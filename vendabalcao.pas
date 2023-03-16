// 03.2013 - Venda simplificada para balc�o
//////////////////////////////////////////////
unit vendabalcao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrBase, ACBrBAL, Async32, Impr, Grids, SqlDtg, StdCtrls, Mask,
  SQLEd, Buttons, SQLBtn, alabel, ExtCtrls, SQLGrid, SqlExpr, ACBrDevice,SqlSis,
  ACBrSocket, ACBrIBPTax, ACBrNFe, ACBrDFe, ACBrDeviceSerial, Vcl.OleCtrls,
//  ShockwaveFlashObjects_TLB,
  SHDocVw,
//  ACBrGIF,
   Vcl.ComCtrls, LblEffct,
  System.ImageList, Vcl.ImgList, Jpeg;

type
  TFVendaBalcao = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bIncluiritem: TSQLBtn;
    bExcluiritem: TSQLBtn;
    bCancelaritem: TSQLBtn;
    bgeranfe: TSQLBtn;
    blebalanca1: TSQLBtn;
    blebalanca2: TSQLBtn;
    brelpendentes: TSQLBtn;
    bgravar: TSQLBtn;
    bgeraboleto: TSQLBtn;
    bcupom: TSQLBtn;
    bbaixa: TSQLBtn;
    Edtransacao: TSQLEd;
    Pbotoesgrid: TSQLPanelGrid;
    bLoadGrid: TSQLBtn;
    bSaveGrid: TSQLBtn;
    bMoveLeft: TSQLBtn;
    bMoveRight: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PTotais: TSQLPanelGrid;
    EdBaseIcms: TSQLEd;
    EdValorIcms: TSQLEd;
    EdBasesubs: TSQLEd;
    EdValorsubs: TSQLEd;
    EdTotalprodutos: TSQLEd;
    EdTotalNota: TSQLEd;
    EdValoripi: TSQLEd;
    PFinan: TSQLPanelGrid;
    PParcelas: TSQLPanelGrid;
    GridParcelas: TSqlDtGrid;
    EdVencimento: TSQLEd;
    EdParcela: TSQLEd;
    EdFpgt_codigo: TSQLEd;
    EdFpgt_descricao: TSQLEd;
    EdPort_codigo: TSQLEd;
    EdPort_descricao: TSQLEd;
    EdPeracre: TSQLEd;
    Edperdesco: TSQLEd;
    EdVlracre: TSQLEd;
    EdVlrdesco: TSQLEd;
    PRemessa: TSQLPanelGrid;
    EdCliente: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdDtemissao: TSQLEd;
    EdRepr_codigo: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdNatf_codigo: TSQLEd;
    EdNatf_descricao: TSQLEd;
    EdComv_codigo: TSQLEd;
    EdComv_descricao: TSQLEd;
    EdDtMovimento: TSQLEd;
    Edqtdetotal: TSQLEd;
    Edmargemlucro: TSQLEd;
    EdPeriss: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    EdUnitario: TSQLEd;
    EdPerdesconto: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdPecas: TSQLEd;
    Impr: TImpr;
    Edunid_codigo: TSQLEd;
    EdEmides: TSQLEd;
    EdTran_codigo: TSQLEd;
    EdDtSaida: TSQLEd;
    EdSeguro: TSQLEd;
    EdValorTroco: TSQLEd;
    EdValorRecebido: TSQLEd;
//    ACBrBAL1: TACBrBAL;
    bf11: TSQLBtn;
    bimpressao: TSQLBtn;
    EdCpf: TSQLEd;
    bvalidade: TSQLBtn;
    ACBrBAL1: TACBrBAL;
    EdFrete: TSQLEd;
    bafaturar: TSQLBtn;
    Timer: TTimer;
    ACBrNFe1: TACBrNFe;
    Timer1: TTimer;
    PBanner: TSQLPanelGrid;
    EdPortador: TSQLEd;

    procedure EdComv_codigoValidate(Sender: TObject);
    procedure bIncluiritemClick(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdProdutoValidate(Sender: TObject);
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure EdClienteValidate(Sender: TObject);
    procedure EdQtdeExitEdit(Sender: TObject);
    procedure brelpendentesClick(Sender: TObject);
    procedure bbaixaClick(Sender: TObject);
    procedure blebalanca1Click(Sender: TObject);
    procedure blebalanca2Click(Sender: TObject);
    procedure SerialRxChar(Sender: TObject; Count: Integer);
    procedure Serial2RxChar(Sender: TObject; Count: Integer);
    procedure bExcluiritemClick(Sender: TObject);
    procedure bcupomClick(Sender: TObject);
    procedure bgeraboletoClick(Sender: TObject);
    procedure bgeranfeClick(Sender: TObject);
    procedure bgravarClick(Sender: TObject);
    procedure EdFpgt_codigoValidate(Sender: TObject);
    procedure EdFpgt_codigoExitEdit(Sender: TObject);
    procedure EdFpgt_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure GridParcelasDblClick(Sender: TObject);
    procedure GridParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure EdVencimentoExitEdit(Sender: TObject);
    procedure EdVencimentoValidate(Sender: TObject);
    procedure EdParcelaExitEdit(Sender: TObject);
    procedure EdperdescoValidate(Sender: TObject);
    procedure EdValorRecebidoValidate(Sender: TObject);
    procedure ACBrBAL1LePeso(Peso: Double; Resposta: String);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdVlrdescoValidate(Sender: TObject);
    procedure bf11Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdPeracreValidate(Sender: TObject);
    procedure EdVlracreValidate(Sender: TObject);
    procedure EdCodtamanhoValidate(Sender: TObject);
    procedure bimpressaoClick(Sender: TObject);
    procedure EdDtemissaoExitEdit(Sender: TObject);
    procedure EdDtemissaoValidate(Sender: TObject);
    procedure EdQtdeValidate(Sender: TObject);
    procedure EdCpfValidate(Sender: TObject);
    procedure EdCpfExitEdit(Sender: TObject);
    procedure EdDtMovimentoValidate(Sender: TObject);
    procedure bvalidadeClick(Sender: TObject);
    procedure EdFreteValidate(Sender: TObject);
    procedure bafaturarClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure EdUnitarioValidate(Sender: TObject);
  private
    { Private declarations }
    procedure LimpaEditsItens;
    procedure Editstogrid;
  public
    { Public declarations }
    function Servico(produto: string): boolean;
    procedure Execute;
    procedure  ConfigEnableEdits( Painel:Tobject ; ativado:boolean );
    procedure SetaEditsValores;
    function AbrirPorta:boolean;
    function AbrirPorta2:boolean;
    procedure ReservaEstoque(Codigo,IncExc:string;Qtde:currency);
    procedure CancelaTransacao(Transacao:string);
    procedure AtivaEditsParcelas(n:integer=0);
    procedure LimitaMouse( Form:TForm );
    procedure LiberaMouse( Form:TForm );
    function  AutorizaNFe(ynumero:integer):boolean;
    procedure ImprimeNfe;


  end;

var
  FVendaBalcao: TFVendaBalcao;
  NotaTipoCad,Ecf,OP,campoufentidade,Revenda,TipoDevolucao,StatusNota,TiposFornec,
  TiposDevolucao,codbarrabalanca:String;
  QBusca,QEstoque,QGrade:TSqlquery;
  ListaReservaCodigo,ListaReservaQTde:TStringlist;
  campoclifpgt:TDicionario;
  codigobarra:boolean;
  ValorTroco,peracre,perdesco:currency;

implementation

uses Geral, Arquiv, Estoque, codigosfis, cadcor, tamanhos, cadcopa,
     Sittribu, SqlFun, tabela, nfsaida, Unidades, BaixaPen, RelFinan,
     gerenciaecf,
  boletos, expnfetxt, conpagto, munic, impressao, Usuarios,
  //visualizaimp,
   gerencianfe, vencervalidade, mostravalorafaturar, printers;

{$R *.dfm}

procedure TFVendaBalcao.EdComv_codigoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin

  campoufentidade:='clie_uf';
  revenda:='N';
  EdValorrecebido.Enabled:=true;
  if Edcomv_codigo.ResultFind=nil then
    EdComv_codigo.validfind;
  NotaTipocad:='C';
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.TiposEntrada+';'+Global.CodTransfSaida)>0 then
    EdComv_codigo.invalid('Movimento inv�lido para vendas');
  if Edcomv_codigo.AsInteger=FGeral.GetConfig1AsInteger('ConfMovECF') then
    Ecf:='S'
  else
    Ecf:='N';
//  if Global.Topicos[1301] then begin
// 10.03.2022 liberado pra sempre vir
    EdNumerodoc.setvalue( FGeral.ConsultaContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade) ) + 1 );

//  end;
//  if not Arq.TConfMovimento.locate('comv_codigo',Edcomv_codigo.Text,[]) then
// 24.09.14
  if EdComv_descricao.IsEmpty then
    EdComv_codigo.invalid('Codigo n�o encontrado')
  else if OP='A' then
    EdNumerodoc.setfocus;   // 28.06.05
// 21.03.14
  EdTran_codigo.text:='001';
  EdTran_codigo.validfind;
  EdTran_codigo.enabled:=false;
  if ( ecf='S' ) and ( OP='I' ) then begin
    EdCliente.text:=FGeral.GetConfig1AsString('clieconsumidor');
    if Global.Topicos[1359] then begin
      EdCliente.valid;
      EdCliente.enabled:=false;
    end else
      EdCliente.enabled:=true;
    EdEmides.Enabled:=false;
    EdEmides.text:='1';
    EdDtSaida.Enabled:=false;
    EdDtSaida.valid;
  end else begin
    EdEmides.Enabled:=true;
//    EdTran_codigo.enabled:=true;
    EdDtSaida.Enabled:=true;
    EdCliente.enabled:=true;
  end;
// 30.07.15
  if EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCe') then begin
// 01.07.18
//    if Global.Topicos[1454] then begin
// 30.08.2021 - Devereda
    if ( Global.Topicos[1454] ) and ( Global.Usuario.OutrosAcessos[0354] ) then begin

      EdCpf.enabled:=true;
      EdCliente.text:=FGeral.GetConfig1AsString('clieconsumidor');
      EdCliente.enabled:=true;
      EdCliente.SetFocus;

    end else begin

      EdCpf.enabled:=true;
      EdCliente.text:=FGeral.GetConfig1AsString('clieconsumidor');
      EdCliente.valid;
// 08.10.2021  - Devereda - Linda
      EdCpf.clear;
      EdCliente.enabled:=false;
      EdCpf.SetFocus;
    end;

  end else
    EdCpf.enabled:=false;
// 12.10.16
  if not FGeral.PodeIncluirNF then EdComv_codigo.invalid('');
// 23.01.19  - Devereda
  if ( EdComv_codigo.asinteger <> FGeral.GetConfig1AsInteger('ConfMovNFCe') )
      and
     ( FGeral.GetConfig1AsInteger('ConfMovNFCe') > 0 )
// 23.02.2021 - Sport A��o
     and
     (  Global.topicos[1384] )
     then
     EdComv_codigo.invalid('Permitido somente NF CONSUMIDOR');

end;

procedure TFVendaBalcao.bIncluiritemClick(Sender: TObject);
//////////////////////////////////////////////////////////////
begin
  if EdCliente.AsInteger=0 then exit;
  PRemessa.Enabled:=false;
  PFinan.Enabled:=false;
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
  PINs.EnableEdits;
  LimpaEditsItens;
  if Global.Topicos[1317] then
    EdQtde.Enabled:=Global.Usuario.OutrosAcessos[0041]
  else
    EdQtde.Enabled:=true;
  EdProduto.enabled:=true;
  EdProduto.SetFocus;


end;

procedure TFVendaBalcao.Editstogrid;
//////////////////////////////////////
var x:integer;
    aqtde,reducaobase:currency;
    cstcfop,xtipocad:string;
    codsittrib:integer;
begin
  xtipocad:='C';
  x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.GetColumn('codtamanho'),Edcodtamanho.asinteger,
                        Grid.getcolumn('codcor'),EdCodcor.asinteger,Grid.getcolumn('codcopa'),0);
  reducaobase:=0;
  if x<=0 then begin
    if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),1])='') then begin
       x:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       x:=Grid.RowCount-1;
    end;
// 09.05.16
    codsittrib:=FEstoque.GetCodigosituacaotributaria(EdProduto.text,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring);
    cstcfop:=FEstoque.Getsituacaotributaria(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,EdCliente.asinteger,
                            revenda,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring);

    Grid.Cells[Grid.Getcolumn('move_natf_codigo'),Abs(x)]:=FSittributaria.GetCfop(codsittrib,EdNatf_codigo.text,EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring);
    if (cstcfop='500')  and  ( trim(Grid.Cells[Grid.Getcolumn('move_natf_codigo'),Abs(x)])<>'5405' ) then begin
      Avisoerro('CFOP incorreto para CST '+cstcfop+' : '+Grid.Cells[Grid.Getcolumn('move_natf_codigo'),Abs(x)]);
      exit;
    end;
//////////////////
    Grid.Cells[Grid.getcolumn('move_esto_codigo'),Abs(x)]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;

    Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=cstcfop;
// 15.02.10
      if Servico(EdProduto.text) then
        Grid.Cells[Grid.getcolumn('perciss'),Abs(x)]:=currtostr(FEstoque.GetaliquotaIss(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring) )
      else
        Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=currtostr(FEstoque.Getaliquotaicms(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.asinteger,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,revenda,xtipocad) );
// 07.10.11 - Novicarnes cfops 5913 e 6913 - devolucao igual a nota 'que veio'
      if pos(EdNatf_codigo.text,'5913/6913') > 0 then
         reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring,revenda,EdProduto.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring )
      else begin
        if EdUNid_codigo.resultfind.FieldByName('unid_uf').asstring=EdCliente.resultfind.fieldbyname(campoufentidade).asstring then
            reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring,revenda,EdProduto.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring )
        else
            reducaobase:=0;
      end;
      if pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.TiposNaoCalcIcms ) > 0 then
        reducaobase:=0;
      if campoufentidade='forn_uf' then  // 27.09.07
         Grid.Cells[Grid.getcolumn('move_aliipi'),abs(x)]:=currtostr(FEstoque.Getaliquotaipi(EdProduto.text,'S',EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring))
      else
         Grid.Cells[Grid.getcolumn('move_aliipi'),abs(x)]:=currtostr(FEstoque.Getaliquotaipi(EdProduto.text,EdCliente.resultfind.fieldbyname('clie_ipi').asstring,EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring));

    Grid.Cells[Grid.getcolumn('esto_unidade'),Abs(x)]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
    Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=EdQTde.AsSql;
    Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
//    Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=TRansform(EdQTde.AsFloat*EdUnitario.AsCurrency,f_cr);
// 22.08.18 - arredondamente para xml 4.0
// 26.11.18 - Patoembalagens
    if (Global.Topicos[1458]) then

      Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=TRansform(EdQTde.AsFloat*EdUnitario.AsCurrency,f_cr)

    else

      Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=TRansform(EdQTde.AsFloat*EdUnitario.AsCurrency,f_cr4);

    Grid.Cells[Grid.getcolumn('move_perdesco'),Abs(x)]:=EdPerdesconto.AsSql;
    Grid.Cells[Grid.getcolumn('move_vendabru'),Abs(x)]:=TRansform(QEstoque.fieldbyname('esqt_vendavis').AsCurrency,f_cr);
// 16.08.06
    Grid.Cells[Grid.getcolumn('cor'),Abs(x)]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),Abs(x)]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
//    Grid.Cells[Grid.getcolumn('copa'),Abs(x)]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),Abs(x)]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),Abs(x)]:=EdCodtamanho.text;
//    Grid.Cells[Grid.getcolumn('codcopa'),Abs(x)]:=EdCodcopa.text;
// 08.05.07
    Grid.Cells[Grid.Getcolumn('move_pecas'),Abs(x)]:=EdPecas.assql;
// 24.05.07
    Grid.Cells[Grid.Getcolumn('move_redubase'),Abs(x)]:=Transform(reducaobase,'#0.000');
// 30.05.07
    Grid.Cells[Grid.Getcolumn('move_vendamin'),Abs(x)]:=TRansform(QEstoque.fieldbyname('esqt_vendamin').AsCurrency,f_cr);
// 23.12.08
//    Grid.Cells[Grid.Getcolumn('move_certificado'),Abs(x)]:=EdCertificado.text;
// 13.07.09
//    Grid.Cells[Grid.Getcolumn('move_core_codigoind'),Abs(x)]:=EdCorIndust.text;
// 08.09.10
    Grid.Cells[Grid.Getcolumn('move_natf_codigo'),Abs(x)]:=FSittributaria.GetCfop(codsittrib,EdNatf_codigo.text,EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring)

  end else begin

    Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=SetEdEsto_descricao.text;
// 13.09.10
    codsittrib:=FEstoque.GetCodigosituacaotributaria(EdProduto.text,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring);

      cstcfop:=FEstoque.Getsituacaotributaria(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,EdCliente.asinteger,
                            revenda,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring);
      Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=cstcfop;

//      Grid.Cells[Grid.getcolumn('move_cst'),x]:=FEstoque.Getsituacaotributaria(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
//                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,0,revenda);
// 15.02.10
      if Servico(EdProduto.text) then
         Grid.Cells[Grid.getcolumn('perciss'),x]:=currtostr(FEstoque.GetaliquotaIss(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring) )
      else
        Grid.Cells[Grid.getcolumn('move_aliicms'),x]:=currtostr(FEstoque.Getaliquotaicms(EdProduto.text,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.asinteger,
                            Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,revenda) );
// 21.03.07
       if campoufentidade='forn_uf' then  // 30.04.09
         Grid.Cells[Grid.getcolumn('move_aliipi'),abs(x)]:=currtostr(FEstoque.Getaliquotaipi(EdProduto.text,'S',EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring))
       else
         Grid.Cells[Grid.getcolumn('move_aliipi'),abs(x)]:=currtostr(FEstoque.Getaliquotaipi(EdProduto.text,EdCliente.resultfind.fieldbyname('clie_ipi').asstring,EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring));


      if pos(EdNatf_codigo.text,'5913/6913') > 0 then
         reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring,revenda,EdProduto.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring )
      else begin
// 24.05.07
        if EdUNid_codigo.resultfind.FieldByName('unid_uf').asstring=EdCliente.resultfind.fieldbyname(campoufentidade).asstring then
    //        reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring )
    // 10.02.09 - Asatec
            reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring,revenda,EdProduto.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring )
        else
            reducaobase:=0;
      end;
// 22.03.10
     if pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.TiposNaoCalcIcms ) > 0 then
       reducaobase:=0;
    Grid.Cells[Grid.getcolumn('esto_unidade'),x]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
    aqtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x])+ EdQTde.AsFloat;
//    Grid.Cells[5,x]:=Transform(texttovalor(Grid.Cells[5,x])+EdQTde.Ascurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_qtde'),x]:=Valortosql( texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x])+EdQTde.AsFloat );
    Grid.Cells[Grid.getcolumn('move_venda'),x]:=Valortosql(EdUnitario.Ascurrency);
    Grid.Cells[Grid.getcolumn('total'),x]:=Valortosql( (aqtde)*EdUnitario.AsCurrency);
    Grid.Cells[Grid.getcolumn('move_perdesco'),Abs(x)]:=EdPerdesconto.AsSql;
//    Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=TRansform(QEstoque.fieldbyname('esqt_vendavis').AsCurrency,f_cr);
// 25.08.06 - Marcia lizot pegou o erro...
    Grid.Cells[Grid.getcolumn('move_vendabru'),Abs(x)]:=TRansform(QEstoque.fieldbyname('esqt_vendavis').AsCurrency,f_cr);
//
    Grid.Cells[Grid.getcolumn('cor'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
//    Grid.Cells[Grid.getcolumn('copa'),x]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),x]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),x]:=EdCodtamanho.text;
//    Grid.Cells[Grid.getcolumn('codcopa'),x]:=EdCodcopa.text;
    Grid.Cells[Grid.Getcolumn('move_pecas'),x]:=EdPecas.assql;
    Grid.Cells[Grid.Getcolumn('move_redubase'),x]:=Transform(reducaobase,'#0.000');
    Grid.Cells[Grid.Getcolumn('move_vendamin'),x]:=TRansform(QEstoque.fieldbyname('esqt_vendamin').AsCurrency,f_cr);
//    Grid.Cells[Grid.Getcolumn('move_certificado'),x]:=EdCertificado.text;
//    Grid.Cells[Grid.Getcolumn('move_core_codigoind'),Abs(x)]:=EdCorIndust.text;
    Grid.Cells[Grid.Getcolumn('move_natf_codigo'),Abs(x)]:=FSittributaria.GetCfop(codsittrib,EdNatf_codigo.text,EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring)
  end;
  Grid.Refresh;


end;

procedure TFVendaBalcao.LimpaEditsItens;
/////////////////////////////////////////
begin
  EdProduto.Clear;
  EdQtde.Clear;
  EdUnitario.Clear;
  EdPerdesconto.clear;
  SetedEsto_descricao.Clear;
  Edcodcor.clear;
  EdCodtamanho.clear;
  EdPecas.clear;
end;

function TFVendaBalcao.Servico(produto: string): boolean;
///////////////////////////////////////////////////////////
var codigofis,tpimposto:string;
begin
  codigofis:=FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,Global.UFUnidade);
  tpimposto:=FCodigosFiscais.GetQualImposto(codigofis);
  result:=tpimposto='S';
end;

///////////////////////////////////////
procedure TFVendaBalcao.Execute;
///////////////////////////////////
var operacao,
    s:string;
    i:integer;
    Lista:TStringList;

begin


  PBanner.visible := false;
  Timer1.Enabled  := false;

  if Global.Usuario.codigo = 100 then  begin

     PBanner.visible := true;
     Timer1.Enabled := true;

//     Shockwaveflash1.Movie:= 'http://www.uol.com.br';

  end;

//  Op:=Acao;
  Op:='I';
//  Ecf:=Imp;
  EdBaseicms.clearall(FVendaBalcao,99);
  FGeral.EstiloForm(FVendaBalcao);
//  FGeral.ConfiguraTamanhoEditsEnabled(FVendaBalcao,FGeral.GetConfig1AsInteger('tamanholetra'));
  PBotoesGrid.Enabled:=Global.Usuario.OutrosAcessos[0325];
  PBotoesGrid.Visible:=Global.Usuario.OutrosAcessos[0325];
// 03.11.15
  EdDtmovimento.Enabled:=Global.Topicos[1387];
  EdDtmovimento.Visible:=Global.Topicos[1387];
// 30.10.17
  EdFrete.Enabled:=Global.Topicos[1451];
  EdUnid_codigo.Text:=Global.CodigoUnidade;
  if Global.Usuario.OutrosAcessos[0313] then
    EdDtemissao.Enabled:=true
  else
    EdDtemissao.enabled:=Global.Usuario.OutrosAcessos[0702];
  Sistema.setmessage('Abrindo tabelas');
  if not Arq.TTransp.Active then Arq.TTransp.Open;
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if not Arq.TEstoqueQtde.Active then Arq.TEstoqueQtde.Open;
  if not Arq.TClientes.Active then Arq.TClientes.Open;
  if not Arq.TRepresentantes.Active then Arq.TRepresentantes.Open;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
//  Arq.TNatFisc.OpenWith('natf_es=''S''',Arq.TNatFisc.Ordenacao);
  if not Arq.TNatFisc.active then Arq.TNatFisc.open;
//  if not Arq.TConfMovimento.Active then Arq.TConfMovimento.Open;
  Arq.TConfMovimento.OpenWith(FGeral.GetIN('comv_tipomovto',Global.TiposSaida,'C'),Arq.TConfMovimento.Ordenacao);
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if not Arq.TPortadores.Active then Arq.TPortadores.Open;
  if not Arq.TSittributaria.Active then Arq.TSittributaria.Open;
  if not Arq.TCodigosFiscais.active then Arq.TCodigosFiscais.open;
  if OP='A' then
    operacao:='Altera��o'
  else if op ='G' then
    operacao:='Nota a partir da Pesagem de Saida'
  else
    operacao:='Inclus�o';
  Caption:='Nota Fiscal de Saida Venda Balc�o - '+operacao;
  Show;
  ListaReservaCodigo:=TStringlist.Create;
  ListaReservaQTde:=TStringlist.Create;
  EdUnid_codigo.Text:=Global.CodigoUnidade;
  EdDtEmissao.SetDate(Sistema.hoje);
  EdDtSaida.SetDate(Sistema.hoje);

// 28.08.15
  if Global.topicos[1384] then
    EdDtMovimento.SetDate(Sistema.hoje)
// 03.02.20 - Guiber
  else if Global.topicos[1467] then
    EdDtMovimento.SetDate( TextTodate('') )
// 25.03.14 - Devereda
  else
    Fgeral.SetaMovimento(EdDtMovimento);

  EdNumerodoc.enabled:=Global.Topicos[1301];
  StatusNota:='N';
  Sistema.setmessage('');
// aqui em 08.09.2021
  FGeral.ConfiguraColorEditsNaoEnabled(FVendabalcao);

//  Edpercomissao.enabled:=Global.Topicos[1324];
//  Edpercomissao2.enabled:=Global.Topicos[1324];
// 09.11.11
//  bcupom.Enabled:=Global.Topicos[1021];
// 10.11.15 - retirado

/////////////////////////////////
//  if CodMovimento>0 then begin
//    EdComv_codigo.setvalue(CodMovimento);
//    EdComv_codigo.valid;
//  end;
////////////////////////////////
//  EdMoes_tabp_codigo.Visible:=Global.Topicos[1357];
//  EdMoes_tabp_codigo.Enabled:=Global.Topicos[1357];
//  SetEdTABP_ALIQUOTA.Visible:=Global.Topicos[1357];
  if OP='I' then begin
// 10.03.2022
    EdVlrdesco.SetValue(0);
    EdPerdesconto.setvalue(0);

    EdComv_codigo.Clear;
    if Global.topicos[1384] then
      EdComv_codigo.text:=inttostr(FGeral.GetConfig1AsInteger('ConfMovNFCe'))
    else
      EdComv_codigo.text:=inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));
    EdComv_codigo.setfocus;
// 17.02.10 - novicarnes - saida de abate - 'pedido'
//    EdTran_codigo.text:=Tran_codigo;
//    EdFpgt_codigo.text:=Fpgt_codigo;
//    EdTran_codigo.ValidFind;
//    EdFpgt_codigo.ValidFind;
    EdProduto.enabled:=false;
// 03.08.11
  end else if op='G' then begin

    ConfigEnableEdits( PRemessa , false );
    EdEmides.text:='1';
    EdPort_codigo.ClearAll(FVendaBalcao,99);
    bincluiritem.Enabled:=false;
    bExcluiritem.Enabled:=false;
 //    EdFpgt_codigo.text:=Fpgt_codigo;
//    EdFpgt_codigo.ValidFind;
//    EdPort_codigo.text:=Port_codigo;
//    EdPOrt_codigo.ValidFind;
//    EdPOrt_codigo.Valid;
    EdTran_codigo.enabled:=true;
    EdTran_codigo.setfocus;

  end else begin

    EdNumerodoc.enabled:=true;
    EdDtemissao.enabled:=true;

  end;

////////////////////////////////////////////////////
  EdPecas.Enabled:=Global.Topicos[1302];
// 13.08.07
//  EdMoes_tabp_codigo.Enabled:=Global.Usuario.OutrosAcessos[0306];
//  EdFrete.Enabled:=Global.Usuario.OutrosAcessos[0307];
//  EdSeguro.Enabled:=Global.Usuario.OutrosAcessos[0308];
//  EdPedido.Enabled:=Global.Usuario.OutrosAcessos[0309];
// 12.11.07
  EdCodcor.Enabled:=Global.Topicos[1309];
  EdCodTamanho.Enabled:=Global.Topicos[1309];
// 24.02.11
  EdCodcor.Visible:=Global.Topicos[1309];
  EdCodTamanho.Visible:=Global.Topicos[1309];
  SetEdcor.Visible:=Global.Topicos[1309];
  SetEdTamanho.Visible:=Global.Topicos[1309];
{
  if Global.Topicos[1309] then begin
    SetEdESTO_DESCRICAO.Width:=250;
  end else begin
    SetEdESTO_DESCRICAO.Width:=250;
  end;
}
  TiposFornec:=Global.CodRemessaconserto+';'+Global.CodRemessaDemo+';'+Global.CodDevolucaoSaida+';'+
               Global.CodRemessaInd+';'+Global.CodVendaFornecedor+';'+Global.CodDevolucaoSimbolicaConsig; ;
// 12.12.07 - depois mudar td para usar o campo da conf. de movimento
  NotaTipocad:='C';
  if not EdPecas.enabled then
    EdPecas.setvalue(0);
  blebalanca1.Enabled:=Global.Topicos[1317];
  blebalanca2.Enabled:=Global.Topicos[1317];

  if FGeral.GetConfig1AsString('PORTASERIALNF')<>'' then begin
   // configura porta de comunica��o - ver config. para modelo balan�a e handshake
   if acbrBal1.Ativo then  ACBrBAL1.Desativar;
   ACBrBAL1.Modelo           := TACBrBALModelo( balToledo );
//   ACBrBAL1.Device.HandShake := TACBrHandShake( cmbHandShaking.ItemIndex );
//   none odd even mark space
   if FGeral.GetConfig1AsString('saiparidade1')='P' then
     ACBrBAL1.Device.Parity    := TACBrSerialParity( podd )
   else if FGeral.GetConfig1AsString('saiparidade1')='I' then
     ACBrBAL1.Device.Parity    := TACBrSerialParity( peven )
   else
     ACBrBAL1.Device.Parity    := TACBrSerialParity( pnone );
// s1  s1,5   s2
   if FGeral.GetConfig1AsString('saistopbitsbal1')='10' then
     ACBrBAL1.Device.Stop      := TACBrSerialStop( s1 )
   else if FGeral.GetConfig1AsString('saistopbitsbal1')='15' then
     ACBrBAL1.Device.Stop      := TACBrSerialStop( s1eMeio )
   else
     ACBrBAL1.Device.Stop      := TACBrSerialStop( s2 );
   ACBrBAL1.Device.Data      := StrToIntdef( FGeral.GetConfig1AsString('saidatabitsbal1'),8 );
   ACBrBAL1.Device.Baud      := StrToIntdef(  FGeral.GetConfig1AsString('saivelocbal1'),2400 );
   ACBrBAL1.Device.Porta     := FGeral.GetConfig1AsString('PORTASERIALNF');
  end;
  {
// 03.12.12 - Pesagem -> NFe
  xcodigocliente:=codigocliente;
  if CodigoCliente>0 then begin
    EdCliente.setvalue(CodigoCliente);
    EdCliente.validfind;
    EdRepr_codigo.text:=EdCliente.resultfind.fieldbyname('clie_repr_codigo').asstring;
    EdRepr_codigo.validfind;
  end;
  }
// 03.08.11
  if op='G' then begin
    EdUnid_codigo.Valid;
  end;
//////////////////////
// 23.12.08
//  EdTotalservicos.Clear;
//  ListaServicos:=TList.create;
  GridParcelas.Clear;
// 03.12.12
  if op='I' then Grid.Clear;
// 07.07.11
  TiposDevolucao:=Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemEstoque+';'+
                  Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoInd+';'+
                  Global.CodDevolucaoSimbolicaConsig+';'+
                  Global.CodDevolucaodeRemessa+';'+
                  Global.CodDevolucaoRoman;
// 18.11.11
  campoclifpgt:=Sistema.GetDicionario('clientes','clie_fpgt_codigo');


  EdPecas.Enabled:=Global.Topicos[1302];
//  EdMoes_tabp_codigo.Enabled:=Global.Usuario.OutrosAcessos[0306];
// 12.11.07
  EdCodcor.Enabled:=Global.Topicos[1309];
  EdCodTamanho.Enabled:=Global.Topicos[1309];
// 24.02.11
  EdCodcor.Visible:=Global.Topicos[1309];
  EdCodTamanho.Visible:=Global.Topicos[1309];
  SetEdcor.Visible:=Global.Topicos[1309];
  SetEdTamanho.Visible:=Global.Topicos[1309];
  if Global.Topicos[1309] then begin
    SetEdESTO_DESCRICAO.Width:=180;
  end else begin
    SetEdESTO_DESCRICAO.Width:=250;
  end;
// 19.07.13 - aqui para nao 'ajudar a dar problema no envio da nfe/ecf
//  if AcbrIbptax1.Itens.Count=0 then FGeral.ArmazenaTabelaIBPT(AcbrIbptax1);
// 10.04.14
//  LimitaMouse( FVendaBalcao );
// 07.07.15 - retirado limitamouse
// 19.05.15
  EdDtemissao.enabled:=Global.Usuario.OutrosAcessos[0340];
// 29.06.18
  if FValoraFaturar.PrecisaFaturar then Timer.Enabled:=true
  else timer.enabled:=false;
// 05.07.18 - para evitar e imprimir na impressora errada
//////////////////////////////////////////////////////////////
  if (Global.UsaNFCe='S') then begin

     Lista:=TStringList.Create;
     s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFCE');
     Lista.Assign( Printer.Printers );
     for I := 0 to Lista.Count-1 do begin
        if Lista[i]=s then
          Printer.PrinterIndex := i ;
     end;

  end;

// 22.08.18
  if Global.UsaNFCe='S' then
     FGeral.configuraacbrnfe( Acbrnfe1,'NFCe' )
  else
     FGeral.configuraacbrnfe( Acbrnfe1,'NFE' );

  Show;

end;

procedure TFVendaBalcao.ConfigEnableEdits(Painel: Tobject;  ativado: boolean);
/////////////////////////////////////////////////////////////////////////////////////
var p:Integer; Ed:TSQLEd;
begin
  for p:=0 to TPanel( Painel ).ControlCount-1 do begin
    if TPanel( Painel ).Controls[p] is TSQLEd then begin
      Ed:=TSQLEd( TPanel( Painel ).Controls[p] );
      Ed.Enabled:=ativado
    end;
  end;
end;


procedure TFVendaBalcao.bSairClick(Sender: TObject);
/////////////////////////////////////////////////////
begin
  if EdProduto.enabled then bCancelaritemClick(self);
  Close;
end;

procedure TFVendaBalcao.bCancelaritemClick(Sender: TObject);
//////////////////////////////////////////////////////////////
begin
//  if EdRepr_codigo.AsInteger=0 then begin
// 26.01.12
//  if (EdRepr_codigo.AsInteger=0) and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,TiposDevolucao)=0 ) then begin
//    Avisoerro('Falta codigo do representante');
//    exit;
//  end;
  if EdComv_codigo.AsInteger=0 then begin
    Avisoerro('Falta codigo do tipo de venda');
    exit;
  end;

  bGravar.Enabled:=true;
//  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
  PFinan.Enabled:=true;
//  PINs.Visible:=false;
  PINs.DisableEdits;
//  AtivaEdits;
  PRemessa.Enabled:=true;
//  EdComv_codigo.SetFocus;
//  Esconde(PDescricaoProduto);
//  if (OP='I') and (ECF='S') then begin
// 24.03.16 - Benato
  if (OP='I') and (EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCe')) then begin
// 07.11.16
    if Global.Usuario.OutrosAcessos[0345] then begin
      EdPort_codigo.enabled:=true;
      EdPort_codigo.text:='';
    end else begin
      EdPort_codigo.enabled:=false;
      EdPort_codigo.text:='001';
      EdPort_codigo.valid;
    end;
// 19.12.2022 - Fama
    if Global.Topicos[1485] then begin

      EdPerAcre.enabled:=true;
      EdVlrAcre.enabled:=true;

    end else begin

      EdPerAcre.enabled:=false;
      EdVlrAcre.enabled:=false;

    end;
    EdPerDesco.enabled:=false;
// 04.09.20 - Cantinho da pretta
    Edperdesco.Enabled:=not Global.Topicos[1375];

    EdVlrdesco.enabled:=false;
    if (EdCliente.asinteger=FGeral.GetConfig1AsInteger('clieconsumidor') ) then begin
      EdFpgt_codigo.text:=FGeral.getconfig1asstring('Fpgtoavista');
      if not EdFpgt_codigo.valid then begin

        EdFpgt_codigo.enabled:=true;
        EdFpgt_codigo.setfocus;

      end else begin
        if Global.Usuario.OutrosAcessos[0345] then begin
          EdVlrdesco.enabled:=true;
          EdPort_codigo.SetFocus;
        end else if Global.Topicos[1393]  then begin
          EdVlrdesco.enabled:=true;
// 30.10.17
          if Global.Topicos[1451] then
            EdFrete.SetFocus
          else
            EdVlrdesco.setfocus;

        end else
          EdValorRecebido.setfocus;
//        EdFpgt_codigo.enabled:=false;
//        EdFpgt_codigo.Next;
      end;

    end else begin

// 19.05.15 - Damama
      if EdCliente.resultfind<>nil then begin
        EdFpgt_codigo.text:=EdCliente.resultfind.fieldbyname('clie_fpgt_codigo').asstring;
// 10.03.2022
        EdFpgt_codigo.ValidFind;
      end else
        EdFpgt_codigo.text:='';
//      EdFpgt_codigo.setfocus;
// 01.07.18 - CiadaFruta
      if Global.Usuario.OutrosAcessos[0345] then begin
         EdFpgt_codigo.enabled:=true;
         EdPort_codigo.SetFocus
      end else
         EdValorRecebido.setfocus;
    end;

  end else begin
    EdPerAcre.enabled:=true;
//    EdPerDesco.enabled:=true;
// 15.05.14
    Edperdesco.Enabled:=not Global.Topicos[1375];
    EdVlrAcre.enabled:=true;
    EdVlrdesco.enabled:=true;
    EdPort_codigo.enabled:=true;
    EdFpgt_codigo.enabled:=true;
    if Global.topicos[1381] then begin
      EdVlrAcre.enabled:=false;
      EdPerAcre.enabled:=false;
      EdPerDesco.enabled:=false;
// 07.04.15
      if EdFpgt_codigo.isempty then
        EdFpgt_codigo.text:=FGeral.GetConfig1AsString('Fpgtoavista');
      EdPort_codigo.setfocus;
//      EdVlrdesco.setfocus;
    end else begin
      EdPort_codigo.setfocus;
    end;
  end;


end;

procedure TFVendaBalcao.FormCreate(Sender: TObject);
///////////////////////////////////////////////////////
begin

  if Global.Usuario.codigo = 100 then  begin

     PBanner.visible := true;

//     Shockwaveflash1.Movie:= 'http://www.uol.com.br';

  end;

  FGeral.ConfiguraTamanhoEditsEnabled(FVendaBalcao,15);
  FGeral.ConfiguraColorEditsNaoEnabled(FVendaBalcao,15);
// 16.03.17
  EdTotalNota.Font.Size:=20;
  EdTotalNota.Height:=20;

end;

procedure TFVendaBalcao.EdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then
    bcancelaritemclick(FVendaBalcao);

end;

procedure TFVendaBalcao.EdProdutoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
var x:integer;
    QBusca:TSqlquery;
    custotrans,precobalanca:currency;
    codbarra,xproduto:string;

    // 20.04.20 - Amanda lanches dia 19.04 fez nf consumidor com dia 20.04 e l� n�o
    //            est� aberta a data para alterar ...
    function ValidaDatadeHoje(xDt:TDatetime):boolean;
    /////////////////////////////////////////////////////
    begin

       result := true;      // 10.09.20 - liberado branutri lan�ar vendas 'atrasadas'
       if (xdt <> Sistema.Hoje) and (not EdDtemissao.enabled) then begin

          Avisoerro('Data de EMISS�O inv�lida. Data atual � '+FGeral.FormataData(Sistema.Hoje) );
          result:=false;
// 18.10.2021

       end;

    end;

//////////////////////////////////
begin
//////////////////////////////////
// 05.12.05
  codbarrabalanca:='N';
// 11.06.2022
    if (Time <= StrToTime('00:15:00')) and ( not EdDtmovimento.IsEmpty ) then begin

      FGeral.gravalog(41,
                      '03 - Data Atual '+FGeral.formatadata(Sistema.hoje)+
                      ' Data Tela '+FGeral.formatadata(EdDtEmissao.AsDate) );
      EdDtMovimento.SetDate(FGeral.GetDataServidor);
      EdDtEmissao.SetDate(FGeral.GetDataServidor);
    end;

  if not FEstoque.ValidaCodigoProduto(EdProduto,EdProduto.text) then
    exit;
// 07.12.20 - para centro poder lan�ar venda balcao retroativa...
  if not EdDtemissao.enabled then begin

// 20.04.20
      if not ValidaDatadeHoje(EdDtEmissao.asdate) then exit;

  end;

  codigobarra:=false;
  if FGeral.CodigoBarra(EdProduto.Text,EdProduto) then begin

    QBusca:=sqltoquery('select * from estoque where esto_Codbarra='+EdProduto.assql);
    codbarra:=EdProduto.text;
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
//          EdProduto.Invalid('Codigo de barra n�o encontrado');
//          exit;
    end;
    codigobarra:=true;
// 09.04.14 - Devereda
    EdQtde.Enabled:=(Global.topicos[1372]) or (bf11.tag=-1) ;
//    EdQtde.Enabled:=false;
    EdQtde.SetValue(1);
    EdPerdesconto.enabled:=false;
    EdPerdesconto.setvalue(0);
    if (not Qbusca.eof) then begin
      QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
      if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsFloat,EdUNid_codigo.Text,QEstoque) then begin
         EdProduto.INvalid('Quantidade em estoque insuficiente');
         exit;
      end;
    end;
    EdCodcor.enabled:=false;
    EdCodtamanho.enabled:=false;
    EdPerdesconto.Enabled:=false;
//    EdCodcopa.enabled:=false;
    EdCodcor.text:='';
    EdCodtamanho.text:='';
//    EdCodcopa.text:='';
//    if QBusca.FieldByName('esto_grad_codigo').asinteger>0 then begin
// 17.04.14
    if not QBusca.eof then
      EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,EdUnid_codigo.text));
    bf11.Tag:=1;
    if (QBusca.eof) then begin
      QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'''+
                       ' and esgr_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
                       ' and esgr_codbarra='+stringtosql(codbarra));
      if not QGrade.eof then begin
        EdProduto.Text:=QGrade.fieldbyname('esgr_esto_codigo').AsString;
        EdCodcor.setvalue(QGrade.fieldbyname('esgr_core_codigo').asinteger);
        EdCodcor.validfind;
        EdCodtamanho.setvalue(QGrade.fieldbyname('esgr_tama_codigo').asinteger);
        EdCodtamanho.validfind;
//        EdCodcopa.setvalue(QGrade.fieldbyname('esgr_copa_codigo').asinteger);
//        EdCodcopa.validfind;
// 17.04.14
        if (Global.topicos[1373]) then EdUnitario.SetValue(QGrade.fieldbyname('esgr_vendavis').AsCurrency);
        FGeral.Fechaquery(QEstoque);
        QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
        FGeral.Fechaquery(QBusca);
        QBusca:=sqltoquery('select * from estoque where esto_codigo='+EdProduto.assql);
      end else begin
        EdProduto.Invalid('Codigo de barra da grade n�o encontrado');
        exit;
      end;
    end;
// 23.05.2022
//    if (Time >= StrToTime('23:45:00')) and ( not EdDtmovimento.IsEmpty ) then begin
    if (Time <= StrToTime('00:15:00')) and ( not EdDtmovimento.IsEmpty ) then begin

      FGeral.gravalog(41,
                      'Data Atual '+FGeral.formatadata(Sistema.hoje)+
                      ' Data Tela '+FGeral.formatadata(EdDtEmissao.AsDate) );
      EdDtMovimento.SetDate(FGeral.GetDataServidor);
      EdDtEmissao.SetDate(FGeral.GetDataServidor);
    end;

  end else if trim(edproduto.text)<>'' then begin

    xproduto:=EdProduto.text;
// 23.11.11 - Benato
    if (Global.Topicos[1217]) and ( copy(xproduto,1,1)='2' ) and ( length(trim(xProduto))=13 ) then begin
      if ( Global.Usuario.OutrosAcessos[0338] )  and ( not Global.Topicos[1458]  ) then
        EdProduto.text:=copy(xproduto,2,5)
      else
        EdProduto.text:=copy(xproduto,2,4);
// 29.10.18 - PatoEmbalagens
      if ( FGeral.GetConfig1asinteger('TAMESTOQUE') > 0 ) then
         EdProduto.Text:=strzero(strtoint(EdProduto.Text),FGeral.GetConfig1asinteger('TAMESTOQUE'));

// 24.09.14 - codigo da balan�a 'diversos'
      if Edproduto.text='0000' then begin
        EdProduto.text:=FGeral.Getconfig1asstring('balancadiversos');
      end;
      codbarrabalanca:='S';
      if Global.Usuario.OutrosAcessos[0338] then
          precobalanca:=Texttovalor( copy(xproduto,8,5) )/100
      else
          precobalanca:=Texttovalor( copy(xproduto,8,5) )/1000;
  // preco balanca ser� o peso para agilizar passagem pelo caixa

    end;

    QBusca:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.assql);
//    QBusca:=sqltoquery('select * from estoque where esto_Codigo='+Stringtosql(xProduto));
    if not QBusca.Eof then begin
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString;
      if FNotaSaida.EstaCodigosNaoVenda(QBusca.fieldbyname('esto_codigo').AsString) then
        EdProduto.Invalid('Codigo n�o permitido usar em vendas');
    end else begin
      EdProduto.Invalid('Codigo n�o encontrado');
      exit;
    end;
    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                       ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    if QEstoque.eof then begin
       EdProduto.INvalid('Codigo n�o encontrado no estoque da unidade '+EdUnid_codigo.text);
       exit;
    end;
    Arq.TEstoque.locate('esto_codigo',Edproduto.text,[]);
/////////    EdQtde.Enabled:=true;
// 01.07.08
//    EdCodcor.enabled:=true;
    EdCodcor.setvalue(0);
//    EdCodtamanho.enabled:=true;
    EdCodtamanho.setvalue(0);
//    EdCodcopa.enabled:=true;
//    EdCodcopa.setvalue(0);
//    EdPerdesconto.enabled:=true;
    EdPerdesconto.setvalue(0);
    EdQtde.Enabled:=true;
// deixao edqtde ativo pra poder informar os kilos vendidos
    if codbarrabalanca='S' then begin
        EdQtde.Enabled:=false;
// 11.05.15
        if ( Global.Usuario.OutrosAcessos[0338] ) and ( not Global.Topicos[1458] ) then begin
          EdQtde.SetValue(1);
          EdUnitario.setvalue( precobalanca );
// 26.11.18 - Patoembalagens
        end else if (Global.Topicos[1458]) and ( copy(xproduto,1,1)='2' ) and ( length(trim(xProduto))=13 ) then begin

            if QEstoque.FieldByName('esqt_vendavis').AsCurrency>0 then begin

               EdQtde.setvalue( precobalanca/QEstoque.FieldByName('esqt_vendavis').AsCurrency );
               EdUnitario.setvalue( QEstoque.FieldByName('esqt_vendavis').AsCurrency );

            end else

               EdProduto.Invalid('Pre�o de venda zerado' );

        end else

          EdQtde.SetValue( precobalanca );


    end else
      EdQtde.SetValue(0);

    EdPerdesconto.setvalue(0);
    EdCodtamanho.Enabled:=Global.Usuario.OutrosAcessos[0305];
    EdCodcor.Enabled:=Global.Usuario.OutrosAcessos[0305];
    EdPerdesconto.Enabled:=Global.Usuario.OutrosAcessos[0304];

  end;

// 17.02.09 - asatec - chamou cadastro de ipi via f12 dentro do f12 dos produtos...
  if QEstoque=nil then begin
      EdProduto.Invalid('Checar codigo do produto informado '+EdProduto.text);
      exit;
  end;
  if QBusca=nil then begin
      EdProduto.Invalid('Checar codigo no estoque do produto informado '+EdProduto.text);
      exit;
  end;
//  if trim(QBusca.sql.Text)='' then begin
  if QBusca.SQL.Count=0  then begin
      EdProduto.Invalid('Checar codigo no estoque do produto informado '+EdProduto.text);
      exit;
  end;
// 23.08.05
  if QEstoque.eof then begin
      EdProduto.Invalid('Codigo ainda n�o cadastrado na unidade '+EdUnid_codigo.text);
      exit;
  end;
  if length( FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_codestado').asinteger,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring) )<> 3 then begin
     EdProduto.Invalid('Situa��o tribut�ria no estado inv�lida');
     exit;
  end;
  if length( FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_forestado').asinteger,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring) ) <> 3 then begin
     EdProduto.Invalid('Situa��o tribut�ria fora do estado inv�lida');
     exit;
  end;
// 04.11.05
  if not FGeral.ChecaCst(FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_codestado').asinteger,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring),EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring)  then begin
    EdProduto.invalid('');
    exit;
  end;
// 05.04.10 - Abra
  if (QEstoque.fieldbyname('esqt_customeger').ascurrency+QEstoque.fieldbyname('esqt_customedio').ascurrency)>999999.99  then begin
    EdProduto.invalid('Problemas no custo m�dio no estoque.  Checar');
    exit;
  end;

//
  SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;
// 11.05.15
  if not Global.Usuario.OutrosAcessos[0338] then begin
// 17.04.14
    if (not (Global.topicos[1373]) ) or ( not codigobarra ) then
      EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,EdUnid_codigo.text));
// 04.12.18
  end else
      EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,EdUnid_codigo.text));

//  EdUnitario.enabled:=Global.Usuario.OutrosAcessos[0034];
// 08.04.13 - Benato - Mari mudou de ideia
  if (codbarrabalanca<>'S') and ( not codigobarra )  then
    EdUnitario.enabled:=true
// 11.05.15 - Damama
  else if (codbarrabalanca='S') and (Global.Usuario.OutrosAcessos[0338]) then begin
    EdUnitario.enabled:=false;
  end else begin
    EdUnitario.enabled:=false;
// 09.04.14 - Devereda
    EdUnitario.Enabled:=Global.topicos[1372];
  end;
// 24.09.14 - Benato - codigo diversos da balan�a
  if (EdProduto.text=FGeral.Getconfig1asstring('balancadiversos')) and (codbarrabalanca='S') then
    EdUnitario.enabled:=true;
  if pos(Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodRemessaInd )>0 then begin
//    perctrans:=FCodigosFiscais.GetPercTransf(FEstoque.GetCodigoFiscal(EdProduto.text,EdUNid_codigo.text,EdUnid_codigo.resultfind.fieldbyname('unid_uf').AsString));
    custotrans:=QEstoque.fieldbyname('esqt_custoger').AsCurrency;
    EdUnitario.Setvalue(custotrans);
//  18.03.05
    EdUnitario.enabled:=true;
  end;
// 05.05.06 - Leila
  if ( pos(Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Global.CodVendaBrindeConsig )>0 ) and (EdDtMovimento.asdate>1)then begin
    EdUnitario.Setvalue(QEstoque.fieldbyname('esqt_customedio').AsCurrency);
  end;
///////////////
// 28.07.11
  if ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem )
     and ( OP='I' ) then begin
    EdUnitario.setvalue(1);
    EdUnitario.enabled:=false;
  end;
//////////////

  if (EdUnitario.ascurrency=0) and ( not EdUnitario.enabled) then
    Avisoerro('Aten��o.   Checar pre�o de venda ou custo m�dio no cadastro.');
  {
  if EdMoes_tabp_codigo.asinteger>0 then begin
    if FTabela.gettipo(EdMoes_tabp_codigo.asinteger) = 'A' then
      EdUnitario.setvalue( EdUnitario.AsCurrency + (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) )
    else
      EdUnitario.setvalue( EdUnitario.AsCurrency - (EdUnitario.ascurrency*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) );
  end;
  }
  if Op='A' then begin
    if FGeral.ProcuraGrid(0,Edproduto.text,Grid)>0 then begin
      Edproduto.Invalid('Em altera��o obrigat�rio excluir e incluir');
    end;
  end;
// 24.04.17 - devereda - ajuste em 28.06.17
//  if (Time >= StrToTime('23:45:00')) and ( not EdDtmovimento.IsEmpty ) then begin
// 21.02.2022 - por aqui nao passou - constatado em 23.05.2022
//  if ( Sistema.hoje > EdDtEmissao.asdate ) and ( not EdDtmovimento.IsEmpty ) then begin
// 23.05.2022
//  if (Time >= StrToTime('23:45:00')) and ( not EdDtmovimento.IsEmpty ) then begin
  if (Time <= StrToTime('00:15:00')) and ( not EdDtmovimento.IsEmpty ) then begin

    FGeral.gravalog(40,
                    'Data Atual '+FGeral.formatadata(Sistema.hoje)+
                    ' Data Tela '+FGeral.formatadata(EdDtEmissao.AsDate) );
    EdDtMovimento.SetDate(FGeral.GetDataServidor);
// 18.10.2021 - pra n�o 'trancar' a venda apos a meia noite no devereda
    EdDtEmissao.SetDate(FGeral.GetDataServidor);
  end;


end;

procedure TFVendaBalcao.Edunid_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin

  if EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring<>EdCliente.resultfind.fieldbyname(campoufentidade).asstring then begin
    EdNatf_codigo.text:=Arq.TConfMovimento.fieldbyname('comv_natf_foestado').asstring;
    if (OP='I') and (campoufentidade='clie_uf')  and (Global.Topicos[1348] ) then begin
      if EdCliente.ResultFind.FieldByName('clie_tipo').AsString='F' then begin
        if trim(FGeral.GetConfig1AsString('cfopfisicafora')) <>'' then
          EdNatf_codigo.text:=FGeral.GetConfig1AsString('cfopfisicafora')
        else
          EdUnid_codigo.Invalid('Cfop para venda fora do estado para pessoa f�sica n�o configurado');
      end;
    end;
  end else
// 22.08.19
//    EdNatf_codigo.text:=Arq.TConfMovimento.fieldbyname('comv_natf_estado').asstring;
    EdNatf_codigo.text:=EdComv_codigo.ResultFind.fieldbyname('comv_natf_estado').asstring;

  if OP<>'A' then begin
    if not FGeral.ValidaUnidadesMvtoUsuario(EdUnid_codigo) then
      EdUnid_codigo.invalid('')
    else begin
      if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem then  // 30.06.11
        EdNUmerodoc.setvalue( FGeral.ConsultaContador('ROMA'+Global.CodRomaneioRemessaaOrdem+EdUnid_codigo.Text)+1 )
      else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodConhecimentoSaida then  // 28.10.11
        EdNUmerodoc.setvalue( FGeral.ConsultaContador('CTRC'+Global.CodConhecimentoSaida+EdUnid_codigo.Text)+1 )
      else if ecf='S' then
        EdNumeroDoc.SetValue( FGeral.ConsultaContador('NFSAIDAECF'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring)+1 )
// 09.01.12 - Benatto - retirado pois s� fodia os demais clientes..deixado sem por enquanto
//      else if (EdDtmovimento.asdate<=1) and (OP='I') then
//         EdNumeroDoc.SetValue( FGeral.ConsultaContador('SAIDA'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring)+1 )
// 12.01.12
//        EdNUmerodoc.setvalue( FGeral.ConsultaContador('SAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade))+1 )
      else begin
        EdNUmerodoc.setvalue( FGeral.ConsultaContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade))+1 );
// 06.06.09
        if not FGeral.ValidaContadorNFSaida(EdNumerodoc.asinteger,EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,EdUnid_codigo.text,sistema.hoje) then begin
            EdUnid_codigo.invalid('')
        end;
      end;
    end;
  end;

end;

// 07.07.2021 - Pato Embalagens
procedure TFVendaBalcao.EdUnitarioValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin

  if not FEstoque.ValidaPrecoVenda( EdProduto.Text,EdUnid_codigo.text,EdUnitario.ascurrency,global.Usuario.codigo) then
     EdUnitario.Invalid('');

end;

procedure TFVendaBalcao.EdClienteValidate(Sender: TObject);
var restricao1,restricao2,restricao3,restricao4:boolean;
    usuariolib:integer;
    obsliberacao,unidades:string;

    procedure SetaEditsPedido;
    //////////////////////////
    begin
      EdUnid_codigo.text:=QPed.fieldbyname('mped_unid_codigo').asstring;
      EdFpgt_codigo.text:=QPed.fieldbyname('mped_fpgt_codigo').asstring;
      ObsPedido:=QPed.fieldbyname('mped_obspedido').asstring;
    end;

    procedure SetaGridPedido;
    /////////////////////////
    var p:integer;
        unitario,qtde,rqtde:currency;
        Q:TSqlquery;
        semreq:boolean;
    begin
      Grid.Clear;p:=1;
      while not QPed.Eof do begin
// 17.09.09
        if (Servico(QPed.fieldbyname('mpdd_esto_codigo').asstring)) then
//           ( FGeral.GetConfig1AsInteger('ConfMovSer')<>EdComv_codigo.asinteger )  then
//              AdicionaListaServicos(QPed)
        else begin
          unitario:=QPed.fieldbyname('mpdd_venda').Ascurrency;
          qtde:=QPed.fieldbyname('mpdd_qtde').AsFloat;
          if Global.Topicos[1340] then begin
            Q:=Sqltoquery('select move_qtde,move_tipomov from movestoque where move_status=''N'''+
                          ' and '+FGeral.GetIN('move_tipomov',Global.CodSaidaAlmox+';'+Global.CodEntradaAlmox,'C')+
                          ' and move_numerodoc='+QPed.fieldbyname('mpdd_numerodoc').asstring+
                          ' and move_esto_codigo='+Stringtosql(QPed.fieldbyname('mpdd_esto_codigo').asstring)+
                          ' and move_core_codigo='+QPed.fieldbyname('mpdd_core_codigo').asstring+
                          ' and move_tama_codigo='+QPed.fieldbyname('mpdd_tama_codigo').asstring );
            rqtde:=0;
            semreq:=Q.eof;
            while not Q.eof do  begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then
                rqtde:=rqtde-Q.fieldbyname('move_qtde').ascurrency
              else
                rqtde:=rqtde+Q.fieldbyname('move_qtde').ascurrency;
              Q.Next;
            end;
  // caso devolver tudo nao fatura nada deste material
            if not semreq then begin
              if rqtde>0 then
                qtde:=rqtde
              else
                qtde:=0;
            end;
            FGeral.FechaQuery(Q);
          end;
          if qtde>0 then begin

            p:=FGeral.ProcuraGrid(Grid.GetColumn('move_esto_codigo'),QPed.fieldbyname('mpdd_esto_codigo').Asstring,
               Grid,Grid.Getcolumn('codtamanho'),QPed.fieldbyname('mpdd_tama_codigo').Asinteger,
               Grid.Getcolumn('codcor'),QPed.fieldbyname('mpdd_core_codigo').Asinteger );

            if p <=0 then begin
              if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),1])='') then begin
                 p:=1;
              end else begin
                 Grid.RowCount:=Grid.RowCount+1;
                 p:=Grid.RowCount-1;
              end;
              Grid.Cells[Grid.GetColumn('move_esto_codigo'),p]:=QPed.fieldbyname('mpdd_esto_codigo').Asstring;
              Grid.Cells[Grid.GetColumn('esto_descricao'),p]:=FEstoque.GetDescricao(QPed.fieldbyname('mpdd_esto_codigo').Asstring);
              Grid.Cells[Grid.getcolumn('move_cst'),p]:=FEstoque.Getsituacaotributaria(QPed.fieldbyname('mpdd_esto_codigo').Asstring,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,
                                  Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,EdCliente.asinteger,
                                  revenda,FUnidades.GetSimples(EdUnid_codigo.text) );
              Grid.Cells[Grid.getcolumn('move_aliicms'),p]:=currtostr(FEstoque.Getaliquotaicms(QPed.fieldbyname('mpdd_esto_codigo').Asstring,Edunid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring,EdCliente.asinteger,
                                  Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) );
              Grid.Cells[Grid.GetColumn('esto_unidade'),p]:=FEstoque.GetUnidade(QPed.fieldbyname('mpdd_esto_codigo').Asstring);
              Grid.Cells[Grid.GetColumn('move_venda'),p]:=TRansform(unitario,f_cr);
              if QPed.fieldbyname('mpdd_cubagem').asfloat>0 then begin
                Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(QPed.fieldbyname('mpdd_cubagem').AsFloat,'###.###');
                Grid.Cells[Grid.GetColumn('total'),p]:=TRansform(QPed.fieldbyname('mpdd_cubagem').AsFloat*unitario,f_cr);
              end else begin
                Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(qtde,f_qtdestoque);
                Grid.Cells[Grid.GetColumn('total'),p]:=TRansform(qtde*unitario,f_cr);
              end;
              Grid.Cells[Grid.getcolumn('move_remessas'),p]:='';
              Grid.Cells[Grid.getcolumn('vendamove'),p]:=Transform(QPed.fieldbyname('mpdd_venda').Ascurrency,f_cr);
      // 26.03.09 -Lam. Sao Caetano
              Grid.Cells[Grid.Getcolumn('codtamanho'),p]:=QPed.fieldbyname('mpdd_tama_codigo').Asstring;
              Grid.Cells[Grid.Getcolumn('codcor'),p]:=QPed.fieldbyname('mpdd_core_codigo').Asstring;
              Grid.Cells[Grid.Getcolumn('move_aliipi'),p]:=transform( FEstoque.Getaliquotaipi(QPed.fieldbyname('mpdd_esto_codigo').AsString,'S',EdComv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) ,'#0.0');
              Grid.Cells[Grid.getcolumn('cor'),p]:=FCores.Getdescricao(QPed.fieldbyname('mpdd_core_codigo').AsInteger);
              Grid.Cells[Grid.getcolumn('tamanho'),p]:=FTamanhos.Getdescricao(QPed.fieldbyname('mpdd_tama_codigo').Asinteger);
//              inc(p);
//              Grid.AppendRow;

            end else begin  // 12.04.10 - Granzotto - varios pedidos de venda marcados
////////////////
              if QPed.fieldbyname('mpdd_cubagem').asfloat>0 then begin
                Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(QPed.fieldbyname('mpdd_cubagem').AsFloat+texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]),'###.###') ;
//                Grid.Cells[Grid.GetColumn('total'),p]:=TRansform(QPed.fieldbyname('mpdd_cubagem').AsFloat*unitario,f_cr);
                Grid.Cells[Grid.GetColumn('total'),p]:=TRansform( (QPed.fieldbyname('mpdd_cubagem').AsFloat*unitario)+
                                                       Texttovalor( Grid.Cells[Grid.GetColumn('total'),p] )
                                                        ,f_cr);
              end else begin
                Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(qtde+texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]),f_qtdestoque) ;
                Grid.Cells[Grid.GetColumn('total'),p]:= TRansform(qtde*unitario +
                                                        texttovalor(Grid.Cells[Grid.GetColumn('total'),p]),f_cr);
              end;
// recalcular pre�o unitario pelo valor total poia pode variar o pre�o do produto
// quando faz promo��es
              Grid.Cells[Grid.GetColumn('move_venda'),p]:=TRansform(texttovalor(Grid.Cells[Grid.GetColumn('total'),p])/texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]),f_cr);
              Grid.Cells[Grid.getcolumn('vendamove'),p]:=TRansform(texttovalor(Grid.Cells[Grid.GetColumn('total'),p])/texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]),f_cr);
//              Grid.Cells[Grid.getcolumn('vendamove'),p]:=Transform(QPed.fieldbyname('mpdd_venda').Ascurrency,f_cr);

////////////////
            end;
          end;
        end;
        QPed.Next;
      end;
    end;



////////////////////////////////////////////////////////////
begin
////////////////////////////////////////////////////////////////

  restricao1:=true;
  restricao2:=true;
  restricao3:=true;
  restricao4:=true;
  usuariolib:=0;
  obsliberacao:='';
  unidades:=Global.Usuario.UnidadesMvto;
//  EdTotalServicos.SetValue(0);
  if Global.Topicos[1255] then
    unidades:=Global.CodigoUnidade;
  if EdCliente.resultfind<>nil then begin
//////////////// - 23.05.07 - restricoes de cr�dito
//    if (OP='I') and (Global.Topicos[1303]) and (campoufentidade='clie_uf') then begin
// 02.05.17 - nao checar limite para socios
    if (OP='I') and (Global.Topicos[1303]) and (campoufentidade='clie_uf')
       and ( EdCliente.resultfind.FieldByName('Clie_ativo').AsString <>'S' ) then begin
      restricao1:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','DUP',unidades );
      restricao2:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','BOL',unidades );
      restricao3:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','CHQ',unidades );
      restricao4:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','LIM',unidades );
      EdRepr_codigo.setvalue(Edcliente.ResultFind.fieldbyname('clie_repr_codigo').asinteger);
//      EdRepr_codigo.ValidFind;
    end else begin
      restricao1:=true;
      restricao2:=true;
      restricao3:=true;
      restricao4:=true;
    end;
    if not restricao1 then begin //fixo portador duplicata
//      if not Confirma('Venda a vista') then
// 27.11.08
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;
{
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
        if usuariolib>0 then begin
//          Input('Contato com representante','Observa��o',obsliberacao,150,true);
//          if trim(obsliberacao)='' then begin
//            EdCliente.Invalid('Preenchimento Obrigat�rio');
//            exit;
//          end;
          FGeral.Gravalog(16,'Venda Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' Repr.'+Sqled3.text+' - DUP',true,
                          '',usuariolib,obsliberacao);
        end else begin
          EdCliente.Invalid('');
          exit;
        end;
}

    end else if not restricao2  then begin //fixo portador boleto
//      if not Confirma('Venda a vista') then
// 27.11.08
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;

{
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
        if usuariolib>0 then begin
//          Input('Contato com representante','Observa��o',obsliberacao,100,true);
//          if trim(obsliberacao)='' then begin
//            EdCliente.Invalid('Preenchimento Obrigat�rio');
//            exit;
//          end;
          FGeral.Gravalog(16,'Venda Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' Repr.'+Sqled3.text+' - BOL',true,
                          '',usuariolib,obsliberacao);
        end else begin
          EdCliente.Invalid('');
          exit;
        end;
}
    end else if not restricao3  then begin //cheques devolvidos
// 27.11.08
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;
{
// 13.07.06 - tania
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
       if usuariolib>0 then begin
//          Input('Contato com representante','Observa��o',obsliberacao,100,true);
//          if trim(obsliberacao)='' then begin
//            EdCliente.Invalid('Preenchimento Obrigat�rio');
//            exit;
//          end;
          FGeral.Gravalog(16,'Venda Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' Repr.'+Sqled3.text+' - CHQ',true,
                          '',usuariolib,obsliberacao);
        end else begin
          EdCliente.Invalid('');
          exit;
        end;
}
    end else if not restricao4  then begin // total em aberto versus limite de cr�dito
// 05.06.07
//       usuariolib:=FUsuarios.GetSenhaAutorizacao(302);
//       if usuariolib>0 then begin
//       if usuariolib>0 then begin
//          FGeral.Gravalog(18,'Venda Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' Repr.'+Sqled3.text+' - LIM',true,
//                          '',usuariolib,obsliberacao);
        if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
          EdCliente.Invalid('');
          exit;
        end;
    end;

    if campoufentidade='clie_uf' then begin
      EdRepr_codigo.setvalue(Edcliente.ResultFind.fieldbyname('clie_repr_codigo').asinteger);
      EdRepr_codigo.ValidFind;
// 01.07.18
//      if Global.Topicos[1454] then EdCpf.Text:=Edcliente.ResultFind.fieldbyname('clie_cnpjcpf').asstring;
// 04.06.2022 - retirado pois em tese nfce somente cpf digitado sem 'puxar automatico' do cadastro..

      if not FGeral.ValidaCliente( EdCliente,Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring ) then
        EdCliente.Invalid('');
//      revenda:=Edcliente.ResultFind.fieldbyname('clie_consfinal').asstring;
// 09.03.17
//      if Edcliente.ResultFind.fieldbyname('clie_consfinal').asstring='S' then
//        revenda:='N'
//      else
//        revenda:='S';

// 01.07.19
      if Edcliente.ResultFind.fieldbyname('clie_consfinal').asstring='R' then revenda:='S'
      else revenda:='N';

// 18.11.11
      if campoclifpgt.Tipo<>'' then begin
         EdFpgt_codigo.text:=EdCliente.resultfind.fieldbyname('clie_fpgt_codigo').asstring;
         EdFpgt_codigo.validfind;
      end;
// 17.01.12
      if ( ecf='S' ) and ( OP='I' ) then begin
        EdUnid_codigo.Enabled:=false;
        EdUnid_codigo.validfind;
        EdUnid_codigo.valid;
        EdNatf_codigo.Enabled:=false;
        EdNatf_codigo.valid;
        EdDtMovimento.enabled:=false;
        EdDtMovimento.valid;
      end else begin
        EdUnid_codigo.Enabled:=true;
        EdNatf_codigo.Enabled:=true;
// 28.06.17
        EdDtmovimento.Enabled:=Global.Topicos[1387];  // para permitir mudar a data em qq tipo de movimento
      end;
    end else begin
//      if Devolucaocompra(Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring) or TiposFornecedor(Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring) then
//        EdRepr_codigo.setvalue(0)
//      else
        EdRepr_codigo.setvalue(Edcliente.ResultFind.fieldbyname('clie_repr_codigo').asinteger);
      revenda:='N';
    end;
    if OP='A' then begin  // 06.11.09
      EdRepr_codigo.enabled:=true;
      EdRepr_codigo.setfocus;
    end else begin
      if Global.Topicos[1339] then begin
        EdRepr_codigo.enabled:=false;
//        EdRepr_codigo.ValidFind;  // 08.09.10
      end else
        EdRepr_codigo.enabled:=true;
    end;
    if not global.topicos[1301] then begin
// 31.08.05
      if (OP='I') and ( pos(Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodVendaAmbulante+';'+Global.CodVendaMagazine)>0 ) then
          EdNumerodoc.enabled:=true
      else if OP<>'A' then
          EdNumerodoc.enabled:=false;
   end;
// 09.08.06
//    Editsconsig('D');;
//    if (OP='I') and (Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaConsigMercantil) then begin
//      Editsconsig('A');
//      SetaItemsConsig(Global.CodConsigMercantil,EdVendasmc);    // vendas
//      SetaItemsConsig(Global.CodDevolucaoConsigMerc,EdDevolucoesdm);  //devolucoes
//    end;
// 28.11.07
//    if (OP='I') and (Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodContratoEntrega) then begin
//      Editsconsig('A');
//      SetaItemsConsig(Global.CodContrato,EdVendasmc);    // vendas contrato
// 25.03.10
//      SetaItemsConsig(Global.CodContrato+';'+Global.CodContratoNota,EdVendasmc);    // vendas contrato
//      SetaItemsConsig(Global.CodContratoEntrega,EdDevolucoesdm);    // vendas contrato entrega
//    end;
// 08.06.09
//    if (OP='I') and (Edcomv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodDevolucaoCompra) then begin
//      Editsconsig('A');
//      SetaItemsConsig(Global.CodCompra,EdVendasmc);    // compras
//    end;
// 18.03.13
    EdUnid_codigo.ValidFind;
    EdUnid_codigo.Valid;
// 22.08.18
//    EdUnid_codigo.ValidateEdit;

    if Global.Usuario.OutrosAcessos[0340] then EdDtemissao.setfocus
// 30.07.15
    else if EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCe') then begin
// 03.11.15
       if ( EdDtmovimento.enabled ) then begin
         EdDtMovimento.setfocus;
       end else begin
         EdCpf.setfocus;
       end;
    end else begin
// 28.06.17
      if Global.Topicos[1387] then
         EdDtMovimento.setfocus
      else
        bincluiritemclick(self);
    end;
  end;

end;

procedure TFVendaBalcao.EdQtdeExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////
var conf:boolean;
    QEst:TSqlquery;
begin

  if codigobarra then
    conf:=true
// 08.04.13 - Benato
  else if codbarrabalanca='S' then
    conf:=true
  else
    conf:=confirma('Confirma item ?');
// 11.06.2022
//    if (Time >= StrToTime('23:45:00')) and ( not EdDtmovimento.IsEmpty ) then begin
    if (Time <= StrToTime('00:15:00')) and ( not EdDtmovimento.IsEmpty ) then begin

      FGeral.gravalog(41,
                      '02 - Data Atual '+FGeral.formatadata(Sistema.hoje)+
                      ' Data Tela '+FGeral.formatadata(EdDtEmissao.AsDate) );
      EdDtMovimento.SetDate(FGeral.GetDataServidor);
      EdDtEmissao.SetDate(FGeral.GetDataServidor);
    end;


  if conf then begin
    EditstoGrid;
    SetaEditsValores;
// 17.10.15 - op��o de baixar o estoque somente na gravacao
    if ( not Global.Topicos[1201] ) then begin
              QEst:=sqltoquery('select esto_grup_codigo,esto_sugr_codigo,esto_fami_codigo,esqt_qtde,esqt_qtdeprev,esqt_pecas,esto_baixavenda from estoque'+
                               ' inner join estoqueqtde on ( esto_codigo=esqt_esto_codigo )'+
                               ' where esto_codigo='+stringtosql(EdProduto.text)+
                               ' and esqt_status=''N'' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text) );
                FGeral.MovimentaQtdeEstoque(EdProduto.text,
                                          EdUnid_codigo.text,'S',EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,
                                          EdQtde.ascurrency,
                                          QEst,
                                          EdQtde.ascurrency,
                                          0);
                FGeral.Fechaquery(QEst);
                Sistema.commit;
    end;

//    if Ecf='S' then
//      ImprimeItem;
    if op='A' then begin
      ListaReservaCodigo.Clear;
      ListaReservaQtde.Clear;
    end;
  end;
  LimpaEditsItens;
  EdProduto.SetFocus;
  QEstoque.close;
  Freeandnil(QEstoque);


end;

procedure TFVendaBalcao.SetaEditsValores;
///////////////////////////////////////////

var baseicms,vlricms,basesubs,icmssubs,totalprodutos,totalnota,totalitem,aliicms,icmsitem,margemlucro,tdescacre,
    tqtde,icmsitemsubs,aliipi,ipiitem,vlripi,totalitembase,totalpesoliquido,aliiss,vlrservicos,
    aliicmsgeral,totalqtdevolumes:currency;
    p:integer;
    produto,descacre:string;
    precovenda:extended;  // 01.07.08 - mudado de currency pra extended para 'ver' mais casas decimas devido saida abate

    function Calctabela(valor:currency):currency;
    ////////////////////////////////////////////////
    begin
      result:=FGeral.Arredonda( valor*(Arq.TTabelapreco.fieldbyname('tabp_aliquota').AsCurrency/100) ,2 );
    end;

begin

// 02.06.06
  if ( pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodVendaRE+';'+Global.CodVendaREFinal)>0 )
    and (op='A') then
     exit;

  baseicms:=0; vlricms:=0; basesubs:=0 ; icmssubs:=0 ; totalprodutos:=0 ; totalbruto:=0; tqtde:=0;
  vlripi:=0;totalpesoliquido:=0;aliiss:=0;vlrservicos:=0;totalqtdevolumes:=0;
// percorrer o grid somando valores e montando base do icms normal e subst. tribut�ria
  produtosnota:='';
  for p:=1 to Grid.rowcount do begin
    produto:=Grid.Cells[Grid.GetColumn('move_esto_codigo'),p];

    if trim(produto)<>'' then begin

      produtosnota:=produtosnota+Grid.Cells[Grid.GetColumn('esto_referencia'),p]+';';
      precovenda:=texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]);
      aliicms:=texttovalor(Grid.Cells[Grid.GetColumn('Move_aliicms'),p] );
      aliipi:=texttovalor(Grid.Cells[Grid.GetColumn('Move_aliipi'),p] );
//      totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * precovenda  ,2);
// 01.07.08
//      totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * precovenda  ,5);
// 14.07.08 - usar o total do grid ao inves da qtde*unitario
// 04.08.18 - devido as validacoes do xml 4.0
//      if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodContratoDoacao)>0 then

        totalitem:=texttovalor(Grid.Cells[Grid.GetColumn('total'),p] );

//      else
//        totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * precovenda  ,5);

      tqtde:=tqtde+texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]);
      totalbruto:=totalbruto+totalitem;
      if EdPeracre.ascurrency>0 then begin
        totalitem:=totalitem+FGEral.Arredonda( totalitem*(EdPeracre.ascurrency/100) ,2  );
      end else if EdPerdesco.ascurrency>0 then begin
        totalitem:=totalitem-FGEral.Arredonda( totalitem*(EdPerdesco.ascurrency/100) ,2 );
      end;
//      Arq.TEstoque.locate('esto_codigo',produto,[]);
//    Arq.TSittributaria.Locate('sitt_codigo',FEstoque.Getsituacaotributaria(produto,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring),[]);
      Arq.TSittributaria.Locate('sitt_codigo',FEstoque.GetCodigosituacaotributaria(produto,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring),[]);
//      aliicms:=FEstoque.Getaliquotaicms(produto,EdUnid_codigo.text,Edcliente);
/////////////////
// 10.07.07 - corrigido a cagada...
      if texttovalor(Grid.Cells[Grid.GetColumn('move_redubase'),p])>0 then
// 24.05.07 - reducao de base
        totalitembase:=( totalitem*(texttovalor(Grid.Cells[Grid.GetColumn('move_redubase'),p])/100) )
      else
        totalitembase:=totalitem;
// 10.02.09 - Asatec
//      ipiitem:=FGeral.Arredonda( totalitem*(aliipi/100) ,2);
// 14.07.09 - dif. 01 centavo na clessi
      ipiitem:=FGeral.Arredonda( totalitem*(aliipi/100) ,3);
//      if (Global.Topicos[1327]) and (Revenda<>'R') then
// 31.03.10
      if (Global.Topicos[1327]) and (Revenda='S') then
        icmsitem:=FGeral.Arredonda( (totalitembase+ipiitem)*(aliicms/100) ,2)
// 07.07.11 - Clessi - devolucao de mat. uso e consumo
      else if ( Global.Topicos[1350] ) and ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,TiposDevolucao)>0 ) then
        icmsitem:=FGeral.Arredonda( (totalitembase+ipiitem)*(aliicms/100) ,2)
      else
        icmsitem:=FGeral.Arredonda( totalitembase*(aliicms/100) ,2);
      if EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaConsigMercantil then begin
        aliicms:=0;
        icmsitem:=0;
      end;
      margemlucro:=0;
// 05.12.05
      if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.TiposNaoCalcIcms)>0 then begin
        icmsitem:=0;
      end;
// 01.12.09 - Abra
      if (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.CodRemessaInd) and
         ( Texttovalor(Grid.Cells[Grid.GetColumn('codcor'),p])>0 ) and
         ( Texttovalor(Grid.Cells[Grid.GetColumn('codtamanho'),p])>0 ) then
         totalpesoliquido:=totalpesoliquido+(FEstoque.GetPeso(produto)*texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]))
// 29.01.13 - Novicarnes - Elize - 'Posto Guar�'
      else if EdPecas.Enabled then begin
         totalpesoliquido:=totalpesoliquido+texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]);
         totalQtdevolumes:=totalQtdevolumes+texttovalor(Grid.Cells[Grid.GetColumn('move_pecas'),p])
      end;
      if icmsitem>0 then begin
//        if (Global.Topicos[1327]) and (Revenda<>'R') then
// 31.03.10
        if (Global.Topicos[1327]) and (Revenda='S') then
          baseicms:=baseicms+totalitembase+ipiitem
// 07.07.11 - Clessi - devolucao de mat. uso e consumo
        else if ( Global.Topicos[1350] ) and ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,TiposDevolucao)>0 ) then
          baseicms:=baseicms+totalitembase+ipiitem
        else
          baseicms:=baseicms+totalitembase;
        vlricms:=vlricms+icmsitem;
      end;
      vlripi:=vlripi+ipiitem;
      icmsitemsubs:=0;   // 07.12.05
      if Arq.TSittributaria.fieldbyname('sitt_cf').asstring=Global.CodigoSubsTrib then begin
// 10.02.05 - reges
        if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.TiposNaoCalcSubsTrib)=0 then begin
          margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname(campoufentidade).asstring));
          basesubs:=basesubs+( totalitem*(1+(margemlucro/100)) );
          icmsitemsubs:=(totalitem*(1+(margemlucro/100))) * (aliicms/100);
          icmsitemsubs:=icmsitemsubs-icmsitem;
        end else begin
          icmsitemsubs:=0;
        end;
        icmssubs:=icmssubs+icmsitemsubs;
      end;
      if Servico(Produto) then begin
        aliiss:=( texttovalor( Grid.cells[Grid.getcolumn('perciss'),p]) );
        vlrservicos:=vlrservicos+totalitem;
      end else
        totalprodutos:=totalprodutos+totalitem;
    end;
  end;
////////////////
{ - 25.08.05 - estava dando o desconto no unit�rio e no total
  if EdMoes_tabp_codigo.AsInteger>0 then begin
    if Arq.TTabelaPreco.Locate('tabp_codigo',EdMoes_tabp_codigo.AsInteger,[]) then begin
      descacre:=Arq.TTabelaPreco.Fieldbyname('tabp_tipo').AsString;
    end else
      descacre:='';
    tdescacre:=FGeral.Arredonda(totalprodutos*(Arq.TTabelapreco.fieldbyname('tabp_aliquota').AsCurrency/100) ,2);
    if descacre='D' then begin
      totalprodutos:=totalprodutos-tdescacre;
      baseicms:=baseicms-Calctabela(baseicms);
      vlricms:=vlricms-Calctabela(vlricms);
      basesubs:=basesubs-Calctabela(basesubs);
      icmssubs:=icmssubs-Calctabela(icmssubs);
    end else if descacre='A' then begin
      totalprodutos:=totalprodutos+tdescacre;
      baseicms:=baseicms+Calctabela(baseicms);
      vlricms:=vlricms+Calctabela(vlricms);
      basesubs:=basesubs+Calctabela(basesubs);
      icmssubs:=icmssubs+Calctabela(icmssubs);
    end;
  end;
}
//////////////////////////
// 08.09.05
//  if not DevolucaoCompra(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) then begin
//    if campoufentidade='clie_uf' then begin  // 27.09.07
//      if (EdDtmovimento.asdate<=1) or (EdCliente.resultfind.fieldbyname('clie_tipo').asstring<>'F') then begin
//        basesubs:=0;
//        icmssubs:=0;
//      end;
//    end;
//  end else begin   // 23.09.05
      basesubs:=0;
      icmssubs:=0;
//  end;
// 30.08.05 - Valmir - notas feitas pelo representante no bloco nao tem icms mas tem substitui��o
  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.CodVendaAmbulante then begin
    baseicms:=0;
    vlricms:=0;
  end;
// 08.10.12 - Niver Marta - 50 anos - Asatec - Fernanda
//  baseicms:=baseicms+EdFrete.ascurrency+EdSEguro.ascurrency;
// 24.10.12 - se for do simples nao tributa o frete nem seguro...
  if pos( FUnidades.GetSimples(Edunid_codigo.text),'S;2') = 0 then
    baseicms:=baseicms+EdFrete.ascurrency+EdSEguro.ascurrency;

  if EdCliente.resultfind.fieldbyname(campoufentidade).asstring<>Global.UFUnidade then
    aliicmsgeral:= FCodigosFiscais.GetAliquota(FUnidades.GetFiscalFora(EdUnid_codigo.text))
  else
    aliicmsgeral:= FCodigosFiscais.GetAliquota(FUnidades.GetFiscalDentro(EdUnid_codigo.text));

  vlricms:=vlricms+( (EdFrete.ascurrency+EdSEguro.ascurrency) *
                     ( (aliicmsgeral/100) ) );
///////////////////////////////////////////////
// 15.02.10
  EdPeriss.setvalue( aliiss );
// 25.05.10 - devido a poder vir do pedido ou digitado direto na nota
  if vlrservicos>0 then begin
//    EdTotalServicos.SetValue( vlrservicos );
//    EdValorIss.SetValue( vlrservicos*(aliiss/100) );
  end;
// 23.04.10 - Abra - Notas RI tem q colocar o peso
{
  if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.CodRemessaInd then begin
    if totalpesoliquido>0 then begin
      EdPesoLiq.SetValue(totalpesoliquido);
      EdPesoBru.SetValue(totalpesoliquido);
    end;
  end else begin
    if EdPesoliq.ascurrency=0 then
      EdPesoLiq.SetValue(totalpesoliquido);
    if EdPesoBru.ascurrency=0 then
      EdPesoBru.SetValue(totalpesoliquido);
// 01.02.13
    if EdQTdeVolumes.ascurrency=0 then EdQTdeVolumes.text:=currtostr(totalQtdevolumes);
  end;
  }
////////////
  totalnota:=totalprodutos+vlrservicos+EdFrete.Ascurrency+EdSeguro.ascurrency+icmssubs+vlripi;

  PTotais.EnableEdits;
//  EdTotalnota.enabled:=true;
  EdBaseicms.setvalue(baseicms);
  EdValoricms.setvalue(vlricms);
  EdQtdetotal.setvalue(tqtde);
  Edvaloripi.setvalue(vlripi);
// 08.09.05
//  if not DevolucaoCompra(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring) then begin
//    if campoufentidade='clie_uf' then begin  // 27.09.07
//      if EdCliente.resultfind.fieldbyname('clie_tipo').asstring<>'F' then begin
//        EdBasesubs.setvalue(0);
//        EdValorsubs.setvalue(0);
//      end else begin
//        EdBasesubs.setvalue(basesubs);
//        EdValorsubs.setvalue(icmssubs);
//      end;
//    end;
//  end else begin
      EdBasesubs.setvalue(basesubs);
      EdValorsubs.setvalue(icmssubs);
//  end;

//  Edtotalprodutos.setvalue(totalprodutos);
// 29.08.11 - para o caso de ter descontos ou acrescimentos na nota...
  Edtotalprodutos.setvalue(totalbruto);

  Edtotalnota.setvalue(totalnota);
  EdValorRecebido.setvalue(totalnota);
//  EdTotalnota.enabled:=false;
  PTotais.DisableEdits;
end;

//
procedure TFVendaBalcao.Timer1Timer(Sender: TObject);
///////////////////////////////////////////////////////////////
var texto,
    xarq : string;
//    img   : TJPEGImage;
    img   : TBitMap;
    p     : integer;

begin

//      Texto:= ' '+Label1.caption+' ';
//      Texto:= Label1.caption+' ';
//      Texto:= Label1.caption;
//      Label1.caption := copy(Texto,2,length(Texto))+ Texto[1];
//       ImageList1.GetBitmap(i,Image1)
//        img   := TJPEGImage.create;

{ timagelist tem q ser 'muito pequeno' as imagens
        img   := TBitmap.create;
        ImageList1.GetBitmap(0, img);
        if img.Height > 0 then
        begin
          Image1.Picture.Bitmap.Assign(img);
          Image1.Refresh;
        end;
        img.FreeImage;
}
{
      for p := 1 to 3 do begin

         xarq := 'figura'+inttostr(p)+'.bmp';
         Image1.Picture.LoadFromFile( xarq );
         Image1.Refresh;
//         Delay( 5000 );

      end;
}

//        aviso(' primeira figura' );


end;

procedure TFVendaBalcao.TimerTimer(Sender: TObject);
///////////////////////////////////////////////////////
begin

//   bafaturar.Visible:= not bafaturar.Visible
//   bafaturar.Font.Color  := clYellow;
   bafaturar.Transparent := not bafaturar.Transparent;
//   delay(1000);
   bafaturar.Font.Color  := clRed;
   bafaturar.Caption     := UPpercase( bafaturar.caption );

end;

procedure TFVendaBalcao.brelpendentesClick(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Pendentes('R',EdCliente.AsInteger); ;

end;

// 29.06.18
procedure TFVendaBalcao.bafaturarClick(Sender: TObject);
//////////////////////////////////////////////////////////////
begin

   if not sistema.processando then  FValoraFAturar.Execute;

end;

procedure TFVendaBalcao.bbaixaClick(Sender: TObject);
begin
  if not Sistema.Processando then FBaixaPendencia.Execute;

end;

procedure TFVendaBalcao.blebalanca1Click(Sender: TObject);
begin
    abrirporta;

end;

procedure TFVendaBalcao.blebalanca2Click(Sender: TObject);
begin
    abrirporta2;

end;

function TFVendaBalcao.AbrirPorta: boolean;
Var TimeOut : Integer ;
begin
  if Global.Usuario.OutrosAcessos[0331] then begin
     if not AcbrBal1.Ativo then ACbrBal1.Ativar;
//     try - ver se cria config. para timeou
//        TimeOut := StrToInt( edtTimeOut.Text ) ;
//     except
        TimeOut := 2000 ;
//     end ;

     ACBrBAL1.LePeso( TimeOut );

  end;

end;

function TFVendaBalcao.AbrirPorta2: boolean;
begin

end;

procedure TFVendaBalcao.SerialRxChar(Sender: TObject; Count: Integer);
var Buffer:array[1..1024] of char; s:String; i,q:Integer;
begin


end;

procedure TFVendaBalcao.Serial2RxChar(Sender: TObject; Count: Integer);
var Buffer:array[1..1024] of char; s:String; i,q:Integer;
begin
end;

procedure TFVendaBalcao.bExcluiritemClick(Sender: TObject);
///////////////////////////////////////////////////////////
var codigoestoque:string;
    qtde:currency;
    QEst:TSqlquery;
begin

  if trim(Grid.Cells[Grid.GetColumn('move_esto_codigo'),Grid.row])='' then exit;
  if (EdRepr_codigo.AsInteger=0) and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,TiposDevolucao)=0 ) then exit;

  if confirma('Confirma exclus�o ?') then begin

    codigoestoque:=Grid.Cells[Grid.GetColumn('move_esto_codigo'),Grid.row];
    qtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
    Grid.DeleteRow(Grid.Row);
    SetaEditsValores;
    EdComv_codigo.validfind;
    if ( not Global.Topicos[1201] ) then begin
              QEst:=sqltoquery('select esto_grup_codigo,esto_sugr_codigo,esto_fami_codigo,esqt_qtde,esqt_qtdeprev,esqt_pecas,esto_baixavenda from estoque'+
                               ' inner join estoqueqtde on ( esto_codigo=esqt_esto_codigo )'+
                               ' where esto_codigo='+stringtosql(codigoestoque)+
                               ' and esqt_status=''N'' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text) );
                FGeral.MovimentaQtdeEstoque(codigoestoque,
                                          EdUnid_codigo.text,'E',EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,
                                          Qtde,
                                          QEst,
                                          Qtde,
                                          0);
                FGeral.Fechaquery(QEst);
                Sistema.commit;
    end;
  end;
  EdFpgt_codigo.ValidateEdit;
end;

procedure TFVendaBalcao.ReservaEstoque(Codigo, IncExc: string;  Qtde: currency);
///////////////////////////////////////////////////////////////////////////////////////
var p:integer;
begin
  if not Global.Topicos[1201] then begin
    if Incexc='I' then begin
      ListaReservaCodigo.Add(Codigo);
      ListaReservaQtde.Add(transform(Qtde,'#,###,###.00'));
      FGeral.ReservaEstoque(Codigo,EdUnid_codigo.text,'S',Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Qtde);
    end else begin
      if OP='I'then begin
        p:=ListaReservaCodigo.IndexOf(Codigo);
        if p>-1 then begin
          ListaReservaCodigo.Delete(p);
          ListaReservaQtde.Delete(p);
          FGeral.ReservaEstoque(Codigo,EdUnid_codigo.text,'E',Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Qtde);
        end;
      end else begin
          FGeral.ReservaEstoque(Codigo,EdUnid_codigo.text,'E',Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Qtde);
      end;
    end;
    Sistema.Commit;
  end;

end;

procedure TFVendaBalcao.bcupomClick(Sender: TObject);
/////////////////////////////////////////////////////////
begin
//  if not Sistema.Processando then FGerenciaECF.Execute;
// 10.11.15
//  if not Sistema.Processando then FGerenciaNfe.Execute(EdNumerodoc.text);
// 12.11.15
//  if not Sistema.Processando then FGerenciaNfe.Execute;

// 30.10.17
  if Global.Topicos[1021] then begin

    if not Sistema.Processando then FGerenciaECF.Execute

  end else

    if not Sistema.Processando then FGerenciaNfe.Execute('','NFCe');


end;

procedure TFVendaBalcao.bgeraboletoClick(Sender: TObject);
begin
///////////////////   FBoletos.Execute();

end;

procedure TFVendaBalcao.bgeranfeClick(Sender: TObject);
begin
  if EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCe') then begin
    FExpNfetxt.Execute( 0,'NFCe' );   // 05.11.15
    EdProduto.SetFocus;
  end else if (Global.Topicos[1020]) and (EdComv_codigo.asinteger>0) then
    FExpNfetxt.Execute( EdNumerodoc.AsInteger )
  else
    FExpNfetxt.Execute;

end;

///////////////////////////////////////////////////////////////////////////////////////
procedure TFVendaBalcao.bgravarClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////////////////////
var Numero,romaneio,xpedido:integer;
    valorcomissao,valoravista:currency;
    QVePendencia,QVeNFe:Tsqlquery;
    Tipocad:string;

    function TotalParcela:currency;
    var p:integer;
        valor:currency;
    begin
      valor:=0;
      for p:=1 to Gridparcelas.rowcount do begin
        valor:=valor+texttovalor(Gridparcelas.cells[1,p]);
      end;
      result:=valor;
    end;

   function GetTotalServicos:currency;
   //////////////////////////////////////
   var i:integer;
   begin
     result:=0;
     {
     for i:=0 to ListaServicos.Count-1 do begin
       PServicos:=ListaServicos[i];
       result:=result+(PServicos.qtde*PServicos.unitario);
     end;
     }
   end;

   function GetPerIss:currency;
   var i:integer;
   begin
     result:=0;
     for i:=0 to ListaServicos.Count-1 do begin
       PServicos:=ListaServicos[i];
       result:=PServicos.periss;
     end;
   end;

// 20.09.12 - benato e antigo novicarnes
   procedure BaixaMateriaPrima;
/////////////////////////////////////////////////////////////
   var xTipoMovimento,xTipocad,sqlcor,sqltamanho,sqlcopa:string;
        QCusto,QEst:TSqlquery;
        linha:integer;
    begin
      xTipoMovimento:=Global.CodBaixaMatSai;
      xTipoCad:='C';
      for linha:=1 to Grid.RowCount do begin
        if trim(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])<>'' then begin
          if strtointdef(Grid.cells[Grid.getcolumn('codcor'),linha],0)>0 then
            sqlcor:=' and cust_core_codigo='+Grid.cells[Grid.getcolumn('codcor'),linha]
          else
            sqlcor:=' and cust_core_codigo=0';
          if strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),linha],0)>0 then
            sqltamanho:=' and cust_tama_codigo='+Grid.cells[Grid.getcolumn('codtamanho'),linha]
          else
            sqltamanho:=' and cust_tama_codigo=0';
          if strtointdef(Grid.cells[Grid.getcolumn('codcopa'),linha],0)>0 then
            sqlcopa:=' and cust_copa_codigo='+Grid.cells[Grid.getcolumn('codcopa'),linha]
          else
            sqlcopa:=' and cust_copa_codigo=0';
          QCusto:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
                  ' inner join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Global.CodigoUnidade)+' )'+
                  ' where cust_status=''N'' and cust_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                   sqlcor+sqltamanho+sqlcopa+' order by cust_esto_codigomat');
// 16.10.12 - Benato - checagem do subgrupo 2 carne bovina
          if (QCusto.eof) and ( FEstoque.GetSubGrupo( Grid.Cells[grid.GetColumn('move_esto_codigo'),linha] )= 2 ) then
            Avisoerro('Checar, n�o encontrado composi��o. Comando '+Qcusto.SQL.Text);
          while (not QCusto.eof)  do begin
              QEst:=sqltoquery('select esto_grup_codigo,esto_sugr_codigo,esto_fami_codigo,esqt_qtde,esqt_qtdeprev,esqt_pecas,esto_baixavenda from estoque'+
                               ' inner join estoqueqtde on ( esto_codigo=esqt_esto_codigo )'+
                               ' where esto_codigo='+stringtosql(QCusto.fieldbyname('cust_esto_codigomat').asstring)+
                               ' and esqt_status=''N'' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text) );
              if (QEst.fieldbyname('esto_baixavenda').asstring<>'N') then begin
                FGeral.MovimentaQtdeEstoque(QCusto.fieldbyname('cust_esto_codigomat').asstring,
                                          EdUnid_codigo.text,'S',xTipoMovimento,
                                          texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency,
                                          QEst,
                                          texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency,
                                          texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency );
                Sistema.Commit;
              end else
                Avisoerro('Checar, n�o baixado estoque do item '+QCusto.fieldbyname('cust_esto_codigomat').asstring+
                          ' da unidade '+EdUnid_codigo.text );
              FGeral.Fechaquery(QEst);
///////////////////////////
            QCusto.next;
          end; // percorre planilha de custos
          FGeral.Fechaquery(QCusto);
        end;  // tiver codigo
      end;  // Grid Produtos
   end;
////////////////////////////////////////////////////////////////////


////////////////////gravacao nota de saida
var xCondicao,unidadecomissao,portador,unidade,Natf_codigo:string;   // 08.12.08
    Numerodoc,ConfMovServicos,xnumero,p,numerosalto:integer;
    FazNotadeServicos,xPedeImpressao:boolean;
    QConf:TSqlquery;
    TotalServicos,AliqIss,numvias:currency;
    DataSaidaAux,DataEmissaoAux:TDatetime;
    conf:boolean;

    // 06.04.11
    function PedeImpressao:boolean;
    ///////////////////////////////
    begin
       result:=false;  // 07.03.15
// 28.08.15
       if EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCe') then
         result:=false
       else if Global.Topicos[1349] then
         result:=true
       else if (Global.UsaNfe='S') and ( not EdDtMovimento.IsEmpty ) then
         result:=false;
    end;

////////////////////////////////////////////////////////////////////////
begin

   if EdComv_codigo.resultfind=nil then exit;

   if not EdCliente.validfind then begin
     Avisoerro('Checar cliente');
     exit;
   end;
// 06.08.05
//   if not EdUnid_codigo.valid then begin
   if EdUnid_codigo.isempty then begin
     Avisoerro('Checar unidade');
     exit;
   end;
   if (EdFpgt_codigo.isempty) and
// 07.03.08 - 30.01.12 - Abra-Adriano + VY - contrato nota
       ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodContratoDoacao+';'+Global.CodContratoNota)=0 )
    then begin
     Avisoerro('Checar condi��o de pagamento');
     exit;
   end;
//   if not Edrepr_codigo.valid then begin
//   if (Edrepr_codigo.isempty) or (strtointdef(Edrepr_codigo.text,0)=0) then begin
// 26.01.12
  if (EdRepr_codigo.AsInteger=0) and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,TiposDevolucao)=0 ) then begin
     Avisoerro('Checar representante');
     exit;
   end;
// 22.08.08
   if (trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),1])='')  then begin
//     Avisoerro('Obrigat�rio informar ao menos um produto');
// 04.04.16 - retirado devido a devereda
     exit;
   end;
// 11.06.08 - 18.01.12 - consumidor passar devido ao ECF
   if (not EdDtmovimento.isempty) and (Global.Topicos[1319]) and (EdCliente.asinteger<>FGeral.GetConfig1AsInteger('clieconsumidor') ) then begin
     if campoufentidade='forn_uf' then begin
       if ( not FGeral.CnpjcpfOK(EdCliente.resultfind.fieldbyname('forn_cnpjcpf').AsString) ) then  begin
         Avisoerro('Obrigat�rio fornecedor com CNPJ/CPF v�lido');
         exit;
       end;
     end else begin
       if ( not FGeral.CnpjcpfOK(EdCliente.resultfind.fieldbyname('clie_cnpjcpf').AsString) ) then  begin
         Avisoerro('Obrigat�rio cliente com CNPJ/CPF v�lido');
         exit;
       end;
     end;
   end;
//////////// - 16.07.09
   if (EdDtmovimento.isempty) and (not Global.Usuario.OutrosAcessos[0319]) then begin
       Avisoerro('Usu�rio sem permiss�o para este tipo de nota');
       exit;
   end;
//////////
   valoravista:=0;
// 05.01.12 - colocado VY - adriano
   if (FCondpagto.GetAvPz(EdFpgt_codigo.text)='P') and (FGeral.GetGeraFinanceiro(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)='S')
      and ( pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodContratoDoacao+';'+
            Global.CodDevolucaoCompraProdutor+';'+Global.CodContratoNota)=0 )
     then begin
//     if EdTotalnota.ascurrency-EdVlrdesco.ascurrency<>Totalparcela then begin
// 24.10.05 - total da nota ja esta com desconto
     if EdTotalnota.ascurrency<>Totalparcela then begin
       Avisoerro('Total da nota :'+formatfloat(f_cr,EdTotalnota.ascurrency)+' difere do total de parcelas :'+formatfloat(f_cr,Totalparcela));
       exit;
     end;
   end;
   if FCondpagto.GetPrimeiroPrazo(EdFpgt_codigo.text)=0 then begin
     if gridparcelas<>nil then
        valoravista:=texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),1] );
   end;
   if (Grid.RowCount<=1)then begin
     Avisoerro('Sem parcelas para o financeiro');
     exit;
   end;
   if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring <> Global.CodVendaConsig then begin
     if EdTran_codigo.asinteger=0 then begin
       Avisoerro('Obrigat�rio codigo do transportador');
       exit;
     end;
   end;
// 02.03.06
   if not FGeral.ValidaGridVencimentos(GridParcelas) then exit;
// 23.05.11 - Novi - Isonel
   if (campoufentidade='clie_uf') and ( pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.TiposRelVenda)>0 ) then begin
     if not FCidades.ValidaFatporCidade(EdCliente.ResultFind.fieldbyname('Clie_cida_codigo_res').AsInteger,global.Usuario.Codigo,EdNumerodoc.asinteger,EdTotalNota.ascurrency ) then exit;
   end;
// 30.07.15
  if (EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCe')) or
     (EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCeVC')) then begin
    Sistema.edit('clientes');
    Sistema.setfield('clie_cnpjcpf',EdCpf.text);
// 16.11.15
    if Edcpf.isempty then
      Sistema.setfield('clie_encargoscob','N')
    else
      Sistema.setfield('clie_encargoscob','');
    Sistema.post('clie_codigo='+EdCliente.assql);
    Sistema.commit;
  end;

//////////////////////
   if OP='A' then begin
        QVePendencia:=sqltoquery('select * from pendencias where '+FGeral.Getin('pend_status','B;P;K','C')+
//                             ' and pend_numerodcto='+EdNumerodoc.AsSql+
// 21.09.11 - banco versao 8.4.1 mais 'rigoroso'
                             ' and pend_numerodcto='+Stringtosql(EdNumerodoc.text)+
                             ' and pend_datamvto>='+EdDtemissao.assql+' and pend_tipocad=''C'' and pend_tipo_codigo='+EdCliente.assql+
// 28.08.09 - Novicarnes - nf 2005 -- coincidiu
                             ' and pend_unid_codigo='+EdUnid_codigo.AsSql);
        if not QVePendencia.eof then begin
             Avisoerro('Nota com pend�ncia financeira baixada.  Transa��o '+QVependencia.fieldbyname('pend_transacao').asstring+'.  Altera��o n�o permitida.');
             exit;
        end;
       qVePendencia.close;
// 12.11.09
      campo:=Sistema.GetDicionario('movesto','moes_dtnfeauto');
      if campo.Tipo<>'' then begin
        QVeNfe:=sqltoquery('select moes_transacao,moes_dtnfeauto from movesto where moes_numerodoc='+EdNumerodoc.AsSql+
                           ' and moes_unid_codigo='+EdUnid_codigo.AsSql+
                           ' and moes_dataemissao='+EdDtEmissao.AsSql+
                           ' and moes_tipo_codigo='+EdCliente.AsSql+
                           ' and moes_status<>''C''');
        if not QVeNfe.eof then begin
          if Datetoano( QVeNfe.fieldbyname('moes_dtnfeauto').asdatetime,true )>1920 then begin
             Avisoerro('NFe j� autorizada pela SEFA.  Transa��o '+QVeNfe.fieldbyname('moes_transacao').asstring+'.  Altera��o n�o permitida.');
             exit;
          end;
        end;
        FGeral.FechaQuery(QVeNfe);
      end;

   end;
// 07.03.15 - Devereda - Linda
   if (global.topicos[1381]) and ( not global.topicos[1391] )  then
     conf:=true
   else
     conf:=confirma('Confirma grava��o ?');
   if conf  then begin
//      if Ecf='S' then
//        Imprimetotal;
      ListaReservaCodigo.Clear;
      ListaReservaQtde.Clear;
      Romaneio:=0;
// 30.08.05 - tentar evitar q lance enquanto ainda estiver gravando... ou q leia algum outro codigo de barra
      Sistema.BeginProcess('Gravando');
// 27.08.04 - colocado unidade no contador das notas e remaneios de saida
        Sistema.BeginTransaction('');
        if (OP='I') or (OP='S') or (OP='G') then begin
// 23.02.07
          if  not Global.Topicos[1301] then begin
            if ecf='S' then
              Numero:=FGeral.GetContador('NFSAIDAECF'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false,FALSE)+1
            else if (EdDtmovimento.asdate<=1) and (OP='I') then begin
              Numero:=FGeral.GetContador('SAIDA'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false,false);

            xpedido:=0;
//////////
            end else if (OP='S') then
              Numero:=EdNumerodoc.asinteger
            else begin
              if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodContrato then begin  // 23.11.07
                if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem then begin  // 30.06.11
                  Numero:=FGeral.GetContador('ROMA'+Global.CodRomaneioRemessaaOrdem+EdUnid_codigo.Text,false,false)+1;
// 28.10.11 - SM - Gris
                end else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodconhecimentoSaida then begin
                  Numero:=FGeral.GetContador('CTRC'+Global.CodConhecimentoSaida+EdUnid_codigo.Text,false,false)+1;
                end else if EdTotalNOta.AsCurrency>0 then // 18.11.09 devido nf servi�os
                  Numero:=FGeral.GetContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,false)+1;

//////////////////////////// - retirado em 07.07.10
{
                if ( FGeral.Getconfig1asinteger('Numeronfs'+EdUnid_codigo.Text)>0 ) and
                   ( EdDtmovimento.asdate<=1 ) and (Op='I') then begin
                  if Numero<FGeral.Getconfig1asinteger('Numeronfs'+EdUnid_codigo.Text) then begin
                    Numero:=FGeral.Getconfig1asinteger('Numeronfs'+EdUnid_codigo.Text);
                    FGeral.AlteraContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),Numero);
                  end;
                end;
                }
////////////////////////////
    // 29.05.06 - senao quando faz uma e depois outro tipo fica dando mensagem...
                FGeral.Checacontador(numero-1,EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,sistema.hoje);
// 06.03.2023  - Devereda
                NumeroSalto := Numero;
                if Global.Topicos[1486] then
                   Numero := FGeral.Checaetraznumfalta(numero,EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,'NFC',EdUnid_codigo.text,Sistema.hoje);

// 17.09.09
////                xpedido:=EdPedido.asinteger
              end else begin

                xpedido:=0;
//                if (not EdPedido.isempty) or (EdPedido.asinteger>0) then
                if xPedido>0 then
                  Numero:=xpedido
                else
                  Numero:=FGeral.GetContador('NFS'+EdUnid_codigo.Text+edComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,false);
              end;
            end;

          end else begin  // caso nro da nota for informado

            Numero:=EdNumerodoc.asinteger;
// 04.05.07 - 07.05.10 - retirado pra nao pular mais de uma vez o numero devido a mudan�a
//                       para nao perder a numeracao quando da erro na gravacao
//            FGeral.AlteraContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),Numero);
// 15.03.10
             xpedido:=0;
          end;

          if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodVendaSerie4 then
            Romaneio:=FGeral.GetContador('ROMANEIO'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false);
// 31.08.05
          if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodVendaAmbulante+';'+Global.CodVendaMagazine)>0 then
            Numero:=EdNumerodoc.asinteger;
          EdNumerodoc.Text:=inttostr(Numero);

        end else begin    // alteracao

          CancelaTransacao(Transacao);
// 18.05.06
          FGeral.Gravalog(7,'numero '+Transacao,true,transacao,usua_codigo,'Altera��o Nota de Saida '+EdNumerodoc.text);
          Numero:=EdNumerodoc.asinteger;
        end;
// 16.09.05
        tipocad:='C';
//        if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemestoque+';'+Global.CodRemessaConserto)>0 then
        if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemestoque+';'+Global.CodRemessaConserto+';'+TiposFornec)>0 then
          tipocad:='F';
///////////////////////
        Transacao:=FGeral.GetTransacao;
///////////////
        if EdTotalNOta.AsCurrency>0 then begin  // 18.11.09 devido nf servi�os

           FGeral.GravaMestreNFSaida(EdDtEmissao.AsDate,EdDtSaida.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
               EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao,EdFpgt_codigo.text,
               EdNatf_codigo.text,EdEmides.text,'',Numero,EdComv_codigo.asinteger,0,
               EdTotalNOta.AsCurrency,EdBaseicms.ascurrency,EdValoricms.ascurrency,EdBasesubs.ascurrency,EdValorsubs.ascurrency,EdFrete.ascurrency,
               0,EdDtmovimento.Asdate,EdTotalprodutos.ascurrency,Edperacre.ascurrency,Edperdesco.ascurrency,Romaneio,valoravista,
               moes_remessas,StatusNota,'',xPedido,Edtran_codigo.text,0,0,moes_clie_codigo,
               EdValoripi.ascurrency,0,'','','',
               0 , TiposFornec,0,EdPeriss.ascurrency,0,
               vlrfunrural,0,0,EdMargemlucro.Ascurrency,
               '','', vlrcotacapital , ''  );

          FGeral.GravaItensNFSaida(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
               EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao,Numero,Grid,EdFRete.ascurrency,EdSEguro.ascurrency,EdPeracre.AsCurrency,
               EdPerdesco.ascurrency,EdDtMovimento.asdate,moes_remessas,StatusNota,xPedido,moes_clie_codigo,
               EdNatf_codigo.text,revenda,EdComv_codigo.asinteger,NotaTipocad,'' );

          valorcomissao:=FGeral.CalculaComissao(EdRepr_codigo,EdFpgt_codigo.text,Grid,nil,EdUnid_codigo.text);
  //        if (EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodVendaSerie4) and
  //           (EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodVendaRomaneio) and
  //           (EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodVendaAmbulante) then
          if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.TiposGeraFinanceiro)>0 then begin
            FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdCliente,tipocad,Edrepr_codigo.asinteger,EdUNid_codigo.text,
                     EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Transacao,EdFpgt_codigo.text,
                     'R',Numero,EdComv_codigo.asinteger,EdTotalnota.ascurrency,Valorcomissao,'N',0,0,GridParcelas,'',EdPort_codigo.text);
            unidadecomissao:=EdUNid_codigo.text;
//            if trim(FGeral.GetConfig1AsString('UNIDADECOMISSAO'))<>'' then
//            unidadecomissao:=FGeral.GetConfig1AsString('UNIDADECOMISSAO');
// 06.10.10 - Adriano - Abra - unidade de onde foi gerado contrato
            xCondicao:=FGeral.GetConfig1AsString('FpgtoComissao');
//            valorcomissao:=EdTotalNota.ascurrency*(EdPerComissao.ascurrency/100);
            valorcomissao:=0;
//            if ( Global.Topicos[1325] ) and (EdPerComissao.ascurrency>0)  and (trim(xcondicao)<>'' ) then
// 20.08.10 - comissao paga gerar igual o parcelamento do contrato
{
            if ( Global.Topicos[1325] ) and (EdPerComissao.ascurrency>0)  then
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdRepr_codigo,'R',Edrepr_codigo.asinteger,unidadecomissao,
                     Global.CodPendenciaFinanceira,Transacao,EdFpgt_codigo.text,
                     'P',Numero,EdComv_codigo.asinteger,ValorComissao,0,'N',0,FGeral.GetConfig1AsInteger('Contacomissao'),nil,'',EdPort_codigo.text)
// 06.10.10 - comissao paga gerar igual o parcelamento do contrato
            else if ( Global.Topicos[1345] ) and (EdPerComissao.ascurrency>0)  then
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdRepr_codigo,'R',Edrepr_codigo.asinteger,unidadecomissao,
                     Global.CodPendenciaFinanceira,Transacao,EdFpgt_codigo.text,
                     'P',Numero,EdComv_codigo.asinteger,ValorComissao,0,'H',0,FGeral.GetConfig1AsInteger('Contacomissao'),nil,'',EdPort_codigo.text);

            valorcomissao:=EdTotalNota.ascurrency*(EdPerComissao2.ascurrency/100);
            if ( Global.Topicos[1344] ) and (EdPerComissao2.ascurrency>0)  and (trim(xcondicao)<>'' ) then
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdRepr_codigo2,'R',Edrepr_codigo2.asinteger,unidadecomissao,
                     Global.CodPendenciaFinanceira,Transacao,xCondicao,
                     'P',Numero,EdComv_codigo.asinteger,ValorComissao,0,'N',0,FGeral.GetConfig1AsInteger('Contareserva'),nil,'',EdPort_codigo.text);
             }
          end;

        end;  // ref. total da nota >0

        try
          Sistema.EndTransaction('');
// 20.09.12 tirado do Geral.pas e colocado aqui apos ter comitado a transa��o
// Benatto e 'antigo Novicarnes'
// 28.02.08
          if ( pos( EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,global.CodVendaDireta )>0 ) and ( Global.Topicos[1311] )  then
             BaixaMateriaPrima;

// 14.09.09 ////////////////////////////// - Nota de Servicos 'automatica'
//////////////////////////////////////////////
          FazNotadeServicos:=false;
          if FazNotadeServicos then begin
            Sistema.BeginTransaction('Fazendo nota de presta��o de servi�os');
            Transacao:=FGeral.GetTransacao;
            QConf:=sqltoquery('select * from confmov where comv_codigo='+inttostr(ConfMovServicos));
            if copy(EdNatf_codigo.text,1,1)='5' then
              Natf_codigo:=QConf.fieldbyname('comv_natf_estado').asstring
            else
              Natf_codigo:=QConf.fieldbyname('comv_natf_foestado').asstring;

  //          Numerodoc:=FGeral.GetContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false);
  // 12.04.10 - cenitech
            if EdDtmovimento.AsDate>1 then begin
              if Global.Topicos[1332] then
//                NUmerodoc:= FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,false )+2
// 07.09.10  - rolos Abra - pra pegar a serie da config. de movimento de servicos
                NUmerodoc:= FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(QConf.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,false )+1
              else
                NUmerodoc:= FGeral.GetContador('NFSAIDAMO'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,false)+1;
            end;

            TotalServicos:=GetTotalServicos;
            Aliqiss:=GetPeriss;
  {
            FGeral.GravaMestreNFSaida(EdDtEmissao.AsDate,EdDtSaida.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
                 Global.CodPrestacaoServicos,Transacao,EdFpgt_codigo.text,
                 Natf_codigo,EdEmides.text,EdEspecievolumes.text,Numerodoc,QConf.fieldbyname('Comv_codigo').asinteger,EdQtdevolumes.asinteger,
                 TotalServicos,0,0,0,0,0,
                 0,EdDtmovimento.Asdate,0,0,0,Romaneio,0,
                 moes_remessas,StatusNota,EdMensagem.text,xPedido,Edtran_codigo.text,EdPesoliq.ascurrency,EdPesobru.ascurrency,moes_clie_codigo,
                 0,0,EdPortoorigem.text,EdPortodestino.text,EdContainer.text,
                 EdRepr_codigo2.AsInteger , TiposFornec );
            FGeral.GravaMestreNFSaidaMO(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
                 Global.CodPrestacaoServicos,Transacao,EdFpgt_codigo.text,
                 Natf_codigo,EdEmides.text,EdEspecievolumes.text,Numerodoc,QConf.fieldbyname('Comv_codigo').asinteger,EdQtdevolumes.asinteger,
                 TotalServicos,0,0,TotalServicos,(TotalServicos*(Aliqiss/100)),0,
                 EdMoes_Tabp_codigo.AsInteger,EdDtmovimento.Asdate,0,0,0,Romaneio,0,
                 moes_remessas,StatusNota,EdMensagem.text,xPedido,Edtran_codigo.text,EdPesoliq.ascurrency,EdPesobru.ascurrency,moes_clie_codigo,
                 0,EdFreteuni.ascurrency,EdPortoorigem.text,EdPortodestino.text,EdContainer.text,
                 EdRepr_codigo2.AsInteger , TiposFornec,Aliqiss,0,0,0 );


            FGeral.GravaItensNFSaidaSer(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
                 Global.CodPrestacaoServicos,Transacao,NumeroDoc,ListaServicos,0,0,0,
                 0,EdDtMovimento.asdate,moes_remessas,StatusNota,xPedido,moes_clie_codigo,
                 Natf_codigo,revenda,QConf.fieldbyname('Comv_codigo').asinteger,NotaTipocad );

            if pos(Global.CodPrestacaoServicos,Global.TiposGeraFinanceiro)>0 then begin
              FGeral.GravaPendencia(EdDtemissao.asdate,EdDtmovimento.asdate,EdCliente,tipocad,Edrepr_codigo.asinteger,EdUNid_codigo.text,
                     Global.CodPrestacaoServicos,Transacao,EdFpgt_codigo.text,
                     'R',NumeroDoc,QConf.fieldbyname('Comv_codigo').asinteger,TotalServicos,0,'N',0,0,nil,'',EdPort_codigo.text);
            end;
            if EdDtmovimento.asdate>1 then
              FGeral.GravaMovbase(Transacao,Numerodoc,'000','S',TotalServicos,round(TotalServicos*(AliqIss/100)),AliqIss,0,0,0,Global.CodPrestacaoServicos);
  }

            Sistema.EndTransaction('');
          end;  // se faz nf de servicos ( mao de obra )
////////////////////////////////////
// 04.05.10 - tentativa de nao pular o contador quando da erro na nota de saida
          if (OP='I') or (OP='G') then begin
            if FazNotadeServicos then begin
// atualiza contador da nf de material e de servicos
              if Global.Topicos[1332] then begin
                NUmerodoc:= FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true );
// 26.05.10 - para pular mais uma vez o contador de nota pois gera 2 notas seguidas
//                NUmerodoc:= FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true )
// 05.10.10 - revisado - mais uma 'abrisse', isto � , coisas da abra...mesma unidade mas
//series diferentes ..
                NUmerodoc:= FGeral.GetContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(QConf.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true )
              end else
                NUmerodoc:= FGeral.GetContador('NFSAIDAMO'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true);

            end else begin

// 30.07.10 - Abra - nf contrato pulava numero igual...
// 09.08.12   Venda Ambulante - VA tbem.. VM - venda magazine tbem
               if pos( EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodContrato+';'+Global.CodVendaAmbulante+';'+Global.CodVendaMagazine)=0 then begin
                 if EdDtmovimento.isempty then
                   Numero:=FGeral.GetContador('SAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true)
                 else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem then // 30.06.11
                   Numero:=FGeral.GetContador('ROMA'+Global.CodRomaneioRemessaaOrdem+EdUnid_codigo.Text,false,true)
                 else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodConhecimentoSaida then // 28.10.11
                   Numero:=FGeral.GetContador('CTRC'+Global.CodConhecimentoSaida+EdUnid_codigo.Text,false,true)
                 else if Ecf='S' then  // 12.07.11
                   Numero:=FGeral.GetContador('NFSAIDAECF'+EdUnid_codigo.Text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false,True)
// 09.03.2023  - Devereda - caso achar algum numero 'pulado' n�o incrementa a numeracao atual
//               caso contrario incrementa normal...
                 else  if Global.Topicos[1486] then begin

                   if Numero = Numerosalto then
                      Numero:=FGeral.GetContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true);

                 end else

                   Numero:=FGeral.GetContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true);

               end;
            end;
            if ( Global.Topicos[1301] ) and ( not EdDtmovimento.IsEmpty) then begin
              if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodRomaneioRemessaaOrdem then // 30.06.11
                FGeral.AlteraContador('ROMA'+Global.CodRomaneioRemessaaOrdem+EdUnid_codigo.Text,EdNumerodoc.AsInteger)
              else if EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodConhecimentoSaida then // 28.10.11
                FGeral.AlteraContador('CTRC'+Global.CodConhecimentoSaida+EdUnid_codigo.Text,EdNumerodoc.AsInteger)
              else
                FGeral.AlteraContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),EdNumerodoc.AsInteger);
            end;
          end;
////////////////////

        except  // 09.08.06
          FGeral.Gravalog(99,'Problemas na grava��o do documento'+inttostr(numero),true,transacao);
// 09.10.08 - caso der pau retorna 1 no contador de nota
//          if (EdDtmovimento.asdate>1) and (OP='I') and not Global.Topicos[1301] then
//            FGeral.AlteraContador('NFSAIDA'+EdUnid_codigo.Text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),Numero-1);
// retiado em 07.05.10  pois 'nunca passava aqui'
        end;

        Sistema.EndProcess('');
        xPedeImpressao:=PedeImpressao;
        unidade:=EdUNid_codigo.text;
        xnumero:=EdNumerodoc.asinteger;
        DataSaidaAux:=EdDtSaida.asdate;
        DataEmissaoAux:=EdDtEmissao.asdate;
        if ( EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring<>Global.CodRomaneioRemessaaOrdem ) then begin

          if not Global.Usuario.OutrosAcessos[0340] then begin

            EdDtSaida.SetDate(Sistema.hoje);
            EdDtEmissao.SetDate(Sistema.hoje);

          end;

        end else begin

            EdDtSaida.SetDate(DataSaidaAux);
            EdDtEmissao.SetDate(DataEmissaoAux);

        end;
///////////////////////////        EdDtMovimento.clear;
        EdQtdetotal.setvalue(0);
        EdFrete.SetValue(0);

        EdUnid_codigo.Text:=Global.CodigoUnidade;
        EdProduto.clearall(FVendabalcao,99);
//        EdTotalServicos.clear;
// 15.06.05
//        if Global.Topicos[1201] then
//          Arq.TEstoqueqtde.commit;

        Grid.Clear;
        GridParcelas.clear;
        EdBaseicms.ClearAll(FVendabalcao,99);
// 18.01.20 - Mirvane
        EdCpf.Clear;

        portador:=EdPort_codigo.text;
//        EdPort_codigo.ClearAll(FVendabalcao,99);
/////////////////        ListaServicos.Clear;  // 14.09.09
        if ( Ecf<>'S' )  then begin
          if ( xPedeImpressao ) then begin
            if confirma('Imprime nota agora ?') then
//            FImpressao.ImprimeNotaSaida(Numero,EdDtEmissao.AsDate,Unidade,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring);
// 04.03.11 - a variavel numero j� est� 'um acima' pois j� gravou a numeracao da nota de saida
//            dai nao acha o 'pedido' pra imprimir] logo apos incluir...
//              FImpressao.ImprimeNotaSaida(Numero-1,EdDtEmissao.AsDate,Unidade,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring);
// 11.04.11 - cfe o numero da nota esta aberto para emissao num d� certo isto..
// 05.02.15 - coorlaf santamaria
              numvias:=0;
              if not Global.topicos[1381] then begin
                numvias:=FCondpagto.GetNumeroParcelas(EdFpgt_codigo.text);
                FGeral.Getvalor(numvias,'Vias:');
              end;
              if numvias>=1 then begin
                for p:=1 to trunc(numvias) do
                  FImpressao.ImprimeNotaSaida(xNumero,EdDtEmissao.AsDate,Unidade,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring);
              end else
                  FImpressao.ImprimeNotaSaida(xNumero,EdDtEmissao.AsDate,Unidade,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring);

          end else if ( ( (Global.Topicos[1020]) and ( Global.UsaNfe='S' ) )
                   or     // 28.08.15 - vivan
                      ( (Global.Topicos[1384]) and ( Global.UsaNfe='S' ) ) )
                   and   // 20.01.16 - para evitar tentar autorizar notas se movimento
                      ( not EdDtMovimento.isempty )
                   then begin  // 11.05.11

 //               if Global.Usuario.Codigo=100 then
 //
 //                  if AutorizaNFe( xNumero) then ImprimeNfe
 //
 //               else begin


                    if EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCe') then begin

                       FExpNfetxt.Execute( xNumero,'NFCe' );

                    end else
                       FExpNfetxt.Execute( xNumero );

                    EdProduto.setfocus;

// 22.08.19 - em expnfetxt tem o mesmo 1388 q ja chama a impressao
                    {
                    if Global.topicos[1388] then begin
                      FGerenciaNfe.Execute(inttostr(xnumero));
                  // 05.11.15
                      if EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCe') then
                        FGerenciaNfe.bimpnfceClick(self)
                      else
                        FGerenciaNfe.bimpdanfeClick(self);
                      FGerenciaNfe.Close;
                    end;
                      }
// 24.03.16 - benato
///                EdValorrecebido.Enabled:=false;
///  22.08.18 - retirado

 //                end;


// 10.08.11
          end else if (OP='G') and ( Global.UsaNfe='S' ) then begin
// 13.08.12
            if pos(EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring,Global.CodVendaMagazine)=0 then
              FExpNfetxt.Execute( xNumero );
// 07.03.15                                       // 01.12.15 - devereda
          end else if (global.topicos[1381]) and  (EdDtmovimento.isempty)  then

// 16.11.20 - Devereda - Linda pediu para n�o imprimir automatico para n�o gastar bobina a toa
              if (global.topicos[1476]) then

                 FImpressao.ImprimeNotaSaida(xNumero,EdDtEmissao.AsDate,Unidade,EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring);

        end else begin  // ECF<>'S'
// 17.01.12 - benatto
          if Global.Usuario.OutrosAcessos[0329] then begin
            FGerenciaECF.Execute(Transacao,EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,EdValorTroco.ascurrency);
            FGerenciaECF.bimpcupomClick(self);
            FGerenciaECF.imprimecupom(EdValorTroco.ascurrency);
            FGerenciaECF.close;
          end;
          EdValorrecebido.Enabled:=false;
        end;
        EdPort_codigo.ClearAll(FVendabalcao,99);
        EdFpgt_codigo.Enabled:=false;
        EdComv_codigo.Next;
        EdCliente.Next;
// 08.10.2021  - Devereda - Linda
        if EdComv_codigo.asinteger=FGeral.GetConfig1AsInteger('ConfMovNFCe') then

           EdCpf.clear;

        EdProduto.SetFocus;

   end;

// 23.05.11 - Novi - Isonel - retorna usuario para nao poder fazer faturamento abaixo
//            do minimo por cidade
////   FUsuarios.GravaOutrosAcessos(326,Global.Usuario.Codigo,'N');
///  13.12.18 - retirado daqui pois � consumidor a nota
// 15.04.16
   if Global.topicos[1384] then begin
      EdNUmerodoc.setvalue( FGeral.ConsultaContador('NFSAIDA'+EdUnid_codigo.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade))+1 );
      bIncluiritemClick(self);
//      EdProduto.setfocus;
   end else if Op='I' then
     EdComv_codigo.setfocus
   else if OP='G' then begin  // 08.08.11
     bsairclick(self);
   end else
// 12.04.10 - Mama
//      FVendabalcao.Execute('A');
// 09.05.11 - retirado pois assim nao daria pra alterar os vencimentos..
// ver se precisa criar parametro do sistema...
     EdNumerodoc.setfocus;

//////////////////////////////////////////////////////////////////
end;

procedure TFVendaBalcao.CancelaTransacao(Transacao: string);
////////////////////////////////////////////////////////////////////////////
var QMovestoque,QQtdeEstoque:TSqlquery;
    Mov:string;
begin
    Sistema.Beginprocess('Cancelando transa��o '+transacao);
    QMovestoque:=sqltoquery(FGeral.BuscaTransacao(Transacao,'movestoque','move_transacao'));
    if QMovestoque.fieldbyname('move_status').asstring='C' then begin
      Avisoerro('Transa��o j� est� cancelada');
      Sistema.Endprocess('');
      exit;
    end;
    if pos(QMOvestoque.fieldbyname('move_tipomov').asstring,Global.TiposMovMovEstoque) > 0 then begin
      while not QMovestoque.eof do begin
        QQtdeEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
        ' and esqt_unid_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring));
        if pos(QMOvestoque.fieldbyname('move_tipomov').asstring,Global.TiposMovMovEntrada) > 0 then
          Mov:='S'
        else
          Mov:='E';
        FGeral.MovimentaQtdeEstoque(QMOvestoque.fieldbyname('move_esto_codigo').asstring,
              QMOvestoque.fieldbyname('move_unid_codigo').asstring,Mov,'CC',
              QMOvestoque.fieldbyname('move_qtde').asfloat,QQtdeEstoque );
        QQtdeEstoque.close;
        Freeandnil(QQtdeEstoque);
        QMovestoque.Next;
      end;
    end;
    Executesql('update movesto set moes_status=''C'' where moes_transacao='+stringtosql(Transacao));
    Executesql('update movestoque set move_status=''C'' where move_transacao='+stringtosql(Transacao));
    Executesql('update movbase set movb_status=''C'' where movb_transacao='+stringtosql(Transacao));
    Executesql('update pendencias set pend_status=''C'' where pend_transacao='+stringtosql(Transacao));
    Executesql('update movfin set movf_status=''C'' where movf_transacao='+stringtosql(Transacao));
    Sistema.Commit;
    QMovestoque.close;
    Freeandnil(QMovestoque);
    Sistema.Endprocess('');

end;

procedure TFVendaBalcao.EdFpgt_codigoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
var nparcelas,n:integer;
    ListaPrazo:TStringlist;
    p:integer;
    valorparcela,valortotal,valoravista:currency;
    venci:TDatetime;
begin
  if not EdFpgt_codigo.validfind then exit;
// 10.11.05
  if (FCondPagto.GetAvPz(EdFpgt_codigo.text)='V') or (Fcondpagto.Getprimeiroprazo(EdFpgt_codigo.text)=0) then begin
    if EdUnid_codigo.Resultfind.fieldbyname('Unid_contacontabil').AsInteger=0 then begin
      EdFpgt_codigo.INvalid('Unidade sem conta caixa cadastrada para lan�amentos a vista');
      exit;
    end;
  end;
// 27.09.07
  if FGeral.GetGeraFinanceiro(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)<>'S' then begin
    GridParcelas.clear;
    exit;
  end;
  if (op='I') or (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue) then
    GridParcelas.Clear;
//  if ( (FCondPagto.GetAvPz(EdFpgt_codigo.text)='P') and (OP='I') ) or (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue ) then begin
// 15.09.2022
// sempre passar aqui sendo a vista ou a prazo
    ListaPrazo:=TStringlist.create;
    n:=FCondPagto.GetPrazos(EdFpgt_codigo.text,ListaPrazo);
    valoravista:=FGeral.GetValorAvista(Listaprazo);
    nparcelas:=FCondPagto.GetNumeroParcelas(EdFpgt_codigo.text);
// 11.03.10
    if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.CodDevolucaoCompraProdutor )>0 then
      valortotal:=EdTotalNota.AsCurrency-vlrfunrural-vlrcotacapital
    else
/////////////////////////////////////////////////////////////////
// 11.03.05 - reges pegou bug quando tem parte a vista e mais de duas parcelas
      valortotal:=EdTotalNota.AsCurrency- valoravista;
    acumulado:=0;
    for p:=1 to nparcelas do begin
      venci:=FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1])) ;
// 24.05.12
     if FCondPagto.GetAvPz(EdFpgt_codigo.text)='P' then
// 24.09.08
        venci:=FGeral.GetVencimentoPadrao(venci);
//      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',venci)  ;
// 04.01.2021
      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yyyy',venci)  ;
      if (p=nparcelas) and (valoravista=0) then
        valorparcela:=valortotal-acumulado  // para deixar na ultima parcelas "as d�zimas"
      else begin
        if (valoravista>0) then begin
          valorparcela:=FGeral.Arredonda(valortotal/(nparcelas-1),2);
          if (p=nparcelas) then
            valorparcela:=valortotal+valoravista-acumulado  // para deixar na ultima parcelas "as d�zimas" - 01.06.05
        end else
          valorparcela:=FGeral.Arredonda((valortotal)/nparcelas,2);
      end;
      if (valoravista>0) and (p=1) then begin
        GridParcelas.cells[1,p]:=Transform(valoravista,f_cr);
        acumulado:=acumulado+valoravista;
      end else begin
        GridParcelas.cells[1,p]:=Transform(valorparcela,f_cr);
        acumulado:=acumulado+valorparcela;
      end;
// 01.09.2022
      GridParcelas.cells[GridParcelas.GetColumn('portador'),p]:=EdPort_codigo.Text;
      GridParcelas.RowCount:=GridParcelas.RowCount+1;
    end;  // for do numero de parcelas

//////////////////////////////////////////////////////////////
{
    acumulado:=0;
//    valortotal:=EdTotalNota.AsCurrency-valoravista;
// 21.01.05
    valortotal:=EdTotalNota.AsCurrency;
    for p:=1 to nparcelas do begin
//      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1])) );
      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  );
//      Sistema.SetField('Pend_Parcela',p);
//      Sistema.SetField('Pend_NParcelas',nparcelas);
      if p=nparcelas then
        valorparcela:=EdTotalnota.ascurrency-acumulado  // para deixar na ultima parcelas "as d�zimas"
      else begin
        if valoravista>0 then
          valorparcela:=FGeral.Arredonda(valortotal/(nparcelas-1),2)
        else
          valorparcela:=FGeral.Arredonda(valortotal/nparcelas,2);
      end;
//      GridParcelas.cells[1,p]:=strspace(Transform(valorparcela,f_cr),10);
//      GridParcelas.cells[1,p]:=Transform(valorparcela,f_cr);
      if (valoravista>0) and (p=1) then begin
        GridParcelas.cells[1,p]:=Transform(valoravista,f_cr);
        acumulado:=acumulado+valoravista;
      end else begin
        GridParcelas.cells[1,p]:=Transform(valorparcela,f_cr);
        acumulado:=acumulado+valorparcela;
      end;
      GridParcelas.RowCount:=GridParcelas.RowCount+1;
    end;  // for do numero de parcelas
}
////////////////////////////////////////////////////////////////////
    Freeandnil(ListaPrazo);
//  end; // 15.09.2022 - sempre passar a vista ou a prazo


// 26.03.13
  if EdValorRecebido.ascurrency>Edtotalnota.ascurrency then
    EdValortroco.setvalue( EdValorRecebido.ascurrency-Edtotalnota.ascurrency )
  else
    EdValortroco.setvalue(0);

// 23.05.12 - criar parametro do sistema
  if (FCondPagto.GetAvPz(EdFpgt_codigo.text)='P') and (OP='I') and (Global.Topicos[1355]) then
     AtivaEditsParcelas(0);

end;

procedure TFVendaBalcao.EdFreteValidate(Sender: TObject);
////////////////////////////////////////////////////////////
begin

    SetaEditsvalores;

end;

procedure TFVendaBalcao.EdFpgt_codigoExitEdit(Sender: TObject);
begin

  if (not Global.Topicos[1355]) or ( (FCondPagto.GetAvPz(EdFpgt_codigo.text)='V') )  then

     bgravarclick(FVendaBalcao);

end;

procedure TFVendaBalcao.EdFpgt_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.LImpaEdit(Edfpgt_codigo,key);

end;

procedure TFVendaBalcao.AtivaEditsParcelas(n: integer);
///////////////////////////////////////////////////////////////////////
begin

  if GridParcelas.Col=0 then begin
     EdVencimento.Top:=GridParcelas.TopEdit+n;
     EdVencimento.Left:=GridParcelas.LeftEdit+5;
     EdVencimento.Text:=StrToStrNumeros(GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]);
//     EdVencimento.Text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
     EdVencimento.Visible:=True;
     EdVencimento.SetFocus;

  end else if GridParcelas.Col=1 then begin

     EdParcela.Top:=GridParcelas.TopEdit;
     EdParcela.Left:=GridParcelas.LeftEdit+6;
     EdParcela.SetValue(TextToValor(GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]));
     EdParcela.Visible:=True;
     EdParcela.SetFocus;

  end;
end;

function TFVendaBalcao.AutorizaNFe(ynumero:integer): boolean;
//////////////////////////////////////////////////////////////
begin
    FExpNfetxt.Execute( ynumero, 'NFCe' );
    result:=true;
end;

procedure TFVendaBalcao.GridParcelasDblClick(Sender: TObject);
begin
  AtivaEditsParcelas;

end;

procedure TFVendaBalcao.GridParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    GridParcelasDblClick(FVendaBalcao);

end;

procedure TFVendaBalcao.ImprimeNfe;
////////////////////////////////////////
begin
    showmessage(' impprime nfe' );
end;

procedure TFVendaBalcao.EdVencimentoExitEdit(Sender: TObject);
begin

//  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=DateToStr_(EdVencimento.AsDate);
// 04.01.2021
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=FormatDateTime('dd/mm/yyyy',EdVencimento.AsDate);
  GridParcelas.SetFocus;
  EdVencimento.Visible:=False;

end;

procedure TFVendaBalcao.EdVencimentoValidate(Sender: TObject);
begin
   if FCondpagto.GetAvPz(EdFpgt_codigo.text)='V' then begin
     if EdVencimento.AsDate>0 then begin
       if Edvencimento.asdate<Sistema.hoje then
          EdVencimento.invalid('Nota a vista somente com data atual');
     end;
   end;
// 01.10.2010 - novi - vava
   if (EdVencimento.asdate<EdDtEmissao.AsDate) and (not EdVencimento.isempty) then
      EdVencimento.invalid('Vencimento anterior a data de emiss�o');

end;

procedure TFVendaBalcao.EdParcelaExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=Transform(EdParcela.AsFloat,f_cr);
  GridParcelas.SetFocus;
  EdParcela.Visible:=False;


end;

procedure TFVendaBalcao.EdperdescoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
begin

  if Edperdesco.ascurrency>0 then begin

    EdVlrdesco.enabled:=false;
    EdVlrdesco.setvalue(0);
    EdVlracre.enabled:=false;
    EdVlracre.setvalue(0);
    EdTotalNota.setvalue( Edtotalprodutos.Ascurrency - FGeral.Arredonda(EdTotalprodutos.Ascurrency*(EdPerdesco.ascurrency/100),2) );
    EdValorRecebido.setvalue( Edtotalprodutos.Ascurrency - FGeral.Arredonda(EdTotalprodutos.Ascurrency*(EdPerdesco.ascurrency/100),2) );

  end else begin

    EdVlrdesco.enabled:=true;
    EdTotalNota.setvalue( Edtotalprodutos.Ascurrency );

  end;

end;

procedure TFVendaBalcao.EdValorRecebidoValidate(Sender: TObject);
begin
//   EdFpgt_codigo.enabled:=false;
   EdProduto.Enabled:=false;
   if Global.Topicos[1481] then begin

     EdFpgt_codigo.setfocus;

   end else if not EdFpgt_codigo.IsEmpty then
     EdFpgt_codigo.Next
   else
     EdFpgt_codigo.setfocus;
//   EdFpgt_codigo.ValidateEdit;

end;

procedure TFVendaBalcao.ACBrBAL1LePeso(Peso: Double; Resposta: String);
var valid : integer;
begin
    EdQtde.setvalue(peso);
{
   sttPeso.Caption     := formatFloat('##0.000', Peso );
   sttResposta.Caption := Converte( Resposta ) ;

   if Peso > 0 then
      Memo1.Lines.Text := 'Leitura OK !'
   else
    begin
      valid := Trunc(ACBrBAL1.UltimoPesoLido);
      case valid of
         0 : Memo1.Lines.Text := 'TimeOut !'+sLineBreak+
                                 'Coloque o produto sobre a Balan�a!' ;
        -1 : Memo1.Lines.Text := 'Peso Instavel ! ' +sLineBreak+
                                 'Tente Nova Leitura' ;
        -2 : Memo1.Lines.Text := 'Peso Negativo !' ;
       -10 : Memo1.Lines.Text := 'Sobrepeso !' ;
      end;
    end ;
}
end;

// 10.04.14
procedure TFVendaBalcao.LimitaMouse(Form: TForm);
///////////////////////////////////////////////////
var  R: TRect;
begin
  { Pega o ret�ngulo da �rea cliente do form }
  R := GetClientRect;
  { Converte as coordenadas do form em coordenadas da tela }
  R.TopLeft := ClientToScreen(R.TopLeft);
  R.BottomRight := ClientToScreen(R.BottomRight);
  { Limita a regi�o de movimenta��o do mouse }
  ClipCursor(@R);
//  ShowMessage('Tente mover o mouse para fora da �rea cliente do Form');
  { Libera a movimenta��o }
//  ClipCursor(nil);end;
end;


// 10.04.14
procedure TFVendaBalcao.LiberaMouse(Form: TForm);
////////////////////////////////////////////////////
var  R: TRect;
begin
  { Pega o ret�ngulo da �rea cliente do form }
  R := GetClientRect;
  { Converte as coordenadas do form em coordenadas da tela }
  R.TopLeft := ClientToScreen(R.TopLeft);
  R.BottomRight := ClientToScreen(R.BottomRight);
  { Limita a regi�o de movimenta��o do mouse }
//  ClipCursor(@R);
//  ShowMessage('Tente mover o mouse para fora da �rea cliente do Form');
  { Libera a movimenta��o }
  ClipCursor(nil);
end;

procedure TFVendaBalcao.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
////////////////////////////////////////////////////////////////////////////////////////
begin
// 07.07.15
////  LiberaMouse( FVendaBalcao );
   timer.Enabled:=false;
   if (EdProduto.Enabled)  then bCancelaritemClick(self);

end;

procedure TFVendaBalcao.EdVlrdescoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
var perdesc:extended;
begin
  if EdVlrdesco.ascurrency>0 then begin
    EdVlracre.enabled:=false;
    EdVlracre.setvalue(0);
    if Edtotalnota.ascurrency>0 then
      perdesc:=(EdVlrdesco.ascurrency/Edtotalprodutos.ascurrency)*100
    else begin
      perdesc:=0;
    end;
    EdPerdesco.setvalue(perdesc);
    SetaEditsvalores;
    if (EdVlrdesco.ascurrency>0) and (EdPerdesco.AsCurrency=0) then  begin
      EdTotalnota.setvalue( Edtotalprodutos.Ascurrency - EdVlrdesco.ascurrency );
      EdValorRecebido.setvalue(EdTotalnota.AsCurrency);
    end;
  end else begin
    EdTotalNota.setvalue( Edtotalprodutos.Ascurrency+EdFrete.AsCurrency );
  end;
end;

procedure TFVendaBalcao.bf11Click(Sender: TObject);
begin
   bf11.Tag:=(-1)*bf11.Tag;
end;

procedure TFVendaBalcao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = vk_f11 then bf11Click(self);

end;

procedure TFVendaBalcao.EdProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = vk_f11 then bf11Click(self);

end;

procedure TFVendaBalcao.EdPeracreValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////
begin
  if EdPeracre.ascurrency>0 then begin
    EdPerdesco.enabled:=false;
    EdVlrDesco.enabled:=false;
    EdPerdesco.setvalue(0);
    EdVlracre.enabled:=false;
    EdVlracre.setvalue(0);
    EdTotalNota.setvalue( Edtotalprodutos.Ascurrency + FGeral.Arredonda(Edtotalprodutos.Ascurrency*(EdPeracre.ascurrency/100),2) );
  end else begin
    EdPerdesco.enabled:=true;
    EdVlrDesco.enabled:=true;
    EdVlracre.enabled:=true;
  end;
  SetaEditsValores;
end;

procedure TFVendaBalcao.EdVlracreValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var valor:currency;
    peracre:extended;
begin
  if EdVlracre.ascurrency>0 then begin
    EdVlrdesco.enabled:=false;
    EdVlrdesco.setvalue(0);
    valor:=Edtotalnota.ascurrency;
    if valor>0 then
      peracre:=(EdVlracre.ascurrency/valor)*100
    else begin
      peracre:=0;
    end;
    EdPeracre.setvalue(peracre);
    SetaEditsvalores;
    if (EdVlracre.ascurrency>0) and (EdPeracre.AsCurrency=0) then  begin
      EdTotalnota.setvalue( Edtotalprodutos.Ascurrency + EdVlracre.ascurrency );
      EdValorRecebido.setvalue(EdTotalnota.AsCurrency);
    end;
  end else begin
    EdVlrdesco.enabled:=true;
    EdTotalNota.setvalue( Edtotalprodutos.Ascurrency );
  end;
end;

// 04.08.14
procedure TFVendaBalcao.EdCodtamanhoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var unitariograde:currency;
begin
  if (EdCodcor.asinteger>0) and (EdCodtamanho.asinteger>0) then begin
    unitariograde:=( FEstoque.GetPrecoGrade(EdProduto.text,Global.CodigoUnidade,Edcodtamanho.asinteger,Edcodcor.asinteger ) );
    EdUnitario.setvalue(unitariograde);
  end;
end;

// 20.03.15
procedure TFVendaBalcao.bimpressaoClick(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
  FRelFinan_ImpNfsaida;
end;

procedure TFVendaBalcao.EdDtemissaoExitEdit(Sender: TObject);
begin
  bIncluiritemClick(self);
end;

procedure TFVendaBalcao.EdDtemissaoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
  if not FGeral.ValidaMvto(EdDtemissao) then
    EdDtemissao.Invalid('')
end;

procedure TFVendaBalcao.EdQtdeValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////
begin
// 01.06.15
    if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsFloat,EdUNid_codigo.Text,QEstoque,Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring) then
       EdQTde.INvalid('Quantidade em estoque insuficiente');

end;

procedure TFVendaBalcao.EdCpfValidate(Sender: TObject);
///////////////////////////////////////////////////////////
begin
   if not Edcpf.isempty then begin
     FGeral.ValidaCNPJCPF(EdCpf);
   end;
end;

procedure TFVendaBalcao.EdCpfExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////
begin
   bincluiritemclick(self);

end;

// 03.11.15
procedure TFVendaBalcao.EdDtMovimentoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin
// 03.11.15
  if ( EdDtmovimento.isempty ) then begin
     EdCpf.enabled:=false;
     bIncluiritemClick(self);
//  end else bIncluiritemClick(self);   // 28.08.17
  end else begin   // 01.09.17
     EdCpf.enabled:=true;
     Edcpf.SetFocus;
  end;

end;

// 13.05.16
procedure TFVendaBalcao.bvalidadeClick(Sender: TObject);
////////////////////////////////////////////////////////
begin
  if not Sistema.Processando then FValidadeVencendo.Execute;

end;

end.
