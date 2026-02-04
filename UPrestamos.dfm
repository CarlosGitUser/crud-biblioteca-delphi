object frmPrestamos: TfrmPrestamos
  Left = 0
  Top = 0
  Caption = 'frmPrestamos'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object StringGrid1: TStringGrid
    Left = 8
    Top = 192
    Width = 608
    Height = 145
    ColCount = 6
    TabOrder = 0
    ColWidths = (
      64
      65
      64
      64
      64
      64)
  end
  object btnAgregar: TButton
    Left = 398
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Agregar'
    TabOrder = 1
  end
  object EditBajas: TEdit
    Left = 8
    Top = 128
    Width = 73
    Height = 23
    TabOrder = 2
    TextHint = 'ID'
  end
  object EditCambios: TEdit
    Left = 8
    Top = 88
    Width = 73
    Height = 23
    TabOrder = 3
    TextHint = 'ID'
  end
  object btnEliminar: TButton
    Left = 104
    Top = 87
    Width = 75
    Height = 25
    Caption = 'Eliminar'
    TabOrder = 4
  end
  object btnModificar: TButton
    Left = 104
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Modificar'
    TabOrder = 5
  end
end
