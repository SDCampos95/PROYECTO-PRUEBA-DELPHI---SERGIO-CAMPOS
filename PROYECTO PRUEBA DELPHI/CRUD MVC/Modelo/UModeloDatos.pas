unit UModeloDatos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB,UControladorDatos;

type
    TDataModule1 = class(TDataModule)
    QryCliente: TADOQuery;
    QryClienteCLIENTE: TIntegerField;
    QryClienteNOMBRE_CLIENTE: TStringField;
    QryClienteDIRECCION: TStringField;
    QryTemporal: TADOQuery;
    DtsCliente: TDataSource;
    QryProductos: TADOQuery;
    QryConsultaFactura: TADOQuery;
    DtsDetalleFactura: TDataSource;
    QryEncabezadoFactura: TADOQuery;
    QryDetalleFactura: TADOQuery;
    QryFechaActual: TADOQuery;
    QryFechaActualCOLUMN1: TDateTimeField;
    QryDetalleFacturaITEM: TLargeintField;
    QryDetalleFacturaNOMBRE_PRODUCTO: TStringField;
    QryDetalleFacturaVALOR_TOTAL: TWideStringField;
    QryDetalleFacturaNUMERO: TStringField;
    QryDetalleFacturaPRODUCTO: TIntegerField;
    QryDetalleFacturaCANTIDAD: TBCDField;
    QryDetalleFacturaVALOR: TBCDField;
    QryDetalleFacturaITEM_1: TIntegerField;
    QryDetalleFacturaVALOR_UNIDAD: TWideStringField;
    DsDetalleFactura: TDataSource;
    QryProductosPRODUCTO: TIntegerField;
    QryProductosNOMBRE_PRODUCTO: TStringField;
    QryProductosVALOR: TBCDField;
    DtsProductos: TDataSource;
    QryEncabezadoFacturaNUMERO: TStringField;
    QryEncabezadoFacturaFECHA: TDateTimeField;
    QryEncabezadoFacturaCLIENTE: TIntegerField;
    QryEncabezadoFacturaTOTAL: TBCDField;
    QryProductosActivos: TADOQuery;
    DsProductosActivos: TDataSource;
    QryConsultaFacturaTIPO_FACTURA: TStringField;
    QryConsultaFacturaNUM_FACTURA: TBCDField;
    QryConsultaFacturaFEC_FACTURA: TDateTimeField;
    QryServiciosFacturados: TADOQuery;
    QryServiciosFacturadosITEM: TLargeintField;
    QryServiciosFacturadosNOMBRE_PRODUCTO: TStringField;
    QryServiciosFacturadosVALOR_TOTAL: TWideStringField;
    QryServiciosFacturadosNUMERO: TStringField;
    QryServiciosFacturadosPRODUCTO: TIntegerField;
    QryServiciosFacturadosCANTIDAD: TBCDField;
    QryServiciosFacturadosVALOR: TBCDField;
    QryServiciosFacturadosITEM_1: TIntegerField;
    QryServiciosFacturadosVALOR_UNIDAD: TWideStringField;
    DtsServiciosFacturados: TDataSource;
    QryProductosActivosPRODUCTO: TIntegerField;
    QryProductosActivosNOMBRE_PRODUCTO: TStringField;
    QryFacturacion: TADOQuery;
    QryFacturacionITEM: TLargeintField;
    QryFacturacionNOMBRE_PRODUCTO: TStringField;
    QryFacturacionVALOR_TOTAL: TWideStringField;
    QryFacturacionNUMERO: TStringField;
    QryFacturacionPRODUCTO: TIntegerField;
    QryFacturacionCANTIDAD: TBCDField;
    QryFacturacionVALOR: TBCDField;
    QryFacturacionITEM_1: TIntegerField;
    QryFacturacionVALOR_UNIDAD: TWideStringField;
    QryFacturacionCLIENTE: TIntegerField;
    QryFacturacionNOMBRE_CLIENTE: TStringField;
    QryFacturacionDIRECCION: TStringField;
    DtsFacturacion: TDataSource;

  private
    { Private declarations }
  public
     Public Function ValidarClienteBD(Datos:TUControladorDatos;Cliente_Id:Integer):Boolean;
     Public Function RegistrarClienteBD(Datos:TUControladorDatos;Actividad:String):Currency;
     Public Function ValidarProductoBD(Datos:TUControladorDatos;Producto_Id:Integer):Boolean;
     Public Function RegistrarProductoBD(Datos:TUControladorDatos;Actividad:String):Currency;
     Public function EliminarCliente( Cliente_id :Integer ): Boolean;
     Public function EliminarTraza( Producto_id :Integer ): Boolean;
     Public function fechahora: TdateTime;    // FECHA ACTUAL //
     Public Function FacturarProducto(Datos:TUControladorDatos):Boolean;
     Public Procedure ConsultaDetalle(Factura:Currency);
     Public Procedure ProdcutosDisponibles(Factura:Currency);
     Public Function GenerarConsecutivoFactura(Datos:TUControladorDatos):Boolean;
     Public Function  Validar_Generacion_Factura(Datos:TUControladorDatos;Factura:Currency):Boolean;


    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation
    Uses     DtConexion;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
// VALIDACION DE UN CLIENTE EN LA BASE DE DATOS.  //
Function TDataModule1.ValidarClienteBD(Datos:TUControladorDatos;Cliente_Id:Integer):Boolean;
begin
    QryCliente.Close;
    QryCliente.Parameters[0].Value := Cliente_Id;
    QryCliente.Open;

    If ( QryCliente.RecordCount = 1 ) Then
     Begin
         Datos.Clie_Identificacion  := QryClienteCLIENTE.Value;
         Datos.Clie_Nombre          := QryClienteNOMBRE_CLIENTE.Value;
         Datos.Clie_Direccion       := QryClienteDIRECCION.Value;
         Result  := True;
     End
       Else
          Begin Result := False; End;

    QryProductos.Close;
    QryProductos.Parameters[0].Value := Datos.Fact_Producto_id;
    QryProductos.Open;

    Datos.Fact_Producto_id := QryProductosPRODUCTO.Value;
end;
// REGISTRO DE UN CLIENTE EN LA BASE DE DATOS. //
Function TDataModule1.RegistrarClienteBD(Datos:TUControladorDatos;Actividad:String):Currency;
begin
   Try
     Conexion.DBConexion.BeginTrans;

     QryCliente.Close;
     QryCliente.Parameters[0].Value := Datos.Clie_Identificacion;
     QryCliente.Open;

     If ( Actividad = 'Registrar' ) Then
      Begin
         QryCliente.Insert;
         QryClienteCLIENTE.Value          := Datos.Clie_Identificacion;
      End Else Begin  QryCliente.Edit;  End;

         QryClienteNOMBRE_CLIENTE.Value   := UpperCase(Datos.Clie_Nombre);
         QryClienteDIRECCION.Value        := UpperCase(Datos.Clie_Direccion);

         QryCliente.Post;
         Conexion.DBConexion.CommitTrans;

      Result   :=  1;
   Except
      Result   :=  2;
      Conexion.DBConexion.RollbackTrans;
   End;
end;

// CONSULTA DATOS A LA QRYPRODUCTOS PARA REVISAR SI EXISTE UN DATO //
Function TDataModule1.ValidarProductoBD(Datos:TUControladorDatos;Producto_id:Integer):Boolean;
begin
    QryProductos.Close;
    QryProductos.Parameters[0].Value := Producto_Id;
    QryProductos.Open;

    If ( QryProductos.RecordCount = 1 ) Then
     Begin
         Datos.Prod_PRODUCTO        := QryProductosPRODUCTO.Value;
         Datos.Prod_NOMBRE_PRODUCTO := QryProductosNOMBRE_PRODUCTO.Value;
         Datos.Prod_VALOR           := QryProductosVALOR.Value;
         Result  := True;
     End
       Else
          Begin Result := False; End;
end;

Function TDataModule1.RegistrarProductoBD(Datos:TUControladorDatos;Actividad:String):Currency;
begin
   Try
     Conexion.DBConexion.BeginTrans;

     QryProductos.Close;
     QryProductos.Parameters[0].Value := Datos.Prod_PRODUCTO;
     QryProductos.Open;

     If ( Actividad = 'Registrar' ) Then
      Begin
         QryProductos.Insert;
         QryProductosPRODUCTO.Value          := Datos.Prod_PRODUCTO;
      End Else Begin  QryProductos.Edit;  End;

         QryProductosNOMBRE_PRODUCTO.Value   := UpperCase(Datos.Prod_NOMBRE_PRODUCTO);
         QryProductosVALOR.Value             := (Datos.Prod_VALOR);

         QryProductos.Post;
         Conexion.DBConexion.CommitTrans;

         QryProductosActivos.Active := False;
         QryProductosActivos.Close;
         QryProductosActivos.Active := True;
         QryProductosActivos.Open;

      Result   :=  1;
   Except
      Result   :=  2;
      Conexion.DBConexion.RollbackTrans;
   End;
end;

function TDataModule1.EliminarCliente( Cliente_id :Integer ): Boolean;
begin
   Try
     Conexion.DBConexion.BeginTrans;

     QryTemporal.Close;
     QryTemporal.SQL.Clear;
     QryTemporal.SQL.Add('DELETE FROM CLIENTES WHERE CLIENTE =:"ID CLIENTE" ');
     QryTemporal.Parameters[0].Value := Cliente_id;
     QryTemporal.ExecSQL;

      Conexion.DBConexion.CommitTrans;
      Result   :=  True;
   Except
      Result   :=  False;
      Conexion.DBConexion.RollbackTrans;
   End;
end;

function TDataModule1.EliminarTraza( Producto_id :Integer ): Boolean;
begin
   Try
     Conexion.DBConexion.BeginTrans;

     QryTemporal.Close;
     QryTemporal.SQL.Clear;
     QryTemporal.SQL.Add('DELETE FROM PRODUCTOS WHERE PRODUCTO =:"ID PRODUCTO" ');
     QryTemporal.Parameters[0].Value := Producto_id;
     QryTemporal.ExecSQL;

      Conexion.DBConexion.CommitTrans;
      Result   :=  True;
   Except
      Result   :=  False;
      Conexion.DBConexion.RollbackTrans;
   End;
end;

// VALIDAR SI EL CLIENTE TIENE NUMERO DE FACTURAS EN  CEROS PARA INTEGRAR CONSECUTIVO NUEVO //
function TDataModule1.GenerarConsecutivoFactura(Datos:TUControladorDatos):Boolean;
begin

    Try
      QryConsultaFactura.Close;
      QryConsultaFactura.Parameters[0].Value := DATOS.Clie_Identificacion;
      QryConsultaFactura.Open;

      If ( QryConsultaFactura.RecordCount <> 0 ) Then
      Begin
         Datos.Fact_Tipo_Factura    := QryConsultaFacturaTIPO_FACTURA.Value;
         Datos.Cons_Factura         := QryConsultaFacturaNUM_FACTURA.Value;
         Datos.Fact_Fecha_Temporal  := QryConsultaFacturaFEC_FACTURA.Value;
       End
         Else
     Begin
         QryTemporal.Close;
         QryTemporal.SQL.Clear;
         QryTemporal.SQL.Add( ' SELECT COUNT(*)+1 AS NUM_FACTURA FROM CABEZA_FACTURA ');
         QryTemporal.Open;

         Datos.Fact_Tipo_Factura   := 'NUEVA';
         Datos.Cons_Factura   := QryTemporal.FieldByName('NUM_FACTURA').Value;
         Datos.Fact_Fecha_Temporal := Now();
     End;

      Result := True;
    Finally
      Result := False;
    End;


  Result := True;
end;



function TDataModule1.fechahora: TdateTime;
var  fecha : tdatetime;
begin
  TRY
    QryFechaActual.close;
    QryFechaActual.Open;

    fecha :=   qryfechaactualCOLUMN1.Value;
    fechahora := fecha;
  EXCEPT
    fecha     := fechahora + strtotime('00:00:01');
    fechahora := fecha;
  END;
end;

function TDataModule1.FacturarProducto(Datos:TUControladorDatos):Boolean;
begin
   Try
     Conexion.DBConexion.BeginTrans;

     ConsultaDetalle(Datos.Fact_NUMERO);

     QryProductos.Close;
     QryProductos.Parameters[0].Value := Datos.Fact_Producto_id;
     QryProductos.Open;


     // CREAMOS PRIMERO EL ENCBEZADO //
     If ( QryDetalleFactura.RecordCount = 0 ) Then
      Begin
          QryEncabezadoFactura.Close;
          QryEncabezadoFactura.Parameters[0].Value :=  Datos.Fact_NUMERO;
          QryEncabezadoFactura.Open;

          QryEncabezadoFactura.Insert;
          QryEncabezadoFacturaNUMERO.Value   := CurrToStr( Datos.Fact_NUMERO );
          QryEncabezadoFacturaFECHA.Value    := fechahora;
          QryEncabezadoFacturaCLIENTE.Value  := ( Datos.Clie_Identificacion );
          QryEncabezadoFacturaTOTAL.Value    := QryProductosVALOR.Value*Datos.Fact_Cantidad;
          QryEncabezadoFactura.Post;

             // INGRESO DEL DETALLE DEL PRODUCTO //
             QryDetalleFactura.Insert;
             QryDetalleFacturaNUMERO.Value       := CurrToStr ( Datos.Fact_NUMERO );
             QryDetalleFacturaITEM_1.Value       := QryDetalleFactura.RecordCount+1;
             QryDetalleFacturaPRODUCTO.Value     := Datos.Fact_Producto_id;
             QryDetalleFacturaCANTIDAD.Value     := Datos.Fact_Cantidad;
             QryDetalleFacturaVALOR.Value        := QryProductosVALOR.Value;
             QryDetalleFactura.Post;
      End
         Else
             Begin   // REGISTRO DE LA TABLA DETALLE PRODCTO /

                 QryEncabezadoFactura.Close;
                 QryEncabezadoFactura.Parameters[0].Value := Datos.Fact_NUMERO;
                 QryEncabezadoFactura.Open;

                 QryDetalleFactura.Insert;
                 QryDetalleFacturaNUMERO.Value       := CurrToStr ( Datos.Fact_NUMERO );
                 QryDetalleFacturaITEM_1.Value       := QryDetalleFactura.RecordCount+1;
                 QryDetalleFacturaPRODUCTO.Value     := Datos.Fact_Producto_id;
                 QryDetalleFacturaCANTIDAD.Value     := Datos.Fact_Cantidad;
                 QryDetalleFacturaVALOR.Value        := QryProductosVALOR.Value;
                 QryDetalleFactura.Post;

                 QryEncabezadoFactura.Edit;
                 QryEncabezadoFacturaTOTAL.Value   := QryEncabezadoFacturaTOTAL.Value + (QryProductosVALOR.Value*Datos.Fact_Cantidad);
                 QryEncabezadoFactura.Post;
             End;

      Conexion.DBConexion.CommitTrans;

      Datos.Fact_Valor_Total := QryEncabezadoFacturaTOTAL.Value;

      Result   :=  True;
   Except
      Result   :=  False;
      Conexion.DBConexion.RollbackTrans;
   End;
end;

procedure TDataModule1.ConsultaDetalle(Factura: Currency);
begin

     QryDetalleFactura.Close;
     QryDetalleFactura.Parameters[0].Value := Factura ;
     QryDetalleFactura.Open;

     QryServiciosFacturados.Close;
     QryServiciosFacturados.Parameters[0].Value := Factura ;
     QryServiciosFacturados.Open;
end;


procedure TDataModule1.ProdcutosDisponibles(Factura: Currency);
Var Veri : Currency;
begin
     QryProductosActivos.Close;
     QryProductosActivos.Parameters[0].Value := Factura ;
     QryProductosActivos.Open;

end;

// GENERACIÓN DE FACTURA DE VENTA //
Function TDataModule1.Validar_Generacion_Factura(Datos:TUControladorDatos;Factura:Currency):Boolean;
begin
    QryFacturacion.Close;
    QryFacturacion.Parameters[0].Value := Factura;
    QryFacturacion.Open;

    If ( QryFacturacion.RecordCount > 0 ) Then
     Begin
         Datos.Fact_NUMERO          := StrToCurr( QryFacturacionNUMERO.Value );
         Datos.Fact_Fecha           := fechahora;
         Datos.Fact_Cliente_id      := IntToStr( QryFacturacionCLIENTE.Value );
         Datos.Fact_Nombre          := QryFacturacionNOMBRE_CLIENTE.Value;
         Datos.Fact_Valor_Total     := StrToCurr( (stringreplace(QryFacturacionVALOR_TOTAL.Value, '.', '', [rfReplaceAll, rfIgnoreCase])) );

         Result  := True;
     End
       Else
          Begin Result := False; End;
end;





end.


