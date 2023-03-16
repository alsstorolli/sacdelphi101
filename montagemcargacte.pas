// 26.02.16
// Montagem de Carga cfe as notas autorizadas
// 27.06.16 - agora cfe os pedidos pesados
// 11.10.19 - agora base para fazer pegando dos CTe para montar a carga

unit montagemcargacte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrNFeDANFEClass, ACBrNFeDANFeRLClass, StdCtrls, Grids, SqlDtg,
  Mask, SQLEd, ExtCtrls, Buttons, SQLBtn, alabel, SQLGrid,SqlExpr, SqlSis;

type
  TFMontaCargaCte = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bmontacarga: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Edtermino: TSQLEd;
    EdInicio: TSQLEd;
    EdTran_codigo: TSQLEd;
    EdTran_nome: TSQLEd;
    pgrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    EdNumeronotas: TSQLEd;
    SetEdCOLA_NOME: TSQLEd;
    EdMoes_cola_codigo01: TSQLEd;
    SQLEd1: TSQLEd;
    EdMoes_cola_codigo02: TSQLEd;
    EdPesoNotas: TSQLEd;
    EdPesoinicial: TSQLEd;
    EdPesofinal: TSQLEd;
    EdDif: TSQLEd;
    bgeranfes: TSQLBtn;
    bmarcatodos: TSQLBtn;
    bdesmarcatodos: TSQLBtn;
    brelcliente: TSQLBtn;
    brelporproduto: TSQLBtn;
    Edtara: TSQLEd;
    EdOrdem: TSQLEd;
    EdCarga: TSQLEd;
    bincluicarga: TSQLBtn;
    procedure GridClick(Sender: TObject);
    procedure EdMoes_cola_codigo02ExitEdit(Sender: TObject);
    procedure EdMoes_cola_codigo02Validate(Sender: TObject);
    procedure bmontacargaClick(Sender: TObject);
    procedure EdterminoChange(Sender: TObject);
    procedure EdterminoValidate(Sender: TObject);
    procedure EdUnid_codigoChange(Sender: TObject);
    procedure EdTran_codigoValidate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bSairClick(Sender: TObject);
    procedure APHeadLabel1Click(Sender: TObject);
    procedure bgeranfesClick(Sender: TObject);
    procedure bmarcatodosClick(Sender: TObject);
    procedure bdesmarcatodosClick(Sender: TObject);
    procedure brelclienteClick(Sender: TObject);
    procedure brelporprodutoClick(Sender: TObject);
    procedure EdOrdemExitEdit(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdCargaValidate(Sender: TObject);
    procedure bincluicargaClick(Sender: TObject);
    procedure EdCargaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(op:string;ncarga:integer=0;ntrans:string='');
    function GetPesoPesado(xtransacao,xTipomov,QPeso:string;xdatai:TDatetime):currency;
    function GetValorPesado(xtransacao,xTipomov,QPeso:string):currency;
    procedure ConfiguraTeclas( Key: Word );
    function ChecagemdePeso:boolean;
    procedure VerificaCargas;

  end;

var
  FMontaCargaCte: TFMontaCargaCte;
  tiposdemovimento,tiposnao,tiposdevolucao,xop:string;
  Q,QC:TSqlquery;
  campo :TDicionario;
  xcarga:integer;

const Tipomov:string='NT';

implementation

uses Geral,SqlFun, Unidades, fornece, DB, nfsaida, sqlrel, Transp,
  Estoque ;

{$R *.dfm}

procedure TFMontaCargaCte.GridClick(Sender: TObject);
////////////////////////////////////////////////////////
begin

{
   if ( Grid.col=Grid.getcolumn('marcado') ) and ( trim(Grid.cells[Grid.getcolumn('moes_transacao'),Grid.row])<>'' ) then begin
     if Grid.cells[Grid.getcolumn('marcado'),Grid.row]='OK' then begin
       Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='';
       Ednumeronotas.setvalue( EdNumeronotas.asinteger - 1 );
       EdPesoNotas.SetValue( EdPesoNotas.ascurrency - TexttoValor(Grid.cells[Grid.getcolumn('moes_pesoliq'),Grid.row]) );
     end else begin
       Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='OK';
       Ednumeronotas.setvalue( EdNumeronotas.asinteger + 1 );
       EdPesoNotas.SetValue( EdPesoNotas.ascurrency + TexttoValor(Grid.cells[Grid.getcolumn('moes_pesoliq'),Grid.row]) );
     end;
   end;
}

end;

procedure TFMontaCargaCte.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if key in [vk_UP, vk_Down] then exit;

//    Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='';
  if key=13 then begin
     EdOrdem.Visible:=true;
     EdOrdem.Enabled:=true;
     EdOrdem.Top:=Grid.TopEdit;
     EdOrdem.Left:=Grid.LeftEdit+5;
     EdOrdem.Text:=StrToStrNumeros(Grid.Cells[Grid.Col,Grid.Row]);
     EdOrdem.SetFocus;
  end;

end;

// 16.05.18
procedure TFMontaCargaCte.bincluicargaClick(Sender: TObject);
///////////////////////////////////////////////////////
type TOrdem=record
     ordem:integer;
     transacao:string;
end;

var p:integer;
    transacoes,ordens,cnumcarga:string;
    Numerocarga:integer;
    POrdem:^Tordem;
    Lista:TList;
    Qx:TSqlquery;

begin
////////////////////////////////////
///
  transacoes:='';
  Lista:=TList.Create;
  for p:=1 to Grid.RowCount do begin
//    if (Grid.cells[Grid.Getcolumn('marcado'),p]='OK') and (Grid.cells[Grid.Getcolumn('moes_transacao'),p]<>'') then begin
    if (Grid.cells[Grid.Getcolumn('marcado'),p]<>'') and (Grid.cells[Grid.Getcolumn('moes_transacao'),p]<>'') then begin
       transacoes:=transacoes+';'+Grid.cells[Grid.Getcolumn('moes_transacao'),p];
       New(POrdem);
       POrdem.ordem:=strtoint(Grid.cells[Grid.Getcolumn('marcado'),p]);
       POrdem.transacao:=trim(Grid.cells[Grid.Getcolumn('moes_transacao'),p]);
       Lista.Add(POrdem);
    end;
  end;

  if transacoes='' then begin
    Avisoerro('Nenhum pedido foi informado a ordem');
    exit;
  end;

  ordens:='';
  for p := 0 to Lista.Count-1 do begin

    POrdem:=Lista[p];
    if AnsiPos( strzero(POrdem.ordem,2),ordens )>0  then begin
         Avisoerro(strzero(POrdem.ordem,2)+' repetida.  Verificar');
         exit;
    end;

   ordens:=ordens+strzero(POrdem.ordem,2)+';';

  end;

  if EdCarga.AsInteger=0 then begin

     if not InPut('Carga','N�mero da Carga',cnumcarga,6,false) then exit;
     if strtointdef(cnumcarga,0) = 0 then exit;
     Qx:=sqltoquery('select * from movcargas where movc_status='+stringtosql('N')+
                 ' and movc_unid_codigo='+EdUnid_codigo.assql+
                 ' and movc_tran_codigo='+EdTran_codigo.assql+
                 ' and movc_numero = '+cnumcarga+
                 ' and movc_data >= '+Datetosql(Sistema.hoje-2));

  end else begin

     cnumcarga:=EdCarga.TExt;
     Qx:=sqltoquery('select * from movcargas where movc_status='+stringtosql('N')+
                 ' and movc_unid_codigo='+EdUnid_codigo.assql+
                 ' and movc_tran_codigo='+EdTran_codigo.assql+
                 ' and movc_numero = '+cnumcarga+
                 ' and movc_data >= '+Datetosql(Sistema.hoje-32));

  end;


  if Qx.Eof then begin
     Avisoerro('Carga '+cnumcarga+' n�o encontrada');
     exit;
  end;

  if not confirma('Confirma inclus�o na carga '+cnumcarga+' ?') then exit;


  if transacoes<>'' then begin

      NumeroCarga:=strtointdef(cnumcarga,0);

      if xOP<>'X' then begin

          Sistema.edit('movcargas');
          Sistema.setfield('movc_usua_codigo',Global.Usuario.codigo);
          Sistema.setfield('movc_cola_codigo01',EdMoes_cola_codigo01.text);
          Sistema.setfield('movc_cola_codigo02',EdMoes_cola_codigo02.text);
          Sistema.setfield('movc_pesonotas',EdPesoNotas.AsCurrency);
          Sistema.post('movc_numero = '+inttostr(Numerocarga)+' and movc_unid_codigo = '+EdUNid_codigo.assql+
                     ' and movc_tran_codigo = '+EdTran_codigo.assql);

      end;

    for p := 0 to Lista.Count-1 do begin

      POrdem:=Lista[p];
      {
      Sistema.edit('movabate');
      Sistema.SetField('mova_carga',NumeroCarga);
      Sistema.SetField('mova_tran_codigo',EdTran_codigo.AsInteger);
      if campo.Tipo<>'' then
        Sistema.SetField('mova_ordem',POrdem.ordem);
  //    Sistema.post(fGeral.GetIN('mova_transacao',transacoes,'C')+' and mova_unid_codigo ='+EdUnid_codigo.assql);
      Sistema.post('mova_transacao = '+Stringtosql(POrdem.transacao)+
                   ' and mova_unid_codigo ='+EdUnid_codigo.assql);
}
      Sistema.edit('movped');
      Sistema.SetField('mped_nftrans',NumeroCarga);
      if campo.Tipo<>'' then
        Sistema.SetField('mped_ordem',POrdem.ordem);
  //    Sistema.post(fGeral.GetIN('mova_transacao',transacoes,'C')+' and mova_unid_codigo ='+EdUnid_codigo.assql);
      Sistema.post('mped_transacao = '+Stringtosql(POrdem.transacao)+
                   ' and mped_unid_codigo ='+EdUnid_codigo.assql);
    end;


    sistema.commit;

  end;

  Aviso('Inserido pedido(s) na Carga '+inttostr(NUmerocarga));
  FGeral.fechaquery(Qx);
  Lista.Free;
  Grid.clear;
  EdNumeroNotas.Clear;
  EdPesoNotas.clear;
  EdTran_codigo.SetFocus;

end;

// 13.03.18
procedure TFMontaCargaCte.VerificaCargas;
///////////////////////////////////////
var Q1:TSqlquery;
begin

    EdCarga.Items.Clear;
    EdCarga.Clear;
    Q1:=sqltoquery('select * from movcargas where movc_status='+stringtosql('N')+
                 ' and movc_unid_codigo='+EdUnid_codigo.assql+
                 ' and movc_tran_codigo='+EdTran_codigo.assql+
                 ' and movc_data >= '+EdINicio.AsSql+
                 ' and movc_data <= '+EdTermino.AsSql);
    if Q1.Eof then begin
        Q1.Close;
        exit;
    end;
    while not Q1.Eof do begin
      EdCarga.Items.Add( strzero(Q1.FieldByName('movc_numero').AsInteger,6));
      Q1.Next;
    end;
    Q1.Close;


end;

procedure TFMontaCargaCte.Execute(op:string;ncarga:integer=0;ntrans:string='');
////////////////////////////////////////////////////////////////////////////////
begin

  xop   :=op;
  xcarga:=ncarga;

  tiposdemovimento:=Global.CodConhecimentoSaida;
  tiposnao:=Global.TiposNaoFiscal+';'+Global.CodPrestacaoServicos+';'+Global.CodVendaInterna;
  TiposDevolucao:=Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemEstoque+';'+
                  Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoInd+';'+
                  Global.CodDevolucaoSimbolicaConsig+';'+
                  Global.CodDevolucaodeRemessa+';'+
                  Global.CodDevolucaoRoman+';'+
                  Global.CodDevolucaoTributada;

  Show;
  Grid.clear;
  EdTran_codigo.clearall(self,99);
  EdUnid_codigo.text:=Global.CodigoUnidade;
  EdInicio.setdate(sistema.hoje);
  if op='V' then EdInicio.setdate(sistema.hoje-1)
  else if OP='X' then EdInicio.setdate(sistema.hoje-3);

  EdTermino.setdate(sistema.hoje);
  FGeral.ConfiguraColorEditsNaoEnabled(FMontaCargaCte);
  bgeranfes.enabled:=(op='V');
  bmontacarga.enabled:=(op<>'V');
  bincluicarga.enabled:=(op<>'V');
  bmarcatodos.enabled:=(op<>'V');
  bdesmarcatodos.enabled:=(op<>'V');
//  edpesoinicial.enabled:=(op='V');
//  edpesofinal.enabled:=(op='V');
  edpesoinicial.visible:=(op='V');
  edpesofinal.visible:=(op='V');
//  eddif.enabled:=(op='V');
  eddif.visible:=(op='V');
  if op='V' then
     caption:='Fechamento de Carga'
  else
     caption:='Montagem de Carga';

  if xOP='X' then begin

     if xcarga>0 then begin

       EdCarga.Text:=inttostr( xcarga );
       EdMoes_cola_codigo02.Next;
       EdTran_codigo.text:=ntrans;
       EdTran_codigo.validfind;

     end;

     EdCarga.SetFirstEd;

  end else
     EdTran_codigo.SetFirstEd;

  campo:=Sistema.GetDicionario('movped','mped_ordem');

end;

// 13.03.18
procedure TFMontaCargaCte.EdCargaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   ConfiguraTeclas( key );

end;

procedure TFMontaCargaCte.EdCargaValidate(Sender: TObject);
//////////////////////////////////////////////////////////
begin

  if EdCarga.IsEmpty then exit;

  if xop='X' then
     QC:=sqltoquery('select * from movcargas where movc_status='+stringtosql('N')+
                  ' and movc_unid_codigo='+EdUnid_codigo.assql+
                  ' and movc_tran_codigo='+EdTran_codigo.assql+
                  ' and movc_numero = '+EdCarga.AsSql)
  else

     QC:=sqltoquery('select * from movcargas where movc_status='+stringtosql('N')+
                  ' and movc_unid_codigo='+EdUnid_codigo.assql+
                  ' and movc_tran_codigo='+EdTran_codigo.assql+
                  ' and movc_data >= '+EdInicio.AsSql+
                  ' and movc_data <= '+EdTermino.AsSql+
                  ' and movc_numero = '+EdCarga.AsSql);
   EdMoes_cola_codigo01.text:=Qc.fieldbyname('movc_cola_codigo01').AsString;
   EdMoes_cola_codigo02.text:=Qc.fieldbyname('movc_cola_codigo02').AsString;
   EdMoes_cola_codigo01.validfind;
   EdMoes_cola_codigo02.validfind;
   EdMoes_cola_codigo02.Next;

end;

procedure TFMontaCargaCte.EdMoes_cola_codigo02ExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////
var sqltran,sqlaberto,sqldata,sqltipomov,sqlcarga:string;
    p:integer;
    pesonotas,peso,valorpedido:currency;
    DataPedido,xData:Tdatetime;
    QPedCarga:TSqlquery;

begin

  sqltran:=' and '+FGeral.Getin('moes_tran_codigo',EdTran_codigo.text,'C');
  Q:=sqltoquery('select movesto.*,clientes.clie_razaosocial,clientes.clie_tipo,clientes.clie_endres,'+
                'clientes.clie_uf,clientes.clie_nome from movesto'+
                ' left join clientes on (clie_codigo=moes_tipo_codigo)'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                  ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                ' and '+FGeral.Getin('moes_retornonfe','Autorizado o uso do CT-e','C')+
                ' and   ( (moes_carga = 0) or (moes_carga is null) )'+
                sqltran+
                ' order by moes_numerodoc' );

   DataPedido:=sistema.hoje;


///////////   if xOP='X' then sqlcarga:=' and mped_nftrans = '+inttostr(xcarga);

   xData:=EdInicio.AsDate-30;

{
   if not EdCarga.IsEmpty then begin
      sqlcarga:=' and mped_nftrans = '+EdCarga.AsSql;
      sqldata:=' and mped_datamvto >= '+Datetosql(xdata)+' and mped_datamvto <= '+EdTermino.assql;
   end;
}

/////////////  bmontacarga.Enabled:=true;
  if ( Q.Eof ) then begin
     Avisoerro('N�o encontrado conhecimentos em aberto');
     exit;
  end;

  Grid.Clear;p:=1;
  pesonotas:=0;valorpedido:=0;
  Sistema.BeginProcess('Pesquisando conhecimentos');

  while not Q.eof do begin

//    valorpedido:=GetValorPesado(Q.fieldbyname('mped_transacao').AsString,Tipomov,'1') ;
    valorpedido:=Q.FieldByName('moes_vlrtotal').AsCurrency;
    if valorpedido>0 then begin
{
        Grid.Cells[Grid.GetColumn('moes_numerodoc'),p]:=Q.fieldbyname('mova_numerodoc').asstring;
        Grid.Cells[Grid.GetColumn('moes_dataemissao'),p]:=FGeral.FormataData( Q.fieldbyname('mova_dtabate').asdatetime );
        Grid.Cells[Grid.GetColumn('moes_vlrtotal'),p]:=floattostr(valorpedido);
        Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p]:=Q.fieldbyname('mova_tipo_codigo').asstring;
        Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:= Q.fieldbyname('clie_razaosocial').asstring;
        Grid.Cells[Grid.GetColumn('clie_endres'),p]:=Q.fieldbyname('clie_endres').asstring;
        Grid.Cells[Grid.GetColumn('moes_transacao'),p]:=Q.fieldbyname('mova_transacao').asstring;
        peso:=GetPesoPesado(Q.fieldbyname('mova_transacao').AsString,Tipomov) ;
        Grid.Cells[Grid.GetColumn('moes_pesoliq'),p]:=FGeral.Formatavalor( Peso,f_cr ) ;
}
        Grid.Cells[Grid.GetColumn('moes_numerodoc'),p]:=Q.fieldbyname('moes_numerodoc').asstring;
        Grid.Cells[Grid.GetColumn('moes_dataemissao'),p]:=FGeral.FormataData( Q.fieldbyname('moes_datamvto').asdatetime );
        Grid.Cells[Grid.GetColumn('moes_vlrtotal'),p]:=floattostr(valorpedido);
        Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p]:=Q.fieldbyname('moes_tipo_codigo').asstring;
        Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:= Q.fieldbyname('clie_razaosocial').asstring;
        Grid.Cells[Grid.GetColumn('clie_endres'),p]:=Q.fieldbyname('clie_endres').asstring;
        Grid.Cells[Grid.GetColumn('moes_transacao'),p]:=Q.fieldbyname('moes_transacao').asstring;
        Grid.Cells[Grid.GetColumn('retorno'),p]:=Q.fieldbyname('moes_retornonfe').asstring;

        peso:=Q.fieldbyname('moes_pesoliq').AsCurrency;

        Grid.Cells[Grid.GetColumn('moes_pesoliq'),p]:=FGeral.Formatavalor( Peso,f_cr ) ;
//        if campo.Tipo<>'' then
//          Grid.Cells[Grid.GetColumn('marcado'),p]:=Q.fieldbyname('mped_ordem').asstring;

        pesonotas:=pesonotas+peso;
        EdPesonotas.setvalue( pesonotas );
        Grid.AppendRow;
        inc(p);
    end;

    Q.Next;

  end;

// 17.09.18
  if EdCarga.AsInteger>0 then begin

     p:=0;
     pesonotas:=0;
     sqldata   :=' and moes_datamvto >= '+EdINicio.assql+ ' and moes_datamvto <= '+EdTermino.assql;
     sqltipomov:=' and moes_tipomov = '+Stringtosql(Global.CodConhecimentoSaida);
     sqlcarga  :=' and ( ( moes_carga is null ) or ( moes_carga=0) )';

     QPedCarga:=sqltoquery('select movesto.*,clie_razaosocial,clie_endres from movesto inner join clientes on (clie_codigo=moes_tipo_codigo)'+
                ' where moes_status = ''N'''+
                ' and '+FGeral.Getin('moes_unid_codigo',Global.CodigoUnidade,'C')+
                ' and moes_carga = '+EdCarga.AsSql+
                sqltran+sqldata+sqltipomov );

     while not QPedCarga.Eof do begin

  //      peso:=GetPesoPesado(QPedCarga.fieldbyname('mped_numerodoc').AsString,'SA','2',QPedCarga.fieldbyname('mped_datamvto').AsDatetime);
        peso := QPedCarga.FieldByName('moes_pesoliq').ascurrency;
        pesonotas:=pesonotas + peso;
        inc(p);
        QPedCarga.Next;

     end;
     EdPesonotas.setvalue( pesonotas );
     EdNUmeronotas.text:=inttostr( p );
     FGEral.FechaQuery(QPedCarga);

  end;


  Sistema.endprocess('');
  EdNumeronotas.setvalue( p-1 );
  EdPesonotas.Update;

end;

procedure TFMontaCargaCte.EdMoes_cola_codigo02Validate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
begin
   if not EdMoes_cola_codigo02.IsEmpty then
     if EdMoes_cola_codigo02.text=EdMoes_cola_codigo01.Text then EdMoes_cola_codigo02.invalid('Motorista 2 n�o pode ser igual ao 1');
end;

procedure TFMontaCargaCte.EdOrdemExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////
begin

  if not Edordem.IsEmpty then
    Grid.Cells[Grid.Col,Grid.Row]:=strtostrnumeros(EdOrdem.Text)
  else
    Grid.Cells[Grid.Col,Grid.Row]:='';
  Grid.SetFocus;
  EdOrdem.Visible:=False;

end;

// 14.02.18
procedure TFMontaCargaCte.bmarcatodosClick(Sender: TObject);
//////////////////////////////////////////////////////////
var x:integer;
    xpeso:currency;
begin
  EdNUmeronotas.SetValue(0);
  EdPesonotas.SetValue(0);
  xpeso:=0;
  for x:=0 to Grid.rowcount do begin
    if trim( Grid.cells[Grid.getcolumn('moes_numerodoc'),x] ) <> '' then begin
       Grid.cells[Grid.getcolumn('marcado'),x]:='Ok';
       Ednumeronotas.setvalue( EdNumeronotas.asinteger + 1 );
       xPeso:=xPeso + TexttoValor(Grid.cells[Grid.getcolumn('moes_pesoliq'),x]) ;
    end;
  end;
  EdPesoNotas.SetValue( xpeso );
  EdPesoNotas.Update;
end;

procedure TFMontaCargaCte.bmontacargaClick(Sender: TObject);
/////////////////////////////////////////////////////////////
type TOrdem=record
     ordem:integer;
     transacao:string;
end;

var p:integer;
    transacoes,ordens:string;
    Numerocarga:integer;
    POrdem:^Tordem;
    Lista:TList;

//    QC:TSqlquery;
begin

  if xop='V' then exit;
  if not EdCarga.isempty then begin
     Aviso('Numero de carga informado somente incluir pedido');
     exit;
  end;
  transacoes:='';
  Lista:=TList.Create;
  for p:=1 to Grid.RowCount do begin
//    if (Grid.cells[Grid.Getcolumn('marcado'),p]='OK') and (Grid.cells[Grid.Getcolumn('moes_transacao'),p]<>'') then begin
    if (Grid.cells[Grid.Getcolumn('marcado'),p]<>'') and (Grid.cells[Grid.Getcolumn('moes_transacao'),p]<>'') then begin
       transacoes:=transacoes+';'+Grid.cells[Grid.Getcolumn('moes_transacao'),p];
       New(POrdem);
       POrdem.ordem:=strtoint(Grid.cells[Grid.Getcolumn('marcado'),p]);
       POrdem.transacao:=trim(Grid.cells[Grid.Getcolumn('moes_transacao'),p]);
       Lista.Add(POrdem);
    end;
  end;
  ordens:='';
  for p := 0 to Lista.Count-1 do begin

    POrdem:=Lista[p];
    if AnsiPos( strzero(POrdem.ordem,2),ordens )>0  then begin
         Avisoerro(strzero(POrdem.ordem,2)+' repetida.  Verificar');
         exit;
    end;

   ordens:=ordens+strzero(POrdem.ordem,2)+';';

  end;

  if not confirma('Confirma ?') then exit;


  if transacoes<>'' then begin

    QC:=sqltoquery('select * from movcargas where movc_status='+stringtosql('N')+
                 ' and movc_unid_codigo='+EdUnid_codigo.assql+
                 ' and movc_tran_codigo='+EdTran_codigo.assql+
                 ' and movc_data = '+Datetosql(Sistema.hoje));
    if QC.eof then
      NumeroCarga:=FGeral.GetContador('CARGA'+EdUnid_codigo.text,false)
    else begin

      NumeroCarga:=QC.fieldbyname('movc_numero').asinteger;
      Sistema.edit('movcargas');
      Sistema.setfield('movc_usua_codigo',Global.Usuario.codigo);
      Sistema.setfield('movc_cola_codigo01',EdMoes_cola_codigo01.text);
      Sistema.setfield('movc_cola_codigo02',EdMoes_cola_codigo02.text);
      Sistema.setfield('movc_pesonotas',EdPesoNotas.AsCurrency);
      Sistema.post('movc_numero = '+inttostr(Numerocarga)+' and movc_unid_codigo = '+EdUNid_codigo.assql+
                 ' and movc_tran_codigo = '+EdTran_codigo.assql);

    end;

    for p := 0 to Lista.Count-1 do begin

      POrdem:=Lista[p];
      {
      Sistema.edit('movabate');
      Sistema.SetField('mova_carga',NumeroCarga);
      Sistema.SetField('mova_tran_codigo',EdTran_codigo.AsInteger);
      if campo.Tipo<>'' then
        Sistema.SetField('mova_ordem',POrdem.ordem);
  //    Sistema.post(fGeral.GetIN('mova_transacao',transacoes,'C')+' and mova_unid_codigo ='+EdUnid_codigo.assql);
      Sistema.post('mova_transacao = '+Stringtosql(POrdem.transacao)+
                   ' and mova_unid_codigo ='+EdUnid_codigo.assql);
}
      Sistema.edit('movesto');
      Sistema.SetField('moes_carga',NumeroCarga);
      Sistema.post('moes_transacao = '+Stringtosql(POrdem.transacao)+
                   ' and moes_unid_codigo ='+EdUnid_codigo.assql);
    end;

    if Qc.Eof then begin
      Sistema.insert('movcargas');
      Sistema.setfield('movc_status','N');
      Sistema.setfield('movc_numero',NumeroCarga);
      Sistema.setfield('movc_data',Sistema.Hoje);
      Sistema.setfield('movc_datamvto',Sistema.Hoje);
      Sistema.setfield('movc_unid_codigo',Edunid_codigo.text);
  //    Sistema.setfield('movc_pesoi',0);
  //    Sistema.setfield('movc_pesof',0);
  //    Sistema.setfield('movc_difpeso',0);
      Sistema.setfield('movc_tran_codigo',EdTran_codigo.text);
      Sistema.setfield('movc_cola_codigo01',EdMoes_cola_codigo01.text);
      Sistema.setfield('movc_cola_codigo02',EdMoes_cola_codigo02.text);
      Sistema.setfield('movc_pesonotas',EdPesoNotas.AsCurrency);
      Sistema.setfield('movc_usua_codigo',Global.Usuario.Codigo);
      Sistema.post();
    end;

    sistema.commit;

  end;

  if transacoes<>'' then

     Aviso('Carga '+inttostr(NUmerocarga)+' Montada')

  else

     Aviso('Carga N�O Montada');

  FGeral.fechaquery(Qc);
  Lista.Free;
  Grid.clear;
  EdNumeroNotas.Clear;
  EdPesoNotas.clear;
  EdTran_codigo.SetFocus;

end;

// 14.02.18
procedure TFMontaCargaCte.brelclienteClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var QC,Q:TSqlquery;
    sqlperiodo:string;

begin

    if EdCarga.IsEmpty then begin
      Aviso('Escolhe a carga primeiro');
      exit;
    end;
    sqlperiodo:=' and movc_data>='+EdInicio.AsSql+' and movc_data<='+EdTermino.AsSql;
    QC:=sqltoquery('select * from movcargas where movc_status='+stringtosql('N')+
                 ' and movc_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                 ' and movc_tran_codigo='+EdTran_codigo.assql+
                 ' and movc_numero = '+EdCarga.AsSql+
                 sqlperiodo);

    if QC.Eof then begin
      Avisoerro('N�o encontrado nenhuma carga neste periodo');
      exit;
    end;
{
    sqlperiodo:=' and mova_dtabate>='+EdInicio.AsSql+' and mova_dtabate<='+EdTermino.AsSql;
    Q:=sqltoquery('select mova_carga,movd_tipo_codigo,movd_esto_codigo,sum(movd_pecas) as movd_pecas,sum(movd_pesocarcaca) as movd_pesocarcaca from movabatedet '+
                  ' inner join movabate on ( mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc and mova_tipomov=movd_tipomov)'+
                  ' where '+FGeral.Getin('movd_status','N','C')+
///                  sqlperiodo+
                  ' and mova_carga = '+QC.FieldByName('movc_numero').AsString+
                  ' and mova_tipomov = '+Stringtosql('SA')+
//                  ' and '+FGeral.Getin('mova_situacao','N;P','C')+
                  ' group by mova_carga,movd_tipo_codigo,movd_esto_codigo' +
                  ' order by mova_carga,movd_tipo_codigo,movd_esto_codigo' );
}
    sqlperiodo:=' and mped_datamvto>='+EdInicio.AsSql+' and mped_datamvto<='+EdTermino.AsSql;
        Q:=sqltoquery('select mped_nftrans,mped_ordem,mpdd_tipo_codigo,mpdd_esto_codigo,sum(mpdd_pecas) as movd_pecas,sum(mpdd_pecas*mpdd_qtde) as movd_pesocarcaca from movpeddet '+
                  ' inner join movped on ( mped_transacao=mpdd_transacao and mped_numerodoc=mpdd_numerodoc and mped_tipomov=mpdd_tipomov)'+
                  ' where '+FGeral.Getin('mpdd_status','N','C')+
///                  sqlperiodo+
                  ' and mped_nftrans = '+QC.FieldByName('movc_numero').AsString+
                  ' and mped_tipomov = '+Stringtosql( Global.codPedVenda )+
//                  ' and '+FGeral.Getin('mova_situacao','N;P','C')+
                  ' group by mped_nftrans,mped_ordem,mpdd_tipo_codigo,mpdd_esto_codigo' +
                  ' order by mped_nftrans,mped_ordem,mpdd_tipo_codigo,mpdd_esto_codigo' );

      Sistema.BeginProcess('Gerando Relat�rio');

      FRel.Init('CargaporClienteProduto');
      FRel.AddTit('Carga por Cliente do ve�culo '+EdTran_codigo.Text+' - '+EdTran_codigo.ResultFind.FieldByName('tran_placa').AsString+' - '+EdTran_codigo.ResultFind.FieldByName('tran_nome').AsString);
      FRel.AddTit('Periodo : '+FGeral.formatadata(Edinicio.Asdate)+' a '+FGeral.formatadata(Edtermino.asdate));

//      FRel.AddCol( 40,1,'C','' ,''              ,'Codigo.'         ,''         ,'',false);
//      FRel.AddCol(150,1,'C','' ,''              ,'Ve�culo'         ,''         ,'',false);
      FRel.AddCol( 50,3,'N','' ,''              ,'Carga'           ,''         ,'',false);
      FRel.AddCol( 50,3,'N','' ,''              ,'Ordem'           ,''         ,'',false);
      FRel.AddCol( 65,3,'N','' ,''              ,'Cod.Cliente'    ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Nome'  ,''         ,'',false);
      FRel.AddCol( 60,3,'N','' ,''              ,'Produto'           ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Descri��o Produto'   ,''         ,'',false);
      FRel.AddCol( 40,3,'N','+'  ,'#####0'       ,'Pe�as'              ,''         ,'',False);
      FRel.AddCol( 60,3,'N','+' ,f_cr3          ,'Peso'        ,''         ,'',False);

      while not Q.eof do begin

 //           FRel.AddCel(Q.fieldbyname('mova_tran_codigo').asstring);
 //           FRel.AddCel( FTransp.GetNome(Q.fieldbyname('mova_tran_codigo').asstring) );
            FRel.AddCel(Q.fieldbyname('mped_nftrans').asstring);
            FRel.AddCel(Q.fieldbyname('mped_ordem').asstring);
            FRel.AddCel(Q.fieldbyname('mpdd_tipo_codigo').asstring);
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mpdd_tipo_codigo').asinteger,'C','N'));
            FRel.AddCel(Q.fieldbyname('mpdd_esto_codigo').asstring);
            FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('mpdd_esto_codigo').asstring));
            FRel.AddCel( floattostr( Q.fieldbyname('movd_pecas').ascurrency) );
            FRel.AddCel(floattostr(Q.fieldbyname('movd_pesocarcaca').ascurrency));
//            FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrarroba').ascurrency));
//            FRel.AddCel( floattostr(Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency/15) ) );
//            FRel.AddCel(Q.fieldbyname('movd_obs').asstring);
        Q.Next;

      end;

      FRel.Video;

    Sistema.EndProcess('');
    FGeral.Fechaquery(Q);


end;

// 15.02.18
procedure TFMontaCargaCte.brelporprodutoClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var QC,Q:TSqlquery;
    sqlperiodo:string;

begin

    if EdCarga.IsEmpty then begin
      Aviso('Escolhe a carga primeiro');
      exit;
    end;

    sqlperiodo:=' and movc_data>='+EdInicio.AsSql+' and movc_data<='+EdTermino.AsSql;
    QC:=sqltoquery('select * from movcargas where movc_status='+stringtosql('N')+
                 ' and movc_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                 ' and movc_tran_codigo='+EdTran_codigo.assql+
                 ' and movc_numero = '+EdCarga.AsSql+
                 sqlperiodo);

    if QC.Eof then begin
      Avisoerro('N�o encontrado nenhuma carga neste periodo');
      exit;
    end;
{
    sqlperiodo:=' and mova_dtabate>='+EdInicio.AsSql+' and mova_dtabate<='+EdTermino.AsSql;
    Q:=sqltoquery('select movd_unid_codigo,mova_carga,movd_esto_codigo,sum(movd_pecas) as movd_pecas,sum(movd_pesocarcaca)as movd_pesocarcaca from movabatedet '+
                  ' inner join movabate on ( mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc and mova_tipomov=movd_tipomov)'+
                  ' where '+FGeral.Getin('movd_status','N','C')+
///                  sqlperiodo+
                  ' and mova_carga = '+QC.FieldByName('movc_numero').AsString+
                  ' and movd_tipomov = '+Stringtosql('SA')+
//                  ' and '+FGeral.Getin('mova_situacao','N;P','C')+
                  ' group by movd_unid_codigo,mova_carga,movd_esto_codigo'+
                  ' order by movd_unid_codigo,mova_carga,movd_esto_codigo' );
}
    sqlperiodo:=' and mped_datamvto>='+EdInicio.AsSql+' and mped_datamvto<='+EdTermino.AsSql;
    Q:=sqltoquery('select mpdd_unid_codigo,mped_nftrans,mpdd_esto_codigo,sum(mpdd_pecas) as movd_pecas,sum(mpdd_pecas*mpdd_qtde)as movd_pesocarcaca from movpeddet '+
                  ' inner join movped on ( mped_transacao=mpdd_transacao and mped_numerodoc=mped_numerodoc and mped_tipomov=mpdd_tipomov)'+
                  ' where '+FGeral.Getin('mpdd_status','N','C')+
///                  sqlperiodo+
                  ' and mped_nftrans = '+QC.FieldByName('movc_numero').AsString+
                  ' and mpdd_tipomov = '+Stringtosql(Global.codPedvenda)+
//                  ' and '+FGeral.Getin('mova_situacao','N;P','C')+
                  ' group by mpdd_unid_codigo,mped_nftrans,mpdd_esto_codigo'+
                  ' order by mpdd_unid_codigo,mped_nftrans,mpdd_esto_codigo' );

      Sistema.BeginProcess('Gerando Relat�rio');

      FRel.Init('CargaporProduto');
      FRel.AddTit('Carga por PRODUTO do ve�culo '+EdTran_codigo.Text+' - '+EdTran_codigo.ResultFind.FieldByName('tran_placa').AsString+' - '+EdTran_codigo.ResultFind.FieldByName('tran_nome').AsString);
      FRel.AddTit('Periodo : '+FGeral.formatadata(Edinicio.Asdate)+' a '+FGeral.formatadata(Edtermino.asdate));

      FRel.AddCol( 50,3,'N','' ,''              ,'Carga'           ,''         ,'',false);
//      FRel.AddCol( 50,3,'N','' ,''              ,'Pedido'           ,''         ,'',false);
      FRel.AddCol( 60,3,'N','' ,''              ,'Produto'           ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Descri��o Produto'   ,''         ,'',false);
      FRel.AddCol( 40,3,'N','+'  ,'#####0'       ,'Pe�as'              ,''         ,'',False);
      FRel.AddCol( 60,3,'N','+' ,f_cr3          ,'Peso'        ,''         ,'',False);

      while not Q.eof do begin

         if AnsiPos('CARCA',Uppercase(FEstoque.GetDescricao( Q.fieldbyname('mpdd_esto_codigo').asstring ) ) ) =0 then begin

            FRel.AddCel(Q.fieldbyname('mped_nftrans').asstring);
//            FRel.AddCel(Q.fieldbyname('mova_numerodoc').asstring);
            FRel.AddCel(Q.fieldbyname('mpdd_esto_codigo').asstring);
            FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('mpdd_esto_codigo').asstring));
            FRel.AddCel( floattostr( Q.fieldbyname('movd_pecas').ascurrency) );
            FRel.AddCel(floattostr(Q.fieldbyname('movd_pesocarcaca').ascurrency));
//            FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrarroba').ascurrency));
//            FRel.AddCel( floattostr(Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency/15) ) );
//            FRel.AddCel(Q.fieldbyname('movd_obs').asstring);
        end;

        Q.Next;

      end;
      Q.First;
      FGeral.PulalinhaRel( FRel.GCol.ColCount );
      while not Q.eof do begin

         if AnsiPos('CARCA',Uppercase(FEstoque.GetDescricao( Q.fieldbyname('mpdd_esto_codigo').asstring ) ) ) > 0 then begin

            FRel.AddCel(Q.fieldbyname('mped_nftrans').asstring);
//            FRel.AddCel(Q.fieldbyname('mova_numerodoc').asstring);
            FRel.AddCel(Q.fieldbyname('mpdd_esto_codigo').asstring);
            FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('mpdd_esto_codigo').asstring));
            FRel.AddCel( floattostr( Q.fieldbyname('movd_pecas').ascurrency) );
            FRel.AddCel(floattostr(Q.fieldbyname('movd_pesocarcaca').ascurrency));
//            FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrarroba').ascurrency));
//            FRel.AddCel( floattostr(Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency/15) ) );
//            FRel.AddCel(Q.fieldbyname('movd_obs').asstring);
        end;

        Q.Next;

      end;

      FRel.Video;

    Sistema.EndProcess('');
    FGeral.Fechaquery(Q);

end;

// 27.06.16
function TFMontaCargaCte.GetPesoPesado(xtransacao, xTipomov,QPeso: string;xdatai:TDatetime): currency;
///////////////////////////////////////////////////////////////////////////////
///    QPeso : 1 - digitado no pedido   2 - lido na balan�a
var xpeso:currency;
    Q:TSqlquery;
begin
   if QPeso = '2' then begin

      Q:=sqltoquery('select movd_pesocarcaca from movabatedet where movd_status = ''N'''+
                         ' and movd_tipomov = '+Stringtosql('SA')+
                         ' and movd_numerodoc = '+xtransacao+
                         ' and movd_datamvto >= '+Datetosql( xDatai )+
                         ' and movd_unid_codigo = '+EdUNid_codigo.AsSql );
       xpeso:=0;
       while not Q.eof do begin

         xpeso:=xpeso+Q.fieldbyname('movd_pesocarcaca').ascurrency;
         Q.next;
       end;

   end else begin
       Q:=sqltoquery('select (mpdd_qtde*mpdd_pecas) as peso from movpeddet where mpdd_transacao='+Stringtosql(xtransacao)+
                     ' and mpdd_status = ''N'' and mpdd_tipomov = '+Stringtosql(xtipomov));
       xpeso:=Q.FieldByName('peso').AsCurrency;;

   end;
   FGeral.FechaQuery(Q);
   result:=xpeso;
end;

// 27.06.16
function TFMontaCargaCte.GetValorPesado(xtransacao,  xTipomov,QPeso: string): currency;
////////////////////////////////////////////////////////////////////////////////////
///    QPeso : 1 - digitado no pedido   2 - lido na balan�a
var xpeso:currency;
    Q:TSqlquery;
begin
   if Qpeso='2' then
     Q:=sqltoquery('select movd_pesobalanca,movd_vlrarroba from movabatedet where movd_transacao='+Stringtosql(xtransacao)+
                 ' and movd_status = ''N'' and movd_tipomov = '+Stringtosql(xtipomov))
   else
     Q:=sqltoquery('select mpdd_qtde,mpdd_pecas from movpeddet where mpdd_transacao='+Stringtosql(xtransacao)+
                 ' and mpdd_status = ''N'' and mpdd_tipomov = '+Stringtosql(Global.CodPedVenda));
   xpeso:=0;
   while not Q.eof do begin
     if Qpeso='2' then
       xpeso:=xpeso+(Q.fieldbyname('movd_pesobalanca').ascurrency*Q.fieldbyname('movd_vlrarroba').ascurrency)
     else
       xpeso:=xpeso+(Q.fieldbyname('mpdd_qtde').ascurrency*Q.fieldbyname('mpdd_pecas').ascurrency);
     Q.next;
   end;
   FGeral.FechaQuery(Q);
   result:=xpeso;
end;

procedure TFMontaCargaCte.EdterminoChange(Sender: TObject);
begin

end;

// 04.07.16
procedure TFMontaCargaCte.EdterminoValidate(Sender: TObject);
//////////////////////////////////////////////////////////
begin
   if EdTermino.asdate < EdInicio.AsDate then EdTermino.Invalid('T�rmino tem que ser maior que inicio')
   else
     VerificaCargas;
end;

procedure TFMontaCargaCte.EdUnid_codigoChange(Sender: TObject);
begin

end;

// 04.07.16
procedure TFMontaCargaCte.EdTran_codigoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
var sql01,sqldata:string;
    difpeso  : currency;

begin
   if xop='M' then
     sql01:=' and movc_pesoi>0'
//            ' and ( (movc_pesof=0) or (movc_pesof is null) )'
   else
     sql01:=' and movc_pesoi>0'+
            ' and movc_pesof>0';
   sqldata := ' and movc_data = '+Datetosql(Sistema.hoje);
   if xOP='V' then
      sqldata := ' and movc_data >= '+Datetosql(Sistema.hoje-1);

   QC:=sqltoquery('select * from movcargas where movc_status='+stringtosql('N')+
                 ' and movc_unid_codigo='+EdUnid_codigo.assql+
                 ' and movc_tran_codigo='+EdTran_codigo.assql+
                 sqldata+
                 sql01 );

   if xOP='V' then begin

       EdMoes_cola_codigo01.enabled:=false;
       EdMoes_cola_codigo02.enabled:=false;

       if Qc.Eof then begin
           EdTran_codigo.Invalid('Nenhuma carga encontrada para esta placa');
           exit;
       end;

       Edinicio.enabled:=false;
       Edtermino.enabled:=false;
       EdCarga.Text:=QC.FieldByName('movc_numero').Asstring;
       EdCarga.Valid;
       EdMoes_cola_codigo02.Valid;
       EdPesoinicial.SetValue(Qc.FieldByName('movc_pesoi').AsCurrency);
       EdPesoFinal.SetValue(Qc.FieldByName('movc_pesof').AsCurrency);
       difpeso:=Abs( Qc.FieldByName('movc_pesof').AsCurrency-Qc.FieldByName('movc_pesoi').AsCurrency );
       EdDif.SetValue(difpeso);;

   end else begin

       EdMoes_cola_codigo01.enabled:=true;
       EdMoes_cola_codigo02.enabled:=true;
       EdMoes_cola_codigo01.text:=EdTran_codigo.ResultFind.FieldByName('tran_cola_codigo').AsString;
       Edinicio.enabled:=true;
       Edtermino.enabled:=true;

   end;

   {
   if QC.Eof then begin
// 14.02.18 - retirado pra iniciar o uso por vagner

     if xop='M' then
       EdTran_codigo.invalid('N�o encontrado peso inicial '+fGeral.FormataData(Sistema.hoje))
     else
       EdTran_codigo.invalid('N�o encontrado peso inicial e final '+fGeral.FormataData(Sistema.hoje));
     exit;

   end else if (not QC.eof) and (Qc.fieldbyname('movc_pesoi').Ascurrency>0) and (Qc.fieldbyname('movc_cola_codigo01').AsString<>'') then begin
//   (Qc.fieldbyname('movc_pesof').Ascurrency<0) then begin

     EdPesoinicial.setvalue(Qc.fieldbyname('movc_pesoi').AsCurrency);
     EdPesofinal.setvalue(Qc.fieldbyname('movc_pesof').AsCurrency);
     EdMoes_cola_codigo01.text:=Qc.fieldbyname('movc_cola_codigo01').AsString;
     EdMoes_cola_codigo02.text:=Qc.fieldbyname('movc_cola_codigo02').AsString;
     EdMoes_cola_codigo01.validfind;
     EdMoes_cola_codigo02.validfind;
     EdMoes_cola_codigo01.enabled:=false;
     EdMoes_cola_codigo02.enabled:=false;
     Edinicio.enabled:=false;
     Edtermino.enabled:=false;
     EdDif.setvalue(EdPesofinal.ascurrency-EdPesoinicial.ascurrency);
     EdMoes_cola_codigo02.OnExitEdit(self);
// ira montar a carga
   end else if (not QC.eof) and (Qc.fieldbyname('movc_pesoi').Ascurrency>0) then begin
     EdPesoinicial.setvalue(Qc.fieldbyname('movc_pesoi').AsCurrency);
     bmontacarga.Enabled:=true;
   end;
   }

   EdTara.text:=FGeral.Formatavalor( EdTran_codigo.ResultFind.FieldByName('tran_pesomaximo').AsCurrency,f_cr);

end;

procedure TFMontaCargaCte.ConfiguraTeclas(Key: Word);
begin
 if key = vk_f4 then bmontacargaClick(self)
 else if (key = vk_f5) and (xop='V') then bgeranfesClick(self)
 else if key = vk_f6 then bsairClick(self)

end;

procedure TFMontaCargaCte.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);
end;

procedure TFMontaCargaCte.bSairClick(Sender: TObject);
begin
   Close;
end;

procedure TFMontaCargaCte.APHeadLabel1Click(Sender: TObject);
begin

end;

// 04.07.16
// 04.07.16
// 14.02.18
procedure TFMontaCargaCte.bdesmarcatodosClick(Sender: TObject);
////////////////////////////////////////////////////////////
var x:integer;
begin
  for x:=0 to Grid.rowcount do begin
    if trim( Grid.cells[Grid.getcolumn('moes_numerodoc'),x] ) <> '' then begin
        Grid.cells[Grid.getcolumn('marcado'),x]:='';
    end;
  end;
  EdNumeronotas.Clear;
  EdPesoNotas.Clear;
end;

procedure TFMontaCargaCte.bgeranfesClick(Sender: TObject);
//////////////////////////////////////////////////////////
var p:integer;
    QPedido,QNfe:TSqlquery;
    sqlaberto,sqlwhere,sqldata:string;
begin

   if not ChecagemdePeso then exit;
   if EdPesofinal.ascurrency=0 then begin
     Avisoerro('Falta o peso final');
     exit;
   end;
   QNfe:=sqltoquery('select moes_transacao,moes_numerodoc from movesto where moes_carga='+Qc.fieldbyname('movc_numero').asstring+
                    ' and moes_status = ''N'' and moes_unid_codigo = '+EdUNid_codigo.AsSql);
   if not QNfe.eof then begin
     Avisoerro('Carga j� faturada na transa��o '+QNfe.fieldbyname('moes_transacao').asstring+' NFe '+QNFe.fieldbyname('moes_numerodoc').asstring);
     FGeral.Fechaquery(QNFe);
     exit;
   end;
   FGeral.Fechaquery(QNFe);
   if not confirma('Confirma emiss�o das nf-e ?') then exit;
   p:=1;
// aqui ira percorrer o grid de pedidos gerando uma nf-e para cada pedido
   if Strtointdef(Grid.cells[Grid.getcolumn('moes_numerodoc'),p],0)>0 then begin
     sqlaberto:=' and '+Fgeral.getin('mped_situacao','P;A','C');
     sqlwhere:=' where '+FGEral.getin('mpdd_status','N;','C')+' and mpdd_numerodoc='+Grid.cells[Grid.getcolumn('moes_numerodoc'),p];
     sqldata:=' and mped_dataemissao >= '+EdInicio.assql;
     QPedido:=sqltoquery('select * from movpeddet inner join movped on ( mped_transacao=mpdd_transacao )'+
                         ' inner join estoque on ( esto_codigo = mpdd_esto_codigo )'+
                         sqlwhere+
                         sqlaberto+sqldata+
                         ' and mped_unid_codigo = '+EdUnid_codigo.assql+
                         ' order by mped_datamvto,mpdd_numerodoc,mpdd_seq');
// pra prever 'pedidos de terceiros'
     if DAtetoano(QPedido.FieldByName('mped_datacont').asdatetime,true ) > 1921 then
       Sistema.BeginProcess('Gerando NFe referente pedido '+Grid.cells[Grid.getcolumn('moes_numerodoc'),p]);
       FNotaSaida.Execute('H','N',Fgeral.GetConfig1AsInteger('ConfMovAbate'),Strtoint(Grid.cells[Grid.getcolumn('moes_numerodoc'),p]),
                     Strtoint(Grid.cells[Grid.getcolumn('moes_tipo_codigo'),p]),QPedido.fieldbyname('mped_fpgt_codigo').asstring,EdTran_codigo.text,
                     QPedido.fieldbyname('mped_port_codigo').asstring,Texttovalor(Grid.cells[Grid.getcolumn('moes_vlrtotal'),p]),Qc.fieldbyname('movc_cola_codigo01').asstring,Qc.fieldbyname('movc_numero').asinteger);
   end;
   Sistema.endprocess('Notas Geradas');
end;

// 04.07.16
function TFMontaCargaCte.ChecagemdePeso: boolean;
///////////////////////////////////////////////
var dif,tolerancia:currency;
begin
   dif:=abs(EdDif.ascurrency-EdPesoNotas.ascurrency);
   tolerancia:=EdDif.AsCurrency * (FGeral.GetConfig1AsFloat( 'pertolerbavendas' )/100 );
   if (dif > tolerancia) and (tolerancia>0) then begin
     if FGeral.GetConfig1AsString('libcaminhao') <> 'S' then begin

       Avisoerro('Diferen�a de Peso acima do permitido');
       result:=false;
       exit;

     end else begin

       Aviso('Aten��o.  Diferen�a de Peso acima do permitido');
       result:=true;

     end;

   end else result:=true;
end;

end.

