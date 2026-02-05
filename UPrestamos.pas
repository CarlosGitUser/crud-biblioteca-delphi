unit UPrestamos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, FireDac.Comp.Client;

type
  TfrmPrestamos = class(TForm)
    StringGrid1: TStringGrid;
    btnAgregar: TButton;
    EditCambios: TEdit;
    EditDevolucion: TEdit;
    btnModificar: TButton;
    btnDevolver: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnAgregarClick(Sender: TObject);
    procedure btnDevolverClick(Sender: TObject);
  private
    { Private declarations }
    procedure ActualizarGrid;
  public
    { Public declarations }
  end;

var
  frmPrestamos: TfrmPrestamos;

implementation

{$R *.dfm}

uses dmData, UMain, UAltaPrestamo;

procedure TfrmPrestamos.ActualizarGrid;
var
  fila: Integer;
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := dbModule.Conexion;

    LQuery.SQL.Text := 'SELECT p.id_prestamo, u.nombre, l.titulo, ' +
                       'p.fecha_salida, p.fecha_devolucion ' +
                       'FROM Prestamo p ' +
                       'INNER JOIN Usuario u ON p.id_usr = u.id_usuario ' +
                       'INNER JOIN Detalle_prestamo dp ON p.id_prestamo = dp.id_prestamo ' +
                       'INNER JOIN Libro l ON dp.id_libro = l.id_libro ' +
                       'ORDER BY p.fecha_devolucion ASC';

    LQuery.Open;

    StringGrid1.RowCount := LQuery.RecordCount + 1;
    if StringGrid1.RowCount < 2 then StringGrid1.RowCount := 2;

    StringGrid1.ColCount := 5;

    // Definir Cabeceras
    StringGrid1.Cells[0, 0] := 'ID Préstamo';
    StringGrid1.Cells[1, 0] := 'Usuario';
    StringGrid1.Cells[2, 0] := 'Libro Prestado';
    StringGrid1.Cells[3, 0] := 'Salida';
    StringGrid1.Cells[4, 0] := 'Devolución';

    StringGrid1.ColWidths[0] := 80;
    StringGrid1.ColWidths[1] := 150;
    StringGrid1.ColWidths[2] := 200;
    StringGrid1.ColWidths[3] := 90;
    StringGrid1.ColWidths[4] := 90;

    fila := 1;
    while not LQuery.Eof do
    begin
      StringGrid1.Cells[0, fila] := LQuery.FieldByName('id_prestamo').AsString;
      StringGrid1.Cells[1, fila] := LQuery.FieldByName('nombre').AsString;
      StringGrid1.Cells[2, fila] := LQuery.FieldByName('titulo').AsString;
      StringGrid1.Cells[3, fila] := LQuery.FieldByName('fecha_salida').AsString;
      StringGrid1.Cells[4, fila] := LQuery.FieldByName('fecha_devolucion').AsString;

      Inc(fila);
      LQuery.Next;
    end;

  finally
    LQuery.Free;
  end;
end;

procedure TfrmPrestamos.btnAgregarClick(Sender: TObject);
begin
     if not Assigned(UAltaPrestamo.frmAltaPrestamo) then
        Application.CreateForm(UAltaPrestamo.TfrmAltaPrestamo, UAltaPrestamo.frmAltaPrestamo);
     try
       if frmAltaPrestamo.ShowModal = mrOk then
        begin
          ActualizarGrid;
        end;
     finally
        FreeAndNil(frmAltaPrestamo);
     end;
end;

procedure TfrmPrestamos.btnDevolverClick(Sender: TObject);
var
  IdPrestamo, IdUsuario: Integer;
  LQuery: TFDQuery;
begin
  if EditDevolucion.Text = '' then
  begin
    ShowMessage('Ingresa el ID del prestamo a devolver');
    Exit;
  end;

  if not TryStrToInt(EditDevolucion.Text, IdPrestamo) or (IdPrestamo <= 0) then
  begin
    ShowMessage('ID invalido.');
    Exit;
  end;

  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := dbModule.Conexion;


    LQuery.SQL.Text := 'SELECT id_usr, fecha_devolucion FROM Prestamo WHERE id_prestamo = :ID';
    LQuery.ParamByName('ID').AsInteger := IdPrestamo;
    LQuery.Open;

    if LQuery.IsEmpty then
    begin
      ShowMessage('El prestamo no existe');
      Exit;
    end;


    if (not LQuery.FieldByName('fecha_devolucion').IsNull) and
       (LQuery.FieldByName('fecha_devolucion').AsString <> '') then
    begin
      ShowMessage('Prestamo ya devuelto');
      Exit;
    end;

    IdUsuario := LQuery.FieldByName('id_usr').AsInteger;
    LQuery.Close;

    dbModule.Conexion.StartTransaction;
    try

      LQuery.SQL.Text := 'UPDATE Prestamo SET fecha_devolucion = :Fecha WHERE id_prestamo = :ID';
      LQuery.ParamByName('Fecha').AsDate := Now;
      LQuery.ParamByName('ID').AsInteger := IdPrestamo;
      LQuery.ExecSQL;

      // Recuperar Stock de Libros
      LQuery.SQL.Text := 'UPDATE Libro SET stock = stock + 1 ' +
                         'WHERE id_libro IN ' +
                         '(SELECT id_libro FROM Detalle_prestamo WHERE id_prestamo = :ID)';
      LQuery.ParamByName('ID').AsInteger := IdPrestamo;
      LQuery.ExecSQL;

      // Liberar al Usuario
      LQuery.SQL.Text := 'UPDATE Usuario SET tiene_prestamo = 0 WHERE id_usuario = :IDUsr';
      LQuery.ParamByName('IDUsr').AsInteger := IdUsuario;
      LQuery.ExecSQL;

      dbModule.Conexion.Commit;
      ShowMessage('Devolucion registrad. Stock actualizado.');
      EditDevolucion.Clear;
      ActualizarGrid;

    except
      on E: Exception do
      begin
        dbModule.Conexion.Rollback;
        ShowMessage('Error en la devolucion: ' + E.Message);
      end;
    end;

  finally
    LQuery.Free;
  end;
end;

procedure TfrmPrestamos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     frmPrestamos.Hide;
     frmMain.Show;
end;

procedure TfrmPrestamos.FormCreate(Sender: TObject);
begin
     ActualizarGrid;
end;

procedure TfrmPrestamos.FormShow(Sender: TObject);
begin
     ActualizarGrid;
end;

end.
