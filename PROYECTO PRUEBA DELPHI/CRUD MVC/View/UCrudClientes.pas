unit UCrudClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DtConexion,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB, ADODB, Vcl.ComCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Imaging.pngimage,UControladorDatos,UModeloDatos;

type
  TFrmCrudClientes = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit7: TEdit;
    TabSheet3: TTabSheet;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit6: TEdit;
    Edit9: TEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    Edit10: TEdit;
    Button8: TButton;
    DBGrid1: TDBGrid;
    TabSheet4: TTabSheet;
    Panel2: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Edit13: TEdit;
    DateTimePicker1: TDateTimePicker;
    Edit14: TEdit;
    DBGrid2: TDBGrid;
    Edit16: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button7: TButton;
    Panel4: TPanel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Image3: TImage;
    BitBtn1: TBitBtn;
    Label26: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure DBLookupComboBox1Exit(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit13Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure Validar_CamposCliente;
    procedure Insert_Update_Cliente(Accion:String);
    procedure LimpiaClientes;
    procedure LimpiarProductos;
    procedure validar_campos_producto;
    Procedure Insert_Update_Producto(Accion:String);
    procedure validar_campos_factura;
    procedure Insert_Generar_Factura(Accion: string);

    Procedure ConsultaDetalleFactura(Factura:Currency);
    procedure DetalleServiciosFacturados(Factura:Currency);
  end;

var
   FrmCrudClientes      : TFrmCrudClientes;
   UControladorDatos    : TUControladorDatos;
   UModeloDatos         : TDataModule1;
   DtConexion           : TConexion;

   Factura : Currency;
   validar : Boolean;

implementation

{$R *.dfm}
 //***    Inicio  ***//
procedure TFrmCrudClientes.FormActivate(Sender: TObject);
begin
  Top := 145;
  Left := 338;
end;

procedure TFrmCrudClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := TCloseAction.caFree;
end;

procedure TFrmCrudClientes.FormCreate(Sender: TObject);
begin
    // SE INSTANCIAN LA CONEXION Y EL MODELO DE DATOS. //
     DtConexion   := TConexion.Create(Nil);
     UModeloDatos        := TDataModule1.Create(Nil);
     UControladorDatos  :=  TUControladorDatos.Create;

     UModeloDatos.QryProductosActivos.Close;
     UModeloDatos.QryProductosActivos.Open;
     UModeloDatos.QryProductosActivos.Refresh;

     UModeloDatos.QryServiciosFacturados.Close;
     UModeloDatos.QryServiciosFacturados.Open;
     UModeloDatos.QryServiciosFacturados.Refresh;
end;

procedure TFrmCrudClientes.ConsultaDetalleFactura(Factura:Currency);
begin
      UModeloDatos.QryServiciosFacturados.Active := True;

     UModeloDatos.QryServiciosFacturados.Close;
     UModeloDatos.QryServiciosFacturados.Parameters[0].Value := Factura ;
     UModeloDatos.QryServiciosFacturados.Open;
end;

procedure TFrmCrudClientes.Edit13Exit(Sender: TObject);
begin

   // GENERAR MACRO DE LA FACTURA //
   If (Trim(Edit13.Text) <> EmptyStr ) Then
  Begin
      UControladorDatos := TUControladorDatos.Create;
      Try
          If ( UControladorDatos.Validar_Datos_Factura(StrToIntDef(Trim(Edit13.Text),99999)) <> EmptyStr ) Then
           Begin
              DateTimePicker1.Date := UControladorDatos.Fact_Fecha;
              Edit14.Text          := UControladorDatos.Fact_Cliente_id +' '+UControladorDatos.Fact_Nombre;
              Edit16.Text          := CurrToStr( UControladorDatos.Fact_Valor_Total );
              Label25.Caption      := DateTimeToStr( UControladorDatos.Fact_Fecha );

              DetalleServiciosFacturados(UControladorDatos.Fact_NUMERO);
              DBGrid2.DataSource   := UModeloDatos.DtsFacturacion;
            End
             Else
           Begin

            End;
      Finally
        UControladorDatos.Free;
      End;
  End;

end;

procedure TFrmCrudClientes.DetalleServiciosFacturados(Factura:Currency);
begin
      UModeloDatos.QryServiciosFacturados.Active := True;

     UModeloDatos.QryFacturacion.Close;
     UModeloDatos.QryFacturacion.Parameters[0].Value := UControladorDatos.Fact_NUMERO;
     UModeloDatos.QryFacturacion.Open;
end;

procedure TFrmCrudClientes.Edit1Exit(Sender: TObject);
begin
 If (Trim(Edit1.Text) <> EmptyStr ) Then
  Begin
      UControladorDatos := TUControladorDatos.Create;
      Try
          If ( UControladorDatos.ValidarClienteBD(StrToIntDef(Trim(Edit1.Text),99999)) <> EmptyStr ) Then
           Begin
              Edit1.Text := CurrToStr(UControladorDatos.Clie_Identificacion);
              Edit2.Text := UControladorDatos.Clie_Nombre;
              Edit3.Text := UControladorDatos.Clie_Direccion;
              Button1.Enabled := False;
              Button2.Enabled := True;
              MessageDlg('El cliente ya esta registrado, si desea puede actualizar datos', mtInformation,[mbOk], 0, mbOk); Exit;
           End
             Else
                Begin
                    Button1.Enabled := True;
                    Button2.Enabled := False;
                    Edit1.Enabled := True;
                    //LimpiaClientes;
                End;
      Finally
        UControladorDatos.Free;
      End;
  End;
end;

procedure TFrmCrudClientes.Edit4Exit(Sender: TObject);
begin
 If (Trim(Edit4.Text) <> EmptyStr ) Then
  Begin
      UControladorDatos := TUControladorDatos.Create;  // INICIALIZAR EL CONTROLADOR DE DATOS - PARA QUE ESTE BUSQU� EN EL M�DULO DE DATOS LA INFORMACI�N //
      Try
          If ( UControladorDatos.ValidarProductoBD(StrToIntDef(Trim(Edit4.Text),99999)) <> EmptyStr ) Then
           Begin
              Edit4.Text := CurrToStr(UControladorDatos.Prod_PRODUCTO);
              Edit5.Text := UControladorDatos.Prod_NOMBRE_PRODUCTO;
              Edit7.Text := CurrToStr(UControladorDatos.Prod_VALOR);
              Button4.Enabled := False;
              Button5.Enabled := True;
              MessageDlg('El cliente ya se encuentra registrado, si desea puede actualizar datos.', mtInformation,[mbOk], 0, mbOk); Exit;
           End
             Else
           Begin
              Edit7.Text := EmptyStr;
              Edit5.Text := EmptyStr;
              Button4.Enabled := True;
              Button5.Enabled := False;
              Edit1.Enabled   := True;
           End;
      Finally
        UControladorDatos.Free;
      End;
  End;
end;

// CONSULTA DE FACTURA //
procedure TFrmCrudClientes.Edit6Exit(Sender: TObject);
begin
    If (Trim(Edit6.Text) <> EmptyStr ) Then
      Begin
        UControladorDatos := TUControladorDatos.Create;

        //Try
          If ( UControladorDatos.ValidarClienteBD(StrToIntDef(Trim(Edit6.Text),99999)) <> EmptyStr ) Then
           Begin
               Edit6.Text  := CurrToStr(UControladorDatos.Clie_Identificacion);
               Edit9.Text := UControladorDatos.Clie_Nombre;

               //DBLookupComboBox1.KeyValue := UControladorDatos.Fact_Producto_id;
               DBLookupComboBox1.Enabled := True;

               Edit10.Enabled     := True;
               //BitBtn8.Enabled           := True;
               Button8.Enabled   := True;

               If ( UModeloDatos.GenerarConsecutivoFactura(UControladorDatos) = True    ) Then
                Begin
                     If UControladorDatos.Fact_Tipo_Factura = 'PENDIENTE' then
                      Begin
                           If MessageDlg('El cliente seleccionado tiene un factura en proceso ' + sLineBreak +
                           'Si desea puede seguir en el proceso de facturacion de la misma ('+FormatFloat('0000',UControladorDatos.Cons_Factura)+'), o de lo contrario debera eliminar la factura para poder generar una nueva.' + sLineBreak +
                           'Desea seguir editando la factura?' ,mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then
                             Begin

                                 Factura                := UControladorDatos.Cons_Factura;
                                 UModeloDatos.ConsultaDetalle(Factura);
                             End
                               Else
                                  Begin
                                      Exit;
                                  End;
                      End
                        Else
                           Begin
                               Factura              := UControladorDatos.Cons_Factura;
                               UModeloDatos.ConsultaDetalle(Factura);
                               Label14.Caption  := FormatFloat('0000',Factura);
                           End;


//                      UModeloDatos.QryProductosActivos.Close;
//                      UModeloDatos.QryProductosActivos.Parameters[0].Value := Factura ;
//                      UModeloDatos.QryProductosActivos.Open;

                      //UModeloDatos.ProdcutosDisponibles(Factura);
                      //UModeloDatos.ProdcutosDisponibles(Factura);


                      ConsultaDetalleFactura(Factura);
                End
                  Else
                      Begin
                         MessageDlg('No es posible iniciar el proceso de facturaci�n por favor cierre e intente de nuevo, o comun�quese con el administrador del sistema ', mtInformation,[mbOk], 0, mbOk);
                         Exit;
                      End;

           End
             Else
                Begin
                    If MessageDlg('PARA PODER REALIZAR UNA FACTURA EL CLIENTE DEBE ESTAR REGISTRADO, DESEA REGISTRARLO ? '  ,mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then
                     Begin
                         Edit1.Text :=  Trim(Edit6.Text);
                     End
                       Else
                          Begin
                              Exit;
                          End;

                          DBLookupComboBox1.Enabled := False; Edit10.Enabled     := False;
                          //BitBtn8.Enabled           := False;
                          Button8.Enabled   := False;
                End;
        //Finally
          //UModeloDatos.Free;
        //End;
      End;
end;

procedure TFrmCrudClientes.Validar_CamposCliente;
begin
    validar := False;
    if Edit1.Text = EmptyStr then
    begin
      Application.MessageBox(PChar('Campo de identificaci�n del cliente Vac�o.'), '�Campo requerido!', MB_ICONWARNING);
      Edit1.SetFocus;
      Exit;
    end;
    if Edit2.Text = EmptyStr then
    begin
      Application.MessageBox(PChar('Campo del nombre completo del cliente Vac�o.'), '�Campo requerido!', MB_ICONWARNING);
      Edit2.SetFocus;
      Exit;
    end;
    if Edit3.Text = EmptyStr then
    begin
      Application.MessageBox(PChar('Campo de la direcci�n del cliente Vac�o.'), '�Campo requerido!', MB_ICONWARNING);
      Edit3.SetFocus;
      Exit;
    end;
    validar := True;
end;

procedure TFrmCrudClientes.Insert_Update_Cliente(Accion:String);
begin
    UControladorDatos := TUControladorDatos.Create;
    Try
       UControladorDatos.Clie_Identificacion  := StrToIntDef(Edit1.Text,999);
       UControladorDatos.Clie_Nombre          := UpperCase(Edit2.Text);
       UControladorDatos.Clie_Direccion       := UpperCase(Edit3.Text);


       If ( UControladorDatos.RegistrarClienteBD(Accion) <> 'Error.' ) Then
       Begin
           MessageDlg('Operacion Exitosa.', mtInformation,[mbOk], 0, mbOk);
           LimpiaClientes;
       End
         Else
            Begin
               MessageDlg('Se presentaron errores.', mtError,[mbOk], 0, mbOk);
               Exit;
            End;



    Finally
      UControladorDatos.Free;
    End;

end;

procedure TFrmCrudClientes.LimpiaClientes;
begin

     Edit1.Text := EmptyStr;
     Edit2.Text := EmptyStr;
     Edit3.Text := EmptyStr;
end;

procedure TFrmCrudClientes.LimpiarProductos;
begin
     Edit4.Text := EmptyStr;
     Edit5.Text := EmptyStr;
     Edit7.Text := EmptyStr;
end;


procedure TFrmCrudClientes.PageControl1Change(Sender: TObject);
begin

end;

// REGISTRAR NUEVO CLIENTE //
procedure TFrmCrudClientes.BitBtn1Click(Sender: TObject);
  Var Temporal_Factura: Currency;
begin

  // DIRECCIONAR LA FACTURA //
   if Application.MessageBox(('�Esta seguro de generar la respectiva factura electr�nica?'), 'Confirmaci�n', MB_ICONQUESTION or MB_YESNO + MB_DEFBUTTON2) = ID_YES then
   begin

      Temporal_Factura :=  StrToCurr( Label14.Caption );
      Edit6.Text := '';
      Edit9.Text := '';
      DBLookupComboBox1.KeyValue := Null;
      Edit10.Text := '';
      Label14.Caption := '##-##-##';

      PageControl1.Pages[3].TabVisible := true;
      PageControl1.ActivePageIndex := 3;
      Edit13.Text :=  '000' + CurrToStr( Temporal_Factura  - 1 );
      Edit13.SetFocus;
    end;



end;

procedure TFrmCrudClientes.Button1Click(Sender: TObject);
begin
    Validar_CamposCliente;

    If validar = True Then
     Begin
        Insert_Update_Cliente(Button1.Caption);
        Button3Click(Sender);
     End;
end;

// ACTUALIZACI�N DATOS DEL CLIENTE //
procedure TFrmCrudClientes.Button2Click(Sender: TObject);
begin
    Validar_CamposCliente;
    If validar = True Then
     Begin
         Insert_Update_Cliente(Button2.Caption);
         Button3Click(Sender);
     End;
end;

procedure TFrmCrudClientes.Button3Click(Sender: TObject);
begin
  Close();
  Application.CreateForm(TFrmCrudClientes, FrmCrudClientes);
  FrmCrudClientes.Show;
end;

procedure TFrmCrudClientes.Button4Click(Sender: TObject);
begin
    validar_campos_producto;

     If validar = True Then
     Begin
        Insert_Update_Producto(Button4.Caption);   // SE LLAMA EL PROCEDIMIENTO DENTRO DE LA MISMA UNIDAD //
        Button3Click(Sender);
        LimpiarProductos;
        UModeloDatos.QryProductosActivos.close;
        UModeloDatos.QryProductosActivos.open;
        DBLookupComboBox1.ListSource  := UModeloDatos.DsProductosActivos;
     End;

end;

procedure TFrmCrudClientes.Button5Click(Sender: TObject);
begin
    validar_campos_producto;

    If validar = True Then
     Begin
         Insert_Update_Producto(Button2.Caption);
         Button3Click(Sender);
         UModeloDatos.QryProductosActivos.close;
        UModeloDatos.QryProductosActivos.open;
        DBLookupComboBox1.ListSource  := UModeloDatos.DsProductosActivos;
     End;
end;

procedure TFrmCrudClientes.Button6Click(Sender: TObject);
begin
    // ELIMINAR REGISTRO //
     if Application.MessageBox(('�Esta seguro de eliminar el registros indicado?'), 'Confirmaci�n', MB_ICONQUESTION or MB_YESNO + MB_DEFBUTTON2) = ID_YES then
     begin
       If ( UModeloDatos.EliminarTraza( StrToInt( Edit4.Text)) = True ) Then
        Begin
          MessageDlg('Registro elimanado correctamente', mtInformation,[mbOk], 0, mbOk);
          Button3Click(Sender);
          Exit;
        End
        Else
        Begin
          MessageDlg('No fue posible eliminar la factura.', mtInformation,[mbOk], 0, mbOk);
          Exit;
        End;
     end
     else
     begin
       Exit;
     end;


end;

procedure TFrmCrudClientes.Button7Click(Sender: TObject);
begin
    // ELIMINAR REGISTRO DE CLIENTE //
     if Application.MessageBox(('�Esta seguro de eliminar el registros indicado?'), 'Confirmaci�n', MB_ICONQUESTION or MB_YESNO + MB_DEFBUTTON2) = ID_YES then
     begin
       If ( UModeloDatos.EliminarTraza( StrToInt( Edit1.Text)) = True ) Then
        Begin
          MessageDlg('Registro elimanado correctamente', mtInformation,[mbOk], 0, mbOk);
          Button3Click(Sender); // Bot�n Nuevo Registro
          Exit;
        End
        Else
        Begin
          MessageDlg('No fue posible eliminar la factura.', mtInformation,[mbOk], 0, mbOk);
          Exit;
        End;
     end
     else
     begin
       Exit;
     end;
end;

procedure TFrmCrudClientes.Button8Click(Sender: TObject);
begin
     validar_campos_factura;

     If validar = True Then
     Begin
        Insert_Generar_Factura(Button8.Caption);   // SE LLAMA EL PROCEDIMIENTO DENTRO DE LA MISMA UNIDAD //
     End;

end;


procedure TFrmCrudClientes.Insert_Generar_Factura(Accion: string);
begin
    UControladorDatos.Fact_Cantidad      := StrToCurr(Edit10.Text);
    UControladorDatos.Fact_NUMERO        := Factura;
    UControladorDatos.Fact_Fecha         := UModeloDatos.fechahora;

    If  UModeloDatos.FacturarProducto(UControladorDatos) = True Then
     Begin
          //UModeloDatos.ProdcutosDisponibles(Factura);

          UModeloDatos.ConsultaDetalle(Factura);
          Edit10.Text := EmptyStr;

          DBGrid1.DataSource            := UModeloDatos.DtsServiciosFacturados;
          DBLookupComboBox1.ListSource  := UModeloDatos.DsProductosActivos;

          DBLookupComboBox1.SetFocus;
     End
       Else
      Begin
          MessageDlg('Error al momento de ingresar el servicio.', mtInformation,[mbOk], 0, mbOk); Exit;
      End;

    Label14.Caption  := FormatFloat('0000',Factura);
    Label13.Caption  := 'VALOR TOTAL : $'+  formatfloat('#,##0', UControladorDatos.Fact_Valor_Total );

end;

procedure TFrmCrudClientes.validar_campos_factura;
begin

  validar := False;

  If ( Edit6.Text = EmptyStr ) Then
    Begin
        MessageDlg('Para poder registrar productos debe Ingresar el cliente.', mtInformation,[mbOk], 0, mbOk); Exit;
        Edit6.SetFocus; Exit;
    End;
   If ( DBLookupComboBox1.KeyValue = 0 ) Then
    Begin
        MessageDlg('Debe seleccione el producto a registrar.', mtInformation,[mbOk], 0, mbOk); Exit;
        DBLookupComboBox1.SetFocus; Exit;
    End;

   If ( Edit10.Text = EmptyStr ) Then
    Begin
        MessageDlg('Ingrese la cantidad a registrar de los productos.', mtInformation,[mbOk], 0, mbOk); Exit;
        Edit10.SetFocus; Exit;
    End;

   If ( StrToCurrDef( (Edit10.Text),9999)  = 9999 ) Then
    Begin
        MessageDlg('Solo se permite el Ingreso de numeros.', mtInformation,[mbOk], 0, mbOk); Exit;
        Edit10.SetFocus; Exit;
    End;

   If ( ( StrToCurr(Edit10.Text) <= 0 ) Or ( StrToCurr(Edit10.Text) > 9998 )  )Then
    Begin
        MessageDlg('La cantidad por producto a registrar debe estar entre 1 y 9998.', mtInformation,[mbOk], 0, mbOk); Exit;
        Edit10.SetFocus; Exit;
    End;

    validar := True;

end;

procedure TFrmCrudClientes.DBLookupComboBox1Exit(Sender: TObject);
begin

  if DBLookupComboBox1.KeyValue <> Null then
  begin
    UControladorDatos.Fact_Producto_id   := DBLookupComboBox1.KeyValue;
    UControladorDatos.Fact_Valor_Unit    := UModeloDatos.QryProductosVALOR.Value;
  end
  else
  begin
    Exit;
  end;

end;

procedure TFrmCrudClientes.validar_campos_producto;
begin
    // VALIDACIONES PREVIAS //

    validar := False;

     If ( Trim(Edit4.Text) = EmptyStr ) then
     Begin
         MessageDlg('Ingrese la identificaci�n del producto.', mtInformation,[mbOk], 0, mbOk);
         Edit4.SetFocus; Exit;
     End;

     If ( Trim(Edit5.Text) = EmptyStr ) then
     Begin
         MessageDlg('Ingrese la identificaci�n del producto.', mtInformation,[mbOk], 0, mbOk);
         Edit5.SetFocus; Exit;
     End;

     If ( Trim(Edit7.Text) = EmptyStr ) then
     Begin
         MessageDlg('Ingrese el valor unitario.', mtInformation,[mbOk], 0, mbOk);
         Edit7.SetFocus; Exit;
     End;

     validar := True;
end;

procedure TFrmCrudClientes.Insert_Update_Producto(Accion: string);
begin
    UControladorDatos := TUControladorDatos.Create;
    Try
       UControladorDatos.Prod_PRODUCTO          := StrToIntDef(Edit4.Text,999);
       UControladorDatos.Prod_NOMBRE_PRODUCTO   := UpperCase(Edit5.Text);
       UControladorDatos.Prod_VALOR             := StrToCurr(UpperCase(Edit7.Text));

       If ( UControladorDatos.RegistrarProductoBD(Accion) <> 'Error.' ) Then
       Begin
           MessageDlg('Operacion Exitosa.', mtInformation,[mbOk], 0, mbOk);
           LimpiaClientes;
       End
         Else
            Begin
               MessageDlg('Se presentaron errores.', mtError,[mbOk], 0, mbOk);
               Exit;
            End;

    Finally
      UControladorDatos.Free;
    End;

end;

end.
