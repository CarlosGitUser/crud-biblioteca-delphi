object frmAltaLibro: TfrmAltaLibro
  Left = 0
  Top = 0
  Caption = 'frmAltaLibro'
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
    Left = 104
    Top = 86
    Width = 433
    Height = 257
    TabOrder = 0
    object Label1: TLabel
      Left = 48
      Top = 51
      Width = 34
      Height = 15
      Caption = 'Titulo:'
    end
    object Label2: TLabel
      Left = 48
      Top = 91
      Width = 33
      Height = 15
      Caption = 'Autor:'
    end
    object Label3: TLabel
      Left = 53
      Top = 185
      Width = 29
      Height = 15
      Caption = 'Stock'
    end
    object Label4: TLabel
      Left = 48
      Top = 136
      Width = 51
      Height = 15
      Caption = 'Categoria'
    end
    object EditTitulo: TEdit
      Left = 184
      Top = 48
      Width = 121
      Height = 23
      TabOrder = 0
      TextHint = 'Titulo'
    end
    object btnAlta: TButton
      Left = 336
      Top = 216
      Width = 75
      Height = 25
      Caption = 'Alta'
      TabOrder = 1
      OnClick = btnAltaClick
    end
    object EditAutor: TEdit
      Left = 184
      Top = 88
      Width = 121
      Height = 23
      TabOrder = 2
      TextHint = 'Autor'
    end
    object EditCategoria: TEdit
      Left = 184
      Top = 133
      Width = 121
      Height = 23
      TabOrder = 3
      TextHint = 'Categoria'
    end
    object EditStock: TEdit
      Left = 184
      Top = 184
      Width = 121
      Height = 23
      TabOrder = 4
      TextHint = 'Stock'
    end
  end
end
