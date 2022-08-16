program PruebaDelphi;

uses
  Forms,
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  UEjercicio1 in 'UEjercicio1.pas' {FrmSerieFibonacci},
  UCalcularsalariosemanal in 'UCalcularsalariosemanal.pas' {FrmCalcularSalarioSemanal},
  UCrudClientes in 'CRUD MVC\View\UCrudClientes.pas' {FrmCrudClientes},
  DtConexion in 'CRUD MVC\Datamodulo\DtConexion.pas' {Conexion: TDataModule},
  UControladorDatos in 'CRUD MVC\Control\UControladorDatos.pas',
  UModeloDatos in 'CRUD MVC\Modelo\UModeloDatos.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmSerieFibonacci, FrmSerieFibonacci);
  Application.CreateForm(TFrmCalcularSalarioSemanal, FrmCalcularSalarioSemanal);
  Application.CreateForm(TFrmCrudClientes, FrmCrudClientes);
  Application.CreateForm(TConexion, Conexion);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
