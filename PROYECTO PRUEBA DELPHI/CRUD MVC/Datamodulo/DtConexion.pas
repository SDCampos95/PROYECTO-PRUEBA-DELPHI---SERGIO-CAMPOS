unit DtConexion;

// ENLACE DE CONEXI�N SQL SERVER //

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TConexion = class(TDataModule)
    DBConexion: TADOConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Conexion: TConexion;

implementation

{$R *.dfm}

end.
