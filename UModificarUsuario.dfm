object frmModificarUsuario: TfrmModificarUsuario
  Left = 0
  Top = 0
  Caption = 'frmModificarUsuario'
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
    Left = 24
    Top = 144
    Width = 577
    Height = 233
    TabOrder = 0
    object Label1: TLabel
      Left = 200
      Top = 35
      Width = 53
      Height = 15
      Caption = 'ID usuario'
    end
    object Label2: TLabel
      Left = 202
      Top = 77
      Width = 50
      Height = 15
      Caption = 'Nombre: '
    end
    object Label3: TLabel
      Left = 200
      Top = 123
      Width = 85
      Height = 15
      Caption = 'Tipo de usuario:'
    end
    object Label4: TLabel
      Left = 202
      Top = 171
      Width = 90
      Height = 15
      Caption = 'Tiene prestamos:'
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
    object EditNombre: TEdit
      Left = 320
      Top = 77
      Width = 121
      Height = 23
      TabOrder = 1
      TextHint = 'Nombre'
    end
    object cbTipo: TComboBox
      Left = 320
      Top = 120
      Width = 145
      Height = 23
      TabOrder = 2
      TextHint = 'Tipo usuario'
      Items.Strings = (
        'Regular'
        'Alumno')
    end
    object cbPermiso: TComboBox
      Left = 320
      Top = 168
      Width = 145
      Height = 23
      TabOrder = 3
      TextHint = 'Tiene prestamos'
      Items.Strings = (
        'No'
        'Si')
    end
    object btnGuardar: TButton
      Left = 488
      Top = 192
      Width = 75
      Height = 25
      Caption = 'Guardar'
      TabOrder = 4
      OnClick = btnGuardarClick
    end
    object btnSalir: TButton
      Left = 16
      Top = 192
      Width = 75
      Height = 25
      Caption = 'Salir'
      TabOrder = 5
      OnClick = btnSalirClick
    end
  end
end
