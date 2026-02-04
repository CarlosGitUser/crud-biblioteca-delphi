unit ULibros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmLibros = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
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
     frmLibros.Close;
     frmMain.Show;
end;

end.
