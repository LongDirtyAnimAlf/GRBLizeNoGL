// #############################################################################
// ############################# G-Code Interpreter ############################
// #############################################################################

// #############################################################################
// Werkzeugbewegung in XYZ (3D-Bresenham)
// #############################################################################

procedure bresenham3D(xf0, xf1, yf0, yf1, zf0, zf1: Double; fast_move: Boolean);
// Bresenham-Implementierung in 3D mit der Aufl?sung von 1/int_scale Schritten
// Berechnet Linie von xf0 nach xf1 usw.
var
  x, x0, x1, ix, ax, dx, dx2, sx, xx  :integer;
  y, y0, y1, iy, ay, dy, dy2, sy, yy  :integer;
  z, z0, z1, iz, az, dz, dz2, sz, zz  :integer;
  err_1, err_2, n          :integer;
  cx, cy, cz               :integer;
  int_scale: Double;
  my_delay: Integer;
  show_drawing: boolean;

begin
  my_delay:= 5;
  int_scale:= 1;
  show_drawing:= Form1.ShowDrawing1.Checked;

  x0:= round(xf0*int_scale); x1:= round(xf1*int_scale);
  y0:= round(yf0*int_scale); y1:= round(yf1*int_scale);
  z0:= round(zf0*int_scale); z1:= round(zf1*int_scale);
  xx:= x0; yy:= y0; zz:= z0;
  dx:= x1 - x0;
  dy:= y1 - y0;
  dz:= z1 - z0;
  If (dx < 0) Then
    ix:= -1
  else
    ix:=  1;
  If (dy < 0) Then
    iy:= -1
  else
    iy:=  1;
  If (dz < 0) Then
    iz:= -1
  else
    iz:=  1;

  ax:= abs(dx); ay:= abs(dy); az:= abs(dz);
  dx2:= ax*2; dy2:= ay*2; dz2:= az*2;

  if (ax >= ay) and (ax >= az) then begin
    err_1:= dy2 - ax;
    err_2:= dz2 - ax;
    for n:= 0 to ax-1 do begin
      if (err_1 > 0) then begin
         yy:= yy + iy;
         err_1:= err_1 - dx2;
      end;
      if (err_2 > 0) then begin
         zz:= zz + iz;
         err_2:= err_2 -dx2;
      end;
      err_1:= err_1 + dy2;
      err_2:= err_2 + dz2;
      xx:= xx + ix;
      if show_drawing then
        SetDrawingToolPosMM(xx/int_scale, yy/int_scale, zz/int_scale);
      if (n mod 5 = 0) then begin
        if fast_move then
          mdelay(1)
        else
          mdelay(my_delay);
        NeedsRedraw:= true;
      end;
      if isCancelled then
        break;
    end;
  end else if (ay >= ax) and (ay >= az) then begin
    err_1:= dx2 - ay;
    err_2:= dz2 - ay;
    for n:= 0 to ay-1 do begin
      if (err_1 > 0) then begin
         xx:= xx + ix;
         err_1:= err_1 - dy2;
      end;
      if (err_2 > 0) then begin
         zz:= zz + iz;
         err_2:= err_2 - dy2;
      end;
      err_1:= err_1 + dx2;
      err_2:= err_2 + dz2;
      yy:= yy + iy;
      if show_drawing then
        SetDrawingToolPosMM(xx/int_scale, yy/int_scale, zz/int_scale);
      if (n mod 5 = 0) then begin
        if fast_move then
          mdelay(1)
        else
          mdelay(my_delay);
        NeedsRedraw:= true;
      end;
      if isCancelled then
        break;
    end;
  end else if (az >= ax) and (az >= ay) then begin
    err_1:= dy2 - az;
    err_2:= dx2 - az;
    for n:= 0 to az-1 do begin
      if (err_1 > 0) then begin
         yy:= yy + iy;
         err_1:= err_1 - dz2;
      end;
      if (err_2 > 0) then begin
         xx:= xx + ix;
         err_2:= err_2 - dz2;
      end;
      err_1:= err_1 + dy2;
      err_2:= err_2 + dx2;
      zz:= zz + iz;
      if show_drawing then
        SetDrawingToolPosMM(xx/int_scale, yy/int_scale, zz/int_scale);
      if (n mod 5 = 0) then begin
        if fast_move then
          mdelay(1)
        else
          mdelay(my_delay);
        NeedsRedraw:= true;
      end;
      if isCancelled then
        break;
    end;
  end;
end;

// #############################################################################
// G-Code-interpreter
// #############################################################################

procedure InterpretGcodeLine(my_str: string);
// interpretiert einen GRBL-Befehl und stellt ihn in 3D-Simulation dar
// beherrscht nur rudiment?re Funktionenm reicht aber f?r 90% der Daten
// gcsim_x, gcsim_y, gcsim_z: Double;
// gcsim_x_old, gcsim_y_old, gcsim_z_old: Double;
// gcsim_offs_x, gcsim_offs_y, gcsim_offs_z: Double;
// definier in main
var
  idx: Integer;
  x,y,z: Double;
  is_absolute: Boolean;
  is_offset: Boolean;
begin
  if (my_str[1] = '/') or (my_str[1] = '(') then // andere Kommentare
    exit;
  if pos('G43', my_str) > 0 then // TLC cancel
    exit;
  if pos('G49', my_str) > 0 then // TLC cancel
    exit;
  if pos('G38', my_str) > 0 then // straight probe
    exit;
  if pos('G4 P', my_str) > 0 then // dwell
    mdelay(500);
  if (pos('G90', my_str) > 0) then is_relative:=false;     // G90
  if (pos('G91', my_str) > 0) then is_relative:=true;     // G91
  is_offset:= (pos('G92', my_str) > 0);     // G92
  if pos('G1', my_str) > 0 then
    gcsim_seek:= false
  else if pos('G0', my_str) > 0 then
    gcsim_seek:= true;
//  if pos('G38.2', my_str) > 0 then
//    exit;
  is_absolute:= (pos('G53', my_str) > 0);
  idx:= pos('X', my_str);
  if idx > 0 then begin
    inc(idx);
    x:= extract_float(my_str, idx, true); // GCode-Dezimaltrenner
    if is_relative then
      grbl_wpos.x:=gcsim_x_old+x
    else
    if is_offset then begin
      grbl_wpos.x:= x;
    end else if is_absolute then
      grbl_wpos.x:= x - WorkZero.X
    else
      grbl_wpos.x:= x;
  end;
  idx:= pos('Y', my_str);
  if idx > 0 then begin
    inc(idx);
    y:= extract_float(my_str, idx, true); // GCode-Dezimaltrenner
    if is_relative then
      grbl_wpos.y:=gcsim_y_old+y
    else
    if is_offset then begin
      grbl_wpos.y:= y;
    end else if is_absolute then
      grbl_wpos.y:= y - WorkZero.Y
    else
      grbl_wpos.y:= y;
  end;
  idx:= pos('Z', my_str);
  if idx > 0 then begin
    inc(idx);
    z:= extract_float(my_str, idx, true); // GCode-Dezimaltrenner
    if is_relative then
      grbl_wpos.z:=gcsim_z_old+z
    else
    if is_offset then begin
      grbl_wpos.z:= z;
    end else if is_absolute then
      grbl_wpos.z:= z - WorkZero.Z
    else
      grbl_wpos.z:= z;
  end;
  idx:= pos('F', my_str);
  if idx > 0 then begin
    inc(idx);
    gcsim_feed:= extract_int(my_str, idx);
  end;
  if not is_offset then
    bresenham3D(gcsim_x_old, grbl_wpos.x, gcsim_y_old, grbl_wpos.y,
      gcsim_z_old, grbl_wpos.z, gcsim_seek);
  gcsim_x_old:= grbl_wpos.x;
  gcsim_y_old:= grbl_wpos.y;
  gcsim_z_old:= grbl_wpos.z;
  grbl_mpos.x:= grbl_wpos.x + WorkZero.X;
  grbl_mpos.y:= grbl_wpos.y + WorkZero.y;
  grbl_mpos.z:= grbl_wpos.z + WorkZero.Z;
end;


