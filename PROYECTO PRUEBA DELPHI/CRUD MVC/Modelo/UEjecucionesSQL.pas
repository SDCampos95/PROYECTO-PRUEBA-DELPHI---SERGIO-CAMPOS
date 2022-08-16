unit UEjecucionesSQL;

interface

uses
  SysUtils, Classes, DtConexion, DB, DBTables, ADODB;

type
  TDtmoduloSQL = class(TDataModule)
    QryClientes: TQuery;
    QryGestionClientes: TADOQuery;
//    procedure Ingresar_informacion;


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DtmoduloSQL: TDtmoduloSQL;

implementation

procedure Ingresar_informacion();
begin
   //
end;






{$R *.dfm}

end.
