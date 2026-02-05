program Project1;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {frmMain},
  dmData in 'dmData.pas' {dbModule: TDataModule},
  UPrestamos in 'UPrestamos.pas' {frmPrestamos},
  UUsuarios in 'UUsuarios.pas' {frmUsuarios},
  ULibros in 'ULibros.pas' {frmLibros},
  UAltaUsuario in 'UAltaUsuario.pas' {frmAltaUsuario},
  UAltaLibro in 'UAltaLibro.pas' {frmAltaLibro},
  UModificarUsuario in 'UModificarUsuario.pas' {frmModificarUsuario},
  UModificarLibros in 'UModificarLibros.pas' {frmModificarLibros},
  UAltaPrestamo in 'UAltaPrestamo.pas' {frmAltaPrestamo},
  UModificarPrestamos in 'UModificarPrestamos.pas' {frmModificarPrestamo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdbModule, dbModule);
  Application.CreateForm(TfrmPrestamos, frmPrestamos);
  Application.CreateForm(TfrmUsuarios, frmUsuarios);
  Application.CreateForm(TfrmLibros, frmLibros);
  Application.CreateForm(TfrmAltaUsuario, frmAltaUsuario);
  Application.CreateForm(TfrmAltaLibro, frmAltaLibro);
  Application.CreateForm(TfrmModificarUsuario, frmModificarUsuario);
  Application.CreateForm(TfrmModificarLibros, frmModificarLibros);
  Application.CreateForm(TfrmAltaPrestamo, frmAltaPrestamo);
  Application.CreateForm(TfrmModificarPrestamo, frmModificarPrestamo);
  Application.Run;
end.
