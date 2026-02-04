program Project1;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {frmMain},
  dmData in 'dmData.pas' {dbModule: TDataModule},
  UPrestamos in 'UPrestamos.pas' {frmPrestamos},
  UUsuarios in 'UUsuarios.pas' {frmUsuarios},
  ULibros in 'ULibros.pas' {frmLibros};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdbModule, dbModule);
  Application.CreateForm(TfrmPrestamos, frmPrestamos);
  Application.CreateForm(TfrmUsuarios, frmUsuarios);
  Application.CreateForm(TfrmLibros, frmLibros);
  Application.Run;
end.
