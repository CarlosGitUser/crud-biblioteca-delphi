unit ULibros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmLibros = class(TForm)
    StringGrid1: TStringGrid;
    EditBajas: TEdit;
    EditCambios: TEdit;
    btnEliminar: TButton;
    btnModificar: TButton;
    btnAgregar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

uses UMain;

procedure TfrmLibros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     frmLibros.Hide;
     frmMain.Show;
end;

procedure TfrmLibros.ActualizarGrid;
begin

end;

end.
