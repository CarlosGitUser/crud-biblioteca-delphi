unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    btnPrestamos: TButton;
    btnUsuarios: TButton;
    btnLibros: TButton;
    Label1: TLabel;
    procedure btnPrestamosClick(Sender: TObject);
    procedure btnUsuariosClick(Sender: TObject);
    procedure btnLibrosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses  ULibros, UPrestamos, UUsuarios;

procedure TfrmMain.btnLibrosClick(Sender: TObject);
begin
     if not Assigned(ULibros.frmLibros) then
        Application.CreateForm(ULibros.TfrmLibros, ULibros.frmLibros);
     frmMain.Hide;
     frmLibros.ShowModal;
end;

procedure TfrmMain.btnPrestamosClick(Sender: TObject);
begin
     if not Assigned(UPrestamos.frmPrestamos) then
        Application.CreateForm(UPrestamos.TfrmPrestamos, UPrestamos.frmPrestamos);
     frmMain.Hide;
     frmPrestamos.ShowModal;
end;

procedure TfrmMain.btnUsuariosClick(Sender: TObject);
begin
     if not Assigned(UUsuarios.frmUsuarios) then
        Application.CreateForm(UUsuarios.TfrmUsuarios, UUsuarios.frmUsuarios);
     frmMain.Hide;
     frmUsuarios.ShowModal;
end;

end.
