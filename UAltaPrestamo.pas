unit UAltaPrestamo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmAltaPrestamo = class(TForm)
    Panel1: TPanel;
    EditNombre: TEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    btnAlta: TButton;
    procedure btnAltaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAltaPrestamo: TfrmAltaPrestamo;

implementation

{$R *.dfm}

procedure TfrmAltaPrestamo.btnAltaClick(Sender: TObject);
var
   nombre : string;
begin
     nombre := EditNombre.Text;
     if nombre.Trim = '' then
     begin
           ShowMessage('El nombre no puede estar vacio');
           Exit;
     end;


end;

end.
