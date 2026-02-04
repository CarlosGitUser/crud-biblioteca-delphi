unit UAltaLibro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, FireDac.Comp.Client;

type
  TfrmAltaLibro = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EditTitulo: TEdit;
    btnAlta: TButton;
    Label3: TLabel;
    Label4: TLabel;
    EditAutor: TEdit;
    EditCategoria: TEdit;
    EditStock: TEdit;
    procedure btnAltaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAltaLibro: TfrmAltaLibro;

implementation

{$R *.dfm}

uses dmData;

procedure TfrmAltaLibro.btnAltaClick(Sender: TObject);
var
   titulo, autor, categoria : string;
   stock : Integer;
   LQuery : TFDQuery;
begin
     titulo := EditTitulo.Text;
     autor := EditAutor.Text;
     categoria := EditCategoria.Text;

     // Validacion inicial de datos
     if (titulo.Trim = '') or (autor.Trim = '') or (categoria.Trim = '') then
     begin
       ShowMessage('Faltan elementos para la alta');
       Exit;
     end;

     if not TryStrToInt(EditStock.Text, stock) or (stock < 0) then
     begin
       ShowMessage('Numero de Stock invalido');
       Exit;
     end;
     // Datos validados
     dbModule.Conexion.StartTransaction;
     try
        LQuery := TFDQuery.Create(nil);
        LQuery.Connection := dbModule.Conexion;
        try

           LQuery.SQL.Text := 'INSERT INTO Libro (titulo, autor, categoria, stock) ' +
                                              'VALUES (:Tit, :Aut, :Cat, :Sto)';
           LQuery.ParamByName('Tit').AsString := titulo.Trim;
           LQuery.ParamByName('Aut').AsString := autor.Trim;
           LQuery.ParamByName('Cat').AsString := categoria.Trim.ToLower;
           LQuery.ParamByName('Sto').AsInteger := stock;


           LQuery.ExecSQL;

           dbModule.Conexion.Commit;
           ModalResult := mrOk;
           ShowMessage('Alta del libro exitosa');

        except
         on E: Exception do
         begin
              dbModule.Conexion.Rollback;
              raise Exception.Create('Error en la alta del libro: ' + E.Message);
         end;
        end;

     finally
        LQuery.Free;
     end;






end;

end.
