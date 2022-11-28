program GRBLize;





uses
  Forms,
  {$ifdef FPC}
  Interfaces,
  {$endif}
  ABOUT in 'ABOUT.PAS' {AboutBox},
  grbl_com in 'grbl_com.pas',
  blinklist in 'ftdiclass\blinklist.pas',
  bsearchtree in 'ftdiclass\bsearchtree.pas',
  FTDIchip in 'ftdiclass\FTDIchip.pas',
  FTDIdll in 'ftdiclass\FTDIdll.pas',
  FTDIthread in 'ftdiclass\FTDIthread.pas',
  FTDItypes in 'ftdiclass\FTDItypes.pas',
  deviceselect in 'deviceselect.pas' {deviceselectbox},
  clipper in 'clipper.pas',
  drawing_window in 'drawing_window.pas' {Form2},
  DirectShow9 in 'DirectX\DirectShow9.pas',
  DirectSound in 'DirectX\DirectSound.pas',
  DXTypes in 'DirectX\DXTypes.pas',
  Direct3D9 in 'DirectX\Direct3D9.pas',
  grbl_player_main in 'grbl_player_main.pas' {Form1},
  gerber_import in 'gerber_import.pas' {FormGerber},
  import_files in 'import_files.pas',
  app_Defaults in 'app_Defaults.pas',
  {$ifndef FPC}
  cam_view in 'cam_view.pas' {Form3},
  VFrames in 'VFrames.pas',
  {$endif}
  DirectDraw in 'DirectX\DirectDraw.pas', SynEditStrConstExtra;

{$R *.res}

begin
  {$ifdef FPC}
  Application.Scaled:=True;
  {$endif}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TFormGerber, FormGerber);
  Application.Run;
  Application.Terminate;
end.
