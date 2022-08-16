unit UCalcularsalariosemanal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmCalcularSalarioSemanal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCalcularSalarioSemanal: TFrmCalcularSalarioSemanal;

implementation

{$R *.dfm}

procedure TFrmCalcularSalarioSemanal.BitBtn1Click(Sender: TObject);
var
  salario_normal, salario_extras, Valor_salario_calculado : Integer;
begin

  salario_normal := 15000;
  salario_extras := 19000;

  if (Trim(Edit1.Text) <> '') and (Edit2.Text > '0') then
  begin

    if (Edit2.Text <= '35') then
    begin
      Valor_salario_calculado := (salario_normal * (StrToInt(Edit2.Text)) );

      Memo1.Text := 'Al Empleado '+Edit1.Text+' se le debe pagar la suma de $ '+IntToStr(Valor_salario_calculado)+' pesos.';
    end
    else
    begin
      Valor_salario_calculado := (salario_extras * (StrToInt(Edit2.Text)) );

      Memo1.Text := 'Al Empleado '+Edit1.Text+' se le debe pagar la suma de $ '+IntToStr(Valor_salario_calculado)+' pesos.';
    end;   
  end;
end;

procedure TFrmCalcularSalarioSemanal.FormActivate(Sender: TObject);
begin
  top := 150; left := 338; Edit1.SetFocus;
end;

end.
