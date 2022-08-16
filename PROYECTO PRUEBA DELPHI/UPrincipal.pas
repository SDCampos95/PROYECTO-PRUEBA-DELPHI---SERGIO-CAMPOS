unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls;

type
  TFrmPrincipal = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Ejercicio11: TMenuItem;
    Ejercicio21: TMenuItem;
    SerieFibonacci1: TMenuItem;
    SalariosSemanales1: TMenuItem;
    Ejercicio31: TMenuItem;
    Clientes1: TMenuItem;
    Image1: TImage;
    procedure SerieFibonacci1Click(Sender: TObject);
    procedure SalariosSemanales1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses UEjercicio1, UCalcularsalariosemanal, UCrudClientes;

{$R *.dfm}

procedure TFrmPrincipal.SerieFibonacci1Click(Sender: TObject);
begin
  // ABRIR FORMULARIO - EJERCICIO 1 SERIE FIBONACCI //
  FrmSerieFibonacci := TFrmSerieFibonacci.CREATE(APPLICATION);
    try
      FrmSerieFibonacci.SHOW;
    except
      FrmSerieFibonacci.FREE;
    end;
end;

procedure TFrmPrincipal.SalariosSemanales1Click(Sender: TObject);
begin
  // ABRIR FORMULARIO - EJERCICIO 2 CALCULO DE SALARIO SEMANALA//
  FrmCalcularSalarioSemanal := TFrmCalcularSalarioSemanal.CREATE(APPLICATION);
  try
    FrmCalcularSalarioSemanal.SHOW;
  except
    FrmCalcularSalarioSemanal.FREE;
  end;
end;

procedure TFrmPrincipal.Clientes1Click(Sender: TObject);
begin
  // FORMULARIO CRUD REGISTRO DE CLIENTES //
  FrmCrudClientes := TFrmCrudClientes.CREATE(APPLICATION);
  try
    FrmCrudClientes.SHOW;
  except
    FrmCrudClientes.FREE;
  end;
end;

end.
