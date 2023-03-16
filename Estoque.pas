{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
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

unit Estoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel, SqlDtg, Printers, Async32, SqlExpr, ExtDlgs,
  ComCtrls, SqlSis, VCL.FileCtrl ,
//  Buttons, SQLBtn, alabel, SqlDtg, DataGrid, Printers, Async32 ;
  ACBrDANFCeFortesFrEA,
  ACBrDANFCeFortesFrETQEST,
  ACBrBase, ACBrDFe, ACBrNFe, pcnconversao, ACBrCargaBal;

type
  TFEstoque = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bAlterar: TSQLBtn;
    bExcluir: TSQLBtn;
    bCancelar: TSQLBtn;
    bbuscar: TSQLBtn;
    bduplicar: TSQLBtn;
    bPesquisar: TSQLBtn;
    bSair: TSQLBtn;
    bExpColumn: TSQLBtn;
    Bevel1: TBevel;
    bRedColumn: TSQLBtn;
    bMoveLeft: TSQLBtn;
    bMoveRight: TSQLBtn;
    bDelColumn: TSQLBtn;
    bRestColumn: TSQLBtn;
    bLoadGrid: TSQLBtn;
    bSaveGrid: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    PEdits: TSQLPanelGrid;
    Grid: TSQLGrid;
    Dts: TDataSource;
    EdEsto_codigo: TSQLEd;
    EdEsto_descricao: TSQLEd;
    EdEsto_unidade: TSQLEd;
    EdEsto_embalagem: TSQLEd;
    EdEsto_qtde: TSQLEd;
    EdEsto_qtdeprev: TSQLEd;
    EdEsto_peso: TSQLEd;
    EdEsto_vendavis: TSQLEd;
    EdEsto_custo: TSQLEd;
    EdEsto_customedio: TSQLEd;
    EdEsto_customeger: TSQLEd;
    EdEsto_dtultvenda: TSQLEd;
    EdEsto_dtultcompra: TSQLEd;
    EdEsto_codbarra: TSQLEd;
    EdEsto_desconto: TSQLEd;
    EdEsto_basecomissao: TSQLEd;
    EdEsto_icmsestado: TSQLEd;
    EdEsto_icmsforaestado: TSQLEd;
    EdEsto_sitt_codestado: TSQLEd;
    EdEsto_sitt_forestado: TSQLEd;
    EdEsto_grup_codigo: TSQLEd;
    EdEsto_sugr_codigo: TSQLEd;
    EdEsto_usua_codigo: TSQLEd;
    EdESTO_GRAD_CODIGO: TSQLEd;
    SetEdgrup_codigo: TSQLEd;
    SetEdsugr_descricao: TSQLEd;
    SetEdsitt_cst: TSQLEd;
    SetEd: TSQLEd;
    SetEdgrad_descricao: TSQLEd;
    Btgravar: TSQLBtn;
    bdigitargrade: TSQLBtn;
    PGrade: TSQLPanelGrid;
    GridGrade: TSqlDtGrid;
    EdGrade: TSQLEd;
    bterminargrade: TSQLBtn;
    EdEsto_mate_codigo: TSQLEd;
    SetEdmate_descricao: TSQLEd;
    EdEsto_cfis_codigoest: TSQLEd;
    EdEsto_cfis_codigoforaest: TSQLEd;
    bDadosgrade: TSQLBtn;
    EdEsto_custoger: TSQLEd;
    Edesto_emlinha: TSQLEd;
    Edesto_qtdeminimo: TSQLEd;
    Edesto_qtdemaximo: TSQLEd;
    EdEsto_fami_codigo: TSQLEd;
    Edesto_fami_descricao: TSQLEd;
    bimpcodbarra: TSQLBtn;
    Edqtdeprev: TSQLEd;
    PVenda: TSQLPanelGrid;
    EdVenda: TSQLEd;
    Edsaldo: TSQLEd;
    PCustoZerado: TSQLPanelGrid;
    Edcustogerencial: TSQLEd;
    Edcustofiscal: TSQLEd;
    batuvenda: TSQLBtn;
    EdEsto_sisvendas: TSQLEd;
    Setedsisvendas: TSQLEd;
    EdEsto_categoria: TSQLEd;
    SetEdesto_categoria: TSQLEd;
    EdEsto_referencia: TSQLEd;
    Edesto_precocompra: TSQLEd;
    Edesto_cipi_codigo: TSQLEd;
    SetEddescriipi: TSQLEd;
    EdEsto_Vendamin: TSQLEd;
    EdEsto_Pecas: TSQLEd;
    balteracampo: TSQLBtn;
    PLocaliza: TSQLPanelGrid;
    Edlocalizacao: TSQLEd;
    blocaliza: TSQLBtn;
    Edmobra: TSQLEd;
    EdMomedio: TSQLEd;
    bsimilares: TSQLBtn;
    EdCompminimo: TSQLEd;
    EdPontoressu: TSQLEd;
    EdQtdeprocesso: TSQLEd;
    PFigura: TSQLPanelGrid;
    babrir: TSQLBtn;
    bimagem: TSQLBtn;
    bfechaimagem: TSQLBtn;
    bgravaimagem: TSQLBtn;
    opd: TOpenDialog;
    Image1: TImage;
    Edcompra: TSQLEd;
    EdMargemBruta: TSQLEd;
    Edesqt_cfis_codestsemie: TSQLEd;
    SetEdcfis_aliquota: TSQLEd;
    EdEsto_nutr_codigo: TSQLEd;
    benviabalanca: TSQLBtn;
    EdEsto_ingr_codigo: TSQLEd;
    EdEsto_cons_codigo: TSQLEd;
    EdEsto_cons_codigo1: TSQLEd;
    Edesto_tara: TSQLEd;
    Edesto_qbalanca: TSQLEd;
    Edesto_validade: TSQLEd;
    Edesto_qetiqbalanca: TSQLEd;
    Edpesquisa: TSQLEd;
    PEmEstoque: TSQLPanelGrid;
    Label1: TLabel;
    Pprecovenda: TSQLPanelGrid;
    Label2: TLabel;
    EdEsto_sitt_codestadonc: TSQLEd;
    SQLEd2: TSQLEd;
    EdEsto_sitt_forestadonc: TSQLEd;
    SQLEd4: TSQLEd;
    Edcfis_codestnc: TSQLEd;
    SQLEd3: TSQLEd;
    Edcfis_codigoforaestnc: TSQLEd;
    SQLEd6: TSQLEd;
    EdEsto_faix_codigo: TSQLEd;
    Edesto_taracf: TSQLEd;
    Edesto_taraperc: TSQLEd;
    bdetalhes: TSQLBtn;
    Pobs: TSQLPanelGrid;
    textoobs: TRichEdit;
    EdEsto_faix_codigo002: TSQLEd;
    Edesto_grup_descricao: TSQLEd;
    EdEsto_validaderes: TSQLEd;
    Edesto_cons_codigores: TSQLEd;
    bequipamento: TSQLBtn;
    PEquipamento: TSQLPanelGrid;
    EdEqui_codigo: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    ACBrNFe1: TACBrNFe;
    pd: TPrintDialog;
    bativos: TSQLBtn;
    ACBrCargaBal1: TACBrCargaBal;
    procedure bIncluirClick(Sender: TObject);
    procedure bAlterarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdEsto_icmsforaestadoExitEdit(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bExcluirClick(Sender: TObject);
    procedure bsimilaresClick(Sender: TObject);
    procedure BtgravarClick(Sender: TObject);
    procedure Ativaedit;
    procedure EdGradeValidate(Sender: TObject);
    procedure GridGradeDblClick(Sender: TObject);
    procedure GridGradeKeyPress(Sender: TObject; var Key: Char);
    procedure bterminagradeClik(Sender: TObject);
    procedure bdigitargradeClick(Sender: TObject);
    procedure EdGradeKeyPress(Sender: TObject; var Key: Char);
    procedure EdEsto_codbarraValidate(Sender: TObject);
    procedure EdEsto_descricaoValidate(Sender: TObject);
    procedure bDadosgradeClick(Sender: TObject);
    procedure Edesto_qtdemaximoValidate(Sender: TObject);
    procedure bimpcodbarraClick(Sender: TObject);
    procedure EdqtdeprevKeyPress(Sender: TObject; var Key: Char);
    procedure EdqtdeprevValidate(Sender: TObject);
    procedure EdVendaClick(Sender: TObject);
    procedure EdVendaKeyPress(Sender: TObject; var Key: Char);
    procedure EdEsto_codigoValidate(Sender: TObject);
    procedure EdEsto_sitt_codestadoValidate(Sender: TObject);
    procedure EdcustogerencialExitEdit(Sender: TObject);
    procedure batuvendaClick(Sender: TObject);
    procedure EdEsto_sisvendasValidte(Sender: TObject);
    procedure EdEsto_categoriaValidate(Sender: TObject);
    procedure bduplicarClick(Sender: TObject);
    procedure EdEsto_VendaminValidate(Sender: TObject);
    procedure blocalizaClick(Sender: TObject);
    procedure EdlocalizacaoExitEdit(Sender: TObject);
    procedure babrirClick(Sender: TObject);
    procedure bfechaimagemClick(Sender: TObject);
    procedure bimagemClick(Sender: TObject);
    procedure bgravaimagemClick(Sender: TObject);
    procedure APHeadLabel1DblClick(Sender: TObject);
    procedure EdcompraValidate(Sender: TObject);
    procedure EdEsto_sitt_forestadoValidate(Sender: TObject);
    procedure EdEsto_cfis_codigoestValidate(Sender: TObject);
    procedure benviabalancaClick(Sender: TObject);
    procedure EdMargemBrutaValidate(Sender: TObject);
    procedure bPesquisarClick(Sender: TObject);
    procedure EdpesquisaExitEdit(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure EdpesquisaExit(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdEsto_referenciaValidate(Sender: TObject);
    procedure Edesto_cipi_codigoValidate(Sender: TObject);
    procedure bbuscarClick(Sender: TObject);
    procedure balteracampoClick(Sender: TObject);
    procedure bdetalhesClick(Sender: TObject);
    procedure textoobsExit(Sender: TObject);
    procedure EdEsto_grup_codigoValidate(Sender: TObject);
    procedure bequipamentoClick(Sender: TObject);
    procedure EdEqui_codigoExitEdit(Sender: TObject);
    procedure bativosClick(Sender: TObject);
    procedure GridCellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetDescricao(codigo:string;retornamsg:string='S'):string;
    function GetCodigoGrade(codigo:string):integer;
    function GetCodigoLinha(produto:string;grade:integer):integer;
    function GetCodigoColuna(produto:string;grade:integer):integer;
    function Somaqtdes(GridGrade:TSqlDtGrid):extended;
    procedure Gravagrade(Op:string);
    procedure GravadadosGrade(Qtde:currency;linha,coluna:integer);
    procedure QtdetoGrid(GridGrade:TSqlDtgrid;Codproduto:string;CodGrade:integer);
    procedure DadosQtdetoEdits(CodigoProduto:string;Unidade:string);
    function GetPreco(Produto,Unidade: string ; ufcliente:string='' ; aliicms:currency=0 ; Tipo:string='F' ; valorbase:currency=0; xcontribuinte:string=''): currency;
    function Getsituacaotributaria(codigoestoque,unidade,UF:string ;Tipomov:string=''; Codigo:integer=0 ; revenda:string='N' ; Simples:string='N'; mens:string='' ):string;
    function Getaliquotaicms(codigoestoque, unidade, UF: string ; Codigo:integer=0 ; Tipomov:string='' ; revenda:string='N' ; ytipocad:string='C'): currency;
    function GetCodigoFiscal(codigoestoque,unidade,UF:string;xrevenda:string='N'; Tipomov:string='VD'):string;
    function GetPerBaseComissao(produto,unidade:string):currency;
    function GetUnidade(codigo:string):string;
    function GetCodigosituacaotributaria(codigoestoque,unidade,UF:string; xcooperado:string='N'; codigo:integer=0 ; xtipomov:string='@@'):integer;
    function TrazQtde(linha,coluna:integer):currency;
    procedure ColocaQtde(linha,coluna:integer;qtde:extended);
    function GetAliquotaIcmsEstado(UFcliente,Tipo:string;Es:string='S'):currency;
    function GetSqlCustos(Produto, Unidade: string ; tamanho:integer=0;cor:integer=0): string;
    function GetGrupo(codigo:string):integer;
//    function GetCodTamanho(Produto,Unidade: string): currency;
    function GetCusto(Produto,Unidade,tipo: string): currency;
    function GetCustoZerado(Produto,tipo: string): currency;
    function GetSubGrupo(codigo:string):integer;
    function GetFamilia(codigo:string):integer;
    function ValidaCodigoProduto(Ed:TSqled=nil ; produto:string=''):boolean;
    function GetSistemaVendas(Produto,Unidade: string): string;
    function GetCF(codigoestoque,unidade,UF:string):string;
// 22.06.06
    procedure SetaItems(Edit,EditNomeForne:TSqlEd;ForneValidos,Nomevalido:String);
// 25.08.06
    function Getaliquotaipi(codigoestoque: string ; incideipi:string='S' ; TipoMov:string=''): currency;
// 22.0.07
   function ValidaPrecoVenda( Produto,Unidade:string ; Venda:currency ; usuario:integer):boolean;
// 20.11.07
   Function GetProximoCodigo(tabela,campo,tipocampo:string; tamvariavel:boolean=false):variant;
// 20.05.08
   Function GetQtdeEmEstoque(unidade,codigo:string;codcor:integer=0;codtamanho:integer=0):currency;
// 21.05.08
   Function GetQtdeEmEstoqueComprimento(unidade,codigo:string;var xcodtamanho:integer;codcor:integer=0;
            comprimento:extended=0;variacao:currency=50):currency;
// 24.06.08
   function GetNCMipi(codigoestoque: string ): string;
// 24.09.08
   function ValidaComprimentoMinimo(produto:string;comp:extended):boolean;
// 21.04.09
   function ImpQualCodigo(codigo,referencia:string):string;
   function CalculaMarkup(custo,xmarkup:extended;codgrupo:integer=0):extended;
// 29.05.09
   function GetPrecodeCompra(codigoestoque:string ):extended;
// 03.09.09 - Abra
   function CalculaMargem(custo,margem:extended;codgrupo:integer=0):extended;
// 16.09.09
   function GetaliquotaIss(codigoestoque, unidade, UF: string): currency;
// 22.10.09
   function GetReferencia(codigo:string):string;
// 24.10.09
   function GetReferenciaouCodigo(codigo:string):string;
// 01.12.09
   function GetPeso(codigo:string):currency;
// 14.10.10
   function EstaCadastrado(unidade,produto:string):boolean;
// 03.11.10
   function Servico(produto,unidade,ufunidade:string):boolean;
// 10.12.10
   function GetCodigoCSTipi(codigoestoque: string  ; xES:string=''): String;
// 17.01.11
   function IsMinuscula(c:string):boolean;
// 22.02.11
   function ValidaCodCst(codigocst:integer ;dentroestado:string): boolean;
// 13.10.11
   function GetsituacaotributariaPIS(codigoestoque,unidade,UF:string;Es:string='S';mens:string='' ):string;
   function GetsituacaotributariaCOFINS(codigoestoque,unidade,UF:string;Es:string='S';mens:string=''):string;
// 21.10.11
   function GetCOFINSpeloCSTICMS(xcst,xes:string;xSimples:string='N';subgrupo:integer=0):string;
   function GetPISpeloCSTICMS(xcst,xes:string;xSimples:string='N';xtransacao:string='';subgrupo:integer=0):string;
// 10.11.11
   procedure ConfiguraEdits( hab:boolean );
// 02.07.13
   function GetComprimentoPadrao(unidade,codigo:string):currency;
// 13.07.13
   function BuscaporReferenciaouCodigo(codigo:string):TSqlquery;
// 22.07.13
   function GetPrecoGrade(Produto,Unidade: string ; xcodtam,xcodcor:integer  ): currency;
// 03.03.16
    function GetEmbalagem(codigo:string):integer;
// 26.06.16
   function GetCESTNCM(codigoestoque: string ): string;
// 31.03.16
   function GetMargemcomST(xUfCliente,yContribuinte:string):currency;
// 21.07.16
   function GetArqEtiqueta( cprod,sexo:string ):string;
// 18.10.16
   function GetCodigoIPINCM( codigo:string ):integer;
// 19.10.16
   function GetPercComissaoporFaixa(codigo:string;venda:currency):currency;
// 17.08.17 - MA - macho  FE - femea
   function GetCategoria(codigo:string):string;
// 20.10.17 - traz o codigo 'de origem' da composicao para identificar o 'sexo do corte'
   function GetCustoOrigem(codigo:string):string;
// 21.09.18
   function GetTolerancia(codigo:string):currency;
// 03.10.18
   procedure SetaItemsporGrupo(Ed:TSqled;xgrupo:integer);
// 06.01.2021
   function ValidaTributacaoProduto( Produto,uf,tipomov:string ):boolean;
// 18.06.21
   function GetCodigodeBarra( codigo:string ):string;

  end;

type TListaQtde=record
     linha,coluna:integer;
     qtde:currency;
     end;

type TListaCest=record
     cest,ncm:string;
end;


var
  FEstoque: TFEstoque;
  Op,Unidade,codigosuni,codfiscalest,codfiscalfest:string;
  PListaQtde:^TListaQTde;
  ListaQtde,ListaCest:Tlist;
  AtuVenda:boolean;
  customeger,vendavis:currency;
  campo,campotara,campofaixa,campotaraperc,
  campoobs,
  campofaixa002,
  campogrupodescricao,
  campovalidaderes:TDicionario;
////////////////  EdtLeft,EdtTop:integer;
  EdtLeftx:integer;
  PListaCest:^TListaCest;
  ListaAuxCest,ListaporUnidade:TStringList;
  QX:TSqlquery;

implementation

uses Arquiv, grupos, Sittribu, Subgrupos, Geral, Sqlfun,
  Grades, SQLRel, cadcor, tamanhos, dadosgrade, codigosfis, similares,
  impressao, listaimagens, munic, Unidades, faixas, JPEG;

{$R *.dfm}

procedure TFEstoque.bIncluirClick(Sender: TObject);
///////////////////////////////////////////////////////////
begin
  Op:='I';
  EdEsto_codigo.SetStatusEdits(Self,99,seEdit);
  Grid.Cancel;
  PEdits.Visible:=true;
  PEdits.EnableEdits;
  EdEsto_Codigo.ClearAll(Self,99);
  if Global.Topicos[1203] then begin
    EdEsto_codigo.Text:=GetProximoCodigo('estoque','esto_codigo','C',true);
    if Global.Topicos[1241] then
// 24.08.2022 - Devereda 'loqueou' tabela estoque
//       EdEsto_codigo.text:=IntToStr( FGeral.GetContador('CODIGOESTOQUE',false,FALSE)+1);
       EdEsto_codigo.text:=StrZero( FGeral.GetContador('CODIGOESTOQUE',false,FALSE)+1,FGeral.GetConfig1AsInteger('TAMESTOQUE'));

  end;

  EdEsto_codigo.enabled:= not Global.Topicos[1203];
// 04.02.09
  EdEsto_descricao.CharUpperLower:= not Global.Topicos[1207];
// 03.05.10
  if Global.Topicos[1212] then
    EdEsto_descricao.CharCase:=ecUpperCase;
  EdEsto_embalagem.Text:='1';
  EdEsto_dtultvenda.Setdate(Sistema.Hoje);
  EdEsto_dtultcompra.Setdate(Sistema.Hoje);
  bSair.enabled:=false;
// 07.03.08
    EdEsto_sitt_codestado.setvalue(GetSittDentro(Global.CodigoUnidade));
    EdEsto_sitt_codestado.ValidFind;
    EdEsto_sitt_forestado.setvalue(GetSittFora(Global.CodigoUnidade));
    EdEsto_sitt_forestado.ValidFind;
    EdEsto_cfis_codigoest.text:=GetFiscalDentro(Global.CodigoUnidade);
    EdEsto_cfis_codigoest.ValidFind;
    EdEsto_cfis_codigoforaest.text:=GetFiscalFora(Global.CodigoUnidade);
    EdEsto_cfis_codigoforaest.ValidFind;

  if Global.Topicos[1203] then
    EdEsto_descricao.setfocus
  else
    EdEsto_Codigo.SetFocus;

  if Global.Topicos[1208] then
    EdEsto_descricao.MaxLength:=100
  else
    EdEsto_descricao.MaxLength:=50;
// 10.11.11
  ConfiguraEdits( Global.topicos[1218] );
  bPesquisar.Enabled:=false;
end;

procedure TFEstoque.bAlterarClick(Sender: TObject);
////////////////////////////////
begin
  Op:='A';
  bincluir.Enabled:=false;
///////////////////  Grid.Cancel;
  PEdits.Visible:=true;
  PEdits.EnableEdits;
//////////////////  EdEsto_codigo.SetStatusEdits(Self,99,seEditall);
  EdEsto_Codigo.Enabled:=False;
  EdEsto_Codigo.GetFields(FEstoque,99);
// 29.08.15
  Edcfis_codestnc.Enabled:=false;
  Edcfis_codigoforaestnc.Enabled:=false;
///
// 04.02.09 - aqui em 17.01.11 - Itacir
  EdEsto_descricao.CharUpperLower:= not Global.Topicos[1207];
// 03.05.10
  if Global.Topicos[1212] then
    EdEsto_descricao.CharCase:=ecUpperCase;
// 06.10.11
  if Global.Topicos[1208] then
    EdEsto_descricao.MaxLength:=100
  else
    EdEsto_descricao.MaxLength:=50;
// 21.08.18

//  DadosQtdetoEdits(EdEsto_codigo.Text,Global.CodigoUnidade);
//////  bSair.enabled:=false;
  EdEsto_descricao.SetFocus;
  customeger:=EdEsto_customeger.ascurrency;  // 15.02.06
  vendavis:=EdEsto_vendavis.ascurrency;  // 11.09.06
// 13.02.2023
  codfiscalest:=EdEsto_cfis_codigoest.text;
  codfiscalfest:=EdEsto_cfis_codigoforaest.text;
// 10.11.11
  ConfiguraEdits( true );
//  bDigitargrade.Enabled:=EdEsto_grad_codigo.ValidFind;

//  bDadosgrade.Enabled:=EdEsto_grad_codigo.ValidFind;

//  bTerminargrade.Enabled:=EdEsto_grad_codigo.ValidFind;

end;

procedure TFEstoque.FormActivate(Sender: TObject);
/////////////////////////////////////////////////////
var QE:Tsqlquery;
begin
//  if true then    // Global.Topicos
//    Arq.TEstoque.OpenWith('',Arq.TEstoque.Ordenacao);
//  else

//  if not Arq.TEstoque.Active then Arq.TEstoque.Open;


//  FGeral.AbreEstoque;
// 25.04.19
  FGeral.ConfiguraColorEditsNaoEnabled(FEstoque);

// 09.09.16
  if Global.Topicos[1025] then begin

    if not Arq.TEstoque.active then begin
      ListaporUnidade:=TStringList.Create;
      Qe:=sqltoquery('select esqt_esto_codigo from estoqueqtde where esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                     ' and esqt_status = ''N'' order by esqt_esto_codigo');
      codigosuni:='';
      while not Qe.eof do begin
        ListaporUnidade.Add(qe.fieldbyname('esqt_esto_codigo').asstring);
        codigosuni:=codigosuni+qe.fieldbyname('esqt_esto_codigo').asstring+';';
        Qe.Next;
      end;
      FGeral.FechaQuery(Qe);
    end;
    Arq.TEstoque.OpenWith(FGeral.GetIN('esto_codigo',codigosuni,'C'),Arq.TEstoque.Ordenacao);

//  end else if Global.Usuario.Codigo=100 then  begin
//
//      Arq.TEstoque.OpenWith('esto_emlinha = ''S''',Arq.TEstoque.Ordenacao);

  end else  begin

       Arq.TEstoque.open;

  end;

  Grid.Refresh;
  Fgeral.ColunasGrid(Grid,Self);

  if not Arq.TSittributaria.Active then Arq.TSittributaria.Open;
//  Grid.Cancel;
  EdEsto_Codigo.ClearAll(Self,99);
  PEdits.DisableEdits;
  Unidade:=Global.CodigoUnidade;
// 12.08.19
  FGeral.SetaItemsCategoria(EdEsto_categoria);

// 20.05.11 - Damama
  campo:=Sistema.GetDicionario('estoque','esto_nutr_codigo');
  campotara:=Sistema.GetDicionario('estoque','esto_tara');
  campotaraperc:=Sistema.GetDicionario('estoque','esto_taraperc');
  campofaixa:=Sistema.GetDicionario('estoque','esto_faix_codigo');
// 24.08.17
  campoobs:=Sistema.GetDicionario('estoque','esto_obs');
// 23.05.18
  campofaixa002:=Sistema.GetDicionario('estoque','esto_faix_codigo002');
// 12.02.19  - Novicarnes
  campogrupodescricao:=Sistema.GetDicionario('estoque','esto_grup_descricao');
// 08.03.19
  campovalidaderes:=Sistema.GetDicionario('estoque','esto_validaderes');

  if Campo.Tipo<>'' then begin

    Edesto_nutr_codigo.Enabled:=true;
    Edesto_nutr_codigo.TableName:='estoque';
    Edesto_ingr_codigo.Enabled:=true;
    Edesto_ingr_codigo.TableName:='estoque';
    Edesto_cons_codigo.Enabled:=true;
    Edesto_cons_codigo.TableName:='estoque';
    Edesto_cons_codigo1.Enabled:=true;
    Edesto_cons_codigo1.TableName:='estoque';
  end else begin

    Edesto_nutr_codigo.Enabled:=false;
    Edesto_nutr_codigo.TableName:='';
    Edesto_ingr_codigo.Enabled:=false;
    Edesto_ingr_codigo.TableName:='';
    Edesto_cons_codigo.Enabled:=false;
    Edesto_cons_codigo.TableName:='';
    Edesto_cons_codigo1.Enabled:=false;
    Edesto_cons_codigo1.TableName:='';

  end;
// 03.06.11
  if CampoTara.Tipo<>'' then begin
    Edesto_tara.Enabled:=true;
    Edesto_tara.TableName:='estoque';
    Edesto_qbalanca.Enabled:=true;
    Edesto_qbalanca.TableName:='estoque';
    Edesto_validade.Enabled:=true;
    Edesto_validade.TableName:='estoque';
    Edesto_qetiqbalanca.Enabled:=true;
    Edesto_qetiqbalanca.TableName:='estoque';
  end else begin
    Edesto_tara.Enabled:=false;
    Edesto_tara.TableName:='';
    Edesto_qbalanca.Enabled:=false;
    Edesto_qbalanca.TableName:='';
    Edesto_validade.Enabled:=false;
    Edesto_validade.TableName:='';
    Edesto_qetiqbalanca.Enabled:=false;
    Edesto_qetiqbalanca.TableName:='';
  end;
//////////
// 22.09.16
  if CampoTaraperc.Tipo<>'' then begin
    Edesto_taraperc.Enabled:=true;
    Edesto_taraperc.TableName:='estoque';
    Edesto_taracf.Enabled:=true;
    Edesto_taracf.TableName:='estoque';
  end else begin
    Edesto_taraperc.Enabled:=false;
    Edesto_taraperc.TableName:='';
    Edesto_taracf.Enabled:=false;
    Edesto_taracf.TableName:='';
  end;

// 26.07.13 - Metalnorte
  campo:=Sistema.GetDicionario('estoque','esto_fami_descricao');
  if Campo.Tipo<>'' then begin
    Edesto_fami_descricao.TableName:='estoque';
//    SetEdfami_descricao.TableField:='esto_fami_descricao';
    Edesto_fami_descricao.enabled:=true;
  end else begin
    Edesto_fami_descricao.TableName:='';
    Edesto_fami_descricao.TableField:='';
    Edesto_fami_descricao.enabled:=false;
  end;
// 12.02.19 - Novicarnes
  campogrupodescricao:=Sistema.GetDicionario('estoque','esto_grup_descricao');
  if Campogrupodescricao.Tipo<>'' then begin

    Edesto_grup_descricao.TableName:='estoque';
    Edesto_grup_descricao.enabled:=true;
    Edesto_grup_descricao.visible:=true;
    Edesto_grup_descricao.TableField:='esto_grup_descricao';

  end else begin

    Edesto_grup_descricao.TableName:='';
    Edesto_grup_descricao.TableField:='';
    Edesto_grup_descricao.enabled:=false;
    Edesto_grup_descricao.visible:=false;

  end;
// 08.03.19 - Novicarnes
  if campovalidaderes.Tipo<>'' then begin

     Edesto_validaderes.Enabled  :=true;
     Edesto_validaderes.Tablename:='estoque';
     Edesto_validaderes.TableField:='esto_validaderes';
     EdEsto_cons_codigores.Enabled :=true;
     Edesto_cons_codigores.Tablename:='estoque';
     Edesto_cons_codigores.TableField:='esto_cons_codigores';

  end else begin

     Edesto_validaderes.Enabled  :=false;
     Edesto_validaderes.Tablename:='';
     Edesto_validaderes.TableField:='';
     EdEsto_cons_codigores.Enabled :=false;
     Edesto_cons_codigores.Tablename:='';
     Edesto_cons_codigores.TableField:='';

  end;

  //////////////////////////
// 15.03.16 - Novicarnes
//  if Campofaixa.Tipo<>'' then begin
//    Edesto_faix_codigo.TableName:='estoque';
//    Edesto_faix_codigo.TableField:='esto_faix_codigo';
//    Edesto_faix_codigo.enabled:=true;
//    Edesto_faix_codigo.visible:=true;
//    Edesto_faix_codigo.Update;
//  end else begin
    Edesto_faix_codigo.TableName:='';
    Edesto_faix_codigo.TableField:='';
    Edesto_faix_codigo.enabled:=false;
    Edesto_faix_codigo.visible:=false;
//  end;
// 23.05.18 - Novicarnes
//  if Campofaixa002.Tipo<>'' then begin
//    Edesto_faix_codigo002.TableName:='estoque';
//    Edesto_faix_codigo002.TableField:='esto_faix_codigo002';
//    Edesto_faix_codigo002.enabled:=true;
//    Edesto_faix_codigo002.visible:=true;
//    Edesto_faix_codigo002.Update;
//  end else begin
    Edesto_faix_codigo002.TableName:='';
    Edesto_faix_codigo002.TableField:='';
    Edesto_faix_codigo002.enabled:=false;
    Edesto_faix_codigo002.visible:=false;
//  end;

// 24.08.17 - Sport acao
  if Campoobs.Tipo<>'' then begin
    bdetalhes.Visible:=true;
    bdetalhes.Enabled:=true;
  end else begin
    bdetalhes.Visible:=false;
    bdetalhes.Enabled:=false;
  end;

// 12.02.19 - Novicarnes
  if Campogrupodescricao.Tipo<>'' then begin

    EdEsto_grup_descricao.Enabled:=True;
    Edesto_grup_descricao.visible:=true;
    EdEsto_grup_descricao.TableName:='estoque';
    EdEsto_grup_descricao.TableField:='esto_grup_descricao';

  end else begin

    EdEsto_grup_descricao.Visible:=False;
    EdEsto_grup_descricao.Enabled:=False;
    EdEsto_grup_descricao.TableName:='';
    EdEsto_grup_descricao.TableField:='';

  end;

/////////////////////////////
  if not Arq.TEstoque.IsEmpty then Arq.TEstoque.GetFields(Self,0);
  DadosQtdetoEdits(EdEsto_Codigo.Text, Global.CodigoUnidade);

  EdEsto_qtdeprev.Enabled:=Global.Usuario.OutrosAcessos[0010];
  EdEsto_qtdeprev.Visible:=Global.Usuario.OutrosAcessos[0010];
  EdEsto_custoger.Visible:=Global.Usuario.OutrosAcessos[0010];
  EdEsto_customeger.Visible:=Global.Usuario.OutrosAcessos[0010];
  EdEsto_custoger.Enabled:=Global.Usuario.OutrosAcessos[0010];
  EdEsto_customeger.Enabled:=Global.Usuario.OutrosAcessos[0010];
  EdEsto_precocompra.Enabled:=Global.Usuario.OutrosAcessos[0010];
  EdEsto_precocompra.Visible:=Global.Usuario.OutrosAcessos[0010];
  if Global.Usuario.OutrosAcessos[0010] then begin
    EdEsto_custo.left:=73;
    EdEsto_custoger.left:=159;
    EdEsto_customedio.left:=245;
    EdEsto_customeger.left:=316;
    EdEsto_precocompra.left:=405;  // 27.06.06
    EdEsto_vendavis.left:=477;
    SetEdmate_descricao.width:=68;
  end else begin
    EdEsto_custo.left:=123;
    EdEsto_customedio.left:=265;
    EdEsto_vendavis.left:=398;
    SetEdmate_descricao.width:=140;
  end;
  bDigitargrade.Enabled:=false;

//  bDadosgrade.Enabled:=false;

  bTerminargrade.Enabled:=false;
{
  if Global.Usuario.OutrosAcessos[0011] then begin
    bcustozerado.visible:=true;
    bcustozerado.Enabled:=true;
  end else begin
    bcustozerado.visible:=false;
    bcustozerado.Enabled:=false;
  end;
}
  ListaQtde:=Tlist.create;
// 01.02.11 - Dist. Bavi
  if Global.Topicos[1212] then
    EdEsto_descricao.CharCase:=ecUpperCase;
// 02.04.12
  EdPesquisa.Enabled:=false;
  EdPesquisa.Visible:=false;
// 03.04.12
  bbuscar.Enabled:=false;
  if (Global.Topicos[1025]) or (Global.Topicos[1044]) then begin
    bPesquisar.Operation:=(fbNone);
    bPesquisar.AutoAction:=false;
    bPesquisar.Tag:=1;
    bPesquisar.Grid:=nil;
    bbuscar.Enabled:=true;
  end else begin
    bPesquisar.Operation:=(fbFind);
    bPesquisar.AutoAction:=true;
    bPesquisar.Tag:=0;
    bPesquisar.Grid:=Grid;
  end;
// 01.08.18
  if (FGeral.GetConfig1AsString('gridestoque')='S') and (FGeral.GetConfig1AsInteger('tamgrid')>0) then
     Grid.Font.Size:=FGeral.GetConfig1AsInteger('tamgrid')
  else
     Grid.Font.Size:=8;
// 14.06.19
  if AnsiPos( FUnidades.GetSimples(global.CodigoUnidade),'S;2' ) > 0 then begin
     EdEsto_sitt_codestado.FindSetField:='sitt_cstme';
     EdEsto_sitt_forestado.FindSetField:='sitt_cstme';
  end else begin
     EdEsto_sitt_codestado.FindSetField:='sitt_cst';
     EdEsto_sitt_forestado.FindSetField:='sitt_cst';
  end;

end;

procedure TFEstoque.EdEsto_icmsforaestadoExitEdit(Sender: TObject);
begin
  btGravar.OnClick(self);
end;

procedure TFEstoque.GridNewRecord(Sender: TObject);
////////////////////////////////////////////////////
var precovenda:currency;
begin
  if not pgrade.Visible then begin
// 23.05.11 - Damama
    campo:=Sistema.GetDicionario('estoque','esto_nutr_codigo');
    campotara:=Sistema.GetDicionario('estoque','esto_tara');
    campotaraperc:=Sistema.GetDicionario('estoque','esto_taraperc');
    campofaixa:=Sistema.GetDicionario('estoque','esto_faix_codigo');
    campofaixa002:=Sistema.GetDicionario('estoque','esto_faix_codigo002');
// 12.02.19
    campogrupodescricao:=Sistema.GetDicionario('estoque','esto_grup_descricao');
    campovalidaderes   :=Sistema.GetDicionario('estoque','esto_validaderes');

    if Campo.Tipo<>'' then begin

      Edesto_nutr_codigo.Enabled:=true;
      Edesto_nutr_codigo.TableName:='estoque';
      Edesto_ingr_codigo.Enabled:=true;
      Edesto_ingr_codigo.TableName:='estoque';
      Edesto_cons_codigo.Enabled:=true;
      Edesto_cons_codigo.TableName:='estoque';
      Edesto_cons_codigo1.Enabled:=true;
      Edesto_cons_codigo1.TableName:='estoque';

    end else begin

      Edesto_nutr_codigo.Enabled:=false;
      Edesto_nutr_codigo.TableName:='';
      Edesto_ingr_codigo.Enabled:=false;
      Edesto_ingr_codigo.TableName:='';
      Edesto_cons_codigo.Enabled:=false;
      Edesto_cons_codigo.TableName:='';
      Edesto_cons_codigo1.Enabled:=false;
      Edesto_cons_codigo1.TableName:='';

    end;
// 03.06.11
    if CampoTara.Tipo<>'' then begin

      Edesto_tara.Enabled:=true;
      Edesto_tara.TableName:='estoque';
      Edesto_qbalanca.Enabled:=true;
      Edesto_qbalanca.TableName:='estoque';
      Edesto_validade.Enabled:=true;
      Edesto_validade.TableName:='estoque';
      Edesto_qetiqbalanca.Enabled:=true;
      Edesto_qetiqbalanca.TableName:='estoque';

    end else begin

      Edesto_tara.Enabled:=false;
      Edesto_tara.TableName:='';
      Edesto_qbalanca.Enabled:=false;
      Edesto_qbalanca.TableName:='';
      Edesto_validade.Enabled:=false;
      Edesto_validade.TableName:='';
      Edesto_qetiqbalanca.Enabled:=false;
      Edesto_qetiqbalanca.TableName:='';
    end;
// 22.09.16
    if CampoTaraperc.Tipo<>'' then begin
      Edesto_taraperc.Enabled:=true;
      Edesto_taraperc.TableName:='estoque';
      Edesto_taracf.Enabled:=true;
      Edesto_taracf.TableName:='estoque';
    end else begin
      Edesto_taraperc.Enabled:=false;
      Edesto_taraperc.TableName:='';
      Edesto_taracf.Enabled:=false;
      Edesto_taracf.TableName:='';
    end;
// 08.03.19 - Novicarnes
    if campovalidaderes.Tipo<>'' then begin

       Edesto_validaderes.Enabled  :=true;
       Edesto_validaderes.Tablename:='estoque';
       Edesto_validaderes.TableField:='esto_validaderes';
       EdEsto_cons_codigores.Enabled :=true;
       Edesto_cons_codigores.Tablename:='estoque';
       Edesto_cons_codigores.TableField:='esto_cons_codigores';

    end else begin

       Edesto_validaderes.Enabled  :=false;
       Edesto_validaderes.Tablename:='';
       Edesto_validaderes.TableField:='';
       EdEsto_cons_codigores.Enabled :=false;
       Edesto_cons_codigores.Tablename:='';
       Edesto_cons_codigores.TableField:='';

    end;

// 26.07.13 - Metalnorte - aqui jamantao s� em 14.08.13
    campo:=Sistema.GetDicionario('estoque','esto_fami_descricao');
    if Campo.Tipo<>'' then begin
      Edesto_fami_descricao.TableName:='estoque';
  //    SetEdfami_descricao.TableField:='esto_fami_descricao';
      Edesto_fami_descricao.enabled:=true;
    end else begin
      Edesto_fami_descricao.TableName:='';
      Edesto_fami_descricao.TableField:='';
      Edesto_fami_descricao.enabled:=false;
    end;
//////////////////////////
// 15.03.16 - Novicarnes
  if Campofaixa.Tipo<>'' then begin
    Edesto_faix_codigo.TableName:='estoque';
    Edesto_faix_codigo.enabled:=true;
  end else begin
    Edesto_faix_codigo.TableName:='';
    Edesto_faix_codigo.TableField:='';
    Edesto_faix_codigo.enabled:=false;
  end;
/////////////////////////////
//////////////////////////
// 23.05.18 - Novicarnes
  if Campofaixa002.Tipo<>'' then begin
    Edesto_faix_codigo002.TableName:='estoque';
    Edesto_faix_codigo002.enabled:=true;
  end else begin
    Edesto_faix_codigo002.TableName:='';
    Edesto_faix_codigo002.TableField:='';
    Edesto_faix_codigo002.enabled:=false;
  end;
/////////////////////////////

//    Aviso('estou no edit codigo '+EdEsto_codigo.Text);
//    Aviso('estou no codigo '+ARq.TEstoque.FieldByName('esto_codigo').asstring);


//////////
    if not Arq.TEstoque.IsEmpty then begin
       Arq.TEstoque.GetFields(Self,0);
    end;

// 19.09.18
//    if not EdEsto_codigo.IsEmpty then EdEsto_Codigo.GetFields(FEstoque,99);

// 24.09.08
    campo:=Sistema.GetDicionario('estoque','esto_compminimo');
    if campo.Tipo<>'' then
      EdCompminimo.setvalue(Arq.TEstoque.fieldbyname('esto_compminimo').Asfloat);
// 20.05.11
    campo:=Sistema.GetDicionario('estoque','esto_nutr_codigo');
    if campo.Tipo<>'' then begin
      EdEsto_Nutr_codigo.setvalue( Arq.TEstoque.fieldbyname('esto_nutr_codigo').AsInteger );
      EdEsto_Ingr_codigo.setvalue( Arq.TEstoque.fieldbyname('esto_ingr_codigo').AsInteger );
      EdEsto_Cons_codigo.setvalue( Arq.TEstoque.fieldbyname('esto_cons_codigo').AsInteger );
      EdEsto_Cons_codigo1.setvalue( Arq.TEstoque.fieldbyname('esto_cons_codigo1').AsInteger );
    end;
// 03.06.11
    campotara:=Sistema.GetDicionario('estoque','esto_tara');
    if CampoTara.Tipo<>'' then begin
      Edesto_tara.setvalue( Arq.TEstoque.fieldbyname('esto_tara').AsCurrency );
      Edesto_qbalanca.text:=Arq.TEstoque.fieldbyname('esto_qbalanca').AsString;
      Edesto_validade.setvalue( Arq.TEstoque.fieldbyname('esto_validade').AsInteger );
      Edesto_qetiqbalanca.setvalue( Arq.TEstoque.fieldbyname('esto_qetiqbalanca').AsInteger );
    end;
// 22.09.16
    campotaraperc:=Sistema.GetDicionario('estoque','esto_taraperc');
    if CampoTaraperc.Tipo<>'' then begin
      Edesto_taraperc.setvalue( Arq.TEstoque.fieldbyname('esto_taraperc').AsCurrency );
      Edesto_taracf.setvalue( Arq.TEstoque.fieldbyname('esto_taracf').AsCurrency );
    end;
// 27.07.13
    campo:=Sistema.GetDicionario('estoque','esto_fami_descricao');
    if Campo.Tipo<>'' then Edesto_fami_descricao.text:= Arq.TEstoque.fieldbyname('esto_fami_descricao').Asstring;
// 15.06.16
    campo:=Sistema.GetDicionario('estoque','esto_faix_codigo');
    if Campo.Tipo<>'' then Edesto_faix_codigo.text:= Arq.TEstoque.fieldbyname('esto_faix_codigo').Asstring;
// 12.02.19
    if Campogrupodescricao.Tipo<>'' then begin
       if Arq.TEstoque.fieldbyname('esto_grup_descricao').Asstring='' then
         Edesto_grup_descricao.text:= FGrupos.GetDescricao( Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger )
       else
         Edesto_grup_descricao.text:= Arq.TEstoque.fieldbyname('esto_grup_descricao').Asstring;
    end;

////////////
    if not Arq.TSittributaria.active then Arq.TSittributaria.open;
//    bDigitargrade.Enabled:=EdEsto_grad_codigo.ValidFind;
//    bTerminargrade.Enabled:=EdEsto_grad_codigo.ValidFind;
  end;


// DadosQtdetoEdits(EdEsto_Codigo.Text, Global.CodigoUnidade);
// 19.09.18
   DadosQtdetoEdits(Arq.TEstoque.FieldByName('esto_codigo').AsString, Global.CodigoUnidade);


///
// 24.02.16
//  DadosQtdetoEdits(Arq.TEstoque.FieldByName('esto_codigo').AsString, Global.CodigoUnidade);
//  if pfigura.Visible then pfigura.Visible:=false;
// 21.03.11 - bavi
  if pfigura.Visible then bimagemClick(Self);
{
  if not pgrade.Visible then begin
    PemEstoque.Caption:=Edesto_qtde.text ;
    PemEstoque.Update;
  end;
  if not pgrade.Visible then begin
    Pprecovenda.Caption:=EdEsto_vendavis.text ;
    Pprecovenda.Update;
  end;
}
 end;

procedure TFEstoque.bCancelarClick(Sender: TObject);
begin
  EdEsto_Codigo.ClearAll(Self,99);
//  Grid.Cancel;
  PGrade.Visible:=false;
  PGrade.Enabled:=false;
  PEdits.DisableEdits;
// 23.02.11 - Bavi
  if Global.Usuario.OutrosAcessos[0053] then
      PEdits.Visible:=true
  else
      PEdits.Visible:=false;
  bSair.enabled:=true;
// 29.01.15
  if Global.Usuario.ObjetosAcessados[0141] then
    bincluir.Enabled:=true;

  Grid.Enabled:=true;
  if not Arq.TEstoque.IsEmpty then Arq.TEstoque.GetFields(Self,0);
  Atuvenda:=false;
  bPesquisar.Enabled:=true;
  Grid.SetFocus;

end;

function TFEstoque.GetDescricao(codigo: string ;retornamsg:string='S'): string;
////////////////////////////////////////////////////////////////////////////////var Q:TSqlquery;
begin

  if retornamsg='S' then
    Result:=Codigo+' N�o encontrado no estoque geral'
  else
    Result:='';

  if Trim(Codigo)<>'' then begin
{
    if not Arq.TEstoque.Active then Arq.TEstoque.Open;
    if Arq.TEstoque.Locate('esto_codigo',Codigo,[]) then Result:=Arq.TEstoque.FieldByName('Esto_Descricao').AsString;
}
   Q:=sqltoquery('select esto_descricao from estoque where esto_codigo='+stringtosql(codigo));
   if not Q.eof then
     result:=Q.FieldByName('Esto_Descricao').AsString;
   FGeral.FechaQuery(Q);
  end;

end;

procedure TFEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
///////////////////////  FGeral.LiberaCadastro(Grid);
// 05.05.16 - retirado devido ao 'efeito devereda' no 'muco-vuco'
  if pfigura.Visible then pfigura.Visible:=false;
end;

procedure TFEstoque.bExcluirClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////////////
var Codigo:String;
    Achou:Boolean;

    function AchaTabela(Tabela,Campo,Msg,Campostatus:String):Boolean;
    var Q:TSqlQuery;
    begin
      Sistema.beginprocess('Checando depend�ncias');
      Q:=SqlToQuery('SELECT Count(*) AS Achados FROM '+Tabela+' WHERE '+Campo+'='+Codigo+' and '+CampoStatus+'=''N''');
      Result:=Q.FieldByName('Achados').AsInteger>0;
      if Result then AvisoErro('Encontrados lan�amentos com o produto escolhido no arquivo '+Msg);
      Q.Close;Q.Free;
      Sistema.endprocess('');
    end;

begin
////////////////////////
  Codigo:=StringToSql(Arq.TEstoque.FieldByName('Esto_Codigo').AsString);
// colocar as devidas tabelas para checagem
//  Achou:=AchaTabela('????????','????_Esto_Codigo','Movimento De Estoque');
  Achou:=false;
  Unidade:=Global.CodigoUnidade;
//  if not Achou then Achou:=AchaTabela('Estgrades','Esgr_Esto_Codigo','Quantidades das grades');
// 01.07.05
  if not Achou then Achou:=AchaTabela('Movestoque','Move_Esto_Codigo','Movimenta��o produtos','Move_Status');
  if not Achou then begin
    if not Confirma('Confirma exclus�o do codigo '+codigo+' ?') then exit;
      Executesql('Update Estgrades set esgr_status=''C'' where esgr_status=''N'''+
  //               ' and esgr_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                 ' and esgr_esto_codigo='+codigo+
                 ' and esgr_grad_codigo='+EdEsto_grad_codigo.AsSql);
      Executesql('Update EstoqueQtde set esqt_status=''C'',esqt_usua_codigo='+Inttostr(Global.Usuario.Codigo)+
                 ' where esqt_esto_codigo='+EdEsto_codigo.AsSql);
      Executesql('Update SalEstoque set saes_status=''C'',saes_usua_codigo='+Inttostr(Global.Usuario.Codigo)+
                 ' where saes_esto_codigo='+EdEsto_codigo.AsSql);
  // 17.02.11 - 'sumi�o de itens'
      FGeral.Gravalog(23,'Variavel Codigo='+Arq.TEstoque.FieldByName('Esto_Codigo').AsString,true,'Unidade='+Unidade,Global.Usuario.Codigo,'Edit esto_codigo='+EdEsto_codigo.Text );

      Grid.Delete;
      Sistema.Commit;
  end;
end;

procedure TFEstoque.bsimilaresClick(Sender: TObject);
begin
//  Grid.Report('CadEstoque','Rela��o de Produtos','','');
//  Frel.Reportfromsql('select * from estoques','CadEstoque','Rela��o de Produtos');
{
   if EdEsto_codigo.isempty then exit;
   PCustoZerado.enabled:=true;
   PCustoZerado.Visible:=true;
   EdCustofiscal.enabled:=true;
   EdCustofiscal.Visible:=true;
   EdCustogerencial.enabled:=true;
   EdCustogerencial.Visible:=true;
   Pbotoes.Enabled:=false;
   EdCustofiscal.setfocus;
}
  if OP='I' then exit;
  FSimilares.Execute('C');

end;

procedure TFEstoque.Execute;
////////////////////////////
var Lista:TStringlist;
    p:integer;
    QE:TSqlquery;
begin

///////////////////////////////////////////////////
// 09.09.16
  if Global.Topicos[1025] then begin
    if not Arq.TEstoque.active then begin
      ListaporUnidade:=TStringList.Create;
      Qe:=sqltoquery('select esqt_esto_codigo from estoqueqtde where esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                     ' and esqt_status = ''N'' order by esqt_esto_codigo');
      codigosuni:='';
      while not Qe.eof do begin
        ListaporUnidade.Add(qe.fieldbyname('esqt_esto_codigo').asstring);
        codigosuni:=codigosuni+qe.fieldbyname('esqt_esto_codigo').asstring+';';
        Qe.Next;
      end;
      FGeral.FechaQuery(Qe);
    end;
    Arq.TEstoque.OpenWith(FGeral.GetIN('esto_codigo',codigosuni,'C'),Arq.TEstoque.Ordenacao);
  end else
    if not Arq.TEstoque.active then Arq.TEstoque.open;
////////////////////////////////////////////////////

//  PEdits.Visible:=false;
  PEdits.DisableEdits;
  Atuvenda:=false;
  FGeral.SetaItemsSisVenda(EdEsto_sisvendas);
  FGeral.SetaItemsCategoria(EdEsto_categoria);
  bimagem.Visible:=Global.Topicos[1214];
  bimagem.Enabled:=Global.Topicos[1214];
// 11.03.15
///////////////////////
  EdEsto_sitt_codestadonc.Enabled:=false;
  EdEsto_sitt_forestadonc.Enabled:=false;
  Edcfis_codestnc.Enabled:=false;
  Edcfis_codigoforaestnc.Enabled:=false;
  if Global.Topicos[1226] then begin
    EdEsto_sitt_codestadonc.Enabled:=true;
    EdEsto_sitt_forestadonc.Enabled:=true;
    Edcfis_codestnc.Enabled:=true;
    Edcfis_codigoforaestnc.Enabled:=true;
  end;
///////////////////////

// 25.10.10
  FGeral.ConfiguraTamanhoEditsEnabled(FEstoque,FGeral.GetConfig1AsInteger('tamanholetra'));
// 05.04.12
  FGeral.ConfiguraColorEditsNaoEnabled(FEstoque);
// 23.02.11 - Bavi
  if Global.Usuario.OutrosAcessos[0053] then
     PEdits.Visible:=true
  else
     PEdits.Visible:=false;
///////////////////
// 08.08.19 -> 27.09.2021
  bequipamento.Enabled:=Global.Topicos[1367];
  bequipamento.Visible:=Global.Topicos[1367];

  ShowModal;
  EdEsto_codigo.enabled:= not Global.Topicos[1203];
// 25.03.11
  campo:=Sistema.GetDicionario('estoqueqtde','esqt_cfis_codestsemie');
  if Campo.Tipo<>'' then begin
    Edesqt_cfis_codestsemie.Enabled:=true;
    Edesqt_cfis_codestsemie.TableName:='estoqueqtde';
  end else begin
    Edesqt_cfis_codestsemie.Enabled:=false;
    Edesqt_cfis_codestsemie.TableName:='';
  end;
// 20.05.11 - Damama
  campo:=Sistema.GetDicionario('estoque','esto_nutr_codigo');
  campotara:=Sistema.GetDicionario('estoque','esto_tara');
  campotaraperc:=Sistema.GetDicionario('estoque','esto_taraperc');
  campofaixa:=Sistema.GetDicionario('estoque','esto_faix_codigo');
  campofaixa002:=Sistema.GetDicionario('estoque','esto_faix_codigo002');
// 08.03.19
  campovalidaderes:=Sistema.GetDicionario('estoque','validaderes');
  if Campo.Tipo<>'' then begin

    Edesto_nutr_codigo.Enabled:=true;
    Edesto_nutr_codigo.TableName:='estoque';
    Edesto_ingr_codigo.Enabled:=true;
    Edesto_ingr_codigo.TableName:='estoque';
    Edesto_cons_codigo.Enabled:=true;
    Edesto_cons_codigo.TableName:='estoque';
    Edesto_cons_codigo1.Enabled:=true;
    Edesto_cons_codigo1.TableName:='estoque';

  end else begin

    Edesto_nutr_codigo.Enabled:=false;
    Edesto_nutr_codigo.TableName:='';
    Edesto_ingr_codigo.Enabled:=false;
    Edesto_ingr_codigo.TableName:='';
    Edesto_cons_codigo.Enabled:=false;
    Edesto_cons_codigo.TableName:='';
    Edesto_cons_codigo1.Enabled:=false;
    Edesto_cons_codigo1.TableName:='';

  end;
// 03.06.11
  if CampoTara.Tipo<>'' then begin

    Edesto_tara.Enabled:=true;
    Edesto_tara.TableName:='estoque';
    Edesto_qbalanca.Enabled:=true;
    Edesto_qbalanca.TableName:='estoque';
    Edesto_validade.Enabled:=true;
    Edesto_validade.TableName:='estoque';
    Edesto_qetiqbalanca.Enabled:=true;
    Edesto_qetiqbalanca.TableName:='estoque';

  end else begin

    Edesto_tara.Enabled:=false;
    Edesto_tara.TableName:='';
    Edesto_qbalanca.Enabled:=false;
    Edesto_qbalanca.TableName:='';
    Edesto_validade.Enabled:=false;
    Edesto_validade.TableName:='';
    Edesto_qetiqbalanca.Enabled:=false;
    Edesto_qetiqbalanca.TableName:='';
  end;
// 22.09.16
  if CampoTaraperc.Tipo<>'' then begin

    Edesto_taraperc.Enabled:=true;
    Edesto_taraperc.TableName:='estoque';
    Edesto_taracf.Enabled:=true;
    Edesto_taracf.TableName:='estoque';

  end else begin

    Edesto_taraperc.Enabled:=false;
    Edesto_taraperc.TableName:='';
    Edesto_taracf.Enabled:=false;
    Edesto_taracf.TableName:='';

  end;

// 27.07.13
    campo:=Sistema.GetDicionario('estoque','esto_fami_descricao');
    if Campo.Tipo<>'' then Edesto_fami_descricao.text:= Arq.TEstoque.fieldbyname('esto_fami_descricao').Asstring;
// 12.02.19
    campogrupodescricao:=Sistema.GetDicionario('estoque','esto_grup_descricao');
    if Campogrupodescricao.Tipo<>'' then begin
       if Arq.TEstoque.fieldbyname('esto_grup_descricao').Asstring='' then
         Edesto_grup_descricao.text:= FGrupos.GetDescricao( Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger )
       else
         Edesto_grup_descricao.text:= Arq.TEstoque.fieldbyname('esto_grup_descricao').Asstring;
    end;
// 08.03.19 - Novicarnes
    if campovalidaderes.Tipo<>'' then begin

       Edesto_validaderes.Enabled  :=true;
       Edesto_validaderes.Tablename:='estoque';
       Edesto_validaderes.Tablefield:='esto_validaderes';
       EdEsto_cons_codigores.Enabled :=true;
       Edesto_cons_codigores.Tablename:='estoque';
       Edesto_cons_codigores.TableField:='esto_cons_codigores';

    end else begin

       Edesto_validaderes.Enabled  :=false;
       Edesto_validaderes.Tablename:='';
       Edesto_validaderes.Tablefield:='';
       EdEsto_cons_codigores.Enabled :=false;
       Edesto_cons_codigores.Tablename:='';
       Edesto_cons_codigores.TableField:='';

    end;

// 15.03.16
    campo:=Sistema.GetDicionario('estoque','esto_faix_codigo');
    if Campo.Tipo<>'' then Edesto_faix_codigo.text:= Arq.TEstoque.fieldbyname('esto_faix_codigo').Asstring;

// 02.04.12
  if Global.Topicos[1025] then begin
    bPesquisar.Operation:=(fbNone);
    bPesquisar.AutoAction:=false;
    bPesquisar.Tag:=1;
//    bPesquisar.Grid:=nil;
  end else begin
    bPesquisar.Operation:=(fbFind);
    bPesquisar.AutoAction:=true;
    bPesquisar.Tag:=0;
//    bPesquisar.Grid:=Grid;
  end;
// 26.03.16
  ListaCest:=Tlist.create;
  if FileExists('tabelacestncm.csv') then begin
    ListaAuxCest:=TStringList.create;
    ListaAuxCest.LoadFromFile('tabelacestncm.csv');
    for p:=0 to LIstaAuxCest.count-1 do begin
      Lista:=TStringlist.create;
      strtolista(Lista,ListaAuxCest[p],';',true);
      New(PListaCest);
      PListaCest.cest:=Lista[0];
      pListaCest.ncm:=Lista[1];
      ListaCest.Add(PListaCest);
      Lista.free;
    end;
    ListaAuxCest.Free;
  end;
// 14.06.19
  if AnsiPos( FUnidades.GetSimples(global.CodigoUnidade),'S;2' ) > 0 then begin
     EdEsto_sitt_codestado.FindSetField:='sitt_cstme';
     EdEsto_sitt_forestado.FindSetField:='sitt_cstme';
  end else begin
     EdEsto_sitt_codestado.FindSetField:='sitt_cst';
     EdEsto_sitt_forestado.FindSetField:='sitt_cst';
  end;

end;

procedure TFEstoque.BtgravarClick(Sender: TObject);
/////////////////////////////////////////////////
var p:integer;
    qtde:currency;
    Q,QQtde,QUnid:TSqlquery;
    xunidades,xunid:string;
    Lista:TStringList;

    procedure GravaEstoqueQtde(xunidade,ie:string);
    ////////////////////////////////////////////////
    begin

      Sistema.Setfield('esqt_status','N');
      Sistema.Setfield('esqt_unid_codigo',xunidade);
      Sistema.Setfield('esqt_esto_codigo',EdEsto_codigo.Text);
      Sistema.Setfield('esqt_qtde',EdEsto_qtde.AsFloat);
      Sistema.Setfield('esqt_qtdeprev',FGeral.QualQtde(Global.Usuario.codigo,EdEsto_qtde.AsFloat,EdEsto_qtdeprev.AsFloat));
      Sistema.Setfield('esqt_vendavis',EdEsto_vendavis.AsCurrency);

// 09.05.18
      if Global.Topicos[1235] then begin

        Sistema.Setfield('esqt_custo',EdEsto_vendavis.AsCurrency*0.4);
        Sistema.Setfield('esqt_custoger',EdEsto_vendavis.AsCurrency*0.4);
        Sistema.Setfield('esqt_customedio',EdEsto_vendavis.AsCurrency*0.4);
        Sistema.Setfield('esqt_customeger',EdEsto_vendavis.AsCurrency*0.4);

      end else begin

        Sistema.Setfield('esqt_custo',EdEsto_custo.AsCurrency);
        Sistema.Setfield('esqt_custoger',EdEsto_custoger.AsCurrency);
        Sistema.Setfield('esqt_customedio',EdEsto_customedio.AsCurrency);
        Sistema.Setfield('esqt_customeger',EdEsto_customeger.AsCurrency);

      end;

      Sistema.Setfield('esqt_dtultvenda',EdEsto_dtultvenda.AsDate);
      Sistema.Setfield('esqt_dtultcompra',EdEsto_dtultcompra.AsDate);
      Sistema.Setfield('esqt_desconto',EdEsto_desconto.AsCurrency);
      Sistema.Setfield('esqt_basecomissao',EdEsto_basecomissao.AsCurrency);
// 05.12.2022 - guiber ajudou a achar esta 'n�o conformidade'
// 27.01.2023 - guiber(vivi) ajudou novamente a achar esta 'outra n�o  conformidade'
     if ie = 'I' then begin

        QUNid := sqltoquery('select * from unidades where unid_codigo='+Stringtosql(xunidade));
        Sistema.Setfield('esqt_cfis_codigoest',QUNid.FieldByName('unid_cfis_codigoest').Ascurrency);
        Sistema.Setfield('esqt_cfis_codigoforaest',QUNid.FieldByName('unid_cfis_codigoforaest').AsCurrency);
        Sistema.Setfield('esqt_sitt_codestado',QUnid.FieldByName('unid_sitt_codestado').AsInteger);
        Sistema.Setfield('esqt_sitt_forestado',QUnid.FieldByName('unid_sitt_forestado').AsInteger);
        FGeral.FechaQuery(QUNid);

      end else begin

        Sistema.Setfield('esqt_cfis_codigoest',EdEsto_cfis_codigoest.Ascurrency);
        Sistema.Setfield('esqt_cfis_codigoforaest',EdEsto_cfis_codigoforaest.AsCurrency);
        Sistema.Setfield('esqt_sitt_codestado',EdEsto_sitt_codestado.AsInteger);
        Sistema.Setfield('esqt_sitt_forestado',EdEsto_sitt_forestado.AsInteger);

      end;
      Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
// 22.05.07
      Sistema.Setfield('esqt_vendamin',EdEsto_vendamin.AsCurrency);
// 03.11.07
      Sistema.Setfield('esqt_pecas',EdEsto_pecas.AsFloat);
// 24.03.08
      Sistema.Setfield('esqt_custoser',EdMobra.AsFloat);
      Sistema.Setfield('esqt_customedioser',EdMomedio.AsFloat);
// 28.03.11
       campo:=Sistema.GetDicionario('estoqueqtde','esqt_cfis_codestsemie');
//     if (campo .Tipo<>'' ) and ( trim(Edesqt_cfis_codestsemie.text)<>'' ) then
// 09.11.20 - Vida Nova - retirado para poder deixar em branco este campo ref. 'isento'
      if (campo .Tipo<>'' ) then

        Sistema.Setfield('esqt_cfis_codestsemie',Edesqt_cfis_codestsemie.text);

       //      Sistema.Setfield('esqt_codbarra',EdEsto_codbarra.text);
//      if EdEsto_grad_codigo.AsInteger=0 then begin
//      Sistema.Setfield('esqt_tama_codigo',0);
//      Sistema.Setfield('esqt_core_codigo',0);
//      end else begin
//        Sistema.Setfield('esqt_tama_codigo',0);  // ver grade
//        Sistema.Setfield('esqt_core_codigo',0);
//      end;
// 11.03.15
      if Global.topicos[1226] then begin
        Sistema.Setfield('Esqt_cfis_codestnc',Edcfis_codestnc.Ascurrency);
        Sistema.Setfield('Esqt_cfis_codforaestnc',Edcfis_codigoforaestnc.AsCurrency);
        Sistema.Setfield('Esqt_sitt_codestadonc',EdEsto_sitt_codestadonc.AsInteger);
        Sistema.Setfield('Esqt_sitt_forestadonc',EdEsto_sitt_forestadonc.AsInteger);
      end;

    end;


// 26.03.12 - usado quando o estoque � filtrado por unidade
    procedure GravaEstoque(xop:string);
    ///////////////////////
    begin
      if xOP='I' then begin
        Sistema.Insert('estoque');
        Sistema.setfield('esto_codigo',EdEsto_codigo.text);
      end else begin
        Sistema.Edit('estoque');
      end;
      Sistema.setfield('esto_descricao',EdEsto_descricao.text);
      Sistema.setfield('esto_unidade',EdEsto_unidade.text);
      Sistema.setfield('esto_embalagem',EdEsto_embalagem.Asinteger);
      Sistema.setfield('esto_peso',EdEsto_peso.ascurrency);
      Sistema.setfield('esto_codbarra',EdEsto_codbarra.text);
      Sistema.setfield('esto_grup_codigo',EdEsto_grup_codigo.asinteger);
      Sistema.setfield('esto_sugr_codigo',EdEsto_sugr_codigo.asinteger);
      Sistema.setfield('esto_fami_codigo',EdEsto_fami_codigo.asinteger);
      Sistema.setfield('esto_emlinha',EdEsto_emlinha.text);
      Sistema.setfield('esto_mate_codigo',EdEsto_mate_codigo.asinteger);
      Sistema.setfield('esto_usua_codigo',Global.Usuario.Codigo);
//      Sistema.setfield('esto_sisvendas character varying(10),
//      Sistema.setfield('esto_categoria character varying(4),
      Sistema.setfield('esto_referencia',EdEsto_referencia.text);
      Sistema.setfield('esto_precocompra',EdEsto_precocompra.ascurrency);
      Sistema.setfield('esto_cipi_codigo',EdEsto_cipi_codigo.asinteger);
/////////////
      if xOP='I' then
         Sistema.Post
      else
         Sistema.Post('esto_codigo='+EdEsto_codigo.AsSql);
    end;

////////////////////////////////////
begin
////////////////////////////////////

   Sistema.SetMessage('Validando as informa��es');
   EdEsto_usua_codigo.SetValue(Global.Usuario.Codigo);
   for p := 0 to Componentcount-1 do begin
      if (Components[p] is TSqled) and ( trim(TSqled(Components[p]).TableField) <> '') and
         (TSqled(Components[p]).TableField <> 'Esto_codigo') and (TSqled(Components[p]).TableField <> 'Esto_grad_codigo')
         then begin
         if not TSqled(Components[p]).Valid then begin
           TSqled(Components[p]).SetFocus;
           exit;
         end;
      end;
   end;
   if not Global.Usuario.OutrosAcessos[0010] then
     EdEsto_qtdeprev.SetValue(EdEsto_qtde.AsFloat);

   if op='I' then begin
////////////     if EdEsto_grad_codigo.AsInteger=0 then begin
       if Global.Topicos[1203] then begin

         EdEsto_codigo.Text:=GetProximoCodigo('estoque','esto_codigo','C');
         if Global.Topicos[1241] then
      // 24.08.2022 - Devereda 'loqueou' tabela estoque
//             EdEsto_codigo.text:=IntToStr( FGeral.GetContador('CODIGOESTOQUE',false,False)+1);
             EdEsto_codigo.text:=StrZero( FGeral.GetContador('CODIGOESTOQUE',false,FALSE)+1,FGeral.GetConfig1AsInteger('TAMESTOQUE'));

       end;
// 09.06.11 - devido aos 'sumi�os' de produtos
       QQtde:=Sqltoquery('select esqt_esto_codigo from EstoqueQtde where esqt_esto_codigo='+EdEsto_codigo.assql+
                         ' and esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                         ' and esqt_status=''N''');
       if QQtde.eof then begin

         Sistema.Insert('EstoqueQtde');
         GravaEstoqueQtde(Global.codigounidade,'I');
         Sistema.Post('');
         Sistema.Commit;
         xunidades:=FGeral.getconfig1asstring('unidadesestoque');
         if trim(xunidades)<>'' then begin
           Lista:=TStringList.create;
           strtolista(Lista,xunidades,';',true);
           for p:= 0 to Lista.count-1 do begin
             xunid:=Lista[p];
             if (trim(xunid)<>'') AND (trim(xunid)<>';') then begin
                QQtde.close;
                QQtde:=Sqltoquery('select esqt_esto_codigo from EstoqueQtde where esqt_esto_codigo='+EdEsto_codigo.assql+
                         ' and esqt_unid_codigo='+Stringtosql(xUnid)+
                         ' and esqt_status=''N''');
                if QQtde.eof then begin
                    Sistema.Insert('EstoqueQtde');
                    GravaEstoqueQtde(xunid,'I');
                    Sistema.Post('');
                    Sistema.Commit;
                end;
             end;
           end;
           Lista.free;
         end;
       end;
       FGeral.FechaQuery(QQtde);
///////////////     end;
     if Global.Topicos[1203] then begin
// 25.08.2022 - Devereda 'loqueou' tabela estoque
       if Global.Topicos[1241] then begin
          FGeral.AlteraContador('CODIGOESTOQUE',StrtoInt(EdEsto_codigo.Text));
       end;
       Grid.PostInsert(EdEsto_descricao);
       if Global.Topicos[1241] then begin
//          EdEsto_codigo.text:=IntToStr( FGeral.GetContador('CODIGOESTOQUE',false,FALSE)+1);
          EdEsto_codigo.text:=StrZero( FGeral.GetContador('CODIGOESTOQUE',false,FALSE)+1,FGeral.GetConfig1AsInteger('TAMESTOQUE'));
      end;

     end else
       Grid.PostInsert(EdEsto_codigo);
// 09.09.16 - filtrado pela uniade
     if Global.topicos[1025] then begin
       codigosuni:=codigosuni+EdEsto_codigo.text+';';
       Arq.TEstoque.Refresh;
     end;

// 25.05.10
    EdEsto_sitt_codestado.setvalue(GetSittDentro(Global.CodigoUnidade));
    EdEsto_sitt_forestado.setvalue(GetSittFora(Global.CodigoUnidade));
    EdEsto_cfis_codigoest.text:=GetFiscalDentro(Global.CodigoUnidade);
    EdEsto_cfis_codigoforaest.text:=GetFiscalFora(Global.CodigoUnidade);
// 08.12.11
    EdEsto_embalagem.Text:='1';

   end else begin

     if EdEsto_grad_codigo.AsInteger>0 then begin
       QtdetoGrid(GridGrade,EdEsto_codigo.Text,EdEsto_grad_codigo.asinteger);
       qtde:=Somaqtdes(GridGrade);
       if qtde <> EdEsto_qtde.AsFloat then begin
         Avisoerro('Quantidade da grade : '+formatfloat(f_cr,qtde)+' Quantidade total informada : '+formatfloat(f_cr,EdEsto_qtde.AsFloat));
//         exit;
       end;
     end else begin
       Q:=sqltoquery('select * from estoqueqtde where esqt_status=''N'' and esqt_unid_codigo='''+Global.CodigoUnidade+''''+
                     ' and esqt_esto_codigo='+EdEsto_codigo.AsSql);
       if not Q.Eof then begin
         Sistema.Edit('EstoqueQtde');
         GravaEstoqueQtde(Global.codigounidade,'E');
         Sistema.Post('esqt_status=''N'' and esqt_unid_codigo='''+Global.CodigoUnidade+''''+
                      ' and esqt_esto_codigo='+EdEsto_codigo.AsSql);
// 15.02.06
         if (EdEsto_customeger.AsCurrency<>customeger)  and (Global.CodigoUnidade=Global.unidadematriz) then
           FGeral.GravaLog(6,'Produto '+EdEsto_codigo.text+' anterior '+floattostr(customeger)+' atual '+floattostr(EdEsto_customeger.AsCurrency),false);
// 11.09.06
         if (EdEsto_vendavis.AsCurrency<>vendavis)  and (Global.CodigoUnidade=Global.unidadematriz) then
           FGeral.GravaLog(13,'Produto '+EdEsto_codigo.text+' anterior '+floattostr(vendavis)+' atual '+floattostr(EdEsto_vendavis.AsCurrency),false);
// 19.04.16
         if (EdEsto_descricao.Text<>EdEsto_descricao.OldValue)  then
           FGeral.GravaLog(32,'Produto '+EdEsto_codigo.text+' anterior '+EdEsto_descricao.oldvalue+' atual '+EdEsto_descricao.Text,false);
// 13.02.22
         if (EdEsto_cipi_codigo.Text<>EdEsto_cipi_codigo.OldValue)  then
           FGeral.GravaLog(42,'Produto '+EdEsto_codigo.text+' cod.ref.ncm anterior '+EdEsto_cipi_codigo.oldvalue+' atual '+EdEsto_cipi_codigo.Text,false);
         if (EdEsto_cfis_codigoest.Text<>codfiscalest)   then
           FGeral.GravaLog(42,'Produto '+EdEsto_codigo.text+' cod. fis.est.anterior '+(codfiscalest)+' cod.fis.atual '+(EdEsto_cfis_codigoest.Text),false);
         if (EdEsto_cfis_codigoforaest.Text<>codfiscalfest)   then
           FGeral.GravaLog(42,'Produto '+EdEsto_codigo.text+' cod. fis.fora est.anterior '+(codfiscalfest)+' cod.fis.atual '+(EdEsto_cfis_codigoforaest.Text),false);
         if (EdEsto_sitt_codestado.Text<>EdEsto_sitt_codestado.oldvalue)   then
           FGeral.GravaLog(42,'Produto '+EdEsto_codigo.text+' cod. sit.est.anterior '+(EdEsto_sitt_codestado.Oldvalue)+' cod.sit.atual '+(EdEsto_sitt_codestado.Text),false);
         if (EdEsto_sitt_forestado.Text<>EdEsto_sitt_forestado.oldvalue)   then
           FGeral.GravaLog(42,'Produto '+EdEsto_codigo.text+' cod. sit.fora est.anterior '+(EdEsto_sitt_forestado.Oldvalue)+' cod.sit.fora est. atual '+(EdEsto_sitt_forestado.Text),false);

       end else begin
         Sistema.Insert('EstoqueQtde');
         GravaEstoqueQtde(Global.codigounidade,'I');
         Sistema.Post('');
       end;
// 26.03.12
       if Global.Topicos[1025] then
         GravaEstoque(OP);
       Sistema.Commit;
     end;
// 26.03.12
     if not Global.Topicos[1025] then begin
       Arq.TEstoque.Edit;
       Arq.TEstoque.SetFields(FEstoque,99);
       Arq.TEstoque.Post;
       Arq.TEstoque.Commit;
     end else
       Arq.TEstoque.Refresh;
     grid.Enabled:=true;
     Grid.Setfocus;
//     PEdits.DisableEdits;
   end;
   if EdEsto_grad_codigo.AsInteger>0 then
     Gravagrade(Op);
/////////////////   Gravaqtde(Op);
  bSair.enabled:=true;
// 29.01.15
  if Global.Usuario.ObjetosAcessados[0141] then
    bincluir.Enabled:=true;
  
// 27.09.10 - Kelen - Doce Pimenta
///////////  op:='W';  // senao nao grava a grade apos incluir produto novo..
// 08.08.11
// retirado pois se incluia mais de um produto 'de uma vez' entrava nesta procedure
// com op='W' e 'fodia o estoque' gravando 'um codigo em cima do outro'..
end;

procedure TFEstoque.Ativaedit;
begin

//   gridgrade.Enabled:=false;
   EdGrade.enabled:=true;
   EdGrade.Left:=GridGrade.LeftEdit;
   EdGrade.Top:=GridGrade.TopEdit;
   EdGrade.Visible:=true;
   EdGrade.Text:=GridGRade.Cells[GridGrade.Col,GridGrade.Row];
//   FGrades.EdGrad_codigolinha.SetValue(Arq.TGrades.fieldbyname('grad_codigolinha').AsInteger);
   EdGrade.SetFocus;

end;

procedure TFEstoque.EdGradeValidate(Sender: TObject);
begin
  if EdGrade.AsFloat >= 0 then
    GridGRade.Cells[GridGrade.Col,GridGrade.Row]:=EdGrade.Text;
  EdGrade.Enabled:=false;
  EdGrade.Visible:=false;
  PEdits.Visible:=true;
  Gridgrade.SetFocus;
  if Global.Usuario.OutrosAcessos[0010] then begin
    EdQtdeprev.enabled:=true;
    EdQtdeprev.Left:=GridGrade.LeftEdit;
    EdQtdeprev.Top:=GridGrade.TopEdit;
    EdQtdeprev.Visible:=true;
    EdQtdeprev.text:=floattostr( TrazQtde(GridGrade.Row,GridGrade.Col) );
    EdQtdeprev.SetFocus;
  end;

end;

procedure TFEstoque.GridGradeDblClick(Sender: TObject);
begin
  if ( trim(GridGRade.Cells[GridGrade.Col,0])='' ) or ( trim(GridGRade.Cells[0,GridGrade.Row])='' ) then begin
    Avisoerro('N�o permitido a digita��o');
    exit;
  end;
  Ativaedit;
end;

procedure TFEstoque.GridGradeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    GridGrade.OnDblClick(self)
  else begin
    avisoerro('Usar somente n�meros');
    Gridgrade.SetFocus;
  end;
end;

procedure TFEstoque.bterminagradeClik(Sender: TObject);
var qtde:extended;
    p:integer;
begin
  if not PEdits.Visible then exit;
  if not PGrade.Visible then exit;
  qtde:=Somaqtdes(GridGrade);
  if qtde <> EdEsto_qtde.AsFloat then begin
    Avisoerro('Quantidade da grade : '+formatfloat(f_cr,qtde)+' Quantidade total informada : '+formatfloat(f_cr,EdEsto_qtde.AsFloat));
    GridGrade.SetFocus;
  end else begin
//    GridGrade.Enabled:=false;
//    GridGrade.Visible:=false;
    if not Global.Usuario.OutrosAcessos[0010] then begin
      PGrade.Enabled:=false;
      PGrade.Visible:=false;
      Gravagrade(Op);
      Grid.Enabled:=true;
      PEdits.Enabled:=true;
      PEdits.Visible:=true;
      PEdits.SetFocus;
      EdEsto_sitt_codestado.SetFocus;
    end;
  end;

  if Global.Usuario.OutrosAcessos[0010] then begin
    qtde:=0;
    for p:=0 to ListaQtde.count-1 do begin
      PListaqtde:=Listaqtde[p];
      qtde:=qtde+Plistaqtde.qtde;
    end;
    if qtde <> EdEsto_qtdeprev.AsFloat then begin
      Avisoerro('Quantidade da grade : '+formatfloat(f_cr,qtde)+' Quantidade total informada : '+formatfloat(f_cr,EdEsto_qtdeprev.AsFloat));
      GridGrade.SetFocus;
    end else begin
      PGrade.Enabled:=false;
      PGrade.Visible:=false;
      Gravagrade(Op);
      Grid.Enabled:=true;
      PEdits.Enabled:=true;
      PEdits.Visible:=true;
      PEdits.SetFocus;
      EdEsto_sitt_codestado.SetFocus;
    end;
  end;

end;

function TFEstoque.Somaqtdes(GridGrade: TSqlDtGrid): extended;
var linha,coluna:integer;
begin
  result:=0;
  for coluna:=1 to GridGrade.ColCount do begin
     for linha:=1 to GridGrade.RowCount do begin
       result:=result+texttovalor(GridGrade.cells[coluna,linha]);
     end;
  end;

end;

procedure TFEstoque.textoobsExit(Sender: TObject);
begin
  Grid.SetFocus;

end;

// 24.08.17
procedure TFEstoque.bdetalhesClick(Sender: TObject);
///////////////////////////////////////////////////////
begin

   if pobs.Visible then begin
     pobs.Visible:=false;
     pobs.Enabled:=false;
     textoobs.visible:=false;
     textoobs.Enabled:=false;
     Sistema.Edit('estoque');
     Sistema.SetField('esto_obs',textoobs.Lines.Text);
     Sistema.Post('esto_codigo='+EdEsto_codigo.AsSql);
     Sistema.Commit;
     Arq.TEstoque.Refresh;
     EdEsto_codigo.GetFields(FEstoque,0);
     Grid.SetFocus;
     exit;
   end else begin
     pobs.Visible:=true;
     pobs.Enabled:=true;
     textoobs.visible:=true;
     textoobs.Enabled:=true;
     if Arq.TEstoque.FieldByName('esto_obs').AsString<>'' then
       textoobs.Lines.Text:=Arq.TEstoque.FieldByName('esto_obs').AsString
     else if ( FGeral.GetConfig1AsInteger('GRUPOARMAS')>0 ) and
             ( FGeral.GetConfig1AsInteger('GRUPOARMAS') = Edesto_grup_codigo.AsInteger ) then begin
         Textoobs.Lines.add('Calibre       :');
         Textoobs.Lines.add('Modelo        :');
         Textoobs.Lines.add('No.raias      :');
         Textoobs.Lines.add('Sentido raia  :');
         Textoobs.Lines.add('Tipo          :');
         Textoobs.Lines.add('Funcionamento :');
         Textoobs.Lines.add('Pais Origem   :');
         Textoobs.Lines.add('Marca         :');
         Textoobs.Lines.add('Acabamento    :');
         Textoobs.Lines.add('No. canos     :');
         Textoobs.Lines.add('Comprimento   :');
         Textoobs.Lines.add('Capacidade    :');
     end else
       textoobs.Lines.Text:=Arq.TEstoque.FieldByName('esto_obs').AsString;
     textoobs.SetFocus;
   end;
end;

procedure TFEstoque.bdigitargradeClick(Sender: TObject);
begin
  if not PEdits.Visible then exit;
  if OP='I' then exit;
  if EdEsto_grad_codigo.AsInteger>0 then begin
    EdEsto_grad_codigo.ValidFind;
    Grid.Enabled:=false;
    GridGrade.Enabled:=true;
    GridGrade.Visible:=true;
    PGrade.Visible:=true;
    PGrade.Enabled:=true;
    FGeral.Linhatogrid(EdEsto_grad_codigo.AsInteger,EdEsto_grad_codigo.ResultFind.fieldbyname('Grad_linha').AsString,GridGrade);
    FGeral.Colunatogrid(EdEsto_grad_codigo.AsInteger,EdEsto_grad_codigo.ResultFind.fieldbyname('Grad_coluna').AsString,GridGrade);
    QtdetoGrid(GridGrade,EdEsto_codigo.Text,EdEsto_grad_codigo.asinteger);
    Gridgrade.setfocus;
  end;

end;

procedure TFEstoque.Gravagrade(Op: string);
var l,c:integer;
begin
  if EdEsto_grad_codigo.asinteger=0 then begin
    Avisoerro('Grade n�o gravada !!!   Codigo da grade est� vazio');
    exit;
  end;
//  if OP<>'I' then begin
//    Executesql('Update Estgrades set esgr_status=''C'' where esgr_status=''N'''+
//               ' and esgr_esto_codigo='+EdEsto_codigo.AsSql+
//               ' and esgr_grad_codigo='+EdEsto_grad_codigo.AsSql);
//    Executesql('Update Estoqueqtde set esqt_status=''C'' where esqt_status=''N'''+
//               ' and esqt_esto_codigo='+EdEsto_codigo.AsSql);
//  end;
// percorrer todo o grid e gravar para cada coordenada um registro
  if OP='I' then begin   // 16.08.06
    for l:=1 to GridGRade.RowCount do begin
      for c:=1 to GridGrade.ColCount do begin
        if trim(GridGrade.Cells[c,l])<>'' then begin
          Gravadadosgrade(texttovalor(GridGrade.Cells[c,l]),l,c);
        end;
      end;
    end;
    Sistema.Commit;
  end;

end;

procedure TFEstoque.Gravadadosgrade(Qtde:Currency;linha,coluna:integer);
var tama_codigo,core_codigo,copa_codigo:integer;
    Listalinha,Listacoluna:Tstringlist;
begin
    ListaLInha:=TStringlist.create;
    ListaColuna:=TStringlist.create;
    EdEsto_grad_codigo.validfind;
    strtolista(Listalinha,EdEsto_grad_codigo.ResultFind.fieldbyname('grad_linha').AsString,';',true);
    strtolista(Listacoluna,EdEsto_grad_codigo.ResultFind.fieldbyname('grad_coluna').AsString,';',true);

    try
    if EdEsto_grad_codigo.ResultFind.fieldbyname('grad_codigolinha').AsInteger=2 then begin // cores
//      core_codigo:=strtoint(Listalinha[coluna-1]);
//      tama_codigo:=strtoint(Listacoluna[linha-1]);
      core_codigo:=strtoint(Listalinha[linha-1]);
      tama_codigo:=strtoint(Listacoluna[coluna-1]);
    end else begin
//      tama_codigo:=strtoint(Listalinha[coluna-1]);
//      core_codigo:=strtoint(Listacoluna[linha-1]);
      tama_codigo:=strtoint(Listalinha[linha-1]);
      core_codigo:=strtoint(Listacoluna[coluna-1]);
    end;
    except
      showmessage('erro do q n�o � integer valido ...');
    end;

    Freeandnil(ListaLinha);
    Freeandnil(ListaColuna);

    try
    Sistema.Insert('EstGrades');
    Sistema.SetField('esgr_status','N');
    Sistema.SetField('esgr_unid_codigo',Global.CodigoUnidade);
    Sistema.SetField('esgr_esto_codigo',EdEsto_codigo.Text);
    Sistema.SetField('esgr_grad_codigo',EdEsto_grad_codigo.AsInteger);
//    Sistema.SetField('esgr_codigolinha',EdEsto_grad_codigo.ResultFind.fieldbyname('grad_codigolinha').AsInteger);
//    Sistema.SetField('esgr_codigocoluna',EdEsto_grad_codigo.ResultFind.fieldbyname('grad_codigocoluna').AsInteger);
    Sistema.SetField('esgr_codigolinha',linha);   // estes linha e coluna s�o a posicao no grid da grade
    Sistema.SetField('esgr_codigocoluna',coluna);
    Sistema.SetField('esgr_qtde',Qtde);
    if not Global.Usuario.OutrosAcessos[0010] then
      Sistema.SetField('esgr_qtdeprev',Qtde)
    else
      Sistema.SetField('esgr_qtdeprev',Trazqtde(linha,coluna));
    Sistema.SetField('esgr_tama_codigo',tama_codigo);
    Sistema.SetField('esgr_core_codigo',core_codigo);
    Sistema.SetField('esgr_usua_codigo',Global.Usuario.Codigo);
    Sistema.Setfield('esgr_vendavis',EdEsto_vendavis.AsCurrency);
    Sistema.Setfield('esgr_custo',EdEsto_custo.AsCurrency);
    Sistema.Setfield('esgr_custoger',EdEsto_custoger.AsCurrency);
    Sistema.Setfield('esgr_customedio',EdEsto_customedio.AsCurrency);
    Sistema.Setfield('esgr_customeger',EdEsto_customeger.AsCurrency);
    Sistema.Setfield('esgr_dtultvenda',EdEsto_dtultvenda.AsDate);
    Sistema.Setfield('esgr_dtultcompra',EdEsto_dtultcompra.AsDate);
    Sistema.Post('');
// aqui nao grava codigo de barra  pois ser� pedido na op��o dados grade

    except
      showmessage('erro gravando estgrades');
    end;

// por enquanto n�o est� previsto dusa quantidades para o estoque por grade
{
    try
    Sistema.Insert('Estoqueqtde');
    Sistema.Setfield('esqt_status','N');
    Sistema.Setfield('esqt_unid_codigo',Global.CodigoUnidade);
    Sistema.Setfield('esqt_esto_codigo',EdEsto_codigo.Text);
    Sistema.Setfield('esqt_qtde',Qtde);
    Sistema.Setfield('esqt_qtdeprev',Qtde);
    Sistema.Setfield('esqt_vendavis',EdEsto_vendavis.AsCurrency);
    Sistema.Setfield('esqt_custo',EdEsto_custo.AsCurrency);
    Sistema.Setfield('esqt_custoger',EdEsto_custoger.AsCurrency);
    Sistema.Setfield('esqt_customedio',EdEsto_customedio.AsCurrency);
    Sistema.Setfield('esqt_customeger',EdEsto_customeger.AsCurrency);
    Sistema.Setfield('esqt_dtultvenda',EdEsto_dtultvenda.AsDate);
    Sistema.Setfield('esqt_dtultcompra',EdEsto_dtultcompra.AsDate);
    Sistema.Setfield('esqt_desconto',EdEsto_desconto.AsCurrency);
    Sistema.Setfield('esqt_basecomissao',EdEsto_basecomissao.AsCurrency);
    Sistema.Setfield('esqt_cfis_codigoest',EdEsto_cfis_codigoest.Ascurrency);
    Sistema.Setfield('esqt_cfis_codigoforaest',EdEsto_cfis_codigoforaest.AsCurrency);
    Sistema.Setfield('esqt_sitt_codestado',EdEsto_sitt_codestado.AsInteger);
    Sistema.Setfield('esqt_sitt_forestado',EdEsto_sitt_forestado.AsInteger);
    Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
    Sistema.Setfield('esqt_core_codigo',core_codigo);
    Sistema.Setfield('esqt_tama_codigo',tama_codigo);  // ver grade
    Sistema.Post;
}

end;

procedure TFEstoque.QtdetoGrid(GridGrade: TSqlDtgrid; Codproduto: string;
  CodGrade: integer);

  procedure LimpaqtdeGrid(Gridgrade:TSqlDtgrid);
  var l,c:integer;
  begin
    for l:=1 to GridGrade.ColCount do begin
      for c:=1 to GridGrade.RowCount do begin
        GridGrade.Cells[c,l]:='';
      end;
    end;
  end;


var Q:TSqlquery;
begin
  LimpaqtdeGrid(GridGrade);
  ListaQtde.clear;
  Q:=Sqltoquery('select * from estgrades where esgr_esto_codigo='+EdEsto_codigo.AsSql+
                ' and esgr_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                ' and esgr_status=''N''');
  if not Q.Eof then begin
    while not Q.Eof do begin
      GridGrade.Cells[Q.FieldByName('esgr_codigocoluna').AsInteger,Q.FieldByName('esgr_codigolinha').AsInteger]:=Q.FieldByName('esgr_qtde').AsString;
      if Global.Usuario.OutrosAcessos[0010] then begin
        New(PListaqtde);
        PListaqtde.linha:=Q.FieldByName('esgr_codigolinha').AsInteger;
        PListaqtde.coluna:=Q.FieldByName('esgr_codigocoluna').AsInteger;
        PListaqtde.qtde:=Q.FieldByName('esgr_qtdeprev').Ascurrency;
        ListaQtde.Add(PListaqtde);
      end;
      Q.Next;
    end;
  end;
  Q.Close;
  Q.free;
end;

procedure TFEstoque.EdGradeKeyPress(Sender: TObject; var Key: Char);
begin
   FGeral.Limpaedit(EdGrade,key);
end;

/////////////////////////////////////////////////////////////////////////
procedure TFEstoque.DadosQtdetoEdits(CodigoProduto, Unidade: string);
/////////////////////////////////////////////////////////////////////////
var QM,
    QQ:TSqlquery;
    unitario,xmargem,unitariograde,tamanho:currency;
    unidades : string;

    Procedure SomaEstoqueGrade;
    //////////////////////////
    var QG:TSqlquery;
        qtde,qtdeprev:currency;
    begin
      QG:=sqltoquery('select esgr_qtde,esgr_qtdeprev from estgrades'+
                     ' where esgr_status=''N'' and esgr_esto_codigo='+EdEsto_codigo.AsSql+
                     ' and esgr_unid_codigo='+Stringtosql(Global.CodigoUnidade) );
      qtde:=0;qtdeprev:=0;
      if not Qg.eof then begin
        while not QG.eof do begin
          qtde:=qtde+Qg.fieldbyname('esgr_qtde').ascurrency;
          qtdeprev:=qtdeprev+Qg.fieldbyname('esgr_qtdeprev').ascurrency;
          Qg.Next;
        end;
        if (qtde+qtdeprev) >= 0 then begin
            EdEsto_qtde.SetValue(qtde);
            EdEsto_qtdeprev.SetValue(qtdeprev);
        end;
      end;
      FGeral.FechaQuery(QG);
    end;

    Function RegradoGrupo(xprod:string):integer;
    ////////////////////////////////////////////
    begin
// ver criar campo 'formula ou regra' no cadastro de grupos e retornar este novo campo
      result:=0;
      if FEstoque.GetGrupo(xprod)=1 then
        result:=1
      else if FEstoque.GetGrupo(xprod)=2 then
        result:=2;
    end;



begin
/////
  QX:=sqltoquery('select * from EstoqueQtde'+
                ' where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Codigoproduto)+
                ' and esqt_unid_codigo='+Stringtosql(Unidade));
// 21.01.14
  QM:=sqltoquery('select esqt_vendavis from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Codigoproduto)+
                ' and esqt_unid_codigo='+Stringtosql(Global.unidadematriz));

  if not Qx.Eof then begin

    unitario:=Qx.fieldbyname('esqt_vendavis').AsCurrency;
    EdEsto_qtde.SetValue(Qx.fieldbyname('esqt_qtde').AsCurrency);
    EdEsto_qtdeprev.SetValue(Qx.fieldbyname('esqt_qtdeprev').AsCurrency);
// 30.08.2021
    if Global.Topicos[1240] then begin

       unidades := FGeral.GetConfig1asstring('unidadesestoque');
       if trim(unidades)='' then unidades := Global.CodigoUnidade;

       QQ := sqltoquery('select sum(esqt_qtde) as esqt_qtde,sum(esqt_qtdeprev) as esqt_qtdeprev from EstoqueQtde'+
             ' where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Codigoproduto)+
             ' and '+FGEral.GetIN('esqt_unid_codigo',Unidades,'C') );
       EdEsto_qtde.SetValue(QQ.fieldbyname('esqt_qtde').AsCurrency);
       EdEsto_qtdeprev.SetValue(QQ.fieldbyname('esqt_qtdeprev').AsCurrency);
       FGeral.Fechaquery( QQ );

    end;

// 11.01.14  - Metalforte
    if ( Global.Topicos[1411] ) and ( (regradogrupo(Codigoproduto)=2) or (regradogrupo(Codigoproduto)=1) )      then begin
// se for ferro ..
// ver criar campo 'formula ou regra' no cadastro de grupos - aqui fixo barra com 6 metros
// 22.01.14 - no ferro o peso j� da barra de 6 metros....
      unitario:=Qx.fieldbyname('esqt_custo').AsCurrency;
//      if regradogrupo(Codigoproduto)=1 then
//        unitario:=unitario*Arq.TEstoque.fieldbyname('esto_peso').AsCurrency
//      else
// se for aluminio - deixado fixo codigo 1 ( tamanho 6 mts ) e codigo 2 cor ( preto )
// deixado o natural
        unitariograde:=0;
//        FEstoque.GetPrecoGrade(Codigoproduto,Global.CodigoUnidade,1,2) ;
        unitario:=unitario+unitariograde;
        unitario:=unitario*Arq.TEstoque.fieldbyname('esto_peso').ascurrency;
        tamanho:=(FEstoque.GetComprimentoPadrao(Global.CodigoUnidade,Codigoproduto)/1000);
        if tamanho=0 then
          unitario:=unitario*6  // ( caso nao tenha a grade informada multiplica por 6mts )
        else
          unitario:=unitario*tamanho;

        xmargem:=FGrupos.GetPercentualMarkup(Arq.TEstoque.fieldbyname('esto_grup_codigo').asinteger);
        if xmargem<=100 then
          unitario:=unitario/( (100-xmargem)/100 )
        else
          unitario:=unitario*2;
// 21.01.14
    end else begin
// 14.02.14
      if Global.Topicos[1362] then
        unitario:=QM.fieldbyname('esqt_vendavis').AsCurrency
      else
        unitario:=Qx.fieldbyname('esqt_vendavis').AsCurrency;
    end;

    EdEsto_vendavis.SetValue(unitario);
    EdEsto_vendavis.Update;

    EdEsto_custo.SetValue(Qx.fieldbyname('esqt_custo').AsCurrency);
    EdEsto_custoger.SetValue(Qx.fieldbyname('esqt_custoger').AsCurrency);
    EdEsto_customedio.SetValue(Qx.fieldbyname('esqt_customedio').AsCurrency);
    EdEsto_customeger.SetValue(Qx.fieldbyname('esqt_customeger').AsCurrency);
    EdEsto_dtultvenda.SetDate(Qx.fieldbyname('esqt_dtultvenda').AsDateTime);
    EdEsto_dtultcompra.SetDate(Qx.fieldbyname('esqt_dtultcompra').AsDateTime);
    EdEsto_desconto.SetValue(Qx.fieldbyname('esqt_desconto').AsCurrency);
    EdEsto_basecomissao.SetValue(Qx.fieldbyname('esqt_basecomissao').AsCurrency);
    EdEsto_cfis_codigoest.Text:=(Qx.fieldbyname('esqt_cfis_codigoest').AsString);
    EdEsto_cfis_codigoforaest.Text:=(Qx.fieldbyname('esqt_cfis_codigoforaest').AsString);
    EdEsto_sitt_codestado.SetValue(Qx.fieldbyname('esqt_sitt_codestado').AsInteger);
    EdEsto_sitt_forestado.SetValue(Qx.fieldbyname('esqt_sitt_forestado').AsInteger);
// 03.11.07
    EdEsto_pecas.SetValue(Qx.fieldbyname('esqt_pecas').AsCurrency);
// 21.08.06
    if not EdEsto_sitt_codestado.isempty then begin

      EdEsto_sitt_codestado.Validfind;
// 14.06.19
      if AnsiPos( FUnidades.GetSimples(global.CodigoUnidade),'S;2' ) >0 then
         SetEdsitt_cst.text:=EdEsto_sitt_codestado.ResultFind.fieldbyname('sitt_cstme').asstring
      else
         SetEdsitt_cst.text:=EdEsto_sitt_codestado.ResultFind.fieldbyname('sitt_cst').asstring;
    end;

    if not EdEsto_sitt_forestado.isempty then begin
      EdEsto_sitt_forestado.validfind;
// 14.06.19
      if AnsiPos( FUnidades.GetSimples(global.CodigoUnidade),'S;2' ) >0 then
         SetEd.text:=EdEsto_sitt_forestado.ResultFind.fieldbyname('sitt_cstme').asstring
      else
         SetEd.text:=EdEsto_sitt_forestado.ResultFind.fieldbyname('sitt_cst').asstring;
    end;

    if trim(EdEsto_cfis_codigoest.text)<>'' then begin
      EdEsto_cfis_codigoest.validfind;
      EdEsto_cfis_codigoforaest.validfind;
    end;
// 21.03.11
    if not EdEsto_Grup_codigo.isempty then
      EdEsto_Grup_codigo.validfind;
    if not EdEsto_Sugr_codigo.isempty then
      EdEsto_Sugr_codigo.validfind;
    if not EdEsto_Fami_codigo.isempty then
      EdEsto_Fami_codigo.validfind;
// 05.04.12
    if not EdEsto_Cipi_codigo.isempty then
      EdEsto_cipi_codigo.validfind
    else
      SetEddescriipi.Clear;   // 06.07.13

    EdEsto_vendamin.SetValue(Qx.fieldbyname('esqt_vendamin').AsCurrency);
// 29..02.08
    EdLocalizacao.text:=Qx.fieldbyname('esqt_localiza').Asstring;
// 02.04.08
    Edmobra.SetValue(Qx.fieldbyname('esqt_custoser').AsCurrency);
    Edmomedio.SetValue(Qx.fieldbyname('esqt_customedioser').AsCurrency);
// 29.04.09
    campo:=Sistema.GetDicionario('estoqueqtde','esqt_ressuprimento');
    if campo.Tipo<>'' then
      EdPontoRessu.setvalue(Qx.fieldbyname('esqt_ressuprimento').AsFloat);
// 16.10.09
    campo:=Sistema.GetDicionario('estoqueqtde','esqt_qtdeprocesso');
    if campo.Tipo<>'' then
      EdQtdeprocesso.setvalue(Qx.fieldbyname('esqt_qtdeprocesso').AsFloat);
// 28.03.11
    campo:=Sistema.GetDicionario('estoqueqtde','esqt_cfis_codestsemie');
    if campo.Tipo<>'' then
      Edesqt_cfis_codestsemie.text:=(Qx.fieldbyname('esqt_cfis_codestsemie').AsString);
// 13.02.19
    if campogrupodescricao.Tipo<>'' then begin
       if Arq.TEstoque.fieldbyname('esto_grup_descricao').AsString<>'' then
          EdEsto_grup_descricao.text:=(Arq.TEstoque.fieldbyname('esto_grup_descricao').AsString)
       else begin

          EdEsto_grup_descricao.text:= FGrupos.GetDescricao( Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger );
          Arq.TEstoque.Edit;
          Arq.TEstoque.FieldByName('esto_grup_descricao').AsString:=EdEsto_grup_descricao.text;
          Arq.TEstoque.Post;
          Arq.TEstoque.ApplyUpdates(0);

       end;
    end;

    if not Edesqt_cfis_codestsemie.isempty then
      Edesqt_cfis_codestsemie.validfind;
    if Global.Usuario.OutrosAcessos[0053] then begin
      if not PEdits.Visible then
        PEdits.Visible:=true;
    end;
// 22.11.13 - Metalforte
    if Global.Topicos[1224] then SomaEstoqueGrade;
// 08.02.17
  if not pgrade.Visible then begin
    PemEstoque.Caption:=Edesto_qtde.text ;
    PemEstoque.UpdateControlState;
  end;
  if not pgrade.Visible then begin
    Pprecovenda.Caption:=EdEsto_vendavis.text ;
    Pprecovenda.Update;
  end;
// 24.02.17
  EdEsto_categoria.GetField;
  EdEsto_categoria.Update;

  end else begin

    if OP='A' then
      Avisoerro('Aten��o !  Item '+edesto_codigo.text+' n�o encontrado na tabela estoqueqtde.  N�O GRAVAR !!!');
    EdEsto_qtde.SetValue(0);
    EdEsto_qtdeprev.SetValue(0);
    EdEsto_vendavis.SetValue(0);
    EdEsto_custo.SetValue(0);
    EdEsto_custoger.SetValue(0);
    EdEsto_customedio.SetValue(0);
    EdEsto_customeger.SetValue(0);
    EdEsto_dtultvenda.Text:='';
    EdEsto_dtultcompra.Text:='';
    EdEsto_desconto.SetValue(0);
    EdEsto_basecomissao.SetValue(0);
    EdEsto_cfis_codigoest.Text:='';
    EdEsto_cfis_codigoforaest.Text:='';
    EdEsto_sitt_codestado.SetValue(0);
    EdEsto_sitt_forestado.SetValue(0);
    EdEsto_vendamin.SetValue(0);
    EdEsto_pecas.SetValue(0);
  end;
end;

function TFEstoque.GetCodigoGrade(codigo: string): integer;
////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Result:=0;
  if Trim(Codigo)<>'' then begin
//    if not Arq.TEstoque.Active then Arq.TEstoque.Open;
//    if Arq.TEstoque.Locate('esto_codigo',Codigo,[]) then Result:=Arq.TEstoque.FieldByName('Esto_Grad_codigo').AsInteger;
     Q:=sqltoquery('select esto_grad_codigo from estoque where esto_codigo='+stringtosql(codigo));
     if not Q.Eof then
       Result:=Q.FieldByName('Esto_Grad_codigo').AsInteger;
     Q.close;
     Freeandnil(Q);
  end;
end;

function TFEstoque.GetCodigoColuna(produto: string;
  grade: integer): integer;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from estgrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(produto)+
                ' and esgr_grad_codigo='+inttostr(grade) );
  if not Q.Eof then
    result:=Q.fieldbyname('esgr_codigocoluna').AsInteger
  else
    result:=0;
  Freeandnil(Q);
end;

function TFEstoque.GetCodigoLinha(produto: string;
  grade: integer): integer;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from estgrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(produto)+
                ' and esgr_grad_codigo='+inttostr(grade) );
  if not Q.Eof then
    result:=Q.fieldbyname('esgr_codigolinha').AsInteger
  else
    result:=0;
  Freeandnil(Q);

end;

procedure TFEstoque.EdEsto_codbarraValidate(Sender: TObject);
var Q:TSqlquery;
begin
  if trim(EdEsto_codbarra.Text)<>'' then begin
    Q:=sqltoquery('select * from estoque where esto_Codbarra='+EdEsto_codbarra.AsSql);
    if (not Q.Eof) and (Q.Fieldbyname('esto_codigo').AsString<>EdEsto_codigo.Text) then
      EdEsto_codbarra.Invalid('Codigo de barra pertence ao codigo '+Q.Fieldbyname('esto_codigo').AsString)
    else
     Q.Close;
    Freeandnil(Q);
  end;
end;

procedure TFEstoque.EdEsto_descricaoValidate(Sender: TObject);
var Q:TSqlquery;
begin
end;

procedure TFEstoque.EdEsto_grup_codigoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin

   if campogrupodescricao.Tipo<>'' then EdEsto_grup_descricao.Text:=SetEdgrup_codigo.Text;


end;

////////////////////////////////////////////////////////////////////////////////
function TFEstoque.GetPreco(Produto,Unidade: string ; ufcliente:string='' ; aliicms:currency=0 ;
         Tipo:string='F' ; valorbase:currency=0 ; xcontribuinte:string='' ): currency;
////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    preco:currency;
    unidadesnao,unidadebusca,cf:string;
    margemlucro,icmsitemsubs,icmssub,icmsitem,margempreco:currency;
    grupo:integer;

begin
  preco:=0;
// 12.10.05 - unidades 'nao toke' tem q buscar o pre�o de venda na pr�pria unidade
  unidadesnao:='100;900';
  if pos( Global.CodigoUnidade,unidadesnao )>0 then
    unidadebusca:=Global.codigounidade
// 04.03.13 - Vivan Financeiro - Lindacir - usar pre�o da matriz ( 001 )
  else if Global.topicos[1362] then
    unidadebusca:=Global.unidadematriz
  else
    unidadebusca:=unidade;
  Q:=sqltoquery('select esqt_vendavis from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Produto)+
                ' and esqt_unid_codigo='+Stringtosql(Unidadebusca));
// 24.03.14 - Lindacir - para o caso de incluir em outra unidade e alterar o pre�o de venda antes de transferir
  if Q.eof then begin
    FGeral.FechaQuery(Q);
    Q:=sqltoquery('select esqt_vendavis from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Produto)+
                  ' and esqt_unid_codigo='+Stringtosql('002'));
  end;

// 23.03.06 - as vezes o clientdataset nao esta aberto cfe de onde chama o getpreco
//  if Arq.TEstoque.active then
//    grupo:=Arq.TEstoque.fieldbyname('esto_grup_codigo').asinteger
//  else
// 05.06.06 0 alterado getgrupo para nao usar clientdataset - uma vez imprimir romaneio sem a subt. embutida
//            no regime especial
  grupo:=FEstoque.GetGrupo(produto);
  margempreco:=FGrupos.GetPercentualMargem(grupo);

// 05.06.06  alterado para nao usar clientdataset - uma vez imprimir romaneio sem a subt. embutida
//           no regime especial
//  if Arq.TSittributaria.active then
//    cf:=Arq.TSittributaria.fieldbyname('sitt_cf').asstring
//  else begin
    Arq.TSittributaria.open;
    cf:=FEstoque.Getcf(produto,unidadebusca,ufcliente);
//  end;
////////////////////////////////////////////////////

  if not Q.eof then begin
    preco:=Q.fieldbyname('esqt_vendavis').AsCurrency;
// 09.02.06
    if valorbase>0 then
      preco:=valorbase;
//////////// - 25.01.06
//    if trim(ufcliente)<>'' then begin
// 24.03.16 - Markito
    if (trim(ufcliente)<>'') and ( ( Global.topicos[1392] ) or ( Global.topicos[1229] )   ) then begin
      if grupo=FGeral.Getconfig1asinteger('grupojoias') then begin
         preco:=preco+0;
      end else if (cf=Global.CodigoSubsTrib)
//                  and (Tipo='F')
                   and ( pos(UfCliente,Global.UfComSubstituicao)>0 )
                   and (UfCliente=Global.UFUnidade )
            then begin
// 30.03.16
            if not Global.topicos[1229] then begin
              margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,Unidadebusca,ufcliente));
              icmsitem:=preco*(aliicms/100);
              icmsitemsubs:=(preco*(1+(margemlucro/100))) * (aliicms/100);
              icmsitemsubs:=icmsitemsubs-icmsitem;
              if icmsitemsubs>0 then begin
  //               if valorbase>0 then
                   preco:=preco+icmsitemsubs
  //               else
  // 27.01.06 - joacir+cassio
  //                 preco:=preco*(1.05)
  // 24.03.16 -retirado
              end;
            end else begin
              margempreco:=GetMargemcomST(UfCliente,xContribuinte);
              preco:=preco+roundvalor(preco*(margempreco/100))
            end;
      end else if ( pos(UfCliente,Global.UfComSubstituicao)>0 )
//               and (Tipo='F')
               and (UfCliente<>Global.UFUnidade )
            then begin
            if not Global.topicos[1229] then begin
    // 25.01.06
    // procuara a margem dentro do estado nao usando o estado do cliente quando a venda � fora do estado
              margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,Unidadebusca,Global.UFUnidade));
              icmsitem:=preco*(aliicms/100);
              icmsitemsubs:=(preco*(1+(margemlucro/100))) * (aliicms/100);
              icmsitemsubs:=icmsitemsubs-icmsitem;
              if icmsitemsubs>0 then begin
  //               if valorbase>0 then
                   preco:=preco+icmsitemsubs
  //               else
  // 27.01.06 - joacir+cassio
  //                preco:=preco*(1.05)
  // retirado em 24.03.16
              end;
            end else begin
              margempreco:=GetMargemcomST(UfCliente,xContribuinte);
              preco:=preco+roundvalor(preco*(margempreco/100))
            end;
      end;
    end;
///////////
  end;
  Q.Close;
  Freeandnil(Q);
  result:=preco;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TFEstoque.Getaliquotaicms(codigoestoque, unidade, UF: string ; Codigo:integer=0 ; Tipomov:string='' ; revenda:string='N'  ; ytipocad:string='C' ): currency;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var QBusca,QTipo,QSubgrupo,TCodigosFiscais:Tsqlquery;
    codigofis,codigofisestado,codigofisestadosemie:string;
    TEst:TSqlQuery;  // 01.08.11
    subgrupodevcompra:integer;


    function GetEcooperado(xcod:integer):string;
    /////////////////////////////////////////////
    var QC:TSqlQuery;  // 10.03.15
    begin
      Qc:=sqltoquery('select clie_ativo from clientes where clie_codigo='+inttostr(codigo));
      if not Qc.eof then result:=Qc.fieldbyname('clie_ativo').AsString else result:='N';
      FGeral.FechaQuery(Qc);
    end;

// 08.07.16 - Zilmar - ST para cliente do simples ou nao
///////////////////////////////////////////////////////////
    function GetEIcmsNormal(xcod:integer):string;
    //////////////////////////////////////////////
    var QC:TSqlQuery;  // 10.03.15
    begin
      Qc:=sqltoquery('select clie_contribuinte from clientes where clie_codigo='+inttostr(codigo));
      result:='N';
      if not Qc.eof then begin
        if (Qc.fieldbyname('clie_contribuinte').AsString='2') then result:='S';
      end;
      FGeral.FechaQuery(Qc);
    end;

begin
////////////////
//  if not Arq.TEstoque.active then Arq.TEstoque.open;
// 01.08.11 - mudado de 'arq pra sqlquery'
//  if not Arq.TCodigosFiscais.active then Arq.TCodigosFiscais.open;
  codigoestoque:=trim(codigoestoque);   // um codigo veio '1279 '..com espa�o no final..vai saber...
  TEst:=Sqltoquery('select * from estoque where esto_codigo='+Stringtosql(codigoestoque));
  if not Arq.TUnidades.active then Arq.TUnidades.open;
  Arq.TUnidades.Locate('unid_codigo',unidade,[]);
  subgrupodevcompra:=FGeral.Getconfig1asinteger('subgrupodevcom');
  result:=0;
//  if Arq.TEstoque.Locate('esto_codigo',codigoestoque,[]) then begin
  if not TEst.eof then begin  // 01.08.11

// 18.03.2022
   if subgrupodevcompra = 0 then

      subgrupodevcompra:=TEst.fieldbyname('esto_sugr_codigo').AsInteger;

// 25.03.11
    campo:=Sistema.GetDicionario('estoqueqtde','esqt_cfis_codestsemie');
    QBusca:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Codigoestoque,Unidade));
    if not QBusca.Eof then begin
      codigofisestado:=QBusca.FieldByName('esqt_cfis_codigoest').asstring;
// 20.04.11 - Asatec
      if campo.Tipo<>'' then
        codigofisestado:=QBusca.FieldByName('esqt_cfis_codestsemie').asstring;
//////////////////
      if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then begin
        codigofis:=QBusca.FieldByName('esqt_cfis_codigoest').asstring;
      end else
        codigofis:=QBusca.FieldByName('esqt_cfis_codigoforaest').asstring;
// 10.03.15 - coorlafs
      if (Global.Topicos[1226]) and (codigo>0) then begin
        if GetEcooperado(codigo)='S' then begin
          if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then begin
            codigofis:=QBusca.FieldByName('Esqt_cfis_codestnc').asstring;
          end else
            codigofis:=QBusca.FieldByName('Esqt_cfis_codforaestnc').asstring;
        end;
      end;
//////////////////////
// 05.08.08
      TCodigosFiscais:=sqltoquery('select * from codigosfis where cfis_codigo='+stringtosql(codigofis));
      if not TCodigosFiscais.eof then begin
         result:=TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
      end;
//////////////////////
      FGeral.FechaQuery(TCodigosFiscais);
//      if Arq.TCodigosFiscais.Locate('cfis_codigo',codigofis,[]) then begin
//         result:=Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
//      end;
// 22.08.05 - para icms em estados 'fora do padrao'
      if (pos(UF,FGeral.getconfig1asstring('ICMSUF01'))>0) and (FGeral.getconfig1asfloat('ICMS01')>0) then
        result:=FGeral.getconfig1asfloat('ICMS01')
// 31.08.05
      else if (Tipomov=Global.CodVendaConsigMercantil) and (tipomov<>'') then
        result:=0
// 11.03.10  - Novi - Vava
      else if (Tipomov=Global.CodDevolucaoCompraProdutor) and (tipomov<>'') then
        result:=0
// 13.11.15  - Mirvane
      else if (Tipomov=Global.CodNfeComplementoIcms) and (tipomov<>'') then
        result:=result
// 26.05.06 - Valmir
      else if pos( Tipomov,Global.TiposNaoCalcIcms ) >0 then
        result:=0
// 09.11.05
      else if (Tipomov=Global.CodDevolucaoCompra) and (tipomov<>'') and ((subgrupodevcompra=0)) then begin

        if (codigo>0) then begin
          QTipo:=sqltoquery('select forn_contribuinte from fornecedores where forn_codigo='+inttostr(codigo));
          if not QTipo.eof then begin
            if QTipo.fieldbyname('forn_contribuinte').asstring='N' then
              result:=0;
          end;
        end;

      end else if (codigo>0) and (UF<>Arq.TUnidades.fieldbyname('unid_uf').AsString) and (revenda<>'R')
// 04.08.20 s� se nao for devolucao....
            and  (ansipos(Tipomov,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada) = 0)
        then begin

        QTipo:=sqltoquery('select clie_tipo,clie_rgie from clientes where clie_codigo='+inttostr(codigo));
        if not QTipo.eof then begin
          if (QTipo.fieldbyname('clie_tipo').asstring='F') then begin
// 05.08.08
            TCodigosFiscais:=sqltoquery('select * from codigosfis where cfis_codigo='+stringtosql(codigofisestado));
            if not TCodigosFiscais.eof then
               result:=TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
            FGeral.FechaQuery(TCodigosFiscais);
//            if Arq.TCodigosFiscais.Locate('cfis_codigo',codigofisestado,[]) then
//              result:=Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;

          end else if(QTipo.fieldbyname('clie_tipo').asstring='J') then begin

            if (QTipo.fieldbyname('clie_rgie').asstring='') or (Uppercase(QTipo.fieldbyname('clie_rgie').asstring)='ISENTO') then begin
// 05.08.08
              TCodigosFiscais:=sqltoquery('select * from codigosfis where cfis_codigo='+stringtosql(codigofisestado));
              if not TCodigosFiscais.eof then
                 result:=TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
              FGeral.FechaQuery(TCodigosFiscais);
//              if Arq.TCodigosFiscais.Locate('cfis_codigo',codigofisestado,[]) then
//                result:=Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
            end;
          end;
        end;
        QTipo.close;
        Freeandnil(QTipo);
// 01.08.06
//      end else if (codigo>0) and ( (revenda='R') or (GetEIcmsNormal(codigo)='S' ) ) then begin
// 02.07.18 - Siccare - mesmo produto ora tem ora nao tem ST
      end else if (codigo>0) and ( (revenda='S') or (GetEIcmsNormal(codigo)='S' ) ) then begin
      //////////////////////////////////////////
        QSubgrupo:=sqltoquery('select * from subgrupos where sugr_codigo='+TEst.fieldbyname('esto_sugr_codigo').Asstring);
        if not QSubgrupo.eof then begin
           if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
              codigofis:=QSubgrupo.fieldbyname('sugr_cfis_codigoest').asstring
           else
              codigofis:=QSubgrupo.fieldbyname('sugr_cfis_codigoforaest').asstring;
// 05.08.08
           TCodigosFiscais:=sqltoquery('select * from codigosfis where cfis_codigo='+stringtosql(codigofis));
           if not TCodigosFiscais.eof then
              result:=TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
           FGeral.FechaQuery(TCodigosFiscais);
//           if Arq.TCodigosFiscais.Locate('cfis_codigo',codigofis,[]) then begin
//              result:=Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
//           end;
        end;
        FGeral.Fechaquery(QSubgrupo);
// 06.11.15 -especifico para devolucao de compra
 //////////////////////////////////////////
      end else if (subgrupodevcompra>0) and (pos(Tipomov,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada)>0) and (tipomov<>'') then begin

//        QSubgrupo:=sqltoquery('select * from subgrupos where sugr_codigo='+inttostr(subgrupodevcompra));
// 15.10.2021 - ao inves de usar o subgrupo configurado nas config. gerais usar o q est� no produto
//              para n�o ter q ficar mudando na config. cfe a aliquota do icms da nota sendo devolvida...
//        QSubgrupo:=sqltoquery('select * from subgrupos where sugr_codigo='+TEst.fieldbyname('esto_sugr_codigo').Asstring);
// 18.03.2022
        QSubgrupo:=sqltoquery('select * from subgrupos where sugr_codigo='+IntToStr(subgrupodevcompra));
        if not QSubgrupo.eof then begin
           if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
              codigofis:=QSubgrupo.fieldbyname('sugr_cfis_codigoest').asstring
           else
              codigofis:=QSubgrupo.fieldbyname('sugr_cfis_codigoforaest').asstring;
           TCodigosFiscais:=sqltoquery('select * from codigosfis where cfis_codigo='+stringtosql(codigofis));
           if not TCodigosFiscais.eof then
              result:=TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
           FGeral.FechaQuery(TCodigosFiscais);
        end;
        FGeral.Fechaquery(QSubgrupo);
// 25.03.11 - preve destinatario no estado sem inscricao estadual
/////////////////////////////////////////////////
      end else if (codigo>0) and (UF=Arq.TUnidades.fieldbyname('unid_uf').AsString) and (revenda<>'R') and (campo.tipo<>'' ) then begin

        codigofisestadosemie:=QBusca.FieldByName('esqt_cfis_codestsemie').asstring;
        if ytipocad='F' then begin
          QTipo:=sqltoquery('select Forn_inscricaoestadual from fornecedores where forn_codigo='+inttostr(codigo));
          if not QTipo.eof then begin
              if (QTipo.fieldbyname('Forn_inscricaoestadual').asstring='') or (Uppercase(QTipo.fieldbyname('Forn_inscricaoestadual').asstring)='ISENTO') then begin
                TCodigosFiscais:=sqltoquery('select * from codigosfis where cfis_codigo='+stringtosql(QBusca.fieldbyname('esqt_cfis_codestsemie').AsString) );
                if not TCodigosFiscais.eof then
                   result:=TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
                FGeral.FechaQuery(TCodigosFiscais);
            end;
          end;

        end else begin  // destinatario � cliente

          QTipo:=sqltoquery('select clie_tipo,clie_rgie from clientes where clie_codigo='+inttostr(codigo));
          if not QTipo.eof then begin

            if (QTipo.fieldbyname('clie_tipo').asstring='F') then begin
              TCodigosFiscais:=sqltoquery('select * from codigosfis where cfis_codigo='+stringtosql(QBusca.fieldbyname('esqt_cfis_codestsemie').AsString) );
              if not TCodigosFiscais.eof then
                 result:=TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
              FGeral.FechaQuery(TCodigosFiscais);
  //            if Arq.TCodigosFiscais.Locate('cfis_codigo',codigofisestado,[]) then
  //              result:=Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;

            end else if(QTipo.fieldbyname('clie_tipo').asstring='J') then begin

              if (QTipo.fieldbyname('clie_rgie').asstring='') or (Uppercase(QTipo.fieldbyname('clie_rgie').asstring)='ISENTO') then begin
  // 05.08.08
                TCodigosFiscais:=sqltoquery('select * from codigosfis where cfis_codigo='+stringtosql(codigofisestadosemie));
                if not TCodigosFiscais.eof then
                   result:=TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
                FGeral.FechaQuery(TCodigosFiscais);
  //              if Arq.TCodigosFiscais.Locate('cfis_codigo',codigofisestado,[]) then
  //                result:=Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
              end;
            end;
          end;
        end;   // cliente ou fornec.
        QTipo.close;
        Freeandnil(QTipo);
///////////////////////
      end;
    end;
    QBusca.Close;
    Freeandnil(QBusca);
  end else
    Avisoerro('Codigo ['+codigoestoque+'] n�o encontrado no estoque  ( Aliquota Icms )');
  FGeral.fechaquery(TEst);

end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TFEstoque.Getsituacaotributaria(codigoestoque, unidade, UF: string ; Tipomov:string='' ; Codigo:integer=0  ; revenda:string='N'  ; Simples:string='N'; mens:string='' ): string;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var QBusca,QTipo,QSubgrupo:Tsqlquery;
    codsittrib,codsittribestado,subgrupodevcompra:integer;
    TiposDevolucao:string;
    TEst,TSittributaria:TSqlQuery;  // 22.08.11

    function GetEcooperado(xcod:integer):string;
    /////////////////////////////////////////////
    var QC:TSqlQuery;  // 10.03.15
    begin
      Qc:=sqltoquery('select clie_ativo from clientes where clie_codigo='+inttostr(codigo));
      if not Qc.eof then result:=Qc.fieldbyname('clie_ativo').AsString else result:='N';
      FGeral.FechaQuery(Qc);
    end;

    function GetsemIE(xcod:integer):boolean;
    /////////////////////////////////////////////
    var QC1:TSqlQuery;
    begin
      Qc1:=sqltoquery('select clie_tipo,clie_rgie from clientes where clie_codigo='+inttostr(codigo));
      result:=false;
      if not Qc1.eof then begin

         if Qc1.fieldbyname('clie_tipo').AsString ='F' then result:=true
         else if Qc1.fieldbyname('clie_rgie').AsString='' then result:=true;

      end;
      FGeral.FechaQuery(Qc1);
    end;

begin

  if not Arq.TEstoque.active then Arq.TEstoque.open;
  if not Arq.TSittributaria.active then Arq.TSittributaria.open;
  if not Arq.TUnidades.active then Arq.TUnidades.open;
// 07.07.11
  TiposDevolucao:=Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemEstoque+';'+
                  Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoInd+';'+
                  Global.CodDevolucaoSimbolicaConsig+';'+
                  Global.CodDevolucaodeRemessa+';'+
// 18.03.2022 - para deixar independente do q t� nas config.
                  Global.CodDevolucaoTributada+';'+
                  Global.CodDevolucaoRoman;
  Arq.TUnidades.locate('unid_codigo',unidade,[]);
  result:='000';
  subgrupodevcompra:=FGeral.Getconfig1asinteger('subgrupodevcom');
// 22.08.11 - mudar daqui 'pra baixo' de arq.testoque pra testoque...
  TEst:=Sqltoquery('select * from estoque where esto_codigo='+Stringtosql(codigoestoque));
//  if Arq.TEstoque.Locate('esto_codigo',codigoestoque,[]) then begin
  if not TEst.eof then begin

// 18.03.2022
   if subgrupodevcompra = 0 then

      subgrupodevcompra:=TEst.fieldbyname('esto_sugr_codigo').AsInteger;


    QBusca:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Codigoestoque,Unidade));
    if not QBusca.Eof then begin
      codsittribestado:=QBusca.FieldByName('esqt_sitt_codestado').asinteger;
      if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
        codsittrib:=QBusca.FieldByName('esqt_sitt_codestado').asinteger
      else
        codsittrib:=QBusca.FieldByName('esqt_sitt_forestado').asinteger;
// 10.03.15
      if (Global.Topicos[1226]) and (codigo>0) then begin
        if GetEcooperado(codigo)='S' then begin
          if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
            codsittrib:=QBusca.FieldByName('Esqt_sitt_codestadonc').asinteger
          else
            codsittrib:=QBusca.FieldByName('Esqt_sitt_forestadonc').asinteger;
        end;
      end;
// 25.04.19
      if (Global.Topicos[1461]) and ( FGeral.GetConfig1AsInteger('subgrupovendasemIE') > 0 )
         and ( GetSemIE(codigo) )
         then begin
         codsittrib:=FSubgrupos.GetCodigosituacaotributaria(if_s(uf=Global.UFUnidade,'5102','6102'),FGeral.GetConfig1AsInteger('subgrupovendasemIE') );
      end;
// 05.09.19 - Seip Brasil
      if ( Global.Topicos[1464] )
         and ( uf <> Global.UFUnidade )
//         and ( not GetSemIE(codigo) )
// 27.09.19
         then begin

           codsittrib:=FSubgrupos.GetCodigosituacaotributaria('6102',TEst.FieldByName('esto_sugr_codigo').AsInteger);
// 05.09.19  - para reposicionar a tabela dos cst...
           Arq.TSittributaria.Locate('sitt_codigo',codsittrib,[]);

      end;

// 24.09.14 - 'locurage' dos locate nao acharem mais nada...
      TSittributaria:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr(codsittrib));
//      if Arq.TSittributaria.Locate('sitt_codigo',codsittrib,[]) then begin
      if not TSittributaria.eof then begin
         if pos(simples,'S;2')>0 then
           result:=TSittributaria.fieldbyname('sitt_cstme').AsString
         else
           result:=TSittributaria.fieldbyname('sitt_cst').AsString;
      end else begin
         result:='000';
// 08.02.18
         if (codsittrib>0) and ( mens='') then
           Avisoerro('N�o encontrado sit. tribut�ria '+inttostr(codsittrib)+' codigo '+codigoestoque);  // 22.07.05
      end;
      FGeral.FechaQuery(TSittributaria);
    end;
// 24.08.05
{
    if (Tipomov=Global.CodConsigMercantil) and (tipomov<>'') and ( pos(simples,'S;2')=0 ) then
      result:='000'
    else if (Tipomov=Global.CodVendaConsigMercantil) and (tipomov<>'') and ( pos(simples,'S;2')=0 ) then
      result:='000'
    else if (Tipomov=Global.CodVendaAmbulante) and (tipomov<>'') and ( pos(simples,'S;2')=0 ) then
      result:='000'
}
// 07.10.05
{
    else if (Tipomov=Global.CodVendaMostruario) and (tipomov<>'') and ( pos(simples,'S;2')=0 ) then
      result:='000'
// 17.08.06 - retirado em 01.10.19 - cst com cbenef
//    else if (Tipomov=Global.CodRemessaConserto) and (tipomov<>'') and ( pos(simples,'S;2')=0 ) then
//      result:='050'
// 11.03.10 - Novi - Vava
    else if (Tipomov=Global.CodDevolucaoCompraProdutor) and ( pos(simples,'S;2')=0 ) then
      result:='051'
// 07.07.11 - Clessi - para nao ter que mudar no cadastro do estoque
    else if ( Global.Topicos[1350] ) and ( pos(Tipomov,TiposDevolucao)>0 ) then
      result:='000'
// 26.05.06 - Valmir // 06.05.11 - valmir
    else if ( pos( Tipomov,Global.TiposNaoCalcIcms ) >0 )  and ( pos(simples,'S;2')=0 ) then
//      result:='041';
// 30.04.10 - Leila - Itacir/Feninx
      result:='040';
}
// 01.09.05 - retirado em 26.07.18 - em avalia��o
    {
    if (codigo>0) and (UF<>Arq.TUnidades.fieldbyname('unid_uf').AsString) and (revenda<>'R') and
       ( pos(uf,global.UfComSubstituicao)>0 ) and ( pos(simples,'S;2')=0 )
       then begin
        QTipo:=sqltoquery('select clie_tipo,clie_rgie from clientes where clie_codigo='+inttostr(codigo));
        if not QTipo.eof then begin
          if (QTipo.fieldbyname('clie_tipo').asstring='F') then begin
            if Arq.TSittributaria.Locate('sitt_codigo',codsittribestado,[]) then
              result:=Arq.TSittributaria.fieldbyname('sitt_cst').AsString;;
          end else if(QTipo.fieldbyname('clie_tipo').asstring='J') then begin
            if (QTipo.fieldbyname('clie_rgie').asstring='') or (Uppercase(QTipo.fieldbyname('clie_rgie').asstring)='ISENTO') then
              if Arq.TSittributaria.Locate('sitt_codigo',codsittribestado,[]) then
                result:=Arq.TSittributaria.fieldbyname('sitt_cst').AsString;
          end;
        end;
        QTipo.close;
        Freeandnil(QTipo);
        }
//    end else if (codigo>0) and (revenda='R')  and ( pos(simples,'S;2')=0 ) then begin  // 01.08.06
//
// 25.07.16                    // consumidor final = 'S'
    if (codigo>0) and (revenda='S')  then begin  // 25.07.16 - Zilmar para NAO CONTRIBUINTE..APENAS USAR O SUBGRUPO

        QSubgrupo:=sqltoquery('select * from subgrupos where sugr_codigo='+TEst.fieldbyname('esto_sugr_codigo').Asstring);
        if not QSubgrupo.eof then begin
           if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
              codsittrib:=QSubgrupo.fieldbyname('sugr_sitt_codestado').asinteger
           else
              codsittrib:=QSubgrupo.fieldbyname('sugr_sitt_forestado').asinteger;
           if codsittrib>0 then begin  // 25.07.16 - caso noa tiver configurado nao faz nada
             if Arq.TSittributaria.Locate('sitt_codigo',codsittrib,[]) then begin
  // 25.07.16
               if pos(simples,'S;2')>0 then
                  result:=Arq.TSittributaria.fieldbyname('sitt_cstme').AsString
               else
                 result:=Arq.TSittributaria.fieldbyname('sitt_cst').AsString;
             end;
           end;
        end;
        FGeral.Fechaquery(QSubgrupo);
// 06.11.15 - especifico para devolucao de compra
    end else if ( pos(tipomov,Global.codDevolucaoCompra+';'+Global.CodDevolucaoTributada)>0)  and (subgrupodevcompra>0)  then begin

        QSubgrupo:=sqltoquery('select * from subgrupos where sugr_codigo='+inttostr(subgrupodevcompra));
        if not QSubgrupo.eof then begin
           if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
              codsittrib:=QSubgrupo.fieldbyname('sugr_sitt_codestado').asinteger
           else
              codsittrib:=QSubgrupo.fieldbyname('sugr_sitt_forestado').asinteger;
           if Arq.TSittributaria.Locate('sitt_codigo',codsittrib,[]) then
             result:=Arq.TSittributaria.fieldbyname('sitt_cst').AsString;
        end;
        FGeral.Fechaquery(QSubgrupo);
// 10.06.19
           if codsittrib>0 then begin
             if Arq.TSittributaria.Locate('sitt_codigo',codsittrib,[]) then begin
               if pos(simples,'S;2')>0 then
                  result:=Arq.TSittributaria.fieldbyname('sitt_cstme').AsString
               else
                 result:=Arq.TSittributaria.fieldbyname('sitt_cst').AsString;
             end;
           end;

// 01.05.18 - especifico para remessa a venda ambulante e do simples
// 09.05.18 - retirado pois a receita nao autorizou.
//    end else if (Tipomov=Global.CodConsigMercantil) and (tipomov<>'') and ( pos(simples,'S;2')>0 ) then begin
//
//       result:='900'

    end;

    QBusca.close;
    Freeandnil(QBusca);
  end else begin

    if mens='' then

      Avisoerro('Codigo ['+codigoestoque+'] n�o encontrado no estoque (Situa��o Tribut�ria)');

  end;

end;

///////////////////////////////////////////////////////////////////////////////
function TFEstoque.GetCodigoFiscal(codigoestoque, unidade, UF: string ;xrevenda:string='N'; Tipomov:string='VD'): string;
////////////////////////////////////////////////////////////////////////////////////////////
var codigofiscal,
    devolucoes:string;
    QBusca,TEstoque,QSubg:TSqlquery;

begin

//  if not Arq.TEstoque.active then Arq.TEstoque.open;
  TEstoque:=sqltoquery('select * from estoque where esto_codigo='+Stringtosql(codigoestoque));
  if not Arq.TEstoqueqtde.active then Arq.TEstoqueqtde.open;
  if not Arq.TCodigosFiscais.active then Arq.TCodigosFiscais.open;
  if not Arq.TUnidades.active then Arq.TUnidades.open;
  Arq.TUnidades.locate('unid_codigo',unidade,[]);
  result:='';
  if not TEstoque.eof then begin

    QBusca:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Codigoestoque,Unidade));
    if not QBusca.Eof then begin
      if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
        codigofiscal:=QBusca.FieldByName('esqt_cfis_codigoest').asstring
      else
        codigofiscal:=QBusca.FieldByName('esqt_cfis_codigoforaest').asstring;
      result:=codigofiscal;
// 14.03.16 caso nao encontrar no estoqueqtde devido a problemas no banco de dados...fama...
    end else begin
      codigofiscal:=FUnidades.GetFiscalDentro(Global.CodigoUnidade);
    end;
// 02.07.18 - para produtos com e sem ST cfe o cliente - Siccare
// 18.06.2021 - Devolucoes com ST - Devereda

     Devolucoes := Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada+';'+
                  Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoVenda;
    if (xrevenda='S') or ( AnsiPos(Tipomov,Devolucoes)>0 ) then begin

        QSubg:=sqltoquery('select * from subgrupos where sugr_codigo = '+TEstoque.fieldbyname('esto_sugr_codigo').asstring);
        if not QSubg.eof then begin

          if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
            codigofiscal:=Qsubg.FieldByName('Sugr_cfis_codigoest').asstring
          else
            codigofiscal:=Qsubg.FieldByName('Sugr_cfis_codigoforaest').asstring;
            result:=codigofiscal;

        end;


    end;

    QBusca.close;
    Freeandnil(QBusca);

  end;
  FGeral.FechaQuery(TEstoque);

end;

procedure TFEstoque.bDadosgradeClick(Sender: TObject);
begin
//  if not PEdits.Visible then exit;
//  if OP='I' then begin
// 08.08.11
  if PEdits.Visible then begin
    Avisoerro('N�o permitido durante a inclus�o/altera��o do produto');
    exit;
  end;
  if EdEsto_codigo.IsEmpty  then begin
    Avisoerro('N�o permitido com o campo codigo vazio');
    exit;
  end;
//  if EdEsto_grad_codigo.AsInteger>0 then begin
//    EdEsto_grad_codigo.ValidFind;
    FDadosGrade.Showmodal;
//  end;
end;

function TFEstoque.GetPerBaseComissao(produto, unidade: string): currency;
begin
/////////  if not Arq.TEstoque.active then Arq.TEstoque.open;
  if not Arq.TEstoqueqtde.active then Arq.TEstoqueqtde.open;
  result:=0;
  if Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([Unidade,produto]),[]) then begin
    if Arq.TEstoqueqtde.fieldbyname('esqt_basecomissao').ascurrency>0 then
      result:=Arq.TEstoqueqtde.fieldbyname('esqt_basecomissao').ascurrency
    else if Arq.TEstoqueqtde.fieldbyname('esqt_basecomissao').ascurrency=0 then
      result:=100
    else
      result:=0;
  end;
end;

procedure TFEstoque.Edesto_qtdemaximoValidate(Sender: TObject);
begin
 if EdEsto_qtdeminimo.AsCurrency>EdEsto_qtdemaximo.AsCurrency then
   EdEsto_qtdemaximo.Invalid('Quantidade m�xima inv�lida');
end;

function TFEstoque.GetUnidade(codigo: string): string;
var Q:Tsqlquery;
begin
  Result:='';
{
  if Trim(Codigo)<>'' then begin
    if not Arq.TEstoque.Active then begin
      Arq.TEstoque.Open;
      if Arq.TEstoque.Locate('esto_codigo',Codigo,[]) then Result:=Arq.TEstoque.FieldByName('Esto_Unidade').AsString;
    end else if Arq.TEstoque.FieldByName('Esto_codigo').AsString=codigo then
      Result:=Arq.TEstoque.FieldByName('Esto_Unidade').AsString
    else if Arq.TEstoque.FieldByName('Esto_codigo').AsString=codigo then begin
      if Arq.TEstoque.Locate('esto_codigo',Codigo,[]) then Result:=Arq.TEstoque.FieldByName('Esto_Unidade').AsString;
    end;
  end;
}
// refeito em 08.02.08 devido a unidade do produto no registro 75 do validapr
  Q:=sqltoquery('select esto_unidade from estoque where esto_codigo='+stringtosql(codigo));
  if not Q.eof then
    result:=Q.FieldByName('Esto_Unidade').AsString;
  FGeral.FechaQuery(Q);

end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TFEstoque.GetCodigosituacaotributaria(codigoestoque, unidade,  UF: string ;
                    xcooperado:string='N' ; codigo:integer=0 ; xtipomov:string='@@' ): integer;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var QBusca,TEstoque,Qsubg:Tsqlquery;
    codsittrib,
    subgrupodevcompra:integer;

    function GetsemIE(xcod:integer):boolean;
    /////////////////////////////////////////////
    var QC1:TSqlQuery;
    begin
      Qc1:=sqltoquery('select clie_tipo,clie_rgie from clientes where clie_codigo='+inttostr(codigo));
      result:=false;
      if not Qc1.eof then begin

         if Qc1.fieldbyname('clie_tipo').AsString ='F' then result:=true
         else if Qc1.fieldbyname('clie_rgie').AsString='' then result:=true;

      end;
      FGeral.FechaQuery(Qc1);
    end;

begin
// 09.05.16
//  if not Arq.TEstoque.active then Arq.TEstoque.open;
  if not Arq.TSittributaria.active then Arq.TSittributaria.open;
  if not Arq.TUnidades.active then Arq.TUnidades.open;
  Arq.TUnidades.locate('unid_codigo',unidade,[]);
// 01.02.2021
  subgrupodevcompra:=FGeral.Getconfig1asinteger('subgrupodevcom');

  result:=0;
  TEstoque:=sqltoquery('select * from estoque where esto_codigo = '+Stringtosql(codigoestoque));
  if not TEstoque.eof then begin

// 18.03.2022
    if subgrupodevcompra = 0 then

      subgrupodevcompra:=TEstoque.fieldbyname('esto_sugr_codigo').AsInteger;

    QBusca:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Codigoestoque,Unidade));
    if not QBusca.Eof then begin
      if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
        codsittrib:=QBusca.FieldByName('esqt_sitt_codestado').asinteger
      else
        codsittrib:=QBusca.FieldByName('esqt_sitt_forestado').asinteger;
      result:=codsittrib;
// 10.03.15
      if Global.Topicos[1226] then begin
        if xcooperado='S' then begin
          if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
            codsittrib:=QBusca.FieldByName('Esqt_sitt_codestadonc').asinteger
          else
            codsittrib:=QBusca.FieldByName('Esqt_sitt_forestadonc').asinteger;
          result:=codsittrib;
        end;
      end;
// 02.07.18 - Siccare - mesmo produto ora com ora sem ST
      if ( not Global.Topicos[1226] ) and  (xcooperado='S') then begin
        QSubg:=sqltoquery('select * from subgrupos where sugr_codigo = '+TEstoque.fieldbyname('esto_sugr_codigo').asstring);
        if not QSubg.eof then begin

          if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
            codsittrib:=Qsubg.FieldByName('Sugr_sitt_codestado').asinteger
          else
            codsittrib:=Qsubg.FieldByName('Sugr_sitt_forestado').asinteger;
          result:=codsittrib;

        end;
        FGeral.FechaQuery(Qsubg);
      end;
// 01.02.2021
      if Ansipos( xtipomov , Global.CodDevolucaoCompra+';'+Global.CodDevolucaoSimbolicaConsig+';'+
                  Global.CodDevolucaoTributada ) > 0
      then begin

// 18.03.2022 - pra ficar independente do q t� nas configuracoes
          QSubg:=sqltoquery('select * from subgrupos where sugr_codigo='+inttostr(subgrupodevcompra));
          if not QSubg.eof then begin
               if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
                  codsittrib:=QSubg.fieldbyname('Sugr_sitt_codestado').asinteger
               else
                  codsittrib:=QSubg.fieldbyname('Sugr_sitt_forestado').asinteger;
              result:=codsittrib;

          end;
          FGeral.FechaQuery(Qsubg);

      end;

    end;
    QBusca.Close;
    Freeandnil(QBusca);
// 04.10.19
    if (Global.Topicos[1461]) and ( FGeral.GetConfig1AsInteger('subgrupovendasemIE') > 0 )
         and ( GetSemIE(codigo) ) and ( AnsiPos(xtipomov,Global.TiposSaida)>0 )
         then begin
         codsittrib:=FSubgrupos.GetCodigosituacaotributaria(if_s(uf=Global.UFUnidade,'5102','6102'),FGeral.GetConfig1AsInteger('subgrupovendasemIE') );
         result:=codsittrib;

    end;

  end;
  FGeral.FechaQuery(TEstoque);
end;

procedure TFEstoque.bimpcodbarraClick(Sender: TObject);

var qtde:integer;
    sqtde,vtermica,l,i,cor,tamanho:string;
    MatEtiqueta:TStringlist;
    a,nporta,nativa,nbaudrate,nstopbits,ndatabits,nparity,x,seconds,tempo,p,linha,coluna:integer;
    Arquivo:TextFile;
    Q:TSqlquery;
    {
    PortaSerial : array [1..4] of string;
    Baudrate : array [1..5] of TBaudRAte;
    Parity   : array [1..5] of TParity;
    Stopbits : array [1..3] of TStopbits;
    Databits : array [1..5] of TDatabits;
    }
    linguagemimpressora,CI,CF,comando:string;

var Buffer:array[1..1024] of char; s:integer;  ss:string;

begin

  if Arq.TEstoque.isempty then exit;
  if not Arq.TEstoqueqtde.active then Arq.TEstoqueqtde.open;

//  aviso('Op��o em desenvolvimento');
//exit;

  Input('Digite a quantidade de etiqueta(s)','Impress�o etq. cod barra',sqtde,4,false);
  if (trim(sqtde)='')  then exit;
  try
    qtde:=strtointdef(sqtde,0);
  except
    avisoerro('Quantidade informada de forma errada');
    exit;
  end;
///////////////////////////////////////////////////////////////
    if Global.Topicos[1237] then begin

        AcbrNFe1.DANFE := TACBrNFeDANFCeFortesETQEST.Create(AcbrNFe1);

        AcbrNfe1.DANFE.TipoDANFE := tiNFCE;
        if Global.usuario.outrosacessos[0510] then
          acbrnfe1.danfe.MostraPreview:=true
        else begin
          acbrnfe1.danfe.MostraPreview:=false;
          Pd.Execute();
//          then acbrnfe1.DANFE.Impressora:
        end;
    {
        acbrnfe1.danfe.MargemEsquerda:=10;
        acbrnfe1.danfe.MargemDireita:=0;
        acbrnfe1.danfe.MargemSuperior:=0 ;
        acbrnfe1.danfe.MargemInferior:=0;
    }
        ACBrNfe1.NotasFiscais.Clear;
        with  Acbrnfe1.NotasFiscais.add.NFe do begin

           Emit.CNPJCPF := Arq.TEstoque.FieldByName('esto_descricao').AsString;
           Emit.xNome   := FGeral.Formatavalor( FEstoque.GetPreco(Arq.TEstoque.FieldByName('esto_codigo').AsString,Global.CodigoUnidade),f_cr);
           with  Det.Add do
           begin

                Prod.qCom    := Arq.TEstoque.fieldbyname('esto_peso').asfloat;
                Prod.qTrib   := Arq.TEstoque.fieldbyname('esto_peso').asfloat;

          end;

        end;

        if ACBrNFe1.NotasFiscais.Count=0 then avisoerro('componente acbr ficou vazio');

        ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[0].NFe ) ;

        exit  ;

     end;
/// ////////////////////////////////////////////////////////////

  if Global.Topicos[1213] then begin
    FImpressao.ImprimeEtqProduto('select * from estoque where esto_codigo='+Stringtosql(Arq.Testoque.fieldbyname('esto_codigo').asstring),strtoint(sqtde),1);
//    FImpressao.ImprimeEtqProduto('select * from estoque where esto_codigo='+Stringtosql(Arq.Testoque.fieldbyname('esto_codigo').asstring),strtoint(sqtde),2);
    exit;
// 08.11.11
  end else if Global.Topicos[1216] then begin
    FImpressao.ImprimeEtqProduto('select * from estoque where esto_codigo='+Stringtosql(Arq.Testoque.fieldbyname('esto_codigo').asstring),strtoint(sqtde),1,'ACBR');
    exit;
  end;

  MatEtiqueta:=TStringList.Create;
  if FileExists('etqbarra.txt') then MatEtiqueta.LoadFromFile('etqbarra.txt')
  else begin
    Avisoerro('N�o encontrado o arquivo etqbarra.txt');
    exit;
  end;
{
  ComPort:=Comport.Create(Application);
  PortaSerial[1]:='Com1';PortaSerial[2]:='Com2';PortaSerial[3]:='Com3';PortaSerial[4]:='Com4';
  BaudRate[1]:=cbr2400;BaudRate[2]:=cbr4800;BaudRate[3]:=cbr9600;BaudRate[4]:=cbr14400;BaudRate[5]:=cbr19200;
  Parity[1]:=paNone;Parity[2]:=paOdd;Parity[3]:=paEven;Parity[4]:=paMark;Parity[5]:=paSpace;
  Stopbits[1]:=sb10;Stopbits[2]:=sb15;Stopbits[3]:=sb20;
  Databits[1]:=da8;Databits[2]:=da5;Databits[3]:=da7;Databits[4]:=da6;Databits[5]:=da4;

  nPorta:=Inteiro(GetIni('Toke','Sac','T-Porta'));
  nBaudRate:=Inteiro(GetIni('Toke','Sac','T-BaudRate'));
  nParity:=Inteiro(GetIni('Toke','Sac','T-Parity'));
  nStopBits:=Inteiro(GetIni('Toke','Sac','T-StopBits'));
  nDataBits:=Inteiro(GetIni('Toke','Sac','T-DataBits'));
  nAtiva:=Inteiro(GetIni('Toke','Sac','T-Ativa'));

   if nAtiva = 1 then begin
      ComPort.Close;
      ComPort.DeviceName	 := PortaSerial[nPorta+1];
		Try
         Try
	         ComPort.Open;
         Except
         end;
	         ComPort.Close;
      Except
         Aviso('N�o foi poss�vel abrir a impressora na porta '+ComPort.DeviceName);
         exit;
      end;
   end;
}

	If GetIni('SACD','EtiquetaEstoque','Termica')<>''  then vTermica := GetIni('SACD','EtiquetaEstoque','Termica');
//	else vTermica := ComPort.DeviceName;

  seconds := 5 ;   // rever
  tempo:=Seconds+3;
  linguagemimpressora:=FGeral.GetConfig1AsString('MODELOIMPETQ') ;
  CI:='';CF:='';
  if linguagemimpressora='EPL2' then begin
    CI:='"';
    CF:='"';
  end;


     AssignFile(Arquivo,'Impetq.txt');
     Rewrite(Arquivo);
     for x:=1 to qtde do begin
       for a:=0 to MatEtiqueta.Count-1 do begin
           l:=MatEtiqueta.Strings[a];
           p:=Pos('Codigo',l);
           if p>0 then begin
              l:=Copy(l,1,p-1)+CI+Arq.Testoque.fieldbyname('esto_codigo').asstring+CF;
           end;
           p:=Pos('Descricao',l);
           if p>0 then begin
              l:=Copy(l,1,p-1)+CI+Uppercase(Arq.Testoque.fieldbyname('esto_descricao').asstring)+CF;
           end;
           if (Arq.TEstoque.fieldbyname('esto_grad_codigo').asinteger>0) and
              (Arq.Testoque.fieldbyname('esto_codbarra').asstring<>'') then begin
              Q:=sqltoquery('select * from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(Arq.Testoque.fieldbyname('esto_codigo').asstring)+
                ' and esgr_unid_codigo='+Stringtosql(global.CodigoUnidade)+' and esgr_codbarra='+stringtosql(Arq.Testoque.fieldbyname('esto_codbarra').asstring) );
             if not Q.eof then begin
               Cor:=FCores.GetDescricao(Q.fieldbyname('esgr_core_codigo').asinteger);
               Tamanho:=FTamanhos.GetDescricao(Q.fieldbyname('esgr_tama_codigo').asinteger);
               p:=Pos('Cor',l);
               if p>0 then l:=Copy(l,1,p-1)+CI+Uppercase( Cor )+CF;
               p:=Pos('Tamanho',l);
               if p>0 then l:=Copy(l,1,p-1)+CI+Uppercase( Tamanho )+CF;
             end;
             Freeandnil(Q);
           end;
           p:=Pos('Codbarra',l);
           if p>0 then l:=Copy(l,1,p-1)+CI+Arq.Testoque.fieldbyname('esto_codbarra').asstring+CF;
           i:=i+l+#13+#10;
       end;
       Writeln(Arquivo,i);
     end;
     CloseFile(Arquivo);
     MatEtiqueta.free;

//    ComPort.Close;
//    Freeandnil(ComPort);
  // 24.01.12
    if (Global.Usuario.OutrosAcessos[0055]) and ( trim( FGeral.GetConfig1AsString('Caminhocodbarra') )<>'' ) then begin
      vtermica:='lpt1';
//      comando:='net use lpt1 '+
//               '\\'+FGeral.GetConfig1AsString('Caminhocodbarra' )+
//               '\'+FGeral.GetConfig1AsString('Caminhocodbarra1' );
//      WinExec(pchar( comando ),SW_SHOWMINIMIZED);
    end else begin
      if trim( FGeral.GetConfig1AsString('Caminhocodbarra') )='' then
  //      vtermica:='\\localhost\generico'
  // 24.01.12
        vtermica:='lpt1'
      else
        vtermica:='\\'+FGeral.GetConfig1AsString('Caminhocodbarra' )+'\'+FGeral.GetConfig1AsString('Caminhocodbarra1' );
    end;
		Try
{ - teste em 19.07.19 para usar os arquivos prn gerados pelo programa de cada impressora zebra ou argox
//    SEMPRE USANDO FONTES DA ZEBRA ou VER SE TEM COM INCLUIR FONTES NA IMPRESSORA
       MatEtiqueta:=TStringList.create;
       MatEtiqueta.LoadFromFile('TesteNovi.Prn');
	     Rewrite(Arquivo);
       Write(Arquivo,MatEtiqueta.gettext);
}
	     AssignFile(Arquivo,vTermica);
	     Rewrite(Arquivo);
	     Write(Arquivo,i);
//       Write(Arquivo,MatEtiqueta.gettext);
	     CloseFile(Arquivo);
//	     Delay(1000);
//  	     WinExec(pchar('c:\imprime.bat '),SW_SHOWMINIMIZED);
     except
       Aviso('Problemas na impress�o');
     end;
//     if Global.Usuario.OutrosAcessos[0055] then begin
//       comando:='net use lpt1 /d';
//       WinExec(pchar( comando ),SW_SHOWMINIMIZED);
//     end;

end;

function TFEstoque.TrazQtde(linha, coluna: integer): currency;
var p:integer;
    qtde:currency;
begin
  qtde:=0;
  for p:=0 to ListaQtde.count-1 do begin
    PListaQtde:=ListaQtde[p];
    if (Plistaqtde.linha=linha) and (Plistaqtde.coluna=coluna) then begin
      qtde:=PListaqtde.qtde;
      break;
    end;
  end;
  result:=qtde;
end;


procedure TFEstoque.EdqtdeprevKeyPress(Sender: TObject; var Key: Char);
begin
   FGeral.Limpaedit(Edqtdeprev,key);

end;

procedure TFEstoque.EdqtdeprevValidate(Sender: TObject);
begin
  if EdQTdeprev.AsFloat >= 0 then
    ColocaQtde(GridGrade.Row,GridGrade.Col,EdQTdeprev.AsFloat);
  EdQtdeprev.Enabled:=false;
  EdQtdeprev.Visible:=false;
  PEdits.Visible:=true;
  Gridgrade.SetFocus;

end;

procedure TFEstoque.ColocaQtde(linha, coluna: integer;qtde:extended);
var p:integer;
    achou:boolean;
begin
  achou:=false;
  for p:=0 to ListaQtde.count-1 do begin
    PListaQtde:=ListaQtde[p];
    if (Plistaqtde.linha=linha) and (Plistaqtde.coluna=coluna) then begin
      PListaqtde.qtde:=qtde;
      achou:=true;
      break;
    end;
  end;
  if not achou then begin
    if Global.Usuario.OutrosAcessos[0010] then begin
      New(PListaqtde);
      PListaqtde.linha:=linha;
      PListaqtde.coluna:=coluna;
      PListaqtde.qtde:=qtde;
      ListaQtde.Add(PListaqtde);
    end;
  end;
end;

function TFEstoque.GetAliquotaIcmsEstado(UFcliente,Tipo: string ;Es:string='S'): currency;
/////////////////////////////////////////////////////////////////////////////////////////////
begin
  if Es='S' then begin
    if Tipo='J' then begin
      if pos(uppercase(ufcliente),FGeral.Getconfig1asstring('ICMSUF01'))>0 then
        result:=FGeral.Getconfig1asfloat('ICMS01')
      else if pos(uppercase(ufcliente),FGeral.Getconfig1asstring('ICMSUF02'))>0 then
        result:=FGeral.Getconfig1asfloat('ICMS02')
      else if pos(uppercase(ufcliente),FGeral.Getconfig1asstring('ICMSUF03'))>0 then
        result:=FGeral.Getconfig1asfloat('ICMS03')
      else
        result:=FGeral.Getconfig1asfloat('ICMS04');
    end else begin
      result:=FGeral.Getconfig1asfloat('ICMSFISICA');
    end;
  end else begin  // 29.07.08
      if pos(uppercase(ufcliente),FGeral.Getconfig1asstring('ICMSUF01E'))>0 then
        result:=FGeral.Getconfig1asfloat('ICMS01e')
      else
        result:=0;
  end;

end;

function TFEstoque.GetSqlCustos(Produto, Unidade: string ; tamanho:integer=0;cor:integer=0): string;
begin
  if not Arq.TEstoque.active then  begin
     Arq.TEstoque.open;
     Arq.TEstoque.locate('esto_codigo',produto,[]);
  end;
//  if Arq.TEstoque.fieldbyname('esto_grad_codigo').asinteger=0 then
//  if (tamanho=0) and ( cor=0 ) then
// 27.07.06  - retirado ate implantar a grade q dar� o custo por tamanho cor e COPA...
    result:='select esqt_custo as custo,esqt_custoger as custoger,esqt_customedio as customedio,esqt_customeger as customeger from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(produto)+
                ' and esqt_unid_codigo='+Stringtosql(Unidade)
//  else
//    result:='select esgr_custo as custo,esgr_custoger as custoger,esgr_customedio as customedio,esgr_customeger as customeger from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(produto)+
//                ' and esgr_unid_codigo='+Stringtosql(Unidade)+' and esgr_tama_codigo='+inttostr(tamanho)+
//                ' and esgr_core_codigo='+inttostr(cor);

end;



procedure TFEstoque.EdVendaClick(Sender: TObject);
begin
   EdVenda.enabled:=false;
   EdVenda.Visible:=false;
   EdCompra.enabled:=false;
   EdCompra.Visible:=false;
   EdMargembruta.Visible:=false;
   PVenda.enabled:=false;
   PVenda.Visible:=false;
   if atuvenda then begin
     if confirma('Confirma novo pre�o de venda ? ') then begin

       sistema.edit('estoqueqtde');
       sistema.setfield('esqt_vendavis',EdVenda.ascurrency);
// 06.12.13
       if not global.Usuario.OutrosAcessos[0056] then
         sistema.post('esqt_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and esqt_status=''N'' and esqt_esto_codigo='+EdEsto_codigo.assql)
       else
         sistema.post(FGeral.GetIN('esqt_unid_codigo',Global.Usuario.UnidadesMvto,'C')
                      +' and esqt_status=''N'' and esqt_esto_codigo='+EdEsto_codigo.assql);
       sistema.commit;

     end;

   end;
   Pbotoes.Enabled:=true;
   Grid.enabled:=true;
   atuvenda:=false;
   Grid.setfocus;
end;

procedure TFEstoque.EdVendaKeyPress(Sender: TObject; var Key: Char);
begin
   if (key=#13) or (key=#27) then
     EdVendaclick(FEstoque);
end;

function TFEstoque.GetGrupo(codigo: string): integer;
///////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Result:=0;
  if Trim(Codigo)<>'' then begin
    Q:=sqltoquery('select esto_grup_codigo from estoque where esto_codigo='+stringtosql(codigo));
    if not Q.eof then
      Result:=Q.FieldByName('esto_grup_codigo').AsInteger;
    FGeral.Fechaquery(Q);
  end;

end;

function TFEstoque.GetCusto(Produto, Unidade, tipo: string): currency;
////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    custo:currency;
begin
  custo:=0;
  Q:=sqltoquery('select esqt_customedio,esqt_custoger,esqt_custo,esqt_customeger,esqt_customedioser,esqt_custoser from EstoqueQtde'+
                ' where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Produto)+
                ' and esqt_unid_codigo='+Stringtosql(Unidade));
// 28.03.14
  if Q.eof then begin
    if Global.topicos[1362] then begin
       FGeral.FechaQuery(Q);
       Q:=sqltoquery('select esqt_customedio,esqt_custoger,esqt_custo,esqt_customeger,esqt_customedioser,esqt_custoser from EstoqueQtde'+
                     ' where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Produto)+
                     ' and esqt_unid_codigo='+Stringtosql('002'));
     end;
  end;
  if not Q.eof then begin
    if tipo='medio' then                                // 02.04.08
      custo:=Q.fieldbyname('esqt_customedio').AsCurrency+Q.fieldbyname('esqt_customedioser').AsCurrency
// 01.09.09 - Abra - Josemar
    else if tipo='mediocustosemser' then begin
      if Q.fieldbyname('esqt_customedio').AsCurrency<=Q.fieldbyname('esqt_custo').AsCurrency then
        custo:=Q.fieldbyname('esqt_customedio').AsCurrency
      else
        custo:=Q.fieldbyname('esqt_custo').AsCurrency;
    end else  if tipo='custo' then
      custo:=Q.fieldbyname('esqt_custo').AsCurrency+Q.fieldbyname('esqt_custoser').AsCurrency
    else if tipo='medioger' then
      custo:=Q.fieldbyname('esqt_customeger').AsCurrency+Q.fieldbyname('esqt_customedioser').AsCurrency
    else
      custo:=Q.fieldbyname('esqt_custoger').AsCurrency+Q.fieldbyname('esqt_custoser').AsCurrency;
  end;
  Q.Close;
  Freeandnil(Q);
  result:=custo;
end;

// 20.10.17
function TFEstoque.GetCustoOrigem(codigo: string): string;
////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
   Q:=sqltoquery('select cust_esto_codigo from custos '+
                 'where cust_esto_codigomat = '+Stringtosql(codigo));
   if not Q.Eof then result:=Q.FieldByName('cust_esto_codigo').AsString else result:='';
   FGeral.Fechaquery(Q);

end;

procedure TFEstoque.EdEsto_codigoValidate(Sender: TObject);
begin
  if OP='I' then begin
{ 04.06.07 - colocar a funcao no cadastro de unidades e ativar os campos no cadastro de unidades
    EdEsto_sitt_codestado.setvalue(GetSittDentro(Global.CodigoUnidade));
    EdEsto_sitt_forestado.setvalue(GetSittFora(Global.CodigoUnidade));
    EdEsto_cfis_codigoest.text:=GetFiscalDentro(Global.CodigoUnidade);
    EdEsto_cfis_codigoforaest.text:=GetFiscalFora(Global.CodigoUnidade);
}
  end;
end;

procedure TFEstoque.EdEsto_sitt_codestadoValidate(Sender: TObject);
begin
//   if not FSittributaria.ValidaCodCst(global.CodigoUnidade,Edesto_sitt_codestado.asinteger) then
//     Edesto_sitt_codestado.invalid('Codigo de situa��o tribut�ria inv�lido para unidade '+global.CodigoUnidade);
// 22.02.11
   if not ValidaCodCst(EdEsto_sitt_codestado.asinteger,'S') then
     Edesto_sitt_codestado.invalid('Codigo de situa��o tribut�ria inv�lido para nota de saida');
end;

procedure TFEstoque.EdcustogerencialExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////
begin

   if confirma('Gravar os custos ? ') then begin
     Arq.TEstoque.edit;
     Arq.TEstoque.fieldbyname('esto_custozeroc').ascurrency:=Edcustofiscal.ascurrency;
     Arq.TEstoque.fieldbyname('esto_custozerog').ascurrency:=Edcustogerencial.ascurrency;
     Arq.TEstoque.post;
     Arq.TEstoque.commit;
   end;

   PCustoZerado.enabled:=false;
   PCustoZerado.Visible:=false;
   EdCustofiscal.enabled:=false;
   EdCustofiscal.Visible:=false;
   EdCustogerencial.enabled:=false;
   EdCustogerencial.Visible:=false;

   Pbotoes.Enabled:=true;
   Grid.enabled:=true;
   Grid.setfocus;
end;

function TFEstoque.GetCustoZerado(Produto, tipo: string): currency;
/////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    custo:currency;
begin
  custo:=0;
  Q:=sqltoquery('select esto_custozeroc,esto_custozerog from Estoque where esto_codigo='+StringtoSql(Produto));
  if not Q.eof then begin
    if tipo='C' then
      custo:=Q.fieldbyname('esto_custozeroc').AsCurrency
    else
      custo:=Q.fieldbyname('esto_custozerog').AsCurrency;
  end;
  Q.Close;
  Freeandnil(Q);
  result:=custo;
end;


// 27.08.19
procedure TFEstoque.bativosClick(Sender: TObject);
///////////////////////////////////////////////////////
begin

   if Arq.TEstoque.Active then Arq.TEstoque.Close;

   if bativos.Tag = 0 then begin

      Arq.TEstoque.OpenWith('esto_emlinha = ''S''',Arq.TEstoque.Ordenacao);
      bativos.Tag :=1;
      bativos.Caption :='Todos';
      bativos.Hint    :='Mostra todos os produtos do estoque';

   end else begin

      Arq.TEstoque.OpenWith(FGEral.GetIN('esto_emlinha','S;N','C'),Arq.TEstoque.Ordenacao);
      bativos.Tag :=0;
      bativos.Caption :='Ativos';
      bativos.Hint    :='Mostra somente os produtos em linha';

   end;

   Grid.Refresh;

end;

procedure TFEstoque.batuvendaClick(Sender: TObject);
begin
  atuvenda:=Global.Usuario.OutrosAcessos[0033];
  if EdEsto_codigo.isempty then exit;
//  if not Global.Usuario.OutrosAcessos[0033] then begin
//
//    Avisoerro('Usu�rio sem permiss�o para atualizar pre�o de venda');
//    exit;
//    podealterar:='N';
//  end;
//  if podealterar='S' then begin
    PVenda.enabled:=true;
    EdVenda.enabled:=true;
// 08.02.11 - Bavi
    EdCompra.enabled:=true;
    Pbotoes.Enabled:=false;
//  end else begin
//    PVenda.enabled:=false;
//    EdVenda.Color:=clWindow;
//    EdVenda.enabled:=false;
// 08.02.11 - Bavi
//    EdCompra.enabled:=false;
//    Pbotoes.Enabled:=true;
//  end;
  PVenda.Visible:=true;
  EdVenda.Visible:=true;
  EdCompra.Visible:=true;
  EdMargembruta.Visible:=true;
  EdVenda.setvalue(FEstoque.GetPreco(EdEsto_codigo.text,global.codigounidade));
//  EdVenda.SetFocus;
   EdCompra.setvalue( Edesto_precocompra.ascurrency );
   EdCompra.setfocus;
// 01.02.12
  if EdVenda.AsCurrency > 0 then
    EdMargemBruta.setvalue( (1 - (EdCompra.ascurrency/EdVenda.ascurrency))*100 )
  else
    EdMargemBruta.setvalue( 0 );
  EdSaldo.Visible:=true;
  if Global.Usuario.OutrosAcessos[0010] then
     EdSaldo.setvalue(EdEsto_qtdeprev.asFloat)
  else
     EdSaldo.setvalue(EdEsto_qtde.asfloat);

end;

function TFEstoque.GetFamilia(codigo: string): integer;
begin
  Result:=0;
  if Trim(Codigo)<>'' then begin
    if not Arq.TEstoque.Active then Arq.TEstoque.Open;
    if Arq.TEstoque.Locate('esto_codigo',Codigo,[]) then Result:=Arq.TEstoque.FieldByName('esto_fami_codigo').AsInteger;
  end;

end;

function TFEstoque.GetSubGrupo(codigo: string): integer;
////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Result:=0;
  if Trim(Codigo)<>'' then begin
    Q:=sqltoquery('select esto_sugr_codigo from estoque where esto_codigo='+stringtosql(codigo));
    if not Q.eof then
      Result:=Q.FieldByName('esto_sugr_codigo').AsInteger;
    FGeral.Fechaquery(Q);
  end;
end;

function TFEstoque.GetTolerancia(codigo: string): currency;
////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
    Result:=0;
    if Trim(Codigo)<>'' then begin
//     Q:=sqltoquery('select esto_taraperc from estoque where esto_codigo='+stringtosql(codigo));
     Q:=sqltoquery('select esto_grup_codigo from estoque where esto_codigo='+stringtosql(codigo));
// 10.01.20
     if not Q.eof then
//       result:=Q.FieldByName('Esto_taraperc').AsCurrency;
// 17.12.19 - criar campo no cadastro de grupos
// 10.01.20
         result:=FGrupos.GetTolerancia(Q.FieldByName('esto_grup_codigo').AsInteger );
     FGeral.FechaQuery(Q);
    end;

end;

function TFEstoque.ValidaCodigoProduto(Ed: TSqled=nil ; produto:string=''): boolean;
begin
  result:=true;
  if Ed<>nil then begin
    if pos(',',Ed.text)>0 then begin
       Ed.Invalid('Codigo com caracter inv�lido');
       result:=false;
    end else if pos(';',Ed.text)>0 then begin
       Ed.Invalid('Codigo com caracter inv�lido');
       result:=false;
//    end else if pos('.',Ed.text)>0 then begin
//       Ed.Invalid('Codigo com caracter inv�lido');
//       result:=false;
// 30.08.10 - retirado - 'codigos Bavi'
    end;
  end else begin
    if pos(',',produto)>0 then begin
      Avisoerro('Codigo com caracter inv�lido');
      result:=false;
    end;
  end;

end;


procedure TFEstoque.EdEsto_sisvendasValidte(Sender: TObject);
begin
   if not EdEsto_sisvendas.isempty then
      Setedsisvendas.text:=copy(EdEsto_sisvendas.Items.Strings[EdEsto_sisvendas.ItemIndex] ,5,14)
   else
      Setedsisvendas.text:='';
end;

function TFEstoque.GetSistemaVendas(Produto, Unidade: string): string;
begin
  Result:='';
  if Trim(Produto)<>'' then begin
    if not Arq.TEstoque.Active then Arq.TEstoque.Open;
    if Arq.TEstoque.Locate('esto_codigo',Produto,[]) then Result:=Arq.TEstoque.FieldByName('Esto_Sisvendas').AsString;
  end;
end;

// 08.08.19
procedure TFEstoque.EdEqui_codigoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////
begin

   if not EdEqui_codigo.IsEmpty then begin

     if not Arq.TEstoque.Active then Arq.TEstoque.Open;

     if confirma('Confirma equipamento ? ') then begin

       Arq.TEstoque.Edit;
       Arq.TEstoque.FieldByName('esto_equi_codigo').asstring:=EdEqui_codigo.Text;
       Arq.TEstoque.Post;
       Arq.TEstoque.Commit;

{
       sistema.edit('estoque');
       sistema.setfield('esto_equi_codigo',EdEqui_codigo.Text);
       sistema.post('esto_codigo = '+EdEsto_codigo.assql);
       sistema.commit;
       }
     end;

   end;

   EdEqui_codigo.enabled:=false;
   EdEqui_codigo.Visible:=false;
   PEquipamento.enabled:=false;
   PEquipamento.Visible:=false;
   Pbotoes.Enabled:=true;
   Grid.enabled:=true;
   Grid.setfocus;

end;

procedure TFEstoque.EdEsto_categoriaValidate(Sender: TObject);
begin
   if not EdEsto_categoria.isempty then
      SetedEsto_categoria.text:=copy(EdEsto_categoria.Items.Strings[EdEsto_categoria.ItemIndex] ,5,14)
   else
      SetedEsto_categoria.text:='';

end;

function TFEstoque.GetCF(codigoestoque, unidade, UF: string): string;
var QBusca,QSittrib:Tsqlquery;
    codsittrib:integer;
    cf:string;
begin
  if not Arq.TEstoque.active then Arq.TEstoque.open;
  if not Arq.TSittributaria.active then Arq.TSittributaria.open;
  if not Arq.TUnidades.active then Arq.TUnidades.open;
  Arq.TUnidades.locate('unid_codigo',unidade,[]);
  result:='';
  if Arq.TEstoque.Locate('esto_codigo',codigoestoque,[]) then begin
    QBusca:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Codigoestoque,Unidade));
    if not QBusca.Eof then begin
      if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
        codsittrib:=QBusca.FieldByName('esqt_sitt_codestado').asinteger
      else
        codsittrib:=QBusca.FieldByName('esqt_sitt_forestado').asinteger;
/////////////////      Arq.TSittributaria.locate('sitt_codigo',inttostr(codsittrib),[]);
      QSittrib:=sqltoquery('select sitt_cf from sittrib where sitt_codigo='+inttostr(codsittrib));
      if not QSittrib.eof then begin
        cf:=QSittrib.FieldByName('sitt_cf').asstring;
        result:=cf;
      end;
      FGeral.fechaquery(QSittrib);
    end;
    QBusca.Close;
    Freeandnil(QBusca)
  end;
end;

procedure TFEstoque.SetaItems(Edit, EditNomeForne: TSqlEd; ForneValidos,
  Nomevalido: String);
begin
  Edit.Items.Clear;
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  Arq.TEstoque.BeginProcess;
  Arq.TEstoque.First;
  while not Arq.TEstoque.Eof do begin
    if ((ForneValidos='') or (Pos(strzero(Arq.TEstoque.FieldByName('Esto_Codigo').AsInteger,7),ForneValidos)>0))
       and ((NomeValido='') or (Pos(Uppercase(NomeValido),Uppercase(Arq.TEstoque.FieldByName('Esto_Descricao').AsString))>0))
      then begin
//       Edit.Items.Add(Strzero(Arq.TEstoque.FieldByName('Esto_Codigo').AsInteger,7)+' - '+strspace(Arq.TEstoque.FieldByName('Esto_Descricao').AsString,30)+
//                      ' - '+Arq.TEstoque.FieldByName('Esto_Descricao').AsString);
       Edit.Items.Add(strspace(Arq.TEstoque.FieldByName('Esto_Codigo').Asstring,7)+' - '+strspace(Arq.TEstoque.FieldByName('Esto_Descricao').AsString,30)+
                      ' - '+Arq.TEstoque.FieldByName('Esto_Descricao').AsString);
    end;
    Arq.TEstoque.Next;
  end;
  Arq.TEstoque.EndProcess;
  if Edit.Items.Count=1 then begin
     Edit.Text:=LeftStr(Edit.Items[0],3);
     if EditNomeForne<>nil then EditNomeForne.Text:=FinalStr(Edit.Items[0],7);
  end;

end;

// 03.10.18
procedure TFEstoque.SetaItemsporGrupo(Ed: TSqled; xgrupo: integer);
///////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

    Q:=sqltoquery('select esto_codigo,esto_descricao from estoque '+
                  ' where esto_grup_codigo = '+inttostr(xgrupo)+
                  ' order by esto_descricao');
    if not Q.Eof then begin
       Ed.Items.Clear;
       while not Q.Eof do begin
           Ed.Items.Add(strspace(Q.FieldByName('esto_codigo').AsString,6)+
                        '  -  '+Q.FieldByName('esto_descricao').AsString );
           Q.Next;
       end;
    end;
    FGeral.FechaQuery(Q);

end;

function TFEstoque.Getaliquotaipi(codigoestoque: string ; incideipi:string='S' ; TipoMov:string=''): currency;
////////////////////////////////////////////////////////////////////////////////////////////////////
var QBusca,QIPI:Tsqlquery;
begin
  result:=0;
  QBusca:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(codigoestoque));
  if not QBusca.Eof then begin

    if QBusca.fieldbyname('esto_cipi_codigo').asinteger>0 then begin
      QIpi:=sqltoquery('select * from codigosipi where cipi_codigo='+QBusca.fieldbyname('esto_cipi_codigo').asstring);
      if not QIPI.eof then
        result:=QIPI.fieldbyname('cipi_aliquota').ascurrency;
      FGeral.Fechaquery(QIPI);
    end;
    FGeral.Fechaquery(QBusca);
// 19.03.10 - Asatec - Fernanda
    if ( pos( Tipomov,Global.TiposNaoCalcIpi ) >0 ) and ( Global.Topicos[1342] ) then
        result:=0
// 23.10.12 - Clessi
    else if ( pos( Tipomov,Global.TiposNaoCalcIpi ) >0 ) and ( not Global.Topicos[1342] ) then
        result:=0;
    if incideipi='N' then   // caso o cliente for 'isento de ipi'
      result:=0             // cliente tem prioridade sobre o tipo de movimento
// 10.09.19 -  Para n�o calcular ipi nas vendas de empresas do simples mesmo
//             q tiver a aliquota no ncm
    else if AnsiPos( FUnidades.GetSimples( Global.CodigoUnidade ), 'S/2') > 0 then
       result:=0;


  end else

    Avisoerro('Codigo '+codigoestoque+' n�o encontrado no estoque (Al�quota Ipi)');

end;

procedure TFEstoque.bduplicarClick(Sender: TObject);
var unidade:string;
    Q,QUni:TSqlquery;
begin
  if Pedits.visible then exit;
  if not Input('Digita��o de unidade','Unidade para cadastro',unidade,3,false) then exit;
  if unidade=Global.CodigoUnidade then begin
    Avisoerro('Unidade para duplicar n�o pode ser a atual');
    exit;
  end;
  Q:=sqltoquery('select unid_codigo from unidades where unid_codigo='+stringtosql(unidade));
  if Q.eof then begin
    Avisoerro('Unidade '+unidade+' n�o encontrada');
    Q.close;
    exit;
  end else begin
    if pos( unidade,Global.Usuario.UnidadesMvto )=0 then begin
      Avisoerro('Usu�rio sem permiss�o para acessar a unidade '+unidade);
      Q.close;
      exit;
    end;
    FGeral.Fechaquery(Q);
    Q:=sqltoquery('select esqt_esto_codigo from estoqueqtde where esqt_unid_codigo='+stringtosql(unidade)+
                  ' and esqt_status=''N'' and esqt_esto_codigo='+EdEsto_codigo.assql);
    if not Q.eof then begin
      Avisoerro('Produto '+EdEsto_codigo.text+' j� cadastrado na unidade '+unidade);
      Q.close;
      exit;
    end;
    if confirma('Confirma duplica��o do item para unidade '+unidade) then begin

      Sistema.Insert('Estoqueqtde');
      Sistema.Setfield('esqt_status','N');
      Sistema.Setfield('esqt_unid_codigo',Unidade);
      Sistema.Setfield('esqt_esto_codigo',EdEsto_codigo.Text);
//      Sistema.Setfield('esqt_qtde',EdEsto_qtde.AsFloat);
//      Sistema.Setfield('esqt_qtdeprev',FGeral.QualQtde(Global.Usuario.codigo,EdEsto_qtde.AsFloat,EdEsto_qtdeprev.AsFloat));
      Sistema.Setfield('esqt_qtde',0);
      Sistema.Setfield('esqt_qtdeprev',0);
      Sistema.Setfield('esqt_vendavis',EdEsto_vendavis.AsCurrency);
      Sistema.Setfield('esqt_custo',EdEsto_custo.AsCurrency);
      Sistema.Setfield('esqt_custoger',EdEsto_custoger.AsCurrency);
      Sistema.Setfield('esqt_customedio',EdEsto_customedio.AsCurrency);
      Sistema.Setfield('esqt_customeger',EdEsto_customeger.AsCurrency);
      Sistema.Setfield('esqt_dtultvenda',EdEsto_dtultvenda.AsDate);
      Sistema.Setfield('esqt_dtultcompra',EdEsto_dtultcompra.AsDate);
      Sistema.Setfield('esqt_desconto',EdEsto_desconto.AsCurrency);
      Sistema.Setfield('esqt_basecomissao',EdEsto_basecomissao.AsCurrency);
// 28.03.12- busca na unidade pra ver se tem configuracao de cst e % de icms
      QUni:=sqltoquery('select * from unidades where unid_codigo='+stringtosql(unidade));
// 14.03.13 - SM - leilinha - quando os jamantinhas deixam sem preencher
      if trim( QUni.fieldbyname('unid_cfis_codigoest').AsString ) <> ''  then begin
        if (QUni.fieldbyname('unid_cfis_codigoest').Ascurrency+QUni.fieldbyname('unid_sitt_codestado').AsInteger) >0  then begin
          Sistema.Setfield('esqt_cfis_codigoest',QUni.fieldbyname('unid_cfis_codigoest').Ascurrency);
          Sistema.Setfield('esqt_cfis_codigoforaest',QUni.fieldbyname('unid_cfis_codigoforaest').Ascurrency);
          Sistema.Setfield('esqt_sitt_codestado',QUni.fieldbyname('unid_sitt_codestado').AsInteger);
          Sistema.Setfield('esqt_sitt_forestado',QUni.fieldbyname('unid_sitt_forestado').AsInteger);
        end else begin
          Sistema.Setfield('esqt_cfis_codigoest',EdEsto_cfis_codigoest.Ascurrency);
          Sistema.Setfield('esqt_cfis_codigoforaest',EdEsto_cfis_codigoforaest.AsCurrency);
          Sistema.Setfield('esqt_sitt_codestado',EdEsto_sitt_codestado.AsInteger);
          Sistema.Setfield('esqt_sitt_forestado',EdEsto_sitt_forestado.AsInteger);
        end;
      end else begin
          Sistema.Setfield('esqt_cfis_codigoest',EdEsto_cfis_codigoest.Ascurrency);
          Sistema.Setfield('esqt_cfis_codigoforaest',EdEsto_cfis_codigoforaest.AsCurrency);
          Sistema.Setfield('esqt_sitt_codestado',EdEsto_sitt_codestado.AsInteger);
          Sistema.Setfield('esqt_sitt_forestado',EdEsto_sitt_forestado.AsInteger);
      end;
      FGeral.FechaQuery(QUni);
      Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
      Sistema.Setfield('esqt_pecas',0);
      Sistema.Post();
// 09.07.20 - Guiber com produtos configurado errados na unidade 002
      FGeral.Gravalog(37,'Codigo = '+EdEsto_codigo.Text+' Unidade a criar '+Unidade,false);

      try
        sistema.commit;
        Aviso('Duplica��o efetuada');
      except
        Avisoerro('Problemas na duplica��o');
      end;
    end;
    Q.close;
  end;
end;

procedure TFEstoque.EdEsto_VendaminValidate(Sender: TObject);
begin
   if ( EdEsto_vendamin.ascurrency>0 ) and ( EdEsto_vendavis.ascurrency>0 ) then begin
     if EdEsto_vendamin.ascurrency>EdEsto_vendavis.ascurrency then
       EdEsto_vendamin.invalid('Pre�o de venda m�nimo tem que ser menor que preo�o a vista');
   end;
end;

// 22.05.07
function TFEstoque.ValidaPrecoVenda(Produto, Unidade: string;  Venda: currency; usuario: integer): boolean;
////////////////////////////////////////////////////////////////////////////////////////////////
var Q,Qusuario:TSqlquery;
begin

  Q:=sqltoquery('select esqt_vendamin from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Produto)+
                ' and esqt_unid_codigo='+Stringtosql(Unidade));
  if not Q.eof then begin

    if Q.fieldbyname('esqt_vendamin').ascurrency>0 then begin

      if venda<Q.fieldbyname('esqt_vendamin').ascurrency then begin
//        if not Global.Usuario.OutrosAcessos[0301] then begin
// 17.10.08
        QUsuario:=sqltoquery('select Usua_OutrosAcessos from usuarios where usua_codigo='+inttostr(usuario));
        if copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,301,1)<>'S' then begin
           if copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,314,1)<>'S' then
             Avisoerro('Usu�rio sem permiss�o para faturamento abaixo do pre�o m�nimo.  Solicitar autoriza��o depois prosseguir!');
           QUsuario:=sqltoquery('select Usua_OutrosAcessos from usuarios where usua_codigo='+inttostr(usuario));
           if not QUsuario.eof then begin
             if copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,314,1)='S' then begin
               result:=true;
               Sistema.Edit('usuarios');
//               Sistema.SetField('Usua_OutrosAcessos',copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,1,300)+'N'+
//                                 copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,302,4000));
               Sistema.SetField('Usua_OutrosAcessos',copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,1,313)+' '+
                                 copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,315,4000-315));
               Sistema.Post('usua_codigo='+inttostr(usuario));
               sistema.Commit;
               FGeral.GravaLog(14,'Produto '+produto+' venda m�nima '+floattostr(Q.fieldbyname('esqt_vendamin').ascurrency)+' pre�o praticado '+floattostr(venda));
             end else begin
               result:=false;
               Avisoerro('Usu�rio Ainda sem permiss�o para faturamento abaixo do pre�o m�nimo');
             end;
           end else
             result:=false;

        end else begin
// 30.07.08 - 'rastrear' vendas abaixo do minimo 'sem autorizacao'
          FGeral.GravaLog(99,inttostr(usuario)+' com permiss�o. '+produto+' venda m�nima '+floattostr(Q.fieldbyname('esqt_vendamin').ascurrency)+' pre�o praticado '+floattostr(venda));
          result:=true;
        end;
      end else
        result:=true;  // 03.07.07
    end else begin

      result:=true;
// 07.07.2021 - Pato Embalagens
      if (Global.Usuario.OutrosAcessos[0068]) and ( venda>0 ) then begin

         Sistema.Edit('estoqueqtde');
         sistema.setfield('esqt_vendavis',Venda);
         Sistema.post('esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Produto)+
                      ' and esqt_unid_codigo='+Stringtosql(Unidade));
         Sistema.commit;

      end;


    end;

  end else

    result:=true;

  FGeral.FechaQuery(Q);

end;

// 06.01.2021
function TFEstoque.ValidaTributacaoProduto(Produto,uf,tipomov: string): boolean;
////////////////////////////////////////////////////////////////////////
var qE            :TSqlquery;
    codigofiscal,
    ieST          :string;
    aliicms       :currency;

begin

   result  := true;
   aliicms := 0;
   ieST    := '';

// se for do simples...
   if ( Ansipos( FUnidades.GetSimples(Global.codigounidade),'S;2') > 0 )
      and
      (  Ansipos( tipomov,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoTributada+';'+
                  Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoInd+';'+
                  Global.CodDevolucaoCompraSemEstoque+';'+Global.CodPrestacaoSErvicos ) = 0 )
      then begin

      QE:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+Stringtosql(Produto)+
                     ' and esqt_unid_codigo='+Stringtosql(Global.codigounidade));
      if not QE.eof then begin

         if UF = Global.UfUnidade then codigofiscal := QE.fieldbyname('esqt_cfis_codigoest').asstring
                                  else codigofiscal := QE.fieldbyname('esqt_cfis_codigoforaest').asstring;

         aliicms := FCodigosFiscais.GetAliquota( codigofiscal );
// 23.09.2021 - Vando - Sicare   - assi nao d� certo pois no produto n�o tem % pra ST ver como tratar..
         ieST := FUnidades.GetieST(Global.codigounidade);

         if ( aliicms > 0 ) and ( trim(ieST)='' )  then begin

            Avisoerro('Produto '+produto+' com icms = '+currtostr(aliicms)+' %.  Alterar para 0 para pode us�-lo');
            result := false;

         end;
      end;

      FGeral.FechaQuery( QE );

   end;

end;

function TFEstoque.GetProximoCodigo(tabela, campo,tipocampo: string; tamvariavel:boolean=false): variant;
/////////////////////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    tam:integer;
    ListaCodigos:TStringList;
    versaobanco:integer;

begin

  tam:=FGeral.GetConfig1AsInteger('TAMESTOQUE');

  if (tamvariavel) or ( Global.Topicos[1236]) then begin
    ListaCodigos:=tStringList.create;
    Q:=sqltoquery('select esto_codigo from estoque');
    if tam=0 then tam:=7;
// 24.03.16
    if Q.Eof then begin
       result:=strzero(1,tam);
       exit;
    end;
    while not Q.eof do begin
      ListaCodigos.add( strzero(strtointdef(Q.fieldbyname('esto_codigo').asstring,0),tam) );
      Q.Next;
    end;
    FGeral.FechaQuery(Q);
    ListaCodigos.Sort;
    result:=strtointdef(ListaCodigos[Listacodigos.count-1],0)+1;

  end else begin

    Q:=sqltoquery('select count(*) as quantos from '+tabela);
    if Q.fieldbyname('quantos').asinteger=0 then begin

      if tabela<>'estoque' then
        result:=1
      else
        result:=strzero(1,tam);

    end else begin

      FGeral.FechaQuery(Q);
// 09.11.17  - 29.08.18 - post 9.3 em diante nao tem funcao substr...
// 21.09.18 - refeito de outra forma sen�o pega codigo errado na novicarnes
      if tam=0 then begin

        Q:=sqltoquery('select max('+campo+') as ultimo from '+tabela);

// 16.09.2021
//      else

//        Q:=sqltoquery('select max( cast('+campo+' as integer ) ) as ultimo from '+tabela+
//                      ' where substr('+campo+','+inttostr(tam+1)+',1 ) = ''''' );
// 29.09.18
      end else if Global.VersaoBanco >= 90300 then

        Q:=sqltoquery('select max( cast('+campo+' as integer ) ) as ultimo from '+tabela)

      else
// 25.09.18
           Q:=sqltoquery('select max( cast('+campo+' as integer ) ) as ultimo from '+tabela+
                      ' where '+campo+' ~ ''[-0-9]'' and length('+campo+') = '+inttostr(tam) );

      if tipocampo='C' then begin

        if strtointdef(Q.FieldByName('ultimo').AsString,0) > 0 then

           result:=strtoint(Q.FieldByName('ultimo').AsString)+1

        else

           result := FGeral.GetContador('CadEstoque',false,true);

      end else

        result:=Q.FieldByName('ultimo').AsInteger+1;

      if tabela<>'estoque' then
       tam:=0;
      if tipocampo='C' then begin
        if tam>0 then
          result:=strzero(result,tam)
        else
          result:=strzero(result,8);
      end;

    end;
    FGeral.FechaQuery(Q);
  end;
end;

procedure TFEstoque.blocalizaClick(Sender: TObject);
////////////////////////////////////////////////////////
begin
   if EdEsto_codigo.isempty then exit;
   PLocaliza.enabled:=true;
   PLocaliza.Visible:=true;
   Edlocalizacao.enabled:=true;
   Edlocalizacao.Visible:=true;
   EdPontoRessu.enabled:=true;
   EdPontoRessu.Visible:=true;
   EdCompminimo.enabled:=true;
   EdCompminimo.Visible:=true;
   Pbotoes.Enabled:=false;
   EdQtdeprocesso.enabled:=true;
   EdQtdeprocesso.Visible:=true;
   EdCompminimo.setfocus;

end;

procedure TFEstoque.EdlocalizacaoExitEdit(Sender: TObject);
begin
   if confirma('Confirma grava��o  ? ') then begin
     Sistema.Edit('estoqueqtde');
     Sistema.setfield('esqt_localiza',Edlocalizacao.text);
// 29.04.09
     Sistema.setfield('esqt_ressuprimento',EdPontoRessu.asfloat);
// 16.10.09
     campo:=Sistema.GetDicionario('estoqueqtde','esqt_qtdeprocesso');
     if campo.Tipo<>'' then
       Sistema.setfield('esqt_qtdeprocesso',EdQtdeprocesso.asfloat);
     Sistema.post('esqt_esto_codigo='+EdEsto_codigo.assql+' and esqt_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                 ' and esqt_status=''N''');
     Sistema.commit;
{
     Sistema.Edit('estoque');
     Sistema.setfield('esto_compminimo',EdCompminimo.asfloat);
     Sistema.post('esto_codigo='+EdEsto_codigo.assql);
     Sistema.commit;
}
     Arq.TEstoque.Edit;
     Arq.TEstoque.FieldByName('esto_compminimo').asfloat:=EdCompminimo.asfloat;
     Arq.TEstoque.post;
     Arq.TEstoque.Commit;
   end;
   PLocaliza.enabled:=false;
   PLocaliza.Visible:=false;
   Edlocalizacao.enabled:=false;
   Edlocalizacao.Visible:=false;
   EdCompminimo.enabled:=false;
   EdCompminimo.Visible:=false;
   EdPontoRessu.enabled:=false;
   EdPontoRessu.Visible:=false;
   EdQtdeprocesso.enabled:=false;
   EdQtdeprocesso.Visible:=false;

   Pbotoes.Enabled:=true;
   Grid.enabled:=true;
   Grid.setfocus;

end;



function TFEstoque.GetQtdeEmEstoque(unidade, codigo: string; codcor,  codtamanho: integer): currency;
///////////////////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqlcor,sqltamanho:string;
begin
  result:=0;
  if (codcor+codtamanho)=0 then begin
    Q:=sqltoquery('select esqt_qtde,esqt_qtdeprev from estoqueqtde where esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Unidade)+
                ' and esqt_esto_codigo='+stringtosql(codigo));
    if not Q.eof then begin
      if Global.Usuario.OutrosAcessos[0010] then
        result:=Q.fieldbyname('esqt_qtdeprev').ascurrency
      else
        result:=Q.fieldbyname('esqt_qtde').ascurrency;
    end;
    FGeral.FechaQuery(Q);
  end else begin
    if codcor>0 then
      sqlcor:=' and esgr_core_codigo='+inttostr(codcor)
    else
      sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
    if codtamanho>0 then
      sqltamanho:=' and esgr_tama_codigo='+inttostr(codtamanho)
    else
      sqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';

    Q:=sqltoquery('select esgr_qtde,esgr_qtdeprev from estgrades where esgr_status=''N'' and esgr_unid_codigo='+stringtosql(Unidade)+
                ' and esgr_esto_codigo='+stringtosql(codigo)+sqlcor+sqltamanho);
    if not Q.eof then begin
      if Global.Usuario.OutrosAcessos[0010] then
        result:=Q.fieldbyname('esgr_qtdeprev').ascurrency
      else
        result:=Q.fieldbyname('esgr_qtde').ascurrency;
    end;
    FGeral.FechaQuery(Q);
  end;
end;

//////////////////////////// 21.05.08
function TFEstoque.GetQtdeEmEstoqueComprimento(unidade, codigo: string; var xcodtamanho:integer;codcor:integer=0;
         comprimento:extended=0 ; variacao:currency=50): currency;
var sqlcor:string;
   comprimentomaior,maxvariacao:extended;
begin
    if codcor>0 then
      sqlcor:=' and esgr_core_codigo='+inttostr(codcor)
    else
      sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';

    Q:=sqltoquery('select esgr_qtde,esgr_qtdeprev,esgr_tama_codigo from estgrades where esgr_status=''N'' and esgr_unid_codigo='+stringtosql(Unidade)+
                ' and esgr_esto_codigo='+stringtosql(codigo)+sqlcor);
    maxvariacao:= comprimento + ( comprimento*(variacao/100));
    result:=0;
    while not Q.eof do begin
      comprimentomaior:=FTamanhos.GetComprimento(Q.fieldbyname('esgr_tama_codigo').AsInteger);
// por enquanto acha o primeiro pedaco maior e cai fora
      if (comprimentomaior>comprimento) and (comprimentomaior<maxvariacao) then begin
        if Global.Usuario.OutrosAcessos[0010] then
          result:=Q.fieldbyname('esgr_qtdeprev').ascurrency
        else
          result:=Q.fieldbyname('esgr_qtde').ascurrency;
        if result>0 then
          xcodtamanho:=Q.fieldbyname('esgr_tama_codigo').AsInteger;
        break;
      end;
      Q.Next;
    end;
    FGeral.FechaQuery(Q);

end;

function TFEstoque.GetNCMipi(codigoestoque: string): string;
////////////////////////////////////////////////////////////////////////
var QBusca,QIPI:Tsqlquery;
begin
  result:='';
  QBusca:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(codigoestoque));
  if not QBusca.Eof then begin
    if QBusca.fieldbyname('esto_cipi_codigo').asinteger>0 then begin
      QIpi:=sqltoquery('select * from codigosipi where cipi_codigo='+QBusca.fieldbyname('esto_cipi_codigo').asstring);
      if not QIPI.eof then
        result:=QIPI.fieldbyname('Cipi_codfiscal').asstring;
      FGeral.Fechaquery(QIPI);
    end;
    FGeral.Fechaquery(QBusca);
  end else
    Avisoerro('Codigo '+codigoestoque+' n�o encontrado no estoque (NcmIpi)' );
end;

function TFEstoque.ValidaComprimentoMinimo(produto: string ; comp:extended): boolean;
////////////////////////////////////////////////////////////////////////////////////////////
var QBusca:Tsqlquery;
begin
  result:=true;
  QBusca:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(produto));
  if not QBusca.Eof then begin
      if comp<QBusca.FieldByName('esto_compminimo').asfloat then begin
        Avisoerro('Comprimento m�nimo para aproveitamento � '+QBusca.FieldByName('esto_compminimo').asstring);
        result:=false;
      end;
  end;
  FGeral.FechaQuery(QBusca);

end;

// 21.04.09
function TFEstoque.ImpQualCodigo(codigo, referencia: string): string;
begin
  if Global.Topicos[1209] then begin
    if trim(referencia)<>'' then
      result:=referencia
    else
      result:=codigo;
  end else
    result:=codigo;

end;

function TFEstoque.CalculaMarkup(custo, xmarkup: extended;codgrupo:integer=0): extended;

begin
   if (xmarkup>0) then
       result:=custo/(xmarkup/100)
   else
     result:=custo;
end;

function TFEstoque.GetPrecodeCompra(codigoestoque:string): extended;
var QBusca:Tsqlquery;
begin
  result:=0;
  QBusca:=sqltoquery('select esto_precocompra from estoque where esto_codigo='+stringtosql(codigoestoque));
  if not QBusca.Eof then begin
     result:=QBusca.fieldbyname('esto_precocompra').ascurrency
  end else
    Avisoerro('Codigo '+codigoestoque+' n�o encontrado no estoque');
  FGeral.FechaQuery(QBusca);
end;

function TFEstoque.CalculaMargem(custo, margem: extended;  codgrupo: integer): extended;

    function GetMarkUp(custo:extended):extended;
    var Q:TSqlquery;
    begin
      result:=0;
      Q:=sqltoquery('select * from grupos where grup_faixacustoi>=0 and grup_faixacustof>0');
      while not Q.eof do begin
        if ( custo>=Q.fieldbyname('grup_faixacustoi').ascurrency ) and
           ( custo<=Q.fieldbyname('grup_faixacustof').ascurrency ) then
            result:=Q.fieldbyname('grup_margem').ascurrency;
        Q.Next;
      end;
      FGeral.FechaQuery(Q);
    end;

begin
   if ( codgrupo=FGEral.GetConfig1AsInteger('Grupocompon') ) and
      ( FGEral.GetConfig1AsInteger('Grupocompon')>0 ) then
     margem:=GetMarkup(custo);
   result:=custo + custo*(margem/100);
end;

// 16.09.09
function TFEstoque.GetaliquotaIss(codigoestoque, unidade, UF: string): currency;
var QBusca,TCodigosFiscais:Tsqlquery;
    codigofis:string;

begin
  if not Arq.TEstoque.active then Arq.TEstoque.open;
//  if not Arq.TCodigosFiscais.active then Arq.TCodigosFiscais.open;
  if not Arq.TUnidades.active then Arq.TUnidades.open;
  Arq.TUnidades.Locate('unid_codigo',unidade,[]);
  result:=0;
  if Arq.TEstoque.Locate('esto_codigo',codigoestoque,[]) then begin
    QBusca:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Codigoestoque,Unidade));
    if not QBusca.Eof then begin
      if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then begin
        codigofis:=QBusca.FieldByName('esqt_cfis_codigoest').asstring;
      end else
        codigofis:=QBusca.FieldByName('esqt_cfis_codigoforaest').asstring;
      TCodigosFiscais:=sqltoquery('select * from codigosfis where cfis_codigo='+stringtosql(codigofis));
      if not TCodigosFiscais.eof then
         result:=TCodigosFiscais.fieldbyname('cfis_aliquota').AsCurrency;
      FGeral.FechaQuery(TCodigosFiscais);
    end;
  end;
end;

function TFEstoque.GetReferencia(codigo: string): string;
var Q:TSqlquery;
begin
  Result:=Codigo+' N�o encontrado no estoque geral';
  if Trim(Codigo)<>'' then begin
   Q:=sqltoquery('select esto_referencia from estoque where esto_codigo='+stringtosql(codigo));
   if not Q.eof then
     result:=Q.FieldByName('Esto_referencia').AsString;
   FGeral.FechaQuery(Q);
  end;

end;

function TFEstoque.GetReferenciaouCodigo(codigo: string): string;
////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  if Global.Topicos[1209] then begin
    Result:='N�o encontrado no estoque geral';
    if Trim(Codigo)<>'' then begin
     Q:=sqltoquery('select esto_referencia from estoque where esto_codigo='+stringtosql(codigo));
     if not Q.eof then
       result:=Q.FieldByName('Esto_referencia').AsString;
     FGeral.FechaQuery(Q);
     if trim(result)='' then result:=Codigo;
    end;
  end else
    result:=codigo;

end;

function TFEstoque.GetPeso(codigo: string): currency;
var Q:TSqlquery;
begin
    Result:=0;
    if Trim(Codigo)<>'' then begin
     Q:=sqltoquery('select esto_peso from estoque where esto_codigo='+stringtosql(codigo));
     if not Q.eof then
       result:=Q.FieldByName('Esto_peso').AsCurrency;
     FGeral.FechaQuery(Q);
    end;
end;

procedure TFEstoque.babrirClick(Sender: TObject);
begin
   if not opd.Execute then exit;
   if not FileExists(opd.FileName) then begin
     Avisoerro('Arquivo '+opd.FileName+' n�o encontrado');
     exit;
   end;
   Image1.Picture.LoadFromFile(opd.filename);
end;

procedure TFEstoque.balteracampoClick(Sender: TObject);
begin
    Grid.Edit;
end;

procedure TFEstoque.bfechaimagemClick(Sender: TObject);
begin
   PFigura.Close;
end;

procedure TFEstoque.bimagemClick(Sender: TObject);
////////////////////////////////////////////////////////
var Str    :TMemoryStream;
    arquivo:string;
    Bmp    :TBitMap;
    Q1     :TSqlQuery;

begin
//{
  pfigura.Visible:=true;
  pfigura.Enabled:=true;
  pfigura.BringToFront;
  Str:=TMemoryStream.Create;
  Image1.Picture:=nil;
  FEstoque.EdEsto_Codigo.GetFields(FEstoque,99);

//  LoadBlob('estoque','esto_imagem','esto_codigo='+FEstoque.EdEsto_codigo.AsSql,Str);
  arquivo:='LoadImagem'+inttostr(global.Usuario.codigo)+'.jpg';

//  Image1.Assign( BitmapFromBase64(Arq.TEstoque.fieldbyname('esto_imagem').asstring) );
  Q1 := sqltoquery('select esto_imagem from estoque where esto_codigo = '+EdEsto_codigo.assql );

  Bmp := TBitMap.Create;
  Bmp.Assign( BitmapFromBase64( HextoString(Q1.fieldbyname('esto_imagem').asstring) ) );
  Bmp.SaveToFile( arquivo );
  Image1.Picture.BitMap.LoadFromFile( Arquivo  );
  FGeral.FechaQuery( Q1 );

  if Str.Size>1 then begin

    Str.SaveToFile(arquivo);
//    if EdEsto_codigo.text='047' then
//      Image1.Picture.Bitmap.LoadFromStream(str)
//    else
    Image1.Picture.LoadFromFile(arquivo);
    Deletefile(arquivo);

  end;

  Str.Free;
//}
end;

procedure TFEstoque.bgravaimagemClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var Str    :TMemoryStream;
    arquivo:string;
    ArquivoBmp,
    bmpDest    : TBitmap;
    ArquivoJpg : TJPEGImage;
    ss         : AnsiString;


    procedure Bmp2Jpeg(const BmpFileName, JpgFileName: string);
    ///////////////////////////////////////////////////////////////
    var
      Bmp: TBitmap;
      Jpg: TJPEGImage;
    begin
      Bmp := TBitmap.Create;
      Jpg := TJPEGImage.Create;
      try
        Bmp.LoadFromFile(BmpFileName);
        Jpg.Assign(Bmp);
        Jpg.SaveToFile(JpgFileName);
      finally
        Jpg.Free;
        Bmp.Free;
      end;
    end;

    procedure Jpeg2Bmp(const BmpFileName, JpgFileName: string);
    /////////////////////////////////////////////////////////////////
    var
      Bmp: TBitmap;
      Jpg: TJPEGImage;
    begin

      Bmp := TBitmap.Create;
      Jpg := TJPEGImage.Create;
      try
        Jpg.LoadFromFile(JpgFileName);
        Bmp.Assign(Jpg);
        Bmp.SaveToFile(BmpFileName);
      finally
        Jpg.Free;
        Bmp.Free;
      end;

    end;

    procedure QualityResizeBitmap(bmpOrig, bmpDest: TBitmap; newWidth, newHeight: Integer);
    /////////////////////////////////////////////////////////////////////////////////////////
    var
       xIni, xFin, yIni, yFin, xSalt, ySalt: Double;
       X, Y, pX, pY, tpX: Integer;
       R, G, B: Integer;
       pxColor: TColor;

    begin

       bmpDest.Width  := newWidth;
       bmpDest.Height := newHeight;

       xSalt := bmpOrig.Width / newWidth;
       ySalt := bmpOrig.Height / newHeight;

       yFin := 0;
       for Y := 0 to pred(newHeight) do
       begin
          yIni := yFin;
          yFin := yIni + ySalt;
          if yFin >= bmpOrig.Height then
             yFin := pred(bmpOrig.Height);

          xFin := 0;
          for X := 0 to pred(newWidth) do
          begin
             xIni := xFin;
             xFin := xIni + xSalt;
             if xFin >= bmpOrig.Width then
                xFin := pred(bmpOrig.Width);

             R := 0;
             G := 0;
             B := 0;
             tpX := 0;

             for pY := Round(yIni) to Round(yFin) do
                for pX := Round(xIni) to Round(xFin) do
                begin
                   Inc(tpX);
                   pxColor := ColorToRGB(bmpOrig.Canvas.Pixels[pX, pY]);
                   R := R + GetRValue(pxColor);
                   G := G + GetGValue(pxColor);
                   B := B + GetBValue(pxColor);
                end;

             bmpDest.Canvas.Pixels[X,Y] := RGB(Round(R/tpX),Round(G/tpX),Round(B/tpX));
          end;
       end;
    end;

begin

   if Image1.Picture.Height>0 then begin

     ArquivoBmp := TBitmap.Create;
     BmpDest    := TBitmap.Create;
//     ArquivoBmp.savetofile( 'arquivobmp'+inttostr(global.Usuario.codigo)+'.bmp' );
     Image1.Picture.SaveToFile( 'arquivobmp'+inttostr(global.Usuario.codigo)+'.bmp' );
     ArquivoJpg := TJPEGImage.Create;
     arquivo:='SaveImagem'+inttostr(global.Usuario.codigo)+'.jpg';
     Image1.Picture.SaveToFile(arquivo);


     Jpeg2Bmp( 'arquivobmp'+inttostr(global.Usuario.codigo)+'.bmp',arquivo);
     ArquivoBmp.LoadFromFile('arquivobmp'+inttostr(global.Usuario.codigo)+'.bmp');

     QualityResizeBitmap(Arquivobmp, bmpDest, 100, 100);

     bmpDest.savetofile('arquivobmpmenor'+inttostr(global.Usuario.codigo)+'.bmp');

     Bmp2Jpeg( 'arquivobmpmenor'+inttostr(global.Usuario.codigo)+'.bmp','arquivojpg'+inttostr(global.Usuario.codigo)+'.jpg');
     ArquivoJpg.LoadFromFile('arquivojpg'+inttostr(global.Usuario.codigo)+'.jpg');

     Str := TMemoryStream.Create;
//     Str.LoadFromFile(arquivo);

     Str.LoadFromFile( 'arquivojpg'+inttostr(global.Usuario.codigo)+'.jpg' );

     //SaveBlob('estoque','esto_imagem','esto_codigo='+EdEsto_codigo.AsSql,Str);
{
     Sistema.edit('estoque');
     Sistema.Setfield('esto_imagem', Base64fromBitmap( BmpDest ) );
     Sistema.post('esto_codigo = '+EdEsto_codigo.assql);
     Sistema.commit;
}
    ss := StringtoHex( Base64fromBitmap( BmpDest ) );

    ExecuteSql('update estoque set esto_imagem = '''+ss+''' where esto_codigo = '+EdEsto_codigo.assql+';');

     Str.Free;
     Deletefile(arquivo);
//     Deletefile(arquivojpg);
//     Deletefile(arquivobmp);

   end;
end;

procedure TFEstoque.APHeadLabel1DblClick(Sender: TObject);
begin
   FListaFiguras.show;
end;

function TFEstoque.EstaCadastrado(unidade, produto: string): boolean;
var Q:TSqlquery;
begin
  Result:=false;
  if Trim(produto)<>'' then begin
    Q:=sqltoquery('select esto_codigo from estoque where esto_codigo='+stringtosql(produto));
    if not Q.eof then
      result:=true;
    FGeral.FechaQuery(Q);
  end;
end;

function TFEstoque.Servico(produto,unidade,ufunidade: string): boolean;
var codigofis,tpimposto:string;
begin
  codigofis:=FEstoque.GetCodigoFiscal(produto,Unidade,UFUnidade);
  tpimposto:=FCodigosFiscais.GetQualImposto(codigofis);
  result:=tpimposto='S';
end;


function TFEstoque.GetCodigoCSTipi(codigoestoque: string ; xES:string=''): string;
/////////////////////////////////////////////////////////////////////////////
var QBusca,QIPI:Tsqlquery;
begin
  result:='';
  QBusca:=sqltoquery('select esto_cipi_codigo from estoque where esto_codigo='+stringtosql(codigoestoque));
  if not QBusca.Eof then begin
    if QBusca.fieldbyname('esto_cipi_codigo').asinteger>0 then begin
      QIpi:=sqltoquery('select * from codigosipi where cipi_codigo='+QBusca.fieldbyname('esto_cipi_codigo').asstring);
      if not QIPI.eof then begin
        result:=QIPI.fieldbyname('cipi_cst').asstring;
        if trim(xES)='E' then result:=QIPI.fieldbyname('cipi_cstent').asstring;;
      end;
      FGeral.Fechaquery(QIPI);
    end;
    FGeral.Fechaquery(QBusca);
  end else
    Avisoerro('Codigo '+codigoestoque+' n�o encontrado no estoque ( CSTIPI )');
end;
// 18.06.21
function TFEstoque.GetCodigodeBarra(codigo: string): string;
///////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

  Result:='';
  if Trim(codigo)<>'' then begin

    Q:=sqltoquery('select esto_codbarra from estoque where esto_codigo='+stringtosql(codigo));
    if not Q.eof then

      result := Q.fieldbyname('esto_codbarra').asstring;

    FGeral.FechaQuery(Q);

  end;

end;

function TFEstoque.IsMinuscula(c: string): boolean;
const minusculas:string='abcdefghijklmnopqrstuvxyz';
begin
  result:=pos( c,minusculas ) > 0;
end;

procedure TFEstoque.EdcompraValidate(Sender: TObject);
begin
  if (EdCompra.ascurrency>0) and (EdVenda.ascurrency>0) then begin
    EdMargemBruta.SetValue( ((EdVenda.ascurrency-EdCompra.ascurrency)/EdVenda.ascurrency)*100 );
  end else
    EdMargemBruta.SetValue( 0 );
end;

// 22.02.11
function TFEstoque.ValidaCodCst(codigocst:integer;dentroestado:string): boolean;
////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    cfop:string;
begin
   Q:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr(codigocst) );
   if not Q.eof then begin
    result:=true;
    campo:=Sistema.GetDicionario('sittrib','SITT_ES');
    if campo.Tipo<>'' then begin
      if Q.fieldbyname('SITT_ES').asstring='E' then
        result:=false;
    end;
    campo:=Sistema.GetDicionario('sittrib','sitt_natf_codigo');
    cfop:='';
    if campo.Tipo<>'' then begin
      Q:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr(codigocst) );
      if not Q.eof  then begin
        if dentroestado='S' then
          cfop:=Q.fieldbyname('sitt_natf_codigo').asstring
        else
          cfop:=Q.fieldbyname('sitt_natf_codigofe').asstring;
      end;
      if (trim(cfop)<>'') and ( pos( copy(cfop,1,1),'1;2;3' )>0 ) then
        result:=false;
    end;
   end else begin
     result:=false;
     Avisoerro('Codigo '+inttostr(codigocst)+' de situa��o tribut�ria n�o encontrado');
   end;
   FGERal.FechaQuery(Q);
end;

procedure TFEstoque.EdEsto_sitt_forestadoValidate(Sender: TObject);
begin
// 22.02.11
   if not ValidaCodCst(EdEsto_sitt_forestado.asinteger,'N') then
     Edesto_sitt_forestado.invalid('Codigo de situa��o tribut�ria inv�lido para nota de saida');

end;

procedure TFEstoque.EdEsto_cfis_codigoestValidate(Sender: TObject);
begin
   {
   if (not EdEsto_Cfis_codigoest.IsEmpty)  then begin
     if (OP='I') then
       Edesqt_cfis_codestsemie.text:=EdEsto_Cfis_codigoest.text
     else if Edesqt_cfis_codestsemie.IsEmpty then
       Edesqt_cfis_codestsemie.text:=EdEsto_Cfis_codigoest.text;
   end;
   }
end;

///////////////////////////////////////////////////////////////////////////////
procedure TFEstoque.benviabalancaClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////////////
var nomearqnutri,nomearqitens,linha,qbalanca,linhaitens,nomearqingre,linhaingre,
    nomearqcons,linhacons,nomearqinfext1,linhainfext1,linhacons1,nomearqinfext2:string;
    ArquivoNutri,ArquivoItens,ArquivoIngredientes,ArquivoConservacao,
    ArquivoInfExt1,ArquivoInfExt2:TextFile;
    Q:TSqlquery;
    ListaNutri,ListaIngre,ListaCons,ListaInfExt1,ListaInfExt2:TStringlist;

    function Poezero(v:currency ; tam:integer):string;
    begin
      result:=FGeral.Exportanumeros(v,tam,0)
    end;

    function GetFormato(bal:string):string;
    ///////////////////////////////////////
    var s:string;

        function GetUnidade(uni:string):string;
        ////////////////////////////////////////
        begin
          result:='X';
          if trim(uni)='G' then
            result:='0'
          else if trim(uni)='ML' then
            result:='1'
          else if trim(uni)='UN' then
            result:='2';
        end;

        function Menor1g(valor:currency):string;
        ///////////////////////////////////////
        begin
          result:='0';
          if Valor>0 then result:='1';
        end;


    begin
    //////////
      if bal='TOLEDO' then begin
// CCCCABBBDEEFGGHHHHIIIJLLMNNNOOOPPPQQRSSSTTTTUUUUVVXXZZWWYYKK&&##**$$(+CR+LF)
        s:=strzero(Q.fieldbyname('nutr_codigo').asinteger,4)+
           space(01)+
           strzero(trunc(Q.fieldbyname('Nutr_qtde').ascurrency) ,3)+
           GetUnidade(Q.fieldbyname('Nutr_unporcao').asstring)+
           strzero(trunc(Q.fieldbyname('Nutr_qtdeporcao').ascurrency),2)+
           '0'+
           '16'+  // fixo por��es ate revisar
           PoeZero(Q.fieldbyname('Nutr_calorias').ascurrency,4)+
           PoeZero(Q.fieldbyname('Nutr_carboidratos').ascurrency,3)+
           Menor1g(Q.fieldbyname('Nutr_carboidratos').ascurrency)+
           PoeZero(Q.fieldbyname('Nutr_proteinas').ascurrency,2)+
           Menor1g(Q.fieldbyname('Nutr_proteinas').ascurrency)+
           Strzero(trunc(Q.fieldbyname('Nutr_gordtotais').ascurrency),2)+
           PoeZero(Q.fieldbyname('Nutr_gordtotais').ascurrency-trunc(Q.fieldbyname('Nutr_gordtotais').ascurrency),1)+
           Strzero(trunc(Q.fieldbyname('Nutr_gordsaturadas').ascurrency),2)+
           PoeZero(Q.fieldbyname('Nutr_gordsaturadas').ascurrency-trunc(Q.fieldbyname('Nutr_gordsaturadas').ascurrency),1)+
           PoeZero(Q.fieldbyname('Nutr_colesterol').ascurrency,3)+
           PoeZero(Q.fieldbyname('Nutr_fibras').ascurrency,2)+
           Menor1g(Q.fieldbyname('Nutr_fibras').ascurrency)+
           PoeZero(Q.fieldbyname('Nutr_calcio').ascurrency,3)+
           PoeZero(trunc(Q.fieldbyname('Nutr_ferro').ascurrency),2)+
           PoeZero(Q.fieldbyname('Nutr_ferro').ascurrency-trunc(Q.fieldbyname('Nutr_ferro').ascurrency),2)+
           PoeZero(Q.fieldbyname('Nutr_sodio').ascurrency,4)+
           strzero(0,2)+
           strzero(0,2)+
           strzero(0,2)+
           strzero(0,2)+
           strzero(0,2)+
           strzero(0,2)+
           strzero(0,2)+
           strzero(0,2)+
           strzero(0,2)+
           strzero(0,2);
      end else
       s:='';
      result:=s;
    end;


    ///////////////////////////////////////////
    function GetFormatoItens(bal:string):string;
    ///////////////////////////////////////////
    var precovenda:currency;
        tipoproduto,s,impdatavalidade,impdataembalagem,codproduto,segundalinhaprodutos:string;
        codigodepto,diasvalidade,codinfextra,codinfnutricional,codfornecedor,
        lote,codconserva,codinfext1,codinfext2:integer;
    begin
      s:='';
// DD(2)T(1)CCCCCC(6)PPPPPP(6)VVV(3)D1(25)D2(25)RRRRRR(6)FFF(3)IIII(4)DV(1)DE(1)CF(4)L(12)G(11)Z(1)R(2)
      precovenda:=FEstoque.GetPreco(Q.fieldbyname('esto_codigo').asString,Global.CodigoUnidade);
      codigodepto:=1;   // ver sua algum campo como grupo ou subgrupo ou deixar fixo
      diasvalidade:=Q.fieldbyname('nutr_validade').asinteger;
      codinfextra:=Q.fieldbyname('Esto_ingr_codigo').asinteger;
      codinfnutricional:=Q.fieldbyname('Esto_nutr_codigo').asinteger;
// ver se precisa criar configuracao pra estes itens
      impdatavalidade:='1';  // 0-nao imprime  1- imprime
      impdataembalagem:='1'; // 0-nao imprime  1- imprime
      codfornecedor:=0;    // ver se vai usar...
      lote:=0;               // ver se vai usar...
      codproduto:=trim(Q.fieldbyname('esto_codigo').asString);
      codconserva:=Q.fieldbyname('Esto_cons_codigo').asinteger;
      codinfext1:=1;
      codinfext2:=Q.fieldbyname('Esto_cons_codigo1').asinteger;
      segundalinhaprodutos:=strspace(copy(Q.fieldbyname('esto_descricao').asString,26,25),25);
      if bal='TOLEDO' then begin
        tipoproduto:='2';   // revisar  = Ean13 por peso
        if trim(FGeral.GetConfig1AsString('TIPOVENTOLEDO'))<>'' then
          tipoproduto:=FGeral.GetConfig1AsString('TIPOVENTOLEDO');
        if length(codproduto) < 6 then
          codproduto:=strzero(0,6-length(codproduto)) + codproduto
        else
          codproduto:=copy(codproduto,1,6);
// 04.01.07
        segundalinhaprodutos:=strspace( Arq.TUnidades.fieldbyname('Unid_reduzido').AsString,25 );
        s:=strzero(codigodepto,2)+
           tipoproduto+  // 1
           codproduto+
//          Strzero(trunc(precovenda),4)+PoeZero(precovenda-trunc(precovenda),2)+
// 10.01.12
           Strzero(trunc(precovenda),4)+PoeZero((precovenda-trunc(precovenda))*100,2)+
           strzero(diasvalidade,3)+
           strspace(Q.fieldbyname('esto_descricao').asString,25)+
           segundalinhaprodutos+
//           strspace(copy(Q.fieldbyname('esto_descricao').asString,26,25),25)+
           strzero(codinfextra,6)+
           strzero(0,6)+   // codigo da imagem
           strzero(codinfnutricional,4)+
           impdatavalidade+
           impdataembalagem+
           strzero(codfornecedor,4)+
           strzero(lote,12)+
           strzero(0,11)+   // reservado
           strzero(0,1)+    // vers�o do pre�o/indicador de uso..nao sei o que �...
           strzero(0,4)+    // codigo do som
           strzero(0,4)+    // codigo da tara
           strzero(0,4)+    // codigo do tracionador
           strzero(codinfext1,4)+    // codigo do campo extra 1
           strzero(codinfext2,4)+    // codigo do campo extra 2
           strzero(codconserva,4)+    // codigo do conserva��o
           strspace(copy(Q.fieldbyname('esto_codbarra').asString,1,12),12);   // codigo barra ean13 sem o digito

//           strzero(0,2);   // reservado  / terminaria aqui se for versao 1
      end; // toledo
      result:=s
    end;
{/////////////////////
ITENSMGV.TXT - VERSAO 1
////////////
DD	C�digo do departamento	(2 bytes)
T	Tipo de produto	(1 byte)
[0] => Venda por peso[1] => Venda por unidade[2] => EAN-13 por peso[3] => Venda por peso glaciado[4] => Venda por peso drenado[5] => EAN-13 por unidade
CCCCCC	C�digo do Item	(6 Bytes)
PPPPPP	Pre�o/kg ou Pre�o/Unid. do item	(6 bytes)
VVV	Dias de validade do produto	(3 bytes)
[000 � 990] - Prix4-N ou superior
[000 � 360] - Prix4 / Prix4-R
[000 � 099] - Rede MGVIII
D1	Linha 1 do descritivo do produto	(25 bytes)
D2	Linha 2 do descritivo do produto	(25 bytes)
RRRRRR	C�digo da Inf. Extra do item	(6 bytes)
"000000"  = n�o haver� associa��o
FFF	C�digo da Imagem do Item	(3 Bytes)
"000"  = n�o haver� associa��o
IIII	C�digo da Informa��o Nutricional	(4 Bytes)
"0000"  = n�o haver� associa��o
DV	Data de Validade	(1 Byte)
[1] => Imprime Data de Validade
[0] => N�o Imprime Data de Validade
DE	Imprime Data de Embalagem	(1 Byte)
[1] => Imprime Data de Embalagem
[0] => N�o Imprime Data de Embalagem
CF	C�digo do Fornecedor	(4 Bytes)
"0000"  = n�o haver� associa��o	
L	Lote	(12 Bytes)
G	Reservado	(11 Bytes)
Z	Vers�o do pre�o / Indicador de uso	(1 Byte)
R	Bytes Reservados	(2 Bytes)
/////////////////////////////////////campos da versa 2
CS	C�digo do Som"0000"  = n�o haver� associa��o	(4 Bytes)
CT	C�digo da Tara"0000"  = n�o haver� associa��o	(4 Bytes)
FRAC	C�digo do Fracinador"0000"  = n�o haver� associa��o	(4 Bytes)
CE1	C�digo do Campo Extra 1"0000"  = n�o haver� associa��o	(4 Bytes)
CE2	C�digo do Campo Extra 2"0000"  = n�o haver� associa��o	(4 Bytes)
CONS	C�digo da Conserva��o"0000"  = n�o haver� associa��o	(4 Bytes)
EAN(12)	EAN-13, quando utilizado Tipo de Produto EAN-13	(12 Bytes)
//////////////////////
}

//////////////////
{
CCCC	C�digo da Informa��o Nutricional	(4 Bytes)
A	Reservado	(1 Byte)
BBB	Quantidade	(3 Bytes)
D	Unidade de Por��o	(1 Byte)
 	[0] => Unidade de por��o em gramas(g)
 	[1] => Unidade de por��o em mililitros(ml)
 	[2] => Unidade de por��o em unidades(un)
EE	Parte Inteira da Medida Caseira	(2 Bytes)
F	Parte Decimal da Medida Caseira	(1 Byte)
 	[0] => Para 0
 	[1] => Para 1/4
 	[2] => Para 1/3
 	[3] => Para 1/2
 	[4] => Para 2/3
 	[5] => Para 3/4
GG	Medida Caseira Utilizada	(2 Bytes)
 	[00] => Colher(es) de Sopa	[14] => Disco(s)
 	[01] => Colher(es) de Caf�	[15] => Copo(s)
[02] => Colher(es) de Ch�	[16] => Por��o(�es)
[03] => X�cara(s)	[17] => Tablete(s)
[04] => De X�cara(s)	[18] => Sach�(s)
[05] => Unidade(s)	[19] => Alm�dega(s)
[06] => Pacote(s)	[20] => Bife(s)
[07] => Fatia(s)	[21] => Fil�(s)
[08] => Fatia(s) Fina(s)	[22] => Concha(s)
[09] => Peda�o(s)	[23] => Bala(s)
[10] => Folha(s)	[24] => Prato(s) Fundo(s)
[11] => P�o(es)	[25] => Pitada(s)
[12] => Biscoito(s)	[26] => Lata(s)
 	[13] => Bisnaguinha(s)
HHHH	Valor Cal�rico	(4 Bytes)
III	Carboidratos	(3 Bytes)
J	Menor que 1 g de Carboidrato	(1 Byte)
 	[0] => N�o
 	[1] => Sim
LL	Prote�nas	(2 Bytes)
M	Menor que 1 g de Prote�na	(1 Byte)
 	[0] => N�o
 	[1] => Sim
NNN*	Gorduras Totais	(3 Bytes)
OOO*	Gorduras Saturadas	(3 Bytes)
PPP**	Colesterol	(3 Bytes)
QQ	Fibra Alimentar	(2 Bytes)
R	Menor que 1 g de Fibra Alimentar	(1 Byte)
[0] => N�o
[1] => Sim
SSS***	C�lcio	(3 Bytes)
TTTT****	Ferro	(4 Bytes)
UUUU	S�dio	(4 Bytes)			
VV	Valor Diario do Valor Calorico	(2 Bytes)			
XX	Valor Diario dos Carboidratos	(2 Bytes)
ZZ	Valor Diario das Prote�nas	(2 Bytes)
WW	Valor Diario das Gorduras Totais	(2 Bytes)
YY	Valor Diario das Gorduras Saturadas	(2 Bytes)
KK	Valor Diario do Colesterol	(2 Bytes)
&&	Valor Diario da Fibra Alimentar	(2 Bytes)
##	Valor Diario do C�lcio	(2 Bytes)
**	Valor Diario do Ferro	(2 Bytes)
$$	Valor Diario do S�dio	(2 Bytes)
}
//////////////////

    ///////////////////////////////////////////
    function GetFormatoIngre(bal:string):string;
    ///////////////////////////////////////////
    var tamlinha:integer;
        s:string;
    begin
      s:='';
// CCCCCCB(100)I(56)I(56)I(56)I(56)I(56)I(56)I(56)I(56)I(56)I(56)I(56)I(56)I(56)I(56)I(56) (+CR +LF)
      if bal='TOLEDO' then begin  // 03 a 5 linhas de 56 bytes cfe a etique escolhida...
        tamlinha:=56;
// talvez usar a config. geral ou o conceito de 'espec�fico'
{
        s:=strzero(Q.fieldbyname('ingr_codigo').asInteger,6)+
           strspace(copy(Q.fieldbyname('Ingr_linha1').AsString,1,100),100)+  // observacoes
           strspace(copy(Q.fieldbyname('Ingr_linha2').AsString,1,tamlinha),tamlinha)+  // linha 1
           strspace(copy(Q.fieldbyname('Ingr_linha3').AsString,1,tamlinha),tamlinha)+  // linha 2
           strspace(copy(Q.fieldbyname('Ingr_linha4').AsString,1,tamlinha),tamlinha)+  // linha 3
           strspace(copy(Q.fieldbyname('Ingr_linha5').AsString,1,tamlinha),tamlinha)+  // linha 4
           strspace(copy(Q.fieldbyname('Ingr_linha6').AsString,1,tamlinha),tamlinha)+  // linha 5
           strspace(copy(Q.fieldbyname('Ingr_linha7').AsString,1,tamlinha),tamlinha)+  // linha 6
           strspace(copy(Q.fieldbyname('Ingr_linha8').AsString,1,tamlinha),tamlinha)+  // linha 7
           strspace(copy(Q.fieldbyname('Ingr_linha9').AsString,1,tamlinha),tamlinha)+  // linha 8
           strspace(copy(Q.fieldbyname('Ingr_linha10').AsString,1,tamlinha),tamlinha)+  // linha 9
           space(tamlinha*6);
}
        s:=strzero(Q.fieldbyname('ingr_codigo').asInteger,6)+
           strspace(copy(Q.fieldbyname('Ingr_linha1').AsString,1,100),100)+  // observacoes
           strspace(copy(Q.fieldbyname('Ingr_linha2').AsString,1,tamlinha),tamlinha)+  // linha 1
           strspace(copy(Q.fieldbyname('Ingr_linha3').AsString,1,tamlinha),tamlinha)+  // linha 2
           strspace(copy(Q.fieldbyname('Ingr_linha4').AsString,1,tamlinha),tamlinha)+  // linha 3
           strspace(copy(strspace(Arq.TUnidades.fieldbyname('Unid_endereco').AsString+' '+Arq.TUnidades.fieldbyname('Unid_bairro').AsString+' '+FGeral.Formatacep(Arq.TUnidades.fieldbyname('Unid_Cep').AsString),56) ,1,tamlinha),tamlinha)+  // linha 4
           strspace(copy( strspace( FGeral.Formatacnpj(Arq.TUnidades.fieldbyname('Unid_cnpj').AsString)+
                         ' INS '+Arq.TUnidades.fieldbyname('Unid_inscricaoestadual').AsString,56),1,tamlinha),tamlinha)+  // linha 5
           strspace(copy(Q.fieldbyname('Ingr_linha7').AsString,1,tamlinha),tamlinha)+  // linha 6
           strspace(copy(Q.fieldbyname('Ingr_linha8').AsString,1,tamlinha),tamlinha)+  // linha 7
           strspace(copy(Q.fieldbyname('Ingr_linha9').AsString,1,tamlinha),tamlinha)+  // linha 8
           strspace(copy(Q.fieldbyname('Ingr_linha10').AsString,1,tamlinha),tamlinha)+  // linha 9
           space(tamlinha*6);
      end; // toledo
      result:=s
    end;


    ///////////////////////////////////////////
    function GetFormatoCons(bal:string):string;
    ///////////////////////////////////////////
    var tamlinha:integer;
        s:string;
    begin
      s:='';
// CCCCB(100)C(56)C(56)C(56)(+CR+LF)
      if bal='TOLEDO' then begin  // 3 linhas de 56 bytes
        tamlinha:=56;
        s:=strzero(Q.fieldbyname('cons_codigo').asInteger,4)+
           strspace(copy(Q.fieldbyname('cons_linha1').AsString,1,100),100)+  // observacoes
           strspace(copy(Q.fieldbyname('cons_linha2').AsString,1,tamlinha),tamlinha)+  // linha 1
           strspace(copy(Q.fieldbyname('cons_linha3').AsString,1,tamlinha),tamlinha)+
           strspace(copy(Q.fieldbyname('cons_linha4').AsString,1,tamlinha),tamlinha);
      end; // toledo
      result:=s
    end;

    ///////////////////////////////////////////
    function GetFormatoCons1(bal:string):string;
    ///////////////////////////////////////////
    var tamlinha:integer;
        s:string;
        Q1:TSqlquery;
    begin
      s:='';
// CCCCB(100)C(56)C(56)C(56)(+CR+LF)
      Q1:=sqltoquery('select * from conservacao where cons_codigo='+inttostr(Q.fieldbyname('esto_cons_codigo1').AsInteger));
      if not Q1.Eof then begin
        if bal='TOLEDO' then begin  // 3 linhas de 56 bytes
          tamlinha:=56;
          s:=strzero(Q1.fieldbyname('cons_codigo').asInteger,4)+
             strspace(copy(Q1.fieldbyname('cons_linha1').AsString,1,100),100)+  // observacoes
             strspace(copy(Q1.fieldbyname('cons_linha2').AsString,1,tamlinha),tamlinha)+  // linha 1
             strspace(copy(Q1.fieldbyname('cons_linha3').AsString,1,tamlinha),tamlinha)+
             strspace(copy(Q1.fieldbyname('cons_linha4').AsString,1,tamlinha),tamlinha);
        end; // toledo
      end;
      FGeral.FechaQuery(Q1);
      result:=s
    end;



////////////////////////////////////////////////////
begin
//////////////////////////////////////////////////////

  if Arq.TEstoque.isempty then exit;
  Q:=Sqltoquery('select * from estoque '+
                ' left join nutricionais on (nutr_codigo=esto_nutr_codigo)'+
                ' left join ingredientes on (ingr_codigo=esto_ingr_codigo)'+
                ' left join conservacao on (cons_codigo=esto_cons_codigo)'+
                ' where ( (esto_nutr_codigo>0) or (esto_ingr_codigo>0) or (esto_cons_codigo>0) )'+
                ' order by esto_descricao');
  if Q.eof then begin
    Avisoerro('Nenhum produto configurado com codigo de informa��o nutricional, ingredientes ou conserva��o');
    exit;
  end;
  qbalanca:='TOLEDO';  // por enquantofixo
  nomearqnutri:='INFNUTRI.TXT';
  nomearqitens:='ITENSMGV.TXT';
  nomearqingre:='TXINFO.TXT';
  nomearqcons:='CONSERVA.TXT';
  nomearqinfext1:='CAMPEXT1.TXT';
  nomearqinfext2:='CAMPEXT2.TXT';
  ListaNutri:=TStringlist.create;
  ListaIngre:=TStringlist.create;
  ListaCons:=TStringlist.create;
  ListaInfExt1:=TStringlist.create;
  ListaInfExt2:=TStringlist.create;

//  Sistema.BeginProcess('Criando arquivo(s) texto(s) '+nomearqnutri+' e '+nomearqitens);
  Sistema.BeginProcess('Criando arquivo(s) texto(s)');
  AssignFile(ArquivoNutri, nomearqnutri );
  Rewrite(ArquivoNutri);
  AssignFile(ArquivoItens, nomearqitens );
  Rewrite(ArquivoItens);
  AssignFile(ArquivoIngredientes, nomearqingre );
  Rewrite(ArquivoIngredientes);
  AssignFile(ArquivoConservacao, nomearqcons );
  Rewrite(ArquivoConservacao);
  AssignFile(ArquivoInfExt1, nomearqinfext1 );
  Rewrite(ArquivoInfExt1);
  AssignFile(ArquivoInfExt2, nomearqinfext2 );
  Rewrite(ArquivoInfExt2);
// campo extra 1 apenas um registro com codigo 1 pra imprimir dados da empresa
// que emite a etiqueta ( buscando do cadastro de unidades )
  if Arq.TUnidades.Locate('unid_codigo',Global.CodigoUnidade,[]) then begin
    linhainfext1:='0001'+
                   strspace(Arq.TUnidades.fieldbyname('Unid_nome').AsString,100)+
                   strspace(Arq.TUnidades.fieldbyname('Unid_endereco').AsString+' '+Arq.TUnidades.fieldbyname('Unid_bairro').AsString,56)+
                   strspace( FGeral.Formatacep(Arq.TUnidades.fieldbyname('Unid_Cep').AsString)+
                             ' - '+FCidades.GetNome(Arq.TUnidades.fieldbyname('Unid_cida_codigo').AsInteger)+
                             ' - '+Global.UFUnidade+
                             ' - '+FGeral.Formatatelefone(Arq.TUnidades.fieldbyname('Unid_fone').AsString)  ,56)+
                   strspace( FGeral.Formatacnpj(Arq.TUnidades.fieldbyname('Unid_cnpj').AsString)+
                         ' - '+'Ind�stria Brasileira',56);
    Writeln(ArquivoInfExt1,linhainfext1);
  end;
  while not Q.eof do begin
    if (Q.fieldbyname('esto_nutr_codigo').asinteger>0) and ( ListaNutri.IndexOf(strzero(Q.fieldbyname('esto_nutr_codigo').asinteger,7))=-1 ) then begin
      linha:=GetFormato(qbalanca);
      Writeln(ArquivoNutri,linha);
      ListaNutri.Add( strzero(Q.fieldbyname('esto_nutr_codigo').asinteger,7) );
    end;
    linhaitens:=GetFormatoItens(qbalanca);
    Writeln(Arquivoitens,linhaitens);
    if (Q.fieldbyname('esto_ingr_codigo').asinteger>0) and ( ListaINgre.IndexOf(strzero(Q.fieldbyname('esto_ingr_codigo').asinteger,7))=-1 ) then begin
      linhaingre:=GetFormatoIngre(qbalanca);
      Writeln(ArquivoIngredientes,linhaingre);
      ListaIngre.Add( strzero(Q.fieldbyname('esto_ingr_codigo').asinteger,7) );
    end;
    if (Q.fieldbyname('esto_cons_codigo').asinteger>0 ) and ( ListaCons.IndexOf(strzero(Q.fieldbyname('esto_cons_codigo').asinteger,7))=-1 ) then begin
      linhacons:=GetFormatoCons(qbalanca);
      Writeln(ArquivoConservacao,linhacons);
      ListaCons.Add( strzero(Q.fieldbyname('esto_cons_codigo').asinteger,7) );
    end;
    if (Q.fieldbyname('esto_cons_codigo1').asinteger>0 ) and ( ListaInfExt2.IndexOf(strzero(Q.fieldbyname('esto_cons_codigo1').asinteger,7))=-1 ) then begin
      linhacons1:=GetFormatoCons1(qbalanca);
      Writeln(ArquivoInfExt2,linhacons1);
      ListaInfExt2.Add( strzero(Q.fieldbyname('esto_cons_codigo1').asinteger,7) );
    end;
    Q.Next;
  end;
  CloseFile(ArquivoNutri);
  CloseFile(ArquivoItens);
  CloseFile(ArquivoIngredientes);
  CloseFile(ArquivoConservacao);
  CloseFile(ArquivoInfExt1);
  CloseFile(ArquivoInfExt2);
  FGeral.FechaQuery(Q);
  ListaCons.Free;
  ListaINgre.Free;
  ListaNutri.Free;
  ListaInfExt1.Free;
  ListaInfExt2.Free;
  Sistema.EndProcess('Arquivos gerados');

end;

// 08.08.19
procedure TFEstoque.bequipamentoClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var xcampo:TDicionario;
begin

  if EdEsto_codigo.isempty then exit;
  xcampo:=Sistema.GetDicionario('estoque','esto_equi_codigo');
  if trim(xcampo.Tipo)='' then exit;

    PEquipamento.enabled:=true;
    EdEqui_codigo.enabled:=true;
    Pbotoes.Enabled:=false;
    PEquipamento.Visible:=true;
    EdEqui_codigo.Visible:=true;
    EdEqui_codigo.text:=Arq.TEstoque.FieldByName('esto_equi_codigo').AsString;
    EdEqui_codigo.setfocus;

end;

/////////////////////////////////////////////////////////////////////////////////////
// 13.10.11
function TFEstoque.GetsituacaotributariaPIS(codigoestoque, unidade,  UF: string;
                   Es:string='S' ; mens:string=''): string;
/////////////////////////////////////////////////////////////////////////////////////////////////////////
var codsittrib,codsittribestado:integer;
    TEstoque,QBusca,TCst:TSqlQuery;
    sqlcst,cstpis:string;
    xcampo:TDicionario;
begin
  if not Arq.TUnidades.active then Arq.TUnidades.open;
  Arq.TUnidades.locate('unid_codigo',unidade,[]);
  result:='01';
  xcampo:=Sistema.GetDicionario('sittrib','sitt_cstpis');
  if trim(xcampo.Tipo)='' then exit;
  sqlcst:='';
  if Es='E' then
    sqlcst:=' and SITT_ES='+Stringtosql(es);
  TEstoque:=Sqltoquery('select * from estoque where esto_codigo='+Stringtosql(codigoestoque));
  if not TEstoque.eof then begin
    QBusca:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Codigoestoque,Unidade));
    if not QBusca.Eof then begin
      codsittribestado:=QBusca.FieldByName('esqt_sitt_codestado').asinteger;
// por enquanto trazer somente baseado 'no do estado' pois PIS � federal
//      if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
        codsittrib:=QBusca.FieldByName('esqt_sitt_codestado').asinteger;
//      else
//        codsittrib:=QBusca.FieldByName('esqt_sitt_forestado').asinteger;
// 09.07.13
      TCst:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr(codsittrib));
      if ( trim(sqlcst)<>'' ) then begin
         TCst.Close;
         TCst:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr(codsittrib)+sqlcst);
         if not Tcst.eof then
           result:=TCSt.fieldbyname('sitt_cstpis').AsString
         else begin
           result:='01';
           Avisoerro('N�o encontrado sit. tribut�ria PIS (Entrada ) '+inttostr(codsittrib)+' codigo '+codigoestoque);
         end;
         TCst.Close;
      end else if not TCst.eof then begin
         result:=TcSt.fieldbyname('sitt_cstpis').AsString;
      end else begin
         result:='01';
// 08.07.20
         if mens='' then
           Avisoerro('N�o encontrado sit. tribut�ria PIS '+inttostr(codsittrib)+' codigo '+codigoestoque);

      end;
    end else begin
// 14.03.16 - prever banco de dados 'detonado' quando nao encontra o produto no estoqueqtde
      TCst:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr(FUnidades.GetSittDentro(unidade)));
      result:=TCSt.fieldbyname('sitt_cstpis').AsString;
      TCst.Close;
    end;
    QBusca.Close;
    if Global.topicos[1230] then begin
      cstpis:=FSubgrupos.GetCST(TEstoque.fieldbyname('esto_sugr_codigo').AsInteger,'PIS');
      if trim(cstpis)<>'' then result:=cstpis;
    end;
  end else begin

// 08.07.20
    if mens='' then
       Avisoerro('Codigo ['+codigoestoque+'] n�o encontrado no estoque (Situa��o Tribut�ria PIS)');

  end;
  TEstoque.Close;
end;

////////////////////////////////////////////////////////////////////////////////////////////
// 13.10.11
function TFEstoque.GetsituacaotributariaCOFINS(codigoestoque, unidade,  UF: string;Es:string='S' ; mens:string=''): string;
////////////////////////////////////////////////////////////////////////////////////////////
var codsittrib,codsittribestado:integer;
    TEstoque,QBusca,TCST:TSqlQuery;
    sqlcst,cstcofins:string;
    xcampo:TDicionario;
begin
///////////  if not Arq.TSittributaria.active then Arq.TSittributaria.open;
  if not Arq.TUnidades.active then Arq.TUnidades.open;
  Arq.TUnidades.locate('unid_codigo',unidade,[]);
  result:='01';
  xcampo:=Sistema.GetDicionario('sittrib','sitt_cstcofins');
  if trim(xcampo.Tipo)='' then exit;
  sqlcst:='';
  if Es='E' then
    sqlcst:=' and SITT_ES='+Stringtosql(es);
  TEstoque:=Sqltoquery('select * from estoque where esto_codigo='+Stringtosql(codigoestoque));
  if not TEstoque.eof then begin
    QBusca:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Codigoestoque,Unidade));
    if not QBusca.Eof then begin
      codsittribestado:=QBusca.FieldByName('esqt_sitt_codestado').asinteger;
// por enquanto trazer somente baseado 'no do estado' pois Cofins � federal
//      if UF=Arq.TUnidades.fieldbyname('unid_uf').AsString then
        codsittrib:=QBusca.FieldByName('esqt_sitt_codestado').asinteger;
//      else
//        codsittrib:=QBusca.FieldByName('esqt_sitt_forestado').asinteger;
      TCst:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr(codsittrib));
      if ( trim(sqlcst)<>'' ) then begin
         TCst.close;
         TCst:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr(codsittrib)+sqlcst);
         if not Tcst.eof then
           result:=TCSt.fieldbyname('sitt_cstcofins').AsString
         else begin
           result:='01';
//           Avisoerro('N�o encontrado sit.  tribut�ria COFINS (Entrada ) '+inttostr(codsittrib)+' codigo '+codigoestoque);
         end;
         TCst.Close;
      end else if not TCst.eof then begin   // Locate('sitt_codigo',codsittrib,[]) then begin
         result:=TCst.fieldbyname('sitt_cstcofins').AsString;
      end else begin
         result:='01';
//         Avisoerro('N�o encontrado sit. tribut�ria COFINS '+inttostr(codsittrib)+' codigo '+codigoestoque);
      end;
    end else begin
// 14.03.16 - prever banco de dados 'detonado' quando nao encontra o produto no estoqueqtde
      TCst:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr(FUnidades.GetSittDentro(unidade)));
      result:=TCSt.fieldbyname('sitt_cstcofins').AsString;
      TCst.Close;
    end;
    QBusca.Close;
    if Global.topicos[1230] then begin
      cstcofins:=FSubgrupos.GetCST(TEstoque.fieldbyname('esto_sugr_codigo').AsInteger,'COFINS');
      if trim(cstcofins)<>'' then result:=cstcofins;
    end;
  end else  begin

// 08.07.20
    if mens='' then
      Avisoerro('Codigo ['+codigoestoque+'] n�o encontrado no estoque (Situa��o Tribut�ria COFINS)');

  end;
  TEstoque.Close;
end;

function TFEstoque.GetCOFINSpeloCSTICMS(xcst, xes: string;xSimples:string='N';subgrupo:integer=0): string;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var TCSt:TSqlquery;
    sqlcst:string;
begin
   sqlcst:=' and SITT_ES='+Stringtosql(xes);
   TCst:=sqltoquery('select * from sittrib where sitt_cst='+Stringtosql(xcst)+sqlcst);
   if not Tcst.eof then
     result:=copy(TCSt.fieldbyname('sitt_cstcofins').AsString,1,2)
   else begin
     IF xes='S' then begin
       TCst.close;
       TCst:=sqltoquery('select * from sittrib where sitt_cst='+Stringtosql(xcst));
       if not Tcst.eof then
         result:=copy(TCSt.fieldbyname('sitt_cstcofins').AsString,1,2)
       else begin
         result:='01';
         if trim(xcst)<>'' then
           Avisoerro('N�o encontrado sit. tribut�ria COFINS CST Icms '+xcst+' '+xes);
       end;
     end else begin
       result:='01';
       if trim(xcst)<>'' then
         Avisoerro('N�o encontrado sit. tribut�ria COFINS CST Icms '+xcst+' '+xes);
     end;
   end;
   FGeral.FechaQuery(TCST);
// 19.04.14 - Cristiane - Erenita
   if (xSimples='S') and (xes='S') then result:='49';
   if (xSimples='S') and (xes='E') then result:='99';
//////////////////////

//   if trim(result)='' then Avisoerro('sit. tribut�ria COFINS em branco para CST Icms '+xcst+' '+xes);

end;

function TFEstoque.GetPISpeloCSTICMS(xcst, xes: string;xSimples:string='N'; xtransacao:string='';subgrupo:integer=0 ): string;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var TCSt:TSqlquery;
    sqlcst,cstpis:string;
begin
   sqlcst:=' and SITT_ES='+Stringtosql(xes);
   TCst:=sqltoquery('select * from sittrib where sitt_cst='+Stringtosql(xcst)+sqlcst);
   if not Tcst.eof then
     result:=copy(TCSt.fieldbyname('sitt_cstpis').AsString,1,2)
   else begin
     IF xes='S' then begin
       TCst.close;
       TCst:=sqltoquery('select * from sittrib where sitt_cst='+Stringtosql(xcst));
       if not Tcst.eof then
         result:=copy(TCSt.fieldbyname('sitt_cstpis').AsString,1,2)
       else begin
         result:='01';
         if trim(xcst)<>'' then
//           Avisoerro('N�o encontrado sit. tribut�ria PIS CST Icms ['+xcst+'] '+xes+' '+xtransacao);
       end;
     end else begin
       result:='01';
       if trim(xcst)<>'' then
//        Avisoerro('N�o encontrado sit. tribut�ria PIS CST ICms ['+xcst+'] '+xes +' '+xtransacao);
     end;
   end;
   FGeral.FechaQuery(TCST);
// 22.06.16
//    if subgrupo >0 then begin
//       cstpis:=FSubgrupos.getcst(subgrupo,'PIS');
//       if trim(cstpis)<>'' then result:=cstpis;
 //   end;
//   if trim(result)='' then Avisoerro('sit. tribut�ria PIS em branco para CST Icms ['+xcst+'] '+xes);

end;

// 10.11.11
procedure TFEstoque.ConfiguraEdits(hab: boolean);
//////////////////////////////////////////////////
begin
  EdEsto_categoria.enabled:=hab;
  EdEsto_sisvendas.enabled:=hab;
  EdEsto_custo.enabled:=hab;
  EdEsto_custoger.enabled:=hab;
  EdEsto_customedio.enabled:=hab;
  EdEsto_customeger.enabled:=hab;
  EdEsto_precocompra.enabled:=hab;
  EdEsto_dtultvenda.enabled:=hab;
  EdEsto_dtultcompra.enabled:=hab;
  EdMObra.enabled:=hab;
  EdMomedio.enabled:=hab;
  EdEsto_basecomissao.Enabled:=hab;
  EdEsto_Vendamin.Enabled:=hab;
  EdEsto_sitt_codestado.Enabled:=hab;
  EdEsto_sitt_forestado.Enabled:=hab;
  EdEsto_cfis_codigoest.Enabled:=hab;
  Edesqt_cfis_codestsemie.Enabled:=hab;
  EdEsto_cfis_codigoforaest.Enabled:=hab;
  if Global.topicos[1226] then begin
    EdEsto_sitt_codestadonc.Enabled:=hab;
    EdEsto_sitt_forestadonc.Enabled:=hab;
    Edcfis_codestnc.Enabled:=hab;
    Edcfis_codigoforaestnc.Enabled:=hab;
  end;
end;

procedure TFEstoque.EdMargemBrutaValidate(Sender: TObject);
begin
  if (EdCompra.ascurrency>0) and (EdMargemBruta.ascurrency>0) then begin
    EdVenda.SetValue( (EdCompra.ascurrency/((100-EdMargemBruta.ascurrency)/100)) );
  end;

end;

procedure TFEstoque.bPesquisarClick(Sender: TObject);
///////////////////////////////////////////////////////
begin
  bincluir.Enabled:=false;
  {
   if (Global.Topicos[1025]) or (Global.Topicos[1044]) then begin
      Edix:=TSqled.Create(self);
      Edix:=Grid.GetEdt;
      EdPesquisa.Enabled:=true;
      EdPesquisa.Visible:=true;
      EdPesquisa.Left:=Edtleft;
//      EdPesquisa.top:=Edttop;
      EdPesquisa.top:=PMens.Top-20;
///////////      EdPesquisa.Clear; // senao nao mostra a primeira letra digitada...
      EdPesquisa.CharUpperLower:=Edix.CharUpperLower;
      EdPesquisa.CharCase:=Edix.CharCase;
      EdPesquisa.Width:=Edix.Width;
      EdPesquisa.Height:=Edix.Height;
      EdPesquisa.TableField:=Edix.TableField;
      EdPesquisa.setfocus;
   end;
   }
// 29.01.15
  if Global.Usuario.ObjetosAcessados[0141] then
    bincluir.Enabled:=true;

end;

procedure TFEstoque.EdpesquisaExitEdit(Sender: TObject);
////////////////////////// /////////////////////////////
var pesq:string;
begin
  if not EdPesquisa.IsEmpty then begin
//    if not Arq.TEstoque.Locate(EdPesquisa.TableField,EdPesquisa.Text,[loCaseInsensitive,lopartialkey]) then
//   if Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([Unidade,codigo]),[]) then begin
//    pesq:='esqt_unid_codigo;'+EdPesquisa.TableField;
//    if not Arq.TEstoque.Locate('esqt_unid_codigo;'+EdPesquisa.TableField+#39,Vararrayof([Global.CodigoUnidade,EdPesquisa.Text]),[loCaseInsensitive,lopartialkey]) then
//    if not Arq.TEstoque.Locate(pesq,Vararrayof([Global.CodigoUnidade,EdPesquisa.Text]),[loCaseInsensitive,lopartialkey]) then
//      Aviso('N�o encontrado '+EdPesquisa.Text )
       Arq.TEstoque.Close;
       Arq.TEstoque.Condicao:='';
       Arq.TEstoque.Open;
       Arq.TEstoque.Close;
       Arq.TEstoque.Condicao:=EdPesquisa.TableField+' like '+Stringtosql('%'+EdPesquisa.text+'%');
       Arq.TEstoque.Ordenacao:=EdPesquisa.TableField;
       Arq.TEstoque.Open;

  end;
  EdPesquisa.Visible:=false;
  EdPesquisa.Enabled:=false;
  Grid.SetFocus;

end;

// 15.02.17
// 18.04.20
procedure TFEstoque.GridCellClick(Column: TColumn);
////////////////////////////////////////////////////
begin

   GridNewRecord(self);

end;

procedure TFEstoque.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
//////////////////////////////////////////////////////////////////////
begin

  if Global.Topicos[1025] then begin
    if (gdSelected in State) and (gdFocused in State) then begin
   //    EdtTop :=Rect.Top;
      EdtLeftx:=Rect.Left;
    end;
  end ;


end;

procedure TFEstoque.EdpesquisaExit(Sender: TObject);
begin
   EdPesquisa.Enabled:=false;
   EdPesquisa.Visible:=false;
end;

procedure TFEstoque.GridKeyPress(Sender: TObject; var Key: Char);
////////////////////////////////////////////////////////////////////
begin

   if Global.Topicos[1025] then begin
      if Key in ['0'..'9','a'..'z','A'..'Z'] then begin
         EdPesquisa.clear;
         Edpesquisa.text:=Key;
         EdPesquisa.SetPosCursor(2);
         bPesquisarClick(self);
      end;
   end;

//   else if (key = chr(VK_RIGHT) ) then Avisoerro('foi pra direita');


//   else  if (key=chr(VK_UP)) or (key=chr(VK_DOWN)) then begin
//     Grid.Next;
//     GridNewRecord(self);
//    PemEstoque.Caption:=Edesto_qtde.text ;
//   end

//    else if (key=chr(VK_UP)) or (key=chr(VK_DOWN)) then   DadosQtdetoEdits(Arq.TEstoque.FieldByName('esto_codigo').AsString,Global.CodigoUnidade);


end;

procedure TFEstoque.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
////////////////////////////////////////////////////////////////////////
begin


// 19.02.19
   Sistema.LastKey := key;

   if (Global.Topicos[1044]) and ( Chr(Key) in ['0'..'9','a'..'z','A'..'Z'] ) and ( key<>VK_MENU ) then begin
         EdPesquisa.clear;
//         Edpesquisa.text:=Chr(Key);
         EdPesquisa.SetPosCursor(1);
         bBuscarClick(self);
         // 01.09.16
         Arq.TEstoque.Close;
         Arq.TEstoque.Condicao:='';
         Arq.TEstoque.Ordenacao:=EdPesquisa.TableField;
         Arq.TEstoque.Open;

   end


 {
// 24.02.16
   else if (key=VK_DOWN) then begin

// 14.09.18 - retirado...
//    Arq.TEstoque.BeginProcess;
//    Arq.TEstoque.Next;
//    EdEsto_codigo.GetField;

//    Arq.TEstoque.Refresh;

    EdEsto_codigo.Text:=Arq.TEstoque.FieldByName('esto_codigo').AsString;

    EdEsto_codigo.GetFields(FEstoque,99);

//    Arq.TEstoque.EndProcess;

//    EdEsto_codigo.GetFields(FEstoque,99);

//    Grid.Next;
//    Grid.DoNewRecord;

    Aviso('estou no edit codigo '+EdEsto_codigo.Text);
//    Aviso('estou no codigo '+ARq.TEstoque.FieldByName('esto_codigo').asstring);

    DadosQtdetoEdits(EdEsto_codigo.Text,Global.CodigoUnidade);

    //    DadosQtdetoEdits(Arq.TEstoque.FieldByName('esto_codigo').AsString,Global.CodigoUnidade);

   end else  if (key=VK_UP) then begin

//    Arq.TEstoque.BeginProcess;
//    Arq.TEstoque.Prior;
//    EdEsto_codigo.GetField;
// 02.03.17
//    Arq.TEstoque.Refresh;

    EdEsto_codigo.GetFields(FEstoque,99);

//    Arq.TEstoque.EndProcess;

//    Grid.DoNewRecord;
//    Grid.Prior;

//    Aviso('estou no edit codigo '+EdEsto_codigo.Text);
//    Aviso('estou no codigo '+ARq.TEstoque.FieldByName('esto_codigo').asstring);

    DadosQtdetoEdits(EdEsto_codigo.Text,Global.CodigoUnidade);
//    DadosQtdetoEdits(Arq.TEstoque.FieldByName('esto_codigo').AsString,Global.CodigoUnidade);

   end;
}


//    else if (key=(VK_UP)) or (key=(VK_DOWN)) then   DadosQtdetoEdits(Arq.TEstoque.FieldByName('esto_codigo').AsString,Global.CodigoUnidade);

   else if (key=(VK_UP)) then begin

       Arq.TEstoque.Prior;
       EdEsto_codigo.Text:=Arq.TEstoque.FieldByName('esto_codigo').AsString;
       EdEsto_codigo.GetFields(FEstoque,99);
       DadosQtdetoEdits(EdEsto_codigo.Text,Global.CodigoUnidade);
       Arq.TEstoque.Next;


   end else if (key=(VK_DOWN)) then begin

       Arq.TEstoque.Next;
       EdEsto_codigo.Text:=Arq.TEstoque.FieldByName('esto_codigo').AsString;
       EdEsto_codigo.GetFields(FEstoque,99);
       DadosQtdetoEdits(EdEsto_codigo.Text,Global.CodigoUnidade);
       Arq.TEstoque.Prior;

//     Grid.DoNewRecord;

//      EdEsto_Codigo.GetFields(FEstoque,99);
//        Arq.TEstoque.GetFields(Festoque,99);

//     keyboard( VK_RIGHT );

   end;


//}

end;

// 02.07.13
function TFEstoque.GetComprimentoPadrao(unidade, codigo: string): currency;
/////////////////////////////////////////////////////////////////////////////
var codcor,codtam:integer;
    sqlcor,sqltam:string;
begin
  codcor:=0;  // talvez nem precise da cor
  codtam:=1;
  if codcor>0 then
      sqlcor:=' and esgr_core_codigo='+inttostr(codcor)
  else
      sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
  if codcor>0 then
      sqlcor:=' and esgr_core_codigo='+inttostr(codcor)
  else
      sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
  if codtam>0 then
      sqltam:=' and esgr_tama_codigo='+inttostr(codtam)
  else
      sqltam:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';

  Q:=sqltoquery('select esgr_tama_codigo from estgrades where esgr_status=''N'''+
                  ' and esgr_unid_codigo='+stringtosql(Unidade)+
                  ' and esgr_esto_codigo='+stringtosql(codigo)+
                  sqltam );   // ++sqlcor por enquanto nao usa
  if not Q.eof then
    result:=FTamanhos.GetComprimento(Q.fieldbyname('esgr_tama_codigo').asinteger)
  else
    result:=0;

end;

// 06.07.13
procedure TFEstoque.EdEsto_referenciaValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  if trim(EdEsto_referencia.text)<>'' then begin
    Q:=sqltoquery('select * from estoque inner join grupos on ( grup_codigo=esto_grup_codigo )'+
                  ' where esto_referencia='+EdEsto_referencia.AsSql);
    if (not Q.Eof) and (Q.Fieldbyname('esto_referencia').AsString<>EdEsto_referencia.Text) then
      EdEsto_referencia.Invalid('Refer�ncia pertence ao codigo '+Q.Fieldbyname('esto_codigo').AsString)
    else
     Q.Close;
    Freeandnil(Q);
  end;
end;

// 13.07.13
function TFEstoque.BuscaporReferenciaouCodigo(codigo: string): TSqlquery;
////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from estoque where esto_codigo='+Stringtosql(codigo));
  if Q.eof then begin
    Q.close;
    Q:=sqltoquery('select * from estoque where esto_referencia='+Stringtosql(codigo));
  end;
  Result:=Q;
end;

// 22.07.13
function TFEstoque.GetPrecoGrade(Produto, Unidade: string; xcodtam,  xcodcor: integer): currency;
/////////////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    Unidadebusca:string;
begin
  if Global.topicos[1362] then
    unidadebusca:=Global.unidadematriz
  else
    unidadebusca:=unidade;
  Q:=sqltoquery('select esgr_vendavis,esgr_custo from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(Produto)+
                ' and esgr_unid_codigo='+Stringtosql(Unidadebusca)+
                ' and esgr_tama_codigo='+inttostr(xcodtam)+
                ' and esgr_core_codigo='+inttostr(xcodcor));
  if not Q.eof then begin
    result:=Q.fieldbyname('esgr_vendavis').ascurrency;
    if Global.Topicos[1411] then result:=Q.fieldbyname('esgr_custo').ascurrency
  end else result:=0;
  FGeral.FechaQuery(Q);
end;

///////////////////// 02.07.15
procedure TFEstoque.Edesto_cipi_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
  if ( Global.Topicos[1228] ) and ( EdEsto_cipi_codigo.isempty ) then EdEsto_cipi_codigo.invalid('Obrigat�rio informar codigo do NCM');
end;

// 03.03.16
function TFEstoque.GetEmbalagem(codigo: string):integer;
/////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Result:=1;
  if Trim(Codigo)<>'' then begin
   Q:=sqltoquery('select esto_embalagem from estoque where esto_codigo='+stringtosql(codigo));
   if not Q.eof then
     result:=Q.FieldByName('Esto_embalagem').AsInteger;
   FGeral.FechaQuery(Q);
  end;
end;

// 26.03.16
// 17.08.17
function TFEstoque.GetCategoria(codigo: string): string;
//////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=sqltoquery('select esto_categoria from estoque where esto_codigo='+stringtosql(codigo));
  if not Q.Eof then begin
    if Q.FieldByName('esto_categoria').AsString<>'' then begin
      if Q.FieldByName('esto_categoria').AsString='FE' then
        result:='F�mea'
      else
        result:='Macho';
    end else
      result:='Macho';
  end else result:='Macho';

end;

function TFEstoque.GetCESTNCM(codigoestoque: string): string;
///////////////////////////////////////////////////////////////
var QBusca,QIPI:Tsqlquery;
    p:integer;
    Lista,ListaAuxCest:TStringList;
begin
  result:='';
// 27.03.16
  if ListaCest=nil then begin
    ListaCest:=Tlist.create;
    if FileExists('tabelacestncm.csv') then begin
      ListaAuxCest:=TStringList.create;
      ListaAuxCest.LoadFromFile('tabelacestncm.csv');
      for p:=0 to LIstaAuxCest.count-1 do begin
        Lista:=TStringlist.create;
        strtolista(Lista,ListaAuxCest[p],';',true);
        New(PListaCest);
        PListaCest.cest:=Lista[0];
        pListaCest.ncm:=Lista[1];
        ListaCest.Add(PListaCest);
        Lista.free;
      end;
      ListaAuxCest.Free;
    end;
  end;
  QBusca:=sqltoquery('select esto_cipi_codigo from estoque where esto_codigo='+stringtosql(codigoestoque));
  if not QBusca.Eof then begin
    if QBusca.fieldbyname('esto_cipi_codigo').asinteger>0 then begin
      QIpi:=sqltoquery('select * from codigosipi where cipi_codigo='+QBusca.fieldbyname('esto_cipi_codigo').asstring);
      campo:=Sistema.GetDicionario('codigosipi','cipi_cest');
      if not QIPI.eof then begin
        if campo.Tipo<>'' then begin
          if length(trim(QIPI.fieldbyname('Cipi_cest').asstring))=7 then begin
             result:=QIPI.fieldbyname('Cipi_cest').asstring;
          end else begin
            for p:=0 to ListaCest.count-1 do begin
                PListaCest:=ListaCest[p];
                if QIPI.fieldbyname('Cipi_codfiscal').asstring=PListaCest.ncm then begin
                  result:=PListaCest.cest;
                  break
                end;
            end;
          end;
        end else begin
            for p:=0 to ListaCest.count-1 do begin
                PListaCest:=ListaCest[p];
                if QIPI.fieldbyname('Cipi_codfiscal').asstring=PListaCest.ncm then begin
                  result:=PListaCest.cest;
                  break
                end;
            end;
        end;
      end;
      FGeral.Fechaquery(QIPI);
    end;
    FGeral.Fechaquery(QBusca);
  end else
    Avisoerro('Codigo '+codigoestoque+' n�o encontrado no estoque (CestNcm)' );
end;

// 31.03.16
function TFEstoque.GetMargemcomST(xUfCliente,  yContribuinte: string): currency;
/////////////////////////////////////////////////////////////////////////////////////
begin
  if xufcliente='PR' then begin
    if ycontribuinte='1' then result:=FGeral.getconfig1asfloat('stprsimples') else
    result:=FGeral.getconfig1asfloat('stprnormal')
  end else begin
    if ycontribuinte='1' then result:=FGeral.getconfig1asfloat('stscsimples') else
    result:=FGeral.getconfig1asfloat('stscnormal')
  end;
end;

// 21.07.16
function TFEstoque.GetArqEtiqueta(cprod,sexo: string): string;
////////////////////////////////////////////////////////////
var Lista,ListaArq:TStringlist;
    xarq,codproduto,caux:string;
    p:integer;
    Diretorio:TFileListBox;
begin
   result:='';
   Diretorio:=TFileListBox.Create(self);
   Diretorio.Parent:=Self;
   Diretorio.Directory:=ExtractFilePath(Application.ExeName)+'Sistema';
   for p := 0 to Diretorio.Items.Count-1 do begin
     caux:=copy(Diretorio.Items.Strings[p],1,pos('-',Diretorio.Items.Strings[p])-1);
     if (sexo='F') and ( pos('F',caux)>0 ) then begin
//       codproduto:=( copy(Diretorio.Items.Strings[p],1,pos('-',Diretorio.Items.Strings[p])-1) );
       codproduto:=strtostrnumeros( copy(Diretorio.Items.Strings[p],1,pos('-',Diretorio.Items.Strings[p])-1) );
//       if pos(cprod,codproduto)>0 then begin
// 30.05.17 - devido ao 54 e 1554 femea...
       if CompareStrings(cprod,copy(codproduto,1,5)) then begin
         result:=Diretorio.Items.Strings[p];
         break;
       end;
     end else if (sexo='M') and ( pos('M',caux)>0 ) then begin
//       codproduto:=( copy(Diretorio.Items.Strings[p],1,pos('-',Diretorio.Items.Strings[p])-1) );
       codproduto:=strtostrnumeros( copy(Diretorio.Items.Strings[p],1,pos('-',Diretorio.Items.Strings[p])-1) );
//       if pos(cprod,codproduto)>0 then begin
       if CompareStrings(cprod,copy(codproduto,1,5)) then begin
         result:=Diretorio.Items.Strings[p];
         break;
       end;
     end else if sexo='Q'  then begin
       codproduto:=strtostrnumeros( copy(Diretorio.Items.Strings[p],1,pos('-',Diretorio.Items.Strings[p])-1) );
       if trim(cprod) = trim(codproduto) then begin
         result:=Diretorio.Items.Strings[p];
         break;
       end;
     end;
   end;

   {
   xarq:= ExtractFilePath(Application.ExeName)+'EtqCodbarra.txt';
   if FileExists( xarq  ) then begin
     Lista:=TStringlist.create;
     Lista.LoadFromFile( xarq );
     for p:=0 to Lista.count-1 do begin
       ListaArq:=TStringlist.create;
       strtolista(ListaArq,LIsta[p],';',true);
       if ListaArq.Count>1 then begin
         if Listaarq[0]=cprod then begin
           result:=Listaarq[1];
           break;
         end;
       end;
       ListaArq.free;
     end;
     Lista.free;
   end;
   }
end;

// 01.09.16
procedure TFEstoque.bbuscarClick(Sender: TObject);
////////////////////////////////////////////////////////
var Edix:TSqled;
begin
   if (Global.Topicos[1025]) or (Global.Topicos[1044]) then begin
      Edix:=TSqled.Create(self);
      Edix:=Grid.GetEdt;
      EdPesquisa.Enabled:=true;
      EdPesquisa.Visible:=true;
      EdPesquisa.Left:=Edtleftx;
//      EdPesquisa.top:=Edttop;
      EdPesquisa.top:=PMens.Top-20;
///////////      EdPesquisa.Clear; // senao nao mostra a primeira letra digitada...
      EdPesquisa.CharUpperLower:=Edix.CharUpperLower;
      EdPesquisa.CharCase:=Edix.CharCase;
      EdPesquisa.Width:=Edix.Width;
      EdPesquisa.Height:=Edix.Height;
      EdPesquisa.TableField:=Edix.TableField;
      EdPesquisa.setfocus;
   end;

end;

// 18.10.16
function TFEstoque.GetCodigoIPINCM(codigo: string): integer;
/////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=sqltoquery('select esto_cipi_codigo from estoque where esto_codigo='+stringtosql(codigo));
  if not Q.eof then result:=Q.fieldbyname('esto_cipi_codigo').asinteger else result:=0;
  FGeral.FechaQuery(Q); 

end;

// 19.10.16
function TFEstoque.GetPercComissaoporFaixa(codigo: string;  venda: currency): currency;
////////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Result:=0;
  if Trim(Codigo)<>'' then begin
   Q:=sqltoquery('select esto_faix_codigo from estoque where esto_codigo='+stringtosql(codigo));
   if not Q.eof then begin
     result:=FFaixas.GetValor(Q.fieldbyname('esto_faix_codigo').AsString,venda);
   end;
   FGeral.FechaQuery(Q);
  end;

end;

end.
