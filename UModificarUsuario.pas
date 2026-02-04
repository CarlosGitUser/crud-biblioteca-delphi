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
    cbPermiso: TComboBox;
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
    procedure CargarDatos;
  end;

var
  frmModificarUsuario: TfrmModificarUsuario;

implementation

{$R *.dfm}

uses dmData;

procedure TfrmModificarUsuario.btnGuardarClick(Sender: TObject);
var
   LQuery : TFDQuery;
begin



end;

procedure TfrmModificarUsuario.btnSalirClick(Sender: TObject);
begin
     ModalResult := mrCancel;
     Exit;
end;

procedure TfrmModificarUsuario.CargarDatos;
var
   LQuery : TFDQuery;
begin

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
            cbPermiso.ItemIndex := LQuery.FieldByName('tiene_prestamo').AsInteger;
       end
       else
       begin
         ShowMessage('Usuario no encontrado');
         ModalResult := mrCancel;
         Exit;
       end;

     finally
       LQuery.Free;
     end;
end;

end.
