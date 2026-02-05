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
    EditBajas: TEdit;
    btnEliminar: TButton;
    btnModificar: TButton;
    btnDevolver: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnAgregarClick(Sender: TObject);
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
