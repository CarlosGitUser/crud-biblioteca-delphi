unit UModificarUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, FireDac.Comp.Client;

type
  TfrmModificarUsuario = class(TForm)
    Panel1: TPanel;
    EditId: TEdit;
    EditNombre: TEdit;
    cbTipo: TComboBox;
    cbPrestamo: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnGuardar: TButton;
    btnSalir: TButton;
    procedure btnSalirClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
  private
    { Private declarations }
    FIdUsuario : Integer;
  public
    { Public declarations }
    property IdUsuario : Integer read FIdUsuario write FIdUsuario;
    function CargarDatos : Boolean;
  end;

var
  frmModificarUsuario: TfrmModificarUsuario;

implementation

{$R *.dfm}

uses dmData;

procedure TfrmModificarUsuario.btnGuardarClick(Sender: TObject);
var
   LQuery : TFDQuery;
   tipo_usuario, tiene_prestamos : Integer;
   nombre : string;
begin

     // Validacion de datos
     if (cbTipo.ItemIndex = -1) or (cbPrestamo.ItemIndex = -1) then
     begin
       ShowMessage('ComboBox no valido');
       Exit;
     end;

     nombre := EditNombre.Text;
     if (nombre.Trim = '') or (nombre.Length < 3) then
     begin
           ShowMessage('Nombre no valido');
           Exit;
     end;

     try
        LQuery := TFDQuery.Create(nil);
        LQuery.Connection := dbModule.Conexion;
        dbModule.Conexion.StartTransaction;
        try
           LQuery.SQL.Text := 'UPDATE Usuario SET nombre = :Nom, tipo_usuario = :Tipo, tiene_prestamo = :Pres WHERE id_usuario = :ID';
           LQuery.ParamByName('Nom').AsString := nombre.Trim;
           LQuery.ParamByName('Tipo').AsInteger := cbTipo.ItemIndex;
           LQuery.ParamByName('Pres').AsInteger := cbPrestamo.ItemIndex;
           LQuery.ParamByName('ID').AsInteger := FIdUsuario;
           LQuery.ExecSQL;
           dbModule.Conexion.Commit;
           ShowMessage('Datos modificados con exito');
           ModalResult := mrOk;
        except
         on E: Exception do
         begin
            dbModule.Conexion.Rollback;
            raise Exception.Create('Error en la modificacion de usuario: ' + E.Message);
         end;
        end;

     finally
        LQuery.Free;
     end;


end;

procedure TfrmModificarUsuario.btnSalirClick(Sender: TObject);
begin
     ModalResult := mrCancel;
end;

function TfrmModificarUsuario.CargarDatos : Boolean;
var
   LQuery : TFDQuery;
begin
     Result := False;
     if FIdUsuario <= 0 then Exit;


     LQuery := TFDQuery.Create(nil);
     try
       LQuery.Connection := dbModule.Conexion;
       LQuery.SQL.Text := 'SELECT * FROM Usuario WHERE id_usuario = :ID';
       LQuery.ParamByName('ID').AsInteger := FIdUsuario;
       LQuery.Open;

       if not LQuery.IsEmpty then
       begin
            EditId.Text := LQuery.FieldByName('id_usuario').AsString;
            EditNombre.Text := LQuery.FieldByName('nombre').AsString;
            cbTipo.ItemIndex := LQuery.FieldByName('tipo_usuario').AsInteger;
            cbPrestamo.ItemIndex := LQuery.FieldByName('tiene_prestamo').AsInteger;
            Result := True;
       end;
     finally
       LQuery.Free;
     end;
     Exit;
end;

end.
