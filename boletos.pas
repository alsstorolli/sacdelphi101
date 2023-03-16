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
  DB, DBClient,ACBrBoletoConversao,
  SimpleDS, SqlSis, Printers, ACBrBoletoFCFortesFr, RLReport, ACBrMail, PCNConversao,
  ACbrDFeSSl, blcksock ;


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
    AcbrBoleto1: TACBrBoleto;
    TMovesto: TSQLDs;
    datas: TDataSource;
    BoletoImagem: TFreeBoletoImagem;
    EdTodos: TSQLEd;
    EdCliente: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdNumeros: TSQLEd;
    EdVencimento: TSQLEd;
    sdpdf: TSaveDialog;
    ACBrMail1: TACBrMail;
    bemail: TSQLBtn;
    ACBrBoletoFCFortes1: TACBrBoletoFCFortes;
    benviabolpix: TSQLBtn;
    brecnossonumero: TSQLBtn;
//    ACBrBoletoFCFortes1: TACBrBoletoFCFortes;
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
    procedure EdInstrucaoCobChange(Sender: TObject);
    procedure EdTodosValidate(Sender: TObject);
    procedure EdSomaValidate(Sender: TObject);
    procedure EdPort_codigoValidate(Sender: TObject);
    procedure bemailClick(Sender: TObject);
    procedure benviabolpixClick(Sender: TObject);
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure brecnossonumeroClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(unidade:string='';portador:string='';inicio:TDatetime=0;termino:TDatetime=0;ntransacao:string='');
    procedure ImprimeUmaNota(ntransacao:string);
    procedure CriaBoleto(Q:TSqlquery ; xCodigoBanco:string='' ; xNotasSomadas:string=''; xImpressao:string='S');
    procedure SetaCarteira(EditCarteira:TSqled ; codigobanco:string);
    procedure GeraLista(Q:TSqlquery);
    function GetDigitoX(xbanco,xnumero:string):string;
    procedure SetaInstrucaoCobranca(xEd:TSqled);
  end;

var
  FBoletos: TFBoletos;
  sqlaberto,sqldeposito,sqldata,sqlunidades,sqldatacont,sqlportador,xtransacao,
  ondesalvar,faixai,faixaf,NotasSomadas,sqltodos,temdesconto:string;
  Chequesmarcados,TamAgencia,
  TamConta:integer;
  QBanco:TSqlquery;
  B:TFreeBoleto;
//  B:TAcbrBoleto;
  Titulo:TAcbrTitulo;
  GeracaoRemessa:boolean;

implementation


uses Geral, Sqlfun, Unidades, munic, Emitentes, Cadcheq, plano,
  nfsaida, SQLRel, portador, StrUtils, gerencianfe, gerapdf;

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
// 13.02.17
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
    end;
  end;
  if Properties <> nil then
    FreeMem(Properties, FSize);
end;

procedure TFBoletos.EdDtFimValidate(Sender: TObject);
begin
  if EdDtfim.asdate<EdDtinicio.asdate then
    EdDtfim.Invalid('Data final tem que ser maior que inicial');

end;

procedure TFBoletos.EdInstrucaoCobChange(Sender: TObject);
begin

end;

// 10.10.19 - Novicarnes - Sandro
procedure TFBoletos.EdPort_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin

  EdBanco.Enabled:=true;

  if not EdPort_codigo.IsEmpty then begin

     if EdPort_codigo.ResultFind<>nil then begin

        if EdPort_codigo.ResultFind.FieldByName('port_plan_conta').AsInteger>0 then begin

           EdBanco.Text:=EdPort_codigo.ResultFind.FieldByName('port_plan_conta').AsString;
           EdBanco.Valid;
           EdBanco.Enabled:=false;

        end;

     end;

  end;


end;

// 11.01.18
procedure TFBoletos.EdSomaValidate(Sender: TObject);
///////////////////////////////////////////////////////
begin

  EdVencimento.Enabled:=(EdSoma.Text='S');
  EdVencimento.SetDate(EdDtFim.AsDate);

end;

// 22.09.17
procedure TFBoletos.EdTodosValidate(Sender: TObject);
///////////////////////////////////////////////////////
begin
  if EdTodos.Text='B' then EdNumeros.Enabled:=true else EdNumeros.Enabled:=false;

end;

// 01.10.2021 - A2z + Guiber
procedure TFBoletos.Edunid_codigoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
var p : integer;
    Lista : TStringList;

    function EstaNaUnidade( xportador:string ):boolean;
    ////////////////////////////////////////////////////
    var Qp,
        Qc:TSqlquery;
    begin

       result := false;
       Qp := sqltoquery('select port_plan_conta from portadores where port_codigo = '+Stringtosql(xportador)) ;
       if not QP.eof then begin

          Qc := sqltoquery('select plan_unid_codigo from plano where Plan_conta = '+inttostr(Qp.fieldbyname('port_plan_conta').asinteger));
          if not Qc.eof then begin

             if Qc.fieldbyname('plan_unid_codigo').asstring = EdUNid_codigo.text then

                result := true;

          end;
          FGeral.FechaQuery( Qc );
       end;

       FGeral.FechaQuery( Qp );

    end;


begin

      if Global.Topicos[1518] then begin

         EdPort_codigo.clear;
         Lista := TStringList.create;
         strtolista(Lista,Fgeral.Getconfig1asstring('Portaboletos'),';',true);
         EdPort_codigo.Items.clear;
         for p:=0 to Lista.count-1 do begin

              if EstaNaUnidade( Lista[p] ) then

                 EdPort_codigo.Items.Add(Lista[p]+' - '+FPortadores.GetDescricao(Lista[p]) );


         end;

     end;

end;

procedure TFBoletos.EdDtFimExitEdit(Sender: TObject);
var QPedidos:TMemoryQuery;
    SqlOrder,sqlcliente,w,xstatus,sqlnumeros:string;

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
// 28.04.18
             GridPedidos.cells[GridPedidos.getcolumn('pend_opantecipa'),x]:=QPedidos.fieldbyname('pend_opantecipa').asstring;
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
    xstatus:='N';
// 14.07.17
    sqltodos:='';
    if Edtodos.Text='N' then sqltodos:=' and pend_opantecipa is null'
    else if EdTodos.Text='B' then begin
       sqltodos := ' and pend_databaixa is not null';
       xstatus:='B;K';
    end;
// 21.09.17
    sqlcliente:='';
    if not Edcliente.IsEmpty then sqlcliente:=' and pend_tipo_codigo = '+Edcliente.AsSql;
// 22.09.17
    sqlnumeros:='';
    if (not EdNUmeros.IsEmpty) and ( EdTodos.Text='B' ) then sqlnumeros:= ' and '+FGeral.GetIN('pend_numerodcto',EdNumeros.Text,'C');

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
    else begin
      w:='select * from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
                   ' where '+FGeral.GetIN('pend_status',xstatus,'C')+
//                   ' and pend_tipocad=''C'''+
// 28.09.11 - Novi - Elize - devolu��o de compra total ou parcial
                  ' and '+FGeral.GetIn('pend_tipocad','C;F','C')+
                   sqlportador+sqltodos+sqlcliente+sqlnumeros+
                   sqldatacont+sqlaberto+sqldata+sqlunidades+sqldeposito+
                   sqlorder ;
      QPedidos:=sqltomemoryquery( w );
    end;

    if QPedidos.eof then begin
      Avisoerro('N�o encontrado documentos em aberto no periodo OU remessa j� enviada');
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

    function EstaNaUnidade( xportador:string ):boolean;
    ////////////////////////////////////////////////////
    var Qp,
        Qc:TSqlquery;
    begin

       result := false;
       Qp := sqltoquery('select port_plan_conta from portadores where port_codigo = '+Stringtosql(xportador)) ;
       if not QP.eof then begin

          Qc := sqltoquery('select plan_unid_codigo from plano where Plan_conta = '+inttostr(Qp.fieldbyname('port_plan_conta').asinteger));
          if not Qc.eof then begin

             if Qc.fieldbyname('plan_unid_codigo').asstring = EdUNid_codigo.text then

                result := true;

          end;
          FGeral.FechaQuery( Qc );
       end;

       FGeral.FechaQuery( Qp );

    end;

begin

   FGeral.ConfiguraColorEditsNaoEnabled(FBoletos);
   FGeral.EstiloForm(FBoletos);
//   if FindWindow( PAnsiChar('TForm'),Pansichar('FNotaSaida') ) >0 then
//     FNotaSaida.SendToBack;
/////////////   AcbrBoletofcfr1.ACBrBoleto:=Acbrboleto1;
///
   benviabolpix.visible := Global.Topicos[1517];
   benviabolpix.Enabled := Global.Topicos[1517];

   Show;

// 05.08.2022 - homologa��o CEF 'exige pdf original'
   AcbrBoletoFCFortes1.Dirlogo := ExtractFilePath( Application.exename );

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
     EdPort_codigo.Text:=portador;
     EdPort_codigo.Next;
     EdBanco.setvalue(FPortadores.GetConta(portador));
//     EdBanco.ValidFind;
     EdBanco.Next;
     EdInstrucaoCob.Next;
     bimprimirClick(self);

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


       if Global.Topicos[1518] then EdPort_codigo.clear;
       for p:=0 to Lista.count-1 do begin

// 01.10.2021 - A2z + Guiber
         if Global.Topicos[1518] then begin

            if EstaNaUnidade( Lista[p] ) then

               EdPort_codigo.Items.Add(Lista[p]+' - '+FPortadores.GetDescricao(Lista[p]) );

         end else if trim(Lista[p])<>'' then

            EdPort_codigo.Items.Add(Lista[p]+' - '+FPortadores.GetDescricao(Lista[p]) );

       end;

     end;
// 08.03.17
     EdPort_codigo.empty:=false;

   end else begin

     EdPort_codigo.ShowForm:='FPortadores';
     EdPort_codigo.Items.Clear;
     EdPort_codigo.empty:=true;

   end;
// 10.06.10
   TamAgencia:=4;
// 07.02.18 - Giacomoni - Barbara
   if Global.Topicos[1295] then EdTodos.Text:='S';
// 16.04.18
   campo:=Sistema.GetDicionario('clientes','clie_DescontoVenda');
   if campo.Tipo<>'' then begin
      TemDesconto:='S';
   end else begin
      TemDesconto:='N';
   end;

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
      EdBAnco.invalid('Codigo do Banco n�o configurado nas contas gerenciais')
    else
      SetaCarteira(EdCarteira,QBanco.fieldbyname('Plan_codigobanco').asstring);
// 02.02.11
    if trim(QBanco.fieldbyname('Plan_codigobanco').asstring)='422' then begin

//      faixai:='3530';
//      faixaf:='3531';
//      faixai:=inttostr( FGeral.GetContador('FAIXANNUM'+QBanco.fieldbyname('Plan_codigobanco').asstring,false,false) );
//      if strtoint(faixai)<3530 then faixai:='3530';

    end else if trim(QBanco.fieldbyname('Plan_codigobanco').asstring)='748' then begin

      GridPedidos.CanFind:=false;

    end;

 end else
    EdBAnco.invalid('Banco n�o encontrado');

end;

procedure TFBoletos.bimprimirClick(Sender: TObject);
//////////////////////////////////////////////////////////
var p:integer;
    op,ximpressora,xsta:string;
    Q:TSqlquery;
    x:TFreeBoleto;
//    x:TAcbrBoleto;
    ListaNotas:TStringList;

begin

  BoletoImagem.ListaBoletos.clear;
  GeracaoRemessa:=false;
  NotasSomadas:='';
  ListaNotas:=TStringList.create;
  ACbrboleto1.ListadeBoletos.Clear;
  xsta:='N';
  if EdTodos.Text='B' then xsta:='B;K';

  for p:=1 to GridPedidos.RowCount do begin

    op:=GridPedidos.Cells[GridPedidos.getcolumn('pend_operacao'),p];

    if (trim(op)<>'') and (trim(GridPedidos.Cells[GridPedidos.getcolumn('marcado'),p])<>'') then begin
        Q:=sqltoquery('select * from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
//                     ' where pend_status=''N'''+
// 21.09.17
                     ' where '+FGeral.GetIN('pend_status',xsta,'C')+
                     ' and '+FGeral.GetIN('pend_tipocad','C;F','C')+
                     ' and pend_operacao='+stringtosql(op));
        if not Q.eof then begin
// 25.03.14
          if EdSoma.text='S' then begin

            if ListaNotas.IndexOf(Q.fieldbyname('pend_numerodcto').AsString)=-1 then begin
              NotasSomadas:=NotasSomadas+Q.fieldbyname('pend_numerodcto').AsString+';';
              ListaNotas.Add(Q.fieldbyname('pend_numerodcto').AsString);
            end;

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
//         break;
// 11.01.18 - Vida Nova
         if not EdVencimento.isempty then begin
           if not Q.Eof then begin
             Sistema.Edit('pendencias');
             Sistema.SetField('pend_datavcto',EdVencimento.AsDate);
             Sistema.Post('pend_operacao = '+stringtosql(op));
             Sistema.Commit;
           end;
         end;
      end;
    end;
// 02.04.14
//    if (EdCarteira.text='017') and (QBanco.fieldbyname('Plan_codigobanco').asstring='756') then
// 28.07.15 - simar
    if (EdCarteira.text='17') and (QBanco.fieldbyname('Plan_codigobanco').asstring='756') then
      CriaBoleto(Q,'001',NotasSomadas)
    else
      CriaBoleto(Q,'',NotasSomadas);

// 24.08.2021 - impressao pelo acbr e com o pix...
    if not Global.Topicos[1517] then begin

      x:=TFreeBoleto.create(nil);
      CloneProperties(b,x);
      BoletoImagem.ListaBoletos.Add(x);

    end;


  end;

// 16.03.11
//  if QBanco<>nil then                               // 26.08.14 - retirado 104 CEF - 22.11.14 recolocado
    if pos(QBanco.fieldbyname('Plan_codigobanco').asstring,'756;748;104;237')>0 then

      BoletoImagem.DrawLogotipo:=true;
// 16.03.11
//  if QBanco.fieldbyname('Plan_codigobanco').asstring='422' then
//    FGeral.AlteraContador('FAIXANNUM'+B.Cedente.CodigoBanco,strtoint(faixai));
//    FGeral.AlteraContador('FAIXANNUM'+QBanco.fieldbyname('Plan_codigobanco').asstring,strtoint(faixai));

   AcbrBoleto1.Cedente.Nome:=Ups(EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring);
   AcbrBoleto1.Cedente.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
   AcbrBoleto1.Cedente.ResponEmissao:=tbCliEmite;
   AcbrBoleto1.Cedente.Logradouro:=EdUnid_codigo.ResultFind.fieldbyname('unid_endereco').asstring;
// 24.03.18
   AcbrBoleto1.Cedente.Logradouro:=EdUnid_codigo.ResultFind.fieldbyname('unid_endereco').asstring;
// 04.03.15 para imprimir o tal 'posto do beneficiario'
//   if QBanco.fieldbyname('Plan_codigobanco').asstring='748' then
//     Acbrboleto1.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('Plan_agencia').asstring,6,2);



//   AcbrBoletofcfr1.Imprimir; - Fast
//   ACBrBoletoFCQuick1.Imprimir; - Quick

///////////  Acbrboleto1.ListadeBoletos.Clear;
///  24.03.18
// 10.04.17
  ximpressora:=trim( LeArquivoINI(Global.NomeSistema,'Impressoras','IMPBOLETO') );
  if (ximpressora)='' then ximpressora:=Printer.Printers[ Printer.PrinterIndex ];
//  if Printer.Printers.IndexOfName( ximpressora ) <> -1 then begin
  for p:=0 to Printer.Printers.count-1 do begin

     if Printer.Printers[p]=ximpressora then begin
         Printer.PrinterIndex:=Printer.Printers.IndexOfName( ximpressora );
//         Papel.Width  := Printer.PageWidth;
//         Papel.Height := Printer.PageHeight;
    end;

  end;

// 23.06.18 - retirado pra ver se 'estabiliza' giacomoni/barbara
//  if AnsiPos( QBanco.FieldByName('Plan_codigobanco').AsString,'104')>0 then begin
//    AcbrBoleto1.ACBrBoletoFC.MostrarPreview:=true;
//    ACBrBoleto1.Imprimir;
//  end else

// 24.08.2021 - impressao pelo acbr e com o pix...
    if Global.Topicos[1517] then begin

      AcbrBoleto1.ACBrBoletoFC.MostrarPreview:=true;
      AcbrBoleto1.Banco.Tipocobranca := cobBancodoBrasilAPI;
// criar campo na config. do portador pra guardar
      AcbrBoleto1.Cedente.CedenteWS.ClientID     := 'eyJpZCI6ImQ5MDY0MyIsImNvZGlnb1B1YmxpY2Fkb3IiOjAsImNvZGlnb1NvZnR3YXJlIjoyMTI3OCwic2VxdWVuY2lhbEluc3RhbGFjYW8iOjF9';
      AcbrBoleto1.Cedente.CedenteWS.ClientSecret :=
      'eyJpZCI6IjBjZTllNDAtYTg5YS00YzE1LTk5MGMtNzA1NyIsImNvZGlnb1B1YmxpY2Fkb3IiOjAsImNvZGlnb1NvZnR3YXJlIjoyMTI3OCwic2VxdWVuY2lhbEluc3RhbGFjYW8iOjEsInNlcXVlbmNpYWxDcmVkZW5jaWFsIjoxLCJhbWJpZW50ZSI6ImhvbW9sb2dhY2FvIiwiaWF0IjoxNjI5ODI4ODA0MzI5fQ';
      AcbrBoleto1.Cedente.CedenteWS.Scope        := 'cobrancas.boletos-info cobrancas.boletos-requisicao';
      AcbrBoleto1.Cedente.CedenteWS.KeyUser      := 'developer_application_key';
      AcbrBoleto1.Cedente.CedenteWS.IndicadorPix := True;

      AcbrBoleto1.Configuracoes.WebService.Ambiente    := tahomologacao;
      AcbrBoleto1.Configuracoes.WebService.Operacao    := tpinclui;
      AcbrBoleto1.Configuracoes.WebService.SSLCryptLib := cryopenSSL;
      AcbrBoleto1.Configuracoes.WebService.SSLHttpLib  := httpOpenSSL;
      AcbrBoleto1.Configuracoes.WebService.SSLType     := LT_TLSV1_2;
      AcbrBoleto1.Configuracoes.WebService.UseCertificateHTTP     := false;


      ACBrBoleto1.Imprimir;

    end else begin

     if xtransacao='' then

        BoletoImagem.ShowPreview

     else

        BoletoImagem.ShowPreview('N');

    end;

// 24.03.18
//  AcbrBoleto1.ACBrBoletoFC.CarregaLogo;
//  if sdpdf.Execute then
//    AcbrBoleto1.ACBrBoletoFC.NomeArquivo:=sdpdf.FileName
//  else
//    AcbrBoleto1.ACBrBoletoFC.NomeArquivo:=ExtractFilePath( Application.ExeName ) + 'Boleto';


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
procedure TFBoletos.CriaBoleto(Q: TSqlquery ; xCodigoBanco:string='' ; xNotasSomadas:string=''; xImpressao:string='S');
///////////////////////////////////////////////////////////////////////////////////////////////////
var NossoNumeroSafra,UnidadeCedente,Aux,DAtaatual:String;
    ContadorNossoNumero,numseq,FaixaNossoNumero:integer;
    QForne:TSqlquery;


    //////////////////////// 26.05.11
    procedure GravaSequencial( xoperacao,xbanco:string ; var  xnumseq:integer );
    //////////////////////////////////////////////////////////////////////////
    var QP:TSqlquery;
    begin
      if EdTodos.Text='B' then
        Qp:=sqltoquery('select pend_lotecnab,pend_dataemissao from pendencias where pend_operacao='+Stringtosql(xoperacao)+
                       ' and pend_status=''B''')
      else
        Qp:=sqltoquery('select pend_lotecnab,pend_dataemissao from pendencias where pend_operacao='+Stringtosql(xoperacao)+
                       ' and pend_status=''N''');
      xnumseq:=0;
      if not QP.Eof then begin
// so grava 'a primeira vez', ou seja, quando imprime o boleto para q na remessa fique
// o mesmo sequencial
        if Qp.fieldbyname('pend_lotecnab').asinteger=0 then begin

//          xnumseq:=FGeral.GetContador('BOL'+xbanco+strzero(DatetoAno(Sistema.Hoje,true),4),false );
// 12.01.2021 - Pato Polpas - boleto impresso em 12.2020 mas remessa gerada em 01.2021 .
//              dai n�o registrou o boleto
          xnumseq:=FGeral.GetContador('BOL'+xbanco+strzero(DatetoAno(Qp.fieldbyname('pend_dataemissao').asdatetime,true),4),false );
// 11.11.2021 - Guiber - boletos em contas de unidades diferentes no mesmo banco...
//          xnumseq := FGeral.GetContador('BOL'+xbanco+EdUNid_codigo.text+strzero(DatetoAno(Qp.fieldbyname('pend_dataemissao').asdatetime,true),4),false );
// 12.11.2021 - desfeito guiber deixado igual novicarnes ...
          Sistema.Edit('pendencias');
          Sistema.SetField('pend_lotecnab',xnumseq);
          Sistema.Post('pend_operacao='+Stringtosql(xoperacao)+' and pend_status=''N''');
          try
            Sistema.Commit;
          except
            Avisoerro('Problemas no banco.  N�o foi poss�vel gravar o sequencial da opera��o '+xoperacao);
            Application.Terminate;
          end;

        end else

            xnumseq:=Qp.fieldbyname('pend_lotecnab').asinteger;


      end;
      FGeral.FechaQuery(Qp);
    end;

// 05.06.20 - Vida Nova
    function NaoforClienteDescontoLiquido( xcodcli:integer ):boolean;
    //////////////////////////////////////////////////////////////////
    begin

        result := true;
        if FGeral.GetConfig1AsInteger('cliedescontoliq')>0 then begin

           if FGeral.GetConfig1AsInteger('cliedescontoliq') = xcodcli then
              result := false;

        end;

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
// 24.03.18
        Titulo.ACBrBoleto.Cedente.Nome:=ups(EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring);
        Titulo.ACBrBoleto.Cedente.Logradouro:=EdUnid_codigo.ResultFind.fieldbyname('unid_endereco').asstring;
        Titulo.ACBrBoleto.Cedente.Cep:=EdUnid_codigo.ResultFind.fieldbyname('unid_cep').asstring;
        Titulo.ACBrBoleto.Cedente.Cidade:=EdUnid_codigo.ResultFind.fieldbyname('Unid_municipio').asstring;
        Titulo.ACBrBoleto.Cedente.Uf:=EdUnid_codigo.ResultFind.fieldbyname('Unid_uf').asstring;

////////////////////////////
// 10.08.16
      Titulo.Referencia:=Q.fieldbyname('pend_operacao').asstring;

// 11.01.18
      if ( trim(xNotasSomadas)<>'' ) and (EdSoma.text='S') then
          B.Instrucoes.Add('Notas : '+xNotasSomadas);

      if QBanco.fieldbyname('Plan_codigobanco').asstring='341' then begin

        B.carteira := FBoletos.edCarteira.text; //
        B.LocalPagamento:='At� o Vencimento, Preferencialmente no ITAU, Ap�s SOMENTE no Itau';
        b.aceite:='S';

        Acbrboleto1.Banco.TipoCobranca:=cobItau;
        Titulo.carteira := FBoletos.edCarteira.text; //
        Titulo.LocalPagamento:='At� o Vencimento, Preferencialmente no ITAU, Ap�s SOMENTE no Itau';
        Titulo.Aceite:=atsim;
        b.Especie:='R$';
        b.EspecieDoc:='DMI';
        if Titulo.Carteira='112' then
          Titulo.EspecieDoc:='DMI';
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          B.Instrucoes.Add('Ap�s o vencimento cobrar mora de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000))+' ao dia');
// 19.06.10
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          B.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));

        B.Instrucoes.Add('Sujeito a protesto se n�o for pago no vencimento');
        B.Instrucoes.Add('Cobran�a Escritural');
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
          Titulo.Mensagem.Add('Ap�s o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
//        B.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*0.02));
// 19.06.10
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          Titulo.Mensagem.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));

          Titulo.Mensagem.Add('Sujeito a protesto se n�o for pago no vencimento');
          Titulo.Mensagem.Add('Cobran�a Escritural');
          Titulo.Mensagem.Add('');
          Titulo.Mensagem.Add('Apos vcto acesse www.itau.com.br/boletos para atualizar seu boleto');

// 07.06.10 - Novicarnes - Elize
///////////////////////////////////////
      end else if ( QBanco.fieldbyname('Plan_codigobanco').asstring='001' ) or
                  (   ( QBanco.fieldbyname('Plan_codigobanco').asstring='756' ) and (EdCArteira.text='17' ) )
        then begin

////////////////////////////////////////////////////////////////
        B.carteira := FBoletos.edCarteira.text; // na remessa tem 2 digitos 017=17
        B.LocalPagamento:='Pag�vel em Qualquer Banco at� o Vencimento';
        B.Aceite:='N';
        B.EspecieDoc:='DM';
// 16.01.2020
        B.Valor:= Q.fieldbyname('pend_valor').ascurrency;

        if EdSoma.text='S' then begin

          B.Valor:=EdTotalMarcado.AsCurrency;
          B.Vencimento:=EdVencimento.AsDate;
          Titulo.ValorDocumento:=EdTotalMarcado.AsCurrency;
          Titulo.Vencimento:=EdVencimento.AsDate;
          Titulo.TotalParcelas:=1;
          Titulo.Parcela:= 1;

        end;

        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          B.Instrucoes.Add('Ap�s o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor( b.Valor*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
//        B.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*0.02));
// 19.06.10
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          B.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,b.Valor*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
//          B.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,roundvalor( Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100) ) ));
//        B.Instrucoes.Add('Sujeito a protesto se n�o for pago no vencimento');
        if FGeral.GetConfig1AsInteger('DIASVENBOLETO')>0 then
           B.Instrucoes.Add('Sujeito a protesto ap�s '+inttostr(FGeral.GetConfig1AsInteger('DIASVENBOLETO'))+'o. dia �til ap�s vencimento')
        else
           B.Instrucoes.Add('Protestar 5o. dia �til ap�s o vencimento');
// 02.07.13 - Simar
        B.Instrucoes.Add(Q.fieldbyname('pend_complemento').asstring);
// 26.03.14 - Simar
        if trim(xNotasSomadas)<>'' then begin
/////          B.Instrucoes.Add(xNotasSomadas);  // 16.01.20 - retirado pois ja faz acima
///  //                                                        para todos os bancos
          b.NossoNumero :=strzero( strtoint(Q.fieldbyname('pend_numerodcto').asstring+
                                 Q.fieldbyname('pend_parcela').asstring),07);
        end else
// 29.08.12
          b.NossoNumero :=strzero( strtoint(Q.fieldbyname('pend_numerodcto').asstring+
                                 Q.fieldbyname('pend_parcela').asstring),07);

        B.Cedente.CodigoBanco :=QBanco.fieldbyname('Plan_codigobanco').asstring ;
        B.Cedente.Cnpjcpf:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
//        if ( QBanco.fieldbyname('Plan_codigobanco').asstring='756' ) and (EdCArteira.text='17' ) then begin
// 10.12.10
        if ( EdCArteira.text='17' ) then begin

//          B.Cedente.Nome:='VIDE CAMPO SACADOR/AVALISTA ABAIXO';
//          B.Cedente.Endereco:='';
          b.Cedente.Nome:=EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring;
          b.Cedente.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
//          B.Cedente.Avalista:=Ups(EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring);

//          Titulo.Sacado.SacadoAvalista.Pessoa:=pJuridica;
//          Titulo.Sacado.SacadoAvalista.NomeAvalista:=Ups(EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring);
//          Titulo.Sacado.SacadoAvalista.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;

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
        Titulo.LocalPagamento:='Pag�vel em Qualquer Banco at� o Vencimento';
        Titulo.Aceite:=atnao;
        Titulo.EspecieDoc:='DM';
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          Titulo.Mensagem.Add('Ap�s o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
//        B.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*0.02));
// 19.06.10
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          Titulo.Mensagem.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
//          B.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,roundvalor( Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100) ) ));
//        B.Instrucoes.Add('Sujeito a protesto se n�o for pago no vencimento');
        if FGeral.GetConfig1AsInteger('DIASVENBOLETO')>0 then begin

           Titulo.Mensagem.Add('Sujeito a protesto ap�s '+inttostr(FGeral.GetConfig1AsInteger('DIASVENBOLETO'))+'o. dia �til ap�s vencimento');
           Titulo.DataProtesto    := Q.fieldbyname('pend_datavcto').asdatetime+FGeral.GetConfig1AsInteger('DIASVENBOLETO');
           Titulo.DiasDeProtesto  :=FGeral.GetConfig1AsInteger('DIASVENBOLETO');

        end else begin

           Titulo.DataProtesto    := Q.fieldbyname('pend_datavcto').asdatetime+1;
           Titulo.Mensagem.Add('Protestar 5o. dia �til ap�s o vencimento');
           Titulo.DiasDeProtesto  := 5;

        end;
// 02.07.13 - Simar
        Titulo.Mensagem.Add(Q.fieldbyname('pend_complemento').asstring);

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
          B.Cedente.CodigoCedente :=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1, 5) ;
          B.Cedente.ContaCorrente:=padl(copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5),8,'0') ;
          Titulo.Acbrboleto.Cedente.CodigoCedente :=copy(QBanco.fieldbyname('Plan_convenio').asstring,7,6) ;
          Titulo.Acbrboleto.Cedente.Conta:=padl(copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5),8,'0') ;
          Titulo.Acbrboleto.Cedente.Modalidade:='01';   // - simples com registro
          Acbrboleto1.Banco.TipoCobranca:=cobBancoob

        end else begin

          Acbrboleto1.Banco.TipoCobranca          := cobBancoDoBrasil;
          Titulo.Acbrboleto.Cedente.CodigoCedente := copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5) ;
          Titulo.Acbrboleto.Cedente.Conta         := copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5) ;
          B.Cedente.CodigoCedente                 := copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5) ;
          B.Cedente.ContaCorrente                 := copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5) ;
// 10.12.19 - Simar
          B.Cedente.Banco001.Convenio             := QBanco.fieldbyname('Plan_convenio').asstring;
          Titulo.ACBrBoleto.Cedente.Convenio      := QBanco.fieldbyname('Plan_convenio').asstring ;

        end;

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
// 10.12.19
        Titulo.NumeroDocumento               := PAdl(Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring,07,'0');
        Titulo.ACBrBoleto.Cedente.Modalidade := '019';
        Titulo.DataMoraJuros                 := Q.fieldbyname('pend_datavcto').asdatetime+1;
// 26.08.2021
        if Global.Topicos[1517] then begin

           Titulo.ACBrBoleto.Cedente.Modalidade := '035';

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
        B.LocalPagamento:='PREFERENCIALMENTE NAS CASAS LOT�RICAS AT� O VALOR LIMITE';
//        B.Instrucoes.Add('Todas as informa��es deste bloqueto s�o de exclusiva responsabilidade do cedente');
// 30.03.11 - email retorno CEF..sem coment�rio
//        B.Instrucoes.Add('(Todas as informa��es deste bloqueto s�o de exclusiva responsabilidade do cedente)');
// 20.08.14
        B.Instrucoes.Add('');
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          B.Instrucoes.Add('Ap�s o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          B.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
        B.Instrucoes.Add('N�o receber ap�s 30 dias de atraso');
        if FGeral.GetConfig1AsInteger('DIASVENBOLETO')>0 then
          B.Instrucoes.Add('Sujeito a protesto ap�s '+inttostr(FGeral.GetConfig1AsInteger('DIASVENBOLETO'))+' dias do vencimento')
        else
          B.Instrucoes.Add('Sujeito a protesto se n�o for pago no vencimento');
//
//        B.Instrucoes.Add('SAC CAIXA: 0800 726 0101 (informa��es, reclama��es, sugest�es e elogios)');
//        B.Instrucoes.Add('Para pessoas com defici�ncia auditiva ou de fala: 0800 726 2492');
//        B.Instrucoes.Add('Ouvidoria: 0800 725 7474 - caixa.gov.br');

//////////////////////////////////////////////////////////////////////
        Titulo.ACBrBoleto.Banco.TamanhoMaximoNossoNum:=15;

        if pos( copy(FBoletos.edCarteira.text,1,1) ,'S;C;R')>0 then
          Titulo.carteira := trim(FBoletos.edCarteira.text)
        else
          Titulo.carteira := copy(FBoletos.edCarteira.text,3,1); // tem 1 digito

// 28.09.18
{  -- nao deixa 'obrigatorio por enquanto
        if FBoletos.edCarteira.text='RG' then begin

          if FGeral.GetConfig1AsInteger('DIASVENBOLETO') > 0 then
             Titulo.DataProtesto:=Q.FieldByName('pend_datavto').AsDateTime + FGeral.GetConfig1AsInteger('DIASVENBOLETO')
          else
             Titulo.DataProtesto:=Q.FieldByName('pend_datavcto').AsDateTime + 5;

          Titulo.DataBaixa:=Q.FieldByName('pend_datavcto').AsDateTime + 30;

        end;
            }

        Titulo.EspecieDoc:='DM';
        Titulo.LocalPagamento:='PREFERENCIALMENTE NAS CASAS LOT�RICAS AT� O VALOR LIMITE';
//        B.Instrucoes.Add('Todas as informa��es deste bloqueto s�o de exclusiva responsabilidade do cedente');
// 30.03.11 - email retorno CEF..sem coment�rio
//        B.Instrucoes.Add('(Todas as informa��es deste bloqueto s�o de exclusiva responsabilidade do cedente)');
// 20.08.14
        Titulo.Mensagem.Add('');
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          Titulo.Mensagem.Add('Ap�s o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          Titulo.Mensagem.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
        Titulo.Mensagem.Add('N�o receber ap�s 30 dias de atraso');
        if FGeral.GetConfig1AsInteger('DIASVENBOLETO')>0 then
          Titulo.Mensagem.Add('Sujeito a protesto ap�s '+inttostr(FGeral.GetConfig1AsInteger('DIASVENBOLETO'))+' dias do vencimento')
        else
          Titulo.Mensagem.Add('Sujeito a protesto se n�o for pago no vencimento');
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

        Acbrboleto1.Banco.TipoCobranca:=cobCaixaEconomica;

        Titulo.ACBrBoleto.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring ;
        Titulo.ACBrBoleto.Cedente.Conta:=strzero( strtoint(QBanco.fieldbyname('Plan_contacorrente').asstring) ,6)  ;

        Titulo.NossoNumero     := strzero(Datetoano(Q.fieldbyname('pend_dataemissao').asdatetime,true),4)+Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring;
        Titulo.NumeroDocumento := Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring;

// 29.01.19 - Seip
        Titulo.OcorrenciaOriginal.Tipo:=toRemessaRegistrar;
        if copy(EdInstrucaocob.Text,1,2) = '06' then
           Titulo.OcorrenciaOriginal.Tipo:=toRemessaAlterarVencimento;


//        Titulo.ACBrBoleto.Banco.CodOcorrenciaToTipo( StrtoIntDef(copy(EdInstrucaocob.Text,1,2) ,0) );

//        Titulo.OcorrenciaOriginal.Tipo:=CodOcorrenciatotipo( StrtoIntDef(,0) );

        if EdSoma.text='S' then begin

          B.Valor:=EdTotalMarcado.AsCurrency;
          B.Vencimento:=EdVencimento.AsDate;
          Titulo.ValorDocumento:=EdTotalMarcado.AsCurrency;
          Titulo.Vencimento:=EdVencimento.AsDate;
          Titulo.TotalParcelas:=1;
          Titulo.Parcela:= 1;

        end;

/////////////////////////////////////////////////////////////////////////////////////////////////////

// 08.11.10 - Novicarnes - Elize - banco safra
// 17.01.20 - Novicarnes - Isonel + Sandro

      end else if QBanco.fieldbyname('Plan_codigobanco').asstring='422' then begin
/////////////////////////////////////////////////////////////////////////////////////////////////////

        B.carteira := copy(FBoletos.edCarteira.text,1,1);
        B.Aceite:='S';
        B.EspecieDoc:='DM';
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          B.Instrucoes.Add('Ap�s o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
//        B.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*0.02));
// 19.06.10
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          B.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
//          B.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,roundvalor( Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100) ) ));
        B.Instrucoes.Add('Sujeito a protesto se n�o for pago no vencimento');
        B.Instrucoes.Add('Este boleto representa duplicata cedida fiduciariamente ao banco SAFRA S/A,');
//        B.Instrucoes.Add('ficando vedado qualquer outra forma de pagamento que n�o seja atrav�s do presente boleto');
        B.Instrucoes.Add('ficando vedado qualquer outra forma de pagamento que n�o seja atrav�s deste');

        B.LocalPagamento:='Pag�vel em qualquer Banco do Sistema de Compensa��o';
        B.Aceite:='N';

      B.Cedente.Agencia :=QBanco.fieldbyname('Plan_agencia').asstring;
      B.Cedente.CodigoBanco := QBanco.fieldbyname('Plan_codigobanco').asstring;
      B.Cedente.Nome := FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring;
      b.Cedente.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;

      if trim(xcodigobanco)<>'' then B.Cedente.CodigoBanco := xcodigobanco;
      b.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_contacorrente').asstring;
//      if B.Carteira='17' then  b.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring;
//////////////
      B.Moeda := '9';  // ver se precisa criar campo ou configuracao

//      if pos(QBanco.fieldbyname('Plan_codigobanco').asstring,'341;001;748')>0 then begin
//        B.Cedente.Nome := B.Cedente.Nome + ' CNPJ:' + FormatoCgccpf( FBoletos.EdUNid_codigo.resultfind.fieldbyname('unid_cnpj').asstring );
//      end;

      // 27.01.14 - retirado
//      end else if ( pos(QBanco.fieldbyname('Plan_codigobanco').asstring,'237'])>0)  and (copy(FBoletos.edCarteira.text,2,2)='09') then
//        B.Cedente.Nome := 'BANCO SAFRA';

      B.DataDocumento := trunc(Q.fieldbyname('pend_dataemissao').asdatetime);
      B.Documento   := Q.fieldbyname('pend_numerodcto').asstring;
      B.NossoNumero := strzero( strtoIntDef(Q.fieldbyname('pend_numerodcto').asstring,0),7)+
                       strzero(Q.fieldbyname('pend_parcela').asinteger,2);

      B.Vencimento := Q.fieldbyname('pend_datavcto').asdatetime;
      if trim(xNotasSomadas)<>'' then
        b.Valor := EdTotalMarcado.ascurrency
      else
        b.Valor := Q.fieldbyname('pend_valor').ascurrency;

      B.Cedente.ContaCorrente :=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,6);

//        Titulo.Acbrboleto.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring ;
        Titulo.Acbrboleto.Cedente.CodigoCedente :=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,6) ;
        Titulo.Acbrboleto.Cedente.Conta:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,6);
        Titulo.Acbrboleto.Cedente.Modalidade:='01';   // - simples com registro
        Acbrboleto1.Banco.TipoCobranca:=cobBancoSafra;
        Titulo.Acbrboleto.Cedente.ContaDigito := UltimoDigito(QBanco.fieldbyname('Plan_contacorrente').asstring);
        Titulo.ACBrBoleto.Cedente.Agencia := copy(QBanco.fieldbyname('plan_agencia').AsString,1,4)+
// 17.08.20 - remessa exige 6 digitios na agencia..colocar zeros a direita...
                                             '00';
        Titulo.ACBrBoleto.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('plan_agencia').AsString,5,1);
        Titulo.Acbrboleto.Cedente.TipoInscricao := pJuridica;
        Titulo.Carteira:=copy(FBoletos.edCarteira.text,1,1);
        Titulo.NumeroDocumento:=trim(Q.fieldbyname('pend_numerodcto').asstring)+'/'+strzero( Q.fieldbyname('pend_parcela').asinteger,3);
        Titulo.EspecieDoc:='DM';   // Duplicata Mercantil

        Titulo.DataMulta :=Q.FieldByName('pend_datavcto').AsDateTime;
        Titulo.Instrucao2:='1';   // codigo de baixa/devolucao  1 - baixa e devolver..??

        Titulo.TotalParcelas:=Q.fieldbyname('pend_nparcelas').asinteger;
        Titulo.Parcela:= Q.fieldbyname('pend_parcela').asinteger;

        Titulo.ACBrBoleto.Cedente.ResponEmissao:=tbCliEmite;
        Titulo.NossoNumero := Q.fieldbyname('pend_numerodcto').asstring+strzero( Q.fieldbyname('pend_parcela').asinteger,2);

        Titulo.DataMoraJuros:=Q.FieldByName('pend_datavcto').AsDateTime;
        Titulo.SeuNumero:=trim(Q.fieldbyname('pend_numerodcto').asstring)+'/'+strzero( Q.fieldbyname('pend_parcela').asinteger,3);
        if EdSoma.text='S' then begin
          Titulo.ValorDocumento:=EdTotalMarcado.AsCurrency;
          Titulo.TotalParcelas:=1;
          Titulo.Parcela:= 1;
          Titulo.Vencimento:=EdVencimento.AsDate;
        end else
          Titulo.ValorDocumento:=B.Valor;
        Titulo.DataBaixa := Q.FieldByName('pend_datavcto').AsDateTime+30;


////////////////////////////////
// 12.11.10 - Banco Bradesco - refeito em 01.07.15
////////////////////////////////
      end  else if QBanco.fieldbyname('Plan_codigobanco').asstring='237' then begin
/////////////////////////////////////////////////////////////////////////////////////////////////////

// 24.09.2021 - conta do mesmo banco e agenca POREM com tamanhos diferentes tipo
//             6656-7 e  10983-5
// tratar pra impressao e geracao de remessa...
        tamconta := length( trim(QBanco.fieldbyname('Plan_contacorrente').asstring) );

        B.carteira := FBoletos.edCarteira.text;
        B.LocalPagamento:='Pag�vel Preferencialmente na rede Bradesco ou no Bradesco expresso';
        B.Aceite:='N';
        B.EspecieDoc:='DM';
        B.Instrucoes.Add('Todas as informa��es deste bloqueto s�o de exclusiva responsabilidade do cedente');
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          B.Instrucoes.Add('Ap�s o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          B.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
        B.Instrucoes.Add('Sujeito a protesto se n�o for pago no vencimento');

//        b.Cedente.CodigoCedente:=padl( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,7),7,'0' ) ;
// 03.02.2022 - Olstri
        B.Cedente.CodigoCedente:=padl( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,tamconta-1),7,'0' );
//        if b.carteira='09' then begin  // bradesco correspondente do safra
//          b.NossoNumero :=strzero(DatetoAno(Q.fieldbyname('pend_dataemissao').asdatetime,false) ,2 )+
//                         NossoNumeroSafra+GetDigito(NossoNumeroSafra,'MOD');
//          b.UsoDoBanco:='CIP130';
//          B.Cedente.ContaCorrente:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,7);
//        end else begin
        b.NossoNumero:= padl( Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring,11,'0');
//        B.Cedente.ContaCorrente:=padl( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,4),7,'0' );
// 15.05.2021
//        B.Cedente.ContaCorrente:=padl( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5),7,'0' );
// 24.09.2021 - pra prever contas com mais de 4 digitos ( fora o dig de controle )
        B.Cedente.ContaCorrente:=padl( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,tamconta-1),7,'0' );

// 16.07.19
        B.Cedente.DigitoContaCorrente := UltimoDigito(QBanco.fieldbyname('Plan_contacorrente').asstring);
        B.Cedente.Agencia:=copy(QBanco.fieldbyname('Plan_agencia').asstring,1,5);
//        end;
        B.Documento := PADL( Q.fieldbyname('pend_numerodcto').asstring+'/'+Q.fieldbyname('pend_parcela').asstring,11,'0');
        b.Cedente.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
////////////////////
        Acbrboleto1.Banco.TipoCobranca:=cobBradesco;
        Titulo.LocalPagamento:='Pag�vel em Qualquer Banco at� o Vencimento. Ap�s somente no Bradesco';
        Titulo.Aceite:=Atnao;
        Titulo.EspecieDoc:='DM';
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          Titulo.Mensagem.Add('Ap�s o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          Titulo.Mensagem.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
        if FGeral.GetConfig1AsInteger('DIASVENBOLETO')>0 then
          Titulo.Mensagem.Add('Protestar ap�s '+inttostr(FGeral.GetConfig1AsInteger('DIASVENBOLETO'))+' dias corridos do vencimento')
        else
          Titulo.Mensagem.Add('Sujeito a protesto se n�o for pago no vencimento');
//        Titulo.Carteira:=copy(FBoletos.edCarteira.text,1,1);
        Titulo.Carteira:=FBoletos.edCarteira.text;
        Titulo.NossoNumero :=padl( Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring,11,'0');
        Titulo.ACBrBoleto.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,4);
//        Titulo.ACBrBoleto.Cedente.Conta:=padl( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,4),7,'0' );
// 15.05.2021
//        Titulo.ACBrBoleto.Cedente.Conta:=padl( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5),7,'0' );
// 24.09.2021
        Titulo.ACBrBoleto.Cedente.Conta:=padl( copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,tamconta-1),7,'0' );

        Titulo.NumeroDocumento := PADL( Q.fieldbyname('pend_numerodcto').asstring+'/'+Q.fieldbyname('pend_parcela').asstring,11,'0');
        Titulo.ACBrBoleto.Cedente.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
//        Titulo.ACBrBoleto.Cedente.ContaDigito:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,5,1);
// 15.05.2021
//        Titulo.ACBrBoleto.Cedente.ContaDigito:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,6,1);
// 24.09.2021
        Titulo.ACBrBoleto.Cedente.ContaDigito:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,tamconta,1);

        Titulo.ACBrBoleto.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('Plan_agencia').asstring,5,1);
        Titulo.ACBrBoleto.Cedente.Nome:=Ups(EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring);
        if EdSoma.text='S' then begin

          B.Valor:=EdTotalMarcado.AsCurrency;
          B.Vencimento:=EdVencimento.AsDate;
          Titulo.ValorDocumento:=EdTotalMarcado.AsCurrency;
          Titulo.Vencimento:=EdVencimento.AsDate;
          Titulo.TotalParcelas:=1;
          Titulo.Parcela:= 1;

        end;
/////////////////////////////////////////////////////////////////////////////////////////////////////

// 29.04.11 - Banco Sicredi
////////////////////////////////
      end  else if QBanco.fieldbyname('Plan_codigobanco').asstring='748' then begin
/////////////////////////////////////////////////////////////////////////////////////////////////////

        Titulo.LocalPagamento:='Pag�vel Preferencialmente nas cooperativas de Cr�dito do SICREDI';
        Titulo.Aceite:=Atsim;
// acbr coloca automatico...
{
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          Titulo.Mensagem.Add('Ap�s o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          Titulo.Mensagem.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
}
        if FGeral.GetConfig1AsInteger('DIASVENBOLETO')>0 then
          Titulo.Mensagem.Add('Protestar ap�s '+inttostr(FGeral.GetConfig1AsInteger('DIASVENBOLETO'))+' dias corridos do vencimento')
        else
          Titulo.Mensagem.Add('Sujeito a protesto se n�o for pago no vencimento');
//        Titulo.Carteira:=copy(FBoletos.edCarteira.text,1,1);
        Titulo.Carteira:=FBoletos.edCarteira.text;
////////////////
        b.LocalPagamento:='Pag�vel Preferencialmente nas cooperativas de Cr�dito do SICREDI';
        b.Aceite:='S';
        if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
          b.Instrucoes.Add('Ap�s o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
        if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
          b.Instrucoes.Add('Ap�s o vencimento cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
        if FGeral.GetConfig1AsInteger('DIASVENBOLETO')>0 then
          b.Instrucoes.Add('Protestar ap�s '+inttostr(FGeral.GetConfig1AsInteger('DIASVENBOLETO'))+' dias corridos do vencimento')
        else
          b.Instrucoes.Add('Sujeito a protesto se n�o for pago no vencimento');
        b.Carteira:=FBoletos.edCarteira.text;
//////////////
// 12.02.2021 - Patopolpas para prever emissa da nf em 12.2020 e geracao de remessa em 01.2021
         Titulo.DataDocumento:=Q.fieldbyname('pend_dataemissao').asdatetime;

//        Titulo.ACbrboleto.Cedente.CodigoCedente := QBanco.fieldbyname('Plan_convenio').asstring ;
// 04.03.15
        Titulo.ACbrboleto.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring ;
        GravaSequencial( Q.fieldbyname('Pend_operacao').asstring , QBanco.fieldbyname('Plan_codigobanco').asstring,numseq );

//        DataAtual:=FormatDateTime('dd/mm/yyyy',Sistema.hoje);
//        DataAtual:=Copy(DataAtual,9,2);
// 20.03.19
        Titulo.ACBrBoleto.Banco.TamanhoMaximoNossoNum:=09;

        Titulo.NossoNumero :=strzero( numseq,05);
        b.NossoNumero :=strzero( numseq,05);

//        Aux := Titulo.AcbrBoleto.Cedente.Agencia+Titulo.AcbrBoleto.Cedente.CodigoCedente+Formatar(IntToStr(StrToInt(DataAtual)), 2) + '2' + Padl(Titulo.NossoNumero,5,'0');
//        Titulo.NossoNumero:=Formatar(IntToStr(StrToInt(DataAtual)), 2) + '2' + Padl(Titulo.NossoNumero,5,'0')+GetDigito(aux,'MOD') ;

        Acbrboleto1.Banco.TipoCobranca:=cobSicred;
// 24.03.18
        Titulo.ACBrBoleto.Banco.TipoCobranca:=cobSicred;
// 08.06.15
//        Titulo.ACBrBoleto.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,6);
// 21.09.15
        Titulo.ACBrBoleto.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,4);
        Titulo.ACBrBoleto.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('plan_agencia').AsString,5,2);
//////////////        Titulo.ACBrBoleto.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('plan_agencia').AsString,5,1);
        Titulo.ACBrBoleto.Cedente.Conta:=QBanco.fieldbyname('plan_contacorrente').AsString;
//        Aux := Titulo.ACBrBoleto.Cedente.Agencia+Titulo.ACBrBoleto.Cedente.CodigoCedente+Formatar(IntToStr(StrToInt(DataAtual)), 2) + '2' + Padl(Titulo.NossoNumero,5,'0');
        Titulo.EspecieDoc:='DMI';
// 24.03.18
        Titulo.AcbrBoleto.Cedente.Nome:=Ups(EdUnid_codigo.resultfind.fieldbyname('Unid_razaosocial').asstring);
        Titulo.AcbrBoleto.Cedente.CNPJCPF:=EdUnid_codigo.resultfind.fieldbyname('Unid_cnpj').asstring;
        Titulo.AcbrBoleto.Cedente.TipoInscricao:=pJuridica;
/////////////////////////////////////////////////////////////////////////////////////////////////////
        B.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,6);
        b.EspecieDoc:='DMI';
        b.Cedente.Nome:=EdUnid_codigo.ResultFind.fieldbyname('unid_razaosocial').asstring;
        b.Cedente.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;
        if EdSoma.text='S' then begin
          B.Valor:=EdTotalMarcado.AsCurrency;
          B.Vencimento:=EdVencimento.AsDate;
          Titulo.ValorDocumento:=EdTotalMarcado.AsCurrency;
          Titulo.Vencimento:=EdVencimento.AsDate;
          Titulo.TotalParcelas:=1;
          Titulo.Parcela:= 1;
        end;
      // 04.03.15 para imprimir o tal 'posto do beneficiario'
///        b.Cedente.Agencia:=copy(QBanco.fieldbyname('Plan_agencia').asstring,1,4)+copy(QBanco.fieldbyname('Plan_agencia').asstring,5,2);


///////////////////////////////////////////////////////////////////////////////////////////////////
// 04.07.17 - Bancoob -  Sicoob - sem usar convenio com banco do brasil
///////////////////////////////////////////////////////////////////////////////////////////////////
      end  else if QBanco.fieldbyname('Plan_codigobanco').asstring='756' then begin
/////////////////////////////////////////////////////////////////////////////////////////////////////

        B.LocalPagamento:='Pag�vel Preferencialmente nas cooperativas de Cr�dito do SICOOB';
        B.Aceite:='S';
        if (FGeral.GetConfig1AsFloat('JUROSMORA')>0 ) and
           (FGeral.GetConfig1AsFloat('MULTABOLETO')>0)
           then begin
            B.Instrucoes.Add('Ap�s o vencimento cobrar multa de '+formatfloat(f_cr,(FGeral.GetConfig1AsFloat('MULTABOLETO')))+' %'+
                            ' e '+formatfloat(f_cr,roundvalor((FGeral.GetConfig1AsFloat('JUROSMORA')/30)))+' % de mora ao dia');
//          B.Instrucoes.Add('Ap�s o vencimento cobrar mora de R$ '+formatfloat(f_cr,roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000)))+' ao dia');
// 09.05.19 - dani vidanova colocr em %. a mora e a multa

        end else if (FGeral.GetConfig1AsFloat('JUROSMORA')>0 ) and
                (FGeral.GetConfig1AsFloat('MULTABOLETO')=0)
             then
               B.Instrucoes.Add('Ap�s o vencimento cobrar mmora de '+formatfloat(f_cr,roundvalor((FGeral.GetConfig1AsFloat('JUROSMORA')/30)))+' % ao dia');
        if (FGeral.GetConfig1AsFloat('MULTABOLETO')=0 ) and
           (FGeral.GetConfig1AsFloat('JUROSMORA')>0 )
            then
//          B.Instrucoes.Add('Ap�s 5 dias de atraso cobrar multa de R$ '+formatfloat(f_cr,Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('MULTABOLETO')/100)));
            B.Instrucoes.Add('Ap�s vencimento cobrar multa de '+formatfloat(f_cr,(FGeral.GetConfig1AsFloat('MULTABOLETO')))+' %' );
// 02.04.18 - Simar  - Irma
//        B.Instrucoes.Add('Ap�s 5 dias de atraso sujeito a PROTESTO' );
// 23.04.19
        B.Instrucoes.Add('PROTESTO Autom�tico ap�s 5 dias do vencimento' );
// 16.04.18
        if ( Global.Topicos[1296] ) and (TemDesconto='S') then begin

           if (Q.FieldByName('clie_descontovenda').AsCurrency > 0)
              and // 05.06.20 - Vida Nova - 'um' dos superpao...
              ( NaoforClienteDescontoLiquido(Q.FieldByName('pend_tipo_codigo').AsInteger) )
              then begin
//              B.Instrucoes.Add('Desconto de '+currtostr(Q.FieldByName('clie_descontovenda').AsCurrency)+' % at� o vencimento' );
// 16.07.18 - Vida Nova - Dani pediu pra tirar
              Titulo.DataDesconto:=Q.FieldByName('pend_datavcto').AsDateTime;
              Titulo.ValorDesconto:=roundvalor( Q.fieldbyname('pend_valor').ascurrency*(Q.FieldByName('clie_descontovenda').AsCurrency/100) );
// 16.07.18 - Dani Vida NOva
              B.VlrDesconto:=Titulo.ValorDesconto;
           end;

        end;

        B.EspecieDoc:='DM';
        B.Carteira:=copy(FBoletos.edCarteira.text,1,1);
// 21.12.17
        if trim(xNotasSomadas)<>'' then
          B.Instrucoes.Add(xNotasSomadas);
        if EdSoma.text='S' then begin
          B.Valor:=EdTotalMarcado.AsCurrency;
          B.Vencimento:=EdVencimento.AsDate;
        end;

        GravaSequencial( Q.fieldbyname('Pend_operacao').asstring , QBanco.fieldbyname('Plan_codigobanco').asstring,numseq );
//        b.NossoNumero :=strzero(Datetoano(Q.fieldbyname('Pend_dataemissao').asdatetime,false),2) + strzero( numseq,06);
//03.08.17
//        b.NossoNumero := padl( Q.fieldbyname('pend_numerodcto').asstring,07,'0');
// 27.11.17 - sr. ivo ligou
//        b.NossoNumero := Padl(Q.fieldbyname('pend_numerodcto').asstring+strzero( Q.fieldbyname('pend_parcela').asinteger,2),12,'0')+
//                         '01'+    // modalidade fornecida pelo banco
//                         '4' ;    // tipo de papel - fixo fornecido pelo banco
//30.11.17 - juliano sicoob ligou
        b.NossoNumero := padl( Q.fieldbyname('pend_numerodcto').asstring+strzero( Q.fieldbyname('pend_parcela').asinteger,2),07,'0');

//                  Result := Result+PadLeft(NossoNum, 10, '0')+
//                            PadLeft(inttostr(ACBrTitulo.Parcela)  , 02, '0')+
//                            PadRight(wModalidade, 02, '0')+
//                            '4'+
//                            Space(5);

        b.NumerodaParcela := strzero( Q.fieldbyname('pend_parcela').asinteger,3);
        b.Cedente.ContaCorrente:=padl(QBanco.fieldbyname('Plan_contacorrente').asstring,7,'0') ;
// 21.09.17
        b.Cedente.CodigoCedente:=QBanco.fieldbyname('Plan_convenio').asstring;
// 10.08.2021 - Vida Nova
        b.Cedente.CNPJCPF:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring;

// 04.07.17
//        Titulo.Acbrboleto.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_contacorrente').asstring ;
// 30.08.17
        Titulo.Acbrboleto.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring ;
//        Titulo.Acbrboleto.Cedente.Conta:=padl(copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5),8,'0') ;
// 02.09.17
        Titulo.Acbrboleto.Cedente.Conta:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5);
        Titulo.Acbrboleto.Cedente.Modalidade:='01';   // - simples com registro
        Acbrboleto1.Banco.TipoCobranca:=cobBancoob;
        Titulo.Acbrboleto.Cedente.ContaDigito := UltimoDigito(QBanco.fieldbyname('Plan_contacorrente').asstring);
        Titulo.ACBrBoleto.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,4);
        Titulo.ACBrBoleto.Cedente.AgenciaDigito:=copy(QBanco.fieldbyname('plan_agencia').AsString,5,1);
// 28.09.17
        Titulo.Acbrboleto.Cedente.TipoInscricao := pJuridica;
// 15.08.17
        Titulo.Carteira:=copy(FBoletos.edCarteira.text,1,1);
        Titulo.NumeroDocumento:=trim(Q.fieldbyname('pend_numerodcto').asstring)+'/'+strzero( Q.fieldbyname('pend_parcela').asinteger,3);
        Titulo.EspecieDoc:='02';   // Duplicata Mercantil
// 02.09.17
//        Titulo.ACBrBoleto.ACBrBoletoFC.Create(AOwner);
//        Titulo.ACBrBoleto.ACBrBoletoFC.LayOut:=lPadrao;

        Titulo.TotalParcelas:=Q.fieldbyname('pend_nparcelas').asinteger;
        Titulo.Parcela:= Q.fieldbyname('pend_parcela').asinteger;

        Titulo.ACBrBoleto.Cedente.ResponEmissao:=tbCliEmite;
        Titulo.NossoNumero := Q.fieldbyname('pend_numerodcto').asstring+strzero( Q.fieldbyname('pend_parcela').asinteger,2);

        Titulo.DataMoraJuros:=Q.FieldByName('pend_datavcto').AsDateTime;
        Titulo.SeuNumero:=trim(Q.fieldbyname('pend_numerodcto').asstring)+'/'+strzero( Q.fieldbyname('pend_parcela').asinteger,3);
// 20.07.20 - Vida Nova - Dani.. se 0 dias nao protesta automatico
        Titulo.DiasDeProtesto := FGeral.Getconfig1asinteger('DIASVENPRAZO');
// 21.12.17
        if EdSoma.text='S' then begin
          Titulo.ValorDocumento:=EdTotalMarcado.AsCurrency;
          Titulo.TotalParcelas:=1;
          Titulo.Parcela:= 1;
// 11.01.18
          Titulo.Vencimento:=EdVencimento.AsDate;
        end else
          Titulo.ValorDocumento:=B.Valor;


//////        Titulo.Sacado.SacadoAvalista.Pessoa:=pFisica;
// 25.09.12
      end else if (QBanco.fieldbyname('Plan_codigobanco').asstring<>'756') and
          ( trim(unidadecedente)='' )
          then begin

//        b.NossoNumero :=strspace(Q.fieldbyname('pend_numerodcto').asstring+
//                        Q.fieldbyname('pend_parcela').asstring,10);
// 06.07.10
        b.NossoNumero :=strzero( strtoint(Q.fieldbyname('pend_numerodcto').asstring+
                        Q.fieldbyname('pend_parcela').asstring),10);

///////////////////////////////////
      end;

//      if edDigitoCC.text <> '' then
// ver questao do digito de controle da conta corrente
//        B.Cedente.DigitoContaCorrente := UltimoDigito(QBanco.fieldbyname('Plan_contacorrente').asstring);
// ver se cria campo no carteira no cadastro de banco ou configura�ao geral

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
          Pessoa:=pJuridica;
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
          if Q.fieldbyname('clie_tipo').asstring='F'  then
            Pessoa:=pFisica
          else
            Pessoa:=pJuridica;
        end;
      end;

// 30.06.10 - banco do brasil sarnovizky
//      b.DataProcessamento:=Sistema.Hoje;
// falado com elyze...se o bb reinar mudamos a geracao da remessa tbem...
      b.DataProcessamento:=b.DataDocumento;
// 21.12.17
      if EdSoma.Text<>'S' then
        b.Valor:=Q.fieldbyname('pend_valor').ascurrency;

//      Titulo.Mensagem.Add(' mensagem 01');
 //     Titulo.Mensagem.Add(' mensagem 02');
      b.Vencimento:=Q.fieldbyname('pend_datavcto').asdatetime;
      if AnsiPos( Qbanco.FieldByName('plan_codigobanco').asstring,'341;104') = 0 then
        b.Documento:=Q.fieldbyname('pend_numerodcto').asstring+'/'+strzero(Q.fieldbyname('pend_parcela').asinteger,2)
      else
//        b.Documento:=Q.fieldbyname('pend_numerodcto').asstring+strzero(Q.fieldbyname('pend_parcela').asinteger,2);
// 10.11.15 - Novicarnes - elyze
        b.Documento:=Q.fieldbyname('pend_numerodcto').asstring;

///////////////////      b.preparar;
// 16.09.15

      Titulo.DataDocumento:=Q.fieldbyname('pend_dataemissao').asdatetime;
      Titulo.DataProcessamento:=Titulo.DataDocumento;
// 21.11.19
      Titulo.TextoLivre:=AcbrBoleto1.Banco.MontarCampoNossoNumero( Titulo );

      if Edsoma.Text<>'S' then begin

        Titulo.ValorDocumento:=Q.fieldbyname('pend_valor').ascurrency;
        Titulo.TotalParcelas:=Q.fieldbyname('pend_nparcelas').asinteger;
        Titulo.Parcela:=Q.fieldbyname('pend_parcela').asinteger;

      end;

      Titulo.Vencimento:=Q.fieldbyname('pend_datavcto').asdatetime;
      Titulo.NumeroDocumento:=Q.fieldbyname('pend_numerodcto').asstring;
      Titulo.TipoImpressao:=tipNormal;

// 11.06.18  - Giacomoni Sicredi - 23.07.18 - retirado pois nossonumero ia errado pro
//             componente acbr do sicredi
//      if ( GeracaoRemessa ) and ( QBanco.fieldbyname('Plan_codigobanco').asstring='748' ) then Titulo.NossoNumero:=ACbrBoleto1.Banco.MontarCampoNossoNumero(Titulo);

      if Edsoma.Text<>'S' then begin
// 29.03.16 - Giacomoni - barbara pegou...
          if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
              Titulo.ValorMoraJuros:=roundvalor(Q.fieldbyname('pend_valor').ascurrency*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000))
          else
              Titulo.ValorMoraJuros:=0;
          if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
                Titulo.PercentualMulta:=FGeral.GetConfig1AsFloat('MULTABOLETO')
          else
                Titulo.PercentualMulta:=0;

      end else begin

          if FGeral.GetConfig1AsFloat('JUROSMORA')>0 then
              Titulo.ValorMoraJuros:=roundvalor(Titulo.ValorDocumento*(FGeral.GetConfig1AsFloat('JUROSMORA')/3000))
          else
              Titulo.ValorMoraJuros:=0;
          if FGeral.GetConfig1AsFloat('MULTABOLETO')>0 then
                Titulo.PercentualMulta:=FGeral.GetConfig1AsFloat('MULTABOLETO')
          else
                Titulo.PercentualMulta:=0;

      end;
// 20.05.16
      if Qbanco.FieldByName('plan_codigobanco').asstring='341' then
        if GeracaoRemessa then Titulo.PercentualMulta:=0;

////////////

/////      AcbrBoleto1.AdicionarMensagensPadroes(Titulo,Titulo.Mensagem);
//// 25.03.18
// 24.03.18
/////      AcbrBoleto1.ListadeBoletos.Add(Titulo);
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

    end else if Codigobanco='748' then begin   // Sicredi

      EditCarteira.text:='A';     //
//              CODIGO DO CEDENTE // MONTA 'l� embaixo' pra ter o codigo do cedente
//              por enquanto fica assim
      Extensao:='.CRM';
//      OndeSalvar:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5)+CodigoBanco+strzero(DatetoDia(EdDtfim.asdate),2)+strzero(DatetoMes(EdDtfim.asdate),2)+Extensao;
      OndeSalvar:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5)+CodigoMes(EdDtfim.asdate)+strzero(DatetoDia(EdDtfim.asdate),2)+Extensao

    end else if Codigobanco='756' then begin

      EditCarteira.text:='01';     //
      Extensao:='.REM';
//      OndeSalvar:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5)+CodigoBanco+strzero(DatetoDia(EdDtfim.asdate),2)+strzero(DatetoMes(EdDtfim.asdate),2)+Extensao;
      OndeSalvar:='CBR'+
                  Formatdatetime('yyyymmdd',Sistema.Hoje)+
                  strzero( FGeral.GetContador('BOL'+codigobanco+strzero(DatetoAno(Sistema.Hoje,true),4),false ) ,2)+
                  Extensao

// 08.08.19
    end else if Codigobanco='237' then begin

      EditCarteira.text:='001';     //
//      Extensao:='.REM';
// pra os testes da homologa��o
      Extensao:='.TST';
//      OndeSalvar:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5)+CodigoBanco+strzero(DatetoDia(EdDtfim.asdate),2)+strzero(DatetoMes(EdDtfim.asdate),2)+Extensao;
      OndeSalvar:='CB'+
                  Formatdatetime('ddmm',Sistema.Hoje)+
                  Formatdatetime('hh',Sistema.Hoje)+
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
//       OndeSalvar:=copy(QBanco.fieldbyname('Plan_contacorrente').asstring,1,5)+CodigoMes(Sistema.hoje)+strzero(DatetoDia(Sistema.hoje),2)+Extensao
// 09.05.19 - giacomoni
       OndeSalvar:=copy(QBanco.fieldbyname('Plan_convenio').asstring,1,5)+
                   CodigoMes(Sistema.hoje)+strzero(DatetoDia(Sistema.hoje),2)+Extensao

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

       OndeSalvar:='REMESSA_'+EdUnid_codigo.text+'_'+CodigoBanco+strzero(DatetoDia(EdDtfim.asdate),2)+strzero(DatetoMes(EdDtfim.asdate),2)+Extensao;

      EdCarteira.text:=QBanco.fieldbyname('Plan_carteira').asstring;

  end;

end;

///////////////////////////////////////////////////////////////////
procedure TFBoletos.bgeraremessaClick(Sender: TObject);
///////////////////////////////////////////////////////////////////
var p,ContadorNossoNumero,r,sequencialremessa:integer;
    op,Aux,DataAtual,csequencialremessa,xsta :string;
    Q             :TSqlquery;
    ListaBoletos,PathSalvo,ListaNotas:TStringlist;
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
// 21.09.17
  if ( EdTodos.text='B' ) and ( EdInstrucaocob.text='01' ) then begin
    Avisoerro('N�o permitido gerar remessa de titulos baixados com instru��o de cobran�a 01');
    exit;
  end;

// 29.10.18
  SequencialRemessa := FGeral.GetContador('REMESSA'+EdUnid_codigo.text+'B'+QBanco.fieldbyname('Plan_codigobanco').asstring,false,false)+1;
  cSequencialRemessa:=inttostr(SequencialRemessa);

  if AnsiPos(QBanco.fieldbyname('Plan_codigobanco').asstring,'748/104' ) >0 then begin

    if not Input('Sequencial Remessa','Numero',cSequencialRemessa,8,true) then exit;
    SequencialRemessa:=Inteiro(cSequencialRemessa);

  end;

  ListaBoletos:=TStringlist.create;
  ListaNotas:=TStringlist.create;
  NotasSomadas:='';
// 18.07.13
  PathSalvo:=TStringList.create;
//  ACobranca:=TGbCobranca.Create(self);
  GeracaoRemessa:=true;
  Sistema.Beginprocess('Gerando boletos');
  AcbrBoleto1.ListadeBoletos.Clear;
  xsta:='N';
  if EdTodos.Text='B' then xsta:='B;K';

  for p:=1 to GridPedidos.RowCount do begin

    op:=GridPedidos.Cells[GridPedidos.getcolumn('pend_operacao'),p];
    if (trim(op)<>'') and (trim(GridPedidos.Cells[GridPedidos.getcolumn('marcado'),p])<>'') then begin
      Q:=sqltoquery('select * from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
                   ' where '+FGeral.GetIN('pend_status',xsta,'C')+
                   ' and '+FGeral.GetIN('pend_tipocad','C;F','C')+
                   ' and pend_operacao='+stringtosql(op));
      if not Q.eof then begin
//        ListaBoletos.add(Q.fieldbyname('pend_numerodcto').AsString);
// 28.04.18
        if EdSoma.text='S' then begin
            if ListaNotas.IndexOf(Q.fieldbyname('pend_numerodcto').AsString)=-1 then begin
              NotasSomadas:=NotasSomadas+Q.fieldbyname('pend_numerodcto').AsString+';';
              ListaNotas.Add(Q.fieldbyname('pend_numerodcto').AsString);
            end;
        end else
           CriaBoleto(Q,'','','N');

//        Titulo:=TGbTitulo.Create(Owner);
//        Titulo.NumeroConvenio:=B.Cedente.Banco001.Convenio;
//        Titulo.LocalPagamento:=B.LocalPagamento;
//        Titulo.DataVencimento:=B.Vencimento;
//        Titulo.Vencimento:=B.Vencimento;
//        if B.Cedente.CodigoBanco='001' then begin
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
{
        Titulo.Free;
        }
////////////////////////////////////////////////////////////////////////////////////
      end;

      if EdSoma.text='S' then break
      else FGeral.FechaQuery(Q);

    end;
  end;

  if EdSoma.Text='S' then CriaBoleto(Q,'',NotasSomadas,'N');

  ///////////////////////////////////////////////////////////////


// 10.06.10 -
//  Acobranca.NumeroArquivo:=FGeral.GetContador('REMESSA'+EdUnid_codigo.text+'B'+QBanco.fieldbyname('Plan_codigobanco').asstring ,false);


  AcbrBoleto1.Cedente.Nome:=Ups(EdUnid_codigo.resultfind.fieldbyname('Unid_razaosocial').asstring);
  AcbrBoleto1.Cedente.CNPJCPF:=EdUnid_codigo.resultfind.fieldbyname('Unid_cnpj').asstring;
// 28.09.17
  AcbrBoleto1.Cedente.TipoInscricao:=pJuridica;

//  ACBrBoleto1.Cedente.Conta:=QBanco.fieldbyname('plan_contacorrente').AsString;
//  Acbrboleto1.Cedente.ContaDigito := UltimoDigito(QBanco.fieldbyname('Plan_contacorrente').asstring);
//  ACBrBoleto1.Cedente.Agencia:=copy(QBanco.fieldbyname('plan_agencia').AsString,1,4);
 if AnsiPos( QBanco.fieldbyname('Plan_codigobanco').asstring,'341/104')>0 then begin

    Acbrboleto1.Cedente.AgenciaDigito:= GetDigito( copy(QBanco.fieldbyname('Plan_agencia').asstring,1,4),'MOD' );
    ACBrBoleto1.Cedente.Conta:=copy(QBanco.fieldbyname('plan_contacorrente').AsString,1,5);

  end;

  Salvar.FileName:=ondesalvar;
  if FileExists(  ExtractFilePath( Application.ExeName ) + 'RemessaSalva.txt') then begin
    PathSalvo.LoadFromFile(  ExtractFilePath( Application.ExeName )+'RemessaSalva.txt');
    Salvar.InitialDir:=GetSomentePath( PathSalvo.Text );
    Salvar.FileName:= GetSomentePath(PathSalvo.Text) +ondesalvar;
  end;

                                                                      // // sad
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
     if pos( QBanco.fieldbyname('Plan_codigobanco').asstring,'104;756;001;422')>0 then

        AcbrBoleto1.LayoutRemessa:=c240

     else

        AcbrBoleto1.LayoutRemessa:=c400;
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
    except on E:Exception do

      Sistema.Endprocess('Checar Cedente.  N�o foi poss�vel gravar o arquivo '+ACBrBoleto1.NomearqRemessa+' em '+ACBrBoleto1.DirArqRemessa+
                         ' Inf. do Erro '+E.Message);

    end;
  end;
// 21.12.17
  if EdSoma.Text='S' then begin

    for p:=1 to GridPedidos.RowCount do begin
      op:=GridPedidos.Cells[GridPedidos.getcolumn('pend_operacao'),p];
      if (trim(op)<>'') and (trim(GridPedidos.Cells[GridPedidos.getcolumn('marcado'),p])<>'') then begin
        Sistema.Edit('pendencias');
        Sistema.SetField('pend_opantecipa',Acbrboleto1.ListadeBoletos.Objects[0].NossoNumero);
        Sistema.post('pend_operacao='+Stringtosql(op));
        Sistema.Commit;
      end;
    end;


  end else begin

// 22.09.16 - gravar nosso numero da remessa para usar no retorno
    for p:=0 to Acbrboleto1.ListadeBoletos.Count-1 do begin

          Sistema.edit('pendencias');
//          Sistema.SetField('pend_opantecipa',Acbrboleto1.ListadeBoletos.Objects[p].NossoNumero);

// 16.08.18 - 17.08.18 - banco itau deu erro de nosso numero maximo de 8...
          if QBanco.fieldbyname('Plan_codigobanco').asstring='748' then begin

            Titulo.DataDocumento:=Acbrboleto1.ListadeBoletos.Objects[p].DataDocumento;
            Titulo.CodigoGeracao:=Acbrboleto1.ListadeBoletos.Objects[p].CodigoGeracao;
//            Titulo.NossoNumero  :=Acbrboleto1.ListadeBoletos.Objects[p].Nossonumero;
            Titulo.NossoNumero  :=Acbrboleto1.ListadeBoletos.Objects[p].TextoLivre;
//            Titulo.NossoNumero:=AcbrBoleto1.Banco.MontarCampoNossoNumero( Titulo );
            Sistema.SetField('pend_opantecipa',Titulo.NossoNumero);

          end else

            Sistema.SetField('pend_opantecipa',Acbrboleto1.ListadeBoletos.Objects[p].NossoNUmero);

          Sistema.post('pend_operacao='+Stringtosql(Acbrboleto1.ListadeBoletos.Objects[p].Referencia));
          Sistema.Commit;

    end;

  end;

  PathSalvo.Clear;
  PathSalvo.Add( Salvar.FileName );
  PathSalvo.SaveToFile( ExtractFilePath( Application.ExeName ) + 'RemessaSalva.txt' );
  PathSalvo.Free;
  Sistema.endprocess('');
  ListaBoletos.free;
// 02.02.11
//  if QBanco.fieldbyname('Plan_codigobanco').asstring='422' then
//    FGeral.AlteraContador('FAIXANNUM'+QBanco.fieldbyname('Plan_codigobanco').asstring,strtoint(faixai));


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

// 12.01.2023
// pega novo sequencial e recalcula o nosso numero cfe a data de emissao
procedure TFBoletos.brecnossonumeroClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var op,
    xnossonumero:string;
    numseqx,
    p:integer;
    Q:TSqlquery;
begin

  AcbrBoleto1.ListadeBoletos.Clear;

  for p:=1 to GridPedidos.RowCount do begin

    op:=GridPedidos.Cells[GridPedidos.getcolumn('pend_operacao'),p];
    if (trim(op)<>'') and (trim(GridPedidos.Cells[GridPedidos.getcolumn('marcado'),p])<>'') then begin

      Q:=sqltoquery('select * from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
                   ' where '+FGeral.GetIN('pend_status','N','C')+
                   ' and '+FGeral.GetIN('pend_tipocad','C;F','C')+
                   ' and pend_operacao='+stringtosql(op));
      if not Q.eof then begin

          CriaBoleto(Q,'','','N');
// cria boleto s� pra ter o objeto com os dados do boleto carregado na memoria...
          numseqx:=FGeral.GetContador('BOL'+QBanco.fieldbyname('Plan_codigobanco').asstring+strzero(DatetoAno(Q.fieldbyname('pend_dataemissao').asdatetime,true),4),false );
          Titulo.NossoNumero :=strzero( numseqx,05);
          Titulo.NossoNumero:=AcbrBoleto1.Banco.MontarCampoNossoNumero( Titulo );
          Sistema.Edit('pendencias');
          Sistema.SetField('pend_opantecipa',Titulo.NossoNumero);
          Sistema.SetField('pend_lotecnab',numseqx);
          Sistema.post('pend_operacao='+Stringtosql(op));
          Sistema.Commit;
          GridPedidos.cells[GridPedidos.getcolumn('pend_opantecipa'),p]:=Titulo.Nossonumero;

      end;

      FGeral.FechaQuery(Q);

    end;

  end;

end;

procedure TFBoletos.brelatorioClick(Sender: TObject);
///////////////////////////////////////////////////////////
var i,marc:integer;
begin

  if Edtotalmarcado.ascurrency=0 then exit;
  Sistema.BeginProcess('Gerando relat�rio');
  FRel.Init('RelBoletosGerados');
  FRel.AddTit('Unidade '+EdUNid_codigo.text+' - '+SetEdUnid_nome.text);
  FRel.AddTit('Rela��o de Boletos Enviados vai Remessa para Conta '+EdBanco.text+' - '+EdBanco_descricao.text );
  FRel.AddCol( 50,1,'D','' ,''              ,'Emiss�o'    ,''         ,'',false);
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

    xEd.Items.Add('01 - Cadastro de T�tulo');
    xEd.Items.Add('02 - Pedido de Baixa');
    xEd.Items.Add('04 - Concess�o de Abatimento');
    xEd.Items.Add('05 - Cancelamento de Abatimento Concedido');
    xEd.Items.Add('06 - Altera��o de Vencimento');
    xEd.Items.Add('08 - Altera��o do seu N�mero');
    xEd.Items.Add('09 - Pedido de Protesto');
    xEd.Items.Add('18 - Sustar protesto e baixar t�tulo');
    xEd.Items.Add('19 - Sustar protesto e manter carteira');
    xEd.Items.Add('31 - Altera��o de Outros Dados');

  end else if EdBanco.text='104' then begin

    xEd.Items.Add('01 - Entrada de T�tulo');
    xEd.Items.Add('02 - Pedido de Baixa');
    xEd.Items.Add('04 - Concess�o de Abatimento');
    xEd.Items.Add('05 - Cancelamento de Abatimento');
    xEd.Items.Add('06 - Altera��o de Vencimento');
    xEd.Items.Add('07 - Concess�o de Desconto');
    xEd.Items.Add('08 - Cancelamento de Desconto');
    xEd.Items.Add('09 - Protestar(transferir de devolu��o para protesto');
    xEd.Items.Add('10 - Sustar protesto e baixa t�tulo');
    xEd.Items.Add('11 - Sustar protesto e manter em carteira');
    xEd.Items.Add('12 - Altera��o de juros de mora');
    xEd.Items.Add('13 - Dispensar cobran�a de juros de mora');

  end else begin

    xEd.Items.Add('01 - Cadastro de T�tulo');
    xEd.Items.Add('02 - Pedido de Baixa');
    xEd.Items.Add('04 - Concess�o de Abatimento');
    xEd.Items.Add('05 - Cancelamento de Abatimento Concedido');
    xEd.Items.Add('06 - Altera��o de Vencimento');
    xEd.Items.Add('08 - Altera��o do seu N�mero');
    xEd.Items.Add('09 - Pedido de Protesto');
    xEd.Items.Add('18 - Sustar protesto e baixar t�tulo');
    xEd.Items.Add('19 - Sustar protesto e manter carteira');
    xEd.Items.Add('31 - Altera��o de Outros Dados');
  end;
end;

procedure TFBoletos.bemailClick(Sender: TObject);
////////////////////////////////////////////////////
var p          : integer;
    xsta,
    xemail,
    nomearq,
    nomearqpdf  : string;
    Q           : TSqlquery;
    CorpoEmail,
    ListaAnexos : TStringList;

begin

   Acbrmail1.from:=FGeral.getconfig1asstring('EMAILORIGEM');
   Acbrmail1.Host:=FGeral.getconfig1asstring('SMTP');
   Acbrmail1.Username:=FGeral.getconfig1asstring('USUARIOSMTP');
   Acbrmail1.Password:=FGeral.getconfig1asstring('SENHASMTP');
   Acbrmail1.Port:=inttostr(FGeral.GetConfig1AsInteger('portasmtp'));
   Acbrmail1.SetSSL:=false;
   ACBrMail1.SetTLS := true;
   if FGeral.EmailStmpcomSSL( FGeral.GetConfig1AsString('EMAILORIGEM') ) then
     Acbrmail1.SetSSL:=true;

  AcbrBoleto1.ListadeBoletos.Clear;
  xsta:='N';
  if EdTodos.Text='B' then xsta:='B;K';

  for p:=1 to GridPedidos.RowCount do begin

    op:=GridPedidos.Cells[GridPedidos.getcolumn('pend_operacao'),p];
    if (trim(op)<>'') and (trim(GridPedidos.Cells[GridPedidos.getcolumn('marcado'),p])<>'') then begin
      Q:=sqltoquery('select * from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
                   ' where '+FGeral.GetIN('pend_status',xsta,'C')+
                   ' and '+FGeral.GetIN('pend_tipocad','C;F','C')+
                   ' and pend_operacao='+stringtosql(op));
      if not Q.eof then begin

         xemail := FGeral.GetEmailEntidade( Q.FieldByName('pend_tipo_codigo').asinteger,
                                            Q.FieldByName('pend_tipocad').asstring,
                                            'S');
         CriaBoleto(Q);

      end;

    end;

  end;

  CorpoEmail := TStringList.Create;
  if trim(xemail)=''  then Input('Envio de email','Email',xemail,50,false);

  if (AcbrBoleto1.ListadeBoletos.Count >0) and ( trim(xemail)<>'' )  then begin

     Sistema.BeginProcess('Enviando email');
     CorpoEmail.Add('Anexo '+inttostr(AcbrBoleto1.ListadeBoletos.Count)+' boletos');

//     AcbrBoleto1.EnviarEmail(xemail,'Boletos de cobran�a',CorpoEmail,true);
//     AcbrBoleto1.GerarPDF;
//     AcbrBoleto1.GerarHTML;
     AcbrBoleto1.GerarJPG;
     ListaAnexos := TStringList.Create;

     for p := 0 to AcbrBoleto1.ListadeBoletos.Count-1 do begin

        nomearq    := 'boleto'+strzero(p+1,3)+'.bmp';
        nomearqpdf := 'boleto'+strzero(p+1,3)+'.pdf';
//        FGerapdf.RLReport1.NewPage;
        FGerapdf.Execute( nomearq );
        ListaAnexos.Add( nomearqpdf );

     end;

     for p := 0 to AcbrBoleto1.ListadeBoletos.Count-1 do begin

        nomearq := 'boleto'+strzero(p+1,3)+'.bmp';
        Deletefile( nomearq );

     end;

     FGeral.EnviaEMailcomAnexo(xemail,ListaAnexos,corpoemail,'BOL','Boletos de Cobranca '+Global.NomeUnidade);

     Sistema.endProcess('');

  end else Aviso('N�o encontrado boletos marcados para envio de email');


  CorpoEmail.Free;

end;

// 26.08.2021
procedure TFBoletos.benviabolpixClick(Sender: TObject);
//////////////////////////////////////////////////////////
var op,
    xsta :string;
    Q    : TSqlquery;
    p,
    x,
    y    : integer;

begin

   ACBrBoleto1.ListadeBoletos.Clear;

   for p:=1 to GridPedidos.RowCount do begin

      if (trim(op)<>'') and (trim(GridPedidos.Cells[GridPedidos.getcolumn('marcado'),p])<>'') then begin

         op := GridPedidos.Cells[GridPedidos.getcolumn('pend_operacao'),p];
         xsta := 'N';
         Q:=sqltoquery('select * from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
                           ' where '+FGeral.GetIN('pend_status',xsta,'C')+
                           ' and '+FGeral.GetIN('pend_tipocad','C;F','C')+
                           ' and pend_operacao='+stringtosql(op));
         if not Q.eof then begin

            CriaBoleto(Q);

         end;
         FGeral.FechaQuery( Q );

      end;

   end;

   if ACBrBoleto1.ListadeBoletos.Count > 0 then begin

            ACBrBoleto1.Configuracoes.WebService.Operacao := tpInclui;
            ACBrBoleto1.Enviar;
{
            for x := 0 to  ACBrBoleto1.ListaRetornoWeb.Count do begin

               y := 0;
               if ACBrBoleto1.ListaRetornoWeb[x].ListaRejeicao.Count > 0 then

                  Avisoerro('Opera��o:'+op+' Mensagem '+ACBrBoleto1.ListaRetornoWeb[x].ListaRejeicao[y].Mensagem+' '+
                            'Ocorrencia=' + ACBrBoleto1.ListaRetornoWeb[x].ListaRejeicao[y].Ocorrencia )

               else if trim( ACBrBoleto1.ListaRetornoWeb[x].DadosRet.TituloRet.CodBarras ) <> '' then begin

                  AcbrBoleto1.ListadeBoletos[x].QrCode.emv := ACBrBoleto1.ListaRetornoWeb[x].DadosRet.TituloRet.EMV;

                  Sistema.Edit('pendencias');
//                  Sistema.SetField('pend_opantecipa',Acbrboleto1.ListadeBoletos.Objects[0].NossoNumero);
                  Sistema.SetField('pend_opantecipa',ACBrBoleto1.ListaRetornoWeb[x].DadosRet.TituloRet.NossoNumero);
                  Sistema.SetField('pend_codbarra',ACBrBoleto1.ListaRetornoWeb[x].DadosRet.TituloRet.CodBarras);
// 26.08.2021 - a ser criado
                  Sistema.SetField('pend_pix',ACBrBoleto1.ListaRetornoWeb[x].DadosRet.TituloRet.EMV);
                  Sistema.post('pend_operacao='+Stringtosql(Acbrboleto1.ListadeBoletos.Objects[x].Referencia));
                  Sistema.Commit;

               end;

            end;
}
   end;


end;

procedure TFBoletos.GridPedidosKeyPress(Sender: TObject; var Key: Char);
begin
//////   showmessage('Teclou a letra '+key );
end;

end.
