unit dmData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Comp.Client, Data.DB,
  // Excepciones para FireDAC
  FireDAC.Phys.SQLiteWrapper,
  // Dependencia para mostrar mensajes de error
  Vcl.Dialogs, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdbModule = class(TDataModule)
    Conexion: TFDConnection;
    FDTransaction1: TFDTransaction;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    PrestamosQuery: TFDQuery;
    UsuariosQuery: TFDQuery;
    LibrosQuery: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConexionBeforeConnect(Sender: TObject);
    procedure ConexionAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CargarPrestamos;
    procedure CargarUsuarios;
  end;

var
  dbModule: TdbModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdbModule.ConexionAfterConnect(Sender: TObject);
begin
    // Verificar si existe una base de datos, en caso contrario crearla
    Conexion.ExecSQL('CREATE TABLE IF NOT EXISTS Libro(' +
        'id_libro INTEGER PRIMARY KEY AUTOINCREMENT,' +
        'titulo TEXT NOT NULL,' +
        'autor TEXT NOT NULL,' +
        'categoria TEXT NOT NULL,' +
        'stock INTEGER DEFAULT 0)');

    Conexion.ExecSQL('CREATE TABLE IF NOT EXISTS Usuario(' +
      'id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,' +
      'nombre TEXT NOT NULL,' +
      'tipo_usuario INTEGER DEFAULT 0,' + // 0=regular, 1=estudiante
      'tiene_prestamo INTEGER DEFAULT 0)'); // 0=no, 1=si

    Conexion.ExecSQL('CREATE TABLE IF NOT EXISTS Prestamo(' +
      'id_prestamo INTEGER PRIMARY KEY AUTOINCREMENT,' +
      'id_usr INTEGER NOT NULL,' +
      'fecha_salida DATE NOT NULL,' +
      'fecha_devolucion DATE,' +
      'FOREIGN KEY (id_usr) REFERENCES Usuario(id_usuario))');

    Conexion.ExecSQL('CREATE TABLE IF NOT EXISTS Detalle_prestamo(' +
      'id_prestamo INTEGER NOT NULL,' +
      'id_libro INTEGER NOT NULL,' +
      'PRIMARY KEY (id_prestamo, id_libro),' +
      'FOREIGN KEY (id_prestamo) REFERENCES Prestamo(id_prestamo),' +
      'FOREIGN KEY (id_libro) REFERENCES Libro(id_libro))');
end;

procedure TdbModule.ConexionBeforeConnect(Sender: TObject);
var ruta : string;
begin
     ruta := ExtractFilePath(ParamStr(0)) + 'biblioteca.db';
     Conexion.Params.Values['Database'] := ruta;
end;

procedure TdbModule.DataModuleCreate(Sender: TObject);
begin
     try
    Conexion.Connected := True;
  except
    on E: ESQLiteNativeException do
      ShowMessage('Error de SQLite: ' + E.Message);
    on E: Exception do
      ShowMessage('Error General: ' + E.Message);
  end;
end;

procedure TdbModule.CargarPrestamos;
begin
     PrestamosQuery.Close;
     PrestamosQuery.SQL.Text := 'SELECT id_prestamo, id_usr, fecha_salida, fecha_devolucion FROM Prestamo';
     PrestamosQuery.Open;
end;

procedure TdbModule.CargarUsuarios;
begin
  UsuariosQuery.Close;
  UsuariosQuery.SQL.Text := 'SELECT id_usuario, nombre, tipo_usuario, tiene_prestamo FROM Usuario';
  UsuariosQuery.Open;
end;

end.
