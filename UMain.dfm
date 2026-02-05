object frmMain: TfrmMain
  Left = 735
  Top = 332
  Caption = 'frmMain'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 633
    Height = 441
    TabOrder = 0
    object Label1: TLabel
      Left = 136
      Top = 56
      Width = 388
      Height = 40
      Caption = 'Sistema CRUD para biblioteca'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object btnPrestamos: TButton
      Left = 264
      Top = 144
      Width = 113
      Height = 41
      Caption = 'Prestamos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnPrestamosClick
    end
    object btnUsuarios: TButton
      Left = 264
      Top = 218
      Width = 113
      Height = 36
      Caption = 'Usuarios'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnUsuariosClick
    end
    object btnLibros: TButton
      Left = 264
      Top = 296
      Width = 113
      Height = 33
      Caption = 'Libros'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnLibrosClick
    end
  end
end
