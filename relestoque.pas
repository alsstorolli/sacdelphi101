unit relestoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, SQLBtn, StdCtrls, alabel, Mask, SQLEd, ExtCtrls,
  SQLGrid, SqlExpr, Sqlsis;

type
  TFRelEstoque = class(TForm)
    PRel: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    baplicar: TSQLBtn;
    bSair: TSQLBtn;
    Edunid_codigo: TSQLEd;
    EdEsto_codigo: TSQLEd;
    SetEdFUNC_NOME: TSQLEd;
    EdGrup_codigo: TSQLEd;
    SetEdDEPT_DESCRICAO: TSQLEd;
    EdSugr_codigo: TSQLEd;
    SetEdSECC_DESCRICAO: TSQLEd;
    PMens: TSQLPanelGrid;
    Eddatai: TSQLEd;
    Eddataf: TSQLEd;
    EdFami_codigo: TSQLEd;
    SQLEd2: TSQLEd;
    EdDocumento: TSQLEd;
    EdTipomov: TSQLEd;
    EdSomagrade: TSQLEd;
    Edestcalculado: TSQLEd;
    EdMesano: TSQLEd;
    EdUnidcusto: TSQLEd;
    SetEdunid_nome: TSQLEd;
    EdCodtipo: TSQLEd;
    EdTipocad: TSQLEd;
    SetEdFavorecido: TSQLEd;
    EdCodcor: TSQLEd;
    EdCodtamanho: TSQLEd;
    Ednroobra: TSQLEd;
    EdCertificado: TSQLEd;
    EdUsarmarkup: TSQLEd;
    EdTamanhos: TSQLEd;
    EdMoes_tabp_codigo: TSQLEd;
    SetEdTABP_ALIQUOTA: TSQLEd;
    EdDifdezero: TSQLEd;
    EdFiltro: TSQLEd;
    EdQdata: TSQLEd;
    procedure baplicarClick(Sender: TObject);
    procedure EdGrup_codigoValidate(Sender: TObject);
    procedure EdSugr_codigoValidate(Sender: TObject);
    procedure EdFami_codigoValidate(Sender: TObject);
    procedure EdEsto_codigoValidate(Sender: TObject);
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdTipomovValidate(Sender: TObject);
    procedure EdDocumentoValidate(Sender: TObject);
    procedure EdCodtipoValidate(Sender: TObject);
    procedure EdestcalculadoValidate(Sender: TObject);
    procedure EdUnidcustoExitEdit(Sender: TObject);
    procedure EdUnidcustoKeyPress(Sender: TObject; var Key: Char);
    procedure EdTipocadValidate(Sender: TObject);
    procedure EdCodtipoExitEdit(Sender: TObject);
    procedure EdTipomovExitEdit(Sender: TObject);
    procedure EdnroobraValidate(Sender: TObject);
    procedure EddatafExitEdit(Sender: TObject);
    procedure EdTamanhosValidate(Sender: TObject);
    procedure EdMoes_tabp_codigoValidate(Sender: TObject);
  private
    { Private declarations }
    SaiOk:Boolean;
  public
    { Public declarations }
  end;


type TSaldos=record
     produto,unidade,balanco:string;
     cor,tamanho,copa,embalagem:integer;
     qtde,qtdeprev,aqtde,aqtdeprev,entradas,saidas,custo,custoger,customedio,customeger,pecas,
     apecas,aqtdeprocesso,qtdeprocesso:currency;
end;

const CodOrcamento:string='OR';

var
  FRelEstoque: TFRelEstoque;
  Q,QSaldoAnterior,QMov,Salestoque:TSqlquery;
  sqlproduto,sqlgrupo,sqlsubgrupo,sqlfamilia,sqltipomovto,sqldocumento,sqlcliente,somargrade,sqlunidade,mesanoant,
  sqlqtde,sqlobra,cQtdeprocesso,sqltamanhos:string;
  largura,nrorel:integer;
  custo,custoger,customedio,customedioger,venda,perc:currency;
  PSaldos:^TSaldos;
  ListaSaldos:Tlist;
  campo:TDicionario;


procedure FRelEstoque_Posicao;         // 1
procedure FRelEstoque_Extrato;         // 2
procedure FRelEstoque_Cadastro;        // 3
procedure FRelEstoque_InventaConsig(tipo,retro:string);        // 4
procedure FRelEstoque_Inventario;     // 5
procedure FRelEstoque_ExtratoSintetico;   // 6
procedure FRelEstoque_Contagem;         // 7
procedure FRelEstoque_ExtratoEstoqueFora(qestoque:string);         // 8
procedure FRelEstoque_ExtratoFora;         // 8
procedure FRelEstoque_ListaPreco;          // 9
procedure FRelEstoque_VendasMinimo;          // 10
procedure FRelEstoque_ExtratoColunas;            // 11
procedure FRelEstoque_Consumo;            // 12
procedure FRelEstoque_ConsumoABC(tipo:string);            // 13
procedure FRelEstoque_SemMovimento;             // 14
procedure FRelEstoque_CreditoMadeira;             // 15
procedure FRelEstoque_PrevistoRealizado;           // 16
procedure FRelEstoque_PontoRessuprimento;          // 17
procedure FRelEstoque_ReservaemObra;          // 18
procedure FRelEstoque_PosicaoEstoqueemPeso;          // 19
procedure FRelEstoque_RastreamentoProduto;          // 20
procedure FRelEstoque_RastreamentoVendas  ;          // 21
procedure FRelEstoque_ExtratoCamarafria;   // 22
procedure FRelEstoque_EstoqueCamarafria;   // 24
procedure FRelEstoque_TributacaoNcm;       // 25

implementation

uses Arquiv, Geral, SQLRel, Unidades, grupos, SqlFun, Subgrupos, familias,
  TextRel, Estoque, codigosfis, Sittribu, represen, cadcor, tamanhos,
  cadcopa, Usuarios, cadcli, tabela, custos;

{$R *.dfm}



function GetQtdecalc(codigo,campo,unid:string;cor,tamanho,copa:integer):currency;
///////////////////////////////////////////////////////////////////////////////////////
var p:integer;
begin
   result:=0;
   for p:=0 to ListaSAldos.Count-1 do begin
          PSaldos:=Listasaldos[p];
          if (Psaldos.produto=codigo) and (Psaldos.unidade=unid) and (PSaldos.cor=cor) and (PSaldos.tamanho=tamanho)
             and ( Psaldos.copa=copa )
             then begin
//            if ansipos(campo,'esto_qtde;esqt_qtde')>0 then
// 25.05.05
//            if campo='esqt_qtde' then
            if campo='XXXX_qtde' then begin
              if PSaldos.balanco='S' then
                result:=PSAldos.qtde
              else
                result:=PSAldos.aqtde+PSAldos.qtde;
            end else if campo='XXXX_pecas' then begin
              if PSaldos.balanco='S' then
                result:=PSAldos.pecas
              else
                result:=PSAldos.apecas+PSAldos.pecas;
            end else begin
              if PSaldos.balanco='S' then
                result:=PSAldos.qtdeprev
              else
                result:=PSAldos.aqtdeprev+PSAldos.qtdeprev;
            end;
            break;
          end;
   end;
end;

procedure Iniciatotais;
begin
end;


function montatit(grupo,subgrupo,familia:integer):string;
var s:string;
begin
  s:='';
  if grupo > 0 then s:='Grupo : '+strzero(grupo,3)+'-'+FGrupos.GetDescricao(grupo);
  if subgrupo > 0 then
    if trim(s) <> '' then s:=s+' - Sub-grupo : '+strzero(subgrupo,4)+'-'+FSubgrupos.GetDescricao(subgrupo)
    else s:='Sub-grupo : '+strzero(subgrupo,4)+'-'+FSubgrupos.GetDescricao(subgrupo);
  if familia > 0 then
    if trim(s) <> '' then s:=s+' - Familia : '+strzero(familia,4)+'-'+FFamilias.GetDescricao(familia)
    else s:='Familia : '+strzero(familia,4)+'-'+FFamilias.GetDescricao(familia);
  result:=s;
end;


function FRelEstoque_Execute(Tp:Integer):Boolean;
///////////////////////////////////////////////////

begin

  if FRelEstoque=nil then FGeral.CreateForm(TFRelEstoque, FRelEstoque);
  result:=true;
  nrorel:=tp;
  campo:=Sistema.GetDicionario('estoqueqtde','esqt_qtdeprocesso');
  cQtdeprocesso:='N';
  if campo.Tipo<>'' then
    cQtdeprocesso:='S';

  with FRelEstoque do begin

    FUnidades.SetaItems(EdUnid_codigo,nil,Global.Usuario.UnidadesRelatorios);
    FGeral.SetaItemsMovimento(EdTipomov);
    sqltipomovto:='';sqldocumento:='';
    EdTamanhos.Enabled:=false;
    if trim(FRelEstoque.Edunid_codigo.Text)='' then
      FRelEstoque.Edunid_codigo.Text := Global.CodigoUnidade;
    if FRelEstoque.EdDatai.AsDate=0 then
      FRelEstoque.Eddatai.SetDate(DatetoPrimeirodiames(Sistema.Hoje));
    if FRelEstoque.EdDataf.AsDate=0 then
      FRelEstoque.Eddataf.SetDate(Sistema.Hoje);
    EdDifdezero.Enabled:=(tp=1);
    EdFiltro.Enabled:=false;
    EdQDAta.Enabled :=false;
    if tp=2 then
      Caption:='Extrato de Movimentação do Produto'
    else if tp=1 then
      Caption:='Relatório de Posição de Estoque'
    else if tp=3 then
      Caption:='Relatório de Cadastro do Estoque'
    else if tp=4 then
      Caption:='Relatório de Inventário Consignado/Regime Especial/Pronta Entrega'
    else if tp=5 then begin
      Caption:='Relatório de Inventário';
      EdTamanhos.Enabled:=true;
      FTamanhos.SetaItems(EdTamanhos,nil,'','');
    end else if tp=6 then
      Caption:='Extrato de Sintético por Tipo de Movimentação do Produto'
    else if tp=7 then
      Caption:='Contagem de Estoque'
    else if tp=8 then
        Caption:='Extrato de Movimentação da Pronta Entrega/Regime Especial/Consignado'
    else if tp=9 then
        Caption:='Lista de Preços'
    else if tp=10 then
        Caption:='Vendas Abaixo do Mínimo'
    else if tp=11 then
        Caption:='Extrato em colunas da Movimentação do Produto'
    else if tp=12 then
        Caption:='Consumo de Materiais'
    else if tp=13 then
        Caption:='Curva ABC Consumo / Estoque'
    else if tp=14 then
        Caption:='Produtos Sem Movimento'
    else if tp=15 then
        Caption:='Crédito de Madeira Certificada'
    else if tp=16 then
        Caption:='Previsto/Realizado de Consumo de Materiais'
    else if tp=17 then
        Caption:='Ponto de Ressuprimento'
    else if tp=18 then
        Caption:='Reserva em Obra'
    else if tp=19 then
        Caption:='Estoque por Peso'
    else if tp=20 then begin
        Caption:='Rastreamento Produto';
        EdTipocad.Enabled:=true;
        EdFiltro.Enabled:=true;
        EdCodtipo.enabled:=true;
///        EdQData.Enabled :=true;
///    revisar..melhor fazer outro relatorio somente os 'pesados'...
    end else if tp=21 then begin
        Caption:='Rastreamento Vendas';
        EdTipocad.Enabled:=false;
    end else if tp=22 then begin
        Caption:='Extrato Camara Fria';
        EdTipocad.Enabled:=false;
 // 24.11.20
    end else if tp=23 then begin

        Caption:='Estoque Camara Fria';
        EdTipocad.Enabled:=false;

    end;
//      else
//        Caption:='Extrato de Movimentação do Regime Especial';

//    tipomovestoque:=Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig+';'+Global.CodCompra+';'+
//                    Global.CodVendaDireta+';'+Global.CodDevolucaoCompra+';'+Global.CodAcertoEsEnt+';'+
//                    Global.CodAcertoEsSai+';';
    EdCodtipo.enabled:=false;
    EdSomagrade.enabled:=false;
    EdCertificado.enabled:=false;
    EdUsarMarkup.enabled:=false;
    EdMoes_tabp_codigo.enabled:=tp=9;
    EdTipoCad.Enabled:=true;
    EdGrup_codigo.enabled:=true;
    EdSugr_codigo.enabled:=true;
    EdFami_codigo.enabled:=true;
    EdTipomov.enabled:=true;
    Eddocumento.enabled:=true;
    EdDatai.enabled:=true;
    if (Tp=20) or (Tp=21)  then begin

      EdTipoCad.Enabled:=false;
      EdGrup_codigo.enabled:=false;
      EdSugr_codigo.enabled:=false;
      EdFami_codigo.enabled:=false;
      EdTipomov.enabled:=false;
      if Tp=21 then
         Eddocumento.enabled:=false
      else begin
         Eddocumento.enabled:=true;
         EdCodtipo.enabled:=true;
         EdTipoCad.Enabled:=true;
      end;

    end;

    if (tp=3) or (tp=1) or (tp=5) or (tp=7) or (tp=9) or (tp=19) then begin
      EdDatai.enabled:=false;
      if tp=1 then
        EdDataf.enabled:=true
      else
        EdDataf.enabled:=false;
      EdDocumento.enabled:=false;
      EdTipomov.enabled:=false;
      EdCodtipo.enabled:=false;
      if tp=1 then
        EdSomagrade.enabled:=true
      else
        EdSomagrade.enabled:=false;
      if (tp=9) then begin
        EdTipocad.enabled:=false;
        EdUsarMarkup.enabled:=true;
      end;
      if (tp=5) or ( tp=19 ) then
        EdTipocad.enabled:=false;
    end;
    if (tp=2) or (tp=6) then begin
      EdDatai.enabled:=true;
      EdDataf.enabled:=true;
      EdDocumento.enabled:=true;
      EdTipomov.enabled:=true;
      EdCodtipo.enabled:=true;
//      EdSomagrade.enabled:=false;
    end;
    if (tp=1) or (tp=5) or (tp=4) then begin
      if tp<>4 then
        Edmesano.enabled:=true
      else
        Edmesano.enabled:=false;
      if (tp=5) or (tp=4) then begin
        EdEstcalculado.enabled:=false;
        EdUnidcusto.enabled:=true;
        EdTipomov.enabled:=false;
      end else begin
        EdEstcalculado.enabled:=true;
        EdUnidcusto.enabled:=false;
        EdUnidcusto.text:='';
      end;
    end else begin
      Edmesano.enabled:=false;
      EdEstcalculado.enabled:=false;
    end;
    if tp=4 then begin
      EdDatai.enabled:=true;
      EdDataf.enabled:=true;
      EdCodtipo.enabled:=true;
    end;
    if tp=8 then
       EdCodtipo.enabled:=true;
    if (tp=10) then
       EdTipocad.Enabled:=false;
    if tp=11 then begin
      EdDatai.enabled:=true;  // 02.05.08
      EdDataf.enabled:=true;  // 02.05.08
      EdNroobra.Enabled:=Global.Topicos[1204];
    end;
    EdCodcor.enabled:=( (tp=2) or (tp=11) or (tp=1) );
    EdCodtamanho.enabled:=( (tp=2) or (tp=11) or (tp=1) );
// 14.01.09
   if (tp=15) then begin
        EdTipocad.enabled:=false;
        EdCertificado.enabled:=true;   // 10.04.09
// 04.04.11 - Capitulo 4 - saldo somente dos controlados
//            por enquanto pede pra pode escolher os controlados
        EdDatai.SetDate( DatetoDateMesAnt(Sistema.hoje,12) );
        EdDataf.SetDate( Sistema.hoje );
   end;
// 11.03.09
    if (tp=12) or (tp=13)  then begin
      EdTipocad.enabled:=false;
      EdTipomov.Items.Clear;
      if tp=12 then begin
        EdTipomov.Items.Add(Global.CodSaidaAlmox+' - Saida Almoxarifado');
        EdTipomov.Items.Add(Global.CodRequisicaoAlmox+' - Requisição Almoxarifado');
        EdTipomov.Items.Add(Global.CodEntradaAlmox+' - Entrada Almoxarifado');
        EdTipomov.text:=Global.CodSaidaAlmox+';'+Global.CodEntradaAlmox;
      end else begin
        EdTipomov.Items.Add(Global.CodSaidaAlmox+' - Saida Almoxarifado');
        EdTipomov.Items.Add(Global.CodCompra100+' - Compras');
        EdTipomov.Items.Add(Global.CodCompraMatConsumo+' - Compra Mat.Uso e Consumo');
        EdTipomov.text:=Global.CodSaidaAlmox+';'+Global.CodCompra100+';'+Global.CodCompraMatConsumo;
      end;
//      EdTipomov.enabled:=false;
// 20.04.10
      EdNroobra.Enabled:=Global.Topicos[1204];
    end;
    if (tp=16)  then begin
       EdTipocad.enabled:=false;
       EdTipomov.enabled:=false;
       EdNroobra.Enabled:=Global.Topicos[1204];
    end;
    if (tp=17) or (tp=18)  then begin
       EdTipocad.enabled:=false;
       EdTipomov.enabled:=false;
       EdNroobra.Enabled:=false;
//       if tp=17 then begin
         EdDatai.Enabled:=false;
         EdDataf.Enabled:=false;
//       end;
       EdDocumento.enabled:=false;
    end;
    largura:=80;
    SaiOk:=False;
    FRelEstoque.ShowModal;
    Result:=SaiOk;
  end;
end;


procedure FRelEstoque_Extrato;         // 2
//////////////////////////////////////////////////////////////////
var unidade,produto,op,sqlinicio,nome,sqltermino,grade,sqlcor,sqltamanho:string;
    saldoanterior,saldo,pentradas,psaidas,psemmov,tentradas,tsaidas,tsemmov,
    pentradaspec,psaidaspec,psemmovpec,tentradaspec,tsaidaspec,tsemmovpec,saldoanteriorpecas,saldopecas:currency;
    margem,x:integer;
    QBusca:TSqlquery;

    function Busca(Tipo,codigo:string;tipomov:string=''):string;
    begin

      if pos(tipomov,Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.CodTransfEnt+';'+Global.CodTransfSai)>0 then begin
        result:='';
        if pos(tipomov,Global.CodTransfEntrada+';'+Global.CodTransfEnt)>0 then begin
          QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
          if not QBusca.eof then
            result:=QBusca.fieldbyname('forn_nome').AsString
        end else begin
          QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
          if not QBusca.eof then
            result:=QBusca.fieldbyname('clie_nome').AsString
        end;

      end else if tipo='C' then begin
        QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('clie_nome').AsString
        else
          result:=''
      end else if tipo='F' then begin
        QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('forn_nome').AsString
        else
          result:=''
      end else begin
        QBusca:=sqltoquery('select unid_nome,unid_reduzido from unidades where unid_codigo='+stringtosql(formatfloat('000',strtocurr(codigo))));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('unid_reduzido').AsString
        else
          result:=''
      end;
      QBusca.Free;
    end;


begin

  with FRelEstoque do begin
    if not FRelEstoque_Execute(2) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);
    if EdEsto_codigo.AsInteger>0 then
       sqlinicio:=' and move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
    else
       sqlinicio:=' and move_datamvto>='+Datetosql(EdDatai.AsDate);
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(EdDatai.AsDate);

    if EdDAtaf.isempty then
       sqltermino:=''
    else
       sqltermino:=' and move_datamvto<='+Datetosql(EdDataf.Asdate);
    if EdDAtai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;
// 08.09.06
    if EdCodcor.isempty then
      sqlcor:=''
    else
      sqlcor:='and move_core_codigo='+Edcodcor.assql;
    if EdCodtamanho.isempty then
      sqltamanho:=''
    else
      sqltamanho:='and move_tama_codigo='+Edcodtamanho.assql;
{
    Q:=sqltoquery('select mestre.*,detalhe.*,esto.esto_descricao,'+
                     'gr.grup_descricao,sg.sugr_descricao,fa.fami_descricao'+
                     ' from movesto mestre,movestoque detalhe,estoque esto,grupos gr,subgrupos sg,familias fa'+
                     ' where mestre.'+FGeral.RelEstoque('moes_status')+
                     ' and mestre.moes_unid_codigo='+stringtosql(unidade)+
                     sqlinicio+
                     ' and mestre.moes_datamvto<='+Datetosql(EdDataf.Asdate)+
                     sqltipomovto+
                     sqldocumento+
                     ' and mestre.moes_transacao=detalhe.move_transacao'+
                     ' and mestre.moes_numerodoc=detalhe.move_numerodoc'+
                     ' and detalhe.'+FGeral.RelEstoque('move_status')+
//                     ' and ( ( (clie_codigo=move_tipo_codigo) and (move_tipocad=''C'') ) or ( (forn_codigo=move_tipo_codigo) and (move_tipocad=''F'') ) )'+
//                     ' and ( ( (move_tipo_codigo=(select * from clientes where ) and (move_tipocad=''C'') ) or ( (forn_codigo=move_tipo_codigo) and (move_tipocad=''F'') ) )'+
                     ' and gr.grup_codigo=move_grup_codigo '+
                     ' and sg.sugr_codigo=move_sugr_codigo '+
                     ' and fa.fami_codigo=move_fami_codigo '+
                     ' and esto_codigo=detalhe.move_esto_codigo  '+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     ' order by detalhe.move_esto_codigo,mestre.moes_datamvto' );
}
//{   esta select parece estar meio 'cagada'---31.03.05 - no notebook nao roda nem pau...
/////////////////////////////////////////////////////////////////////////////////////////////////////
{
    Q:=sqltoquery('select mestre.*,detalhe.*,esto_descricao,'+
                     'grup_descricao,sugr_descricao,fami_descricao'+
                     ' from movesto mestre,movestoque detalhe'+
                     ' left join grupos on (grup_codigo=move_grup_codigo) '+
                     ' left join subgrupos on (sugr_codigo=move_sugr_codigo) '+
                     ' left join familias on (fami_codigo=move_fami_codigo) '+
//                     ' left join estoque on (esto_codigo=move_esto_codigo) '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' where mestre.'+FGeral.RelEstoque('moes_status')+
                     ' and mestre.moes_unid_codigo='+stringtosql(unidade)+
                     sqlinicio+
                     ' and mestre.moes_datamvto<='+Datetosql(EdDataf.Asdate)+
                     sqltipomovto+
                     sqldocumento+
                     sqlcliente+
                     ' and mestre.moes_transacao=detalhe.move_transacao'+
/////////////////////                     ' and mestre.moes_tipomov=detalhe.move_tipomov'+
                     ' and mestre.moes_unid_codigo=detalhe.move_unid_codigo'+
                     ' and mestre.moes_numerodoc=detalhe.move_numerodoc'+
//                     ' and mestre.moes_datacont=detalhe.move_datacont'+
                     ' and detalhe.'+FGeral.RelEstoque('move_status')+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
//                     ' order by detalhe.move_esto_codigo,mestre.moes_datamvto' );
                     ' order by detalhe.move_esto_codigo,detalhe.move_datamvto,detalhe.move_numerodoc' );
//                     ' order by detalhe.move_datamvto,detalhe.move_esto_codigo' );
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// aqui em 02.12.05
    Q:=sqltoquery('select * from movestoque '+
                     ' left join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
// 07.08.06 - explosão de materia prima
//                     ' left join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc) '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
//                     ' and extract( month from move_datamvto )='+inttostr(Datetomes(texttodate('01'+EdMesano.text)))+
//                     ' and extract( year from move_datamvto )='+inttostr(Datetoano(texttodate('01'+EdMesano.text),true))+
                     sqlinicio+
                     sqltermino+
                     sqldocumento+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     sqltipomovto+  // 15.02.06
                     sqlcor+  // 08.09.06
                     sqltamanho+  // 12.09.06
                     ' and '+FGeral.RelEstoque('moes_status')+
                     ' order by move_esto_codigo,move_datamvto,move_numerodoc' );


//////////////////////////////////////////////////////////////////////////////////
      unidade:=copy(FRelEstoque.EdUNid_codigo.Text,1,3);
      FTextRel.Init(60);
      FTextRel.MargemEsquerda:=3;
      margem:=FTextRel.MargemEsquerda;
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emissão:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
      FTextRel.AddTitulo(FGeral.Centra('Extrato de Movimentação por Produto',largura),false,false,false);
      FTextRel.AddTitulo(space(margem-1)+replicate('-',largura+03),false,false,false);
      FTextRel.AddTitulo(space(margem-1)+'Unidade : '+Unidade+' - '+FUnidades.Getnome(Unidade),false,false,false);
      FTextRel.AddTitulo(space(margem-1)+'Periodo : '+formatdatetime('dd/mm/yy',EdDatai.AsDate)+' a '+formatdatetime('dd/mm/yy',EdDataf.AsDate)+Montatit(EdGrup_codigo.AsInteger,EdSugr_codigo.AsInteger,EdFami_codigo.AsInteger),false,false,false);
      FTextRel.AddTitulo(space(margem-1)+replicate('-',largura+04),false,false,false);
      FTextRel.AddColuna( margem, 08,'Data'     ,''          ,'D','1',false,false);
      FTextRel.AddColuna( 12, 08,'Docum.'       ,''          ,'N','1',False,false);
      FTextRel.AddColuna( 22, 02,'TM'           ,''          ,'C','1',False,false);
      FTextRel.AddColuna( 26, 11,'Entradas'     ,f_qtdestoque,'N','3',True ,false);
      FTextRel.AddColuna( 36, 11,'Saidas'       ,f_qtdestoque,'N','3',True,false);
      FTextRel.AddColuna( 50, 11,'Sem Movim'   ,f_qtdestoque,'N','3',True,false);
      FTextRel.AddColuna(060, 08,'Ent Pec'      ,'#####0.0','N','3',True ,false);
      FTextRel.AddColuna(070, 08,'Sai Pec'      ,'#####0.0','N','3',True,false);
      FTextRel.AddColuna(080, 08,'Sem Mov'      ,'#####0.0','N','3',True,false);
      x:=80;
      if Trim(EdEsto_codigo.text)<>'' then begin
        FTextRel.AddColuna( x+10, 08   ,'Saldo'       ,'#####0.0'    ,'N','3',False,false);
//        FTextRel.AddColuna( x+10+10, 06,'Clifor'       ,''    ,'N','1',False,false);
        FTextRel.AddColuna( x+10+10, 06,'Peças'       ,'#####0.0'    ,'N','3',False,false);
        FTextRel.AddColuna( x+10+10+08, 15,'Nome'         ,''    ,'C','1',False,false);
//        FTextRel.AddColuna(108, 13,'Grade'         ,''    ,'C','1',False,false);
//        FTextRel.AddColuna(123, 12,'Transação'    ,''    ,'C','1',False,false);
        FTextRel.AddColuna(x+10+10+08+16, 12,'Transação'    ,''    ,'C','1',False,false);
      end else begin
        FTextRel.AddColuna(x+10, 06,'Clifor'       ,''    ,'N','1',False,false);
        FTextRel.AddColuna(x+10+08, 20,'Nome'         ,''    ,'C','1',False,false);
//        FTextRel.AddColuna(095, 13,'Grade'         ,''    ,'C','1',False,false);
//        FTextRel.AddColuna(110, 12,'Transação'    ,''    ,'C','1',False,false);
        FTextRel.AddColuna(x+10+08+21, 12,'Transação'    ,''    ,'C','1',False,false);
      end;

      tentradas:=0;tsaidas:=0;tsemmov:=0;
      tentradaspec:=0;tsaidaspec:=0;tsemmovpec:=0;

      while not Q.eof do begin

        produto:=Q.FieldByName('move_esto_codigo').AsString;
        if Trim(EdEsto_codigo.text)<>'' then begin
          saldoanterior:=FGeral.EstoqueAnterior(produto,unidade,EdDatai.AsDate,saldoanteriorpecas,Q.FieldByName('move_core_codigo').AsInteger,
                         Q.FieldByName('move_tama_codigo').AsInteger,Q.FieldByName('move_copa_codigo').AsInteger);
        end;

        if (Datetodia(EdDatai.AsDate)>1) and (Trim(EdEsto_codigo.text)<>'') then begin
          while (not Q.eof) and (produto=Q.FieldByName('move_esto_codigo').AsString) and (Q.FieldByName('move_datamvto').AsDateTime<EdDatai.Asdate)
            do begin
            op:=FGeral.GetEntSaiTipoMovto(Q.FieldByName('move_tipomov').AsString);
            if op='+' then begin
              saldoanterior:=saldoanterior+Q.FieldByName('move_qtde').AsFloat;
              saldoanteriorpecas:=saldoanteriorpecas+Q.FieldByName('move_pecas').AsFloat;
            end else if op='-' then begin
              saldoanterior:=saldoanterior-Q.FieldByName('move_qtde').AsFloat;
              saldoanteriorpecas:=saldoanteriorpecas-Q.FieldByName('move_pecas').AsFloat;
            end else if op='B' then begin  // 13.02.06
              saldoanterior:=Q.FieldByName('move_estoque').AsFloat;
              saldoanteriorpecas:=Q.FieldByName('move_estoquepc').AsFloat;
            end;
            Q.Next;
          end;
        end;


        if not Q.Eof then begin    // para não imprimir em branco no final
          FTextRel.SaltaLinha(1);
          grade:=' '+strspace(FCores.Getdescricao(Q.FieldByName('move_core_codigo').AsInteger),07)+' '+
                 strspace(FTamanhos.Getdescricao(Q.FieldByName('move_tama_codigo').AsInteger),3)+' '+
                 strspace(FCopas.Getdescricao(Q.FieldByName('move_copa_codigo').AsInteger),1);
          if Trim(EdEsto_codigo.text)<>'' then
            FTextREl.AddLinha('Produto:'+Q.FieldByName('move_esto_codigo').AsString+' - '+
                          strspace(Q.FieldByName('esto_descricao').AsString+grade,45)+' '+'Saldo anterior:'+
                          space(08)+FGeral.Formatavalor(saldoanterior,f_qtdestoque)+
                          ' '+FGeral.Formatavalor(saldoanteriorpecas,'#####0.0')
                          ,false,false,true)
          else
            FTextREl.AddLinha('Produto:'+Q.FieldByName('move_esto_codigo').AsString+' - '+
                          strspace(Q.FieldByName('esto_descricao').AsString,50),false,false,true);
        end;

        if Trim(EdEsto_codigo.text)<>'' then begin
          saldo:=saldoanterior;
          saldopecas:=saldoanteriorpecas;
        end;
        pentradas:=0;psaidas:=0;psemmov:=0;
        pentradaspec:=0;psaidaspec:=0;psemmovpec:=0;

        while (not Q.eof) and (produto=Q.FieldByName('move_esto_codigo').AsString) do begin

//          FTextRel.SetColuna(01,Q.FieldByName('moes_datamvto').AsDateTime);
//          FTextRel.SetColuna(02,Q.FieldByName('moes_numerodoc').AsInteger);
// 11.04.06
          FTextRel.SetColuna(01,Q.FieldByName('move_datamvto').AsDateTime);
          FTextRel.SetColuna(02,Q.FieldByName('move_numerodoc').AsInteger);
          FTextRel.SetColuna(03,FGeral.GetTipoMovto(Q.FieldByName('move_tipomov').AsString,true));
          op:=FGeral.GetEntSaiTipoMovto(Q.FieldByName('move_tipomov').AsString);
          if op='+' then begin
//            FTextRel.SetColuna(04,FGeral.Formatavalor(Q.FieldByName('move_qtde').AsFloat,f_qtdestoque));
            FTextRel.SetColuna(04,Q.FieldByName('move_qtde').AsFloat);
            FTextRel.SetColuna(05,0);
            FTextRel.SetColuna(06,0);
            if Trim(EdEsto_codigo.text)<>'' then begin
              saldo:=saldo+Q.FieldByName('move_qtde').AsFloat;
              saldopecas:=saldopecas+Q.FieldByName('move_pecas').AsFloat;
            end;
            pentradas:=pentradas+Q.FieldByName('move_qtde').AsFloat;
            tentradas:=tentradas+Q.FieldByName('move_qtde').AsFloat;
          end else if op='-' then begin
            FTextRel.SetColuna(04,0);
            FTextRel.SetColuna(05,Q.FieldByName('move_qtde').AsFloat);
//            FTextRel.SetColuna(05,FGeral.Formatavalor(Q.FieldByName('move_qtde').AsFloat,f_qtdestoque));
            FTextRel.SetColuna(06,0);
            if Trim(EdEsto_codigo.text)<>'' then begin
              saldo:=saldo-Q.FieldByName('move_qtde').AsFloat;
              saldopecas:=saldopecas-Q.FieldByName('move_pecas').AsFloat;
            end;
            psaidas:=psaidas+Q.FieldByName('move_qtde').AsFloat;
            tsaidas:=tsaidas+Q.FieldByName('move_qtde').AsFloat;
          end else if op='B' then begin  // 28.11.05
            FTextRel.SetColuna(04,0);
            FTextRel.SetColuna(05,0);
            FTextRel.SetColuna(06,Q.FieldByName('move_qtde').AsFloat);
//            FTextRel.SetColuna(06,Q.FieldByName('move_estoque').AsFloat);
            psemmov:=psemmov+Q.FieldByName('move_qtde').AsFloat;
            tsemmov:=tsemmov+Q.FieldByName('move_qtde').AsFloat;
            saldo:=Q.FieldByName('move_estoque').AsFloat;
          end else begin
            FTextRel.SetColuna(04,0);
            FTextRel.SetColuna(05,0);
//            FTextRel.SetColuna(06,FGeral.Formatavalor(Q.FieldByName('move_qtde').AsFloat,f_qtdestoque));
            FTextRel.SetColuna(06,Q.FieldByName('move_qtde').AsFloat);
            psemmov:=psemmov+Q.FieldByName('move_qtde').AsFloat;
            tsemmov:=tsemmov+Q.FieldByName('move_qtde').AsFloat;
          end;
// 04.05.07 - ref. as peças
          if op='+' then begin
//            FTextRel.SetColuna(04,FGeral.Formatavalor(Q.FieldByName('move_qtde').AsFloat,f_qtdestoque));
            FTextRel.SetColuna(07,Q.FieldByName('move_pecas').AsFloat);
            FTextRel.SetColuna(08,0);
            FTextRel.SetColuna(09,0);
//            if Trim(EdEsto_codigo.text)<>'' then
//              saldo:=saldo+Q.FieldByName('move_pecas').AsFloat;
            pentradaspec:=pentradaspec+Q.FieldByName('move_pecas').AsFloat;
            tentradaspec:=tentradaspec+Q.FieldByName('move_pecas').AsFloat;
          end else if op='-' then begin
            FTextRel.SetColuna(07,0);
            FTextRel.SetColuna(08,Q.FieldByName('move_pecas').AsFloat);
//            FTextRel.SetColuna(05,FGeral.Formatavalor(Q.FieldByName('move_qtde').AsFloat,f_qtdestoque));
            FTextRel.SetColuna(09,0);
//            if Trim(EdEsto_codigo.text)<>'' then
//              saldo:=saldo-Q.FieldByName('move_pecas').AsFloat;
            psaidaspec:=psaidaspec+Q.FieldByName('move_pecas').AsFloat;
            tsaidaspec:=tsaidaspec+Q.FieldByName('move_pecas').AsFloat;
          end else if op='B' then begin
            FTextRel.SetColuna(07,0);
            FTextRel.SetColuna(08,0);
            FTextRel.SetColuna(09,Q.FieldByName('move_pecas').AsFloat);
//            FTextRel.SetColuna(06,Q.FieldByName('move_estoque').AsFloat);
            psemmovpec:=psemmovpec+Q.FieldByName('move_pecas').AsFloat;
            tsemmovpec:=tsemmovpec+Q.FieldByName('move_pecas').AsFloat;
// 05.11.07
            saldopecas:=Q.FieldByName('move_estoquepc').AsFloat;
          end else begin
            FTextRel.SetColuna(07,0);
            FTextRel.SetColuna(08,0);
//            FTextRel.SetColuna(06,FGeral.Formatavalor(Q.FieldByName('move_qtde').AsFloat,f_qtdestoque));
            FTextRel.SetColuna(09,Q.FieldByName('move_pecas').AsFloat);
            psemmovpec:=psemmovpec+Q.FieldByName('move_pecas').AsFloat;
            tsemmovpec:=tsemmovpec+Q.FieldByName('move_pecas').AsFloat;
          end;

/////////////
          nome:=Busca(Q.FieldByName('moes_tipocad').AsString,Q.FieldByName('move_tipo_codigo').AsString);
          grade:=strspace(FCores.Getdescricao(Q.FieldByName('move_core_codigo').AsInteger),07)+' '+
                 strspace(FTamanhos.Getdescricao(Q.FieldByName('move_tama_codigo').AsInteger),3)+' '+
                 strspace(FCopas.Getdescricao(Q.FieldByName('move_copa_codigo').AsInteger),1);
          if Trim(EdEsto_codigo.text)<>'' then begin
//            FTextRel.SetColuna(07,FGeral.Formatavalor(saldo,f_qtdestoque));
//acertos de estoque
// 01.04.05 - considera acertos de estoque como movimento normal
//            if pos(Q.FieldByName('move_tipomov').AsString,Global.CodAcertoEsEnt+';'+Global.codacertoessai)>0 then
//              saldo:=Q.FieldByName('move_estoque').Ascurrency;
            FTextRel.SetColuna(10,saldo);
//            FTextRel.SetColuna(11,Q.FieldByName('move_tipo_codigo').AsInteger);
// 04.10.07
            FTextRel.SetColuna(11,saldopecas);
            FTextRel.SetColuna(12,strspace(nome,15));
//            FTextRel.SetColuna(10,grade);
            FTextRel.SetColuna(13,Q.FieldByName('move_transacao').AsString);
          end else begin
            FTextRel.SetColuna(10,Q.FieldByName('move_tipo_codigo').AsInteger);
            FTextRel.SetColuna(11,strspace(nome,25));
//            FTextRel.SetColuna(09,grade);
            FTextRel.SetColuna(12,Q.FieldByName('move_transacao').AsString);
          end;

          FTextRel.SetColunas([]);
          Q.Next;
        end;

        FTExtRel.AddLinha(space(12)+'Totais'+space(3)+FGeral.Formatavalor(pentradas,f_qtdestoque)+
                          FGeral.Formatavalor(psaidas,f_qtdestoque,10)+
                          FGeral.Formatavalor(psemmov,f_qtdestoque,14)+
                          FGeral.Formatavalor(pentradaspec,'#####0.0',09)+
                          FGeral.Formatavalor(psaidaspec,'#####0.0',10)+
                          FGeral.Formatavalor(psemmovpec,'#####0.0',10)
                          ,false,false,true  );
      end;
// 13.04.05 - total geral
      FTExtRel.AddLinha(space(12)+'Totais'+space(3)+FGeral.Formatavalor(tentradas,f_qtdestoque)+
                          FGeral.Formatavalor(tsaidas,f_qtdestoque,10)+
                          FGeral.Formatavalor(tsemmov,f_qtdestoque,14)+
                          FGeral.Formatavalor(tentradaspec,'#####0.0',09)+
                          FGeral.Formatavalor(tsaidaspec,'#####0.0',10)+
                          FGeral.Formatavalor(tsemmovpec,'#####0.0',10)
                          ,false,false,true  );
      FTextRel.Video;
//    end else
//      Avisoerro('Nada encontrado para impressão');
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;

////////////////  FRelEstoque_Extrato;         // 2 - 08.09.06

end;

procedure TFRelEstoque.baplicarClick(Sender: TObject);
begin
//  if not EdUnid_codigo.Valid then exit;
  if not FRelEstoque.EdUNid_codigo.ValidEdiAll(FRelEstoque,99) then exit;
  Saiok:=true;
  close;

end;

procedure TFRelEstoque.EdGrup_codigoValidate(Sender: TObject);
begin
  if EdGrup_codigo.AsInteger>0 then
    sqlgrupo:=' and esto_grup_codigo='+EdGrup_codigo.AsSql
  else
    sqlgrupo:='';
end;

procedure TFRelEstoque.EdSugr_codigoValidate(Sender: TObject);
begin
  if EdSuGr_codigo.AsInteger>0 then
    sqlsubgrupo:=' and esto_sugr_codigo='+EdSugr_codigo.AsSql
  else
    sqlsubgrupo:='';

end;

procedure TFRelEstoque.EdFami_codigoValidate(Sender: TObject);
begin
  if EdFami_codigo.AsInteger>0 then
    sqlfamilia:=' and esto_fami_codigo='+EdFami_codigo.AsSql
  else
    sqlfamilia:='';

end;

procedure TFRelEstoque.EdEsto_codigoValidate(Sender: TObject);
begin
  if EdEsto_codigo.AsInteger>0 then begin
//    sqlproduto:=' and esto_codigo='+EdEsto_codigo.AsSql
    if (nrorel=2) or (nrorel=4) or (nrorel=6) or ( nrorel=8) or ( nrorel=10)  or (nrorel=12) or (nrorel=13)then
      sqlproduto:=' and move_esto_codigo='+EdEsto_codigo.AsSql
    else if (nrorel=5)  then
      sqlproduto:=' and saes_esto_codigo='+EdEsto_codigo.AsSql
    else
//      sqlproduto:=' and esto_codigo='+EdEsto_codigo.AsSql;
      sqlproduto:=' and esqt_esto_codigo='+EdEsto_codigo.AsSql;
  end else
    sqlproduto:='';

end;

procedure TFRelEstoque.Edunid_codigoValidate(Sender: TObject);
begin
  if FRelEstoque.EdUnid_codigo.isempty then
    FRelEstoque.EdUnid_codigo.Text:=Global.Usuario.UnidadesRelatorios;
end;

procedure TFRelEstoque.FormActivate(Sender: TObject);
begin
  FRelEstoque.EdUnid_codigo.SetFirstEd;
end;

procedure TFRelEstoque.EdTipomovValidate(Sender: TObject);
begin
  if trim(EdTipomov.Text)='' then
    sqltipomovto:=''
  else
    sqltipomovto:=' and '+FGeral.GetIn('move_tipomov',EdTipoMov.Text,'C');
end;

procedure TFRelEstoque.EdDocumentoValidate(Sender: TObject);
begin
  if trim(EdDocumento.text)<>'' then begin
    sqldocumento:=' and moes_numerodoc='+EdDocumento.AsSql;
    if (nrorel=11) or (nrorel=16) then
      sqldocumento:=' and move_numerodoc='+EdDocumento.AsSql;
  end else
    sqldocumento:='';
end;

procedure TFRelEstoque.EdCodtipoValidate(Sender: TObject);
begin
  sqlcliente:='';

  if EdCodtipo.AsInteger>0 then begin
    SetEdFavorecido.Text:=FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipoCad.text,'N');
    if EdTipocad.text='R' then
      sqlcliente:=' and moes_repr_codigo='+EdCodtipo.AsSql
    else
      sqlcliente:=' and moes_tipo_codigo='+EdCodtipo.AsSql;
    if trim(SetEdFavorecido.Text)='' then
      EdCodTipo.Invalid('Não encontrado');
    EdCodtipo.enabled:=true;
  end else begin
    SetEdFavorecido.Text:='';
    EdCodtipo.text:='';
//    EdCodtipo.enabled:=false;
  end;

end;

///////////////////////////////////////////////////////////////////////////////////////////
procedure FRelEstoque_Posicao;         // 1
///////////////////////////////////////////////////////////////////////////////////////////
var custototal,custototalb,custototalm,custototalbm,produto,sqlmovunidades,sqlprodutodet,vendatotal,
    sqlcor,sqltamanho,sqlcopa,titcortamanho,sqlqtde,sqlqtdegrade:string;
    qtde,qtdeprev,pecas,qtdeprocesso:extended;
    mes,ano,tamanho:integer;
    quergravar,gerarinventario,imprime:boolean;
    Datainicio:TDatetime;
    Qaux:TSqlquery;
    VendaProduto,CustoMedioProduto,CustoUltimoProduto,xmargem:currency;
    ListaImp:TStringList;

    procedure AtualizaLista(produto:string ; qtde,qtdeprev,estoque,pecas,estoquepc:extended ;tipomov,unid:string ; cor,tamanho,copa,xembalagem:integer);
    ////////////////////////////////////////////////////////////////////////////////////////////
    var p:integer;
    begin

/////////////////////////////////////////////////////////////////////////////////
// 19.10.09 - Movimentacao estoque em processo na grade
      if pos(Tipomov,Global.TipoEstoqueEmProcesso)>0 then begin
        for p:=0 to ListaSAldos.Count-1 do begin
          PSaldos:=Listasaldos[p];
          if Psaldos.produto=produto then begin
              if pos(Tipomov,Global.CodContagemBalancoE+';'+Global.CodContagemBalancoS)>0 then begin
                PSaldos.qtdeprocesso:=qtde;
              end else if pos(Tipomov,Global.TiposEntrada)>0 then begin
                PSaldos.qtdeprocesso:=PSaldos.qtdeprocesso+qtde;
              end else begin
                PSaldos.qtdeprocesso:=PSaldos.qtdeprocesso-qtde;
              end;
            break;
          end;
        end;
      end;
///////////////////////////////////////////////////////
      if pos(Tipomov,Global.TiposMovMovEstoque)>0 then begin
        for p:=0 to ListaSAldos.Count-1 do begin
          PSaldos:=Listasaldos[p];
            if (Psaldos.produto=produto)and (Psaldos.unidade=unid) and (PSaldos.cor=cor) and (PSaldos.tamanho=tamanho)
                and (PSaldos.copa=copa)
                then begin
  // 01.04.05 - considera acertos de estoque como movimento normal
  // 18.11.05 - novas normas para isolar digitação de balanço
  //              if pos(Tipomov,Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai)>0 then begin
  // 28.11.05 - criado tipos BE e BS para contagem de balanço
                if pos(Tipomov,Global.CodContagemBalancoE+';'+Global.CodContagemBalancoS)>0 then begin
                  PSaldos.qtde:=estoque;
                  PSaldos.qtdeprev:=estoque;
                  PSaldos.balanco:='S';
  // 03.11.07
                  PSaldos.pecas:=estoquepc;
                end else if pos(Tipomov,Global.TiposMovMovEntrada)>0 then begin
// 29.02.12 - considerando a embalagem do cadastro
//                  if Q.fieldbyname('esto_embalagem').AsInteger>=1 then begin
// 16.03.12
                  if ( PSaldos.embalagem>=1 ) and ( pos(Tipomov,Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai)=0 ) then begin
                    if (Global.Topicos[1356]) and (xembalagem>0) then begin
                      qtde:=qtde*xembalagem;
                      qtdeprev:=qtdeprev*xembalagem;
                    end else begin
                      qtde:=qtde*PSaldos.embalagem;
                      qtdeprev:=qtdeprev*PSaldos.embalagem;
                    end;
                  end;
                  PSaldos.entradas:=PSaldos.entradas+qtde;
                  PSaldos.qtde:=psaldos.qtde+qtde;
                  PSaldos.qtdeprev:=psaldos.qtdeprev+qtde;
                  PSaldos.pecas:=psaldos.pecas+pecas;
                end else begin
// 14.04.15 - Devereda
                    if (Global.Topicos[1382]) and (PSaldos.tamanho>0) then begin
                      qtde:=qtde*FTamanhos.GetComprimento(PSaldos.tamanho);
                      qtdeprev:=qtdeprev*FTamanhos.GetComprimento(PSaldos.tamanho);
                    end else begin
                      qtde:=qtde*1;
                      qtdeprev:=qtdeprev*1;
                    end;
                  PSaldos.saidas:=PSaldos.saidas+qtde;
                  PSaldos.qtde:=psaldos.qtde-qtde;
                  PSaldos.qtdeprev:=psaldos.qtdeprev-qtde;
  // 02.10.07
                  PSaldos.pecas:=psaldos.pecas-pecas;
                end;

  //              PSaldos.qtde:=psaldos.aqtde+psaldos.entradas-psaldos.saidas;
  //              PSaldos.qtdeprev:=psaldos.aqtdeprev+psaldos.entradas-psaldos.saidas;
              break;
            end;
        end;
      end;
    end;

// 25.02.14 - Metalforte
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

    // 22.03.14
    Function SomaGrade(xuni,xproduto:string):string;
    /////////////////////////////////////////////////
    var QG:Tsqlquery;
    begin
      QG:=Sqltoquery('select sum(esgr_qtde) as qtde from estgrades where esgr_status=''N'''+
                     ' and esgr_unid_codigo='+Stringtosql(xuni)+
                     ' and esgr_esto_codigo='+Stringtosql(xproduto) );
      result:=floattostr(QG.fieldbyname('qtde').AsCurrency);
      FGeral.FechaQuery(QG);
    end;



begin
///////////////////////////////////////////////////////

  with FRelEstoque do begin
    if not FRelEstoque_Execute(1) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    if EdSomagrade.isempty then
      somargrade:='N'
    else
      somargrade:=EdSomagrade.text;
// 23.08.06
    if (Global.Usuario.OutrosAcessos[3305]) and (FRelEstoque.EdEstcalculado.text='S') then begin
      quergravar:=confirma('Atualizar posição atual do estoque ?');
      gerarinventario:=false;
      if (Global.Usuario.OutrosAcessos[3308]) then
        gerarinventario:=confirma('Gerar inventário referente '+EdMesano.text+' ?');
    end else begin
      quergravar:=false;
      gerarinventario:=false;
    end;
    if trim(FRelEstoque.EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.Getin('esqt_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')
    else
      sqlunidade:='';

    if (EdUnid_codigo.text)<>'' then
//      sqlmovunidades:=' and '+FGeral.Getin('mestre.moes_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')
      sqlmovunidades:=' and '+FGeral.Getin('move_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')
    else
      sqlmovunidades:='';

    if not FRelEstoque.EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.Getin('esqt_esto_codigo',FRelEstoque.EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
// 22.03.14
    sqlqtde:='';sqlqtdegrade:='';
    if (EdDifdezero.text='S') or (EdDifdezero.IsEmpty) then begin
      sqlqtde:=' and ((esqt_qtde <> 0) or (esgr_qtde <> 0) )';
//      sqlqtdegrade:=' and esgr_qtde > 0';
    end;

    if EdEstcalculado.text='S' then begin

//      if not Arq.TSalestoque.active then
//        Arq.TSalestoque.open;
      if gerarinventario then begin
        Sistema.Beginprocess('Zerando inventário de '+EdMesano.text);
        QAux:=TSqlquery.Create(Sistema.Conexao );
        QAux.SQLConnection:=Sistema.Conexao;
        Qaux.SQL.Text:='Update salestoque set saes_status=''C'' where '+FGeral.Getin('saes_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')+
                               ' and saes_mesano='+stringtosql(FGeral.Anomesinvertido(EdMesano.text))+
                               ' and saes_status=''N''';
        QAux.ExecSQL();
        FGeral.FechaQuery( QAux );
      end;
      Sistema.Beginprocess('Armazenando saldo do mes anterior');
//      if EdSomaGrade.text='S' then
//        QSaldoanterior:=sqltoquery('select * from estoqueqtde'+
//                     ' inner join estoque on (esto_codigo=esqt_esto_codigo) '+
//                     ' where esqt_status=''N'''+
//                      sqlunidade+
//                      sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto)
//      else
        QSaldoanterior:=sqltoquery('select * from estoqueqtde'+
                     ' inner join estoque on (esto_codigo=esqt_esto_codigo) '+
// 08.09.06
                     ' left  join estgrades on (esgr_esto_codigo=esqt_esto_codigo and esgr_status=''N'' and esgr_unid_codigo=esqt_unid_codigo)'+
                     ' where esqt_status=''N'''+
                      sqlunidade+
                      sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto);

      if EdMesano.isempty then
        EdMesano.text:=strzero(datetomes(sistema.hoje),2)+strzero(datetoano(sistema.hoje,true),4);
      mes:=strtoint(copy(edmesano.text,1,2));
      ano:=strtoint(copy(edmesano.text,3,4));
      if mes=1 then begin
        mes:=12;
        dec(ano);
      end else
        dec(mes);
      mesanoant:=inttostr(ano)+strzero(mes,2);
      ListaSaldos:=Tlist.create;
      Salestoque:=TSQLQuery.Create(Application.MainForm);
//      Salestoque.NoMetadata:=True;
      Salestoque.SQLConnection:=Sistema.Conexao;

      Sistema.Beginprocess('Armazenando saldo do mes anterior ');
      while not QSaldoanterior.eof do begin
        produto:=QSaldoanterior.fieldbyname('esqt_esto_codigo').asstring;
//        Sistema.Beginprocess('Armazenando saldo do mes anterior '+produto);

//        FGeral.PosicaoEstoqueAnterior(produto,QSaldoanterior.fieldbyname('esqt_tama_codigo').asinteger,QSaldoanterior.fieldbyname('esqt_core_codigo').asinteger,
//              FRelEstoque.EdUNid_codigo.text,texttodate('01'+EdMesano.text),SAlestoque);
// 25.10.05 - cleuziane chu....quer o mesmo produto para diversar unidades
//        FGeral.PosicaoEstoqueAnterior(produto,QSaldoanterior.fieldbyname('esqt_tama_codigo').asinteger,QSaldoanterior.fieldbyname('esqt_core_codigo').asinteger,
//              0,QSaldoanterior.fieldbyname('esqt_unid_codigo').asstring,texttodate('01'+EdMesano.text),SAlestoque);
// 08.09.06
//        if EdSomagrade.text='S' then
//          FGeral.PosicaoEstoqueAnterior(produto,0,0,
//              0,QSaldoanterior.fieldbyname('esqt_unid_codigo').asstring,texttodate('01'+EdMesano.text),SAlestoque)
//        else
          FGeral.PosicaoEstoqueAnterior(produto,QSaldoanterior.fieldbyname('esgr_tama_codigo').asinteger,QSaldoanterior.fieldbyname('esgr_core_codigo').asinteger,
              QSaldoanterior.fieldbyname('esgr_copa_codigo').asinteger,QSaldoanterior.fieldbyname('esqt_unid_codigo').asstring,texttodate('01'+EdMesano.text),SAlestoque);
        New(PSaldos);
        PSaldos.produto:=produto;
        PSaldos.unidade:=QSaldoanterior.fieldbyname('esqt_unid_codigo').asstring;
        PSaldos.embalagem:=QSaldoanterior.fieldbyname('esto_embalagem').asinteger;
//        if TSalEstoque.fieldbyname('saes_mesano').asstring=mesanoant then begin
        if not SalEstoque.eof then begin
          PSaldos.aqtde:=SalEstoque.fieldbyname('saes_qtde').asfloat;
          PSaldos.aqtdeprev:=SalEstoque.fieldbyname('saes_qtdeprev').asfloat;
// 02.10.07
          PSaldos.apecas:=SalEstoque.fieldbyname('saes_pecas').asfloat;
// 19.10.09
          if cQtdeprocesso='S' then
            PSaldos.aqtdeprocesso:=SalEstoque.fieldbyname('saes_qtdeprocesso').asfloat
          else
            PSaldos.aqtdeprocesso:=0;
          Salestoque.close;
        end else begin
          PSaldos.aqtde:=0;
          PSaldos.aqtdeprev:=0;
          PSaldos.apecas:=0;
          PSaldos.aqtdeprocesso:=0;
        end;
        PSaldos.qtde:=0;
        PSaldos.qtdeprev:=0;
        PSaldos.entradas:=0;
        PSaldos.saidas:=0;
        PSaldos.pecas:=0;
        PSaldos.qtdeprocesso:=0;
        PSaldos.custo:=QSaldoanterior.fieldbyname('esqt_custo').ascurrency;
        PSaldos.custoger:=QSaldoanterior.fieldbyname('esqt_custoger').ascurrency;
        PSaldos.customedio:=QSaldoanterior.fieldbyname('esqt_customedio').ascurrency;
        PSaldos.customeger:=QSaldoanterior.fieldbyname('esqt_customeger').ascurrency;
        PSaldos.balanco:='N';
        if EdSomagrade.text='S' then begin
          PSaldos.cor:=0;
          Psaldos.tamanho:=0;
          PSaldos.copa:=0;
        end else begin
          PSaldos.cor:=QSaldoanterior.fieldbyname('esgr_core_codigo').asinteger;
          Psaldos.tamanho:=QSaldoanterior.fieldbyname('esgr_tama_codigo').asinteger;
          PSaldos.copa:=QSaldoanterior.fieldbyname('esgr_copa_codigo').asinteger;
        end;
        ListaSaldos.Add(PSaldos);
        QSaldoanterior.next;
      end;
      Sistema.Beginprocess('Gerando movimento');
      if EdEsto_codigo.isempty then begin
        sqlproduto:='';
        sqlprodutodet:='';
      end else begin
        sqlproduto:=' and esto_codigo='+EdEsto_codigo.assql;
// 01.04.05
        sqlprodutodet:=' and move_esto_codigo='+EdEsto_codigo.assql;
      end;
      datainicio:=(DatetoPrimeirodiames(EdDataf.asdate));
      if not EdMesano.isempty then
        datainicio:= DatetoUltimodiames( texttodate('01'+EdMesano.text) ) + 1;
///////////////////////////////////////////////////////////////////////
{
      QMov:=sqltoquery('select mestre.*,detalhe.*,esto_descricao'+
                       ' from movesto mestre,movestoque detalhe'+
                       ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                       ' where mestre.'+FGeral.RelEstoque('moes_status')+
                       sqlmovunidades+
//                       ' and detalhe.move_datamvto>='+Datetosql(texttodate('01'+EdMesano.text))+
// 13.04.05
//                       ' and detalhe.move_datamvto>='+Datetosql(DatetoPrimeirodiames(EdDataf.asdate))+
// 06.07.05
                       ' and detalhe.move_datamvto>='+Datetosql(Datainicio)+
// 05.04.05
                       ' and detalhe.move_datamvto<='+EdDataf.assql+
//                       ' and mestre.moes_datamvto<='+Datetosql(DatetoUltimodiames(texttodate('01'+EdMesano.text)))+
// 25.02.05
                       ' and mestre.moes_datamvto<='+EdDataf.assql+
// 25.04.05
                       ' and mestre.moes_datamvto>='+Datetosql(Datainicio)+
                       ' and mestre.moes_transacao=detalhe.move_transacao'+
//                       ' and mestre.moes_tipomov=detalhe.move_tipomov'+
                       ' and mestre.moes_numerodoc=detalhe.move_numerodoc'+
                       ' and mestre.moes_datamvto=detalhe.move_datamvto'+
                       ' and mestre.moes_tipo_codigo=detalhe.move_tipo_codigo'+
                       ' and mestre.moes_tipocad=detalhe.move_tipocad'+
                       ' and detalhe.'+FGeral.RelEstoque('move_status')+
                       sqlprodutodet+
                        sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                       ' order by detalhe.move_esto_codigo,detalhe.move_datamvto,detalhe.move_numerodoc' );
}
///////////////////////////////////////////////////////////////////////
// 20.11.09
    sqlcor:='';
    if EdCodcor.AsInteger>0 then
      sqlcor:=' and move_core_codigo='+EdCodcor.AsSql;
    sqltamanho:='';
    if EdCodtamanho.AsInteger>0 then
      sqltamanho:=' and Move_tama_codigo='+EdCodtamanho.AsSql;

// 16.11.05
      QMov:=sqltoquery('select *,esto_descricao from movestoque '+
//                       ' left join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
// 27.10.09 - transacoes 'SA' estavam 'enuplicando' no movesto movimentando errado
                       ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                       ' where '+FGeral.RelEstoque('move_status')+
                       sqlmovunidades+
                       ' and move_datamvto>='+Datetosql(Datainicio)+
                       ' and move_datamvto<='+EdDataf.assql+
                       sqlprodutodet+sqlcor+sqltamanho+
                       sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
//                      ' order by move_esto_codigo,move_datamvto,move_numerodoc' );
//                    ' order by move_esto_codigo,move_datamvto,move_operacao' );
// 28.11.05
                      ' order by move_esto_codigo,move_datamvto,move_tipomov' );

///////////////////////////////////////////////////////////////////////

      Sistema.Beginprocess('Percorrendo movimento');
      while not QMov.eof do begin
//        Sistema.Beginprocess('Percorrendo movimento '+QMov.fieldbyname('moes_dataemissao').asstring);
//        Sistema.Beginprocess('Percorrendo movimento '+QMov.fieldbyname('move_datamvto').asstring);
        produto:=QMov.fieldbyname('move_esto_codigo').asstring;
  // ver como sera o uso das duas quantidades em estoque
// 05.09.12
        if Global.Topicos[1356] then
          AtualizaLista(produto,QMov.fieldbyname('move_qtde').asfloat,
                      QMov.fieldbyname('move_qtde').asfloat,QMov.fieldbyname('move_estoque').ascurrency,QMov.fieldbyname('move_pecas').ascurrency,QMov.fieldbyname('move_estoquepc').ascurrency,
                      QMov.fieldbyname('move_tipomov').asstring,QMov.fieldbyname('move_unid_codigo').asstring,
                      QMov.fieldbyname('move_core_codigo').asinteger,QMov.fieldbyname('move_tama_codigo').asinteger,
                      QMov.fieldbyname('move_copa_codigo').asinteger,QMov.fieldbyname('move_embalagem').asinteger)
        else
          AtualizaLista(produto,QMov.fieldbyname('move_qtde').asfloat,
                      QMov.fieldbyname('move_qtde').asfloat,QMov.fieldbyname('move_estoque').ascurrency,QMov.fieldbyname('move_pecas').ascurrency,QMov.fieldbyname('move_estoquepc').ascurrency,
                      QMov.fieldbyname('move_tipomov').asstring,QMov.fieldbyname('move_unid_codigo').asstring,
                      QMov.fieldbyname('move_core_codigo').asinteger,QMov.fieldbyname('move_tama_codigo').asinteger,
                      QMov.fieldbyname('move_copa_codigo').asinteger,1);
        QMov.Next;
      end;

      Sistema.endprocess('');
    end;

    Sistema.beginprocess('Lendo codigos do estoque');
    sqlcor:='';
    titcortamanho:='';
    if EdCodcor.AsInteger>0 then begin
      sqlcor:=' and core_codigo='+EdCodcor.AsSql;
      titcortamanho:=' Cor '+FCores.GetDescricao(EdCodcor.AsInteger)+' codigo '+EdCodcor.AsSql;
    end;
    sqltamanho:='';
    if EdCodtamanho.AsInteger>0 then begin
      sqltamanho:=' and tama_codigo='+EdCodtamanho.AsSql;
      titcortamanho:=titcortamanho+' Tamanho '+' '+FTamanhos.GetDescricao(EdCodtamanho.AsInteger)+' codigo '+EdCodtamanho.AsSql;
    end;
    if somargrade='N' then
      Q:=sqltoquery('select * from estoqueqtde'+
                     ' inner join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' left  join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' left  join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
//                     ' left  join estgrades on (esgr_esto_codigo=esqt_esto_codigo and esgr_status=''N'' and esgr_unid_codigo=esqt_unid_codigo)'+
                     ' left  join estgrades on (esgr_esto_codigo=esqt_esto_codigo and esgr_status=esqt_status and esgr_unid_codigo=esqt_unid_codigo)'+
                     ' left  join familias on (fami_codigo=esto_fami_codigo) '+
                     ' left  join tamanhos on (tama_codigo=esgr_tama_codigo) '+
                     ' left  join cores    on (core_codigo=esgr_core_codigo) '+
                     ' left  join copas    on (copa_codigo=esgr_copa_codigo) '+
                     ' where esqt_status=''N'''+
// 05.02.14
//                     ' and esgr_status=''N'''+
// 25.02.14 - assim 'phode'  os itens cujo estoque nao tem grade informada....
                     ' and esto_emlinha=''S'''+
                     sqlunidade+sqlcor+sqltamanho+sqlqtde+sqlqtdegrade+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     ' order by esqt_unid_codigo,esqt_esto_codigo' )
    else begin
// 07.04.14
      if (EdDifdezero.text='S') or (EdDifdezero.IsEmpty) then
        sqlqtdegrade:=' and esgr_qtde<>0'
      else
        sqlqtdegrade:='';
//////////////////////////////////
              {
      Q:=sqltoquery('select * from estoqueqtde'+
                     ' inner join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' inner join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' inner join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
                     ' inner join familias on (fami_codigo=esto_fami_codigo) '+
                     ' where esqt_status=''N'''+
                     sqlunidade+
                     ' and esto_emlinha=''S'''+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+sqlqtdegrade+
                     ' order by esqt_unid_codigo,esqt_esto_codigo' );
                     }
//////////////////////////////////
//////////////////////////////////
      Q:=sqltoquery('select * from estgrades'+
                     ' inner join estoque on (esto_codigo=esgr_esto_codigo) '+
                     ' inner join estoqueqtde on (esqt_esto_codigo=esgr_esto_codigo and esqt_unid_codigo=esgr_unid_codigo ) '+
                     ' inner join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' inner join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
                     ' inner join familias on (fami_codigo=esto_fami_codigo) '+
                     ' where esgr_status=''N'''+
                     ' and esqt_status=''N'''+
                     sqlunidade+
                     ' and esto_emlinha=''S'''+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+sqlqtdegrade+
                     ' order by esqt_unid_codigo,esqt_esto_codigo' );
//////////////////////////////////

    end;
    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      FRel.Init('PosicaoEstoque');
      FRel.AddTit('Posição de Estoque');
      FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text)+titcortamanho);
      if EdEstcalculado.text='S' then begin
        FRel.AddTit(FGeral.TituloRelUnidade('Recálculo de '+FRelEstoque.EdMesano.Text)+' até '+formatdatetime('dd/mm/yy',FRelEstoque.EdDataf.asdate));
      end;
      FRel.AddCol( 45,1,'C','' ,''              ,'Uni'         ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Grupo'           ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Grupo'     ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Localização'     ,''         ,'',false);
      if Global.Topicos[1209] then begin
// 14.10.13 - Metalforte
        FRel.AddCol( 90,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
        FRel.AddCol( 90,1,'C','' ,''              ,'Referencia'          ,''         ,'',false)
      end else
        FRel.AddCol( 90,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(200,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
      FRel.AddCol( 50,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);

      if somargrade='N' then begin
        FRel.AddCol( 60,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
        FRel.AddCol( 90,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
//        FRel.AddCol( 40,1,'C','' ,''              ,'Copa'             ,''         ,'',False);
      end;

      FRel.AddCol( 70,3,'N','+' ,f_qtdestoque              ,'Qtde '           ,''         ,'',false);
// 16.04.15 - Devereda
      if Global.Topicos[1382] then
        FRel.AddCol( 70,3,'N','+' ,f_qtdestoque              ,'Qtde Emb.'           ,''         ,'',false);
// 14.10.08 - caso acerto for por referencia a digitação...
      if Global.Topicos[1206] then begin
        FRel.AddCol( 70,3,'N','+' ,'######'                 ,'Barras'           ,''         ,'',false);
        FRel.AddCol( 70,3,'N','+' ,f_qtdestoque              ,'Peso'           ,''         ,'',false);
      end;
      FRel.AddCol( 70,3,'N','+' ,f_qtdestoque              ,'Peças '           ,''         ,'',false);
      if cQtdeprocesso='S' then
        FRel.AddCol( 70,3,'N','+' ,f_qtdestoque              ,'Em Processo'           ,''         ,'',false);
      if EdEstcalculado.text='S' then begin
        FRel.AddCol( 70,3,'N','+' ,f_qtdestoque            ,'Qtde Calc.'           ,''         ,'',false);
        FRel.AddCol( 70,3,'N','+' ,f_qtdestoque            ,'Peças Calc.'           ,''         ,'',false);
      end;
      if Global.Usuario.OutrosAcessos[0049] then begin
        if somargrade='N' then begin
          FRel.AddCol( 70,3,'N','' ,''              ,'Último Custo'           ,''         ,'',false);
          FRel.AddCol( 70,3,'N','' ,''              ,'Custo Médio'           ,''         ,'',false);
          FRel.AddCol( 70,3,'N','' ,''              ,'Preço Venda'           ,''         ,'',false);
        end;
        FRel.AddCol( 80,3,'N','+' ,''              ,'Total Custo'           ,''         ,'',false);
        FRel.AddCol( 80,3,'N','+' ,''              ,'Total Médio'           ,''         ,'',false);
        FRel.AddCol( 80,3,'N','+' ,''              ,'Total Venda'           ,''         ,'',false);
      end;
      if Global.Usuario.OutrosAcessos[0010] then begin
        FRel.AddCol( 70,3,'N','+' ,f_qtdestoque              ,'Qtde Prevista'       ,''         ,'',false);
        if EdEstcalculado.text='S' then
          FRel.AddCol( 70,3,'N','+' ,f_qtdestoque           ,'Qtde Prev. Calc.'           ,''         ,'',false);
        if Global.Usuario.OutrosAcessos[0049] then begin
          if somargrade='N' then begin
            FRel.AddCol( 80,3,'N','' ,''              ,'Último Previsto'           ,''         ,'',false);
            FRel.AddCol( 80,3,'N','' ,''              ,'Médio Previsto'           ,''         ,'',false);
          end;
          FRel.AddCol( 80,3,'N','+' ,''              ,'Total Último Prev.'           ,''         ,'',false);
          FRel.AddCol( 80,3,'N','+' ,''              ,'Total Médio prev.'           ,''         ,'',false);
        end;
      end;

      Sistema.beginprocess('Gerando relatório');
      ListaImp:=TStringList.Create;

      while not Q.eof do begin
// 09.05.14
      if somargrade='N' then
        imprime:= LISTAIMP.INDEXOF( Q.FieldByName('esqt_unid_codigo').AsString+
                               Q.fieldbyname('esgr_esto_codigo').asstring+
                               Q.fieldbyname('esgr_tama_codigo').asstring+
                               Q.fieldbyname('esgr_core_codigo').asstring )=-1
      else
        imprime:= LISTAIMP.INDEXOF( Q.FieldByName('esqt_unid_codigo').AsString+
                               Q.fieldbyname('esqt_esto_codigo').asstring+
                               Q.fieldbyname('esgr_tama_codigo').asstring+
                               Q.fieldbyname('esgr_core_codigo').asstring )=-1;

      IF  Imprime then begin
        FRel.AddCel(Q.FieldByName('esqt_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_grup_codigo').AsString);
        FRel.AddCel(Q.FieldByName('grup_descricao').AsString);
// 29.02.08
        FRel.AddCel(Q.FieldByName('esqt_localiza').AsString);
// 14.10.08 - caso acerto for por referencia a digitação...
        if Global.Topicos[1209] then begin
// 14.10.13 - Metalforte
          FRel.AddCel(Q.FieldByName('esqt_esto_codigo').AsString);
          FRel.AddCel(Q.FieldByName('esto_referencia').AsString);
        end else
          FRel.AddCel(Q.FieldByName('esqt_esto_codigo').AsString);
//        if somargrade='N' then begin
          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
          FRel.AddCel(Q.FieldByName('esto_unidade').AsString);
// 25.03.13 - vivan
          vendaproduto:=(FEstoque.GetPreco(Q.fieldbyname('esqt_esto_codigo').asstring,copy(EdUnid_codigo.text,1,3)));
          customedioproduto:=FEstoque.GetCusto(Q.fieldbyname('esqt_esto_codigo').asstring,copy(EdUnid_codigo.text,1,3),'medio');
          custoultimoproduto:=FEstoque.GetCusto(Q.fieldbyname('esqt_esto_codigo').asstring,copy(EdUnid_codigo.text,1,3),'custo');
//////////////
//        end else begin
//          FRel.AddCel(FEstoque.GetDescricao(Q.FieldByName('esqt_esto_codigo').AsString));
//          FRel.AddCel(Arq.Testoque.FieldByName('esto_unidade').AsString);
//        end;

        if somargrade='N' then begin
//        FRel.AddCel(Q.FieldByName('esqt_tama_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('tama_descricao').AsString);
//        FRel.AddCel(Q.FieldByName('esqt_core_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('core_descricao').AsString);
//          FRel.AddCel(Q.FieldByName('copa_descricao').AsString);
        end;

// 17.04.08
        if somargrade='N' then begin
          if Q.fieldbyname('esgr_esto_codigo').asstring<>'' then begin
            FRel.AddCel(Q.FieldByName('tama_descricao').AsString);
            FRel.AddCel(Q.FieldByName('core_descricao').AsString);
          end else begin
            FRel.AddCel('');
            FRel.AddCel('');
          end;
        end;
        if somargrade='N' then begin
//          if Q.fieldbyname('esto_grad_codigo').asinteger>0 then
// 17.04.08
          if Q.fieldbyname('esgr_esto_codigo').asstring<>'' then begin
            FRel.AddCel(Q.FieldByName('esgr_qtde').AsString);
            if Global.Topicos[1382] then
              FRel.AddCel( floattostr(Q.FieldByName('esgr_qtde').AsCurrency/Q.FieldByName('tama_comprimento').AsCurrency));
            if (Global.Topicos[1206]) then begin
              if (Q.FieldByName('tama_comprimento').AsFloat>0) then
                FRel.AddCel( floattostr(Q.FieldByName('esgr_qtde').AsInteger/(Q.FieldByName('tama_comprimento').AsFloat/1000)) )
              else
                FRel.AddCel('');
              if (Q.FieldByName('tama_comprimento').AsFloat>0) then
//                FRel.AddCel( floattostr(Q.FieldByName('esgr_qtde').AsInteger/(Q.FieldByName('tama_comprimento').AsFloat/1000) * Q.FieldByName('esto_peso').AsFloat) )
// 09.10.09 - Robson - peso pelos metrs ( qtde ) e nao pelas barras
                FRel.AddCel( floattostr(Q.FieldByName('esgr_qtde').AsInteger * Q.FieldByName('esto_peso').AsFloat) )
              else
                FRel.AddCel('');
            end;
            FRel.AddCel(Q.FieldByName('esgr_pecas').AsString);
          end else begin
            FRel.AddCel(Q.FieldByName('esqt_qtde').AsString);
// 16.04.15 - Devereda
            if Global.Topicos[1382] then
              FRel.AddCel( floattostr(Q.FieldByName('esqt_qtde').AsCurrency/Q.FieldByName('esto_embalagem').AsCurrency));
            if Global.Topicos[1206] then begin
              FRel.AddCel('');
              FRel.AddCel('');
            end;
            FRel.AddCel(Q.FieldByName('esqt_pecas').AsString);
          end;
          if cQtdeprocesso='S' then
            FRel.AddCel(floattostr(qtdeprocesso));
        end else begin
//        FRel.AddCel(Q.FieldByName('esqt_qtde').AsString);
// 22.03.14 - soma a grade
//          FRel.AddCel( SomaGrade(Q.FieldByName('esqt_unid_codigo').AsString,Q.FieldByName('esqt_esto_codigo').AsString));
          FRel.AddCel( Q.FieldByName('esgr_qtde').AsString );
          if Global.Topicos[1356] then
              FRel.AddCel('');
          if Global.Topicos[1204] then begin
             FRel.AddCel('');
             FRel.AddCel('');  // 02.07.13
          end;
          FRel.AddCel(Q.FieldByName('esgr_pecas').AsString);
          if cQtdeprocesso='S' then
            FRel.AddCel(floattostr(qtdeprocesso));
        end;
        if EdEstcalculado.text='S' then begin
           if somargrade='N' then begin
             FRel.AddCel( formatfloat( '#####0.00',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'XXXX_qtde',
                        Q.FieldByName('esqt_unid_codigo').AsString,Q.FieldByName('esgr_core_codigo').AsInteger,
                        Q.FieldByName('esgr_tama_codigo').AsInteger,
                        Q.FieldByName('esgr_copa_codigo').AsInteger) ) );
             FRel.AddCel( formatfloat( '#####0.00',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'XXXX_pecas',
                        Q.FieldByName('esqt_unid_codigo').AsString,0,
                        0,
                        0) ) );
           end else begin
             FRel.AddCel( formatfloat( '#####0.00',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'XXXX_qtde',
                        Q.FieldByName('esqt_unid_codigo').AsString,0,
                        0,
                        0) ) );
             FRel.AddCel('');
           end;
        end;
////////////////21.08.08
        custo:=Q.FieldByName('esqt_custo').Ascurrency+Q.FieldByName('esqt_custoser').Ascurrency;
        customedio:=Q.FieldByName('esqt_customedio').Ascurrency+Q.FieldByName('esqt_customedioser').Ascurrency;
        custoger:=Q.FieldByName('esqt_custoger').Ascurrency+Q.FieldByName('esqt_custoser').Ascurrency;
        customedioger:=Q.FieldByName('esqt_customeger').Ascurrency+Q.FieldByName('esqt_customedioser').Ascurrency;
        qtde:=Q.FieldByName('esqt_qtde').Asfloat;
// 25.02.14 - Custo 'da metalforte
/////////////////////////
        if Global.topicos[1411] then begin
       // ferro - custo do kilo vezes o peso da barra
          tamanho:=6;  // por enquanto fixo barra de 6 metros
          if regradogrupo(Q.FieldByName('esto_codigo').asstring)=1 then
            custo:=Q.FieldByName('esqt_custo').ascurrency*Q.FieldByName('esto_peso').ascurrency
          else if regradogrupo(Q.FieldByName('esto_codigo').asstring)=2 then
            custo:=Q.FieldByName('esqt_custo').ascurrency*Q.FieldByName('esto_peso').ascurrency *
                   tamanho
          else
            custo:=Q.FieldByName('esqt_custo').ascurrency;
        end;
////////////////
        qtdeprev:=Q.FieldByName('esqt_qtdeprev').Asfloat;
        venda:=Q.FieldByName('esqt_vendavis').AsCurrency;
// 25.03.13 - Vivan
        if Global.topicos[1362] then begin
          venda:=vendaproduto;
          custo:=custoultimoproduto;
          customedio:=customedioproduto;
        end else if Global.topicos[1411] then begin
          venda:=custo;
          xmargem:=Q.fieldbyname('grup_markup').AsCurrency;
          if xmargem<=100 then
            venda:=venda/( (100-xmargem)/100 )
          else
            venda:=venda*2;
        end;
////
        if cQtdeprocesso='S' then
          qtdeprocesso:=Q.FieldByName('esqt_qtdeprocesso').Asfloat
        else
          qtdeprocesso:=0;
/////////////////
        if somargrade='N' then begin
//          if Q.fieldbyname('esto_grad_codigo').asinteger>0 then begin
// 17.04.08
          if Q.fieldbyname('esgr_esto_codigo').asstring<>'' then begin
// 21.10.09 - colocado custo do servido na grade--antes so havia no produto e so o ultimo
            custo:=Q.FieldByName('esgr_custo').Ascurrency+Q.FieldByName('esgr_custoser').Ascurrency;
            customedio:=Q.FieldByName('esgr_customedio').Ascurrency+Q.FieldByName('esgr_customedioser').AsCurrency;
            custoger:=Q.FieldByName('esgr_custoger').Ascurrency+Q.FieldByName('esgr_custoser').Ascurrency;
            customedioger:=Q.FieldByName('esgr_customeger').Ascurrency+Q.FieldByName('esgr_customedioser').AsCurrency;
            qtde:=Q.FieldByName('esgr_qtde').Asfloat;
            qtdeprev:=Q.FieldByName('esgr_qtdeprev').Asfloat;
            venda:=Q.FieldByName('esgr_vendavis').AsCurrency;
// 10.03.14 - Custo da metalforte
/////////////////////////
            if Global.topicos[1411] then begin
           // ferro - custo do kilo vezes o peso da barra
              tamanho:=6;  // por enquanto fixo barra de 6 metros
              if regradogrupo(Q.FieldByName('esto_codigo').asstring)=1 then
                custo:=Q.FieldByName('esgr_custo').ascurrency*Q.FieldByName('esto_peso').ascurrency
              else if regradogrupo(Q.FieldByName('esto_codigo').asstring)=2 then
                custo:=(Q.FieldByName('esqt_custo').ascurrency+Q.FieldByName('esgr_custo').ascurrency)*Q.FieldByName('esto_peso').ascurrency *
                      tamanho
              else
                custo:=Q.FieldByName('esgr_custo').ascurrency;
              customedio:=custo;
              custoger:=custo;
              customedioger:=custo;
              venda:=custo;
              xmargem:=Q.fieldbyname('grup_markup').AsCurrency;
              if xmargem<=100 then
                venda:=venda/( (100-xmargem)/100 )
              else
                venda:=venda*2;
            end;
/////////////////////
// 25.03.13 - Vivan
            if Global.topicos[1362] then begin
              venda:=vendaproduto;
              custo:=custoultimoproduto;
              customedio:=customedioproduto;
            end;
//////////////////////////////
            if cqtdeprocesso='S' then
              qtdeprocesso:=Q.FieldByName('esgr_qtdeprocesso').Asfloat
            else
              qtdeprocesso:=0;
            if Global.Usuario.OutrosAcessos[0049] then begin
              FRel.AddCel(floattostr(custo));
              FRel.AddCel(floattostr(customedio));
              FRel.AddCel(floattostr(vendavis));
            end;
          end else begin
            custo:=Q.FieldByName('esqt_custo').Ascurrency+Q.FieldByName('esqt_custoser').Ascurrency;
            customedio:=Q.FieldByName('esqt_customedio').Ascurrency+Q.FieldByName('esqt_customedioser').Ascurrency;
            custoger:=Q.FieldByName('esqt_custoger').Ascurrency+Q.FieldByName('esqt_custoser').Ascurrency;
            customedioger:=Q.FieldByName('esqt_customeger').Ascurrency+Q.FieldByName('esqt_customedioser').Ascurrency;
            qtde:=Q.FieldByName('esqt_qtde').Asfloat;
            qtdeprev:=Q.FieldByName('esqt_qtdeprev').Asfloat;
            venda:=Q.FieldByName('esqt_vendavis').AsCurrency;
// 10.03.14 - Custo da metalforte
/////////////////////////
            if Global.topicos[1411] then begin
           // ferro - custo do kilo vezes o peso da barra
              tamanho:=6;  // por enquanto fixo barra de 6 metros
              if regradogrupo(Q.FieldByName('esto_codigo').asstring)=1 then
                custo:=Q.FieldByName('esqt_custo').ascurrency*Q.FieldByName('esto_peso').ascurrency
              else if regradogrupo(Q.FieldByName('esto_codigo').asstring)=2 then
                custo:=Q.FieldByName('esqt_custo').ascurrency*Q.FieldByName('esto_peso').ascurrency *
                       tamanho
              else
                custo:=Q.FieldByName('esqt_custo').ascurrency;
              customedio:=custo;
              custoger:=custo;
              customedioger:=custo;
              venda:=custo;
              xmargem:=Q.fieldbyname('grup_markup').AsCurrency;
              if xmargem<=100 then
                venda:=venda/( (100-xmargem)/100 )
              else
                venda:=venda*2;
            end;
/////////////////////

// 25.03.13 - Vivan
            if Global.topicos[1362] then begin
              venda:=vendaproduto;
              custo:=custoultimoproduto;
              customedio:=customedioproduto;
            end;
//////////////////////////////

            if Global.Usuario.OutrosAcessos[0049] then begin
              FRel.AddCel(floattostr(custo));
              FRel.AddCel(floattostr(customedio));
              FRel.AddCel(floattostr(venda));
            end;
          end;
          custototal:=formatfloat(f_cr,qtde*custo);
          custototalm:=formatfloat(f_cr,qtde*customedio);
          custototalb:=formatfloat(f_cr,qtdeprev*custoger);
          custototalbm:=formatfloat(f_cr,qtdeprev*customedioger);
          vendatotal:=formatfloat(f_cr,qtde*venda);
// soma a garde
        end else begin
          custototal:=formatfloat(f_cr,(Q.fieldbyname('esqt_custo').ascurrency+Q.FieldByName('esqt_custoser').Ascurrency)*Q.fieldbyname('esgr_qtde').asfloat);
          custototalm:=formatfloat(f_cr,(Q.fieldbyname('esqt_customedio').ascurrency+Q.FieldByName('esqt_customedioser').Ascurrency)*Q.fieldbyname('esgr_qtde').asfloat);
          custototalb:=formatfloat(f_cr,(Q.fieldbyname('esqt_custoger').ascurrency+Q.FieldByName('esqt_custoser').Ascurrency)*Q.fieldbyname('esgr_qtdeprev').asfloat);
          custototalbm:=formatfloat(f_cr,(Q.fieldbyname('esqt_customeger').ascurrency+Q.FieldByName('esqt_customedioser').Ascurrency)*Q.fieldbyname('esgr_qtdeprev').asfloat);
          vendatotal:=formatfloat(f_cr,Q.fieldbyname('esqt_vendavis').ascurrency*Q.fieldbyname('esgr_qtde').asfloat);
        end;

        if Global.Usuario.OutrosAcessos[0049] then begin
          FRel.AddCel(custototal);
          FRel.AddCel(custototalm);
          FRel.AddCel(vendatotal);
        end;

        if Global.Usuario.OutrosAcessos[0010] then begin
          FRel.AddCel(formatfloat(f_qtdestoque,qtdeprev));
          if EdEstcalculado.text='S' then begin
// 21.08.08
              if gerarinventario then begin
                   Sistema.Insert('salestoque');
                   Sistema.SetField('saes_status','N');
                   Sistema.SetField('saes_mesano',FGeral.Anomesinvertido(EdMesano.text));
                   Sistema.SetField('saes_unid_codigo',Q.FieldByName('esqt_unid_codigo').AsString);
                   Sistema.SetField('saes_esto_codigo',Q.fieldbyname('esqt_esto_codigo').AsString);
                   Sistema.SetField('saes_custo',custo);
                   Sistema.SetField('saes_custoger',custoger);
                   Sistema.SetField('saes_customedio',customedio);
                   Sistema.SetField('saes_customeger',customedioger);
//                   Sistema.SetField('saes_qtde',qtde);
//                   Sistema.SetField('saes_qtdeprev',qtdeprev);
// 27.10.08
                   if (Q.FieldByName('esgr_core_codigo').AsInteger+Q.FieldByName('esgr_tama_codigo').AsInteger)>0 then begin
//                     Sistema.SetField('saes_qtde',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'XXXX_qtde',Q.FieldByName('esqt_unid_codigo').AsString,
  //                               Q.FieldByName('esgr_core_codigo').AsInteger,
//                                   Q.FieldByName('esgr_tama_codigo').AsInteger,
//                                   0) );
                     Sistema.SetField('saes_qtde',Q.FieldByName('esgr_qtde').Asfloat );

//                     Sistema.SetField('saes_qtdeprev',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'esqt_qtdeprev',Q.FieldByName('esqt_unid_codigo').AsString,
//                                   Q.FieldByName('esgr_core_codigo').AsInteger,
//                                   Q.FieldByName('esgr_tama_codigo').AsInteger,
//                                   0) );
                     Sistema.SetField('saes_qtdeprev',Q.FieldByName('esgr_qtdeprev').Asfloat);

                   end else begin
//                    Sistema.SetField('saes_qtde',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'XXXX_qtde',Q.FieldByName('esqt_unid_codigo').AsString,0,0,0));
//                    Sistema.SetField('saes_qtdeprev',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'esqt_qtdeprev',Q.FieldByName('esqt_unid_codigo').AsString,0,0,0));
                     Sistema.SetField('saes_qtde',qtde);
                     Sistema.SetField('saes_qtdeprev',qtdeprev);
                   end;
                   Sistema.SetField('saes_usua_codigo',Global.Usuario.Codigo);
                   Sistema.SetField('saes_vendavis',venda);
                   Sistema.Post;
              end;
///////////////////
              if somargrade='N' then
                FRel.AddCel( formatfloat( '######',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'esqt_qtdeprev',
                        Q.FieldByName('esqt_unid_codigo').AsString,Q.FieldByName('esgr_core_codigo').AsInteger,
                        Q.FieldByName('esgr_tama_codigo').AsInteger,
                        Q.FieldByName('esgr_copa_codigo').AsInteger) ) )
              else
                FRel.AddCel( formatfloat( '######',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'esqt_qtdeprev',Q.FieldByName('esqt_unid_codigo').AsString,0,0,0)) );
              if (Global.Usuario.OutrosAcessos[3305]) and (quergravar) then begin
                Sistema.Edit('Estoqueqtde');
                Sistema.Setfield('esqt_qtdeprev',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'esqt_qtdeprev',Q.FieldByName('esqt_unid_codigo').AsString,0,0,0));
                Sistema.Setfield('esqt_qtde',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'XXXX_qtde',Q.FieldByName('esqt_unid_codigo').AsString,0,0,0));
                Sistema.Setfield('esqt_pecas',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'XXXX_pecas',Q.FieldByName('esqt_unid_codigo').AsString,0,0,0));
                Sistema.Post('esqt_unid_codigo='+stringtosql(Q.FieldByName('esqt_unid_codigo').AsString)+
                             ' and esqt_status=''N'' and esqt_esto_codigo='+stringtosql(Q.fieldbyname('esqt_esto_codigo').AsString) );
// 08.09.06
                if (Q.FieldByName('esgr_core_codigo').AsInteger>0) and (Q.FieldByName('esgr_tama_codigo').AsInteger>0) then begin
                  sqlcor:='';sqltamanho:='';
                  if Q.FieldByName('esgr_core_codigo').AsInteger>0 then
                    sqlcor:=' and esgr_core_codigo='+Q.FieldByName('esgr_core_codigo').AsString;
                  if Q.FieldByName('esgr_tama_codigo').AsInteger>0 then
                    sqltamanho:=' and esgr_tama_codigo='+Q.FieldByName('esgr_tama_codigo').AsString;
                  if Q.FieldByName('esgr_copa_codigo').AsInteger>0 then
                    sqlcopa:=' and esgr_copa_codigo='+Q.FieldByName('esgr_copa_codigo').AsString
                  else
                    sqlcopa:=' and ( esgr_copa_codigo=0 or esgr_copa_codigo is null)';
                  Sistema.Edit('EstGrades');
                  Sistema.Setfield('esgr_qtdeprev',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'esqt_qtdeprev',Q.FieldByName('esqt_unid_codigo').AsString,
                                   Q.FieldByName('esgr_core_codigo').AsInteger,
                                   Q.FieldByName('esgr_tama_codigo').AsInteger,
                                   Q.FieldByName('esgr_copa_codigo').AsInteger));
                  Sistema.Setfield('esgr_qtde',GetQtdecalc(Q.FieldByName('esqt_esto_codigo').AsString,'XXXX_qtde',Q.FieldByName('esqt_unid_codigo').AsString,
                                   Q.FieldByName('esgr_core_codigo').AsInteger,
                                   Q.FieldByName('esgr_tama_codigo').AsInteger,
                                   Q.FieldByName('esgr_copa_codigo').AsInteger));
                  Sistema.Post('esgr_unid_codigo='+stringtosql(Q.FieldByName('esgr_unid_codigo').AsString)+
                               ' and esgr_status=''N'' and esgr_esto_codigo='+stringtosql(Q.fieldbyname('esgr_esto_codigo').AsString)+
                               sqlcor+sqltamanho+sqlcopa );
                end;
              end;
          end;
          if Global.Usuario.OutrosAcessos[0049] then begin
            if somargrade='N' then begin
              FRel.AddCel(formatfloat(f_cr,custoger));
              FRel.AddCel(formatfloat(f_cr,customedioger));
            end;
            FRel.AddCel(custototalb);
            FRel.AddCel(custototalbm);
          end;
        end;
// 09.05.14 - ajuste técnico devido duplicidade no estoqueqtde ainda nao detectada o porque
        if somargrade='N' then begin
          if ListaImp.indexof( Q.fieldbyname('esgr_unid_codigo').asstring+
                               Q.fieldbyname('esgr_esto_codigo').asstring+
                               Q.fieldbyname('esgr_tama_codigo').asstring+
                               Q.fieldbyname('esgr_core_codigo').asstring ) = -1 then
             ListaImp.add(     Q.fieldbyname('esgr_unid_codigo').asstring+
                               Q.fieldbyname('esgr_esto_codigo').asstring+
                               Q.fieldbyname('esgr_tama_codigo').asstring+
                               Q.fieldbyname('esgr_core_codigo').asstring );
        end else begin
          if ListaImp.indexof( Q.fieldbyname('esqt_unid_codigo').asstring+
                               Q.fieldbyname('esgr_tama_codigo').asstring+
                               Q.fieldbyname('esgr_core_codigo').asstring ) = -1 then
             ListaImp.add(     Q.fieldbyname('esgr_unid_codigo').asstring+
                               Q.fieldbyname('esqt_esto_codigo').asstring+
                               Q.fieldbyname('esgr_tama_codigo').asstring+
                               Q.fieldbyname('esgr_core_codigo').asstring );

        end;

      END;

        Q.Next;

      end;

// 07.04.14
      if somargrade='S' then FRel.SetResume('Codigo');
      FRel.Video;
    end;
    if EdEstcalculado.text='S' then begin
      if (Global.Usuario.OutrosAcessos[3305]) and (quergravar) then begin
        Sistema.beginprocess('Gravando estoque calculado');
        Sistema.commit;
      END else if gerarinventario then begin
        Sistema.beginprocess('Gravando inventário ref. '+EdMesano.text);
        Sistema.commit;
      end;
    END;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);
  end;

  FRelEstoque_Posicao;         // 1  - 08.09.06

end;


////////////////////////////////////////
procedure FRelEstoque_Cadastro;         // 3
////////////////////////////////////////
var qtde,qtdeprev:currency;
    QT:TSqlquery;

begin

  with FRelEstoque do begin

    if not FRelEstoque_Execute(3) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    if EdSomagrade.isempty then
      somargrade:='N'
    else
      somargrade:=EdSomagrade.text;
    if trim(FRelEstoque.EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.Getin('esqt_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
//    if somargrade='N' then

      Q:=sqltoquery('select * from estoqueqtde'+
                     ' left join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' left join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' left join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
                     ' left join estgrades on (esgr_esto_codigo=esqt_esto_codigo and esgr_status=''N'' and esgr_unid_codigo=esqt_unid_codigo)'+
                     ' left join familias on (fami_codigo=esto_fami_codigo) '+
                     ' left join tamanhos on (tama_codigo=esgr_tama_codigo) '+
                     ' left join cores    on (core_codigo=esgr_core_codigo) '+
                     ' left join material on (mate_codigo=esto_mate_codigo) '+
// 27.08.12  - Vivan - Lindacir
                     ' left join codigosipi on (cipi_codigo=esto_cipi_codigo) '+
                     ' where esqt_status=''N'''+
//                     ' and esto_emlinha=''S'''+
                     sqlunidade+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     ' order by esqt_unid_codigo,esqt_esto_codigo' );
{
    else
      Q:=sqltoquery('select * from estoqueqtde'+
                     ' left join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' left join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' left join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
                     ' left join familias on (fami_codigo=esto_fami_codigo) '+
                     ' where esqt_status=''N'''+
                     sqlunidade+
                     ' and esto_emlinha=''S'''+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     ' order by esqt_unid_codigo,esqt_esto_codigo' );
}
    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      FRel.Init('CadastroEstoque');
      FRel.AddTit('Cadastro do Estoque');
      FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));
      FRel.AddCol( 45,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Grupo'           ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Grupo'     ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Subgrupo'        ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Subgrupo'  ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Familia'         ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Familia'   ,''         ,'',false);
      FRel.AddCol( 90,1,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(200,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
      FRel.AddCol( 50,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 90,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
      FRel.AddCol( 80,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
      FRel.AddCol(100,1,'C','' ,''              ,'Cod.Barra'       ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'NCM'             ,''         ,'',false);
      FRel.AddCol( 50,1,'C','' ,''              ,'Em linha'        ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Material'         ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Material'   ,''         ,'',false);
      FRel.AddCol( 65,1,'D','' ,''              ,'Ult. Venda'       ,''         ,'',false);
      FRel.AddCol( 65,1,'D','' ,''              ,'Ult. Compra'      ,''         ,'',false);
      FRel.AddCol( 65,3,'N','' ,f_cr            ,'% Desconto'       ,''         ,'',false);
      FRel.AddCol( 70,3,'N','' ,f_cr            ,'Base comissão'    ,''         ,'',false);
      FRel.AddCol( 70,3,'N','' ,'##.#0'         ,'Aliq.estado'      ,''         ,'',false);
      FRel.AddCol( 80,3,'N','' ,'##.#0'         ,'Aliq.fora estado' ,''         ,'',false);
      FRel.AddCol( 80,1,'C','' ,''              ,'Sit.Trib.estado'  ,''         ,'',false);
      FRel.AddCol( 80,1,'C','' ,''              ,'Sit.Trib.fora est.' ,''         ,'',false);
// 25.06.18 - Novicarnes - Ketlen
      FRel.AddCol( 80,1,'C','' ,''              ,'CST Pis Saidas'  ,''         ,'',false);
      FRel.AddCol( 80,1,'C','' ,''              ,'CST Cofins Saidas' ,''         ,'',false);

      FRel.AddCol( 80,3,'N','' ,f_cr            ,'Venda a Vista'      ,''         ,'',false);
      if Global.Usuario.OutrosAcessos[0010] then
        FRel.AddCol( 80,3,'N','' ,f_cr            ,'Custo'    ,''         ,'',false);

      while not Q.eof do begin

        FRel.AddCel(Q.FieldByName('esqt_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_grup_codigo').AsString);
        FRel.AddCel(Q.FieldByName('grup_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esto_sugr_codigo').AsString);
        FRel.AddCel(Q.FieldByName('sugr_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esto_fami_codigo').AsString);
        FRel.AddCel(Q.FieldByName('fami_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esqt_esto_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esto_unidade').AsString);

//        FRel.AddCel(Q.FieldByName('esqt_tama_codigo').AsString);
        FRel.AddCel(Q.FieldByName('tama_descricao').AsString);
//        FRel.AddCel(Q.FieldByName('esqt_core_codigo').AsString);
        FRel.AddCel(Q.FieldByName('core_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esto_codbarra').AsString);
        FRel.AddCel(Q.FieldByName('Cipi_codfiscal').AsString);
        FRel.AddCel(Q.FieldByName('esto_emlinha').AsString);
        FRel.AddCel(Q.FieldByName('esto_mate_codigo').AsString);
        FRel.AddCel(Q.FieldByName('mate_descricao').AsString);

        FRel.AddCel(Q.FieldByName('esqt_dtultvenda').asstring);
        FRel.AddCel(Q.FieldByName('esqt_dtultcompra').asstring);
        FRel.AddCel(Q.FieldByName('esqt_desconto').asstring);
        FRel.AddCel(Q.FieldByName('esqt_basecomissao').asstring);

//        FRel.AddCel(Q.FieldByName('esqt_cfis_codigoest').asstring;
        FRel.AddCel( currtostr (FCodigosFiscais.GetAliquota( Q.FieldByName('esqt_cfis_codigoest').asstring )) );
//        FRel.AddCel(Q.FieldByName('esqt_cfis_codigoforaest').asstring;
        FRel.AddCel( currtostr (FCodigosFiscais.GetAliquota( Q.FieldByName('esqt_cfis_codigoforaest').asstring)) );
//        FRel.AddCel(Q.FieldByName('esqt_sitt_codestado').asstring;
        FRel.AddCel( FSittributaria.GetCST( Q.FieldByName('esqt_sitt_codestado').asinteger ) );
        FRel.AddCel(FSittributaria.GetCST( Q.FieldByName('esqt_sitt_forestado').asinteger ) );
// 25.06.18
        QT:=sqltoquery('select sitt_cstpis,sitt_cstcofins from SITTRIB where sitt_codigo = '+
                       Q.FieldByName('esqt_sitt_codestado').asstring );
        FRel.AddCel( QT.FieldByName('sitt_cstpis').asstring );
        FRel.AddCel( QT.FieldByName('sitt_cstcofins').asstring );
        FGeral.FechaQuery(QT);

        FRel.AddCel(Q.FieldByName('esqt_vendavis').asstring);
        if Global.Usuario.OutrosAcessos[0010] then
          FRel.AddCel(Q.FieldByName('esqt_custoger').asstring);

        Q.Next;

      end;

      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);
  end;
end;


/////////////////////////////////////////////////////////////////////////////////////////////////////
// PEGA AS REMESSAS E DEVOLUCOES DO PERIODO DIGITADO
procedure FRelEstoque_InventaConsig(tipo,retro:string);        // 4,5,6

type TInventa=record
    esto_codigo,unidade:string;
    remessas,devolucoes,saldoqtde,dc,dr:currency;
    tamanho,cor:integer;
end;


var Q,QCustos:TSqlquery;
    produto,unidade,tiporemessa,unidadecusto,listadocumentos,tiposbuscadev,tiposoma,remessasbai,statusbuscamoes,
    statusbuscamove,statusremessas,titretro1,titretro2,tiposdevolucoes,sqlcodtipo:string;
    vlrcusto,vlrcustomedio,vlrcustoger,vlrcustomeger,saldoqtde,qtdedevolvida,qtderemessa:currency;
    cor,tamanho,p:integer;
    ListaI:TList;
    PInventa:^TInventa;
    ListaRemessaBai,ListaDevolucoes,Lista,ListaRemessasPeriodo:Tstringlist;
    Datainicio:TDatetime;
    retroativo:boolean;

//////////// - 01.03.06
    function DevolucaoOK(remessas,tipomov:string):boolean;
    var x:integer;
        found:boolean;
    begin
       found:=false;
       if tipomov=global.CodRemessaProntaEntrega then
         found:=true
       else if trim(remessas)='' then
         found:=true
       else begin
//         found:=true;
         for x:=0 to Listaremessasperiodo.count-1 do begin
           if pos( strzero(strtointdef(listaremessasperiodo[x],0),8) , remessas )>0 then begin
             found:=true;
             break;
           end;
         end;
       end;
       result:=found;
    end;
//////////////


    procedure Atualiza(produto,tipomov,unidade:string ; qtde:currency ; status:string='N');
    var x:integer;
        jatem:boolean;
    begin
      jatem:=false;
      for x:=0 to ListaI.count-1 do begin
        PInventa:=Listai[x];
        if (Pinventa.esto_codigo=produto) and (Pinventa.unidade=unidade)then begin
{
          if tipomov=tiporemessa then begin
            Pinventa.remessas:=Pinventa.remessas+qtde;
            Pinventa.saldoqtde:=Pinventa.saldoqtde+qtde;
          end else begin
            Pinventa.devolucoes:=Pinventa.devolucoes+qtde;
            Pinventa.saldoqtde:=Pinventa.saldoqtde-qtde;
          end;
}
          jatem:=true;
          if pos(tipomov,tiposoma)>0 then begin
            Pinventa.remessas:=Pinventa.remessas+qtde;
            Pinventa.saldoqtde:=Pinventa.saldoqtde+qtde;
          end else begin
            if pos( tipomov,tiposdevolucoes )>0 then  // 14.02.06
              Pinventa.devolucoes:=Pinventa.devolucoes+qtde;
            Pinventa.saldoqtde:=Pinventa.saldoqtde-qtde;
            if tipomov=Global.CodDevolucaoConsig then
              Pinventa.dc:=pinventa.dc+Q.fieldbyname('move_qtde').ascurrency
            else if tipomov=Global.CodDevolucaoTroca then begin
              Pinventa.dr:=Pinventa.dr+Q.fieldbyname('move_qtde').ascurrency;
            end;
          end;
        end;
      end;
// tentativa se caso houver devolucoes sem se referir a alguma remessa ainda em aberto
      if not jatem then begin     // 06.06.05
            New(PInventa);
            Pinventa.esto_codigo:=produto;
            Pinventa.unidade:=unidade;
            Pinventa.remessas:=0;
            Pinventa.devolucoes:=qtde;
            Pinventa.tamanho:=Q.fieldbyname('move_tama_codigo').asinteger;
            Pinventa.cor:=Q.fieldbyname('move_core_codigo').asinteger;
            Pinventa.saldoqtde:=-qtde;
            Pinventa.dc:=0;
            Pinventa.dr:=0;
            ListaI.add(pinventa);
      end;
    end;


begin

  with FRelEstoque do begin

    if not FRelEstoque_Execute(4) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    if trim(FRelEstoque.EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    statusremessas:='N';
//    retroativo:=EdDataf.asdate<>sistema.hoje;
//    if ( datetomes(EdDataf.asdate)<>datetomes(sistema.hoje) ) then
// 07.07.06
    sqlcodtipo:='';
    if not EdCodtipo.isempty then begin
        if Edtipocad.text='R' then
          sqlcodtipo:=' and move_repr_codigo='+EdCodtipo.assql
        else
          sqlcodtipo:=' and move_tipo_codigo='+EdCodtipo.assql;
    end;
    if retro='S' then
      retroativo:=true
    else
      retroativo:=false;
    if tipo='Consignado' then begin
//      sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C');
// 18.05.05
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.CodRemessaConsig+';'+Global.CodVendaTransf,'C');
      tiporemessa:=Global.CodRemessaConsig+';'+Global.CodVendaTransf;
      datainicio:=Datetoprimeirodiames(EdDataf.asdate);
      tiposbuscadev:=global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca;
//      tiposoma:=Global.CodDevolucaoConsig+';'+global.CodDevolucaoTroca+';'+Global.CodRemessaConsig;
// 12.05.05
      tiposoma:=Global.CodRemessaConsig+';'+Global.CodVendaTransf;
      tiposdevolucoes:=Global.CodDevolucaoConsig;
      if retroativo then begin
        statusremessas:='N;D;E';
        statusbuscamoes:='N;D;E';  // status E devido as dev. de troca
        statusbuscamove:='N;D;E';
      end else begin
        statusremessas:='N;E';
        statusbuscamoes:='N;E';  // status E devido as dev. de troca
        statusbuscamove:='N;E';
      end;

    end else if tipo='Regimeespecial' then begin

      sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.CodVendaSerie4,'C');
//      sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.CodVendaSerie4+';'+Global.CodDevolucaoSerie5+';'+Global.CodVendaReBrinde+';'+Global.CodVendaRE,'C');
//      tiporemessa:=Global.CodRomaSerie4;
      tiporemessa:=Global.CodVendaSerie4;
//      tiposbusca:=Global.CodRomaSerie4+';'+global.CodDevolucaoSerie5;
// 14.02.06
      tiposbuscadev:=global.CodDevolucaoSerie5+';'+Global.CodVendaREBrinde+';'+Global.CodVendaRE;
//      tiposoma:=global.CodDevolucaoSerie5+';'+Global.CodVendaLiqSerie4;
//      tiposoma:=global.CodDevolucaoSerie5+';'+Global.CodVendaREBrinde+';'+Global.CodVendaRE;
// 14.02.06
      tiposoma:=global.CodVendaserie4;
      if retroativo then begin
        statusremessas:='N;E';
        statusbuscamoes:='E;N';
        statusbuscamove:='E;N';
// 01.03.06
      end else begin
        statusremessas:='N';
        statusbuscamoes:='N';
        statusbuscamove:='N';
      end;
/////////////////
      tiposdevolucoes:=tiposbuscadev;
// 07.07.06
      sqlcodtipo:='';
      if not EdCodtipo.isempty then begin
        if Edtipocad.text='R' then
          sqlcodtipo:=' and move_repr_codigo='+EdCodtipo.assql
        else
          sqlcodtipo:=' and move_clie_codigo='+EdCodtipo.assql;
      end;

    end else begin  // PE

//      sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.CodRemessaProntaEntrega+';'+Global.CodDevolucaoProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodVendaTransf+';'+Global.CodVendaProntaEntrega,'C');
// 14.02.06
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.CodRemessaProntaEntrega,'C');
      tiporemessa:=Global.CodRemessaProntaEntrega;
//      tiposbusca:=Global.CodDevolucaoProntaEntrega+';'+Global.CodRemessaProntaEntrega;
      tiposbuscadev:=Global.CodDevolucaoProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodVendaTransf+';'+Global.CodVendaProntaEntrega;
//      tiposoma:=Global.CodDevolucaoProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodVendaTransf+';'+Global.CodVendaProntaEntrega;
// 14.02.06 - Leila + Reges retestando
      tiposoma:=Global.CodRemessaProntaEntrega;
      if retroativo then begin
        statusremessas:='N;E';
        statusbuscamoes:='N;E';  // status E devido as dev. de troca
        statusbuscamove:='N;E';
      end else begin
        statusremessas:='N';
        statusbuscamoes:='N';  // status E devido as dev. de troca
        statusbuscamove:='N';
      end;
      tiposdevolucoes:=tiposbuscadev;
    end;
    ListaRemessasPeriodo:=TStringlist.create;
// 10.10.05
    if not FRelEstoque.EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.Getin('move_esto_codigo',FRelEstoque.EdEsto_codigo.text,'C')
    else
      sqlproduto:='';

    Sistema.beginprocess('Pesquisando remessas digitadas até '+formatdatetime('dd/mm/yy',EdDataf.asdate));
    Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
//                  ' where move_datamvto>='+Datetosql(Datainicio)+' and move_datamvto<='+EdDataf.AsSql+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
//                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+Datetosql(Sistema.hoje)+
                  sqlunidade+
                  sqlproduto+
                  sqltipomovto+
                  sqlcodtipo+  // 07.07.06
                  ' and '+FGeral.Getin('moes_status',statusremessas,'C')+   // 15.04.05
                  ' and '+FGeral.Getin('move_status',statusremessas,'C')+
//                  ' and '+FGeral.Getin('move_tipomov',tiposmov,'C')+
//                ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_datalcto' );
                ' order by move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo,move_transacao' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      ListaI:=TList.create;
      Sistema.beginprocess('Armazenando remessas digitadas até '+formatdatetime('dd/mm/yy',EdDataf.asdate));
      while not Q.eof  do begin
            produto:=Q.fieldbyname('move_esto_codigo').asstring;
            unidade:=Q.fieldbyname('move_unid_codigo').asstring;
            tamanho:=Q.fieldbyname('move_tama_codigo').asinteger;
            cor:=Q.fieldbyname('move_core_codigo').asinteger;
            saldoqtde:=0;qtderemessa:=0;qtdedevolvida:=0;
            if FRelEstoque.EdUnidcusto.isempty then
              unidadecusto:=unidade
            else
              unidadecusto:=FRelEstoque.EdUnidcusto.text;
            while (not Q.eof) and (unidade=Q.fieldbyname('move_unid_codigo').asstring) and (produto=Q.fieldbyname('move_esto_codigo').asstring) and
              (tamanho=Q.fieldbyname('move_tama_codigo').asinteger) and (cor=Q.fieldbyname('move_core_codigo').asinteger) do begin
              if pos(Q.fieldbyname('move_tipomov').asstring,tiporemessa)>0 then begin
                qtderemessa:=qtderemessa+Q.fieldbyname('move_qtde').ascurrency;
                saldoqtde:=saldoqtde+Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                saldoqtde:=saldoqtde-Q.fieldbyname('move_qtde').ascurrency;
                if pos(Q.fieldbyname('move_tipomov').asstring,tiposdevolucoes)>0 then  // 14.02.06
                  qtdedevolvida:=qtdedevolvida+Q.fieldbyname('move_qtde').ascurrency;
              end;
              if ListaRemessasPeriodo.indexof(Q.fieldbyname('move_numerodoc').asstring)=-1 then
                ListaRemessasPeriodo.add(Q.fieldbyname('move_numerodoc').asstring);
              Q.Next;
            end;  // por produto
            New(PInventa);
            Pinventa.esto_codigo:=produto;
            Pinventa.unidade:=unidade;
            Pinventa.remessas:=qtderemessa;
            Pinventa.devolucoes:=qtdedevolvida;
            Pinventa.tamanho:=tamanho;
            Pinventa.cor:=cor;
            Pinventa.saldoqtde:=saldoqtde;
            Pinventa.dc:=0;
            Pinventa.dr:=0;
            ListaI.add(pinventa);
      end;
      Q.close;
      Freeandnil(Q);

/////////////////////{
{
      Sistema.beginprocess('Lendo Vendas consignadas baixadas após '+formatdatetime('dd/mm/yy',EdDataf.asdate));
      Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' where move_datamvto>'+EdDataF.AsSql+
                  sqlunidade+
                  ' and moes_tipomov='+stringtosql(Global.CodVendaConsig)+
                  ' and '+FGeral.Getin('move_status','N','C')+
                ' order by move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo,move_transacao' );
      ListaRemessa:=Tstringlist.create;
      while not Q.eof do begin
        Lista:=Tstringlist.create;
        strtolista(Lista,Q.fieldbyname('moes_remessas').asstring,';',true);
        for p:=0 to Lista.count-1 do begin
          if Listaremessa.indexof(lista[p])=-1 then
            ListaRemessa.add(lista[p]);
        end;
        Q.Next;
      end;
      Q.close;
      Freeandnil(Q);

      Sistema.beginprocess('Lendo Devoluções de consignação baixadas após '+formatdatetime('dd/mm/yy',EdDataf.asdate));
      Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                  ' where move_datamvto>'+EdDataF.AsSql+
                  sqlunidade+
                  ' and '+FGeral.getin('moes_tipomov',stringtosql(Global.CodDevolucaoConsig+';'+global.CodDevolucaoTroca),'C')+
                  ' and '+FGeral.Getin('move_status','D','C')+
                ' order by move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo,move_transacao' );

      ListaDevolucoes:=Tstringlist.create;
      Listadocumentos:='';
      for p:=0 to listaremessa.count-1 do begin
        Listadocumentos:=listadocumentos+listaremessa[p]+';';
      end;
      while not Q.eof do begin
        Lista:=Tstringlist.create;
        strtolista(Lista,Q.fieldbyname('moes_remessas').asstring,';',true);
        for p:=0 to Lista.count-1 do begin
          if ListaDevolucoes.indexof(lista[p])=-1 then begin
// somente as devolucoes ref, as remessas 'pesquisadas'
            if pos( lista[p],listadocumentos )>0 then
               ListaDevolucoes.add(lista[p]);
          end;
        end;
        Q.Next;
      end;
      Q.close;
      Freeandnil(Q);

      for p:=0 to listadevolucoes.count-1 do begin
        Listadocumentos:=listadocumentos+listadevolucoes[p]+';';
      end;
}

//      if trim(Listadocumentos)<>'' then begin
//        Sistema.beginprocess('Somando remessas e devoluções de consignação baixadas após '+formatdatetime('dd/mm/yy',EdDataf.asdate));

///////////////////////////////////////////////////////////////////////////////

//        Sistema.beginprocess('Somando devoluções de consignação baixadas após '+formatdatetime('dd/mm/yy',EdDataf.asdate));
        Sistema.beginprocess('Somando devoluções até '+formatdatetime('dd/mm/yy',EdDataf.asdate));
        Q:=sqltoquery('select * from movestoque '+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc )'+
                    ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
//                  ' where move_datamvto>='+Datetosql(Datainicio)+' and move_datamvto<='+EdDataf.AsSql+
                    sqlproduto+
                    sqlunidade+
                    ' and '+FGeral.getin('move_tipomov',tiposbuscadev,'C')+
//////                    ' and '+FGeral.Getin('moes_status',statusbuscamoes,'C')+   // 15.04.05
                    ' and '+FGeral.Getin('move_status',statusbuscamove,'C')+
//                    ' and '+FGEral.getin('move_numerodoc',listadocumentos,'N')+
                  ' order by move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo,move_transacao' );

// soma somente as devolucoes q se referem a remessas do periodo
        ListaRemessaBai:=Tstringlist.create;
        while not Q.eof do begin

// 17.04.06
          if ( (Q.fieldbyname('moes_comv_codigo').asinteger<>54) and (Devolucaook(Q.fieldbyname('move_remessas').asstring,Q.fieldbyname('move_tipomov').asstring))  )
//          if ( (Q.fieldbyname('moes_comv_codigo').asinteger<>54) and (Devolucaook(Q.fieldbyname('move_remessas').asstring,Q.fieldbyname('move_tipomov').asstring)) and (pos(tipo,'Prontaentrega'+';'+'Regimeespecial')>0) )
//          if ( (Q.fieldbyname('moes_comv_codigo').asinteger<>54) and (Devolucaook(Q.fieldbyname('move_remessas').asstring,Q.fieldbyname('move_tipomov').asstring)) and (tipo='Prontaentrega') )
//              or
//             ( tipo<>'Regimeespecial' )
          then begin
            Lista:=Tstringlist.create;
  //          strtolista(Lista,Q.fieldbyname('moes_remessas').asstring,';',true);
  // 01.03.06
            strtolista(Lista,Q.fieldbyname('move_remessas').asstring,';',true);
            for p:=0 to Lista.count-1 do begin
              if ListaremessaBai.indexof(lista[p])=-1 then
                ListaRemessaBai.add(lista[p]);
            end;
            if Lista.count>0 then begin
  // assim nao pode ficar ---- 06.06.05 - lista tem as devolucoes do moes_remessa mas a select 'ta no mesmo lugar1
              for p:=0 to Lista.count-1 do begin
                if retroativo then begin
                  if ListaremessasPeriodo.indexof(lista[p])<>-1 then begin
                    Atualiza(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_status').asstring);
                    break;
                  end else begin
                     if Q.fieldbyname('move_repr_codigo').asinteger=0 then begin
                       Atualiza(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_status').asstring);
                       break;
                     end;
                  end;
                end else begin
                  Atualiza(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_status').asstring);
                  break;
                end;
              end;
            end else begin  // 01.03.06 - devido as VP e VB da PE
              Atualiza(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_status').asstring);
            end;
          
          
          end;
          Q.next;
        end;



      if retro='S' then begin
        titretro1:='R';
        titretro2:=' - Retroativo';
      end else begin
        titretro1:='';
        titretro2:='';
      end;

      if tipo='Consignado' then begin
        FRel.Init('RelInventarioConsigAberto'+titretro1);
        FRel.AddTit('Inventário Consignado'+titretro2);
      end else if tipo='Regimeespecial' then begin
        FRel.Init('RelInventarioRegimeEspecial'+titretro1);
        FRel.AddTit('Inventário Regime Especial'+titretro2);
      end else  begin
        FRel.Init('RelInventarioProntaEntrega'+titretro1);
        FRel.AddTit('Inventário Pronta Entrega'+titretro2);
      end;

      if not FRelEstoque.EdUnidcusto.isempty then
         FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text)+' -  Custos da Unidade '+FRelEstoque.EdUnidcusto.Text+' - '+FRelEstoque.EdUnidcusto.resultfind.fieldbyname('unid_nome').asstring )
      else
         FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 80,0,'C','' ,''              ,'Cod.Prod'        ,''         ,'',False);
      FRel.AddCol(130,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Remessa'         ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Devolvida'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Saldo Produto'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',''              ,'Custo'          ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',''              ,'Custo Médio'       ,''         ,'',False);
      if Global.Usuario.OutrosAcessos[0010] then begin
        FRel.AddCol( 80,3,'N','+',''              ,'Custo Medio Gerencial'    ,''         ,'',False);
      end;

//      FRel.AddCol( 80,3,'N','+',''              ,'DC'       ,''         ,'',False);
//      FRel.AddCol( 80,3,'N','+',''              ,'DR'       ,''         ,'',False);

      for p:=0 to LIstai.count-1 do begin
            PInventa:=ListaI[p];
            FRel.AddCel(Pinventa.unidade);
            FRel.AddCel(Pinventa.esto_codigo);
            FRel.AddCel(FEstoque.GetDescricao(Pinventa.esto_codigo));
            if Qcustos=nil then
                QCustos:=sqltoquery(FEstoque.GetSqlCustos(Pinventa.esto_codigo,unidadecusto,Pinventa.tamanho,Pinventa.cor))
            else begin
                Qcustos.close;
                Qcustos.sql.text:=FEstoque.GetSqlCustos(Pinventa.esto_codigo,unidadecusto,Pinventa.tamanho,Pinventa.cor);
                QCustos.open;
            end;
            vlrcusto:=(Pinventa.saldoqtde*QCustos.fieldbyname('custo').ascurrency);
            vlrcustomedio:=(Pinventa.saldoqtde*QCustos.fieldbyname('customedio').ascurrency);
            if vlrcustomedio=0 then  // 17.06.05
               vlrcustomedio:=Pinventa.saldoqtde*FEstoque.GetCustoZerado(Pinventa.esto_codigo,'C');
            vlrcustoger:=(Pinventa.saldoqtde*QCustos.fieldbyname('custoger').ascurrency);
            if vlrcustoger=0 then   // 17.06.05
              vlrcustoger:=Pinventa.saldoqtde*FEstoque.GetCustoZerado(Pinventa.esto_codigo,'G');
            vlrcustomeger:=(Pinventa.saldoqtde*QCustos.fieldbyname('customeger').ascurrency);
            FRel.AddCel(transform(Pinventa.remessas,f_cr));
            FRel.AddCel(transform(Pinventa.devolucoes,f_cr));
            FRel.AddCel(transform(Pinventa.saldoqtde,f_cr));
            FRel.AddCel(transform(vlrcusto,f_cr));
            FRel.AddCel(transform(vlrcustomedio,f_cr));
            if Global.Usuario.OutrosAcessos[0010] then begin
//               FRel.AddCel(transform(vlrcustoger,f_cr));
               FRel.AddCel(transform(vlrcustomeger,f_cr));
            end;
//            FRel.AddCel(transform(pinventa.dc,f_cr));
//            FRel.AddCel(transform(pinventa.dr,f_cr));
      end;
      if QCustos<>nil then begin
        Qcustos.close;
        Freeandnil(QCustos);
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Sistema.beginprocess('Fechando tabelas');
    Q.close;
    Freeandnil(Q);
    if listai<>nil then
      Freeandnil(ListaI);
    if listaremessabai<>nil then
       Freeandnil(ListaREmessabai);
    if listadevolucoes<>nil then
      Freeandnil(ListaDevolucoes);
    Sistema.EndProcess('');
  end;

end;
/////////////////////////////////////////////////////////////////////////////////////////////////////
// PEGA AS REMESSAS E DEVOLUCOES DO PERIODO DIGITADO


/////////////////////////////////////////////////////////////////////////////////////////////////////
// CALCULA O SALDO ATUAL IGUAL RELAT. DE POSICAO EM ABERTO E 'VAI PRA TRAS'
procedure FRelEstoque_InventaConsigXX(tipo:string);        // 4,5,6

type TSaldos=record
    produto,unidade:string;
    qtderem,qtdedev,saldo:currency;
    qtderemret,qtdedevret,saldoret:currency;
end;

var Q:TSqlquery;
    sqlconsigaberto,produto,tiposremessa,tiposdevolucoes,statusretro:string;
    vlrremessa,saldoqtde,saldoqtdeclie:currency;
    repr,clie,p:integer;
    ListaSaldos:Tlist;
    PSaldos:^TSaldos;
    Datafinal:TDatetime;


    procedure Atualiza(unidade,produto,tipomov:string ; qtde:currency ; status:string='N' ; retro:string='N');
    var x,y:integer;
    begin
      y:=0;
      for x:=0 to ListaSaldos.count-1 do begin
        PSaldos:=ListaSaldos[x];
        if (PSaldos.produto=produto) and (PSaldos.unidade=unidade)then begin
          y:=1;
          if pos(tipomov,tiposremessa)>0 then begin
              PSaldos.qtderem:=PSaldos.qtderem+qtde;
              Psaldos.saldo:=Psaldos.saldo+qtde;
          end else begin
              PSaldos.qtdedev:=PSaldos.qtdedev+qtde;
              Psaldos.saldo:=Psaldos.saldo-qtde;
          end;
          break;
        end;
      end;
      if y=0 then begin
        New(PSaldos);
        PSaldos.unidade:=unidade;
        PSaldos.produto:=produto;
        PSaldos.qtderem:=0;
        PSaldos.qtdedev:=0;
        PSaldos.saldo:=0;
        PSaldos.qtderemret:=0;
        PSaldos.qtdedevret:=0;
        PSaldos.saldoret:=0;
        if pos(tipomov,tiposremessa)>0 then begin
               PSaldos.qtderem:=PSaldos.qtderem+qtde;
               Psaldos.saldo:=Psaldos.saldo+qtde;
        end else begin
              PSaldos.qtdedev:=PSaldos.qtdedev+qtde;
              Psaldos.saldo:=Psaldos.saldo-qtde;
        end;
        ListaSaldos.add(PSaldos);
      end;
    end;

    procedure AtualizaRetro(unidade,produto,tipomov:string ; qtde:currency ; status:string='N' ; retro:string='N');
    var x,y:integer;
    begin
      y:=0;
      for x:=0 to ListaSaldos.count-1 do begin
        PSaldos:=ListaSaldos[x];
        if (PSaldos.produto=produto) and (PSaldos.unidade=unidade)then begin
          y:=1;
          if pos(tipomov,tiposremessa)>0 then begin
            PSaldos.qtderemret:=PSaldos.qtderemret+qtde;
            PSaldos.saldoret:=PSaldos.saldoret+qtde;
            if retro='N' then begin
              Psaldos.saldo:=Psaldos.saldo+qtde;
            end else begin
              Psaldos.saldo:=Psaldos.saldo-qtde;
            end;
          end else begin
            PSaldos.qtdedevret:=PSaldos.qtdedevret+qtde;
            PSaldos.saldoret:=PSaldos.saldoret-qtde;
            if retro='N' then begin
              Psaldos.saldo:=Psaldos.saldo+qtde;
            end else begin
              Psaldos.saldo:=Psaldos.saldo-qtde;
            end;
          end;
          break;
        end;
      end;
      if y=0 then begin
        New(PSaldos);
        PSaldos.unidade:=unidade;
        PSaldos.produto:=produto;
        PSaldos.qtderem:=0;
        PSaldos.qtdedev:=0;
        PSaldos.saldo:=0;
        PSaldos.qtderemret:=0;
        PSaldos.qtdedevret:=0;
        PSaldos.saldoret:=0;
        if pos(tipomov,tiposremessa)>0 then begin
            PSaldos.qtderemret:=PSaldos.qtderemret+qtde;
            PSaldos.saldoret:=PSaldos.saldoret+qtde;
            if retro='N' then begin
               Psaldos.saldo:=Psaldos.saldo+qtde;
            end else begin
               Psaldos.saldo:=Psaldos.saldo-qtde;
            end;
        end else begin
            PSaldos.qtdedevret:=PSaldos.qtdedevret+qtde;
            PSaldos.saldoret:=PSaldos.saldoret-qtde;
            if retro='N' then begin
              Psaldos.saldo:=Psaldos.saldo+qtde;
            end else begin
              Psaldos.saldo:=Psaldos.saldo-qtde;
            end;
        end;
        ListaSaldos.add(PSaldos);
      end;
    end;




begin

  with FRelEstoque do begin

    if not FRelEstoque_Execute(4) then Exit;
    if not FGEral.Validamesano(EdMesano.text) then exit;

    Sistema.BeginProcess('Gerando Relatório');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';

//    if EdCodtipo.isempty then
//    else begin
//      if Edtipocad.text='R' then
//        sqlcodtipo:=' and move_repr_codigo='+EdCodtipo.assql
//      else
//        sqlcodtipo:=' and move_tipo_codigo='+EdCodtipo.assql;
//    end;

    sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca+';'+Global.CodVendaTransf,'C');
    statusretro:='D';

    ListaSaldos:=TList.create;
    Sistema.BeginProcess('Pesquisando remessas e devoluções em aberto');
    Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc and moes_status=move_status)'+
                  ' where move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  ' and '+FGeral.Getin('move_status','N,E','C')+
//                  ' and '+FGeral.Getin('move_tipomov',tiposmov,'C')+
                ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_datalcto' );
//                ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_transacao' );
//                ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_numerodoc' );

    if Q.Eof then begin
      Avisoerro('Nada encontrado para impressão');
      Q.close;
      Freeandnil(Q);
      Sistema.endprocess('');
    end;

    tiposremessa:=Global.CodRemessaConsig+';'+Global.CodVendaTransf;
    Sistema.BeginProcess('Calculando saldo atual em aberto ');
    while not Q.eof  do begin
      Atualiza(Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_esto_codigo').asstring,
               Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_qtde').ascurrency);
      Q.Next;
    end;

    Sistema.BeginProcess('Pesquisando retroativo remessas e devoluções já fechadas até '+EdMesano.text);
    Q.Close;
    Datafinal:=Datetoultimodiames(texttodate('01'+EdMesano.text));
    Q:=sqltoquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc and moes_status=move_status)'+
                  ' where move_datamvto>'+Datetosql(Datafinal)+' and move_datamvto<='+EdDataf.assql+
                  sqlunidade+
                  sqltipomovto+
                  ' and '+FGeral.Getin('move_status',statusretro,'C')+
                ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_datalcto' );


    Sistema.BeginProcess('Calculando saldo retroativo a '+EdMesano.text);
    while not Q.eof  do begin
      AtualizaRetro(Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_esto_codigo').asstring,
               Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_qtde').ascurrency,'N','R');
      Q.Next;
    end;

    FRel.Init('RelInventarioConsignado');
      FRel.AddTit('Inventário EM EXPERIENCIA - VALORES TEM TESTE - Ninja do Estoque Consignado Referente a '+EdMesano.text);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 80,0,'C','' ,''              ,'Cod.Prod'        ,''         ,'',False);
      FRel.AddCol(130,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Remessa'         ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Devolvida'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Rem.-Dev.'            ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Saldo Produto'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Remessa Ret'     ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Devolvida Ret'   ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Rem.-Dev. Ret'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Saldo Produto Ret'    ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Remessa Tot'     ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Devolvida Tot'   ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Rem.-Dev. Tot'        ,''         ,'',False);

      for p:=0 to ListaSaldos.count-1  do begin
              PSaldos:=ListaSaldos[p];
              FRel.AddCel(PSaldos.unidade);
              FRel.AddCel(PSaldos.produto);
              FRel.AddCel(FEstoque.GetDescricao(Psaldos.produto));
              FRel.AddCel(transform(Psaldos.qtderem,f_cr));
              FRel.AddCel(transform(Psaldos.qtdedev,f_cr));
              FRel.AddCel(transform(Psaldos.qtderem-Psaldos.qtdedev,f_cr));
              FRel.AddCel(transform(Psaldos.saldo,f_cr));
              FRel.AddCel(transform(Psaldos.qtderemret,f_cr));
              FRel.AddCel(transform(Psaldos.qtdedevret,f_cr));
              FRel.AddCel(transform(Psaldos.qtderemret-Psaldos.qtdedevret,f_cr));
              FRel.AddCel(transform(Psaldos.saldoret,f_cr));
              FRel.AddCel(transform(Psaldos.qtderem-Psaldos.qtderemret,f_cr));
              FRel.AddCel(transform(Psaldos.qtdedev+Psaldos.qtdedevret,f_cr));
              FRel.AddCel(transform((Psaldos.qtderem-Psaldos.qtderemret)-(Psaldos.qtdedev+Psaldos.qtdedevret),f_cr));
//              FRel.AddCel(transform(vlrremessa,f_cr));
              Q.Next;
      end;
      FRel.Video;

    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;

end;
/////////////////////////////////////////////////////////////////////////////////////////////////////
// PEGA O SALDO ATUAL IGUAL RELAT. DE POSICAO EM ABERTO E 'VOLTA PRA TRAS'





procedure TFRelEstoque.EdestcalculadoValidate(Sender: TObject);
begin
  if EdEstCalculado.enabled then begin
     if Edestcalculado.text='S' then
       EdMesano.enabled:=true
     else if Edestcalculado.text='N' then begin
       EdMesano.enabled:=false;
       EdMesano.text:='';
     end;
  end;
end;


procedure FRelEstoque_Inventario;        // 5
//////////////////////////////////////
type TCusto=record
     esto_codigo,estimado:string;
     custo,customedio,custoger,customeger,venda:currency;
end;

var Q,QCusto,QGrades:TSqlquery;
    QDevConsig,QCustoGer:TMemoryQuery;
    produto,unidade,tiporemessa,mes,ano,devolucoes,sqlgradeproduto,
    tittamanhos,sqlgruposnao:string;
    vlrcusto,vlrcustomedio,vlrcustoger,vlrcustomeger,saldoqtde,qtderemessa,
    custouni ,custogeruni,customegeruni,venda,vlrvenda,vlrvendaprev,
    vlrprocesso:currency;
    cor,tamanho:integer;
    PCusto:^TCusto;
    Listacusto:Tlist;
    Datacustos:TDatetime;
    ListaGrades:TStringlist;
    customediouni:extended;



    function GetCusto(codigo,qcusto:string;tamanho:integer=0;cor:integer=0):currency;
    //////////////////////////////////////////////////////////////////////
    var p:integer; found:boolean;
    begin
        result:=0; found:=false;
        for p:=0 to Listacusto.count-1 do begin
          PCusto:=Listacusto[p];
          if Pcusto.esto_codigo=codigo then begin
            found:=true;
            if qcusto='uni' then begin
               result:=PCusto.custo
            end else if qcusto='medio' then begin
               if Pcusto.customedio=0 then
                 result:=FEstoque.GetCustozerado(codigo,'C')
               else
                 result:=Pcusto.customedio;
            end else if qcusto='ger' then begin
               if Pcusto.custoger=0 then
                 result:=FEstoque.GetCustozerado(codigo,'G')
               else
                 result:=Pcusto.customeger
            end else if qcusto='merger' then begin
               if Pcusto.customeger=0 then
                 result:=FEstoque.GetCustozerado(codigo,'G')
               else
                 result:=Pcusto.customeger;
            end;
            break;
          end;
        end;

      if not found then begin  // para o caso e nao ter o codigo da 999
        if qcusto='medio' then
           result:=FEstoque.GetCustozerado(codigo,'C')
        else
           result:=FEstoque.GetCustozerado(codigo,'G');
      end;
// 12.06.14 - vivan
      if (Global.topicos[1362]) and (result=0) then begin
        if qcusto='uni' then
           result:=FEstoque.GetCusto(codigo,FRelestoque.EdUnidcusto.text,'custo')
        else
           result:=FEstoque.GetCusto(codigo,FRelestoque.EdUnidcusto.text,'medio');
        found:=true;
      end;

    end;

    function GetQtdeDev(produto:string):currency;
    //////////////////////////////////////////////////
    var medioger:currency;
    begin
      result:=0;
      QDevConsig.first;medioger:=0;
      while not QDevConsig.eof do begin
        if QDevConsig.fieldbyname('move_esto_codigo').asstring=produto then begin
            result:=QDevConsig.fieldbyname('qtde').asfloat;
            break;
        end;
        QDevConsig.next;
      end;
    end;

    function GetCustoGer(produto:string):currency;
    ///////////////////////////////////////////////
    var medioger:currency;
    begin
      result:=0;
      QCustoGer.first;medioger:=0;
      while not QCustoGer.eof do begin
        if QCustoGer.fieldbyname('move_esto_codigo').asstring=produto then begin
           medioger:=QCustoGer.fieldbyname('customeger').asfloat;
           break;
        end;
        QCustoGer.next;
      end;
      result:=medioger;
    end;

    // 02.05.08
    function Temgrade(codigo:string):boolean;
    //////////////////////////////////////////
    var i:integer;
    begin
      result:=false;
      for i:=0 to LIstaGrades.Count-1 do begin
        if codigo=LIstaGrades[i] then begin
          result:=true;
          break;
        end;
      end;

    end;

begin

  devolucoes:=Global.CodDevolucaoConsig+';'+Global.CodDevolucaoSerie5+';'+Global.CodDevolucaoProntaEntrega;

  with FRelEstoque do begin

    if not FRelEstoque_Execute(5) then Exit;
    if Global.Usuario.OutrosAcessos[0010] then
      sqlqtde:=' and saes_qtdeprev<>0'
    else
      sqlqtde:=' and saes_qtde<>0';
// 20.10.09
    if cQtdeprocesso='S' then begin
      if Global.Usuario.OutrosAcessos[0010] then
//        sqlqtde:=' and (saes_qtdeprev+saes_qtdeprocesso)<>0'
// 18.09.13
        sqlqtde:=' and ( (saes_qtdeprev<>0) or (saes_qtdeprocesso<>0) ) '
      else
//        sqlqtde:=' and (saes_qtde+saes_qtdeprocesso)<>0';
// 18.09.13
        sqlqtde:=' and ( (saes_qtde<>0) or (saes_qtdeprocesso<>0) ) ';
    end;

    if not EdUnidcusto.isempty then begin
      Sistema.beginprocess('Armazenando custo da unidade '+EdUnidcusto.text);
      Qcusto:=sqltoquery('select * from salestoque inner join estoque on ( esto_codigo=saes_esto_codigo )'+
                  ' where saes_mesano='+stringtosql(FGeral.Anomesinvertido(EdMesano.text))+
                  ' and saes_unid_codigo='+EdUnidcusto.assql+
                  sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+   //   sqlqtde+ - 04.11.05 - retirado a qtde -> produto sem custo
                  sqltamanhos+
                  ' and '+FGeral.Getin('saes_status','N','C')+
                  ' order by saes_unid_codigo,saes_esto_codigo,saes_tama_codigo,saes_core_codigo' );
      ListaCusto:=Tlist.create;
      while not QCusto.eof do begin

        New(Pcusto);
        Sistema.beginprocess('Armazenando custo da unidade '+EdUnidcusto.text+' codigo '+Qcusto.fieldbyname('saes_esto_codigo').asstring);
        Pcusto.esto_codigo:=Qcusto.fieldbyname('saes_esto_codigo').asstring;
        Pcusto.custo:=Qcusto.fieldbyname('saes_custo').ascurrency;
        Pcusto.customedio:=Qcusto.fieldbyname('saes_customedio').ascurrency;
        Pcusto.custoger:=Qcusto.fieldbyname('saes_custoger').ascurrency;
        Pcusto.customeger:=Qcusto.fieldbyname('saes_customeger').ascurrency;
        ListaCusto.add(Pcusto);
        QCusto.next;

      end;

      Qcusto.close;
      Freeandnil(Qcusto);
      Sistema.endprocess('');
    end;
// 02.05.08
    sqlgradeproduto:='';
    if not FRelEstoque.EdEsto_codigo.isempty then
      sqlgradeproduto:=' and '+FGeral.getin('esgr_esto_codigo',FRelEstoque.EdEsto_codigo.text,'C');
    Sistema.BeginProcess('Armazenando grades da unidade ');
    QGrades:=sqltoquery('select esgr_esto_codigo from estgrades where esgr_status=''N'' and '+FGeral.GetIN('esgr_unid_codigo',EdUnid_codigo.text,'C')+
                         sqlgradeproduto );
    ListaGrades:=TStringlist.create;
    while not QGrades.eof do begin
      if LIstaGrades.indexof(QGrades.fieldbyname('esgr_esto_codigo').asstring)=-1 then
        ListaGrades.Add(QGrades.fieldbyname('esgr_esto_codigo').asstring);
      QGRades.Next;
    end;
    FGEral.FechaQuery(QGrades);
    Sistema.BeginProcess('Gerando Relatório');
    if not FRelEstoque.EdUnid_codigo.isempty then
      sqlunidade:=' and '+FGeral.getin('saes_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
   tittamanhos:='';
   if not EdTamanhos.IsEmpty then
     tittamanhos:=' - Codigos de Tamanhos escolhidos : '+edTamanhos.Text;
// 12.02.20 - Seip Brasil
   sqlgruposNao:='';
   if trim(FGeral.getconfig1asstring('GRUPOSNAOINV')) <> ''  then
      sqlgruposNao:=' and '+FGeral.GetNOTIN('esto_grup_codigo',FGeral.getconfig1asstring('GRUPOSNAOINV'),'N');

   Q:=sqltoquery('select * from salestoque '+
                  ' inner join estoque on (esto_codigo=saes_esto_codigo) '+
                  ' inner join grupos on (grup_codigo=esto_grup_codigo) '+
// 02.05.08
//                  ' left  join estgrades on (esgr_esto_codigo=saes_esto_codigo and saes_status=''N'' and esgr_unid_codigo=saes_unid_codigo)'+
                  ' left join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
                  ' left join familias on (fami_codigo=esto_fami_codigo) '+
                  ' left join tamanhos on (tama_codigo=saes_tama_codigo) '+
                  ' left join cores    on (core_codigo=saes_core_codigo) '+
                  ' left join copas    on (copa_codigo=saes_copa_codigo) '+
                  ' left join codigosipi on (cipi_codigo=esto_cipi_codigo) '+
                  ' where saes_mesano='+stringtosql(FGeral.Anomesinvertido(FRelEstoque.EdMesano.text))+
                  sqlunidade+sqlgruposnao+
                  sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+sqlqtde+sqltamanhos+
                  ' and '+FGeral.Getin('saes_status','N','C')+
                   ' order by saes_unid_codigo,saes_esto_codigo,saes_tama_codigo,saes_core_codigo' );

    if Q.Eof then

      Avisoerro('Nada encontrado para impressão')

    else begin

      FRel.Init('RelInventario');
      FRel.AddTit('Inventário Final de Estoque do mes de '+copy(FRelEstoque.EdMesano.text,1,2)+'/'+copy(FRelEstoque.EdMesano.text,3,4));
      FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text)+tittamanhos);
      if not EdUnidcusto.isempty then
        FRel.AddTit('Custos da Unidade '+EdUnidcusto.Text+' - '+EdUnidcusto.resultfind.fieldbyname('unid_nome').asstring );
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Grupo'           ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Grupo'     ,''         ,'',false);
      FRel.AddCol( 80,0,'N','' ,''              ,'Cod.Prod'        ,''         ,'',False);
      FRel.AddCol(150,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
// 08.03.16
      FRel.AddCol(090,1,'C','' ,''              ,'NCM'          ,''         ,'',False);
      if Global.Topicos[1211] then
        FRel.AddCol( 60,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False)
      else
        FRel.AddCol( 60,1,'N','' ,''              ,'Tamanho'         ,''         ,'',False);
      FRel.AddCol( 90,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
//      FRel.AddCol( 40,1,'C','' ,''              ,'Copa'             ,''         ,'',False);
      if cqtdeprocesso='S' then begin
        FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Processo'        ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Médio Processo'        ,''         ,'',False);
      end;
      FRel.AddCol( 80,3,'N','+' ,''             ,'Saldo Produto'        ,''         ,'',False);
      FRel.AddCol(100,3,'N','+' ,''              ,'Custo(último compra)'          ,''         ,'',False);
      FRel.AddCol( 80,3,'N','' ,''              ,'Custo Médio'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',''              ,'Total Médio'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',''              ,'Venda'             ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',''              ,'Total Venda'       ,''         ,'',False);
      if Global.Usuario.OutrosAcessos[0010] then begin
        FRel.AddCol( 80,3,'N','+' ,''             ,'Saldo Previsto'        ,''         ,'',False);
        FRel.AddCol(100,3,'N','' ,''              ,'Custo Previsto Médio'       ,''         ,'',False);
        FRel.AddCol(100,3,'N','+',''              ,'Total Previsto Médio'    ,''         ,'',False);
        FRel.AddCol(100,3,'N','+',''              ,'Total Venda Previsto'   ,''         ,'',False);
//        FRel.AddCol( 80,3,'N','+',''              ,'Custo Gerencial'    ,''         ,'',False);
//        FRel.AddCol(100,3,'N','+',''              ,'Total Previsto Ger',''         ,'',False);
      end;
      if FGeral.UsuarioTeste(Global.Usuario.Codigo) then begin
        FRel.AddCol( 80,3,'N','+',''              ,'Qtde Consignado'      ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+',''              ,'Custo Consignado'      ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+',''              ,'Qtde Pronta Entrega'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+',''              ,'Custo Pronta Entrega'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+',''              ,'Qtde Reg.Esp.SC'     ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+',''              ,'Custo Reg.Esp.SC'     ,''         ,'',False);
      end;
      mes:=copy(EdMesano.text,1,2);
      ano:=copy(EdMesano.text,3,4);
      datacustos:=texttodate('01'+EdMesano.text)-1;

      while not Q.eof  do begin
//         if ( (Q.FieldByName('esto_grad_codigo').asinteger>0) and (Q.fieldbyname('saes_tama_codigo').asinteger>0) or
         if ( (Q.fieldbyname('saes_tama_codigo').asinteger>0) or
            (Q.fieldbyname('saes_core_codigo').asinteger>0)  ) OR (
//            (Q.FieldByName('esto_grad_codigo').asinteger=0) and (Q.fieldbyname('saes_tama_codigo').asinteger=0) and
            (Q.fieldbyname('saes_tama_codigo').asinteger=0) and
            (Q.fieldbyname('saes_core_codigo').asinteger=0)  )
//            (Q.fieldbyname('saes_core_codigo').asinteger=0) and not Temgrade(Q.fieldbyname('saes_esto_codigo').asstring) )
            then begin
            produto:=Q.fieldbyname('saes_esto_codigo').asstring;
            unidade:=Q.fieldbyname('saes_unid_codigo').asstring;
            tamanho:=Q.fieldbyname('saes_tama_codigo').asinteger;
            cor:=Q.fieldbyname('saes_core_codigo').asinteger;
            custouni:=Q.fieldbyname('saes_custo').ascurrency;
//            customediouni:=Q.fieldbyname('saes_customedio').ascurrency;
// 04.01.19
            customediouni:=Q.fieldbyname('saes_customedio').asfloat;
            custogeruni:=Q.fieldbyname('saes_custoger').ascurrency;
            customegeruni:=Q.fieldbyname('saes_customeger').ascurrency;
            venda:=Q.fieldbyname('saes_vendavis').ascurrency;
            if not EdUnidcusto.isempty then begin
              custouni:=GetCusto(produto,'uni',tamanho,cor);
              customediouni:=GetCusto(produto,'medio',tamanho,cor);
              custogeruni:=GetCusto(produto,'ger',tamanho,cor);
              customegeruni:=GetCusto(produto,'merger',tamanho,cor);
              venda:=FEstoque.GetPreco(produto,unidade);
            end;
            FRel.AddCel(unidade);
            FRel.AddCel(Q.FieldByName('esto_grup_codigo').AsString);
            FRel.AddCel(Q.FieldByName('grup_descricao').AsString);
            FRel.AddCel(produto);
            FRel.AddCel(FEstoque.GetDescricao(produto));
            FRel.AddCel(Q.FieldByName('cipi_codfiscal').AsString);
            FRel.AddCel(Q.FieldByName('tama_descricao').AsString);
            FRel.AddCel(Q.FieldByName('core_descricao').AsString);
//            FRel.AddCel(Q.FieldByName('copa_descricao').AsString);
            if cqtdeprocesso='S' then begin
              FRel.AddCel(transform(Q.fieldbyname('saes_qtdeprocesso').ascurrency,f_cr));
              vlrprocesso:=(Q.fieldbyname('saes_qtdeprocesso').ascurrency*customediouni);
              FRel.AddCel(transform(vlrprocesso,f_cr));
            end;
            vlrcusto:=(Q.fieldbyname('saes_qtde').ascurrency*custouni);
            vlrcustoger:=(Q.fieldbyname('saes_qtdeprev').ascurrency*custogeruni);
            vlrcustomedio:=(Q.fieldbyname('saes_qtde').ascurrency*customediouni);
            vlrcustomeger:=(Q.fieldbyname('saes_qtdeprev').ascurrency*customegeruni);
            vlrvenda:=(Q.fieldbyname('saes_qtde').ascurrency*venda);
            vlrvendaprev:=(Q.fieldbyname('saes_qtdeprev').ascurrency*venda);
            FRel.AddCel(transform(Q.fieldbyname('saes_qtde').ascurrency,f_cr));
            FRel.AddCel(transform(vlrcusto,f_cr4));
            FRel.AddCel(transform(customediouni,f_cr5));
            FRel.AddCel(transform(vlrcustomedio,f_cr));
            FRel.AddCel(transform(venda,f_cr));
            FRel.AddCel(transform(vlrvenda,f_cr));
            if Global.Usuario.OutrosAcessos[0010] then begin
               FRel.AddCel(transform(Q.fieldbyname('saes_qtdeprev').ascurrency,f_cr));
               FRel.AddCel(transform(customegeruni,f_cr));
               FRel.AddCel(transform(vlrcustomeger,f_cr));
               FRel.AddCel(transform(vlrvendaprev,f_cr));
//               FRel.AddCel(transform(custogeruni,f_cr));
//               FRel.AddCel(transform(vlrcustoger,f_cr));
            end;
{
            if FGeral.UsuarioTeste(Global.Usuario.Codigo) then begin
              FRel.AddCel(transform(Q.fieldbyname('saes_qtdeconsig').ascurrency,f_cr));
              FRel.AddCel(transform(Q.fieldbyname('saes_qtdeconsig').ascurrency*customegeruni,f_cr));
              FRel.AddCel(transform(Q.fieldbyname('saes_qtdepronta').ascurrency,f_cr));
              FRel.AddCel(transform(Q.fieldbyname('saes_qtdepronta').ascurrency*customegeruni,f_cr));
              FRel.AddCel(transform(Q.fieldbyname('saes_qtderegesp').ascurrency,f_cr));
              FRel.AddCel(transform(Q.fieldbyname('saes_qtderegesp').ascurrency*customegeruni,f_cr));
            end;
}
         end;
         Q.next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;

  FRelEstoque_Inventario;        // 5

end;



procedure TFRelEstoque.EdUnidcustoExitEdit(Sender: TObject);
begin
   baplicarclick(FRelEstoque);
end;

procedure TFRelEstoque.EdUnidcustoKeyPress(Sender: TObject; var Key: Char);
begin
  FGeral.Limpaedit(FRelEstoque.EdUNidcusto,key);

end;



procedure FRelEstoque_ExtratoSintetico;         // 6
///////////////////////////////////////////////////////////

type TTiposQTde=record
  tipomov:string;
  qtde:currency;
end;

type TMovimento=record
     moes_unidade,move_esto_codigo,tipomov01,tipomov02,tipomov03,tipomov04,tipomov05,tipomov06,tipomov07,tipomov08,
     tipomov09,tipomov10,tipomov11,tipomov12,tipomov13,tipomov14,tipomov15,tipomov16,tipomov17,tipomov18,tipomov19,
     tipomov20,tipomov21,tipomov22,tipomov23,tipomov24,tipomov25,tipomov26,tipomov27,tipomov28,tipomov29,tipomov30:string;
     qtde01,qtde02,qtde03,qtde04,qtde05,qtde06,qtde07,qtde08,qtde09,qtde10,qtde11,qtde12,qtde13,qtde14,qtde15,saldoant,qtde16,qtde17,qtde18,qtde19,qtde20,
     qtde21,qtde22,qtde23,qtde24,qtde25,qtde26,qtde27,qtde28,qtde29,qtde30:currency;
     ListaTipos:Tlist;
     PTiposQtde:^TTiposQTde;
end;


var unidade,produto,op,sqlinicio,nome,sqlprodutox:string;
    saldoanterior,saldo,pentradas,psaidas,psemmov,tentradas,tsaidas,tsemmov,salantpecas:currency;
    margem,p,y:integer;
    QBusca,QEstqtde,QMov:TSqlquery;
    ListaMov:Tlist;
    PMOvimento:^TMovimento;
    jatemtipo:boolean;
    ListaTiposGeral:Tstringlist;


    procedure AtualizaSAldoanterior(saldo:currency ; unidade,produto:string);
    var jatem:boolean;
        x,y:integer;
    begin
      jatem:=false;
      for x:=0 to LIstamov.count-1 do begin
        PMovimento:=Listamov[x];
        if ( Pmovimento.moes_unidade=unidade ) and
           ( PMovimento.move_esto_codigo=produto ) then begin
          jatem:=true;
          break;
        end;
      end;
      if not jatem then begin
        New(PMovimento);
        PMovimento.moes_unidade:=unidade;
        PMovimento.move_esto_codigo:=produto;
{
            PMovimento.tipomov01:=global.CodVendaDireta;
            PMovimento.tipomov02:=global.CodVendaBrinde;
            PMovimento.tipomov03:=global.CodCompra100;
            PMovimento.tipomov04:=global.CodCompraProdutor;
            PMovimento.tipomov05:=global.CodCompraSemfinan;
            PMovimento.tipomov06:=global.CodDevolucaoCompra;
            PMovimento.tipomov07:=global.CodDevolucaoIgualVenda;
            PMovimento.tipomov08:=global.CodDevolucaoVenda;
            PMovimento.tipomov09:=global.CodBaixaMatEnt;
            PMovimento.tipomov10:=global.CodBaixaMatSai;
            PMovimento.tipomov11:=global.CodDevolucaoTroca;
            PMovimento.tipomov12:=global.CodDevolucaoVenda;
}

            PMovimento.tipomov01:=global.CodRemessaConsig;
            PMovimento.tipomov02:=global.CodRemessaProntaEntrega;
            PMovimento.tipomov03:=global.CodVendaConsig;
            PMovimento.tipomov04:=global.CodVendaDireta;
            PMovimento.tipomov05:=global.CodVendaProntaEntrega;
            PMovimento.tipomov06:=global.CodVendaMagazine;
            PMovimento.tipomov07:=global.CodVendaBrinde;
            PMovimento.tipomov08:=global.CodVendaTransf;
            PMovimento.tipomov09:=global.CodDevolucaoConsig;
            PMovimento.tipomov10:=global.CodDevolucaoProntaEntrega;
            PMovimento.tipomov11:=global.CodDevolucaoTroca;
            PMovimento.tipomov12:=global.CodDevolucaoVenda;
/////////////}
            PMovimento.tipomov13:=global.CodDevolucaoConsigMerc;
            PMovimento.tipomov14:=global.CodAcertoEsEnt;
            PMovimento.tipomov15:=global.CodAcertoEsSai;
            PMovimento.tipomov16:=global.CodTransfEntrada;
            PMovimento.tipomov17:=global.CodTransfSaida;
            PMovimento.tipomov18:=global.CodVendaProntaEntregaFecha;
            PMovimento.tipomov19:=global.CodRetornoMostruario;
            PMovimento.tipomov20:=global.CodCompra100;
            PMovimento.tipomov21:=global.CodVendaMostruario;
            PMovimento.tipomov22:=Global.CodConsigMercantil;
// 30.08.05
            PMovimento.tipomov23:=Global.CodVendaSerie4;
            PMovimento.tipomov24:=Global.CodDevolucaoSerie5;
            PMovimento.tipomov25:=Global.CodVendaRE;
            PMovimento.tipomov26:=Global.CodVendaREFinal;
            PMovimento.tipomov27:=Global.CodContagemBalancoE;
            PMovimento.tipomov28:=Global.CodContagemBalancoS;

        Pmovimento.qtde01:=0;Pmovimento.qtde02:=0;Pmovimento.qtde03:=0;Pmovimento.qtde04:=0;Pmovimento.qtde05:=0;
        Pmovimento.qtde06:=0;Pmovimento.qtde07:=0;Pmovimento.qtde08:=0;Pmovimento.qtde09:=0;Pmovimento.qtde10:=0;
        Pmovimento.qtde11:=0;Pmovimento.qtde12:=0;Pmovimento.qtde13:=0;Pmovimento.qtde14:=0;Pmovimento.qtde15:=0;
        Pmovimento.qtde16:=0;Pmovimento.qtde17:=0;Pmovimento.qtde18:=0;Pmovimento.qtde19:=0;Pmovimento.qtde20:=0;
        Pmovimento.qtde21:=0;Pmovimento.qtde22:=0;Pmovimento.qtde23:=0;Pmovimento.qtde24:=0;Pmovimento.qtde25:=0;
        Pmovimento.qtde26:=0;Pmovimento.qtde27:=0;Pmovimento.qtde28:=0;Pmovimento.qtde29:=0;Pmovimento.qtde30:=0;
        PMovimento.saldoant:=saldo;
          PMovimento.ListaTipos:=TList.create;
          for y:=0 to ListaTiposGeral.count-1 do begin
            New(PMovimento.PTiposQtde);
            PMovimento.PTiposQtde.tipomov:=ListaTiposGeral[y];
            PMovimento.PTiposQtde.qtde:=0;
            PMovimento.ListaTipos.add(PMovimento.PTiposQtde);
          end;

        Listamov.add(Pmovimento);

      end else begin

        PMovimento:=Listamov[x];
        PMovimento.saldoant:=saldo;
///////////////////////
        if PMovimento.ListaTipos=nil then begin
          PMovimento.ListaTipos:=TList.create;
          for y:=0 to ListaTiposGeral.count-1 do begin
            New(PMovimento.PTiposQtde);
            PMovimento.PTiposQtde.tipomov:=ListaTiposGeral[y];
            PMovimento.PTiposQtde.qtde:=0;
            PMovimento.ListaTipos.add(PMovimento.PTiposQtde);
          end;
        end;
/////////////////////////
      end;

//      for y:=0 to Pmovimento.ListaTipos.Count-1 do begin
//        PMovimento.PTiposQtde:=Pmovimento.ListaTipos[y];
//        showmessage('produto '+Pmovimento.move_esto_codigo+' '+Pmovimento.ptiposqtde.tipomov );
//      end;


    end;

    procedure AtualizaLista;
    //////////////////////////
    var x:integer;
        jatem:boolean;

        procedure Somatipomov(tipomov:string;qtde:currency);
        var i:integer;
        begin
          if tipomov=global.CodRemessaConsig then begin
            PMovimento.tipomov01:=global.CodRemessaConsig;
            PMovimento.qtde01:=PMovimento.qtde01+qtde;
          end else if tipomov=global.CodRemessaProntaEntrega then begin
            PMovimento.tipomov02:=global.CodRemessaProntaEntrega;
            PMovimento.qtde02:=PMovimento.qtde02+qtde;
          end else if tipomov=global.CodVendaConsig then begin
            PMovimento.tipomov03:=global.CodVendaConsig;
            PMovimento.qtde03:=PMovimento.qtde03+qtde;
          end else if tipomov=global.CodVendaDireta then begin
            PMovimento.tipomov04:=global.CodVendaDireta;
            PMovimento.qtde04:=PMovimento.qtde04+qtde;
          end else if tipomov=global.CodVendaProntaEntrega then begin
            PMovimento.tipomov05:=global.CodVendaProntaEntrega;
            PMovimento.qtde05:=PMovimento.qtde05+qtde;
          end else if tipomov=global.CodVendaMagazine then begin
            PMovimento.tipomov06:=global.CodVendaMagazine;
            PMovimento.qtde06:=PMovimento.qtde06+qtde;
          end else if tipomov=global.CodVendaBrinde then begin
            PMovimento.tipomov07:=global.CodVendaBrinde;
            PMovimento.qtde07:=PMovimento.qtde07+qtde;
          end else if tipomov=global.CodVendaTransf then begin
            PMovimento.tipomov08:=global.CodVendaTransf;
            PMovimento.qtde08:=PMovimento.qtde08+qtde;
          end else if tipomov=global.CodDevolucaoConsig then begin
            PMovimento.tipomov09:=global.CodDevolucaoConsig;
            PMovimento.qtde09:=PMovimento.qtde09+qtde;
          end else if tipomov=global.CodDevolucaoProntaEntrega then begin
            PMovimento.tipomov10:=global.CodDevolucaoProntaEntrega;
            PMovimento.qtde10:=PMovimento.qtde10+qtde;
          end else if tipomov=global.CodDevolucaoTroca then begin
            PMovimento.tipomov11:=global.CodDevolucaoTroca;
            PMovimento.qtde11:=PMovimento.qtde11+qtde;
          end else if tipomov=global.CodDevolucaoVenda then begin
            PMovimento.tipomov12:=global.CodDevolucaoVenda;
            PMovimento.qtde12:=PMovimento.qtde12+qtde;
          end else if tipomov=global.CodDevolucaoConsigMerc then begin
            PMovimento.tipomov13:=global.CodDevolucaoConsigMerc;
            PMovimento.qtde13:=PMovimento.qtde13+qtde;
          end else if tipomov=global.CodAcertoEsEnt then begin
            PMovimento.tipomov14:=global.CodAcertoEsEnt;
            PMovimento.qtde14:=PMovimento.qtde14+qtde;
          end else if tipomov=global.CodAcertoEsSai then begin
            PMovimento.tipomov15:=global.CodAcertoEsSai;
            PMovimento.qtde15:=PMovimento.qtde15+qtde;
          end else if tipomov=global.CodTransfEntrada then begin
            PMovimento.tipomov16:=global.CodTransfEntrada;
            PMovimento.qtde16:=PMovimento.qtde16+qtde;
          end else if tipomov=global.CodTransfSaida then begin
            PMovimento.tipomov17:=global.CodTransfSaida;
            PMovimento.qtde17:=PMovimento.qtde17+qtde;
          end else if tipomov=global.CodVendaProntaEntregaFecha then begin
            PMovimento.tipomov18:=global.CodVendaProntaEntregaFecha;
            PMovimento.qtde18:=PMovimento.qtde18+qtde;
          end else if tipomov=global.CodRetornoMostruario then begin
            PMovimento.qtde19:=PMovimento.qtde19+qtde;
            PMovimento.tipomov19:=global.CodRetornoMostruario;
          end else if tipomov=global.CodCompra100 then begin
            PMovimento.qtde20:=PMovimento.qtde20+qtde;
            PMovimento.tipomov20:=global.CodCompra100;
          end else if tipomov=global.CodVendaMostruario then begin
            PMovimento.qtde21:=PMovimento.qtde21+qtde;
            PMovimento.tipomov21:=global.CodVendaMostruario;
          end else if tipomov=global.CodConsigMercantil then begin
            PMovimento.qtde22:=PMovimento.qtde22+qtde;
            PMovimento.tipomov22:=global.CodConsigMercantil;
          end else if tipomov=global.CodVendaSerie4 then begin
            PMovimento.qtde23:=PMovimento.qtde23+qtde;
            PMovimento.tipomov23:=global.CodVendaSerie4;
          end else if tipomov=global.CodDevolucaoSerie5 then begin
            PMovimento.qtde24:=PMovimento.qtde24+qtde;
            PMovimento.tipomov24:=global.CodDevolucaoSerie5;
          end else if tipomov=global.CodVendaRE then begin
            PMovimento.qtde25:=PMovimento.qtde25+qtde;
            PMovimento.tipomov25:=global.CodVendaRE;
          end else if tipomov=global.CodVendaREFinal then begin
            PMovimento.qtde26:=PMovimento.qtde26+qtde;
            PMovimento.tipomov26:=global.CodVendaREFinal;
          end else if tipomov=global.CodContagemBalancoE then begin
            PMovimento.qtde27:=PMovimento.qtde27+qtde;
            PMovimento.tipomov27:=global.CodContagemBalancoE;
          end else if tipomov=global.CodContagemBalancoS then begin
            PMovimento.qtde28:=PMovimento.qtde28+qtde;
            PMovimento.tipomov28:=global.CodContagemBalancoS;
          end else if tipomov=global.CodBaixaMatSai then begin
            PMovimento.qtde29:=PMovimento.qtde29+qtde;
            PMovimento.tipomov29:=global.CodBaixaMatSai;
          end else begin
            PMovimento.tipomov30:='XX'+tipomov;
            PMovimento.qtde30:=PMovimento.qtde30+qtde;
          end;
// 05.12.07
////////////////////////////////////////////////////
            for i:=0 to PMovimento.ListaTipos.Count-1 do begin
              PMovimento.PTiposqtde:=PMovimento.ListaTipos[i];
              if PMovimento.PTiposqtde.tipomov=tipomov then begin
                PMovimento.PTiposqtde.qtde:=PMovimento.PTiposqtde.qtde+qtde;
                break;
              end;
            end;
////////////////////////////////////////////////////
        end;

    begin

      jatem:=false;
      for x:=0 to LIstamov.count-1 do begin
        PMovimento:=Listamov[x];
        if ( Pmovimento.moes_unidade=Q.fieldbyname('move_unid_codigo').asstring ) and
           ( PMovimento.move_esto_codigo=Q.fieldbyname('move_esto_codigo').asstring ) then begin
          jatem:=true;
          break;
        end;
      end;
      if not jatem then begin
        New(PMovimento);
        PMovimento.moes_unidade:=Q.fieldbyname('move_unid_codigo').asstring;
        PMovimento.move_esto_codigo:=Q.fieldbyname('move_esto_codigo').asstring;
        Pmovimento.tipomov01:='';Pmovimento.tipomov02:='';Pmovimento.tipomov03:='';Pmovimento.tipomov04:='';
        Pmovimento.tipomov05:='';Pmovimento.tipomov06:='';Pmovimento.tipomov07:='';Pmovimento.tipomov08:='';
        Pmovimento.tipomov09:='';Pmovimento.tipomov10:='';Pmovimento.tipomov11:='';Pmovimento.tipomov12:='';
        Pmovimento.tipomov13:='';Pmovimento.tipomov14:='';Pmovimento.tipomov15:='';
        Pmovimento.tipomov16:='';Pmovimento.tipomov17:='';Pmovimento.tipomov18:='';Pmovimento.tipomov19:='';
        Pmovimento.tipomov20:='';
        Pmovimento.qtde01:=0;Pmovimento.qtde02:=0;Pmovimento.qtde03:=0;Pmovimento.qtde04:=0;Pmovimento.qtde05:=0;
        Pmovimento.qtde06:=0;Pmovimento.qtde07:=0;Pmovimento.qtde08:=0;Pmovimento.qtde09:=0;Pmovimento.qtde10:=0;
        Pmovimento.qtde11:=0;Pmovimento.qtde12:=0;Pmovimento.qtde13:=0;Pmovimento.qtde14:=0;Pmovimento.qtde15:=0;
        Pmovimento.qtde16:=0;Pmovimento.qtde17:=0;Pmovimento.qtde18:=0;Pmovimento.qtde19:=0;Pmovimento.qtde20:=0;
        Pmovimento.qtde21:=0;Pmovimento.qtde22:=0;Pmovimento.qtde23:=0;Pmovimento.qtde24:=0;Pmovimento.qtde25:=0;
        Pmovimento.qtde26:=0;Pmovimento.qtde27:=0;Pmovimento.qtde28:=0;Pmovimento.qtde29:=0;Pmovimento.qtde30:=0;
//////////////////////////
        if PMovimento.ListaTipos=nil then begin
            PMovimento.ListaTipos:=TList.create;
            for x:=0 to ListaTiposGeral.count-1 do begin
              New(PMovimento.PTiposQtde);
              PMovimento.PTiposQtde.tipomov:=ListaTiposGeral[x];
              PMovimento.PTiposQtde.qtde:=0;
              PMovimento.ListaTipos.add(PMovimento.PTiposQtde);
            end;
        end;

/////////////////////////
        Listamov.add(Pmovimento);
        SomaTipomov( Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_qtde').ascurrency);

      end else begin

//      PMovimento:=Listamov[x];
        if PMovimento.ListaTipos=nil then begin
            PMovimento.ListaTipos:=TList.create;
            for x:=0 to ListaTiposGeral.count-1 do begin
              New(PMovimento.PTiposQtde);
              PMovimento.PTiposQtde.tipomov:=ListaTiposGeral[x];
              PMovimento.PTiposQtde.qtde:=0;
              PMovimento.ListaTipos.add(PMovimento.PTiposQtde);
            end;
        end;
        SomaTipomov( Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_qtde').ascurrency);

      end;
    end;


    function GetSaldo:extended;
    var op,tipos:string;
        ent,sai:currency;
        Lista:TStringlist;
        p:integer;
    begin
      ent:=0;sai:=0;
      tipos:=PMovimento.tipomov01+';'+PMovimento.tipomov02+';'+PMovimento.tipomov03+';'+PMovimento.tipomov04+';'+
             PMovimento.tipomov05+';'+PMovimento.tipomov06+';'+PMovimento.tipomov07+';'+PMovimento.tipomov08+';'+
             PMovimento.tipomov09+';'+PMovimento.tipomov10+';'+PMovimento.tipomov11+';'+PMovimento.tipomov12+';'+
             PMovimento.tipomov13+';'+PMovimento.tipomov14+';'+PMovimento.tipomov15+';'+PMovimento.tipomov16+';'+
             PMovimento.tipomov17+';'+PMovimento.tipomov18+';'+PMovimento.tipomov19+';'+PMovimento.tipomov20+';'+
             PMovimento.tipomov21+';'+PMovimento.tipomov22+';'+PMovimento.tipomov23+';'+PMovimento.tipomov24+';'+
             PMovimento.tipomov25+';'+PMovimento.tipomov26+';'+PMovimento.tipomov27+';'+PMovimento.tipomov28+';'+
             PMovimento.tipomov29+';'+PMovimento.tipomov30;
      Lista:=TStringlist.create;
      strtolista(lista,tipos,';',true);
      for p:=0 to lista.count-1 do begin
        if trim(Lista[p])<>'' then begin
          op:=FGeral.GetEntSaiTipoMovto(Lista[p]);
          if p=0 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde01
            else if op='-' then
              sai:=sai+PMovimento.qtde01;
          end else if p=1 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde02
            else if op='-' then
              sai:=sai+PMovimento.qtde02;
          end else if p=2 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde03
            else if op='-' then
              sai:=sai+PMovimento.qtde03;
          end else if p=3 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde04
            else if op='-' then
              sai:=sai+PMovimento.qtde04;
          end else if p=4 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde05
            else if op='-' then
              sai:=sai+PMovimento.qtde05;
          end else if p=5 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde06
            else if op='-' then
              sai:=sai+PMovimento.qtde06;
          end else if p=6 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde07
            else if op='-' then
              sai:=sai+PMovimento.qtde07;
          end else if p=7 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde08
            else if op='-' then
              sai:=sai+PMovimento.qtde08;
          end else if p=8 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde09
            else if op='-' then
              sai:=sai+PMovimento.qtde09;
          end else if p=9 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde10
            else if op='-' then
              sai:=sai+PMovimento.qtde10;
          end else if p=10 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde11
            else if op='-' then
              sai:=sai+PMovimento.qtde11;
          end else if p=11 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde12
            else if op='-' then
              sai:=sai+PMovimento.qtde12;
          end else if p=12 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde13
            else if op='-' then
              sai:=sai+PMovimento.qtde13;
          end else if p=13 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde14
            else if op='-' then
              sai:=sai+PMovimento.qtde14;
          end else if p=14 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde15
            else if op='-' then
              sai:=sai+PMovimento.qtde15;
          end else if p=15 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde16
            else if op='-' then
              sai:=sai+PMovimento.qtde16;
          end else if p=16 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde17
            else if op='-' then
              sai:=sai+PMovimento.qtde17;
          end else if p=17 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde18
            else if op='-' then
              sai:=sai+PMovimento.qtde18;
          end else if p=18 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde19
            else if op='-' then
              sai:=sai+PMovimento.qtde19;
          end else if p=19 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde20
            else if op='-' then
              sai:=sai+PMovimento.qtde20;
          end else if p=20 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde21
            else if op='-' then
              sai:=sai+PMovimento.qtde21;
          end else if p=21 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde22
            else if op='-' then
              sai:=sai+PMovimento.qtde22;
          end else if p=22 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde23
            else if op='-' then
              sai:=sai+PMovimento.qtde23;
          end else if p=23 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde24
            else if op='-' then
              sai:=sai+PMovimento.qtde24;
          end else if p=24 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde25
            else if op='-' then
              sai:=sai+PMovimento.qtde25;
          end else if p=25 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde26
            else if op='-' then
              sai:=sai+PMovimento.qtde26;
          end else if p=26 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde27
            else if op='-' then
              sai:=sai+PMovimento.qtde27;
          end else if p=27 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde28
            else if op='-' then
              sai:=sai+PMovimento.qtde28;
          end else if p=28 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde29
            else if op='-' then
              sai:=sai+PMovimento.qtde29;
          end else if p=29 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde30
            else if op='-' then
              sai:=sai+PMovimento.qtde30;
          end;
        end;
      end;
      result:=PMovimento.saldoant+ent-sai;
////////////////////////////
      ent:=0;sai:=0;
      for p:=0 to PMovimento.ListaTipos.count-1 do begin
              PMovimento.PTiposQTde:=PMovimento.ListaTipos[p];
              op:=FGeral.GetEntSaiTipoMovto(PMovimento.PTiposQTde.tipomov);
              if op='+' then
                ent:=ent+PMovimento.PtiposQtde.qtde
              else if op='-' then
                sai:=sai+PMovimento.PtiposQtde.qtde;
      end;
      result:=PMovimento.saldoant+ent-sai;
////////////////////////////

    end;

begin

  with FRelEstoque do begin
    if not FRelEstoque_Execute(6) then Exit;
    Sistema.BeginProcess('Pesquisando movimento');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);
    if EdEsto_codigo.AsInteger>0 then begin
       sqlinicio:=' and moes_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate));
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
       sqlprodutox:= ' and esqt_esto_codigo='+EdEsto_codigo.assql;
    end else begin
       sqlinicio:=' and moes_datamvto>='+Datetosql(EdDatai.AsDate);
       sqlprodutox:='';
    end;
    Q:=sqltoquery('select mestre.*,detalhe.*,esto_descricao,'+
                     'grup_descricao,sugr_descricao,fami_descricao'+
                     ' from movesto mestre,movestoque detalhe'+
                     ' left  join grupos on (grup_codigo=move_grup_codigo) '+
                     ' left  join subgrupos on (sugr_codigo=move_sugr_codigo) '+
                     ' left  join familias on (fami_codigo=move_fami_codigo) '+
//                     ' left join estoque on (esto_codigo=move_esto_codigo) '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' where mestre.'+FGeral.RelEstoque('moes_status')+
                     ' and mestre.moes_unid_codigo='+stringtosql(unidade)+
                     sqlinicio+
                     ' and mestre.moes_datamvto<='+Datetosql(EdDataf.Asdate)+
                     sqltipomovto+
// rever esta questao dos tipos q movimentam de fato estoque
//                     ' and '+FGeral.Getin('mestre.moes_tipomov',Global.TiposMovMovEstoque,'C')+
//                     ' and '+FGeral.Getin('detalhe.move_tipomov',Global.TiposMovMovEstoque,'C')+
                     sqldocumento+
                     sqlcliente+
                     ' and mestre.moes_transacao=detalhe.move_transacao'+
/////////////////////                     ' and mestre.moes_tipomov=detalhe.move_tipomov'+
                     ' and mestre.moes_unid_codigo=detalhe.move_unid_codigo'+
                     ' and mestre.moes_numerodoc=detalhe.move_numerodoc'+
//                     ' and mestre.moes_datacont=detalhe.move_datacont'+
                     ' and detalhe.'+FGeral.RelEstoque('move_status')+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
//                     ' order by detalhe.move_esto_codigo,mestre.moes_datamvto' );
                     ' order by detalhe.move_esto_codigo,detalhe.move_datamvto,detalhe.move_numerodoc' );
//                     ' order by detalhe.move_datamvto,detalhe.move_esto_codigo' );
//////////}

///////////////////////////////////////////// - 06.12.07

    Sistema.BeginProcess('Pesquisando tipos');
    QMov:=sqltoquery('select move_tipomov,count(*) as tipos from movestoque'+
                     ' left join movesto on ( moes_transacao=move_transacao )'+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and move_unid_codigo='+stringtosql(unidade)+
                     sqlinicio+
                     ' and move_datamvto<='+Datetosql(EdDataf.Asdate)+
                     sqltipomovto+
                     sqldocumento+
                     sqlcliente+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     ' group by move_tipomov' );
        ListaTiposGeral:=TStringlist.create;
        while not Qmov.eof do begin
          jatemtipo:=false;
          for y:=0 to ListaTiposGeral.count-1 do begin
            if ( ListaTiposGeral[y]=QMov.fieldbyname('move_tipomov').asstring ) then begin
              jatemtipo:=true;
              break;
            end;
          end;
          if not jatemtipo then begin
            ListaTiposGeral.add(QMov.fieldbyname('move_tipomov').asstring);
          end;
          qMov.next;
        end;
/////////////////////////////////////////////

      unidade:=copy(FRelEstoque.EdUNid_codigo.Text,1,3);

      Listamov:=Tlist.create;
      Sistema.beginprocess('Gerando saldo anterior dos produtos');
      QEstqtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+stringtosql(unidade)+
                           sqlprodutox+
                           ' and esqt_status=''N''');
      while not QEstqtde.eof do begin
        saldoanterior:=FGeral.EstoqueAnterior(QEstqtde.fieldbyname('esqt_esto_codigo').asstring,unidade,EdDatai.AsDate,salantpecas);
        AtualizaSAldoanterior(saldoanterior,unidade,QEstqtde.fieldbyname('esqt_esto_codigo').asstring);
        QEstqtde.next;
      end;
      QEstqtde.close;
      Freeandnil(QEstqtde);
      Sistema.endprocess('');

      if Q.eof then
        Avisoerro('Não encontrado movimentação no periodo escolhido');

      Sistema.beginprocess('Atualizando saldo anterior dos produtos até dia '+formatdatetime('dd/mm/yy',EdDAtai.asdate));

      while not Q.eof do begin

        produto:=Q.FieldByName('move_esto_codigo').AsString;
//        saldoanterior:=FGeral.EstoqueAnterior(produto,unidade,EdDatai.AsDate);

        if (Datetodia(EdDatai.AsDate)>1) and (Trim(EdEsto_codigo.text)<>'') then begin
          while (not Q.eof) and (produto=Q.FieldByName('move_esto_codigo').AsString) and (Q.FieldByName('move_datamvto').AsDateTime<EdDatai.Asdate)
            do begin
            op:=FGeral.GetEntSaiTipoMovto(Q.FieldByName('move_tipomov').AsString);
            if op='+' then
              saldoanterior:=saldoanterior+Q.FieldByName('move_qtde').AsFloat
            else if op='-' then
              saldoanterior:=saldoanterior-Q.FieldByName('move_qtde').AsFloat
            else if op='B' then  // 13.02.06
              saldoanterior:=Q.FieldByName('move_estoque').AsFloat;
            Q.Next;
          end;
        end;
// 08.07.05 - nao trazia saldo inicial correto caso escolhesse um dia diferente do dia primeiro
        AtualizaSAldoanterior(saldoanterior,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_esto_codigo').asstring);
        while (not Q.eof) and (produto=Q.FieldByName('move_esto_codigo').AsString) do begin
          Atualizalista;
          Q.Next;
        end;

      end;

      FRel.Init('RelExtratoSinTipomov');
//      FRel.AddTit('Extrato Sintético por Tipo de Movimentação por Produto - Somente tipos que movimentam estoque');
      FRel.AddTit('Extrato Sintético por Tipo de Movimentação por Produto');
      FRel.AddTit('Unidade : '+Unidade+' - '+FUnidades.Getnome(Unidade));
      FRel.AddTit('Periodo : '+formatdatetime('dd/mm/yy',EdDatai.AsDate)+' a '+formatdatetime('dd/mm/yy',EdDataf.AsDate)+Montatit(EdGrup_codigo.AsInteger,EdSugr_codigo.AsInteger,EdFami_codigo.AsInteger));
      FRel.AddCol( 90,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(200,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
      FRel.AddCol( 80,3,'N','+',''              ,'Saldo ant.'      ,''         ,'',false);
      for p:=0 to ListaTiposGeral.count-1 do begin
        FRel.AddCol( 50,3,'N','+' ,''              ,ListaTiposGeral[p]       ,''         ,'',false);
      end;
{
      PMovimento:=Listamov[0];
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov01       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov02       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov03       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov04       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov05       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov06       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov07       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov08       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov09       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov10       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov11       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov12       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov13       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov14       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov15       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov16       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov17       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov18       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov19       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov20       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov21       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov22       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov23       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov24       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov25       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov26       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov27       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov28       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov29       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov30       ,''         ,'',false);
}

      FRel.AddCol( 50,3,'N','+' ,''              ,'Saldo'                    ,''         ,'',false);
      for p:=0 to Listamov.count-1 do begin
        PMovimento:=Listamov[p];
        FRel.AddCel(Pmovimento.move_esto_codigo);
        FRel.AddCel(FEstoque.getdescricao(Pmovimento.move_esto_codigo) );
        FRel.AddCel( floattostr(Pmovimento.saldoant) );
        for y:=0 to PMovimento.ListaTipos.count-1 do begin
          PMovimento.PTiposQtde:=PMovimento.ListaTipos[y];
          FRel.AddCel( floattostr(PMovimento.PTiposqtde.qtde) );
        end;
{
        FRel.AddCel( floattostr(Pmovimento.qtde01) );
        FRel.AddCel( floattostr(Pmovimento.qtde02) );
        FRel.AddCel( floattostr(Pmovimento.qtde03) );
        FRel.AddCel( floattostr(Pmovimento.qtde04) );
        FRel.AddCel( floattostr(Pmovimento.qtde05) );
        FRel.AddCel( floattostr(Pmovimento.qtde06) );
        FRel.AddCel( floattostr(Pmovimento.qtde07) );
        FRel.AddCel( floattostr(Pmovimento.qtde08) );
        FRel.AddCel( floattostr(Pmovimento.qtde09) );
        FRel.AddCel( floattostr(Pmovimento.qtde10) );
        FRel.AddCel( floattostr(Pmovimento.qtde11) );
        FRel.AddCel( floattostr(Pmovimento.qtde12) );
        FRel.AddCel( floattostr(Pmovimento.qtde13) );
        FRel.AddCel( floattostr(Pmovimento.qtde14) );
        FRel.AddCel( floattostr(Pmovimento.qtde15) );
        FRel.AddCel( floattostr(Pmovimento.qtde16) );
        FRel.AddCel( floattostr(Pmovimento.qtde17) );
        FRel.AddCel( floattostr(Pmovimento.qtde18) );
        FRel.AddCel( floattostr(Pmovimento.qtde19) );
        FRel.AddCel( floattostr(Pmovimento.qtde20) );
        FRel.AddCel( floattostr(Pmovimento.qtde21) );
        FRel.AddCel( floattostr(Pmovimento.qtde22) );
        FRel.AddCel( floattostr(Pmovimento.qtde23) );
        FRel.AddCel( floattostr(Pmovimento.qtde24) );
        FRel.AddCel( floattostr(Pmovimento.qtde25) );
        FRel.AddCel( floattostr(Pmovimento.qtde26) );
        FRel.AddCel( floattostr(Pmovimento.qtde27) );
        FRel.AddCel( floattostr(Pmovimento.qtde28) );
        FRel.AddCel( floattostr(Pmovimento.qtde29) );
        FRel.AddCel( floattostr(Pmovimento.qtde30) );
}
        FRel.AddCel( floattostr( Getsaldo ) );
      end;
      FRel.Video;
      Sistema.EndProcess('');
      Q.close;
      Freeandnil(Q);
  end;
end;

procedure FRelEstoque_Contagem;         // 7
//////////////////////////////////////////////
var qtde,qtdeprev:currency;
    tracos:string;

begin
  with FRelEstoque do begin
    if not FRelEstoque_Execute(7) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    tracos:='___________';
    if EdSomagrade.isempty then
      somargrade:='N'
    else
      somargrade:=EdSomagrade.text;
    if trim(FRelEstoque.EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.Getin('esqt_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
//    if somargrade='N' then

      Q:=sqltoquery('select * from estoqueqtde'+
                     ' inner join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' left join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' left join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
                     ' left join estgrades on (esgr_esto_codigo=esqt_esto_codigo and esgr_status=''N'' and esgr_unid_codigo=esqt_unid_codigo)'+
                     ' left join familias on (fami_codigo=esto_fami_codigo) '+
                     ' left join tamanhos on (tama_codigo=esgr_tama_codigo) '+
                     ' left join cores    on (core_codigo=esgr_core_codigo) '+
                     ' left join material on (mate_codigo=esto_mate_codigo) '+
                     ' where esqt_status=''N'''+
//                     ' and esto_emlinha=''S'''+
                     sqlunidade+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     ' order by esqt_unid_codigo,esqt_esto_codigo' );
{
    else
      Q:=sqltoquery('select * from estoqueqtde'+
                     ' left join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' left join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' left join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
                     ' left join familias on (fami_codigo=esto_fami_codigo) '+
                     ' where esqt_status=''N'''+
                     sqlunidade+
                     ' and esto_emlinha=''S'''+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     ' order by esqt_unid_codigo,esqt_esto_codigo' );
}
    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      FRel.Init('ContagemEstoque');
      FRel.AddTit('Contagem do Estoque');
      FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));
      FRel.AddCol( 45,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Grupo'           ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Grupo'     ,''         ,'',false);
//      FRel.AddCol( 60,1,'C','' ,''              ,'Subgrupo'        ,''         ,'',false);
//      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Subgrupo'  ,''         ,'',false);
//      FRel.AddCol( 60,1,'C','' ,''              ,'Familia'         ,''         ,'',false);
//      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Familia'   ,''         ,'',false);
      FRel.AddCol( 90,1,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol( 80,1,'C','' ,''              ,'Referência'          ,''         ,'',false);
      FRel.AddCol( 70,1,'C','' ,''              ,'Localização'          ,''         ,'',false);
      FRel.AddCol(200,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
      FRel.AddCol( 50,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 90,1,'N','' ,''              ,'Tamanho'         ,''         ,'',False);
      FRel.AddCol( 100,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
//      FRel.AddCol(100,1,'C','' ,''              ,'Cod.Barra'       ,''         ,'',false);
//      FRel.AddCol( 50,1,'C','' ,''              ,'Em linha'        ,''         ,'',false);
      FRel.AddCol( 70,3,'N','' ,''              ,'Qtde'       ,''         ,'',false);
      FRel.AddCol(100,03,'C','' ,''              ,''       ,''         ,'',false);
//      FRel.AddCol( 90,03,'C','' ,''              ,''       ,''         ,'',false);
//      FRel.AddCol( 90,03,'C','' ,''              ,''       ,''         ,'',false);

      while not Q.eof do begin

        FRel.AddCel(Q.FieldByName('esqt_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_grup_codigo').AsString);
        FRel.AddCel(Q.FieldByName('grup_descricao').AsString);
//        FRel.AddCel(Q.FieldByName('esto_sugr_codigo').AsString);
//        FRel.AddCel(Q.FieldByName('sugr_descricao').AsString);
//        FRel.AddCel(Q.FieldByName('esto_fami_codigo').AsString);
//        FRel.AddCel(Q.FieldByName('fami_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esqt_esto_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_referencia').AsString);
        FRel.AddCel(Q.FieldByName('esqt_localiza').AsString);
        FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esto_unidade').AsString);

//        FRel.AddCel(Q.FieldByName('esqt_tama_codigo').AsString);
//        FRel.AddCel(Q.FieldByName('tama_descricao').AsString);
        FRel.AddCel(Q.FieldByName('tama_comprimento').AsString);
//        FRel.AddCel(Q.FieldByName('esqt_core_codigo').AsString);
        FRel.AddCel(Q.FieldByName('core_descricao').AsString);
//        FRel.AddCel(Q.FieldByName('esto_codbarra').AsString);
//        FRel.AddCel(Q.FieldByName('esto_emlinha').AsString);
//        FRel.AddCel(Q.FieldByName('esto_mate_codigo').AsString);
//        FRel.AddCel(Q.FieldByName('mate_descricao').AsString);

//        FRel.AddCel(Q.FieldByName('esqt_dtultvenda').asstring);
//        FRel.AddCel(Q.FieldByName('esqt_dtultcompra').asstring);
//        FRel.AddCel(Q.FieldByName('esqt_desconto').asstring);
//        FRel.AddCel(Q.FieldByName('esqt_basecomissao').asstring);
//      if Global.Usuario.OutrosAcessos[0010] then begin
        if ( Q.FieldByName('esgr_tama_codigo').AsInteger>0 ) or
           ( Q.FieldByName('esgr_core_codigo').AsInteger>0 ) then
          FRel.AddCel(Q.FieldByName('esgr_qtdeprev').AsString)
        else
          FRel.AddCel(Q.FieldByName('esqt_qtdeprev').AsString);
//        FRel.AddCel(tracos+tracos+tracos+tracos);
//        FRel.AddCel(tracos);
        FRel.AddCel(tracos);


        Q.Next;

      end;

      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);
  end;
end;


////////////////////////  06.04.06
procedure FRelEstoque_ExtratoEstoqueFora(qestoque:string);         // 8

type TMovimento=record
     moes_unidade,move_esto_codigo,tipomov01,tipomov02,tipomov03,tipomov04,tipomov05,tipomov06,tipomov07,tipomov08,
     tipomov09,tipomov10,tipomov11,tipomov12,tipomov13,tipomov14,tipomov15,tipomov16,tipomov17,tipomov18,tipomov19,
     tipomov20,tipomov21,tipomov22,tipomov23,tipomov24,tipomov25,tipomov26,tipomov27:string;
     qtde01,qtde02,qtde03,qtde04,qtde05,qtde06,qtde07,qtde08,qtde09,qtde10,qtde11,qtde12,qtde13,qtde14,qtde15,saldoant,qtde16,qtde17,qtde18,qtde19,qtde20,
     qtde21,qtde22,qtde23,qtde24,qtde25,qtde26,qtde27,customeger:currency;
end;

var unidade,produto,op,sqlinicio,nome,sqlprodutox,titestoque,sqltipomovtod:string;
    saldoanterior,saldo,pentradas,psaidas,psemmov,tentradas,tsaidas,tsemmov:currency;
    margem,p:integer;
    QBusca,QEstqtde:TSqlquery;
    ListaMov:Tlist;
    PMOvimento:^TMovimento;


    procedure AtualizaSAldoanterior(saldo:currency ; unidade,produto:string ; customeger:currency=0);
    var jatem:boolean;
        x:integer;
    begin
      jatem:=false;
      for x:=0 to LIstamov.count-1 do begin
        PMovimento:=Listamov[x];
        if ( Pmovimento.moes_unidade=unidade ) and
           ( PMovimento.move_esto_codigo=produto ) then begin
          jatem:=true;
          break;
        end;
      end;
      if not jatem then begin
        New(PMovimento);
        PMovimento.moes_unidade:=unidade;
        PMovimento.move_esto_codigo:=produto;
        if qestoque=Global.CodRemessaProntaEntrega then begin
            PMovimento.tipomov01:=global.CodRemessaProntaEntrega;
            PMovimento.tipomov02:=global.CodDevolucaoProntaEntrega;
            PMovimento.tipomov03:=global.CodVendaProntaEntrega;
            PMovimento.tipomov04:=global.CodVendaBrinde;
        end else if qestoque=Global.CodVendaSerie4 then begin
            PMovimento.tipomov01:=Global.CodVendaSerie4;
            PMovimento.tipomov02:=Global.CodDevolucaoSerie5;
            PMovimento.tipomov03:=Global.CodVendaRE;
            PMovimento.tipomov04:=Global.CodVendaREBrinde;
        end else if qestoque=Global.CodRemessaConsig then begin
            PMovimento.tipomov01:=Global.CodRemessaConsig;
            PMovimento.tipomov02:=Global.CodDevolucaoConsig;
            PMovimento.tipomov03:=Global.CodDevolucaoTroca;
            PMovimento.tipomov04:=Global.CodVendaConsig;
        end;
        PMovimento.tipomov05:='';
{
            PMovimento.tipomov06:='';
            PMovimento.tipomov07:='';
            PMovimento.tipomov08:=global.CodVendaTransf;
            PMovimento.tipomov09:=global.CodDevolucaoConsig;
            PMovimento.tipomov10:=global.CodDevolucaoProntaEntrega;
            PMovimento.tipomov11:=global.CodDevolucaoTroca;
            PMovimento.tipomov12:=global.CodDevolucaoVenda;
            PMovimento.tipomov13:=global.CodDevolucaoConsigMerc;
            PMovimento.tipomov14:=global.CodAcertoEsEnt;
            PMovimento.tipomov15:=global.CodAcertoEsSai;
            PMovimento.tipomov16:=global.CodTransfEntrada;
            PMovimento.tipomov17:=global.CodTransfSaida;
            PMovimento.tipomov18:=global.CodVendaProntaEntregaFecha;
            PMovimento.tipomov19:=global.CodRetornoMostruario;
            PMovimento.tipomov20:=global.CodCompra100;
            PMovimento.tipomov21:=global.CodVendaMostruario;
            PMovimento.tipomov22:=Global.CodConsigMercantil;
}

        Pmovimento.qtde01:=0;Pmovimento.qtde02:=0;Pmovimento.qtde03:=0;Pmovimento.qtde04:=0;Pmovimento.qtde05:=0;
        Pmovimento.qtde06:=0;Pmovimento.qtde07:=0;Pmovimento.qtde08:=0;Pmovimento.qtde09:=0;Pmovimento.qtde10:=0;
        Pmovimento.qtde11:=0;Pmovimento.qtde12:=0;Pmovimento.qtde13:=0;Pmovimento.qtde14:=0;Pmovimento.qtde15:=0;
        Pmovimento.qtde16:=0;Pmovimento.qtde17:=0;Pmovimento.qtde18:=0;Pmovimento.qtde19:=0;Pmovimento.qtde20:=0;
        Pmovimento.qtde21:=0;Pmovimento.qtde22:=0;Pmovimento.qtde23:=0;Pmovimento.qtde24:=0;Pmovimento.qtde25:=0;
        Pmovimento.qtde26:=0;Pmovimento.qtde27:=0;
        PMovimento.saldoant:=saldo;
        if customeger>0 then
          PMovimento.customeger:=customeger
        else
          PMovimento.customeger:=0;
        Listamov.add(Pmovimento);
      end else begin
        PMovimento:=Listamov[x];                                      
        PMovimento.saldoant:=saldo;
      end;
    end;

    procedure AtualizaLista;
    //////////////////////
    var x:integer;
        jatem:boolean;

        procedure Somatipomov(tipomov:string;qtde:currency);
        begin
          if qestoque=Global.CodRemessaProntaEntrega then begin
              if tipomov=Global.CodRemessaProntaEntrega then begin
                PMovimento.tipomov01:=global.CodRemessaProntaEntrega;
                PMovimento.qtde01:=PMovimento.qtde01+qtde;
              end else if tipomov=global.CodDevolucaoProntaEntrega then begin
                PMovimento.tipomov02:=global.CodDevolucaoProntaEntrega;
                PMovimento.qtde02:=PMovimento.qtde02+qtde;
              end else if tipomov=global.CodVendaProntaEntrega then begin
                PMovimento.tipomov03:=global.CodVendaProntaEntrega;
                PMovimento.qtde03:=PMovimento.qtde03+qtde;
              end else if tipomov=global.CodVendaBrinde then begin
                PMovimento.tipomov04:=global.CodVendaBrinde;
                PMovimento.qtde04:=PMovimento.qtde04+qtde;
              end;
          end else if qestoque=Global.CodVendaSerie4 then begin
              if tipomov=Global.CodVendaSerie4 then begin
                PMovimento.tipomov01:=Global.CodVendaSerie4;
                PMovimento.qtde01:=PMovimento.qtde01+qtde;
              end else if tipomov=Global.CodDevolucaoSerie5 then begin
                PMovimento.tipomov02:=Global.CodDevolucaoSerie5;
                PMovimento.qtde02:=PMovimento.qtde02+qtde;
              end else if tipomov=Global.CodVendaRE then begin
                PMovimento.tipomov03:=Global.CodVendaRE;
                PMovimento.qtde03:=PMovimento.qtde03+qtde;
              end else if tipomov=Global.CodVendaREBrinde then begin
                PMovimento.tipomov04:=Global.CodVendaREBrinde;
                PMovimento.qtde04:=PMovimento.qtde04+qtde;
              end;
          end else if qestoque=Global.CodRemessaConsig then begin
              if tipomov=Global.CodRemessaConsig then begin
                PMovimento.tipomov01:=Global.CodRemessaConsig;
                PMovimento.qtde01:=PMovimento.qtde01+qtde;
              end else if tipomov=Global.CodDevolucaoConsig then begin
                PMovimento.tipomov02:=Global.CodDevolucaoConsig;
                PMovimento.qtde02:=PMovimento.qtde02+qtde;
              end else if tipomov=Global.CodDevolucaoTroca then begin
                PMovimento.tipomov03:=Global.CodDevolucaoTroca;
                PMovimento.qtde03:=PMovimento.qtde03+qtde;
              end else if tipomov=Global.CodVendaConsig then begin
                PMovimento.tipomov04:=Global.CodVendaConsig;
                PMovimento.qtde04:=PMovimento.qtde04+qtde;
              end;
          end;

        end;


    begin
      jatem:=false;
      for x:=0 to LIstamov.count-1 do begin
        PMovimento:=Listamov[x];
        if ( Pmovimento.moes_unidade=Q.fieldbyname('move_unid_codigo').asstring ) and
           ( PMovimento.move_esto_codigo=Q.fieldbyname('move_esto_codigo').asstring ) then begin
          jatem:=true;
          break;
        end;
      end;
      if not jatem then begin
        New(PMovimento);
        PMovimento.moes_unidade:=Q.fieldbyname('move_unid_codigo').asstring;
        PMovimento.move_esto_codigo:=Q.fieldbyname('move_esto_codigo').asstring;
        Pmovimento.tipomov01:='';Pmovimento.tipomov02:='';Pmovimento.tipomov03:='';Pmovimento.tipomov04:='';
        Pmovimento.tipomov05:='';Pmovimento.tipomov06:='';Pmovimento.tipomov07:='';Pmovimento.tipomov08:='';
        Pmovimento.tipomov09:='';Pmovimento.tipomov10:='';Pmovimento.tipomov11:='';Pmovimento.tipomov12:='';
        Pmovimento.tipomov13:='';Pmovimento.tipomov14:='';Pmovimento.tipomov15:='';
        Pmovimento.tipomov16:='';Pmovimento.tipomov17:='';Pmovimento.tipomov18:='';Pmovimento.tipomov19:='';
        Pmovimento.tipomov20:='';
        Pmovimento.qtde01:=0;Pmovimento.qtde02:=0;Pmovimento.qtde03:=0;Pmovimento.qtde04:=0;Pmovimento.qtde05:=0;
        Pmovimento.qtde06:=0;Pmovimento.qtde07:=0;Pmovimento.qtde08:=0;Pmovimento.qtde09:=0;Pmovimento.qtde10:=0;
        Pmovimento.qtde11:=0;Pmovimento.qtde12:=0;Pmovimento.qtde13:=0;Pmovimento.qtde14:=0;Pmovimento.qtde15:=0;
        Pmovimento.qtde16:=0;Pmovimento.qtde17:=0;Pmovimento.qtde18:=0;Pmovimento.qtde19:=0;Pmovimento.qtde20:=0;
        Pmovimento.qtde21:=0;Pmovimento.qtde22:=0;Pmovimento.qtde23:=0;Pmovimento.qtde24:=0;Pmovimento.qtde25:=0;
        Pmovimento.qtde26:=0;Pmovimento.qtde27:=0;
        SomaTipomov( Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_qtde').ascurrency);
        Listamov.add(Pmovimento);
      end else begin
//      PMovimento:=Listamov[x];
        SomaTipomov( Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_qtde').ascurrency);
      end;
    end;


    function GetSaldo:extended;
    var op,tipos:string;
        ent,sai:currency;
        Lista:TStringlist;
        p:integer;
    begin
      ent:=0;sai:=0;
      tipos:=PMovimento.tipomov01+';'+PMovimento.tipomov02+';'+PMovimento.tipomov03+';'+PMovimento.tipomov04+';'+
             PMovimento.tipomov05+';'+PMovimento.tipomov06+';'+PMovimento.tipomov07+';'+PMovimento.tipomov08+';'+
             PMovimento.tipomov09+';'+PMovimento.tipomov10+';'+PMovimento.tipomov11+';'+PMovimento.tipomov12+';'+
             PMovimento.tipomov13+';'+PMovimento.tipomov14+';'+PMovimento.tipomov15+';'+PMovimento.tipomov16+';'+
             PMovimento.tipomov17+';'+PMovimento.tipomov18+';'+PMovimento.tipomov19+';'+PMovimento.tipomov20+';'+
             PMovimento.tipomov21+';'+PMovimento.tipomov22+';'+PMovimento.tipomov23+';'+PMovimento.tipomov24+';'+
             PMovimento.tipomov25+';'+PMovimento.tipomov26+';'+PMovimento.tipomov27;
      Lista:=TStringlist.create;
      strtolista(lista,tipos,';',true);
      for p:=0 to lista.count-1 do begin
        if trim(Lista[p])<>'' then begin
          op:=FGeral.GetEntSaiTipoMovtoEsFora(Lista[p]);
          if p=0 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde01
            else if op='-' then
              sai:=sai+PMovimento.qtde01;
          end else if p=1 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde02
            else if op='-' then
              sai:=sai+PMovimento.qtde02;
          end else if p=2 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde03
            else if op='-' then
              sai:=sai+PMovimento.qtde03;
          end else if p=3 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde04
            else if op='-' then
              sai:=sai+PMovimento.qtde04;
          end else if p=4 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde05
            else if op='-' then
              sai:=sai+PMovimento.qtde05;
          end else if p=5 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde06
            else if op='-' then
              sai:=sai+PMovimento.qtde06;
          end else if p=6 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde07
            else if op='-' then
              sai:=sai+PMovimento.qtde07;
          end else if p=7 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde08
            else if op='-' then
              sai:=sai+PMovimento.qtde08;
          end else if p=8 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde09
            else if op='-' then
              sai:=sai+PMovimento.qtde09;
          end else if p=9 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde10
            else if op='-' then
              sai:=sai+PMovimento.qtde10;
          end else if p=10 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde11
            else if op='-' then
              sai:=sai+PMovimento.qtde11;
          end else if p=11 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde12
            else if op='-' then
              sai:=sai+PMovimento.qtde12;
          end else if p=12 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde13
            else if op='-' then
              sai:=sai+PMovimento.qtde13;
          end else if p=13 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde14
            else if op='-' then
              sai:=sai+PMovimento.qtde14;
          end else if p=14 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde15
            else if op='-' then
              sai:=sai+PMovimento.qtde15;
          end else if p=15 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde16
            else if op='-' then
              sai:=sai+PMovimento.qtde16;
          end else if p=16 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde17
            else if op='-' then
              sai:=sai+PMovimento.qtde17;
          end else if p=17 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde18
            else if op='-' then
              sai:=sai+PMovimento.qtde18;
          end else if p=18 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde19
            else if op='-' then
              sai:=sai+PMovimento.qtde19;
          end else if p=19 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde20
            else if op='-' then
              sai:=sai+PMovimento.qtde20;
          end else if p=20 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde21
            else if op='-' then
              sai:=sai+PMovimento.qtde21;
          end else if p=21 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde22
            else if op='-' then
              sai:=sai+PMovimento.qtde22;
          end else if p=22 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde23
            else if op='-' then
              sai:=sai+PMovimento.qtde23;
          end else if p=23 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde24
            else if op='-' then
              sai:=sai+PMovimento.qtde24;
          end else if p=24 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde25
            else if op='-' then
              sai:=sai+PMovimento.qtde25;
          end else if p=25 then begin
            if op='+' then
              ent:=ent+PMovimento.qtde26
            else if op='-' then
              sai:=sai+PMovimento.qtde26;
          end;
        end;
      end;
      result:=PMovimento.saldoant+ent-sai;
    end;

begin

  with FRelEstoque do begin
    if not FRelEstoque_Execute(8) then Exit;
    Sistema.BeginProcess('Pesquisando movimento');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);
    sqltipomovtod:='';
    if qestoque=Global.CodRemessaProntaEntrega then begin
      sqltipomovto:=' and '+FGeral.Getin('move_tipomov',Global.CodRemessaProntaEntrega+';'+Global.CodDevolucaoProntaEntrega+';'+Global.CodVendaProntaEntrega+';'+Global.CodVendaBrinde,'C');
      sqltipomovtod:=' and '+FGeral.Getin('moes_tipomov',Global.CodRemessaProntaEntrega+';'+Global.CodDevolucaoProntaEntrega+';'+Global.CodVendaProntaEntrega+';'+Global.CodVendaBrinde,'C');
      titestoque:='Pronta Entrega';
    end else if qestoque=Global.CodVendaSerie4 then begin
      sqltipomovto:=' and '+FGeral.Getin('move_tipomov',Global.CodVendaSerie4+';'+Global.CodDevolucaoSerie5+';'+Global.CodVendaRE+';'+Global.CodVendaREBrinde,'C');
      sqltipomovtod:=' and '+FGeral.Getin('moes_tipomov',Global.CodVendaSerie4+';'+Global.CodDevolucaoSerie5+';'+Global.CodVendaRE+';'+Global.CodVendaREBrinde,'C');
      titestoque:='Regime Especial de SC';
    end else begin
      sqltipomovto:=' and '+FGeral.Getin('move_tipomov',Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca+';'+Global.CodVendaConsig,'C');
      sqltipomovtod:=' and '+FGeral.Getin('moes_tipomov',Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca+';'+Global.CodVendaConsig,'C');
      titestoque:='Consignado';
    end;
    if EdEsto_codigo.AsInteger>0 then begin
       sqlinicio:=' and move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))+' and move_datamvto<='+EdDataf.assql;
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
       sqlprodutox:= ' and esqt_esto_codigo='+EdEsto_codigo.assql;
    end else begin
       sqlinicio:=' and move_datamvto>='+Datetosql(EdDatai.AsDate)+' and move_datamvto<='+EdDataf.assql;
       sqlprodutox:='';
    end;
    sqlproduto:='';
    if not EdEsto_codigo.isempty then
      sqlproduto:=' and move_esto_codigo='+EdEsto_codigo.AsSql;

    Q:=sqltoquery('select * from movestoque'+
                     ' left  join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                     ' left  join grupos on (grup_codigo=move_grup_codigo) '+
                     ' left  join subgrupos on (sugr_codigo=move_sugr_codigo) '+
                     ' left  join familias on (fami_codigo=move_fami_codigo) '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and move_unid_codigo='+stringtosql(unidade)+
                     sqlinicio+
                     sqltipomovto+
                     sqldocumento+
                     sqlcliente+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     ' order by move_esto_codigo,move_datamvto,move_numerodoc' );

      unidade:=copy(FRelEstoque.EdUNid_codigo.Text,1,3);

      if Q.eof then begin
        Avisoerro('Não encontrado movimentação no periodo escolhido');
        Sistema.endprocess('');
        exit;
      end;

      Listamov:=Tlist.create;
      Sistema.beginprocess('Gerando saldo anterior dos produtos');
      QEstqtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+stringtosql(unidade)+
                           sqlprodutox+
                           ' and esqt_status=''N''');
      while not QEstqtde.eof do begin
        saldoanterior:=FGeral.EstoqueAnteriorEsFora(QEstqtde.fieldbyname('esqt_esto_codigo').asstring,unidade,qestoque,EdDatai.AsDate);
        AtualizaSAldoanterior(saldoanterior,unidade,QEstqtde.fieldbyname('esqt_esto_codigo').asstring,QEstqtde.fieldbyname('esqt_customeger').ascurrency);
        QEstqtde.next;
      end;
      QEstqtde.close;
      Freeandnil(QEstqtde);
      Sistema.endprocess('');

      Sistema.beginprocess('Atualizando saldo anterior dos produtos até dia '+formatdatetime('dd/mm/yy',EdDAtai.asdate));

      while not Q.eof do begin

        produto:=Q.FieldByName('move_esto_codigo').AsString;
//        saldoanterior:=FGeral.EstoqueAnterior(produto,unidade,EdDatai.AsDate);

        if (Datetodia(EdDatai.AsDate)>1) and (Trim(EdEsto_codigo.text)<>'') then begin
          while (not Q.eof) and (produto=Q.FieldByName('move_esto_codigo').AsString) and (Q.FieldByName('move_datamvto').AsDateTime<EdDatai.Asdate)
            do begin
            op:=FGeral.GetEntSaiTipoMovtoEsFora(Q.FieldByName('move_tipomov').AsString);
            if op='+' then
              saldoanterior:=saldoanterior+Q.FieldByName('move_qtde').AsFloat
            else if op='-' then
              saldoanterior:=saldoanterior-Q.FieldByName('move_qtde').AsFloat;
            Q.Next;
          end;
        end;
// 08.07.05 - nao trazia saldo inicial correto caso escolhesse um dia diferente do dia primeiro
        AtualizaSAldoanterior(saldoanterior,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_esto_codigo').asstring);

        while (not Q.eof) and (produto=Q.FieldByName('move_esto_codigo').AsString) do begin
          Atualizalista;
          Q.Next;
        end;

      end;

      Sistema.beginprocess('Gerando relatório');

      FRel.Init('RelExtratoSinTipomovEsFora');
//      FRel.AddTit('Extrato Sintético por Tipo de Movimentação por Produto - Somente tipos que movimentam estoque');
      FRel.AddTit('Extrato Sintético por Tipo de Movimentação por Produto do Estoque '+titestoque);
      FRel.AddTit('Unidade : '+Unidade+' - '+FUnidades.Getnome(Unidade)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
      FRel.AddTit('Periodo : '+formatdatetime('dd/mm/yy',EdDatai.AsDate)+' a '+formatdatetime('dd/mm/yy',EdDataf.AsDate)+Montatit(EdGrup_codigo.AsInteger,EdSugr_codigo.AsInteger,EdFami_codigo.AsInteger));
      FRel.AddCol( 90,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(200,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
      FRel.AddCol( 80,3,'N','+',''              ,'Saldo ant.'      ,''         ,'',false);
      PMovimento:=Listamov[0];
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov01       ,''         ,'',false);
      FRel.AddCol( 55,3,'N','+' ,''              ,'Gerencial'          ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov02       ,''         ,'',false);
      FRel.AddCol( 55,3,'N','+' ,''              ,'Gerencial'          ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov03       ,''         ,'',false);
      FRel.AddCol( 55,3,'N','+' ,''              ,'Gerencial'          ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov04       ,''         ,'',false);
      FRel.AddCol( 55,3,'N','+' ,''              ,'Gerencial'          ,''         ,'',false);
{
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov05       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov06       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov07       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov08       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov09       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov10       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov11       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov12       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov13       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov14       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov15       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov16       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov17       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov18       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov19       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov20       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov21       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov22       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov23       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov24       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov25       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov26       ,''         ,'',false);
      FRel.AddCol( 50,3,'N','+' ,''              ,Pmovimento.tipomov27       ,''         ,'',false);
}

      FRel.AddCol( 50,3,'N','+' ,''              ,'Saldo'                    ,''         ,'',false);
      FRel.AddCol( 70,3,'N','+' ,f_cr            ,'Medio Gerencial'                    ,''         ,'',false);
      for p:=0 to Listamov.count-1 do begin
        PMovimento:=Listamov[p];
        if Pmovimento.saldoant+Pmovimento.qtde01+Pmovimento.qtde02+Pmovimento.qtde03+Pmovimento.qtde04+
           Pmovimento.qtde05<>0 then begin
          FRel.AddCel(Pmovimento.move_esto_codigo);
          FRel.AddCel(FEstoque.getdescricao(Pmovimento.move_esto_codigo) );
          FRel.AddCel( floattostr(Pmovimento.saldoant) );
          FRel.AddCel( floattostr(Pmovimento.qtde01) );
          FRel.AddCel( floattostr( Pmovimento.qtde01*PMovimento.customeger) );
          FRel.AddCel( floattostr(Pmovimento.qtde02) );
          FRel.AddCel( floattostr( Pmovimento.qtde02*PMovimento.customeger) );
          FRel.AddCel( floattostr(Pmovimento.qtde03) );
          FRel.AddCel( floattostr( Pmovimento.qtde03*PMovimento.customeger) );
          FRel.AddCel( floattostr(Pmovimento.qtde04) );
          FRel.AddCel( floattostr( Pmovimento.qtde04*PMovimento.customeger) );
  {
          FRel.AddCel( floattostr(Pmovimento.qtde05) );
          FRel.AddCel( floattostr(Pmovimento.qtde06) );
          FRel.AddCel( floattostr(Pmovimento.qtde07) );
          FRel.AddCel( floattostr(Pmovimento.qtde08) );
          FRel.AddCel( floattostr(Pmovimento.qtde09) );
          FRel.AddCel( floattostr(Pmovimento.qtde10) );
          FRel.AddCel( floattostr(Pmovimento.qtde11) );
          FRel.AddCel( floattostr(Pmovimento.qtde12) );
          FRel.AddCel( floattostr(Pmovimento.qtde13) );
          FRel.AddCel( floattostr(Pmovimento.qtde14) );
          FRel.AddCel( floattostr(Pmovimento.qtde15) );
          FRel.AddCel( floattostr(Pmovimento.qtde16) );
          FRel.AddCel( floattostr(Pmovimento.qtde17) );
          FRel.AddCel( floattostr(Pmovimento.qtde18) );
          FRel.AddCel( floattostr(Pmovimento.qtde19) );
          FRel.AddCel( floattostr(Pmovimento.qtde20) );
          FRel.AddCel( floattostr(Pmovimento.qtde21) );
          FRel.AddCel( floattostr(Pmovimento.qtde22) );
          FRel.AddCel( floattostr(Pmovimento.qtde23) );
          FRel.AddCel( floattostr(Pmovimento.qtde24) );
          FRel.AddCel( floattostr(Pmovimento.qtde25) );
          FRel.AddCel( floattostr(Pmovimento.qtde26) );
          FRel.AddCel( floattostr(Pmovimento.qtde27) );
  }
          FRel.AddCel( floattostr( Getsaldo ) );
          if Pmovimento.customeger>0 then
            FRel.AddCel( floattostr( Getsaldo*PMovimento.customeger) )
          else
            FRel.AddCel('');
        end;
//        FEstoque.GetCusto(Pmovimento.move_esto_codigo,Global.unidadematriz,'medioger') ) );
      end;
      FRel.Video;
      Sistema.EndProcess('');
      Q.close;
      Freeandnil(Q);
  end;

  FRelEstoque_ExtratoEstoqueFora(qestoque);         // 8

end;


procedure TFRelEstoque.EdTipocadValidate(Sender: TObject);
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



//////////////
procedure FRelEstoque_ExtratoFora;         // 8
var unidade,op,sqlinicio,nome,sqltermino:string;
    saldoanterior,saldo,entrada,saida:currency;
    QBusca:TSqlquery;

    function Busca(Tipo,codigo:string;tipomov:string=''):string;
    begin

      if pos(tipomov,Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.CodTransfEnt+';'+Global.CodTransfSai)>0 then begin
        result:='';
        if pos(tipomov,Global.CodTransfEntrada+';'+Global.CodTransfEnt)>0 then begin
          QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
          if not QBusca.eof then
            result:=QBusca.fieldbyname('forn_nome').AsString
        end else begin
          QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
          if not QBusca.eof then
            result:=QBusca.fieldbyname('clie_nome').AsString
        end;

      end else if tipo='C' then begin
        QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('clie_nome').AsString
        else
          result:=''
      end else if tipo='F' then begin
        QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('forn_nome').AsString
        else
          result:=''
      end else begin
        QBusca:=sqltoquery('select unid_nome,unid_reduzido from unidades where unid_codigo='+stringtosql(formatfloat('000',strtocurr(codigo))));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('unid_reduzido').AsString
        else
          result:=''
      end;
      QBusca.Free;
    end;


begin

  with FRelEstoque do begin
    if not FRelEstoque_Execute(8) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);
//    if EdEsto_codigo.AsInteger>0 then
//       sqlinicio:=' and move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
//    else
       sqlinicio:=' and move_datamvto>='+Datetosql(EdDatai.AsDate);
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(EdDatai.AsDate);

    if EdDAtaf.isempty then
       sqltermino:=''
    else
       sqltermino:=' and move_datamvto<='+Datetosql(EdDataf.Asdate);
    if EdDAtai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// aqui em 02.12.05
    Q:=sqltoquery('select * from movestoque '+
                     ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
//                     ' and extract( month from move_datamvto )='+inttostr(Datetomes(texttodate('01'+EdMesano.text)))+
//                     ' and extract( year from move_datamvto )='+inttostr(Datetoano(texttodate('01'+EdMesano.text),true))+
                     sqlinicio+
                     sqltermino+
                     sqldocumento+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     sqltipomovto+  // 15.02.06
                     ' order by move_esto_codigo,move_datamvto,move_numerodoc' );


//////////////////////////////////////////////////////////////////////////////////
      unidade:=copy(FRelEstoque.EdUNid_codigo.Text,1,3);
      FRel.Init('ExtratoProdutoFora');
      FRel.AddTit('Extrato por Produto Estoque Fora'+FGEral.TituloRelCliRepre(EdCodtipo.asinteger,Edtipocad.text));
      FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));
      FRel.AddTit('Periodo : '+formatdatetime('dd/mm/yy',FRelEstoque.EdDatai.asdate)+' a '+formatdatetime('dd/mm/yy',FRelEstoque.EdDataf.asdate));
      FRel.AddCol( 35,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 70,3,'N','' ,''              ,'Produto'         ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Data'            ,''         ,'',false);
      FRel.AddCol( 60,3,'N','' ,''              ,'Docum.'          ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Tipomov'         ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',''              ,'Entradas'         ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',''              ,'Saidas'           ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',''              ,'Ent.-Sai.'       ,''         ,'',false);
//      FRel.AddCol( 70,3,'N','' ,''              ,'Saldo'           ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Status'          ,''         ,'',false);
      FRel.AddCol(300,1,'C','' ,''              ,'Moes_remessas'   ,''         ,'',false);
      FRel.AddCol(300,1,'C','' ,''              ,'Move_remessas'   ,''         ,'',false);

      while not Q.eof do begin

        FRel.AddCel(Q.FieldByName('move_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('move_esto_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
        FRel.AddCel(FGEral.formatadata(Q.FieldByName('move_datamvto').AsDatetime));
        FRel.AddCel(Q.FieldByName('move_numerodoc').Asstring);
        FRel.AddCel(Q.FieldByName('move_tipomov').Asstring);
//        FTextRel.SetColuna(03,FGeral.GetTipoMovto(Q.FieldByName('move_tipomov').AsString,true));
        op:=FGeral.GetEntSaiTipoMovtoEsFora(Q.FieldByName('move_tipomov').AsString);
        entrada:=0;saida:=0;
        if op='+' then begin
            FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat));
            FRel.addCel('');
//            saldo:=saldo+Q.FieldByName('move_qtde').AsFloat;
            entrada:=Q.FieldByName('move_qtde').AsFloat;
        end else if op='-' then begin
            FRel.addCel('');
            FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat));
//            saldo:=saldo-Q.FieldByName('move_qtde').AsFloat;
            saida:=Q.FieldByName('move_qtde').AsFloat;
        end else begin
            FRel.addCel('');
            FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat));
        end;
        saldo:=saldo+(entrada-saida);
        FRel.addCel(floattostr(entrada-saida));
//        FRel.addCel(floattostr(saldo));
//          nome:=Busca(Q.FieldByName('moes_tipocad').AsString,Q.FieldByName('move_tipo_codigo').AsString);
        FRel.AddCel(Q.FieldByName('move_status').Asstring);
        FRel.AddCel(Q.FieldByName('moes_remessas').Asstring);
        FRel.AddCel(Q.FieldByName('move_remessas').Asstring);


          Q.Next;

      end;

      FRel.Video;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;
end;

////////////////////////////////////////////////////////////////////
procedure FRelEstoque_ListaPreco;          // 9
////////////////////////////////////////////////////////////////////
var sqlgrupos,tit,sqlprodutosnao:string;
//    Str:TMemoryStream;
    venda,xmargem,tamanho,unitariograde:currency;


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
//////////////
  with FRelEstoque do begin
    if not FRelEstoque_Execute(9) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    if EdSomagrade.isempty then
      somargrade:='N'
    else
      somargrade:=EdSomagrade.text;
    if trim(FRelEstoque.EdUnid_codigo.text)<>'' then
//      sqlunidade:=' and '+FGeral.Getin('esqt_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')
      sqlunidade:=' and esqt_unid_codigo='+stringtosql(copy(FRelEstoque.EdUnid_codigo.text,1,3))
    else
      sqlunidade:='';
   if FGeral.getconfig1asstring('GRUPOSPRECO')<>'' then
     sqlgrupos:=' and '+FGeral.GetIN('esto_grup_codigo',FGeral.getconfig1asstring('GRUPOSPRECO'),'N')
   else
     sqlgrupos:='';
// 02.06.16
   if trim( FGeral.getconfig1asstring('Produtosnaovenda'))<>'' then
//   if  FGeral.getconfig1asstring('Produtosnaovenda') <>'' then
     sqlprodutosNAO:=' and '+FGeral.GetNotIN('esto_codigo',FGeral.getconfig1asstring('Produtosnaovenda'),'C')
   else
     sqlprodutosNAO:='';

//    if somargrade='N' then
{
      Q:=sqltoquery('select * from estoqueqtde'+
                     ' left join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' left join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' left join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
                     ' left join estgrades on (esgr_esto_codigo=esqt_esto_codigo and esgr_status=''N'' and esgr_unid_codigo=esqt_unid_codigo)'+
                     ' left join familias on (fami_codigo=esto_fami_codigo) '+
                     ' left join tamanhos on (tama_codigo=esgr_tama_codigo) '+
                     ' left join cores    on (core_codigo=esgr_core_codigo) '+
                     ' left join material on (mate_codigo=esto_mate_codigo) '+
                     ' where esqt_status=''N'''+
//                     ' and esto_emlinha=''S'''+
                     sqlunidade+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     ' order by esqt_unid_codigo,esqt_esto_codigo' );
}

//    else

      Q:=sqltoquery('select * from estoqueqtde'+
                     ' left join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' left join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' left join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
                     ' left join familias on (fami_codigo=esto_fami_codigo) '+
                     ' where esqt_status=''N'''+
                     sqlunidade+sqlprodutosnao+
                     ' and esto_emlinha=''S'''+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+sqlgrupos+
                     ' order by esqt_unid_codigo,esqt_esto_codigo' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      tit:='';
      if EdUsarmarkup.text='S' then
        tit:=' - Preço de Venda Calculado com Markup sobre o custo'
      else  if EdMoes_tabp_codigo.asinteger>0 then
        tit := ' - Tabela '+SetEdTABP_ALIQUOTA.text
      else  if EdGrup_codigo.asinteger>0 then
        tit := ' - Grupo '+SetEdDEPT_DESCRICAO.text;
      FRel.Init('ListaPrecos');
      FRel.AddTit('Lista de Preços');
      FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text)+tit);
//      FRel.AddCol( 45,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 60,1,'N','' ,''              ,'Grupo'           ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Grupo'     ,''         ,'',false);
//      FRel.AddCol( 60,1,'C','' ,''              ,'Subgrupo'        ,''         ,'',false);
//      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Subgrupo'  ,''         ,'',false);
//      FRel.AddCol( 60,1,'C','' ,''              ,'Familia'         ,''         ,'',false);
//      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Familia'   ,''         ,'',false);
//      if Global.Topicos[1209] then
//      else
      FRel.AddCol( 90,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Referência'          ,''         ,'',false);
      FRel.AddCol(200,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
      FRel.AddCol( 50,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
//      FRel.AddCol( 90,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
//      FRel.AddCol( 80,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
//      FRel.AddCol(100,1,'C','' ,''              ,'Cod.Barra'       ,''         ,'',false);
//      FRel.AddCol( 50,1,'C','' ,''              ,'Em linha'        ,''         ,'',false);
//      FRel.AddCol( 60,1,'C','' ,''              ,'Material'         ,''         ,'',false);
//      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Material'   ,''         ,'',false);
//      FRel.AddCol( 65,1,'D','' ,''              ,'Ult. Venda'       ,''         ,'',false);
//      FRel.AddCol( 65,1,'D','' ,''              ,'Ult. Compra'      ,''         ,'',false);
//      FRel.AddCol( 65,3,'N','' ,f_cr            ,'% Desconto'       ,''         ,'',false);
//      FRel.AddCol( 70,3,'N','' ,f_cr            ,'Base comissão'    ,''         ,'',false);
//      FRel.AddCol( 70,3,'N','' ,'##.#0'         ,'Aliq.estado'      ,''         ,'',false);
//      FRel.AddCol( 80,3,'N','' ,'##.#0'         ,'Aliq.fora estado' ,''         ,'',false);
//      FRel.AddCol( 80,1,'C','' ,''              ,'Sit.Trib.estado'  ,''         ,'',false);
//      FRel.AddCol( 80,1,'C','' ,''              ,'Sit.Trib.fora est.' ,''         ,'',false);
// grupo aluminio especifico
      if ( Global.Topicos[1411] ) and ( EdGrup_codigo.AsInteger=2 ) then begin
        FRel.AddCol( 80,3,'N','' ,f_cr            ,'Natural'      ,''         ,'',false);
        FRel.AddCol( 80,3,'N','' ,f_cr            ,'Branco'      ,''         ,'',false);
        FRel.AddCol( 80,3,'N','' ,f_cr            ,'Preto'      ,''         ,'',false);
      end else begin
        FRel.AddCol( 80,3,'N','' ,f_cr            ,'Venda'      ,''         ,'',false);
// 20.05.16
        FRel.AddCol( 80,3,'N','' ,f_cr            ,'Venda Min.'   ,''         ,'',false);
      end;
      FRel.AddCol( 80,3,'N','' ,f_cr            ,'Estoque'      ,''         ,'',false);
      FRel.AddCol( 80,3,'N','' ,f_cr3           ,'Peso'      ,''         ,'',false);
//      if Global.Usuario.OutrosAcessos[0010] then
//        FRel.AddCol( 80,3,'N','' ,f_cr            ,'Custo'    ,''         ,'',false);

// 29.03.11 - retirado devido a erros com jpeg
//      if  Global.Topicos[1214] then  // sem sucesso
//        FRel.AddCol(200,3,'C','' ,''            ,'Imagem '      ,''         ,'',false);

      while not Q.eof do begin

//        FRel.AddCel(Q.FieldByName('esqt_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_grup_codigo').AsString);
        FRel.AddCel(Q.FieldByName('grup_descricao').AsString);
//        FRel.AddCel(Q.FieldByName('esto_sugr_codigo').AsString);
//        FRel.AddCel(Q.FieldByName('sugr_descricao').AsString);
//        FRel.AddCel(Q.FieldByName('esto_fami_codigo').AsString);
//        FRel.AddCel(Q.FieldByName('fami_descricao').AsString);

//        FRel.AddCel(FEstoque.ImpQualCodigo(Q.FieldByName('esqt_esto_codigo').AsString,Q.FieldByName('esto_referencia').AsString));
        FRel.AddCel(Q.FieldByName('esto_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_referencia').AsString);
        FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esto_unidade').AsString);
{
//        FRel.AddCel(Q.FieldByName('esqt_tama_codigo').AsString);
        FRel.AddCel(Q.FieldByName('tama_descricao').AsString);
//        FRel.AddCel(Q.FieldByName('esqt_core_codigo').AsString);
        FRel.AddCel(Q.FieldByName('core_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esto_codbarra').AsString);
        FRel.AddCel(Q.FieldByName('esto_emlinha').AsString);
        FRel.AddCel(Q.FieldByName('esto_mate_codigo').AsString);
        FRel.AddCel(Q.FieldByName('mate_descricao').AsString);

        FRel.AddCel(Q.FieldByName('esqt_dtultvenda').asstring);
        FRel.AddCel(Q.FieldByName('esqt_dtultcompra').asstring);
        FRel.AddCel(Q.FieldByName('esqt_desconto').asstring);
        FRel.AddCel(Q.FieldByName('esqt_basecomissao').asstring);

//        FRel.AddCel(Q.FieldByName('esqt_cfis_codigoest').asstring;
        FRel.AddCel( currtostr (FCodigosFiscais.GetAliquota( Q.FieldByName('esqt_cfis_codigoest').asstring )) );
//        FRel.AddCel(Q.FieldByName('esqt_cfis_codigoforaest').asstring;
        FRel.AddCel( currtostr (FCodigosFiscais.GetAliquota( Q.FieldByName('esqt_cfis_codigoforaest').asstring)) );
//        FRel.AddCel(Q.FieldByName('esqt_sitt_codestado').asstring;
        FRel.AddCel( FSittributaria.GetCST( Q.FieldByName('esqt_sitt_codestado').asinteger ) );
//        FRel.AddCel(Q.FieldByName('esqt_sitt_forestado').asstring;
        FRel.AddCel(FSittributaria.GetCST( Q.FieldByName('esqt_sitt_forestado').asinteger ) );
}
// 18.01.13 - Vivan
//       venda:=Q.FieldByName('esqt_vendavis').ascurrency;
// 21.01.14 - Vivan - Vanderlei
       venda:=FEstoque.GetPreco(Q.FieldByName('esto_codigo').asstring,copy(EdUnid_codigo.text,1,3));
       if EdMoes_tabp_codigo.AsInteger>0 then
          venda:=(FGeral.CalcDescAcre(venda,perc,Arq.TTabelaPreco.fieldbyname('tabp_tipo').asstring))
       else if Global.topicos[1411] then begin
       // ferro - custo do kilo vezes o peso da barra
          tamanho:=6;  // por enquanto fixo barra de 6 metros
          if regradogrupo(Q.FieldByName('esto_codigo').asstring)=1 then
            venda:=Q.FieldByName('esqt_custo').ascurrency*Q.FieldByName('esto_peso').ascurrency
          else if regradogrupo(Q.FieldByName('esto_codigo').asstring)=2 then
            venda:=Q.FieldByName('esqt_custo').ascurrency*Q.FieldByName('esto_peso').ascurrency *
                   tamanho
          else
            venda:=Q.FieldByName('esqt_custo').ascurrency;
// 07.01.14 - depois ver se sai cor e tamanho na lista de preço
//                   FEstoque.GetPrecoGrade(Q.FieldByName('esto_codigo').asstring,copy(EdUnid_codigo.text,1,3),Edcodtamanho.asinteger,Edcodcor.asinteger) ;

          xmargem:=Q.fieldbyname('grup_markup').AsCurrency;
          if xmargem<=100 then
            venda:=venda/( (100-xmargem)/100 )
          else
            venda:=venda*2;
       end;
       if EdUsarMarkup.text='S' then begin
//          FRel.AddCel( floattostr( FEStoque.CalculaMarkup(Q.FieldByName('esqt_custo').ascurrency,Q.FieldByName('grup_markup').ascurrency) ))
          FRel.AddCel( floattostr( FEStoque.CalculaMarkup( FEstoque.GetCusto(Q.FieldByName('esqt_esto_codigo').AsString,Global.CodigoUnidade,'custo' ),Q.FieldByName('grup_markup').ascurrency) ));
          FRel.AddCel( '' );
       end else begin
          FRel.AddCel( floattostr(venda) );
          FRel.AddCel( floattostr(Q.FieldByName('esqt_vendamin').ascurrency) );
       end;
// 24.01.14
      if ( Global.Topicos[1411] ) and ( EdGrup_codigo.AsInteger=2 ) then begin
          tamanho:=(FEstoque.GetComprimentoPadrao(Global.CodigoUnidade,Q.FieldByName('esto_codigo').asstring)/1000);
// branco//////////////////////////////
          unitariograde:=FEstoque.GetPrecoGrade(Q.FieldByName('esto_codigo').asstring,Global.CodigoUnidade,1,6);
          venda:=( Q.FieldByName('esqt_custo').ascurrency+unitariograde )*Q.FieldByName('esto_peso').ascurrency *
                   tamanho  ;
          if xmargem<=100 then
            venda:=venda/( (100-xmargem)/100 )
          else
            venda:=venda*2;
          FRel.AddCel( floattostr(venda) );
          tamanho:=(FEstoque.GetComprimentoPadrao(Global.CodigoUnidade,Q.FieldByName('esto_codigo').asstring)/1000);
// preto////////////////////////
          unitariograde:=FEstoque.GetPrecoGrade(Q.FieldByName('esto_codigo').asstring,Global.CodigoUnidade,1,2);
          venda:=( Q.FieldByName('esqt_custo').ascurrency+unitariograde )*Q.FieldByName('esto_peso').ascurrency *
                   tamanho  ;
          if xmargem<=100 then
            venda:=venda/( (100-xmargem)/100 )
          else
            venda:=venda*2;
          FRel.AddCel( floattostr(venda) );
      end;
// 11.10.13 - Metalforte
       FRel.AddCel( floattostr(Q.FieldByName('esqt_qtde').ascurrency) );
// 22.11.13 - Metalforte
       FRel.AddCel( floattostr(Q.FieldByName('esto_peso').ascurrency) );
//        if Global.Usuario.OutrosAcessos[0010] then
//          FRel.AddCel(Q.FieldByName('esqt_custoger').asstring);

//        if  Global.Topicos[1214] then  //sem sucesso
//          FRel.AddCelFigura(  Q.FieldByName('esto_imagem').AsString );
//          FRel.AddCel(  Q.FieldByName('esto_imagem').AsString );

        Q.Next;

      end;

      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);
  end;
// 21.04.09
  FRelEstoque_ListaPreco;          // 9

end;


procedure FRelEstoque_VendasMinimo;          // 10]
///////////////////////////////////////////////////////////
var unidade,produto,op,sqlinicio,nome,sqltermino,grade,sqlcor,sqltamanho:string;
    saldoanterior,saldo,pentradas,psaidas,psemmov,tentradas,tsaidas,tsemmov,
    pentradaspec,psaidaspec,psemmovpec,tentradaspec,tsaidaspec,tsemmovpec:currency;
    margem,x:integer;
    QBusca:TSqlquery;

    function Busca(Tipo,codigo:string;tipomov:string=''):string;
    begin

      if pos(tipomov,Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.CodTransfEnt+';'+Global.CodTransfSai)>0 then begin
        result:='';
        if pos(tipomov,Global.CodTransfEntrada+';'+Global.CodTransfEnt)>0 then begin
          QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
          if not QBusca.eof then
            result:=QBusca.fieldbyname('forn_nome').AsString
        end else begin
          QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
          if not QBusca.eof then
            result:=QBusca.fieldbyname('clie_nome').AsString
        end;

      end else if tipo='C' then begin
        QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('clie_nome').AsString
        else
          result:=''
      end else if tipo='F' then begin
        QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('forn_nome').AsString
        else
          result:=''
      end else begin
        QBusca:=sqltoquery('select unid_nome,unid_reduzido from unidades where unid_codigo='+stringtosql(formatfloat('000',strtocurr(codigo))));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('unid_reduzido').AsString
        else
          result:=''
      end;
      QBusca.Free;
    end;

    function GetUsuarioLog(xusuario:integer):integer;
    ////////////////////////////////////////////////////
    var Q1:TSqlquery;
    begin
// 15.09.15
      Q1:=sqltoquery('select * from log where log_usua_canc='+inttostr(xusuario)+
                     ' and log_data='+Datetosql(Q.fieldbyname('move_datamvto').asdatetime)+
                     ' and log_codigo='+inttostr(15));
      if not Q1.eof then
        result:=Q1.fieldbyname('log_usua_codigo').asinteger
      else
        result:=0;
      FGeral.FechaQuery(Q1);
    end;

begin

  with FRelEstoque do begin
    if not FRelEstoque_Execute(10) then Exit;
    Sistema.BeginProcess('Pesquisando movimento');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);
    if EdEsto_codigo.AsInteger>0 then
       sqlinicio:=' and move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
    else
       sqlinicio:=' and move_datamvto>='+Datetosql(EdDatai.AsDate);
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(EdDatai.AsDate);

    if EdDAtaf.isempty then
       sqltermino:=''
    else
       sqltermino:=' and move_datamvto<='+Datetosql(EdDataf.Asdate);
    if EdDAtai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;
// 08.09.06
    if EdCodcor.isempty then
      sqlcor:=''
    else
      sqlcor:='and move_core_codigo='+Edcodcor.assql;
    if EdCodtamanho.isempty then
      sqltamanho:=''
    else
      sqltamanho:='and move_tama_codigo='+Edcodtamanho.assql;
    if EdTipomov.isempty then
      sqltipomovto:=' and '+FGeral.GetIn('move_tipomov',Global.TiposSaida,'C');
    Q:=sqltoquery('select * from movestoque '+
                     ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' inner join grupos on ( grup_codigo=esto_grup_codigo )'+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
                     ' and move_venda<>move_vendabru and move_vendamin>0'+
                     sqlinicio+
                     sqltermino+
                     sqldocumento+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     sqltipomovto+  // 15.02.06
//                     sqlcor+  // 08.09.06
//                     sqltamanho+  // 12.09.06
                     ' and '+FGeral.RelEstoque('moes_status')+
                     ' order by move_datamvto,move_numerodoc' );
     if Q.Eof then begin
        Avisoerro('Nada encontrado para impressão');
        FGeral.fechaquery(Q);
        Sistema.EndProcess('');
        exit;
     end;
     Sistema.BeginProcess('Gerando Relatório');
     FRel.Init('VendasAbaixominimo');
     FRel.AddTit('Checagem de Preço de Venda com o Preço mínimo - Período : '+FGeral.formatadata(EdDatai.asdate)+' a '+FGeral.formatadata(EdDAtaf.asdate));
     FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));
//      FRel.AddCol( 45,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
     FRel.AddCol( 50,1,'N','' ,''              ,'Grupo'           ,''         ,'',false);
     FRel.AddCol(100,1,'C','' ,''              ,'Desc. Grupo'     ,''         ,'',false);
     FRel.AddCol( 80,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
     FRel.AddCol(150,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
     FRel.AddCol( 50,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
     FRel.AddCol( 50,3,'N','' ,''              ,'Doc.'            ,''         ,'',false);
     FRel.AddCol(150,1,'C','' ,''              ,'Cliente'         ,''         ,'',false);
     FRel.AddCol( 55,1,'D','' ,''              ,'Data'            ,''         ,'',false);
     FRel.AddCol( 55,1,'D','' ,''              ,'Movimento'       ,''         ,'',false);
     FRel.AddCol( 70,3,'N','' ,''              ,'Qtde'            ,''         ,'',false);
     FRel.AddCol( 80,3,'N','' ,f_cr            ,'Preço Praticado' ,''         ,'',false);
     FRel.AddCol( 70,3,'N','' ,f_cr            ,'Preço Mínimo'    ,''         ,'',false);
     FRel.AddCol( 70,3,'N','' ,f_cr            ,'Preço Tabela'    ,''         ,'',false);
     FRel.AddCol( 60,2,'C','' ,''              ,'Abaixo Min'      ,''         ,'',false);
     FRel.AddCol(100,1,'C','' ,''              ,'Usuário'         ,''         ,'',false);
// 23.04.08 - isonel
     FRel.AddCol(100,1,'C','' ,''              ,'Usuário Aut'         ,''         ,'',false);
     while not Q.eof do begin
        FRel.AddCel(Q.FieldByName('esto_grup_codigo').AsString);
        FRel.AddCel(Q.FieldByName('grup_descricao').AsString);
        FRel.AddCel(Q.FieldByName('move_esto_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esto_unidade').AsString);
        FRel.AddCel(Q.FieldByName('move_numerodoc').AsString);
        FRel.AddCel(Busca(Q.FieldByName('move_tipocad').AsString,Q.FieldByName('move_tipo_codigo').AsString));
        FRel.AddCel(Q.FieldByName('move_datamvto').AsString);
        FRel.AddCel(Q.FieldByName('move_datacont').AsString);
        FRel.AddCel(Q.FieldByName('move_qtde').AsString);
        FRel.AddCel(Q.FieldByName('move_venda').AsString);
        FRel.AddCel(Q.FieldByName('move_vendamin').AsString);
        FRel.AddCel(Q.FieldByName('move_vendabru').AsString);
        if Q.FieldByName('move_vendamin').Ascurrency>Q.FieldByName('move_venda').AsCurrency then
          FRel.AddCel('S')
        else
          FRel.AddCel('N');
        FRel.AddCel(FUsuarios.Getnome( Q.FieldByName('move_usua_codigo').AsInteger ));
//        FRel.AddCel(FUsuarios.Getnome( GetUsuarioLog(Q.FieldByName('move_transacao').AsString) ));
// 15.09.15
        FRel.AddCel(FUsuarios.Getnome( GetUsuarioLog(Q.FieldByName('move_usua_codigo').AsInteger)) );
        Q.Next;
     end;
     FRel.Video;
     Sistema.EndProcess('');
  end;
  FRelEstoque_VendasMinimo;

end;

/////////////////////////////////////////// - 17.12.07
procedure FRelEstoque_ExtratoColunas;         // 11
///////////////////////////////////////////////////////////////
var unidade,produto,op,sqlinicio,nome,sqltermino,grade,sqlcor,sqltamanho,titcor,tittamanho,produtoant:string;
    saldoanterior,saldo,pentradas,psaidas,psemmov,tentradas,tsaidas,tsemmov,
    pentradaspec,psaidaspec,psemmovpec,tentradaspec,tsaidaspec,tsemmovpec,saldoanteriorpecas,saldopecas,qtde:currency;
    margem,x:integer;
    QBusca:TSqlquery;

    function Busca(Tipo,codigo:string;tipomov:string=''):string;
    begin

      if pos(tipomov,Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.CodTransfEnt+';'+Global.CodTransfSai)>0 then begin
        result:='';
        if pos(tipomov,Global.CodTransfEntrada+';'+Global.CodTransfEnt)>0 then begin
          QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
          if not QBusca.eof then
            result:=QBusca.fieldbyname('forn_nome').AsString
        end else begin
          QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
          if not QBusca.eof then
            result:=QBusca.fieldbyname('clie_nome').AsString
        end;

      end else if tipo='C' then begin
        QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('clie_nome').AsString
        else
          result:=''
      end else if tipo='F' then begin
        QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('forn_nome').AsString
        else
          result:=''
      end else begin
        QBusca:=sqltoquery('select unid_nome,unid_reduzido from unidades where unid_codigo='+stringtosql(formatfloat('000',strtocurr(codigo))));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('unid_reduzido').AsString
        else
          result:=''
      end;
      QBusca.Free;
    end;

    // 14.04.18
    function GetBaixaMateriaPrima( xtran:string ):boolean;
    ///////////////////////////////////////////////////////
    var Qx:TSqlquery;
    begin

       Qx:=sqltoquery('select moes_transacao from movesto where moes_status = ''N'''+
                      ' and moes_transacao = '+Stringtosql(xtran)+
                      ' and moes_tipomov = '+Stringtosql(Global.CodBaixaMatSai) );
       result:=( not Qx.eof);
       FGEral.FechaQuery(Qx);

    end;

begin

  with FRelEstoque do begin
    if not FRelEstoque_Execute(11) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);
    if EdEsto_codigo.AsInteger>0 then
       sqlinicio:=' and move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
    else
       sqlinicio:=' and move_datamvto>='+Datetosql(EdDatai.AsDate);
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(EdDatai.AsDate);

    if EdDAtaf.isempty then
       sqltermino:=''
    else
       sqltermino:=' and move_datamvto<='+Datetosql(EdDataf.Asdate);
    if EdDAtai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;
// 08.09.06
    if EdCodcor.isempty then
      sqlcor:=''
    else
      sqlcor:='and move_core_codigo='+Edcodcor.assql;
    if EdCodtamanho.isempty then
      sqltamanho:=''
    else
      sqltamanho:='and move_tama_codigo='+Edcodtamanho.assql;
    Q:=sqltoquery('select * from movestoque '+
//                     ' left join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
// 07.08.06 - explosão de materia prima
//                     ' left join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc) '+
// 24.04.08 - contagem de estoque
//                     ' left join movesto on (moes_transacao=move_transacao and moes_numerodoc=move_numerodoc and moes_datamvto=move_datamvto) '+
// 30.04.08 - retirado left join movesto para nao duplicar lançamentos como a entrada no almoxarifado com SP
                     ' left join cores on (core_codigo=move_core_codigo)'+
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' left join estoqueqtde on (esqt_esto_codigo=move_esto_codigo and esqt_unid_codigo=move_unid_codigo and esqt_status=''N'')'+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+
                     sqldocumento+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     sqltipomovto+  // 15.02.06
                     sqlcor+  // 08.09.06
                     sqltamanho+  // 12.09.06
                     sqlobra+   // 03.01.07
//                     ' and '+FGeral.RelEstoque('moes_status')+
// 17.03.08
//                     ' and '+FGeral.Getin('moes_status','N;D;E;R','C')+
                     ' order by move_esto_codigo,move_datamvto,move_numerodoc' );


//////////////////////////////////////////////////////////////////////////////////
      unidade:=copy(FRelEstoque.EdUNid_codigo.Text,1,3);
      FRel.Init('ExtratoColunas');
      FRel.AddTit('Extrato de Movimentação do Produto - Período : '+FGeral.formatadata(EdDatai.asdate)+' a '+FGeral.formatadata(EdDAtaf.asdate));
      FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));

      if not EdEsto_codigo.isempty then begin
        if not EdCodcor.isempty then
          titcor:=' - '+Fcores.Getdescricao(Edcodcor.asinteger)
        else
          titcor:='';
        if not EdCodtamanho.isempty then
          tittamanho:=' - '+FTamanhos.Getdescricao(Edcodtamanho.asinteger)
        else
          tittamanho:='';
        FRel.AddTit(EdEsto_codigo.Text+' - '+FEstoque.GetDescricao(EdEsto_codigo.text)+titcor+tittamanho);
      end;

// 14.10.08 - caso acerto for por referencia a digitação...
      if Global.Topicos[1204] then
        FRel.AddCol( 70,1,'C','' ,''              ,'Referência'         ,''         ,'',false)
      else
        FRel.AddCol( 70,3,'N','' ,''              ,'Produto'         ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'SubGrupo'       ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Cor'       ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Tamanho'       ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Data'            ,''         ,'',false);
      FRel.AddCol( 60,3,'N','' ,''              ,'Docum.'          ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Tipomov'         ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque    ,'Entradas'         ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque    ,'Saidas'           ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque    ,'Sem Mov.'         ,''         ,'',false);
      if Global.Topicos[1204] then begin
        FRel.AddCol( 60,3,'N','+',f_qtdestoque    ,'Barras'         ,''         ,'',false);
//        FRel.AddCol( 60,3,'N','+',f_qtdestoque    ,'Estoque'        ,''         ,'',false);
// 16.10.09 - retirado - 'esquema adriano'
      end;
//////////////      if (Trim(EdEsto_codigo.text)<>'') then
        FRel.AddCol( 60,3,'N','' ,f_qtdestoque  ,'Saldo'           ,''         ,'',false);

      FRel.AddCol( 60,3,'N','' ,''              ,'Cod.cli/for'     ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Cli/Fornec'      ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Transação'       ,''         ,'',false);
      if Global.Topicos[1204] then
        FRel.AddCol(100,1,'C','' ,''              ,'Obra'       ,''         ,'',false);
// 23.12.08
      if Global.Topicos[1326] then
        FRel.AddCol(060,2,'C','' ,''              ,'Certif.'       ,''         ,'',false);

      if Global.Topicos[1302] then begin
        FRel.AddCol( 60,3,'N','+',f_qtdestoque  ,'Ent Pecs'         ,''         ,'',false);
        FRel.AddCol( 60,3,'N','+',f_qtdestoque  ,'Sai Pec'          ,''         ,'',false);
        FRel.AddCol( 60,3,'N','+',f_qtdestoque  ,'Sem Mov.'         ,''         ,'',false);
//////////////        if (Trim(EdEsto_codigo.text)<>'') then
          FRel.AddCol( 60,3,'N','' ,f_qtdestoque  ,'Saldo'           ,''         ,'',false);
      end;
// 21.11.16
      if Global.Topicos[1232] then begin
        FRel.AddCol(200,1,'C','' ,''              ,'Razão Social'       ,''         ,'',false);
        FRel.AddCol(100,1,'C','' ,''              ,'CNPJ/CPF'       ,''         ,'',false);
      end;
      produto:=Q.FieldByName('move_esto_codigo').AsString;

//      if Trim(EdEsto_codigo.text)<>'' then begin
//        saldoanterior:=FGeral.EstoqueAnterior(produto,unidade,EdDatai.AsDate,saldoanteriorpecas,Q.FieldByName('move_core_codigo').AsInteger,
//                       Q.FieldByName('move_tama_codigo').AsInteger,Q.FieldByName('move_copa_codigo').AsInteger);
        saldoanterior:=FGeral.EstoqueAnterior(produto,unidade,EdDatai.AsDate,saldoanteriorpecas,EdCodcor.asinteger,
                       EdCodtamanho.AsInteger,0);

///      end;

      if (Datetodia(EdDatai.AsDate)>1) and (Trim(EdEsto_codigo.text)<>'') then begin
          while (not Q.eof) and (produto=Q.FieldByName('move_esto_codigo').AsString) and (Q.FieldByName('move_datamvto').AsDateTime<EdDatai.Asdate)
            do begin
            op:=FGeral.GetEntSaiTipoMovto(Q.FieldByName('move_tipomov').AsString);
            if op='+' then begin
              if (Q.FieldByName('esto_embalagem').AsInteger>=1) and ( pos(Q.FieldByName('move_tipomov').AsString,Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai)=0 ) then begin
// 05.09.12
                if (Global.Topicos[1356]) and (Q.FieldByName('move_embalagem').AsInteger>0) then
                  saldoanterior:=saldoanterior+(Q.FieldByName('move_qtde').AsFloat*Q.FieldByName('move_embalagem').AsInteger)
                else
                  saldoanterior:=saldoanterior+(Q.FieldByName('move_qtde').AsFloat*Q.FieldByName('esto_embalagem').AsInteger);
              end else  begin
                  saldoanterior:=saldoanterior+Q.FieldByName('move_qtde').AsFloat;
              end;
              saldoanteriorpecas:=saldoanteriorpecas+Q.FieldByName('move_pecas').AsFloat;
            end else if op='-' then begin
// 13.04.15 - Deverda
              if (Global.Topicos[1382]) and (Q.FieldByName('move_tama_codigo').AsInteger>0) then begin
                 saldoanterior:=saldoanterior-(Q.FieldByName('move_qtde').AsFloat*FTamanhos.GetComprimento(Q.FieldByName('move_tama_codigo').AsInteger) );
                 saldoanteriorpecas:=saldoanteriorpecas-(Q.FieldByName('move_pecas').AsFloat*FTamanhos.GetComprimento(Q.FieldByName('move_tama_codigo').AsInteger) );
              end else begin
                 saldoanterior:=saldoanterior-Q.FieldByName('move_qtde').AsFloat;
                 saldoanteriorpecas:=saldoanteriorpecas-Q.FieldByName('move_pecas').AsFloat;
              end;
            end else if op='B' then begin  // 13.02.06
              saldoanterior:=Q.FieldByName('move_estoque').AsFloat;
              saldoanteriorpecas:=Q.FieldByName('move_estoquepc').AsFloat;
            end;
            Q.Next;
          end;
      end;
//      if Trim(EdEsto_codigo.text)<>'' then begin
          saldo:=saldoanterior;
          saldopecas:=saldoanteriorpecas;
//      end;

      while not Q.eof do begin

//          FRel.AddCel(Q.FieldByName('move_unid_codigo').AsString);
// 14.10.08 - caso acerto for por referencia a digitação...
          if Global.Topicos[1204] then
            FRel.AddCel(Q.FieldByName('esto_referencia').AsString)
          else
            FRel.AddCel(Q.FieldByName('move_esto_codigo').AsString);

          if ( Global.Topicos[1234] ) and ( Q.FieldByName('move_tipomov').AsString=Global.CodBaixaMatSai )
             and
             ( Q.fieldbyname('move_nroobra').asstring<>'' )
             then begin
              FRel.AddCel( FEstoque.GetDescricao(Q.FieldByName('move_nroobra').AsString ) )
       //     else
       //       FRel.AddCel( FEstoque.GetDescricao(Q.FieldByName('move_esto_codigo').AsString ) );

          end else
            FRel.AddCel(Q.FieldByName('esto_descricao').AsString);

          FRel.AddCel(FSubgrupos.GetDescricao(Q.FieldByName('esto_sugr_codigo').AsInteger) );
          FRel.AddCel(Q.FieldByName('core_descricao').AsString);
          FRel.AddCel(Q.FieldByName('tama_descricao').AsString);
          FRel.AddCel(FGEral.formatadata(Q.FieldByName('move_datamvto').AsDatetime));
          FRel.AddCel(Q.FieldByName('move_numerodoc').Asstring);
          FRel.AddCel(Q.FieldByName('move_tipomov').Asstring);
          op:=FGeral.GetEntSaiTipoMovto(Q.FieldByName('move_tipomov').AsString);

          if op='+' then begin
              if ( Q.FieldByName('esto_embalagem').AsInteger>=1 ) and ( pos(Q.FieldByName('move_tipomov').AsString,Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai)=0  ) then begin
// 05.09.12
                if (Global.Topicos[1356]) and (Q.FieldByName('move_embalagem').AsInteger>0) then begin
                  FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat*Q.FieldByName('move_embalagem').AsInteger));
                  saldo:=saldo+(Q.FieldByName('move_qtde').AsFloat*Q.FieldByName('move_embalagem').AsInteger);
                end else begin
                  FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat*Q.FieldByName('esto_embalagem').AsInteger));
                  saldo:=saldo+(Q.FieldByName('move_qtde').AsFloat*Q.FieldByName('esto_embalagem').AsInteger);
               end;
              end else begin
                FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat));
                saldo:=saldo+Q.FieldByName('move_qtde').AsFloat;
              end;
              FRel.addCel('');
              FRel.addCel('');

          end else if op='-' then begin

              FRel.addCel('');
// 13.04.15 - Devereda
              if (Global.Topicos[1382]) and (Q.FieldByName('move_tama_codigo').AsInteger>0) then begin
                FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat*FTamanhos.GetComprimento(Q.FieldByName('move_tama_codigo').AsInteger) ) );
                saldo:=saldo-(Q.FieldByName('move_qtde').AsFloat*FTamanhos.GetComprimento(Q.FieldByName('move_tama_codigo').AsInteger) ) ;
              end else begin
                FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat));
                saldo:=saldo-Q.FieldByName('move_qtde').AsFloat;
              end;
              FRel.addCel('');
          end else begin
              FRel.addCel('');
              FRel.addCel('');
              FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat));
              if op='B' then
                saldo:=Q.FieldByName('move_estoque').AsFloat;
          end;
// 14.10.08
          if (Global.Topicos[1204]) then begin
            if Q.FieldByName('tama_comprimento').AsFloat>0 then
              FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat/(Q.FieldByName('tama_comprimento').AsFloat/1000)))
            else
              FRel.AddCel('');
//            if Q.FieldByName('tama_comprimento').AsFloat>0 then
//              FRel.AddCel(floattostr(Q.FieldByName('move_estoque').AsFloat/(Q.FieldByName('tama_comprimento').AsFloat/1000)))
//            else
//              FRel.AddCel(floattostr(Q.FieldByName('move_estoque').AsFloat))
          end;

  //////////////        if Trim(EdEsto_codigo.text)<>'' then
            FRel.addCel(floattostr(saldo));
//          nome:=Busca(Q.FieldByName('moes_tipocad').AsString,Q.FieldByName('moes_tipo_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('moes_tipo_codigo').Asstring);
          FRel.AddCel(Q.FieldByName('move_tipo_codigo').Asstring);
//          nome:=FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').Asinteger,Q.FieldByName('moes_tipocad').AsString,'N');
          nome:=FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('move_tipo_codigo').Asinteger,Q.FieldByName('move_tipocad').AsString,'N');
          FRel.AddCel(nome);
          FRel.AddCel(Q.FieldByName('move_transacao').Asstring);
          if Global.Topicos[1204] then
            FRel.AddCel(Q.FieldByName('move_nroobra').Asstring);
// 23.12.08
          if Global.Topicos[1326] then
            FRel.AddCel(Q.FieldByName('move_certificado').Asstring);
          if Global.Topicos[1302] then begin
            if op='+' then begin
                FRel.AddCel(floattostr(Q.FieldByName('move_pecas').AsFloat));
                FRel.addCel('');
                FRel.addCel('');
                saldopecas:=saldopecas+Q.FieldByName('move_pecas').AsFloat;
            end else if op='-' then begin
                FRel.addCel('');
                FRel.AddCel(floattostr(Q.FieldByName('move_pecas').AsFloat));
                FRel.addCel('');
                saldopecas:=saldopecas-Q.FieldByName('move_pecas').AsFloat;
            end else begin
                FRel.addCel('');
                FRel.addCel('');
                FRel.AddCel(floattostr(Q.FieldByName('move_pecas').AsFloat));
                if op='B' then
                  saldopecas:=Q.FieldByName('move_estoquepc').AsFloat;
            end;
///////////////////            if Trim(EdEsto_codigo.text)<>'' then
              FRel.addCel(floattostr(saldopecas));
          end;
// 21.11.16
          if Global.Topicos[1232] then begin
            FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('move_tipo_codigo').asinteger,
                         Q.fieldbyname('move_tipocad').asstring,'R') );
            FRel.AddCel( FGeral.Formatacnpjcpf(  FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('move_tipo_codigo').asinteger,
                         Q.fieldbyname('move_tipocad').asstring)  ) );
          end;

          produtoant:=Q.fieldbyname('move_esto_codigo').asstring;
          Q.Next;
// 21.11.16
          produto:=Q.fieldbyname('move_esto_codigo').asstring;
          if not Q.eof then begin
            if produto<>produtoant then begin
              saldoanterior:=FGeral.EstoqueAnterior(produto,unidade,EdDatai.AsDate,saldoanteriorpecas,EdCodcor.asinteger,
                                  EdCodtamanho.AsInteger,0);
              saldo:=saldoanterior;
              FGeral.PulalinhaRel(FREl.GCol.ColCount,08,'Sal.Ant.',12,floattostr(saldoanterior));
            end;
          end;

      end;
    Q.close;
//////////////// - 16.09.08 - movimentação futura - carli - pivato
      if (EdDataf.asdate>Sistema.hoje) and ( not Edesto_codigo.isempty )  then begin
// reservas já feitas no almox
        sqltipomovto:=' and '+FGeral.GetIn('move_tipomov',Global.CodRequisicaoAlmox+';' ,'C');
        sqlproduto:=' and move_esto_codigo='+EdEsto_codigo.AsSql;
        Q:=sqltoquery('select * from movestoque '+
                     ' left join cores on (core_codigo=move_core_codigo)'+
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' left join estoqueqtde on (esqt_esto_codigo=move_esto_codigo and esqt_unid_codigo=move_unid_codigo and esqt_status=''N'')'+
                     ' where move_status=''R'''+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
                     ' and move_datamvto>'+Datetosql(Sistema.hoje)+
//                     sqlinicio+
//                     sqltermino+
//                     sqldocumento+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     sqltipomovto+  // 15.02.06
                     sqlcor+  // 08.09.06
                     sqltamanho+  // 12.09.06
                     sqlobra+   // 03.01.07
                     ' order by move_esto_codigo,move_datamvto,move_numerodoc' );
        while not Q.eof do begin

//          FRel.AddCel(Q.FieldByName('move_unid_codigo').AsString);
          FRel.AddCel(Q.FieldByName('move_esto_codigo').AsString);
          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
          FRel.AddCel(Q.FieldByName('core_descricao').AsString);
          FRel.AddCel(Q.FieldByName('tama_descricao').AsString);
          FRel.AddCel(FGEral.formatadata(Q.FieldByName('move_datamvto').AsDatetime));
          FRel.AddCel(Q.FieldByName('move_numerodoc').Asstring);
          FRel.AddCel(Q.FieldByName('move_tipomov').Asstring);
          op:='-';   // FGeral.GetEntSaiTipoMovto(Q.FieldByName('move_tipomov').AsString);
          if op='+' then begin
              FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat));
              FRel.addCel('');
              FRel.addCel('');
              saldo:=saldo+Q.FieldByName('move_qtde').AsFloat;
          end else if op='-' then begin
              FRel.addCel('');
              FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat));
              FRel.addCel('');
              saldo:=saldo-Q.FieldByName('move_qtde').AsFloat;
          end else begin
              FRel.addCel('');
              FRel.addCel('');
              FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat));
              if op='B' then
                saldo:=Q.FieldByName('move_estoque').AsFloat;
          end;
          if Trim(EdEsto_codigo.text)<>'' then
            FRel.addCel(floattostr(saldo));
//          nome:=Busca(Q.FieldByName('moes_tipocad').AsString,Q.FieldByName('moes_tipo_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('moes_tipo_codigo').Asstring);
          FRel.AddCel(Q.FieldByName('move_tipo_codigo').Asstring);
//          nome:=FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').Asinteger,Q.FieldByName('moes_tipocad').AsString,'N');
          nome:=FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('move_tipo_codigo').Asinteger,Q.FieldByName('move_tipocad').AsString,'N');
          FRel.AddCel(nome);
          FRel.AddCel(Q.FieldByName('move_transacao').Asstring);
          if Global.Topicos[1204] then
//            FRel.AddCel(Q.FieldByName('move_nroobra').Asstring);
            FRel.AddCel(Q.FieldByName('move_nroobra').Asstring);
          if Global.Topicos[1302] then begin
            if op='+' then begin
                FRel.AddCel(floattostr(Q.FieldByName('move_pecas').AsFloat));
                FRel.addCel('');
                FRel.addCel('');
                saldopecas:=saldopecas+Q.FieldByName('move_pecas').AsFloat;
            end else if op='-' then begin
                FRel.addCel('');
                FRel.AddCel(floattostr(Q.FieldByName('move_pecas').AsFloat));
                FRel.addCel('');
                saldopecas:=saldopecas-Q.FieldByName('move_pecas').AsFloat;
            end else begin
                FRel.addCel('');
                FRel.addCel('');
                FRel.AddCel(floattostr(Q.FieldByName('move_pecas').AsFloat));
                if op='B' then
                  saldopecas:=Q.FieldByName('move_estoquepc').AsFloat;
            end;
            if Trim(EdEsto_codigo.text)<>'' then
              FRel.addCel(floattostr(saldopecas));
          end;
          Q.Next;
        end;
        Q.close;
//////////////// - pedido de compras em aberto
        if trim(EdUnid_codigo.text)<>'' then begin
          sqlunidade:=' and '+FGeral.getin('moco_unid_codigo',EdUnid_codigo.text,'C');
        end else begin
          sqlunidade:='';
        end;
        if trim(EdTipomov.text)<>'' then begin
          sqltipomovto:=' and '+FGeral.getin('moco_tipomov',EdTipomov.text,'C');
        end else begin
          sqltipomovto:='';
        end;
        if not EdEsto_codigo.isempty  then
          sqlproduto:=' and moco_esto_codigo='+EdEsto_codigo.assql
        else
          sqlproduto:='';

        Q:=sqltoquery('select * from movcompras'+
                        ' inner join movcomp on ( mocm_numerodoc=moco_numerodoc and mocm_status=''N'' )'+
                        ' inner join estoque on ( esto_codigo=moco_esto_codigo )'+
                        ' left join cores on (core_codigo=moco_core_codigo)'+
                        ' left join tamanhos on (tama_codigo=moco_tama_codigo)'+
                        ' where '+FGeral.getin('moco_status','N','C')+
                        ' and ( (moco_qtde>moco_qtderecebida) or (moco_qtderecebida is null) )'+
                        ' and moco_tipomov<>'+stringtosql(CodOrcamento)+
                          sqlunidade+sqltipomovto+sqlproduto+
                        ' and mocm_dataentrega>'+Datetosql(sistema.hoje)+' order by moco_unid_codigo,moco_numerodoc');

        while not Q.eof do begin

//          FRel.AddCel(Q.FieldByName('move_unid_codigo').AsString);
          FRel.AddCel(Q.FieldByName('moco_esto_codigo').AsString);
          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
          FRel.AddCel(Q.FieldByName('core_descricao').AsString);
          FRel.AddCel(Q.FieldByName('tama_descricao').AsString);
          FRel.AddCel(FGEral.formatadata(Q.FieldByName('moco_datamvto').AsDatetime));
          FRel.AddCel(Q.FieldByName('moco_numerodoc').Asstring);
          FRel.AddCel(Q.FieldByName('moco_tipomov').Asstring);
          qtde:=Q.FieldByName('moco_qtde').ascurrency-Q.FieldByName('moco_qtderecebida').ascurrency;
          op:='+'; // FGeral.GetEntSaiTipoMovto(Q.FieldByName('moco_tipomov').AsString);
          if op='+' then begin
              FRel.AddCel(floattostr(qtde));
              FRel.addCel('');
              FRel.addCel('');
              saldo:=saldo+qtde;
          end else if op='-' then begin
              FRel.addCel('');
              FRel.AddCel(floattostr(qtde));
              FRel.addCel('');
              saldo:=saldo-qtde;
          end else begin
              FRel.addCel('');
              FRel.addCel('');
              FRel.AddCel(floattostr(qtde));
//              if op='B' then
//                saldo:=Q.FieldByName('move_estoque').AsFloat;
          end;
          if Trim(EdEsto_codigo.text)<>'' then
            FRel.addCel(floattostr(saldo));
//          nome:=Busca(Q.FieldByName('moes_tipocad').AsString,Q.FieldByName('moes_tipo_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('moes_tipo_codigo').Asstring);
          FRel.AddCel(Q.FieldByName('moco_tipo_codigo').Asstring);
//          nome:=FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').Asinteger,Q.FieldByName('moes_tipocad').AsString,'N');
          nome:=FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moco_tipo_codigo').Asinteger,Q.FieldByName('moco_tipocad').AsString,'N');
          FRel.AddCel(nome);
          FRel.AddCel(Q.FieldByName('moco_transacao').Asstring);
          if Global.Topicos[1204] then
//            FRel.AddCel(Q.FieldByName('move_nroobra').Asstring);
//            FRel.AddCel(Q.FieldByName('move_nroobra').Asstring);
            FRel.AddCel('');
          if Global.Topicos[1302] then begin
            if op='+' then begin
                FRel.AddCel(floattostr(Q.FieldByName('move_pecas').AsFloat));
                FRel.addCel('');
                FRel.addCel('');
                saldopecas:=saldopecas+Q.FieldByName('move_pecas').AsFloat;
            end else if op='-' then begin
                FRel.addCel('');
                FRel.AddCel(floattostr(Q.FieldByName('move_pecas').AsFloat));
                FRel.addCel('');
                saldopecas:=saldopecas-Q.FieldByName('move_pecas').AsFloat;
            end else begin
                FRel.addCel('');
                FRel.addCel('');
                FRel.AddCel(floattostr(Q.FieldByName('move_pecas').AsFloat));
                if op='B' then
                  saldopecas:=Q.FieldByName('move_estoquepc').AsFloat;
            end;
            if Trim(EdEsto_codigo.text)<>'' then
              FRel.addCel(floattostr(saldopecas));
          end;
          Q.Next;
        end;
        Q.close;
//////////////
      end;
///////////////

      FRel.Video();
    Sistema.EndProcess('');
    Freeandnil(Q);
  end;

  FRelEstoque_ExtratoColunas;         // 11 - 19.12.07

end;


procedure FRelEstoque_Consumo;            // 12
//////////////////////////////////////////////
type TConsumo=record
    produto,descricao,referencia:string;
    mesano01,mesano02,mesano03,mesano04,mesano05,mesano06,mesano07,mesano08,mesano09,mesano10,mesano11,mesano12:string;
    valor01,valor02,valor03,valor04,valor05,valor06,valor07,valor08,valor09,valor10,valor11,valor12:currency;
    qtde01,qtde02,qtde03,qtde04,qtde05,qtde06,qtde07,qtde08,qtde09,qtde10,qtde11,qtde12:currency;
end;

var PConsumo:^TConsumo;
    Lista:TList;
    ListaDocs:TStringList;
    sqlinicio,sqltermino,sqlcor,sqltamanho,sqlstatus,sqlentregas,titvh:string;
    i:integer;
    Qvf:TSqlquery;

    procedure AtualizaLista;
    ///////////////////////////
    var p:integer;
        achou:boolean;

        procedure ConfiguraMesano;
        var data:TDatetime;
        begin
          data:=TExttodate( strzero(Datetodia(FRelEstoque.EdDataf.asdate),2)+strzero(Datetomes(FRelEstoque.EdDatai.asdate),2)+Strzero(Datetoano(FRelEstoque.EdDatai.asdate,true),4) );
          PConsumo.mesano01:=strzero(Datetomes(FRelEstoque.EdDatai.asdate),2)+'/'+Strzero(Datetoano(FRelEstoque.EdDatai.asdate,true),4);
          PConsumo.mesano02:='';PConsumo.mesano03:='';PConsumo.mesano04:='';PConsumo.mesano05:='';PConsumo.mesano06:='';
          PConsumo.mesano07:='';PConsumo.mesano08:='';PConsumo.mesano09:='';PConsumo.mesano10:='';PConsumo.mesano11:='';
          PConsumo.mesano12:='';
          PConsumo.valor01:=0;PConsumo.valor02:=0;PConsumo.valor03:=0;PConsumo.valor04:=0;PConsumo.valor05:=0;PConsumo.valor06:=0;
          PConsumo.valor07:=0;PConsumo.valor08:=0;PConsumo.valor09:=0;PConsumo.valor10:=0;PConsumo.valor11:=0;PConsumo.valor12:=0;
          PConsumo.qtde01:=0;PConsumo.qtde02:=0;PConsumo.qtde03:=0;PConsumo.qtde04:=0;PConsumo.qtde05:=0;PConsumo.qtde06:=0;
          PConsumo.qtde07:=0;PConsumo.qtde08:=0;PConsumo.qtde09:=0;PConsumo.qtde10:=0;PConsumo.qtde11:=0;PConsumo.qtde12:=0;
          data:=DateToDateMesPos(data,1);
//          PConsumo.valor01:=0;
          while data<=FRelEstoque.EdDataf.asdate do begin
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
        var mesano:string;
            unitario:currency;
        begin
            mesano:=strzero(Datetomes(Q.fieldbyname('move_datamvto').asdatetime),2)+'/'+Strzero(Datetoano(Q.fieldbyname('move_datamvto').asdatetime,true),4);

//           unitario:=Q.fieldbyname('move_custo').ascurrency;
//           if unitario=0 then
              unitario:=FEstoque.GetCusto(pconsumo.produto,Q.fieldbyname('move_unid_codigo').asstring,'custo');
            if PConsumo.mesano01=mesano then begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then begin
                PConsumo.valor01:=PConsumo.valor01-(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde01:=PConsumo.qtde01-Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                PConsumo.valor01:=PConsumo.valor01+(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde01:=PConsumo.qtde01+Q.fieldbyname('move_qtde').ascurrency;
              end;
            end;
            if PConsumo.mesano02=mesano then begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then begin
                PConsumo.valor02:=PConsumo.valor02-(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde02:=PConsumo.qtde02-Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                PConsumo.valor02:=PConsumo.valor02+(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde02:=PConsumo.qtde02+Q.fieldbyname('move_qtde').ascurrency;
              end;
            end;
            if PConsumo.mesano03=mesano then begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then begin
                PConsumo.valor03:=PConsumo.valor03-(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde03:=PConsumo.qtde03-Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                PConsumo.valor03:=PConsumo.valor03+(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde03:=PConsumo.qtde03+ Q.fieldbyname('move_qtde').ascurrency;
              end;
            end;
            if PConsumo.mesano04=mesano then begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then begin
                PConsumo.valor04:=PConsumo.valor04-(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde04:=PConsumo.qtde04-Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                PConsumo.valor04:=PConsumo.valor04+(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde04:=PConsumo.qtde04+Q.fieldbyname('move_qtde').ascurrency;
              end;
            end;
            if PConsumo.mesano05=mesano then begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then begin
                PConsumo.valor05:=PConsumo.valor05-(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde05:=PConsumo.qtde05-Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                PConsumo.valor05:=PConsumo.valor05+(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde05:=PConsumo.qtde05+Q.fieldbyname('move_qtde').ascurrency;
              end;
            end;
            if PConsumo.mesano06=mesano then begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then begin
                PConsumo.valor06:=PConsumo.valor06-(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde06:=PConsumo.qtde06-Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                PConsumo.valor06:=PConsumo.valor06+(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde06:=PConsumo.qtde06+Q.fieldbyname('move_qtde').ascurrency;
              end;
            end;
            if PConsumo.mesano07=mesano then begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then begin
                PConsumo.valor07:=PConsumo.valor07-(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde07:=PConsumo.qtde07-Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                PConsumo.valor07:=PConsumo.valor07+(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde07:=PConsumo.qtde07+Q.fieldbyname('move_qtde').ascurrency;
              end;
            end;
            if PConsumo.mesano08=mesano then begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then begin
                PConsumo.valor08:=PConsumo.valor08-(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde08:=PConsumo.qtde08-Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                PConsumo.valor08:=PConsumo.valor08+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde08:=PConsumo.qtde08+Q.fieldbyname('move_qtde').ascurrency;
              end;
            end;
            if PConsumo.mesano09=mesano then begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then begin
                PConsumo.valor09:=PConsumo.valor09-(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde09:=PConsumo.qtde09-Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                PConsumo.valor09:=PConsumo.valor09+(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde09:=PConsumo.qtde09+Q.fieldbyname('move_qtde').ascurrency;
              end;
            end;
            if PConsumo.mesano10=mesano then begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then begin
                PConsumo.valor10:=PConsumo.valor10-(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde10:=PConsumo.qtde10-Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                PConsumo.valor10:=PConsumo.valor10+(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde10:=PConsumo.qtde10+Q.fieldbyname('move_qtde').ascurrency;
              end;
            end;
            if PConsumo.mesano11=mesano then begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then begin
                PConsumo.valor11:=PConsumo.valor11-(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde11:=PConsumo.qtde11-Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                PConsumo.valor11:=PConsumo.valor11+(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde11:=PConsumo.qtde11+Q.fieldbyname('move_qtde').ascurrency;
              end;
            end;
            if PConsumo.mesano12=mesano then begin
              if Q.fieldbyname('move_tipomov').asstring=Global.CodEntradaAlmox then begin
                PConsumo.valor12:=PConsumo.valor12-(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde12:=PConsumo.qtde12-Q.fieldbyname('move_qtde').ascurrency;
              end else begin
                PConsumo.valor12:=PConsumo.valor12+(unitario*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtde12:=PConsumo.qtde12+Q.fieldbyname('move_qtde').ascurrency;
              end;
            end;

        end;

    begin
//////////////////////////////////////////////////////////////////////
      achou:=false;
      for p:=0 to Lista.Count-1 do begin
        PConsumo:=Lista[p];
        if PConsumo.produto=Q.FieldByName('move_esto_codigo').asstring then begin
          achou:=true;
          break
        end;
      end;

      if not achou then begin
        New(PConsumo);
        PConsumo.produto:=Q.FieldByName('move_esto_codigo').asstring;
        PConsumo.descricao:=Q.FieldByName('esto_descricao').asstring;
        PConsumo.referencia:=Q.FieldByName('esto_referencia').asstring;
        ConfiguraMesano;
        AtualizaDadosMesano;
        Lista.add(Pconsumo);
      end else begin
        AtualizaDadosMesano;
      end;

    end;

    function EstanasVendasEntrega(nroreq:string):boolean;
    var x:integer;
    begin
      result:=false;
      for x:=0 to Listadocs.Count-1 do begin
        if pos(nroreq,Listadocs[x])>0 then begin
          result:=true;
          break;
        end;
      end;
    end;

begin
///////////////////////////////////////////////////////////
  with FRelEstoque do begin
    if not FRelEstoque_Execute(12) then Exit;
    Sistema.BeginProcess('Pesquisando');
    if EdEsto_codigo.AsInteger>0 then
       sqlinicio:=' and move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
    else
       sqlinicio:=' and move_datamvto>='+Datetosql(EdDatai.AsDate);
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(EdDatai.AsDate);

    if EdDAtaf.isempty then
       sqltermino:=''
    else
       sqltermino:=' and move_datamvto<='+Datetosql(EdDataf.Asdate);
    if EdDAtai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;
// 08.09.06
    if EdCodcor.isempty then
      sqlcor:=''
    else
      sqlcor:='and move_core_codigo='+Edcodcor.assql;
    if EdCodtamanho.isempty then
      sqltamanho:=''
    else
      sqltamanho:='and move_tama_codigo='+Edcodtamanho.assql;
// 25.08.08
//    sqltipomovto:=' and '+FGEral.GetIN('move_tipomov',Global.CodEntradaprocesso,'C');
// 11.03.09
    if not EdTipomov.isempty then
      sqltipomovto:=' and '+FGEral.GetIN('move_tipomov',EdTipomov.text,'C')
    else
      sqltipomovto:=' and '+FGEral.GetIN('move_tipomov',Global.CodSaidaAlmox+';'+Global.CodEntradaAlmox,'C');
    sqlstatus:=FGeral.Getin('move_status','N,D,E','C');
    if pos(Global.CodRequisicaoAlmox,sqltipomovto)>0 then
      sqlstatus:=FGeral.Getin('move_status','N,D,E,R','C');;
    Q:=sqltoquery('select * from movestoque '+
//                     ' left join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
// 07.08.06 - explosão de materia prima
//                     ' left join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov and moes_numerodoc=move_numerodoc) '+
// 24.04.08 - contagem de estoque
//                     ' left join movesto on (moes_transacao=move_transacao and moes_numerodoc=move_numerodoc and moes_datamvto=move_datamvto) '+
// 30.04.08 - retirado left join movesto para nao duplicar lançamentos como a entrada no almoxarifado com SP
                     ' left join cores on (core_codigo=move_core_codigo)'+
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' left join estoqueqtde on (esqt_esto_codigo=move_esto_codigo and esqt_unid_codigo=move_unid_codigo and esqt_status=''N'')'+
                     ' where '+sqlstatus+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+
                     sqldocumento+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     sqltipomovto+  // 15.02.06
                     sqlcor+  // 08.09.06
                     sqltamanho+  // 12.09.06
                     sqlobra+   // 03.01.07
//                     ' and '+FGeral.RelEstoque('moes_status')+
// 17.03.08
//                     ' and '+FGeral.Getin('moes_status','N;D;E;R','C')+
                     ' order by move_datamvto,move_esto_codigo,move_numerodoc' );
    if Q.eof then begin
      Avisoerro('Nada encontrado para impressão');
      Sistema.EndProcess('');
      Q.close;
      Freeandnil(Q);
      exit;
    end;
    Lista:=TList.create;
    ListaDocs:=TStringList.create;
    if Global.Topicos[1204] then begin
      Sistema.BeginProcess('Checando numero das requisições nas entregas no periodo');
      Qvf:=Sqltoquery('select moes_numerodoc,moes_remessas from movesto '+
                     ' where '+FGeral.Getin('moes_status','N,D,E','C')+
                     ' and '+FGeral.Getin('moes_unid_codigo',EdUnid_codigo.text,'C')+
                     ' and '+FGeral.GetIN('moes_tipomov',global.CodContratoEntrega,'C')+
                     ' and moes_datamvto>='+Datetosql(EdDatai.AsDate)+
                     ' and moes_datamvto<='+Datetosql(EdDataf.Asdate) );
      while not Qvf.eof do begin
        if Listadocs.IndexOf(Qvf.fieldbyname('moes_remessas').asstring)=-1 then
          Listadocs.add(Qvf.fieldbyname('moes_remessas').asstring);
        Qvf.Next;
      end;
    end;
    FGeral.FechaQuery(Qvf);
    titvh:='';
    if Listadocs.Count>0 then begin
      titvh:=' - Requisições Consideradas : ';
      for i:=0 to ListaDocs.Count-1 do begin
        titvh:=titvh+ListaDocs[i]+';';
      end;
    end;
    Sistema.BeginProcess('Somando valores no periodo por produto');
    while not Q.eof do begin
      if Global.Topicos[1204] then begin
        if EstanasVendasEntrega(Q.fieldbyname('move_numerodoc').asstring) then
           AtualizaLista;
      end else
        AtualizaLista;

      Q.Next;
    end;
    if Lista.count=0 then begin
      Avisoerro('Não encontrado requisições ou vendas entrega no período');
      Sistema.EndProcess('');
      Q.close;
      Freeandnil(Q);
      exit;
    end;
    Sistema.BeginProcess('Gerando Relatório');
    FRel.Init('RelConsumoMaterial');
    FRel.AddTit('Relatório de Consumo de Material - Tipo de Movimento '+EdTipomov.text+titvh);
//    FRel.AddTit('Unidade : '+Unidade+' - '+FUnidades.Getnome(Unidade)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,FRelEstoque.EdTipocad.text));
    FRel.AddTit('Unidade : '+EdUnid_codigo.text+' - '+FGeral.Gettitulounidades(EdUnid_codigo.text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,FRelEstoque.EdTipocad.text));
    FRel.AddTit('Periodo : '+formatdatetime('dd/mm/yy',FRelEstoque.EdDatai.AsDate)+' a '+formatdatetime('dd/mm/yy',EdDataf.AsDate)+Montatit(FRelEstoque.EdGrup_codigo.AsInteger,EdSugr_codigo.AsInteger,EdFami_codigo.AsInteger));
    FRel.AddCol( 90,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
    FRel.AddCol( 90,1,'C','' ,''              ,'Referência'          ,''         ,'',false);
    FRel.AddCol(220,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
    PConsumo:=Lista[0];
    FRel.AddCol( 50,3,'N','' ,''              ,PConsumo.mesano01       ,''         ,'',false);
    FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    if trim(PConsumo.mesano02)<>'' then begin
      FRel.AddCol( 50,3,'N','' ,''              ,PConsumo.mesano02       ,''         ,'',false);
      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano03)<>'' then begin
      FRel.AddCol( 50,3,'N','' ,''              ,PConsumo.mesano03       ,''         ,'',false);
      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano04)<>'' then begin
      FRel.AddCol( 50,3,'N','' ,''              ,PConsumo.mesano04       ,''         ,'',false);
      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano05)<>'' then begin
      FRel.AddCol( 50,3,'N','' ,''              ,PConsumo.mesano05       ,''         ,'',false);
      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano06)<>'' then begin
      FRel.AddCol( 50,3,'N','' ,''              ,PConsumo.mesano06       ,''         ,'',false);
      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano07)<>'' then begin
      FRel.AddCol( 50,3,'N','' ,''              ,PConsumo.mesano07       ,''         ,'',false);
      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano08)<>'' then begin
      FRel.AddCol( 50,3,'N','' ,''              ,PConsumo.mesano08       ,''         ,'',false);
      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano09)<>'' then begin
      FRel.AddCol( 50,3,'N','' ,''              ,PConsumo.mesano09       ,''         ,'',false);
      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano10)<>'' then begin
      FRel.AddCol( 50,3,'N','' ,''              ,PConsumo.mesano10       ,''         ,'',false);
      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano11)<>'' then begin
      FRel.AddCol( 50,3,'N','' ,''              ,PConsumo.mesano11       ,''         ,'',false);
      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;
    if trim(PConsumo.mesano12)<>'' then begin
      FRel.AddCol( 50,3,'N','' ,''              ,PConsumo.mesano12       ,''         ,'',false);
      FRel.AddCol( 65,3,'N','+' ,''              ,'Valor'          ,''         ,'',false);
    end;

    for i:=0 to LIsta.count-1 do begin
      Pconsumo:=Lista[i];
// 11.03.09 - caso acerto for por referencia a digitação...
//      if Global.Topicos[1204] then
//      else
      FRel.AddCel(PConsumo.produto);
      FRel.AddCel( PConsumo.referencia );
      FRel.AddCel(PConsumo.descricao);
      FRel.AddCel(floattostr(PConsumo.qtde01));
      FRel.AddCel(floattostr(PConsumo.valor01));
      if trim(PConsumo.mesano02)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde02));
        FRel.AddCel(floattostr(PConsumo.valor02));
      end;
      if trim(PConsumo.mesano03)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde03));
        FRel.AddCel(floattostr(PConsumo.valor03));
      end;
      if trim(PConsumo.mesano04)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde04));
        FRel.AddCel(floattostr(PConsumo.valor04));
      end;
      if trim(PConsumo.mesano05)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde05));
        FRel.AddCel(floattostr(PConsumo.valor05));
      end;
      if trim(PConsumo.mesano06)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde06));
        FRel.AddCel(floattostr(PConsumo.valor06));
      end;
      if trim(PConsumo.mesano07)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde07));
        FRel.AddCel(floattostr(PConsumo.valor07));
      end;
      if trim(PConsumo.mesano08)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde08));
        FRel.AddCel(floattostr(PConsumo.valor08));
      end;
      if trim(PConsumo.mesano09)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde09));
        FRel.AddCel(floattostr(PConsumo.valor09));
      end;
      if trim(PConsumo.mesano10)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde10));
        FRel.AddCel(floattostr(PConsumo.valor10));
      end;
      if trim(PConsumo.mesano11)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde11));
        FRel.AddCel(floattostr(PConsumo.valor11));
      end;
      if trim(PConsumo.mesano12)<>'' then begin
        FRel.AddCel(floattostr(PConsumo.qtde12));
        FRel.AddCel(floattostr(PConsumo.valor12));
      end;
    end;
    FRel.Video();
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

  end;

  FRelEstoque_Consumo;         // 12 - 25.08.08

end;
/////////////////////////////////////////// - 28.08.08
procedure FRelEstoque_ConsumoABC(tipo:string);            // 13

type TConsumo=record
    produto,descricao,referencia,unidade:string;
    mesano01,mesano02,mesano03,mesano04,mesano05,mesano06,mesano07,mesano08,mesano09,mesano10,mesano11,mesano12:string;
    valor01,valor02,valor03,valor04,valor05,valor06,valor07,valor08,valor09,valor10,valor11,valor12,custo:currency;
    qtde01,qtde02,qtde03,qtde04,qtde05,qtde06,qtde07,qtde08,qtde09,qtde10,qtde11,qtde12:currency;
end;

var PConsumo:^TConsumo;
    Lista:TList;
    sqlinicio,sqltermino,sqlcor,sqltamanho,xtabela,sqlstatus,titobra,cliobra,cliente:string;
    i:integer;
    totalqtde,totalvalor,abcqtde,abcvalor:currency;


    procedure AtualizaLista;
    var p:integer;
        achou:boolean;


        procedure AtualizaDadosMesano;
        var mesano:string;
        begin
            mesano:=strzero(Datetomes(Q.fieldbyname('move_datamvto').asdatetime),2)+'/'+Strzero(Datetoano(Q.fieldbyname('move_datamvto').asdatetime,true),4);
//        custo:=FEstoque.GetCusto(Pconsu)
//           custo:=Q.fieldbyname('move_custo').ascurrency;
//           if custo=0 then
              custo:=FEstoque.GetCusto(pconsumo.produto,Q.fieldbyname('move_unid_codigo').asstring,'custo');


              PConsumo.valor01:=PConsumo.valor01+(custo*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde01:=PConsumo.qtde01+Q.fieldbyname('move_qtde').ascurrency;
{
            if PConsumo.mesano02=mesano then begin
              PConsumo.valor02:=PConsumo.valor02+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde02:=PConsumo.qtde02+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano03=mesano then begin
              PConsumo.valor03:=PConsumo.valor03+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde03:=PConsumo.qtde03+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano04=mesano then begin
              PConsumo.valor04:=PConsumo.valor04+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde04:=PConsumo.qtde04+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano05=mesano then begin
              PConsumo.valor05:=PConsumo.valor05+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde05:=PConsumo.qtde05+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano06=mesano then begin
              PConsumo.valor06:=PConsumo.valor06+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde06:=PConsumo.qtde06+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano07=mesano then begin
              PConsumo.valor07:=PConsumo.valor07+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde07:=PConsumo.qtde07+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano08=mesano then begin
              PConsumo.valor08:=PConsumo.valor08+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde08:=PConsumo.qtde08+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano09=mesano then begin
              PConsumo.valor09:=PConsumo.valor09+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde09:=PConsumo.qtde09+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano10=mesano then begin
              PConsumo.valor10:=PConsumo.valor10+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde10:=PConsumo.qtde10+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano11=mesano then begin
              PConsumo.valor11:=PConsumo.valor11+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde11:=PConsumo.qtde11+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano12=mesano then begin
              PConsumo.valor12:=PConsumo.valor12+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde12:=PConsumo.qtde12+Q.fieldbyname('move_qtde').ascurrency;
            end;
}
        end;

    begin

      achou:=false;
      for p:=0 to Lista.Count-1 do begin
        PConsumo:=Lista[p];
        if tipo='C' then begin
          if PConsumo.produto=Q.FieldByName('move_esto_codigo').asstring then begin
            achou:=true;
            break
          end;
        end else begin
          if PConsumo.produto=Q.FieldByName('esqt_esto_codigo').asstring then begin
            achou:=true;
            break
          end;
        end;
      end;

      if not achou then begin
        New(PConsumo);
        if tipo='C' then
          PConsumo.produto:=Q.FieldByName('move_esto_codigo').asstring
        else
          PConsumo.produto:=Q.FieldByName('esqt_esto_codigo').asstring;
        PConsumo.descricao:=Q.FieldByName('esto_descricao').asstring;
        PConsumo.referencia:=Q.fieldbyname('esto_referencia').asstring;
        PConsumo.unidade:=Q.fieldbyname('esto_unidade').asstring;
        PConsumo.valor01:=0;
        PConsumo.qtde01:=0;
        PConsumo.custo:=0;
        if tipo='C' then
          AtualizaDadosMesano
        else begin
          custo:=FEstoque.GetCusto(pconsumo.produto,Q.fieldbyname('esqt_unid_codigo').asstring,'custo');
          PConsumo.valor01:=Q.fieldbyname('esqt_qtde').ascurrency*custo;
          PConsumo.qtde01:=Q.fieldbyname('esqt_qtde').ascurrency;
          Pconsumo.custo:=custo;
        end;
        Lista.add(Pconsumo);
      end else begin
        if tipo='C' then
          AtualizaDadosMesano
        else begin
          PConsumo.valor01:=PConsumo.valor01+Q.fieldbyname('esqt_qtde').ascurrency*Pconsumo.custo;
          PConsumo.qtde01:=PConsumo.qtde01+Q.fieldbyname('esqt_qtde').ascurrency;
        end;
      end;
    end;

    procedure Somalista;
    var p:integer;
    begin
       for p:=0 to Lista.count-1 do begin
         PConsumo:=Lista[p];
         totalqtde:=totalqtde+Pconsumo.qtde01;
         totalvalor:=totalvalor+Pconsumo.valor01;
       end;
    end;


begin

  if tipo='C' then
    xtabela:='movestoque'
  else
    xtabela:='estoqueqtde';
  with FRelEstoque do begin
    if not FRelEstoque_Execute(13) then Exit;
    Sistema.BeginProcess('Pesquisando');
    cliente:='';
    if tipo='C' then begin
      if EdEsto_codigo.AsInteger>0 then
         sqlinicio:=' and move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
  //       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
      else
         sqlinicio:=' and move_datamvto>='+Datetosql(EdDatai.AsDate);
  //       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(EdDatai.AsDate);

      if EdDAtaf.isempty then
         sqltermino:=''
      else
         sqltermino:=' and move_datamvto<='+Datetosql(EdDataf.Asdate);
      if EdCodcor.isempty then
        sqlcor:=''
      else
        sqlcor:='and move_core_codigo='+Edcodcor.assql;
      if EdCodtamanho.isempty then
        sqltamanho:=''
      else
        sqltamanho:='and move_tama_codigo='+Edcodtamanho.assql;
//      sqltipomovto:=' and '+FGEral.GetIN('move_tipomov',Global.CodEntradaprocesso,'C');
// 11.03.09
      if not EdTipomov.isempty then
        sqltipomovto:=' and '+FGEral.GetIN('move_tipomov',EdTipomov.text,'C')
      else
//        sqltipomovto:=' and '+FGEral.GetIN('move_tipomov',Global.CodSaidaAlmox,'C');
// 20.04.10 - Abra - Paulo
        sqltipomovto:=' and '+FGEral.GetIN('move_tipomov',Global.CodSaidaAlmox+';'+Global.CodCompra100+';'+Global.CodCompraMatConsumo,'C');
      sqlstatus:=FGeral.Getin('move_status','N,D,E','C');
      if pos(Global.CodRequisicaoAlmox,sqltipomovto)>0 then
        sqlstatus:=FGeral.Getin('move_status','N,D,E,R','C');;
      if EdDAtai.isempty then
         sqlinicio:=''
      else
         sqlinicio:=sqlinicio;


      Q:=sqltoquery('select * from movestoque '+
                     ' left join cores on (core_codigo=move_core_codigo)'+
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' left join estoqueqtde on (esqt_esto_codigo=move_esto_codigo and esqt_unid_codigo=move_unid_codigo and esqt_status=''N'')'+
                     ' where '+sqlstatus+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+
                     sqldocumento+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     sqltipomovto+  // 15.02.06
                     sqlcor+  // 08.09.06
                     sqltamanho+  // 12.09.06
                     sqlobra+   // 03.01.07
                     ' order by move_datamvto,move_esto_codigo,move_numerodoc' );

    end else begin

      sqlinicio:='';
      sqltermino:='';
      if EdCodcor.isempty then
        sqlcor:=''
      else
        sqlcor:='and esgr_core_codigo='+Edcodcor.assql;
      if EdCodtamanho.isempty then
        sqltamanho:=''
      else
        sqltamanho:='and esgr_tama_codigo='+Edcodtamanho.assql;
      sqltipomovto:='';
      Q:=sqltoquery('select * from estoqueqtde '+
                     ' inner join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' where esqt_status=''N'''+
                     ' and '+FGeral.Getin('esqt_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+
                     sqldocumento+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     sqltipomovto+  // 15.02.06
                     sqlcor+  // 08.09.06
                     sqltamanho+  // 12.09.06
                     ' order by esto_descricao' );

    end;
    if Q.eof then begin
      Avisoerro('Nada encontrado para impressão');
      Sistema.EndProcess('');
      Q.close;
      Freeandnil(Q);
      exit;
    end;
    Lista:=TList.create;
    Sistema.beginprocess('Somando itens');
    while not Q.eof do begin
      if (not EdNroobra.IsEmpty) and ( trim(cliente)='' ) and (Q.fieldbyname('move_tipomov').asstring=Global.CodSaidaAlmox) then begin
        cliente:= FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('move_tipo_codigo').asinteger,'C','N') ;
      end;
      AtualizaLista;
      Q.Next;
    end;
    totalqtde:=0;
    totalvalor:=0;
    SomaLista;
    unidade:=copy(EdUnid_codigo.text,1,3);
    Sistema.BeginProcess('Gerando Relatório');
    if tipo='C' then begin
// 20.04.10
      titobra:='';
      cliobra:='';
      if not EdNroobra.IsEmpty then begin
        titobra:=' - Obra : '+EdNroobra.text;
        cliobra:=' - Cliente : '+cliente;
      end;
      FRel.Init('RelAbcConsumoMaterial');
      FRel.AddTit('Curva ABC Relatório de Consumo de Material - Tipo de Movimento '+EdTipomov.text+titobra+cliobra);
      FRel.AddTit('Unidade : '+Unidade+' - '+FUnidades.Getnome(Unidade)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
      FRel.AddTit('Periodo : '+formatdatetime('dd/mm/yy',EdDatai.AsDate)+' a '+formatdatetime('dd/mm/yy',EdDataf.AsDate)+Montatit(EdGrup_codigo.AsInteger,EdSugr_codigo.AsInteger,EdFami_codigo.AsInteger));
    end else begin
      FRel.Init('RelAbcSaldoEstoque');
      FRel.AddTit('Curva ABC pelo Saldo em Estoque');
      FRel.AddTit('Unidade : '+Unidade+' - '+FUnidades.Getnome(Unidade)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
    end;

    if Global.Topicos[1204] then
      FRel.AddCol( 90,1,'C','' ,''              ,'Referência'          ,''         ,'',false)
    else
      FRel.AddCol( 90,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
    FRel.AddCol(220,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
    FRel.AddCol(045,1,'C','' ,''              ,'Unidade'       ,''         ,'',false);
    PConsumo:=Lista[0];

    FRel.AddCol( 70,3,'N','+' ,''                ,'Qtde'       ,''         ,'',false);
    FRel.AddCol( 50,3,'N',''  ,f_cr              ,'% Abc Q.'       ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,f_cr              ,'Valor'          ,''         ,'',false);
    FRel.AddCol( 50,3,'N',''  ,f_cr              ,'% Abc V.'       ,''         ,'',false);

    for i:=0 to LIsta.count-1 do begin
      Pconsumo:=Lista[i];
// 11.03.09 - caso acerto for por referencia a digitação...
      if Global.Topicos[1204] then
         FRel.AddCel( PConsumo.referencia )
      else
        FRel.AddCel(PConsumo.produto);
      FRel.AddCel(PConsumo.descricao);
      FRel.AddCel(PConsumo.unidade);
      FRel.AddCel(floattostr(PConsumo.qtde01));
      if totalqtde>0 then
        abcqtde:=(PConsumo.qtde01/totalqtde)*100
      else
        abcqtde:=0;
      if totalvalor>0 then
        abcvalor:=(PConsumo.valor01/totalvalor)*100
      else
        abcvalor:=0;
      FRel.AddCel(floattostr(abcqtde));
      FRel.AddCel(floattostr(PConsumo.valor01));
      FRel.AddCel(floattostr(abcvalor));

    end;
    FRel.Video();
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

  end;

  FRelEstoque_ConsumoABC(tipo);         // 13 - 28.08.08

end;

procedure FRelEstoque_SemMovimento;             // 14
////////////////////////////////////////
var unidade,produto,op,sqlinicio,nome,sqltermino,grade,sqlcor,sqltamanho:string;
    saldoanterior,saldo,pentradas,psaidas,psemmov,tentradas,tsaidas,tsemmov,
    pentradaspec,psaidaspec,psemmovpec,tentradaspec,tsaidaspec,tsemmovpec:currency;
    margem,x:integer;
    QBusca:TSqlquery;

    function Busca(Tipo,codigo:string;tipomov:string=''):string;
    begin

      if pos(tipomov,Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.CodTransfEnt+';'+Global.CodTransfSai)>0 then begin
        result:='';
        if pos(tipomov,Global.CodTransfEntrada+';'+Global.CodTransfEnt)>0 then begin
          QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
          if not QBusca.eof then
            result:=QBusca.fieldbyname('forn_nome').AsString
        end else begin
          QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
          if not QBusca.eof then
            result:=QBusca.fieldbyname('clie_nome').AsString
        end;

      end else if tipo='C' then begin
        QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('clie_nome').AsString
        else
          result:=''
      end else if tipo='F' then begin
        QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('forn_nome').AsString
        else
          result:=''
      end else begin
        QBusca:=sqltoquery('select unid_nome,unid_reduzido from unidades where unid_codigo='+stringtosql(formatfloat('000',strtocurr(codigo))));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('unid_reduzido').AsString
        else
          result:=''
      end;
      QBusca.Free;
    end;

    function GetUsuarioLog(xtransacao:string):integer;
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select * from log where log_transacaocanc='+stringtosql(xtransacao));
      if not Q.eof then
        result:=Q.fieldbyname('log_usua_canc').asinteger
      else
        result:=0;
      FGeral.FechaQuery(Q);
    end;

begin

  with FRelEstoque do begin
    if not FRelEstoque_Execute(14) then Exit;
    Sistema.BeginProcess('Pesquisando movimento');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);
    if EdEsto_codigo.AsInteger>0 then
       sqlinicio:=' and move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
    else
       sqlinicio:=' and move_datamvto>='+Datetosql(EdDatai.AsDate);

    if EdDAtaf.isempty then
       sqltermino:=''
    else
       sqltermino:=' and move_datamvto<='+Datetosql(EdDataf.Asdate);
    if EdDAtai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;
// 08.09.06
    if EdCodcor.isempty then
      sqlcor:=''
    else
      sqlcor:='and move_core_codigo='+Edcodcor.assql;
    if EdCodtamanho.isempty then
      sqltamanho:=''
    else
      sqltamanho:='and move_tama_codigo='+Edcodtamanho.assql;
    if EdTipomov.isempty then
      sqltipomovto:=' and '+FGeral.GetIn('move_tipomov',Global.TiposSaida,'C');
    Q:=sqltoquery('select * from estoqueqtde '+
                     ' inner join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' inner join grupos on ( grup_codigo=esto_grup_codigo )'+
                     ' where esqt_status=''N'''+
                     ' and '+FGeral.Getin('esqt_unid_codigo',EdUnid_codigo.text,'C')+
                     ' and esqt_esto_codigo not in ('+
                     ' select move_esto_codigo from movestoque '+
                     ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' inner join grupos on ( grup_codigo=esto_grup_codigo )'+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     sqltipomovto+  // 15.02.06
//                     sqlcor+  // 08.09.06
//                     sqltamanho+  // 12.09.06
                     ' and '+FGeral.RelEstoque('moes_status')+')'+
                     ' order by esto_descricao' );
     if Q.Eof then begin
        Avisoerro('Nada encontrado para impressão');
        FGeral.fechaquery(Q);
        Sistema.EndProcess('');
        exit;
     end;
     Sistema.BeginProcess('Gerando Relatório');
     FRel.Init('ProdutosSemMovimento');
     FRel.AddTit('Relatório de Produtos não Movimentados - Período : '+FGeral.formatadata(EdDatai.asdate)+' a '+FGeral.formatadata(EdDAtaf.asdate));
     FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));
//      FRel.AddCol( 45,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
     FRel.AddCol( 50,1,'N','' ,''              ,'Grupo'           ,''         ,'',false);
     FRel.AddCol(100,1,'C','' ,''              ,'Desc. Grupo'     ,''         ,'',false);
     FRel.AddCol( 80,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
     FRel.AddCol(150,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
     FRel.AddCol( 50,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
     FRel.AddCol( 70,1,'D','' ,''              ,'Ult.Entrada'         ,''         ,'',false);
     FRel.AddCol( 70,1,'D','' ,''              ,'Ult.Saida'         ,''         ,'',false);
     while not Q.eof do begin
        FRel.AddCel(Q.FieldByName('esto_grup_codigo').AsString);
        FRel.AddCel(Q.FieldByName('grup_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esqt_esto_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esto_unidade').AsString);
        FRel.AddCel(Q.FieldByName('Esqt_dtultcompra').AsString);
        FRel.AddCel(Q.FieldByName('Esqt_dtultvenda').AsString);
        Q.Next;
     end;
     FGeral.fechaquery(Q);
     FRel.Video;
     Sistema.EndProcess('');
  end;
  FRelEstoque_SemMovimento;

end;

//////////////////////////////////////////////////////////
procedure FRelEstoque_CreditoMadeira;             // 15
//////////////////////////////////////////////////////////////////////////////
var unidade,produto,op,sqlinicio,nome,sqltermino,grade,sqlcor,sqltamanho,titcor,tittamanho,
    sqlcertificado,titulo:string;
    saldoanterior,saldo,pentradas,psaidas,psemmov,tentradas,tsaidas,tsemmov,
    qtde,fatorconversao,entradas,qtdsai:currency;
    margem,x:integer;
    QBusca:TSqlquery;

    function Busca(Tipo,codigo:string;tipomov:string=''):string;
    begin

      if pos(tipomov,Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.CodTransfEnt+';'+Global.CodTransfSai)>0 then begin
        result:='';
        if pos(tipomov,Global.CodTransfEntrada+';'+Global.CodTransfEnt)>0 then begin
          QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
          if not QBusca.eof then
            result:=QBusca.fieldbyname('forn_nome').AsString
        end else begin
          QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
          if not QBusca.eof then
            result:=QBusca.fieldbyname('clie_nome').AsString
        end;

      end else if tipo='C' then begin
        QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('clie_nome').AsString
        else
          result:=''
      end else if tipo='F' then begin
        QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('forn_nome').AsString
        else
          result:=''
      end else begin
        QBusca:=sqltoquery('select unid_nome,unid_reduzido from unidades where unid_codigo='+stringtosql(formatfloat('000',strtocurr(codigo))));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('unid_reduzido').AsString
        else
          result:=''
      end;
      QBusca.Free;
    end;

    function GetTipoFsc(qtipo:string):string;
    var i:integer;
    begin
      result:='';
      for i:=0 to FRelEstoque.EdCertificado.Items.Count-1 do begin
      if copy(FRelEstoque.EdCertificado.Items[i],1,1)=qtipo then
        result:=copy(FRelEstoque.EdCertificado.Items[i],4,15);
      end;
    end;

begin
////////////////////////////////////////////////////////////////////

  with FRelEstoque do begin
    if not FRelEstoque_Execute(15) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);
    if EdEsto_codigo.AsInteger>0 then
       sqlinicio:=' and move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
    else
       sqlinicio:=' and move_datamvto>='+Datetosql(EdDatai.AsDate);
//       sqlinicio:=' and detalhe.move_datamvto>='+Datetosql(EdDatai.AsDate);

    if EdDAtaf.isempty then
       sqltermino:=''
    else
       sqltermino:=' and move_datamvto<='+Datetosql(EdDataf.Asdate);
    if EdDAtai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;
// 08.09.06
    if EdCodcor.isempty then
      sqlcor:=''
    else
      sqlcor:='and move_core_codigo='+Edcodcor.assql;
    if EdCodtamanho.isempty then
      sqltamanho:=''
    else
      sqltamanho:='and move_tama_codigo='+Edcodtamanho.assql;
// 10.04.09
//////////////////
    {
    if Global.Usuario.OutrosAcessos[0052] then begin
      sqlcertificado:='';
      if EdCertificado.text<>'T' then
        sqlcertificado:=' and move_certificado='+EdCertificado.Assql;
    end else begin
      sqlcertificado:=' and ( (move_certificado is not null) and (move_certificado<>''N'') )';
      if EdCertificado.text<>'T' then
        sqlcertificado:=' and move_certificado='+EdCertificado.Assql;
    end;
    }
//////////////
// 04.04.11 - saldo somente de certificados - nao pedir pra escolher
//  Antes 1-FSC Puro e 2-FSC Misto...por isto foi feito 3 como fsc controlado
    if EdCertificado.text='1' then
      sqlcertificado:=' and '+FGeral.GetIN('move_certificado','1;2','C')
    else if EdCertificado.text='3' then
      sqlcertificado:=' and '+FGeral.GetIN('move_certificado',EdCertificado.text,'C')
    else
      sqlcertificado:=' and '+FGeral.GetIN('move_certificado','1;2;3','C');

    Q:=sqltoquery('select * from movestoque '+
                     ' left join cores on (core_codigo=move_core_codigo)'+
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' inner join subgrupos on (sugr_codigo=Esto_sugr_codigo)'+
                     ' left join estoqueqtde on (esqt_esto_codigo=move_esto_codigo and esqt_unid_codigo=move_unid_codigo and esqt_status=''N'')'+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
//                     ' and move_certificado=''S'''+
                     sqlcertificado+   // 10.04.09
                     sqlinicio+
                     sqltermino+
                     sqldocumento+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     sqltipomovto+  // 15.02.06
                     sqlcor+  // 08.09.06
                     sqltamanho+  // 12.09.06
                     sqlobra+   // 03.01.07
//                     ' order by move_esto_codigo,move_datamvto,move_numerodoc' );
// 13.04.10 - Volmar
                     ' order by move_datamvto,move_esto_codigo,move_numerodoc' );


//////////////////////////////////////////////////////////////////////////////////
      unidade:=copy(FRelEstoque.EdUNid_codigo.Text,1,3);
      fatorconversao:=FGeral.GetConfig1AsFloat('percconvm3');
      titulo:=' - Todos os FSC';
      if EdCertificado.text<>'T' then
        titulo:=' - '+EdCertificado.Text+' - '+GetTipoFsc(EdCertificado.Text);

      FRel.Init('ExtratoCreditoMadeira');
      FRel.AddTit('Extrato de Movimentação de Itens Certificados - Período : '+FGeral.formatadata(EdDatai.asdate)+' a '+FGeral.formatadata(EdDAtaf.asdate));
      FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text)+titulo);
      if Global.Topicos[1204] then
        FRel.AddCol( 70,1,'C','' ,''              ,'Referência'         ,''         ,'',false)
      else
        FRel.AddCol( 70,3,'N','' ,''              ,'Produto'         ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'SubGrupo'       ,''         ,'',false);
//      FRel.AddCol(100,1,'C','' ,''              ,'Cor'       ,''         ,'',false);
//      FRel.AddCol(100,1,'C','' ,''              ,'Tamanho'       ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Data'            ,''         ,'',false);
      FRel.AddCol( 60,3,'N','' ,''              ,'Docum.'          ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Tipomov'         ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque    ,'Ent. Ton'         ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque    ,'Ent. M3'         ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque    ,'Saidas M3'           ,''         ,'',false);
      FRel.AddCol( 60,3,'N','' ,f_qtdestoque    ,'Saldo M3'           ,''         ,'',false);
      FRel.AddCol( 60,3,'N','' ,''              ,'Cod.cli/for'     ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Cli/Fornec'      ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Transação'       ,''         ,'',false);

      produto:=Q.FieldByName('move_esto_codigo').AsString;
      if Trim(EdEsto_codigo.text)<>'' then begin
//        saldoanterior:=FGeral.EstoqueAnterior(produto,unidade,EdDatai.AsDate,saldoanteriorpecas,Q.FieldByName('move_core_codigo').AsInteger,
//                       Q.FieldByName('move_tama_codigo').AsInteger,Q.FieldByName('move_copa_codigo').AsInteger);
//        saldoanterior:=FGeral.EstoqueAnterior(produto,unidade,EdDatai.AsDate,saldoanteriorpecas,EdCodcor.asinteger,
//                       EdCodtamanho.AsInteger,0);

          saldoanterior:=0;
      end;

      while not Q.eof do begin

//          FRel.AddCel(Q.FieldByName('move_unid_codigo').AsString);
// 14.10.08 - caso acerto for por referencia a digitação...
          if Global.Topicos[1204] then
            FRel.AddCel(Q.FieldByName('esto_referencia').AsString)
          else
            FRel.AddCel(Q.FieldByName('move_esto_codigo').AsString);
          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
          FRel.AddCel(FSubgrupos.GetDescricao(Q.FieldByName('esto_sugr_codigo').AsInteger) );
//          FRel.AddCel(Q.FieldByName('core_descricao').AsString);
//          FRel.AddCel(Q.FieldByName('tama_descricao').AsString);
          FRel.AddCel(FGEral.formatadata(Q.FieldByName('move_datamvto').AsDatetime));
          FRel.AddCel(Q.FieldByName('move_numerodoc').Asstring);
          FRel.AddCel(Q.FieldByName('move_tipomov').Asstring);
          if pos( Q.FieldByName('move_tipomov').AsString,Global.TiposEntrada ) > 0 then
            op:='+'
          else
            op:='-';
          if op='+' then begin
              FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat));
              if fatorconversao>0 then begin
                FRel.AddCel(floattostr(Q.FieldByName('move_qtde').AsFloat/fatorconversao));
                saldo:=saldo+Q.FieldByName('move_qtde').AsFloat/fatorconversao;
              end else begin
                FRel.addCel('');
                saldo:=saldo+Q.FieldByName('move_qtde').AsFloat;
              end;
              FRel.addCel('');
          end else if op='-' then begin
              FRel.addCel('');
              FRel.addCel('');
// se for compensado ( familia 5 ) somar 12% na quantidade
// 29.03.11 - 04.04.2011 - 06.04.11
              if ( Q.fieldbyname('move_tama_codigo').asinteger>0 ) and (Q.fieldbyname('esto_unidade').asstring='PC') then begin
                qtdsai:=Q.fieldbyname('move_qtde').ascurrency*FTamanhos.GetCubagem(Q.fieldbyname('move_tama_codigo').asinteger);
              end else
                qtdsai:=Q.FieldByName('move_qtde').AsFloat;
              qtdsai:=qtdsai+( qtdsai*(Q.fieldbyname('sugr_percperda').AsCurrency/100) );
              FRel.AddCel(floattostr(qtdsai));
              saldo:=saldo-qtdsai;
          end;

          FRel.addCel(floattostr(saldo));
//          nome:=Busca(Q.FieldByName('moes_tipocad').AsString,Q.FieldByName('moes_tipo_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('moes_tipo_codigo').Asstring);
          FRel.AddCel(Q.FieldByName('move_tipo_codigo').Asstring);
//          nome:=FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').Asinteger,Q.FieldByName('moes_tipocad').AsString,'N');
          nome:=FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('move_tipo_codigo').Asinteger,Q.FieldByName('move_tipocad').AsString,'N');
          FRel.AddCel(nome);
          FRel.AddCel(Q.FieldByName('move_transacao').Asstring);

          Q.Next;

      end;
    Q.close;
///////////////

    FRel.Video();
    Sistema.EndProcess('');
    Freeandnil(Q);
  end;

  FRelEstoque_CreditoMadeira;         // 15

end;


///////////////

procedure FRelEstoque_PrevistoRealizado;           // 16
//////////////////////////////////////////////////////////////
type TConsumo=record
    produto,descricao,referencia,unidade:string;
    mesano01:string;
    vlrprevisto,custo,vlrrealizado:currency;
    qtdeprevista,qtderealizada:currency;
end;

var PConsumo:^TConsumo;
    Lista:TList;
    sqlinicio,sqltermino,sqlcor,sqltamanho,xtabela,sqlstatus,tipo,SitAprovada,NomeObraAprovada:string;
    i:integer;
    totalqtdeprev,totalvalorprev,abcqtde,abcvalor,totalqtdereal,totalvalorreal,
    dif,vlrmotorizacao,PrecoVendaObraAprovada,divisorprev,divisorreal,CustoObraAprovada,
    vlrcomponentes,vlrcremonas:currency;

    QI,QOrcamencal:TSqlquery;

    procedure AtualizaListaOrca;
    var p:integer;
        achou:boolean;

        procedure AtualizaDadosMesano(xtipomov:string);
        var mesano:string;
        begin
          custo:=Q.fieldbyname('orcd_unitario').ascurrency;
          PConsumo.vlrprevisto:=PConsumo.vlrprevisto+(custo*Q.fieldbyname('orcd_qtde').ascurrency);
          PConsumo.qtdeprevista:=PConsumo.qtdeprevista+Q.fieldbyname('orcd_qtde').ascurrency;
        end;

    begin
    //////////////////////////////////////////////////
      achou:=false;
      for p:=0 to Lista.Count-1 do begin
        PConsumo:=Lista[p];
        if tipo='C' then begin
          if PConsumo.produto=Q.FieldByName('orcd_codigo').asstring then begin
            achou:=true;
            break
          end;
        end else begin
          if PConsumo.produto=Q.FieldByName('orcd_codigo').asstring then begin
            achou:=true;
            break
          end;
        end;
      end;

      if not achou then begin
        New(PConsumo);
        if tipo='C' then
          PConsumo.produto:=Q.FieldByName('orcd_codigo').asstring
        else
          PConsumo.produto:=Q.FieldByName('orcd_codigo').asstring;
//        PConsumo.descricao:=Q.FieldByName('orcd_nome').asstring;
        PConsumo.descricao:=Q.FieldByName('orcd_descricao').asstring;
        PConsumo.referencia:=Q.FieldByName('orcd_codigo').asstring;;
        PConsumo.unidade:=Q.fieldbyname('orcd_unidade').asstring;
        PConsumo.vlrprevisto:=0;
        PConsumo.vlrrealizado:=0;
        PConsumo.qtdeprevista:=0;
        PConsumo.qtderealizada:=0;
        PConsumo.custo:=0;
        if tipo='C' then
          AtualizaDadosMesano('X#')
        else begin
//          custo:=FEstoque.GetCusto(pconsumo.produto,Q.fieldbyname('esqt_unid_codigo').asstring,'custo');
//          PConsumo.valor01:=Q.fieldbyname('esqt_qtde').ascurrency*custo;
//          PConsumo.qtde01:=Q.fieldbyname('esqt_qtde').ascurrency;
          Pconsumo.custo:=0;
        end;
        Lista.add(Pconsumo);
      end else begin
        if tipo='C' then
          AtualizaDadosMesano('X@')
        else begin
//          PConsumo.valor01:=PConsumo.valor01+Q.fieldbyname('esqt_qtde').ascurrency*Pconsumo.custo;
//          PConsumo.qtde01:=PConsumo.qtde01+Q.fieldbyname('esqt_qtde').ascurrency;
        end;
      end;
    end;
/////////////////////////////////////////////////////////////////////////////

    procedure AtualizaListaOrcaInsumos;
    var p:integer;
        achou:boolean;

        procedure AtualizaDadosMesano(xtipomov:string);
        var mesano:string;
        begin
          custo:=Q.fieldbyname('orin_precouni').ascurrency;
          PConsumo.vlrprevisto:=PConsumo.vlrprevisto+(custo*Q.fieldbyname('orin_pesoreal').ascurrency);
          PConsumo.qtdeprevista:=PConsumo.qtdeprevista+Q.fieldbyname('orin_pesoreal').ascurrency;
        end;

    begin
    //////////////////////////////////////////////////
      achou:=false;
      for p:=0 to Lista.Count-1 do begin
        PConsumo:=Lista[p];
        if tipo='C' then begin
          if PConsumo.produto=Q.FieldByName('orin_esto_codigo').asstring then begin
            achou:=true;
            break
          end;
        end else begin
          if PConsumo.produto=Q.FieldByName('orin_esto_codigo').asstring then begin
            achou:=true;
            break
          end;
        end;
      end;

      if not achou then begin
        New(PConsumo);
        if tipo='C' then
          PConsumo.produto:=Q.FieldByName('orin_esto_codigo').asstring
        else
          PConsumo.produto:=Q.FieldByName('orin_esto_codigo').asstring;
//        PConsumo.descricao:=Q.FieldByName('orin_nome').asstring;
        PConsumo.descricao:='';
        PConsumo.referencia:=Q.FieldByName('orin_esto_codigo').asstring;;
        PConsumo.unidade:='KG';
        PConsumo.vlrprevisto:=0;
        PConsumo.vlrrealizado:=0;
        PConsumo.qtdeprevista:=0;
        PConsumo.qtderealizada:=0;
        PConsumo.custo:=0;
        if tipo='C' then
          AtualizaDadosMesano('X#')
        else begin
//          custo:=FEstoque.GetCusto(pconsumo.produto,Q.fieldbyname('esqt_unid_codigo').asstring,'custo');
//          PConsumo.valor01:=Q.fieldbyname('esqt_qtde').ascurrency*custo;
//          PConsumo.qtde01:=Q.fieldbyname('esqt_qtde').ascurrency;
          Pconsumo.custo:=0;
        end;
        Lista.add(Pconsumo);
      end else begin
        if tipo='C' then
          AtualizaDadosMesano('X@')
        else begin
//          PConsumo.valor01:=PConsumo.valor01+Q.fieldbyname('esqt_qtde').ascurrency*Pconsumo.custo;
//          PConsumo.qtde01:=PConsumo.qtde01+Q.fieldbyname('esqt_qtde').ascurrency;
        end;
      end;
    end;


//////////////////////////////////////////////////////////////////////////
    procedure AtualizaLista;
    var p:integer;
        achou:boolean;


        procedure AtualizaDadosMesano(xtipomov:string);
        var mesano:string;
        begin
//            mesano:=strzero(Datetomes(Q.fieldbyname('move_datamvto').asdatetime),2)+'/'+Strzero(Datetoano(Q.fieldbyname('move_datamvto').asdatetime,true),4);
//        custo:=FEstoque.GetCusto(Pconsu)
//           custo:=Q.fieldbyname('move_custo').ascurrency;
//           if custo=0 then
              custo:=FEstoque.GetCusto(pconsumo.produto,Q.fieldbyname('move_unid_codigo').asstring,'custo');

              if xtipomov=Global.CodSaidaAlmox then begin
                PConsumo.vlrrealizado:=PConsumo.vlrrealizado+(custo*Q.fieldbyname('move_qtde').ascurrency);
                PConsumo.qtderealizada:=PConsumo.qtderealizada+Q.fieldbyname('move_qtde').ascurrency;
              end else begin                                           /// 08.08.09
//                PConsumo.vlrprevisto:=PConsumo.vlrprevisto+(custo*Q.fieldbyname('move_qtderetorno').ascurrency);
//                PConsumo.qtdeprevista:=PConsumo.qtdeprevista+Q.fieldbyname('move_qtderetorno').ascurrency;
// 19.11.09 - previsto vem do orçamento de obra
              end;
{
            if PConsumo.mesano02=mesano then begin
              PConsumo.valor02:=PConsumo.valor02+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde02:=PConsumo.qtde02+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano03=mesano then begin
              PConsumo.valor03:=PConsumo.valor03+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde03:=PConsumo.qtde03+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano04=mesano then begin
              PConsumo.valor04:=PConsumo.valor04+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde04:=PConsumo.qtde04+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano05=mesano then begin
              PConsumo.valor05:=PConsumo.valor05+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde05:=PConsumo.qtde05+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano06=mesano then begin
              PConsumo.valor06:=PConsumo.valor06+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde06:=PConsumo.qtde06+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano07=mesano then begin
              PConsumo.valor07:=PConsumo.valor07+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde07:=PConsumo.qtde07+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano08=mesano then begin
              PConsumo.valor08:=PConsumo.valor08+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde08:=PConsumo.qtde08+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano09=mesano then begin
              PConsumo.valor09:=PConsumo.valor09+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde09:=PConsumo.qtde09+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano10=mesano then begin
              PConsumo.valor10:=PConsumo.valor10+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde10:=PConsumo.qtde10+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano11=mesano then begin
              PConsumo.valor11:=PConsumo.valor11+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde11:=PConsumo.qtde11+Q.fieldbyname('move_qtde').ascurrency;
            end;
            if PConsumo.mesano12=mesano then begin
              PConsumo.valor12:=PConsumo.valor12+(Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency);
              PConsumo.qtde12:=PConsumo.qtde12+Q.fieldbyname('move_qtde').ascurrency;
            end;
}
        end;

    begin

      achou:=false;
      for p:=0 to Lista.Count-1 do begin
        PConsumo:=Lista[p];
        if tipo='C' then begin
          if PConsumo.produto=Q.FieldByName('move_esto_codigo').asstring then begin
            achou:=true;
            break
          end;
        end else begin
          if PConsumo.produto=Q.FieldByName('esqt_esto_codigo').asstring then begin
            achou:=true;
            break
          end;
        end;
      end;

      if not achou then begin
        New(PConsumo);
        if tipo='C' then
          PConsumo.produto:=Q.FieldByName('move_esto_codigo').asstring
        else
          PConsumo.produto:=Q.FieldByName('esqt_esto_codigo').asstring;
        PConsumo.descricao:=Q.FieldByName('esto_descricao').asstring;
        PConsumo.referencia:=Q.fieldbyname('esto_referencia').asstring;
        PConsumo.unidade:=Q.fieldbyname('esto_unidade').asstring;
        PConsumo.vlrprevisto:=0;
        PConsumo.vlrrealizado:=0;
        PConsumo.qtdeprevista:=0;
        PConsumo.qtderealizada:=0;
        PConsumo.custo:=0;
        if tipo='C' then
          AtualizaDadosMesano(Q.fieldbyname('move_tipomov').asstring)
        else begin
          custo:=FEstoque.GetCusto(pconsumo.produto,Q.fieldbyname('esqt_unid_codigo').asstring,'custo');
//          PConsumo.valor01:=Q.fieldbyname('esqt_qtde').ascurrency*custo;
//          PConsumo.qtde01:=Q.fieldbyname('esqt_qtde').ascurrency;
          Pconsumo.custo:=custo;
        end;
        Lista.add(Pconsumo);
      end else begin
        if tipo='C' then
          AtualizaDadosMesano(Q.fieldbyname('move_tipomov').asstring)
        else begin
//          PConsumo.valor01:=PConsumo.valor01+Q.fieldbyname('esqt_qtde').ascurrency*Pconsumo.custo;
//          PConsumo.qtde01:=PConsumo.qtde01+Q.fieldbyname('esqt_qtde').ascurrency;
        end;
      end;
    end;

    procedure Somalista;
    var p:integer;
    begin
       for p:=0 to Lista.count-1 do begin
         PConsumo:=Lista[p];
         totalqtdereal:=totalqtdereal+Pconsumo.qtderealizada;
         totalvalorreal:=totalvalorreal+Pconsumo.vlrrealizado;
         totalqtdeprev:=totalqtdeprev+Pconsumo.qtdeprevista;
         totalvalorprev:=totalvalorprev+Pconsumo.vlrprevisto;
       end;
    end;

/////////////////////////////////////
begin
/////////////////////////////////////
  SitAprovada:='F';
  tipo:='C';
  if tipo='C' then
    xtabela:='movestoque'
  else
    xtabela:='estoqueqtde';
  with FRelEstoque do begin
    if not FRelEstoque_Execute(16) then Exit;
    if FRelEstoque.Ednroobra.isempty then begin
      FRelEstoque.Ednroobra.invalid('Obrigatório informar numero da obra');
      exit;
    end;
    Sistema.BeginProcess('Pesquisando');
    if tipo='C' then begin
      sqlinicio:=' and move_datamvto>='+Datetosql(EdDatai.AsDate);
      Qi:=sqltoquery('select moes_datamvto from movesto where moes_numerodoc='+EdNroobra.assql+
                     ' and '+FGeral.Getin('moes_unid_codigo',EdUnid_codigo.text,'C')+
                     ' and moes_status=''R'' and moes_tipomov='+Stringtosql(Global.CodRequisicaoAlmox)+
                     ' order by moes_datamvto' );
      if not Qi.eof then begin
        sqlinicio:=' and move_datamvto>='+Datetosql(QI.fieldbyname('moes_datamvto').asdatetime);
        EdDatai.setdate(QI.fieldbyname('moes_datamvto').asdatetime);
      end;
      FGeral.FechaQuery(QI);
      if EdDAtaf.isempty then
         sqltermino:=''
      else
         sqltermino:=' and move_datamvto<='+Datetosql(EdDataf.Asdate);
      if EdCodcor.isempty then
        sqlcor:=''
      else
        sqlcor:='and move_core_codigo='+Edcodcor.assql;
      if EdCodtamanho.isempty then
        sqltamanho:=''
      else
        sqltamanho:='and move_tama_codigo='+Edcodtamanho.assql;
//      sqltipomovto:=' and '+FGEral.GetIN('move_tipomov',Global.CodEntradaprocesso,'C');
// 11.03.09
//      if not EdTipomov.isempty then
//        sqltipomovto:=' and '+FGEral.GetIN('move_tipomov',EdTipomov.text,'C')
//      else
//      sqltipomovto:=' and '+FGEral.GetIN('move_tipomov',Global.CodRequisicaoAlmox+';'+Global.CodSaidaAlmox,'C');
// 19.11.09
      sqltipomovto:=' and '+FGEral.GetIN('move_tipomov',Global.CodSaidaAlmox,'C');
//      sqlstatus:=FGeral.Getin('move_status','N,D,E','C');
//      if pos(Global.CodRequisicaoAlmox,sqltipomovto)>0 then
      sqlstatus:=FGeral.Getin('move_status','N,D,E,R','C');;
      if EdDAtai.isempty then
         sqlinicio:=''
      else
         sqlinicio:=sqlinicio;
      Q:=sqltoquery('select * from movestoque '+
                     ' left join cores on (core_codigo=move_core_codigo)'+
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' left join estoqueqtde on (esqt_esto_codigo=move_esto_codigo and esqt_unid_codigo=move_unid_codigo and esqt_status=''N'')'+
                     ' where '+sqlstatus+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+
                     sqldocumento+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     sqltipomovto+  // 15.02.06
                     sqlcor+  // 08.09.06
                     sqltamanho+  // 12.09.06
                     sqlobra+   // 03.01.07
                     ' order by move_datamvto,move_esto_codigo,move_numerodoc' );

    end else begin

      sqlinicio:='';
      sqltermino:='';
      if EdCodcor.isempty then
        sqlcor:=''
      else
        sqlcor:='and esgr_core_codigo='+Edcodcor.assql;
      if EdCodtamanho.isempty then
        sqltamanho:=''
      else
        sqltamanho:='and esgr_tama_codigo='+Edcodtamanho.assql;
      sqltipomovto:='';
      Q:=sqltoquery('select * from estoqueqtde '+
                     ' inner join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' where esqt_status=''N'''+
                     ' and '+FGeral.Getin('esqt_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+
                     sqldocumento+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     sqltipomovto+  // 15.02.06
                     sqlcor+  // 08.09.06
                     sqltamanho+  // 12.09.06
                     ' order by esto_descricao' );

    end;
    
    if Q.eof then begin
      Avisoerro('Nada encontrado para impressão');
      Sistema.EndProcess('');
      Q.close;
      Freeandnil(Q);
      exit;
    end;
    Lista:=TList.create;
    Sistema.beginprocess('Somando itens');
    while not Q.eof do begin
      AtualizaLista;
      Q.Next;
    end;
// 17.04.09 - buscar dados 'nao previstos' pelo PEA
    Q.Close;
    Q:=sqltoquery('select * from orcamendet'+
                  ' inner join orcamentos on (orca_numerodoc=orcd_numerodoc)'+
//                  ' inner join orcamencal on (orcc_numerodoc=orcd_numerodoc)'+
//                  ' inner join orcamencal on (orcc_numerodoc=orcd_numerodoc and orcc_situacao='+Stringtosql(SitAprovada)+')'+
                  ' where orca_nroobra='+Stringtosql( FGeral.FormatoObra(FRelEstoque.Ednroobra.Text))+
                  ' and orcd_tipoitem<>''S'''+
// 20.11.09 - retira a mao de obra
//                  ' and orcc_status=''N'''+
//                  ' and orcc_status=''N'''+
//                  ' and orcc_situacao='+Stringtosql(SitAprovada)+
                  ' and orcd_status=''N'''+
                  ' and orca_status=''N''');
    vlrmotorizacao:=0;vlrcremonas:=0;vlrcomponentes:=0;
    while not Q.eof do begin
        QOrcamencal:=sqltoquery('select orcc_situacao,orcc_nome,orcc_motorizacao,orcc_acessorios,orcc_cremonas from orcamencal where orcc_numerodoc='+Q.fieldbyname('orcd_numerodoc').AsString+
                                ' and orcc_nome='+Stringtosql(Q.fieldbyname('orcd_nome').asstring)+
                                ' and orcc_status=''N''' );
        if not QOrcamencal.eof then begin
          if (QOrcamencal.fieldbyname('orcc_situacao').asstring=SitAprovada) and
             (QOrcamencal.fieldbyname('orcc_nome').asstring=Q.fieldbyname('orcd_nome').asstring)
              then begin
            AtualizaListaOrca;
            vlrmotorizacao:=QOrcamencal.fieldbyname('orcc_motorizacao').ascurrency;
            vlrcomponentes:=QOrcamencal.fieldbyname('orcc_acessorios').ascurrency;
            vlrcremonas:=QOrcamencal.fieldbyname('orcc_cremonas').ascurrency;
          end;
        end;
      Q.Next;
      FGeral.FechaQuery(QOrcamencal);
    end;

    if vlrmotorizacao>0 then begin
        New(PConsumo);
        if tipo='C' then
          PConsumo.produto:=''
        else
          PConsumo.produto:='';
        PConsumo.descricao:='Motorização';
        PConsumo.referencia:='';
        PConsumo.unidade:='UN';
        PConsumo.vlrprevisto:=vlrmotorizacao;
        PConsumo.vlrrealizado:=0;
        PConsumo.qtdeprevista:=1;
        PConsumo.qtderealizada:=0;
        PConsumo.custo:=vlrmotorizacao;
        Lista.add(Pconsumo);
    end;
    if vlrcremonas>0 then begin
        New(PConsumo);
        if tipo='C' then
          PConsumo.produto:=''
        else
          PConsumo.produto:='';
        PConsumo.descricao:='Cremonas';
        PConsumo.referencia:='';
        PConsumo.unidade:='UN';
        PConsumo.vlrprevisto:=vlrcremonas;
        PConsumo.vlrrealizado:=0;
        PConsumo.qtdeprevista:=1;
        PConsumo.qtderealizada:=0;
        PConsumo.custo:=vlrcremonas;
        Lista.add(Pconsumo);
    end;
    if vlrcomponentes>0 then begin
        New(PConsumo);
        if tipo='C' then
          PConsumo.produto:=''
        else
          PConsumo.produto:='';
        PConsumo.descricao:='Componentes';
        PConsumo.referencia:='';
        PConsumo.unidade:='UN';
        PConsumo.vlrprevisto:=vlrcomponentes;
        PConsumo.vlrrealizado:=0;
        PConsumo.qtdeprevista:=1;
        PConsumo.qtderealizada:=0;
        PConsumo.custo:=vlrcomponentes;
        Lista.add(Pconsumo);
    end;
//
// 19.11.09 - buscar 'mais dados' do orçamentos - item INSUMOS = Perfis
    Q.Close;
    Q:=sqltoquery('select * from orcainsumos'+
                  ' inner join orcamentos on (orca_numerodoc=orin_numerodoc)'+
//                  ' inner join orcamencal on (orcc_numerodoc=orin_numerodoc)'+
                  ' where orca_nroobra='+Stringtosql( FGeral.FormatoObra(FRelEstoque.Ednroobra.Text))+
//                  ' and orcd_tipoitem=''T'''+
//                  ' and orcc_status=''N'''+
// 19.11.09
//                  ' and orcc_situacao='+Stringtosql(SitAprovada)+
                  ' and orin_status=''N'''+
                  ' and orca_status=''N''');
    NomeObraAprovada:='';
    PrecoVendaObraAprovada:=0;
    CustoObraAprovada:=0;
    divisorprev:=0;
    divisorreal:=0;
    if not Q.eof then begin
      while not Q.eof do begin
        QOrcamencal:=sqltoquery('select orcc_situacao,orcc_nome,orcc_venda,orcc_custoobra from orcamencal where orcc_numerodoc='+Q.fieldbyname('orin_numerodoc').AsString+
                                ' and orcc_nome='+Stringtosql(Q.fieldbyname('orin_nome').asstring)+
                                ' and orcc_status=''N''' );
        if not QOrcamencal.eof then begin
          if (QOrcamencal.fieldbyname('orcc_situacao').asstring=SitAprovada) and
             (QOrcamencal.fieldbyname('orcc_nome').asstring=Q.fieldbyname('orin_nome').asstring)
              then begin
            AtualizaListaOrcaInsumos;
            NomeObraAprovada:=QOrcamencal.fieldbyname('orcc_nome').asstring;
            PrecoVendaObraAprovada:=QOrcamencal.fieldbyname('orcc_venda').ascurrency;
            CustoObraAprovada:=QOrcamencal.fieldbyname('orcc_custoobra').ascurrency;
          end;
        end;
        Q.Next;
        FGeral.FechaQuery(QOrcamencal);
      end;
    end;

    totalqtdeprev:=0;
    totalvalorprev:=0;
    totalqtdereal:=0;
    totalvalorreal:=0;
    SomaLista;

    if PrecoVendaObraAprovada >0 then begin
      divisorprev:=( CustoObraAprovada/PrecoVendaObraAprovada ) * 100;
      divisorreal:=( totalvalorreal/PrecoVendaObraAprovada ) * 100;
    end;
    unidade:=copy(EdUnid_codigo.text,1,3);
    Sistema.BeginProcess('Gerando Relatório');

    if tipo='C' then begin
      FRel.Init('RelConsumoPrevRealizado');
//      FRel.AddTit('Consumo Realizado X Previsto de Consumo de Material - Estimado Pea X Saida do Almoxarifado - Obra '+EdNroobra.text);
// 19.11.09
      FRel.AddTit('Consumo Previsto/Previsto de Consumo de Material - Orçamento Obra X Saida do Almoxarifado - Obra '+FGeral.FormatoObra(EdNroobra.text)+' - Aprovada '+NomeObraAprovada);
      FRel.AddTit('Unidade : '+Unidade+' - '+FUnidades.Getnome(Unidade)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text)+
                 ' - Valor de Venda da Obra :'+FGeral.Formatavalor(PrecoVendaObraAprovada,f_cr)+
                 ' - Markup Realizado :'+FGeral.Formatavalor(divisorreal,f_cr)+
                 ' - Markup Previsto :'+FGeral.Formatavalor(divisorprev,f_cr) );
      FRel.AddTit('Periodo : '+formatdatetime('dd/mm/yy',EdDatai.AsDate)+' a '+formatdatetime('dd/mm/yy',EdDataf.AsDate)+Montatit(EdGrup_codigo.AsInteger,EdSugr_codigo.AsInteger,EdFami_codigo.AsInteger));
    end else begin
      FRel.Init('RelAbcSaldoEstoque');
      FRel.AddTit('Curva ABC pelo Saldo em Estoque');
      FRel.AddTit('Unidade : '+Unidade+' - '+FUnidades.Getnome(Unidade)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
    end;

    if Global.Topicos[1204] then
      FRel.AddCol( 90,1,'C','' ,''              ,'Referência'          ,''         ,'',false)
    else
      FRel.AddCol( 90,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
    FRel.AddCol(220,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
    FRel.AddCol(045,1,'C','' ,''              ,'Unidade'       ,''         ,'',false);
    PConsumo:=Lista[0];

    FRel.AddCol( 70,3,'N','+' ,''                ,'Qtde Prev.'       ,''         ,'',false);
    FRel.AddCol( 70,3,'N','+' ,''                ,'Qtde Real.'       ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,''                ,'Qtde Dif.'          ,''         ,'',false);
    FRel.AddCol( 50,3,'N',''  ,f_cr              ,'% Dif. Q.'       ,''         ,'',false);
    FRel.AddCol( 70,3,'N','+' ,f_cr              ,'Valor Prev.'       ,''         ,'',false);
    FRel.AddCol( 70,3,'N','+' ,f_cr              ,'Valor Real.'       ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,f_cr              ,'Valor Dif.'          ,''         ,'',false);
    FRel.AddCol( 50,3,'N',''  ,f_cr              ,'% Dif. V.'       ,''         ,'',false);

    for i:=0 to LIsta.count-1 do begin
      Pconsumo:=Lista[i];
// 11.03.09 - caso acerto for por referencia a digitação...
      if Global.Topicos[1204] then
         FRel.AddCel( PConsumo.referencia )
      else
        FRel.AddCel(PConsumo.produto);
      FRel.AddCel(PConsumo.descricao);
      FRel.AddCel(PConsumo.unidade);
      FRel.AddCel(floattostr(PConsumo.qtdeprevista));
      FRel.AddCel(floattostr(PConsumo.qtderealizada));
      dif:=abs( PConsumo.qtdeprevista-PConsumo.qtderealizada );
      if PConsumo.qtderealizada>0 then
        abcqtde:=(dif/PConsumo.qtderealizada)*100
      else if ( (PConsumo.qtderealizada>0) and (PConsumo.qtdeprevista=0) ) or ( (PConsumo.qtderealizada=0) and (PConsumo.qtdeprevista>0) ) then
        abcqtde:=100
      else
        abcqtde:=0;
      FRel.AddCel(floattostr(dif));
      FRel.AddCel(floattostr(abcqtde));
      FRel.AddCel(floattostr(PConsumo.vlrprevisto));
      FRel.AddCel(floattostr(PConsumo.vlrrealizado));
//      dif:=abs( PConsumo.vlrprevisto-PConsumo.vlrrealizado );
// 22.09.10
      dif:=PConsumo.vlrprevisto-PConsumo.vlrrealizado;
      if PConsumo.vlrrealizado>0 then
        abcvalor:=(dif/PConsumo.vlrrealizado)*100
      else if ( (PConsumo.vlrrealizado>0) and (PConsumo.vlrprevisto=0) ) or ( (PConsumo.vlrrealizado=0) and (PConsumo.vlrprevisto>0) ) then
        abcvalor:=100
      else
        abcvalor:=0;
      FRel.AddCel(floattostr(dif));
      FRel.AddCel(floattostr(abcvalor));
    end;
    FRel.Video();
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

  end;

  FRelEstoque_PrevistoRealizado;         // 16 - 12.03.09
end;

//////////////////////////////////////////////////

procedure FRelEstoque_PontoRessuprimento;          // 17
var Q:TSqlquery;
    QEntrada,QSaida:TMemoryQuery;
    saldofinal,preventrada,prevsaida:extended;

// busca as previsoes de entrada nos pedidos de compra em aberto, saida nas requisicoes do almox
    procedure BuscaPrevisaoEntrada;
    begin
      QEntrada:=SqltoMemoryquery('select moco_unid_codigo,moco_esto_codigo,moco_tama_codigo,moco_core_codigo,sum(moco_qtde)as qtde,sum(moco_qtderecebida) as rece from movcompras '+
          ' inner join movcomp on ( mocm_numerodoc=moco_numerodoc and mocm_status=moco_status )'+
          ' where mocm_datamvto>='+Datetosql(Sistema.hoje)+
          ' and moco_status=''N'' and '+FGeral.Getin('moco_tipomov','PU;PB;PX','C')+
          ' and mocm_tipomov=moco_tipomov'+
          ' and '+FGeral.GetIN('moco_unid_codigo',FRelEstoque.EdUNid_codigo.text,'C')+
//          ' and ( (moco_qtderecebida is null) or (moco_qtderecebida=0) )'+
          '  and ( (moco_qtderecebida is null) or (moco_qtderecebida<moco_qtde) )'+
          ' group by moco_unid_codigo,moco_esto_codigo,moco_tama_codigo,moco_core_codigo');
    end;

// busca previsao de saida nas requisicoes do almox
    procedure BuscaPrevisaoSaida;
    var Data:TDatetime;
    begin
        sqltipomovto:=' and '+FGeral.GetIn('move_tipomov',Global.CodRequisicaoAlmox ,'C');
        Data:=Sistema.hoje-360;
        QSaida:=sqltoMemoryquery('select move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo,sum(move_qtde) as qtde,sum(move_qtderetorno) as qtderetorno from movestoque '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' left join estoqueqtde on (esqt_esto_codigo=move_esto_codigo and esqt_unid_codigo=move_unid_codigo and esqt_status=''N'')'+
                     ' where move_status=''R'''+
                     ' and '+FGeral.Getin('move_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')+
                     ' and move_datamvto>='+Datetosql(Data)+
                     sqltipomovto+
                     ' group by move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo');
    end;

    function GetPrevEntrada(unidade,codigo:String;codtamanho:integer=0;codcor:integer=0):extended;
    var n:extended;
    begin
      QEntrada.First;
      n:=0;
      while not QEntrada.Eof do begin
        if (unidade=QEntrada.fieldbyname('moco_unid_codigo').asstring) and
           (codigo=QEntrada.fieldbyname('moco_esto_codigo').asstring) then begin
          if (codtamanho>0) or (codcor>0) then begin
            if (QEntrada.fieldbyname('moco_tama_codigo').AsInteger=codtamanho) and
               (QEntrada.fieldbyname('moco_core_codigo').AsInteger=codcor) then begin
              n:=n+(QEntrada.fieldbyname('qtde').asfloat-QEntrada.fieldbyname('rece').asfloat);
              break;
            end;
          end else begin
             n:=n+(QEntrada.fieldbyname('qtde').asfloat-QEntrada.fieldbyname('rece').asfloat);
             break;
          end
        end;
        QEntrada.Next;
      end;
      result:=n;
    end;

    function GetPrevSaida(unidade,codigo:String;codtamanho:integer=0;codcor:integer=0):extended;
    var n:extended;
    begin
      QSaida.First;
      n:=0;
      while not QSaida.Eof do begin
        if (unidade=QSaida.fieldbyname('move_unid_codigo').asstring) and
           (codigo=QSaida.fieldbyname('move_esto_codigo').asstring) then begin
          if (codtamanho>0) or (codcor>0) then begin
            if (QSaida.fieldbyname('move_tama_codigo').AsInteger=codtamanho) and
               (QSaida.fieldbyname('move_core_codigo').AsInteger=codcor) then begin
              if (QSaida.fieldbyname('qtde').asfloat<QSaida.fieldbyname('qtderetorno').asfloat) then
                n:=n+QSaida.fieldbyname('qtderetorno').asfloat-QSaida.fieldbyname('qtde').asfloat
              else
                n:=n+QSaida.fieldbyname('qtde').asfloat;
              break;
            end;
          end else begin
             if (QSaida.fieldbyname('qtde').asfloat<QSaida.fieldbyname('qtderetorno').asfloat) then
                n:=n+QSaida.fieldbyname('qtderetorno').asfloat-QSaida.fieldbyname('qtde').asfloat
             else
                n:=n+QSaida.fieldbyname('qtde').asfloat;
             break;
          end
        end;
        QSaida.Next;
      end;
      result:=n;
    end;


begin
//////////////////////////////////////////
  with FRelEstoque do begin
    if not FRelEstoque_Execute(17) then Exit;

    Sistema.BeginProcess('Pesquisando itens em estoque');
    if trim(FRelEstoque.EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('esqt_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    Q:=sqltoquery('select * from estoqueqtde'+
                     ' inner join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' left  join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' left  join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
//                     ' left  join estgrades on (esgr_esto_codigo=esqt_esto_codigo and esgr_status=''N'' and esgr_unid_codigo=esqt_unid_codigo)'+
                     ' left  join estgrades on (esgr_esto_codigo=esqt_esto_codigo and esgr_status=esqt_status and esgr_unid_codigo=esqt_unid_codigo)'+
                     ' left  join familias on (fami_codigo=esto_fami_codigo) '+
                     ' left  join tamanhos on (tama_codigo=esgr_tama_codigo) '+
                     ' left  join cores    on (core_codigo=esgr_core_codigo) '+
//                     ' left  join copas    on (copa_codigo=esgr_copa_codigo) '+
                     ' where esqt_status=''N'''+
                     ' and esto_emlinha=''S'''+
                     sqlunidade+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     ' order by esqt_unid_codigo,esqt_esto_codigo' );
    if Q.Eof then  begin
      Avisoerro('Nada encontrado para impressão');
      FGeral.FechaQuery(Q);
      exit;
    end;
    Sistema.BeginProcess('Pesquisando pedidos de compra');
    BuscaPrevisaoEntrada;
    Sistema.BeginProcess('Pesquisando requisições do estoque');
    BuscaPrevisaoSaida;
    Sistema.BeginProcess('Gerando relatório');
    FRel.Init('PontoRessuprimento');
    FRel.AddTit('Ponto de Ressuprimento');
    FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));
    FRel.AddCol( 45,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    FRel.AddCol( 60,1,'C','' ,''              ,'Grupo'           ,''         ,'',false);
    FRel.AddCol(100,1,'C','' ,''              ,'Desc. Grupo'     ,''         ,'',false);
    FRel.AddCol(100,1,'C','' ,''              ,'Localização'     ,''         ,'',false);
    if Global.Topicos[1209] then
      FRel.AddCol( 90,1,'C','' ,''              ,'Referencia'          ,''         ,'',false)
    else
      FRel.AddCol( 90,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
    FRel.AddCol(200,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
    FRel.AddCol( 50,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    FRel.AddCol( 60,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
    FRel.AddCol( 90,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,''              ,'Ponto Ressup.'   ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,''              ,'Saldo-P.Ressup.' ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,''              ,'Saldo'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,''              ,'Prev.Entrada'    ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,''              ,'Prev.Saida'      ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,''              ,'Saldo Final'     ,''         ,'',False);

    while not Q.eof do begin
        FRel.AddCel(Q.FieldByName('esqt_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_grup_codigo').AsString);
        FRel.AddCel(Q.FieldByName('grup_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esqt_localiza').AsString);
        if Global.Topicos[1209] then
          FRel.AddCel(Q.FieldByName('esto_referencia').AsString)
        else
          FRel.AddCel(Q.FieldByName('esqt_esto_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esto_unidade').AsString);

        if Q.fieldbyname('esgr_esto_codigo').asstring<>'' then begin
            FRel.AddCel(Q.FieldByName('tama_descricao').AsString);
            FRel.AddCel(Q.FieldByName('core_descricao').AsString);
        end else begin
            FRel.AddCel('');
            FRel.AddCel('');
        end;
        if Q.fieldbyname('esgr_esto_codigo').asstring<>'' then begin
            preventrada:=GetPrevEntrada(Q.FieldByName('esqt_unid_codigo').AsString,Q.FieldByName('esqt_esto_codigo').AsString,
                         Q.FieldByName('esgr_tama_codigo').AsInteger,Q.FieldByName('esgr_core_codigo').AsInteger);
            prevsaida:=GetPrevSaida(Q.FieldByName('esqt_unid_codigo').AsString,Q.FieldByName('esqt_esto_codigo').AsString,
                         Q.FieldByName('esgr_tama_codigo').AsInteger,Q.FieldByName('esgr_core_codigo').AsInteger);
            FRel.AddCel(Q.FieldByName('esgr_ressuprimento').AsString);
            FRel.AddCel(Floattostr(Q.FieldByName('esgr_qtde').AsFloat-Q.FieldByName('esqt_ressuprimento').AsFloat));
            FRel.AddCel(Q.FieldByName('esgr_qtde').AsString);
            FRel.AddCel(floattostr(preventrada));
            FRel.AddCel(floattostr(prevsaida));
            saldofinal:=Q.FieldByName('esgr_qtde').AsFloat+preventrada-prevsaida;
//            FRel.AddCel(floattostr(saldofinal));
            FRel.AddCel(Formatfloat(f_cr3,saldofinal));
{
            if (Global.Topicos[1204]) then begin
              if (Q.FieldByName('tama_comprimento').AsFloat>0) then
                FRel.AddCel( floattostr(Q.FieldByName('esgr_qtde').AsInteger/(Q.FieldByName('tama_comprimento').AsFloat/1000)) )
              else
                FRel.AddCel('');
              if (Q.FieldByName('tama_comprimento').AsFloat>0) then
                FRel.AddCel( floattostr(Q.FieldByName('esgr_qtde').AsInteger/(Q.FieldByName('tama_comprimento').AsFloat/1000) * Q.FieldByName('esto_peso').AsFloat) )
              else
                FRel.AddCel('');
            end;
}
        end else begin

            preventrada:=GetPrevEntrada(Q.FieldByName('esqt_unid_codigo').AsString,Q.FieldByName('esqt_esto_codigo').AsString);
            prevsaida:=GetPrevSaida(Q.FieldByName('esqt_unid_codigo').AsString,Q.FieldByName('esqt_esto_codigo').AsString);
            FRel.AddCel(Q.FieldByName('esqt_ressuprimento').AsString);
            FRel.AddCel(floattostr(Q.FieldByName('esqt_qtde').AsFloat-Q.FieldByName('esqt_ressuprimento').AsFloat));
            FRel.AddCel(Q.FieldByName('esqt_qtde').AsString);
            FRel.AddCel(floattostr(preventrada));
            FRel.AddCel(floattostr(prevsaida));
            saldofinal:=Q.FieldByName('esqt_qtde').AsFloat+preventrada-prevsaida;
            FRel.AddCel(floattostr(saldofinal));
//            if Global.Topicos[1204] then begin
//              FRel.AddCel('');
//              FRel.AddCel('');
//            end;
        end;

      Q.Next;
    end;
    FRel.Video();
    Sistema.EndProcess('');
    fGeral.FechaQuery(Q);
    fGeral.FechaQuery(QEntrada);
    fGeral.FechaQuery(QSaida);

  end;  // ref with..

  FRelEstoque_PontoRessuprimento;         // 17 - 01.06.09

end;

procedure FRelEstoque_ReservaemObra;          // 18
//////////////////////////////////////////////////////////////
var Q:TSqlquery;
    QSaida:TMemoryQuery;
    saldofinal,preventrada,prevsaida,jabaixado,emestoque:extended;
    saldofinalp,prevsaidap,jabaixadop,emestoquep:extended;
    sqldata,produto:string;
    Data:TDatetime;
    Numerodoc,tamanho,cor,cliente:integer;

// busca previsao de saida nas requisicoes do almox
    procedure BuscaPrevisaoSaida;
    begin
        sqltipomovto:=' and '+FGeral.GetIn('move_tipomov',Global.CodRequisicaoAlmox ,'C');
        QSaida:=sqltoMemoryquery('select move_unid_codigo,move_esto_codigo,move_numerodoc,move_tama_codigo,move_core_codigo,sum(move_qtde) as qtde,sum(move_qtderetorno) as qtderetorno from movestoque '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' left join estoqueqtde on (esqt_esto_codigo=move_esto_codigo and esqt_unid_codigo=move_unid_codigo and esqt_status=''N'')'+
                     ' where move_status=''R'''+
                     ' and '+FGeral.Getin('move_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')+
                     ' and move_datamvto>='+Datetosql(Data)+
                     sqltipomovto+
                     ' group by move_unid_codigo,move_esto_codigo,move_numerodoc,move_tama_codigo,move_core_codigo');
    end;

    function GetPrevSaida(unidade,codigo:String;documento:integer;codtamanho:integer=0;codcor:integer=0):extended;
    var n,y:extended;
    begin
      QSaida.First;
      n:=0;
      while not QSaida.Eof do begin
        if  not (QSaida.eof) and (unidade=QSaida.fieldbyname('move_unid_codigo').asstring) and
           (codigo=QSaida.fieldbyname('move_esto_codigo').asstring) then begin
          while not (QSaida.eof) and (unidade=QSaida.fieldbyname('move_unid_codigo').asstring) and
             (codigo=QSaida.fieldbyname('move_esto_codigo').asstring) do begin
            if (codtamanho>0) or (codcor>0) then begin
              if (QSaida.fieldbyname('move_tama_codigo').AsInteger=codtamanho) and
                 (QSaida.fieldbyname('move_core_codigo').AsInteger=codcor) then begin
                if (QSaida.fieldbyname('qtde').asfloat<QSaida.fieldbyname('qtderetorno').asfloat) then begin
                  n:=n+QSaida.fieldbyname('qtderetorno').asfloat-QSaida.fieldbyname('qtde').asfloat;
                  y:=QSaida.fieldbyname('qtderetorno').asfloat-QSaida.fieldbyname('qtde').asfloat
                end else begin
                  n:=n+QSaida.fieldbyname('qtde').asfloat;
                  y:=QSaida.fieldbyname('qtde').asfloat;
                end;
//                qtdeobras:=qtdeobras+'Req.'+QSaida.fieldbyname('move_numerodoc').asstring+':'+floattostr(y)+' ';
  //              break;
              end;
            end else begin
               if (QSaida.fieldbyname('qtde').asfloat<QSaida.fieldbyname('qtderetorno').asfloat) then begin
                  n:=n+QSaida.fieldbyname('qtderetorno').asfloat-QSaida.fieldbyname('qtde').asfloat;
                  y:=QSaida.fieldbyname('qtderetorno').asfloat-QSaida.fieldbyname('qtde').asfloat
               end else begin
                  n:=n+QSaida.fieldbyname('qtde').asfloat;
                  y:=QSaida.fieldbyname('qtde').asfloat;
               end;
//               qtdeobras:=qtdeobras+'Req.'+QSaida.fieldbyname('move_numerodoc').asstring+':'+floattostr(y)+' ';
  //             break;
            end;
            QSaida.Next;
          end;
          Break;
        end else
          QSaida.Next;
      end;
      result:=n;
    end;

    function GetJabaixado(numerodoc:integer;data:tdatetime;produto:string;codtam:integer;codcor:integer):currency;
    var Qx:TSqlquery;
        sqlcor,sqltam:string;
    begin
      if codcor>0 then
        sqlcor:=' and move_core_codigo='+inttostr(codcor)
      else
        sqlcor:=' and ( (move_core_codigo=0) or (move_core_codigo is null) )';
      if codtam>0 then
        sqltam:=' and move_tama_codigo='+inttostr(codtam)
      else
        sqltam:=' and ( (move_tama_codigo=0) or (move_tama_codigo is null) )';
      Qx:=sqltoquery('select move_qtde from movestoque where move_status=''N'''+
                     ' and move_esto_codigo='+stringtosql(produto)+
                     ' and move_numerodoc='+inttostr(numerodoc)+
                     ' and move_datamvto>='+datetosql(data)+
                     ' and '+FGeral.GetIN('move_tipomov',Global.CodSaidaAlmox+';'+Global.CodRequisicaoAlmox,'C')+
                     sqlcor+sqltam );
      result:=0;
      while not Qx.eof do begin
        result:=result+Qx.fieldbyname('move_qtde').ascurrency;
        Qx.Next;
      end;
      FGeral.FechaQuery(Qx);
    end;


begin
//////////////////////////////////////////
  with FRelEstoque do begin
    if not FRelEstoque_Execute(18) then Exit;

    Sistema.BeginProcess('Pesquisando itens reservados em obras');
    if trim(FRelEstoque.EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('esqt_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    Data:=Sistema.hoje-365;
//    sqldata:=' and move_datamvto>='+Datetosql(EdDatai.AsDate)+' and move_datamvto<='+Datetosql(EdDataf.AsDate);
// conversa com Paulo, Adriano e Joce em 29.09
    sqldata:=' and move_datamvto>='+Datetosql(DAta);
    Q:=sqltoquery('select * from movestoque'+
//    inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                 ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                 ' inner join estoqueqtde on ( esqt_esto_codigo=move_esto_codigo and esqt_unid_codigo=move_unid_codigo )'+
                 ' left join cores on ( core_codigo=move_core_codigo )'+
                 ' left join tamanhos on ( tama_codigo=move_tama_codigo )'+
                 ' left  join grupos on (grup_codigo=esto_grup_codigo) '+
                 ' left  join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
//                 ' left  join estgrades on (esgr_esto_codigo=esqt_esto_codigo and esgr_status=esqt_status and esgr_unid_codigo=esqt_unid_codigo)'+
                 ' left  join familias on (fami_codigo=esto_fami_codigo) '+
                 ' where move_status=''R'''+
//                 ' and moes_status=''R'''+
                 sqldata+
                 ' and '+FGeral.Getin('move_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')+
                 ' and '+FGeral.GetIn('move_tipomov',Global.CodRequisicaoAlmox ,'C')+
                 sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                 ' order by move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo,move_datamvto');

    if Q.Eof then  begin
      Sistema.EndProcess('Nada encontrado para impressão');
      FGeral.FechaQuery(Q);
      exit;
    end;
//    Sistema.BeginProcess('Pesquisando pedidos de compra');
//    BuscaPrevisaoEntrada;
//    Sistema.BeginProcess('Pesquisando requisições do estoque');

//    BuscaPrevisaoSaida;

    Sistema.BeginProcess('Gerando relatório');
    FRel.Init('ReservaemObras');
    FRel.AddTit('Itens Reservados em Obras');
    FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));
//    FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
    FRel.AddTit('Periodo : Desde '+FGeral.formatadata(data));
    if not FRelEstoque.EdEsto_codigo.IsEmpty then
      FRel.AddTit('Escolhido codigo '+EdESto_codigo.text+' - '+FEstoque.GetDescricao(EdESto_codigo.text));
    FRel.AddCol( 45,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
//    FRel.AddCol( 60,1,'C','' ,''              ,'Grupo'           ,''         ,'',false);
//    FRel.AddCol(100,1,'C','' ,''              ,'Desc. Grupo'     ,''         ,'',false);
//    FRel.AddCol(100,1,'C','' ,''              ,'Localização'     ,''         ,'',false);
    if Global.Topicos[1209] then
      FRel.AddCol( 90,1,'C','' ,''              ,'Referencia'          ,''         ,'',false)
    else
      FRel.AddCol( 90,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
    FRel.AddCol(200,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
    FRel.AddCol( 50,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    FRel.AddCol( 60,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
    FRel.AddCol( 90,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
    FRel.AddCol( 60,1,'C','' ,''              ,'Cliente'           ,''         ,'',false);
    FRel.AddCol(100,1,'C','' ,''              ,'Descrição'     ,''         ,'',false);
    FRel.AddCol( 90,3,'N','' ,''              ,'Numero'          ,''         ,'',False);
    FRel.AddCol( 70,1,'D','' ,''              ,'Data'          ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,''              ,'Saldo'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,''              ,'Requisitado'       ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,''              ,'Baixado'       ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,''              ,'Saldo Req.'      ,''         ,'',False);

    while not Q.eof do begin

      cliente:=Q.fieldbyname('move_tipo_codigo').asinteger;
      Numerodoc:=Q.fieldbyname('move_numerodoc').asinteger;
      produto:=Q.fieldbyname('move_esto_codigo').asstring;
      tamanho:=Q.fieldbyname('move_tama_codigo').asinteger;
      cor:=Q.fieldbyname('move_core_codigo').asinteger;
      saldofinalp:=0;prevsaidap:=0;jabaixadop:=0;emestoquep:=0;

      while (not Q.eof)
       and (produto=Q.fieldbyname('move_esto_codigo').asstring)
       and (tamanho=Q.fieldbyname('move_tama_codigo').asinteger)
       and (cor=Q.fieldbyname('move_core_codigo').asinteger)
       do begin
        jabaixado:=GetJabaixado(Q.fieldbyname('move_numerodoc').asinteger,Q.fieldbyname('move_datamvto').asdatetime,Q.fieldbyname('move_esto_codigo').asstring,
                               Q.fieldbyname('move_tama_codigo').asinteger,
                               Q.fieldbyname('move_core_codigo').asinteger);
        prevsaida:=Q.FieldByName('move_qtde').AsCurrency;
        if jabaixado<prevsaida then begin
          FRel.AddCel(Q.FieldByName('esqt_unid_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('esto_grup_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('grup_descricao').AsString);
  //        FRel.AddCel(Q.FieldByName('esqt_localiza').AsString);
          if Global.Topicos[1209] then
            FRel.AddCel(Q.FieldByName('esto_referencia').AsString)
          else
            FRel.AddCel(Q.FieldByName('esqt_esto_codigo').AsString);
          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
          FRel.AddCel(Q.FieldByName('esto_unidade').AsString);

  //        if Q.fieldbyname('esgr_esto_codigo').asstring<>'' then begin
              FRel.AddCel(FTamanhos.GetDescricao(Q.FieldByName('move_tama_codigo').AsInteger));
              FRel.AddCel(FCores.GetDescricao(Q.FieldByName('move_core_codigo').AsInteger));
  //        end else begin
  //            FRel.AddCel('');
  //            FRel.AddCel('');
  //        end;
          FRel.AddCel(Q.FieldByName('move_tipo_codigo').AsString);
          FRel.AddCel(FCadcli.GetRazaoSocial(Q.FieldByName('move_tipo_codigo').AsInteger));
          FRel.AddCel(Q.FieldByName('move_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('move_datamvto').AsString);


  //        if Q.fieldbyname('move_tama_codigo').asstring<>'' then begin
  //            preventrada:=GetPrevEntrada(Q.FieldByName('esqt_unid_codigo').AsString,Q.FieldByName('esqt_esto_codigo').AsString,
  //                         Q.FieldByName('esgr_tama_codigo').AsInteger,Q.FieldByName('esgr_core_codigo').AsInteger);
  //            prevsaida:=GetPrevSaida(Q.FieldByName('esqt_unid_codigo').AsString,Q.FieldByName('esqt_esto_codigo').AsString,
  //                         Q.FieldByName('esgr_tama_codigo').AsInteger,Q.FieldByName('esgr_core_codigo').AsInteger);
  //            FRel.AddCel(Q.FieldByName('esgr_ressuprimento').AsString);
  //            FRel.AddCel(Floattostr(Q.FieldByName('esgr_qtde').AsFloat-Q.FieldByName('esqt_ressuprimento').AsFloat));
              emestoque:=FEstoque.GetQtdeEmEstoque(Q.fieldbyname('move_unid_codigo').asstring,
                         Q.fieldbyname('move_esto_codigo').asstring,
                         Q.fieldbyname('move_core_codigo').asinteger,
                         Q.fieldbyname('move_tama_codigo').asinteger );
              FRel.AddCel(floattostr(emestoque));
              FRel.AddCel(floattostr(prevsaida));
              FRel.AddCel(floattostr(jabaixado));
              saldofinal:=emestoque-(prevsaida-jabaixado);
  //            FRel.AddCel(floattostr(saldofinal));
              FRel.AddCel(Floattostr(saldofinal));
              jabaixadop:=jabaixadop+jabaixado;
              prevsaidap:=prevsaidap+prevsaida;
              saldofinalp:=emestoque-(prevsaidap-jabaixadop);

        end;
        Q.Next;
      end;
      if prevsaidap>0 then
          FGeral.PulalinhaRel(14,11,'Saldo Final',12,floattostr(prevsaidap),13,floattostr(jabaixadop),14,floattostr(saldofinalp));

    end;
    FRel.Video();
    Sistema.EndProcess('');
    fGeral.FechaQuery(Q);
//    fGeral.FechaQuery(QSaida);

  end;  // ref with..

  FRelEstoque_ReservaemObra;         // 18 - 22.09.09

end;

// 02.12.13 - Metalforte
procedure FRelEstoque_PosicaoEstoqueemPeso;          // 19
///////////////////////////////////////////////////////////////
var Q:TSqlquery;
    customedioproduto,custoultimoproduto,pesototalproduto:currency;
    sqlcor,sqltamanho:string;
begin

  with FRelEstoque do begin

    if not FRelEstoque_Execute(19) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    if EdSomagrade.isempty then
      somargrade:='N'
    else
      somargrade:=EdSomagrade.text;
    if trim(FRelEstoque.EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.Getin('esqt_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')
    else
      sqlunidade:='';

    if not FRelEstoque.EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.Getin('esqt_esto_codigo',FRelEstoque.EdEsto_codigo.text,'C')
    else
      sqlproduto:='';

    if trim(FRelEstoque.EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.Getin('esqt_unid_codigo',FRelEstoque.EdUnid_codigo.text,'C')
    else
      sqlunidade:='';

    if not FRelEstoque.EdEsto_codigo.isempty then
      sqlproduto:=' and '+FGeral.Getin('esqt_esto_codigo',FRelEstoque.EdEsto_codigo.text,'C')
    else
      sqlproduto:='';
    if somargrade='N' then
      Q:=sqltoquery('select * from estoqueqtde'+
                     ' inner join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' left  join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' left  join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
//                     ' left  join estgrades on (esgr_esto_codigo=esqt_esto_codigo and esgr_status=''N'' and esgr_unid_codigo=esqt_unid_codigo)'+
                     ' left  join estgrades on (esgr_esto_codigo=esqt_esto_codigo and esgr_status=esqt_status and esgr_unid_codigo=esqt_unid_codigo)'+
                     ' left  join familias on (fami_codigo=esto_fami_codigo) '+
                     ' left  join tamanhos on (tama_codigo=esgr_tama_codigo) '+
                     ' left  join cores    on (core_codigo=esgr_core_codigo) '+
                     ' left  join copas    on (copa_codigo=esgr_copa_codigo) '+
                     ' where esqt_status=''N'''+
                     ' and esto_emlinha=''S'''+
                     sqlunidade+sqlcor+sqltamanho+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     ' order by esqt_unid_codigo,esqt_esto_codigo' )
    else
      Q:=sqltoquery('select * from estoqueqtde'+
                     ' inner join estoque on (esto_codigo=esqt_esto_codigo) '+
                     ' inner join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' inner join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
                     ' inner join familias on (fami_codigo=esto_fami_codigo) '+
                     ' where esqt_status=''N'''+
                     sqlunidade+
                     ' and esto_emlinha=''S'''+
                     sqlgrupo+sqlsubgrupo+sqlfamilia+sqlproduto+
                     ' order by esqt_unid_codigo,esqt_esto_codigo' );
    if Q.Eof then

      Avisoerro('Nada encontrado para impressão')

    else begin

      FRel.Init('PosicaoEstoquePeso');
      FRel.AddTit('Posição de Estoque em Peso');
      FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));
      FRel.AddCol( 60,1,'C','' ,''              ,'Grupo'           ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Grupo'     ,''         ,'',false);
      FRel.AddCol( 90,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol( 90,1,'C','' ,''              ,'Referencia'          ,''         ,'',false);
      FRel.AddCol(200,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
      FRel.AddCol( 50,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
      FRel.AddCol( 70,3,'N','+' ,f_qtdestoque             ,'Barras/Qtde'           ,''         ,'',false);
//      FRel.AddCol( 70,3,'N','+' ,f_qtdestoque              ,'Qtde '           ,''         ,'',false);
      FRel.AddCol( 70,3,'N','' ,f_qtdestoque              ,'Peso Uni.'           ,''         ,'',false);
      FRel.AddCol( 70,3,'N','+' ,f_qtdestoque             ,'Peso Total'           ,''         ,'',false);
      if Global.Usuario.OutrosAcessos[0049] then begin
        FRel.AddCol( 70,3,'N','' ,f_cr              ,'Último Custo'           ,''         ,'',false);
        FRel.AddCol( 70,3,'N','' ,f_cr              ,'Custo Médio'           ,''         ,'',false);
        FRel.AddCol( 80,3,'N','+' ,f_cr              ,'Total Custo'           ,''         ,'',false);
        FRel.AddCol( 80,3,'N','+' ,f_cr              ,'Total Médio'           ,''         ,'',false);
      end;

      while not Q.eof do begin

        FRel.AddCel(Q.FieldByName('esto_grup_codigo').AsString);
        FRel.AddCel(Q.FieldByName('grup_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esqt_esto_codigo').AsString);
        FRel.AddCel(Q.FieldByName('esto_referencia').AsString);
        FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
        FRel.AddCel(Q.FieldByName('esto_unidade').AsString);
//          vendaproduto:=(FEstoque.GetPreco(Q.fieldbyname('esqt_esto_codigo').asstring,copy(EdUnid_codigo.text,1,3)));
//        customedioproduto:=FEstoque.GetCusto(Q.fieldbyname('esqt_esto_codigo').asstring,copy(EdUnid_codigo.text,1,3),'medio');
//        custoultimoproduto:=FEstoque.GetCusto(Q.fieldbyname('esqt_esto_codigo').asstring,copy(EdUnid_codigo.text,1,3),'custo');
        customedioproduto:=Q.fieldbyname('esqt_customedio').ascurrency;
        custoultimoproduto:=Q.fieldbyname('esqt_custo').ascurrency;
        pesototalproduto:=Q.FieldByName('esqt_qtde').AsCurrency*Q.FieldByName('esto_peso').AsCurrency;
        FRel.AddCel(Q.FieldByName('esqt_qtde').AsString);
        FRel.AddCel(Q.FieldByName('esto_peso').AsString);
        FRel.AddCel(floattostr(pesototalproduto));
        if Global.Usuario.OutrosAcessos[0049] then begin
          FRel.AddCel(floattostr(custoultimoproduto));
          FRel.AddCel(floattostr(customedioproduto));
          FRel.AddCel(floattostr(custoultimoproduto*pesototalproduto));
          FRel.AddCel(floattostr(custoultimoproduto*pesototalproduto));
        end;

        Q.Next;

      end;

      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);

  end;

  FRelEstoque_PosicaoEstoqueemPeso;          // 19


end;






procedure TFRelEstoque.EdCodtipoExitEdit(Sender: TObject);
begin
   baplicarclick(FRelEstoque);

end;

procedure TFRelEstoque.EdTipomovExitEdit(Sender: TObject);
begin
   baplicarclick(FRelEstoque);

end;

procedure TFRelEstoque.EdnroobraValidate(Sender: TObject);
begin
  if not EdNroobra.isempty then
//    sqlobra:=' and moes_nroobra='+EdNroobra.AsSql
    sqlobra:=' and move_nroobra='+EdNroobra.AsSql
  else
    sqlobra:='';

end;

procedure TFRelEstoque.EddatafExitEdit(Sender: TObject);
begin
   baplicarclick(FRelEstoque);

end;

procedure TFRelEstoque.EdTamanhosValidate(Sender: TObject);
begin
  sqltamanhos:='';
  if (nrorel=5) and ( not EdTamanhos.IsEmpty ) then
    sqltamanhos:=' and '+fGeral.GetIN('saes_tama_codigo',EdTamanhos.Text,'N')

end;

procedure TFRelEstoque.EdMoes_tabp_codigoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////////
begin
  if EdMoes_tabp_codigo.asinteger>0 then begin
    if not Arq.TTabelaPreco.active then Arq.TTabelaPreco.open;
    if Arq.TTabelaPreco.Locate('tabp_codigo',EdMoes_tabp_codigo.AsInteger,[]) then begin
      SetEdTabp_aliquota.Text:=FTabela.GetDescAliquota(EdMoes_tabp_codigo.asinteger);
      perc:=FTabela.GetAliquota(EdMoes_tabp_codigo.AsInteger);
    end else begin
      SetEdTabp_aliquota.Text:='';
      EdMoes_tabp_codigo.Invalid('Tabela não encontrada');
    end;
  end else begin
    SetEdTabp_aliquota.Text:='';
    perc:=0;
  end;

end;


// 24.06.16
procedure FRelEstoque_RastreamentoProduto;          // 20
///////////////////////////////////////////////////////////
var unidade,produto,op,sqlinicio,nome,sqltermino,xtipomov,
    ultimaoperacao,sqlproduto,sa,sqllote,
    titulofiltro,
    sqlorder,
    sqlprodutor,
    tituloprodutor                    :string;
    QCorte1,QCorte2,QCorte3,QCorte4,
    QVenda1,
    QA                                :TSqlquery;
    i,xcont,tam:integer;
    temcorte2,temcorte3,temcorte4,temvenda1,
    venda1,venda2,
    primeirocorte1 :boolean;
    vlrentrada     :currency;
    Impressas      :TStringList;


    procedure GetPedido( xop:string );
    /////////////////////////////////////////
    begin
        QVenda1:=sqltoquery('select movd_numerodoc,movd_tipo_codigo,movd_vlrarroba,clie_nome,movd_esto_codigo,movd_pesocarcaca,'+
                            ' movd_pesobalanca,movd_datamvto from movabatedet ' +
//                             ' inner join movabate on ( mova_transacao=movd_transacao )'+
                             ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                             ' inner join clientes on ( clie_codigo=movd_tipo_codigo )'+
                             ' where movd_oprastreamento = '+Stringtosql(xop)+
                             ' and movd_status = ''N'''+
//                             ' and movd_tipomov = '+Stringtosql('SA')+
// 13.08.19 - para pegar o q foi pro 'congelado'
                             ' and '+FGeral.GetIN('movd_tipomov','SA;EC','C')+
                             ' and movd_unid_codigo = '+Stringtosql(Q.fieldbyname('movd_unid_codigo').asstring) );
    end;


    function AplicaFiltro(xpesobalanca:currency):boolean;
    ///////////////////////////////////////////////////
    begin

        result:=false;
        if ( FRelEstoque.EdFiltro.text='V' ) and ( xpesobalanca>0 ) then result:=true
        else if FRelEstoque.EdFiltro.text = 'T' then result:=true
        else if ( FRelEstoque.EdFiltro.text = 'E' ) and ( xpesobalanca=0 ) then result:=true;

    end;


begin
///////////////////////////////////////

  with FRelEstoque do begin

    if not FRelEstoque_Execute(20) then Exit;
    Sistema.BeginProcess('Pesquisando movimento');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);
//    if Global.Usuario.Codigo=100 then
//      sa:='S'
//    else
      sa:='A';

    if EdEsto_codigo.AsInteger>0 then
       sqlproduto:= 'and movd_esto_codigo ='+EdEsto_codigo.AsSql
    else
       sqlproduto:='';

// 28.02.20
    if EdQdata.Text = 'A' then begin

      sqlinicio:=' and mova_dtabate>='+Datetosql(EdDatai.AsDate);
      if EdDAtaf.isempty then
         sqltermino:=''
      else
         sqltermino:=' and mova_dtabate<='+Datetosql(EdDataf.Asdate);
//      sqlorder := ' order by mova_datalcto,movd_numerodoc' ;

    end else begin

      sqlinicio:=' and movd_datamvto>='+Datetosql(EdDatai.AsDate);
      if EdDAtaf.isempty then
         sqltermino:=''
      else
         sqltermino:=' and movd_datamvto<='+Datetosql(EdDataf.Asdate);
 //     sqlorder := ' order by movd_numerodoc,movd_ordem' ;

    end;

   sqlorder := ' order by mova_datalcto,movd_numerodoc' ;

    if EdDAtai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;
    xtipomov:='PC';
    if EdTipomov.isempty then begin
      sqltipomovto:=' and '+FGeral.GetIn('movd_tipomov','EA','C');
      if EdQData.text = 'P' then
         sqltipomovto:=' and '+FGeral.GetIn('movd_tipomov', xTipomov ,'C');

    end;

// 10.08.17
    sqlproduto:='';
    if not EdEsto_codigo.IsEmpty then sqlproduto:=' and movd_esto_codigo = '+EdEsto_codigo.AsSql;
    sqllote:='';
    if not EdDocumento.IsEmpty then sqllote:=' and movd_numerodoc = '+EdDocumento.AsSql;
// 13.03.20
    sqlprodutor :='';
    if not EdCodtipo.IsEmpty then sqlprodutor:=' and movd_tipo_codigo = '+EdCodtipo.AsSql;

// 19.09.19
    titulofiltro:=' - Todos os Produtos';
    if EdFiltro.Text = 'V' then titulofiltro:=' - Somente Vendidos'
    else if EdFiltro.Text = 'E' then titulofiltro:=' - Somente Em Estoque';
// 13.03.20
    tituloprodutor:=' - Todos os Produtores';
    if not EdCodtipo.IsEmpty then TituloProdutor := ' - Produtor '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.AsInteger,Edtipocad.text,'N');

    Q:=sqltoquery('select * from movabatedet '+
                     ' inner join movabate on ( mova_transacao=movd_transacao ) '+
                     ' inner join estoque on (esto_codigo=movd_esto_codigo) '+
                     ' where '+FGeral.RelEstoque('movd_status')+
                     ' and '+FGeral.Getin('movd_unid_codigo',EdUnid_codigo.text,'C')+
                     ' and mova_numerodoc=movd_numerodoc '+
                     sqlinicio+
                     sqltermino+
                     sqltipomovto+
                     sqlproduto+
                     sqllote+
                     sqlprodutor+
                     ' and extract( year from mova_dtabate ) = extract( year from mova_datalcto )'+
                     ' and '+FGeral.RelEstoque('mova_status')+
                     sqlorder );

     if Q.Eof then begin

        Avisoerro('Nada encontrado para impressão');
        FGeral.fechaquery(Q);
        Sistema.EndProcess('');
        exit;

     end;
     Sistema.BeginProcess('Gerando Relatório');

     Impressas := TStringList.Create;

     FRel.Init('RastreamentoProdutos');
     if EdQData.Text='A' then

        FRel.AddTit('Rastreamento de Produtos - Período pelo Abate: '+FGeral.formatadata(EdDatai.asdate)+' a '+FGeral.formatadata(EdDAtaf.asdate))

     else

        FRel.AddTit('Rastreamento de Produtos - Período pela pesagem : '+FGeral.formatadata(EdDatai.asdate)+' a '+FGeral.formatadata(EdDAtaf.asdate));

     FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text)+TituloFiltro+TituloProdutor+TituloProdutor);
//      FRel.AddCol( 45,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
     FRel.AddCol( 40,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
     FRel.AddCol(150,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
     FRel.AddCol(150,1,'C','' ,''              ,'Produtor'        ,''         ,'',false);
     FRel.AddCol( 80,3,'N','' ,''              ,'Lote/Etiqueta'   ,''         ,'',false);
// 18.09.19
     FRel.AddCol( 80,3,'N','' ,''              ,'Seq'             ,''         ,'',false);
     FRel.AddCol( 55,1,'D','' ,''              ,'Data'            ,''         ,'',false);
     FRel.AddCol( 40,3,'N','+' ,''             ,'Peças'            ,''         ,'',false);
     FRel.AddCol( 70,3,'N','+' ,''             ,'Peso Abate'            ,''         ,'',false);
     FRel.AddCol( 70,3,'N','+' ,''             ,'Vlr Abate'            ,''         ,'',false);
     FRel.AddCol( 80,1,'C','' ,''              ,''       ,''         ,'',false);
     FRel.AddCol( 80,1,'C','' ,''              ,'Etiqueta'       ,''         ,'',false);
     FRel.AddCol( 50,1,'N','' ,''              ,'Cod.Corte'       ,''         ,'',false);
     FRel.AddCol(150,1,'C','' ,''              ,'Desc.Corte'           ,''         ,'',false);
     FRel.AddCol( 40,3,'N','+' ,''             ,'Peças'            ,''         ,'',false);
     FRel.AddCol( 70,3,'N','+' ,''             ,'Peso'            ,''         ,'',false);
     FRel.AddCol( 70,3,'N','' ,''              ,'Corte'            ,''         ,'',false);
     FRel.AddCol( 70,3,'N','+' ,''             ,'Peso Balança'     ,''         ,'',false);
     FRel.AddCol( 70,3,'N',''  ,''             ,'Pedido'           ,''         ,'',false);
     FRel.AddCol( 70,3,'N','+'  ,''            ,'Vlr Venda'         ,''         ,'',false);
     FRel.AddCol( 60,1,'D',''  ,''             ,'Data Pedido'        ,''         ,'',false);
     FRel.AddCol( 60,3,'N',''  ,''             ,'Cod.Cliente'        ,''         ,'',false);
     FRel.AddCol(150,1,'C',''  ,''             ,'Cliente'           ,''         ,'',false);
     {
     FRel.AddCol( 40,1,'N','' ,''              ,'Cod.Corte'       ,''         ,'',false);
     FRel.AddCol(150,1,'C','' ,''              ,'Corte'           ,''         ,'',false);
     FRel.AddCol( 40,3,'N','+' ,''             ,'Peças'            ,''         ,'',false);
     FRel.AddCol( 70,3,'N','+' ,''             ,'Peso'            ,''         ,'',false);
     FRel.AddCol( 40,1,'N','' ,''              ,'Cod.Corte'       ,''         ,'',false);
     FRel.AddCol(150,1,'C','' ,''              ,'Corte'           ,''         ,'',false);
     FRel.AddCol( 40,3,'N','+' ,''             ,'Peças'            ,''         ,'',false);
     FRel.AddCol( 70,3,'N','+' ,''             ,'Peso'            ,''         ,'',false);
     FRel.AddCol( 40,1,'N','' ,''              ,'Cod.Corte'       ,''         ,'',false);
     FRel.AddCol(150,1,'C','' ,''              ,'Corte'           ,''         ,'',false);
     FRel.AddCol( 40,3,'N','+' ,''             ,'Peças'            ,''         ,'',false);
     FRel.AddCol( 70,3,'N','+' ,''             ,'Peso'            ,''         ,'',false);
     FRel.AddCol( 40,1,'N','' ,''              ,'Cod.Corte'       ,''         ,'',false);
     FRel.AddCol(150,1,'C','' ,''              ,'Corte'           ,''         ,'',false);
     FRel.AddCol( 40,3,'N','+' ,''             ,'Peças'            ,''         ,'',false);
     FRel.AddCol( 70,3,'N','+' ,''             ,'Peso'            ,''         ,'',false);
     }
     temcorte3:=false;

     while not Q.eof do begin

{
          FRel.AddCel(Q.FieldByName('movd_esto_codigo').AsString);
          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
          FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade( Q.FieldByName('movd_tipo_codigo').AsInteger,'C','N' ) );
          FRel.AddCel(Q.FieldByName('movd_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('movd_ordem').AsString);
          FRel.AddCel(Q.FieldByName('mova_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('movd_pecas').AsString);
          FRel.AddCel(Q.FieldByName('movd_pesocarcaca').AsString);
          }
{
          if sa='A' then begin
            for i:=1 to 06 do FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
          end;
}

// primeiro pega os dois 'primeiro corte' - boi -> carcaça
        tam:=Length(Q.fieldbyname('movd_transacao').asstring+strzero(Q.fieldbyname('movd_ordem').asinteger,3));
        QCorte1:=sqltoquery('select * from movabatedet ' +
                           ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
//                           ' where substr(movd_operacao,1,'+inttostr(tam)+') = '+Stringtosql(Q.fieldbyname('movd_transacao').asstring+strzero(Q.fieldbyname('movd_ordem').asinteger,3))+
// 22.01.19  - para ficar menos demorado...
                           ' where movd_transacao = '+Stringtosql(Q.fieldbyname('movd_transacao').asstring) +
                           ' and movd_ordem = '+inttostr(Q.fieldbyname('movd_ordem').asinteger)+
                           ' and movd_status = ''N'''+
                           ' and movd_tipomov = '+Stringtosql(xtipomov)+
                           ' and '+FGeral.GetIN('movd_tipomov',xtipomov+';'+'EC','C')+
                           ' and movd_unid_codigo = '+Stringtosql(Q.fieldbyname('movd_unid_codigo').asstring) );
        primeirocorte1:=true;

        while not QCorte1.eof do begin

          if (Sa='A') and  ( AplicaFiltro( QCorte1.FieldByName('movd_pesobalanca').Ascurrency ) ) then begin

{
              for i:=1 to 08 do FRel.AddCel('');
              }
          if EdQData.Text= 'A' then begin

            FRel.AddCel(Q.FieldByName('movd_esto_codigo').AsString);
            FRel.AddCel(Q.FieldByName('esto_descricao').AsString);

          end else begin

            QA:=sqltoquery('select * from movabatedet '+
                     ' inner join movabate on (mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc ) '+
                     ' inner join estoque on (esto_codigo=movd_esto_codigo) '+
                     ' where '+FGeral.RelEstoque('movd_status')+
                     ' and '+FGeral.Getin('movd_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     ' and movd_transacao = '+Stringtosql(Q.FieldByName('movd_transacao').AsString)+
                     ' and movd_ordem     = '+Q.FieldByName('movd_ordem').AsString+
                     ' and movd_tipomov   = '+Stringtosql('EA') );

            FRel.AddCel( QA.FieldByName('movd_esto_codigo').AsString);
            FRel.AddCel( QA.FieldByName('esto_descricao').AsString);

          end;

          FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade( Q.FieldByName('movd_tipo_codigo').AsInteger,'C','N' ) );
          FRel.AddCel(Q.FieldByName('movd_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('movd_ordem').AsString);
          if EdQData.text = 'A' then
//             FRel.AddCel(Q.FieldByName('mova_datalcto').AsString);
             FRel.AddCel(Q.FieldByName('mova_dtabate').AsString)
          else
             FRel.AddCel(Q.FieldByName('movd_datamvto').AsString);

          vlrentrada:=0;

          if PrimeiroCorte1 then begin

             if EdQData.Text= 'A' then
                FRel.AddCel(Q.FieldByName('movd_pecas').AsString)
             else
                FRel.AddCel(QA.FieldByName('movd_pecas').AsString);

             primeirocorte1:=false;
// 02.03.20
             if EdQDAta.Text = 'P' then begin

                if Qa.FieldByName('movd_pesobalanca').Ascurrency > 0 then begin

                  FRel.AddCel(Qa.FieldByName('movd_pesobalanca').AsString)  ;
                  vlrentrada:=Qa.FieldByName('movd_pesobalanca').Ascurrency*
                              (Qa.FieldByName('movd_vlrarroba').Ascurrency/15);
                  FRel.AddCel( FGeral.Formatavalor(vlrentrada,f_cr) );

                end else begin

                  FRel.AddCel(Qa.FieldByName('movd_pesocarcaca').AsString);
                  vlrentrada:=Qa.FieldByName('movd_pesocarcaca').Ascurrency*
                              (Qa.FieldByName('movd_vlrarroba').Ascurrency/30);
                  FRel.AddCel( FGeral.Formatavalor(vlrentrada,f_cr) );

                end;

             end else begin
// 18.09.19  - 13.03.20 - somente o peso da carcaça descontando tara + quebra
//                if Q.FieldByName('movd_pesobalanca').Ascurrency > 0 then begin
//
//                  FRel.AddCel(Q.FieldByName('movd_pesobalanca').AsString)  ;
//                    vlrentrada:=Q.FieldByName('movd_pesobalanca').Ascurrency*
//                              (Q.FieldByName('movd_vlrarroba').Ascurrency/15);
 //                 FRel.AddCel( FGeral.Formatavalor(vlrentrada,f_cr) );

//                end else begin

                  FRel.AddCel(Q.FieldByName('movd_pesocarcaca').AsString);
                  vlrentrada:=Q.FieldByName('movd_pesocarcaca').Ascurrency*
                              (Q.FieldByName('movd_vlrarroba').Ascurrency/15);
                  FRel.AddCel( FGeral.Formatavalor(vlrentrada,f_cr) );

//                end;

             end;

          end else begin

             FRel.AddCel('');
             FRel.AddCel('');
             FRel.AddCel('');

          end;

              FRel.AddCel(QCorte1.FieldByName('movd_brinco').AsString);

// 07.02.20 - etiquetas 'repetidas'
          if Impressas.indexof( QCorte1.FieldByName('movd_operacao').AsString )=-1 then begin
//          if true then begin

              FRel.AddCel(QCorte1.FieldByName('movd_operacao').AsString);

// 24.02.20
              GetPedido(QCorte1.FieldByName('movd_operacao').AsString);
              if (QCorte1.FieldByName('movd_brinco').AsString = 'CASADO')
                and
                ( not QVenda1.eof )
                then begin

                FRel.AddCel(QVenda1.FieldByName('movd_esto_codigo').AsString);
                FRel.AddCel( FEstoque.GetDescricao( QVenda1.FieldByName('movd_esto_codigo').AsString) );

              end else begin

                FRel.AddCel(QCorte1.FieldByName('movd_esto_codigo').AsString);
                FRel.AddCel(QCorte1.FieldByName('esto_descricao').AsString);

              end;
// 18.09.19
//              if QCorte1.FieldByName('movd_baia').AsString <> 'D' then begin

                FRel.AddCel(QCorte1.FieldByName('movd_pecas').AsString);
// 05.02.18
//                if Q.FieldByName('movd_pesocarcaca').AsCurrency=QCorte1.FieldByName('movd_pesocarcaca').AsCurrency then
//                  FRel.AddCel('*'+Floattostr(QCorte1.FieldByName('movd_pesocarcaca').AsCurrency/2))
//                else
//                  FRel.AddCel(QCorte1.FieldByName('movd_pesocarcaca').AsString);
// 05.03.2020
                if QCorte1.FieldByName('movd_pesocarcaca').AsCurrency<30 then
                  FRel.AddCel('*'+Floattostr(FComposicao.getpesocomposicao(Q.FieldByName('movd_esto_codigo').AsString,QCorte1.FieldByName('movd_esto_codigo').AsString,Q.FieldByName('movd_pesobalanca').Ascurrency/2   ) ))
                else
                  FRel.AddCel(QCorte1.FieldByName('movd_pesocarcaca').AsString);

//              end else begin

 //                FRel.AddCel('');
//                 FRel.AddCel('');
//
//              end;

              FRel.AddCel('1');

// 05.02.18
              if Q.FieldByName('movd_pesocarcaca').AsCurrency=QCorte1.FieldByName('movd_pesocarcaca').AsCurrency then begin

                FRel.AddCel('*'+Floattostr(QCorte1.FieldByName('movd_pesocarcaca').AsCurrency/2));
 // retirado em 05.04.18
 // recolocado em 18.04.18
 // retirado em 04.03.20
{
                Sistema.Edit('movabatedet');
                Sistema.SetField('movd_pesocarcaca',QCorte1.FieldByName('movd_pesocarcaca').AsCurrency/2);
                Sistema.Post('movd_operacao='+Stringtosql(QCorte1.FieldByName('movd_operacao').AsString));
                Sistema.Commit;
}
              end else

//                FRel.AddCel(QCorte1.FieldByName('movd_pesocarcaca').AsString);
// 31.10.18  - 15/01/20
//                if Impressas.indexof( QCorte1.FieldByName('movd_operacao').AsString )=-1 then

//                   FRel.AddCel(QCorte1.FieldByName('movd_pesobalanca').AsString);
// 13.03.20 - Isonel
                   if not QVenda1.Eof then
                      FRel.AddCel(QVenda1.FieldByName('movd_pesocarcaca').AsString)
                   else
                      FRel.AddCel(QCorte1.FieldByName('movd_pesobalanca').AsString);

//                else
//
//                   FRel.AddCel('');

// 15.01.20
              if Impressas.indexof( QCorte1.FieldByName('movd_operacao').AsString )=-1 then
                 Impressas.Add( QCorte1.FieldByName('movd_operacao').AsString);

// 05.04.18 - mudado acima em 24.02.20
//              GetPedido(QCorte1.FieldByName('movd_operacao').AsString);

              if QVenda1.Eof then begin

                  if Sa='A' then begin
                    FRel.AddCel('');
                    FRel.AddCel('');
                    FRel.AddCel('');
                    FRel.AddCel('');
// 24.04.20 - data do pedido
                    FRel.AddCel('');
                  end;

              end else begin
                  if Sa='S' then begin
//                    FRel.AddCel('');
//                    FRel.AddCel('');
//                    FRel.AddCel('');
//                    FRel.AddCel('');
                  end;
                  FRel.AddCel(QVenda1.fieldbyname('movd_numerodoc').AsString);
// 13.03.20 - Isonel
//                  FRel.AddCel(floattostr(QVenda1.fieldbyname('movd_vlrarroba').AsCurrency*QCorte1.FieldByName('movd_pesobalanca').AsCurrency));
                  FRel.AddCel(floattostr(QVenda1.fieldbyname('movd_vlrarroba').AsCurrency*QVenda1.FieldByName('movd_pesocarcaca').AsCurrency));
// 24.04.20 - data do pedido
                  FRel.AddCel(QVenda1.fieldbyname('movd_datamvto').AsString);
                  FRel.AddCel(QVenda1.fieldbyname('movd_tipo_codigo').AsString);
                  FRel.AddCel(QVenda1.fieldbyname('clie_nome').AsString);
                  venda1:=true;
              end;

          end else begin

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
// 24.04.20 - data do pedido
              FRel.AddCel('');

          end; // para nao imprimir repetido etiqueta

//              FRel.AddCel('');
//             FRel.AddCel('');
//              FRel.AddCel('');
//              FRel.AddCel('');

         end;  // aqui do Sa='A'  e aplica filtro ?

            ultimaoperacao:=QCorte1.FieldByName('movd_operacao').AsString;
//
            QCorte2:=sqltoquery('select * from movabatedet ' +
                           ' inner join movabate on ( mova_transacao=movd_transacao )'+
                           ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                           ' where mova_transacaogerada = '+Stringtosql(QCorte1.fieldbyname('movd_operacao').asstring)+
                           ' and movd_status = ''N'''+
                           ' and movd_tipomov = '+Stringtosql(xtipomov)+
                           ' and movd_unid_codigo = '+Stringtosql(QCorte1.fieldbyname('movd_unid_codigo').asstring) );
            if not QCorte2.Eof then begin

              if Sa='A' then begin
//                for i:=1 to 07 do FRel.AddCel('');
// 19.09.19
                for i:=1 to 09 do FRel.AddCel('');
//                for i:=1 to 11 do FRel.AddCel('---------------------------------------------');
//                for i:=1 to 12 do FRel.AddCel('');
// 24.04.20 - data do pedido
                for i:=1 to 13 do FRel.AddCel('');
              end;

            end;

            temcorte2:=false;

            while not Qcorte2.Eof do begin

//              if Sa='A' then begin
              if (Sa='A') and  ( AplicaFiltro( QCorte2.FieldByName('movd_pesobalanca').Ascurrency ) ) then begin

//                for i:=1 to 07 do FRel.AddCel('');
// 19.09.19
                FRel.AddCel(Q.FieldByName('movd_esto_codigo').AsString);
                FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
                FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade( Q.FieldByName('movd_tipo_codigo').AsInteger,'C','N' ) );
                FRel.AddCel(Q.FieldByName('movd_numerodoc').AsString);
                FRel.AddCel(Q.FieldByName('movd_ordem').AsString);
                FRel.AddCel('');
                FRel.AddCel('');
                FRel.AddCel('');
                FRel.AddCel('');
/////////////////////
                FRel.AddCel(QCorte2.FieldByName('movd_brinco').AsString);

// 07.02.20 - etiquetas 'repetidas'
             if Impressas.indexof( QCorte2.FieldByName('movd_operacao').AsString )=-1 then begin
//            if true then begin


                FRel.AddCel(QCorte2.FieldByName('movd_operacao').AsString);
                FRel.AddCel(QCorte2.FieldByName('movd_esto_codigo').AsString);
                FRel.AddCel(QCorte2.FieldByName('esto_descricao').AsString);
  //              FRel.AddCel('');
                FRel.AddCel(QCorte2.FieldByName('movd_pecas').AsString);
                FRel.AddCel(QCorte2.FieldByName('movd_pesocarcaca').AsString);
                FRel.AddCel('2');
// 15.01.20
                if Impressas.indexof( QCorte2.FieldByName('movd_operacao').AsString )=-1 then

                   FRel.AddCel(QCorte2.FieldByName('movd_pesobalanca').AsString)

                else

                   FRel.AddCel('');

                ultimaoperacao:=QCorte2.FieldByName('movd_operacao').AsString;
{ - 05.04.18 - pra imprimir se foi vendido o pedaço
                FRel.AddCel('');
                FRel.AddCel('');
                FRel.AddCel('');
                FRel.AddCel('');
}
//              end;     19.09.19
// 15.01.20
              if Impressas.indexof( QCorte2.FieldByName('movd_operacao').AsString )=-1 then
                 Impressas.Add( QCorte2.FieldByName('movd_operacao').AsString);

// 05.04.18
              GetPedido(QCorte2.FieldByName('movd_operacao').AsString);
              if QVenda1.Eof then begin

                  if Sa='A' then begin
                    FRel.AddCel('');
                    FRel.AddCel('');
                    FRel.AddCel('');
                    FRel.AddCel('');
// 24.04.20 - data do pedido
                    FRel.AddCel('');
                  end;

              end else begin

                  if Sa='S' then begin
//                    FRel.AddCel('');
//                    FRel.AddCel('');
//                    FRel.AddCel('');
//                    FRel.AddCel('');
                  end;
                  FRel.AddCel(QVenda1.fieldbyname('movd_numerodoc').AsString);
                  FRel.AddCel(floattostr(QVenda1.fieldbyname('movd_vlrarroba').AsCurrency*QCorte2.FieldByName('movd_pesobalanca').AsCurrency));
// 24.04.20 - data do pedido
                  FRel.AddCel(QVenda1.fieldbyname('movd_datamvto').AsString);

                  FRel.AddCel(QVenda1.fieldbyname('movd_tipo_codigo').AsString);
                  FRel.AddCel(QVenda1.fieldbyname('clie_nome').AsString);
                  venda1:=true;
              end;
// etq 'repetidas
             end else begin

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
// 24.04.20 - data do pedido
                    FRel.AddCel('');

             end;

             end; // 19.09 Sa='A'...

              QCorte3:=sqltoquery('select * from movabatedet ' +
                           ' inner join movabate on ( mova_transacao=movd_transacao )'+
                           ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                           ' where mova_transacaogerada = '+Stringtosql(QCorte2.fieldbyname('movd_operacao').asstring)+
                           ' and movd_status = ''N'''+
//                           ' and movd_tipomov = '+Stringtosql(xtipomov)+
// 13.08.19
                           ' and '+FGeral.GetIN('movd_tipomov',xtipomov+';EC','C')+
                           ' and movd_unid_codigo = '+Stringtosql(QCorte2.fieldbyname('movd_unid_codigo').asstring) );
// 16.08.17
              if not QCorte3.Eof then begin

                if Sa='A' then begin
//                  for i:=1 to 07 do FRel.AddCel('');
// 19.09
                  for i:=1 to 09 do FRel.AddCel('');
//                  for i:=1 to 11 do FRel.AddCel('---------------------------------------------');
//                  for i:=1 to 12 do FRel.AddCel('');
// 20.04.20 - data do pedido
                  for i:=1 to 13 do FRel.AddCel('');
                end;

              end;

              temcorte3:=false;
              venda1:=false;

              while not Qcorte3.Eof do begin

//                if Sa='A' then begin
//19.09.19
              if (Sa='A') and  ( AplicaFiltro( QCorte3.FieldByName('movd_pesobalanca').Ascurrency ) ) then begin

//                  for i:=1 to 07 do FRel.AddCel('');
          FRel.AddCel(Q.FieldByName('movd_esto_codigo').AsString);
          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
          FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade( Q.FieldByName('movd_tipo_codigo').AsInteger,'C','N' ) );
          FRel.AddCel(Q.FieldByName('movd_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('movd_ordem').AsString);
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
///////////////////////
                  FRel.AddCel(QCorte3.FieldByName('movd_brinco').AsString);

// 10.02.20 - etiquetas 'repetidas'
            if Impressas.indexof( QCorte3.FieldByName('movd_operacao').AsString )=-1 then begin
//              if true then begin

                  FRel.AddCel(QCorte3.FieldByName('movd_operacao').AsString);
                  FRel.AddCel(QCorte3.FieldByName('movd_esto_codigo').AsString);
                  FRel.AddCel(QCorte3.FieldByName('esto_descricao').AsString);
    //              FRel.AddCel('');
                  FRel.AddCel(QCorte3.FieldByName('movd_pecas').AsString);
                  FRel.AddCel(QCorte3.FieldByName('movd_pesocarcaca').AsString);
                  FRel.AddCel('3');
// 15.01.20
                if Impressas.indexof( QCorte3.FieldByName('movd_operacao').AsString )=-1 then

                   FRel.AddCel(QCorte3.FieldByName('movd_pesobalanca').AsString)

                else

                   FRel.AddCel('');
//                end;  // 19.09.19

// 15.01.20
              if Impressas.indexof( QCorte3.FieldByName('movd_operacao').AsString )=-1 then
                 Impressas.Add( QCorte3.FieldByName('movd_operacao').AsString);

//                FRel.AddCel(GetPedido(QCorte3.FieldByName('movd_operacao').AsString));
                GetPedido(QCorte3.FieldByName('movd_operacao').AsString);
                if QVenda1.Eof then begin
                  if Sa='A' then begin
                    FRel.AddCel('');
                    FRel.AddCel('');
                    FRel.AddCel('');
                    FRel.AddCel('');
// 24.04.20 - data do pedido
                    FRel.AddCel('');

                  end;
                end else begin
                  if Sa='S' then begin
                    FRel.AddCel('');
                    FRel.AddCel('');
                    FRel.AddCel('');
                    FRel.AddCel('');
                    FRel.AddCel('');
                    FRel.AddCel('');
                    FRel.AddCel('');
                  end;
                  FRel.AddCel(QVenda1.fieldbyname('movd_numerodoc').AsString);
                  FRel.AddCel(floattostr(QVenda1.fieldbyname('movd_vlrarroba').AsCurrency*QCorte3.FieldByName('movd_pesobalanca').AsCurrency));
 // 24.04.20 - data do pedido
                  FRel.AddCel(QVenda1.fieldbyname('movd_datamvto').AsString);
                  FRel.AddCel(QVenda1.fieldbyname('movd_tipo_codigo').AsString);
                  FRel.AddCel(QVenda1.fieldbyname('clie_nome').AsString);
                  venda1:=true;

                end;
                FGeral.FechaQuery(QVenda1);
                ultimaoperacao:=QCorte3.FieldByName('movd_operacao').AsString;
                temcorte3:=true;

            end else begin

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
 // 20.04.20 - data do pedido
                    FRel.AddCel('');

            end;

//                FGeral.FechaQuery(QVenda1);
//                ultimaoperacao:=QCorte3.FieldByName('movd_operacao').AsString;
//                temcorte3:=true;

                end;  // 19.09.19

                QCorte4:=sqltoquery('select * from movabatedet ' +
                             ' inner join movabate on ( mova_transacao=movd_transacao )'+
                             ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                             ' where mova_transacaogerada = '+Stringtosql(QCorte3.fieldbyname('movd_operacao').asstring)+
                             ' and movd_status = ''N'''+
                             ' and movd_tipomov = '+Stringtosql(xtipomov)+
                             ' and movd_unid_codigo = '+Stringtosql(QCorte3.fieldbyname('movd_unid_codigo').asstring) );
// 16.08.17
                if (not QCorte4.Eof) then begin
                  if Sa='A' then begin
//                    for i:=1 to 07 do FRel.AddCel('');
//                    for i:=1 to 11 do FRel.AddCel('---------------------------------------------');
// 19.09.19
                    for i:=1 to 09 do FRel.AddCel('');
//                    for i:=1 to 12 do FRel.AddCel('');
// 20.04.20 - data do pedido
                    for i:=1 to 13 do FRel.AddCel('');
                  end;
                end;
                temcorte4:=false;
                venda2:=false;
                while not Qcorte4.Eof do begin

                  if Sa='A' then begin

//                    for i:=1 to 07 do FRel.AddCel('');
// 19.09.19
          FRel.AddCel(Q.FieldByName('movd_esto_codigo').AsString);
          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
          FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade( Q.FieldByName('movd_tipo_codigo').AsInteger,'C','N' ) );
          FRel.AddCel(Q.FieldByName('movd_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('movd_ordem').AsString);
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
///////////////////////

                    FRel.AddCel(QCorte1.FieldByName('movd_brinco').AsString);
                    FRel.AddCel(QCorte4.FieldByName('movd_operacao').AsString);
                    FRel.AddCel(QCorte4.FieldByName('movd_esto_codigo').AsString);
                    FRel.AddCel(QCorte4.FieldByName('esto_descricao').AsString);
      //              FRel.AddCel('');
                    FRel.AddCel(QCorte4.FieldByName('movd_pecas').AsString);
                    FRel.AddCel(QCorte4.FieldByName('movd_pesocarcaca').AsString);
                    FRel.AddCel('4');
                    FRel.AddCel(QCorte4.FieldByName('movd_pesobalanca').AsString);
                  end;

                  GetPedido(QCorte4.FieldByName('movd_operacao').AsString);
                  if QVenda1.Eof then begin
                    if Sa='A' then begin

                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
  // 24.04.20 - data do pedido
                      FRel.AddCel('');

                  end else begin
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                    end;
                  end else begin
                    if Sa='S' then begin
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      {
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      }
                    end;
                    FRel.AddCel(QVenda1.fieldbyname('movd_numerodoc').AsString);
                    FRel.AddCel(floattostr(QVenda1.fieldbyname('movd_vlrarroba').AsCurrency*QCorte4.FieldByName('movd_pesobalanca').AsCurrency));
// 24.04.20 - data do pedido
                    FRel.AddCel(QVenda1.fieldbyname('movd_datamvto').AsString);
                    FRel.AddCel(QVenda1.fieldbyname('movd_tipo_codigo').AsString);
                    FRel.AddCel(QVenda1.fieldbyname('clie_nome').AsString);

                    if (Sa='S') and (not temcorte4) then begin
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                    end;
                    venda2:=true;

                  end;

                  FGeral.FechaQuery(QVenda1);
                  ultimaoperacao:=QCorte4.FieldByName('movd_operacao').AsString;
                  temcorte4:=true;
                  QCorte4.Next;
                end;
                FGeral.FechaQuery(QCorte4);

                QCorte3.Next;
// 16.08.17
                if (QCorte3.Eof) then begin
//                  if Sa='A' then begin
//                    for i:=1 to 07 do FRel.AddCel('');
//                    for i:=1 to 11 do FRel.AddCel('---------------------------------------------');
// 19.09.19
                    for i:=1 to 09 do FRel.AddCel('');
//                    for i:=1 to 12 do FRel.AddCel('');
// 20.04.20 - data do pedido
                    for i:=1 to 13 do FRel.AddCel('');
//                  end;
                end;

              end;
              FGeral.FechaQuery(QCorte3);

              temcorte2:=true;
              QCorte2.Next;
            end;
            FGeral.FechaQuery(QCorte2);
            if temcorte2 then begin
              if Sa='A' then begin
//                for i:=1 to 07 do FRel.AddCel('');
//                for i:=1 to 11 do FRel.AddCel('---------------------------------------------');
// 19.09.19
                for i:=1 to 09 do FRel.AddCel('');
//                for i:=1 to 12 do FRel.AddCel('');
// 20.04.20 - data do pedido
                for i:=1 to 13 do FRel.AddCel('');
              end;
            end;
 //
            QCorte1.Next;

        end; // do primeiro Sa='A' e aplicafiltro ?
        FGeral.FechaQuery(QCorte1);
///////////////////////
  {
        QVenda1:=sqltoquery('select * from movabatedet ' +
//                             ' inner join movabate on ( mova_transacao=movd_transacao )'+
                             ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                             ' where movd_oprastreamento = '+Stringtosql(ultimaoperacao)+
                             ' and movd_status = ''N'''+
                             ' and movd_tipomov = '+Stringtosql('SA')+
                             ' and movd_unid_codigo = '+Stringtosql(Q.fieldbyname('movd_unid_codigo').asstring) );
         temvenda1:=false;
         while not QVenda1.Eof do begin
            for i:=1 to 07 do FRel.AddCel('');
                  FRel.AddCel(QVenda1.FieldByName('movd_operacao').AsString);
                  FRel.AddCel(QVenda1.FieldByName('movd_esto_codigo').AsString);
                  FRel.AddCel(QVenda1.FieldByName('esto_descricao').AsString);
                  FRel.AddCel(QVenda1.FieldByName('movd_pecas').AsString);
                  FRel.AddCel(QVenda1.FieldByName('movd_pesocarcaca').AsString);
                  FRel.AddCel('5');
                  FRel.AddCel(QVenda1.FieldByName('movd_pesobalanca').AsString);
                  ultimaoperacao:=QVenda1.FieldByName('movd_operacao').AsString;
                  temvenda1:=true;
            QVenda1.Next;
         end;
         FGeral.FechaQuery(QVenda1);
         }
///////////////////////

        Q.Next;


     end;
// 20.09.19 - buscando itens a serem vendidos nas 'caixas'..embalados
/////////////////////////////////////////////////////////////////////////
    sqltipomovto:=' and '+FGeral.GetIn('movd_tipomov','ER','C');
    Q:=sqltoquery('select * from movabatedet '+
                     ' inner join movabate on (mova_transacao=movd_transacao ) '+
                     ' inner join estoque on (esto_codigo=movd_esto_codigo) '+
                     ' where '+FGeral.RelEstoque('movd_status')+
                     ' and '+FGeral.Getin('movd_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+
                     sqltipomovto+
                     sqlproduto+
                     sqllote+
                     sqlprodutor+
                     ' and extract( year from mova_dtabate ) = extract( year from mova_datalcto )'+
                     ' and '+FGeral.RelEstoque('mova_status')+
                     ' order by mova_datalcto,movd_numerodoc' );

     while not Q.Eof do begin

          QCorte1:=sqltoquery('select * from movabatedet ' +
                           ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                           ' where movd_transacao = '+Stringtosql(Q.fieldbyname('movd_transacao').asstring) +
                           ' and movd_ordem = '+inttostr(Q.fieldbyname('movd_ordem').asinteger)+
                           ' and movd_status = ''N'''+
                           ' and movd_tipomov = '+Stringtosql(xtipomov)+
                           ' and '+FGeral.GetIN('movd_tipomov',xtipomov+';'+'EC','C')+
                           ' and movd_unid_codigo = '+Stringtosql(Q.fieldbyname('movd_unid_codigo').asstring) );

          FRel.AddCel(Q.FieldByName('movd_esto_codigo').AsString);
          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
          FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade( Q.FieldByName('movd_tipo_codigo').AsInteger,'U','N' ) );
          FRel.AddCel(Q.FieldByName('movd_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('movd_ordem').AsString);
          FRel.AddCel(Q.FieldByName('mova_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('movd_pecas').AsString);

          if Q.FieldByName('movd_pesobalanca').Ascurrency > 0 then begin

              FRel.AddCel(Q.FieldByName('movd_pesobalanca').AsString)  ;
              vlrentrada:=Q.FieldByName('movd_pesobalanca').Ascurrency*
                          (Q.FieldByName('movd_vlrarroba').Ascurrency/15);
              FRel.AddCel( FGeral.Formatavalor(vlrentrada,f_cr) );

          end else begin

              FRel.AddCel(Q.FieldByName('movd_pesocarcaca').AsString);
              vlrentrada:=Q.FieldByName('movd_pesocarcaca').Ascurrency*
                          (Q.FieldByName('movd_vlrarroba').Ascurrency/30);
              FRel.AddCel( FGeral.Formatavalor(vlrentrada,f_cr) );

         end;


///////////////////////
                    FRel.AddCel(QCorte1.FieldByName('movd_brinco').AsString);
                    FRel.AddCel(QCorte1.FieldByName('movd_operacao').AsString);
                    FRel.AddCel(QCorte1.FieldByName('movd_esto_codigo').AsString);
                    FRel.AddCel(QCorte1.FieldByName('esto_descricao').AsString);
      //              FRel.AddCel('');
                    FRel.AddCel(QCorte1.FieldByName('movd_pecas').AsString);
                    FRel.AddCel(QCorte1.FieldByName('movd_pesocarcaca').AsString);
                    FRel.AddCel('');
                    FRel.AddCel(QCorte1.FieldByName('movd_pesobalanca').AsString);

                  GetPedido(QCorte1.FieldByName('movd_operacao').AsString);
                  if QVenda1.Eof then begin
                    if Sa='A' then begin

                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
// 24.04.20 - data do pedido
                      FRel.AddCel('');

                    end else begin
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                    end;
                  end else begin
                    if Sa='S' then begin
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      {
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      }
                    end;
                    FRel.AddCel(QVenda1.fieldbyname('movd_numerodoc').AsString);
                    FRel.AddCel(floattostr(QVenda1.fieldbyname('movd_vlrarroba').AsCurrency*QCorte1.FieldByName('movd_pesobalanca').AsCurrency));
// 24.04.20 - data do pedido
                    FRel.AddCel(QVenda1.fieldbyname('movd_datamvto').AsString);
                    FRel.AddCel(QVenda1.fieldbyname('movd_tipo_codigo').AsString);
                    FRel.AddCel(QVenda1.fieldbyname('clie_nome').AsString);

                    if (Sa='S')  then begin
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                      FRel.AddCel('');
                    end;

                  end;

         Q.Next;
         QCorte1.Close;

     end;

     FRel.Video;
     Q.close;
     Sistema.EndProcess('');

  end;
  FRelEstoque_RastreamentoProduto;

end;

procedure FRelEstoque_RastreamentoVendas  ;          // 21
///////////////////////////////////////////////////////////
type TVendas=record
     produto:string;
     peso,valor:currency;
end;

var unidade,produto,op,sqlinicio,nome,sqltermino,xtipomov,ultimaoperacao,sqlproduto:string;
    QCorte1,QCorte2,QCorte3,QCorte4,QVenda1:TSqlquery;
    i,xcont,tam:integer;
    temcorte2,temcorte3,temcorte4,temvenda1,venda1,venda2:boolean;
    PVendas:^TVendas ;
    ListaV:TList;
    margem:currency;


    procedure GetPedido( xop:string );
    /////////////////////////////////////////
    begin
        QVenda1:=sqltoquery('select movd_numerodoc,movd_tipo_codigo,movd_vlrarroba,clie_nome from movabatedet ' +
//                             ' inner join movabate on ( mova_transacao=movd_transacao )'+
//                             ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
// 08.01.19
                             ' inner join estoque on ( esto_codigo=movd_esto_codigoven )'+
                             ' inner join clientes on ( clie_codigo=movd_tipo_codigo )'+
                             ' where movd_oprastreamento = '+Stringtosql(xop)+
                             ' and movd_status = ''N'''+
                             ' and movd_tipomov = '+Stringtosql('SA')+
                             ' and movd_unid_codigo = '+Stringtosql(Q.fieldbyname('movd_unid_codigo').asstring) );
    end;

     procedure IncluiVenda(xcodigo:string;peso:currency ; xvalor:currency=0);
     ///////////////////////////////////////////////////////////////////////////
     var achou:boolean;
         p:integer;
     begin
         achou:=false;
         for p := 0 to ListaV.Count-1 do begin
           PVendas:=ListaV[p];
           if PVendas.produto=xcodigo then begin
             achou:=true;
             break;
           end;
         end;
         if not achou then begin
           New(PVendas);
           PVendas.produto:=xcodigo;
           PVendas.peso:=peso;
           PVendas.valor:=xvalor;
           ListaV.Add(PVendas)
         end else begin
           PVendas.peso:=PVendas.peso+peso;
           PVendas.valor:=PVendas.valor+xvalor;
         end;
     end;

begin
///////////////////////////////////////

  with FRelEstoque do begin
    if not FRelEstoque_Execute(21) then Exit;
    Sistema.BeginProcess('Pesquisando movimento');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);

    if EdEsto_codigo.AsInteger>0 then
       sqlproduto:= 'and movd_esto_codigo ='+EdEsto_codigo.AsSql
    else
       sqlproduto:='';

    sqlinicio:=' and mova_dtabate>='+Datetosql(EdDatai.AsDate);

    if EdDAtaf.isempty then
       sqltermino:=''
    else
       sqltermino:=' and mova_dtabate<='+Datetosql(EdDataf.Asdate);
    if EdDAtai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;
    xtipomov:='PC';
    if EdTipomov.isempty then
      sqltipomovto:=' and '+FGeral.GetIn('movd_tipomov','EA','C');
    sqlproduto:='';
    if not EdEsto_codigo.IsEmpty then sqlproduto:=' and movd_esto_codigo = '+EdEsto_codigo.AsSql;

    Q:=sqltoquery('select * from movabatedet '+
                     ' inner join movabate on (mova_transacao=movd_transacao ) '+
                     ' inner join estoque on (esto_codigo=movd_esto_codigo) '+
                     ' where '+FGeral.RelEstoque('movd_status')+
                     ' and '+FGeral.Getin('movd_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+
                     sqltipomovto+
                     sqlproduto+
                     ' and extract( year from mova_dtabate ) = extract( year from mova_datalcto )'+
                     ' and '+FGeral.RelEstoque('mova_status')+
                     ' order by mova_datalcto,movd_numerodoc' );
     if Q.Eof then begin
        Avisoerro('Nada encontrado para impressão');
        FGeral.fechaquery(Q);
        Sistema.EndProcess('');
        exit;
     end;
     Sistema.BeginProcess('Gerando Relatório');
     FRel.Init('RastreamentoVendas');
     FRel.AddTit('Rastreamento de Vendas - Período : '+FGeral.formatadata(EdDatai.asdate)+' a '+FGeral.formatadata(EdDAtaf.asdate));
     FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));
//      FRel.AddCol( 45,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
     FRel.AddCol( 40,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
     FRel.AddCol(150,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
     FRel.AddCol(150,1,'C','' ,''              ,'Produtor'        ,''         ,'',false);
     FRel.AddCol( 80,3,'N','' ,''              ,'Lote/Etiqueta'   ,''         ,'',false);
     FRel.AddCol( 55,1,'D','' ,''              ,'Data'            ,''         ,'',false);
     FRel.AddCol( 40,3,'N','+' ,''             ,'Peças'            ,''         ,'',false);
     FRel.AddCol( 70,3,'N','+' ,''             ,'Peso'            ,''         ,'',false);
     FRel.AddCol( 70,3,'N','+' ,f_cr             ,'Vlr Compra'      ,''         ,'',false);

     FRel.AddCol( 70,3,'N','+' ,''             ,'Peso Balança'     ,''         ,'',false);
     FRel.AddCol( 70,3,'N','+' ,f_cr            ,'Vlr Venda'         ,''         ,'',false);
     FRel.AddCol( 70,3,'N','&' ,f_cr            ,'Margem %'         ,''         ,'',false);

     while not Q.eof do begin

          ListaV:=TList.Create;
          FRel.AddCel(Q.FieldByName('movd_esto_codigo').AsString);
          FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
          FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade( Q.FieldByName('movd_tipo_codigo').AsInteger,'C','N' ) );
          FRel.AddCel(Q.FieldByName('movd_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('mova_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('movd_pecas').AsString);
          FRel.AddCel(Q.FieldByName('movd_pesocarcaca').AsString);
          FRel.AddCel(floattostr((Q.FieldByName('movd_pesocarcaca').AsCurrency/15)*Q.FieldByName('movd_vlrarroba').AsCurrency));
// primeiro pega os dois 'primeiro corte' - boi -> carcaça
        tam:=Length(Q.fieldbyname('movd_transacao').asstring+strzero(Q.fieldbyname('movd_ordem').asinteger,3));
        QCorte1:=sqltoquery('select * from movabatedet ' +
                           ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
//                           ' where substr(movd_operacao,1,'+inttostr(tam)+') = '+Stringtosql(Q.fieldbyname('movd_transacao').asstring+strzero(Q.fieldbyname('movd_ordem').asinteger,3))+
// 22.01.19  - para ficar menos demorado...
                           ' where movd_transacao = '+Stringtosql(Q.fieldbyname('movd_transacao').asstring) +
                           ' and movd_ordem = '+inttostr(Q.fieldbyname('movd_ordem').asinteger)+
                           ' and movd_status = ''N'''+
                           ' and movd_tipomov = '+Stringtosql(xtipomov)+
                           ' and movd_unid_codigo = '+Stringtosql(Q.fieldbyname('movd_unid_codigo').asstring) );
        while not QCorte1.eof do begin

//            IncluiVenda(Q.FieldByName('movd_operacao').AsString,QCorte1.FieldByName('movd_pesocarcaca').Ascurrency);
//
// 05.04.18
                GetPedido(QCorte1.FieldByName('movd_operacao').AsString);
                if not QVenda1.Eof then
                   IncluiVenda(Q.FieldByName('movd_operacao').AsString,
                              QCorte1.FieldByName('movd_pesobalanca').AsCurrency,
                              (QVenda1.fieldbyname('movd_vlrarroba').AsCurrency)*QCorte1.FieldByName('movd_pesobalanca').AsCurrency);

                FGeral.FechaQuery(QVenda1);

            QCorte2:=sqltoquery('select * from movabatedet ' +
                           ' inner join movabate on ( mova_transacao=movd_transacao )'+
                           ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                           ' where mova_transacaogerada = '+Stringtosql(QCorte1.fieldbyname('movd_operacao').asstring)+
                           ' and movd_status = ''N'''+
                           ' and movd_tipomov = '+Stringtosql(xtipomov)+
                           ' and movd_unid_codigo = '+Stringtosql(QCorte1.fieldbyname('movd_unid_codigo').asstring) );
            while not Qcorte2.Eof do begin

//              IncluiVenda(Q.FieldByName('movd_operacao').AsString,QCorte2.FieldByName('movd_pesocarcaca').Ascurrency);
// nao inclui corte 2 pois é o peso da entrada dividido por 2
// 05.04.18
                GetPedido(QCorte2.FieldByName('movd_operacao').AsString);
                if not QVenda1.Eof then
                   IncluiVenda(Q.FieldByName('movd_operacao').AsString,
                              QCorte2.FieldByName('movd_pesobalanca').AsCurrency,
                              (QVenda1.fieldbyname('movd_vlrarroba').AsCurrency)*QCorte2.FieldByName('movd_pesobalanca').AsCurrency);

                FGeral.FechaQuery(QVenda1);

              QCorte3:=sqltoquery('select * from movabatedet ' +
                           ' inner join movabate on ( mova_transacao=movd_transacao )'+
                           ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                           ' where mova_transacaogerada = '+Stringtosql(QCorte2.fieldbyname('movd_operacao').asstring)+
                           ' and movd_status = ''N'''+
                           ' and movd_tipomov = '+Stringtosql(xtipomov)+
                           ' and movd_unid_codigo = '+Stringtosql(QCorte2.fieldbyname('movd_unid_codigo').asstring) );

              while not Qcorte3.Eof do begin

                GetPedido(QCorte3.FieldByName('movd_operacao').AsString);

                if not QVenda1.Eof then
                   IncluiVenda(Q.FieldByName('movd_operacao').AsString,
                              QCorte3.FieldByName('movd_pesobalanca').AsCurrency,
                              (QVenda1.fieldbyname('movd_vlrarroba').AsCurrency)*QCorte3.FieldByName('movd_pesobalanca').AsCurrency);


                FGeral.FechaQuery(QVenda1);
                QCorte4:=sqltoquery('select * from movabatedet ' +
                             ' inner join movabate on ( mova_transacao=movd_transacao )'+
                             ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                             ' where mova_transacaogerada = '+Stringtosql(QCorte3.fieldbyname('movd_operacao').asstring)+
                             ' and movd_status = ''N'''+
                             ' and movd_tipomov = '+Stringtosql(xtipomov)+
                             ' and movd_unid_codigo = '+Stringtosql(QCorte3.fieldbyname('movd_unid_codigo').asstring) );

                while not Qcorte4.Eof do begin

                  GetPedido(QCorte4.FieldByName('movd_operacao').AsString);
                  if not QVenda1.Eof then
                     IncluiVenda(Q.FieldByName('movd_operacao').AsString,
                               QCorte4.FieldByName('movd_pesobalanca').AsCurrency,
                               (QVenda1.fieldbyname('movd_vlrarroba').AsCurrency)*QCorte4.FieldByName('movd_pesobalanca').AsCurrency);


                  FGeral.FechaQuery(QVenda1);
                  QCorte4.Next;
                end;
                FGeral.FechaQuery(QCorte4);

                QCorte3.Next;

              end;
              FGeral.FechaQuery(QCorte3);

              QCorte2.Next;
            end;
            FGeral.FechaQuery(QCorte2);
 //
            QCorte1.Next;
        end;
        FGeral.FechaQuery(QCorte1);
        if ListaV.Count>0  then begin
          PVendas:=Listav[0];
          FRel.AddCel( floattostr( PVendas.peso ) );
          FRel.AddCel( floattostr( PVendas.valor ) );
          if PVendas.valor>0 then
             Margem:=( 1 -  ( (Q.FieldByName('movd_pesocarcaca').AsCurrency/15)*Q.FieldByName('movd_vlrarroba').AsCurrency  )/PVendas.valor )*100
          else
             Margem:=0;
          FRel.AddCel( floattostr( Margem ) );
        end else begin
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
        end;

        ListaV.Free;

        Q.Next;


     end;
     FRel.Video;
     Q.close;
     Sistema.EndProcess('');
  end;
  FRelEstoque_RastreamentoVendas;

end;


// 20.03.18
procedure FRelEstoque_ExtratoCamarafria;   // 22
/////////////////////////////////////////////
var TiposMov,sqlinicio,sqltermino,campo,transacoes,
    numerosdoc,
    sqlproduto   :String;
    Listat,ListaN:TStringList;

    function DataValida:boolean;
    //////////////////////////
    begin
      result:=true;
      if Datetoano( Q.fieldbyname( campo ).asDatetime,true ) > 1901 then begin
        if ( Q.fieldbyname( campo ).asdatetime < FRelEstoque.EdDatai.asdate )
           or
           ( Q.fieldbyname( campo ).asdatetime > FRelEstoque.EdDataf.asdate ) then
           result:=false;

      end;

    end;

begin

  with FRelEstoque do begin

    if not FRelEstoque_Execute(22) then Exit;
    Sistema.BeginProcess('Pesquisando movimento');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);
    campo:='mova_dtabate';
    if EdEsto_codigo.AsInteger>0 then
       sqlinicio:=' and '+campo+' >= '+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
    else
       sqlinicio:=' and '+campo+' >= '+Datetosql(EdDatai.AsDate);

    if EdDAtaf.isempty then
       sqltermino:=''
    else
       sqltermino:=' and '+campo+' <= '+Datetosql(EdDataf.Asdate);
    if EdDAtai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;
//    TiposMov:='EA;'+Global.CodDesossaEnt+';'+'SA'+';DE;DS;EC;ER';
// 22.05.20 - colocado tipo PC
// 17.06.20 - colocado tipo DG e DS
    TiposMov:='EA;'+Global.CodDesossaEnt+';'+'SA'+';DE;DS;EC;ER;PC;DH;DG';
    transacoes:='';
    numerosdoc:='';
    sqltipomovto:=' and '+FGeral.GetIn('mova_tipomov',TiposMov,'C');
    sqlproduto:='';
    if not EdEsto_codigo.IsEmpty then sqlproduto:=' and movd_esto_codigo = '+EdEsto_codigo.AsSql;

    Q:=sqltoquery('select mova_transacao,mova_numerodoc from movabate '+
//                     ' where '+FGeral.RelEstoque('mova_status')+
// 11.11.20 - Novicarnes - Vanderlei
                     ' where mova_status <> ''C'''+
                     ' and '+FGeral.Getin('mova_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+
                     sqltipomovto+
                     ' order by mova_dtabate' );
    if Q.eof then begin
        Sistema.EndProcess('Nada encontrado para impressão');
        exit;
    end;
    Listat:=TStringList.Create;
    Listan:=TStringList.Create;
    while not Q.Eof do begin

      if ListaT.indexof(Q.fieldbyname('mova_transacao').assTring)=-1 then begin
        ListaT.Add(Q.fieldbyname('mova_transacao').assTring);
        transacoes:=transacoes+Q.fieldbyname('mova_transacao').assTring+';';
      end;
      if ListaN.indexof(Q.fieldbyname('mova_numerodoc').assTring)=-1 then begin
        ListaN.Add(Q.fieldbyname('mova_numerodoc').assTring);
        Numerosdoc:=Numerosdoc+Q.fieldbyname('mova_numerodoc').assTring+';';
      end;
      Q.Next;

    end;
    Q.Close;
    Listat.Free;
    Q:=sqltoquery('select movabatedet.*,mova_dtabate,esto_descricao,esto_grup_codigo from movabatedet '+
// 24.11.20
                     ' inner join movabate on ( mova_transacao=movd_transacao and movd_tipomov=mova_tipomov)'+
                     ' inner join estoque on (esto_codigo=movd_esto_codigo) '+
//                     ' where '+FGeral.RelEstoque('movd_status')+
// 11.11.20 - Novicarnes - Vanderlei
                     ' where movd_status <> ''C'''+
                     ' and '+FGeral.Getin('movd_unid_codigo',EdUnid_codigo.text,'C')+
                     ' and '+FGeral.GetIN('movd_transacao',transacoes,'C')+
                     ' and '+FGeral.GetIN('movd_numerodoc',numerosdoc,'C')+
                     sqlproduto+
                     ' order by movd_datamvto,movd_tipomov,movd_ordem' );

      unidade:=copy(FRelEstoque.EdUNid_codigo.Text,1,3);

//      campo:='movd_datamvto';
// 24.11.20
      campo:='mova_dtabate';

      FRel.Init('ExtratoCamarafria');
      FRel.AddTit('Extrato de Movimentação na Camara Fria do Produto - Período : '+FGeral.formatadata(EdDatai.asdate)+' a '+FGeral.formatadata(EdDAtaf.asdate));
      FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));

      if not EdEsto_codigo.isempty then begin
        FRel.AddTit(EdEsto_codigo.Text+' - '+FEstoque.GetDescricao(EdEsto_codigo.text));
      end;

      FRel.AddCol( 70,3,'N','' ,''              ,'Produto'         ,''         ,'',false);
      FRel.AddCol(170,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
      FRel.AddCol(120,1,'C','' ,''              ,'Grupo'       ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Data'            ,''         ,'',false);
      FRel.AddCol( 60,3,'N','' ,''              ,'Lote/Pedido'          ,''         ,'',false);
      FRel.AddCol( 80,3,'N','' ,''              ,'Etiqueta'          ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Tipomov'         ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque    ,'Entradas'         ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque    ,'Saidas'           ,''         ,'',false);
//      FRel.AddCol( 60,3,'N','' ,f_qtdestoque    ,'Saldo'           ,''         ,'',false);
//      FRel.AddCol(100,1,'C','' ,''              ,'Transação'       ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque  ,'Ent Pec'         ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque  ,'Sai Pec'          ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque  ,'Ven Sai'         ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque  ,'Ven Pec'          ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+' ,f_qtdestoque ,'Caixas'           ,''         ,'',false);

    while not Q.eof do begin

       if DataValida then begin

         FRel.addcel( Q.fieldbyname('movd_esto_codigo').asstring );
         FRel.addcel( Q.fieldbyname('esto_descricao').asstring );
         FRel.addcel( FGrupos.GetDescricao( Q.fieldbyname('esto_grup_codigo').asinteger ));
         FRel.addcel( Q.fieldbyname( campo ).asstring );
         FRel.addcel( Q.fieldbyname('movd_numerodoc').asstring );
         if Ansipos(  Q.fieldbyname('movd_tipomov').asstring,'EA' )>0 then
           FRel.AddCel('')
         else
           FRel.addcel( Q.fieldbyname('movd_operacao').asstring );
         FRel.addcel( Q.fieldbyname('movd_tipomov').asstring );

         if Ansipos(  Q.fieldbyname('movd_tipomov').asstring,'EA;DE;EC;ER;PC' )>0 then begin
           FRel.addcel( Q.fieldbyname('movd_pesocarcaca').asstring );
           FRel.addcel('');
         end else if Ansipos( Q.fieldbyname('movd_tipomov').asstring,'SA;DS') > 0 then begin
           FRel.addcel('');
           FRel.addcel( Q.fieldbyname('movd_pesocarcaca').asstring );
         end else begin
           FRel.addcel('');
           FRel.addcel('');
         end;
         if Ansipos(  Q.fieldbyname('movd_tipomov').asstring,'EA;DE;ER;EC;PC' ) > 0 then begin
           FRel.addcel( Q.fieldbyname('movd_pecas').asstring );
           FRel.addcel('');
         end else if AnsiPos( Q.fieldbyname('movd_tipomov').asstring,'SA;DS' ) = 0 then begin
           FRel.addcel('');
           FRel.addcel( Q.fieldbyname('movd_pecas').asstring );
         end else begin
           FRel.addcel('');
           FRel.addcel('');
         end;
         if AnsiPos( Q.fieldbyname('movd_tipomov').asstring,'SA;DS') = 0 then begin
           FRel.addcel('');
           FRel.addcel('');
         end else begin
           FRel.addcel( Q.fieldbyname('movd_pesocarcaca').asstring );
           FRel.addcel( Q.fieldbyname('movd_pecas').asstring );
         end;
         FRel.addcel('1');

       end;

       Q.Next;

    end;

    FRel.Video;
    Q.close;
    Sistema.EndProcess('');

  end;

  FRelEstoque_ExtratoCamarafria;

end;


// 16.11.20
procedure FRelEstoque_EstoqueCamarafria;   // 23
/////////////////////////////////////////////
///
type Estoque = record
     codigo,
     tipomov : string;
     entradas,
     saidas  : currency;
end;

var TiposMov,sqlinicio,sqltermino,campo,transacoes,
    numerosdoc,
    sqlproduto,
    tiposSaida   :String;
    Listat,ListaN:TStringList;
    ListaE       :TList;
    PEstoque     :^Estoque;
    p            :integer;
    achou        :boolean;


    function DataValida:boolean;
    //////////////////////////
    begin
      result:=true;
      if Datetoano( Q.fieldbyname( campo ).asDatetime,true ) > 1901 then begin
        if ( Q.fieldbyname( campo ).asdatetime < FRelEstoque.EdDatai.asdate )
           or
           ( Q.fieldbyname( campo ).asdatetime > FRelEstoque.EdDataf.asdate ) then
           result:=false;

      end;

    end;

begin

  with FRelEstoque do begin

    if not FRelEstoque_Execute(23) then Exit;
    Sistema.BeginProcess('Pesquisando movimento');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);
    campo:='mova_dtabate';
    if EdEsto_codigo.AsInteger>0 then
       sqlinicio:=' and '+campo+' >= '+Datetosql(DatetoPrimeiroDiames(EdDatai.AsDate))
    else
       sqlinicio:=' and '+campo+' >= '+Datetosql(EdDatai.AsDate);

    if EdDAtaf.isempty then
       sqltermino:=''
    else
       sqltermino:=' and '+campo+' <= '+Datetosql(EdDataf.Asdate);
    if EdDAtai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;
    TiposMov:='EA;'+Global.CodDesossaEnt+';'+'DE;DS;EC;ER;PC;DH;DG;SA';
    TiposSaida := 'DS;PC;SA';
    transacoes:='';
    numerosdoc:='';
    sqltipomovto:=' and '+FGeral.GetIn('mova_tipomov',TiposMov,'C');
    sqlproduto:='';
    if not EdEsto_codigo.IsEmpty then sqlproduto:=' and movd_esto_codigo = '+EdEsto_codigo.AsSql;

    Q:=sqltoquery('select mova_transacao,mova_numerodoc from movabate '+
//                     ' where '+FGeral.RelEstoque('mova_status')+
// 11.11.20 - Novicarnes - Vanderlei
                     ' where mova_status <> ''C'''+
                     ' and '+FGeral.Getin('mova_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+
                     sqltipomovto+
                     ' order by mova_dtabate' );
    if Q.eof then begin
        Sistema.EndProcess('Nada encontrado para impressão');
        exit;
    end;

    Listat:=TStringList.Create;
    Listan:=TStringList.Create;

    while not Q.Eof do begin

      if ListaT.indexof(Q.fieldbyname('mova_transacao').assTring)=-1 then begin
        ListaT.Add(Q.fieldbyname('mova_transacao').assTring);
        transacoes:=transacoes+Q.fieldbyname('mova_transacao').assTring+';';
      end;
      if ListaN.indexof(Q.fieldbyname('mova_numerodoc').assTring)=-1 then begin
        ListaN.Add(Q.fieldbyname('mova_numerodoc').assTring);
        Numerosdoc:=Numerosdoc+Q.fieldbyname('mova_numerodoc').assTring+';';
      end;
      Q.Next;

    end;

    Q.Close;
    Listat.Free;
    Q:=sqltoquery('select movd_esto_codigo,movd_tipomov,sum(movd_pesocarcaca) as movd_pesocarcaca from movabatedet '+
                     ' inner join estoque on (esto_codigo=movd_esto_codigo) '+
//                     ' where '+FGeral.RelEstoque('movd_status')+
// 11.11.20 - Novicarnes - Vanderlei
                     ' where movd_status <> ''C'''+
                     ' and '+FGeral.Getin('movd_unid_codigo',EdUnid_codigo.text,'C')+
                     ' and '+FGeral.GetIN('movd_transacao',transacoes,'C')+
                     ' and '+FGeral.GetIN('movd_numerodoc',numerosdoc,'C')+
                     sqlproduto+
                     ' group  by movd_esto_codigo,movd_tipomov' );

      unidade:=copy(FRelEstoque.EdUNid_codigo.Text,1,3);
      campo:='movd_datamvto';
      FRel.Init('EstoqueCamarafria');
      FRel.AddTit('Posição de Estoque na Camara Fria - Período : '+FGeral.formatadata(EdDatai.asdate)+' a '+FGeral.formatadata(EdDAtaf.asdate));
      FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));

      if not EdEsto_codigo.isempty then begin
        FRel.AddTit(EdEsto_codigo.Text+' - '+FEstoque.GetDescricao(EdEsto_codigo.text));
      end;

      FRel.AddCol( 70,3,'N','' ,''              ,'Produto'         ,''         ,'',false);
      FRel.AddCol(170,1,'C','' ,''              ,'Descrição'       ,''         ,'',false);
      FRel.AddCol(120,1,'C','' ,''              ,'Grupo'       ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque    ,'Entradas'         ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+',f_qtdestoque    ,'Saidas'           ,''         ,'',false);
  //    FRel.AddCol( 60,3,'N','+',f_qtdestoque  ,'Ent Pec'         ,''         ,'',false);
  //    FRel.AddCol( 60,3,'N','+',f_qtdestoque  ,'Sai Pec'          ,''         ,'',false);
      FRel.AddCol( 60,3,'N','' ,f_qtdestoque    ,'Saldo'           ,''         ,'',false);
//      FRel.AddCol( 60,3,'N','+',f_qtdestoque  ,'Ven Sai'         ,''         ,'',false);
//      FRel.AddCol( 60,3,'N','+',f_qtdestoque  ,'Ven Pec'          ,''         ,'',false);
 //     FRel.AddCol( 60,3,'N','+' ,f_qtdestoque ,'Caixas'           ,''         ,'',false);

// totalizacao...
    ListaE := TList.create;

    while not Q.eof do begin


          achou := false;
          for p := 0 to ListaE.count-1 do begin

              PEstoque := ListaE[p] ;

              if Q.fieldbyname('movd_esto_codigo').asstring = PEstoque.codigo then begin

                 achou := true;
                 break;

              end;

          end;
          if not achou then begin

             New(PEstoque);
             PEstoque.codigo  := Q.fieldbyname('movd_esto_codigo').asstring;
             PEstoque.tipomov := Q.fieldbyname('movd_tipomov').asstring;
             if Ansipos( Q.fieldbyname('movd_tipomov').asstring,TiposSaida ) > 0  then begin

                PEstoque.Saidas   := Q.fieldbyname('movd_pesocarcaca').ascurrency;
                PEstoque.entradas := 0;

             end else begin

                PEstoque.saidas    := 0;
                PEstoque.entradas  := Q.fieldbyname('movd_pesocarcaca').ascurrency;

             end;
             ListaE.add(Pestoque);

          end else begin

             if Ansipos( Q.fieldbyname('movd_tipomov').asstring,TiposSaida ) > 0  then begin

                PEstoque.Saidas  :=  PEstoque.Saidas +  Q.fieldbyname('movd_pesocarcaca').ascurrency;

             end else begin

                PEstoque.entradas := PEstoque.entradas  + Q.fieldbyname('movd_pesocarcaca').ascurrency;

             end;

          end;


       Q.Next;

    end;

// impressao
    for p := 0 to ListaE.count-1 do begin

        PEstoque := ListaE[p];

        FRel.addcel( PEstoque.codigo );
        FRel.addcel(  FEstoque.GetDescricao(PEstoque.codigo) );
        FRel.addcel( FGrupos.GetDescricao( FEstoque.GetGrupo(PEstoque.codigo) ));
//         FRel.addcel( Q.fieldbyname( campo ).asstring );

        FRel.addcel( FGeral.formataValor( PEstoque.entradas,f_cr) );
        FRel.addcel( FGeral.formataValor( PEstoque.saidas,f_cr) );
        FRel.addcel( FGeral.formataValor( PEstoque.entradas - PEstoque.saidas,f_cr) );

    end;

    FRel.Video;
    Q.close;
    Sistema.EndProcess('');

  end;

  FRelEstoque_EstoqueCamarafria;

end;


// 10.02.2023
procedure FRelEstoque_TributacaoNcm;       // 25
//////////////////////////////////////////////
var unidade : string;
    Q       : TSqlquery;
begin

  with FRelEstoque do begin

    if not FRelEstoque_Execute(25) then Exit;
    Q := sqltoquery('select * from codigosipi order by cipi_codfiscal');
    Sistema.BeginProcess('Pesquisando movimento');
    unidade:=copy(FRelEstoque.EdUnid_codigo.Text,1,3);

      FRel.Init('RelTributacaoNcm');
      FRel.AddTit('Tributação pelo NCM ');
//      FRel.AddTit(FGeral.TituloRelUnidade(FRelEstoque.EdUnid_codigo.Text));

      FRel.AddCol(070,1,'C','' ,''              ,'Unidade'       ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'NCM'       ,''         ,'',false);
      FRel.AddCol( 60,3,'N','' ,''              ,'% Icms Est. '          ,''         ,'',false);
      FRel.AddCol(070,1,'C','' ,''              ,'CFOP Est.'       ,''         ,'',false);
      FRel.AddCol(080,1,'C','' ,''              ,'CST Est.'       ,''         ,'',false);
      FRel.AddCol( 80,3,'N','' ,''              ,'% Icms F.Est. '          ,''         ,'',false);
      FRel.AddCol(090,1,'C','' ,''              ,'CFOP F.Est.'       ,''         ,'',false);
      FRel.AddCol(090,1,'C','' ,''              ,'CST F.Est.'       ,''         ,'',false);

    while not Q.eof do begin

         FRel.addcel( Q.fieldbyname('cipi_unid1_codigo').asstring );
         FRel.addcel( Q.fieldbyname('cipi_codfiscal').asstring );
         FRel.addcel( Q.fieldbyname('cipi_aliicmsu1_est').asstring );
         FRel.addcel( Q.fieldbyname('cipi_cfopu1_est').asstring );
         FRel.addcel( Q.fieldbyname('cipi_cstu1_est').asstring );
         FRel.addcel( Q.fieldbyname('cipi_aliicmsu1_fest').asstring );
         FRel.addcel( Q.fieldbyname('cipi_cfopu1_fest').asstring );
         FRel.addcel( Q.fieldbyname('cipi_cstu1_fest').asstring );
       Q.Next;

    end;

    FRel.Video;
    Q.close;
    Sistema.EndProcess('');

  end;

end;


end.

