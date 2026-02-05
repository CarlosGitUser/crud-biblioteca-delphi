object frmModificarLibros: TfrmModificarLibros
  Left = 735
  Top = 353
  Caption = 'frmModificarLibros'
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
    Left = 24
    Top = 80
    Width = 577
    Height = 297
    TabOrder = 0
    object Label1: TLabel
      Left = 200
      Top = 35
      Width = 38
      Height = 15
      Caption = 'ID libro'
    end
    object Label2: TLabel
      Left = 202
      Top = 77
      Width = 34
      Height = 15
      Caption = 'Titulo:'
    end
    object Label3: TLabel
      Left = 200
      Top = 123
      Width = 33
      Height = 15
      Caption = 'Autor:'
    end
    object Label4: TLabel
      Left = 200
      Top = 168
      Width = 54
      Height = 15
      Caption = 'Categoria:'
    end
    object Label5: TLabel
      Left = 202
      Top = 216
      Width = 29
      Height = 15
      Caption = 'Stock'
    end
    object EditId: TEdit
      Left = 320
      Top = 32
      Width = 121
      Height = 23
      ReadOnly = True
      TabOrder = 0
      TextHint = 'ID'
    end
    object EditTitulo: TEdit
      Left = 320
      Top = 77
      Width = 121
      Height = 23
      TabOrder = 1
      TextHint = 'Titulo'
    end
    object btnGuardar: TButton
      Left = 488
      Top = 256
      Width = 75
      Height = 25
      Caption = 'Guardar'
      TabOrder = 2
      OnClick = btnGuardarClick
    end
    object btnSalir: TButton
      Left = 16
      Top = 256
      Width = 75
      Height = 25
      Caption = 'Salir'
      TabOrder = 3
      OnClick = btnSalirClick
    end
    object EditAutor: TEdit
      Left = 320
      Top = 125
      Width = 121
      Height = 23
      TabOrder = 4
      TextHint = 'Autor'
    end
    object EditCategoria: TEdit
      Left = 320
      Top = 165
      Width = 121
      Height = 23
      TabOrder = 5
      TextHint = 'Categoria'
    end
    object EditStock: TEdit
      Left = 320
      Top = 216
      Width = 121
      Height = 23
      TabOrder = 6
      TextHint = 'Stock'
    end
  end
end
