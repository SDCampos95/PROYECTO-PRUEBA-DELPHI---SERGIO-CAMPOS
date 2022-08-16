object DataModule1: TDataModule1
  Height = 440
  Width = 636
  object QryCliente: TADOQuery
    Connection = Conexion.DBConexion
    CursorType = ctStatic
    Parameters = <
      item
        Name = '100'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM CLIENTES  WHERE CLIENTE = :"100"')
    Left = 16
    Top = 8
    object QryClienteCLIENTE: TIntegerField
      FieldName = 'CLIENTE'
    end
    object QryClienteNOMBRE_CLIENTE: TStringField
      FieldName = 'NOMBRE_CLIENTE'
      Size = 150
    end
    object QryClienteDIRECCION: TStringField
      FieldName = 'DIRECCION'
      Size = 100
    end
  end
  object QryTemporal: TADOQuery
    Connection = Conexion.DBConexion
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 576
    Top = 8
  end
  object DtsCliente: TDataSource
    DataSet = QryCliente
    Left = 88
    Top = 8
  end
  object QryProductos: TADOQuery
    Connection = Conexion.DBConexion
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'Producto_Id'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED'
      
        'SELECT  * FROM PRODUCTOS   WITH (NOLOCK) WHERE PRODUCTO =:"Produ' +
        'cto_Id"')
    Left = 304
    Top = 24
    object QryProductosPRODUCTO: TIntegerField
      FieldName = 'PRODUCTO'
    end
    object QryProductosNOMBRE_PRODUCTO: TStringField
      FieldName = 'NOMBRE_PRODUCTO'
      Size = 250
    end
    object QryProductosVALOR: TBCDField
      FieldName = 'VALOR'
      Precision = 18
      Size = 0
    end
  end
  object QryConsultaFactura: TADOQuery
    Connection = Conexion.DBConexion
    CursorType = ctStatic
    Parameters = <
      item
        Name = '10'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      '  Declare @Num_IdCliente Numeric(18,0);'
      '  Declare @NumFactura    Numeric(18,0);'
      '  Declare @FechaFac      DateTime;'
      '  Declare @TipoFactura   Varchar(50);'
      ''
      '  Set @Num_IdCliente =:"10"'
      '  Set @TipoFactura   = '#39'NUEVA'#39';'
      ''
      
        '  SELECT   @NumFactura = NUMERO , @FechaFac = FECHA  FROM CABEZA' +
        '_FACTURA  WHERE CLIENTE = @Num_IdCliente AND TOTAL = 0 OR TOTAL ' +
        'IS NULL'
      '  '#9
      '  IF @@ROWCOUNT > 0'
      #9'BEGIN '
      #9#9'SET @TipoFactura   = '#39'PENDIENTE'#39';'
      
        #9'    SELECT @TipoFactura AS TIPO_FACTURA ,@NumFactura AS NUM_FAC' +
        'TURA, @FechaFac AS FEC_FACTURA'
      #9'END'
      #9'  Else'
      #9'     Begin'
      
        '           SET   @NumFactura = ISNULL(( SELECT TOP 1 NUMERO  FRO' +
        'M CABEZA_FACTURA   WITH (NOLOCK) ORDER BY NUMERO DESC ),0)+1;'
      '           SET   @FechaFac   = GETDATE();'
      
        '           SELECT @TipoFactura AS TIPO_FACTURA ,@NumFactura AS N' +
        'UM_FACTURA, @FechaFac AS FEC_FACTURA'
      #9#9'    End;')
    Left = 56
    Top = 248
    object QryConsultaFacturaTIPO_FACTURA: TStringField
      FieldName = 'TIPO_FACTURA'
      ReadOnly = True
      Size = 50
    end
    object QryConsultaFacturaNUM_FACTURA: TBCDField
      FieldName = 'NUM_FACTURA'
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QryConsultaFacturaFEC_FACTURA: TDateTimeField
      FieldName = 'FEC_FACTURA'
      ReadOnly = True
    end
  end
  object DtsDetalleFactura: TDataSource
    DataSet = QryConsultaFactura
    Left = 168
    Top = 232
  end
  object QryEncabezadoFactura: TADOQuery
    Connection = Conexion.DBConexion
    CursorType = ctStatic
    DataSource = DtsCliente
    Parameters = <
      item
        Name = '1'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED'
      'SELECT *  FROM CABEZA_FACTURA   WITH (NOLOCK) WHERE NUMERO =:"1"')
    Left = 552
    Top = 72
    object QryEncabezadoFacturaNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 50
    end
    object QryEncabezadoFacturaFECHA: TDateTimeField
      FieldName = 'FECHA'
    end
    object QryEncabezadoFacturaCLIENTE: TIntegerField
      FieldName = 'CLIENTE'
    end
    object QryEncabezadoFacturaTOTAL: TBCDField
      FieldName = 'TOTAL'
      Precision = 18
      Size = 2
    end
  end
  object QryDetalleFactura: TADOQuery
    Connection = Conexion.DBConexion
    CursorType = ctStatic
    Parameters = <
      item
        Name = '1'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED'
      
        'SELECT ROW_NUMBER() OVER(PARTITION BY DF.NUMERO ORDER BY DF.NUME' +
        'RO DESC) AS '#39'ITEM'#39','
      'PD.NOMBRE_PRODUCTO,'
      
        'FORMAT (DF.VALOR*DF.CANTIDAD,'#39'##,###'#39') AS VALOR_TOTAL, DF.*  , F' +
        'ORMAT (DF.VALOR,'#39'##,###'#39') AS VALOR_UNIDAD'
      'FROM DETALLE_FACTURA DF  WITH (NOLOCK)'
      'INNER JOIN PRODUCTOS PD  ON DF.PRODUCTO = PD.PRODUCTO'
      'WHERE NUMERO =:"1"')
    Left = 408
    Top = 24
    object QryDetalleFacturaITEM: TLargeintField
      FieldName = 'ITEM'
      ReadOnly = True
    end
    object QryDetalleFacturaNOMBRE_PRODUCTO: TStringField
      FieldName = 'NOMBRE_PRODUCTO'
      Size = 250
    end
    object QryDetalleFacturaVALOR_TOTAL: TWideStringField
      FieldName = 'VALOR_TOTAL'
      ReadOnly = True
      Size = 4000
    end
    object QryDetalleFacturaNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 50
    end
    object QryDetalleFacturaPRODUCTO: TIntegerField
      FieldName = 'PRODUCTO'
    end
    object QryDetalleFacturaCANTIDAD: TBCDField
      FieldName = 'CANTIDAD'
      Precision = 18
      Size = 2
    end
    object QryDetalleFacturaVALOR: TBCDField
      FieldName = 'VALOR'
      Precision = 18
      Size = 2
    end
    object QryDetalleFacturaITEM_1: TIntegerField
      FieldName = 'ITEM_1'
    end
    object QryDetalleFacturaVALOR_UNIDAD: TWideStringField
      FieldName = 'VALOR_UNIDAD'
      ReadOnly = True
      Size = 4000
    end
  end
  object QryFechaActual: TADOQuery
    Connection = Conexion.DBConexion
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select getdate()')
    Left = 160
    Top = 16
    object QryFechaActualCOLUMN1: TDateTimeField
      FieldName = 'COLUMN1'
      ReadOnly = True
    end
  end
  object DsDetalleFactura: TDataSource
    DataSet = QryDetalleFactura
    Left = 408
    Top = 80
  end
  object DtsProductos: TDataSource
    DataSet = QryProductos
    Left = 304
    Top = 88
  end
  object QryProductosActivos: TADOQuery
    Connection = Conexion.DBConexion
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT T.PRODUCTO, T.NOMBRE_PRODUCTO FROM PRODUCTOS T')
    Left = 40
    Top = 104
    object QryProductosActivosPRODUCTO: TIntegerField
      FieldName = 'PRODUCTO'
    end
    object QryProductosActivosNOMBRE_PRODUCTO: TStringField
      FieldName = 'NOMBRE_PRODUCTO'
      Size = 250
    end
  end
  object DsProductosActivos: TDataSource
    DataSet = QryProductosActivos
    Left = 152
    Top = 128
  end
  object QryServiciosFacturados: TADOQuery
    Connection = Conexion.DBConexion
    CursorType = ctStatic
    Parameters = <
      item
        Name = '1'
        DataType = ftInteger
        Size = -1
        Value = 0
      end>
    SQL.Strings = (
      #9'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED'
      
        #9'SELECT ROW_NUMBER() OVER(PARTITION BY T0.NUMERO ORDER BY T0.NUM' +
        'ERO DESC) AS '#39'ITEM'#39','
      #9'T1.NOMBRE_PRODUCTO ,'
      ''
      
        #9'FORMAT (T0.VALOR*T0.CANTIDAD,'#39'##,###'#39') AS VALOR_TOTAL, T0.*  , ' +
        'FORMAT (T0.VALOR,'#39'##,###'#39') AS VALOR_UNIDAD'
      #9'FROM DETALLE_FACTURA T0  WITH (NOLOCK)'
      #9'INNER JOIN PRODUCTOS T1  ON T0.PRODUCTO = T1.PRODUCTO'
      #9'WHERE NUMERO =:"1"')
    Left = 392
    Top = 240
    object QryServiciosFacturadosITEM: TLargeintField
      FieldName = 'ITEM'
      ReadOnly = True
    end
    object QryServiciosFacturadosNOMBRE_PRODUCTO: TStringField
      FieldName = 'NOMBRE_PRODUCTO'
      Size = 250
    end
    object QryServiciosFacturadosVALOR_TOTAL: TWideStringField
      FieldName = 'VALOR_TOTAL'
      ReadOnly = True
      Size = 4000
    end
    object QryServiciosFacturadosNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 50
    end
    object QryServiciosFacturadosPRODUCTO: TIntegerField
      FieldName = 'PRODUCTO'
    end
    object QryServiciosFacturadosCANTIDAD: TBCDField
      FieldName = 'CANTIDAD'
      Precision = 18
      Size = 2
    end
    object QryServiciosFacturadosVALOR: TBCDField
      FieldName = 'VALOR'
      Precision = 18
      Size = 2
    end
    object QryServiciosFacturadosITEM_1: TIntegerField
      FieldName = 'ITEM_1'
    end
    object QryServiciosFacturadosVALOR_UNIDAD: TWideStringField
      FieldName = 'VALOR_UNIDAD'
      ReadOnly = True
      Size = 4000
    end
  end
  object DtsServiciosFacturados: TDataSource
    DataSet = QryServiciosFacturados
    Left = 392
    Top = 304
  end
  object QryFacturacion: TADOQuery
    Connection = Conexion.DBConexion
    CursorType = ctStatic
    Parameters = <
      item
        Name = '1'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED'
      
        'SELECT ROW_NUMBER() OVER(PARTITION BY DF.NUMERO ORDER BY DF.NUME' +
        'RO DESC) AS '#39'ITEM'#39','
      
        'P.NOMBRE_PRODUCTO,'#9'FORMAT (DF.VALOR*DF.CANTIDAD,'#39'##,###'#39') AS VAL' +
        'OR_TOTAL, DF.*  , '
      
        'FORMAT (DF.VALOR,'#39'##,###'#39') AS VALOR_UNIDAD, C.CLIENTE, C.NOMBRE_' +
        'CLIENTE, C.DIRECCION'
      'FROM DETALLE_FACTURA DF'#9#9' WITH (NOLOCK)'
      'INNER JOIN PRODUCTOS P'#9#9' ON DF.PRODUCTO = P.PRODUCTO'
      'INNER JOIN CABEZA_FACTURA CF ON CF.NUMERO = DF.NUMERO'
      'INNER JOIN CLIENTES  C'#9'ON C.CLIENTE = CF.CLIENTE'
      'WHERE DF.NUMERO =:"1"')
    Left = 552
    Top = 160
    object QryFacturacionITEM: TLargeintField
      FieldName = 'ITEM'
      ReadOnly = True
    end
    object QryFacturacionNOMBRE_PRODUCTO: TStringField
      FieldName = 'NOMBRE_PRODUCTO'
      Size = 250
    end
    object QryFacturacionVALOR_TOTAL: TWideStringField
      FieldName = 'VALOR_TOTAL'
      ReadOnly = True
      Size = 4000
    end
    object QryFacturacionNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 50
    end
    object QryFacturacionPRODUCTO: TIntegerField
      FieldName = 'PRODUCTO'
    end
    object QryFacturacionCANTIDAD: TBCDField
      FieldName = 'CANTIDAD'
      Precision = 18
      Size = 2
    end
    object QryFacturacionVALOR: TBCDField
      FieldName = 'VALOR'
      Precision = 18
      Size = 2
    end
    object QryFacturacionITEM_1: TIntegerField
      FieldName = 'ITEM_1'
    end
    object QryFacturacionVALOR_UNIDAD: TWideStringField
      FieldName = 'VALOR_UNIDAD'
      ReadOnly = True
      Size = 4000
    end
    object QryFacturacionCLIENTE: TIntegerField
      FieldName = 'CLIENTE'
    end
    object QryFacturacionNOMBRE_CLIENTE: TStringField
      FieldName = 'NOMBRE_CLIENTE'
      Size = 150
    end
    object QryFacturacionDIRECCION: TStringField
      FieldName = 'DIRECCION'
      Size = 100
    end
  end
  object DtsFacturacion: TDataSource
    DataSet = QryFacturacion
    Left = 568
    Top = 216
  end
end
