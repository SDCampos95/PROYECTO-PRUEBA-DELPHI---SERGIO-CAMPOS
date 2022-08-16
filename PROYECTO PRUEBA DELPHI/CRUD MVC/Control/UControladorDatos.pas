unit UControladorDatos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

Type
  TUControladorDatos = class
  private
    { Private declarations }
    public

    //Variables Globales //
    Clie_Identificacion   : Integer;
    Clie_Nombre           : String;
    Clie_Direccion        : String;

    Prod_PRODUCTO         : Integer;
    Prod_NOMBRE_PRODUCTO  : String;
    Prod_VALOR            : Currency;

    Fact_Cliente_id       : String;
    Fact_NUMERO           : Currency;
    Fact_Nombre           : String;
    Fact_Producto_id      : Integer;
    Fact_Cantidad         : Double;
    Fact_Valor_Unit       : Currency;
    Fact_Valor_Total      : Currency;
    Fact_Fecha            : TDateTime;
    Cons_Factura          : Currency;
    Fact_Vlr_Total_Fact   : Currency;
    Fact_Tipo_Factura   : String;
    Fact_Cons_Factura   : Currency;
    Fact_Fecha_Temporal : TDateTime;


    Public Function ValidarClienteBD(Cliente_Id:Integer):String;
    Public Function RegistrarClienteBD(Actividad:String):String;

    Public Function ValidarProductoBD(Producto_Id:Integer):String;
    Public Function RegistrarProductoBD(Actividad:String):String;

    Function Validar_Cliente_FacturaBD(Fact_Cliente_id:Integer):String;
    Function Validar_Datos_Factura(Fact_NUMERO:Integer):String;

    { Public declarations }
  end;

implementation
   uses UModeloDatos;

// VALIDACION DE EXISTENCIA DEL NUMERO DEL CLIENTE INGRESARO EN BASE DE DATOS.  //
Function TUControladorDatos.ValidarClienteBD(Cliente_Id:Integer):String;
begin
    DataModule1 := TDataModule1.Create(Nil);
    Try
        If ( DataModule1.ValidarClienteBD(Self,Cliente_Id) = True ) Then
         Begin
            Result := 'El Cliente ya se encuentra registrado en la base de datos.';
         End
         Else
         Begin Result := '' ;

         End;

    Finally
      DataModule1.Free;
    End;
end;

// ACCIONES Y VALIDACIONES PARA EL INSERT O UPDATE DE UN REGISTRO EN LA TABLA CLIENTE. //
Function TUControladorDatos.RegistrarClienteBD(Actividad:String):String;
    Var Modelo_Gestion : TDataModule1;
begin
    DataModule1 := TDataModule1.Create(Nil);
    Try
      If ( DataModule1.RegistrarClienteBD(Self,Actividad) = 2 ) Then
      Begin
          Result := 'Error.';
      End
        Else
            Begin
                Result := 'Ok';
            End;
    Finally
      DataModule1.Free;
    End;
end;

//VALIDACION DE EXISTENCIA DEL NUMERO DEL PRODUCTO INGRESARO EN BASE DE DATOS. //
Function TUControladorDatos.ValidarProductoBD(Producto_Id:Integer):String;
    Var Modelo_Gestion : TDataModule1;
begin
    DataModule1 := TDataModule1.Create(Nil);
    Try
        If ( DataModule1.ValidarProductoBD(Self,Producto_Id) = True ) Then
         Begin
            Result := 'El Cliente ya se encuentra registrado en la base de datos.';
         End Else Begin Result := '' ; End;
    Finally
      DataModule1.Free;
    End;
end;

// REGISTRO DE PRODUCTOS EN LA BASE DE DATOS //
Function TUControladorDatos.RegistrarProductoBD(Actividad:String):String;
    Var Modelo_Gestion : TDataModule1;
begin
    DataModule1 := TDataModule1.Create(Nil); // INICIALIZAR MODELO DEDATOS //
    Try
      If ( DataModule1.RegistrarProductoBD(Self,Actividad) = 2 ) Then
      Begin
          Result := 'Error.';
      End
        Else
            Begin
                Result := 'Ok';
            End;
    Finally
      DataModule1.Free;
    End;
end;

// VALIDAR DATOS DEL CLIENTE EN EL INGRESO DE ASOCIACIÓN VS FACTURA //
Function TUControladorDatos.Validar_Cliente_FacturaBD(Fact_Cliente_id:Integer):String;
    Var Modelo_Gestion : TDataModule1;
begin
    DataModule1 := TDataModule1.Create(Nil);
    Try
        If ( DataModule1.ValidarClienteBD(Self,Fact_Cliente_id) = True ) Then
         Begin
            Result := 'El Cliente ya se encuentra registrado en la base de datos.';
         End
         Else
         Begin
            Result := '';
         End;
    Finally
      DataModule1.Free;
    End;
end;

// VALIDAR TODOS LOS DATOS QUE SE VAN A INGRESAR A LA FACTURA ELECTRONICA //
Function TUControladorDatos.Validar_Datos_Factura(Fact_NUMERO:Integer):String;
    Var Modelo_Gestion : TDataModule1;
begin
    DataModule1 := TDataModule1.Create(Nil);
    Try
        If ( DataModule1.Validar_Generacion_Factura(Self,Fact_NUMERO) = True ) Then
         Begin
            Result := 'El Cliente ya se encuentra registrado en la base de datos.';
         End
         Else
         Begin
            Result := '';
         End;
    Finally
      DataModule1.Free;
    End;
end;

end.
