unit nftransf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr;

type
  TFNotaTransf = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bIncluiritem: TSQLBtn;
    bExcluiritem: TSQLBtn;
    bCancelaritem: TSQLBtn;
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
    PRemessa: TSQLPanelGrid;
    Edunid_origem: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdDtemissao: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdNatf_codigo: TSQLEd;
    EdNatf_descricao: TSQLEd;
    EdComv_codigo: TSQLEd;
    EdComv_descricao: TSQLEd;
    EdDtSaida: TSQLEd;
    EdFrete: TSQLEd;
    EdSeguro: TSQLEd;
    EdEmides: TSQLEd;
    EdTran_codigo: TSQLEd;
    EdTran_nome: TSQLEd;
    EdQtdevolumes: TSQLEd;
    EdEspecievolumes: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    EdUnitario: TSQLEd;
    EdUnid_destino: TSQLEd;
    SQLEd2: TSQLEd;
    EdUnitarioger: TSQLEd;
    EdDtMovimento: TSQLEd;
    Edtotalpecas: TSQLEd;
    Edmens_codigo: TSQLEd;
    EdMensagem: TSQLEd;
    EdPedidos: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    EdPesoliq: TSQLEd;
    EdPesobru: TSQLEd;
    bgeranfe: TSQLBtn;
    EdRomaneio: TSQLEd;
    EdFornec: TSQLEd;
    SetEdFORN_NOME: TSQLEd;
    Edpertransf: TSQLEd;
    bnfcompra: TSQLBtn;
    procedure EdComv_codigoValidate(Sender: TObject);
    procedure EdUnid_destinoValidate(Sender: TObject);
    procedure EdNatf_codigoValidate(Sender: TObject);
    procedure EdDtSaidaValidate(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdQtdeValidate(Sender: TObject);
    procedure EdQtdeExitEdit(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure bIncluiritemClick(Sender: TObject);
    procedure bExcluiritemClick(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bGravarClick(Sender: TObject);
    procedure EdUnid_destinoKeyPress(Sender: TObject; var Key: Char);
    procedure Edunid_origemKeyPress(Sender: TObject; var Key: Char);
    procedure EdDtMovimentoValidate(Sender: TObject);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdTran_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure Edmens_codigoValidate(Sender: TObject);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure EdPedidosValidate(Sender: TObject);
    procedure Edunid_origemValidate(Sender: TObject);
    procedure EdProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bgeranfeClick(Sender: TObject);
    procedure EdFornecValidate(Sender: TObject);
    procedure EdRomaneioValidate(Sender: TObject);
    procedure bnfcompraClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimpaEditsItens;
  public
    { Public declarations }
    procedure EditstoGrid;
    procedure ReservaEstoque(Codigo,IncExc:string;Qtde:currency);
    procedure SetaEditsValores;
    procedure RetornaReserva;
    procedure Execute(Acao:string);
    function BuscaItem(produto:string):integer;
    procedure Campostoedits(Q:TSqlquery);
    procedure Campostogrid(Q:TSqlquery);
// 21.10.20
    procedure GetListaNfe( TLista:TStringList ; xES:string);

  end;

Type TProdutos=record
    codigo:string;
    pericms:currency;
    codtamanho,codcor:integer;
    qtde,unitario,totalitem,reducaobase:extended;
end;

var
  FNotaTransf: TFNotaTransf;
  QBusca,QEstoque,QBuscaNota,QGrade:TSqlquery;
  Op,Transacao,Acao,CSTTransferencia,UnidadeTransferencia:string;
  ListaReservacodigo,ListaReservaQtde:TStringList;
  Acumulado:currency;
  codigobarra:boolean;
  ListaProdutos:Tlist;
  PProdutos:^Tprodutos;
  database:Tdatetime;

const TipoEntradaAbate:string='EA';

implementation

uses Geral, Arquiv, Estoque, SqlFun, SqlSis, codigosfis, impressao,
  Sittribu, cadcor, tamanhos, expnfetxt;

{$R *.dfm}

procedure TFNotaTransf.Execute(Acao:string);
/////////////////////////////////////////////
begin

  Op:=Acao;
  ListaProdutos:=Tlist.create;

  CSTTransferencia:=Global.CstTransferencia;

  if not Arq.TTransp.Active then Arq.TTransp.Open;
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if not Arq.TEstoqueQtde.Active then Arq.TEstoqueQtde.Open;
  if not Arq.TClientes.Active then Arq.TClientes.Open;
  if not Arq.TRepresentantes.Active then Arq.TRepresentantes.Open;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
  if not Arq.TNatFisc.Active then Arq.TNatFisc.Open;
  Arq.TNatFisc.setfilter('natf_es=''S''');
//  Arq.TNatFisc.OpenWith('natf_es=''S''',Arq.TNatFisc.Ordenacao);
//  if not Arq.TConfMovimento.Active then Arq.TConfMovimento.Open;
  Arq.TConfMovimento.OpenWith(FGeral.GetIN('comv_tipomovto',Global.TiposSaida,'C'),Arq.TConfMovimento.Ordenacao);
  if not Arq.TFPgto.Active then Arq.TFPgto.Open;
  if not Arq.TPortadores.Active then Arq.TPortadores.Open;
  if not Arq.TSittributaria.Active then Arq.TSittributaria.Open;
  if not Arq.TCodigosFiscais.active then Arq.TCodigosFiscais.open;
  EdComv_codigo.clearall(FNotaTransf,99);
  EdProduto.clearall(FNotaTransf,99);
  database:=Sistema.hoje-70;
  EdPedidos.text:='';

//  EdPedidos.enabled:=FGeral.UsuarioTeste(Global.Usuario.codigo);
//  EdPedidos.Visible:=FGeral.UsuarioTeste(Global.Usuario.codigo);
  EdPedidos.enabled:=false;
  EdPedidos.Visible:=false;
// 03.05.06
  EdDtemissao.enabled:=Global.Usuario.OutrosAcessos[0702];
// 28.08.06
  ListaReservaCodigo:=TStringlist.Create;
  ListaReservaQTde:=TStringlist.Create;
  EdUnid_origem.Text:=Global.CodigoUnidade;
  EdDtEmissao.SetDate(Sistema.hoje);
  EdDtSaida.SetDate(Sistema.hoje);
  Grid.clear;
// 14.12.12
  EdCodcor.Enabled:=Global.Topicos[1309];
  EdCodTamanho.Enabled:=Global.Topicos[1309];
// 23.03.14
  FGeral.ConfiguraColorEditsNaoEnabled(FNotaTransf);
  EdRomaneio.Enabled:=Global.Topicos[1371];
  EdFornec.Enabled:=Global.Topicos[1371];
  Edpertransf.Enabled:=Global.Topicos[1371];
  FGeral.ConfiguraColorEditsNaoEnabled(FNOtaTransf);
  Show;
//

//  Edtotalnota.Color:=clblack;
// 05.06.15
  UnidadeTransferencia:=FGeral.getconfig1asstring('UNIDADETransf');
  if UnidadeTransferencia='' then UnidadeTransferencia:=Global.unidadematriz;
  FGEral.SetaTribUnidades;   //  08.12.05
  EdComv_codigo.setfocus;
end;


procedure TFNotaTransf.EdComv_codigoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var s:string;
begin
  s:=Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodTransfSaidaTempo+';'+Global.CodTransfSaiRetTempo+';'+
     Global.CodTransMatConsumoS;
  if Listaprodutos=nil then
    ListaProdutos:=Tlist.create;
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,s)=0 then begin
    EdComv_codigo.invalid('Movimento inv�lido para transfer�ncias');
  end else begin
   EdNumerodoc.enabled:=Global.Topicos[1301];;
// 15.05.07
  if (Global.Topicos[1301]) and (EdNumerodoc.isempty) then
     EdNumerodoc.setvalue( FGeral.ConsultaContador('NFSAIDA'+Global.CodigoUnidade+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade) ) + 1 );
//   if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodTransfSaiRetTempo then begin
//     EdNumerodoc.enabled:=true;
//   end else
//     EdNumerodoc.enabled:=false;
  end;

end;

procedure TFNotaTransf.EdUnid_destinoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////////
var QNota:TSqlquery;
begin

  if EdUNid_destino.text=EdUnid_origem.text then
    EdUNid_destino.invalid('Unidades tem que ser diferentes')

  else begin

    if EdUnid_origem.ResultFind.fieldbyname('unid_uf').asstring<>EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring then begin

      EdNatf_codigo.text:=EdComv_codigo.resultfind.fieldbyname('comv_natf_foestado').asstring;
      if pos( EdUnid_origem.ResultFind.fieldbyname('Unid_simples').asstring,'S;2' ) >0 then
        CSTTransferencia:=FSittributaria.GetCST(EdUnid_origem.ResultFind.fieldbyname('unid_sitt_forestado').asinteger,'S')

    end else begin

      EdNatf_codigo.text:=EdComv_codigo.resultfind.fieldbyname('comv_natf_estado').asstring;
// 21.09.11
      if pos( EdUnid_origem.ResultFind.fieldbyname('Unid_simples').asstring,'S;2' ) >0 then
        CSTTransferencia:=FSittributaria.GetCST(EdUnid_origem.ResultFind.fieldbyname('unid_sitt_codestado').asinteger,'S')

    end;

    if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodTransfSaiRetTempo then begin

      sistema.beginprocess('pesquisando transfer�ncias');
      Qnota:=sqltoquery('select * from movesto '+
                            ' where moes_status=''N'' and '+FGeral.getin('moes_tipomov',Global.CodTransfSaidaTempo,'C')+
                            ' and moes_unid_codigo='+EdUnid_destino.assql+
                            ' and moes_datamvto>='+Datetosql(Database)+
                            ' order by moes_numerodoc' );
     EdNumerodoc.Items.clear;
     while not QNota.eof do begin
       EdNUmerodoc.Items.Add(strspace(QNota.fieldbyname('moes_numerodoc').asstring,8)+' - '+QNota.fieldbyname('moes_dataemissao').asstring);
       QNota.next;
     end;
     sistema.endprocess('');
     FGeral.Fechaquery(QNota);
    end;
  end;
end;

procedure TFNotaTransf.EdNatf_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
var iniciook:string;
begin
//  if EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring<>Global.UFUnidade then
// 19.05.05
  if EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring<>EdUNid_origem.resultfind.fieldbyname('unid_uf').asstring then
    iniciook:='6,7'
  else
    iniciook:='5';

  if (iniciook='5') and (EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring='SC') and
    (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.codtransfsaida )
    then begin
    EdMens_codigo.setvalue(FGeral.getconfig1asinteger('codmentran'));
    EdMens_codigo.enabled:=false;
    Edmensagem.enabled:=false;

  end else if (iniciook='5') and (EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring='SC') and
    (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.codtransfsaidatempo )
    then begin
    EdMens_codigo.setvalue(FGeral.getconfig1asinteger('CODMENFEIRA'));
    EdMens_codigo.enabled:=false;
    Edmensagem.enabled:=false;
// 04.04.06
///////////////////////////

  end else if (iniciook='5') and (EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring=EdUNid_origem.resultfind.fieldbyname('unid_uf').asstring) and
    (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.CodTransMatConsumoS )
    then begin
    EdMens_codigo.setvalue(FGeral.getconfig1asinteger('MENSTRAMATES'));
    EdMens_codigo.enabled:=false;
    Edmensagem.enabled:=false;

  end else if (pos('6',iniciook)>0) and (EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring<>EdUNid_origem.resultfind.fieldbyname('unid_uf').asstring) and
    (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.CodTransMatConsumoS )
    then begin

    EdMens_codigo.setvalue(FGeral.getconfig1asinteger('MENSTRAMATFO'));
    EdMens_codigo.enabled:=false;
    Edmensagem.enabled:=false;
//////////////////////////////////////
// 20.09.19
  end else if (Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=global.CodTransfSaida )
// 03.05.2021 - Novicarnes - Jane+Simone
              and ( FGeral.getconfig1asinteger('CODMENTRAN') > 0 )

    then begin

    EdMens_codigo.setvalue(FGeral.getconfig1asinteger('CODMENTRAN'));
    EdMens_codigo.enabled:=false;
    Edmensagem.enabled:=false;

  end else begin

    EdMens_codigo.setvalue(0);
    EdMens_codigo.enabled:=true;
    Edmensagem.enabled:=true;

  end;

  Edmens_codigo.valid;
  if pos(copy(EdNatf_codigo.text,1,1),iniciook)=0 then
    EdNatf_codigo.Invalid('Natureza inv�lida para esta opera��o');
// 22.10.19 - Novicarnes - Ketlen
//  if copy(EdNatf_codigo.text,2,3) = '557' then
//     CSTTransferencia := '090';
// 23.10.20 - Novicarnes - Simone - 'desmudou' sen�o n�o autoriza
//27.10.20 - Novicarnes - Ketlen+Simone - CSt 041... vamos ver
end;

procedure TFNotaTransf.EdDtSaidaValidate(Sender: TObject);
begin
  if not FGeral.ValidaMvto(EdDtSaida) then
    EdDtSaida.Invalid('')
  else if EdDtSaida.AsDate<EdDtemissao.asdate then
    EdDtSaida.Invalid('Data de saida tem que ser maior ou igual a emiss�o')
  else
    EdDtmovimento.setdate(EdDtsaida.asdate);

end;

procedure TFNotaTransf.EdProdutoValidate(Sender: TObject);
var QBusca:TSqlquery;
    custotrans,perctrans:currency;
    codbarra:string;
begin
// 05.12.05
  if not FEstoque.ValidaCodigoProduto(EdProduto,EdProduto.text) then
    exit;

  codigobarra:=false;
  if  FGeral.CodigoBarra(EdProduto.Text,EdProduto) then begin
    QBusca:=sqltoquery('select * from estoque where esto_Codbarra='+EdProduto.Assql);
    codbarra:=EdProduto.text;
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
//      EdProduto.Invalid('Codigo de barra n�o encontrado');
//      exit;
    end;
    codigobarra:=true;
    EdQtde.Enabled:=false;
    EdQtde.SetValue(1);
//////////////////////////////////////
// 17.01.2013
    if not Qbusca.eof then begin
      QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_origem.text));
// 26.03.13 - Vivan financeiro
      if not global.Topicos[1201] then begin
        if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsFloat,EdUNid_origem.Text,QEstoque) then begin
           EdProduto.INvalid('Quantidade em estoque insuficiente');
           exit;
        end;
      end;
    end;
    EdCodcor.enabled:=false;
    EdCodtamanho.enabled:=false;
    EdCodcor.text:='';
    EdCodtamanho.text:='';
//    if QBusca.FieldByName('esto_grad_codigo').asinteger>0 then begin
    if QBusca.eof  then begin
      QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'''+
                       ' and esgr_unid_codigo='+Stringtosql(EdUnid_origem.text)+
                       ' and esgr_codbarra='+stringtosql(codbarra));
      if not QGrade.eof then begin
        EdProduto.Text:=QGrade.fieldbyname('esgr_esto_codigo').AsString;
        EdCodcor.setvalue(QGrade.fieldbyname('esgr_core_codigo').asinteger);
        EdCodcor.validfind;
        EdCodtamanho.setvalue(QGrade.fieldbyname('esgr_tama_codigo').asinteger);
        EdCodtamanho.validfind;
        FGeral.Fechaquery(QEstoque);
        QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_origem.text));
        FGeral.Fechaquery(QBusca);
        QBusca:=sqltoquery('select * from estoque where esto_codigo='+EdProduto.assql);
      end else begin
        EdProduto.Invalid('Codigo de barra da grade n�o encontrado');
        exit;
      end;
    end;

/////////////////////////////////
  end else begin
    QBusca:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.AsSql);
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
      EdProduto.Invalid('Codigo n�o encontrado');
      exit;
    end;
    EdQtde.Enabled:=true;
    EdQtde.SetValue(0);
  end;
  if codigobarra then begin
    EdCodcor.enabled:=false;
    EdCodtamanho.enabled:=false;
  end else begin
    EdCodcor.setvalue(0);
    EdCodtamanho.setvalue(0);
    EdCodcor.enabled:=true;
    EdCodtamanho.enabled:=true;
  end;
  SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;
  Sistema.setmessage('Pesquisando quantidade em estoque na unidade origem');
  QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                       ' and esqt_unid_codigo='+Stringtosql(EdUnid_Origem.text));

  Sistema.setmessage('');
  if length( FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_codestado').asinteger) )<> 3 then begin
     EdProduto.Invalid('Situa��o tribut�ria no estado inv�lida');
     exit;
  end;
  if length( FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_forestado').asinteger) ) <> 3 then begin
     EdProduto.Invalid('Situa��o tribut�ria fora do estado inv�lida');
     exit;
  end;
  perctrans:=FCodigosFiscais.GetPercTransf(FEstoque.GetCodigoFiscal(EdProduto.text,EdUNid_origem.text,EdUnid_Destino.resultfind.fieldbyname('unid_uf').AsString));
// aqui ver se tera q dar um jeito e pegar o custo da matriz...coisas de perebice da contabilidade
//  custotrans:=QEstoque.fieldbyname('esqt_custoger').AsCurrency*(1+(perctrans/100));
//  custotrans:=QEstoque.fieldbyname('esqt_custo').AsCurrency*(1+(perctrans/100));
// 19.05.05 - ate implantar a 001 fica a 999
  if EdDtmovimento.asdate>1 then
//    custotrans:=FEstoque.GetCusto(EdProduto.text,global.unidadematriz999,'medio')
    custotrans:=FEstoque.GetCusto(EdProduto.text,unidadetransferencia,'medio')
  else
//    custotrans:=FEstoque.GetCusto(EdProduto.text,global.unidadematriz999,'gerencial')
    custotrans:=FEstoque.GetCusto(EdProduto.text,unidadetransferencia,'gerencial');
// 17.01.13
   if custotrans=0 then begin
     if Global.Topicos[1360] then
       custotrans:=FEstoque.GetPreco(EdProduto.text,EdUnid_origem.text)
     else
      EdUnitario.enabled:=true
  end else
// 19.03.08
    EdUnitario.enabled:=Global.Usuario.OutrosAcessos[0034];
//    EdUnitario.enabled:=false;

  EdUnitario.Setvalue(custotrans);
  EdUnitarioGer.Setvalue(custotrans);

//  x:=FGeral.ProcuraGrid(0,EdProduto.Text,Grid);
//  if x>0 then
//     EdProduto.Invalid('Produto j� existente.   Excluir e incluir.');

end;

procedure TFNotaTransf.FormActivate(Sender: TObject);
begin
{
  Op:='I';  // por enquanto fixo
  ListaReservaCodigo:=TStringlist.Create;
  ListaReservaQTde:=TStringlist.Create;
  EdUnid_origem.Text:=Global.CodigoUnidade;
  EdDtEmissao.SetDate(Sistema.hoje);
  EdDtSaida.SetDate(Sistema.hoje);
}
end;

procedure TFNotaTransf.EdQtdeValidate(Sender: TObject);
begin
  if EdQtde.AsCurrency>0 then begin
    if (QEstoque=nil) then
      avisoerro('Qestoque est� nil');
    if (QEstoque.IsEmpty) then
      avisoerro('Qestoque est� vazio');
    if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsCurrency,EdUNid_origem.Text,QEstoque) then begin
       EdQTde.INvalid('Quantidade em estoque insuficiente');
    end;
  end;

end;

procedure TFNotaTransf.EdQtdeExitEdit(Sender: TObject);
var conf:boolean;
begin
  if codigobarra then
    conf:=true
  else
    conf:=confirma('Confirma item ?');
  if conf then begin
    if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,global.TiposMovMovEstoque)>0 then
      ReservaEstoque(EdProduto.Text,'I',EdQtde.AsFloat);
    EditstoGrid;
    SetaEditsValores;
    if op='A' then begin
//      GravaItemConsignacao;
//      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
//             Global.CodRemessaConsig,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger);
//      Sistema.Commit;
      ListaReservaCodigo.Clear;
      ListaReservaQtde.Clear;
    end;
  end;
  LimpaEditsItens;
  EdProduto.SetFocus;
  QEstoque.Close;
  Freeandnil(QEstoque);

end;

procedure TFNotaTransf.EditstoGrid;
////////////////////////////////////
var x:integer;
    aqtde,reducaobase:currency;
    achou:boolean;
begin
  Sistema.setmessage('Pesquisando item dentro do grid');

  x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.getcolumn('move_tama_codigo'),
     EdCodtamanho.asinteger,Grid.getcolumn('move_core_codigo'),Edcodcor.asinteger);
////  x:=BuscaItem(EdProduto.text);
// 19.08.05 - desfeito pois alguns produtos ficaram dua vezes no grid com qtdes  diferentes
  Sistema.setmessage('');
  reducaobase:=0;

  if x<=0 then begin

    if (Grid.RowCount=2) and (Trim(Grid.Cells[0,1])='') then begin
       x:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       x:=Grid.RowCount-1;
    end;
    Grid.Cells[Grid.Getcolumn('move_esto_codigo'),Abs(x)]:=EdProduto.Text;
    Grid.Cells[Grid.Getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;
//    Grid.Cells[2,Abs(x)]:=FEstoque.Getsituacaotributaria(EdProduto.text,Edunid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring);
// 06.07.05
    Grid.Cells[Grid.Getcolumn('move_cst'),Abs(x)]:=CstTransferencia;
// 29.10.20
    if Global.topicos[1474] then

       Grid.Cells[Grid.Getcolumn('move_cst'),Abs(x)]:= FEstoque.Getsituacaotributaria(EdProduto.text,EdUNid_Origem.text,EdUNid_Origem.Resultfind.fieldbyname('unid_uf').asstring) ;

    //    Grid.Cells[Grid.Getcolumn('move_aliicms'),Abs(x)]:=currtostr(FEstoque.Getaliquotaicms(EdProduto.text,Edunid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring));
// 10.10.19 - Novicarnes
    Grid.Cells[Grid.Getcolumn('move_aliicms'),Abs(x)]:=currtostr(0);
// 08.09.05
    if (EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring='SC') and
       (EdUNid_origem.resultfind.fieldbyname('unid_uf').asstring=EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring) then begin
      Grid.Cells[Grid.Getcolumn('move_cst'),Abs(x)]:=Global.CstTransferenciaSC;
      Grid.Cells[Grid.Getcolumn('move_aliicms'),Abs(x)]:=currtostr(0);
    end;
// 19.01.16
    if pos(EdNatf_codigo.text,'5913/6913') > 0 then
         reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring,'N',EdProduto.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring )
      else begin
        if EdUNid_origem.resultfind.FieldByName('unid_uf').asstring=EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring then
            reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring,'N',EdProduto.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring )
        else
            reducaobase:=0;
    end;
    if pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.TiposNaoCalcIcms ) > 0 then
      reducaobase:=0;

    Grid.Cells[Grid.Getcolumn('move_redubase'),Abs(x)]:=Transform(reducaobase,'#0.000');
//////////////////////////////
    Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=SetEdtamanho.text;
    Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=SetEdcor.text;
    Grid.Cells[Grid.Getcolumn('esto_unidade'),Abs(x)]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
    Grid.Cells[Grid.Getcolumn('move_qtde'),Abs(x)]:=EdQTde.AsSql;
    Grid.Cells[Grid.Getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.Getcolumn('totalunitario'),Abs(x)]:=TRansform(EdQTde.AsFloat*EdUnitario.AsFloat,f_cr);
    Grid.Cells[Grid.Getcolumn('precovenda'),Abs(x)]:=TRansform(Festoque.GetPreco(Edproduto.text,EdUnid_origem.text),f_cr);
    Grid.Cells[Grid.getcolumn('move_tama_codigo'),Abs(x)]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('move_core_codigo'),Abs(x)]:=EdCodcor.text;

  end else begin

    Grid.Cells[Grid.Getcolumn('move_esto_codigo'),x]:=EdProduto.Text;
    Grid.Cells[Grid.Getcolumn('esto_descricao'),x]:=SetEdEsto_descricao.text;
//    Grid.Cells[2,x]:=FEstoque.Getsituacaotributaria(EdProduto.text,Edunid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring);
// 06.07.05
    Grid.Cells[Grid.Getcolumn('move_cst'),Abs(x)]:=CstTransferencia;
// 24.11.20
    if Global.topicos[1474] then

       Grid.Cells[Grid.Getcolumn('move_cst'),Abs(x)]:= FEstoque.Getsituacaotributaria(EdProduto.text,EdUNid_Origem.text,EdUNid_Origem.Resultfind.fieldbyname('unid_uf').asstring) ;


    //    Grid.Cells[Grid.Getcolumn('move_aliicms'),x]:=currtostr(FEstoque.Getaliquotaicms(EdProduto.text,Edunid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring));
// 10.10.19 - Novicarnes
    Grid.Cells[Grid.Getcolumn('move_aliicms'),Abs(x)]:=currtostr(0);
// 08.09.05
    if (EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring='SC') and
       (EdUNid_origem.resultfind.fieldbyname('unid_uf').asstring=EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring) then begin
      Grid.Cells[Grid.Getcolumn('move_cst'),Abs(x)]:=Global.CstTransferenciaSC;
      Grid.Cells[Grid.Getcolumn('move_aliicms'),Abs(x)]:=currtostr(0);
    end;
// 19.01.16
    if pos(EdNatf_codigo.text,'5913/6913') > 0 then
         reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring,'N',EdProduto.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring )
      else begin
        if EdUNid_origem.resultfind.FieldByName('unid_uf').asstring=EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring then
            reducaobase:=FCodigosFiscais.GetAliquotaRedBase( QEstoque.fieldbyname('esqt_cfis_codigoest').asstring,'N',EdProduto.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring )
        else
            reducaobase:=0;
    end;
    if pos( Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Global.TiposNaoCalcIcms ) > 0 then
      reducaobase:=0;

    Grid.Cells[Grid.Getcolumn('move_redubase'),Abs(x)]:=Transform(reducaobase,'#0.000');
//////////////////////////////

    Grid.Cells[Grid.Getcolumn('esto_unidade'),x]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
    aqtde:=texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),x])+ EdQTde.AsFloat;
//    Grid.Cells[5,x]:=Transform(texttovalor(Grid.Cells[5,x])+EdQTde.Ascurrency,f_cr);
    Grid.Cells[Grid.Getcolumn('move_qtde'),x]:=Valortosql( texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),x])+EdQTde.AsFloat );
    Grid.Cells[Grid.Getcolumn('move_venda'),x]:=Valortosql(EdUnitario.Ascurrency);
//    Grid.Cells[Grid.Getcolumn('totalunitario'),x]:=Valortosql( (aqtde)*EdUnitario.AsCurrency);
// 03.06.15
    Grid.Cells[Grid.Getcolumn('totalunitario'),x]:=Valortosql( Texttovalor(Grid.Cells[Grid.Getcolumn('totalunitario'),x]) +
                                                     (Edqtde.asfloat*EdUnitario.ascurrency) );
    Grid.Cells[Grid.Getcolumn('precovenda'),x]:=TRansform(Festoque.GetPreco(Edproduto.text,EdUnid_origem.text),f_cr);
  end;
// 11.08.05
  achou:=false;
  for x:=0 to LIstaProdutos.count-1 do begin
    PProdutos:=listaprodutos[x];
    if Pprodutos.codigo=EdProduto.text then begin
      achou:=true;
      break;
    end;
  end;
  if not achou then begin
    New(PProdutos);
    PProdutos.codigo:=Edproduto.text;
    PProdutos.qtde:=EdQtde.asFloat;
    PProdutos.unitario:=EdUnitario.ascurrency;
    PProdutos.totalitem:=EdUnitario.asFloat*EdQtde.asfloat;
    PProdutos.pericms:=FEstoque.Getaliquotaicms(EdProduto.text,Edunid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring);
    PProdutos.codtamanho:=EdCodtamanho.asinteger;
    PProdutos.codcor:=EdCodcor.asinteger;
    if (EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring='SC') and
       (EdUNid_origem.resultfind.fieldbyname('unid_uf').asstring=EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring) then begin
      PProdutos.pericms:=0;
    end;
// 19.01.16
    PProdutos.reducaobase:=reducaobase;
    ListaProdutos.add(PProdutos);
  end else begin
    PProdutos.qtde:=PProdutos.qtde+EdQtde.asfloat;
// 03.06.15
    PProdutos.totalitem:=PProdutos.totalitem+(EdUnitario.asFloat*EdQtde.asfloat);
  end;
//////////  Grid.Refresh;
// 09.06.05

end;

procedure TFNotaTransf.LimpaEditsItens;
begin
  EdProduto.Clear;
  EdQtde.Clear;
  EdUnitario.Clear;
  SetedEsto_descricao.Clear;

end;

procedure TFNotaTransf.ReservaEstoque(Codigo, IncExc: string;
  Qtde: currency);
var p:integer;
begin
  if not Global.Topicos[1201] then begin
    if Incexc='I' then begin
      ListaReservaCodigo.Add(Codigo);
      ListaReservaQtde.Add(transform(Qtde,'#,###,###.00'));
      FGeral.ReservaEstoque(Codigo,EdUnid_origem.text,'S',Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Qtde);
    end else begin
      p:=ListaReservaCodigo.IndexOf(Codigo);
      if p>-1 then begin
        ListaReservaCodigo.Delete(p);
        ListaReservaQtde.Delete(p);
        FGeral.ReservaEstoque(Codigo,EdUnid_origem.text,'E',Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,Qtde);
      end;
    end;
    Sistema.Commit;
  end;

end;

procedure TFNotaTransf.RetornaReserva;
/////////////////////////////////////////
var p:integer;
begin
  if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,global.TiposMovMovEstoque)>0 then begin
    if ListaReservaCodigo<>nil then begin
      if ListaReservaCodigo.Count>0 then begin
        for p:=0 to ListaReservaCodigo.Count-1 do begin
          FGeral.ReservaEstoque(ListaReservaCodigo[p],EdUnid_origem.text,'E',Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,texttovalor(ListaReservaQtde[p]));
        end;
        Sistema.Commit;
        ListaReservaCodigo.Clear;
        ListaReservaQTde.Clear;
      end;
    end;
  end;
end;

procedure TFNotaTransf.SetaEditsValores;
/////////////////////////////////////////////////
var baseicms,vlricms,basesubs,icmssubs,totalprodutos,totalnota,totalitem,aliicms,icmsitem,margemlucro,totalpecas,
    totalitembase:currency;
    p:integer;
    produto:string;

begin

  baseicms:=0; vlricms:=0; basesubs:=0 ; icmssubs:=0 ; totalprodutos:=0 ;
// percorrer o grid somando valores e montando base do icms normal e subst. tribut�ria
///////////////////////////////////////////////////////////////////////
{
  for p:=1 to Grid.rowcount do begin
    produto:=Grid.Cells[0,p];
    if trim(produto)<>'' then begin
      totalitem:=Fgeral.Arredonda( texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p]) * texttovalor(Grid.Cells[Grid.GetColumn('move_venda'),p]) ,2);
      Arq.TEstoque.locate('esto_codigo',produto,[]);
      Arq.TSittributaria.Locate('sitt_codigo',FEstoque.Getsituacaotributaria(produto,EdUnid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring),[]);
//// 14.06.05 - ver se continua a demora pra atualizar os edits dos totais da nf
//// alem do que a funcao getsituacaotributaria retorna o cst e nao o codigo da sit. trib.
//      Arq.TSittributaria.Locate('sitt_codigo', ,[]);
//      aliicms:=FEstoque.Getaliquotaicms(produto,EdUnid_codigo.text,Edcliente);
      aliicms:=texttovalor(Grid.Cells[Grid.GetColumn('Move_aliicms'),p] );
      icmsitem:=FGeral.Arredonda( totalitem*(aliicms/100) ,2);
//      margemlucro:=0;
      if EdDtmovimento.isempty then begin
        baseicms:=0;
        icmsitem:=0;
      end;
      if icmsitem>0 then begin
        baseicms:=baseicms+totalitem;
        vlricms:=vlricms+icmsitem;
      end;
      icmssubs:=0;
//      if Arq.TNatFisc.fieldbyname('natf_movimento').asstring<>'T' then begin
      if EdNatf_codigo.resultfind=nil then
        EdNatf_codigo.valid;
      if EdNatf_codigo.resultfind.fieldbyname('natf_movimento').asstring<>'T' then begin
        if Arq.TSittributaria.fieldbyname('sitt_cf').asstring=Global.CodigoSubsTrib then begin
  //        margemlucro:=Global.MargemSubsTrib;   // ate ver onde pode colocar para configurar
          margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring));
          basesubs:=basesubs+( totalitem*(1+(margemlucro/100)) );
          icmssubs:=(totalitem*(1+(margemlucro/100))) * (aliicms/100);
        end;
        if EdDtmovimento.isempty then begin
          icmssubs:=0;
          basesubs:=0
        end;
      end;
      totalprodutos:=totalprodutos+totalitem;
      totalpecas:=totalpecas+texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),p])
    end;
  end;
}
///////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////

  for p:=0 to ListaProdutos.count-1 do begin

    sistema.setmessage('Calculando base de c�lculo do icms');
    PProdutos:=Listaprodutos[p];
    produto:=PProdutos.codigo;
    if trim(produto)<>'' then begin
//      totalitem:=Fgeral.Arredonda( PProdutos.qtde * PProdutos.unitario ,2);
// 03.06.15
//      totalitem:=Fgeral.Arredonda( PProdutos.totalitem ,2 );
// 09.08.18 -devido a diferen�a de centavos entre total produtos e soma por item
//      totalitem:=Fgeral.Arredonda( PProdutos.totalitem ,4 );
// 19.06.20
      totalitem:=Fgeral.Arredonda( PProdutos.totalitem ,2 );

      Arq.TEstoque.locate('esto_codigo',produto,[]);
      Arq.TSittributaria.Locate('sitt_codigo',FEstoque.Getsituacaotributaria(produto,EdUnid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring),[]);
      aliicms:=Pprodutos.pericms;
      icmsitem:=FGeral.Arredonda( totalitem*(aliicms/100) ,2);
      if PProdutos.reducaobase >0 then
// 19.01.16 - reducao de base
        totalitembase:=( totalitem*(PProdutos.reducaobase/100) )
      else
        totalitembase:=totalitem;
//////////////////
      if EdDtmovimento.isempty then begin
        baseicms:=0;
        icmsitem:=0;
      end;
// 05.12.05
      if pos(EdComv_codigo.ResultFind.fieldbyname('comv_tipomovto').asstring,Global.TiposNaoCalcIcms)>0 then begin
        vlricms:=0;
        icmsitem:=0;  // 08.02.06
      end;

      icmsitem:=FGeral.Arredonda( totalitembase*(aliicms/100) ,2);
// 04.05.16
//      icmsitem:=roundvalor( totalitembase*(aliicms/100) );
//      icmsitem:=( totalitembase*(aliicms/100) );
////////
{
      if icmsitem>0 then begin
        baseicms:=baseicms+totalitem;
        vlricms:=vlricms+icmsitem;
      end;
      }
// 19.01.16
      if icmsitem>0 then begin
        baseicms:=baseicms+totalitembase;
        vlricms:=vlricms+icmsitem;
      end;

/////////////
      icmssubs:=0;
      if EdNatf_codigo.resultfind=nil then
        EdNatf_codigo.valid;
      if EdNatf_codigo.resultfind.fieldbyname('natf_movimento').asstring<>'T' then begin
        if Arq.TSittributaria.fieldbyname('sitt_cf').asstring=Global.CodigoSubsTrib then begin
          margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring));
          basesubs:=basesubs+( totalitem*(1+(margemlucro/100)) );
          icmssubs:=(totalitem*(1+(margemlucro/100))) * (aliicms/100);
        end;
        if EdDtmovimento.isempty then begin
          icmssubs:=0;
          basesubs:=0
        end;
      end;
      totalprodutos:=totalprodutos+totalitem;
      totalpecas:=totalpecas+PProdutos.qtde;
    end;
  end;
  Sistema.setmessage('Base icms j� calculada');
///////////////////////////////////////////////////////////////////////

  totalnota:=totalprodutos+EdFrete.Ascurrency+EdSeguro.ascurrency+icmssubs;
  PTotais.EnableEdits;
//  EdTotalnota.enabled:=true;
  EdBaseicms.setvalue(baseicms);
  EdValoricms.setvalue(vlricms);
  EdBasesubs.setvalue(basesubs);
  EdValorsubs.setvalue(icmssubs);
  Edtotalprodutos.setvalue(totalprodutos);
  Edtotalnota.setvalue(totalnota);
//  EdTotalnota.enabled:=false;
  Edtotalpecas.setvalue(totalpecas);
  PTotais.DisableEdits;
  sistema.setmessage('');
//  Update;
end;

procedure TFNotaTransf.bSairClick(Sender: TObject);
begin
  Grid.Clear;
  Close;

end;

procedure TFNotaTransf.bIncluiritemClick(Sender: TObject);
begin
  if EdUnid_destino.AsInteger=0 then exit;
  PRemessa.Enabled:=false;
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
//  bCancelar.Enabled:=false;
//  PINs.Visible:=true;
//  PINs.EnableEdits;
  PIns.enabled:=true;
  LimpaEditsItens;
  EdProduto.SetFocus;

end;

// 21.10.20
procedure TFNotaTransf.bnfcompraClick(Sender: TObject);
/////////////////////////////////////////////////////////
var ctransacoes : string;
    Lista       : TStringList;
    QN          : TSqlquery;

begin

    if EdUNid_origem.isempty then begin
       Avisoerro('Obrigat�rio informar a unidade origem');
       exit;
    end;

    Lista       := TStringList.create;
    if confirma('Quer informado direto a transa��o ?') then
        Input('Informe a transa��o a ser alterada ','Transa��o ',ctransacoes,14,true)
    else
        GetListaNfe( Lista,'E' );

    if (Lista.count>0) and (Lista[0]<>'') then begin

       ctransacoes:=SelecionaItems(Lista,'NFe de Compra','',false);
       strtolista(Lista,ctransacoes,'|',true);

    end else

      Lista.Add(ctransacoes);

    if ( copy(ctransacoes,1,11)<>'Transa��o |' ) and ( trim(ctransacoes)<>'' ) then begin
       QN:=sqltoquery('select * from movestoque where move_transacao='+Stringtosql(trim(Lista[0]))+' and '+
           FGeral.GetNOTIN('move_tipomov',Global.CodBaixaMatSai,'C') );
       if not QN.eof then begin

          Campostogrid(QN);

       end;
       FGeral.FechaQuery(QN);
       SetaEditsvalores;

    end;
    Lista.clear;

end;

procedure TFNotaTransf.bExcluiritemClick(Sender: TObject);
var codigoestoque:string;
    qtde,codigocor,codigotam:currency;


    procedure DeletaRegistro(produto:string);
    ///////////////////////////////////////////////
    var x:integer;
    begin
      for x:=0 to LIstaProdutos.count-1 do begin
        PProdutos:=listaprodutos[x];
        if (Pprodutos.codigo=Produto) and (PProdutos.codtamanho=codigotam) and (PProdutos.codcor=codigocor) then begin
          ListaProdutos.Delete(x);
          break;
        end;
      end;
    end;


begin
  if trim(Grid.Cells[0,Grid.row])='' then exit;
  if confirma('Confirma exclus�o ?') then begin
    codigoestoque:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
    codigocor:=Texttovalor(Grid.Cells[Grid.getcolumn('move_core_codigo'),Grid.row]);
    codigotam:=Texttovalor(Grid.Cells[Grid.getcolumn('move_tama_codigo'),Grid.row]);
    qtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
    Grid.DeleteRow(Grid.Row);
    DeletaRegistro(codigoestoque);
    SetaEditsValores;
    if pos(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring,global.TiposMovMovEstoque)>0 then
      ReservaEstoque(Codigoestoque,'E',qtde);
    if OP='A' then begin
      ExecuteSql('Update movestoque set move_status=''C'' where move_status=''N'''+
          ' and move_numerodoc='+EdNumerodoc.AsSql+
          ' and move_tipomov='+Stringtosql(Global.CodRemessaConsig)+
          ' and move_unid_codigo='+Stringtosql(EdUnid_origem.text)+
          ' and move_tipo_codigo='+EdUnid_destino.AsSql+
          ' and move_esto_codigo='+Stringtosql(codigoestoque)+
          ' and move_tipocad='+Stringtosql('C') );
//      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
//             Global.CodRemessaConsig,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger);

    end;
    Sistema.Commit;
  end;
end;

procedure TFNotaTransf.bCancelaritemClick(Sender: TObject);
begin
  if EdUnid_destino.AsInteger=0 then exit;
  bGravar.Enabled:=true;
//  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
//  PINs.Visible:=false;
//  PINs.DisableEdits;
//  AtivaEdits;
  PIns.enabled:=false;
  PRemessa.Enabled:=true;
  EdComv_codigo.SetFocus;

end;

procedure TFNotaTransf.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var QMestre:TSqlquery;
begin
  if (EdUnid_destino.AsInteger>0) and (EdUnid_origem.AsInteger>0) then begin
    if OP='I' then begin
      QMestre:=Sqltoquery('select moes_status from movesto where moes_status=''N'''+
          ' and moes_tipomov='+Stringtosql(Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring)+
          ' and moes_unid_codigo='+Stringtosql(EdUnid_origem.text)+
          ' and moes_tipo_codigo='+EdUNid_destino.AsSql+
          ' and moes_datamvto='+EdDtEmissao.AsSql+
          ' and moes_numerodoc='+EdNumerodoc.AsSql+
          ' and moes_tipocad='+Stringtosql('U') );
      if (QMestre.Eof) and (EdTotalnota.ascurrency>0) then begin
        if Confirma('� prov�vel que este documento ainda n�o foi gravado.  Gravar ?') then
          bgravarclick(Self);
      end;
      RetornaReserva;
    end else begin
//      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
//             Arq.TConfMovimento.fieldbyname('comv_tipomovto').asstring,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger);
//      Sistema.Commit;
    end;
  end;

  if ListaReservaCodigo<>nil then ListaReservaCodigo.Free;
  if ListaReservaQtde<>nil then ListaReservaQtde.Free;
//  Arq.TNatFisc.close;
  Arq.TNatfisc.setfilter('');

end;

procedure TFNotaTransf.GetListaNfe(TLista: TStringList; xES: string);
/////////////////////////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
    sqlconfmov,tiposnao,tiposdemovimento,sqlexp,sqles:string;
    Di,Df:TDatetime;

begin

  if xEs='S' then
    sqlexp:=' and extract( year from moes_dtnfeauto ) >= '+Strzero(Datetoano(Sistema.hoje,true)-1,4)
  else
//    sqlexp:=' and moes_chavenfe is not null';
    sqlexp:=' and moes_especie=''NFE''';
//  Di:=Sistema.Hoje-460;
  Di:=Sistema.Hoje-60;
// 24.08.16
  if FGeral.GetConfig1AsInteger('Diasdevolucao') > 0 then
    Di:=Sistema.Hoje-FGeral.GetConfig1AsInteger('Diasdevolucao');
  Df:=Sistema.Hoje;
  sqlconfmov:='';
  if FGeral.ConfiguradoECF then
    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));
  if xEs='S' then
    sqles:=' and '+FGeral.GetIN('moes_tipomov',Global.TiposSaida,'C')
  else
    sqles:=' and '+FGeral.GetIN('moes_tipomov',Global.TiposEntrada,'C');
  tiposnao:=Global.TiposNaoFiscal+';'+Global.CodPrestacaoServicos+';'+Global.CodVendaInterna;
  tiposdemovimento:=Global.TiposSaida;
  Q:=sqltoquery('select * from movesto'+
                ' where moes_datamvto>='+Datetosql(Di)+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+Datetosql(Df)+
                ' and moes_unid_codigo='+EdUnid_origem.assql+
                 sqlconfmov+
                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
///////////////////////                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                sqlexp+sqles+
                ' order by moes_dataemissao desc' );
  if not Q.eof then
    TLista.Add('Transa��o     | Emiss�o   | Numero |       Valor       | Raz�o Social'+space(25) );
  while not Q.eof do begin
    TLista.Add(strspace(Q.fieldbyname('moes_transacao').asstring,12)+' | '+
               FGeral.FormataData( Q.fieldbyname('moes_dataemissao').asdatetime )+' | '+
               strzero( Q.fieldbyname('moes_numerodoc').asinteger ,6)+' | '+
               FGeral.Formatavalor(Q.fieldbyname('moes_vlrtotal').ascurrency,f_cr)+' | '+
//               Q.fieldbyname('moes_chavenfe').asstring+' | '+
               FGeral.GetNomeRazaoSocialEntidade( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring,'R') );
    Q.Next;
  end;
  FGeral.FechaQuery(Q);

end;

procedure TFNotaTransf.bGravarClick(Sender: TObject);
///////////////////////////////////////////////////////
var Numero,x:integer;
    valorcomissao:currency;
    natentrada,TipoMovimento1,TipoMovimento2:string;
    movimentochu:TDatetime;
    Lista:TStringList;

    // 06.10.11
    function PedeImpressao:boolean;
    ///////////////////////////////
    begin
       result:=true;
       if Global.Topicos[1349] then
         result:=true
       else if (Global.UsaNfe='S') and ( not EdDtMovimento.IsEmpty ) then
         result:=false
// 27.04.18
       else if EdDtMovimento.IsEmpty  then
         result:=true
    end;

begin
////////////////
   if not EdUnid_destino.validfind then exit;
   if not EdUnid_origem.validfind then exit;
   if not EdComv_codigo.valid then begin
     Avisoerro('Checar codigo de movimento');
     exit;
   end;
   if (Grid.RowCount<=1)then exit;

   if confirma('Confirma grava��o ?') then begin

      Sistema.beginprocess('');
      ListaReservaCodigo.Clear;
      ListaReservaQtde.Clear;
      movimentochu:=EdDtmovimento.asdate;
      if OP='I' then begin
        Sistema.BeginTransaction('Gravando');
        if (Movimentochu<=1) then
          Numero:=FGeral.GetContador('SAIDA'+EdUNid_Origem.text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false,false)+1
        else
//          Numero:=FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false);
// 06.06.05 - Walmir deu a dica
          Numero:=FGeral.GetContador('NFSAIDA'+EdUNid_Origem.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,false)+1;
// 19.03.07 - numera�ao liberada para digitar entao ja esta em ednumerodoc o numero certo...
         if not Global.Topicos[1301] then
            EdNumerodoc.Text:=inttostr(Numero)
         else begin
// 15.05.07
            Numero:=EdNumerodoc.asinteger;
            FGeral.AlteraContador('NFSAIDA'+EdUNid_Origem.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade),Numero);
         end;

        Transacao:=FGeral.GetTransacao;                                     // indica a saida
// 05.12.05
        if  EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodTransfSaida then begin
          TipoMovimento1:=Global.CodTransfSaida;
          TipoMovimento2:=Global.CodTransfEntrada;
        end else if  EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodTransfSaidaTempo then begin
          TipoMovimento1:=Global.CodTransfSaidaTempo;
          TipoMovimento2:=Global.CodTransfEntradaTempo;
// 06.02.06
        end else if  EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodTransfSaiRetTempo then begin
          TipoMovimento1:=Global.CodTransfSaiRetTempo;
          TipoMovimento2:=Global.CodTransfEntRetTempo;
// 31.03.06
        end else if  EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring=Global.CodTransMatConsumoS then begin
          TipoMovimento1:=Global.CodTransMatConsumoS;
          TipoMovimento2:=Global.CodTransMatConsumoE;
        end else if (EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodTransfSaida) and
           (EdComv_codigo.resultfind.fieldbyname('comv_tipomovto').asstring<>Global.CodTransfEntrada) then begin
          TipoMovimento1:=Global.CodTransImob;
          TipoMovimento2:=Global.CodTransImobE;
        end;

        Sistema.beginprocess('Gravando mestre unidade origem');
        FGeral.GravaMestreNFTrans(EdDtEmissao.AsDate,EdUNid_Destino,EdUnid_origem.text,'S',
               TipoMovimento1,Transacao,
               EdNatf_codigo.text,EdEmides.text,EdEspecievolumes.text,Numero,EdComv_codigo.asinteger,EdQtdevolumes.asinteger,
               EdTotalNOta.AsCurrency,EdBaseicms.ascurrency,EdValoricms.ascurrency,EdBasesubs.ascurrency,EdValorsubs.ascurrency,EdFrete.ascurrency,
               EdPesoLiq.ascurrency,EdPesoBru.ascurrency,EdUnid_origem.resultfind.fieldbyname('unid_simples').asstring,
               Movimentochu,EdMensagem.text,EdTran_codigo.text,EdPedidos.text,Edpertransf.ascurrency,EdRomaneio.Text,EdFornec);

        Sistema.beginprocess('Gravando detalhe unidade origem');
        FGeral.GravaItensNFTrans(EdDtEmissao.AsDate,EdUnid_destino,EdUnid_origem.text,'S',
               TipoMovimento1,Transacao,Numero,Grid,EdFRete.ascurrency,EdSEguro.ascurrency,EdUnid_origem.resultfind.fieldbyname('unid_simples').asstring,
               Movimentochu,EdPedidos.text,EdRomaneio.Text,EdFornec);

        if copy(EdNatf_codigo.text,1,1)='5' then
          natentrada:='1'+copy(EdNatf_codigo.text,2,4)
        else if copy(EdNatf_codigo.text,1,1)='6' then
          natentrada:='2'+copy(EdNatf_codigo.text,2,4)
        else
          natentrada:='3'+copy(EdNatf_codigo.text,2,4);

        Sistema.beginprocess('Gravando mestre unidade destino');
        FGeral.GravaMestreNFTrans(EdDtEmissao.AsDate,EdUNid_Destino,EdUnid_origem.text,'E',
               TipoMovimento2,Transacao,
               natentrada,EdEmides.text,EdEspecievolumes.text,Numero,EdComv_codigo.asinteger,EdQtdevolumes.asinteger,
               EdTotalNOta.AsCurrency,EdBaseicms.ascurrency,EdValoricms.ascurrency,EdBasesubs.ascurrency,EdValorsubs.ascurrency,EdFrete.ascurrency,
               EdPesoLiq.ascurrency,EdPesoBru.ascurrency,EdUnid_destino.resultfind.fieldbyname('unid_simples').asstring,
               movimentochu,EdMensagem.text,EdTran_codigo.text,EdPedidos.text,edPertransf.ascurrency,EdRomaneio.Text,EdFornec);

        Sistema.beginprocess('Gravando detalhe unidade destino');
        FGeral.GravaItensNFTrans(EdDtEmissao.AsDate,EdUnid_destino,EdUnid_origem.text,'E',
               TipoMovimento2,Transacao,Numero,Grid,EdFRete.ascurrency,EdSEguro.ascurrency,
               EdUnid_destino.resultfind.fieldbyname('unid_simples').asstring,movimentochu,EdPedidos.text,EdRomaneio.Text,EdFornec);

        Sistema.EndTransaction('');
// 21.09.11 - para 'nao perder numeracao'
        if (Movimentochu<=1) then
          Numero:=FGeral.GetContador('SAIDA'+Edunid_origem.text+EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,false,true)
        else
          Numero:=FGeral.GetContador('NFSAIDA'+Edunid_origem.text+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true);
// 24.03.14 - vivan
      if (trim(Edromaneio.text)<>'') and ( not EdFornec.isempty ) then begin
        Lista:=TStringList.create;
        strtolista(Lista,Edromaneio.text,';',true);
        for x:=0 to Lista.Count-1 do begin
          if trim(Lista[x])<>'' then begin
            Sistema.Edit('movabate');
            Sistema.SetField('mova_notagerada',Numero);
            Sistema.SetField('mova_transacaogerada',Transacao);
            Sistema.Post(FGeral.GetIN('mova_numerodoc',Lista[x],'N')+
                         ' and mova_status=''N'''+
                         ' and mova_tipomov='+Stringtosql(TipoEntradaAbate)+
                         ' and mova_unid_codigo='+stringtosql(Edunid_destino.text)+
                         ' and mova_transacaogerada='+stringtosql('')+
                         ' and mova_tipo_codigo='+EdFornec.Assql);
          end;
        end;
        Sistema.commit;
      end;

        if PedeIMpressao then
          FImpressao.ImprimeNotaTransf(Numero,EdDtEmissao.AsDate,EdUnid_origem.text);

        EdComv_codigo.ClearAll(FNotaTransf,99);
        EdProduto.clearall(FNotaTransf,99);
        Grid.Clear;
        EdBaseicms.ClearAll(FNotaTransf,99);
// 11.08.05
        EdDtEmissao.SetDate(Sistema.hoje);
        EdDtSaida.SetDate(Sistema.hoje);


      end;
//       else if OP='A' then begin
//        FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
//               Global.CodRemessaConsig,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger);
//        Sistema.Commit;
     if ListaProdutos<>nil then
       Freeandnil(ListaProdutos);
     Sistema.endprocess('');
   end;

   EdComv_codigo.setfocus;
end;

procedure TFNotaTransf.EdUnid_destinoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.LImpaedit(EdUnid_destino,key);
end;

procedure TFNotaTransf.Edunid_origemKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.LImpaedit(EdUnid_origem,key);

end;

procedure TFNotaTransf.EdDtMovimentoValidate(Sender: TObject);
begin
  bIncluiritemClick(FNotaTransf);

end;

procedure TFNotaTransf.EdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then begin
    bcancelaritemclick(FNotaTransf);
    bgravarclick(FNotaTransf);
  end;
end;

procedure TFNotaTransf.EdTran_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.limpaedit(EdTran_codigo,key);
end;

function TFNotaTransf.BuscaItem(produto:string): integer;
var y:integer;
    achou:boolean;
begin
// 11.08.05
  result:=-1;
  for y:=0 to LIstaProdutos.count-1 do begin
    PProdutos:=listaprodutos[y];
    if Pprodutos.codigo=Produto then begin
      result:=y+1;   // pois o ponteiro come�a em 0...
      break;
    end;
  end;

end;

procedure TFNotaTransf.Edmens_codigoValidate(Sender: TObject);
begin
  if not Arq.TMensagensNF.active then Arq.TMensagensNF.open;
  if Edmens_codigo.asinteger>0 then begin
    if not Arq.Tmensagensnf.locate('mens_codigo',Edmens_codigo.text,[]) then
       Edmens_codigo.invalid('Codigo de mensagem n�o encontrado')
    else begin
       if (Edmensagem.isempty) or (Edmens_codigo.text<>EdMens_codigo.oldvalue) then
         EdMensagem.text:=Arq.Tmensagensnf.fieldbyname('mens_descricao').asstring;
    end;
  end;

end;

procedure TFNotaTransf.EdNumeroDocValidate(Sender: TObject);
begin
   if Edcomv_codigo.ResultFind.FieldByName('comv_tipomovto').asstring=Global.CodTransfSaiRetTempo then begin
     sistema.beginprocess('Procurando nota de envio da mercadoria tipo '+Global.CodTransfSaidaTempo);
     QBuscanota:=sqltoquery('select * from movestoque inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                            ' where move_status=''N'' and '+FGeral.getin('move_tipomov',Global.CodTransfSaidaTempo,'C')+
                            ' and move_numerodoc='+EdNumerodoc.assql+
                            ' and move_unid_codigo='+EdUnid_destino.assql+
                            ' and move_datamvto>='+Datetosql(Database) );
     if not QBuscanota.eof then begin
           Campostoedits(QbuscaNOta);
           Campostogrid(QbuscaNota);
//           EdUnid_origem.ValidFind;
//           EdUnid_destino.ValidFind;
//           EdComv_codigo.ValidFind;
//           Arq.TConfMovimento.locate('comv_codigo',Edcomv_codigo.Text,[]);
     end else
       EdNumerodoc.invalid('Nota n�o encontrada desde '+FGeral.formatadata(database));

     sistema.endprocess('');
   end;
end;

procedure TFNotaTransf.Campostoedits(Q: TSqlquery);
var p:integer;
begin

//  EdUnid_codigo.Text:=Q.fieldbyname('moes_unid_codigo').AsString;
//  EdDtEmissao.SetDate(Q.fieldbyname('moes_dataemissao').AsDateTime);
  EdTotalNota.SetValue(Q.fieldbyname('moes_vlrtotal').AsCurrency);
  EdTotalProdutos.SetValue(Q.fieldbyname('moes_totprod').AsCurrency);
//  EdNatf_codigo.text:=Q.fieldbyname('moes_natf_codigo').AsString;
//  EdNatf_descricao.Text:=FNatureza.GetDescricao(Q.fieldbyname('moes_natf_codigo').Asstring);
// 20.08.05 - notas de pronta entrega e regime especial gravada sem conf. de movimento
//  EdSeguro.setvalue(Q.fieldbyname('moes_seguro').AsCurrency);

//  EdDtSaida.setdate(Q.fieldbyname('moes_dataemissao').Asdatetime);
//  EdDtMovimento.setdate(Q.fieldbyname('moes_datacont').Asdatetime);
  EdDtEmissao.SetDate(Sistema.hoje);
  EdDtSaida.SetDate(Sistema.hoje);
  EdDtMovimento.setdate(Sistema.hoje);

  EdQtdevolumes.setvalue(Q.fieldbyname('moes_qtdevolume').Asinteger);
  EdEspecievolumes.text:=(Q.fieldbyname('moes_especievolume').Asstring);
  EdBaseicms.setvalue(Q.fieldbyname('moes_baseicms').AsCurrency);
  EdValoricms.setvalue(Q.fieldbyname('moes_valoricms').AsCurrency);
  EdBasesubs.setvalue(Q.fieldbyname('moes_basesubstrib').AsCurrency);
  EdValorsubs.setvalue(Q.fieldbyname('moes_valoricmssutr').AsCurrency);
//  Transacao:=Q.fieldbyname('moes_transacao').asstring;
//  StatusNota:=Q.fieldbyname('moes_status').asstring;
  Edmensagem.text:='Devolu��o ref. nf '+EdNumerodoc.text;
// 15.11.05
//  EdPesoliq.setvalue(Q.fieldbyname('moes_pesoliq').ascurrency);
//  EdPesobru.setvalue(Q.fieldbyname('moes_pesobru').ascurrency);
// 30.12.05 - devido a altera��o das vendas do reg. especial ( VN )
//  Moes_clie_codigo:=Q.fieldbyname('moes_clie_codigo').Asinteger;


end;

procedure TFNotaTransf.Campostogrid(Q: TSqlquery);
///////////////////////////////////////////////////////////////////
var p,
    x       :integer;
    achou   : boolean;

begin

  Grid.Clear;p:=1;Q.First;

  while not Q.Eof do begin

    Grid.Cells[Grid.getcolumn('move_esto_codigo'),p]:=Q.fieldbyname('move_esto_codigo').Asstring;
    Grid.Cells[Grid.GetColumn('esto_descricao'),p]:=FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').Asstring);
//    Grid.Cells[Grid.GetColumn('move_cst'),p]:=Q.fieldbyname('move_cst').Asstring;

    Grid.Cells[Grid.getcolumn('move_cst'),p]:=CstTransferencia;
// 29.10.20
    if Global.topicos[1474] then begin

       Grid.Cells[Grid.Getcolumn('move_cst'),p]:= FEstoque.Getsituacaotributaria(Q.fieldbyname('move_esto_codigo').Asstring,EdUNid_Origem.text,EdUNid_Origem.Resultfind.fieldbyname('unid_uf').asstring) ;

//       if Global.usuario.codigo=100 then begin
//
//          aviso( Q.fieldbyname('move_esto_codigo').Asstring+'|'+EdUNid_Origem.text+'|'+EdUNid_Origem.Resultfind.fieldbyname('unid_uf').asstring );
//
//       end;

    end;
//    Grid.Cells[Grid.GetColumn('Move_aliicms'),p]:=transform(Q.fieldbyname('move_aliicms').Ascurrency,'#0.0');
    Grid.Cells[Grid.GetColumn('Move_aliicms'),p]:=transform(0,'#0.0');
    Grid.Cells[Grid.GetColumn('esto_unidade'),p]:=Arq.TEstoque.fieldbyname('esto_unidade').asstring;
    Grid.Cells[Grid.GetColumn('move_qtde'),p]:=transform(Q.fieldbyname('move_qtde').Ascurrency,f_qtdestoque);
    Grid.Cells[Grid.GetColumn('move_venda'),p]:=TRansform(Q.fieldbyname('move_venda').Ascurrency,f_cr);
    Grid.Cells[Grid.GetColumn('totalunitario'),p]:=TRansform(Q.fieldbyname('move_qtde').Ascurrency*Q.fieldbyname('move_venda').Ascurrency,f_cr);
//    Grid.Cells[Grid.getcolumn('move_remessas'),p]:=Q.fieldbyname('move_remessas').Asstring;
    inc(p);
    Grid.AppendRow;

// 23.10.20 - Novicarnes - puxando valores de nf de entrada
    achou:=false;
    for x:=0 to LIstaProdutos.count-1 do begin
      PProdutos:=listaprodutos[x];
      if Pprodutos.codigo=Q.fieldbyname('move_esto_codigo').Asstring then begin
        achou:=true;
        break;
      end;
    end;
    if not achou then begin
      New(PProdutos);
      PProdutos.codigo:=Q.fieldbyname('move_esto_codigo').Asstring;
      PProdutos.qtde:=Q.fieldbyname('move_qtde').Ascurrency;
      PProdutos.unitario:=Q.fieldbyname('move_venda').Ascurrency;
      PProdutos.totalitem:=Q.fieldbyname('move_qtde').Ascurrency*Q.fieldbyname('move_venda').Ascurrency;
      PProdutos.pericms:=FEstoque.Getaliquotaicms(Q.fieldbyname('move_esto_codigo').Asstring,Edunid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring);
      PProdutos.codtamanho:=EdCodtamanho.asinteger;
      PProdutos.codcor:=EdCodcor.asinteger;
      if (EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring='SC') and
         (EdUNid_origem.resultfind.fieldbyname('unid_uf').asstring=EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring) then begin
        PProdutos.pericms:=0;
      end;
      PProdutos.reducaobase:=Q.fieldbyname('move_redubase').Ascurrency;
      ListaProdutos.add(PProdutos);
    end else begin
      PProdutos.qtde:=PProdutos.qtde+EdQtde.asfloat;
      PProdutos.totalitem:=PProdutos.totalitem+(EdUnitario.asFloat*EdQtde.asfloat);
    end;


    Q.Next;

  end;
end;

procedure TFNotaTransf.EdPedidosValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
var QPedidos:TSqlquery;
    ListaPedidos,Lista:tstringlist;
    p,x:integer;
    achou:boolean;

    procedure QuerytoGrid;
    var x:integer;
        achou:boolean;
        xqtde,xtotalunitario,custotrans:currency;
    begin
      x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING,Grid,
                            Grid.getcolumn('move_tama_codigo'),QPedidos.fieldbyname('mpdd_tama_codigo').asinteger,
                            Grid.getcolumn('move_core_codigo'),QPedidos.fieldbyname('mpdd_core_codigo').asinteger );
      if x<=0 then begin
        if (Grid.RowCount=2) and (Trim(Grid.Cells[0,1])='') then begin
           x:=1;
        end else begin
           Grid.RowCount:=Grid.RowCount+1;
           x:=Grid.RowCount-1;
        end;
        Grid.Cells[Grid.getcolumn('move_esto_codigo'),Abs(x)]:=QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING;
        Grid.Cells[Grid.getcolumn('esto_descricao'),Abs(x)]:=FEstoque.GetDescricao(QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING);

        Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=CstTransferencia;
// 24.11.20
        if Global.topicos[1474] then

            Grid.Cells[Grid.Getcolumn('move_cst'),Abs(x)]:= FEstoque.Getsituacaotributaria(QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING,EdUNid_Origem.text,EdUNid_Origem.Resultfind.fieldbyname('unid_uf').asstring) ;

        Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=currtostr(FEstoque.Getaliquotaicms(QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING,Edunid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring));
        if (EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring='SC') and
           (EdUNid_origem.resultfind.fieldbyname('unid_uf').asstring=EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring) then begin
          Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=Global.CstTransferenciaSC;
          Grid.Cells[Grid.getcolumn('move_aliicms'),Abs(x)]:=currtostr(0);
        end;
        Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=FTamanhos.Getdescricao(QPedidos.fieldbyname('mpdd_tama_codigo').ASInteger);
        Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=Fcores.Getdescricao(QPedidos.fieldbyname('mpdd_core_codigo').ASInteger);
        Grid.Cells[Grid.getcolumn('esto_unidade'),Abs(x)]:=FEstoque.GetUnidade(QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING);
        Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=QPedidos.fieldbyname('mpdd_qtdeenviada').AsString;
        if EdDtmovimento.asdate>1 then
          custotrans:=FEstoque.GetCusto(QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING,global.unidadematriz,'medio')
        else
          custotrans:=FEstoque.GetCusto(QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING,global.unidadematriz,'gerencial');
        Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=floattostr(custotrans);
        Grid.Cells[Grid.getcolumn('totalunitario'),Abs(x)]:=TRansform(QPedidos.fieldbyname('mpdd_qtdeenviada').AsCurrency*custotrans,f_cr);
        Grid.Cells[Grid.getcolumn('precovenda'),Abs(x)]:=TRansform(custotrans,f_cr);
//        Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=QPedidos.fieldbyname('mpdd_venda').AsString;
//        Grid.Cells[Grid.getcolumn('totalunitario'),Abs(x)]:=TRansform(QPedidos.fieldbyname('mpdd_qtdeenviada').AsCurrency*QPedidos.fieldbyname('mpdd_venda').AsCurrency,f_cr);
//        Grid.Cells[Grid.getcolumn('precovenda'),Abs(x)]:=TRansform(Festoque.GetPreco(QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING,EdUnid_origem.text),f_cr);
        Grid.Cells[Grid.getcolumn('move_tama_codigo'),Abs(x)]:=QPedidos.fieldbyname('mpdd_tama_codigo').ASSTRING;
        Grid.Cells[Grid.getcolumn('move_core_codigo'),Abs(x)]:=QPedidos.fieldbyname('mpdd_core_codigo').ASSTRING;
        New(PProdutos);
        PProdutos.codigo:=QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING;
        PProdutos.qtde:=QPedidos.fieldbyname('mpdd_qtdeenviada').ascurrency;
        PProdutos.unitario:=custotrans;
//        PProdutos.unitario:=QPedidos.fieldbyname('mpdd_venda').ascurrency;
        PProdutos.pericms:=FEstoque.Getaliquotaicms(QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING,Edunid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring);
        if (EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring='SC') and
           (EdUNid_origem.resultfind.fieldbyname('unid_uf').asstring=EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring) then begin
          PProdutos.pericms:=0;
        end;
        PProdutos.codtamanho:=QPedidos.fieldbyname('mpdd_tama_codigo').ASInteger;
        PProdutos.codcor:=QPedidos.fieldbyname('mpdd_core_codigo').ASInteger;
        ListaProdutos.add(PProdutos);
      end else begin
        xqtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]);
        if EdDtmovimento.asdate>1 then
          custotrans:=FEstoque.GetCusto(QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING,global.unidadematriz,'medio')
        else
          custotrans:=FEstoque.GetCusto(QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING,global.unidadematriz,'gerencial');
        xtotalunitario:=texttovalor(Grid.Cells[Grid.getcolumn('totalunitario'),Abs(x)]) + (QPedidos.fieldbyname('mpdd_qtdeenviada').AsCurrency*custotrans);
//        xtotalunitario:=texttovalor(Grid.Cells[Grid.getcolumn('totalunitario'),Abs(x)]) + (QPedidos.fieldbyname('mpdd_qtdeenviada').AsCurrency*QPedidos.fieldbyname('mpdd_venda').AsCurrency);
        Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=floattostr(QPedidos.fieldbyname('mpdd_qtdeenviada').AsInteger+xqtde);
        Grid.Cells[Grid.getcolumn('totalunitario'),Abs(x)]:=floattostr(xtotalunitario);
        achou:=false;
        for x:=0 to LIstaProdutos.count-1 do begin
          PProdutos:=listaprodutos[x];
          if (Pprodutos.codigo=QPedidos.fieldbyname('mpdd_esto_codigo').ASSTRING) and (Pprodutos.codtamanho=QPedidos.fieldbyname('mpdd_tama_codigo').ASInteger)
            and (Pprodutos.codcor=QPedidos.fieldbyname('mpdd_core_codigo').ASInteger) then begin
            achou:=true;
            break;
          end;
        end;
        if achou then
          PProdutos.qtde:=PProdutos.qtde+QPedidos.fieldbyname('mpdd_qtdeenviada').ascurrency;

      end;

    end;


begin

  if EdPedidos.isempty then exit;
  if pos('/',EdPedidos.text)>0 then begin
    EdPedidos.invalid('Caracter / n�o permitido');
    exit;
  end;
  if pos('.',EdPedidos.text)>0 then begin
    EdPedidos.invalid('Caracter . n�o permitido');
    exit;
  end;
  if pos('\',EdPedidos.text)>0 then begin
    EdPedidos.invalid('Caracter \ n�o permitido');
    exit;
  end;
  if pos(',',EdPedidos.text)=0 then begin
    EdPedidos.invalid('Obrigat�rio colocar v�rgula no final ou entre os numeros de pedidos');
    exit;
  end;
  QPedidos:=sqltoquery('select * from movpeddet where '+FGeral.GetIn('mpdd_numerodoc',EdPedidos.text,'N')+
                       ' and mpdd_status=''N'' and mpdd_situacao=''E'' and mpdd_qtdeenviada>0'+
                       ' and '+FGeral.Getin('mpdd_unid_codigo',EdUnid_origem.text+';'+EdUnid_destino.text,'C')+
                       ' and ( (mpdd_nftrans=0) or (mpdd_nftrans is null) )'+
                       ' order by mpdd_numerodoc');
  ListaPedidos:=Tstringlist.create;
  Grid.clear;
  if not QPedidos.eof then begin
    ListaProdutos.Clear;
    Sistema.beginprocess('Pesquisando Pedidos');
    ListaPedidos.Clear;
    while not QPedidos.eof do begin
      QuerytoGrid;
      if ListaPedidos.indexof(QPedidos.fieldbyname('mpdd_numerodoc').AsString)=-1 then
        ListaPedidos.add(QPedidos.fieldbyname('mpdd_numerodoc').AsString);
      QPedidos.Next;
    end;
    Lista:=Tstringlist.create;
    strtolista(Lista,EdPedidos.text,',',true);
    for p:=0 to LIsta.count-1 do begin
      if (trim(lista[p])<>'') then begin
        achou:=false;
        for x:=0 to LIstaPedidos.count-1 do begin
          if (LIstapedidos[x]=Lista[p])  then begin
            achou:=true;
            break;
          end;
        end;
        if not achou then
          Avisoerro('Pedido '+lista[p]+' ainda n�o atendido, inexistente ou transf. j� feita n�o ser� usado');
      end;
    end;

    SetaEditsvalores;
    Sistema.endprocess('');
    EdNatf_codigo.setfocus;
  end else
    Avisoerro('Pedido de venda n�o atendido, inexistente ou j� feito nota de transfer�ncia');
  FGeral.Fechaquery(QPedidos);
end;

procedure TFNotaTransf.Edunid_origemValidate(Sender: TObject);
begin
   if pos(EdUNid_origem.text,Global.Usuario.UnidadesMvto)=0 then
     EdUNid_origem.invalid('Usu�rio sem autoriza��o para movimentar esta unidade');


end;

procedure TFNotaTransf.EdProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=18 then
    Aviso('Enter pra retornar ao programa');

end;

procedure TFNotaTransf.bgeranfeClick(Sender: TObject);
begin
  if Global.Topicos[1020] then
    FExpNfetxt.Execute( EdNumerodoc.AsInteger )
  else
    FExpNfetxt.Execute;

end;

procedure TFNotaTransf.EdFornecValidate(Sender: TObject);
//////////////////////////////////////////////////////////////
var Qroma:TSqlquery;
begin
  if not EdFornec.IsEmpty then begin
    QRoma:=sqltoquery('select * from movabate '+
                      ' where mova_tipo_codigo='+EdFornec.assql+' and mova_status=''N'''+
                      ' and ( mova_notagerada=0 or mova_notagerada is null )'+
                      ' and '+FGeral.Getin('mova_situacao','N;P','C')+
                      ' and mova_tipomov='+stringtosql(TipoEntradaAbate)+
                      ' order by mova_dtabate');
    EdRomaneio.Items.Clear;
    while not QRoma.eof do begin
      EdRomaneio.Items.Add( strzero(QRoma.fieldbyname('mova_numerodoc').asinteger,8)+' - '+FGeral.formatadata(QRoma.fieldbyname('mova_datacont').asdatetime) );
      QRoma.Next
    end;
    FGeral.FechaQuery(QRoma);
  end;
end;

procedure TFNotaTransf.EdRomaneioValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
type TProdutosro=record
  produto:string;
  pesocarcaca,pesovivo,valortotal:currency;
// 19.06.20
//  vlrunitario,valortotal:extended;
  vlrunitario:extended;
  pecas:integer;
end;

var p,x:integer;
    Lista:Tlist;
    PProdutosro:^Tprodutosro;
    pesovivozerado,achou:boolean;
var QRoma:TSqlquery;


     procedure AtualizaLista;
     //////////////////////////
     var i:integer;
         achou:boolean;
         unitario:extended;
     begin
       achou:=false;
       for i:=0 to Lista.count-1 do begin
         PProdutosro:=Lista[i];
         if PProdutosro.produto=QRoma.fieldbyname('movd_esto_codigo').AsString then begin
           achou:=true;
           break;
         end;
       end;
       if QRoma.fieldbyname('movd_pesovivo').Ascurrency=0 then
         pesovivozerado:=true;

       if not achou then begin
          New(PProdutosro);
          PProdutosro.produto:=QRoma.fieldbyname('movd_esto_codigo').AsString;
          PProdutosro.pesocarcaca:=QRoma.fieldbyname('movd_pesocarcaca').Ascurrency;
          PProdutosro.pesovivo:=QRoma.fieldbyname('movd_pesovivo').Ascurrency;
//          PProdutos.vlrunitario:=QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15;
// 16.01.08
//          PProdutosro.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),6);
// 23.08.18 - xml 4.0
//          PProdutosro.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),4);
// 19.06.20
//          PProdutosro.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),2);
//          PProdutosro.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),3);
//          PProdutosro.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),4);
          PProdutosro.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),5);

// 21.09.16
//          if (Edpertransf.ascurrency>0) and (Edpertransf.ascurrency<>100) then
//             PProdutosro.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),6) *
//                                      ( EdPertransf.ascurrency/100 );
// 23.08.18
          if (Edpertransf.ascurrency>0) and (Edpertransf.ascurrency<>100) then
             PProdutosro.vlrunitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),4) *
                                      ( EdPertransf.ascurrency/100 );

          PProdutosro.valortotal:=QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*PProdutosro.vlrunitario;
          PProdutosro.pecas:=1;
          Lista.Add(PProdutosro);

       end else begin

          PProdutosro.pesovivo:=PProdutosro.pesovivo+QRoma.fieldbyname('movd_pesovivo').Ascurrency;
          PProdutosro.pesocarcaca:=PProdutosro.pesocarcaca+QRoma.fieldbyname('movd_pesocarcaca').Ascurrency;
//          PProdutos.valortotal:=PProdutos.valortotal+(QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*(QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15));
//          PProdutos.valortotal:=PProdutos.valortotal+(QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*(QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15));
// 16.01.7
{
          if (Edpertransf.ascurrency>0) and (Edpertransf.ascurrency<>100) then
             unitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),6) *
                                          ( EdPertransf.ascurrency/100 )
          else
             unitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),6);
}
// 23.08.18
          if (Edpertransf.ascurrency>0) and (Edpertransf.ascurrency<>100) then
             unitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),4) *
                                          ( EdPertransf.ascurrency/100 )
          else
             unitario:=FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),4);


//          PProdutosro.valortotal:=PProdutosro.valortotal+(QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*(FGeral.Arredonda((QRoma.fieldbyname('movd_vlrarroba').Ascurrency/15),6)));
// 11.10.16
          PProdutosro.valortotal:=PProdutosro.valortotal+(QRoma.fieldbyname('movd_pesocarcaca').Ascurrency*unitario);

          PProdutosro.vlrunitario:=PProdutosro.valortotal/PProdutosro.pesocarcaca;
          PProdutosro.pecas:=PProdutosro.pecas+1;
       end;
     end;

     procedure IncluiGrid(x:integer);
     //////////////////////////////////
     var codigosit:integer;
     begin
        Grid.Cells[Grid.Getcolumn('move_esto_codigo'),x]:=PProdutosro.produto;
        Grid.Cells[Grid.Getcolumn('move_tama_codigo'),x]:='';
        Grid.Cells[Grid.Getcolumn('move_core_codigo'),x]:='';
        Grid.Cells[Grid.Getcolumn('cor'),Abs(x)]:='';
        Grid.Cells[Grid.Getcolumn('tamanho'),Abs(x)]:='';
        Grid.Cells[Grid.Getcolumn('esto_descricao'),x]:=FEstoque.GetDescricao(PProdutosro.produto);

        Grid.Cells[Grid.Getcolumn('move_cst'),Abs(x)]:=CstTransferencia;
// 24.11.20
       if Global.topicos[1474] then

          Grid.Cells[Grid.Getcolumn('move_cst'),Abs(x)]:= FEstoque.Getsituacaotributaria(PProdutosro.produto,EdUNid_Origem.text,EdUNid_Origem.Resultfind.fieldbyname('unid_uf').asstring) ;

        Grid.Cells[Grid.Getcolumn('move_aliicms'),Abs(x)]:=currtostr(FEstoque.Getaliquotaicms(PProdutosro.produto,Edunid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring));

        Grid.Cells[Grid.Getcolumn('move_aliipi'),x]:=transform(0,'#0.0');
        Grid.Cells[Grid.Getcolumn('esto_unidade'),x]:=FEstoque.GetUnidade(PProdutosro.produto);
          Grid.Cells[Grid.Getcolumn('move_qtde'),x]:=transform(PProdutosro.pesocarcaca,f_qtdestoque);
          Grid.Cells[Grid.Getcolumn('qtdeprev'),x]:=transform(PProdutosro.pesocarcaca,f_qtdestoque);
          Grid.Cells[Grid.Getcolumn('valoruni'),x]:=transform(PProdutosro.vlrunitario,'##,##0.000000');
          Grid.Cells[Grid.Getcolumn('move_venda'),x]:=TRansform(PProdutosro.vlrunitario,'##,##0.000000');
          Grid.Cells[Grid.Getcolumn('total'),x]:=TRansform(PProdutosro.valortotal,f_cr);
        Grid.Cells[13,x]:=Transform(0,f_cr);  // margemlucro
//        margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(PProdutos.produto,EdUnid_codigo.text,QFornec.fieldbyname(campoufentidade).asstring));
        codigosit:=FEstoque.GetCodigosituacaotributaria(PProdutosro.produto,EdUnid_destino.text,Edfornec.resultfind.fieldbyname('clie_uf').asstring);
        Grid.Cells[14,x]:=inttostr(codigosit);
        Grid.Cells[15,x]:='';
        Grid.Cells[Grid.Getcolumn('move_pecas'),x]:=INttostr(PProdutosro.pecas);
// 10.10.09 - - NF Reclassificacao
        Grid.Cells[Grid.Getcolumn('pesovivo'),x]:=transform(PProdutosro.pesovivo,f_qtdestoque);
        Grid.Cells[Grid.Getcolumn('pesocarcaca'),x]:=transform(PProdutosro.pesocarcaca,f_qtdestoque);
        Grid.AppendRow;
     end;

     function ChecaRomaneios:boolean;
     /////////////////////////////////
     var i:integer;
         lista:tstringlist;
         Q:TSqlquery;
         comdata,semdata:boolean;
     begin
       lista:=Tstringlist.create;
       comdata:=false;semdata:=false;
       strtolista(lista,EdRomaneio.Text,';',true);
       result:=true;
       if Lista.count>1 then begin
          for i:=0 to Lista.count-1 do begin
            if trim(lista[i])<>'' then begin
              Q:=sqltoquery('select mova_datacont from movabate where mova_numerodoc='+lista[i]+' and mova_status=''N'''+
                            ' and mova_unid_codigo='+EdUnid_destino.assql+' and mova_tipomov='+stringtosql(TipoEntradaAbate));
              if not Q.eof then begin
                if Q.fieldbyname('mova_datacont').asdatetime>1 then
                  comdata:=true
                else
                  semdata:=true;
              end;
              FGeral.FechaQuery(Q);
            end;
          end;
          if (comdata) and (semdata) then begin
            Avisoerro('N�o � permitido escolher entradas de tipos diferentes');
            result:=false;
          end;
       end;
       lista.free;
     end;


begin
/////////////////
  if (not EdRomaneio.IsEmpty) and (not EdFornec.IsEmpty) then begin
      QRoma:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao ) '+
                          ' where '+FGeral.GetIN('mova_numerodoc',EdRomaneio.text,'N')+
                          ' and movd_status=''N'''+
                          ' and movd_tipomov='+stringtosql(TipoEntradaAbate)+
                          ' and '+FGeral.Getin('mova_situacao','N;P','C')+
                          ' and mova_tipo_codigo='+EdFornec.assql+
                          ' and ( mova_notagerada=0 or mova_notagerada is null )'+
                          ' order by movd_esto_codigo');
      if QRoma.eof then
        EdRomaneio.invalid('Entrada n�o encontrada ou com nota de produtor j� feita')
      else begin
        Grid.clear;
        Lista:=TList.create;
        EdDtMovimento.SetDate(QRoma.fieldbyname('mova_datacont').asdatetime);
        pesovivozerado:=false;
        while not QRoma.eof do begin
          AtualizaLista;
          QRoma.Next;
        end;
        if (pesovivozerado) and (Global.Topicos[1337] ) then
          EdRomaneio.Invalid('Produto com peso vivo zerado no romaneio.')
        else begin
//       ver se precisa para configurar o CST(codigo) e aliquota de icms(codigo) dentro e fora do estado para entrada de produtor
// joga no grid totalizando por codigo
          x:=1;
          for p:=0 to Lista.count-1 do begin
            PProdutosro:=Lista[p];
            Incluigrid(p+1);
          end;
// atualiza lista para o grid...
///////////////////////////

          ListaProdutos.Clear;
          for p:=0 to Lista.count-1 do begin
            achou:=false;
            PProdutosro:=Lista[p];
            for x:=0 to LIstaProdutos.count-1 do begin
              PProdutos:=listaprodutos[x];
              if Pprodutos.codigo=PProdutosro.produto then begin
                achou:=true;
                break;
              end;
            end;
            if not achou then begin
              New(PProdutos);
              PProdutos.codigo:=PProdutosro.produto;
              PProdutos.qtde:=PProdutosro.pesocarcaca;
              PProdutos.unitario:=PProdutosro.vlrunitario;
              PProdutos.pericms:=FEstoque.Getaliquotaicms(PProdutosro.produto,Edunid_origem.text,EdUnid_destino.resultfind.fieldbyname('unid_uf').asstring);
              PProdutos.codtamanho:=0;
              PProdutos.codcor:=0;
              PProdutos.reducaobase:=0;
// 11.08.15
              PProdutos.totalitem:=(PProdutosro.pesocarcaca*PProdutosro.vlrunitario);
              if (EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring='SC') and
                 (EdUNid_origem.resultfind.fieldbyname('unid_uf').asstring=EdUNid_destino.resultfind.fieldbyname('unid_uf').asstring) then begin
                PProdutos.pericms:=0;
              end;
              ListaProdutos.add(PProdutos);
            end else begin
              PProdutos.qtde:=PProdutos.qtde+PProdutosro.pesocarcaca;
// 11.08.15
              PProdutos.totalitem:=PProdutos.totalitem+(PProdutosro.pesocarcaca*PProdutosro.vlrunitario);
            end;
          end;

///////////////////////////
// atualiza os edits de valores totais da nota

          SetaEditsvalores;
        end;
        Lista.free;
      end;
      FGeral.Fechaquery(QRoma);

  end;
end;

end.
