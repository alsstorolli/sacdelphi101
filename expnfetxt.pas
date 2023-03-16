{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE ON}
{$WARN UNSAFE_CODE ON}
{$WARN UNSAFE_CAST ON}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}

unit expnfetxt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  SQLGrid, ExtCtrls, Grids, SqlDtg, SqlExpr, ACBrNFe, pcnConversao, SqlSis,
  Math, ACBrBase, ACBrSocket, ACBrIBPTax,  URLMON, ACBrDFe, PcnConversaoNfe,
  ACBrNFeDANFEClass, ACBrNFeDANFeRLClass, STRUtils, pcnNFe, pcnAuxiliar,
  ACBrNFeNotasFiscais, ACBrMail, ACBrDANFCeFortesFrA4, ACBrDANFCeFortesFr,
  ACBrDFeReport, ACBrDFeDANFeReport, ACBrGNREGuiaClass, ACBrGNReGuiaRLClass,
  ACBrGNRE2,  ACBrDFeUtil ;




type
  TFExpNfetxt = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
//    APHeadLabel1: TAPHeadLabel;
    bExecutar: TSQLBtn;
    bSair: TSQLBtn;
    bexportados: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Edtermino: TSQLEd;
    EdInicio: TSQLEd;
    EdPasta: TSQLEd;
    EdTran_codigo: TSQLEd;
    EdTran_nome: TSQLEd;
    pgrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    Edformaemissao: TSQLEd;
    EdNumeronotas: TSQLEd;
    EdAmbiente: TSQLEd;
    EdExportadas: TSQLEd;
    EdNotas: TSQLEd;
    bexpxml: TSQLBtn;
    bgerenciar: TSQLBtn;
    bconsultasefa: TSQLBtn;
    bconsutawebser: TSQLBtn;
    bimpnfprodutor: TSQLBtn;
    od1: TOpenDialog;
    Edtipomov: TSQLEd;
    bconsultarecibo: TSQLBtn;
    EdRecibo: TSQLEd;
    MemoDAdos: TMemo;
    Bevel1: TBevel;
    bpreviewxml: TSQLBtn;
   // ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    baltentrada: TSQLBtn;
//    ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes;
//    ACBrNFeDANFCeFortesA41: TACBrNFeDANFCeFortesA4;
//    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    ACBrNFe1: TACBrNFe;
    bgnre: TSQLBtn;
    ACBrGNRE1: TACBrGNRE;
    ACBrGNREGuiaRL1: TACBrGNREGuiaRL;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes;
    ACBrNFeDANFCeFortesA41: TACBrNFeDANFCeFortesA4;
    bgeramdfe: TSQLBtn;
    ACBrMail1: TACBrMail;
//    ACBrNFeDANFCeFortesA41: TACBrNFeDANFCeFortesA4;
//    ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes;
//    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    procedure EdterminoValidate(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdPastaExitEdit(Sender: TObject);
    procedure bExecutarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdUnid_codigoValidate(Sender: TObject);
    procedure bexportadosClick(Sender: TObject);
    procedure EdTran_codigoValidate(Sender: TObject);
    procedure EdNotasValidate(Sender: TObject);
    procedure bexpxmlClick(Sender: TObject);
    procedure bgerenciarClick(Sender: TObject);
    procedure bconsultasefaClick(Sender: TObject);
    procedure bconsutawebserClick(Sender: TObject);
    procedure EdformaemissaoValidate(Sender: TObject);
    procedure bimpnfprodutorClick(Sender: TObject);
    procedure bconsultareciboClick(Sender: TObject);
    procedure bpreviewxmlClick(Sender: TObject);
    procedure baltentradaClick(Sender: TObject);
    procedure PBotoesClick(Sender: TObject);
    procedure bgnreClick(Sender: TObject);
    procedure bgeramdfeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute( numeronota:integer=0 ; situacaonotas:string='' ; comcpf:string='S');
    function ContaNotas(Grid:TSqldtgrid):integer;
    procedure SetaTransportadores(Ed:TSqlEd);
    procedure FechaArquivos;
    function GetRetorno(xml:string; xtag:string=''):string;
    function GetTag(ctag,cxml:string):string;
    procedure AtualizaGrid(nf:integer ; xretorno:string);
    function GetGridTransacao(nf:integer):string;
    procedure EnviaConsultaSefa(op:string);
    procedure FechaArquivosXML;
    function TiraString(stringatirar,stringdeondetirar:string):string;
// 10.06.13
    function CalculaImpostoAproximado(xNCM,xCST:string;xvalor:currency):currency;
    function TributaPIS(ycst:TPcnCstPIS):boolean;
    function TributaCOFINS(ycst:TPcnCstCOFINS):boolean;
// 31.12.14 - Coorlaf
   procedure SetaCodigosIbge;
   function  GetCodigoListaIbge(xMuni_nome:string):string;
// 13.10.16
   function GetxMotivo(xml,xchave:string):string;
// 23.11.16
   function ValidaSchema( xNfe:TNotasFiscais ):boolean;
// 07.09.2022
   function VerificaNotas:boolean;
  end;

var
  FExpNfetxt: TFExpNfetxt;
  nomearqtexto,nomearqtextoclientes,nomearqtextoprodutos,tiposdemovimento,tiposnao,
  nomearqtextoTransp,TiposDevolucao,xsituacaonotas,xcomcpf,xemail:string;
  Q,QMOvb,QConfMov:Tsqlquery;
  Arquivo,ArqClientes,ArqProdutos,ArqTransp:Textfile;
  RetornoVazio:boolean;
  campo,
  campoicmsst   :TDicionario;
  xnumeronota   :integer;
  ListaIbge:TStringlist;
  xHoraEnvio:TTime;
  TItensNfe:TAcbrNfe;

implementation

uses Transp, Geral, Sqlfun, munic, Natureza, sintegra, Estoque,
  codigosfis, SQLRel, fornece, gerencianfe, nfsaida, DB, Unidades,
  ACBrNFeConfiguracoes, Arquiv, consultawebsernfe, represen, spedpiscofins,
  conpagto, ACBrNFeWebServices, Subgrupos, nfcompra, usuarios, portador,
  codigosipi, Sittribu, grupos,
  ACBrGNREGuias, ACBrGNREConfiguracoes, pgnreConversao, geramdfe, colaboradores;

{$R *.dfm}

{ TFExpNfetxt }

procedure TFExpNfetxt.Execute( numeronota:integer=0 ; situacaonotas:string='' ; comcpf:string='S');
////////////////////////////////////////////////////////////////////////////////////////////////////////
var numerosnotas,sqlconfmov:string;
    Q:TSqlquery;
begin

// 25.07.20
  bgnre.visible := ( Global.Usuario.codigo = 100 );

  memodados.Visible:=(Global.Usuario.Codigo=100);
  edrecibo.Visible:=(Global.Usuario.Codigo=100);
  bconsultarecibo.Visible:=(Global.Usuario.Codigo=100);
// 08.07.19
  campoicmsst:=Sistema.GetDicionario('codigosfis','Cfis_AliqST');
  nomearqtexto:='NFE';
  nomearqtextoClientes:='ClientesNFE';
  nomearqtextoProdutos:='ProdutosNFE';
  nomearqtextoTransp:='TranspNFE';
// 23.01.12
  sqlconfmov:='';
  if FGeral.ConfiguradoECF then
//    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));
// 07.11.14
    sqlconfmov:=' and '+FGeral.GetNOTIN('moes_comv_codigo',inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'))+';'+inttostr(FGeral.GetConfig1AsInteger('ConfMovECFVC')),'N');

  tiposdemovimento:=Global.TiposSaida+';'+Global.CodDevolucaoCompra+';'+Global.CodCompraProdutor+';'+
                    Global.CodDrawBackEnt+';'+Global.CodDevolucaoIgualVenda+';'+Global.CodEntradaImobilizado+';'+
                    Global.CodCompraProdutorReclassifica+';'+Global.CodDevolucaoSimbolicaConsig+';'+Global.CodVendasemFinan+';'+
                    Global.CodCompraConsignado+';'+Global.CodDevolucaodeRemessa+';'+Global.CodDevolucaoRoman+';'+
                    Global.CodNotaRemessaaOrdem+';'+Global.CodEstornoNFeSai+';'+Global.CodDevolucaoTributada+';'+
// 12.09.14
                    Global.CodRemessaConserto+';'+Global.CodNfeComplementoQtde+';'+Global.CodNfeComplementoValorProdutor+';'+
                    Global.CodNfeComplementoIPI+';'+
// 04.12.20
                    Global.CodDevolucaoBonificacao+';'+
                    FGeral.GetConfig1AsString('TIPOSENUMSAIDA'); // 18.05.11
// 26.03.09 - colocado tipo ET - entrada de imobilizado
// 30.09.10 - colocado tipo DA - devolucao de romaneio
// 05.05..11 - colocado tipo VI - venda internet devido Mama
  tiposnao:=Global.TiposNaoFiscal+';'+Global.CodPrestacaoServicos+';'+Global.CodVendaInterna;
  EdPasta.text:=FGeral.GetConfig1AsString('Pastaexpnfe');
  RetornoVazio:=true;
// 07.07.11
  TiposDevolucao:=Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemEstoque+';'+
                  Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoInd+';'+
                  Global.CodDevolucaoSimbolicaConsig+';'+
                  Global.CodDevolucaodeRemessa+';'+
                  Global.CodDevolucaoRoman+';'+
                  Global.CodDevolucaoTributada+';'+
// 10.10.19 - Mirvane
                  Global.CodNfeComplementoIcms+';'+
// 06.05.19 - Clessi usava RG dai sugeri DJ
                  Global.CodDevolucaoSaida;

//  bexpxml.Visible:=Global.Usuario.Codigo=100;
//  bexpxml.Enabled:=Global.Usuario.Codigo=100;


     Show;

//
//     FExpnfetxt.visible:=false;
//
//  end;

// 09.11.16
  FGeral.ConfiguraColorEditsNaoEnabled(FExpNfetxt);
  Grid.clear;
  EdUnid_codigo.text:=Global.CodigoUnidade;
// 08.03.10
  if trim( FGeral.GetConfig1AsString('AmbienteNFe') )<>'' then
    EdAmbiente.text:=FGeral.GetConfig1AsString('AmbienteNFe')
  else
    EdAmbiente.text:='2';
// 02.01.14
  Acbrnfe1.Configuracoes.WebServices.ProxyHost:='';
  Acbrnfe1.Configuracoes.WebServices.ProxyUser:='';
  Acbrnfe1.Configuracoes.WebServices.ProxyPass:='';
  Acbrnfe1.Configuracoes.WebServices.ProxyPort:='';
//    FGeral.ACBrIBPTax1.ProxyHost:='192.168.1.253';
  FGeral.ACBrIBPTax1.ProxyHost:='';
  FGeral.ACBrIBPTax1.ProxyUser:='';
//    FGeral.ACBrIBPTax1.ProxyPass:='andre2014';
  FGeral.ACBrIBPTax1.ProxyPass:='';
  FGeral.ACBrIBPTax1.ProxyPort:='';
  if Global.Topicos[1013] then begin
    Acbrnfe1.Configuracoes.WebServices.ProxyHost:=FGeral.GetConfig1AsString('ipproxy');
    Acbrnfe1.Configuracoes.WebServices.ProxyUser:=FGeral.GetConfig1AsString('usuarioproxy');
    Acbrnfe1.Configuracoes.WebServices.ProxyPass:=FGeral.GetConfig1AsString('senhaproxy');
    Acbrnfe1.Configuracoes.WebServices.ProxyPort:=FGeral.GetConfig1AsString('portaproxy');
//    FGeral.ACBrIBPTax1.ProxyHost:='192.168.1.253';
    FGeral.ACBrIBPTax1.ProxyHost:=FGeral.GetConfig1AsString('ipproxy');
    FGeral.ACBrIBPTax1.ProxyUser:=FGeral.GetConfig1AsString('usuarioproxy');
//    FGeral.ACBrIBPTax1.ProxyPass:='andre2014';
    FGeral.ACBrIBPTax1.ProxyPass:=FGeral.GetConfig1AsString('senhaproxy');
    FGeral.ACBrIBPTax1.ProxyPort:=FGeral.GetConfig1AsString('portaproxy');
  end;

// 07.07.10 - Abra
  if Global.Topicos[1014] then
    Acbrnfe1.Configuracoes.WebServices.Visualizar:=true
  else
    Acbrnfe1.Configuracoes.WebServices.Visualizar:=false;
// 21.09.10
  if trim( FGeral.GetConfig1AsString('Pastaschemas') ) <> '' then
    Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=FGeral.GetConfig1AsString('Pastaschemas')
//  else if Sistema.Hoje>=Texttodate('01012011') then
//    Acbrnfe1.Configuracoes.Geral.PathSchemas:=ExtractFilePath( Application.ExeName )+'Schemas20'
  else
//    Acbrnfe1.Configuracoes.Geral.PathSchemas:=ExtractFilePath( Application.ExeName )+'Schemas';
// 01.04.2011
    Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=ExtractFilePath( Application.ExeName )+'Schemas20';
// 04.10.11
  xsituacaonotas:=situacaonotas;
  xcomcpf:=comcpf;
// 27.09.10
   Acbrnfe1.Configuracoes.Arquivos.Salvar:=true;
// 13.10.16 - para noa salvar mais o pdf...
// 26.10.16 - retornado para salvar o xml com a autorizacao da receita ?

// 13.03.15
//  if global.topicos[1041] then
//    Acbrnfe1.Configuracoes.Geral.VersaoDF:=ve310;
// 26.06.18
//    if FileExists('leiauteNFe_v400.xsd') then
//        Acbrnfe1.Configuracoes.Geral.VersaoDF:=ve400;
// 02.08.18
//    if FileExists( Acbrnfe1.Configuracoes.Arquivos.PathSchemas+'\leiauteNFe_v400.xsd' ) then

     Acbrnfe1.Configuracoes.Geral.VersaoDF:=ve400;
// 03.06.19 - para quem cst de ST tipo csosn 0500  ou cst 060
    if (EdAmbiente.Text='1') and (Sistema.Hoje>=Texttodate('03062019') )
       and (Global.UFUnidade = 'PR') then
       Acbrnfe1.Configuracoes.Geral.ForcarGerarTagRejeicao938:=fgtSomenteProducao
    else
       Acbrnfe1.Configuracoes.Geral.ForcarGerarTagRejeicao938:=fgtSomenteHomologacao;

// 04.06.19  - para o caso de 'atualizar' o componente e perder alguma propriedade
     AcbrNfe1.Configuracoes.Geral.VersaoQRCode:=veqr200;

//    if Global.Usuario.Codigo=100 then
//      if confirma('usar nfe 4.0 ?') then
//        Acbrnfe1.Configuracoes.Geral.VersaoDF:=ve400;

//  else
//    Acbrnfe1.Configuracoes.Geral.VersaoDF:=ve200;
// 06.07.15 - NFC-e
  AcbrNfe1.Configuracoes.Geral.ModeloDF:= monfe;
////////  AcbrNfe1.Configuracoes.Geral.IdCSC:='';
// 08.12.15 - ja deixa 'certo' a tabela para calculo do ibpt
  FGeral.SetaTabelaIBPT;

  if xsituacaonotas='NFCe' then begin
    AcbrNfe1.Configuracoes.Geral.ModeloDF:= monfce;
  end;
// 23.08.18 - Mercado Burille
  if FGeral.GetConfig1AsString('idcsc')<>'' then
     AcbrNfe1.Configuracoes.Geral.IdCSC:=FGeral.GetConfig1AsString('idcsc')
  else
     AcbrNfe1.Configuracoes.Geral.IdCSC:='1';

  AcbrNfe1.Configuracoes.Geral.CSC:=FGeral.getconfig1asstring('idtoken');
///////////
  if EdInicio.isempty then
    EdInicio.setdate(sistema.hoje);
  if EdTermino.isempty then
    EdTermino.setdate(sistema.hoje);
// 10.02.16
  if Global.topicos[1390] then
//     AcbrNfe1.Configuracoes.Geral.IncluirQRCodeXMLNFCe:=true;
// 03.08.18 - nao tem mais esta propriedade
//     AcbrNfe1.Configuracoes.Geral.IncluirQRCodeXMLNFCe:=true;

// 28.07.16 - pra tentar diminuir os 'sem retorno da sefa'
//   AcbrNfe1.Configuracoes.WebServices.TimeOut:=1000;
   AcbrNfe1.Configuracoes.WebServices.TimeOut:=20*1000;

// 22.01.18
  if trim(FGeral.GetConfig1AsString('Pastaimagemdanfe'))<>'' then begin
//    Acbrnfe1.DANFE.Logo:=FGeral.GetConfig1AsString('Pastaimagemdanfe')
// 28.04.11
    if FileExists( FGeral.GetConfig1AsString('Pastaimagemdanfe') ) then begin
        AcbrnfeDanfeRL1.Logo:=FGeral.GetConfig1AsString('Pastaimagemdanfe');
    end else if FileExists( ExtractFilePath( Application.ExeName ) + FGeral.GetConfig1AsString('Pastaimagemdanfe') ) then begin
        AcbrnfeDanfeRL1.Logo:=ExtractFilePath( Application.ExeName )+ FGeral.GetConfig1AsString('Pastaimagemdanfe');
    end else begin
      AcbrnfeDanfeRL1.Logo:='';
// 19.02.18
      if AcbrNFe1.DANFE<>nil then
        ACBrNFe1.DANfe.Logo:='';
    end;
  end else begin
//    Acbrnfe1.DANFE.Logo:='';
    AcbrnfeDanfeRL1.Logo:='';
  end;

// 02.06.20 - referente emitente da nota
   if Global.Topicos[1472] then
// 28.06.19 - Tempero da Hora
      AcbrnfeDanfeRL1.ImprimeNomeFantasia:=true
  else
      AcbrnfeDanfeRL1.ImprimeNomeFantasia:=False;


// 11.05.11
  xnumeronota:=numeronota;
// 05.04.17
  xemail:=FGeral.GetConfig1AsString('emailportalnfe');
   Acbrmail1.from:=FGeral.getconfig1asstring('EMAILORIGEM');
   Acbrmail1.Host:=FGeral.getconfig1asstring('SMTP');
   Acbrmail1.Username:=FGeral.getconfig1asstring('USUARIOSMTP');
   Acbrmail1.Password:=FGeral.getconfig1asstring('SENHASMTP');
   Acbrmail1.Port:=inttostr(FGeral.GetConfig1AsInteger('portasmtp'));
   if FGeral.EmailStmpcomSSL( FGeral.GetConfig1AsString('EMAILORIGEM') ) then
     Acbrmail1.SetSSL;
   ACBrMail1.SetTLS := true; // Auto TLS
   ACBrNfe1.MAIL:=AcbrMail1;
// 04.08.18
//  FGeral.ConfiguraCriptografiaAcbrNfe( AcbrNfe1 );
// 02.06.20
  FGeral.ConfiguraCriptografiaAcbrNfe( AcbrNfe1,Global.UFUnidade );
// 25.07.20
  FGeral.ConfiguraCriptografiaAcbrGNRE( AcbrGNRE1,Global.UFUnidade );
  FGeral.ConfiguraAcbrGNRE( AcbrGNRE1,Global.UFUnidade );

// 10.04.19
  AcbrNfe1.Configuracoes.RespTec.IdCSRT:=0;
  AcbrNfe1.Configuracoes.RespTec.CSRT  :='';
// 10.03.2021
  EdNotas.Clear;

  if xnumeronota>0 then begin

    EdInicio.setdate( Sistema.Hoje );
    EdTermino.setdate( Sistema.Hoje );
    EdInicio.Next;
    EdTermino.Next;
    EdUnid_codigo.Next;
    EdAmbiente.Next;
    EdTran_codigo.Next;
    EdNotas.Text:=strzero(numeronota,6);
    EdNotas.Next;
    EdFormaEmissao.text:='1';
    EdFormaEmissao.Next;
    bexpxmlClick(self);
// 04.04.16 - Devereda
    if Global.topicos[1388] then begin
//      FGerenciaNfe.Execute(inttostr(numeronota));
      if xsituacaonotas='NFCe' then begin
// 14.06.2022 - pra ver se imprime certo direto da tela da venda balcao em sessao de servidor TS
        FGerenciaNfe.Execute(inttostr(numeronota),xsituacaonotas);
        FGerenciaNfe.bimpnfceClick(self)

      end else begin

        FGerenciaNfe.Execute(inttostr(numeronota));
        FGerenciaNfe.bimpdanfeClick(self);

      end;

      FGerenciaNfe.Close;
    end;
    Close;

  end else if xsituacaonotas<>'' then begin

// 06.07.15
    if xsituacaonotas='NFCe' then
       sqlconfmov:=' and '+FGeral.GetIN('moes_comv_codigo',inttostr(FGeral.GetConfig1AsInteger('ConfMovNFCe'))+';'+inttostr(FGeral.GetConfig1AsInteger('ConfMovNFCeVC')),'N')
// 10.03.2022 - para autorizar somente nf-e sem pegar nfc-e junto
    else if FGeral.GetConfig1AsInteger('ConfMovNFCe')>0 then

       sqlconfmov:=' and '+FGeral.GetNOTIN('moes_comv_codigo',inttostr(FGeral.GetConfig1AsInteger('ConfMovNFCe'))+';'+inttostr(FGeral.GetConfig1AsInteger('ConfMovNFCeVC')),'N');

    Q:=Sqltoquery('select moes_numerodoc from movesto where moes_chavenfe is null'+
                  ' and moes_datamvto='+Datetosql(Sistema.hoje)+
                  ' and moes_status<>''C'''+
                  sqlconfmov+   // 23.01.12
                  ' and moes_unid_codigo='+EdUnid_codigo.assql+
                  ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                  ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                  ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C') );
    numerosnotas:='';
    while not Q.eof do begin
      if Q.fieldbyname('moes_numerodoc').AsInteger>0 then
        numerosnotas:=numerosnotas+strzero( Q.fieldbyname('moes_numerodoc').AsInteger ,6)+';';
      Q.Next;
    end;
    FGeral.FechaQuery(Q);
    if trim(numerosnotas)='' then begin
      Aviso('N�o encontrado notas a enviar para Sefa');
      close;
      exit;
    end;
    EdInicio.setdate( Sistema.Hoje );
    EdTermino.setdate( Sistema.Hoje );
    EdInicio.Next;
    EdTermino.Next;
    EdUnid_codigo.Next;
    EdAmbiente.Next;
    EdTran_codigo.Next;
    EdNotas.Text:=numerosnotas;
    EdNotas.Next;
    EdFormaEmissao.text:='1';
    EdFormaEmissao.Next;
    bexpxmlClick(self);
    FGerenciaNfe.Execute(numerosnotas,xsituacaonotas);
// 30.07.15
    if xsituacaonotas='NFCe' then
      FGerenciaNfe.bimpnfceClick(self)
    else
      FGerenciaNfe.bimpdanfeClick(self);
    FGerenciaNfe.Close;
    Close;

  end else
    EdInicio.SetFirstEd;
//  EdInicio.SetFocus;

end;

procedure TFExpNfetxt.EdterminoValidate(Sender: TObject);
begin
    if EdTermino.asdate<EdInicio.asdate then
      EdTermino.invalid('T�rmino deve ser posterior ao inicio');

end;

procedure TFExpNfetxt.EdUnid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdUnid_codigo,key);

end;

procedure TFExpNfetxt.EdPastaExitEdit(Sender: TObject);
////////////////////////////////////////////////////////
var sqltran,sqlexp,sqlnotas,sqlconfmov,sqltipomov,xstatus,sqltiposmov:string;
    p:integer;

   procedure ChecaEnderecos(Grid1:TSqlDtGrid);
   /////////////////////////////////////////////
   var i,posicaovirgula,posicaokm,posicao2numeros:integer;
       numero:string;
   begin
     for i:=1 to Grid.RowCount do begin
       if strtointdef(Grid1.Cells[Grid.getcolumn('moes_numerodoc'),i],0)>0 then begin
         posicaovirgula:=pos(',',Grid1.Cells[Grid.getcolumn('clie_endres'),i]);
         posicaokm:=pos('KM',uppercase(Grid1.Cells[Grid.getcolumn('clie_endres'),i]));
         posicao2numeros:=FSintegra.Posicao2num(Grid1.Cells[Grid.getcolumn('clie_endres'),i]);
         if (posicaovirgula+posicaokm+posicao2numeros)=0 then begin
           Grid1.Cells[Grid.getcolumn('clie_uf'),i]:='S';
//           Grid1.Cells[Grid.getcolumn('clie_tipo'),i]:='';
         end else begin
           if (posicaovirgula>0) then
             numero:=copy(Grid1.Cells[Grid.getcolumn('clie_endres'),i],posicaovirgula+1,5)
           else if (posicaokm>0) then
             numero:=copy(Grid1.Cells[Grid.getcolumn('clie_endres'),i],posicaokm+3,4)
           else
             numero:=copy(Grid1.Cells[Grid.getcolumn('clie_endres'),i],posicao2numeros,4);
           Grid1.Cells[Grid.getcolumn('clie_uf'),i]:='N';
//           Grid1.Cells[Grid.getcolumn('clie_tipo'),i]:=numero;
         end;
       end;
     end;
   end;

begin
////////////////////////////////////////////////////////////////////

  sqltran:='';sqlexp:='';sqlnotas:='';sqltipomov:='';
  xstatus:='N;E;D';
  if EdTipoMOv.text='I' then xstatus:='I';
// 14.06.18
  if EdTipoMOv.text='X' then xstatus:='X';

  if not EdTRan_codigo.isempty then
    sqltran:=' and '+FGeral.Getin('moes_tran_codigo',EdTran_codigo.text,'C');
  if EdExportadas.text='S' then
    sqlexp:=' and moes_nfeexp=''S'''
  else if EdExportadas.text='N' then
    sqlexp:=' and ( (moes_nfeexp is null) or (moes_nfeexp<>''S'') )'
  else if EdExportadas.text  = 'X' then
//    sqlexp:=' and ( (moes_dtnfeauto is null) and (moes_nfeexp is not null) )';
// 28.06.17 - 'coisas' no devereda
//    sqlexp:=' and ( (moes_dtnfeauto is null) and (moes_datacont is not null) )';
// 07.03.18 - 'mais coisas' do devereda
//    sqlexp:=' and ( (moes_chavenfe ='''' ) and (moes_datacont is not null) )';
// 15.03.18
//    sqlexp:=' and ( (moes_chavenfe is null ) and (moes_datacont is not null) )';
// 01.04.18 - 28.08.19 - retornada
   sqlexp:=' and ( ( (moes_chavenfe is null) or (moes_chavenfe = '''') ) and (moes_datacont is not null) )';
// 04.04.19 - 28.06.19 - nao deu boa
//    sqlexp:=' and (moes_datacont is not null) '+
//            ' and moes_retornonfe not like '+stringtosql('%'+'Autorizad'+'%');

  if not EdNotas.isempty then
    sqlnotas:=' and '+FGeral.GetIN('moes_numerodoc',EdNOtas.text,'N');
  if Edtipomov.text='S' then
    sqltipomov:=' and '+FGeral.GetIN('moes_tipomov',Global.CodCompraProdutor,'C')
// 01.12.15 - devereda
  else if Edtipomov.text = 'N' then
    sqltipomov :=' and '+FGeral.GetIN('moes_comv_codigo',inttostr(FGeral.GetConfig1AsInteger('ConfMovNFCe'))+';'+inttostr(FGeral.GetConfig1AsInteger('ConfMovNFCeVC')),'N')
// 23.02.23
  else if Edtipomov.text = 'D' then
    sqltipomov :=' and '+FGeral.GetIN('moes_especie','NFE','C');

// 23.01.12
  sqlconfmov:='';
  if FGeral.ConfiguradoECF then
//    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));
// 07.11.14
    sqlconfmov:=' and '+FGeral.GetNOTIN('moes_comv_codigo',inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'))+';'+inttostr(FGeral.GetConfig1AsInteger('ConfMovECFVC')),'N') ;
// 05.05.17
  sqltiposmov:='';
  if trim( FGeral.GetConfig1AsString('TIPOSNAOAUTORIZA') ) <> ''  then
    sqltiposmov:=' and '+FGeral.GetNOTIN('moes_tipomov',FGeral.GetConfig1AsString('TIPOSNAOAUTORIZA'),'C');

  Q:=sqltoquery('select movesto.*,clientes.clie_razaosocial,clientes.clie_tipo,clientes.clie_endres,'+
                'clientes.clie_uf,clientes.clie_nome from movesto'+
                ' left join clientes on (clie_codigo=moes_tipo_codigo)'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status',xstatus,'C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
// 20.05.20 - para quem faz nfe e cte
                ' and moes_tipomov <> '+Stringtosql(Global.CodConhecimentoSaida)+
// 17.11.15
                  ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 sqlconfmov+   // 23.01.12
                 sqltipomov+   // 15.04.15
                 sqltiposmov+  // 05.05.17
//                ' and moes_datacont>1'+
// 15.03.10
                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                sqltran+sqlexp+sqlnotas+
//                ' and moes_tipocad='+stringtosql(Cv)+
//                ' order by moes_datamvto,moes_vispra' );
// 04.07.15
                ' order by moes_numerodoc' );
  Grid.Clear;p:=1;
  if Q.eof then begin
    Avisoerro('Nada encontrado para exporta��o');
    exit;
  end;
//  Grid.QueryToGrid(Q);
  while not Q.eof do begin

    Grid.Cells[Grid.GetColumn('moes_numerodoc'),p]:=Q.fieldbyname('moes_numerodoc').asstring;
    Grid.Cells[Grid.GetColumn('moes_dataemissao'),p]:=FGeral.FormataData( Q.fieldbyname('moes_dataemissao').asdatetime );
    Grid.Cells[Grid.GetColumn('moes_vlrtotal'),p]:=floattostr(Q.fieldbyname('moes_vlrtotal').Ascurrency);
    Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p]:=Q.fieldbyname('moes_tipo_codigo').asstring;
    if Q.FieldByName('moes_tipocad').AsString='C' then begin
      Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:= Q.fieldbyname('clie_razaosocial').asstring;
      Grid.Cells[Grid.GetColumn('clie_endres'),p]:=Q.fieldbyname('clie_endres').asstring
//      Grid.Cells[Grid.GetColumn('clie_uf'),p]:=Q.fieldbyname('clie_uf').asstring
    end else if Q.FieldByName('moes_tipocad').AsString='U' then begin
      Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:=FGeral.GetNomeRazaoSocialEntidade( Q.fieldbyname('moes_tipo_codigo').asinteger,
                                Q.fieldbyname('moes_tipocad').asstring,'R');
      Grid.Cells[Grid.GetColumn('clie_endres'),p]:=FUnidades.getendereco( Q.fieldbyname('moes_unid_codigo').asstring );
//      Grid.Cells[Grid.GetColumn('clie_uf'),p]:=Q.fieldbyname('clie_uf').asstring
    end else begin
      Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:=FGeral.GetNomeRazaoSocialEntidade( Q.fieldbyname('moes_tipo_codigo').asinteger,
                                Q.fieldbyname('moes_tipocad').asstring,'R');
      Grid.Cells[Grid.GetColumn('clie_endres'),p]:=FFornece.GetEndereco( Q.fieldbyname('moes_tipo_codigo').Asinteger );
//      Grid.Cells[Grid.GetColumn('clie_uf'),p]:=Q.fieldbyname('clie_uf').asstring
    end;
    Grid.Cells[Grid.GetColumn('moes_transacao'),p]:=Q.fieldbyname('moes_transacao').asstring;
// 07.03.18
    if Q.fieldbyname('moes_status').AsString='N' then begin
      if Q.fieldbyname('moes_chavenfe').AsString='' then
        Grid.Cells[Grid.GetColumn('retorno'),p]:='Nota ainda n�o autorizada'
      else
        Grid.Cells[Grid.GetColumn('retorno'),p]:=Q.fieldbyname('moes_retornonfe').asstring;

    end else
      Grid.Cells[Grid.GetColumn('retorno'),p]:=Q.fieldbyname('moes_retornonfe').asstring;

// 08.11.17
    Grid.Cells[Grid.GetColumn('moes_especie'),p]:=Q.fieldbyname('moes_especie').asstring;
    Grid.AppendRow;
    inc(p);
    Q.Next;
  end;
  ChecaEnderecos(Grid);
  EdNumeronotas.setvalue(ContaNotas(Grid));

end;

//////////////////////////////////////////////////////////////////////////////////////////
procedure TFExpNfetxt.bExecutarClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////////////////////////
var linha,transacoes,sep,codmuni,codmuniemitente,chaveacesso,vistaprazo,tipodoc,formatodanfe,codigonumerico,
    DvChaveAcesso,Ambiente,Finalidade,processoemissao,versao,numero,codigopais,
    nomepais,linhacliente,linhaproduto,versaolayout,qtipo,cnpjtran,cpftran,rntc,
    codigoproduto,redubasetexto,modbc,modbcst,caracteresespeciais,dadosadicionais,cfopind,dadosarmadefogo:string;
    Q1,QDesti,QPend:TSqlquery;
    TNOtas,TClientes,TProdutos,TClientesCodigo,TProdutosCodigo,TNotasCst,TProdutosCst,TProdutosCodigoCst,
    TProdutosAux,ListaProdutosCst,TTransp,TTranspCodigo:TStringlist;
    Nnotas,seq,qtderegn,i,y:integer;
    Datam:TDatetime;
    Totalitem,redubase,baseicms,vlrpis,alipis,vlrcofins,alicofins,totalpis,
    totalcofins,vlrdesco,vlrii,aliicms,
    valorII,totalvalorII :currency;
    vlricms:extended;

////////////////////////////////////
{
    procedure GeraArquivo(Lista:TStringlist ; tipo:string  );
    /////////////////////////////////////////////////////////////////
    var p:integer;
    begin
      for p:=0 to Lista.count-1 do begin
        if tipo='NOTAS' then
          Writeln(arquivo,Lista[p])
        else if tipo='PRODUTOS' then
          Writeln(arqProdutos,Lista[p])
        else if tipo='CLIENTES' then begin
          Writeln(arqClientes,'A'+SEP+versaolayout+sep);
          Writeln(arqClientes,Lista[p]);
        end else if tipo='TRANSPORTADORA' then begin
          Writeln(arqTransp,'A'+SEP+versaolayout+sep);
          Writeln(arqTransp,Lista[p]);
        end;
      end;
    end;

    function GetSerie(serie:string):string;
    begin
      if trim(uppercase(serie))='U' then
        result:='0'
      else
        result:=strspace(serie,length(trim(serie)));
    end;

    function GetCodigoNumerico(t:string):string;
    var s:integer;
    begin
      s:=length(trim(t));
      if s<9 then
        result:=t+copy('0000000000',1,9-s)
      else if s=9 then
        result:=copy(t,1,9)
      else if s=10 then
        result:=copy(t,2,9)
      else if s=11 then
        result:=copy(t,3,9)
      else
        result:=copy(t,4,9);
    end;

    function GetDvChaveAcesso(chave:string):string;
    var t,i,soma,multi,n,resto:integer;
    begin
      t:=length(trim(chave));
      n:=2;soma:=0;
      for i:=t downto 1 do begin
         multi:=n*strtoint(copy(chave,i,1));
         soma:=soma+multi;
         if n=9 then
           n:=2
         else
           inc(n);

      end;

//      showmessage('soma='+inttostr(soma)+' multi='+inttostr(multi));

      resto:= (soma mod 11);
      if (resto=0) or (resto=1) then
        result:='0'
      else
        result:=inttostr(11-resto);
    end;

    function GetInsEst(s:string;tipo:string='C'):string;
    var d:string;
    begin
          if (trim(s)='')  then
//            d:='ISENTO'  // nao validou a nota
            d:=''
          else if tipo='T' then  // 10.11.08
              d:=copy(s,1,14)
          else if  Q.fieldbyname('moes_tipocad').asstring='C' then begin
            if QDesti.fieldbyname('clie_tipo').asstring='F' then
//              d:='ISENTO'
// 02.12.08 - 'ISENTO' � SOMENTE SE for contribuiente do icms mas nao estiver obrigado a ter
//                     inscri��o estadual  // no do produtor rural deixar em branco
              d:=''
            else
              d:=copy(s,1,14);
          end else
            d:=copy(s,1,14);
          result:=strspace(d,14);
    end;

    function GetCnpjCpf(s:string ; tam:integer):string;
    var d,t:string;
    begin
      if Q.fieldbyname('moes_tipocad').asstring='C' then
        t:='Cliente'
      else if Q.fieldbyname('moes_tipocad').asstring='F' then
        t:='Fornecedor'
      else if Q.fieldbyname('moes_tipocad').asstring='R' then
        t:='Representante'
      else
        t:='Unidade';
      if trim(s)='' then begin
        Avisoerro('Codigo '+Q.fieldbyname('moes_tipo_codigo').asstring+' de '+t+' sem CNPJ/CPF');
        d:=strzero(0,14);
      end else if length(trim(s))<tam then
        d:='000'+strspace( copy(s,1,11) ,11 )
      else
        d:=strspace(copy(s,1,14),tam);
      result:=d;
    end;

    function GetTelefone(fone:string):string;
    begin
      if length(trim(fone))<=8 then
        result:='46'+fone
      else if copy(fone,1,1)='0' then
        result:=copy(fone,2,10)
      else if copy(fone,3,1)=' ' then // (46 )32259396
        result:=copy(fone,1,02)+copy(fone,4,08)
// 28.04.11
      else if copy(fone,1,1)=' ' then // ( 46)32259396
        result:=copy(fone,2,02)+copy(fone,4,08)
      else
        result:=copy(fone,1,10);
    end;

    function GetCodigoBarra(codigo:string):string;
    begin
//      if trim(Q1.FieldByName('esto_codbarra').asstring)<>'' then
// 28.04.11
      if copy(Q1.FieldByName('esto_codbarra').asstring,1,3)='789' then
        result:=Q1.FieldByName('esto_codbarra').asstring
      else
        result:='';
    end;

    function GetCfopItem(cst,t,cfop,tipomov,xcfopind:string;ipiproduto:integer;xsimples:string='N'):string;
    //////////////////////////////////////////////////////////////////////////////////
    var Qb,QIpi:TSqlquery;
    begin
      result:=cfop;
// 19.03.10
      if (ipiproduto<=0)  and ( Global.Topicos[1009] ) and (xsimples='N') then begin
        result:=cfop;               // 06.02.12
      end else if (ipiproduto<=0) or (xsimples='S') then begin
        Qb:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(t)+
                       ' and movb_status<>''C'' and movb_tipomov='+stringtosql(tipomov));
        while not Qb.eof do begin
          if Qb.fieldbyname('movb_cst').asstring=cst then begin
            if trim(Qb.fieldbyname('movb_natf_codigo').asstring)<>'' then begin
              result:=Qb.fieldbyname('movb_natf_codigo').asstring;
              break;
            end;
          end;
          Qb.Next;
        end;
// 16.03.10
//      TEstoque:=sqltoquery('select esto_cipi_codigo from estoque where esto_codigo='+stringtosql(produto) );
//      if TEstoque.fieldbyname('esto_cipi_codigo').asinteger>0 then begin
      end else begin
            QIpi:=sqltoquery('select * from codigosipi where cipi_codigo='+inttostr(ipiproduto));
            if not QIpi.eof then begin
               campo:=Sistema.GetDicionario('codigosipi','cipi_fabricap');
               if campo.Tipo<>'' then begin
                 if QIPI.fieldbyname('cipi_fabricap').asstring='S' then
                  result:=xcfopind;
               end else
                  result:=xcfopind;
            end;
            FGeral.Fechaquery(QIpi);
      end;
/////////////////////

// 28.10.09 - devido as variacoes de cfop 'generico'. Ex. : 59491, 59492...
//            o programa da receita de sp nao aceita..nem importa
      result:=copy(result,1,4);
      FGeral.FechaQuery(Qb);
    end;

    function GetGrupo(cst:string):string;
    begin
          if copy(cst,2,2)='00' then
            result:='N02'
          else if copy(cst,2,2)='10' then
            result:='N03'
          else if copy(cst,2,2)='20' then
            result:='N04'
          else if copy(cst,2,2)='30' then
            result:='N05'
          else if pos( copy(cst,2,2),'40;41;50' ) >0 then
            result:='N06'
          else if copy(cst,2,2)='51' then
            result:='N07'
          else if copy(cst,2,2)='60' then
            result:='N08'
          else if copy(cst,2,2)='70' then
            result:='N09'
          else if copy(cst,2,2)='90' then
            result:='N10'
          else
            result:='CST';

    end;

    function GetRegistrosN(linhaproduto:string):integer;
    var x,n:integer;
        Lista:TStringlist;
    begin
      n:=0;
      Lista:=TStringList.Create;
      strtolista(Lista,linhaproduto,'|',true);
      if trim(Lista[1])<>'' then begin
        for x:=0 to TProdutosCodigoCst.count-1 do begin
//          if pos( trim(Lista[1]),trim(TProdutosCodigoCst[x]) )>0 then
// 10.11.08
          if trim(Lista[1])=copy(TProdutosCodigoCst[x],1,pos(';',TProdutosCodigoCst[x])-1)  then
            inc(n);
        end;
      end;
      result:=n;
    end;

    function GetCodigoProdutoN(linhaproduto:string):string;
    var x,n:integer;
        Lista:TStringlist;
    begin
      n:=0;
      Lista:=TStringList.Create;
      strtolista(Lista,linhaproduto,'|',true);
      result:=Lista[1];
    end;
/////////////////////////////////////////////////////////////////////
}


/////////////////////////////////////////////////////
begin
/////////////////////////////////////////////////////
{

}

end;

function TFExpNfetxt.ContaNotas(Grid: TSqldtgrid): integer;
/////////////////////////////////////////////////////////////////
var p,n:integer;
begin
  n:=0;
  for p:=1 to Grid.RowCount do begin
    if trim( Grid.Cells[Grid.getcolumn('moes_numerodoc'),p] )<>'' then begin
      inc(n);
    end;
  end;
  result:=n;
end;

procedure TFExpNfetxt.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 if Texttovalor( Grid.cells[Grid.getcolumn('moes_numerodoc'),1 ] ) > 0 then begin
   if Q<>nil then begin
     if trim(Q.SQL.Text)<>'' then
       FGeral.FechaQuery(Q);
   end;
 end;

end;

procedure TFExpNfetxt.SetaTransportadores(Ed: TSqlEd);
//////////////////////////////////////////////////////////
var Qt:TSqlquery;
begin
  Ed.Items.Clear;
  Qt:=sqltoquery('select distinct moes_tran_codigo,tran_nome,tran_razaosocial from movesto'+
                ' inner join transportadores on ( tran_codigo=moes_tran_codigo )'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
//                ' and moes_datacont>1'+
// 20.07.10
                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C') );
  while not Qt.eof do begin
    Ed.Items.Add(Qt.fieldbyname('moes_tran_codigo').asstring+' - '+Qt.fieldbyname('tran_nome').asstring+
                 ' - '+Qt.fieldbyname('tran_razaosocial').asstring);
    Qt.Next;
  end;
  FGeral.FechaQuery(Qt);
end;

procedure TFExpNfetxt.EdUnid_codigoValidate(Sender: TObject);
begin
  SetaTransportadores(EdTran_codigo);

end;

procedure TFExpNfetxt.bexportadosClick(Sender: TObject);
var p:integer;
    Lista:TStringlist;
begin
  FRel.Init('RelEnderecosNfe');
  FRel.AddTit('Rela��o de Endere�os para Corre��o para NFe');
  FRel.AddTit('Per�odo Exportado '+FGeral.formatadata(Edinicio.asdate)+' a '+FGeral.formatadata(EdTermino.asdate));
  FRel.AddCol( 60,3,'N','' ,''              ,'Codigo'          ,''         ,'',false);
  FRel.AddCol(150,1,'C','' ,''              ,'Raz�o Social'           ,''         ,'',false);
  FRel.AddCol(220,1,'C','' ,''              ,'Endere�o Resid.'         ,''         ,'',false);
  Lista:=TStringlist.Create;
  for p:=1 to Grid.RowCount do begin
    if (Grid.Cells[Grid.getcolumn('clie_uf'),p]='S') and (Lista.IndexOf(Grid.Cells[Grid.getcolumn('moes_tipo_codigo'),p])=-1) then begin
      FRel.AddCel(Grid.Cells[Grid.getcolumn('moes_tipo_codigo'),p]);
      FRel.AddCel(Grid.Cells[Grid.getcolumn('clie_razaosocial'),p]);
      FRel.AddCel(Grid.Cells[Grid.getcolumn('clie_endres'),p]);
      Lista.Add(Grid.Cells[Grid.getcolumn('moes_tipo_codigo'),p]);
    end;
  end;
  FRel.Video();
  Lista.free;
end;

procedure TFExpNfetxt.FechaArquivos;
begin
    CloseFile(Arquivo);
    CloseFile(ArqClientes);
    CloseFile(ArqProdutos);
    CloseFile(ArqTransp);
    sistema.endprocess('Processo Interrompido');
end;

procedure TFExpNfetxt.EdTran_codigoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
    sqltran,sqlconfmov,sqltiposmov:string;
begin
  sqltran:='';
// 23.01.12
// 22.11.12
  sqlconfmov:='';
  if FGeral.ConfiguradoECF then
//    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));
// 07.11.14
    sqlconfmov:=' and '+FGeral.GetNOTIN('moes_comv_codigo',inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'))+';'+inttostr(FGeral.GetConfig1AsInteger('ConfMovECFVC')),'N') ;

// 05.05.17
  sqltiposmov:='';
  if trim( FGeral.GetConfig1AsString('TIPOSNAOAUTORIZA') ) <> ''  then
    sqltiposmov:=' and '+FGeral.GetNOTIN('moes_tipomov',FGeral.GetConfig1AsString('TIPOSNAOAUTORIZA'),'C');

  if not EdTRan_codigo.isempty then
    sqltran:=' and '+FGeral.Getin('moes_tran_codigo',EdTran_codigo.text,'C');
  Q:=sqltoquery('select movesto.moes_numerodoc,clientes.clie_razaosocial,clientes.clie_tipo,clientes.clie_endres,clientes.clie_uf from movesto'+
                ' left join clientes on (clie_codigo=moes_tipo_codigo)'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
//                ' and moes_datacont>1'+
// 20.07.10
                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                sqltran+sqlconfmov+sqltiposmov+
                ' order by moes_numerodoc' );
  EdNotas.Items.Clear;
  if not Q.eof then begin
    while not Q.eof do begin
      EdNotas.Items.add(strzero(Q.fieldbyname('moes_numerodoc').asinteger,6));
      Q.Next;
    end;
  end;
  FGeral.fechaquery(Q);


end;

procedure TFExpNfetxt.EdNotasValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
   if not EdNotas.IsEmpty then begin
     EdExportadas.enabled:=false;
     EdExportadas.text:='A';
   end else begin
     EdExportadas.enabled:=true;
   end;
end;

/////////////////////////////////////////////////////////////
procedure TFExpNfetxt.bexpxmlClick(Sender: TObject);
/////////////////////////////////////////////////////////////
begin

   EnviaConsultaSefa('E');

end;

function TFExpNfetxt.GetRetorno(xml: string ; xtag:string=''):string;
////////////////////////////////////////////////////////
const cautorizado:string='autorizado o uso de nf-e';
const cautorizadooutro:string='autorizado o uso da nf-e';
const ccancelada:string='Cancelamento';

begin
// 16.08.16
  if ( ansipos(Uppercase(ccancelada),Uppercase(XML))>0 ) then
    result:=GetTag('xMotivo',xml)
  else if ( ansipos(Uppercase(cautorizado),Uppercase(XML))>0 ) and ( GetTag('mod',xml)='65' ) then
    result:='NFC-e Autorizada'
  else if ansipos(Uppercase(cautorizado),Uppercase(XML))>0 then
    result:='NF-e Autorizada'
// 14.06.10
  else if ansipos(Uppercase(cautorizadooutro),Uppercase(XML))>0 then
    result:='NF-e Autorizada'
  else if xtag='' then
    result:=GetTag('xMotivo',xml)
  else
    result:=GetTag(xtag,xml);

end;

function TFExpNfetxt.GetTag(ctag, cxml: string): string;
////////////////////////////////////////////////////////////
var cbuscai,cbuscaf:string;
    inicio,fim:integer;
begin
//  result:='N�o encontrado tag '+ctag;
  result:='';
  cbuscai:='<'+ctag+'>';
  cbuscaf:='</'+ctag+'>';
  inicio:=ansipos( Uppercase(cbuscai),Uppercase(cXML) );
  fim:=ansipos( Uppercase(cbuscaf),Uppercase(cXML) );
  if (inicio>0) and (fim>0) then
//    result:=copy(xml,inicio+length(cbuscai),(fim)-(inicio+length(cbuscai)) );
// 18.02.13
    result:=copy(cxml,inicio+length(cbuscai),(fim)-(inicio+length(cbuscai)) );
//  else
//    AvisoErro('N�o encontrado tag '+ctag);

end;

procedure TFExpNfetxt.AtualizaGrid(nf:integer ; xretorno: string);
var i:integer;
begin
  for i:=1 to Grid.RowCount do begin
     if strtointdef(Grid.Cells[Grid.getcolumn('moes_numerodoc'),i],0) = nf then begin
        Grid.Cells[Grid.getcolumn('retorno'),i]:=xretorno;
        break;
     end;
  end;

end;


function TFExpNfetxt.GetGridTransacao(nf: integer): string;
////////////////////////////////////////////////////////////////
var i:integer;
begin
  result:='';
  for i:=1 to Grid.RowCount do begin
     if strtointdef(Grid.Cells[Grid.getcolumn('moes_numerodoc'),i],0) = nf then begin
        result:=Grid.Cells[Grid.getcolumn('moes_transacao'),i];
        break;
     end;
  end;
end;

procedure TFExpNfetxt.bgeramdfeClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var xtrans:string;
    Q     :TSqlquery;

begin

// 29.04.2022 - gera mdfe a partir do xml do fornecedor ( ou qq xml informado )
//              pra pegar a chave , municipio de carregamento e destino
   if not Global.Topicos[1058] then begin

      FGeraMdfe.Execute('','XML');
      Exit;

   end;

   xtrans := Grid.Cells[Grid.getcolumn('moes_transacao'),Grid.row];
   if trim(xtrans) = '' then exit;

   Q:=Sqltoquery('select moes_xmlnfet,moes_xmlnfecanc,moes_dataemissao,moes_numerodoc,moes_cola_codigo,'+
                 'moes_cida_codigo,moes_comv_codigo'+
                 ' from movesto where moes_transacao='+Stringtosql(xtrans)+
                 ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C''') ;

   if not Q.eof then begin

     if trim(Q.fieldbyname('moes_xmlnfet').asstring)='' then begin

          Avisoerro('Transa��o '+xtrans+' sem XML gravado');
          exit;

     end else if trim(Q.fieldbyname('moes_cola_codigo').asstring)='' then begin

          Avisoerro('Nota sem o colaborador(motorista) informado ');
          exit;

     end else if (Q.fieldbyname('moes_cida_codigo').asinteger = FUnidades.GetCidaCodigo( Global.codigoUnidade ))
         and
                 ( not Global.Topicos[1477] )
        then begin

          Avisoerro('Nota com destinat�rio dentro do munic�pio da unidade emissora da NFe');
          exit;

     end else if FColaboradores.GetCpf( Q.fieldbyname('moes_cola_codigo').asstring ) = '' then begin

          Avisoerro('Colaborador codigo '+Q.fieldbyname('moes_cola_codigo').asstring+' sem o CPF informado');
          exit;

     end else if ( Q.fieldbyname('moes_comv_codigo').asstring <> FGeral.Getconfig1asstring('Nfvendaracao') )
              and
                ( FGeral.Getconfig1asstring('Nfvendaracao')<>'' )
           then begin

          Avisoerro('Nota n�o se refere a venda de ra��o configurada no sistema');
          exit;

     end else

        FGeraMdfe.Execute(xtrans);

   end;
   FGeral.Fechaquery( Q );

end;

procedure TFExpNfetxt.bgerenciarClick(Sender: TObject);
begin
//   FGerenciaNfe.Execute( 'A' );
// 06.08.12
   FGerenciaNfe.Execute( EdNotas.text );
end;

// 25.07.20
procedure TFExpNfetxt.bgnreClick(Sender: TObject);
////////////////////////////////////////////////////
var ct,
    CNPJCPF,
    Razao,
    InscricaoEstadual,
    chavenfe,
    cretorno,
    reprnumerica      :string;
    QG,
    QEntidade         :TSqlquery;
    valordifal,
    valorst           :currency;
    emissaonfe        :TDateTime;
    CodigoMunicipio   : integer;
    ufok,
    ok                : boolean;


    procedure GerarGNRE;
    ////////////////////
    begin

        with ACBrGNRE1.Guias.Add.GNRE do
        begin

          c01_UfFavorecida := Qg.fieldbyname('moes_estado').asstring;
          tipoGNRE := tgSimples;
          if valorst > 0 then

             c02_receita :=  100099

          else

            c02_receita :=  100102;

          if length(trim(EdUNid_codigo.resultfind.fieldbyname('unid_cnpj').asstring))= 11 then

             c27_tipoIdentificacaoEmitente := 2

          else

             c27_tipoIdentificacaoEmitente := 1;

          c03_idContribuinteEmitente := EdUNid_codigo.resultfind.fieldbyname('unid_cnpj').asstring;
          c06_valorPrincipal := valordifal;
          c10_valorTotal     := valordifal;
          c14_dataVencimento := Sistema.hoje;
//          c15_convenio := '?????????';
//          c15_convenio := '16461313';

          c16_razaoSocialEmitente := EdUNid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring;
//          c17_inscricaoEstadualEmitente := EdUNid_codigo.resultfind.fieldbyname('unid_inscricaoestadual').asstring;
          c18_enderecoEmitente   := EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring;
          c19_municipioEmitente := copy( FCidades.GetCodigoIBGE( EdUNid_codigo.resultfind.fieldbyname('Unid_cida_codigo').asinteger),3,5) ;
          if trim(EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString)<>'' then
            c20_ufEnderecoEmitente:=EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString
          else
            c20_ufEnderecoEmitente:='PR';

          c21_cepEmitente      := EdUNid_codigo.resultfind.fieldbyname('unid_cep').AsString;
          c22_telefoneEmitente := EdUNid_codigo.resultfind.fieldbyname('unid_fone').AsString;

          if AcbrGnre1.Configuracoes.Geral.VersaoDF = ve100 then begin

             c28_tipoDocOrigem := 10;    // nota fiscal
             c04_docOrigem := strzero(Qg.fieldbyname('moes_numerodoc').asinteger,6);

          end else begin

            c28_tipoDocOrigem := 22;    // chave da nfe  23-cte  24-dfe
            c04_docOrigem := Qg.fieldbyname('moes_chavenfe').asstring;

          end;

          c33_dataPagamento := Sistema.hoje;

          if length(trim(CNPJCPF))= 11 then

            c34_tipoIdentificacaoDestinatario := 2

          else

            c34_tipoIdentificacaoDestinatario := 1;

          c35_idContribuinteDestinatario    := CNPJCPF;
          c36_inscricaoEstadualDestinatario := InscricaoEstadual;
          c37_razaoSocialDestinatario       := Razao;
          c38_municipioDestinatario         := copy( FCidades.GetCodigoIBGE( CodigoMunicipio),3,5) ;

// nem todas as UF exigem o campo referencia...

          referencia.periodo := -1;
          referencia.mes := '';
          referencia.ano := 0;
          referencia.parcela := 0;


          if AnsiPos( Qg.fieldbyname('moes_estado').asstring,'MT/MG' )  > 0 then begin

             referencia.periodo := 0;
             referencia.mes := strzero(Datetomes(emissaonfe),2);
             referencia.ano := Datetoano(emissaonfe,true);
             referencia.parcela := 0;

          end;

          if c28_tipoDocOrigem <> 22 then begin

              with camposExtras.Add do
              begin

                if Qg.fieldbyname('moes_estado').asstring = 'RS' then begin

                  CampoExtra.codigo := 74;
//                  CampoExtra.codigo := 91;
                  CampoExtra.tipo := 'T';
                  CampoExtra.valor := Qg.fieldbyname('moes_chavenfe').asstring;

                end else if Qg.fieldbyname('moes_estado').asstring = 'SC' then begin

                  CampoExtra.codigo := 84;
//                  CampoExtra.codigo := 96;
                  CampoExtra.tipo := 'T';
                  CampoExtra.valor := Qg.fieldbyname('moes_chavenfe').asstring;

                end else if Qg.fieldbyname('moes_estado').asstring = 'PE' then begin

                  if valorst > 0 then
                     CampoExtra.codigo := 9
                  else
                    CampoExtra.codigo := 92;

                  CampoExtra.tipo := 'T';
                  CampoExtra.valor := Qg.fieldbyname('moes_chavenfe').asstring;

                end else if Qg.fieldbyname('moes_estado').asstring = 'MS' then begin

                  if valorst > 0 then
                     CampoExtra.codigo := 27
                  else
                    CampoExtra.codigo := 88;

                  CampoExtra.tipo := 'T';
                  CampoExtra.valor := Qg.fieldbyname('moes_chavenfe').asstring;

                end else if Qg.fieldbyname('moes_estado').asstring = 'MT' then begin

                  if valorst > 0 then
                     CampoExtra.codigo := 17
                  else
                    CampoExtra.codigo := 108;

                  CampoExtra.tipo := 'T';
                  CampoExtra.valor := Qg.fieldbyname('moes_chavenfe').asstring;

                end else begin

                   ufok := false;
                   Avisoerro('UF '+Qg.fieldbyname('moes_estado').asstring+' n�o prevista no sistema. Ver aplicativo pr�prio');

                end;

              end;

          end;
          c42_identificadorGuia := '001';

        end;

    end;


begin

  ct := Grid.Cells[Grid.getcolumn('moes_transacao'),Grid.row];
  if trim(ct)='' then exit;
  Qg := sqltoquery('select * from movesto where moes_transacao = '+Stringtosql(trim(ct)) );

  Acbrnfe1.NotasFiscais.clear;
  Acbrnfe1.NOtasFiscais.LoadFromString(Qg.fieldbyname('moes_xmlnfet').asstring);
  ufok := true;

  if trim(Qg.fieldbyname('moes_xmlnfet').asstring)='' then begin

      Avisoerro('Transa��o '+ct+' sem XML gravado');
      exit;

  end else if FExpNfetxt.GetTag('tpemis',Qg.fieldbyname('moes_xmlnfet').asstring)='2' then begin

     Avisoerro('Transa��o '+ct+' se ref. a nfe em conting�ncia. Autorizar primeiro');
     exit;

   end else if DAtetoano(Qg.fieldbyname('moes_dtnfeauto').asdatetime,true)<=1900 then begin

     Avisoerro('Transa��o '+ct+' ainda n�o foi autorizada');
     exit;

  end else if AnsiPos('Autorizado',FExpNfetxt.GetTag('xmotivo',Qg.fieldbyname('moes_xmlnfet').asstring))= 0 then begin

     Aviso('Nfe ref. Transa��o '+ct+' ainda n�o autorizada pela SEFA');
     exit;

   end else if DAtetoano(Qg.fieldbyname('moes_dtnfecanc').asdatetime,true)>1900 then begin

     Avisoerro('NFe ref. Transa��o '+ct+' foi cancelada em '+FGeral.FormataData(Qg.fieldbyname('moes_dtnfecanc').asdatetime));
     exit;

   end;

  emissaonfe := QG.fieldbyname('moes_dataemissao').asdatetime;

  valordifal := Acbrnfe1.NotasFiscais.Items[0].NFe.Total.ICMSTot.vICMSUFDest +
                Acbrnfe1.NotasFiscais.Items[0].NFe.Total.ICMSTot.vFCP;
  valorst    := Acbrnfe1.NotasFiscais.Items[0].NFe.Total.ICMSTot.vST;

  if valordifal=0  then begin

     Aviso('Nfe sem difal calculada');
     exit;

  end;

// ICMSUFDest.vICMSUFRemet:= basedifal *((100-ICMSUFDest.pICMSInterPart)/100) ;
// valor difal soma difal + fcp...
// codigo varia se tiver ou nao ST na nota]
  if Qg.fieldbyname('moes_tipocad').asstring = 'F' then begin

     QEntidade := sqltoquery(' select * from fornecedores where forn_codigo = '+Qg.fieldbyname('moes_tipo_codigo').asstring);
     razao             := QEntidade.fieldbyname('forn_razaosocial').asstring;
     cnpjcpf           := QEntidade.fieldbyname('forn_cnpjcpf').asstring;
     inscricaoestadual := QEntidade.fieldbyname('forn_inscricaoestadual').asstring;
     codigomunicipio   := QEntidade.fieldbyname('forn_cida_codigo').asinteger;

  end else begin

     QEntidade := sqltoquery(' select * from clientes where clie_codigo = '+Qg.fieldbyname('moes_tipo_codigo').asstring);
     razao             := QEntidade.fieldbyname('clie_razaosocial').asstring;
     cnpjcpf           := QEntidade.fieldbyname('clie_cnpjcpf').asstring;
     inscricaoestadual := QEntidade.fieldbyname('clie_rgie').asstring;
     codigomunicipio   := QEntidade.fieldbyname('clie_cida_codigo_res').asinteger;

  end;

  ACBrGNRE1.Guias.Clear;
  AcbrGnre1.Configuracoes.WebServices.Ambiente := StrToTpAmb( ok,EdAmbiente.text );

  GerarGNRE;
  if not ufok then exit;
//  ACBrGNRE1.Guias.Items[0].GravarXML;

  Sistema.beginprocess('Autorizando GNRE');
//  MemoDAdos.visible := true;

  try

    ACBrGNRE1.Enviar;
    if trim(ACBrGNRE1.WebServices.Retorno.descricao)='' then

       Aviso('Sem retorno da receita, tentar mais tarde')

    else

       Aviso( ACBrGNRE1.WebServices.Retorno.descricao );

  except on Y:exception do

//     Aviso( UTF8Encode(ACBrGNRE1.WebServices.Retorno.RetWS ) );
//     Aviso( GetTag('ns1:descricao', UTF8Encode(ACBrGNRE1.WebServices.Retorno.RetWS ) ) );
     Aviso( ACBrGNRE1.WebServices.Retorno.descricao+' '+Y.message );

//     Memodados.Lines.Text := UTF8Encode(ACBrGNRE1.WebServices.Retorno.RetWS );
//     Memodados.Lines.Text := UTF8Encode( ACBrGNRE1.Guias.Items[0].XMLAssinado );

  end;

  cretorno :=UTF8Encode(ACBrGNRE1.WebServices.Retorno.RetWS );


  if ( pos('SUCESSO',uppercase(cretorno))>0 ) then begin

// ver se cria campos para xml do gnre...semelhante aos da nfe
      Sistema.Edit('movesto');
                 Sistema.setfield('moes_datamanifesto',Sistema.hoje);
                 Sistema.setfield('moes_retornomanifesto',copy(cretorno,1,200));
                 Sistema.setfield('moes_xmlmanifesto',ACBrGNRE1.Guias.Items[0].XMLAssinado) ;
//                 Sistema.setfield('moes_chavenfe',ACBrNFe1.NotasFiscais.Items[i].NFe.procNFe.chNFe);
     Sistema.Post('moes_transacao = '+stringtosql(ct) );
     Sistema.commit;

//     Aviso( 'GNRE Validada' );
     ACBrGNRE1.GuiasRetorno.Clear;
//     ACBrGNRE1.GuiasRetorno.LoadFromFile(OpenDialog1.FileName);
//     ACBrGNRE1.GuiasRetorno.LoadFromString( ACBrGNRE1.Guias.Items[0].XMLAssinado );
//     ACBrGNRE1.Guias.Items[0].GerarXML;

//     ACBrGNRE1.GuiasRetorno.ImprimirPDF;
//     reprnumerica := copy( cretorno,982,48 );

     reprnumerica := ACBrGNRE1.WebServices.Retorno.GNRERetorno.resGuia.Items[0].RepresentacaoNumerica;

     if length(trim( reprnumerica ) ) = 48 then

        ACBrGNRE1.GuiasRetorno.LoadFromFile( ACBrGNRE1.Configuracoes.Arquivos.PathArqTXT+'\'+reprnumerica+'-gnre.TXT' )

     else begin

        od1.initialdir := ACBrGNRE1.Configuracoes.Arquivos.PathArqTXT;
        od1.execute;
        ACBrGNRE1.GuiasRetorno.LoadFromFile(OD1.FileName);

     end;


     ACBrGNRE1.GuiasRetorno.Imprimir;

  end;

  FGeral.FechaQuery( Qg );
  FGeral.FechaQuery( QEntidade );

  Sistema.endprocess('');


end;

procedure TFExpNfetxt.bconsultasefaClick(Sender: TObject);
{
var ct,ct1:string;
    Q,QNfe:TSqlquery;
    ListaXML:TStringList;
    arqxml,cretorno,ctransacao,arqxmlretorno:string;
    marc,i:integer;
}

begin

   EnviaConsultaSefa('C');
{
}

end;

//////////////////////////////////////////////////////////////
procedure TFExpNfetxt.EnviaConsultaSefa(op: string);       // P - Preview  C -consulta - E - envia
/////////////////////////////////////////////////////////////////
var linha,transacoes,sep,codmuni,codmuniemitente,chaveacesso,vistaprazo,tipodoc,formatodanfe,codigonumerico,
    Ambiente,Finalidade,versao,numero,
    nomepais,versaolayout,qtipo,cnpjtran,cpftran,rntc,
    codigoproduto,redubasetexto,modbc,modbcst,caracteresespeciais,dadosadicionais,cretorno,
    ctransacao,senhacertificado,cfopind,ConsumidorFinal,TiposNumeracaoSaida,cretornoerro,ces,
    pathenvioexterno ,arquivoexterno,arquivoexternoret,pathenvioexternoretorno,pathretornoexterno,
    drive,aux,dadosarmadefogo:string;
    Q1,QDesti,QPend,QNfe,QItens,QN,Qg:TSqlquery;
    TNOtas,TClientes,TProdutos,TClientesCodigo,TProdutosCodigo,TProdutosCodigoCst,
    TProdutosAux,ListaProdutosCst,TTransp,
    TTranspCodigo,
    ListaItens01,
    ListaItens02,
    ListaItens02a:TStringlist;
    Nnotas,seq,qtderegn,i,y,codigopais,NUmlote,tempo,p:integer;
    Datam,
    vencimentoNP   :TDatetime;
    Totalitem,redubase,baseicms,vlricms,vlrpis,alipis,vlrcofins,alicofins,totalpis,
    totalcofins,vlrdesco,vlrii,aliicms,vlripi,totalitens,vendaliquido,despacessorias,
    baseicmssemreducao,Valortotalimpaproximado,xvTotTrib,margemlucro,basesubs,icmsitemsubs,
    informainss,totdescitens,moes_vlrgta,vtotalfreteitens,xaliFPC,totalvFCPUFDest,
    totalvICMSUFDest,
    totalvICMSUFRemet,
    valorliquidoNP,
    basedifal,
    valorII ,totalvalorII,
    totalitemliquido,
    totacreitens,
    vlracres                             :currency;
    rateioicmsimportacao,valordesc,xmoes_perdesco,
    xmoes_peracres:extended;
    NotasE:TAcBrNfe;
    ListaEnvioNotas:TStringList;
    ChecaStatusSefa,
    ok         :boolean;
    xmlaux     :TStringList;
    xLink: array[0..120] of WideChar;
    Xmlstream:TMemoryStream;
    xmlstring:WideString;

var ct,ct1:string;
    ListaXML:TStringList;
    arqxmlretorno,
    sqlorder       :string;
    Statusok,Temdi,cOK:boolean;
    tIcmsDeson        :currency;


    procedure GeraArquivo(Lista:TStringlist ; tipo:string  );
    /////////////////////////////////////////////////////////
    var p:integer;
    begin
      for p:=0 to Lista.count-1 do begin
        if tipo='NOTAS' then
          Writeln(arquivo,Lista[p])
        else if tipo='PRODUTOS' then
          Writeln(arqProdutos,Lista[p])
        else if tipo='CLIENTES' then begin
          Writeln(arqClientes,'A'+SEP+versaolayout+sep);
          Writeln(arqClientes,Lista[p]);
        end else if tipo='TRANSPORTADORA' then begin
          Writeln(arqTransp,'A'+SEP+versaolayout+sep);
          Writeln(arqTransp,Lista[p]);
        end;
      end;
    end;

    function GetSerie(serie,tipoemissao:string):integer;
    ////////////////////////////////////////
    begin
      if trim(uppercase(serie))='U' then
        result:=0
      else if tipoemissao='3' then  // 05.11.2012 - Contingencia via Scan
        result:=901
      else
        result:=strtointdef(trim(serie),0);
    end;

    function GetCodigoNumerico(t:string):string;
    /////////////////////////////////////////////
    var s:integer;
    begin
      s:=length(trim(t));
      if s<9 then
        result:=t+copy('0000000000',1,9-s)
      else if s=9 then
        result:=copy(t,1,9)
      else if s=10 then
        result:=copy(t,2,9)
      else if s=11 then
        result:=copy(t,3,9)
      else
        result:=copy(t,4,9);
    end;

    function GetDvChaveAcesso(chave:string):string;
    ///////////////////////////////////////////////
    var t,i,soma,multi,n,resto:integer;
    begin
      t:=length(trim(chave));
      n:=2;soma:=0;
      for i:=t downto 1 do begin
         multi:=n*strtoint(copy(chave,i,1));
         soma:=soma+multi;
         if n=9 then
           n:=2
         else
           inc(n);

      end;

//      showmessage('soma='+inttostr(soma)+' multi='+inttostr(multi));

      resto:= (soma mod 11);
      if (resto=0) or (resto=1) then
        result:='0'
      else
        result:=inttostr(11-resto);
    end;

    function GetInsEst(s:string;tipo:string='C'):string;
    ///////////////////////////////////////////////////
    var d:string;
    begin
          if (trim(s)='')  then
//            d:='ISENTO'  // nao validou a nota
            d:=''
          else if tipo='T' then  // 10.11.08
              d:=copy(s,1,14)
          else if  Q.fieldbyname('moes_tipocad').asstring='C' then begin
            if QDesti.fieldbyname('clie_tipo').asstring='F' then begin
//              d:='ISENTO'
// 02.12.08 - 'ISENTO' � SOMENTE SE for contribuiente do icms mas nao estiver obrigado a ter
//                     inscri��o estadual  // no do produtor rural deixar em branco
// 04.02.13 - cliente da Cenitech exigiu cpf e inscricao estadual do produtor rural
              d:='';
              if QDesti.fieldbyname('Clie_contribuinte').asstring='S' then
                d:=Uppercase( copy(s,1,14) ) ;
            end else
              d:=Uppercase( copy(s,1,14) ) ;
          end else
            d:=Uppercase( copy(s,1,14) ) ;
// 13.02.17
          if trim(d)<>'' then
            result:=strspace( Uppercase(d) ,14)  // uppercase em 27.09.10
          else
            result:=d;
    end;

    function GetCnpjCpf(s:string ; tam:integer):string;
    //////////////////////////////////////////////////
    var d,t:string;
    begin
      if Q.fieldbyname('moes_tipocad').asstring='C' then
        t:='Cliente'
      else if Q.fieldbyname('moes_tipocad').asstring='F' then
        t:='Fornecedor'
      else if Q.fieldbyname('moes_tipocad').asstring='R' then
        t:='Representante'
      else
        t:='Unidade';
      if (trim(s)='') then begin
//        if (Q.fieldbyname('moes_estado').asstring)<>'EX' then
//          Avisoerro('Codigo '+Q.fieldbyname('moes_tipo_codigo').asstring+' de '+t+' sem CNPJ/CPF');
// retirado devido nfc-e - 01.08.15
        d:=strzero(0,14);
      end else if length(trim(s))<tam then
        d:='000'+strspace( copy(s,1,11) ,11 )
      else
        d:=strspace(copy(s,1,14),tam);
      result:=d;
    end;

    function GetTelefone(fone:string):string;
    //////////////////////////////////////////
    begin
// 22.08.18
      if trim(fone)='' then
         result:=''
      else if length(trim(fone))<=8 then
        result:='46'+fone
      else if copy(fone,1,1)='0' then
        result:=copy(fone,2,10)
      else if copy(fone,3,1)=' ' then // (46 )32259396
        result:=copy(fone,1,02)+copy(fone,4,08)
// 28.04.11
      else if copy(fone,1,1)=' ' then // ( 46)32259396
        result:=copy(fone,2,02)+copy(fone,4,08)
      else
        result:=copy(fone,1,10);
    end;

    function GetCodigoBarra(codigo:string):string;
    ///////////////////////////////////////////////
    begin
//      if trim(Q1.FieldByName('esto_codbarra').asstring)<>'' then
// 28.04.11
      if copy(Q1.FieldByName('esto_codbarra').asstring,1,3)='789' then
        result:=Q1.FieldByName('esto_codbarra').asstring
      else
        result:='';
    end;

    function GetCfopItem(cst,t,cfop,tipomov,xcfopind:string;ipiproduto:integer;xsimples:string='N';xcfopmove:string=''):string;
    //////////////////////////////////////////////////////////////////////////////////////////////// //////////////////////
    var Qb,QIpi:TSqlquery;
    begin
      result:=cfop;
// 19.03.10
      if (ipiproduto<=0)  and ( Global.Topicos[1009] ) and (xsimples='N') then begin
        result:=cfop;
// 28.06.16 - devido a devolucao tributada com 2 cfops na novicarnes
      end else if (xsimples='N') and (xcfopmove<>'') then begin
        result:=xcfopmove;
      end else if (ipiproduto<=0) or ( xsimples='S') then begin

        Qb:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(t)+
// 10.06.2022 - Sport Acao - banco de dados com transacao duplicada...
                       ' and movb_numerodoc = '+Q1.FieldByName('move_numerodoc').AsString+
                       ' and movb_status<>''C'' and movb_tipomov='+stringtosql(tipomov));
        while not Qb.eof do begin
          if Qb.fieldbyname('movb_cst').asstring=cst then begin
            if trim(Qb.fieldbyname('movb_natf_codigo').asstring)<>'' then begin
              result:=Qb.fieldbyname('movb_natf_codigo').asstring;
              break;
            end;
          end;
          Qb.Next;
        end;
      FGeral.FechaQuery(Qb);
// 16.03.10
//      TEstoque:=sqltoquery('select esto_cipi_codigo from estoque where esto_codigo='+stringtosql(produto) );
//      if TEstoque.fieldbyname('esto_cipi_codigo').asinteger>0 then begin
      end else begin
            QIpi:=sqltoquery('select * from codigosipi where cipi_codigo='+inttostr(ipiproduto));
            if not QIpi.eof then begin
               campo:=Sistema.GetDicionario('codigosipi','cipi_fabricap');
               if campo.Tipo<>'' then begin
                 if QIPI.fieldbyname('cipi_fabricap').asstring='S' then
                  result:=xcfopind;
               end else
                  result:=xcfopind;
            end;
            FGeral.Fechaquery(QIpi);
      end;
/////////////////////

// 28.10.09 - devido as variacoes de cfop 'generico'. Ex. : 59491, 59492...
//            o programa da receita de sp nao aceita..nem importa
//      result:=copy(result,1,4);
// 16.08.18 - deixado com 5 digitos se for o caso...

    end;

    function GetGrupo(cst:string):string;
    //////////////////////////////////
    begin
          if copy(cst,2,2)='00' then
            result:='N02'
          else if copy(cst,2,2)='10' then
            result:='N03'
          else if copy(cst,2,2)='20' then
            result:='N04'
          else if copy(cst,2,2)='30' then
            result:='N05'
          else if pos( copy(cst,2,2),'40;41;50' ) >0 then
            result:='N06'
          else if copy(cst,2,2)='51' then
            result:='N07'
          else if copy(cst,2,2)='60' then
            result:='N08'
          else if copy(cst,2,2)='70' then
            result:='N09'
          else if copy(cst,2,2)='90' then
            result:='N10'
          else
            result:='CST';

    end;

    function GetRegistrosN(linhaproduto:string):integer;
    ///////////////////////////////////////////////////
    var x,n:integer;
        Lista:TStringlist;
    begin
      n:=0;
      Lista:=TStringList.Create;
      strtolista(Lista,linhaproduto,'|',true);
      if trim(Lista[1])<>'' then begin
        for x:=0 to TProdutosCodigoCst.count-1 do begin
//          if pos( trim(Lista[1]),trim(TProdutosCodigoCst[x]) )>0 then
// 10.11.08
          if trim(Lista[1])=copy(TProdutosCodigoCst[x],1,pos(';',TProdutosCodigoCst[x])-1)  then
            inc(n);
        end;
      end;
      result:=n;
    end;

    function GetCodigoProdutoN(linhaproduto:string):string;
    /////////////////////////////////////////////////////////
    var x,n:integer;
        Lista:TStringlist;
    begin
      n:=0;
      Lista:=TStringList.Create;
      strtolista(Lista,linhaproduto,'|',true);
      result:=Lista[1];
    end;

    function GetCst(xcst:string):TpcnCSTIcms;
    /////////////////////////////////////////
    var ccst:string;
        ok  :boolean;
    begin
      result:=cst00;
      ok :=true;
      ccst:=trim(xcst);  // 08.12.15
      if (ccst='010') or (copy(ccst,2,2)='10') then
        result:=cst10
      else if ccst='020' then
        result:=cst20
      else if ccst='030' then
        result:=cst30
      else if ccst='040' then
        result:=cst40
      else if ccst='041' then
        result:=cst41
      else if ccst='050' then
        result:=cst50
      else if ccst='051' then
        result:=cst51
      else if ccst='060' then
        result:=cst60
      else if ccst='070' then
        result:=cst70
      else if ccst='080' then
        result:=cst80
      else if ccst='081' then
        result:=cst81
// 23.04.19 - Seip
      else if ccst='390' then
        result:=cst90
// 24.04.19 - Seip
      else if ccst='341' then
        result:=cst41
      else if ccst='090' then
        result:=cst90 //80 e 81 apenas para CTe
// 04.12.18
//      else result:=STRtocsticms(ok,ccst);
    end;

////////////////////// 24.10.11
    function GetCstPis(xcst:string):TpcnCSTPis;
    /////////////////////////////////////////
    var ccst:string;
    begin
      result:=pis01;
      ccst:=trim(xcst);
      if ccst='01' then
        result:=pis01
      else if ccst='02' then
        result:=pis02
      else if ccst='03' then
        result:=pis03
      else if ccst='04' then
        result:=pis04
      else if ccst='05' then
        result:=pis05
      else if ccst='06' then
        result:=pis06
      else if ccst='07' then
        result:=pis07
      else if ccst='08' then
        result:=pis08
      else if ccst='09' then
        result:=pis09
      else if ccst='49' then
        result:=pis49
      else if ccst='50' then
        result:=pis50
      else if ccst='51' then
        result:=pis51
      else if ccst='52' then
        result:=pis52
      else if ccst='53' then
        result:=pis53
      else if ccst='54' then
        result:=pis54
      else if ccst='55' then
        result:=pis55
      else if ccst='56' then
        result:=pis56
      else if ccst='60' then
        result:=pis60
      else if ccst='61' then
        result:=pis61
      else if ccst='62' then
        result:=pis62
      else if ccst='63' then
        result:=pis63
      else if ccst='64' then
        result:=pis64
      else if ccst='65' then
        result:=pis65
      else if ccst='66' then
        result:=pis66
      else if ccst='67' then
        result:=pis67
      else if ccst='70' then
        result:=pis70
      else if ccst='71' then
        result:=pis71
      else if ccst='72' then
        result:=pis72
      else if ccst='73' then
        result:=pis73
      else if ccst='74' then
        result:=pis74
      else if ccst='75' then
        result:=pis75
      else if ccst='98' then
        result:=pis98
      else if ccst='99' then
        result:=pis99;
    end;

////////////////////// 25.10.11
    function GetCstCofins(xcst:string):TpcnCSTCofins;
    /////////////////////////////////////////
    var ccst:string;
    begin
      result:=cof01;
      ccst:=trim(xcst);
      if ccst='01' then
        result:=cof01
      else if ccst='02' then
        result:=cof02
      else if ccst='03' then
        result:=cof03
      else if ccst='04' then
        result:=cof04
      else if ccst='05' then
        result:=cof05
      else if ccst='06' then
        result:=cof06
      else if ccst='07' then
        result:=cof07
      else if ccst='08' then
        result:=cof08
      else if ccst='09' then
        result:=cof09
      else if ccst='49' then
        result:=cof49
      else if ccst='50' then
        result:=cof50
      else if ccst='51' then
        result:=cof51
      else if ccst='52' then
        result:=cof52
      else if ccst='53' then
        result:=cof53
      else if ccst='54' then
        result:=cof54
      else if ccst='55' then
        result:=cof55
      else if ccst='56' then
        result:=cof56
      else if ccst='60' then
        result:=cof60
      else if ccst='61' then
        result:=cof61
      else if ccst='62' then
        result:=cof62
      else if ccst='63' then
        result:=cof63
      else if ccst='64' then
        result:=cof64
      else if ccst='65' then
        result:=cof65
      else if ccst='66' then
        result:=cof66
      else if ccst='67' then
        result:=cof67
      else if ccst='70' then
        result:=cof70
      else if ccst='71' then
        result:=cof71
      else if ccst='72' then
        result:=cof72
      else if ccst='73' then
        result:=cof73
      else if ccst='74' then
        result:=cof74
      else if ccst='75' then
        result:=cof75
      else if ccst='98' then
        result:=cof98
      else if ccst='99' then
        result:=cof99;
    end;

// 22.03.10
    function GetCstIPI(xcst:string):TpcnCSTIpi;
    ////////////////////////////////////////////
    var ccst:string;
        ok:boolean;
//C�digo da Situa��o Tribut�ria do IPI:
//00-Entrada com recupera��o de cr�dito
//49 - Outras entradas
//50-Sa�da tributada
//99-Outras sa�das
    begin
      ok:=true;
      // '50';
      ccst:=trim(xcst);
//por enquanto todos q tem ipi vao como tributados
//      if ccst='000' then
        result:=StrToCSTIPI(ok,'50');
//      else
//        result:=StrToCSTIPI(ok,'99');

    end;

    ///////////////////////////////////////////////////////////////
    function GetOrigemMercadoria(xcst,xSimples:string):TpcnOrigemMercadoria;
    ///////////////////////////////////////////////////////////////
    var ccst:string;
    begin
      result:=oeNacional;
      if xSimples<>'S' then begin   // 12.07.11 ver se precisa buscar do cadastro

        ccst:=trim(xcst);
        if copy(ccst,1,1)='1' then
          result:=oeEstrangeiraImportacaoDireta
        else if copy(ccst,1,1)='2' then
          result:=oeEstrangeiraAdquiridaBrasil
        else if copy(ccst,1,1)='3' then
          result:=oeNacionalConteudoImportacaoSuperior40

      end else begin
// 12.07.11
        ccst:=FEstoque.Getsituacaotributaria(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,global.UFUnidade);
        if trim(ccst)='' then ccst:='000';
// 16.04.14 - retirado pois se � do simples '� nacional'...
//        if copy(ccst,1,1)='1' then
//          result:=oeEstrangeiraImportacaoDireta
//        else if copy(ccst,1,1)='2' then
//          result:=oeEstrangeiraAdquiridaBrasil;
      end;

    end;

    /////////////////////////////////////
    function GetSenhaCertificado:boolean;
    /////////////////////////////////////
    var senha:string;
    begin
      result:=true;
      senha:=FGeral.GetConfig1AsString('SenhaCertificado');
      if trim(senha)<>'' then begin
        if Input('Certificado Digital','Informe Senha',senhacertificado,150,false) then begin
          if trim(senhacertificado)<>senha then begin
            result:=false;
            Avisoerro('Senha do certificado divergente com a informada');
          end;
        end else begin
          result:=false;
          Avisoerro('Senha do certificado n�o informada');
        end;
      end;
    end;

    function ValidaNotas( ListaNotas:TACBrNFe ) :boolean;
    //////////////////////////////////////////////////////
    var x,y:integer;
        ListaProdutos:string;
    begin
      result:=true;
      for x:=0 to ListaNotas.NotasFiscais.Count-1 do begin
// 30.07.15
        if ListaNotas.NotasFiscais.Items[x].NFe.Ide.modelo<>65 then begin
          if trim(ListaNotas.NotasFiscais.Items[x].NFe.Dest.EnderDest.nro)='' then begin
            Avisoerro('Nota '+inttostr(ListaNotas.NotasFiscais.Items[x].NFe.Ide.cNF)+' Endere�o '+ListaNotas.NotasFiscais.Items[x].NFe.Dest.EnderDest.xLgr+' sem numero');
            result:=false;
          end else if trim(ListaNotas.NotasFiscais.Items[x].NFe.Dest.EnderDest.xBairro)='' then begin
            Avisoerro('Nota '+inttostr(ListaNotas.NotasFiscais.Items[x].NFe.Ide.cNF)+' Endere�o '+ListaNotas.NotasFiscais.Items[x].NFe.Dest.EnderDest.xLgr+' sem bairro');
            result:=false;
          end else if ListaNotas.NotasFiscais.Items[x].NFe.Dest.EnderDest.CEP=0 then begin
            Avisoerro('Nota '+inttostr(ListaNotas.NotasFiscais.Items[x].NFe.Ide.cNF)+' Endere�o '+ListaNotas.NotasFiscais.Items[x].NFe.Dest.EnderDest.xLgr+' sem Cep');
            result:=false;
  // 19.05.11
//          end else if ListaNotas.NotasFiscais.Items[x].NFe.Dest.EnderDest.fone='' then begin
//            Avisoerro('Nota '+inttostr(ListaNotas.NotasFiscais.Items[x].NFe.Ide.cNF)+' Cliente '+ListaNotas.NotasFiscais.Items[x].NFe.Dest.xNome+' sem telefone');
//            result:=false;
//          end else if ( trim(ListaNotas.NotasFiscais.Items[x].NFe.Transp.veicTransp.placa )='') and (ListaNotas.NotasFiscais.Items[x].NFe.Transp.Transporta.CNPJCPF<>'') then begin
//            Avisoerro('Nota '+inttostr(ListaNotas.NotasFiscais.Items[x].NFe.Ide.cNF)+' Ve�culo sem placa');
//            result:=false;
  // 11.10.11 - Cenitech pegou - n�o d� retorno na sefa e nem da erro de validacao
//          end else if ( length(trim(ListaNotas.NotasFiscais.Items[x].NFe.Transp.veicTransp.placa ))<>7 ) and (ListaNotas.NotasFiscais.Items[x].NFe.Transp.Transporta.CNPJCPF<>'') then begin
//            Avisoerro('Nota '+inttostr(ListaNotas.NotasFiscais.Items[x].NFe.Ide.cNF)+' Ve�culo com placa diferente de 7 caracteres');
//            result:=false;
          end else if (trim(ListaNotas.NotasFiscais.Items[x].NFe.Transp.veicTransp.UF )='')
                  and (ListaNotas.NotasFiscais.Items[x].NFe.Transp.Transporta.CNPJCPF<>'')
                  and (ListaNotas.NotasFiscais.Items[x].NFe.ide.idDest<>doInterestadual)
                  then begin
 //           Aviso('Nota '+inttostr(ListaNotas.NotasFiscais.Items[x].NFe.Ide.cNF)+' Placa sem ////UF');
            result:=true;
  // 15.04.11
//          end else if length(trim(ListaNotas.NotasFiscais.Items[x].NFe.Dest.EnderDest.fone )) < 5 then begin
//            Avisoerro('Nota '+inttostr(ListaNotas.NotasFiscais.Items[x].NFe.Ide.cNF)+' Destinat�rio sem telefone completo');
//            result:=false;
// 22.08.18 - retirado pra ver se autoriza sem fone
          end;
        end;

          ListaProdutos:='';
          for y:=0 to ListaNotas.NotasFiscais.Items[x].NFe.Det.Count-1 do begin
            if (ListaNotas.NotasFiscais.Items[x].NFe.Det.Items[y].Prod.NCM='') and (ListaNotas.NotasFiscais.Items[x].NFe.Ide.finNFe<>fnComplementar)  then begin
  //            Avisoerro('Nota '+inttostr(ListaNotas.NotasFiscais.Items[x].NFe.Ide.cNF)+
  //            ' Produto '+ListaNotas.NotasFiscais.Items[x].NFe.Det.Items[y].Prod.cProd+' sem NCM' );
              result:=false;
              ListaProdutos:=Listaprodutos+ListaNotas.NotasFiscais.Items[x].NFe.Det.Items[y].Prod.cProd+' | ';
            end;
          end;
// 04.09.13
        if (not result) and (trim(ListaProdutos)<>'') then
            Avisoerro('Nota '+inttostr(ListaNotas.NotasFiscais.Items[x].NFe.Ide.cNF)+
            ' Produtos '+Listaprodutos+' sem NCM no cadastro de Produtos' );

      end;

    end;

//{
// 23.09.10 - xml 2.0 - deixado fixo em 05.05.11
//  TpcnCRT = (crtSimplesNacional, crtSimplesExcessoReceita, crtRegimeNormal);
//    {$IFDEF LIBXML2}
    function GetCRT(Simples:string):TPcnCRT;
    //////////////////////////////////////////
    begin
      if (Simples='S') or (Simples='1') then //- Optante do simples
        result:=crtSimplesNacional
      else if (Simples='N') or (Simples='E') or (Simples='3') then
        result:=crtRegimeNormal
      else if (Simples='2')  then
        result:=crtSimplesExcessoReceita;

//N - N�o optante do simples
//E - Epp ( Empresa de pequeno porte )
//2 - Optante do simples mas ultrapassou faixa
//3 - N�o � optante do simples

    end;
//    {$ENDIF}
///////////////////////////////
//}


//{
// 23.09.10 - xml 2.0 - fixo em 05.05.11
//  TpcnCSOSNIcms = (csosnVazio,csosn101, csosn102, csosn103, csosn201, csosn202,
//                   csosn203, csosn300, csosn400, csosn500,csosn900 );
//    {$IFDEF LIBXML2}
    function GetCSTSimples(xcst:string):TpcnCSOSNIcms;
    //////////////////////////////////////////
    var Q:TSqlquery;
    begin
        campo:=Sistema.GetDicionario('sittrib','sitt_cstme');
        result:=csosnVazio;
        if campo.tipo<>'' then begin
//        buscar no sitrib cfe o cst q veio aqui comoo parametro mas
//          Q:=sqltoquery('select * from sittrib where sitt_cst='+Stringtosql(xcst)+
//             ' and ( (sitt_es=''S'') or (sitt_es is null) )' );
//          if not Q.eof then begin
//      pegando somente cst ref. Saidas ou null no campo novo sitt_es no sittrib
////////////////////
{
            if Q.fieldbyname('sitt_cstme').asstring<>'' then begin
              if Q.fieldbyname('sitt_cstme').asstring='101' then
                result:=csosn101
              else if Q.fieldbyname('sitt_cstme').asstring='102' then
                result:=csosn102
              else if Q.fieldbyname('sitt_cstme').asstring='103' then
                result:=csosn103
              else if Q.fieldbyname('sitt_cstme').asstring='201' then
                result:=csosn201
              else if Q.fieldbyname('sitt_cstme').asstring='202' then
                result:=csosn202
              else if Q.fieldbyname('sitt_cstme').asstring='202' then
                result:=csosn202
              else if Q.fieldbyname('sitt_cstme').asstring='203' then
                result:=csosn203
              else if Q.fieldbyname('sitt_cstme').asstring='300' then
                result:=csosn300
              else if Q.fieldbyname('sitt_cstme').asstring='400' then
                result:=csosn400
              else if Q.fieldbyname('sitt_cstme').asstring='500' then
                result:=csosn500
              else if Q.fieldbyname('sitt_cstme').asstring='900' then
                result:=csosn900;
            end;
            }
////////////////////
            if xcst<>'' then begin
              if xcst='101' then
                result:=csosn101
              else if xcst='102' then
                result:=csosn102
              else if xcst='103' then
                result:=csosn103
              else if xcst='201' then
                result:=csosn201
              else if xcst='202' then
                result:=csosn202
              else if xcst='202' then
                result:=csosn202
              else if xcst='203' then
                result:=csosn203
              else if xcst='300' then
                result:=csosn300
              else if xcst='400' then
                result:=csosn400
              else if xcst='500' then
                result:=csosn500
              else if xcst='900' then
                result:=csosn900;
            end;

//          end;
//          Q.Close;
        end;
    end;
//    {$ENDIF}
//}

// 08.04.16
    function GetProduto(produto,xcod,s:string;nitem:integer):string;
    //////////////////////////////////////////////////////////
    var y:string;
    begin
//      result:=copy(s, ansipos(produto,s),400 );
//      if ansipos(produto,s)=0 then  result:=copy(s,ansipos('<cProd>'+xcod+'</cProd>',s),400);
//      result:=copy(s,pos('<cProd>'+xcod+'</cProd>',s),600);
// 27.04.16 - Laminadora sao caetano - usa o mesmo codigo com medidas(dimensoes) diferentes da chapa
//      result:=copy(s,pos('<xProd>'+(produto)+'</xProd>',s),600);
//      result:=copy(s,ansipos('<xProd>'+(produto)+'</xProd>',s),600);
//      y:='<cProd>'+xcod+'</cProd>';
//      result:=copy(s,pos(y,s),600);
//      result:=copy(s,pos(y,s),600);
//      y:=produto;
// <det nItem="2">
      result:=copy(s,pos('<det nItem='+'"'+inttostr(nitem)+'"',s),600);
//      y:=GetTag('xProd',result);
//      result:=copy(result,pos(y,result),600);
//      result:=copy(result, pos('ICMS',result),250);
// 24.05.16
      result:=copy(result,1, pos('/ICMS',result) );
    end;


// 15.04.16
    function GetProdutoIPI(produto,xcod,s:widestring):string;
    /////////////////////////////////////
    begin
//      result:=copy(s, ansipos(produto,s),400 );
//      if ansipos(produto,s)=0 then  result:=copy(s,ansipos('<cProd>'+xcod+'</cProd>',s),400);
      result:=copy(s,ansipos('<xProd>'+trim(produto)+'</xProd>',s),1000);

//      Aviso(  result );

      result:=copy(result, pos('IPI',result),150);

//      Aviso(  result );

    end;

    // 08.09.15
    procedure ChecaBaseIcms(  NF:TNFe );
    /////////////////////////////////
    var x:integer;
        xbaseicms,xvalor:currency;
    begin
       xbaseicms:=0;
//       with ACbrnfe1.NotasFiscais.Items[i] do begin
       with NF do begin
         for x:=0 to Det.count-1  do begin
//            xbaseicms:=xbaseicms+TextToValor(FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vBC,f_cr));
//            xbaseicms:=xbaseicms+TextToValor( FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vBC,f_cr3));
//            xbaseicms:=xbaseicms+TextToValor( FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vBC,f_cr4));
//            xbaseicms:=xbaseicms+( roundvalor(Det.Items[x].Imposto.ICMS.vBC));
// 05.04.16
//            xbaseicms:=xbaseicms+TextToValor(FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vBC,f_cr4));
// 08.04.16
//            xvalor:=TextToValor( GetTAg( 'vbc',GetProduto(Det.Items[x].Prod.xProd,Det.Items[x].Prod.cProd,AcbrNfe1.NotasFiscais.Items[i].XML,x+1) ) );
// 16.11.18 - seip - 30.11.18 - retirado devido a voltar a dar dif. na novi em venda normal
// 05.12.18 - dai retornou 0 no vbc do item provavel devido a ter ST .....
//            xvalor:=( roundvalor(Det.Items[x].Imposto.ICMS.vBC));
// 05.01.19 - venda normal d� calculado pela receita 0,01 centavo a mais...
            xvalor:=TextToValor( GetTAg( 'vbc',GetProduto(Det.Items[x].Prod.xProd,Det.Items[x].Prod.cProd,AcbrNfe1.NotasFiscais.Items[i].XML,x+1) ) );

            xbaseicms:=xbaseicms+xvalor;
// 19.01.16
//            xbaseicms:=xbaseicms+Det.Items[x].Imposto.ICMS.vBC;
//           Aviso('Base Icms Item '+FGeral.Formatavalor(TextToValor(FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vBC,f_cr)),f_cr4));
         end;
       end;
       if (Abs(xbaseicms-NF.Total.ICMSTot.vBC)<=0.03) and (NF.Ide.finNFe<>fncomplementar) and (NF.Total.ICMSTot.vBC>0)
          and  ( xbaseicms>0 )  // 22.02.19
          then begin
          NF.Total.ICMSTot.vBC:=xbaseicms;
//         Aviso('Base Icms Total '+FGeral.Formatavalor(Acbrnfe1.NotasFiscais.Items[0].NFe.Total.ICMSTot.vBC,f_cr4)+
//               ' Base Icms Itens '+FGeral.Formatavalor(xbaseicms,f_cr4) );
       end else if (ABs(NF.Total.ICMSTot.vBC-xbaseicms)<=0.03) and (NF.Ide.finNFe<>fncomplementar) and (NF.Total.ICMSTot.vBC>0) then begin
          NF.Total.ICMSTot.vBC:=xbaseicms ;
//         Aviso('Base Icms Total '+FGeral.Formatavalor(Acbrnfe1.NotasFiscais.Items[0].NFe.Total.ICMSTot.vBC,f_cr4)+
//               ' Base Icms Itens '+FGeral.Formatavalor(xbaseicms,f_cr4) );
       end;

    end;


   // 12.12.15
    procedure ChecaBaseIcmsST(  NF:TNFe );
    //////////////////////// ////////////
    var x:integer;
        xbaseicms:currency;
    begin
       xbaseicms:=0;
       with NF do begin
         for x:=0 to Det.count-1  do begin
            xbaseicms:=xbaseicms+TextToValor(FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vBCST,f_cr));
         end;
       end;
//       if (xbaseicms<>NF.Total.ICMSTot/.vBCST) and (NF.Ide.finNFe=fndevolucao) then
// 30.08.16 - markito
       if ( abs(xbaseicms-NF.Total.ICMSTot.vBCST)<=0.05 ) and (NF.Total.ICMSTot.vBCST>0) then
          NF.Total.ICMSTot.vBCST:=xbaseicms;
    end;


    // 08.09.15
    procedure ChecaValorIcmsST(  NF:TNFe );
    ///////////////////////////////////////////
    var x:integer;
        xicmsst,xbasest,xvalor:currency;
    begin
       xicmsst:=0;xbasest:=0;
       with NF do begin
         for x:=0 to Det.count-1  do begin
//// 28.07.16
//            if Det.Items[x].Prod.IndTot<>itSomaTotalNFe then begin
//              xvalor:=TextToValor( GetTAg( 'vICMSST',GetProduto(Det.Items[x].Prod.xProd,Det.Items[x].Prod.cProd,AcbrNfe1.NotasFiscais.Items[i].XML,x+1) ) );
//              xvalor:=TextToValor(FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vICMSST,f_cr));
// 02.02.17 - Zilmar
//              xvalor:=TextToValor(FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vICMSST,f_cr3));
// 03.07.17 - Zilmar - dava 25,746 e 25,746 mas com duas casas fica 25,74 e 25,75...
              xvalor:=TextToValor(FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vICMSST,f_cr));
              xicmsst:=xicmsst+xvalor;
              xbasest:=xbasest+TextToValor(FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vBCST,f_cr));
//            end;
//            Aviso('Base Icms Item '+FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vBC,f_cr));
         end;
       end;                                           // 28.07.16
       if (Abs(xicmsst-NF.Total.ICMSTot.vST)<=0.03) and (xicmsst>0)  then begin
          NF.Total.ICMSTot.vST:=xicmsst;
// 21.09.15
          NF.Total.ICMSTot.vNF:=NF.Total.ICMSTot.vProd+NF.Total.ICMSTot.vST+NF.Total.ICMSTot.vFrete+NF.Total.ICMSTot.vIPI-
                                Nf.Total.Icmstot.vDesc;
       end;                                     // 278.07.16
       if (xbasest<>NF.Total.ICMSTot.vBCST) and (xbasest>0) then
          NF.Total.ICMSTot.vBCST:=xbasest;
//         Aviso('Base Icms Total '+FGeral.Formatavalor(Acbrnfe1.NotasFiscais.Items[0].NFe.Total.ICMSTot.vBC,f_cr4)+
//               ' Base Icms Itens '+FGeral.Formatavalor(xbaseicms,f_cr4) );
    end;



    // 23.11.20
    procedure ChecaVIcmsDIF(  NF:TNFe );
    ///////////////////////////////////////////
    var x:integer;
        xicmsdif,
        xvicms,
        xvicmsop,
        valor       :currency;
        xoperacao   :string;

    begin
       xicmsdif:=0;
       xvicms  :=0;
       xvicmsop:=0;

       with NF do begin

         for x:=0 to Det.count-1  do begin

            if Det.Items[x].Prod.IndTot<>itNaoSomaTotalNFe then begin

              xicmsdif  := xicmsdif+TextToValor(FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vICMSDif,f_cr));
              xvicms    := xvicms+TextToValor(FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vICMS,f_cr));
              xvicmsop  := xvicmsop+TextToValor(FGeral.Formatavalor(Det.Items[x].Imposto.ICMS.vICMSop,f_cr));
              valor     := xvicmsop - xvicms;
              if xvicmsop>0 then

                 Det.Items[x].Imposto.ICMS.vICMS := valor;

            end;

         end;

       end;


    end;




    procedure ChecaValorvProd(   NF:TNFe );
    ///////////////////////////////////////
    var x:integer;
        xbaseicms:currency;
    begin
       xbaseicms:=0;
       with NF do begin
         for x:=0 to Det.count-1  do begin
//            xbaseicms:=xbaseicms+TextToValor(FGeral.Formatavalor(Det.Items[x].Prod.vProd,f_cr));
// 28.07.16
            if Det.Items[x].Prod.IndTot<>itNaoSomaTotalNFe then
// 24.03.16
//              xbaseicms:=xbaseicms+TextToValor(FGeral.Formatavalor(Det.Items[x].Prod.vProd,f_cr4));
// 31.08.18 - NP - novicarnes
             xbaseicms:=xbaseicms+TextToValor(FGeral.Formatavalor(Det.Items[x].Prod.vProd,f_cr));
         end;
       end;

//       if ( abs(xbaseicms-NF.Total.ICMSTot.vProd)<=0.07 ) and (NF.Total.ICMSTot.vProd>0) then
// 31.03.20 - notas de venda da novicarnes de ra��o com numeros 'quebrado' devido a vender
//            em kilos
       if ( abs(xbaseicms-NF.Total.ICMSTot.vProd)<=0.20 ) and (NF.Total.ICMSTot.vProd>0)
// 29.03.2021
          and ( abs(xbaseicms-NF.Total.ICMSTot.vProd)<> 0 )
          then
          NF.Total.ICMSTot.vProd:=xbaseicms;
// 17.01.19 - Importacao Seip brasil
       if ( abs(xbaseicms-NF.Total.ICMSTot.vProd)<=0.30 ) and (NF.Total.ICMSTot.vProd>0)
          and  (  NF.Ide.idDest=doExterior  )
          and ( abs(xbaseicms-NF.Total.ICMSTot.vProd)<> 0 )
          then
          NF.Total.ICMSTot.vProd:=xbaseicms;

// 17.08.16 - coorlaf laranjeiras 54.50 * 1,63   da 88,83 ou 88.84 ??
// 02.09.16 - vivan 0 pre�o com 3 casas devido desconto na tabela dai da 1096.343 no totprod e 1096,34 no vnf...
// 21.03.18 - Novi - nf produtor com pre�o unitario com dizima...
//       if ( abs(NF.Total.ICMSTot.vProd - NF.Total.ICMSTot.vNF)<=0.04 ) and ( abs(NF.Total.ICMSTot.vProd - NF.Total.ICMSTot.vNF)>=0.01 )  then
//       if ( abs(NF.Total.ICMSTot.vProd - NF.Total.ICMSTot.vNF)<=0.07 ) and ( abs(NF.Total.ICMSTot.vProd - NF.Total.ICMSTot.vNF)>=0.01 )  then
// 17.03.2021 - guiber - desconto de 0,03 centavos
       if ( abs(NF.Total.ICMSTot.vProd - NF.Total.ICMSTot.vNF)<=0.07 )
          and ( abs(NF.Total.ICMSTot.vProd - NF.Total.ICMSTot.vNF)>=0.01 )
          and ( NF.Total.ICMSTot.vDesc = 0 )
         then
         NF.Total.ICMSTot.vNF:=NF.Total.ICMSTot.vProd;

/////////////////////      aviso(' Total Item : '+FGeral.formatavalor(xbaseicms,f_cr4) );

    end;

// 30.08.18  - nfc-e benato
    procedure ChecaValorvPag(   NF:TNFe );
    ///////////////////////////////////////
    var x:integer;
    begin

//       if NF.Ide.modelo=65 then begin

         if ( NF.pag.Items[0].vPag <> NF.Total.ICMSTot.vNF) and ( NF.pag.Items[0].tPag<>fpSemPagamento ) then
             NF.pag.Items[0].vPag:=NF.Total.ICMSTot.vNF;

//       end;

    end;



    procedure ChecaValorvFrete(   NF:TNFe );
    ///////////////////////////////////////
    var x:integer;
        xbaseicms:currency;
    begin
       xbaseicms:=0;
       with NF do begin
         for x:=0 to Det.count-1  do begin
//            xbaseicms:=xbaseicms+TextToValor(FGeral.Formatavalor(Det.Items[x].Prod.vFrete,f_cr));
            xbaseicms:=xbaseicms+(FGeral.arredonda(Det.Items[x].Prod.vFrete,4));
         end;
       end;
//       if xbaseicms<>NF.Total.ICMSTot.vFrete then
//          NF.Total.ICMSTot.vFrete:=xbaseicms;
//      aviso(' Total Item : '+FGeral.formatavalor(xbaseicms,f_cr4) );
    end;

    // 14.09.15
    procedure ChecaValorvIcms(   NF:TNFe );
    ///////////////////////////////////////
    var x,posicao:integer;
        xbaseicms,xvlricms:currency;
        tagvicms,xml:string;
    begin
       xbaseicms:=0;xvlricms:=0;
       with NF do begin
          xml:=copy( AcbrNfe1.NotasFiscais.Items[0].XML,1,Ansipos('total',AcbrNfe1.NotasFiscais.Items[0].XML));
//          tagvicms:=GetTag('vICMS',xml);
//          posicao:=Ansipos('</vICMS>',xml);
          while true do begin

//         for x:=0 to Det.count-1  do begin
//            xbaseicms:=xbaseicms+TextToValor(FGeral.Formatavalor(Det.Items[x].Prod.vFrete,f_cr));
//            xbaseicms:=xbaseicms+(FGeral.arredonda(Det.Items[x].Imposto.ICMS.vICMS,4));
//            xbaseicms:=xbaseicms+(FGeral.arredonda(Det.Items[x].Imposto.ICMS.vICMS,3));
//            xbaseicms:=xbaseicms+(FGeral.arredonda(Det.Items[x].Imposto.ICMS.vICMS,2));
// 08.12.15 - dif. 0,01 - novicarnes
//            xbaseicms:=xbaseicms+(Det.Items[x].Imposto.ICMS.vICMS);
//            xbaseicms:=(Det.Items[x].Prod.vProd*(Det.Items[x].Imposto.ICMS.pRedBC/100));
//            xbaseicms:=Det.Items[x].Imposto.ICMS.vBC;
//            xbaseicms:=Det.Items[x].Imposto.ICMS.vBC,2 );
//            xvlricms:=xvlricms + (xbaseicms*(Det.Items[x].Imposto.ICMS.pICMS/100));
//            xvlricms:=xvlricms+FGEral.Arredonda( Det.Items[x].Imposto.ICMS.vICMS ,2 );
            tagvicms:=GetTag('vICMS',xml);
            xvlricms:=xvlricms + Texttovalor( tagvicms );
            posicao:=Ansipos('</vICMS>',xml);
            if posicao=0 then break;
            xml:=copy(XML,posicao+10,length(xml));
          end;
       end;
//       if (xbaseicms<>NF.Total.ICMSTot.vICMS) and (NF.Total.ICMSTot.vICMS>0) then
// 14.10.15
//       if ( abs(xvlricms-NF.Total.ICMSTot.vICMS)<=0.01) and (NF.Total.ICMSTot.vICMS>0) and (xVlricms<NF.Total.ICMSTot.vICMS) then
//       if ( abs(xvlricms-NF.Total.ICMSTot.vICMS)<=0.03) and (NF.Total.ICMSTot.vICMS>0) then
// 04.07.2022
       if ( abs(xvlricms-NF.Total.ICMSTot.vICMS)<=0.05) and (NF.Total.ICMSTot.vICMS>0) then
          NF.Total.ICMSTot.vIcms:=xvlricms;

//      aviso(' Total por Item : '+FGeral.formatavalor(xvlricms,f_cr4) );

    end;


// 08.07.16
///////////////////
    procedure ChecaVicmsDestUF(   NF:TNFe );
    ///////////////////////////////////////
    var x,posicao:integer;
        xbaseicms,xvlricms:currency;
        tagvicms,xml:string;
    begin
       xbaseicms:=0;xvlricms:=0;
       with NF do begin
          xml:=copy( AcbrNfe1.NotasFiscais.Items[0].XML,1,Ansipos('total',AcbrNfe1.NotasFiscais.Items[0].XML));
          while true do begin
            tagvicms:=GetTag('vICMSUFDest',xml);
            xvlricms:=xvlricms + Texttovalor( tagvicms );
            posicao:=Ansipos('</vICMSUFDest>',xml);
            if posicao=0 then break;
            xml:=copy(XML,posicao+10,length(xml));
          end;
       end;
       if ( abs(xvlricms-NF.Total.ICMSTot.vICMSUFDest)<=0.04) and (NF.Total.ICMSTot.vICMSUFDest>0) then
          NF.Total.ICMSTot.vICMSUFDest:=xvlricms;

//      aviso(' Total por Item : '+FGeral.formatavalor(xvlricms,f_cr4) );
    end;

// 08.07.16
    procedure ChecavicmsSUFRem(   NF:TNFe );
    ///////////////////////////////////////
    var x,posicao:integer;
        xbaseicms,xvlricms:currency;
        tagvicms,xml:string;
    begin
       xbaseicms:=0;xvlricms:=0;
       with NF do begin
          xml:=copy( AcbrNfe1.NotasFiscais.Items[0].XML,1,Ansipos('total',AcbrNfe1.NotasFiscais.Items[0].XML));
          while true do begin
            tagvicms:=GetTag('vICMSUFRemet',xml);
            xvlricms:=xvlricms + Texttovalor( tagvicms );
            posicao:=Ansipos('</vICMSUFRemet>',xml);
            if posicao=0 then break;
            xml:=copy(XML,posicao+10,length(xml));
          end;
       end;
       if ( abs(xvlricms-NF.Total.ICMSTot.vICMSUFRemet)<=0.03) and (NF.Total.ICMSTot.vICMSUFRemet>0) then
          NF.Total.ICMSTot.vICMSUFRemet:=xvlricms;
//      aviso(' Total por Item : '+FGeral.formatavalor(xvlricms,f_cr4) );
    end;

// 08.02.17 - clessi
    procedure ChecavFCPUFDest(   NF:TNFe );
    ///////////////////////////////////////
    var x,posicao:integer;
        xbaseicms,xvlricms:currency;
        tagvicms,xml:string;
    begin
       xbaseicms:=0;xvlricms:=0;
       with NF do begin
          xml:=copy( AcbrNfe1.NotasFiscais.Items[0].XML,1,Ansipos('total',AcbrNfe1.NotasFiscais.Items[0].XML));
          while true do begin
            tagvicms:=GetTag('vFCPUFDest',xml);
            xvlricms:=xvlricms + Texttovalor( tagvicms );
            posicao:=Ansipos('</vFCPUFDest>',xml);
            if posicao=0 then break;
            xml:=copy(XML,posicao+10,length(xml));
          end;
       end;
       if ( xvlricms<>NF.Total.ICMSTot.vFCPUFDest ) and (NF.Total.ICMSTot.vFCPUFDest>0) then
          NF.Total.ICMSTot.vFCPUFDest:=xvlricms;
//      aviso(' Total por Item : '+FGeral.formatavalor(xvlricms,f_cr4) );
    end;


   // 10.12.15
       // 14.09.15
    procedure ChecaValorvIPI(   NF:TNFe );
    ///////////////////////////////////////
    var x,posicao:integer;
        xbaseicms,xvalor:currency;
        tagvicms,xml:string;
    begin
       xbaseicms:=0;xvalor:=0;
       with NF do begin
       {
          xml:=copy( AcbrNfe1.NotasFiscais.Items[0].XML,1,Ansipos('total',AcbrNfe1.NotasFiscais.Items[0].XML));
          while true do begin
            tagvicms:=GetTag('vIPI',xml);
            xvlricms:=xvlricms + Texttovalor( tagvicms );
            posicao:=Ansipos('</vIPI>',xml);
            if posicao=0 then break;
            xml:=copy(XML,posicao+10,length(xml));
          end;
          }
         for x:=0 to Det.count-1  do begin
            xvalor:=TextToValor( GetTAg( 'vIPI',GetProdutoIPI(Det.Items[x].Prod.xProd,Det.Items[x].Prod.cProd,AcbrNfe1.NotasFiscais.Items[i].XML) ) );
            xbaseicms:=xbaseicms+xvalor;
//            Aviso(' IPI Item '+Det.Items[x].Prod.xProd+' '+FGeral.Formatavalor(xvalor,f_cr4) );
         end;
       end;

//         Aviso('IPI Total '+FGeral.Formatavalor(Acbrnfe1.NotasFiscais.Items[0].NFe.Total.ICMSTot.vIPI,f_cr4)+
//                ' IPI Itens '+FGeral.Formatavalor(xbaseicms,f_cr4) );

       if ( abs(xbaseicms-NF.Total.ICMSTot.vIPI)<=0.03) and (NF.Total.ICMSTot.vIPI>0) then
          NF.Total.ICMSTot.vIPI:=xbaseicms;
// 17.01.19 - Seip
       if ( abs(xbaseicms-NF.Total.ICMSTot.vIPI)<=0.05 ) and (NF.Total.ICMSTot.vIPI>0) and
          (  NF.Ide.idDest=doExterior  )
          then
            NF.Total.ICMSTot.vIPI:=xbaseicms;
    end;

// 24.08.16 - nf devolucao devereda
    procedure ChecaValorvOUTRO(   NF:TNFe );
    ///////////////////////////////////////
    var x,posicao:integer;
        xbaseicms,xvalor:currency;
        tagvicms,xml:string;
    begin
       xbaseicms:=0;xvalor:=0;
       with NF do begin
       {
          xml:=copy( AcbrNfe1.NotasFiscais.Items[0].XML,1,Ansipos('total',AcbrNfe1.NotasFiscais.Items[0].XML));
          while true do begin
            tagvicms:=GetTag('vIPI',xml);
            xvlricms:=xvlricms + Texttovalor( tagvicms );
            posicao:=Ansipos('</vIPI>',xml);
            if posicao=0 then break;
            xml:=copy(XML,posicao+10,length(xml));
          end;
          }
         for x:=0 to Det.count-1  do begin
            xvalor:=TextToValor( GetTAg( 'vOUTRO',GetProduto(Det.Items[x].Prod.xProd,Det.Items[x].Prod.cProd,AcbrNfe1.NotasFiscais.Items[i].XML,x+1) ) );
            xbaseicms:=xbaseicms+xvalor;
         end;
       end;

       if ( abs(xbaseicms-NF.Total.ICMSTot.vOUTRO)<=0.03)
// 14.05.18 - nf complento de icms e st
          and ( abs(xbaseicms-NF.Total.ICMSTot.vOUTRO)>0 )
          and (NF.Total.ICMSTot.vOUTRO>0) then
          NF.Total.ICMSTot.vOUTRO:=xbaseicms;

    end;


// 19.11.20
    procedure Checavalorvdesc(   NF:TNFe );
    ///////////////////////////////////////
    var x,posicao:integer;
        xbaseicms,xvalor:currency;
        tagvicms,xml:string;

    begin

       xbaseicms:=0;xvalor:=0;
       with NF do begin

         for x:=0 to Det.count-1  do begin
            xvalor:=TextToValor( GetTAg( 'vDESC',GetProduto(Det.Items[x].Prod.xProd,Det.Items[x].Prod.cProd,AcbrNfe1.NotasFiscais.Items[i].XML,x+1) ) );
            xbaseicms:=xbaseicms+xvalor;
         end;

       end;

       if ( abs(xbaseicms-NF.Total.ICMSTot.vDESC)<=0.03)
          and ( abs(xbaseicms-NF.Total.ICMSTot.vDESC)>0 )
          and (NF.Total.ICMSTot.vDESC>0) then
          NF.Total.ICMSTot.vDESC:=xbaseicms;

    end;



    function GetBaseST:string;
    ////////////////////////////
    var i:integer;
    begin
       result:='0';               // 18.05.16 - caso nao usar xml nas compras
       if (TItensNFe.Tag<>98) and ( TItensNFe.NotasFiscais.Count>0 ) then begin
         for i:=0 to TItensNFe.NotasFiscais.Items[0].NFe.Det.Count-1 do begin
{
            if Q1.fieldbyname('move_esto_codigo').asstring='004518' then begin
              Aviso( inttostr(i)+'|'+ Valortosql( FGeral.arredonda( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.vUnCom,2) )
                    +'|'+ Valortosql( FGeral.arredonda(Q1.fieldbyname('move_venda').ascurrency,2) )
                    +'|'+ Valortosql( FGeral.arredonda( TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.qCom,2) )
                    +'|' + Valortosql( Q1.fieldbyname('move_qtde').ascurrency) );
            end;
}
            if ( Valortosql( FGeral.arredonda(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.vUnCom,2) ) = Valortosql( FGeral.arredonda(Q1.fieldbyname('move_venda').ascurrency,2)) )
               and ( Valortosql( FGeral.arredonda(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.qCom,2) ) = Valortosql( FGeral.arredonda(Q1.fieldbyname('move_qtde').ascurrency,2)) )
               and ( Valortosql( FGeral.arredonda(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.pICMS,2) ) = Valortosql( FGeral.arredonda(Q1.fieldbyname('move_aliicms').ascurrency,2) ) ) then begin
               result:=Valortosql(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.vBCST);
               break;
            end;
         end;
       end;
    end;

// 12.12.15
////////////
    function GetValorST:string;
    ////////////////////////////
    var i:integer;
    begin
     result:='0';               // 18.05.16 - caso nao usar xml nas compras
     if (TItensNFe.Tag<>98) and (TItensNfe.NotasFiscais.Count>0) then begin  // 22.12.15 - Simar
       if TItensNFe<>nil then begin
         for i:=0 to TItensNFe.NotasFiscais.Items[0].NFe.Det.Count-1 do begin
            if ( Valortosql( FGeral.arredonda(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.vUnCom,2) ) = Valortosql( FGeral.arredonda(Q1.fieldbyname('move_venda').ascurrency,2)) )
               and ( Valortosql( FGeral.arredonda(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Prod.qCom,2) ) = Valortosql( FGeral.arredonda(Q1.fieldbyname('move_qtde').ascurrency,2)) )
               and ( Valortosql( FGeral.arredonda(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.pICMS,2) ) = Valortosql( Q1.fieldbyname('move_aliicms').ascurrency ) ) then begin
               result:=Valortosql(TItensNFe.NotasFiscais.Items[0].NFe.Det[i].Imposto.ICMS.vIcmsST);
               break;
            end;
         end;
       end;
     end;
    end;

// 03.02.16
    function GetAqliFCP(xUF:string):currency;
    ////////////////////////////////////////
    begin
      result:=0;
      if xUF='MT' then result :=10
      else if xUF='RJ' then result :=1
// 27.09.19 ; 31.01.20 - Sc nao tem mais fcp
// 20.08.20 - SP nao tem mais fcp
      else if AnsiPos( xUF,'GO/SC/SP' ) >0  then result :=0
      else result:=2;
    end;

// 24.11.16
    function EContribuinte( xcodigo,xtipo:string ):string;
    ///////////////////////////////////////////////////////////
    begin
      result:='S';
      if (xtipo='C') then
        result:=QDesti.fieldbyname('clie_contribuinte').asstring;
    end;

    // 18.04.19
    function ConverteUnidadeProduto( xunid,xncm:string ):string;
    ///////////////////////////////////////////////////////
    begin

       result:=xunid;
// 12.06.19 - 'rolos' da seip
       if copy(Q1.FieldByName('moes_natf_codigo').asstring,1,1)='7' then begin

           if AnsiPos( xunid,'UN/UND/UN./ML') > 0 then
              result:='KG';
// 06.04.20
//              result:='UN';

           if AnsiPos( xncm ,'85013110/85269200/84831019' ) >0 then result := 'UN';



       end else begin

           if AnsiPos( xunid,'UN/UND/UN.') > 0 then
              result:='UNID'
           else if AnsiPos( xunid,'LT') > 0 then
              result:='LITRO';

       end;

    end;


/////////////////////////////////////////////////////////////////////////////////////////////
begin
/////////////////////////////////////////////////////////////////////////////////////////////

  if EdUnid_codigo.ResultFind=nil then begin
//    Avisoerro('Escolher a unidade');
//    exit;
// 22.08.18
      EdUnid_codigo.Text:=Global.CodigoUnidade;
  end;

  if not EdUnid_codigo.validfind then exit;
  if not EdUnid_codigo.valid then exit;
  if not EdPasta.valid then exit;
  if not EdFormaEmissao.valid then exit;
  SenhaCertificado:='#';  // 29.01.10
  if not GetSenhaCertificado then exit;
  nomearqtexto:='NFEXML';
  TItensNfe:=TACBrNFe.Create(Self);

  if trim(FGeral.GetConfig1AsString('Pastaexpnfexml'))<>'' then
    acbrnfe1.Configuracoes.Arquivos.PathNFe:=FGeral.GetConfig1AsString('Pastaexpnfexml');
// 26.06.10 - 1 ano falecimento Altair...
  acbrnfe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(EdUnid_codigo.text);

//  if trim(FGeral.GetConfig1AsString('NumSerieCert'))<>'' then
//    acbrnfe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetConfig1AsString('NumSerieCert');
//  if trim(FGeral.GetConfig1AsString('Pastaxmldpec'))<>'' then
//    acbrnfe1.Configuracoes.Arquivos.PathDPEC:=FGeral.GetConfig1AsString('Pastaxmldpec');
// 01.12.09 6 hs da matina...
  if EdAmbiente.text='1' then
      acbrnfe1.Configuracoes.WebServices.Ambiente:=taProducao
  else
    acbrnfe1.Configuracoes.WebServices.Ambiente:=taHomologacao;
// 16.12.09
  if trim(FGeral.GetConfig1AsString('Pastaretonfexml'))<>'' then begin
    acbrnfe1.Configuracoes.Arquivos.PathEvento:=FGeral.GetConfig1AsString('Pastaretonfexml');
// 15.03.10
    acbrnfe1.Configuracoes.Arquivos.PathSalvar:=FGeral.GetConfig1AsString('Pastaretonfexml');
  end;
  if Q=nil then exit;
  if trim(Q.SQL.Text)='' then exit;
  if trim( EdUNid_codigo.resultfind.fieldbyname('unid_cep').asstring )='' then begin
    Avisoerro('Cep no cadastro da unidade est� sem preencher');
    exit;
  end;

{
  if (op='P') and ( pos('Autorizada',Grid.cells[Grid.getcolumn('retorno'),Grid.row])>0 ) then begin
    Aviso('Nota j� autorizada');
    exit;
  end;
}

  IF OP='E' THEN BEGIN  // 01.03.12
{
    if (Global.Usuario.Codigo=900) and (global.Usuario.Nome='Andr�') then begin
      if Confirma('Checar certificado ?') then begin
        if (ACBrNFe1.Configuracoes.Certificados.DataVenc>Sistema.Hoje) and
           ( trunc(ACBrNFe1.Configuracoes.Certificados.DataVenc-Sistema.Hoje)<=30 )
          then begin
      //    Avisoerro('Certificado digital '+ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado+' vencido em '+Datetostr(ACBrNFe1.Configuracoes.Certificados.DataVenc));
      //    Avisoerro('Certificado digital numero de s�rie '+ACBrNFe1.Configuracoes.Certificados.NumeroSerie+' vencido em '+Datetostr(ACBrNFe1.Configuracoes.Certificados.DataVenc));
          Avisoerro('Certificado digital '+copy(ACBrNFe1.Configuracoes.Certificados.GetCertificado.SubjectName,1,40)+' VENCE em '+Datetostr(ACBrNFe1.Configuracoes.Certificados.DataVenc));
        end;
//        if ACBrNFe1.Configuracoes.Certificados.DataVenc<EdInicio.asdate then begin
// 10.02.14
        if ACBrNFe1.Configuracoes.Certificados.DataVenc<Sistema.hoje then begin
      //    Avisoerro('Certificado digital '+ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado+' vencido em '+Datetostr(ACBrNFe1.Configuracoes.Certificados.DataVenc));
      //    Avisoerro('Certificado digital numero de s�rie '+ACBrNFe1.Configuracoes.Certificados.NumeroSerie+' vencido em '+Datetostr(ACBrNFe1.Configuracoes.Certificados.DataVenc));
          Avisoerro('Certificado digital '+copy(ACBrNFe1.Configuracoes.Certificados.GetCertificado.SubjectName,1,40)+' VENCIDO em '+Datetostr(ACBrNFe1.Configuracoes.Certificados.DataVenc));
          exit;
        end;
      end;

    end else begin

  // 17.06.11 - Abra
  /////////////////////////
      if (ACBrNFe1.Configuracoes.Certificados.DataVenc>Sistema.Hoje) and
         ( trunc(ACBrNFe1.Configuracoes.Certificados.DataVenc-Sistema.Hoje)<=30 )
        then begin
    //    Avisoerro('Certificado digital '+ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado+' vencido em '+Datetostr(ACBrNFe1.Configuracoes.Certificados.DataVenc));
    //    Avisoerro('Certificado digital numero de s�rie '+ACBrNFe1.Configuracoes.Certificados.NumeroSerie+' vencido em '+Datetostr(ACBrNFe1.Configuracoes.Certificados.DataVenc));
        Avisoerro('Certificado digital '+copy(ACBrNFe1.Configuracoes.Certificados.GetCertificado.SubjectName,1,40)+' VENCE em '+Datetostr(ACBrNFe1.Configuracoes.Certificados.DataVenc));
      end;
//      if ACBrNFe1.Configuracoes.Certificados.DataVenc<EdInicio.asdate then begin
// 10.02.14
      if ACBrNFe1.Configuracoes.Certificados.DataVenc<Sistema.hoje then begin
    //    Avisoerro('Certificado digital '+ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado+' vencido em '+Datetostr(ACBrNFe1.Configuracoes.Certificados.DataVenc));
    //    Avisoerro('Certificado digital numero de s�rie '+ACBrNFe1.Configuracoes.Certificados.NumeroSerie+' vencido em '+Datetostr(ACBrNFe1.Configuracoes.Certificados.DataVenc));
        Avisoerro('Certificado digital '+copy(ACBrNFe1.Configuracoes.Certificados.GetCertificado.SubjectName,1,40)+' VENCIDO em '+Datetostr(ACBrNFe1.Configuracoes.Certificados.DataVenc));
        exit;
      end;
    end;
/////    }
// 08.08.18  - apenas para nao verificar quando tem q fazer testes e certif. � A3
     if not Global.Topicos[1028] then begin

// 11.05.16
       if ( ACBrNFe1.SSL.CertDataVenc > Sistema.hoje ) and  ( trunc(ACBrNFe1.SSL.CertDataVenc-Sistema.Hoje)<=30 )
          then begin
          Aviso('Certificado digital '+copy(ACBrNFe1.SSL.CertSubjectName,1,40)+' VENCE em '+Datetostr(ACBrNFe1.SSL.CertDataVenc));
       end;

       if ACBrNFe1.SSL.CertDataVenc<Sistema.hoje then begin
          Avisoerro('Certificado digital '+copy(ACBrNFe1.SSL.CertSubjectName,1,40)+' VENCIDO em '+Datetostr(ACBrNFe1.SSL.CertDataVenc));
          exit;
       end;

     end;

//   ( FormatDateBr(ACBrNFe1.SSL.CertDataVenc) );
// 08.11.17
     if ( trim( AcbrNfe1.Configuracoes.Geral.CSC ) = '' ) and ( Grid.cells[Grid.getcolumn('moes_especie'),Grid.row]='NFC' ) then begin
        Avisoerro('Falta configuarar o CSC nas configura��es gerais do sistema para autorizar NFC-e');
        exit;
     end;

  END;

//////////////////
{  - 26.02.16 - retirado confirmacao para 'um enter a menos'
  if OP<>'P' then begin
// 12.05.11
    if ((xnumeronota=0) and (xsituacaonotas='') ) then
      if not confirma('Confirma exporta��o do arquivo XML ?') then exit;
  end;
}

//  AssignFile(Arquivo, EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.SAC' );
  caracteresespeciais:='/-.;';
//  try
//    Rewrite(Arquivo);
//    Rewrite(ArqClientes);
//    Rewrite(ArqProdutos);
//    Rewrite(ArqTransp);
//  except
//    Avisoerro('Drive ou Pasta n�o encontrado');
//    Q.Close;
//    EdPasta.setfocus;
//    exit;
//  end;
//  versaolayout:='1.11';  // s� serve pra geracao em TXT pro programa da SEFA/SP
// 23.03.11
  versaolayout:='2.00';  // s� serve pra geracao em TXT pro programa da SEFA/SP
// 31.03.20
  ok := true;
// 23.02.2023 - para nao fazer no preview da nota
  if OP <> 'P' then
// 06.09.2022 - verifica o grid se tem somente NFE ou somente NFCe...
     if not VerificaNotas then exit;

  Sistema.beginprocess('Gerando arquivos XML - 1 ');
  Transacoes:='';nnotas:=0;
  Q.first;
  while not Q.eof do begin
    Transacoes:=Transacoes+Q.fieldbyname('moes_transacao').asstring+';';
    inc(nnotas);
    Q.Next;
  end;
  Q.first;

  Sistema.beginprocess('Gerando arquivos XML - 2 ');

  codmuniemitente:=FCidades.GetCodigoIBGE(EdUNid_codigo.resultfind.fieldbyname('unid_cida_codigo').asinteger);
  if trim(codmuniemitente)='' then begin
    Avisoerro('Cidade codigo '+EdUNid_codigo.resultfind.fieldbyname('unid_cida_codigo').asstring+' sem codigo do IBGE');
    Sistema.endprocess('');
    closefile(Arquivo);
    exit;
  end;
  codigopais:=1058;
  nomepais:='BRASIL';
  ListaProdutosCst:=TStringList.create;
//  NotasE:=Acbrnfe1.Create(self);

  if OP='E' then
    Numlote:=FGEral.GetContador('LOTENFE'+EdUnid_codigo.text,false);

  ACBrNFe1.NotasFiscais.Clear;

// 23.04.10 - emitente em outro estado que nao seja PR
  if trim(EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString)<>'' then
    ACBrNFe1.Configuracoes.WebServices.UF:=EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString
  else
    ACBrNFe1.Configuracoes.WebServices.UF:='PR';
//////////////////////
// 16.01.12
  TiposNumeracaoSaida:=Global.CodEntradaImobilizado+';'+Global.CodCompraConsignado+';'+
                       Global.CodDevolucaodeRemessa+';'+Global.CodCompraProdutor+';'+Global.CodNfeComplementoValorProdutor+';'+
                       FGeral.GetConfig1AsString('TIPOSENUMSAIDA');
// 01.02.12 - pastas por mes ano da emissao
  if not Q.eof then begin
    if trim(FGeral.GetConfig1AsString('Pastaexpnfexml'))<>'' then
      acbrnfe1.Configuracoes.Arquivos.PathNFe:=FGeral.GetConfig1AsString('Pastaexpnfexml')+'\'+
                                               strzero(Datetoano(Q.fieldbyname('moes_dataemissao').AsDateTime,true),4)+
                                               strzero(Datetomes(Q.fieldbyname('moes_dataemissao').AsDateTime),2)
    else
      acbrnfe1.Configuracoes.Arquivos.PathNFe:=acbrnfe1.Configuracoes.Arquivos.PathNFe+'\'+
                                               strzero(Datetoano(Q.fieldbyname('moes_dataemissao').AsDateTime,true),4)+
                                               strzero(Datetomes(Q.fieldbyname('moes_dataemissao').AsDateTime),2);
    if not DirectoryExists( acbrnfe1.Configuracoes.Arquivos.PathNFe ) then
      ForceDirectories( acbrnfe1.Configuracoes.Arquivos.PathNFe );
  end;
/////
// 10.07.15
  xHoraEnvio:=time();
  if OP='P' then begin

    FGeral.FechaQuery(Q);
    Q:=sqltoquery('select movesto.*,clientes.clie_razaosocial,clientes.clie_tipo,clientes.clie_endres,'+
                'clientes.clie_uf,clientes.clie_nome from movesto'+
                ' left join clientes on (clie_codigo=moes_tipo_codigo)'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                ' and moes_transacao = '+Stringtosql(Grid.cells[Grid.getcolumn('moes_transacao'),Grid.row])+
                ' order by moes_numerodoc' );
  end;

  while not Q.eof do begin

/////////////////////////////////////////////////////////////
//    ACBrNFe1.NotasFiscais.Add.NFe.Ide.Create(ACBrNFe1.NotasFiscais.Add.NFe);
//////////////////////////////////////////////////////////////////
    Sistema.beginprocess('Gerando arquivos XML - 3 ');

    with  ACBrNFe1.NotasFiscais.Add.NFe do
    begin

// 09.04.19 - Configurao respons�vel t�cnico // ainda nao disponivel na homologacao PR
//    if (EdAmbiente.Text='2') or (Q.fieldbyname('moes_dataemissao').asdatetime>=Texttodate('03062019') )
      if (EdAmbiente.Text='2') or (Sistema.Hoje>=Texttodate('03062019') )
         and ( AnsiPos( Global.UFUnidade, 'PR/SC/') > 0 ) then
       FGeral.ConfiguraRespTecnicoAcbrNfe( infRespTec );

// 09.07.15 - colocaro + time()devido a nfce
      if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin
        datam:=Q.fieldbyname('moes_datamvto').asdatetime + xHoraEnvio ;
        tipodoc:='0';
      end else begin
        datam:=Q.fieldbyname('moes_dataemissao').asdatetime + xHoraEnvio ;
  // 27.11.09
        campo:=Sistema.GetDicionario('movesto','moes_datasaida');
        if Campo.Tipo<>'' then begin
            if Q.fieldbyname('moes_datasaida').asdatetime>Q.fieldbyname('moes_dataemissao').asdatetime then
              datam:=Q.fieldbyname('moes_datasaida').asdatetime + + xHoraEnvio ;
        end else begin
    // 20.08.09
           if Q.fieldbyname('moes_datamvto').asdatetime>Q.fieldbyname('moes_dataemissao').asdatetime then
             datam:=Q.fieldbyname('moes_datamvto').asdatetime + + xHoraEnvio ;
        end;
        tipodoc:='1';
      end;

      QItens:=sqltoquery('select move_qtde,move_venda,move_tipomov,move_esto_codigo,move_tama_codigo,move_core_codigo from movestoque inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                     ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
// 05.07.10
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' left join cores on (core_codigo=move_core_codigo)'+
//
                     ' where move_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                     ' and move_tipomov='+stringtosql(Q.fieldbyname('moes_tipomov').asstring)+
                     ' and move_unid_codigo='+stringtosql(Q.fieldbyname('moes_unid_codigo').asstring)+
                     ' and '+FGeral.GetIN('move_status','N','C') );
      totalitens:=0;
      valordesc:=0;
      ListaItens01:=TStringlist.create;
      ListaItens02:=TStringlist.create;

      while not QItens.eof do begin

//        if pos(Qitens.fieldbyname('move_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodCompraProdutorMerenda)>0 then
//          totalitens:=totalitens+QItens.fieldbyname('move_qtde').ascurrency*QItens.fieldbyname('move_venda').ascurrency;
// 06.09.16 - venda com 6 casas decimais no unitario - racao novi
//          totalitens:=totalitens+QItens.fieldbyname('move_qtde').ascurrency*QItens.fieldbyname('move_venda').asfloat;

//          totalitens:=totalitens+FGEral.Arredonda(QItens.fieldbyname('move_qtde').ascurrency,2)*FGEral.Arredonda(QItens.fieldbyname('move_venda').ascurrency,4) // .14
//          totalitens:=totalitens+FGEral.Arredonda(QItens.fieldbyname('move_qtde').ascurrency,2)*FGEral.Arredonda(QItens.fieldbyname('move_venda').ascurrency,3) // .
//        else
//          totalitens:=totalitens+FGEral.Arredonda(QItens.fieldbyname('move_qtde').ascurrency*QItens.fieldbyname('move_venda').ascurrency,2);

//          totalitens:=totalitens+FGEral.Arredonda(QItens.fieldbyname('move_qtde').ascurrency,2)*FGEral.Arredonda(QItens.fieldbyname('move_venda').ascurrency,4);

// 09.09.15
// 0,31 totalitens:=totalitens+TextToValor(FGeral.Formatavalor(FGEral.Arredonda(QItens.fieldbyname('move_qtde').ascurrency*QItens.fieldbyname('move_venda').ascurrency,2),f_cr));
//        totalitens:=totalitens+TextToValor(FGeral.Formatavalor(FGEral.Arredonda(QItens.fieldbyname('move_qtde').ascurrency*QItens.fieldbyname('move_venda').ascurrency,2),f_cr));
// 28.07.16  - DEvereda
        if QItens.fieldbyname('move_qtde').ascurrency<0 then begin

// 09.12.2021 - retirado este valor desc...
          valordesc:=valordesc + (QItens.fieldbyname('move_qtde').ascurrency*QItens.fieldbyname('move_venda').ascurrency)*(-1);

// 18.03.20 - Devereda - para poder dar desconto
// 09.12.2021 - s� q ta somando negativo dai diminuindo n� jamanta...
//          totalitens := totalitens + (QItens.fieldbyname('move_qtde').ascurrency*QItens.fieldbyname('move_venda').asfloat);
// 19.03.20 - 09.12.2021 - retirado para fazer 'sem desconto'...
{
          if ListaItens01.IndexOf( QItens.fieldbyname('move_esto_codigo').asstring ) = -1  then  begin

            ListaItens01.Add( QItens.fieldbyname('move_esto_codigo').asstring );
            ListaItens02.Add( QItens.fieldbyname('move_qtde').asstring+';'+
                              QItens.fieldbyname('move_venda').asstring );

          end;
}

        end else
// aqui em 10.05.17
          totalitens:=totalitens+QItens.fieldbyname('move_qtde').ascurrency*QItens.fieldbyname('move_venda').asfloat;

        Qitens.next;
      end;
      FGeral.FechaQuery(QItens);

// Novicarnes - dados adicionais do fisco e do contribuinte
// 20.12.11 - colocado tipo DN - dev. de compra de produtor
      campo:=Sistema.GetDicionario('movesto','moes_vlrgta');
      if campo.tipo<>'' then
        moes_vlrgta:=Q.fieldbyname('moes_vlrgta').ascurrency
      else
        moes_vlrgta:=0;

      if (Q.fieldbyname('moes_perdesco').ascurrency>0)  then
//        vlrdesco:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100),2)
// 18.05.11 - 29.05.12 - senao fica desconto negativo
        vlrdesco:= totalitens - (Q.fieldbyname('moes_vlrtotal').AsCurrency-Q.fieldbyname('moes_valoripi').AsCurrency-Q.fieldbyname('moes_frete').AsCurrency-Q.fieldbyname('moes_outrasdesp').ascurrency)

// 17.11.15 - coorlaf - somente no primeiro item...
//      else if Q.fieldbyname('moes_funrural').ascurrency>0 then
//        vlrdesco:=Q.fieldbyname('moes_funrural').ascurrency+moes_vlrgta+Q.fieldbyname('moes_cotacapital').ascurrency
// 28.07.16 - devereda - 09.12.2021 -...revisado
      else if valordesc>0 then
        vlrdesco  := valordesc
      else
        vlrdesco:=0;
// 08.07.19 - vini rotta - nf com ST somado da desconto negativo OU zerado quando o total da nota
//            fica exatamente igual ao total da mercadoria devido ao desconto..
      if vlrdesco<=0  then
//         vlrdesco:=FGeral.Arredonda(Q.fieldbyname('moes_vlrtotal').AsCurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100),2);
         vlrdesco:=FGeral.Arredonda(Q.fieldbyname('moes_totprod').AsCurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100),2);

// 29.08.11 - Janina - Acrescimo financeiro na nota
      if Q.fieldbyname('moes_peracres').ascurrency>0 then
        Despacessorias:=Q.fieldbyname('moes_vlrtotal').AsCurrency-totalitens+vlrdesco
                        -Q.fieldbyname('moes_valoripi').AsCurrency
                        -Q.fieldbyname('moes_frete').AsCurrency
      else
        Despacessorias:=0;
// 11.11.2013 - Metalforte - Devolucao Tributada
      Despacessorias:=despacessorias+Q.fieldbyname('moes_outrasdesp').ascurrency;

      dadosadicionais:='';
// 27.09.17 - ficavam sem devido a mudan�as pra arma de fogo e romaneios vida nova
      dadosadicionais:=Q.fieldbyname('moes_mensagem').asstring;

      dadosarmadefogo:='';

      if pos(Q.fieldbyname('moes_tipomov').asstring,global.CodCompraProdutor+';'+Global.CodDevolucaoCompraProdutor+';'+
             Global.CodNfeComplementoValorProdutor)>0 then begin

        dadosadicionais:=dadosadicionais+' INSS : '+floattostr(Q.fieldbyname('moes_funrural').ascurrency);
        dadosadicionais:=dadosadicionais+' Cota Capital : '+floattostr(Q.fieldbyname('moes_cotacapital').ascurrency);
        dadosadicionais:=dadosadicionais+' NF Produtor : '+inttostr(Q.fieldbyname('moes_notapro').asinteger);
        if moes_vlrgta>0 then
          dadosadicionais:=dadosadicionais+' Valor GTA   : '+FLOATtostr(moes_vlrgta);
        if Q.fieldbyname('moes_notapro2').asinteger>0 then
          dadosadicionais:=dadosadicionais+' '+inttostr(Q.fieldbyname('moes_notapro2').asinteger) ;
// 27.07.16 - Coorlaf - Pitanga
        if Q.fieldbyname('moes_freteuni').ascurrency>0 then
          dadosadicionais:=dadosadicionais+' Taxa Administrativa : '+floattostr(Q.fieldbyname('moes_freteuni').ascurrency);
// 20.06.19 - vida Nova
        if ( Ansipos(Q.fieldbyname('moes_tipomov').asstring,global.Codcompraprodutor)>0 ) and  ( global.topicos[1462] ) then begin

           if Q.fieldbyname('moes_insumos').ascurrency>0 then
              dadosadicionais:=dadosadicionais+' Insumos Produ��o : '+floattostr(Q.fieldbyname('moes_insumos').ascurrency);

        end;

      end;
// 01.07.13 - Metalforte
      if (Global.topicos[1364]) and ( pos(copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1),'5;6;7')>0 )
         then dadosadicionais:=dadosadicionais+'Vendedor:'+Q.fieldbyname('moes_repr_codigo').asstring+
                        ' - '+FRepresentantes.GetDescricao(Q.fieldbyname('moes_repr_codigo').asinteger);
// 18.05.11 - Fama - Parte/total a vista
      QPend:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(Q.fieldbyname('moes_Transacao').AsString)+
                        ' and movf_status<>''C''');
      if (not QPend.eof) and ( Q.fieldbyname('moes_comv_codigo').AsInteger<>FGeral.GetConfig1AsInteger('ConfMovNFCe') )
         and ( Q.fieldbyname('moes_comv_codigo').AsInteger<>FGeral.GetConfig1AsInteger('ConfMovNFCeVC') )
// 27.03.18
         and ( Q.FieldByName('moes_vispra').asstring <> 'V' )

        then begin
{
        if (  Acbrnfe1.Configuracoes.Geral.VersaoDF = ve400 ) then begin

            with Pag.Add do
            begin
               tPag := fpDinheiro;
               vPag := QPend.fieldbyname('movf_valorger').AsCurrency;
            end;

        end else begin
}
            with cobr.Dup.Add do
            begin
                nDup:='001' ;
                dVenc:=QPend.fieldbyname('movf_datamvto').AsDatetime ;
                vDup:=QPend.fieldbyname('movf_valorger').AsCurrency ;
            end;
 //       end;

      end;

//      FGeral.FechaQuery(QPend);
// 16.09.2022 - retirado daqui
      vencimentoNP:=0;
      valorliquidoNP:=0;

// 06.07.15
      if Q.FieldByName('moes_vispra').asstring='V' then begin

          if  ( (Q.fieldbyname('moes_comv_codigo').AsInteger=FGeral.GetConfig1AsInteger('ConfMovNFCe') ) and
                ( FGeral.GetConfig1AsInteger('ConfMovNFCe')>0 ) )
// 31.08.15 - vivan
            OR
               ( (Q.fieldbyname('moes_comv_codigo').AsInteger=FGeral.GetConfig1AsInteger('ConfMovNFCeVC') ) and
                ( FGeral.GetConfig1AsInteger('ConfMovNFCeVC')>0 ) )
// 06.11.16 - versao 4 do xml
            OR
               (  Acbrnfe1.Configuracoes.Geral.VersaoDF = ve400 )


            then begin

              with pag.Add do //PAGAMENTOS apenas para NFC-e OU xml 4.0
              begin

// 06.08.18
                 if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodDevolucaoCompra+';'
                                  +Global.CodDevolucaoCompraProdutor+';'
// 07.08.18 - giacomoni
                                  +Global.CodDevolucaoIgualVenda+';'
// 24.09.18 - Simar
                                  +Global.CodDevolucaoCompraSemEstoque+';'
// 05.06.19 - Novicarnes - nf de credito de icms
                                  +Global.CodDevolucaoSemFinan+';'
// 17.03.20 - Seip - estorno de nfe autorizada mas fora do prazo
                                  +Global.CodEstornoNFeSai+';'
                                  +Global.CodDevolucaoTributada)>0 then
                   tPag := fpSemPagamento

                 else begin

                    tPag := fpDinheiro;
// 02.09.2022
                    if Global.Topicos[1520] then begin

                      QPend:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(Q.fieldbyname('moes_Transacao').AsString)+
                              ' and movf_status<>''C''');
                      if Ansipos('BOLETO',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('movf_port_codigo').AsString) ) ) >0 then
                         tPag := fpDuplicataMercantil

                      else if Ansipos('CREDIT',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('movf_port_codigo').AsString) ) ) >0 then
                         tPag := fpCartaoCredito

                      else if Ansipos('DEBIT',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('movf_port_codigo').AsString) ) ) >0 then
                         tPag := fpCartaoDebito

// 19.09.2022
                      else if Ansipos('PIX',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('movf_port_codigo').AsString) ) ) >0 then
                         tPag := fpPagamentoInstantaneo;

                      if Ansipos('CONVENIO',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('movf_port_codigo').AsString) ) ) >0 then
                          tPag := fpCreditoLoja;

                    end;

                    vPag := Q.fieldbyname('moes_vlrtotal').AsCurrency;
                    tpIntegra := tiPagNaoIntegrado;

                 end;
//                 pag.vTroco := 0;
              end;

          end;
// 15.09.2022
          FGeral.FechaQuery(QPend);

      end else begin

// 15.09.2022
         FGeral.FechaQuery(QPend);

    // 12.08.13 - ajustado para nao imprimir os vencimentos ref. comiss�o a pagar gerada na mesma transacao
          QPend:=sqltoquery('select pend_datavcto,pend_numerodcto,pend_valor,pend_parcela,pend_port_codigo from pendencias where pend_transacao='+stringtosql(Q.fieldbyname('moes_transacao').Asstring)+
                            ' and pend_tipomov='+Stringtosql(Q.fieldbyname('moes_tipomov').Asstring)+
                            ' and pend_status<>''C'' order by pend_datavcto');
// 30.07.18
          if QPend.eof then

             pag.Add.tPag := fpSemPagamento
// 04.08.18
          else begin

// retirado em 13.08.18  para nao gerar um registro a mais no not pend.eof mais abaixo
// 16.08.18 - recolocado
            if  ( AnsiPos( Q.fieldbyname('moes_tipomov').Asstring,Global.CodCompraProdutor+';'+Global.CodDevolucaoCompraProdutor ) = 0 )
                and
                ( AnsiPos( Q.fieldbyname('moes_tipomov').Asstring,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoIgualVenda) = 0 )
// 31.08.18  - Iran - nfce parcelada
             and  (  Q.fieldbyname('moes_comv_codigo').AsInteger<>FGeral.GetConfig1AsInteger('ConfMovNFCe') )
             then begin
              with pag.Add do
              begin
                 tPag := fpDinheiro;
                 if Ansipos('BOLETO',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('pend_port_codigo').AsString) ) ) >0 then
                   tPag := fpDuplicataMercantil
// 04.09.20
//                 else if Ansipos('CART',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('pend_port_codigo').AsString) ) ) >0 then
//                   tPag := fpCartaoCredito;
// 12.09.2022
                 else if Ansipos('CREDIT',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('pend_port_codigo').AsString) ) ) >0 then
                         tPag := fpCartaoCredito

                 else if Ansipos('DEBIT',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('pend_port_codigo').AsString) ) ) >0 then
                         tPag := fpCartaoDebito

// 19.09.2022
                 else if Ansipos('PIX',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('pend_port_codigo').AsString) ) ) >0 then
                         tPag := fpPagamentoInstantaneo;

                 if Ansipos('CONVENIO',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('pend_port_codigo').AsString) ) ) >0 then
                    tPag := fpCreditoLoja;

                 vPag := Q.fieldbyname('moes_vlrtotal').AsCurrency;
// 22.02.2021 - vida Nova
                 if Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoValorProdutor) > 0 then

                    vPag := QPend.fieldbyname('pend_valor').AsCurrency;

              end;

            end else if ( Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodDevolucaoCompra+';'
                                  +Global.CodDevolucaoCompraProdutor+';'
                                  +Global.CodDevolucaoIgualVenda+';'
// 24.09.18 - Simar
                                  +Global.CodDevolucaoCompraSemEstoque+';'
                                  +Global.CodDevolucaoTributada)>0 )

                   then

                    pag.Add.tPag := fpSemPagamento;



// 27.05.2022 - Benato - nfce a prazo nao gera o tag 'cobr'
            if (  Q.fieldbyname('moes_comv_codigo').AsInteger <> FGeral.GetConfig1AsInteger('ConfMovNFCe') )
            then begin
// 06.08.18
              with cobr.Fat do
              begin

                 nFat:=QPend.fieldbyname('pend_numerodcto').AsString ;
// 22.02.2021 - vida Nova
                 if Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoValorProdutor) > 0 then begin

                   vOrig:=QPend.fieldbyname('pend_valor').AsCurrency;
                   vLiq :=QPend.fieldbyname('pend_valor').AsCurrency;

                 end else begin

                   vOrig:=Q.fieldbyname('moes_vlrtotal').AsCurrency;
                   vLiq :=Q.fieldbyname('moes_vlrtotal').AsCurrency;

                 end;
              end;

            end; /// <> nfc-e

          end;

    // 25.03.10
          while not QPend.eof do begin

    // 20.05.15
            if  ( (Q.fieldbyname('moes_comv_codigo').AsInteger=FGeral.GetConfig1AsInteger('ConfMovNFCe') ) and
                ( FGeral.GetConfig1AsInteger('ConfMovNFCe')>0 ) )
// 31.08.15 - vivan
            OR
               ( (Q.fieldbyname('moes_comv_codigo').AsInteger=FGeral.GetConfig1AsInteger('ConfMovNFCeVC') ) and
                ( FGeral.GetConfig1AsInteger('ConfMovNFCeVC')>0 ) )

            then begin

              with pag.Add do //PAGAMENTOS apenas para NFC-e - xml 4.0 dai preenche
              begin

                 tPag := fpDinheiro;
                 if Ansipos('BOLETO',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('pend_port_codigo').AsString) ) ) >0 then
                   tPag := fpDuplicataMercantil
// 04.09.20
                 else if Ansipos('CART',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('pend_port_codigo').AsString) ) ) >0 then
                   tPag := fpCartaoCredito;

// 01.07.18 - para cliente 'assinar a notinha' e pagar no fim do mes
                 if Ansipos('CONVENIO',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('pend_port_codigo').AsString) ) ) >0 then
                    tPag := fpCreditoLoja;

// 06.11.17 - valor parcela
               vPag := QPend.fieldbyname('pend_valor').AsCurrency;
// 02.08.18 - senao nao autoriza no xml 4.0 devido ao funrural  - considerando q seja em uma parcela...
               if Q.fieldbyname('moes_tipomov').Asstring=Global.CodCompraProdutor then
                  vPag := Q.fieldbyname('moes_vlrtotal').AsCurrency;

// 31.08.19 -nfc-e em 30/60... - iran
//                 if not (  Acbrnfe1.Configuracoes.Geral.VersaoDF = ve400 ) then
                   break;  // para nao somar 'nparcelas' o valor da nota

              end;

            end else if AnsiPos( Q.fieldbyname('moes_tipomov').Asstring,Global.CodCompraProdutor+';'+Global.CodDevolucaoCompraProdutor )=0 then begin

              with cobr.Dup.Add do
              begin

                  nDup:=strzero(QPend.fieldbyname('pend_parcela').AsInteger,3) ;
                  dVenc:=QPend.fieldbyname('pend_datavcto').AsDatetime ;
                  if Q.fieldbyname('moes_tipomov').Asstring=Global.CodCompraProdutor then
                    vDup:=Q.fieldbyname('moes_vlrtotal').AsCurrency
                  else
                    vDup:=QPend.fieldbyname('pend_valor').AsCurrency ;

              end;

// 22.02.19 - Novicarnes..valores nao bate e ainda tem o gta
            end else if AnsiPos( Q.fieldbyname('moes_tipomov').Asstring,Global.CodDevolucaoCompraProdutor )=0 then begin
// 10.08.18
                vencimentoNP:=QPend.FieldByName('pend_datavcto').AsDateTime;
                valorliquidoNP:=QPend.FieldByName('pend_valor').AsCurrency;
                with pag.Add do
                begin
                   tPag := fpDinheiro;
                   if Ansipos('BOLETO',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('pend_port_codigo').AsString) ) ) >0 then
                     tPag := fpDuplicataMercantil;
                   if Ansipos('CONVENIO',uppercase( FPOrtadores.GetDescricao( QPend.FieldByName('pend_port_codigo').AsString) ) ) >0 then
                      tPag := fpCreditoLoja;
                    vPag := Q.fieldbyname('moes_vlrtotal').AsCurrency;
                end;


            end;
            QPend.Next;

          end;

//          FGeral.FechaQuery(QPend);

      end;  //vista/prazo
///////////////////
///  04.09.20 - recolocado somente para nfc-e
      if ( Uppercase( copy( Q.fieldbyname('moes_especie').asstring,1,3 ) ) = 'NFC' )
          and
         ( Q.FieldByName('moes_vispra').asstring <> 'V' )
          then begin

          QPend.First;
// 28.05.2022 - Benato - nome do cliente aqui pois na nfc-e s� sai o nome se informar cpf
          dadosadicionais:=dadosadicionais+' '+FGeral.GetNomeTipoCad(Q.fieldbyname('moes_tipo_codigo').AsInteger,Q.fieldbyname('moes_tipocad').AsString)+' ';
          if not Qpend.Eof then begin
            if trim(dadosadicionais)<>'' then
              dadosadicionais:=dadosadicionais+' - Vencimento(s)'
            else
              dadosadicionais:=dadosadicionais+'Vencimento(s)';
          end;

          while not QPend.eof do begin

            dadosadicionais:=dadosadicionais+' '+FGeral.FormataData(QPend.fieldbyname('pend_datavcto').AsDatetime)+
                             ' R$ '+FGeral.FormataValor(QPend.fieldbyname('pend_valor').AsCurrency,'##,##0.00') ;
            QPend.Next;

          end;

      end;

      if QPend <> nil then

         if QPend.SQL.Text <> '' then

            FGeral.FechaQuery(QPend);

///////////////////
// 01.07.10 - Clessi - notas de exportacao
      if copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1)='7' then begin

        dadosadicionais:=dadosadicionais+' Porto Embarque:'+(Q.fieldbyname('moes_embarque').asstring) ;
        dadosadicionais:=dadosadicionais+' Porto Destino:'+(Q.fieldbyname('moes_destino').asstring) ;
        dadosadicionais:=dadosadicionais+' Numero Container:'+(Q.fieldbyname('moes_container').asstring) ;

      end;
// 24.07.20 - Seip - notas de importacao
      if ( copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1)='3' )
         and
         ( trim(Q.fieldbyname('moes_numerodi').asstring)<>'' )
         then begin

        dadosadicionais:=dadosadicionais+' Numero DI :'+(Q.fieldbyname('moes_numerodi').asstring) ;

      end;

// 01.03.2013 - nome fantasia - Bavi
      if ( Global.Topicos[1361] ) and (Q.fieldbyname('moes_tipocad').asstring='C') then
        dadosadicionais:=dadosadicionais+' Nome Fantasia '+(Q.fieldbyname('clie_nome').asstring) ;
// 07.08.17  - Usuario e transacao da nota
      if ( Global.Topicos[1397] ) then
        dadosadicionais:=dadosadicionais+' Usu�rio '+inttostr(Global.Usuario.Codigo)+'-'+
                         FUsuarios.GetNome(Global.Usuario.Codigo)+' Transa��o '+Q.FieldByName('moes_transacao').AsString;
// 13.08.18 - aqui colocar o valor liquido a ser pago ao produtor
      if Q.FieldByName('moes_tipomov').AsString=Global.CodCompraProdutor then begin

        dadosadicionais:=dadosadicionais+' Valor a ser Pago : '+FGeral.FormataValor(valorliquidoNP,f_cr);
        dadosadicionais:=dadosadicionais+' Vencimento : '+FGeral.FormataData(vencimentoNP);

      end;

      if trim(dadosadicionais)<>'' then
        InfAdic.infCpl:=dadosadicionais;
// 06.07.10
//        InfAdic.infAdFisco:=dadosadicionais;
  // 17.08.09 - Capeg - 'romaneios do leonir'                // 15.09.17
      if (trim(Q.fieldbyname('moes_mensagem').asstring)<>'') and  ( Q.fieldbyname('moes_mensagem').asstring=Global.CodVendaaOrdem   ) then begin
        dadosadicionais:='';
        if trim(dadosadicionais)<>'' then
          dadosadicionais:=dadosadicionais+' - '+Q.fieldbyname('moes_mensagem').asstring
        else
          dadosadicionais:=dadosadicionais+Q.fieldbyname('moes_mensagem').asstring;
// 24.08.17
        if ( pos(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring,'S;2') = 0 ) then
           InfAdic.infAdFisco:=dadosadicionais;
      end;
  //////////////

///////////////////////      FGeral.FechaQuery(QPend);

      Total.retTrib.vRetPrev:=Q.fieldbyname('moes_funrural').asfloat;
// 01.04.15 - xml 3.10 - novicarnes
//      if Q.fieldbyname('moes_funrural').AsCurrency>0 then
//        Total.ICMSTot.vDesc:=Q.fieldbyname('moes_funrural').AsCurrency+Q.fieldbyname('moes_cotacapital').ascurrency+
//                             moes_vlrgta
// 18.02.16 - unicafes
//      else

      Total.ICMSTot.vDesc:=vlrdesco;
      Total.ICMSTot.vBC         :=  Q.fieldbyname('moes_baseicms').AsCurrency;
 // 13.05.15
      if Q.fieldbyname('moes_valoricms').AsCurrency>0 then begin
        Total.ICMSTot.vICMS       :=  Q.fieldbyname('moes_valoricms').AsCurrency;
// 08.09.15
//        Total.ICMSTot.vBC         :=  RecalculaBaseicms;
      end;
// 24.05.11 - VC com desconto de 6,321
      if (vlrdesco>0) and (valordesc=0) then
        Total.ICMSTot.vProd       :=   totalitens

      {  - 07.08.18 - retirado - devido dif. de 0,01 centavo 'de forma diferente
// 09.09.15 - novi - diferenca vprod total e por item
      else if (Q.fieldbyname('moes_totprod').AsCurrency<>totalitens)
           and (Q.fieldbyname('moes_totprod').AsCurrency>0) // 06.10.15
           and  (Q.fieldbyname('moes_tipomov').AsString<>Global.CodCompraProdutor)   // 16.03.16 no sac ok mas danfe dif. 0,01
           then
        Total.ICMSTot.vProd       :=   totalitens
}
      else

//        Total.ICMSTot.vProd       :=  Q.fieldbyname('moes_totprod').AsCurrency+valordesc;
// 19.03.20 - Devereda 'os retornos'
        Total.ICMSTot.vProd       :=  Q.fieldbyname('moes_totprod').AsCurrency;


// 24.03.17 - Clessi nf de produtor informando frete somente pra custo mas sem
//            somar no total da nota
//      if Q.fieldbyname('moes_freteciffob').asstring='2' then
// 20.09.17 - iran informa o frete mas � ele que paga
      if pos( Q.fieldbyname('moes_tipomov').asstring,Global.TiposSaida )>0 then
        Total.ICMSTot.vFrete      :=  Q.fieldbyname('moes_frete').AsCurrency;

//      Total.ICMSTot.vNF         :=  Q.fieldbyname('moes_vlrtotal').AsCurrency-
//                                     (Q.fieldbyname('moes_funrural').AsCurrency+Q.fieldbyname('moes_cotacapital').AsCurrency+
//                                     moes_vlrgta) ;
// 02.12.15 - NP da novi....
      Total.ICMSTot.vNF         :=  Q.fieldbyname('moes_vlrtotal').AsCurrency;

// 22.03.10 - Asatec
      Total.ICMSTot.vIPI        := Q.fieldbyname('moes_valoripi').AsCurrency;
// 29.08.11 - Janina
      if Despacessorias>0 then
        Total.ICMSTot.vOutro:=despacessorias;
// 08.03.14 - empresa do simples sujeita a ST
      Total.ICMSTot.vBCST:=Q.fieldbyname('moes_basesubstrib').asfloat;
      Total.ICMSTot.vST:=Q.fieldbyname('moes_valoricmssutr').asfloat;
////////////////////////
// 15.02.10 - servi�os na mesma nota
      Total.ISSQNtot.vServ      :=  Q.fieldbyname('moes_vlrservicos').asfloat;
      Total.ISSQNtot.vBC        :=  Q.fieldbyname('moes_baseiss').asfloat;
      Total.ISSQNtot.vISS       :=  Q.fieldbyname('moes_valoriss').asfloat;
// 28.10.16 - devido as retencoes q comecam a calcuar nas notas de servi�o de entrada
      if Q.fieldbyname('moes_vlrservicos').asfloat>0 then begin
        Total.ISSQNtot.vPIS       :=  Q.fieldbyname('moes_valorpis').asfloat;
        Total.ISSQNtot.vCOFINS    :=  Q.fieldbyname('moes_valorcofins').asfloat;
      end;
////////////////      procNFe.nProt := Q.fieldbyname('moes_transacao').Asstring;
// 27.06.11
      if ( Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1Asinteger('ConfNfComple') )
          and ( FGeral.GetConfig1Asinteger('ConfNfComple')>0 )
          OR
          ( Q.fieldbyname('moes_tipomov').asstring=Global.CodNfeComplementoQtde )
      then begin
        Total.ICMSTot.vBC         :=  0;
// 11.07.18 - retirado para poder fazer o rolo da sollosul e var uma nota de complemento de valor
//        Total.ICMSTot.vProd       :=  0;
//        Total.ICMSTot.vNF         :=  0;
      end;
      infNFe.ID := Q.fieldbyname('moes_transacao').Asstring+Q.fieldbyname('moes_numerodoc').Asstring;

      Ide.natOp  := Ups(FNatureza.GetDescricao(Q.fieldbyname('moes_natf_codigo').asstring));

//      Ide.cNF             := Q.fieldbyname('moes_numerodoc').AsInteger;
// 12.08.19 - a partir de 09.2019 receita n�o aceita mais desta forma
// 20.08.19 - deixado gerar aleatorio pelo acbr porem devido ao 'fator clevis' mudado para codigo
//            do cliente para que n�o 'mude a chave' caso tentar autorizar / consultar '18 vezes'

      if Global.usuario.codigo=100 then begin

         {
         if Q.fieldbyname('moes_numerodoc').AsInteger=6356 then
            Ide.cNF     := 25
         else if Q.fieldbyname('moes_numerodoc').AsInteger=6357 then
            Ide.cNF     := 1558
         else if Q.fieldbyname('moes_numerodoc').AsInteger=165535 then
            Ide.cNF     := 68250215
         else if Q.fieldbyname('moes_numerodoc').AsInteger=165536 then
            Ide.cNF     := 56201903
         else if Q.fieldbyname('moes_numerodoc').AsInteger=165578 then
            Ide.cNF     := 62169074
         else if Q.fieldbyname('moes_numerodoc').AsInteger=6294 then
            Ide.cNF     := 51957188
         else
            }
//           Ide.cNF             := Q.fieldbyname('moes_tipo_codigo').AsInteger + Q.fieldbyname('moes_numerodoc').AsInteger;
// 03.12.20
         Ide.cNF             := Q.fieldbyname('moes_tipo_codigo').AsInteger;

// 04.09.19 - 'cagada' no Sandro tonet - numero da nota igual codigo do cliente
      end  else if Q.fieldbyname('moes_tipo_codigo').AsInteger = Q.fieldbyname('moes_numerodoc').AsInteger then begin

         Ide.cNF             := Q.fieldbyname('moes_tipo_codigo').AsInteger + Q.fieldbyname('moes_numerodoc').AsInteger;

      end  else

         Ide.cNF             := Q.fieldbyname('moes_tipo_codigo').AsInteger;

      Ide.cUF             := strtoint(copy(codmuniemitente,1,2));
      Ide.cMunFG          := strtoint(codmuniemitente);

      Ide.modelo          := 55;
      if Uppercase( copy( Q.fieldbyname('moes_especie').asstring,1,3 ) ) =' NFC'  then

         Ide.modelo          := 65;


      Ide.tpImp     := tiRetrato;
// 02.02.16
      if FGeral.GetConsumidorFinal(Q.fieldbyname('moes_tipo_codigo').AsInteger,Q.fieldbyname('moes_tipocad').AsString)='S' then
        Ide.indFinal  := cfConsumidorFinal
      else
        Ide.indFinal  := cfNao;
// 06.07.15
      if  ( (Q.fieldbyname('moes_comv_codigo').AsInteger=FGeral.GetConfig1AsInteger('ConfMovNFCe') ) and
          ( FGeral.GetConfig1AsInteger('ConfMovNFCe')>0 ) )
// 31.08.15 - vivan
            OR
               ( (Q.fieldbyname('moes_comv_codigo').AsInteger=FGeral.GetConfig1AsInteger('ConfMovNFCeVC') ) and
                ( FGeral.GetConfig1AsInteger('ConfMovNFCeVC')>0 ) ) then begin
         Ide.modelo             := 65;
         Ide.tpImp     := tiNFCe;
         Ide.indFinal  := cfConsumidorFinal;
         Ide.indPres   := pcPresencial;
      end;
// 05.11.2012 - contigencia via Scan
      Ide.serie              := GetSerie(Q.fieldbyname('moes_serie').asstring,EdFormaEmissao.text);
      Ide.nNF                := Q.fieldbyname('moes_numerodoc').AsInteger;
//      Ide.dEmi               := Q.fieldbyname('moes_dataemissao').asdatetime ;
// 06.07.15 - para NFC-e
      Ide.dEmi               := Q.fieldbyname('moes_dataemissao').asdatetime + xHoraEnvio ;

      Ide.dSaiEnt            := datam;
//  TpcnFinalidadeNFe = (fnNormal, fnComplementar, fnAjuste);
      Ide.finNFe             := fnNormal;
// 27.06.11
      if ( ( Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1Asinteger('ConfNfComple') )
         and (FGeral.GetConfig1Asinteger('ConfNfComple')>0) )
         or
// 30.01.15
         ( ( Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1Asinteger('NfCompleentrada') )
         and (FGeral.GetConfig1Asinteger('NfCompleentrada')>0) )
// 17.03.15
         or
         (  pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoQtde+';'+Global.CodNfeComplementoIcms+
            ';'+Global.CodNfeComplementoValorProdutor+';'+Global.CodNfeComplementoIPI+';'+
                Global.CodComplementoValorS)>0  )
         then begin
        Ide.finNFe             := fnComplementar;
// 31.10.14 - Novicarnes
        if trim(Q.fieldbyname('moes_chavenferef').asstring)='' then
          Ide.finNFe             := fnAjuste;
        if Ide.finNFe=fncomplementar then begin
          with Ide.NFref.Add do begin
            refNFe:=Q.fieldbyname('moes_chavenferef').asstring;
          end;
        end;
// 06.08.12 - NFe de estorno
      end else if ( Q.fieldbyname('moes_tipomov').asstring=Global.CodEstornoNFeSai ) then begin

//23.10.20 - FAma - estorno de devolu��o de venda...
        if AnsiPos( copy(Q.fieldbyname('moes_natf_codigo').asstring,2,3),'202' ) > 0 then

           Ide.finNFe             := fnDevolucao

        else

           Ide.finNFe             := fnAjuste;

        Ide.natOp  := '999 - Estorno de NF-e nao cancelada no prazo legal';
        with Ide.NFref.Add do begin
          refNFe:=Q.fieldbyname('moes_chavenferef').asstring;
        end;
// 02.04.15 - NFe de Devolucao - Coorlaf - Pitanga
      end else if ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodDevolucaoCompra+';'+
                      Global.CodDevolucaoCompraProdutor+';'+
                      Global.CodDevolucaoTributadaCliente+';'+
// 04.12.20
                      Global.CodDevolucaoBonificacao+';'+
// 16.05.2022 - Clessi
                      Global.CodCompraProdutor+';'+
                      Global.CodDevolucaoTributada)>0 then begin

// 16.05.2022 - Clessi
        if Q.fieldbyname('moes_tipomov').asstring<>Global.CodCompraProdutor then

           Ide.finNFe             := fnDevolucao;

        if trim(Q.fieldbyname('moes_chavenferef').asstring)<>'' then begin

          with Ide.NFref.Add do begin
  //          RefNFe.nNF     := strtointdef( trim(Q.fieldbyname('moes_devolucoes').asstring), 0 );
            refNFe:=Q.fieldbyname('moes_chavenferef').asstring;
          end;

        end;
// 06.05.15 - NFe de Devolucao entradas rolos casa nova  - DX
      end else if ( Q.fieldbyname('moes_tipomov').asstring=Global.CodDevolucaoIgualVenda ) then begin
        Ide.finNFe             := fnDevolucao;
        with Ide.NFref.Add do begin
          refNFe:=Q.fieldbyname('moes_chavenferef').asstring;
        end;
// 20.09.18 - Simar - Devolucao de Palets que 'nao entraram' no estoque
      end else if ( Q.fieldbyname('moes_tipomov').asstring= Global.CodDevolucaoCompraSemEstoque ) then begin

        Ide.finNFe             := fnDevolucao;

      end;

      if Q.FieldByName('moes_vispra').asstring='V' then
        Ide.indPag            := ipVista
      else
        Ide.indPag            := ipPrazo;

      if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin
        Ide.tpNF      := tnEntrada;
        cEs:='E';
      end else begin
        Ide.tpNF      := tnSaida;
        cEs:='S';
      end;
// 05.11.12 - contingencia com dpecv
      if EdFormaemissao.text='4' then begin

        Ide.dhCont:=Sistema.Hoje++ xHoraEnvio;
        Ide.xjust:='Sefa '+Global.UFUnidade+' com problemas t�cnicos';

      end;
//
//      Ide.verProc   := versaolayout;
      if Global.Topicos[1028] then
        Ide.verProc   := '2.2.2'
      else
        Ide.verProc   := Global.VersaoSistema;

      if EdAmbiente.text='1' then
        Ide.tpAmb     := taProducao
      else
        Ide.tpAmb     := taHomologacao;
//  TpcnTipoEmissao = (teNormal, teContingencia, teSCAN, teDPEC, teFSDA);
      if EdFormaEmissao.text='1' then
        Ide.tpEmis    := teNormal
      else if EdFormaEmissao.text='2' then
        Ide.tpEmis    := teContingencia
      else if EdFormaEmissao.text='3' then
        Ide.tpEmis    := teSCAN
      else if EdFormaEmissao.text='4' then
        Ide.tpEmis    := teDPEC
      else if EdFormaEmissao.text='5' then
        Ide.tpEmis    := teFSDA
// 26.05.15
      else if EdFormaEmissao.text='7' then
        Ide.tpEmis    := teSVCRS
// 02.12.15 - para nfc-e somente ??
      else if EdFormaEmissao.text='8' then
        Ide.tpEmis    := teOffLine;
//  TpcnProcessoEmissao = (peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco);
     Ide.procEmi:=peAplicativoContribuinte;
// 26.05.15
    if EdFormaEmissao.text<>'1' then begin
      Ide.dhCont := Now;
      Ide.xJust := 'NOTA FISCAL EMITIDA EM CONTINGENCIA';
    end;

// 23.03.11 - Clessi - nota de exporta��o - xml 2.0
//      if copy(Ide.natOp,1,1)='7' then begin
//  07.04.11 ide.natop tem a descricao da natureza e nao o cfop jamantossauro...
      if copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1)='7' then begin
        campo:=Sistema.GetDicionario('movesto','moes_estadoex');
//        if campo.Tipo<>'' then
//          exporta.UFembarq:=Q.fieldbyname('moes_estadoex').asstring
//        else
// 24.06.19 - nao aceita mais o EX na tag ufsaidapais
          exporta.UFembarq:=Global.UFUnidade;
        exporta.xLocEmbarq:=copy(Q.fieldbyname('moes_embarque').asstring,1,60);
// 06.04.15
        exporta.UFSaidaPais:=exporta.UFembarq;
        exporta.xLocExporta:=copy(Q.fieldbyname('moes_embarque').asstring,1,60);
        exporta.xLocDespacho:=copy(Q.fieldbyname('moes_embarque').asstring,1,60);
      end else begin
        exporta.UFembarq:='';
        exporta.xLocEmbarq:='';
      end;
// 12.01.12 - Asatec
      temdi:=false;
      if copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1)='3' then begin
        campo:=Sistema.GetDicionario('movesto','moes_numerodi');
        if campo.Tipo<>'' then temdi:=true;
      end;
// 26.03.15 - xml 3.10
//     if Global.topicos[1041] then begin
        if pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1),'15' ) > 0 then
          Ide.idDest:=doInterna
        else if pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1),'26' ) > 0 then
          Ide.idDest:=doInterestadual
        else
          Ide.idDest:=doExterior;
//     end;
/////////////////
      QDesti:=Sqltoquery('select * from transportadores where tran_codigo='+stringtosql(Q.fieldbyname('moes_tran_codigo').AsString));

      rntc:='';
      numero:=Fsintegra.GetNumerodoEndereco(QDesti.fieldbyname('tran_endereco').asstring,0,'N');
      if length(trim(QDesti.fieldbyname('tran_cnpjcpf').asstring))<14 then begin
        cnpjtran:='';
        cpftran:=QDesti.fieldbyname('tran_cnpjcpf').asstring;
      end else begin
        cpftran:='';
        cnpjtran:=QDesti.fieldbyname('tran_cnpjcpf').asstring;
      end;

//  TpcnModalidadeFrete = (mfContaEmitente, mfContaDestinatario);
      if Q.fieldbyname('moes_freteciffob').asstring='1' then
        Transp.modFrete  := mfContaEmitente
      else
        Transp.modFrete  :=  mfContaDestinatario;
// 20.05.15
      if  ( (Q.fieldbyname('moes_comv_codigo').AsInteger=FGeral.GetConfig1AsInteger('ConfMovNFCe') ) and
          ( FGeral.GetConfig1AsInteger('ConfMovNFCe')>0 ) )
// 31.08.15 - vivan
            OR
               ( (Q.fieldbyname('moes_comv_codigo').AsInteger=FGeral.GetConfig1AsInteger('ConfMovNFCeVC') ) and
                ( FGeral.GetConfig1AsInteger('ConfMovNFCeVC')>0 ) ) then
        Transp.modFrete := mfSemFrete; // NFC-e n�o pode ter FRETE

// 01.03.2013   - 26.04.17 colocado para usar transportador do EXterior - Clessi
      if (  (QDesti.fieldbyname('tran_cnpjcpf').asstring<>'') or (QDesti.fieldbyname('tran_ufplaca').asstring='EX') )
        and (Q.fieldbyname('moes_comv_codigo').AsInteger<>FGeral.GetConfig1AsInteger('ConfMovNFCe'))
        and (Q.fieldbyname('moes_comv_codigo').AsInteger<>FGeral.GetConfig1AsInteger('ConfMovNFCeVC'))
// 02.08.18 - se for interestadual nao informar o grupo de transportador...
// 16.08.18 - FAma  - revendo a questao..
//        and ( pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1),'26' ) = 0 )
        then begin

        Transp.Transporta.CNPJCPF := QDesti.fieldbyname('tran_cnpjcpf').asstring;
        Transp.Transporta.xNome   := UPs(QDesti.fieldbyname('tran_razaosocial').asstring);
        Transp.Transporta.IE      := GetInsEst(QDesti.fieldbyname('tran_inscricaoestadual').asstring,'T');
        Transp.Transporta.xEnder  := Ups(QDesti.fieldbyname('tran_endereco').asstring);
        Transp.Transporta.xMun    := Ups(FCidades.GetNome(QDesti.fieldbyname('tran_cida_codigo').asinteger));
        Transp.Transporta.UF      := FCidades.GetUF( QDesti.fieldbyname('tran_cida_codigo').asinteger);
// 16.08.18
//        if Ide.idDest<>doInterestadual then begin
// 10.06.19
        if (Ide.idDest<>doInterestadual) and  ( QDesti.fieldbyname('tran_placa').asstring<>'' ) then begin

            Transp.veicTransp.placa   :=fGeral.TiraBarra(QDesti.fieldbyname('tran_placa').asstring,'-');
            Transp.veicTransp.UF      :=QDesti.fieldbyname('tran_ufplaca').asstring;

        end;

  // 05.11.12
        if Q.FieldByName('moes_qtdevolume').asINTEGER > 0 then begin
          Transp.Vol.Add.qVol       :=Q.FieldByName('moes_qtdevolume').asINTEGER;
  // se usar add cria tag volume para cada add..entao cria uma e coloca 'as filhas'
          Transp.Vol.Items[0].esp   :=Q.FieldByName('moes_especievolume').AsString;
          Transp.Vol.Items[0].marca      :='';
          Transp.Vol.Items[0].pesoL      :=Q.FieldByName('moes_pesoliq').ascurrency;
          Transp.Vol.Items[0].pesoB      :=Q.FieldByName('moes_pesobru').ascurrency;
        end;
      end;

      Emit.EnderEmit.xPais := nomepais;
      Emit.EnderEmit.cPais := codigopais;
//       Emit.EnderEmit.nro   := 'SEM NUMERO';

      Dest.EnderDest.xPais := nomepais;
      Dest.EnderDest.cPais := codigopais;
//       Dest.EnderDest.nro   := 'SEM NUMERO';


      numero:=Fsintegra.GetNumerodoEndereco(EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring,0,'N');

      codmuniemitente:=FCidades.GetCodigoIBGE(EdUNid_codigo.resultfind.fieldbyname('unid_cida_codigo').asinteger);
      codmuni:=strspace(codmuniemitente,7);
      Emit.xNome     := EdUnid_codigo.resultfind.fieldbyname('Unid_razaosocial').asstring;
      Emit.xFant     := EdUnid_codigo.resultfind.fieldbyname('Unid_nome').asstring;
      Emit.CNPJCPF   := EdUnid_codigo.resultfind.fieldbyname('Unid_cnpj').asstring;
      Emit.IE        := EdUnid_codigo.resultfind.fieldbyname('Unid_inscricaoestadual').asstring;

      Emit.EnderEmit.fone       :=GetTelefone(EdUNid_codigo.resultfind.fieldbyname('unid_fone').asstring);
      Emit.EnderEmit.CEP        :=strtoint(EdUNid_codigo.resultfind.fieldbyname('unid_cep').asstring);
// 01.07.10 - para nao ficar sem logradouro caso nao tiver virgula...
      if Ansipos(',',EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring)>0 then
          Emit.EnderEmit.xLgr      := Ups( copy(EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring,1,Ansipos(',',EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring)-1) )
      else
         Emit.EnderEmit.xLgr      := Ups( EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring );
//      Emit.EnderEmit.xLgr       :=Ups(EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring);

      Emit.EnderEmit.nro        :=numero;
//      Emit.EnderEmit.xCpl       := '';
      Emit.EnderEmit.xBairro    := Ups(EdUNid_codigo.resultfind.fieldbyname('unid_bairro').asstring);
      Emit.EnderEmit.cMun   := strtoint(codmuniemitente);
      Emit.EnderEmit.xMun := Ups(EdUNid_codigo.resultfind.fieldbyname('unid_municipio').asstring);
      Emit.EnderEmit.UF          := EdUNid_codigo.resultfind.fieldbyname('unid_uf').asstring;
// 15.02.10
      Emit.IM:=EdUNid_codigo.resultfind.fieldbyname('Unid_inscricaomunicipal').asstring;
// ver se precisa do cnae quando a nota tem servi�os junto
// checar pois este campo ainda nao esta 'disponivel' no cadastro de unidades com edit, etc
      Emit.CNAE:=EdUNid_codigo.resultfind.fieldbyname('unid_Cnaefiscal').asstring;
      if ( Total.ISSQNtot.vServ>0 ) and (trim(Emit.CNAE)='') then begin
        Avisoerro('Obrigat�rio informar o CNAE na Unidade em notas com servi�os');
        FechaArquivosXML;
        exit;
     end;
// 23.09.10 - deixado 'fixo' em 05.05.11
//    {$IFDEF LIBXML2}
     Emit.CRT:=GetCRT(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring);
// 09.03.14 - Zilmar I.E. ref. Subst. Trib.
     Emit.IEST:=EdUNid_codigo.resultfind.fieldbyname('Unid_inscricaomunicipal').AsString;
// 27.08.18 -  siccare e zilmar = quando � venda fora do estado nao enviar a IE do substituto tributario
     if ( Ansipos( copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1),'26' ) > 0 )
        or
        ( ide.modelo=65  )   // 07.12.2021 - Nfce n�o aceita
        then
        Emit.IEST:='';

//    {$ENDIF}
// 11.05.16 - Unicafes - Wagner
      if  trim(EdUNid_codigo.resultfind.fieldbyname('Unid_cpfcontador').AsString)<>'' then begin
        with autXML.Add do begin
          CNPJCPF:=EdUNid_codigo.resultfind.fieldbyname('Unid_cpfcontador').AsString;
        end;
      end;
//////////////////
// Dados do Destinatario
///////////////////////////
      Dest.EnderDest.cPais   := codigopais;
      Dest.EnderDest.xPais   := nomepais;
      ConsumidorFinal:='N';
      if Q.fieldbyname('moes_tipocad').AsString='F' then begin

        QDesti:=Sqltoquery('select * from fornecedores where forn_codigo='+Q.fieldbyname('moes_tipo_codigo').AsString);
        numero:=Fsintegra.GetNumerodoEndereco(QDesti.fieldbyname('forn_endereco').asstring,Q.fieldbyname('moes_tipo_codigo').AsInteger,'N');
        codmuni:=FCidades.GetCodigoIBGE(QDesti.fieldbyname('forn_cida_codigo').asinteger);
        if trim(codmuni)='' then begin
           Avisoerro('Cidade codigo '+QDesti.fieldbyname('forn_cida_codigo').asstring+' sem codigo do IBGE');
           FechaArquivosXML;
           exit;
        end;
// 29.03.10
        if trim(QDesti.fieldbyname('forn_cep').asstring)='' then begin
           Avisoerro('Fornecedor codigo '+QDesti.fieldbyname('forn_codigo').asstring+' sem Cep');
           FechaArquivosxml;
           exit;
        end;

        if length(trim(QDesti.fieldbyname('forn_cnpjcpf').asstring))<14 then
  //        linha:='E03'+sep+GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,11)+sep
          Dest.CNPJCPF                   := GetCnpjCpf(QDesti.fieldbyname('forn_cnpjcpf').asstring,11)
        else
    //      linha:='E02'+sep+GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,14)+sep;
          Dest.CNPJCPF                   := GetCnpjCpf(QDesti.fieldbyname('forn_cnpjcpf').asstring,14);

        Dest.EnderDest.CEP           := strtoint(QDesti.fieldbyname('forn_cep').asstring);
// 01.07.10 - para nao ficar sem logradouro caso nao tiver virgula...
        if pos(',',QDesti.fieldbyname('forn_endereco').asstring)>0 then
          Dest.EnderDest.xLgr      := Ups( copy(QDesti.fieldbyname('forn_endereco').asstring,1,pos(',',QDesti.fieldbyname('forn_endereco').asstring)) )
        else
          Dest.EnderDest.xLgr      := Ups( QDesti.fieldbyname('forn_endereco').asstring );

//        Dest.EnderDest.xLgr      := Ups(QDesti.fieldbyname('forn_endereco').asstring);

        Dest.EnderDest.nro           := numero;
        Dest.EnderDest.xCpl  := '';
        Dest.EnderDest.xBairro     := Ups(QDesti.fieldbyname('forn_bairro').asstring);
        Dest.EnderDest.cMun  := strtoint(codmuni);
        Dest.EnderDest.xMun := Ups(FCidades.GetNome(QDesti.fieldbyname('forn_cida_codigo').asinteger));
        Dest.EnderDest.UF               := QDesti.fieldbyname('forn_uf').asstring;
        Dest.EnderDest.fone            := GetTelefone(QDesti.fieldbyname('forn_fone').asstring);
        Dest.IE                    := GetInsEst(QDesti.fieldbyname('forn_inscricaoestadual').asstring);
        Dest.xNome                := Ups(QDesti.fieldbyname('forn_razaosocial').asstring);
// 13.02.17
        Dest.indIEDest:=inContribuinte;
        Ide.indFinal  := cfNao;
        if (trim(Dest.IE)='') or (QDesti.fieldbyname('forn_contribuinte').asstring='N') then  begin
          Dest.indIEDest:=inNaoContribuinte;
          Ide.indFinal  := cfConsumidorFinal;
        end;

      end else if ( Q.fieldbyname('moes_tipocad').AsString='U') then begin

        QDesti:=Sqltoquery('select * from unidades where unid_codigo='+stringtosql(strzero(Q.fieldbyname('moes_tipo_codigo').AsInteger,3)));

        numero:=Fsintegra.GetNumerodoEndereco(QDesti.fieldbyname('unid_endereco').asstring,Q.fieldbyname('moes_tipo_codigo').AsInteger,'N');
        codmuni:=FCidades.GetCodigoIBGE(QDesti.fieldbyname('unid_cida_codigo').asinteger);
////////////
        if length(trim(QDesti.fieldbyname('unid_cnpj').asstring))<14 then
  //        linha:='E03'+sep+GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,11)+sep
          Dest.CNPJCPF                   := GetCnpjCpf(QDesti.fieldbyname('unid_cnpj').asstring,11)
        else
    //      linha:='E02'+sep+GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,14)+sep;
          Dest.CNPJCPF                   := GetCnpjCpf(QDesti.fieldbyname('unid_cnpj').asstring,14);
        Dest.EnderDest.CEP           := strtoint(QDesti.fieldbyname('unid_cep').asstring);

// 15.04.10 - 'retirada do numero para 'nao dobrar'
// 23.04.10 - para nao ficar sem logradouro caso nao tiver virgula...
        if pos(',',QDesti.fieldbyname('unid_endereco').asstring)>0 then
          Dest.EnderDest.xLgr      := Ups( copy(QDesti.fieldbyname('unid_endereco').asstring,1,pos(',',QDesti.fieldbyname('unid_endereco').asstring)) )
        else
          Dest.EnderDest.xLgr      := Ups( QDesti.fieldbyname('unid_endereco').asstring );
//        Dest.EnderDest.xLgr      := Ups(QDesti.fieldbyname('unid_endereco').asstring);

        Dest.EnderDest.nro           := numero;
        Dest.EnderDest.xCpl  := '';
        Dest.EnderDest.xBairro     := Ups(QDesti.fieldbyname('unid_bairro').asstring);
        Dest.EnderDest.cMun  := strtoint(codmuni);
        Dest.EnderDest.xMun:= Ups(FCidades.GetNome(QDesti.fieldbyname('unid_cida_codigo').asinteger));
        Dest.EnderDest.UF               := QDesti.fieldbyname('unid_uf').asstring;
        Dest.EnderDest.fone            := GetTelefone(QDesti.fieldbyname('unid_fone').asstring);
//        Dest.IE                    := GetInsEst(QDesti.fieldbyname('unid_inscricaoestadual').asstring);
// 31.08.15
        Dest.IE                    := copy(QDesti.fieldbyname('unid_inscricaoestadual').asstring,1,14);
        Dest.xNome                := Ups(QDesti.fieldbyname('unid_razaosocial').asstring);
////////////
      end else begin

// 11.11.2021 - Benato - 06.01.2022 ajustado somente para nfce
        if Global.Topicos[1519] and (ide.modelo=65) then

           QDesti := Sqltoquery('select * from clientes where clie_codigo = '+FGeral.GetConfig1AsString('clieconsumidor') )

        else

           QDesti:=Sqltoquery('select * from clientes where clie_codigo='+Q.fieldbyname('moes_tipo_codigo').AsString);


        if length(trim(QDesti.fieldbyname('clie_cnpjcpf').asstring))<14 then
  //        linha:='E03'+sep+GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,11)+sep
          Dest.CNPJCPF                   := GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,11)
        else
    //      linha:='E02'+sep+GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,14)+sep;
          Dest.CNPJCPF                   := GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,14);
//  04.03.16 - Vida Nova - Dani - sai com cnpj do seed e demais dados da escolha
        if ( Q.fieldbyname('moes_tipomov').AsString=Global.CodNotaRemessaaOrdem )
              and
              ( pos(Q.fieldbyname('moes_clie_codigo').asstring,FGeral.getconfig1asstring('clientesjustica')+';'+FGeral.getconfig1asstring('clientessaude')) = 0 )
             then begin
             FGeral.FechaQuery(QDesti);
             QDesti:=Sqltoquery('select * from clientes where clie_codigo='+Q.fieldbyname('moes_clie_codigo').AsString);
        end;


        numero :=Fsintegra.GetNumerodoEndereco(QDesti.fieldbyname('clie_endres').asstring,Q.fieldbyname('moes_tipo_codigo').AsInteger,'N');
        codmuni:=FCidades.GetCodigoIBGE(QDesti.fieldbyname('clie_cida_codigo_res').asinteger);
        if trim(codmuni)='' then begin
           Avisoerro('Cidade codigo '+QDesti.fieldbyname('clie_cida_codigo_res').asstring+' sem codigo do IBGE');
           FechaArquivosxml;
           exit;
        end;
        if ( trim(QDesti.fieldbyname('clie_bairrores').asstring)='' ) and ( Ide.modelo <>65 ) then begin
           Avisoerro('Cliente codigo '+QDesti.fieldbyname('clie_codigo').asstring+' sem bairro');
           FechaArquivosxml;
           exit;
        end;
// 29.03.10
        if ( trim(QDesti.fieldbyname('clie_cepres').asstring)='' )  and ( Ide.modelo <>65 ) then begin
           Avisoerro('Cliente codigo '+QDesti.fieldbyname('clie_codigo').asstring+' sem Cep');
           FechaArquivosxml;
           exit;
        end;
        ConsumidorFinal:=QDesti.fieldbyname('Clie_consfinal').Asstring;

// 01.08.15
        if ( ( ide.modelo=65 ) and ( copy(Dest.CNPJCPF,1,5)='00000' ) )
           OR
           (  ( ide.modelo=65 ) and ( QDesti.fieldbyname('clie_encargoscob').asstring='N' ) )
        then Dest.CNPJCPF:='';

        Dest.EnderDest.CEP           := strtointdef(QDesti.fieldbyname('clie_cepres').asstring,0);
//        Dest.EnderDest.xLgr      := Ups(QDesti.fieldbyname('clie_endres').asstring);
// 15.04.10 - 'retirada do numero para 'nao dobrar'
// 23.04.10 - para nao ficar sem logradouro caso nao tiver virgula...
        if Ansipos(',',QDesti.fieldbyname('clie_endres').asstring)>0 then

//          Dest.EnderDest.xLgr      := Ups( copy(QDesti.fieldbyname('clie_endres').asstring,1,Ansipos(',',QDesti.fieldbyname('clie_endres').asstring)) )
// 11.11.2021 - Guiber - fica com 'duas v�rgulas' no danfe
          Dest.EnderDest.xLgr      := Ups( copy(QDesti.fieldbyname('clie_endres').asstring,1,Ansipos(',',QDesti.fieldbyname('clie_endres').asstring)-1) )

        else

          Dest.EnderDest.xLgr      := Ups( QDesti.fieldbyname('clie_endres').asstring );

// 09.11.12 - nao dobrar o numero
        Dest.EnderDest.xLgr := TiraString(numero,Dest.EnderDest.xLgr);
        Dest.EnderDest.Nro           := numero;
        Dest.EnderDest.xCpl  := '';
        Dest.EnderDest.xBairro     := Ups(QDesti.fieldbyname('clie_bairrores').asstring);
        Dest.EnderDest.cMun  := strtointdef(codmuni,0);
        Dest.EnderDest.xMun  := Ups(FCidades.GetNome(QDesti.fieldbyname('clie_cida_codigo_res').asinteger));
        Dest.EnderDest.UF               := QDesti.fieldbyname('clie_uf').asstring;
        Dest.EnderDest.fone            := GetTelefone(QDesti.fieldbyname('clie_foneres').asstring);
// 23.04.2021
        if (Global.Topicos[1429]) and ( trim(QDesti.fieldbyname('Clie_codcliemp').asstring)<>'' ) then

           Dest.EnderDest.xCpl := Uppercase(QDesti.fieldbyname('Clie_codcliemp').asstring);

// 01.04.15
        Dest.indIEDest:=inNaoContribuinte;
        if QDesti.FieldByName('Clie_tipo').AsString<>'F' then begin
          if trim(QDesti.fieldbyname('clie_rgie').asstring)<>'' then
            Dest.IE                := GetInsEst(QDesti.fieldbyname('clie_rgie').asstring);
  // 25.03.15 - xml 3.10
//          if Global.topicos[1041] then begin
          Dest.indIEDest:=inContribuinte;
  //          aviso( 'IE='+Dest.ie+'|' );
          if trim(Dest.IE)='' then begin
             Dest.indIEDest:=inNaoContribuinte;
          end;
//   15.08.16 - Markito - vendas para MEI ( sem IE mas contribuinte )
          if QDesti.fieldbyname('clie_contribuinte').asstring='S' then Dest.indIEDest:=inContribuinte;
//   22.04.22 - Guiber - venda para Senac que mesmo com IE � nao contribuiente )
          if QDesti.fieldbyname('clie_contribuinte').asstring='N' then Dest.indIEDest:=inNaoContribuinte;

//          end;   // 04.07.16 - Novicarnes - produtor rural com cadpro  // 05.10.16
        end else if (QDesti.fieldbyname('clie_rgie').asstring<>'') and (QDesti.fieldbyname('Clie_contribuinte').asstring='S') then begin
               Dest.indIEDest:=inContribuinte;
               Dest.IE       := GetInsEst(QDesti.fieldbyname('clie_rgie').asstring);
        end;
        Dest.xNome                := Ups(QDesti.fieldbyname('clie_razaosocial').asstring);
// 06.06.16 - NFe de Produtor rural informar a nota do produtor
        if (Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor) and (Global.Topicos[1395])  then begin
          with Ide.NFref.Add do begin
            RefNFP.cUF:=strtoint(copy(codmuni,1,2));
            RefNFP.AAMM:=strzero(DatetoAno(Q.fieldbyname('moes_dataemissao').asdatetime,false),2)+
                         strzero(Datetomes(Q.fieldbyname('moes_dataemissao').asdatetime),2);
            if length(trim(QDesti.fieldbyname('clie_cnpjcpf').asstring))<14 then
              RefNFP.CNPJCPF    := GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,11)
            else
              RefNFP.CNPJCPF    := GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,14);
            RefNFP.IE           := QDesti.fieldbyname('clie_rgie').asstring;
            RefNFP.modelo       := '04';  // bloco de nota de produtor
            RefNFP.serie        := 0;
            RefNFP.nNF          := Q.Fieldbyname('moes_notapro').asinteger;
          end;
        end;
////////////
      end;
// 15.06.10 - Lam. Sao Caetano + Sefa Sc
      if (Q.fieldbyname('moes_estado').asstring)='EX' then begin
//        Dest.EnderDest.cPais:=2321;  // FCidades.GetCodigoPais(QDesti.fieldbyname('clie_cida_codigo_res').asinteger);
//        Dest.EnderDest.xPais:='DINAMARCA';  // Ups(FCidades.GetNomePais(QDesti.fieldbyname('clie_cida_codigo_res').asinteger));
// 30.10.10 - Asatec - Nota de IMporta��o - Entrada - Fornecedor
        if Q.fieldbyname('moes_tipocad').AsString='F' then begin
          Dest.EnderDest.cPais:=strtointdef(FCidades.GetCodigoPais(QDesti.fieldbyname('Forn_cida_codigo').asinteger),0);
          Dest.EnderDest.xPais:=Ups(FCidades.GetNomePais(QDesti.fieldbyname('Forn_cida_codigo').asinteger));
        end else begin
          Dest.EnderDest.cPais:=strtointdef(FCidades.GetCodigoPais(QDesti.fieldbyname('clie_cida_codigo_res').asinteger),0);
          Dest.EnderDest.xPais:=Ups(FCidades.GetNomePais(QDesti.fieldbyname('clie_cida_codigo_res').asinteger));
// 06.04.15 - Lam. Sao caetano xml 3.10
          Dest.idEstrangeiro:=QDesti.fieldbyname('Clie_codcliemp').asstring; // '1-770-472-3050';
        end;
        if Dest.EnderDest.cPais=0 then begin
           Avisoerro('Sem codigo do pais no cadastro de cidades');
           FechaArquivosxml;
           exit;
        end;
        if trim(Dest.EnderDest.xPais)='' then begin
           Avisoerro('Sem nome do pais no cadastro de cidades');
           FechaArquivosxml;
           exit;
        end;
      end else begin
        Dest.EnderDest.cPais:=codigopais;  // FCidades.GetCodigoPais(QDesti.fieldbyname('clie_cida_codigo_res').asinteger);
        Dest.EnderDest.xPais:='BRASIL';  // Ups(FCidades.GetNomePais(QDesti.fieldbyname('clie_cida_codigo_res').asinteger));
      end;


//       ACBrNFe1.NotasFiscais.Add.NFe.Det.Add.Prod.

////////////////////////////////// - itens das notas

// 17.03.10 - refazendo para prever mais de um cfop e mesma cst na venda ( 5101 e 5102 )
      QConfmov:=sqltoquery('select * from confmov where comv_codigo='+inttostr(Q.fieldbyname('moes_comv_codigo').AsInteger));
      if copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1)='5' then
        cfopind:=QConfmov.fieldbyname('comv_natf_estadoipi').asstring
      else
        cfopind:=QConfmov.fieldbyname('comv_natf_foestadoipi').asstring;
// 19.01.11 - quando tem ncm busca o ipi de industria mas caso nao tiver configurado
//            deve ficar o 'normal'
      if trim(cfopind)='' then cfopind:=Q.fieldbyname('moes_natf_codigo').asstring;

      FGeral.Fechaquery(QConfmov);
// 29.08.18 - Giacomoni - Barbara
      sqlorder:='';
      if Global.Topicos[1052] then sqlorder:=' order by esto_descricao';

      Q1:=sqltoquery('select * from movestoque inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                     ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
//                     ' inner join estoqueqtde on ( esqt_esto_codigo=move_esto_codigo )'+
// 03.12.19 - A2z - Thais 'descobriu'
//                     ' inner join estoqueqtde on ( esqt_esto_codigo=move_esto_codigo and esqt_unid_codigo=move_unid_codigo )'+
// 08.07.20 - tentativa de preve quando produto fica no estoqueqtde 2 x uma com status N e outro C
                     ' inner join estoqueqtde on ( esqt_esto_codigo=move_esto_codigo and esqt_unid_codigo=move_unid_codigo and esqt_status=move_status )'+
// 05.07.10
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' left join cores on (core_codigo=move_core_codigo)'+
//
                     ' where move_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                     ' and move_tipomov='+stringtosql(Q.fieldbyname('moes_tipomov').asstring)+
// 10.05.17 - pedido com  devolucoes devereda para nao considerar e dar como desconto
                     ' and move_qtde >= 0 '+
                     ' and move_unid_codigo='+stringtosql(Q.fieldbyname('moes_unid_codigo').asstring)+
                     ' and '+FGeral.GetIN('move_status','N','C')+
                     sqlorder
                      );
      seq:=1;
      totalcofins:=0;totalpis:=0;totalvFCPUFDest:=0;totalvICMSUFDest:=0;totalvICMSUFRemet:=0;
// 28.05.12
      rateioicmsimportacao:=0;
      tIcmsDeson:=0;

///////////////////////
{
      if not Q1.eof then begin
        if ( Q1.FieldByName('moes_vlrtotal').ascurrency < Q1.FieldByName('moes_baseicms').ascurrency )
          and
         ( Q1.FieldByName('moes_valoricms').ascurrency>0 )
          and                          41
         ( copy(Q1.FieldByName('moes_natf_codigo').asstring,1,1)='3' )
        then
//          rateioicmsimportacao:=fGeral.Arredonda( Abs(Q1.FieldByName('moes_vlrtotal').ascurrency - Q1.FieldByName('moes_baseicms').ascurrency)/Q1.FieldByName('moes_valoricms').ascurrency ,3 )
//          rateioicmsimportacao:=fGeral.Arredonda( 100 *  (Abs(Q1.FieldByName('moes_vlrtotal').ascurrency - Q1.FieldByName('moes_baseicms').ascurrency)/Q1.FieldByName('moes_valoricms').ascurrency) ,2 )
//          rateioicmsimportacao:=fGeral.Arredonda( 100 *  (Abs(Q1.FieldByName('moes_vlrtotal').ascurrency - Q1.FieldByName('moes_baseicms').ascurrency)/Q1.FieldByName('moes_valoricms').ascurrency) ,3 )
//          rateioicmsimportacao:=fGeral.Arredonda( 100 *  (Abs(Q1.FieldByName('moes_vlrtotal').ascurrency - Q1.FieldByName('moes_baseicms').ascurrency)/Q1.FieldByName('moes_valoricms').ascurrency) ,4 )
//          rateioicmsimportacao:=fGeral.Arredonda( 100 *  (Abs(Q1.FieldByName('moes_vlrtotal').ascurrency - Q1.FieldByName('moes_baseicms').ascurrency)/Q1.FieldByName('moes_valoricms').ascurrency) ,6 )
          rateioicmsimportacao:= 100 *  (Abs(Q1.FieldByName('moes_vlrtotal').ascurrency - Q1.FieldByName('moes_baseicms').ascurrency)/Q1.FieldByName('moes_valoricms').ascurrency)
      end;
     // }
///////////////////////

      Sistema.beginprocess('Gerando arquivos XML - 4 ');
      Valortotalimpaproximado:=0;
      informainss:=0;
      totdescitens:=0;
      totacreitens:=0;
      vlracres:=Despacessorias;
      if Q1.FieldByName('moes_vlrtotal').ascurrency>0 then
// recalcula o % de acrescimo para ficar com 'todas as casas
         xmoes_peracres := (despacessorias/Q1.FieldByName('moes_vlrtotal').ascurrency)*100
      else
            xmoes_peracres := 0;
// 10.09.15
      vtotalfreteitens:=0;
// 08.12.15
      if trim(Q.fieldbyname('moes_remessas').asstring)<>'' then begin
        QN:=sqltoquery('select moes_xmlnfet from movesto where moes_transacao='+Stringtosql(trim(Q.fieldbyname('moes_remessas').asstring)) );
        TItensNfe.NotasFiscais.LoadFromString( QN.fieldbyname('moes_xmlnfet').AsString ,false);
        fgeral.Fechaquery(QN);
      end else begin
         TItensNfe.Tag:=98
      end;
      totalvalorII:=0;

      while not Q1.eof do begin

//        totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency,2);
// 21.05.12 - nova valida��o da sefa - aceita 0,01 centavos de diferen�a
//        totalitem:=Q1.fieldbyname('move_qtde').ascurrency*FGEral.Arredonda( Q1.fieldbyname('move_venda').ascurrency,4);
//        totalitem:=Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency;

// 25.05.12 - Asatec - 03.08.12 - NP - Novicarnes
        if ( Q.fieldbyname('moes_peracres').ascurrency>0 ) and
           ( Q.fieldbyname('moes_estado').asstring='EX' )
           then
//          totalitem:=Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').asFLOAT

          totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').asFLOAT,2)

// 07.08.13 - NP - Novicarnes com d�zima no valor unitario do kilo
//        else if Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor then
//        else if Q1.fieldbyname('move_tipomov').asstring=Global.CodCompraProdutor then

// 18.06.14 - Novicarnes - transferencias da fazenda (002) para novi (001) usando romaneio da 001
        else if pos(Q1.fieldbyname('move_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodTransfSaida)>0 then begin

//          totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').asfloat,2)
// 03.08.18 - Novicarnes xml 4.0
//          totalitem:= Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').asfloat
// 14.08.18
//          totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').asfloat,6)
//          totalitem:=Q1.fieldbyname('move_qtde').ascurrency*FGEral.Arredonda(Q1.fieldbyname('move_venda').asfloat,6)
//          totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency,5)*
//                     FGEral.Arredonda(Q1.fieldbyname('move_venda').asfloat,5)
// 31.07.20 - NF produtor 'loke' com xml+romaneio na bate qtde x unitario com total do item
          totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency,6)*
                     FGEral.Arredonda(Q1.fieldbyname('move_venda').asfloat,6);

//          if global.usuario.codigo = 100  then Aviso('totalitem='+floattostr(totalitem));


        end else if ( Q.fieldbyname('moes_peracres').ascurrency>0 ) then begin

          totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency,6)*
                     FGEral.Arredonda(Q1.fieldbyname('move_venda').asfloat,6);


        end else
//          totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency,2);
// 06.09.16 - novi venda com 5 casas decimais
//          totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').asfloat,2);
// 04.08.18
//          totalitem:=Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').asfloat;
// 28.08.18
          totalitem:=FGEral.Arredonda( Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').asfloat ,2 );

          if ListaItens01.count>0 then begin

             if ListaItens01.indexof( Q1.fieldbyname('move_esto_codigo').asstring ) >=0  then begin
                ListaItens02a:=TStringList.Create;
                strtolista(Listaitens02a,Listaitens02[ListaItens01.indexof( Q1.fieldbyname('move_esto_codigo').asstring )] ,';',true);
                totalitem := totalitem +
                             FGEral.Arredonda( TextTovalor( ListaItens02a[0] ) * TextTovalor( ListaItens02a[1] )
                             ,2 );
                ListaItens02a.Free;

             end;

          end;

// 28.07.16 - Devereda
//        if totalitem<0 then totalitem:=totalitem*(-1);
// 19.03.20
//        if totalitem<0 then totalitem:=0;

// 08.09.15 diferen�a de 0,01 centavos...
//          totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency,3);
//          totalitem:=Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency;
//          totalitem:=Q1.fieldbyname('move_qtde').asfloat*Q1.fieldbyname('move_venda').asfloat;
//          totalitem:=RoundValor(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency);
//          totalitem:=SimpleRoundTo(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency,0);
//          totalitem:=SimpleRoundTo(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency,1);

//        vendaliquido:=Q1.fieldbyname('move_venda').asfloat - ( Q1.fieldbyname('move_venda').asfloat*(Q.fieldbyname('moes_perdesco').ascurrency/100) );
// 24.05.11
        vendaliquido:=Q1.fieldbyname('move_venda').asfloat - ( Q1.fieldbyname('move_venda').asfloat*roundvalor(Q.fieldbyname('moes_perdesco').ascurrency/100) );
//        if Q.fieldbyname('moes_perdesco').ascurrency>0 then
//          totalitem:= FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*vendaliquido,2);

// 08.07.19
        totalitemliquido:=totalitem - ( totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100));
        baseicms:=totalitem;
// 10.10.18
        valorII:=0;

        baseicmssemreducao:=0;
// 29.08.11 - Descontos e acrescimentos na base do icms
        if Q.fieldbyname('moes_perdesco').ascurrency>0 then
          baseicms:=baseicms - roundvalor( totalitem * (Q.fieldbyname('moes_perdesco').ascurrency/100) ) ;
// 17.11.15 - coorlaft - funrural descontava somente no primeiro item....
//        if ( Q.fieldbyname('moes_funrural').AsCurrency>0 ) then begin
//          xmoes_perdesco:=((Q.fieldbyname('moes_funrural').AsCurrency+moes_vlrgta+Q.fieldbyname('moes_cotacapital').ascurrency)/Q.fieldbyname('moes_vlrtotal').AsCurrency)*100;
//          baseicms:=baseicms - roundvalor( totalitem * (xmoes_perdesco/100) ) ;
//        end;
// 29.05.12 - Asatec..nao bate o valor calculado do icms em nota com desconto
        if ( Q.fieldbyname('moes_estado').asstring='EX' )  and (cEs='E') then begin

          baseicms:=baseicms;
//          valorII:= baseicms * (FCodigosIPI.GetPerII( FEstoque.GetNCMipi(Q1.fieldbyname('move_esto_codigo').asstring) ) /100);
// 04.07.19
          valorII:= baseicms * (Q1.fieldbyname('move_aliII').ascurrency/100);

// 23.06.19 - nota importacao - devolucao seip - gambiaaaaaaaaaa
        end else if ( Q.fieldbyname('moes_estado').asstring='EX' )  and (cEs='S')
// 07.04.20
            and  ( AnsiPos( Q.fieldbyname('moes_tipomov').asstring,Global.CodDevolucaoTributadaCliente+'/;'+Global.CodVendaSemMovEstoque)>0 )
            then begin

          baseicms:=baseicms;
          valorII:= baseicms * (Q1.fieldbyname('move_aliII').ascurrency/100);
//          valorII:= baseicms * (0.6007 ) /100;

        end else if Q.fieldbyname('moes_peracres').ascurrency>0 then begin

//             baseicms:=baseicms + roundvalor( totalitem * (Q.fieldbyname('moes_peracres').ascurrency/100) ) ;
// 13.03.19  - Novicarens - Isonel - calculo 'por dentro'
//             baseicms:= roundvalor( totalitem / ( (100-Q.fieldbyname('moes_peracres').ascurrency)/100) ) ;
// 18.03.2021 - Novicarens - Isonel - calculo 'por dentro' colocado aqui . estava fixo somente
//              do 'jeito isonel'
               if Global.Topicos[1471] then
                  baseicms:= roundvalor( totalitem / ( (100-Q.fieldbyname('moes_peracres').ascurrency)/100) )
               else
                  baseicms:= baseicms + roundvalor( totalitem * (Q.fieldbyname('moes_peracres').ascurrency/100) ) ;

        end;
////////////////////////////
//        vlripi:=baseicms*(Q1.fieldbyname('move_aliipi').ascurrency/100);
// 07.07.11 - para prever notas em que soma o ipi na base do icms
//        vlripi:=totalitem*(Q1.fieldbyname('move_aliipi').ascurrency/100);
// 24.08.16 - considerando o desconto dado
// 24.06.19 - rolo devolucao importacao seip
        if ( Q.fieldbyname('moes_estado').asstring='EX' )  and (cEs='E') then

           vlripi:=( totalitem - roundvalor( totalitem * (Q.fieldbyname('moes_perdesco').ascurrency/100) ) + valorII  ) *
                   ( Q1.fieldbyname('move_aliipi').ascurrency/100)
        else

           vlripi:=( ( totalitem - roundvalor( totalitem * (Q.fieldbyname('moes_perdesco').ascurrency/100) )  ) *
                   ( Q1.fieldbyname('move_aliipi').ascurrency/100)  ) + valorII;

// 13.09.17 - Mettalum - complemento de ipi
        if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoIPI)>0 then
           vlripi:=Q.fieldbyname('moes_valoripi').ascurrency;

// 21.05.12 - Asatec
        if ( (Global.Topicos[1327]) and (ConsumidorFinal='S') ) OR
// 17.09.12 - Asatec
           ( (Global.Topicos[1327]) and (Q.fieldbyname('moes_tipomov').asstring=Global.CodDevolucaoIgualVenda) ) then
          baseicms:=baseicms+vlripi
// aqui ver se soma ipi na base do item cfe topico do sistema
        else if ( Global.Topicos[1350] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,TiposDevolucao)>0 ) then

           baseicms:=baseicms+vlripi;

        redubase:=FCodigosFiscais.GetAliquotaRedBase( FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,
                    Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
// 28.05.12 - Asatec
        if ( Q.fieldbyname('moes_estado').asstring='EX' )  and (cEs='E') then begin

          if Q1.fieldbyname('move_aliicms').ascurrency>0 then begin

//            baseicms:=( baseicms/(1-(Q1.fieldbyname('move_aliicms').ascurrency/100)) );
// 23.11.20
            baseicms := Q1.fieldbyname('move_baseicms').ascurrency;
            baseicmssemreducao:=baseicms;

          end;
          redubase:= Q1.fieldbyname('move_redubase').ascurrency;
          if redubase>0 then begin
            baseicms:=(baseicms*(redubase/100));
          end;

        end else if (redubase >0 ) then begin

          baseicms:=(baseicms*(redubase/100));

        end;
//        vlricms:=baseicms*(Q1.fieldbyname('move_aliicms').ascurrency/100);
// 19.04.16 - nota da novi...
//        vlricms:=FGEral.arredonda( baseicms*(Q1.fieldbyname('move_aliicms').ascurrency/100) ,2 );

        vlricms:=FGEral.arredonda( baseicms*(Q1.fieldbyname('move_aliicms').ascurrency/100) ,3 );

 //       vlricms:=FGEral.arredonda( baseicms*(Q1.fieldbyname('move_aliicms').ascurrency/100) ,4 );

// 30.01.12 = Clessi
       if (vlricms=0)
          and
// 22.02.2021
          ( AnsiPos(Q1.fieldbyname('moes_tipomov').asstring,Global.CodNFeComplementoIcms+';'+
                    Global.CodNfeComplementoValorProdutor  ) = 0 )
          then

          baseicms:=0;

// 24.06.19 - Novicarnes - complemento de icms saida
//       if (vlricms>0) and (Q1.fieldbyname('moes_tipomov').asstring=Global.CodNFeComplementoIcms)
//          then baseicms:=0;

// 25.05.2018 - Vida Nova + Leila - 24.06.19 - retirado - Novicarnes
//       if (Q1.fieldbyname('moes_tipomov').asstring =Global.CodNFeComplementoIcms) then
//           vlricms:=totalitem;

          with  Det.Add do
          begin
// 06.02.12 - cfop de subst. tributaria
            if ( pos(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring,'S;2') > 0 ) then

//              Prod.CFOP     :=GetCfopItem(Q1.FieldByName('move_cst').asstring,Q1.FieldByName('move_transacao').asstring,
//                              Q1.FieldByName('moes_natf_codigo').asstring,Q1.FieldByName('moes_tipomov').asstring,
//                              cfopind,Q1.FieldByName('esto_cipi_codigo').asinteger,'S')
// 07.10.20
              Prod.CFOP     :=GetCfopItem(Q1.FieldByName('move_cst').asstring,Q1.FieldByName('move_transacao').asstring,
                              copy(Q1.FieldByName('moes_natf_codigo').asstring,1,4),Q1.FieldByName('moes_tipomov').asstring,
                              cfopind,Q1.FieldByName('esto_cipi_codigo').asinteger,'S')
            else
// 07.10.20 - NOvicarnes
//              Prod.CFOP     :=GetCfopItem(Q1.FieldByName('move_cst').asstring,Q1.FieldByName('move_transacao').asstring,
//                              Q1.FieldByName('moes_natf_codigo').asstring,Q1.FieldByName('moes_tipomov').asstring,
//                              cfopind,Q1.FieldByName('esto_cipi_codigo').asinteger,'N',Q1.FieldByName('move_natf_codigo').asstring);
              Prod.CFOP     :=GetCfopItem(Q1.FieldByName('move_cst').asstring,Q1.FieldByName('move_transacao').asstring,
                              copy(Q1.FieldByName('moes_natf_codigo').asstring,1,4),Q1.FieldByName('moes_tipomov').asstring,
                              cfopind,Q1.FieldByName('esto_cipi_codigo').asinteger,'N',Q1.FieldByName('move_natf_codigo').asstring);
// 28.12.2022 - Vida Nova
              if Length(trim(Prod.CFOP))>4 then Prod.CFOP := copy(prod.CFOP,1,4);

// 16.08.18
//            if Global.Topicos[1455] then Prod.Cfop:=Q1.FieldByName('move_natf_codigo').asstring;
// 07.10.20 - NOvicarnes
            if Global.Topicos[1455] then Prod.Cfop:=copy(Q1.FieldByName('move_natf_codigo').asstring,1,4);
// 12.08.19 - 30.08.19
            if ( Ansipos(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring,'S;2') = 0 )
//                and ( Ansipos(Q1.FieldByName('move_tipomov').asstring,Global.CodTransfSaida) = 0 )
                and  ( Sistema.Hoje >= Texttodate('02092019') )
            then begin

// 29.12.19 - 06.04.20 - Seip...
              if (cES = 'E') or (q1.fieldbyname('move_natf_codigo').asstring='7949') then begin

                 Prod.cBenef    :=  FSitTributaria.GetcbenefporCST( q1.fieldbyname('move_cst').asstring,
                                          cES )

              end else begin

 // 20.02.20 - Novicarnes
                 if Global.Topicos[1239] then begin

                   Prod.cBenef    :=  FCodigosIPI.Getcbenef( FEstoque.GetCodigoIPINCM( q1.fieldbyname('move_esto_codigo').asstring ) );
// 28.02.20
                   if trim(Prod.cBenef)='' then
                      Prod.cBenef    :=  FSitTributaria.Getcbenef( FEstoque.GetCodigosituacaotributaria( q1.fieldbyname('move_esto_codigo').asstring,
                                          q1.fieldbyname('move_unid_codigo').asstring,
                                          Q.fieldbyname('moes_estado').asstring,'N',
                                          Q.fieldbyname('moes_tipo_codigo').asinteger,
                                          Q.fieldbyname('moes_tipomov').asstring ) );

                 end else

                   Prod.cBenef    :=  FSitTributaria.Getcbenef( FEstoque.GetCodigosituacaotributaria( q1.fieldbyname('move_esto_codigo').asstring,
                                          q1.fieldbyname('move_unid_codigo').asstring,
                                          Q.fieldbyname('moes_estado').asstring,'N',
                                          Q.fieldbyname('moes_tipo_codigo').asinteger,
                                          Q.fieldbyname('moes_tipomov').asstring ) );

              end;

            end;

            Prod.cProd     := Q1.fieldbyname('move_esto_codigo').asstring;

//            Prod.xProd     :=Ups(Q1.fieldbyname('esto_descricao').asstring);
// 30.07.10 - Abra '/' no nome do produto
            Prod.xProd     := Ups(Q1.fieldbyname('esto_descricao').asstring);
// 05.07.10 - Clessi
            if Global.Topicos[1310] then

               Prod.xProd :=Ups(Q1.fieldbyname('esto_descricao').asstring+' '+
                            Q1.fieldbyname('Core_descricao').AsString+' '+
                            Q1.fieldbyname('Tama_descricao').AsString)
// 05.11.19 - Novicarnes  - Isonel + Vagner
            else if ( Global.Topicos[1369] ) and ( Global.Topicos[1238] ) then

               Prod.xProd :=copy( Ups(Q1.fieldbyname('esto_descricao').asstring)+
                            ' ('+FGrupos.GetDescricao( Q1.fieldbyname('esto_grup_codigo').asinteger)+')' ,1,40)+
                            Q1.fieldbyname('move_pecas').AsString+' PC'

// 17.10.13 - Novicarnes
            else if Global.Topicos[1369] then

               Prod.xProd :=copy(Ups(Q1.fieldbyname('esto_descricao').asstring)+
                            replicate('.',40-length(trim(Q1.fieldbyname('esto_descricao').asstring))),1,40)+
                            Q1.fieldbyname('move_pecas').AsString+' PC';


            if Q1.fieldbyname('move_qtde').asfloat<0 then begin

              Prod.qCom    := Q1.fieldbyname('move_qtde').asfloat*(-1);
              Prod.qTrib   := Q1.fieldbyname('move_qtde').asfloat*(-1);

// 22.02.2021 - Vida Nova
            end else if Ansipos( Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoValorProdutor ) > 0 then begin

                Prod.qCom    := 0;
                Prod.qTrib   := 0;

// 28.12.2022 - Vida Nova
            end else if Ansipos( Q.fieldbyname('moes_tipomov').asstring,Global.CodComplementoValorS ) > 0 then begin

                Prod.qCom    := 0;
                Prod.qTrib   := 0;

            end else begin

                Prod.qCom    := Q1.fieldbyname('move_qtde').asfloat;
                Prod.qTrib   := Q1.fieldbyname('move_qtde').asfloat;

            end;
// 19.03.20
              if ListaItens01.count>0 then begin

                 if ListaItens01.indexof( Q1.fieldbyname('move_esto_codigo').asstring ) >=0  then begin

                    ListaItens02a:=TStringList.Create;
                    strtolista(Listaitens02a,Listaitens02[ListaItens01.indexof( Q1.fieldbyname('move_esto_codigo').asstring )] ,';',true);
                    Prod.qCom    := Q1.fieldbyname('move_qtde').asfloat - Texttovalor(ListaItens02a[0]);
                    Prod.qTrib   := Q1.fieldbyname('move_qtde').asfloat - Texttovalor(ListaItens02a[0]);
                    ListaItens02a.Free;

                 end;

              end;


// 06.04.20 - mudado pra c�..era mais abaixo...
            Prod.NCM     := FEstoque.GetNCMipi(Q1.fieldbyname('move_esto_codigo').asstring);
            Prod.uCom    := ConverteUnidadeProduto( Q1.fieldbyname('esto_unidade').asstring,Prod.NCM );
            Prod.uTrib   := ConverteUnidadeProduto(Q1.fieldbyname('esto_unidade').asstring,Prod.NCM );

// 07.02.23 - Devereda
            if Global.topicos[1242] then begin

              if ( Q1.Fieldbyname('move_tama_codigo').asinteger>0 )
                 and
                 ( Q1.Fieldbyname('move_core_codigo').asinteger>0 )
               then begin

                 Qg := sqltoquery('select esgr_unidade from estgrades where' +
                      ' esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(Q1.Fieldbyname('move_esto_codigo').asstring)+
                      ' and esgr_unid_codigo='+stringtosql(Q1.Fieldbyname('move_unid_codigo').asstring)+
                      ' and esgr_tama_codigo='+inttostr(Q1.Fieldbyname('move_tama_codigo').asinteger)+
                      ' and esgr_core_codigo='+inttostr(Q1.Fieldbyname('move_core_codigo').asinteger));
                 if not Qg.eof then begin

                    if trim(Qg.fieldbyname('esgr_unidade').asstring)<>'' then begin

                       Prod.uCom    := ConverteUnidadeProduto( Qg.fieldbyname('esgr_unidade').asstring,Prod.NCM );
                       Prod.uTrib   := ConverteUnidadeProduto(Qg.fieldbyname('esgr_unidade').asstring,Prod.NCM );

                    end;

                 end;
                 Qg.close;

               end;

            end;
            Prod.vProd   := totalitem;
// 10.10.19 - Mirvane - 'devolucao complemento de icms'
           if Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoIcms ) > 0 then
              Prod.vProd   := 0;

// 25.04.17 - clessi - detalhe ref. exportacao indireta cfop 7501
//             depois ver como tratar isto
            if pos(Prod.CFOP,'7501') > 0 then begin

              with Ide.NFref.Add do begin
                refNFe:=Q.fieldbyname('moes_chavenferef').asstring;
              end;
              with Prod.detExport.Add do begin
                chNFe:=Q.fieldbyname('moes_chavenferef').asstring;
                qExport:=Q1.fieldbyname('move_qtde').asfloat;
//                nRE:='17061853900';
              end;

            end;
// 18.05.11 - rateio do desconto pelos itens - ver se faz o mesmo com frete+seguro
            if ( Q.fieldbyname('moes_perdesco').ascurrency>0 ) OR ( valordesc<>0 ) then begin
// 17.11.15
//               ( Q.fieldbyname('moes_funrural').AsCurrency>0 ) then begin
              xmoes_perdesco:=Q.fieldbyname('moes_perdesco').ascurrency;
// 28.07.16
              if xmoes_perdesco=0 then xmoes_perdesco:= (valordesc/(Q.fieldbyname('moes_totprod').ascurrency+valordesc) )*(100) ;
//              if Q.fieldbyname('moes_funrural').AsCurrency>0 then
//                xmoes_perdesco:=((Q.fieldbyname('moes_funrural').AsCurrency+moes_vlrgta+Q.fieldbyname('moes_cotacapital').ascurrency)/Q.fieldbyname('moes_vlrtotal').AsCurrency)*100;

              Prod.vUnCom  := Q1.fieldbyname('move_venda').asfloat;
              Prod.vUnTrib := Q1.fieldbyname('move_venda').asfloat;
// 19.03.20   - devereda - desconto e retornos...
              if ListaItens01.count>0 then begin

                 if ListaItens01.indexof( Q1.fieldbyname('move_esto_codigo').asstring ) >=0  then begin

                    ListaItens02a:=TStringList.Create;
                    strtolista(Listaitens02a,Listaitens02[ListaItens01.indexof( Q1.fieldbyname('move_esto_codigo').asstring )] ,';',true);
                    Prod.vUnCom    := Prod.vProd/Prod.qCom;
                    Prod.vUnTrib   := Prod.vProd/Prod.qCom;
                    ListaItens02a.Free;

                 end;

              end;

// 10.10.19 - Mirvane - 22.02.2021 - Vida Nova
              if Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoIcms+';'+
                         Global.CodNfeComplementoValorProdutor ) > 0
              then begin

                Prod.vUnCom  := 0;
                Prod.vUnTrib := 0;

              end;

// 30.05.11 - VC com desconto
//              Prod.vDesc   := totalitem * roundvalor(Q.fieldbyname('moes_perdesco').ascurrency/100) ;
//              Prod.vDesc   := roundvalor( totalitem * (Q.fieldbyname('moes_perdesco').ascurrency/100) ) ;
// 22.04.15 - Fama
//              Prod.vDesc   := ( totalitem * (Q.fieldbyname('moes_perdesco').ascurrency/100) ) ;
// 11.05.15 - Fama..de novo....
             if seq=Q1.RecordCount then begin

// 19.03.20
                if (vlrdesco >= totdescitens) and ( (vlrdesco-FGeral.Arredonda(totdescitens,2))>0 ) then begin

                   Prod.vDesc   := vlrdesco-FGeral.Arredonda(totdescitens,2);
                   totdescitens:=totdescitens + Prod.vdesc;

                end;

// 22.09.2022 - Receita nao permite gerar tag vdesc zerada
//                else

//                   Prod.vDesc   := 0;

             end else if Q1.fieldbyname('move_qtde').asfloat>0 then

// 22.09.2022 - Receita nao permite gerar tag vdesc zerada
//                Prod.vDesc  = FGeral.Arredonda(totalitem *  (xmoes_perdesco/100),2 ) ;
                if FGeral.Arredonda(totalitem *  (xmoes_perdesco/100),2 ) > 0 then begin

                   Prod.vDesc  := FGeral.Arredonda(totalitem *  (xmoes_perdesco/100),2 ) ;
                   totdescitens:=totdescitens + Prod.vdesc;

                end;

//              Prod.vDesc   := totalitem * FGeral.Arredonda( (Q.fieldbyname('moes_perdesco').ascurrency/100),4 ) ; 122,71..
//              Prod.vDesc   := totalitem * FGeral.Arredonda( (Q.fieldbyname('moes_perdesco').ascurrency/100),3 ) ;  122,83
//              Prod.vDesc   := totalitem * FGeral.Arredonda( (Q.fieldbyname('moes_perdesco').ascurrency/100),5 ) ;  122,6937
//              Prod.vDesc   := FGeral.Arredonda( totalitem *  (Q.fieldbyname('moes_perdesco').ascurrency/100),3 ) ;  // 122,702

//              Prod.vDesc   := FGeral.Arredonda( totalitem8 *  (Q.fieldbyname('moes_perdesco').ascurrency/100),4 ) ;  122,6997

//                Prod.vDesc   :=   fGeral.Arredonda( totalitem * ((vlrdesco/Q.fieldbyname('moes_totprod').ascurrency)) ,4)  ;
//              aux          :=  Formatfloat('###,###.####',Prod.vDesc)  ;
//              aux          :=  copy( aux,pos(',',aux)+1,2)  ;
//              Prod.vDesc   :=  Int(Prod.vDesc)+  ( Strtocurr( aux )/100 );
// 28.07.16 - Devereda

            end else begin

// 07.08.13 - NP - Novicarnes com d�zima no valor unitario do kilo
//              if Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor then begin
// 18.06.14 - Novicarnes - transferencias da fazenda (002) para novi (001) usando romaneio da 001
              if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodTransfSaida)>0 then begin

                Prod.vUnCom  := Q1.fieldbyname('move_venda').asfloat;
                Prod.vUnTrib := Q1.fieldbyname('move_venda').asfloat;
// 01.04.2015 - novicanres - xml 3.10 - nao aceita total da nf menor q o de produtos
//                if informainss=0 then begin
//                  Prod.vDesc:=Q.fieldbyname('moes_funrural').asfloat+Q.fieldbyname('moes_cotacapital').ascurrency+moes_vlrgta;
//                  informainss:=Q.fieldbyname('moes_funrural').asfloat+Q.fieldbyname('moes_cotacapital').ascurrency+moes_vlrgta;
//                end;
// 17.11.15 - retirado para ratear pelos produtos da nota...coorlaf
                if seq=Q1.RecordCount then begin
// 02.12.15 -
                   if (Total.ICMSTot.vDesc>=totdescitens) and ( (Total.ICMSTot.vDesc-totdescitens)>0  ) then
                     Prod.vDesc   := Total.ICMSTot.vDesc-totdescitens;
//                   else
// 22.09.2022 - Receita nao permite gerar tag vdesc zerada
//                     prod.vDesc   :=0;

                end else
//                   Prod.vDesc   := FGeral.Arredonda(totalitem *  (((Total.ICMSTot.vDesc/Total.ICMSTot.vNF)*100)/100),2 ) ;
//                   Prod.vDesc   := FGeral.Arredonda(totalitem *  (((Total.ICMSTot.vDesc/Total.ICMSTot.vProd)*100)/100),2 ) ;
                   if FGeral.Arredonda(totalitem *  (xmoes_perdesco/100),2 ) > 0 then
                      Prod.vDesc  := FGeral.Arredonda(totalitem *  (xmoes_perdesco/100),2 ) ;

                totdescitens:=totdescitens + Prod.vdesc;

              end else begin
// 30.05.12 - Asatec
//                Prod.vUnCom  := Q1.fieldbyname('move_venda').ascurrency;
//               Prod.vUnTrib := Q1.fieldbyname('move_venda').ascurrency;
// 06.09.16
                Prod.vUnCom  := Q1.fieldbyname('move_venda').asfloat;
                Prod.vUnTrib := Q1.fieldbyname('move_venda').asfloat;
// 10.10.19 - Mirvane
//                if Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoIcms ) > 0 then begin
                if Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoIcms+';'+
                         Global.CodNfeComplementoValorProdutor ) > 0
                  then begin

                     Prod.vUnCom  := 0;
                     Prod.vUnTrib := 0;
                  end;

              end;

            end;

// 29.08.11 - rateio do acrescimo pelos itens - ver se faz o mesmo com frete+seguro
            if Q.fieldbyname('moes_peracres').ascurrency>0 then begin

              if Q1.fieldbyname('move_qtde').asfloat>0 then begin

//                if (vlracres <= totacreitens) and ( (FGeral.Arredonda(totacreitens-vlracres,2))>0 ) then begin
//
//                   Prod.vOutro   := FGeral.Arredonda(totacreitens-vlracres,2);
//                   totacreitens  := 0// para nao entrar mais aqui... vamos ver se nao pode mais nem somar...
//                end else
// 18.12.2022 - tentar jogar o acrescimo somente em um item...sem ratear por todos
                if (vlracres > 0) and (xmoes_peracres<1) then begin

                    if totalitem>=vlracres then  begin
                       Prod.vOutro:=vlracres;
                       vlracres:=0;
                    end;

                end else if (vlracres > 0) and (xmoes_peracres>1) then

//                  Prod.vOutro  := FGeral.Arredonda(totalitem *  (Q.fieldbyname('moes_peracres').ascurrency/100),2 ) ;
                  Prod.vOutro  := totalitem * (xmoes_peracres/100) ;
//                  Prod.vOutro  := totalitem * FGeral.Arredonda( Q.fieldbyname('moes_peracres').ascurrency,2)/100 ;
              end;

              totacreitens:=totacreitens + Prod.voutro;

/// /////////////////////////
            end;

// 11.11.13 - Metalforte - Devolucao tributada joga ipi no desp. acessoria

           if Despacessorias>0 then begin

//                Prod.vOutro   := (totalitem * despacessorias)/Q.fieldbyname('moes_totprod').ascurrency
// 16.12.2022 - retirado pra ratear o acrescimo de outra forma igual faz com desconto
// 14.05.18 - complemento de icms - supondo ter somente o item 'complemento de icms'...
// 28.08.19 - complemento de IPI - supondo ter somente o item 'complemento de ipi'...
//              if AnsiPos( Q.FieldByName('moes_tipomov').AsString,Global.CodNfeComplementoIcms+';'+Global.CodNfeComplementoIPI ) > 0  then
// 01.03.2023 - Guiber
              if AnsiPos( Q.FieldByName('moes_tipomov').AsString,Global.CodNfeComplementoIcms+';'+Global.CodNfeComplementoIPI+';'+TiposDevolucao ) > 0  then

                Prod.vOutro   := despacessorias;

           end;

/////////////////////////
            Prod.cEAN    := GetCodigoBarra(Q1.fieldbyname('move_esto_codigo').asstring);
            Prod.cEANTrib:= Prod.cEAN;
// caso tiver ean diferente para a unidade 'normal' e a unidade comercializada
//          tipo ean pro produto 'unitario' e o produto vendido em caixa
// 06.08.18
            if trim( Prod.cEAN ) = '' then begin
               Prod.cEAN    := 'SEM GTIN';
               Prod.cEANTrib:= 'SEM GTIN';
            end;
// 23.04.2021 - Vida Nova - exigencia da 'Sadia'
            if (Global.Topicos[1429]) and ( Q.fieldbyname('moes_pedido').asinteger>0 ) then

                Prod.xped := inttostr(Q.fieldbyname('moes_pedido').asinteger);

            Prod.nItem   := seq;
// 30.05.12 - Simar
            if ( Q.fieldbyname('moes_frete').ascurrency>0 ) and ( Q.fieldbyname('moes_totprod').ascurrency>0 ) then begin

//              Prod.vFrete  := totalitem * (Q.fieldbyname('moes_frete').ascurrency/Q.fieldbyname('moes_totprod').ascurrency);

              Prod.vFrete  := FGEral.arredonda(totalitem * (Q.fieldbyname('moes_frete').ascurrency/Q.fieldbyname('moes_totprod').ascurrency),2);

// 19.06.12 - Simar  - caso no rateio valor for 'muito pequeno' na cabe em duas casas decimais
//            ficando zero dai sefa nao aceita item sem rateio do frete...
//              if FGeral.Arredonda( Prod.vFrete,2 ) = 0 then Prod.vFrete:=0.01;
// 30.01.2022 - tirado
// 10.09.15

              if Q1.RecordCount=seq then begin
//                Prod.vfrete:=q.fieldbyname('moes_frete').ascurrency-(vtotalfreteitens-(totalitem * (Q.fieldbyname('moes_frete').ascurrency/Q.fieldbyname('moes_totprod').ascurrency) ));
                Prod.vfrete:=q.fieldbyname('moes_frete').ascurrency-(vtotalfreteitens);
              end;

// 30.01.2022 - guiber -> floripa - se n�o tem icms n�o rateia o frete
// 02.02.2023 - rateia devido ao custo
//              if Q1.fieldbyname('move_aliicms').ascurrency  = 0 then
//                 Prod.vFrete := 0;

              vtotalfreteitens:=vtotalfreteitens+Prod.vFrete;
// 23.10.12 - Asatec - 30.01.23 - s� se tem icms - caso 'guiber -> floripa'
              if Q1.fieldbyname('move_aliicms').ascurrency > 0 then begin

//                baseicms:=baseicms+Prod.vFrete;
// 03.02.2023 - nao soma o valor do frete mas sim aplica o percenual...
                if Q.fieldbyname('moes_totprod').ascurrency>0 then

                  baseicms:=baseicms + ( baseicms*(((Q.fieldbyname('moes_frete').ascurrency/Q.fieldbyname('moes_totprod').ascurrency))) );

                vlricms:=baseicms*(Q1.fieldbyname('move_aliicms').ascurrency/100);

              end else begin

                vlricms:=0;
                baseicms:=0;
/////////////////////////

              end;
/////////////////////////
            end;

//            Prod.NCM     := FEstoque.GetNCMipi(Q1.fieldbyname('move_esto_codigo').asstring);

// 26.03.16   // ver do simples com 900 somente se vicmsst . 0
//           if pos( Q1.fieldbyname('move_cst').asstring,'010/030/060/070/090/201/202/203/500/') >0 then
// 26.03.18 - em testes exigiu cest de cosn 103
             Prod.CEST:=FEstoque.GetCESTNCM(Q1.fieldbyname('move_esto_codigo').asstring);
// 18.04.19 - Giacomoni - Barbar�  - cliente com 'sistema exigindo'...
            if Global.Topicos[1459] then Prod.xPed:=Q.fieldbyname('moes_romaneio').asstring;

// 12.01.12 - dados da DI - nota de importa��o
            if temdi then begin
              with Prod.DI.Add do begin
                nDi:=Q.fieldbyname('moes_numerodi').asstring;
                xLocDesemb:=Q.fieldbyname('moes_localdesen').asstring;
                dDi:=Q.fieldbyname('moes_dtregistro').asdatetime;
                dDesemb:=Q.fieldbyname('moes_dtdesen').asdatetime;
                UFDesemb:=Q.fieldbyname('moes_ufdesen').asstring;
                cExportador:=Q.fieldbyname('moes_tipo_codigo').asstring;
                with adi.Add do begin
                  nAdicao:=seq;
                  nSeqAdi:=seq;
                  cFabricante:=Q.fieldbyname('moes_tipo_codigo').asstring;
                  vDescDI:=0;
                end;
              end;
            end;
///////////
// 27.06.11
            if ( ( Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1Asinteger('ConfNfComple') )
               and ( FGeral.GetConfig1Asinteger('ConfNfComple')>0 ) )
               or
// 30.01.15
               ( ( Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1Asinteger('NfCompleentrada') )
               and (FGeral.GetConfig1Asinteger('NfCompleentrada')>0) )
// 17.03.15
               or
//               (  Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoQtde+';'+Global.CodNfeComplementoIcms+';'+
// 11.07.18 - rolo Sollo Sul -> Novicarnes
               (  Ansipos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoIcms+';'+
                      Global.CodNfeComplementoIPI)>0 )
// 28.07.16 - Devereda
              or
                ( Q1.fieldbyname('move_qtde').ascurrency<0)
              then
                Prod.IndTot:=itNaoSomaTotalNFe;

            with Imposto do
            begin

//              if Q1.fieldbyname('move_aliicms').ascurrency=0 then begin
              if FNotaSaida.Servico(Q1.fieldbyname('move_esto_codigo').asstring) then begin
                with ISSQN do
                begin
                    vAliq := FEstoque.GetaliquotaIss(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,global.UFUnidade);
                    vIssQn :=  vBC*(vAliq/100);
                    vBC   := baseicms;
                    cMunFG := strtoint(codmuni) // codigo do municipio do Fator Gerador
                                               //  ver se precisa ser do cliente...
                end;
                with ICMS do  // senao fica com valores na coluna de icms
                begin
                    pICMS := 0;
                    vICMS := 0;
                    vBC   := 0;
                    pRedBC:= 0;
                end;
//                vTotTrib:=CalculaImpostoAproximado()
// 10.06.13 - ver como tratar o 'NBS' - codigo de servi�os

              end else begin

                with ICMS do
                begin

    //               Det.Add.Imposto.ICMS.CST.  :=
    //                CST   := Q1.fieldbyname('move_cst').asstring;
//                    if pos(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring,'S;2') > 0 then begin
// 16.01.12 - nao tinha previsto empresa do simples e nota de produtor
                    if ( pos(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring,'S;2') > 0 )
//                       and
//                       ( pos(copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1),'5;6;7')>0 )
                       then begin

                       CSOSN := GetCstSimples(Q1.fieldbyname('move_cst').asstring);
                       orig  :=  GetOrigemMercadoria(Q1.fieldbyname('move_cst').asstring,'S');
// 25.04.13 - devolucao pra quem precisa se creditar do icms
                       if ( Ansipos(Q1.fieldbyname('move_tipomov').asstring,TiposDevolucao)>0 )
                          or
// 16.10.20 - Guiber - Nfe de cancelamento de frete usando tipo VJ
                          (  Q1.fieldbyname('move_tipomov').asstring = Global.CodVendaFornecedor )
                       then begin
//                          if Q1.fieldbyname('move_cst').asstring='101' then begin
//                            pCredSN := Q1.fieldbyname('move_aliicms').ascurrency;
//                          vCredICMSSN := vlricms;
// assim a sefa nao autoriza..com coosn 101 continua dando dif. de base de calculo - tentado 900
//                          end else begin
//                       and

// 08.11.2022 - Alutech - Devolucao com icms diferido reduzindo a base
                           if Q1.fieldbyname('move_redubase').ascurrency>0 then begin

                              if Q1.fieldbyname('move_sitt_codigo').asinteger>0 then begin

                                if FSittributaria.GetCF(Q1.fieldbyname('move_sitt_codigo').asinteger) = '3' then begin

//                                  vBC   := baseicms*(Q1.fieldbyname('move_redubase').ascurrency/100);
//                                  vBC   := baseicms*((100-Q1.fieldbyname('move_redubase').ascurrency)/100);
                                  vBC      := baseicms;
                                  pICMS    := Q1.fieldbyname('move_aliicms').ascurrency;
                                  vlricms  := FGeral.Arredonda(baseicms*((Q1.fieldbyname('move_aliicms').ascurrency-(Q1.fieldbyname('move_aliicms').ascurrency*(Q1.fieldbyname('move_redubase').ascurrency/100)))/100),2);
                                  vICMS    := vlricms;
//                                  pDif     := Q1.fieldbyname('move_redubase').ascurrency;
//                                  vICMSDif := FGeral.Arredonda(baseicms*(Q1.fieldbyname('move_aliicms').ascurrency/100),2) - vlricms;
//                                  vICMSOp  := FGeral.Arredonda(baseicms*(Q1.fieldbyname('move_aliicms').ascurrency/100),2);
//                                  modBC    := dbiValorOperacao;
// sai icms menor...
                                  modBC    := dbiValorOperacao;
//                                  pRedBC   := 100-(Q1.fieldbyname('move_redubase').ascurrency);
//                                  pRedBC   := (Q1.fieldbyname('move_redubase').ascurrency);

                                end else begin
// 23.02.2023 - Devolucao Olstri com redu��o de base......a outra 'de cima' � pela dif. de valores sem reduzir a base
                                    vBC   := baseicms*(Q1.fieldbyname('move_redubase').ascurrency/100);
                                    pICMS    := Q1.fieldbyname('move_aliicms').ascurrency;
                                    modBC    := dbiValorOperacao;
                                    vlricms  := FGeral.Arredonda(vBC*(pICMS/100),2);
                                    vICMS    := vlricms;
                                end;

                              end;

                           end else begin

                             pICMS := Q1.fieldbyname('move_aliicms').ascurrency;
                             vICMS := vlricms;
                             vBC   := baseicms;

                           end;

                       end;

// 08.03.14 - Empresa do Simples sujeita a ST
                       margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring));
// 08.08.18
                       if (Q.fieldbyname('moes_tipocad').asstring='C') then begin

                          if QDesti.fieldbyname('clie_consfinal').asstring='R' then

                             margemlucro:=FCodigosFiscais.GetPercBaseSubs( FSubGrupos.GetCodigoFiscal(Q1.fieldbyname('moes_natf_codigo').asstring,Q1.fieldbyname('move_sugr_codigo').asinteger) )

                          else begin
// 08.07.19
                             if QDesti.fieldbyname('clie_contribuinte').asstring='2' then
                                 margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring))
                             else
                                 margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring));

                          end;

                       end;

// 17.12.16 - Zilmar - venda a consumidor final( Jur ou Fis )
                       if consumidorfinal='S' then margemlucro:=0;
// 05.02.18 - Zilmar - devolucao de venda com nf propria nao calcula ST
                       if Q.FieldByName('moes_tipomov').AsString=Global.CodDevolucaoIgualVenda then margemlucro:=0;

// 11.07.16 - Zilmar - ST
                       if (Q.fieldbyname('moes_tipocad').asstring='C') and ( margemlucro>0) then begin
                         if QDesti.fieldbyname('clie_contribuinte').asstring='2' then
                            margemlucro:=FCodigosFiscais.GetPercBaseSubs(FSubGrupos.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,FEstoque.GetSubGrupo(Q1.fieldbyname('move_esto_codigo').asstring)))
                         else if QDesti.fieldbyname('clie_contribuinte').asstring='1' then
                            margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring));
                       end;
////////////////////////////////////////////
// 18.02.20 - Vida Nova em nota de transferencia de icms
                       if margemlucro>0 then

                          basesubs:=( totalitem*(1+(margemlucro/100)) )

                       else

                          basesubs:=0;

// 06.08.18 - Zilmar
                       basesubs:= FGeral.Arredonda( basesubs,2 );
// 04.09.18 - Zilmar
                       icmsitemsubs :=0;

// 12.12.15
// 17.10.16 - devolucao refinato gustao - retirado pois empresa do simple pode destacar ST em devolucoes..
                       if (  pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada) > 0 ) then begin
//                         basesubs:=TextToValor( GetBaseST );
//                         icmsitemsubs:=TextToValor( GetValorST );
//                         margemlucro:=1;  // s� pra gerar as tags de ST..
                         basesubs:=0;
                         icmsitemsubs:=0;
                         margemlucro:=0;

                       end else begin

//                       icmsitemsubs:=(totalitem*(1+(margemlucro/100))) * (Q1.fieldbyname('move_aliicms').ascurrency/100);
// 29.10.14 - giacomoni+asterio
//                         icmsitemsubs:=(totalitem*(1+(margemlucro/100))) * (FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring)/100);
// 08.08.18
                         if (Q.fieldbyname('moes_tipocad').asstring='C') then begin

                            if QDesti.fieldbyname('clie_consfinal').asstring='R' then
                               icmsitemsubs:=(totalitemliquido*(1+(margemlucro/100))) *
                               ( FCodigosFiscais.GetAliquota( FSubgrupos.GetCodigoFiscal( Q.fieldbyname('moes_natf_codigo').asstring,Q1.FieldByName('move_sugr_codigo').AsInteger) )/100 )
// 04.09.18 - Zilmar
                            else begin

                               icmsitemsubs:=(totalitemliquido*(1+(margemlucro/100))) * (FEstoque.Getaliquotaicms(Q1.fieldbyname('move_esto_codigo').asstring,Global.CodigoUnidade,Global.UFUnidade)/100);
// 08.07.19 - Vini rotta
                               if campoicmsst.tipo<>''  then
                                   icmsitemsubs:=FGeral.arredonda( ((totalitemliquido)*(1+(margemlucro/100))) *
                                  ( FCodigosFiscais.GetPercIcmsSubs(
                                  FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)
                                    ) /100) ,2 );

                            end;

                         end else

// 22.07.16
                           icmsitemsubs:=(totalitem*(1+(margemlucro/100))) * (FEstoque.Getaliquotaicms(Q1.fieldbyname('move_esto_codigo').asstring,Global.CodigoUnidade,Global.UFUnidade)/100);
// 04.08.18
                         icmsitemsubs:= FGeral.Arredonda( icmsitemsubs,2 );

                         icmsitemsubs:=icmsitemsubs-vlricms;
// 04.09.18 - Zilmar
//                         if icmsitemsubs<0 then icmsitemsubs:=0;

////////////////////////                         icmsitemsubs:=Q.fieldbyname('moes_valoricmssutr').asfloat;

                       end;
// 17.11.15 - mirvane
                       if (margemlucro>0) and
//                          (  pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoQtde+';'+Global.CodNfeComplementoIcms) = 0 )
// 17.02.17 - Mirvane...complemento de devolucao de compra
                          (  pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoQtde) = 0 )
                         then begin
                         modBCST:=dbisMargemValorAgregado;
                         vBCST:=basesubs;
// 02.09.19 - novas validacoes da receita
                         pMVAST :=margemlucro;
//                         pICMSST:=Q1.fieldbyname('move_aliicms').ascurrency;
// 08.12.15
//                         pICMSST:=FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring);
// 22.07.16 - pegar a aliquota do estado
                         pICMSST:=FEstoque.Getaliquotaicms(Q1.fieldbyname('move_esto_codigo').asstring,Global.CodigoUnidade,Global.UFUnidade);
// 08.07.19 - Vini rotta
//                        if campoicmsst.tipo<>''  then
//                           pICMSST:=FCodigosFiscais.GetPercIcmsSubs(
//                                  FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring));

                         vICMSST:=icmsitemsubs;
                         vICMS := vlricms;
                         vBC   := baseicms;

                      end;
{
// 31.03.20 - Guiber - venda com csosn de ST 500 estado de SC exige alguns campos ref. ST...
                      if       ( Ide.indFinal <> cfConsumidorFinal)
                          and ( Ide.modelo=55 )
                          and ( Csosn = StrToCSOSNIcms(ok,'500') )
                          and ( icmsitemsubs = 0 )
                          and ( Emit.CRT <> crtRegimeNormal ) then begin

                          vBCSTRet :=basesubs;
                          pST      :=0;
                          vICMSSubstituto := icmsitemsubs;
                          vICMSSTRet := 0;

                      end;
                      }
// aqui

// 02.02.16 - Difal - Vendas fora do estado para consumidor final
// 24.11.16 - Ajuste para Clessi para 'ajudar' cons.final ipi soma na base
// 20.04.18 - STF liberou empresas do simples a recolher o Difal mas h� estados q cobram
// 27.06.18 - Mirvane venda interestadual para MS para consumidor final n�o autorizou
//            tentado fazer para empresa do simples tbem
// 14.12.18 - cfop 5949/6949
// 14.12.18 - a2z - simples remessa para nao contribuinte fora do estado
// 27.05.19 - Seip - s� calcula se 'for venda' , aqui se gerar financeiro
// 11.06.19 - Seip - 'for venda' para eles � 's� fiscal' - VH - venda entrega..rolos
                       if (Ide.idDest=doInterestadual)
                          and ( Ide.indFinal=cfConsumidorFinal)
                          and ( Emit.CRT=crtRegimeNormal )
                          and ( Ide.modelo=55 )
                          // 29.01.20 - pra nao gerar este grupo em notas sem icms...Seip
                          and ( Q1.FieldByName('move_aliicms').AsCurrency>0)
                          and ( EContribuinte(Q.fieldbyname('moes_tipo_codigo').asstring,Q.fieldbyname('moes_tipocad').asstring)='N')
//                         and
//                         ( ( AnsiPos( Q.fieldbyname('moes_tipomov').asstring,Global.TiposGeraFinanceiro )>0 )
//                            or
//                            ( AnsiPos( Q.fieldbyname('moes_tipomov').asstring,Global.CodContratoEntrega )>0 )

                         then begin

                         xaliFPC:=GetAqliFCP(Q.fieldbyname('moes_estado').asstring);
// 27.09.19 - Polli
                         if Q.FieldByName('clie_tipo').AsString='F' then xalifpc:=0;
// aqui em 20.09.18
                         if DatetoAno(Q.fieldbyname('moes_dataemissao').asdatetime,true)=2016 then
                           ICMSUFDest.pICMSInterPart:=40
                         else if DatetoAno(Q.fieldbyname('moes_dataemissao').asdatetime,true)=2017 then
                           ICMSUFDest.pICMSInterPart:=60
                         else if DatetoAno(Q.fieldbyname('moes_dataemissao').asdatetime,true)=2018 then
                           ICMSUFDest.pICMSInterPart:=80
                         else if DatetoAno(Q.fieldbyname('moes_dataemissao').asdatetime,true)=2019 then
                           ICMSUFDest.pICMSInterPart:=100;

                         if  Emit.CRT=crtRegimeNormal then begin

                             ICMSUFDest.vBCUFDest:=baseicms;
                             ICMSUFDest.pFCPUFDest:=xaliFPC; // % fundo de combate a pobreza por estado ( SC,RS E SP ainda nao tem )
                             ICMSUFDest.pICMSUFDest:=FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring,
                                                                                      Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring);
{
                             if pos(Q.fieldbyname('moes_estado').asstring,'PR/SC/RS/SP/RJ/MG')>0 then
                               ICMSUFDest.pICMSInter:=12
                             else
                               ICMSUFDest.pICMSInter:=7;   // se for prod. importado seria 4%..revisar
}  // 04.12.18 - 'conserto' no calculo da Difal - usar a mesma aliquota destacada na nota
// 26.06.19 - ajustado para informar aliquota mesmo n�o calculando a difal
                             if Q1.FieldByName('move_aliicms').AsCurrency=0 then
                               ICMSUFDest.pICMSInter:=4
                             else
                               ICMSUFDest.pICMSInter:=Q1.FieldByName('move_aliicms').AsCurrency;
// 14.12.18 - 27.09.19 - polli mudou
//                         if  AnsiPos( copy(Q.FieldByName('moes_natf_codigo').AsString,2,3),'949' )>0  then begin
//
//                            basedifal:=0;
//                            ICMSUFDest.vFCPUFDest:=0 // valor do incentivo a pobreza
//
//                         end else

                            ICMSUFDest.vFCPUFDest:=baseicms*(xaliFPC/100);   // valor do incentivo a pobreza


    //                         ICMSUFDest.vICMSUFDest:=(FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring)/100)*
    //                                                  baseicms *(ICMSUFDest.pICMSInterPart/100) ;
    // 18.05.17
//                             ICMSUFDest.vICMSUFDest:=FGeral.Arredonda( (FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring)/100)*
//                                                      baseicms *(ICMSUFDest.pICMSInterPart/100) ,2 ) ;
// 20.09.19
//                             basedifal:= baseicms * ( FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring) - ICMSUFDest.pICMSInter  )/100 ;
// 01.02.19
                             basedifal:= baseicms * ( ICMSUFDest.pICMSUFDest - ICMSUFDest.pICMSInter  )/100 ;
                             ICMSUFDest.vICMSUFDest:= basedifal *(ICMSUFDest.pICMSInterPart/100)  ;
                             if DatetoAno(Q.fieldbyname('moes_dataemissao').asdatetime,true)>=2019 then
                               ICMSUFDest.vICMSUFRemet:=0
                             else
                               ICMSUFDest.vICMSUFRemet:= basedifal *((100-ICMSUFDest.pICMSInterPart)/100) ;

                         end else begin // caso for micro empresa

// 16.01.19 - retirado pra Janina..vamos ver se autoriza sem difal
(*
                             ICMSUFDest.vBCUFDest:=0;
                             ICMSUFDest.pFCPUFDest:=0; // % fundo de combate a pobreza por estado ( SC,RS E SP ainda nao tem )
                             ICMSUFDest.pICMSUFDest:=FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring);
 {
                             if pos(Q.fieldbyname('moes_estado').asstring,'PR/SC/RS/SP/RJ/MG')>0 then
                               ICMSUFDest.pICMSInter:=12
                             else
                               ICMSUFDest.pICMSInter:=7;   // se for prod. importado seria 4%..revisar
}
// 04.12.18 - 'conserto' calculo da Difal
                             ICMSUFDest.pICMSInter:=Q1.FieldByName('move_aliicms').AsCurrency;


                             ICMSUFDest.vFCPUFDest:=0;   // valor do incentivo a pobreza
                             ICMSUFDest.vICMSUFDest:=0;
//                             if DatetoAno(Q.fieldbyname('moes_dataemissao').asdatetime,true)>=2019 then
                               ICMSUFDest.vICMSUFRemet:=0;
//                             else
//                               ICMSUFDest.vICMSUFRemet:=(FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring)/100)*
//                                                      baseicms *((100-ICMSUFDest.pICMSInterPart)/100) ;
                              *)


                         end;


// 18.04.16
                         totalvFCPUFDest:=totalvFCPUFDest+ICMSUFDest.vFCPUFDest;
                         totalvICMSUFDest:=totalvICMSUFDest+ICMSUFDest.vICMSUFDest;
                         totalvICMSUFRemet:=totalvICMSUFRemet+ICMSUFDest.vICMSUFRemet;

                       end;

// 25.03.15 - xml 3.10 exige quando for CST ref. a ST
//                       vBCSTRet:=10;
//                       vICMSSTRet:=1;
//////////////////////////////////

//                    end else if ( pos(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring,'S;2') > 0 )
//                                 and
//                                ( pos(Q.fieldbyname('moes_tipomov').asstring,TiposNumeracaoSaida)=0 )
//                       then begin
//                      CSOSN := GetCstSimples(Q1.fieldbyname('move_cst').asstring);
//                      orig  :=  GetOrigemMercadoria(Q1.fieldbyname('move_cst').asstring,'S');

                    end else begin  // empresas 'NAO' do simples

                      CST   := GetCst(Q1.fieldbyname('move_cst').asstring);
                      pICMS := Q1.fieldbyname('move_aliicms').ascurrency;
// 02.09.19
                      modBC    :=dbiValorOperacao;

// 12.08.19 -
                      if (redubase>0) and ( AnsiPos(Q1.fieldbyname('move_cst').asstring,'020/030/040/041/070/090')>0 )
                         and ( Q.FieldByName('moes_dataemissao').AsDateTime >= Texttodate('02092019') )
                         then begin

//                         vICMSDeson := ( totalitem*(Q1.fieldbyname('move_aliicms').ascurrency/100) ) - vlricms;
//                         motDesICMS := mdiProdutorAgropecuario;
//                         tIcmsDeson := tIcmsDeson + vICMSDeson;

                      end;
// 02.09.19
/////////////
                      if ( AnsiPos(Q1.fieldbyname('move_cst').asstring,'051')>0 ) then begin
// 23.11.20 - Seip

                         if  ( Copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1) <> '3' ) then begin


                           pRedBC := redubase;
                           picms  := 12;
                           vICMSOp:= vlricms;
                           vICMSDif :=0;
// 22.02.2021 - Vida Nova - complemento de entrada de produtor
                           if (Q1.fieldbyname('moes_tipomov').asstring = Global.CodNfeComplementoValorProdutor) then begin

                              vICMSDif := vlricms;
                              vlricms  :=0;

                           end;
  // 10.10.19 - Novicarnes - nf de transferencia nao autorizou zerado
  //                         vICMSOp:= 0;
                           vbc    := 0;
                           pDif   := 100;
                           vICMS    :=0;
                           modBC    :=dbiValorOperacao;
  //                         modBC    :=dbiPauta;

                        end else begin

                           vICMSOp   := vlricms;
                           vlricms   := baseicms * ( (100-33.3334)/100 ) *(Q1.fieldbyname('move_aliicms').ascurrency/100);
                           vlricms   := FGeral.Arredonda(vlricms,2);
                           vICMSDif  := vicmsOP - vlricms;
                           pdif      := 33.3334;

                        end;

                      end;


// 13.05.15 - Coorlaf...ser� ??
                      if vlricms>0 then
                        vICMS := vlricms;

                      if ( ( Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1Asinteger('ConfNfComple') )
                         and ( FGeral.GetConfig1Asinteger('ConfNfComple')>0 ) )
                       OR
// 17.03.15                                                                                      // 24.03.17
                         ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoQtde+';'+Global.CodCompraProdutor)>0 )
                       then begin
                        vBC:=0;
                        pRedBc:=0;
// 13.11.15
                       end else if   ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoIcms)>0 )then begin

                        pRedBc:=0;
                        vBC   :=baseicms;
//                        vIcms :=0;
// 24.06.19  - Novicarnes
                        vIcms :=vlricms;
// 30.01.15 - Novicarnes - entrada complemento de icms
                      end else if ( Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1Asinteger('NfCompleentrada') )
                         and ( FGeral.GetConfig1Asinteger('NfCompleentrada')>0 ) then begin

                        vBC:=0;
                        pRedBc:=0;
                        vICMS := totalitem;
                        pIcms := 0;

// 02.09.19
                      end else if ( AnsiPos(Q1.fieldbyname('move_cst').asstring,'051')>0 )
                         and ( Q.FieldByName('moes_dataemissao').AsDateTime >= Texttodate('02092019') )
                         and ( redubase=0 )
                         and ( baseicms=0 )
                         then begin

                         vbc:=0;

                      end else begin

// 30.12.2022 - Guiber - notas de venda a consumidor final fora do estado no qual o produto n�o tinha icms
//                       ficava zerado o icms mas a base do item com valor....
//                        if vlricms=0 then baseicms :=0;
//                      s� q tem frete a ser rateado e q faz parte da base do icms...
                        if baseicmssemreducao>0 then
                          vBC   := baseicmssemreducao
                        else
                          vBC   := baseicms;

                        pRedBC:= redubase;

                      end;
// 02.12.15 - ST - Mirvane
                       if (  pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada) > 0 ) then
                          basesubs:=TextToValor( GetBaseST )
// 16.11.18 - Seip - pego o calculo para empresa do simples e posto aqui
                       else begin

                           margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring));
    // 08.08.18
                           if (Q.fieldbyname('moes_tipocad').asstring='C') then begin

                              if QDesti.fieldbyname('clie_consfinal').asstring='R' then
                                 margemlucro:=FCodigosFiscais.GetPercBaseSubs( FSubGrupos.GetCodigoFiscal(Q1.fieldbyname('moes_natf_codigo').asstring,Q1.fieldbyname('move_sugr_codigo').asinteger) );

                           end;

                           if consumidorfinal='S' then margemlucro:=0;

                           if Q.FieldByName('moes_tipomov').AsString=Global.CodDevolucaoIgualVenda then margemlucro:=0;


                           if (Q.fieldbyname('moes_tipocad').asstring='C') and ( margemlucro>0) then begin
                             if QDesti.fieldbyname('clie_contribuinte').asstring='2' then
                                margemlucro:=FCodigosFiscais.GetPercBaseSubs(FSubGrupos.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,FEstoque.GetSubGrupo(Q1.fieldbyname('move_esto_codigo').asstring)))
                             else if QDesti.fieldbyname('clie_contribuinte').asstring='1' then
                                margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring));
                           end;
// 18.02.20 - Vida Nova em nota de transferencia de icms
                           if margemlucro>0 then

                             basesubs:=( totalitem*(1+(margemlucro/100)) )

                           else

                             basesubs:=0;

                           basesubs:= FGeral.Arredonda( basesubs,2 );
                           icmsitemsubs :=0;
                       end;

////////////////////////////////////////////

// 12.12.15
// 17.10.16 - devolucao refinato gustao - retirado pois empresa do simple pode destacar ST em devolucoes..
                       if (  pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada) > 0 ) then begin
//                         basesubs:=TextToValor( GetBaseST );
//                         icmsitemsubs:=TextToValor( GetValorST );
//                         margemlucro:=1;  // s� pra gerar as tags de ST..
                         basesubs:=0;
                         icmsitemsubs:=0;
                         margemlucro:=0;

// 04.12.18 - s� calcular se for saida..
                       end else if AnsiPos( copy(Q.FieldByName('moes_natf_codigo').AsString,1,1),'567' ) > 0 then begin

//                       icmsitemsubs:=(totalitem*(1+(margemlucro/100))) * (Q1.fieldbyname('move_aliicms').ascurrency/100);
// 29.10.14 - giacomoni+asterio
//                         icmsitemsubs:=(totalitem*(1+(margemlucro/100))) * (FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring)/100);
// 08.08.18
                         if (Q.fieldbyname('moes_tipocad').asstring='C') then begin

                            if QDesti.fieldbyname('clie_consfinal').asstring='R' then
                               icmsitemsubs:=(totalitemliquido*(1+(margemlucro/100))) *
                               ( FCodigosFiscais.GetAliquota( FSubgrupos.GetCodigoFiscal( Q.fieldbyname('moes_natf_codigo').asstring,Q1.FieldByName('move_sugr_codigo').AsInteger) )/100 )
// 04.09.18 - Zilmar
                            else

                               icmsitemsubs:=(totalitemliquido*(1+(margemlucro/100))) * (FEstoque.Getaliquotaicms(Q1.fieldbyname('move_esto_codigo').asstring,Global.CodigoUnidade,Global.UFUnidade)/100);


                         end else

                           icmsitemsubs:=(totalitemliquido*(1+(margemlucro/100))) * (FEstoque.Getaliquotaicms(Q1.fieldbyname('move_esto_codigo').asstring,Global.CodigoUnidade,Global.UFUnidade)/100);

                         icmsitemsubs:= FGeral.Arredonda( icmsitemsubs,2 );

                         icmsitemsubs:=icmsitemsubs-vlricms;

                      end else basesubs:=0;  // 04.12.18

// 06.08.18 - Zilmar
                       basesubs:= FGeral.Arredonda( basesubs,2 );


//                       icmsitemsubs:=basesubs * (FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring)/100);
// 08.12.15
                       icmsitemsubs:=FGeral.Arredonda( basesubs * (FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring,Q.fieldbyname('moes_tipo_codigo').asinteger)/100) ,2);
                       icmsitemsubs:=icmsitemsubs-vlricms;
//                       icmsitemsubs:=(basesubs-baseicms)*(FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring)/100);
                       if (basesubs>0) and
                          (  pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodNfeComplementoQtde+';'+Global.CodNfeComplementoIcms) = 0 )
                         then begin
                         modBCST:=dbisMargemValorAgregado;
                         vBCST:=basesubs;
// 02.09.19 - novas validacoes da receita
                         pMVAST :=margemlucro;
//                         pICMSST:=Q1.fieldbyname('move_aliicms').ascurrency;
// 08.12.15
                         pICMSST:=FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring,Q.fieldbyname('moes_tipo_codigo').asinteger);
                         vICMSST:=icmsitemsubs;
                         vICMS := vlricms;
                         vBC   := baseicms;
                       end;
////////////////////////////
// 12.07.11
                      orig  :=  GetOrigemMercadoria(Q1.fieldbyname('move_cst').asstring,'N');
/////////////////////////////////
// 08.07.16 - Difal - Vendas fora do estado para consumidor final - A2Z
// 24.11.16 - Ajuste para Clessi para 'ajudar' cons.final ipi soma na base
// 20.09.18 - Ajuste no calculo da base do difal
// 14.12.18 - a2z simples remessa para nao contribuinte fora do estado

                       if (    (Ide.idDest=doInterestadual)
                          and ( Ide.indFinal=cfConsumidorFinal)
                          and ( Ide.modelo=55 )
                          // 29.01.20 - pra nao gerar este grupo em notas sem icms...Seip
                          and ( Q1.FieldByName('move_aliicms').AsCurrency>0)
                          and ( EContribuinte(Q.fieldbyname('moes_tipo_codigo').asstring,Q.fieldbyname('moes_tipocad').asstring)='N')
                          )
//                          and
// 10.06.19 - Polli desmudou...
//                         ( ( AnsiPos( Q.fieldbyname('moes_tipomov').asstring,Global.TiposGeraFinanceiro )>0 )
//                            or
//                            ( AnsiPos( Q.fieldbyname('moes_tipomov').asstring,Global.CodContratoEntrega )>0 )


                         then begin

                         xaliFPC:=GetAqliFCP(Q.fieldbyname('moes_estado').asstring);
// 27.09.19 - Polli
                         if Q.FieldByName('clie_tipo').AsString='F' then xalifpc:=0;

                         ICMSUFDest.vBCUFDest:=baseicms;
                         ICMSUFDest.pFCPUFDest:=xaliFPC; // % fundo de combate a pobreza por estado ( SC,RS E SP ainda nao tem )
                         ICMSUFDest.pICMSUFDest:=FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring,Q.fieldbyname('moes_tipo_codigo').asinteger);
{
                         if pos(Q.fieldbyname('moes_estado').asstring,'PR/SC/RS/SP/RJ/MG')>0 then
                           ICMSUFDest.pICMSInter:=12
                         else
                           ICMSUFDest.pICMSInter:=7;   // se for prod. importado seria 4%..revisar
}
// 04.12.18
//                          ICMSUFDest.pICMSInter:=Q1.fieldbyname('move_aliicms').ascurrency;
// 26.06.19 - ajustado para informar aliquota mesmo n�o calculando a difal
                             if Q1.FieldByName('move_aliicms').AsCurrency=0 then
                               ICMSUFDest.pICMSInter:=04
                             else
                               ICMSUFDest.pICMSInter:=Q1.FieldByName('move_aliicms').AsCurrency;

                         if DatetoAno(Q.fieldbyname('moes_dataemissao').asdatetime,true)=2016 then
                           ICMSUFDest.pICMSInterPart:=40
                         else if DatetoAno(Q.fieldbyname('moes_dataemissao').asdatetime,true)=2017 then
                           ICMSUFDest.pICMSInterPart:=60
                         else if DatetoAno(Q.fieldbyname('moes_dataemissao').asdatetime,true)=2018 then
                           ICMSUFDest.pICMSInterPart:=80
                         else if DatetoAno(Q.fieldbyname('moes_dataemissao').asdatetime,true)>=2019 then
                           ICMSUFDest.pICMSInterPart:=100;
{
 II � para o ano de 2016: 40% (quarenta por cento) para o Estado de destino e 60% (sessenta por cento) para o Estado de origem;
III � para o ano de 2017: 60% (sessenta por cento) para o Estado de destino e 40% (quarenta por cento) para o Estado de origem;
IV � para o ano de 2018: 80% (oitenta por cento) para o Estado de destino e 20% (vinte por cento) para o Estado de origem;
V � a partir do ano de 2019: 100% (cem por cento) para o Estado de destino.
}
// 14.12.18 // 27.09.19 - polli mudou
//                         if  AnsiPos( copy(Q.FieldByName('moes_natf_codigo').AsString,2,3),'949' )>0  then begin
//
//                            basedifal:=0;
//                            ICMSUFDest.vFCPUFDest:=0 // valor do incentivo a pobreza
//
//                         end else

                            ICMSUFDest.vFCPUFDest:=baseicms*(xaliFPC/100);   // valor do incentivo a pobreza

//                         ICMSUFDest.vICMSUFDest:=(FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring)/100)*
//                                                  baseicms *(ICMSUFDest.pICMSInterPart/100) ;
// 18.05.17
//                         ICMSUFDest.vICMSUFDest:=FGeral.Arredonda( (FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring)/100)*
//                                                  baseicms *(ICMSUFDest.pICMSInterPart/100) ,2 ) ;
// 20.09.18
                         basedifal:= baseicms * ( FGeral.GetAliquotaFixaIcmsEstado(Q.fieldbyname('moes_estado').asstring,Q.fieldbyname('moes_tipo_codigo').asinteger) - ICMSUFDest.pICMSInter  )/100 ;
                         ICMSUFDest.vICMSUFDest:=  basedifal *(ICMSUFDest.pICMSInterPart/100)  ;

                         if DatetoAno(Q.fieldbyname('moes_dataemissao').asdatetime,true)>=2019 then
                           ICMSUFDest.vICMSUFRemet:=0
                         else
                           ICMSUFDest.vICMSUFRemet:=basedifal *((100-ICMSUFDest.pICMSInterPart)/100) ;
// 20.09.18 - se nao calcular da rejeicao no 'calculo' do vfcpufdest ...
                         if ICMSUFDest.pFCPUFDest>0 then

                             ICMSUFDest.vBCFCPUFDest:= ICMSUFDest.vFCPUFDest/(ICMSUFDest.pFCPUFDest/100);
// 18.04.16
                         totalvFCPUFDest:=totalvFCPUFDest+ICMSUFDest.vFCPUFDest;
                         totalvICMSUFDest:=totalvICMSUFDest+ICMSUFDest.vICMSUFDest;
                         totalvICMSUFRemet:=totalvICMSUFRemet+ICMSUFDest.vICMSUFRemet;
                       end;
/////////////////////////////////
                    end;

  //  TpcnDeterminacaoBaseIcms = (dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao);
//                    modBC :=dbiValorOperacao;
// 02.09.19
/////////////
                end; // Det.Add.Imposto.Icms


// 24.10.11 - calculo do pis e cofins
                alipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,
                       Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
                alicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,
                        Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
// 09.04.13 - Clessi - notas de exportacao
                if copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1)='7' then begin
                  alipis:=0;
                  alicofins:=0;
                end;
// 10.06.13 - mostrar tributos na inf. complementares
//                vTotTrib:=CalculaImpostoAproximado(Prod.NCM,Q1.fieldbyname('move_cst').asstring,totalitem);
                xvTotTrib:=CalculaImpostoAproximado(Prod.NCM,Q1.fieldbyname('move_cst').asstring,totalitem);
                Valortotalimpaproximado:=Valortotalimpaproximado + xvTotTrib;

///////////////////////
                with PIS do
                begin

// 12.02.20 - Vida Nova - Ale pegou erro..
                  if cES = 'E' then

                     CST := GetCstPis( FEstoque.GetPISpeloCSTICMS(Q1.fieldbyname('move_cst').asstring,'E','N') )

                  else

                     CST:=GetCStPis( FEstoque.GetsituacaotributariaPIS(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,
                                     Q1.fieldbyname('moes_estado').asstring) );
                  vBC:=totalitem;
// viagem da vava
//                  if (Q.fieldbyname('moes_tipocad').AsString='C') and (ConsumidorFinal='S') then begin
//                    pPIS:=0;
//                    vlrpis:=0;
//                    vPIS:=0;
//                  end else begin
// 26.08.13
//                    if TributaPIS( GetCStPis( FEstoque.GetsituacaotributariaPIS(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q1.fieldbyname('moes_estado').asstring) ) ) then begin
                    if TributaPIS( CST  ) then begin
                      pPIS:=alipis;
//                      vlrpis:=totalitem*(alipis/100);
// 09.09.15
                      vlrpis:=FGeral.arredonda( totalitem*(alipis/100) ,2 );
                      vPIS:=vlrpis;
                    end else begin
                      pPis:=0;
                      vlrpis:=0;
                      vPis:=0;
                    end;
//                  end;
                end;
////////////////////////
                with COFINS do
                begin
// 12.02.20
                  if cES = 'E' then

                     CST := GetCstCofins( FEstoque.GetCOFINSpeloCSTICMS(Q1.fieldbyname('move_cst').asstring,'E','N') )

                  else

                     CST:=GetCStCofins( FEstoque.GetsituacaotributariaCOFINS(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,
                                        Q1.fieldbyname('moes_estado').asstring) );;
                  vBC:=totalitem;
// viagem da vava
//                  if (Q.fieldbyname('moes_tipocad').AsString='C') and (ConsumidorFinal='S') then begin
//                    pCOFINS:=0;
//                    vlrcofins:=0;
//                    vCOFINS:=0;
//                  end else begin
// 26.08.13
                    if TributaCOFINS( GetCStCOFINS( FEstoque.GetsituacaotributariaCOFINS(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q1.fieldbyname('moes_estado').asstring) ) ) then begin
                      pCOFINS:=alicofins;
//                      vlrcofins:=totalitem*(alicofins/100);
// 09.09.15
                      vlrcofins:=FGeral.arredonda( totalitem*(alicofins/100) ,2 );
                      vCOFINS:=vlrcofins;
                    end else begin
                      pCOFINS:=0;
                      vlrcofins:=0;
                      vCOFINS:=vlrcofins;
                    end;
                end;
///////////////////////////////////////
                cOK:=true;
                if  ( (trim(Q1.fieldbyname('esto_cipi_codigo').asstring)<>'') and
                      ( Q.fieldbyname('moes_comv_codigo').AsInteger<>FGeral.GetConfig1AsInteger('ConfMovNFCe') ) and
                    ( pos(Q1.fieldbyname('moes_tipomov').asstring,Global.TiposSaida)>0 ) )
                    OR
// 13.04.11 - Devolucao DX Clessi
                    ( (Q1.fieldbyname('move_aliipi').ascurrency>0) and (pos(Q1.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0)  )
                    OR
// 22.01.20 - recolocado justamente devido a DX da clessi
// 16.05.12 - Importacao Asatec
//                    (  ( (Q.fieldbyname('moes_estado').asstring='EX') or (Q1.fieldbyname('move_aliipi').ascurrency>0) )
// 10.10.18 - - Importacao SEip Brasil
                    (  ( (Q.fieldbyname('moes_estado').asstring='EX') )
                        and (pos(Q1.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0)  )
                  then begin
                  with IPI do
                  begin
//                      CST   := GetCstIPI(Q1.fieldbyname('move_cst').asstring);
// 22.03.10 - Asatec - destaque de ipi somente em saidas
                      CST:=StrToCSTIPI(cOK, FEstoque.GetCodigoCSTipi(Q1.fieldbyname('move_esto_codigo').asstring,cEs) );
//                      GetCst(Q1.fieldbyname('move_cst').asstring);
/////////////////////////
                      pIPI  := Q1.fieldbyname('move_aliipi').ascurrency;
//                      vIPI  := vlripi;
//                      vBC   := baseicms + valorII;
// 24.06.19
                      vIPI  := vlripi ;
                      vBC   := baseicms ;

// 10.10.18 - Seip - importacao
                      if Q1.fieldbyname('move_aliipi').ascurrency=0 then cEnq:='999';
    //  TpcnDeterminacaoBaseIcms = (dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao);

                  end; // Det.Add.Imposto.IPI
                end;

              end;  // ref .if do servicos
            end; // Det.Add.Imposto
// 22.05.17 - venda de armas de fogo - 20.06.17
            if ( FGeral.GetConfig1AsInteger('GRUPOARMAS')>0 ) and
               ( FGeral.GetConfig1AsInteger('GRUPOARMAS') = Q1.FieldByName('esto_grup_codigo').AsInteger )
               then begin
               with Prod.arma.add do begin
                  tpArma:=taUsoPermitido;
                  nSerie:=copy(Q1.fieldbyname('esto_referencia').asstring,1,Ansipos(';',Q1.fieldbyname('esto_referencia').asstring)-1);
                        // numero de serie da arma   - ver campo referencia do estoque
                  nCano:=copy(Q1.fieldbyname('esto_referencia').asstring,Ansipos(';',Q1.fieldbyname('esto_referencia').asstring)+1,4);
                     // numero de serie do cano - ver se � necessario
                  descr:=Q1.fieldbyname('esto_referencia').asstring;  // calibre, marca, capacidade..ver se repete a descricao ou pega de outro lugar
               end;
// 24.08.17  - Sport e Acao - armas - exigencia do exercito
               dadosarmadefogo:=Q1.FieldByName('esto_obs').AsString;
               if trim(dadosarmadefogo)<>'' then begin
                 MemoDAdos.Lines.Clear;
                 MemoDados.Lines.Text:=dadosarmadefogo;
                 for p := 0 to MemoDados.Lines.Count-1 do dadosadicionais:=dadosadicionais+MemoDados.Lines.Strings[p]+' ';
               end;
               dadosarmadefogo:='';
               Memodados.Lines.Clear;

            end;


          end;  // Det.add

        //end;
// 23.11.11
        totalpis:=totalpis+vlrpis;
        totalcofins:=totalcofins+vlrcofins;
// 23.06.19
        totalvalorII := totalvalorII + valorii;
/////////////

        Sistema.beginprocess('Gerando arquivos XML - 5 ');

        Q1.Next;
        inc(seq);

      end;

// 24.08.17 - aqui novamente devido a armas de fogo
      if trim(dadosadicionais)<>'' then
        InfAdic.infCpl:=dadosadicionais;
//////////////////////////////////////////////


// 23.06.19 - seip
      if Q.FieldByName('moes_tipomov').asstring=Global.CodDevolucaoTributadaCliente then begin

/////         Total.Icmstot.vii:=totalvalorii;
         Total.ICMSTot.vIPI:=Total.ICMSTot.vIPI + totalvalorii;
         Total.ICMSTot.vNF:=Total.ICMSTot.vNF + totalvalorii;

      end;
// 12.08.19
//  if tIcmsDeson>0 then Total.ICMSTot.vICMSDeson:=tIcmsDeson;

// 23.04.2021 - Vida Nova - exigencia da 'Sadia'


///////////////    }
// 23.11.11
      Total.ICMSTot.vPIS       :=  totalpis;
      Total.ICMSTot.vCOFINS    :=  totalcofins;
//18.04.16 - Markito
      if (Ide.idDest=doInterestadual)
          and ( Ide.indFinal=cfConsumidorFinal)
          and ( Ide.modelo=55 )
//         and
// 10.06.19 - 27.09.19 - Polli mudou
//          ( ( AnsiPos( Q.fieldbyname('moes_tipomov').asstring,Global.TiposGeraFinanceiro )>0 )
             or
            ( AnsiPos( Q.fieldbyname('moes_tipomov').asstring,Global.CodContratoEntrega )>0 )

             then begin

         Total.ICMSTot.vFCPUFDest:=totalvFCPUFDest;
         Total.ICMSTot.vICMSUFDest:=totalvICMSUFDest;
         Total.ICMSTot.vICMSUFRemet:=totalvICMSUFRemet;
// 16.11.18 - Seip
         InfAdic.infCpl:=InfAdic.infCpl+
              ' Valor FCP '+FGeral.Formatavalor( totalvFCPUFDest,f_cr  ) +
              ' Valor Icms de partilha UF destinat�rio '+FGeral.Formatavalor( totalvICMSUFDest,f_cr  ) +
              ' Valor Icms de partilha UF remetente '+FGeral.Formatavalor( totalvICMSUFRemet,f_cr  );


      end;
// 28.07.16 - Devereda - 09.12.2021 - retornado estas linhas pelo 'mesmo' devereda
      if valordesc>0 then begin

//        Total.ICMSTot.vNF    :=  Total.ICMSTot.vNF - valordesc;
        Total.ICMSTot.vProd  :=  Total.ICMSTot.vProd + valordesc;

      end;

/////////////////////////////////////////////
// 11.05.15 - Fama nf com desconto...VC
//    if Q.fieldbyname('moes_funrural').AsCurrency=0 then
 //     Total.ICMSTot.vDesc:=totdescitens;

// 10.06.13
//      Total.ICMSTot.vTotTrib := Valortotalimpaproximado;
//     talvez tenha que atualizar o Schema pra poder usar
      if trim(dadosadicionais)<>'' then
          InfAdic.infCpl:=InfAdic.infCpl + ' - '+'Valor aproximado tributos '+FGeral.Formatavalor(Valortotalimpaproximado,f_cr)+' Fonte: IBPT'
      else
          InfAdic.infCpl:=InfAdic.infCpl + 'Valor aproximado tributos '+FGeral.Formatavalor(Valortotalimpaproximado,f_cr)+' Fonte: IBPT';

    FGeral.Fechaquery(Q1);
    ListaItens01.free;
    ListaItens02.free;
    FGeral.FechaQuery(QMOvb);

//    if global.Usuario.Codigo=100 then
//      Aviso('Desconto total:'+floattostr(total.ICMSTot.vDesc)+'|Desconto itens:'+floattostr(totdescitens) );


    end;  // do mestre do acbrnfe1

//////////////////////////////////
// 24.11.08
    Sistema.edit('movesto');
    Sistema.setfield('moes_dtnfeexp',Sistema.hoje);
    Sistema.setfield('moes_nfeexp','S');
    Sistema.Post('moes_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring));

    Q.Next;   // NO MESTRE


  end; //  ref. as notas o 'mestre'

//  if global.Usuario.Codigo=100 then

//     showmessage('total acrescimo itens '+floattostr(totacreitens) );

  if  ACBrNFe1.NotasFiscais.Count>0 then begin
    Sistema.beginprocess('Gerando arquivos XML - 5 ');
    if  Acbrnfe1.NotasFiscais.Items[0].NFe.Ide.modelo=65 then begin
      AcbrNfe1.Configuracoes.Geral.ModeloDF:= monfce;
  //    AcbrNfe1.Configuracoes.Geral.IdToken:='Q7EZHVVA8JPZXZAQXTDFEAI1TSNZURWUI5LP';
////////////////////      AcbrNfe1.Configuracoes.Geral.IdCSC:=FGeral.getconfig1asstring('idtoken');
    end;
    if (EdFormaemissao.text<>'4')  then
      ACBrNFe1.NotasFiscais.GerarNFe;
//    else
//      ACBrNFe1.NotasFiscais.GerarNFe;

    IF OP='E' THEN BEGIN  // 01.03.12
      Sistema.beginprocess('Checando as informa��es da(s) nota(s)');
  // 19.01.10
      if not ValidaNotas( ACBrNFe1 ) then begin
        Sistema.endprocess('');
        exit;
      end;
    END;

    Sistema.beginprocess('Validando e Assinando arquivos XML');
    if op='E' then begin
// 08.09.15 - Novicarnes
      for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin
        if ( pos(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring,'S;2') = 0 )
           then begin

           ChecaBaseIcms(   AcbrNfe1.NotasFiscais.Items[i].NFe  );

           ChecaValorvProd(   AcbrNfe1.NotasFiscais.Items[i].NFe  );

// 17.08.16
           ChecaValorVIcms(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 15.04.16
             ChecaValorVIPI(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 08.07.16
             ChecavicmsDestUF(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
             ChecavicmsSUFRem(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 08.02.17
             ChecavFCPUFDest(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 28.08.18 -
             ChecaValorvoutro(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 31.08.18 - Novi -  NP
             Checavalorvpag(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 19.11.22 - Novi -  venda para primato com 1% de desconto
             Checavalorvdesc(   AcbrNfe1.NotasFiscais.Items[i].NFe  );


        end else begin

           ChecaValorIcmsST(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 21.09.15
           ChecaValorvFrete(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 09.11.15 - vivan devolucao de compra
           if (  Acbrnfe1.NotasFiscais.Items[i].nfe.ide.finNFe=fndevolucao ) then
             ChecaValorVIcms(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 10.12.15
             ChecaValorVIPI(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 12.12.15  - recolocado em 31.03.20 - Guiber Matriz
             ChecaBaseIcmsST(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 24.03.16 - vendas nfc-e vivan com 4 casas no unitario
// 27.08.18 - recolocado pra ver se 'estabiliza' nfc-e benato
             ChecaValorvProd(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 24.08.16 -
             ChecaValorvoutro(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 13.07.17 - Iran
             ChecavFCPUFDest(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
             ChecavicmsSUFRem(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 30.08.18 - benato nfc-e
             Checavalorvpag(   AcbrNfe1.NotasFiscais.Items[i].NFe  );
// 23.11.20 - seip - importacao e icms diferido
             ChecaVIcmsDIF(   AcbrNfe1.NotasFiscais.Items[i].NFe  );

        end;
      end;
    end;

///////////////////////17.02.17
    if ( OP='E' ) and ( Global.Topicos[1028] ) then begin

      ACBrNFe1.NotasFiscais.Items[0].GravarXML(inttostr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.cNF)+FGeral.TiraBarra( Datetostr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dEmi) )+'-NFe.xml',AcBrNfe1.Configuracoes.Arquivos.PathNFe+'\');
      TNotas.Free;
      Sistema.EndProcess('XML Gerado');
      exit;

    end;
                                        // 09.06.11 - pra ver se para 'sumi�os' de produtos quando d� os 'retornos' da sefa
//    if Arq.TEstoque.active then Arq.TEstoque.Close;
// 11.10.11 - sem comentarios...culpa do 'silvano'..

//////////////////////////
    if (Global.Usuario.Codigo=900) and (global.Usuario.Nome='Andr�') then begin

      if confirma('Validar') then
        ACBrNFe1.NotasFiscais.Validar;

    end else
// 01.12.16
       if ( ACbrNFe1.NotasFiscais.Count=1 ) and ( OP<>'P' ) then begin
//         ACBrNFe1.NotasFiscais.Validar;
// 29.06.17 - com novos acbr nao valida...
// 20.02.18
         if OP<>'C' then  begin

//           if Global.Usuario.Codigo=100 then begin
//
//              if confirma('assinar e validar ?') then begin
//                 AcbrNfe1.NotasFiscais.Assinar;
//                 ACBrNFe1.NotasFiscais.Validar;
//              end;
//
//           end else begin

              AcbrNfe1.NotasFiscais.Assinar;
              ACBrNFe1.NotasFiscais.Validar;

//           end;

         end;

//         ValidaSchema( AcbrNfe1.NotasFiscais );
       end else if (OP<>'P') then begin
// 23.11.16 - nova forma de validar pra ficar 'mais confortavel' pro usuario
// 20.02.18
         AcbrNfe1.NotasFiscais.Assinar;
{
         if not ValidaSchema( AcbrNfe1.NotasFiscais )   then begin
           Sistema.EndProcess('');
           exit;
         end;
         }
          ACBrNFe1.NotasFiscais.Validar ;
      end;

// 07.02.14 - ver fazer 'validacao propria' aqui e nao fazer dentro do acbr
// 09.06.11
//    IF OP='E' THEN BEGIN  // 01.03.12
//        if (Global.Usuario.Codigo=900) and (global.Usuario.Nome='Andr�') then begin
//         if confirma('Validar ?') then
//           if not  ACBrNFe1.NotasFiscais.ValidacomRetorno then begin
//             Sistema.endprocess('');
//             exit;
//           end;
//      end else if not ACBrNFe1.NotasFiscais.ValidacomRetorno then begin
//        Sistema.endprocess('');
//        exit;
//      end;
//
//    END;

    pathenvioexterno:='';
    pathenvioexternoretorno:='';
    pathretornoexterno:='';
    drive:=ExtractFileDrive(Application.ExeName);
    if Global.Usuario.OutrosAcessos[0333] then begin

      pathenvioexterno:=Drive+'\Unimake\UniNFe\'+EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring+'\Envio';
      pathenvioexternoretorno:=Drive+'\Unimake\UniNFe\'+EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring+'\Enviado\Autorizados\'+
                        FormatDatetime('yyyymm',EdTermino.asdate) ;
      pathretornoexterno:=Drive+'\Unimake\UniNFe\'+EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring+'\Retorno';

    end;

//      C:\Unimake\UniNFe\07411627000184\Enviado\Autorizados\201208
    arquivoexterno:='ENTNFE.TXT';
    arquivoexternoret:='SAINFE.TXT';

/////////////////////
// 16.08.12
    Sistema.beginprocess('Salvando '+inttostr(ACBrNFe1.NotasFiscais.Count)+ ' arquivos XML assinados');
    for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin
//      ACBrNFe1.NotasFiscais.Items[i].XML.SaveToFile(ExtractFileDir(application.ExeName)+ACBrNFe1.NotasFiscais.Items[i].XML.NFeChave+'-NFe.xml');

      ACBrNFe1.NotasFiscais.Items[i].GravarXML(inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.cNF)+FGeral.TiraBarra( Datetostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.dEmi) )+'-NFe.xml',AcBrNfe1.Configuracoes.Arquivos.PathNFe+'\');
      if trim(pathenvioexterno)<>'' then
        ACBrNFe1.NotasFiscais.Items[i].GravarXml(inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.cNF)+FGeral.TiraBarra( Datetostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.dEmi) )+'-NFe.xml',PathenvioExterno+'\');

    end;

    if (Global.Usuario.Codigo=900) and (global.Usuario.Nome='Andr�') then begin

      if confirma('Parar processo') then begin
        sistema.endprocess('');
        exit;
      end;

    end;

    if ( OP='E' ) and ( Global.Topicos[1028] ) then begin

      TNotas.Free;
      Sistema.EndProcess('XML Gerado');
      exit;

    end;

//    pathenvioexterno:='\AcbrNfeMonitor';

    IF OP='E' THEN BEGIN

      if (EdFormaemissao.text<>'2') and (EdFormaemissao.text<>'8') then begin
        Sistema.beginprocess('Enviando arquivos XML para SEFA');
//        if ACBrNFe1.WebServices.StatusServico.Executar then begin
{
        try
          statusok:=ACBrNFe1.WebServices.StatusServico.Executar;
        except
          statusok:=false;
          Avisoerro('Retorno Sefa a :'+ACBrNFe1.WebServices.StatusServico.RetWS  );
          Avisoerro('Retorno Sefa b :'+ACBrNFe1.WebServices.StatusServico.xMotivo  );
          Avisoerro('Retorno Sefa c :'+ACBrNFe1.WebServices.StatusServico.Msg  );
          Avisoerro('Retorno Sefa :'+ACBrNFe1.WebServices.Retorno.xMotivo);
          Avisoerro('Retorno Sefa 1:'+ACBrNFe1.WebServices.Retorno.Msg);
        end;
}

// 21.08.12
        ACBrNFe1.Configuracoes.WebServices.Tentativas:=2;
        xmlaux:=TSTringList.create;

// 02.04.16
        ACBrNFe1.Configuracoes.Geral.ValidarDigest:=true;

        cretornoerro:='';
//////////////////////////////
{
// 03.01.14 - tentar 'autenticar' no proxy
        if ( Global.Topicos[1013] ) and ( not jaautenticado ) then begin
//                   StringToWideChar('www.google.com.br', xLink, 120);
          StringToWideChar('localhost', xLink, 120);
          HlinkNavigateString(nil,xLink );
          jaautenticado:=true;
        end;
        }
/////////////

// 20.08.12 - vendo pra retirar esta checagem de status
//        Sistema.beginprocess('Checando Status do Servi�o na SEFA');
//        if global.Usuario.codigo<>100 then
          ChecaStatusSefa:=true;
//        else
//          ChecaStatusSefa:=ACBrNFe1.WebServices.StatusServico.Executar;
//          ChecaStatusSefa:=ACBrNFe1.WebServices.StatusServico.Executar;
// 01.04.16 0 retirado esta BIROSCA de checagem q 'sempre' d� q o status t� off..principalmente em win server

        if ChecaStatusSefa  then begin

          Numlote:=FGEral.GetContador('LOTENFE'+EdUnid_codigo.text,false);
          try

            if EdFormaemissao.Text='Y' then begin

              Sistema.beginprocess('Enviando arquivos XML para site do DPEC');
//              ACBrNFe1.WebServices.EnviarDPEC.Executar;
            end else

              if Global.usuario.OutrosAcessos[0333] then begin

                for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin

                  Sistema.beginprocess('Enviando xml nf '+inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF)+' para WebServices da SEFA');
                  ListaEnvioNotas:=TStringList.create;

{
 - Nfe.LerNfe(cArqXml) : ler arquivo XML e retorna formato INI
 - Nfe.AdicionarNfe(cArqIni,nLote)
 - Nfe.EnviarLoteNfe(nLote)
 NFe.CriarEnviarNFe
 }
                  ListaEnvioNotas.Add( 'NFE.EnviarNFe("'+AcBrNfe1.Configuracoes.Arquivos.PathNFe+'\'+inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.cNF)+FGeral.TiraBarra( Datetostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.dEmi) )+'-NFe.xml'+'",'+inttostr(numlote)+')' );

//                  ListaEnvioNotas.Add('Nfe.LerNfe("'+AcBrNfe1.Configuracoes.Arquivos.PathNFe+'\'+inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.cNF)+FGeral.TiraBarra( Datetostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.dEmi) )+'-NFe.xml'+'")' );
//                  ListaEnvioNotas.Add('Nfe.AdicionarNfe('+
//                  ListaEnvioNotas.SavetoFile( pathenvioexterno+'\'+arquivoexterno );
//                  Sleep(500);
//                  if FileExists( pathenvioexterno+'\'+arquivoexternoret ) then
// ver se joga o retorno no proprio componente do acbr na propriedade xml

//                  ListaEnvioNotas.SavetoFile( pathenvioexterno+'\'+arquivoexterno2 );
                  ListaEnvioNotas.Free;
                end;

              end else begin

// 30.03.16
//                if ACBrNFe1.NotasFiscais.Count=1 then
// 07.04.16
//                 if global.Usuario.codigo<>100 then
//                    ACBrNFe1.WebServices.Envia(NumLote);
// 05.10.2021 - pra enviar como SINCRONO...nfce parou de autorizar...

//                    if ( xsituacaonotas='NFCe'  )
//                       or
                    if   ( ACBrNFe1.NotasFiscais.Count = 1 )

                    then begin

//                       Aviso( 'sincrono') ;
//                       ACBrNFe1.WebServices.Envia(NumLote,True);
                       ACBrNFe1.Enviar(NumLote,False,True);

                    end else begin

//                       Aviso( 'assincrono') ;
//                       ACBrNFe1.WebServices.Envia(NumLote,False);
                       ACBrNFe1.Enviar(NumLote,False,False);

                    end;

//                 else
//                    ACBrNFe1.Enviar(NumLote,false);

//              else
//                   ACBrNFe1.WebServices.Envia(NumLote,true);

/////////////////////////////  06.10.2021
                  if    ( ACBrNFe1.NotasFiscais.Count = 1 ) then

                     cretornoerro := ACBrNFe1.WebServices.Enviar.xMotivo

                  else

                     cretornoerro:=ACBrNFe1.WebServices.Retorno.xMotivo;
////////////////////////////

              end;

// 20.08.12
//                ACBrNFe1.Enviar(NumLote,false);

//              ListaEnvioNotas.SavetoFile( pathenvioexterno+'\'+arquivoexterno );
//              ListaEnvioNotas.Free;


  //            ACBrNFe1.WebServices.ConsultaDPEC.Executar ;
  //          end;
    //        Aviso('xmotivo='+ACBrNFe1.WebServices.Retorno.xMotivo );
    //        Aviso('chavenfe='+ACBrNFe1.WebServices.Retorno.ChaveNFe );

          except

//            Avisoerro('Retorno Sefa :'+ACBrNFe1.WebServices.StatusServico.xMotivo);
// 02.05.12

//            cretornoerro:=ACBrNFe1.WebServices.Retorno.xMotivo;
// 05.10.2021 - mudan�a pra sincrono
//            if ( xsituacaonotas='NFCe'  )
//                       or
           if    ( ACBrNFe1.NotasFiscais.Count = 1 ) then

               cretornoerro := ACBrNFe1.WebServices.Enviar.xMotivo

            else

               cretornoerro:=ACBrNFe1.WebServices.Retorno.xMotivo;


//               ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.xMotivo;

            if trim(cretornoerro)<>'' then

//              Aviso('Retorno Sefa :'+ACBrNFe1.WebServices.Retorno.xMotivo)
              Aviso('Retorno Sefa : '+cretornoerro)

            else begin

              cretornoerro:=ACBrNFe1.WebServices.Retorno.Msg;
              if trim(cretornoerro)<>'' then
//                Aviso('Retorno Sefa :'+ACBrNFe1.WebServices.Retorno.Msg)
                Aviso('Retorno Sefa :'+cretornoerro)

              else begin

                cretornoerro:=ACBrNFe1.WebServices.Retorno.RetornoWS;
                Sistema.endprocess('Sem retorno da Sefa. '+cretornoerro+'  Tentar enviar novamente e/ou usar Consulta Sefa');
                exit;

              end;
            end;

          end;
  //        ACBrNFe1.NotasFiscais.Clear;
  //        ACBrNFe1.NotasFiscais.LoadFromFile(AcBrNfe1.Configuracoes.Arquivos.PathNFe+'\');

          Sistema.beginprocess('Gravando retornos da SEFA');

          for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin

// 23.08.12 - adsl oi 10 megas da novi..
           if trim(pathenvioexterno)<>'' then begin

              tempo:=0;
              while (not FileExists( PathRetornoExterno+'\'+inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.cNF)+FGeral.TiraBarra( Datetostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.dEmi) )+'-num-lot.xml' ) )
                and (  tempo<100000 ) do begin
                inc(tempo);
              end;
              if FileExists(  PathRetornoExterno+'\'+inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.cNF)+FGeral.TiraBarra( Datetostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.dEmi) )+'-num-lot.xml' )  then
                xmlaux.LoadFromFile( PathRetornoExterno+'\'+
                          inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.cNF)+FGeral.TiraBarra( Datetostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.dEmi) )+'-num-lot.xml' )
              else
                Sistema.endprocess('Arquivo com NUMERO DO LOTE  '+PathRetornoExterno+'\'+
                          inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.cNF)+FGeral.TiraBarra( Datetostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.dEmi) )+'-num-lot.xml'+
                          ' n�o encontrado.  Verificar' );
              cretorno:=GetTag('NumeroLoteGerado',xmlaux.Text);
              tempo:=0;
              while (not FileExists( PathRetornoExterno+'\'+strzero(strtointdef(cretorno,0),15)+'-rec.xml' ) ) and (  tempo<100000 ) do begin
                inc(tempo);
              end;
              IF FileExists( PathRetornoExterno+'\'+strzero(strtointdef(cretorno,0),15)+'-rec.xml' ) then
                xmlaux.LoadFromFile( PathRetornoExterno+'\'+strzero(strtointdef(cretorno,0),15)+'-rec.xml' )
              else
                Sistema.endprocess('Arquivo com NUMERO DO RECIBO  '+PathRetornoExterno+'\'+
                                   strzero(strtointdef(cretorno,0),15)+'-rec.xml'+
                                   ' n�o encontrado.  Verificar' );
              cretorno:=GetTag('nRec',xmlaux.Text);
// s� sai quando encontra o arquivo
              tempo:=0;
              while (not FileExists( PathRetornoExterno+'\'+cretorno+'-pro-rec.xml' ) ) and (  tempo<100000 ) do begin
                inc(tempo);
              end;

              xmlaux.LoadFromFile( PathRetornoExterno+'\'+cretorno+'-pro-rec.xml' );
              cretorno:=GetTag('xMotivo',copy(xmlaux.Text, pos('dhRecbto',xmlaux.Text),length(xmlaux.Text) ) );
              if pos( 'AUTORIZADA',Uppercase(GetRetorno(cretorno)) )>0 then begin
                if FileExists( PathEnvioExternoRetorno+'\'+inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.cNF)+FGeral.TiraBarra( Datetostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.dEmi) )+'-procNFe.xml' ) then begin
                  xmlaux.LoadFromFile( PathEnvioExternoRetorno+'\'+inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.cNF)+FGeral.TiraBarra( Datetostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.dEmi) )+'-procNFe.xml' );
                  cretorno:=GetRetorno(xmlaux.Text);
                end;
              end;
// 13.10.16
           end else begin

              tempo:=0;

// 05.10.2021
{
//              while (not FileExists( acbrnfe1.Configuracoes.Arquivos.PathSalvar+'\'+inttostr(NUmlote)+'-rec.xml' ) )
// 05.10.2021
              while (not FileExists( acbrnfe1.Configuracoes.Arquivos.PathSalvar+inttostr(NUmlote)+'-rec.xml' ) )
                and (  tempo<100000 ) do begin
                inc(tempo);
              end;
//              if FileExists(  acbrnfe1.Configuracoes.Arquivos.PathSalvar+'\'+inttostr(Numlote)+'-rec.xml' )  then
              if FileExists(  acbrnfe1.Configuracoes.Arquivos.PathSalvar+inttostr(Numlote)+'-rec.xml' )  then

                xmlaux.LoadFromFile( acbrnfe1.Configuracoes.Arquivos.PathSalvar+
                          inttostr(Numlote)+'-rec.xml' )

              else

                Sistema.endprocess('Arquivo de LOTE  '+acbrnfe1.Configuracoes.Arquivos.PathSalvar+
                          inttostr(Numlote) +'-rec.xml'+
                          ' n�o encontrado.  Verificar' );
}
// 05.10.2021 - retirado este esquema de pegar do xml e pegar do componente
{
// aqui pega o numero do protocolo do lote enviado
//              cretorno:=GetTag('nRec',xmlaux.Text);
              cretorno:=GetTag('idLote',xmlaux.Text);
// pega o xml com os retornos de nf enviada separando pela sua chave
// aqui tem q procurar pela chave da nota e dentro de sua tag buscar a tag xmotivo

//              if FileExists( acbrnfe1.Configuracoes.Arquivos.PathSalvar+'\'+cretorno + '-pro-rec.xml' ) then begin
              if FileExists( acbrnfe1.Configuracoes.Arquivos.PathSalvar+cretorno + '-pro-lot.xml' ) then begin

                xmlaux.LoadFromFile( acbrnfe1.Configuracoes.Arquivos.PathSalvar+
                          cretorno + '-pro.xml' );
                cretorno:=GetxMotivo(xmlaux.Text, Acbrnfe1.NotasFiscais.Items[i].NFe.infNFe.ID )

              end else

                Sistema.endprocess('Arquivo com os RETORNOS DA RECEITA '+acbrnfe1.Configuracoes.Arquivos.PathSalvar+cretorno + '-pro-lot.xml'+
                                   ' n�o encontrado.  Verificar' );
//             cretorno:=GetRetorno( ACBrNFe1.NotasFiscais.Items[i].XML );
}

           end;


// 02.05.12
//            if trim(cretorno)='' then cretorno:=cretornoerro;
// 05.10.2021
            cretorno := cretornoerro;
            AtualizaGrid( ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF,cretorno );
            ctransacao:=GetGridTransacao(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);

            if ( trim(ctransacao)<>'' ) and
               ( trim(cretorno)<>'' )   and
               ( EdFormaemissao.Text<>'4' ) and
               ( Ansipos('ENCONTRADO',UPpercase(cretorno))=0 )
               then begin

               QNfe:=Sqltoquery('select moes_dtnfeauto,moes_chavenfe from movesto where moes_transacao='+Stringtosql(Trim(ctransacao))+
                                ' and moes_status<>''C''' );
               Sistema.edit('movesto');
               campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
// 11.02.16
//               xmlstring:=ACBrNFe1.NotasFiscais.Items[i].XML;
// 02.09.2022 // para ver se n�o ocorrer mais de ficar 'autorizada no sac e n�o autorizada na receita'
              // caso da vida nova..
               xmlstring:=ACBrNFe1.NotasFiscais.Items[i].XMLOriginal;
               xmlstring:=FGeral.TiraBarra(xmlstring,chr(39),'"');
               Xmlstream:=TMemoryStream.Create;
               ACBrNFe1.NotasFiscais.Items[i].GravarStream(Xmlstream);
// 26.10.16
               if ( Ansipos('AUTORIZADA',uppercase(cretorno))>0 )
               OR
                  ( Ansipos('AUTORIZADO',uppercase(cretorno))>0 ) then begin
                 Sistema.setfield('moes_dtnfeauto',Sistema.hoje);
// 23.08.12
                 Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
{
                 Sistema.setfield('moes_xmlnfe',ACBrNFe1.NotasFiscais.Items[i].XML) ;
                 if trim(pathenvioexterno)<>'' then
                     Sistema.setfield('moes_xmlnfet',xmlaux.Text)
                 else if campo.tipo<>'' then // 16.07.10
                   Sistema.setfield('moes_xmlnfet',ACBrNFe1.NotasFiscais.Items[i].XML) ;
}
// 05.02.16
                 xmlaux.Clear;
//                 StreamXml:=TMemoryStream.Create;
//                 ACBrNFe1.NotasFiscais.Items[i].GravarStream(StreamXml);
//                 xmlaux.LoadFromStream(Streamxml);

                 Sistema.setfield('moes_xmlnfe',xmlstring) ;
//                 Streamxml.Free;
                 if trim(pathenvioexterno)<>'' then
                     Sistema.setfield('moes_xmlnfet',xmlstring)
                 else if campo.tipo<>'' then // 16.07.10
                   Sistema.setfield('moes_xmlnfet',xmlstring) ;
///////////////////////////////}
                 if trim(pathenvioexterno)<>'' then
                   Sistema.setfield('moes_chavenfe',copy(ACBrNFe1.NotasFiscais.Items[i].NFe.infNFe.ID,4,44))
                 else
                   Sistema.setfield('moes_chavenfe',ACBrNFe1.NotasFiscais.Items[i].NFe.procNFe.chNFe);
// 05.04.17 - Mirvane - Jackson contador - Delcio
                 if trim(xemail)<>'' then begin
                    AcBrNfe1.EnviarEmail(xemail,'NF '+inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF)+
                                        FGeral.FormataData(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.dEmi),
                                        nil,nil,nil,xmlstream,'Xmlnf_'+inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF) );
                 end;

               end else if trim(cretorno)<>''  then begin

               // 07.11.16
                   Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
// 09.09.19
                   if AnsiPos( 'DENEGA',Uppercase( cretorno ) ) >0 then

                      Sistema.setfield('moes_chavenfe',ACBrNFe1.NotasFiscais.Items[i].NFe.procNFe.chNFe);

//                 if Datetoano(QNfe.fieldbyname('moes_dtnfeauto').AsDatetime,true) <= 1920 then begin
// 21.10.16
                 if Datetoano(QNfe.fieldbyname('moes_dtnfeauto').AsDatetime,true) >= 1920 then begin
// 23.08.12
                   if trim(pathenvioexterno)<>'' then
                     Sistema.setfield('moes_xmlnfet',xmlstring)
                   else if campo.tipo<>'' then // 16.07.10
                     Sistema.setfield('moes_xmlnfet',xmlstring) ;
                   Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
                   Sistema.setfield('moes_dtnfereto',Sistema.hoje);
                 end;
               end;
               FGeral.FechaQuery(QNfe);
  //             if trim(cretorno)<>'' then
  //               Sistema.setfield('moes_remessas',cretorno);
               Sistema.Post('moes_transacao='+stringtosql(ctransacao));

            end  else if EdFormaemissao.Text='4' then begin

            {
//              cretorno:='enviado via DPEC';
//              cretorno:=GetRetorno( ACBrNFe1.WebServices.EnviarDPEC.xMotivo
// 05.11.12 - mudado do retorno
              cretorno:= ACBrNFe1.WebServices.EnviarDPEC.xMotivo;

//              ACBrNFe1.WebServices.EnviarDPEC.xMotivo;
//              ACBrNFe1.NotasFiscais.Items[i].Alertas
//               mandar o xml da dpeC e nao do gerado...

              if trim( cretorno ) ='' then
                if trim( ACBrNFe1.WebServices.EnviarDPEC.nRegDPEC )='' then
                  cretorno:='sem protocolo de envio ao DPEC';

  //            avisoerro('RetWs :'+UTF8Encode(ACBrNFe1.WebServices.EnviarDPEC.RetWS));

              AtualizaGrid( ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF,cretorno );
              campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
              Sistema.edit('movesto');
              Sistema.setfield('moes_xmlnfe',ACBrNFe1.NotasFiscais.Items[i].XML) ;
              if campo.tipo<>'' then // 16.07.10
                Sistema.setfield('moes_xmlnfet',ACBrNFe1.NotasFiscais.Items[i].XML) ;
              Sistema.setfield('moes_chavenfe',ACBrNFe1.NotasFiscais.Items[i].NFe.procNFe.chNFe);
              Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
              Sistema.setfield('moes_dtnfereto',Sistema.hoje);
              if trim( ACBrNFe1.WebServices.EnviarDPEC.nRegDPEC )<>'' then
                Sistema.setfield('moes_protodpec',ACBrNFe1.WebServices.EnviarDPEC.nRegDPEC+' '+
                                  DateTimeToStr(ACBrNFe1.WebServices.EnviarDPEC.DhRegDPEC) )
              else
                Sistema.setfield('moes_protodpec','');
              Sistema.Post('moes_transacao='+stringtosql(ctransacao));
              }
            end else if trim(cretorno)<>'' then


               Avisoerro('Verificar. '+cretorno);

          end;

        end else
  //        Avisoerro('Status Servi�o :'+ACBrNFe1.WebServices.StatusServico.Msg);
          Avisoerro('Status WebService Sefa :'+ACBrNFe1.WebServices.StatusServico.xMotivo);
        try
          Sistema.Commit;
        except
          Avisoerro('N�o foi poss�vel gravar o xml de retorno no banco de dados');
        end;

//        if FileExists( pathenvioexterno+'\'+arquivoexternoret ) then
//          DeleteFile( pathenvioexterno+'\'+arquivoexternoret );

      end else begin  // 25.11.09 - caso for usar formulario de seguran�a apenas gerar xml
                      // para depois imprimir o danfe em form. seguran�a

        for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin

          ACBrNFe1.NotasFiscais.Items[i].GerarXML;
          ctransacao:=GetGridTransacao(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);

          cretorno := 'EM CONTINGENCIA';
// 13.08.2021
          if EdFormaemissao.Text='8' then

             cretorno := 'CONTINGENCIA OFFLINE';

          AtualizaGrid( ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF,cretorno );
          campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
          Sistema.edit('movesto');
          Sistema.setfield('moes_xmlnfe',ACBrNFe1.NotasFiscais.Items[i].XML) ;
          if campo.tipo<>'' then // 16.07.10
             Sistema.setfield('moes_xmlnfet',ACBrNFe1.NotasFiscais.Items[i].XML) ;
          Sistema.setfield('moes_chavenfe',ACBrNFe1.NotasFiscais.Items[i].NFe.procNFe.chNFe);
          Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
          Sistema.setfield('moes_dtnfereto',Sistema.hoje);
          Sistema.Post('moes_transacao='+stringtosql(ctransacao));

        end;
        try
          Sistema.Commit;
        except
          Avisoerro('N�o foi poss�vel gravar o xml no banco de dados');
        end;
      end;

    END ELSE BEGIN   // Consulta Sefa

// 04.02.16
    ACBrNFe1.Configuracoes.Geral.ValidarDigest:=false;
    xmlaux:=TSTringList.create;
    ListaXml:=TStringList.create;

    ///////////////////////////////////////////////////
     for i:=0 to AcbrNfe1.NotasFiscais.Count-1 do begin
//       ACBrNFe1.WebServices.Consulta.NFeChave := FExpNfetxt.GetTag('chNFe', ACBRNfe1.NotasFiscais.Items[i].XML );
// tiro o 'NFe' inicial do ID para ir somente os 44 digitos
       ACBrNFe1.WebServices.Consulta.NFeChave := copy(ACBRNfe1.NotasFiscais.Items[i].NFe.infNFe.ID,4,44) ;
       if Op='C' then
         ACBrNFe1.WebServices.Consulta.Executar;
// gerando o xml novamente nao vem o arquivo de retorno mas sim a 'nfe retorno'...
// so quando faz consulta sem xml gerado dai retorna este arquivo
// 16.08.16 - parece q 'voltou como era antes'...
//{
// 24.11.16
       if OP='P' then begin

         ListaXML.Clear;
         ListaXml.Add( AcbrNfe1.NotasFiscais.Items[i].XMLOriginal);

       end else begin

         arqxmlretorno:=AcbrNfe1.Configuracoes.Arquivos.PathEvento+'\'+ACBrNFe1.WebServices.Consulta.NFeChave+'-sit.XML';
         if not FileExists(arqxmlretorno) then begin
              Avisoerro('Arquivo XML de retorno n�o encontrado:'+arqxmlretorno);
              Sistema.EndProcess('Banco de dados n�o atualizado');
              exit;
         end;
         ListaXML.Clear;
         ListaXml.LoadFromFile(arqxmlretorno);
// xml retorno - 11.01.2022
       end;
///}
// pois nao precisa mostrar o numero da nfe...
//       cretorno:=copy(FExpNfetxt.GetRetorno( ListaXml.Strings[0] ),53,40) ;
//       cretorno:= FGerenciaNfe.TrataRetornoXMotivo( ListaXml.Strings[0]  ) ;
//       AtualizaGrid( ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF,cretorno );
//       ctransacao:=FExpNfetxt.GetGridTransacao(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);


//       cretorno:=GetRetorno( ACBrNFe1.NotasFiscais.Items[i].XML );

       cretorno:= GetRetorno( ListaXml.Strings[0]  ) ;

// 05.01.10 - quando nao vem a tag xmotivo no xml de retorno
       if trim(cretorno)='' then
         cretorno:=copy(ACBrNFe1.NotasFiscais.Items[i].NFe.procNFe.xMotivo,53,50);
// 01.12.10 - lokurage na Bavi
       if trim(cretorno)='' then
         cretorno:=copy(ACBrNFe1.NotasFiscais.Items[i].NFe.procNFe.xMotivo,1,80);
//
       if op<>'P' then
         AtualizaGrid( ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF,cretorno );

       ctransacao:=GetGridTransacao(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);
//{
       if ( trim(ctransacao)<>'' ) and
             ( trim(cretorno)<>'' )   and
             ( op <>'P' )             and
             ( Ansipos('ENCONTRADO',UPpercase(cretorno))=0 )
             then begin
             QNfe:=Sqltoquery('select moes_dtnfeauto,moes_chavenfe from movesto where moes_transacao='+Stringtosql(Trim(ctransacao))+
                              ' and moes_status<>''C''' );

             campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
             Sistema.edit('movesto');
             if ( Ansipos('AUTORIZADA',uppercase(cretorno))>0  )
// 03.11.16
               OR
                  ( Ansipos('AUTORIZADO',uppercase(cretorno))>0 ) then begin

               Sistema.setfield('moes_dtnfeauto',Sistema.hoje);
// 10.02.16
/////////////////////////

               xmlaux.Clear;
//               StreamXml:=TMemoryStream.Create;
//               ACBrNFe1.NotasFiscais.Items[i].GravarStream(StreamXml);
//               xmlaux.LoadFromStream(Streamxml);
//               xmlaux.Add( RetiraBarra( ACBrNFe1.NotasFiscais.Items[i].XML )  );
//               xmlstring:=RetiraBarra( ACBrNFe1.NotasFiscais.Items[i].XML );

//               xmlstring:=ACBrNFe1.NotasFiscais.Items[i].XML;

// 11.01.2022 - devido a alguns xmls devereda q vem com xml sem a tag de assinatura
//              dai sistemas como o sage n�o o importa...
//               xmlstring:=ACBrNFe1.NotasFiscais.Items[i].XMLAssinado;
// 02.09.2022 // para evitar de ficar 'autorizada no sac e n�o autorizada na receita'
               xmlstring:=ACBrNFe1.NotasFiscais.Items[i].XMLOriginal;

               xmlstring:=FGeral.TiraBarra(xmlstring,chr(39),'"');
               xmlstream:=TMemoryStream.Create;
               ACBrNFe1.NotasFiscais.Items[i].GravarStream(Xmlstream);
               Sistema.setfield('moes_xmlnfe',xmlstring) ;
               if campo.tipo<>'' then // 16.07.10
                  Sistema.setfield('moes_xmlnfet',xmlstring) ;

//////////////////////////////////////
{
               Sistema.setfield('moes_xmlnfe',ACBrNFe1.NotasFiscais.Items[i].XML) ;
               if campo.tipo<>'' then
                  Sistema.setfield('moes_xmlnfet',ACBrNFe1.NotasFiscais.Items[i].XML) ;
}
               Sistema.setfield('moes_chavenfe',ACBrNFe1.NotasFiscais.Items[i].NFe.procNFe.chNFe);
// 05.04.17 - Mirvane - Jackson contador - Delcio
                 if trim(xemail)<>'' then begin
                    AcBrNfe1.EnviarEmail(xemail,'NF '+inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF)+
                                        ' emiss�o '+FGeral.FormataData(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.dEmi),
                                        nil,nil,nil,xmlstream,'Xmlnf_'+inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF) );
                 end;
             end;

// 08.12.10 -colocado o cancelamento da nfe na sefa mas no sac sem ter atualizado
//           o banco...primeira vez com dr. Tiago
// 05.11.14 -colocado o cancelamento da nfe na sefa mas no sac sem ter atualizado
//           o banco...segunda vez com dr. Marilete felix
             if ( pos('CANCELA',uppercase(cretorno))>0 ) or
                ( pos('PROCESSADO',uppercase(cretorno))>0 ) then begin

//               if global.Usuario.Codigo=100 then
//                 Aviso('cretorno='+cretorno+' ctransacao='+ctransacao);
// 28.09.16 -
               xmlstring:=ACBrNFe1.NotasFiscais.Items[i].XML;
               xmlstring:=FGeral.TiraBarra(xmlstring,chr(39),'"');
             /////////
               Sistema.setfield('moes_dtnfecanc',Sistema.hoje);
//               Sistema.setfield('moes_xmlnfecanc',ACBrNFe1.NotasFiscais.Items[i].XML) ;
               Sistema.setfield('moes_xmlnfecanc',xmlstring) ;
               Sistema.setfield('Moes_Usua_CancNfe',Global.Usuario.Codigo);
               Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
               Sistema.setfield('moes_dtnfereto',Sistema.hoje);

             end else if trim(cretorno)<>'' then begin

//               if Datetoano(QNfe.fieldbyname('moes_dtnfeauto').AsDatetime,true) <= 1920 then begin
// 03.11.16 - retirado para atualizar retorno no consulta sefa
// 09.09.19
                if AnsiPos( 'DENEGA',Uppercase( cretorno ) ) >0 then
//                      Sistema.setfield('moes_chavenfe',ACBrNFe1.NotasFiscais.Items[i].NFe.procNFe.chNFe);

                      Sistema.setfield('moes_chavenfe',GetRetorno(ListaXml.Strings[0],'chnfe'));

                 Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
                 Sistema.setfield('moes_dtnfereto',Sistema.hoje);
//               end;

             end;
             Sistema.Post('moes_transacao='+stringtosql(ctransacao));
// 11.02.16

//             if ( pos('AUTORIZADA',uppercase(cretorno))>0  ) then
//               Sistema.Conexao.ExecuteDirect('update movesto set moes_xmlnfet = Convert ('+chr(39)+xmlstring+chr(39)+',''UTF-8'',''LATIN'' )'+
//                                           ' where moes_transacao='+stringtosql(ctransacao) );

             FGeral.FechaQuery(QNfe);
// 19.02.16
       end else if op='P' then begin

           AcbrNFe1.DANFE := ACBrNFeDANFeRL1;
// 04.09.20
           acbrnfe1.danfe.TipoDANFE := tiretrato;
           if acbrnfe1.NotasFiscais.Items[0].NFe.Ide.modelo = 65 then begin

//              AcbrNFe1.DANFE.MostraPreview:=true;
              ACBrNFeDANFCeFortes1.MostraPreview := True;
              Acbrnfe1.DANFE:=ACBrNFeDANFCeFortes1;
              acbrnfe1.danfe.TipoDANFE:=tiNFCe;
              ACBrNFeDANFCeFortes1.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

           end else begin

              AcbrNFe1.DANFE.MostraPreview:=true;
              AcbrNfe1.DANFE.ImprimirDANFE(AcbrNFe1.NotasFiscais.Items[0].NFe);
              AcbrNFe1.DANFE.MostraPreview:=false;
           end;

       end;
//          }
     end;
     try
          Sistema.Commit;
     except
          Avisoerro('N�o foi poss�vel gravar o xml no banco de dados');
     end;

    END;

  end;


// Para enviar uma NFe, temos dois m�todos dispon�veis. O m�todo ACBrNFe1.Enviar(NumLote);
//  ir� gerar o(s) XML da(s) NFe(s), assin�-la(s), valid�-la(s), envi�-la(s) e por fim imprim�-la(s) (se forem autorizadas) de forma autom�tica.
// Caso n�o queira que o DANFe seja impresso automaticamente, use a sequ�ncia de comandos abaixo:
//ACBrNFe1.NotasFiscais.GerarNFe;
//ACBrNFe1.NotasFiscais.Assinar;
//ACBrNFe1.NotasFiscais.Valida;
//ACBrNFe1.WebServices.Envia(NumLote);
//Depois para imprimir use o comando ACBrNFe1.NotasFiscais.Items[i].XML.Imprimir;


  TNotas.Free;                                 // 10.04.17
  if (op<>'P') and (not Global.topicos[1384]) and (xnumeronota=0) then begin
    if  ACBrNFe1.NotasFiscais.Count>0 then
      Sistema.EndProcess('Enviado(s) XML(s) gerado(s) em '+AcBrNfe1.Configuracoes.Arquivos.PathNFe)
    else
      Sistema.EndProcess('Sem notas para enviar XML(s)');
  end else Sistema.endprocess('');
end;

procedure TFExpNfetxt.FechaArquivosXML;
begin
    sistema.endprocess('Processo Interrompido');

end;

procedure TFExpNfetxt.bconsutawebserClick(Sender: TObject);
begin
  FSiteWebservices.execute('D');
end;

/////////09.11.12 - para nao 'dobrar' o numero do endereco na NFe
function TFExpNfetxt.TiraString(stringatirar,  stringdeondetirar: string): string;
//////////////////////////////////////////////////////////////////////////////////
var x:integer;
begin
  x:=pos(stringatirar,stringdeondetirar);
  if x>0 then result:=copy(stringdeondetirar,1,x-1) else result:=stringdeondetirar;
// 27.11.12 - numa nota da Giacomoni sem virgula ficou com xlogr em branco
  if trim(result)='' then result:=stringdeondetirar
end;

procedure TFExpNfetxt.EdformaemissaoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
begin
    if (EdFormaemissao.text='2') and ( not Global.Topicos[1032] ) then
      Edformaemissao.Invalid('Op��o somente permitida para quem tem o formul�rio de seguran�a');
end;

// 10.06.13
function TFExpNfetxt.CalculaImpostoAproximado(xNCM,xCST: string; xvalor:currency): currency;
///////////////////////////////////////////////////////////////////////////////////////////////
var tab:integer;
    aliqnac,aliqimp,aliest,alimun:double;
    xdescri,xex:string;
begin
  result:=0;
// para ser chamado de 'qq lugar' - ate parece q o componente tem 'em todo lugar'.
//  if FGeral.AcbrIbptax1.Itens.Count=0 then begin
// 08.12.15
//  if FGeral.AcbrIbptax1.Arquivo.Count=0 then begin
//    AcbrIbptax1.URLDownload:='https://acbr.svn.sourceforge.net/svnroot/acbr/trunk/Exemplos/ACBrIBPTax/tabela/AcspDeOlhoNoImpostoIbptV.0.0.1.csv';
// 02.08.13 - ver para usar arquivo texto e criar opcao de atualizar tabela..
//    AcbrIbptax1.URLDownload:='https://acbr.svn.sourceforge.net/svnroot/acbr/trunk/Exemplos/ACBrIBPTax/tabela/AcspDeOlhoNoImpostoIbptV.0.0.2.csv';
//    AcbrIbptax1.DownloadTabela;
//     FGeral.ArmazenaTabelaIBPT(AcbrIbptax1);
//     FGeral.SetaTabelaIBPT;
////////////
    {
    if not FileExists( 'TabelaIbpt.csv' ) then begin
      AcbrIbptax1.URLDownload:='https://acbr.svn.sourceforge.net/svnroot/acbr/trunk/Exemplos/ACBrIBPTax/tabela/AcspDeOlhoNoImpostoIbptV.0.0.1.csv';
      Sistema.beginprocess('Baixando tabela IBPT');
      if AcbrIbptax1.Itens.Count=0 then AcbrIbptax1.DownloadTabela;
    end else begin
      AcbrIbptax1.URLDownload:='TabelaIbpt.csv';
      Sistema.beginprocess('Lendo tabela IBPT');
      if AcbrIbptax1.Itens.Count=0 then AcbrIbptax1.AbrirTabela('TabelaIbpt.csv');
    end;
    }
////////////
//  end;

  if pos( Global.SimplesUnidade,'S;2') > 0 then
    xCST:='000';   // por enquanto tudo origem nacional pra empresas do simples
//  if Fgeral.Acbribptax1.Procurar(xNCM,xCST,tab,aliqnac,aliqimp) then begin
// 08.04.15
  if Fgeral.Acbribptax1.Procurar(xNCM,xEx,xDescri,tab,aliqnac,aliqimp,aliest,alimun) then begin
// 07.08.13 - ver o que � xdescri
//  if FGeral.Acbribptax1.Procurar(xNCM,xCST,xDescri,tab,aliqnac,aliqimp) then begin
// 24.01.15

//  if FGeral.Acbribptax1.Procurar then begin
    if pos( copy(xCST,1,1),'0;3;4;5' ) > 0 then
      result:=xvalor*(aliqnac/100)
    else
      result:=xvalor*(aliqimp/100);
  end;

end;

// 26.08.13
////////////////////////////////////////////////////////////////////
function TFExpNfetxt.TributaPIS(ycst:TPcnCstPIS):boolean;
/////////////////////////////////////////////////////////////////////
    begin
      result:=false;
//pis06, pis07, pis08, pis09, pis49,
// pis70, pis71, pis72, pis73, pis74,
      if ycst in [ pis01,pis02, pis03, pis04, pis05,
                   pis50, pis51, pis52, pis53, pis54, pis55, pis56, pis60, pis61, pis62,
                   pis63, pis64, pis65, pis66, pis67, pis75,
                   pis98, pis99 ]
                   then
        result:=true;
    end;


// 26.08.13
////////////////////////////////////////////////////////////////////
function TFExpNfetxt.TributaCOFINS(ycst: TPcnCstCOFINS): boolean;
////////////////////////////////////////////////////////////////////
begin
      result:=false;
//pis06, pis07, pis08, pis09, pis49,
// pis70, pis71, pis72, pis73, pis74,
      if ycst in [ cof01,cof02, cof03, cof04, cof05,
                   cof50, cof51, cof52, cof53, cof54, cof55, cof56, cof60, cof61, cof62,
                   cof63, cof64, cof65, cof66, cof67, cof75,
                   cof98, cof99 ]
                   then
        result:=true;

end;

////////////////////////////////////////////////////////////////////
// 29.12.14
procedure TFExpNfetxt.bimpnfprodutorClick(Sender: TObject);
////////////////////////////////////////////////////////////////////
type TMunicipios=record
     nome,uf,cep,codigoibge,codigopais,nomepais:string;
     codigo:integer;
end;


var ListaArquivo,ListaLinha:TStringList;
    p,xnfsaida,xcodigosac,contagerencial:integer;
    xcodigo,xnome,xcpfcnpj,xemissao,xnf,xie,xendereco,xbairro,xfone,xcel,xcep,xestcivil,
    xcadpro,xadmissao,xconjuge,xcpfconjuge,xcontasprodutorleite,transacao,xtransacoes,xsexo,
    xmun,xuf,tipocad,condicao,xcodigoleite,xcst,xunidade:string;
    xvlrbruto,xinss,xfrete,xtxadm,xtxassoc,xprecoliq,xlitros,xcotacapital:currency;
    demissao:TDatetime;
    Q,QComv,QProdutor,TEstoque,QProduto:TSqlquery;
    ListaMunicipios:Tlist;
    PMunicipios:^TMunicipios;
    ListaPrazos:TStringList;
    Pergunta:boolean;

    procedure LeMunicipios;
    ///////////////////////
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select * from cidades');
      ListaMunicipios:=Tlist.create;
      while not Q.eof do begin
        New(PMunicipios);
        PMunicipios.codigo:=Q.fieldbyname('cida_codigo').asinteger;
        PMunicipios.nome:=Ups(q.fieldbyname('cida_nome').asstring );
        PMunicipios.uf:=q.fieldbyname('cida_uf').asstring;
        ListaMunicipios.add( PMunicipios );
        Q.Next;
      end;
      Q.close;Freeandnil(q);
    end;

    procedure AdicionaMunicipio;
    ////////////////////////////
    var Q:TSqlquery;
        name:string;
    begin
        Q:=sqltoquery('select * from cidades where cida_codigo='+inttostr(PMUnicipios.codigo));
        if Q.eof then begin
          Sistema.Insert('cidades');
          Sistema.SetField('cida_codigo',PMUnicipios.codigo);
          Sistema.SetField('cida_nome',PMUnicipios.nome);
          Sistema.SetField('cida_uf',PMUnicipios.uf);
          Sistema.SetField('cida_regi_codigo','001');
          Sistema.SetField('cida_cep',PMunicipios.cep);
          Sistema.SetField('cida_codigoibge',PMunicipios.codigoibge);
          Sistema.SetField('cida_codigopais',PMunicipios.codigopais);
          Sistema.SetField('cida_nomepais',PMunicipios.nomepais);
          Sistema.post;
          Sistema.commit;
        end;
        Q.Close;
    end;


    function GetCodigoMunicipio(nomecidade,ufcidade:string):integer;
    ///////////////////////////////////////////////////////////////
    var p,codigo:integer;
        achou:boolean;

        function Maior:integer;
        ///////////////////////
        var x,maior:integer;
        begin
          maior:=0;
          for x:=0 to LIstaMunicipios.count-1 do begin
            PMunicipios:=ListaMunicipios[x];
            if PMunicipios.codigo>maior then
              maior:=PMunicipios.codigo;
          end;
          result:=maior;
        end;

    begin
    ///////////////////////////////////////
    //////
      achou:=false;
      for p:=0 to LIstaMunicipios.count-1 do begin
        PMunicipios:=ListaMunicipios[p];
//        if (PMunicipios.nome=ups(nomecidade) )  and (PMunicipios.uf=ufcidade )then begin
// 09.06.08
        if (ups(PMunicipios.nome)=ups(nomecidade) )  and (uppercase(PMunicipios.uf)=uppercase(ufcidade) )then begin
          result:=PMunicipios.codigo;
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
//        Q:=sqltoquery('select max(muni_codigo) as ultimo from municipios');
        if trim(nomecidade)<>'' then begin
          codigo:=Maior+1;
  //        Q.close;Freeandnil(Q);
          New(PMunicipios);
          PMunicipios.codigo:=codigo;
          PMunicipios.nome:=nomecidade;
          PMunicipios.uf:=ufcidade;
          PMunicipios.cep:=( xCEP );
          PMunicipios.codigoibge:=GetCodigoListaIbge(nomecidade);
          PMunicipios.codigopais:='';
          PMunicipios.nomepais:= '';
          ListaMunicipios.Add( PMunicipios );
  // salva na lista para no final gravar tdos os novos municipios cadastrados
          result:=codigo;
        end else
          result:=999
      end;
    end;


    procedure IncluiProdutor;
    /////////////////////////
    var sql,cod:string;
        Q:TSqlquery;
        Codigo:integer;
    begin
        Sql:='Select Max(Clie_Codigo) As Proximo From Clientes';
        Q:=SqlToQuery(Sql);
        if Q.FieldByName('Proximo').AsInteger>0 then begin
            Cod:=Trim(Q.FieldByName('Proximo').AsString);
            Cod:=LeftStr(Cod,Length(Cod)-1);
        end;
        Q.Close; FreeAndNil(Q);
        Codigo:=Inteiro(Cod)+1;
        Cod:=IntToStr(Codigo);
        Codigo:=Inteiro(Cod+GetDigito(Cod,'MOD'));
        xcodigosac:=codigo;
        xnome:=ListaLinha[11];
        xsexo:='M';
        xIE:=ListaLinha[13];
        xendereco:=ListaLinha[14];
        if pos(',',xendereco ) = 0 then xendereco:=xendereco+' ,S/N';
        xbairro:=copy(ListaLinha[15],1,30);
        xmun:=copy(ListaLinha[24],1,40);
        xuf:=copy(ListaLinha[25],1,2);
        xcep:=ListaLinha[18];
        xfone:=copy(ListaLinha[16],2,2)+copy(ListaLinha[16],6,4)+copy(ListaLinha[16],11,4);
        xadmissao:=ListaLinha[21];
        xconjuge:=copy(ListaLinha[22],1,40);
        xcadpro:=ListaLinha[20];
        xcpfconjuge:=ListaLinha[23];

          Sistema.Insert('clientes');
          Sistema.SetField('clie_codigo',codigo);
          Sistema.SetField('clie_nome',copy(SpecialCase(xNome),1,40));
          Sistema.SetField('clie_razaosocial',copy(SpecialCase(xNome),1,40));
          if length(trim(xcpfcnpj))<=11 then
//          Sistema.SetField('clie_tipo',GetTipo(Emit.CNPJCPF));
            Sistema.SetField('clie_tipo','F')
          else
            Sistema.SetField('clie_tipo','J');
          Sistema.SetField('clie_cnpjcpf',xcpfcnpj);
          Sistema.SetField('clie_rgie',xIE);
          Sistema.SetField('clie_sexo',xsexo);
  ////        Sistema.SetField('clie_uf',PClifor.forn_uf);
          Sistema.SetField('clie_endres',copy(SpecialCase(xEndereco),1,40));
  //        Sistema.SetField('clie_endrescompl',PClifor.forn_endereco);
          Sistema.SetField('clie_bairrores',SpecialCase(xBairro));
          Sistema.SetField('clie_cida_codigo_res',GetCodigoMunicipio(xMun,xUF));
          Sistema.SetField('clie_cepres',(xCEP));
          Sistema.SetField('clie_uf',(xuf));
          Sistema.SetField('clie_foneres',xfone);
//          Sistema.SetField('clie_email',Emit.EnderEmit....);
          Sistema.SetField('clie_endcom',copy(SpecialCase(xendereco),1,50));
          Sistema.SetField('clie_bairrocom',SpecialCase(xBairro));
          Sistema.SetField('clie_cida_codigo_com',GetCodigoMunicipio(xMun,xUF));
          Sistema.SetField('clie_cidade',xMun);
          Sistema.SetField('clie_cepcom',(xCEP));
          Sistema.SetField('clie_fonecom',xfone);
//          Sistema.SetField('clie_contacontabil',PClifor.forn_contacontabil);
//          Sistema.SetField('clie_situacao','');
          if trim(xadmissao)<>'' then
            Sistema.SetField('clie_dtcad',Strtodate(xadmissao))
          else
            Sistema.SetField('clie_dtcad',Sistema.Hoje);
          Sistema.SetField('clie_unid_codigo',Global.CodigoUnidade);
          Sistema.SetField('clie_repr_codigo',1);
          Sistema.SetField('clie_usua_codigo',Global.Usuario.Codigo);
          Sistema.SetField('clie_contribuinte','S');
          Sistema.SetField('clie_obs','IMP.PRODUTOR CODIGO '+ListaLinha[00]);
          Sistema.SetField('Clie_nomecje',xconjuge);
          Sistema.SetField('Clie_codcliemp',xcadpro);
          Sistema.SetField('Clie_cpfcje',xcpfconjuge);
          Sistema.SetField('clie_aliinsspro',0);
          Sistema.SetField('Clie_ativo','S');
          Sistema.SetField('Clie_estadocivil','0');  // 'sempre casado

  //        Sistema.SetField('clie_caractrib varchar(1)
          Sistema.Post();
          Sistema.Commit;


    end;


begin
/////////////////////////////////////////////
   xContasProdutorLeite:=FGeral.GetConfig1AsString('Ctaprodleite');
   if trim(xContasProdutorLeite)='' then begin
     Avisoerro('Falta configurar a(s) conta(s) de produ��o de leite nas configura��es aba geral');
     exit;
   end;
   if not od1.execute then exit;
   if trim(od1.FileName)='' then exit;
   ListaArquivo:=TStringList.create;
   ListaArquivo.LoadFromFile(od1.FileName);
   ListaLinha:=TStringList.create;
   strtolista(ListaLinha,ListaArquivo[0],';',true);
   if ListaLinha.Count>10 then xemissao:=ListaLinha[1]
   else xemissao:='';
   if trystrtodate( xemissao,global.datasistema ) then begin
     demissao:=strtodate(xemissao);
   end else begin
      avisoerro('Verificar data de emiss�o no inicio do arquivo');
      exit;
   end;
// 16.03.15
   if not Sistema.GetDataMvto('Emiss�o das notas') then exit;
   demissao:=Sistema.DataMvto;
   if not confirma('Confirma importa��o das notas de produtor em '+FGeral.formatadata(demissao)+' ? ') then exit;
   SetaCodigosIbge;
   Sistema.BeginProcess('Checando notas de produtor');
   Q:=sqltoquery('select moes_transacao from movesto '+
              ' where moes_status=''N'''+
              ' and '+FGeral.getin('moes_tipomov',global.CodCompraProdutor,'C')+
              ' and '+FGeral.getin('moes_plan_codigo',xContasProdutorLeite,'C')+
              ' and moes_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
              ' and moes_dataemissao='+Datetosql(demissao) );
   xtransacoes:='';
   QComv:=sqltoquery('select comv_serie,comv_codigo from confmov where comv_tipomovto='+Stringtosql(Global.CodCompraProdutor));
   xnfsaida:=FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+FGeral.Qualserie(QComv.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,false);
   if not Q.eof then begin
//     if not confirma('ATEN��O.  Numera��o de notas est� em '+inttostr(xnfsaida)+'.  Confirma ? ') then exit;
     Avisoerro('ATEN��O.  J� encontrado notas de produtor em '+Datetostr(demissao));
     Sistema.endProcess('');
     exit;
   end;

   if Global.usuario.codigo=100 then pergunta:=Confirma('Elimina importa��o anterior ?')
   else pergunta:=true;
   if Pergunta then begin
     Sistema.BeginProcess('eliminando importa��o anterior');
     while not Q.eof do begin
       xtransacoes:=xtransacoes+';'+Q.fieldbyname('moes_transacao').asstring;
       Q.Next;
     end;
     Q.close;
     if trim(xtransacoes)<>'' then begin
       Executesql('update movesto set moes_status=''C'''+
                ' where moes_status=''N'''+
                ' and '+FGeral.getin('moes_tipomov',global.CodCompraProdutor,'C')+
                ' and '+FGeral.getin('moes_plan_codigo',xContasProdutorLeite,'C')+
                ' and moes_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                ' and '+FGeral.getin('moes_transacao',xtransacoes,'C')+
                ' and moes_dataemissao='+Datetosql(demissao) );
       Executesql('update movestoque set move_status=''C'''+
                ' where move_status=''N'''+
                ' and '+FGeral.getin('move_tipomov',global.CodCompraProdutor,'C')+
                ' and move_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                ' and '+FGeral.getin('move_transacao',xtransacoes,'C')+
                ' and move_datamvto='+Datetosql(demissao) );
       Executesql('update movbase set movb_status=''C'''+
                ' where movb_status=''N'''+
                ' and '+FGeral.getin('movb_tipomov',global.CodCompraProdutor,'C')+
                ' and movb_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                ' and '+FGeral.getin('movb_transacao',xtransacoes,'C') );
       Executesql('update pendencias set pend_status=''C'''+
                ' where pend_status=''N'''+
                ' and pend_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                ' and '+FGeral.getin('pend_tipomov',global.CodCompraProdutor,'C')+
                ' and '+FGeral.getin('pend_transacao',xtransacoes,'C') );
       Sistema.Endprocess('');
     end;
   end;

   LeMunicipios;
   condicao:='009';  // por enquanto fixo - 20 dias
//   contagerencial:=341;  // criado conta com descricao Leite ver se ser� dif. por unidade...
   if pos(';',xContasProdutorLeite)>0 then
     contagerencial:=strtoint(copY(xContasProdutorLeite,1,pos(';',xContasProdutorLeite)))
   else
     contagerencial:=strtointdef(xContasProdutorLeite,0);
   xcodigoleite:=fGeral.GetConfig1AsString('Produtoleite');
   TEstoque:=sqltoquery('select * from estoque where esto_codigo='+Stringtosql(xcodigoleite));
   xcst:=FEstoque.Getsituacaotributaria(xcodigoleite,Global.CodigoUnidade,Global.UFUnidade);
   ListaPrazos:=TStringList.create;
   FCondpagto.GetPrazos(condicao,ListaPrazos);

   for p:=0 to ListaArquivo.Count-1 do begin
     ListaLinha:=TStringList.create;
     strtolista(ListaLinha,ListaArquivo[p],';',true);
     if ListaLinha.Count>10 then xemissao:=ListaLinha[1];
     if ListaLinha.Count>=26 then xunidade:=trim(ListaLinha[26]);
// 23.09.15
     if trim(xunidade)='' then xunidade:=EdUnid_codigo.text;
     if xunidade<>Global.CodigoUnidade then begin
       Sistema.endprocess('Importa��o interrompida.  Arquivo pentence a unidade '+xunidade );
       exit;
     end;
     if trystrtodate( xemissao,Global.Datasistema ) then begin
// 16.03.15
////       demissao:=strtodate(xemissao);
       xnfsaida:=FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+FGeral.Qualserie(QComv.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,false)+1;
       transacao:=FGeral.GetTransacao;
       xcodigo:=ListaLinha[0];
       xcpfcnpj:=copy(ListaLinha[12],1,14);
       if length( trim(xcpfcnpj) )=10 then xcpfcnpj:='0'+xcpfcnpj;
       xcodigosac:=0;
       QProdutor:=sqltoquery('select clie_codigo,Clie_cnpjcpf from clientes where Clie_cnpjcpf='+Stringtosql(xcpfcnpj));
       xmun:=copy(ListaLinha[24],1,40);
       xuf:=copy(ListaLinha[25],1,2);  // caso vier do sisleite sem cpf vai incluir...
       if (QProdutor.eof) or (trim(xcpfcnpj)='') then begin
         IncluiProdutor;
       end else begin
         xcodigosac:=QProdutor.fieldbyname('clie_codigo').AsInteger;
       end;
       Tipocad:='C';
       Sistema.beginprocess('Importa��o produtor '+inttostr(xcodigosac)+' '+FGeral.GetNomeRazaoSocialEntidade(xcodigosac,'C','N'));
       xprecoliq:=TextTovalor( ListaLinha[10] );
       xvlrbruto:=TextTovalor( ListaLinha[03] );
       xlitros:=trunc(xvlrbruto/xprecoliq);
// 14.03.16 - para ver os 'chu' q usam mais q 2 casas decimais no pre�o do leite
//       xvlrbruto:=TextTovalor( ListaLinha[03] );
       xvlrbruto:=xprecoliq*xlitros;
       xinss:=TextTovalor( ListaLinha[04] );
       xfrete:=TextTovalor( ListaLinha[05] );
       xtxadm:=TextTovalor( ListaLinha[06] );
       xtxassoc:=TextTovalor( ListaLinha[07] );
       xcotacapital:=0;  // confirmar se desconta 'somente quando entra na cooperativa'...
       Sistema.Insert('movesto');
        Sistema.SetField('moes_transacao',Transacao);
        Sistema.SetField('moes_operacao',FGeral.GetOperacao);
        Sistema.SetField('moes_status','N');
        Sistema.SetField('moes_numerodoc',xnfsaida);
        Sistema.SetField('moes_tipomov',Global.CodCompraProdutor);
        Sistema.SetField('moes_comv_codigo',Qcomv.fieldbyname('comv_codigo').AsInteger);
        Sistema.SetField('moes_unid_codigo',Global.CodigoUnidade);
    //    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
        Sistema.SetField('moes_tipo_codigo',xcodigosac);
    // 31.07.07
    //    if codcidade=0 then begin
          if Tipocad='F' then begin
            Sistema.SetField('moes_estado',xuf);
            Sistema.SetField('moes_cida_codigo',0);
          end else begin
            Sistema.SetField('moes_estado',xuf);
            Sistema.SetField('moes_cida_codigo',GetCodigoMunicipio(xMun,xUF));
          end;
    //    end else begin
    //        Sistema.SetField('moes_estado',FCidades.GetUF(codcidade));
    //        Sistema.SetField('moes_cida_codigo',codcidade);
    //    end;
        Sistema.SetField('moes_tipocad',tipocad);
        Sistema.SetField('moes_datalcto',Sistema.Hoje);
        Sistema.SetField('moes_datamvto',dEmissao);

          Sistema.SetField('moes_vlrtotal',xvlrbruto);
// 19.01.16 - mudan�as a receita para autorizar
//          Sistema.SetField('moes_vlrtotal',xvlrbruto-xinss-xcotacapital);
// 22.02.16 - desfeito devido a 'equivoco' ref. a desconto do funrural.....
          Sistema.SetField('moes_totprod',xvlrbruto);
          Sistema.SetField('moes_repr_codigo',1);
            Sistema.SetField('moes_DataCont',Sistema.hoje);
            Sistema.SetField('moes_baseicms',0);
            Sistema.SetField('moes_valoricms',0);
            Sistema.SetField('moes_basesubstrib',0);
            Sistema.SetField('moes_valoricmssutr',0);
            Sistema.SetField('moes_valortotal',xvlrbruto);
        Sistema.SetField('moes_dataemissao',dEmissao);
        Sistema.SetField('moes_natf_codigo','1102');
        Sistema.SetField('moes_freteciffob','1');
        Sistema.SetField('moes_frete',xfrete);
        Sistema.SetField('moes_vispra','P');

          Sistema.SetField('moes_especie','NFE');
          Sistema.SetField('moes_serie',FUnidades.getserie(Global.codigounidade));

          Sistema.SetField('moes_tran_codigo','001');
        Sistema.SetField('Moes_Perdesco',0);
        Sistema.SetField('Moes_Peracres',0);
        Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
//        Sistema.SetField('moes_mensagem',mensagem);
        Sistema.SetField('moes_fpgt_codigo',condicao);
//        Sistema.SetField('moes_pedido',Pedido);
        Sistema.SetField('moes_notapro',strtoint(ListaLinha[02]));
        Sistema.SetField('moes_funrural',xinss);
        Sistema.SetField('moes_cotacapital',xcotacapital);
// 27.07.16 - Coorlaf - Pitanga
        Sistema.SetField('moes_freteuni',xtxadm);
//        campo:=Sistema.GetDicionario('movesto','moes_plan_codigo');
 //       if campo.Tipo<>'' then
          Sistema.SetField('moes_plan_codigo',ContaGerencial);
       Sistema.Post();
{
       try
         Sistema.Commit;
       except
         Avisoerro('Problemas ao tentar gravar movesto');
       end;
}

       Sistema.Insert('movestoque');
        Sistema.SetField('move_esto_codigo',xcodigoleite);
        Sistema.SetField('move_transacao',transacao);
        Sistema.SetField('move_operacao',FGeral.GetOperacao);
        Sistema.SetField('move_numerodoc',xnfsaida);
        Sistema.SetField('move_status','N');
        Sistema.SetField('move_tipomov',Global.CodCompraProdutor);
        Sistema.SetField('move_unid_codigo',Global.CodigoUnidade);
        Sistema.SetField('move_tipo_codigo',xcodigosac);
        Sistema.SetField('move_tipocad',tipocad);
        Sistema.SetField('move_repr_codigo',1);
        Sistema.SetField('move_qtde',xlitros);
        Sistema.SetField('move_venda',xprecoliq);
        Sistema.SetField('move_datacont',Sistema.Hoje);
        Sistema.SetField('move_datalcto',Sistema.Hoje);
        Sistema.SetField('move_datamvto',dEmissao);
        Sistema.SetField('move_qtderetorno',0);
{
        Sistema.SetField('move_custo',QEstQtde.fieldbyname('esqt_custo').ascurrency);
        Sistema.SetField('move_custoger',QEstQtde.fieldbyname('esqt_custoger').ascurrency);
        Sistema.SetField('move_customedio',QEstQtde.fieldbyname('esqt_customedio').ascurrency);
        Sistema.SetField('move_customeger',QEstQtde.fieldbyname('esqt_customeger').ascurrency);
}
        Sistema.SetField('move_cst',xcst);
        Sistema.SetField('move_aliicms',0);
        Sistema.SetField('move_grup_codigo',TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
        Sistema.SetField('move_sugr_codigo',TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
        Sistema.SetField('move_fami_codigo',TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
        Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
        Sistema.SetField('move_aliipi',0);
        Sistema.SetField('move_pecas',0);
        Sistema.SetField('move_redubase',0);
        Sistema.SetField('move_natf_codigo','1102');
        Sistema.SetField('move_embalagem',1);
        Sistema.SetField('move_unitarionota',xprecoliq);
       Sistema.post();

// 28.05.15
       QProduto:=sqltoquery('select esqt_qtde,esqt_qtdeprev from estoqueqtde where'+
                            ' esqt_unid_codigo='+stringtosql(global.codigounidade)+' and esqt_esto_codigo='+Stringtosql(xcodigoleite)+
                            ' and esqt_status='+Stringtosql('N') );
       Sistema.edit('estoqueqtde');
       Sistema.SetField('esqt_qtde',QProduto.fieldbyname('esqt_qtde').ascurrency+xlitros);
       Sistema.SetField('esqt_qtdeprev',QProduto.fieldbyname('esqt_qtdeprev').ascurrency+xlitros);
       Sistema.post('esqt_unid_codigo='+stringtosql(global.codigounidade)+' and esqt_esto_codigo='+Stringtosql(xcodigoleite)+
                    ' and esqt_status='+Stringtosql('N') );
       FGeral.fechaquery(QProduto);
{
       try
         Sistema.Commit;
       except
         Avisoerro('Problemas ao tentar gravar movestoque');
       end;
}
       Sistema.Insert('movbase');
        Sistema.SetField('movb_transacao',Transacao);
        Sistema.SetField('movb_operacao',fGeral.GetOperacao);
        Sistema.SetField('movb_status','N');
        Sistema.SetField('movb_numerodoc',xnfsaida);
        Sistema.SetField('Movb_cst',xcst);
        Sistema.SetField('Movb_TpImposto','C' );
        Sistema.SetField('Movb_BaseCalculo',0);
        Sistema.SetField('Movb_Imposto',0);
        Sistema.SetField('Movb_Aliquota',0);
        Sistema.SetField('Movb_ReducaoBc',0);
        Sistema.SetField('Movb_Isentas',0);
        Sistema.SetField('Movb_Outras' ,0);
        Sistema.SetField('Movb_tipomov',Global.CodCompraProdutor);
        Sistema.SetField('Movb_unid_codigo',Global.CodigoUnidade);
        Sistema.SetField('Movb_natf_codigo','1102');
       Sistema.post();
{
       try
         Sistema.Commit;
       except
         Avisoerro('Problemas ao tentar gravar movbase');
       end;
}
       Sistema.Insert('pendencias');
          Sistema.SetField('Pend_Transacao',Transacao);
          Sistema.SetField('Pend_Operacao',FGeral.GetOperacao);
          Sistema.SetField('Pend_Status','N');
          Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
          Sistema.SetField('Pend_DataCont',Sistema.Hoje);
          Sistema.SetField('Pend_DataMvto',Sistema.Hoje);
          Sistema.SetField('Pend_DataVcto',FGeral.GetProximoDiaUtil(dEmissao+Inteiro(ListaPrazos[0])) );
          Sistema.SetField('Pend_DataEmissao',Sistema.Hoje);
          Sistema.SetField('Pend_Plan_Conta',contagerencial);
          Sistema.SetField('Pend_Unid_Codigo',Global.CodigoUnidade);
          Sistema.SetField('Pend_Fpgt_Codigo',Condicao);
          Sistema.SetField('Pend_Port_Codigo','');
          Sistema.SetField('Pend_Hist_Codigo',0);
          Sistema.SetField('Pend_Moed_Codigo','');
          Sistema.SetField('Pend_Repr_Codigo',1);
          Sistema.SetField('Pend_Tipo_Codigo',xcodigosac);
          Sistema.SetField('Pend_TipoCad'    ,'C');
          Sistema.SetField('Pend_Complemento','');
          Sistema.SetField('Pend_NumeroDcto',inttostr(xnfsaida));
          Sistema.SetField('Pend_Parcela',1);
          Sistema.SetField('Pend_NParcelas',1);
          Sistema.SetField('Pend_RP','P');
          Sistema.SetField('Pend_Valor',xvlrbruto-xinss-xcotacapital);
          Sistema.SetField('Pend_ValorTitulo',xvlrbruto-xinss-xcotacapital);
          Sistema.SetField('Pend_Juros',0);
          Sistema.SetField('Pend_Multa',0);
          Sistema.SetField('Pend_Mora',0);
          Sistema.SetField('Pend_Acrescimos',0);
          Sistema.SetField('Pend_Descontos',0);
          Sistema.SetField('Pend_ValorComissao',0);
          Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
          Sistema.SetField('Pend_ContaBaixa',0);
  //        Sistema.SetField('Pend_DataBaixa',0);
          Sistema.SetField('Pend_Observacao','');
//          Sistema.SetField('Pend_UsuAutPgto','');
          Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
          Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso j� foi enviado para impress�o
          Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exporta��o banc�ria (CNAB )
          Sistema.SetField('Pend_tipomov',Global.CodCompraProdutor);

       Sistema.post();

       try
         Sistema.Commit;
// atualiza contador de nota de saida da unidade
         xnfsaida:=FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+FGeral.Qualserie(QComv.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true)+1;

       except
         Avisoerro('Problemas ao tentar gravar nota do produtor '+inttostr(xcodigosac)+' '+FGeral.GetNomeRazaoSocialEntidade(xcodigosac,'C','N'));
       end;
     end;
     ListaLinha.Free;
   end;
   fGeral.FechaQuery(TEstoque);
    Sistema.Beginprocess('Atualizando munic�pios');
    for p:=0 to ListaMunicipios.count-1 do begin
      PMunicipios:=ListaMunicipios[p];
      AdicionaMunicipio;
    end;
   Sistema.endprocess('Importa��o terminada');
end;
// 31.12.14
function TFExpNfetxt.GetCodigoListaIbge(xMuni_nome: string): string;
///////////////////////////////////////////////////////////////////////
var p:integer;
    Lista:TStringlist;
begin
  result:='';
  for p:=0 to ListaIbge.count-1 do begin
     Lista:=TStringlist.create;
     Strtolista(Lista,ListaIbge.Strings[p],';',true);
     if (ansipos( uppercase(xmuni_nome),uppercase(lista[0]) )>0 ) or ( ansipos( xmuni_nome,lista[0] )>0 ) then begin
         result:=copy(Lista[0],1,7);
         break;
     end;
  end;
end;

// 31.12.14
procedure TFExpNfetxt.SetaCodigosIbge;
///////////////////////////////////////////////////////////////////////
var Lista,ListaCidade:TStringlist;
    p:integer;
begin
   ListaIbge:=TStringlist.create;;
   if FileExists('tabela_municipios.csv') then begin
      Lista:=TStringlist.create;
        Lista.LoadFromFile('tabela_municipios.csv');
        for p:=0 to Lista.count-1 do begin
           ListaCidade:=TStringlist.create;
           Strtolista(ListaCidade,Lista[p],';',true);
           if ListaCidade.count=3 then
             ListaIbge.Add(ListaCidade[1]+' '+strspace(ListaCidade[2],30)+' '+strspace(ListaCidade[0],20));
        end;
   end;
end;

procedure TFExpNfetxt.bconsultareciboClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
begin

  acbrnfe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(EdUnid_codigo.text);
  ACBrNFe1.WebServices.Recibo.Recibo := EdRecibo.text;;
  ACBrNFe1.WebServices.Recibo.Executar;

//  MemoResp.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.Recibo.RetWS);
//  memoRespWS.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.Recibo.RetornoWS);
//  LoadXML(MemoResp, WBResposta);

//  pgRespostas.ActivePageIndex := 1;

  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Consultar Recibo');
  MemoDados.Lines.Add('tpAmb: '    +TpAmbToStr(ACBrNFe1.WebServices.Recibo.tpAmb));
  MemoDados.Lines.Add('versao: ' +ACBrNFe1.WebServices.Recibo.versao);
  MemoDados.Lines.Add('verAplic: ' +ACBrNFe1.WebServices.Recibo.verAplic);
  MemoDados.Lines.Add('cStat: '    +IntToStr(ACBrNFe1.WebServices.Recibo.cStat));
  MemoDados.Lines.Add('xMotivo: '  +ACBrNFe1.WebServices.Recibo.xMotivo);
  MemoDados.Lines.Add('cUF: '    +IntToStr(ACBrNFe1.WebServices.Recibo.cUF));
  MemoDados.Lines.Add('xMsg: ' +ACBrNFe1.WebServices.Recibo.xMsg);
  MemoDados.Lines.Add('cMsg: '    +IntToStr(ACBrNFe1.WebServices.Recibo.cMsg));
  MemoDados.Lines.Add('Recibo   : ' +ACBrNFe1.WebServices.Recibo.Recibo);
  MemoDados.Lines.Add('Chave NFe: ' +ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtDFe.Items[0].chDFe);

end;

///////////////////////////////////////////////////////////
procedure TFExpNfetxt.bpreviewxmlClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

   EnviaConsultaSefa('P');


end;
//////////// 15.07.16
procedure TFExpNfetxt.baltentradaClick(Sender: TObject);
////////////////////////////////////////////////////////////
var xtrans:string;
begin
   xtrans:=Grid.Cells[Grid.getcolumn('moes_transacao'),Grid.row];
   FNotaCompra.Execute('A',xtrans);
end;

// 13.10.16
function TFExpNfetxt.GetxMotivo(xml,xchave: string): string;
///////////////////////////////////////////////////////////
var p:integer;
    s:string;
begin
   xchave:=StrToStrNumeros(xchave);
   p:=pos( xchave,xml );
   result:='';
   if p>0 then begin
      s:=copy(xml,p,500);
      s:=copy(s,1,pos('</xMotivo>',s)+11);
      result:=GetTag('xMotivo',s);
   end;
end;

procedure TFExpNfetxt.PBotoesClick(Sender: TObject);
begin
end;

// 23.11.16
function TFExpNfetxt.ValidaSchema( xNfe:TNotasFiscais ):boolean ;
////////////////////////////////////////////////////////////////
var  Erro, AXML: String;
  NotaEhValida, ok: Boolean;
  ALayout: TLayOut;
  VerServ: Real;
  Modelo: TpcnModeloDF;
  cUF,p: Integer;
begin
  result:=true;
  for p:=0 to xNFe.Count-1 do begin
    AXML := xNFe.Items[p].XMLAssinado;
    ALayout := LayNfeAutorizacao;
    VerServ := xNFe.Items[p].NFe.infNFe.Versao;
    Modelo  := StrToModeloDF(ok, IntToStr(xNFe.Items[p].NFe.Ide.modelo));
    cUF     := xNFe.Items[p].NFe.Ide.cUF;
//    AXML := '<NFe xmlns' + RetornarConteudoEntre(AXML, '<NFe xmlns', '</NFe>') + '</NFe>';
// 07.02.18
    AXML := '<NFe xmlns' + GetTag(AXML, '<NFe>');
    NotaEhValida := AcbrNfe1.SSL.Validar(AXML, AcbrNfe1.GerarNomeArqSchema(ALayout, VerServ), Erro);
    if not NotaEhValida then begin
      Avisoerro( 'Falha na valida��o dos dados da nota: ' +
          IntToStr(xNFe.Items[p].NFe.Ide.nNF) + sLineBreak +
//          copy(xNFe.Items[p].Alertas,1,4000) ) ;
//          FErroValidacaoCompleto := FErroValidacao + sLineBreak + Erro;
          copy(erro,1,4000) ) ;
      result:=false;
    end;
  end;
end;

// 07.09.2022 - Percorre o grid e checa se tem somente NFe ou somente NFCe
function TFExpNfetxt.VerificaNotas: boolean;
///////////////////////////////////////////
var i:integer;
    xespecie:string;
begin

  xespecie:='NFE';
  if trim( Grid.Cells[Grid.getcolumn('moes_especie'),1] )<>'' then
      xespecie:=Grid.Cells[Grid.getcolumn('moes_especie'),1]
  else if xsituacaonotas='NFCe' then
      xespecie:='NFCE';
  result:=true;

  for i:=1 to Grid.RowCount do begin
    if trim( Grid.Cells[Grid.getcolumn('moes_numerodoc'),i] )<>'' then begin

//       if trim(Grid.Cells[Grid.GetColumn('moes_especie'),i]) <> xespecie then begin
// 08.11.2022 - com uma nfe 'sozinha' dava msg ... NFE <> NFE...bem loke...
       if (Grid.Cells[Grid.GetColumn('moes_especie'),i]) <> xespecie then begin

          result:=false;
          Avisoerro('N�o � permitido autorizar NOTAS CONSUMIDOR com NOTAS "DANFE"');
          break;

       end;

    end;
  end;

end;

end.
