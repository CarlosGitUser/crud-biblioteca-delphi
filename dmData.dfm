object dbModule: TdbModule
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object Conexion: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    AfterConnect = ConexionAfterConnect
    BeforeConnect = ConexionBeforeConnect
    Left = 72
    Top = 80
  end
  object FDTransaction1: TFDTransaction
    Connection = Conexion
    Left = 224
    Top = 80
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 520
    Top = 88
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 368
    Top = 88
  end
  object PrestamosQuery: TFDQuery
    Connection = Conexion
    Left = 72
    Top = 320
  end
  object UsuariosQuery: TFDQuery
    Connection = Conexion
    Left = 216
    Top = 320
  end
  object LibrosQuery: TFDQuery
    Connection = Conexion
    Left = 368
    Top = 312
  end
end
