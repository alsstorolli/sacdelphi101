unit spedpiscofins;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrSpedFiscal, StdCtrls, ComCtrls, Mask, SQLEd, Buttons,
  SQLBtn, alabel, SQLGrid, ExtCtrls, ACBrEPCBlocos, ACBrSpedPisCofins, ACBrBase,
  SqlSis, ACBrEPCBloco_D;

type
  TFSpedPisCofins = class(TForm)
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
    ACBrSPEDPisCofins1: TACBrSPEDPisCofins;
    EdReciboanterior: TSQLEd;
    EdFormaapuracao: TSQLEd;
    Edconsfinal: TSQLEd;
    Edtodas: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bExecutarClick(Sender: TObject);
    procedure EdUnid_codigoValidate(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
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
    procedure AcumulaReg(tiporegistro,ycst:string ; ybase,yimposto,yaliquota:currency );
    function EmissaoPropria(xchavenfe:string):boolean;
// 17.10.11
    procedure BuscaNosItems(xtransacao,xtipomov:string;xperdesco:currency;var xvalorpis,xvalorcofins:currency;
              xconsfinal:string='N' ; xrateiofrete:currency=0 ; xconta:integer=0 );
// 04.03.12
    procedure AcumulaporCriterio(yRegistro,yModelo,ystatusreg,yser,ysub,yunid_codigo:string;ynumerodoc,ycfop:integer;
              ydtref:TDatetime;yvalordoc:currency; yconta:string='' );
    procedure AcumulaD201205(yRegistro,yunid_codigo:string;yCSTPIS:TACBrSituacaoTribPIS;yCSTCOFINS:TACBrSituacaoTribCOFINS; yConta:string;
              yvlitem,yvlbc,yaliq,yvlimposto:currency;ydataemissao:TDatetime;ycfop:string;ynumerodoc:integer );
    function TributaCOFINS(ycst:TACBrSituacaoTribCOFINS):boolean;
    function GetCSTCOFINS(ycst:string;ycfop:string='';ycsticms:string=''):TACBrSituacaoTribCOFINS;
    function TributaPIS(ycst:TACBrSituacaoTribPIS):boolean;
    function GetCSTPIS(ycst:string;ycfop:string='';ycsticms:string=''):TACBrSituacaoTribPIS;
// 29.09.2021 - Clessi
    function SituacaoCST( nome:string ) :boolean;

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

type TRegM100=record
   COD_CRED:string;
   IND_CRED_ORI,IND_DESC_CRED:integer;
   VL_BC_PIS,ALIQ_PIS,QUANT_BC_PIS,ALIQ_PIS_QUANT,VL_CRED,VL_AJUS_ACRES,
   VL_AJUS_REDUC,VL_CRED_DIF,VL_CRED_DISP,VL_CRED_DESC,
   SLD_CRED :currency
end;

type TRegD200=record
   COD_MOD,SER,SUB,StatusREg,unid_codigo:string;
   NUM_DOC_INI,NUM_DOC_FIM,CFOP:integer;
   DT_REF:TDATETIME;
   VL_DOC:currency
end;

type TRegD201205=record
   REG,COD_CTA,cfop,unid_codigo:string;
   CSTPis:TACBrSituacaoTribPIS;
   CSTCofins:TACBrSituacaoTribCOFINS;
   VL_ITEM,VL_BC,ALIQ,IMPOSTO:currency;
   Emissao:TDatetime;
   Numerodoc:integer;
end;

type Titens=record
     transacao,tipomov,produto,unidade,estado,cst,natf_codigo:string;
     unitario,qtde,redubase,aliicms,baseicms,valoricms:currency;
end;

// 07.05.20
type  TTRegD100 = record
      TRegD100 : ACBrEPCBloco_D.TRegistroD100;
      Unidade  : string;
end;

var
  FSpedPisCofins: TFSpedPisCofins;
  FormatoMascaraSped,FormatoMascara,CfopsIsentosSaidas,CfopsIsentosEntradas,
  CfopsAquisicaoBensparaRevenda,CfopsAquisicaoBensparaInsumo,
  CfopsAquisicaoServicosparaInsumo,CfopsDevolucaoVendaNaoCumulativa,
  CfopsOutrasEntradascomCredito,CfopsConhecimentoSaida,xcstpis,cstpisNAOEXPORTA, temsocstqnaoexporta
  :string;
  ListaTotalCst,ListaRegM100,ListaDocumentoCst,ListaRegD200,ListaRegD201205,
  ListaItens,
  ListaD100   :TList;
  PTotalCst   :^TTotalCst;
  PDocumentoCst:^TDocumentoCst;
  PRegM100:^TRegM100;
  PRegD200:^TRegD200;
  PRegD201205:^TRegD201205;
  PItens:^Titens;
  ListaCod_Cta,
  ListaDespesasCST53    :TStringList;
  campo                 :TDicionario;
// 07.05.20
  PRegD100              : ^TTRegD100;


const CstSubsTrib:string='010';

implementation

uses Unidades, Geral, SqlFun, SqlExpr , Sittribu, Estoque,
  codigosfis, ACBrEFDBloco_0_Class, ACBrEFDBloco_0, munic, Arquiv,
  sintegra, Natureza, codigosipi,Contnrs, Transp,
  ACBrEPCBloco_0, ACBrEPCBloco_1,
  ACBrEPCBloco_A, ACBrEPCBloco_C, ACBrEPCBloco_F,
  ACBrEPCBloco_M, ACBrEPCBloco_M_Class, ACBrEPCBloco_C_Class,
  ACBrEPCBloco_0_Class, ACBrEPCBloco_D_Class, ACBrEPCBloco_F_Class,
  ACBrEPCBloco_1_Class, spedfiscal, plano;


{$R *.dfm}

function TiraSintegra(s:string):string;
//////////////////////////////////////////
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

function TributaConsumidorFinal(xcons:string):boolean;
////////////////////////////////////////
begin
//   if (FSpedPisCofins.EdConsfinal.text='S') and (xcons='S') then
//     result:=true
//   else if (FSpedPisCofins.EdConsfinal.text='S') and (xcons='N') then
//     result:=true
//   else
// 25.10.16 - sempre tributa..ate q mudem....
     result:=true;
end;


{ TFSpedPisCofins }
////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////
procedure TFSpedPisCofins.AcumulaReg(tiporegistro,ycst:string ; ybase,yimposto,yaliquota:currency );
///////////////////////////////////////////////////////////////////////////////////////////
var x:integer;
    achou:boolean;
    xtipocredito:string;

    function GetTipoCredito(wcst:string):string;
    ////////////////////////////////////////////
    begin
      if pos(wcst,'50,51,52,53,54,55,56,60,61,62,63,64,65,66')>0 then
        result:='101'
      else
        result:='201'
//        result:='301'  // ver quando for exportacao
    end;
begin

///////////////////////////////////////////////////
  if tiporegistro='M100' then begin
    achou:=false;
    xtipocredito:=GetTipoCredito(ycst);
    for x:=0 to ListaRegM100.Count-1 do begin
      PRegM100:=ListaRegM100[x];
      if PRegM100.COD_CRED=xtipocredito then begin
        achou:=true;
        break;
      end;
    end;
    if achou then begin
      PRegM100.VL_BC_PIS:=PRegM100.VL_BC_PIS+ybase;
    end else begin
      New(PRegM100);
      PRegM100.COD_CRED:=xtipocredito;
      PRegM100.VL_BC_PIS:=ybase;
//      PRegM100.IND_CRED_ORI:=icoOperProprias;
      PRegM100.IND_CRED_ORI:=0;
//      PRegM100.IND_DESC_CRED:=idcTotal;
      PRegM100.IND_DESC_CRED:=0;
      PRegM100.ALIQ_PIS:=yaliquota;
      PRegM100.QUANT_BC_PIS:=0;
      PRegM100.ALIQ_PIS_QUANT:=0;
      PRegM100.VL_CRED:=0;
      PRegM100.VL_AJUS_ACRES:=0;
      PRegM100.VL_AJUS_REDUC:=0;
      PRegM100.VL_CRED_DIF:=0;
      PRegM100.VL_CRED_DISP:=PRegM100.VL_CRED+PRegM100.VL_AJUS_ACRES-PRegM100.VL_AJUS_REDUC-PRegM100.VL_CRED_DIF;
//      if PRegM100.IND_DESC_CRED:=idcTotal then
      if PRegM100.IND_DESC_CRED=0 then
        PRegM100.VL_CRED_DESC:=PRegM100.VL_CRED_DISP  // ver este 'total e parcial'
      else
        PRegM100.VL_CRED_DESC:=PRegM100.VL_CRED_DISP;
      PRegM100.SLD_CRED:=PRegM100.VL_CRED_DISP-PRegM100.VL_CRED_DESC;
      ListaRegM100.Add(PRegM100);
    end;
{

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
 }


  end;
///////////////////////////////////////////////////

end;

procedure TFSpedPisCofins.Execute;
//////////////////////////////////////////////
begin
  if EdInicio.isempty then begin
    Edinicio.Setdate(Sistema.Hoje);
    EdTermino.setdate(Sistema.hoje);
  end;
//  EdUnidades.Enabled:=Global.Topicos[1015];
//  EdUnidades.text:=Global.Usuario.UnidadesMvto;
//  FUnidades.SetaItems(EdUnidades,nil,Global.Usuario.UnidadesMvto);
  campo:=Sistema.GetDicionario('plano','plan_cstpiscofins');
  FGeral.ConfiguraColorEditsNaoEnabled(FSpedPisCofins );
  Show;


end;

procedure TFSpedPisCofins.FormActivate(Sender: TObject);
///////////////////////////////////////////////////
begin
  if trim(EdUnid_codigo.text)='' then
    EdUnid_codigo.text:=Global.CodigoUnidade;
  EdInicio.setfocus;

end;

function TFSpedPisCofins.FormataClassificacao(  Classificacao: String): String;
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

function TFSpedPisCofins.FormataClassificacaoSped(  Classificacao: String): String;
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

procedure TFSpedPisCofins.GeraBlocoC;
///////////////////////////////////////
begin
   with ACBrSpedPisCofins1.Bloco_C do
   begin
      with RegistroC001New do
      begin
         IND_MOV := imComDados;
      end;
   end;

end;

// 13.10.17
//////////////////////////////////////////////////////////
procedure TFSpedPisCofins.GeraRegistro500;
//////////////////////////////////////////////////////
var QPlanx:TSqlquery;
    whereempresa,classf,ind_cta,cod_cta_sup :string;
    nnivel,p:integer;
    ctadespesa:integer;
    ListaClassificacao:TStringList;
begin

//  whereempresa:=' where pcon_empr_codigo='+stringtosql(copy(xUni,2,2));
  QPlanX:=FGeral.SqlToQueryContax(' select * from planocon '+
//                            whereempresa+
                            ' order by pcon_classificacao ');
  ListaClassificacao:=TStringList.Create;

  while not QPlanX.Eof do begin

   if ListaCod_CTA.indexof(QPlanx.fieldbyname('pcon_conta').asstring)<>-1 then begin

    if ListaClassificacao.IndexOf(QPlanX.Fieldbyname('pcon_classificacao').AsString)=-1 then begin

    ListaClassificacao.Add(QPlanX.Fieldbyname('pcon_classificacao').AsString);

    with ACBrSpedPisCofins1.Bloco_0.Registro0500New do begin

           DT_ALT:=QPlanx.fieldbyname('pcon_dataincalteracao').asdatetime;
           classf := FSPedFiscal.FormataClassificacao(QPlanX.Fieldbyname('pcon_classificacao').AsString);
           if QPlanX.fieldbyname('pcon_tipo').asstring='AA' then begin
             IND_CTA:=indCTAnalitica;
           end else  begin
             IND_CTA:=indCTASintetica;
           end;
            nnivel := 1;
            cod_cta_sup:= '';
            if length(classf) = 1 then cod_cta_sup := '' else begin
              for p := Length(classf) downto 1 do begin
                if ((classf[p]) = '.') then begin
                  cod_cta_sup := substr(classf,1,p-1);
                  Break;
                end;
              end;
            end;
            if length(classf) = 1 then nnivel := 1 else begin
              for p := 1 to Length(classf) do begin
                if ((classf[p]) = '.') then nnivel := nnivel+1;
              end;
            end;
            if QPlanx.FieldByName('pcon_spednaturezaconta').AsString='01' then
              COD_NAT_CC:=ncgAtivo
            else if QPlanx.FieldByName('pcon_spednaturezaconta').AsString='02' then
              COD_NAT_CC:=ncgPassivo
            else if QPlanx.FieldByName('pcon_spednaturezaconta').AsString='03' then
              COD_NAT_CC:=ncgLiquido
            else if QPlanx.FieldByName('pcon_spednaturezaconta').AsString='04' then
              COD_NAT_CC:=ncgResultado
            else if QPlanx.FieldByName('pcon_spednaturezaconta').AsString='05' then
              COD_NAT_CC:=ncgCompensacao
            else
              COD_NAT_CC:=ncgOutras;

            NIVEL:=inttostr(nnivel);
//            COD_CTA:= classf;
            COD_CTA:= QPlanX.Fieldbyname('pcon_classificacao').AsString;
            NOME_CTA:=QPlanX.Fieldbyname('pcon_descricao').asstring;
            // Plano de Contas Referencial.
            classf := FormataClassificacaoSped(QPlanX.Fieldbyname('pcon_planorefsped').AsString);
            COD_CTA_REF:= classf;
            CNPJ_EST:='';


    end;

    end;

   end;

   QPlanX.Next;
  end;

  QPlanX.Close;
  ListaClassificacao.Free;
end;



function TFSpedPisCofins.GetNumerodoEndereco(endereco: string;
  codigo: integer; mensagem: string): string;
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

function TFSpedPisCofins.Posicao2num(endereco: string): integer;
///////////////////////////////////////////////////////////////////
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

/////////////////////////////////////////////////////////////////////////////////
// 29.09.2021 - Clessi
function TFSpedPisCofins.SituacaoCST(nome: string): boolean;
///////////////////////////////////////////////////////////
begin

   result :=( AnsiPos( nome,Uppercase(Global.NomeUnidade) ) > 0 );

end;

procedure TFSpedPisCofins.SomanoRegistro(tiporegistro, ycst, ycfop: string;
  yaliqicms, ytotalitem, ybaseicms, yvlricms, ybaseicmsst, yvlricmsst,
  yreducaobase, yvlripi: currency);
/////////////////////////////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////////////////////
procedure TFSpedPisCofins.SomanoRegistroDoc(tiporegistro, ycst,
  ycfop: string; yaliqicms, ytotalitem, ybaseicms, yvlricms, ybaseicmsst,
  yvlricmsst, yreducaobase, yvlripi: currency);
////////////////////////////////////////////////////////////////////////////
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

///////////////////////////////////////////////////////////////
procedure TFSpedPisCofins.bExecutarClick(Sender: TObject);
///////////////////////////////////////////////////////////////
type TParticipa=record
  codigo,codigosac:integer;
  tipocad:string;
end;
type TUnidades=record
  codigo:integer;
  descricao:string;
end;
type  TipoC100=record
    ttransacao:string;
    IND_OPER:TACBrTipoOperacao;
    IND_EMIT:TACBrEmitente;
    COD_MOD,NUM_DOC,CHV_NFE,COD_PART,SER,Exporta:string;
//    COD_SIT:TACBrSituacaoDocto;
// 25.02.13
    COD_SIT:TACBrCodSit;
    DT_DOC,DT_E_S:TDateTime;
    VL_DOC,VL_DESC,VL_MERC,VL_FRT,VL_SEG,VL_OUT_DA,VL_BC_ICMS,VL_ICMS,VL_BC_ICMS_ST,VL_ICMS_ST,VL_IPI,
    VL_PIS,VL_COFINS,VL_PIS_ST,VL_COFINS_ST:currency;
    IND_PGTO:TACBrTipoPagamento;
    IND_FRT:TACBrTipoFrete;
end;

type  TipoC170=record
    ttransacaoc100:string;
    NUM_ITEM,COD_ITEM,DESCR_COMPL,UNID,CFOP,COD_NAT,COD_ENQ,COD_CTA:string;
    QTD,VL_ITEM,VL_DESC,VL_BC_ICMS,ALIQ_ICMS,VL_ICMS,VL_BC_ICMS_ST,ALIQ_ST,VL_ICMS_ST,VL_BC_IPI,ALIQ_IPI,
    VL_IPI,VL_BC_PIS,ALIQ_PIS_PERC,VL_PIS,VL_BC_COFINS,ALIQ_COFINS_PERC,VL_COFINS:currency;
    IND_MOV:TACBrMovimentacaoFisica;
    CST_ICMS:TACBrSituacaoTribICMS;
    IND_APUR:TACBrApuracaoIPI;
    CST_PIS:TACBrSituacaoTribPIS;
    cST_COFINS:TACBrSituacaoTribCOFINS;
    CST_IPI:TACBrSituacaoTribIPI;
end;

// 10.04.17 - para o registro 0400
type TCod_Nat=record
     cod_nat,descr_nat,cfop:string;
end;

// 18.10.17 - para o cod_cta nos registros detalhe
type TCod_Cta=record
     contadespesa,pcon_conta:integer;
     pcon_classif,pcon_classifref:string;
end;

var NumSerieCertificado,SqlUNidades,linha,tiposnao,SqlunidadesDet,nomearq,es,
    cfop,situacaonota,x,codigofiscal,cfop50,cfop54,xcst,codmuniemitente,codigopais,
    numero,ModelosRegistroC100,ModelosRegistroPadrao,ModelosRegistroC140,
    ModelosRegistroC160,ModelosRegistroC170,ConsumidorFinal,PessoaFisica,
    sqlcfopssim,
    cstpiscofins
    :String;
    aliqsicms,numcfops,p,regsbloco0,contitem,NRegD100,NRegD500,NRegD010,NRegD200,i,NRegA100:integer;
    Q,QMovbase,QGeral,QE,QPend,QTransp,
    QUnidades,QItens,QPlanx,
    QReg11001500                    :TSqlquery;
    ListaAliquotas,ListaBases,ListaCfops,
    ListaCSTs,Lista75,Lista75aux,
    ListaTodosCfops,Lista,ListaD010 :TStringlist;
    isentas,outras,valornota,vlricms,aliqicms,perdesco,aliqmovb,totalitem,
    valoripi,basecalculo,redubase,redubasemestre,baseicmsst,vlrdesco,vlracres,vlrfrete,
    valoricmsst,rateioicmsst,valoricmsstitem,aliicms,alipis,alicofins:currency;
    baseicms,baseacumulada,basetotal,icmsacumulado,
    perrateiofrete,vlrfreteitem:extended;

    ListaParticipantes,ListaUnidades,ListaC100,ListaC170,ListaCod_Nat,ListaPlanoCon
    :TList;
    PParticipa,PParti:^TParticipa;
    PUnidades:^TUnidades;
    DataNota:TDatetime;
    xcst_pis:TACBrSituacaoTribPIS;
    xcst_cofins:TACBrSituacaoTribCOFINS;
    PC100:^TipoC100;
    PC170:^TipoC170;
    PCod_Nat:^TCod_Nat;
    PCod_Cta:^TCod_Cta;
    OK:boolean;
    classf,ind_cta,cod_cta_sup :string;
    nnivel,
    px,
    mes,
    ano,
    tem11001500                  :integer;

const ModeloNfe:string='55';
      ModelosnaoGeraItem:string='06;22';


    //////////////////////////////////////////
    function GetModelo(tipomov:string):string;
    //////////////////////////////////////////
//modelo de documento fiscal     01 - nf modelo 1 ou 1A     02 - nf venda consumidor modelo 2
//                               04 - nf produtor   e MAIS UM MONTE...
    begin
      result:='01';
// 21.01.10 - nfe
      if ( ( Q.fieldbyname('moes_dtnfecanc').AsDateTime>1 ) or
         ( Q.fieldbyname('moes_dtnfeauto').AsDateTime>1 ) ) and
         (  NumSerieCertificado<>'' )  and
// 14.01.2021
         (  COPY(Uppercase(Q.fieldbyname('moes_especie').AsString),1,3) = 'NFE' )
         then
         result:='55'
// 14.03.16
//      else if (Q.fieldbyname('moes_xmlnfet').AsString<>'' ) and
// 30.09.2021 - Clessi
      else if (Q.fieldbyname('moes_chavenfe').AsString<>'' ) then begin

         result:='55';
// 08.12.2021  - Come�ou a importar xml de servi�os com chave...
         if (  COPY(Uppercase(Q.fieldbyname('moes_especie').AsString),1,3) = 'NFS' ) then

           result:='PS'

         else

// 11.08.17
             if pos(tipomov,Global.CodConhecimento+';'+Global.CodConhecimentoSaida)>0 then result:='57';
//
      end else if pos(tipomov,Global.CodConhecimento+';'+Global.CodConhecimentoSaida)>0 then begin
        result:='08';
// 29.07.10 - Clessi
        if uppercase(Q.fieldbyname('moes_especie').AsString)='CTE' then
          result:='57';
// 25.04.12
      end else if pos(tipomov,Global.CodPrestacaoServicos)>0 then begin
        result:='PS';
// 11.00.13 - para nao gerar no C170...
      end else if pos(tipomov,Global.CodPrestacaoServicosE)>0 then begin
        result:='PA';
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
//      else  if Q.fieldbyname('moes_tipomov').AsString=Global.CodCompraProdutor then
// 09.01.18
      else  if Pos( Q.fieldbyname('moes_tipomov').AsString,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor )>0 then
          result:='04'
// 25.10.19  - Novicarnes - sped fiscal
      else  if Q.fieldbyname('moes_especie').AsString='NFAE' then
          result:='1B'

      else  if (uppercase(copy(Q.fieldbyname('moes_especie').AsString,1,2))='NF') and (copy(Q.FieldByName('moes_serie').asstring,1,1)='1') then
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
    //////////////////////////////////////
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
    ///////////////////////////////////////////
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
      if pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModelosnaoGeraItem ) >0 then
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


///////////////////////////////////////////////////////
    function GetCSTIcms(ycst:string):TACBrSituacaoTribICMS;
///////////////////////////////////////////////////////
    begin
      result:=sticmsTributadaIntegralmente;
      if ycst='000' then
        result:=sticmsTributadaIntegralmente
      else if ycst='010'  then //	Tributada e com cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsTributadaComCobracaPorST
      else if ycst='020'  then //	Com redu��o de base de c�lculo
        result:=sticmsComReducao
      else if ycst='030' then  //	Isenta ou n�o tributada e com cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsIsentaComCobracaPorST
      else if ycst='040' then //	Isenta
        result:=sticmsIsenta
      else if ycst='041' then //	N�o tributada
        result:=sticmsNaoTributada
      else if ycst='050' then //	Suspens�o
        result:=sticmsSuspensao
      else if ycst='051' then //	Diferimento
        result:=sticmsDiferimento
      else if ycst='060' then //	ICMS cobrado anteriormente por substitui��o tribut�ria
        result:=sticmsCobradoAnteriormentePorST
      else if ycst='070' then //	Com redu��o de base de c�lculo e cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsComReducaoPorST
      else if ycst='090' then //	Outros
        result:=sticmsOutros
      else if ycst='100' then // Estrangeira - Importa��o direta - Tributada integralmente
        result:=sticmsEstrangeiraImportacaoDiretaTributadaIntegralmente
      else if ycst='110' then // Estrangeira - Importa��o direta - Tributada e com cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsEstrangeiraImportacaoDiretaTributadaComCobracaPorST

      else if ycst='120' then // Estrangeira - Importa��o direta - Com redu��o de base de c�lculo
        result:=sticmsEstrangeiraImportacaoDiretaComReducao

      else if ycst='130' then // Estrangeira - Importa��o direta - Isenta ou n�o tributada e com cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsEstrangeiraImportacaoDiretaIsentaComCobracaPorST

      else if ycst='140' then // Estrangeira - Importa��o direta - Isenta
        result:=sticmsEstrangeiraImportacaoDiretaIsenta

      else if ycst='141' then // Estrangeira - Importa��o direta - N�o tributada
        result:=sticmsEstrangeiraImportacaoDiretaNaoTributada

      else if ycst='150' then // Estrangeira - Importa��o direta - Suspens�o
        result:=sticmsEstrangeiraImportacaoDiretaSuspensao

      else if ycst='151' then // Estrangeira - Importa��o direta - Diferimento
        result:=sticmsEstrangeiraImportacaoDiretaDiferimento

      else if ycst='160' then // Estrangeira - Importa��o direta - ICMS cobrado anteriormente por substitui��o tribut�ria
        result:=sticmsEstrangeiraImportacaoDiretaCobradoAnteriormentePorST

      else if ycst='170' then // Estrangeira - Importa��o direta - Com redu��o de base de c�lculo e cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsEstrangeiraImportacaoDiretaComReducaoPorST

      else if ycst='190' then // Estrangeira - Importa��o direta - Outras
        result:=sticmsEstrangeiraImportacaoDiretaOutros

      else if ycst='200' then // Estrangeira - Adquirida no mercado interno - Tributada integralmente
        result:=sticmsEstrangeiraAdqMercIntTributadaIntegralmente

      else if ycst='210' then // Estrangeira - Adquirida no mercado interno - Tributada e com cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsEstrangeiraAdqMercIntTributadaComCobracaPorST

      else if ycst='220' then // Estrangeira - Adquirida no mercado interno - Com redu��o de base de c�lculo
        result:=sticmsEstrangeiraAdqMercIntComReducao

      else if ycst='230' then // Estrangeira - Adquirida no mercado interno - Isenta ou n�o tributada e com cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsEstrangeiraAdqMercIntIsentaComCobracaPorST

      else if ycst='240' then // Estrangeira - Adquirida no mercado interno - Isenta
        result:=sticmsEstrangeiraAdqMercIntIsenta

      else if ycst='241' then // Estrangeira - Adquirida no mercado interno - N�o tributada
        result:=sticmsEstrangeiraAdqMercIntNaoTributada

      else if ycst='250' then // Estrangeira - Adquirida no mercado interno - Suspens�o
        result:=sticmsEstrangeiraAdqMercIntSuspensao

      else if ycst='251' then // Estrangeira - Adquirida no mercado interno - Diferimento
        result:=sticmsEstrangeiraAdqMercIntDiferimento

      else if ycst='260' then // Estrangeira - Adquirida no mercado interno - ICMS cobrado anteriormente por substitui��o tribut�ria
        result:=sticmsEstrangeiraAdqMercIntCobradoAnteriormentePorST

      else if ycst='270' then // Estrangeira - Adquirida no mercado interno - Com redu��o de base de c�lculo e cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsEstrangeiraAdqMercIntComReducaoPorST

      else if ycst='290' then // Estrangeira - Adquirida no mercado interno - Outras
        result:=sticmsEstrangeiraAdqMercIntOutros

      else if ycst='101' then // Simples Nacional - Tributada pelo Simples Nacional com permiss�o de cr�dito
        result:=sticmsSimplesNacionalTributadaComPermissaoCredito

      else if ycst='270' then // Estrangeira - Adquirida no mercado interno - Com redu��o de base de c�lculo e cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsEstrangeiraAdqMercIntComReducaoPorST

      else if ycst='290' then // Estrangeira - Adquirida no mercado interno - Outras
        result:=sticmsEstrangeiraAdqMercIntOutros

      else if ycst='102' then // Simples Nacional - Tributada pelo Simples Nacional sem permiss�o de cr�dito
        result:=sticmsSimplesNacionalTributadaSemPermissaoCredito

      else if ycst='103' then // Simples Nacional - Isen��o do ICMS no Simples Nacional para faixa de receita bruta
        result:=sticmsSimplesNacionalIsencaoPorFaixaReceitaBruta

      else if ycst='102' then // Simples Nacional - Tributada pelo Simples Nacional sem permiss�o de cr�dito
        result:=sticmsSimplesNacionalTributadaSemPermissaoCredito

      else if ycst='201' then // Simples Nacional - Tributada pelo Simples Nacional com permiss�o de cr�dito e com cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsSimplesNacionalTributadaComPermissaoCreditoComST

      else if ycst='202' then // Simples Nacional - Tributada pelo Simples Nacional sem permiss�o de cr�dito e com cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsSimplesNacionalTributadaSemPermissaoCreditoComST

      else if ycst='201' then // Simples Nacional - Tributada pelo Simples Nacional com permiss�o de cr�dito e com cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsSimplesNacionalTributadaComPermissaoCreditoComST

      else if ycst='202' then // Simples Nacional - Tributada pelo Simples Nacional sem permiss�o de cr�dito e com cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsSimplesNacionalTributadaSemPermissaoCreditoComST

      else if ycst='203' then // Simples Nacional - Isen��o do ICMS no Simples Nacional para faixa de receita bruta e com cobran�a do ICMS por substitui��o tribut�ria
        result:=sticmsSimplesNacionalIsencaoPorFaixaReceitaBrutaComST

      else if ycst='300' then // Simples Nacional - Imune
        result:=sticmsSimplesNacionalImune

      else if ycst='400' then // Simples Nacional - N�o tributada pelo Simples Nacional
        result:=sticmsSimplesNacionalNaoTributada

      else if ycst='500' then // Simples Nacional - ICMS cobrado anteriormente por substitui��o tribut�ria (substitu�do) ou por antecipa��o
        result:=sticmsSimplesNacionalCobradoAnteriormentePorST

      else if ycst='900' then // Simples Nacional - Outros
        result:=sticmsSimplesNacionalOutros
    end;

    ///////////////////////////////////////////////////////
    function GetCSTIPI(ycst:string):TACBrSituacaoTribIPI;
    ///////////////////////////////////////////////////////
    begin
      result:=stipiEntradaRecuperacaoCredito;
      if ycst='00' then
        result:=stipiEntradaRecuperacaoCredito
      else if ycst='01' then // Entrada tributada com al�quota zero
        result:=stipiEntradaTributradaZero
      else if ycst='02' then // Entrada isenta
        result:=stipiEntradaIsenta
      else if ycst='03' then // Entrada n�o-tributada
        result:=stipiEntradaNaoTributada
      else if ycst='04' then // Entrada imune
        result:=stipiEntradaImune
      else if ycst='05' then // Entrada com suspens�o
        result:=stipiEntradaComSuspensao
      else if ycst='49' then // Outras entradas
        result:=stipiOutrasEntradas
      else if ycst='50' then // Sa�da tributada
        result:=stipiSaidaTributada
      else if ycst='51' then // Sa�da tributada com al�quota zero
        result:=stipiSaidaTributadaZero
      else if ycst='52' then // Sa�da isenta
        result:=stipiSaidaIsenta
      else if ycst='53' then // Sa�da n�o-tributada
        result:=stipiSaidaNaoTributada
      else if ycst='54' then // Sa�da imune
        result:=stipiSaidaImune
      else if ycst= '55' then // Sa�da com suspens�o
        result:=stipiSaidaComSuspensao
      else if ycst='99' then // Outras sa�das
        result:=stipiOutrasSaidas;
    end;

    ///////////////////////////////////////////////////////
    function TributaIPI(ycst:TACBrSituacaoTribIPI):boolean;
    ///////////////////////////////////////////////////////
    begin
      result:=false;
      if ycst in [ stipiEntradaRecuperacaoCredito,stipiSaidaTributada ] then
        result:=true;
    end;


 // 09.01.17 - > 10.04.17
    function GetCod_Nat(xcfop:string):string;
    ////////////////////////////////////////////
    var n:integer;
        achou:boolean;
    begin
      achou:=false;
      for n:=0 to ListaCod_Nat.Count-1 do begin
        PCod_Nat:=ListaCod_Nat[n];
        if PCod_Nat.cfop=xcfop then begin
          result:=PCod_Nat.cod_nat;
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
        New(PCod_Nat);
        PCod_Nat.cod_nat:=strzero(LIstacod_nat.Count+1,10);
        PCod_Nat.descr_nat:=FNatureza.GetDescricao(xcfop);
        PCod_Nat.cfop:=xcfop;
        Listacod_Nat.Add(Pcod_Nat);
        result:=Pcod_Nat.cod_nat;
      end;
    end;

// 20.05.17
   function GetBaseitens(ttransacao:string):currency;
   /////////////////////////////////////////////////
   var i:integer;
   begin
      result:=0;
      for i:=0 to ListaItens.Count-1 do begin
        PItens:=ListaItens[i];
        if PItens.transacao=ttransacao then begin
          result:=result+FGeral.Arredonda( PItens.baseicms,2 );
//          result:=result+PItens.baseicms;
        end;
      end;
   end;

// 17.10.17
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
           Texto.LInes.Add('Reduzido '+inttostr(xcontareduzida)+' n�o encontrado no plano de contas');

    end;


// 17.10.17
    procedure GetPlanocon(xuni:string);
    ///////////////////////////////////////////////////////////////////////
    var QP:TSqlquery;
        whereempresa:string;
    begin
// 12.01.18 - no sac unidade 003 porem na contab empresa 01...devido a mudan�a de
//            capeg para vidanova
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


   // 17.10.17
   function GetCod_Cta(xtipomov,xunidade:string ; xconfmov:integer):string;
   ////////////////////////////////////////////////////////////////////////
   var Qx,
       QContab:TSqlquery;
       xconta:integer;
   begin
     xconta:=0;
     {
     if xconfmov>0 then begin
       Qx:=sqltoquery('select * from confmov where comv_codigo = '+inttostr(xconfmov));
       if not Qx.eof then begin
          if pos( xtipomov,Global.TiposSaida ) > 0 then
            xconta:=Qx.fieldbyname('Comv_credito').asinteger
          else
            xconta:=Qx.fieldbyname('Comv_debito').asinteger;
       end;
       FGeral.FechaQuery(QX);
     end;
     }
// 02.08.19
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
// 05.11.19  - Novicarnes = ketlen
          if xtipomov = Global.CodTransfEntrada then
             xconta:=Qx.fieldbyname('Unid_transentrada').asinteger;
        end;

     end;
     if xconta>0 then begin
        result:=GetCod_CtaPcon(xconta);
        if ListaCod_cta.indexof(inttostr(xconta))=-1 then
           ListaCod_Cta.Add( inttostr(xconta) );

     end  else result:='';


   end;


var valorpis,valorcofins:currency;


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
// 15.12.16
  if not FGeral.ConectaContax then begin
     Avisoerro('N�o foi poss�vel conectar com a contabilidade. Registro 0500 n�o ser� gerado !!');
//     exit;
  end;
// 13.02.19 - Vida Nova
  if EdTodas.Text = 'N' then

     cstpisNAOEXPORTA:='70;71;72;73;74;75;76;77;78;79;80;81;82;83;84;85;86;87;88;90;98;99'

  else
// 19.10.18 - retirado
     cstpisNAOEXPORTA:='';

  temsocstqnaoexporta:='N';

  if not confirma('Confirma gera��o do arquivo do Sped Fiscal ref. Pis/Cofins ?') then exit;

  texto.clear;
  ModelosRegistroPadrao:='01;1B;04;55';
  ModelosRegistroC100:=ModelosRegistroPadrao;
  ModelosRegistroC140:='01';
  ModelosRegistroC160:='01;04';
  ModelosRegistroC170:=ModelosRegistroPadrao;
  ListaTotalCst:=TList.create;
  ListaRegM100:=TList.create;
  ListaRegD200:=TList.create;
  ListaRegD201205:=TList.create;
  ListaCod_Nat:=TList.create;
  FormatoMascaraSped:='';
  FormatoMascara:='';
  CfopsAquisicaoBensparaRevenda:='1102;1113;1117;1118;1121;1251;1403;1652;2102;2113;2117;'+
                                 '2118;2121;2251;2403;2652;3102;3251;3652';
  CfopsAquisicaoBensparaInsumo:='1101;1111;1116;1120;1122;1126;1128;1401;1407;1556;1651;'+
                                '1653;2101;2111;2116;2120;2122;2126;2128;2401;2407;2556;'+
                                '2651;2653;3101;3126;3128;3556;3651;3653';
  CfopsAquisicaoServicosparaInsumo:='1124;1125;1933;2124;2125;2933';
  CfopsDevolucaoVendaNaoCumulativa:='1201;1202;1203;1204;1410;1411;1660;1661;1662;2201;'+
                                    '2202;2410;2411;2660;2661;2662';
  CfopsOutrasEntradascomCredito:='1922;2922';
  CfopsConhecimentoSaida:='5352/6352/5351/6351/5932/6932';
  CfopsIsentosEntradas:=FGeral.GetConfig1AsString('Cfopspiscofinse');
  CfopsIsentosSaidas:=FGeral.GetConfig1AsString('Cfopspiscofinss');
// 19.10.18
  ListaDespesasCST53:=TStringList.Create;
  if FileExists( 'ListaDespesasCST53.txt' ) then begin
     try
        ListaDespesasCST53.LoadFromFile( 'ListaDespesasCST53.txt' );
     except
        Avisoerro('N�o foi poss�vel ler o arquivo ListaDespesasCST53.txt');
        exit;
     end;
  end;

/////////////
    nomearq:='SFPISCOFINS'+EdUnid_codigo.text+copy(EdTermino.text,3,4)+'.TXT';
    ACBrSPEDPisCofins1.DT_INI:=EdInicio.asdate;
    AcbrSpedPisCofins1.DT_FIN:=EdTermino.asdate;
    AcbrSpedPisCofins1.Path:=ExtractFilePath(Application.ExeName);
    AcbrSpedPisCofins1.Arquivo:=nomearq;

// abrir os blocos 'sem dados' e depois muda para 'com dados' se for o caso
// Abertura Bloco A - ref. ISS - notas de servicos = serie F
  with AcbrSpedPisCofins1.Bloco_A do begin
    LimpaRegistros;
    with RegistroA001New do begin
      IND_MOV:=imSemDados;
    end;
  end;
// Abertura Bloco D - conhecimentos de transporte e outros...
  with AcbrSpedPisCofins1.Bloco_D do begin
    LimpaRegistros;
    with RegistroD001New do begin
      IND_MOV:=imSemDados;
    end;
  end;
// 07.05.20
  ListaD100 := TList.Create;

// Abertura Bloco M - apuracao do pis/cofins
////////////////////////////////////////
//   18.10.11 - por enquanto nao gera...'complicadissimo'
//              gerar dentro do proprio validador
//{
  with AcbrSpedPisCofins1.Bloco_M do begin
        with RegistroM001New do begin
          IND_MOV:=imSemDados;
        end;
        with RegistroM100New do begin
          DT_INI:=EdInicio.AsDate;
          DT_FIN:=EdTermino.AsDate;
        end;
        with RegistroM500New do begin
          DT_INI:=EdInicio.AsDate;
          DT_FIN:=EdTermino.AsDate;
        end;
  end;
//}

/////////////
  sistema.beginprocess('Pesquisando conhecimentos');
  NumSerieCertificado:=trim( FGeral.GetConfig1AsString('NumSerieCert') );

  Sqlunidades:=' and moes_unid_codigo='+EdUnid_codigo.assql;
//  if Global.Topicos[1015] then
  if not EdUnidades.isempty then
     Sqlunidades:=FGeral.GetIN('unid_codigo',EdUnidades.text,'C');
  QUnidades:=Sqltoquery('select * from unidades where '+sqlunidades+' order by unid_codigo');
//    Sqlunidades:=' and '+FGeral.GetIN('moes_unid_codigo',EdUnidades.text,'C');
//////////////////////////////////////////////////////////////////////////////////////
// 12.08.13 - aqui
  ListaD010:=TStringList.create;
  NRegD010:=0;

  ListaCod_Cta:=TStringList.Create;
// 08.02.19 - Ketlen - Novicarnes
  ListaParticipantes:=TList.create;

  WHILE NOT QUnidades.Eof DO BEGIN
//////////////////////////////////////////////////////////////////////////////////////
  Sqlunidades:=' and moes_unid_codigo='+Stringtosql(QUnidades.fieldbyname('unid_codigo').asstring);
  ListaTodosCfops:=TStringlist.create;
//  ListaParticipantes:=TList.create;
  ListaUnidades:=TList.create;
  Lista:=TStringList.create;

// 18.10.17
  ListaPlanocon:=TList.Create;
// 14.01.2021 - enviar o codigo da empresa na contabilidade
  if QUnidades.fieldbyname('Unid_empresa1').asinteger > 0 then

     GetPlanocon( strzero( QUnidades.fieldbyname('Unid_empresa1').asinteger,3) )

  else

     GetPlanocon( QUnidades.fieldbyname('unid_codigo').asstring );

  Q:=sqltoquery('select * from movesto'+
                ' inner join natureza on (natf_codigo=moes_natf_codigo)'+
                ' where '+FGeral.Getin('moes_status','N','C')+' and moes_datamvto>='+EdInicio.assql+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and '+FGeral.Getin('moes_tipomov',Global.CodConhecimento+';'+Global.CodConhecimentoSaida,'C')+
                ' and moes_datacont is not null'+
                sqlunidades+
                ' and moes_natf_codigo is not null'+
                ' order by moes_datamvto,moes_numerodoc' );
  NRegD100:=0;NRegD500:=0;NRegD200:=0;
// 10.10.2011 - identificar estabelecimento que teve conhecimento na entrada
  if not Q.eof then begin
// Abertura Bloco D - conhecimentos de transporte e outros...
    with AcbrSpedPisCofins1.Bloco_D do begin
      with RegistroD001New do begin
        IND_MOV:=imComDados;
      end;
    end;
////////////// 07.08.13

//    if NRegD010=0 then begin  // 07.05.20 - Novicarnes - Ketlen cte na filial 002 vai na 001
      with AcbrSpedPisCofins1.Bloco_D do begin
//        if ListaD010.indexof(QUnidades.fieldbyname('unid_cnpj').asstring)=-1 then begin
// 05.05.20 - Novicarnes - Ketlen pegou cte gerada na unidade errada porem com o participante na certa
        if ListaD010.indexof(Q.fieldbyname('moes_unid_codigo').asstring)=-1 then begin
          with RegistroD010New do begin
//            CNPJ:=QUnidades.fieldbyname('unid_cnpj').asstring;
            CNPJ := FUnidades.GetCnpjcpf( Q.fieldbyname('moes_unid_codigo').asstring);
            ListaD010.add(Q.fieldbyname('moes_unid_codigo').asstring);
            inc(NRegD010);
          end;
        end;
      end;
//    end;

////////////////////
  end;  // q.eof dos conhecimentos


// Geracao dos conhecimentos de transporte 'aquisicao' e emissao


  while not Q.eof do begin

      QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(q.fieldbyname('moes_transacao').asstring)+
                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('moes_tipomov').asstring));

      datanota:=Q.fieldbyname('moes_datamvto').asdatetime;

      IncluiParticipa( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring );


     with AcbrSpedPisCofins1.Bloco_D do begin

       vlrdesco:=FGeral.Arredonda(Q.FieldByName('moes_totprod').AsCurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100),2);
       if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin
          es:='E';
       end else begin
          es:='S';
       end;
       if Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimento then begin
         Es:='E';
// 14.03.12
         with RegistroD100New do begin
// 07.05.20
//         New(PRegD100);
//         PRegD100.Unidade := Q.fieldbyname('moes_tipomov').asstring;
//         with PRegD100.TRegD100 do begin

           Inc(NRegD100);
  //         IND_OPER:=itoContratado;
           IND_OPER:='0';
//           IND_EMIT:=iedfProprio;
// 06.12.19 - NOvicarnes - Ketlen
           IND_EMIT:=iedfTerceiro;
           COD_PART:=GetCodigoParticipa( Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring ) ;
           COD_MOD:=GetModelo(Q.fieldbyname('moes_tipomov').asstring);
           if Qmovbase.fieldbyname('movb_status').asstring='X' then begin
              COD_SIT:=sdfCancelado;
           end else if Qmovbase.fieldbyname('movb_status').asstring='Y' then
             COD_SIT:=sdfDenegado
           else
              COD_SIT:=sdfRegular;
  //          SER:=strspace(Q.fieldbyname('moes_serie').asstring,3);
            SER:=trim(Q.fieldbyname('moes_serie').asstring);
  //          NUM_DOC:=strspace(Q.fieldbyname('moes_numerodoc').asstring,09);
            NUM_DOC:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,09);

  // pra uso somente em conhecimento eletronico..ainda nao previsto
            if trim(Q.fieldbyname('moes_chavenfe').asstring)<>'' then
              CHV_CTE:=copy(Q.fieldbyname('moes_chavenfe').asstring,1,44);
  //          CHV_CTE_REF:='';
            DT_DOC:=Q.fieldbyname('moes_dataemissao').asdatetime;
            DT_A_P:=datanota;
            VL_DOC:=Q.fieldbyname('moes_vlrtotal').ascurrency;
//            VL_DESC:=0;
// 12.03.18
            VL_DESC:=vlrdesco;
            if Q.FieldByName('moes_freteciffob').asstring='1' then
              IND_FRT:=tfPorContaEmitente
            else
              IND_FRT:=tfPorContaDestinatario;
            VL_BC_ICMS:=Q.fieldbyname('moes_baseicms').ascurrency;
            if Q.fieldbyname('moes_baseicms').ascurrency=0 then
              VL_BC_ICMS:=Q.fieldbyname('moes_vlrtotal').ascurrency;
            VL_ICMS:=Q.fieldbyname('moes_valoricms').ascurrency;
            VL_SERV:=0;  // pedagio e demais despesas somadas
            VL_NT:=0;
            COD_INF:='';
            COD_CTA:=GetCod_Cta(Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);
// 20.10.17
            TP_CT_e:='0';
// 07.05.20
            ListaD100.Add( PRegD100 );

         end;

/////////////////////////////////
// 09.04.12 - pois conhecimento entrada n�o � digitado itens ent�o gero aqui com cst 'fixo' 54  -> 53
// at� ver como tratar de forma 'configur�vel'
         if Es='E' then begin
           with RegistroD101New do begin

             IND_NAT_FRT:=nfcCompraGeraCred;
             VL_ITEM:=Q.fieldbyname('moes_vlrtotal').ascurrency;
//             CST_PIS:=GetCSTPIS('54');
// 18.12.17 - NOvicarnes - Ketlen - Polli
             CST_PIS:=GetCSTPIS('53');
// 29.09.2021 - Clessi
             if SituacaoCST('LAMINADORA') then

                CST_PIS:=GetCSTPIS('54');

// 19.10.12 - Clessi
             if pos( Q.fieldbyname('moes_natf_codigo').asstring,'1352/2352' ) > 0 then
               NAT_BC_CRED:=bccAqBensUtiComoInsumo
             else
               NAT_BC_CRED:=bccAqBensRevenda;
             VL_BC_PIS:=Q.fieldbyname('moes_vlrtotal').ascurrency;
             alipis:=FCodigosFiscais.GetAliquotaPis( '1'  );
             ALIQ_PIS:=alipis;
             VL_PIS:=(Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco)*(alipis/100);
  //           COD_CTA:='';
  // 18.10.17
            COD_CTA:=GetCod_Cta(Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);
           end;
           with AcbrSpedPisCofins1.Bloco_D.RegistroD105New do begin

               IND_NAT_FRT:=nfcCompraGeraCred;
               VL_ITEM:=Q.fieldbyname('moes_vlrtotal').ascurrency;
//               CST_COFINS:=GetCSTCOFINS( '54');
// 18.12.17 - NOvicarnes - Ketlen - Polli
               CST_COFINS:=GetCSTCOFINS('53');
// 29.09.2021 - Clessi
               if SituacaoCST('LAMINADORA') then

                  CST_COFINS:=GetCSTCOFINS('54');
// 19.10.12 - Clessi
               if pos( Q.fieldbyname('moes_natf_codigo').asstring,'1352/2352' ) > 0 then
                 NAT_BC_CRED:=bccAqBensUtiComoInsumo
               else
                 NAT_BC_CRED:=bccAqBensRevenda;
               VL_BC_COFINS:=Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco;
               alicofins:=FCodigosFiscais.GetAliquotaCofins( '1' );
               ALIQ_COFINS:=alicofins;
               VL_COFINS:=(Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco) *(alicofins/100);
//               COD_CTA:='';
// 18.10.17
               COD_CTA:=GetCod_Cta(Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);
           end;
         end;
///////////////////////////////

       end else begin   // conhecimento emitido

           Es:='S';
           Inc(NRegD200);
           AcumulaporCriterio('D200',
                              GetModelo(Q.fieldbyname('moes_tipomov').asstring),
                              Q.fieldbyname('moes_status').asstring,
                              trim(Q.fieldbyname('moes_serie').asstring),
                              '',
                              Q.fieldbyname('moes_unid_codigo').asstring,
                              Q.fieldbyname('moes_numerodoc').asinteger,
                              strtoint( Q.fieldbyname('moes_natf_codigo').asstring ),
                              Q.fieldbyname('moes_dataemissao').asdatetime,
                              Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco );

       end;
     end;

     FGeral.Fechaquery(QMovbase);


     Q.Next;

  end; // while dos conhecimentos da unidade
  FGeral.Fechaquery(q);

  sistema.beginprocess('Pesquisando documentos');
  tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+Global.CodContrato+';'+
            Global.CodConhecimento+';'+Global.CodCedulaProdutoRural;
// 25.09.13 - para poder gerar registros D201/D205
////////////            +';'+Global.CodConhecimentoSaida;
  sqlcfopssim:='';
  if trim( FGeral.GetConfig1Asstring('Cfopspiscofinsgera') )<>'' then
    sqlcfopssim:=' and '+FGeral.GetNOTIN('moes_natf_codigo',FGeral.GetConfig1Asstring('Cfopspiscofinsgera'),'C');
// 19.08.10
//  SqlunidadesDet:=' and move_unid_codigo='+EdUnid_codigo.assql;
  SqlunidadesDet:=' and move_unid_codigo='+Stringtosql(QUnidades.fieldbyname('Unid_codigo').asstring);
//  if Global.Topicos[1015] then
//  if not EdUnidades.isempty then
//    SqlunidadesDet:=' and '+FGeral.GetIN('move_unid_codigo',EdUnidades.text,'C');

  Q:=sqltoquery('select * from movestoque'+
                ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                ' inner join estoque on ( move_esto_codigo=esto_codigo )'+
//                ' inner join estoqueqtde on ( move_esto_codigo=esqt_esto_codigo and move_unid_codigo=esqt_unid_codigo)'+
// retirado devido algumas 'duplicidades possiveis' de codigos devido
// aos 'sumi�os de codigos' de 2010/2011
                ' inner join natureza on (natf_codigo=moes_natf_codigo)'+
                ' where '+FGeral.Getin('move_status','N;X;E;D;Y','C')+' and move_datamvto>='+EdInicio.assql+
                ' and '+FGeral.Getin('moes_status','N;X;E;D;Y','C')+' and move_datamvto>='+EdInicio.assql+
                ' and move_datamvto<='+EdTermino.assql+
                ' and '+FGeral.GetNOTIN('moes_tipomov',Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodTransfEntrada+';'+Global.CodTransfSaida,'C')+
                ' and '+FGeral.GetNOTIN('move_tipomov',Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodTransfEntrada+';'+Global.CodTransfSaida,'C')+
                ' and '+FGeral.GetNOTIN('moes_especie','CF;CF ;','C')+
                ' and '+FGeral.GetNOTIN('moes_tipomov',tiposnao,'C')+
// 14.05.12 - Capeg - cfops pra n�o enviar
                sqlcfopssim+
                ' and move_datacont is not null'+
                sqlunidadesdet+
//                ' and esqt_unid_codigo='+EdUnid_codigo.assql+  // 14.10.11
                ' and moes_natf_codigo is not null'+
// aqui
//                ' and '+FGeral.Getin('move_tipomov',Global.TiposEntrada,'C')+
//                ' and '+FGeral.Getin('moes_tipomov',Global.TiposEntrada,'C')+
//                ' order by move_transacao,move_datamvto,move_numerodoc,move_aliicms' );
// 09.03.12
                ' order by move_transacao,move_datamvto,move_numerodoc,move_tipomov,move_aliicms' );
  if Q.eof then begin
    Avisoerro('Nada encontrado para exporta��o.  Ser� gerado SEM movimento para a unidade '+QUnidades.fieldbyname('Unid_codigo').asstring);
  end;

// 25.08.15
  Sistema.beginprocess('Lendo itens das notas de entrada e saida');
  Qitens:=Sqltoquery('select move_transacao,move_tipomov,move_numerodoc,move_unid_codigo,move_esto_codigo,move_qtde,move_venda,'+
                ' moes_estado,move_cst,move_natf_codigo,move_aliicms,move_redubase'+
                ' from movestoque inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                ' where '+FGeral.Getin('moes_status','N;X;E;D;Y','C')+' and moes_datamvto>='+EdInicio.assql+
                ' and move_datamvto<='+EdTermino.assql+
                ' and '+FGeral.Getin('move_status','N;X;E;D;Y','C')+' and move_datamvto>='+EdInicio.assql+
                ' and '+FGeral.GetNOTIN('moes_tipomov',Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodTransfEntrada+';'+Global.CodTransfSaida,'C')+
                ' and '+FGeral.GetNOTIN('move_tipomov',Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodTransfEntrada+';'+Global.CodTransfSaida,'C')+
                ' and move_datamvto<='+EdTermino.assql+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_status<>''C'''+
                ' and move_status<>''C'''+
// aqui
//                ' and '+FGeral.Getin('move_tipomov',Global.TiposEntrada,'C')+
//                ' and '+FGeral.Getin('moes_tipomov',Global.TiposEntrada,'C')+
                ' order by move_transacao,move_tipomov');

  Sistema.beginprocess('Armazenando itens das notas de entrada e saida ');
  ListaItens:=TList.create;

  while not Qitens.eof do begin

    New(PItens);
    PItens.transacao:=QItens.fieldbyname('move_transacao').asstring;
    PItens.tipomov:=QItens.fieldbyname('move_tipomov').asstring;
    PItens.unitario:=QItens.fieldbyname('move_venda').ascurrency;
    PItens.qtde:=QItens.fieldbyname('move_qtde').ascurrency;
    PItens.produto:=QItens.fieldbyname('move_esto_codigo').asstring;
    PItens.unidade:=QItens.fieldbyname('move_unid_codigo').asstring;
    PItens.estado:=QItens.fieldbyname('moes_estado').asstring;
    PItens.cst:=QItens.fieldbyname('move_cst').asstring;
    PItens.natf_codigo:=QItens.fieldbyname('move_natf_codigo').asstring;
// 19.05.17
    PItens.redubase:=QItens.fieldbyname('move_redubase').ascurrency;
    PItens.aliicms:=QItens.fieldbyname('move_aliicms').ascurrency;
    PItens.baseicms:=FGeral.Arredonda(QItens.fieldbyname('move_qtde').ascurrency*QItens.fieldbyname('move_venda').ascurrency,2);
    if QItens.fieldbyname('move_redubase').ascurrency>0 then
      PItens.baseicms:=PItens.baseicms*(QItens.fieldbyname('move_redubase').ascurrency/100);
    PItens.valoricms:=PItens.baseicms*(QItens.fieldbyname('move_aliicms').ascurrency/100);
    Listaitens.Add(PItens);
    QItens.next;

  end;

  QItens.close;
//  Aviso('itens guardados '+inttostr(ListaItens.count)+'Terminado'+TimeToStr(time()) );

  Sistema.beginprocess('Exportando movimento de entrada e saida ' );

  Texto.Lines.add('Inicio '+TimeToStr(time()) );

  ListaC100:=TList.create;
  ListaC170:=TList.create;

  if not Q.eof then begin

    with AcbrSpedPisCofins1.Bloco_C do begin
//      LimpaRegistros;
      with RegistroC001New do begin
        IND_MOV:=imComDados;
      end;

      with RegistroC010New do begin
        CNPJ:=QUnidades.fieldbyname('unid_cnpj').asstring;
        IND_ESCRI:=IndEscriIndividualizado;  //2 � Apura��o com base no registro individualizado de NF-e (C100 e C170) e de ECF (C400)
//         IndEscriConsolidado,     //1 � Apura��o com base nos registros de consolida��o das opera��es por NF-e (C180 e C190) e por ECF (C490);
      end;
    end;


  end;

  Lista75:=TStringlist.create;
  Lista75Aux:=TStringlist.create;

  NRegA100:=0;
//////////////////////////////////////////////////////////
  while not Q.eof do begin
//////////////////////////////////////////////////////////

//    Sistema.setmessage('Exportando movimento de entrada e saida - mestre '+Q.fieldbyname('moes_transacao').asstring);
//    Sistema.setmessage('Exportando movimento de entrada e saida - mestre '+fGeral.formatadata(Q.fieldbyname('moes_datamvto').asdatetime));
    Sistema.setmessage('Exportando movimento de entrada e saida - data '+fGeral.formatadata(Q.fieldbyname('moes_datamvto').asdatetime));

//    Texto.lines.add(Q.fieldbyname('moes_transacao').asstring);

//    if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposMovMovEntrada)>0 then begin
// 10.06.08 - CI - Novicarnes 'entendia' como saida...
    if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin
      es:='E';
    end else begin
      es:='S';
    end;
    cfop:=copy(Q.fieldbyname('moes_natf_codigo').asstring,1,4);
//    if  GetModelo(Q.fieldbyname('moes_tipomov').asstring) <> ModeloNfe then begin
    if pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModelosnaoGeraItem )=0 then begin
      if ListaTodosCfops.IndexOf(cfop)=-1 then
        ListaTodosCfops.Add(cfop);
    end;

/////////
    if Es='E' then begin
      datanota:=Q.fieldbyname('moes_datamvto').asdatetime;
//      vlrfrete:=0;  // nf de entrada � s� para entrar no custo do produto
// 05.09.18 - nao mais...Novicarnes - Ketlen..faz parte da base de pis e cofins...
      vlrfrete:=q.fieldbyname('moes_frete').ascurrency;
// 10.07.19
      if ( (Q.fieldbyname('moes_totprod').ascurrency+Q.fieldbyname('moes_valoripi').ascurrency+
          Q.fieldbyname('moes_valoricmssutr').ascurrency+vlrfrete) > Q.fieldbyname('moes_vlrtotal').ascurrency )
          and ( Es = 'E' )
           then
          vlrfrete:=0;

    end else begin

      datanota:=Q.fieldbyname('moes_dataemissao').asdatetime;
      vlrfrete:=q.fieldbyname('moes_frete').ascurrency;

    end;

    QMovbase:=sqltoquery('select movb_aliquota,sum(movb_basecalculo) as basecalculo from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring)+
//                           ' group by movb_natf_codigo');
// 10.07.09 - mudado para contar aliquotas e nao cfops...
                           ' group by movb_aliquota');
    aliqsicms:=0;
// 16.05.17
//    baseicms:=0;
    while not QMovbase.eof do begin
      inc(aliqsicms);
//      baseicms:=baseicms + QMovbase.FieldByName('basecalculo').AsCurrency;
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

//    QMovbase.first;

//    PesquisaEntidade(Q.fieldbyname('moes_tipocad').asstring,Q.fieldbyname('moes_tipo_codigo').asinteger);

    ListaAliquotas:=TStringlist.create;
    ListaBases:=TStringlist.create;
    ListaCfops:=TStringlist.create;
    ListaCSTs:=TStringlist.create;

    valorpis:=0;valorcofins:=0;
//    x:=q.fieldbyname('move_transacao').asstring+q.fieldbyname('move_datamvto').asstring+q.fieldbyname('move_numerodoc').asstring;
// 09.03.12 - para nao dobrar as transferencias entre matriz e filial
    x:=q.fieldbyname('move_transacao').asstring+q.fieldbyname('move_datamvto').asstring+q.fieldbyname('move_numerodoc').asstring
       +q.fieldbyname('move_tipomov').asstring;
////////////////////////////////////////////////////////////////////////////////////
// 21.03.07
     codigofiscal:=FSittributaria.CSttoCF(Qmovbase.FieldByName('movb_cst').Asstring);
// 04.07.07
     if QMovbase.FieldByName('movb_reducaobc').AsCurrency>0 then
       codigofiscal:='2';
     isentas:=0;outras:=0;
//     baseicms:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
// 16.05.17 - nas entradas com mais de um cfop nao fechava a base do C100 com C170
     if numcfops=1 then baseicms:=Q.FieldByName('moes_baseicms').AsCurrency
     else baseicms:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;

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
//       if ( aliqsicms=1 ) and ( numcfops=1 ) then begin
// 16.05.17 - devido sped atrasado de 01.2015 - Leo Jaime...
       if ( numcfops=1 ) then begin
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
       outras:=Q.FieldByName('moes_valoripi').AsCurrency;
// 13.11.07
     if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 then begin
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
     end else begin
// 17.04.07
//       valornota:=QMovbase.FieldByName('movb_basecalculo').AsCurrency+Q.fieldbyname('moes_valoripi').ascurrency;
// 16.11.07
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
       if (Q.FieldByName('moes_tipomov').asstring=Global.CodVendaConsigMercantil) and (QMovbase.FieldByName('movb_basecalculo').AsCurrency=0) then begin
         valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency+Q.fieldbyname('moes_valoripi').ascurrency;
         baseicms:=Q.FieldByName('moes_baseicms').AsCurrency;
// 10.09.09
       end else if (Q.FieldByName('moes_tipomov').asstring=Global.CodCompraIndustria) and (QMovbase.FieldByName('movb_basecalculo').AsCurrency=0) then begin
         valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
         baseicms:=Q.FieldByName('moes_baseicms').AsCurrency;
       end;
     end;
// 04.07.07
     vlricms:=QMovbase.FieldByName('movb_imposto').Ascurrency;
// 16.05.17
     if numcfops=1 then vlricms:=Q.FieldByName('moes_valoricms').AsCurrency;

     if ( QMovbase.FieldByName('movb_aliquota').Ascurrency>0 ) and (QMovbase.FieldByName('movb_basecalculo').AsCurrency>0) then
       vlricms:=baseicms*(QMovbase.FieldByName('movb_aliquota').Ascurrency/100);
     aliqicms:=QMovbase.FieldByName('movb_aliquota').Ascurrency;
// 23.10.07
     if QMovbase.fieldbyname('movb_natf_codigo').asstring<>'' then
       cfop50:=copy(QMovbase.fieldbyname('movb_natf_codigo').asstring,1,4)
     else
       cfop50:=cfop;

     if (Q.FieldByName('moes_tipomov').asstring=Global.Codcompraprodutor)
       or (situacaonota='S')
       or (Q.FieldByName('moes_tipomov').asstring=Global.CodPrestacaoServicos)
       or (Q.fieldbyname('moes_tipomov').asstring=Global.CodPrestacaoServicosE)
       then begin  // 16.09.10 - Abra
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
       baseicms:=0;
       vlricms:=0;
       aliqicms:=0;
     end;
// notas de combustivel elize...
     if baseicms>valornota then
        baseicms:=valornota;           // 16.05.17
     if (baseicms>0) and (vlricms=0) and (Es='E') then begin
       baseicms:=0;
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
     end;
// 06.07.07
     if ( Q.FieldByName('moes_vlrtotal').AsCurrency>QMovbase.fieldbyname('movb_basecalculo').ascurrency ) and
        ( QMovbase.FieldByName('movb_basecalculo').AsCurrency>0 ) and ( aliqsicms=1 ) then begin
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
     end;
     ConsumidorFinal:='N';
     if Q.fieldbyname('moes_tipocad').asstring='C' then
       ConsumidorFinal:=FGeral.GetConsumidorFinal(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring);

// 22.02.11 - retirado este if devido notas de entrada com servicos dai total merc fica
//            menor que o total da nota e tem mais de um cfop...bicheiras das entradas
//      else if ( Q.FieldByName('moes_vlrtotal').AsCurrency>QMovbase.fieldbyname('movb_basecalculo').ascurrency ) and
//        ( QMovbase.FieldByName('movb_basecalculo').AsCurrency>0 ) and ( aliqsicms>1 ) then
//          valornota:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;


     perdesco:=0;vlrdesco:=0;
{
     if (Q.FieldByName('moes_vlrtotal').AsCurrency<Q.FieldByName('moes_totprod').AsCurrency) and
        (Q.FieldByName('moes_baseicms').AsCurrency=0)
         then begin
       perdesco:= 100 - ( (Q.FieldByName('moes_vlrtotal').AsCurrency/Q.FieldByName('moes_totprod').AsCurrency)*100 );
       perdesco:=roundvalor(perdesco);
// 11.04.11
       vlrdesco:=FGeral.Arredonda(Q.FieldByName('moes_totprod').AsCurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100),2);
     end;
}
// 09.02.19 - Novicarnes
      if (Q.fieldbyname('moes_perdesco').ascurrency>0) and
         (Q.FieldByName('moes_totprod').AsCurrency>0)  and
         (Q.FieldByName('moes_vlrtotal').AsCurrency>0) then begin

          vlrdesco:=Q.FieldByName('moes_totprod').AsCurrency -
                    Q.FieldByName('moes_vlrtotal').AsCurrency;
          perdesco:=( (vlrdesco-Q.fieldbyname('moes_frete').ascurrency)/Q.FieldByName('moes_totprod').AsCurrency) * 100;
 // 23.01.20
          if perdesco < 0 then perdesco:=Q.fieldbyname('moes_perdesco').ascurrency;

          vlrdesco:=FGeral.Arredonda(Q.FieldByName('moes_totprod').AsCurrency*(perdesco/100),2);
          if Q.FieldByName('moes_numerodoc').AsInteger=7992 then begin

             Texto.Lines.add('vlrdesco = '+floattostr( vlrdesco ) );
             Texto.Lines.add('perdesco = '+floattostr( perdesco ) );

          end;

      end;

/////////////// - recolocado em 27.01.11
     if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
        then begin    // entradas td em outras e valor contabil
        outras:=valornota;
        baseicms:=0;
        isentas:=0;
        vlricms:=0;
        aliqicms:=0;
     end;
/////////////////////

// 05.07.10 - Granzotto - NF venda consumidor
     if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'567')>0 ) then begin
{
}
{
///////////////////////////////////
///////////////////////////////////
}

     end else if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'123')>0 ) then begin
       linha:='x';  // nao gera nada
     end else begin
{
}
// 19.04.12
////////////////////////////////////////////////////
        with AcbrSpedPisCofins1.Bloco_A do begin

          if Pos( Q.fieldbyname('moes_tipomov').asstring,Global.CodPrestacaoServicos+';'+Global.CodPrestacaoServicosE )  > 0 then begin
// 15.05.17
            BuscaNosItems(  Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
                            Q.fieldbyname('moes_perdesco').ascurrency,valorpis,valorcofins,'N',0,Q.FieldByName('moes_plan_codigo').AsInteger);
//            if (valorpis+valorcofins) > 0 then begin
// 29.10.18 - enviar todos ref. servi�os - Novicarnes - Ketlen
              if NRegA100=0 then begin
                with RegistroA001New do begin
                  IND_MOV:=imComDados;
                end;
                with RegistroA010New do begin
                  CNPJ:=QUnidades.fieldbyname('unid_cnpj').asstring;
                end;
                Inc(NRegA100);
              end;

              with RegistroA100New do begin

                if Es='E' then begin

                  IND_OPER:=itoContratado;
// 15.01.18 - Novicarnes - Ketlen
                  IND_EMIT:=iedfTerceiro;

                end else begin

                  IND_OPER:=itoPrestado;
                  IND_EMIT:=iedfProprio;

                end;
  // 18.07.12
                IncluiParticipa( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring );

                COD_PART:=GetCodigoParticipa( Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring ) ;
                if Qmovbase.fieldbyname('movb_status').asstring='X' then
                    COD_SIT:=sdfCancelado
                else
                    COD_SIT:=sdfRegular;
                SER:=trim(copy(Q.fieldbyname('moes_serie').asstring,1,3));
  //              SUB:=
                NUM_DOC:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,09);
  //              CHV_NFSE:='';
                DT_DOC:=Q.fieldbyname('moes_dataemissao').asdatetime;
//                VL_DOC:=valornota;
// 19.06.17 - SM - Carine - pra ficar o mesmo valor sem deduzir as retencoes de pis e cofins
//                VL_DOC:=Q.fieldbyname('moes_baseiss').ascurrency;

// 20.10.17 - Novicarnes - nf de entrada de servi�os ficam zeradas pois nao tem base de iss
                if Q.fieldbyname('moes_baseiss').ascurrency>0 then
                  VL_DOC:=Q.fieldbyname('moes_baseiss').ascurrency
                else
                  VL_DOC:=valornota;

                if pos( Q.fieldbyname('moes_tipomov').asstring,Global.TiposGeraFinanceiro)>0 then begin
                  if Q.fieldbyname('moes_vispra').asstring='V' then
                    IND_PGTO:=tpVista
                  else
                    IND_PGTO:=tpPrazo;
                end else if Q.fieldbyname('moes_tipomov').asstring=Global.CodPrestacaoServicosE then begin
                    IND_PGTO:=tpPrazo
                end else
                    IND_PGTO:=tpSemPagamento;
// 19.09.19 - Novicarnes - Ketlen
                if Es='E' then

                   DT_EXE_SERV:=Q.fieldbyname('moes_datamvto').asdatetime

                else

                   DT_EXE_SERV:=Q.fieldbyname('moes_dataemissao').asdatetime;

                VL_DESC:=vlrdesco;
  //              BuscaNosItems(Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
  //                            Q.fieldbyname('moes_perdesco').ascurrency,valorpis,valorcofins);
                VL_PIS:=valorpis;
                VL_COFINS:=valorcofins;
// 20.10.17 - Novicarnes - nf de entrada de servi�os ficam zeradas pois nao tem base de iss

// 07.11.18 - Novicarnes - Ketlen
                if (valorpis+valorcofins) >0 then begin

                  if Q.fieldbyname('moes_baseiss').ascurrency>0 then begin
                    VL_BC_PIS:=Q.fieldbyname('moes_baseiss').ascurrency;  // confirmar se a base � o total da nota mesmo...
                    VL_BC_COFINS:=Q.fieldbyname('moes_baseiss').ascurrency;
                  end else begin
                    VL_BC_PIS:=valornota;
                    VL_BC_COFINS:=valornota;
                  end;

                end;

                VL_PIS_RET:=Q.fieldbyname('moes_valorpis').ascurrency;
                VL_COFINS_RET:=Q.fieldbyname('moes_valorcofins').ascurrency;
                VL_ISS:=Q.fieldbyname('moes_valoriss').ascurrency;
              end;

//            end;

          end;
        end;

////////////////////////////////////////////////////
        with AcbrSpedPisCofins1.Bloco_C do begin

         if Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , ModelosRegistroC100 )  > 0 then begin

//          Sistema.setmessage('Registro C100 movimento de '+fGeral.formatadata(Q.fieldbyname('moes_datamvto').asdatetime));

//          with RegistroC100New do begin
//          PC100a:=TRegistroc100nRC100.
//          with RegistroC100New
//          with PC100.RC100  do begin
//            TRegistroC100.Create;
            New( PC100 );
            if es='E' then
              PC100.IND_OPER:=tpEntradaAquisicao
            else
              PC100.IND_OPER:=tpSaidaPrestacao;
            PC100.VL_MERC:=0;
            PC100.VL_OUT_DA:=0;
            PC100.VL_BC_ICMS_ST:=0;
            PC100.VL_ICMS_ST:=0;
            PC100.VL_IPI:=0;
            PC100.VL_FRT:=0;
            PC100.VL_SEG:=0;
            PC100.VL_PIS:=0;
            PC100.VL_COFINS:=0;
            PC100.VL_COFINS_st:=0;
            PC100.VL_PIS_ST:=0;
            {
            if pos(Qmovbase.fieldbyname('movb_status').asstring,'X;Y')=0 then begin
              IncluiParticipa( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring );
              IncluiUnidadeEstoque(  Q.fieldbyname('esto_unidade').asstring,Q.fieldbyname('esto_codigo').asstring );
            end;
            }
// 14.03.16
            if EmissaoPropria(Q.fieldbyname('moes_chavenfe').asstring) then
              PC100.IND_EMIT:=edEmissaoPropria
            else
              PC100.IND_EMIT:=edTerceiros;

// 08.02.19 - Novicarnes - validador checa cnpj da chave ...
            if Q.fieldbyname('moes_tipomov').asstring = Global.CodTransfEntrada then
               PC100.IND_EMIT:=edTerceiros;


            PC100.COD_MOD:=GetModelo(Q.fieldbyname('moes_tipomov').asstring);
            PC100.NUM_DOC:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,09);
            if Qmovbase.fieldbyname('movb_status').asstring='X' then begin
              PC100.COD_SIT:=sdCancelado;
// 28.02.12
              if (trim(Q.fieldbyname('moes_chavenfe').asstring)<>'') and ( EmissaoPropria(Q.fieldbyname('moes_chavenfe').asstring) ) then
                PC100.CHV_NFE:=copy(Q.fieldbyname('moes_chavenfe').asstring,1,44);

            end else if Qmovbase.fieldbyname('movb_status').asstring='Y' then begin

              PC100.COD_SIT:=sdDoctoDenegado;
              if (trim(Q.fieldbyname('moes_chavenfe').asstring)<>'') and ( EmissaoPropria(Q.fieldbyname('moes_chavenfe').asstring) ) then
                PC100.CHV_NFE:=copy(Q.fieldbyname('moes_chavenfe').asstring,1,44);


            end else  begin

              PC100.COD_SIT:=sdRegular;
//              PC100.COD_PART:=GetCodigoParticipa( Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring ) ;
//              SER:=strspace(Q.fieldbyname('moes_serie').asstring,3);
              PC100.SER:=trim(copy(Q.fieldbyname('moes_serie').asstring,1,3));
              PC100.DT_DOC:=Q.fieldbyname('moes_dataemissao').asdatetime;
              PC100.DT_E_S:=datanota;
              PC100.VL_DOC:=valornota;
              if pos( Q.fieldbyname('moes_tipomov').asstring,Global.TiposGeraFinanceiro)>0 then begin
                if Q.fieldbyname('moes_vispra').asstring='V' then
                  PC100.IND_PGTO:=tpVista
                else
                  PC100.IND_PGTO:=tpPrazo;
              end else
                  PC100.IND_PGTO:=tpSemPagamento;

// 25.10.19  - Novicarnes - sped fiscal
             if Q.fieldbyname('moes_especie').AsString='NFAE' then

                 PC100.COD_SIT:=sdRegimeEspecNEsp;

              PC100.VL_DESC:=vlrdesco;
              PC100.VL_MERC:=Q.fieldbyname('moes_totprod').ascurrency;
// os 'cagadex' das notas de entrada da novi...22.02.11
// 26.10.16 - nota de credito de icms q s� tem valor do icms e demais campos zerados - sped contrib.
              if (es='E') and ( Q.fieldbyname('moes_totprod').ascurrency=0 ) then begin

                if valornota>0 then
                  PC100.VL_MERC:=valornota
                else
                  PC100.VL_MERC:=Q.fieldbyname('moes_valoricms').ascurrency;

              end else if (es='E') and ( Q.fieldbyname('moes_totprod').ascurrency>0 ) and
                      ( Q.fieldbyname('moes_totprod').ascurrency<valornota )
                then
                PC100.VL_MERC:=valornota;

              PC100.VL_FRT:=vlrfrete;
              PC100.VL_SEG:=0;
              if Q.FieldByName('moes_freteciffob').asstring='1' then
                PC100.IND_FRT:=tfPorContaEmitente
              else
                PC100.IND_FRT:=tfPorContaDestinatario;
              PC100.VL_BC_ICMS:=baseicms;
              PC100.VL_ICMS:=vlricms;
              PC100.VL_BC_ICMS_ST:= Q.FieldByName('moes_basesubstrib').ascurrency;
              PC100.VL_ICMS_ST:=Q.FieldByName('moes_valoricmssutr').ascurrency;
// para o caso de ser informado nos totais da nf de entrada e nao nos itens...
//              if Q.fieldbyname('move_aliipi').ascurrency>0 then
                PC100.VL_IPI:=Q.fieldbyname('moes_valoripi').ascurrency;
//checar - ver se cria fun��o para buscar pela transacao+tipo de movimento
//         nos itens ( pis e cofins )
//              alipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
//                      Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
//              alicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
//                      Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
//              VL_PIS:=roundvalor(Q.fieldbyname('moes_baseicms').ascurrency*(alipis/100));
//              VL_COFINS:=roundvalor(Q.fieldbyname('moes_baseicms').ascurrency*(alicofins/100));
//              VL_PIS:=roundvalor(Q.fieldbyname('moes_totprod').ascurrency*(alipis/100));
//              VL_COFINS:=roundvalor(Q.fieldbyname('moes_totprod').ascurrency*(alicofins/100));
// 15.12.16
              temsocstqnaoexporta:='S';

// 22.06.18 - Novicarnes - Ketlen pegou q nao rateia o frete para compor base e calcular pis/cofins
////////////////////////////////
              perrateiofrete:=0;
              if ( Q.FieldByName('moes_frete').AsCurrency > 0 ) and (Q.FieldByName('moes_totprod').AsCurrency>0)
                 and ( Q.FieldByName('moes_totprod').AsCurrency < Q.FieldByName('moes_vlrtotal').AsCurrency )
                 then
                 perrateiofrete:=(Q.FieldByName('moes_frete').AsCurrency/Q.FieldByName('moes_totprod').AsCurrency)*100;

// 10.07.19 - Clessi - nao adiantou - tem q checar quando o frete nao faz parte do total da nota
//            mas � informado para efeito de custo
              if ( (Q.fieldbyname('moes_totprod').ascurrency+Q.fieldbyname('moes_valoripi').ascurrency+
                  Q.fieldbyname('moes_valoricmssutr').ascurrency+vlrfrete) > Q.fieldbyname('moes_vlrtotal').ascurrency )
                  and ( Es = 'E' )
                   then

                  perrateiofrete:=0;


/////////////////////////////////////////
// 17.10.11
//              BuscaNosItems(Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
//                            Q.fieldbyname('moes_perdesco').ascurrency,valorpis,valorcofins,consumidorfinal,perrateiofrete);
// 09.02.19 - desconto calculado durante a geracao devido a alguns ter gravado errado no banco
              BuscaNosItems(Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
                            perdesco,valorpis,valorcofins,consumidorfinal,perrateiofrete,Q.FieldByName('moes_plan_codigo').AsInteger);
//              if baseicms>0 then begin
                PC100.VL_PIS:=valorpis;
                PC100.VL_COFINS:=valorcofins;
//              end;
              PC100.VL_PIS_ST:=0;
//              if (trim(Q.fieldbyname('moes_chavenfe').asstring)<>'') and ( EmissaoPropria(Q.fieldbyname('moes_chavenfe').asstring) ) then
// 14.03.16 - a partir de 2012 considera erro se for nf-e sem chave mesmo na entrada
//              if (trim(Q.fieldbyname('moes_xmlnfet').asstring)<>'') then
// 29.09.2021 - retirado este if para 'caso clessi'...entrada somente alterando para informar a chave...

                PC100.CHV_NFE:=copy(Q.fieldbyname('moes_chavenfe').asstring,1,44);

              PC100.VL_COFINS_ST:=0;
              if es='E' then begin

                if pos( Q.fieldbyname('moes_natf_codigo').asstring,CfopsIsentosEntradas ) >0 then begin
                  PC100.VL_IPI:=0;
                  PC100.VL_PIS:=0;
                  PC100.VL_COFINS:=0;
                end

              end else begin
                if pos( Q.fieldbyname('moes_natf_codigo').asstring,CfopsIsentosSaidas ) >0 then begin
                  PC100.VL_IPI:=0;
                  PC100.VL_PIS:=0;
                  PC100.VL_COFINS:=0;
                end
              end;
            end;

              PC100.ttransacao:=Q.fieldbyname('moes_transacao').asstring+';'+Q.fieldbyname('moes_tipomov').asstring;
// 15.12.16 - 24.02.17 - Novicarnes Leonir nao enviar canceladas, denegadas
              if (temsocstqnaoexporta='N') and ( pos(Qmovbase.fieldbyname('movb_status').asstring,'X;Y;I')=0) then begin
// 04.04.17 - para incluir participantes somente de notas q vao pro validador
                if pos(Qmovbase.fieldbyname('movb_status').asstring,'X;Y')=0 then begin

                  IncluiParticipa( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring );
                  IncluiUnidadeEstoque(  Q.fieldbyname('esto_unidade').asstring,Q.fieldbyname('esto_codigo').asstring );
                  PC100.COD_PART:=GetCodigoParticipa( Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring ) ;

                end;

                ListaC100.Add(PC100);

              end;

//          end;  // with do C100

         end else if Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , '06' )  >0 then begin
//////////////////////////////
// fatura de energia el�trica
//////////////////////////////
           with RegistroC500New do begin

             IncluiParticipa( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring );
             COD_PART:=GetCodigoParticipa(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring);
             COD_MOD:='06';
             COD_SIT:=sdRegular;
             SER:=Q.fieldbyname('moes_serie').asstring;
             SUB:=0;
              if Q.fieldbyname('moes_perdesco').ascurrency>0 then
                vlrdesco:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100),2)
              else
                vlrdesco:=0;
//             NUM_DOC:=Q.fieldbyname('moes_numerodoc').asstring;
             NUM_DOC:=Q.fieldbyname('moes_numerodoc').asinteger;
             DT_DOC:=Q.fieldbyname('moes_dataemissao').asdatetime;
             DT_ENT:=Q.fieldbyname('moes_datamvto').asdatetime;
             VL_DOC:=Q.FieldByName('moes_vlrtotal').Ascurrency;
             VL_ICMS:=Q.fieldbyname('moes_valoricms').ascurrency;
//             alipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
//                  Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
//             alicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
//                  Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
// 17.10.11
             BuscaNosItems(Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
                           Q.fieldbyname('moes_perdesco').ascurrency,valorpis,valorcofins);
             VL_PIS:=valorpis;
             VL_COFINS:=valorcofins;

//             VL_PIS:=roundvalor(Q.fieldbyname('moes_baseicms').ascurrency*(alipis/100));
//             VL_COFINS:=roundvalor(Q.fieldbyname('moes_baseicms').ascurrency*(alicofins/100));
//             VL_PIS:=roundvalor(Q.fieldbyname('moes_totprod').ascurrency*(alipis/100));
//             VL_COFINS:=roundvalor(Q.fieldbyname('moes_totprod').ascurrency*(alicofins/100));
//             VL_PIS:=Q.fieldbyname('moes_totprod').ascurrency*(alipis/100);
//             VL_COFINS:=Q.fieldbyname('moes_totprod').ascurrency*(alicofins/100);
           end;

         end else if Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , '22' )  >0 then begin
//////////////////////////////
// fatura de conta de telefone
//////////////////////////////
// 08.12.11 - retirado em 07.08.13 e em 12.08.13  // recolocado em 07.05.20

            if NRegD010=0 then begin
              with AcbrSpedPisCofins1.Bloco_D do begin
                with RegistroD010New do begin
                  CNPJ:=QUnidades.fieldbyname('unid_cnpj').asstring;
                end;
                inc(nregd010);  // 07.08.13
              end;
            end;

//////////////
           with AcbrSpedPisCofins1.Bloco_D.RegistroD500New do begin

             Inc(NRegD500);  // 08.12.11
             IND_OPER:=itoContratado;
             IND_EMIT:=iedfProprio;
             IncluiParticipa( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring );
// 11.04.11 - nao inclui participante de conta telefonica
// 15.07.11 - novo validador pelo jeito exige
             COD_PART:=GetCodigoParticipa(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring);
             COD_MOD:='22';
             COD_SIT:=sdfRegular;
             SER:=Q.fieldbyname('moes_serie').asstring;
             SUB:=0;
              if Q.fieldbyname('moes_perdesco').ascurrency>0 then
                vlrdesco:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100),2)
              else
                vlrdesco:=0;
//             NUM_DOC:=Q.fieldbyname('moes_numerodoc').asstring;
//             NUM_DOC:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,09);
             NUM_DOC:=Q.fieldbyname('moes_numerodoc').asinteger;
             DT_DOC:=Q.fieldbyname('moes_dataemissao').asdatetime;
             DT_A_P:=Q.fieldbyname('moes_datamvto').asdatetime;
             VL_DOC:=Q.FieldByName('moes_vlrtotal').Ascurrency;
             VL_DESC:=vlrdesco;
             VL_BC_ICMS:=Q.FieldByName('moes_baseicms').Ascurrency;
             VL_ICMS:=Q.FieldByName('moes_valoricms').Ascurrency;
//             alipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
//                  Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
//             alicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
//                  Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
// 17.10.11
             BuscaNosItems(Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
                           Q.fieldbyname('moes_perdesco').ascurrency,valorpis,valorcofins);
             VL_PIS:=valorpis;
             VL_COFINS:=valorcofins;
//             VL_PIS:=roundvalor(Q.fieldbyname('moes_baseicms').ascurrency*(alipis/100));
//             VL_COFINS:=roundvalor(Q.fieldbyname('moes_baseicms').ascurrency*(alicofins/100));
//             VL_PIS:=roundvalor(Q.fieldbyname('moes_totprod').ascurrency*(alipis/100));
//             VL_COFINS:=roundvalor(Q.fieldbyname('moes_totprod').ascurrency*(alicofins/100));
//             VL_PIS:=(Q.fieldbyname('moes_totprod').ascurrency*(alipis/100));
//             VL_COFINS:=(Q.fieldbyname('moes_totprod').ascurrency*(alicofins/100));
    // demais campos penso nao irei usar...

           end;
// 04.03.12 - detalhe dos conhecimentos de entrada e saida
// 09.04.12 - conhecimento de entrada n�o � digitado itens...rever... nem passa por aqui
//         end else if Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , '08' )  >0 then begin
// 14.05.13
         end else if Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , '08/57' )  >0 then begin

           if ES='E' then begin
             with AcbrSpedPisCofins1.Bloco_D.RegistroD101New do begin
               IND_NAT_FRT:=nfcCompraGeraCred;
               VL_ITEM:=Q.fieldbyname('moes_vlrtotal').ascurrency;
               CST_PIS:=GetCSTPIS( FEstoque.GetPISpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'E'),Q.fieldbyname('moes_natf_codigo').asstring,Q.fieldbyname('move_cst').asstring );
               NAT_BC_CRED:=bccAqBensRevenda;
               VL_BC_PIS:=Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco;
               alipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                       Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
               ALIQ_PIS:=alipis;
               VL_PIS:=(Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco)*(alipis/100);
    //           COD_CTA:='';
               COD_CTA:=GetCod_Cta(Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);
             end;
             with AcbrSpedPisCofins1.Bloco_D.RegistroD105New do begin
               IND_NAT_FRT:=nfcCompraGeraCred;
               VL_ITEM:=Q.fieldbyname('moes_vlrtotal').ascurrency;
               CST_COFINS:=GetCSTCOFINS( FEstoque.GetCOFINSpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'E'),Q.fieldbyname('moes_natf_codigo').asstring,Q.fieldbyname('move_cst').asstring );
               NAT_BC_CRED:=bccAqBensRevenda;
               VL_BC_COFINS:=Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco;
               alicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                       Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
               ALIQ_COFINS:=alicofins;
               VL_COFINS:=(Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco)*(alicofins/100);
    //           COD_CTA:='';
               COD_CTA:=GetCod_Cta(Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);
             end;

           end else begin
           // conhecimentos Emitidos
/////////////////////////

             alipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                          Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
             alicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                       Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
             xCST_PIS:=GetCSTPIS( FEstoque.GetPISpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'S'),Q.fieldbyname('moes_natf_codigo').asstring,Q.fieldbyname('move_cst').asstring );
             xCST_COFINS:=GetCSTCOFINS( FEstoque.GetCOFINSpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'S'),Q.fieldbyname('moes_natf_codigo').asstring,Q.fieldbyname('move_cst').asstring );
// 14.05.13 - mudado para 'junto' ao d200 - furou...
             AcumulaD201205('D201',
                            Q.fieldbyname('moes_unid_codigo').asstring,
//                            GetCSTPIS( FEstoque.GetPISpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'S'),Q.fieldbyname('moes_natf_codigo').asstring,Q.fieldbyname('move_cst').asstring ),
                            xCST_PIS,xCST_COFINS,
                            '',
                            Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco,
                            Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco,
                            alipis,
                            (Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco)*(alipis/100),
                            Q.fieldbyname('moes_dataemissao').asdatetime,
                            Q.fieldbyname('moes_natf_codigo').asstring,
                            Q.fieldbyname('move_numerodoc').asinteger
                            );
             AcumulaD201205('D205',
                            Q.fieldbyname('moes_unid_codigo').asstring,
//                            GetCSTCOFINS( FEstoque.GetCOFINSpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'S'),Q.fieldbyname('moes_natf_codigo').asstring,Q.fieldbyname('move_cst').asstring ),
                            xCST_PIS,xCST_COFINS,
                            '',
                            Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco,
                            Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco,
                            alicofins,
                            (Q.fieldbyname('moes_vlrtotal').ascurrency-vlrdesco)*(alicofins/100),
                            Q.fieldbyname('moes_dataemissao').asdatetime,
                            Q.fieldbyname('moes_natf_codigo').asstring,
                            Q.fieldbyname('move_numerodoc').asinteger
                            );

           end;

/////////////////////////
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


        end;  // with do Bloco C

     end;

// 23.10.07
      ListaAliquotas.add( Valortosql( aliqicms ) );
      ListaBases.add( Valortosql( valornota ) );
      ListaCfops.add( cfop50 );
      ListaCSTs.add( QMovbase.FieldByName('movb_cst').AsString );

//      if pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModeloNfe+';'+ModelosnaoGeraItem )=0 then begin
// 25.10.11 - pis/cofins gera pra Nfe
      if pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModelosnaoGeraItem )=0 then begin
        if ListaTodosCfops.IndexOf(cfop50)=-1 then
          ListaTodosCfops.Add(cfop50);
      end;

// 10.04.07                                           // 09.12.09
      if (Q.fieldbyname('moes_valoripi').ascurrency>0) and (pos(Q.fieldbyname('moes_status').asstring,'X;Y')=0) then begin
{
}
      end;

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
           valoripi:=totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100);
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
             outras:=Q.FieldByName('moes_valoripi').AsCurrency;
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
           if pos(Q.FieldByName('moes_tipomov').asstring,Global.CodPrestacaoServicos+';'+Global.CodPrestacaoServicosE) > 0
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
         if pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModelosnaoGeraItem )=0 then begin
           if ListaTodosCfops.IndexOf(cfop50)=-1 then
             ListaTodosCfops.Add(cfop50);
         end;

        end;
        QMovbase.next;
      end;
      fGeral.Fechaquery(QMovbase);

///////////////////

    contitem:=1;
    ListaDocumentoCst:=TList.create;

//    Sistema.setmessage('Exportando movimento de entrada e saida - detalhe '+fGeral.formatadata(Q.fieldbyname('moes_datamvto').asdatetime)+' '+Q.fieldbyname('move_numerodoc').asstring);

//    while ( q.fieldbyname('move_transacao').asstring+q.fieldbyname('move_datamvto').asstring+q.fieldbyname('move_numerodoc').asstring=x ) and
// 09.03.12
    while ( q.fieldbyname('move_transacao').asstring+q.fieldbyname('move_datamvto').asstring+q.fieldbyname('move_numerodoc').asstring+q.fieldbyname('move_tipomov').asstring=x ) and
        ( not Q.eof )
       do begin

       if pos(Q.fieldbyname('moes_status').asstring,'X;Y')=0 then begin
          IncluiUnidadeEstoque(  Q.fieldbyname('esto_unidade').asstring,Q.fieldbyname('move_esto_codigo').asstring );
       end;

//      totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,2);
// 21.10.16
//      totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,2);
// 30.07.20
      totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').asfloat*Q.fieldbyname('move_venda').asfloat,2);
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
// 19.05.17
                           ' and movb_cst = '+Stringtosql(q.FieldByName('move_cst').AsString)+
                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring));
// 19.05.17
                           {
      if not QMovBase.eof then begin
        redubasemestre:=QMovBase.fieldbyname('movb_reducaobc').ascurrency;
      end else
        redubasemestre:=0;
        }
        redubasemestre:=0;
         while not Qmovbase.Eof do begin
           if QMovBase.fieldbyname('movb_reducaobc').ascurrency>0 then
             redubasemestre:=QMovBase.fieldbyname('movb_reducaobc').ascurrency;
           QMovbase.Next;
         end;
         QMovbase.Close;
//////////////////////////
//      if (redubase>0) then begin
      if (redubase>0) and (redubasemestre>0) then begin
//        baseicms:=(baseicms*(redubase/100));
// 13.04.17
        baseicms:=FGeral.Arredonda( (baseicms*(redubase/100) ) ,2 );
      end;

      if ( q.fieldbyname('move_cst').asstring=CstSubsTrib ) and
         ( ES='S' )   // 27.07.11 - caso digitar CSt errado na entrada...
         then
        baseicmsst:=( totalitem*(1+(Global.MargemSubsTrib/100)) )  // rever posteriormente se tiver mais de um % subst.
      else
        baseicmsst:=0;
//
      valoripi:=totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100);
{//
      if (Q.fieldbyname('moes_perdesco').ascurrency>0) and
         (Q.FieldByName('moes_baseicms').AsCurrency=0) then begin // 22.07.11
         vlrdesco:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100),2);
// 22.07.11
         perdesco:=Q.fieldbyname('moes_perdesco').ascurrency;
}
// 08.02.19 - refeito tratamento com desconto devido as notas de entrada gravados com % de
//            desconto errado e beeem maior
      if (Q.fieldbyname('moes_perdesco').ascurrency>0) and
         (Q.FieldByName('moes_totprod').AsCurrency>0)  and
         (Q.FieldByName('moes_vlrtotal').AsCurrency>0) then begin
          vlrdesco:=Q.FieldByName('moes_totprod').AsCurrency -
                    Q.FieldByName('moes_vlrtotal').AsCurrency;
          perdesco:=( (vlrdesco-Q.fieldbyname('moes_frete').ascurrency)/Q.FieldByName('moes_totprod').AsCurrency) * 100;
// 23.01.20
          if perdesco < 0 then perdesco := Q.fieldbyname('moes_perdesco').ascurrency;
          vlrdesco:=FGeral.Arredonda(totalitem*(perdesco/100),2);
          if vlrdesco<0 then Texto.Lines.Add(' Transa��o '+Q.FieldByName('moes_transacao').AsString+
                                             ' com desconto de '+formatfloat(f_cr3,perdesco)+
                                             '.  Verificar');
      end else begin

        vlrdesco:=0;
        perdesco:=0;

      end;
// 05.09.19 - frete na base de pis e cofins
      if (Q.fieldbyname('moes_frete').ascurrency>0) and
          (Q.fieldbyname('moes_totprod').ascurrency>0) then begin

         vlrfreteitem:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_frete').ascurrency/Q.fieldbyname('moes_totprod').ascurrency),2);

      end else begin

         vlrfreteitem:=0;

      end;


// 10.12.10 - no sintegra nao gerava...
///////////////
      valoricmsst:=Q.fieldbyname('moes_valoricmssutr').ascurrency;
      if Q.fieldbyname('moes_totprod').ascurrency>0 then
        rateioicmsst:=FGeral.arredonda(valoricmsst/Q.fieldbyname('moes_totprod').ascurrency,4)
      else if valornota>0 then
        rateioicmsst:=FGeral.arredonda(valoricmsst/valornota,4);
      valoricmsstitem:=(totalitem-vlrdesco)*rateioicmsst;
///////////////
      if Q.fieldbyname('moes_peracres').ascurrency>0 then
        vlracres:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_peracres').ascurrency/100),2)
      else
        vlracres:=0;
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
//      vlricms:=(baseicms*(aliqicms/100));
// 16.05.17
      vlricms:=FGeral.Arredonda( (baseicms*(aliqicms/100)),2 );
// 05.10.10 - Abra - PS - canceladas ou nao
       if pos(Q.FieldByName('moes_tipomov').asstring,Global.CodPrestacaoServicos+';'+Global.CodPrestacaoServicosE) > 0
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
// nota fiscal de venda consumidor ( modelo 02 ) s�rie D ....
// C380...

      end else begin
// itens das notas
///////////////////
        if ( Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , ModelosRegistroC170 )  >0 )
           and ( pos(Q.fieldbyname('moes_status').asstring,'X;Y')=0 )
          then begin

          if (Q.fieldbyname('moes_tipomov').asstring=Global.CodDevolucaoVenda) and
                ( aliqicms=0 ) then
//             if ( pos( copy(xcst,2,3),'00;10;20;70' ) > 0 ) and then
               aliqicms:=FEstoque.Getaliquotaicms(Q.fieldbyname('move_esto_codigo').asstring,
                          Q.fieldbyname('move_unid_codigo').asstring,
                          Q.fieldbyname('moes_estado').asstring) ;

          if ( pos( copy(xcst,2,2),'20;70' ) > 0 ) and ( (totalitem-baseicms)>0 ) then
            SomanoRegistroDoc( 'C190',xcst,cfop54,aliqicms,totalitem,baseicms,vlricms,baseicmsst,valoricmsstitem,totalitem-baseicms,totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100) )
          else begin
// 22.07.11
            if (totalitem-vlrdesco)>0 then
              SomanoRegistroDoc( 'C190',xcst,cfop54,aliqicms,totalitem-vlrdesco,baseicms,vlricms,baseicmsst,valoricmsstitem,0,(totalitem-vlrdesco)*(Q.fieldbyname('move_aliipi').ascurrency/100) )
            else
              SomanoRegistroDoc( 'C190',xcst,cfop54,aliqicms,totalitem,baseicms,vlricms,baseicmsst,valoricmsstitem,0,totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100) );
          end;
          //if  GetModelo(Q.fieldbyname('moes_tipomov').asstring) <> ModeloNfe then begin
//           with AcbrSpedPisCofins1.Bloco_C.RegistroC170New do begin
          New( PC170 );

//             Sistema.setmessage('Registro C170 movimento de '+fGeral.formatadata(Q.fieldbyname('moes_datamvto').asdatetime));
// 05.09.18 - frete na base de pis e cofins
             totalitem:=totalitem-vlrdesco+vlrfreteitem;

             PC170.NUM_ITEM:=strzero(contitem,3);
             PC170.VL_PIS:=0;
             PC170.VL_IPI:=0;
             PC170.VL_COFINS:=0;
             PC170.ALIQ_COFINS_PERC:=0;
             PC170.ALIQ_IPI:=0;
             PC170.ALIQ_PIS_PERC:=0;
             PC170.VL_BC_IPI:=0;
             PC170.VL_BC_PIS:=0;
             PC170.VL_BC_COFINS:=0;

             PC170.COD_ITEM:=Q.fieldbyname('move_esto_codigo').asstring;
             PC170.DESCR_COMPL:='';
//             PC170.QTD:=Q.fieldbyname('move_qtde').ascurrency;
// 30.07.20 - Novicarnes - Ketlen
             PC170.QTD:=Q.fieldbyname('move_qtde').asfloat;
//             UNID:=FEstoque.GetUnidade(Q.fieldbyname('move_esto_codigo').asstring);
             PC170.UNID:=GetCodigoUnidadeEstoque( Q.fieldbyname('esto_unidade').asstring );
             PC170.VL_ITEM:=totalitem;
             PC170.VL_DESC:=vlrdesco;
             PC170.IND_MOV:=mfsim;
             PC170.CST_ICMS:=GetCSTIcms(xcst);
             PC170.CFOP:=cfop54;
//             COD_NAT:=FNatureza.GetDescricao(cfop54);
//  25.01.11 - nao entendi este cod_nat se � mesmo igual ao cfop
//             PC170.COD_NAT:=cfop54;
// 10.04.17
//             PC170.COD_NAT:=GetCod_Nat(cfop54);

             PC170.VL_BC_ICMS:=baseicms;
             PC170.ALIQ_ICMS:=aliqicms;
             PC170.VL_ICMS:=vlricms;
             PC170.VL_BC_ICMS_ST:=baseicmsst;

             if baseicmsst>0 then
               PC170.ALIQ_ST:=(valoricmsstitem/baseicmsst)*100;

             PC170.VL_ICMS_ST:=valoricmsstitem;
             PC170.IND_APUR:=iaMensal;
// criar campo no cadastro de classificacao de ipi;
// criar campo cadastro de unidades pra identifcar se � contribuiente do IPI
//           if EdUnid_codigo.resultfind.fieldbyname('unid_ipi').asstring='S' then

//             if Q.fieldbyname('moes_tipocad').asstring='C' then
//               PessoaFisica:=FGeral.GetPessoaFisica(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring)
//             else
//               PessoaFisica:='N';


// 09.03.12 - exportacao
// 13.09.12 - retirado nota de produtor - com leonir na novicarnes
// 13.08.13 - colocado nota de produtor - leonir 'mudou de ideia mas nega...rs
             if ( Q.fieldbyname('moes_estado').asstring='EX' )
             or ( Q.fieldbyname('move_tipomov').asstring=Global.CodCompraProdutor ) then begin
               alipis:=0;
               alicofins:=0;
               if ( Q.fieldbyname('move_tipomov').asstring=Global.CodCompraProdutor ) then begin
                 PC170.CST_PIS:=GetCSTPIS( '73' );
                 PC170.CST_COFINS:=GetCSTCOFINS( '73' );
                 PC170.CST_IPI:=GetCSTIPI( '03' );
               end else begin
                 PC170.CST_PIS:=GetCSTPIS( '08' );
                 PC170.CST_COFINS:=GetCSTCOFINS( '08' );
                 PC170.CST_IPI:=GetCSTIPI( '54' );
               end;

             end else begin

               PC170.CST_IPI:=GetCSTIPI( FEstoque.GetCodigoCSTipi(Q.fieldbyname('move_esto_codigo').asstring,ES) );
               if TributaIPI( PC170.CST_IPI ) then begin
                 PC170.VL_BC_IPI:=totalitem;
                 PC170.ALIQ_IPI:=Q.fieldbyname('move_aliipi').ascurrency;
                 PC170.VL_IPI:=totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100);
               end;

//               if (PessoaFisica='S') and (Edconsfinal.Text='N') then begin
//                 PC170.CST_PIS:=stpisOutrasOperacoes;
//                 PC170.CST_COFINS:=stcofinsOutrasOperacoes;
//               end else begin
// 19.08.14 - retirado trato especifico para pessoa fisica - Novicarnes - Leonir
                 if (Es='E')  then begin
//                   PC170.CST_PIS:=GetCSTPIS( FEstoque.GetPISpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'E',Q.fieldbyname('move_transacao').asstring),cfop54,Q.fieldbyname('move_cst').asstring );
//                   PC170.CST_COFINS:=GetCSTCOFINS( FEstoque.GetCOFINSpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'E'),cfop54,Q.fieldbyname('move_cst').asstring );

// 18.10.16  - pegar no ncm
//                   PC170.CST_PIS:=GetCSTPIS( FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );
//                   PC170.CST_COFINS:=GetCSTCOFINS( FCodigosipi.GetCstCofins( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );
                     if Q.FieldByName('moes_plan_codigo').AsInteger  >0 then begin

                         if LIstaDespesasCST53.IndexOf( IntToStr( Q.FieldByName('moes_plan_codigo').AsInteger ) ) >=0  then begin

                           PC170.CST_PIS    := GetCSTPIS( '53' );
                           PC170.CST_COFINS := GetCSTCOFINS( '53' );

                         end else begin

                           PC170.CST_PIS    := GetCSTPIS( FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );
                           PC170.CST_COFINS := GetCSTCOFINS( FCodigosipi.GetCstCofins( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );
// 06.08.19 - Novicarnes - Ketlen - diferencia��o cfe a conta de despesa
                           if campo.Tipo<>'' then begin
                              cstpiscofins:=FPlano.GetCSTPisCofins( Q.FieldByName('moes_plan_codigo').AsInteger);
                              if trim(cstpiscofins)<>'' then begin
                                PC170.CST_PIS    := GetCSTPIS( cstpiscofins );
                                PC170.CST_COFINS := GetCSTCOFINS( cstpiscofins );
                              end;
                           end;

                         end;

                     end else begin

                       PC170.CST_PIS:=GetCSTPIS( FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );
                       PC170.CST_COFINS:=GetCSTCOFINS( FCodigosipi.GetCstCofins( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );

                     end;



                 end else begin

                   PC170.CST_PIS:=GetCSTPIS( FEstoque.GetsituacaotributariaPIS(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring) );
                   PC170.CST_COFINS:=GetCSTCOFINS( FEstoque.GetsituacaotributariaCofins(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring) );

                 end;

//               end;
///////////////////////////// - mudado este if em 24.09.13
{
               if PessoaFisica<>'S' then begin
  //               if (Es='E') and (pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodDevolucaoVenda)=0) then begin
                 if (Es='E')  then begin
                   PC170.CST_PIS:=GetCSTPIS( FEstoque.GetPISpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'E'),cfop54,Q.fieldbyname('move_cst').asstring );
                   PC170.CST_COFINS:=GetCSTCOFINS( FEstoque.GetCOFINSpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'E'),cfop54,Q.fieldbyname('move_cst').asstring );
                 end else begin
                   PC170.CST_PIS:=GetCSTPIS( FEstoque.GetsituacaotributariaPIS(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring) );
                   PC170.CST_COFINS:=GetCSTCOFINS( FEstoque.GetsituacaotributariaCofins(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring) );
                 end;
               end else begin
                 PC170.CST_PIS:=stpisOutrasOperacoes;
                 PC170.CST_COFINS:=stcofinsOutrasOperacoes;
               end;
               }
/////////////////////////////


//               if ( Q.fieldbyname('move_tipomov').asstring=Global.CodTransfEntrada ) then begin
//                 CST_PIS:=GetCSTPIS( '08' );
//                 CST_COFINS:=GetCSTCOFINS( '08' );
//                 CST_IPI:=GetCSTIPI( '03' );
               if ( Q.fieldbyname('move_tipomov').asstring=Global.CodTransfSai ) then begin
                 PC170.CST_PIS:=GetCSTPIS( '08' );
                 PC170.CST_COFINS:=GetCSTCOFINS( '08' );
                 PC170.CST_IPI:=GetCSTIPI( '03' );
               end;
// 04.15.16 - Novicarnes
               ConsumidorFinal:='N';
               if Q.fieldbyname('moes_tipocad').asstring='C' then
                 ConsumidorFinal:=FGeral.GetConsumidorFinal(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring);

// 07.03.12 - capeg cst pis 06
//               if PC170.CST_PIS<>stpisAliquotaZero then begin
               if TributaPIS( PC170.CST_PIS ) and ( TributaConsumidorFinal(consumidorfinal) ) then begin
// 26.10.16
                 if (Es='E')  then
                   alipis:=FCodigosipi.GetPerPis( FEstoque.GetCodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring) )
                 else
                   alipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                           Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );

                 PC170.VL_BC_PIS:=totalitem ;

               end else

                 alipis:=0;

               if TributaCOFINS( PC170.CST_COFINS ) and ( TributaConsumidorFinal(consumidorfinal) ) then begin

                 if (Es='E')  then
                   alicofins:=FCodigosipi.GetPerCofins( FEstoque.GetCodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring) )
                 else
                   alicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                          Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  )    ;
                 PC170.VL_BC_COFINS:=totalitem;

               end else

                 alicofins:=0;

               PC170.ALIQ_PIS_PERC:=alipis;
  //             ALIQ_PIS_R:=0;
  //             QUANT_BC_PIS:=0;  // somente pra quem calcula sobre a qtde vendida
  //             VL_PIS:=roundvalor(totalitem*(alipis/100));
               PC170.VL_PIS:=(totalitem*(alipis/100));
               PC170.ALIQ_COFINS_PERC:=alicofins;
               PC170.VL_COFINS:=(totalitem*(alicofins/100));

             end; // se nao for exportacao nem compra de produtor

             if es='E' then begin

                if pos( Q.fieldbyname('moes_natf_codigo').asstring,CfopsIsentosEntradas ) >0 then begin

                  PC170.VL_BC_IPI:=0;
                  PC170.VL_BC_PIS:=0;
                  PC170.VL_BC_COFINS:=0;
                  PC170.VL_IPI:=0;
                  PC170.VL_PIS:=0;
                  PC170.VL_COFINS:=0;
                  PC170.CST_PIS:=GetCSTPIS( '74' );
                  PC170.CST_COFINS:=GetCSTCOFINS( '74' );
                  PC170.CST_IPI:=GetCSTIPI( '03' );

                end

             end else begin

                if pos( Q.fieldbyname('moes_natf_codigo').asstring,CfopsIsentosSaidas ) >0 then begin

                  PC170.VL_BC_IPI:=0;
                  PC170.VL_BC_PIS:=0;
                  PC170.VL_BC_COFINS:=0;
                  PC170.VL_IPI:=0;
                  PC170.VL_PIS:=0;
                  PC170.VL_COFINS:=0;
                  PC170.CST_PIS:=GetCSTPIS( '08' );
                  PC170.CST_COFINS:=GetCSTCOFINS( '08' );
                  PC170.CST_IPI:=GetCSTIPI( '53' );
                end
             end;

             PC170.COD_ENQ:='';
// ver do que se trata e se precisa criar campo no cadastro de classif. do ipi
// acumulador do registro ref. IPI - ver de aproveita a funcao ou cria outra
//             SomanoRegistro( 'E510',CST_IPI,cfop54,aliqicms,totalitem,baseicms,vlricms,baseicmsst,valoricmsstitem,totalitem-baseicms,totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100) );

// checar se pode ser 'pego' atrav�s da config. de movimento...
//             PC170.COD_CTA:='000';
//  18.10.17
             PC170.COD_CTA:=GetCod_Cta(Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);

             PC170.ALIQ_ST:=0;
          // end;
             inc(contitem);
             PC170.ttransacaoc100:=Q.fieldbyname('move_transacao').asstring+';'+Q.fieldbyname('move_tipomov').asstring;

             ListaC170.Add(PC170)
//           end;  // C170

// 14.10.11 - se alguma dia descobrir como percorrer os registro gravados
//            no componente...
//           for p:=0 AcbrSpedPisCofins1.Bloco_C.RegistroC100Count do begin
//               ACBrSPEDPisCofins1.Bloco_C.
//               VL_PIS:=VL_PIS+(totalitem*(alipis/100));
//               VL_COFINS:=VL_COFINS+(totalitem*(alicofins/100));
//           end;

//////////////////////////////////////////////////////////////////////////////////////////////
        end else if Pos( Q.fieldbyname('moes_tipomov').asstring,Global.CodPrestacaoServicos+';'+Global.CodPrestacaoServicosE )  > 0 then begin

// 15.05.17
          BuscaNosItems(Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
                        Q.fieldbyname('moes_perdesco').ascurrency,valorpis,valorcofins,'N',0,Q.FieldByName('moes_plan_codigo').AsInteger);

//          if (valorpis+valorcofins) > 0 then begin
// 29.10.18 - Novicarnes - ketlen

            with AcbrSpedPisCofins1.Bloco_A do begin

              with RegistroA170New do begin

                 NUM_ITEM:=contitem;
                 COD_ITEM:=Q.fieldbyname('move_esto_codigo').asstring;
                 DESCR_COMPL:='';
                 VL_ITEM:=totalitem;
                 VL_DESC:=vlrdesco;
// 20.03.18 - Novicarnes - Ketlen contadora nao preencher quando servi�o prestado
                 if Q.fieldbyname('moes_tipomov').asstring<>Global.CodPrestacaoServicos then begin
  //                 NAT_BC_CRED:=bccAtPresServ
  // 12.12.13 -validador nao deixou
//                   NAT_BC_CRED:=bccOutrasOpeComDirCredito
                   NAT_BC_CRED:=bccAqServUtiComoInsumo;
                   IND_ORIG_CRED:=opcMercadoInterno;
                 end else
// 05.09.18 - se nao fizer assim fica com 0 segundo ketlen
                   IND_ORIG_CRED:=opcVazio;
  // 15.05.17
                 if Es='E' then begin
  //                 CST_PIS:=GetCSTPIS( FEstoque.GetPISpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'E','N',Q.fieldbyname('move_transacao').asstring),Q.fieldbyname('moes_natf_codigo').asstring,Q.fieldbyname('move_cst').asstring )
// 19.10.18 - Novicarnes - Ketlen
                     if Q.FieldByName('moes_plan_codigo').AsInteger  >0 then begin

                         if LIstaDespesasCST53.IndexOf( IntToStr( Q.FieldByName('moes_plan_codigo').AsInteger ) ) >=0  then begin

                           CST_PIS:=GetCSTPIS( '53' );
                           CST_COFINS:=GetCSTCOFINS( '53' );

                         end else begin

                           CST_PIS:=GetCSTPIS( FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );
                           CST_COFINS:=GetCSTCOFINS( FCodigosipi.GetCstCofins( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );
// 26.04.19 - Novicarnes - Ketlen - diferencia��o cfe a conta de despesa
                           if campo.Tipo<>'' then begin
                              cstpiscofins:=FPlano.GetCSTPisCofins( Q.FieldByName('moes_plan_codigo').AsInteger);
                              if trim(cstpiscofins)<>'' then begin
                                CST_PIS:=GetCSTPIS( cstpiscofins );
                                CST_COFINS:=GetCSTCOFINS( cstpiscofins );
                              end;
                           end;

                         end;

                     end else begin

                       CST_PIS:=GetCSTPIS( FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );
                       CST_COFINS:=GetCSTCOFINS( FCodigosipi.GetCstCofins( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );

                     end;

                 end else

                   CST_PIS:=GetCSTPIS( FEstoque.GetsituacaotributariaPIS(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring) );

                 if TributaPIS( CST_PIS ) then begin
                   alipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                         Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
                   VL_BC_PIS:=totalitem-vlrdesco;
//   02.08.19 - Novicarnes - Ketlen
                   if CST_PIS = GetCSTPIS( '53' ) then alipis:=1.65;

                 end else
                   alipis:=0;

                 ALIQ_PIS:=alipis;
                 VL_PIS:=(totalitem-vlrdesco)*(alipis/100);
                 if Es='E' then
  //                 CST_COFINS:=GetCSTCOFINS( FEstoque.GetPISpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'E'),Q.fieldbyname('moes_natf_codigo').asstring,Q.fieldbyname('move_cst').asstring )
  // 26.08.15
   //                CST_COFINS:=GetCSTCOFINS( FEstoque.GetCOFINSpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'E'),Q.fieldbyname('moes_natf_codigo').asstring,Q.fieldbyname('move_cst').asstring )
                 else
                   CST_COFINS:=GetCSTCOFINS( FEstoque.GetsituacaotributariaCofins(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring) );
                 VL_BC_COFINS:=0;
                 if TributaCOFINS( CST_COFINS ) then begin
                   alicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                         Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
                   VL_BC_COFINS:=totalitem-vlrdesco;
                 end else
                   alicofins:=0;
//   02.08.19 - Novicarnes - Ketlen
                 if CST_COFINS  = GetCSTCOFINS( '53' ) then alicofins:=7.60;

                 ALIQ_COFINS:=alicofins;
                 VL_COFINS:=(totalitem-vlrdesco)*(alicofins/100);
     //            COD_CTA:='';
                 COD_CTA:=GetCod_Cta(Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);
                 COD_CCUS:='';
                 inc(contitem);
  // 31.03.17
                 if Lista75aux.IndexOf(Q.fieldbyname('move_esto_codigo').asstring)=-1 then begin
                   Lista75.Add(Q.fieldbyname('move_esto_codigo').asstring);
                   Lista75aux.Add(Q.fieldbyname('move_esto_codigo').asstring);
                 end;
  ////////////////////
              end;

            end;

//          end;
/////////////////////////////////////////////////////////////////////////////////////////////

        end else if Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , '06' )  >0 then begin
//////////////////////////////
// fatura de energia el�trica
//////////////////////////////
//////////////// C501 - 'item' de energia el�trica  - ref. PIS
           with AcbrSpedPisCofins1.Bloco_C.RegistroC501New do begin
               alipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                     Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );

//               CST_PIS:=stpisOperCredExcRecTribMercInt;
// 12.03.12
//               if Uppercase(Q.fieldbyname('esto_unidade').asstring)='KW' then
               if pos( 'ENERGIA',Uppercase(Q.fieldbyname('esto_descricao').asstring) ) = 0  then
//                 CST_PIS:=GetCSTPIS( '03' )
// 19.10.12 - Clessi
                 CST_PIS:=GetCSTPIS( '54' )
               else
//                 CST_PIS:=GetCSTPIS( FEstoque.GetPISpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'E',Q.fieldbyname('move_transacao').asstring),cfop54,Q.fieldbyname('move_cst').asstring );
// 12.12.17 para pegar o cst pelo ncm de entrada
                 CST_PIS:=GetCSTPIS( FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );

//               VL_ITEM:=baseicms;
               VL_ITEM:=totalitem;
               NAT_BC_CRED:=bccEnergiaEletricaTermica;
//               VL_BC_PIS:=baseicms;
               if cst_pis<>stpisQtdeAliquotaUnidade then begin
                 VL_BC_PIS:=totalitem-vlrdesco;
                 ALIQ_PIS:= alipis;
                 VL_PIS:=((totalitem-vlrdesco)*(alipis/100));
               end else
                 alipis:=0;
//               VL_PIS:=roundvalor(baseicms*(alipis/100));
//               VL_PIS:=roundvalor(totalitem*(alipis/100));
  // checar se pode ser 'pego' atrav�s da config. de movimento...
//               COD_CTA:='000';
               COD_CTA:=GetCod_Cta(Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);
           end;
////////////////
//////////////// C505 - 'item' de energia el�trica  - ref. Cofins
           with AcbrSpedPisCofins1.Bloco_C.RegistroC505New do begin
               alicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                     Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
//               CST_COFINS:=stCofinsValorAliquotaNormal;
//               CST_COFINS:=stCofinsOperCredExcRecTribMercInt;
// 12.03.12
//               if Uppercase(Q.fieldbyname('esto_unidade').asstring)='KW' then
               if pos( 'ENERGIA',Uppercase(Q.fieldbyname('esto_descricao').asstring) ) = 0  then
//                 CST_COFINS:=GetCSTcofins( '03' )
// 19.10.12 - Clessi
                 CST_COFINS:=GetCSTcofins( '54' )
               else
                 CST_COFINS:=GetCSTCOFINS( FEstoque.GetCOFINSpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'E'),cfop54,Q.fieldbyname('move_cst').asstring );
// 12.12.17 para pegar o cst pelo ncm de entrada
                 CST_COFINS:=GetCSTCOFINS( FCodigosipi.GetCstCofins( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );
//               VL_ITEM:=baseicms;
               VL_ITEM:=totalitem;
               NAT_BC_CRED:=bccEnergiaEletricaTermica;
//               VL_BC_COFINS:=baseicms;
               if cst_cofins<>stcofinsQtdeAliquotaUnidade then begin
                 VL_BC_COFINS:=totalitem;
                 ALIQ_COFINS:= alicofins;
                 VL_COFINS:=(totalitem*(alicofins/100));
               end else
                 alicofins:=0;
//               VL_COFINS:=roundvalor(baseicms*(alipis/100));
//               VL_COFINS:=roundvalor(totalitem*(alipis/100));
  // checar se pode ser 'pego' atrav�s da config. de movimento...
//               COD_CTA:='000';
               COD_CTA:=GetCod_Cta(Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);
           end;
////////////////

        end;

      end;  // serie D nao tem itens

// cfop de notas eletronicas nao inclui pois nao gera o registro C170
// no pis/cofins SIM...
//      if  GetModelo(Q.fieldbyname('moes_tipomov').asstring) <> ModeloNfe then begin
      if ( pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModelosnaoGeraItem )=0 ) and
         ( pos(Q.fieldbyname('moes_status').AsString,'X;Y')=0 )
        then begin
        if ListaTodosCfops.IndexOf(cfop54)=-1 then
          ListaTodosCfops.Add(cfop54);
      end;
{ // 31.03.17 - mudado de lugar pra nao gerar produtos q estejam no movimento
//              gerado pra o sped
// codigo de produto de notas eletronicas nao inclui pois nao gera o registro C170
// 13.10.11 - no pis/cofins gera
//      if  GetModelo(Q.fieldbyname('moes_tipomov').asstring) <> ModeloNfe then begin
      if ( pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring), ModelosnaoGeraItem )=0 ) and
         ( pos(copy(Q.fieldbyname('moes_natf_codigo').AsString,1,1),'1;2')>0 ) and
         ( pos(Q.fieldbyname('moes_status').AsString,'X;Y')=0 )
        then begin
        if Lista75aux.IndexOf(Q.fieldbyname('move_esto_codigo').asstring)=-1 then begin
          Lista75.Add(Q.fieldbyname('move_esto_codigo').asstring);
          Lista75aux.Add(Q.fieldbyname('move_esto_codigo').asstring);
        end;
      end;
}
      Q.Next;

    end;  // ref. detalhes

//  end;


// aqui gerar o C190 para entradas e C180 para saidas mas SOMENTE NFE
// pra cada documento resumo por cst, aliquota...e em seguida zerar
// a lista para o proximo documento
// como gero o registro 100 nao � necessario informar C180/C190 � opcional
/////////////////////////////////////////////////////////////////////////////////
{
    for p:=0 to ListaDocumentoCst.Count-1 do begin
       PDocumentoCst:=ListaDocumentoCst[p];
       with ACBrSPEDPisCofins1.Bloco_C do begin
         if pos( copy(PDocumentoCst.cfop,1,1),'123' ) > 0 then begin
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
          end else begin
            with RegistroC180New do begin
            end;
          end;
//            AcumulaReg('E110',PDocumentoCst.cfop,PDocumentoCst.vl_icms);
       end;
    end;
    }
/////////////////////////////////////////////////////////////////////////////////

    ListaDocumentoCst.Free;

    ListaBases.free;
    ListaCfops.free;
    ListaCSTs.free;

// em savefiletxt ja faz 'os writeBlocos...'

    if QGeral<>nil then begin
      Qgeral.close;
      Freeandnil(QGeral);
    end;

  end; // ref. mestre Q.eof

//////////////////////////////////////////////////////
// REGISTRO 140 ref. aos 'estabelecimentos' da empresa
//////////////////////////////////////////////////////
//       Sqlunidades:=' unid_codigo='+EdUnid_codigo.assql;
//       Sqlunidades:=' unid_codigo='+Stringtosql(QUnidades.fieldbyname('Unid_codigo').asstring);
//  if Global.Topicos[1015] then
//       while not QUnidades.eof do begin
         with ACbrSpedPisCofins1.Bloco_0.Registro0140New do begin

           COD_EST:=QUnidades.fieldbyname('Unid_codigo').asstring;
           NOME:=QUnidades.fieldbyname('unid_razaosocial').asstring;
           CNPJ:=QUnidades.fieldbyname('unid_cnpj').asstring;
           UF:=QUnidades.fieldbyname('unid_uf').asstring;
           IE:=TiraSintegra(QUnidades.fieldbyname('unid_inscricaoestadual').asstring);
//           COD_MUN:=strtointdef(codmuniemitente,0);
// 04.03.12
           COD_MUN:=strtointdef(FCidades.GetCodigoIBGE(QUnidades.fieldbyname('unid_cida_codigo').asinteger) ,0);
           IM:=TiraSintegra(QUnidades.fieldbyname('unid_inscricaomunicipal').asstring);
         end;
// 07.03.12
// 'Participantes' : clientes , fornecedores e transportadores com movimento no periodo
///////////////////////////////////////////////////////////////////////
         codigopais:='1058';

         for p:=0 to ListaParticipantes.count-1 do begin

           with ACbrSpedPisCofins1.Bloco_0.Registro0150New do begin

             PParticipa:=ListaParticipantes[p];
             PesquisaEntidade(PParticipa.tipocad,PParticipa.codigosac);
             COD_PART:=inttostr(PParticipa.codigo);

             if PParticipa.tipocad='C' then begin

               NOME:=QGeral.fieldbyname('clie_razaosocial').asstring;
               COD_PAIS:=codigopais;
               if (QGeral.fieldbyname('clie_uf').asstring)='EX' then begin
  //                if Q.fieldbyname('moes_tipocad').AsString='F' then begin
  //                  Dest.EnderDest.cPais:=strtointdef(FCidades.GetCodigoPais(QDesti.fieldbyname('Forn_cida_codigo').asinteger),0);
  //                  Dest.EnderDest.xPais:=Ups(FCidades.GetNomePais(QDesti.fieldbyname('Forn_cida_codigo').asinteger));
  //                end else begin
                    COD_PAIS:=FCidades.GetCodigoPais(QGeral.fieldbyname('clie_cida_codigo_res').asinteger);
  //                end;
               end else begin
                 {
                 if QGeral.fieldbyname('clie_tipo').asstring='J' then begin
                   CNPJ:=QGeral.fieldbyname('clie_cnpjcpf').asstring;
                   if AnsiPos( Uppercase(QGeral.fieldbyname('clie_rgie').asstring),'ISENTO;ISENTA' ) = 0 then
                     IE:=QGeral.fieldbyname('clie_rgie').asstring;
                 end else
                   CPF:=QGeral.fieldbyname('clie_cnpjcpf').asstring;
                   }
// 14.03.16 - devido a clientes importados errada da fama como pessoa juridica mas tendo cpf
                 if length(trim(QGeral.fieldbyname('clie_cnpjcpf').asstring))=14 then begin
                   CNPJ:=QGeral.fieldbyname('clie_cnpjcpf').asstring;
                   if AnsiPos( Uppercase(QGeral.fieldbyname('clie_rgie').asstring),'ISENTO;ISENTA' ) = 0 then
                     IE:=QGeral.fieldbyname('clie_rgie').asstring;
                 end else
                   CPF:=QGeral.fieldbyname('clie_cnpjcpf').asstring;
               end;
               COD_MUN:=strtointdef( FCidades.GetCodigoIBGE(QGeral.fieldbyname('clie_cida_codigo_res').asinteger),7 );
               ENDERECO:=QGeral.fieldbyname('clie_endres').asstring;
               numero:=GetNumerodoEndereco(QGeral.fieldbyname('clie_endres').asstring,QGeral.fieldbyname('clie_codigo').AsInteger,'N');
               NUM:=numero;
               COMPL:=QGeral.fieldbyname('Clie_endrescompl').asstring;
               BAIRRO:=QGeral.fieldbyname('clie_bairrores').asstring;

             end else if PParticipa.tipocad='T' then begin

               NOME:=Arq.TTransp.fieldbyname('tran_razaosocial').asstring;
               COD_PAIS:=codigopais;
               if FTransp.GetUF(Arq.TTransp.fieldbyname('tran_codigo').asinteger)='EX' then begin
                    COD_PAIS:=FCidades.GetCodigoPais(Arq.TTransp.fieldbyname('tran_cida_codigo').asinteger);
               end;
               if length( trim(Arq.TTransp.fieldbyname('tran_cnpjcpf').asstring) )=14 then
                 CNPJ:=Arq.TTransp.fieldbyname('tran_cnpjcpf').asstring
               else
                 CPF:=Arq.TTransp.fieldbyname('tran_cnpjcpf').asstring;
               IE:=TiraSintegra( Arq.TTransp.fieldbyname('tran_inscricaoestadual').asstring );
               COD_MUN:=strtointdef( FCidades.GetCodigoIBGE(Arq.TTransp.fieldbyname('tran_cida_codigo').asinteger),7 ) ;
               ENDERECO:=Arq.TTransp.fieldbyname('tran_endereco').asstring;
               numero:=GetNumerodoEndereco(Arq.TTransp.fieldbyname('tran_endereco').asstring,Arq.TTransp.fieldbyname('tran_codigo').AsInteger,'N');
               NUM:=numero;
               COMPL:='';
               BAIRRO:=Arq.TTransp.fieldbyname('tran_bairro').asstring;

             end else if PParticipa.tipocad='U' then begin  // 07.03.12 - clessi

          {
               NOME:=EdUnid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring;
               COD_PAIS:=codigopais;
               if EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring='EX' then begin
                    COD_PAIS:=FCidades.GetCodigoPais(Arq.TTransp.fieldbyname('unid_cida_codigo').asinteger);
               end;
               if length( trim(EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring) )=14 then
                 CNPJ:=EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring
               else
                 CPF:=EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring;
               IE:=TiraSintegra( EdUnid_codigo.resultfind.fieldbyname('unid_inscricaoestadual').asstring );
               COD_MUN:=strtointdef( FCidades.GetCodigoIBGE(EdUnid_codigo.resultfind.fieldbyname('unid_cida_codigo').asinteger),7 ) ;
               ENDERECO:=EdUnid_codigo.resultfind.fieldbyname('unid_endereco').asstring;
               numero:=GetNumerodoEndereco(EdUnid_codigo.resultfind.fieldbyname('unid_endereco').asstring,EdUnid_codigo.resultfind.fieldbyname('unid_codigo').AsInteger,'N');
               NUM:=numero;
               COMPL:='';
               BAIRRO:=EdUnid_codigo.resultfind.fieldbyname('unid_bairro').asstring;
}
// 08.02.19 - pesquisa na unidade mesmo e nao pelo edit
//             pra ver resolve a questao das transferencias
               NOME:=Arq.TUnidades.fieldbyname('unid_razaosocial').asstring;
               COD_PAIS:=codigopais;
               if Arq.TUnidades.fieldbyname('unid_uf').asstring='EX' then begin
                    COD_PAIS:=FCidades.GetCodigoPais(Arq.TTransp.fieldbyname('unid_cida_codigo').asinteger);
               end;
               if length( trim(Arq.TUnidades.fieldbyname('unid_cnpj').asstring) )=14 then
                 CNPJ:=Arq.TUnidades.fieldbyname('unid_cnpj').asstring
               else
                 CPF:=Arq.TUnidades.fieldbyname('unid_cnpj').asstring;
               IE:=TiraSintegra( Arq.TUnidades.fieldbyname('unid_inscricaoestadual').asstring );
               COD_MUN:=strtointdef( FCidades.GetCodigoIBGE(Arq.TUnidades.fieldbyname('unid_cida_codigo').asinteger),7 ) ;
               ENDERECO:=Arq.TUnidades.fieldbyname('unid_endereco').asstring;
               numero:=GetNumerodoEndereco(Arq.TUnidades.fieldbyname('unid_endereco').asstring,EdUnid_codigo.resultfind.fieldbyname('unid_codigo').AsInteger,'N');
               NUM:=numero;
               COMPL:='';
               BAIRRO:=Arq.TUnidades.fieldbyname('unid_bairro').asstring;

             end else begin  // por enquanto somente fornecedores

               NOME:=QGeral.fieldbyname('forn_razaosocial').asstring;
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
               COD_MUN:=strtointdef( FCidades.GetCodigoIBGE(QGeral.fieldbyname('forn_cida_codigo').asinteger),0 );
               ENDERECO:=QGeral.fieldbyname('forn_endereco').asstring;
               numero:=GetNumerodoEndereco(QGeral.fieldbyname('forn_endereco').asstring,QGeral.fieldbyname('forn_codigo').AsInteger,'N');
               NUM:=numero;
               COMPL:='';
               BAIRRO:=QGeral.fieldbyname('forn_bairro').asstring;
             end;
           end;  // participantes
         end;

//         ListaParticipantes.free;

//////////////////////////////////////////////////////////////////////
///////////////// - 07.03.12
// Cadastros de natureza de operacao...'quase os cfops'
///////////////////////////////////////////////////////////////////////
{
         for p:=0 to ListaTodosCfops.count-1 do begin
           with ACbrSpedPisCofins1.Bloco_0.Registro0400New do begin
             COD_NAT:=ListaTodosCfops[p];
             DESCR_NAT:=FNatureza.GetDescricao( ListaTodosCfops[p] ) ;
           end;
         end;
         }
         {
         for p:=0 to ListaCod_Nat.count-1 do begin
           with ACbrSpedPisCofins1.Bloco_0.Registro0400New do begin
             PCod_Nat:=ListaCod_Nat[p];
             COD_NAT:=PCod_Nat.cod_nat;
             DESCR_NAT:=copy(PCod_Nat.descr_nat,1,60);
           end;
         end;
         }
///////////////////////////////////////////////////////////////////////////
         ListaTodosCfops.free;
//         ListaUnidades.free;
         for p:=0 to ListaC100.Count-1 do begin
           with ACbrSpedPisCofins1.Bloco_C.RegistroC100New do begin
            PC100:=ListaC100[p];
            IND_OPER:=PC100.IND_OPER;
            IND_EMIT:=PC100.IND_EMIT;
            COD_MOD:=PC100.COD_MOD;
            NUM_DOC:=PC100.NUM_DOC;
            COD_SIT:=PC100.COD_SIT;
            CHV_NFE:=PC100.CHV_NFE;
            COD_SIT:=PC100.COD_SIT;

//            if PC100.COD_SIT=sdRegular then begin
// 25.10.19 - Novicarnes - NFAe...
            if (PC100.COD_SIT=sdRegular) or ( PC100.COD_SIT=sdRegimeEspecNEsp ) then begin
              COD_PART:=PC100.COD_PART ;
              SER:=PC100.SER;
              DT_DOC:=PC100.DT_DOC;
              DT_E_S:=PC100.DT_E_S;
              VL_DOC:=PC100.VL_DOC;
              IND_PGTO:=PC100.IND_PGTO;
              VL_DESC:=PC100.VL_DESC;
              VL_MERC:=PC100.VL_MERC;
              VL_FRT:=PC100.VL_FRT;
              VL_SEG:=PC100.VL_SEG;
              IND_FRT:=PC100.IND_FRT;
              if PC100.VL_OUT_DA>0 then
                 VL_OUT_DA:=PC100.VL_OUT_DA;
              if PC100.VL_BC_ICMS >0 then
                VL_BC_ICMS:=PC100.VL_BC_ICMS;
              if PC100.VL_ICMS>0 then
                VL_ICMS:=PC100.VL_ICMS;
              if PC100.VL_BC_ICMS_ST > 0 then
                VL_BC_ICMS_ST:=PC100.VL_BC_ICMS_ST;
              if PC100.VL_ICMS_ST>0 then
                VL_ICMS_ST:=PC100.VL_ICMS_ST;
// para o caso de ser informado nos totais da nf de entrada e nao nos itens...
//              if Q.fieldbyname('move_aliipi').ascurrency>0 then
                if PC100.VL_IPI>0 then
                  VL_IPI:=PC100.VL_IPI;
//checar - ver se cria fun��o para buscar pela transacao+tipo de movimento
//         nos itens ( pis e cofins )
//              alipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
//                      Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
//              alicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
//                      Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
//              VL_PIS:=roundvalor(Q.fieldbyname('moes_baseicms').ascurrency*(alipis/100));
//              VL_COFINS:=roundvalor(Q.fieldbyname('moes_baseicms').ascurrency*(alicofins/100));
//              VL_PIS:=roundvalor(Q.fieldbyname('moes_totprod').ascurrency*(alipis/100));
//              VL_COFINS:=roundvalor(Q.fieldbyname('moes_totprod').ascurrency*(alicofins/100));

                if PC100.VL_PIS>0 then
                  VL_PIS:=PC100.VL_PIS;
                if PC100.VL_COFINS>0 then
                  VL_COFINS:=PC100.VL_COFINS;
//              end;
              if PC100.VL_PIS_ST>0 then
                VL_PIS_ST:=PC100.VL_PIS_ST;
//              if (trim(Q.fieldbyname('moes_chavenfe').asstring)<>'') and ( EmissaoPropria(Q.fieldbyname('moes_chavenfe').asstring) ) then
//                CHV_NFE:=copy(Q.fieldbyname('moes_chavenfe').asstring,1,44);
              if PC100.VL_COFINS_ST>0 then
                VL_COFINS_ST:=PC100.VL_COFINS_ST;
             end;  // se for documento em situacao regular
           end; // inclui registro C100

           basetotal:=PC100.VL_BC_ICMS;
           baseacumulada:=GetBaseitens(copy(PC100.ttransacao,1,pos(';',pc100.ttransacao)-1));
           icmsacumulado:=0;
           ok:=true;
           for i:=0 to ListaC170.Count-1 do begin
             PC170:=ListaC170[i];
             if PC170.ttransacaoc100=PC100.ttransacao then begin
                with ACbrSpedPisCofins1.Bloco_C.RegistroC170New do begin
                ///////////////////////////////////////////////////////
                   NUM_ITEM:=PC170.NUM_ITEM;
                   COD_ITEM:=PC170.COD_ITEM;
                   DESCR_COMPL:=PC170.DESCR_COMPL;
                   QTD:=PC170.QTD;
      //             UNID:=FEstoque.GetUnidade(Q.fieldbyname('move_esto_codigo').asstring);
                   UNID:=PC170.UNID;
                   VL_ITEM:=PC170.VL_ITEM;
                   VL_DESC:=PC170.VL_DESC;
                   IND_MOV:=PC170.IND_MOV;
                   CST_ICMS:=PC170.CST_ICMS;
                   CFOP:=PC170.CFOP;
      //             COD_NAT:=FNatureza.GetDescricao(cfop54);
      //  25.01.11 - nao entendi este cod_nat se � mesmo igual ao cfop
                   COD_NAT:=PC170.COD_NAT;
// 13.04.17
                   COD_NAT:=GetCod_Nat(PC170.CFOP);
// 19.05.17
{
                   if  ( baseacumulada+0.01 ) < Basetotal then begin
                     VL_BC_ICMS:=PC170.VL_BC_ICMS;
                     ALIQ_ICMS:=PC170.ALIQ_ICMS;
                     VL_ICMS:=PC170.VL_ICMS;
                     baseacumulada:=baseacumulada+PC170.VL_BC_ICMS;
                     icmsacumulado:=icmsacumulado+PC170.VL_ICMS;
                   end;
}

                   VL_BC_ICMS:=PC170.VL_BC_ICMS;
                   ALIQ_ICMS:=PC170.ALIQ_ICMS;
                   VL_ICMS:=PC170.VL_ICMS;
// 20.05.17
                   if  ( FGEral.Arredonda( Abs(Basetotal-Baseacumulada),2 ) = FGEral.Arredonda(PC170.VL_BC_ICMS,2) ) and ( Baseacumulada>0)
                   OR
                     ( FGEral.Arredonda( Abs(Basetotal-Baseacumulada)+0.01,2 ) = FGEral.Arredonda(PC170.VL_BC_ICMS,2) ) and ( Baseacumulada>0)
                   OR
                     ( FGEral.Arredonda( Abs(Basetotal-Baseacumulada)-0.01,2 ) = FGEral.Arredonda(PC170.VL_BC_ICMS,2) ) and ( Baseacumulada>0)
                   then begin
                     VL_BC_ICMS:=0;
                     ALIQ_ICMS:=0;
                     VL_ICMS:=0;
                     CST_ICMS:=GetCSTIcms('040');
                   end;

                   VL_BC_ICMS_ST:=PC170.VL_BC_ICMS_ST;
                   ALIQ_ST:=PC170.ALIQ_ST;
                   VL_ICMS_ST:=PC170.VL_ICMS_ST;
                   IND_APUR:=PC170.IND_APUR;
                   CST_PIS:=PC170.CST_PIS;
                   CST_COFINS:=PC170.CST_COFINS;
                   CST_IPI:=PC170.CST_IPI;
                   if PC170.VL_BC_IPI>0 then
                     VL_BC_IPI:=PC170.VL_BC_IPI;
                   if PC170.ALIQ_IPI>0 then
                     ALIQ_IPI:=PC170.ALIQ_IPI;
                   if PC170.VL_IPI>0 then
                     VL_IPI:=PC170.VL_IPI;
                   if PC170.VL_BC_PIS>0 then
                     VL_BC_PIS:=PC170.VL_BC_PIS;
                   if PC170.ALIQ_PIS_PERC>0 then
                     ALIQ_PIS_PERC:=PC170.ALIQ_PIS_PERC;
                   if PC170.VL_PIS>0 then
                     VL_PIS:=PC170.VL_PIS;
                   if PC170.VL_BC_COFINS>0 then
                     VL_BC_COFINS:=PC170.VL_BC_COFINS;
                   if PC170.ALIQ_COFINS_PERC>0 then
                     ALIQ_COFINS_PERC:=PC170.ALIQ_COFINS_PERC;

                   COD_ENQ:='';
                   if PC170.VL_COFINS>0 then
                     VL_COFINS:=PC170.VL_COFINS;
      // checar se pode ser 'pego' atrav�s da config. de movimento...
      //             COD_CTA:='000';
                   COD_CTA:=PC170.COD_CTA;
                ///////////////////////////////////////////////////
// 31.03.17
                  if Lista75aux.IndexOf(PC170.COD_ITEM)=-1 then begin
                    Lista75.Add(PC170.COD_ITEM);
                    Lista75aux.Add(PC170.COD_ITEM);
                  end;
//////////////////
                end;
             end;
           end; // for listac170
         end;  // for listac100
         if ListaC100<>nil then ListaC100.free;
         if ListaC170<>nil then ListaC170.free;

//////////////////////////////////////
////////////////////////////
//////////////////////////////////////////////////////////
//  QUNIDADES.NEXT;
// 31.03.17
// Codigos de Unidade de Estoque - um cadastro para cada estabelecimento ? - 07.03.2012
///////////////////////////////////////////////////////////////////////
         for p:=0 to ListaUnidades.count-1 do begin
           with ACbrSpedPisCofins1.Bloco_0.Registro0190New do begin
             PUnidades:=ListaUnidades[p];
             UNID:=strzero(PUnidades.codigo,6);
             DESCR:=PUnidades.descricao;
           end;
         end;

// 13.04.17 - registro 0400 - cod_nat
///////////////////////////
          for p:=0 to ListaCod_Nat.count-1 do begin
                   with ACbrSpedPisCofins1.Bloco_0.Registro0400New do begin
                     PCod_Nat:=ListaCod_Nat[p];
                     COD_NAT:=PCod_Nat.cod_nat;
                     DESCR_NAT:=copy(PCod_Nat.descr_nat,1,60);
                   end;
          end;



//////////////////////////////////////////////////////////
///  18.10.17 - aqui para gerar o reg. 500
  QUNIDADES.NEXT;

////////////////////////////////////// - 07.03.12
// Cadastros dos itens do estoque e servicos
///////////////////////////////////////////////////////////////////////
       for p:=0 to Lista75.count-1 do begin
         with ACbrSpedPisCofins1.Bloco_0.Registro0200New do begin
           COD_ITEM:=Lista75[p];
           QE:=Sqltoquery('select * from estoque where esto_codigo='+Stringtosql(cod_item));
           if not QE.eof then begin
             DESCR_ITEM:=trim(QE.fieldbyname('esto_descricao').asstring);
// ver se � somente codigo de barra 'oficial' ou pode ser de uso interno tbem
             if copy(QE.fieldbyname('Esto_codbarra').asstring,1,3)='789' then
               COD_BARRA:=QE.fieldbyname('Esto_codbarra').asstring;
             COD_ANT_ITEM:='';
             UNID_INV:=GetCodigoUnidadeEstoque(QE.fieldbyname('Esto_unidade').asstring);
// ver para criar campo no cadastro de grupos do estoque
// por enquanto
// 03.08.20 - retirado pois o codigo do servico usado no reinfo q tbem fica no campo da referencia
//            n�o � o mesmo usado pelo sped contribuicoes
//             if ( pos('FRETE',Uppercase(QE.fieldbyname('esto_descricao').asstring)) > 0 )
//                or
//                ( FEstoque.Servico(QE.fieldbyname('esto_codigo').asstring,EdUnid_codigo.text,EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring ) )
//               then begin
//               TIPO_ITEM:=tiServicos;
//               COD_LST:=QE.fieldbyname('esto_referencia').asstring;
// 12.01.18
//               COD_NCM:='00';

//             end else begin

               TIPO_ITEM:=tiMercadoriaRevenda;
               COD_NCM:=FEstoque.GetNCMipi(cod_item);

//             end;
//////////////////             if trim(COD_NCM)='' then COD_NCM:='02012090';
///////////////////////////////////////////////////////////////////////////
             EX_IPI:='';
             COD_GEN:=copy(cod_ncm,1,2);
// ver colocar este codigo em novo campo no sub-grupo do estoque
//             if FEstoque.Servico(cod_item,EdUNid_codigo.text,EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring) then
//               COD_LST:=
             ALIQ_ICMS:=FCodigosFiscais.GetAliquota( FEstoque.GetCodigoFiscal(cod_item,EdUnid_codigo.text,EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring) );
           end else
             Avisoerro('Codigo '+cod_item+' n�o encontrado no estoque');
         end;
       end;


  Lista75.free;
  Lista75Aux.free;
  ListaUnidades.free;

//  if ListaAliquotas<>nil then ListaAliquotas.free;
//  if ListaParticipantes<>nil then ListaParticipantes.free;
//  if Listatodoscfops<>nil then ListaTodosCfops.free;
//  if ListaUnidades<>nil then ListaUnidades.free;

////////////////////////////////////////////////////////////////////

  END;   // REF. UNIDADES DA MESMA EMPRESA...MATRIZ/FILIAL

// 08.02.19
  ListaParticipantes.free;

////////////////////////////////////////////////////////////////////
// gera os registros C190, D190 , C320 , E510 cfe foi acumulado no registro TTotalCst
// 06.01.2011 - ver se sera necessario algum gerar aqui
///////////////////////////////////////////////////////////
{
    for p:=0 to LIstaTotalCst.Count-1 do begin
          PTotalCst:=ListaTotalCst[p];
          if PTotalCst.registro='C190' then begin
          end else if PTotalCst.registro='D190' then begin
          end else if PTotalCst.registro='D590' then begin
          end else if PTotalCst.registro='E510' then begin
           with ACBrSPEDPisCofins1.Bloco_E do begin
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
    }
///////////////////////////////////////////////////////////
// ver se sera necessario...
// gera os registros C190 , C320 , D190 , E510 cfe foi acumulado no registro TTotalCst
/////////////////
////////////////
//Geracao do D200 com D201 e D205
/////////////////////////

  for p:=0 to ListaRegD200.count-1 do begin
// 14.07.13 - colocado aqui pra gerar correto 'cada macaco no seu galho'
    PRegD200:=ListaRegD200[p];
    if ListaD010.indexof(PRegD200.unid_codigo)=-1 then begin
      with AcbrSpedPisCofins1.Bloco_D do begin
        with RegistroD010New do begin
          inc(NRegD010);
          CNPJ:=FUnidades.GetCnpjcpf( PRegD200.unid_codigo );
        end;
        ListaD010.add(PRegD200.unid_codigo);
      end;
    end;
    with AcbrSpedPisCofins1.Bloco_D.RegistroD200New do begin
       if PRegD200.StatusREg='X' then begin
         COD_SIT:=sdfCancelado;
       end else if PRegD200.statusreg='Y' then
         COD_SIT:=sdfDenegado
       else
          COD_SIT:=sdfRegular;
       COD_MOD:=PRegD200.COD_MOD;
       SER:=PRegD200.SER;
       NUM_DOC_INI:=PRegD200.NUM_DOC_INI;
       NUM_DOC_FIN:=PRegD200.NUM_DOC_FIM;
       CFOP:=PRegD200.CFOP;
       DT_REF:=PRegD200.DT_REF;
       VL_DOC:=PRegD200.VL_DOC;
       VL_DESC:=0;

    end;
//  end;

    for i:=0 to ListaRegD201205.count-1 do begin
      PRegD201205:=ListaRegD201205[i];
      if ( PRegD201205.REG='D201' ) and
         ( strtoint(PRegD201205.cfop)=PRegD200.CFOP ) and ( PRegD201205.Emissao=PRegD200.DT_REF )
// 14.05.13
//         ( PRegD201205.Numerodoc>=PRegD200.NUM_DOC_INI ) and ( PRegD201205.Emissao=PRegD200.DT_REF ) and
//         ( PRegD201205.Numerodoc<=PRegD200.NUM_DOC_FIM )
         then begin
// aqui ao inves de percorrer ja somar em o que t� no D201 cfe data e numero inicial e final
// do D200..dai criar o registro ...
             with AcbrSpedPisCofins1.Bloco_D.RegistroD201New do begin
               VL_ITEM:=PRegD201205.VL_ITEM;
               CST_PIS:=PRegD201205.CSTPis;;
               VL_BC_PIS:=PRegD201205.VL_BC;
               VL_PIS:=PRegD201205.IMPOSTO;
               ALIQ_PIS:=PRegD201205.ALIQ;
    //           COD_CTA:='';
             end;
       end;
       if ( PRegD201205.REG='D205' ) and
            ( strtoint(PRegD201205.cfop)=PRegD200.CFOP ) and ( PRegD201205.Emissao=PRegD200.DT_REF )
// 14.05.13
//         ( PRegD201205.Numerodoc>=PRegD200.NUM_DOC_INI ) and ( PRegD201205.Emissao=PRegD200.DT_REF ) and
//         ( PRegD201205.Numerodoc<=PRegD200.NUM_DOC_FIM )
            then begin

             with AcbrSpedPisCofins1.Bloco_D.RegistroD205New do begin
               VL_ITEM:=PRegD201205.VL_ITEM;
               CST_COFINS:=PRegD201205.CSTCOFINS ;
               VL_BC_COFINS:=PRegD201205.VL_BC;
               VL_COFINS:=PRegD201205.IMPOSTO;
               ALIQ_COFINS:=PRegD201205.ALIQ;
    //           COD_CTA:='';
             end;
       end;
    end;
//   }
  end;

  ListaD010.free;

    codmuniemitente:=FCidades.GetCodigoIBGE(EdUNid_codigo.resultfind.fieldbyname('unid_cida_codigo').asinteger);
    regsbloco0:=0;

    with AcbrSpedPisCofins1.Bloco_0 do begin
//       LimpaRegistros;
// dados da empresa
///////////////////////////////////////////////////////////////////////
       with Registro0000New do begin
//         COD_VER:=vlVersao100;
//         COD_VER:=vlVersao101;
//         COD_VER:=vlVersao201;
// 06.08.18
 //        COD_VER:=vlVersao310;  // versao 005
// 22.01.20
         COD_VER:=vlVersao320;  // versao 006

         TIPO_ESCRIT:=tpEscrOriginal;     // 0 - Original
         if EdFinalidade.text='1' then
           TIPO_ESCRIT:=tpEscrRetificadora;  // 1 - Retificadora;
//         IND_SIT_ESP
         NUM_REC_ANTERIOR:=EdReciboanterior.text;
         DT_INI:=EdInicio.AsDate;
         DT_FIN:=EdTermino.AsDate;
         NOME:=ups(EdUnid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring);
         CNPJ:=EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring;
//         CPF:=
         UF:=EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring;
         COD_MUN:=strtointdef(codmuniemitente,0);
         IND_ATIV:=indAtivoOutros;
// 31.07.12 - SM - refeito em 11.05.16
         if FCodigosFiscais.GetQualImposto( EdUnid_codigo.resultfind.fieldbyname('unid_cfis_codigoest').AsString ) = 'S'  then
           IND_ATIV:=indAtivPrestadorServico
         else if FCodigosFiscais.GetQualImposto( EdUnid_codigo.resultfind.fieldbyname('unid_cfis_codigoest').AsString ) = 'I'  then
           IND_ATIV:=indAtivComercio
         else if FCodigosFiscais.GetQualImposto( EdUnid_codigo.resultfind.fieldbyname('unid_cfis_codigoest').AsString ) = 'P'  then
           IND_ATIV:=indAtivIndustrial;
// 15.02.18
         if copy(EdUnid_codigo.resultfind.fieldbyname('unid_cnaefiscal').AsString,1,2)='68' then
           IND_ATIV:=indAtivoImobiliaria;
// 13.12.19  - Novicarnes - Ketlen  - mudada de posi��o 'antes' em 13.07.20
         if AnsiPos( 'INDUSTRIAL',Uppercase(EdUnid_codigo.resultfind.fieldbyname('unid_razaosocial').AsString) ) > 0 then
            IND_ATIV:=indAtivIndustrial
// 15.01.19  - Vida Nova - Leila
         else if AnsiPos( 'COOPERATIVA',Uppercase(EdUnid_codigo.resultfind.fieldbyname('unid_razaosocial').AsString) ) > 0 then
            IND_ATIV:=indAtivoOutros ;

// 06.10.11 - criar campo no cadastro de unidades OU criar configuracao geral
//       para identifcar se � cooperativa, empresarial ou com pis exclusivo sobre a folha
//         if ( FGeral.GetConfig1AsFloat( 'perfunruraljur' ) >0 ) and
//           (FGeral.GetConfig1AsFloat( 'percotacapital' ) > 0 ) and
// 02.08.16
         if  ( FGeral.GetConfig1AsFloat('perfunrural' ) > 0 ) then
           IND_NAT_PJ:=indNatPJSocCooperativa
         else
           IND_NAT_PJ:=indNatPJSocEmpresariaGeral;
       end;
///////////////////////////////////////////////////
       with Registro0001New do begin
         IND_MOV:=imComDados;
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
         EMAIL:='';
         COD_MUN:=strtointdef(codmuniemitente,0); // deixado igual da unidade
       end;

// registro 0110 - define a forma de apuracao da contribuicao social
       with Registro0110New do begin
         if EdFormaapuracao.text='1' then
           COD_INC_TRIB:=codEscrOpIncNaoCumulativo
         else if EdFormaapuracao.text='2' then
           COD_INC_TRIB:=codEscrOpIncCumulativo
         else
           COD_INC_TRIB:=codEscrOpIncAmbos;

//         codEscrOpIncNaoCumulativo, // 1 - Escritura��o de opera��es com incidencia exclusivamente no regime n�o cumulativo
//         codEscrOpIncCumulativo,    // 2 - Escritura��o de opera��es com incidencia exclusivamente no regime cumulativo
//         codEscrOpIncAmbos          // 3 - Escritura��o de opera��es com incidencia nos regimes cumulativo e n�o cumulativo
         IND_APRO_CRED:=indMetodoApropriacaoDireta;
//     indMetodoApropriacaoDireta,   // 0 - M�todo de apropria��o direta
//     indMetodoDeRateioProporcional // 1 - M�todo de rateio proporcional(Receita Bruta);
         COD_TIPO_CONT:=codIndTipoConExclAliqBasica;
// codIndTipoConExclAliqBasica, // 0 - Apura��o da Contribui��o Exclusivamente a Al�quota B�sica
// codIndTipoAliqEspecificas    // 1 - Apura��o da Contribui��o a Al�quotas Espec�ficas (Diferenciadas e/ou por Unidade de Medida de Produto)
// ?? 11.10.11 - informar somente a partir de 01.01.12 somente pra empresa lucro presumido
// 13.09.12 - nao pode ser informado quando for nao cumulativo total ou parcial
//             vamos ver a proxima versao do validador

        IND_REG_CUM:=codRegimeCompetEscritDetalhada;

//      codRegimeCaixa,                   //1 � Regime de Caixa � Escritura��o consolidada (Registro F500);
//      codRegimeCompetEscritConsolidada, //2 � Regime de Compet�ncia - Escritura��o consolidada (Registro F550);
//      codRegimeCompetEscritDetalhada    //9 � Regime de Compet�ncia - Escritura��o detalhada, com base nos registros dos Blocos �A�, �C�, �D� e �F�.

       end;


//         QUnidades.next;
//      end;

//      FGeral.Fechaquery(QUnidades);


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

// 28.08.18 - ver checagem para nao gerar caso nao conectar ou nao tiver o contax no micro

// 19.10.17 - gera somente um q serve para matriz e filiais
   GeraRegistro500;
   ListaCod_Cta.free;
   ListaPLanoCon.Free;

/////////////////////////////// FIM DO BLOCO 0
       with ACBrSPEDPisCofins1.Bloco_0 do begin
//                    Registro 000    Registro 001
          regsbloco0:=     1       +        1        + Registro0140Count+
                      Registro0150Count+Registro0190Count+Registro0110Count+
                      Registro0200Count+Registro0400Count+Registro0450Count+
                      Registro0500Count;
       end;

       with Registro0990 do begin
         QTD_LIN_0:=regsbloco0;
       end;

    end;   // BLOCO 0
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////

// Abertura Bloco D - conhecimentos de transporte e outros...
//    if (AcbrSpedFiscal1.Bloco_D.RegistroD100Count>0) or
//       (AcbrSpedFiscal1.Bloco_D.RegistroD190Count>0) then begin
    if (NRegD100>0) or (NRegD500>0) or (NRegD200>0) then begin
      with ACBrSPEDPisCofins1.Bloco_D do begin
        with RegistroD001 do begin
          IND_MOV:=imComDados;
        end;
      end;
    end;
//Encerramento Bloco D
//////////////////////////
       with ACBrSPEDPisCofins1.Bloco_D do begin
//                       D001            D990
          regsbloco0:=     1       +        1        +
                      RegistroD100Count+RegistroD101Count++RegistroD105Count+
                      RegistroD200Count+RegistroD201Count++RegistroD205Count+
                      RegistroD500Count;
       end;

       with AcbrSpedPisCofins1.Bloco_D.RegistroD990 do begin
         QTD_LIN_D:=regsbloco0;
       end;

// Bloco M - apuracao do pis e cofins
////////////////////////////////////////
///////////////////////////////////
{ - 18.10.11 - por enquanto nao gerar
      with AcbrSpedPisCofins1.Bloco_M do begin
        with RegistroM001New do begin
          IND_MOV:=imComDados;
        end;
        for p:=0 to ListaRegM100.Count-1 do begin
          with RegistroM100New do begin
            PRegM100:=ListaRegM100[p];
            COD_CRED:=PRegM100.COD_CRED;
            if PRegM100.IND_CRED_ORI=0 then
              IND_CRED_ORI:=icoOperProprias
            else
              IND_CRED_ORI:=icoEvenFusaoCisao ;
            VL_BC_PIS:=PRegM100.VL_BC_PIS;
            ALIQ_PIS:=PRegM100.ALIQ_PIS;
            QUANT_BC_PIS:=PRegM100.QUANT_BC_PIS;
            ALIQ_PIS_QUANT:=PRegM100.ALIQ_PIS_QUANT;
            VL_CRED:=PRegM100.VL_CRED;
            VL_AJUS_ACRES:=PRegM100.VL_AJUS_ACRES;
            VL_AJUS_REDUC:=PRegM100.VL_AJUS_REDUC;
            VL_CRED_DIF:=PRegM100.VL_CRED_DIF;
            VL_CRED_DISP:=PRegM100.VL_CRED_DISP;
            if PRegM100.IND_DESC_CRED=0 then
              IND_DESC_CRED:=idcTotal
            else
              IND_DESC_CRED:=idcParcial;
            VL_CRED_DESC:=PRegM100.VL_CRED_DESC;
            SLD_CRED:=( PRegM100.VL_CRED_DISP - PRegM100.VL_CRED_DESC);
          end;

        end;

      end;
}

////////////////////////
{ - 18.10.11 - por enquanto nao gerar

        for p:=0 to ListaRegE520.Count-1 do begin
          with RegistroE520New do begin
            PRegE520:=ListaRegE520[p];
            PRegE520.VL_SD_IPI:=( PRegE520.VL_DEB_IPI + PRegE520.VL_OD_IPI  )  -
                                ( PRegE520.VL_SD_ANT_IPI + VL_CRED_IPI + VL_OC_IPI );
            if PRegE520.VL_SD_IPI<0 then begin
              PRegE520.VL_SC_IPI:=abs(PRegE520.VL_SD_IPI);
              PRegE520.VL_SD_IPI:=0;
            end;
          end;
        end;
      }

////////////////////////


//Abertura Bloco F
//////////////////////////
      with AcbrSpedPisCofins1.Bloco_F do begin
        with RegistroF001New do begin
//          IND_MOV:=imComDados;
          IND_MOV:=imSemDados;
        end;
//Encerramento Bloco F
//////////////////////////
        regsbloco0:=     1  + 1  + RegistroF010Count+RegistroF100Count;
        with RegistroF990 do begin
          QTD_LIN_F:=regsbloco0;
        end;
      end;

      with AcbrSpedPisCofins1.Bloco_M do begin
//Encerramento Bloco M
//////////////////////  M001            M990
        regsbloco0:=     1       +      1   +
                       RegistroM210Count+RegistroM100Count+
                       RegistroM500Count+RegistroM610Count;
        with RegistroM990 do begin
          QTD_LIN_M:=regsbloco0;
        end;
      end;
//      }
/////////////////////

//Abertura Bloco 1
//////////////////////////
///  20.05.19
      mes:=DAtetomes( EdTermino.AsDate );
      ano:=Datetoano( EdTermino.AsDate,true );

      QReg11001500:=sqltoquery('select * from sped where sped_tiposped = '+stringtosql( 'CONTRIBUICOES' )+
                 ' and sped_registro = '+Stringtosql('1100')+
//                 ' and sped_mesano   = '+Stringtosql( strzero(mes,2)+strzero(ano,4) ) );
// 24.06.19 - 'nova orienta��o'
                 ' and substr(sped_mesano,3,4) <= '+Stringtosql( strzero(ano,4) ) );
      tem11001500:=0;

      Sistema.setmessage('Exportando registros 1100 e 1500');

      while not QReg11001500.Eof  do begin

        if ( ( copy( QReg11001500.FieldByName('sped_mesano').AsString,3,4)+
           copy( QReg11001500.FieldByName('sped_mesano').AsString,1,2) )
           <=
           ( strzero(ano,4)+strzero(mes,2) )
           )
// 22.10.19 - Novicarnes - Ketlen - nao mandar se zero saldo
          and

          ( QReg11001500.fieldbyname('sped_SLD_CRED_FIM').ascurrency > 0 )

          then begin

          with AcbrSpedPisCofins1.Bloco_1.Registro1100New do begin

             tem11001500:=1;
             PER_APU_CRED    :=QReg11001500.fieldbyname('sped_per_apu_cred').asinteger;
             ORIG_CRED       :=QReg11001500.fieldbyname('sped_orig_cred').asinteger;
             CNPJ_SUC        :=QReg11001500.fieldbyname('sped_cnpj_suc').asstring;
             COD_CRED        :=QReg11001500.fieldbyname('sped_cod_cre').asinteger;
             VL_CRED_APU     :=QReg11001500.fieldbyname('sped_vl_cred_apu').ascurrency;
             VL_CRED_EXT_APU :=QReg11001500.fieldbyname('sped_vl_cred_ext_apu').ascurrency;
             VL_TOT_CRED_APU :=QReg11001500.fieldbyname('sped_vl_tot_cred_apu').ascurrency;
             VL_CRED_DESC_PA_ANT :=QReg11001500.fieldbyname('sped_VL_CRED_DESC_PA_ANT').ascurrency;
             VL_CRED_PER_PA_ANT  :=QReg11001500.fieldbyname('sped_VL_CRED_PER_PA_ANT').ascurrency;
             VL_CRED_DCOMP_PA_ANT:=QReg11001500.fieldbyname('sped_VL_CRED_DCOMP_PA_ANT').ascurrency;
             VL_CRED_DESC_EFD    :=QReg11001500.fieldbyname('sped_VL_CRED_DESC_EFD').ascurrency;
             VL_CRED_PER_EFD     :=QReg11001500.fieldbyname('sped_VL_CRED_PER_EFD').ascurrency;
             VL_CRED_DCOMP_EFD   :=QReg11001500.fieldbyname('sped_VL_CRED_DCOMP_EFD').ascurrency;
             VL_CRED_TRANS       :=QReg11001500.fieldbyname('sped_VL_CRED_TRANS').ascurrency;
             VL_CRED_OUT         :=QReg11001500.fieldbyname('sped_VL_CRED_OUT').ascurrency;
             SD_CRED_DISP_EFD    :=QReg11001500.fieldbyname('sped_SD_CRED_DISP_EFD').ascurrency;
             SLD_CRED_FIM        :=QReg11001500.fieldbyname('sped_SLD_CRED_FIM').ascurrency;

          end;

        end;

        QReg11001500.Next;


      end;

      FGeral.FechaQuery( QReg11001500 );
      QReg11001500:=sqltoquery('select * from sped where sped_tiposped = '+stringtosql( 'CONTRIBUICOES' )+
                 ' and sped_registro = '+Stringtosql('1500')+
//                 ' and sped_mesano   = '+Stringtosql( strzero(mes,2)+strzero(ano,4) ) );
// 24.06.19 - 'nova orienta��o'
                 ' and substr(sped_mesano,3,4) <= '+Stringtosql( strzero(ano,4) ) );

      while not QReg11001500.Eof  do begin

        if ( ( copy( QReg11001500.FieldByName('sped_mesano').AsString,3,4)+
           copy( QReg11001500.FieldByName('sped_mesano').AsString,1,2) )
           <=
           ( strzero(ano,4)+strzero(mes,2) )
           )
// 23.10.19 - Novicarnes - Ketlen - nao mandar se zero saldo
          and
          ( QReg11001500.fieldbyname('sped_SLD_CRED_FIM').ascurrency > 0 )

          then begin

          with AcbrSpedPisCofins1.Bloco_1.Registro1500New do begin

             tem11001500:=1;
             PER_APU_CRED    :=QReg11001500.fieldbyname('sped_per_apu_cred').asinteger;
             ORIG_CRED       :=QReg11001500.fieldbyname('sped_orig_cred').asinteger;
             CNPJ_SUC        :=QReg11001500.fieldbyname('sped_cnpj_suc').asstring;
             COD_CRED        :=QReg11001500.fieldbyname('sped_cod_cre').asinteger;
             VL_CRED_APU     :=QReg11001500.fieldbyname('sped_vl_cred_apu').ascurrency;
             VL_CRED_EXT_APU :=QReg11001500.fieldbyname('sped_vl_cred_ext_apu').ascurrency;
             VL_TOT_CRED_APU :=QReg11001500.fieldbyname('sped_vl_tot_cred_apu').ascurrency;
             VL_CRED_DESC_PA_ANT :=QReg11001500.fieldbyname('sped_VL_CRED_DESC_PA_ANT').ascurrency;
             VL_CRED_PER_PA_ANT  :=QReg11001500.fieldbyname('sped_VL_CRED_PER_PA_ANT').ascurrency;
             VL_CRED_DCOMP_PA_ANT:=QReg11001500.fieldbyname('sped_VL_CRED_DCOMP_PA_ANT').ascurrency;
             VL_CRED_DESC_EFD    :=QReg11001500.fieldbyname('sped_VL_CRED_DESC_EFD').ascurrency;
             VL_CRED_PER_EFD     :=QReg11001500.fieldbyname('sped_VL_CRED_PER_EFD').ascurrency;
             VL_CRED_DCOMP_EFD   :=QReg11001500.fieldbyname('sped_VL_CRED_DCOMP_EFD').ascurrency;
             VL_CRED_TRANS       :=QReg11001500.fieldbyname('sped_VL_CRED_TRANS').ascurrency;
             VL_CRED_OUT         :=QReg11001500.fieldbyname('sped_VL_CRED_OUT').ascurrency;
             SD_CRED_DISP_EFD    :=QReg11001500.fieldbyname('sped_SD_CRED_DISP_EFD').ascurrency;
             SLD_CRED_FIM        :=QReg11001500.fieldbyname('sped_SLD_CRED_FIM').ascurrency;

          end;

        end;

        QReg11001500.Next;


      end;

      with AcbrSpedPisCofins1.Bloco_1 do begin

        with Registro1001New do begin

            if tem11001500 > 0 then
               IND_MOV:=imComDados
            else
               IND_MOV:=imSemDados;
        end;

//Encerramento Bloco 1
//////////////////////  1001            1990
        regsbloco0:=     1       +      1   +
                       Registro1100Count+Registro1101Count+Registro1500Count;  // tem + registros...
        with Registro1990 do begin
          QTD_LIN_1:=regsbloco0;
        end;
      end;

//Abertura Bloco 9
//////////////////////////
      with AcbrSpedPisCofins1.Bloco_9 do begin
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


  Sistema.setmessage('Criando arquivo texto '+nomearq+' na pasta '+AcbrSpedPisCofins1.Path);

  AcbrSpedPisCofins1.SaveFileTXT;

  Sistema.Endprocess('Gerado arquivo '+nomearq+' '+TimeToStr(time()));


end;

function TFSpedPisCofins.EmissaoPropria(xchavenfe: string): boolean;
/////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
   Q:=sqltoquery('select unid_cnpj from unidades where '+FGeral.Getin('unid_codigo',EdUnidades.text,'C'));
   result:=false;
   while not Q.eof do begin
    if pos(Q.fieldbyname('unid_cnpj').asstring,xchavenfe)>0 then
      result:=true;
     Q.Next;
   end;
   FGeral.FechaQuery(Q);
//   result:=pos(EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring,xchavenfe)>0;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TFSpedPisCofins.BuscaNosItems(xtransacao, xtipomov:string;xperdesco:currency;var xvalorpis, xvalorcofins: currency;
                                        xconsfinal:string='N' ; xrateiofrete:currency=0 ; xconta:integer=0 );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var Qi:TSqlQuery;
    xalipis,xalicofins,xtotalitem,
    pisitem,
    cofinsitem,
    xtotal    :currency;
    ycstpis   :TAcbrCStPis;
    ycstcofins:TAcbrCstCofins;
    ycfop54:string;
    i,p:integer;

begin

  if ( pos( xtipomov,Global.CodCompraProdutor+';'+Global.CodDrawBackSai+';'+Global.CodTransfSai ) >0 )
     then begin
     xvalorpis:=0;
     xvalorcofins:=0;
     exit;
  end;
////////////////////////////////////////////////////////////////////
// 25.08.15 - tentar ficar menos lento o sped contribuicoes
  xvalorpis:=0;xvalorcofins:=0;
  xtotal:=0;

  for i:=0 to ListaItens.count-1 do begin

    PItens:=ListaItens[i];
    if ( PItens.transacao=xtransacao ) and ( pItens.tipomov=xtipomov ) then begin
      p:=i;
      while ( PItens.transacao=xtransacao ) and ( pItens.tipomov=xtipomov ) and (P<(ListaItens.count)) do begin
        PItens:=ListaItens[p];
        ycfop54:=PItens.natf_codigo;
//        if xconsfinal='S' then begin
// 30.09.16 - tributa sempre
//          if Edconsfinal.text='S' then begin
//            xalipis:=FGeral.GetConfig1AsFloat('perpis');
//            xalicofins:=FGeral.GetConfig1AsFloat('percofins');
//          end else begin
//            xalipis:=0;
//            xalicofins:=0;
//          end;
//        end else begin

          if pos(xtipomov,Global.TiposEntrada)>0  then begin

//             yCSTPIS:=GetCSTPIS( FEstoque.GetPISpeloCSTICMS(PItens.cst,'E'),ycfop54,pItens.cst );
//             yCSTCOFINS:=GetCSTCOFINS( FEstoque.GetCOFINSpeloCSTICMS(pItens.cst,'E'),ycfop54,pItens.cst );
// 21.10.16  - pegar no ncm
             xcstpis:= FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(PItens.produto) );
             if trim(xcstpis)='' then xcstpis:='99';
// 19.10.18 - Ketlen
             if xconta >0 then begin

                      if LIstaDespesasCST53.IndexOf( IntToStr( xconta ) ) >=0  then begin

                         xcstpis:='53' ;
                         yCSTCOFINS:=GetCSTCOFINS( '53' );

                      end else begin

// 05.08.19
                         if campo.Tipo<>'' then begin

                              xcstpis:=FPlano.GetCSTPisCofins( xconta );
                              if trim(xcstpis)<>'' then begin
                                yCSTPIS   :=GetCSTPIS( xcstpis );
                                yCSTCOFINS:=GetCSTCOFINS( xcstpis );
                              end;

                         end else begin

                           yCSTPIS:=GetCSTPIS( xcstpis ) ;
                           yCSTCOFINS:=GetCSTCOFINS( FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(PItens.produto ) ) );

                         end;

                      end;

             end else begin

                   yCSTPIS:=GetCSTPIS( xcstpis ) ;
                   yCSTCOFINS:=GetCSTCOFINS( FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(PItens.produto ) ) );

             end;
// 15.12.16
             if pos( xcstpis,cstpisNAOEXPORTA ) = 0 then
                temsocstqnaoexporta:='N';

          end else begin

             yCSTPIS:=GetCSTPIS( FEstoque.GetsituacaotributariaPIS(PItens.produto,PItens.unidade,PItens.estado) );
             yCSTCOFINS:=GetCSTCOFINS( FEstoque.GetsituacaotributariaCofins(PItens.produto,PItens.unidade,PItens.estado) );
             temsocstqnaoexporta:='N';

          end;

          if TributaPIS( yCSTPIS ) then begin
// 14.03.16
           if pos(xtipomov,Global.TiposEntrada)>0  then begin
//              xalipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(PItens.produto,
//                          PItens.unidade,Global.UFUnidade)  )
// 21.10.16
              xalipis:=FCodigosIPI.GetPerPis( FEstoque.GetcodigoIPINCM(PItens.produto) );
//   02.08.19 - Novicarnes - Ketlen
              if yCSTPIS  = GetCSTPIS( '53' ) then xalipis:=1.65;

           end else
//              xalipis:=FCodigosFiscais.GetAliquotaPis('0');  // para buscar o  qtiver  na unidade
// 06.05.16
              xalipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(PItens.produto,
                          PItens.unidade,Global.UFUnidade)  )
          end else
            xalipis:=0;

          if TributaCOFINS( yCSTCOFINS ) then begin
// 14.03.16
             if pos(xtipomov,Global.TiposEntrada)>0  then begin
//                xalicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(PItens.produto,
//                             PItens.unidade,Global.UFUnidade)  )
// 21.10.16
              xalicofins:=FCodigosIPI.GetPerCofins( FEstoque.GetcodigoIPINCM(PItens.produto) );
//   02.08.19 - Novicarnes - Ketlen
              if yCSTCOFINS  = GetCSTCOFINS( '53' ) then xalicofins:=7.60;

             end else
//                xalicofins:=FCodigosFiscais.GetAliquotaCofins('0');  // para buscar o  qtiver  na unidade
// 06.05.16
                xalicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(PItens.produto,
                             PItens.unidade,Global.UFUnidade)  )
          end else
            xalicofins:=0;
//        end;

    //    xtotalitem:=(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency);
        xtotalitem:=FGEral.Arredonda(PItens.qtde*PItens.unitario,2);
// 23.06.18 - Novicarnes - Ketlen - nao estava considerando frete na base
        xtotalitem:=xtotalitem + ( xtotalitem*(xrateiofrete/100) );

    // 14.03.12 - nao estava jogando a base liquida
        xtotalitem:=xtotalitem - ( xtotalitem*(xperdesco/100) );

        pisitem:= roundvalor(xtotalitem*(xalipis/100));
        cofinsitem:= roundvalor(xtotalitem*(xalicofins/100));
        xtotal := xtotal + xtotalitem;
{
        if xtransacao='0016319044' then begin

           Texto.Lines.Add('PItens.produto  = '+PItens.produto );
           Texto.Lines.Add('xalipis = '+floattostr(xalipis));
           Texto.Lines.Add('xalicofins = '+floattostr(xalicofins));
           Texto.Lines.Add('xperdesco = '+floattostr(xperdesco));
           Texto.Lines.Add('xrateiofrete = '+floattostr(xrateiofrete));

        end;
}
        xvalorpis:=xvalorpis+pisitem;
        xvalorcofins:=xvalorcofins+cofinsitem;
        inc(p);
// 18.10.16 - para poder comparar no while acima
        if P<ListaItens.Count then  // 25.10.16
          PItens:=ListaItens[p];
      end;  // whhile
      break;   // 10.05.16
    end;  // if

  end;

        if xtransacao='0016319044' then begin

           Texto.Lines.Add('xvalorpis = '+floattostr(xvalorpis));
           Texto.Lines.Add('xvalorcofins = '+floattostr(xvalorcofins));
           Texto.Lines.Add('xtotal = '+floattostr(xtotal));

        end;
///////////////////////////////////////////////////////////////////////////////////////////////////////
{
  Qi:=Sqltoquery('select move_numerodoc,move_unid_codigo,move_esto_codigo,move_qtde,move_venda,'+
                ' move_unid_codigo,moes_estado,move_cst,move_natf_codigo'+
                ' from movestoque inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                ' where move_transacao='+Stringtosql(xtransacao)+
                ' and move_tipomov='+Stringtosql(xtipomov)+
                ' and moes_status<>''C'''+
                ' and move_status<>''C''');

  xvalorpis:=0;xvalorcofins:=0;
  while not Qi.eof do begin

    ycfop54:=Qi.fieldbyname('move_natf_codigo').asstring;
  // 20.11.12 - Novicarnes - Leonir - venda consumidor final TEM que tributar
    if xconsfinal='S' then begin
// 27.06.12 - Novicarnes - Leonir - venda consumidor final TEM que tributar
      if Edconsfinal.text='S' then begin
        xalipis:=FGeral.GetConfig1AsFloat('perpis');
        xalicofins:=FGeral.GetConfig1AsFloat('percofins');
      end else begin
        xalipis:=0;
        xalicofins:=0;
      end;
    end else begin
// 08.08.13
      if pos(xtipomov,Global.TiposEntrada)>0  then begin
         yCSTPIS:=GetCSTPIS( FEstoque.GetPISpeloCSTICMS(Qi.fieldbyname('move_cst').asstring,'E'),ycfop54,Qi.fieldbyname('move_cst').asstring );
         yCSTCOFINS:=GetCSTCOFINS( FEstoque.GetCOFINSpeloCSTICMS(Qi.fieldbyname('move_cst').asstring,'E'),ycfop54,Qi.fieldbyname('move_cst').asstring );
      end else begin
         yCSTPIS:=GetCSTPIS( FEstoque.GetsituacaotributariaPIS(Qi.fieldbyname('move_esto_codigo').asstring,Qi.fieldbyname('move_unid_codigo').asstring,Qi.fieldbyname('moes_estado').asstring) );
         yCSTCOFINS:=GetCSTCOFINS( FEstoque.GetsituacaotributariaCofins(Qi.fieldbyname('move_esto_codigo').asstring,Qi.fieldbyname('move_unid_codigo').asstring,Qi.fieldbyname('moes_estado').asstring) );
      end;
      if TributaPIS( yCSTPIS ) then
        xalipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Qi.fieldbyname('move_esto_codigo').asstring,
                      Qi.fieldbyname('move_unid_codigo').asstring,Global.UFUnidade)  )
      else
        xalipis:=0;
      if TributaCOFINS( yCSTCOFINS ) then
        xalicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Qi.fieldbyname('move_esto_codigo').asstring,
                      Qi.fieldbyname('move_unid_codigo').asstring,Global.UFUnidade)  )
      else
        xalicofins:=0;
    end;
//    xtotalitem:=(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency);
    xtotalitem:=FGEral.Arredonda(Qi.fieldbyname('move_qtde').ascurrency*Qi.fieldbyname('move_venda').ascurrency,2);
// 14.03.12 - nao estava jogando a base liquida
    xtotalitem:=xtotalitem - ( xtotalitem*(xperdesco/100) );
    pisitem:= roundvalor(xtotalitem*(xalipis/100));
    cofinsitem:= roundvalor(xtotalitem*(xalicofins/100));
    xvalorpis:=xvalorpis+pisitem;
    xvalorcofins:=xvalorcofins+cofinsitem;
    Qi.Next;
  end;
  FGeral.FechaQuery(Qi);
///////////////////////////////////////////////////////////////////////////////////////////////////////
}
end;

// 14.01.2021
procedure TFSpedPisCofins.EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
/////////////////////////////////////////////////////////////////////////////////
begin

  FGeral.Limpaedit(EdUnid_codigo,key);

end;

procedure TFSpedPisCofins.EdUnid_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
begin
   EdUnidades.Text:=FUnidades.GetMatrizeFiliais(EdUnid_codigo.text);
end;

////////////////////////////////////////////
// 05.03.12
procedure TFSpedPisCofins.AcumulaporCriterio(yregistro,yModelo, ystatusreg, yser,
          ysub, yunid_codigo: string; ynumerodoc, ycfop: integer; ydtref: TDatetime;
          yvalordoc: currency ; yconta:string='' );
///////////////////////////////////////////////////////////////////////////////////////
var y:integer;
    achou:boolean;
begin
  achou:=false;
  if yregistro='D200' then begin
    for y:=0 to ListaRegD200.count-1 do begin
      PRegD200:=ListaRegD200[y];
      if ( PRegD200.COD_MOD=yModelo ) and ( PRegD200.StatusREg=yStatusreg ) and
         ( PRegD200.SER=ySer ) and ( PRegD200.SUB=ySub ) and ( PRegD200.CFOP=ycfop ) and
         ( PRegD200.DT_REF=ydtref ) then begin
         achou:=true;
         break
      end;
    end;
    if not achou then begin
      New(PRegD200);
      PRegD200.COD_MOD:=yModelo;
      PRegD200.SER:=yser;
      PRegD200.SUB:=ysub;
      PRegD200.StatusREg:=ystatusreg;
      PRegD200.NUM_DOC_INI:=ynumerodoc;
      PRegD200.NUM_DOC_FIM:=ynumerodoc;
      PRegD200.CFOP:=ycfop;
      PRegD200.DT_REF:=ydtref;
      PRegD200.VL_DOC:=yvalordoc;
      PRegD200.unid_codigo:=yunid_codigo;
      ListaRegD200.add(PRegD200);
    end else begin
      PRegD200.VL_DOC:=PRegD200.VL_DOC+yvalordoc;
      if ynumerodoc<PRegD200.NUM_DOC_INI then
        PRegD200.NUM_DOC_INI:=ynumerodoc
      else if ynumerodoc>PRegD200.NUM_DOC_FIM then
        PRegD200.NUM_DOC_FIM:=ynumerodoc
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////
// 05.03.12
//procedure TFSpedPisCofins.AcumulaD201205(yRegistro, yCST, yConta: string;
//  yvlitem, yvlbc, yaliq, yvlimposto: currency);
procedure TFSpedPisCofins.AcumulaD201205(yRegistro,yunid_codigo:string;yCSTPIS:TACBrSituacaoTribPIS;yCSTCOFINS:TACBrSituacaoTribCOFINS;yConta:string;
          yvlitem,yvlbc,yaliq,yvlimposto:currency;ydataemissao:TDatetime;ycfop:string;ynumerodoc:integer );
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var y:integer;
    achou:boolean;
begin
  achou:=false;
  if yregistro='D201' then begin
    for y:=0 to ListaRegD201205.count-1 do begin
      PRegD201205:=ListaRegD201205[y];
      if ( PRegD201205.REG=yRegistro ) and ( PRegD201205.CSTPis=yCSTPIS ) and
//         ( PRegD201205.ALIQ=yaliq ) and ( PRegD201205.COD_CTA=yConta ) and
         ( PRegD201205.cfop=ycfop ) and ( PRegD201205.Emissao=yDataEmissao )
         and ( PRegD201205.unid_codigo=yunid_codigo )
// 14.05.13
//         ( PRegD201205.Numerodoc=yNumerodoc )
         then begin
         achou:=true;
         break
      end;
    end;
    if not achou then begin
      New(PRegD201205);
      PRegD201205.REG:=yregistro;
      PRegD201205.CSTPIS:=yCSTPIS;
      PRegD201205.COD_CTA:=yconta;
      PRegD201205.VL_ITEM:=yvlitem;
      PRegD201205.VL_BC:=yvlbc;
      PRegD201205.ALIQ:=yaliq;
      PRegD201205.IMPOSTO:=yvlimposto;
      PRegD201205.cfop:=ycfop;
      PRegD201205.Emissao:=yDataemissao;
      PRegD201205.Numerodoc:=yNumerodoc;
// 14.07.13
      PRegD201205.unid_codigo:=yunid_codigo;
      ListaRegD201205.add(PRegD201205);
    end else begin
      PRegD201205.VL_ITEM:=PRegD201205.VL_ITEM+yvlitem;
      PRegD201205.VL_BC:=PRegD201205.VL_BC+yvlbc;
      PRegD201205.IMPOSTO:=PRegD201205.IMPOSTO+yvlimposto;
    end;
  end else  if yregistro='D205' then begin
    for y:=0 to ListaRegD201205.count-1 do begin
      PRegD201205:=ListaRegD201205[y];
      if ( PRegD201205.REG=yRegistro ) and ( PRegD201205.CSTCOFINS=yCSTCOFINS ) and
//         ( PRegD201205.ALIQ=yaliq ) and ( PRegD201205.COD_CTA=yConta ) and
         ( PRegD201205.cfop=ycfop ) and ( PRegD201205.Emissao=yDataEmissao )
         and ( PRegD201205.unid_codigo=yunid_codigo )
// 14.05.13
//         ( PRegD201205.Numerodoc=yNumerodoc )
         then begin
         achou:=true;
         break
      end;
    end;
    if not achou then begin
      New(PRegD201205);
      PRegD201205.REG:=yregistro;
      PRegD201205.CSTCOFINS:=yCSTCOFINS;
      PRegD201205.COD_CTA:=yconta;
      PRegD201205.VL_ITEM:=yvlitem;
      PRegD201205.VL_BC:=yvlbc;
      PRegD201205.ALIQ:=yaliq;
      PRegD201205.IMPOSTO:=yvlimposto;
      PRegD201205.cfop:=ycfop;
      PRegD201205.Emissao:=yDataemissao;
      PRegD201205.Numerodoc:=yNumerodoc;
// 14.07.13
      PRegD201205.unid_codigo:=yunid_codigo;
      ListaRegD201205.add(PRegD201205);
    end else begin
      PRegD201205.VL_ITEM:=PRegD201205.VL_ITEM+yvlitem;
      PRegD201205.VL_BC:=PRegD201205.VL_BC+yvlbc;
      PRegD201205.IMPOSTO:=PRegD201205.IMPOSTO+yvlimposto;
    end;
  end;
end;

///////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
function TFSpedPisCofins.GetCSTPIS(ycst:string;ycfop:string='';ycsticms:string=''):TACBrSituacaoTribPIS;
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
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
      if ( trim(ycfop)<>'' ) and ( Pos(ycfop,CfopsConhecimentoSaida)=0 ) and ( pos(copy(ycfop,1,1),'1,2,3')>0 ) then begin
        if pos( ycfop,CfopsAquisicaoBensparaRevenda+';'+CfopsAquisicaoBensparaInsumo+';'+
                CfopsAquisicaoServicosparaInsumo+';'+CfopsDevolucaoVendaNaoCumulativa+';'+
                CfopsOutrasEntradascomCredito ) = 0 then
            result:=stpisOperAquiSemDirCredito
      end;
// 14.03.12 pois nem sempre icms = pis/cofinsretirado
//      if trim(ycsticms)<>'' then begin
//        if ycsticms='040' then //  sticmsIsenta
//          result:=stpisOperAquiAliquotaZero
//      end;
    end;


    ///////////////////////////////////////////////////////
function TFSpedPisCofins.TributaPIS(ycst:TACBrSituacaoTribPIS):boolean;
    ///////////////////////////////////////////////////////
    begin
      result:=false;
      if ycst in [ stpisValorAliquotaNormal,stpisValorAliquotaDiferenciada,stpisQtdeAliquotaUnidade,
                   stpisValorAliquotaPorST,stpisOperCredExcRecTribMercInt,stpisOperCredExcRecNaoTribMercInt,
                   stpisOperCredExcRecExportacao,stpisCredPresAquiExcRecTribMercInt,
                   stpisCredPresAquiExcRecNaoTribMercInt,
                   stpisCredPresAquiExcExcRecExportacao,
                   stpisCredPresAquiRecTribNaoTribMercInt,
                   stpisCredPresAquiRecTribMercIntEExportacao,
                   stpisCredPresAquiRecNaoTribMercIntEExportacao,
                   stpisCredPresAquiRecTribENaoTribMercIntEExportacao,
                   stpisOutrasOperacoes_CredPresumido,
                   stpisOperCredExcRecTribMercInt,     // '50' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita Tributada no Mercado Interno
                   stpisOperCredExcRecExportacao,      // '52' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita de Exporta��o
                   stpisOperCredRecTribNaoTribMercInt, // '53' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno
                   stpisOperCredRecTribMercIntEExportacao, // '54' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o
                   stpisOperCredRecNaoTribMercIntEExportacao, // '55' // Opera��o com Direito a Cr�dito - Vinculada a Receitas N�o-Tributadas no Mercado Interno e de Exporta��o
                   stpisOperCredRecTribENaoTribMercIntEExportacao,
                   stpisOperAquiPorST ]
                   then
        result:=true;
    end;


    ///////////////////////////////////////////////////////////
function TFSpedPisCofins.GetCSTCOFINS(ycst:string;ycfop:string='';ycsticms:string=''):TACBrSituacaoTribCOFINS;
    ////////////////////////////////////////////////////////////////////////////////////////////
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
//      if trim(ycfop)<>'' then begin
// 05.03.12
      if ( trim(ycfop)<>'' ) and ( Pos(ycfop,CfopsConhecimentoSaida)=0 ) and ( pos(copy(ycfop,1,1),'1,2,3')>0 ) then begin
        if pos( ycfop,CfopsAquisicaoBensparaRevenda+';'+CfopsAquisicaoBensparaInsumo+';'+
                CfopsAquisicaoServicosparaInsumo+';'+CfopsDevolucaoVendaNaoCumulativa+';'+
                CfopsOutrasEntradascomCredito ) = 0 then
            result:=stcofinsOperAquiSemDirCredito
      end;
// 14.03.12 pois nem sempre icms = pis/cofinsretirado
//      if trim(ycsticms)<>'' then begin
//        if ycsticms='040' then //  sticmsIsenta
//          result:=stCofinsOperAquiAliquotaZero
//      end;

    end;
///////////////////////////////////////////

    ///////////////////////////////////////////////////////
function TFSpedPisCofins.TributaCOFINS(ycst:TACBrSituacaoTribCOFINS):boolean;
    ///////////////////////////////////////////////////////
    begin
      result:=false;
      if ycst in [ stCofinsValorAliquotaNormal,stCofinsValorAliquotaDiferenciada,stCofinsQtdeAliquotaUnidade,
                   stCofinsValorAliquotaPorST,stCofinsOperCredExcRecTribMercInt,stCofinsOperCredExcRecNaoTribMercInt,
                   stCofinsOperCredExcRecExportacao,stCofinsCredPresAquiExcRecTribMercInt,
                   stCofinsCredPresAquiExcRecNaoTribMercInt,
                   stCofinsCredPresAquiExcExcRecExportacao,
                   stCofinsCredPresAquiRecTribNaoTribMercInt,
                   stCofinsCredPresAquiRecTribMercIntEExportacao,
                   stCofinsCredPresAquiRecNaoTribMercIntEExportacao,
                   stCofinsCredPresAquiRecTribENaoTribMercIntEExportacao,
                   stCofinsOutrasOperacoes_CredPresumido,
                   stcofinsOperCredExcRecTribMercInt,    // '50' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita Tributada no Mercado Interno
                   stcofinsOperCredExcRecNaoTribMercInt,  // '51' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita N�o-Tributada no Mercado Interno
                   stcofinsOperCredExcRecExportacao,             // '52' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita de Exporta��o
                   stcofinsOperCredRecTribNaoTribMercInt,        // '53' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno
                   stcofinsOperCredRecTribMercIntEExportacao,    // '54' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o
                   stcofinsOperCredRecNaoTribMercIntEExportacao,  // '55' // Opera��o com Direito a Cr�dito - Vinculada a Receitas N�o Tributadas no Mercado Interno e de Exporta��o
                   stcofinsOperCredRecTribENaoTribMercIntEExportacao,  // '56' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno e de Exporta��o
                   stcofinsCredPresAquiExcRecTribMercInt,        // '60' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita Tributada no Mercado Interno
                   stcofinsCredPresAquiExcRecNaoTribMercInt,     // '61' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita N�o-Tributada no Mercado Interno
                   stcofinsCredPresAquiExcExcRecExportacao,      // '62' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita de Exporta��o
                   stcofinsCredPresAquiRecTribNaoTribMercInt,   // '63' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno
                   stcofinsCredPresAquiRecTribMercIntEExportacao,     // '64' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o
                   stcofinsCredPresAquiRecNaoTribMercIntEExportacao,  // '65' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas N�o-Tributadas no Mercado Interno e de Exporta��o
                   stcofinsCredPresAquiRecTribENaoTribMercIntEExportacao, // '66' // Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno e de Exporta��o
                   stcofinsOutrasOperacoes_CredPresumido,        // '67' // Cr�dito Presumido - Outras Opera��es
                   stCofinsOperAquiPorST ]
                   then
        result:=true;
    end;

///////////////////////


end.

