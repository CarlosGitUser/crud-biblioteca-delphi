unit ULibros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmLibros = class(TForm)
    StringGrid1: TStringGrid;
    EditCambios: TEdit;
    EditBajas: TEdit;
    btnEliminar: TButton;
    btnModificar: TButton;
    btnAgregar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAgregarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
  private
    { Private declarations }
    procedure ActualizarGrid;
  public
    { Public declarations }
  end;

var
  frmLibros: TfrmLibros;

implementation

{$R *.dfm}

uses UMain, dmData, UAltaLibro, UModificarLibros;

procedure TfrmLibros.btnAgregarClick(Sender: TObject);
begin
     if not Assigned(UAltaLibro.frmAltaLibro) then
        Application.CreateForm(UAltaLibro.TfrmAltaLibro, UAltaLibro.frmAltaLibro);
     try
        if frmAltaLibro.ShowModal = mrOk then
        begin
          ActualizarGrid;
        end;

     finally
            FreeAndNil(frmAltaLibro);
     end;

end;

procedure TfrmLibros.btnModificarClick(Sender: TObject);
var
   idLibro : Integer;
begin
     if EditCambios.Text = '' then
     begin
       ShowMessage('Se debe ingresar un ID');
       Exit;
     end;

     if not TryStrToInt(EditCambios.Text, idLibro) or (idLibro < 0) then
     begin
       ShowMessage('ID no valido');
       Exit;
     end;

     if not Assigned(UModificarLibros.frmModificarLibros) then
       Application.CreateForm(UModificarLibros.TfrmModificarLibros, UModificarLibros.frmModificarLibros);

     try
        frmModificarLibros.IdLibro := idLibro;

        if frmModificarLibros.CargarDatos then
        begin
             // Si existe el usuario
             if frmModificarLibros.ShowModal = mrOk then
             begin
                ActualizarGrid;
             end;
        end
        else
        begin
             ShowMessage('El usuario con ID ' + IntToStr(idLibro) + ' no existe.');
        end;

        finally
          FreeAndNil(frmModificarLibros);
     end;

end;

procedure TfrmLibros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     frmLibros.Hide;
     frmMain.Show;
end;

procedure TfrmLibros.FormCreate(Sender: TObject);
begin
     ActualizarGrid;
end;

procedure TfrmLibros.FormShow(Sender: TObject);
begin
     ActualizarGrid;
end;

procedure TfrmLibros.ActualizarGrid;
var fila : Integer;
begin
     dbModule.CargarLibros;

     StringGrid1.ColCount := 5;
     StringGrid1.RowCount := dbModule.LibrosQuery.RecordCount + 1;

     // Cabeceras de la tabla
     StringGrid1.Cells[0, 0] := 'ID';
     StringGrid1.Cells[1, 0] := 'Tiutlo';
     StringGrid1.Cells[2, 0] := 'Autor';
     StringGrid1.Cells[3, 0] := 'Categoria';
     StringGrid1.Cells[4, 0] := 'Stock';

     StringGrid1.ColWidths[0] := 60;
     StringGrid1.ColWidths[1] := 180;
     StringGrid1.ColWidths[2] := 140;
     StringGrid1.ColWidths[3] := 100;
     StringGrid1.ColWidths[4] := 70;

     dbModule.LibrosQuery.First;
     fila := 1;
     while not dbModule.LibrosQuery.Eof do
     begin
       StringGrid1.Cells[0, fila] := dbModule.LibrosQuery.FieldByName('id_libro').AsString;
       StringGrid1.Cells[1, fila] := dbModule.LibrosQuery.FieldByName('titulo').AsString;
       StringGrid1.Cells[2, fila] := dbModule.LibrosQuery.FieldByName('autor').AsString;
       StringGrid1.Cells[3, fila] := dbModule.LibrosQuery.FieldByName('categoria').AsString;
       StringGrid1.Cells[4, fila] := dbModule.LibrosQuery.FieldByName('stock').AsString;

       Inc(fila);
       dbModule.LibrosQuery.Next;
     end;
end;

end.
