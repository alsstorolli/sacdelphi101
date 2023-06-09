unit RelGerenciais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid;

type
  TFRelGerenciais = class(TForm)
    PRel: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    baplicar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    EdTransacao: TSQLEd;
    Eddatai: TSQLEd;
    Eddataf: TSQLEd;
    Edunid_codigo: TSQLEd;
    EdBomparai: TSQLEd;
    EdBomparaf: TSQLEd;
    EdDepositoi: TSQLEd;
    EdDepositof: TSQLEd;
    EdTipomov: TSQLEd;
    EdTipocad: TSQLEd;
    EdCodtipo: TSQLEd;
    SetEdFavorecido: TSQLEd;
    Edsinana: TSQLEd;
    EdNumerodoc: TSQLEd;
    EdEsto_codigo: TSQLEd;
    SetEdFUNC_NOME: TSQLEd;
    Edtiporesumo: TSQLEd;
    EdSomagazine: TSQLEd;
    EdEmaberto: TSQLEd;
    Edsisvendas: TSQLEd;
    EdGrup_codigo: TSQLEd;
    EdCaoc_codigo: TSQLEd;
    EdCfops: TSQLEd;
    EdConsfinal: TSQLEd;
    EdTran_codigo: TSQLEd;
    EdTran_nome: TSQLEd;
    EdNumeros: TSQLEd;
    Edentsai: TSQLEd;
    EdsubGrup_codigo: TSQLEd;
    EdAbatidos: TSQLEd;
    EdPlan_conta: TSQLEd;
    EdPlan_descricao: TSQLEd;
    Edbrinco: TSQLEd;
    Edespecies: TSQLEd;
    procedure baplicarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdTransacaoValidate(Sender: TObject);
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure EddatafValidate(Sender: TObject);
    procedure EdTransacaoKeyPress(Sender: TObject; var Key: Char);
    procedure EdTipocadValidate(Sender: TObject);
    procedure EdCodtipoValidate(Sender: TObject);
    procedure EdEsto_codigoValidate(Sender: TObject);
    procedure EdCodtipoExitEdit(Sender: TObject);
    procedure EdNumerodocExitEdit(Sender: TObject);
    procedure EdEsto_codigoExitEdit(Sender: TObject);
    procedure EdDepositofExitEdit(Sender: TObject);
    procedure EdGrup_codigoValidate(Sender: TObject);
    procedure EdtiporesumoExitEdit(Sender: TObject);
    procedure EdTransacaoExitEdit(Sender: TObject);
    procedure EdsubGrup_codigoValidate(Sender: TObject);
  private
    { Private declarations }
    SaiOk:Boolean;
  public
    { Public declarations }
    function TituloTipoMov(movimentos:string):string;
    function TituloConsigaberto(aberto:string):string;
    procedure PoeLista(tipomov,transacao:string);
    procedure Baixadocumentos(Lista:TList);
    function Gettitmotivos:string;
    function ChecaZero(s:string):string;
    procedure SetaNumerosNotaSaida(Ed:TSqlEd;Datai,Dataf:TDatetime);
// 16.01.12
    function EstaNaLista(tipomov,transacao:string):boolean;

  end;

type TRegistros=record
     transacao,tipomov:string
end;

var
  FRelGerenciais: TFRelGerenciais;
  largura,margem,rel,dcliente:integer;
  sqlunidade,tiposmov,sqltipomovto,sqlcodtipo,sqldatacont,sqlproduto,sqlgrupo,sqlsubgrupo,
  sqlmotivo,TipoEntradaAbate,sqlnumeros,
  TipoFazenda,
  TipoLote,
  TipoPesagem    :string;
  PRegistro:^TRegistros;
  ListaRegistro:TList;


procedure FRelGerenciais_Transacao(xtrans:string='');           // 1
procedure FRelGerenciais_AuditoriaFiscal;     // 2
procedure FRelGerenciais_ChequesRecebidos(xemirec:string='R');    // 3
procedure FRelGerenciais_AuditoriaCustos;     // 4
procedure FRelGerenciais_Comissoes;           // 5
procedure FRelGerenciais_VendasQtde;          // 6
procedure FRelGerenciais_ConsigAberto(xcodcliente:integer=0);        // 7
procedure FRelGerenciais_PosicaoCliente;      // 8
procedure FRelGerenciais_ProntaEntregaAberto; // 9
procedure FRelGerenciais_Compras;             // 10
procedure FRelGerenciais_Vendas(xcliente:integer=0);              // 11
procedure FRelGerenciais_ConfDescontos;       // 12
////////////procedure FRelGerenciais_MediaVendas(Rel,Tipo:string);         // 13
// retornado em 21.09.11 - Janina
procedure FRelGerenciais_DetalheVC ;          // 14   - detalhamento das VC
////////////procedure FRelGerenciais_ConsigAbertoRes;     // 15
////////////procedure FRelGerenciais_ConfereProntaEntregaAberto(tiporel:string);  // 16
procedure FRelGerenciais_CorrecaoTransferencias;              // 17
procedure FRelGerenciais_AtendimentosRepre;              // 18
////////////procedure FRelGerenciais_RegEspecialAbertoRes;       // 19
procedure FRelGerenciais_CMV;                //20
////////procedure FRelGerenciais_InadimplenciaCheques;  // 21
procedure FRelGerenciais_VendasProdutoQtde;          // 22
// procedure FRelGerenciais_MediaVendasOutra(Rel,Tipo:string);         // 23
procedure FRelGerenciais_AtendimentoPedidos;         // 24
procedure FRelGerenciais_PecasPendentes;         // 25
procedure FRelGerenciais_PedidosVenda;         // 26
procedure FRelGerenciais_PedidosProdutos(Tiporel:string);      // 27
procedure FRelGerenciais_AtendimentoPedidosProdutos;         // 28
procedure FRelGerenciais_ImpressaoPedidos;                   // 29
///////procedure FRelGerenciais_RemessasMagazine;
procedure FRelGerenciais_EntradadeAbate(numero:integer=0;unidade:string='';xtipomov:string='EA');             // 30
// 24.12.08 - Isonel - Novicarnes
procedure FRelGerenciais_ComissoesporGrupo;           // 31
// 24.08.09 - Vanessa - Novicarnes
procedure FRelGerenciais_AuditoriaFiscalItens;     // 32
// 28.10.09 - Abra - despesas veiculos
procedure FRelGerenciais_DespesasVeiculos;     // 33
// 03.12.09 - Vanessa - Novicarnes
procedure FRelGerenciais_AuditoriaFiscalBaseItens;     // 34
// 17.02.10
procedure FRelGerenciais_Carga(Tran:string='';unidade:string='';xtipomov:string='SA');             // 35
// 24.01.11
procedure FRelGerenciais_ComissoesEntradaAbate;           // 36
// 23.03.12 -
procedure FRelGerenciais_AuditoriaFiscalporCfop;     // 37
// 27.09.14 -  Vivan - Liane
procedure FRelGerenciais_AnaliseVendasporCliente;     // 38

procedure FRelGerenciais_Lotes;     // 39
// 17.06.19
procedure FRelGerenciais_ComissoesBoiadeiros; // 40
// 14.01.20
procedure FRelGerenciais_ConfAcrescimos;       // 41
 // 06.08.20
 procedure FRelGerenciais_LotesResumo;     // 42


implementation

uses Geral, SqlExpr, Sqlfun, SqlSis, TextRel, SQLRel, Unidades, represen,
  cadcli, fornece, plano, Estoque, portador, tamanhos, cadcor, grupos,
  Usuarios, cadocor, Ocorrenc, cadcopa, Transp, ConfMovi, Natureza,
  codigosfis, colaboradores, setores, sintegra, Subgrupos, codigosipi, baias;

{$R *.dfm}


function FRelGerenciais_Execute(Tp:Integer):Boolean;
///////////////////////////////////////////////////////////
begin

  if FRelGerenciais=nil then FGeral.CreateForm(TFRelGerenciais, FRelGerenciais);
  rel:=tp;
  result:=true;
  FGeral.SetaTipoCad(FRelgerenciais.EdTipocad);
//  FGeral.SetaItemsMovimento(FRelgerenciais.EdTipomov);
// 11.08.08
  FConfMovimento.SetaItemsMovimento(FRelgerenciais.EdTipomov);
  FCadOcorrencias.SetaItems(FRelgerenciais.EdCaoc_codigo,nil,'');
// 05.06.08
  TipoEntradaAbate:='EA';
  TipoFAzenda:='FA';
  TipoLote   :='LO';
  TipoPesagem:='FM';

  with FRelGerenciais do begin

    FUnidades.SetaItems(EdUnid_codigo,nil,Global.Usuario.UnidadesRelatorios);
//    FGeral.SetaItemsMovimento(EdTipomov);
    sqlunidade:='';
    sqltipomovto:='';
    sqlgrupo:='';
    sqlsubgrupo:='';
    EdTran_codigo.enabled:=false;
    EdPlan_conta.enabled := false;
    EdBrinco.Enabled:=false;
    if tp=1 then
      Caption:='Relat�rio detalhado da transa��o'
    else if tp=2 then
      Caption:='Relat�rio de Auditoria Fiscal'
    else if tp=3 then
      Caption:='Relat�rio de Cheques Recebidos/Emitidos'
    else if tp=4 then
      Caption:='Relat�rio de Auditoria de Custos'
    else if tp=5 then
      Caption:='Relat�rio de Vendas / Comiss�o'
    else if tp=6 then
      Caption:='Relat�rio de Vendas / Quantidade'
    else if tp=7 then begin
      Caption:='Relat�rio de Consigna��es em Aberto'  ;
      EdTipocad.enabled:=true;
      EdCodTipo.enabled:=true;
    end else if tp=8 then
      Caption:='Relat�rio de Posi��o de Cliente'
    else if tp=9 then
      Caption:='Relat�rio de Pronta Entrega em Aberto'
    else if tp=10 then
      Caption:='Relat�rio de Compras'
    else if tp=11 then begin
      Caption:='Relat�rio de Vendas';
      if dcliente>0 then begin
         EdTipocad.text:='C';
         EdCodtipo.SetValue(dcliente);
         EdSinana.text:='A';
      end;
    end else if tp=12 then
      Caption:='Relat�rio de Confer�ncia de Descontos'
    else if tp=13 then
      Caption:='Relat�rio de M�dia de Vendas'
    else if tp=14 then
      Caption:='Relat�rio de Detalhamento de Venda Consignada'
    else if tp=15 then
      Caption:='Relat�rio de Resumido de Consig. em Aberto'
    else if tp=16 then
      Caption:='Relat�rio de Confer�ncia de Consigna��o/Pronta Entrega'
    else if tp=17 then
      Caption:='Relat�rio de Transfer�ncias Corrigidas'
    else if tp=18 then
      Caption:='Relat�rio de Atendimentos de Representantes'
    else if tp=19 then
      Caption:='Relat�rio Reg. Especial Aberto Resumido'
    else if tp=20 then
      Caption:='Relat�rio de Custo da Mercadoria Vendida'
    else if tp=21 then
      Caption:='Relat�rio de Inadimpl�ncia de Cheques Recebidos'
    else if tp=22 then begin
      Caption:='Relat�rio de Vendas por Produto';
      EdTipocad.enabled:=true;
      EdCodTipo.enabled:=true;
    end else if tp=24 then
      Caption:='Relat�rio de Atendimentos dos Pedidos de Venda por Cliente'
    else if tp=25 then
      Caption:='Relat�rio de Pe�as Pendentes dos Pedidos de Venda'
    else if tp=26 then
      Caption:='Rela��o dos Pedidos de Venda'
    else if tp=27 then
      Caption:='Rela��o dos Produtos mais Pedidos'
    else if tp=28 then
      Caption:='Rela��o Atendimentos dos Pedidos de Venda por Produto'
    else if tp=29 then
      Caption:='Rela��o(Impress�o) de Pedidos digitados'
    else if tp=30 then begin

      Caption:='Rela��o das Entradas/Saidas de Abate/Fazenda';
      EdBrinco.Enabled:=true;

    end else if tp=31 then
      Caption:='Rela��o de Comiss�es por Grupo de Produto'
    else if tp=32 then
      Caption:='Auditoria Fiscal nos itens das notas'
    else if tp=33 then begin

      Caption:='Relat�rio de Despesas dos Ve�culos da empresa';
// 17.10.19
      EdTran_codigo.enabled:= true;
      EdPlan_conta.enabled := true;

    end else if tp=34 then
      Caption:='Auditoria Fiscal da Base do Icms nos itens das notas'
    else if tp=35 then
      Caption:='Pedido de Venda Bovinos/Su�nos'
    else if tp=36 then
      Caption:='Comiss�o sobre Entrada de Abate'
    else if tp=37 then begin
      Caption:='Auditoria Fiscal por Cfop';
      if EdDatai.isempty then begin
        EdDatai.setdate(sistema.hoje);
        EdDataf.setdate(sistema.hoje);
      end;
      EdTran_codigo.enabled:=true;
      EdTipocad.enabled:=false;
      EdCodTipo.enabled:=false;
      EdTipomov.enabled:=false;
    end else if tp=36 then begin
      Caption:='Comiss�o sobre Entrada de Abate';
      if EdDatai.isempty then begin
        EdDatai.setdate(sistema.hoje);
        EdDataf.setdate(sistema.hoje);
      end;
//      EdTran_codigo.enabled:=true;
      EdTipocad.enabled:=true;
      EdCodTipo.enabled:=true;
      EdTipomov.enabled:=false;
// 13.06.19
    end else if tp=39 then begin

      Caption:='Lotes de Animais Fazenda';

    end else if tp=40 then begin

      Caption:='Boiadeiro';

    end else if tp=41 then begin

      Caption:='Confer�ncia de Acr�scimos';

    end else if tp=42 then begin

      Caption:='Lotes Fazenda Resumo';

    end;

    largura:=80;
    if tp=1 then begin
      EdTransacao.enabled:=true;
      EdTipomov.enabled:=false;  // 18.04.06
    end else begin
      EdTransacao.enabled:=false;
      EdTransacao.text:='';
    end;
    EdBomParai.enabled:=tp=3;
    EdBomParaf.enabled:=tp=3;
    EdCfops.enabled:=( (tp=2) or (tp=32) or (tp=37) );
// 10.01.23
    EdEspecies.enabled:=( (tp=2) );
    EdEspecies.Items.Clear;
    EdEspecies.Items.Add('NFE');;
    EdEspecies.Items.Add('NFC');;
    EdEspecies.Items.Add('CTE');;
    EdEspecies.Items.Add('MDF');;
    EdEspecies.Items.Add('NFP');;

    FNatureza.SetaCfopsEmUso(EdCfops);
    if (tp=3) or (tp=21) then begin
      EdDepositoi.enabled:=true;
      EdDepositof.enabled:=true;
      EdTipoCad.enabled:=true;
      EdcodTipo.enabled:=true;
    end else begin
      EdDepositoi.enabled:=false;
      EdDepositof.enabled:=false;
    end;
    EdDAtai.enabled:=true;
    EdDAtaf.enabled:=true;
    EdUnid_codigo.enabled:=true;
    Edtipomov.enabled:=true;  // 06.06.05
// 04.12.13
    EdEntSai.enabled:=( (tp=2) or (tp=32) or (tp=37) );

// 30.05.06 -reges tira um apos o outro
//    if EdBomparai.enabled then begin
//      EdBomparai.setdate(FGeral.GetDatainiciomes(sistema.hoje));
//      EdBomParaf.setdate(sistema.hoje);
//    end;

//    EdDAtai.empty:=tp<>3;
//    EdDataf.empty:=tp<>3;
//    EdDAtai.enabled:=tp<>3;
//    EdDataf.enabled:=tp<>3;

    EdEmaberto.enabled:=( (tp=3) or (tp=26) );

    if EdDatai.enabled then begin
      if EdDatai.isempty then begin
        if tp<>3 then begin
          EdDAtai.setdate(FGeral.GetDatainiciomes(sistema.hoje));
          EdDataf.setdate(sistema.hoje);
        end else begin
          EdDAtai.empty:=true;
          EdDataf.empty:=true;
        end;
      end;
    end;
    if (EdDepositoi.enabled) and (tp<>3) then begin
//      if EdDepositoi.isempty then begin
//        EdDepositoi.setdate(FGeral.GetDatainiciomes(sistema.hoje));
//        EdDepositof.setdate(sistema.hoje);
//      end;
    end;
    if (trim(EdDatai.text)='') and (tp<>3) then EdDatai.SetDate(Sistema.Hoje);
    if (trim(EdDataf.text)='') and (tp<>3) then EdDataf.SetDate(Sistema.Hoje);
    if (tp>=2) and (tp<=4)  then begin
//      EdDAtai.enabled:=tp<>3;
//      EdDataf.enabled:=tp<>3;
      EdUnid_codigo.enabled:=true;
//      if trim(EdDatai.text)='' then EdDatai.SetDate(Sistema.Hoje);
//      if trim(EdDataf.text)='' then EdDataf.SetDate(Sistema.Hoje);
      if tp=3 then begin
//        EdTipoCad.enabled:=false;
//        EdTipoCad.text:='';
//        EdcodTipo.enabled:=false;
//        EdcodTipo.text:='';
        Edtipomov.enabled:=false;
      end;
    end else if tp=1 then begin
      EdDAtai.enabled:=false;
      EdDAtaf.enabled:=false;
      EdUnid_codigo.enabled:=false;
      EdDAtai.text:='';
      EdDAtaf.text:='';
      EdUnid_codigo.text:='';
    end;
    if (tp=5) or (tp=6) then begin
      EdDAtai.enabled:=true;
      EdDAtaf.enabled:=true;
      EdUnid_codigo.enabled:=true;
    end;
    EdTiporesumo.enabled:=false;
    EdTipoResumo.text:='';
    if (tp=7) or (tp=8) or (tp=13) or (tp=15) or (tp=16) or (tp=17) then begin
// 28.06.06
//    if (tp=7) or (tp=8)  or (tp=15) or (tp=16) or (tp=17) then begin
      EdTipomov.enabled:=false;
      EdTipomov.text:='';
      if (tp=15) or (tp=16) or (tp=17) then begin
        EdTipoCad.enabled:=false;
        EdTipoCad.text:='';
        EdcodTipo.enabled:=false;
        EdcodTipo.text:='';
        if tp=15 then begin
          EdTipoCad.enabled:=true;  // 03.06.05
          EdcodTipo.enabled:=true;  // 03.06.05
          EdTiporesumo.enabled:=true;
          EdTipoResumo.text:='D';
        end else begin
          EdTiporesumo.enabled:=false;
          EdTipoResumo.text:='';
        end;
      end;
    end;                   // 31.05.11
    if (tp=9) or (tp=16) or (tp=05) then begin   // 25.11.05
        EdTipoCad.enabled:=true;
        EdcodTipo.enabled:=true;
    end;
    if tp=8 then begin
      EdTipoCad.enabled:=false;
      EdTipoCad.text:='C';
      EdTipoCad.enabled:=true;  // 19.09.05
// 07.01.14 - por enquanto independente de periodo
      EdDAtai.enabled:=false;
      EdDAtaf.enabled:=false;
      EdDAtai.setdate(sistema.hoje-40);
      EdDAtaf.setdate(sistema.hoje);
      EdUnid_codigo.enabled:=false;
    end;
    if (tp=10) or (tp=11) or (tp=24) or (tp=28) or (tp=17) or (tp=35) or (tp=35) or (tp=33 )then
      Edsinana.enabled:=true
    else
      Edsinana.enabled:=false;
    EdNumerodoc.empty:=false;
    if (tp=14) or (tp=10) or (tp=30) then begin
      EdNumerodoc.enabled:=true;
      if (tp=10) or (tp=30) or (tp=14) then
        EdNumerodoc.empty:=true;
    end else begin
      EdNumerodoc.enabled:=false;
      EdNumerodoc.setvalue(0);
    end;
    EdGrup_codigo.enabled:=false;
// 03.07.14 - Vivan - Liane               // 17.05.22 - Guiber - Silvano
    EdSubGrup_codigo.enabled:=( (tp=20) or (tp=6) );
    if (tp=17) or (tp=7) then
      EdGrup_codigo.enabled:=true;
    if (tp=7) or (tp=6) or (tp=13) or (tp=20) or (tp=4) or (tp=25) or (tp=10) or (tp=22) then begin
      EdEsto_codigo.enabled:=true;
      if (tp=6) or (tp=20) then
        EdGrup_codigo.enabled:=true
    end else begin
      EdEsto_codigo.enabled:=false;
      EdEsto_codigo.text:='';
    end;
    EdSomagazine.enabled:=tp=13;
    if (tp=24) or (tp=28)  then begin
      EdSisvendas.enabled:=true;
    end else begin
      EdSisvendas.enabled:=false;
    end;
    EdCaoc_codigo.enabled:=tp=25;
// 24.10.06
    if tp=1 then begin
      EdTipomov.enabled:=false;
      EdTipocad.enabled:=false;
      EdCodTipo.enabled:=false;
    end;
// 28.09.07
    if tp=30 then begin
      EdTipomov.enabled:=false;
      EdSinana.enabled:=true;
      EdNumerodoc.enabled:=true;
      EdEsto_codigo.enabled:=true;
    end;
// 28.04.09
    if tp=10 then begin
      EdTipocad.enabled:=true;
      EdCodtipo.enabled:=true;
    end;
// 09.11.09 - Novicarnes
//    EdConsfinal.Enabled:=tp=22;
// 09.04.15- 'coisas de vanesssa'
    EdConsfinal.Enabled:=false;
// 16.02.11
    EdNumeros.Enabled:=(tp=22);
// 08.09.20
    EdAbatidos.enabled:=(tp=30);

    FGeral.SetaItemsSisVenda(EdSisvendas);
    FGrupos.SetaItems(EdGrup_codigo,nil,'','');
    FSubGrupos.SetaItems(EdSubGrup_codigo,nil,'','');
    SaiOk:=False;
    FRelGerenciais.ShowModal;
    Result:=SaiOk;
  end;
end;

//////////////////////////////////////////////////////
procedure FRelGerenciais_Transacao(xtrans:string='');         // 1
////////////////////////////////////////////////////
var QMovesto,QMovbase,QPendencias,QMovFin,QPendenciasBaixadas,QProducao,QMovEstoque,QContabil,
    QPLano,
    QApropria   :TSqlquery;
    Linhas,Lista:TStringList;
    s,TipoMovimento,Unidade,cancelada,QImposto,cliente,representante,tipocad,r,descpendencia,
    tipomov,tiposdemovimento,tamanho,cor,sep,transacaocontax,sqldatacontax,chavedoc:string;
    p,codigo,codusuario,n,confmovimento:integer;
    xdata,xDatalcto:TDatetime;

    function GetContas(ss:string):string;
    /////////////////////////////////////
    var L : TStringList;
        i : integer;

    begin

       L := TStringList.create;
       strtolista(L,ss,'|',true);
       result:='';
       for i := 0 to L.count-1 do begin

           if trim(L[i])<>'' then
              result := result + copy( L[i],1,pos(';',L[i])-1) +' | ';

       end;

    end;


begin

  with FRelGerenciais do begin
// 19.06.17
    if xtrans='' then begin
      if not FRelGerenciais_Execute(1) then Exit;
      if trim(EdTransacao.text)='' then exit;
    end else EdTransacao.Text:=xtrans;

    Sistema.BeginProcess('Gerando Relat�rio');
    cancelada:='';
    sep:=';';
    QMovesto:=sqltoquery('select * from movesto left join confmov on ( comv_codigo=moes_comv_codigo )'+
              ' where moes_transacao='+EdTransacao.AsSql+
              ' and '+FGeral.GetNOTIN('moes_tipomov',Global.CodRequisicaoAlmox,'C')+
              ' order by moes_datalcto desc');
    tipomov:='';
    tiposdemovimento:='';   // 29.04.08
    codusuario:=0;
    confmovimento:=0;
    chavedoc:='';
    if not QMovesto.eof then begin

      codusuario:=QMovesto.fieldbyname('moes_usua_codigo').AsInteger;
      transacaocontax:=QMovesto.fieldbyname('moes_transacerto').AsString;
      chavedoc:=QMovesto.fieldbyname('moes_chavenfe').AsString;
// 27.04.18
      xdatalcto:=QMovesto.fieldbyname('moes_datalcto').AsDateTime;
      if QMovesto.fieldbyname('moes_status').asstring='C' then
        cancelada:=' - CANCELADA'
      else
        cancelada:='';
      tipomov:=QMovesto.fieldbyname('moes_tipomov').asstring;
      tiposdemovimento:=QMovesto.fieldbyname('moes_tipomov').asstring;  // 29.04.08
// 12.11.10
      confmovimento:=QMovesto.fieldbyname('moes_comv_codigo').asinteger;
    end;

    QMovbase:=sqltoquery('select * from movbase where movb_transacao='+EdTransacao.AsSql+' and movb_status<>''C''');
    QPendencias:=sqltoquery('select * from pendencias where pend_transacao='+EdTransacao.AsSql+
//                            ' and pend_status<>''C'''+
                            ' order by pend_datavcto');
    if not QPendencias.eof then begin
      if QPendencias.fieldbyname('pend_status').asstring='C' then
        cancelada:=' - CANCELADA'
      else
        cancelada:='';
    end;
    QPendenciasBaixadas:=sqltoquery('select * from pendencias where pend_transbaixa='+EdTransacao.AsSql+
                            ' and pend_status<>''K'''+  // 06.08.07
                            ' order by pend_databaixa');
    QMovfin:=Sqltoquery( FGEral.BuscaTransacao(EdTransacao.text,'movfin','movf_transacao','movf_status','N;G') );
    if not QMovfin.eof then begin

      if QMovfin.fieldbyname('movf_status').asstring='C' then
        cancelada:=' - CANCELADA'
      else
        cancelada:='';

    end;
    Linhas:=TStringlist.create;
    Lista:=TStringlist.create;
    Unidade:=space(03);
// 03.09.09 - 'contas contabeis'
    if (not QMovesto.eof) then begin

      if (QMovesto.fieldbyname('moes_comv_codigo').asinteger>0) and ( pos(tipomov,Global.TiposEntrada)>0 )  and ( not Global.topicos[1043] ) then begin
        if Global.Topicos[1002] then begin
          if QPendencias.eof then
            s:=strspace('Contabiliza��o   ',25)+sep+''+sep+''+sep+''+sep+''+sep+'D�bito :'+QMovesto.FieldByName('comv_debito').Asstring+
                    ' '+FPlano.GetDescricao(QMovesto.FieldByName('comv_debito').AsInteger)+
                    'Cr�dito : '+QMovesto.FieldByName('comv_credito').Asstring+
                    FPlano.GetDescricao(QMovesto.FieldByName('comv_credito').AsInteger)

          else
            s:=strspace('Contabiliza��o   ',25)+sep+''+sep+''+sep+''+sep+''+sep+'D�bito :'+QPendencias.FieldByName('pend_plan_conta').Asstring+
                    ' '+FPlano.GetDescricao(QPendencias.FieldByName('pend_plan_conta').AsInteger)+
                    'Cr�dito : '+QMovesto.FieldByName('comv_credito').Asstring+
                    FPlano.GetDescricao(QMovesto.FieldByName('comv_credito').AsInteger);
        end else
          s:=strspace('Contabiliza��o   ',25)+sep+''+sep+''+sep+''+sep+''+sep+'D�bito :'+QMovesto.FieldByName('comv_debito').Asstring+
                    ' Cr�dito : '+QMovesto.FieldByName('comv_credito').Asstring;

        Linhas.Add(s);
      end;
// 21.08.20
      if QMovesto.fieldbyname('moes_plan_codigo').asinteger = 9999 then

        s := strspace('Contas Gerenciais',25)+sep+GetContas(QMovesto.fieldbyname('moes_devolucoes').Asstring)+sep+''+
             sep+''+sep+''+
             ''+sep

      else

        s := strspace('Conta Gerencial',25)+sep+QMovesto.fieldbyname('moes_plan_codigo').Asstring+'-'+
             FPLano.GetDescricao(QMovesto.fieldbyname('moes_plan_codigo').AsInteger)+sep+space(10)+
             ' '+sep+space(10)+' '+sep+''+sep;


     Linhas.Add(s);


    end;


//////////////
    while (not QMovesto.eof) and (QMovesto.fieldbyname('moes_status').asstring<>'C') do begin

      TipoMovimento:=QMovesto.fieldbyname('moes_tipomov').asstring+'-'+strspace(FGeral.GetTipoMovto(QMovesto.fieldbyname('moes_tipomov').asstring),30);
      tiposdemovimento:=tiposdemovimento+';'+QMovesto.fieldbyname('moes_tipomov').asstring;  // 29.04.08
      Unidade:=QMovesto.fieldbyname('moes_unid_codigo').asstring;
      if pos(QMovesto.fieldbyname('moes_tipomov').asstring,'VC;DC')>0 then
        r:=' Remessas '
      else
        r:=' ';
      s:=strspace('Movimento Estoque',25)+sep+TipoMovimento+sep+strspace(QMovesto.fieldbyname('moes_numerodoc').Asstring,10)+
         ' '+sep+formatdatetime('dd/mm/yy',QMovesto.fieldbyname('moes_datamvto').asdatetime)+
         ' '+sep+FGeral.Formatavalor(QMovesto.fieldbyname('moes_vlrtotal').ascurrency,f_cr)+
//         r+strspace(QMovesto.fieldbyname('moes_remessas').asstring,30);
// 07.08.07
         sep+r+strspace(QMovesto.fieldbyname('moes_tipo_codigo').asstring+'-'+FGeral.GetNomeRazaoSocialEntidade(QMovesto.fieldbyname('moes_tipo_codigo').asinteger,QMovesto.fieldbyname('moes_tipocad').asstring,'N') ,30);
      Linhas.Add(s);
      QMovesto.Next;

    end;

    while not QMovbase.eof do begin

      TipoMovimento:=QMovbase.fieldbyname('movb_tipomov').asstring+'-'+strspace(FGeral.GetTipoMovto(QMovbase.fieldbyname('movb_tipomov').asstring),30);
      if QMovbase.fieldbyname('movb_tpimposto').asstring='I' then
        QImposto:='ICMS'
      else
        QImposto:='IPI ';
      s:=strspace('Movimento Fiscal',25)+sep+TipoMovimento+sep+strspace(QMovbase.fieldbyname('movb_numerodoc').Asstring,10)+
         ' '+sep+space(8)+
         ' '+sep+FGeral.Formatavalor(QMovbase.fieldbyname('movb_basecalculo').ascurrency,f_cr)+
         sep+' Sit.Trib.'+QMovbase.fieldbyname('movb_cst').asstring+space(10)+QImposto+' '+
         ' Imposto '+FGeral.Formatavalor(QMovbase.fieldbyname('movb_imposto').ascurrency,'###,##0.00') ;
      Linhas.Add(s);
      QMovbase.Next;

    end;

    while not QPendencias.eof do begin

      if trim(unidade)='' then unidade:=QPendencias.fieldbyname('pend_unid_codigo').asstring;
      codigo:=QPendencias.fieldbyname('pend_tipo_codigo').asinteger;
      tipocad:=QPendencias.fieldbyname('pend_tipocad').asstring;
// 26.05.10
      if codusuario=0 then codusuario:=QPendencias.fieldbyname('pend_usua_codigo').AsInteger;

      if QPendencias.fieldbyname('pend_rp').asstring='R' then begin
//        TipoMovimento:=strspace('Contas a Receber',33);
// 28.10.05
        TipoMovimento:=strspace('CR '+ QPendencias.fieldbyname('pend_tipomov').asstring+'-'+strspace(FGeral.GetTipoMovto(QPendencias.fieldbyname('pend_tipomov').asstring),30),33);
        cliente:=strspace(QPendencias.fieldbyname('pend_tipo_codigo').asstring+'-'+FGeral.GetNomeRazaoSocialEntidade(codigo,tipocad,'N'),19);
      end else begin
//        TipoMovimento:=strspace('Contas a Pagar',33);
// 28.10.05
        TipoMovimento:=strspace('CP '+ QPendencias.fieldbyname('pend_tipomov').asstring+'-'+strspace(FGeral.GetTipoMovto(QPendencias.fieldbyname('pend_tipomov').asstring),30),33);
        cliente:=strspace(QPendencias.fieldbyname('pend_tipo_codigo').asstring+'-'+FGeral.GetNomeRazaoSocialEntidade(codigo,tipocad,'N'),19);
      end;
      representante:=strspace(QPendencias.fieldbyname('pend_repr_codigo').asstring+'-'+FRepresentantes.GetDescricao(QPendencias.fieldbyname('pend_repr_codigo').asinteger),19);
      if QPendencias.fieldbyname('pend_databaixa').asdatetime<=1 then
        descpendencia:='Financeiro Pendente'
      else
        descpendencia:='Financeiro Baixado';
      s:=strspace(descpendencia,25)+sep+TipoMovimento+sep+strspace(QPendencias.fieldbyname('pend_numerodcto').Asstring,10)+
         ' '+sep+formatdatetime('dd/mm/yy',QPendencias.fieldbyname('pend_datavcto').asdatetime)+
//         ' '+formatdatetime('dd/mm/yy',QPendencias.fieldbyname('pend_datamvto').asdatetime)+
         ' '+sep+FGeral.Formatavalor(QPendencias.fieldbyname('pend_valor').ascurrency,f_cr)+
         ' '+sep+cliente+' '+representante;
      Linhas.Add(s);
      QPendencias.Next;

    end;

    while not QPendenciasBaixadas.eof do begin

      if trim(unidade)='' then unidade:=QPendenciasBaixadas.fieldbyname('pend_unid_codigo').asstring;
      codigo:=QPendenciasBaixadas.fieldbyname('pend_tipo_codigo').asinteger;
      tipocad:=QPendenciasBaixadas.fieldbyname('pend_tipocad').asstring;
      if QPendenciasBaixadas.fieldbyname('pend_rp').asstring='R' then begin
        TipoMovimento:=strspace('Contas a Receber',33);
        cliente:=strspace(QPendenciasBaixadas.fieldbyname('pend_tipo_codigo').asstring+'-'+FGeral.GetNomeRazaoSocialEntidade(codigo,tipocad,'N'),19);
      end else begin
        TipoMovimento:=strspace('Contas a Pagar',33);
        cliente:=strspace(QPendenciasBaixadas.fieldbyname('pend_tipo_codigo').asstring+'-'+FGeral.GetNomeRazaoSocialEntidade(codigo,tipocad,'N'),19);
      end;
      representante:=strspace(QPendenciasBaixadas.fieldbyname('pend_repr_codigo').asstring+'-'+FRepresentantes.GetDescricao(QPendenciasBaixadas.fieldbyname('pend_repr_codigo').asinteger),19);
      s:=strspace('Financeiro Baixado',25)+sep+TipoMovimento+sep+strspace(QPendenciasBaixadas.fieldbyname('pend_numerodcto').Asstring,10)+
         ' '+sep+formatdatetime('dd/mm/yy',QPendenciasBaixadas.fieldbyname('pend_datavcto').asdatetime)+
//         ' '+formatdatetime('dd/mm/yy',QPendencias.fieldbyname('pend_datamvto').asdatetime)+
         ' '+sep+FGeral.Formatavalor(QPendenciasBaixadas.fieldbyname('pend_valor').ascurrency,f_cr)+
         ' '+sep+cliente+' '+representante;
      Linhas.Add(s);
      QPendenciasBaixadas.Next;

    end;

// 19.09.16
    if not QMovfin.eof then begin

      if codusuario=0 then codusuario:=QMovfin.fieldbyname('movf_usua_codigo').asinteger;
      if (transacaocontax='') and  ( (Global.topicos[1043]) or (Global.topicos[1045]) ) then
        transacaocontax:=QMovfin.fieldbyname('movf_transacaocontax').asstring;
      xdata:=QMovfin.fieldbyname('movf_datamvto').AsDateTime;
// 27.04.18
      xdatalcto:=QMovfin.fieldbyname('movf_datalcto').AsDateTime;
    end;
    while not QMovfin.eof do begin

      if QMovfin.fieldbyname('movf_es').asstring='E' then
        TipoMovimento:=strspace('Entrada no Caixa/Bancos',33)
      else
        TipoMovimento:=strspace('Saida do Caixa/Bancos',33);
      Unidade:=QMovfin.fieldbyname('movf_unid_codigo').asstring;
// 26.05.10
      if codusuario=0 then codusuario:=QMovfin.fieldbyname('movf_usua_codigo').AsInteger;
      if (transacaocontax='') and  ( (Global.topicos[1043]) or (Global.topicos[1045]) ) then
        transacaocontax:=QMovfin.fieldbyname('movf_transacaocontax').asstring;
      s:=strspace('Movimento Financeiro',25)+sep+TipoMovimento+sep+strspace(QMovfin.fieldbyname('movf_numerodcto').Asstring,10)+
         ' '+sep+formatdatetime('dd/mm/yy',QMovfin.fieldbyname('movf_dataprevista').asdatetime)+
         ' '+sep+FGeral.Formatavalor(QMovfin.fieldbyname('movf_valorger').ascurrency,f_cr)+
         sep+' Conta '+QMovfin.fieldbyname('movf_plan_conta').asstring+' '+
             strspace(FPlano.GetDescricao(QMovfin.fieldbyname('movf_plan_conta').asinteger),30) ;
      Linhas.Add(s);
      QMovfin.Next;

    end;
// 08.12.20 - Apropria��es
   campo := Sistema.Getdicionario('apropriacoes','APRO_COMV_CODIGO');
   if campo.Tipo<>'' then begin

      QApropria := sqltoquery('select * from apropriacoes where apro_transacao = '+EdTransacao.assql);
      if not QApropria.eof then  begin

        s:=strspace('Movimento Apropria��es',25)+sep+TipoMovimento+sep+strspace(QApropria.fieldbyname('apro_numerodoc').Asstring,10)+
           ' '+sep+formatdatetime('dd/mm/yy',QApropria.fieldbyname('apro_data').asdatetime)+
           ' '+sep+FGeral.Formatavalor(QApropria.fieldbyname('apro_valor').ascurrency,f_cr)+
           sep+' '+inttostr(QApropria.fieldbyname('apro_nvezes').asinteger)+' Vezes'+' Conta '+QApropria.fieldbyname('apro_plan_codigo').asstring+' '+
               strspace(FPlano.GetDescricao(QApropria.fieldbyname('apro_plan_codigo').asinteger),30) ;
        Linhas.Add(s);

      end;
      FGeral.Fechaquery( QApropria );

   end;

// 29.10.08
    QMovEstoque:=sqltoquery('select * from movestoque inner join estoque on (esto_codigo=move_esto_codigo)'+
                 ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                 ' left join cores on (core_codigo=move_core_codigo)'+
                 ' where move_transacao='+EdTransacao.AsSql+
                 ' and move_tipomov='+stringtosql(tipomov)+
                 ' and move_status<>''C''');  // 16.06.11
    while not QMovEstoque.eof do begin
      TipoMovimento:=strspace(QMovEstoque.fieldbyname('esto_descricao').asstring,45)+' ';
      tamanho:='';cor:='';
      if QMovestoque.fieldbyname('move_tama_codigo').asinteger>0 then
        tamanho:=strspace(QMovestoque.fieldbyname('tama_descricao').asstring,10);
      if QMovestoque.fieldbyname('move_core_codigo').asinteger>0 then
        cor:=strspace(QMovestoque.fieldbyname('core_descricao').asstring,10);
      s:=strspace('Itens da Nota',25)+sep+TipoMovimento+sep+strspace(QMovEstoque.fieldbyname('move_numerodoc').Asstring,10)+
         ' '+sep+formatdatetime('dd/mm/yy',QMovEstoque.fieldbyname('move_datamvto').asdatetime)+
         ' '+sep+FGeral.Formatavalor(QMovEstoque.fieldbyname('move_venda').ascurrency*QMovEstoque.fieldbyname('move_qtde').ascurrency,f_cr)+
         ' '+sep+QMovEstoque.fieldbyname('esto_referencia').asstring+
         ' '+tamanho+' '+cor;
      Linhas.Add(s);
      QMovEstoque.Next;
    end;
// 07.06.17
    if chavedoc<>'' then begin
      s:=strspace('Chave do Documento',25)+sep+chavedoc;
      Linhas.Add(s);
    end;
// 15.01.08
//    if tipomov=Global.CodContrato then begin
// 29.04.08
    if pos(Global.CodContrato,tiposdemovimento)>0 then begin
      Qproducao:=sqltoquery('select * from movproducao where movp_transacao='+EdTransacao.assql);
      if not QProducao.eof then begin
        TipoMovimento:=strspace('Ordem de Produ��o',33);
        Unidade:=QProducao.fieldbyname('movp_unid_codigo').asstring;
        s:=strspace('Movimento Produ��o',25)+sep+TipoMovimento+sep+strspace(QProducao.fieldbyname('movp_numerodoc').Asstring,10)+
           ' '+sep+formatdatetime('dd/mm/yy',QProducao.fieldbyname('movp_datamvto').asdatetime)+
           ' '+sep+FGeral.Formatavalor(QProducao.fieldbyname('movp_venda').ascurrency,f_cr)+
           sep+' Obra  '+QProducao.fieldbyname('movp_nroobra').asstring+' '+
               space(30) ;
        Linhas.Add(s);
      end;
      FGeral.fechaquery(QProducao);
      Qproducao:=sqltoquery('select * from movobrasdet where movo_transacao='+EdTransacao.assql);
      if not QProducao.eof then begin
        TipoMovimento:=strspace('Itens da Obra',33);
        Unidade:=QProducao.fieldbyname('movo_unid_codigo').asstring;
        s:=strspace('Movimento Obra',25)+sep+TipoMovimento+sep+strspace(QProducao.fieldbyname('movo_numerodoc').Asstring,10)+
           ' '+sep+formatdatetime('dd/mm/yy',QProducao.fieldbyname('movo_datamvto').asdatetime)+
           ' '+sep+FGeral.Formatavalor(QProducao.fieldbyname('movo_venda').ascurrency,f_cr)+
           sep+' Obra  '+QProducao.fieldbyname('movo_nroobra').asstring;
        Linhas.Add(s);
      end;
      FGeral.fechaquery(QProducao);

    end;
// 04.08.15
//////////////
    FGeral.FechaQuery(QMovfin);
    QMovfin:=sqltoquery('select * from cheques where cheq_transbaixa='+EdTransacao.assql);
    while not QMovfin.eof do begin
      if QMovfin.fieldbyname('cheq_rc').asstring='E' then
        TipoMovimento:=strspace('Cheque Emitido         ',33)
      else
        TipoMovimento:=strspace('Cheque Recebido        ',33);
      Unidade:=QMovfin.fieldbyname('cheq_unid_codigo').asstring;
// 26.05.10
      if codusuario=0 then codusuario:=QMovfin.fieldbyname('cheq_usua_codigo').AsInteger;
      s:=strspace('Movimento Cheques',25)+sep+TipoMovimento+sep+strspace(QMovfin.fieldbyname('cheq_cheque').Asstring,10)+
         ' '+sep+formatdatetime('dd/mm/yy',QMovfin.fieldbyname('cheq_predata').asdatetime)+
         ' '+sep+FGeral.Formatavalor(QMovfin.fieldbyname('cheq_valor').ascurrency,f_cr)+
         sep+' Conta '+QMovfin.fieldbyname('cheq_plan_contadep').asstring+' '+
             strspace(FPlano.GetDescricao(QMovfin.fieldbyname('cheq_plan_contadep').asinteger),30) ;
      Linhas.Add(s);
      QMovfin.Next;
    end;
// 20.06.16
    if ( (Global.topicos[1043]) or (Global.topicos[1045])  ) and ( Transacaocontax<>'')  then begin
      sqldatacontax:='';
      if Datetoano(xdata,true)> 1902 then sqldatacontax:=' and mcon_datamvto = '+Datetosql(xdata);
      QContabil:=FGEral.SqlToQueryContax('select * from movcon'+
////////////////////////      inner join planocon on (pcon_conta=mcon_pcon_conta)'+
                 ' where mcon_transacao='+Stringtosql(transacaocontax)+
                 sqldatacontax+
                 ' and mcon_status =''N''');
      while not Qcontabil.eof do begin
        QPlano:=FGEral.SqlToQueryContax('select * from planocon where pcon_conta = '+QContabil.fieldbyname('mcon_pcon_conta').asstring);
        if Qcontabil.fieldbyname('mcon_dc').asstring='D' then
          s:=strspace('Contabiliza��o   ',25)+sep+QPlano.fieldbyname('pcon_descricao').asstring+sep+transacaocontax+sep+''+sep+FGeral.Formatavalor(QContabil.fieldbyname('mcon_valor').ascurrency,f_cr)+sep+'D�bito :'+QContabil.FieldByName('mcon_pcon_conta').Asstring
        else
          s:=strspace('Contabiliza��o   ',25)+sep+QPlano.fieldbyname('pcon_descricao').asstring+sep+transacaocontax+sep+''+sep+FGeral.Formatavalor(QContabil.fieldbyname('mcon_valor').ascurrency,f_cr)+sep+'Cr�dito :'+QContabil.FieldByName('mcon_pcon_conta').Asstring;
        Linhas.Add(s);
        fGeral.fechaquery(qPlano);
        Qcontabil.Next;
      end;
      fGeral.fechaquery(qcontabil);
    end;

//////////////////////////
{
    FTextRel.Init(60);
    largura:=129;
    FTextRel.MargemEsquerda:=3;
    margem:=FTextRel.MargemEsquerda;
    FTextRel.AddTitulo(space(margem)+Global.NomeSistema+' '+Global.VersaoSistema+space(86)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
    FTextRel.AddTitulo(FGeral.Centra('Detalhamento da Transa��o '+EdTransacao.text+cancelada,largura),false,false,true);
    FTextRel.AddTitulo(space(margem)+replicate('-',largura+3),false,false,true);
    FTextRel.AddTitulo(space(margem)+'Unidade : '+Unidade+' - '+FUnidades.Getnome(Unidade)+' - Usu�rio '+inttostr(codusuario)+' '+FUsuarios.GetNome(codusuario),false,false,true);
    FTextRel.AddTitulo(space(margem)+replicate('-',largura+3),false,false,true);
    FTextRel.AddTitulo(space(margem)+'Movimenta��o'+space(13)+'Tipo'+space(29)+'Documento'+space(02)+'Movim.'+
                       space(12)+'Valor'+space(01)+'Diversos',false,false,true);
    FTextRel.AddTitulo(space(margem)+replicate('-',largura+3),false,false,true);
    for p:=0 to Linhas.count-1 do begin
      FTextRel.AddLinha(linhas[p],false,false,true);
    end;
    FTextRel.Video;
}
//////////////////////////
    FRel.Init('RelTransacao',20);
    FRel.AddTit('Detalhamento da Transa��o '+EdTransacao.text+cancelada);
    FRel.AddTit('Unidade : '+Unidade+' - '+FUnidades.Getnome(Unidade)+' - Usu�rio '+inttostr(codusuario)+
                ' '+FUsuarios.GetNome(codusuario)+' - Data de Lan�amento : '+FGeral.FormataData(xdatalcto) );
    if (confmovimento>0) then begin
      FRel.AddTit('Configura��o de Movimento : '+inttostr(confmovimento)+
                  ' - '+FConfMovimento.GetDescricao(confmovimento)+
                  ' Tipo de Movimento : '+TipoMov );
     end;
//    FRel.AddCol(800,1,'C','','','Movimenta��o'+space(13)+'Tipo'+space(29)+'Documento'+space(02)+'Movim.'+
//                       space(12)+'Valor'+space(01)+'Diversos','','',true);
    FRel.AddCol(150,1,'C','','','Movimenta��o','','',true);
    FRel.AddCol(280,1,'C','','','Tipo','','',true);
    FRel.AddCol(090,1,'C','','','Documento','','',true);
    FRel.AddCol(100,2,'D','','','Movim.','','',true);
    FRel.AddCol(100,3,'N','','','Valor','','',true);
    FRel.AddCol(220,1,'C','','','Diversos','','',true);

    for p:=0 to Linhas.count-1 do begin
//      FRel.AddCel(linhas[p]);
       strtolista(Lista,Linhas[p],sep,true);
       for n:=0 to Lista.count-1 do begin
         FRel.AddCel(Lista[n]);
       end;
       Lista.clear;
    end;
    FRel.Video;

    Freeandnil(Linhas);QMovesto.close;QPendencias.close;Qmovbase.close;
    Freeandnil(QMovesto);Freeandnil(QPendencias);Freeandnil(QMovbase);
    FGeral.FechaQuery(QMovEstoque);FGeral.FechaQuery(QMovFin);
    Sistema.EndProcess('');
  end;
end;


procedure TFRelGerenciais.baplicarClick(Sender: TObject);
begin
  if not EdTransacao.ValidEdiAll(FRelGerenciais,99) then exit;
  Saiok:=true;
  close;

end;

procedure TFRelGerenciais.FormActivate(Sender: TObject);
begin
  FRelGerenciais.EdTransacao.SetFirstEd;
  FRelGerenciais.EdTransacao.text:=Global.Ultimatransacao;

end;

procedure TFRelGerenciais.EdTransacaoValidate(Sender: TObject);
begin
//  FRelgerenciais.baplicarClick(Sender);
end;

procedure FRelGerenciais_AuditoriaFiscal;    // 2
///////////////////////////////////////////
var Q,Q1,
    QPlano          :TSqlquery;
    doc,tiposnao,sqlcfops,sqltipos,titentsai,xarq,
    serie,
    tipomov,
    cstpis,
    sqlespecies,
    xcnpjcpf        :string;
    valorimposto,vlripi,vlrST,vlracrescimo,vlrdesconto:currency;
    ListaSintegra,
    ListaDespesasCST53   :TStringList;
    mes,
    ano:integer;
    venc : TDatetime;
    CfopsIsentosEntradas,CfopsIsentosSaidas,
    CfopsAquisicaoBensparaRevenda,CfopsAquisicaoBensparaInsumo,CfopsAquisicaoServicosparaInsumo,
    CfopsDevolucaoVendaNaoCumulativa,
    CfopsOutrasEntradascomCredito:string;
    campo                        :TDicionario;


    // 09.05.14
    function GetValorSintegra(xnumerodoc:Integer;xcfop:String;xAliqIcms:currency):currency;
    ///////////////////////////////////////////////////////////////////////////////////////////////
    var i,numero:integer;
        cfop:string;
        aliqicms:currency;
    begin
      result:=0;
      for i:=0 to ListaSintegra.Count-1 do begin
        if ( copy(ListaSintegra[i],1,2)='50' ) then begin
          numero:=strtointdef(copy(ListaSintegra[i],46,6),0);
          cfop:=copy(ListaSintegra[i],52,4);
          aliqicms:=Texttovalor( copy(ListaSintegra[i],122,4) )/100;
          if (numero=xnumerodoc) and (cfop=xcfop) and (xaliqicms=aliqicms) then begin
             result:=Texttovalor(copy(ListaSintegra[i],57,13))/100;
             break;
          end;
        end;
      end;
    end;

// 04.07.14
    function GetValorSintegraTotal(xnumerodoc:Integer;xcfop:String;xAliqIcms:currency):currency;
    ///////////////////////////////////////////////////////////////////////////////////////////////
    var i,numero:integer;
        cfop:string;
        aliqicms:currency;
    begin
      result:=0;
      for i:=0 to ListaSintegra.Count-1 do begin
        if ( copy(ListaSintegra[i],1,2)='50' ) then begin
          numero:=strtointdef(copy(ListaSintegra[i],46,6),0);
          cfop:=copy(ListaSintegra[i],52,4);
          aliqicms:=Texttovalor( copy(ListaSintegra[i],122,4) )/100;
          if (numero=xnumerodoc) then begin
             result:=result+Texttovalor(copy(ListaSintegra[i],57,13))/100;
          end;
        end;
      end;
      if pos( copy(xcfop,2,3),'353;352' ) > 0  then begin
        result:=0;
        for i:=0 to ListaSintegra.Count-1 do begin
          if ( copy(ListaSintegra[i],1,2)='70' ) then begin
            numero:=strtointdef(copy(ListaSintegra[i],46,6),0);
            cfop:=copy(ListaSintegra[i],52,4);
            aliqicms:=Texttovalor( copy(ListaSintegra[i],122,4) )/100;
            if (numero=xnumerodoc) then begin
               result:=result+Texttovalor(copy(ListaSintegra[i],57,12))/100;
            end;
          end;
        end;
      end;
    end;

    // 21.05.19
    function GetVencimento(xt:string):Tdatetime;
    ////////////////////////////////////////////
    var QF:TSqlquery;
    begin

        QF:=sqltoquery('select pend_datavcto from pendencias where pend_transacao = '+Stringtosql(xt)+
                       ' and pend_status <> ''C''');
        if not Qf.eof then result:=Qf.fieldbyname('pend_datavcto').AsDatetime else result:=0;
        FGeral.Fechaquery(Qf);

    end;


// 24.09.19
////////////
    //////////////////////////////////////////
    function GetModelo(tipomov:string):string;
    //////////////////////////////////////////
//modelo de documento fiscal     01 - nf modelo 1 ou 1A     02 - nf venda consumidor modelo 2
//                               04 - nf produtor   e MAIS UM MONTE...
    begin
      result:='01';
      if ( ( Q.fieldbyname('moes_dtnfecanc').AsDateTime>1 ) or
         ( Q.fieldbyname('moes_dtnfeauto').AsDateTime>1 ) ) and
         (  Global.UsaNfe='S' )
         then
         result:='55'
      else if (Q.fieldbyname('moes_xmlnfet').AsString<>'' ) and
              (Q.fieldbyname('moes_chavenfe').AsString<>'' ) then begin
         result:='55';
         if pos(tipomov,Global.CodConhecimento+';'+Global.CodConhecimentoSaida)>0 then result:='57';

      end else if pos(tipomov,Global.CodConhecimento+';'+Global.CodConhecimentoSaida)>0 then begin
        result:='08';
        if uppercase(Q.fieldbyname('moes_especie').AsString)='CTE' then
          result:='57';
      end else if pos(tipomov,Global.CodPrestacaoServicos)>0 then begin
        result:='PS';
      end else if pos(tipomov,Global.CodPrestacaoServicosE)>0 then begin
        result:='PA';
      end else if pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,2,3),'251;252;253') > 0 then
        result:='06'    // contas de energia eletrica
      else if pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,2,3),'302;303') > 0 then
        result:='22'    // contas de telefone
      else  if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'567')>0 ) then
           Result:='02'
      else  if Pos( Q.fieldbyname('moes_tipomov').AsString,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor )>0 then
          result:='04'
      else  if (uppercase(copy(Q.fieldbyname('moes_especie').AsString,1,2))='NF') and (copy(Q.FieldByName('moes_serie').asstring,1,1)='1') then
          result:='01';

    end;

    function GetNumeroAp( xt:string ):string;
    //////////////////////////////////////////
    var Qa : TSqlquery;
    begin

        Qa := sqltoquery('select * from apropriacoes where apro_transacao = '+
                   stringtosql( xt )+
                   ' and Extract( year from apro_data ) = '+strzero(Datetoano(FRelGerenciais.EdDatai.asdate,true) ,4)+
                   ' and Extract( month from apro_data ) = '+strzero(Datetomes(FRelGerenciais.EdDataf.asdate) ,2)+
                   ' and apro_status = ''N''');
        if not Qa.eof then

           result := Qa.fieldbyname('apro_nvezes').asstring

        else

           result :='0';

        FGeral.FechaQuery(Qa);

    end;


begin

  with FRelGerenciais do begin


    if not FRelGerenciais_Execute(2) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');

    if Global.Usuario.Codigo=100 then begin
      Sistema.BeginProcess('Armazenando arquivo Sintegra');
      mes:=Datetomes(EdDataf.asdate);
      ano:=Datetoano(EdDataf.asdate,false);
      ListaSintegra:=TStringList.Create;
      xarq:='SI'+copy(EdUnid_codigo.text,1,3)+strzero(mes,2)+strzero(ano,2)+'.TXT' ;
      if FileExists( xarq ) then
        ListaSintegra.LoadFromFile( xarq );
    end;

    tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+Global.CodContrato+';'+
              Global.CodRomaneioRemessaaOrdem+';'+   // 28.07.11 - Capeg - Leonir
              Global.CodVendaInterna;  // 27.10.11 - Mama
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if trim(EdTipomov.text)<>'' then begin
//      sqltipomovto:=' and '+FGeral.getin('movb_tipomov',EdTipomov.text,'C')
// 30.05.06
      sqltipomovto:=' and '+FGeral.getin('moes_tipomov',EdTipomov.text,'C');
// 27.02.12 - everaldo quer escolher os romaneios pra cancelar as transacoes ...
      tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+Global.CodContrato+';'+
                Global.CodVendaInterna;  // 27.10.11 - Mama
    end else
      sqltipomovto:='';
// 30.05.05
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and moes_tipo_codigo='+EdCodtipo.assql;
      if Edtipocad.text='R' then
        sqlcodtipo:=' and moes_repr_codigo='+EdCodtipo.assql;

    end;
// 12.12.08
    sqlcfops:='';
    if not EdCfops.IsEmpty then
      sqlcfops:=' and '+FGeral.GetIN('movb_natf_codigo',EdCfops.text,'C');

    if EdEntSai.text='E' then begin
      sqltipos:=' and substr(moes_natf_codigo,1,1) in (''1'',''2'',''3'')';
      titentsai:=' - ENTRADAS';
    end else if EdEntSai.text='S' then begin
      sqltipos:=' and substr(moes_natf_codigo,1,1) in (''5'',''6'',''7'')';
      titentsai:=' - SAIDAS';
    end else begin
      sqltipos:='';
      titentsai:=' - ENTRADAS E SAIDAS';
    end;
// 10.01.23
    sqlespecies:='';
    if not EdEspecies.IsEmpty then begin
      sqlespecies:=' and '+FGeral.GetIN('moes_especie',EdEspecies.Text,'C');
      titentsai:=titentsai + ' - Esp�cies : '+EdEspecies.Text;
    end;

    if Global.Topicos[1510] then  begin

        ListaDespesasCST53:=TStringList.Create;
        if FileExists( 'ListaDespesasCST53.txt' ) then begin
           try
              ListaDespesasCST53.LoadFromFile( 'ListaDespesasCST53.txt' );
           except
              Avisoerro('N�o foi poss�vel ler o arquivo ListaDespesasCST53.txt');
              exit;
           end;
        end;
        if not FGeral.ConectaContax then  begin
              Avisoerro('N�o foi poss�vel conectar com o Contax');
              exit;
        end;

    end;

    CfopsIsentosEntradas:=FGeral.GetConfig1AsString('Cfopspiscofinse');
    CfopsIsentosSaidas:=FGeral.GetConfig1AsString('Cfopspiscofinss');

    campo:=Sistema.GetDicionario('plano','plan_cstpiscofins');


// 31.10.18    - Novicarnes - Ketlen

    CfopsAquisicaoBensparaRevenda:='1102;1113;1117;1118;1121;1251;1403;1652;2102;2113;2117;'+
                                   '2118;2121;2251;2403;2652;3102;3251;3652';
    CfopsAquisicaoBensparaInsumo:='1101;1111;1116;1120;1122;1126;1128;1401;1407;1556;1651;'+
                                  '1653;2101;2111;2116;2120;2122;2126;2128;2401;2407;2556;'+
                                  '2651;2653;3101;3126;3128;3556;3651;3653';
    CfopsAquisicaoServicosparaInsumo:='1124;1125;1933;2124;2125;2933';
    CfopsDevolucaoVendaNaoCumulativa:='1201;1202;1203;1204;1410;1411;1660;1661;1662;2201;'+
                                      '2202;2410;2411;2660;2661;2662';
    CfopsOutrasEntradascomCredito:='1922;2922';


// retornado esta em 02.09.05
    Sistema.BeginProcess('Pesquisando movimento');
    Q:=sqltoquery('select * from movesto'+
//                  ' left join movbase on (moes_transacao=movb_transacao and moes_status=movb_status and moes_tipomov=movb_tipomov)'+
// 01.09.08
                  ' left join movbase on (moes_transacao=movb_transacao and moes_tipomov=movb_tipomov and movb_status<>''C'')'+
//                  ' where moes_datalcto>='+EdDatai.AsSql+' and moes_datalcto<='+EdDataf.AsSql+
                  ' where moes_datamvto>='+EdDatai.AsSql+' and moes_datamvto<='+EdDataf.AsSql+
                  sqlunidade+sqltipomovto+sqlcodtipo+

                  ' and '+fGeral.GetNOTIN('moes_tipomov',tiposnao,'C')+

                  ' and moes_natf_codigo is not null '+
                  ' and '+FGeral.Getin('moes_status','N;X;E;D;Y;I','C')+
                  ' and moes_datacont is not null'+
                  sqlcfops+sqltipos+sqlespecies+
//                  ' and movb_status<>''C'''+  / assim 'nao pega' conhecimentos-CT
                  ' order by moes_unid_codigo,moes_datalcto,moes_numerodoc,movb_cst' );
//    Q:=sqltoquery('select * from movbase'+
//                  ' inner join movesto on (moes_transacao=movb_transacao and moes_status=movb_status)'+
//                  ' inner join movesto on (moes_transacao=movb_transacao and moes_status=movb_status'+
//                  ' and movb_tipomov=moes_tipomov )'+
//                  ' where moes_datalcto>='+EdDatai.AsSql+' and moes_datalcto<='+EdDataf.AsSql+
// 30.05.05 - reges -quando altera nf antes de imprimir 'nao encontra'
//                  ' where moes_datamvto>='+EdDatai.AsSql+' and moes_datamvto<='+EdDataf.AsSql+
//                  sqlunidade+sqltipomovto+sqlcodtipo+
//                  ' and '+FGeral.Getin('moes_status','N;X;E','C')+
//                  ' order by moes_unid_codigo,moes_datamvto,moes_numerodoc,movb_cst' );

    Sistema.BeginProcess('Pesquisando movimento');
    if Q.Eof then

      Avisoerro('Nada encontrado para impress�o')

    else begin

      FRel.Init('RelAuditoriaFiscal');
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
      FRel.AddTit('Rela��o de Auditoria Fiscal '+titentsai);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 80,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'  ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Emiss�o'    ,''         ,'',false);
      FRel.AddCol( 60,3,'N','' ,''              ,'Nota'     ,''         ,'',False);
//      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Repres.'     ,''         ,'',false);
//      FRel.AddCol(150,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
//      if Global.UsaNfe='S' then
      if (Global.Usuario.Codigo=100) and ( EdEntSai.Text='E' )  then
         FRel.AddCol(150,1,'C','' ,''            ,'Manifesto'   ,''         ,'',false)
      else
         FRel.AddCol(150,1,'C','' ,''            ,'Situa��o Sefa'   ,''         ,'',false);

      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Emitente'    ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Emitente'        ,''         ,'',false);
      FRel.AddCol(050,1,'C','' ,''              ,'F/J'        ,''         ,'',false);
// 15.02.18
//      if (Global.Topicos[1050]) and (EdEntSai.Text='E') then
// 07.10.19 - Novicarnes - Simone
      if (Global.Topicos[1050]) then
        FRel.AddCol(150,1,'C','' ,''              ,'CNPJ/CPF'        ,''         ,'',false);

      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Total Nota'           ,''         ,'',False);
      if global.Usuario.Codigo=100 then begin
        FRel.AddCol( 80,3,'N','+',f_cr            ,'Sintegra' ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+',f_cr            ,'Dif.' ,''         ,'',False);
      end;
      FRel.AddCol( 50,0,'C','' ,''              ,'Cfop'            ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'Esp.'            ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'S�rie'            ,''         ,'',False);
      FRel.AddCol( 20,0,'C','' ,''              ,'UF'              ,''         ,'',False);
      FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
      FRel.AddCol( 40,0,'C','' ,''              ,'ST'              ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Vlr p/CFOP+IPI+ST' ,''         ,'',False);
      if global.Usuario.Codigo=100 then
        FRel.AddCol( 80,3,'N','+',f_cr            ,'Sintegra CFOP' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','' ,'##0.00'        ,'Redu��o'         ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Base Icms'       ,''         ,'',False);
      FRel.AddCol( 60,3,'N','' ,'##0.00'        ,'Al�quota'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor Imposto'   ,''         ,'',False);
// 21.09.18 - Novicarnes - Ketlen - Polli contadores
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Base Iss'       ,''         ,'',False);
      FRel.AddCol( 60,3,'N','' ,'##0.00'        ,'Al�quota'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor Iss'       ,''         ,'',False);

      FRel.AddCol( 80,1,'C','' ,''              ,'Nota(s) Produtor' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Base Icms Subs'  ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor Icms Subs' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor Ipi'       ,''         ,'',False);
      if Global.topicos[1510] then begin

         FRel.AddCol( 80,1,'D','' ,''              ,'Vencimento' ,''         ,'',False);
         FRel.AddCol( 80,1,'N','' ,''              ,'Conta'       ,''         ,'',False);
         FRel.AddCol(180,1,'C','' ,''              ,'Descri��o Conta' ,''         ,'',False);
         FRel.AddCol(060,1,'C','' ,''              ,'CST Pis' ,''         ,'',False);
         FRel.AddCol( 80,1,'N','' ,''              ,'Reduzido'       ,''         ,'',False);
         FRel.AddCol(180,1,'C','' ,''              ,'Descri��o Reduzido' ,''         ,'',False);
// 26.08.20
         FRel.AddCol( 80,3,'N','' ,''              ,'Ap.' ,''         ,'',False);

      end ;

      doc:='XYzwewe';
      serie:='LOPa';
      tipomov:='p5gg)';

      while not Q.eof do begin

        FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
//        FRel.AddCel(Q.FieldByName('moes_datalcto').AsString);
        FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
        FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
        FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
//        FRel.AddCel(Q.fieldbyname('moes_repr_codigo').asstring);
//        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_repr_codigo').asinteger,'R','N'));
//        if Global.UsaNfe='S' then begin

          if Q.fieldbyname('moes_status').asstring='N' then begin

            if EdEntSai.Text='E' then begin

               if (Global.Usuario.Codigo=100) and ( EdEntSai.Text='E' ) and ( Q.fieldbyname('moes_tipomov').asstring = Global.CodConhecimento )  then

                  FRel.AddCel(Q.fieldbyname('moes_retornomanifesto').asstring)

               else

                  FRel.AddCel(Q.fieldbyname('moes_chavenfe').asstring);

            end else if ( Q.FieldByName('moes_chavenfe').AsString<>'' )
// 13.08.2021
                        or
                        ( Q.FieldByName('moes_xmlnfet').AsString<>'' )
              then

              FRel.AddCel(Q.fieldbyname('moes_retornonfe').asstring)

            else if AnsiPos( copy(Q.FieldByName('moes_natf_codigo').AsString,1,1), '567' ) > 0 then

              FRel.AddCel('Nota ainda n�o autorizada')

            else

              FRel.AddCel(Q.fieldbyname('moes_retornonfe').asstring);


          end else

            FRel.AddCel(Q.fieldbyname('moes_retornonfe').asstring);

//        end;

        FRel.AddCel(Q.fieldbyname('moes_tipo_codigo').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.FieldByName('moes_tipocad').AsString,'R'));
// 03.03.23
        xcnpjcpf:=FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.FieldByName('moes_tipocad').AsString);
        if length(trim(xcnpjcpf))=11 then
           FRel.AddCel('F')
        else
           FRel.AddCel('J');
// 15.02.18
//        if (Global.Topicos[1050]) and (EdEntSai.Text='E') then
// 07.10.19 - Novicarnes - Simone
        if (Global.Topicos[1050]) then
          FRel.AddCel( FGeral.Formatacnpjcpf( xcnpjcpf ));
// 14.12.13
//        if doc<>Q.FieldByName('moes_numerodoc').AsString then begin
// 25.06.19 - devido a coincidencia de notas de mesmo numero porem series / tipos diferentes
        if (doc<>Q.FieldByName('moes_numerodoc').AsString) or
           ( tipomov <> Q.FieldByName('moes_tipomov').AsString )
           then begin

          FRel.AddCel(Q.FieldByName('moes_vlrtotal').AsString);
// 04.07.14
          if global.Usuario.Codigo=100 then begin
             if Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimento then begin
               FRel.AddCel( floattostr( GetValorSintegraTotal(Q.FieldByName('moes_numerodoc').AsInteger,Q.FieldByName('moes_natf_codigo').AsString,Q.FieldByName('movb_aliquota').AsCurrency) ) );
               FRel.AddCel( floattostr( Q.FieldByName('moes_vlrtotal').AsCurrency - GetValorSintegraTotal(Q.FieldByName('moes_numerodoc').AsInteger,Q.FieldByName('moes_natf_codigo').AsString,Q.FieldByName('movb_aliquota').AsCurrency) ) );
             end else begin
               FRel.AddCel( floattostr( GetValorSintegraTotal(Q.FieldByName('moes_numerodoc').AsInteger,Q.FieldByName('movb_natf_codigo').AsString,Q.FieldByName('movb_aliquota').AsCurrency) ) );
               FRel.AddCel( floattostr( Q.FieldByName('moes_vlrtotal').AsCurrency - GetValorSintegraTotal(Q.FieldByName('moes_numerodoc').AsInteger,Q.FieldByName('movb_natf_codigo').AsString,Q.FieldByName('movb_aliquota').AsCurrency) ) );
             end;
          end;
        end else begin
          FRel.AddCel('');
          if global.Usuario.Codigo=100 then begin
            FRel.AddCel('');
            FRel.AddCel('');
          end;
        end;
        if pos(Q.FieldByName('movb_natf_codigo').AsString,'1401;1403;2403;1910;2910;5401;5405;6404')>0 then
            vlrST:=Q.FieldByName('moes_valoricmssutr').AsCurrency
        else
            vlrst:=0;
// 05.05.14
        vlracrescimo:=0;
        if ( Q.FieldByName('moes_totprod').AsCurrency>0 ) and (Q.FieldByName('moes_peracres').AsCurrency>0) then begin
//          vlracrescimo:=Q.FieldByName('movb_basecalculo').AsCurrency*(Q.FieldByName('moes_peracres').AsCurrency/100);
// 18.06.19  - acrescimo 'por dentro'
          vlracrescimo:= ( Q.FieldByName('movb_basecalculo').AsCurrency/
                          ((100-Q.FieldByName('moes_peracres').AsCurrency)/100) )
                         - Q.FieldByName('movb_basecalculo').AsCurrency;
        end;
        vlrdesconto:=0; // nao precisa pois j� est� incluso na base
//        if ( Q.FieldByName('moes_totprod').AsCurrency>0 ) and (Q.FieldByName('moes_perdesco').AsCurrency>0) then begin
//          vlrdesconto:=Q.FieldByName('movb_basecalculo').AsCurrency*(Q.FieldByName('moes_perdesco').AsCurrency/100);
//        end;
////////////
        if trim(Q.FieldByName('movb_natf_codigo').AsString)='' then
          FRel.AddCel(Q.FieldByName('moes_natf_codigo').AsString)
        else
          FRel.AddCel(Q.FieldByName('movb_natf_codigo').AsString);
        FRel.AddCel(Q.FieldByName('moes_especie').AsString);
        FRel.AddCel(Q.FieldByName('moes_serie').AsString);
        FRel.AddCel(Q.FieldByName('moes_estado').AsString);
        if Q.FieldByName('moes_status').AsString='X' then
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+' - Nota fiscal cancelada')
        else if Q.FieldByName('moes_status').AsString='Y' then
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+' - Nfe Denegada')
        else if Q.FieldByName('moes_status').AsString='I' then
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+' - Numera��o Inutilizada')
        else
//          FRel.AddCel(Q.FieldByName('movb_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('movb_tipomov').AsString));
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));
// 17.08.09 - Clessi - prever conhecimento transporte
        if Q.FieldByName('moes_tipomov').AsString<>Global.CodConhecimento then begin

          FRel.AddCel(Q.FieldByName('movb_cst').AsString);
          vlripi:=FSintegra.BuscaIPInositem(Q.FieldByName('moes_transacao').AsString,Q.FieldByName('movb_natf_codigo').AsString);

// 21.03.14 -caso informar ipi no total e nao nos itens
          Q1:=Sqltoquery('select * from movbase where movb_transacao='+STringtosql(Q.FieldByName('moes_transacao').AsString)+
                         ' and movb_tipomov='+Stringtosql(Q.FieldByName('moes_tipomov').asstring)+
                         ' and movb_natf_codigo<>'+Stringtosql(Q.FieldByName('movb_natf_codigo').AsString)+
                         ' and movb_status<>''C''');
//          if (vlripi=0) and (Q1.eof) then vlripi:=Q.FieldByName('moes_valoripi').AsCurrency;
// 23.09.15
//          if (vlripi=0) and (Q1.eof) then vlripi:=Q.FieldByName('moes_valoripi').AsCurrency;
// 23.09.15
          if (vlripi=0) and (doc<>Q.FieldByName('moes_numerodoc').AsString) then vlripi:=Q.FieldByName('moes_valoripi').AsCurrency;

          fGeral.FechaQuery(Q1);

//          FRel.AddCel( floattostr(Q.FieldByName('movb_basecalculo').AsCurrency+vlripi+vlrST+vlracrescimo-vlrdesconto) );
// 09.05.14 - notas sem base icms no movbase tipo ES por exemplo
          if Q.FieldByName('movb_basecalculo').AsCurrency=0 then
            FRel.AddCel( floattostr(Q.FieldByName('moes_vlrtotal').AsCurrency) )
// 06.08.19   - 'xunxo' pra ajeitar o relatorio devido campo movb_basecalculo gravado errado com acrescimo
          else if vlracrescimo>0 then
            FRel.AddCel( floattostr(Q.FieldByName('moes_vlrtotal').AsCurrency) )
          else
            FRel.AddCel( floattostr(Q.FieldByName('movb_basecalculo').AsCurrency+vlripi+vlrST) );
// 04.07.14
          if global.Usuario.Codigo=100 then
             FRel.AddCel( floattostr( GetValorSintegra(Q.FieldByName('movb_numerodoc').AsInteger,Q.FieldByName('movb_natf_codigo').AsString,Q.FieldByName('movb_aliquota').AsCurrency) ) );

          FRel.AddCel(Q.FieldByName('movb_reducaobc').AsString );
// 21.08.09 - 'adapt. tecnica' devido a nf saida so calc. icms caso houvesse reducao base
          valorimposto:=Q.FieldByName('movb_imposto').AsCurrency;
// 21.09.18
          if AnsiPos( Q.FieldByName('moes_tipomov').AsString,Global.CodPrestacaoServicos+';'+Global.CodPrestacaoServicosE)>0 then begin

              FRel.AddCel('');
              FRel.AddCel('');
              FRel.AddCel('');
              if (Q.FieldByName('movb_aliquota').AsCurrency>0) and (Q.FieldByName('movb_basecalculo').AsCurrency>0) and
                 ( pos(Q.FieldByName('moes_tipomov').AsString,Global.TiposSaida)>0 ) and
                 ( Q.FieldByName('movb_reducaobc').Ascurrency=0)
                 then
                 valorimposto:=Q.FieldByName('movb_basecalculo').AsCurrency*(Q.FieldByName('movb_aliquota').AsCurrency/100);
// 16.02.19
              if Q.FieldByName('moes_tipomov').AsString = Global.CodPrestacaoServicosE then
                 valorimposto:=Q.FieldByName('moes_valoriss').AsCurrency;

    // 14.07.09
              if Q.FieldByName('movb_reducaobc').Ascurrency>0 then
                FRel.AddCel( floattostr(Q.FieldByName('movb_basecalculo').AsCurrency*(Q.FieldByName('movb_reducaobc').Ascurrency/100)) )
              else if (Q.FieldByName('movb_imposto').AsCurrency>0) and  ( Q.FieldByName('moes_tipomov').AsString=Global.CodPrestacaoServicos  )  then
                FRel.AddCel(Q.FieldByName('movb_basecalculo').AsString)
              else
                FRel.AddCel('');
              if ( Q.FieldByName('moes_tipomov').AsString=Global.CodPrestacaoServicos  )  then
                 FRel.AddCel(Q.FieldByName('movb_aliquota').AsString)
              else
                 FRel.AddCel('');
              FRel.AddCel(floattostr(valorimposto));

          end else begin

              if (Q.FieldByName('movb_aliquota').AsCurrency>0) and (Q.FieldByName('movb_basecalculo').AsCurrency>0) and
                 ( pos(Q.FieldByName('moes_tipomov').AsString,Global.TiposSaida)>0 ) and
                 ( Q.FieldByName('movb_reducaobc').Ascurrency=0)
                 then
                 valorimposto:=Q.FieldByName('movb_basecalculo').AsCurrency*(Q.FieldByName('movb_aliquota').AsCurrency/100);
    // 14.07.09
              if ( Q.FieldByName('movb_reducaobc').Ascurrency>0 )  and (vlracrescimo=0) then
                FRel.AddCel( floattostr(Q.FieldByName('movb_basecalculo').AsCurrency*(Q.FieldByName('movb_reducaobc').Ascurrency/100)) )
// 06.08.19
              else if ( Q.FieldByName('movb_reducaobc').Ascurrency>0 )  and (vlracrescimo>0) then

                FRel.AddCel( floattostr(Q.FieldByName('moes_vlrtotal').AsCurrency*(Q.FieldByName('movb_reducaobc').Ascurrency/100)) )

              else if Q.FieldByName('movb_imposto').AsCurrency>0 then
                FRel.AddCel(Q.FieldByName('movb_basecalculo').AsString)
              else
                FRel.AddCel('');
              FRel.AddCel(Q.FieldByName('movb_aliquota').AsString);
              FRel.AddCel(floattostr(valorimposto));
              FRel.AddCel('');
              FRel.AddCel('');
              FRel.AddCel('');

           end;

        end else begin
// CTE...
          FRel.AddCel('');
          FRel.AddCel(Q.FieldByName('moes_baseicms').AsString);
          if global.Usuario.Codigo=100 then
            FRel.AddCel('' );
          FRel.AddCel('' );
          FRel.AddCel(Q.FieldByName('moes_baseicms').AsString);
          if (Q.FieldByName('moes_valoricms').Ascurrency>0) and (Q.FieldByName('moes_baseicms').Ascurrency>0) then
            FRel.AddCel( FloatTostr( (Q.FieldByName('moes_valoricms').Ascurrency/Q.FieldByName('moes_baseicms').Ascurrency)*100 ) )
          else
            FRel.AddCel('');
          FRel.AddCel(Q.FieldByName('moes_valoricms').AsString);
              FRel.AddCel('');
              FRel.AddCel('');
              FRel.AddCel('');

        end;

// 14.04.10 -
        if Q.FieldByName('moes_notapro').AsInteger>0 then
          FRel.AddCel( strzero(Q.FieldByName('moes_notapro').AsInteger,6)+';'+
                     strzero(Q.FieldByName('moes_notapro2').AsInteger,6)+';'+
                     strzero(Q.FieldByName('moes_notapro3').AsInteger,6) )
        else
          FRel.AddCel( '' );

        if (doc<>Q.FieldByName('moes_numerodoc').AsString) or
           ( tipomov <> Q.FieldByName('moes_tipomov').AsString ) or
           (vlrst>0)
           then begin
          FRel.AddCel(Q.FieldByName('moes_basesubstrib').AsString);
          FRel.AddCel(floattostr(vlrst));
          FRel.AddCel(Q.FieldByName('moes_valoripi').AsString);
        end else begin
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
        end;
        doc:=Q.FieldByName('moes_numerodoc').AsString;
// 02.07.19
        tipomov:=Q.FieldByName('moes_tipomov').AsString;

// 21.05.19
        if Global.topicos[1510] then begin

           Q1 := sqltoquery('select move_esto_codigo,move_unid_codigo,move_tipomov from movestoque where '+
                 'move_transacao = '+Stringtosql(Q.FieldByName('moes_transacao').AsString)+
                 ' and move_unid_codigo = '+Stringtosql(Q.FieldByName('moes_unid_codigo').AsString)+
                 ' and move_status <> ''C''' );

           venc:=GetVencimento( Q.FieldByName('moes_transacao').AsString );
           if Datetoano(venc,true)>1902 then
             FRel.AddCel( Datetostr_4(venc) )
           else
             FRel.AddCel('');
           if Q.FieldByName('moes_plan_codigo').AsInteger > 0 then begin

              if Q.FieldByName('moes_plan_codigo').AsInteger <> 9999 then begin

                 FRel.AddCel( Q.FieldByName('moes_plan_codigo').AsString );
                 FRel.AddCel( FPlano.GetDescricao(Q.FieldByName('moes_plan_codigo').AsInteger) );

              end else begin

                 FRel.AddCel( Q.FieldByName('moes_plan_codigo').AsString );
                 FRel.AddCel( Q.FieldByName('moes_devolucoes').AsString );

              end;

           end else begin

             FRel.AddCel('');
             FRel.AddCel('');
           end;


// 24.09.19 - Novicarnes - Ketlen
//////////////////////////////////
           if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin

              CSTPIS:=FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q1.fieldbyname('move_esto_codigo').asstring ) )  ;
              if Q.FieldByName('moes_plan_codigo').AsInteger  >0 then begin

                   if LIstaDespesasCST53.IndexOf( IntToStr( Q.FieldByName('moes_plan_codigo').AsInteger ) ) >=0  then begin

                     CSTPIS:= '53';

                   end else begin

                           if campo.Tipo<>'' then begin
                              cstpis:=FPlano.GetCSTPisCofins( Q.FieldByName('moes_plan_codigo').AsInteger);
                              if trim(cstpis)='' then begin
                                 CSTPIS:=FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q1.fieldbyname('move_esto_codigo').asstring ) )  ;
                              end;
                           end;

                   end;

              end;

              if ( Pos( Q.fieldbyname('moes_tipomov').asstring,Global.CodPrestacaoServicos+';'+Global.CodPrestacaoServicosE )  > 0 )
                 or ( Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , '06' )  >0 )
                 or ( Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , '22' )  >0 )
              then begin
                   if ( pos( Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodDrawBackSai+';'+
                            Global.CodTransfSai+';'+Global.CodPrestacaoServicos+';'+Global.CodPrestacaoServicosE ) = 0 ) then
                     if trim(cstpis)=''  then CSTPis:='96';

              end;


              if pos( Q.fieldbyname('moes_natf_codigo').asstring,CfopsIsentosEntradas ) >0 then begin

                  CSTPIS:='74' ;

              end else  if ( pos( Q.fieldbyname('moes_natf_codigo').asstring,CfopsAquisicaoBensparaRevenda+';'+CfopsAquisicaoBensparaInsumo+';'+
                      CfopsAquisicaoServicosparaInsumo+';'+CfopsDevolucaoVendaNaoCumulativa+';'+
                      CfopsOutrasEntradascomCredito ) = 0 ) and ( trim(cstpis)='' ) then
                  cstpis:='70';

           end else begin

               CSTPIS:=FEstoque.GetsituacaotributariaPIS(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  ;
                if pos( Q.fieldbyname('moes_natf_codigo').asstring,CfopsIsentosSaidas ) >0 then begin

                  CSTPIS:='08' ;
                end

           end;

           if ( Q1.fieldbyname('move_tipomov').asstring=Global.CodTransfSai ) then

                 CSTPIS:='08'

           else if ( Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimento ) then

                 CSTPIS:='53'


           else if ( Q1.fieldbyname('move_tipomov').asstring=Global.CodCompraProdutor ) then begin

                 CSTPIS:='73';

           end;

           FRel.AddCel( cstpis );
           FGeral.FechaQuery(Q1);
           if Q.FieldByName('moes_plan_codigo').AsInteger > 0 then begin



              QPlano:=FGEral.SqlToQueryContax('select * from planocon where pcon_conta = '+
                      inttostr( FPlano.GetContaExportacao(Q.fieldbyname('moes_plan_codigo').asinteger,Q.fieldbyname('moes_unid_codigo').asstring) ) );
//              FGEral.GetContaContax(Q.FieldByName('moes_plan_codigo').AsInteger)  );

              FRel.AddCel( QPlano.FieldByName('pcon_conta').AsString );
              FRel.AddCel( QPlano.FieldByName('pcon_descricao').AsString );
              fGeral.FechaQuery(QPlano);

           end else begin

              FRel.AddCel('');
              FRel.AddCel('');

           end;
// 26.08.20
           FRel.Addcel( GetNumeroAp( Q.FieldByName('moes_transacao').AsString) );
        end;

        Q.Next;

      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);
  end;

  FRelGerenciais_AuditoriaFiscal;    // 2

end;

procedure FRelGerenciais_ChequesRecebidos(xemirec:string='R');    // 3
/////////////////////////////////////////////////////////////////////
var Q,Q1:TSqlquery;
    sqlbompara,sqlDeposito,sqlorder,sqlperiodo,campodata,sqlprorroga,sqlemaberto,titemaberto,
    sqlemirec:string;
    emaberto,baixados:currency;
    contaemissao:integer;

    function EstanoPeriodo(campodata:string):boolean;
    /////////////////////////////////////////////////////
    begin
      result:=true;
{
      if campodata='cheq_predata' then begin
         if Q.FieldByName('cheq_prorroga').Asdatetime<=1 then
           result:=true
         else if ( Q.FieldByName('cheq_prorroga').Asdatetime>=FRelgerenciais.Edbomparai.asdate ) and
                 ( Q.FieldByName('cheq_prorroga').Asdatetime<=FRelgerenciais.Edbomparaf.asdate ) then
           result:=true
         else
           result:=false;
      end;
}

    end;

    function AbertoBaixado:boolean;
    /////////////////////////////////
    begin
      result:=true;
      titemaberto:=' - Todos os cheques';
      if (fRelgerenciais.EdEmaberto.text='A') and (Q.FieldByName('cheq_deposito').AsDatetime>1)then begin
         titemaberto:=' - Somente cheques Em Aberto';
         result:=false;
      end else if (fRelgerenciais.EdEmaberto.text='B') and (Q.FieldByName('cheq_deposito').AsDatetime<1)then begin
         titemaberto:=' - Somente cheques Baixados';
         result:=false;
      end;
    end;


begin
///////////////////////////////////

  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(3) then Exit;
    sqlemirec:=' and cheq_emirec = '+Stringtosql(xemirec);
    Sistema.BeginProcess('Gerando Relat�rio');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('cheq_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    sqlorder:=' order by cheq_unid_codigo,cheq_emitente,cheq_lancto,cheq_cheque';
    if EdDatai.isempty then
      sqlperiodo:=''
    else
      sqlperiodo:=' and cheq_lancto>='+EdDatai.AsSql+' and cheq_lancto<='+EdDataf.AsSql;
    campodata:='cheq_lancto';
    if (fRelgerenciais.EdEmaberto.text='A') then
       sqlemaberto:=' and cheq_deposito is null'
    else if (fRelgerenciais.EdEmaberto.text='B') then
//       sqlemaberto:=' and cheq_deposito>1'
       sqlemaberto:=' and cheq_deposito > '+DatetoSql(Global.DataMenorBanco)
    else
       sqlemaberto:='';
    sqlprorroga:='';
    if (EdBomparai.asdate>1) and (EdBomparaf.asdate>1) then begin
//      sqlbompara:=' and ( ( cheq_predata>='+EdBomparai.AsSql+' and cheq_predata<='+EdBomparaf.AsSql+' and cheq_prorroga<=1 ) '+
//                  ' or ( cheq_prorroga>='+EdBomparai.AsSql+' and cheq_prorroga<='+EdBomparaf.AsSql+') and cheq_prorroga>1  )';
//      sqlbompara:=' cheq_predata>='+EdBomparai.AsSql+' and cheq_predata<='+EdBomparaf.AsSql+' and cheq_prorroga is null';
// 09.08.05 - data de prorrogacao...viagem na maionese
      sqlbompara:=' cheq_predata>='+EdBomparai.AsSql+' and cheq_predata<='+EdBomparaf.AsSql;
      sqlprorroga:=' cheq_prorroga>='+EdBomparai.AsSql+' and cheq_prorroga<='+EdBomparaf.AsSql+' and cheq_prorroga is not null';
//      sqlorder:=' order by cheq_unid_codigo,cheq_predata,cheq_cheque';
      sqlorder:=' order by cheq_unid_codigo,cheq_emitente,cheq_predata,cheq_cheque';
//      sqlperiodo:='and ( ('+sqlbompara+') or ('+sqlprorroga+') )';
      sqlperiodo:='and '+sqlbompara;
      campodata:='cheq_predata';
    end else
      sqlbompara:='';
    if (EdDepositoi.asdate>1) and (EdDepositof.asdate>1) then begin
      sqlDeposito:=' and cheq_deposito>='+EdDepositoi.AsSql+' and cheq_deposito<='+EdDepositof.AsSql;
      sqlorder:=' order by cheq_unid_codigo,cheq_emitente,cheq_deposito,cheq_cheque';
      sqlperiodo:=sqldeposito;
      campodata:='cheq_deposito';
      sqlemaberto:='';
    end else
      sqlDeposito:='';
// 07.10.05
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      if EdTipocad.text='R' then
        sqlcodtipo:=' and cheq_repr_codigo='+EdCodtipo.assql
      else
        sqlcodtipo:=' and cheq_tipo_codigo='+EdCodtipo.assql;
    end;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and cheq_datacont>1';
// 27.05.10
      sqldatacont:=' and cheq_datacont > '+DateToSql(Global.DataMenorBanco);

    Q:=sqltoquery('select * from cheques left join representantes on (repr_codigo=cheq_repr_codigo)'+
//                  ' where cheq_emirec=''R'''+
                  ' where '+FGeral.Getin('cheq_status','N','C')+
                  sqlperiodo+sqlcodtipo+
                  sqlunidade+sqlemirec+
                  sqldatacont+
                  sqlemaberto+
                  sqlorder );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      titemaberto:=' - Todos os cheques';
/////////////////////////////
      if (fRelgerenciais.EdEmaberto.text='A') then begin
         titemaberto:=' - Somente cheques Em Aberto';
      end else if (fRelgerenciais.EdEmaberto.text='B') then begin
         titemaberto:=' - Somente cheques Baixados';
      end;
/////////////////////////////}

      FRel.Init('RelChequesRecebidos');
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
//      FRel.AddTit('Rela��o de Cheques Recebidos'+titemaberto);
      FRel.AddTit('Rela��o de Cheques Recebidos '+FGeral.TituloRelCliRepre(Edcodtipo.asinteger,EdTipocad.text) );
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
{
      if (EdBomparai.asdate>1) and (EdBomparaf.asdate>1) then
        FRel.AddTit('Periodo Bom para : '+FGeral.formatadata(Edbomparai.Asdate)+' a '+FGeral.formatadata(Edbomparaf.asdate))
      else if (EdDepositoi.asdate>1) and (EdDepositof.asdate>1) then
        FRel.AddTit('Periodo Deposito: '+FGeral.formatadata(EdDepositoi.Asdate)+' a '+FGeral.formatadata(EdDepositof.asdate))
      else
        FRel.AddTit('Periodo Lan�amento : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
}
      if ( not Edbomparai.isempty ) and (not EdDepositoi.isempty) and ( not Eddatai.isempty ) then
        FRel.AddTit('Periodo Bom para : '+FGeral.formatadata(Edbomparai.Asdate)+' a '+FGeral.formatadata(Edbomparaf.asdate)+
           ' - Periodo Deposito: '+FGeral.formatadata(EdDepositoi.Asdate)+' a '+FGeral.formatadata(EdDepositof.asdate)+
           ' - Periodo Lan�amento : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate))
      else if ( not Edbomparai.isempty ) and (not EdDepositoi.isempty)  then
        FRel.AddTit('Periodo Bom para : '+FGeral.formatadata(Edbomparai.Asdate)+' a '+FGeral.formatadata(Edbomparaf.asdate)+
           ' - Periodo Lan�amento : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate))
      else if ( not Edbomparai.isempty ) then
        FRel.AddTit('Periodo Bom para : '+FGeral.formatadata(Edbomparai.Asdate)+' a '+FGeral.formatadata(Edbomparaf.asdate) )
      else if  (not EdDepositoi.isempty)  then
        FRel.AddTit('Periodo Deposito: '+FGeral.formatadata(EdDepositoi.Asdate)+' a '+FGeral.formatadata(EdDepositof.asdate) )
      else if ( not Eddatai.isempty ) then
        FRel.AddTit('Periodo Lan�amento : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate) );
      FRel.AddCol( 70,0,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 50,0,'N','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(100,0,'C','' ,''              ,'Representante'   ,''         ,'',false);
      FRel.AddCol( 60,0,'N','' ,''              ,'Cliente'         ,''         ,'',false);
      FRel.AddCol(160,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'  ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Lan�amento'  ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Emiss�o'    ,''         ,'',false);
      FRel.AddCol( 70,0,'N','' ,''              ,'Numero Cheque'   ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor'           ,''         ,'',False);
      FRel.AddCol( 90,0,'C','' ,''              ,'Banco Emitente'  ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Emitente'  ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Bom para'   ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Dep�sito'   ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Prorroga��o',''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Observa��es',''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Devolvido'  ,''         ,'',false);
      FRel.AddCol( 90,0,'C','' ,''              ,'Banco Cust�dia'  ,''         ,'',false);
      while not Q.eof do begin
        if Estanoperiodo(campodata) and (AbertoBaixado) then begin
          FRel.AddCel(FUnidades.GetReduzido(Q.FieldByName('cheq_unid_codigo').AsString));
          FRel.AddCel(Q.fieldbyname('cheq_repr_codigo').asstring);
          FRel.AddCel(FRepresentantes.GetDescricao(Q.fieldbyname('cheq_repr_codigo').asinteger));
          FRel.AddCel(Q.fieldbyname('cheq_tipo_codigo').asstring);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('cheq_tipo_codigo').asinteger,Q.fieldbyname('cheq_tipocad').asstring,'N'));
          FRel.AddCel(Q.FieldByName('cheq_datacont').AsString);
          FRel.AddCel(Q.FieldByName('cheq_lancto').AsString);
          FRel.AddCel(Q.FieldByName('cheq_emissao').AsString);
          FRel.AddCel(Q.FieldByName('cheq_cheque').AsString);
// 16.11.16 - novicarnes - sandro
          if FGeral.GetConfig1AsInteger('Ctacheacompensar') > 0 then begin
            contaemissao:=FPlano.GetContaviaBanco(Q.FieldByName('Cheq_emit_banco').AsString);
            contaemissao:=FPlano.GetContaCompensacao(contaemissao);
//            Q1:=sqltoquery('select * from movfin where movf_unid_codigo='+Stringtosql(Q.FieldByName('cheq_unid_codigo').AsString)+
//                         ' and movf_numerocheque='+stringtosql(Q.FieldByName('cheq_cheque').AsString)+
//                         ' and movf_plan_contard = '+inttostr(FGeral.GetConfig1AsInteger('Ctacheacompensar'))+
//                         ' and movf_status = ''N''');
//            if not Q1.eof then
//                FRel.AddCel(Q1.FieldByName('movf_valorger').AsString)
//            else begin
//              FGeral.FechaQuery(Q1);
              Q1:=sqltoquery('select * from movfin where movf_unid_codigo='+Stringtosql(Q.FieldByName('cheq_unid_codigo').AsString)+
                         ' and movf_numerocheque='+stringtosql(Q.FieldByName('cheq_cheque').AsString)+
                         ' and movf_plan_conta = '+inttostr(contaemissao)+
                         ' and movf_status = ''N''');
               if not Q1.eof then
                  FRel.AddCel(Q1.FieldByName('movf_valorger').AsString)
               else
                 FRel.AddCel('');
//            end;
          end else begin

            if Q.FieldByName('cheq_deposito').AsDatetime>1 then begin
              if Q.FieldByName('cheq_valorrec').AsCurrency>0 then
                FRel.AddCel(Q.FieldByName('cheq_valorrec').AsString)
              else
                FRel.AddCel(Q.FieldByName('cheq_valor').AsString);
            end else
              FRel.AddCel(Q.FieldByName('cheq_valor').AsString);

          end;
          FRel.AddCel(Q.FieldByName('cheq_bcoemitente').AsString);
          FRel.AddCel(Q.FieldByName('cheq_emitente').AsString);
          FRel.AddCel(Q.FieldByName('cheq_predata').AsString);

          if FGeral.GetConfig1AsInteger('Ctacheacompensar') > 0 then begin
            if not Q1.Eof then begin
                FRel.AddCel(Q1.FieldByName('movf_datamvto').AsString);
                baixados:=baixados+Q.FieldByName('cheq_valor').Ascurrency;
            end else
              FRel.AddCel(Q.FieldByName('cheq_deposito').AsString);
            FGeral.FechaQuery(Q1);
          end else begin
            FRel.AddCel(Q.FieldByName('cheq_deposito').AsString);
            if Q.FieldByName('cheq_deposito').AsDatetime<1 then
              emaberto:=emaberto+Q.FieldByName('cheq_valor').Ascurrency
            else
              baixados:=baixados+Q.FieldByName('cheq_valor').Ascurrency;
          end;
          FRel.AddCel(Q.FieldByName('cheq_prorroga').AsString);
          FRel.AddCel(Q.FieldByName('cheq_obs').AsString);
          FRel.AddCel(Q.FieldByName('cheq_devolvido').AsString);
          FRel.AddCel(Q.FieldByName('Cheq_bancocustodia').AsString);
        end;

        Q.Next;
      end;

      FGeral.PulalinhaRel(18);

 //////////////////

          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('Bai.:'+formatfloat(f_cr,baixados));
          FRel.AddCel('');
          FRel.AddCel('Ab.:'+formatfloat(f_cr,emaberto));
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          

      if ( (Edbomparai.asdate=Edbomparaf.asdate) and (Edbomparai.asdate>1) ) or ( (EdDatai.asdate=Eddataf.asdate) and (eddatai.asdate>1) ) then
        FRel.Setsort('Codigo');
      FRel.Video;
//      FRel.Print(1);
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);;
  end;
  
  FRelGerenciais_ChequesRecebidos;    // 3

end;


procedure FRelGerenciais_AuditoriaCustos;     // 4
///////////////////////////////////////////////
var Q:TSqlquery;
    Tiposmov:string;
    vlrfrete,vlrref:currency;
begin
  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(4) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
//    Tiposmov:=Global.CodVendaConsig+';'+global.CodVendaDireta+';'+Global.CodCompra+';'+Global.CodVendaProntaEntrega+';'+
//              Global.CodVendaMagazine+';'+Global.CodVendaInternet+';'+Global.CodTransfEntrada+';'+Global.CodTransfSaida ;
    if trim(EdTipomov.text)<>'' then
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C')
    else
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.TiposRelVenda,'C');
    if not EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.getin('move_esto_codigo',EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);

    Q:=sqltoquery('select * from movestoque '+
//                  ' left join movesto on (moes_transacao=move_transacao and moes_status=move_status'+
                  ' inner join movesto on (moes_transacao=move_transacao)'+
//                  ' where move_datalcto>='+EdDatai.AsSql+' and move_datalcto<='+EdDataf.AsSql+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+sqlproduto+
                  ' and '+FGeral.Getin('move_status','N','C')+
                  ' and '+FGeral.Getin('moes_status','N','C')+
                  sqltipomovto+
                  sqldatacont+
                  ' order by moes_unid_codigo,move_esto_codigo,moes_datalcto,moes_numerodoc' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      FRel.Init('RelAuditoriaCustos');
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
      FRel.AddTit('Rela��o de Auditoria de Custos');
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 90,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'  ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Lan�amento'  ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Emiss�o'    ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Nota'      ,''         ,'',False);
      FRel.AddCol(100,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
      FRel.AddCol(090,0,'C','' ,''              ,'Produto'         ,''         ,'',False);
      FRel.AddCol(150,0,'C','' ,''              ,'Descri��o'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_quant2        ,'Quantidade'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','',f_cr            ,'Custo  Compra'    ,''         ,'',False);
      if Global.Usuario.OutrosAcessos[0010] then begin
        FRel.AddCol( 80,3,'N','',f_cr            ,'Custo Gerencial' ,''         ,'',False);
        FRel.AddCol( 80,3,'N','',f_cr            ,'Custo G.Cadastro' ,''         ,'',False);
      end;
      FRel.AddCol( 80,3,'N','',f_cr            ,'M�dio Compra' ,''         ,'',False);
      if Global.Usuario.OutrosAcessos[0010] then begin
        FRel.AddCol( 80,3,'N','',f_cr            ,'M�dio Gerencial' ,''         ,'',False);
        FRel.AddCol( 80,3,'N','',f_cr            ,'M�dio G.Cadastro' ,''         ,'',False);
      end;
      FRel.AddCol( 80,3,'N',''  ,f_cr             ,'Unit�rio'         ,''         ,'',False);
      FRel.AddCol( 80,3,'N',''  ,f_cr             ,'% Icms'           ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr            ,'Frete Proporcional'   ,''         ,'',False);
      FRel.AddCol( 70,3,'N',''  ,f_cr             ,'% Desconto'           ,''         ,'',False);
      FRel.AddCol( 70,3,'N',''  ,f_cr             ,'% Acr�scimo'          ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr            ,'Total Produto'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','&' ,f_cr            ,'Margem Bruta'         ,''         ,'',False);

      while not Q.eof do begin

        FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
        FRel.AddCel(Q.FieldByName('moes_datacont').AsString);
        FRel.AddCel(Q.FieldByName('moes_datalcto').AsString);
        FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
        FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
        FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));
        FRel.AddCel(Q.FieldByName('move_esto_codigo').AsString);
        FRel.AddCel(FEstoque.GetDescricao(Q.FieldByName('move_esto_codigo').AsString));
        FRel.AddCel(Q.FieldByName('move_qtde').AsString);
        FRel.AddCel(Q.FieldByName('move_custo').AsString);
        if Global.Usuario.OutrosAcessos[0010] then begin
          FRel.AddCel(Q.FieldByName('move_custoger').AsString);
          FRel.AddCel( floattostr( FEstoque.GetCusto(Q.FieldByName('move_esto_codigo').AsString,Global.unidadematriz,'') ) );
        end;
        FRel.AddCel(Q.FieldByName('move_customedio').AsString);
        if Global.Usuario.OutrosAcessos[0010] then begin
          FRel.AddCel(Q.FieldByName('move_customeger').AsString);
          FRel.AddCel( floattostr( FEstoque.GetCusto(Q.FieldByName('move_esto_codigo').AsString,Global.unidadematriz,'medioger') ) );
        end;
        FRel.AddCel(Q.FieldByName('move_venda').AsString);
        FRel.AddCel(Q.FieldByName('move_aliicms').asstring);
//        FRel.AddCel(Q.FieldByName('moes_frete').asstring);
// 19.01.06
        if Q.FieldByName('moes_totprod').ascurrency>0 then
          vlrref:=Q.FieldByName('moes_totprod').ascurrency
        else if Q.FieldByName('moes_vlrtotal').ascurrency>0 then
          vlrref:=Q.FieldByName('moes_vlrtotal').ascurrency
        else
          vlrref:=Q.FieldByName('moes_valortotal').ascurrency;
        if vlrref=0 then
          vlrfrete:=9999999
        else
          vlrfrete:=(Q.FieldByName('moes_frete').ascurrency/vlrref) * (Q.FieldByName('move_venda').ascurrency);
        FRel.AddCel(floattostr(vlrfrete));
//        FRel.AddCel(Q.FieldByName('moes_vlrtotal').asstring);
// 19.01.06
        FRel.AddCel(Q.FieldByName('moes_perdesco').AsString);
        FRel.AddCel(Q.FieldByName('moes_peracres').AsString);
        FRel.AddCel( floattostr(Q.FieldByName('move_venda').ascurrency*Q.FieldByName('move_qtde').AsCurrency) );
////////////////////
// 13.12.05
        if (Q.FieldByName('move_venda').AsCurrency>0) and ( pos(Q.FieldByName('move_tipomov').Asstring,Global.TiposRelVenda)>0 ) then
            FRel.AddCel( floattostr(  (Q.FieldByName('move_customeger').AsCurrency/Q.FieldByName('move_venda').AsCurrency)*100)    )
        else
            FRel.AddCel('');

        Q.Next;
      end;

      FRel.Setsort('Margem Bruta');
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;

  FRelGerenciais_AuditoriaCustos;     // 4

end;


////////////////////////////////////////////////////////////
procedure FRelGerenciais_Comissoes;              //
////////////////////////////////////////////////////////////
var Q,QF:TSqlquery;
    statusvalidos,sqlorder,sqlunidade,sqltipocod,tiposmov,tiposvenda,tiposdev,titulo,sqltipomov,devolucoes:string;
    avista,aprazo,devolucao,comissao,percomissao,perbonus,percomissao2:currency;
begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(5) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    statusvalidos:='N;E';
    sqlorder:=' order by moes_unid_codigo,moes_repr_codigo,moes_tipo_codigo,moes_numerodoc';
    sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
    if EdCodtipo.Asinteger>0 then begin
      if Edtipocad.text='R' then
        sqltipocod:=' and moes_repr_codigo='+EdCodtipo.assql
      else
        sqltipocod:=' and ( (moes_tipo_codigo='+EdCodtipo.assql+') and (moes_tipocad='+EdTipocad.Assql+') )';
    end else
      sqltipocod:='';
    if EdTipomov.isempty then begin
      tiposmov:=Global.CodRemessaConsig+';'+Global.CodTransfEntrada+';'+
                Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodRemessaProntaEntrega+';'+Global.CodSimplesRemessa;
      Tiposvenda:=Global.TiposRelVenda;
      Tiposdev:=Global.TiposRelDevVenda;
    end else begin
      tiposmov:='';
      tiposvenda:=EdTipomov.text;
    end;

    devolucoes:=Global.CodDevolucaoVenda+';'+Global.CodDevolucaoRoman+';'+Global.CodDevolucaoSerie5+';'+Global.CodDevolucaoIgualVenda;
    if trim(tiposmov)<>'' then
      sqltipomov:='and '+FGeral.GetNOTIN('moes_tipomov',tiposmov,'C')
    else
      sqltipomov:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and moes_datacont>1';
// 27.05.10
      sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);
// 23.08.10
    campo:=Sistema.GetDicionario('movesto','moes_permargem');
    titulo:='Comiss�o sobre Faturamento de '+FGeral.FormataData(Eddatai.asdate)+' a '+FGeral.FormataData(Eddataf.asdate)+
            ' - Tipos Impressos: '+TiposVenda+';'+TiposDev ;
    Q:=sqltoquery('select * from movesto'+
                  ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                  ' and moes_datamvto>='+Eddatai.AsSql+' and moes_datamvto<='+Eddataf.AsSql+
                  sqlunidade+
                  sqltipocod+
                  sqltipomov+
                  sqldatacont+
                  ' and '+FGeral.getin('moes_tipomov',tiposvenda+';'+tiposdev,'C')+
                  sqlorder );


    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      FRel.Init('RelComissoesFat');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
//      FRel.AddTit(Periodo);
//      FRel.AddCol( 70,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
//      FRel.AddCol( 60,1,'D','' ,''              ,'Lan�amento'      ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Emiss�o'         ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
//      FRel.AddCol( 40,0,'C','' ,''              ,'CFOP'            ,''         ,'',False);
      FRel.AddCol( 90,1,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
//      FRel.AddCol( 80,0,'C','' ,''              ,'Forma Pagto'     ,''         ,'',false);
//      FRel.AddCol( 90,0,'C','' ,''              ,'Portador'        ,''         ,'',false);
//      FRel.AddCol( 60,0,'C','' ,''              ,'Tipo'            ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Cod.repres.'     ,''         ,'',false);
      FRel.AddCol(140,0,'C','' ,''              ,'Nome repres.'    ,''         ,'',false);
//      FRel.AddCol(080,3,'N','+',f_cr            ,'Total Produtos'     ,''         ,'',false);
// 26.02.19 - Novicarnes
      FRel.AddCol(080,3,'N','+',f_cr            ,'Total Nota'     ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Devolu��es'      ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Total L�quido'   ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor comiss�o'  ,''         ,'',false);
      FRel.AddCol(080,3,'N','',f_cr             ,'Perc. comiss�o'  ,''         ,'',false);
//      FRel.AddCol(080,3,'N','',f_cr             ,'Perc. bonus'     ,''         ,'',false);
// 23.08.10
      if campo.Tipo<>'' then
        FRel.AddCol(080,3,'N','',f_cr             ,'Margem Lucro'    ,''         ,'',false);
      FRel.AddCol(070,1,'D','',''               ,'Vencimento'     ,''         ,'',false);
      FRel.AddCol(070,1,'D','',''               ,'Data Baixa'     ,''         ,'',false);
{
      FRel.AddCol(100,1,'C','' ,''              ,'Cidade'          ,''         ,'',False);
      FRel.AddCol( 40,1,'C','' ,''              ,'Estado'          ,''         ,'',False);
      FRel.AddCol( 80,3,'C','' ,''              ,'Popula��o'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','' ,''              ,'Cod usuario'  ,''         ,'',False);
      FRel.AddCol(100,1,'C','' ,''              ,'Nome'  ,''         ,'',False);
}
      while not Q.eof do begin
//          FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
          FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
          FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
//          FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
          FRel.AddCel(Q.FieldByName('moes_datacont').AsString);
          FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
//          FRel.AddCel(Q.FieldByName('moes_natf_codigo').AsString);
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));
//          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('moes_fpgt_codigo').AsString));
//          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('moes_port_codigo').AsString));
//          FRel.AddCel(Q.FieldByName('moes_tipocad').AsString);
          FRel.AddCel(Q.FieldByName('moes_tipo_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'N'));
          FRel.AddCel(Q.FieldByName('moes_repr_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_repr_codigo').AsInteger,'R','N'));
          avista:=0;aprazo:=0;
          if pos(Q.Fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 then  begin
//             aprazo:=Q.FieldByName('moes_totprod').Ascurrency;
// 31.10.05
//             if (aprazo=0) and (pos(Q.Fieldbyname('moes_tipomov').asstring,Global.CodVendaProntaEntrega+';'+Global.CodVendaRE)>0) then
// 26.02.19 - Novicarnes - Isonel/Vagner
               aprazo:=Q.FieldByName('moes_vlrtotal').Ascurrency;
             FRel.AddCel(floattostr(aprazo));

          end else begin

            FRel.AddCel('');

          end;
          devolucao:=0;
          if pos( Q.FieldByName('moes_tipomov').AsString,Devolucoes )>0 then begin
            devolucao:=Q.FieldByName('moes_totprod').Ascurrency;
            FRel.AddCel(Q.FieldByName('moes_totprod').Asstring);
          end else
            FRel.AddCel('');
          FRel.AddCel(valortosql(avista+aprazo-devolucao));
// 03.12.08 - 10.05.12 - colocado venda contrato nota
          if pos( Q.FieldByName('moes_tipomov').AsString,Global.CodContrato+';'+Global.CodContratoNota )>0 then begin
            percomissao:=Q.FieldByName('moes_percomissao').AsCurrency;
            percomissao2:=Q.FieldByName('moes_percomissao2').AsCurrency;
          end else begin
            percomissao:=FRepresentantes.GetPerComissao(Q.FieldByName('moes_repr_codigo').Asinteger,Q.FieldByName('moes_datamvto').AsDatetime,Q.FieldByName('moes_tipomov').AsString);
            percomissao2:=0;
          end;
//          perbonus:=FRepresentantes.GetPerBonus(Q.FieldByName('moes_repr_codigo').Asinteger,Q.FieldByName('moes_datamvto').AsDatetime,Q.FieldByName('moes_tipomov').AsString);
// 03.12.08 - desativado para ver se cria campo no cadastro de representantes
          perbonus:=0;
          comissao:=(avista+aprazo-devolucao) * (percomissao)/100;
//          comissao:=comissao+ ( comissao*(perbonus/100) );
// 23.08.10 - retirado o 'bonus' da toke
          FRel.AddCel(valortosql(comissao));
          FRel.AddCel(valortosql(percomissao));
          if campo.Tipo<>'' then
            FRel.AddCel(valortosql(Q.FieldByName('moes_permargem').AsCurrency));
//          FRel.AddCel(valortosql(perbonus));
// 18.08.08 - clessi - lam. sao caetano
          QF:=sqltoquery('select pend_databaixa,pend_datavcto from pendencias where pend_rp=''R'' and pend_transacao='+stringtosql(Q.FieldByName('moes_transacao').AsString));
          if not QF.eof then begin
            if QF.fieldbyname('pend_datavcto').AsDateTime>0 then
              FRel.AddCel(FGeral.Formatadata(QF.fieldbyname('pend_datavcto').AsDateTime) )
            else
              FRel.AddCel('');
            if QF.fieldbyname('pend_databaixa').AsDateTime>0 then
              FRel.AddCel(FGeral.Formatadata(QF.fieldbyname('pend_databaixa').AsDateTime) )
            else
              FRel.AddCel('');
          end else begin
              FRel.AddCel('');
              FRel.AddCel('');
          end;
          FGeral.FechaQuery(QF);
{
          FRel.AddCel(FCadcli.GetCidade(Q.FieldByName('moes_tipo_codigo').Asinteger));
          FRel.AddCel(FCadcli.GetUf(Q.FieldByName('moes_tipo_codigo').Asinteger));
          FRel.AddCel(inttostr(FCadcli.GetPopulacao(Q.FieldByName('moes_tipo_codigo').Asinteger)));
// 02.09.05
          FRel.AddCel(Q.FieldByName('moes_usua_codigo').Asstring);
          FRel.AddCel(FUsuarios.getnome(Q.FieldByName('moes_usua_codigo').Asinteger));
}
        if percomissao2>0 then begin
          FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
          FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
          FRel.AddCel(Q.FieldByName('moes_datacont').AsString);
          FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));
          FRel.AddCel(Q.FieldByName('moes_tipo_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'N'));
          FRel.AddCel(Q.FieldByName('moes_repr_codigo2').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_repr_codigo2').AsInteger,'R','N'));
          avista:=0;aprazo:=0;
          if pos(Q.Fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 then  begin
             aprazo:=Q.FieldByName('moes_totprod').Ascurrency;
             if (aprazo=0) and (pos(Q.Fieldbyname('moes_tipomov').asstring,Global.CodVendaProntaEntrega+';'+Global.CodVendaRE)>0) then
               aprazo:=Q.FieldByName('moes_vlrtotal').Ascurrency;
//             FRel.AddCel(floattostr(aprazo));
             FRel.AddCel('');
          end else begin
            FRel.AddCel('');
          end;
          devolucao:=0;
          if pos( Q.FieldByName('moes_tipomov').AsString,Devolucoes )>0 then begin
            devolucao:=Q.FieldByName('moes_totprod').Ascurrency;
//            FRel.AddCel(Q.FieldByName('moes_totprod').Asstring);
            FRel.AddCel('');
          end else
            FRel.AddCel('');
//          FRel.AddCel(valortosql(avista+aprazo-devolucao));
// retirado valores para nao 'dobrar faturamento'
          FRel.AddCel('');
//          perbonus:=FRepresentantes.GetPerBonus(Q.FieldByName('moes_repr_codigo').Asinteger,Q.FieldByName('moes_datamvto').AsDatetime,Q.FieldByName('moes_tipomov').AsString);
// 03.12.08 - desativado para ver se cria campo no cadastro de representantes
          perbonus:=0;
          comissao:=(avista+aprazo-devolucao) * (percomissao2)/100;
          comissao:=comissao+ ( comissao*(perbonus/100) );
          FRel.AddCel(valortosql(comissao));
          FRel.AddCel(valortosql(percomissao2));
          FRel.AddCel(valortosql(perbonus));
          FRel.AddCel('');
        end;
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

    FRelGerenciais_Comissoes;     //

  end;

end;

////////////////////////////////////////////////////
{
    Sistema.BeginProcess('Gerando Relat�rio');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
//  Tiposmov:=Global.CodVendaConsig+';'+global.CodVendaDireta+';'+Global.CodVendaProntaEntrega+';'+
//            Global.CodVendaMagazine+';'+Global.CodVendaInternet+';';
// trocar para o arquivo de pendencias q tem o campo de comissoes ja calculoado
//    Q:=sqltoquery('select pend_unid_codigo,pend_repr_codigo,sum(pend_valor) as parcela,sum(pend_valorcomissao) as comissao from pendencias '+

    Q:=sqltoquery('select * from pendencias '+
                  ' where pend_datamvto>='+EdDatai.AsSql+' and pend_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  ' and '+FGeral.Getin('pend_status','N','C')+
                  ' and pend_rp = ''R'''+
//                  ' and '+FGeral.Getin('pend_tipomov',tiposmov,'C')+
                  ' order by pend_unid_codigo,pend_repr_codigo' );
    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      FRel.Init('RelResumoVendasComissoes');
      FRel.AddTit('Vendas sobre Pendencias Financeiras');
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 45,1,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(120,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
//      FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
      FRel.AddCol( 80,0,'D','' ,''              ,'Emiss�o'         ,''         ,'',False);
      FRel.AddCol( 80,0,'D','' ,''              ,'Vencimento'      ,''         ,'',False);
      FRel.AddCol( 80,0,'D','' ,''              ,'Baixa'           ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr            ,'Valor Parcela'   ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr            ,'Valor Comiss�o'  ,''         ,'',False);
      FRel.AddCol( 40,0,'C','' ,''              ,'Parc'            ,''         ,'',False);
      FRel.AddCol( 40,0,'C','' ,''              ,'N.Parc.'         ,''         ,'',False);
      while not Q.eof do begin
        FRel.AddCel(Q.FieldByName('pend_unid_codigo').AsString);
        FRel.AddCel(Q.fieldbyname('pend_repr_codigo').asstring);
        FRel.AddCel(FRepresentantes.GetDescricao(Q.fieldbyname('pend_repr_codigo').asinteger));
//        FRel.AddCel(Q.FieldByName('pend_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('pend_tipomov').AsString));
        FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
        FRel.AddCel(Q.FieldByName('pend_datavcto').AsString);
        FRel.AddCel(Q.FieldByName('pend_databaixa').AsString);
        FRel.AddCel(Q.FieldByName('Pend_valor').AsString);
        FRel.AddCel(Q.FieldByName('Pend_valorcomissao').AsString);
        FRel.AddCel(Q.FieldByName('Pend_parcela').AsString);
        FRel.AddCel(Q.FieldByName('Pend_nparcelas').AsString);
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Free;
  end;
///////////////////////////////////////////////////////
}


//////////////////////////////////////////////
procedure FRelGerenciais_VendasQtde;   // 6
//////////////////////////////////////////////
type Vendas=record
     Unid_codigo,esto_codigo,tipovenda,cidade,cpf,endereco:string;
     repr_codigo,clie_codigo:integer;
     qtdevenda,vlrvenda,qtdevendaprev,vlrvendaprev,custo,custoprev:currency;
end;

var Q:TSqlquery;
    Lista:Tlist;
    PVendas : ^Vendas;
    p,posicao:integer;
    totqtde,totvalor,qtdeabc,valorabc:currency;
    margem:currency;

     function Procura(unidade:string;repre:integer;cliente:integer;produto,tipomov:string):integer;
     //////////////////////////////////////////////////////////////////////////////////////////////
     var x:integer;
     begin
       result:=-1;
       for x:=0 to Lista.count-1 do begin
         PVendas:=Lista[x];
         if (PVendas.Unid_codigo=unidade) and (PVendas.repr_codigo=repre) and (PVendas.clie_codigo=cliente)
             and (PVendas.esto_codigo=produto)
//             and (Ansipos(PVendas.esto_codigo,produto)>0) // 15.06.19 - retirado
             and (PVendas.tipovenda=tipomov) then begin   // 15.06.05
            result:=x;
            break;
         end;
       end;
     end;

     procedure Atualiza(qtde,unitario:currency;posicao:integer);
     ///////////////////////////////////////////////////////////////
     begin
       PVendas:=Lista[posicao];
//       if Q.fieldbyname('move_datacont').asdatetime<1 then begin
       if Q.fieldbyname('moes_datacont').asdatetime>1 then begin
         PVendas.qtdevenda:=PVendas.qtdevenda+qtde;
         PVendas.vlrvenda:=PVendas.vlrvenda+(qtde*unitario);
       end else begin
         PVendas.qtdevendaprev:=PVendas.qtdevendaprev+qtde;
         PVendas.vlrvendaprev:=PVendas.vlrvendaprev+(qtde*unitario);
       end;
     end;

// aqui em 16.02.06
    function GetValorunitario:currency;
    //////////////////////////////////
    begin
      if Q.fieldbyname('moes_tabp_codigo').asinteger>0 then
        result:=Q.fieldbyname('move_venda').ascurrency
      else if Q.fieldbyname('move_perdesco').ascurrency>0 then
        result:=Q.fieldbyname('move_venda').ascurrency
      else if Q.fieldbyname('moes_perdesco').ascurrency>0 then
        result:=Q.fieldbyname('move_venda').ascurrency - (Q.fieldbyname('move_venda').ascurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100)  )
      else if Q.fieldbyname('moes_peracres').ascurrency>0 then
        result:=Q.fieldbyname('move_venda').ascurrency + (Q.fieldbyname('move_venda').ascurrency*(Q.fieldbyname('moes_peracres').ascurrency/100)  )
      else
        result:=Q.fieldbyname('move_venda').ascurrency
    end;


var tiposmovto,titestoque:string;
begin
////////////////////////////////////////////////

  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(6) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');

// ver pedir se quer relat. sobre consigna��o, pronta entrega ou "outro esquema"
//    Tiposmov:=Global.CodVendaConsig+';'+Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig;
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
//    tiposmovto:=Global.CodVendaConsig+';'+Global.CodVendaDireta+';'+Global.CodVendaProntaEntrega+';'+global.CodVendaMagazine+';'+';'+Global.CodVendaInternet;
// 18.10.05 - cleuzina+cassio+reges
    tiposmovto:=Global.TiposRelVenda;
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C');
      tiposmovto:=EdTipomov.text;
    end else
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',tiposmovto,'C');
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and move_tipo_codigo='+EdCodtipo.assql;
      if Edtipocad.text='R' then  // 02.05.05
        sqlcodtipo:=' and move_repr_codigo='+EdCodtipo.assql;

    end;
    if not EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.getin('move_esto_codigo',EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);
    Q:=sqltoquery('select *,clie_razaosocial,clie_cnpjcpf,clie_endres from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' inner join clientes on ( clie_codigo=move_tipo_codigo )'+
                  ' left join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqlcodtipo+
                  sqltipomovto+
                  sqlproduto+
                  sqlgrupo+
                  sqlsubgrupo+
                  sqldatacont+
                  ' and '+FGeral.GetNotin('moes_status','C;X;Y','C')+
                  ' and '+FGeral.GetNotin('move_status','C;X;Y','C')+
//                  ' and move_status<>''C'''+
//                  ' and moes_status<>''C'''+  // 08.08.06
//                  ' and '+FGeral.Getin('move_status','D','C')+
                  ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_datamvto,move_esto_codigo' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      Lista:=Tlist.create;
      Sistema.beginprocess('Somando quantidade e valor vendido');
      totqtde:=0;totvalor:=0;

      while not Q.eof do begin

        posicao:=Procura(Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_repr_codigo').asinteger,
                 Q.fieldbyname('move_tipo_codigo').asinteger,Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_tipomov').asstring);
        if posicao<0 then begin
          New(PVendas);
          PVendas.Unid_codigo:=Q.fieldbyname('move_unid_codigo').asstring;
          PVendas.repr_codigo:=Q.fieldbyname('move_repr_codigo').asinteger;
          PVendas.clie_codigo:=Q.fieldbyname('move_tipo_codigo').asinteger;
          PVendas.esto_codigo:=Q.fieldbyname('move_esto_codigo').asstring;
          PVendas.tipovenda:=Q.fieldbyname('move_tipomov').asstring;
          PVendas.custo:=FEstoque.GetCusto(Q.fieldbyname('move_esto_codigo').asstring,Global.unidadematriz,'custo');
          PVendas.custoprev:=FEstoque.GetCusto(Q.fieldbyname('move_esto_codigo').asstring,Global.unidadematriz,'');
          if Q.fieldbyname('move_datacont').asdatetime<1 then begin
            PVendas.qtdevenda:=Q.fieldbyname('move_qtde').ascurrency;
            PVendas.vlrvenda:=Q.fieldbyname('move_qtde').ascurrency*GetValorUnitario;
            PVendas.qtdevendaprev:=0;
            PVendas.vlrvendaprev:=0;
          end else begin
            PVendas.qtdevendaprev:=Q.fieldbyname('move_qtde').ascurrency;
            PVendas.vlrvendaprev:=Q.fieldbyname('move_qtde').ascurrency*GetValorUnitario;
            PVendas.qtdevenda:=0;
            PVendas.vlrvenda:=0;
          end;
          PVendas.cpf:=Q.fieldbyname('clie_cnpjcpf').asstring;
          PVendas.cidade:=Q.fieldbyname('clie_cidade').asstring;
          PVendas.endereco:=Q.fieldbyname('clie_endres').asstring;
          Lista.Add(PVendas);
        end else
           Atualiza(Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_venda').ascurrency,posicao);

        Q.Next;

      end;

      if pos(';',EdEsto_codigo.text)>0 then titestoque:=' - Codigos informados : '+EdEsto_codigo.text
      else titestoque:=FGeral.TituloRelProduto(EdEsto_codigo.text);
      Sistema.beginprocess('Gerando relat�rio');
      FRel.Init('RelQtdeVendas');
      FRel.AddTit('Quantidade Vendida '+TituloTipoMov(tiposmovto)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,Edtipocad.text));
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+titestoque);
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate)+
                   FGeral.TituloGrupoproduto(EdGrup_codigo.text)+
                   FGeral.TituloSubGrupoproduto(EdSubGrup_codigo.text));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 45,1,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(120,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
      FRel.AddCol( 40,0,'C','' ,''              ,'Cod.'            ,''         ,'',False);
      FRel.AddCol(150,0,'C','' ,''              ,'Cliente'         ,''         ,'',False);
      FRel.AddCol(090,0,'C','' ,''              ,'CPF'             ,''         ,'',False);
      FRel.AddCol(120,0,'C','' ,''              ,'Endere�o'          ,''         ,'',False);
      FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
//      FRel.AddCol( 40,0,'N','' ,''              ,'Prod'        ,''         ,'',False);
// 03.03.09
      FRel.AddCol(100,0,'C','' ,''              ,'Grupo'        ,''         ,'',False);
      FRel.AddCol(100,0,'C','' ,''              ,'SubGrupo'        ,''         ,'',False);
      FRel.AddCol( 80,0,'N','' ,''              ,'Cod.Prod'        ,''         ,'',False);
      FRel.AddCol(120,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde'             ,''         ,'',False);
      FRel.AddCol( 80,3,'N',''  ,''             ,'% Total Qtde'     ,''         ,'',False);
      FRel.AddCol( 80,3,'N',''  ,''             ,'Unit�rio m�dio'   ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Total'     ,''         ,'',False);
      FRel.AddCol( 80,3,'N',''  ,''             ,'% Total Valor'     ,''         ,'',False);
//      if Global.Usuario.OutrosAcessos[0010] then begin
//        FRel.AddCol( 80,3,'N','+' ,''             ,'CMV gerencial'     ,''         ,'',False);
//        FRel.AddCol( 80,3,'N','+' ,''             ,'Margem Bruta'            ,''         ,'',False);
//      end;

      for p:=0 to Lista.count-1 do begin

        PVendas:=Lista[p];
        if not Global.Usuario.OutrosAcessos[0010] then begin
          totvalor:=totvalor+PVendas.vlrvenda;
          totqtde:=totqtde+PVendas.qtdevenda;
        end else begin
          totqtde:=totqtde+PVendas.qtdevenda+PVendas.qtdevendaprev;
          totvalor:=totvalor+PVendas.vlrvenda+PVendas.vlrvendaprev;
        end;

      end;

      for p:=0 to Lista.count-1 do begin

        PVendas:=Lista[p];
        FRel.AddCel(PVendas.Unid_codigo);
        FRel.AddCel(inttostr(PVendas.repr_codigo));
        FRel.AddCel(FRepresentantes.GetDescricao(PVendas.repr_codigo));
        FRel.AddCel(inttostr(PVendas.clie_codigo));
        FRel.AddCel(FCadcli.GetNome(PVendas.clie_codigo));
// 05.10.15
        FRel.AddCel((PVendas.cpf));
        FRel.AddCel((PVendas.endereco));
        FRel.AddCel(PVendas.tipovenda+'-'+FGeral.GetTipoMovto(PVendas.tipovenda));
//        FRel.AddCel(copy(PVendas.esto_codigo,1,2));
// 03.03.09
        FRel.AddCel(FGrupos.GetDescricao( FEstoque.GetGrupo(PVendas.esto_codigo) ) );
// 18.02.16
        FRel.AddCel(FSubGrupos.GetDescricao( FEstoque.GetSubGrupo(PVendas.esto_codigo) ) );
        FRel.AddCel(PVendas.esto_codigo);
        FRel.AddCel(FEstoque.GetDescricao(PVendas.esto_codigo));
        if not Global.Usuario.OutrosAcessos[0010] then begin
          FRel.AddCel(transform(PVendas.qtdevenda,f_qtdestoque));
          if totqtde>0 then
            qtdeabc:=(Pvendas.qtdevenda/totqtde)*100
          else
            qtdeabc:=0;
          FRel.AddCel(transform(qtdeabc,f_cr));
          if PVendas.qtdevenda=0 then
            FRel.AddCel('')
          else
            FRel.AddCel(transform(PVendas.vlrvenda/PVendas.qtdevenda,f_cr));
          FRel.AddCel(transform(PVendas.vlrvenda,f_cr));

        end else begin

          FRel.AddCel(transform(PVendas.qtdevenda+PVendas.qtdevendaprev,f_qtdestoque));
          if totqtde>0 then
            qtdeabc:=((Pvendas.qtdevenda+PVendas.qtdevendaprev)/totqtde)*100
          else
            qtdeabc:=0;
          FRel.AddCel(transform(qtdeabc,f_cr));
          if PVendas.qtdevenda+PVendas.qtdevendaprev=0 then
            FRel.AddCel('')
          else
            FRel.AddCel(transform((PVendas.vlrvenda+PVendas.vlrvendaprev)/(PVendas.qtdevenda+PVendas.qtdevendaprev),f_cr));
          FRel.AddCel(transform(PVendas.vlrvenda+PVendas.vlrvendaprev,f_cr));
          if totvalor>0 then
            valorabc:=((Pvendas.vlrvenda+PVendas.vlrvendaprev)/totvalor)*100
          else
            valorabc:=0;
          FRel.AddCel(transform(valorabc,f_cr));
//          FRel.AddCel(transform(PVendas.custoprev*(PVendas.qtdevenda+PVendas.qtdevendaprev),f_cr));
          if (PVendas.vlrvendaprev)>0 then
            margem:=( 1- (PVendas.custo*(PVendas.qtdevenda+PVendas.qtdevendaprev)/PVendas.vlrvendaprev) ) *100
          else
            margem:=0;
//          FRel.AddCel(transform(margem,f_cr));
        end;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Freeandnil(Lista);
    Q.close;
    Freeandnil(Q);

  end;
// 15.06.19
  FRelGerenciais_VendasQtde;

end;

// 25.05.10 - retornado aqui
procedure FRelGerenciais_ProntaEntregaAberto;  // 9

var Q,QSaidas:TSqlquery;
    produto,remessas,devolucoes,sqlespecial,sqlstatus,titespecial,vendas:string;
    vlrremessa,saldoqtde,saldoqtdeclie,vlrdevolucao:currency;
    repr,clie,p:integer;
    ListaVendas,lista:TStringlist;
    Datai:TDatetime;

{
    function DevolucaoOK(remessas,tipomov:string):boolean;
    var x:integer;
        found:boolean;
    begin
       found:=false;
       if tipomov=global.CodRemessaProntaEntrega then
         found:=true
       else begin
         found:=true;
         for x:=0 to Listaremessas.count-1 do begin
           if pos( strzero(strtoint(listaremessas[x]),8) , remessas )>0 then begin
             found:=false;
             break;
           end;
         end;
       end;
       result:=found;
    end;
}

begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(9) then Exit;
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
//  if trim(EdTipomov.text)<>'' then
//      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C')
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.CodRemessaProntaEntrega+';'+Global.CodDevolucaoProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodVendaTransf+';'+Global.CodVendaProntaEntrega,'C');
// sem codigo de devolu�ao de consigna�ao pois este somente � gerado quando � feito o acerto
//  else
//    sqltipomovto:='';

// 20.09.05
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and moes_tipo_codigo='+EdCodtipo.assql;
      if Edtipocad.text='R' then
        sqlcodtipo:=' and moes_repr_codigo='+EdCodtipo.assql;

    end;
    sqlespecial:='';
    remessas:='681;691;716;647;655;658;659;669;675;684;696;706;713;761;';
    devolucoes:='22578;22673';
    sqlstatus:=' and '+FGeral.Getin('move_status','N','C') +
               ' and '+FGeral.Getin('moes_status','N','C');  // 20.10.11
    vendas:='';
    titespecial:='';
    ListaVendas:=Tstringlist.create;
//    if FGeral.UsuarioTeste(global.usuario.codigo) then begin
//////////////////////////////////////////////////////////////
{
    if global.usuario.codigo=300 then begin
       sqlstatus:=' and '+FGeral.GetNOTIN('move_status','C','C');
       titespecial:=' - Remessas :'+remessas+' Devolu��es :'+devolucoes;

        QSaidas:=sqltoquery('select * from movestoque '+
    //                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                      ' inner join movesto on ( moes_transacao=move_transacao )'+
                      ' where move_datamvto>='+Eddatai.assql+' and move_datamvto<='+EdDataf.AsSql+
                      sqlunidade+
                      ' and '+FGeral.getin('move_tipomov',Global.CodVendaProntaEntrega+';'+Global.CodVendaBrinde,'C')+
                      sqlcodtipo+
                      ' and '+FGeral.GetNOTIN('move_status','C;E','C')+
                    ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_tipomov' );
        while not QSaidas.eof do begin
              if ListaVendas.indexof(QSaidas.fieldbyname('move_numerodoc').asstring)=-1 then begin
                ListaVendas.add(QSaidas.fieldbyname('move_numerodoc').asstring);
                vendas:=vendas+strzero(QSaidas.fieldbyname('move_numerodoc').asinteger,8)+';';
              end;
          QSaidas.next;
        end;
        sqlespecial:=' and '+fGeral.Getin('move_numerodoc',remessas+';'+devolucoes+';'+vendas,'N');
    end;
////////////////////////////////
}

    Sistema.BeginProcess('Checando remessas');
    Datai:=EdDatai.asdate-60;  // 26.09.05
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);

  
    Sistema.BeginProcess('Checando vendas');
    Q:=sqltoquery('select * from movestoque '+
//                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' inner join movesto on ( moes_transacao=move_transacao )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlcodtipo+
                  sqldatacont+
                  sqlespecial+  // 10.05.06
                  sqlstatus+
//                  ' and '+FGeral.Getin('move_tipomov',tiposmov,'C')+
//                ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_datalcto' );
                ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_tipomov' );
//                ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_tipomov' );
//                ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_numerodoc' );

    Sistema.BeginProcess('Gerando Relat�rio');
    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      FRel.Init('RelRemessaProntaEntregaAberto');
      FRel.AddTit('Relat�rio de Pronta Entrega em Aberto '+titespecial);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 45,1,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(120,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
      FRel.AddCol( 40,0,'C','' ,''              ,'Cod.'            ,''         ,'',False);
      FRel.AddCol(120,0,'C','' ,''              ,'Cliente'         ,''         ,'',False);
      FRel.AddCol( 80,0,'C','' ,''              ,'Cod.Prod'        ,''         ,'',False);
      FRel.AddCol(130,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
      FRel.AddCol( 50,1,'C','' ,''              ,'Documento'        ,''         ,'',False);
      FRel.AddCol( 60,3,'D','' ,''              ,'Data'             ,''         ,'',False);
      FRel.AddCol( 60,1,'C','' ,''              ,'Tipo'             ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Remessa'         ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Devolvida'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''              ,'Saldo Produto'        ,''         ,'',False);
//      FRel.AddCol( 80,3,'N','' ,''              ,'Saldo Cliente'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',''              ,'Valor Total'          ,''         ,'',False);
      while not Q.eof  do begin
        repr:=Q.fieldbyname('move_repr_codigo').asinteger;
        while (not Q.eof) and (repr=Q.fieldbyname('move_repr_codigo').asinteger)  do begin
          clie:=Q.fieldbyname('move_tipo_codigo').asinteger;
          saldoqtdeclie:=0;
          while (not Q.eof) and (repr=Q.fieldbyname('move_repr_codigo').asinteger) and (clie=Q.fieldbyname('move_tipo_codigo').asinteger)  do begin
            produto:=Q.fieldbyname('move_esto_codigo').asstring;
            saldoqtde:=0;
            while (not Q.eof) and (repr=Q.fieldbyname('move_repr_codigo').asinteger) and (clie=Q.fieldbyname('move_tipo_codigo').asinteger)
              and (produto=Q.fieldbyname('move_esto_codigo').asstring) do begin
// 26.09.05 - gambiarra devido a existencia de 'duas VB'...o sistema s� trata a ref. a PE mas foi colocado
//            o tipo VB na conf. de venda 54 e usado o tipo de movimento como VB : � usado na consigna��o
//            checar se sera necessario crir outro tipo de VB para uso na consigna��o...
//              if ( Q.fieldbyname('moes_comv_codigo').asinteger<>54 ) and (Devolucaook(Q.fieldbyname('move_remessas').asstring,Q.fieldbyname('move_tipomov').asstring) )
// 11.05.06
              if ( Q.fieldbyname('moes_comv_codigo').asinteger<>54 )
                then begin
                FRel.AddCel(Q.fieldbyname('move_unid_codigo').asstring);
                FRel.AddCel(inttostr(Q.fieldbyname('move_repr_codigo').asinteger));
//                FRel.AddCel(FRepresentantes.GetDescricao(Q.fieldbyname('move_repr_codigo').asinteger));
// 01.03.06 - clientdataset as vezes nao achava 'os cara'
                FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('move_repr_codigo').asinteger,'R','N'));
                FRel.AddCel(inttostr(Q.fieldbyname('move_tipo_codigo').asinteger));
                FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('move_tipo_codigo').asinteger,Q.fieldbyname('move_tipocad').asstring,'N'));
                FRel.AddCel(Q.fieldbyname('move_esto_codigo').asstring);
                FRel.AddCel(FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').asstring));
                FRel.AddCel(Q.fieldbyname('move_numerodoc').asstring);
                FRel.AddCel(formatdatetime('dd/mm/yy',Q.fieldbyname('move_datamvto').asdatetime));
                FRel.AddCel(Q.FieldByName('move_tipomov').AsString);
                if Q.fieldbyname('move_tipomov').asstring=Global.CodRemessaProntaEntrega then begin
                  FRel.AddCel(transform(Q.fieldbyname('move_qtde').ascurrency,f_qtdestoque));
                  FRel.AddCel('');
//                  saldoqtde:=saldoqtde+Q.fieldbyname('move_qtde').ascurrency;
// 28.06.06
                  saldoqtde:=Q.fieldbyname('move_qtde').ascurrency;
                  saldoqtdeclie:=saldoqtdeclie+Q.fieldbyname('move_qtde').ascurrency;
                  vlrremessa:=(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency);
                end else begin
                  FRel.AddCel('');
                  FRel.AddCel(transform(Q.fieldbyname('move_qtde').ascurrency,f_qtdestoque));
//                  saldoqtde:=saldoqtde-Q.fieldbyname('move_qtde').ascurrency;
// 28.06.06
                  saldoqtde:=(-1)*Q.fieldbyname('move_qtde').ascurrency;
                  saldoqtdeclie:=saldoqtdeclie-Q.fieldbyname('move_qtde').ascurrency;
                  vlrremessa:=(-1)*(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency);
                end;
                FRel.AddCel(transform(saldoqtde,f_cr));
//                FRel.AddCel(transform(saldoqtdeclie,f_cr));
                FRel.AddCel(transform(vlrremessa,f_cr));
              end;
              Q.Next;
            end;  // por produto
          end;  // por cliente
        end; // por representante
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
    if QSaidas<>nil then begin
      QSaidas.close;
      Freeandnil(QSaidas);
    end;

    FRelGerenciais_ProntaEntregaAberto;  // 9
  end;

end;



procedure TFRelGerenciais.Edunid_codigoValidate(Sender: TObject);
begin
  if trim(EdUnid_codigo.Text)='' then
    EdUnid_codigo.Text:=Global.Usuario.UnidadesRelatorios;
end;


procedure TFRelGerenciais.EddatafValidate(Sender: TObject);
begin
  if EdDataf.asdate<EdDatai.asdate then
   EdDataf.invalid('Data final tem que ser maior que a inicial')
  else if (rel=22) and ( not Global.topicos[1227] ) then
    SetaNumerosNotaSaida(EdNumeros,EdDatai.asdate,EdDataf.asdate);
end;

procedure TFRelGerenciais.EdTransacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdTransacao,key);
end;

procedure TFRelGerenciais.EdTipocadValidate(Sender: TObject);
begin
  if EdTipoCad.text='U' then begin
    EdCodtipo.ShowForm:='FUnidades';
    EdCodtipo.FindTable:='unidades';
    EdCodtipo.FindField:='unid_codigo';
  end else if EdTipoCad.text='C' then begin
    EdCodtipo.ShowForm:='FCadcli';
    EdCodtipo.FindTable:='clientes';
    EdCodtipo.FindField:='clie_codigo';
  end else if EdTipoCad.text='F' then begin
    EdCodtipo.ShowForm:='FFornece';
    EdCodtipo.FindTable:='fornecedores';
    EdCodtipo.FindField:='forn_codigo';
  end else if EdTipoCad.text='T' then  begin
    EdCodtipo.ShowForm:='FTransp';
    EdCodtipo.FindTable:='transportadores';
    EdCodtipo.FindField:='tran_codigo';
  end else if EdTipoCad.text='R' then begin
    EdCodtipo.ShowForm:='FRepresentantes';
    EdCodtipo.FindTable:='representantes';
    EdCodtipo.FindField:='repr_codigo';
  end else begin
    EdCodtipo.ShowForm:='';
    EdCodtipo.FindTable:='';
    EdCodtipo.FindField:='';
  end;


end;

procedure TFRelGerenciais.EdCodtipoValidate(Sender: TObject);
begin
  if EdCodtipo.AsInteger>0 then begin
    SetEdFavorecido.Text:=FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipoCad.text,'N');
    if trim(SetEdFavorecido.Text)='' then
      EdCodTipo.Invalid('N�o encontrado');
    EdCodtipo.enabled:=true;
  end else begin
    SetEdFavorecido.Text:='';
    EdCodtipo.text:='';
//    EdCodtipo.enabled:=false;
  end;

end;

function TFRelGerenciais.TituloTipoMov(movimentos: string): string;
begin
  if trim(movimentos)<>'' then
    result:=' - '+EdTipomov.text
  else
    result:='';
end;

function TFRelGerenciais.TituloConsigaberto(aberto: string): string;
begin
  if aberto='S' then
    result:=' - Somente consigna��es em aberto'
  else
    result:='';
end;



///////////////////////////////////////////////////////////
procedure FRelGerenciais_PosicaoCliente;      // 8
///////////////////////////////////////////////////////////
type Vendas=record
     Unid_codigo,esto_codigo:string;
     repr_codigo,clie_codigo:integer;
     remessa,devolucao,venda,vendaconsignada,vlrremessa:currency;
end;

var Q,QVd:TSqlquery;
    Lista:Tlist;
    PVendas : ^Vendas;
    p,posicao:integer;
    ListaJaBaixadosBP:TStringlist;
    dData:TDatetime;

var sqlconsigaberto,sqlrecpag,statusvalidos,recpag,sqlorder,sqlunidade,sqltipocod,linha,portador,
    sqlportadorcartao,xportadores:string;
    largura,nvezes,contvd:integer;
    totvalor,saldoqtde,vlrremessa,mediadiasatraso,vlrdevolucao,qtdremessa,qtddevolucao:currency;


// 15.04.14 - Vivan Liane
//////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
    function Tudobaixado(unidade,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer;saldo:currency):boolean;
    /////////////////////////////////////////////////////////////////////////////////////
    var Qbx:TSqlquery;
        valor:currency;
        sqldatacont:string;
    begin
      if Q.FieldByName('pend_status').AsString='N' then begin
        valor:=Q.FieldByName('pend_valor').AsCurrency;
        if Datacont>1 then
          sqldatacont:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco)
        else
          sqldatacont:=' and pend_datacont is null';
        QBx:=sqltoquery('select pend_valor from pendencias where pend_status=''P'' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
                      ' and pend_databaixa > '+DatetoSql(Global.DataMenorBanco)+
                      ' and pend_parcela='+inttostr(parcela)+
                      ' and pend_unid_codigo='+Stringtosql(Q.FieldByName('pend_unid_codigo').AsString)+
                      sqldatacont+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
        while not QBx.Eof do begin
          valor:=valor-QBx.fieldbyname('pend_valor').ascurrency;
          QBx.Next;
        end;
        Qbx.close;
        Freeandnil(Qbx);
        if valor<=0 then
          result:=true
        else
          result:=false;
      end else
        result:=false;
    end;


    function TudoBaixadoBP(xoperacao:string):boolean;
    //////////////////////////////////////////////////////
    begin
        if ListaJaBaixadosBP.IndexOf(xoperacao)>=0 then
          result:=true
        else
          result:=false;
    end;

    function GetPortadores(yportadores:string):string;
    /////////////////////////////////////////////////
    var Lista:TStringList;
        i:integer;
    begin
      Lista:=TStringList.create;
      strtolista(Lista,yportadores,';',true);
      result:='';
      for i:=0 to Lista.count-1 do begin
        if trim(Lista[i])<>'' then result:=result+Lista[i]+' - '+FPortadores.GetDescricao(Lista[i])+'  ';
      end;
    end;

begin
///////////////
  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(8) then Exit;
    if trim(EdCodtipo.text)='' then begin
      Avisoerro('Obrigat�rio escolher um cliente');
      exit
    end;
    Sistema.BeginProcess('Gerando Relat�rio');

    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if trim(EdTipomov.text)<>'' then
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C')
    else
//      sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig+';'+Global.CodVendaConsig,'C');
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C');

   sqlconsigaberto:='';     // ver se via usar
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);
///////////////////////////////

    Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
//                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  ' where '+FGeral.Getin('move_status','N','C')+
                  ' and '+FGeral.Getin('moes_status','N','C')+
                  ' and move_tipo_codigo='+EdCodtipo.assql+
                  ' and move_tipocad=''C'''+
                  sqlunidade+
                  sqltipomovto+
                  sqlconsigaberto+
                  sqldatacont+
                  ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_transacao' );
// 02.02.15 - Vivan - Cecilia
    sqltipomovto:=' and '+FGeral.getin('moes_tipomov',Global.CodVendaDireta,'C');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);
    dDAta:=Sistema.hoje-90;
    QVd:=sqltoquery('select moes_dataemissao,moes_vlrtotal,moes_numerodoc from movesto'+
                  ' where moes_datamvto>='+Datetosql(dData)+
                  ' and '+FGeral.Getin('moes_status','N','C')+
                  ' and moes_tipo_codigo='+EdCodtipo.assql+
                  ' and moes_tipocad=''C'''+
                  sqlunidade+
                  sqltipomovto+
                  sqlconsigaberto+
                  sqldatacont+
                  ' order by moes_unid_codigo,moes_dataemissao desc' );

////////////////////////////
// 07.01.14
//    if Q.Eof then
//      Avisoerro('Nada encontrado para impress�o')
//    else begin
      largura:=132;
      FTextRel.Init;
      FTextRel.AddTitulo(replicate('-',largura),false,false,true);
      FTextRel.AddTitulo('Extrato de Informa��es Financeiras do Cliente',false,false,true);
//      FTextRel.AddTitulo(FGeral.TituloRelUnidade(EdUnid_codigo.Text),false,false,true);
      FTextRel.AddTitulo('Cliente '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,'C','N')+' - '+EdCodtipo.text,true,false,true);
//      FTextRel.AddTitulo('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate),false,false,true);
      FTextRel.AddTitulo('Data de Cadastro : '+FGeral.formatadata(FCadcli.getdatadecadastro(EdCodtipo.asinteger) )+
                        ' - Representante : '+FRepresentantes.GetDescricao(EdCodtipo.ResultFind.fieldbyname('clie_repr_codigo').AsInteger)+
                        ' - Portador(es) : '+EdCodtipo.ResultFind.fieldbyname('clie_portadores').AsString
                        ,false,false,true);
      FTextRel.AddTitulo('Data : '+FGeral.formatadata(Sistema.hoje),false,false,true);
      FTextRel.AddTitulo(replicate('-',largura),false,false,true);

      saldoqtde:=0;vlrremessa:=0;vlrdevolucao:=0;qtdremessa:=0;
///////////////////////////////////////
      while not Q.eof do begin
          if Q.fieldbyname('move_tipomov').asstring=Global.CodRemessaConsig then begin
            saldoqtde:=saldoqtde+Q.fieldbyname('move_qtde').ascurrency;
            vlrremessa:=vlrremessa + (Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency);
            qtdremessa:=qtdremessa+Q.fieldbyname('move_qtde').ascurrency;
          end else begin
            saldoqtde:=saldoqtde-Q.fieldbyname('move_qtde').ascurrency;
            vlrdevolucao:=vlrdevolucao + (Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency);
            qtddevolucao:=qtddevolucao+Q.fieldbyname('move_qtde').ascurrency;
          end;
          Q.Next;
      end;
      if (qtdremessa+qtddevolucao) > 0 then begin
        FTextRel.AddLinha('Remessas em Aberto '+TituloTipoMov(EdTipomov.text),true,false,true);
        FTextRel.AddLinha(replicate('-',largura),false,false,true);
        FTextRel.AddLinha('Remessa    Devolu��o    Saldo             Valor',false,false,true);
        linha:=FGeral.Formatavalor(qtdremessa,f_integer)+space(06)+
               FGeral.Formatavalor(qtddevolucao,f_integer)+space(02)+
               FGeral.Formatavalor(saldoqtde,f_integer)+space(04)+
               FGeral.Formatavalor(vlrremessa-vlrdevolucao,f_cr) ;
        FTextRel.AddLinha(linha,false,false,true);
        FTextRel.AddLinha(replicate('-',largura),false,false,true);
      end;
// 02.02.15 - vivan -cecilia
      contvd:=0;
      if  not QVd.eof then begin
        FTextRel.AddLinha('Ultimas Vendas Diretas',true,false,true);
        FTextRel.AddLinha(replicate('-',largura),false,false,true);
        FTextRel.AddLinha('Emiss�o          Numero         Valor',false,false,true);
      end;
      while not QVd.eof do begin
        linha:=FGeral.Formatadata(QVd.fieldbyname('moes_dataemissao').asdatetime)+space(06)+
               FGeral.Formatavalor(QVd.fieldbyname('moes_numerodoc').asinteger,f_integer)+space(02)+
               FGeral.Formatavalor(QVd.fieldbyname('moes_vlrtotal').ascurrency,f_cr)+space(04);
        FTextRel.AddLinha(linha,false,false,true);
        Qvd.Next;
        inc(contvd);
        if contvd=2 then break;
      end;
      FGeral.FechaQuery(Qvd);
      if contvd>0 then
        FTextRel.AddLinha(replicate('-',largura),false,false,true);

//////////////////////////////////////////
      FTextRel.AddLinha('Contas a Receber BAIXADOS',true,false,true);
      FTextRel.AddLinha(replicate('-',largura),false,false,true);
      recpag:='R';
      sqlrecpag:=' and pend_RP='+stringtosql(Recpag);
      statusvalidos:='B;K';
      sqlorder:=' order by pend_unid_codigo,pend_datavcto,pend_numerodcto,pend_datacont,pend_parcela';
      sqlunidade:='';
      if EdCodtipo.Asinteger>0 then
        sqltipocod:=' and ( (pend_tipo_codigo='+EdCodtipo.assql+') and (pend_tipocad='+EdTipocad.Assql+') )'
      else
        sqltipocod:='';
/////////////////////      Q.close;
      if Global.Usuario.OutrosAcessos[0701] then
        sqldatacont:=''
      else
  //      sqldatacont:=' and pend_datacont>1';
  // 27.05.10
        sqldatacont:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco);
      Q.close;
      Q:=Sqltoquery( 'select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  ' and pend_databaixa is not null '+
                  sqlrecpag+
                  sqlunidade+
                  sqldatacont+
                  sqltipocod+
                  sqlorder  );
//      FTextrel.Addlinha('Unidade Documento Portador             Emiss�o  Vencimento Baixa    Parc   Np          Valor   Atraso',true,false,true);
//      FTextRel.AddLinha(replicate('-',largura),false,false,true);
      totvalor:=0;
      mediadiasatraso:=0;nvezes:=0;
      while not Q.eof do begin
//          if Global.Usuario.OutrosAcessos[0701] then
//            FRel.AddCel(Q.FieldByName('pend_datacont').AsString);
// ver como ficara esta questao neste relatorio - por enquanto mostra tudo sem diferenciar
        if trim(Q.FieldByName('pend_port_codigo').AsString)='' then
          portador:=space(15)
        else
          portador:=strspace(FPortadores.GetDescricao(Q.FieldByName('pend_port_codigo').AsString),15);
        linha:=Q.FieldByName('pend_unid_codigo').AsString+space(05)+strspace(Q.FieldByName('pend_numerodcto').AsString,10)+
               space(01)+portador+space(05)+
               FGeral.FormataData(Q.FieldByName('pend_dataemissao').Asdatetime)+' '+
               FGeral.FormataData(Q.FieldByName('pend_datavcto').Asdatetime)+space(03)+
               FGeral.FormataData(Q.FieldByName('pend_databaixa').Asdatetime)+space(03)+
               Q.FieldByName('pend_parcela').AsString+space(05)+
               Q.FieldByName('pend_nparcelas').AsString+' '+FGeral.Formatavalor(Q.FieldByName('pend_valor').Ascurrency,f_cr)+
               space(05)+inttostr(trunc(Q.FieldByName('pend_databaixa').Asdatetime-Q.FieldByName('pend_datavcto').Asdatetime));
//          FRel.AddCel(Q.FieldByName('pend_datamvto').AsString);
//          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('pend_fpgt_codigo').AsString));
        mediadiasatraso:=mediadiasatraso+trunc(Q.FieldByName('pend_databaixa').Asdatetime-Q.FieldByName('pend_datavcto').Asdatetime);
//        FTextREl.AddLinha(linha,false,false,true);
        totvalor:=totvalor+Q.FieldByName('pend_valor').Ascurrency;
        Q.Next;
        inc(nvezes);
      end;
      if totvalor>0 then begin
//        FTextRel.AddLinha(replicate('-',largura),false,false,true);
        FTextRel.AddLinha(space(39)+'TOTAL'+space(04)+FGeral.Formatavalor(totvalor,f_cr)+
                          space(02)+'Dias de atraso em m�dia '+
                          FGeral.Formatavalor(mediadiasatraso/nvezes,'####'),false,false,true);
      end;

///////////////////////////////////////////

// colocar aqui outra query dos em aberto do cliente, INDEPENDENTE DO periodo
      recpag:='R';
      sqlrecpag:=' and pend_RP='+stringtosql(Recpag);
      statusvalidos:='N';
//      sqlorder:=' order by pend_unid_codigo,pend_tipo_codigo,pend_dataemissao,pend_numerodcto,pend_datacont,pend_parcela';
      sqlorder:=' order by pend_unid_codigo,pend_datavcto,pend_numerodcto,pend_datacont,pend_parcela';
//      sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C');
      sqlunidade:='';
      if EdCodtipo.Asinteger>0 then
        sqltipocod:=' and ( (pend_tipo_codigo='+EdCodtipo.assql+') and (pend_tipocad='+EdTipocad.Assql+') )'
      else
        sqltipocod:='';
      Q.close;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and pend_datacont>1';
// 27.05.10
      sqldatacont:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco);
// 05.05.14
    sqlportadorcartao:='';
    if trim( FGeral.GetConfig1AsString('Portadorcartao') )<>'' then
      sqlportadorcartao:=' and '+FGeral.GetNOTIN('pend_port_codigo',FGeral.GetConfig1AsString('Portadorcartao'),'C');

      ListaJaBaixadosBP:=TStringList.create;

      Q.sql.text:='select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  ' and pend_databaixa is null '+
                  sqlrecpag+
                  sqlunidade+
                  sqldatacont+
                  sqltipocod+
                  sqlportadorcartao+
                  sqlorder ;
      Q.open;

///////////////////////
      Sistema.beginprocess('Checando titulos baixados com baixas parciais');
      while not Q.eof do begin
          if Q.FieldByName('pend_status').AsString='N' then begin
           if TudoBaixado(Q.FieldByName('pend_unid_codigo').AsString,Q.FieldByName('pend_tipo_codigo').AsString,Q.FieldByName('pend_tipocad').AsString,
              Q.FieldByName('pend_numerodcto').AsString,Q.FieldByName('pend_dataemissao').Asdatetime,
              Q.FieldByName('pend_datacont').Asdatetime,Q.FieldByName('pend_datavcto').Asdatetime,
              Q.FieldByName('pend_parcela').Asinteger,0) then
               ListaJaBaixadosBP.Add(Q.FieldByName('pend_operacao').AsString);
          end;
        Q.Next;
      end;
      Sistema.beginprocess('Gerando titulos em aberto');
      Q.First;

//////////////////////
      if not Q.eof then begin
        FTextRel.AddLinha('Contas a Receber EM ABERTO',true,false,true);
        FTextRel.AddLinha(replicate('-',largura),false,false,true);
        FTextrel.Addlinha('Unidade Documento Portador             Emiss�o  Vencimento Parc   Np          Valor   Atraso',true,false,true);
        FTextRel.AddLinha(replicate('-',largura),false,false,true);
      end;
      totvalor:=0;
      Sistema.beginprocess('Gerando relat�rio');
      while not Q.eof do begin
// 15.04.14
        if  not TudoBaixadoBP(Q.FieldByName('pend_operacao').AsString) then begin
//          if Global.Usuario.OutrosAcessos[0701] then
//            FRel.AddCel(Q.FieldByName('pend_datacont').AsString);
// ver como ficara esta questao neste relatorio - por enquanto mostra tudo sem diferenciar
        if trim(Q.FieldByName('pend_port_codigo').AsString)='' then
          portador:=space(15)
        else
          portador:=strspace(FPortadores.GetDescricao(Q.FieldByName('pend_port_codigo').AsString),15);
        linha:=Q.FieldByName('pend_unid_codigo').AsString+space(05)+strspace(Q.FieldByName('pend_numerodcto').AsString,10)+
               space(01)+portador+space(05)+
               FGeral.FormataData(Q.FieldByName('pend_dataemissao').Asdatetime)+' '+
               FGeral.FormataData(Q.FieldByName('pend_datavcto').Asdatetime)+space(05)+Q.FieldByName('pend_parcela').AsString+space(05)+
               Q.FieldByName('pend_nparcelas').AsString+' '+FGeral.Formatavalor(Q.FieldByName('pend_valor').Ascurrency,f_cr)+
               space(05)+inttostr(abs(FGeral.GetDiasAtraso(Q.FieldByName('pend_datavcto').Asdatetime,Sistema.hoje)));
//          FRel.AddCel(Q.FieldByName('pend_datamvto').AsString);
//          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('pend_fpgt_codigo').AsString));

        FTextREl.AddLinha(linha,false,false,true);
        totvalor:=totvalor+Q.FieldByName('pend_valor').Ascurrency;
       end;
       Q.Next;
      end;
      if totvalor>0 then begin
        FTextRel.AddLinha(replicate('-',largura),false,false,true);
        FTextRel.AddLinha(space(60)+'TOTAL'+space(04)+FGeral.Formatavalor(totvalor,f_cr),false,false,true);
      end;
//////////////////////////////
      FTextRel.AddLinha('Cheques A COMPENSAR ',true,false,true);
      FTextRel.AddLinha(replicate('-',largura),false,false,true);
      recpag:='R';
      sqlrecpag:=' and cheq_emirec='+stringtosql(Recpag);
      statusvalidos:='N';
      sqlorder:=' order by cheq_unid_codigo,cheq_predata,cheq_cheque,cheq_datacont';
      sqlunidade:='';
      if EdCodtipo.Asinteger>0 then
        sqltipocod:=' and cheq_tipo_codigo='+EdCodtipo.assql
      else
        sqltipocod:='';
      Q.close;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and pend_datacont>1';
// 27.05.10
      sqldatacont:=' and cheq_datacont > '+DateToSql(Global.DataMenorBanco);

      Q.close;
      Q.sql.text:='select * from cheques'+
                  ' where '+FGeral.Getin('cheq_status','N','C')+
                  ' and cheq_deposito is null '+
                  sqlrecpag+
                  sqlunidade+
                  sqldatacont+
                  sqltipocod+
                  sqlorder ;
      Q.open;
      FTextrel.Addlinha('Unidade  Numero      Banco  '+space(11)+'Emiss�o  Vencimento            Valor   ',true,false,true);
      FTextRel.AddLinha(replicate('-',largura),false,false,true);
      totvalor:=0;
      while not Q.eof do begin
        linha:=Q.FieldByName('cheq_unid_codigo').AsString+space(05)+strspace(Q.FieldByName('cheq_cheque').AsString,10)+
               space(03)+
               strspace(Q.FieldByName('cheq_bcoemitente').AsString,15)+space(03)+
               FGeral.FormataData(Q.FieldByName('cheq_emissao').Asdatetime)+' '+
               FGeral.FormataData(Q.FieldByName('cheq_predata').Asdatetime)+space(05)+
               FGeral.Formatavalor(Q.FieldByName('cheq_valor').Ascurrency,f_cr);

        FTextREl.AddLinha(linha,false,false,true);
        totvalor:=totvalor+Q.FieldByName('cheq_valor').Ascurrency;
        Q.Next;
      end;
      if totvalor>0 then begin
        FTextRel.AddLinha(replicate('-',largura),false,false,true);
        FTextRel.AddLinha(space(52)+'TOTAL'+space(04)+FGeral.Formatavalor(totvalor,f_cr),false,false,true);
      end;
// Limite de credito
      FTextRel.AddLinha(replicate('-',largura),false,false,true);
      xportadores:=GetPortadores( EdCodtipo.ResultFind.fieldbyname('clie_portadores').AsString );
      xportadores:=copy(xportadores+space(100),1,100);
      FTextRel.AddLinha('Limite Dispon�vel : '+FGeral.Formatavalor( FGeral.LimiteDisponivel(EdCodtipo.asinteger),f_cr)+
                        ' -  Portador(es) : '+copy(xportadores,1,50),
                        True,false,true);
      FTextRel.AddLinha('Limite Atual      : '+FGeral.Formatavalor( FCadCli.GetLimitecredito( EdCodtipo.asinteger ),f_cr)+
                        '                   '+copy(xportadores,51,50),
                        True,false,true);
      FTextRel.AddLinha(replicate('-',largura),true,false,true);

/////////////////////////////
      FTExtRel.Video;
/////////////////////////////    end;
    Sistema.EndProcess('');
    Freeandnil(Lista);
    ListaJaBaixadosBP.Free;
    Q.close;
    Freeandnil(Q);
  end;

end;


//////////////////////////////////////////////////////////////////////
procedure FRelGerenciais_Compras;   // 10
//////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    p,posicao:integer;
    tiposmovto,sqlunidadem,sqltipomovtom,unidade,tipomov,tipocad,datamovimento,transacao,sqldoc,
    innerchu,tituloproduto:string;
    totqtde,totvalor,valor,qtde,totqtdeg,totvalorg,valorabc,qtdeabc,vlripi,vlrfrete:currency;
    codigo,documento:integer;
    data,dataemissao,datacont:TDatetime;
begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(10) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');

// ver pedir se quer relat. sobre consigna��o, pronta entrega ou "outro esquema"
//    Tiposmov:=Global.CodVendaConsig+';'+Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig;
    if trim(EdUnid_codigo.text)<>'' then begin
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
//      sqlunidadem:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C')
    end else begin
      sqlunidade:='';
//      sqlunidadem='';
    end;
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else
      sqlcodtipo:=' and move_tipo_codigo='+EdCodtipo.assql;
//    if Global.Usuario.OutrosAcessos[0701] then
//      tiposmovto:=Global.CodCompra+';'+Global.CodConhecimento+';'+Global.CodCompra100+';'+global.CodCompraX
//    else begin
//      tiposmovto:=Global.CodCompra+';'+Global.CodConhecimento+';'+Global.CodCompra100;
//    end;
// 298.03.08
//   tiposmovto:=Global.TiposRelCompra;
// 24.10.09
   tiposmovto:=Global.TiposEntrada;
// 04.05.07
    tiposmovto:=tiposmovto+';'+Global.Codcompraprodutor;
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C');
      sqltipomovtom:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C');
      tiposmovto:=EdTipomov.text;
    end else begin
//      sqltipomovto:=' and '+FGeral.getin('move_tipomov',tiposmovto,'C');
//      sqltipomovtom:=' and '+FGeral.getin('move_tipomov',tiposmovto,'C');
// 14.12.13
      sqltipomovto:='';
      sqltipomovtom:='';
    end;
    if EdNumerodoc.AsInteger>0 then
      sqldoc:=' and move_numerodoc='+EdNumerodoc.assql
    else
      sqldoc:='';
    totvalor:=0;
    totqtde:=0;
    totvalorg:=0;
    totqtdeg:=0;
// 23.08.05
    if pos(global.codcompra,Edtipomov.text)>0 then
      innerchu:=' inner join movesto on ( moes_transacao=move_transacao )'
    else
      innerchu:=' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )';

// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);
// 24.10.09
    if not EdEsto_codigo.isempty then begin
      sqlproduto:=' and '+FGeral.getin('move_esto_codigo',EdEsto_codigo.text,'C');
      tituloproduto:=' - Produto :'+EdEsto_codigo.Text+' - '+FEstoque.GetDescricao(EdEsto_codigo.text)
   end  else begin
      sqlproduto:='';
      tituloproduto:='';
   end;
    if Edsinana.text='S' then begin
      Sistema.beginprocess('somando valores e quantidades');
      Q:=sqltoquery('select * from movestoque'+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlcodtipo+
                  sqlproduto+  // 24.10.09
                  sqldatacont+
                  ' and '+FGeral.GetNotin('move_status','C;X;Y','C')+
// 14.07.11 - 'integridade do banco' - vava - novicarnes
                  ' and '+FGeral.GetNotin('moes_status','C;X;Y','C')+
//                  ' and move_status<>''C'''+
                  ' order by moes_unid_codigo,moes_tipo_codigo,moes_datamvto,moes_numerodoc,moes_datacont' );
      if not Q.eof then begin
        while not Q.eof do begin
          codigo:=q.fieldbyname('move_tipo_codigo').asinteger;
          documento:=q.fieldbyname('moes_numerodoc').asinteger;
          data:=q.fieldbyname('move_datamvto').asdatetime;
          unidade:=q.fieldbyname('move_unid_codigo').asstring;
          valor:=0;
          while (not Q.eof) and (q.fieldbyname('move_unid_codigo').asstring=unidade) and
            (q.fieldbyname('move_tipo_codigo').asinteger=codigo) and
            (q.fieldbyname('move_datamvto').asdatetime=data) and
            (q.fieldbyname('moes_numerodoc').asinteger=documento) do begin
            totqtdeg:=totqtdeg+q.FieldByName('move_qtde').ascurrency;
            valor:=q.FieldByName('moes_vlrtotal').ascurrency;
            q.next;
          end;
          totvalorg:=totvalorg+valor;
        end;
        Q.Close;
        Freeandnil(Q);
        Q:=sqltoquery('select * from movestoque '+
//                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
// 23.08.05
                  innerchu+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  ' and substr(moes_natf_codigo,1,1) in (''1'',''2'')'+
                  sqlunidade+
                  sqltipomovto+
                  sqlcodtipo+
                  sqldoc+
                  sqlproduto+  // 24.10.09
                  ' and '+FGeral.GetNotin('move_status','C;X;Y','C')+
                  ' and '+FGeral.GetNOtin('moes_status','C;X;Y','C')+
//                  ' and move_status<>''C'''+
                  ' order by moes_unid_codigo,moes_tipo_codigo,moes_datamvto,moes_numerodoc,moes_datacont' );
      end;
      Sistema.endprocess('');

    end else begin  // analitico

      Q:=sqltoquery('select * from movestoque '+
//                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
//                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
// 23.08.05
                  innerchu+
                  ' left join transportadores on ( tran_codigo=moes_tran_codigo )'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' left join codigosipi on ( cipi_codigo=esto_cipi_codigo )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  ' and substr(moes_natf_codigo,1,1) in (''1'',''2'',''3'')'+
                  sqlunidade+
                  sqltipomovto+
                  sqldoc+
                  sqlcodtipo+
                  sqlproduto+  // 24.10.09
                  sqldatacont+
                  ' and '+FGeral.GetNotin('move_status','C;X;Y','C')+
// 14.07.11 - 'integridade do banco' - vava - novicarnes
                  ' and '+FGeral.GetNotin('moes_status','C;X;Y','C')+
//                  ' and move_status<>''C'''+   // 20.06.11
                  ' order by move_unid_codigo,move_tipo_codigo,move_datamvto,moes_numerodoc,move_esto_codigo' );
    end;

    if Q.Eof then

      Avisoerro('Nada encontrado para impress�o')

    else begin

      Sistema.BeginProcess('Gerando Relat�rio');
      if EdSinana.text='S' then begin
        frel.init('relcomprassintetico');
//        frel.addtit('Compras '+titulotipomov(tiposmovto));
        frel.addtit('Compras ');
        frel.addtit(fgeral.titulorelunidade(edunid_codigo.text)+tituloproduto);
        frel.addtit('Periodo : '+fgeral.formatadata(eddatai.asdate)+' a '+fgeral.formatadata(eddataf.asdate));
        frel.addcol( 90,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
        frel.addcol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
        frel.addcol( 40,0,'N','' ,''              ,'Cod.'            ,''         ,'',false);
        frel.addcol(120,0,'C','' ,''              ,'Fornecedor'      ,''         ,'',false);
        frel.addcol(120,0,'C','' ,''              ,'Tipo movimento'  ,''         ,'',false);
        frel.addcol( 80,0,'C','' ,''              ,'Documento'       ,''         ,'',false);
        frel.addcol( 70,1,'D','' ,''              ,'Emiss�o'          ,''         ,'',false);
        frel.addcol( 70,3,'D','' ,''              ,'Entrada'          ,''         ,'',false);
        frel.addcol( 70,3,'D','' ,''              ,'Movimento'        ,''         ,'',false);
        frel.addcol( 80,3,'N','+' ,''             ,'Qtde'             ,''         ,'',false);
        frel.addcol( 80,3,'N',''  ,''             ,'% Total qtde'     ,''         ,'',false);
        frel.addcol( 80,3,'N','+' ,''             ,'Valor total'      ,''         ,'',false);
        frel.addcol( 80,3,'N',''  ,''             ,'% Total valor'     ,''         ,'',false);
        while not q.eof do begin
          codigo:=q.fieldbyname('move_tipo_codigo').asinteger;
          tipocad:=q.fieldbyname('move_tipocad').asstring;
          documento:=q.fieldbyname('moes_numerodoc').asinteger;
          data:=q.fieldbyname('move_datamvto').asdatetime;
          dataemissao:=q.fieldbyname('moes_dataemissao').asdatetime;
          if q.fieldbyname('moes_datacont').asdatetime>1 then
            datamovimento:=datetostr(q.fieldbyname('moes_datacont').asdatetime)
          else
            datamovimento:=space(8);
          unidade:=q.fieldbyname('move_unid_codigo').asstring;
          tipomov:=q.fieldbyname('moes_tipomov').asstring;
          transacao:=q.fieldbyname('moes_transacao').asstring;
          valor:=0;totqtde:=0;
// 04.11.05
//          datacont:=q.fieldbyname('moes_datacont').asdatetime;
// 11.09.08
          datacont:=q.fieldbyname('move_datacont').asdatetime;
          while (not q.eof) and (q.fieldbyname('move_unid_codigo').asstring=unidade) and
            (q.fieldbyname('move_tipo_codigo').asinteger=codigo) and
            (q.fieldbyname('move_datamvto').asdatetime=data) and
            (q.fieldbyname('moes_numerodoc').asinteger=documento) and
            (q.fieldbyname('move_datacont').asdatetime=datacont) do begin
            totqtde:=totqtde+q.fieldbyname('move_qtde').asfloat;
            valor:=q.fieldbyname('moes_vlrtotal').ascurrency;
            q.next;
          end;
          frel.addcel(transacao);
          frel.addcel(unidade);
          frel.addcel(inttostr(codigo));
          FRel.AddCel(Fgeral.GetNomeRazaoSocialEntidade(codigo,tipocad,'N'));
//          frel.addcel(ffornece.getnome(codigo));
          frel.addcel(tipomov+'-'+fgeral.gettipomovto(tipomov));
          frel.addcel(inttostr(documento));
          frel.addcel(datetostr(dataemissao));
          frel.addcel(datetostr(data));
          frel.addcel(datamovimento);
//          frel.addcel(transform(totqtde,'#########'));
// 15.05.09
          frel.addcel(transform(totqtde,f_qtdestoque));

          if totqtdeg>0 then
            qtdeabc:=(totqtde/totqtdeg)*100
          else
            qtdeabc:=0;
          frel.addcel(transform(qtdeabc,f_cr));
          frel.addcel(transform(valor,f_cr));
          if totvalorg>0 then
            valorabc:=(valor/totvalorg)*100
          else
            valorabc:=0;
          frel.addcel(transform(valorabc,f_cr));
        end;

      end else begin   // analitico

        Sistema.BeginProcess('Gerando Relat�rio');
        frel.init('relcomprasanalitico');
        frel.addtit('Compras '+titulotipomov(tiposmovto));
        frel.addtit(fgeral.titulorelunidade(edunid_codigo.text)+tituloproduto);
        frel.addtit('Periodo : '+fgeral.formatadata(eddatai.asdate)+' a '+fgeral.formatadata(eddataf.asdate));
        frel.addcol( 90,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
        frel.addcol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
        frel.addcol( 40,0,'N','' ,''              ,'Cod.'            ,''         ,'',false);
        frel.addcol(120,0,'C','' ,''              ,'Fornecedor'      ,''         ,'',false);
        frel.addcol(060,0,'C','' ,''              ,'Cod. Mov.'     ,''         ,'',false);
        frel.addcol(120,0,'C','' ,''              ,'Tipo movimento'  ,''         ,'',false);
        frel.addcol( 80,0,'C','' ,''              ,'Documento'       ,''         ,'',false);
        frel.addcol( 70,1,'D','' ,''              ,'Emiss�o'          ,''         ,'',false);
        frel.addcol( 70,1,'D','' ,''              ,'Entrada'          ,''         ,'',false);
        frel.addcol( 70,3,'D','' ,''              ,'Movimento'        ,''         ,'',false);
        if Global.Topicos[1209] then
          FRel.AddCol( 80,1,'N','' ,''              ,'Ref.Ou Prod.'          ,''         ,'',False)
        else
          FRel.AddCol( 80,1,'N','' ,''              ,'Cod.Prod'        ,''         ,'',False);
// 24.06.08
        FRel.AddCol(100,0,'C','' ,'####.##.##'     ,'NCM'             ,''         ,'',False);
        FRel.AddCol(130,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
// 01.02.13
        FRel.AddCol(130,1,'C','' ,''              ,'Grupo'          ,''         ,'',False);
// 13.10.17
        FRel.AddCol(130,1,'C','' ,''              ,'Familia'          ,''         ,'',False);
        FRel.AddCol(100,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
        FRel.AddCol(100,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
//        FRel.AddCol(100,1,'C','' ,''              ,'Copa'             ,''         ,'',False);
        frel.addcol( 80,3,'N','+' ,''             ,'Qtde'             ,''         ,'',false);
        frel.addcol( 80,3,'N',''  ,''             ,'Unit�rio'         ,''         ,'',false);
        frel.addcol( 80,3,'N','+' ,''             ,'Valor total'          ,''         ,'',false);
        frel.addcol(080,1,'C',''  ,''             ,'Placa'          ,''         ,'',false);
        frel.addcol(100,1,'C',''  ,''             ,'Transportador'          ,''         ,'',false);
        frel.addcol( 80,3,'N','+' ,''             ,'Valor frete'          ,''         ,'',false);
        if Global.Topicos[1313] then
          frel.addcol( 80,3,'N','+' ,''             ,'Peso L�quido'          ,''         ,'',false);
        if Global.Topicos[1302] then
          frel.addcol( 80,3,'N','+' ,''             ,'Pe�as'          ,''         ,'',false);
// 25.06.08
        FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Ipi'        ,''         ,'',False);
//        FRel.AddCol( 80,3,'N','+' ,''             ,'Vlr Total+Ipi'   ,''         ,'',False);
// 04.04.16  - Novicarnes - Iso
        FRel.AddCol( 80,3,'N','+' ,''             ,'Vlr Total+Ipi+Frete' ,''         ,'',False);
        ListaRegistro:=TList.create;

        while not q.eof do begin
           FRel.AddCel(Q.fieldbyname('moes_transacao').asstring);
           FRel.AddCel(Q.fieldbyname('move_unid_codigo').asstring);
           FRel.AddCel(inttostr(Q.fieldbyname('move_tipo_codigo').asinteger));
           FRel.AddCel(Fgeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('move_tipo_codigo').asinteger,Q.fieldbyname('move_tipocad').asstring,'N'));
           FRel.AddCel(inttostr(Q.fieldbyname('moes_comv_codigo').asinteger));
           Frel.addcel(Q.fieldbyname('move_tipomov').asstring+'-'+fgeral.gettipomovto(Q.fieldbyname('move_tipomov').asstring));
           FRel.AddCel(Q.fieldbyname('move_numerodoc').asstring);
           FRel.AddCel(formatdatetime('dd/mm/yy',Q.fieldbyname('moes_dataemissao').asdatetime));
           FRel.AddCel(formatdatetime('dd/mm/yy',Q.fieldbyname('move_datamvto').asdatetime));
           FRel.AddCel(Q.fieldbyname('move_datacont').asstring);
//           FRel.AddCel(Q.fieldbyname('move_esto_codigo').asstring);
           FRel.AddCel( FEStoque.GetReferenciaouCodigo( Q.fieldbyname('move_esto_codigo').asstring) );
           FRel.AddCel(FEstoque.GetNCMipi(Q.fieldbyname('move_esto_codigo').asstring));
           FRel.AddCel(FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').asstring));
// 03.08.16
           if Q.fieldbyname('move_tipomov').asstring<>Global.CodTransfEntrada then begin
             FRel.AddCel(FGrupos.GetDescricao(strtoint(Q.fieldbyname('move_grup_codigo').asstring)));
             FRel.AddCel(FGrupos.GetDescricao(strtoint(Q.fieldbyname('move_fami_codigo').asstring)));
           end else begin
             FRel.AddCel(FGrupos.GetDescricao(( FEstoque.GetGrupo(Q.fieldbyname('move_esto_codigo').asstring ))));
             FRel.AddCel(FGrupos.GetDescricao(( FEstoque.GetFamilia(Q.fieldbyname('move_esto_codigo').asstring ))));
           end;
           Frel.addcel(strzero(Q.fieldbyname('move_tama_codigo').asinteger,3)+'-'+FTamanhos.getdescricao(Q.fieldbyname('move_tama_codigo').asinteger));
           Frel.addcel(strzero(Q.fieldbyname('move_core_codigo').asinteger,3)+'-'+Fcores.getdescricao(Q.fieldbyname('move_core_codigo').asinteger));
//           Frel.addcel(strzero(Q.fieldbyname('move_copa_codigo').asinteger,3)+'-'+Fcopas.getdescricao(Q.fieldbyname('move_copa_codigo').asinteger));
           FRel.AddCel(transform(Q.fieldbyname('move_qtde').asfloat,f_qtdestoque));
           FRel.AddCel(transform(Q.fieldbyname('move_venda').ascurrency,f_cr));
           FRel.AddCel(transform(Q.fieldbyname('move_qtde').asfloat*Q.fieldbyname('move_venda').ascurrency,f_cr));
           FRel.AddCel(Q.fieldbyname('tran_placa').asstring);
           FRel.AddCel(Q.fieldbyname('tran_nome').asstring);
// 16.01.12
           if not EstanaLista(Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('moes_transacao').asstring) then begin
             FRel.AddCel(transform(Q.fieldbyname('moes_frete').ascurrency,f_cr));
             vlrfrete:= Q.fieldbyname('moes_frete').ascurrency;
           end else begin
             FRel.AddCel('');
             vlrfrete:=0;
           end;
// 16.01.12
           PoeLista(Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('moes_transacao').asstring);
           if Global.Topicos[1313] then
             FRel.AddCel(transform(Q.fieldbyname('moes_pesoliq').ascurrency,f_cr));
           if Global.Topicos[1302] then
             FRel.AddCel(transform(Q.fieldbyname('move_pecas').ascurrency,f_cr));
// 25.06.08
           vlripi:=(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency) * (Q.fieldbyname('move_aliipi').ascurrency/100);
           FRel.AddCel(transform(vlripi,f_cr));
           FRel.AddCel(transform( (Q.fieldbyname('move_qtde').asfloat*Q.fieldbyname('move_venda').ascurrency) + vlripi + vlrfrete,f_cr));
           Q.next;
        end;

      end;
      FRel.Video;
    end;

    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
    ListaRegistro.free;
  end;

  FRelGerenciais_Compras;   // 10  - 24.10.09

end;


/////////////////////////////////////////////////////////
procedure FRelGerenciais_Vendas(xcliente:integer=0);              // 11
//////////////////////////////////////////////////////////
type Vendas=record
     Unid_codigo,esto_codigo,tipovenda,status,tran_nome,transacao,consfinal,cida_nome,
     grup_nome,tipocad:string;
     repr_codigo,clie_codigo,numerodoc,tamanho,cor,tran_codigo,cida_codigo:integer;
     qtdevenda,vlrvenda,qtdevendaprev,vlrvendaprev,unitario,freteuni,pecas,vlripi,vlricms,aliicms:currency;
     emissao,movimento,saida:TDatetime;
end;


var Q:TSqlquery;
    Lista:Tlist;
    PVendas : ^Vendas;
    p,posicao:integer;
    totqtde,totvalor,qtdeabc,valorabc,custouni:currency;

     function Procura(unidade:string;repre:integer;cliente,numero:integer;emissao:Tdatetime;tipomov:string;tamanho,cor:integer):integer;
     ///////////////////////////////////////////////////////////////////////////////////////////////
     var x:integer;
     begin
       result:=-1;
       for x:=0 to Lista.count-1 do begin
         PVendas:=Lista[x];
         if (PVendas.Unid_codigo=unidade) and (PVendas.repr_codigo=repre) and (PVendas.clie_codigo=cliente)
             and (PVendas.numerodoc=numero) and (PVendas.emissao=emissao) and (PVendas.tipovenda=tipomov) then begin
//             and (PVendas.tamanho=tamanho) and (PVendas.cor=cor) then begin
            result:=x;
            break;
         end;
       end;
     end;

     procedure Atualiza(qtde,xpecas,unitario:currency;posicao:integer);
     ///////////////////////////////////////////////////////////////////////
     begin
       PVendas:=Lista[posicao];
//       if Q.fieldbyname('move_datacont').asdatetime<1 then begin
       if Q.fieldbyname('moes_datacont').asdatetime>1 then begin
         PVendas.qtdevenda:=PVendas.qtdevenda+qtde;
         PVendas.vlrvenda:=PVendas.vlrvenda+(qtde*unitario);
       end else begin
         PVendas.qtdevendaprev:=PVendas.qtdevendaprev+qtde;
         PVendas.vlrvendaprev:=PVendas.vlrvendaprev+(qtde*unitario);
       end;
       PVendas.pecas:=PVendas.pecas+xpecas;
     end;


var tiposmovto,sqlgrupo,sqlperiodo,sqlperiodo1:string;

begin
////////////////////////////////////////////

  with FRelGerenciais do begin
    dcliente:=xcliente;
    if not FRelGerenciais_Execute(11) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');

    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
//    tiposmovto:=Global.CodVendaConsig+';'+Global.CodVendaDireta+';'+Global.CodVendaProntaEntrega+';'+global.CodVendaMagazine+';'+
//                Global.CodVendaInternet+';'+;
    tiposmovto:=Global.TiposRelVenda;
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C');
      tiposmovto:=EdTipomov.text;
    end else
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',tiposmovto,'C');

    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and move_tipo_codigo='+EdCodtipo.assql;
      if Edtipocad.text='R' then  // 02.05.05
        sqlcodtipo:=' and move_repr_codigo='+EdCodtipo.assql;
    end;

    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);

    if trim(FGeral.getconfig1asstring('Grupojoias'))<>'' then
      sqlgrupo:=' and '+FGeral.GetNotin('esto_grup_codigo',FGeral.getconfig1asstring('Grupojoias'),'N')
    else
      sqlgrupo:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);
// 18.08.11
    sqlperiodo:=' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql;
    sqlperiodo1 :=' and move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql;
    if ( pos( Global.CodRomaneioRemessaaOrdem,EdTipomov.text) > 0 ) or ( Global.Usuario.OutrosAcessos[0348] )  then begin

      sqlperiodo  :=' where moes_datasaida>='+EdDatai.AsSql+' and moes_datasaida<='+EdDataf.AsSql;
      sqlperiodo1 :=' and moes_datasaida>='+EdDatai.AsSql+' and moes_datasaida<='+EdDataf.AsSql;

    end;

    if EdSinana.text='S' then

       Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' left join transportadores on ( tran_codigo=moes_tran_codigo )'+
                  ' where '+FGeral.GetNotin('move_status','C;X;Y','C')+
                  sqlunidade+
                  sqlcodtipo+
                  sqltipomovto+
                  sqlgrupo+
                  sqldatacont+
                  sqlperiodo1+
                  ' and '+FGeral.GetNotin('moes_status','C;X;Y','C')+
//                  ' and '+FGeral.Getin('move_status','N;E','C')+
                  ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_datamvto,move_numerodoc' )
    else
       Q:=sqltoquery('select movestoque.*,clie_consfinal,movesto.*,tran_nome,cida_nome,grup_descricao from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' left join clientes on ( clie_codigo=move_tipo_codigo )'+
                  ' left join transportadores on ( tran_codigo=moes_tran_codigo )'+
// 08.04.10 - Seab - Novi - Elize
                  ' left join cidades on ( cida_codigo=moes_cida_codigo )'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' left join codigosipi on ( cipi_codigo=esto_cipi_codigo )'+
// 08.04.10 - Seab - Novi - Elize
//                  ' left join grupos on ( grup_codigo=esto_grup_codigo )'+
// 15.06.19
                  ' inner join grupos on ( grup_codigo=esto_grup_codigo )'+
                  sqlperiodo+
//                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqlcodtipo+
                  sqldatacont+
                  sqltipomovto+
//                  ' and '+FGeral.Getin('move_status','N;E','C')+
//                  ' and move_status<>''C'''+  // 23.09.05
                  ' and '+FGeral.GetNotin('move_status','C;X;Y','C')+
// 23.01.14
                  ' and '+FGeral.GetNotin('moes_status','C;X;Y','C')+
                  ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_datamvto,move_numerodoc' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      Lista:=Tlist.create;
      Sistema.beginprocess('Somando quantidade e valor vendido');
      totqtde:=0;totvalor:=0;

      while not Q.eof do begin

        if Edsinana.text='S' then
           posicao:=Procura(Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_repr_codigo').asinteger,
                   Q.fieldbyname('move_tipo_codigo').asinteger,Q.fieldbyname('move_numerodoc').asinteger,Q.fieldbyname('moes_dataemissao').asdatetime,
                   Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_tama_codigo').asinteger,
                   Q.fieldbyname('move_core_codigo').asinteger);

        if (posicao<0) or (EdSinana.text='A') then begin
          New(PVendas);
          PVendas.Transacao:=Q.fieldbyname('moes_transacao').asstring;
          PVendas.Unid_codigo:=Q.fieldbyname('move_unid_codigo').asstring;
          PVendas.repr_codigo:=Q.fieldbyname('move_repr_codigo').asinteger;
          PVendas.clie_codigo:=Q.fieldbyname('move_tipo_codigo').asinteger;
          PVendas.tipocad:=Q.fieldbyname('moes_tipocad').asstring;
          PVendas.esto_codigo:=Q.fieldbyname('move_esto_codigo').asstring;
          PVendas.tipovenda:=Q.fieldbyname('move_tipomov').asstring;
          PVendas.numerodoc:=Q.fieldbyname('move_numerodoc').asinteger;
          PVendas.emissao:=Q.fieldbyname('moes_dataemissao').asdatetime;
// 18.08.11
          PVendas.saida:=Q.fieldbyname('moes_datasaida').asdatetime;
          Pvendas.tamanho:=Q.fieldbyname('move_tama_codigo').asinteger;
          PVendas.cor:=Q.fieldbyname('move_core_codigo').asinteger;
          PVendas.status:=Q.fieldbyname('move_status').asstring;
          PVendas.movimento:=Q.fieldbyname('moes_datacont').asdatetime;
          PVendas.freteuni:=Q.fieldbyname('moes_freteuni').ascurrency;
          PVendas.tran_codigo:=strtointdef(Q.fieldbyname('moes_tran_codigo').asstring,0);
          PVendas.tran_nome:=Q.fieldbyname('tran_nome').asstring;
          PVendas.cida_codigo:=Q.fieldbyname('moes_cida_codigo').asinteger;
//  15.07.10 - somente pro analitico--no sintetico da erro - Abra - Paulo pegou
          if Edsinana.text<>'S' then begin
            PVendas.cida_nome:=Q.fieldbyname('cida_nome').asstring;
            PVendas.grup_nome:=Q.fieldbyname('grup_descricao').asstring;
          end else begin
            PVendas.cida_nome:='';
            PVendas.grup_nome:='';
          end;
          PVendas.vlripi:=0;
          PVendas.vlricms:=0;
          PVendas.aliicms:=0;
          if EdSinana.text='S' then begin
// 26.11.09
            PVendas.consfinal:='';
            if Q.fieldbyname('move_datacont').asdatetime<1 then begin
              PVendas.qtdevenda:=Q.fieldbyname('move_qtde').asfloat;
              PVendas.vlrvenda:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency;
              PVendas.qtdevendaprev:=0;
              PVendas.vlrvendaprev:=0;
            end else begin
              PVendas.qtdevendaprev:=Q.fieldbyname('move_qtde').asfloat;
              PVendas.vlrvendaprev:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency;
              PVendas.qtdevenda:=0;
              PVendas.vlrvenda:=0;
            end;
            PVendas.pecas:=Q.fieldbyname('move_pecas').ascurrency;
          end else begin   // analitico
// 26.11.09
              PVendas.consfinal:=Q.fieldbyname('clie_consfinal').asstring;;
              PVendas.qtdevenda:=Q.fieldbyname('move_qtde').asfloat;
              PVendas.vlrvenda:=Q.fieldbyname('move_qtde').asfloat*Q.fieldbyname('move_venda').ascurrency;
              PVendas.unitario:=Q.fieldbyname('move_venda').ascurrency;
              PVendas.qtdevendaprev:=0;
              PVendas.vlrvendaprev:=0;
              PVendas.pecas:=Q.fieldbyname('move_pecas').ascurrency;
// 25.06.08
              PVendas.vlripi:=PVendas.vlrvenda  * (Q.fieldbyname('move_aliipi').ascurrency/100);
// 25.09.09
              PVendas.vlricms:=PVendas.vlrvenda  * (Q.fieldbyname('move_aliicms').ascurrency/100);
              PVendas.aliicms:=Q.fieldbyname('move_aliicms').ascurrency;
          end;
          Lista.Add(PVendas);
        end else
           Atualiza(Q.fieldbyname('move_qtde').asfloat,Q.fieldbyname('move_pecas').ascurrency,Q.fieldbyname('move_venda').ascurrency,posicao);
        Q.Next;
      end;
      Sistema.beginprocess('Gerando relat�rio');

      if (EdSinana.text='S') then begin   // sintetico

        FRel.Init('RelVendasSin');
        FRel.AddTit('Relat�rio de Vendas Sint�tico '+TituloTipoMov(tiposmovto));
        FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
        FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
        FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
        FRel.AddCol( 45,3,'N','' ,''              ,'Codigo'          ,''         ,'',false);
        FRel.AddCol(120,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
        FRel.AddCol( 40,0,'C','' ,''              ,'Cod.'            ,''         ,'',False);
        FRel.AddCol(120,0,'C','' ,''              ,'Cliente'         ,''         ,'',False);
        FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
        FRel.AddCol(100,1,'C','' ,''              ,'Cidade'          ,''         ,'',False);
        FRel.AddCol( 40,1,'C','' ,''              ,'Estado'          ,''         ,'',False);
        FRel.AddCol( 80,3,'N','' ,''              ,'Popula��o'       ,''         ,'',False);
        FRel.AddCol( 80,1,'N','' ,''              ,'Documento'       ,''         ,'',False);
        if ( pos( Global.CodRomaneioRemessaaOrdem,EdTipomov.text) > 0 ) or ( Global.Usuario.OutrosAcessos[0348] )  then
           FRel.AddCol( 50,1,'D','' ,''              ,'Saida'         ,''         ,'',False)
        else
           FRel.AddCol( 50,1,'D','' ,''              ,'Emiss�o'         ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde'             ,''         ,'',False);
        FRel.AddCol( 80,3,'N',''  ,''             ,'% Total Qtde'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Total'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N',''  ,''             ,'% Total Valor'     ,''         ,'',False);

        for p:=0 to Lista.count-1 do begin

          PVendas:=Lista[p];
          if not Global.Usuario.OutrosAcessos[0010] then begin
            totvalor:=totvalor+PVendas.vlrvenda;
            totqtde:=totqtde+PVendas.qtdevenda;
          end else begin
            totqtde:=totqtde+PVendas.qtdevenda+PVendas.qtdevendaprev;
            totvalor:=totvalor+PVendas.vlrvenda+PVendas.vlrvendaprev;
          end;
        end;

        for p:=0 to Lista.count-1 do begin
          PVendas:=Lista[p];
          FRel.AddCel(PVendas.Unid_codigo);
          FRel.AddCel(inttostr(PVendas.repr_codigo));
          FRel.AddCel(FRepresentantes.GetDescricao(PVendas.repr_codigo));
          FRel.AddCel(inttostr(PVendas.clie_codigo));
//          FRel.AddCel(FCadcli.GetNome(PVendas.clie_codigo));
// 26.10.11 - Novi - Iso -> vava
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(PVendas.clie_codigo,PVendas.tipocad,'N'));

          FRel.AddCel(PVendas.tipovenda+'-'+FGeral.GetTipoMovto(PVendas.tipovenda));
          FRel.AddCel(FCadcli.GetCidade(PVendas.clie_codigo));
          FRel.AddCel(FCadcli.GetUf(PVendas.clie_codigo));
          FRel.AddCel(inttostr(FCadcli.GetPopulacao(PVendas.clie_codigo)));
          FRel.AddCel(inttostr(PVendas.numerodoc));
          if ( pos( Global.CodRomaneioRemessaaOrdem,EdTipomov.text) > 0 ) or ( Global.Usuario.OutrosAcessos[0348] )  then
            FRel.AddCel(datetostr(PVendas.saida))
          else
            FRel.AddCel(datetostr(PVendas.emissao));

          if not Global.Usuario.OutrosAcessos[0010] then begin
            FRel.AddCel(transform(PVendas.qtdevenda,f_qtdestoque));
            if totqtde>0 then
              qtdeabc:=(Pvendas.qtdevenda/totqtde)*100
            else
              qtdeabc:=0;
            FRel.AddCel(transform(qtdeabc,f_cr));
            FRel.AddCel(transform(PVendas.vlrvenda,f_cr));
// 26.10.11 - faltava o Abc em valor no sintetivo com usuario 'sem acesso'
            if totvalor>0 then
              valorabc:=((Pvendas.vlrvenda)/totvalor)*100
            else
              valorabc:=0;
            FRel.AddCel(transform(valorabc,f_cr));
          end else begin
            FRel.AddCel(transform(PVendas.qtdevenda+PVendas.qtdevendaprev,f_qtdestoque));
            if totqtde>0 then
              qtdeabc:=((Pvendas.qtdevenda+PVendas.qtdevendaprev)/totqtde)*100
            else
              qtdeabc:=0;
            FRel.AddCel(transform(qtdeabc,f_cr));
            FRel.AddCel(transform(PVendas.vlrvenda+PVendas.vlrvendaprev,f_cr));
            if totvalor>0 then
              valorabc:=((Pvendas.vlrvenda+PVendas.vlrvendaprev)/totvalor)*100
            else
              valorabc:=0;
            FRel.AddCel(transform(valorabc,f_cr));
          end;
        end;

      end else begin   // analitico

        FRel.Init('RelVendasAna');
        FRel.AddTit('Relat�rio de Vendas Anal�tico '+TituloTipoMov(tiposmovto));
        FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
        if pos( Global.CodRomaneioRemessaaOrdem,EdTipomov.text) > 0 then
          FRel.AddTit('Periodo pela Data de SAIDA : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate))
        else
          FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
        FRel.AddCol( 90,1,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
        FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
        FRel.AddCol( 45,3,'N','' ,''              ,'Cod.Cid.'          ,''         ,'',false);
        FRel.AddCol(120,1,'C','' ,''              ,'Cidade'   ,''         ,'',false);
        FRel.AddCol( 45,3,'N','' ,''              ,'Codigo'          ,''         ,'',false);
        FRel.AddCol(120,1,'C','' ,''              ,'Transportador'   ,''         ,'',false);
        FRel.AddCol( 60,0,'C','' ,''              ,'Cons.Final'            ,''         ,'',False);
        FRel.AddCol( 40,0,'C','' ,''              ,'Cod.'            ,''         ,'',False);
        FRel.AddCol(120,0,'C','' ,''              ,'Cliente'         ,''         ,'',False);
// 06.11.16
        FRel.AddCol(120,0,'C','' ,''              ,'CPF'             ,''         ,'',False);
        FRel.AddCol( 40,0,'C','' ,''              ,'Cod.Repr.'         ,''         ,'',False);
        FRel.AddCol(100,0,'C','' ,''              ,'Representante'     ,''         ,'',False);
        FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
        FRel.AddCol( 80,1,'N','' ,''              ,'Documento'       ,''         ,'',False);
        FRel.AddCol( 60,1,'C','' ,''              ,'Status'          ,''         ,'',False);
        if pos( Global.CodRomaneioRemessaaOrdem,EdTipomov.text) > 0 then
          FRel.AddCol( 50,1,'D','' ,''              ,'Saida'       ,''         ,'',False)
        else
          FRel.AddCol( 50,1,'D','' ,''              ,'Emiss�o'         ,''         ,'',False);
        FRel.AddCol( 50,1,'D','' ,''              ,'Movimento'       ,''         ,'',False);
        FRel.AddCol( 70,1,'C','' ,''              ,'Grupo'          ,''         ,'',False);
// 18.02.16
        FRel.AddCol( 70,1,'C','' ,''              ,'SubGrupo'          ,''         ,'',False);
        FRel.AddCol( 80,0,'N','' ,''              ,'Cod.Prod'        ,''         ,'',False);
// 24.06.08
        FRel.AddCol(100,0,'C','' ,'####.##.##'     ,'NCM'             ,''         ,'',False);
        FRel.AddCol(120,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
        FRel.AddCol(060,1,'C','' ,''              ,'Unidade'          ,''         ,'',False);
        FRel.AddCol(100,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
        FRel.AddCol(100,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
        FRel.AddCol( 70,3,'N','+' ,''             ,'Qtde'             ,''         ,'',False);
        FRel.AddCol( 70,3,'N','+' ,''             ,'Pe�as'             ,''         ,'',False);
        FRel.AddCol( 60,3,'N','&'  ,''             ,'Unit�rio'         ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Total'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Frete Unit�rio'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Frete Total'     ,''         ,'',False);
// 25.06.08
        FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Ipi'        ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Vlr Total+Ipi'   ,''         ,'',False);
// 25.09.09 - Clessi
        FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Icms'        ,''         ,'',False);
        FRel.AddCol( 50,3,'N','+' ,''             ,'% Icms'     ,''         ,'',False);

        for p:=0 to Lista.count-1 do begin
          PVendas:=Lista[p];
          FRel.AddCel(PVendas.Transacao);
          FRel.AddCel(PVendas.Unid_codigo);
//          FRel.AddCel(inttostr(PVendas.repr_codigo));
//          FRel.AddCel(FRepresentantes.GetDescricao(PVendas.repr_codigo));
          FRel.AddCel(inttostr(PVendas.cida_codigo));
          FRel.AddCel(PVendas.cida_nome);
          FRel.AddCel(inttostr(PVendas.tran_codigo));
          FRel.AddCel(PVendas.tran_nome);
          FRel.AddCel(PVendas.consfinal);
          FRel.AddCel(inttostr(PVendas.clie_codigo));
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(PVendas.clie_codigo,'C','N'));
// 26.10.11 - Novi - Iso -> vava
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(PVendas.clie_codigo,PVendas.tipocad,'N'));
// 06.11.16
          FRel.AddCel(FCadCli.GetCnpjCpf(PVendas.clie_codigo,'S'));
// 20.08.09 - arrumado em 25.09.09
          FRel.AddCel(inttostr(PVendas.repr_codigo));
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(PVendas.repr_codigo,'R','N'));

          FRel.AddCel(PVendas.tipovenda+'-'+FGeral.GetTipoMovto(PVendas.tipovenda));
          FRel.AddCel(inttostr(PVendas.numerodoc));
          FRel.AddCel( PVendas.status );
          if ( pos( Global.CodRomaneioRemessaaOrdem,EdTipomov.text) > 0 ) or ( Global.Usuario.OutrosAcessos[0348] )  then
            FRel.AddCel(datetostr(PVendas.Saida))
          else
            FRel.AddCel(datetostr(PVendas.emissao));
          if PVendas.movimento>1 then
            FRel.AddCel(datetostr(PVendas.movimento))
          else
            FRel.AddCel('');
          FRel.AddCel(PVendas.grup_nome);
// 18.02.16
          FRel.AddCel(FSubgrupos.GetDescricao( FEstoque.GetSubGrupo( PVendas.esto_codigo ) ));
          FRel.AddCel(PVendas.esto_codigo);
          FRel.AddCel(FEstoque.GetNCMipi(PVendas.esto_codigo) );
          FRel.AddCel(FEstoque.GetDescricao(PVendas.esto_codigo));
          FRel.AddCel(FEstoque.GetUnidade(PVendas.esto_codigo));
          Frel.addcel(strzero(PVendas.tamanho,3)+'-'+FTamanhos.getdescricao(PVendas.tamanho));
          Frel.addcel(strzero(PVendas.cor,3)+'-'+Fcores.getdescricao(PVendas.cor));
          FRel.AddCel(transform(PVendas.qtdevenda,f_qtdestoque));
          FRel.AddCel(transform(PVendas.pecas,f_qtdestoque));
          FRel.AddCel(transform(PVendas.unitario,f_cr));
          FRel.AddCel(transform(PVendas.vlrvenda,f_cr));
          custouni:=FEstoque.Getcusto(PVendas.esto_codigo,global.unidadematriz,'medioger');
//          FRel.AddCel(transform(custouni,f_cr));
//          FRel.AddCel(transform(custouni*PVendas.qtdevenda,f_cr));
          FRel.AddCel(transform(PVendas.freteuni,f_cr));
          FRel.AddCel(transform(PVendas.freteuni*PVendas.qtdevenda,f_cr));
// 25.06.08
          FRel.AddCel(transform(PVendas.vlripi,f_cr));
          FRel.AddCel(transform(PVendas.vlripi+PVendas.vlrvenda,f_cr));
// 25.09.09 - Clessi
          FRel.AddCel(transform(PVendas.vlricms,f_cr));
          FRel.AddCel(transform(PVendas.aliicms,f_cr));
        end;

      end;
      if ( pos( Global.CodRomaneioRemessaaOrdem,EdTipomov.text) > 0 ) or ( Global.Usuario.OutrosAcessos[0348] )  then
        FRel.setsort('Saida')
      else
        FRel.setsort('Emiss�o');
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Freeandnil(Lista);
    Q.close;
    Freeandnil(Q);
    FRelGerenciais_Vendas;              // 11   - 30.12.05
    
  end;


end;

// 14.01.20
procedure FRelGerenciais_ConfAcrescimos;       // 41
/////////////////////////////////////////////////////////
type Vendas=record
     Unid_codigo,esto_codigo,tipovenda,descnota:string;
     repr_codigo,clie_codigo,numerodoc,tamanho,cor:integer;
     qtdevenda,vlrvenda,qtdevendaprev,vlrvendaprev,unitario,vlrdescnota,vlrdescitem,unitariobru,valordesc:currency;
     emissao:TDatetime;
end;

var Q:TSqlquery;
    Lista:Tlist;
    PVendas : ^Vendas;
    p,posicao:integer;
    totqtde,totvalor,qtdeabc,valorabc,Valormaisdesconto:currency;
    ListaDoc:TStringlist;

var tiposmovto:string;

begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(41) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');

    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    tiposmovto:=Global.CodVendaConsig+';'+Global.CodVendaDireta+';'+Global.CodVendaProntaEntrega+';'+global.CodVendaMagazine+';'+';'+Global.CodVendaInterna;
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C');
      tiposmovto:=EdTipomov.text;
    end else
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',tiposmovto,'C');
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else
      sqlcodtipo:=' and move_tipo_codigo='+EdCodtipo.assql;
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);
    Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqlcodtipo+
                  sqldatacont+
                  sqltipomovto+
                  ' and move_status=''N'''+
                  ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_datamvto,move_numerodoc' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      Lista:=Tlist.create;
      Listadoc:=TStringlist.create;
      Sistema.beginprocess('Gerando relat�rio SOMENTE DAS NOTAS COM ACR�SCIMO NO TOTAL');
      totqtde:=0;totvalor:=0;
      while not Q.eof do begin

        if (q.fieldbyname('Moes_Peracres').ascurrency>0)  then begin

          New(PVendas);
          PVendas.Unid_codigo:=Q.fieldbyname('move_unid_codigo').asstring;
          PVendas.repr_codigo:=Q.fieldbyname('move_repr_codigo').asinteger;
          PVendas.clie_codigo:=Q.fieldbyname('move_tipo_codigo').asinteger;
          PVendas.esto_codigo:=Q.fieldbyname('move_esto_codigo').asstring;
          PVendas.tipovenda:=Q.fieldbyname('move_tipomov').asstring;
          PVendas.numerodoc:=Q.fieldbyname('move_numerodoc').asinteger;
          PVendas.emissao:=Q.fieldbyname('moes_dataemissao').asdatetime;
          PVendas.qtdevenda:=Q.fieldbyname('move_qtde').ascurrency;
          PVendas.vlrvenda:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency;
          PVendas.unitario:=Q.fieldbyname('move_venda').ascurrency;
          PVendas.unitariobru:=Q.fieldbyname('move_vendabru').ascurrency;
          PVendas.qtdevendaprev:=0;
          PVendas.vlrvendaprev:=0;
          Pvendas.tamanho:=Q.fieldbyname('move_tama_codigo').asinteger;
          PVendas.cor:=Q.fieldbyname('move_core_codigo').asinteger;
//          Pvendas.vlrdescnota:=q.fieldbyname('moes_perdesco').ascurrency;
// 20.05.05
          Pvendas.vlrdescnota:=q.fieldbyname('Moes_Peracres').ascurrency;
          if pvendas.vlrdescnota>0 then begin
            Valormaisdesconto:=Q.FieldByName('moes_vlrtotal').Ascurrency ;
            PVendas.valordesc:=Valormaisdesconto-Q.FieldByName('moes_totprod').Ascurrency;

          end else

            PVendas.valordesc:=0;

          PVendas.vlrdescitem:=(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency)
                                *(q.fieldbyname('moes_peracres').ascurrency/100);
          if (q.fieldbyname('moes_peracres').ascurrency>0) then begin
            PVendas.descnota:='A';
            if Q.fieldbyname('moes_tipomov').asstring=Global.CodVendaConsig then
              PVendas.descnota:='N';
          end else if (q.fieldbyname('moes_peracres').ascurrency>0) then
            PVendas.descnota:='N'
          else
            PVendas.descnota:='I';
          Lista.Add(PVendas);
        end;

        Q.Next;

      end;

      if Lista.count>0 then begin

        Sistema.beginprocess('Gerando relat�rio');
        FRel.Init('RelConfAcrescimos');
        FRel.AddTit('Relat�rio de Confer�ncia de Acr�scimos nas Vendas '+TituloTipoMov(tiposmovto));
        FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
        FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
        FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
        FRel.AddCol( 45,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
        FRel.AddCol(100,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
        FRel.AddCol( 40,0,'C','' ,''              ,'Cod.'            ,''         ,'',False);
        FRel.AddCol(120,0,'C','' ,''              ,'Cliente'         ,''         ,'',False);
        FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
        FRel.AddCol( 80,1,'N','' ,''              ,'Documento'       ,''         ,'',False);
        FRel.AddCol( 80,0,'N','' ,''              ,'Cod.Prod'        ,''         ,'',False);
        FRel.AddCol(120,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
//        FRel.AddCol(080,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
//        FRel.AddCol(080,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
        FRel.AddCol( 70,3,'N','+' ,''             ,'Qtde'             ,''         ,'',False);
        FRel.AddCol( 80,3,'N',''  ,''             ,'Uni.Bruto'        ,''         ,'',False);
        FRel.AddCol( 80,3,'N',''  ,''             ,'Uni.L�quido'      ,''         ,'',False);
        FRel.AddCol( 70,3,'N','' ,''              ,'Acres. Nota(%)'      ,''         ,'',False);
//        FRel.AddCol( 70,3,'N','' ,''              ,'Desc. Item(%)'      ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Acr�scimo'     ,''         ,'',False);
        FRel.AddCol( 90,3,'N','+' ,''             ,'Valor por Produto'     ,''         ,'',False);

        for p:=0 to Lista.count-1 do begin

          PVendas:=Lista[p];
//          if Listadoc.indexof(inttostr(PVendas.numerodoc))=-1 then begin
            FRel.AddCel(PVendas.Unid_codigo);
            FRel.AddCel(inttostr(PVendas.repr_codigo));
            FRel.AddCel(FRepresentantes.GetDescricao(PVendas.repr_codigo));
            FRel.AddCel(inttostr(PVendas.clie_codigo));
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(PVendas.clie_codigo,'C','N'));
            FRel.AddCel(PVendas.tipovenda+'-'+FGeral.GetTipoMovto(PVendas.tipovenda));
            FRel.AddCel(inttostr(PVendas.numerodoc));
            FRel.AddCel(PVendas.esto_codigo);
            FRel.AddCel(FEstoque.GetDescricao(PVendas.esto_codigo));
//            Frel.addcel(strzero(PVendas.tamanho,3)+'-'+FTamanhos.getdescricao(PVendas.tamanho));
//            Frel.addcel(strzero(PVendas.cor,3)+'-'+Fcores.getdescricao(PVendas.cor));
            FRel.AddCel(transform(PVendas.qtdevenda,f_qtdestoque));
            FRel.AddCel(transform(PVendas.unitariobru,f_cr));
            FRel.AddCel(transform(PVendas.unitario,f_cr));

            if (Pvendas.descnota='N')  then begin
              FRel.AddCel(transform(PVendas.vlrdescnota,f_cr));
//              FRel.AddCel('');
            end;
            if (Pvendas.descnota='I') then begin
              FRel.AddCel('');
//              FRel.AddCel(transform(PVendas.vlrdescitem,f_cr));
            end;
            if (Pvendas.descnota='A') then begin
              FRel.AddCel(transform(PVendas.vlrdescnota,f_cr));
//              FRel.AddCel(transform(PVendas.vlrdescitem,f_cr));
            end;

            FRel.AddCel( transform( PVendas.vlrvenda*(PVendas.vlrdescnota/100) ,f_cr) );
            FRel.AddCel(transform(PVendas.vlrvenda,f_cr));
            Listadoc.add(inttostr(PVendas.numerodoc));
//          end;
        end;
        FRel.Video;
      end else Aviso('N�o encontrado acr�scimos no per�odo');

    end;
    Sistema.EndProcess('');
    Freeandnil(Lista);
    Q.close;
    Freeandnil(Q);

  end;


end;

procedure FRelGerenciais_ConfDescontos;       // 12
////////////////////////////////////////////////////////////
type Vendas=record
     Unid_codigo,esto_codigo,tipovenda,descnota:string;
     repr_codigo,clie_codigo,numerodoc,tamanho,cor:integer;
     qtdevenda,vlrvenda,qtdevendaprev,vlrvendaprev,unitario,vlrdescnota,vlrdescitem,unitariobru,valordesc:currency;
     emissao:TDatetime;
end;

var Q:TSqlquery;
    Lista:Tlist;
    PVendas : ^Vendas;
    p,posicao:integer;
    totqtde,totvalor,qtdeabc,valorabc,Valormaisdesconto:currency;
    ListaDoc:TStringlist;

var tiposmovto:string;
begin

  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(12) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');

    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    tiposmovto:=Global.CodVendaConsig+';'+Global.CodVendaDireta+';'+Global.CodVendaProntaEntrega+';'+global.CodVendaMagazine+';'+';'+Global.CodVendaInterna;
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C');
      tiposmovto:=EdTipomov.text;
    end else
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',tiposmovto,'C');
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else
      sqlcodtipo:=' and move_tipo_codigo='+EdCodtipo.assql;
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);
    Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqlcodtipo+
                  sqldatacont+
                  sqltipomovto+
                  ' and move_status=''N'''+
                  ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_datamvto,move_numerodoc' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      Lista:=Tlist.create;
      Listadoc:=TStringlist.create;
      Sistema.beginprocess('Gerando relat�rio SOMENTE DAS NOTAS COM DESCONTO NO TOTAL');
      totqtde:=0;totvalor:=0;
      while not Q.eof do begin
//        if (q.fieldbyname('moes_perdesco').ascurrency>0) or (q.fieldbyname('move_perdesco').ascurrency>0) then begin

        if (q.fieldbyname('moes_perdesco').ascurrency>0)  then begin

          New(PVendas);
          PVendas.Unid_codigo:=Q.fieldbyname('move_unid_codigo').asstring;
          PVendas.repr_codigo:=Q.fieldbyname('move_repr_codigo').asinteger;
          PVendas.clie_codigo:=Q.fieldbyname('move_tipo_codigo').asinteger;
          PVendas.esto_codigo:=Q.fieldbyname('move_esto_codigo').asstring;
          PVendas.tipovenda:=Q.fieldbyname('move_tipomov').asstring;
          PVendas.numerodoc:=Q.fieldbyname('move_numerodoc').asinteger;
          PVendas.emissao:=Q.fieldbyname('moes_dataemissao').asdatetime;
          PVendas.qtdevenda:=Q.fieldbyname('move_qtde').ascurrency;
          PVendas.vlrvenda:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency;
          PVendas.unitario:=Q.fieldbyname('move_venda').ascurrency;
          PVendas.unitariobru:=Q.fieldbyname('move_vendabru').ascurrency;
          PVendas.qtdevendaprev:=0;
          PVendas.vlrvendaprev:=0;
          Pvendas.tamanho:=Q.fieldbyname('move_tama_codigo').asinteger;
          PVendas.cor:=Q.fieldbyname('move_core_codigo').asinteger;
//          Pvendas.vlrdescnota:=q.fieldbyname('moes_perdesco').ascurrency;
// 20.05.05
          Pvendas.vlrdescnota:=q.fieldbyname('moes_perdesco').ascurrency;
          if pvendas.vlrdescnota>0 then begin
//            Valormaisdesconto:=(Q.FieldByName('moes_totprod').Ascurrency)/(1-(Q.fieldbyname('Moes_perdesco').ascurrency/100));
// 01.02.19
            Valormaisdesconto:=(Q.FieldByName('moes_totprod').Ascurrency)/(Q.fieldbyname('Moes_perdesco').ascurrency/100) ;
            PVendas.valordesc:=Valormaisdesconto-Q.FieldByName('moes_totprod').Ascurrency;

          end else

            PVendas.valordesc:=0;

          PVendas.vlrdescitem:=q.fieldbyname('move_perdesco').ascurrency;
          if (q.fieldbyname('moes_perdesco').ascurrency>0) and (q.fieldbyname('move_perdesco').ascurrency>0) then begin
            PVendas.descnota:='A';
            if Q.fieldbyname('moes_tipomov').asstring=Global.CodVendaConsig then
              PVendas.descnota:='N';
          end else if (q.fieldbyname('moes_perdesco').ascurrency>0) then
            PVendas.descnota:='N'
          else
            PVendas.descnota:='I';
          Lista.Add(PVendas);
        end;

        Q.Next;

      end;

      if Lista.count>0 then begin

        Sistema.beginprocess('Gerando relat�rio');
        FRel.Init('RelConfDescontos');
        FRel.AddTit('Relat�rio de Confer�ncia de Descontos nas Vendas '+TituloTipoMov(tiposmovto));
        FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
        FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
        FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
        FRel.AddCol( 45,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
        FRel.AddCol(100,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
        FRel.AddCol( 40,0,'C','' ,''              ,'Cod.'            ,''         ,'',False);
        FRel.AddCol(120,0,'C','' ,''              ,'Cliente'         ,''         ,'',False);
        FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
        FRel.AddCol( 80,1,'N','' ,''              ,'Documento'       ,''         ,'',False);
        FRel.AddCol( 80,0,'N','' ,''              ,'Cod.Prod'        ,''         ,'',False);
        FRel.AddCol(120,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
//        FRel.AddCol(080,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
//        FRel.AddCol(080,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
        FRel.AddCol( 70,3,'N','+' ,''             ,'Qtde'             ,''         ,'',False);
        FRel.AddCol( 80,3,'N',''  ,''             ,'Uni.Bruto'        ,''         ,'',False);
        FRel.AddCol( 80,3,'N',''  ,''             ,'Uni.L�quido'      ,''         ,'',False);
        FRel.AddCol( 70,3,'N','' ,''              ,'Desc. Nota(%)'      ,''         ,'',False);
//        FRel.AddCol( 70,3,'N','' ,''              ,'Desc. Item(%)'      ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Desconto'     ,''         ,'',False);
        FRel.AddCol( 90,3,'N','+' ,''             ,'Valor por Produto'     ,''         ,'',False);

        for p:=0 to Lista.count-1 do begin

          PVendas:=Lista[p];
//          if Listadoc.indexof(inttostr(PVendas.numerodoc))=-1 then begin
            FRel.AddCel(PVendas.Unid_codigo);
            FRel.AddCel(inttostr(PVendas.repr_codigo));
            FRel.AddCel(FRepresentantes.GetDescricao(PVendas.repr_codigo));
            FRel.AddCel(inttostr(PVendas.clie_codigo));
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(PVendas.clie_codigo,'C','N'));
            FRel.AddCel(PVendas.tipovenda+'-'+FGeral.GetTipoMovto(PVendas.tipovenda));
            FRel.AddCel(inttostr(PVendas.numerodoc));
            FRel.AddCel(PVendas.esto_codigo);
            FRel.AddCel(FEstoque.GetDescricao(PVendas.esto_codigo));
//            Frel.addcel(strzero(PVendas.tamanho,3)+'-'+FTamanhos.getdescricao(PVendas.tamanho));
//            Frel.addcel(strzero(PVendas.cor,3)+'-'+Fcores.getdescricao(PVendas.cor));
            FRel.AddCel(transform(PVendas.qtdevenda,f_qtdestoque));
            FRel.AddCel(transform(PVendas.unitariobru,f_cr));
            FRel.AddCel(transform(PVendas.unitario,f_cr));

            if (Pvendas.descnota='N')  then begin
              FRel.AddCel(transform(PVendas.vlrdescnota,f_cr));
//              FRel.AddCel('');
            end;
            if (Pvendas.descnota='I') then begin
              FRel.AddCel('');
//              FRel.AddCel(transform(PVendas.vlrdescitem,f_cr));
            end;
            if (Pvendas.descnota='A') then begin
              FRel.AddCel(transform(PVendas.vlrdescnota,f_cr));
//              FRel.AddCel(transform(PVendas.vlrdescitem,f_cr));
            end;

            FRel.AddCel( transform( PVendas.vlrvenda*(PVendas.vlrdescnota/100) ,f_cr) );
            FRel.AddCel(transform(PVendas.vlrvenda,f_cr));
            Listadoc.add(inttostr(PVendas.numerodoc));
//          end;
        end;
        FRel.Video;
      end;
    end;
    Sistema.EndProcess('');
    Freeandnil(Lista);
    Q.close;
    Freeandnil(Q);
  end;
end;



procedure TFRelGerenciais.EdEsto_codigoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
  if not EdEsto_codigo.Isempty then begin
//    if nrorel=2 then
      sqlproduto:=' and move_esto_codigo='+EdEsto_codigo.AsSql
//    else
//      sqlproduto:=' and esqt_esto_codigo='+EdEsto_codigo.AsSql;
  end else
    sqlproduto:='';

end;





procedure TFRelGerenciais.EdCodtipoExitEdit(Sender: TObject);
begin
   baplicarclick(FRelGerenciais);
end;

procedure TFRelGerenciais.EdNumerodocExitEdit(Sender: TObject);
begin
   baplicarclick(FRelGerenciais);

end;

procedure TFRelGerenciais.EdEsto_codigoExitEdit(Sender: TObject);
begin
   baplicarclick(FRelGerenciais);

end;



procedure FRelGerenciais_CorrecaoTransferencias;              // 17
type Vendas=record
     Unid_codigo,esto_codigo,tipovenda,tipocad:string;
     repr_codigo,clie_codigo,numerodoc,tamanho,cor:integer;
     qtdevenda,vlrvenda,qtdevendaprev,vlrvendaprev,unitario,totalnota,customatriz:currency;
     emissao,datacont,movimento:TDatetime;
end;

var Q:TSqlquery;
    Lista:Tlist;
    ListaDoc,Listacustozero:Tstringlist;
    PVendas : ^Vendas;
    p,posicao:integer;
    totqtde,totvalor,qtdeabc,valorabc,customatriz:currency;
    qprodutos:string;


     procedure Adicionalistacustozero(produto:string);
     begin
       If listacustozero.indexof(produto)=-1 then
         Listacustozero.add(produto);
     end;

     function Procura(unidade:string;repre:integer;cliente,numero:integer;emissao:Tdatetime;tipomov,produto:string;tamanho,cor:integer):integer;
     var x:integer;
     begin
       result:=-1;
       for x:=0 to Lista.count-1 do begin
         PVendas:=Lista[x];
         if (PVendas.Unid_codigo=unidade) and (PVendas.repr_codigo=repre) and (PVendas.clie_codigo=cliente)
             and (PVendas.numerodoc=numero) and (PVendas.emissao=emissao) and (PVendas.tipovenda=tipomov) then begin
//             and (PVendas.tamanho=tamanho) and (PVendas.cor=cor) and (PVendas.esto_codigo=produto) then begin
            result:=x;
            break;
         end;
       end;
     end;

     procedure Atualiza(qtde,unitario:currency;posicao:integer);
     var customatriz:currency;
     begin
       PVendas:=Lista[posicao];
//       if Q.fieldbyname('move_datacont').asdatetime<1 then begin
//       if Q.fieldbyname('moes_datacont').asdatetime>1 then begin
         PVendas.qtdevenda:=PVendas.qtdevenda+qtde;
         PVendas.vlrvenda:=PVendas.vlrvenda+(qtde*unitario);
//         if Q.fieldbyname('moes_datacont').asdatetime>1 then
//           customatriz:=FEstoque.GetCusto(Q.fieldbyname('move_esto_codigo').asstring,global.unidadematriz999,'medio')
//         else
//         customatriz:=FEstoque.GetCusto(Q.fieldbyname('move_esto_codigo').asstring,global.unidadematriz,'gerencial');
// 01.09.05
         customatriz:=FEstoque.GetCusto(Q.fieldbyname('move_esto_codigo').asstring,global.unidadematriz,'medioger');
        if customatriz<=0 then
             Adicionalistacustozero(Q.fieldbyname('move_esto_codigo').asstring);
         PVendas.customatriz:=PVendas.customatriz+(qtde*customatriz)
//       end else begin
//         PVendas.qtdevendaprev:=PVendas.qtdevendaprev+qtde;
//         PVendas.vlrvendaprev:=PVendas.vlrvendaprev+(qtde*unitario);
//       end;
     end;



var tiposmovto:string;

begin

  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(17) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');

    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    tiposmovto:=Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.CodTransfEnt+';'+global.CodTransfSai;
    sqltipomovto:=' and '+FGeral.getin('move_tipomov',tiposmovto,'C');
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else
      sqlcodtipo:=' and move_tipo_codigo='+EdCodtipo.assql;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);

    Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqlcodtipo+
                  sqltipomovto+
                  sqlgrupo+
                  sqldatacont+
                  ' and move_status=''N'''+
                  ' order by move_unid_codigo,move_datamvto,move_numerodoc' );

    qprodutos:='';
    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      Lista:=Tlist.create;
      Listadoc:=Tstringlist.create;
      Listacustozero:=Tstringlist.create;
      Sistema.beginprocess('Somando quantidade e valor');
      totqtde:=0;totvalor:=0;
      while not Q.eof do begin
        posicao:=Procura(Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_repr_codigo').asinteger,
                   Q.fieldbyname('move_tipo_codigo').asinteger,Q.fieldbyname('move_numerodoc').asinteger,Q.fieldbyname('moes_dataemissao').asdatetime,
                   Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_esto_codigo').asstring,
                   Q.fieldbyname('move_tama_codigo').asinteger,
                   Q.fieldbyname('move_core_codigo').asinteger);
        if (posicao<0) or (EdSinAna.text='A') then begin
          New(PVendas);
          PVendas.Unid_codigo:=Q.fieldbyname('move_unid_codigo').asstring;
          PVendas.repr_codigo:=Q.fieldbyname('move_repr_codigo').asinteger;
          PVendas.clie_codigo:=Q.fieldbyname('move_tipo_codigo').asinteger;
          PVendas.esto_codigo:=Q.fieldbyname('move_esto_codigo').asstring;
          PVendas.tipovenda:=Q.fieldbyname('move_tipomov').asstring;
          PVendas.numerodoc:=Q.fieldbyname('move_numerodoc').asinteger;
          PVendas.emissao:=Q.fieldbyname('moes_dataemissao').asdatetime;
          Pvendas.tamanho:=Q.fieldbyname('move_tama_codigo').asinteger;
          PVendas.cor:=Q.fieldbyname('move_core_codigo').asinteger;
          PVendas.totalnota:=Q.fieldbyname('moes_vlrtotal').ascurrency;
          Pvendas.datacont:=Q.fieldbyname('moes_datacont').asdatetime;
          Pvendas.tipocad:=Q.fieldbyname('moes_tipocad').asstring;
          Pvendas.movimento:=Q.fieldbyname('moes_datamvto').asdatetime;
//          if Q.fieldbyname('moes_datacont').asdatetime>1 then
//            customatriz:=FEstoque.GetCusto(Q.fieldbyname('move_esto_codigo').asstring,global.unidadematriz999,'medio')
//          else
            customatriz:=FEstoque.GetCusto(Q.fieldbyname('move_esto_codigo').asstring,global.unidadematriz,'medioger');
          if customatriz<=0 then
             Adicionalistacustozero(Q.fieldbyname('move_esto_codigo').asstring);

          PVendas.customatriz:=Q.fieldbyname('move_qtde').ascurrency*customatriz;

           PVendas.qtdevenda:=Q.fieldbyname('move_qtde').ascurrency;
           PVendas.vlrvenda:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency;
           PVendas.unitario:=Q.fieldbyname('move_venda').ascurrency;
           PVendas.qtdevendaprev:=0;
           PVendas.vlrvendaprev:=0;

          Lista.Add(PVendas);
          Listadoc.add(inttostr(Pvendas.numerodoc));
        end else
           Atualiza(Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_venda').ascurrency,posicao);
        Q.Next;
      end;

      if Listacustozero.count>0 then begin
        for p:=0 to LIstacustozero.count-1 do begin
          qprodutos:=qprodutos+listacustozero[p]+';';
        end;
//        avisoerro('Produtos com custo zerado : '+copy(qprodutos,1,10));
      end;
      Sistema.beginprocess('Gerando relat�rio');

        FRel.Init('RelCorrecaoTrans');
        FRel.AddTit('Relat�rio de Transferencias Corrigida pelo Custo da Matriz '+TituloTipoMov(tiposmovto));
        FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
        FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
        FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
        FRel.AddCol( 45,2,'N','' ,''              ,'Codigo emitente'         ,''         ,'',false);
        FRel.AddCol(100,1,'C','' ,''              ,'Nome'            ,''         ,'',false);
        FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
        if EdSinana.text='A' then begin
          FRel.AddCol(080,1,'N','' ,''              ,'Codigo'            ,''         ,'',false);
          FRel.AddCol(120,0,'C','' ,''              ,'Descri��o Produto'  ,''         ,'',False);
        end;
        FRel.AddCol( 80,1,'N','' ,''              ,'Documento'       ,''         ,'',False);
        FRel.AddCol( 50,1,'D','' ,''              ,'Emiss�o'         ,''         ,'',False);
        FRel.AddCol( 50,1,'D','' ,''              ,'Lan�amento'      ,''         ,'',False);
        FRel.AddCol( 50,1,'D','' ,''              ,'Movimento'       ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde'             ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Total'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Corrigido'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Diferen�a'     ,''         ,'',False);
        if trim(qprodutos)<>'' then
          FRel.AddCol(300,0,'C','' ,''              ,'Produtos com custo zerado'  ,''         ,'',False);


        for p:=0 to Lista.count-1 do begin
          PVendas:=Lista[p];
          FRel.AddCel(PVendas.Unid_codigo);
          FRel.AddCel(inttostr(Pvendas.clie_codigo));
          FRel.AddCel(Fgeral.GetNomeRazaoSocialEntidade(PVendas.clie_codigo,PVendas.tipocad,'N'));
//          FRel.AddCel(PVendas.Unid_codigo);
//          FRel.AddCel(FUnidades.GetNome(PVendas.Unid_codigo));
//          FRel.AddCel(inttostr(PVendas.clie_codigo));
//          FRel.AddCel(FCadcli.GetNome(PVendas.clie_codigo));
          FRel.AddCel(PVendas.tipovenda+'-'+FGeral.GetTipoMovto(PVendas.tipovenda));
          if EdSinana.text='A' then begin
            FRel.AddCel(PVendas.esto_codigo);
            FRel.AddCel(FEstoque.getdescricao(PVendas.esto_codigo));
          end;
          FRel.AddCel(inttostr(PVendas.numerodoc));
          FRel.AddCel(datetostr(PVendas.emissao));
          FRel.AddCel(datetostr(PVendas.movimento));
          If pvendas.datacont>1 then
            FRel.AddCel(datetostr(PVendas.datacont))
          else
            FRel.AddCel('');
          FRel.AddCel(transform(PVendas.qtdevenda,f_qtdestoque));
          FRel.AddCel(transform(PVendas.vlrvenda,f_cr));
          FRel.AddCel(transform(PVendas.customatriz,f_cr));
          FRel.AddCel(transform(PVendas.customatriz-PVendas.vlrvenda,f_cr));
          if trim(qprodutos)<>'' then
            FRel.AddCel(qprodutos);

        end;


      FRel.setsort('Emiss�o');
      FRel.Video;
      Freeandnil(Lista);
      Q.close;
      Freeandnil(Q);
    end;
    Sistema.EndProcess('');

    FRelGerenciais_CorrecaoTransferencias;              // 17

  end;
end;


procedure FRelGerenciais_AtendimentosRepre;              // 18

type TMovimento=record
    codrepre:integer;
    vlravista,vlraprazo,vlrdevolucoes,vlrliquido:currency;
    nrocliativos,nroatendimentos:integer;
    unidade:string;
end;

type TClientesAtivos=record
    codrepre,codcliente:integer;
    unidade:string;
end;

var statusvalidos,titulo,sqlorder,sqltipocod,sqltipomov,tiposmov,tiposvenda,tiposdev,checar,devolucoes:string;
    Q,QMovFin:TSqlquery;
    PMovimento:^TMovimento;
    PClientesAtivos:^TclientesAtivos;
    Lista,ListaClientesAtivos:Tlist;
    p:integer;

    function Contaclientes(codrepre:integer ; unidade:string):integer;
    var x,w:integer;
    begin
      w:=0;
      for x:=0 to Listaclientesativos.count-1 do begin
        Pclientesativos:=listaclientesativos[x];
        if (Pclientesativos.codrepre=codrepre) and (Pclientesativos.unidade=unidade) then  begin
          inc(w);
        end;
      end;
      result:=w;
    end;

    procedure Atualiza(unidade:string ; codrepre:integer );
    var x:integer;
        jatem:boolean;
        avista,aprazo,devolucao:currency;

        procedure Atualizaclientes;
        var jatem:boolean;
            x:integer;
        begin
          for x:=0 to Listaclientesativos.count-1 do begin
            Pclientesativos:=listaclientesativos[x];
            if (Pclientesativos.codrepre=Q.Fieldbyname('moes_repr_codigo').asinteger) and
               (Pclientesativos.unidade=Q.Fieldbyname('moes_unid_codigo').asstring) and
               (Pclientesativos.codcliente=Q.Fieldbyname('moes_tipo_codigo').asinteger) then begin
              jatem:=true;
              break;
            end;
          end;
          if not jatem then begin
            New(Pclientesativos);
            Pclientesativos.codrepre:=Q.Fieldbyname('moes_repr_codigo').asinteger;
            Pclientesativos.codcliente:=Q.Fieldbyname('moes_tipo_codigo').asinteger;
            Pclientesativos.unidade:=Q.Fieldbyname('moes_unid_codigo').asstring;
            LIstaclientesativos.add(pclientesativos);
          end;
        end;

    begin
      jatem:=false;
      avista:=0 ; aprazo:=0 ; devolucao:=0;
      if pos(Q.Fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 then  begin
        if Q.FieldByName('moes_vispra').Asstring='V' then begin
          if Q.FieldByName('moes_datacont').Asdatetime>1 then begin
            avista:=Q.FieldByName('moes_vlrtotal').Ascurrency;
          end else begin
            avista:=Q.FieldByName('moes_valortotal').Ascurrency;
          end;
        end else begin
          if Q.FieldByName('moes_valoravista').Ascurrency>0 then begin
            avista:=Q.FieldByName('moes_valoravista').Ascurrency;
// 01.06.05///////////////////
            if Q.FieldByName('moes_tipomov').Asstring='VC' then  begin
              QMovfin:=sqltoquery('select movf_valorger from movfin where movf_transacao='+stringtosql(Q.FieldByName('moes_transacao').Asstring));
              if not QMovfin.eof then begin
                if QMovfin.fieldbyname('movf_valorger').ascurrency<>avista then begin
                  avista:=QMovfin.fieldbyname('movf_valorger').ascurrency;
                  checar:='*';
                end;
              end;
            end;
            if Q.FieldByName('moes_datacont').Asdatetime>1 then begin
              aprazo:=Q.FieldByName('moes_vlrtotal').Ascurrency-avista;
            end else begin
              aprazo:=Q.FieldByName('moes_valortotal').Ascurrency-avista;
            end;
          end else begin
            if Q.FieldByName('moes_datacont').Asdatetime>1 then begin
              aprazo:=Q.FieldByName('moes_vlrtotal').Ascurrency;
            end else begin
              aprazo:=Q.FieldByName('moes_valortotal').Ascurrency;
            end;
          end;
        end;
      end else if pos(Q.Fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
            if Q.FieldByName('moes_datacont').Asdatetime>1 then begin
              devolucao:=Q.FieldByName('moes_vlrtotal').Ascurrency;
            end else begin
              devolucao:=Q.FieldByName('moes_valortotal').Ascurrency;
            end;
      end;
      for x:=0 to Lista.count-1 do begin
        Pmovimento:=lista[x];
        if (Pmovimento.unidade=unidade) and (Pmovimento.codrepre=codrepre) then begin
          jatem:=true;
          break;
        end;
      end;
      if not jatem then begin
        New(Pmovimento);
        Pmovimento.unidade:=unidade;
        Pmovimento.codrepre:=codrepre;
        Pmovimento.vlravista:=avista;
        Pmovimento.vlraprazo:=aprazo;
        Pmovimento.vlrdevolucoes:=devolucao;
        Pmovimento.vlrliquido:=(avista+aprazo)-devolucao;
        Pmovimento.nrocliativos:=0;
        Pmovimento.nroatendimentos:=1;
        Lista.add(pmovimento);
        if pos(Q.Fieldbyname('moes_tipocad').asstring,'C')>0 then begin
          New(Pclientesativos);
          Pclientesativos.codrepre:=Q.Fieldbyname('moes_repr_codigo').asinteger;
          Pclientesativos.codcliente:=Q.Fieldbyname('moes_tipo_codigo').asinteger;
          LIstaclientesativos.add(pclientesativos);
        end;
      end else begin
        Pmovimento.vlravista:=Pmovimento.vlravista+avista;
        Pmovimento.vlraprazo:=Pmovimento.vlraprazo+aprazo;
        Pmovimento.vlrdevolucoes:=Pmovimento.vlrdevolucoes+devolucao;
        Pmovimento.vlrliquido:=Pmovimento.vlrliquido+ (avista+aprazo)-devolucao;
        Pmovimento.nroatendimentos:=Pmovimento.nroatendimentos+1;
        if pos(Q.Fieldbyname('moes_tipocad').asstring,'C')>0 then begin
          AtualizaClientes;
        end;
      end;
    end;

begin
  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(18) then Exit;
    Sistema.BeginProcess('Pesquisando movimento no per�odo');
    statusvalidos:='N;E';
    sqlorder:=' order by moes_unid_codigo,moes_dataemissao,moes_tipo_codigo,moes_numerodoc';
    sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
    devolucoes:=Global.CodDevolucaoVenda+';'+Global.CodDevolucaoRoman;
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and moes_tipo_codigo='+EdCodtipo.assql;
      if Edtipocad.text='R' then
        sqlcodtipo:=' and moes_repr_codigo='+EdCodtipo.assql;
    end;
    if EdTipomov.isempty then begin
      tiposmov:=Global.CodRemessaConsig+';'+Global.CodTransfEntrada+';'+
                Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodRemessaProntaEntrega+';'+Global.CodSimplesRemessa;
      Tiposvenda:=Global.CodVendaConsig+';'+global.CodVendaDireta+';'+global.CodVendaProntaEntrega+';'+global.CodVendaSemMovEstoque+';'+
                  global.CodVendaMagazine+';'+global.CodVendaInterna+';'+global.CodVendaSerie4+';'+Global.CodVendaProntaEntregaFecha;
      Tiposdev:=Global.CodDevolucaoVenda+';'+global.CodDevolucaoSerie5;
    end else begin
      tiposmov:='';
      tiposvenda:=EdTipomov.text;
    end;
    if trim(tiposmov)<>'' then
      sqltipomov:='and '+FGeral.GetNOTIN('moes_tipomov',tiposmov,'C')
    else
      sqltipomov:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);

    titulo:='Atendimentos de '+FGeral.FormataData(Eddatai.asdate)+' a '+FGeral.FormataData(Eddataf.asdate)+
            ' - Tipos Impressos: '+TiposVenda+';'+TiposDev ;
    Q:=sqltoquery('select * from movesto'+
                  ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                  ' and moes_datamvto>='+Eddatai.AsSql+' and moes_datamvto<='+Eddataf.AsSql+
                  sqlunidade+
                  sqlcodtipo+
                  sqltipomov+
                  sqldatacont+
                  ' and '+FGeral.getin('moes_tipomov',tiposvenda+';'+tiposdev,'C')+
                  sqlorder );


    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      Sistema.setmessage('Somando vendas por representante');
      Lista:=Tlist.create;
      ListaClientesAtivos:=TList.create;
      while not Q.eof do begin
        Atualiza(Q.fieldbyname('moes_unid_codigo').asstring,Q.fieldbyname('moes_repr_codigo').asinteger);
        Q.next;
      end;
      Sistema.BeginProcess('Gerando Relat�rio');
      FRel.Init('RelAtendimentosRepre');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
//      FRel.AddTit(Periodo);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Cod.repres.'     ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome repres.'    ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor a Vista'   ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor a Prazo'   ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor Total'     ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Devolu��es'      ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Total L�quido'   ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',''              ,'Atendimentos',''         ,'',false);
      FRel.AddCol(080,3,'N','+',''              ,'Clientes Ativos' ,''         ,'',false);
      for p:=0 to Lista.count-1 do begin
          Pmovimento:=lista[p];
          FRel.AddCel(Pmovimento.unidade);
          FRel.AddCel(inttostr(pmovimento.codrepre));
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(pmovimento.codrepre,'R','N'));
          FRel.AddCel(floattostr(pmovimento.vlravista));
          FRel.AddCel(floattostr(pmovimento.vlraprazo));
          FRel.AddCel(floattostr(pmovimento.vlravista+pmovimento.vlraprazo));
          FRel.AddCel(floattostr(pmovimento.vlrdevolucoes));
          FRel.AddCel(floattostr(pmovimento.vlravista+pmovimento.vlraprazo-pmovimento.vlrdevolucoes));
          FRel.AddCel(floattostr(pmovimento.nroatendimentos));
          pmovimento.nrocliativos:=contaclientes(pmovimento.codrepre,PMovimento.unidade);
          FRel.AddCel(floattostr(pmovimento.nrocliativos));
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);
  end;

end;



procedure FRelGerenciais_CMV;                //20
/////////////////////////////////////////////////////

type TRegistro=record
     moes_repr_codigo,moes_tipo_codigo,moes_numerodoc:integer;
     moes_tipocad,moes_unid_codigo,notasvenda,notasdev,move_esto_codigo,esto_unidade,esto_referencia:string;
     moes_dataemissao:TDatetime;
     qtdeven,qtdedev,vlrvenda,vlrdesconto,vlrdev,vlrvendast,vlrdevst:currency;
end;


var Q:TSqlquery;
    sqlconsigaberto,produto,tiporesumo,tiposvenda,tiposdev,titulo,sqlstatus:string;
    vlrremessa,qtde,qtdeliquida,vlrliquido,valorcmv,st,vlrliquidost,valorcmvst,vlrvendabru,vlrdev,vlrdevst:currency;
    repr,clie:integer;
    PRegistro:^TRegistro;
    ListaRegistro:TList;
    p,y,x:integer;

    function GetValorunitario:currency;
    ////////////////////////////////////
    begin
// 30.07.09 - Abra - Contabilidade
      if pos(Global.CodSaidaAlmox,FRelGerenciais.EdTipomov.text)>0 then
          result:=FEstoque.GetCusto(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring,'mediocustosemser')
      else begin
        if Q.fieldbyname('moes_tabp_codigo').asinteger>0 then
          result:=Q.fieldbyname('move_venda').ascurrency
        else if Q.fieldbyname('move_perdesco').ascurrency>0 then
          result:=Q.fieldbyname('move_venda').ascurrency
        else if Q.fieldbyname('moes_perdesco').ascurrency>0 then
          result:=Q.fieldbyname('move_venda').ascurrency - (Q.fieldbyname('move_venda').ascurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100)  )
        else if Q.fieldbyname('moes_peracres').ascurrency>0 then
          result:=Q.fieldbyname('move_venda').ascurrency + (Q.fieldbyname('move_venda').ascurrency*(Q.fieldbyname('moes_peracres').ascurrency/100)  )
        else
          result:=Q.fieldbyname('move_venda').ascurrency;
     end;
    end;

    function GetValorunitariost:currency;
    begin
      if Q.fieldbyname('moes_tabp_codigo').asinteger>0 then
        result:=Q.fieldbyname('move_venda').ascurrency
      else if Q.fieldbyname('move_perdesco').ascurrency>0 then
        result:=Q.fieldbyname('move_venda').ascurrency
      else if Q.fieldbyname('moes_perdesco').ascurrency>0 then
        result:=Q.fieldbyname('move_venda').ascurrency - (Q.fieldbyname('move_venda').ascurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100)  )
      else if Q.fieldbyname('moes_peracres').ascurrency>0 then
        result:=Q.fieldbyname('move_venda').ascurrency + (Q.fieldbyname('move_venda').ascurrency*(Q.fieldbyname('moes_peracres').ascurrency/100)  )
      else
        result:=Q.fieldbyname('move_venda').ascurrency;
      result:=result+ (result*st);
    end;

    function Procura(unidade,tipomov,produto:string;repr,cliente,numero:integer):integer;
    /////////////////////////////////////////////////////////////////////////////////////
    var x:integer;
    begin
      result:=-1;
      for x:=0 to Listaregistro.count-1 do begin
        Pregistro:=listaregistro[x];
        if tiporesumo='C' then  begin
          if (pregistro.moes_repr_codigo=repr) and (pregistro.moes_tipo_codigo=cliente) and (pregistro.moes_unid_codigo=unidade)
             then begin
  //           and (pregistro.moes_numerodoc=numero) then begin
            result:=x;
            break;
          end;
        end else begin
          if (pregistro.moes_unid_codigo=unidade) and (pregistro.move_esto_codigo=produto)
             then begin
            result:=x;
            break;
          end;
        end;
      end;
    end;

    procedure Atualiza(posicao:integer;qtde:currency;tipomov:string);
    ////////////////////////////////////////////////////////////////
    var x:integer;
        valor:currency;
    begin
      Pregistro:=listaregistro[posicao];
      valor:=qtde*Getvalorunitario;
      if tiporesumo='C' then begin
        if pos(tipomov,tiposvenda)>0 then begin
          Pregistro.qtdeven:=Pregistro.qtdeven+qtde;
        end else begin
          Pregistro.qtdedev:=Pregistro.qtdedev+qtde;
        end;

      end else begin

              if pos(Q.fieldbyname('move_tipomov').asstring,tiposdev)>0 then begin
                 PRegistro.vlrdev:=PRegistro.vlrdev+(Q.fieldbyname('move_qtde').ascurrency*Getvalorunitario);
                 Pregistro.qtdedev:=Pregistro.qtdedev+Q.fieldbyname('move_qtde').ascurrency;
                 PRegistro.vlrdevst:=PRegistro.vlrdevst+(Q.fieldbyname('move_qtde').ascurrency*Getvalorunitariost);
              end else begin
                 PRegistro.vlrvenda:=PRegistro.vlrvenda+(Q.fieldbyname('move_qtde').ascurrency*Getvalorunitario);
                 Pregistro.qtdeven:=Pregistro.qtdeven+Q.fieldbyname('move_qtde').ascurrency;
                 PRegistro.vlrvendast:=PRegistro.vlrvendast+(Q.fieldbyname('move_qtde').ascurrency*Getvalorunitariost);
              end;
      end;
    end;


begin

  with FRelGerenciais do begin

    tiporesumo:='D';   // EdTiporesumo.text;   // C - cliente  / D - documento

    if not FRelGerenciais_Execute(20) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if EdTipomov.isempty then begin
      Tiposvenda:=Global.TiposRelVenda;
      Tiposdev:=Global.TiposRelDevVenda;
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',tiposvenda+';'+TiposDev,'C');
    end else begin
      tiposvenda:=EdTipomov.text;
      Tiposdev:='';
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',tiposvenda,'C');
    end;
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      if Edtipocad.text='R' then
        sqlcodtipo:=' and move_repr_codigo='+EdCodtipo.assql
      else
        sqlcodtipo:=' and move_clie_codigo='+EdCodtipo.assql;
    end;
// 03.10.05
    if not EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.getin('move_esto_codigo',EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
// 18.01.06
    if trim(tiposdev)='' then
      sqlstatus:=' and '+FGeral.Getin('move_status','N;E;D','C') + ' and '+FGeral.Getin('moes_status','N;E;D','C')
    else
      sqlstatus:=' and '+FGeral.Getin('move_status','N;E','C') + ' and '+FGeral.Getin('moes_status','N;E','C');
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);

    Q:=sqltoquery('select * from movestoque '+
//                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc and moes_status=move_status)'+
// 20.02.06
//                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc)'+
// 11.04.06
                  ' left join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc)'+
                  ' left join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqlstatus+
                  sqlgrupo+
                  sqlsubgrupo+
                  sqldatacont+
                  ' order by move_unid_codigo,move_datalcto,move_numerodoc,move_tipo_codigo,move_esto_codigo' );

    titulo:='Custo Mercadoria Vendida de '+FGeral.FormataData(Eddatai.asdate)+' a '+FGeral.FormataData(Eddataf.asdate)+
            ' - Tipos Impressos: '+TiposVenda+';'+TiposDev ;

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

      sistema.beginprocess('separando quantidade vendida por produto');
      ListaREgistro:=TList.create;
      while not Q.eof do begin
        y:=procura(Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_esto_codigo').asstring,
                   Q.fieldbyname('move_repr_codigo').asinteger,
                   Q.fieldbyname('move_tipo_codigo').asinteger,Q.fieldbyname('move_numerodoc').asinteger);
        if Q.fieldbyname('moes_totprod').ascurrency>0 then
          st:=Q.fieldbyname('moes_valoricmssutr').ascurrency/Q.fieldbyname('moes_totprod').ascurrency
//        else if Q.fieldbyname('moes_vlrtotal').ascurrency>0 then
//          st:=Q.fieldbyname('moes_valoricmssutr').ascurrency/Q.fieldbyname('moes_vlrtotal').ascurrency
        else
          st:=0;
        if y=-1 then begin
          New(Pregistro);
          Pregistro.moes_repr_codigo:=Q.fieldbyname('moes_repr_codigo').asinteger;
          if Q.fieldbyname('moes_clie_codigo').asinteger=0 then
            Pregistro.moes_tipo_codigo:=Q.fieldbyname('moes_tipo_codigo').asinteger
          else
            Pregistro.moes_tipo_codigo:=Q.fieldbyname('moes_clie_codigo').asinteger;
//          Pregistro.moes_unid_codigo:=Q.fieldbyname('moes_unid_codigo').asstring;
// 11.04.06
          Pregistro.moes_unid_codigo:=Q.fieldbyname('move_unid_codigo').asstring;
          Pregistro.qtdeven:=0;
          Pregistro.qtdedev:=0;
          Pregistro.moes_numerodoc:=Q.fieldbyname('moes_numerodoc').asinteger;
          PRegistro.moes_dataemissao:=Q.fieldbyname('moes_dataemissao').asdatetime;
          PREgistro.qtdeven:=0;
          PREgistro.qtdedev:=0;
          PREgistro.move_esto_codigo:=Q.fieldbyname('move_esto_codigo').asstring;
          PREgistro.vlrvenda:=0;
          PREgistro.vlrdesconto:=0;
          PREgistro.vlrdev:=0;
          PREgistro.vlrvendast:=0;
          PREgistro.vlrdevst:=0;
          PREgistro.esto_unidade:=Q.fieldbyname('esto_unidade').AsString;
          PREgistro.esto_referencia:=Q.fieldbyname('esto_referencia').AsString;

          if tiporesumo='C' then begin
//            if Q.fieldbyname('move_tipomov').asstring=global.CodRemessaConsig then begin
            if pos(Q.fieldbyname('move_tipomov').asstring,tiposvenda)>0 then begin
              Pregistro.qtdeven:=Q.fieldbyname('move_qtde').ascurrency;
            end else begin
              Pregistro.qtdedev:=Q.fieldbyname('move_qtde').ascurrency;
            end;
          end else begin
              if pos(Q.fieldbyname('move_tipomov').asstring,tiposdev)>0 then begin
                 PRegistro.vlrdev:=(Q.fieldbyname('move_qtde').ascurrency*Getvalorunitario);
                 Pregistro.qtdedev:=Q.fieldbyname('move_qtde').ascurrency;
                 PRegistro.vlrdevst:=(Q.fieldbyname('move_qtde').ascurrency*Getvalorunitariost);
              end else begin
                 PRegistro.vlrvenda:=(Q.fieldbyname('move_qtde').ascurrency*Getvalorunitario);
                 Pregistro.qtdeven:=Q.fieldbyname('move_qtde').ascurrency;
                 PRegistro.vlrvendast:=(Q.fieldbyname('move_qtde').ascurrency*Getvalorunitariost);
              end;
          end;
          ListaRegistro.Add(PRegistro);
        end else
           Atualiza(y,Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_tipomov').asstring);
        Q.next;
      end;

      FRel.Init('RelCustoMercadoriaVendida');
      if tiporesumo='C' then
        FRel.AddTit('Relat�rio de Custo da Mercadoria Vendida por ...')
      else
        FRel.AddTit('Relat�rio de Custo da Mercadoria Vendida - Tipos Impressos: '+TiposVenda+';'+TiposDev );
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloGrupoproduto(EdGrup_codigo.text)+FGeral.TituloSubGrupoproduto(EdSubGrup_codigo.text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol(090,0,'N','' ,''              ,'Produto'         ,''         ,'',False);
      FRel.AddCol(090,0,'C','' ,''              ,'Refer�ncia'         ,''         ,'',False);
      FRel.AddCol(170,0,'C','' ,''              ,'Descri��o'       ,''         ,'',False);
      FRel.AddCol( 60,0,'N','' ,''              ,'Grupo'           ,''         ,'',False);
      FRel.AddCol(100,0,'C','' ,''              ,'Descri��o Grupo'           ,''         ,'',False);
      FRel.AddCol( 60,0,'N','' ,''              ,'SubGrupo'           ,''         ,'',False);
      FRel.AddCol(120,0,'C','' ,''              ,'Descri��o SubGrupo'           ,''         ,'',False);
      FRel.AddCol(050,0,'C','' ,''              ,'Unidade'           ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Venda '         ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Devolvida '         ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Liquida '         ,''         ,'',False);
      if pos(Global.CodSaidaAlmox,FRelGerenciais.EdTipomov.text)=0 then begin
        FRel.AddCol( 80,3,'N','+',''              ,'Venda Bruta'            ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+',''              ,'Venda Bruta + ST'            ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+',''              ,'Devolu��o'              ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+',''              ,'Devolu��o + ST'              ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+',''              ,'Venda Liquida'          ,''         ,'',False);
      end else begin
          FRel.AddCol( 80,3,'N','+' ,''             ,'CMV M�dio '     ,''         ,'',False);
      end;
// 30.07.09 - Abra - Contabilidade
      if pos(Global.CodSaidaAlmox,FRelGerenciais.EdTipomov.text)=0 then begin
        if Global.Usuario.OutrosAcessos[0010] then begin
          FRel.AddCol( 80,3,'N','+' ,''             ,'CMV Medio gerencial'     ,''         ,'',False);
          FRel.AddCol( 80,3,'N','&' ,'##,##0.00'     ,'Margem Bruta'            ,''         ,'',False);
        end;
        FRel.AddCol( 90,3,'N','+',''              ,'Venda Liquida ST'          ,''         ,'',False);
        if Global.Usuario.OutrosAcessos[0010] then begin
          FRel.AddCol( 90,3,'N','&' ,'##,##0.00'     ,'Margem Bruta ST'            ,''         ,'',False);
        end;
      end;

      for p:=0 to Listaregistro.count-1 do begin
        Pregistro:=listaregistro[p];
        FRel.AddCel(pregistro.moes_unid_codigo);
        FRel.AddCel(pregistro.move_esto_codigo);
        FRel.AddCel(pregistro.esto_referencia);
        FRel.AddCel(FEstoque.GetDescricao(pregistro.move_esto_codigo));
        FRel.AddCel( inttostr(FEstoque.getgrupo(pregistro.move_esto_codigo)) );
        FRel.AddCel(FGrupos.GetDescricao(FEstoque.getgrupo(pregistro.move_esto_codigo)));
        FRel.AddCel( inttostr(FEstoque.getsubgrupo(pregistro.move_esto_codigo)) );
        FRel.AddCel(FSubGrupos.GetDescricao(FEstoque.getsubgrupo(pregistro.move_esto_codigo)));
        qtdeliquida:=Pregistro.qtdeven-Pregistro.qtdedev;
        vlrliquido:=Pregistro.vlrvenda-Pregistro.vlrdev;
        vlrliquidost:=Pregistro.vlrvendast-Pregistro.vlrdevst;
        FRel.AddCel(Pregistro.esto_unidade);
        FRel.AddCel(formatfloat(f_cr,pregistro.qtdeven));
        FRel.AddCel(formatfloat(f_cr,pregistro.qtdedev));
        FRel.AddCel(formatfloat(f_cr,qtdeliquida));
        if pos(Global.CodSaidaAlmox,FRelGerenciais.EdTipomov.text)=0 then begin
          FRel.AddCel(formatfloat(f_cr,PRegistro.vlrvenda));
          FRel.AddCel(formatfloat(f_cr,PRegistro.vlrvendast));
          FRel.AddCel(formatfloat(f_cr,PRegistro.vlrdev));
          FRel.AddCel(formatfloat(f_cr,PRegistro.vlrdevst));
          FRel.AddCel(formatfloat(f_cr,vlrliquido));
        end else
          FRel.AddCel(formatfloat(f_cr,vlrliquido));
// 30.07.09 - Abra - Contabilidade
        if pos(Global.CodSaidaAlmox,FRelGerenciais.EdTipomov.text)=0 then begin
// 25.10.13 - vivan - vande
          if Global.Topicos[1222] then
            valorcmv:=FEstoque.getcusto(Pregistro.move_esto_codigo,global.unidadematriz,'custo')*qtdeliquida
          else
            valorcmv:=FEstoque.getcusto(Pregistro.move_esto_codigo,global.unidadematriz,'medioger')*qtdeliquida;
          if Global.Usuario.OutrosAcessos[0010] then begin
            FRel.AddCel(formatfloat(f_cr,valorcmv));   // 08.07.05
            if vlrliquido>0 then begin
              FRel.AddCel( floattostr(  ((valorcmv/vlrliquido)*100)  )   );
            end else begin
              FRel.AddCel('');
            end;
          end;
          FRel.AddCel(formatfloat(f_cr,vlrliquidost));
          if Global.Usuario.OutrosAcessos[0010] then begin
  //          FRel.AddCel(floattostr(valorcmv));   // 08.07.05
            if vlrliquidost>0 then begin
              FRel.AddCel( floattostr(  ((valorcmv/vlrliquidost)*100)  )   );
            end else begin
              FRel.AddCel('');
            end;
          end;
        end;

      end;
      FRel.Setsort('Produto');
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
    ListaRegistro.free;
  end;

  FRelGerenciais_CMV;                //20

end;
///////////////////////////////////////

// 26.09.05
////////////////////////////////////////////////////////
{
procedure FRelGerenciais_InadimplenciaCheques;  // 21

type TInad=record
     codrepr:integer;
     valorrecebido,valordevolvido:currency;
     unidade:string;
end;

var Q:TSqlquery;
    titulo,statusvalidos,sqldatalan,sqlorder,periodo,sqlcodtipo,sqltipocad:string;
    percinad:currency;
    Lista:Tlist;
    PInad:^TInad;
    p:integer;

    procedure Atualizalista;
    var x:integer;
        found:boolean;
    begin
      found:=false;
      for x:=0 to Lista.count-1 do begin
        PInad:=Lista[x];
        if ( PInad.unidade=Q.fieldbyname('cheq_unid_codigo').asstring ) and
           ( PInad.codrepr=Q.fieldbyname('cheq_repr_codigo').asinteger ) then begin
          found:=true;
          break;
        end;
      end;
      if not found then begin
        New(PInad);
        PInad.codrepr:=Q.fieldbyname('cheq_repr_codigo').asinteger;
        PINad.unidade:=Q.fieldbyname('cheq_unid_codigo').asstring;
        PInad.valorrecebido:=0;
        PInad.valordevolvido:=0;
// aqui deixar assim at� criar campo especifico para cheques devolvidos
        if pos( 'CD',uppercase(Q.fieldbyname('cheq_bcoemitente').asstring) )>0 then
          PInad.valordevolvido:=Q.fieldbyname('cheq_valor').ascurrency
        else
          PInad.valorrecebido:=Q.fieldbyname('cheq_valor').ascurrency;
          Lista.add(PInad);
      end else begin
// aqui deixar assim at� criar campo especifico para cheques devolvidos
        if pos( 'CD',uppercase(Q.fieldbyname('cheq_bcoemitente').asstring) )>0 then
          PInad.valordevolvido:=PInad.valordevolvido+Q.fieldbyname('cheq_valor').ascurrency
        else
          PInad.valorrecebido:=PInad.valorrecebido+Q.fieldbyname('cheq_valor').ascurrency;
      end;
    end;

begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(21) then Exit;
    Sistema.BeginProcess('Somando valores');
    titulo:='Relat�rio de Inadimpl�ncia de Cheques';
    statusvalidos:='N';
    sqlorder:=' order by cheq_unid_codigo,cheq_repr_codigo';
    sqlunidade:=' and '+FGeral.getin('cheq_unid_codigo',EdUnid_codigo.text,'C');
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
      sqldatacont:=' and move_datacont>1';

    periodo:='Periodo : ';
    if EdDepositoi.AsDate>1 then begin
      sqldatalan:=' and cheq_deposito>='+EdDepositoi.AsSql+' and cheq_deposito<='+EdDepositof.AsSql;
      periodo:=periodo+' Dep�sito : '+FGeral.FormataData(EdDepositoi.AsDate)+' a '+FGeral.FormataData(EdDepositof.AsDate);
    end else
      sqldatalan:='';

    if EdCodtipo.AsInteger>0 then begin
      titulo:=titulo+' - Codigo '+EdCodtipo.text+' - '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipocad.text,'N');
      if EdTipocad.text='R' then
        sqlcodtipo:=' and cheq_repr_codigo='+Edcodtipo.AsSql
      else
        sqlcodtipo:='';
    end else
      sqlcodtipo:='';
    sqltipocad:='';
    Q:=sqltoquery('select * from cheques'+
                  ' where '+FGeral.Getin('cheq_status',statusvalidos,'C')+
                  sqlunidade+
                  sqldatalan+
                  sqldatacont+
                  sqlcodtipo+
                  sqltipocad+
                  sqlorder );


    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      Lista:=TList.create;
      while not Q.eof do begin
        Atualizalista;
        Q.next;
      end;
      Sistema.BeginProcess('Gerando Relat�rio');
      FRel.Init('RelInadimplenciaCheques');
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit(titulo);
      FRel.AddTit(Periodo);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
//      if Global.Usuario.OutrosAcessos[0701] then
//         FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      if EdCodtipo.AsInteger=0 then begin
        FRel.AddCol( 45,0,'C','' ,''              ,'Repr.'              ,''         ,'',false);
        FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      end;
      FRel.AddCol( 80,3,'N','+' ,f_cr            ,'Vlr Recebido'   ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr            ,'Vlr Devolvido'   ,''         ,'',False);
      FRel.AddCol( 70,3,'N',''  ,f_cr            ,'% Inadimp.'   ,''         ,'',False);

      for p:=0 to Lista.count-1 do begin
          PInad:=lista[p];
          FRel.AddCel(PInad.unidade);
//          if Global.Usuario.OutrosAcessos[0701] then
//            FRel.AddCel(Q.FieldByName('pend_datacont').AsString);
          if EdCodtipo.AsInteger=0 then begin
            FRel.AddCel(inttostr(PInad.codrepr));
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(PInad.codrepr,'R','N'));
          end;
          FRel.AddCel(floattostr(PInad.valorrecebido));
          FRel.AddCel(floattostr(PInad.valordevolvido));
          if PInad.valorrecebido>0 then
            percinad:=(PInad.valordevolvido/PInad.valorrecebido)*100
          else if  PInad.valordevolvido=0 then
            percinad:=0
          else
            percinad:=100;
          FRel.AddCel(floattostr(percinad));
      end;
      Lista.free;
      FREl.setsort('% Inadimp.',false);
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);

    FRelGerenciais_InadimplenciaCheques;  // 21

  end;

end;
}
////////////////////////////////////////////

procedure FRelGerenciais_VendasProdutoQtde;          // 22  - Vendas por Produto
///////////////////////////////////////////////////////////////

var Q:TSqlquery;
    QDevo:TMemoryquery;
    tiposmovto,titnumeros,sqlorder,sqlgroup,campo,campo1,campo2:string;
    vlrvenda,qtdevenda,vlrdevo,qtdedevo,pecasvenda,pecasdevo,unitariomedio,pesomedio:currency;
    ListaImpressos:TStringList;
    p:integer;

    procedure Checadevolucao;
    //////////////////////////
    begin
      QDevo.First;
      while not QDevo.eof do begin
//        if FRelGerenciais.EdConsfinal.text='S' then begin
//          if ( ( Qdevo.fieldbyname( campo ).asstring+Qdevo.fieldbyname( campo1 ).asstring+Qdevo.fieldbyname( campo2 ).asstring )
//              =
//              ( Q.fieldbyname( campo ).asstring+Q.fieldbyname( campo1 ).asstring+Q.fieldbyname( campo2 ).asstring ) ) and
//             (Qdevo.fieldbyname('move_unid_codigo').asstring=Q.fieldbyname('move_unid_codigo').asstring) and
//             (Qdevo.fieldbyname('clie_consfinal').asstring=Q.fieldbyname('clie_consfinal').asstring) then begin
//            qtdedevo:=qtdedevo+Qdevo.fieldbyname('qtde').asfloat;
//            vlrdevo:=vlrdevo+(Qdevo.fieldbyname('vlrvenda').asfloat);
//          end;
//        end else begin
          if (Qdevo.fieldbyname( campo ).asstring=Q.fieldbyname( campo ).asstring) and
             (Qdevo.fieldbyname('move_unid_codigo').asstring=Q.fieldbyname('move_unid_codigo').asstring) then begin
            qtdedevo:=qtdedevo+Qdevo.fieldbyname('qtde').asfloat;
            pecasdevo:=pecasdevo+Qdevo.fieldbyname('pecas').asfloat;
            vlrdevo:=vlrdevo+(Qdevo.fieldbyname('vlrvenda').asfloat);
          end;
//        end;
        QDevo.next;
      end;
    end;


begin
////////////////////////////////

  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(22) then Exit;
    Sistema.BeginProcess('Somando vendas');

// ver pedir se quer relat. sobre consigna��o, pronta entrega ou "outro esquema"
//    Tiposmov:=Global.CodVendaConsig+';'+Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig;
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    tiposmovto:=global.TiposRelVenda;
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C');
      tiposmovto:=EdTipomov.text;
    end else
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',tiposmovto,'C');
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and move_tipo_codigo='+EdCodtipo.assql;
      if Edtipocad.text='R' then  // 02.05.05
        sqlcodtipo:=' and move_repr_codigo='+EdCodtipo.assql;

    end;
    if not EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.getin('move_esto_codigo',EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);
// 16.02.11
    if not EdNumeros.IsEmpty then
      sqlnumeros:=' and '+fGeral.GetIN('move_numerodoc',EdNumeros.Text,'N')
    else
      sqlnumeros:='';
// 18.08.14
    if EdConsfinal.text='S' then begin
      sqlorder:=' order by move_unid_codigo,move_esto_codigo,Clie_consfinal';
      sqlgroup:=' group by move_unid_codigo,move_esto_codigo,Clie_consfinal';
    end else begin
      sqlorder:=' order by move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo';
      sqlgroup:=' group by move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo';
    end;
    campo:='move_esto_codigo';
    campo1:='move_tama_codigo';
    campo2:='move_core_codigo';
    if EdTipocad.text='C' then begin
      if EdConsfinal.text='S' then begin
        sqlorder:=' order by move_unid_codigo,move_tipo_codigo,Clie_consfinal';
        sqlgroup:=' group by move_unid_codigo,move_tipo_codigo,Clie_consfinal';
      end else begin
        sqlorder:=' order by move_unid_codigo,move_tipo_codigo,move_tama_codigo,move_core_codigo';
        sqlgroup:=' group by move_unid_codigo,move_tipo_codigo,move_tama_codigo,move_core_codigo';
      end;
      campo:='move_tipo_codigo';
      campo1:='move_tama_codigo';
      campo2:='move_core_codigo';
    end;
    if EdConsfinal.text='S' then
      Q:=sqltoquery('select move_unid_codigo,'+campo+','+campo1+','+campo2+',Clie_consfinal,sum(move_qtde) as qtde,sum(move_qtde*move_venda) as vlrvenda,sum(move_pecas) as pecas from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' inner join clientes on ( moes_tipo_codigo=clie_codigo )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqlcodtipo+
                  sqltipomovto+
                  sqlproduto+
                  sqldatacont+
                  sqlnumeros+
//                  ' and move_status<>''C'''+
                  ' and '+FGeral.GetNotin('move_status','C;X;Y','C')+
                  ' and '+FGeral.GetNotin('moes_status','C;X;Y','C')+
//                  ' and '+FGeral.Getin('move_status','D','C')+
                  sqlgroup+
                  sqlorder )
    else
      Q:=sqltoquery('select move_unid_codigo,'+campo+','+campo1+','+campo2+',sum(move_qtde) as qtde,sum(move_qtde*move_venda) as vlrvenda,sum(move_pecas) as pecas from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqlcodtipo+
                  sqltipomovto+
                  sqlproduto+
                  sqldatacont+
                  sqlnumeros+
//                  ' and move_status<>''C'''+
                  ' and '+FGeral.GetNotin('move_status','C;X;Y','C')+
                  ' and '+FGeral.GetNotin('moes_status','C;X;Y','C')+
//                  ' and '+FGeral.Getin('move_status','D','C')+
                  sqlgroup+
                  sqlorder );

    if Q.Eof then
      Sistema.endprocess('Nada encontrado para impress�o')
    else begin

      Sistema.BeginProcess('Somando devolucoes');
      if EdConsfinal.text='S' then
        QDevo:=sqltomemoryquery('select move_unid_codigo,'+campo+',Clie_consfinal,sum(move_qtde) as qtde,sum(move_qtde*move_venda) as vlrvenda,sum(move_pecas) as pecas from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' inner join clientes on ( moes_tipo_codigo=clie_codigo )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqlcodtipo+
                  sqldatacont+
                  ' and '+FGeral.getin('move_tipomov',global.TiposRelDevVenda,'C')+
                  sqlproduto+
//                  ' and move_status<>''C'''+
                  ' and '+FGeral.GetNotin('move_status','C;X;Y','C')+
//                  ' and '+FGeral.Getin('move_status','D','C')+
                  sqlgroup+
                  sqlorder )
      else
        QDevo:=sqltomemoryquery('select move_unid_codigo,'+campo+','+campo1+','+campo2+',sum(move_qtde) as qtde,sum(move_qtde*move_venda) as vlrvenda,sum(move_pecas) as pecas from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqlcodtipo+
                  sqldatacont+
                  ' and '+FGeral.getin('move_tipomov',global.TiposRelDevVenda,'C')+
                  sqlproduto+
//                  ' and move_status<>''C'''+
                  ' and '+FGeral.GetNotin('move_status','C;X;Y','C')+
                  ' and '+FGeral.GetNotin('moes_status','C;X;Y','C')+
//                  ' and '+FGeral.Getin('move_status','D','C')+
                  sqlgroup+
                  sqlorder );

      Sistema.beginprocess('Gerando relat�rio');
      if not EdNumeros.IsEmpty then
        titnumeros:=' - Documentos:'+EdNumeros.text
      else
        titnumeros:='';

      FRel.Init('RelProdutoQTdeVendas');
      if EdTipocad.text='C' then
        FRel.AddTit('Valor Vendido por Cliente '+TituloTipoMov(tiposmovto)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,Edtipocad.text))
      else
        FRel.AddTit('Quantidade Vendida por Produto '+TituloTipoMov(tiposmovto)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,Edtipocad.text));
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelProduto(EdEsto_codigo.text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate)+titnumeros);
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 50,0,'N','' ,''              ,'Grupo'           ,''         ,'',False);
      FRel.AddCol(100,0,'C','' ,''              ,'Descri��o'           ,''         ,'',False);
//      FRel.AddCol(060,0,'C','' ,''              ,'Sist.Vendas'         ,''         ,'',False);
      if EdTipocad.text='C' then begin
        FRel.AddCol( 80,0,'N','' ,''              ,'Codigo'        ,''         ,'',False);
        FRel.AddCol(180,1,'C','' ,''              ,'Cliente'          ,''         ,'',False);
      end else begin
        FRel.AddCol( 80,0,'N','' ,''              ,'Cod.Prod'        ,''         ,'',False);
        FRel.AddCol(300,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
        FRel.AddCol(100,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
        FRel.AddCol(100,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
      end;
      FRel.AddCol(050,1,'C','' ,''              ,'Unid'          ,''         ,'',False);
      if EdConsFinal.Text='S' then
        FRel.AddCol(60,1,'C','' ,''              ,'Cons.Final'          ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Vendida'             ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Vendido'     ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Devol'             ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Devol'     ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde liq.'             ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Valor liq.'     ,''         ,'',False);
// 02.06.16
      FRel.AddCol( 80,3,'N','+' ,''             ,'Pe�as'             ,''         ,'',False);
      FRel.AddCol( 80,3,'N','&'  ,''             ,'Unit�rio M�dio'     ,''         ,'',False);
      FRel.AddCol( 80,3,'N','&'  ,''             ,'Peso M�dio'     ,''         ,'',False);
      if EdConsFinal.Text='S' then begin
        FRel.AddCol( 80,3,'N','+' ,''             ,'Valor liq.CF'     ,''         ,'',False);
        FRel.AddCol( 90,3,'N','+' ,''             ,'Valor liq.Total'     ,''         ,'',False);
      end;
      ListaImpressos:=TStringList.Create;
      while not Q.eof  do begin
        FRel.AddCel(Q.fieldbyname('move_unid_codigo').asstring);
        if EdTipocad.text='C' then begin
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel(Q.fieldbyname('move_tipo_codigo').asstring);
          FRel.AddCel(FCadcli.GetNome(Q.fieldbyname('move_tipo_codigo').asinteger));
          FRel.AddCel( '' );
        end else begin
          FRel.AddCel( inttostr(FEstoque.getgrupo(Q.fieldbyname('move_esto_codigo').asstring)) );
          FRel.AddCel(FGrupos.GetDescricao(FEstoque.getgrupo(Q.fieldbyname('move_esto_codigo').asstring)));
          FRel.AddCel(Q.fieldbyname('move_esto_codigo').asstring);
          FRel.AddCel(FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').asstring));
// 09.04.15 - devereda
          Frel.addcel(FTamanhos.getdescricao(Q.fieldbyname('move_tama_codigo').asinteger));
          Frel.addcel(Fcores.getdescricao(Q.fieldbyname('move_core_codigo').asinteger));

          FRel.AddCel(FEstoque.GetUnidade(Q.fieldbyname('move_esto_codigo').asstring));
        end;
// 10.04.14 - Devolvidos mas nao vendidos no mes
        If ListaImpressos.IndexOf(Q.fieldbyname( campo ).asstring+Q.fieldbyname( campo1 ).asstring+Q.fieldbyname( campo2 ).asstring)=-1 then
           ListaImpressos.Add(Q.fieldbyname( campo ).asstring+Q.fieldbyname( campo1 ).asstring+Q.fieldbyname( campo2 ).asstring);
        if EdConsFinal.Text='S' then begin
          FRel.AddCel(Q.fieldbyname('clie_consfinal').AsString);
          if Q.fieldbyname('clie_consfinal').AsString='S' then begin
            FRel.AddCel('');
            FRel.AddCel('');
          end else begin
            FRel.AddCel(transform(Q.fieldbyname('qtde').ascurrency,f_qtdestoque));
            FRel.AddCel(transform(Q.fieldbyname('vlrvenda').ascurrency,f_cr));
          end;
          qtdedevo:=0;
          vlrdevo:=0;
          pecasdevo:=0;
          Checadevolucao;
          FRel.AddCel(transform(qtdedevo,f_qtdestoque));
// 24.06.13 - vivan - algumas DV foram gravadas com valor unitario zerado entao pego
//        pelo pre�o da venda;;;
// 10.04.14 - Novicarnes - retirado..nao bate com o rel. faturamento
//          vlrdevo:=qtdedevo*(Q.fieldbyname('vlrvenda').ascurrency/Q.fieldbyname('qtde').ascurrency);
//          vlrdevo:=qtdedevo*FEstoque.GetPreco(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring);
          FRel.AddCel(transform(vlrdevo,f_cr));
          qtdevenda:=Q.fieldbyname('qtde').ascurrency-qtdedevo;
          pecasvenda:=Q.fieldbyname('pecas').ascurrency-pecasdevo;
          vlrvenda:=Q.fieldbyname('vlrvenda').ascurrency-vlrdevo;
          if Q.fieldbyname('clie_consfinal').AsString='S' then begin
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel(transform(qtdevenda,f_qtdestoque));
            FRel.AddCel(transform(vlrvenda,f_cr));
          end else begin
            FRel.AddCel(transform(qtdevenda,f_qtdestoque));
            FRel.AddCel(transform(vlrvenda,f_cr));
            FRel.AddCel('');
            FRel.AddCel(transform(vlrvenda,f_cr));
          end;
// 02.06.16
          if qtdevenda>0 then unitariomedio:=vlrvenda/qtdevenda else unitariomedio:=0;
          if pecasvenda>0 then pesomedio:=qtdevenda/pecasvenda else pesomedio:=0;
          FRel.AddCel(transform(pecasvenda,f_integer));
          FRel.AddCel(transform(unitariomedio,f_cr));
          FRel.AddCel(transform(pesomedio,f_cr));

        end else begin
//          FRel.AddCel('');
//          FRel.AddCel('');
          FRel.AddCel(transform(Q.fieldbyname('qtde').ascurrency,f_qtdestoque));
          FRel.AddCel(transform(Q.fieldbyname('vlrvenda').ascurrency,f_cr));
          qtdedevo:=0;
          vlrdevo:=0;
          Checadevolucao;
// 24.06.13 - vivan - algumas DV foram gravadas com valor unitario zerado entao pego
//        pelo pre�o da venda;;;
// 10.04.14 - Novicarnes - retirado..nao bate com o rel. faturamento
//          vlrdevo:=qtdedevo*(Q.fieldbyname('vlrvenda').ascurrency/Q.fieldbyname('qtde').ascurrency);
//          vlrdevo:=qtdedevo*FEstoque.GetPreco(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring);
          FRel.AddCel(transform(qtdedevo,f_qtdestoque));
          FRel.AddCel(transform(vlrdevo,f_cr));
//          qtdevenda:=0;
//          vlrvenda:=0;
// 09.04.15
          qtdevenda:=Q.fieldbyname('qtde').ascurrency-qtdedevo;
          vlrvenda:=Q.fieldbyname('vlrvenda').ascurrency-vlrdevo;
          pecasvenda:=Q.fieldbyname('pecas').ascurrency-qtdedevo;
          FRel.AddCel(transform(qtdevenda,f_qtdestoque));
          FRel.AddCel(transform(vlrvenda,f_cr));
// 02.06.16
          if qtdevenda>0 then unitariomedio:=vlrvenda/qtdevenda else unitariomedio:=0;
          if pecasvenda>0 then pesomedio:=qtdevenda/pecasvenda else pesomedio:=0;
          FRel.AddCel(transform(pecasvenda,f_integer));
          FRel.AddCel(transform(unitariomedio,f_cr));
          FRel.AddCel(transform(pesomedio,f_cr));
        end;
        Q.Next;
      end;
///////// 10.04.14
      QDevo.First;
      while not QDevo.Eof do begin
//        if ListaImpressos.Indexof(QDevo.fieldbyname( campo ).asstring)=-1 then begin
// 17.07.15 - Iso pego....
        If ListaImpressos.IndexOf(QDevo.fieldbyname( campo ).asstring+QDevo.fieldbyname( campo1 ).asstring+QDevo.fieldbyname( campo2 ).asstring)=-1 then begin
          FRel.AddCel(QDevo.fieldbyname('move_unid_codigo').asstring+'D');
          if EdTipocad.text='C' then begin
            FRel.AddCel( '' );
            FRel.AddCel( '' );
            FRel.AddCel(QDevo.fieldbyname('move_tipo_codigo').asstring);
            FRel.AddCel(FCadcli.GetNome(QDevo.fieldbyname('move_tipo_codigo').asinteger));
            FRel.AddCel( '' );
          end else begin
            FRel.AddCel( inttostr(FEstoque.getgrupo(QDevo.fieldbyname('move_esto_codigo').asstring) ) );
            FRel.AddCel(FGrupos.GetDescricao(FEstoque.getgrupo(QDevo.fieldbyname('move_esto_codigo').asstring)));
            FRel.AddCel(QDevo.fieldbyname('move_esto_codigo').asstring);
            FRel.AddCel(FEstoque.GetDescricao(QDevo.fieldbyname('move_esto_codigo').asstring));
// 09.04.15 - devereda
            Frel.addcel(FTamanhos.getdescricao(QDevo.fieldbyname('move_tama_codigo').asinteger));
            Frel.addcel(Fcores.getdescricao(QDevo.fieldbyname('move_core_codigo').asinteger));

            FRel.AddCel(FEstoque.GetUnidade(QDevo.fieldbyname('move_esto_codigo').asstring));
          end;
          if EdConsFinal.Text='S' then begin
            FRel.AddCel(QDevo.fieldbyname('clie_consfinal').AsString);
            if QDevo.fieldbyname('clie_consfinal').AsString='S' then begin
              FRel.AddCel('');
              FRel.AddCel('');
            end else begin
              FRel.AddCel(transform(QDevo.fieldbyname('qtde').asfloat,f_qtdestoque));
              FRel.AddCel(transform(QDevo.fieldbyname('vlrvenda').asfloat,f_cr));
            end;
            qtdedevo:=QDevo.fieldbyname('qtde').asfloat;
            pecasdevo:=QDevo.fieldbyname('pecas').asfloat;
            vlrdevo:=QDevo.fieldbyname('vlrvenda').asfloat;
//            Checadevolucao;
            FRel.AddCel(transform(qtdedevo,f_qtdestoque));
            FRel.AddCel(transform(vlrdevo,f_cr));
            qtdevenda:=0;
            vlrvenda:=0;
            if Qdevo.fieldbyname('clie_consfinal').AsString='S' then begin
              FRel.AddCel('');
              FRel.AddCel('');
              FRel.AddCel(transform(qtdevenda,f_qtdestoque));
              FRel.AddCel(transform(vlrvenda,f_cr));
            end else begin
              FRel.AddCel(transform(qtdevenda,f_qtdestoque));
              FRel.AddCel(transform(vlrvenda,f_cr));
              FRel.AddCel('');
              FRel.AddCel(transform(vlrvenda,f_cr));
            end;
// 02.06.16
            if qtdevenda>0 then unitariomedio:=vlrvenda/qtdevenda else unitariomedio:=0;
            if pecasvenda>0 then pesomedio:=qtdevenda/pecasvenda else pesomedio:=0;
            FRel.AddCel(transform(pecasvenda,f_integer));
            FRel.AddCel(transform(unitariomedio,f_cr));
            FRel.AddCel(transform(pesomedio,f_cr));
          end else begin
            FRel.AddCel('');
            FRel.AddCel('');
            qtdedevo:=QDevo.fieldbyname('qtde').asfloat;
            pecasdevo:=QDevo.fieldbyname('pecas').asfloat;
            vlrdevo:=QDevo.fieldbyname('vlrvenda').asfloat;
            FRel.AddCel(transform(qtdedevo,f_qtdestoque));
            FRel.AddCel(transform(vlrdevo,f_cr));
//            qtdevenda:=0;
//            vlrvenda:=0;
// 17.07.15
            qtdevenda:=(-1)*qtdedevo;
            pecasvenda:=(-1)*pecasdevo;
            vlrvenda:=(-1)*vlrdevo;
            FRel.AddCel(transform(qtdevenda,f_qtdestoque));
            FRel.AddCel(transform(vlrvenda,f_cr));
// 02.06.16
            if qtdevenda>0 then unitariomedio:=vlrvenda/qtdevenda else unitariomedio:=0;
            if pecasvenda>0 then pesomedio:=qtdevenda/pecasvenda else pesomedio:=0;
            FRel.AddCel(transform(pecasvenda,f_integer));
            FRel.AddCel(transform(unitariomedio,f_cr));
            FRel.AddCel(transform(pesomedio,f_cr));
          end;
        end;
        QDevo.Next
      end;
      ListaImpressos.Free;
      if EdTipocad.text<>'C' then
        FRel.setsort('Grupo');
      FRel.Video;
      Q.close;
      Freeandnil(Q);
      FGeral.FechaQuery(QDevo);

    end;

    Sistema.EndProcess('');
    FRelGerenciais_VendasProdutoQtde;          // 22

  end;

end;



procedure TFRelGerenciais.EdDepositofExitEdit(Sender: TObject);
begin
   baplicarclick(FRelgerenciais);
end;

procedure TFRelGerenciais.PoeLista(tipomov,transacao: string);
/////////////////////////////////////////////////////////////
begin
        New(PRegistro);
        PRegistro.tipomov:=tipomov;
        pRegistro.transacao:=transacao;
        listaregistro.add(pregistro);
end;


procedure TFRelGerenciais.Baixadocumentos(Lista: TList);
var x:integer;
    status:string;
begin
  for x:=0 to Lista.count-1 do begin
    PRegistro:=Lista[x];
    if trim(Pregistro.transacao)<>'' then begin
      if pos( Pregistro.tipomov,Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca ) >0 then
        status:='D'
      else
        status:='E';
      Sistema.Edit('movesto');
      Sistema.Setfield('moes_status',status);
      Sistema.post('moes_transacao='+stringtosql(Pregistro.transacao)+'and moes_tipomov='+stringtosql(PRegistro.tipomov));
      Sistema.Edit('movestoque');
      Sistema.Setfield('move_status',status);
      Sistema.post('move_transacao='+stringtosql(Pregistro.transacao)+'and move_tipomov='+stringtosql(PRegistro.tipomov));
    end;
  end;
  if lista.count>0 then begin
    Sistema.beginprocess('Baixando documentos');
    Sistema.commit;
    Sistema.endprocess('Documentos baixados');
  end;
end;

// 24.11.05
procedure FRelGerenciais_AtendimentoPedidos;         // 24
var Q:TSqlquery;
    sqlsisvendas,titulo,subtit:string;
    percaten:currency;

begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(24) then Exit;
    sistema.beginprocess('separando quantidade vendida por produto');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('mpdd_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if EdTipomov.isempty then begin
      sqltipomovto:=''
    end else begin
      sqltipomovto:=' and '+FGeral.getin('mpdd_tipomov',Edtipomov.text,'C');
    end;
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      if Edtipocad.text='R' then
        sqlcodtipo:=' and mpdd_repr_codigo='+EdCodtipo.assql
      else
        sqlcodtipo:=' and mpdd_tipo_codigo='+EdCodtipo.assql;
    end;
// 03.10.05
    if not EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.getin('mpdd_esto_codigo',EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
    if not EdSisvendas.isempty then
      sqlsisvendas:=' and '+FGEral.getin('esto_sisvendas',EdSisvendas.text,'C')
    else
      sqlsisvendas:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and mpdd_datacont>1';
// 27.05.10
//      sqldatacont:=' and mpdd_datacont > '+DateToSql(Global.DataMenorBanco);
// 28.01.15 - nos pedido naom tem '1 e 2'
      sqldatacont:='';

    sistema.beginprocess('separando quantidade vendida por produto');
    Q:=sqltoquery('select mpdd_unid_codigo,mpdd_repr_codigo,mpdd_datamvto,mpdd_dataenviada,mpdd_tipo_codigo,mpdd_numerodoc,sum(mpdd_qtde) as qtdpedida,sum(mpdd_qtdeenviada) as qtdentregue'+
                  ' from movpeddet '+
                  ' inner join movped on ( mped_transacao=mpdd_transacao and mped_tipomov=mpdd_tipomov and mped_numerodoc=mpdd_numerodoc and mped_status=mpdd_status)'+
                  ' inner join estoque on ( esto_codigo=mpdd_esto_codigo )'+
//                  ' where mpdd_datamvto>='+EdDatai.AsSql+' and mpdd_datamvto<='+EdDataf.AsSql+
                  ' where mpdd_dataenviada>='+EdDatai.AsSql+' and mpdd_dataenviada<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqlsisvendas+   // 01.02.06
                  sqldatacont+
                  ' and '+FGeral.Getin('mpdd_status','N','C')+
                  ' and '+FGeral.Getin('mpdd_situacao','E','C')+
                  ' group by mpdd_unid_codigo,mpdd_repr_codigo,mpdd_datamvto,mpdd_dataenviada,mpdd_tipo_codigo,mpdd_numerodoc'+
                  ' order by mpdd_unid_codigo,mpdd_repr_codigo,mpdd_datamvto,mpdd_dataenviada,mpdd_tipo_codigo,mpdd_numerodoc' );

    titulo:='Atendimento de Pedidos de '+FGeral.FormataData(Eddatai.asdate)+' a '+FGeral.FormataData(Eddataf.asdate)+
            ' - Tipos Impressos: '+EdTipomov.text;

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

      Sistema.BeginProcess('Gerando Relat�rio');
      if not EdSisvendas.isempty then
        subtit:=' - Sistemas de Venda escolhido(s): '+EdSisvendas.text
      else
        subtit:='';
      FRel.Init('RelAtendimentoPedidoVenda');
      FRel.AddTit('Relat�rio de Atendimentos dos Pedidos de Venda'+subtit);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Repres.'     ,''         ,'',false);
      FRel.AddCol(120,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Pedido'           ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Montagem'         ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Cliente'     ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Nome cliente'   ,''         ,'',false);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Nro de pedidos'   ,''         ,'',false);
      FRel.AddCol( 80,3,'N','' ,''              ,'Nro pedido'   ,''         ,'',false);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Solicitada'          ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Enviada'             ,''         ,'',False);
      FRel.AddCol( 80,3,'N','&'  ,''            ,'% Atend.'           ,''         ,'',False);
      FRel.AddCol( 80,3,'N','&' ,''             ,'Dias Atendimento'           ,''         ,'',False);

      while not Q.eof do begin

        FRel.AddCel(Q.fieldbyname('mpdd_unid_codigo').asstring);
        FRel.AddCel(Q.fieldbyname('mpdd_repr_codigo').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mpdd_repr_codigo').asinteger,'R','N'));
        FRel.AddCel(Q.fieldbyname('mpdd_datamvto').asstring);
        FRel.AddCel(Q.fieldbyname('mpdd_dataenviada').asstring);
        FRel.AddCel(Q.fieldbyname('mpdd_tipo_codigo').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mpdd_tipo_codigo').asinteger,'C','N'));
        FRel.AddCel('1');
        FRel.AddCel(Q.fieldbyname('mpdd_numerodoc').asstring);
        FRel.AddCel(formatfloat(f_cr,Q.fieldbyname('qtdpedida').ascurrency));
        FRel.AddCel(formatfloat(f_cr,Q.fieldbyname('qtdentregue').ascurrency));
        if Q.fieldbyname('qtdpedida').ascurrency>0 then begin
//          percaten:=(Q.fieldbyname('qtdentregue').ascurrency/Q.fieldbyname('qtdpedida').ascurrency)*100;
          percaten:=FGeral.GetPercAtendimento(Q.fieldbyname('qtdentregue').ascurrency,Q.fieldbyname('qtdpedida').ascurrency,Q.fieldbyname('mpdd_dataenviada').asdatetime-Q.fieldbyname('mpdd_datamvto').asdatetime)
        end else
          percaten:=0;
        FRel.AddCel(formatfloat(f_cr,percaten));
        FRel.AddCel(currtostr(Q.fieldbyname('mpdd_dataenviada').asdatetime-Q.fieldbyname('mpdd_datamvto').asdatetime));
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
    FRelGerenciais_AtendimentoPedidos;         // 24

  end;


end;

////////////////////// 30.11.05

procedure FRelGerenciais_PecasPendentes;         // 25
//////////////////////////////////////////////////////////////

var Q:TSqlquery;
    titulo,sqlsituacao:string;
    percaten:currency;
    codigo:integer;

    function Considerar(dias:currency):boolean;
    begin
      result:=false;
      if (dias<=FGeral.getconfig1asinteger('DIASPEDIDO')) and (FGeral.getconfig1asinteger('DIASPEDIDO')>0) then
        result:=true
      else if (FGeral.getconfig1asinteger('DIASPEDIDO')=0) then
        result:=true;
    end;


begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(25) then Exit;
    sistema.beginprocess('separando quantidade vendida por produto');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('mpdd_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if EdTipomov.isempty then begin
      sqltipomovto:=''
    end else begin
      sqltipomovto:=' and '+FGeral.getin('mpdd_tipomov',Edtipomov.text,'C');
    end;
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      if Edtipocad.text='R' then
        sqlcodtipo:=' and mpdd_repr_codigo='+EdCodtipo.assql
      else
        sqlcodtipo:=' and mpdd_tipo_codigo='+EdCodtipo.assql;
    end;
// 03.10.05
    if not EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.getin('mpdd_esto_codigo',EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and mpdd_datacont>1';
// 27.05.10
//      sqldatacont:='  and ( ( mpdd_datacont > '+DateToSql(Global.DataMenorBanco)+
//                   ' ) or (mpdd_datacont <> null) )'  ;
// 28.01.15 - nos pedido naom tem '1 e 2'
      sqldatacont:='';

// 05.04.06
    if EdCaoc_codigo.isempty then begin
      sqlmotivo:='';                       //               'E' pois pode ser entrega parcial do pedido
      sqlsituacao:=' and '+FGeral.Getin('mped_situacao','P;E','C');    // 04.08.06
    end else begin
      sqlmotivo:=' and '+FGeral.getin('mpdd_caoc_codigo',EdCaoc_codigo.text,'N');
// 04.08.06
      sqlsituacao:=' and '+FGeral.Getin('mped_situacao','E','C');
    end;
    Q:=sqltoquery('select mpdd_unid_codigo,mpdd_repr_codigo,mpdd_datamvto,mpdd_dataenviada,mpdd_tipo_codigo,mpdd_tipomov,'+
                  'mpdd_numerodoc,mpdd_esto_codigo,mpdd_core_codigo,mpdd_tama_codigo,mpdd_copa_codigo,mped_envio,sum(mpdd_qtde) as qtdpedida,sum(mpdd_qtdeenviada) as qtdentregue'+
                  ' from movpeddet '+
                  ' inner join movped on ( mped_transacao=mpdd_transacao and mped_tipomov=mpdd_tipomov and mped_numerodoc=mpdd_numerodoc)'+
//                  ' left join cadocorrencias on ( caoc_codigo=mpdd_caoc_codigo )'+
                  ' where mpdd_datamvto>='+EdDatai.AsSql+' and mpdd_datamvto<='+EdDataf.AsSql+
//                  ' where mpdd_dataenviada>='+EdDatai.AsSql+' and mpdd_dataenviada<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqldatacont+
                  sqlmotivo+
//                  ' and mped_envio<>''P'''+
// 29.08.06 -retirado
//                  ' and ( ( mpdd_qtde>mpdd_qtdeenviada and  mpdd_qtdeenviada>0 ) or (mpdd_qtdeenviada=0)  )'+
                  ' and '+FGeral.Getin('mpdd_status','N','C')+
//                  ' and '+FGeral.Getin('mpdd_situacao','P;E','C')+
// 01.08.06 - checava somente se qtde entregue menor q pedida sem ver status
//                  ' and '+FGeral.Getin('mpdd_situacao','P','C')+
// 04.08.06
                  sqlsituacao+
//                  ' and ( mpdd_caoc_codigo=0 or mpdd_caoc_codigo is null)'+
                  ' group by mpdd_unid_codigo,mpdd_repr_codigo,mpdd_tipo_codigo,mpdd_datamvto,mpdd_dataenviada,mpdd_tipomov,mpdd_numerodoc,mpdd_esto_codigo,mpdd_core_codigo,mpdd_tama_codigo,mpdd_copa_codigo,mped_envio'+
//                  ' order by mpdd_unid_codigo,mpdd_repr_codigo,mpdd_datamvto,mpdd_dataenviada,mpdd_tipo_codigo,mpdd_tipomov,mpdd_numerodoc,mpdd_esto_codigo,mpdd_core_codigo,mpdd_tama_codigo,mpdd_copa_codigo,mped_envio' );
// 30.08.06
                  ' order by mpdd_unid_codigo,mpdd_repr_codigo,mpdd_tipo_codigo,mpdd_datamvto,mpdd_dataenviada,mpdd_tipomov,mpdd_numerodoc,mpdd_esto_codigo,mpdd_core_codigo,mpdd_tama_codigo,mpdd_copa_codigo,mped_envio' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

      Sistema.BeginProcess('Gerando Relat�rio');
      FRel.Init('RelPecasPendentes');
//      FRel.AddTit('Relat�rio de Pe�as Pendentes dos Pedidos de Venda - Sem considerar PAC'+Gettitmotivos);
      FRel.AddTit('Relat�rio de Pe�as Pendentes dos Pedidos de Venda '+Gettitmotivos);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Repres.'     ,''         ,'',false);
      FRel.AddCol(120,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Pedido'           ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Montagem'         ,''         ,'',false);
      FRel.AddCol( 80,1,'N','' ,''              ,'Nro pedido'   ,''         ,'',false);
      FRel.AddCol( 40,1,'C','' ,''              ,'Envio'           ,''         ,'',false);
      FRel.AddCol( 40,1,'C','' ,''              ,'Tipo'           ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Cliente'     ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Nome cliente'   ,''         ,'',false);
      FRel.AddCol(090,1,'N','' ,''              ,'Produto'   ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Descri��o Produto'   ,''         ,'',false);
      FRel.AddCol(060,1,'C','' ,''              ,'Tamanho'             ,''         ,'',false);
      FRel.AddCol(110,1,'C','' ,''              ,'Cor'                 ,''         ,'',false);
//      FRel.AddCol(060,1,'C','' ,''              ,'Copa'                ,''         ,'',false);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Solicitada'          ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Enviada'             ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'A Entregar'               ,''         ,'',False);
      codigo:=0;

      while not Q.eof do begin

        codigo:=Q.fieldbyname('mpdd_tipo_codigo').asinteger;
        if Considerar(Q.fieldbyname('mpdd_dataenviada').asdatetime-Q.fieldbyname('mpdd_datamvto').asdatetime) then begin
          FRel.AddCel(Q.fieldbyname('mpdd_unid_codigo').asstring);
          FRel.AddCel(Q.fieldbyname('mpdd_repr_codigo').asstring);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mpdd_repr_codigo').asinteger,'R','N'));
          FRel.AddCel(Q.fieldbyname('mpdd_datamvto').asstring);
          FRel.AddCel(Q.fieldbyname('mpdd_dataenviada').asstring);
          FRel.AddCel(Q.fieldbyname('mpdd_numerodoc').asstring);
          FRel.AddCel(Q.fieldbyname('mped_envio').asstring);
          FRel.AddCel(Q.fieldbyname('mpdd_tipomov').asstring);
          FRel.AddCel(Q.fieldbyname('mpdd_tipo_codigo').asstring);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mpdd_tipo_codigo').asinteger,'C','N'));
          FRel.AddCel(Q.fieldbyname('mpdd_esto_codigo').asstring);
          FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('mpdd_esto_codigo').asstring));
          FRel.AddCel(FTamanhos.GetDescricao(Q.fieldbyname('mpdd_tama_codigo').asinteger));
          FRel.AddCel(FCores.GetDescricao(Q.fieldbyname('mpdd_core_codigo').asinteger));
//          FRel.AddCel(FCopas.GetDescricao(Q.fieldbyname('mpdd_copa_codigo').asinteger));
          FRel.AddCel(formatfloat(f_cr,Q.fieldbyname('qtdpedida').ascurrency));
          FRel.AddCel(formatfloat(f_cr,Q.fieldbyname('qtdentregue').ascurrency));
          FRel.AddCel(formatfloat(f_cr,Q.fieldbyname('qtdpedida').ascurrency-Q.fieldbyname('qtdentregue').ascurrency));
        end;
        Q.Next;
        if (codigo<>Q.fieldbyname('mpdd_tipo_codigo').asinteger) and ( not Q.eof ) then
          FGeral.PulalinhaRel(17);

      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
    FRelGerenciais_PecasPendentes;         // 25

  end;


end;

procedure FRelGerenciais_PedidosVenda;         // 26
//////////////////////////////////////////
var Q,
    QR                      :TSqlquery;
    titulo,partesql,emaberto:string;
    percaten:currency;
    atendimento:TDatetime;

    function GetQtdePedido(pedido:integer):currency;
    ///////////////////////////////////////////////////
    var QP:TSqlquery;
    begin
       QP:=sqltoquery('select sum(mpdd_qtde) as qtde from movpeddet where mpdd_status=''N'' and mpdd_numerodoc='+inttostr(pedido));
       result:=QP.fieldbyname('qtde').ascurrency;
       QP.close;Freeandnil(Qp);
    end;

    function GetAtendimentoPedido(pedido:integer):TDatetime;
    /////////////////////////////////////////////////////////////
    var QP:TSqlquery;
    begin
       result:=0;
       QP:=sqltoquery('select mpdd_dataenviada as data from movpeddet where mpdd_status=''N'' and mpdd_numerodoc='+inttostr(pedido)+
                      ' and mpdd_dataenviada > '+DatetoSql(Global.DataMenorBanco) );

       if not QP.eof then begin
         result:=QP.fieldbyname('data').asdatetime
       end;
       QP.close;Freeandnil(Qp);
    end;

begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(26) then Exit;
    sistema.beginprocess('separando os pedidos de venda');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('mped_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if EdTipomov.isempty then begin
      sqltipomovto:=''
    end else begin
      sqltipomovto:=' and '+FGeral.getin('mped_tipomov',Edtipomov.text,'C');
    end;
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      if Edtipocad.text='R' then
        sqlcodtipo:=' and mped_repr_codigo='+EdCodtipo.assql
      else
        sqlcodtipo:=' and mped_tipo_codigo='+EdCodtipo.assql;
    end;
// 03.10.05
//    if not EdEsto_codigo.isempty then
//      sqlproduto:=' and '+FGeral.getin('mpdd_esto_codigo',EdEsto_codigo.text,'C')
//    else
      sqlproduto:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and mped_datacont>1';
// 27.05.10
//      sqldatacont:=' and mped_datacont > '+DateToSql(Global.DataMenorBanco);
// 28.01.15
      sqldatacont:='';
// 16.07.14 - Devereda - Linda
   if (fRelgerenciais.EdEmaberto.text='A') then
     partesql:=' and ( mped_nfvenda=0 or mped_nfvenda is null )'+
             ' and mped_situacao=''P''' 
   else
     partesql:='';

    Q:=sqltoquery('select * from movped'+
                  ' where mped_datamvto>='+EdDatai.AsSql+' and mped_datamvto<='+EdDataf.AsSql+
//                  ' where mpdd_dataenviada>='+EdDatai.AsSql+' and mpdd_dataenviada<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqldatacont+
                  partesql+
                  ' and '+FGeral.Getin('mped_status','N,X','C')+
//                  ' and '+FGeral.Getin('mpdd_situacao','E','C')+
                  ' order by mped_unid_codigo,mped_repr_codigo,mped_datamvto,mped_tipo_codigo,mped_numerodoc' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

      Sistema.BeginProcess('Gerando Relat�rio');
      FRel.Init('RelPedidosVenda');
      FRel.AddTit('Relat�rio de Pedidos de Venda');
      emaberto:='';
      if (fRelgerenciais.EdEmaberto.text='A') then
        emaberto:=' - Somente EM ABERTO';
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate)+emaberto);
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Repres.'     ,''         ,'',false);
      FRel.AddCol(120,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Cliente'     ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Nome cliente'   ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Data'           ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Atendimento'     ,''         ,'',false);
      FRel.AddCol( 60,3,'N','' ,''              ,'Nro pedido'   ,''         ,'',false);
      FRel.AddCol( 40,1,'C','' ,''              ,'Tipo'   ,''         ,'',false);
      FRel.AddCol( 80,1,'C','' ,''              ,'Forma Contato'   ,''         ,'',false);
      FRel.AddCol( 80,1,'C','' ,''              ,'Forma Envio'     ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Contato'     ,''         ,'',false);
      FRel.AddCol( 80,1,'C','' ,''              ,'Condi��o'    ,''         ,'',false);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Total'             ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Pe�as Total'             ,''         ,'',False);
      FRel.AddCol( 60,1,'C','' ,''              ,'Situa��o'         ,''         ,'',false);
      FRel.AddCol( 80,1,'C','' ,''              ,'Cidade'         ,''         ,'',false);
      FRel.AddCol( 40,1,'C','' ,''              ,'UF'         ,''         ,'',false);
      FRel.AddCol( 80,1,'C','' ,''              ,'Usu�rio '               ,''         ,'',false);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Canc.'             ,''         ,'',False);
      FRel.AddCol(100,1,'C','' ,''              ,'Motivo Canc.'           ,''         ,'',false);
      FRel.AddCol( 80,1,'C','' ,''              ,'Usu�rio Autor.'               ,''         ,'',false);
      FRel.AddCol(200,1,'C','' ,''              ,'Motivo Autoriza��o'           ,''         ,'',false);
// 08.02.19 - Seip
      FRel.AddCol(080,3,'N','+' ,''             ,'Parcela 1'            ,''         ,'',false);
      FRel.AddCol(080,3,'N','' ,''              ,'Vencimento 1'            ,''         ,'',false);
      FRel.AddCol(080,3,'N','+' ,''             ,'Parcela 2'            ,''         ,'',false);
      FRel.AddCol(080,3,'N','' ,''              ,'Vencimento 2'            ,''         ,'',false);
      FRel.AddCol(080,3,'N','+' ,''             ,'Parcela 3'            ,''         ,'',false);
      FRel.AddCol(080,3,'N','' ,''              ,'Vencimento 3'            ,''         ,'',false);

      while not Q.eof do begin

          FRel.AddCel(Q.fieldbyname('mped_unid_codigo').asstring);
          FRel.AddCel(Q.fieldbyname('mped_repr_codigo').asstring);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mped_repr_codigo').asinteger,'R','N'));
          FRel.AddCel(Q.fieldbyname('mped_tipo_codigo').asstring);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mped_tipo_codigo').asinteger,'C','N'));
          FRel.AddCel(Q.fieldbyname('mped_datamvto').asstring);
          atendimento:=GetAtendimentoPedido(Q.fieldbyname('mped_numerodoc').asinteger);
          if atendimento>1 then
            FRel.AddCel(FGeral.formatadata(Atendimento))
          else
            FRel.AddCel('');
          FRel.AddCel(Q.fieldbyname('mped_numerodoc').asstring);
          FRel.AddCel(Q.fieldbyname('mped_tipomov').asstring);
          FRel.AddCel(FGeral.GetFormaPedido(Q.fieldbyname('mped_formaped').asstring));
          FRel.AddCel(FGeral.GetFormaEnvio(Q.fieldbyname('mped_envio').asstring));
          FRel.AddCel(Q.fieldbyname('mped_contatopedido').asstring);
          FRel.AddCel(Q.fieldbyname('mped_fpgt_prazos').asstring);
          if Q.fieldbyname('mped_status').asstring<>'X' then begin
            FRel.AddCel(formatfloat(f_cr,Q.fieldbyname('mped_vlrtotal').ascurrency));
            FRel.AddCel( formatfloat(f_cr,GetQtdePedido(Q.fieldbyname('mped_numerodoc').asinteger)) );
          end else begin
            FRel.AddCel('');
            FRel.AddCel('');
          end;
//          FRel.AddCel(Q.fieldbyname('mped_situacao').asstring);
// 28.01.19 - Seip
          if Q.fieldbyname('mped_situacao').asstring='F' then
             FRel.AddCel( 'FECHADO' )
          else
             FRel.AddCel('EM ABERTO');

          FRel.AddCel(FCadCli.GetCidade( Q.fieldbyname('mped_tipo_codigo').asinteger) );
          FRel.AddCel(FCadCli.Getuf( Q.fieldbyname('mped_tipo_codigo').asinteger) );
          if Q.fieldbyname('mped_status').asstring<>'X' then begin
            FRel.AddCel(FUsuarios.GetNome( Q.fieldbyname('mped_usua_codigo').asinteger) );
            FRel.AddCel('');
            FRel.AddCel('');
          end else begin
            FRel.AddCel(FUsuarios.GetNome( Q.fieldbyname('mped_usua_cancela').asinteger) );
            FRel.AddCel(formatfloat(f_cr,Q.fieldbyname('mped_vlrtotal').ascurrency));
            FRel.AddCel(FCadocorrencias.GetDescricao( FOcorrencias.GetCodigoOcorrencia('C',Q.fieldbyname('mped_tipo_codigo').asinteger,
                        Q.fieldbyname('mped_numerodoc').asinteger,Q.fieldbyname('mped_datamvto').asdatetime ) ) );
          end;
          FRel.AddCel(FUsuarios.GetNome( Q.fieldbyname('mped_usualibcred').asinteger) );
          FRel.AddCel(Q.fieldbyname('mped_obslibcredito').asstring);
// 08.02.19 - busca parcelas
          Qr:=sqltoquery('select pend_datavcto,pend_valor from pendencias where pend_transacao = '+
                         stringtosql( Q.fieldbyname('mped_transacao').asstring )+
                         ' and pend_status = ''H'' order by pend_datavcto');
          if Qr.eof then  begin

             FRel.Addcel('');
             FRel.Addcel('');
             FRel.Addcel('');
             FRel.Addcel('');
             FRel.Addcel('');
             FRel.Addcel('');

          end else begin


             FRel.Addcel( FGeral.Formatavalor( Qr.fieldbyname('pend_valor').ascurrency,f_cr) );
             FRel.Addcel( Qr.fieldbyname('pend_datavcto').asstring );
             Qr.Next;
             if not Qr.Eof then  begin

                FRel.Addcel( FGeral.Formatavalor( Qr.fieldbyname('pend_valor').ascurrency,f_cr) );
                FRel.Addcel( Qr.fieldbyname('pend_datavcto').asstring );
                Qr.Next;
                if not Qr.Eof then  begin
                    FRel.Addcel( FGeral.Formatavalor( Qr.fieldbyname('pend_valor').ascurrency,f_cr) );
                    FRel.Addcel( Qr.fieldbyname('pend_datavcto').asstring );
                end else begin
                    FRel.Addcel('');
                    FRel.Addcel('');
                end;

             end else begin

                FRel.Addcel('');
                FRel.Addcel('');
                FRel.Addcel('');
                FRel.Addcel('');

             end;
          end;
          FGeral.FechaQuery(Qr);
        Q.Next;

      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
    FRelGerenciais_PedidosVenda;         // 26

  end;


end;


procedure FRelGerenciais_PedidosProdutos(Tiporel:string);      // 27
var Q:TSqlquery;
    titulo:string;
    percaten:currency;


begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(27) then Exit;
    sistema.beginprocess('separando quantidade vendida por produto');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('mpdd_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if EdTipomov.isempty then begin
      sqltipomovto:=''
    end else begin
      sqltipomovto:=' and '+FGeral.getin('mpdd_tipomov',Edtipomov.text,'C');
    end;
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      if Edtipocad.text='R' then
        sqlcodtipo:=' and mpdd_repr_codigo='+EdCodtipo.assql
      else
        sqlcodtipo:=' and mpdd_tipo_codigo='+EdCodtipo.assql;
    end;
// 03.10.05
    if not EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.getin('mpdd_esto_codigo',EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and mpdd_datacont>1';
// 27.05.10
//      sqldatacont:=' and mpdd_datacont > '+DateToSql(Global.DataMenorBanco);
      sqldatacont:='';

    if Tiporel='P' then begin   // produto
      Q:=sqltoquery('select mpdd_unid_codigo,mpdd_esto_codigo,mpdd_core_codigo,mpdd_tama_codigo,sum(mpdd_qtde) as qtdpedida,sum(mpdd_qtdeenviada) as qtdentregue,'+
//                  ' sum(mped_vlrtotal) as vlrtotal from movpeddet '+
                  ' sum(mpdd_venda*mpdd_qtde) as vlrtotal from movpeddet '+
                  ' inner join movped on ( mped_transacao=mpdd_transacao and mped_tipomov=mpdd_tipomov and mped_numerodoc=mpdd_numerodoc)'+
                  ' where mpdd_datamvto>='+EdDatai.AsSql+' and mpdd_datamvto<='+EdDataf.AsSql+
//                  ' where mpdd_dataenviada>='+EdDatai.AsSql+' and mpdd_dataenviada<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqldatacont+
                  ' and mpdd_qtdeenviada>0 '+
                  ' and '+FGeral.Getin('mpdd_status','N','C')+
                  ' and '+FGeral.Getin('mpdd_situacao','E','C')+
                  ' group by mpdd_unid_codigo,mpdd_esto_codigo,mpdd_core_codigo,mpdd_tama_codigo'+
                  ' order by mpdd_unid_codigo,mpdd_esto_codigo,mpdd_core_codigo,mpdd_tama_codigo' );
      titulo:='Relat�rio de Produtos mais vendidos por Produto';
    end else begin  // por representante + produto
      Q:=sqltoquery('select mpdd_unid_codigo,mpdd_repr_codigo,mpdd_esto_codigo,mpdd_core_codigo,mpdd_tama_codigo,sum(mpdd_qtde) as qtdpedida,sum(mpdd_qtdeenviada) as qtdentregue,'+
                  ' sum(mpdd_venda*mpdd_qtde) as vlrtotal from movpeddet '+
//                  ' sum(mped_vlrtotal) as vlrtotal from movpeddet '+
                  ' inner join movped on ( mped_transacao=mpdd_transacao and mped_tipomov=mpdd_tipomov and mped_numerodoc=mpdd_numerodoc)'+
                  ' where mpdd_datamvto>='+EdDatai.AsSql+' and mpdd_datamvto<='+EdDataf.AsSql+
//                  ' where mpdd_dataenviada>='+EdDatai.AsSql+' and mpdd_dataenviada<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqldatacont+
                  ' and mpdd_qtdeenviada>0 '+
                  ' and '+FGeral.Getin('mpdd_status','N','C')+
                  ' and '+FGeral.Getin('mpdd_situacao','E','C')+
                  ' group by mpdd_unid_codigo,mpdd_repr_codigo,mpdd_esto_codigo,mpdd_core_codigo,mpdd_tama_codigo'+
                  ' order by mpdd_unid_codigo,mpdd_repr_codigo,mpdd_esto_codigo,mpdd_core_codigo,mpdd_tama_codigo' );
      titulo:='Relat�rio de Produtos mais vendidos por Representante + Produto';
    end;

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

      Sistema.BeginProcess('Gerando Relat�rio');
      FRel.Init('RelPedidosProdutos');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      if tiporel='P' then begin
        FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      end else begin
        FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Repres.'     ,''         ,'',false);
        FRel.AddCol(120,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
      end;
      FRel.AddCol(090,1,'N','' ,''              ,'Produto'   ,''         ,'',false);
      FRel.AddCol(200,1,'C','' ,''              ,'Descri��o Produto'   ,''         ,'',false);
      FRel.AddCol(090,1,'C','' ,''              ,'Tamanho'             ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Cor'                 ,''         ,'',false);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Pedida'         ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Valor Total'         ,''         ,'',False);

      while not Q.eof do begin

        if tiporel='P' then begin
           FRel.AddCel(Q.fieldbyname('mpdd_unid_codigo').asstring);
        end else begin
          FRel.AddCel(Q.fieldbyname('mpdd_repr_codigo').asstring);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mpdd_repr_codigo').asinteger,'R','N'));
        end;
//          FRel.AddCel(Q.fieldbyname('mpdd_datamvto').asstring);
//          FRel.AddCel(Q.fieldbyname('mpdd_dataenviada').asstring);
//          FRel.AddCel(Q.fieldbyname('mpdd_tipo_codigo').asstring);
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mpdd_tipo_codigo').asinteger,'C','N'));
//          FRel.AddCel(Q.fieldbyname('mpdd_numerodoc').asstring);
          FRel.AddCel(Q.fieldbyname('mpdd_esto_codigo').asstring);
          FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('mpdd_esto_codigo').asstring));
          FRel.AddCel(FTamanhos.GetDescricao(Q.fieldbyname('mpdd_tama_codigo').asinteger));
          FRel.AddCel(FCores.GetDescricao(Q.fieldbyname('mpdd_core_codigo').asinteger));
          FRel.AddCel(formatfloat(f_cr,Q.fieldbyname('qtdpedida').ascurrency));
          FRel.AddCel(formatfloat(f_cr,Q.fieldbyname('vlrtotal').ascurrency));
//          FRel.AddCel(formatfloat(f_cr,Q.fieldbyname('qtdentregue').ascurrency));

        Q.Next;

      end;
      if tiporel='P' then
        FRel.Setsort('Valor Total',false)
      else if (EdCodtipo.asinteger>0) then
        FRel.Setsort('Valor Total',false);
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

    FRelGerenciais_PedidosProdutos(Tiporel);      // 27

  end;


end;

// 01.02.06
procedure FRelGerenciais_AtendimentoPedidosProdutos;         // 28
type TRegistro=record
     codrepr,qtdepedidos:integer;
     qtdepedida,qtdeenviada:currency;
     produto,unid_codigo:string;
     ListadosPedidos:Tstringlist;
end;

var Q:TSqlquery;
    sqlsisvendas,titulo,subtit:string;
    percaten:currency;
    Lista,ListaPedidos:Tlist;
    p:integer;
    PRegistro:^TRegistro;

    function Considerar(dias:currency):boolean;
    begin
      result:=false;
      if (dias<=FGeral.getconfig1asinteger('DIASPEDIDO')) and (FGeral.getconfig1asinteger('DIASPEDIDO')>0) then
        result:=true
      else if (FGeral.getconfig1asinteger('DIASPEDIDO')=0) then
        result:=true;
    end;

    procedure Atualiza(codrepr,numerodoc:integer; produto,unid_codigo:string ; qtde,qtdeenviada:currency );
    var x,y:integer;
        achou:boolean;
    begin
      achou:=false;
      for x:=0 to Lista.count-1 do begin
        PRegistro:=Lista[x];
        if FRelgerenciais.EdSinana.text='A' then begin   // com os produtos
          if (Pregistro.unid_codigo=unid_codigo) and (Pregistro.codrepr=codrepr) and (Pregistro.produto=produto ) then begin
            achou:=true;
            break;
          end;
        end else begin
          if (Pregistro.unid_codigo=unid_codigo) and (Pregistro.codrepr=codrepr) then begin
            achou:=true;
            break;
          end;
        end;
      end;
      if not achou then begin
        New(PRegistro);
        PRegistro.ListadosPedidos:=Tstringlist.create;
        Pregistro.unid_codigo:=unid_codigo;
        Pregistro.codrepr:=codrepr;
        Pregistro.produto:=produto;
        Pregistro.qtdepedida:=qtde;
        Pregistro.qtdeenviada:=qtdeenviada;
        Pregistro.ListadosPedidos.add(inttostr(numerodoc));
        Lista.add(PRegistro);
      end else begin
        PRegistro.qtdepedida:=PRegistro.qtdepedida+qtde;
        PRegistro.qtdeenviada:=PRegistro.qtdeenviada+qtdeenviada;
        if Pregistro.ListadosPedidos.indexof( inttostr(numerodoc) )=-1 then
          Pregistro.ListadosPedidos.add(inttostr(numerodoc));
      end;

    end;

begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(28) then Exit;
    sistema.beginprocess('separando quantidade vendida por produto');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('mpdd_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if EdTipomov.isempty then begin
      sqltipomovto:=''
    end else begin
      sqltipomovto:=' and '+FGeral.getin('mpdd_tipomov',Edtipomov.text,'C');
    end;
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      if Edtipocad.text='R' then
        sqlcodtipo:=' and mpdd_repr_codigo='+EdCodtipo.assql
      else
        sqlcodtipo:=' and mpdd_tipo_codigo='+EdCodtipo.assql;
    end;
// 03.10.05
    if not EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.getin('mpdd_esto_codigo',EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
    if not EdSisvendas.isempty then
      sqlsisvendas:=' and '+FGEral.getin('esto_sisvendas',EdSisvendas.text,'C')
    else
      sqlsisvendas:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and mpdd_datacont>1';
// 27.05.10
//      sqldatacont:=' and mpdd_datacont > '+DateToSql(Global.DataMenorBanco);
// 28.01.15
      sqldatacont:='';
    sistema.beginprocess('separando quantidade vendida por produto');
    Lista:=TList.create;
    ListaPedidos:=TList.create;
//    Q:=sqltoquery('select mpdd_unid_codigo,mpdd_repr_codigo,mpdd_datamvto,mpdd_dataenviada,mpdd_esto_codigo,mpdd_numerodoc,sum(mpdd_qtde) as qtdpedida,sum(mpdd_qtdeenviada) as qtdentregue'+
{
    Q:=sqltoquery('select mpdd_unid_codigo,mpdd_repr_codigo,mpdd_esto_codigo,sum(mpdd_qtde) as qtdpedida,sum(mpdd_qtdeenviada) as qtdentregue'+
                  ' from movpeddet '+
                  ' inner join movped on ( mped_transacao=mpdd_transacao and mped_tipomov=mpdd_tipomov and mped_numerodoc=mpdd_numerodoc and mped_status=mpdd_status)'+
                  ' inner join estoque on ( esto_codigo=mpdd_esto_codigo )'+
//                  ' where mpdd_datamvto>='+EdDatai.AsSql+' and mpdd_datamvto<='+EdDataf.AsSql+
                  ' where mpdd_dataenviada>='+EdDatai.AsSql+' and mpdd_dataenviada<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqlsisvendas+   // 01.02.06
                  ' and '+FGeral.Getin('mpdd_status','N','C')+
                  ' and '+FGeral.Getin('mpdd_situacao','E','C')+
                  ' group by mpdd_unid_codigo,mpdd_repr_codigo,mpdd_esto_codigo'+
                  ' order by mpdd_unid_codigo,mpdd_repr_codigo,mpdd_esto_codigo' );
}
    Q:=sqltoquery('select * from movpeddet '+
                  ' inner join movped on ( mped_transacao=mpdd_transacao and mped_tipomov=mpdd_tipomov and mped_numerodoc=mpdd_numerodoc and mped_status=mpdd_status)'+
                  ' inner join estoque on ( esto_codigo=mpdd_esto_codigo )'+
                  ' where mpdd_dataenviada>='+EdDatai.AsSql+' and mpdd_dataenviada<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqlsisvendas+   // 01.02.06
                  sqldatacont+
                  ' and '+FGeral.Getin('mpdd_status','N','C')+
                  ' and '+FGeral.Getin('mpdd_situacao','E','C')+
                  ' order by mpdd_unid_codigo,mpdd_repr_codigo,mpdd_esto_codigo' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

      while not Q.eof do begin
        if Considerar(Q.fieldbyname('mpdd_dataenviada').asdatetime-Q.fieldbyname('mpdd_datamvto').asdatetime) then begin
          Atualiza(Q.fieldbyname('mpdd_repr_codigo').asinteger,Q.fieldbyname('mpdd_numerodoc').asinteger,
                 Q.fieldbyname('mpdd_esto_codigo').asstring,Q.fieldbyname('mpdd_unid_codigo').asstring,Q.fieldbyname('mpdd_qtde').ascurrency,
                 Q.fieldbyname('mpdd_qtdeenviada').ascurrency );
        end;
        Q.next;
      end;

      Sistema.BeginProcess('Gerando Relat�rio');
      if not EdSisvendas.isempty then
        subtit:=' - Sistemas de Venda escolhido(s): '+EdSisvendas.text
      else
        subtit:='';
      FRel.Init('RelAtendimentoPedidoVendaProduto');
      FRel.AddTit('Relat�rio de Atendimentos dos Pedidos de Venda por Produto'+subtit+' - Somente dentro dos '+inttostr(FGeral.getconfig1asinteger('DIASPEDIDO'))+' dias');
      if not EdCodtipo.isempty then
        FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+' '+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text)  )
      else
        FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Repres.'     ,''         ,'',false);
      FRel.AddCol(120,1,'C',''  ,''              ,'Representante'   ,''         ,'',false);
      if EdSinana.text='A' then
        FRel.AddCol( 80,3,'N','' ,''              ,'Qtde Pedidos'           ,''         ,'',false)
      else
        FRel.AddCol( 80,3,'N','+' ,''              ,'Qtde Pedidos'           ,''         ,'',false);
//      FRel.AddCol( 60,1,'D','' ,''              ,'Montagem'         ,''         ,'',false);
      if EdSinana.text='A' then begin   // com os produtos
        FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Produto'     ,''         ,'',false);
        FRel.AddCol(150,1,'C','' ,''              ,'Produto'        ,''         ,'',false);
      end;
//      FRel.AddCol( 80,3,'N','+' ,''             ,'Nro de pedidos'   ,''         ,'',false);
//      FRel.AddCol( 80,3,'N','' ,''              ,'Nro pedido'   ,''         ,'',false);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Solicitada'          ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Enviada'             ,''         ,'',False);
//      FRel.AddCol( 80,3,'N','&'  ,''            ,'% Atend.'           ,''         ,'',False);
//      FRel.AddCol( 80,3,'N','&' ,''             ,'Dias Atendimento'           ,''         ,'',False);

      for p:=0 to lista.count-1 do begin
        PRegistro:=Lista[p];
        FRel.AddCel(PRegistro.unid_codigo);
        FRel.AddCel( inttostr(PRegistro.codrepr) );
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(PRegistro.codrepr,'R','N'));
        FRel.AddCel(inttostr(Pregistro.ListadosPedidos.count));
//        FRel.AddCel(Q.fieldbyname('mpdd_dataenviada').asstring);
        if EdSinana.text='A' then begin   // com os produtos
          FRel.AddCel(PRegistro.produto);
          FRel.AddCel(FEstoque.GetDescricao(PRegistro.produto));
        end;
//        FRel.AddCel('1');
//        FRel.AddCel(Q.fieldbyname('mpdd_numerodoc').asstring);
        FRel.AddCel(formatfloat(f_cr,PRegistro.qtdepedida));
        FRel.AddCel(formatfloat(f_cr,PRegistro.qtdeenviada));
//        if Q.fieldbyname('qtdpedida').ascurrency>0 then begin
//          percaten:=(Q.fieldbyname('qtdentregue').ascurrency/Q.fieldbyname('qtdpedida').ascurrency)*100;
//          percaten:=FGeral.GetPercAtendimento(Q.fieldbyname('qtdentregue').ascurrency,Q.fieldbyname('qtdpedida').ascurrency,Q.fieldbyname('mpdd_dataenviada').asdatetime-Q.fieldbyname('mpdd_datamvto').asdatetime)
//        end else
//          percaten:=0;
//        FRel.AddCel(formatfloat(f_cr,percaten));
//        FRel.AddCel(currtostr(Q.fieldbyname('mpdd_dataenviada').asdatetime-Q.fieldbyname('mpdd_datamvto').asdatetime));
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
    FRelGerenciais_AtendimentoPedidosProdutos;         // 28

  end;


end;


procedure FRelGerenciais_ImpressaoPedidos;                   // 29

var Q:TSqlquery;
    titulo:string;
    percaten:currency;
    cliente:integer;

    function Considerar(dias:currency):boolean;
    begin
      result:=false;
      if (dias<=FGeral.getconfig1asinteger('DIASPEDIDO')) and (FGeral.getconfig1asinteger('DIASPEDIDO')>0) then
        result:=true
      else if (FGeral.getconfig1asinteger('DIASPEDIDO')=0) then
        result:=true;
    end;


begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(29) then Exit;
    sistema.beginprocess('separando quantidade vendida por produto');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('mpdd_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if EdTipomov.isempty then begin
      sqltipomovto:=''
    end else begin
      sqltipomovto:=' and '+FGeral.getin('mpdd_tipomov',Edtipomov.text,'C');
    end;
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      if Edtipocad.text='R' then
        sqlcodtipo:=' and mpdd_repr_codigo='+EdCodtipo.assql
      else
        sqlcodtipo:=' and mpdd_tipo_codigo='+EdCodtipo.assql;
    end;
// 03.10.05
    if not EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.getin('mpdd_esto_codigo',EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and mpdd_datacont>1';
// 27.05.10
//      sqldatacont:=' and mpdd_datacont > '+DateToSql(Global.DataMenorBanco);
// 28.01.15
      sqldatacont:='';

    Q:=sqltoquery('select * from movpeddet '+
                  ' inner join movped on ( mped_transacao=mpdd_transacao and mped_tipomov=mpdd_tipomov and mped_numerodoc=mpdd_numerodoc)'+
                  ' where mpdd_datamvto>='+EdDatai.AsSql+' and mpdd_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqldatacont+
                  ' and '+FGeral.Getin('mpdd_status','N','C')+
                  ' and '+FGeral.Getin('mpdd_situacao','P;E','C')+
                  ' order by mpdd_unid_codigo,mpdd_repr_codigo,mpdd_tipo_codigo,mpdd_numerodoc,mpdd_seq' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

      Sistema.BeginProcess('Gerando Relat�rio');
      FRel.Init('RelImpressaoPedidos');
      FRel.AddTit('Relat�rio de Impress�o de Pedidos de Venda');
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+' '+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Rep.'     ,''         ,'',false);
      FRel.AddCol(120,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Pedido'           ,''         ,'',false);
//      FRel.AddCol( 60,1,'D','' ,''              ,'Montagem'         ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Cliente'     ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Nome cliente'   ,''         ,'',false);
      FRel.AddCol( 80,1,'N','' ,''              ,'Nro pedido'   ,''         ,'',false);
      FRel.AddCol(080,1,'N','' ,''              ,'Produto'   ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Descri��o Produto'   ,''         ,'',false);
      FRel.AddCol(070,2,'C','' ,''              ,'Tamanho'             ,''         ,'',false);
      FRel.AddCol(120,1,'C','' ,''              ,'Cor'                 ,''         ,'',false);
      FRel.AddCol(040,1,'C','' ,''              ,'Copa'                ,''         ,'',false);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Solicitada'          ,''         ,'',False);
      while not Q.eof do begin

//        if Considerar(Q.fieldbyname('mpdd_dataenviada').asdatetime-Q.fieldbyname('mpdd_datamvto').asdatetime) then begin
          cliente:=Q.fieldbyname('mpdd_tipo_codigo').asinteger;
          FRel.AddCel(Q.fieldbyname('mpdd_unid_codigo').asstring);
          FRel.AddCel(Q.fieldbyname('mpdd_repr_codigo').asstring);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mpdd_repr_codigo').asinteger,'R','N'));
          FRel.AddCel(Q.fieldbyname('mpdd_datamvto').asstring);
//          FRel.AddCel(Q.fieldbyname('mpdd_dataenviada').asstring);
          FRel.AddCel(Q.fieldbyname('mpdd_tipo_codigo').asstring);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mpdd_tipo_codigo').asinteger,'C','N'));
          FRel.AddCel(Q.fieldbyname('mpdd_numerodoc').asstring);
          FRel.AddCel(Q.fieldbyname('mpdd_esto_codigo').asstring);
          FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('mpdd_esto_codigo').asstring));
          FRel.AddCel(FTamanhos.GetDescricao(Q.fieldbyname('mpdd_tama_codigo').asinteger));
          FRel.AddCel(FCores.GetDescricao(Q.fieldbyname('mpdd_core_codigo').asinteger));
          FRel.AddCel(FCopas.GetDescricao(Q.fieldbyname('mpdd_copa_codigo').asinteger));
          FRel.AddCel(formatfloat(f_cr,Q.fieldbyname('mpdd_qtde').ascurrency));
//        end;
        Q.Next;
        if (cliente<>Q.fieldbyname('mpdd_tipo_codigo').asinteger) and ( not Q.eof ) then
          FGeral.PulalinhaRel(13);

      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    FGeral.Fechaquery(Q);
    FRelGerenciais_ImpressaoPedidos;         // 29
  end;

end;

// 28.09.07
//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure FRelGerenciais_EntradadeAbate(numero:integer=0;unidade:string='';xtipomov:string='EA');                   // 30
///////////////////////////////////////////////////////////////////////////////////////////////////////
type TProdutos=record
  produto:string;
  pesocarcaca,vlrarroba,pesovivo,valortotal:currency;
end;


var xnumero,
    i,
    dias,
    diasp               :integer;
    xunidade,xSa,sqlperiodo,sqlnumerodoc,Anasin,soma,email,cooperado,sqlorder,pessoafisjur,
    sqlabatidos,AbaVivos,
    sqlbrinco  :string;
    Q,Qa,QFM   :TSqlquery;
    tpesovivo,tpesocarcaca,rend,tvalortotal,perfunrural,percotacapital,valorfunrural,valorcotacapital,unitariogta,
    valorgta,ganhopeso,
    vlrarrobaentrada,
    totalentrada,
    custocc       :currency;
    PProdutos:^Tprodutos;
    Lista   :TList;
    Datacont:TDatetime;

    procedure Atualiza(produto:string ; vlrarroba,vivo,carcaca:currency );
   //////////////////////////////////////////////////////////////////////
    var p:integer;
        achou:boolean;
    begin
      achou:=false;
      for p:=0 to Lista.count-1 do begin
        PProdutos:=Lista[p];
        if PProdutos.produto=produto then begin
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
        New(PProdutos);
        PProdutos.produto:=produto;
        PProdutos.pesocarcaca:=carcaca;
        PProdutos.pesovivo:=vivo;
        PProdutos.vlrarroba:=vlrarroba;
        PProdutos.valortotal:=carcaca*(vlrarroba/15);
        Lista.Add(PProdutos);
      end else begin
        PProdutos.pesovivo:=PProdutos.pesovivo+vivo;
        PProdutos.pesocarcaca:=PProdutos.pesocarcaca+carcaca;
//        PProdutos.vlrarroba:=vlrarroba;
        PProdutos.valortotal:=PProdutos.valortotal+(carcaca*(vlrarroba/15));
      end;

    end;

    // 27.05.19
    function GetValorArrobaEntrada(xbrinco:string ; xdatamvto:Tdatetime ; xmovd_tipo_codigo:integer ):currency;
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var QA,
        QC      :TSqlquery;
        sqlxdata,
        xcpfcnpj:string;
    begin

        if Datetoano(xdatamvto,true)>1902 then
           sqlxdata:=' and movd_datamvto >= '+Datetosql(xdatamvto-180)
        else
           sqlxdata:=' and movd_datamvto >= '+Datetosql(Sistema.Hoje-180);

        QA:=sqltoquery( 'select movd_vlrarroba from movabatedet'+
                        ' where movd_tipomov = '+Stringtosql('EA')+
                        ' and movd_unid_codigo = '+Stringtosql( copy(xunidade,1,3))+
                        ' and movd_status <> ''C'''+
                        ' and movd_brinco = '+stringtosql(xbrinco)+
                        sqlxdata+
                        ' and movd_abatido is null'+
// 29.04.20 - Novicarnes..
//                        ' and movd_tipo_codigo = '+inttostr(xmovd_tipo_codigo)+
                        ' order by movd_datamvto' );
        if not QA.eof then result:=QA.fieldbyname('movd_vlrarroba').ascurrency
        else begin
             xcpfcnpj:=FCadcli.GetCnpjCpf(xmovd_tipo_codigo);
             QC:=sqltoquery('select clie_codigo from clientes where clie_cnpjcpf='+
                            stringtosql(xcpfcnpj));
             while not Qc.Eof do begin

                if QC.FieldByName('clie_codigo').asinteger<>xmovd_tipo_codigo then begin

                   QA.Close;
                   QA:=sqltoquery( 'select movd_vlrarroba,clie_cnpjcpf from movabatedet'+
                        ' inner join clientes on ( clie_codigo=movd_tipo_codigo )'+
                        ' where movd_tipomov = '+Stringtosql('EA')+
                        ' and movd_unid_codigo = '+Stringtosql( copy(xunidade,1,3))+
                        ' and movd_status <> ''C'''+
                        ' and movd_brinco = '+stringtosql(xbrinco)+
                        sqlxdata+
                        ' and movd_abatido is null'+
//                        ' and movd_tipo_codigo = '+inttostr(QC.FieldByName('clie_codigo').asinteger)+
// 29.04.20 - Novicarnes..
                        ' order by movd_datamvto' );
                  if not QA.eof then result:=QA.fieldbyname('movd_vlrarroba').ascurrency
                  else result:=0;

                end;

                Qc.Next;

             end;

        end;
        FGeral.FechaQuery(QA);

    end;

//  13.06.19
    function GetNumeroLote:string;
    //////////////////////////////
    var QL:TSqlquery;
    begin

      QL:=sqltoquery('select movd_numerodoc from movabatedet where movd_status = ''N'''+
                     ' and movd_brinco = '+stringtosql(Q.FieldByName('movd_brinco').AsString)+
                     ' and movd_unid_codigo = '+stringtosql(Q.FieldByName('movd_unid_codigo').AsString)+
                     ' and movd_tipomov = '+Stringtosql( TipoLote )+
                     ' and movd_datamvto >= '+Datetosql(Q.FieldByName('movd_datamvto').AsDatetime-60) );
      if not QL.Eof then result:=QL.FieldByName('movd_numerodoc').AsString
      else result:='';
      FGeral.FechaQuery(QL);

    end;

// 20.08.19
   function GetProdutorPeloBrinco( xbrinco:string):integer;
   //////////////////////////////////////////////////////////
   var QB:TSqlquery;
   begin

      QB:=sqltoquery('select movd_tipo_codigo from movabatedet where movd_status = ''N'''+
                     ' and movd_brinco = '+stringtosql(xbrinco)+
                     ' and movd_unid_codigo = '+stringtosql(Q.FieldByName('movd_unid_codigo').AsString)+
                     ' and movd_tipomov = '+Stringtosql( TipoEntradaAbate )+
                     ' and movd_datamvto >= '+Datetosql(Q.FieldByName('movd_datamvto').AsDatetime-360) );
      if not QB.Eof then result:=QB.FieldByName('movd_tipo_codigo').AsInteger
      else result:=0;
      FGeral.FechaQuery(QB);

   end;

// 01.06.20
   function GetValorCCusto( dataentrada, dataabate :TDatetime;
                            Datai , Dataf :TDatetime):currency;
   ////////////////////////////////////////////////////////////////////
   var Qcc   : TSqlquery;
       xdata ,
       xdataentrada      : TDatetime;
       contaconfinamento : string;
       valor,
       tvalor            : currency;
       diasmes,
       diaspropo         : integer;
       primeiromes       : boolean;


       function GetDiasmes(xmes:integer):integer;
       ////////////////////////////////////////////
       begin

          if xmes = 1 then result:=31
          else if xmes = 2 then result:=28
          else if xmes = 3 then result:=31
          else if xmes = 4 then result:=30
          else if xmes = 5 then result:=31
          else if xmes = 6 then result:=30
          else if xmes = 7 then result:=31
          else if xmes = 8 then result:=31
          else if xmes = 9 then result:=30
          else if xmes = 10 then result:=31
          else if xmes = 11 then result:=30
          else if xmes = 12 then result:=31
          else result:=0;

       end;

       function EstanoMes(di,df:TDatetime):boolean;
       /////////////////////////////////////////////
       begin

          if ( DateTodia(di)>1 ) and ( FormatDatetime('mm/yyyy',di) = FormatDatetime('mm/yyyy',df) ) then
             result:=true
          else
             result:=false;

       end;



   begin

      contaconfinamento := FGeral.GetConfig1AsString( 'ccustoconfina' );
      result:=0;
      valor :=0;
      tvalor := 0;
//// caso ainda estiver vivo
//      if DateToAno(dataabate,true) < 1902 then
//         datai := Sistema.hoje;

      if trim(contaconfinamento)<>'' then begin

         xdata:=Texttodate('01'+FormatDatetime('mm/yyyy',dataentrada));
         Qcc := sqltoquery('select ccus_vlrreal from CentrosdeCusto'+
              ' left join ccustos on (ccst_codigo=Ccus_Codigo)'+
              ' where ccus_data = '+Datetosql(xdata)+
              ' and ccus_codigo = '+stringtosql(contaconfinamento));

         if not Qcc.eof then begin

            valor     := Qcc.FieldByName('ccus_vlrreal').AsCurrency;
            diasmes   := GetDiasmes( Datetomes(dataentrada) );
            diaspropo := diasmes - ( Datetodia(dataentrada+1) ) +1 ;  // desconta dia da entrada
            xdataentrada := dataentrada;
            primeiromes  := true;

            {
            while xdataentrada < datai do begin

                  xdata:=Texttodate('01'+FormatDatetime('mm/yyyy',xdataentrada));
                  Qcc := sqltoquery('select ccus_vlrreal from CentrosdeCusto'+
                          ' left join ccustos on (ccst_codigo=Ccus_Codigo)'+
                          ' where ccus_data = '+Datetosql(xdata)+
                          ' and ccus_codigo = '+stringtosql(contaconfinamento));
                  if not Qcc.eof then
                        valor := Qcc.FieldByName('ccus_vlrreal').AsCurrency;

                  if (EstanoMes(xdataentrada,datai)) or (EstanoMes(dataentrada,datai)) then begin

                            diasmes   := GetDiasmes( Datetomes(xdataentrada) );
//                            diaspropo := diasmes - Datetodia(xdataentrada);
                            diaspropo := diasmes - Datetodia(dataentrada) + 1;  // desconta dia da entrada
                            valor     := (valor/diasmes) * diaspropo;
                            tvalor    :=  tvalor + valor ;

                  end else if (Datetodia(Dataentrada)>1) and ( primeiromes) then begin

                            diasmes   := GetDiasmes( Datetomes(dataentrada) );
//                            diaspropo := diasmes - Datetodia(dataentrada) -1 ;
                            diaspropo := diasmes - Datetodia(dataentrada) + 1;  // desconta dia da entrada
                            valor     := (valor/diasmes) * diaspropo;
                            tvalor    :=  tvalor + valor ;
                            primeiromes := false;

                  end else
                            tvalor    :=  tvalor + valor ;


                  xdataentrada := ( DateToDateMesPos(xdataentrada,1) );

            end;
            }


//            while xdataentrada < dataf do begin
            while xdataentrada < FRelGerenciais.Eddatai.asdate do begin

                  xdata:=Texttodate('01'+FormatDatetime('mm/yyyy',xdataentrada));
                  Qcc := sqltoquery('select ccus_vlrreal from CentrosdeCusto'+
                          ' left join ccustos on (ccst_codigo=Ccus_Codigo)'+
                          ' where ccus_data = '+Datetosql(xdata)+
                          ' and ccus_codigo = '+stringtosql(contaconfinamento));
                  if not Qcc.eof then
                        valor := Qcc.FieldByName('ccus_vlrreal').AsCurrency;


//                  if (EstanoMes(dataentrada,dataf))  then begin
                  if Primeiromes then begin

                            diasmes   := GetDiasmes( Datetomes(xdataentrada) );
//                            diaspropo := diasmes - Datetodia(xdataentrada);
                            diaspropo := diasmes - Datetodia(dataentrada) ;
                            valor     := (valor/diasmes) * diaspropo;
                            tvalor    :=  tvalor + valor ;
                            Primeiromes := false;
     {
                  end else if ( (DataAbate>Datai) and (DAtaAbate < DataF) ) then begin

                            diasmes   := GetDiasmes( Datetomes(dataabate) );
                            diaspropo := Datetodia(dataabate);
                            valor     := (valor/diasmes) * diaspropo;
                            tvalor    :=  tvalor + valor ;
       }
                  end else

                            tvalor    :=  tvalor + valor ;

                  xdataentrada := ( DateToDateMesPos(xdataentrada,1) );


            end;  // xdataentrada < dataf

// mes final do relatorio ver proporcional data do fim do relatorou OU abate
            if (Datetoano(DataAbate,true) > 1902) and ( DataAbate <= FRelGerenciais.EdDataf.asdate ) then begin

                if Datetodia(DataAbate) = 1 then begin

                   xdata := dataabate;

                end else begin

                   xdata     := dataabate-1;
                   dataabate := dataabate-1;

                end;

            end else begin

                dataabate := Sistema.hoje; // FRelGerenciais.EdDataf.asdate;
                xdata     := Sistema.hoje;

            end;
           // if (Datetoano(DataAbate,true) > 1902) then begin  // proporcional ultimo mes..

                xdata:=Texttodate('01'+FormatDatetime('mm/yyyy',xdata));
                Qcc := sqltoquery('select ccus_vlrreal from CentrosdeCusto'+
                          ' left join ccustos on (ccst_codigo=Ccus_Codigo)'+
                          ' where ccus_data = '+Datetosql(xdata)+
                          ' and ccus_codigo = '+stringtosql(contaconfinamento));
                if not Qcc.eof then
                        valor := Qcc.FieldByName('ccus_vlrreal').AsCurrency
                else
                        valor:=0;
               diasmes   := GetDiasmes( Datetomes(dataabate) );
               diaspropo := Datetodia(dataabate) ; // j� vem descontado o dia do abate
               valor     := ( (valor/diasmes) * diaspropo );
               tvalor    := tvalor+ valor;

            //end;


         end; // Qcc.eof

         result := tvalor;
         FGeral.FechaQuery(Qcc);

      end;  // trim(ccusto confinamento)


   end;  // da funcao



begin
//////////////////////////////////////////
//  with FRelGerenciais do begin
// 01.07.08  - aqui pois nao passa no 'execute' no inicio de .pas
    TipoEntradaAbate:='EA';
    TipoFazenda:='FA';
    TipoLote   :='LO';

    sqlabatidos:='';
    Abavivos   :='';
    sqlbrinco  := '';

    if (numero>0) and (unidade<>'') then begin

      xnumero:=numero;
      xunidade:=unidade;
      FRelGerenciais.EdNUmerodoc.setvalue(numero);
      FRelGerenciais.EdUnid_codigo.text:=unidade;
      xSa:='A';
      sqlperiodo:='';
// 18.07.11 - quem ser� q pediu ou porque foi alterado ??
//      sqlorder:=' order by mova_unid_codigo,mova_tipo_codigo,movd_esto_codigo' ;
// 28.10.11
      sqlorder:=' order by mova_unid_codigo,mova_tipo_codigo,movd_numerodoc,movd_ordem' ;

    end else begin

// 15.03.18
      FRelGerenciais.EdAbatidos.enabled:=(xtipomov=TipoFazenda);

      if not FRelGerenciais_Execute(30) then Exit;
      xnumero:=FRelGerenciais.EdNumerodoc.asinteger;
      xunidade:=FRelGerenciais.EdUnid_codigo.text;
      xSa:=FRelGerenciais.EdSinana.text;
      sqlperiodo:=' and mova_dtabate>='+FRelGerenciais.EdDatai.AsSql+' and mova_dtabate<='+FRelGerenciais.EdDataf.AsSql;
      sqlorder:=' order by mova_unid_codigo,mova_tipo_codigo,movd_numerodoc,movd_ordem' ;
// 15.03.18
      Abavivos:='';
      if xtipomov=TipoFazenda then begin

        Abavivos:=' - Todos';
        if FRelGerenciais.EdAbatidos.Text = 'A' then begin

          sqlabatidos:=' and movd_dataabate is not null';
          Abavivos:=' - Abatidos';
// 24.04.20
          sqlperiodo:=' and movd_dataabate>='+FRelGerenciais.EdDatai.AsSql+' and movd_dataabate<='+FRelGerenciais.EdDataf.AsSql;

        end else if FRelGerenciais.EdAbatidos.text = 'V' then begin

          sqlabatidos:=' and movd_dataabate is null';
          Abavivos:=' - Vivos';

        end;
      end;

    end;

    sistema.beginprocess('separando quantidade');
// nas 'saidas de abate/pedidos de venda' nao faz sentido o sintetico...
// 01.07.11 - agora faz...nova tela de pesagem
//    if xTipomov<>TipoEntradaAbate then
//      xSa:='A';
    if xsa='A' then
      Anasin:=' - Anal�tico'
    else
      Anasin:=' - Sint�tico';
    if xnumero>0 then
      sqlnumerodoc:=' and mova_numerodoc='+inttostr(xnumero)
    else
      sqlnumerodoc:='';
    if trim(xUnidade)<>'' then
      sqlunidade:=' and '+FGeral.getin('mova_unid_codigo',xUnidade,'C')
    else
      sqlunidade:='';
//    if EdTipomov.isempty then begin
      sqltipomovto:='';
//    end else begin
//      sqltipomovto:=' and '+FGeral.getin('mpdd_tipomov',Edtipomov.text,'C');
//    end;
    if FRelGerenciais.EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
        sqlcodtipo:=' and movd_tipo_codigo='+FRelGerenciais.EdCodtipo.assql;
    end;
// 03.10.05
    if not FRelGerenciais.EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.getin('movd_esto_codigo',FRelGerenciais.EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and mova_datacont>1';
// 27.05.10
      sqldatacont:=' and mova_datacont > '+DateToSql(Global.DataMenorBanco);
// 05.06.08                                              // 31.01.13
    sqltipomovto:=' and mova_tipomov='+Stringtosql(xTipomov)+' and movd_tipomov='+Stringtosql(xTipomov);
// 28.04.20
    if not FRelGerenciais.EdBrinco.isempty then
       sqlbrinco := ' and movd_brinco = '+FRelGerenciais.EdBrinco.assql;


    if xTipoMov='PA' then
        sqltipomovto:=' and mova_tipomov='+Stringtosql(TipoEntradaAbate)+' and movd_tipomov='+Stringtosql(TipoEntradaAbate);
    if xSa='A' then

      Q:=sqltoquery('select movabatedet.*,movabate.*,clie_email,clie_email1,clie_ativo,clie_tipo,clie_aliinsspro from movabatedet '+
                  ' inner join movabate on ( mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc and mova_tipomov=movd_tipomov)'+
//                  ' inner join clientes on ( clie_codigo=movd_tipo_codigo )'+
//     13.07.16
//                  ' inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
//     14.05.19 - para achar os Lotes
                  ' left join clientes on ( clie_codigo=mova_tipo_codigo )'+
                  ' where '+FGeral.Getin('movd_status','N','C')+
                  sqlperiodo+
                  sqlunidade+sqlnumerodoc+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqldatacont+
                  sqlabatidos+
                  sqlbrinco+
                  ' and '+FGeral.Getin('mova_situacao','N;P','C')+
                  sqlorder )
//                  ' order by mova_unid_codigo,mova_tipo_codigo,movd_numerodoc,movd_ordem' )
    else begin

      if xTipomov=TipoEntradaAbate then
        Q:=sqltoquery('select movd_unid_codigo,movd_numerodoc,movd_tipo_codigo,movd_esto_codigo,sum(movd_pesovivo) as vivo,sum(movd_pesocarcaca) as carcaca,'+
                  ' sum(movd_pesocarcaca*(movd_vlrarroba/15)) as vlrtotal, sum(movd_pecas) as totpecas from movabatedet'+
                  ' inner join movabate on ( mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc)'+
                  ' where '+FGeral.Getin('movd_status','N','C')+
                  sqlperiodo+
                  sqlunidade+sqlnumerodoc+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqldatacont+
                  sqlbrinco+
                  ' and '+FGeral.Getin('mova_situacao','N;P','C')+
                  ' group by movd_unid_codigo,movd_numerodoc,movd_tipo_codigo,movd_esto_codigo'+
                  ' order by movd_unid_codigo,movd_numerodoc,movd_tipo_codigo,movd_esto_codigo')
      else // 01.07.11

        Q:=sqltoquery('select movd_unid_codigo,movd_numerodoc,movd_tipo_codigo,movd_esto_codigo,sum(movd_pesovivo) as vivo,sum(movd_pesocarcaca) as carcaca,'+
                  ' sum(movd_pesocarcaca*(movd_vlrarroba)) as vlrtotal, sum(movd_pecas) as totpecas from movabatedet'+
                  ' inner join movabate on ( mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc)'+
                  ' where '+FGeral.Getin('movd_status','N','C')+
                  sqlperiodo+
                  sqlunidade+sqlnumerodoc+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqldatacont+
                  sqlabatidos+
                  sqlbrinco+
                  ' and '+FGeral.Getin('mova_situacao','N;P','C')+
                  ' group by movd_unid_codigo,movd_numerodoc,movd_tipo_codigo,movd_esto_codigo'+
                  ' order by movd_unid_codigo,movd_numerodoc,movd_tipo_codigo,movd_esto_codigo');

    end;
    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

      if xsa='A' then begin
        email:=Q.fieldbyname('clie_email').asstring+';'+Q.fieldbyname('clie_email1').asstring;
        cooperado:=Q.FieldByName('clie_ativo').asstring;
// 07.08.15
        pessoafisjur:=Q.FieldByName('clie_tipo').asstring;
        datacont:=Q.FieldByName('mova_datacont').asdatetime;
      end else begin
        datacont:=0;
      end;
      tpesovivo:=0;tpesocarcaca:=0;tvalortotal:=0;
      Lista:=TList.create;
      perfunrural:=FGeral.Getconfig1asfloat('perfunrural');
// 30.07.15
      unitariogta:=FGeral.GetConfig1AsFloat('valorgta');
// 15.01.2010
      if xSa='A' then begin
//        if Q.fieldbyname('clie_tipo').AsString='J' then
//          perfunrural:=FGeral.Getconfig1asfloat('perfunruraljur');
// 19.05.10
        if Q.FieldByName('clie_tipo').AsString='J' then
            perfunrural:=FGeral.Getconfig1asfloat('perfunruraljur');
      // 05.05.10 - produtor rural Nao empregador - Novi - vava
        if Q.FieldByName('clie_aliinsspro').Ascurrency=99 then
            perfunrural:=0
        else if Q.FieldByName('clie_aliinsspro').Ascurrency>0 then
            perfunrural:=Q.FieldByName('clie_aliinsspro').Ascurrency;
      end;
      percotacapital:=FGeral.Getconfig1asfloat('percotacapital');
      Sistema.BeginProcess('Gerando Relat�rio');

      if (numero>0) and (unidade<>'') then begin

        if xTipomov=TipoEntradaAbate then begin

          FRel.Init('EntradadeAbate');
          FRel.AddTit('Entrada de Abate Numero '+inttostr(xnumero)+' - Data Abate '+FGeral.formatadata(Q.fieldbyname('mova_dtabate').asdatetime)+
                      ' - Vencimento '+FGeral.formatadata(Q.fieldbyname('mova_dtvenci').asdatetime));
          FRel.AddTit(FGeral.TituloRelUnidade(xUnidade)+' - Produtor : '+Q.fieldbyname('mova_tipo_codigo').asstring+' - '+
                      FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mova_tipo_codigo').asinteger,'C','N') );
// 30.07.19
        end else if xTipomov=TipoLote then begin

          FRel.Init('EntradadeLote');
          FRel.AddTit('Lote Numero '+inttostr(xnumero)+' - Data Entrada '+FGeral.formatadata(Q.fieldbyname('mova_dtabate').asdatetime)+
                      ' - Abate '+FGeral.formatadata(Q.fieldbyname('mova_dtvenci').asdatetime)+
                      ' - Baia '+FBaias.getdescricao(Q.fieldbyname('movd_baia').asstring)  );
          FRel.AddTit(FGeral.TituloRelUnidade(xUnidade)+' - Produtor : '+Q.fieldbyname('mova_tipo_codigo').asstring+' - '+
                      FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mova_tipo_codigo').asinteger,'C','N') );

        end else if xTipomov=TipoFazenda then begin
// 30.07.19
//        end else if AnsiPos(xTipomov,TipoFazenda+';'+TipoLote) >0 then begin

          FRel.Init('MovFazenda');
          FRel.AddTit('Movimento Numero '+inttostr(xnumero)+' - Data '+FGeral.formatadata(Q.fieldbyname('mova_dtabate').asdatetime)+' - Vencimento '+FGeral.formatadata(Q.fieldbyname('mova_dtvenci').asdatetime) );
          FRel.AddTit(FGeral.TituloRelUnidade(xUnidade)+' - Produtor : '+Q.fieldbyname('mova_tipo_codigo').asstring+' - '+
                      FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mova_tipo_codigo').asinteger,'C','N') );
// 17.09.15
        end else if xTipomov='PA' then begin
// 30.07.19
//        end else if AnsiPos(xTipomov,TipoFazenda+';'+TipoLote) >0 then begin

          FRel.Init('PesagemEntradadeAbate');
          FRel.AddTit('Entrada de Abate Numero '+inttostr(xnumero)+' - Data Abate '+FGeral.formatadata(Q.fieldbyname('mova_dtabate').asdatetime)+' - Vencimento '+FGeral.formatadata(Q.fieldbyname('mova_dtvenci').asdatetime) );
          FRel.AddTit(FGeral.TituloRelUnidade(xUnidade)+' - Produtor : '+Q.fieldbyname('mova_tipo_codigo').asstring+' - '+
                      FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mova_tipo_codigo').asinteger,'C','N') );
        end else begin

          FRel.Init('SaidadeAbate');
//          FRel.AddTit('Pedido de Venda Numero '+inttostr(xnumero)+' - Data '+FGeral.formatadata(Q.fieldbyname('mova_dtabate').asdatetime) );  // +' - Vencimento '+FGeral.formatadata(Q.fieldbyname('mova_dtvenci').asdatetime) );
          FRel.AddTit('Romaneio de Pesagem do Pedido de Venda Numero '+inttostr(xnumero)+' - Data '+FGeral.formatadata(Q.fieldbyname('mova_dtabate').asdatetime) );  // +' - Vencimento '+FGeral.formatadata(Q.fieldbyname('mova_dtvenci').asdatetime) );
          FRel.AddTit(FGeral.TituloRelUnidade(xUnidade)+' - Cliente : '+Q.fieldbyname('mova_tipo_codigo').asstring+' - '+
                      FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mova_tipo_codigo').asinteger,'C','N') );
        end;

//        if xTipomov=TipoEntradaAbate then begin
// 30.07.19
        if AnsiPos(xTipomov,TipoEntradaAbate+';'+TipoLote) >0 then begin

          FRel.AddCol( 40,3,'N','' ,''              ,'Ordem'                 ,''         ,'',false);
          FRel.AddCol( 45,1,'N','' ,''              ,'Brinco'                ,''         ,'',false);
          FRel.AddCol( 65,3,'N','' ,''              ,'Cod.Produto'           ,''         ,'',false);
          FRel.AddCol(150,1,'C','' ,''              ,'Descri��o Produto'   ,''         ,'',false);
          FRel.AddCol( 35,2,'C','' ,''              ,'Idade'                 ,''         ,'',false);
 // 20.08.19
          if xtipomov = TipoLote then

             FRel.AddCol( 60,3,'N','+' ,f_cr            ,'Vivo'           ,''         ,'',False)

          else

             FRel.AddCol( 60,3,'N','-' ,f_cr            ,'Vivo'           ,''         ,'',False);

          FRel.AddCol( 60,3,'N','' ,f_cr            ,'Carca�a'        ,''         ,'',False);


        end else if xTipomov=TipoFazenda then begin
// 30.07.19
//        end else if AnsiPos(xTipomov,TipoFazenda+';'+TipoLote) >0 then begin

          FRel.AddCol( 40,3,'N','' ,''              ,'Ordem'                 ,''         ,'',false);
          FRel.AddCol( 45,1,'N','' ,''              ,'Brinco'                ,''         ,'',false);
          FRel.AddCol( 65,3,'N','' ,''              ,'Cod.Produto'           ,''         ,'',false);
          FRel.AddCol(150,1,'C','' ,''              ,'Descri��o Produto'   ,''         ,'',false);
//          FRel.AddCol(100,1,'C','' ,''              ,'Setor'                ,''         ,'',false);
          FRel.AddCol( 35,2,'C','' ,''              ,'Baia'                  ,''         ,'',false);
          FRel.AddCol( 60,3,'N','' ,f_cr            ,'Vivo Ent.'           ,''         ,'',False);
          FRel.AddCol( 60,3,'N','' ,f_cr            ,'Vivo Abate'           ,''         ,'',False);
// 22.09.16
          FRel.AddCol( 60,3,'N','' ,f_cr            ,'Abate'           ,''         ,'',False);
// 17.09.15
        end else if xTipomov='PA' then begin
          FRel.AddCol( 40,3,'N','' ,''              ,'Ordem'                 ,''         ,'',false);
//          FRel.AddCol( 65,3,'N','' ,''              ,'Cod.Produto'           ,''         ,'',false);
          FRel.AddCol(150,1,'C','' ,''              ,'Descri��o Produto'   ,''         ,'',false);
          FRel.AddCol( 60,3,'N','' ,f_cr            ,'Peso'            ,''         ,'',False)

        end else begin
//          FRel.AddCol( 40,3,'N','+'  ,'#####0'       ,'Pe�as'              ,''         ,'',False);
          FRel.AddCol( 40,3,'N','+'  ,''       ,'Pe�as'              ,''         ,'',False);
          FRel.AddCol(150,1,'C','' ,''              ,'Descri��o Produto'   ,''         ,'',false);
//          FRel.AddCol( 60,3,'N','+' ,f_cr3           ,'Peso'        ,''         ,'',False);
          FRel.AddCol( 60,3,'N','+' ,''           ,'Peso'        ,''         ,'',False);
        end;

//        if xTipomov=TipoEntradaAbate then begin
// 30.07.19
        if AnsiPos(xTipomov,TipoEntradaAbate+';'+TipoLote) >0 then begin

          FRel.AddCol( 50,3,'N',''  ,'##0.00'       ,'Rend.%'              ,''         ,'',False);
          FRel.AddCol( 40,3,'N',''  ,'##0.00'       ,'Arroba'              ,''         ,'',False);
          FRel.AddCol( 70,3,'N','' ,f_cr           ,'Valor Total'         ,''         ,'',False);

        end else if xTipomov=TipoFazenda then begin
// 30.07.19
//        end else if AnsiPos(xTipomov,TipoFazenda+';'+TipoLote) >0 then begin

          FRel.AddCol( 50,3,'N',''  ,''       ,'Arroba Ent.'              ,''         ,'',False);
// 22.09.16
          FRel.AddCol( 50,3,'N',''  ,''        ,'Arroba Abate'              ,''         ,'',False);
          FRel.AddCol( 50,3,'N',''  ,'##0.00'  ,'Rend.%'              ,''         ,'',False);
          FRel.AddCol( 80,3,'N','+' ,f_cr       ,'Total Entrada'         ,''         ,'',False);
          FRel.AddCol( 80,3,'N','+' ,f_cr       ,'Total Abate'         ,''         ,'',False);
          FRel.AddCol( 70,3,'N','+' ,f_cr       ,'Diferen�a'         ,''         ,'',False);
          FRel.AddCol( 50,3,'N','' ,''          ,'Dias'         ,''         ,'',False);
          FRel.AddCol( 70,3,'N','+' ,f_cr       ,'Ganho Peso'         ,''         ,'',False);
          FRel.AddCol(150,1,'C',''  ,''       ,'Produto Abatido'   ,''         ,'',false);
// 17.09.15
        end else if xTipomov='PA' then begin
// s� para nao imprimir mais colunas...
        end else begin
//          FRel.AddCol( 40,3,'N',''  ,'##0.00'       ,'Unit�rio'              ,''         ,'',False);
          FRel.AddCol( 40,3,'N',''  ,''       ,'Unit�rio'              ,''         ,'',False);
//          FRel.AddCol( 70,3,'N','+' ,f_cr           ,'Valor Total'         ,''         ,'',False);
          FRel.AddCol( 70,3,'N','+' ,''           ,'Valor Total'         ,''         ,'',False);
        end;
// 18.09.15
        if xTipomov<>'PA' then
           FRel.AddCol(080,1,'C','' ,''              ,'Obs'                   ,''         ,'',false);

        if xtipomov = TipoLote then

             FRel.AddCol(180,1,'C','' ,''            ,'Produtor'           ,''         ,'',False);

      end else begin  // relatorios

        if xTipomov=TipoEntradaAbate then begin

          FRel.Init('RelEntradadeAbate');
          FRel.AddTit('Relat�rio de Entrada de Abate '+Anasin);
          FRel.AddTit(FGeral.TituloRelUnidade(xUnidade));

        end else if xTipomov=TipoFazenda then begin

          FRel.Init('RelMovFazenda');
          FRel.AddTit('Relat�rio de Movimento '+Anasin+AbaVivos);
          if sqlbrinco='' then

             FRel.AddTit(FGeral.TituloRelUnidade(xUnidade))

          else

             FRel.AddTit(FGeral.TituloRelUnidade(xUnidade)+' Brinco '+FRelGerenciais.Edbrinco.Text);

        end else begin
          FRel.Init('RelSaidadeAbate');
          FRel.AddTit('Relat�rio de Pedidos de Venda '+Anasin);
          FRel.AddTit(FGeral.TituloRelUnidade(xUnidade));
        end;
        if numero=0 then
          FRel.AddTit('Periodo : '+FGeral.formatadata(FRelGerenciais.EdDatai.Asdate)+' a '+FGeral.formatadata(FRelGerenciais.EdDataf.asdate));
        if xSa='A' then begin

          FRel.AddCol( 40,2,'C','' ,''              ,'Uni.'         ,''         ,'',false);
          FRel.AddCol( 50,3,'N','' ,''              ,'Numero'           ,''         ,'',false);
          FRel.AddCol( 65,3,'N','' ,''              ,'Cod.Produtor'    ,''         ,'',false);
          FRel.AddCol(150,1,'C','' ,''              ,'Nome Produtor'  ,''         ,'',false);
          if xTipomov=TipoEntradaAbate then begin
            FRel.AddCol( 60,1,'D','' ,''              ,'Abate'        ,''         ,'',false);
            FRel.AddCol(060,1,'D','' ,''              ,'Vencim.'   ,''         ,'',false);
          end;
          FRel.AddCol( 60,3,'N','' ,''              ,'Ordem'                 ,''         ,'',false);

          if (xTipomov=TipoEntradaAbate) or (xTipomov=TipoFazenda) then begin
            FRel.AddCol( 50,1,'N','' ,''              ,'Brinco'                ,''         ,'',false);
// 02.07.19
            FRel.AddCol( 50,1,'N','' ,''              ,'Baia'                ,''         ,'',false);
// 13.06.19 -
            FRel.AddCol( 50,1,'N','' ,''              ,'Lote'                ,''         ,'',false);
          end;

          FRel.AddCol( 60,3,'N','' ,''              ,'Cod.Produto'           ,''         ,'',false);
          FRel.AddCol(180,1,'C','' ,''              ,'Descri��o Produto'   ,''         ,'',false);

          if xTipomov=TipoEntradaAbate then begin
            FRel.AddCol( 40,2,'C','' ,''              ,'Idade'                 ,''         ,'',false);
            FRel.AddCol( 40,3,'N','+'  ,'#####0'       ,'Pe�as'              ,''         ,'',False);
            FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Vivo'           ,''         ,'',False);
          end else if xTipomov=TipoFazenda then begin
//            FRel.AddCol(100,1,'C','' ,''              ,'Setor'           ,''         ,'',False);
            FRel.AddCol( 40,2,'C','' ,''              ,'Baia'                 ,''         ,'',false);
          end;

          if xTipomov=TipoEntradaAbate then

            FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Carca�a'        ,''         ,'',False)

          else begin

            FRel.AddCol( 70,3,'N','+' ,f_cr3          ,'Vivo Ent.'        ,''         ,'',False);
// 08.04.18
            FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Pesagem'           ,''         ,'',False);
            FRel.AddCol( 50,3,'N','' ,''              ,'Dias P'         ,''         ,'',False);
            FRel.AddCol( 70,3,'N','+' ,f_cr           ,'Ganho Peso P'         ,''         ,'',False);
            FRel.AddCol( 70,3,'N','+' ,f_cr3          ,'Vivo Abate'        ,''         ,'',False);
          end;
          if xTipomov=TipoEntradaAbate then begin
            FRel.AddCol( 50,3,'N',''  ,'##0.00'       ,'Rend.%'              ,''         ,'',False);
            FRel.AddCol( 70,3,'N',''  ,'##0.00'       ,'Arroba'              ,''         ,'',False)
          end else begin
            if xTipomov<>TipoFazenda then
              FRel.AddCol( 40,3,'N','+'  ,'#####0'       ,'Pe�as'              ,''         ,'',False);
            FRel.AddCol( 70,3,'N',''  ,'##0.000'       ,'Abate'              ,''         ,'',False);
// 04.10.16
            if xTipomov=TipoFazenda then begin
              FRel.AddCol( 70,3,'N',''  ,'##0.000'       ,'Arroba Ent.'              ,''         ,'',False);
              FRel.AddCol( 70,3,'N',''  ,'##0.000'       ,'Arroba Abate'              ,''         ,'',False);
            end;
          end;
          if xTipomov=TipoEntradaAbate then
            FRel.AddCol( 90,3,'N','+' ,f_cr           ,'PesoXArroba/15'      ,''         ,'',False)
          else
            FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Valor Total'         ,''         ,'',False);
// 04.10.16
          if xTipomov=TipoFazenda then begin
            FRel.AddCol( 50,3,'N',''  ,'##0.00'       ,'Rend.%'              ,''         ,'',False);
            FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Total Abate'         ,''         ,'',False);
// 29.05.20
            FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Confinamento'         ,''         ,'',False);
            FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Diferen�a'         ,''         ,'',False);
            FRel.AddCol( 50,3,'N','' ,''              ,'Dias'         ,''         ,'',False);
            FRel.AddCol( 70,3,'N','+' ,f_cr           ,'Ganho Peso'         ,''         ,'',False);
// 30.08.19
            FRel.AddCol( 70,3,'N','+' ,f_cr           ,'Ganho Interm.'         ,''         ,'',False);
            FRel.AddCol(150,1,'C',''  ,''             ,'Produto Abatido'   ,''         ,'',false);
// 09.09.17
            FRel.AddCol( 70,1,'D','' ,''                ,'Data Entrada'         ,''         ,'',False);
            FRel.AddCol( 70,1,'D','' ,''                ,'Data Pesagem'           ,''         ,'',False);
            FRel.AddCol( 70,1,'D','' ,''                ,'Data Abate'           ,''         ,'',False);

          end;
          FRel.AddCol(100,1,'C','' ,''              ,'Obs'                   ,''         ,'',false);

        end else begin  // Sintetico

          FRel.AddCol( 40,2,'C','' ,''              ,'Uni.'         ,''         ,'',false);
          FRel.AddCol( 50,3,'N','' ,''              ,'Numero'           ,''         ,'',false);
          FRel.AddCol( 65,3,'N','' ,''              ,'Cod.Produtor'    ,''         ,'',false);
          FRel.AddCol(150,1,'C','' ,''              ,'Nome Produtor'  ,''         ,'',false);
          FRel.AddCol( 60,3,'N','' ,''              ,'Cod.Produto'           ,''         ,'',false);
          FRel.AddCol(150,1,'C','' ,''              ,'Descri��o Produto'   ,''         ,'',false);
          if xTipomov=TipoEntradaAbate then begin
            FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Vivo'           ,''         ,'',False);
            FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Carca�a'        ,''         ,'',False)
          end else
            FRel.AddCol( 60,3,'N','+' ,f_cr3          ,'Peso'        ,''         ,'',False);
          if xTipomov=TipoEntradaAbate then
            FRel.AddCol( 50,3,'N',''  ,'##0.00'       ,'Rend.%'              ,''         ,'',False);
          FRel.AddCol( 70,3,'N','+'  ,'######'       ,'Pe�as'                    ,''         ,'',False);
          FRel.AddCol( 70,3,'N',''  ,'##0.00'       ,'Valor M�dio'              ,''         ,'',False);
          FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Valor Total'         ,''         ,'',False);
        end;
      end;


      while not Q.eof do begin

        if (numero<>0) and (unidade<>'') then begin

//          if xTipomov=TipoEntradaAbate then begin
// 30.07.19
        if AnsiPos(xTipomov,TipoEntradaAbate+';'+TipoLote) >0 then begin

            FRel.AddCel(Q.fieldbyname('movd_ordem').asstring);
            FRel.AddCel(Q.fieldbyname('movd_brinco').asstring);
            FRel.AddCel(Q.fieldbyname('movd_esto_codigo').asstring);
            FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('movd_esto_codigo').asstring));
            FRel.AddCel(Q.fieldbyname('movd_idade').asstring);
// 25.01.08 - izonel - novicarnes
            FRel.AddCel( FRelGerenciais.ChecaZero( floattostr(Q.fieldbyname('movd_pesovivo').ascurrency) ) );
            FRel.AddCel(floattostr(Q.fieldbyname('movd_pesocarcaca').ascurrency));
            if Q.Fieldbyname('Movd_pesovivo').AsCurrency>0 then
              rend:=( Q.Fieldbyname('Movd_pesocarcaca').AsCurrency/Q.Fieldbyname('Movd_pesovivo').AsCurrency ) *100
            else
              rend:=0;
            FRel.AddCel( FRelGerenciais.Checazero(floattostr(rend)) );
            FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrarroba').ascurrency));
            valorgta:=Q.Fieldbyname('Mova_vlrgta').AsCurrency;
// 17.09.15
          end else if xTipomov='PA' then begin

            FRel.AddCel(Q.fieldbyname('movd_ordem').asstring);
//            FRel.AddCel(Q.fieldbyname('movd_esto_codigo').asstring);
            FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('movd_esto_codigo').asstring));
            FRel.AddCel(floattostr(Q.fieldbyname('movd_pesocarcaca').ascurrency));

// 30.09.13
          end else if xTipomov=TipoFazenda then begin
// 30.07.19
//        end else if AnsiPos(xTipomov,TipoFazenda+';'+TipoLote) >0 then begin
          //////////////////////////////////////////////////////////////////////////
            FRel.AddCel(Q.fieldbyname('movd_ordem').asstring);
            FRel.AddCel(Q.fieldbyname('movd_brinco').asstring);
            FRel.AddCel(Q.fieldbyname('movd_esto_codigo').asstring);
            FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('movd_esto_codigo').asstring));
//            FRel.AddCel(FSetores.getdescricao(Q.fieldbyname('movd_seto_codigo').asstring));
//            FRel.AddCel(Q.fieldbyname('movd_baia').asstring);
            FRel.AddCel( FRelGerenciais.ChecaZero( floattostr(Q.fieldbyname('movd_pesovivo').ascurrency) ) );
            FRel.AddCel( FRelGerenciais.ChecaZero( floattostr(Q.fieldbyname('movd_pesovivoabate').ascurrency) ) );
// 22.09.16
            FRel.AddCel( FRelGerenciais.ChecaZero( floattostr(Q.fieldbyname('movd_pesocarcaca').ascurrency) ) );
////////////            FRel.AddCel(floattostr(Q.fieldbyname('movd_pesocarcaca').ascurrency));
            if Q.Fieldbyname('Movd_pesovivoabate').AsCurrency>0 then
              rend:=( Q.Fieldbyname('Movd_pesocarcaca').AsCurrency/Q.Fieldbyname('Movd_pesovivoabate').AsCurrency ) *100
            else
              rend:=0;
            FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrarroba').ascurrency));
// 22.09.16
            FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrabate').ascurrency));
// 27.10.16
            if Q.Fieldbyname('Movd_pesovivoabate').AsCurrency>0 then
              rend:=( Q.Fieldbyname('Movd_pesocarcaca').AsCurrency/Q.Fieldbyname('Movd_pesovivoabate').AsCurrency ) *100
            else
              rend:=0;
            FRel.AddCel( FRelGerenciais.Checazero(floattostr(rend)) );
            FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrarroba').ascurrency*Q.fieldbyname('movd_pesovivo').ascurrency));
            FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrabate').ascurrency*Q.fieldbyname('movd_pesocarcaca').ascurrency));
            FRel.AddCel(floattostr(( Q.fieldbyname('movd_vlrabate').ascurrency*Q.fieldbyname('movd_pesocarcaca').ascurrency )-
                                   ( Q.fieldbyname('movd_vlrarroba').ascurrency*Q.fieldbyname('movd_pesovivo').ascurrency )) );
// 26.10.16
            if Q.fieldbyname('movd_dataabate').Asdatetime > 1 then begin
              dias:=trunc(Q.fieldbyname('movd_dataabate').Asdatetime-Q.fieldbyname('mova_dtabate').AsdateTime);
              if dias>0 then  ganhopeso:=((Q.fieldbyname('movd_pesovivoabate').ascurrency-Q.fieldbyname('movd_pesovivo').ascurrency)/dias)*1
              else            ganhopeso:=0;
            end else begin
              dias:=trunc(sistema.hoje-Q.fieldbyname('mova_dtabate').AsdateTime);
              ganhopeso:=0;
            end;
            FRel.AddCel(floattostr(dias));
            FRel.AddCel(floattostr(ganhopeso));
            QA:=sqltoquery('select esto_descricao from estoque where esto_codigo='+
                           Stringtosql(Q.fieldbyname('movd_esto_codigoven').asstring));
            if not QA.eof then
              FRel.AddCel( QA.fieldbyname('esto_descricao').asstring )
            else
              FRel.AddCel('');
            FGeral.FechaQuery(QA);
// 17.09.15
          end else if xTipomov='PA' then begin
// para nao imprimir nada...
          end else begin
//            FRel.AddCel( FRelGerenciais.Checazero(floattostr(Q.fieldbyname('movd_pecas').ascurrency)) );
            FRel.AddCel( FRelGerenciais.Checazero(formatfloat('#####0.0',Q.fieldbyname('movd_pecas').ascurrency)) );
            FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('movd_esto_codigo').asstring));
//            FRel.AddCel(floattostr(Q.fieldbyname('movd_pesocarcaca').ascurrency));
            FRel.AddCel(formatfloat(f_cr3,Q.fieldbyname('movd_pesocarcaca').ascurrency));
            FRel.AddCel(formatfloat('##0.00',Q.fieldbyname('movd_vlrarroba').ascurrency));
          end;

//          if xTipomov=TipoEntradaAbate then
// 30.07.19
          if AnsiPos(xTipomov,TipoEntradaAbate+';'+TipoLote) >0 then
            FRel.AddCel( floattostr(Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency/15) ) )

          else if xTipomov=TipoEntradaAbate then
// 30.07.19
//        end else if AnsiPos(xTipomov,TipoFazenda+';'+TipoLote) >0 then begin
//            FRel.AddCel( floattostr(Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*Q.Fieldbyname('Movd_vlrarroba').AsCurrency) );
            FRel.AddCel( formatfloat(f_cr,Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*Q.Fieldbyname('Movd_vlrarroba').AsCurrency) );

          if xTipomov<>'PA' then
            FRel.AddCel(Q.fieldbyname('movd_obs').asstring);
// 20.08.19
          if xtipomov = TipoLote then

             FRel.AddCel( FCadCli.GetNome( GetProdutorPeloBrinco(Q.fieldbyname('movd_brinco').asstring) ) );

//          if xTipomov<>TipoEntradaAbate then begin
//            FGeral.PulalinhaRel(FRel.GCol.ColCount);
//            FGeral.ImprimelinhaRel(FRel.GCol.ColCount ,replicate('-',70));
//          end;

        end else begin  // relatorio

          if xSa='A' then begin

            FRel.AddCel(Q.fieldbyname('mova_unid_codigo').asstring);
            FRel.AddCel(Q.fieldbyname('mova_numerodoc').asstring);
            FRel.AddCel(Q.fieldbyname('mova_tipo_codigo').asstring);
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mova_tipo_codigo').asinteger,'C','N'));
            if xTipomov=TipoEntradaAbate then begin
              FRel.AddCel(Q.fieldbyname('mova_dtabate').asstring);
              FRel.AddCel(Q.fieldbyname('mova_dtvenci').asstring);
            end;
            FRel.AddCel(Q.fieldbyname('movd_ordem').asstring);

            if (xTipomov=TipoEntradaAbate) or (xTipomov=TipoFazenda) then begin
              FRel.AddCel(Q.fieldbyname('movd_brinco').asstring);
// 02.07.19
              FRel.AddCel(Q.fieldbyname('movd_baia').asstring);
// 13.06.19 -
              FRel.AddCel( GetNumeroLote );
            end;

            FRel.AddCel(Q.fieldbyname('movd_esto_codigo').asstring);
            FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('movd_esto_codigo').asstring));
            if xTipomov=TipoEntradaAbate then begin

              FRel.AddCel(Q.fieldbyname('movd_idade').asstring);
// 14.04.16
              if Q.fieldbyname('movd_pecas').asinteger>1 then
                FRel.AddCel(floattostr(Q.fieldbyname('movd_pecas').ascurrency))
              else
                FRel.AddCel('1');

              FRel.AddCel(floattostr(Q.fieldbyname('movd_pesovivo').ascurrency));

            end else if xTipomov=TipoFazenda then begin

//              FRel.AddCel(Q.fieldbyname('movd_seto_codigo').asstring+'-'+FSetores.getdescricao(Q.fieldbyname('movd_seto_codigo').asstring));
// 10.05.18
/////////////////////////////////////////////////////
              QFM:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao and mova_tipomov=movd_tipomov )'+
                               ' where movd_brinco = '+Stringtosql(Q.FieldByName('movd_brinco').AsString)+
                               ' and '+FGeral.GetIN('movd_tipomov','FM;LO','C')+
                               ' and movd_status <> ''C'''+
                               ' and ( (movd_abatido is null) or (movd_abatido='''') )'+
//                              ' and movd_datamvto >= '+Datetosql(Sistema.Hoje-60) );
// 05.11.19
//                               ' and movd_datamvto >= '+Datetosql(Sistema.Hoje-180) );
                               ' and movd_datamvto >= '+Datetosql( TexttoDate('01052019') ) );
              if not QFM.Eof then
                FRel.AddCel(QFM.fieldbyname('movd_baia').asstring)
              else
                FRel.AddCel(Q.fieldbyname('movd_baia').asstring);

            end;

            if xTipomov<>TipoFazenda then
               FRel.AddCel(floattostr(Q.fieldbyname('movd_pesocarcaca').ascurrency))
            else begin
               FRel.AddCel(floattostr(Q.fieldbyname('movd_pesovivo').ascurrency));
// 08.04.18
/////////////////////////////////////////////////////
///
{
               QFM:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao and mova_tipomov=movd_tipomov )'+
                               ' where movd_brinco = '+Stringtosql(Q.FieldByName('movd_brinco').AsString)+
                               ' and movd_tipomov = '+Stringtosql('FM')+
                               ' and movd_status <> ''C'''+
                               ' and ( (movd_abatido is null) or (movd_abatido='''') )'+
                               ' and movd_datamvto >= '+Datetosql(Sistema.Hoje-60) );
                               }
               if not QFM.Eof then begin

                 FRel.AddCel(floattostr(QFM.fieldbyname('movd_pesovivo').ascurrency));
                 dias:=trunc(QFM.fieldbyname('movd_datamvto').Asdatetime-Q.fieldbyname('mova_dtabate').AsdateTime);
                 if dias>0 then
                   ganhopeso:=((QFM.fieldbyname('movd_pesovivo').ascurrency-Q.fieldbyname('movd_pesovivo').ascurrency)/dias)*1
                 else
                   ganhopeso:=0;
                 FRel.AddCel(floattostr(dias));
                 FRel.AddCel(floattostr(ganhopeso));
// 30.08.19
                 diasp := dias;
                 dias:=0;ganhopeso:=0;

               end else begin

                 FRel.AddCel('');
                 FRel.AddCel('');
                 FRel.AddCel('');

               end;

               FRel.AddCel(floattostr(Q.fieldbyname('movd_pesovivoabate').ascurrency));
               FRel.AddCel(floattostr(Q.fieldbyname('movd_pesocarcaca').ascurrency));
            end;

            if Q.Fieldbyname('Movd_pesovivo').AsCurrency>0 then
              rend:=( Q.Fieldbyname('Movd_pesocarcaca').AsCurrency/Q.Fieldbyname('Movd_pesovivo').AsCurrency ) *100
            else
              rend:=0;
            if xTipomov=TipoEntradaAbate then begin

              FRel.AddCel(floattostr(rend));
//              FRel.AddCel( floattostr(Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency/15) ) );
// 11.05.15 - Novicarnes - iso
              FRel.AddCel( floattostr(Q.Fieldbyname('Movd_vlrarroba').AsCurrency) );

            end else if xTipomov=TipoFazenda then begin

//              FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrarroba').ascurrency));
// 24.05.19  - buscar na respectiva EA  pelo brinco
// 14.06.19 - ajustes cfe conversa com isonel
               vlrarrobaentrada:=GetValorArrobaEntrada( Q.fieldbyname('movd_brinco').asstring,
                                                        Q.fieldbyname('movd_datamvto').asdatetime,
                                                        Q.fieldbyname('movd_tipo_codigo').asinteger )  ;


               totalentrada:=(vlrarrobaentrada/30)*Q.fieldbyname('movd_pesovivo').ascurrency;

            FRel.AddCel( floattostr( vlrarrobaentrada ) );
//              FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrabate').ascurrency)) ;
// 09.08.17 - valor em arrobas - isonel
              FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrabate').ascurrency*15)) ;

            end else begin
// 26.07.17
               FRel.AddCel(floattostr(Q.fieldbyname('movd_pesovivo').ascurrency));
              FRel.AddCel( FRelGerenciais.Checazero(floattostr(Q.fieldbyname('movd_pecas').ascurrency)) );
//              FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrarroba').ascurrency))
              FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrabate').ascurrency)) ;
            end;
        // 10.08.12
            if (xTipomov=TipoEntradaAbate) or (xtipomov<>TipoFazenda) then
//              FRel.AddCel( floattostr(Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency) ) )
// 12.05.15 - Novicarnes - Isonel - 15.08.17
              FRel.AddCel( floattostr(Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency/15) ) )
// 09.08.17

            else if xtipomov=TipoFazenda then begin

              if Q.Fieldbyname('Movd_pesovivoabate').AsCurrency>0 then
//                rend:=( Q.Fieldbyname('Movd_pesocarcaca').AsCurrency/Q.Fieldbyname('Movd_pesovivo').AsCurrency ) *100
// 10.08.17 - Iso...
                rend:=( Q.Fieldbyname('Movd_pesocarcaca').AsCurrency/Q.Fieldbyname('Movd_pesovivoabate').AsCurrency ) *100
              else
                rend:=0;
// 09.08.17 - estava invertido o rendimento com o total
//              FRel.AddCel( floattostr(Q.Fieldbyname('Movd_pesovivo').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency)/30 ) );
// 15.06.19 - ajustes cfe conversa com isonel
              FRel.AddCel(floattostr(totalentrada)) ;

              FRel.AddCel(floattostr(rend));
// 09.08.17 - vezes 15 par ficar em arroba
              FRel.AddCel( floattostr(Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*(Q.Fieldbyname('Movd_vlrabate').AsCurrency) ) );
//              FRel.AddCel( floattostr( (Q.Fieldbyname('Movd_pesovivo').AsCurrency*Q.Fieldbyname('Movd_vlrarroba').AsCurrency)/30-
//                                       (Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*Q.Fieldbyname('Movd_vlrabate').AsCurrency) ) ) ;

// coluna 'diferen�a' apos coluna 'total abate'
//              FRel.AddCel( floattostr( (Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*Q.Fieldbyname('Movd_vlrabate').AsCurrency)-
//                                         (Q.Fieldbyname('Movd_pesovivo').AsCurrency*Q.Fieldbyname('Movd_vlrarroba').AsCurrency)/30) ) ;

// 26.10.16
              if Q.fieldbyname('movd_dataabate').Asdatetime > 1 then begin

                dias:=trunc(Q.fieldbyname('movd_dataabate').Asdatetime-Q.fieldbyname('mova_dtabate').AsdateTime);
                if dias>0 then
                  ganhopeso:=((Q.fieldbyname('movd_pesovivoabate').ascurrency-Q.fieldbyname('movd_pesovivo').ascurrency)/dias)*1
                else
                  ganhopeso:=0;
// 09.08.17
              end else if Q.fieldbyname('mova_dtabate').Asdatetime > 1 then begin

                dias:=trunc(sistema.hoje-Q.fieldbyname('mova_dtabate').AsdateTime);

              end else begin
//                dias:=trunc(sistema.hoje-Q.fieldbyname('mova_datalcto').AsdateTime);
// 02.07.19
                dias:=trunc(sistema.hoje-Q.fieldbyname('movd_datamvto').AsdateTime);
                ganhopeso:=0;
              end;

// 29.05.20  - custo mensal do confinamento vindo do centro de custo mensal
              custocc := GetValorCCusto( Q.fieldbyname('mova_dtabate').Asdatetime,
                                         Q.fieldbyname('movd_dataabate').Asdatetime,
                                         FRelgerenciais.Eddatai.asdate,
                                         FRelgerenciais.EdDataf.asdate);

              FRel.AddCel( floattostr( custocc ) ) ;

// 29.10.19  - Isonel pegou o erro
              FRel.AddCel( floattostr( (Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*Q.Fieldbyname('Movd_vlrabate').AsCurrency)-
                                       (totalentrada+custocc) ) ) ;

              FRel.AddCel(floattostr(dias));
              FRel.AddCel(floattostr(ganhopeso));
// 30.08.19
              if ( (Dias-Diasp)>0 ) and ( not QFM.Eof ) then begin

                  ganhopeso:=((Q.fieldbyname('movd_pesovivoabate').ascurrency-QFM.fieldbyname('movd_pesovivo').ascurrency)/(Dias-Diasp))*1;
                  FRel.AddCel(floattostr(ganhopeso));

              end else

                FRel.AddCel('');

              QA:=sqltoquery('select esto_descricao from estoque'+
                             ' where esto_codigo='+Stringtosql(Q.fieldbyname('movd_esto_codigoven').asstring));
              if not QA.eof then
                FRel.AddCel( QA.fieldbyname('esto_descricao').asstring )
              else
                FRel.AddCel('');
              FGeral.FechaQuery(QA);
// 09.09.17
              if Q.fieldbyname('mova_dtabate').Asdatetime > 1 then
                FRel.AddCel( Q.Fieldbyname('mova_dtabate').AsString )
              else
//                FRel.AddCel( Q.fieldbyname('mova_datalcto').AsString );
// 02.07.19
                FRel.AddCel( QFM.fieldbyname('movd_datamvto').AsString );
// 08.04.18
              if (QFM <> nil) and (xTipomov=TipoFazenda) then
                FRel.AddCel( QFM.fieldbyname('movd_datamvto').AsString )
              else
                FRel.AddCel('');

              if Q.fieldbyname('movd_dataabate').Asdatetime > 1 then
                FRel.AddCel( Q.fieldbyname('movd_dataabate').AsString )
              else
                FRel.AddCel('');

            end;

            FRel.AddCel(Q.fieldbyname('movd_obs').asstring);
            FGeral.FechaQuery(QFM);

// 29.03.18 - Isonel - Pesagem Intermediaria
////////////////////////////////////////////////////
///  08.04.18 - Isonel prefere colunas a mais e nao linha a mais
{
            if xtipomov=TipoFazenda then begin

               QFM:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao and mova_tipomov=movd_tipomov )'+
                               ' where movd_brinco = '+Stringtosql(Q.FieldByName('movd_brinco').AsString)+
                               ' and movd_tipomov = '+Stringtosql('FM')+
                               ' and movd_status <> ''C'''+
                               ' and movd_abatido is null'+
                               ' and movd_datamvto >= '+Datetosql(Sistema.Hoje-60) );
               while not QFM.Eof do begin
/////////////////////////////////////
                  FRel.AddCel(QFM.fieldbyname('movd_unid_codigo').asstring);
                  FRel.AddCel(QFM.fieldbyname('movd_numerodoc').asstring);
                  FRel.AddCel(QFM.fieldbyname('mova_tipo_codigo').asstring);
                  FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QFM.fieldbyname('movd_tipo_codigo').asinteger,'C','N'));
                  FRel.AddCel(QFM.fieldbyname('movd_ordem').asstring);
                  FRel.AddCel(QFM.fieldbyname('movd_brinco').asstring);

                  FRel.AddCel(QFM.fieldbyname('movd_esto_codigo').asstring);
                  FRel.AddCel(FEstoque.getdescricao(QFM.fieldbyname('movd_esto_codigo').asstring));

                  FRel.AddCel(floattostr(QFM.fieldbyname('movd_pesovivo').ascurrency));
                  FRel.AddCel(floattostr(QFM.fieldbyname('movd_pesovivoabate').ascurrency));
                  FRel.AddCel(floattostr(QFM.fieldbyname('movd_pesocarcaca').ascurrency));

                  FRel.AddCel(floattostr(QFM.fieldbyname('movd_vlrarroba').ascurrency));
                  FRel.AddCel(floattostr(QFM.fieldbyname('movd_vlrabate').ascurrency*15)) ;

                    if QFM.Fieldbyname('Movd_pesovivo').AsCurrency>0 then
                      rend:=( QFM.Fieldbyname('Movd_pesocarcaca').AsCurrency/QFM.Fieldbyname('Movd_pesovivoabate').AsCurrency ) *100
                    else
                      rend:=0;
                    FRel.AddCel( floattostr(QFM.Fieldbyname('Movd_pesovivo').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency)/30 ) );
                    FRel.AddCel(floattostr(rend));

                    FRel.AddCel( floattostr(QFM.Fieldbyname('Movd_pesocarcaca').AsCurrency*(QFM.Fieldbyname('Movd_vlrabate').AsCurrency) ) );
                    FRel.AddCel( floattostr( (QFM.Fieldbyname('Movd_pesocarcaca').AsCurrency*QFM.Fieldbyname('Movd_vlrabate').AsCurrency)-
                                               (QFM.Fieldbyname('Movd_pesovivo').AsCurrency*QFM.Fieldbyname('Movd_vlrarroba').AsCurrency)/30) ) ;

                    if QFM.fieldbyname('movd_dataabate').Asdatetime > 1 then begin
                      dias:=trunc(QFM.fieldbyname('movd_dataabate').Asdatetime-QFM.fieldbyname('mova_dtabate').AsdateTime);
                      if dias>0 then
                        ganhopeso:=((QFM.fieldbyname('movd_pesovivoabate').ascurrency-QFM.fieldbyname('movd_pesovivo').ascurrency)/dias)*1
                      else
                        ganhopeso:=0;
                    end else if QFM.fieldbyname('movd_dataabate').Asdatetime > 1 then begin
                      dias:=trunc(sistema.hoje-QFM.fieldbyname('movd_databate').AsdateTime);
                    end else begin
                      dias:=trunc(sistema.hoje-Q.fieldbyname('mova_datalcto').AsdateTime);
                      ganhopeso:=0;
                    end;
                    FRel.AddCel(floattostr(dias));
                    FRel.AddCel(floattostr(ganhopeso));
                    QA:=sqltoquery('select esto_descricao from estoque'+
                                   ' where esto_codigo='+Stringtosql(QFM.fieldbyname('movd_esto_codigoven').asstring));
                    if not QA.eof then
                      FRel.AddCel( QA.fieldbyname('esto_descricao').asstring )
                    else
                      FRel.AddCel('');
                    FGeral.FechaQuery(QA);

                    if QFM.fieldbyname('movd_dataabate').Asdatetime > 1 then
                      FRel.AddCel( QFM.Fieldbyname('movd_dataabate').AsString )
                    else
                      FRel.AddCel( QFM.fieldbyname('movd_datamvto').AsString );
                    if QFM.fieldbyname('movd_dataabate').Asdatetime > 1 then
                      FRel.AddCel( QFM.fieldbyname('movd_dataabate').AsString )
                    else
                      FRel.AddCel('');


                  FRel.AddCel(QFM.fieldbyname('movd_obs').asstring);


                 QFM.Next;
               end;
               FGeral.FechaQuery(QFM);

            end;
}
///////////////////////////////////////////

          end else begin  // sintetico

            FRel.AddCel(Q.fieldbyname('movd_unid_codigo').asstring);
            FRel.AddCel(Q.fieldbyname('movd_numerodoc').asstring);
            FRel.AddCel(Q.fieldbyname('movd_tipo_codigo').asstring);
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('movd_tipo_codigo').asinteger,'C','N'));
            FRel.AddCel(Q.fieldbyname('movd_esto_codigo').asstring);
            FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('movd_esto_codigo').asstring));
            if xTipomov=TipoEntradaAbate then
              FRel.AddCel(floattostr(Q.fieldbyname('vivo').ascurrency));
            FRel.AddCel(floattostr(Q.fieldbyname('carcaca').ascurrency));
            if Q.Fieldbyname('vivo').AsCurrency>0 then
              rend:=( Q.Fieldbyname('carcaca').AsCurrency/Q.Fieldbyname('vivo').AsCurrency ) *100
            else
              rend:=0;
            if xTipomov=TipoEntradaAbate then  // 10.03.10
              FRel.AddCel(floattostr(rend));
            FRel.AddCel(floattostr(Q.fieldbyname('totpecas').ascurrency));
            if Q.fieldbyname('carcaca').ascurrency>0 then
              FRel.AddCel(floattostr(Q.fieldbyname('vlrtotal').ascurrency/Q.fieldbyname('carcaca').ascurrency))
            else
              FRel.AddCel('');
            FRel.AddCel( floattostr(Q.Fieldbyname('vlrtotal').AsCurrency) ) ;
          end;
        end;

        if (numero<>0) and (unidade<>'') then begin
          Atualiza(Q.Fieldbyname('Movd_esto_codigo').AsString,Q.Fieldbyname('Movd_vlrarroba').AsCurrency,
                                      Q.Fieldbyname('Movd_pesovivo').AsCurrency,Q.Fieldbyname('Movd_pesocarcaca').AsCurrency);
          tpesovivo:=tpesovivo+Q.Fieldbyname('Movd_pesovivo').AsCurrency;
          tpesocarcaca:=tpesocarcaca+Q.Fieldbyname('Movd_pesocarcaca').AsCurrency;
          tvalortotal:=tvalortotal+ ( Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency/15) );
        end;
        Q.Next;
//        if (cliente<>Q.fieldbyname('mpdd_tipo_codigo').asinteger) and ( not Q.eof ) then
//          FGeral.PulalinhaRel(13);

      end;
                                          // 05.06.08
      if (numero<>0) and (unidade<>'') and (pos(xTipomov,TipoEntradaAbate+';'+'PA')>0) then begin
        if xTipomov<>'PA' then begin
          FGeral.PulalinhaRel(11);
          FGeral.PulalinhaRel(11);
        end else begin
          FGeral.PulalinhaRel(03);
          FGeral.PulalinhaRel(03);
        end;
        tpesocarcaca:=0;
        for i:=0 to Lista.count-1 do begin
          PProdutos:=Lista[i];
          if xTipomov<>'PA' then begin
            FRel.AddCel('');  // ordem
            FRel.AddCel('');  // brinco
            FRel.AddCel(PProdutos.produto);
            FRel.AddCel(FEstoque.getdescricao(PProdutos.produto));
            FRel.AddCel('');
            FRel.AddCel( FRelGerenciais.Checazero(floattostr(pProdutos.pesovivo)));
            FRel.AddCel(floattostr(pProdutos.pesocarcaca));
            if pProdutos.pesovivo>0 then
              rend:=( pProdutos.pesocarcaca/pProdutos.pesovivo ) *100
            else
              rend:=0;
            FRel.AddCel(FRelGerenciais.Checazero(floattostr(rend)));
            FRel.AddCel(floattostr( (pProdutos.valortotal) / (pProdutos.pesocarcaca)  ));
            FRel.AddCel( floattostr(pProdutos.valortotal) );
            FRel.AddCel('');
          end else begin
            FRel.AddCel('');  // ordem
//            FRel.AddCel(PProdutos.produto);
            FRel.AddCel(FEstoque.getdescricao(PProdutos.produto));
            FRel.AddCel(floattostr(pProdutos.pesocarcaca));
          end;
          tpesocarcaca:=tpesocarcaca+pProdutos.pesocarcaca;
        end;
        if xTipomov<>'PA' then begin
          FGeral.PulalinhaRel(11);
          FGeral.PulalinhaRel(11);
        end else begin
          FGeral.PulalinhaRel(03);
          FGeral.PulalinhaRel(03);
          FRel.AddCel('');  // ordem
//          FRel.AddCel('');  // codigo
          FRel.AddCel('Total Peso  :');
          FRel.AddCel(FGeral.Formatavalor(tpesocarcaca,'##,##0.00') );
        end;
        if datacont>1 then begin
          valorfunrural:=tvalortotal*(perfunrural/100);
// 01.08.15 - 07.08.15 - elize ligou
          if cooperado='S' then begin
            valorcotacapital:=tvalortotal*(percotacapital/100);
            if pessoafisjur='J' then
              valorcotacapital:=0
          end else
            valorcotacapital:=0;
        end else begin
          valorcotacapital:=0;
          valorfunrural:=0;
        end;
        if xTipomov<>'PA' then begin
          FRel.AddCel('');  // ordem
          FRel.AddCel('');  // brinco
          FRel.AddCel('');  // cod.produto
          FRel.AddCel('Funrural       : '+FGeral.Formatavalor(valorfunrural,'##,##0.00') );
          FRel.AddCel(FGeral.Formatavalor(perfunrural,'%#0.00'));
          FRel.AddCel(FRelGerenciais.Checazero(floattostr(tpesovivo)));
          FRel.AddCel(floattostr(tpesocarcaca));
          if tpesovivo>0 then
            rend:=( tpesocarcaca/tpesovivo ) *100
          else
            rend:=0;
          FRel.AddCel(FRelGerenciais.Checazero(floattostr(rend)));   // rend
          FRel.AddCel(floattostr(tvalortotal/tpesocarcaca));   // vlr arroba
          FRel.AddCel(FGeral.Formatavalor(tvalortotal,'###,##0.00'));
          FRel.AddCel('');
//          FRel.AddCel(FGeral.Formatavalor(tvalortotal-(valorfunrural+valorcotacapital),'###,##0.00') );
          if valorcotacapital>0 then begin
            FRel.AddCel('');  // ordem
            FRel.AddCel('');  // brinco
            FRel.AddCel('');  // cod.produto
            FRel.AddCel('Cota Capital : '+FGeral.Formatavalor(valorcotacapital,'##,##0.00') );
            FRel.AddCel(FGeral.Formatavalor(percotacapital,'%#0.00'));
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');   // rend
            FRel.AddCel('');   // vlr arroba
  //          FRel.AddCel(FGeral.Formatavalor(tvalortotal,'###,##0.00'));
            FRel.AddCel(FGeral.Formatavalor(tvalortotal-(valorfunrural+valorcotacapital),'###,##0.00') );
            FRel.AddCel('');
          end;
// 30.07.15
///////////////////
          FRel.AddCel('');  // ordem
          FRel.AddCel('');  // brinco
          FRel.AddCel('');  // cod.produto
            FRel.AddCel('Valor GTA    : '+FGeral.Formatavalor(valorgta,'##,##0.00') );
          FRel.AddCel(FGeral.Formatavalor(unitariogta,'##0.00'));
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');   // rend
          FRel.AddCel('');   // vlr arroba
          FRel.AddCel(FGeral.Formatavalor(tvalortotal-(valorfunrural+valorcotacapital+valorgta),'###,##0.00') );
          FRel.AddCel('');
          FRel.AddCel('');
        end;
      end;

      if (numero<>0) and (unidade<>'') then begin
        if pos(xTipomov,TipoEntradaAbate+';'+'PA')=0 then
//          FRel.SetaSubTotal2('Descri��o Produto')
//          FRel.Video( '', 'Subtotal' , 1 )
// 04.10.16
          FRel.Video( '' )
        else if xTipomov='PA' then begin
         FRel.Video('','Imprime');
        end else
          FRel.Video( email );
      end else
        FRel.Video;

    end;

    Sistema.EndProcess('');
    FGeral.Fechaquery(Q);
    if (numero=0) or (unidade='') then
      FRelGerenciais_EntradadeAbate(0,'',xTipomov)
    else
      FRelGerenciais.Close;

//  end;

end;

/////////////////////////////////////////////////////////////////// - 05.06.08 - recolocado visando Mag. avenida
procedure FRelGerenciais_ConsigAberto(xcodcliente:integer=0);        // 7
////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqlconsigaberto,produto,remessas,devolucoes,sqlstatus,titgrupo:string;
    vlrremessa,saldoqtde,saldoqtdeclie,remessa,devolucao,vlrremessadev:currency;
    repr,clie:integer;

begin

  with FRelGerenciais do begin

// 01.12.17
    if xcodcliente>0 then begin
      Edcodtipo.setvalue( xcodcliente );
      Edtipocad.Text:='C';
      Edcodtipo.ValidFind;
    end;

    if not FRelGerenciais_Execute(7) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
//  if trim(EdTipomov.text)<>'' then
//      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C')
    sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca+';'+Global.CodVendaTransf,'C');
// sem codigo de devolu�ao de consigna�ao pois este somente � gerado quando � feito o acerto
//  else
//    sqltipomovto:='';

    sqlconsigaberto:='';

    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      if Edtipocad.text='R' then
        sqlcodtipo:=' and move_repr_codigo='+EdCodtipo.assql
      else
        sqlcodtipo:=' and move_tipo_codigo='+EdCodtipo.assql;
    end;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont>1';
// 27.05.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);

//            q fez com q os considerasse...
//    sqlstatus:=' and '+FGeral.Getin('move_status','N,E','C');
// 27.06.13
//    sqlstatus:=' and '+FGeral.Getin('move_status','N,E,D','C') + ' and '+FGeral.Getin('moes_status','N,E,D','C');
// 02.08.18 - retornado para nao considerar status D - nao lembro qual situacao da vivan
    sqlstatus:=' and '+FGeral.Getin('move_status','N,E','C') + ' and '+FGeral.Getin('moes_status','N,E','C');

// 25.10.13 - vivan - liane
    titgrupo:='';
    if not EdGrup_codigo.IsEmpty then begin
      if pos(';',EdGrup_codigo.text)=0 then
        titgrupo:=' - Grupo : '+FGrupos.GetDescricao(EdGrup_codigo.AsInteger)
      else
        titgrupo:=' - Grupos : '+EdGrup_codigo.text;
    end;
    remessas:='6798;7645;7600;7621;7620;7516;6821;7453;7599;7646;6809';
//+';'+strzero(129499,8)
    devolucoes:=strzero(128468,8)+';'+strzero(129728,8)+';'+strzero(129730,8)+';'+strzero(128575,8)+';'+
                  strzero(128425,8)+';'+strzero(128423,8)+';'+strzero(130505,8)+';'+strzero(129499,8);

//    if global.usuario.codigo=300 then begin
//      sqlconsigaberto:=' and '+FGeral.getin('move_numerodoc',remessas+';'+devolucoes,'N');
//      sqlstatus:=' and '+FGeral.GetNOTIN('move_status','C','C');   // 28.04.06
//    end;

    Q:=sqltoquery('select *,esto_grup_codigo from movestoque '+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
//                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc and moes_status=move_status)'+
// 27.06.13
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlconsigaberto+
                  sqlcodtipo+
                  sqlproduto+
                  sqldatacont+
                  sqlstatus+
                  sqlgrupo+
                ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo,move_datalcto' );
//                ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_transacao' );
//                ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_numerodoc' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      FRel.Init('RelConsigAberto');
      if EdCodtipo.isempty then
        FRel.AddTit('Relat�rio de Consigna��es em Aberto '+titgrupo)
      else
        FRel.AddTit('Relat�rio de Consigna��es em Aberto - '+FGeral.Gettipoentidade(EdTipocad.text)+' - '+EdCodtipo.text+' - '+SetEdfavorecido.text+titgrupo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 45,1,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(120,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
      FRel.AddCol( 40,0,'C','' ,''              ,'Cod.'            ,''         ,'',False);
      FRel.AddCol(120,0,'C','' ,''              ,'Cliente'         ,''         ,'',False);
      FRel.AddCol( 80,0,'C','' ,''              ,'Cod.Prod'        ,''         ,'',False);
      FRel.AddCol(130,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
      FRel.AddCol( 50,1,'C','' ,''              ,'Documento'        ,''         ,'',False);
      FRel.AddCol( 60,3,'D','' ,''              ,'Data'             ,''         ,'',False);
      FRel.AddCol( 60,1,'C','' ,''              ,'Tipo'             ,''         ,'',False);
// 10.10.12 - Vivan
      FRel.AddCol(100,1,'C','' ,''              ,'Tamanho'          ,''         ,'',False);
      FRel.AddCol(100,1,'C','' ,''              ,'Cor'              ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Remessa'         ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Devolvida'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''              ,'Remessa-Devolvida'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','' ,''              ,'Saldo Produto'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','' ,''              ,'Saldo Cliente'        ,''         ,'',False);
//      FRel.AddCol( 80,3,'N','' ,''              ,'Saldo '               ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',''              ,'Valor Total'          ,''         ,'',False);

      while not Q.eof  do begin
        repr:=Q.fieldbyname('move_repr_codigo').asinteger;
        while (not Q.eof) and (repr=Q.fieldbyname('move_repr_codigo').asinteger)  do begin
          clie:=Q.fieldbyname('move_tipo_codigo').asinteger;
          saldoqtdeclie:=0;
          while (not Q.eof) and (repr=Q.fieldbyname('move_repr_codigo').asinteger) and (clie=Q.fieldbyname('move_tipo_codigo').asinteger)  do begin
            produto:=Q.fieldbyname('move_esto_codigo').asstring;
            saldoqtde:=0;
            while (not Q.eof) and (repr=Q.fieldbyname('move_repr_codigo').asinteger) and (clie=Q.fieldbyname('move_tipo_codigo').asinteger)
              and (produto=Q.fieldbyname('move_esto_codigo').asstring) do begin
// 27.06.13
              IF Q.fieldbyname('move_status').asstring<>'D' then begin

              FRel.AddCel(Q.fieldbyname('move_unid_codigo').asstring);

//              FRel.AddCel(inttostr(Q.fieldbyname('move_repr_codigo').asinteger));
// 31.01.05
              FRel.AddCel(inttostr(Q.fieldbyname('moes_repr_codigo').asinteger));
              FRel.AddCel(FRepresentantes.GetDescricao(Q.fieldbyname('moes_repr_codigo').asinteger));
              FRel.AddCel(Q.fieldbyname('move_tipo_codigo').asstring);
//              FRel.AddCel(FCadcli.GetNome(Q.fieldbyname('move_tipo_codigo').asinteger));
              if Q.fieldbyname('move_tipo_codigo').asinteger=0 then
                FRel.AddCel('')
              else
                FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('move_tipo_codigo').asinteger,Q.fieldbyname('move_tipocad').asstring,'N'));
              FRel.AddCel(Q.fieldbyname('move_esto_codigo').asstring);
              FRel.AddCel(FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').asstring));
              FRel.AddCel(Q.fieldbyname('move_numerodoc').asstring);
              FRel.AddCel(formatdatetime('dd/mm/yy',Q.fieldbyname('move_datamvto').asdatetime));
              FRel.AddCel(Q.FieldByName('move_tipomov').AsString);
// 10.10.12 - Vivan
              FRel.AddCel(FTamanhos.GetDescricao(Q.fieldbyname('move_tama_codigo').asinteger));
              FRel.AddCel(FCores.GetDescricao(Q.fieldbyname('move_core_codigo').asinteger));
              remessa:=0 ; devolucao:=0;
              if ( pos( Q.fieldbyname('move_tipomov').asstring,Global.CodRemessaConsig+';'+Global.CodVendaTransf )>0 )
                then begin
                FRel.AddCel(transform(Q.fieldbyname('move_qtde').ascurrency,f_qtdestoque));
                FRel.AddCel('');
                remessa:=Q.fieldbyname('move_qtde').ascurrency;
                saldoqtde:=saldoqtde+Q.fieldbyname('move_qtde').ascurrency;
                saldoqtdeclie:=saldoqtdeclie+Q.fieldbyname('move_qtde').ascurrency;
                vlrremessa:=(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency);
              end else begin
                FRel.AddCel('');
                devolucao:=Q.fieldbyname('move_qtde').ascurrency;
                FRel.AddCel(transform(Q.fieldbyname('move_qtde').ascurrency,f_qtdestoque));
                saldoqtde:=saldoqtde-Q.fieldbyname('move_qtde').ascurrency;
                saldoqtdeclie:=saldoqtdeclie-Q.fieldbyname('move_qtde').ascurrency;
                vlrremessa:=(-1)*(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency);
              end;
               vlrremessadev:=(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency);
              FRel.AddCel(transform(remessa-devolucao,f_cr));
              FRel.AddCel(transform(saldoqtde,f_cr));
//              FRel.AddCel(transform(remessa-devolucao,f_cr));
              FRel.AddCel(transform(saldoqtdeclie,f_cr));
              FRel.AddCel(transform(vlrremessa,f_cr));
//              FRel.AddCel(transform(vlrremessadev,f_cr));
              End; // status <> 'D'
              Q.Next;
            end;  // por produto
          end;  // por cliente
        end; // por representante
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;

end;


// 24.12.08 - Isonel - Novicarnes
procedure FRelGerenciais_ComissoesporGrupo;           // 31
////////////////////////////////////////////////////////////////////
var Q,QF:TSqlquery;
    statusvalidos,sqlorder,sqlunidade,sqltipocod,tiposvenda,tiposdev,titulo,devolucoes:string;
    avista,aprazo,devolucao,comissao,percomissao,perbonus,percomissao2,desconto:currency;
begin
  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(31) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    statusvalidos:='N;E';
    sqlorder:=' order by moes_unid_codigo,moes_repr_codigo,moes_tipo_codigo,moes_numerodoc,move_esto_codigo';
    sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
    if EdCodtipo.Asinteger>0 then begin
      if Edtipocad.text='R' then
        sqltipocod:=' and moes_repr_codigo='+EdCodtipo.assql
      else
        sqltipocod:=' and ( (moes_tipo_codigo='+EdCodtipo.assql+') and (moes_tipocad='+EdTipocad.Assql+') )';
    end else
      sqltipocod:='';
    if EdTipomov.isempty then begin
      Tiposvenda:=Global.TiposRelVenda;
      Tiposdev:=Global.TiposRelDevVenda;
    end else begin
      tiposvenda:=EdTipomov.text;
    end;

    devolucoes:=Global.CodDevolucaoVenda+';'+Global.CodDevolucaoRoman+';'+Global.CodDevolucaoSerie5+';'+Global.CodDevolucaoIgualVenda;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and moes_datacont>1';
// 27.05.10
      sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);

    titulo:='Comiss�o sobre Produtos no Faturamento de '+FGeral.FormataData(Eddatai.asdate)+' a '+FGeral.FormataData(Eddataf.asdate)+
            ' - Tipos Impressos: '+TiposVenda+';'+TiposDev ;
    Q:=sqltoquery('select * from movestoque inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                  ' and moes_datamvto>='+Eddatai.AsSql+' and moes_datamvto<='+Eddataf.AsSql+
                  sqlunidade+
                  sqltipocod+
                  sqldatacont+
                  ' and '+FGeral.getin('moes_tipomov',tiposvenda+';'+tiposdev,'C')+
                  sqlorder );


    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      FRel.Init('RelComissoesFatporGrupo');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
//      FRel.AddTit(Periodo);
//      FRel.AddCol( 70,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
//      FRel.AddCol( 60,1,'D','' ,''              ,'Lan�amento'      ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Emiss�o'         ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
//      FRel.AddCol( 40,0,'C','' ,''              ,'CFOP'            ,''         ,'',False);
      FRel.AddCol( 90,1,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
//      FRel.AddCol( 80,0,'C','' ,''              ,'Forma Pagto'     ,''         ,'',false);
//      FRel.AddCol( 90,0,'C','' ,''              ,'Portador'        ,''         ,'',false);
//      FRel.AddCol( 60,0,'C','' ,''              ,'Tipo'            ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Cod.repres.'     ,''         ,'',false);
      FRel.AddCol(140,0,'C','' ,''              ,'Nome repres.'    ,''         ,'',false);
//      FRel.AddCol(080,3,'N','+',f_cr            ,'Total Produtos'     ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Produto'         ,''         ,'',false);
      FRel.AddCol(140,0,'C','' ,''              ,'Descri��o'       ,''         ,'',false);
// 19.10.16
      if Global.topicos[1231] then
        FRel.AddCol(080,3,'N','',f_cr            ,'Unit�rio'   ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Total Produto'   ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Devolu��es'      ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Total'      ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor desconto'  ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor comiss�o'  ,''         ,'',false);
      FRel.AddCol(080,3,'N','',f_cr             ,'Perc. comiss�o'  ,''         ,'',false);
      FRel.AddCol(070,1,'D','',''               ,'Data Baixa'     ,''         ,'',false);
{
      FRel.AddCol(100,1,'C','' ,''              ,'Cidade'          ,''         ,'',False);
      FRel.AddCol( 40,1,'C','' ,''              ,'Estado'          ,''         ,'',False);
      FRel.AddCol( 80,3,'C','' ,''              ,'Popula��o'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','' ,''              ,'Cod usuario'  ,''         ,'',False);
      FRel.AddCol(100,1,'C','' ,''              ,'Nome'  ,''         ,'',False);
}
      while not Q.eof do begin
//          FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
          FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
          FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
//          FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
          FRel.AddCel(Q.FieldByName('moes_datacont').AsString);
          FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
//          FRel.AddCel(Q.FieldByName('moes_natf_codigo').AsString);
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));
//          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('moes_fpgt_codigo').AsString));
//          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('moes_port_codigo').AsString));
//          FRel.AddCel(Q.FieldByName('moes_tipocad').AsString);
          FRel.AddCel(Q.FieldByName('moes_tipo_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'N'));
          FRel.AddCel(Q.FieldByName('moes_repr_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_repr_codigo').AsInteger,'R','N'));
          FRel.AddCel(Q.FieldByName('move_esto_codigo').AsString);
          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
// 19.10.16
          if Global.topicos[1231] then
             FRel.AddCel(floattostr(Q.FieldByName('move_venda').Ascurrency));
          avista:=0;aprazo:=0;
          if pos(Q.Fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 then  begin
//             aprazo:=Q.FieldByName('moes_totprod').Ascurrency;
//             aprazo:=Q.FieldByName('moes_vlrtotal').Ascurrency;
             aprazo:=Q.FieldByName('move_venda').Ascurrency*Q.FieldByName('move_qtde').Ascurrency;
             FRel.AddCel(floattostr(aprazo));
          end else begin
            FRel.AddCel('');
          end;
          devolucao:=0;
          if pos( Q.FieldByName('moes_tipomov').AsString,Devolucoes )>0 then begin
//            devolucao:=Q.FieldByName('moes_totprod').Ascurrency;
            devolucao:=Q.FieldByName('move_venda').Ascurrency*Q.FieldByName('move_qtde').Ascurrency;
            FRel.AddCel( floattostr(devolucao) );
          end else
            FRel.AddCel('');
          FRel.AddCel(valortosql(avista+aprazo-devolucao));
// 03.12.08
//          if pos( Q.FieldByName('moes_tipomov').AsString,Global.CodContrato )>0 then begin
//            percomissao:=Q.FieldByName('moes_percomissao').AsCurrency;
//            percomissao2:=Q.FieldByName('moes_percomissao2').AsCurrency;
//          end else begin
// 19.10.16
            if Global.topicos[1231] then
              percomissao:=FEstoque.GetPercComissaoporFaixa(Q.FieldByName('move_esto_codigo').AsString,Q.fieldbyname('move_venda').ascurrency)
            else
              percomissao:=FGrupos.GetPercentualComissao(Q.fieldbyname('esto_grup_codigo').asinteger,Q.FieldByName('move_esto_codigo').AsString,Q.FieldByName('move_unid_codigo').AsString);
            percomissao2:=0;
//          end;
//          perbonus:=FRepresentantes.GetPerBonus(Q.FieldByName('moes_repr_codigo').Asinteger,Q.FieldByName('moes_datamvto').AsDatetime,Q.FieldByName('moes_tipomov').AsString);
// 03.12.08 - desativado para ver se cria campo no cadastro de representantes
          perbonus:=0;
          desconto:=0;
          if Q.fieldbyname('move_venda').ascurrency<Q.fieldbyname('move_vendamin').ascurrency then
            desconto:= ( ( Q.fieldbyname('move_vendamin').ascurrency-Q.fieldbyname('move_venda').ascurrency ) * Q.FieldByName('move_qtde').Ascurrency ) * (percomissao/100);
          comissao:=(avista+aprazo-devolucao) * (percomissao)/100;
          comissao:=comissao+ ( comissao*(perbonus/100) );
          FRel.AddCel(valortosql(desconto));
          FRel.AddCel(valortosql(comissao-desconto));
          FRel.AddCel(valortosql(percomissao));
//          FRel.AddCel(valortosql(perbonus));
          QF:=sqltoquery('select pend_databaixa from pendencias where pend_rp=''R'' and pend_transacao='+stringtosql(Q.FieldByName('moes_transacao').AsString));
          if not QF.eof then begin
            if QF.fieldbyname('pend_databaixa').AsDateTime>0 then
              FRel.AddCel(FGeral.Formatadata(QF.fieldbyname('pend_databaixa').AsDateTime) )
            else
              FRel.AddCel('');
          end else
              FRel.AddCel('');
          FGeral.FechaQuery(QF);
{
          FRel.AddCel(FCadcli.GetCidade(Q.FieldByName('moes_tipo_codigo').Asinteger));
          FRel.AddCel(FCadcli.GetUf(Q.FieldByName('moes_tipo_codigo').Asinteger));
          FRel.AddCel(inttostr(FCadcli.GetPopulacao(Q.FieldByName('moes_tipo_codigo').Asinteger)));
// 02.09.05
          FRel.AddCel(Q.FieldByName('moes_usua_codigo').Asstring);
          FRel.AddCel(FUsuarios.getnome(Q.FieldByName('moes_usua_codigo').Asinteger));
}
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

    FRelGerenciais_ComissoesporGrupo;     // 31

  end;

end;


///////////////////////////////////////////////////////
procedure FRelGerenciais_AuditoriaFiscalItens;    // 32
///////////////////////////////////////////////////////
var Q,QMovb:TSqlquery;
    doc,tiposnao,sqlcfops,sqltipos,titentsai:string;
    valorimposto,totalprodutos,baseicmscheia,baseicms,redubase,baseicmsconf,totalitem,ipiitem,
    descontoitem,freteitem,subsitem:currency;
begin
  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(32) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+Global.CodContrato ;
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if trim(EdTipomov.text)<>'' then
      sqltipomovto:=' and '+FGeral.getin('moes_tipomov',EdTipomov.text,'C')
    else
      sqltipomovto:='';
// 30.05.05
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and moes_tipo_codigo='+EdCodtipo.assql;
      if Edtipocad.text='R' then
        sqlcodtipo:=' and moes_repr_codigo='+EdCodtipo.assql;

    end;
// 12.12.08
    sqlcfops:='';
    if not EdCfops.IsEmpty then
      sqlcfops:=' and '+FGeral.GetIN('move_natf_codigo',EdCfops.text,'C');
// 04.12.13 - metalforte
    if EdEntSai.text='E' then begin
      sqltipos:=' and substr(moes_natf_codigo,1,1) in (''1'',''2'',''3'')';
      titentsai:=' - ENTRADAS';
    end else if EdEntSai.text='S' then begin
      sqltipos:=' and substr(moes_natf_codigo,1,1) in (''5'',''6'',''7'')';
      titentsai:=' - SAIDAS';
    end else begin
      sqltipos:='';
      titentsai:=' - ENTRADAS E SAIDAS';
    end;

// retornado esta em 02.09.05
    Q:=sqltoquery('select * from movestoque'+
                  ' inner join movesto on ( move_transacao=moes_transacao and move_tipomov=moes_tipomov )'+
//                  ' left join movbase on (moes_transacao=movb_transacao and moes_status=movb_status and moes_tipomov=movb_tipomov)'+
// 01.09.08
//                ' left join movbase on (moes_transacao=movb_transacao and moes_tipomov=movb_tipomov and movb_status<>''C'')'+
// 14.12.13 - retirado pois para cada cfop no movbase mostra o produto de novo...
                  ' where moes_datamvto>='+EdDatai.AsSql+' and moes_datamvto<='+EdDataf.AsSql+
                  sqlunidade+sqltipomovto+sqlcodtipo+
                  ' and '+fGeral.GetNOTIN('moes_tipomov',tiposnao,'C')+
                  ' and moes_natf_codigo is not null '+
                  ' and '+FGeral.Getin('moes_status','N;X;E;D;Y','C')+
                  ' and '+FGeral.Getin('move_status','N;X;E;D;Y','C')+
                  ' and moes_datacont is not null'+
                  sqlcfops+sqltipos+
//                  ' and movb_status<>''C'''+  / assim 'nao pega' conhecimentos-CT
                  ' order by moes_unid_codigo,moes_datalcto,moes_numerodoc,move_cst' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      FRel.Init('RelAuditoriaFiscalItens');
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
      FRel.AddTit('Rela��o de Auditoria Fiscal dos Itens das Notas'+titentsai);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 80,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'  ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Emiss�o'    ,''         ,'',false);
      FRel.AddCol( 60,2,'N','' ,''              ,'Nota'     ,''         ,'',False);
//      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Repres.'     ,''         ,'',false);
//      FRel.AddCol(150,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
      FRel.AddCol( 60,1,'N','' ,''              ,'Cod.Emitente'    ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Emitente'        ,''         ,'',false);
// 11.11.14 - novi - angela
      FRel.AddCol(100,1,'C','' ,''              ,'Grupo'         ,''         ,'',false);

      FRel.AddCol( 60,3,'N','' ,''              ,'Produto'         ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Descri��o'       ,''         ,'',false);
      FRel.AddCol( 80,3,'N','' ,f_cr           ,'Confer�ncia'           ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'Cfop'            ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'Esp.'            ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'S�rie'            ,''         ,'',False);
      FRel.AddCol( 20,0,'C','' ,''              ,'UF'              ,''         ,'',False);
      FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
      FRel.AddCol( 40,0,'C','' ,''              ,'CST'              ,''         ,'',False);
// 18.12.17
      FRel.AddCol( 60,0,'C','' ,''              ,'CST Pis/Cofins'   ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Produto c/Desc'  ,''         ,'',False);
      FRel.AddCol(100,3,'N','+',f_cr            ,'Prod.+IPI+Frete+Subs.'  ,''         ,'',False);
      FRel.AddCol( 70,3,'N','+',f_cr            ,'IPI Item'  ,''         ,'',False);
      FRel.AddCol( 70,3,'N','+',f_cr            ,'Subs.Item'  ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Desconto'  ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Frete'  ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Base Icms ' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','' ,'##0.00'        ,'Redu��o'         ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Base Icms Red.'       ,''         ,'',False);
      FRel.AddCol( 60,3,'N','' ,'##0.00'        ,'% ICMS'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor Imposto'   ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Base Icms Subs'  ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Icms Subs' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Ipi Nota'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'% Ipi'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Ipi Item'       ,''         ,'',False);
      doc:='XYzwewe';
      while not Q.eof do begin
        FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
//        FRel.AddCel(Q.FieldByName('moes_datalcto').AsString);
        FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
        FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
        FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
//        FRel.AddCel(Q.fieldbyname('moes_repr_codigo').asstring);
//        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_repr_codigo').asinteger,'R','N'));
        FRel.AddCel(Q.fieldbyname('moes_tipo_codigo').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.FieldByName('moes_tipocad').AsString,'N'));
// 11.11.14 - novi - angela
        FRel.AddCel(FGrupos.GetDescricao( FEstoque.GetGrupo(Q.fieldbyname('move_esto_codigo').asstring) ) );
        FRel.AddCel(Q.fieldbyname('move_esto_codigo').asstring);
        FRel.AddCel(FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').asstring));
        totalprodutos:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency;
        if Q.fieldbyname('move_aliicms').ascurrency>0 then
          baseicmscheia:=totalprodutos
        else
          baseicmscheia:=0;
        baseicms:=baseicmscheia;
        redubase:=FCodigosFiscais.GetAliquotaRedBase( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
//        Q.fieldbyname('move_aliicms').ascurrency;
        if redubase >0then
          baseicms:=(baseicms*(redubase/100))
        else
          baseicms:=baseicmscheia;
        QMovb:=sqltoquery('select * from movbase where movb_transacao='+Stringtosql(Q.fieldbyname('move_transacao').asstring)+
                          ' and movb_status=''N'''+
                          ' and movb_natf_codigo='+Stringtosql(Q.fieldbyname('move_natf_codigo').asstring) );
        baseicmsconf:=QMovb.FieldByName('movb_basecalculo').AsCurrency;
        if QMovb.FieldByName('movb_reducaobc').AsCurrency>0 then
          baseicmsconf:=(QMovb.FieldByName('movb_basecalculo').AsCurrency*(QMovb.FieldByName('movb_reducaobc').AsCurrency/100));

//        FRel.AddCel(floattostr(baseicmsconf));
        FRel.AddCel(floattostr(Q.fieldbyname('moes_vlrtotal').ascurrency));
        if trim(QMovb.FieldByName('movb_natf_codigo').AsString)='' then
          FRel.AddCel(Q.FieldByName('moes_natf_codigo').AsString)
        else
          FRel.AddCel(QMOvb.FieldByName('movb_natf_codigo').AsString);
        FRel.AddCel(Q.FieldByName('moes_especie').AsString);
        FRel.AddCel(Q.FieldByName('moes_serie').AsString);
        FRel.AddCel(Q.FieldByName('moes_estado').AsString);
        if Q.FieldByName('moes_status').AsString='X' then
          FRel.AddCel('Nota fiscal cancelada')
        else if Q.FieldByName('moes_status').AsString='Y' then
          FRel.AddCel('Nfe Denegada')
        else
//          FRel.AddCel(Q.FieldByName('movb_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('movb_tipomov').AsString));
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));

          FRel.AddCel(Q.FieldByName('move_cst').AsString);
// 18.12.17
        if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then
          FRel.AddCel( FEstoque.GetsituacaotributariaPIS(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring) )
        else
          FRel.AddCel( FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) )   );

          totalitem:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency;
          ipiitem:=totalitem*(Q.FieldByName('move_aliipi').Ascurrency/100);
          if Q.FieldByName('moes_vlrtotal').Ascurrency>0 then
            freteitem:=(Q.FieldByName('moes_frete').Ascurrency/Q.FieldByName('moes_vlrtotal').Ascurrency)*100
          else
            freteitem:=0;
          freteitem:=totalitem*(freteitem/100);
//          totalitem:=totalitem-(  totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100) );
          descontoitem:=totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100);
          FRel.AddCel(floattostr(totalitem-descontoitem));
//        subsitem:=(Q.FieldByName('moes_valoricmssutr').Ascurrency/Q.FieldByName('moes_vlrtotal').Ascurrency)*100 ;
          if pos( Q.FieldByName('move_natf_codigo').AsString,'1403;2403;1910;2910' )>0 then begin
            if QMovb.FieldByName('movb_basecalculo').AsCurrency>0 then
              subsitem:=(Q.FieldByName('moes_valoricmssutr').Ascurrency/QMovb.FieldByName('movb_basecalculo').AsCurrency)*100
            else
              subsitem:=0;
            subsitem:=totalitem*(subsitem/100);
          end else
            subsitem:=0;
          if pos(QMOvb.FieldByName('movb_natf_codigo').AsString,'1403;2403;1910;2910')>0 then
            FRel.AddCel(floattostr(totalitem+ipiitem-descontoitem+freteitem+subsitem))
          else
            FRel.AddCel(floattostr(totalitem+ipiitem-descontoitem+freteitem));

          FRel.AddCel(floattostr(ipiitem));
          FRel.AddCel(floattostr(subsitem));
          FRel.AddCel(floattostr(descontoitem));
          FRel.AddCel(floattostr(freteitem));

          QMOvb.Close;QMOvb.free;
          FRel.AddCel( floattostr(baseicmscheia) );
          FRel.AddCel( floattostr(redubase) );
// 21.08.09 - 'adapt. tecnica' devido a nf saida so calc. icms caso houvesse reducao base
          valorimposto:=baseicms*(Q.FieldByName('move_aliicms').AsCurrency/100);
//          if (Q.FieldByName('movb_aliquota').AsCurrency>0) and (Q.FieldByName('movb_basecalculo').AsCurrency>0) and
//             ( pos(Q.FieldByName('moes_tipomov').AsString,Global.TiposSaida)>0 ) and
//             ( Q.FieldByName('movb_reducaobc').Ascurrency=0)
//             then
//             valorimposto:=Q.FieldByName('movb_basecalculo').AsCurrency*(Q.FieldByName('movb_aliquota').AsCurrency/100);
// 14.07.09
          FRel.AddCel( floattostr(baseicms) );
          FRel.AddCel(Q.FieldByName('move_aliicms').AsString);
          FRel.AddCel(floattostr(valorimposto));

        if doc<>Q.FieldByName('moes_numerodoc').AsString then begin
          FRel.AddCel(Q.FieldByName('moes_basesubstrib').AsString);
          FRel.AddCel(Q.FieldByName('moes_valoricmssutr').AsString);
          FRel.AddCel(Q.FieldByName('moes_valoripi').AsString);
        end else begin
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
        end;
// 25.09.11 - detalhament do IPI
        FRel.AddCel(Q.FieldByName('move_aliipi').AsString);
        valorimposto:=totalprodutos*(Q.FieldByName('move_aliipi').AsCurrency/100);
        FRel.AddCel(floattostr(valorimposto));
/////////////////////////
        doc:=Q.FieldByName('moes_numerodoc').AsString;
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);
  end;

  FRelGerenciais_AuditoriaFiscalItens;    // 32

end;


// 28.10.09 - Abra - despesas veiculos
///////////////////////////////////////////////////////////
procedure FRelGerenciais_DespesasVeiculos;     // 33
//////////////////////////////////////////////////////////
type TVeiculos=record

     codveic,
     placa        :string;
     kmi,
     kmf,
     nrokms      :integer;
     ListaValores : TList;
     ListaColaboradores:TStringList;

end;

type TValores=record

     conta  : integer;
     valor  : currency;

end;

type TValoresT=record

     conta  : integer;
     valor  : currency;

end;

var Q             :TSqlquery;
    sqlveiculos,doc,docs,
    sqldocs,
    sqlqueveiculo,
    titveiculo,
    sqlconta,
    titconta      :string;
    totalitem,
    totalvalor,
    totalvalord,
    custokm       :currency;
    ListaDocs     :TStringList;
    ListaVeiculos,
    ListaValoresT :TList;
    PVeiculos     :^TVeiculos;
    PValores      :^TValores;
    PValoresT     :^TValoresT;
    x,
    y,
    p,
    difkm         : Integer;
    achou         : boolean;


    procedure OrdenaLista( Valores:TList );
    //////////////////////////////////////
    var i,
        j,
        aux,
        temp1  : integer;
        Temp   : currency;
        PValoresT1 : ^TValoresT;

    begin

      for i := 0 to Valores.Count - 1 do

          for j := 0 to Valores.Count - 2 do
          begin

            PValorest := Valores[j];
            if ( J + 1 ) <= Valores.Count then begin

              PValorest1 := Valores[j + 1];
  //            if ( PValorest.valor ) > ( PValorest1.valor ) then
              if ( PValorest.valor ) < ( PValorest1.valor ) then
  //            if ansiUpperCase(Valores[j]) > ansiUpperCase(Valores[j + 1]) then
              begin
                TEmp := PValorest.valor;
                TEmp1 := PValorest.conta;
                PValorest.valor := PValorest1.valor;
                PValorest.conta := PValorest1.conta;
  //              Valores[j] := Valores[j + 1];
                PValorest1.valor := temp;
                PValorest1.conta := temp1;
  //              Valores[j + 1 ] := TEmp;
              end;

           end;

          end;
    end;


    procedure AtualizaLista;
    ////////////////////////
    var p          : integer;
        achou      : boolean;
        totalitema : currency;


        procedure AtualizaValoresT;
        ///////////////////////////
        var i:integer;
            achou : boolean;
        begin

           achou := false;
           for i := 0 to ListaValoresT.Count-1 do begin

              PValoresT := ListaValoresT[i];
              if PvaloresT.conta = Q.FieldByName('moes_plan_codigo').AsInteger then begin
                 achou := true;
                 break;
              end;

           end;

           if NOT achou then  begin

              New( Pvalorest );
              PValorest.conta := Q.FieldByName('moes_plan_codigo').AsInteger;
              PValorest.valor := totalitema;
              ListaValorest.Add(Pvalorest);

           end else begin

              PValorest.valor := PValorest.valor + totalitema;

           end;

        end;


        procedure AtualizaValores;
        ///////////////////////////
        var i:integer;
            achou : boolean;
        begin

           achou := false;
           for i := 0 to PVeiculos.ListaValores.Count-1 do begin

              PValores := PVeiculos.ListaValores[i];
              if Pvalores.conta = Q.FieldByName('moes_plan_codigo').AsInteger then begin
                 achou := true;
                 break;
              end;

           end;

           if NOT achou then  begin

              New( Pvalores );
              PValores.conta := Q.FieldByName('moes_plan_codigo').AsInteger;
              PValores.valor := totalitema;
              PVeiculos.ListaValores.Add(Pvalores);

           end else begin

              PValores.valor := PValores.valor + totalitema;

           end;

        end;


    begin

       achou := false;
       totalitema := Q.FieldByName('move_venda').Ascurrency*Q.FieldByName('move_qtde').Ascurrency;;
       for p :=0  to ListaVeiculos.count-1 do  begin

         PVeiculos := ListaVeiculos[p];
         if PVeiculos.codveic = Q.FieldByName('moes_tran_codigo').AsString then begin
            achou := true;
            break;
         end;

       end;
       if not achou then begin

          New( PVeiculos );
          PVeiculos.codveic := Q.FieldByName('moes_tran_codigo').AsString;
          PVeiculos.placa   := Q.FieldByName('tran_placa').AsString;
          PVeiculos.kmi     := Strtointdef(Q.FieldByName('moes_km').AsString,0);
          PVeiculos.kmf     := Strtointdef(Q.FieldByName('moes_km').AsString,0);
          PVeiculos.LIstaValores:= TList.Create;
          New( PValores );
          PValores.conta    := Q.FieldByName('moes_plan_codigo').AsInteger;
          PVAlores.valor    := totalitema;
          PVeiculos.ListaValores.add( PValores );
          PVeiculos.ListaColaboradores:= TStringList.Create;
          PVeiculos.ListaColaboradores.Add( Q.FieldByName('moes_cola_codigo').AsString );
          if PVeiculos.kmi > 10 then
             PVeiculos.nrokms :=1
          else begin
            PVeiculos.kmi     := 999999;
            PVeiculos.kmf     := 0;
          end;
          ListaVeiculos.Add(PVeiculos)

       end else begin

          if Strtointdef(Q.FieldByName('moes_km').AsString,0) > 10 then begin

             PVeiculos.nrokms := PVeiculos.nrokms + 1;
             if Strtointdef(Q.FieldByName('moes_km').AsString,0) < PVeiculos.kmi then
                PVeiculos.kmi := Strtointdef(Q.FieldByName('moes_km').AsString,0)
             else if Strtointdef(Q.FieldByName('moes_km').AsString,0) > PVeiculos.kmf then
                PVeiculos.kmf := Strtointdef(Q.FieldByName('moes_km').AsString,0);

          end;

          AtualizaValores;
          AtualizaValoresT;
          if PVeiculos.ListaColaboradores.Indexof( Q.FieldByName('moes_cola_codigo').AsString ) = -1 then
             PVeiculos.ListaColaboradores.Add( Q.FieldByName('moes_cola_codigo').AsString );

       end;

    end;


begin
////////////////////////////////////////
  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(33) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if trim(EdTipomov.text)<>'' then
      sqltipomovto:=' and '+FGeral.getin('moes_tipomov',EdTipomov.text,'C')
    else  // 08.02.10
//      sqltipomovto:=' and '+FGeral.GetNOTIN('moes_tipomov',Global.TiposNaoFiscal,'C');
//      sqltipomovto:=' and '+FGeral.GetNOTIN('moes_tipomov',Global.TiposGeraFinanceiro,'C');
// 12.03.19
      sqltipomovto:=' and '+FGeral.GetIN('moes_tipomov',Global.TiposEntrada,'C');
// 30.05.05
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and moes_tipo_codigo='+EdCodtipo.assql;
      if Edtipocad.text='R' then
        sqlcodtipo:=' and moes_repr_codigo='+EdCodtipo.assql;

    end;
    sqlveiculos:=' and '+FGeral.GetIN('tran_proprio','S','C');
// 17.10.19 - Globalfoods
    sqlqueveiculo:='';
    titveiculo   :='';
    titconta     :='';

    if not EdTran_codigo.IsEmpty then begin
       sqlqueveiculo:=' and moes_tran_codigo = '+EdTran_codigo.AsSql;
       titveiculo   :=' - Veiculo :'+EdTran_codigo.Text+' - '+EdTran_codigo.ResultFind.FieldByName('tran_placa').asstring;
    end;
// 17.12.19
    sqlconta := '';
    titconta := '';
    if not EdPlan_conta.IsEmpty then begin

       sqlconta := ' and moes_plan_codigo = '+EdPlan_conta.AsSql;
       titconta := ' - Conta:'+EdPlan_conta.Text+' - '+Fplano.GetDescricao(EdPlan_conta.AsInteger);

    end;

    Q:=sqltoquery('select * from movestoque'+
                  ' inner join movesto on ( move_transacao=moes_transacao and move_tipomov=moes_tipomov )'+
                  ' inner join transportadores on ( moes_tran_codigo=tran_codigo )'+
                  ' where moes_datamvto>='+EdDatai.AsSql+' and moes_datamvto<='+EdDataf.AsSql+
                  sqlunidade+sqltipomovto+sqlcodtipo+sqlveiculos+sqlqueveiculo+sqlconta+
                  ' and '+FGeral.Getin('moes_status','N;E;D','C')+
                  ' and '+FGeral.Getin('move_status','N;E;D','C')+
                  ' order by moes_unid_codigo,moes_datamvto,moes_numerodoc' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

      ListaDocs:=TStringList.Create;
      docs:='';

      if EdSinAna.Text = 'A' then begin

          FRel.Init('RelDespesasVeiculos');
    //      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
          FRel.AddTit('Rela��o de Notas Fiscais de Ve�culos da Frota');
          FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+TitVeiculo+Titconta );
          FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
          FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
          FRel.AddCol( 80,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
          FRel.AddCol( 60,1,'C','' ,''              ,'Placa Ve�culo'     ,''         ,'',false);
          FRel.AddCol(100,1,'C','' ,''              ,'Ve�culo'         ,''         ,'',false);
          FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Colaborador' ,''         ,'',false);
          FRel.AddCol(100,1,'C','' ,''              ,'Colaborador'     ,''         ,'',false);
          FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'  ,''         ,'',false);
          FRel.AddCol( 60,1,'D','' ,''              ,'Emiss�o'    ,''         ,'',false);
          FRel.AddCol( 60,3,'N','' ,''              ,'Nota'     ,''         ,'',False);
          FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Emitente'    ,''         ,'',false);
          FRel.AddCol(150,1,'C','' ,''              ,'Emitente'        ,''         ,'',false);
          FRel.AddCol( 60,0,'C','' ,''              ,'Tipo Mov.'  ,''         ,'',False);
          FRel.AddCol( 60,3,'N','' ,''              ,'KM' ,''         ,'',False);
          FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor Nota' ,''         ,'',False);
          FRel.AddCol(150,1,'C','' ,''              ,'Conta Despesa'   ,''         ,'',False);
          FRel.AddCol(150,1,'C','' ,''              ,'Descri��o Item'   ,''         ,'',False);
          FRel.AddCol( 60,3,'N','',f_cr3           ,'Unit�rio Item'   ,''         ,'',False);
          FRel.AddCol( 60,3,'N','+',f_cr            ,'Qtde Item'   ,''         ,'',False);
          FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor Item'   ,''         ,'',False);

      end else begin

          FRel.Init('RelDespesasVeiculosSint');
          FRel.AddTit('Custo Ve�culos da Frota por KM rodado');
          FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+TitVeiculo );
          FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
          FRel.AddCol( 60,1,'C','' ,''              ,'Placa Ve�culo'     ,''         ,'',false);
          FRel.AddCol(100,1,'C','' ,''              ,'Ve�culo'         ,''         ,'',false);
          FRel.AddCol(100,1,'C','' ,''              ,'Colaboradores'     ,''         ,'',false);
          FRel.AddCol( 60,3,'N','' ,''              ,'KM INI' ,''         ,'',False);
          FRel.AddCol( 60,3,'N','' ,''              ,'KM FIM' ,''         ,'',False);
          FRel.AddCol( 60,3,'N','' ,''              ,'KM DIF' ,''         ,'',False);
          FRel.AddCol(150,1,'C','' ,''              ,'Despesa 01'   ,''         ,'',False);
          FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor 01' ,''         ,'',False);
          FRel.AddCol( 80,3,'N','&',f_cr            ,'Custo KM 01' ,''         ,'',False);
          FRel.AddCol(150,1,'C','' ,''              ,'Despesa 02'   ,''         ,'',False);
          FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor 02' ,''         ,'',False);
          FRel.AddCol( 80,3,'N','&',f_cr            ,'Custo KM 02' ,''         ,'',False);
          FRel.AddCol(150,1,'C','' ,''              ,'Despesa 03'   ,''         ,'',False);
          FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor 03' ,''         ,'',False);
          FRel.AddCol( 80,3,'N','&',f_cr            ,'Custo KM 03' ,''         ,'',False);
          FRel.AddCol(150,1,'C','' ,''              ,'Despesa 04'   ,''         ,'',False);
          FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor 04' ,''         ,'',False);
          FRel.AddCol( 80,3,'N','&',f_cr            ,'Custo KM 04' ,''         ,'',False);
          FRel.AddCol(150,1,'C','' ,''              ,'Despesa 05'   ,''         ,'',False);
          FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor 05' ,''         ,'',False);
          FRel.AddCol( 80,3,'N','&',f_cr            ,'Custo KM 05' ,''         ,'',False);
          FRel.AddCol(150,1,'C','' ,''              ,'Despesa'   ,''         ,'',False);
          FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor' ,''         ,'',False);
          FRel.AddCol( 80,3,'N','&',f_cr            ,'Custo KM' ,''         ,'',False);
          FRel.AddCol( 80,3,'N','+',f_cr            ,'Total' ,''         ,'',False);
          FRel.AddCol( 80,3,'N','&',f_cr            ,'Custo KM Tot' ,''         ,'',False);
          ListaValoresT := TList.Create;

      end;

      doc:='XYzwewe';
      ListaVeiculos := TList.Create;

      while not Q.eof do begin

        if EdSinAna.Text = 'A' then begin

          FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
          FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
          FRel.AddCel(Q.FieldByName('tran_placa').AsString);
          FRel.AddCel(Q.FieldByName('tran_nome').AsString);
  //        FRel.AddCel(Q.FieldByName('moes_datalcto').AsString);
          FRel.AddCel(Q.fieldbyname('moes_cola_codigo').asstring);
          FRel.AddCel(FColaboradores.GetDescricao(Q.fieldbyname('moes_cola_codigo').asstring));
          FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
          FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
          FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
          FRel.AddCel(Q.fieldbyname('moes_tipo_codigo').asstring);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.FieldByName('moes_tipocad').AsString,'N'));
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString);
          FRel.AddCel(Q.FieldByName('moes_km').AsString);
          if doc<>Q.FieldByName('moes_numerodoc').AsString then begin
            FRel.AddCel( floattostr(Q.FieldByName('moes_vlrtotal').Ascurrency) );
          end else begin
            FRel.AddCel('');
          end;
          FRel.AddCel( FPLano.GetDescricao( Q.FieldByName('moes_plan_codigo').AsInteger ) );
          FRel.AddCel( FEstoque.GetDescricao( Q.FieldByName('move_esto_codigo').AsString ) );
          totalitem:=Q.FieldByName('move_venda').Ascurrency*Q.FieldByName('move_qtde').Ascurrency;
          FRel.AddCel( floattostr(Q.FieldByName('move_venda').Ascurrency) );
          FRel.AddCel( floattostr(Q.FieldByName('move_qtde').Ascurrency) );
          FRel.AddCel( floattostr(totalitem) );

        end else begin

          AtualizaLista;

        end;

        doc:=Q.FieldByName('moes_numerodoc').AsString;
        if ListaDocs.IndexOf(doc)=-1 then begin
          ListaDocs.Add(doc);
          docs:=docs+doc+';';
        end;

        Q.Next;

      end;

// prevendo notas 'sem itens'
      FGeral.FechaQuery(q);
      if Listadocs.Count>0 then
        sqldocs:=' and '+FGeral.GetNOTIN('moes_numerodoc',docs,'N')
      else
        sqldocs:='';

// 12.12.19 - s� pra dar eof e nao fazer nada...
      if EdSinAna.Text = 'S' then sqldocs:=' and moes_numerodoc = 91919191';

      Q:=sqltoquery('select * from movesto'+
                  ' inner join transportadores on ( moes_tran_codigo=tran_codigo )'+
                  ' where moes_datamvto>='+EdDatai.AsSql+' and moes_datamvto<='+EdDataf.AsSql+
                  sqlunidade+sqltipomovto+sqlcodtipo+sqlveiculos+sqldocs+
                  sqlqueveiculo+
                  ' and '+FGeral.Getin('moes_status','N;E;D','C')+
                  ' order by moes_unid_codigo,moes_datamvto,moes_numerodoc' );

      while not Q.eof do begin

        FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
        FRel.AddCel(Q.FieldByName('tran_placa').AsString);
        FRel.AddCel(Q.FieldByName('tran_nome').AsString);
//        FRel.AddCel(Q.FieldByName('moes_datalcto').AsString);
        FRel.AddCel(Q.fieldbyname('moes_cola_codigo').asstring);
        FRel.AddCel(FColaboradores.GetDescricao(Q.fieldbyname('moes_cola_codigo').asstring));
        FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
        FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
        FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
        FRel.AddCel(Q.fieldbyname('moes_tipo_codigo').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.FieldByName('moes_tipocad').AsString,'N'));
        FRel.AddCel(Q.FieldByName('moes_tipomov').AsString);
        FRel.AddCel('');
        FRel.AddCel('' );
        totalitem:=0;
        FRel.AddCel( floattostr(totalitem) );
        FRel.AddCel( FPLano.GetDescricao( Q.FieldByName('moes_plan_codigo').AsInteger ) );
        FRel.AddCel('');
        FRel.AddCel('' );
        FRel.AddCel('' );
        Q.Next;

      end;

      if EdSinAna.Text = 'S' then begin

         OrdenaLista( ListaValoresT );

         for x := 0 to ListaVeiculos.Count-1  do begin

           PVeiculos := ListaVeiculos[x];
           FRel.AddCel( PVeiculos.placa );
           FRel.AddCel( FTransp.GetNome( PVeiculos.codveic ) );
           if PVeiculos.ListaColaboradores.Count>=4 then

             FRel.AddCel( PVeiculos.ListaColaboradores[0]+';'+PVeiculos.ListaColaboradores[01]+';'+
                          PVeiculos.ListaColaboradores[02]+';'+PVeiculos.ListaColaboradores[03] )

           else if PVeiculos.ListaColaboradores.Count>=3 then

             FRel.AddCel( PVeiculos.ListaColaboradores[0]+';'+PVeiculos.ListaColaboradores[01]+';'+
                          PVeiculos.ListaColaboradores[02] )

           else if PVeiculos.ListaColaboradores.Count>=2 then

             FRel.AddCel( PVeiculos.ListaColaboradores[0]+';'+PVeiculos.ListaColaboradores[01] )

           else

             FRel.AddCel( PVeiculos.ListaColaboradores[0] );


           FRel.AddCel( floattostr( PVeiculos.kmi) );
           FRel.AddCel( floattostr( PVeiculos.kmf) );
           difkm :=  PVeiculos.kmf - PVeiculos.kmi;

           FRel.AddCel( floattostr( difkm  ) );
           totalvalor:=0;

           achou := false;
           for y := 0 to PVeiculos.ListaValores.Count-1 do  begin

              PValores := PVeiculos.ListaValores[y];
              PValoresT := ListaValoresT[0];
              if PValores.conta = PValorest.conta then begin

                FRel.AddCel( FPlano.GetDescricao( PValores.conta ) );
                FRel.AddCel( floattostr( PValores.valor ) );
                if difkm > 0 then

                  FRel.AddCel( floattostr( PValores.valor/difkm ) )

                else

                  FRel.AddCel( '' );
                totalvalor := totalvalor + PValores.valor;
                achou := true;

              end;

           end;

           if not achou then begin
              FRel.AddCel( '' );
              FRel.AddCel( '' );
              FRel.AddCel( '' );
           end;

           achou := false;
           for y := 0 to PVeiculos.ListaValores.Count-1 do  begin

              PValores := PVeiculos.ListaValores[y];
              if ListaValoresT.Count < 2 then break;
              PValoresT := ListaValoresT[1];
              if PValores.conta = PValorest.conta then begin

                FRel.AddCel( FPlano.GetDescricao( PValores.conta ) );
                FRel.AddCel( floattostr( PValores.valor ) );
                totalvalor := totalvalor + PValores.valor;
                achou := true;
                if difkm > 0 then

                  FRel.AddCel( floattostr( PValores.valor/difkm ) )

                else

                  FRel.AddCel( '' );

              end;

           end;

           if not achou then begin
              FRel.AddCel( '' );
              FRel.AddCel( '' );
              FRel.AddCel( '' );
           end;

           achou := false;
           for y := 0 to PVeiculos.ListaValores.Count-1 do  begin

              PValores := PVeiculos.ListaValores[y];
              if ListaValoresT.Count < 3 then break;
              PValoresT := ListaValoresT[2];
              if PValores.conta = PValorest.conta then begin

                FRel.AddCel( FPlano.GetDescricao( PValores.conta ) );
                FRel.AddCel( floattostr( PValores.valor ) );
                totalvalor := totalvalor + PValores.valor;
                achou := true;
                if difkm > 0 then

                  FRel.AddCel( floattostr( PValores.valor/difkm ) )

                else

                  FRel.AddCel( '' );

              end;

           end;

           if not achou then begin
              FRel.AddCel( '' );
              FRel.AddCel( '' );
              FRel.AddCel( '' );
           end;

           achou := false;
           for y := 0 to PVeiculos.ListaValores.Count-1 do  begin

              PValores := PVeiculos.ListaValores[y];
              if ListaValoresT.Count < 3 then break;
              PValoresT := ListaValoresT[2];
              if PValores.conta = PValorest.conta then begin

                FRel.AddCel( FPlano.GetDescricao( PValores.conta ) );
                FRel.AddCel( floattostr( PValores.valor ) );
                totalvalor := totalvalor + PValores.valor;
                achou := true;
                if difkm > 0 then

                  FRel.AddCel( floattostr( PValores.valor/difkm ) )

                else

                  FRel.AddCel( '' );

              end;

           end;

           if not achou then begin
              FRel.AddCel( '' );
              FRel.AddCel( '' );
              FRel.AddCel( '' );
           end;

           achou := false;
           for y := 0 to PVeiculos.ListaValores.Count-1 do  begin

              PValores := PVeiculos.ListaValores[y];
              if ListaValoresT.Count < 4 then break;
              PValoresT := ListaValoresT[3];
              if PValores.conta = PValorest.conta then begin

                FRel.AddCel( FPlano.GetDescricao( PValores.conta ) );
                FRel.AddCel( floattostr( PValores.valor ) );
                totalvalor := totalvalor + PValores.valor;
                achou := true;
                if difkm > 0 then

                  FRel.AddCel( floattostr( PValores.valor/difkm ) )

                else

                  FRel.AddCel( '' );

              end;

           end;

           if not achou then begin
              FRel.AddCel( '' );
              FRel.AddCel( '' );
              FRel.AddCel( '' );
           end;

           totalvalord := 0;
           for y := 0 to PVeiculos.ListaValores.Count-1 do  begin

              if ListaValoresT.Count < 5 then break;

              for p := 5 to ListaValorest.Count-1 do begin

                PValores := PVeiculos.ListaValores[y];
                PValoresT := ListaValoresT[p];
                if PValores.conta = PValorest.conta then begin

                  totalvalor := totalvalor + PValores.valor;
                  totalvalord := totalvalord + PValores.valor;

                end;

              end;
           end;

           FRel.AddCel( 'Diversas Contas' );
           FRel.AddCel( floattostr( totalvalord ) );
                if difkm > 0 then

                  FRel.AddCel( floattostr( totalvalord/difkm ) )

                else

                  FRel.AddCel( '' );

{
           if ListaValorest.Count>5 then  begin

              totalvalord := 0;
              for y :=5 to ListaValorest.Count-1 do begin

                PValorest := ListaValorest[y];
                totalvalor := totalvalor + PValorest.valor;
                totalvalord := totalvalord + PValorest.valor;

              end;
              FRel.AddCel( 'Diversas Contas' );
              FRel.AddCel( floattostr( totalvalord ) );

           end else begin

              FRel.AddCel( '' );
              FRel.AddCel( '' );

           end;
}

           FRel.AddCel( floattostr( totalvalor ) );
           if difkm > 0 then

              FRel.AddCel( floattostr( totalvalor/difkm ) )

           else

              FRel.AddCel( '' );

         end;

      end;

      FRel.Video;

    end;
    Sistema.EndProcess('');
    FGeral.FechaQuery(q);

  end;

  FRelGerenciais_DespesasVeiculos;     // 33

end;

procedure FRelGerenciais_AuditoriaFiscalBaseItens;    // 34
///////////////////////////////////////////////////////
type TBases=record
     nota,codigo:integer;
     emissaoentrada:TDatetime;
     transacao,tipomov,cfop,es,tipocodigo:string;
     baseicmsnota,baseicmsdesmembrada,baseicmsitens,contabilnota,contabilitens,ipinota:currency
end;

var Q:TSqlquery;
    tiposnao,sqlcfops,xes,dif:string;
    baseicmsitem,redubase,baseicmsconf,difvalor,difcontabil,totalitem:currency;
    Lista:TList;
    PBases:^TBases;
    Datam:TDatetime;
    i:integer;

    procedure AtualizaLista(tabela,transacao,tipomov:string ; baseicms,vlrcontabil,valoripi:currency ; numeronf:integer ; cfop:string='' ; data:Tdatetime=0; es:string='';codigo:integer=0;tipocodigo:string='') ;
    ///////////////////////////////////////////////////////////////////////////////////////
    var p:integer;
        achou:boolean;
    begin
      achou:=false;
      for p:=0 to Lista.count-1 do begin
        PBases:=Lista[p];
        if ( PBases.transacao=transacao ) and ( Pbases.tipomov=tipomov ) then begin
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
        New(PBases);
        PBases.nota:=numeronf;
        PBases.emissaoentrada:=data;
        PBases.transacao:=transacao;
        PBases.tipomov:=tipomov;
        PBases.baseicmsnota:=0;
        PBases.ipinota:=0;
        PBases.baseicmsdesmembrada:=0;
        PBases.baseicmsitens:=0;
        PBases.es:=es;
        PBases.codigo:=codigo;
        PBases.tipocodigo:=tipocodigo;
        PBases.contabilnota:=0;
        PBases.contabilitens:=0;
        if tabela='movesto' then begin
          PBases.baseicmsnota:=baseicms;
          PBases.ipinota:=valoripi;
          PBases.contabilnota:=vlrcontabil;
        end else if tabela='movestoque' then begin
          PBases.baseicmsitens:=baseicms;
          PBases.contabilitens:=vlrcontabil;
        end;
        if trim(cfop)<>'' then
          PBases.cfop:=cfop;
        Lista.add(PBases);

      end else begin
        if (tabela='movesto') and (PBases.baseicmsnota=0) then
          PBases.baseicmsnota:=PBases.baseicmsnota+baseicms;
        if (tabela='movesto') and (PBases.contabilnota=0) then
          PBases.contabilnota:=PBases.contabilnota+vlrcontabil;
        if (tabela='movesto') and (PBases.ipinota=0) then
          PBases.ipinota:=PBases.ipinota+valoripi;
        if tabela='movestoque' then begin
          PBases.baseicmsitens:=PBases.baseicmsitens+baseicms;
          PBases.contabilitens:=PBases.contabilitens+vlrcontabil;
        end;
        if trim(cfop)<>'' then
          PBases.cfop:=cfop;
      end;
    end;

begin
/////////////////////////////////////////////
  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(34) then Exit;
    Lista:=TList.Create;
    Sistema.BeginProcess('Lendo movimento');
    tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+Global.CodContrato ;
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if trim(EdTipomov.text)<>'' then
      sqltipomovto:=' and '+FGeral.getin('moes_tipomov',EdTipomov.text,'C')
    else
      sqltipomovto:='';
// 30.05.05
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and moes_tipo_codigo='+EdCodtipo.assql;
      if Edtipocad.text='R' then
        sqlcodtipo:=' and moes_repr_codigo='+EdCodtipo.assql;

    end;
// 12.12.08
    sqlcfops:='';
    if not EdCfops.IsEmpty then
      sqlcfops:=' and '+FGeral.GetIN('moes_natf_codigo',EdCfops.text,'C');
    Q:=sqltoquery('select * from movestoque'+
                  ' inner join movesto on ( move_transacao=moes_transacao and move_tipomov=moes_tipomov )'+
                  ' where moes_datamvto>='+EdDatai.AsSql+' and moes_datamvto<='+EdDataf.AsSql+
                  sqlunidade+sqltipomovto+sqlcodtipo+
                  ' and '+fGeral.GetNOTIN('moes_tipomov',tiposnao,'C')+
                  ' and moes_natf_codigo is not null '+
                  ' and '+FGeral.Getin('moes_status','N;X;E;D;Y','C')+
                  ' and '+FGeral.Getin('move_status','N;X;E;D;Y','C')+
                  ' and moes_datacont is not null'+
                  sqlcfops+
//                  ' and movb_status<>''C'''+  / assim 'nao pega' conhecimentos-CT
                  ' order by moes_unid_codigo,moes_datalcto,moes_numerodoc' );

    if Q.Eof then begin
      Sistema.EndProcess('Nada encontrado para impress�o');
      Q.Close;
    end;
    Sistema.BeginProcess('Totalizando por documento');
    while not Q.eof do begin
      if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin
        datam:=Q.fieldbyname('moes_datamvto').asdatetime;
        xes:='E';
        redubase:=0;
      end else begin
        datam:=Q.fieldbyname('moes_dataemissao').asdatetime;
        xes:='S';
        redubase:=FCodigosFiscais.GetAliquotaRedBase( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
      end;
      AtualizaLista('movesto',Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
                     Q.fieldbyname('moes_baseicms').ascurrency,Q.fieldbyname('moes_vlrtotal').ascurrency,Q.fieldbyname('moes_valoripi').ascurrency,
                     Q.fieldbyname('moes_numerodoc').asinteger,
                     Q.fieldbyname('moes_natf_codigo').asstring,datam,xes,Q.fieldbyname('moes_tipo_codigo').asinteger,
                     Q.fieldbyname('moes_tipocad').asstring);
      baseicmsitem:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency;
      totalitem:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency;
      if redubase >0 then
        baseicmsitem:=(baseicmsitem*(redubase/100))
      else if Q.fieldbyname('moes_perdesco').ascurrency>0 then
//        totalitem:=totalitem/(1-(Q.fieldbyname('moes_perdesco').ascurrency/100));
        totalitem:=totalitem - ( totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100) );
      AtualizaLista('movestoque',Q.fieldbyname('moes_transacao').asstring,Q.fieldbyname('moes_tipomov').asstring,
                     baseicmsitem,totalitem,0,Q.fieldbyname('moes_numerodoc').asinteger,
                     Q.fieldbyname('moes_natf_codigo').asstring,datam);
      Q.Next;
    end;
    FGeral.FechaQuery(Q);
    Sistema.BeginProcess('Totalizando bases');
    for i:=0 to Lista.count-1 do begin
      PBases:=Lista[i];
      Q:=sqltoquery('select * from movbase where movb_transacao='+Stringtosql(PBases.transacao)+
                    ' and movb_status<>''C'' and movb_tipomov='+Stringtosql(PBases.tipomov));
      while not Q.eof do begin
        baseicmsconf:=Q.FieldByName('movb_basecalculo').AsCurrency;
        if Q.FieldByName('movb_reducaobc').AsCurrency>0 then
          baseicmsconf:=(Q.FieldByName('movb_basecalculo').AsCurrency*(Q.FieldByName('movb_reducaobc').AsCurrency/100));
        PBases.baseicmsdesmembrada:=PBases.baseicmsdesmembrada+baseicmsconf;
        Q.Next;
      end;
      FGeral.FechaQuery(Q);
    end;


      Sistema.BeginProcess('Gerando Relat�rio');
      FRel.Init('RelAuditoriaFiscalBaseItens');
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
      FRel.AddTit('Rela��o de Auditoria Fiscal de Base do Icms dos Itens das Notas');
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 80,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
      FRel.AddCol( 80,1,'D','' ,''              ,'Entrada/Emiss�o'  ,''         ,'',false);
      FRel.AddCol( 60,2,'N','' ,''              ,'Nota'     ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'Cfop'            ,''         ,'',False);
      FRel.AddCol( 80,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
      FRel.AddCol( 60,0,'C','' ,''              ,'Ent/Saida'        ,''         ,'',False);
      FRel.AddCol( 60,1,'C','' ,''              ,'Cod.Emitente'    ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Emitente'        ,''         ,'',false);
//      FRel.AddCol( 40,1,'C','' ,''              ,'Dif.'        ,''         ,'',false);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Base Nota'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Base itens'      ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Dif.Valor'      ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Base Desmebrada' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Cont�bil Nota'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Cont�bil itens'      ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Dif.Cont�bil'      ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor IPI'      ,''         ,'',False);
//      FRel.AddCol( 60,3,'N','' ,'##0.00'        ,'Al�quota'        ,''         ,'',False);
//      FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor Imposto'   ,''         ,'',False);
      for i:=0 to Lista.count-1 do begin
        PBases:=Lista[i];
        dif:='N';
        if roundvalor(PBases.baseicmsnota)<>roundvalor(PBases.baseicmsitens) then dif:='S';
        difvalor:=roundvalor(PBases.baseicmsnota-PBases.baseicmsitens);
        difcontabil:=roundvalor(PBases.contabilnota-PBases.contabilitens);
        if ( (PBases.baseicmsnota>0) and ( abs(difvalor)>0.5)  and (PBases.es='S') ) or
//           ( (PBases.contabilnota>0) and ( (difcontabil<-1) or (difcontabil>1) ) )
           ( (PBases.contabilnota>0) and ( Abs(difcontabil)>0.5 ) and (PBases.es='E') )
//           ( (PBases.contabilnota>0) and (PBases.es='E') )
           then begin
          FRel.AddCel(PBases.transacao);
          FRel.AddCel(FGeral.FormataData(PBases.emissaoentrada));
          FRel.AddCel(inttostr(PBases.nota));
          FRel.AddCel(PBases.cfop);
          FRel.AddCel(PBases.tipomov);
          FRel.AddCel(PBases.es);
          FRel.AddCel(inttostr(PBases.codigo));
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(PBases.codigo,PBases.tipocodigo,'R'));
//          FRel.AddCel(dif);
          if Pbases.es='S' then begin
            FRel.AddCel(floattostr(PBases.baseicmsnota));
            FRel.AddCel(floattostr(PBases.baseicmsitens));
            FRel.AddCel(floattostr(difvalor));
            FRel.AddCel(floattostr(PBases.baseicmsdesmembrada));
          end else begin
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
          end;
          if Pbases.es='E' then begin
            FRel.AddCel(floattostr(PBases.contabilnota));
            FRel.AddCel(floattostr(PBases.contabilitens));
            FRel.AddCel(floattostr(difcontabil));
            FRel.AddCel(floattostr(PBases.ipinota));
          end else begin
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
          end;
        end;
      end;
      FRel.Video;

    Sistema.EndProcess('');
  end;

  FRelGerenciais_AuditoriaFiscalBaseItens;    // 34

end;

// 17.02.10
//////////////////////////////////////////////////////////////////////////////////////
procedure FRelGerenciais_Carga(tran:string='';unidade:string='';xtipomov:string='SA');              // 35
//////////////////////////////////////////////////////////////////////////////////////

var xnumero:string;
    i:integer;
    xunidade,xSa,sqlperiodo,sqlnumerodoc,Anasin,soma,email,cooperado,sqltipomov,titveiculos:string;
    Q:TSqlquery;
    Datacont:TDatetime;

begin
//////////////////////////////////////////
    if xtipomov='ES' then  // na primeira vez vem com 'ES' e nao descobri pq...
      xtipomov:='SA';
    if ( trim(tran)<>'') and (unidade<>'') then begin
      xnumero:=tran;
      xunidade:=unidade;
      FRelGerenciais.EdUnid_codigo.text:=unidade;
      FRelGerenciais.EdTran_codigo.text:=tran;
    end;

    if not FRelGerenciais_Execute(35) then Exit;
    xSa:=FRelGerenciais.EdSinana.text;

    if ( trim(tran)='') and (unidade='') then begin
      xnumero:=FRelGerenciais.EdTran_codigo.text;
      xunidade:=FRelGerenciais.EdUnid_codigo.text;
    end;

    sistema.beginprocess('separando quantidade por ve�culo');
    sqlperiodo:=' and mova_dtabate>='+FRelGerenciais.EdDatai.AsSql+' and mova_dtabate<='+FRelGerenciais.EdDataf.AsSql;
    if not FRelGerenciais.EdTran_codigo.isempty then
      titveiculos:='Ve�culo '+FRelGerenciais.EdTran_codigo.text+' - '+FTransp.GetNome(FRelGerenciais.EdTran_codigo.text)
    else
      titveiculos:='';
    if xsa='A' then
      Anasin:=' - Anal�tico'
    else
      Anasin:=' - Sint�tico';
    if trim(xnumero)<>'' then
      sqlnumerodoc:=' and mova_tran_codigo='+Stringtosql(xnumero)
    else
      sqlnumerodoc:='';
    if trim(xUnidade)<>'' then
      sqlunidade:=' and '+FGeral.getin('mova_unid_codigo',xUnidade,'C')
    else
      sqlunidade:='';
    if FRelGerenciais.EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
        sqlcodtipo:=' and movd_tipo_codigo='+FRelGerenciais.EdCodtipo.assql;
    end;
// 03.10.05
    if not FRelGerenciais.EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.getin('movd_esto_codigo',FRelGerenciais.EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
//      sqldatacont:=' and mova_datacont>1';
// 27.05.10
      sqldatacont:=' and mova_datacont > '+DateToSql(Global.DataMenorBanco);
// 05.06.08
    sqltipomov:=' and mova_tipomov='+Stringtosql(xTipomov);
    if xSa='A' then
      Q:=sqltoquery('select movabatedet.*,movabate.*,clie_email,clie_email1,clie_ativo,clie_tipo from movabatedet '+
                  ' inner join movabate on ( mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc and mova_tipomov=movd_tipomov)'+
                  ' inner join clientes on ( clie_codigo=movd_tipo_codigo )'+
                  ' where '+FGeral.Getin('movd_status','N','C')+
                  sqlperiodo+
                  sqlunidade+sqlnumerodoc+
                  sqlproduto+
                  sqlcodtipo+
                  sqldatacont+
                  sqltipomov+
                  ' and '+FGeral.Getin('mova_situacao','N;P','C')+
                  ' order by mova_unid_codigo,mova_tipo_codigo,movd_numerodoc,movd_ordem' )
    else
      Q:=sqltoquery('select mova_unid_codigo,mova_tran_codigo,mova_carga,movd_esto_codigo,sum(movd_pesocarcaca) as movd_pesocarcaca,sum(movd_pecas) as movd_pecas from movabatedet '+
                  ' inner join movabate on ( mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc and mova_tipomov=movd_tipomov)'+
                  ' where '+FGeral.Getin('movd_status','N','C')+
                  sqlperiodo+
                  sqlunidade+sqlnumerodoc+
                  sqlproduto+
                  sqlcodtipo+
                  sqldatacont+
                  sqltipomov+
                  ' and '+FGeral.Getin('mova_situacao','N;P','C')+
                  ' group by mova_unid_codigo,mova_tran_codigo,mova_carga,movd_esto_codigo' );
    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

      Sistema.BeginProcess('Gerando Relat�rio');
      if xSa='A' then
        FRel.Init('CargaVeiculo')
      else
        FRel.Init('CargaVeiculoProduto');
      FRel.AddTit(titveiculos);
      FRel.AddTit('Periodo : '+FGeral.formatadata(FRelGerenciais.EdDatai.Asdate)+' a '+FGeral.formatadata(FRelGerenciais.EdDataf.asdate));

      FRel.AddCol( 40,1,'C','' ,''              ,'Codigo.'         ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Ve�culo'         ,''         ,'',false);
      FRel.AddCol( 50,3,'N','' ,''              ,'Carga'           ,''         ,'',false);
      if xsa='A' then begin
        FRel.AddCol( 50,3,'N','' ,''              ,'Pedido'           ,''         ,'',false);
        FRel.AddCol( 65,3,'N','' ,''              ,'Cod.Cliente'    ,''         ,'',false);
        FRel.AddCol(150,1,'C','' ,''              ,'Nome'  ,''         ,'',false);
      end;
      FRel.AddCol( 60,3,'N','' ,''              ,'Produto'           ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Descri��o Produto'   ,''         ,'',false);
      FRel.AddCol( 40,3,'N','+'  ,'#####0'       ,'Pe�as'              ,''         ,'',False);
      FRel.AddCol( 60,3,'N','+' ,f_cr3          ,'Peso'        ,''         ,'',False);

      while not Q.eof do begin

            FRel.AddCel(Q.fieldbyname('mova_tran_codigo').asstring);
            FRel.AddCel( FTransp.GetNome(Q.fieldbyname('mova_tran_codigo').asstring) );
            FRel.AddCel(Q.fieldbyname('mova_carga').asstring);
         if xsa='A' then begin
            FRel.AddCel(Q.fieldbyname('mova_numerodoc').asstring);
            FRel.AddCel(Q.fieldbyname('mova_tipo_codigo').asstring);
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mova_tipo_codigo').asinteger,'C','N'));
         end;
            FRel.AddCel(Q.fieldbyname('movd_esto_codigo').asstring);
            FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('movd_esto_codigo').asstring));
            FRel.AddCel( floattostr( Q.fieldbyname('movd_pecas').ascurrency) );
            FRel.AddCel(floattostr(Q.fieldbyname('movd_pesocarcaca').ascurrency));
//            FRel.AddCel(floattostr(Q.fieldbyname('movd_vlrarroba').ascurrency));
//            FRel.AddCel( floattostr(Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency/15) ) );
//            FRel.AddCel(Q.fieldbyname('movd_obs').asstring);
        Q.Next;

      end;

      FRel.Video;

    end;

    Sistema.EndProcess('');
    FGeral.Fechaquery(Q);
    if (trim(xnumero)='') or (unidade='') then
      FRelGerenciais_Carga
    else
      FRelGerenciais.Close;

end;


////////////////////////////////////////////////////////////////////
// 24.01.11 - Isonel via Elyze - Novicarnes
procedure FRelGerenciais_ComissoesEntradaAbate;           // 36
////////////////////////////////////////////////////////////////////
var Q,QF:TSqlquery;
    statusvalidos,sqlorder,sqlunidade,sqltipocod,tiposvenda,tiposdev,titulo,devolucoes:string;
    avista,aprazo,devolucao,comissao,percomissao:currency;
begin
  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(36) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    statusvalidos:='N';
    sqlorder:=' order by mova_unid_codigo,mova_repr_codigo,mova_tipo_codigo,mova_numerodoc';
    sqlunidade:=' and '+FGeral.getin('mova_unid_codigo',EdUnid_codigo.text,'C');
    if EdCodtipo.Asinteger>0 then begin
      if Edtipocad.text='R' then
        sqltipocod:=' and mova_repr_codigo='+EdCodtipo.assql
      else
//        sqltipocod:=' and ( (mova_tipo_codigo='+EdCodtipo.assql+') and (mova_tipocad='+EdTipocad.Assql+') )';
// 02.12.11
        sqltipocod:=' and mova_tipo_codigo='+EdCodtipo.assql;
    end else
      sqltipocod:='';
//    if EdTipomov.isempty then begin
//      Tiposvenda:=Global.TiposRelVenda;
//      Tiposdev:=Global.TiposRelDevVenda;
//    end else begin
//      tiposvenda:=EdTipomov.text;
//    end;
     TipoEntradaAbate:='EA';

//    devolucoes:=Global.CodDevolucaoVenda+';'+Global.CodDevolucaoRoman+';'+Global.CodDevolucaoSerie5+';'+Global.CodDevolucaoIgualVenda;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and moes_datacont>1';
// 27.05.10
      sqldatacont:=' and mova_datacont > '+DateToSql(Global.DataMenorBanco);

    titulo:='Comiss�o sobre Entrada de Abate de '+FGeral.FormataData(Eddatai.asdate)+' a '+FGeral.FormataData(Eddataf.asdate);
    Q:=sqltoquery('select * from movabatedet '+
                  ' inner join movabate on ( mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc and mova_tipomov=movd_tipomov)'+
                  ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                  ' where '+FGeral.GetIN('mova_status',statusvalidos,'C')+
// 02.12.11
                  ' and '+FGeral.GetIN('movd_status',statusvalidos,'C')+
                  ' and mova_dtabate>='+Eddatai.AsSql+' and mova_dtabate<='+Eddataf.AsSql+
                  sqlunidade+
                  sqltipocod+
                  sqldatacont+
                  ' and '+FGeral.getin('mova_tipomov',tipoentradaabate,'C')+
                  sqlorder );


    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      FRel.Init('RelComissoesEntradaAbate');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Emiss�o'         ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
//      FRel.AddCol( 90,1,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
      FRel.AddCol( 45,0,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Cod.repres.'     ,''         ,'',false);
      FRel.AddCol(140,0,'C','' ,''              ,'Nome repres.'    ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Produto'         ,''         ,'',false);
      FRel.AddCol(140,0,'C','' ,''              ,'Descri��o'       ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Total Produto'   ,''         ,'',false);
//      FRel.AddCol(080,3,'N','+',f_cr            ,'Total'      ,''         ,'',false);
//      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor desconto'  ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor comiss�o'  ,''         ,'',false);
      FRel.AddCol(080,3,'N','',f_cr             ,'Perc. comiss�o'  ,''         ,'',false);
//      FRel.AddCol(070,1,'D','',''               ,'Data Baixa'     ,''         ,'',false);

      while not Q.eof do begin
//          FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
          FRel.AddCel(Q.FieldByName('mova_unid_codigo').AsString);
          FRel.AddCel(Q.FieldByName('mova_dtabate').AsString);
//          FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
          FRel.AddCel(Q.FieldByName('mova_datacont').AsString);
          FRel.AddCel(Q.FieldByName('mova_numerodoc').AsString);
//          FRel.AddCel(Q.FieldByName('moes_natf_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));
          FRel.AddCel(Q.FieldByName('mova_tipo_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('mova_tipo_codigo').AsInteger,'C','N'));
          FRel.AddCel(Q.FieldByName('mova_repr_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('mova_repr_codigo').AsInteger,'R','N'));
          FRel.AddCel(Q.FieldByName('movd_esto_codigo').AsString);
          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
          avista:=0;
          aprazo:=Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency/15);
//          FRel.AddCel( floattostr(Q.Fieldbyname('Movd_pesocarcaca').AsCurrency*(Q.Fieldbyname('Movd_vlrarroba').AsCurrency/15) ) )
          FRel.AddCel(floattostr(aprazo));
          devolucao:=0;
//          FRel.AddCel(valortosql(avista+aprazo-devolucao));

//          percomissao:=FRepresentantes.GetPerComissao(Q.fieldbyname('mova_repr_codigo').asinteger);
          percomissao:=Q.fieldbyname('mova_perccomissao').ascurrency;
//          desconto:=0;
//          if Q.fieldbyname('move_venda').ascurrency<Q.fieldbyname('move_vendamin').ascurrency then
//            desconto:= ( ( Q.fieldbyname('move_vendamin').ascurrency-Q.fieldbyname('move_venda').ascurrency ) * Q.FieldByName('move_qtde').Ascurrency ) * (percomissao/100);
          comissao:=(avista+aprazo-devolucao) * (percomissao)/100;
//          comissao:=comissao+ ( comissao*(perbonus/100) );
//          FRel.AddCel(valortosql(desconto));
          FRel.AddCel(valortosql(comissao));
          FRel.AddCel(valortosql(percomissao));
//          FRel.AddCel(valortosql(perbonus));
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

    FRelGerenciais_ComissoesEntradaAbate;     // 36

  end;

end;

// 21.09.11 -retornado este relatorio - Janina
procedure FRelGerenciais_DetalheVC ;          // 14   - detalhamento das VC
///////////////////////////////////////////////////////////////////////////////
type Vendas=record
     Unid_codigo,esto_codigo,tipovenda,remessasvendas,remessasdevolucoes:string;
     repr_codigo,clie_codigo,numerodoc:integer;
     qtdevenda,vlrvenda,qtdedevo,qtderemessa,vendaunitario,vlrremessa:currency;
end;

{
type TRemessas=record
     Unid_codigo,esto_codigo,tipovenda:string;
     repr_codigo,clie_codigo,numerodoc:integer;
     qtde:currency;
end;
type TDevolucoes=record
     Unid_codigo,esto_codigo,tipovenda:string;
     repr_codigo,clie_codigo,numerodoc:integer;
     qtde:currency;
end;
}

var Q:TSqlquery;
    Lista,ListaRe,ListaDe:TList;
    ListaRemessas,ListaDevolucoes,ListaAux:TStringlist;
    PVendas : ^Vendas;
//    PRemessas : ^TRemessas;
//    PDevolucoes : ^TDevolucoes;
    p,posicao,x:integer;
    totqtde,totvalor,qtdeabc,valorabc:currency;
    remessas,devolucoes,tiposremessas,tiposdevolucoes,tiposmovto,camposremessas,sqlperiodo,
    sqlnumerodoc :string;
    Datadevolucoes,Datafinal:TDatetime;

     function Procura(unidade:string;repre:integer;cliente:integer;produto,tipomov:string;numero:integer=0):integer;
     ///////////////////////////////////////////////////////////////////////////////////////////////////
     var x:integer;
     begin
       result:=-1;
       for x:=0 to Lista.count-1 do begin
         PVendas:=Lista[x];
         if tiposmovto=Global.CodVendaConsig then begin
           if not FRelGerenciais.EdNumerodoc.isempty then begin
             if (PVendas.Unid_codigo=unidade) and (PVendas.repr_codigo=repre) and (PVendas.clie_codigo=cliente)
                 and (PVendas.esto_codigo=produto) then begin
                result:=x;
                break;
             end;
           end else begin
             if (PVendas.Unid_codigo=unidade) and (PVendas.clie_codigo=cliente) then begin
                result:=x;
                break;
             end;
           end;
         end else begin
//         if (PVendas.Unid_codigo=unidade) and (PVendas.repr_codigo=repre)
//               and (PVendas.esto_codigo=produto) then begin
// 19.12.13
           if not FRelGerenciais.EdNumerodoc.isempty then begin
             if (PVendas.Unid_codigo=unidade) and (PVendas.repr_codigo=repre) and (PVendas.clie_codigo=cliente)
                 and (PVendas.esto_codigo=produto) then begin
                result:=x;
                break;
             end;
           end else begin
             if (PVendas.Unid_codigo=unidade) and (PVendas.clie_codigo=cliente) then begin
                result:=x;
                break;
             end;
           end;
         end;
       end;
     end;

     procedure Atualiza(qtde,unitario:currency;tipomov:string;posicao:integer;remdev:string='');
     //////////////////////////////////////////////////////////////////////////////
     begin
       PVendas:=Lista[posicao];
//       if Q.fieldbyname('move_datacont').asdatetime<1 then begin
//         if pos( Q.fieldbyname('move_tipomov').asstring,tiposDevolucoes ) >0 then begin
         if pos( tipomov,tiposDevolucoes ) >0 then begin
           PVendas.qtdedevo:=PVendas.qtdedevo+qtde;
//         end else if pos( Q.fieldbyname('move_tipomov').asstring,tiposremessas ) >0 then begin
         end else if pos( tipomov,tiposremessas ) >0 then begin
           PVendas.qtderemessa:=PVendas.qtderemessa+qtde;
           PVendas.vlrremessa:=PVendas.vlrremessa+(qtde*unitario);
         end else begin
           PVendas.qtdevenda:=PVendas.qtdevenda+qtde;
           PVendas.vlrvenda:=PVendas.vlrvenda+(qtde*unitario);
           PVendas.remessasvendas:=PVendas.remessasvendas + remdev;
         end;
     end;


begin
///////////////////////////
  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(14) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
//    tiposmovto:=Global.CodVendaConsig+';'+global.CodRemessaConsig+';'+global.CodDevolucaoConsig+';'+global.CodDevolucaoTroca
    if FRelGerenciais.EdTipomov.isempty then
      tiposmovto:=Global.CodVendaConsig
    else
      tiposmovto:=copy(FRelGerenciais.EdTipomov.text,1,2);  //  Global.CodVendaConsig;
    sqltipomovto:=' and '+FGeral.getin('move_tipomov',tiposmovto,'C');
    if copy(EdTipomov.text,1,2)=global.CodVendaConsig then begin
      tiposdevolucoes:=global.CodDevolucaoConsig+';'+global.CodDevolucaoTroca;
      tiposremessas:=Global.CodRemessaConsig;
    end else if copy(EdTipomov.text,1,2)=global.CodVendaProntaEntregaFecha then begin
      tiposdevolucoes:=global.CodDevolucaoProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodVendaProntaEntrega;
      tiposremessas:=Global.CodRemessaProntaEntrega;
    end else begin
      tiposdevolucoes:=global.CodDevolucaoConsig+';'+global.CodDevolucaoTroca;
      tiposremessas:=Global.CodRemessaConsig;
    end;
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
//       if copy(EdTipomov.text,1,2)=global.CodVendaConsig then
          sqlcodtipo:=' and move_tipo_codigo='+EdCodtipo.assql
//     else
//          sqlcodtipo:=' and move_repr_codigo='+EdCodtipo.assql;
    end;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
      sqldatacont:=' and move_datacont > '+Datetosql(Global.DataMenorBanco);
// 19.12.13
    if EdDatai.isempty then
      sqlperiodo:=''
    else
      sqlperiodo:=' and move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql;
    sqlnumerodoc:='';
    if not EdNumerodoc.IsEmpty then sqlnumerodoc:=' and move_numerodoc='+EdNumerodoc.AsSql;
    Sistema.beginprocess('Pesquisando vendas');
    Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc and moes_tipo_codigo=move_tipo_codigo)'+
//                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
//                  ' inner join movesto on ( moes_transacao=move_transacao )'+
//                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
//                  ' where move_numerodoc='+EdNumerodoc.assql+
// 19.12.13
                  ' where '+FGeral.getin('move_status','N','C')+
// 23.01.14
                  ' and '+FGeral.Getin('moes_status','N,E,D','C')+
                  sqlunidade+
                  sqlcodtipo+
                  sqltipomovto+
                  sqldatacont+
                  sqlperiodo+
                  sqlnumerodoc+
//                  ' and '+FGeral.Getin('move_status','D','C')+
                  ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_datamvto,move_esto_codigo' );

    if Q.Eof then begin
      Avisoerro('Nada encontrado para impress�o');
      Sistema.endprocess('');
    end else begin
      Lista:=Tlist.create;
      Sistema.beginprocess('Somando quantidade vendida');
      totqtde:=0;totvalor:=0;
      while not Q.eof do begin
        posicao:=Procura(Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_repr_codigo').asinteger,
                   Q.fieldbyname('move_tipo_codigo').asinteger,Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_numerodoc').asinteger);
        if posicao<0 then begin
          New(PVendas);
          PVendas.Unid_codigo:=Q.fieldbyname('move_unid_codigo').asstring;
          PVendas.repr_codigo:=Q.fieldbyname('move_repr_codigo').asinteger;
          PVendas.clie_codigo:=Q.fieldbyname('move_tipo_codigo').asinteger;
          PVendas.esto_codigo:=Q.fieldbyname('move_esto_codigo').asstring;
          PVendas.tipovenda:=Q.fieldbyname('move_tipomov').asstring;
//          PVendas.remessasvendas:=Q.fieldbyname('move_remessas').asstring;
// 16.01.14
          PVendas.remessasvendas:=PVendas.remessasvendas + Q.fieldbyname('move_remessas').asstring;
          if copy(EdTipomov.text,1,2)=global.CodVendaProntaEntregaFecha then   // 18.05.06
//            PVendas.remessasvendas:=Q.fieldbyname('moes_remessas').asstring;
// 16.01.14
            PVendas.remessasvendas:=PVendas.remessasvendas + Q.fieldbyname('moes_remessas').asstring;
          pvendas.numerodoc:=Q.fieldbyname('move_numerodoc').asinteger;
          PVendas.qtdedevo:=0;
          PVendas.qtderemessa:=0;
          PVendas.vlrremessa:=0;
          PVendas.qtdevenda:=Q.fieldbyname('move_qtde').ascurrency;
          PVendas.vlrvenda:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency;
          PVendas.vendaunitario:=Q.fieldbyname('move_venda').ascurrency;
          Lista.Add(PVendas);
        end else
           Atualiza(Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_venda').ascurrency,Q.fieldbyname('move_tipomov').asstring,posicao,Q.fieldbyname('move_remessas').asstring);
        Q.Next;
      end;

      ListaRemessas:=TStringlist.create;
      ListaDevolucoes:=TStringlist.create;
      Q.close;
      Freeandnil(Q);
// coletando as remessas da(s) venda(s) escolhida(s)
      remessas:='';
      for p:=0 to Lista.count-1 do begin
        PVendas:=lista[p];
        ListaAux:=TStringlist.create;
        strtolista(listaaux,PVendas.remessasvendas,';',true);
        for x:=0 to Listaaux.count-1 do begin
          if ListaRemessas.indexof(listaaux[x])=-1 then begin
            Listaremessas.add(listaaux[x]);
            remessas:=remessas+listaaux[x]+';';
          end;
        end;
      end;
       if trim(remessas)='' then begin
         Avisoerro('N�o encontrado remessas desta venda.  Checar se foi alterada');
         Q.close;
         Freeandnil(Q);
         Sistema.endprocess('');
         exit;
      end;
      Sistema.beginprocess('Pesquisando remessas');

//      remessas:='6798;7645;7600;7621;7620;7516;6821;7453;7599;7646;6809';

      Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc and moes_tipo_codigo=move_tipo_codigo)'+
//                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
//                  ' inner join movesto on ( moes_transacao=move_transacao )'+
//                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  ' where '+Fgeral.getin('move_numerodoc',remessas,'N')+
                  sqlunidade+
                  sqlcodtipo+
                  sqldatacont+
                  ' and '+FGeral.getin('move_tipomov',tiposremessas,'C')+
                  ' and '+FGeral.getin('move_status','D;E','C')+
                  ' and '+FGeral.getin('moes_status','D;E','C')+
                  ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_datamvto,move_esto_codigo' );
// 19.12.13 - pega a data da remessa 'mais antiga'
      datadevolucoes:=EdDatai.asdate;
      Datafinal:=EdDataf.asdate;

      while not Q.eof do begin
        posicao:=Procura(Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_repr_codigo').asinteger,
                   Q.fieldbyname('move_tipo_codigo').asinteger,Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_tipomov').asstring);
        if Q.fieldbyname('moes_datamvto').asdatetime < Datadevolucoes then
          datadevolucoes:=Q.fieldbyname('moes_datamvto').asdatetime
        else if Q.fieldbyname('moes_datamvto').asdatetime >= datafinal then
          datafinal:=Q.fieldbyname('moes_datamvto').asdatetime;
        if Q.fieldbyname('moes_datamvto').asdatetime < Datadevolucoes then
          datadevolucoes:=Q.fieldbyname('moes_datamvto').asdatetime;
        if posicao>=0 then
          Atualiza(Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_venda').ascurrency,Q.fieldbyname('move_tipomov').asstring,posicao)
        else begin
////////////////// - 18.05.06
            New(PVendas);
            PVendas.Unid_codigo:=Q.fieldbyname('move_unid_codigo').asstring;
            PVendas.repr_codigo:=Q.fieldbyname('move_repr_codigo').asinteger;
            PVendas.clie_codigo:=Q.fieldbyname('move_tipo_codigo').asinteger;
            PVendas.esto_codigo:=Q.fieldbyname('move_esto_codigo').asstring;
            PVendas.tipovenda:=Q.fieldbyname('move_tipomov').asstring;
            PVendas.remessasvendas:=Q.fieldbyname('move_remessas').asstring;
            if copy(EdTipomov.text,1,2)=global.CodVendaProntaEntregaFecha then   // 18.05.06
              PVendas.remessasvendas:=Q.fieldbyname('moes_remessas').asstring;
            pvendas.numerodoc:=Q.fieldbyname('move_numerodoc').asinteger;
            PVendas.qtdedevo:=0;
            PVendas.qtderemessa:=0;
            PVendas.vlrremessa:=0;
            PVendas.qtdevenda:=0;
            PVendas.vlrvenda:=0;
            PVendas.vendaunitario:=Q.fieldbyname('move_venda').ascurrency;
            Lista.Add(PVendas);
            posicao:=Procura(Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_repr_codigo').asinteger,
                     Q.fieldbyname('move_tipo_codigo').asinteger,Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_numerodoc').asinteger);
            Atualiza(Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_venda').ascurrency,Q.fieldbyname('move_tipomov').asstring,posicao)
        end;
//////////////////
        Q.next;
      end;

      Sistema.beginprocess('Pesquisando devolu�oes');
      Q.close;
      Freeandnil(Q);
//      datadevolucoes:=EdDatai.asdate-90;
// 11.05.05
//      datadevolucoes:=EdDatai.asdate-180;
      devolucoes:='';
      Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc and moes_tipo_codigo=move_tipo_codigo)'+
//                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
//                  ' inner join movesto on ( moes_transacao=move_transacao )'+
                  ' where move_datamvto>'+Datetosql(datadevolucoes)+
                  sqlunidade+
                  sqlcodtipo+
                  sqldatacont+
                  ' and '+Fgeral.getin('move_tipomov',tiposdevolucoes,'C')+
                  ' and '+FGeral.getin('move_status','D;E','C')+
                  ' and '+FGeral.getin('moes_status','D;E','C')+
                  ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_datamvto,move_esto_codigo' );
      Sistema.beginprocess('Somando devolu�oes');
      while not Q.eof do begin
//        if FGeral.EstaemAberto(Q.fieldbyname('move_remessas').asstring,remessas) then begin
// 18.05.06
        camposremessas:=Q.fieldbyname('move_remessas').asstring;
        if copy(EdTipomov.text,1,2)=global.CodVendaProntaEntregaFecha then
          camposremessas:=Q.fieldbyname('moes_remessas').asstring;
        if FGeral.EstaemAberto(camposremessas,remessas) then begin
           if Listadevolucoes.indexof(Q.fieldbyname('move_numerodoc').asstring)=-1 then begin
             Listadevolucoes.add(Q.fieldbyname('move_numerodoc').asstring);
             devolucoes:=devolucoes+strzero(Q.fieldbyname('move_numerodoc').asinteger,8)+';';
           end;
        end;
        Q.Next;
      end;

      if  trim(devolucoes)<>'' then begin
        Sistema.beginprocess('Somando devolu�oes pesquisadas');
        Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc and moes_tipo_codigo=move_tipo_codigo)'+
//                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
  //                  ' inner join movesto on ( moes_transacao=move_transacao )'+
                    ' where '+Fgeral.getin('move_numerodoc',devolucoes,'N')+
                    sqlunidade+
                    sqlcodtipo+
                    sqldatacont+
                    ' and '+Fgeral.getin('move_tipomov',tiposdevolucoes,'C')+
                    ' and '+FGeral.getin('move_status','D;E','C')+
                    ' and '+FGeral.getin('moes_status','D;E','C')+
                    ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_datamvto,move_esto_codigo' );

        while not Q.eof do begin
          posicao:=Procura(Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_repr_codigo').asinteger,
                     Q.fieldbyname('move_tipo_codigo').asinteger,Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_numerodoc').asinteger);
// 19.12.13
           if Q.fieldbyname('moes_datamvto').asdatetime < Datadevolucoes then
             datadevolucoes:=Q.fieldbyname('moes_datamvto').asdatetime;
          if posicao>=0 then
            Atualiza(Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_venda').ascurrency,Q.fieldbyname('move_tipomov').asstring,posicao)
          else begin
////////////////// - 18.05.06
            New(PVendas);
            PVendas.Unid_codigo:=Q.fieldbyname('move_unid_codigo').asstring;
            PVendas.repr_codigo:=Q.fieldbyname('move_repr_codigo').asinteger;
            PVendas.clie_codigo:=Q.fieldbyname('move_tipo_codigo').asinteger;
            PVendas.esto_codigo:=Q.fieldbyname('move_esto_codigo').asstring;
            PVendas.tipovenda:=Q.fieldbyname('move_tipomov').asstring;
            PVendas.remessasvendas:=Q.fieldbyname('move_remessas').asstring;
            if copy(EdTipomov.text,1,2)=global.CodVendaProntaEntregaFecha then   // 18.05.06
              PVendas.remessasvendas:=Q.fieldbyname('moes_remessas').asstring;
            pvendas.numerodoc:=Q.fieldbyname('move_numerodoc').asinteger;
            PVendas.qtdedevo:=0;
            PVendas.qtderemessa:=0;
            PVendas.vlrremessa:=0;
            PVendas.qtdevenda:=0;
            PVendas.vlrvenda:=0;
            PVendas.vendaunitario:=Q.fieldbyname('move_venda').ascurrency;
            Lista.Add(PVendas);
            posicao:=Procura(Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_repr_codigo').asinteger,
                     Q.fieldbyname('move_tipo_codigo').asinteger,Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_numerodoc').asinteger);
            Atualiza(Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_venda').ascurrency,Q.fieldbyname('move_tipomov').asstring,posicao)
//////////////////

          end;
          Q.next;
        end;
     end;

      Sistema.beginprocess('Gerando relat�rio');
      FRel.Init('RelDetalheVendaConsig');
      if not EdNumerodoc.IsEmpty then begin
        if length(devolucoes)>100 then
          FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+' - Devolu��es:'+copy(devolucoes,1,100)+' mais ...' )
        else
          FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+' - Devolu��es:'+devolucoes);
      end else
          FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      if not EdNumerodoc.IsEmpty then
        FRel.AddTit('Detalhamento da Venda '+copy(EdTipomov.text,1,2)+' numero '+EdNumerodoc.text+' - Remessas:'+remessas);
//      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+' - Devolu��es:'+devolucoes);
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate)+' Per�odo Remessas '+FGeral.formatadata(DataDevolucoes)+' a '+FGeral.formatadata(Datafinal) );
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      if not EdNumerodoc.isempty then begin
        FRel.AddCol( 45,1,'C','' ,''              ,'Codigo'          ,''         ,'',false);
        FRel.AddCol(120,1,'C','' ,''              ,'Representante'   ,''         ,'',false);
        FRel.AddCol( 40,0,'C','' ,''              ,'Cod.'            ,''         ,'',False);
        FRel.AddCol(120,0,'C','' ,''              ,'Cliente'         ,''         ,'',False);
        FRel.AddCol( 80,0,'C','' ,''              ,'Cod.Prod'        ,''         ,'',False);
        FRel.AddCol(120,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
      end else begin
        FRel.AddCol( 40,0,'C','' ,''              ,'Cod.'            ,''         ,'',False);
        FRel.AddCol(160,0,'C','' ,''              ,'Cliente'         ,''         ,'',False);
      end;
      FRel.AddCol( 80,3,'N','+' ,''             ,'Remessa'          ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Devolu��o'     ,''         ,'',False);
      if not EdNumerodoc.isempty then begin
        FRel.AddCol( 80,3,'N','+' ,''             ,'Rem.-Devol.'   ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Vlr Rem.-Devol.'   ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Venda'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Vlr Venda'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Diferen�a'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Vlr Diferen�a'     ,''         ,'',False);
      end else begin
        FRel.AddCol( 80,3,'N','+' ,''             ,'Venda'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','&' ,''             ,'% Vendido'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Vlr Remessa'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Vlr Venda'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','&' ,''             ,'% Vend'     ,''         ,'',False);
      end;
//      for p:=0 to Lista.count-1 do begin
//        PVendas:=Lista[p];
//        totvalor:=totvalor+PVendas.vlrvenda;
//        totqtde:=totqtde+PVendas.qtdevenda;
//      end;

      for p:=0 to Lista.count-1 do begin
        PVendas:=Lista[p];
        FRel.AddCel(PVendas.Unid_codigo);
        if not EdNumerodoc.isempty then begin
          FRel.AddCel(inttostr(PVendas.repr_codigo));
          FRel.AddCel(FRepresentantes.GetDescricao(PVendas.repr_codigo));
          FRel.AddCel(inttostr(PVendas.clie_codigo));
          FRel.AddCel(FCadcli.GetNome(PVendas.clie_codigo));
          FRel.AddCel(PVendas.esto_codigo);
          FRel.AddCel(FEstoque.GetDescricao(PVendas.esto_codigo));
        end else begin
          FRel.AddCel(inttostr(PVendas.clie_codigo));
          FRel.AddCel(FCadcli.GetNome(PVendas.clie_codigo));
        end;
        FRel.AddCel(transform(PVendas.qtderemessa,f_qtdestoque));
        FRel.AddCel(transform(PVendas.qtdedevo,f_qtdestoque));
        if not EdNumerodoc.isempty then begin
          FRel.AddCel(transform(PVendas.qtderemessa-PVendas.qtdedevo,f_qtdestoque));
          FRel.AddCel(transform((PVendas.qtderemessa-PVendas.qtdedevo)*PVendas.vendaunitario,f_cr));
          FRel.AddCel(transform(PVendas.qtdevenda,f_qtdestoque));
          FRel.AddCel(transform((PVendas.qtdevenda)*PVendas.vendaunitario,f_cr));
          FRel.AddCel(transform((PVendas.qtderemessa-PVendas.qtdedevo)-PVendas.qtdevenda,f_qtdestoque));
          FRel.AddCel(transform( ((PVendas.qtderemessa-PVendas.qtdedevo)-PVendas.qtdevenda)*PVendas.vendaunitario,f_cr));
        end else begin
          FRel.AddCel(transform(PVendas.qtdevenda,f_qtdestoque));
          if PVendas.qtderemessa>0 then
            FRel.AddCel(transform(((PVendas.qtderemessa-PVendas.qtdedevo)/PVendas.qtderemessa)*100,f_qtdestoque))
          else
            FRel.AddCel('0');
          FRel.AddCel(transform(PVendas.vlrremessa,f_cr));
          FRel.AddCel(transform(PVendas.vlrvenda,f_cr));
          if (PVendas.vlrvenda/(PVendas.vlrremessa))*100 <=100 then begin
            if PVendas.vlrremessa>0 then
              FRel.AddCel(transform( (PVendas.vlrvenda/(PVendas.vlrremessa))*100,f_cr) )
            else
              FRel.AddCel('0');
          end else
              FRel.AddCel('101,00');
        end;
      end;
{
      if (length(devolucoes)>100) or (length(remessas)>100) then begin
        FGeral.PulalinhaRel(15);
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel(remessas);
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FGeral.PulalinhaRel(15);
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel(devolucoes);
      end;
}

      FRel.Video;

    end;
    Sistema.EndProcess('');
    Freeandnil(Lista);
    Q.close;
    Freeandnil(Q);
  end;
end;

// 23.03.12
////////////////////////////////////////////////////
procedure FRelGerenciais_AuditoriaFiscalporCfop;     // 37
////////////////////////////////////////////////////
var Q:TSqlquery;
    doc,tiposnao,sqlcfops,campos,sqltipos,titentsai:string;
    valorimposto:currency;
begin
  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(37) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+Global.CodContrato+';'+
              Global.CodRomaneioRemessaaOrdem+';'+   // 28.07.11 - Capeg - Leonir
              Global.CodVendaInterna;  // 27.10.11 - Mama
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('moes_tipomov',EdTipomov.text,'C');
      tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+Global.CodContrato+';'+
                Global.CodVendaInterna;  // 27.10.11 - Mama
    end else
      sqltipomovto:='';
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and moes_tipo_codigo='+EdCodtipo.assql;
      if Edtipocad.text='R' then
        sqlcodtipo:=' and moes_repr_codigo='+EdCodtipo.assql;

    end;
    sqlcfops:='';
    if not EdCfops.IsEmpty then
      sqlcfops:=' and '+FGeral.GetIN('movb_natf_codigo',EdCfops.text,'C');
// 04.12.13
    if EdEntSai.text='E' then begin
      sqltipos:=' and substr(moes_natf_codigo,1,1) in (''1'',''2'',''3'')';
      titentsai:=' - ENTRADAS';
    end else if EdEntSai.text='S' then begin
      sqltipos:=' and substr(moes_natf_codigo,1,1) in (''5'',''6'',''7'')';
      titentsai:=' - SAIDAS';
    end else begin
      sqltipos:='';
      titentsai:=' - ENTRADAS E SAIDAS';
    end;

    campos:='moes_unid_codigo,moes_transacao,moes_datamvto,moes_numerodoc,moes_status,moes_tipomov,movb_natf_codigo,moes_retornonfe,'+
            'sum(movb_basecalculo) as movb_basecalculo,sum(moes_vlrtotal) as moes_vlrtotal';
    Q:=sqltoquery('select '+campos+' from movesto'+
                  ' left join movbase on (moes_transacao=movb_transacao and moes_tipomov=movb_tipomov and movb_status<>''C'')'+
                  ' where moes_datamvto>='+EdDatai.AsSql+' and moes_datamvto<='+EdDataf.AsSql+
                  sqlunidade+sqltipomovto+sqlcodtipo+
                  ' and '+fGeral.GetNOTIN('moes_tipomov',tiposnao,'C')+
                  ' and moes_natf_codigo is not null '+
                  ' and '+FGeral.Getin('moes_status','N;E;D;X,Y;I','C')+
                  ' and moes_datacont is not null'+
                  sqlcfops+sqltipos+
                  ' group by moes_unid_codigo,moes_transacao,moes_datamvto,moes_numerodoc,moes_status,moes_tipomov,movb_natf_codigo,moes_retornonfe'+
                  ' order by moes_unid_codigo,moes_transacao,moes_datamvto,moes_numerodoc,moes_status,moes_tipomov,movb_natf_codigo' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      FRel.Init('RelAuditoriaFiscalporCfop');
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
      FRel.AddTit('Rela��o de Auditoria Fiscal por CFOP'+titentsai);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 80,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'  ,''         ,'',false);
      FRel.AddCol( 60,2,'N','' ,''              ,'Nota'     ,''         ,'',False);
      if Global.UsaNfe='S' then
        FRel.AddCol(150,1,'C','' ,''            ,'Situa��o Sefa'   ,''         ,'',false);
      FRel.AddCol( 80,3,'N','' ,f_cr            ,'Valor total'           ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'Cfop'            ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Base Icms Cheia' ,''         ,'',False);
      FRel.AddCol(150,0,'C','' ,''              ,'Tipo de Movimento'            ,''         ,'',False);
      doc:='XYzwewe';
      while not Q.eof do begin
        FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
//        FRel.AddCel(Q.FieldByName('moes_datalcto').AsString);
        FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
//        FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
        FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
// 19.10.12
        if Global.UsaNfe='S' then
          FRel.AddCel(Q.fieldbyname('moes_retornonfe').asstring);
        FRel.AddCel(Q.FieldByName('moes_vlrtotal').AsString);
//        if trim(Q.FieldByName('movb_natf_codigo').AsString)='' then
//          FRel.AddCel(Q.FieldByName('moes_natf_codigo').AsString)
//        else
          FRel.AddCel(Q.FieldByName('movb_natf_codigo').AsString);

        FRel.AddCel(Q.FieldByName('movb_basecalculo').AsString);
// 18.06.12
//        FRel.AddCel(Q.fieldbyname('moes_status').asstring);

//        FRel.AddCel(Q.fieldbyname('moes_retornonfe').asstring);
        if Q.FieldByName('moes_status').AsString='X' then
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+' - Nota fiscal cancelada')
        else if Q.FieldByName('moes_status').AsString='Y' then
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+' - Nfe Denegada')
        else if Q.FieldByName('moes_status').AsString='I' then
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+' - Numera��o Inutilizada')
        else
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));

/////////
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);
  end;

  FRelGerenciais_AuditoriaFiscalporCfop;     // 37

end;

procedure TFRelGerenciais.EdGrup_codigoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin
  if not EdGrup_codigo.isempty then
    sqlgrupo:=' and '+FGeral.getin('esto_grup_codigo',EdGrup_codigo.text,'N')
  else
    sqlgrupo:='';
end;

function TFRelGerenciais.Gettitmotivos: string;
///////////////////////////////////////////////////
begin
   if EdCaoc_codigo.isempty then
     result:=''
   else begin
     result:=' - Motivo(s) : '+EdCaoc_codigo.text;
   end;
end;

procedure TFRelGerenciais.EdtiporesumoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////
begin
  baplicarclick(FRelgerenciais);

end;

procedure TFRelGerenciais.EdTransacaoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////
begin
  FRelgerenciais.baplicarClick(Sender);

end;

// 25.01.08 - izonel - novicarnes
function TFRelGerenciais.ChecaZero(s: string): string;
/////////////////////////////////////////////////////////
begin
   if (trim(s)='') or (trim(s)='0') or (trim(s)='0.00') then
     result:=''
   else
     result:=s;
end;

procedure TFRelGerenciais.SetaNumerosNotaSaida(Ed: TSqlEd; Datai,  Dataf: TDatetime);
////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  if (Datai>0) and (Dataf>0) then begin
    Sistema.beginprocess('Pesquisando notas no periodo');
    Q:=sqltoquery('select moes_numerodoc,moes_tipo_codigo,moes_tipocad from movesto'+
                ' where moes_dataemissao >= '+Datetosql(Datai)+
                ' and moes_dataemissao <= '+Datetosql(Dataf)+
                ' and moes_status = ''N'''+
                ' and '+FGeral.GetIN('moes_tipomov',Global.TiposRelVenda,'C') );
    Ed.Items.Clear;
    while not Q.eof do begin
      Ed.Items.Add( strzero(Q.fieldbyname('moes_numerodoc').asinteger,6) +
                    '  '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,
                     Q.fieldbyname('moes_tipocad').asstring,'N') );
      Q.Next;
    end;
    Q.Close;
    Sistema.endprocess('');
  end else
    Ed.Clear;

end;

function TFRelGerenciais.EstaNaLista(tipomov, transacao: string):boolean;
///////////////////////////////////////////////////////////////////
var p:integer;
begin
  result:=false;
  for p:=0 to ListaRegistro.count-1 do begin
    PRegistro:=ListaRegistro[p];
    if (PRegistro.transacao=transacao) and (PRegistro.tipomov=tipomov) then begin
       result:=true;
       break;
    end;
  end;
end;

procedure TFRelGerenciais.EdsubGrup_codigoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////////
begin
  if not EdSubGrup_codigo.isempty then
    sqlsubgrupo:=' and '+FGeral.getin('esto_sugr_codigo',EdSubGrup_codigo.text,'N')
  else
    sqlsubgrupo:='';

end;

// 27.09.14 -  Vivan - Liane
procedure FRelGerenciais_AnaliseVendasporCliente;     // 38
//////////////////////////////////////////////////////////////
type TConsumo=record
    produto,descricao,referencia:string;
    mesano01,mesano02,mesano03,mesano04,mesano05,mesano06,mesano07,mesano08,mesano09,mesano10,mesano11,mesano12:string;
    valor01,valor02,valor03,valor04,valor05,valor06,valor07,valor08,valor09,valor10,valor11,valor12:currency;
    qtde01,qtde02,qtde03,qtde04,qtde05,qtde06,qtde07,qtde08,qtde09,qtde10,qtde11,qtde12:currency;
end;

var PConsumo:^TConsumo;
    Lista:TList;
    sqlinicio,sqltermino,sqlstatus,devolucoes:string;
    i:integer;
    Q:TSqlquery;

    procedure AtualizaLista;
    ///////////////////////////
    var p:integer;
        achou:boolean;

        procedure ConfiguraMesano;
        /////////////////////////////
        var data:TDatetime;
        begin
          data:=TExttodate( strzero(Datetodia(FRelGerenciais.EdDataf.asdate),2)+strzero(Datetomes(FRelGerenciais.EdDatai.asdate),2)+Strzero(Datetoano(FRelGerenciais.EdDatai.asdate,true),4) );
          PConsumo.mesano01:=strzero(Datetomes(FRelGerenciais.EdDatai.asdate),2)+'/'+Strzero(Datetoano(FRelGerenciais.EdDatai.asdate,true),4);
          PConsumo.mesano02:='';PConsumo.mesano03:='';PConsumo.mesano04:='';PConsumo.mesano05:='';PConsumo.mesano06:='';
          PConsumo.mesano07:='';PConsumo.mesano08:='';PConsumo.mesano09:='';PConsumo.mesano10:='';PConsumo.mesano11:='';
          PConsumo.mesano12:='';
          PConsumo.valor01:=0;PConsumo.valor02:=0;PConsumo.valor03:=0;PConsumo.valor04:=0;PConsumo.valor05:=0;PConsumo.valor06:=0;
          PConsumo.valor07:=0;PConsumo.valor08:=0;PConsumo.valor09:=0;PConsumo.valor10:=0;PConsumo.valor11:=0;PConsumo.valor12:=0;
          PConsumo.qtde01:=0;PConsumo.qtde02:=0;PConsumo.qtde03:=0;PConsumo.qtde04:=0;PConsumo.qtde05:=0;PConsumo.qtde06:=0;
          PConsumo.qtde07:=0;PConsumo.qtde08:=0;PConsumo.qtde09:=0;PConsumo.qtde10:=0;PConsumo.qtde11:=0;PConsumo.qtde12:=0;
          data:=DateToDateMesPos(data,1);
//          PConsumo.valor01:=0;
          while data<=FRelGerenciais.EdDataf.asdate do begin
            if trim(PConsumo.mesano02)='' then
              PConsumo.mesano02:=strzero(Datetomes(data),2)+'/'+Strzero(Datetoano(data,true),4)
            else if trim(PConsumo.mesano03)='' then
              PConsumo.mesano03:=strzero(Datetomes(data),2)+'/'+Strzero(Datetoano(data,true),4)
            else if trim(PConsumo.mesano04)='' then
              PConsumo.mesano04:=strzero(Datetomes(data),2)+'/'+Strzero(Datetoano(data,true),4)
            else if trim(PConsumo.mesano05)='' then
              PConsumo.mesano05:=strzero(Datetomes(data),2)+'/'+Strzero(Datetoano(data,true),4)
            else if trim(PConsumo.mesano06)='' then
              PConsumo.mesano06:=strzero(Datetomes(data),2)+'/'+Strzero(Datetoano(data,true),4)
            else if trim(PConsumo.mesano07)='' then
              PConsumo.mesano07:=strzero(Datetomes(data),2)+'/'+Strzero(Datetoano(data,true),4)
            else if trim(PConsumo.mesano08)='' then
              PConsumo.mesano08:=strzero(Datetomes(data),2)+'/'+Strzero(Datetoano(data,true),4)
            else if trim(PConsumo.mesano09)='' then
              PConsumo.mesano09:=strzero(Datetomes(data),2)+'/'+Strzero(Datetoano(data,true),4)
            else if trim(PConsumo.mesano10)='' then
              PConsumo.mesano10:=strzero(Datetomes(data),2)+'/'+Strzero(Datetoano(data,true),4)
            else if trim(PConsumo.mesano11)='' then
              PConsumo.mesano11:=strzero(Datetomes(data),2)+'/'+Strzero(Datetoano(data,true),4)
            else if trim(PConsumo.mesano12)='' then
              PConsumo.mesano12:=strzero(Datetomes(data),2)+'/'+Strzero(Datetoano(data,true),4);
            data:=DateToDateMesPos(data,1);
          end;

        end;

        procedure AtualizaDadosMesano;
        //////////////////////////////
        var mesano:string;
            unitario:currency;
        begin
            mesano:=strzero(Datetomes(Q.fieldbyname('moes_datamvto').asdatetime),2)+'/'+Strzero(Datetoano(Q.fieldbyname('moes_datamvto').asdatetime,true),4);

//           unitario:=Q.fieldbyname('move_custo').ascurrency;
//           if unitario=0 then
              unitario:=1;
            if PConsumo.mesano01=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor01:=PConsumo.valor01-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde01:=PConsumo.qtde01-Q.fieldbyname('moes_vlrtotal').ascurrency;
              end else begin
                PConsumo.valor01:=PConsumo.valor01+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde01:=PConsumo.qtde01+Q.fieldbyname('moes_vlrtotal').ascurrency;
              end;
            end;
            if PConsumo.mesano02=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor02:=PConsumo.valor02-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde02:=PConsumo.qtde02-Q.fieldbyname('moes_vlrtotal').ascurrency;
              end else begin
                PConsumo.valor02:=PConsumo.valor02+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde02:=PConsumo.qtde02+Q.fieldbyname('moes_vlrtotal').ascurrency;
              end;
            end;
            if PConsumo.mesano03=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor03:=PConsumo.valor03-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde03:=PConsumo.qtde03-Q.fieldbyname('moes_vlrtotal').ascurrency;
              end else begin
                PConsumo.valor03:=PConsumo.valor03+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde03:=PConsumo.qtde03+ Q.fieldbyname('moes_vlrtotal').ascurrency;
              end;
            end;
            if PConsumo.mesano04=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor04:=PConsumo.valor04-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde04:=PConsumo.qtde04-Q.fieldbyname('moes_vlrtotal').ascurrency;
              end else begin
                PConsumo.valor04:=PConsumo.valor04+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde04:=PConsumo.qtde04+Q.fieldbyname('moes_vlrtotal').ascurrency;
              end;
            end;
            if PConsumo.mesano05=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor05:=PConsumo.valor05-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde05:=PConsumo.qtde05-Q.fieldbyname('moes_vlrtotal').ascurrency;
              end else begin
                PConsumo.valor05:=PConsumo.valor05+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde05:=PConsumo.qtde05+Q.fieldbyname('moes_vlrtotal').ascurrency;
              end;
            end;
            if PConsumo.mesano06=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor06:=PConsumo.valor06-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde06:=PConsumo.qtde06-Q.fieldbyname('moes_vlrtotal').ascurrency;
              end else begin
                PConsumo.valor06:=PConsumo.valor06+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde06:=PConsumo.qtde06+Q.fieldbyname('moes_vlrtotal').ascurrency;
              end;
            end;
            if PConsumo.mesano07=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor07:=PConsumo.valor07-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde07:=PConsumo.qtde07-Q.fieldbyname('moes_vlrtotal').ascurrency;
              end else begin
                PConsumo.valor07:=PConsumo.valor07+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde07:=PConsumo.qtde07+Q.fieldbyname('moes_vlrtotal').ascurrency;
              end;
            end;
            if PConsumo.mesano08=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor08:=PConsumo.valor08-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde08:=PConsumo.qtde08-Q.fieldbyname('moes_vlrtotal').ascurrency;
              end else begin
                PConsumo.valor08:=PConsumo.valor08+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde08:=PConsumo.qtde08+Q.fieldbyname('moes_vlrtotal').ascurrency;
              end;
            end;
            if PConsumo.mesano09=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor09:=PConsumo.valor09-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde09:=PConsumo.qtde09-Q.fieldbyname('moes_vlrtotal').ascurrency;
              end else begin
                PConsumo.valor09:=PConsumo.valor09+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde09:=PConsumo.qtde09+Q.fieldbyname('moes_vlrtotal').ascurrency;
              end;
            end;
            if PConsumo.mesano10=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor10:=PConsumo.valor10-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde10:=PConsumo.qtde10-Q.fieldbyname('moes_vlrtotal').ascurrency;
              end else begin
                PConsumo.valor10:=PConsumo.valor10+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde10:=PConsumo.qtde10+Q.fieldbyname('moes_vlrtotal').ascurrency;
              end;
            end;
            if PConsumo.mesano11=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor11:=PConsumo.valor11-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde11:=PConsumo.qtde11-Q.fieldbyname('moes_vlrtotal').ascurrency;
              end else begin
                PConsumo.valor11:=PConsumo.valor11+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde11:=PConsumo.qtde11+Q.fieldbyname('moes_vlrtotal').ascurrency;
              end;
            end;
            if PConsumo.mesano12=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor12:=PConsumo.valor12-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde12:=PConsumo.qtde12-Q.fieldbyname('moes_vlrtotal').ascurrency;
              end else begin
                PConsumo.valor12:=PConsumo.valor12+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde12:=PConsumo.qtde12+Q.fieldbyname('moes_vlrtotal').ascurrency;
              end;
            end;

        end;

    begin
//////////////////////////////////////////////////////////////////////
      achou:=false;
      for p:=0 to Lista.Count-1 do begin
        PConsumo:=Lista[p];
        if PConsumo.produto=Q.FieldByName('moes_tipo_codigo').asstring then begin
          achou:=true;
          break
        end;
      end;

      if not achou then begin
        New(PConsumo);
        PConsumo.produto:=Q.FieldByName('moes_tipo_codigo').asstring;
        PConsumo.descricao:='';
        PConsumo.referencia:='';
        ConfiguraMesano;
        AtualizaDadosMesano;
        Lista.add(Pconsumo);
      end else begin
        AtualizaDadosMesano;
      end;

    end;


begin
///////////////////////////////////////////////////////////
  with FRelGerenciais do begin
    if not FRelGerenciais_Execute(38) then Exit;
    Sistema.BeginProcess('Pesquisando');
    sqlinicio:=' and moes_datamvto>='+Datetosql(EdDatai.AsDate);
    if EdDAtaf.isempty then
       sqltermino:=''
    else
       sqltermino:=' and moes_datamvto<='+Datetosql(EdDataf.Asdate);
    if EdDAtai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and moes_tipo_codigo='+EdCodtipo.assql;
      if Edtipocad.text='R' then
        sqlcodtipo:=' and moes_repr_codigo='+EdCodtipo.assql;

    end;
    devolucoes:=Global.TiposRelDevVenda;
    sqltipomovto:=' and '+FGEral.GetIN('moes_tipomov',Global.TiposRelVenda+';'+Devolucoes,'C');
    sqlstatus:=FGeral.Getin('moes_status','N,D,E','C');
    Q:=sqltoquery('select moes_tipo_codigo,moes_vlrtotal,moes_datamvto,moes_tipomov from movesto '+
                     ' where '+sqlstatus+
                     ' and '+FGeral.Getin('moes_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+sqlcodtipo+
                     sqltipomovto+
                     ' order by moes_datamvto' );
    if Q.eof then begin
      Avisoerro('Nada encontrado para impress�o');
      Sistema.EndProcess('');
      Q.close;
      Freeandnil(Q);
      exit;
    end;
    Lista:=TList.create;
    Sistema.BeginProcess('Somando valores no periodo por cliente');
    while not Q.eof do begin
      AtualizaLista;
      Q.Next;
    end;
    if Lista.count=0 then begin
      Avisoerro('N�o encontrado vendas no per�odo');
      Sistema.EndProcess('');
      Q.close;
      Freeandnil(Q);
      exit;
    end;
    Sistema.BeginProcess('Gerando Relat�rio');
    FRel.Init('RelAnaliseVendaporCliente');
    FRel.AddTit('Relat�rio de An�lise de Venda por Cliente');
    FRel.AddTit('Unidade : '+EdUnid_codigo.text+' - '+FGeral.Gettitulounidades(EdUnid_codigo.text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,FRelGerenciais.EdTipocad.text));
    FRel.AddTit('Periodo : '+formatdatetime('dd/mm/yy',FRelGerenciais.EdDatai.AsDate)+' a '+formatdatetime('dd/mm/yy',EdDataf.AsDate));
    FRel.AddCol( 50,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
    FRel.AddCol(220,1,'C','' ,''              ,'Nome'       ,''         ,'',false);
    PConsumo:=Lista[0];
    FRel.AddCol( 70,3,'N','+' ,f_cr              ,PConsumo.mesano01       ,''         ,'',false);
//    FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    if trim(PConsumo.mesano02)<>'' then begin
      FRel.AddCol( 70,3,'N','+' ,f_cr            ,PConsumo.mesano02       ,''         ,'',false);
//      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano03)<>'' then begin
      FRel.AddCol( 70,3,'N','+' ,f_cr              ,PConsumo.mesano03       ,''         ,'',false);
  //    FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano04)<>'' then begin
      FRel.AddCol( 70,3,'N','+' ,f_cr              ,PConsumo.mesano04       ,''         ,'',false);
    //  FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano05)<>'' then begin
      FRel.AddCol( 70,3,'N','+' ,f_cr              ,PConsumo.mesano05       ,''         ,'',false);
//      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano06)<>'' then begin
      FRel.AddCol( 70,3,'N','+' ,f_cr              ,PConsumo.mesano06       ,''         ,'',false);
  //    FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano07)<>'' then begin
      FRel.AddCol( 70,3,'N','+' ,f_cr              ,PConsumo.mesano07       ,''         ,'',false);
//      FRel.AddCol7 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano08)<>'' then begin
      FRel.AddCol( 70,3,'N','+' ,f_cr              ,PConsumo.mesano08       ,''         ,'',false);
//      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano09)<>'' then begin
      FRel.AddCol( 70,3,'N','+' ,f_cr              ,PConsumo.mesano09       ,''         ,'',false);
  //    FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano10)<>'' then begin
      FRel.AddCol( 70,3,'N','+' ,f_cr              ,PConsumo.mesano10       ,''         ,'',false);
    //  FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano11)<>'' then begin
      FRel.AddCol( 70,3,'N','+' ,f_cr              ,PConsumo.mesano11       ,''         ,'',false);
//      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano12)<>'' then begin
      FRel.AddCol( 70,3,'N','+' ,f_cr             ,PConsumo.mesano12       ,''         ,'',false);
  //    FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    FRel.AddCol( 80,3,'N','+' ,f_cr            ,'Total'          ,''         ,'',false);

    for i:=0 to LIsta.count-1 do begin
      Pconsumo:=Lista[i];
      FRel.AddCel(PConsumo.produto);
      FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(strtoint(PConsumo.produto),'C','N') );
      FRel.AddCel(floattostr(PConsumo.qtde01));
//      FRel.AddCel(floattostr(PConsumo.valor01));
      if trim(PConsumo.mesano02)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde02));
//        FRel.AddCel(floattostr(PConsumo.valor02));
      end;
      if trim(PConsumo.mesano03)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde03));
//        FRel.AddCel(floattostr(PConsumo.valor03));
      end;
      if trim(PConsumo.mesano04)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde04));
//        FRel.AddCel(floattostr(PConsumo.valor04));
      end;
      if trim(PConsumo.mesano05)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde05));
//        FRel.AddCel(floattostr(PConsumo.valor05));
      end;
      if trim(PConsumo.mesano06)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde06));
//        FRel.AddCel(floattostr(PConsumo.valor06));
      end;
      if trim(PConsumo.mesano07)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde07));
//        FRel.AddCel(floattostr(PConsumo.valor07));
      end;
      if trim(PConsumo.mesano08)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde08));
//        FRel.AddCel(floattostr(PConsumo.valor08));
      end;
      if trim(PConsumo.mesano09)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde09));
//        FRel.AddCel(floattostr(PConsumo.valor09));
      end;
      if trim(PConsumo.mesano10)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde10));
//        FRel.AddCel(floattostr(PConsumo.valor10));
      end;
      if trim(PConsumo.mesano11)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde11));
//        FRel.AddCel(floattostr(PConsumo.valor11));
      end;
      if trim(PConsumo.mesano12)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde12));
//        FRel.AddCel(floattostr(PConsumo.valor12));
      end;
      FRel.AddCel(floattostr(PConsumo.qtde12+PConsumo.qtde11+PConsumo.qtde10+PConsumo.qtde09+PConsumo.qtde08+
                  PConsumo.qtde07+PConsumo.qtde06+PConsumo.qtde05+PConsumo.qtde04+PConsumo.qtde03+PConsumo.qtde02+PConsumo.qtde01));
    end;
    FRel.Video();
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

  end;

  FRelGerenciais_AnaliseVendasporCliente;         // 38

end;

// 13.06.19
procedure FRelGerenciais_Lotes;     // 39
/////////////////////////////////////////////////
var Q,
    Qd         :TSqlquery;
    sqlltipos,
    campos     :string;
    vganhopeso :currency;

begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(39) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('movd_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    sqltipomovto:=' and '+FGeral.getin('movd_tipomov','LO','C');
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and movd_tipo_codigo='+EdCodtipo.assql;
    end;

    campos:='*';
    Q:=sqltoquery('select '+campos+' from movabatedet'+
                  ' inner join movabate on (mova_transacao=movd_transacao and mova_tipomov=movd_tipomov and movd_status<>''C'')'+
                  ' where movd_datamvto>='+EdDatai.AsSql+' and movd_datamvto<='+EdDataf.AsSql+
                  sqlunidade+sqltipomovto+sqlcodtipo+
                  ' order by movd_unid_codigo,movd_datamvto' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

      FRel.Init('RelLotesFazenda');
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
      FRel.AddTit('Relat�rio de Lotes da Fazenda');
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
//      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
//      FRel.AddCol( 80,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'  ,''         ,'',false);
      FRel.AddCol( 60,2,'N','' ,''              ,'Lote'     ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'Brinco'            ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'Codigo'            ,''         ,'',False);
      FRel.AddCol(150,0,'C','' ,''              ,'Descri��o Animal'            ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'Setor'            ,''         ,'',False);
      FRel.AddCol(150,0,'C','' ,''              ,'Descri��o Setor'            ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'Produtor'            ,''         ,'',False);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome Produtor'            ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'Baia'            ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Peso' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','',f_cr             ,'% Proje��o' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',f_cr            ,'Peso Projetado' ,''         ,'',False);

      while not Q.eof do begin

//        FRel.AddCel(Q.FieldByName('movd_unid_codigo').AsString);
//        FRel.AddCel(Q.FieldByName('movd_transacao').AsString);
        Qd:=sqltoquery('select movd_seto_codigo,movd_tipo_codigo from movabatedet'+
                     ' where movd_status = ''N'''+
                     ' and movd_brinco = '+stringtosql(Q.FieldByName('movd_brinco').AsString)+
                     ' and movd_unid_codigo = '+stringtosql(Q.FieldByName('movd_unid_codigo').AsString)+
                     ' and '+FGeral.GetIN('movd_tipomov',TipoEntradaAbate+';'+TipoFazenda+';'+TipoPesagem,'C' )+
                     ' and movd_datamvto >= '+Datetosql(Q.FieldByName('movd_datamvto').AsDatetime-60) );
        FRel.AddCel(Q.FieldByName('movd_datamvto').AsString);

        FRel.AddCel(Q.FieldByName('movd_numerodoc').AsString);
        FRel.AddCel(Q.FieldByName('movd_brinco').AsString);
        FRel.AddCel(Q.fieldbyname('movd_esto_codigo').asstring);
        FRel.AddCel(FEstoque.getdescricao(Q.fieldbyname('movd_esto_codigo').asstring));
        if not Qd.Eof then begin

           FRel.AddCel(Qd.FieldByName('movd_seto_codigo').AsString);
           FRel.AddCel(FSetores.GetDescricao( Qd.FieldByName('movd_seto_codigo').AsString) );
           FRel.AddCel(Qd.FieldByName('movd_tipo_codigo').AsString);
           FRel.AddCel(FCadcli.GetNOme( Qd.FieldByName('movd_tipo_codigo').AsInteger) );

        end else begin

           FRel.AddCel('');
           FRel.AddCel('');
           FRel.AddCel('');
           FRel.AddCel('');

        end;

        FGeral.FechaQuery(Qd);
        FRel.AddCel(Q.FieldByName('movd_baia').AsString);
        FRel.AddCel(Q.FieldByName('movd_pesovivo').AsString);
        FRel.AddCel(Q.FieldByName('mova_ganhopeso').AsString);
        vganhopeso:=trunc(Sistema.Hoje-Q.FieldByName('movd_datamvto').AsDatetime)*
                    Q.FieldByName('movd_pesovivo').Ascurrency*
                   (Q.FieldByName('mova_ganhopeso').Ascurrency/100) +
                   ( Q.FieldByName('movd_pesovivo').Ascurrency );
        FRel.AddCel( floattostr(vganhopeso) );
        Q.Next;

      end;

      FRel.Video;

    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);

  end;

  FRelGerenciais_Lotes;     // 39

end;

// 17.06.19
procedure FRelGerenciais_ComissoesBoiadeiros ;      // 40
///////////////////////////////////////////////////
var Q,QF:TSqlquery;
    statusvalidos,sqlorder,sqlunidade,sqltipocod,tiposvenda,tiposdev,titulo,devolucoes:string;
    comissaocabecas,comissaokm,percomissao:currency;
    km,
    cabecas:integer;


    function DifKM( xkmi,xkmf : integer ):integer;
    ///////////////////////////////////////////////////
    begin

        if xkmf>=xkmi then result:= xkmf-xkmi
        else result:=( 100000 - xkmi ) + xkmf;

    end;




begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(40) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    statusvalidos:='N';
    sqlorder:=' order by mova_unid_codigo,mova_repr_codigo,mova_tipo_codigo,mova_numerodoc';
    sqlunidade:=' and '+FGeral.getin('mova_unid_codigo',EdUnid_codigo.text,'C');
    if EdCodtipo.Asinteger>0 then begin
      if Edtipocad.text='R' then
        sqltipocod:=' and mova_repr_codigo='+EdCodtipo.assql
      else
        sqltipocod:=' and mova_tipo_codigo='+EdCodtipo.assql;
    end else
      sqltipocod:='';

    TipoEntradaAbate:='EA';

    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
      sqldatacont:=' and mova_datacont > '+DateToSql(Global.DataMenorBanco);

    titulo:='Comiss�o Boiadeiros sobre Entrada de Abate de '+FGeral.FormataData(Eddatai.asdate)+' a '+FGeral.FormataData(Eddataf.asdate);
    Q:=sqltoquery('select * from movabate '+
//                  ' inner join movabate on ( mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc and mova_tipomov=movd_tipomov)'+
//                  ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                  ' where '+FGeral.GetIN('mova_status',statusvalidos,'C')+
//                  ' and '+FGeral.GetIN('movd_status',statusvalidos,'C')+
                  ' and mova_dtabate>='+Eddatai.AsSql+' and mova_dtabate<='+Eddataf.AsSql+
                  sqlunidade+
                  sqltipocod+
                  sqldatacont+
                  ' and '+FGeral.getin('mova_tipomov',tipoentradaabate,'C')+
                  sqlorder );


    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      FRel.Init('RelComissoesBoiadeiros');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Emiss�o'         ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
      FRel.AddCol( 45,0,'C','' ,''              ,'Cod.Mot.'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Motorista'            ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Cod.Veic.'     ,''         ,'',false);
      FRel.AddCol(140,0,'C','' ,''              ,'Caminh�o'    ,''         ,'',false);
//      FRel.AddCol( 45,0,'C','' ,''              ,'Produto'         ,''         ,'',false);
//      FRel.AddCol(140,0,'C','' ,''              ,'Descri��o'       ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'KM'   ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Comiss�o KM'  ,''         ,'',false);
      FRel.AddCol(080,3,'N','',f_cr             ,'Por KM'  ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Cabe�as'   ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Comiss�o Cab.'  ,''         ,'',false);
      FRel.AddCol(080,3,'N','',f_cr             ,'Por Cabe�a'  ,''         ,'',false);

      while not Q.eof do begin

          FRel.AddCel(Q.FieldByName('mova_unid_codigo').AsString);
          FRel.AddCel(Q.FieldByName('mova_dtabate').AsString);
          FRel.AddCel(Q.FieldByName('mova_datacont').AsString);
          FRel.AddCel(Q.FieldByName('mova_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('mova_cola_codigo').AsString);
          FRel.AddCel(FColaboradores.GetDescricao(Q.FieldByName('mova_cola_codigo').AsString));
          FRel.AddCel(Q.FieldByName('mova_tran_codigo').AsString);
          FRel.AddCel(FTransp.GetNome(Q.FieldByName('mova_tran_codigo').AsString));
//          FRel.AddCel(Q.FieldByName('movd_esto_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
          km:=DifKM( Q.Fieldbyname('Mova_kmi').AsInteger,Q.Fieldbyname('Mova_kmf').AsInteger);
          FRel.AddCel(floattostr(km));
          percomissao:=FGeral.getconfig1asfloat('percomkm');
          comissaokm:=(km) * (percomissao);
          FRel.AddCel(valortosql(comissaokm));
          FRel.AddCel(valortosql(percomissao));
          QF:=sqltoquery('select count(*) as cabecas from movabatedet '+
                  ' where '+FGeral.GetIN('movd_status',statusvalidos,'C')+
                  ' and '+FGeral.getin('movd_tipomov',tipoentradaabate,'C')+
                  ' and movd_transacao = '+Stringtosql(Q.FieldByName('mova_transacao').AsString));

          cabecas:=Qf.FieldByName('cabecas').AsInteger;
          FGeral.FechaQuery(QF);
          FRel.AddCel(floattostr(cabecas));
          percomissao:=FGeral.GetConfig1AsFloat('percomcab');
          comissaocabecas:=(cabecas) * (percomissao);
          FRel.AddCel(valortosql(comissaocabecas));
          FRel.AddCel(valortosql(percomissao));

        Q.Next;

      end;

      FRel.Video;

    end;

    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

    FRelGerenciais_ComissoesBoiadeiros;     // 40

  end;

end;

// 06.08.20 - Resumo Lotes
procedure FRelGerenciais_LotesResumo;     // 42
/////////////////////////////////////////////////
var Q,
    Qd         :TSqlquery;
    sqlltipos,
    campos,
    brincosnao,
    sqlperiodo,
    baia       :string;
    vganhopeso :currency;
    lote,
    vivos,
    abatidos,
    naoenc ,
    abatido    :integer;

begin

  with FRelGerenciais do begin

    if not FRelGerenciais_Execute(42) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('movd_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    sqltipomovto:=' and '+FGeral.getin('movd_tipomov','LO','C');
    if EdCodtipo.isempty then
      sqlcodtipo:=''
    else begin
      sqlcodtipo:=' and movd_tipo_codigo='+EdCodtipo.assql;
    end;
// 08.09.20
//    if EdAbatidos.text = 'A' then
//
//       sqlperiodo:=' movd_dataabate>='+FRelGerenciais.EdDatai.AsSql+' and movd_dataabate<='+FRelGerenciais.EdDataf.AsSql
//
//    else

       sqlperiodo:=' movd_datamvto>='+FRelGerenciais.EdDatai.AsSql+' and movd_datamvto<='+FRelGerenciais.EdDataf.AsSql;

    campos:='*';
    Q:=sqltoquery('select '+campos+' from movabatedet'+
                  ' inner join movabate on (mova_transacao=movd_transacao and mova_tipomov=movd_tipomov and movd_status<>''C'')'+
                  ' where '+
                  sqlperiodo+
                  sqlunidade+sqltipomovto+sqlcodtipo+
                  ' order by movd_numerodoc' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

      FRel.Init('RelLotesFazendaResumo');
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
      FRel.AddTit('Relat�rio de Resumo dos Lotes da Fazenda');
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
//      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
//      FRel.AddCol( 80,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
//      FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'  ,''         ,'',false);
      FRel.AddCol( 60,2,'N','' ,''              ,'Lote'     ,''         ,'',False);
      FRel.AddCol( 50,0,'C','' ,''              ,'Baia'            ,''         ,'',False);
      FRel.AddCol(150,0,'C','' ,''              ,'Endere�o'            ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',''              ,'Vivos' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',''              ,'Abatidos' ,''         ,'',False);
      FRel.AddCol( 90,3,'N','+',''              ,'N�o Encontrados' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',''              ,'Total' ,''         ,'',False);
      FRel.AddCol(150,1,'C','' ,''              ,'Brincos N�o Encontrados' ,''         ,'',False);

      while not Q.eof do begin

        lote     := Q.FieldByName('movd_numerodoc').AsInteger;
        baia     := Q.FieldByName('movd_baia').AsString;
        vivos    :=0;
        abatidos := 0;
        naoenc   := 0;
        brincosnao := '';

        while (not Q.eof) and ( lote = Q.FieldByName('movd_numerodoc').AsInteger)  do begin

            Qd:=sqltoquery('select movd_seto_codigo,movd_tipo_codigo,movd_dataabate from movabatedet'+
                         ' where movd_status = ''N'''+
                         ' and movd_brinco = '+stringtosql(Q.FieldByName('movd_brinco').AsString)+
//                         ' and movd_unid_codigo = '+stringtosql(Q.FieldByName('movd_unid_codigo').AsString)+
                         ' and '+FGeral.GetIN('movd_tipomov',TipoEntradaAbate+';'+TipoFazenda+';'+TipoPesagem,'C' )+
                         ' and movd_datamvto >= '+Datetosql(Q.FieldByName('movd_datamvto').AsDatetime-180) );

            if not Qd.Eof then begin

               abatido := 0;

               while not Qd.eof do  begin

                  if Datetoano( Qd.fieldbyname('movd_dataabate').asdatetime,true ) > 1902 then begin
                     inc(abatido ) ;
                     break;
                  end;

                  Qd.Next;

               end;

               if abatido >0 then
                  inc(abatidos )
               else
                  inc(  vivos  );

               if lote = 0 then

                  brincosnao := brincosnao + Q.FieldByName('movd_brinco').AsString + ';';

            end else begin

               inc(naoenc);
               brincosnao := brincosnao + Q.FieldByName('movd_brinco').AsString + ';';

            end;

            FGeral.FechaQuery(Qd);
            Q.Next;

        end;

        FRel.AddCel( inttostr(lote) );
        FRel.AddCel( baia );
        FRel.AddCel(FBaias.GetDescricao( baia ));
        FRel.AddCel( inttostr(vivos) );
        FRel.AddCel( inttostr(abatidos) );
        FRel.AddCel( inttostr(naoenc) );
        FRel.AddCel( inttostr(vivos+abatidos) );
        FRel.AddCel( brincosnao );

      end;

      FRel.Video;

    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);

  end;

  FRelGerenciais_LotesResumo;     // 42

end;



end.
