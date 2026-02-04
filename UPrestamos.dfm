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
    Left = 112
    Top = 192
    Width = 393
    Height = 145
    ColCount = 6
    TabOrder = 0
  end
  object btnAgregar: TButton
    Left = 430
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Agregar'
    TabOrder = 1
  end
end
