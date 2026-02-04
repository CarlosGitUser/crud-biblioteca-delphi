unit UUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls;

type
  TfrmUsuarios = class(TForm)
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
    procedure btnEliminarClick(Sender: TObject);

  private
    { Private declarations }
    ID_usuario : Integer;
    procedure ActualizarGrid;
  public
    { Public declarations }
    function getIdUsuario : Integer;
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation

{$R *.dfm}

uses UMain, dmData, UAltaUsuario, UModificarUsuario;

function TfrmUsuarios.getIdUsuario: Integer;
begin

end;

procedure TfrmUsuarios.btnAgregarClick(Sender: TObject);
begin
     if not Assigned(UAltaUsuario.frmAltaUsuario) then
        Application.CreateForm(UAltaUsuario.TfrmAltaUsuario, UAltaUsuario.frmAltaUsuario);
     try
        if frmAltaUsuario.ShowModal = mrOk then
        begin
          ActualizarGrid;
        end;

     finally
            FreeAndNil(frmAltaUsuario);
     end;

end;

procedure TfrmUsuarios.btnEliminarClick(Sender: TObject);
var
   idUsuario : Integer;
begin
     if EditBajas.Text = '' then
     begin
       ShowMessage('Se debe ingresar un ID');
       Exit;
     end;

     if not TryStrToInt(EditBajas.Text, idUsuario) or (idUsuario < 0) then
     begin
       ShowMessage('ID no valido');
       Exit;
     end;


end;

procedure TfrmUsuarios.btnModificarClick(Sender: TObject);
var
   idUsuario : Integer;
begin
     if EditCambios.Text = '' then
     begin
       ShowMessage('Se debe ingresar un ID');
       Exit;
     end;

     if not TryStrToInt(EditCambios.Text, idUsuario) or (idUsuario < 0) then
     begin
       ShowMessage('ID no valido');
       Exit;
     end;

     if not Assigned(UModificarUsuario.frmModificarUsuario) then
       Application.CreateForm(UModificarUsuario.TfrmModificarUsuario, UModificarUsuario.frmModificarUsuario);
     try
       frmModificarUsuario.IdUsuario := idUsuario;
       frmModificarUsuario.CargarDatos;
       if frmModificarUsuario.ShowModal = mrOk then
       begin
         ActualizarGrid;
       end;
     finally
       FreeAndNil(frmModificarUsuario);
     end;

end;

procedure TfrmUsuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     frmUsuarios.Hide;
     frmMain.Show;
end;

procedure TfrmUsuarios.FormCreate(Sender: TObject);
begin
     ActualizarGrid;
end;

procedure TfrmUsuarios.FormShow(Sender: TObject);
begin
     ActualizarGrid;
end;

procedure TfrmUsuarios.ActualizarGrid;
var fila, tiene_prestamo, tipo_usuario: Integer;
begin
     dbModule.CargarUsuarios;

     StringGrid1.ColCount := 4;
     StringGrid1.RowCount := dbModule.UsuariosQuery.RecordCount + 1;

     // Cabeceras de la tabla
     StringGrid1.Cells[0, 0] := 'ID';
     StringGrid1.Cells[1, 0] := 'Nombre';
     StringGrid1.Cells[2, 0] := 'Tipo usuario';
     StringGrid1.Cells[3, 0] := 'Tiene prestamo';

     StringGrid1.ColWidths[0] := 50;
     StringGrid1.ColWidths[1] := 180;
     StringGrid1.ColWidths[2] := 80;
     StringGrid1.ColWidths[3] := 110;

     dbModule.UsuariosQuery.First;
     fila := 1;
     while not dbModule.UsuariosQuery.Eof do
     begin
       StringGrid1.Cells[0, fila] := dbModule.UsuariosQuery.FieldByName('id_usuario').AsString;
       StringGrid1.Cells[1, fila] := dbModule.UsuariosQuery.FieldByName('nombre').AsString;

       tipo_usuario := dbModule.UsuariosQuery.FieldByName('tipo_usuario').AsInteger;
       if tipo_usuario = 0 then
          StringGrid1.Cells[2, fila] := 'Regular'
       else StringGrid1.Cells[2, fila] := 'Estudiante';

       tiene_prestamo := dbModule.UsuariosQuery.FieldByName('tiene_prestamo').AsInteger;
       if tiene_prestamo = 1 then
          StringGrid1.Cells[3, fila] := 'Si'
       else StringGrid1.Cells[3, fila] := 'No';

       Inc(fila);
       dbModule.UsuariosQuery.Next;
     end;
end;

end.
