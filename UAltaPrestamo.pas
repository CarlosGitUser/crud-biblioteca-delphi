unit UAltaPrestamo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, FireDAC.Comp.Client, System.DateUtils;

type
  TfrmAltaPrestamo = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    cbUsuarios: TComboBox;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label3: TLabel;
    cbLibros: TComboBox;
    btnAgregarLibro: TButton;
    btnAlta: TButton;
    StringGrid1: TStringGrid;
    Label4: TLabel;
    btnEliminarLibro: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAgregarLibroClick(Sender: TObject);
    procedure btnEliminarLibroClick(Sender: TObject);
    procedure btnAltaClick(Sender: TObject);
  private
    { Private declarations }
    procedure CargarCombos;
    procedure ConfigurarGrid;
    procedure EliminarFilaGrid(Grid: TStringGrid; FilaIndex: Integer);
  public
    { Public declarations }
  end;

var
  frmAltaPrestamo: TfrmAltaPrestamo;

implementation

{$R *.dfm}

uses dmData;

procedure TfrmAltaPrestamo.ConfigurarGrid;
begin
  StringGrid1.ColCount := 2;
  StringGrid1.RowCount := 2;
  StringGrid1.FixedRows := 1;


  StringGrid1.Cols[0].Text := 'ID';
  StringGrid1.ColWidths[0] := 0;

  StringGrid1.Cols[1].Text := 'Título del Libro';
  StringGrid1.ColWidths[1] := 250;

  DateTimePicker1.MinDate := Date;
end;

procedure TfrmAltaPrestamo.btnAgregarLibroClick(Sender: TObject);
var
  idLibro: Integer;
  tituloLibro: string;
  i: Integer;
begin
  // Validar selección
  if cbLibros.ItemIndex = -1 then
  begin
    ShowMessage('Selecciona un libro primero.');
    Exit;
  end;

  // Recuperar datos del Combo
  tituloLibro := cbLibros.Items[cbLibros.ItemIndex];
  idLibro := Integer(cbLibros.Items.Objects[cbLibros.ItemIndex]);

  // Validar duplicados en el Grid
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    if StringGrid1.Cells[0, i] = IntToStr(idLibro) then
    begin
      ShowMessage('Este libro ya esta en la lista');
      Exit;
    end;
  end;

  StringGrid1.RowCount := StringGrid1.RowCount + 1;
  StringGrid1.Cells[0, StringGrid1.RowCount - 1] := IntToStr(idLibro);
  StringGrid1.Cells[1, StringGrid1.RowCount - 1] := tituloLibro;
end;

procedure TfrmAltaPrestamo.btnAltaClick(Sender: TObject);
var
  LQuery: TFDQuery;
  IdUsuario, TipoUsuario, TienePrestamoActivo: Integer;
  LimiteLibros, DiasPrestamo: Integer;
  CantidadLibrosSeleccionados: Integer;
  FechaLimiteEstimada: TDateTime;
  NuevoIdPrestamo, i, IdLibroGrid: Integer;
begin
  // Validaciones
  if cbUsuarios.ItemIndex = -1 then
  begin
    ShowMessage('Se debe seleccionar un usuario');
    Exit;
  end;

  CantidadLibrosSeleccionados := StringGrid1.RowCount - 1;
  if CantidadLibrosSeleccionados <= 0 then
  begin
    ShowMessage('Se debe agregar al menos un libro a la lista');
    Exit;
  end;

  IdUsuario := Integer(cbUsuarios.Items.Objects[cbUsuarios.ItemIndex]);

  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := dbModule.Conexion;

    // Obtener datos del usuario
    LQuery.SQL.Text := 'SELECT tipo_usuario, tiene_prestamo FROM Usuario WHERE id_usuario = :ID';
    LQuery.ParamByName('ID').AsInteger := IdUsuario;
    LQuery.Open;

    if LQuery.IsEmpty then
    begin
      ShowMessage('Usuario no encontrado');
      Exit;
    end;

    TipoUsuario := LQuery.FieldByName('tipo_usuario').AsInteger;
    TienePrestamoActivo := LQuery.FieldByName('tiene_prestamo').AsInteger;
    LQuery.Close;

    // Si el usuario ya tiene prestamo se niega este
    if TienePrestamoActivo = 1 then
    begin
      ShowMessage('Este usuario ya tiene un prestamo activo sin devolver');
      Exit;
    end;

    if TipoUsuario = 0 then
    begin // REGULAR
      LimiteLibros := 5;
      DiasPrestamo := 5;
    end
    else
    begin // ESTUDIANTE
      LimiteLibros := 10;
      DiasPrestamo := 10;
    end;

    if CantidadLibrosSeleccionados > LimiteLibros then
    begin
      ShowMessage('Limite excedido para el tipo de usuario. Maximo permitido: ' + IntToStr(LimiteLibros));
      Exit;
    end;

    FechaLimiteEstimada := DateTimePicker1.Date + DiasPrestamo;

    dbModule.Conexion.StartTransaction;
    try
      LQuery.SQL.Text := 'INSERT INTO Prestamo (id_usr, fecha_salida) ' +
                         'VALUES (:IdUsr, :FechaSal)';

      LQuery.ParamByName('IdUsr').AsInteger := IdUsuario;
      LQuery.ParamByName('FechaSal').AsDate := DateTimePicker1.Date;

      LQuery.ExecSQL;

      // Obtener id del prestamo recién creado
      LQuery.SQL.Text := 'SELECT last_insert_rowid()';
      LQuery.Open;
      NuevoIdPrestamo := LQuery.Fields[0].AsInteger;
      LQuery.Close;

      // Insertar Detalles_prestamo y bajar el stock
      for i := 1 to StringGrid1.RowCount - 1 do
      begin
        IdLibroGrid := StrToInt(StringGrid1.Cells[0, i]);

        // Insertar Detalle
        LQuery.SQL.Text := 'INSERT INTO Detalle_prestamo (id_prestamo, id_libro) ' +
                           'VALUES (:IdPres, :IdLib)';
        LQuery.ParamByName('IdPres').AsInteger := NuevoIdPrestamo;
        LQuery.ParamByName('IdLib').AsInteger := IdLibroGrid;
        LQuery.ExecSQL;

        // Bajar Stock
        LQuery.SQL.Text := 'UPDATE Libro SET stock = stock - 1 WHERE id_libro = :IdLib';
        LQuery.ParamByName('IdLib').AsInteger := IdLibroGrid;
        LQuery.ExecSQL;
      end;

      // Actualizar estado del usuario
      LQuery.SQL.Text := 'UPDATE Usuario SET tiene_prestamo = 1 WHERE id_usuario = :ID';
      LQuery.ParamByName('ID').AsInteger := IdUsuario;
      LQuery.ExecSQL;

      dbModule.Conexion.Commit;

      // Mostrar fecha limite
      ShowMessage('Prestamo registrado exitosamente.' + sLineBreak +
                  'El usuario debe devolver los libros antes del: ' + DateToStr(FechaLimiteEstimada));

      ModalResult := mrOk;

    except
      on E: Exception do
      begin
        dbModule.Conexion.Rollback;
        ShowMessage('Error al guardar: ' + E.Message);
      end;
    end;

  finally
    LQuery.Free;
  end;
end;

procedure TfrmAltaPrestamo.btnEliminarLibroClick(Sender: TObject);
begin
  if (StringGrid1.Row > 0) and (StringGrid1.Row < StringGrid1.RowCount) then
  begin
    EliminarFilaGrid(StringGrid1, StringGrid1.Row);
  end
  else
  begin
    ShowMessage('Selecciona un libro de la lista para eliminar');
  end;
end;

procedure TfrmAltaPrestamo.EliminarFilaGrid(Grid: TStringGrid; FilaIndex: Integer);
var
  i: Integer;
begin
  if (FilaIndex > 0) and (FilaIndex < Grid.RowCount) then
  begin
    // Si es la ultima fila, solo restar el contador
    if FilaIndex = Grid.RowCount - 1 then
      Grid.RowCount := Grid.RowCount - 1
    else
    begin
      for i := FilaIndex to Grid.RowCount - 2 do
        Grid.Rows[i] := Grid.Rows[i + 1];
      Grid.RowCount := Grid.RowCount - 1;
    end;
  end;
end;

procedure TfrmAltaPrestamo.CargarCombos;
var
  LQuery: TFDQuery;
begin
  cbUsuarios.Clear;
  cbLibros.Clear;

  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := dbModule.Conexion;

    LQuery.SQL.Text := 'SELECT id_usuario, nombre FROM Usuario ORDER BY nombre';
    LQuery.Open;
    while not LQuery.Eof do
    begin
      cbUsuarios.Items.AddObject(
        LQuery.FieldByName('nombre').AsString,
        TObject(LQuery.FieldByName('id_usuario').AsInteger)
      );
      LQuery.Next;
    end;

    LQuery.Close;
    LQuery.SQL.Text := 'SELECT id_libro, titulo FROM Libro WHERE stock > 0 ORDER BY titulo';
    LQuery.Open;
    while not LQuery.Eof do
    begin
      cbLibros.Items.AddObject(
        LQuery.FieldByName('titulo').AsString,
        TObject(LQuery.FieldByName('id_libro').AsInteger)
      );
      LQuery.Next;
    end;

  finally
    LQuery.Free;
  end;
end;

procedure TfrmAltaPrestamo.FormCreate(Sender: TObject);
begin
     ConfigurarGrid;
end;

procedure TfrmAltaPrestamo.FormShow(Sender: TObject);
begin
  CargarCombos;
  StringGrid1.RowCount := 1;
  DateTimePicker1.Date := Now;
end;

end.
