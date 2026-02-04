unit UAltaUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, FireDac.Comp.Client;

type
  TfrmAltaUsuario = class(TForm)
    Panel1: TPanel;
    EditNombre: TEdit;
    Label1: TLabel;
    cbUsuario: TComboBox;
    Label2: TLabel;
    btnAlta: TButton;
    procedure btnAltaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAltaUsuario: TfrmAltaUsuario;

implementation

{$R *.dfm}

uses dmData;

procedure TfrmAltaUsuario.btnAltaClick(Sender: TObject);
var
   nombre : string;
   LQuery : TFDQuery;
begin
     // Validacion de datos
     if cbUsuario.ItemIndex = -1 then
     begin
       ShowMessage('Debe seleccionar el tipo de usuario');
       Exit;
     end;

     nombre := EditNombre.Text;
     if (nombre.Trim = '') or (nombre.Length < 3) then
     begin
           ShowMessage('Nombre no valido');
           Exit;
     end;

     // Datos validados
     dbModule.Conexion.StartTransaction;
     try
        LQuery := TFDQuery.Create(nil);
        LQuery.Connection := dbModule.Conexion;
        try

           LQuery.SQL.Text := 'INSERT INTO Usuario (nombre, tipo_usuario) ' +
                                              'VALUES (:Nom, :Tipo)';
           LQuery.ParamByName('Nom').AsString := nombre;
           LQuery.ParamByName('Tipo').AsInteger := cbUsuario.ItemIndex;


           LQuery.ExecSQL;

           dbModule.Conexion.Commit;
           ModalResult := mrOk;
           ShowMessage('Alta de usuario exitosa');

        except
         on E: Exception do
         begin
              dbModule.Conexion.Rollback;
              raise Exception.Create('Error en la alta de usuario: ' + E.Message);
         end;
        end;

     finally
        LQuery.Free;
     end;

end;

end.
