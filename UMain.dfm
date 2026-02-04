object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 8
    Top = 96
    Width = 601
    Height = 337
    TabOrder = 0
    object btnPrestamos: TButton
      Left = 272
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Prestamos'
      TabOrder = 0
      OnClick = btnPrestamosClick
    end
    object btnUsuarios: TButton
      Left = 272
      Top = 168
      Width = 75
      Height = 25
      Caption = 'Usuarios'
      TabOrder = 1
      OnClick = btnUsuariosClick
    end
    object btnLibros: TButton
      Left = 272
      Top = 208
      Width = 75
      Height = 25
      Caption = 'Libros'
      TabOrder = 2
      OnClick = btnLibrosClick
    end
  end
end
