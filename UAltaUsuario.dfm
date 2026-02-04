object frmAltaUsuario: TfrmAltaUsuario
  Left = 0
  Top = 0
  Caption = 'frmAltaUsuario'
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
      Width = 111
      Height = 15
      Caption = 'Nombre del usuario: '
    end
    object Label2: TLabel
      Left = 48
      Top = 91
      Width = 85
      Height = 15
      Caption = 'Tipo de usuario:'
    end
    object EditNombre: TEdit
      Left = 216
      Top = 48
      Width = 121
      Height = 23
      TabOrder = 0
      TextHint = 'Nombre'
    end
    object cbUsuario: TComboBox
      Left = 216
      Top = 88
      Width = 121
      Height = 23
      Style = csDropDownList
      TabOrder = 1
      TextHint = 'Tipo de usuario'
      Items.Strings = (
        'Regular'
        'Estudiante')
    end
    object btnAlta: TButton
      Left = 320
      Top = 200
      Width = 75
      Height = 25
      Caption = 'Alta'
      TabOrder = 2
      OnClick = btnAltaClick
    end
  end
end
