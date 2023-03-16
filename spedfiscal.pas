unit spedfiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  SQLGrid, ExtCtrls, ACBrSpedFiscal, ACBrEFDBlocos, ACBrBase, SqlSis;

type
  TFSpedFiscal = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bExecutar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Texto: TRichEdit;
    Edinicio: TSQLEd;
    Edtermino: TSQLEd;
    EdUnidades: TSQLEd;
    Edfinalidade: TSQLEd;
    EdMesano: TSQLEd;
    EdEsto_sugr_codigo: TSQLEd;
    SetEdsugr_descricao: TSQLEd;
    EdSugr_codigoacabado: TSQLEd;
    SQLEd2: TSQLEd;
    ACBrSPEDFiscal1: TACBrSPEDFiscal;
    procedure FormActivate(Sender: TObject);
    procedure bExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GeraBlocoC;
    procedure Execute;
    function GetNumerodoEndereco(endereco:string;codigo:integer=0;mensagem:string='S'):string;
    function Posicao2num(endereco:string):integer;
    procedure GeraRegistro500;
    function FormataClassificacaoSped(Classificacao:String):String;
    function FormataClassificacao(Classificacao:String):String;
    procedure SomanoRegistro(tiporegistro,ycst,ycfop:string ; yaliqicms,ytotalitem,ybaseicms,yvlricms,ybaseicmsst,yvlricmsst,yreducaobase,yvlripi:currency );
    procedure SomanoRegistroDoc(tiporegistro,ycst,ycfop:string ; yaliqicms,ytotalitem,ybaseicms,yvlricms,ybaseicmsst,yvlricmsst,yreducaobase,yvlripi:currency );
    procedure AcumulaReg(tiporegistro,ycfop:string ; yvl_icms:currency );
// 18.10.12
    procedure BuscaNosItems(xtransacao,xtipomov:string;xperdesco:currency;var xbaseicms,xvlricms:currency);
// 17.02.14 - Abra Cuiaba
    function Servico(produto: string): boolean;
// 17.09.19
    function GetCSTPIS(ycst:string;ycfop:string='';ycsticms:string=''):TACBrSituacaoTribPIS;
    function GetCSTCOFINS(ycst:string;ycfop:string='';ycsticms:string=''):TACBrSituacaoTribCOFINS;
// 29.09.2021
    function GetAliqicms( s:widestring ):currency;
    function GetAliqIcmsRegc195( trans:string ) : currency;

  end;

type TTotalCST=record
     cst,cfop,registro:string;
     aliicms,vl_opr,vl_bc_icms,vl_icms,vl_bc_icms_st,vl_icms_st,vl_red_bc,
     vl_ipi:currency;
end;

type TDocumentoCST=record
     cst,cfop,registro:string;
     aliicms,vl_opr,vl_bc_icms,vl_icms,vl_bc_icms_st,vl_icms_st,vl_red_bc,
     vl_ipi:currency;
end;

type TRegE110=record
   VL_TOT_DEBITOS,VL_AJ_DEBITOS,VL_TOT_AJ_DEBITOS,VL_ESTORNOS_CRED,
   VL_TOT_CREDITOS,VL_AJ_CREDITOS,VL_TOT_AJ_CREDITOS,VL_ESTORNOS_DEB,
   VL_SLD_CREDOR_ANT,VL_SLD_APURADO,VL_TOT_DED,VL_ICMS_RECOLHER,VL_SLD_CREDOR_TRANSPORTAR,
   DEB_ESP :currency
end;

type TRegE520=record
   VL_DEB_IPI, VL_SD_ANT_IPI,VL_OD_IPI,VL_OC_IPI,
   VL_CRED_IPI, VL_SC_IPI,VL_SD_IPI :currency
end;

type TReg1400=record
     COD_ITEM_IPM:string;
     MUN         :integer;
     VALOR       :currency;
end;

type TReg0460  =record
     COD_OBS,
     TXT       :string;
end;

type TRegC195  =record
     COD_OBS,
     TXT_COMPL,
     TRANSACAO   :string;
     ALIICMS     :currency;
end;

type TRegC197  =record
     COD_AJ,
     DESCR_COMPL_AJ,
     COD_ITEM,
     TRANSACAO   :string;
     VL_BC_ICMS,
     ALIQ_ICMS,
     VL_ICMS,
     VL_OUTROS   :currency;

end;

var
  FSpedFiscal: TFSpedFiscal;
  FormatoMascaraSped,
  FormatoMascara      :string;
  ListaTotalCst,ListaRegE110,
  ListaRegE520,
  ListaDocumentoCst,
  ListaReg1400,
  ListaReg460,
  ListaRegC195,
  ListaRegC197  :TList;
  PTotalCst:^TTotalCst;
  PDocumentoCst:^TDocumentoCst;
  PRegE110:^TRegE110;
  PRegE520:^TRegE520;
  PReg1400:^TReg1400;
  PReg0460:^TReg0460;
  PRegC195:^TRegC195;
  PRegC197:^TRegC197;
  codigoibge:integer;
  ListaCod_Cta   : TStringList;
  ListaDespesasCST53   :TStringList;
  campo                :TDicionario;

const CstSubsTrib    :string='010';
      CODCREDITOICMS : string = '000001';
      CODCREDITOCMSAJ: string = 'SC10000034';

implementation

uses Unidades, Geral, SqlFun, SqlExpr , Sittribu, Estoque,
  codigosfis, ACBrEFDBloco_0_Class, ACBrEFDBloco_0, munic, Arquiv,
  sintegra, Natureza, ACBrEFDBloco_C_Class, ACBrEFDBloco_C, codigosipi,
  ACBrEFDBloco_D_Class, ACBrEFDBloco_D, ACBrEFDBloco_E,
  ACBrEFDBloco_E_Class, ACBrEFDBloco_G_Class, ACBrEFDBloco_G,
  ACBrEFDBloco_H_Class, ACBrEFDBloco_1_Class, ACBrEFDBloco_9_Class,
  ACBrEFDBloco_9, Contnrs, Transp, ACBrEFDBloco_1, ACBrEFDBloco_H, DB,
  expnfetxt, custos, cadcli, plano, grupos;

{$R *.dfm}

function TiraSintegra(s:string):string;
////////////////////////////////////////////////
var d,g,r:string;
    p:integer;
begin
  d:=';,/-.';
  r:='';
  for p:=1 to length( s ) do begin
    g:=copy(s,p,1);
    if pos(g,d)=0 then
      r:=r+g;
  end;
  result:=r;
end;


{ TFSpedFiscal }

procedure TFSpedFiscal.Execute;
/////////////////////////////////////////////////////
begin

  if EdInicio.isempty then begin
    Edinicio.Setdate(Sistema.Hoje);
    EdTermino.setdate(Sistema.hoje);
  end;
  EdUnidades.Enabled:=Global.Topicos[1015];
  EdUnidades.text:=Global.Usuario.UnidadesMvto;
  FUnidades.SetaItems(EdUnidades,nil,Global.Usuario.UnidadesMvto);
  campo:=Sistema.GetDicionario('plano','plan_cstpiscofins');

  Show;

end;

procedure TFSpedFiscal.GeraBlocoC;
//var imComDados:TAcbrIndicadorMovimento;
begin
   with ACBrSpedFiscal1.Bloco_C do
   begin
      with RegistroC001New do
      begin
         IND_MOV := imComDados;
{
}
      end;
   end;
end;

procedure TFSpedFiscal.FormActivate(Sender: TObject);
begin
  if trim(EdUnid_codigo.text)='' then
    EdUnid_codigo.text:=Global.CodigoUnidade;
  EdInicio.setfocus;

end;

///////////////////////////////////////////////////////
procedure TFSpedFiscal.bExecutarClick(Sender: TObject);
///////////////////////////////////////////////////////
type TParticipa=record

  codigo,codigosac:integer;
  tipocad:string;

end;

type TUnidades=record

  codigo:integer;
  descricao:string;

end;

// 24.09.19 - para o cod_cta nos registros detalhe
type TCod_Cta=record
     contadespesa,pcon_conta:integer;
     pcon_classif,pcon_classifref:string;
end;

var NumSerieCertificado,SqlUNidades,linha,tiposnao,SqlunidadesDet,nomearq,es,
    cfop,situacaonota,x,codigofiscal,cfop50,cfop54,xcst,codmuniemitente,codigopais,
    numero,ModelosRegistroC100,ModelosRegistroPadrao,ModelosRegistroC140,
    ModelosRegistroC160,ModelosRegistroC170,xCSTIPI,Reg10101100,incluiunid,xchave,
    gravar,
    campos,
    codigosdeinsumos,
    cstpiscofins,
    xproduto,
    sqlgruposnao       :String;

    aliqsicms,numcfops,p,regsbloco0,contitem,NRegD100,nregd500,r,chaves,contc420:integer;
    Q,QMovbase,QGeral,QE,QPend,QTransp,
    QInventario,
    QZ,
    QZDoc,
    QzDocItens,
    QAcabado,
    QInsumos,
    QCusto       :TSqlquery;

    ListaAliquotas,ListaBases,ListaCfops,ListaCSTs,Lista75,Lista75aux,
    ListaTodosCfops,
    ListaAliquota:TStringlist;
    isentas,outras,baseicms,valornota,vlricms,aliqicms,perdesco,aliqmovb,
//    totalitem,
    valoripi,basecalculo,redubase,redubasemestre,baseicmsst,vlrdesco,vlracres,vlrfrete,
    valoricmsst,rateioicmsst,valoricmsstitem,aliicms,totalinventario,valoripiitem,rateiofrete,
    vlrfreteitem       :currency;
    ListaParticipantes,
    ListaUnidades,
    ListaPlanoCon      :TList;
    totalitemnfprodutor,
    totalitem          :extended;  // 30.07.20
    PParticipa,PParti  :^TParticipa;
    PUnidades          :^TUnidades;
    DataNota           :TDatetime;
    ListaData          :TStringList;
    PCod_Cta           :^TCod_Cta;
    GerarCodCta  :boolean;

const ModeloNfe:string='55';
      ModeloNfce:string='65';
//      ModelosnaoGeraItem:string='06;22';
// 24.11.11
      ModelosnaoGeraItem:string='06;22;04';


    //////////////////////////////////////////
    function GetModelo(tipomov:string):string;
    //////////////////////////////////////////
//modelo de documento fiscal     01 - nf modelo 1 ou 1A     02 - nf venda consumidor modelo 2
//                               04 - nf produtor   e MAIS UM MONTE...
    begin
      result:='01';
// 13.02.17
//      result:='55';
// 21.01.10 - nfe
      if ( ( Q.fieldbyname('moes_dtnfecanc').AsDateTime>1 ) or
         ( Q.fieldbyname('moes_dtnfeauto').AsDateTime>1 ) ) and
         (  NumSerieCertificado<>'' )
         OR // 23.09.11 - nova versao do 'valichupador'...
         ( (Q.fieldbyname('moes_chavenfe').AsString<>'') and ( pos(copy(Q.fieldbyname('moes_natf_codigo').AsString,1,1),'1;2;3')>0 )
             )
         then begin
         result:='55';
// 08.05.14 - devido as CTE nas entradas q tem q ter chave
         if uppercase(Q.fieldbyname('moes_especie').AsString)='CTE' then
           result:='57'
// 03.02.2021 - Novicarnes
         else if uppercase(Q.fieldbyname('moes_especie').AsString)='CTEO' then
           result:='67'
// 23.11.15 -
         else if uppercase(Q.fieldbyname('moes_especie').AsString)='NFCE' then
           result:='65';

// 17.02.14 - nfe cancelada antes de de autorizada
      end else if ( uppercase(copy(Q.fieldbyname('moes_especie').AsString,1,3))='NFE' ) and
              ( pos( Q.fieldbyname('moes_status').asstring,'X;Y;I' ) > 0 ) then
         result:='55'
// 24.11.15 - NFC-e
      else if ( uppercase(copy(Q.fieldbyname('moes_especie').AsString,1,3))='NFC' ) and
              ( pos( Q.fieldbyname('moes_status').asstring,'X;Y;I' ) > 0 ) then
         result:='65'
// 24.11.15 - nfe nao autorizada e 'esquecida' no sac para ver se nao gera no sped
      else if ( uppercase(copy(Q.fieldbyname('moes_especie').AsString,1,3))='NFE' ) and
              ( pos( Q.fieldbyname('moes_status').asstring,'X;Y;I' ) = 0 ) and
              ( pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1),'5;6;7' ) > 0 ) and  // 09.12.15
              ( Q.fieldbyname('moes_retornonfe').asstring<>'NF-e Autorizada' )
              then
         result:='XX'

      else if pos(tipomov,Global.CodConhecimento+';'+Global.CodConhecimentoSaida)>0 then begin

        result:='08';
// 29.07.10 - Clessi
        if uppercase(Q.fieldbyname('moes_especie').AsString)='CTE' then
           result:='57';
// 04.12.20 - Novicarnes
        if uppercase(Q.fieldbyname('moes_especie').AsString)='CTEO' then
           result:='67';

// 23.03.07
      end else if pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,2,3),'251;252;253') > 0 then
        result:='06'    // contas de energia eletrica
// 08.07.09 - novicarnes
      else if pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,2,3),'302;303') > 0 then
        result:='22'    // contas de telefone
// 05.07.10 - Granzotto - NF venda consumidor
      else  if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'567')>0 ) then
           Result:='02'
// 16.12.10  - sped fiscal
      else  if Q.fieldbyname('moes_tipomov').AsString=Global.CodCompraProdutor then
          result:='04'
// 11.03.14  - sped fiscal
      else  if Q.fieldbyname('moes_tipomov').AsString=Global.CodFaturaAgua then
          result:='29'
// 25.10.19  - Novicarnes - sped fiscal
      else  if Q.fieldbyname('moes_especie').AsString='NFAE' then
          result:='1B'
// 04.12.19  - Novicarnes - sped fiscal - nf inutilizada
      else  if ( Q.fieldbyname('moes_status').AsString='I') and ( (uppercase(copy(Q.fieldbyname('moes_especie').AsString,1,3))='NFE') )   then

          result:='55'

      else  if (uppercase(copy(Q.fieldbyname('moes_especie').AsString,1,3))='NF ') and (copy(Q.FieldByName('moes_serie').asstring,1,1)='1') then
          result:='01';

    end;


    procedure PesquisaEntidade(tipocad:string ; codigo:integer );
    /////////////////////////////////////////////////////////////
    begin
      if tipoCad='U' then
        Arq.TUnidades.locate('unid_codigo',strzero(codigo,3),[])
      else if tipoCad='R' then
        Arq.TRepresentantes.locate('repr_codigo',codigo,[])
      else if tipoCad='F' then
        QGeral:=sqltoquery('select * from fornecedores where forn_codigo='+inttostr(codigo))
      else if tipoCad='T' then
        Arq.TTransp.locate('tran_codigo',strzero(codigo,3),[])
      else
        QGeral:=sqltoquery('select * from clientes where clie_codigo='+inttostr(codigo));

      if Qgeral<>nil then begin
        if qgeral.eof then
          avisoerro('tipocad '+tipocad+' codigo '+inttostr(codigo)+' n�o encontrado');
      end;

    end;


    function TemAliquota(aliq:currency):boolean;
    /////////////////////////////////////////////
    var p:integer;
    begin
      result:=false;
      for p:=0 to ListaAliquotas.count-1 do begin
        if texttovalor( Listaaliquotas[p] ) = aliq then begin
          result:=true;
          break
        end;
      end;
    end;


///////////////////////////////////
    function TemCfop(xcfop:string):boolean;
    var p:integer;
    begin
      result:=false;
      if trim(xcfop)='' then begin   // 10.09.08
        result:=true;
        exit;
      end;
      for p:=0 to ListaCfops.count-1 do begin
        if ListaCfops[p]=xcfop then begin
          result:=true;
          break
        end;
      end;
    end;

// 18.12.09
///////////////////////////////////
    function TemCST(xcst:string):boolean;
    var p:integer;
    begin
      result:=false;
      if trim(xcst)='' then begin
        result:=true;
        exit;
      end;
      for p:=0 to ListaCSTs.count-1 do begin
        if ListaCSTs[p]=xcst then begin
          result:=true;
          break
        end;
      end;
    end;
///////////////////////

    procedure IncluiParticipa( codigo:integer;tipocad:string );
    ///////////////////////////////////////////////////////////
    var x:integer;
        achou:boolean;

        function GetProximo:integer;
        //////////////////////////////
        var p,xcod:integer;
        begin
          xcod:=0;
          for p:=0 to ListaParticipantes.count-1 do begin
            PParti:=ListaParticipantes[p];
            if Pparti.codigo>xcod then
              xcod:=Pparti.codigo;
          end;
          result:=xcod+1;
        end;

    begin
    //////////////////////////////
      if codigo=0 then exit;

      achou:=false;
      for x:=0 to ListaParticipantes.Count-1 do begin
        PParticipa:=ListaParticipantes[x];
        if (PParticipa.codigosac=codigo) and (PParticipa.tipocad=tipocad) then begin
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
        New(PParticipa);
        PParticipa.codigo:=GetProximo;
        PParticipa.codigosac:=codigo;
        PParticipa.tipocad:=tipocad;
        ListaParticipantes.Add(PParticipa);
      end;
    end;

    function GetCodigoParticipa( codigosac:integer;tipocad:string ):string;
    ///////////////////////////////////////////////////////////
    var x:integer;
    begin
    //////////////////////////////
      result:='';
      for x:=0 to ListaParticipantes.Count-1 do begin
        PParticipa:=ListaParticipantes[x];
        if (PParticipa.codigosac=codigosac) and (PParticipa.tipocad=tipocad) then begin
          result:=inttostr(PParticipa.codigo) ;
          break;
        end;
      end;
    end;


    procedure IncluiUnidadeEstoque( descricao,codigo:string );
    ///////////////////////////////////////////////////////////
    var x:integer;
        achou:boolean;
        xdescricao:string;
    begin
      achou:=false;
      xdescricao:=Uppercase(descricao);
// para nao incluir unidade itens de nota eletronica...
// 24.11.11 mas nas NFe de entrada inclui
      if pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModelosnaoGeraItem ) >0 then
        exit;
      if ( pos(copy(cfop54,1,1),'1;2')=0 ) and
         ( GetModelo(Q.fieldbyname('moes_tipomov').asstring) = ModeloNfe )
          then
        exit;

      for x:=0 to ListaUnidades.Count-1 do begin
        PUnidades:=ListaUnidades[x];
        if ( trim(PUnidades.descricao)=trim(xdescricao) )then begin
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
        New(PUnidades);
        PUnidades.codigo:=ListaUnidades.count+1;
        if trim(xdescricao)='' then begin
          Texto.Lines.Add('Produto '+codigo+' sem unidade no cadastro de produto. Colocado UN.');
          PUnidades.descricao:='UN.';
        end else begin
          PUnidades.descricao:=uppercase(xdescricao);
        end;
        ListaUnidades.Add(PUnidades);
      end;
    end;

    function GetCodigoUnidadeEstoque(unidade:string):string;
    /////////////////////////////////////////////////////////
    var x:integer;
    begin
      result:='000000';
      for x:=0 to ListaUnidades.Count-1 do begin
        PUnidades:=ListaUnidades[x];
        if ( trim(PUnidades.descricao) = trim(uppercase(unidade)) )then begin
          result:=strzero(PUnidades.codigo,6);
          break;
        end;
      end;
    end;


    // 09.02.18
    function GetCodigoIBGEOrigem( xxml:string ):string;
    /////////////////////////////////////////////////////
    var s:string;
    begin

       s:=FExpNfetxt.GetTag('enderReme',xxml);
       s:=FExpNfetxt.GetTag('cmun',s);
       result:=s;

    end;

    // 27.11.18
    //////////////////////////////////////////////////////////////////////////////////////
    function TemnaLista1400(xcodigo:string ; xibge:integer ; xvalor:currency ):boolean;
    ///////////////////////////////////////////////////////////////////////////////////////
    var p:integer;
        achou:boolean;
    begin

       achou:=false;
       for p := 0 to ListaReg1400.count-1 do begin

           PReg1400:=ListaReg1400[p];
           if (PReg1400.COD_ITEM_IPM=xcodigo) and (PReg1400.MUN=xibge) then begin
               achou:=true;
               break;
           end;

       end;
       if achou then PReg1400.VALOR:=PReg1400.VALOR + xvalor;
       result:=achou;

    end;


// 24.09.19
    procedure GetPlanocon(xuni:string);
    ///////////////////////////////////////////////////////////////////////
    var QP:TSqlquery;
        whereempresa:string;
    begin
      if AnsiPos( 'VIDA NOVA',Uppercase(EdUnid_codigo.resultfind.FieldByName('unid_razaosocial').AsString)) > 0 then
        xuni:='001';

      whereempresa:=' where pcon_empr_codigo='+stringtosql(copy(xUni,2,2));
      QP:=FGeral.SqlToQueryContax(' select * from planocon '+
                            whereempresa+
                            ' order by pcon_classificacao ');
      while not QP.Eof do begin

        New(PCod_Cta);
        PCod_Cta.pcon_conta:=QP.FieldByName('pcon_conta').AsInteger;
        PCod_Cta.contadespesa:=0;
        PCod_Cta.pcon_classif:=QP.FieldByName('pcon_classificacao').AsString;
        PCod_Cta.pcon_classifref:=QP.FieldByName('pcon_planorefsped').AsString;
        ListaPlanoCon.Add(Pcod_Cta);
        QP.Next;

      end;
      FGeral.FechaQuery(QP);
    end;


// 24.09.19
    //////////////////////////////////////////////////////////////////////
    function GetCod_CtaPcon(xcontareduzida:integer):string;
    ///////////////////////////////////////////////////////////////////////
    var n:integer;
    begin
      result:='';

      for n:=0 to ListaPlanoCon.Count-1 do begin
        PCod_Cta:=ListaPlanoCon[n];
        if PCod_Cta.pcon_conta=xcontareduzida then begin
          result:=PCod_Cta.pcon_classif;
          break;
        end;
      end;
      if ( Global.Usuario.Codigo=100 ) and ( result='' ) then
//       Avisoerro('Reduzido '+inttostr(xcontareduzida)+' n�o encontrado no plano de contas');
       Texto.Lines.Add('Reduzido '+inttostr(xcontareduzida)+' n�o encontrado no plano de contas');

    end;

   // 24.09.19
   function GetCod_Cta(xtipomov,xunidade:string ; xconfmov:integer):string;
   ////////////////////////////////////////////////////////////////////////
   var Qx,
       QContab:TSqlquery;
       xconta:integer;
   begin
     xconta:=0;
     if NOT gerarcodcta then begin

        result:='';
        exit;

     end;
     if Global.Topicos[1055] then begin

           QContab:=sqltoquery('select moct_debito,moct_credito from movcontab where moct_transacao = '+
                    Stringtosql(Q.FieldByName('moes_transacao').AsString)+
                    ' and moct_datamvto = '+Datetosql(Q.FieldByName('moes_datamvto').AsDatetime)+
                    ' and moct_tipo = '+stringtosql('NOTAS') );
           if pos( xtipomov,Global.TiposSaida ) > 0 then
              xconta :=QContab.FieldByName('moct_credito').AsInteger
           else
              xconta := QContab.FieldByName('moct_debito').AsInteger;
           FGeral.FechaQuery(QContab);
     end;

     if xconta=0 then begin
        QX:=sqltoquery('select * from unidades where unid_codigo = '+stringtosql(xunidade));
        if not Qx.eof then begin
          if pos( xtipomov,Global.TiposSaida ) > 0 then
            xconta:=Qx.fieldbyname('unid_vendaaprazo').asinteger
          else
            xconta:=Qx.fieldbyname('unid_compras').asinteger;
        end;
     end;
     if xconta>0 then begin
        result:=GetCod_CtaPcon(xconta);
        if ListaCod_cta.indexof(inttostr(xconta))=-1 then
           ListaCod_Cta.Add( inttostr(xconta) );

     end  else result:='';

   end;

///////////////////////////////////////////////////////
begin
///////////////////////////////////////////////////////

  if not EdUnid_codigo.validfind then exit;
  if not EdUnid_codigo.valid then exit;
  if not EdTermino.valid then exit;
  if not Arq.TTransp.Active then Arq.TTransp.Open;
//  if not FGeral.ConectaContax then begin
//     exit;
//  end;
// 11.04.11 - deixado assim pra executar mesmo q nao conecte com o banco contax...
//  FGeral.ConectaContax;
// 18.10.12 - retirado por ainda nao usar...

  if not confirma('Confirma gera��o do arquivo do Sped Fiscal ?') then exit;

  texto.clear;
  ModelosRegistroPadrao:='01;1B;04;55;65';
  ModelosRegistroC100:=ModelosRegistroPadrao;
  ModelosRegistroC140:='01';
  ModelosRegistroC160:='01;04';
  ModelosRegistroC170:=ModelosRegistroPadrao;
  ListaTotalCst:=TList.create;
  ListaRegE110:=TList.create;
  ListaRegE520:=TList.create;
  ListaReg1400:=TList.create;
  ListaReg460 :=TList.create;
  ListaRegC195 :=TList.create;
  ListaRegC197 :=TList.create;

  FormatoMascaraSped:='';
  FormatoMascara:='';
/////////////
    nomearq:='SF'+EdUnid_codigo.text+copy(EdTermino.text,3,4)+'.TXT';
    AcbrSpedFiscal1.DT_INI:=EdInicio.asdate;
    AcbrSpedFiscal1.DT_FIN:=EdTermino.asdate;
    AcbrSpedFiscal1.Path:=ExtractFilePath(Application.ExeName);
    AcbrSpedFiscal1.Arquivo:=nomearq;

// 28.09.2021 - Clessi
// 'APROVEITAMENTO DO CREDITO DE ICMS NO VALOR DE R$ 278,85'
//  if AnsiPos( 'APROVEITAMENTO DO CREDITO DE ICMS NO VALOR DE',
//              UpperCase( NotaFiscal.NotasFiscais.Items[0].NFe.InfAdic.infCpl ) ) > 0 then

//    AcbrSpedFiscal1.IniciaGeracao;
// ja fez em savefiletxt

// abrir os blocos 'sem dados' e depois muda para 'com dados' se for o caso
// Abertura Bloco D - conhecimentos de transporte e outros...
  with AcbrSpedFiscal1.Bloco_D do begin
    with RegistroD001New do begin
      IND_MOV:=imSemDados;
    end;
  end;

// 24.09.19
  GerarCodCta:=true;
  if not FGeral.ConectaContax then begin
     Avisoerro('N�o foi poss�vel conectar com a contabilidade. Cod_Cta n�o ser� informado !!');
     GerarCodCta:=false;
  end;

  ListaCod_Cta:=TStringList.Create;

  ListaPlanocon:=TList.Create;
// 09.10.19  - para quem gera o sped para o escritorio..  - Seip
  if GerarCodCta then

     GetPlanocon( EdUNid_codigo.Text );

// 17.10.19
  ListaDespesasCST53:=TStringList.Create;
  if FileExists( 'ListaDespesasCST53.txt' ) then begin
     try
        ListaDespesasCST53.LoadFromFile( 'ListaDespesasCST53.txt' );
     except
        Avisoerro('N�o foi poss�vel ler o arquivo ListaDespesasCST53.txt');
        exit;
     end;
  end;


// Abertura Bloco E - apuracao do icms
////////////////////////////////////////
  with AcbrSpedFiscal1.Bloco_E do begin
        with RegistroE001New do begin
          IND_MOV:=imComDados;
        end;
        with RegistroE100New do begin
          DT_INI:=EdInicio.AsDate;
          DT_FIN:=EdTermino.AsDate;
        end;
        with RegistroE500New do begin
          IND_APUR:=iaMensal;
          DT_INI:=EdInicio.AsDate;
          DT_FIN:=EdTermino.AsDate;
        end;
  end;

/////////////
  ListaTodosCfops:=TStringlist.create;
// 27.04.15
  sistema.beginprocess('Revisando chaves de nf-e');
  Q:=sqltoquery('select * from movesto'+
                ' where substr(moes_natf_codigo,1,1) in (''1'',''2'')'+
                ' and '+FGeral.Getin('moes_status','N;X;E;D;Y;I','C')+
                ' and moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.Getin('moes_status','N;X;E;D;Y;I','C')+
                ' and '+FGeral.GetNOTIN('moes_serie','F;F ','C')+
                ' and '+FGeral.GetNOTIN('moes_especie','CF;CF ;','C')+
                ' and '+FGeral.GetNOTIN('moes_tipomov',tiposnao+';'+Global.CodConhecimento+';'+global.CodConhecimentoSaida,'C')+
                ' and moes_datacont is not null'+
                ' and moes_unid_codigo='+EdUnid_codigo.AsSql+
                ' and moes_natf_codigo is not null'+
                ' order by moes_transacao,moes_datamvto' );
  gravar:='N';chaves:=0;
  while not Q.eof do begin
    if (Q.fieldbyname('moes_chavenfe').asstring='') and (Q.fieldbyname('moes_xmlnfet').AsString<>'')
        or
        ( pos('www',Q.fieldbyname('moes_chavenfe').AsString)>0 )
    then begin
      xchave:=copy( Q.fieldbyname('moes_xmlnfet').AsString, pos('Id=',Q.fieldbyname('moes_xmlnfet').AsString)+7,44 );
//      xchave:=copy(xchave,pos('NFe',xchave)+3,44);
      if trim(xchave)<>'' then begin
        Sistema.Edit('movesto');
        Sistema.SetField('moes_chavenfe',xchave);
        Sistema.Post('moes_transacao='+Stringtosql(Q.fieldbyname('moes_transacao').AsString));
        gravar:='S';
        inc(chaves);
      end;
    end;
    Q.Next;
  end;
  FGeral.fechaquery(Q);

//  aviso('chaves ajustadas '+inttostr(chaves));

  if gravar='S' then Sistema.Commit;
/////////////////////////////////
  sistema.beginprocess('Pesquisando conhecimentos');
  ListaParticipantes:=TList.create;
  ListaUnidades:=TList.create;
  NumSerieCertificado:=trim( FGeral.GetConfig1AsString('NumSerieCert') );
// 14.04.14 - Vida Nova
  if Trim(NumSerieCertificado)='' then NumSerieCertificado:=EdUnid_codigo.ResultFind.fieldbyname('unid_nroseriecertif').AsString;

  Sqlunidades:=' and moes_unid_codigo='+EdUnid_codigo.assql;
  if Global.Topicos[1015] then
    Sqlunidades:=' and '+FGeral.GetIN('moes_unid_codigo',EdUnidades.text,'C');
  Q:=sqltoquery('select * from movesto'+
                ' inner join natureza on (natf_codigo=moes_natf_codigo)'+
                ' where '+FGeral.Getin('moes_status','N','C')+' and moes_datamvto>='+EdInicio.assql+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and '+FGeral.Getin('moes_tipomov',Global.CodConhecimento+';'+Global.CodConhecimentoSaida,'C')+
                ' and moes_datacont is not null'+
                sqlunidades+
                ' and moes_natf_codigo is not null'+
                ' order by moes_datamvto,moes_numerodoc' );
  NRegD100:=0;NRegD500:=0;
  Reg10101100:='N';
  while not Q.eof do begin

      QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(q.fieldbyname('moes_transacao').asstring)+
                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('moes_tipomov').asstring));

      datanota:=Q.fieldbyname('moes_datamvto').asdatetime;

      IncluiParticipa( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring );

{
      linha:=GetFormato70( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 datanota+';'+
                 Q.fieldbyname('moes_estado').asstring+';'+
                 GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                 copy(Q.fieldbyname('moes_serie').asstring,1,1)+';'+
                 Q.fieldbyname('moes_numerodoc').asstring+';'+
                 copy(Q.fieldbyname('moes_natf_codigo').asstring,1,4)+';'+
                 Q.FieldByName('moes_vlrtotal').Asstring+';'+
//                 Q.FieldByName('moes_baseicms').Asstring+';'+
                 QMovbase.FieldByName('movb_basecalculo').Asstring+';'+
                 QMovbase.FieldByName('movb_imposto').Asstring+';'+
                 valortosql( 0 )+';'+
                 valortosql( 0 )+';'+
                 Q.FieldByName('moes_freteciffob').asstring+';'+
                 'N'+';' );
}
     with AcbrSpedFiscal1.Bloco_D do begin

       with RegistroD100New do begin

         Inc(NRegD100);
         if Q.fieldbyname('moes_tipomov').asstring=Global.codconhecimento then begin
           IND_OPER:=tpEntradaAquisicao;
           IND_EMIT:=edTerceiros;
         end else begin
           IND_OPER:=tpSaidaPrestacao;
           IND_EMIT:=edEmissaoPropria;
         end;
         COD_PART:=GetCodigoParticipa( Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring ) ;
         COD_MOD :=GetModelo(Q.fieldbyname('moes_tipomov').asstring);
         if Qmovbase.fieldbyname('movb_status').asstring='X' then
            COD_SIT:=sdCancelado
         else if Qmovbase.fieldbyname('movb_status').asstring='Y' then
           COD_SIT:=sdDoctoDenegado
         else
            COD_SIT:=sdRegular;
//          SER:=strspace(Q.fieldbyname('moes_serie').asstring,3);
          SER:=trim(Q.fieldbyname('moes_serie').asstring);
//          NUM_DOC:=strspace(Q.fieldbyname('moes_numerodoc').asstring,09);
          NUM_DOC:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,09);

// pra uso somente em conhecimento eletronico..ainda nao previsto
          if trim(Q.fieldbyname('moes_chavenfe').asstring)<>'' then
            CHV_CTE:=copy(Q.fieldbyname('moes_chavenfe').asstring,1,44);
//          CHV_CTE_REF:='';
          TP_CT_e:='0'; // Cte normal
          if Q.fieldbyname('moes_status').asstring='X' then
            TP_CT_e:='3'; // Cte anulado
          DT_DOC:=Q.fieldbyname('moes_dataemissao').asdatetime;
          DT_A_P:=datanota;
          VL_DOC:=Q.fieldbyname('moes_vlrtotal').ascurrency;
          VL_DESC:=0;
          if Q.FieldByName('moes_freteciffob').asstring='1' then
            IND_FRT:=tfPorContaEmitente
          else
            IND_FRT:=tfPorContaDestinatario;
// 14.05.14
          if pos( EdUnid_codigo.ResultFind.FieldByName('unid_simples').AsString,'S;2' )>0 then begin
            VL_BC_ICMS:=0;
            VL_ICMS:=0;
          end else begin
            VL_BC_ICMS:=Q.fieldbyname('moes_baseicms').ascurrency;
            VL_ICMS:=Q.fieldbyname('moes_valoricms').ascurrency;
          end;
//          if Q.fieldbyname('moes_baseicms').ascurrency=0 then
//            VL_BC_ICMS:=Q.fieldbyname('moes_vlrtotal').ascurrency;
          VL_SERV:=0;  // pedagio e demais despesas somadas
          VL_NT:=0;
          COD_INF:='';
//          COD_CTA:='';
// 24.09.19
          COD_CTA:=GetCod_Cta(Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);

// 09.02.18 -
          COD_MUN_ORIG:=GetCodigoIBGEOrigem( Q.FieldByName('moes_xmlnfet').AsString);
          COD_MUN_DEST:=FCidades.GetCodigoIBGE( EdUnid_codigo.ResultFind.FieldByName('unid_cida_codigo').AsInteger );

       end;

     end;

     ListaDocumentoCst:=TList.create;
     aliicms:=0;
// 20.04.14 - Abra cuiaba escritorio warning
     valoripi:=Q.fieldbyname('moes_valoripi').ascurrency;
     if pos( EdUnid_codigo.ResultFind.FieldByName('unid_simples').AsString,'S;2' )>0 then
       valoripi:=0;
     if (Q.fieldbyname('moes_valoricms').ascurrency>0) and (Q.fieldbyname('moes_baseicms').ascurrency>0) then
       aliicms:=100*(Q.fieldbyname('moes_valoricms').ascurrency/Q.fieldbyname('moes_baseicms').ascurrency);
// 14.05.14
     if pos( EdUnid_codigo.ResultFind.FieldByName('unid_simples').AsString,'S;2' )>0 then
       SomanoRegistroDoc('D190','000',Q.fieldbyname('moes_natf_codigo').asstring,aliicms,Q.fieldbyname('moes_vlrtotal').ascurrency,
                    0,0,
                    Q.FieldByName('moes_basesubstrib').ascurrency,Q.fieldbyname('moes_valoricmssutr').ascurrency,
                    0,valoripi  )
     else
       SomanoRegistroDoc('D190','000',Q.fieldbyname('moes_natf_codigo').asstring,aliicms,Q.fieldbyname('moes_vlrtotal').ascurrency,
                    Q.fieldbyname('moes_baseicms').ascurrency,Q.fieldbyname('moes_valoricms').ascurrency,
                    Q.FieldByName('moes_basesubstrib').ascurrency,Q.fieldbyname('moes_valoricmssutr').ascurrency,
                    0,valoripi  );

     FGeral.Fechaquery(QMovbase);
//     if ListaTodosCfops.IndexOf(Q.fieldbyname('moes_natf_codigo').asstring)=-1 then
//       ListaTodosCfops.Add(Q.fieldbyname('moes_natf_codigo').asstring);
// em conhecimentos nao informa o cfop ( nem tem o campo...)

     for p:=0 to ListaDocumentoCst.count-1 do begin
       PDocumentoCst:=ListaDocumentoCst[p];
           with AcbrSpedFiscal1.Bloco_D do begin
            with RegistroD190New do begin
              CST_ICMS:=PDocumentoCst.cst ;
              CFOP:=PDocumentoCst.cfop;
              ALIQ_ICMS:=PDocumentoCst.aliicms;
              VL_OPR:=PDocumentoCst.vl_opr;
              VL_BC_ICMS:=PDocumentoCst.vl_bc_icms;
              VL_ICMS:=PDocumentoCst.vl_icms;
              VL_RED_BC:=PDocumentoCst.vl_red_bc;
              VL_RED_BC:=PDocumentoCst.vl_red_bc;
              COD_OBS:='';
            end;
/////////            AcumulaReg('E110',PDocumentoCst.cfop,PDocumentoCst.vl_icms);
/// 21.09.18 - bloco � servi�os e E110 � somente para icms
           end;
     end;
     ListaDocumentoCst.Free;
     Q.Next;

  end;
  FGeral.Fechaquery(q);
////////////
  sistema.beginprocess('Pesquisando documentos');
// 24.02.14 - Abra Cuiaba - notas de prestacao de servi�os nao geram
// 19.02.15 - DAmama
  tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+
            Global.CodPrestacaoServicos+';'+Global.CodPrestacaoServicosE+';'+Global.CodRomaneioRemessaaOrdem+';'+
            Global.Codvendainterna+';'+Global.CodVendaSemfinan+';'+Global.CodCedulaProdutoRural;

  // 19.08.10

  SqlunidadesDet:=' and move_unid_codigo='+EdUnid_codigo.assql;
  if Global.Topicos[1015] then
    SqlunidadesDet:=' and '+FGeral.GetIN('move_unid_codigo',EdUnidades.text,'C');

  Q:=sqltoquery('select * from movestoque'+
                ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                ' inner join estoque on ( move_esto_codigo=esto_codigo )'+
                ' inner join natureza on (natf_codigo=moes_natf_codigo)'+
                ' where '+FGeral.Getin('move_status','N;X;E;D;Y;I','C')+
                ' and moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.Getin('moes_status','N;X;E;D;Y;I','C')+
                ' and move_datamvto>='+EdInicio.assql+
                ' and move_datamvto<='+EdTermino.assql+
                ' and '+FGeral.GetNOTIN('moes_serie','F;F ','C')+
                ' and '+FGeral.GetNOTIN('moes_especie','CF;CF ;','C')+
                ' and '+FGeral.GetNOTIN('moes_tipomov',tiposnao+';'+Global.CodConhecimento+';'+global.CodConhecimentoSaida,'C')+
                ' and move_datacont is not null'+
                sqlunidadesdet+
                ' and moes_natf_codigo is not null'+
                ' order by move_transacao,move_datamvto,move_numerodoc,move_aliicms' );
  if Q.eof then begin
    Avisoerro('Nada encontrado para exporta��o.  Ser� gerado SEM movimento');
  end;

  Sistema.beginprocess('Exportando movimento de entrada e saida');

  if not Q.eof then begin
    with AcbrSpedFiscal1.Bloco_C do begin
      LimpaRegistros;
      with RegistroC001New do begin
        IND_MOV:=imComDados;
      end;
    end;
  end;

  Lista75:=TStringlist.create;
  Lista75Aux:=TStringlist.create;

  while not Q.eof do begin

//    Sistema.setmessage('Exportando movimento de entrada e saida - mestre '+Q.fieldbyname('moes_transacao').asstring);
    Sistema.setmessage('Exportando movimento de entrada e saida - mestre '+fGeral.formatadata(Q.fieldbyname('moes_datamvto').asdatetime));
//    if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposMovMovEntrada)>0 then begin
// 10.06.08 - CI - Novicarnes 'entendia' como saida...
    if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin
      es:='E';
    end else begin
      es:='S';
    end;
    cfop:=copy(Q.fieldbyname('moes_natf_codigo').asstring,1,4);
//    if  GetModelo(Q.fieldbyname('moes_tipomov').asstring) <> ModeloNfe then begin
    if pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModeloNfe+';'+ModelosnaoGeraItem+';'+ModeloNFCe )=0 then begin
      if ListaTodosCfops.IndexOf(cfop)=-1 then
        ListaTodosCfops.Add(cfop);
    end;

/////////
    if Es='E' then begin
      datanota:=Q.fieldbyname('moes_datamvto').asdatetime;
//      vlrfrete:=0;  // nf de entrada � s� para entrar no custo do produto
    end else begin
      datanota:=Q.fieldbyname('moes_dataemissao').asdatetime;
//      vlrfrete:=q.fieldbyname('moes_frete').ascurrency;
    end;
// 26.04.12 - frete 'parelho'....
    vlrfrete:=q.fieldbyname('moes_frete').ascurrency;
// 19.12.18 - Clessi - frete apenas para entrar no custo do produto porem nao somado na nota
    if (Es='E') and ( Q.FieldByName('moes_freteciffob').AsString='1' ) then
       vlrfrete:=0;

// 10.07.19
    if (  (Q.fieldbyname('moes_totprod').ascurrency+Q.fieldbyname('moes_valoripi').ascurrency+
        Q.fieldbyname('moes_valoricmssutr').ascurrency+vlrfrete) > Q.fieldbyname('moes_vlrtotal').ascurrency )
        and ( Es='E' )
        then
       vlrfrete:=0;

    QMovbase:=sqltoquery('select count(*) as ncfops from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring)+
//                           ' group by movb_natf_codigo');
// 10.07.09 - mudado para contar aliquotas e nao cfops...
                           ' group by movb_aliquota');
    aliqsicms:=0;
    while not QMovbase.eof do begin
      inc(aliqsicms);
      QMovbase.next;
    end;
// aqui em 21.03.07
    FGeral.FechaQuery(QMovbase);
// 10.07.09
    QMovbase:=sqltoquery('select count(*) as ncfops from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring)+
                           ' group by movb_natf_codigo');
    numcfops:=0;
    while not QMovbase.eof do begin
      inc(numcfops);
      QMovbase.next;
    end;
    FGeral.FechaQuery(QMovbase);
/////////////////////////

    QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring)+
//                           ' and movb_natf_codigo<>'+stringtosql(cfop)+  // 12.03.08
//                           ' order by movb_aliquota');
// 07.10.10 - dobra no validapr o registro 50
                           'and movb_tipomov <> '+Stringtosql(Global.CodPrestacaoServicos)+
                           ' order by movb_natf_codigo');
    if pos(Qmovbase.fieldbyname('movb_status').asstring,'X;Y')>0 then
      situacaonota:='S'
    else
      situacaonota:='N';

    QMovbase.first;

//    PesquisaEntidade(Q.fieldbyname('moes_tipocad').asstring,Q.fieldbyname('moes_tipo_codigo').asinteger);

    ListaAliquotas:=TStringlist.create;
    ListaBases:=TStringlist.create;
    ListaCfops:=TStringlist.create;
    ListaCSTs:=TStringlist.create;

     x:=q.fieldbyname('move_transacao').asstring+q.fieldbyname('move_datamvto').asstring+q.fieldbyname('move_numerodoc').asstring;
////////////////////////////////////////////////////////////////////////////////////
// 21.03.07
     codigofiscal:=FSittributaria.CSttoCF(Qmovbase.FieldByName('movb_cst').Asstring,'',es);
// 25.02.14 - ver como parametrizar - Gris - SC
    if Q.fieldbyname('moes_estado').AsString='SC' then begin
       if  Qmovbase.FieldByName('movb_cst').Asstring='040' then
         codigofiscal:='4'
       else if Qmovbase.FieldByName('movb_cst').Asstring='060' then
         codigofiscal:='2';
    end;
// 04.07.07
     if QMovbase.FieldByName('movb_reducaobc').AsCurrency>0 then
       codigofiscal:='2';
     isentas:=0;outras:=0;
     baseicms:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
// 04.07.07
     if Q.FieldByName('move_tipomov').AsString=Global.CodCompraProdutor then
       baseicms:=0;

     if ( pos( codigofiscal,'2;3' ) >0 ) and (QMovbase.FieldByName('movb_reducaobc').AsCurrency=0) then begin
//       isentas:=Q.FieldByName('moes_baseicms').AsCurrency
       isentas:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
       baseicms:=0;
// 04.07.07
     end else if ( pos( codigofiscal,'2;3' ) >0 ) and (QMovbase.FieldByName('movb_reducaobc').AsCurrency>0) then begin
       isentas:=QMovbase.FieldByName('movb_basecalculo').AsCurrency-(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
       baseicms:=(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
// 21.12.09 - Novi ref. 10.2007
       if ( aliqsicms=1 ) and ( numcfops=1 ) then begin
         isentas:=Q.FieldByName('moes_vlrtotal').AsCurrency-Q.FieldByName('moes_baseicms').AsCurrency;
         baseicms:=Q.FieldByName('moes_baseicms').AsCurrency;
       end;
////////////
     end else if codigofiscal='5' then begin
//       outras:=Q.FieldByName('moes_baseicms').AsCurrency
       if QMovbase.FieldByName('movb_reducaobc').AsCurrency>0 then begin
         outras:=QMovbase.FieldByName('movb_basecalculo').AsCurrency-(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
         baseicms:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100);
       end else begin
         outras:=Qmovbase.FieldByName('movb_basecalculo').AsCurrency;
         baseicms:=0;
       end;
     end else
       outras:=valoripi;   //  20.04.14 Q.FieldByName('moes_valoripi').AsCurrency;
// 13.11.07
     if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 then begin
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
// 18.10.12 - clessi - venda com mais de uma aliquota de icms
       if aliqsicms>1 then begin
         baseicms:=Q.FieldByName('moes_baseicms').AsCurrency;
         vlricms:=Q.FieldByName('moes_valoricms').AsCurrency;
       end;
     end else begin
// 17.04.07
//       valornota:=QMovbase.FieldByName('movb_basecalculo').AsCurrency+Q.fieldbyname('moes_valoripi').ascurrency;
// 16.11.07
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
       if (Q.FieldByName('moes_tipomov').asstring=Global.CodVendaConsigMercantil) and (QMovbase.FieldByName('movb_basecalculo').AsCurrency=0) then begin
         valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency+valoripi; // 20.04 Q.fieldbyname('moes_valoripi').ascurrency;
         baseicms:=Q.FieldByName('moes_baseicms').AsCurrency;
// 10.09.09
       end else if (Q.FieldByName('moes_tipomov').asstring=Global.CodCompraIndustria) and (QMovbase.FieldByName('movb_basecalculo').AsCurrency=0) then begin
         valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
         baseicms:=Q.FieldByName('moes_baseicms').AsCurrency;
       end;
     end;
// 18.10.12 - Clessi
     if aliqsicms=1 then begin
////////////////////
// 04.07.07
       vlricms:=QMovbase.FieldByName('movb_imposto').Ascurrency;
       if ( QMovbase.FieldByName('movb_aliquota').Ascurrency>0 ) and (QMovbase.FieldByName('movb_basecalculo').AsCurrency>0) then
         vlricms:=baseicms*(QMovbase.FieldByName('movb_aliquota').Ascurrency/100);
       aliqicms:=QMovbase.FieldByName('movb_aliquota').Ascurrency;
////////////////////
     end;
// 23.10.07
     if QMovbase.fieldbyname('movb_natf_codigo').asstring<>'' then
       cfop50:=copy(QMovbase.fieldbyname('movb_natf_codigo').asstring,1,4)
     else
       cfop50:=cfop;

     if (Q.FieldByName('moes_tipomov').asstring=Global.Codcompraprodutor)
       or (situacaonota='S')
       or (Q.FieldByName('moes_tipomov').asstring=Global.CodPrestacaoServicos)
       then begin  // 16.09.10 - Abra
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
       baseicms:=0;
       vlricms:=0;
       aliqicms:=0;
     end;
// 21.02.16 - Unicafes   - 18.10.16 - Novicarnes - 'xml errado'
     if (Q.FieldByName('moes_tipomov').asstring=Global.Codcompraprodutor) then begin
       valornota:=TexttoValor( FExpNfetxt.GetTag('vNF', Q.fieldbyname('moes_xmlnfet').AsString ) );
       if valornota < Q.FieldByName('moes_vlrtotal').AsCurrency then valornota:= Q.FieldByName('moes_vlrtotal').AsCurrency;
     end;
// notas de combustivel elize...
     if baseicms>valornota then
        baseicms:=valornota;
     if (baseicms>0) and (vlricms=0) then begin
       baseicms:=0;
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
     end;
// 06.07.07
     if ( Q.FieldByName('moes_vlrtotal').AsCurrency>QMovbase.fieldbyname('movb_basecalculo').ascurrency ) and
        ( QMovbase.FieldByName('movb_basecalculo').AsCurrency>0 ) and ( aliqsicms=1 ) then begin
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
// 11.02.08 - entradas com mercadorias e servi�os cfops 1556 e 1933 e td lan�ado em 1556 - quando lanca o 'primeiro'
//            registro 50 desmembrando a nota
// 04.03.08
//       if (Q.fieldbyname('moes_vlrtotal').ascurrency>Q.fieldbyname('moes_totprod').ascurrency) and
//          (Q.fieldbyname('moes_natf_codigo').asstring='1556') and
//          (Q.fieldbyname('moes_totprod').ascurrency>0) then
//          valornota:=Q.fieldbyname('moes_totprod').ascurrency;
// 11.02.08  - 12.03.08
// 10.07.09 - caso tiver mais de um registro mas com mesma aliquota e cfop diferente

// 22.02.11 - retirado este igual if abaixo
//        if numcfops>1 then
//          valornota:=QMovbase.FieldByName('movb_basecalculo').AsCurrency

     end;
// 22.02.11 - retirado este if devido notas de entrada com servicos dai total merc fica
//            menor que o total da nota e tem mais de um cfop...bicheiras das entradas
//      else if ( Q.FieldByName('moes_vlrtotal').AsCurrency>QMovbase.fieldbyname('movb_basecalculo').ascurrency ) and
//        ( QMovbase.FieldByName('movb_basecalculo').AsCurrency>0 ) and ( aliqsicms>1 ) then
//          valornota:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;


     perdesco:=0;vlrdesco:=0;
     if (Q.FieldByName('moes_vlrtotal').AsCurrency<Q.FieldByName('moes_totprod').AsCurrency) and
        (Q.FieldByName('moes_baseicms').AsCurrency=0)
         then begin
       perdesco:= 100 - ( (Q.FieldByName('moes_vlrtotal').AsCurrency/Q.FieldByName('moes_totprod').AsCurrency)*100 );
       perdesco:=roundvalor(perdesco);
// 11.04.11
//       vlrdesco:=FGeral.Arredonda(Q.FieldByName('moes_totprod').AsCurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100),2);
// 15.04.14 - Abra cuiaba - 286 - 285.99
       vlrdesco:=(Q.FieldByName('moes_totprod').AsCurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100));

// 09.11.17
     end else if (Q.FieldByName('moes_vlrtotal').AsCurrency<Q.FieldByName('moes_totprod').AsCurrency) and
                  ( Es = 'S' ) then begin

       perdesco:= 100 - ( (Q.FieldByName('moes_vlrtotal').AsCurrency/Q.FieldByName('moes_totprod').AsCurrency)*100 );
       perdesco:=roundvalor(perdesco);
       vlrdesco:=(Q.FieldByName('moes_totprod').AsCurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100));

     end;

/////////////// - recolocado em 27.01.11 - retirado em 25.02.14 devido entrada do Gris
//                ver se � necessario fazer por unidade e ver se � do simples
// 24.04.14 - recolocado devido a devolucoes da novicarnes
     if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
        then begin    // entradas td em outras e valor contabil
        outras:=valornota;
        baseicms:=0;
        isentas:=0;
        vlricms:=0;
        aliqicms:=0;
     end;
// 14.11.14 - clessi - nao gerava ipi nas saidas
//            dai deu erro nas entradas com total ipi mestre <> ipi detalhe no c190
//     if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 then
     valoripi:=Q.fieldbyname('moes_valoripi').ascurrency;
// 12.03.15 - casanova
     if pos( EdUnid_codigo.ResultFind.FieldByName('unid_simples').AsString,'S;2' )>0 then
       valoripi:=0;

/////////////////////

// 05.07.10 - Granzotto - NF venda consumidor
     if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'567')>0 ) then begin
{
///////////////////////////////////
        with AcbrSpedFiscal1.Bloco_C do begin
          with RegistroC300New do begin
            COD_MOD:='02';
            SER:=Q.FieldByName('moes_serie').asstring;
            SUB:='';
            NUM_DOC_INI:=Q.fieldbyname('moes_numerodoc').asstring;
            NUM_DOC_FIN:=Q.fieldbyname('moes_numerodoc').asstring;
            DT_DOC:=Q.fieldbyname('moes_dataemissao').asdatetime;
            VL_DOC:=valornota;
            VL_PIS:=0;
            VL_COFINS:=0;
            COD_CTA:='';
          end;
        end;
///////////////////////////////////
}

     end else if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'123')>0 ) then begin

       linha:='x';  // nao gera nada

     end else begin

        with AcbrSpedFiscal1.Bloco_C do begin

         if Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , ModelosRegistroC100 )  >0 then begin

          with RegistroC100New do begin

            if es='E' then
              IND_OPER:=tpEntradaAquisicao
            else
              IND_OPER:=tpSaidaPrestacao;
// 16.03.17
{
              if copy(Q.fieldbyname('moes_especie').asstring,1,3)='NFE' then
                COD_MOD:='55'
              else
                COD_MOD:='65';
                }
// 04.07.19 - Novicarnes
              if copy(Q.fieldbyname('moes_especie').asstring,1,3)='NFC' then
                COD_MOD:='65'
// 25.10.19
              else if copy(Q.fieldbyname('moes_especie').asstring,1,4)='NFAE' then
                COD_MOD:='1B'
              else
                COD_MOD:='55';
// 22.08.12 - checa se teve nf de saida com cfop '7'
//            if copy(cfop50,1,1)='7' then Reg10101100:='S';
//Clessi - por enquanto 'N' fixo
            if pos(Qmovbase.fieldbyname('movb_status').asstring,'X;Y;I')=0 then begin
              if COD_MOD<>'65' then begin
                IncluiParticipa( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring );
                IncluiUnidadeEstoque(  Q.fieldbyname('esto_unidade').asstring,Q.fieldbyname('move_esto_codigo').asstring );
              end;
            end;
// 23.02.14 - nfe de entrada
//            if ( uppercase(copy(Q.fieldbyname('moes_especie').AsString,1,3))='NFE' ) and
//            ( pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1),'1;2;3' ) > 0 ) then
//              COD_MOD:='55'
//            else

            COD_MOD:=GetModelo(Q.fieldbyname('moes_tipomov').asstring);
            {
// 06.07.20
            if ( Global.usuario.codigo = 100 ) and (Qmovbase.fieldbyname('movb_status').asstring='Y') then begin

               Showmessage('NF '+Q.fieldbyname('moes_numerodoc').asstring+' denegada' );

            end;
            }

//            NUM_DOC:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,09);
            if (Qmovbase.fieldbyname('movb_status').asstring='X') or
               ( AnsiPos('Cancelamento',Q.fieldbyname('moes_retornonfe').asstring)>0 )
              then begin
              COD_SIT:=sdCancelado;
// 24.02.12 - novo validador exige chave das canceladas no livro fiscal
              if trim(Q.fieldbyname('moes_chavenfe').asstring)<>'' then
                CHV_NFE:=copy(Q.fieldbyname('moes_chavenfe').asstring,1,44);
// 12.02.16 - novas validacoes
              SER:=trim(copy(Q.fieldbyname('moes_serie').asstring,1,3));
              NUM_DOC:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,09);
////////////////////////
            end else if Qmovbase.fieldbyname('movb_status').asstring='Y' then begin

              COD_SIT:=sdDoctoDenegado;
// 06.07.20 - novo validador exige chave das denegadas no livro fiscal
              if trim(Q.fieldbyname('moes_chavenfe').asstring)<>'' then
                CHV_NFE:=copy(Q.fieldbyname('moes_chavenfe').asstring,1,44);
              SER:=trim(copy(Q.fieldbyname('moes_serie').asstring,1,3));
              NUM_DOC:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,09);

// 17.09.14 - Abra - Cuiaba
            end else if Qmovbase.fieldbyname('movb_status').asstring='I' then begin

              COD_SIT:=sdDoctoNumInutilizada;
              NUM_DOC:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,09);

            end else  begin
// 18.10.12 - Clessi - NF-e de complemento de Icms
              if Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1Asinteger('ConfNfComple') then
                COD_SIT:=sdFiscalCompl
// 25.10.19
              else if copy(Q.fieldbyname('moes_especie').asstring,1,4)='NFAE' then

                COD_SIT:=sdRegimeEspecNEsp

              else
                COD_SIT:=sdRegular;
// 16.03.17
              if COD_MOD<>'65' then
                COD_PART:=GetCodigoParticipa( Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring ) ;
//              SER:=strspace(Q.fieldbyname('moes_serie').asstring,3);
              SER:=trim(copy(Q.fieldbyname('moes_serie').asstring,1,3));
              DT_DOC:=Q.fieldbyname('moes_dataemissao').asdatetime;
              DT_E_S:=datanota;
// 19.09.2022 - Clessi - Receita Sc exige lan�amento com valor zerado da entrada NFPe
              if Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodEntradaNFPe)>0  then

                 VL_DOC:=0

              else

                 VL_DOC:=valornota;

// aqui em 24.11.15
////////////////////////////////
              NUM_DOC:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,09);
              if ( trim(Q.fieldbyname('moes_chavenfe').asstring)<>'' )  and (es='E')
                and ( Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodCompraProdutorMerenda)=0 ) then
                IND_EMIT:=edTerceiros
              else
                IND_EMIT:=edEmissaoPropria;
//////////////////////////////////
              if pos( Q.fieldbyname('moes_tipomov').asstring,Global.TiposGeraFinanceiro)>0 then begin
                if Q.fieldbyname('moes_vispra').asstring='V' then
                  IND_PGTO:=tpVista
                else
                  IND_PGTO:=tpPrazo;
              end else
//                  IND_PGTO:=tpSemPagamento;
// 12.02.16
                  IND_PGTO:=tpOutros;
              VL_DESC:=vlrdesco;

              VL_MERC:=Q.fieldbyname('moes_totprod').ascurrency;

// os 'cagadex' das notas de entrada da novi...22.02.11
              if (es='E') and ( Q.fieldbyname('moes_totprod').ascurrency=0 ) then
                VL_MERC:=valornota
// 20.04.12
              else if ( pos( EdUnid_codigo.ResultFind.FieldByName('unid_simples').AsString,'S;2' ) >0 ) then

                VL_MERC:=Q.fieldbyname('moes_totprod').ascurrency+Q.fieldbyname('moes_valoripi').ascurrency;

// 26.04.12 - retirado pra ver 'o estouro'
//              else if (es='E') and ( Q.fieldbyname('moes_totprod').ascurrency>0 ) and
//                      ( Q.fieldbyname('moes_totprod').ascurrency<valornota )
//                then begin
//                if vlrfrete+Q.fieldbyname('moes_valoripi').ascurrency+;
//                VL_MERC:=valornota;

// 19.09.2022 - Clessi - Receita Sc exige lan�amento com valor zerado da entrada NFPe
              if Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodEntradaNFPe)>0  then

                 VL_MERC:=0;

              VL_FRT:=vlrfrete;
              VL_SEG:=0;
              if Q.FieldByName('moes_freteciffob').asstring='1' then
                IND_FRT:=tfPorContaEmitente
              else
                IND_FRT:=tfPorContaDestinatario;
              VL_OUT_DA:=0;
              if COD_MOD<>'65' then begin

                VL_BC_ICMS:=baseicms;
                VL_ICMS:=vlricms;
// 18.10.12 - Clessi - NF-e de complemento de Icms
                if ( Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1Asinteger('ConfNfComple') ) and
                   ( baseicms=0 ) then begin
                  BuscaNosItems(Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
                                Q.fieldbyname('moes_perdesco').ascurrency,baseicms,vlricms);
                  VL_BC_ICMS:=baseicms;
                  VL_ICMS:=vlricms;
// 26.06.17 - devolucao sem financeiro - DL - usada para notas emitidas pela fazenda ref. Entrada de icms...
                end else if Q.fieldbyname('moes_tipomov').asstring=Global.CodDevolucaoSemFinan then begin

                  BuscaNosItems(Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
                                Q.fieldbyname('moes_perdesco').ascurrency,baseicms,vlricms);
                  VL_DOC:=baseicms;
                  VL_MERC:=baseicms;

// 26.06.17 - 'notas maxicorte' ra��o cujo unitario tem 'quase d�zima'...
// 30.07.20 - retirado para ficar registro c100 igual ao danfe pelo menos
//                end else if (Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraMatConsumo) and
//                            ( pos(Q.fieldbyname('moes_natf_codigo').asstring,'1102/2102')>0 )
//                  then begin
//                  BuscaNosItems(Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
//                                Q.fieldbyname('moes_perdesco').ascurrency,baseicms,vlricms);
//                  VL_DOC:=baseicms+vlrfrete;
//                  VL_MERC:=baseicms+vlrfrete;
// 26.06.17 - transf. 'com % de diminuicao' da novi vindas da fazenda
                end else if Q.fieldbyname('moes_tipomov').asstring=Global.CodTransfEntrada then begin

                  BuscaNosItems(Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
                                Q.fieldbyname('moes_perdesco').ascurrency,baseicms,vlricms);
                  VL_DOC:=baseicms;
                  VL_MERC:=baseicms;

// 19.09.2022 - Clessi - Receita Sc exige lan�amento com valor zerado da entrada NFPe
                end else  if Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodEntradaNFPe)>0  then begin

                  VL_DOC:=0;
                  VL_MERC:=0;
                  VL_BC_ICMS:=0;
                  VL_ICMS:=0;

                end;

                VL_BC_ICMS_ST:= Q.FieldByName('moes_basesubstrib').ascurrency;
                VL_ICMS_ST:=Q.FieldByName('moes_valoricmssutr').ascurrency;

// 26.09.11 mas se no 'primeiro item' nao tiver % do ipi mas em outro tiver...
//              if Q.fieldbyname('move_aliipi').ascurrency>0 then
                VL_IPI:=valoripi;   // 20.04 - Q.fieldbyname('moes_valoripi').ascurrency;
// 29.09.2021 - Clessi
// 'APROVEITAMENTO DO CREDITO DE ICMS NO VALOR DE R$ 278,85'
                if AnsiPos( 'APROVEITAMENTO DO CREDITO DE ICMS NO VALOR DE',
                            UpperCase( Q.fieldbyname('moes_xmlnfet').AsString ) ) > 0 then begin

                   New( PRegC195 );
                   PRegC195.COD_OBS := CODCREDITOICMS;
                   PRegC195.TRANSACAO := Q.fieldbyname('moes_transacao').AsString;
                   PRegC195.ALIICMS := GetAliqicms( UpperCase( Q.fieldbyname('moes_xmlnfet').AsString ) );
                   PRegC195.TXT_COMPL := currtostr(PRegC195.ALIICMS)+' CREDITO ICMS';
                   if PRegC195.ALIICMS>0 then

                      ListaRegC195.add( PRegC195 );

                   if PRegC195.ALIICMS > 0 then begin

                     with RegistroC195New do begin

                        COD_OBS := CODCREDITOICMS;
                        TXT_COMPL := currtostr(PRegC195.ALIICMS)+'% CREDITO ICMS';

                     end;

                   end;

                end;

              end; // modelo <> 65

              VL_PIS:=0;
              VL_COFINS:=0;
              VL_PIS_ST:=0;
              if trim(Q.fieldbyname('moes_chavenfe').asstring)<>'' then
                CHV_NFE:=copy(Q.fieldbyname('moes_chavenfe').asstring,1,44);
              VL_COFINS_ST:=0;
// 23.05.12 - Clessi - para gerar aqui pois NFe n�o gera o registro C170
              if ( trim(Q.fieldbyname('moes_chavenfe').asstring)<>'' )  and (es='S') then begin
// 12.06.15 - novicarnes - leonir
                 if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
                    then     // entradas td em outras e valor contabil
                    xCSTIPI:='03'
                 else if valoripi>0 then  // 20.04
                    xCSTIPI:='00'
                  else
                    xCSTIPI:='01';

                aliqicms:=QMovbase.FieldByName('movb_aliquota').Ascurrency;
// 19.09.2022 - Clessi - Receita Sc exige lan�amento com valor zerado da entrada NFPe
                if Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodEntradaNFPe)>0  then

                   SomanoRegistro( 'E510',xCSTIPI,Q.fieldbyname('moes_natf_codigo').asstring,
                              aliqicms,0,0,0,
                              Q.FieldByName('moes_basesubstrib').ascurrency,Q.FieldByName('moes_valoricmssutr').ascurrency,
                              0,
                              0 )
                else

                   SomanoRegistro( 'E510',xCSTIPI,Q.fieldbyname('moes_natf_codigo').asstring,
                              aliqicms,Q.fieldbyname('moes_totprod').ascurrency,baseicms,vlricms,
                              Q.FieldByName('moes_basesubstrib').ascurrency,Q.FieldByName('moes_valoricmssutr').ascurrency,
                              Q.fieldbyname('moes_totprod').ascurrency-baseicms,
                              valoripi );  // 20.04
              end;

            end;

          end;  // C100


         end else if Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , '06;29' )  >0 then begin
/////////////////////////////////////////////////
// fatura de energia el�trica + Conta de Agua
////////////////////////////////////////////
           with RegistroC500New do begin

             IND_OPER:=tpEntradaAquisicao;
             IND_EMIT:=edEmissaoPropria;
             IncluiParticipa( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring );
             COD_PART:=GetCodigoParticipa(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring);
             COD_SIT:=sdRegular;
             SER:=Q.fieldbyname('moes_serie').asstring;
             SUB:='';
//             COD_CONS:=ccComercial ;
// 01.09.11 -depois de baixar do svn
             COD_CONS:='01';
              if Q.fieldbyname('moes_perdesco').ascurrency>0 then
                vlrdesco:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100),2)
              else
                vlrdesco:=0;
//             NUM_DOC:=Q.fieldbyname('moes_numerodoc').asstring;
             NUM_DOC:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,09);
             DT_DOC:=Q.fieldbyname('moes_dataemissao').asdatetime;
             DT_E_S:=Q.fieldbyname('moes_datamvto').asdatetime;
             VL_DOC:=Q.FieldByName('moes_vlrtotal').Ascurrency;
             VL_DESC:=vlrdesco;
             VL_FORN:=QMovbase.FieldByName('movb_basecalculo').Ascurrency;
             VL_SERV_NT:=0;
             VL_TERC:=0;
             VL_DA:=0;
             VL_BC_ICMS:=Q.fieldbyname('moes_baseicms').ascurrency;
             VL_ICMS:=Q.fieldbyname('moes_valoricms').ascurrency;
             VL_BC_ICMS_ST:=0;
             VL_ICMS_ST:=0;
             COD_MOD:=GetModelo(Q.fieldbyname('moes_tipomov').asstring);
             if  GetModelo(Q.fieldbyname('moes_tipomov').asstring)='06' then begin
               TP_LIGACAO:=tlTrifasico;
               COD_GRUPO_TENSAO:=gtB4a;
             end;
           end;

//////////////// C510 - 'item' de energia el�trica  - NAO DEVE SER INFORMADO
//                      PRO TIPO DE PERFIL DA NOVICARNES - VARIA CFE A EMPRESA
{
           with RegistroC510New do begin
             NUM_ITEM:=strzero(contitem,3);
             COD_ITEM:=Q.fieldbyname('move_esto_codigo').asstring;
//             COD_CLASS:='';
             UNID:=GetCodigoUnidadeEstoque( Q.fieldbyname('esto_unidade').asstring );
             VL_ITEM:=totalitem;
             VL_DESC:=0;
             CST_ICMS:=xcst;
             CFOP:=cfop54;
             VL_BC_ICMS:=baseicms;
             ALIQ_ICMS:=aliqicms;
             VL_ICMS:=vlricms;
             VL_BC_ICMS_ST:=baseicmsst;
             if baseicmsst>0 then
               ALIQ_ST:=(valoricmsstitem/baseicmsst)*100;
             VL_ICMS_ST:=valoricmsstitem;
             IND_REC:=trPropria;
             COD_PART:=GetCodigoParticipa(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring);
             VL_PIS:=0;
             VL_COFINS:=0;
// checar se pode ser 'pego' atrav�s da config. de movimento...
             COD_CTA:='000';
           end;
             }
////////////////
           aliicms:=0;
           if (Q.fieldbyname('moes_valoricms').ascurrency>0) and (Q.fieldbyname('moes_baseicms').ascurrency>0) and
              ( Q.fieldbyname('moes_valoricms').ascurrency<Q.fieldbyname('moes_baseicms').ascurrency )
             then
             aliicms:=100*(Q.fieldbyname('moes_valoricms').ascurrency/Q.fieldbyname('moes_baseicms').ascurrency);

           ListaDocumentoCst:=TList.create;
// 10.04.14 - Abra - cuiaba
           SomanoRegistroDoc('C590','000',Q.fieldbyname('moes_natf_codigo').asstring,aliicms,Q.fieldbyname('moes_vlrtotal').ascurrency,
//                          Q.fieldbyname('moes_vlrtotal').ascurrency,Q.fieldbyname('moes_valoricms').ascurrency,
                          Q.fieldbyname('moes_baseicms').ascurrency,Q.fieldbyname('moes_valoricms').ascurrency,
                          Q.FieldByName('moes_basesubstrib').ascurrency,Q.fieldbyname('moes_valoricmssutr').ascurrency,
                          0,valoripi  );  // 20.04
           for p:=0 to ListaDocumentoCst.Count-1 do begin
             PDocumentoCst:=ListaDocumentoCst[p];
             with AcbrSpedFiscal1.Bloco_D do begin
              with RegistroC590New do begin
                CST_ICMS:=PDocumentoCst.cst ;
                CFOP:=PDocumentoCst.cfop;
                ALIQ_ICMS:=PDocumentoCst.aliicms;
                VL_OPR:=PDocumentoCst.vl_opr;
                VL_BC_ICMS:=PDocumentoCst.vl_bc_icms;
                VL_ICMS:=PDocumentoCst.vl_icms;
                VL_RED_BC:=PDocumentoCst.vl_red_bc;
                VL_RED_BC:=PDocumentoCst.vl_red_bc;
                COD_OBS:='';
              end;
///////////////              AcumulaReg('E110',PDocumentoCst.cfop,PDocumentoCst.vl_icms);
             end;
           end;
           ListaDocumentoCst.Free;


         end else if Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , '22' )  >0 then begin
//////////////////////////////
// fatura de conta de telefone
//////////////////////////////
           with AcbrSpedFiscal1.Bloco_D.RegistroD500New do begin
             Inc(NRegD500);
             IND_OPER:=tpEntradaAquisicao;
             IND_EMIT:=edEmissaoPropria;
             IncluiParticipa( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring );
// 11.04.11 - nao inclui participante de conta telefonica
// 15.07.11 - novo validador pelo jeito exige
             COD_PART:=GetCodigoParticipa(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring);
             COD_MOD:='22';
             COD_SIT:=sdRegular;
             SER:=Q.fieldbyname('moes_serie').asstring;
             SUB:='';
              if Q.fieldbyname('moes_perdesco').ascurrency>0 then
                vlrdesco:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100),2)
              else
                vlrdesco:=0;
//             NUM_DOC:=Q.fieldbyname('moes_numerodoc').asstring;
             NUM_DOC:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,09);
             DT_DOC:=Q.fieldbyname('moes_dataemissao').asdatetime;
             DT_A_P:=Q.fieldbyname('moes_datamvto').asdatetime;
             VL_DOC:=Q.FieldByName('moes_vlrtotal').Ascurrency;
             VL_DESC:=vlrdesco;
//             COD_CTA:='';
// 24.09.19
             COD_CTA:=GetCod_Cta(Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);
             TP_ASSINANTE:=assComercialIndustrial;
    // demais campos penso nao irei usar...

           end;

           aliicms:=0;
           if (Q.fieldbyname('moes_valoricms').ascurrency>0) and (Q.fieldbyname('moes_baseicms').ascurrency>0) and
              ( Q.fieldbyname('moes_valoricms').ascurrency<Q.fieldbyname('moes_baseicms').ascurrency )
             then
             aliicms:=100*(Q.fieldbyname('moes_valoricms').ascurrency/Q.fieldbyname('moes_baseicms').ascurrency);

           ListaDocumentoCst:=TList.create;
           SomanoRegistroDoc('D590','000',Q.fieldbyname('moes_natf_codigo').asstring,aliicms,Q.fieldbyname('moes_vlrtotal').ascurrency,
// 07.04.14 - Abra - cuiaba
//                          Q.fieldbyname('moes_vlrtotal').ascurrency,Q.fieldbyname('moes_valoricms').ascurrency,
                          Q.fieldbyname('moes_baseicms').ascurrency,Q.fieldbyname('moes_valoricms').ascurrency,
                          Q.FieldByName('moes_basesubstrib').ascurrency,Q.fieldbyname('moes_valoricmssutr').ascurrency,
                          0,valoripi  );   // 20.04
           for p:=0 to ListaDocumentoCst.Count-1 do begin

             PDocumentoCst:=ListaDocumentoCst[p];
             with AcbrSpedFiscal1.Bloco_D do begin

              with RegistroD590New do begin
                CST_ICMS:=PDocumentoCst.cst ;
                CFOP:=PDocumentoCst.cfop;
                ALIQ_ICMS:=PDocumentoCst.aliicms;
                VL_OPR:=PDocumentoCst.vl_opr;
                VL_BC_ICMS:=PDocumentoCst.vl_bc_icms;
                VL_ICMS:=PDocumentoCst.vl_icms;
                VL_RED_BC:=PDocumentoCst.vl_red_bc;
                VL_RED_BC:=PDocumentoCst.vl_red_bc;
                COD_OBS:='';
              end;
//              AcumulaReg('E110',PDocumentoCst.cfop,PDocumentoCst.vl_icms);
/// 21.09.18 - bloco � servi�os e E110 � somente para icms
             end;
           end;
           ListaDocumentoCst.Free;


         end;  // if dos diversos modelos de documentos
         //////////////////////////////////////////////////////////

{   // s� gerar se usar o campo de informacoes complementares de nao de informacoes
//     adicionais
          with RegistroC110New do begin
            if (es='S') and ( trim(Q.fieldbyname('moes_mensagem').asstring)<>'' ) then begin
              QE:=sqltoquery('select * from mensagensnf where mens_descricao='+
                              Stringtosql(Q.fieldbyname('moes_mensagem').asstring));
              if not QE.Eof then begin
                COD_INF:=strzero(QE.fieldbyname('mens_codigo').asinteger,6);
                TXT_COMPL:=Q.fieldbyname('moes_mensagem').asstring;
              end;
              FGeral.FechaQuery(QE);
            end;
          end;
}
// checar se for entrada com cfop come�ado por '3' - importa��o gerar o registro
// C120
{
          with RegistroC120New do begin
            if (es='E') and ( copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1)='3' ) then begin
              COD_DOC_IMPO:=diImportacao;   // diSimplificadaImport
              ...
            end;
          end;
}

// s� gerar se for nota de presta��o de servi�o mas N�o serie F que �
// 'somente da prefeitura'
          if (es='S') and ( Q.fieldbyname('moes_tipomov').asstring=Global.CodPrestacaoServicos )
               and ( Q.fieldbyname('moes_serie').asstring<>'F' ) then begin
            with RegistroC130New do begin
               VL_SERV_NT:=Q.fieldbyname('moes_vlrservicos').ascurrency;
               VL_BC_ISSQN:=Q.fieldbyname('moes_baseiss').ascurrency;
               VL_ISSQN:=Q.fieldbyname('moes_valoriss').ascurrency;
               VL_BC_IRRF:=0;
               VL_IRRF:=0;
               VL_BC_PREV:=0;
               VL_PREV:=0;
            end;
          end;

// gerar somente se 'gerou financeiro'...
          if ( Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , ModelosRegistroC140 ) >0 )
             and ( pos(Q.fieldbyname('moes_status').asstring,'X;Y;I')=0)
            then begin
            QPend:=Sqltoquery('select pend_nparcelas,pend_numerodcto,pend_parcela,pend_datavcto,Pend_Valor,pend_nparcelas from pendencias where pend_transacao='+
                              Stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                              ' and pend_status<>''C'' and pend_tipomov='+
                              Stringtosql(Q.fieldbyname('moes_tipomov').asstring) );
            if not QPend.Eof then begin
              with RegistroC140New do begin
                   IND_EMIT:=edEmissaoPropria;
                   IND_TIT:=tcDuplicata;
                   DESC_TIT:='';
                   NUM_TIT:=QPend.fieldbyname('pend_numerodcto').asstring;
                   QTD_PARC:=QPend.fieldbyname('pend_nparcelas').asinteger;
                   VL_TIT:=valornota;
              end;
              while not QPend.eof do begin
                with RegistroC141New do begin
                     NUM_PARC:=QPend.fieldbyname('pend_parcela').asstring;
                     DT_VCTO:=QPend.fieldbyname('pend_datavcto').asdatetime;
                     VL_PARC:=QPend.fieldbyname('Pend_Valor').AsCurrency;
                end;
                QPend.Next;
              end;
            end;
            FGeral.FechaQuery(QPend);
          end;

// detalhes do(s) volume(s) transportados, do transportador e placa do ve�culo
///////////////////////////////////////////////////////////////////////
         if ( Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , ModelosRegistroC160 ) > 0 )  and (es='S')
           and ( pos(Q.fieldbyname('moes_status').asstring,'X;Y;I')=0)
           then begin
           with RegistroC160New do begin
             if ( Q.fieldbyname('moes_pesoliq').ascurrency>0 ) then begin
               QTransp:=sqltoquery('select * from transportadores where tran_codigo='+stringtosql(Q.fieldbyname('moes_tran_codigo').asstring));
               if not QTransp.eof then begin
//                 IncluiParticipa( strtointdef( Q.fieldbyname('moes_tran_codigo').asstring,0 ),'T' );
//                 COD_PART:=GetCodigoParticipa( Q.fieldbyname('moes_tran_codigo').asinteger,'T' );
                 COD_PART:=GetCodigoParticipa( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring );
                 VEIC_ID:=QTransp.fieldbyname('tran_placa').asstring;
                 UF_ID:=QTransp.fieldbyname('tran_ufplaca').asstring;
                 QTD_VOL:=Q.fieldbyname('moes_qtdevolume').AsInteger;
                 PESO_BRT:=Q.fieldbyname('moes_pesobru').AsCurrency;
                 PESO_LIQ:=Q.fieldbyname('moes_pesoliq').AsCurrency;
               end;
               FGERal.FechaQuery(QTransp);
             end;
           end;
         end;

        end;  // with do Bloco C

     end;

// 23.10.07
      ListaAliquotas.add( Valortosql( aliqicms ) );
      ListaBases.add( Valortosql( valornota ) );
      ListaCfops.add( cfop50 );
      ListaCSTs.add( QMovbase.FieldByName('movb_cst').AsString );
// 27.01.11
      if pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModeloNfe+';'+ModelosnaoGeraItem+';'+ModeloNFCe )=0 then begin
        if ListaTodosCfops.IndexOf(cfop50)=-1 then
          ListaTodosCfops.Add(cfop50);
      end;

// 10.04.07  / 20.04                                         // 09.12.09
      if (valoripi>0) and (pos(Q.fieldbyname('moes_status').asstring,'X;Y;I')=0) then begin
{
        linha:=GetFormato51( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                   FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                   datanota+';'+
                   Q.fieldbyname('moes_estado').asstring+';'+
                   GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                   Q.fieldbyname('moes_serie').asstring+';'+
                   Q.fieldbyname('moes_numerodoc').asstring+';'+
                   cfop+';'
                   +'P'+';'+    //P - o pr�prio estabelecimento emite  T - emitida por terceiros
                   Valortosql( Q.FieldByName('moes_vlrtotal').AsCurrency)+';'+
                   Valortosql( baseicms )+';'+
                   Q.fieldbyname('moes_valoripi').asstring+';'+
                   Valortosql( 0 )+';'+
                   Valortosql( 0 )+';'+
                   Valortosql( 0 )+';'+
                   situacaonota+';' );
        Lista51.Add( linha );
}
      end;

//                 Q.FieldByName('movb_isentas').Asstring+';'+
//                 Q.FieldByName('movb_outras').Asstring+';'+
// 11.07.06
///////////////////
//      QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
//                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring));

      cfop50:=cfop;
      cfop54:=cfop;

      while (not QMovbase.eof) do begin
// 23.10.07
        if QMovbase.fieldbyname('movb_natf_codigo').asstring<>'' then
             cfop50:=copy(QMovbase.fieldbyname('movb_natf_codigo').asstring,1,4);
        aliqmovb:=QMovbase.fieldbyname('movb_aliquota').ascurrency;
// 12.03.08
//        if (Global.Topicos[1304])  and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 ) then
//          aliqmovb:=0;
// retirado em 10.07.09
// 13.11.07
//        if ( ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 )
// 03.03.08
        if ( ( Global.Topicos[1304] )
            and
            ( (not TemAliquota(aliqmovb) )
               or (not TemCfop(QMovbase.fieldbyname('movb_natf_codigo').asstring))
// 18.12.09
//               or (not TemCST(QMovbase.fieldbyname('movb_cst').asstring))
                )  )
// 11.02.08
//           ( not TemBase(QMovbase.fieldbyname('movb_basecalculo').ascurrency) )  )
           or
           ( ( not Global.Topicos[1304] )  )
            and
           ( not TemAliquota(QMovbase.fieldbyname('movb_aliquota').ascurrency) )
//           ( not TemBase(QMovbase.fieldbyname('movb_basecalculo').ascurrency) )
           then begin

           totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,2);
           valoripiitem:=totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100);
// 20.04.14
           if pos( EdUnid_codigo.ResultFind.FieldByName('unid_simples').AsString,'S;2' )>0 then begin
// 16.03.17 - simar - escritorio sganzerla
             totalitem:=totalitem+valoripiitem;
             valoripiitem:=0;
           end;
// 21.03.07
           codigofiscal:=FSittributaria.CSttoCF(QMovbase.FieldByName('movb_cst').Asstring);
           isentas:=0;outras:=0;
           basecalculo:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
// 04.07.07
           if Q.FieldByName('move_tipomov').AsString=Global.CodCompraProdutor then
             basecalculo:=0;

//////////////////////////////// - 14.07.09
           valornota:=basecalculo;
           if QMovbase.FieldByName('movb_reducaobc').AsCurrency>0 then
             codigofiscal:='2';
           isentas:=0;outras:=0;
           if ( pos( codigofiscal,'2;3' ) >0 ) and (QMovbase.FieldByName('movb_reducaobc').AsCurrency=0) then begin
      //       isentas:=Q.FieldByName('moes_baseicms').AsCurrency
             isentas:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
             basecalculo:=0;
      // 04.07.07
           end else if ( pos( codigofiscal,'2;3' ) >0 ) and (QMovbase.FieldByName('movb_reducaobc').AsCurrency>0) then begin
             isentas:=QMovbase.FieldByName('movb_basecalculo').AsCurrency-(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
             valornota:=basecalculo;
             basecalculo:=(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
           end else if codigofiscal='5' then begin
             if QMovbase.FieldByName('movb_reducaobc').AsCurrency>0 then begin
               outras:=QMovbase.FieldByName('movb_basecalculo').AsCurrency-(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
               basecalculo:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100);
             end else begin
               outras:=Qmovbase.FieldByName('movb_basecalculo').AsCurrency;
               basecalculo:=0;
             end;
           end else
             outras:=valoripi;  // 20.04
//////////////////// - 14.07.09

//////////////////////////
{
           if pos( codigofiscal,'2;3' ) >0 then begin
             isentas:=basecalculo;
           end else if codigofiscal='5' then
             outras:=basecalculo
           else
             outras:=valoripi;
             }
//////////////////
//////
///////////////
// 23.07.07
//           valornota:=basecalculo;
           aliqicms:=QMovbase.FieldByName('movb_aliquota').Ascurrency;
           vlricms:=QMovbase.FieldByName('movb_imposto').Ascurrency;
// 05.10.10 - Abra - PS - canceladas ou nao
           if (Q.FieldByName('moes_tipomov').asstring=Global.CodPrestacaoServicos)
             then begin
             valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
             baseicms:=0;
             vlricms:=0;
             aliqicms:=0;
           end;
///////////////////////////////////////////
{ - 10.07.09 - retirado
           if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 ) and
// 04.03.08
              ( QMovbase.FieldByName('movb_cst').AsString<>'000' )
              then begin    // entradas td em outras e valor contabil
              outras:=valornota;
              basecalculo:=0;
              isentas:=0;
              vlricms:=0;
//              aliqicms:=0;  // 10.07.09
           end;
           }
/////////////////////
          if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'123')>0 ) then begin
             linha:='x';
          end else begin
{
            linha:=GetFormato50( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 datanota+';'+Q.fieldbyname('moes_estado').asstring+';'+
                 GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                 Q.fieldbyname('moes_serie').asstring+';'+
                 Q.fieldbyname('moes_numerodoc').asstring+';'+
                 cfop50+';'+'P'+';'+    //P - o pr�prio estabelecimento emite  T - emitida por terceiros
//                 Q.FieldByName('moes_vlrtotal').Asstring+';'+
//                 Valortosql( QMovbase.FieldByName('movb_basecalculo').Ascurrency+valoripi )+';'+
// 23.07.07
                 Valortosql( valornota )+';'+
                 Valortosql( basecalculo )+';'+
                 Valortosql( vlricms )+';'+
                 Valortosql( isentas )+';'+
                 Valortosql( outras )+';'+
                 Valortosql( aliqicms )+';'+
                 situacaonota+';' );

//                 QMovbase.FieldByName('movb_isentas').Asstring+';'+
//                 QMovbase.FieldByName('movb_outras').Asstring+';'+
            Lista50.Add( linha );
}
  // 13.11.07
  //          Lista50Teste.Add( strzero(Q.fieldbyname('moes_numerodoc').asinteger,6)+';'+cfop50+';'+formatfloat( '######0.00',valornota ) );

         end;

         ListaAliquotas.add( QMovbase.FieldByName('movb_aliquota').AsString );
         ListaBases.add( QMovbase.FieldByName('movb_basecalculo').AsString );
         ListaCfops.add ( cfop50 ) ;
         ListaCSTs.add( QMovbase.FieldByName('movb_cst').AsString );
//         if  GetModelo(Q.fieldbyname('moes_tipomov').asstring) <> ModeloNfe then begin
         if pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModeloNfe+';'+ModelosnaoGeraItem+';'+ModeloNFCe )=0 then begin
           if ListaTodosCfops.IndexOf(cfop50)=-1 then
             ListaTodosCfops.Add(cfop50);
         end;

///////////////////////////////////////////////////////////
{
//        end else if (QMovbase.FieldByName('movb_natf_codigo').Asstring='1556') and
// 03.03.08 - gerou tipo 50 zerado e 'a mais'...
        end else if (QMovbase.FieldByName('movb_natf_codigo').Asstring='1556') and
           (Q.fieldbyname('moes_natf_codigo').asstring<>QMovbase.FieldByName('movb_natf_codigo').Asstring) and
           (Q.fieldbyname('moes_vlrtotal').ascurrency>Q.fieldbyname('moes_totprod').ascurrency) and
           (Q.fieldbyname('moes_totprod').ascurrency>0)
           then begin  // 11.02.08 - tratamento para entradas que precisa desmembrar...
///////////
           totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,2);
           valoripi:=totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100);
// 21.03.07
           codigofiscal:=FSittributaria.CSttoCF(QMovbase.FieldByName('movb_cst').Asstring);
           isentas:=0;outras:=0;
           basecalculo:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
// 04.07.07
           if Q.FieldByName('move_tipomov').AsString=Global.CodCompraProdutor then
             basecalculo:=0;

           if pos( codigofiscal,'2;3' ) >0 then
             isentas:=basecalculo
           else if codigofiscal='5' then
             outras:=basecalculo
           else
             outras:=valoripi;
//////
///////////////
// 23.07.07 - 11.02.08
           valornota:=Q.fieldbyname('moes_vlrtotal').ascurrency-basecalculo;
           aliqicms:=QMovbase.FieldByName('movb_aliquota').Ascurrency;
           vlricms:=QMovbase.FieldByName('movb_imposto').Ascurrency;
           if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
              then begin    // entradas td em outras e valor contabil
              outras:=valornota;
              basecalculo:=0;
              isentas:=0;
              vlricms:=0;
              aliqicms:=0;
           end;
           cfop50:='1933';
/////////////////////
          linha:=GetFormato50( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 datanota+';'+Q.fieldbyname('moes_estado').asstring+';'+
                 GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                 Q.fieldbyname('moes_serie').asstring+';'+
                 Q.fieldbyname('moes_numerodoc').asstring+';'+
                 cfop50+';'+'P'+';'+    //P - o pr�prio estabelecimento emite  T - emitida por terceiros
//                 Q.FieldByName('moes_vlrtotal').Asstring+';'+
//                 Valortosql( QMovbase.FieldByName('movb_basecalculo').Ascurrency+valoripi )+';'+
// 23.07.07
                 Valortosql( valornota )+';'+
                 Valortosql( basecalculo )+';'+
                 Valortosql( vlricms )+';'+
                 Valortosql( isentas )+';'+
                 Valortosql( outras )+';'+
                 Valortosql( aliqicms )+';'+
                 situacaonota+';' );
          Lista50.Add( linha );
          Lista50Teste.Add( strzero(Q.fieldbyname('moes_numerodoc').asinteger,6)+';'+cfop50+';'+formatfloat( '######0.00',valornota ) );
          Lista50A.Add(copy(linha,1,2)+copy(linha,31,8)+'['+linha );
          ListaAliquotas.add( QMovbase.FieldByName('movb_aliquota').AsString );
          ListaBases.add( QMovbase.FieldByName('movb_basecalculo').AsString );

////////////
}
        end;
        QMovbase.next;
      end;
      fGeral.Fechaquery(QMovbase);

///////////////////

    contitem:=1;
    ListaDocumentoCst:=TList.create;

    while ( q.fieldbyname('move_transacao').asstring+q.fieldbyname('move_datamvto').asstring+q.fieldbyname('move_numerodoc').asstring=x ) and
        ( not Q.eof )
       do begin

//      Sistema.setmessage('Exportando movimento de entrada e saida - detalhe');
       if pos(Q.fieldbyname('moes_status').asstring,'X;Y;I')=0 then begin
          IncluiUnidadeEstoque(  Q.fieldbyname('esto_unidade').asstring,Q.fieldbyname('move_esto_codigo').asstring );
       end;
// 25.04.12
//      if AnsiPos( Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)>0 then begin
// 20.09.19 - Novicarnes Ketlen - notas com valor unitario com dizima...
      if AnsiPos( Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+
                  ';'+Global.CodCompraMatConsumo +
                  ';'+Global.CodEntradaProdutor )>0
       then begin
//        totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,4)
//        totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency,4)*FGeral.arredonda(Q.fieldbyname('move_venda').ascurrency,4)
//        totalitem:=Q.fieldbyname('move_qtde').ascurrency*FGeral.arredonda(Q.fieldbyname('move_venda').ascurrency,5)
        totalitemnfprodutor:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').asfloat;
//        totalitem:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency
// 30.07.20 - Ketlen - Novicarnes
        totalitem:=Q.fieldbyname('move_qtde').asfloat*Q.fieldbyname('move_venda').asfloat;

      end else

        totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,2);
// 03.04.19 - Novicarnes nota com acrescimo e reducao de base
//        totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,4);
//        totalitem:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency;

      baseicms:=totalitem;
// 27.06.07
//      if Q.fieldbyname('move_redubase').ascurrency>0 then
//        baseicms:=baseicms*(Q.fieldbyname('move_redubase').ascurrency/100) ;
// 04.07.07
      redubase:=FCodigosFiscais.GetAliquotaRedBase( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
      aliqicms:=Q.fieldbyname('move_aliicms').ascurrency;
// 11.12.09 - Novicarnes - Vanessa - notas feitas erradas sem redu�ao de base mas q nos itens
//            agora t� configurado como com reducao
      QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
                           ' and movb_status<>''C'''+
// 09.11.17
                           ' and movb_aliquota = '+ValorToSql(Q.FieldByName('move_aliicms').AsCurrency)+
                           ' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring));
      if not QMovBase.eof then begin
        redubasemestre:=QMovBase.fieldbyname('movb_reducaobc').ascurrency;
      end else
        redubasemestre:=0;
//////////////////////////
// aqui 03.04.19
///////////////
      if Q.fieldbyname('moes_peracres').ascurrency>0 then
//        vlracres:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_peracres').ascurrency/100),2)
// 03.04.19  - 18.06.19
        vlracres:= FGEral.Arredonda( totalitem / ( (100-Q.fieldbyname('moes_peracres').ascurrency)/100) ,5  )
                   - totalitem
      else
        vlracres:=0;
// 03.04.19
      baseicms := baseicms + vlracres;

//      if (redubase>0) then begin
      if (redubase>0) and (redubasemestre>0) then begin
//        baseicms:=(baseicms*(redubase/100));
// 03.04.19
        baseicms:=FGEral.Arredonda(baseicms*(redubase/100),2);
      end;

      if ( q.fieldbyname('move_cst').asstring=CstSubsTrib ) and
         ( ES='S' )   // 27.07.11 - caso digitar CSt errado na entrada...
         then
        baseicmsst:=( totalitem*(1+(Global.MargemSubsTrib/100)) )  // rever posteriormente se tiver mais de um % subst.
      else
        baseicmsst:=0;
//
      valoripiitem:=totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100);
// 20.04.14
      if pos( EdUnid_codigo.ResultFind.FieldByName('unid_simples').AsString,'S;2' )>0 then
         valoripiitem:=0;
//
      if (Q.fieldbyname('moes_perdesco').ascurrency>0) and
         (Q.FieldByName('moes_baseicms').AsCurrency=0) then begin // 22.07.11
         vlrdesco:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100),2);
// 22.07.11
         perdesco:=Q.fieldbyname('moes_perdesco').ascurrency;
// 09.11.17
      end else if (Q.FieldByName('moes_vlrtotal').AsCurrency<Q.FieldByName('moes_totprod').AsCurrency) and
                  ( Es = 'S' ) then begin
         vlrdesco:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100),2);
         perdesco:=Q.fieldbyname('moes_perdesco').ascurrency;

      end else begin
        vlrdesco:=0;
        perdesco:=0;
      end;
// 10.12.10 - no sintegra nao gerava...
///////////////
      valoricmsst:=Q.fieldbyname('moes_valoricmssutr').ascurrency;
      if Q.fieldbyname('moes_totprod').ascurrency>0 then
        rateioicmsst:=FGeral.arredonda(valoricmsst/Q.fieldbyname('moes_totprod').ascurrency,4)
      else if valornota>0 then
        rateioicmsst:=FGeral.arredonda(valoricmsst/valornota,4)
      else if Q.fieldbyname('moes_baseicms').ascurrency>0 then
        rateioicmsst:=FGeral.arredonda(valoricmsst/Q.fieldbyname('moes_baseicms').ascurrency,4)
      else
        rateioicmsst:=0;
      valoricmsstitem:=(totalitem-vlrdesco)*rateioicmsst;
// 12.04.14 - Abra Cuiaba
       rateiofrete:=0;
      if (vlrfrete>0) and (Q.fieldbyname('moes_totprod').ascurrency>0) then
        rateiofrete:=FGeral.arredonda(vlrfrete/Q.fieldbyname('moes_totprod').ascurrency,4);
      vlrfreteitem:=(totalitem-vlrdesco)*rateiofrete;

// 19.12.18 - Clessi - frete apenas para entrar no custo do produto porem nao somado na nota
      if (Es='E') and ( Q.FieldByName('moes_freteciffob').AsString='1' ) then
         vlrfreteitem:=0;

// 10.07.19 - Clessi - nao adiantou - tem q checar quando o frete nao faz parte do total da nota
//            mas � informado para efeito de custo
      if ( (Q.fieldbyname('moes_totprod').ascurrency+Q.fieldbyname('moes_valoripi').ascurrency+
          Q.fieldbyname('moes_valoricmssutr').ascurrency+vlrfrete) > Q.fieldbyname('moes_vlrtotal').ascurrency )
          and ( Es = 'E' )
          then begin
          vlrfreteitem:=0;
          rateiofrete:=0;
      end;

// 23.03.07
//     codigofiscal:=FSittributaria.CSttoCF(Qmovbase.FieldByName('movb_cst').Asstring);
//      if ( (outras>0) or (isentas>0) ) and (valoripi=0) then
      if ( Q.fieldbyname('move_aliicms').ascurrency=0 ) or (Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor) then
         baseicms:=0;
      if (Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor) then
         aliqicms:=0;
// 04.07.07 - notas 'elize'..
      if (baseicms>0) and (baseicms>totalitem) and (vlrdesco=0) then
        totalitem:=baseicms;
      if perdesco>0 then begin
        baseicms:=baseicms - ( baseicms*(perdesco/100) );
      end;

// 10.12.10 - aqui nao calculava valor do icms pois nao mandava pro sintegra reg. 54
      vlricms:=(baseicms*(aliqicms/100));
// 05.10.10 - Abra - PS - canceladas ou nao
       if (Q.FieldByName('moes_tipomov').asstring=Global.CodPrestacaoServicos)
         then begin
         valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
         baseicms:=0;
         vlricms:=0;
         aliqicms:=0;
       end;

      if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
          then begin    // entradas td em outras e valor contabil
          baseicms:=0;
          aliqicms:=0;  // 10.07.09
          vlricms:=0;
      end;
/////////////////////
// aqui em 23.10.07
//      cfop54:=cfop;
// 11.03.08
      cfop54:=cfop50;
      if listaaliquotas.count>0 then begin
        QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
                             ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring)+
//                             ' and movb_natf_codigo<>'+stringtosql(cfop) );
//                             ' and movb_natf_codigo<>'+stringtosql(cfop50) );
                             ' and movb_cst='+stringtosql(Q.fieldbyname('move_cst').asstring) );
// 11.03.08
//                             ' and movb_aliquota='+valortosql(aliqicms) );
        if not QMovbase.eof then begin
          if QMovbase.fieldbyname('movb_natf_codigo').asstring<>'' then
            cfop54:=copy(QMovbase.fieldbyname('movb_natf_codigo').asstring,1,4);
        end;
        FGeral.FechaQuery(QMovbase);
      end;
//  04.03.08
      xcst:=Q.fieldbyname('move_cst').asstring;
      if xcst='099' then xcst:='090';
// 09.12.09 - pra prevenir eventuais 'bostex' onde o move_cst fica sem preencher...
      if trim(xcst)='' then
        xcst:=FEstoque.Getsituacaotributaria(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring,
               Global.UFUnidade);
// 10.12.10
      xcst:=copy(xcst,1,3);

///
// 05.07.10 - 17.12.10 - sped fiscal
     if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'567')>0 ) then begin

//        SomanoRegistro( 'C320',xcst,cfop54,aliqicms,totalitem,baseicms,vlricms,baseicmsst,valoricmsstitem,totalitem-baseicms,totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100) );
// existem os  registros C300, C310, C320, C321, C350, C370, C390 que se referem a
// nota fiscal de venda consumidor ( modelo 02 ) s�rie D ....
//por enquanto feito somente o C300 e C320

      end else begin
// itens das notas
///////////////////
        if ( Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , ModelosRegistroC170 )  >0 )
           and ( pos(Q.fieldbyname('moes_status').asstring,'X;Y;I')=0 )
          then begin

           if (Q.fieldbyname('moes_tipomov').asstring=Global.CodDevolucaoVenda) and
               ( aliqicms=0 ) then
//             if ( pos( copy(xcst,2,3),'00;10;20;70' ) > 0 ) and then
               aliqicms:=FEstoque.Getaliquotaicms(Q.fieldbyname('move_esto_codigo').asstring,
                          Q.fieldbyname('move_unid_codigo').asstring,
                          Q.fieldbyname('moes_estado').asstring) ;

// 20.02.14 - rateado o IPI pelos itens nota
// 12.04.14 - deixado pela aliquota q tiver no produto senao nao fecha com o IPI total da nota
//           valoripiitem:=0;
//           if (Q.fieldbyname('move_aliipi').ascurrency=0) and (Q.fieldbyname('moes_valoripi').ascurrency>0) then
//               valoripiitem:=( (totalitem-vlrdesco)/(Q.fieldbyname('moes_totprod').Ascurrency) ) * Q.fieldbyname('moes_valoripi').ascurrency
//           else
               valoripiitem:=(totalitem-vlrdesco)*(Q.fieldbyname('move_aliipi').ascurrency/100);
// 20.04.14
           if pos( EdUnid_codigo.ResultFind.FieldByName('unid_simples').AsString,'S;2' )>0 then begin
             totalitem:=totalitem+valoripiitem;
             valoripiitem:=0;
             if (totalitem-vlrdesco)>0 then                                                     // 03.04.19
                  SomanoRegistroDoc( 'C190',xcst,cfop54,aliqicms,totalitem-vlrdesco+vlrfreteitem+vlracres,baseicms,vlricms,baseicmsst,valoricmsstitem,0,valoripiitem)
             else
                  SomanoRegistroDoc( 'C190',xcst,cfop54,aliqicms,totalitem+vlrfreteitem+vlracres,baseicms,vlricms,baseicmsst,valoricmsstitem,0,valoripiitem) ;

           end else begin

              if ( pos( copy(xcst,2,3),'20;70' ) > 0 ) and ( (totalitem-baseicms)>0 ) then
//                SomanoRegistroDoc( 'C190',xcst,cfop54,aliqicms,totalitem,baseicms,vlricms,baseicmsst,valoricmsstitem,totalitem-baseicms,valoripiitem)
// 09.11.17
                SomanoRegistroDoc( 'C190',xcst,cfop54,aliqicms,totalitem-vlrdesco+vlrfreteitem+vlracres,baseicms,vlricms,baseicmsst,valoricmsstitem,totalitem-baseicms,valoripiitem)
              else begin
                if (totalitem-vlrdesco)>0 then
                  SomanoRegistroDoc( 'C190',xcst,cfop54,aliqicms,totalitem+valoripiitem-vlrdesco+vlrfreteitem+vlracres,baseicms,vlricms,baseicmsst,valoricmsstitem,0,valoripiitem)
                else
                  SomanoRegistroDoc( 'C190',xcst,cfop54,aliqicms,totalitem+valoripiitem+vlrfreteitem+vlracres,baseicms,vlricms,baseicmsst,valoricmsstitem,0,valoripiitem) ;
              end;

          end;

//          if  GetModelo(Q.fieldbyname('moes_tipomov').asstring) <> ModeloNfe then begin
// 24.11.11 - gera se for NFe de Entrada OU se n�o for NFe
// 21.02.16 - gera se for NFe de Entrada E nao for emissao propria OU se n�o for NFe
// 31.10.16 - gera para NFe de saida caso tiver nas config. gerais
          if  ( pos(GetModelo(Q.fieldbyname('moes_tipomov').asstring),ModeloNfe+';'+ModelosnaoGeraItem+';'+ModeloNFCe)=0 )
          or  ( ( pos(copy(cfop54,1,1),'1;2;3')>0 ) and
               ( GetModelo(Q.fieldbyname('moes_tipomov').asstring) = ModeloNfe )
               and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodCompraProdutorMerenda)=0 )
               )
// 31.10.16 - para agilizar pra escritorios contabeis
          or  ( ( pos(copy(cfop54,1,1),'5;6;7')>0 ) and
               ( GetModelo(Q.fieldbyname('moes_tipomov').asstring) = ModeloNfe ) and
               ( Global.Topicos[1047] ) )

            then begin

           with AcbrSpedFiscal1.Bloco_C.RegistroC170New do begin

             NUM_ITEM:=strzero(contitem,3);
             COD_ITEM:=Q.fieldbyname('move_esto_codigo').asstring;
             DESCR_COMPL:='';
             QTD:=Q.fieldbyname('move_qtde').ascurrency;
//             UNID:=FEstoque.GetUnidade(Q.fieldbyname('move_esto_codigo').asstring);
             UNID:=GetCodigoUnidadeEstoque( Q.fieldbyname('esto_unidade').asstring );
//             if Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor then
// 27.11.18
//             if AnsiPos( Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)>0 then
// 29.09.19
             if AnsiPos( Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+
                        ';'+Global.CodCompraMatConsumo +
                        ';'+Global.CodEntradaProdutor)>0 then
               VL_ITEM:=totalitemnfprodutor
             else
               VL_ITEM:=totalitem;

             VL_DESC:=vlrdesco;
             IND_MOV:=mfsim;
             CST_ICMS:=xcst;
             CFOP:=cfop54;
//             COD_NAT:=FNatureza.GetDescricao(cfop54);
//  25.01.11 - nao entendi este cod_nat se � mesmo igual ao cfop
             COD_NAT:=cfop54;
             VL_BC_ICMS:=baseicms;
             ALIQ_ICMS:=aliqicms;
             VL_ICMS:=vlricms;
             VL_BC_ICMS_ST:=baseicmsst;
             if baseicmsst>0 then
               ALIQ_ST:=(valoricmsstitem/baseicmsst)*100;
             VL_ICMS_ST:=valoricmsstitem;
             IND_APUR:=iaMensal;
// criar campo no cadastro de classificacao de ipi;
// criar campo cadastro de unidades pra identifcar se � contribuiente do IPI
//           if EdUnid_codigo.resultfind.fieldbyname('unid_ipi').asstring='S' then
             CST_IPI:=FEstoque.GetCodigoCSTipi(Q.fieldbyname('move_esto_codigo').asstring,Es);
             if trim(CST_IPI)='' then begin
                if Es='E' then begin
                  if Q.fieldbyname('move_aliipi').ascurrency>0 then
                    CST_IPI:='00'
                  else
                    CST_IPI:='01';
                end else begin
                  if Q.fieldbyname('move_aliipi').ascurrency>0 then
                    CST_IPI:='50'
                  else
                    CST_IPI:='51';
                end;
             end;
// ver do que se trata e se precisa criar campo no cadastro de classif. do ipi
             COD_ENQ:='';
// 15.06.15 - Novicarnes
             if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
                 then  begin
                 VL_BC_IPI:=0;
                 ALIQ_IPI:=0;
             end else begin
               VL_BC_IPI:=totalitem;
               ALIQ_IPI:=Q.fieldbyname('move_aliipi').ascurrency;
             end;
// 20.02.14 - rateado o IPI pelos itens nota
// 12.04.14 - deixado pela aliquota q tiver no iem
//             if (Q.fieldbyname('move_aliipi').ascurrency=0) and (Q.fieldbyname('moes_valoripi').ascurrency>0) then
//               VL_IPI:=( totalitem/(Q.fieldbyname('moes_totprod').ascurrency) ) * Q.fieldbyname('moes_valoripi').ascurrency
//             else
               VL_IPI:=totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100);
// 18.06.15 - Novicarnes
             if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 ) then
               VL_ipi:=0;
// acumulador do registro ref. IPI - ver se aproveita a funcao ou cria outra
// 20.04.14
             if pos( EdUnid_codigo.ResultFind.FieldByName('unid_simples').AsString,'S;2' )>0 then begin
               totalitem:=totalitem+valoripiitem;
               valoripiitem:=0;
             end;

             SomanoRegistro( 'E510',CST_IPI,cfop54,aliqicms,totalitem,baseicms,vlricms,baseicmsst,valoricmsstitem,totalitem-baseicms,valoripiitem );

// ver como calcular estes valores..se � apenas aplicar as aliquotas
// que tem no cadastro
//             CST_PIS:=pisOutrasOperacoes;
// 07.02.18
//             CST_PIS:='49';
// 17.09.19 - novicarnes  - ketlen pegou erro
             CST_PIS:= CstPisToStr( GetCSTPIS( FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) ) );
//             CST_COFINS:=cofinsOutrasOperacoes;
// 07.02.18
//             CST_COFINS:='49';
// 17.09.19 - novicarnes  - ketlen pegou erro
             CST_COFINS := CstCofinsToStr( GetCSTCOFINS( FCodigosipi.GetCstCofins( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) ) );

             if Q.FieldByName('moes_numerodoc').AsInteger=2034 then begin

                Texto.Lines.Add( 'conta:'+Q.FieldByName('moes_plan_codigo').AsString );
                Texto.Lines.Add( 'cstpis:'+cst_pis );

             end;

             if Q.FieldByName('moes_plan_codigo').AsInteger  >0 then begin

                         if LIstaDespesasCST53.IndexOf( IntToStr( Q.FieldByName('moes_plan_codigo').AsInteger ) ) >=0  then begin

                           CST_PIS    := ( '53' );
                           CST_COFINS := ( '53' );

                         end else begin

                           if campo.Tipo<>'' then begin

                              cstpiscofins:=FPlano.GetCSTPisCofins( Q.FieldByName('moes_plan_codigo').AsInteger);

                              if Q.FieldByName('moes_numerodoc').AsInteger=2034 then

                                 Texto.Lines.Add( 'cstpiscofins:'+cstpiscofins );

                              if trim(cstpiscofins)<>'' then begin
                                CST_PIS    := ( cstpiscofins );
                                CST_COFINS := ( cstpiscofins );
                              end;
                           end;

                         end;

                     end;



             VL_BC_PIS:=0;
             ALIQ_PIS_PERC:=0;
             ALIQ_PIS_R:=0;
             QUANT_BC_PIS:=0;
             VL_PIS:=0;


             VL_BC_COFINS:=0;
             ALIQ_COFINS_PERC:=0;
             ALIQ_COFINS_R:=0;
             QUANT_BC_COFINS:=0;
             VL_COFINS:=0;
// checar se pode ser 'pego' atrav�s da config. de movimento...
//             COD_CTA:='000';
// 24.09.19
             COD_CTA:=GetCod_Cta(Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);

// 29.09.2021 - clessi
                if AnsiPos( 'APROVEITAMENTO DO CREDITO DE ICMS NO VALOR DE',
                            UpperCase( Q.fieldbyname('moes_xmlnfet').AsString ) ) > 0 then begin

                   New( PRegC197 );
                   PRegC197.COD_AJ :=  CODCREDITOCMSAJ;
                   PRegC197.DESCR_COMPL_AJ := '';
                   PRegC197.COD_ITEM := Q.fieldbyname('move_esto_codigo').AsString;
                   PRegC197.VL_BC_ICMS := roundvalor( Q.fieldbyname('move_venda').AsCurrency *
                                          Q.fieldbyname('move_qtde').AsCurrency );
                   PRegC197.ALIQ_ICMS := GetAliqIcmsRegc195( Q.fieldbyname('move_transacao').AsString );
                   PRegC197.VL_ICMS := 0;
                   PRegC197.VL_OUTROS := 0;
                   PRegC197.TRANSACAO := Q.fieldbyname('move_transacao').AsString;
                   ListaRegC197.add( PRegC197 );
                   if PRegC197.ALIQ_ICMS > 0 then begin

                       with AcbrSpedFiscal1.Bloco_C.RegistroC197New do begin

                           COD_AJ :=  CODCREDITOCMSAJ;
                           DESCR_COMPL_AJ := 'DOCUMENTO EMITIDO POR ME OU EPP OPTANTE PELO SIMPLES NACIONAL. PERMITE APROVEITAMENTO DE CREDITO DE ICMS  ART.23 LC 123/2006';
                           COD_ITEM := Q.fieldbyname('move_esto_codigo').AsString;
                           VL_BC_ICMS := roundvalor( Q.fieldbyname('move_venda').AsCurrency *
                                                  Q.fieldbyname('move_qtde').AsCurrency );
                           ALIQ_ICMS :=  PRegC197.ALIQ_ICMS;
                           VL_ICMS   := VL_BC_ICMS * (ALIQ_ICMS/100);
                           VL_OUTROS := 0;

                       end;

                    end;

                end;

           end;

           inc(contitem);
////////////////////////// - 08.03.16
          if Lista75aux.IndexOf(Q.fieldbyname('move_esto_codigo').asstring)=-1 then begin
            Lista75.Add(Q.fieldbyname('move_esto_codigo').asstring);
            Lista75aux.Add(Q.fieldbyname('move_esto_codigo').asstring);
          end;
          if ListaTodosCfops.IndexOf(cfop54)=-1 then
             ListaTodosCfops.Add(cfop54);
////////////////////
          end;
// 27.11.18 - armazena para registro 1400
          if ( AnsiPos( Q.FieldByName('moes_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor )> 0 )
             and
               ( EdInicio.AsDate >= TextToDate('01012019') )
             then begin

             codigoibge:=strtointdef( FCidades.GetCodigoIBGE( strtointdef(FCadCli.GetCodigoCidade(  Q.fieldbyname('moes_tipo_codigo').asinteger ),0) ),0 );
             xproduto := Q.fieldbyname('move_esto_codigo').asstring;
// 04.06.2021
             if Global.UFUnidade = 'PR' then

                   xproduto :='PREPPP01';

             if not TemnaLista1400(xproduto,
                                   codigoibge ,
                                   totalitemnfprodutor ) then begin

                New(PReg1400);
// 04.06.2021 - receita do PR agora tem 'codigos proprios'
                if Global.UFUnidade = 'PR' then

                   PReg1400.COD_ITEM_IPM:='PREPPP01'

                else
//
                  PReg1400.COD_ITEM_IPM:=Q.fieldbyname('move_esto_codigo').asstring;

                PReg1400.MUN         :=codigoibge;
                PReg1400.VALOR       :=totalitemnfprodutor;
                ListaReg1400.add( PReg1400 );

             end;

          end;

        end;  // C170

      end;  // serie D nao tem itens

{
// cfop de notas eletronicas nao inclui pois nao gera o registro C170
//      if  GetModelo(Q.fieldbyname('moes_tipomov').asstring) <> ModeloNfe then begin
// 24.11.11 - gera se for NFe de Entrada OU se n�o for NFe
       if ( ( pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring),ModeloNfe+';'+ModelosnaoGeraItem+';'+ModeloNFCe )=0 )
             and
            ( pos(Q.fieldbyname('moes_status').AsString,'X;Y;I')=0 ) )
          or  ( ( pos(copy(cfop54,1,1),'1;2;3')>0 ) and
               ( pos(GetModelo(Q.fieldbyname('moes_tipomov').asstring),ModeloNfe+';'+ModeloNfCe)>0 ) and
               ( pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModelosnaoGeraItem )=0 ) and
               ( pos(Q.fieldbyname('moes_status').AsString,'X;Y;I')=0 )
               )
         then begin
         if ListaTodosCfops.IndexOf(cfop54)=-1 then
           ListaTodosCfops.Add(cfop54);
      end;
}

{
// codigo de produto de notas eletronicas nao inclui pois nao gera o registro C170
//      if  GetModelo(Q.fieldbyname('moes_tipomov').asstring) <> ModeloNfe then begin
//      if ( pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModeloNfe+';'+ModelosnaoGeraItem )=0 ) and
// 24.11.11 - gera se for NFe de Entrada OU se n�o for NFe
       if ( ( pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring),ModeloNfe+';'+ModelosnaoGeraItem+';'+ModeloNfce )=0 )
             and
            ( pos(Q.fieldbyname('moes_status').AsString,'X;Y;I')=0 ) )
          or  ( ( pos(copy(cfop54,1,1),'1;2;3')>0 ) and
//               ( GetModelo(Q.fieldbyname('moes_tipomov').asstring) = ModeloNfe ) and
// 08.03.16
               ( GetModelo(Q.fieldbyname('moes_tipomov').asstring) = ModeloNfe ) and
               ( pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModelosnaoGeraItem )=0 ) and
               ( pos(Q.fieldbyname('moes_status').AsString,'X;Y;I')=0 )
               )
        then begin
        if Lista75aux.IndexOf(Q.fieldbyname('move_esto_codigo').asstring)=-1 then begin
          Lista75.Add(Q.fieldbyname('move_esto_codigo').asstring);
          Lista75aux.Add(Q.fieldbyname('move_esto_codigo').asstring);
        end;
      end;
}

      Q.Next;

    end;  // ref. detalhes

// aqui gerar o C190 pra cada documento resumo por cst, aliquota...e em seguida zerar
// a lista para o proximo documento
    for p:=0 to ListaDocumentoCst.Count-1 do begin
       PDocumentoCst:=ListaDocumentoCst[p];
           with AcbrSpedFiscal1.Bloco_C do begin
            with RegistroC190New do begin
              CST_ICMS:=PDocumentoCst.cst ;
              CFOP:=PDocumentoCst.cfop;
              ALIQ_ICMS:=PDocumentoCst.aliicms;
              VL_OPR:=PDocumentoCst.vl_opr;
              VL_BC_ICMS:=PDocumentoCst.vl_bc_icms;
              VL_ICMS:=PDocumentoCst.vl_icms;
// senao o validador d� advertencia para cst ?20,?70 // 23.02.11
              if PDocumentoCst.vl_red_bc>0 then
                VL_RED_BC:=PDocumentoCst.vl_red_bc;
              VL_BC_ICMS_ST:=PDocumentoCst.vl_bc_icms_st;
              VL_ICMS_ST:=PDocumentoCst.vl_icms_st;
              VL_IPI:=PDocumentoCst.vl_ipi;
              COD_OBS:='';
            end;
            AcumulaReg('E110',PDocumentoCst.cfop,PDocumentoCst.vl_icms);
           end;
    end;

    ListaDocumentoCst.Free;

{
    ACBrSPEDFiscal1.WriteBloco_0;
    ACBrSPEDFiscal1.WriteBloco_C(True);
    ACBrSPEDFiscal1.WriteBloco_D;
    ACBrSPEDFiscal1.WriteBloco_E;
    ACBrSPEDFiscal1.WriteBloco_G;
    ACBrSPEDFiscal1.WriteBloco_H;
    ACBrSPEDFiscal1.WriteBloco_1;
    ACBrSPEDFiscal1.WriteBloco_9;
}
// em savefiletxt ja faz 'os writeBlocos...'

    if QGeral<>nil then begin
      Qgeral.close;
      Freeandnil(QGeral);
    end;

  end; // ref. mestre

// gera os registros C190, D190 , C320 , E510 cfe foi acumulado no registro TTotalCst
// 04.01.2011
    for p:=0 to LIstaTotalCst.Count-1 do begin
          PTotalCst:=ListaTotalCst[p];
          if PTotalCst.registro='C320' then begin
           with AcbrSpedFiscal1.Bloco_C do begin
            with RegistroC320New do begin
              CST_ICMS:=PTotalCst.cst ;
              CFOP:=PTotalCst.cfop;
              ALIQ_ICMS:=PTotalCst.aliicms;
              VL_OPR:=PTotalCst.vl_opr;
              VL_BC_ICMS:=PTotalCst.vl_bc_icms;
              VL_ICMS:=PTotalCst.vl_icms;
              VL_RED_BC:=PTotalCst.vl_red_bc;
              COD_OBS:='';
            end;
            AcumulaReg('E110',PTotalCst.cfop,PTotalCst.vl_icms);
           end;
          end else if PTotalCst.registro='C190' then begin

          end else if PTotalCst.registro='D190' then begin

          end else if PTotalCst.registro='D590' then begin

          end else if PTotalCst.registro='E510' then begin
           with AcbrSpedFiscal1.Bloco_E do begin
            with RegistroE510New do begin
              CST_IPI:=PTotalCst.cst ;
              CFOP:=PTotalCst.cfop;
              VL_CONT_IPI:=PTotalCst.vl_opr;
              VL_BC_IPI:=PTotalCst.vl_opr;;
              VL_IPI:=PTotalCst.vl_ipi;
            end;
            AcumulaReg('E520',PTotalCst.cfop,PTotalCst.vl_ipi);
           end;

          end;
    end;
// gera os registros C190 , C320 , D190 , E510 cfe foi acumulado no registro TTotalCst
/////////////////
// 19.11.15 - geracao do(s) registro(s) C400  -ref. leitura Z ( delcio bixa - mirvane )
   QZ:=sqltoquery('select distinct mecf_data,* from movleituraecf where mecf_status=''N'''+
                 ' and mecf_tipo=''Z'''+
                 ' and mecf_data >= '+EdInicio.AsSql+
                 ' and mecf_data <= '+EdTermino.AsSql+
                 ' and '+FGeral.GetIN('mecf_unid_codigo',EdUNid_codigo.text,'C') );
   if not QZ.eof then begin
      with AcbrSpedFiscal1.Bloco_C.RegistroC400New do begin
         COD_MOD:=QZ.fieldbyname('Mecf_Modelo').asstring;
         ECF_MOD:='MB 4000';
         ECF_FAB:=QZ.fieldbyname('Mecf_NumeroSerie').asstring;
         ECF_CX:='001';
      end;
   end;
   contc420:=1;
   ListaData:=TStringList.create;
   while not QZ.eof do begin
     if (QZ.fieldbyname('Mecf_VendaBruta').ascurrency>0) and (ListaData.indexof(QZ.fieldbyname('Mecf_Data').asstring)=-1) then begin
        with AcbrSpedFiscal1.Bloco_C.RegistroC405New do begin
          DT_DOC:=QZ.fieldbyname('Mecf_Data').asdatetime;
          CRO   :=QZ.fieldbyname('Mecf_NumeroCRO').asinteger;
          CRZ   :=QZ.fieldbyname('Mecf_NumeroCRZ').asinteger;
          NUM_COO_FIN := QZ.fieldbyname('Mecf_NumeroCOOf').asinteger;
          GT_FIN:=QZ.fieldbyname('Mecf_TotalGeral').ascurrency;
          VL_BRT:=QZ.fieldbyname('Mecf_VendaBruta').ascurrency;
          ListaData.add(QZ.fieldbyname('Mecf_Data').asstring);
        end;
           ListaAliquotas:=TStringList.create;
           ListaAliquota:=TStringList.create;
           strtolista(ListaAliquotas,Qz.fieldbyname('Mecf_AliqsIcms').asstring,'|',true);
           for p:=0 to ListaAliquotas.Count-1 do begin
             strtolista(ListaAliquota,ListaAliquotas[p],';',true);
             if ListaAliquota.Count>0 then begin
               if (trim(ListaAliquota[0])<>'') and (trim(ListaAliquota[0])<>'S') then begin
    // aliquota de icms > 0
                 if (ListaAliquota.Count=3)  then begin
                   with AcbrSpedFiscal1.Bloco_C.RegistroC420New do begin
                     COD_TOT_PAR := 'T'+ListaAliquota[1];
                     VLR_ACUM_TOT:=TextToValor(ListaAliquota[2]);
                     NR_TOT      :=01;
//                   DESCR_NR_TOT:=
                  end;
{
                   linha:=GetFormato60( Q.fieldbyname('Mecf_usua_codigo').asstring+';'+
                         'nada'+';'+
                         Q.fieldbyname('Mecf_Data').asstring+';'+
                         Q.fieldbyname('Mecf_NumeroSerie').asstring+';'+
                         ListaAliquota[1]+';'+
                         Valortosql( TextToValor(ListaAliquota[2]) )+';' ,
                         'A' );
                         }
    // F - subst.   I - Isento  - N - diferido
                 end else begin
{
                   if (valorvendas>0) then
                     linha:=GetFormato60( Q.fieldbyname('Mecf_usua_codigo').asstring+';'+
                         'nada'+';'+
                         Q.fieldbyname('Mecf_Data').asstring+';'+
                         Q.fieldbyname('Mecf_NumeroSerie').asstring+';'+
                         ListaAliquota[0]+';'+
                         Valortosql( valorvendas )+';' ,
                         'A' )
}
                   if TextToValor(ListaAliquota[1]) > 0  then begin
                      with AcbrSpedFiscal1.Bloco_C.RegistroC420New do begin
                        if ListaAliquota[0]='CANC' then
                          COD_TOT_PAR := 'Can-T'
                        else
//                          COD_TOT_PAR := ListaAliquota[0]+inttostr(contc420);
                          COD_TOT_PAR := ListaAliquota[0]+inttostr(p);
                        VLR_ACUM_TOT:=TextToValor(ListaAliquota[1]);
//                        NR_TOT      :=contc420;
                        inc(contc420);
  //                    DESCR_NR_TOT:=
                     end;
                   end;

                 end;
               end;
             end;
           end;
           QZDoc:=sqltoquery('select moes_numerodoc,moes_vlrtotal,moes_transacao,moes_natf_codigo from movesto'+
                ' where '+FGeral.Getin('moes_status','N;X;E;D;Y;I','C')+
                ' and moes_datamvto='+Datetosql(QZ.fieldbyname('Mecf_Data').asdatetime)+
                ' and '+FGeral.GetIN('moes_especie','CF;CF ;','C')+
                ' and '+FGeral.GetNOTIN('moes_tipomov',tiposnao+';'+Global.CodConhecimento+';'+global.CodConhecimentoSaida,'C')+
                ' and moes_datacont is not null'+
                sqlunidades+
                ' and moes_natf_codigo is not null'+
                ' order by moes_transacao,moes_datamvto,moes_numerodoc' );
           while not QzDoc.eof do begin
             with AcbrSpedFiscal1.Bloco_C.RegistroC460New do begin
                COD_MOD :=QZ.fieldbyname('Mecf_Modelo').asstring ;
                COD_SIT :=sdRegular;
                NUM_DOC :=QZDoc.fieldbyname('Moes_Numerodoc').asstring;
                DT_DOC  :=QZ.fieldbyname('Mecf_Data').asdatetime;
                VL_DOC  :=QZDoc.fieldbyname('Moes_vlrtotal').ascurrency;
             end;
             QZDocItens:=sqltoquery('select move_numerodoc,move_qtde,move_venda,move_unid_codigo,move_aliicms,move_esto_codigo,esto_unidade,move_cst from movestoque'+
                ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                ' inner join estoque on ( move_esto_codigo=esto_codigo )'+
                ' where '+FGeral.Getin('move_status','N;X;E;D;Y;I','C')+
                ' and move_transacao='+Stringtosql(QZDoc.fieldbyname('Moes_transacao').asstring)+
                ' and move_datacont is not null'+
                sqlunidadesdet+
                ' order by move_transacao,move_datamvto,move_numerodoc' );
             ListaDocumentoCst:=TList.create;
             while not QZDocItens.eof do begin
               totalitem:=QZDocItens.fieldbyname('move_qtde').ascurrency*QZDocItens.fieldbyname('move_venda').ascurrency;
               IF TOTALITEM>0 THEN BEGIN
               with AcbrSpedFiscal1.Bloco_C.RegistroC470New do begin
                 COD_ITEM:=QZDocItens.fieldbyname('move_esto_codigo').asstring;
                 QTD:=QZDocItens.fieldbyname('move_qtde').ascurrency;
                 IncluiUnidadeEstoque(  QZDocItens.fieldbyname('esto_unidade').asstring,QZDocItens.fieldbyname('move_esto_codigo').asstring );
                 UNID:=GetCodigoUnidadeEstoque( QZDocItens.fieldbyname('esto_unidade').asstring );
                 totalitemnfprodutor:=QZDocItens.fieldbyname('move_qtde').ascurrency*QZDocItens.fieldbyname('move_venda').asfloat;
                  xcst:=QZDocItens.fieldbyname('move_cst').asstring;
                  if xcst='099' then xcst:='090';
                  if trim(xcst)='' then
                    xcst:=FEstoque.Getsituacaotributaria(QZDocItens.fieldbyname('move_esto_codigo').asstring,QZDocItens.fieldbyname('move_unid_codigo').asstring,
                           Global.UFUnidade);
                  xcst:=copy(xcst,1,3);
                 if Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor then
                   VL_ITEM:=totalitemnfprodutor
                 else
                   VL_ITEM:=totalitem;
                 CST_ICMS:=xcst;
                 CFOP    :=QzDoc.fieldbyname('moes_natf_codigo').asstring;
                 ALIQ_ICMS:=QzDocItens.fieldbyname('move_aliicms').ascurrency;
                 aliicms:=QzDocItens.fieldbyname('move_aliicms').ascurrency;
                 baseicms:=totalitem;
                 vlricms:=roundvalor(baseicms*(aliicms/100));
               end;
               if pos( EdUnid_codigo.ResultFind.FieldByName('unid_simples').AsString,'S;2' )>0 then begin
                 SomanoRegistroDoc( 'C490',xcst,QZDoc.fieldbyname('Moes_natf_codigo').asstring,aliqicms,totalitem,baseicms,vlricms,0,0,0,0)
               end else
                 SomanoRegistroDoc( 'C490',xcst,QZDoc.fieldbyname('Moes_natf_codigo').asstring,aliqicms,totalitem,baseicms,vlricms,0,0,0,0);

               if Lista75aux.IndexOf(QZdocitens.fieldbyname('move_esto_codigo').asstring)=-1 then begin
                  Lista75.Add(QZdocitens.fieldbyname('move_esto_codigo').asstring);
                  Lista75aux.Add(QZdocitens.fieldbyname('move_esto_codigo').asstring);
               end;
               END;
               QzDocItens.Next;
             end;
             FGeral.Fechaquery(QzDocItens);
             QzDoc.Next;
           end;
           FGeral.Fechaquery(QZDoc);
// aqui gerar o C490 pra cada documento resumo por cst, aliquota...e em seguida zerar
// a lista para o proximo documento
            for p:=0 to ListaDocumentoCst.Count-1 do begin
               PDocumentoCst:=ListaDocumentoCst[p];
                  with AcbrSpedFiscal1.Bloco_C do begin
                    with RegistroC490New do begin
                      CST_ICMS:=PDocumentoCst.cst ;
                      CFOP:=PDocumentoCst.cfop;
                      ALIQ_ICMS:=PDocumentoCst.aliicms;
                      VL_OPR:=PDocumentoCst.vl_opr;
                      VL_BC_ICMS:=PDocumentoCst.vl_bc_icms;
                      VL_ICMS:=PDocumentoCst.vl_icms;
                      COD_OBS:='';
                    end;
                  end;
            end;
            ListaDocumentoCst.Free;

     end;  // venda bruta > 0
     QZ.Next;
   end; // while
   FGeral.Fechaquery(QZ);
   ListaData.free;

////////////////////////////////

    codmuniemitente:=FCidades.GetCodigoIBGE(EdUNid_codigo.resultfind.fieldbyname('unid_cida_codigo').asinteger);
    regsbloco0:=0;

    with AcbrSpedFiscal1.Bloco_0 do begin
       LimpaRegistros;
// dados da empresa
///////////////////////////////////////////////////////////////////////
       with Registro0000New do begin
// 03.02.2021
         if EdInicio.AsDate>=StrToDate('01/01/2021') then
           COD_VER:=vlVersao114
// 30.01.20
         else if EdInicio.AsDate>=StrToDate('01/01/2020') then
           COD_VER:=vlVersao113
// 07.02.18
         else if EdInicio.AsDate>=StrToDate('01/01/2019') then
           COD_VER:=vlVersao112
         else if EdInicio.AsDate>=StrToDate('01/01/2018') then
           COD_VER:=vlVersao111
         else if EdInicio.AsDate>=StrToDate('01/01/2017') then
           COD_VER:=vlVersao110
         else if EdInicio.AsDate>=StrToDate('01/01/2016') then
           COD_VER:=vlVersao109
         else if EdInicio.AsDate>=StrToDate('01/01/2015') then
           COD_VER:=vlVersao108
         else if EdInicio.AsDate>=StrToDate('01/01/2014') then
           COD_VER:=vlVersao107      // 01.01.14
         else if EdInicio.AsDate>=StrToDate('25/02/2013') then
           COD_VER:=vlVersao106    // 25.02.13
         else
           COD_VER:=vlVersao105;    // 01.07.2012

//         COD_VER:=vlVersao106;    // 25.02.13
//         COD_VER:=vlVersao105;    // 01.07.2012
//         COD_VER:=vlVersao104;   // 01.01.2012
//         COD_VER:=vlVersao103;   // 01.01.2011
//         COD_VER:=vlVersao102;   // 01.01.2010
//         COD_VER:=vlVersao101;
         COD_FIN:=raOriginal;
// 31.08.11
         if EdFinalidade.text='1' then
           COD_FIN:=raSubstituto;
         DT_INI:=EdInicio.AsDate;
         DT_FIN:=EdTermino.AsDate;
         NOME:=EdUnid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring;
         CNPJ:=EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring;
//         CPF:=
         UF:=EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring;
         IE:=TiraSintegra(EdUnid_codigo.resultfind.fieldbyname('unid_inscricaoestadual').asstring);
         COD_MUN:=strtointdef(codmuniemitente,0);
         IM:=TiraSintegra(EdUnid_codigo.resultfind.fieldbyname('unid_inscricaomunicipal').asstring);
         IND_PERFIL:=pfPerfilA;  // A-detalhado  B-sintetico
         if pos( 'LAMINADORA',Uppercase(EdUnid_codigo.resultfind.fieldbyname('Unid_atividade').asstring)) > 0 then
           IND_PERFIL:=pfPerfilB;  // A-detalhado  B-sintetico
         IND_ATIV:=atIndustrial;
       end;
       with Registro0001New do begin
         IND_MOV:=imComDados;
       end;
// 31.01.20
       with Registro0002New do begin
         CLAS_ESTAB_IND:='02';  // montagem
         if Ansipos( 'LAMINADORA',Uppercase(EdUnid_codigo.resultfind.fieldbyname('Unid_atividade').asstring)) > 0 then
            CLAS_ESTAB_IND:='00'  // tranformacao
         else if Ansipos( 'COOPERATIVA',Uppercase(EdUnid_codigo.resultfind.fieldbyname('Unid_atividade').asstring)) > 0 then
            CLAS_ESTAB_IND:='00';  //
         end;

// complemento dos dados da empresa
///////////////////////////////////////////////////////////////////////
       with Registro0005New do begin
         FANTASIA:=EdUnid_codigo.resultfind.fieldbyname('unid_nome').asstring;
         CEP:=EdUnid_codigo.resultfind.fieldbyname('unid_cep').asstring;
         ENDERECO:=EdUnid_codigo.resultfind.fieldbyname('unid_endereco').asstring;
         NUM:=GetNumerodoEndereco(EdUnid_codigo.resultfind.fieldbyname('unid_endereco').asstring);
         BAIRRO:=EdUnid_codigo.resultfind.fieldbyname('unid_bairro').asstring;
         FONE:=Fgeral.tirabarra(EdUnid_codigo.resultfind.fieldbyname('unid_fone').asstring,' ');
         FAX:=Fgeral.tirabarra(EdUnid_codigo.resultfind.fieldbyname('unid_fax').asstring,' ');
         EMAIL:=EdUnid_codigo.resultfind.fieldbyname('unid_email').asstring;
       end;
// dados do contabilista
///////////////////////////////////////////////////////////////////////
       with Registro0100New do begin
         NOME:=EdUnid_codigo.resultfind.fieldbyname('unid_contador').asstring;
         CPF:=EdUnid_codigo.resultfind.fieldbyname('unid_cpfcontador').asstring;
         CRC:=EdUnid_codigo.resultfind.fieldbyname('unid_crccontador').asstring;
// 29.10.10 - ver criar estes campos no cadastro de unidades se necessario..
         CNPJ:='';
         CEP:='';
         ENDERECO:='';
         NUM:='';
         BAIRRO:='';
         FONE:='';
         FAX:='';
// 17.02.14
         EMAIL:=FGeral.getconfig1asstring('Emailcontador');
         COD_MUN:=strtointdef(codmuniemitente,0); // deixado igual da unidade
       end;
// 'Participantes' : clientes , fornecedores e transportadores com movimento no periodo
///////////////////////////////////////////////////////////////////////
       codigopais:='1058';
       for p:=0 to ListaParticipantes.count-1 do begin
         with Registro0150New do begin
           PParticipa:=ListaParticipantes[p];
           PesquisaEntidade(PParticipa.tipocad,PParticipa.codigosac);
           COD_PART:=inttostr(PParticipa.codigo);
           if PParticipa.tipocad='C' then begin
             NOME:=trim(QGeral.fieldbyname('clie_razaosocial').asstring);
             COD_PAIS:=codigopais;
             if (QGeral.fieldbyname('clie_uf').asstring)='EX' then begin
//                if Q.fieldbyname('moes_tipocad').AsString='F' then begin
//                  Dest.EnderDest.cPais:=strtointdef(FCidades.GetCodigoPais(QDesti.fieldbyname('Forn_cida_codigo').asinteger),0);
//                  Dest.EnderDest.xPais:=Ups(FCidades.GetNomePais(QDesti.fieldbyname('Forn_cida_codigo').asinteger));
//                end else begin
                  COD_PAIS:=FCidades.GetCodigoPais(QGeral.fieldbyname('clie_cida_codigo_res').asinteger);
//                end;
             end else begin
               if QGeral.fieldbyname('clie_tipo').asstring='J' then begin
                CNPJ:=QGeral.fieldbyname('clie_cnpjcpf').asstring;
                if (Uppercase(QGeral.fieldbyname('clie_rgie').asstring)<>'ISENTO') and (Uppercase(QGeral.fieldbyname('clie_rgie').asstring)<>'ISENTA') then
                  IE:=TiraSintegra(QGeral.fieldbyname('clie_rgie').asstring);
               end else
                 CPF:=QGeral.fieldbyname('clie_cnpjcpf').asstring;
             end;
             COD_MUN:=strtointdef(FCidades.GetCodigoIBGE(QGeral.fieldbyname('clie_cida_codigo_res').asinteger) ,0);
             ENDERECO:=QGeral.fieldbyname('clie_endres').asstring;
             numero:=GetNumerodoEndereco(QGeral.fieldbyname('clie_endres').asstring,QGeral.fieldbyname('clie_codigo').AsInteger,'N');
             NUM:=numero;
             COMPL:=QGeral.fieldbyname('Clie_endrescompl').asstring;
             BAIRRO:=QGeral.fieldbyname('clie_bairrores').asstring;
           end else if PParticipa.tipocad='T' then begin
             NOME:=trim(Arq.TTransp.fieldbyname('tran_razaosocial').asstring);
             COD_PAIS:=codigopais;
             if FTransp.GetUF(Arq.TTransp.fieldbyname('tran_codigo').asinteger)='EX' then begin
                  COD_PAIS:=FCidades.GetCodigoPais(Arq.TTransp.fieldbyname('tran_cida_codigo').asinteger);
             end;
             if length( trim(Arq.TTransp.fieldbyname('tran_cnpjcpf').asstring) )=14 then
               CNPJ:=Arq.TTransp.fieldbyname('tran_cnpjcpf').asstring
             else
               CPF:=Arq.TTransp.fieldbyname('tran_cnpjcpf').asstring;
             IE:=TiraSintegra( Arq.TTransp.fieldbyname('tran_inscricaoestadual').asstring );
             COD_MUN:=strtointdef(FCidades.GetCodigoIBGE(Arq.TTransp.fieldbyname('tran_cida_codigo').asinteger) ,0);
             ENDERECO:=Arq.TTransp.fieldbyname('tran_endereco').asstring;
             numero:=GetNumerodoEndereco(Arq.TTransp.fieldbyname('tran_endereco').asstring,Arq.TTransp.fieldbyname('tran_codigo').AsInteger,'N');
             NUM:=numero;
             COMPL:='';
             BAIRRO:=Arq.TTransp.fieldbyname('tran_bairro').asstring;
// 21.05.12 - clessi
           end else if PParticipa.tipocad='U' then begin

               NOME:=trim(Ups(Arq.TUnidades.fieldbyname('unid_razaosocial').asstring));
               COD_PAIS:=codigopais;
               if Arq.TUnidades.fieldbyname('unid_uf').asstring='EX' then begin
                    COD_PAIS:=FCidades.GetCodigoPais(Arq.TUnidades.fieldbyname('unid_cida_codigo').asinteger);
               end;
               if length( trim(Arq.TUnidades.fieldbyname('unid_cnpj').asstring) )=14 then
                 CNPJ:=Arq.TUnidades.fieldbyname('unid_cnpj').asstring
               else
                 CPF:=Arq.TUnidades.fieldbyname('unid_cnpj').asstring;
               IE:=TiraSintegra( Arq.TUnidades.fieldbyname('unid_inscricaoestadual').asstring );
               COD_MUN:=strtointdef( FCidades.GetCodigoIBGE(Arq.TUnidades.fieldbyname('unid_cida_codigo').asinteger),7 ) ;
               ENDERECO:=Arq.TUnidades.fieldbyname('unid_endereco').asstring;
               numero:=GetNumerodoEndereco(Arq.TUnidades.fieldbyname('unid_endereco').asstring,Arq.TUnidades.fieldbyname('unid_codigo').AsInteger,'N');
               NUM:=numero;
               COMPL:='';
               BAIRRO:=Arq.TUnidades.fieldbyname('unid_bairro').asstring;

           end else begin  // por enquanto somente fornecedores

             NOME:=trim(QGeral.fieldbyname('forn_razaosocial').asstring);
             COD_PAIS:=codigopais;
             if (QGeral.fieldbyname('forn_uf').asstring)='EX' then begin
//                if Q.fieldbyname('moes_tipocad').AsString='F' then begin
//                  Dest.EnderDest.cPais:=strtointdef(FCidades.GetCodigoPais(QDesti.fieldbyname('Forn_cida_codigo').asinteger),0);
//                  Dest.EnderDest.xPais:=Ups(FCidades.GetNomePais(QDesti.fieldbyname('Forn_cida_codigo').asinteger));
//                end else begin
                  COD_PAIS:=FCidades.GetCodigoPais(QGeral.fieldbyname('forn_cida_codigo').asinteger);
//                end;
             end;
             if length( trim(QGeral.fieldbyname('forn_cnpjcpf').asstring) )=14 then
               CNPJ:=QGeral.fieldbyname('forn_cnpjcpf').asstring
             else
               CPF:=QGeral.fieldbyname('forn_cnpjcpf').asstring;
             IE:=TiraSintegra( QGeral.fieldbyname('forn_inscricaoestadual').asstring );
             COD_MUN:=strtointdef(FCidades.GetCodigoIBGE(QGeral.fieldbyname('forn_cida_codigo').asinteger) ,0);
             ENDERECO:=QGeral.fieldbyname('forn_endereco').asstring;
             numero:=GetNumerodoEndereco(QGeral.fieldbyname('forn_endereco').asstring,QGeral.fieldbyname('forn_codigo').AsInteger,'N');
             NUM:=numero;
             COMPL:='';
             BAIRRO:=QGeral.fieldbyname('forn_bairro').asstring;
           end;
         end;  // participantes
       end;
// Codigos de Unidade de Estoque
///////////////////////////////////////////////////////////////////////
{
       for p:=0 to ListaUnidades.count-1 do begin
// 17.02.14 - Abra cuiaba
         incluiunid:='N';
         PUnidades:=ListaUnidades[p];
         for r:=0 to Lista75.count-1 do begin
           if PUnidades.descricao=FEstoque.GetUnidade( Lista75[r] ) then begin
             incluiunid:='S';
             break;
           end;
         end;
         if incluiunid='S' then begin
           with Registro0190New do begin
//             PUnidades:=ListaUnidades[p];
             UNID:=strzero(PUnidades.codigo,6);
             DESCR:=PUnidades.descricao;
           end;
         end;
       end;
       }



////////////////////////////////////////
//Abertura Bloco H - 14.03.13
////////////////////////////////////
// 14.06.18
//      if  EdUnid_codigo.ResultFind.FieldByName('Unid_identatividade').AsString='02' then
//        EdMesano.Text:=FormatDatetime('mmyyyy',EdTermino.AsDate);

// 12.02.20 - Seip Brasil
       sqlgruposNao:='';
       if trim(FGeral.getconfig1asstring('GRUPOSNAOINV')) <> ''  then
          sqlgruposNao:=' and '+FGeral.GetNOTIN('esto_grup_codigo',FGeral.getconfig1asstring('GRUPOSNAOINV'),'N');

      if ( not EdMesano.isempty ) then begin

        QInventario:=Sqltoquery('select * from salestoque inner join estoque on (esto_codigo=saes_esto_codigo)'+
              ' where saes_status=''N'''+
//              ' and '+FGeral.GetIN('saes_esto_codigo',codigosprodutos,'C')+
              ' and saes_unid_codigo='+EdUnid_codigo.AsSql+
              ' and saes_mesano='+stringtosql(FGeral.AnoMesinvertido(EdMesano.text))+
              sqlgruposNao+
              ' and saes_qtde>0'+
              ' order by saes_esto_codigo' );
        if QInventario.Eof then
          Avisoerro('N�o encontrado invent�rio ref. '+EdMesano.text+' OU todos os itens zerados.  Bloco H n�o gerado');

      end;

      with AcbrSpedFiscal1.Bloco_H do begin

        with RegistroH001New do begin

          if not EdMesano.IsEmpty then begin
            if QInventario.eof then
              IND_MOV:=imSemDados
            else
              IND_MOV:=imComDados;
          end else
              IND_MOV:=imSemDados;

        end;
        totalinventario:=0;

        if not EdMesano.IsEmpty then begin

          while not QInventario.eof do begin

            totalitem:=QInventario.fieldbyname('saes_qtde').ascurrency*QInventario.fieldbyname('saes_customedio').ascurrency;
            totalinventario:=totalinventario+totalitem;
            QInventario.Next;

          end;

          with RegistroH005New do begin
              DT_INV:=DateToUltimoDiaMes(TextToDate('01'+EdMesano.text));
              VL_INV:=totalinventario;
              MOT_INV:=miFinalPeriodo;
          end;
          QInventario.First;

          while not QInventario.eof do begin

              with RegistroH010New do begin
                COD_ITEM:=QInventario.fieldbyname('saes_esto_codigo').asstring;
                IncluiUnidadeEstoque(  QInventario.fieldbyname('esto_unidade').asstring,QInventario.fieldbyname('esto_codigo').asstring );
                UNID:=GetCodigoUnidadeEstoque( QInventario.fieldbyname('esto_unidade').asstring );
                QTD:=QInventario.fieldbyname('saes_qtde').ascurrency;
                VL_UNIT:=QInventario.fieldbyname('saes_customedio').ascurrency;
                totalitem:=QInventario.fieldbyname('saes_qtde').ascurrency*QInventario.fieldbyname('saes_customedio').ascurrency;
                VL_ITEM:=totalitem;
                IND_PROP:=piInformante;
  //              COD_PART:=  // so informa e o estoque nao for 'do proprio
  //              TXT_COMPL:=
                COD_CTA:=EdUnid_codigo.resultfind.fieldbyname('unid_compras').asstring;
//                totalinventario:=totalinventario+totalitem;
              end;

            if Lista75aux.IndexOf(QInventario.fieldbyname('saes_esto_codigo').asstring)=-1 then begin
              Lista75.Add(QInventario.fieldbyname('saes_esto_codigo').asstring);
              Lista75aux.Add(QInventario.fieldbyname('saes_esto_codigo').asstring);
            end;

            QInventario.Next;
          end;
          QInventario.Close;

        end;  // mes ano empty

      end;  // with bloco H

// 14.06.18
          if ( EdUnid_codigo.ResultFind.FieldByName('Unid_identatividade').AsString='02' )
//              and  ( not QAcabado.Eof )
             then begin

// 23.01.19
             EdMesano.Text:=FormatDatetime('mmyyyy',EdTermino.AsDate);
             QInventario:=Sqltoquery('select * from salestoque inner join estoque on (esto_codigo=saes_esto_codigo)'+
              ' where saes_status=''N'''+
//              ' and '+FGeral.GetIN('saes_esto_codigo',codigosprodutos,'C')+
              ' and saes_unid_codigo='+EdUnid_codigo.AsSql+
              ' and saes_mesano='+stringtosql(FGeral.AnoMesinvertido(EdMesano.text))+
              ' and saes_qtde>0'+
              ' order by saes_esto_codigo' );

             if QInventario.Eof then
                Avisoerro('N�o encontrado invent�rio ref. '+EdMesano.text+' OU todos os itens zerados.  Bloco K n�o gerado');
/////////////////////////////////////////
///  Abertura Bloco K  - 16.06.18
////////////////////////////////////////
              if  EdUnid_codigo.ResultFind.FieldByName('Unid_identatividade').AsString='02' then begin

                  campos:='move_datamvto,move_esto_codigo,move_qtde,move_numerodoc';
                  QAcabado   :=sqltoquery('select '+campos+' from movestoque'+
                //                ' inner join movesto on ( move_transacao=moes_transacao and move_tipomov=moes_tipomov )'+
                                ' where move_datamvto>= '+EdInicio.AsSql+
                                ' and move_datamvto <= '+Edtermino.AsSql+
                                ' and move_tipomov = '+Stringtosql(Global.CodOrdemdeServico)+
                                ' and move_status <> ''C'''+
                                ' and move_unid_codigo = '+EdUNid_codigo.AsSql+
                                ' order by move_datamvto' );

                  with AcbrSpedFiscal1.Bloco_K.RegistroK001New do begin

                       if QInventario.Eof then
                         IND_MOV  := imSemDados
                       else begin
                         IND_MOV  := imComDados;
                         with AcbrSpedFiscal1.Bloco_K.RegistroK100New do begin
                              DT_INI  :=Edinicio.AsDate;
                              DT_FIN  :=Edtermino.AsDate;
                         end;
                       end;
                  end;

              end;
//////////////////////////////////////////


             while not QInventario.eof do begin

               with AcbrSpedFiscal1.Bloco_K.RegistroK200New do begin

                 DT_EST   := EdTermino.AsDate;
                 COD_ITEM := QInventario.fieldbyname('saes_esto_codigo').asstring;
                 QTD      := QInventario.fieldbyname('saes_qtde').ascurrency;
                 IND_EST  := estPropInformantePoder;

               end;

               if Lista75aux.IndexOf(QInventario.fieldbyname('saes_esto_codigo').asstring)=-1 then begin
                 Lista75.Add(QInventario.fieldbyname('saes_esto_codigo').asstring);
                 Lista75aux.Add(QInventario.fieldbyname('saes_esto_codigo').asstring);
               end;

               QInventario.Next;

             end;

             QINventario.close;

          end;  //   '02' e not acabado.eof



// Codigos de Unidade de Estoque aqui em 12.03.15 pois nao incluia unidade de itens q so tem no invenario
///////////////////////////////////////////////////////////////////////
       for p:=0 to ListaUnidades.count-1 do begin
// 17.02.14 - Abra cuiaba
         incluiunid:='N';
         PUnidades:=ListaUnidades[p];
         for r:=0 to Lista75.count-1 do begin
           if PUnidades.descricao=FEstoque.GetUnidade( Lista75[r] ) then begin
             incluiunid:='S';
             break;
           end;
         end;

         if incluiunid='S' then begin
           with Registro0190New do begin
             UNID:=strzero(PUnidades.codigo,6);
             DESCR:=PUnidades.descricao;
           end;
         end;
       end;
////////////////////////////////////////

// 15.06.18 - bloco K registro k230 - produtos acabados e/ou em processo
       if  (EdUnid_codigo.ResultFind.FieldByName('Unid_identatividade').AsString='02' ) and
           ( not QAcabado.Eof )
          then begin

           while not QAcabado.Eof do begin

             with AcbrSpedFiscal1.Bloco_K.RegistroK230New do begin

//              codigosdeinsumos:=FComposicao.GetCodigosMat(QAcabado.FieldByName('move_esto_codigo').AsString);
              codigosdeinsumos:='';
// 09.03.19 - pegar somente se tiver composi��o cadastrada
// 30.01.20 - pegar o q tiver sido lan�ado ou importado na requisi��o como saida do almox..
//              if trim(codigosdeinsumos)<>'' then begin

                 DT_INI_OP   :=  QAcabado.FieldByName('move_datamvto').AsDateTime;
  //               DT_INI_OP   :=  EdInicio.AsDate;
                 DT_FIN_OP   :=  QAcabado.FieldByName('move_datamvto').AsDateTime;
  //               DT_FIN_OP   :=  EdTermino.AsDate;
                 COD_DOC_OP  :=  QAcabado.FieldByName('move_numerodoc').Asstring;
                 COD_ITEM    :=  QAcabado.FieldByName('move_esto_codigo').Asstring;
                 QTD_ENC     :=  QAcabado.FieldByName('move_qtde').AsCurrency;

                 QInsumos :=sqltoquery('select '+campos+' from movestoque'+
                        ' inner join movesto on ( move_transacao=moes_transacao and move_tipomov=moes_tipomov )'+
//                        ' where move_datamvto>= '+Datetosql(QAcabado.FieldByName('move_datamvto').AsDateTime)+
//                        ' and move_datamvto <= '+Datetosql(QAcabado.FieldByName('move_datamvto').AsDateTime)+
                        ' where move_datamvto>= '+EdInicio.assql+
                        ' and move_datamvto <= '+EdTermino.assql+
                        ' and move_tipomov = '+Stringtosql(Global.CodSaidaAlmox)+
//                        ' and '+FGeral.GetIN('move_esto_codigo',codigosdeinsumos,'C')+
                        ' and move_numerodoc = '+QAcabado.FieldByName('move_numerodoc').AsString+
                        ' and move_status <> ''C'''+
                        ' and move_unid_codigo = '+EdUNid_codigo.AsSql+
                        ' order by move_datamvto' );

//                    if QInsumos.FieldByName('move_datamvto').AsDateTime=QAcabado.FieldByName('move_datamvto').AsDateTime then
//                       DT_SAIDA     :=QInsumos.FieldByName('move_datamvto').AsDateTime+1
//                    else
                 while not QInsumos.Eof do begin


                   with AcbrSpedFiscal1.Bloco_K.RegistroK235New do begin

                         Sistema.BeginProcess('Registro K235 insumo '+QInsumos.FieldByName('move_esto_codigo').AsString);

                         DT_SAIDA     :=QInsumos.FieldByName('move_datamvto').AsDateTime;

                         COD_ITEM     :=QInsumos.FieldByName('move_esto_codigo').AsString;
                         QTD          :=QInsumos.FieldByName('move_qtde').AsCurrency;

                    end;

////////////////////////// - 24.06.18
                    if Lista75aux.IndexOf(QInsumos.FieldByName('move_esto_codigo').AsString)=-1 then begin
                      Lista75.Add(QInsumos.fieldbyname('move_esto_codigo').asstring);
                      Lista75aux.Add(QInsumos.fieldbyname('move_esto_codigo').asstring);
                    end;

                    QINsumos.Next;

                 end;
                 fGeral.FechaQuery(QInsumos);

             end;

             QAcabado.Next;

           end;

             fGeral.FechaQuery(QAcabado);

       end;

// 27.11.18 - a partir de 01.2019 - Novicarnes
///// Registro 1400. - entradas de produtor de 'qq esp�cie animal'
    if ListaReg1400.count>0 then begin

          for p := 0 to ListaReg1400.Count-1 do begin

             with  AcbrSpedFiscal1.Bloco_1.Registro1400New do begin

                PReg1400:=ListaReg1400[p];
                COD_ITEM :=PReg1400.COD_ITEM_IPM;
                MUN      :=strzero( PReg1400.MUN, 7 );
                VALOR    :=PReg1400.VALOR;
                if Lista75aux.IndexOf(COD_ITEM)=-1 then begin
                   Lista75.Add(COD_ITEM);
                   Lista75aux.Add(COD_ITEM);
                end;

             end;


          end;

     end;

// Cadastros dos itens do estoque e servicos
///////////////////////////////////////////////////////////////////////
       QAcabado   :=sqltoquery('select move_esto_codigo from movestoque'+
                                ' where move_datamvto>= '+EdInicio.AsSql+
                                ' and move_datamvto <= '+Edtermino.AsSql+
                                ' and move_tipomov = '+Stringtosql(Global.CodOrdemdeServico)+
                                ' and move_status <> ''C'''+
                                ' and move_unid_codigo = '+EdUNid_codigo.AsSql+
                                ' group by move_esto_codigo' );
       while not QAcabado.Eof do begin

          Lista75.Add( QAcabado.FieldByName('move_esto_codigo').AsString  );
          QAcabado.Next;

       end;

       for p:=0 to Lista75.count-1 do begin

         with Registro0200New do begin

           COD_ITEM:=Lista75[p];
           QE:=Sqltoquery('select * from estoque where esto_codigo='+Stringtosql(cod_item));
           if not QE.eof then begin
             DESCR_ITEM:=trim(QE.fieldbyname('esto_descricao').asstring);
// ver se � somente codigo de barra 'oficial' ou pode ser de uso interno tbem
             if copy(QE.fieldbyname('Esto_codbarra').asstring,1,3)='789' then
               COD_BARRA:=QE.fieldbyname('Esto_codbarra').asstring;
             COD_ANT_ITEM:='';
             UNID_INV:=GetCodigoUnidadeEstoque(QE.fieldbyname('Esto_unidade').asstring);
             if Servico(cod_item) then
               TIPO_ITEM:=tiServicos
// 02.07.15
             else if (QE.FieldByName('esto_sugr_codigo').AsInteger=EdEsto_sugr_codigo.asinteger) and (EdEsto_sugr_codigo.asinteger>0) then begin

               TIPO_ITEM:=tiMaterialConsumo;
               COD_NCM:=FEstoque.GetNCMipi(cod_item);
               ALIQ_ICMS:=FCodigosFiscais.GetAliquota( FEstoque.GetCodigoFiscal(cod_item,EdUnid_codigo.text,EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring) );
               COD_GEN:=copy(cod_ncm,1,2);
// 24.06.18
             end else if (QE.FieldByName('esto_sugr_codigo').AsInteger=Edsugr_codigoacabado.asinteger) and (Edsugr_codigoacabado.asinteger>0) then begin

               TIPO_ITEM:=tiProdutoAcabado;
               COD_NCM:=FEstoque.GetNCMipi(cod_item);
               ALIQ_ICMS:=FCodigosFiscais.GetAliquota( FEstoque.GetCodigoFiscal(cod_item,EdUnid_codigo.text,EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring) );
               COD_GEN:=copy(cod_ncm,1,2);

             end else begin

// 03.02.20 - Seip
               if AnsiPos('ACABADO',Uppercase( FGrupos.GetDescricao(QE.fieldbyname('esto_grup_codigo').asinteger ) ) ) > 0 then

                  TIPO_ITEM:=tiProdutoAcabado

               else if AnsiPos('COMPONENTE',Uppercase( FGrupos.GetDescricao(QE.fieldbyname('esto_grup_codigo').asinteger ) ) ) > 0 then

                  TIPO_ITEM:=tiMateriaPrima

               else
                  TIPO_ITEM:=tiMercadoriaRevenda;

               COD_NCM:=FEstoque.GetNCMipi(cod_item);
               ALIQ_ICMS:=FCodigosFiscais.GetAliquota( FEstoque.GetCodigoFiscal(cod_item,EdUnid_codigo.text,EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring) );
               COD_GEN:=copy(cod_ncm,1,2);

             end;

//////////////////             if trim(COD_NCM)='' then COD_NCM:='02012090';
///////////////////////////////////////////////////////////////////////////
             EX_IPI:='';
// 08.02.17
             CEST:=FEstoque.GetCESTNCM(cod_item);
// ver colocar este codigo em novo campo no sub-grupo do estoque
//             if FEstoque.Servico(cod_item,EdUNid_codigo.text,EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring) then
//               COD_LST:=
// 24.06.18 - caso for gerar bloco K
 // 06.02.19 - retirado devido a novicarnes nao tem composicao 'certa' pra isto
 // 03.02.20 - colocado devido a obrigatoriedade - Seip
             if  ( EdUnid_codigo.ResultFind.FieldByName('Unid_identatividade').AsString='02' )
                 and
                 ( Global.Topicos[1057] )
                 then begin

                 QCusto:=sqltoquery('select * from custos' +
                         ' where cust_status='+StringtoSql('N')+
                         ' and cust_tipo = '+StringtoSql('E')+
                         ' and cust_esto_codigo='+Stringtosql(Lista75[p]) );
                 if not QCusto.Eof then begin

                   while not Qcusto.eof do begin

                     with Registro0210New do begin
                          COD_ITEM_COMP  := QCusto.FieldByName('cust_esto_codigomat').AsString ;
                          QTD_COMP       := QCusto.FieldByName('cust_qtde').AsCurrency;
                          PERDA          := 0;
                     end;
                     QCusto.Next;

                   end;

                 end else begin  // vai buscar no proprio consumo e monta a planilha de custo

                   FGeral.FechaQuery(QCusto);
                   FGeral.FechaQuery(QAcabado);
                   QAcabado   :=sqltoquery('select move_transacao from movestoque'+
                                ' where move_datamvto>= '+EdInicio.AsSql+
                                ' and move_datamvto <= '+Edtermino.AsSql+
                                ' and move_tipomov = '+Stringtosql(Global.CodOrdemdeServico)+
                                ' and move_esto_codigo = '+Stringtosql(Lista75[p])+
                                ' and move_status <> ''C'''+
                                ' and move_unid_codigo = '+EdUNid_codigo.AsSql+
                                ' order by move_datamvto' );

                   if not QAcabado.Eof then xproduto := QAcabado.FieldByName('move_transacao').AsString
                   else xproduto := 'XY678%';

                   QCusto :=sqltoquery('select move_esto_codigo,move_qtde from movestoque'+
                        ' inner join movesto on ( move_transacao=moes_transacao and move_tipomov=moes_tipomov )'+
//                        ' where move_datamvto>= '+Datetosql(QAcabado.FieldByName('move_datamvto').AsDateTime)+
//                        ' and move_datamvto <= '+Datetosql(QAcabado.FieldByName('move_datamvto').AsDateTime)+
                        ' where move_datamvto>= '+EdInicio.assql+
                        ' and move_datamvto <= '+EdTermino.assql+
                        ' and move_tipomov = '+Stringtosql(Global.CodSaidaAlmox)+
                        ' and move_transacao = '+Stringtosql(xproduto)+
                        ' and move_status <> ''C'''+
                        ' and move_unid_codigo = '+EdUNid_codigo.AsSql+
                        ' order by move_datamvto' );

                   if not QCusto.Eof then begin

                     while not Qcusto.eof do begin

                       with Registro0210New do begin
                          COD_ITEM_COMP  := QCusto.FieldByName('move_esto_codigo').AsString ;
                          QTD_COMP       := QCusto.FieldByName('move_qtde').AsCurrency;
                          PERDA          := 0;
                       end;
                       QCusto.Next;

                     end;

                   end;

                 end;
                 FGeral.FechaQuery(QCusto);
                 FGeral.FechaQuery(QAcabado);

             end;
//             }

           end else

             Avisoerro('Codigo '+cod_item+' n�o encontrado no estoque');

         end;

       end;

// Cadastros de natureza de operacao...'quase os cfops'
///////////////////////////////////////////////////////////////////////
       for p:=0 to ListaTodosCfops.count-1 do begin
         with Registro0400New do begin
           COD_NAT:=ListaTodosCfops[p];
           DESCR_NAT:=FNatureza.GetDescricao( ListaTodosCfops[p] ) ;
         end;
       end;

// 29.09.2021 - Clessi
// Cadastros de natureza de operacao...'quase os cfops'
///////////////////////////////////////////////////////////////////////
       if ListaRegC195.count > 0 then begin

         with Registro0460New do begin

           COD_OBS := CODCREDITOICMS;
           TXT     := 'DOCUMENTO EMITIDO POR ME OU EPP OPTANTE PELO SIMPLES NACIONAL. PERMITE APROVEITAMENTO DE CREDITO DE ICMS' ;

         end;

       end;

// Cadastros de mensagens usadas notas notas nos dados adicionais
// o jamanta..s� gerar se usar o campo de informa�oes complementares
///////////////////////////////////////////////////////////////////////
{       with Registro0450New do begin
         QE:=sqltoquery('select * from mensagensnf order by mens_codigo');
         while not QE.Eof do begin
           COD_INF:=strzero(QE.fieldbyname('mens_codigo').asinteger,6);
           TXT:=QE.fieldbyname('Mens_descricao').Asstring ;
           Qe.Next;
         end;
       end;
}

// Cadastros do plano de contas contabil do Contax mes
// REVISAR : informar somente as contas dos bens do ativo imobilizado informado
//           no registro 300 que por sua vez s� informa os bens j� inclusos e 'movimentados' no
//           periodo e que s�o informados no Bloco G regisgro G125
///////////////////////////////////////////////////////////////////////

//       GeraRegistro500;

/////////////////////////////// FIM DO BLOCO 0
       with AcbrSpedFiscal1.Bloco_0 do begin
//                    Registro 000    Registro 001
//                    Registro 100
          regsbloco0:=     1       +        1        +Registro0005Count+
                           1           +Registro0150Count+Registro0190Count+
                      Registro0200Count+Registro0400Count+Registro0450Count+
                      Registro0500Count;
       end;

       with Registro0990 do begin
         QTD_LIN_0:=regsbloco0;
       end;

    end;   // BLOCO 0

// Abertura Bloco D - conhecimentos de transporte e outros...
//    if (AcbrSpedFiscal1.Bloco_D.RegistroD100Count>0) or
//       (AcbrSpedFiscal1.Bloco_D.RegistroD190Count>0) then begin
    if (NRegD100+NRegD500)>0 then begin
      with AcbrSpedFiscal1.Bloco_D do begin
        with RegistroD001 do begin
          IND_MOV:=imComDados;
        end;
      end;
    end;


//Encerramento Bloco D
//////////////////////////
       with AcbrSpedFiscal1.Bloco_D do begin
//                       D001            D990
          regsbloco0:=     1       +        1        +RegistroD100Count+
                      RegistroD110Count+RegistroD190Count+
                      RegistroD500Count+RegistroD590Count;
       end;

       with AcbrSpedFiscal1.Bloco_D.RegistroD990 do begin
         QTD_LIN_D:=regsbloco0;
       end;

// Abertura Bloco E - apuracao do icms
////////////////////////////////////////
//    if (AcbrSpedFiscal1.Bloco_D.RegistroD100Count>0) or
//       (AcbrSpedFiscal1.Bloco_D.RegistroD190Count>0) then begin
      with AcbrSpedFiscal1.Bloco_E do begin
/////////////////////
{
        with RegistroE001New do begin
          IND_MOV:=imComDados;
        end;
        with RegistroE100New do begin
          DT_INI:=EdInicio.AsDate;
          DT_FIN:=EdTermino.AsDate;
        end;
        with RegistroE500New do begin
          IND_APUR:=iaMensal;
          DT_INI:=EdInicio.AsDate;
          DT_FIN:=EdTermino.AsDate;
        end;
        }
/////////////////////
        for p:=0 to ListaRegE110.Count-1 do begin
          with RegistroE110New do begin
            PRegE110:=ListaRegE110[p];
            PRegE110.VL_SLD_APURADO:=( PRegE110.VL_TOT_DEBITOS+(PRegE110.VL_AJ_DEBITOS+VL_TOT_AJ_DEBITOS)
                                     + PRegE110.VL_ESTORNOS_CRED  )  -
                                     ( PRegE110.VL_TOT_CREDITOS + (PRegE110.VL_AJ_CREDITOS+PRegE110.VL_TOT_AJ_CREDITOS)
                                      + PRegE110.VL_ESTORNOS_DEB + PRegE110.VL_SLD_CREDOR_ANT  );
            PRegE110.VL_ICMS_RECOLHER:=PRegE110.VL_SLD_APURADO - PRegE110.VL_TOT_DED;
            if PRegE110.VL_ICMS_RECOLHER<0 then
               PRegE110.VL_ICMS_RECOLHER:=0;
            if PRegE110.VL_SLD_APURADO<0 then begin
              PRegE110.VL_SLD_CREDOR_TRANSPORTAR:=abs(PRegE110.VL_SLD_APURADO);
              PRegE110.VL_SLD_APURADO:=0;
            end;
            VL_TOT_DEBITOS:=PRegE110.VL_TOT_DEBITOS;
            VL_AJ_DEBITOS:=PRegE110.VL_AJ_DEBITOS;
            VL_TOT_AJ_DEBITOS:=PRegE110.VL_TOT_AJ_DEBITOS;
            VL_ESTORNOS_CRED:=PRegE110.VL_ESTORNOS_CRED;
            VL_TOT_CREDITOS:=PRegE110.VL_TOT_CREDITOS;
            VL_AJ_CREDITOS:=PRegE110.VL_AJ_CREDITOS;
            VL_TOT_AJ_CREDITOS:=PRegE110.VL_TOT_AJ_CREDITOS;
            VL_ESTORNOS_DEB:=PRegE110.VL_ESTORNOS_DEB;
            VL_SLD_CREDOR_ANT:=PRegE110.VL_SLD_CREDOR_ANT;
            VL_SLD_APURADO:=PRegE110.VL_SLD_APURADO;
            VL_TOT_DED:=PRegE110.VL_TOT_DED;
            VL_ICMS_RECOLHER:=PRegE110.VL_ICMS_RECOLHER;
            VL_SLD_CREDOR_TRANSPORTAR:=PRegE110.VL_SLD_CREDOR_TRANSPORTAR;
          end;
          with RegistroE116New do begin
            COD_OR:='000'; // icms a recolher
            VL_OR:=PRegE110.VL_ICMS_RECOLHER;
            DT_VCTO:=EdTermino.asdate+15;
            if EdUnid_codigo.ResultFind.FieldByName('unid_uf').asstring='PR' then
              COD_REC:='1015'   // icms a recolher da sefa
            else if EdUnid_codigo.ResultFind.FieldByName('unid_uf').asstring='SC' then
              COD_REC:='144910014'   // icms a recolher d�cimo dia util
            else
              COD_REC:='1015';  // ir vendo de cada estado....
//            NUM_PROC:='';
            IND_PROC:=opNenhum;
//            PROC:='';
//            TXT_COMPL:='';
// campo somente a partir de 01.2011 - dever� precisar de atualizao da ACBR
            MES_REF:=strzero(Datetomes(EdTermino.asdate),2)+strzero(Datetoano(EdTermino.asdate,true),4)
          end;
        end;

        for p:=0 to ListaRegE520.Count-1 do begin
          with RegistroE520New do begin
            PRegE520:=ListaRegE520[p];
            PRegE520.VL_SD_IPI:=( PRegE520.VL_DEB_IPI + PRegE520.VL_OD_IPI  )  -
                                ( PRegE520.VL_SD_ANT_IPI + PRegE520.VL_CRED_IPI + PRegE520.VL_OC_IPI );
            if PRegE520.VL_SD_IPI<0 then begin
              PRegE520.VL_SC_IPI:=abs(PRegE520.VL_SD_IPI);
              PRegE520.VL_SD_IPI:=0;
            end;
            VL_SD_ANT_IPI:=PRegE520.VL_SD_ANT_IPI;
            VL_DEB_IPI:=PRegE520.VL_DEB_IPI;
            VL_CRED_IPI:=PRegE520.VL_CRED_IPI;
            VL_OD_IPI:=PRegE520.VL_OD_IPI;
            VL_OC_IPI:=PRegE520.VL_OC_IPI;
            VL_SC_IPI:=PRegE520.VL_SC_IPI;
            VL_SD_IPI:=PRegE520.VL_SD_IPI;
          end;
        end;

      end;
//    end;

//Encerramento Bloco E
//////////////////////////
       with AcbrSpedFiscal1.Bloco_E do begin
//                       E001            E100         E990
          regsbloco0:=     1       +        1        +   1   +
                         RegistroE110Count+RegistroE500Count+RegistroE510Count+
                         RegistroE520Count+RegistroE530Count;
       end;

       with AcbrSpedFiscal1.Bloco_E.RegistroE990 do begin
         QTD_LIN_E:=regsbloco0;
       end;

//Abertura Bloco G
//////////////////////////
      with AcbrSpedFiscal1.Bloco_G do begin
        with RegistroG001New do begin
//          IND_MOV:=imComDados;
          IND_MOV:=imSemDados;
        end;
//Encerramento Bloco G
//////////////////////////
        regsbloco0:=     1       +        1        +   1   +
                       RegistroG110Count+RegistroG125Count+
                       RegistroG130Count+RegistroG140Count;
        with RegistroG990 do begin
          QTD_LIN_G:=regsbloco0;
        end;
      end;

// 14.03.12
//Encerramento Bloco H
///////////////////////////////
      with AcbrSpedFiscal1.Bloco_H do begin
//////////////////////  H001            H990
        regsbloco0:=     1       +      1   +
                       RegistroH005Count+RegistroH010Count+RegistroH020Count;
        with RegistroH990 do begin
          QTD_LIN_H:=regsbloco0;
        end;
      end;

//Abertura Bloco 1
//////////////////////////
      with AcbrSpedFiscal1.Bloco_1 do begin
        with Registro1001New do begin
//          IND_MOV:=imSemDados;
// 22.08.12 - a partir de 01.07.12 obrigatorio
          IND_MOV:=imComDados;
        end;
// 22.08.12 - Geracao do Registro 1100 com os 'S e N'
         with Registro1010New do begin
           IND_EXP:=Reg10101100;
           IND_CCRF:='N';
           IND_COMB:='N';
           IND_USINA:='N';
           IND_VA:='N';
// 16.01.19
           if ListaReg1400.Count > 0 then
              IND_VA:='S';
// 06.02.20 - Novicarnes
           IND_REST_RESSARC_COMPL_ICMS := 'N';
           IND_EE:='N';
           IND_CART:='N';
           IND_FORM:='N';
           IND_AER:='N';
// 16.01.19
           IND_GIAF1:='N';
           IND_GIAF3:='N';
           IND_GIAF4:='N';
         end;
//Encerramento Bloco 1
//////////////////////  1001            1990    //1010
        regsbloco0:=     1       +      1   +    1    +
                       Registro1100Count+Registro1105Count;  // tem + registros...
        with Registro1990 do begin
          QTD_LIN_1:=regsbloco0;
        end;
      end;

//Abertura Bloco 9
//////////////////////////
      with AcbrSpedFiscal1.Bloco_9 do begin
        with Registro9001 do begin
          IND_MOV:=imComDados;
        end;
//Encerramento Bloco 9
//////////////////////
          {
        with Registro9900 do begin

           New.REG_BLC:='0000';
           New.QTD_REG_BLC:=1;
           Add(New);
           New.REG_BLC:='0001';
           New.QTD_REG_BLC:=1;
           Add(New);
           New.REG_BLC:='0100';
           New.QTD_REG_BLC:=1;
           Add(New);
           New.REG_BLC:='0005';
           New.QTD_REG_BLC:=AcbrSpedFiscal1.Bloco_0.Registro0005Count;
           Add(New);

//                    Registro 000    Registro 001
//                    Registro 100
//          regsbloco0:=     1       +        1        +Registro0005Count+
//                           1           +Registro0150Count+Registro0190Count+
//                      Registro0200Count+Registro0400Count+Registro0450Count+
//                      Registro0500Count;

        end;
        }
////////////////////////////

        with Registro9990 do begin
//                      9001  +  9990 + 9999
          QTD_LIN_9:=     1    +   1  +   1  +Registro9900.Count;
        end;
        with Registro9999 do begin
//                      9001  +  9990 + 9999
          QTD_LIN:=Registro9900.Count + Registro9990.QTD_LIN_9;
        end;

      end;  /// with .. bloco 9


  Sistema.setmessage('Criando arquivo texto '+nomearq+' na pasta '+AcbrSpedFiscal1.Path);

  AcbrSpedFiscal1.SaveFileTXT;
  Lista75.free;
  Lista75Aux.free;
  ListaAliquotas.free;
  ListaBases.free;
  ListaCfops.free;
  ListaCSTs.free;



  Sistema.Endprocess('Gerado arquivo '+nomearq);


end;

// 17.09.19
// 29.09.2021
function TFSpedFiscal.GetAliqicms(s: widestring): currency;
////////////////////////////////////////////////////////////
var posicao : integer;
    buscar,
    ondebuscar  : string;
    aliicms     : currency;

begin

   ondebuscar := s;
   buscar := 'EMPRESA OPTANTE PELO SIMPLES NACIONAL PERMITE O APROVEITAMENTO DO CREDITO DE ICMS';
   posicao := AnsiPos( buscar, Uppercase(ondebuscar) );
   aliicms := 0;
   if posicao > 0 then begin

      ondebuscar := copy( ondebuscar,posicao,200);
      buscar := 'CORRESPONDENTE A ALIQUOTA DE';
      posicao := AnsiPos( buscar, Uppercase(ondebuscar));
      if posicao >0 then

         aliicms := strtocurr( copy( ondebuscar,posicao+length(buscar),5 ) );

   end;
   result := aliicms;

end;

// 29.09.2021
function TFSpedFiscal.GetAliqIcmsRegc195(trans: string): currency;
/////////////////////////////////////////////////////////////////////
var p:integer;

begin

  result := 0;
  for p := 0 to ListaRegC195.count-1 do begin

      PRegC195 := ListaRegC195[p];
      if PRegC195.TRANSACAO = trans then begin

         result := PRegC195.ALIICMS;
         break;

      end;

  end;

end;

function TFSpedFiscal.GetCSTCOFINS(ycst, ycfop,  ycsticms: string): TACBrSituacaoTribCOFINS;
//////////////////////////////////////////////////////////////////////////////////////////////
begin

      result:=stcofinsValorAliquotaNormal;
      if ycst='01' then
        result:=stcofinsValorAliquotaNormal          // '01' // Opera��o Tribut�vel com Al�quota B�sica                           // valor da opera��o al�quota normal (cumulativo/n�o cumulativo)).
      else if ycst='02' then
        result:=stcofinsValorAliquotaDiferenciada    // '02' // Opera��o Tribut�vel com Al�quota Diferenciada                     // valor da opera��o (al�quota diferenciada)).
      else if ycst='03' then
        result:=stcofinsQtdeAliquotaUnidade          // '03' // Opera��o Tribut�vel com Al�quota por Unidade de Medida de Produto // quantidade vendida x al�quota por unidade de produto).
      else if ycst='04' then
        result:=stcofinsMonofaticaAliquotaZero         // '04' // Opera��o Tribut�vel Monof�sica - Revenda a Al�quota Zero
      else if ycst='05' then
        result:=stcofinsValorAliquotaPorST             // '05' // Opera��o Tribut�vel por Substitui��o Tribut�ria
      else if ycst='06' then
        result:=stcofinsAliquotaZero                   // '06' // Opera��o Tribut�vel a Al�quota Zero
      else if ycst='07' then
        result:=stcofinsIsentaContribuicao            // '07' // Opera��o Isenta da Contribui��o
      else if ycst='08' then
        result:=stcofinsSemIncidenciaContribuicao     // '08' // Opera��o sem Incid�ncia da Contribui��o
      else if ycst='09' then
        result:=stcofinsSuspensaoContribuicao        // '09' // Opera��o com Suspens�o da Contribui��o
      else if ycst='49' then
        result:=stcofinsOutrasOperacoesSaida        // '49' // Outras Opera��es de Sa�da
      else if ycst='50' then
        result:=stcofinsOperCredExcRecTribMercInt    // '50' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita Tributada no Mercado Interno
      else if ycst='51' then
        result:=stcofinsOperCredExcRecNaoTribMercInt  // '51' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita N�o-Tributada no Mercado Interno
      else if ycst='52' then
        result:=stcofinsOperCredExcRecExportacao             // '52' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita de Exporta��o
      else if ycst='53' then
        result:=stcofinsOperCredRecTribNaoTribMercInt        // '53' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno
      else if ycst='54' then
        result:=stcofinsOperCredRecTribMercIntEExportacao    // '54' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o
      else if ycst='55' then
        result:=stcofinsOperCredRecNaoTribMercIntEExportacao  // '55' // Opera��o com Direito a Cr�dito - Vinculada a Receitas N�o Tributadas no Mercado Interno e de Exporta��o
      else if ycst='56' then
        result:=stcofinsOperCredRecTribENaoTribMercIntEExportacao  // '56' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno e de Exporta��o
      else if ycst='60' then
        result:=stcofinsCredPresAquiExcRecTribMercInt        // '60' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita Tributada no Mercado Interno
      else if ycst='61' then
        result:=stcofinsCredPresAquiExcRecNaoTribMercInt     // '61' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita N�o-Tributada no Mercado Interno
      else if ycst='62' then
        result:=stcofinsCredPresAquiExcExcRecExportacao      // '62' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita de Exporta��o
      else if ycst='63' then
        result:=stcofinsCredPresAquiRecTribNaoTribMercInt   // '63' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno
      else if ycst='64' then
        result:=stcofinsCredPresAquiRecTribMercIntEExportacao     // '64' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o
      else if ycst='65' then
        result:=stcofinsCredPresAquiRecNaoTribMercIntEExportacao  // '65' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas N�o-Tributadas no Mercado Interno e de Exporta��o
      else if ycst='66' then
        result:=stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao // '66' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno e de Exporta��o
      else if ycst='67' then
        result:=stcofinsOutrasOperacoes_CredPresumido        // '67' // Cr�dito Presumido - Outras Opera��es
      else if ycst='70' then
        result:=stcofinsOperAquiSemDirCredito          // '70' // Opera��o de Aquisi��o sem Direito a Cr�dito
      else if ycst='71' then
        result:=stcofinsOperAquiComIsensao             // '71' // Opera��o de Aquisi��o com Isen��o
      else if ycst='72' then
        result:=stcofinsOperAquiComSuspensao           // '72' // Opera��o de Aquisi��o com Suspens�o
      else if ycst='73' then
        result:=stcofinsOperAquiAliquotaZero          // '73' // Opera��o de Aquisi��o a Al�quota Zero
      else if ycst='74' then
        result:=stcofinsOperAqui_SemIncidenciaContribuicao   // '74' // Opera��o de Aquisi��o sem Incid�ncia da Contribui��o
      else if ycst='75' then
        result:=stcofinsOperAquiPorST                 // '75' // Opera��o de Aquisi��o por Substitui��o Tribut�ria
      else if ycst='98' then
        result:=stcofinsOutrasOperacoesEntrada        // '98' // Outras Opera��es de Entrada
      else // if ycst='99' then
        result:= stcofinsOutrasOperacoes;                                // '99' // Outras Opera��es
{
      if ( trim(ycfop)<>'' ) and ( Pos(ycfop,CfopsConhecimentoSaida)=0 ) and ( pos(copy(ycfop,1,1),'1,2,3')>0 ) then begin
        if pos( ycfop,CfopsAquisicaoBensparaRevenda+';'+CfopsAquisicaoBensparaInsumo+';'+
                CfopsAquisicaoServicosparaInsumo+';'+CfopsDevolucaoVendaNaoCumulativa+';'+
                CfopsOutrasEntradascomCredito ) = 0 then
            result:=stcofinsOperAquiSemDirCredito
      end;
}

end;

// 17.09.19
function TFSpedFiscal.GetCSTPIS(ycst, ycfop, ycsticms: string): TACBrSituacaoTribPIS;
//////////////////////////////////////////////////////////////////////////////////////////
begin

//      result:=stpisValorAliquotaNormal;
      if ycst='01' then
        result:=stpisValorAliquotaNormal // Opera��o Tribut�vel com Al�quota B�sica   // valor da opera��o al�quota normal (cumulativo/n�o cumulativo)).
      else if ycst='02' then
        result:=stpisValorAliquotaDiferenciada     // '02' // Opera��o Tribut�vel com Al�quota Diferenciada // valor da opera��o (al�quota diferenciada)).
      else if ycst='03' then
        result:=stpisQtdeAliquotaUnidade           // '03' // Opera��o Tribut�vel com Al�quota por Unidade de Medida de Produto // quantidade vendida x al�quota por unidade de produto).
      else if ycst='04' then
        result:=stpisMonofaticaAliquotaZero        // '04' // Opera��o Tribut�vel Monof�sica - Revenda a Al�quota Zero
      else if ycst='05' then
        result:=stpisValorAliquotaPorST            // '05' // Opera��o Tribut�vel por Substitui��o Tribut�ria
      else if ycst='06' then
        result:=stpisAliquotaZero                  // '06' // Opera��o Tribut�vel a Al�quota Zero
      else if ycst='07' then
        result:=stpisIsentaContribuicao            // '07' // Opera��o Isenta da Contribui��o
      else if ycst='08' then
        result:=stpisSemIncidenciaContribuicao     // '08' // Opera��o sem Incid�ncia da Contribui��o
      else if ycst='09' then
        result:=stpisSuspensaoContribuicao         // '09' // Opera��o com Suspens�o da Contribui��o
      else if ycst='49' then
        result:=stpisOutrasOperacoesSaida          // '49' // Outras Opera��es de Sa�da
      else if ycst='50' then
        result:=stpisOperCredExcRecTribMercInt     // '50' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita Tributada no Mercado Interno
      else if ycst='51' then
        result:=stpisOperCredExcRecNaoTribMercInt  // '51' // Opera��o com Direito a Cr�dito � Vinculada Exclusivamente a Receita N�o Tributada no Mercado Interno
      else if ycst='52' then
        result:=stpisOperCredExcRecExportacao      // '52' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita de Exporta��o
      else if ycst='53' then
        result:=stpisOperCredRecTribNaoTribMercInt // '53' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno
      else if ycst='54' then
        result:=stpisOperCredRecTribMercIntEExportacao // '54' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o
      else if ycst='55' then
        result:=stpisOperCredRecNaoTribMercIntEExportacao // '55' // Opera��o com Direito a Cr�dito - Vinculada a Receitas N�o-Tributadas no Mercado Interno e de Exporta��o
      else if ycst='56' then
        result:=stpisOperCredRecTribENaoTribMercIntEExportacao // '56' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno, e de Exporta��o
      else if ycst='60' then
        result:=stpisCredPresAquiExcRecTribMercInt      // '60' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita Tributada no Mercado Interno
      else if ycst='61' then
        result:=stpisCredPresAquiExcRecNaoTribMercInt   // '61' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita N�o-Tributada no Mercado Interno
      else if ycst='62' then
        result:=stpisCredPresAquiExcExcRecExportacao    // '62' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita de Exporta��o
      else if ycst='63' then
        result:=stpisCredPresAquiRecTribNaoTribMercInt    // '63' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno
      else if ycst='64' then
        result:=stpisCredPresAquiRecTribMercIntEExportacao // '64' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o
      else if ycst='65' then
        result:=stpisCredPresAquiRecNaoTribMercIntEExportacao  // '65' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas N�o-Tributadas no Mercado Interno e de Exporta��o
      else if ycst='66' then
        result:=stpisCredPresAquiRecTribENaoTribMercIntEExportacao  // '66' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno, e de Exporta��o
      else if ycst='67' then
        result:=stpisOutrasOperacoes_CredPresumido       // '67' // Cr�dito Presumido - Outras Opera��es
      else if ycst='70' then
        result:=stpisOperAquiSemDirCredito               // '70' // Opera��o de Aquisi��o sem Direito a Cr�dito
      else if ycst='71' then
        result:=stpisOperAquiComIsensao                // '71' // Opera��o de Aquisi��o com Isen��o
      else if ycst='72' then
        result:=stpisOperAquiComSuspensao              // '72' // Opera��o de Aquisi��o com Suspens�o
      else if ycst='73' then
        result:=stpisOperAquiAliquotaZero              // '73' // Opera��o de Aquisi��o a Al�quota Zero
      else if ycst='74' then
        result:=stpisOperAqui_SemIncidenciaContribuicao    // '74' // Opera��o de Aquisi��o sem Incid�ncia da Contribui��o
      else if ycst='75' then
        result:=stpisOperAquiPorST                    // '75' // Opera��o de Aquisi��o por Substitui��o Tribut�ria
      else if ycst='98' then
        result:=stpisOutrasOperacoesEntrada          // '98' // Outras Opera��es de Entrada
      else // if ycst='99' then
        result:=stpisOutrasOperacoes;      // '99' // Outras Opera��es   // 14.03.16
{
      if ( trim(ycfop)<>'' ) and ( Pos(ycfop,CfopsConhecimentoSaida)=0 ) and ( pos(copy(ycfop,1,1),'1,2,3')>0 ) then begin
        if pos( ycfop,CfopsAquisicaoBensparaRevenda+';'+CfopsAquisicaoBensparaInsumo+';'+
                CfopsAquisicaoServicosparaInsumo+';'+CfopsDevolucaoVendaNaoCumulativa+';'+
                CfopsOutrasEntradascomCredito ) = 0 then
            result:=stpisOperAquiSemDirCredito
      end;
}

end;

function TFSpedFiscal.GetNumerodoEndereco(endereco: string;  codigo: integer; mensagem: string): string;
///////////////////////////////////////////////////////////////
var posicaovirgula,posicaokm,posicao2numeros:integer;
begin
   posicaovirgula:=pos(',',endereco);
   posicaokm:=pos('KM',uppercase(endereco));
   posicao2numeros:=Posicao2num(endereco);
   if posicaovirgula>0 then
     result:=copy(endereco,posicaovirgula+1,5)
   else if posicaokm>0 then
     result:=copy(endereco,posicaokm+3,4)
   else if posicao2numeros>0 then
     result:=copy(endereco,posicao2numeros,4)
   else begin
     result:='';
     if mensagem='S' then
       Avisoerro('Falta colocar a v�rgula antes do numero no endere�o '+endereco+' Codigo '+inttostr(codigo));
   end;
   if result<>'' then
     result:=trim(result);
   if pos('S/N',uppercase(result))>0 then result:='';
   
end;

function TFSpedFiscal.Posicao2num(endereco: string): integer;
var t,p,n:integer;
begin
  t:=length(trim(endereco));
  n:=0;
//  for p:=0 to t do begin
  for p:=1 to t do begin
    if endereco[p] in ['0'..'9'] then begin
      if endereco[p+1] in ['0'..'9'] then begin
        n:=p;
        break;
      end
    end;
  end;
  result:=n;
end;

procedure TFSpedFiscal.GeraRegistro500;
/////////////////////////////////////////
var QPlan: TSqlquery;
    ind_ctav, cod_cta_sup, classf, sqlplanoempresa: String;
    p, nivelv, xc: Integer;

    function GetClassificacaoAnalitica(cla:string):string;
    ///////////////////////////////////////////////////////
    var QP:Tsqlquery;
        tam:string;
    begin
      tam:=inttostr(length(trim(cla)));
      QP:=FGeral.SqlToQueryContax(' select pcon_classificacaosped, pcon_tipo '+
                            ' from planocon'+
                            sqlplanoempresa+
                            ' and substr(pcon_classificacao,1,'+tam+')='+Stringtosql(cla)+
                            ' order by pcon_classificacao ');
      result:='';
      while not QP.eof do begin
        if QP.FieldByName('pcon_tipo').asstring='AA' then begin
          result:=FormataClassificacaoSped(QP.fieldbyname('pcon_classificacaosped').AsString);
          break;
        end;
        QP.Next;
      end;
      Qp.Close;Freeandnil(Qp);
    end;

begin
//////////////////
  sqlplanoempresa:=' where pcon_empr_codigo='+Stringtosql( strzero(EdUNid_codigo.resultfind.fieldbyname('Unid_empresa1').asinteger,2) );
  QPlan:=FGeral.SqlToQueryContax(' select pcon_classificacaosped, pcon_conta, pcon_descricao,pcon_classificacao, '+
                            ' pcon_spednaturezaconta, pcon_dataincalteracao, pcon_tipo, pcon_planorefsped  '+
                            ' from planocon'+
                            sqlplanoempresa+
//                            ' order by pcon_classificacaosped ');
                            ' order by pcon_classificacao ');
  xc:=0;
  while not QPlan.Eof do begin

    classf:= FormataClassificacaoSped(QPlan.fieldbyname('pcon_classificacaosped').AsString);
//    Sistema.setmessage('Conta '+FormataClassificacao(QPlan.Fieldbyname('pcon_classificacao').AsString)+' '+QPlan.fieldbyname('pcon_descricao').AsString);
    inc(xc);
    Sistema.setmessage(strzero(xc,5)+' Conta '+FormataClassificacao(QPlan.Fieldbyname('pcon_classificacao').AsString));
// 01.06.10 - rever ..a classificacao � 'do sped' ou do plano da empresa
// 18.06.10 - se usar este tem q gerar o registro I051 entao por enquanto...
// 19.06.10 - sei l�.....
// 24.06.10 - mais uma vez...
    if QPlan.fieldbyname('pcon_tipo').AsString='SS' then
      ind_ctav:='S'
    else
      ind_ctav:='A';
/////////////////
{
    if ind_ctav = 'A' then begin
      if (QPlan.Fieldbyname('pcon_classificacaosped').AsString='') or (QPlan.Fieldbyname('pcon_classificacaosped').AsString = null) then begin
         Texto.Lines.Add('Conta: '+QPlan.Fieldbyname('pcon_conta').AsString+' n�o associada ao plano referencial !');
      end;

      if (QPlan.Fieldbyname('pcon_spednaturezaconta').AsString = '') or (QPlan.Fieldbyname('pcon_spednaturezaconta').AsString = null) then begin
        Texto.Lines.Add('Conta: '+QPlan.Fieldbyname('pcon_conta').AsString+' n�o possui natureza !');
//        Sistema.EndProcess('Gera��o do Sped interrompida');
//        FGeraSpedContabil.Close;
//        CloseFile(Txt);
//        Exit;
      end;
    end;
/////////////////
    }

    nivelv := 1;
// 18.06.10
//    if (QPlan.fieldbyname('pcon_tipo').AsString='SS') and ( length(classf) = 0  ) then
//      classf:=GetClassificacaoAnalitica(QPlan.fieldbyname('pcon_classificacao').AsString);
// retirado pois tem q fazer o plano do sped 'igual' ao contabil 1 , 1.01 , 1.01.01 e etc

    if length(classf) = 1 then cod_cta_sup := ''
    else if length(classf) = 0 then cod_cta_sup := ''
    else begin
      for p := Length(classf) downto 1 do begin
        if ((classf[p]) = '.') then begin
          cod_cta_sup := substr(classf,1,p-1);
          Break;
        end;
      end;
    end;

    if length(classf) = 1 then nivelv := 1
    else begin
      for p := 1 to Length(classf) do begin
        if ((classf[p]) = '.') then nivelv := nivelv+1;
      end;
    end;

    with AcbrSpedFiscal1.Bloco_0 do begin
      with Registro0500new do begin
        DT_ALT:=QPlan.fieldbyname('pcon_dataincalteracao').AsDatetime;
        COD_NAT_CC:=QPlan.fieldbyname('pcon_spednaturezaconta').AsString;
        IND_CTA:=ind_ctav;
        NIVEL:=inttostr(nivelv);
        COD_CTA:=classf;
        NOME_CTA:=QPlan.fieldbyname('pcon_descricao').AsString;
      end;
    end;


//    Writeln(Txt,'|I050|'+FormatDatetime('ddmmyyyy',QPlan.fieldbyname('pcon_dataincalteracao').AsDatetime)+'|'+
//            QPlan.fieldbyname('pcon_spednaturezaconta').AsString+'|'+
//            ind_cta+'|'+IntToStr(nivel)+'|'+
//            classf+'|'+cod_cta_sup+'|'+QPlan.fieldbyname('pcon_descricao').AsString+'|'
//            );


    // Plano de Contas Referencial.
    if trim(QPlan.Fieldbyname('pcon_planorefsped').AsString)<>'' then
      classf := FormataClassificacaoSped(QPlan.Fieldbyname('pcon_planorefsped').AsString)
    else
      classf := FormataClassificacaoSped( copy(QPlan.Fieldbyname('pcon_classificacaosped').AsString,1,09) );

    // Plano pr�prio
///    classf2 := FormataClassificacao(QPlan.Fieldbyname('pcon_classificacao').AsString);

    QPlan.Next;
  end;

  FGeral.FechaQuery(QPlan);
//  QPlan.Close;

end;

/////////////////////////////////////////////////////////////////////////////////
function TFSpedFiscal.FormataClassificacaoSped(  Classificacao: String): String;
/////////////////////////////////////////////////////////////////////////////////
var p,i:integer;
    tt,t,ttt:string;
    TamValidoSped:Array[0..30] of Boolean;
    Q:TSqlquery;
begin
// buscar direto no config1 - ver criar no sac ou buscar no contax
  if trim(FormatoMascaraSped)='' then begin
    Q:=FGeral.SqlToQueryContax('select * from config1 where cfg1_nome='+Stringtosql('MASCARAPLANOSPED'));
  //  t:=FGeral.GetConfig1AsString('MASCARAPLANOSPED');
    t:=Q.fieldbyname('cfg1_conteudo').asstring;
    tt:='';ttt:='';
    for i:=0 to 30 do TamValidoSped[i]:=False;
    for i:=1 to Length(t) do begin
       if t[i]='9' then tt:=tt+'9';
       if t[i]='9' then ttt:=ttt+'9';
       if t[i]='.' then tt:=tt+'\.';
       if (t[i]='.') or (i=Length(t)) then TamValidoSped[Length(ttt)]:=True;
       if t[i]='9' then FormatoMascaraSped:=FormatoMascaraSped+'#';
       if t[i]='.' then FormatoMascaraSped:=FormatoMascaraSped+'.';
    end;
    tt:=tt+';0;_';
    FGeral.FechaQuery(Q);
  end;
//  if trim(FormatoMascaraSped)='' then ConfiguraMascara;
  Result:=Trim(Trans(Classificacao,FormatoMascaraSped));
  for p:=Length(Result) downto 1 do if isNumero(Result[p]) then Break;
  Result:=LeftStr(Result,p);
end;

function TFSpedFiscal.FormataClassificacao(Classificacao: String): String;
////////////////////////////////////////////////////////////////////////////
var p,i:integer;
    tt,t,ttt:string;
    TamValidoSped:Array[0..30] of Boolean;
    Q:TSqlquery;

begin
// buscar direto no config1 - ver criar no sac ou buscar no contax
  if trim(FormatoMascara)='' then begin
    Q:=FGeral.SqlToQueryContax('select * from config1 where cfg1_nome='+Stringtosql('MASCARAPLANOCON'));
  //  t:=FGeral.GetConfig1AsString('MASCARAPLANOCON');
    t:=Q.fieldbyname('cfg1_conteudo').asstring;
    tt:='';ttt:='';
    for i:=0 to 30 do TamValidoSped[i]:=False;
    for i:=1 to Length(t) do begin
       if t[i]='9' then tt:=tt+'9';
       if t[i]='9' then ttt:=ttt+'9';
       if t[i]='.' then tt:=tt+'\.';
       if (t[i]='.') or (i=Length(t)) then TamValidoSped[Length(ttt)]:=True;
       if t[i]='9' then FormatoMascara:=FormatoMascara+'#';
       if t[i]='.' then FormatoMascara:=FormatoMascara+'.';
    end;
    tt:=tt+';0;_';
    FGeral.FechaQuery(Q);
  end;
  Result:=Trim(Trans(Classificacao,FormatoMascara));
  for p:=Length(Result) downto 1 do if isNumero(Result[p]) then Break;
  Result:=LeftStr(Result,p);
end;

///////////////////////////////////////////////////
procedure TFSpedFiscal.SomanoRegistro(tiporegistro, ycst, ycfop: string;  yaliqicms,ytotalitem,ybaseicms,yvlricms,ybaseicmsst,yvlricmsst,yreducaobase,yvlripi: currency);
///////////////////////////////////////////////////
var p:integer;
    achou:boolean;
begin
  achou:=false;
  for p:=0 to ListaTotalCst.Count-1 do begin
    PTotalCst:=ListaTotalCst[p];
    if tiporegistro='E510' then begin
      if (PTotalCst.registro=tiporegistro) and (PTotalCst.cst=ycst)  and
         (PTotalCst.cfop=ycfop) then begin
         achou:=true;
         break;
      end;
    end else begin
      if (PTotalCst.registro=tiporegistro) and (PTotalCst.cst=ycst)  and
         (PTotalCst.cfop=ycfop) and (PTotalCst.aliicms=yaliqicms) then begin
         achou:=true;
         break;
      end;
    end;
  end;
  if not achou then begin
    New(PTotalCst);
    PTotalCst.registro:=tiporegistro;
    PTotalCst.cst:=ycst;
    PTotalCst.cfop:=ycfop;
    PTotalCst.aliicms:=yaliqicms;
    PTotalCst.vl_opr:=ytotalitem;
    PTotalCst.vl_bc_icms:=ybaseicms;
    PTotalCst.vl_bc_icms_st:=ybaseicmsst;
    PTotalCst.vl_icms:=yvlricms;
    PTotalCst.vl_icms_st:=yvlricmsst;
    PTotalCst.vl_red_bc:=yreducaobase;
    PTotalCst.vl_ipi:=yvlripi;
    ListaTotalCst.Add(PTotalCst);
  end else begin
    PTotalCst.vl_opr:=PTotalCst.vl_opr+ytotalitem;
    PTotalCst.vl_bc_icms:=PTotalCst.vl_bc_icms+ybaseicms;
    PTotalCst.vl_bc_icms_st:=PTotalCst.vl_bc_icms_st+ybaseicmsst;
    PTotalCst.vl_icms:=PTotalCst.vl_icms+yvlricms;
    PTotalCst.vl_icms_st:=PTotalCst.vl_icms_st+yvlricmsst;
    PTotalCst.vl_red_bc:=PTotalCst.vl_red_bc+yreducaobase;
    PTotalCst.vl_ipi:=PTotalCst.vl_ipi+yvlripi;
  end;

end;

// ver se precisa criar
////////////////////////////////////////////////////////////////////////////////////
procedure TFSpedFiscal.AcumulaReg(tiporegistro, ycfop: string;  yvl_icms: currency);
/////////////////////////////////////////////////////////////////////////////////////
//var x:integer;
begin
  if tiporegistro='E110' then begin
    if ListaRegE110.Count=1 then begin
      PRegE110:=ListaRegE110[0];
      if pos( copy(ycfop,1,1),'567'  ) > 0 then
        PRegE110.VL_TOT_DEBITOS:=PRegE110.VL_TOT_DEBITOS+yvl_icms
      else
        PRegE110.VL_TOT_CREDITOS:=PRegE110.VL_TOT_CREDITOS+yvl_icms;
    end else begin
      New(PRegE110);
      if pos( copy(ycfop,1,1),'567'  ) > 0 then begin
        PRegE110.VL_TOT_DEBITOS:=yvl_icms;
        PRegE110.VL_TOT_CREDITOS:=0;
      end else begin
        PRegE110.VL_TOT_CREDITOS:=yvl_icms;
        PRegE110.VL_TOT_DEBITOS:=0;
      end;
      PRegE110.VL_TOT_AJ_DEBITOS:=0;
      PRegE110.VL_ESTORNOS_CRED:=0;
      PRegE110.VL_TOT_CREDITOS:=0;
      PRegE110.VL_AJ_CREDITOS:=0;
      PRegE110.VL_AJ_DEBITOS:=0;
      PRegE110.VL_TOT_AJ_CREDITOS:=0;
      PRegE110.VL_ESTORNOS_DEB:=0;
      PRegE110.VL_SLD_CREDOR_ANT:=0;
      PRegE110.VL_SLD_APURADO:=0;
      PRegE110.VL_TOT_DED:=0;
      PRegE110.VL_ICMS_RECOLHER:=0;
      PRegE110.VL_SLD_CREDOR_TRANSPORTAR:=0;
      ListaRegE110.Add(PRegE110);
    end;

  end else if tiporegistro='E520' then begin

    if ListaRegE520.Count=1 then begin
      PRegE520:=ListaRegE520[0];
      if pos( copy(ycfop,1,1),'56'  ) > 0 then
        PRegE520.VL_DEB_IPI:=PRegE520.VL_DEB_IPI+yvl_icms
      else
        PRegE520.VL_CRED_IPI:=PRegE520.VL_CRED_IPI+yvl_icms;
    end else begin
      New(PRegE520);
      if pos( copy(ycfop,1,1),'56'  ) > 0 then begin
        PRegE520.VL_DEB_IPI:=yvl_icms;
        PRegE520.VL_CRED_IPI:=0;
      end else begin
        PRegE520.VL_CRED_IPI:=yvl_icms;
        PRegE520.VL_DEB_IPI:=0;
      end;
      PRegE520.VL_SD_ANT_IPI:=0;
      PRegE520.VL_OD_IPI:=0;
      PRegE520.VL_OC_IPI:=0;
      PRegE520.VL_SC_IPI:=0;
      PRegE520.VL_SD_IPI:=0;
      ListaRegE520.Add(PRegE520);
    end;
  end;

end;

////////////////////////////////////////////////////////////////////
procedure TFSpedFiscal.SomanoRegistroDoc(tiporegistro, ycst, ycfop: string;
  yaliqicms, ytotalitem, ybaseicms, yvlricms, ybaseicmsst, yvlricmsst,
  yreducaobase, yvlripi: currency);
////////////////////////////////////////////////////////////////////
var p:integer;
    achou:boolean;
begin
  achou:=false;
  for p:=0 to ListaDocumentoCst.Count-1 do begin
    PDocumentoCst:=ListaDocumentoCst[p];
      if (PDocumentoCst.registro=tiporegistro) and (PDocumentoCst.cst=ycst)  and
         (PDocumentoCst.cfop=ycfop) and (PDocumentoCst.aliicms=yaliqicms) then begin
         achou:=true;
         break;
      end;
  end;
  if not achou then begin
    New(PDocumentoCst);
    PDocumentoCst.registro:=tiporegistro;
    PDocumentoCst.cst:=ycst;
    PDocumentoCst.cfop:=ycfop;
    PDocumentoCst.aliicms:=yaliqicms;
    PDocumentoCst.vl_opr:=ytotalitem;
    PDocumentoCst.vl_bc_icms:=ybaseicms;
    PDocumentoCst.vl_bc_icms_st:=ybaseicmsst;
    PDocumentoCst.vl_icms:=yvlricms;
    PDocumentoCst.vl_icms_st:=yvlricmsst;
    PDocumentoCst.vl_red_bc:=yreducaobase;
    PDocumentoCst.vl_ipi:=yvlripi;
    ListaDocumentoCst.Add(PDocumentoCst);
  end else begin
    PDocumentoCst.vl_opr:=PDocumentoCst.vl_opr+ytotalitem;
    PDocumentoCst.vl_bc_icms:=PDocumentoCst.vl_bc_icms+ybaseicms;
    PDocumentoCst.vl_bc_icms_st:=PDocumentoCst.vl_bc_icms_st+ybaseicmsst;
    PDocumentoCst.vl_icms:=PDocumentoCst.vl_icms+yvlricms;
    PDocumentoCst.vl_icms_st:=PDocumentoCst.vl_icms_st+yvlricmsst;
    PDocumentoCst.vl_red_bc:=PDocumentoCst.vl_red_bc+yreducaobase;
    PDocumentoCst.vl_ipi:=PDocumentoCst.vl_ipi+yvlripi;
  end;

end;

// 18.10.12
procedure TFSpedFiscal.BuscaNosItems(xtransacao, xtipomov: string;  xperdesco: currency; var xbaseicms, xvlricms: currency);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var Qi:TSqlQuery;
    xtotalitem,icmsitem:currency;
begin

  Qi:=Sqltoquery('select move_numerodoc,move_unid_codigo,move_esto_codigo,move_qtde,move_venda,move_aliicms from movestoque where move_transacao='+Stringtosql(xtransacao)+
                ' and move_tipomov='+Stringtosql(xtipomov)+
                ' and move_status<>''C''');
  xbaseicms:=0;xvlricms:=0;
  while not Qi.eof do begin

// 20.09.19 - Novicarnes - Ketlen
    if xtipomov = Global.CodCompraMatConsumo then

//      xtotalitem:=FGEral.Arredonda(Qi.fieldbyname('move_qtde').ascurrency*Qi.fieldbyname('move_venda').ascurrency,4)
//      xtotalitem:=FGEral.Arredonda(Qi.fieldbyname('move_qtde').asfloat*Qi.fieldbyname('move_venda').asfloat,6)
      xtotalitem:=Qi.fieldbyname('move_qtde').asfloat*Qi.fieldbyname('move_venda').asfloat

    else

      xtotalitem:=FGEral.Arredonda(Qi.fieldbyname('move_qtde').ascurrency*Qi.fieldbyname('move_venda').ascurrency,2);

    xtotalitem:=xtotalitem - ( xtotalitem*(xperdesco/100) );
    icmsitem:= roundvalor(xtotalitem*(Qi.fieldbyname('move_aliicms').ascurrency/100));
    xbaseicms:=xbaseicms+xtotalitem;
    xvlricms:=xvlricms+icmsitem;
    Qi.Next;

  end;
  FGeral.FechaQuery(Qi);
end;

function TFSpedFiscal.Servico(produto: string): boolean;
////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
var codigofis,tpimposto:string;
begin
  codigofis:=FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,Global.UFUnidade);
  tpimposto:=FCodigosFiscais.GetQualImposto(codigofis);
  result:=tpimposto='S';
end;


end.
