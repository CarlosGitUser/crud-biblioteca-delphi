unit UPrestamos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmPrestamos = class(TForm)
    StringGrid1: TStringGrid;
    btnAgregar: TButton;
    EditBajas: TEdit;
    EditCambios: TEdit;
    btnEliminar: TButton;
    btnModificar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
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

uses dmData, UMain;

procedure TfrmPrestamos.ActualizarGrid;
var fila : Integer;
begin
     dbModule.CargarPrestamos;
     StringGrid1.RowCount := dbModule.PrestamosQuery.RecordCount + 1;
     StringGrid1.ColCount := 6;

     // Configurar las cabeceras
     StringGrid1.Cells[0, 0] := 'ID Prestamo';
     StringGrid1.Cells[1, 0] := 'ID Usuario';
     StringGrid1.Cells[2, 0] := 'Fecha salida';
     StringGrid1.Cells[3, 0] := 'Fecha devolucion';

     StringGrid1.ColWidths[0] := 80;
     StringGrid1.ColWidths[1] := 80;
     StringGrid1.ColWidths[2] := 100;
     StringGrid1.ColWidths[3] := 100;

     dbModule.PrestamosQuery.First;
     fila := 1;
     while not dbModule.PrestamosQuery.Eof do
     begin
          StringGrid1.Cells[0, fila] := dbModule.PrestamosQuery.FieldByName('id_prestamo').AsString;
          StringGrid1.Cells[1, fila] := dbModule.PrestamosQuery.FieldByName('id_usr').AsString;
          StringGrid1.Cells[2, fila] := dbModule.PrestamosQuery.FieldByName('fecha_salida').AsString;
          StringGrid1.Cells[3, fila] := dbModule.PrestamosQuery.FieldByName('fecha_devolucion').AsString;
          // Agregar btnEliminar
          // Agregar btnModificar
          Inc(fila);
          dbModule.PrestamosQuery.Next;
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
