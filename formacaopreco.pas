unit formacaopreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, DB,
//  dbf,
  SqlExpr, ComCtrls, Sqlfun, SqlSis, SimpleDS;

type
  TFFormacaoPreco = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bImpressao: TSQLBtn;
    PMens: TSQLPanelGrid;
    bcalcula: TSQLBtn;
    bsalvarcomo: TSQLBtn;
    EdNomeorcam: TSQLEd;
    bmuda: TSQLBtn;
    EdOrcam: TSQLEd;
//    dbforcam: TDbf;
    dbforcam: TSimpleDataSet;
    bexclusao: TSQLBtn;
    PageVenda: TPageControl;
    PgVenda: TTabSheet;
    PgTratamento: TTabSheet;
    Pvenda: TSQLPanelGrid;
    PFormacao: TSQLPanelGrid;
    Edorca_custoobra: TSQLEd;
    EdOrca_venda: TSQLEd;
    EdDesconto01: TSQLEd;
    EdDesconto02: TSQLEd;
    EdOfertacliente: TSQLEd;
    EdVendasemlucro: TSQLEd;
    PVarVenda: TSQLPanelGrid;
    EdOrca_varvenda: TSQLEd;
    Edorca_simples: TSQLEd;
    EdOrca_pis: TSQLEd;
    EdOrca_cofins: TSQLEd;
    EdOrca_ir: TSQLEd;
    EdOrca_cs: TSQLEd;
    EdOrca_comissoes: TSQLEd;
    EdOrca_icms: TSQLEd;
    EdOrca_reserva: TSQLEd;
    EdOrca_fretes: TSQLEd;
    EdOrca_custofixo: TSQLEd;
    Edorca_simplesvlr: TSQLEd;
    EdOrca_pisvlr: TSQLEd;
    EdOrca_cofinsvlr: TSQLEd;
    EdOrca_irvlr: TSQLEd;
    EdOrca_csvlr: TSQLEd;
    EdOrca_comissoesvlr: TSQLEd;
    EdOrca_icmsvlr: TSQLEd;
    EdOrca_reservavlr: TSQLEd;
    EdOrca_fretesvlr: TSQLEd;
    EdOrca_custofixovlr: TSQLEd;
    EdOrca_varvendavlr: TSQLEd;
    Edorca_simplesvlr1: TSQLEd;
    EdOrca_pisvlr1: TSQLEd;
    EdOrca_cofinsvlr1: TSQLEd;
    EdOrca_irvlr1: TSQLEd;
    EdOrca_csvlr1: TSQLEd;
    EdOrca_comissoesvlr1: TSQLEd;
    EdOrca_icmsvlr1: TSQLEd;
    EdOrca_reservavlr1: TSQLEd;
    EdOrca_fretesvlr1: TSQLEd;
    EdOrca_custofixovlr1: TSQLEd;
    EdOrca_varvendavlr1: TSQLEd;
    PAcessorios: TSQLPanelGrid;
    EdVlracessorios: TSQLEd;
    PMargem: TSQLPanelGrid;
    EdOrca_margem: TSQLEd;
    EdOrca_margemvlr: TSQLEd;
    EdOrca_divisor: TSQLEd;
    EdOrcam_multi: TSQLEd;
    EdOrca_margemcli: TSQLEd;
    PTratamento: TSQLPanelGrid;
    PTratdigitacao: TSQLPanelGrid;
    EdCodigo: TSQLEd;
    EdDescricao: TSQLEd;
    Edorcd_qtde: TSQLEd;
    Edorcd_unidade: TSQLEd;
    Edorcd_unitario: TSQLEd;
    DtGrid: TSqlDtGrid;
    pbotoestrata: TSQLPanelGrid;
    bincluirtrata: TSQLBtn;
    balterartrata: TSQLBtn;
    bexcluitrata: TSQLBtn;
    bcancelatrata: TSQLBtn;
    Edtotaltratamento: TSQLEd;
    PgMaodeobra: TTabSheet;
    pmaodeobra: TSQLPanelGrid;
    DtGridm: TSqlDtGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    bincluimo: TSQLBtn;
    balteramo: TSQLBtn;
    excluimo: TSQLBtn;
    cancelamo: TSQLBtn;
    pdigmo: TSQLPanelGrid;
    Edcodigomo: TSQLEd;
    EdDescricaomo: TSQLEd;
    Edtempomo: TSQLEd;
    Edunidademo: TSQLEd;
    Edunitariomo: TSQLEd;
    Edtotalmo: TSQLEd;
    PgInsumos: TTabSheet;
    Pitens: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    Edpercperda: TSQLEd;
    Edvlrmotorizacao: TSQLEd;
    EdVlrpersianas: TSQLEd;
    EdVlrcremonas: TSQLEd;
    PDeslocamento: TSQLPanelGrid;
    Edvlralimentacao: TSQLEd;
    Edvlrestadia: TSQLEd;
    Edkm: TSQLEd;
    edvlrdeslocamento: TSQLEd;
    EdOrca_divisorcli: TSQLEd;
    EdOrcam_multicli: TSQLEd;
    EdOrca_margemclivalor: TSQLEd;
    pcustokg: TSQLPanelGrid;
    EdCustokgreal: TSQLEd;
    Edcustom2: TSQLEd;
    Edbrutototal: TSQLEd;
    Edrealtotal: TSQLEd;
    Edpesoliquido: TSQLEd;
    Edcustopesoliquido: TSQLEd;
    Edpercproducao: TSQLEd;
    Edvlrproducao: TSQLEd;
    Edmediaperda: TSQLEd;
    Bevel1: TBevel;
    Ptotaisinsumos: TSQLPanelGrid;
    Edtotpesobruto: TSQLEd;
    Edtotpesosobra: TSQLEd;
    Edtotmediaperda: TSQLEd;
    Edtotpesoreal: TSQLEd;
    EdPesobruto2: TSQLEd;
    EdPesosobra2: TSQLEd;
    EdVendam2: TSQLEd;
    EdVendakgliq: TSQLEd;
    EdVendakgreal: TSQLEd;
    EdTotalinsumos: TSQLEd;
    Label1: TLabel;
    EdDesccliente: TSQLEd;
    PgVidros: TTabSheet;
    PVidros: TSQLPanelGrid;
    GridVidros: TSqlDtGrid;
    SQLPanelGrid5: TSQLPanelGrid;
    bincluivi: TSQLBtn;
    balteravi: TSQLBtn;
    bexcluivi: TSQLBtn;
    bcancelavi: TSQLBtn;
    Edtotalvidros: TSQLEd;
    pvidrosdigitacao: TSQLPanelGrid;
    EdCodigovi: TSQLEd;
    EdDescricaovi: TSQLEd;
    Edorcd_qtdevi: TSQLEd;
    Edorcd_unidadevi: TSQLEd;
    Edorcd_unitariovi: TSQLEd;
    PgAcessorios: TTabSheet;
    PAcessoriospag: TSQLPanelGrid;
    GridAces: TSqlDtGrid;
    SQLPanelGrid6: TSQLPanelGrid;
    bincluiaces: TSQLBtn;
    balteraraces: TSQLBtn;
    bexcluiaces: TSQLBtn;
    bcancelaaces: TSQLBtn;
    Edtotalaces: TSQLEd;
    Pacesdigitacao: TSQLPanelGrid;
    EdCodigoac: TSQLEd;
    EdDescricaoac: TSQLEd;
    Edorcd_qtdeac: TSQLEd;
    Edorcd_unidadeac: TSQLEd;
    Edorcd_unitarioac: TSQLEd;
    PgTelas: TTabSheet;
    SQLPanelGrid3: TSQLPanelGrid;
    GridTelas: TSqlDtGrid;
    SQLPanelGrid7: TSQLPanelGrid;
    bincluirtelas: TSQLBtn;
    balterartelas: TSQLBtn;
    bexluirtelas: TSQLBtn;
    bcancelartelas: TSQLBtn;
    EdTotaltelas: TSQLEd;
    ptelasdigitacao: TSQLPanelGrid;
    EdCodigote: TSQLEd;
    EdDescricaote: TSQLEd;
    Edorcd_qtdete: TSQLEd;
    Edorcd_unidadete: TSQLEd;
    Edorcd_unitariote: TSQLEd;
    EdTotalPerfist: TSQLEd;
    EdTotaltratamentot: TSQLEd;
    EdTotalvidrost: TSQLEd;
    EdTotalacessoriost: TSQLEd;
    EdTotaltelast: TSQLEd;
    EdTotalmaodeobrat: TSQLEd;
    EdPerfismark: TSQLEd;
    EdTratamentomark: TSQLEd;
    EdVidrosmark: TSQLEd;
    EdAcessoriosmark: TSQLEd;
    EdTelasmark: TSQLEd;
    EdMaodeobramark: TSQLEd;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    perfdigitacao: TSQLPanelGrid;
    EdCodigop: TSQLEd;
    EdPesobrutop: TSQLEd;
    EdPesosobrap: TSQLEd;
    EdPercsobrap: TSQLEd;
    EdPercperdap: TSQLEd;
    EdPesorealp: TSQLEd;
    EdUnitariop: TSQLEd;
    SQLPanelGrid9: TSQLPanelGrid;
    bincluirp: TSQLBtn;
    balterarp: TSQLBtn;
    bexcluirp: TSQLBtn;
    bcancelarp: TSQLBtn;
    EdReflexocom: TSQLEd;
    EdOrca_reflexovlr: TSQLEd;
    EdOrca_reflexovlr1: TSQLEd;
    EdUnitario: TSQLEd;
    PgPrazoPagamento: TTabSheet;
    SQLPanelGrid8: TSQLPanelGrid;
    GridPrazos: TSqlDtGrid;
    SQLPanelGrid10: TSQLPanelGrid;
    bcalcparcelas: TSQLBtn;
    SQLPanelGrid11: TSQLPanelGrid;
    EdVlrvenda: TSQLEd;
    Edvlrentrada: TSQLEd;
    EdFpgto_codigo: TSQLEd;
    SetEdfpgt_DESCRICAO: TSQLEd;
    Ednparcelas: TSQLEd;
    EdVlrcalculo: TSQLEd;
    Edpercjuros: TSQLEd;
    EdCarencia: TSQLEd;
    Edvlrvendafinal: TSQLEd;
    baprova: TSQLBtn;
    Bevel2: TBevel;
    Edorca_construcard: TSQLEd;
    Edorca_construcardvlr: TSQLEd;
    Edorca_construcardvlr1: TSQLEd;
    PgPerfisSac: TTabSheet;
    SQLPanelGrid12: TSQLPanelGrid;
    GridPerfisSac: TSqlDtGrid;
    SQLPanelGrid13: TSQLPanelGrid;
    bincluiperfissac: TSQLBtn;
    balterarperfissac: TSQLBtn;
    bexcluiperfissac: TSQLBtn;
    bcancelaperfissac: TSQLBtn;
    Edtotalperfissac: TSQLEd;
    paperfissacdigitacao: TSQLPanelGrid;
    EdCodigoperfissac: TSQLEd;
    EdDescricaoperfissac: TSQLEd;
    Edorcd_qtdeperfissac: TSQLEd;
    Edorcd_unidadeperfissac: TSQLEd;
    Edorcd_unitarioperfissac: TSQLEd;
    EdCodtamanhops: TSQLEd;
    Setedtamanho: TSQLEd;
    Edcodcorps: TSQLEd;
    Setedcor: TSQLEd;
    EdPesops: TSQLEd;
    bajuda: TSQLBtn;
    bimporcamento: TSQLBtn;
    Edorca_custoobraporgrupo: TSQLEd;
    PMargensgrupo: TSQLPanelGrid;
    Remargensporgrupo: TRichEdit;
    procedure bcalculaClick(Sender: TObject);
    procedure EdOfertaclienteValidate(Sender: TObject);
    procedure EdOrca_margemValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdDesconto01Validate(Sender: TObject);
    procedure bsalvarcomoClick(Sender: TObject);
    procedure EdNomeorcamExitEdit(Sender: TObject);
    procedure EdNomeorcamKeyPress(Sender: TObject; var Key: Char);
    procedure EdNomeorcamValidate(Sender: TObject);
    procedure bmudaClick(Sender: TObject);
    procedure EdOrcamKeyPress(Sender: TObject; var Key: Char);
    procedure EdOrcamExitEdit(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure EdpercperdaExitEdit(Sender: TObject);
    procedure bexclusaoClick(Sender: TObject);
    procedure PageVendaChange(Sender: TObject);
    procedure bincluirtrataClick(Sender: TObject);
    procedure Edorcd_unitarioExitEdit(Sender: TObject);
    procedure bcancelatrataClick(Sender: TObject);
    procedure balterartrataClick(Sender: TObject);
    procedure bexcluitrataClick(Sender: TObject);
    procedure EdunitariomoExitEdit(Sender: TObject);
    procedure bincluimoClick(Sender: TObject);
    procedure balteramoClick(Sender: TObject);
    procedure excluimoClick(Sender: TObject);
    procedure cancelamoClick(Sender: TObject);
    procedure EdcodigomoValidate(Sender: TObject);
    procedure EdkmValidate(Sender: TObject);
    procedure EdOrca_comissoesValidate(Sender: TObject);
    procedure EdOrca_reservaValidate(Sender: TObject);
    procedure EdpercproducaoValidate(Sender: TObject);
    procedure bImpressaoClick(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure bincluiviClick(Sender: TObject);
    procedure balteraviClick(Sender: TObject);
    procedure bexcluiviClick(Sender: TObject);
    procedure bcancelaviClick(Sender: TObject);
    procedure Edorcd_unitarioviExitEdit(Sender: TObject);
    procedure EdCodigoviExit(Sender: TObject);
    procedure bincluiacesClick(Sender: TObject);
    procedure balteraracesClick(Sender: TObject);
    procedure bexcluiacesClick(Sender: TObject);
    procedure bcancelaacesClick(Sender: TObject);
    procedure EdCodigoacExit(Sender: TObject);
    procedure Edorcd_unitarioacExitEdit(Sender: TObject);
    procedure bincluirtelasClick(Sender: TObject);
    procedure balterartelasClick(Sender: TObject);
    procedure bexluirtelasClick(Sender: TObject);
    procedure EdCodigoteExit(Sender: TObject);
    procedure Edorcd_unitarioteExitEdit(Sender: TObject);
    procedure bincluirpClick(Sender: TObject);
    procedure balterarpClick(Sender: TObject);
    procedure bexcluirpClick(Sender: TObject);
    procedure bcancelarpClick(Sender: TObject);
    procedure EdUnitariopExitEdit(Sender: TObject);
    procedure EdPercperdapValidate(Sender: TObject);
    procedure EdUnitarioExitEdit(Sender: TObject);
    procedure EdOrca_margemcliExitEdit(Sender: TObject);
    procedure EdvlrentradaExit(Sender: TObject);
    procedure EdFpgto_codigoExit(Sender: TObject);
    procedure bcalcparcelasClick(Sender: TObject);
    procedure GridPrazosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure baprovaClick(Sender: TObject);
    procedure EdFpgto_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure Edorcd_unitarioperfissacExitEdit(Sender: TObject);
    procedure bincluiperfissacClick(Sender: TObject);
    procedure balterarperfissacClick(Sender: TObject);
    procedure bcancelaperfissacClick(Sender: TObject);
    procedure EdCodigoperfissacValidate(Sender: TObject);
    procedure EdCodigoperfissacExit(Sender: TObject);
    procedure EdCodtamanhopsValidate(Sender: TObject);
    procedure bexcluiperfissacClick(Sender: TObject);
    procedure EdPesopsValidate(Sender: TObject);
    procedure bajudaClick(Sender: TObject);
    procedure bimporcamentoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(numorc:integer;xnomeorcam,xnumeroobra,unidadeobra,tipovenda:string);
    procedure CalculaPreco;
    procedure BuscaDadosPea;
    procedure CamposdbftoGrid(Grid:TSqlDtGrid);
    procedure CalculaCustoObra;
    function GetPreNativo(codigo:string):string;
    procedure BuscaDadosGrid(Q:TSqlquery);
    function SequenciaGrid(xGrid:TSqlDtGrid):integer;
    procedure EditstoGrid;
    procedure SetaDescricaoTratamento(Ed:TSqlEd);
    procedure BuscaDadosDtGrid(Q:TSqlquery; DtGrid:TSqlDtGrid);
    procedure EditstoGridM;
    procedure Limpaedits(Formulario: TForm ; Grupo:integer);
    procedure ZeraCampos;
    procedure IniciaCampos(tipovenda:string);
    procedure ImprimePlanilhaOrcamento;
    procedure EfetuarDesconto(Ed1,Ed2,Ed3,Ed4,Ed5,Ed6,Ed7,Ed8,Ed9,Ed10:TSqled);
    procedure EditstoGridVidro;
    procedure EditstoGridAces;
    procedure EditstoGridTela;
    procedure EditstoGridPerfis;
    function Inteiro(valor:real ; sinal:string ; quanto:integer):real;
    procedure PreencheGridPrazos;
    procedure SetaBotaoAprova(Situacao:string);
    procedure EditstoGridPerfisSac;

  end;

type TPerfis=record
     codigo,prenativo:string;
end;

type TCustoGrupo=record
     codgrupo:integer;
     custo,markup,margem:currency;
end;

var
  FFormacaoPreco: TFFormacaoPreco;
  Numero:integer;
  NomeOrcam,GNOmeOrcam,NumeroObra,OPOrcam,MudouTratamento,MudouMaoDeObra,MudouVidro,
  MudouAcessorios,MudouTela,MudouPerfil,SitAprovada,xUnidadeObra,xTipoVenda,TipoVendaProduto,
  TipoVendaServicos,MudouPerfisSac:string;
  ListaCodigos:TStringlist;
  CustoObra,TotalPeso,TotalPesoBruto,TotalPesoReal,Vlracessorios,Vlrmotorizacao,Vlrpersianas,
  Valorm2,Valorm2alimentacao,cargaveiculo,mediam2,CustoObraServicos,CustoObraServicosSEM:currency;
  PPerfis:^TPerfis;
  ListaP:TList;
  PCustoGrupo:^TCustoGrupo;
  ListaCustoGrupo:TList;
  Campo:TDicionario;
  QBusca,QEstoque:TSqlquery;

implementation

uses Geral, cadorcam, SQLRel, represen, Arquiv, Estoque,
  tabcomissao, conpagto, tamanhos, cadcor, impressao, grupos;

{$R *.dfm}  

{ TFFormacaoPreco }

////////////////////////////////////////////////////////////////////
procedure TFFormacaoPreco.CalculaPreco;
////////////////////////////////////////////////////////////////////
var percvenda,venda,margemcli,vendaporgrupo:currency;
    divisor,divisorsem,divisorcliente,valor,precovendaSOservicos:extended;
    i:integer;
begin
  CalculaCustoObra;
// 17.07.09
  EdOrca_comissoes.setvalue( FTabelaComissao.GetComissao(Arq.TOrcamentos.fieldbyname('orca_repr_codigo').asinteger,EdOrca_margem.ascurrency ) );
  EdReflexocom.setvalue( FTabelaComissao.GetReflexoComissao(Arq.TOrcamentos.fieldbyname('orca_repr_codigo').asinteger,EdOrca_margem.ascurrency ) );
// 03.08.09
  if EdOrca_margemcli.AsCurrency>0 then begin
    EdOrca_comissoes.setvalue( FTabelaComissao.GetComissao(Arq.TOrcamentos.fieldbyname('orca_repr_codigo').asinteger,EdOrca_margemcli.ascurrency ) );
    EdReflexocom.setvalue( FTabelaComissao.GetReflexoComissao(Arq.TOrcamentos.fieldbyname('orca_repr_codigo').asinteger,EdOrca_margemcli.ascurrency ) );
  end;
  if xTipoVenda=TipoVendaServicos then begin
    percvenda:=Edorca_simples.ascurrency+EdOrca_pis.ascurrency+Edorca_cofins.ascurrency+
             EdOrca_ir.ascurrency+EdOrca_cs.ascurrency+EdOrca_comissoes.ascurrency+
             EdOrca_icms.ascurrency+EdOrca_reserva.ascurrency+EdOrca_fretes.ascurrency+
             EdReflexocom.ascurrency+EdOrca_construcard.ascurrency;
    divisor:= ( 100 - (percvenda)) / 100;
    divisorcliente:= ( 100 - (percvenda)) / 100;
  end else begin
    percvenda:=Edorca_simples.ascurrency+EdOrca_pis.ascurrency+Edorca_cofins.ascurrency+
             EdOrca_ir.ascurrency+EdOrca_cs.ascurrency+EdOrca_comissoes.ascurrency+
             EdOrca_icms.ascurrency+EdOrca_reserva.ascurrency+EdOrca_fretes.ascurrency+
             EdOrca_custofixo.ascurrency+EdReflexocom.ascurrency+EdOrca_construcard.ascurrency;
    divisor:= ( 100 - (percvenda+EdOrca_margem.ascurrency)) / 100;
    divisorcliente:= ( 100 - (percvenda+EdOrca_margemcli.ascurrency)) / 100;
  end;

  EdOrca_varvenda.text:=floattostr(percvenda);
  if divisor>0 then begin
// 18.07.11
    if xTipoVenda=TipoVendaServicos then begin
//      EdOrca_venda.setvalue( CustoObraservicos+ ((EdOrca_custoobra.ascurrency-CustoObraservicos)/divisor) );
// 28.09.11 - corrigindo calculo
//      EdOrca_venda.setvalue( EdOrca_custoobra.ascurrency+(CustoObraservicos/divisor) );
      EdOrca_venda.setvalue( (CustoObraservicos/divisor) );
    end else begin
// 21.11.13 - Metalforte - Margem por grupo de produtos
      vendaporgrupo:=0;
      if Global.Topicos[1501] then begin
        for i:=0 to ListaCustogrupo.Count-1 do begin
          PCustoGrupo:=ListacustoGrupo[i];
          if PCustoGrupo.codgrupo=999 then  // Mao de obra
            vendaporgrupo:=vendaporgrupo+(Pcustogrupo.custo/((100-(PCustoGrupo.markup))/100))
//  ver como identificar a obra como revenda ou 'obra'
          else if FOrcamentos.Edorca_tipovenda.text='Revenda' then
            vendaporgrupo:=vendaporgrupo+(Pcustogrupo.custo/((100-(Percvenda+PCustoGrupo.markup))/100))
          else
            vendaporgrupo:=vendaporgrupo+(Pcustogrupo.custo/((100-(Percvenda+PCustoGrupo.margem))/100));
        end;
        EdOrca_venda.setvalue( EdOrca_custoobra.ascurrency/(divisor) + vendaporgrupo );
///////////////////////////////////
      end else
        EdOrca_venda.setvalue(EdOrca_custoobra.ascurrency/(divisor));
    end;
  end else
    EdOrca_venda.setvalue(0);

  EdVlrVenda.setvalue( EdOrca_venda.ascurrency );
  EdVlrcalculo.setvalue(EdVlrvenda.ascurrency-EdVlrEntrada.ascurrency);

// 19.07.11
//  precovendaSOservicos:=((EdOrca_custoobra.ascurrency-CustoObraservicos)/divisor);
// 28.09.11
  precovendaSOservicos:=EdOrca_venda.ascurrency;
  if xTipoVenda=TipoVendaServicos then begin
    EdOrca_simplesvlr.setvalue( (precovendaSOservicos)*(EdOrca_simples.ascurrency/100) );
    EdOrca_Reflexovlr.setvalue(precovendaSOservicos*(EdReflexocom.ascurrency/100));
    EdOrca_comissoesvlr.setvalue(precovendaSOservicos*(EdOrca_comissoes.ascurrency/100));
    EdOrca_margemvlr.setvalue(EdOrca_custoobra.ascurrency*(EdOrca_margem.ascurrency/100));
    EdOrca_custofixovlr.setvalue(EdOrca_custoobra.ascurrency*(EdOrca_custofixo.ascurrency/100));
    EdOrca_reservavlr.setvalue(precovendaSOservicos*(EdOrca_reserva.ascurrency/100));
  end else begin
    EdOrca_simplesvlr.setvalue( EdOrca_venda.ascurrency*(EdOrca_simples.ascurrency/100) );
    EdOrca_Reflexovlr.setvalue(EdOrca_venda.ascurrency*(EdReflexocom.ascurrency/100));
    EdOrca_comissoesvlr.setvalue(EdOrca_venda.ascurrency*(EdOrca_comissoes.ascurrency/100));
    EdOrca_margemvlr.setvalue(EdOrca_venda.ascurrency*(EdOrca_margem.ascurrency/100));
    EdOrca_custofixovlr.setvalue(EdOrca_venda.ascurrency*(EdOrca_custofixo.ascurrency/100));
    EdOrca_reservavlr.setvalue(EdOrca_venda.ascurrency*(EdOrca_reserva.ascurrency/100));
  end;
  EdOrca_pisvlr.setvalue(EdOrca_venda.ascurrency*(EdOrca_pis.ascurrency/100));
  EdOrca_cofinsvlr.setvalue(EdOrca_venda.ascurrency*(EdOrca_cofins.ascurrency/100));
  EdOrca_irvlr.setvalue(EdOrca_venda.ascurrency*(EdOrca_ir.ascurrency/100));
  EdOrca_csvlr.setvalue(EdOrca_venda.ascurrency*(EdOrca_cs.ascurrency/100));
  EdOrca_icmsvlr.setvalue(EdOrca_venda.ascurrency*(EdOrca_icms.ascurrency/100));
  EdOrca_fretesvlr.setvalue(EdOrca_venda.ascurrency*(EdOrca_fretes.ascurrency/100));
// 09.07.09
  if xTipoVenda=TipoVendaServicos then
    EdOrca_varvendavlr.setvalue(EdOrca_simplesvlr.ascurrency+EdOrca_pisvlr.ascurrency+
                                EdOrca_cofinsvlr.ascurrency+EdOrca_irvlr.ascurrency+
                                EdOrca_csvlr.ascurrency+EdOrca_comissoesvlr.ascurrency+
                                EdOrca_icmsvlr.ascurrency+EdOrca_reservavlr.ascurrency+
                                EdOrca_reflexovlr.ascurrency+
                                EdOrca_custofixovlr.ascurrency+
                                EdOrca_construcardvlr.ascurrency  )
  else
    EdOrca_varvendavlr.setvalue(EdOrca_venda.ascurrency*(EdOrca_varvenda.ascurrency/100));
// 10.09.10
  EdOrca_construcardvlr.setvalue( EdOrca_venda.ascurrency*(EdOrca_construcard.ascurrency/100) );

//  EfetuarDesconto(EdOrca_simplesvlr,EdOrca_pisvlr,EdOrca_cofinsvlr,EdOrca_irvlr,EdOrca_csvlr,EdOrca_comissoesvlr,
//                  EdOrca_icmsvlr,EdOrca_reservavlr,EdOrca_custofixovlr,EdOrca_varvendavlr);
// Adriano - 29.04.09 - efetua o desconto somente na coluna 'ao lado'

  EdOrca_divisor.setvalue(divisor);
  EdOrca_divisorcli.setvalue(divisorcliente);
  if EdOrca_custoobra.ascurrency>0 then
    EdOrcam_multi.setvalue(EdOrca_venda.ascurrency/(EdOrca_custoobra.ascurrency+EdOrca_custoobraporgrupo.ascurrency))
  else
    EdOrcam_multi.setvalue(0);
  if EdOrca_custoobra.ascurrency>0 then
    EdOrcam_multicli.setvalue(EdOfertacliente.ascurrency/(EdOrca_custoobra.ascurrency+EdOrca_custoobraporgrupo.ascurrency))
  else
    EdOrcam_multicli.setvalue(0);
  venda:=0;
////////
  EdOrca_simplesvlr1.setvalue(EdOfertaCliente.ascurrency*(EdOrca_simples.ascurrency/100));
  EdOrca_construcardvlr1.setvalue(EdOfertaCliente.ascurrency*(EdOrca_construcard.ascurrency/100));
  EdOrca_pisvlr1.setvalue(EdOfertaCliente.ascurrency*(EdOrca_pis.ascurrency/100));
  EdOrca_cofinsvlr1.setvalue(EdOfertaCliente.ascurrency*(EdOrca_cofins.ascurrency/100));
  EdOrca_irvlr1.setvalue(EdOfertaCliente.ascurrency*(EdOrca_ir.ascurrency/100));
  EdOrca_csvlr1.setvalue(EdOfertaCliente.ascurrency*(EdOrca_cs.ascurrency/100));
  EdOrca_comissoesvlr1.setvalue(EdOfertaCliente.ascurrency*(EdOrca_comissoes.ascurrency/100));
  EdOrca_icmsvlr1.setvalue(EdOfertaCliente.ascurrency*(EdOrca_icms.ascurrency/100));
  EdOrca_reservavlr1.setvalue(EdOfertaCliente.ascurrency*(EdOrca_reserva.ascurrency/100));
  EdOrca_fretesvlr1.setvalue(EdOfertaCliente.ascurrency*(EdOrca_fretes.ascurrency/100));
  EdOrca_Reflexovlr1.setvalue(EdOfertaCliente.ascurrency*(EdReflexocom.ascurrency/100));
  EdOrca_custofixovlr1.setvalue(EdOfertaCliente.ascurrency*(EdOrca_custofixo.ascurrency/100));
  EdOrca_varvendavlr1.setvalue(EdOfertaCliente.ascurrency*(EdOrca_varvenda.ascurrency/100));

//  EfetuarDesconto(EdOrca_simplesvlr1,EdOrca_pisvlr1,EdOrca_cofinsvlr1,EdOrca_irvlr1,EdOrca_csvlr1,EdOrca_comissoesvlr1,
//                  EdOrca_icmsvlr1,EdOrca_reservavlr1,EdOrca_custofixovlr1,EdOrca_varvendavlr1);

////////
  if EdOfertaCliente.ascurrency>0 then begin
    EdOrca_margemclivalor.setvalue(Edofertacliente.ascurrency*(EdOrca_margemcli.ascurrency/100));
//    divisor:=  100 - (percvenda+EdOrca_margem.ascurrency));
//      divisor - 100 = percvenda+EdOrca_margem.ascurrency
//      orcamargem = divisor -100 - percvenda;
//    EdOrca_venda.setvalue(EdOrca_custoobra.ascurrency/(divisor))
    if xTipoVenda=TipoVendaServicos then begin
       percvenda:=Edorca_simples.ascurrency+EdOrca_pis.ascurrency+Edorca_cofins.ascurrency+
             EdOrca_ir.ascurrency+EdOrca_cs.ascurrency+EdOrca_comissoes.ascurrency+
             EdOrca_icms.ascurrency+EdOrca_reserva.ascurrency+EdOrca_fretes.ascurrency+
             EdReflexocom.ascurrency+EdOrca_construcard.ascurrency;
      divisor:= ( 100 - (percvenda)) / 100;
      margemcli:= 100 - divisor;
      margemcli:=margemcli-percvenda;
    end else begin
      divisor:=( Edorca_custoobra.ascurrency/EdOfertacliente.ascurrency ) * 100;
      margemcli:= 100 - divisor;
      margemcli:=margemcli-percvenda;
    end;
    EdOrca_margemcli.setvalue(margemcli);
    EdOrca_margemclivalor.setvalue(EdOfertaCliente.ascurrency*(EdOrca_margemcli.ascurrency/100));
//    EdDesconto01.setvalue( ( (EdOrca_venda.ascurrency-EdOfertacliente.ascurrency)/
//                            EdOrca_venda.ascurrency )*100 );
    if EdOrca_venda.ascurrency>0 then
      EdDescCliente.setvalue( ( (EdOrca_venda.ascurrency-EdOfertacliente.ascurrency)/
                              EdOrca_venda.ascurrency )*100 );
    EdDesconto02.setvalue(0);
// 03.08.09
    EdDesconto01.setvalue(0);

  end else begin

    if EdDesconto01.ascurrency>0 then begin
      venda:=EdOrca_venda.ascurrency-(EdOrca_venda.ascurrency*(EdDesconto01.ascurrency/100));
      EdOrca_venda.setvalue(venda);
    end else begin
      venda:=EdOrca_venda.ascurrency;
      EdOrca_venda.setvalue(venda);
    end;
// 03.08.09
////////////////////
    if venda>0 then begin
      if xTipoVenda=TipoVendaServicos then
        divisor:=divisorcliente  // calculado acima
      else
        divisor:=( (Edorca_custoobra.ascurrency+EdOrca_custoobraporgrupo.ascurrency)/Venda ) * 100;
    end else
      divisor:=0;
    margemcli:= 100 - divisor;
    margemcli:=margemcli-percvenda;
    EdOrca_margemcli.setvalue(margemcli);
    EdOrca_margemclivalor.setvalue(Venda*(EdOrca_margemcli.ascurrency/100));
////////////////////
      EdOrca_simplesvlr1.setvalue( EdOrca_simplesvlr.ascurrency - ( EdOrca_Simplesvlr.ascurrency*(EdDesconto01.ascurrency/100)  ) );
      EdOrca_construcardvlr1.setvalue( EdOrca_construcardvlr.ascurrency - ( EdOrca_Construcardvlr.ascurrency*(EdDesconto01.ascurrency/100)  ) );
      EdOrca_pisvlr1.setvalue( EdOrca_pisvlr.ascurrency - ( EdOrca_pisvlr.ascurrency*(EdDesconto01.ascurrency/100)  ) );
      EdOrca_cofinsvlr1.setvalue( EdOrca_cofinsvlr.ascurrency - ( EdOrca_cofinsvlr.ascurrency*(EdDesconto01.ascurrency/100)  ) );
      EdOrca_irvlr1.setvalue( EdOrca_irvlr.ascurrency - ( EdOrca_irvlr.ascurrency*(EdDesconto01.ascurrency/100)  ) );
      EdOrca_csvlr1.setvalue( EdOrca_csvlr.ascurrency - ( EdOrca_csvlr.ascurrency*(EdDesconto01.ascurrency/100)  ) );
      EdOrca_comissoesvlr1.setvalue( EdOrca_comissoesvlr.ascurrency - ( EdOrca_comissoesvlr.ascurrency*(EdDesconto01.ascurrency/100)  ) );
      EdOrca_icmsvlr1.setvalue( EdOrca_icmsvlr.ascurrency - ( EdOrca_icmsvlr.ascurrency*(EdDesconto01.ascurrency/100)  ) );
      EdOrca_reservavlr1.setvalue( EdOrca_reservavlr.ascurrency - ( EdOrca_reservavlr.ascurrency*(EdDesconto01.ascurrency/100)  ) );
      EdOrca_custofixovlr1.setvalue( EdOrca_custofixovlr.ascurrency - ( EdOrca_custofixovlr.ascurrency*(EdDesconto01.ascurrency/100)  ) );
      EdOrca_varvendavlr1.setvalue( EdOrca_varvendavlr.ascurrency - ( EdOrca_varvendavlr.ascurrency*(EdDesconto01.ascurrency/100)  ) );

//////    end;  // 03.08.09
    if EdDesconto02.ascurrency>0 then begin
      venda:=Venda-(Venda*(EdDesconto02.ascurrency/100));
      EdOrca_venda.setvalue(venda);
    end;
    EdDescCliente.setvalue(0);
  end;
  divisorsem:= ( 100 - (percvenda)) / 100;
  if divisorsem>0 then
// 18.07.11
    if xTipoVenda=TipoVendaServicos then
      EdVendasemlucro.setvalue( (CustoObraservicos/divisorsem) )
    else
      EdVendasemlucro.setvalue(EdOrca_custoobra.ascurrency+EdOrca_custoobraporgrupo.ascurrency/(divisorsem));

  if EdRealtotal.asfloat >0 then
    EdCustokgreal.SetValue(EdOrca_custoobra.AsCurrency/EdRealtotal.asfloat);
  if FOrcamentos.EdOrca_area.asfloat >0 then
    EdCustom2.SetValue(EdOrca_custoobra.AsCurrency/FOrcamentos.EdOrca_area.asfloat);
// 18.02.09
  if Edvlralimentacao.ascurrency=0 then  begin
//    Edvlralimentacao.setvalue(valorm2alimentacao*FOrcamentos.EdOrca_area.asfloat);
    if cargaveiculo>0 then
      mediam2:=Inteiro(FOrcamentos.EdOrca_area.AsCurrency/cargaveiculo,'+',1)*2
    else
      mediam2:=0;
    Edvlralimentacao.setvalue( mediam2*FGeral.GetConfig1AsFloat('VLRREFORCA')  );
  end;

  if Edvlrestadia.ascurrency=0 then begin
//    Edvlrestadia.setvalue(valorm2*FOrcamentos.EdOrca_area.asfloat);
    if cargaveiculo>0 then
      mediam2:=Inteiro(FOrcamentos.EdOrca_area.AsCurrency/cargaveiculo,'-',1)
    else
      mediam2:=0;
    Edvlrestadia.setvalue( mediam2*FGeral.GetConfig1AsFloat('VLRDIARIA')  );
  end;
// 21.09.09
  if EdKM.AsCurrency=0 then begin
    Edvlrestadia.setvalue( 0.00 );
    Edvlralimentacao.setvalue( 0.00 );
  end;

   if EdPesoliquido.asfloat>0 then begin
     EdCustoPesoliquido.setvalue( EdOrca_custoobra.AsCurrency/EdPesoliquido.asfloat );
     if EdRealtotal.asfloat>0 then
       EdMediaperda.SetValue( ((EdRealtotal.asfloat-EdPesoliquido.asfloat)/EdRealtotal.asfloat)*100 );
   end;
  EdPesobruto2.setvalue( EdtotPesobruto.ascurrency);
  EdPesosobra2.setvalue( EdtotPesosobra.ascurrency);
//  EdPesoreal2.setvalue( EdtotPesoreal.ascurrency);
  if FOrcamentos.EdOrca_area.asfloat>0 then
     EdVendam2.setvalue(EdOrca_venda.AsCurrency/FOrcamentos.EdOrca_area.asfloat);
  if EdPesoliquido.asfloat>0 then
    EdVendakgliq.setvalue(EdOrca_venda.AsCurrency/EdPesoliquido.asfloat);
  if EdRealtotal.asfloat>0 then
     EdVendakgreal.setvalue(EdOrca_venda.AsCurrency/EdRealtotal.asfloat);
//  EdTotalPerfist.setvalue(EdTotalinsumos.AsCurrency);
// 18.07.13
  EdTotalPerfist.setvalue(EdTotalinsumos.AsCurrency+Edtotalperfissac.ascurrency);
  EdTotaltratamentot.setvalue(Edtotaltratamento.AsCurrency);
  EdTotalvidrost.setvalue(Edtotalvidros.Ascurrency);
  EdTotalacessoriost.setvalue(Edtotalaces.AsCurrency);
  EdTotaltelast.setvalue(EdTotaltelas.AsCurrency);
  EdTotalmaodeobrat.setvalue(Edtotalmo.AsCurrency);
  valor:=EdTotalPerfist.AsCurrency+(EdTotalPerfist.AsCurrency*(Edpercproducao.ascurrency/100));
  if EdOrca_Venda.ascurrency>0 then
    EdPerfismark.setvalue( (valor/(EdOrca_Venda.ascurrency))*100 );
  valor:=EdTotaltratamentot.AsCurrency+(EdTotaltratamentot.AsCurrency*(Edpercproducao.ascurrency/100));
  if EdOrca_Venda.ascurrency>0 then
    EdTratamentomark.setvalue( (valor/(EdOrca_Venda.ascurrency))*100 );
  if EdOrca_Venda.ascurrency>0 then
    EdVidrosmark.setvalue( (valor/(EdOrca_Venda.ascurrency))*100 );
  valor:=EdTotalvidrost.AsCurrency+(EdTotalvidrost.AsCurrency*(Edpercproducao.ascurrency/100));
  valor:=EdTotalacessoriost.AsCurrency+(EdTotalacessoriost.AsCurrency*(Edpercproducao.ascurrency/100));
  if EdOrca_Venda.ascurrency>0 then
    EdAcessoriosmark.setvalue( (valor/(EdOrca_Venda.ascurrency))*100 );
  valor:=EdTotaltelast.AsCurrency+(EdTotaltelast.AsCurrency*(Edpercproducao.ascurrency/100));
  if EdOrca_Venda.ascurrency>0 then
    EdTelasmark.setvalue( (valor/(EdOrca_Venda.ascurrency))*100 );
  valor:=EdTotalmaodeobrat.AsCurrency+(EdTotalmaodeobrat.AsCurrency*(Edpercproducao.ascurrency/100));
  if EdOrca_Venda.ascurrency>0 then
    EdMaodeobramark.setvalue( (valor/(EdOrca_Venda.ascurrency))*100 );

end;

///////////////////////////////////////////////////////////
procedure TFFormacaoPreco.PreencheGridPrazos;
///////////////////////////////////////////////////////////
var linhapc,coluna,ncolunas,n:integer;
    valorbase,valor:currency;
begin
  linhapc:=1;
  GridPrazos.Cells[0,linhapc]:='Parcela Capital';
  ncolunas:=10;
  for n:=1 to ncolunas do begin
    coluna:=n;
    GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor(EdVlrCalculo.ascurrency/coluna,f_cr)
  end;
  linhapc:=2;
  if GridPrazos.RowCount<linhapc+1 then
    GridPrazos.AppendRow;
  GridPrazos.Cells[0,linhapc]:='Saldo p/ Juros';
  for n:=1 to ncolunas do begin
    coluna:=n;
    if coluna>EdCarencia.asinteger then
      GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( (EdVlrCalculo.ascurrency/coluna)*(coluna-EdCarencia.ascurrency) ,f_cr)
    else
      GridPrazos.Cells[coluna,linhapc]:='0';
  end;

  linhapc:=3;
  if GridPrazos.RowCount<linhapc+1 then
    GridPrazos.AppendRow;
  GridPrazos.Cells[0,linhapc]:='Juro';
  for n:=1 to ncolunas do begin
    coluna:=n;
    valorbase:=Texttovalor(GridPrazos.Cells[coluna,linhapc-1]);
    if (coluna=1) and (EdFpgto_codigo.Text=FGeral.getconfig1asstring('Fpgtoavista') ) then
      GridPrazos.Cells[coluna,linhapc]:='0'
    else if (coluna>EdCarencia.asinteger) then begin
      valor:=FGeral.GetValorJurosII(valorbase,Edpercjuros.ascurrency,coluna-EdCarencia.asinteger,'N');
      GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr);
    end else
      GridPrazos.Cells[coluna,linhapc]:='0';
  end;

  linhapc:=4;
  if GridPrazos.RowCount<linhapc+1 then
    GridPrazos.AppendRow;
  GridPrazos.Cells[0,linhapc]:='Total';
  for n:=1 to ncolunas do begin
    coluna:=n;
    valor:=EdVlrCalculo.ascurrency+Texttovalor(GridPrazos.Cells[coluna,linhapc-1]);
    GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr);
    if coluna=EdNParcelas.AsInteger then
      Edvlrvendafinal.setvalue(valor);
  end;

  linhapc:=5;
  if GridPrazos.RowCount<linhapc+1 then
    GridPrazos.AppendRow;
  GridPrazos.Cells[0,linhapc]:='Parcela';
  for n:=1 to ncolunas do begin
    coluna:=n;
    valor:=Texttovalor(GridPrazos.Cells[coluna,linhapc-1]) / coluna;
    GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr);
  end;

  linhapc:=6;
  if GridPrazos.RowCount<linhapc+1 then
    GridPrazos.AppendRow;
  GridPrazos.Cells[0,linhapc]:='Markup Fin.';
  for n:=1 to ncolunas do begin
    coluna:=n;
    if coluna>EdCarencia.asinteger then begin
      if Texttovalor(GridPrazos.Cells[coluna,4])>0 then
       valor:= ( (Texttovalor(GridPrazos.Cells[coluna,4])-EdVlrVenda.Ascurrency) / Texttovalor(GridPrazos.Cells[coluna,4]) )*100
      else
       valor:=0;
      GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr);
//      GridPrazos.Cells[coluna,linhapc]:='Rever';
    end else
      GridPrazos.Cells[coluna,linhapc]:='0';
  end;

  linhapc:=linhapc+1;
  if GridPrazos.RowCount<linhapc+1 then
    GridPrazos.AppendRow;
  GridPrazos.Cells[0,linhapc]:='';

  linhapc:=linhapc+1;
  if GridPrazos.RowCount<linhapc+1 then
    GridPrazos.AppendRow;
  GridPrazos.Cells[0,linhapc]:='Tab.Descontos';

  linhapc:=linhapc+1;
  if GridPrazos.RowCount<linhapc+1 then
    GridPrazos.AppendRow;
  GridPrazos.Cells[0,linhapc]:='    1.000,00';
  for n:=1 to ncolunas do begin
    coluna:=n;
    if EdVlrCalculo.AsCurrency>0 then
      valor:=( Texttovalor(GridPrazos.Cells[coluna,3])/EdVlrcalculo.AsCurrency )*100
    else
      valor:=0;
    if coluna>EdCarencia.asinteger then
      GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr3)
    else
      GridPrazos.Cells[coluna,linhapc]:='0';
  end;
  linhapc:=linhapc+1;
  if GridPrazos.RowCount<linhapc+1 then
    GridPrazos.AppendRow;
  GridPrazos.Cells[0,linhapc]:='    5.000,00';
  for n:=1 to ncolunas do begin
    coluna:=n;
    if ( Texttovalor(GridPrazos.Cells[coluna,4])>0 ) then begin
      if coluna=3 then
        GridPrazos.Cells[coluna,linhapc]:='0'
      else if coluna>3 then begin
        valor:=( ( Texttovalor(GridPrazos.Cells[coluna,4])-Texttovalor(GridPrazos.Cells[3,4]) )/Texttovalor(GridPrazos.Cells[3,4]) )*100;
        GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr3);
      end else begin
        valor:=( ( Texttovalor(GridPrazos.Cells[3,4])-Texttovalor(GridPrazos.Cells[coluna,4]) )/Texttovalor(GridPrazos.Cells[3,4]) )*100;
        GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr3);
      end;
    end;
  end;
  linhapc:=linhapc+1;
  if GridPrazos.RowCount<linhapc+1 then
    GridPrazos.AppendRow;
  GridPrazos.Cells[0,linhapc]:='   25.000,00';
  for n:=1 to ncolunas do begin
    coluna:=n;
    if ( Texttovalor(GridPrazos.Cells[coluna,4])>0 ) then begin
      if coluna=5 then
        GridPrazos.Cells[coluna,linhapc]:='0'
      else if coluna>5 then begin
        valor:=( ( Texttovalor(GridPrazos.Cells[coluna,4])-Texttovalor(GridPrazos.Cells[5,4]) )/Texttovalor(GridPrazos.Cells[5,4]) )*100;
        GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr3);
      end else begin
        valor:=( ( Texttovalor(GridPrazos.Cells[5,4])-Texttovalor(GridPrazos.Cells[coluna,4]) )/Texttovalor(GridPrazos.Cells[5,4]) )*100;
        GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr3);
      end;
    end;
  end;
  linhapc:=linhapc+1;
  if GridPrazos.RowCount<linhapc+1 then
    GridPrazos.AppendRow;
  GridPrazos.Cells[0,linhapc]:='  75.000,00';
  for n:=1 to ncolunas do begin
    coluna:=n;
    if ( Texttovalor(GridPrazos.Cells[coluna,4])>0 ) then begin
      if coluna=8 then
        GridPrazos.Cells[coluna,linhapc]:='0'
      else if coluna>8 then begin
        valor:=( ( Texttovalor(GridPrazos.Cells[coluna,4])-Texttovalor(GridPrazos.Cells[5,4]) )/Texttovalor(GridPrazos.Cells[8,4]) )*100;
        GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr3);
      end else begin
        valor:=( ( Texttovalor(GridPrazos.Cells[8,4])-Texttovalor(GridPrazos.Cells[coluna,4]) )/Texttovalor(GridPrazos.Cells[8,4]) )*100;
        GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr3);
      end;
    end;
  end;
  linhapc:=linhapc+1;
  if GridPrazos.RowCount<linhapc+1 then
    GridPrazos.AppendRow;
  GridPrazos.Cells[0,linhapc]:='100.000,00';
  for n:=1 to ncolunas do begin
    coluna:=n;
    if ( Texttovalor(GridPrazos.Cells[coluna,4])>0 ) then begin
      if coluna=10 then
        GridPrazos.Cells[coluna,linhapc]:='0'
      else if coluna>10 then begin
        valor:=( ( Texttovalor(GridPrazos.Cells[coluna,4])-Texttovalor(GridPrazos.Cells[10,4]) )/Texttovalor(GridPrazos.Cells[10,4]) )*100;
        GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr3);
      end else begin
        valor:=( ( Texttovalor(GridPrazos.Cells[10,4])-Texttovalor(GridPrazos.Cells[coluna,4]) )/Texttovalor(GridPrazos.Cells[10,4]) )*100;
        GridPrazos.Cells[coluna,linhapc]:=FGeral.Formatavalor( valor ,f_cr3);
      end;
    end;
  end;


end;

////////////////////////////////////////////////////////////////////////////////////////////////
procedure TFFormacaoPreco.Execute(numorc:integer;xnomeorcam,xnumeroobra,unidadeobra,tipovenda:string);
//////////////////////////////////////////////////////////////////////////////////////////////////
var Q,QIns,QTrat:TSqlquery;
    unidadeorcamento:string;

    procedure QuerytoEdits;
    ////////////////////////
    begin
      Edorca_Custoobra.setvalue( Q.fieldbyname('orcc_custoobra').ascurrency );
      EdDesconto01.setvalue( Q.fieldbyname('orcc_desconto01').ascurrency );
      EdDesconto02.setvalue( Q.fieldbyname('orcc_desconto02').ascurrency );
      Edorca_Venda.setvalue( Q.fieldbyname('orcc_venda').ascurrency );
      Edofertacliente.setvalue( Q.fieldbyname('orcc_ofertacliente').ascurrency );
      Edorca_simples.setvalue( Q.fieldbyname('orcc_simples').ascurrency );
      Edorca_construcard.setvalue( Q.fieldbyname('orcc_construcard').ascurrency );
      Edorca_pis.setvalue( Q.fieldbyname('orcc_pis').ascurrency );
      Edorca_cofins.setvalue( Q.fieldbyname('orcc_cofins').ascurrency );
      Edorca_ir.setvalue( Q.fieldbyname('orcc_ir').ascurrency );
      Edorca_cs.setvalue( Q.fieldbyname('orcc_cs').ascurrency );
      Edorca_comissoes.setvalue( Q.fieldbyname('orcc_comissoes').ascurrency );
      Edorca_icms.setvalue( Q.fieldbyname('orcc_icms').ascurrency );
      Edorca_reserva.setvalue( Q.fieldbyname('orcc_reserva').ascurrency );
      Edorca_fretes.setvalue( Q.fieldbyname('orcc_fretes').ascurrency );
      EdReflexocom.setvalue( Q.fieldbyname('orcc_reflexocom').ascurrency );

      Edorca_custofixo.setvalue( Q.fieldbyname('orcc_custofixo').ascurrency );
      Edorca_margem.setvalue( Q.fieldbyname('orcc_margem').ascurrency );
//      EdVlracessorios.setvalue( Q.fieldbyname('Orcc_acessorios').ascurrency );
// 08.05.09 - agora componentes
      EdVlracessorios.setvalue( Q.fieldbyname('Orcc_acessorios').ascurrency+Q.fieldbyname('Orcc_persianas').ascurrency );
      EdVlrmotorizacao.setvalue( Q.fieldbyname('Orcc_motorizacao').ascurrency );
      EdVlrcremonas.setvalue( Q.fieldbyname('Orcc_cremonas').ascurrency );
//      EdVlrpersianas.setvalue( Q.fieldbyname('Orcc_persianas').ascurrency );
      EdVlralimentacao.setvalue( Q.fieldbyname('Orcc_alimentacao').ascurrency );
      EdVlrestadia.setvalue( Q.fieldbyname('Orcc_estadia').ascurrency );
      Edkm.text:=inttostr(Q.fieldbyname('Orcc_km').asinteger);
      EdVlrdeslocamento.setvalue( Q.fieldbyname('Orcc_desloca').ascurrency );
      EdPesoliquido.setvalue( Q.fieldbyname('Orcc_pesoliquido').ascurrency );
      EdPercproducao.setvalue( Q.fieldbyname('Orcc_geralprod').ascurrency );
      Edorca_margemcli.setvalue( Q.fieldbyname('orcc_margemcli').ascurrency );
// 12.08.09
      EdVlrVenda.SetValue(Q.fieldbyname('Orcc_venda').ascurrency);
      EdFpgto_codigo.text:=Q.fieldbyname('Orcc_fpgt_codigo').asString;
      EdFpgto_codigo.validfind;
      EdVlrEntrada.SetValue(Q.fieldbyname('Orcc_vlrentrada').ascurrency);
      if Q.fieldbyname('Orcc_nparcelas').asinteger<=0 then
        EdNparcelas.text:='1'
      else
        EdNparcelas.text:=inttostr(Q.fieldbyname('Orcc_nparcelas').asinteger);
      EdVlrCalculo.SetValue(Q.fieldbyname('Orcc_venda').ascurrency-Q.fieldbyname('Orcc_vlrentrada').ascurrency);
      if Q.fieldbyname('Orcc_percjurosfin').ascurrency=0 then
        EdPercjuros.setvalue( FGeral.GetConfig1AsFloat('PERCJURFIN') )
      else
        EdPercJuros.SetValue(Q.fieldbyname('Orcc_percjurosfin').ascurrency);
      if Q.fieldbyname('Orcc_mesescare').asinteger=0 then
        EdCarencia.setvalue( FGeral.GetConfig1AsInteger('MESESCARENCIA') )
      else
        EdCarencia.text:=inttostr(Q.fieldbyname('Orcc_mesescare').asinteger);
      SetaBotaoAprova(Q.fieldbyname('Orcc_situacao').asString);
    end;

begin
// 02.10.08
///////////////////////////////////////
   FGeral.EstiloForm(FFormacaoPreco);
//   FGeral.ConfiguraColorEditsNaoEnabled(FFormacaoPreco);
   PVarVenda.Enabled:=Global.Usuario.OutrosAcessos[0044];
   PAcessorios.Enabled:=true;
   MudouTratamento:='N';
   MudouVidro:='N';
   MudouAcessorios:='N';
   MudouTela:='N';
   MudouMaoDeObra:='N';
   MudouPerfil:='N';
   MudouPerfisSac:='N';
//   NrObra:='';  // 'VIMS-'
   numero:=numorc;
   NomeOrcam:=xnomeorcam;
   NumeroObra:=xnumeroobra;
   GNomeOrcam:=xnomeorcam;
//   FFormacaoPreco.Caption:='Forma��o do Pre�o de Venda - Or�amento Numero '+inttostr(numero)+' Nome : '+NomeOrcam+' Obra : '+Numeroobra;
   FFormacaoPreco.Caption:='Forma��o do Pre�o de Venda - Or�amento Numero '+inttostr(numero)+' Op��o : '+NomeOrcam+' Obra : '+Numeroobra;
   Show;

   FGeral.ConfiguraColorEditsNaoEnabled(FFormacaoPreco);
   TipoVendaProduto:='VP';
   TipoVendaServicos:='VS';
   xTipoVenda:=TipoVenda;
   PageVenda.ActivePage:=PgVenda;  //  then Edorca_custoobra.SetFirstEd
   EdNomeOrcam.enabled:=false;
   EdNomeOrcam.Visible:=false;
   SetaDescricaoTratamento(EdDescricao);
   ZeraCampos;
   ListaCustoGrupo:=TList.Create;
   valorm2:=FGeral.GetConfig1AsFloat('VLRMETRO2');
   valorm2Alimentacao:=FGeral.GetConfig1AsFloat('VLRMETRO2ALI');
   cargaveiculo:=FGeral.GetConfig1AsFloat('CARGAM2');

   Q:=sqltoquery('select * from orcamencal '+
               ' where orcc_status=''N'' and orcc_numerodoc='+inttostr(numero)+
               ' and orcc_nome='+stringtosql(nomeorcam)+
//               ' and orcc_unid_codigo='+stringtosql(Global.CodigoUnidade) );
// 29.09.10 - pode ver or�ammentos(valores) das unidades q pode acessar
//               ' and '+FGeral.GetIN('orcc_unid_codigo',Global.Usuario.UnidadesMvto,'C') );
// 04.04.11 - para mostrar cfe a unidade onde foi gravado o or�amento
               ' and '+FGeral.GetIN('orcc_unid_codigo',UnidadeObra,'C') );
   xUnidadeObra:=UnidadeObra;
// escolhar qual orcamento..se for o primeiro nome 'ORCAMENTO 01'
   Grid.clear;
   DtGrid.clear;
   DtGridM.clear;
   GridVidros.Clear;
   GridAces.Clear;
   GridTelas.Clear;
   GridPerfisSac.clear;
   SitAprovada:='F';  // fechada
   if not Q.eof then begin
     SetaBotaoAprova(Q.fieldbyname('Orcc_situacao').asString);
// 29.09.10
     unidadeorcamento:=Q.fieldbyname('orcc_unid_codigo').asstring;
     QuerytoEdits;
     QIns:=sqltoquery('select * from orcainsumos '+
               ' where orin_status=''N'' and orin_numerodoc='+inttostr(numero)+
               ' and orin_nome='+stringtosql(nomeorcam)+
//               ' and orin_unid_codigo='+stringtosql(Global.CodigoUnidade) );
               ' and orin_unid_codigo='+stringtosql(unidadeorcamento) );
     if not QINs.eof then
       BuscaDadosGrid(QIns);
     FGeral.FechaQuery(QIns);
     QTrat:=sqltoquery('select * from orcamendet'+
               ' where orcd_status=''N'' and orcd_numerodoc='+inttostr(numero)+
               ' and orcd_nome='+stringtosql(nomeorcam)+
//               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
// 29.09.10
               ' and orcd_unid_codigo='+stringtosql(unidadeorcamento)+
               ' and orcd_tipoitem=''T'''+
               ' order by orcd_codigo' );
     if not QTrat.eof then
       BuscaDadosDtGrid(QTrat,DtGrid);
     FGeral.FechaQuery(QTrat);
     QTrat:=sqltoquery('select * from orcamendet'+
               ' where orcd_status=''N'' and orcd_numerodoc='+inttostr(numero)+
               ' and orcd_nome='+stringtosql(nomeorcam)+
//               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
// 29.09.10
               ' and orcd_unid_codigo='+stringtosql(unidadeorcamento)+
               ' and orcd_tipoitem=''S'''+
               ' order by orcd_codigo' );
     if not QTrat.eof then
       BuscaDadosDtGrid(QTrat,DtGridm);
     FGeral.FechaQuery(QTrat);
     QTrat:=sqltoquery('select * from orcamendet'+
               ' where orcd_status=''N'' and orcd_numerodoc='+inttostr(numero)+
               ' and orcd_nome='+stringtosql(nomeorcam)+
//               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
               ' and orcd_unid_codigo='+stringtosql(unidadeorcamento)+
               ' and orcd_tipoitem=''A'''+
               ' order by orcd_codigo' );
     if not QTrat.eof then
       BuscaDadosDtGrid(QTrat,GridAces);
     FGeral.FechaQuery(QTrat);

     QTrat:=sqltoquery('select * from orcamendet'+
               ' where orcd_status=''N'' and orcd_numerodoc='+inttostr(numero)+
               ' and orcd_nome='+stringtosql(nomeorcam)+
//               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
               ' and orcd_unid_codigo='+stringtosql(unidadeorcamento)+
               ' and orcd_tipoitem=''S'''+
               ' order by orcd_codigo' );
     if not QTrat.eof then
       BuscaDadosDtGrid(QTrat,DtGridm);
     FGeral.FechaQuery(QTrat);
     QTrat:=sqltoquery('select * from orcamendet'+
               ' where orcd_status=''N'' and orcd_numerodoc='+inttostr(numero)+
               ' and orcd_nome='+stringtosql(nomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(unidadeorcamento)+
               ' and orcd_tipoitem=''V'''+
               ' order by orcd_codigo' );
     if not QTrat.eof then
       BuscaDadosDtGrid(QTrat,GridVidros);
     FGeral.FechaQuery(QTrat);
     QTrat:=sqltoquery('select * from orcamendet'+
               ' where orcd_status=''N'' and orcd_numerodoc='+inttostr(numero)+
               ' and orcd_nome='+stringtosql(nomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(unidadeorcamento)+
               ' and orcd_tipoitem=''C'''+
               ' order by orcd_codigo' );
     if not QTrat.eof then
       BuscaDadosDtGrid(QTrat,GridTelas);
     FGeral.FechaQuery(QTrat);
     QTrat:=sqltoquery('select * from orcamendet'+
               ' where orcd_status=''N'' and orcd_numerodoc='+inttostr(numero)+
               ' and orcd_nome='+stringtosql(nomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(unidadeorcamento)+
               ' and orcd_tipoitem=''P'''+
               ' order by orcd_codigo' );
     if not QTrat.eof then
       BuscaDadosDtGrid(QTrat,GridPerfisSac);
     FGeral.FechaQuery(QTrat);

     Calculapreco;

   end else begin

     EdOrca_CustoObra.ClearAll(FFormacaoPreco,99);
     EdOrca_Simples.ClearAll(FFormacaoPreco,99);
     EdOrca_Margem.ClearAll(FFormacaoPreco,99);
     EdVlrAcessorios.ClearAll(FFormacaoPreco,99);
     EdVlrAlimentacao.ClearAll(FFormacaoPreco,99);

     BuscaDadosPea;
     IniciaCampos(tipovenda);
     CalculaPreco;
     SetaBotaoAprova('');
   end;

   PreencheGridPrazos;
   campo:=Sistema.GetDicionario('orcamendet','orcd_tama_codigo');
   if campo.Tipo<>'' then begin
     EdCodtamanhops.enabled:=true;
     EdCodcorps.enabled:=true;
     EdPesops.enabled:=true;
   end else begin
     EdCodtamanhops.enabled:=false;
     EdCodcorps.enabled:=false;
     EdPesops.enabled:=false;
   end;
   FGeral.FechaQuery(Q);
// 06.08.13
   bajuda.Visible:=Global.Topicos[1036];
   bajuda.Enabled:=Global.Topicos[1036];
   EdOrca_CustoObra.setfocus;
end;

procedure TFFormacaoPreco.bcalculaClick(Sender: TObject);
begin
   CalculaPreco;
end;

procedure TFFormacaoPreco.EdOfertaclienteValidate(Sender: TObject);
begin
   Calculapreco;
end;

procedure TFFormacaoPreco.EdOrca_margemValidate(Sender: TObject);
begin
   if (EdOrca_margem.ascurrency>0) and (EdOrca_margem.ascurrency<FGeral.GetConfig1AsFloat('MARGEMMIN')) then
     EdOrca_margem.Invalid('Margem n�o permitida')
   else
     CalculaPreco;
end;


procedure TFFormacaoPreco.bGravarClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    condicaopost:string;
    n:integer;

    procedure SalvaGrid(op, tabela,campocodigo: string; Grid: TSqlDtGrid;colunacodigo:integer ;condicaopost: string);
    ////////////////////////////////////////////////////////////////////////////////////////////////
    var i:integer;
        xcondicao,codigo:string;
    begin
    // nao esquecer q ter� q ser um post para cada linha do grid 'somando' o codigo do produto
    // na condicaopost;;

      for i:=1 to Grid.RowCount do begin
        codigo:=Grid.Cells[colunacodigo,i];
        if trim(codigo)<>'' then begin
          xcondicao:=condicaopost+' and '+campocodigo+' = '+Stringtosql(codigo);
          if op='I' then begin
            Sistema.Insert(tabela);
            Sistema.Setfield('orin_status','N');
            Sistema.Setfield('orin_numerodoc',Numero);
            Sistema.Setfield('orin_unid_codigo',Global.CodigoUnidade);
            Sistema.Setfield('orin_nome',gnomeorcam);
          end else
            Sistema.Edit(tabela);
          Sistema.SetField(campocodigo,codigo);
          Sistema.SetField('orin_pesobruto',texttovalor( Grid.cells[Grid.GetColumn('pesobruto'),i] ) );
// 06.04.09
          Sistema.SetField('orin_pesosobra',texttovalor( Grid.cells[Grid.GetColumn('pesosobra'),i] ) );
//
          Sistema.SetField('orin_percsobrabruta',texttovalor( Grid.cells[Grid.GetColumn('percsobrabruta'),i] ) );
          Sistema.SetField('orin_percperda',texttovalor( Grid.cells[Grid.GetColumn('percperda'),i] ) );
          Sistema.SetField('orin_pesoreal',texttovalor( Grid.cells[Grid.GetColumn('pesoreal'),i] ) );
          Sistema.SetField('orin_precouni',texttovalor( Grid.cells[Grid.GetColumn('precouni'),i] ) );
          Sistema.SetField('orin_custopeca',texttovalor( Grid.cells[Grid.GetColumn('custopeca'),i] ) );
          if op='I' then
            Sistema.post()
          else
            Sistema.post(xcondicao);
        end;
      end;
    end;

begin
/////////////////////////////////////////////////////////////////////////////////////
  if trim(nomeorcam)='' then exit;
  if not EdOrca_margem.Valid then exit;
  if Global.CodigoUnidade<>xUnidadeObra then begin
    Avisoerro('N�o permitido salvar or�amento fora da unidade onde foi incluido');
    exit;
  end;
  if not confirma('Confirma grava��o') then exit;
  Q:=Sqltoquery('select * from orcamencal where orcc_numerodoc='+inttostr(numero)+
                ' and orcc_nome='+stringtosql(gnomeorcam)+
                ' and orcc_status=''N'''+
                ' and orcc_unid_codigo='+stringtosql(Global.CodigoUnidade));
  if not Q.eof then begin
    Sistema.Edit('orcamencal');
  end else begin
    Sistema.Insert('orcamencal');
    Sistema.Setfield('orcc_status','N');
    Sistema.Setfield('orcc_numerodoc',Numero);
    Sistema.Setfield('orcc_unid_codigo',Global.CodigoUnidade);
    Sistema.Setfield('orcc_nome',gnomeorcam);
  end;
  Sistema.Setfield('Orcc_venda',EdOrca_venda.AsCurrency);
  Sistema.Setfield('Orcc_custoobra',Edorca_custoobra.AsCurrency);
  Sistema.Setfield('Orcc_ofertacliente',EdOfertacliente.AsCurrency);
  Sistema.Setfield('Orcc_simples',Edorca_simples.AsCurrency);
  Sistema.Setfield('Orcc_pis',EdOrca_pis.AsCurrency);
  Sistema.Setfield('Orcc_cofins',EdOrca_cofins.AsCurrency);
  Sistema.Setfield('Orcc_ir',EdOrca_ir.AsCurrency);
  Sistema.Setfield('Orcc_cs',EdOrca_cs.AsCurrency);
  Sistema.Setfield('Orcc_comissoes',EdOrca_comissoes.AsCurrency);
  Sistema.Setfield('Orcc_icms',EdOrca_icms.AsCurrency);
  Sistema.Setfield('Orcc_reserva',EdOrca_reserva.AsCurrency);
  Sistema.Setfield('Orcc_fretes',EdOrca_fretes.AsCurrency);
  Sistema.Setfield('Orcc_custofixo',EdOrca_custofixo.AsCurrency);
  Sistema.Setfield('Orcc_margem',EdOrca_margem.AsCurrency);
  Sistema.Setfield('Orcc_desconto01',EdDesconto01.AsCurrency);
  Sistema.Setfield('Orcc_desconto02',EdDesconto02.AsCurrency);
// 08.05.09 - agora componentes
  Sistema.Setfield('Orcc_acessorios',EdVlracessorios.AsCurrency+EdVlrpersianas.ascurrency);
// 11.02.09
  Sistema.Setfield('Orcc_motorizacao',EdVlrmotorizacao.ascurrency );
  Sistema.Setfield('Orcc_cremonas',EdVlrcremonas.ascurrency );
  Sistema.Setfield('Orcc_persianas',EdVlrpersianas.ascurrency );
// 16.02.09
  Sistema.Setfield('Orcc_alimentacao',EdVlralimentacao.ascurrency );
  Sistema.Setfield('Orcc_estadia',EdVlrestadia.ascurrency );
  Sistema.Setfield('Orcc_km',Edkm.asinteger);
  Sistema.Setfield('Orcc_desloca',EdVlrdeslocamento.ascurrency );
// 20.02.09
  Sistema.Setfield('Orcc_pesoliquido',EdPesoliquido.ascurrency );
  Sistema.Setfield('Orcc_geralprod',EdPercproducao.ascurrency );
// 27.02.09
  Sistema.Setfield('Orcc_margemcli',EdOrca_margemcli.AsCurrency);
// 09.07.09
  Sistema.Setfield('Orcc_reflexocom',EdReflexocom.AsCurrency);
// 12.08.09
  Sistema.Setfield('Orcc_fpgt_codigo',EdFpgto_codigo.text);
  Sistema.Setfield('Orcc_vlrentrada',EdVlrEntrada.ascurrency);
  Sistema.Setfield('Orcc_nparcelas',EdNparcelas.asinteger);
  Sistema.Setfield('Orcc_percjurosfin',EdPercJuros.ascurrency);
  Sistema.Setfield('Orcc_mesescare',EdCarencia.asinteger);
  Sistema.Setfield('orcc_vendaobrafinal',Edvlrvendafinal.AsCurrency);
// 10.09.10
  Sistema.Setfield('Orcc_construcard',Edorca_construcard.AsCurrency);

/////////////////////
  if not Q.eof then begin
    Sistema.post('orcc_numerodoc='+inttostr(numero)+' and orcc_nome='+stringtosql(gnomeorcam)+
               ' and orcc_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and orcc_status=''N''');
    condicaopost:='orin_numerodoc='+inttostr(numero)+' and orin_nome='+stringtosql(gnomeorcam)+
               ' and orin_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and orin_status=''N''';

   if MudouPerfil='S' then begin
     Sistema.edit('orcainsumos');
     Sistema.SetField('orin_status','C');
     Sistema.post('orin_numerodoc='+inttostr(numero)+' and orin_nome='+stringtosql(gnomeorcam)+
                  ' and orin_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and orin_status=''N''');
//     SalvaGrid('A','orcainsumos','orin_esto_codigo',Grid,0,condicaopost);
     SalvaGrid('I','orcainsumos','orin_esto_codigo',Grid,0,condicaopost);
   end;
  end else begin
    Sistema.post();
    SalvaGrid('I','orcainsumos','orin_esto_codigo',Grid,0,'');
  end;
  if MudouTratamento='S' then begin
     Sistema.edit('orcamendet');
     Sistema.SetField('orcd_status','C');
     Sistema.post('orcd_numerodoc='+inttostr(numero)+' and orcd_nome='+stringtosql(gnomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and orcd_status=''N'''+
               ' and orcd_tipoitem=''T''');
     for n:=1 to DtGrid.RowCount do begin
       if trim(DtGrid.cells[DtGrid.getcolumn('orcd_codigo'),n])<>'' then begin
         Sistema.insert('orcamendet');
         Sistema.Setfield('orcd_status','N');
         Sistema.Setfield('orcd_numerodoc',Numero);
         Sistema.Setfield('orcd_unid_codigo',Global.CodigoUnidade);
         Sistema.Setfield('orcd_nome',gnomeorcam);
         Sistema.SetField('orcd_codigo',DtGrid.Cells[DtGrid.getcolumn('orcd_codigo'),n]);
         Sistema.SetField('orcd_descricao',DtGrid.Cells[DtGrid.getcolumn('orcd_descricao'),n]);
         Sistema.SetField('orcd_unidade',DtGrid.Cells[DtGrid.getcolumn('orcd_unidade'),n]);
         Sistema.SetField('orcd_qtde',Texttovalor( DtGrid.Cells[DtGrid.getcolumn('orcd_qtde'),n]) );
         Sistema.SetField('orcd_unitario',Texttovalor( DtGrid.Cells[DtGrid.getcolumn('orcd_unitario'),n]) );
         Sistema.SetField('orcd_tipoitem','T');
         Sistema.Post();
       end;
     end;
  end;
// 30.04.09
  if MudouVidro='S' then begin
     Sistema.edit('orcamendet');
     Sistema.SetField('orcd_status','C');
     Sistema.post('orcd_numerodoc='+inttostr(numero)+' and orcd_nome='+stringtosql(gnomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and orcd_status=''N'''+
               ' and orcd_tipoitem=''V''');
     for n:=1 to GridVidros.RowCount do begin
       if trim(GridVidros.cells[GridVidros.getcolumn('orcd_codigo'),n])<>'' then begin
         Sistema.insert('orcamendet');
         Sistema.Setfield('orcd_status','N');
         Sistema.Setfield('orcd_numerodoc',Numero);
         Sistema.Setfield('orcd_unid_codigo',Global.CodigoUnidade);
         Sistema.Setfield('orcd_nome',gnomeorcam);
         Sistema.SetField('orcd_codigo',GridVidros.Cells[GridVidros.getcolumn('orcd_codigo'),n]);
         Sistema.SetField('orcd_descricao',GridVidros.Cells[GridVidros.getcolumn('orcd_descricao'),n]);
         Sistema.SetField('orcd_unidade',GridVidros.Cells[GridVidros.getcolumn('orcd_unidade'),n]);
         Sistema.SetField('orcd_qtde',Texttovalor( GridVidros.Cells[GridVidros.getcolumn('orcd_qtde'),n]) );
         Sistema.SetField('orcd_unitario',Texttovalor( GridVidros.Cells[GridVidros.getcolumn('orcd_unitario'),n]) );
         Sistema.SetField('orcd_tipoitem','V');
         Sistema.Post();
       end;
     end;
  end;
// 04.05.09
  if MudouAcessorios='S' then begin
     Sistema.edit('orcamendet');
     Sistema.SetField('orcd_status','C');
     Sistema.post('orcd_numerodoc='+inttostr(numero)+' and orcd_nome='+stringtosql(gnomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and orcd_status=''N'''+
               ' and orcd_tipoitem=''A''');
     for n:=1 to GridAces.RowCount do begin
       if trim(GridAces.cells[GridAces.getcolumn('orcd_codigo'),n])<>'' then begin
         Sistema.insert('orcamendet');
         Sistema.Setfield('orcd_status','N');
         Sistema.Setfield('orcd_numerodoc',Numero);
         Sistema.Setfield('orcd_unid_codigo',Global.CodigoUnidade);
         Sistema.Setfield('orcd_nome',gnomeorcam);
         Sistema.SetField('orcd_codigo',GridAces.Cells[GridAces.getcolumn('orcd_codigo'),n]);
         Sistema.SetField('orcd_descricao',GridAces.Cells[GridAces.getcolumn('orcd_descricao'),n]);
         Sistema.SetField('orcd_unidade',GridAces.Cells[GridAces.getcolumn('orcd_unidade'),n]);
         Sistema.SetField('orcd_qtde',Texttovalor( GridAces.Cells[GridAces.getcolumn('orcd_qtde'),n]) );
         Sistema.SetField('orcd_unitario',Texttovalor( GridAces.Cells[GridAces.getcolumn('orcd_unitario'),n]) );
         Sistema.SetField('orcd_tipoitem','A');
         Sistema.Post();
       end;
     end;
  end;
// 04.05.09
  if MudouTela='S' then begin
     Sistema.edit('orcamendet');
     Sistema.SetField('orcd_status','C');
     Sistema.post('orcd_numerodoc='+inttostr(numero)+' and orcd_nome='+stringtosql(gnomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and orcd_status=''N'''+
               ' and orcd_tipoitem=''C''');
     for n:=1 to GridTelas.RowCount do begin
       if trim(GridTelas.cells[GridTelas.getcolumn('orcd_codigo'),n])<>'' then begin
         Sistema.insert('orcamendet');
         Sistema.Setfield('orcd_status','N');
         Sistema.Setfield('orcd_numerodoc',Numero);
         Sistema.Setfield('orcd_unid_codigo',Global.CodigoUnidade);
         Sistema.Setfield('orcd_nome',gnomeorcam);
         Sistema.SetField('orcd_codigo',GridTelas.Cells[GridTelas.getcolumn('orcd_codigo'),n]);
         Sistema.SetField('orcd_descricao',GridTelas.Cells[GridTelas.getcolumn('orcd_descricao'),n]);
         Sistema.SetField('orcd_unidade',GridTelas.Cells[GridTelas.getcolumn('orcd_unidade'),n]);
         Sistema.SetField('orcd_qtde',Texttovalor( GridTelas.Cells[GridTelas.getcolumn('orcd_qtde'),n]) );
         Sistema.SetField('orcd_unitario',Texttovalor( GridTelas.Cells[GridTelas.getcolumn('orcd_unitario'),n]) );
         Sistema.SetField('orcd_tipoitem','C');
         Sistema.Post();
       end;
     end;
  end;

  if MudouMaoDeObra='S' then begin
     Sistema.edit('orcamendet');
     Sistema.SetField('orcd_status','C');
     Sistema.post('orcd_numerodoc='+inttostr(numero)+' and orcd_nome='+stringtosql(gnomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and orcd_status=''N'''+
               ' and orcd_tipoitem=''S''');
     for n:=1 to DtGridm.RowCount do begin
       if trim(DtGridm.cells[DtGridm.getcolumn('orcd_codigo'),n])<>'' then begin
         Sistema.insert('orcamendet');
         Sistema.Setfield('orcd_status','N');
         Sistema.Setfield('orcd_numerodoc',Numero);
         Sistema.Setfield('orcd_unid_codigo',Global.CodigoUnidade);
         Sistema.Setfield('orcd_nome',gnomeorcam);
         Sistema.SetField('orcd_codigo',DtGridm.Cells[DtGridm.getcolumn('orcd_codigo'),n]);
         Sistema.SetField('orcd_descricao',DtGridm.Cells[DtGridm.getcolumn('orcd_descricao'),n]);
         Sistema.SetField('orcd_unidade',DtGridm.Cells[DtGridm.getcolumn('orcd_unidade'),n]);
         Sistema.SetField('orcd_qtde',Texttovalor( DtGridm.Cells[DtGridm.getcolumn('orcd_qtde'),n]) );
         Sistema.SetField('orcd_unitario',Texttovalor( DtGridm.Cells[DtGridm.getcolumn('orcd_unitario'),n]) );
         Sistema.SetField('orcd_tipoitem','S');
         Sistema.Post();
       end;
     end;
  end;
// 17.07.13 - Perfis Sac - Metalforte
  if MudouPerfisSac='S' then begin
     Sistema.edit('orcamendet');
     Sistema.SetField('orcd_status','C');
     Sistema.post('orcd_numerodoc='+inttostr(numero)+' and orcd_nome='+stringtosql(gnomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and orcd_status=''N'''+
               ' and orcd_tipoitem=''P''');
     for n:=1 to GridPerfisSac.RowCount do begin
       if trim(GridPerfisSac.cells[GridAces.getcolumn('orcd_codigo'),n])<>'' then begin
         Sistema.insert('orcamendet');
         Sistema.Setfield('orcd_status','N');
         Sistema.Setfield('orcd_numerodoc',Numero);
         Sistema.Setfield('orcd_unid_codigo',Global.CodigoUnidade);
         Sistema.Setfield('orcd_nome',gnomeorcam);
         Sistema.SetField('orcd_codigo',GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_codigo'),n]);
         Sistema.SetField('orcd_descricao',GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_descricao'),n]);
         Sistema.SetField('orcd_unidade',GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_unidade'),n]);
         Sistema.SetField('orcd_qtde',Texttovalor( GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_qtde'),n]) );
         Sistema.SetField('orcd_unitario',Texttovalor( GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_unitario'),n]) );
// 19.07.13
         if campo.Tipo<>'' then begin
           Sistema.SetField('orcd_peso',Texttovalor( GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_peso'),n]) );
           Sistema.SetField('orcd_tama_codigo',strtointdef(GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_tama_codigo'),n],0));
           Sistema.SetField('orcd_core_codigo',strtointdef(GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_core_codigo'),n],0));
         end;
         Sistema.SetField('orcd_tipoitem','P');
         Sistema.Post();
       end;
     end;
  end;

// 04.05.09
  if MudouAcessorios='S' then begin
     Sistema.edit('orcamendet');
     Sistema.SetField('orcd_status','C');
     Sistema.post('orcd_numerodoc='+inttostr(numero)+' and orcd_nome='+stringtosql(gnomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and orcd_status=''N'''+
               ' and orcd_tipoitem=''A''');
     for n:=1 to GridAces.RowCount do begin
       if trim(GridAces.cells[GridAces.getcolumn('orcd_codigo'),n])<>'' then begin
         Sistema.insert('orcamendet');
         Sistema.Setfield('orcd_status','N');
         Sistema.Setfield('orcd_numerodoc',Numero);
         Sistema.Setfield('orcd_unid_codigo',Global.CodigoUnidade);
         Sistema.Setfield('orcd_nome',gnomeorcam);
         Sistema.SetField('orcd_codigo',GridAces.Cells[GridAces.getcolumn('orcd_codigo'),n]);
         Sistema.SetField('orcd_descricao',GridAces.Cells[GridAces.getcolumn('orcd_descricao'),n]);
         Sistema.SetField('orcd_unidade',GridAces.Cells[GridAces.getcolumn('orcd_unidade'),n]);
         Sistema.SetField('orcd_qtde',Texttovalor( GridAces.Cells[GridAces.getcolumn('orcd_qtde'),n]) );
         Sistema.SetField('orcd_unitario',Texttovalor( GridAces.Cells[GridAces.getcolumn('orcd_unitario'),n]) );
         Sistema.SetField('orcd_tipoitem','A');
         Sistema.Post();
       end;
     end;
  end;
//////////////
// 08.07.10 - Atualiza o 'or�amento base' quando salva - Adriano+Marcelo
  Sistema.Edit('Orcamentos');
  Sistema.Setfield('orca_valor',EdOrca_venda.AsCurrency);
  Sistema.Post('orca_numerodoc='+inttostr(numero)+
               ' and orca_unid_codigo='+stringtosql(Global.CodigoUnidade)+
               ' and orca_status=''N''' );
/////
  try
    FFormacaoPreco.Caption:='Forma��o do Pre�o de Venda - Or�amento Numero '+inttostr(numero)+' Nome : '+GNomeOrcam;
    Sistema.commit;
// 25.08.09
    FGeral.GravaLog(22,'Op��o '+GNomeOrcam+' Or�amento '+inttostr(numero)+' Obra '+NumeroObra,true );
    Aviso('Informa��es gravadas');
  except
    Avisoerro('N�o foi poss�vel gravar as informa��es');
  end;
  FGeral.FechaQuery(Q);
end;

procedure TFFormacaoPreco.EdDesconto01Validate(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
  if Eddesconto01.ascurrency>3 then
    EdDesconto01.Invalid('Desconto m�ximo ultrapassado')
  else
    CalculaPreco;
end;

procedure TFFormacaoPreco.bsalvarcomoClick(Sender: TObject);
begin
   if baprova.Tag=1 then begin
     Avisoerro('Op��o de or�amento aprovada n�o pode ser copiada');
   end else begin
     EdNomeOrcam.enabled:=true;
     EdNomeOrcam.Visible:=true;
     EdNomeOrcam.setfocus;
   end;
end;

procedure TFFormacaoPreco.EdNomeorcamExitEdit(Sender: TObject);
begin
   GNOmeOrcam:=EdNOmeorcam.text;
   EdNomeOrcam.enabled:=false;
   EdNomeOrcam.Visible:=false;
   bgravarclick(self);

end;

procedure TFFormacaoPreco.EdNomeorcamKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#27 then begin
    EdNomeOrcam.enabled:=false;
    EdNomeOrcam.Visible:=false;
  end;

end;

procedure TFFormacaoPreco.EdNomeorcamValidate(Sender: TObject);
begin
//   if EdNomeorcam.text=GNomeOrcam then
   if EdNomeorcam.text=NomeOrcam then
     EdNomeOrcam.invalid('Nome n�o pode ser o mesmo do or�amento atual');
end;

procedure TFFormacaoPreco.bmudaClick(Sender: TObject);
var Q:TSqlquery;
begin
  OPOrcam:='M';
  Q:=sqltoquery('select orcc_numerodoc,orcc_nome from orcamencal '+
               ' where orcc_status=''N'' and orcc_numerodoc='+inttostr(numero)+
               ' and orcc_unid_codigo='+stringtosql(Global.CodigoUnidade));
  EdOrcam.Items.Clear;
  while not Q.eof do begin
    EdOrcam.Items.Add(Q.fieldbyname('orcc_nome').asstring);
    q.Next;
  end;
  FGeral.FechaQuery(Q);
   EdOrcam.enabled:=true;
   EdOrcam.Visible:=true;
   EdOrcam.setfocus;

end;

procedure TFFormacaoPreco.EdOrcamKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then begin
    EdOrcam.enabled:=false;
    EdOrcam.Visible:=false;
  end;

end;

procedure TFFormacaoPreco.EdOrcamExitEdit(Sender: TObject);
begin
  if OPOrcam='M' then begin
    EdOrcam.enabled:=false;
    EdOrcam.Visible:=false;
    Execute(numero,EdOrcam.text,NumeroObra,xUnidadeObra,xTipoVenda);
  end else begin
    if not confirma('Excluir planilha '+EdOrcam.text+' da obra '+Numeroobra) then exit;
    Sistema.beginprocess('Excluindo');
    Sistema.edit('orcamencal');
    Sistema.SetField('orcc_status','C');
    Sistema.post('orcc_numerodoc='+inttostr(numero)+' and orcc_nome='+stringtosql(EdOrcam.text)+
                 ' and orcc_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and orcc_status=''N''');
    Sistema.edit('orcainsumos');
    Sistema.SetField('orin_status','C');
    Sistema.post('orin_numerodoc='+inttostr(numero)+' and orin_nome='+stringtosql(EdOrcam.text)+
                 ' and orin_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and orin_status=''N''');
    try
      Sistema.Commit;
      Sistema.endprocess('Excluido');
    except
      Sistema.endprocess('Exclus�o n�o efetuada.  Problemas no banco de dados');
    end;
    EdOrcam.enabled:=false;
    EdOrcam.Visible:=false;
    Close;
  end;

end;

procedure TFFormacaoPreco.BuscaDadosPea;
var localexterno,obra:string;
begin
//    localexterno:=FGeral.Getconfig1asstring('localpea');
    localexterno:=FGeral.GetLocalExternoPea;
    if trim(localexterno)='' then begin
      Avisoerro('Falta configurar o local do PEA na configura��o geral do sistema');
      exit;
    end else begin
      ListaP:=tList.Create;
      dbforcam.FileName:=localexterno+'PERF.DBF';
      try
        dbforcam.Open;
      except
        Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
        exit;
      end;
      Sistema.beginprocess('Pesquisando cadastro de perfis '+dbforcam.FileName);
      while  not dbforcam.Eof do begin
        New(PPerfis);
        PPerfis.codigo:=dbforcam.FieldByName('codigo').asstring;
        PPerfis.prenativo:=dbforcam.FieldByName('prenat').asstring;
        ListaP.Add(PPerfis);
        dbforcam.Next;
      end;
      dbforcam.close;
      Sistema.endprocess('');

      dbforcam.FileName:=localexterno+'OBAPROV.DBF';
      try
        dbforcam.Open;
      except
        Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
        exit;
      end;
      Sistema.beginprocess('Pesquisando obra '+NumeroObra);
//      obra:=NrObra+Numeroobra;
// 15.06.09
      obra:=Numeroobra;
      ListaCodigos:=TStringList.create;
      while  not dbforcam.Eof do begin
        if dbforcam.FieldByName('codigo').asstring=obra then
          CamposdbftoGrid(Grid);
        dbforcam.Next;
      end;
      dbforcam.close;
      ListaCodigos.free;
// 18.12.08
      dbforcam.FileName:=localexterno+'OBCALCA.DBF';
      try
        dbforcam.Open;
      except
        Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
        exit;
      end;
      Sistema.beginprocess('Pesquisando acess�rios obra '+NumeroObra);
//      obra:=NrObra+Numeroobra;
      obra:=Numeroobra;
      Vlracessorios:=0;Vlrmotorizacao:=0;Vlrpersianas:=0;
      while  not dbforcam.Eof do begin
        if dbforcam.FieldByName('codigo').asstring=obra then begin
          if (Ansipos( copy(dbforcam.fieldbyname('CODACES').asstring,1,3),FGeral.GetConfig1AsString('REFPERSIANAS') )>0) and ( trim(FGeral.GetConfig1AsString('REFPERSIANAS'))<>'')
            then
//            vlrpersianas:=vlrpersianas+(dbforcam.fieldbyname('qtde').asfloat*dbforcam.fieldbyname('custo').asfloat)
            vlrpersianas:=vlrpersianas+(dbforcam.fieldbyname('custo').asfloat)
          else if (Ansipos( copy(dbforcam.fieldbyname('CODACES').asstring,1,3),FGeral.GetConfig1AsString('REFMOTORI') )>0) and ( trim(FGeral.GetConfig1AsString('REFMOTORI'))<>'' )
            then
//            vlrmotorizacao:=vlrmotorizacao+(dbforcam.fieldbyname('qtde').asfloat*dbforcam.fieldbyname('custo').asfloat)
            vlrmotorizacao:=vlrmotorizacao+(dbforcam.fieldbyname('custo').asfloat)
          else
//            Vlracessorios:=Vlracessorios+ (dbforcam.fieldbyname('qtde').asfloat*dbforcam.fieldbyname('custo').asfloat) ;
            Vlracessorios:=Vlracessorios+ (dbforcam.fieldbyname('custo').asfloat) ;
        end;
        dbforcam.Next;
      end;
      dbforcam.close;
      EdVlracessorios.setvalue(vlracessorios+vlrpersianas);
      EdVlrmotorizacao.setvalue(vlrmotorizacao);
//      EdVlrpersianas.setvalue(vlrpersianas);
      Sistema.endprocess('');
//      EdOrca_custoobra.SetValue(CustoObra);
    end;

end;

procedure TFFormacaoPreco.CamposdbftoGrid(Grid:TSqlDtgrid);
///////////////////////////////////////////////////////////
var linhagrid,i:integer;
    prenativo:string;
begin
  linhagrid:=1;
  for i:=1 to Grid.RowCount do begin
    if trim( Grid.cells[grid.getcolumn('pesobruto'),i])='' then  begin
      linhagrid:=i;
      break;
    end;
  end;
  prenativo:=GetPreNativo(trim(dbforcam.fieldbyname('CODPERF').asstring));
  if ListaCodigos.indexof(prenativo)=-1 then begin
//  if ListaCodigos.indexof(trim(dbforcam.fieldbyname('ID').asstring))=-1 then begin
//    ListaCodigos.Add( trim(dbforcam.fieldbyname('ID').asstring) );
//    Grid.Cells[Grid.getcolumn('id'),linhagrid]:=dbforcam.fieldbyname('ID').asstring;
// 25.11.08
    ListaCodigos.Add( prenativo );
    Grid.Cells[Grid.getcolumn('id'),linhagrid]:=prenativo;
    Grid.Cells[Grid.getcolumn('pesobruto'),linhagrid]:=dbforcam.fieldbyname('PESOBRUTO').asstring;
    Grid.Cells[Grid.getcolumn('pesosobra'),linhagrid]:=dbforcam.fieldbyname('PESOSOBRA').asstring;
//    Grid.Cells[Grid.getcolumn('PERCSOBRABRUTA'),linhagrid]:=dbforcam.fieldbyname('PCTSOBRA').asstring;
//    Grid.Cells[Grid.getcolumn('PERCPERDA'),linhagrid]:=dbforcam.fieldbyname('PCTSOBRA').asstring;
// 15.06.09
    if dbforcam.fieldbyname('PESOBRUTO').asfloat>0 then begin
      Grid.Cells[Grid.getcolumn('PERCSOBRABRUTA'),linhagrid]:=
          Transform( (texttovalor(Grid.Cells[Grid.getcolumn('pesoSOBRA'),linhagrid])/Texttovalor(Grid.Cells[Grid.getcolumn('pesobruto'),linhagrid]))*100 , f_cr );

      Grid.Cells[Grid.getcolumn('PERCPERDA'),linhagrid]:=
           Transform( (texttovalor(Grid.Cells[Grid.getcolumn('pesoSOBRA'),linhagrid])/Texttovalor(Grid.Cells[Grid.getcolumn('pesobruto'),linhagrid]))*100 , F_cr );
    end;
    Grid.Cells[Grid.getcolumn('PESOREAL'),linhagrid]:=dbforcam.fieldbyname('PESOBRUTO').asstring;
    if dbforcam.fieldbyname('PESOBRUTO').asfloat>0 then
      Grid.Cells[Grid.getcolumn('precouni'),linhagrid]:=formatfloat('##0.000',dbforcam.fieldbyname('CUSTOPERF').asfloat/dbforcam.fieldbyname('PESOBRUTO').asfloat)
    else
      Grid.Cells[Grid.getcolumn('precouni'),linhagrid]:='';
    Grid.Cells[Grid.getcolumn('custopeca'),linhagrid]:=formatfloat('#,##0.00',Texttovalor(Grid.Cells[Grid.getcolumn('precouni'),linhagrid])*Texttovalor(Grid.Cells[Grid.getcolumn('pesoreal'),linhagrid]) );
    Grid.AppendRow;
    custoobra:=custoobra+Texttovalor(Grid.Cells[Grid.getcolumn('precouni'),linhagrid])*Texttovalor(Grid.Cells[Grid.getcolumn('pesoreal'),linhagrid]);
    TotalPesoBruto:=TotalPesoBruto+Texttovalor(Grid.Cells[Grid.getcolumn('pesobruto'),linhagrid]);
    TotalPesoReal:=TotalPesoReal+Texttovalor(Grid.Cells[Grid.getcolumn('pesoreal'),linhagrid]);
  end else begin
    for i:=1 to Grid.RowCount do begin
//      if trim( Grid.cells[grid.getcolumn('ID'),i])=dbforcam.fieldbyname('ID').asstring then  begin
      if trim( Grid.cells[grid.getcolumn('ID'),i])=prenativo then  begin
        Grid.Cells[Grid.getcolumn('pesobruto'),i]:=floattostr( texttovalor(Grid.Cells[Grid.getcolumn('pesobruto'),i])+
           dbforcam.fieldbyname('PESOBRUTO').asfloat );
        Grid.Cells[Grid.getcolumn('pesoSOBRA'),i]:=floattostr( texttovalor(Grid.Cells[Grid.getcolumn('pesoSOBRA'),i])+
           dbforcam.fieldbyname('PESOSOBRA').asfloat );
        Grid.Cells[Grid.getcolumn('pesoreal'),i]:=floattostr( texttovalor(Grid.Cells[Grid.getcolumn('pesobruto'),i]) );
        custoobra:=custoobra+Texttovalor(Grid.Cells[Grid.getcolumn('precouni'),i])*Texttovalor(Grid.Cells[Grid.getcolumn('pesoreal'),i]);
        TotalPesoBruto:=TotalPesoBruto+Texttovalor(Grid.Cells[Grid.getcolumn('pesobruto'),i]);
        TotalPesoReal:=TotalPesoReal+Texttovalor(Grid.Cells[Grid.getcolumn('pesoreal'),i]);
// 15.06.09        
        if Texttovalor(Grid.Cells[Grid.getcolumn('pesobruto'),i])>0 then begin
          Grid.Cells[Grid.getcolumn('PERCSOBRABRUTA'),i]:=
            Transform( (texttovalor(Grid.Cells[Grid.getcolumn('pesoSOBRA'),i])/Texttovalor(Grid.Cells[Grid.getcolumn('pesobruto'),i]))*100 ,f_cr);
          Grid.Cells[Grid.getcolumn('PERCPERDA'),i]:=
            Transform( (texttovalor(Grid.Cells[Grid.getcolumn('pesoSOBRA'),i])/Texttovalor(Grid.Cells[Grid.getcolumn('pesobruto'),i]))*100 ,f_cr);
        end;
        break;
      end;
    end;
  end;
end;

procedure TFFormacaoPreco.GridDblClick(Sender: TObject);
begin
  if Grid.GetColumn('percperda')=Grid.col then begin
    EdPercperda.Top:=Grid.TopEdit;
    EdPercperda.Left:=Grid.LeftEdit;
    Edpercperda.Enabled:=true;
    Edpercperda.Visible:=true;
    Edpercperda.setvalue(Texttovalor(Grid.Cells[Grid.getcolumn('percperda'),Grid.row]));
    EdPercperda.setfocus;
  end else if (Grid.GetColumn('precouni')=Grid.col) and (Global.Usuario.OutrosAcessos[0047]) then begin
    EdUnitario.Top:=Grid.TopEdit;
    EdUnitario.Left:=Grid.LeftEdit;
    EdUnitario.Enabled:=true;
    EdUnitario.Visible:=true;
    EdUnitario.setvalue(Texttovalor(Grid.Cells[Grid.getcolumn('precouni'),Grid.row]));
    EdUnitario.setfocus;

  end;
end;

procedure TFFormacaoPreco.GridKeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
     Grid.OnDblClick(self);
end;

procedure TFFormacaoPreco.EdpercperdaExitEdit(Sender: TObject);
var pesoreal:extended;
begin
   Edpercperda.Enabled:=false;
   Edpercperda.Visible:=false;
   if Edpercperda.ascurrency>=0 then begin
    pesoreal:=Texttovalor(Grid.Cells[Grid.getcolumn('PESOBRUTO'),Grid.row]) -
    Texttovalor(Grid.Cells[Grid.getcolumn('PESOBRUTO'),Grid.row])*((Texttovalor(Grid.Cells[Grid.getcolumn('PERCSOBRABRUTA'),Grid.row]) -EdPercperda.ascurrency))/100;
    Grid.Cells[Grid.getcolumn('percperda'),Grid.row]:=formatfloat('##0.00',Edpercperda.ascurrency);
    Grid.Cells[Grid.getcolumn('PESOREAL'),Grid.row]:=formatfloat('##,##0.00',pesoreal);
    Grid.Cells[Grid.getcolumn('custopeca'),Grid.row]:=formatfloat('##,##0.000',Texttovalor(Grid.Cells[Grid.getcolumn('precouni'),Grid.row])*Texttovalor(Grid.Cells[Grid.getcolumn('pesoreal'),Grid.row]) );
   end;
   Grid.setfocus;
end;

///////////////////////////////////////////////////////////////////
procedure TFFormacaoPreco.CalculaCustoObra;
///////////////////////////////////////////////////////////////////
var i,conta:integer;
    totaltrata,totalinsumos,totalmaodeobra,totalpesosobra,totmediaperda,totalpesoreal,
    totalvidros,totalaces,totaltelas,totalps:currency;

    procedure Acumula(codproduto:string ; valor:currency);
    ////////////////////////////////////////////////////
    var p,codgrupo:integer;
        achou:boolean;
        QG:TSqlquery;
    begin
      achou:=false;
      if codproduto<>'MO' then begin
        codGrupo:=FEstoque.GetGrupo(codproduto);
        QG:=sqltoquery('select * from grupos where grup_codigo='+inttostr(codgrupo));
      end else
        codgrupo:=999;
      for p:=0 to ListaCustoGrupo.Count-1 do begin
         PCustoGrupo:=ListacustoGrupo[p];
         if PCustogrupo.codgrupo=codgrupo then begin
             achou:=true;
             break;
         end;
      end;
      if not achou then begin
        New(PCustoGrupo);
        if codproduto<>'MO' then begin
          PCustoGrupo.codgrupo:=QG.fieldbyname('grup_codigo').AsInteger;
          PCustoGrupo.custo:=valor;
          PCustoGrupo.markup:=QG.fieldbyname('Grup_markup').AsCurrency;
          PCustoGrupo.margem:=QG.fieldbyname('Grup_margem').AsCurrency;
        end else begin
          PCustoGrupo.codgrupo:=999;
          PCustoGrupo.custo:=valor;
          PCustoGrupo.markup:=FGeral.GetConfig1AsFloat('MARGEMMOORCA');
          PCustoGrupo.margem:=FGeral.GetConfig1AsFloat('MARGEMMOORCA');
        end;
        ListacustoGrupo.Add(PCustoGrupo)
      end else PCustoGrupo.custo:=PCustoGrupo.custo+valor;
      FGeral.FechaQuery(QG);
    end;

    function SomaCustoporGrupo:currency;
    ////////////////////////////////////
    var x:integer;
        xcusto:currency;
    begin
      xcusto:=0;
      ReMargensporgrupo.Clear;
      ReMargensporgrupo.Lines.Add('Margem  Grupo');
      ReMargensporgrupo.Lines.Add('------------------------------------------------');
      for x:=0 to ListaCustoGrupo.Count-1 do begin
         PCustoGrupo:=ListacustoGrupo[x];
         xcusto:=xcusto+PCustoGrupo.custo;
         if Pcustogrupo.codgrupo=999 then
           ReMargensporgrupo.Lines.Add('  '+currtostr(FGeral.GetConfig1AsFloat('MARGEMMOORCA'))+'%     '+inttostr(Pcustogrupo.codgrupo)+' - M�o de Obra')
//  ver como identificar a obra como revenda ou 'obra'
         else if FOrcamentos.Edorca_tipovenda.text='Revenda' then
           ReMargensporgrupo.Lines.Add('  '+currtostr(Pcustogrupo.markup)+'%     '+inttostr(Pcustogrupo.codgrupo)+' - '+FGrupos.GetDescricao(Pcustogrupo.codgrupo))
         else
           ReMargensporgrupo.Lines.Add('  '+currtostr(Pcustogrupo.margem)+'%     '+inttostr(Pcustogrupo.codgrupo)+' - '+FGrupos.GetDescricao(Pcustogrupo.codgrupo));
         ReMargensporgrupo.Lines.Add('------------------------------------------------');
      end;
      result:=xcusto;
    end;

//////////////////////////////////////////////////////////////////////////////
begin
//////////////////////////////////////////////////////////////////////////////
  custoobra:=0;totalpeso:=0;TotalPesoBruto:=0;TotalPesoReal:=0;totalpesosobra:=0;
  totalinsumos:=0;totalmaodeobra:=0;totmediaperda:=0;totalpesoreal:=0;
  conta:=0;CustoObraServicos:=0;CustoObraServicosSEM:=0;totalps:=0;
  ListaCustoGrupo.Clear;

  for i:=1 to Grid.rowcount do begin
    if trim(Grid.cells[Grid.getcolumn('ID'),i])<>'' then begin
      inc(conta);
      custoobra:=custoobra+Texttovalor(Grid.Cells[Grid.getcolumn('precouni'),i])*Texttovalor(Grid.Cells[Grid.getcolumn('pesoreal'),i]);
      totalpeso:=totalpeso+Texttovalor(Grid.Cells[Grid.getcolumn('pesobruto'),i]);
      TotalPesoBruto:=TotalPesoBruto+Texttovalor(Grid.Cells[Grid.getcolumn('pesobruto'),i]);
      TotalPesoReal:=TotalPesoReal+Texttovalor(Grid.Cells[Grid.getcolumn('pesoreal'),i]);
      TotalPesoSobra:=TotalPesoSobra+Texttovalor(Grid.Cells[Grid.getcolumn('pesosobra'),i]);
      totmediaperda:=totmediaperda++Texttovalor(Grid.Cells[Grid.getcolumn('percperda'),i]);
      totalinsumos:=totalinsumos+Texttovalor(Grid.Cells[Grid.getcolumn('precouni'),i])*Texttovalor(Grid.Cells[Grid.getcolumn('pesoreal'),i]);
    end;
  end;
  if conta>0 then
    totmediaperda:=totmediaperda/conta;

  totaltrata:=0;
  for i:=1 to DtGrid.rowcount do begin
    if trim(dtGrid.cells[DtGrid.getcolumn('orcd_codigo'),i])<>'' then begin
      custoobra:=custoobra+Texttovalor(DtGrid.Cells[DtGrid.getcolumn('orcd_unitario'),i])*Texttovalor(DtGrid.Cells[DtGrid.getcolumn('orcd_qtde'),i]);
      totaltrata:=totaltrata+Texttovalor(DtGrid.Cells[DtGrid.getcolumn('orcd_unitario'),i])*Texttovalor(DtGrid.Cells[DtGrid.getcolumn('orcd_qtde'),i]);
    end;
  end;
  totalvidros:=0;
  for i:=1 to GridVidros.rowcount do begin
    if trim(GridVidros.cells[GridVidros.getcolumn('orcd_codigo'),i])<>'' then begin
      totalvidros:=totalvidros+Texttovalor(GridVidros.Cells[DtGrid.getcolumn('orcd_unitario'),i])*Texttovalor(GridVidros.Cells[GridVidros.getcolumn('orcd_qtde'),i]);
      if Global.Topicos[1501] then
        Acumula(GridVidros.cells[GridVidros.getcolumn('orcd_codigo'),i],Texttovalor(GridVidros.Cells[GridVidros.getcolumn('orcd_unitario'),i])*Texttovalor(GridVidros.Cells[GridVidros.getcolumn('orcd_qtde'),i]))
      else
        custoobra:=custoobra+Texttovalor(GridVidros.Cells[GridVidros.getcolumn('orcd_unitario'),i])*Texttovalor(GridVidros.Cells[GridVidros.getcolumn('orcd_qtde'),i]);
    end;
  end;
  totalaces:=0;
  for i:=1 to GridAces.rowcount do begin
    if trim(GridAces.cells[GridAces.getcolumn('orcd_codigo'),i])<>'' then begin
      totalaces:=totalaces+Texttovalor(GridAces.Cells[GridAces.getcolumn('orcd_unitario'),i])*Texttovalor(GridAces.Cells[GridAces.getcolumn('orcd_qtde'),i]);
      if Global.Topicos[1501] then
        Acumula(GridAces.cells[GridAces.getcolumn('orcd_codigo'),i],Texttovalor(GridAces.Cells[GridAces.getcolumn('orcd_unitario'),i])*Texttovalor(GridAces.Cells[GridAces.getcolumn('orcd_qtde'),i]))
      else
        custoobra:=custoobra+Texttovalor(GridAces.Cells[GridAces.getcolumn('orcd_unitario'),i])*Texttovalor(GridAces.Cells[GridAces.getcolumn('orcd_qtde'),i]);
    end;
  end;
  totaltelas:=0;
  for i:=1 to GridTelas.rowcount do begin
    if trim(GridTelas.cells[GridTelas.getcolumn('orcd_codigo'),i])<>'' then begin
      totaltelas:=totaltelas+Texttovalor(GridTelas.Cells[GridTelas.getcolumn('orcd_unitario'),i])*Texttovalor(GridTelas.Cells[GridTelas.getcolumn('orcd_qtde'),i]);
      if Global.Topicos[1501] then
        Acumula(GridTelas.cells[GridTelas.getcolumn('orcd_codigo'),i],Texttovalor(GridTelas.Cells[GridTelas.getcolumn('orcd_unitario'),i])*Texttovalor(GridTelas.Cells[GridTelas.getcolumn('orcd_qtde'),i]))
      else
        custoobra:=custoobra+Texttovalor(GridTelas.Cells[GridTelas.getcolumn('orcd_unitario'),i])*Texttovalor(GridTelas.Cells[GridTelas.getcolumn('orcd_qtde'),i]);
    end;
  end;

  totalMaoDeObra:=0;
  for i:=1 to DtGridm.rowcount do begin
    if trim(dtGridm.cells[DtGridm.getcolumn('orcd_codigo'),i])<>'' then begin
      totalMaoDeObra:=totalMaoDeObra+Texttovalor(DtGridm.Cells[DtGridm.getcolumn('orcd_unitario'),i])*Texttovalor(DtGridM.Cells[DtGridM.getcolumn('orcd_qtde'),i]);
      if FGeral.GetConfig1AsFloat('MARGEMMOORCA')>0 then
        Acumula('MO',Texttovalor(DtGridm.Cells[DtGridm.getcolumn('orcd_unitario'),i])*Texttovalor(DtGridm.Cells[DtGridm.getcolumn('orcd_qtde'),i]))
      else
        custoobra:=custoobra+Texttovalor(DtGridm.Cells[DtGridm.getcolumn('orcd_unitario'),i])*Texttovalor(DtGridM.Cells[DtGridM.getcolumn('orcd_qtde'),i]);
    end;
  end;
// 18.07.13 - Perfis Sac
  totalps:=0;
  for i:=1 to GridPerfisSac.rowcount do begin
    if trim(GridPerfisSac.cells[GridPerfisSac.getcolumn('orcd_codigo'),i])<>'' then begin
      totalps:=totalps+Texttovalor(GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_unitario'),i])*Texttovalor(GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_qtde'),i]);
      if Global.Topicos[1501] then
        Acumula(GridPerfisSac.cells[GridPerfisSac.getcolumn('orcd_codigo'),i],Texttovalor(GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_unitario'),i])*Texttovalor(GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_qtde'),i]))
      else
        custoobra:=custoobra+Texttovalor(GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_unitario'),i])*Texttovalor(GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_qtde'),i]);
    end;
  end;

  Edtotalmo.SetValue(totalMaoDeObra);
  Edtotalinsumos.SetValue(totalinsumos);
  Edtotaltratamento.SetValue(totaltrata);
  Edtotalvidros.SetValue(totalvidros);
  Edtotalaces.SetValue(totalaces);
  Edtotalperfissac.SetValue(totalps);
  Edtotaltelas.SetValue(totaltelas);
  EdBrutototal.setvalue(totalpesobruto);
  EdRealtotal.setvalue(totalpesoreal);
//  EdVlrproducao.setvalue( (EdTotalinsumos.ascurrency+Edtotaltratamento.ascurrency+Edtotalmo.ascurrency+EdTotalVidros.AsCurrency+EdTotalAces.AsCurrency+EdTotalTelas.Ascurrency)*(EdPercproducao.ascurrency/100) );
// 14.09.10 - Marcelo Medeiros - sem Mao de obra somente materiais
  EdVlrproducao.setvalue( (EdTotalinsumos.ascurrency+Edtotaltratamento.ascurrency+EdTotalVidros.AsCurrency+EdTotalAces.AsCurrency+EdTotalTelas.Ascurrency)*(EdPercproducao.ascurrency/100) );
  EdTotPesobruto.setvalue(totalpesobruto);
  EdTotPesosobra.setvalue ( totalpesosobra );
  EdTotmediaperda.SetValue( totmediaperda );
  EdTotPesoReal.setvalue(totalpesoreal);

  custoobra:=custoobra+EdVlralimentacao.ascurrency;
  custoobra:=custoobra+EdVlrestadia.ascurrency;
  custoobra:=custoobra+EdVlrdeslocamento.ascurrency;
  custoobra:=custoobra+EdVlracessorios.ascurrency;
  custoobra:=custoobra+EdVlrmotorizacao.ascurrency;
//  custoobra:=custoobra+EdVlrpersianas.ascurrency;  // pois ja esta nos componentes(ex-acessorios)
  custoobra:=custoobra+EdVlrcremonas.ascurrency;
  custoobra:=custoobra+EdVlrproducao.ascurrency;
// 10.06.11 - refeito em 28.09.11 - estava 'meio errado'
  if (xTipoVenda=TipoVendaServicos) then begin
    custoobraservicos:=custoobra/(  ( 100-(EdOrca_custofixo.ascurrency+EdOrca_margem.ascurrency) )/100 );
    CustoObraServicos:=custoobraservicos- custoobra;
//    custoobra:=custoobra/( ( 100 - (EdOrca_custofixo.ascurrency+EdOrca_margem.ascurrency)) / 100);
//    CustoObraServicosSEM:=custoobraservicos/( ( 100 - (EdOrca_custofixo.ascurrency)) / 100);
  end;
  if Global.Topicos[1501] then
    EdOrca_custoobraporgrupo.SetValue( SomaCustoporGrupo )
  else
    EdOrca_custoobraporgrupo.SetValue( 0 );
  EdOrca_custoobra.SetValue(custoobra);

end;

function TFFormacaoPreco.GetPreNativo(codigo: string): string;
///////////////////////////////////////////////////////
var p:integer;
    s:string;
begin
 s:='';
 for p:=0 to ListaP.count-1 do begin
   PPerfis:=ListaP[p];
   if PPerfis.codigo=codigo then begin
     s:=PPerfis.prenativo;
     break;
   end;
 end;
 result:=s;

end;


procedure TFFormacaoPreco.BuscaDadosGrid(Q:TSqlquery);
var linhagrid:integer;
begin
  linhagrid:=1;
  while not Q.eof do begin
    Grid.Cells[Grid.getcolumn('id'),linhagrid]:=Q.fieldbyname('orin_esto_codigo').asstring;
    Grid.Cells[Grid.getcolumn('pesobruto'),linhagrid]:=Q.fieldbyname('orin_PESOBRUTO').asstring;
// 06.04.09
    Grid.Cells[Grid.getcolumn('pesosobra'),linhagrid]:=Q.fieldbyname('orin_PESOSOBRA').asstring;
//
    Grid.Cells[Grid.getcolumn('PERCSOBRABRUTA'),linhagrid]:=Q.fieldbyname('orin_PERCSOBRABRUTA').asstring;
    Grid.Cells[Grid.getcolumn('PERCPERDA'),linhagrid]:=Q.fieldbyname('orin_PercPerda').asstring;
    Grid.Cells[Grid.getcolumn('PESOREAL'),linhagrid]:=Q.fieldbyname('orin_PESOREAL').asstring;
    Grid.Cells[Grid.getcolumn('precouni'),linhagrid]:=formatfloat('##0.000',Q.fieldbyname('orin_precouni').asfloat);
    Grid.Cells[Grid.getcolumn('custopeca'),linhagrid]:=formatfloat('##0.000',Q.fieldbyname('orin_CUSTOPECA').asfloat);
//  09.02.09
    if Edorca_custoobra.ascurrency>0 then
      Grid.Cells[Grid.getcolumn('perctotal'),linhagrid]:=formatfloat('##0.00',(Q.fieldbyname('orin_CUSTOPECA').asfloat/Edorca_custoobra.ascurrency)*100)
    else
      Grid.Cells[Grid.getcolumn('perctotal'),linhagrid]:='';
    inc(linhagrid);
    Grid.AppendRow;
    Q.Next;
  end;
end;

procedure TFFormacaoPreco.bexclusaoClick(Sender: TObject);
var Q:TSqlquery;
begin
  OPOrcam:='E';
  Q:=sqltoquery('select orcc_numerodoc,orcc_nome from orcamencal '+
               ' where orcc_status=''N'' and orcc_numerodoc='+inttostr(numero)+
               ' and orcc_unid_codigo='+stringtosql(Global.CodigoUnidade));
  EdOrcam.Items.Clear;
  while not Q.eof do begin
    EdOrcam.Items.Add(Q.fieldbyname('orcc_nome').asstring);
    q.Next;
  end;
  FGeral.FechaQuery(Q);
   EdOrcam.enabled:=true;
   EdOrcam.Visible:=true;
   EdOrcam.setfocus;

end;

procedure TFFormacaoPreco.PageVendaChange(Sender: TObject);
begin
  if PageVenda.ActivePage=PgVenda then Edorca_custoobra.SetFirstEd
  else if PageVenda.ActivePage=PgTratamento then Edorca_custoobra.SetFirstEd
  else if PageVenda.ActivePage=PgPrazoPagamento then EdVlrvenda.SetFirstEd

end;

procedure TFFormacaoPreco.bincluirtrataClick(Sender: TObject);
begin
  ptratdigitacao.enabled:=true;
//  EdCodigo.setvalue( SequenciaGrid(DtGrid) );
  EdCodigo.text:=strzero( SequenciaGrid(DtGrid) ,5 );
  EdDescricao.setfocus;
end;

procedure TFFormacaoPreco.Edorcd_unitarioExitEdit(Sender: TObject);
begin
  ptratdigitacao.enabled:=false;
  if Confirma('Confirma ?') then
    EditstoGrid;


end;

function TFFormacaoPreco.SequenciaGrid(xGrid: TSqlDtGrid): integer;
var n,i:integer;
begin
  n:=0;
  for i:=1 to xGrid.RowCount do begin
    if trim(xGrid.cells[xGrid.getcolumn('orcd_codigo'),i])<>'' then
      n:=strtointdef( xGrid.cells[xGrid.getcolumn('orcd_codigo'),i],0 );
  end;
  result:=n+1;

end;

procedure TFFormacaoPreco.EditstoGrid;
var x:integer;
    totalitem:currency;
begin
  x:=FGeral.ProcuraGrid(DtGrid.getcolumn('orcd_codigo'),EdCodigo.Text,DtGrid);
  if x<=0 then begin
    if (DtGrid.RowCount=2) and (Trim(DtGrid.Cells[DtGrid.getcolumn('orcd_codigo'),1])='') then begin
       x:=1;
    end else begin
       DtGrid.RowCount:=DtGrid.RowCount+1;
       x:=DtGrid.RowCount-1;
    end;
    totalitem:=Edorcd_unitario.asfloat*Edorcd_qtde.asfloat;
    DtGrid.Cells[DtGrid.getcolumn('orcd_codigo'),Abs(x)]:=EdCodigo.Text;
    DtGrid.Cells[DtGrid.getcolumn('orcd_descricao'),Abs(x)]:=EdDescricao.Text;
    DtGrid.Cells[DtGrid.getcolumn('orcd_qtde'),Abs(x)]:=Edorcd_qtde.text;
    DtGrid.Cells[DtGrid.getcolumn('orcd_unidade'),Abs(x)]:=Edorcd_unidade.text;
    DtGrid.Cells[DtGrid.getcolumn('orcd_unitario'),Abs(x)]:=Edorcd_unitario.text;
    DtGrid.Cells[DtGrid.getcolumn('totalitem'),Abs(x)]:=floattostr(totalitem);
  end else begin
    totalitem:=Edorcd_unitario.asfloat*Edorcd_qtde.asfloat;
    DtGrid.Cells[DtGrid.getcolumn('orcd_codigo'),Abs(x)]:=EdCodigo.Text;
    DtGrid.Cells[DtGrid.getcolumn('orcd_descricao'),Abs(x)]:=EdDescricao.Text;
    DtGrid.Cells[DtGrid.getcolumn('orcd_qtde'),Abs(x)]:=Edorcd_qtde.text;
    DtGrid.Cells[DtGrid.getcolumn('orcd_unidade'),Abs(x)]:=Edorcd_unidade.text;
    DtGrid.Cells[DtGrid.getcolumn('orcd_unitario'),Abs(x)]:=Edorcd_unitario.text;
    DtGrid.Cells[DtGrid.getcolumn('totalitem'),Abs(x)]:=floattostr(totalitem);
  end;
  MudouTratamento:='S';
end;

procedure TFFormacaoPreco.bcancelatrataClick(Sender: TObject);
begin
  ptratdigitacao.enabled:=false;

end;

procedure TFFormacaoPreco.SetaDescricaoTratamento(Ed: TSqlEd);
begin
   Ed.Items.Clear;
   Ed.Items.add('PINTURA ELETROST�TICA');
   Ed.Items.add('ANODIZA��O COLORIDA');
   Ed.Items.add('ANODIZA��O FOSCO');
   Ed.Items.add('VIDRO');
   Ed.Items.add('LAMINA��O');
   Ed.Items.add('INSULAMENTO');
end;

procedure TFFormacaoPreco.balterartrataClick(Sender: TObject);
begin
  if trim(DtGrid.cells[DtGrid.getcolumn('orcd_codigo'),dtGrid.row])<>'' then begin
    ptratdigitacao.enabled:=true;
    EdCodigo.text:=DtGrid.cells[DtGrid.getcolumn('orcd_codigo'),dtGrid.row];
    EdDescricao.text:=DtGrid.cells[DtGrid.getcolumn('orcd_descricao'),dtGrid.row];
    Edorcd_qtde.text:=DtGrid.Cells[DtGrid.getcolumn('orcd_qtde'),dtGrid.row];
    Edorcd_unidade.text:=DtGrid.Cells[DtGrid.getcolumn('orcd_unidade'),dtGrid.row];
    Edorcd_unitario.text:=DtGrid.Cells[DtGrid.getcolumn('orcd_unitario'),dtGrid.row];
    EdDescricao.setfocus;
  end;

end;

procedure TFFormacaoPreco.bexcluitrataClick(Sender: TObject);
begin
  if not confirma('Confirma exclus�o') then exit;
  DtGrid.DeleteRow(DtGrid.Row);
  MudouTratamento:='S';
end;

procedure TFFormacaoPreco.BuscaDadosDtGrid(Q: TSqlquery ; DtGrid:TSqlDtGrid);
/////////////////////////////////////////////////////////////////////////////////
var linhagrid:integer;
    totalitem:currency;
begin
  linhagrid:=1;
  while not Q.eof do begin
    totalitem:=Q.fieldbyname('orcd_unitario').asfloat*Q.fieldbyname('orcd_qtde').asfloat;
    DtGrid.Cells[DtGrid.getcolumn('orcd_codigo'),linhagrid]:=Q.fieldbyname('orcd_codigo').asstring;
    DtGrid.Cells[DtGrid.getcolumn('orcd_descricao'),linhagrid]:=Q.fieldbyname('orcd_descricao').asstring;
    DtGrid.Cells[DtGrid.getcolumn('orcd_qtde'),linhagrid]:=Q.fieldbyname('orcd_qtde').asstring;
    DtGrid.Cells[DtGrid.getcolumn('orcd_unidade'),linhagrid]:=Q.fieldbyname('orcd_unidade').asstring;
    DtGrid.Cells[DtGrid.getcolumn('orcd_unitario'),linhagrid]:=Q.fieldbyname('orcd_unitario').asstring;
    DtGrid.Cells[DtGrid.getcolumn('totalitem'),linhagrid]:=floattostr(totalitem);
//  19.02.09
    if Edorca_custoobra.ascurrency>0 then
      DtGrid.Cells[DtGrid.getcolumn('perctotal'),linhagrid]:=formatfloat('##0.00',(totalitem/Edorca_custoobra.ascurrency)*100)
    else
      DtGrid.Cells[DtGrid.getcolumn('perctotal'),linhagrid]:='';
// 19.07.13  - Metalforte
    if DtGrid.getcolumn('orcd_tama_codigo')>0 then begin
      DtGrid.Cells[DtGrid.getcolumn('orcd_tama_codigo'),linhagrid]:=Q.fieldbyname('orcd_tama_codigo').asstring;
      DtGrid.Cells[DtGrid.getcolumn('orcd_core_codigo'),linhagrid]:=Q.fieldbyname('orcd_core_codigo').asstring;
      DtGrid.Cells[DtGrid.getcolumn('tamanho'),linhagrid]:=FTamanhos.Getdescricao( Q.fieldbyname('orcd_tama_codigo').asinteger );
      DtGrid.Cells[DtGrid.getcolumn('cor'),linhagrid]:=FCores.Getdescricao( Q.fieldbyname('orcd_core_codigo').asinteger );
      DtGrid.Cells[DtGrid.getcolumn('orcd_peso'),linhagrid]:=Q.fieldbyname('orcd_peso').asstring;
    end;
    if DtGrid.getcolumn('esto_referencia')>0 then
       DtGrid.Cells[DtGrid.getcolumn('esto_referencia'),linhagrid]:=FEStoque.getreferencia(Q.fieldbyname('orcd_codigo').asstring);
    inc(linhagrid);
    DtGrid.AppendRow;
    Q.Next;
  end;
end;

procedure TFFormacaoPreco.EdunitariomoExitEdit(Sender: TObject);
begin
  pdigmo.enabled:=false;
  if Confirma('Confirma ?') then
    EditstoGridm;

end;

procedure TFFormacaoPreco.EditstoGridM;
var x:integer;
    totalitem:currency;
begin
  x:=FGeral.ProcuraGrid(DtGridM.getcolumn('orcd_codigo'),EdCodigomo.Text,DtGridM);
  if x<=0 then begin
    if (DtGridM.RowCount=2) and (Trim(DtGridM.Cells[DtGridM.getcolumn('orcd_codigo'),1])='') then begin
       x:=1;
    end else begin
       DtGridM.RowCount:=DtGridM.RowCount+1;
       x:=DtGridM.RowCount-1;
    end;
    totalitem:=Edunitariomo.asfloat*Edtempomo.asfloat;
    DtGridM.Cells[DtGridM.getcolumn('orcd_codigo'),Abs(x)]:=EdCodigomo.Text;
    DtGridM.Cells[DtGridM.getcolumn('orcd_descricao'),Abs(x)]:=EdDescricaomo.Text;
    DtGridM.Cells[DtGridM.getcolumn('orcd_qtde'),Abs(x)]:=Edtempomo.text;
    DtGridM.Cells[DtGridM.getcolumn('orcd_unidade'),Abs(x)]:=Edunidademo.text;
    DtGridM.Cells[DtGridM.getcolumn('orcd_unitario'),Abs(x)]:=Edunitariomo.text;
    DtGridM.Cells[DtGridM.getcolumn('totalitem'),Abs(x)]:=floattostr(totalitem);
  end else begin
    totalitem:=Edunitariomo.asfloat*Edtempomo.asfloat;
    DtGridM.Cells[DtGridM.getcolumn('orcd_codigo'),Abs(x)]:=EdCodigomo.Text;
    DtGridM.Cells[DtGridM.getcolumn('orcd_descricao'),Abs(x)]:=EdDescricaomo.Text;
    DtGridM.Cells[DtGridM.getcolumn('orcd_qtde'),Abs(x)]:=Edtempomo.text;
    DtGridM.Cells[DtGridM.getcolumn('orcd_unidade'),Abs(x)]:=Edunidademo.text;
    DtGridM.Cells[DtGridM.getcolumn('orcd_unitario'),Abs(x)]:=Edunitariomo.text;
    DtGridM.Cells[DtGridM.getcolumn('totalitem'),Abs(x)]:=floattostr(totalitem);
  end;
  MudouMaoDeObra:='S';
end;

procedure TFFormacaoPreco.bincluimoClick(Sender: TObject);
begin
  pdigmo.enabled:=true;
//  EdCodigo.setvalue( SequenciaGrid(DtGrid) );
//  EdCodigo.text:=strzero( SequenciaGrid(DtGrid) ,5 );
  LimpaEdits(FFormacaoPreco,25);
  EdCodigomo.enabled:=true;
  EdCodigomo.setfocus;

end;

procedure TFFormacaoPreco.balteramoClick(Sender: TObject);
begin
  if trim(DtGridm.cells[DtGridm.getcolumn('orcd_codigo'),dtGridm.row])<>'' then begin
    pdigmo.enabled:=true;
    EdCodigomo.text:=DtGridm.cells[DtGridm.getcolumn('orcd_codigo'),dtGridm.row];
    EdDescricaomo.text:=DtGridm.cells[DtGridm.getcolumn('orcd_descricao'),dtGridm.row];
    Edtempomo.text:=DtGridm.Cells[DtGridm.getcolumn('orcd_qtde'),dtGridm.row];
    Edunidademo.text:=DtGridm.Cells[DtGridm.getcolumn('orcd_unidade'),dtGridm.row];
    Edunitariomo.text:=DtGridm.Cells[DtGridm.getcolumn('orcd_unitario'),dtGridm.row];
    EdCodigomo.enabled:=false;
    EdDescricaomo.setfocus;
  end;

end;

procedure TFFormacaoPreco.excluimoClick(Sender: TObject);
begin
  if not confirma('Confirma exclus�o') then exit;
  DtGridm.DeleteRow(DtGridm.Row);
  MudouMaoDeObra:='S';

end;

procedure TFFormacaoPreco.cancelamoClick(Sender: TObject);
begin
  pdigmo.enabled:=false;

end;

procedure TFFormacaoPreco.EdcodigomoValidate(Sender: TObject);
begin
  if EdCodigomo.ResultFind<>nil then begin
    if EdDescricaomo.IsEmpty then
      EdDescricaomo.text:=EdCodigomo.ResultFind.fieldbyname('cadm_descricao').AsString;
    if EdUNidademo.isempty then
      EdUNidademo.text := EdCodigomo.ResultFind.fieldbyname('cadm_unidade').AsString;
    if EdUNitariomo.ascurrency=0 then
      EdUNitariomo.setvalue( EdCodigomo.ResultFind.fieldbyname('cadm_unitario').AsFloat );
  end;
end;

procedure TFFormacaoPreco.Limpaedits(Formulario: TForm ; Grupo:integer);
var i:integer;
begin
  for i:=0 to Formulario.ComponentCount-1 do begin
    if Formulario.Components[i] is TSqlEd then
      if TSqlEd(Formulario.Components[i]).Group=25 then
        TSqlEd(Formulario.Components[i]).Clear ;
  end;
end;

procedure TFFormacaoPreco.ZeraCampos;
begin
   Edtotalinsumos.setvalue(0);
   Edtotaltratamento.setvalue(0);
   Edtotalmo.setvalue(0);
   EdKm.text:='';
   EdVlrdeslocamento.setvalue(0);
   Edvlralimentacao.SetValue(0);
   Edvlrestadia.SetValue(0);
end;

procedure TFFormacaoPreco.EdkmValidate(Sender: TObject);
var consumoveiculo:currency;
begin
//  Edvlrdeslocamento.setvalue(EdKm.asinteger*FGeral.GetConfig1AsFloat('VLRporkm'))
  consumoveiculo:=FGeral.GetConfig1AsFloat('CONSUMOORCA');
  if cargaveiculo>0 then
    mediam2:=Inteiro(FOrcamentos.EdOrca_area.AsCurrency/cargaveiculo,'+',1);
  if Consumoveiculo>0 then
    Edvlrdeslocamento.setvalue( (((EdKm.asinteger*2)*mediam2)/Consumoveiculo)*FGeral.GetConfig1AsFloat('PRECOCOMBORCA')  )
end;

procedure TFFormacaoPreco.EdOrca_comissoesValidate(Sender: TObject);
begin
  if not FGeral.ValidaComissao(EdOrca_comissoes.ascurrency) then begin
      EdOrca_comissoes.setvalue(0);
      EdOrca_comissoes.invalid('');
  end;
end;

procedure TFFormacaoPreco.EdOrca_reservaValidate(Sender: TObject);
begin
  if not FGeral.ValidaComissao(EdOrca_reserva.ascurrency) then begin
      EdOrca_reserva.setvalue(0);
      EdOrca_reserva.invalid('');
  end;

end;

////////////////////////////////////////////////////////////
procedure TFFormacaoPreco.IniciaCampos(tipovenda:string);
////////////////////////////////////////////////////////////
begin
  EdOrca_simples.setvalue( FGeral.GetConfig1AsFloat('PERCSIMPLES') );
// 10.06.11
  if tipovenda=TipoVendaServicos then
    EdOrca_simples.setvalue( FGeral.GetConfig1AsFloat('Percsimplesser') );
  EdOrca_custofixo.setvalue( FGeral.GetConfig1AsFloat('CUSTOFIXO') );
  EdOrca_margem.setvalue( FGeral.GetConfig1AsFloat('MARGEMMIN') );
  EdOrca_margemcli.setvalue( FGeral.GetConfig1AsFloat('MARGEMMIN') );
  Edpercproducao.setvalue( FGeral.GetConfig1AsFloat('PERGERPRODUCAO') );
  EdOrca_Reserva.setvalue( FGeral.GetConfig1AsFloat('PERCRESTEC') );
  EdOrca_Construcard.setvalue( FGeral.GetConfig1AsFloat('PERCconstru') );

  EdOrca_simples.Refresh;
  EdOrca_reserva.Refresh;
  EdOrca_custofixo.Refresh;
  EdOrca_margem.Refresh;
  EdOrca_construcard.Refresh;
// 13.07.09
//  EdOrca_comissoes.setvalue( FTabelaComissao.GetComissao(Arq.TOrcamentos.fieldbyname('orca_repr_codigo').asinteger,EdOrca_margem.ascurrency ) );
//  EdReflexocom.setvalue( FTabelaComissao.GetReflexoComissao(Arq.TOrcamentos.fieldbyname('orca_repr_codigo').asinteger,EdOrca_margem.ascurrency ) );
//  EdOrca_comissoes.setvalue( FRepresentantes.GetPerComissao( Arq.TOrcamentos.fieldbyname('orca_repr_codigo').asinteger ));
// 09.07.09 - calcular segundo nova 'formula'
//  'MARKUPMIN'
  EdPercjuros.setvalue( FGeral.GetConfig1AsFloat('PERCJURFIN') );
  EdCarencia.setvalue( FGeral.GetConfig1AsInteger('MESESCARENCIA') );


end;

procedure TFFormacaoPreco.EdpercproducaoValidate(Sender: TObject);
begin
//   if EdPercproducao.ascurrency>0 then
//     EdVlrproducao.setvalue( (EdTotalinsumos.ascurrency+Edtotaltratamento.ascurrency+Edtotalmo.ascurrency)*(EdPercproducao.ascurrency/100) );
// retirado para deixar 'padrao' o calculo somente pelo botao calcula
end;

procedure TFFormacaoPreco.bImpressaoClick(Sender: TObject);
begin
   ImprimePlanilhaOrcamento;
end;

////////////////////////////////////////////////////////////
procedure TFFormacaoPreco.ImprimePlanilhaOrcamento;
////////////////////////////////////////////////////////////
var Q,QIns,QTratT,QTratS,QOrc,QTratV,QTratA,QTratC:TSqlquery;
    pesobruto,valorunitario,perc,totalmateriais,totalmo,totalinsumos,totaltratamento,
    totaltratadiversos,totaldespextraordinarias,totpercvenda,totvalorvenda,
    totpercvendacli,totalvalorvendacli,totalvidros,totalacessorios,totaltelas,
    mediaperda:extended;
    colunas,qtdmediaperda:integer;
    TituloTipoVenda:string;


    function FazDesconto(qvalor:currency):currency;
    //////////////////////////////////////////////
    var vlr:currency;
    begin
      vlr:=0;
      if Q.fieldbyname('orcc_desconto01').ascurrency>0 then
        vlr:=qvalor - ( qvalor*(Q.fieldbyname('orcc_desconto01').ascurrency/100) );
      result:=vlr;

    end;

begin
///////////////////////////////////////////////////////////////
   totalmateriais:=0;totalmo:=0;totalinsumos:=0;
   totaltratamento:=0;totaltratadiversos:=0;
   totaldespextraordinarias:=0;totpercvenda:=0;totvalorvenda:=0;
   totpercvendacli:=0;totalvalorvendacli:=0;mediaperda:=0;qtdmediaperda:=0;
   QOrc:=sqltoquery('select * from orcamentos '+
               ' where orca_status=''N'' and orca_numerodoc='+inttostr(numero) );
   Q:=sqltoquery('select * from orcamencal '+
               ' where orcc_status=''N'' and orcc_numerodoc='+inttostr(numero)+
               ' and orcc_nome='+stringtosql(nomeorcam)+
               ' and orcc_unid_codigo='+stringtosql(Global.CodigoUnidade) );

   if Q.eof then begin
     Avisoerro('Orcamento numero '+inttostr(numero)+' nome '+nomeorcam+' n�o encontrado');
     Q.Close;
     exit;
   end;
   QIns:=sqltoquery('select * from orcainsumos '+
               ' where orin_status=''N'' and orin_numerodoc='+inttostr(numero)+
               ' and orin_nome='+stringtosql(nomeorcam)+
               ' and orin_unid_codigo='+stringtosql(Global.CodigoUnidade) );
   QTratT:=sqltoquery('select * from orcamendet'+
               ' where orcd_status=''N'' and orcd_numerodoc='+inttostr(numero)+
               ' and orcd_nome='+stringtosql(nomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
               ' and orcd_tipoitem=''T'''+
               ' order by orcd_codigo' );

   QTratS:=sqltoquery('select * from orcamendet'+
               ' where orcd_status=''N'' and orcd_numerodoc='+inttostr(numero)+
               ' and orcd_nome='+stringtosql(nomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
               ' and orcd_tipoitem=''S'''+
               ' order by orcd_codigo' );

// 22.09.10 - nao imprimia estes 'outros dados do custo'
   QTratV:=sqltoquery('select * from orcamendet'+
               ' where orcd_status=''N'' and orcd_numerodoc='+inttostr(numero)+
               ' and orcd_nome='+stringtosql(nomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
               ' and orcd_tipoitem=''V'''+
               ' order by orcd_codigo' );

   QTratA:=sqltoquery('select * from orcamendet'+
               ' where orcd_status=''N'' and orcd_numerodoc='+inttostr(numero)+
               ' and orcd_nome='+stringtosql(nomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
               ' and orcd_tipoitem=''A'''+
               ' order by orcd_codigo' );

   QTratC:=sqltoquery('select * from orcamendet'+
               ' where orcd_status=''N'' and orcd_numerodoc='+inttostr(numero)+
               ' and orcd_nome='+stringtosql(nomeorcam)+
               ' and orcd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
               ' and orcd_tipoitem=''C'''+
               ' order by orcd_codigo' );

   Calculapreco;
   Sistema.BeginProcess('');
   FRel.Init('RelPlanilhaOrcamento');
  //      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
//   FRel.AddTit(FGeral.TituloRelUnidade(Global.CodigoUnidade));
   FRel.AddTit('Planilha de Or�amento de Obra '+Numeroobra+' do Or�amento '+nomeorcam+'  - Cliente '+FOrcamentos.EdOrca_cliente1.text+'  - Representante '+FOrcamentos.EdRepr_codigo.text+' - '+FRepresentantes.GetDescricao( FOrcamentos.EdRepr_codigo.asinteger ) );
   if xTipoVenda=TipoVendaServicos then
     FRel.AddTit('Fone '+FOrcamentos.EdOrca_fone.text+' - Celular '+FOrcamentos.EdOrca_celular.text+'  - Linha '+FOrcamentos.EdOrca_linha.text+'  - Area '+FOrcamentos.EdOrca_area.text+' - VENDA DE SERVI�OS' )
   else
     FRel.AddTit('Fone '+FOrcamentos.EdOrca_fone.text+' - Celular '+FOrcamentos.EdOrca_celular.text+'  - Linha '+FOrcamentos.EdOrca_linha.text+'  - Area '+FOrcamentos.EdOrca_area.text );
   FRel.AddTit('Tamanho m2 '+FOrcamentos.EdOrca_area.text+' -  Peso Bruto '+EdBrutototal.text+' - Peso Real '+EdRealtotal.text+' - Peso L�quido '+EdPesoliquido.text  );
   FRel.Addtit('Custo por KG real '+EdCustokgreal.text+'  - Custo por KG L�quido '+Edcustopesoliquido.text+' - Custo por m2 '+EdCustom2.text  );

   FRel.AddCol( 200,1,'C','' ,''              ,'Insumos'         ,''         ,'',false);
   FRel.AddCol( 080,3,'N','' ,''              ,'Peso Bruto'         ,''         ,'',false);
//   FRel.AddCol( 060,3,'N','' ,'##0.00'        ,'Sobra Bruta'         ,''         ,'',false);
   FRel.AddCol( 060,3,'N','' ,''               ,'Sobra Bruta'         ,''         ,'',false);
   FRel.AddCol( 060,3,'N','' ,''              ,'Perda'         ,''         ,'',false);
   FRel.AddCol( 080,3,'N','' ,''              ,'Peso Real'         ,''         ,'',false);
   FRel.AddCol( 030,1,'C','' ,''              ,'Un.'         ,''         ,'',false);
   FRel.AddCol( 070,3,'N','' ,''              ,'Pre�o Unit�rio'         ,''         ,'',false);
   FRel.AddCol( 080,3,'N','' ,''              ,'Custo/Pe�a'         ,''         ,'',false);
   FRel.AddCol( 080,3,'N','' ,''              ,'% Proporcional'         ,''         ,'',false);
   colunas:=9;
//   FRel.AddCol( 080,3,'N','' ,''              ,''         ,''         ,'',false);

  {
   FRel.AddCel('Cliente/Obra :'+QOrc.FieldByName('orca_cliente1').AsString);
   FRel.AddCel('Telefone     :'+FGeral.Formatatelefone( QOrc.FieldByName('orca_fone').AsString )+
                space(10)+'Celular   :'+FGeral.Formatatelefone( QOrc.FieldByName('orca_fone').AsString ) );
   FRel.AddCel('Tamanho m2   :'+Transform(QOrc.FieldByName('orca_area').AsFloat,f_cr) );

   FRel.AddCel('Peso Bruto        :'+Transform(totalpesobruto,f_cr)+space(10)+
               'Peso Real         :'+Transform(totalpesoreal,f_cr)+
               'Peso L�quido      :'+Transform(Q.FieldByName('orcc_pesoliquido').AsFloat,f_cr)+
               'M�dia Perda       :'+Transform(EdMediaperda.ascurrency,f_cr)
                 );
   FRel.AddCel('Custo por KG Real :'+Transform(EdCustokgreal.asfloat,f_cr)+space(10)+
               'Custo por KG L�quido :'+Transform(EdCustopesoliquido.asfloat,f_cr)+
               'Custo por M2 :'+Transform(EdCustom2.asfloat,f_cr)
                 );
   FRel.AddCel(replicate('-',c));
}
   while not QIns.eof do begin
     FRel.AddCel(Qins.fieldbyname('orin_esto_codigo').asstring);
     FRel.AddCel(Qins.fieldbyname('orin_pesobruto').asstring);
     FRel.AddCel( transform(Qins.fieldbyname('orin_percsobrabruta').asfloat,'##0.00') );
     FRel.AddCel(Qins.fieldbyname('orin_percperda').asstring);
     FRel.AddCel(Qins.fieldbyname('orin_pesoreal').asstring);
     FRel.AddCel('KG');
     FRel.AddCel(Qins.fieldbyname('orin_precouni').asstring);
     FRel.AddCel(Qins.fieldbyname('orin_custopeca').asstring);
     if Edorca_custoobra.AsCurrency>0 then
       perc:=(Qins.fieldbyname('orin_custopeca').asfloat/Edorca_custoobra.AsCurrency)*100
     else
       perc:=0;
     FRel.AddCel(transform(perc,f_cr));
     totalmateriais:=totalmateriais+Qins.fieldbyname('orin_custopeca').asfloat;
     totalinsumos:=totalinsumos+Qins.fieldbyname('orin_custopeca').asfloat;
     mediaperda:=mediaperda+Qins.fieldbyname('orin_percperda').asfloat;
     inc(qtdmediaperda);
     QIns.Next;
   end;
   if qtdmediaperda>0 then mediaperda:=mediaperda/qtdmediaperda;
   FGEral.ImprimelinhaRel(colunas,replicate('-',70));
   if Edorca_custoobra.AsCurrency>0 then
       perc:=(totalinsumos/Edorca_custoobra.AsCurrency)*100
   else
       perc:=0;
   FGEral.PulalinhaRel(colunas,4,transform(mediaperda,f_cr),8,transform(totalinsumos,f_cr),9,transform(perc,f_cr));
   FRel.AddCel('TRATAMENTO');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');

   totaltratamento:=0;
   while not QTRatT.eof do begin
     FRel.AddCel(QTratt.fieldbyname('orcd_descricao').asstring);
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel(QTratt.fieldbyname('orcd_qtde').asstring);
     FRel.AddCel(QTratt.fieldbyname('orcd_unidade').asstring);
     FRel.AddCel(QTratt.fieldbyname('orcd_unitario').asstring);
     valorunitario:=(QTratt.fieldbyname('orcd_unitario').ascurrency*QTratt.fieldbyname('orcd_qtde').ascurrency);
     FRel.AddCel(transform(valorunitario,f_cr));
     if Edorca_custoobra.AsCurrency>0 then
       perc:=(valorunitario/Edorca_custoobra.AsCurrency)*100
     else
       perc:=0;
     FRel.AddCel(transform(perc,f_cr));
     totalmateriais:=totalmateriais+valorunitario;
     totaltratamento:=totaltratamento+valorunitario;
     QTratt.Next;
   end;

   FGEral.ImprimelinhaRel(colunas,replicate('-',70));
   if Edorca_custoobra.AsCurrency>0 then
       perc:=(totaltratamento/Edorca_custoobra.AsCurrency)*100
   else
       perc:=0;
   FGEral.PulalinhaRel(colunas,8,transform(totaltratamento,f_cr),9,transform(perc,f_cr));
   FGEral.PulalinhaRel(colunas);
// 22.09.10
//////////////////////////////
   totalVIDROS:=0;
   FRel.AddCel('VIDROS');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   while not QTRatV.eof do begin
     FRel.AddCel(QTratv.fieldbyname('orcd_descricao').asstring);
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel(QTratv.fieldbyname('orcd_qtde').asstring);
     FRel.AddCel(QTratv.fieldbyname('orcd_unidade').asstring);
     FRel.AddCel(QTratv.fieldbyname('orcd_unitario').asstring);
     valorunitario:=(QTratv.fieldbyname('orcd_unitario').ascurrency*QTratv.fieldbyname('orcd_qtde').ascurrency);
     FRel.AddCel(transform(valorunitario,f_cr));
     if Edorca_custoobra.AsCurrency>0 then
       perc:=(valorunitario/Edorca_custoobra.AsCurrency)*100
     else
       perc:=0;
     FRel.AddCel(transform(perc,f_cr));
     totalmateriais:=totalmateriais+valorunitario;
     totalvidros:=totalvidros+valorunitario;
     QTratv.Next;
   end;

   FGEral.ImprimelinhaRel(colunas,replicate('-',70));
   if Edorca_custoobra.AsCurrency>0 then
       perc:=(totalvidros/Edorca_custoobra.AsCurrency)*100
   else
       perc:=0;
   FGEral.PulalinhaRel(colunas,8,transform(totalvidros,f_cr),9,transform(perc,f_cr));
   FGEral.PulalinhaRel(colunas);

// Acessorios
// 22.09.10
//////////////////////////////
   totalacessorios:=0;
   FRel.AddCel('ACESS�RIOS');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   while not QTRatA.eof do begin
     FRel.AddCel(QTrata.fieldbyname('orcd_descricao').asstring);
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel(QTrata.fieldbyname('orcd_qtde').asstring);
     FRel.AddCel(QTrata.fieldbyname('orcd_unidade').asstring);
     FRel.AddCel(QTrata.fieldbyname('orcd_unitario').asstring);
     valorunitario:=(QTrata.fieldbyname('orcd_unitario').ascurrency*QTrata.fieldbyname('orcd_qtde').ascurrency);
     FRel.AddCel(transform(valorunitario,f_cr));
     if Edorca_custoobra.AsCurrency>0 then
       perc:=(valorunitario/Edorca_custoobra.AsCurrency)*100
     else
       perc:=0;
     FRel.AddCel(transform(perc,f_cr));
     totalmateriais:=totalmateriais+valorunitario;
     totalacessorios:=totalacessorios+valorunitario;
     QTrata.Next;
   end;

   FGEral.ImprimelinhaRel(colunas,replicate('-',70));
   if Edorca_custoobra.AsCurrency>0 then
       perc:=(totalacessorios/Edorca_custoobra.AsCurrency)*100
   else
       perc:=0;
   FGEral.PulalinhaRel(colunas,8,transform(totalacessorios,f_cr),9,transform(perc,f_cr));
   FGEral.PulalinhaRel(colunas);

// telas e chapas

// Acessorios
// 22.09.10
//////////////////////////////
   totaltelas:=0;
   FRel.AddCel('TELAS/CHAPAS');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   while not QTRatc.eof do begin
     FRel.AddCel(QTratc.fieldbyname('orcd_descricao').asstring);
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel(QTratc.fieldbyname('orcd_qtde').asstring);
     FRel.AddCel(QTratc.fieldbyname('orcd_unidade').asstring);
     FRel.AddCel(QTratc.fieldbyname('orcd_unitario').asstring);
     valorunitario:=(QTratc.fieldbyname('orcd_unitario').ascurrency*QTratc.fieldbyname('orcd_qtde').ascurrency);
     FRel.AddCel(transform(valorunitario,f_cr));
     if Edorca_custoobra.AsCurrency>0 then
       perc:=(valorunitario/Edorca_custoobra.AsCurrency)*100
     else
       perc:=0;
     FRel.AddCel(transform(perc,f_cr));
     totalmateriais:=totalmateriais+valorunitario;
     totaltelas:=totaltelas+valorunitario;
     QTratc.Next;
   end;

   FGEral.ImprimelinhaRel(colunas,replicate('-',70));
   if Edorca_custoobra.AsCurrency>0 then
       perc:=(totaltelas/Edorca_custoobra.AsCurrency)*100
   else
       perc:=0;
   FGEral.PulalinhaRel(colunas,8,transform(totaltelas,f_cr),9,transform(perc,f_cr));
   FGEral.PulalinhaRel(colunas);


////////////////////

   FRel.AddCel('Componentes');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('UD');
   FRel.AddCel('');
   valorunitario:=(Q.fieldbyname('orcc_acessorios').ascurrency);
   FRel.AddCel(transform(valorunitario,f_cr));
   if Edorca_custoobra.AsCurrency>0 then
     perc:=(valorunitario/Edorca_custoobra.AsCurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   totalmateriais:=totalmateriais+valorunitario;
   totaltratadiversos:=totaltratadiversos+valorunitario;
   FRel.AddCel('Persianas');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('UD');
   FRel.AddCel('');
   valorunitario:=(Q.fieldbyname('orcc_persianas').ascurrency);
   FRel.AddCel(transform(valorunitario,f_cr));
   if Edorca_custoobra.AsCurrency>0 then
     perc:=(valorunitario/Edorca_custoobra.AsCurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   totalmateriais:=totalmateriais+valorunitario;
   totaltratadiversos:=totaltratadiversos+valorunitario;
//   if Q.fieldbyname('orcc_cremonas').ascurrency>0 then begin
// 30.05.11 - Adriano pediu para imprimir mesmo zerado
     FRel.AddCel('Cremonas');
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel('UD');
     FRel.AddCel('');
     valorunitario:=(Q.fieldbyname('orcc_cremonas').ascurrency);
     FRel.AddCel(transform(valorunitario,f_cr));
     if Edorca_custoobra.AsCurrency>0 then
       perc:=(valorunitario/Edorca_custoobra.AsCurrency)*100
     else
       perc:=0;
     FRel.AddCel(transform(perc,f_cr));
     totalmateriais:=totalmateriais+valorunitario;
     totaltratadiversos:=totaltratadiversos+valorunitario;
//   end;
   FRel.AddCel('Motoriza��o');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('UD');
   FRel.AddCel('');
   valorunitario:=(Q.fieldbyname('orcc_motorizacao').ascurrency);
   FRel.AddCel(transform(valorunitario,f_cr));
   if Edorca_custoobra.AsCurrency>0 then
     perc:=(valorunitario/Edorca_custoobra.AsCurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   totalmateriais:=totalmateriais+valorunitario;
   totaltratadiversos:=totaltratadiversos+valorunitario;


   FGEral.ImprimelinhaRel(colunas,replicate('-',70));
   if Edorca_custoobra.AsCurrency>0 then
       perc:=(totaltratadiversos/Edorca_custoobra.AsCurrency)*100
   else
       perc:=0;
   FGEral.PulalinhaRel(colunas,8,transform(totaltratadiversos,f_cr),9,transform(perc,f_cr));

   FGEral.PulalinhaRel(colunas);
   FRel.AddCel('TOTAL DE MATERIAIS');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel( transform(totalmateriais,f_cr) );
   if Edorca_custoobra.AsCurrency>0 then
       perc:=(totalmateriais/Edorca_custoobra.AsCurrency)*100
   else
       perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FGEral.PulalinhaRel(colunas);

   FRel.AddCel('Sal�rios de Produ��o');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('Tempo/Hora');
   FRel.AddCel('');
   FRel.AddCel('Custo/Hora');
   FRel.AddCel('Total');
   FRel.AddCel('');


   while not QTRatS.eof do begin
     FRel.AddCel(QTrats.fieldbyname('orcd_descricao').asstring);
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel('');
     FRel.AddCel(QTrats.fieldbyname('orcd_qtde').asstring);
     FRel.AddCel(QTrats.fieldbyname('orcd_unidade').asstring);
     FRel.AddCel(QTrats.fieldbyname('orcd_unitario').asstring);
     valorunitario:=(QTrats.fieldbyname('orcd_unitario').ascurrency*QTrats.fieldbyname('orcd_qtde').ascurrency);
     FRel.AddCel( transform(valorunitario,f_cr));
     if Edorca_custoobra.AsCurrency>0 then
       perc:=(valorunitario/Edorca_custoobra.AsCurrency)*100
     else
       perc:=0;
     FRel.AddCel(transform(perc,f_cr));
     totalmo:=totalmo+valorunitario;
     QTrats.Next;
   end;

   FGEral.ImprimelinhaRel(colunas,replicate('-',70));
//   FGEral.PulalinhaRel(colunas);
   FRel.AddCel('TOTAL DA M�O DE OBRA');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel( transform(totalmO,f_cr) );
   if Edorca_custoobra.AsCurrency>0 then
       perc:=(totalMO/Edorca_custoobra.AsCurrency)*100
   else
       perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FGEral.PulalinhaRel(colunas);

//   FGEral.ImprimelinhaRel(colunas,replicate('-',70));
//   FGEral.PulalinhaRel(colunas);
   FRel.AddCel('GASTOS PRODU��O S/ MATERIAIS');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel( transform(EdPercproducao.asfloat,f_cr) );
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel( transform(EdVlrproducao.asfloat,f_cr) );
   if EdVlrproducao.asfloat>0 then
       perc:=(EdVlrproducao.asfloat/Edorca_custoobra.AsCurrency)*100
   else
       perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FGEral.PulalinhaRel(colunas);

   FRel.AddCel('Despesas Extraordin�rias');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');

   FRel.AddCel('Deslocamento');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=(Q.fieldbyname('orcc_desloca').asfloat);
   totaldespextraordinarias:=totaldespextraordinarias+valorunitario;
   FRel.AddCel( transform(valorunitario,f_cr));
   if Edorca_custoobra.AsCurrency>0 then
     perc:=(valorunitario/Edorca_custoobra.AsCurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel('Alimenta��o');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=(Q.fieldbyname('orcc_alimentacao').asfloat);
   totaldespextraordinarias:=totaldespextraordinarias+valorunitario;
   FRel.AddCel( transform(valorunitario,f_cr));
   if Edorca_custoobra.AsCurrency>0 then
     perc:=(valorunitario/Edorca_custoobra.AsCurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel('Estadia');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=(Q.fieldbyname('orcc_estadia').asfloat);
   totaldespextraordinarias:=totaldespextraordinarias+valorunitario;
   FRel.AddCel( transform(valorunitario,f_cr));
   if Edorca_custoobra.AsCurrency>0 then
     perc:=(valorunitario/Edorca_custoobra.AsCurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));

   FGEral.ImprimelinhaRel(colunas,replicate('-',70));
   if Edorca_custoobra.AsCurrency>0 then
       perc:=(totaldespextraordinarias/Edorca_custoobra.AsCurrency)*100
   else
       perc:=0;
   FGEral.PulalinhaRel(colunas,8,transform(totaldespextraordinarias,f_cr),9,transform(perc,f_cr));


   FGEral.PulalinhaRel(colunas);
   TituloTipoVenda:='';
   if xTipoVenda=TipoVendaServicos then
     TituloTipoVenda:='SERVI�OS';
   FRel.AddCel('FORMA��O DO PRE�O DE VENDA');
   if xTipoVenda=TipoVendaServicos then
     FRel.AddCel(titulotipovenda)
   else
     FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FGEral.PulalinhaRel(colunas);
   FRel.AddCel('Custo da Obra');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=(Edorca_custoobra.asfloat);
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
//   FGEral.PulalinhaRel(colunas);

   if xTipoVenda=TipoVendaServicos then
     FRel.AddCel('Pre�o de Venda dos Servi�os')
   else
     FRel.AddCel('Pre�o de Venda');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_venda').ascurrency;
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel(transform(Q.fieldbyname('orcc_ofertacliente').ascurrency,f_cr));
//   FGEral.PulalinhaRel(colunas);

   FRel.AddCel('Pre�o de Venda com Juros Financeiros');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_vendaobrafinal').ascurrency;
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
   FGEral.PulalinhaRel(colunas);


   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('%');
   FRel.AddCel('Valor');
   FRel.AddCel('');
   FRel.AddCel('%');
   FRel.AddCel('Valor Cliente');
   FRel.AddCel('');

   FGEral.ImprimelinhaRel(colunas,replicate('-',70));
   FGEral.PulalinhaRel(colunas);

   FRel.AddCel('DESPESAS VARI�VEIS DE VENDA');
   if xTipoVenda=TipoVendaServicos then
     FRel.AddCel(titulotipovenda)
   else
     FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=(Edorca_varvendavlr.asfloat);
//   FRel.AddCel(transform(Edorca_varvenda.asfloat,f_cr));
//   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   if Q.fieldbyname('orcc_venda').ascurrency>0 then
     perc:=(EdOrca_varvendavlr1.ascurrency/Q.fieldbyname('orcc_venda').ascurrency)*100
   else
     perc:=0;
//   FRel.AddCel(transform(perc,f_cr));
//   FRel.AddCel(transform(EdOrca_varvendavlr1.ascurrency,f_cr));
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');

//   FGEral.PulalinhaRel(colunas);
   FRel.AddCel('Simples Federal');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_simples').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_simples').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvenda:=totpercvenda+Q.fieldbyname('orcc_simples').ascurrency;
   totvalorvenda:=totvalorvenda+valorunitario;

   totpercvendacli:=0;totalvalorvendacli:=0;

   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_simples').ascurrency/100);
   valorunitario:=FazDesconto(valorunitario);
   if Q.fieldbyname('orcc_ofertacliente').ascurrency>0 then
     perc:=(valorunitario/Q.fieldbyname('orcc_ofertacliente').ascurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvendacli:=totpercvendacli+perc;
   totalvalorvendacli:=totalvalorvendacli+valorunitario;
//   FGEral.PulalinhaRel(colunas);
   FRel.AddCel('Pis');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_pis').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_pis').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvenda:=totpercvenda+Q.fieldbyname('orcc_pis').ascurrency;
   totvalorvenda:=totvalorvenda+valorunitario;
   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_pis').ascurrency/100);
   if Q.fieldbyname('orcc_ofertacliente').ascurrency>0 then
     perc:=(valorunitario/Q.fieldbyname('orcc_ofertacliente').ascurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvendacli:=totpercvendacli+perc;
   totalvalorvendacli:=totalvalorvendacli+valorunitario;
//
   FRel.AddCel('Cofins');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_cofins').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_cofins').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvenda:=totpercvenda+Q.fieldbyname('orcc_cofins').ascurrency;
   totvalorvenda:=totvalorvenda+valorunitario;
   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_cofins').ascurrency/100);
   if Q.fieldbyname('orcc_ofertacliente').ascurrency>0 then
     perc:=(valorunitario/Q.fieldbyname('orcc_ofertacliente').ascurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvendacli:=totpercvendacli+perc;
   totalvalorvendacli:=totalvalorvendacli+valorunitario;
//
   FRel.AddCel('Imposto de Renda');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_ir').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_ir').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvenda:=totpercvenda+Q.fieldbyname('orcc_ir').ascurrency;
   totvalorvenda:=totvalorvenda+valorunitario;
   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_ir').ascurrency/100);
   if Q.fieldbyname('orcc_ofertacliente').ascurrency>0 then
     perc:=(valorunitario/Q.fieldbyname('orcc_ofertacliente').ascurrency)*100
   else
     perc:=0;
   totpercvendacli:=totpercvendacli+perc;
   totalvalorvendacli:=totalvalorvendacli+valorunitario;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
//
   FRel.AddCel('Contribui��o Social');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_cs').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_cs').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_cs').ascurrency/100);
   if Q.fieldbyname('orcc_ofertacliente').ascurrency>0 then
     perc:=(valorunitario/Q.fieldbyname('orcc_ofertacliente').ascurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvendacli:=totpercvendacli+perc;
   totalvalorvendacli:=totalvalorvendacli+valorunitario;
//
   FRel.AddCel('Comiss�es e Encargos');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_comissoes').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_comissoes').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvenda:=totpercvenda+Q.fieldbyname('orcc_comissoes').ascurrency;
   totvalorvenda:=totvalorvenda+valorunitario;
   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_comissoes').ascurrency/100);
   if Q.fieldbyname('orcc_ofertacliente').ascurrency>0 then
     perc:=(valorunitario/Q.fieldbyname('orcc_ofertacliente').ascurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvendacli:=totpercvendacli+perc;
   totalvalorvendacli:=totalvalorvendacli+valorunitario;
//
//
   FRel.AddCel('Reflexo Sobre Comiss�es');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_reflexocom').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_reflexocom').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvenda:=totpercvenda+Q.fieldbyname('orcc_reflexocom').ascurrency;
   totvalorvenda:=totvalorvenda+valorunitario;
   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_reflexocom').ascurrency/100);
   if Q.fieldbyname('orcc_ofertacliente').ascurrency>0 then
     perc:=(valorunitario/Q.fieldbyname('orcc_ofertacliente').ascurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvendacli:=totpercvendacli+perc;
   totalvalorvendacli:=totalvalorvendacli+valorunitario;
//

   FRel.AddCel('Icms');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_icms').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_icms').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvenda:=totpercvenda+Q.fieldbyname('orcc_icms').ascurrency;
   totvalorvenda:=totvalorvenda+valorunitario;

   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_icms').ascurrency/100);
   if Q.fieldbyname('orcc_ofertacliente').ascurrency>0 then
     perc:=(valorunitario/Q.fieldbyname('orcc_ofertacliente').ascurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvendacli:=totpercvendacli+perc;
   totalvalorvendacli:=totalvalorvendacli+valorunitario;
//
   FRel.AddCel('Reserva T�cnica');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_reserva').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_reserva').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvenda:=totpercvenda+Q.fieldbyname('orcc_reserva').ascurrency;
   totvalorvenda:=totvalorvenda+valorunitario;
   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_reserva').ascurrency/100);
   if Q.fieldbyname('orcc_ofertacliente').ascurrency>0 then
     perc:=(valorunitario/Q.fieldbyname('orcc_ofertacliente').ascurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvendacli:=totpercvendacli+perc;
   totalvalorvendacli:=totalvalorvendacli+valorunitario;
// retirado frete - 23.09.10
{
   FRel.AddCel('Fretes');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_fretes').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_fretes').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvenda:=totpercvenda+Q.fieldbyname('orcc_fretes').ascurrency;
   totvalorvenda:=totvalorvenda+valorunitario;
   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_fretes').ascurrency/100);
   if Q.fieldbyname('orcc_ofertacliente').ascurrency>0 then
     perc:=(valorunitario/Q.fieldbyname('orcc_ofertacliente').ascurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvendacli:=totpercvendacli+perc;
   totalvalorvendacli:=totalvalorvendacli+valorunitario;
}

//
   FRel.AddCel('Custo Fixo M�dia');
   FRel.AddCel('');
   FRel.AddCel('');
   if xTipoVenda=TipoVendaServicos then
     valorunitario:=Q.fieldbyname('orcc_custoobra').ascurrency*(Q.fieldbyname('orcc_custofixo').ascurrency/100)
   else
     valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_custofixo').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_custofixo').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvenda:=totpercvenda+Q.fieldbyname('orcc_custofixo').ascurrency;
   totvalorvenda:=totvalorvenda+valorunitario;
   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_custofixo').ascurrency/100);
   if Q.fieldbyname('orcc_ofertacliente').ascurrency>0 then
     perc:=(valorunitario/Q.fieldbyname('orcc_ofertacliente').ascurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvendacli:=totpercvendacli+perc;
   totalvalorvendacli:=totalvalorvendacli+valorunitario;

// 10.09.10
   FRel.AddCel('Construcard');
   FRel.AddCel('');
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_construcard').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_construcard').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvenda:=totpercvenda+Q.fieldbyname('orcc_construcard').ascurrency;
   totvalorvenda:=totvalorvenda+valorunitario;
   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_construcard').ascurrency/100);
   if Q.fieldbyname('orcc_ofertacliente').ascurrency>0 then
     perc:=(valorunitario/Q.fieldbyname('orcc_ofertacliente').ascurrency)*100
   else
     perc:=0;
   FRel.AddCel(transform(perc,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
   totpercvendacli:=totpercvendacli+perc;
   totalvalorvendacli:=totalvalorvendacli+valorunitario;


   FGEral.ImprimelinhaRel(colunas,replicate('-',70));

   FGEral.PulalinhaRel(colunas,4,transform(totpercvenda,f_cr),5,transform(totvalorvenda,f_cr),7,transform(totpercvendacli,f_cr),8,transform(totalvalorvendacli,f_cr) );

   FGEral.PulalinhaRel(colunas);

   FRel.AddCel('MARGEM DE LUCRO');
   FRel.AddCel('');
   FRel.AddCel('');
   if xTipoVenda=TipoVendaServicos then
     valorunitario:=Q.fieldbyname('orcc_custoobra').ascurrency*(Q.fieldbyname('orcc_margem').ascurrency/100)
   else
     valorunitario:=Q.fieldbyname('orcc_venda').ascurrency*(Q.fieldbyname('orcc_margem').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_margem').ascurrency,f_cr));
   FRel.AddCel( transform(valorunitario,f_cr));
   FRel.AddCel('');
   valorunitario:=Q.fieldbyname('orcc_ofertacliente').ascurrency*(Q.fieldbyname('orcc_margemcli').ascurrency/100);
   FRel.AddCel(transform(Q.fieldbyname('orcc_margemcli').ascurrency,f_cr));
   FRel.AddCel(transform(valorunitario,f_cr));
   FRel.AddCel('');
//
   FRel.AddCel('Markup Divisor');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel(transform(Edorca_divisor.ascurrency,f_cr3));
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel(transform(EdOrca_divisorcli.ascurrency,f_cr3));
   FRel.AddCel('');
   FRel.AddCel('');
//
   FRel.AddCel('Markup Multiplicador');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel(transform(EdOrcam_multi.ascurrency,f_cr3));
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel(transform(EdOrcam_multicli.ascurrency,f_cr3));
   FRel.AddCel('');
   FRel.AddCel('');

   FGEral.ImprimelinhaRel(colunas,replicate('-',70));
   FGEral.PulalinhaRel(colunas);
   FRel.AddCel('REF. PARA TOMADA DE DECIS�O');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
//
   FRel.AddCel('Pre�o de Venda por metro quadrado');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   if FOrcamentos.EdOrca_area.asfloat>0 then
     FRel.AddCel(transform(Q.fieldbyname('orcc_venda').ascurrency/FOrcamentos.EdOrca_area.asfloat,f_cr))
   else
    FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
//
   FRel.AddCel('Pre�o de Venda por KG l�quido');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   if EdPesoliquido.asfloat>0 then
     FRel.AddCel(transform(Q.fieldbyname('orcc_venda').ascurrency/EdPesoliquido.asfloat,f_cr))
   else
    FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
//
   FRel.AddCel('Pre�o de Venda por KG Real');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   if EdRealtotal.asfloat>0 then
     FRel.AddCel(transform(Q.fieldbyname('orcc_venda').ascurrency/EdRealtotal.asfloat,f_cr))
   else
    FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');

   FGEral.PulalinhaRel(colunas);
   FGEral.PulalinhaRel(colunas);
   FGEral.PulalinhaRel(colunas,1,replicate('_',70));
//   FGEral.ImprimelinhaRel(colunas,replicate('_',70));
   FRel.AddCel('Consultor de Venda');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');

   FGEral.PulalinhaRel(colunas);
   FGEral.PulalinhaRel(colunas);
   FGEral.PulalinhaRel(colunas,1,replicate('_',70));
   FRel.AddCel('Gerente Comercial');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');
   FRel.AddCel('');

   FREl.Video;

   Sistema.endProcess('');
   FGeral.FechaQuery(QOrc);
   FGeral.FechaQuery(Q);
   FGeral.FechaQuery(QTratT);
   FGeral.FechaQuery(QTratS);
   FGeral.FechaQuery(QTratV);
   FGeral.FechaQuery(QTratA);
   FGeral.FechaQuery(QTratC);
   FGeral.FechaQuery(QIns);


end;

procedure TFFormacaoPreco.EfetuarDesconto(Ed1, Ed2, Ed3, Ed4, Ed5, Ed6,
  Ed7, Ed8, Ed9, Ed10:TSqled);
var des:currency;
begin
   if EdDesconto01.AsCurrency>0 then begin
     des:=EdDesconto01.AsCurrency;
     if Ed1.AsCurrency>0 then
       Ed1.SetValue( Ed1.ascurrency-(Ed1.ascurrency*(Des/100)));
     if Ed2.AsCurrency>0 then
       Ed2.SetValue( Ed2.ascurrency-(Ed2.ascurrency*(Des/100)));
     if Ed3.AsCurrency>0 then
       Ed3.SetValue( Ed3.ascurrency-(Ed3.ascurrency*(Des/100)));
     if Ed4.AsCurrency>0 then
       Ed4.SetValue( Ed4.ascurrency-(Ed4.ascurrency*(Des/100)));
     if Ed5.AsCurrency>0 then
       Ed5.SetValue( Ed5.ascurrency-(Ed5.ascurrency*(Des/100)));
     if Ed6.AsCurrency>0 then
       Ed6.SetValue( Ed6.ascurrency-(Ed6.ascurrency*(Des/100)));
     if Ed7.AsCurrency>0 then
       Ed7.SetValue( Ed7.ascurrency-(Ed7.ascurrency*(Des/100)));
     if Ed8.AsCurrency>0 then
       Ed8.SetValue( Ed8.ascurrency-(Ed8.ascurrency*(Des/100)));
     if Ed9.AsCurrency>0 then
       Ed9.SetValue( Ed9.ascurrency-(Ed9.ascurrency*(Des/100)));
     if Ed10.AsCurrency>0 then
       Ed10.SetValue( Ed10.ascurrency-(Ed10.ascurrency*(Des/100)));
   end;
end;

procedure TFFormacaoPreco.GridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var s:string;
    t:integer;
begin

  if (not (gdSelected in State)) and (ARow>0) and
     ( (Acol=Grid.Getcolumn('paca_quando')) or (Acol=Grid.Getcolumn('percperda')) )
     and ( trim(Grid.Cells[Grid.GetColumn('id'),aRow])<>'' ) then begin

//           Grid.Canvas.Brush.Color := clBlue;
// 22.09.10
           Grid.Canvas.Brush.Color := clYellow;
           s:=Grid.Cells[ACol,ARow];
           Grid.Canvas.FillRect(Rect);
           t:=Grid.Canvas.TextWidth(s)+2;
           if Grid.Columns[ACol].Alignment=taRightJustify then
              Grid.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else Grid.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
  end;

end;

procedure TFFormacaoPreco.bincluiviClick(Sender: TObject);
begin
  pvidrosdigitacao.enabled:=true;
  EdCodigovi.setfocus;

end;

procedure TFFormacaoPreco.balteraviClick(Sender: TObject);
begin
  if trim(GridVidros.cells[GridVidros.getcolumn('orcd_codigo'),GridVidros.row])<>'' then begin
    pvidrosdigitacao.enabled:=true;
    EdCodigovi.text:=GridVidros.cells[DtGrid.getcolumn('orcd_codigo'),GridVidros.row];
    EdDescricaovi.text:=GridVidros.cells[GridVidros.getcolumn('orcd_descricao'),GridVidros.row];
    Edorcd_qtdevi.text:=GridVidros.Cells[GridVidros.getcolumn('orcd_qtde'),GridVidros.row];
    Edorcd_unidadevi.text:=GridVidros.Cells[GridVidros.getcolumn('orcd_unidade'),GridVidros.row];
    Edorcd_unitariovi.text:=GridVidros.Cells[GridVidros.getcolumn('orcd_unitario'),GridVidros.row];
    Edorcd_qtdevi.setfocus;
  end;

end;

procedure TFFormacaoPreco.bexcluiviClick(Sender: TObject);
begin
  if not confirma('Confirma exclus�o') then exit;
  GridVidros.DeleteRow(GridVidros.Row);
  MudouVidro:='S';

end;

procedure TFFormacaoPreco.bcancelaviClick(Sender: TObject);
begin
  pvidrosdigitacao.enabled:=false;

end;

procedure TFFormacaoPreco.Edorcd_unitarioviExitEdit(Sender: TObject);
begin
  pvidrosdigitacao.enabled:=false;
  if Confirma('Confirma ?') then
    EditstoGridVidro;

end;

procedure TFFormacaoPreco.EditstoGridVidro;
var x:integer;
    totalitem:currency;
begin
  x:=FGeral.ProcuraGrid(GridVidros.getcolumn('orcd_codigo'),EdCodigovi.Text,GridVidros);
  if x<=0 then begin
    if (GridVidros.RowCount=2) and (Trim(GridVidros.Cells[GridVidros.getcolumn('orcd_codigo'),1])='') then begin
       x:=1;
    end else begin
       GridVidros.RowCount:=GridVidros.RowCount+1;
       x:=GridVidros.RowCount-1;
    end;
    totalitem:=Edorcd_unitariovi.asfloat*Edorcd_qtdevi.asfloat;
    GridVidros.Cells[GridVidros.getcolumn('orcd_codigo'),Abs(x)]:=EdCodigovi.Text;
    GridVidros.Cells[GridVidros.getcolumn('orcd_descricao'),Abs(x)]:=EdDescricaovi.Text;
    GridVidros.Cells[GridVidros.getcolumn('orcd_qtde'),Abs(x)]:=Edorcd_qtdevi.text;
    GridVidros.Cells[GridVidros.getcolumn('orcd_unidade'),Abs(x)]:=Edorcd_unidadevi.text;
    GridVidros.Cells[GridVidros.getcolumn('orcd_unitario'),Abs(x)]:=Edorcd_unitariovi.text;
    GridVidros.Cells[GridVidros.getcolumn('totalitem'),Abs(x)]:=floattostr(totalitem);
  end else begin
    totalitem:=Edorcd_unitariovi.asfloat*Edorcd_qtdevi.asfloat;
    GridVidros.Cells[GridVidros.getcolumn('orcd_codigo'),Abs(x)]:=EdCodigovi.Text;
    GridVidros.Cells[GridVidros.getcolumn('orcd_descricao'),Abs(x)]:=EdDescricaovi.Text;
    GridVidros.Cells[GridVidros.getcolumn('orcd_qtde'),Abs(x)]:=Edorcd_qtdevi.text;
    GridVidros.Cells[GridVidros.getcolumn('orcd_unidade'),Abs(x)]:=Edorcd_unidadevi.text;
    GridVidros.Cells[GridVidros.getcolumn('orcd_unitario'),Abs(x)]:=Edorcd_unitariovi.text;
    GridVidros.Cells[GridVidros.getcolumn('totalitem'),Abs(x)]:=floattostr(totalitem);
  end;
  MudouVidro:='S';
end;

procedure TFFormacaoPreco.EdCodigoviExit(Sender: TObject);
begin
   if (not EdCodigovi.empty) and (EdCodigovi.resultfind<>nil) then begin
     EdOrcd_unidadevi.text:=EdCodigovi.resultfind.fieldbyname('esto_unidade').asstring;
     EdOrcd_unitariovi.SetValue( FEstoque.GetCusto(EdCodigovi.text,Global.CodigoUnidade,'custo') );
   end;
end;

procedure TFFormacaoPreco.bincluiacesClick(Sender: TObject);
begin
  pacesdigitacao.enabled:=true;
  EdCodigoac.setfocus;
end;

procedure TFFormacaoPreco.balteraracesClick(Sender: TObject);
begin
  if trim(GridAces.cells[GridAces.getcolumn('orcd_codigo'),GridAces.row])<>'' then begin
    pacesdigitacao.enabled:=true;
    EdCodigoac.text:=GridAces.cells[GridAces.getcolumn('orcd_codigo'),GridAces.row];
    EdDescricaoac.text:=GridAces.cells[GridAces.getcolumn('orcd_descricao'),GridAces.row];
    Edorcd_qtdeac.text:=GridAces.Cells[GridAces.getcolumn('orcd_qtde'),GridAces.row];
    Edorcd_unidadeac.text:=GridAces.Cells[GridAces.getcolumn('orcd_unidade'),GridAces.row];
    Edorcd_unitarioac.text:=GridAces.Cells[GridAces.getcolumn('orcd_unitario'),GridAces.row];
    Edorcd_qtdeac.setfocus;
  end;

end;

procedure TFFormacaoPreco.bexcluiacesClick(Sender: TObject);
begin
  if not confirma('Confirma exclus�o') then exit;
  GridAces.DeleteRow(GridAces.Row);
  MudouAcessorios:='S';


end;

procedure TFFormacaoPreco.bcancelaacesClick(Sender: TObject);
begin
  pacesdigitacao.enabled:=false;

end;

procedure TFFormacaoPreco.EdCodigoacExit(Sender: TObject);
begin
   if (not EdCodigoac.empty) and (EdCodigoac.resultfind<>nil) then begin
     EdOrcd_unidadeac.text:=EdCodigoac.resultfind.fieldbyname('esto_unidade').asstring;
     EdOrcd_unitarioac.SetValue( FEstoque.GetCusto(EdCodigoac.text,Global.CodigoUnidade,'custo') );
   end;

end;

procedure TFFormacaoPreco.Edorcd_unitarioacExitEdit(Sender: TObject);
begin
  pacesdigitacao.enabled:=false;
  if Confirma('Confirma ?') then
    EditstoGridAces

end;

procedure TFFormacaoPreco.EditstoGridAces;
/////////////////////////////////////////////////////
var x:integer;
    totalitem:currency;
begin
  x:=FGeral.ProcuraGrid(GridAces.getcolumn('orcd_codigo'),EdCodigoac.Text,GridAces);
  if x<=0 then begin
    if (GridAces.RowCount=2) and (Trim(GridAces.Cells[GridAces.getcolumn('orcd_codigo'),1])='') then begin
       x:=1;
    end else begin
       GridAces.RowCount:=GridAces.RowCount+1;
       x:=GridAces.RowCount-1;
    end;
    totalitem:=Edorcd_unitarioac.asfloat*Edorcd_qtdeac.asfloat;
    GridAces.Cells[GridAces.getcolumn('orcd_codigo'),Abs(x)]:=EdCodigoac.Text;
    GridAces.Cells[GridAces.getcolumn('orcd_descricao'),Abs(x)]:=EdDescricaoac.Text;
    GridAces.Cells[GridAces.getcolumn('orcd_qtde'),Abs(x)]:=Edorcd_qtdeac.text;
    GridAces.Cells[GridAces.getcolumn('orcd_unidade'),Abs(x)]:=Edorcd_unidadeac.text;
    GridAces.Cells[GridAces.getcolumn('orcd_unitario'),Abs(x)]:=Edorcd_unitarioac.text;
    GridAces.Cells[GridAces.getcolumn('totalitem'),Abs(x)]:=floattostr(totalitem);
  end else begin
    totalitem:=Edorcd_unitarioac.asfloat*Edorcd_qtdeac.asfloat;
    GridAces.Cells[GridAces.getcolumn('orcd_codigo'),Abs(x)]:=EdCodigoac.Text;
    GridAces.Cells[GridAces.getcolumn('orcd_descricao'),Abs(x)]:=EdDescricaoac.Text;
    GridAces.Cells[GridAces.getcolumn('orcd_qtde'),Abs(x)]:=Edorcd_qtdeac.text;
    GridAces.Cells[GridAces.getcolumn('orcd_unidade'),Abs(x)]:=Edorcd_unidadeac.text;
    GridAces.Cells[GridAces.getcolumn('orcd_unitario'),Abs(x)]:=Edorcd_unitarioac.text;
    GridAces.Cells[GridAces.getcolumn('totalitem'),Abs(x)]:=floattostr(totalitem);
  end;
  MudouAcessorios:='S';
end;

procedure TFFormacaoPreco.bincluirtelasClick(Sender: TObject);
begin
  ptelasdigitacao.enabled:=true;
  EdCodigote.setfocus;

end;

procedure TFFormacaoPreco.balterartelasClick(Sender: TObject);
begin
  if trim(GridTelas.cells[GridTelas.getcolumn('orcd_codigo'),GridTelas.row])<>'' then begin
    ptelasdigitacao.enabled:=true;
    EdCodigote.text:=GridTelas.cells[GridTelas.getcolumn('orcd_codigo'),GridTelas.row];
    EdDescricaote.text:=GridTelas.cells[GridTelas.getcolumn('orcd_descricao'),GridTelas.row];
    Edorcd_qtdete.text:=GridTelas.Cells[GridTelas.getcolumn('orcd_qtde'),GridTelas.row];
    Edorcd_unidadete.text:=GridTelas.Cells[GridTelas.getcolumn('orcd_unidade'),GridTelas.row];
    Edorcd_unitariote.text:=GridTelas.Cells[GridTelas.getcolumn('orcd_unitario'),GridTelas.row];
    Edorcd_qtdete.setfocus;
  end;

end;

procedure TFFormacaoPreco.bexluirtelasClick(Sender: TObject);
begin
  if not confirma('Confirma exclus�o') then exit;
  GridTelas.DeleteRow(GridTelas.Row);
  MudouTela:='S';


end;

procedure TFFormacaoPreco.EdCodigoteExit(Sender: TObject);
begin
   if (not EdCodigote.empty) and (EdCodigote.resultfind<>nil) then begin
     EdOrcd_unidadete.text:=EdCodigote.resultfind.fieldbyname('esto_unidade').asstring;
     EdOrcd_unitariote.SetValue( FEstoque.GetCusto(EdCodigote.text,Global.CodigoUnidade,'custo') );
   end;
end;

procedure TFFormacaoPreco.Edorcd_unitarioteExitEdit(Sender: TObject);
begin
  ptelasdigitacao.enabled:=false;
  if Confirma('Confirma ?') then
    EditstoGridTela;


end;

procedure TFFormacaoPreco.EditstoGridTela;
var x:integer;
    totalitem:currency;
begin
  x:=FGeral.ProcuraGrid(GridTelas.getcolumn('orcd_codigo'),EdCodigovi.Text,GridTelas);
  if x<=0 then begin
    if (GridTelas.RowCount=2) and (Trim(GridTelas.Cells[GridTelas.getcolumn('orcd_codigo'),1])='') then begin
       x:=1;
    end else begin
       GridTelas.RowCount:=GridTelas.RowCount+1;
       x:=GridTelas.RowCount-1;
    end;
    totalitem:=Edorcd_unitariote.asfloat*Edorcd_qtdete.asfloat;
    GridTelas.Cells[GridTelas.getcolumn('orcd_codigo'),Abs(x)]:=EdCodigote.Text;
    GridTelas.Cells[GridTelas.getcolumn('orcd_descricao'),Abs(x)]:=EdDescricaote.Text;
    GridTelas.Cells[GridTelas.getcolumn('orcd_qtde'),Abs(x)]:=Edorcd_qtdete.text;
    GridTelas.Cells[GridTelas.getcolumn('orcd_unidade'),Abs(x)]:=Edorcd_unidadete.text;
    GridTelas.Cells[GridTelas.getcolumn('orcd_unitario'),Abs(x)]:=Edorcd_unitariote.text;
    GridTelas.Cells[GridTelas.getcolumn('totalitem'),Abs(x)]:=floattostr(totalitem);
  end else begin
    totalitem:=Edorcd_unitariote.asfloat*Edorcd_qtdete.asfloat;
    GridTelas.Cells[GridTelas.getcolumn('orcd_codigo'),Abs(x)]:=EdCodigote.Text;
    GridTelas.Cells[GridTelas.getcolumn('orcd_descricao'),Abs(x)]:=EdDescricaote.Text;
    GridTelas.Cells[GridTelas.getcolumn('orcd_qtde'),Abs(x)]:=Edorcd_qtdete.text;
    GridTelas.Cells[GridTelas.getcolumn('orcd_unidade'),Abs(x)]:=Edorcd_unidadete.text;
    GridTelas.Cells[GridTelas.getcolumn('orcd_unitario'),Abs(x)]:=Edorcd_unitariote.text;
    GridTelas.Cells[GridTelas.getcolumn('totalitem'),Abs(x)]:=floattostr(totalitem);
  end;
  MudouTela:='S';
end;

procedure TFFormacaoPreco.bincluirpClick(Sender: TObject);
begin
  perfdigitacao.enabled:=true;
  EdCodigop.setfocus;

end;

procedure TFFormacaoPreco.balterarpClick(Sender: TObject);
begin
  if trim(Grid.cells[Grid.getcolumn('id'),Grid.row])<>'' then begin
    perfdigitacao.enabled:=true;
    EdCodigop.text:=Grid.cells[Grid.getcolumn('id'),Grid.row];
    EdPesoBrutop.text:=Grid.cells[Grid.getcolumn('pesobruto'),Grid.row];
    EdPesoSobrap.text:=Grid.cells[Grid.getcolumn('pesosobra'),Grid.row];
    EdPercSobrap.text:=Grid.cells[Grid.getcolumn('percsobrabruta'),Grid.row];
    EdPercperdap.text:=Grid.cells[Grid.getcolumn('percperda'),Grid.row];
    EdPesorealp.text:=Grid.cells[Grid.getcolumn('pesoreal'),Grid.row];
    EdUnitariop.text:=Grid.cells[Grid.getcolumn('precouni'),Grid.row];
    EdCodigop.setfocus;
  end;

end;

procedure TFFormacaoPreco.bexcluirpClick(Sender: TObject);
begin
  if not confirma('Confirma exclus�o') then exit;
  Grid.DeleteRow(Grid.Row);
  MudouPerfil:='S';

end;

procedure TFFormacaoPreco.bcancelarpClick(Sender: TObject);
begin
  perfdigitacao.enabled:=false;

end;

procedure TFFormacaoPreco.EdUnitariopExitEdit(Sender: TObject);
begin
  perfdigitacao.enabled:=false;
  if Confirma('Confirma ?') then
    EditstoGridPerfis;

end;

procedure TFFormacaoPreco.EditstoGridPerfis;
var x:integer;
    totalitem:currency;
begin
  x:=FGeral.ProcuraGrid(Grid.getcolumn('id'),EdCodigop.Text,Grid);
  if x<=0 then begin
    if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.getcolumn('id'),1])='') then begin
       x:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       x:=Grid.RowCount-1;
    end;
    totalitem:=Edunitariop.asfloat*EdPesorealp.asfloat;
    Grid.Cells[Grid.getcolumn('id'),x]:=EdCodigop.text;
    Grid.Cells[Grid.getcolumn('pesobruto'),x]:=EdPESOBRUTOp.text;
    Grid.Cells[Grid.getcolumn('pesosobra'),x]:=EdPESOSOBRAp.text;
    Grid.Cells[Grid.getcolumn('PERCSOBRABRUTA'),x]:=EdPERCSOBRAp.text;
    Grid.Cells[Grid.getcolumn('PERCPERDA'),x]:=EdPercPerdap.text;
    Grid.Cells[Grid.getcolumn('PESOREAL'),x]:=EdPesorealp.text;
    Grid.Cells[Grid.getcolumn('precouni'),x]:=EdUnitariop.text;
    Grid.Cells[Grid.getcolumn('custopeca'),x]:=formatfloat('##0.000',totalitem);
//    if Edorca_custoobra.ascurrency>0 then
//      Grid.Cells[Grid.getcolumn('perctotal'),linhagrid]:=formatfloat('##0.00',(Q.fieldbyname('orin_CUSTOPECA').asfloat/Edorca_custoobra.ascurrency)*100)
//    else
//      Grid.Cells[Grid.getcolumn('perctotal'),linhagrid]:='';
  end else begin
    totalitem:=Edunitariop.asfloat*EdPesorealp.asfloat;
    Grid.Cells[Grid.getcolumn('id'),Abs(x)]:=EdCodigop.text;
    Grid.Cells[Grid.getcolumn('pesobruto'),Abs(x)]:=EdPESOBRUTOp.text;
    Grid.Cells[Grid.getcolumn('pesosobra'),Abs(x)]:=EdPESOSOBRAp.text;
    Grid.Cells[Grid.getcolumn('PERCSOBRABRUTA'),Abs(x)]:=EdPERCSOBRAp.text;
    Grid.Cells[Grid.getcolumn('PERCPERDA'),Abs(x)]:=EdPercPerdap.text;
    Grid.Cells[Grid.getcolumn('PESOREAL'),Abs(x)]:=EdPesorealp.text;
    Grid.Cells[Grid.getcolumn('precouni'),Abs(x)]:=EdUnitariop.text;
    Grid.Cells[Grid.getcolumn('custopeca'),Abs(x)]:=formatfloat('##0.000',totalitem);
  end;

  MudouPerfil:='S';

end;

procedure TFFormacaoPreco.EdPercperdapValidate(Sender: TObject);
var pesoreal:extended;
begin
  if EdPercperdap.ascurrency>0 then begin
    pesoreal:=EdPESOBRUTOp.asfloat - (EdPESOBRUTOp.asfloat*(EdPERCSOBRAp.ascurrency-EdPercperdap.ascurrency))/100;
    EdPESOREALp.setvalue(pesoreal);
  end;
end;

function TFFormacaoPreco.Inteiro(valor: real; sinal: string;
  quanto: integer): real;
begin
   if valor-int(valor)=0 then begin
     result:=valor;
     end else begin
     if sinal='+' then
       result:=Int(valor)+quanto
     else
       result:=Int(valor);
   end;
end;

procedure TFFormacaoPreco.EdUnitarioExitEdit(Sender: TObject);
var custopeca:extended;
begin
   EdUnitario.Enabled:=false;
   EdUnitario.Visible:=false;
   if EdUnitario.ascurrency>=0 then begin
    custopeca:=Texttovalor(Grid.Cells[Grid.getcolumn('PESOREAL'),Grid.row]) * EdUnitario.AsCurrency;
    Grid.Cells[Grid.getcolumn('precouni'),Grid.row]:=formatfloat('##,##0.000',EdUNitario.ascurrency);
    Grid.Cells[Grid.getcolumn('custopeca'),Grid.row]:=formatfloat('##,##0.000',Texttovalor(Grid.Cells[Grid.getcolumn('precouni'),Grid.row])*Texttovalor(Grid.Cells[Grid.getcolumn('pesoreal'),Grid.row]) );
   end;
   Grid.setfocus;

end;

procedure TFFormacaoPreco.EdOrca_margemcliExitEdit(Sender: TObject);
begin
  if EdOrca_margemcli.AsCurrency>0 then
    CalculaPreco;
end;

procedure TFFormacaoPreco.EdvlrentradaExit(Sender: TObject);
begin
   EdVlrcalculo.setvalue(EdVlrvenda.ascurrency-EdVlrEntrada.ascurrency);
end;

procedure TFFormacaoPreco.EdFpgto_codigoExit(Sender: TObject);
begin
  Ednparcelas.text:=inttostr( FCondpagto.GetNumeroParcelas(EdFpgto_codigo.text) ) ;
end;

procedure TFFormacaoPreco.bcalcparcelasClick(Sender: TObject);
begin
   PreencheGridPrazos;
end;

procedure TFFormacaoPreco.GridPrazosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var s,nomecoluna:string;
    t:integer;
begin
  nomecoluna:='orcd_'+trim(EdNParcelas.text);
  if (not (gdSelected in State)) and (ARow>0) and
     (  Acol=GridPrazos.Getcolumn( nomecoluna )  )
     and ( trim(GridPrazos.Cells[GridPrazos.GetColumn('orcd_codigo'),aRow])<>'' ) then begin

           GridPrazos.Canvas.Brush.Color := clBlue;
           s:=GridPrazos.Cells[ACol,ARow];
           GridPrazos.Canvas.FillRect(Rect);
           t:=GridPrazos.Canvas.TextWidth(s)+2;
           if GridPrazos.Columns[ACol].Alignment=taRightJustify then
              GridPrazos.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else GridPrazos.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
  end;

end;

procedure TFFormacaoPreco.baprovaClick(Sender: TObject);
var Q:TSqlquery;
begin
  Q:=sqltoquery('select orcc_situacao,orcc_nome from orcamencal'+
               ' where orcc_status=''N'' and orcc_numerodoc='+inttostr(numero)+
               ' and orcc_unid_codigo='+stringtosql(Global.CodigoUnidade)+
               ' and orcc_situacao='+Stringtosql(SitAprovada)+
               ' and orcc_nome<>'+Stringtosql(NomeOrcam) );
  if (not Q.Eof) and (baprova.Tag=0) then
    Avisoerro('Op��o '+Q.fieldbyname('orcc_nome').asstring+' deste or�amento j� aprovada')
  else if (Q.Eof) and (baprova.Tag=1) then begin
    Sistema.Edit('orcamencal');
    Sistema.SetField('orcc_situacao','');
    Sistema.Post('orcc_status=''N'' and orcc_numerodoc='+inttostr(numero)+
               ' and orcc_nome='+Stringtosql(NomeOrcam)+
               ' and orcc_unid_codigo='+stringtosql(Global.CodigoUnidade) );
    Sistema.Commit;
    SetaBotaoAprova(' ');
  end else begin
    Sistema.Edit('orcamencal');
    Sistema.SetField('orcc_situacao',sitaprovada);
    Sistema.Post('orcc_status=''N'' and orcc_numerodoc='+inttostr(numero)+
               ' and orcc_nome='+Stringtosql(NomeOrcam)+
               ' and orcc_unid_codigo='+stringtosql(Global.CodigoUnidade) );
// 22.05.13
    if ( trim(FGeral.GetConfig1AsString('usuariosfaturamento'))<>'' )  and (Confirma('Gerar aviso pra faturamento ?')) then begin
       FGeral.PlanoAcaoSistema(numero,FGeral.GetConfig1AsString('usuariosfaturamento')
                ,Global.codigounidade,
                'FATURAMENTO CONTRATO','Or�amento '+inttostr(numero)+' Aprovado ',
                EdOrca_venda.ascurrency )
    end;
///////////////
    Sistema.Commit;
    SetaBotaoAprova(SitAprovada);
  end;
  FGeral.FechaQuery(Q);
end;

procedure TFFormacaoPreco.SetaBotaoAprova(Situacao: string);
begin
   if situacao=SitAprovada then begin
     baprova.Caption:='  APROVADA  ';
     baprova.Tag:=1;
   end else begin
     baprova.Caption:='N�O APROVADA';
     baprova.Tag:=0;
   end;
   baprova.Update;
end;

procedure TFFormacaoPreco.EdFpgto_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.Limpaedit(EdFpgto_codigo,key);
end;

//
procedure TFFormacaoPreco.Edorcd_unitarioperfissacExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////////
begin
//  paperfissacdigitacao.enabled:=false;
  if Confirma('Confirma ?') then
    EditstoGridPerfisSac;
  EdCodigoPerfissac.clear;
  EdCodigoPerfissac.SetFocus;


end;

// 17.07.13
procedure TFFormacaoPreco.EditstoGridPerfisSac;
//////////////////////////////////////////////////
var x:integer;
    totalitem:currency;
begin
  x:=FGeral.ProcuraGrid(GridPerfisSac.getcolumn('orcd_codigo'),EdCodigoperfissac.Text,GridPerfisSac);
  if x<=0 then begin
    if (GridPerfisSac.RowCount=2) and (Trim(GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_codigo'),1])='') then begin
       x:=1;
    end else begin
       GridPerfisSac.RowCount:=GridPerfisSac.RowCount+1;
       x:=GridPerfisSac.RowCount-1;
       if x>1 then x:=x-1;  // 18.07.13
    end;
    totalitem:=Edorcd_unitarioPerfisSac.asfloat*Edorcd_qtdePerfisSac.asfloat;
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_codigo'),Abs(x)]:=EdCodigoPerfisSac.Text;
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('esto_referencia'),Abs(x)]:=FEStoque.getreferencia(EdCodigoPerfisSac.Text);
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_descricao'),Abs(x)]:=EdDescricaoPerfisSac.Text;
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_qtde'),Abs(x)]:=Edorcd_qtdePerfisSac.text;
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_unidade'),Abs(x)]:=Edorcd_unidadePerfisSac.text;
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_unitario'),Abs(x)]:=Edorcd_unitarioPerfisSac.text;
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('totalitem'),Abs(x)]:=floattostr(totalitem);
    if campo.Tipo<>'' then begin
      GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_tama_codigo'),Abs(x)]:=Edcodtamanhops.text;
      GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_core_codigo'),Abs(x)]:=Edcodcorps.text;
      GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_peso'),Abs(x)]:=Edpesops.text;
      GridPerfisSac.Cells[GridPerfisSac.getcolumn('tamanho'),Abs(x)]:=FTamanhos.GetDescricao(Edcodtamanhops.asinteger);
      GridPerfisSac.Cells[GridPerfisSac.getcolumn('cor'),Abs(x)]:=FCores.GetDescricao(Edcodcorps.asinteger);
    end;
  end else begin
    totalitem:=Edorcd_unitarioPerfisSac.asfloat*Edorcd_qtdePerfisSac.asfloat;
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_codigo'),Abs(x)]:=EdCodigoPerfisSac.Text;
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('esto_referencia'),Abs(x)]:=FEStoque.getreferencia(EdCodigoPerfisSac.Text);
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_descricao'),Abs(x)]:=EdDescricaoPerfisSac.Text;
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_qtde'),Abs(x)]:=Edorcd_qtdePerfisSac.text;
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_unidade'),Abs(x)]:=Edorcd_unidadePerfisSac.text;
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_unitario'),Abs(x)]:=Edorcd_unitarioPerfisSac.text;
    GridPerfisSac.Cells[GridPerfisSac.getcolumn('totalitem'),Abs(x)]:=floattostr(totalitem);
    if campo.Tipo<>'' then begin
      GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_tama_codigo'),Abs(x)]:=Edcodtamanhops.text;
      GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_core_codigo'),Abs(x)]:=Edcodcorps.text;
      GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_peso'),Abs(x)]:=Edpesops.text;
      GridPerfisSac.Cells[GridPerfisSac.getcolumn('tamanho'),Abs(x)]:=FTamanhos.GetDescricao(Edcodtamanhops.asinteger);
      GridPerfisSac.Cells[GridPerfisSac.getcolumn('cor'),Abs(x)]:=FCores.GetDescricao(Edcodcorps.asinteger);
    end;
  end;
  MudouPerfisSac:='S';
end;

procedure TFFormacaoPreco.bincluiperfissacClick(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
  paperfissacdigitacao.enabled:=true;
  EdCodigoperfissac.setfocus;

end;

procedure TFFormacaoPreco.balterarperfissacClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
begin
  if trim(GridPerfisSac.cells[GridPerfisSac.getcolumn('orcd_codigo'),GridPerfisSac.row])<>'' then begin
    paperfissacdigitacao.enabled:=true;
    EdCodigoperfissac.text:=GridPerfisSac.cells[GridPerfisSac.getcolumn('orcd_codigo'),GridPerfisSac.row];
    EdDescricaoperfissac.text:=GridPerfisSac.cells[GridPerfisSac.getcolumn('orcd_descricao'),GridPerfisSac.row];
    Edorcd_qtdeperfissac.text:=GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_qtde'),GridPerfisSac.row];
    Edorcd_unidadeperfissac.text:=GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_unidade'),GridPerfisSac.row];
    Edorcd_unitarioperfissac.text:=GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_unitario'),GridPerfisSac.row];
    if campo.Tipo<>'' then begin
      Edcodtamanhops.text:=GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_tama_codigo'),GridPerfisSac.row];
      Edcodcorps.text:=GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_core_codigo'),GridPerfisSac.row];
      Edpesops.text:=GridPerfisSac.Cells[GridPerfisSac.getcolumn('orcd_peso'),GridPerfisSac.row];
      SetEdTamanho.text:=GridPerfisSac.Cells[GridPerfisSac.getcolumn('tamanho'),GridPerfisSac.row];
      SetEdCor.text:=GridPerfisSac.Cells[GridPerfisSac.getcolumn('cor'),GridPerfisSac.row];
    end;
    Edorcd_qtdeperfissac.setfocus;
  end;

end;

procedure TFFormacaoPreco.bcancelaperfissacClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////
begin
  paperfissacdigitacao.enabled:=false;

end;

procedure TFFormacaoPreco.EdCodigoperfissacValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
begin
    if Global.Usuario.OutrosAcessos[0504] then
      QBusca:=FEstoque.BuscaporReferenciaouCodigo(EdCodigoperfissac.text)
    else
      QBusca:=sqltoquery('select * from estoque inner join grupos on ( grup_codigo=esto_grup_codigo )  where esto_Codigo='+EdCodigoperfissac.Assql);
    if not QBusca.Eof then
      EdCodigoperfissac.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
      EdCodigoperfissac.Invalid('Codigo n�o encontrado');
      exit;
    end;
    QEstoque:=sqltoquery('select * from EstoqueQtde inner join estoque on (esqt_esto_codigo=esto_codigo)'+
                       ' where esqt_status=''N'' and esqt_esto_codigo='+EdCodigoperfissac.AsSql+
                       ' and esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade));
    if QEstoque.eof then begin
       EdCodigoperfissac.INvalid('Codigo n�o encontrado no estoque da unidade '+Global.CodigoUnidade);
       bcancelaperfissacclick(self);
    end else
//      EdPesops.setvalue( QEstoque.fieldbyname('esto_peso').ascurrency );
//      EdPesops.setvalue( QEstoque.fieldbyname('esto_vendavis').ascurrency );
     EdPesops.setvalue( FEstoque.GetCusto(EdCodigoperfissac.text,Global.CodigoUnidade,'custo') );

//    if not Arq.TEstoque.active then Arq.TEstoque.open;
//    Arq.TEstoque.locate('esto_codigo',Ed.text,[]);

end;

procedure TFFormacaoPreco.EdCodigoperfissacExit(Sender: TObject);
/////////////////////////////////////////////////////////////////////////////////////////////
begin
   if (not EdCodigoperfissac.empty)  then begin
     EdOrcd_unidadeperfissac.text:=QEstoque.fieldbyname('esto_unidade').asstring;
     EdDescricaoperfissac.text:=QEstoque.fieldbyname('esto_descricao').asstring;
     EdOrcd_unitarioperfissac.SetValue( FEstoque.GetCusto(EdCodigoperfissac.text,Global.CodigoUnidade,'custo') );
   end;

end;

procedure TFFormacaoPreco.EdCodtamanhopsValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////////
var novounitario:currency;
begin
    novounitario:=Edorcd_unitarioperfissac.ascurrency*FEstoque.GetPeso(Edcodigoperfissac.text)*(FTamanhos.GetComprimento(EdCodtamanhops.asinteger)/1000);
    if edcodtamanhops.asinteger>0 then Edorcd_unitarioperfissac.setvalue(novounitario);

end;

procedure TFFormacaoPreco.bexcluiperfissacClick(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
  if not confirma('Confirma exclus�o') then exit;
  GridPerfisSac.DeleteRow(GridPerfisSac.Row);
  MudouPerfisSac:='S';

end;

procedure TFFormacaoPreco.EdPesopsValidate(Sender: TObject);
////////////////////////////////////////////////////////////
var novounitario,vendabru:currency;
begin
   if (Global.Usuario.OutrosAcessos[0506]) and (EdCodtamanhops.asinteger>0) then begin
     vendabru:=( FEstoque.GetCusto(EdCodigoperfissac.text,Global.CodigoUnidade,'custo') );
     novounitario:=FEstoque.GetPeso(EdCodigoperfissac.text)*EdPesops.ascurrency*(FTamanhos.GetComprimento(EdCodtamanhops.asinteger)/1000);
     Edorcd_unitarioperfissac.setvalue(novounitario);
   end;

end;

procedure TFFormacaoPreco.bajudaClick(Sender: TObject);
/////////////////////////////////////////////////////////
begin
// 06.08.13
 FGeral.ExecutaHelp('OrcamentoObra');

end;

procedure TFFormacaoPreco.bimporcamentoClick(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
   FImpressao.ImprimeOrcamentoObra(numero,Global.CodigoUnidade,nomeorcam);

end;

end.
