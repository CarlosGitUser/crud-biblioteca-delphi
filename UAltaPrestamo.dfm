object frmAltaPrestamo: TfrmAltaPrestamo
  Left = 735
  Top = 332
  Caption = 'frmAltaPrestamo'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 8
    Top = 88
    Width = 608
    Height = 305
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 48
      Width = 43
      Height = 15
      Caption = 'Usuario:'
    end
    object Label2: TLabel
      Left = 24
      Top = 145
      Width = 30
      Height = 15
      Caption = 'Libro:'
    end
    object Label3: TLabel
      Left = 24
      Top = 96
      Width = 106
      Height = 15
      Caption = 'Fecha del prestamo:'
    end
    object Label4: TLabel
      Left = 409
      Top = 16
      Width = 109
      Height = 15
      Caption = 'Libros seleccionados'
    end
    object cbUsuarios: TComboBox
      Left = 152
      Top = 45
      Width = 209
      Height = 23
      Style = csDropDownList
      TabOrder = 0
      TextHint = 'Lista de usuarios'
    end
    object DateTimePicker1: TDateTimePicker
      Left = 152
      Top = 96
      Width = 209
      Height = 25
      Date = 46057.000000000000000000
      Time = 46057.000000000000000000
      Color = clGrayText
      DateFormat = dfLong
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object cbLibros: TComboBox
      Left = 152
      Top = 142
      Width = 209
      Height = 23
      Style = csDropDownList
      TabOrder = 2
      TextHint = 'Lista de libros'
    end
    object btnAgregarLibro: TButton
      Left = 286
      Top = 184
      Width = 75
      Height = 25
      Caption = 'Agregar libro'
      TabOrder = 3
      OnClick = btnAgregarLibroClick
    end
    object btnAlta: TButton
      Left = 488
      Top = 256
      Width = 75
      Height = 25
      Caption = 'Alta'
      TabOrder = 4
      OnClick = btnAltaClick
    end
    object StringGrid1: TStringGrid
      Left = 409
      Top = 48
      Width = 154
      Height = 120
      ColCount = 2
      RowCount = 2
      TabOrder = 5
    end
    object btnEliminarLibro: TButton
      Left = 152
      Top = 184
      Width = 75
      Height = 25
      Caption = 'Eliminar libro'
      TabOrder = 6
      OnClick = btnEliminarLibroClick
    end
  end
end
