object frmUsuarios: TfrmUsuarios
  Left = 735
  Top = 332
  Caption = 'frmUsuarios'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object StringGrid1: TStringGrid
    Left = 31
    Top = 166
    Width = 570
    Height = 259
    Align = alCustom
    ColCount = 4
    TabOrder = 0
  end
  object EditCambios: TEdit
    Left = 31
    Top = 104
    Width = 73
    Height = 23
    TabOrder = 1
    TextHint = 'ID'
  end
  object EditBajas: TEdit
    Left = 31
    Top = 56
    Width = 73
    Height = 23
    TabOrder = 2
    TextHint = 'ID'
  end
  object btnEliminar: TButton
    Left = 152
    Top = 55
    Width = 75
    Height = 25
    Caption = 'Eliminar'
    TabOrder = 3
    OnClick = btnEliminarClick
  end
  object btnModificar: TButton
    Left = 152
    Top = 103
    Width = 75
    Height = 25
    Caption = 'Modificar'
    TabOrder = 4
    OnClick = btnModificarClick
  end
  object btnAgregar: TButton
    Left = 374
    Top = 103
    Width = 75
    Height = 25
    Caption = 'Agregar'
    TabOrder = 5
    OnClick = btnAgregarClick
  end
end
