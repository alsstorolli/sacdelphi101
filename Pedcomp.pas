unit Pedcomp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr,Sqlsis;

type
  TFPedcompra = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bIncluiritem: TSQLBtn;
    bExcluiritem: TSQLBtn;
    bCancelaritem: TSQLBtn;
    bImpressao: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    Edcliente: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdDtemissao: TSQLEd;
    EdTotalRemessa: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdMoes_tabp_codigo: TSQLEd;
    SetEdTABP_ALIQUOTA: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    EdUnitario: TSQLEd;
    EdDtentrega: TSQLEd;
    EdPagto: TSQLEd;
    SQLEd1: TSQLEd;
    EdPecastotal: TSQLEd;
    EdFormaentrega: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    EdCodcopa: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    Edtipomov: TSQLEd;
    bexcluirpedido: TSQLBtn;
    bcompramaterial: TSQLBtn;
    EdReferencia: TSQLEd;
    bbaixaitem: TSQLBtn;
    PBaixa: TSQLPanelGrid;
    EdQtdebaixa: TSQLEd;
    bsalvarcomo: TSQLBtn;
    Edfornecedores: TSQLEd;
    Edicms: TSQLEd;
    EdST: TSQLEd;
    SetEdSt: TSQLEd;
    Edipi: TSQLEd;
    EdPecas: TSQLEd;
    Edservicos: TSQLEd;
    EdObras: TSQLEd;
    EdPerfilaces: TSQLEd;
    bbuscareq: TSQLBtn;
    EdUnitarioGrid: TSQLEd;
    bbaixapedido: TSQLBtn;
    Stsituacao: TStaticText;
    batualizapreco: TSQLBtn;
    bajuda: TSQLBtn;
    Edobspedido: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure EdDtentregaValidate(Sender: TObject);
    procedure EdDtemissaoValidate(Sender: TObject);
    procedure EdMoes_tabp_codigoValidate(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure EdUnitarioExitEdit(Sender: TObject);
    procedure EdQtdeValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure bIncluiritemClick(Sender: TObject);
    procedure bExcluiritemClick(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure bImpressaoClick(Sender: TObject);
    procedure EdMoes_tabp_codigoExitEdit(Sender: TObject);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdCodtamanhoValidate(Sender: TObject);
    procedure EdtipomovValidate(Sender: TObject);
    procedure bexcluirpedidoClick(Sender: TObject);
    procedure bcompramaterialClick(Sender: TObject);
    procedure EdPagtoValidate(Sender: TObject);
    procedure bbaixaitemClick(Sender: TObject);
    procedure EdQtdebaixaExitEdit(Sender: TObject);
    procedure EdQtdebaixaValidate(Sender: TObject);
    procedure bsalvarcomoClick(Sender: TObject);
    procedure EdUnitarioValidate(Sender: TObject);
    procedure EdObrasValidate(Sender: TObject);
    procedure bbuscareqClick(Sender: TObject);
    procedure EdPerfilacesValidate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure EdUnitarioGridExitEdit(Sender: TObject);
    procedure bbaixapedidoClick(Sender: TObject);
    procedure batualizaprecoClick(Sender: TObject);
    procedure bajudaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Campostoedits(Q:TSqlquery);
    procedure Campostogrid(Q:TSqlquery);
    procedure AtivaEdits;
    procedure DesativaEdits;
    function CalculaTotal:currency;
    procedure EditstoGrid;
    procedure LimpaEditsItens;
    procedure GravaItemConsignacao;
    procedure GravaMestrePedCompras(Emissao: TDatetime; Cliente:TSqlEd ;
              Unidade, TipoMovimento, Transacao : string ; Numero: Integer ; Valortotal:currency ; Tabela:Integer ; OP:string='I');
    procedure GravaItensPedCompras(Emissao: TDatetime; Cliente:TSqlEd ;
              Unidade, TipoMovimento,Transacao : string ; Numero: Integer ; Grid: TSqlDtGrid);
    function ProcuraGrid(Coluna: integer;  Pesquisa: string ; Colunatam:integer=0 ; tam:integer=0 ;
             colunacor:integer=0 ; cor:integer=0  ; colunacopa:integer=0 ; copa:integer=0 ) : integer;
    procedure ImprimePedidoCompra(numero:integer ; tipomov,video:string );
    procedure ImprimeCompraMaterial(numero:integer ; tipomov,video:string);
    procedure SetaEditsItens;
    function GetSeIndustrializa(pedido:integer;produto:string;codigocor:Integer):string;

  end;

// 23.05.12 - Damama
const UnidadesDivideComposicao:string='KG;L;LT;LTS';

var
  FPedcompra: TFPedcompra;
  QBusca,QEstoque:TSqlquery;
  Op,Transacao,
  semvideo,
  tipomov,
  transacoesreq:string;
  TotalRemessa,DivideComposicao:Currency;
  seq:integer;
  campoobs        :TDicionario;

//const tipomov:string='PU' ;   // PU = pedido de compra de material e uso e consumo     REVER ESTES TIpOS
                              // PB = pedido de compra de produtos a serem produzdiso
                              // OR = orcamento
// 06.03.08
const tiposmov:string ='PU;PB;PX;OR';

procedure PedidoCompra_Execute(Opx:string);
/////////////////////////////////////////////////

implementation

uses Estoque,Sqlfun,Arquiv,Geral,Grades,tabela, TextRel, Usuarios,
  conpagto, cadcor, tamanhos, cadcopa, SQLRel, fornece, impressao;

{$R *.dfm}

procedure PedidoCompra_Execute(Opx:string);
////////////////////////////////////////////////
var localpea:string;
begin
  Op:=Opx;
////////////////////////////;
  transacoesreq:='';
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
  FGeral.EstiloForm(FPedcompra);
  FPedcompra.bCancelar.Enabled:=Op='A';
  FPedcompra.bImpressao.Enabled:=OP='A';
//  bDevolucao.Enabled:=OP='D';
  FPedcompra.bCancelaritem.Enabled:=true;
  if pos(OP,'A/B')>0 then begin
    FPedcompra.DesativaEdits;
    FPedcompra.EdNumerodoc.Enabled:=true;
    FPedcompra.EdMoes_tabp_codigo.Enabled:=true;
    if OP='B' then
      FPedcompra.bCancelaritem.Enabled:=false;
  end else begin
    FPedcompra.AtivaEdits;
    FPedcompra.EdNumerodoc.Enabled:=false;
  end;
  if OP='B' then begin
    FPedcompra.bIncluiritem.Enabled:=false;
    FPedcompra.bExcluiritem.Enabled:=false;
    FPedcompra.bExcluirpedido.Enabled:=false;
    FPedcompra.bCancelar.Enabled:=false;
    FPedcompra.bGravar.Enabled:=false;
  end else begin
    FPedcompra.bIncluiritem.Enabled:=true;
    FPedcompra.bExcluiritem.Enabled:=true;
    FPedcompra.bCancelar.Enabled:=true;
    FPedcompra.bGravar.Enabled:=true;
  end;

////////////////////////////
  semvideo:='N';
  tipomov:='PB';
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
  FPedcompra.EdCliente.ClearAll(FPedcompra,99);
  FPedcompra.EdUNid_codigo.text:=Global.CodigoUnidade;
  FPedcompra.EdUnid_codigo.validfind;
  FPedcompra.bbaixaitem.enabled:=OP='B';
  FPedcompra.bsalvarcomo.enabled:=OP='A';
  if Op='I' then begin
    if trim(FPedcompra.EdDtemissao.Text)='' then begin
       FPedcompra.EdDtemissao.SetDate(Date);
       FPedcompra.EdDtentrega.SetDate(Date);
    end;
    FPedcompra.EdNumerodoc.Setvalue(0);
  end;
  FPedcompra.Grid.clear;

  FPedcompra.Show;

// 06.03.08
  FPedcompra.EdCodcor.enabled:=Global.topicos[1309];
  FPedcompra.EdCodtamanho.enabled:=Global.topicos[1309];
// 10.03.08
  FFornece.SetaItems(FPedcompra.EdFornecedores,nil,'','');
// 11.07.08
  FPedcompra.bbuscareq.Enabled:=false;
  FPedcompra.edobras.Enabled:=false;
  FPedcompra.EdPerfilaces.enabled:=false;
  if op='I' then begin
    FPedcompra.EdCliente.SetFocus;
    FPedcompra.bbuscareq.Enabled:=Global.topicos[1204];
    FPedcompra.EdObras.enabled:=Global.topicos[1204];
    FPedcompra.EdPerfilaces.enabled:=Global.topicos[1204];
  end else begin
    FPedcompra.EdNumerodoc.enabled:=true;
    FPedcompra.EdNumerodoc.SetFocus;
  end;
// 23.05.12
   DivideComposicao:=FGeral.GetConfig1AsInteger('DIVCOMPOSICAO');
   if DivideComposicao<=0 then DivideComposicao:=1;
// 27.05.13
   FGeral.ConfiguraColorEditsNaoEnabled(FPedcompra);
   FPedcompra.bajuda.Visible:=Global.Topicos[1036];
   FPedcompra.bajuda.Enabled:=Global.Topicos[1036];
// 24.06.2022
   campoobs:=Sistema.GetDicionario('movcomp','mocm_obspedido');
   FPedcompra.Edobspedido.enabled := ( trim(campoobs.tipo) <> '' );

end;

procedure TFPedcompra.GravaItemConsignacao;
/////////////////////////////////////////////////////////////////
var codigograde,codigolinha,codigocoluna:integer;
    Q2,Q1:TSqlquery;
    sqlcor,sqltamanho,sqlcopa:string;
begin
  if not EdCodcor.isempty then
    sqlcor:=' and moco_core_codigo='+Edcodcor.assql
  else
    sqlcor:=' and moco_core_codigo=0';
  if not EdCodtamanho.isempty then
    sqltamanho:=' and moco_tama_codigo='+Edcodtamanho.assql
  else
    sqltamanho:='';
  if not EdCodcopa.isempty then
    sqlcopa:=' and moco_copa_codigo='+Edcodcopa.assql
  else
    sqlcopa:=' and moco_copa_codigo=0';

   Q1:=Sqltoquery('select mocM_status,mocm_transacao from movcomp where mocm_status=''N'''+
          ' and mocm_numerodoc='+EdNumerodoc.AsSql+
          ' and mocm_tipomov='+Stringtosql(Tipomov)+
          ' and mocm_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and mocm_tipo_codigo='+EdCliente.AsSql+
          ' and mocm_tipocad=''F''' );
   if Q1.eof then begin
     Avisoerro('Pedido n�o encontrado para incluir este item');
     FGeral.fechaquery(Q1);
     exit;
   end;
   Q2:=Sqltoquery('select moco_status,moco_transacao from movcompras where moco_status=''N'''+
          ' and moco_numerodoc='+EdNumerodoc.AsSql+
          ' and moco_tipomov='+Stringtosql(Tipomov)+
          ' and moco_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and moco_esto_codigo='+Stringtosql(EdProduto.text)+
          sqlcor+sqltamanho+sqlcopa+
          ' and moco_tipo_codigo='+EdCliente.AsSql+
          ' and moco_tipocad=''F''' );
    if Q2.Eof then begin
      codigograde:=FEstoque.GetCodigoGrade(EdProduto.Text);
      Transacao:=Q1.fieldbyname('mocm_transacao').Asstring;
      Sistema.Insert('movcompras');
      Sistema.SetField('moco_esto_codigo',EdProduto.Text);
//      codigolinha:=FEstoque.GetCodigoLinha(EdProduto.Text,codigograde);
//      codigocoluna:=FEstoque.GetCodigoColuna(EdProduto.Text,codigograde);
{
      if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
        Sistema.SetField('moco_tama_codigo',codigolinha)
      else
        Sistema.SetField('moco_core_codigo',codigolinha);
      if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
        Sistema.SetField('moco_tama_codigo',codigocoluna)
      else
        Sistema.SetField('moco_core_codigo',codigocoluna);
}
      Sistema.SetField('moco_core_codigo',EdCodcor.asinteger);
      Sistema.SetField('moco_tama_codigo',EdCodtamanho.asinteger);
      Sistema.SetField('moco_copa_codigo',EdCodcopa.asinteger);
      Sistema.SetField('moco_transacao',transacao);
      Sistema.SetField('moco_operacao',transacao+'AA');
      Sistema.SetField('moco_numerodoc',Ednumerodoc.Asinteger);
      Sistema.SetField('moco_status','N');
      Sistema.SetField('moco_tipomov',TipoMov);
      Sistema.SetField('moco_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('moco_tipo_codigo',EdCliente.AsInteger);
      Sistema.SetField('moco_tipocad','F');
      Sistema.SetField('moco_qtde',EdQtde.AsCurrency);
      Sistema.SetField('moco_datalcto',EdDtEmissao.Asdate);
      Sistema.SetField('moco_datamvto',Sistema.Hoje);
      Sistema.SetField('moco_unitario',EdUnitario.AsFloat);
      Sistema.SetField('moco_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('moco_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('moco_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('moco_usua_codigo',Global.Usuario.codigo);
// 04.09.06
      Sistema.SetField('moco_seq',seq);
// 14.04.08
      Sistema.SetField('moco_cst',SetEdSt.text);
      Sistema.SetField('moco_aliicms',EdIcms.ascurrency);
      Sistema.SetField('moco_aliipi',EdIpi.ascurrency);
      Sistema.SetField('moco_pecas',EdPecas.ascurrency);
      Sistema.SetField('moco_industrializa',EdServicos.text);
      Sistema.Post('');
    end else begin
      codigograde:=FEstoque.GetCodigoGrade(EdProduto.Text);
      Transacao:=Q1.fieldbyname('mocm_transacao').Asstring;
      Sistema.Edit('movcompras');
{
      if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
        Sistema.SetField('moco_tama_codigo',codigolinha)
      else
        Sistema.SetField('moco_core_codigo',codigolinha);
      if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
        Sistema.SetField('moco_tama_codigo',codigocoluna)
      else
        Sistema.SetField('moco_core_codigo',codigocoluna);
}
      Sistema.SetField('moco_core_codigo',EdCodcor.asinteger);
      Sistema.SetField('moco_tama_codigo',Edcodtamanho.asinteger);
      Sistema.SetField('moco_copa_codigo',Edcodcopa.asinteger);
      Sistema.SetField('moco_transacao',transacao);
      Sistema.SetField('moco_operacao',transacao+'AA');
      Sistema.SetField('moco_numerodoc',Ednumerodoc.Asinteger);
      Sistema.SetField('moco_status','N');
      Sistema.SetField('moco_tipomov',TipoMov);
      Sistema.SetField('moco_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('moco_tipo_codigo',EdCliente.AsInteger);
      Sistema.SetField('moco_tipocad','F');
      Sistema.SetField('moco_qtde',EdQtde.AsCurrency);
      Sistema.SetField('moco_datalcto',EdDtEmissao.Asdate);
      Sistema.SetField('moco_datamvto',Sistema.Hoje);
      Sistema.SetField('moco_unitario',EdUnitario.AsFloat);
      Sistema.SetField('moco_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('moco_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('moco_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('moco_usua_codigo',Global.Usuario.codigo);
// 14.04.08
      Sistema.SetField('moco_cst',SetEdSt.text);
      Sistema.SetField('moco_aliicms',EdIcms.ascurrency);
      Sistema.SetField('moco_aliipi',EdIpi.ascurrency);
      Sistema.SetField('moco_pecas',EdPecas.ascurrency);
      Sistema.SetField('moco_industrializa',EdServicos.text);
      Sistema.Post('moco_numerodoc='+EdNumerodoc.AsSql+' and moco_status=''N'''+
                ' and moco_tipomov='+Stringtosql(Tipomov)+
                ' and moco_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
                ' and moco_tipo_codigo='+EdCliente.AsSql+
                ' and moco_esto_codigo='+EdProduto.AsSql+
                  sqlcor+sqltamanho+sqlcopa+
                ' and moco_tipocad=''F''' );
    end;
    Sistema.Commit;
    FGeral.fechaquery(Q2);
    FGeral.fechaquery(Q1);
end;



procedure TFPedcompra.Campostoedits(Q:TSqlquery);
///////////////////////////////////////////////////
begin

  EdCliente.Text:=Q.fieldbyname('mocm_tipo_codigo').AsString;
  EdUnid_codigo.Text:=Q.fieldbyname('mocm_unid_codigo').AsString;
  EdDtEmissao.SetDate(Q.fieldbyname('mocm_datamvto').AsDateTime);
  EdTotalremessa.SetValue(Q.fieldbyname('mocm_vlrtotal').AsCurrency);
  Edmoes_tabp_codigo.SetValue(Q.fieldbyname('mocm_tabp_codigo').AsInteger);
  EdDtentrega.setdate(Q.fieldbyname('mocm_dataentrega').AsDateTime);
  EdPagto.text:=Q.fieldbyname('mocm_fpgt_codigo').Asstring;
  SetEdTabp_aliquota.Text:=FTabela.GetDescAliquota(Q.fieldbyname('mocm_tabp_codigo').AsInteger);
  EdTipomov.text:=Q.fieldbyname('mocm_tipomov').AsString;
  Tipomov:=Q.fieldbyname('mocm_tipomov').AsString;
  EdFormaentrega.text:=Q.fieldbyname('mocm_formaentrega').AsString;
  // 11.03.08
  EdFornecedores.text:=Q.fieldbyname('mocm_fornecorcam').asstring;
// 24.06.2022
  if trim(campoobs.tipo) <> '' then
     Edobspedido.Text := Q.fieldbyname('mocm_obspedido').asstring;

  EdUnid_codigo.ValidateEdit;
  EdCliente.ValidateEdit;
  EdPagto.validateedit;
// 22.05.09
  if Q.fieldbyname('mocm_datarecebido').asdatetime>1 then
    StSituacao.Caption:='Baixado'
  else
    StSituacao.Caption:='Pendente';
  StSituacao.Refresh;
end;

procedure TFPedcompra.Campostogrid(Q:TSqlquery);
var p:integer;
    QE:TSqlquery;
begin
  Grid.Clear;p:=1;Q.First;
  while not Q.Eof do begin
    QE:=sqltoquery('select esto_referencia from estoque where esto_codigo='+stringtosql(Q.fieldbyname('moco_esto_codigo').Asstring));
    Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]:=Q.fieldbyname('moco_esto_codigo').Asstring;
    Grid.Cells[Grid.Getcolumn('esto_descricao'),p]:=FEstoque.GetDescricao(Q.fieldbyname('moco_esto_codigo').Asstring);
    Grid.Cells[Grid.Getcolumn('move_qtde'),p]:=transform(Q.fieldbyname('moco_qtde').Ascurrency,f_cr);
    Grid.Cells[Grid.Getcolumn('move_venda'),p]:=transform(Q.fieldbyname('moco_unitario').Ascurrency,f_cr3);
    Grid.Cells[Grid.Getcolumn('total'),p]:=transform(FGeral.Arredonda(Q.fieldbyname('moco_unitario').Ascurrency*Q.fieldbyname('moco_qtde').Ascurrency,2),f_cr);
    Grid.Cells[Grid.Getcolumn('codcor'),p]:=Q.fieldbyname('moco_core_codigo').Asstring;
    Grid.Cells[Grid.Getcolumn('codcopa'),p]:=Q.fieldbyname('moco_copa_codigo').Asstring;
    Grid.Cells[Grid.Getcolumn('codtamanho'),p]:=Q.fieldbyname('moco_tama_codigo').Asstring;
    Grid.Cells[grid.getcolumn('cor'),Abs(p)]:=FCores.getdescricao(Q.fieldbyname('moco_core_codigo').Asinteger);
    Grid.Cells[grid.getcolumn('tamanho'),Abs(p)]:=FTamanhos.getdescricao(Q.fieldbyname('moco_tama_codigo').Asinteger);
    Grid.Cells[grid.getcolumn('copa'),Abs(p)]:=FCopas.getdescricao(Q.fieldbyname('moco_copa_codigo').Asinteger);
    Grid.Cells[Grid.Getcolumn('moco_seq'),p]:=strzero(Q.fieldbyname('moco_seq').Asinteger,3);
// 11.04.08
    Grid.Cells[Grid.getcolumn('move_icms'),Abs(p)]:=transform(Q.fieldbyname('moco_aliicms').Ascurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_ipi'),Abs(p)]:=transform(Q.fieldbyname('moco_aliipi').Ascurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_pecas'),Abs(p)]:=transform(Q.fieldbyname('moco_pecas').Ascurrency,'###,##0');
    Grid.Cells[Grid.getcolumn('moco_industrializa'),Abs(p)]:=Q.fieldbyname('moco_industrializa').AsString;
// 02.07.08
    if not QE.eof then
      Grid.Cells[Grid.getcolumn('esto_referencia'),Abs(p)]:=(QE.fieldbyname('esto_referencia').Asstring);
//    Grid.Cells[Grid.getcolumn('move_cst'),Abs(p)]:=Q.Fieldbyname('moco_cst').asstring;
///
    FGeral.FechaQuery(QE);
    inc(p);
    Grid.AppendRow;
    Q.Next;
  end;
end;

procedure TFPedcompra.AtivaEdits;
begin
  PRemessa.Enabled:=true;
  if OP='I' then begin
    PRemessa.EnableEdits;
    EdNumerodoc.Enabled:=false;
  end else
    EdNumerodoc.Enabled:=true;
end;

procedure TFPedcompra.DesativaEdits;
begin
  PRemessa.DisableEdits;
  EdNumerodoc.Enabled:=true;

end;


function TFPedcompra.CalculaTotal:currency;
var p:integer;
    vlrtotal,qtdetotal:currency;
begin
  vlrtotal:=0;qtdetotal:=0;
  for p:=1 to Grid.RowCount do begin
//    vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),p])*
//              texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),p]),2);
// 11.08.08 - carli
    vlrtotal:=vlrtotal+FGeral.Arredonda( texttovalor(Grid.Cells[Grid.getcolumn('total'),p]),2 );
    qtdetotal:=qtdetotal+texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),p]);
  end;
  result:=vlrtotal;
  EdPecastotal.setvalue(qtdetotal);
end;


procedure TFPedcompra.EditstoGrid;
////////////////////////////////////////
var x:integer;
    aqtde:currency;
begin
  x:=ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,grid.getcolumn('codtamanho'),EdCodtamanho.asinteger,
                        grid.getcolumn('codcor'),Edcodcor.asinteger,grid.getcolumn('codcopa'),Edcodcopa.asinteger);
//  if x<0 then begin
  if x<=0 then begin
    if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),1])='') then begin
       x:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       x:=Grid.RowCount-1;
    end;
/////    Grid.AppendRow;
    Grid.Cells[Grid.getcolumn('move_esto_codigo'),Abs(x)]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;
    Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=EdQTde.AsSql;
    Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=TRansform(EdQTde.AsCurrency*EdUnitario.AsFloat,f_cr);
    Grid.Cells[grid.getcolumn('tamanho'),Abs(x)]:=SetEdtamanho.text;
    Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=SetEdcor.text;
    Grid.Cells[grid.getcolumn('codtamanho'),Abs(x)]:=Edcodtamanho.text;
    Grid.Cells[grid.getcolumn('codcor'),Abs(x)]:=Edcodcor.text;
    Grid.Cells[grid.getcolumn('copa'),Abs(x)]:=SetEdcopa_descricao.text;
    Grid.Cells[grid.getcolumn('codcopa'),Abs(x)]:=Edcodcopa.text;
    Grid.Cells[grid.getcolumn('esto_referencia'),Abs(x)]:=EdReferencia.text;
    Grid.Cells[grid.getcolumn('moco_seq'),Abs(x)]:=strzero(Seq,3);
// 11.04.08
    Grid.Cells[Grid.getcolumn('move_icms'),Abs(x)]:=EdIcms.AsSql;
    Grid.Cells[Grid.getcolumn('move_ipi'),Abs(x)]:=EdIpi.AsSql;
    Grid.Cells[Grid.getcolumn('move_cst'),Abs(x)]:=EdSt.resultfind.Fieldbyname('sitt_cst').asstring;
    Grid.Cells[Grid.getcolumn('move_pecas'),Abs(x)]:=Edpecas.Assql;
    Grid.Cells[Grid.getcolumn('moco_industrializa'),Abs(x)]:=EdServicos.Text;
///
  end else begin

    Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=SetEdEsto_descricao.text;
//    Grid.Cells[Grid.getcolumn('move_qtde'),x]:=Transform(EdQTde.Ascurrency,f_cr);
// 27.09.12 - Abra - JU+Andressa
    aqtde:=Texttovalor( Grid.Cells[Grid.getcolumn('move_qtde'),x] );
    Grid.Cells[Grid.getcolumn('move_qtde'),x]:=Transform(aqtde+EdQTde.Ascurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_venda'),x]:=Transform(EdUnitario.AsFloat,f_cr3);
    Grid.Cells[Grid.getcolumn('total'),x]:=TRansform((EdQTde.AsCurrency+aqtde)*EdUnitario.AsFloat,f_cr);
    Grid.Cells[grid.getcolumn('tamanho'),x]:=SetEdtamanho.text;
    Grid.Cells[grid.getcolumn('cor'),Abs(x)]:=SetEdcor.text;
    Grid.Cells[grid.getcolumn('codtamanho'),Abs(x)]:=Edcodtamanho.text;
    Grid.Cells[grid.getcolumn('codcor'),Abs(x)]:=Edcodcor.text;
    Grid.Cells[grid.getcolumn('copa'),Abs(x)]:=SetEdcopa_descricao.text;
    Grid.Cells[grid.getcolumn('codcopa'),Abs(x)]:=Edcodcopa.text;
    Grid.Cells[grid.getcolumn('esto_referencia'),x]:=EdReferencia.text;
// 11.04.08
    Grid.Cells[Grid.getcolumn('move_icms'),x]:=EdIcms.AsSql;
    Grid.Cells[Grid.getcolumn('move_ipi'),x]:=EdIpi.AsSql;
    Grid.Cells[Grid.getcolumn('move_cst'),x]:=EdSt.resultfind.Fieldbyname('sitt_cst').asstring;
    Grid.Cells[Grid.getcolumn('move_pecas'),Abs(x)]:=Edpecas.Assql;
///
    Grid.Cells[Grid.getcolumn('moco_industrializa'),Abs(x)]:=EdServicos.Text;
  end;
  Grid.Refresh;
end;

{
function TFPedcompra.ProcuraGrid(Coluna: integer; Pesquisa: string):integer;
var p:integer;
begin
  result:=0;
  for p:=1 to Grid.RowCount do  begin
    if trim(Grid.Cells[Coluna,p])=trim(Pesquisa) then begin
      result:=p;
      break;
    end;
    if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
      result:=(-1)*p;
      break;
    end;
  end;
end;
}

procedure TFPedcompra.LimpaEditsItens;
begin
  EdProduto.Clear;
  EdQtde.Clear;
  EdPecas.clear;
  EdUnitario.Clear;
  EdPecas.clear;
//  EdIcms.clear;   pra nao ter q redigitar em todos os items
//  EdIpi.Clear;
  SetedEsto_descricao.Clear;
end;

///////////////////////////////////////////////////////////
procedure TFPedcompra.FormActivate(Sender: TObject);
begin
{
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
  FPedcompra.bCancelar.Enabled:=Op='A';
  FPedcompra.bImpressao.Enabled:=OP='A';
//  bDevolucao.Enabled:=OP='D';
  FPedcompra.bCancelaritem.Enabled:=true;
  if pos(OP,'A/B')>0 then begin
    FPedcompra.DesativaEdits;
    FPedcompra.EdNumerodoc.Enabled:=true;
    FPedcompra.EdMoes_tabp_codigo.Enabled:=true;
    if OP='B' then
      FPedcompra.bCancelaritem.Enabled:=false;
  end else begin
    FPedcompra.AtivaEdits;
    FPedcompra.EdNumerodoc.Enabled:=false;
  end;
  if OP='B' then begin
    FPedcompra.bIncluiritem.Enabled:=false;
    FPedcompra.bExcluiritem.Enabled:=false;
    FPedcompra.bExcluirpedido.Enabled:=false;
    FPedcompra.bCancelar.Enabled:=false;
    FPedcompra.bGravar.Enabled:=false;
  end else begin
    FPedcompra.bIncluiritem.Enabled:=true;
    FPedcompra.bExcluiritem.Enabled:=true;
    FPedcompra.bCancelar.Enabled:=true;
    FPedcompra.bGravar.Enabled:=true;
  end;
}
end;


procedure TFPedcompra.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var QMestre:TSqlquery;
begin
  if (EdCliente.AsInteger>0) then begin
    if OP='I' then begin
      QMestre:=Sqltoquery('select mocm_status from movcomp where mocm_status=''N'''+
          ' and mocm_tipomov='+Stringtosql(tipomov)+
          ' and mocm_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and mocm_tipo_codigo='+EDCliente.AsSql+
          ' and mocm_datamvto='+EdDtEmissao.AsSql+
          ' and mocm_tipocad='+Stringtosql('F') );
      if QMestre.Eof then begin
        if Confirma('� prov�vel que este documento ainda n�o foi gravado.  Gravar ?') then
          bgravarclick(Self);
      end;
    end else if TotalRemessa<>EdTotalremessa.AsCurrency then begin
      GravaMestrePedCompras(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             Global.CodRemessaConsig,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,Op);
      Sistema.Commit;
    end;
  end;

end;



procedure TFPedcompra.EdNumeroDocValidate(Sender: TObject);
begin
  if EdNumerodoc.AsInteger>0 then begin

     QBusca:=sqltoquery(FGeral.buscapedcompra(EdNumerodoc.AsInteger,tiposmov,'S'));
     if QBusca.eof then begin
       EdNUmerodoc.INvalid('Numero de pedido n�o encontrado');
       EdNumerodoc.ClearAll(FPedcompra,99);
       EdUNid_codigo.text:=Global.CodigoUnidade;
       Grid.Clear;
     end else begin
       if OP='A' then
         Transacao:=QBusca.fieldbyname('mocm_transacao').asstring;
       Sistema.beginprocess('lendo pedido');
       Campostoedits(Qbusca);
       Campostogrid(Qbusca);
       EdCliente.ValidFind;
       EdTotalRemessa.setvalue(CalculaTotal);
       TotalRemessa:=EdTotalremessa.AsCurrency;
       Sistema.endprocess('');
       EdUnid_codigo.ValidFind;
     end;
  end;

end;



procedure TFPedcompra.GravaMestrePedCompras(Emissao: TDatetime;
  Cliente: TSqlEd; Unidade, TipoMovimento, Transacao: string;
  Numero: Integer; Valortotal: currency; Tabela: Integer; OP: string);
begin

  if Op='I' then begin

    Sistema.Insert('Movcomp');
    Sistema.SetField('mocm_transacao',Transacao);
    Sistema.SetField('mocm_operacao',FGeral.getoperacao);
    Sistema.SetField('mocm_status','N');
    Sistema.SetField('mocm_numerodoc',Numero);
    Sistema.SetField('mocm_tipomov',TipoMovimento);
    Sistema.SetField('mocm_unid_codigo',Unidade);
    Sistema.SetField('mocm_tipo_codigo',Cliente.AsInteger);
    Sistema.SetField('mocm_tipocad','F');
    Sistema.SetField('mocm_datalcto',Sistema.Hoje);
    Sistema.SetField('mocm_datamvto',Emissao);
    Sistema.SetField('mocm_dataentrega',EdDtentrega.Asdate);
    Sistema.SetField('mocm_vlrtotal',Valortotal);
    Sistema.SetField('mocm_tabp_codigo',Tabela);
    Sistema.SetField('mocm_fpgt_codigo',EdPagto.text);
    Sistema.SetField('mocm_tabaliquota',FTabela.GetAliquota(Tabela));
    Sistema.SetField('mocm_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('mocm_totprod',Valortotal);
    Sistema.SetField('mocm_valortotal',Valortotal);
// 06.06.06
    Sistema.SetField('mocm_formaentrega',EdFormaentrega.text);
// 11.03.08
    Sistema.SetField('mocm_fornecorcam',Edfornecedores.Text);
// 05.08.08 - requisicoes usadas na ordem de compra
    Sistema.SetField('mocm_requisicoes',EdObras.text);
    Sistema.SetField('mocm_transreq',transacoesreq);
// 24.06.2022
   if trim(campoobs.tipo) <> '' then
      Sistema.SetField('mocm_obspedido',Edobspedido.Text);

    Sistema.Post();
//    Avisoerro('gravando previsao de pagamento');
    if pos(tipomov,'OR;')=0 then
      FGeral.GravaPendencia(Emissao,emissao,EdCliente,'F',0,unidade,tipomov,transacao,EdPagto.text,'P',Numero,0,valortotal,
                          0,'H',valortotal,0,nil,'','001' );
// 05.08.08 - gravar no moes_remessas a transacao do pedido de compra gerado
    if trim(transacoesreq)<>'' then begin
      Sistema.Edit('movesto');
      Sistema.SetField('moes_remessas',transacao);
      Sistema.post('moes_status=''R'' and '+FGeral.GetIN('moes_transacao',transacoesreq,'C')+
                   ' and moes_unid_codigo='+stringtosql(EdUnid_codigo.text)+
                   ' and moes_tipomov='+stringtosql(Global.CodRequisicaoAlmox) );
    end;
//    Avisoerro('gravado previsao de pagamento');
  end else begin

    Sistema.Edit('Movcomp');
    Sistema.SetField('mocm_numerodoc',Numero);
    Sistema.SetField('mocm_tipo_codigo',Cliente.AsInteger);
    Sistema.SetField('mocm_tipocad','F');
    Sistema.SetField('mocm_datamvto',Emissao);
    Sistema.SetField('mocm_vlrtotal',Valortotal);
    Sistema.SetField('mocm_dataentrega',EdDtentrega.Asdate);
    Sistema.SetField('mocm_tabp_codigo',Tabela);
    Sistema.SetField('mocm_tabaliquota',FTabela.GetAliquota(Tabela));
    Sistema.SetField('mocm_fpgt_codigo',EdPagto.text);
    Sistema.SetField('mocm_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('mocm_totprod',Valortotal);
    Sistema.SetField('mocm_valortotal',Valortotal);
// 06.06.06
    Sistema.SetField('mocm_formaentrega',EdFormaentrega.text);
// 11.03.08
    Sistema.SetField('mocm_fornecorcam',EdFornecedores.text);
// 24.06.2022
   if trim(campoobs.tipo) <> '' then
      Sistema.SetField('mocm_obspedido',Edobspedido.Text);


    Sistema.Post('mocm_transacao='+stringtosql(transacao));
    if pos(tipomov,'PU;PX')>0 then begin
      Sistema.Edit('pendencias');
      Sistema.setfield('pend_valor',valortotal);
      Sistema.Post('pend_transacao='+stringtosql(transacao)+' and pend_status=''H''');
    end;

  end;

end;

procedure TFPedcompra.EdDtentregaValidate(Sender: TObject);
begin
  if EdDtentrega.Asdate<EdDtemissao.asdate then
    EdDtentrega.invalid('Data de entrega inv�lida');
end;

procedure TFPedcompra.EdDtemissaoValidate(Sender: TObject);
begin
  if not FGeral.ValidaMvto(EdDtemissao) then
    EdDtemissao.Invalid('');

end;

procedure TFPedcompra.EdMoes_tabp_codigoValidate(Sender: TObject);
begin
  if EdMoes_tabp_codigo.asinteger>0 then begin
    if Arq.TTabelaPreco.Locate('tabp_codigo',EdMoes_tabp_codigo.AsInteger,[]) then
      SetEdTabp_aliquota.Text:=FTabela.GetDescAliquota(EdMoes_tabp_codigo.asinteger)
    else begin
      SetEdTabp_aliquota.Text:='';
      EdMoes_tabp_codigo.Invalid('Tabela n�o encontrada');
    end;
  end else
    SetEdTabp_aliquota.Text:='';

end;

procedure TFPedcompra.EdProdutoValidate(Sender: TObject);
var x:integer;
    Q:TSqlquery;
begin
  if  FGeral.CodigoBarra(EdProduto.Text) then begin
    Q:=sqltoquery('select * from estoque where esto_Codbarra='+EdProduto.Text);
    if not QBusca.Eof then begin
      EdProduto.Text:=Q.fieldbyname('esto_codigo').AsString;
      EdReferencia.Text:=Q.fieldbyname('esto_referencia').AsString;
    end else begin
      EdProduto.Invalid('Codigo de barra n�o encontrado');
      exit;
    end;
    EdQtde.Enabled:=false;
    EdQtde.SetValue(1);
  end else begin
    Q:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.Assql);
    if not Q.Eof then begin
      EdProduto.Text:=Q.fieldbyname('esto_codigo').AsString;
      EdReferencia.Text:=Q.fieldbyname('esto_referencia').AsString;
    end else begin
      EdProduto.Invalid('Codigo n�o encontrado');
      exit;
    end;
    EdQtde.Enabled:=true;
    if op='I' then
      EdQtde.SetValue(0);
  end;

  SetEdEsto_descricao.text:=Q.fieldbyname('esto_descricao').asstring;
  QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
  if op='I' then begin

     if (Q.fieldbyname('esto_precocompra').AsFloat) > 0 then

        EdUnitario.Setvalue(Q.fieldbyname('esto_precocompra').AsFloat)

     else

        EdUnitario.Setvalue(QEstoque.fieldbyname('esqt_custo').AsFloat);

  end;

  if op='I' then begin
//      x:=ProcuraGrid(0,EdProduto.Text);
      x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid);
      if x>0 then
        Aviso('Aten��o.  Produto j� digitado.');
  end;

  FGeral.Fechaquery(Q);
end;

procedure TFPedcompra.EdUnitarioExitEdit(Sender: TObject);
begin
  if confirma('Confirma item ?') then begin
    EditstoGrid;
    EdTotalRemessa.setvalue(CalculaTotal);
    if op='A' then begin
      GravaItemConsignacao;
      GravaMestrePedCompras(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             Tipomov,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,OP);
      Sistema.Commit;
    end;
  end;
  LimpaEditsItens;
  EdProduto.SetFocus;
  Freeandnil(QEstoque);

end;

procedure TFPedcompra.EdQtdeValidate(Sender: TObject);
begin
  if EdQtde.AsCurrency>0 then begin
//    if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsCurrency,EdUNid_codigo.Text,QEstoque) then begin
//       EdQTde.INvalid('Quantidade em estoque insuficiente');
//    end;
// provavelmente nao precisara de grade aqui
//    if EdProduto.ResultFind.FieldByName('esto_grad_codigo').AsInteger>0 then begin
// mostrar grade para digita��o na grade e sua consistencia com o total digitado no edit
// se ok lan�ar todos os tamanhos/cores do dtgrid
//       FGrade.Execute(EdUnid_codigo.text,EdProduto.Text,EdProduto.ResultFind.FieldByName('esto_grad_codigo').AsInteger);
//    end;
  end;

end;

procedure TFPedcompra.bGravarClick(Sender: TObject);
//////////////////////////////////////////////////////////
var Numero:integer;

  procedure TrocaCodigo(novocodigo:integer);
  //////////////////////////////////////////
  begin
    Sistema.Edit('movcompras');
    Sistema.SetField('moco_tipo_codigo',novocodigo);
    Sistema.post('moco_numerodoc='+EdNumerodoc.assql);
  end;

begin
//////////
  if (EdDtemissao.AsDate<=1) or (EdCliente.AsInteger=0) or (Grid.RowCount<=1)then
    exit;
  if not EdTipomov.valid then exit;
  if not Edpagto.valid then exit;

  if confirma('Confirma grava��o ?') then begin

    if OP='I' then begin

      Sistema.BeginTransaction('Gravando');
      Numero:=FGeral.GetContador('PEDCOMPRA',false);
      EdNumerodoc.Text:=inttostr(Numero);
//      Transacao:=EdUnid_codigo.text+strzero(Numero,08);
      Transacao:=FGeral.Gettransacao;
      GravaMestrePedCompras(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             Tipomov,Transacao,Numero,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger);
      GravaItensPedCompras(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             TipoMOv,Transacao,Numero,Grid);
// 27.05.13
      if Edtipomov.text<>'OR' then begin
        if ( trim(FGeral.GetConfig1AsString('usuariosestoque'))<>'' )  and (Confirma('Gerar aviso pra estoque ?')) then begin
         FGeral.PlanoAcaoSistema(numero,FGeral.GetConfig1AsString('usuariosestoque')
                ,Global.codigounidade,
                'CHECAR PEDIDO DE COMPRA','Pedido '+inttostr(numero)+' Forn. '+SetEdCLIE_NOME.text+' Digitado ',
                EdTotalRemessa.ascurrency , EdDtentrega.asdate )
        end;
      end;
///////////////

      Sistema.EndTransaction('Gravado pedido '+EdNumerodoc.text);

    end else if OP='A' then begin
      GravaMestrePedCompras(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             Tipomov,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,Op);
// 11.08.08
      if EdCliente.text<>EdCliente.OldValue then
        TrocaCodigo(EdCliente.asinteger);

      Sistema.Commit;
    end;
    semvideo:='S';

    bimpressaoclick(self);
    EdCliente.Clearall(FPedcompra,99);
    EdDtEmissao.setdate(sistema.hoje);
    EdDtEntrega.setdate(sistema.hoje);
    EdUNid_codigo.text:=Global.CodigoUnidade;
    Grid.Clear;
    if OP='I' then
      EdCliente.Setfocus
    else
      EdNumerodoc.SetFocus;
    semvideo:='N';

  end;

end;

procedure TFPedcompra.GravaItensPedCompras(Emissao: TDatetime;
  Cliente: TSqlEd; Unidade, TipoMovimento, Transacao: string;
  Numero: Integer; Grid: TSqlDtGrid);
////////////////////////////////////////////////////////
var linha,codigograde,codigolinha,codigocoluna:integer;
begin
  for linha:=1 to Grid.rowcount do begin
    if trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha])<>'' then begin
//      codigograde:=FEstoque.GetCodigoGrade(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha]);
      Sistema.Insert('Movcompras');
      Sistema.SetField('moco_esto_codigo',Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha]);
//      codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[0,linha],codigograde);
//      codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[0,linha],codigograde);
{
      if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
        Sistema.SetField('moco_tama_codigo',codigolinha)
      else
        Sistema.SetField('moco_core_codigo',codigolinha);
      if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
        Sistema.SetField('moco_tama_codigo',codigocoluna)
      else
        Sistema.SetField('moco_core_codigo',codigocoluna);
}
      Sistema.SetField('moco_tama_codigo',strtointdef(Grid.Cells[Grid.Getcolumn('codtamanho'),linha],0));
      Sistema.SetField('moco_core_codigo',strtointdef(Grid.Cells[Grid.Getcolumn('codcor'),linha],0) );
      Sistema.SetField('moco_copa_codigo',strtointdef(Grid.Cells[Grid.Getcolumn('codcopa'),linha],0) );
      Sistema.SetField('moco_transacao',transacao);
      Sistema.SetField('moco_operacao',FGeral.getoperacao);
      Sistema.SetField('moco_numerodoc',numero);
      Sistema.SetField('moco_status','N');
      Sistema.SetField('moco_tipomov',TipoMovimento);
      Sistema.SetField('moco_unid_codigo',Unidade);
      Sistema.SetField('moco_tipo_codigo',Cliente.AsInteger);
      Sistema.SetField('moco_tipocad','F');
      Sistema.SetField('moco_qtde',Texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),linha]) );
      Sistema.SetField('moco_datalcto',Sistema.Hoje);
      Sistema.SetField('moco_datamvto',Emissao);
      Sistema.SetField('moco_unitario',Texttovalor(Grid.Cells[Grid.Getcolumn('move_venda'),linha]));
      Sistema.SetField('moco_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('moco_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('moco_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('moco_usua_codigo',Global.Usuario.codigo);
// 04.09.06
      Sistema.SetField('moco_seq',strtoint(Grid.Cells[Grid.Getcolumn('moco_seq'),linha]) );
// 11.04.08
      Sistema.SetField('moco_cst',Grid.Cells[Grid.Getcolumn('move_cst'),linha]);
      Sistema.SetField('moco_aliicms',Texttovalor(Grid.Cells[Grid.Getcolumn('move_icms'),linha]));
      Sistema.SetField('moco_aliipi',Texttovalor(Grid.Cells[Grid.Getcolumn('move_ipi'),linha]));
      Sistema.SetField('moco_pecas',Texttovalor(Grid.Cells[Grid.Getcolumn('move_pecas'),linha]));
      Sistema.SetField('moco_industrializa',Grid.Cells[Grid.Getcolumn('moco_industrializa'),linha]);
// 09.06.09
      Sistema.SetField('moco_qtderecebida',0); // para 'facilitar' selects...
////////////////
// 01.08.08
      Sistema.Post('');
      Sistema.Edit('estoque');
      Sistema.SetField('esto_precocompra',Texttovalor(Grid.Cells[Grid.Getcolumn('move_venda'),linha]));
      Sistema.post('esto_codigo='+stringtosql(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha]));
    end;
  end;


end;

procedure TFPedcompra.bSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFPedcompra.bIncluiritemClick(Sender: TObject);
begin
  if EdCliente.AsInteger=0 then exit;
  PRemessa.Enabled:=false;
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
  bCancelar.Enabled:=false;
  PINs.Visible:=true;
  PINs.EnableEdits;
  LimpaEditsItens;
  SetaEditsItens;
  EdPecas.Enabled:=Global.Topicos[1302];
  EdProduto.SetFocus;

end;

procedure TFPedcompra.bExcluiritemClick(Sender: TObject);
var codigoestoque:string;
    qtde:currency;
    sqlcor,sqltamanho,sqlcopa:string;
    codcor,codtamanho,codcopa:integer;
begin
  if EdCliente.AsInteger=0 then exit;
  if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row])='' then exit;
  codcor:=strtointdef(Grid.cells[Grid.getcolumn('codcor'),Grid.row],0);
  codtamanho:=strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),Grid.row],0);
  codcopa:=strtointdef(Grid.cells[Grid.getcolumn('codcopa'),Grid.row],0);
  if Codcor>0 then
    sqlcor:=' and moco_core_codigo='+inttostr(codcor)
  else
    sqlcor:=' and moco_core_codigo=0';
  if not EdCodtamanho.isempty then
    sqltamanho:=' and moco_tama_codigo='+inttostr(codtamanho)
  else
    sqltamanho:='';
  if not EdCodcopa.isempty then
    sqlcopa:=' and moco_copa_codigo='+inttostr(codcopa)
  else
    sqlcopa:=' and moco_copa_codigo=0';
  if confirma('Confirma exclus�o ?') then begin
    codigoestoque:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
    qtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
    Grid.DeleteRow(Grid.Row);
    Edtotalremessa.SetValue(Calculatotal);
    if OP='A' then begin
      ExecuteSql('Update movcompras set moco_status=''C'' where moco_status=''N'''+
          ' and moco_numerodoc='+EdNumerodoc.AsSql+
          ' and moco_tipomov='+Stringtosql(TipoMov)+
          ' and moco_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and moco_tipo_codigo='+EdCliente.AsSql+
          ' and moco_esto_codigo='+Stringtosql(codigoestoque)+
          sqlcor+sqltamanho+sqlcopa ) ;
      GravaMestrePedCompras(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             Tipomov,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,Op);

    end;
    Sistema.Commit;
  end;
end;

procedure TFPedcompra.bCancelaritemClick(Sender: TObject);
begin
  if EdCliente.AsInteger=0 then exit;
  bGravar.Enabled:=true;
  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
  PINs.Visible:=false;
  PINs.DisableEdits;
  AtivaEdits;
  PRemessa.Enabled:=true;
  EdCliente.SetFocus;

end;

procedure TFPedcompra.bImpressaoClick(Sender: TObject);
begin

// 24.06.2022
  if Trim(FGeral.GetConfig1AsString('Imprpedidocom'))<>'' then begin

     if EdNumerodoc.asinteger>0 then
       FImpressao.ImprimePedidoCompra(EdNumerodoc.asinteger,EdDtemissao.asdate,edunid_codigo.text,'N',Edtipomov.Text)

  end else

    ImprimePedidoCompra(EdNumerodoc.asinteger,tipomov,semvideo);

end;

procedure TFPedcompra.EdMoes_tabp_codigoExitEdit(Sender: TObject);
begin
  bincluiritemclick(self);
end;

procedure TFPedcompra.EdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
   if key=#27 then begin
    bGravar.Enabled:=true;
     bCancelar.Enabled:=true;
     bSair.Enabled:=true;
     PINs.Visible:=false;
     PINs.DisableEdits;
     AtivaEdits;
     PRemessa.Enabled:=true;
     bgravarclick(self);
   end;
end;

procedure TFPedcompra.EdCodtamanhoValidate(Sender: TObject);
begin
{
  if (Edproduto.enabled) and (OP='A') then begin
    if FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),Edproduto.text,Grid,Grid.getcolumn('codtamanho'),EdCodtamanho.asinteger,Grid.getcolumn('codcor'),EdCodcor.asinteger)>0 then begin
      EdCodtamanho.Invalid('Produto j� existente.  Usar a op��o Alterar');
    end;
  end;
}
end;

function TFPedcompra.ProcuraGrid(Coluna: integer; Pesquisa: string;
  Colunatam, tam, colunacor, cor, colunacopa, copa: integer): integer;
var p:integer;
begin
  result:=0;seq:=0;
// 04.09.06
  for p:=1 to Grid.RowCount do  begin
      if trim(Grid.Cells[Grid.getcolumn('moco_seq'),p])<>'' then begin
        seq:=strtoint(Grid.Cells[Grid.getcolumn('moco_seq'),p]);
        inc(seq);
      end else begin
        if seq=0 then
          seq:=1;
      end;
  end;

//
//  if (colunatam>0) and (colunacor>0) then begin
//    if colunacopa=0 then begin
// 04.09.06
  if (tam>0) and (cor>0) then begin
    if copa=0 then begin
      for p:=1 to Grid.RowCount do  begin
        if (trim(Grid.Cells[Coluna,p])=trim(Pesquisa)) and
         (trim(Grid.Cells[Colunatam,p])=trim(inttostr(tam))) and (trim(Grid.Cells[Colunacor,p])=trim(inttostr(cor))) then begin
          result:=p;
          break;
        end;
        if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
    end else begin
      for p:=1 to Grid.RowCount do  begin
        if (trim(Grid.Cells[Coluna,p])=trim(Pesquisa)) and
         (trim(Grid.Cells[Colunatam,p])=trim(inttostr(tam))) and
         (trim(Grid.Cells[Colunacopa,p])=trim(inttostr(copa))) and
         (trim(Grid.Cells[Colunacor,p])=trim(inttostr(cor))) then begin
          result:=p;
          break;
        end;
        if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
    end;
  end else if (tam=0) and (cor>0) then begin   // 14.04.08
      for p:=1 to Grid.RowCount do  begin
        if (trim(Grid.Cells[Coluna,p])=trim(Pesquisa)) and
         (trim(Grid.Cells[Colunacor,p])=trim(inttostr(cor))) then begin
          result:=p;
          break;
        end;
        if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
  end else begin
    for p:=1 to Grid.RowCount do  begin
      if trim(Grid.Cells[Coluna,p])=trim(Pesquisa) then begin
        result:=p;
        break;
      end;
      if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
        result:=(-1)*p;
        break;
      end;
    end;
  end;
end;

procedure TFPedcompra.ImprimePedidoCompra(numero: integer;  tipomov,video: string);
//////////////////////////////////////////////////////////////////////////////////////
var largura,
    titem,
    nespacos:integer;
    QBusca,TFornec:TSqlquery;
    tqtde,liquido,Tdescacre,totalitem:currency;
    descacre,forma,emails,ind:string;
    ListaCodigos,Dadospeca:String;
    scondensa:Boolean;

begin
///  if not EdCliente.ValidEdiAll(FPedcompra,99) then exit;
//   if confirma('S - Por codigo    N - Por sequencial') then
//     forma:='C'
//   else
     forma:='S';
  QBusca:=sqltoquery(FGeral.buscapedcompra(Numero,tiposmov,forma) );
  if QBusca.Eof then begin
    Avisoerro('Pedido n�o encontrado');
    exit;
  end;

  if not Confirma('Confirma impress�o ?') then exit;
  Sistema.BeginProcess('');
//  largura:=76;
  largura:=80;
//  FTextRel.Init(60);
  FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309]);

  FTextRel.MargemEsquerda:=1;
  FTextRel.Titulo.Clear;
  FTextRel.ClearColunas;
//  FTextrel.SaltaLinha(1);
  if not Arq.TUnidades.Active then Arq.TUnidades.Open;
  if not Arq.TMunicipios.Active then Arq.TMunicipios.Open;
  Arq.TUnidades.Locate('unid_codigo',QBusca.Fieldbyname('Moco_Unid_codigo').Asstring,[]);
  TFornec:=sqltoquery('select * from FORNECEDORES where forn_codigo='+inttostr(QBusca.Fieldbyname('Mocm_tipo_codigo').AsINteger));
  Arq.TMunicipios.Locate('cida_codigo',TFornec.Fieldbyname('forn_cida_codigo').AsInteger,[]);
  if tipomov='OR' then
    FTextRel.AddTitulo(FGeral.Centra('Cota��o de Compras',largura),true,False,false)
  else
    FTextRel.AddTitulo(FGeral.Centra('Pedido de Compras',largura),true,False,false);
  FTextRel.AddTitulo(' Emiss�o......: '+QBusca.fieldbyname('mocm_datamvto').Asstring+space(10)+
                    'Entrega : '+QBusca.fieldbyname('mocm_dataentrega').Asstring+space(13)+
                    'N�mero : '+strzero(QBusca.fieldbyname('mocm_numerodoc').Asinteger,6),false,False,false );
  FTextRel.AddLinha('Unidade......: '+strspace(Arq.TUnidades.Fieldbyname('unid_razaosocial').Asstring,39)+space(06)+
                    'Tel.: '+FGeral.Formatatelefone(Arq.TUnidades.Fieldbyname('unid_fone').Asstring)
                    ,false,False,false);
  FTextRel.AddLinha('Endere�o.....: '+strspace(Arq.TUnidades.Fieldbyname('unid_endereco').Asstring,39)+space(02)+
                    'CNPJ:'+FGeral.Formatacnpjcpf(Arq.TUnidades.Fieldbyname('unid_cnpj').Asstring)
                    ,false,False,false);
  FTextRel.AddLinha('Cep/Cidade/UF: '+FGeral.formatacep(Arq.TUnidades.Fieldbyname('unid_cep').Asstring)+' - '+
                    Arq.TUnidades.Fieldbyname('unid_municipio').Asstring+' - '+
                    strspace(Arq.TUnidades.Fieldbyname('unid_uf').Asstring,02)
                    ,false,False,false);
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
// 10.03.08
  if QBusca.fieldbyname('mocm_tipomov').asstring<>'OR' then begin

    FTextRel.AddLinha('Fornecedor...: '+TFornec.fieldbyname('forn_nome').AsString,false,False,false);
    FTextRel.AddLinha('Codigo.......: '+TFornec.Fieldbyname('forn_codigo').Asstring,false,False,false);
    FTextRel.AddLinha('Raz�o Social : '+strspace(TFornec.Fieldbyname('forn_razaosocial').Asstring,34)+space(01)+
                      'Tel.:'+FGeral.Formatatelefone(TFornec.Fieldbyname('forn_fone').Asstring)
                      ,false,False,false);
    FTextRel.AddLinha('Endere�o.....: '+strspace(TFornec.Fieldbyname('forn_endereco').Asstring,34)+space(01)+
                      'CPF :'+FGeral.Formatacpf(TFornec.Fieldbyname('forn_cnpjcpf').Asstring)
                      ,false,False,false);
    FTextRel.AddLinha('Bairro.......: '+strspace(TFornec.Fieldbyname('forn_bairro').Asstring,50)
                      ,false,False,false);
    FTextRel.AddLinha('Cep/Cidade/UF: '+FGeral.formatacep(TFornec.Fieldbyname('forn_cep').Asstring)+' - '+
                      Arq.TMunicipios.Fieldbyname('cida_nome').Asstring+' - '+
                      strspace(TFornec.Fieldbyname('forn_uf').Asstring,02)
                      ,false,False,false);
    FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);

  end;

//  FTextRel.SaltaLinha(1);
//  FTextRel.AddLinha(space(04)+'Codigo'+space(10)+'Descri��o'+space(31)+'Unidade   Quantidade'+space(08)+'Unit�rio'+space(11)+'Total'
//                    ,false,False,true);
//  FTextRel.AddLinha(space(01)+'Seq Codigo'+space(07)+'Referencia'+space(01)+'Descri��o'+space(21)+'Un.'+space(1)+'Tam.'+space(02)+'Cor'+space(08)+'Copa'+
//                    space(01)+'Quantidade'+space(03)+'Unit�rio'+space(07)+'Total'
// 10.03.08
  dadospeca:='';
  if Global.Topicos[1302] then
    dadospeca:=FGeral.Formatavalor(QBusca.Fieldbyname('Moco_qtde').AsCurrency,'####0.0')+space(01);

  scondensa := True;  // ver

  if scondensa then nespacos := 10 else nespacos := 0;

  if QBusca.fieldbyname('mocm_tipomov').asstring<>'OR' then begin

    if Global.Topicos[1302] then
      FTextRel.AddLinha(space(01)+'Seq Codigo'+space(07)+'Referencia'+space(01)+'Descri��o'+space(14)+'Ind. '+'Un.'+space(1)+'Tam.'+space(03)+
                    'Cor'+space(10)+'Pe�as Qtde'+space(03)+'Unit�rio'+space(07)+'Total'
                    ,false,False,true)
    else begin

      if Global.Topicos[1309] then
        FTextRel.AddLinha(space(01)+'Seq Codigo'+space(07)+'Referencia'+space(01)+'Descri��o'+space(14)+'Ind. '+'Un.'+space(1)+'Tam.'+space(03)+
                    'Cor'+space(10)+'Qtde'+space(03)+'Unit�rio'+space(07)+'Total'
                    ,false,False,true)
      else if Global.Topicos[1209] then begin

        if scondensa then
           FTextRel.AddLinha(space(01)+'Seq Codigo'+space(07)+'Referencia'+
                    space(04)+'Descri��o'+space(42)+'Un.'+
                    space(05)+
                    'Qtde'+space(05)+'Unit�rio'+
                    space(06)+'Total'
                    ,false,False,scondensa)
        else
           FTextRel.AddLinha(space(01)+'Seq Codigo'+space(07)+'Referencia'+space(01)+'Descri��o'+space(14)+'Un.'+space(01)+
                    'Qtde'+space(03)+'Unit�rio'+space(02)+'Total'
                    ,false,False,False);

      end else
        FTextRel.AddLinha(space(01)+'Seq Codigo'+space(07)+'Descri��o'+space(14)+'Ind. '+'Un.'+space(3)+
                    'Qtde'+space(03)+'Unit�rio'+space(07)+'Total'
                    ,false,False,false);
    end;
  end else begin
    if Global.Topicos[1302] then
      FTextRel.AddLinha(space(01)+'Seq Codigo'+space(07)+'Referencia'+space(01)+'Descri��o'+space(21)+'Un.'+space(1)+'Tam.'+space(03)+
                    'Cor'+space(10)+'Pe�as Qtde'
                    ,false,False,false)
 // 13.06.2022
    else if Global.Topicos[1309] then

      FTextRel.AddLinha(space(01)+'Seq Codigo'+space(07)+'Referencia'+space(01)+'Descri��o'+space(21)+'Un.'+space(1)+'Tam.'+space(03)+
                    'Cor'+space(10)+'Qtde'
                    ,false,False,false)

    else

      FTextRel.AddLinha(space(01)+'Seq Codigo'+space(07)+'Referencia'+space(01)+'Descri��o'+space(21)+'Un.'+
                    space(10)+'Qtde'
                    ,false,False,false);
  end;
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
  tqtde:=0;titem:=0;
  if not Arq.TTabelaPreco.active then Arq.TTabelaPreco.open;
  if Arq.TTabelaPreco.Locate('tabp_codigo',QBusca.Fieldbyname('Mocm_tabp_codigo').AsInteger,[]) then begin
    descacre:=Arq.TTabelaPreco.Fieldbyname('tabp_tipo').AsString;
  end else
    descacre:='';

  while not QBusca.Eof do begin

    totalitem:=FGeral.Arredonda(QBusca.Fieldbyname('Moco_unitario').AsCurrency*QBusca.Fieldbyname('Moco_qtde').AsCurrency,2);
//    if ( QBusca.Fieldbyname('Moco_tama_codigo').AsInteger=0 ) and ( QBusca.Fieldbyname('Moco_core_codigo').AsInteger=0 ) then
//      FTextRel.AddLinha(space(04)+strspace(QBusca.Fieldbyname('Moco_esto_codigo').AsString,13)+space(03)+
//                    strspace(FEstoque.GetDescricao(QBusca.Fieldbyname('Moco_esto_codigo').AsString),45)+
//                    strspace(FEstoque.getunidade(QBusca.Fieldbyname('Moco_esto_codigo').AsString),04)+
//                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_qtde').AsCurrency,'###,##0.000')+space(02)+
//                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_unitario').AsCurrency,f_cr)+space(02)+
//                    FGeral.Formatavalor(totalitem,f_cr)
//                    ,false,False,true)
//    else
// 10.03.08
  if QBusca.fieldbyname('mocm_tipomov').asstring<>'OR' then begin

      ind := ' ';
      if QBusca.Fieldbyname('Moco_industrializa').AsString='N' then
        ind:=QBusca.Fieldbyname('Moco_industrializa').AsString;
      if Global.Topicos[1309] then
        FTextRel.AddLinha(space(01)+strzero(QBusca.Fieldbyname('Moco_seq').AsInteger,3)+space(01)+
                    strspace(QBusca.Fieldbyname('Moco_esto_codigo').AsString,12)+space(01)+
                    strspace(QBusca.Fieldbyname('esto_referencia').AsString,10)+space(01)+
                    strspace(QBusca.Fieldbyname('esto_descricao').AsString,25)+space(01)+
                    ind+space(01)+
//                    strspace(FEstoque.GetDescricao(QBusca.Fieldbyname('Moco_esto_codigo').AsString),35)+space(01)+
//                    strspace(FEstoque.getunidade(QBusca.Fieldbyname('Moco_esto_codigo').AsString),04)+
                    strspace(QBusca.Fieldbyname('esto_unidade').AsString,04)+
                    strspace(FTamanhos.GetDescricao(QBusca.Fieldbyname('Moco_tama_codigo').AsInteger),06)+
                    strspace(Fcores.GetDescricao(QBusca.Fieldbyname('Moco_core_codigo').AsInteger),10)+
//                    strspace(Fcopas.GetDescricao(QBusca.Fieldbyname('Moco_copa_codigo').AsInteger),03)+space(03)+
                    space(03)+
//                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_pecas').AsCurrency,'####0')+space(01)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_qtde').AsCurrency,'####0.0')+space(01)+
                    dadospeca+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_unitario').AsCurrency,'##,##0.00')+space(02)+
                    FGeral.Formatavalor(totalitem,'####,##0.00')
                    ,false,False,true)
      else if Global.Topicos[1209] then

          if scondensa then

             FTextRel.AddLinha(space(01)+strzero(QBusca.Fieldbyname('Moco_seq').AsInteger,3)+space(02)+
                    strspace(QBusca.Fieldbyname('Moco_esto_codigo').AsString,12)+space(02)+
                    strspace(QBusca.Fieldbyname('esto_referencia').AsString,10)+space(02)+
                    strspace(QBusca.Fieldbyname('esto_descricao').AsString,50)+space(01)+
                    strspace(QBusca.Fieldbyname('esto_unidade').AsString,04)+
                    space(02)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_qtde').AsCurrency,'####0.0')+
                    space(02)+
                    dadospeca+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_unitario').AsCurrency,'##,##0.00')+
                    space(02)+
                    FGeral.Formatavalor(totalitem,'####,##0.00')
                    ,false,False,scondensa)

          else

             FTextRel.AddLinha(space(01)+strzero(QBusca.Fieldbyname('Moco_seq').AsInteger,3)+space(01)+
                    strspace(QBusca.Fieldbyname('Moco_esto_codigo').AsString,12)+space(01)+
                    strspace(QBusca.Fieldbyname('esto_referencia').AsString,10)+space(01)+
                    strspace(QBusca.Fieldbyname('esto_descricao').AsString,25)+space(01)+
//                    ind+space(01)+
// 15.06.2022
//                    strspace(QBusca.Fieldbyname('esto_descricao').AsString,38)+
                    space(01)+
//                    strspace(FEstoque.GetDescricao(QBusca.Fieldbyname('Moco_esto_codigo').AsString),35)+space(01)+
//                    strspace(FEstoque.getunidade(QBusca.Fieldbyname('Moco_esto_codigo').AsString),04)+
                    strspace(QBusca.Fieldbyname('esto_unidade').AsString,04)+
//                    strspace(FTamanhos.GetDescricao(QBusca.Fieldbyname('Moco_tama_codigo').AsInteger),06)+
//                    strspace(Fcores.GetDescricao(QBusca.Fieldbyname('Moco_core_codigo').AsInteger),10)+
//                    strspace(Fcopas.GetDescricao(QBusca.Fieldbyname('Moco_copa_codigo').AsInteger),03)+space(03)+
                    space(01)+
//                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_pecas').AsCurrency,'####0')+space(01)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_qtde').AsCurrency,'####0.0')+space(01)+
                    dadospeca+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_unitario').AsCurrency,'##,##0.00')+space(02)+
                    FGeral.Formatavalor(totalitem,'####,##0.00')
                    ,false,False,False)

      else

        FTextRel.AddLinha(space(01)+strzero(QBusca.Fieldbyname('Moco_seq').AsInteger,3)+space(01)+
                    strspace(QBusca.Fieldbyname('Moco_esto_codigo').AsString,12)+space(01)+
                    strspace(QBusca.Fieldbyname('esto_descricao').AsString,25)+space(01)+
                    ind+space(01)+
//                    strspace(FEstoque.GetDescricao(QBusca.Fieldbyname('Moco_esto_codigo').AsString),35)+space(01)+
//                    strspace(FEstoque.getunidade(QBusca.Fieldbyname('Moco_esto_codigo').AsString),04)+
                    strspace(QBusca.Fieldbyname('esto_unidade').AsString,03)+
//                    strspace(FTamanhos.GetDescricao(QBusca.Fieldbyname('Moco_tama_codigo').AsInteger),06)+
//                    strspace(Fcores.GetDescricao(QBusca.Fieldbyname('Moco_core_codigo').AsInteger),10)+
//                    strspace(Fcopas.GetDescricao(QBusca.Fieldbyname('Moco_copa_codigo').AsInteger),03)+space(03)+
                    space(01)+
//                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_pecas').AsCurrency,'####0')+space(01)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_qtde').AsCurrency,'####0.0')+space(01)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_unitario').AsCurrency,'##,##0.00')+space(01)+
                    FGeral.Formatavalor(totalitem,'####,##0.00')
                    ,false,False,false);

    end else begin

 // 13.06.2022
      if  Global.Topicos[1309] then

          FTextRel.AddLinha(space(01)+strzero(QBusca.Fieldbyname('Moco_seq').AsInteger,3)+space(01)+
                    strspace(QBusca.Fieldbyname('Moco_esto_codigo').AsString,12)+space(01)+
                    strspace(QBusca.Fieldbyname('esto_referencia').AsString,10)+space(01)+
                    strspace(QBusca.Fieldbyname('esto_descricao').AsString,29)+space(01)+
                    strspace(QBusca.Fieldbyname('esto_unidade').AsString,04)+
                    strspace(FTamanhos.GetDescricao(QBusca.Fieldbyname('Moco_tama_codigo').AsInteger),06)+
                    strspace(Fcores.GetDescricao(QBusca.Fieldbyname('Moco_core_codigo').AsInteger),09)+
                    space(01)+
                    dadospeca+
//                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_pecas').AsCurrency,'####0')+space(01)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_qtde').AsCurrency,'####0')
                    ,false,False,false)

      else

          FTextRel.AddLinha(space(01)+strzero(QBusca.Fieldbyname('Moco_seq').AsInteger,3)+space(01)+
                    strspace(QBusca.Fieldbyname('Moco_esto_codigo').AsString,12)+space(01)+
                    strspace(QBusca.Fieldbyname('esto_referencia').AsString,10)+space(01)+
                    strspace(QBusca.Fieldbyname('esto_descricao').AsString,29)+space(01)+
                    strspace(QBusca.Fieldbyname('esto_unidade').AsString,04)+
                    space(10)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Moco_qtde').AsCurrency,'####0')
                    ,false,False,false);

    end;

    inc(titem);
    tqtde:=tqtde+QBusca.Fieldbyname('Moco_qtde').AsCurrency;
    QBusca.next;

  end;

  QBusca.First;
// 24.06.2022
  if trim(campoobs.tipo) <> '' then begin

     FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
     FTextRel.AddLinha('Observa��o : '+copy(QBusca.fieldbyname('mocm_obspedido').AsString,1,66),false,False,false);
     FTextRel.AddLinha(copy(QBusca.fieldbyname('mocm_obspedido').AsString,67,79),false,False,false);

  end;

  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
// 10.03.08
  if QBusca.fieldbyname('mocm_tipomov').asstring<>'OR' then
    FTextRel.AddLinha(space(30)+'Total Mercadorias....: R$ '+FGeral.Formatavalor(QBusca.fieldbyname('mocm_vlrtotal').AsCurrency,f_cr),false,False,false);
  tdescacre:=FGeral.Arredonda(QBusca.fieldbyname('mocm_vlrtotal').AsCurrency*(QBusca.fieldbyname('mocm_tabaliquota').AsCurrency/100) ,2);

  if descacre='D' then begin
    FTextRel.AddLinha(space(30)+'Desconto sobre total.: R$ '+FGeral.Formatavalor(tdescacre,'###,##0.00'),false,False,false);
    liquido:=QBusca.fieldbyname('mocm_vlrtotal').AsCurrency-tdescacre;
  end else if descacre='A' then begin
    liquido:=QBusca.fieldbyname('mocm_vlrtotal').AsCurrency+tdescacre;
    FTextRel.AddLinha(space(30)+'Acr�scimo sobre total: R$ '+FGeral.Formatavalor(tdescacre,'###,##0.00'),false,False,false);
  end;
  if tdescacre>0 then
    FTextRel.AddLinha(space(30)+'Total l�quido........: R$ '+FGeral.Formatavalor(liquido,f_cr),false,False,false);

  FTextRel.AddLinha(strspace('_________________________',30)+'Total em Quantidade..:       '+FGeral.Formatavalor(tqtde,'####,##0.00'),false,False,false);
  FTextRel.AddLinha(strspace('Autorizado',30)+'Total de Itens.......:    '+FGeral.Formatavalor(titem,'####'),false,False,false);
  FTextRel.SaltaLinha(1);
  FTextRel.AddLinha(strspace('Solicitante:'+strzero(QBusca.fieldbyname('mocm_usua_codigo').asinteger,3)+
          '-'+Fusuarios.Getnome(QBusca.fieldbyname('mocm_usua_codigo').asinteger),30)+
          space(06)+'Condi��o Pagamento:'+FCondpagto.Getdescricao(QBusca.fieldbyname('mocm_fpgt_codigo').asstring),false,False,false);
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
// 06.06.06
  FTextRel.AddLinha('Forma de entrega:'+QBusca.fieldbyname('mocm_formaentrega').asstring,false,False,false);

//  if video='N' then
//    FTextRel.Video(TFornec.fieldbyname('forn_email').AsString);
    listacodigos:=EdFornecedores.text;
    if QBusca.fieldbyname('mocm_tipomov').asstring<>'OR' then
      emails:=TFornec.fieldbyname('forn_email').AsString
    else
      emails:=FFornece.Getemails(listacodigos);

    FPedcompra.SendToBack;  // 11.03.08

    FTextRel.Video(emails);
//  else begin
//    FGeral.Imprimesemvideo(FTextrel.PaginaAtual);
//  end;

  Sistema.EndProcess('');
  FGeral.Fechaquery(QBusca);

end;

procedure TFPedcompra.EdtipomovValidate(Sender: TObject);
begin
   tipomov:=EdTipomov.text;
   if tipomov<>'OR' then begin
     EdFornecedores.enabled:=false;
     EdFornecedores.text:='';
   end else
     EdFornecedores.enabled:=true;
end;

procedure TFPedcompra.bexcluirpedidoClick(Sender: TObject);
var Q:TSqlquery;
    Lista:TStringlist;
    p:integer;
begin
   if not EdNUmerodoc.valid then exit;
   if not confirma('Confirma exclus�o do pedido ?') then exit;
   Sistema.beginprocess('Excluindo pedido');
   Sistema.Edit('movcomp');
   Sistema.setfield('mocm_status','C');
   Sistema.setfield('mocm_usua_codigo',global.usuario.codigo);
   Sistema.post('mocm_numerodoc='+EdNumerodoc.assql);
   Sistema.Edit('movcompras');
   Sistema.setfield('moco_status','C');
   Sistema.post('moco_numerodoc='+EdNumerodoc.assql);
//   if Edtipomov.text='PU' then begin
   if pos(Edtipomov.text,'PU;PX')>0 then begin
     Sistema.Edit('pendencias');
     Sistema.setfield('pend_status','C');
     Sistema.post('pend_numerodcto='+EdNumerodoc.assql+' and pend_status=''H''');
   end;
// 08.08.08 - libera remessas utilizadas para fazer o or�amento/pedido compra
   if Global.topicos[1204] then begin
      Q:=sqltoquery('select mocm_transreq from movcomp where mocm_numerodoc='+EdNumerodoc.assql);
      if not Q.eof then begin
        if trim(Q.fieldbyname('mocm_transreq').asstring)<>'' then begin
          Lista:=TStringlist.create;
          strtolista(Lista,Q.fieldbyname('mocm_transreq').asstring,';',true);
          for p:=0 to Lista.count-1 do begin
            if trim(lista[p])<>'' then begin
              Sistema.edit('movesto');
              Sistema.SetField('moes_remessas','');
              Sistema.post('moes_transacao='+stringtosql(Lista[p]));
            end;
          end;
        end;
      end;
      FGeral.fechaquery(Q);
   end;
   try
     Sistema.commit;
   except
     Avisoerro('N�o foi poss�vel executar esta opera��o'); 
   end;
   Sistema.endprocess('');
   Grid.clear;
   EdNumerodoc.clearall(FPedcompra,99);
   EdNUmerodoc.setfocus;
end;

procedure TFPedcompra.bcompramaterialClick(Sender: TObject);
begin

  ImprimeCompraMaterial(EdNumerodoc.asinteger,tipomov,semvideo);


end;

procedure TFPedcompra.ImprimeCompraMaterial(numero:integer ; tipomov,video:string);
////////////////////////////////////////////////////////////////////////////////////////
type TMateriais=record
    codigomat,referencia,unidade:string;
    qtde,qtdeestoque:currency;
    tamanho,cor:integer;
end;

var QBusca,QMaterial:TSqlquery;
    Produto,sqltamanho,sqlcor,sqlcopa:string;
    Lista:TList;
    PMateriais:^TMateriais;
    x,fornec:integer;
    Datapedido:TDatetime;
    falta:currency;

    procedure AtualizaMaterial(codigo,unidadepro:string ; codtamanho,codcor:integer ; qtdematerial,qtdeproduto,estoque:currency );
    /////////////////////////////////////////////////////////////////////////////////////////////
    var i:integer;
        achou:boolean;
    begin
      achou:=false;
      for i:=0 to Lista.count-1 do  begin
        PMateriais:=Lista[i];
//        if (PMateriais.codigomat=codigo) and (PMateriais.tamanho=codtamanho) and (PMateriais.cor=codcor) then begin
// 17.06.17
        if (PMateriais.codigomat=codigo)  then begin
          achou:=true;
          break;
        end;
      end;
      if not Achou then begin
        New(PMateriais);
        PMateriais.codigomat:=codigo;
        PMateriais.tamanho:=codtamanho;
        PMateriais.cor:=codcor;
        PMateriais.unidade:=unidadepro;
// 23.05.12 - Damama
        if pos( trim( PMateriais.unidade ),UnidadesDivideComposicao ) >0 then
          PMateriais.qtde:=qtdematerial*(qtdeproduto/DivideComposicao)
        else
          PMateriais.qtde:=qtdematerial*qtdeproduto;
        PMateriais.qtdeestoque:=estoque;
        PMateriais.referencia:=QMaterial.fieldbyname('esto_referencia').asstring;
        Lista.add(PMateriais);
      end else begin
// 23.05.12 - Damama
        if pos( trim( PMateriais.unidade ),UnidadesDivideComposicao ) >0 then
          PMateriais.qtde:=PMateriais.qtde+( qtdematerial*(qtdeproduto/DivideComposicao) )
        else
        PMateriais.qtde:=PMateriais.qtde+( qtdematerial*qtdeproduto );
      end;

    end;

begin
///////////////////////////////////////////////////////////////////////////

  if not Sistema.GetPeriodo('Informe o per�odo') then exit;

//  QBusca:=sqltoquery(FGeral.buscapedcompra(Numero,tiposmov));
  Qbusca:=sqltoquery('select * from movcompras '+
          ' inner join movcomp on ( mocm_numerodoc=moco_numerodoc and mocm_status=moco_status )'+
          ' left join estoque on ( esto_codigo=moco_esto_codigo )'+
          ' where mocm_datamvto >= '+datetosql(Sistema.Datai)+
          ' and mocm_datamvto <= '+Datetosql(Sistema.Dataf)+
          ' and moco_status=''N''' +
          ' and mocm_tipomov=moco_tipomov'+
          ' order by mocm_datamvto');

  if QBusca.Eof then begin
    Avisoerro('Nenhum Pedido encontrado neste per�odo');
    exit;
  end;
  if not Confirma('Confirma impress�o ?') then exit;
  Datapedido:=QBusca.fieldbyname('mocm_datamvto').asdatetime;
  Fornec:=QBusca.fieldbyname('mocm_tipo_codigo').asinteger;
  Sistema.beginprocess('Calculando mat�ria prima');
  Lista:=TList.create;
  while not QBusca.eof do begin
    Produto:=QBusca.fieldbyname('moco_esto_codigo').asstring;
    if QBusca.fieldbyname('moco_tama_codigo').asinteger>0 then
      sqltamanho:=' and cust_tama_codigo='+Qbusca.fieldbyname('moco_tama_codigo').asstring
    else
      sqltamanho:=' and cust_tama_codigo=0';
    if Qbusca.fieldbyname('moco_core_codigo').asinteger>0 then
      sqlcor:=' and cust_core_codigo='+Qbusca.fieldbyname('moco_core_codigo').asstring
    else
      sqlcor:=' and cust_core_codigo=0';
    if Qbusca.fieldbyname('moco_copa_codigo').asinteger>0 then
      sqlcopa:=' and cust_copa_codigo='+Qbusca.fieldbyname('moco_copa_codigo').asstring
    else
      sqlcopa:=' and cust_copa_codigo=0';
    QMaterial:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
                ' inner join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Global.Unidadematriz)+' )'+
                ' where cust_status=''N'' and cust_esto_codigo='+stringtosql(Produto)+
                 sqlcor+sqltamanho+sqlcopa+' order by cust_esto_codigomat');
    while not QMaterial.eof do begin
      Atualizamaterial(QMaterial.fieldbyname('cust_esto_codigomat').asstring,
                       QMaterial.fieldbyname('esto_unidade').asstring,
                       QMaterial.fieldbyname('cust_tama_codigo').asinteger,
                       QMaterial.fieldbyname('cust_core_codigo').asinteger,
                       QMaterial.fieldbyname('cust_qtde').ascurrency,
                       QBusca.fieldbyname('moco_qtde').ascurrency,QMaterial.fieldbyname('esqt_qtdeprev').ascurrency );
      QMaterial.Next;
    end;
    FGeral.fechaquery(QMaterial);
    QBusca.next;
  end;

   FRel.init('CompraMateriaPrima');
   FRel.AddTit('Compra de Mat�ria Prima');
//   FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
//   FRel.AddTit('Material referente Pedido de Compra '+inttostr(NUmero)+' de '+FGeral.formatadata(datapedido));
   FRel.AddTit('Material referente aos Pedidos de Compra de '+FGeral.formatadata(Sistema.Datai)+' a '+FGeral.formatadata(Sistema.Dataf));
   FRel.AddTit('Fornecedor '+inttostr(Fornec)+' - '+FGeral.GetNomeRazaoSocialEntidade(fornec,'F','N'));
   FRel.AddCol(080,1,'N','' ,''              ,'Material'       ,''         ,'',false);
   FRel.AddCol(080,1,'C','' ,''              ,'Refer�ncia'               ,''         ,'',false);
   FRel.AddCol(180,1,'C','' ,''              ,'Descri��o Material'       ,''         ,'',false);
//   FRel.AddCol(050,1,'C','' ,''              ,'Tamanho'                  ,''         ,'',false);
//   FRel.AddCol(060,1,'C','' ,''              ,'Cor'                      ,''         ,'',false);
   FRel.AddCol(070,3,'N','+','##,##0.000'               ,'Quantidade'     ,''         ,'',false);
   FRel.AddCol(070,1,'C',''           ,''              ,'Unidade'        ,''         ,'',false);
   FRel.AddCol(070,3,'N',''           ,f_cr            ,'Valor Unit�rio' ,''         ,'',false);
   FRel.AddCol(070,3,'N','+'          ,f_cr            ,'Valor Total'    ,''         ,'',false);
   FRel.AddCol(070,3,'N','+','##,##0.000'               ,'Estoque'        ,''         ,'',false);
   FRel.AddCol(070,3,'N','+','##,##0.000'               ,'Falta'          ,''         ,'',false);
   for x:=0 to LIsta.count-1 do begin
     PMateriais:=lista[x];
     FRel.AddCel(PMateriais.codigomat);
     FRel.AddCel(PMateriais.referencia);
     FRel.AddCel(FEstoque.Getdescricao(PMateriais.codigomat));
//     FRel.AddCel(FTamanhos.Getdescricao(PMateriais.tamanho));
//     FRel.AddCel(FCores.GetDescricao(PMateriais.cor));
     FRel.AddCel(floattostr(PMateriais.qtde));
     FRel.AddCel(FEstoque.Getunidade(PMateriais.codigomat));
     FRel.AddCel( floattostr( FEstoque.GetCusto(PMateriais.codigomat,Global.unidadematriz,'custo') ) );
     FRel.AddCel( floattostr( FEstoque.GetCusto(PMateriais.codigomat,Global.unidadematriz,'custo') * PMateriais.qtde ) );
     FRel.AddCel(floattostr(PMateriais.qtdeestoque));
     if PMateriais.qtdeestoque>=PMateriais.qtde then
       falta:=0
     else
       falta:=PMateriais.qtde-PMateriais.qtdeestoque;
     FRel.AddCel(floattostr(falta));
   end;
   FRel.video;
  Lista.clear;
  Lista.free;
  sistema.endprocess('');
end;


procedure TFPedcompra.EdPagtoValidate(Sender: TObject);
begin
   if FCondpagto.GetAvPz(EdPagto.text)='V' then
     EdPagto.invalid('Pedido n�o pode ser a vista');
end;

procedure TFPedcompra.bbaixaitemClick(Sender: TObject);
var qtde:currency;
begin
  if EdCliente.AsInteger=0 then exit;
  if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row])='' then exit;
  PBaixa.visible:=true;
  PBaixa.EnableEdits;
  Grid.enabled:=false;
  qtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
  Edqtdebaixa.setvalue(qtde);;
  Edqtdebaixa.setfocus;
end;

procedure TFPedcompra.EdQtdebaixaExitEdit(Sender: TObject);
var codigoestoque:string;
    qtde:currency;
    codcor,codtamanho,codcopa:integer;
    sqlcor,sqltamanho,sqlcopa:string;
begin
  codcor:=strtointdef(Grid.cells[Grid.getcolumn('codcor'),Grid.row],0);
  codtamanho:=strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),Grid.row],0);
  codcopa:=strtointdef(Grid.cells[Grid.getcolumn('codcopa'),Grid.row],0);
  if Codcor>0 then
    sqlcor:=' and moco_core_codigo='+inttostr(codcor)
  else
    sqlcor:=' and moco_core_codigo=0';
  if not EdCodtamanho.isempty then
    sqltamanho:=' and moco_tama_codigo='+inttostr(codtamanho)
  else
    sqltamanho:='';
  if not EdCodcopa.isempty then
    sqlcopa:=' and moco_copa_codigo='+inttostr(codcopa)
  else
    sqlcopa:=' and moco_copa_codigo=0';
  if confirma('Confirma Baixa ?') then begin
    codigoestoque:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
    ExecuteSql('Update movcompras set moco_qtderecebida='+Edqtdebaixa.assql+' where moco_status=''N'''+
          ' and moco_numerodoc='+EdNumerodoc.AsSql+
          ' and moco_tipomov='+Stringtosql(TipoMov)+
          ' and moco_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and moco_tipo_codigo='+EdCliente.AsSql+
          ' and moco_esto_codigo='+Stringtosql(codigoestoque)+
          sqlcor+sqltamanho+sqlcopa ) ;
    Sistema.Commit;
  end;

  PBaixa.visible:=false;
  PBaixa.DisableEdits;
  Grid.enabled:=true;

end;

procedure TFPedcompra.EdQtdebaixaValidate(Sender: TObject);
var qtde:currency;
begin
  qtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
  if EdQtdebaixa.ascurrency>qtde then
    EdQtdebaixa.invalid('Aten��o.  Quantidade recebida maior que a pedida');

end;

procedure TFPedcompra.bsalvarcomoClick(Sender: TObject);
var Numero:integer;
begin
   if EdNUmerodoc.isempty then exit;
   if not confirma('Confirma ?') then exit;
   OP:='I';
   Sistema.BeginTransaction('Gravando novo pedido');
      Numero:=FGeral.GetContador('PEDCOMPRA',false);
//      EdNumerodoc.Text:=inttostr(Numero);
      Transacao:=FGeral.Gettransacao;
      if Tipomov='OR' then tipomov:='PU';   // 12.03.08 - para aproveitar or�amentos
      GravaMestrePedCompras(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             Tipomov,Transacao,Numero,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger);
      GravaItensPedCompras(EdDtEmissao.AsDate,EdCliente,EdUnid_codigo.text,
             TipoMOv,Transacao,Numero,Grid);
   Sistema.EndTransaction('Gravado pedido '+inttostr(numero));
end;

procedure TFPedcompra.EdUnitarioValidate(Sender: TObject);
begin
  if (Edunitario.asfloat=0) and (EdTipomov.text<>'OR') then
    EdUnitario.Invalid('Valor zerado somente em or�amentos');
end;

procedure TFPedcompra.SetaEditsItens;
begin
  if OP<>'A' then exit;
  if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),grid.row])<>'' then begin
    EdProduto.text:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),grid.row];
    EdQtde.setvalue(Texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),grid.row]));
    EdUnitario.setvalue(Texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),grid.row]));
    EdPecas.setvalue(Texttovalor(Grid.Cells[Grid.getcolumn('move_pecas'),grid.row]));
    Edicms.setvalue(Texttovalor(Grid.Cells[Grid.getcolumn('move_icms'),grid.row]));
    Edipi.setvalue(Texttovalor(Grid.Cells[Grid.getcolumn('move_ipi'),grid.row]));
    EdCodcor.Text:=Grid.Cells[Grid.getcolumn('codcor'),grid.row];
    EdCodtamanho.Text:=Grid.Cells[Grid.getcolumn('codtamanho'),grid.row];
    EdServicos.text:=Grid.Cells[Grid.getcolumn('moco_industrializa'),grid.row];
    EdProduto.ValidFind;
  end;

end;

////////////////////16.04.08
function TFPedcompra.GetSeIndustrializa(pedido: integer; produto: string;  codigocor: Integer): string;
var Q:TSqlquery;
    sqlcor:string;
begin
  if codigocor>0 then
    sqlcor:=' and moco_core_codigo='+inttostr(codigocor)
  else
    sqlcor:=' and ( (moco_core_codigo=0) or (moco_core_codigo is null) )';
   Q:=sqltoquery('select moco_industrializa from movcompras where moco_status=''N'' and moco_numerodoc='+inttostr(pedido)+
                  ' and moco_unid_codigo='+stringtosql(Global.CodigoUnidade)+' and moco_esto_codigo='+stringtosql(produto)+sqlcor);
   if not Q.eof then
     result:=Q.fieldbyname('moco_industrializa').AsString
   else
     result:='S';
   FGeral.FechaQuery(Q);
end;




procedure TFPedcompra.EdObrasValidate(Sender: TObject);
begin
   if Edobras.isempty then EdPerfilaces.Enabled:=false
   else EdPerfilaces.Enabled:=true;
end;

procedure TFPedcompra.bbuscareqClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var Q:TSqlquery;
    inicio:TDatetime;
begin
   if EdUnid_codigo.IsEmpty then exit;
   inicio:=Sistema.hoje-365;   // 27.05.13
   Q:=sqltoquery('select * from movesto'+
                 ' where moes_status=''R'''+
                 ' and moes_unid_codigo='+stringtosql(EdUnid_codigo.text)+
                 ' and ( (moes_remessas is null) or (moes_remessas='+stringtosql('')+') )'+
                 ' and moes_datamvto >= '+DatetoSql(inicio)+
                 ' and moes_tipomov='+stringtosql(Global.CodRequisicaoAlmox));
   EdObras.items.clear;
   sistema.beginprocess('pesquisando requisi��es em aberto');
   transacoesreq:='';
   while not Q.eof do begin
       EdObras.Items.Add(strspace(Q.fieldbyname('moes_numerodoc').AsString,9)+' - '+FGeral.formatadata(Q.fieldbyname('moes_dataemissao').AsDatetime)+
          ' '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').AsInteger,'C','N') );
       transacoesreq:=transacoesreq+Q.fieldbyname('moes_transacao').AsString+';';
       Q.Next;
   end;
   sistema.endprocess('Terminado');



end;

procedure TFPedcompra.EdPerfilacesValidate(Sender: TObject);
var sqltipo,status,sqlproduto:string;
    grupoperfil,p:integer;
    Q,QE:TSqlquery;
    qtde:currency;
    comestoque:boolean;
begin
   if EdObras.IsEmpty then exit;
   if FGeral.GetConfig1AsString('REFPERFIS')='' then begin
       Avisoerro('Configura��o dos perfis n�o configurada nas config. gerais');
       exit;
   end;
   comestoque:=Confirma('Considerar estoque ?');
   sqltipo:=' and move_tipomov='+stringtosql(Global.CodRequisicaoAlmox);
   status:='R';
   GrupoPerfil:=FGeral.getconfig1asinteger('GRUPOPERF');
   if (EdPerfilaces.Text='P') and ( Grupoperfil=0 ) then begin
     EdPerfilaces.invalid('Grupo padr�o referente Perfis do estoque n�o configurado');
     exit;
   end;
   sqlproduto:='';
{ - 09.10.08 - tem q ser pela referencia mas nao tem no movimento
   if EdPerfilaces.Text='P' then begin
//     sqlproduto:=' and esto_grup_codigo='+inttostr(grupoperfil)
       sqlproduto:=' and substr(move_esto_codigo,1,2) in ('+stringtosql(FGeral.GetConfig1AsString('REFPERFIS'))+')';
   end else if EdPerfilaces.Text='A' then begin
//     sqlproduto:=' and esto_grup_codigo<>'+inttostr(grupoperfil);
       sqlproduto:=' and substr(move_esto_codigo,1,2) not in ('+stringtosql(FGeral.GetConfig1AsString('REFPERFIS'))+')';
   end;
}
   Sistema.BeginProcess('Pesquisando requisi��es');
   Q:=sqltoquery('select move_esto_codigo,move_core_codigo,move_tama_codigo,sum(move_qtde) as move_qtde from movestoque'+
                 ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
//                 ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
//                 ' left join cores on ( core_codigo=move_core_codigo )'+
//                 ' left join tamanhos on ( tama_codigo=move_tama_codigo )'+
                 ' where move_status='+stringtosql(status)+
                 ' and '+FGeral.GetIN('move_numerodoc',EdObras.text,'N')+
                 ' and move_unid_codigo='+EdUnid_codigo.assql+
                 ' and ( (moes_remessas is null) or (moes_remessas='+stringtosql('')+') )'+
                 sqltipo+sqlproduto+
                 ' group by move_esto_codigo,move_core_codigo,move_tama_codigo'+
                 ' order by move_esto_codigo');
   Grid.clear;
   p:=1;
   while not Q.eof do begin
      QE:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(Q.fieldbyname('move_esto_codigo').Asstring));
      if ( (pos(EdPerfilaces.Text,'P')>0) and ( pos(copy(QE.fieldbyname('esto_referencia').asstring,1,2),FGeral.GetConfig1AsString('REFPERFIS'))>0 ) ) OR
         ( (pos(EdPerfilaces.Text,'A')>0) and ( pos(copy(QE.fieldbyname('esto_referencia').asstring,1,2),FGeral.GetConfig1AsString('REFPERFIS'))=0 ) ) OR
         ( EdPerfilaces.text='T' )
      then begin
        Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]:=Q.fieldbyname('move_esto_codigo').Asstring;
        Grid.Cells[Grid.Getcolumn('esto_descricao'),p]:=FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').Asstring);
        if comestoque then
          qtde:=Q.fieldbyname('move_qtde').Ascurrency-FEstoque.GetQtdeEmEstoque( EdUnid_codigo.text,Q.fieldbyname('move_esto_codigo').Asstring,Q.fieldbyname('move_core_codigo').AsInteger,Q.fieldbyname('move_tama_codigo').AsInteger)
        else
          qtde:=Q.fieldbyname('move_qtde').Ascurrency ;
        if qtde<0 then qtde:=0;
        Grid.Cells[Grid.Getcolumn('move_qtde'),p]:=transform(qtde,f_cr);
        Grid.Cells[Grid.Getcolumn('move_venda'),p]:=transform( QE.fieldbyname('esto_precocompra').Ascurrency,f_cr3);
        Grid.Cells[Grid.Getcolumn('total'),p]:=transform(FGeral.Arredonda(QE.fieldbyname('esto_precocompra').Ascurrency*qtde,2),f_cr);
        Grid.Cells[Grid.Getcolumn('codcor'),p]:=Q.fieldbyname('move_core_codigo').Asstring;
  //      Grid.Cells[Grid.Getcolumn('codcopa'),p]:=Q.fieldbyname('move_copa_codigo').Asstring;
        Grid.Cells[Grid.Getcolumn('codtamanho'),p]:=Q.fieldbyname('move_tama_codigo').Asstring;
        Grid.Cells[grid.getcolumn('cor'),Abs(p)]:=FCores.getdescricao(Q.fieldbyname('move_core_codigo').Asinteger);
        Grid.Cells[grid.getcolumn('tamanho'),Abs(p)]:=FTamanhos.getdescricao(Q.fieldbyname('move_tama_codigo').Asinteger);
  //      Grid.Cells[grid.getcolumn('copa'),Abs(p)]:=FCopas.getdescricao(Q.fieldbyname('move_copa_codigo').Asinteger);
        Grid.Cells[Grid.Getcolumn('moco_seq'),p]:=strzero(p,3);
  //      Grid.Cells[Grid.getcolumn('move_icms'),Abs(p)]:=transform( Q.fieldbyname('moco_aliicms').Ascurrency ,f_cr);
  //      Grid.Cells[Grid.getcolumn('move_ipi'),Abs(p)]:=transform(Q.fieldbyname('moco_aliipi').Ascurrency,f_cr);
  //      Grid.Cells[Grid.getcolumn('move_pecas'),Abs(p)]:=transform(Q.fieldbyname('moco_pecas').Ascurrency,'###,##0');
  //      Grid.Cells[Grid.getcolumn('moco_industrializa'),Abs(p)]:=Q.fieldbyname('moco_industrializa').AsString;
        Grid.Cells[Grid.getcolumn('esto_referencia'),Abs(p)]:=(QE.fieldbyname('esto_referencia').Asstring);
    //    Grid.Cells[Grid.getcolumn('move_cst'),Abs(p)]:=Q.Fieldbyname('moco_cst').asstring;
    ///
        inc(p);
        Grid.AppendRow;
        FGeral.FechaQuery(Qe);
      end;
      Q.Next;
   end;
   FGeral.Fechaquery(Q);
   Sistema.endProcess('');
   EdTotalRemessa.setvalue(CalculaTotal);

end;

procedure TFPedcompra.GridDblClick(Sender: TObject);
begin
//  if Grid.Columns.Items[Grid.getcolumn('move_venda')].Title.Caption='Unit�rio' then begin
  if Grid.getcolumn('move_venda')=Grid.Col then begin
     EdUnitarioGrid.Top:=Grid.TopEdit;
     EdUnitarioGrid.Left:=Grid.LeftEdit+5;
     EdUnitarioGrid.SetValue(TextToValor(Grid.Cells[Grid.Col,Grid.Row]));
//     EdVencimento.Text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
     EdUnitarioGrid.Visible:=True;
     EdUnitarioGrid.Enabled:=True;
     EdUnitarioGrid.SetFocus;
  end ;

end;

procedure TFPedcompra.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    GridDblClick(FPedCompra);

end;

procedure TFPedcompra.EdUnitarioGridExitEdit(Sender: TObject);
begin
  Grid.Cells[Grid.Col,Grid.Row]:=Transform(EdUnitarioGrid.AsFloat,f_cr);
  Grid.SetFocus;
  Grid.Cells[Grid.GetColumn('total'),Grid.Row]:=Transform(EdUnitarioGrid.AsFloat*Texttovalor(Grid.Cells[Grid.GetColumn('move_qtde'),Grid.Row]),f_cr);
  EdTotalRemessa.setvalue(CalculaTotal);
  EdUnitarioGrid.Visible:=False;
  EdUnitarioGrid.Enabled:=False;

end;

procedure TFPedcompra.bbaixapedidoClick(Sender: TObject);
var Numerodoc,p,codcor,codtam,codcopa:integer;
    produto:string;
    qtde:currency;
    Q:TSqlquery;
begin
{
  if not Global.Usuario.OutrosAcessos[0704] then begin
     Avisoerro('Usu�rio sem permiss�o de faturamento de pedido de venda');
     exit;
  end;
}
  if trim( Grid.cells[grid.getcolumn('move_esto_codigo'),grid.row])='' then exit;
  Numerodoc:=EdNUmerodoc.AsInteger;
  Q:=Sqltoquery('select mocm_datarecebido from movcomp where mocm_status<>''C'''+
                ' and mocm_numerodoc='+EdNumerodoc.AsSql+
                ' and mocm_unid_codigo='+EdUnid_codigo.AsSql);
  if Q.eof then begin
    Avisoerro('Pedido n�o encontrado');
    exit;
  end;

  if Q.fieldbyname('mocm_datarecebido').asdatetime>1  then begin
    Avisoerro('Pedido j� baixado');
    exit;
  end;

  if not Sistema.GetDataMvto('Informe data da baixa') then exit;

  if confirma('Confirma baixa TOTAL do pedido '+inttostr(Numerodoc)) then begin
      Sistema.beginprocess('Gravando');
      sistema.edit('movcomp');
      sistema.setfield('mocm_datarecebido',Sistema.DataMvto);
      Sistema.post( 'mocm_numerodoc='+inttostr(numerodoc)+' and mocm_status=''N'''+
                    ' and mocm_unid_codigo='+EdUnid_codigo.assql );
      for p:=1 to Grid.rowcount do begin
        produto:=Grid.cells[Grid.getcolumn('move_esto_codigo'),p];
        if trim(produto)<>'' then begin
          codcor:=strtointdef(Grid.cells[grid.getcolumn('codcor'),p],0);
          codtam:=strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),p],0);
          codcopa:=strtointdef(Grid.cells[Grid.getcolumn('codcopa'),p],0);
          qtde:=texttovalor( Grid.cells[Grid.getcolumn('move_qtde'),p] );
          sistema.edit('movcompras');
          sistema.setfield('moco_qtderecebida',qtde);
          sistema.setfield('moco_datanfcompra',sistema.DataMvto);
          sistema.setfield('moco_usua_codigo',Global.Usuario.Codigo);
//          sistema.setfield('mpdd_caoc_codigo',EdCaoc_codigo.asinteger);
          Sistema.post( 'moco_numerodoc='+inttostr(numerodoc)+
                        ' and moco_status=''N'' and moco_esto_codigo='+Stringtosql(produto)+
//                        sqlcor+sqltamanho+sqlcopa
                        ' and moco_core_codigo='+inttostr(codcor)+' and moco_tama_codigo='+inttostr(codtam)+
                        ' and ( moco_copa_codigo='+inttostr(codcopa)+' or moco_copa_codigo is null )'+
                        ' and moco_unid_codigo='+EdUnid_codigo.assql );
//          Grid.cells[Grid.getcolumn('mpdd_qtderecebida'),p]:=formatfloat('#####.##',qtde);
//          Grid.cells[Grid.getcolumn('mpdd_dataenviada'),p]:=formatdatetime('dd/mm/yy',sistema.DataMvto);
        end;
      end;
      try
        sistema.commit;
//        Grid.cells[grid.getcolumn('mped_situacao'),grid.row]:='E';
//        GridPedidosClick(FPosicaoPedidoVenda);
      except
        avisoerro('Problemas na grava��o da baixa do pedido');
      end;
      Sistema.endprocess('Pedido Baixado');
      EdNumerodoc.SetFocus;
  end;

end;

procedure TFPedcompra.batualizaprecoClick(Sender: TObject);
var linha:integer;
    unitario:currency;
    sqlcor,sqltamanho,sqlcopa:string;
begin
// 29.05.09
  if EdCliente.isempty then exit;
  if EdNumerodoc.isempty then exit;
  if not Confirma('Confirma atualiza��o ?') then exit;
  sistema.beginprocess('Atulizando itens');
  for linha:=1 to Grid.rowcount do begin
    if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha])<>'' then begin
//      aliicms:= FEstoque.Getaliquotaicms(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha],Edunid_codigo.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring,EdCliente.asinteger,EdTipoPed.text) ;
//      sittrib:=FEstoque.Getsituacaotributaria(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha],Edunid_codigo.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring,EdTipoPed.text);
      Unitario:=FEstoque.GetPrecodeCompra( Grid.cells[Grid.getcolumn('move_esto_codigo'),linha] );
      if EdMoes_tabp_codigo.asinteger>0 then begin
        if FTabela.gettipo(EdMoes_tabp_codigo.asinteger) = 'A' then
          Unitario:=( Unitario + (Unitario*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) )
        else
          Unitario:= ( Unitario - (Unitario*(FTabela.GetAliquota(EdMoes_tabp_codigo.asinteger)/100) ) );
      end;
      Grid.Cells[grid.getcolumn('move_venda'),linha]:=TRansform(Unitario,f_cr3);
      Grid.Cells[grid.getcolumn('total'),linha]:=TRansform(Texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*Unitario,f_cr);
    end;
  end;
  EdTotalRemessa.setvalue(CalculaTotal);
  TotalRemessa:=EdTotalremessa.AsCurrency;
  sistema.endprocess('');
  if Confirma('Gravar o Pedido com os novos valores ?') then begin
    sistema.beginprocess('Gravando itens');
    for linha:=1 to Grid.rowcount do begin
     if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha])<>'' then begin
      if texttovalor(Grid.Cells[Grid.Getcolumn('codcor'),linha])>0 then
        sqlcor:=' and moco_core_codigo='+Grid.Cells[Grid.Getcolumn('codcor'),linha]
      else
        sqlcor:=' and ( (moco_core_codigo=0) or (moco_core_codigo  is null) )';
//        sqlcor:=' and moco_core_codigo=0';
      if Texttovalor(Grid.Cells[Grid.Getcolumn('codtamanho'),linha])>0 then
        sqltamanho:=' and moco_tama_codigo='+Grid.Cells[Grid.Getcolumn('codtamanho'),linha]
      else
        sqltamanho:=' and ( (moco_tama_codigo=0) or (moco_tama_codigo is null) )';;
//        sqltamanho:=' and moco_tama_codigo=0';
      if texttovalor(Grid.Cells[Grid.Getcolumn('codcopa'),linha])>0 then
        sqlcopa:=' and moco_copa_codigo='+Grid.Cells[Grid.Getcolumn('codcopa'),linha]
      else
        sqlcopa:=' and ( (moco_copa_codigo=0) or (moco_copa_codigo is null) )';
//        sqlcopa:=' and moco_copa_codigo=0';
      Sistema.Edit('movcompras');
      Sistema.SetField('moco_unitario',TextToValor(Grid.cells[Grid.getcolumn('move_venda'),linha]) );
      Sistema.Post('moco_numerodoc='+EdNumerodoc.AsSql+' and moco_status=''N'''+
                ' and moco_tipomov='+Stringtosql(Tipomov)+
                ' and moco_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
                ' and moco_tipo_codigo='+EdCliente.AsSql+
                ' and moco_esto_codigo='+Stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),linha])+
                  sqlcor+sqltamanho+sqlcopa+
                ' and moco_tipocad=''F''' );
     end;
    end;
    try
      Sistema.Commit;
      Sistema.endprocess('Pedido Alterado');
    except
      Sistema.endprocess('N�o foi poss�vel gravar.  Tente mais tarde.');
    end;
  end;
end;

procedure TFPedcompra.bajudaClick(Sender: TObject);
/////////////////////////////////////////////////////
begin
// 31.07.13
 FGeral.ExecutaHelp('PedidoCompra');

end;

end.
