object Form2: TForm2
  Cursor = crCross
  Left = 65
  Height = 524
  Top = 160
  Width = 840
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Drawing'
  Color = clBtnFace
  Constraints.MaxHeight = 800
  Constraints.MaxWidth = 1200
  Constraints.MinHeight = 240
  Constraints.MinWidth = 320
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseWheel = FormMouseWheel
  OnPaint = FormPaint
  OnResize = FormResize
  object DrawingBox: TPaintBox
    Left = 0
    Height = 526
    Hint = 'Milling View - Drag with left-click or modify with right-click'
    Top = 8
    Width = 841
    Anchors = [akTop, akLeft, akRight, akBottom]
    Color = clCream
    DragCursor = crSizeAll
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    OnMouseDown = DrawingBoxMouseDown
    OnMouseMove = DrawingBoxMouseMove
    OnMouseUp = DrawingBoxMouseUp
  end
  object Panel1: TPanel
    Left = 8
    Height = 177
    Top = 8
    Width = 132
    Align = alCustom
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Height = 13
      Top = 160
      Width = 78
      Caption = 'Grid/Ruler in mm'
    end
    object BtnZoomReset: TButton
      Left = 16
      Height = 24
      Top = 129
      Width = 97
      HelpType = htKeyword
      HelpKeyword = 'Reset zoom and pan'
      Caption = 'Zoom Reset'
      Font.CharSet = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      OnClick = BtnZoomResetClick
      ParentFont = False
      TabOrder = 0
      TabStop = False
    end
    object TrackBarZoom: TTrackBar
      Left = 0
      Height = 20
      Hint = 'View zoom - disabled when camera ON'
      Top = 88
      Width = 129
      Max = 50
      Min = 1
      OnChange = TrackBarZoomChange
      PageSize = 1
      Position = 4
      TabStop = False
      TickStyle = tsNone
      TabOrder = 1
    end
    object CheckBoxDimensions: TCheckBox
      Left = 8
      Height = 17
      Top = 8
      Width = 100
      Caption = 'Show Dimensions'
      OnClick = CheckBoxDimensionsClick
      TabOrder = 2
    end
    object CheckBoxDirections: TCheckBox
      Left = 8
      Height = 17
      Top = 32
      Width = 94
      Caption = 'Show Directions'
      OnClick = CheckBoxDirectionsClick
      TabOrder = 3
    end
    object StaticText2: TStaticText
      Left = 8
      Height = 17
      Top = 108
      Width = 10
      Caption = '1'
      TabOrder = 4
    end
    object StaticText3: TStaticText
      Left = 112
      Height = 17
      Top = 108
      Width = 16
      Caption = '50'
      TabOrder = 5
    end
    object CheckBoxToolpath: TCheckBox
      Left = 8
      Height = 17
      Top = 56
      Width = 92
      Caption = 'Show Tool Path'
      Checked = True
      OnClick = CheckBoxDirectionsClick
      State = cbChecked
      TabOrder = 6
    end
  end
  object PopupMenuObject: TPopupMenu
    Left = 1120
    Top = 8
    object pu_ObjectEnabled: TMenuItem
      Caption = 'Object Enabled'
      Checked = True
      OnClick = pu_ObjectenabledClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object pu_online: TMenuItem
      AutoCheck = True
      Caption = 'Contour'
      GroupIndex = 1
      OnClick = pu_radioClick
    end
    object pu_inside: TMenuItem
      Tag = 1
      AutoCheck = True
      Caption = 'Inside'
      GroupIndex = 1
      OnClick = pu_radioClick
    end
    object pu_outside: TMenuItem
      Tag = 2
      AutoCheck = True
      Caption = 'Outside'
      GroupIndex = 1
      OnClick = pu_radioClick
    end
    object pu_pocket: TMenuItem
      Tag = 3
      AutoCheck = True
      Caption = 'Pocket'
      GroupIndex = 1
      OnClick = pu_radioClick
    end
    object Drill1: TMenuItem
      Caption = 'Drill'
      GroupIndex = 2
      RadioItem = True
      OnClick = pu_radioClick
    end
    object N2: TMenuItem
      Caption = '-'
      GroupIndex = 2
      RadioItem = True
    end
    object pu_isatCenter1: TMenuItem
      Caption = 'Tool is above Object Center'
      GroupIndex = 2
      RadioItem = True
      OnClick = pu_toolIsAtCenterClick
    end
    object pu_camIsAtCenter: TMenuItem
      Caption = 'Cam is above Object Center'
      GroupIndex = 2
      RadioItem = True
      OnClick = pu_camIsAtCenterClick
    end
    object N3: TMenuItem
      Caption = '-'
      GroupIndex = 2
    end
    object pu_moveCenter1: TMenuItem
      Caption = 'Move Tool to Object Center'
      GroupIndex = 2
      OnClick = pu_moveToolToCenterClick
    end
    object pu_moveCamToCenter: TMenuItem
      Caption = 'Move Cam to Object Center'
      GroupIndex = 2
      OnClick = pu_moveCamToCenterClick
    end
  end
  object PopupMenuPart: TPopupMenu
    AutoPopup = False
    Left = 168
    Top = 16
    object pu_isAtZero2: TMenuItem
      Caption = 'Tool is above Part Zero'
      GroupIndex = 3
      RadioItem = True
      OnClick = pu_toolisAtPartZeroClick
    end
    object pu_camIsAtZero2: TMenuItem
      Caption = 'Cam is above Part Zero'
      GroupIndex = 3
      RadioItem = True
      OnClick = pu_camIsAtPartZeroClick
    end
    object N5: TMenuItem
      Caption = '-'
      GroupIndex = 3
      RadioItem = True
    end
    object pu_moveZero2: TMenuItem
      Caption = 'Move Tool to Part Zero'
      GroupIndex = 3
      RadioItem = True
      OnClick = pu_moveToolToPartZeroClick
    end
    object pu_moveCamToZero2: TMenuItem
      Caption = 'Move Cam to Part Zero'
      GroupIndex = 3
      RadioItem = True
      OnClick = pu_moveCamToPartZeroClick
    end
  end
  object PopupMenuPoint: TPopupMenu
    AutoPopup = False
    Left = 1120
    Top = 8
    object pu_PointEnabled: TMenuItem
      Caption = 'Path Enabled'
      Checked = True
      OnClick = pu_PathEnabledClick
    end
    object MenuItem2: TMenuItem
      Caption = '-'
    end
    object MenuItem3: TMenuItem
      AutoCheck = True
      Caption = 'Contour'
      GroupIndex = 1
      OnClick = pu_radioClick
    end
    object MenuItem4: TMenuItem
      Tag = 1
      AutoCheck = True
      Caption = 'Inside'
      GroupIndex = 1
      OnClick = pu_radioClick
    end
    object MenuItem5: TMenuItem
      Tag = 2
      AutoCheck = True
      Caption = 'Outside'
      GroupIndex = 1
      OnClick = pu_radioClick
    end
    object MenuItem6: TMenuItem
      Tag = 3
      AutoCheck = True
      Caption = 'Pocket'
      GroupIndex = 1
      OnClick = pu_radioClick
    end
    object MenuItem7: TMenuItem
      Caption = 'Drill'
      GroupIndex = 2
      RadioItem = True
      OnClick = pu_radioClick
    end
    object MenuItem8: TMenuItem
      Caption = '-'
      GroupIndex = 2
      RadioItem = True
    end
    object MenuItem10: TMenuItem
      Caption = 'Tool is above Point'
      GroupIndex = 2
      RadioItem = True
      OnClick = pu_toolisatpointClick
    end
    object MenuItem18: TMenuItem
      Caption = 'Cam is above Point'
      GroupIndex = 2
      RadioItem = True
      OnClick = pu_camIsAtPointClick
    end
    object MenuItem12: TMenuItem
      Caption = '-'
      GroupIndex = 2
    end
    object pu_MoveToPoint: TMenuItem
      Caption = 'Move Tool to Point'
      GroupIndex = 2
      OnClick = pu_moveToolToPointClick
    end
    object pu_MoveCamToPoint: TMenuItem
      Caption = 'Move Cam to Point'
      GroupIndex = 2
      OnClick = pu_moveCamToPointClick
    end
  end
end
