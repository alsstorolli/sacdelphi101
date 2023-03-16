unit boletos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SqlDtg, StdCtrls, Mask, SQLEd, Buttons,
  SQLBtn, alabel, ExtCtrls, SQLGrid, uFreeBoletoImage, uFreeBoleto, Sqlexpr, TypInfo,
//  UFuncAux, GbCobranca ;
//  gbCob341, gbCobranca ,gbCob001, gbcob422 , gbcob237,
  UFuncAux, ACBrBoleto, ACBrBase,
//   ACBrBoletoFCQuickFr,
  DB, DBClient,
  SimpleDS, SqlSis ;
//  gbcob748
//  gbcob756 ;
//, gbcob104

type
  TFBoletos = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bimprimir: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    bmarcatodos: TSQLBtn;
    bdesmarcatodos: TSQLBtn;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdDtinicio: TSQLEd;
    EdDtFim: TSQLEd;
    Edcheq_repr_codigo: TSQLEd;
    SetEdRepr_nome: TSQLEd;
    PCheques: TSQLPanelGrid;
    GridPedidos: TSqlDtGrid;
    Edtotalmarcado: TSQLEd;
    EdValorpedidos: TSQLEd;
    EdCheq_bcoemitente: TSQLEd;
    EdPort_codigo: TSQLEd;
    Edbanco: TSQLEd;
    EdBanco_descricao: TSQLEd;
    EdCarteira: TSQLEd;
    bgeraremessa: TSQLBtn;
    Salvar: TSaveDialog;
    brelatorio: TSQLBtn;
    EdInstrucaoCob: TSQLEd;
    EdSoma: TSQLEd;
//    AcbrBoleto1: TACBrBoleto;
    TMovesto: TSQLDs;
    datas: TDataSource;
    BoletoImagem: TFreeBoletoImagem;
    ACBrBoleto1: TACBrBoleto;
///    ACBrBoletoFCQuick1: TACBrBoletoFCQuick;
    procedure EdDtFimValidate(Sender: TObject);
    procedure EdDtFimExitEdit(Sender: TObject);
    procedure bmarcatodosClick(Sender: TObject);
    procedure bdesmarcatodosClick(Sender: TObject);
    procedure EdbancoValidate(Sender: TObject);
    procedure bimprimirClick(Sender: TObject);
    procedure GridPedidosClick(Sender: TObject);
    procedure EdbancoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bgeraremessaClick(Sender: TObject);
    procedure brelatorioClick(Sender: TObject);
    procedure GridPedidosKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(unidade:string='';portador:string='';inicio:TDatetime=0;termino:TDatetime=0;ntransacao:string='');
    procedure ImprimeUmaNota(ntransacao:string);
    procedure CriaBoleto(Q:TSqlquery ; xCodigoBanco:string='' ; xNotasSomadas:string='');
    procedure SetaCarteira(EditCarteira:TSqled ; codigobanco:string);
    procedure GeraLista(Q:TSqlquery);
    function GetDigitoX(xbanco,xnumero:string):string;
    procedure SetaInstrucaoCobranca(xEd:TSqled);
  end;

var
  FBoletos: TFBoletos;
  sqlaberto,sqldeposito,sqldata,sqlunidades,sqldatacont,sqlportador,xtransacao,
  ondesalvar,faixai,faixaf,NotasSomadas:string;
  Chequesmarcados,TamAgencia:integer;
  QBanco:TSqlquery;
  B:TFreeBoleto;
//  B:TAcbrBoleto;
  Titulo:TAcbrTitulo;
  GeracaoRemessa:boolean;

implementation


uses Geral, Sqlfun, Unidades, munic, Emitentes, Cadcheq, plano,
  nfsaida, SQLRel, portador, StrUtils;

{$R *.dfm}

    function UltimoDigito(s:string):Char;
    var i:integer;
    begin
      result:='0';
      for i:=1 to length(s) do begin
        if s[i]<>'' then
          result:=s[i];
      end;

    end;



procedure CloneProperties(SourceComp, DestComp: TObject);
///////////////////////////////////////////////////////////
var
  Propinfo: PPropInfo;
  Properties: PPropList;
  FCount: Integer;
  FSize: Integer;
  i: Integer;
  PropName: String;
  SourcePropObject: TObject;
  DestPropObject: TObject;

begin
/////////////////////////////////////////////
  FCount := GetPropList(SourceComp.ClassInfo, tkAny, nil);
  FSize := FCount * SizeOf(Pointer);
  GetMem(Properties, FSize);
  GetPropList(SourceComp.ClassInfo, tkAny, Properties);
  for i := 0 to FCount-1 do
  begin
    PropName := Properties^[i].Name;
    PropInfo := GetPropInfo(DestComp.ClassInfo, PropName);
    if (PropInfo = nil) or (UpperCase(PropName) = 'NAME') then
      Continue;
    case PropType(SourceComp, PropName) of
      tkInteger,
      tkWChar,
      tkSet,
      tkChar        : SetOrdProp(DestComp,PropName,GetOrdProp(SourceComp,PropName));
      tkString,
      tkLString,
// 11.02.17
      tkUString,
      tkWString     : SetStrProp(DestComp,PropName,GetStrProp(SourceComp,PropName));
      tkEnumeration : SetEnumProp(DestComp,PropName,GetEnumProp(SourceComp,PropName));
      tkFloat       : SetFloatProp(DestComp,PropName,GetFloatProp(SourceComp,PropName));
      tkClass       : begin
                        SourcePropObject := GetObjectProp(SourceComp,PropName);
                        DestPropObject := GetObjectProp(DestComp,PropName);
                        if (SourcePropObject<>nil) and (DestPropObject<>nil)
                        and (SourcePropObject.ClassType.ClassParent.ClassName='TPersistent') then
                          CloneProperties(SourcePropObject,DestPropObject)
                        else
                          SetObjectProp(DestComp,PropName,GetObjectProp(SourceComp,PropName));
                      end;
    else
      Avisoerro('Tipo de variável não encontrado');
    end
  end;
  if Properties <> nil then
    FreeMem(Properties, FSize);
end;

procedure TFBoletos.EdDtFimValidate(Sender: TObject);
begin
  if EdDtfim.asdate<EdDtinicio.asdate then
    EdDtfim.Invalid('Data final tem que ser maior que inicial');

end;

procedure TFBoletos.EdDtFimExitEdit(Sender: TObject);
var QPedidos:TMemoryQuery;
    SqlOrder:string;

    procedure ChequestoGrid;
    ////////////////////////
    var  ListaPedidos:TStringlist;
         x:integer;
         vlrpedidos:currency;
    begin
       vlrpedidos:=0;
       GridPedidos.clear;
       ListaPedidos:=TStringlist.create;
       x:=1;
       while not QPedidos.eof do begin
             ListaPedidos.add(Qpedidos.fieldbyname('pend_transacao').asstring);
             GridPedidos.cells[GridPedidos.getcolumn('pend_Numerodcto'),x]:=QPedidos.fieldbyname('pend_numerodcto').asstring;
             GridPedidos.cells[GridPedidos.getcolumn('pend_tipo_codigo'),x]:=QPedidos.fieldbyname('pend_tipo_codigo').asstring;
//             GridPedidos.cells[GridPedidos.getcolumn('clie_descricao'),x]:=QPedidos.fieldbyname('clie_razaosocial').asstring;
// 23.09.11
             GridPedidos.cells[GridPedidos.getcolumn('clie_descricao'),x]:=FGeral.GetNomeRazaoSocialEntidade( QPedidos.fieldbyname('pend_tipo_codigo').asinteger,QPedidos.fieldbyname('pend_tipocad').asstring,'R') ;
             GridPedidos.cells[GridPedidos.getcolumn('pend_dataemissao'),x]:=FGeral.FormataData( QPedidos.fieldbyname('pend_dataemissao').asdatetime );
             GridPedidos.cells[GridPedidos.getcolumn('pend_datavcto'),x]:=formatdatetime('dd/mm/yy',QPedidos.fieldbyname('pend_datavcto').asdatetime);
             GridPedidos.cells[GridPedidos.getcolumn('pend_valor'),x]:=floattostr(QPedidos.fieldbyname('pend_valor').asfloat);
//             GridPedidos.cells[GridPedidos.getcolumn('pend_transacao'),x]:=QPedidos.fieldbyname('pend_transacao').asstring;
             GridPedidos.cells[GridPedidos.getcolumn('pend_operacao'),x]:=QPedidos.fieldbyname('pend_operacao').asstring;
             inc(x);
             vlrpedidos:=vlrpedidos+QPedidos.fieldbyname('pend_valor').asfloat;
             GridPedidos.AppendRow;
         EdValorpedidos.setvalue(vlrpedidos);
         QPedidos.next;
       end;


    end;


begin
//////////////////
    GridPedidos.clear;
    GridPedidos.setfocus;
    Edtotalmarcado.setvalue(0);
    Sistema.Beginprocess('Lendo documentos no periodo');
    sqlaberto:=' and pend_rp=''R''';
    sqldeposito:='';
//    sqldata:=' and cheq_emissao >= '+Datetosql(Sistema.hoje-60);
//    sqldata:=' and cheq_emissao >='+EdDtinicio.assql+' and cheq_emissao <='+EdDtfim.assql;
    sqldata:=' and pend_dataemissao >='+EdDtinicio.assql+' and pend_dataemissao <='+EdDtfim.assql;
    sqlunidades:=' and '+FGeral.Getin('pend_unid_codigo',EdUnid_codigo.text,'C');
// 16.04.14 - Metallum - Fran
    if Global.Usuario.OutrosAcessos[0721] then
        sqldatacont:=''
    else
      sqldatacont:=' and pend_datacont > '+DatetoSql(Global.DataMenorBanco);
    sqlportador:=' and pend_port_codigo='+EdPort_codigo.assql;
    sqlorder:=' order by pend_numerodcto,pend_datavcto';
// 04.08.11
    if QBanco.FieldByName('Plan_codigobanco').asstring='748' then
      sqlorder:=' order by pend_lotecnab';

    if EdPort_codigo.isempty then
      sqlportador:='';
    if trim(xtransacao)<>'' then
      QPedidos:=sqltomemoryquery('select * from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
                ' where pend_status=''N'''+
                ' and '+FGeral.GetIn('pend_tipocad','C;F','C')+
                ' and pend_transacao='+stringtosql(xtransacao)+
                ' and pend_status<>''C'' order by pend_datavcto')
    else
      QPedidos:=sqltomemoryquery('select * from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
                   ' where pend_status=''N'''+
//                   ' and pend_tipocad=''C'''+
// 28.09.11 - Novi - Elize - devolução de compra total ou parcial
                  ' and '+FGeral.GetIn('pend_tipocad','C;F','C')+
                   sqlportador+
                   sqldatacont+sqlaberto+sqldata+sqlunidades+sqldeposito+
                   sqlorder );
//                   ' order by cheq_emissao');
    if QPedidos.eof then begin
      Avisoerro('Não encontrado documentos em aberto no periodo');
      EdDtfim.setfocus;
    end else begin
      ChequestoGrid;
      bmarcatodosclick(self);
    end;

    Sistema.endprocess('');

end;

procedure TFBoletos.bmarcatodosClick(Sender: TObject);
var x:integer;
begin
  for x:=0 to GridPedidos.rowcount do begin
    if trim( GridPedidos.cells[GridPedidos.getcolumn('pend_numerodcto'),x] ) <> '' then begin
        GridPedidos.cells[GridPedidos.getcolumn('marcado'),x]:='Ok';
        inc(Chequesmarcados)
    end;
  end;
  Edtotalmarcado.setvalue(EdValorpedidos.ascurrency);

end;

procedure TFBoletos.bdesmarcatodosClick(Sender: TObject);
var x:integer;
begin
  for x:=0 to GridPedidos.rowcount do begin
    if trim( GridPedidos.cells[GridPedidos.getcolumn('pend_numerodcto'),x] ) <> '' then begin
        GridPedidos.cells[GridPedidos.getcolumn('marcado'),x]:='';
    end;
  end;
  Edtotalmarcado.setvalue(0);
  Chequesmarcados:=0;

end;

procedure TFBoletos.Execute(unidade:string='';portador:string='';inicio:TDatetime=0;termino:TDatetime=0;ntransacao:string='');
//////////////////////////////////////////////////////////////////////////////////////////////////////////
var Lista:TStringlist;
    p:integer;
begin

   FGeral.ConfiguraColorEditsNaoEnabled(FBoletos);
   FGeral.EstiloForm(FBoletos);
//   if FindWindow( PAnsiChar('TForm'),Pansichar('FNotaSaida') ) >0 then
//     FNotaSaida.SendToBack;
/////////////   AcbrBoletofcfr1.ACBrBoleto:=Acbrboleto1;
   Show;

   xtransacao:='';
   if trim(ntransacao)<>'' then
     xtransacao:=ntransacao;

   if EdDtinicio.isempty then
     EdDtinicio.setdate(sistema.hoje);
   if EdDtFim.isempty then
     EdDtFim.setdate(sistema.hoje);
   if inicio>0 then
     EdDtinicio.setdate(inicio);
   if termino>0 then
     EdDtfim.setdate(termino);
   FPlano.SetaItems(EdBanco,EdBanco_descricao,'B','','','S');
   FUnidades.SetaItems(EdUnid_codigo,SetEdUNid_nome,Global.Usuario.UnidadesMvto);
   b:=TFreeBoleto.Create(Self);
//   b:=TAcbrBoleto.Create(Self);
//   FBoletos.FormStyle:=fsStayontop;
   if trim(unidade)<>'' then begin
     EdUnid_codigo.Text:=unidade;
     EdUnid_codigo.ValidFind;
     EdBanco.setfocus;
   end else
     EdUnid_codigo.setfocus;
   GridPedidos.Clear;
   if trim(portador)<>'' then begin
     EdPort_codigo.Text:=portador;
     EdPort_codigo.validfind;
   end;
   if trim(Fgeral.Getconfig1asstring('Portaboletos'))<>'' then begin
     EdPort_codigo.ShowForm:='';
     Lista:=TStringList.Create;
     strtolista(Lista,Fgeral.Getconfig1asstring('Portaboletos'),';',true);
     EdPort_codigo.Items.Clear;
     if Lista.count=1 then begin
       EdPort_codigo.Text:=Lista[0];
     end else begin
       for p:=0 to Lista.count-1 do begin
         if trim(Lista[p])<>'' then
           EdPort_codigo.Items.Add(Lista[p]+' - '+FPortadores.GetDescricao(Lista[p]) );
       end;
     end;
   end else begin
     EdPort_codigo.ShowForm:='FPortadores';
     EdPort_codigo.Items.Clear;
   end;
// 10.06.10
   TamAgencia:=4;
end;

procedure TFBoletos.EdbancoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
//   sqled1.text:=FCadcheques.GetNomeBanco(Edbanco.text,Edbanco);
 QBanco:=sqltoquery('select * from plano where plan_conta='+EdBanco.assql);
 faixai:='';
 faixaf:='';
 GridPedidos.CanFind:=true;
 if not QBanco.eof then begin
    EdBanco_descricao.text:=QBanco.fieldbyname('plan_descricao').asstring;
    if trim(QBanco.fieldbyname('Plan_codigobanco').asstring)='' then
      EdBAnco.invalid('Codigo do Banco não configurado nas contas gerenciais')
    else
      SetaCarteira(EdCarteira,QBanco.fieldbyname('Plan_codigobanco').asstring);
// 02.02.11
    if trim(QBanco.fieldbyname('Plan_codigobanco').asstring)='422' then begin
//      faixai:='3530';
      faixaf:='3531';
      faixai:=inttostr( FGeral.GetContador('FAIXANNUM'+QBanco.fieldbyname('Plan_codigobanco').asstring,false,false) );
      if strtoint(faixai)<3530 then faixai:='3530';
    end else if trim(QBanco.fieldbyname('Plan_codigobanco').asstring)='748' then begin
      GridPedidos.CanFind:=false;
    end;
 end else
    EdBAnco.invalid('Banco não encontrado');

end;

procedure TFBoletos.bimprimirClick(Sender: TObject);
//////////////////////////////////////////////////////////
var p:integer;
    op:string;
    Q:TSqlquery;
    x:TFreeBoleto;
//    x:TAcbrBoleto;
    ListaNotas:TStringList;

begin

  BoletoImagem.ListaBoletos.clear;
  GeracaoRemessa:=false;
  NotasSomadas:='Notas : ';
  ListaNotas:=TStringList.create;
  ACbrboleto1.ListadeBoletos.Clear;
  for p:=1 to GridPedidos.RowCount do begin
    op:=GridPedidos.Cells[GridPedidos.getcolumn('pend_operacao'),p];
    if (trim(op)<>'') and (trim(GridPedidos.Cells[GridPedidos.getcolumn('marcado'),p])<>'') then begin
        Q:=sqltoquery('select * from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
                     ' where pend_status=''N'''+
                     ' and '+FGeral.GetIN('pend_tipocad','C;F','C')+
                     ' and pend_operacao='+stringtosql(op));
        if not Q.eof then begin
// 25.03.14
          if EdSoma.text='S' then begin
            if ListaNotas.IndexOf(Q.fieldbyname('pend_numerodcto').AsString)=-1 then
              NotasSomadas:=NotasSomadas+Q.fieldbyname('pend_numerodcto').AsString+';';
          end else begin
//            if (EdCarteira.text='017') and (QBanco.fieldbyname('Plan_codigobanco').asstring='756') then
// 28.07.15 - simar
            if (EdCarteira.text='17') and (QBanco.fieldbyname('Plan_codigobanco').asstring='756') then
              CriaBoleto(Q,'001')
            else
              CriaBoleto(Q);
            x:=TFreeBoleto.create(nil);
            CloneProperties(b,x);
            BoletoImagem.ListaBoletos.Add(x);
// 11.02.17
//            BoletoImagem.ListaBoletos.Add(b);

          end;
        end;
        FGeral.FechaQuery(Q);
    end;
  end;
  ListaNotas.free;
  if EdSoma.text='S' then begin
    for p:=1 to GridPedidos.RowCount do begin
      op:=GridPedidos.Cells[GridPedidos.getcolumn('pend_operacao'),p];
      if (trim(op)<>'') and (trim(GridPedidos.Cells[GridPedidos.getcolumn('marcado'),p])<>'') then begin
         Q:=sqltoquery('select * from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
                       ' where pend_status=''N'''+
                       ' and '+FGeral.GetIN('pend_tipocad','C;F','C')+
                       ' and pend_operacao='+stringtosql(op));
         break;
      end;
    end;
// 02.04.14
//    if (EdCarteira.text='017') and (QBanco.fieldbyname('Plan_codigobanco').asstring='756') then
// 28.07.15 - simar
    if (EdCarteira.text='17') and (QBanco.fieldbyname('Plan_codigobanco').asstring='756') then
      CriaBoleto(Q,'001',NotasSomadas)
    else
      CriaBoleto(Q,'',NotasSomadas);

    x:=TFreeBoleto.create(nil);
    CloneProperties(b,x);
    BoletoImagem.ListaBoletos.Add(x);

  end;

// 16.03.11
//  if QBanco<>nil then                               // 26.08.14 - retirado 104 CEF - 22.11.14 recolocado
    if pos(QBanco.fieldbyname('Plan_codigobanco').asstring,'756;748;104;237')>0 then
      BoletoImagem.DrawLogotipo:=true;
// 16.03.11
  if QBanco.fieldbyname('Plan_codigobanco').asstring='422' then
//    FGeral.AlteraContador('FAIXANNUM'+B.Cedente.CodigoBanco,strtoint(faixai));
    FGeral.AlteraContador('FAIXANNUM'+QBanco.fieldbyname('Plan_codigobanco').asstring,strtoint(faixai));

   AcbrBoleto1.Cedente.Nome:=Ups(EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring);
   AcbrBoleto1.Cedente.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
   AcbrBoleto1.Cedente.ResponEmissao:=tbCliEmite;
   AcbrBoleto1.Cedente.Logradouro:=EdUnid_codigo.ResultFind.fieldbyname('unid_endereco').asstring;
// 04.03.15 para imprimir o tal 'posto do beneficiario'
//   if QBanco.fieldbyname('Plan_codigobanco').asstring='748' then
//     Acbrboleto1.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('Plan_agencia').asstring,6,2);



//   AcbrBoletofcfr1.Imprimir; - Fast
//   ACBrBoletoFCQuick1.Imprimir; - Quick

  Acbrboleto1.ListadeBoletos.Clear;

/////////  showmessage('codigo banco '+b.Cedente.CodigoBanco );

  BoletoImagem.ShowPreview;
  BoletoImagem.ListaBoletos.Clear;
  if x<>nil then x.Free;

end;

procedure TFBoletos.GridPedidosClick(Sender: TObject);
////////////////////////////////////////////////////////////////
var valor:currency;
begin
   if GridPedidos.col=GridPedidos.getcolumn('marcado') then begin
     valor:=texttovalor(GridPedidos.cells[GridPedidos.getcolumn('pend_valor'),GridPedidos.row]);
     if GridPedidos.cells[GridPedidos.getcolumn('marcado'),GridPedidos.row]='Ok' then begin
       GridPedidos.cells[GridPedidos.getcolumn('marcado'),GridPedidos.row]:='';
       if Edtotalmarcado.ascurrency>0 then begin
           Edtotalmarcado.setvalue( EdTotalmarcado.ascurrency - valor );
       end;
     end else begin
       GridPedidos.cells[GridPedidos.getcolumn('marcado'),GridPedidos.row]:='Ok';
       Edtotalmarcado.setvalue( EdTotalmarcado.ascurrency + valor );
     end;
   end;


end;

procedure TFBoletos.EdbancoKeyPress(Sender: TObject; var Key: Char);
begin
   FGeral.LimpaEdit(Edbanco,key);

end;

procedure TFBoletos.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if b<>nil then
    b.Free;
end;

procedure TFBoletos.ImprimeUmaNota(ntransacao: string);
begin
end;

//////////////////////////////////////////////////////////////////////////////////////
procedure TFBoletos.CriaBoleto(Q: TSqlquery ; xCodigoBanco:string='' ; xNotasSomadas:string='');
///////////////////////////////////////////////////////////////////////////////////////////////////
var NossoNumeroSafra,UnidadeCedente,Aux,DAtaatual:String;
    ContadorNossoNumero,numseq,FaixaNossoNumero:integer;
    QForne:TSqlquery;


    //////////////////////// 26.05.11
    procedure GravaSequencial( xoperacao,xbanco:string ; var  xnumseq:integer );
    //////////////////////////////////////////////////////////////////////////
    var QP:TSqlquery;
    begin
      Qp:=sqltoquery('select pend_lotecnab from pendencias where pend_operacao='+Stringtosql(xoperacao)+
                     ' and pend_status=''N''');
      xnumseq:=0;
      if not QP.Eof then begin
// so grava 'a primeira vez', ou seja, quando imprime o boleto para q na remessa fique
// o mesmo sequencial
        if Qp.fieldbyname('pend_lotecnab').asinteger=0 then begin
          xnumseq:=FGeral.GetContador('BOL'+xbanco+strzero(DatetoAno(Sistema.Hoje,true),4),false );
          Sistema.Edit('pendencias');
          Sistema.SetField('pend_lotecnab',xnumseq);
          Sistema.Post('pend_operacao='+Stringtosql(xoperacao)+' and pend_status=''N''');
          try
            Sistema.Commit;
          except
            Avisoerro('Problemas no banco.  Não foi possível gravar o sequencial da operação '+xoperacao);
            Application.Terminate;
          end;
        end else
          xnumseq:=Qp.fieldbyname('pend_lotecnab').asinteger;
      end;
      FGeral.FechaQuery(Qp);
    end;

///////////////////////////////////////
begin
///////////////////////////////////////
      B.LimparTudo;
      unidadecedente:=( FGeral.GetConfig1AsString('UNIDADECEDENTE') );

      AcbrBoleto1.Banco.ACBrBoleto.Cedente.Convenio:=QBanco.fieldbyname('plan_convenio').asstring;
      AcbrBoleto1.Banco.Numero:=strtointdef(QBanco.fieldbyname('plan_codigobanco').asstring,0);


      b.Cedente.CodigoBanco:=QBanco.fieldbyname('plan_codigobanco').asstring;
      b.Cedente.CodigoCedente:=QBanco.fieldbyname('plan_convenio').asstring;

      Titulo:=AcbrBoleto1.CriarTituloNaLista;

      Titulo.ACBrBoleto.Cedente.CodigoCedente:=QBanco.fieldbyname('plan_convenio').AsString;
      Titulo.ACBrBoleto.Cedente.Agencia:=QBanco.fieldbyname('plan_agencia').AsString;
      Titulo.ACBrBoleto.Cedente.Conta:=QBanco.fieldbyname('plan_contacorrente').AsString;
      Titulo.Acbrboleto.Cedente.ContaDigito := UltimoDigito(QBanco.fieldbyname('Plan_contacorrente').asstring);
      Titulo.Acbrboleto.Cedente.Modalidade :='';
      Titulo.DataDocumento:=Q.fieldbyname('pend_dataemissao').asdatetime;
      Titulo.TipoImpressao:=tipNormal;

      b.Cedente.Agencia:=QBanco.fieldbyname('plan_agencia').AsString;
      b.Cedente.ContaCorrente:=QBanco.fieldbyname('plan_contacorrente').AsString;
      b.Cedente.DigitoContaCorrente := UltimoDigito(QBanco.fieldbyname('Plan_contacorrente').asstring);
      b.DataDocumento:=Q.fieldbyname('pend_dataemissao').asdatetime;
// 24.04.15
        b.Cedente.Nome:=ups(EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring);
        b.Cedente.Endereco:=EdUnid_codigo.ResultFind.fieldbyname('unid_endereco').asstring;
        b.Cedente.Cep:=EdUnid_codigo.ResultFind.fieldbyname('unid_cep').asstring;
        b.Cedente.Cidade:=EdUnid_codigo.ResultFind.fieldbyname('Unid_municipio').asstring;
        b.Cedente.Uf:=EdUnid_codigo.ResultFind.fieldbyname('Unid_uf').asstring;
////////////////////////////
// 10.08.16
      Titulo.Referencia:=Q.fieldbyname('pend_operacao').asstring;

      if QBanco.fieldbyname('Plan_codigobanco').asstring='341' then begin

        B.carteira := FBoletos.edCarteira.text; //
        B.LocalPagamento:='Até o Vencimento, Preferencialmente no ITAU, Após SOMENTE no Itau';
        b.aceite:='S';

        Acbrboleto1.Banco.TipoCobranca:=cobItau;
        Titulo.carteira := FBoletos.edCarteira.text; //
        Titulo.LocalPagamento:='Até o Vencimento, Preferencialmente no ITAU, Após SOMENTE no Itau';
        Titulo.Aceite:=atsim;
        b.Especie:='R$';
        b.EspecieDoc:='DMI';
        if Titulo.Carteira='112' then
          Titulo.EspecieDoc:='DMI';
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          B.Instrucoes.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000))+' ao dia');
// 19.06.10
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));

        B.Instrucoes.Add('Sujeito a protesto se não for pago no vencimento');
        B.Instrucoes.Add('Cobrança Escritural');
        B.Instrucoes.Add('Apos vcto acesse www.itau.com.br/boletos para atualizar seu boleto');
//        B.Mensagem.Add('Apos vcto acesse www.itau.com.br/boletos para atualizar seu boleto');

        b.Cedente.CodigoCedente :=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5) ;
        B.Cedente.ContaCorrente:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5)  ;
//        b.Cedente.Nome:=EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring;
// 23.04.15
        b.Cedente.Nome:=EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring;
        b.Cedente.Endereco:=EdUnid_codigo.ResultFind.fieldbyname('unid_endereco').asstring;
        b.Cedente.Cep:=EdUnid_codigo.ResultFind.fieldbyname('unid_cep').asstring;
        b.Cedente.Cidade:=EdUnid_codigo.ResultFind.fieldbyname('Unid_municipio').asstring;
        b.Cedente.Uf:=EdUnid_codigo.ResultFind.fieldbyname('Unid_uf').asstring;
        b.Cedente.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
        b.NossoNumero := Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring;

        Titulo.NossoNumero := Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring;
        Titulo.NumeroDocumento := Q.fieldbyname('pend_numerodcto').asstring;

        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          Titulo.Mensagem.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
//        B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*0.02));
// 19.06.10
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          Titulo.Mensagem.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));

          Titulo.Mensagem.Add('Sujeito a protesto se não for pago no vencimento');
          Titulo.Mensagem.Add('Cobrança Escritural');
          Titulo.Mensagem.Add('');
          Titulo.Mensagem.Add('Apos vcto acesse www.itau.com.br/boletos para atualizar seu boleto');

// 07.06.10 - Novicarnes - Elize
///////////////////////////////////////
      end else if ( QBanco.fieldbyname('Plan_codigobanco').asstring='001' ) or
                  (   ( QBanco.fieldbyname('Plan_codigobanco').asstring='756' ) and (EdCArteira.text='17' ) )
        then begin

////////////////////////////////////////////////////////////////
        B.carteira := FBoletos.edCarteira.text; // na remessa tem 2 digitos 017=17
        B.LocalPagamento:='Pagável em Qualquer Banco até o Vencimento';
        B.Aceite:='N';
        B.EspecieDoc:='DM';
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          B.Instrucoes.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
//        B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*0.02));
// 19.06.10
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
//          B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,roundvalor( Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100) ) ));
//        B.Instrucoes.Add('Sujeito a protesto se não for pago no vencimento');
// 19.10.13 - Simar  - Irma
        B.Instrucoes.Add('Protestar após 5 dias do vencimento');
// 02.07.13 - Simar
        B.Instrucoes.Add(Q.fieldbyname('pend_complemento').asstring);
// 26.03.14 - Simar
        if trim(xNotasSomadas)<>'' then begin
          B.Instrucoes.Add(xNotasSomadas);
          b.NossoNumero :=strzero( strtoint(Q.fieldbyname('pend_numerodcto').asstring+
                                 Q.fieldbyname('pend_parcela').asstring),07);
        end else
// 29.08.12
          b.NossoNumero :=strzero( strtoint(Q.fieldbyname('pend_numerodcto').asstring+
                                 Q.fieldbyname('pend_parcela').asstring),07);

        B.Cedente.CodigoBanco :=QBanco.fieldbyname('Plan_codigobanco').asstring ;
        B.Cedente.Cnpjcpf:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
        if ( QBanco.fieldbyname('Plan_codigobanco').asstring='756' ) and (EdCArteira.text='17' ) then begin
          B.Cedente.Nome:='VIDE CAMPO SACADOR/AVALISTA ABAIXO';
          B.Cedente.Endereco:='';
          B.Cedente.Avalista:=Ups(EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring);
          Titulo.Sacado.SacadoAvalista.Pessoa:=pJuridica;
          Titulo.Sacado.SacadoAvalista.NomeAvalista:=Ups(EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring);
          Titulo.Sacado.SacadoAvalista.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
        end else begin
          B.Cedente.Nome:=EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring;
        end;
        B.Cedente.Agencia:=copy(QBanco.fieldbyname('Plan_agencia').asstring,1,5);
// 17.04.13
        if trim( uniDADECEDENTE ) <> '' then begin
          FaixaNossonumero:=500000000;   // fixo por enquanto
          b.Cedente.Nome:=FUnidades.GetNome(uniDADECEDENTE);
          GravaSequencial( Q.fieldbyname('Pend_operacao').asstring , QBanco.fieldbyname('Plan_codigobanco').asstring,numseq );
          b.NossoNumero := strzero( FaixaNossoNumero+numseq,10);
        end;
        if Q.fieldbyname('clie_tipo').asstring='F' then begin
//          B.Sacado.Pessoa:=pfisica;
          Titulo.Sacado.Pessoa:=pfisica;
        end else begin
//          B.Sacado.Pessoa:=pjuridica;
          Titulo.Sacado.Pessoa:=pjuridica;
        end;
////////////////////////////////////////////
        Titulo.carteira := FBoletos.edCarteira.text; // na remessa tem 2 digitos 017=17
        Titulo.LocalPagamento:='Pagável em Qualquer Banco até o Vencimento';
        Titulo.Aceite:=atnao;
        Titulo.EspecieDoc:='DM';
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          Titulo.Mensagem.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
//        B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*0.02));
// 19.06.10
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          Titulo.Mensagem.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
//          B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,roundvalor( Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100) ) ));
//        B.Instrucoes.Add('Sujeito a protesto se não for pago no vencimento');
// 19.10.13 - Simar  - Irma
        Titulo.Mensagem.Add('Protestar após 5 dias do vencimento');
// 02.07.13 - Simar
        Titulo.Mensagem.Add(Q.fieldbyname('pend_complemento').asstring);

// 26.03.14 - Simar
        if trim(xNotasSomadas)<>'' then begin
          Titulo.Mensagem.Add(xNotasSomadas);
//          Titulo.NossoNumero :=strzero( strtoint(trim(Q.fieldbyname('pend_numerodcto').asstring)+
//                                 Q.fieldbyname('pend_parcela').asstring),07);
// 16.12.15
          Titulo.NossoNumero :=PAdl(Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring,07,'0')
        end else
//          Titulo.NossoNumero :=strzero( strtoint(trim(Q.fieldbyname('pend_numerodcto').asstring)+
//                                 Q.fieldbyname('pend_parcela').asstring),07);
          Titulo.NossoNumero :=PAdl(Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring,07,'0');
        Titulo.ACBrBoleto.Cedente.Nome:='VIDE CAMPO SACADOR/AVALISTA ABAIXO';
        if trim( uniDADECEDENTE ) <> '' then begin
          FaixaNossonumero:=500000000;   // fixo por enquanto
          Titulo.ACBrBoleto.Cedente.Nome:=FUnidades.GetNome(uniDADECEDENTE);
          GravaSequencial( Q.fieldbyname('Pend_operacao').asstring , QBanco.fieldbyname('Plan_codigobanco').asstring,numseq );
          Titulo.NossoNumero := strzero( FaixaNossoNumero+numseq,10);
        end;

        Titulo.ACBrBoleto.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,4);
        Titulo.ACBrBoleto.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('plan_agencia').AsString,5,1);

        if QBanco.fieldbyname('Plan_codigobanco').asstring='756'  then begin
////////// 15.09.15
          if trim(xcodigobanco)<>'' then B.Cedente.CodigoBanco := xcodigobanco;
//          if B.Carteira='017' then  b.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring;
//////////
          B.Cedente.CodigoCedente :=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1, 5) ;
          B.Cedente.ContaCorrente:=padl(copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5),8,'0') ;
          Titulo.Acbrboleto.Cedente.CodigoCedente :=copy(QBanco.fieldbyname('Plan_convenio').asstring,7,6) ;
          Titulo.Acbrboleto.Cedente.Conta:=padl(copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5),8,'0') ;
          Titulo.Acbrboleto.Cedente.Modalidade:='01';   // - simples com registro
          Acbrboleto1.Banco.TipoCobranca:=cobBancoob
        end else begin
          Acbrboleto1.Banco.TipoCobranca:=cobBancoDoBrasil;
          Titulo.Acbrboleto.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring ;
          Titulo.Acbrboleto.Cedente.Conta:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5) ;
          B.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring ;
          B.Cedente.ContaCorrente:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5) ;
        end;


// 28.09.10 - Clessi - CEF
////////////////////////////
      end else if QBanco.fieldbyname('Plan_codigobanco').asstring='104' then begin
/////////////////////////////////////////////////////////////////////////////////////////////////////
// para impressao com freeboleto

        if pos( copy(FBoletos.edCarteira.text,1,1) ,'S;C;R')>0 then
          B.carteira := trim(FBoletos.edCarteira.text)
        else
          B.carteira := copy(FBoletos.edCarteira.text,3,1); // tem 1 digito
        B.EspecieDoc:='DM';
        B.LocalPagamento:='PREFERENCIALMENTE NAS CASAS LOTÉRICAS ATÉ O VALOR LIMITE';
//        B.Instrucoes.Add('Todas as informações deste bloqueto são de exclusiva responsabilidade do cedente');
// 30.03.11 - email retorno CEF..sem comentário
//        B.Instrucoes.Add('(Todas as informações deste bloqueto são de exclusiva responsabilidade do cedente)');
// 20.08.14
        B.Instrucoes.Add('');
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          B.Instrucoes.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
        B.Instrucoes.Add('Não receber após 30 dias de atraso');
        if FGeral.GetConfig1AsInteger('DIASVENBOLETO')>0 then
          B.Instrucoes.Add('Sujeito a protesto após '+inttostr(FGeral.GetConfig1AsInteger('DIASVENBOLETO'))+' dias do vencimento')
        else
          B.Instrucoes.Add('Sujeito a protesto se não for pago no vencimento');
//
//        B.Instrucoes.Add('SAC CAIXA: 0800 726 0101 (informações, reclamações, sugestões e elogios)');
//        B.Instrucoes.Add('Para pessoas com deficiência auditiva ou de fala: 0800 726 2492');
//        B.Instrucoes.Add('Ouvidoria: 0800 725 7474 - caixa.gov.br');

//////////////////////////////////////////////////////////////////////
        Titulo.ACBrBoleto.Banco.TamanhoMaximoNossoNum:=15;

        if pos( copy(FBoletos.edCarteira.text,1,1) ,'S;C;R')>0 then
          Titulo.carteira := trim(FBoletos.edCarteira.text)
        else
          Titulo.carteira := copy(FBoletos.edCarteira.text,3,1); // tem 1 digito
        Titulo.EspecieDoc:='DM';
        Titulo.LocalPagamento:='PREFERENCIALMENTE NAS CASAS LOTÉRICAS ATÉ O VALOR LIMITE';
//        B.Instrucoes.Add('Todas as informações deste bloqueto são de exclusiva responsabilidade do cedente');
// 30.03.11 - email retorno CEF..sem comentário
//        B.Instrucoes.Add('(Todas as informações deste bloqueto são de exclusiva responsabilidade do cedente)');
// 20.08.14
        Titulo.Mensagem.Add('');
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          Titulo.Mensagem.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          Titulo.Mensagem.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
        Titulo.Mensagem.Add('Não receber após 30 dias de atraso');
        if FGeral.GetConfig1AsInteger('DIASVENBOLETO')>0 then
          Titulo.Mensagem.Add('Sujeito a protesto após '+inttostr(FGeral.GetConfig1AsInteger('DIASVENBOLETO'))+' dias do vencimento')
        else
          Titulo.Mensagem.Add('Sujeito a protesto se não for pago no vencimento');
        Titulo.ACBrBoleto.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,4);
        Titulo.ACBrBoleto.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('plan_agencia').AsString,5,1);

        B.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring ;
        B.Cedente.ContaCorrente:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,6) ;
        B.Cedente.CodigoBanco :=QBanco.fieldbyname('Plan_codigobanco').asstring ;
        B.Cedente.Cnpjcpf:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
        B.Cedente.Nome:=EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring;
        B.Cedente.Agencia:=QBanco.fieldbyname('Plan_agencia').asstring;

        B.NossoNumero := strzero(Datetoano(Q.fieldbyname('pend_dataemissao').asdatetime,true),4)+Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring;
        B.Documento := Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring;

        Titulo.ACBrBoleto.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring ;
        Titulo.ACBrBoleto.Cedente.Conta:=strzero( strtoint(QBanco.fieldbyname('Plan_contacorrente').asstring) ,6)  ;

        Titulo.NossoNumero := strzero(Datetoano(Q.fieldbyname('pend_dataemissao').asdatetime,true),4)+Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring;
        Titulo.NumeroDocumento := Q.fieldbyname('pend_numerodcto').asstring+'/'+Q.fieldbyname('pend_parcela').asstring;
        Acbrboleto1.Banco.TipoCobranca:=cobCaixaEconomica;

/////////////////////////////////////////////////////////////////////////////////////////////////////

// 08.11.10 - Novicarnes - Elize - banco safra
      end else if QBanco.fieldbyname('Plan_codigobanco').asstring='422' then begin
/////////////////////////////////////////////////////////////////////////////////////////////////////
{
        B.carteira := copy(FBoletos.edCarteira.text,3,2); // na remessa tem 1 digitos 017=17
        B.LocalPagamento:='Pagável em Qualquer Banco até o Vencimento';
        B.Aceite:='S';
        B.EspecieDoc:='DM';
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          B.Instrucoes.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
//        B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*0.02));
// 19.06.10
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
//          B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,roundvalor( Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100) ) ));
        B.Instrucoes.Add('Sujeito a protesto se não for pago no vencimento');
//        B.Instrucoes.Add('Cobrança Escritural');
//        B.Instrucoes.Add('');
// 28.09.10 - Clessi - CEF
      end else begin
        B.LocalPagamento:='Até o Vencimento, Preferencialmente no Banco Emissor do Boleto';
        B.Aceite:='N';
      end;


      B.Cedente.Agencia :=QBanco.fieldbyname('Plan_agencia').asstring;
// 08.08.12 - Siccob - Brasil COM REGISTRO - Simar
      B.Cedente.CodigoBanco := QBanco.fieldbyname('Plan_codigobanco').asstring;
// 11.10.13
      B.Cedente.Nome := FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring;

      if trim(xcodigobanco)<>'' then B.Cedente.CodigoBanco := xcodigobanco;
      b.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_contacorrente').asstring;
//      if B.Carteira='17' then  b.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring;
//////////////
      B.Moeda := '9';  // ver se precisa criar campo ou configuracao
// 17.09.12
      if ( QBanco.fieldbyname('Plan_codigobanco').asstring='756' ) and (EdCArteira.text='017' ) then begin
//        B.Cedente.Avalista:=FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring;
// 21.01.15
        B.Cedente.Agencia :=copy(QBanco.fieldbyname('Plan_agencia').asstring,1,5);
        b.Cedente.CodigoCedente :=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,pos(';',QBanco.fieldbyname('Plan_contacorrente').asstring)-1);
      end else if trim( uniDADECEDENTE ) <> '' then begin
        B.Cedente.Nome := FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring;
// 15.05.13
//        B.Cedente.Avalista:=FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring;
// 21.01.15
      end;
////////////////////////////////////////
//      B.Cedente.CpfCnpj:=FormatoCgccpf( FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_cnpj').asstring );
// 21.01.15
      if pos(QBanco.fieldbyname('Plan_codigobanco').asstring,'341;001;748')>0 then begin
        B.Cedente.Nome := B.Cedente.Nome + ' CNPJ:' + FormatoCgccpf( FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_cnpj').asstring );
// 17.04.13
        if trim( uniDADECEDENTE ) <> '' then
          b.Cedente.Nome:=FUnidades.GetNome(uniDADECEDENTE)+ ' CNPJ:' + FormatoCgccpf( FUnidades.GetCnpjcpf( unidadecedente) );
      end;
// 27.01.14 - retirado
//      end else if ( pos(QBanco.fieldbyname('Plan_codigobanco').asstring,'237'])>0)  and (copy(FBoletos.edCarteira.text,2,2)='09') then
//        B.Cedente.Nome := 'BANCO SAFRA';

      B.DataDocumento := trunc(Q.fieldbyname('pend_dataemissao').asdatetime);
      B.Documento := Q.fieldbyname('pend_numerodcto').asstring;
// 02.07.09 - mudado somente o nosso numero
//      B.Documento := Q.fieldbyname('pend_numerodcto').asstring+'-'+Q.fieldbyname('pend_parcela').asstring+'/'+
//                     Q.fieldbyname('pend_nparcelas').asstring ;
      B.Vencimento := Q.fieldbyname('pend_datavcto').asdatetime;
//      b.Cedente.CodigoCedente :=FBoletos.EdUNid_codigo.text ;
// Ver configuracao  ou campo cadastro contas...
//      edCodCedente.text;
// 26.03.14 - Simar - varias nf num boleto
      if trim(xNotasSomadas)<>'' then
        b.Valor := EdTotalMarcado.ascurrency
      else
        b.Valor := Q.fieldbyname('pend_valor').ascurrency;

//      b.NossoNumero := Q.fieldbyname('pend_numerodcto').asstring;
      B.Cedente.ContaCorrente :=QBanco.fieldbyname('Plan_contacorrente').asstring;
//////////////////////////////// - BANCO ITAU
      if QBanco.fieldbyname('Plan_codigobanco').asstring='341' then begin
////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////


// 08.11.10 - Banco Safra
////////////////////////////////
      end  else if QBanco.fieldbyname('Plan_codigobanco').asstring='422' then begin
/////////////////////////////////////////////////////////////////////////////////////////////////////
{
//        b.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring ;
//        B.Cedente.ContaCorrente:=strzero( strtoint(QBanco.fieldbyname('Plan_contacorrente').asstring) ,6)  ;
        b.Cedente.CodigoCedente:=QBanco.fieldbyname('Plan_contacorrente').asstring;
        B.Cedente.ContaCorrente:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,6);
// 30.11.10
        B.Cedente.DigitoContaCorrente:=UltimoDigito(QBanco.fieldbyname('Plan_contacorrente').asstring);
// nosso numero de safra é 'fixo' '3819'+ 4 digitos
        if length( trim(Q.fieldbyname('pend_numerodcto').asstring) )=5 then
//          b.NossoNumero := '3819'+copy(Q.fieldbyname('pend_numerodcto').asstring,3,3)+Q.fieldbyname('pend_parcela').asstring
          b.NossoNumero := faixai+copy(Q.fieldbyname('pend_numerodcto').asstring,2,4)
        else
//          b.NossoNumero := '3819'+copy(Q.fieldbyname('pend_numerodcto').asstring,4,3)+Q.fieldbyname('pend_parcela').asstring;
          b.NossoNumero := faixai+copy(Q.fieldbyname('pend_numerodcto').asstring,3,4);
// 19.01.11 - 'repeticao de nosso numero devido a limitacao de 3 + 1 digitos deste banco
//          ContadorNossoNumero:=FGeral.GetContador('NOSSONUM'+QBanco.fieldbyname('Plan_codigobanco').asstring,false);
//          if ContadorNossoNumero>9999 then
//            FGeral.AlteraContador('NOSSONUM'+B.Cedente.CodigoBanco,1);
//          b.NossoNumero := '3819'+strzero(ContadorNossoNumero,4);

        B.Documento := Q.fieldbyname('pend_numerodcto').asstring+'/'+Q.fieldbyname('pend_parcela').asstring;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////

// 12.11.10 - Banco Bradesco - refeito em 01.07.15
////////////////////////////////
      end  else if QBanco.fieldbyname('Plan_codigobanco').asstring='237' then begin
/////////////////////////////////////////////////////////////////////////////////////////////////////

        B.carteira := FBoletos.edCarteira.text;
        B.LocalPagamento:='Pagável Preferencialmente na rede Bradesco ou no Bradesco expresso';
        B.Aceite:='N';
        B.EspecieDoc:='DM';
        B.Instrucoes.Add('Todas as informações deste bloqueto são de exclusiva responsabilidade do cedente');
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          B.Instrucoes.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
        B.Instrucoes.Add('Sujeito a protesto se não for pago no vencimento');
        b.Cedente.CodigoCedente:=padl( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,7),7,'0' ) ;
//        if b.carteira='09' then begin  // bradesco correspondente do safra
//          b.NossoNumero :=strzero(DatetoAno(Q.fieldbyname('pend_dataemissao').asdatetime,false) ,2 )+
//                         NossoNumeroSafra+GetDigito(NossoNumeroSafra,'MOD');
//          b.UsoDoBanco:='CIP130';
//          B.Cedente.ContaCorrente:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,7);
//        end else begin
        b.NossoNumero:= padl( Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring,11,'0');
        B.Cedente.ContaCorrente:=padl( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5),7,'0' );
        B.Cedente.Agencia:=copy(QBanco.fieldbyname('Plan_agencia').asstring,1,4);
//        end;
        B.Documento := PADL( Q.fieldbyname('pend_numerodcto').asstring+'/'+Q.fieldbyname('pend_parcela').asstring,11,'0');
        b.Cedente.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
////////////////////
        Acbrboleto1.Banco.TipoCobranca:=cobBradesco;
        Titulo.LocalPagamento:='Pagável em Qualquer Banco até o Vencimento. Após somente no Bradesco';
        Titulo.Aceite:=Atnao;
        Titulo.EspecieDoc:='DM';
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          Titulo.Mensagem.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          Titulo.Mensagem.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
        if FGeral.GetConfig1AsInteger('DIASVENBOLETO')>0 then
          Titulo.Mensagem.Add('Protestar após '+inttostr(FGeral.GetConfig1AsInteger('DIASVENBOLETO'))+' dias corridos do vencimento')
        else
          Titulo.Mensagem.Add('Sujeito a protesto se não for pago no vencimento');
//        Titulo.Carteira:=copy(FBoletos.edCarteira.text,1,1);
        Titulo.Carteira:=FBoletos.edCarteira.text;
        Titulo.NossoNumero :=padl( Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring,11,'0');
        Titulo.ACBrBoleto.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,4);
        Titulo.ACBrBoleto.Cedente.Conta:=padl( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5),7,'0' );
        Titulo.NumeroDocumento := PADL( Q.fieldbyname('pend_numerodcto').asstring+'/'+Q.fieldbyname('pend_parcela').asstring,11,'0');
        Titulo.ACBrBoleto.Cedente.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
        Titulo.ACBrBoleto.Cedente.ContaDigito:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,6,1);
        Titulo.ACBrBoleto.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,5,1);
        Titulo.ACBrBoleto.Cedente.Nome:=Ups(EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring);
/////////////////////////////////////////////////////////////////////////////////////////////////////

// 29.04.11 - Banco Sicredi
////////////////////////////////
      end  else if QBanco.fieldbyname('Plan_codigobanco').asstring='748' then begin
/////////////////////////////////////////////////////////////////////////////////////////////////////

        Titulo.LocalPagamento:='Pagável Preferencialmente nas cooperativas de Crédito do SICREDI';
        Titulo.Aceite:=Atsim;
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          Titulo.Mensagem.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          Titulo.Mensagem.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
        if FGeral.GetConfig1AsInteger('DIASVENBOLETO')>0 then
          Titulo.Mensagem.Add('Protestar após '+inttostr(FGeral.GetConfig1AsInteger('DIASVENBOLETO'))+' dias corridos do vencimento')
        else
          Titulo.Mensagem.Add('Sujeito a protesto se não for pago no vencimento');
//        Titulo.Carteira:=copy(FBoletos.edCarteira.text,1,1);
        Titulo.Carteira:=FBoletos.edCarteira.text;
////////////////
        b.LocalPagamento:='Pagável Preferencialmente nas cooperativas de Crédito do SICREDI';
        b.Aceite:='S';
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          b.Instrucoes.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          b.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
        if FGeral.GetConfig1AsInteger('DIASVENBOLETO')>0 then
          b.Instrucoes.Add('Protestar após '+inttostr(FGeral.GetConfig1AsInteger('DIASVENBOLETO'))+' dias corridos do vencimento')
        else
          b.Instrucoes.Add('Sujeito a protesto se não for pago no vencimento');
        b.Carteira:=FBoletos.edCarteira.text;
//////////////
//        Titulo.ACbrboleto.Cedente.CodigoCedente := QBanco.fieldbyname('Plan_convenio').asstring ;
// 04.03.15
        Titulo.ACbrboleto.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring ;
        GravaSequencial( Q.fieldbyname('Pend_operacao').asstring , QBanco.fieldbyname('Plan_codigobanco').asstring,numseq );

//        DataAtual:=FormatDateTime('dd/mm/yyyy',Sistema.hoje);
//        DataAtual:=Copy(DataAtual,9,2);
        Titulo.NossoNumero :=strzero( numseq,05);
        b.NossoNumero :=strzero( numseq,05);

//        Aux := Titulo.AcbrBoleto.Cedente.Agencia+Titulo.AcbrBoleto.Cedente.CodigoCedente+Formatar(IntToStr(StrToInt(DataAtual)), 2) + '2' + Padl(Titulo.NossoNumero,5,'0');
//        Titulo.NossoNumero:=Formatar(IntToStr(StrToInt(DataAtual)), 2) + '2' + Padl(Titulo.NossoNumero,5,'0')+GetDigito(aux,'MOD') ;

        Acbrboleto1.Banco.TipoCobranca:=cobSicred;
// 08.06.15
//        Titulo.ACBrBoleto.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,6);
// 21.09.15
        Titulo.ACBrBoleto.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,4);
        Titulo.ACBrBoleto.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('plan_agencia').AsString,5,2);
//////////////        Titulo.ACBrBoleto.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('plan_agencia').AsString,5,1);
        Titulo.ACBrBoleto.Cedente.Conta:=QBanco.fieldbyname('plan_contacorrente').AsString;
//        Aux := Titulo.ACBrBoleto.Cedente.Agencia+Titulo.ACBrBoleto.Cedente.CodigoCedente+Formatar(IntToStr(StrToInt(DataAtual)), 2) + '2' + Padl(Titulo.NossoNumero,5,'0');
        Titulo.EspecieDoc:='DMI';
/////////////////////////////////////////////////////////////////////////////////////////////////////
        B.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,6);
        b.EspecieDoc:='DMI';
        b.Cedente.Nome:=EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring;
        b.Cedente.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
      // 04.03.15 para imprimir o tal 'posto do beneficiario'
///        b.Cedente.Agencia:=copy(QBanco.fieldbyname('Plan_agencia').asstring,1,4)+copy(QBanco.fieldbyname('Plan_agencia').asstring,5,2);

// 25.07.12 - Bancoob -  Sicoob - talvez nao sera usado pois é o banco do brasil que imprime
////////////////////////////////
      end  else if QBanco.fieldbyname('Plan_codigobanco').asstring='x756' then begin
/////////////////////////////////////////////////////////////////////////////////////////////////////
{
        B.LocalPagamento:='Pagável Preferencialmente nas cooperativas de Crédito do SICOOB';
        B.Aceite:='S';
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          B.Instrucoes.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          B.Instrucoes.Add('Após 5 dias de atraso cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
        B.EspecieDoc:='DM';
        B.Carteira:=copy(FBoletos.edCarteira.text,1,1);
//        b.Cedente.CodigoCedente := QBanco.fieldbyname('Plan_convenio').asstring ;
// definido pelo Siccob...será q terá q usar/criar campo do cadastro de clientes ??
        GravaSequencial( Q.fieldbyname('Pend_operacao').asstring , QBanco.fieldbyname('Plan_codigobanco').asstring,numseq );
        b.NossoNumero :=strzero(Datetoano(Q.fieldbyname('Pend_dataemissao').asdatetime,false),2) + strzero( numseq,06);

//      end else if xcodigobanco<>'001' then begin
////////////////////////
//  / retirado em 22.08.14 quando feito CEF - devereda
// 25.09.12
      end else if (QBanco.fieldbyname('Plan_codigobanco').asstring<>'756') and
          ( trim(unidadecedente)='' )
          then begin

//        B.Cedente.ContaCorrente:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,6);
//        b.Cedente.CodigoCedente :=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5); ;
// 01.07.09
//        b.NossoNumero :=strspace(QBanco.fieldbyname('Plan_convenio').asstring,7)+
//                          strspace(Q.fieldbyname('pend_numerodcto').asstring+
//                          Q.fieldbyname('pend_parcela').asstring,10);
//        b.NossoNumero :=strspace(Q.fieldbyname('pend_numerodcto').asstring+
//                        Q.fieldbyname('pend_parcela').asstring,10);
// 06.07.10
        b.NossoNumero :=strzero( strtoint(Q.fieldbyname('pend_numerodcto').asstring+
                        Q.fieldbyname('pend_parcela').asstring),10);
                        }
///////////////////////////////////
      end;

//      if edDigitoCC.text <> '' then
// ver questao do digito de controle da conta corrente
//        B.Cedente.DigitoContaCorrente := UltimoDigito(QBanco.fieldbyname('Plan_contacorrente').asstring);
// ver se cria campo no carteira no cadastro de banco ou configuraçao geral

//      B.Cedente.Banco151.ModalidadeConta := edModeloCarteira.text;
//      B.Cedente.Banco151.ModalidadeConta :='';
///////////////////////////////////////////////////////////////////////////////////////////////////////////

// 30.08.12 - recolocad em 28.07.15 - simar
      if ( QBanco.fieldbyname('Plan_codigobanco').asstring='756' ) and (EdCArteira.text='17' ) then begin
        B.Cedente.Banco001.Convenio :=QBanco.fieldbyname('Plan_convenio').asstring;
        ACBrBoleto1.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('plan_agencia').AsString,5,1);
// 26.01.16  - simar primeiro registro da remessa com tamanhoa errado
        Titulo.NossoNumero:=copy(Q.fieldbyname('pend_numerodcto').asstring,1,6)+Q.fieldbyname('pend_parcela').asstring;
        if GeracaoRemessa then begin
          B.Cedente.ContaCorrente:=trim(copy(QBanco.fieldbyname('Plan_contacorrente').asstring,pos(';',QBanco.fieldbyname('Plan_contacorrente').asstring)+1,20));
          B.Cedente.DigitoContaCorrente:= Inttochar( StrtoINt( GetDigito( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,pos(';',QBanco.fieldbyname('Plan_contacorrente').asstring)+1,20),'MOD') ) );
// 09.10.13 - fixo por enquanto - ver para criar campo na configuracao da conta 'agencia para remessa'
// 28.07.15
          Titulo.ACBrBoleto.Cedente.Conta:=trim(copy(QBanco.fieldbyname('Plan_contacorrente').asstring,pos(';',QBanco.fieldbyname('Plan_contacorrente').asstring)+1,20));
          Titulo.ACBrBoleto.Cedente.ContaDigito:=Inttochar( StrtoINt( GetDigito( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,pos(';',QBanco.fieldbyname('Plan_contacorrente').asstring)+1,20),'MOD') ) );
          Titulo.Acbrboleto.Cedente.Agencia:='4390';
// 22.09.15
          Titulo.Acbrboleto.Cedente.CodigoCedente:=QBanco.fieldbyname('Plan_convenio').asstring;
// 25.01.16  - simar primeiro registro da remessa com tamanhoa errado
          Titulo.ACBrBoleto.Cedente.Modalidade:='01'; // simples com registro
          Titulo.Carteira:='1'; // simples com registro
//          
        end else begin
          B.Cedente.DigitoContaCorrente:= Inttochar( StrtoINt( GetDigito( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,pos(';',QBanco.fieldbyname('Plan_contacorrente').asstring)-1),'MOD') ) );
// 09.10.13
          B.Cedente.ContaCorrente:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,pos(';',QBanco.fieldbyname('Plan_contacorrente').asstring)-1);
          B.Documento := Q.fieldbyname('pend_numerodcto').asstring+'/'+Q.fieldbyname('pend_parcela').asstring;
        end;
      end else
        B.Cedente.Banco001.Convenio :=copy(QBanco.fieldbyname('Plan_convenio').asstring,1,7);
//        }
///////////////////////////////////////////////////////////////////////////////////////////////////////////
 ///////////////////////////////////////////////

      with B.sacado do
      begin
// 28.09.11
        if Q.fieldbyname('pend_tipocad').asstring='F' then begin
          QForne:=sqltoquery('select * from fornecedores where forn_codigo='+Inttostr(Q.fieldbyname('pend_tipo_codigo').asinteger));
          Nome := ups(QForne.fieldbyname('forn_razaosocial').asstring);
          Endereco := QForne.fieldbyname('forn_endereco').asstring;
          Bairro := QForne.fieldbyname('forn_bairro').asstring;
          Estado := QForne.fieldbyname('forn_UF').asstring;
          Cep := QForne.fieldbyname('forn_cep').asstring;
          Cidade := FCidades.GetNome( QForne.fieldbyname('Forn_cida_codigo').asinteger);
          CNPJ_CPF := QForne.fieldbyname('forn_cnpjcpf').asstring;
          FGeral.FechaQuery(Qforne);
        end else begin
          Nome := ups(Q.fieldbyname('clie_razaosocial').asstring);
          if (trim(Q.fieldbyname('Clie_endcom').asstring)<>'') and (trim(Q.fieldbyname('Clie_cepcom').asstring)<>'') then begin
            Endereco := ups(Q.fieldbyname('Clie_endcom').asstring);
            Bairro := ups(Q.fieldbyname('Clie_bairrocom').asstring);
            Cep := Q.fieldbyname('Clie_cepcom').asstring;
            Estado := ups( FCidades.GetUF( Q.fieldbyname('Clie_cida_codigo_com').asinteger));
            Cidade := FCidades.GetNome( Q.fieldbyname('Clie_cida_codigo_com').asinteger);
          end else begin
            Endereco := ups(Q.fieldbyname('Clie_endres').asstring);
            Bairro := (ups(Q.fieldbyname('Clie_bairrores').asstring));
            Estado := ups(FCidades.GetUF( Q.fieldbyname('Clie_cida_codigo_res').asinteger));
            Cep := Q.fieldbyname('Clie_cepres').asstring;
            Cidade := Ups(FCidades.GetNome( Q.fieldbyname('Clie_cida_codigo_res').asinteger));
          end;
          CNPJ_CPF := Q.fieldbyname('Clie_cnpjcpf').asstring;
        end;
      end;

 ///////////////////////////////////////////////

      with Titulo.Sacado do
      begin
// 28.09.11
        if Q.fieldbyname('pend_tipocad').asstring='F' then begin
          QForne:=sqltoquery('select * from fornecedores where forn_codigo='+Inttostr(Q.fieldbyname('pend_tipo_codigo').asinteger));
          NomeSacado := Ups(QForne.fieldbyname('forn_razaosocial').asstring);
          Logradouro := QForne.fieldbyname('forn_endereco').asstring;
          Bairro := QForne.fieldbyname('forn_bairro').asstring;
          UF := QForne.fieldbyname('forn_UF').asstring;
          CEP := QForne.fieldbyname('forn_cep').asstring;
          Cidade := FCidades.GetNome( QForne.fieldbyname('Forn_cida_codigo').asinteger);
          CNPJCPF := QForne.fieldbyname('forn_cnpjcpf').asstring;
          FGeral.FechaQuery(Qforne);
        end else begin
          NomeSacado := Ups(Q.fieldbyname('clie_razaosocial').asstring);
          if (trim(Q.fieldbyname('Clie_endcom').asstring)<>'') and (trim(Q.fieldbyname('Clie_cepcom').asstring)<>'') then begin
            Logradouro := Ups(Q.fieldbyname('Clie_endcom').asstring);
            Bairro := Ups(Q.fieldbyname('Clie_bairrocom').asstring);
            Cep := Q.fieldbyname('Clie_cepcom').asstring;
            UF := FCidades.GetUF( Q.fieldbyname('Clie_cida_codigo_com').asinteger);
            Cidade := ups(FCidades.GetNome( Q.fieldbyname('Clie_cida_codigo_com').asinteger));
          end else begin
            Logradouro := ups(Q.fieldbyname('Clie_endres').asstring);
            Bairro := ups(Q.fieldbyname('Clie_bairrores').asstring);
            UF := FCidades.GetUF( Q.fieldbyname('Clie_cida_codigo_res').asinteger);
            Cep := Q.fieldbyname('Clie_cepres').asstring;
            Cidade := ups(FCidades.GetNome( Q.fieldbyname('Clie_cida_codigo_res').asinteger));
          end;
          CNPJCPF := Q.fieldbyname('Clie_cnpjcpf').asstring;
        end;
      end;

// 30.06.10 - banco do brasil sarnovizky
//      b.DataProcessamento:=Sistema.Hoje;
// falado com elyze...se o bb reinar mudamos a geracao da remessa tbem...
      b.DataProcessamento:=b.DataDocumento;
      b.Valor:=Q.fieldbyname('pend_valor').ascurrency;
//      Titulo.Mensagem.Add(' mensagem 01');
 //     Titulo.Mensagem.Add(' mensagem 02');
      b.Vencimento:=Q.fieldbyname('pend_datavcto').asdatetime;
      if Qbanco.FieldByName('plan_codigobanco').asstring<>'341' then
        b.Documento:=Q.fieldbyname('pend_numerodcto').asstring+'/'+strzero(Q.fieldbyname('pend_parcela').asinteger,2)
      else
//        b.Documento:=Q.fieldbyname('pend_numerodcto').asstring+strzero(Q.fieldbyname('pend_parcela').asinteger,2);
// 10.11.15 - Novicarnes - elyze
        b.Documento:=Q.fieldbyname('pend_numerodcto').asstring;

      b.preparar;

// 16.09.15

      Titulo.DataDocumento:=Q.fieldbyname('pend_dataemissao').asdatetime;
      Titulo.DataProcessamento:=Titulo.DataDocumento;
      Titulo.ValorDocumento:=Q.fieldbyname('pend_valor').ascurrency;
      Titulo.Vencimento:=Q.fieldbyname('pend_datavcto').asdatetime;
      Titulo.NumeroDocumento:=Q.fieldbyname('pend_numerodcto').asstring;
      Titulo.TipoImpressao:=tipNormal;
      Titulo.TotalParcelas:=Q.fieldbyname('pend_nparcelas').asinteger;
      Titulo.Parcela:=Q.fieldbyname('pend_parcela').asinteger;
// 29.03.16 - Giacomoni - barbara pegou...
      if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          Titulo.ValorMoraJuros:=roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000))
      else
          Titulo.ValorMoraJuros:=0;
      if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
            Titulo.PercentualMulta:=FGeral.GetConfig1AsFloat('MULTABOLETO')
      else
            Titulo.PercentualMulta:=0;
// 20.05.16
      if Qbanco.FieldByName('plan_codigobanco').asstring='341' then
        if GeracaoRemessa then Titulo.PercentualMulta:=0;

////////////

      AcbrBoleto1.AdicionarMensagensPadroes(Titulo,Titulo.Mensagem);
/////////////////      Titulo.Free;
end;

procedure TFBoletos.SetaCarteira(EditCarteira: TSqled;  codigobanco: string);
//////////////////////////////////////////////////////////
var Extensao:string;

      function CodigoMes(xData:TDateTime):string;
      ///////////////////////////////////////////
      begin
        if Datetomes(xData)=10 then
          result:='O'
        else if Datetomes(xData)=11 then
          result:='N'
        else if Datetomes(xData)=12 then
          result:='D'
        else
          result:=strzero(Datetomes(xData),1);
      end;

/////////////////////////////////////////
begin
/////////////////////////////////////////
  Extensao:='.TXT';
  if trim(QBanco.fieldbyname('Plan_carteira').asstring)='' then begin
    if Codigobanco='341' then begin
  //    EditCarteira.text:='112'; - se o banco emitir o boleto
      EditCarteira.text:='109';  // se o cliente emitir o boleto
  //    OndeSalvar:='REMESSA'+CodigoBanco+strzero(DatetoDia(EdDtfim.asdate),2)+strzero(DatetoMes(EdDtfim.asdate),2);
  // itau exige 8 caracteres no maximo...
      OndeSalvar:='R'+CodigoBanco+strzero(DatetoDia(EdDtfim.asdate),2)+strzero(DatetoMes(EdDtfim.asdate),2)+Extensao;
    end else if Codigobanco='748' then begin
      EditCarteira.text:='A';     //
//              CODIGO DO CEDENTE // MONTA 'lá embaixo' pra ter o codigo do cedente
//              por enquanto fica assim
      Extensao:='.CRM';
//      OndeSalvar:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5)+CodigoBanco+strzero(DatetoDia(EdDtfim.asdate),2)+strzero(DatetoMes(EdDtfim.asdate),2)+Extensao;
      OndeSalvar:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5)+CodigoMes(EdDtfim.asdate)+strzero(DatetoDia(EdDtfim.asdate),2)+Extensao
    end else if Codigobanco='756' then begin
      EditCarteira.text:='001';     //
      Extensao:='.REM';
//      OndeSalvar:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5)+CodigoBanco+strzero(DatetoDia(EdDtfim.asdate),2)+strzero(DatetoMes(EdDtfim.asdate),2)+Extensao;
      OndeSalvar:='CBR'+
                  Formatdatetime('yyyymmdd',Sistema.Hoje)+
                  strzero( FGeral.GetContador('BOL'+codigobanco+strzero(DatetoAno(Sistema.Hoje,true),4),false ) ,2)+
                  Extensao
    end else begin
      EdCarteira.text:='001';
      OndeSalvar:='REMESSA'+CodigoBanco+strzero(DatetoDia(EdDtfim.asdate),2)+strzero(DatetoMes(EdDtfim.asdate),2)+Extensao;
    end;
  end else begin
     if Codigobanco='748' then begin
       Extensao:='.CRM';
//       OndeSalvar:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5)+CodigoMes(EdDtfim.asdate)+strzero(DatetoDia(EdDtfim.asdate),2)+Extensao
// 29.04.16 - para nao ficar o nome do arquivo em desacordo com a data da geracao do arquio
       OndeSalvar:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5)+CodigoMes(Sistema.hoje)+strzero(DatetoDia(Sistema.hoje),2)+Extensao
     end else if Codigobanco='756' then begin
       Extensao:='.REM';
//      OndeSalvar:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5)+CodigoBanco+strzero(DatetoDia(EdDtfim.asdate),2)+strzero(DatetoMes(EdDtfim.asdate),2)+Extensao;
      OndeSalvar:='CBR'+
                  Formatdatetime('yyyymmdd',Sistema.Hoje)+
                  strzero( FGeral.GetContador('BOL'+codigobanco+strzero(DatetoAno(Sistema.Hoje,true),4),false ) ,2)+
                  Extensao
// 05.09.14
     end else if Codigobanco='104' then begin
       Extensao:='.REM';
       OndeSalvar:='REMESSA'+CodigoBanco+strzero(DatetoDia(EdDtfim.asdate),2)+strzero(DatetoMes(EdDtfim.asdate),2)+Extensao;
     end else
       OndeSalvar:='REMESSA'+CodigoBanco+strzero(DatetoDia(EdDtfim.asdate),2)+strzero(DatetoMes(EdDtfim.asdate),2)+Extensao;
      EdCarteira.text:=QBanco.fieldbyname('Plan_carteira').asstring;
  end;
end;


procedure TFBoletos.bgeraremessaClick(Sender: TObject);
////////////////////////////////
var p,ContadorNossoNumero,r,sequencialremessa:integer;
    op,Aux,DataAtual,csequencialremessa:string;
    Q:TSqlquery;
    ListaBoletos,PathSalvo:TStringlist;
//    ACobranca:TGbCobranca;
    ACobranca:TACBrBoleto;
//    Titulo:TGbTitulo;
//    Titulo:TAcbrTitulo;
//    CobBanco341:TGbBanco341;
//    CobBanco001:TGbBanco001;
//    CobBanco104:TGbBanco104;
//    CobBanco422:TGbBanco422;
//    CobBanco237:TGbBanco237;
//    CobBanco748:TGbBanco748;
//    CobBanco756:TGbBanco756;
//    Conta:TGbContaBancaria;
    Conta:String;
//    Banco:TGbBanco;
//    Sacado:TGbPessoa;
    Sacado:TACBrSacado;
//    Endereco:TGbEndereco;
//    Aceite:TAceiteDocumento;
    Aceite:TACBrAceiteTitulo;
//    EspecieDocumento:TEspecieDocumento;
    EspecieDocumento:String;
//    EmissaoBoleto:TEmissaoBoleto;
    EmissaoBoleto:TDatetime;
//    TipoOcorrencia:TTipoOcorrencia;
    TipoOcorrencia:TAcbrTipoOcorrencia;


//    function StringToTipoOcorrencia(inst:string):TTipoOcorrencia;
    function StringToTipoOcorrencia(inst:string):TAcbrTipoOcorrencia;
    //////////////////////////////////////////////////////////////
    begin
      if EdBanco.text='748' then begin
        if inst='01' then result:=toRemessaRegistrar
        else if inst='02' then result:=toRemessaBaixar
        else if inst='04' then result:=toRemessaConcederAbatimento
        else if inst='05' then result:=toRemessaCancelarAbatimento
        else if inst='06' then result:=toRemessaAlterarVencimento
//        else if inst='08' then result:=toRemessaAlterarSeuNumero
        else if inst='09' then result:=toRemessaProtestar
//        else if inst='18' then result:=toRemessaCancelarInstProtestoeBaixar
//        else if inst='19' then result:=toRemessaCancelarInstProtestoeManter
        else result:=toRemessaRegistrar;
      end else if EdBanco.text='104' then begin
        if inst='01' then result:=toRemessaRegistrar
        else if inst='02' then result:=toRemessaBaixar
        else if inst='03' then result:=toRemessaConcederAbatimento
        else if inst='04' then result:=toRemessaCancelarAbatimento
        else if inst='05' then result:=toRemessaAlterarVencimento
//        else if inst='06' then result:=toRemessaAlterarUsodaEmpresa
//        else if inst='07' then result:=toRemessaAlterarDiasProtesto
//        else if inst='08' then result:=toRemessaAlterarPrazoDevolucao
//        else if inst='09' then result:=toRemessaAlterarOutrosDados
//        else if inst='10' then result:=toRemessaAlterarEmissaoBoleto
//        else if inst='11' then result:=toRemessaAlterarProtestoparaDevolucao
//        else if inst='12' then result:=toRemessaAlterarDevolucaoparaProtesto
        else result:=toRemessaRegistrar;
      end else begin
        if inst='01' then result:=toRemessaRegistrar
        else if inst='02' then result:=toRemessaBaixar
        else if inst='04' then result:=toRemessaConcederAbatimento
        else if inst='05' then result:=toRemessaCancelarAbatimento
        else if inst='06' then result:=toRemessaAlterarVencimento
//        else if inst='08' then result:=toRemessaAlterarSeuNumero
        else if inst='09' then result:=toRemessaProtestar
//        else if inst='18' then result:=toRemessaCancelarInstProtestoeBaixar
//        else if inst='19' then result:=toRemessaCancelarInstProtestoeManter
        else result:=toRemessaRegistrar;
      end;

    end;

// 20.04.15
    function GetSomentePath( s:string ):string;
    //////////////////////////////////////////
    var p:integer;
        r:string;
    begin
       r:='';
       if trim(s)='' then begin
         Aviso('Variavel s='+s);
         result:=s;
         exit;
       end;
       for p:=Length(s) downto 0 do begin
          r:=s[p];
          if r='\' then begin
            r:=leftstr(s,p);
            break;
          end;
       end;
       result:=r;
    end;


/////////////////////////////////////
begin
/////////////////////////////////////
// 29.10.18
  SequencialRemessa:=FGeral.GetContador('REMESSA'+EdUnid_codigo.text+'B'+QBanco.fieldbyname('Plan_codigobanco').asstring,false,false)+1;
  cSequencialRemessa:=inttostr(SequencialRemessa);
  if QBanco.fieldbyname('Plan_codigobanco').asstring='748' then begin
    if not Input('Sequencial Remessa','Numero',cSequencialRemessa,8,true) then exit;
    SequencialRemessa:=Inteiro(cSequencialRemessa);
  end;
  ListaBoletos:=TStringlist.create;
// 18.07.13
  PathSalvo:=TStringList.create;
//  ACobranca:=TGbCobranca.Create(self);
  GeracaoRemessa:=true;
  Sistema.Beginprocess('Gerando boletos');
  AcbrBoleto1.ListadeBoletos.Clear;
  for p:=1 to GridPedidos.RowCount do begin
    op:=GridPedidos.Cells[GridPedidos.getcolumn('pend_operacao'),p];
    if (trim(op)<>'') and (trim(GridPedidos.Cells[GridPedidos.getcolumn('marcado'),p])<>'') then begin
      Q:=sqltoquery('select * from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
                   ' where pend_status=''N'''+
                   ' and '+FGeral.GetIN('pend_tipocad','C;F','C')+
                   ' and pend_operacao='+stringtosql(op));
      if not Q.eof then begin
//        ListaBoletos.add(Q.fieldbyname('pend_numerodcto').AsString);
        CriaBoleto(Q);

//        Titulo:=TGbTitulo.Create(Owner);
//        Titulo.NumeroConvenio:=B.Cedente.Banco001.Convenio;
//        Titulo.LocalPagamento:=B.LocalPagamento;
//        Titulo.DataVencimento:=B.Vencimento;
//        Titulo.Vencimento:=B.Vencimento;
//        if B.Cedente.CodigoBanco='001' then begin
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
{
        if B.Cedente.ACBrBoleto.Banco.Numero=1 then begin
//          Titulo.Cedente.CodigoCedente:=strzero(strtointdef(B.Cedente.CodigoCedente,0),8);
          Titulo.ACBrBoleto.Cedente.CodigoCedente:=strzero(strtointdef(B.Cedente.CodigoCedente,0),8);
// 08.08.12 - esquema siccob
          if B.Carteira='17' then Titulo.Carteira:='09'
        end else if B.Cedente.CodigoBanco='422' then
//          Titulo.Cedente.CodigoCedente:=strspace(B.Cedente.Agencia,5)+strspace(B.Cedente.ContaCorrente+B.Cedente.DigitoContaCorrente,09)
          Titulo.AcbrBoleto.Cedente.CodigoCedente:=Padl(B.Cedente.Agencia,5,'0')+Padl(B.Cedente.ContaCorrente+B.Cedente.DigitoContaCorrente,09,'0')
//          Titulo.Cedente.CodigoCedente:=Padl(B.Cedente.Agencia,5,'0')+Padl(B.Cedente.ContaCorrente,09,'0')
        else
//          Titulo.Cedente.CodigoCedente:=B.Cedente.CodigoCedente;
          Titulo. AcbrBoleto.Cedente.CodigoCedente:=B.Cedente.CodigoCedente;
//        Titulo.Cedente.DigitoCodigoCedente:=B.Cedente.DigitoContaCorrente;
//        Titulo.Acbrboleto.Cedente.DigitoCodigoCedente:=B.Cedente.DigitoContaCorrente;
// 11.06.10
//        Titulo.Cedente.TipoInscricao:=tiPessoaJuridica;
//        Titulo.Acbrboleto.Cedente.TipoInscricao:=tiPessoaJuridica;
        Titulo.Acbrboleto.Cedente.TipoInscricao:=PJuridica;
{
            tiPessoaFisica  : ACedenteTipoInscricao := '01';
            tiPessoaJuridica: ACedenteTipoInscricao := '02';
            tiOutro         : ACedenteTipoInscricao := '03';
/////////

//        Titulo.Cedente.NumeroCPFCGC:=FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_cnpj').asstring;
//        Titulo.Cedente.Nome:=B.Cedente.Nome;
//        Titulo.Acbrboleto.Cedente.NumeroCPFCGC:=FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_cnpj').asstring;
        Titulo.Acbrboleto.Cedente.CNPJCPF:=FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_cnpj').asstring;
        Titulo.Acbrboleto.Cedente.Nome:=B.Cedente.Nome;
//        Titulo.Cedente.Endereco:=B.Cedente.Nome;
        Titulo.SeuNumero:=B.Documento;
// ver se dá pra mudar somente o 'nosso numero' colocando a parcela nele
// senao terá q colocar no numero mesmo
        Titulo.NumeroDocumento:=B.Documento;
        Titulo.Carteira:=B.Carteira;
//        Aceite:=(adSim);
// 14.06.10
{
        if B.Aceite='S' then
          Aceite:=(adSim)
        else
          Aceite:=(adNao);
          ////////////////////
        if B.Aceite='S' then
          Aceite:=(atSim)
        else
          Aceite:=(atNao);
////////////
//        Titulo.AceiteDocumento:=Aceite;
//        Titulo.Aceite:=Aceite;
        Titulo.Aceite:=Aceite;
        Titulo.DataProcessamento:=Sistema.hoje;
        Titulo.DataDocumento:=B.DataDocumento;
//        Titulo.DataVencimento:=B.Vencimento;
        Titulo.vencimento:=B.Vencimento;
        if EdSoma.text='S' then
          Titulo.ValorDocumento:=EdTotalMarcado.AsCurrency
        else
          Titulo.ValorDocumento:=B.Valor;

//        EmissaoBoleto:=ebClienteEmite;
        EmissaoBoleto:=Titulo.DataDocumento;
//        Titulo.EmissaoBoleto:=EmissaoBoleto;
        Titulo.DataDocumento:=EmissaoBoleto;
        TipoOcorrencia:=toRemessaRegistrar;
// 13.09.13
        TipoOcorrencia:=StringToTipoOcorrencia(EdInstrucaoCob.text);
//        Titulo.TipoOcorrencia:=TipoOcorrencia;
//        Titulo.TipoOcorrencia:=TipoOcorrencia;
//        Titulo.TipoOcorrencia:=AcbrTipoOcorrencia;
//        Titulo. :=TipoOcorrencia;

//        EspecieDocumento:=edDuplicataMercantil;
        EspecieDocumento:='DM';

//        Titulo.EspecieDocumento:=EspecieDocumento;
        Titulo.EspecieDoc:=EspecieDocumento;
        DataAtual:=FormatDateTime('dd/mm/yyyy',Now);
        DataAtual:=Copy(DataAtual,9,2);

// 09.11.10
        if B.Cedente.CodigoBanco='422' then begin

          if length( trim(Q.fieldbyname('pend_numerodcto').asstring) )=5 then begin
//            Titulo.NossoNumero := '3819'+copy(Q.fieldbyname('pend_numerodcto').asstring,3,3)+Q.fieldbyname('pend_parcela').asstring
            Titulo.NossoNumero := faixai+copy(Q.fieldbyname('pend_numerodcto').asstring,2,4);
           ContadorNossoNumero:=strtoint(copy(Q.fieldbyname('pend_numerodcto').asstring,2,4));
          end else begin
//            Titulo.NossoNumero := '3819'+copy(Q.fieldbyname('pend_numerodcto').asstring,4,3)+Q.fieldbyname('pend_parcela').asstring;
            Titulo.NossoNumero := faixai+copy(Q.fieldbyname('pend_numerodcto').asstring,3,4);
            ContadorNossoNumero:=strtoint(copy(Q.fieldbyname('pend_numerodcto').asstring,3,4));
//          Titulo.NossoNumero:=Titulo.NossoNumero + GetDigito(Titulo.NossoNumero,'MOD') ;
// 16.11.10 - senao nao 'fecha' o digito 'do safra'...
          end;

// 02.02.11 - 'repeticao de nosso numero devido a limitacao de 3 + 1 digitos deste banco
          if ContadorNossoNumero>9999 then begin
            FGeral.AlteraContador('FAIXANNUM'+B.Cedente.CodigoBanco,strtoint(faixaf));
            faixai:=faixaf;
          end;
//          Titulo.NossoNumero := '3819'+strzero(ContadorNossoNumero,4);

          Titulo.NossoNumero:=Titulo.NossoNumero + GetDigitoX( B.Cedente.CodigoBanco,Titulo.NossoNumero );

// 26.05.11
        end else if B.Cedente.CodigoBanco='748' then begin

          Aux := B.Cedente.Agencia+B.Cedente.CodigoCedente+Formatar(IntToStr(StrToInt(DataAtual)), 2) + '2' + Padl(B.NossoNumero,5,'0');
          Titulo.NossoNumero:=Formatar(IntToStr(StrToInt(DataAtual)), 2) + '2' + Padl(B.NossoNumero,5,'0')+GetDigito(aux,'MOD') ;
//          Titulo.EspecieDocumento:=edDuplicataMercantialIndicacao;
          Titulo.EspecieDoc:='DMI';
// 03.08.11 // senao dá msg de data interna diferente da informada no nome do arquivo...tsc, tsc
          Titulo.DataProcessamento:=EdDtfim.asdate;

        end else if B.Cedente.CodigoBanco='756' then begin  // Sicoob
// 29.08.12
          Titulo.NossoNumero:=strspace(copy(QBanco.fieldbyname('Plan_convenio').asstring,1,10),10)+Strspace(B.NossoNumero,07);
//          Titulo.Cedente.Nome := FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring;
          Titulo.Acbrboleto.Cedente.Nome := FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring;
          tamagencia:=5;
// 10.10.12
//          Titulo.Cedente.CodigoCedente:=copy(QBanco.fieldbyname('Plan_agencia').asstring,6,5);
          Titulo.Acbrboleto.Cedente.CodigoCedente:=copy(QBanco.fieldbyname('Plan_agencia').asstring,6,5);
          Titulo.SeuNumero:=B.Documento+strzero(Q.fieldbyname('pend_parcela').AsInteger,2);
///////////////
        end else
// 18.06.10
          Titulo.NossoNumero:=strspace(copy(QBanco.fieldbyname('Plan_convenio').asstring,1,7),7)+Strspace(B.NossoNumero,10);

//        Banco:=TGbBanco.Create;
//        Conta:=TGbContaBancaria.Create;
//        Banco.Codigo:=B.Cedente.CodigoBanco;
//        Conta.fBanco:=Banco;
//        Conta:=Banco;
        Conta:=B.Cedente.ContaCorrente;
//        Conta.fCodigoAgencia:=copy(B.Cedente.Agencia,1,tamagencia);
// 18.06.09 - qual digito enviar ?
//        Conta.fDigitoAgencia:=UltimoDigito(B.Cedente.Agencia);
//        Conta.fDigitoConta:=UltimoDigito(B.Cedente.ContaCorrente);
//        Conta.fDigitoConta:=B.Cedente.DigitoContaCorrente;

//        Conta.fNumeroConta:=B.Cedente.ContaCorrente;
//        Conta.fNumeroConta:=B.Cedente.ContaCorrente+B.Cedente.DigitoContaCorrente;

//        Titulo.Cedente.ContaBancaria:=Conta;
        Titulo.Acbrboleto.Cedente.Conta:=Conta;
{
        Sacado:=TGbPessoa.Create;
        Sacado.NumeroCPFCGC:=B.Sacado.CNPJ_CPF;
        Sacado.Nome:=B.Sacado.Nome;

        Sacado:=tAcbrsacado.Create;
        Sacado.CNPJCPF:=B.Sacado.CNPJ_CPF;
        Sacado.NomeSacado:=B.Sacado.Nome;
{
        Endereco:=TGbEndereco.Create;
        Endereco.fRua:=B.Sacado.Endereco;
        Endereco.fBairro:=B.Sacado.Bairro;
        Endereco.fCidade:=B.Sacado.Cidade;
        Endereco.fEstado:=B.Sacado.Estado;
        Endereco.fCEP:=B.Sacado.Cep;

        Sacado.Bairro:=B.Sacado.Bairro;
        Sacado.Cidade:=B.Sacado.Cidade;
        Sacado.UF:=B.Sacado.Estado;
        Sacado.CEP:=B.Sacado.Cep;
//        Sacado.Endereco:=Endereco;
        Sacado.Logradouro:=B.Sacado.Endereco;
// 07.07.10
{
        Sacado.TipoInscricao:=tiPessoaJuridica;
        if Q.fieldbyname('clie_tipo').AsString='F' then
          Sacado.TipoInscricao:=tiPessoaFisica;

        Sacado.Pessoa:=pjuridica;
        if Q.fieldbyname('clie_tipo').AsString='F' then
          Sacado.Pessoa:=pFisica;
//
        Titulo.Sacado:=Sacado;
//        Titulo.Cedente.

// 19.06.10
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
//          Titulo.ValorMoraJuros:=Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)
//30.06.10
          Titulo.ValorMoraJuros:=roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000))
        else
          Titulo.ValorMoraJuros:=0;
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
//          Titulo.ValorMulta:=FGeral.Arredonda( Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100),2 )
//          Titulo.ValorMulta:=roundvalor( Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100) )
        else
//          Titulo.ValorMulta:=0;
////////////

//          B.Instrucoes.Add('Após o vencimento cobrar mora de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000))+' ao dia');
//        B.Instrucoes.Add('Após o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*0.02));

//        ACobranca.Titulos.Add(Titulo);

        ACobranca.CriarTituloNaLista;
        Titulo.Free;
        }
////////////////////////////////////////////////////////////////////////////////////
      end;

      FGeral.FechaQuery(Q);
      if EdSoma.text='S' then break;

    end;
  end;
  ///////////////////////////////////////////////////////////////


// 10.06.10 -
//  Acobranca.NumeroArquivo:=FGeral.GetContador('REMESSA'+EdUnid_codigo.text+'B'+QBanco.fieldbyname('Plan_codigobanco').asstring ,false);

{
  if QBanco.fieldbyname('Plan_codigobanco').asstring='341' then begin
    CobBanco341:=TGbBanco341.Create;
    CobBanco341.GerarRemessa(ACobranca,ListaBoletos);
  end else if QBanco.fieldbyname('Plan_codigobanco').asstring='104' then begin
    CobBanco104:=TGbBanco104.Create;
    CobBanco104.GerarRemessa(ACobranca,ListaBoletos);
  end else if QBanco.fieldbyname('Plan_codigobanco').asstring='422' then begin
    CobBanco422:=TGbBanco422.Create;
    CobBanco422.GerarRemessa(ACobranca,ListaBoletos);
  end else if QBanco.fieldbyname('Plan_codigobanco').asstring='237' then begin
    CobBanco237:=TGbBanco237.Create;
    CobBanco237.GerarRemessa(ACobranca,ListaBoletos);
  end else if QBanco.fieldbyname('Plan_codigobanco').asstring='748' then begin
//    CobBanco748:=TGbBanco748.Create;
//    CobBanco748.GerarRemessa(ACobranca,ListaBoletos);
// 27.07.12
  end else if QBanco.fieldbyname('Plan_codigobanco').asstring='756' then begin
//    CobBanco756:=TGbBanco756.Create;
//    CobBanco756.GerarRemessa(ACobranca,ListaBoletos);
// 08.08.12 - para nao ter q ficar mudando de banco pois imprime no banco do brasil e gera no sicoob
  end else if ( QBanco.fieldbyname('Plan_codigobanco').asstring='001') and (EdCarteira.text='17') then begin
//    CobBanco756:=TGbBanco756.Create;
//    CobBanco756.GerarRemessa(ACobranca,ListaBoletos);
  end else begin
    CobBanco001:=TGbBanco001.Create;
//    CobBanco001.GerarRemessa(ACobranca,ListaBoletos);
  end;
}

//   FGeral.GetContador('REMESSA'+EdUnid_codigo.text+'B'+QBanco.fieldbyname('Plan_codigobanco').asstring ,false);

  AcbrBoleto1.Cedente.Nome:=Ups(EdUnid_codigo.resultfind.fieldbyname('Unid_razaosocial').asstring);
  AcbrBoleto1.Cedente.CNPJCPF:=EdUnid_codigo.resultfind.fieldbyname('Unid_cnpj').asstring;
//  ACBrBoleto1.Cedente.Conta:=QBanco.fieldbyname('plan_contacorrente').AsString;
//  Acbrboleto1.Cedente.ContaDigito := UltimoDigito(QBanco.fieldbyname('Plan_contacorrente').asstring);
//  ACBrBoleto1.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,4);
 if QBanco.fieldbyname('Plan_codigobanco').asstring='341' then begin
    Acbrboleto1.Cedente.AgenciaDigito:= GetDigito( copy(QBanco.fieldbyname('Plan_agencia').asstring,1,4),'MOD' );
    ACBrBoleto1.Cedente.Conta:=copy(QBanco.fieldbyname('plan_contacorrente').AsString,1,5);
  end;

  Salvar.FileName:=ondesalvar;
  if FileExists(  ExtractFilePath( Application.ExeName ) + 'RemessaSalva.txt') then begin
    PathSalvo.LoadFromFile(  ExtractFilePath( Application.ExeName )+'RemessaSalva.txt');
    Salvar.InitialDir:=GetSomentePath( PathSalvo.Text );
    Salvar.FileName:= GetSomentePath(PathSalvo.Text) +ondesalvar;
  end;
  Sistema.Beginprocess('Gerando arquivo remessa');
  if Salvar.Execute then begin
    try
      if FileExists( Salvar.FileName ) then begin
        if QBanco.fieldbyname('Plan_codigobanco').asstring='748' then begin
          for r:=2 to 9 do begin
//            Salvar.FileName: = Salvar.InitialDir+'\'+ copy(ondesalvar,1,pos('.',ondesalvar)-1)+'.RM'+strzero(r,1);
            Salvar.FileName:= ExtractFilePath( salvar.filename )+ copy(ondesalvar,1,pos('.',ondesalvar)-1)+'.RM'+strzero(r,1);
            if not FileExists( Salvar.FileName ) then break;
          end;
        end;
      end;
//      ACBrBoleto1.DirArqRemessa:='\Sac\Remessas'+QBanco.fieldbyname('Plan_codigobanco').asstring;
     ACBrBoleto1.DirArqRemessa:=ExtractFilePath( Salvar.Filename);
     if FileExists( ExtractFilePath( Application.ExeName )+ 'RemessaSalva.txt') then
        ACBrBoleto1.DirArqRemessa:=( Salvar.InitialDir )
     else
       ACBrBoleto1.DirArqRemessa:=GetSomentePath( Salvar.Filename);
      ACBrBoleto1.NomeArqRemessa:=ExtractFileName( Salvar.filename );
     if pos( QBanco.fieldbyname('Plan_codigobanco').asstring,'104;756')>0 then AcbrBoleto1.LayoutRemessa:=c240
     else AcbrBoleto1.LayoutRemessa:=c400;
//     AcBrBoleto1.GerarRemessa( FGeral.GetContador('REMESSA'+EdUnid_codigo.text+'B'+QBanco.fieldbyname('Plan_codigobanco').asstring ,false) );
// 29.10.15 - giacomoni
     FGeral.AlteraContador( 'REMESSA'+EdUnid_codigo.text+'B'+QBanco.fieldbyname('Plan_codigobanco').asstring,SequencialRemessa );
// 16.09.15
     if (QBanco.fieldbyname('Plan_codigobanco').asstring='756')  and (EdCarteira.text='17') then
       AcBrBoleto1.GerarRemessa( FGeral.GetContador('REMESSA'+EdUnid_codigo.text+'B'+'001' ,false) )
     else
       AcBrBoleto1.GerarRemessa( SequencialRemessa );
//      Sistema.Endprocess('Arquivo '+Salvar.FileName+' gerado');
      Sistema.Endprocess('Arquivo '+ACBrBoleto1.NomeArqRemessa+' gerado em '+ACBrBoleto1.DirArqRemessa );
    except
      Sistema.Endprocess('Não foi possível gravar o arquivo '+ACBrBoleto1.DirArqRemessa+' em '+ACBrBoleto1.DirArqRemessa);
    end;
  end;

// 22.09.16 - gravar nosso numero da remessa para usar no retorno
  for p:=0 to Acbrboleto1.ListadeBoletos.Count-1 do begin
        Sistema.edit('pendencias');
        Sistema.SetField('pend_opantecipa',Acbrboleto1.ListadeBoletos.Objects[p].NossoNumero);
        Sistema.post('pend_operacao='+Stringtosql(Acbrboleto1.ListadeBoletos.Objects[p].Referencia));
        Sistema.Commit;
  end;
  PathSalvo.Clear;
  PathSalvo.Add( Salvar.FileName );
  PathSalvo.SaveToFile( ExtractFilePath( Application.ExeName ) + 'RemessaSalva.txt' );
  PathSalvo.Free;
  Sistema.endprocess('');
  ListaBoletos.free;
// 02.02.11
  if QBanco.fieldbyname('Plan_codigobanco').asstring='422' then
    FGeral.AlteraContador('FAIXANNUM'+QBanco.fieldbyname('Plan_codigobanco').asstring,strtoint(faixai));


//  if QBanco.fieldbyname('Plan_codigobanco').asstring='341' then
//    CobBanco341.free
//  else if QBanco.fieldbyname('Plan_codigobanco').asstring='748' then
//    CobBanco748.free
//  else
//    CobBanco001.free

end;

procedure TFBoletos.GeraLista(Q:TSqlquery);
begin


end;

procedure TFBoletos.brelatorioClick(Sender: TObject);
var i,marc:integer;
begin
  if Edtotalmarcado.ascurrency=0 then exit;
  Sistema.BeginProcess('Gerando relatório');
  FRel.Init('RelBoletosGerados');
  FRel.AddTit('Unidade '+EdUNid_codigo.text+' - '+SetEdUnid_nome.text);
  FRel.AddTit('Relação de Boletos Enviados vai Remessa para Conta '+EdBanco.text+' - '+EdBanco_descricao.text );
  FRel.AddCol( 50,1,'D','' ,''              ,'Emissão'    ,''         ,'',false);
  FRel.AddCol( 70,1,'D','' ,''              ,'Vencimento'    ,''         ,'',false);
  FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor'           ,''         ,'',False);
  FRel.AddCol( 70,0,'N','' ,''              ,'Documento'   ,''         ,'',False);
  FRel.AddCol( 60,1,'N','' ,''              ,'Cliente/Forn.'   ,''         ,'',false);
  FRel.AddCol(150,1,'C','' ,''              ,'Nome'   ,''         ,'',false);
  marc:=0;
  for i:=1 to GridPedidos.rowcount do begin
    if GridPedidos.Cells[GridPedidos.getcolumn('marcado'),i]='Ok' then begin
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('pend_dataemissao'),i] );
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('pend_datavcto'),i] );
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('pend_valor'),i] );
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('pend_numerodcto'),i] );
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('pend_tipo_codigo'),i] );
          FRel.AddCel(GridPedidos.cells[GridPedidos.getcolumn('clie_descricao'),i] );
          inc(marc);
    end;
  end;
  if marc>0 then
    FRel.Video;
  Sistema.endProcess('');
end;

function TFBoletos.GetDigitoX(xbanco, xnumero: string): string;
//////////////////////////////////////////////////////////////////
var r:string;
    resto:integer;
begin
  if xbanco='422' then begin
    r:=Modulo11(xnumero,9,resto) ;
    if resto = 0 then
      r := '1'
    else if resto = 1 then
      r := '0';
  end else begin
    r:=Modulo11(xnumero,length(xnumero)+1,resto) ;
    if resto = 0 then
      r := '1'
    else if resto = 1 then
      r := '0';
  end;
  result:=r[1];

end;

// 12.12.14
procedure TFBoletos.SetaInstrucaoCobranca(xEd: TSqled);
///////////////////////////////////////////////////////
begin
  xEd.Items.Clear;
  if (EdBanco.text='748') then begin
    xEd.Items.Add('01 - Cadastro de Título');
    xEd.Items.Add('02 - Pedido de Baixa');
    xEd.Items.Add('04 - Concessão de Abatimento');
    xEd.Items.Add('05 - Cancelamento de Abatimento Concedido');
    xEd.Items.Add('06 - Alteração de Vencimento');
    xEd.Items.Add('08 - Alteração do seu Número');
    xEd.Items.Add('09 - Pedido de Protesto');
    xEd.Items.Add('18 - Sustar protesto e baixar título');
    xEd.Items.Add('19 - Sustar protesto e manter carteira');
    xEd.Items.Add('31 - Alteração de Outros Dados');
  end else if EdBanco.text='104' then begin
    xEd.Items.Add('01 - Entrada de Título');
    xEd.Items.Add('02 - Pedido de Baixa');
    xEd.Items.Add('03 - Concessão de Abatimento');
    xEd.Items.Add('04 - Cancelamento de Abatimento');
    xEd.Items.Add('05 - Alteração de Vencimento');
    xEd.Items.Add('06 - Alteração do uso da Empresa');
    xEd.Items.Add('07 - Alteração do Prazo de Protesto');
    xEd.Items.Add('08 - Alteração do Prazo de Devolução');
    xEd.Items.Add('09 - Alteração de outros dados');
    xEd.Items.Add('10 - Alt de dados c/ emissão / emissão de bloqueto');
    xEd.Items.Add('11 - Alteração da opção de Protesto para Devolução');
    xEd.Items.Add('12 - Alteração da opção de Devolução para Protesto');
  end else begin
    xEd.Items.Add('01 - Cadastro de Título');
    xEd.Items.Add('02 - Pedido de Baixa');
    xEd.Items.Add('04 - Concessão de Abatimento');
    xEd.Items.Add('05 - Cancelamento de Abatimento Concedido');
    xEd.Items.Add('06 - Alteração de Vencimento');
    xEd.Items.Add('08 - Alteração do seu Número');
    xEd.Items.Add('09 - Pedido de Protesto');
    xEd.Items.Add('18 - Sustar protesto e baixar título');
    xEd.Items.Add('19 - Sustar protesto e manter carteira');
    xEd.Items.Add('31 - Alteração de Outros Dados');
  end;
end;

procedure TFBoletos.GridPedidosKeyPress(Sender: TObject; var Key: Char);
begin
//////   showmessage('Teclou a letra '+key );
end;

end.
