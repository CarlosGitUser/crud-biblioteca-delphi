unit UModificarPrestamos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.Client, System.DateUtils,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmModificarPrestamo = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbUsuarios: TComboBox;
    DateTimePicker1: TDateTimePicker;
    cbLibros: TComboBox;
    btnAgregarLibro: TButton;
    btnGuardar: TButton;
    StringGrid1: TStringGrid;
    btnEliminarLibro: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnAgregarLibroClick(Sender: TObject);
    procedure btnEliminarLibroClick(Sender: TObject);
  private
    { Private declarations }
    FIdPrestamo: Integer;
    procedure CargarCombos;
    procedure ConfigurarGrid;
    procedure EliminarFilaGrid(Grid: TStringGrid; FilaIndex: Integer);
  public
    { Public declarations }
    property IdPrestamo: Integer read FIdPrestamo write FIdPrestamo;
    function CargarDatos: Boolean;
  end;

var
  frmModificarPrestamo: TfrmModificarPrestamo;

implementation

{$R *.dfm}

uses dmData;

procedure TfrmModificarPrestamo.FormCreate(Sender: TObject);
begin
     ConfigurarGrid;
end;



procedure TfrmModificarPrestamo.FormShow(Sender: TObject);
begin
     CargarCombos;
end;

procedure TfrmModificarPrestamo.ConfigurarGrid;
begin
  StringGrid1.ColCount := 2;
  StringGrid1.RowCount := 2;
  StringGrid1.FixedRows := 1;
  StringGrid1.Cols[0].Text := 'ID';
  StringGrid1.ColWidths[0] := 0;
  StringGrid1.Cols[1].Text := 'Título del Libro';
  StringGrid1.ColWidths[1] := 250;
end;

procedure TfrmModificarPrestamo.btnAgregarLibroClick(Sender: TObject);
var i, idLibro: Integer; titulo: string;
begin
  if cbLibros.ItemIndex = -1 then Exit;
  idLibro := Integer(cbLibros.Items.Objects[cbLibros.ItemIndex]);
  titulo := cbLibros.Items[cbLibros.ItemIndex];

  for i := 1 to StringGrid1.RowCount - 1 do
    if StringGrid1.Cells[0, i] = IntToStr(idLibro) then begin ShowMessage('Libro ya en lista'); Exit; end;

  StringGrid1.RowCount := StringGrid1.RowCount + 1;
  StringGrid1.Cells[0, StringGrid1.RowCount - 1] := IntToStr(idLibro);
  StringGrid1.Cells[1, StringGrid1.RowCount - 1] := titulo;
end;

procedure TfrmModificarPrestamo.btnEliminarLibroClick(Sender: TObject);
begin
  if (StringGrid1.Row > 0) and (StringGrid1.Row < StringGrid1.RowCount) then
    EliminarFilaGrid(StringGrid1, StringGrid1.Row);
end;

procedure TfrmModificarPrestamo.btnGuardarClick(Sender: TObject);
var
  LQuery: TFDQuery;
  i, IdLibroGrid, IdUsuario: Integer;
begin
  // Validaciones
  if StringGrid1.RowCount <= 1 then
  begin
    ShowMessage('El prestamo debe tener al menos un libro');
    Exit;
  end;

  IdUsuario := Integer(cbUsuarios.Items.Objects[cbUsuarios.ItemIndex]);

  dbModule.Conexion.StartTransaction;
  LQuery := TFDQuery.Create(nil);
  try
    try
      LQuery.Connection := dbModule.Conexion;

      // Revertir el stock
      LQuery.SQL.Text := 'UPDATE Libro SET stock = stock + 1 WHERE id_libro IN ' +
                         '(SELECT id_libro FROM Detalle_prestamo WHERE id_prestamo = :ID)';
      LQuery.ParamByName('ID').AsInteger := FIdPrestamo;
      LQuery.ExecSQL;

      // Elimininar registro asociado a Detalle_prestamo
      LQuery.SQL.Text := 'DELETE FROM Detalle_prestamo WHERE id_prestamo = :ID';
      LQuery.ParamByName('ID').AsInteger := FIdPrestamo;
      LQuery.ExecSQL;

      // Update del prestamo
      LQuery.SQL.Text := 'UPDATE Prestamo SET id_usr = :Usr, fecha_salida = :Fecha WHERE id_prestamo = :ID';
      LQuery.ParamByName('Usr').AsInteger := IdUsuario;
      LQuery.ParamByName('Fecha').AsDate := DateTimePicker1.Date;
      LQuery.ParamByName('ID').AsInteger := FIdPrestamo;
      LQuery.ExecSQL;

      // Crear Detalles_prestamo
      for i := 1 to StringGrid1.RowCount - 1 do
      begin
        IdLibroGrid := StrToInt(StringGrid1.Cells[0, i]);

        LQuery.SQL.Text := 'INSERT INTO Detalle_prestamo (id_prestamo, id_libro) VALUES (:IdP, :IdL)';
        LQuery.ParamByName('IdP').AsInteger := FIdPrestamo;
        LQuery.ParamByName('IdL').AsInteger := IdLibroGrid;
        LQuery.ExecSQL;

        // Descontar Stock
        LQuery.SQL.Text := 'UPDATE Libro SET stock = stock - 1 WHERE id_libro = :IdL';
        LQuery.ParamByName('IdL').AsInteger := IdLibroGrid;
        LQuery.ExecSQL;
      end;

      dbModule.Conexion.Commit;
      ShowMessage('Prestamo modificado correctamente');
      ModalResult := mrOk;

    except
      on E: Exception do
      begin
        dbModule.Conexion.Rollback;
        ShowMessage('Error al modificar: ' + E.Message);
      end;
    end;
  finally
    LQuery.Free;
  end;
end;

procedure TfrmModificarPrestamo.CargarCombos;
var
  LQuery: TFDQuery;
begin
  cbUsuarios.Clear;
  cbLibros.Clear;
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := dbModule.Conexion;
    // Usuarios
    LQuery.SQL.Text := 'SELECT id_usuario, nombre FROM Usuario ORDER BY nombre';
    LQuery.Open;
    while not LQuery.Eof do begin
      cbUsuarios.Items.AddObject(LQuery.FieldByName('nombre').AsString, TObject(LQuery.FieldByName('id_usuario').AsInteger));
      LQuery.Next;
    end;
    LQuery.Close;
    LQuery.SQL.Text := 'SELECT id_libro, titulo FROM Libro WHERE stock > 0 ORDER BY titulo';
    LQuery.Open;
    while not LQuery.Eof do begin
      cbLibros.Items.AddObject(LQuery.FieldByName('titulo').AsString, TObject(LQuery.FieldByName('id_libro').AsInteger));
      LQuery.Next;
    end;
  finally
    LQuery.Free;
  end;
end;

function TfrmModificarPrestamo.CargarDatos: Boolean;
var
  LQuery: TFDQuery;
  i: Integer;
begin
  Result := False;
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := dbModule.Conexion;

    // Cargar Cabecera
    LQuery.SQL.Text := 'SELECT id_usr, fecha_salida, fecha_devolucion FROM Prestamo WHERE id_prestamo = :ID';
    LQuery.ParamByName('ID').AsInteger := FIdPrestamo;
    LQuery.Open;

    if LQuery.IsEmpty then Exit;

    // Validar que no esté devuelto
    if not LQuery.FieldByName('fecha_devolucion').IsNull and (LQuery.FieldByName('fecha_devolucion').AsString <> '') then
    begin
      ShowMessage('No se puede modificar un prestamo que ya ha sido devuelto');
      Exit;
    end;

    DateTimePicker1.Date := LQuery.FieldByName('fecha_salida').AsDateTime;

    // Seleccionar el usuario en el ComboBox
    for i := 0 to cbUsuarios.Items.Count - 1 do
    begin
      if Integer(cbUsuarios.Items.Objects[i]) = LQuery.FieldByName('id_usr').AsInteger then
      begin
        cbUsuarios.ItemIndex := i;
        Break;
      end;
    end;
    LQuery.Close;

    // Cargar Detalles_prestamo
    LQuery.SQL.Text := 'SELECT dp.id_libro, l.titulo FROM Detalle_prestamo dp ' +
                       'INNER JOIN Libro l ON dp.id_libro = l.id_libro ' +
                       'WHERE dp.id_prestamo = :ID';
    LQuery.ParamByName('ID').AsInteger := FIdPrestamo;
    LQuery.Open;

    StringGrid1.RowCount := 1;
    while not LQuery.Eof do
    begin
      StringGrid1.RowCount := StringGrid1.RowCount + 1;
      StringGrid1.Cells[0, StringGrid1.RowCount - 1] := LQuery.FieldByName('id_libro').AsString;
      StringGrid1.Cells[1, StringGrid1.RowCount - 1] := LQuery.FieldByName('titulo').AsString;
      LQuery.Next;
    end;

    Result := True;
  finally
    LQuery.Free;
  end;
end;

procedure TfrmModificarPrestamo.EliminarFilaGrid(Grid: TStringGrid; FilaIndex: Integer);
var i: Integer;
begin
  if FilaIndex = Grid.RowCount - 1 then Grid.RowCount := Grid.RowCount - 1
  else begin
    for i := FilaIndex to Grid.RowCount - 2 do Grid.Rows[i] := Grid.Rows[i + 1];
    Grid.RowCount := Grid.RowCount - 1;
  end;
end;


end.
