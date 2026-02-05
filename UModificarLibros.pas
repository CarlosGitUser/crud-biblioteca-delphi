unit UModificarLibros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, FireDac.Comp.Client;

type
  TfrmModificarLibros = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditId: TEdit;
    EditTitulo: TEdit;
    btnGuardar: TButton;
    btnSalir: TButton;
    EditAutor: TEdit;
    EditCategoria: TEdit;
    Label5: TLabel;
    EditStock: TEdit;
    procedure btnSalirClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);

  private
    { Private declarations }
    FIdLibro : Integer;
  public
    { Public declarations }
    property IdLibro : Integer read FIdLibro write FIdLibro;
    function CargarDatos : Boolean;
  end;

var
  frmModificarLibros: TfrmModificarLibros;

implementation

{$R *.dfm}

uses dmData;

procedure TfrmModificarLibros.btnGuardarClick(Sender: TObject);
var
   LQuery : TFDQuery;
   stockNuevo, prestamosActuales : Integer;
   titulo, autor, categoria : string;
begin

     titulo := EditTitulo.Text;
     autor := EditAutor.Text;
     categoria := EditCategoria.Text;

     // Validacion inicial de datos
     if (titulo.Trim = '') or (autor.Trim = '') or (categoria.Trim = '') then
     begin
       ShowMessage('Elemenentos vacios');
       Exit;
     end;
     // Para el stock validar que no se coloque menos stock del que hay en libros prestados
     if not TryStrToInt(EditStock.Text, stockNuevo) or (stockNuevo < 0) then
     begin
       ShowMessage('Numero de Stock invalido');
       Exit;
     end;
     LQuery := TFDQuery.Create(nil);
     try
        // Validacion de stock con libros prestados
        LQuery.Connection := dbModule.Conexion;
        LQuery.SQL.Text := 'SELECT COUNT(*) FROM Detalle_prestamo dp ' +
                           'INNER JOIN Prestamo p ON dp.id_prestamo = p.id_prestamo ' +
                           'WHERE dp.id_libro = :ID ' +
                           'AND p.fecha_devolucion IS NULL';
        LQuery.ParamByName('ID').AsInteger := FIdLibro;
        LQuery.Open;
        prestamosActuales := LQuery.Fields[0].AsInteger;
        LQuery.Close;
        if stockNuevo < prestamosActuales then
        begin
             ShowMessage('No se puede reducir el stock a ' + IntToStr(StockNuevo) +
                         '. Actualmente hay ' + IntToStr(prestamosActuales) +
                         ' libros prestados y no devueltos.');
             Exit;
        end;
        dbModule.Conexion.StartTransaction;
        try
           LQuery.SQL.Text := 'UPDATE Libro SET titulo = :Tit, autor = :Aut, stock = :Stock, categoria = :Cate ' +
            'WHERE id_libro = :ID';
           LQuery.ParamByName('Tit').AsString := titulo.Trim;
           LQuery.ParamByName('Aut').AsString := autor.Trim;
           LQuery.ParamByName('Stock').AsInteger := stockNuevo;
           LQuery.ParamByName('Cate').AsString := categoria.Trim.ToLower;
           LQuery.ParamByName('ID').AsInteger := FIdLibro;
           LQuery.ExecSQL;
           dbModule.Conexion.Commit;
           ShowMessage('Datos modificados con exito');
           ModalResult := mrOk;
        except
         on E: Exception do
         begin
            dbModule.Conexion.Rollback;
            raise Exception.Create('Error en la modificacion de libro: ' + E.Message);
         end;
        end;

     finally
        LQuery.Free;
     end;

end;

procedure TfrmModificarLibros.btnSalirClick(Sender: TObject);
begin
     ModalResult := mrCancel;
end;

function TfrmModificarLibros.CargarDatos: Boolean;
var
   LQuery : TFDQuery;
begin
     Result := False;
     if FIdLibro <= 0 then Exit;


     LQuery := TFDQuery.Create(nil);
     try
       LQuery.Connection := dbModule.Conexion;
       LQuery.SQL.Text := 'SELECT * FROM Libro WHERE id_libro = :ID';
       LQuery.ParamByName('ID').AsInteger := FIdLibro;
       LQuery.Open;

       if not LQuery.IsEmpty then
       begin
            EditId.Text := LQuery.FieldByName('id_libro').AsString;
            EditTitulo.Text := LQuery.FieldByName('titulo').AsString;
            EditAutor.Text := LQuery.FieldByName('autor').AsString;
            EditCategoria.Text := LQuery.FieldByName('categoria').AsString;
            EditStock.Text := LQuery.FieldByName('stock').AsString;
            Result := True;
       end;
     finally
       LQuery.Free;
     end;
     Exit;
end;


end.
