unit relfinan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid, ComObj;

type
  TFRelFinan = class(TForm)
    PRel: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    baplicar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    EdLancai: TSQLEd;
    EdLancaf: TSQLEd;
    EdBaixai: TSQLEd;
    EdBaixaf: TSQLEd;
    EdVencimentoi: TSQLEd;
    EdVencimentof: TSQLEd;
    EdDtposicao: TSQLEd;
    EdCodtipo: TSQLEd;
    EdTipocad: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdDtemissao: TSQLEd;
    EdTipomov: TSQLEd;
    Edemissaoini: TSQLEd;
    EdEmissaofim: TSQLEd;
    EdTiposmov: TSQLEd;
    EdMesano: TSQLEd;
    Edmesanoorcado: TSQLEd;
    EdAtivos: TSQLEd;
    EdVencimento: TSQLEd;
    EdPlan_conta: TSQLEd;
    EdPlan_descricao: TSQLEd;
    EdSorateio: TSQLEd;
    EdNumeroDocf: TSQLEd;
    EdCompete: TSQLEd;
    EdMesanofinal: TSQLEd;
    EdSeto_codigo: TSQLEd;
    EdSeto_descricao: TSQLEd;
    EdNomeRel: TSQLEd;
    EdMesanof: TSQLEd;
    EdMesanofinal1: TSQLEd;
    EdMesanof01: TSQLEd;
    EdMesanofinal02: TSQLEd;
    EdCida_codigo: TSQLEd;
    SetEdcida_nome: TSQLEd;
    EdVendaCompra: TSQLEd;
    EdEsto_codigo: TSQLEd;
    SetEdFUNC_NOME: TSQLEd;
    EdEqui_codigo: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    Edcodigoscli: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure baplicarClick(Sender: TObject);
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure EdTipocadValidate(Sender: TObject);
    procedure EdCodtipoValidate(Sender: TObject);
    procedure EdLancaiValidate(Sender: TObject);
    procedure EdLancafExitEdit(Sender: TObject);
    procedure EdTipomovExitEdit(Sender: TObject);
    procedure EdLancafValidate(Sender: TObject);
    procedure EdDtemissaoValidate(Sender: TObject);
    procedure EdVencimentoValidate(Sender: TObject);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure EdMesanoValidate(Sender: TObject);
  private
    { Private declarations }
    SaiOk:Boolean;
  public
    { Public declarations }
    function  GetPerComissao(xtransacao:string):currency;
    function  GetPerComissao2(xtransacao:string):currency;
    function  BuscaCodigoUsuario( xtransacao:String ):integer;
    function  GetEquipamento( xtransacao:string ):string;
// 05.11.19
    function GetSaldos( xconta:integer ):currency;
// 29.04.20
    function GetUltimaKM(xTran_codigo:string; xcarga:integer ; xdatacarga:TDatetime):integer;
// 27.09.2021
    function  GetEquipamentos( xtransacao,codequi:string ):boolean;
// 24.06.2022
    function  GetTransEquipamentoBP(xnumerodcto,xunidade,xrp: string ; xtipo_codigo,xplan_conta:integer ):string;
// 03.03.2023
    function  GetValorEquipamentos( xtransacao,codequi:string; valor:currency ):currency;

  end;

var
  FRelFinan: TFRelFinan;
  largura,margem:integer;
  sqlunidade,sqldatalan,sqldatabai,sqldatavenci,sqldatacont,devolucoes,sqlperiodoemissao,
  sqlportadorcartao,
  sqldoc    :string;
  qrel      :integer;

procedure FRelFinan_Pendencias(RecPag,Rel:string;Tp:integer;ycodigo:integer=0);  // 0
procedure FRelFinan_Incluidas(RecPag:string);     // 1
procedure FRelFinan_Pendentes(RecPag:string;xcodigo:integer=0);     // 2
procedure FRelFinan_Baixadas(RecPag:string);     // 3
procedure FRelFinan_Posicao(RecPag:string);     // 4
procedure FRelFinan_ImpNfsaida;      // 5
procedure FRelFinan_ImpNfTransf;     // 6
procedure FRelFinan_Faturamento;     // 7
procedure FRelFinan_ImpRomaneio;     // 8
procedure FRelFinan_ImpNFDevolucao;  // 9
procedure FRelFinan_Antecipacoes;  // 10
procedure FRelFinan_Compras;        // 11
procedure FRelFinan_PendentesRepre;     // 12
procedure FRelFinan_ResumoAberto(RecPag:string);     // 13
procedure FRelFinan_AtendePrePedidos;     // 14
procedure FRelFinan_RelacaoPrePedidos;     // 15
procedure FRelFinan_ImpBloqueto;      // 16
procedure FRelFinan_Orcamento;    //17
procedure FRelFinan_PosicaoCheques(RecPag:string);     // 18
procedure FRelFinan_Comissao;       // 19
procedure FRelFinan_SaldoaEntregar;       // 20
// 16.09.10
procedure FRelFinan_InssNfProdutor;        // 21
// 12.09.11
procedure FRelFinan_DRE(nomerel:string='');        // 22
// 18.11.15
procedure FRelFinan_DepositoemConta(DtInicio,DtFim:TDatetime);        // 23
// 19.11.15
procedure FRelFinan_PedidosFaturados;     // 24
// 14.08.17
procedure FRelFinan_Carregados;     // 25
// 02.10.18
procedure FRelFinan_ImpostosRetidosNFServicos;        // 26
// 15.07.19
procedure  FRelFinan_PorSetor;   // 27
// 16.08.19
procedure  FRelFinan_InformeIRProdutor;   // 28
// 29.04.20
procedure FRelFinan_CargasKM;     // 29
// 23.07.20
procedure FRelFinan_PosicaoApro;  // 30

implementation

uses Geral, SQLRel, Unidades, SqlExpr, SqlSis, SqlFun, conpagto, portador,
  impressao, cadcli, Hist, Usuarios, fornece, represen, plano, Transp,
  munic, ConfMovi, Estoque, setores, equipamentos, ConfDcto, visualizaimp, TextRel,
  colaboradores;

{$R *.dfm}
//////////////////////////////////////////////////////////////////////////////////////
function FRelFinan_Execute(Tp:Integer;RecPag:string='';NomeRel:string='';ycodigo:integer=0):Boolean;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
var tit1:string;
    Q:TSqlquery;
  campo:TDicionario;
begin
/////////////
  if FRelFinan=nil then FGeral.CreateForm(TFRelFinan, FRelFinan);
  qrel:=tp;
  result:=true;
  devolucoes:=Global.CodDevolucaoVenda+';'+Global.CodDevolucaoRoman+';'+Global.CodDevolucaoSerie5+';'+
              Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoVendaConsig+';'+Global.CodDevolucaoSimbolicaConsig;
//  FGeral.SetaItemsMovimento(FRelFinan.EdTiposmov);
// 11.08.08
  FConfMovimento.SetaItemsMovimento(FRelFinan.EdTiposmov);
// 23.11.16
  FGeral.ConfiguraColorEditsNaoEnabled(FRelFinan);
// 23.10.12 - Vivan - para não imprimir contas a receber ref. recebimento com cartão de credito
  sqlportadorcartao:='';
  if trim( FGeral.GetConfig1AsString('Portadorcartao') )<>'' then
    sqlportadorcartao:=' and '+FGeral.GetNOTIN('pend_port_codigo',FGeral.GetConfig1AsString('Portadorcartao'),'C');

  with FRelFinan do begin

    EdNomerel.enabled:=(tp=22);
    FGeral.SetaTipoCad(EdTipocad);
// 12.09.11
    campo:=Sistema.GetDicionario('relgerencial','relg_status');
    EdNomerel.Items.Clear;
    if nomerel<>'' then EdNOmerel.text:=nomerel;
    if campo.Tipo<>'' then begin
      Q:=sqltoquery('select distinct Relg_NomeRel from relgerencial where Relg_Unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                 ' and relg_status=''N''');
      while not Q.eof do begin
        EdNomerel.Items.Add(Q.fieldbyname('relg_nomerel').asstring);
        q.Next;
      end;
      FGeral.FechaQuery(Q);
    end else
        EdNomerel.enabled:=false;
    EdCida_codigo.enabled:=false;
    if Recpag='R' then
      tit1:='Relatório de Recebimentos - '
    else
      tit1:='Relatório de Pagamentos - ';
    if tp>5 then
      tit1:='';
    FUnidades.SetaItems(EdUnid_codigo,nil,Global.Usuario.UnidadesRelatorios);
//    FGeral.SetaItemsMovimento(EdTipomov);
    sqlunidade:='';
    sqldatalan:='';
    sqldatabai:='';
    sqldatavenci:='';
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and pend_datacont > 1';
// 26.04.10
      sqldatacont:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco);
    EdDtposicao.enabled:=false;
    if EdDtposicao.isempty then
      EdDtposicao.setdate(sistema.hoje);
    EdBaixai.enabled:=false;
    EdBaixaf.enabled:=false;
    EdLancai.enabled:=false;
    EdLancaf.enabled:=false;
    EdVencimentoi.enabled:=false;
    EdVencimentof.enabled:=false;
// 11.08.08
    EdVencimento.enabled:=tp=16;
// 16.03.18
    EdVendaCompra.Enabled:=false;
    EdEsto_codigo.Enabled:=false;
// 28.06.19
    EdEqui_codigo.Enabled:=false;
    EdCodigoscli.Enabled :=false;

    if tp=1 then begin

      Caption:=tit1+'Incluídas';
// 02.06.20  - A2z - thais
      EdEqui_codigo.Enabled:=( global.topicos[1367] );

    end else if tp=2 then  begin
      Caption:=tit1+'Pendentes';
      if RecPag='R' then
          EdCida_codigo.enabled:=true;
// 15.08.19  - A2z - thais
      EdEqui_codigo.Enabled:=( global.topicos[1367] );

    end else if tp=3 then begin

      Caption:=tit1+'Baixadas';
      EdVencimentoi.enabled:=true;
      EdVencimentof.enabled:=true;
// 07.06.21  - A2z - thais
      EdEqui_codigo.Enabled:=( global.topicos[1367] );

    end else if tp=4 then
      Caption:=tit1+'Posição Financeira'
    else if tp=5 then
      Caption:='Impressão de Nota de Saida'
    else if tp=6 then
      Caption:='Impressão de Nota de Transferência'
    else if tp=7 then begin

      Caption:='Relação do Faturamento';
// 02.07.19
      EdEqui_codigo.Enabled:=( global.topicos[1367] );

    end else if tp=8 then
      Caption:='Impressão de Romaneio de Retorno'
    else if tp=9 then
      Caption:='Impressão de Devolução Romaneio/Consig.'
    else if tp=10 then
      Caption:='Antecipações'
    else if tp=11 then begin

      Caption:='Compras';
// 28.06.19
      EdEqui_codigo.Enabled:=( global.topicos[1367] );

    end else if tp=12 then
      Caption:='Pendencias para Representantes'
    else if tp=13 then
      Caption:='Resumo Vencidos/A Vencer por Representantes'
    else if tp=14 then
      Caption:='Atendimento Pré-Pedidos'
    else if tp=15 then
      Caption:='Relação de Pré-Pedidos'
    else if tp=16 then
      Caption:='Impressão Duplicata de Cobrança'
    else if tp=17 then
      Caption:='Controle Orçamentário'
    else if tp=18 then
      Caption:='Posição Cheques'
    else if tp=19 then begin

      Caption:='Comissão sobre Recebimentos';
// 28.04.20 - Novicarnes - Isonel
      EdLancai.enabled:=true;
      EdLancaf.enabled:=true;

    end else if tp=20 then begin
      Caption:='Saldo a Entregar ';
      EdVendaCompra.Enabled:=true;
      EdEsto_codigo.Enabled:=true;
    end else if tp=21 then
      Caption:='Inss Nota Produtor '
    else if tp=22 then
      Caption:='DRE Gerencial '
    else if tp=23 then
      Caption:='Depósito em Conta'
    else if tp=24 then
      Caption:='Pedidos Faturados'
    else if tp=25 then
      Caption:='Produtos Carregados'
    else if tp=26 then
      Caption:='Impostos Retidos NF Serviços'
    else if tp=27 then begin
      Caption:='Notas por Setor';
      EdLancai.enabled:=true;
// 20.08.19
    end else if tp=28 then begin

      Caption:='Informe para IR Produtor';
      EdCodtipo.enabled:=true;
      EdTipocad.enabled:=true;
      EdCodigoscli.Enabled:=true;
      FCadcli.setaedit( Edcodigoscli,'clie_ativo','S');
// 29.04.20
    end else if tp=29 then begin

      Caption:='Comissão Motoristas';
//      EdCodtipo.enabled:=true;
//      EdTipocad.enabled:=true;
//      EdTipoCad.Text   :='T';
      EdLancai.enabled:=true;
      EdLancaf.enabled:=true;
      EdBaixai.text:='';
      EdBaixaf.text:='';
      EdVencimentoi.text:='';
      EdVencimentof.text:='';

//      EdCodigoscli.Enabled:=true;
//      FCadcli.setaedit( Edcodigoscli,'clie_ativo','S');
// 23.07.20
    end else if tp=30 then begin

      Caption:='Posição Apropriações';
//      EdCodtipo.enabled:=true;
//      EdTipocad.enabled:=true;
//      EdTipoCad.Text   :='T';
//      EdLancai.enabled:=true;
//      EdLancaf.enabled:=true;
      EdBaixai.text:='';
      EdBaixaf.text:='';
      EdVencimentoi.text:='';
      EdVencimentof.text:='';
      EdDtPosicao.enabled := true;

//      EdCodigoscli.Enabled:=true;
//      FCadcli.setaedit( Edcodigoscli,'clie_ativo','S');

    end;

// 22.10.07
    Edemissaoini.enabled:=false;
    Edemissaofim.enabled:=false;
    EdPlan_Conta.enabled:=false;
//    EdPlan_conta.text:='';
    EdSoRateio.enabled:=false;
    if (tp=1) or (tp=25)  then begin
      EdLancai.enabled:=true;
      EdLancaf.enabled:=true;
      EdBaixai.text:='';
      EdBaixaf.text:='';
      EdVencimentoi.text:='';
      EdVencimentof.text:='';
      if tp<>25 then begin
        Edemissaoini.enabled:=true;
        Edemissaofim.enabled:=true;
// 10.03.09
        EdPlan_Conta.enabled:=true;
      end;

    end else if tp=2 then begin

      EdLancai.enabled:=false;
      EdLancaf.enabled:=false;
      EdLancai.text:='';
      Edlancaf.text:='';
      EdBaixai.text:='';
      EdBaixaf.text:='';
      EdVencimentoi.enabled:=true;
      EdVencimentof.enabled:=true;
// 10.03.09
      EdPlan_Conta.enabled:=true;
// 27.07.09
      Edemissaoini.enabled:=true;
      Edemissaofim.enabled:=true;

    end else if tp=3 then begin

      EdLancai.text:='';
      Edlancaf.text:='';
      EdBaixai.enabled:=true;
      EdBaixaf.enabled:=true;
      EdVencimentoi.text:='';
      EdVencimentof.text:='';
// 07.05.10
      Edemissaoini.text:='';
      Edemissaofim.text:='';
// 21.11.19 - Alutech - Robson
      if RecPag='P'then
         EdPlan_conta.Enabled:=true;

    end else if (tp=4) or (tp=13) or (tp=18) then
      EdDtposicao.enabled:=true;
    if (tp<=4) or (tp=7) or (tp=18) or (tp=24) or (tp=25) then begin
      EdTipocad.enabled:=true;
      EdCodtipo.enabled:=true;
    end else begin
      EdTipocad.enabled:=false;
      EdCodtipo.enabled:=false;
    end;
    if (tp=5) or (tp=6) or (tp=8) or (tp=9) or (tp=16) then begin

      EdDtemissao.enabled:=true;
      if EdDtemissao.isempty then
        EdDtemissao.setdate(Sistema.hoje);
      Edtipomov.enabled:=true;

    end else if tp=10 then begin

      EdLancai.enabled:=true;
      EdLancaf.enabled:=true;
      EdTipocad.enabled:=true;
      EdCodtipo.enabled:=true;
      EdNumerodoc.enabled:=false;
      EdDtemissao.enabled:=false;
      EdDtemissao.text:='';
      Edtipomov.enabled:=false;
      Edtipomov.text:='';
    end else begin
      EdNumerodoc.enabled:=false;
      EdDtemissao.enabled:=false;
      EdDtemissao.text:='';
      Edtipomov.enabled:=false;
      Edtipomov.text:='';
    end;
    if (tp=7) or (tp=11) or (tp=23) or (tp=24) or (tp=21) then begin
      EdLancai.enabled:=true;
      EdLancaf.enabled:=true;
      Edtipomov.enabled:=false;
      EdtipoSmov.enabled:=true;
      if tp=11 then begin
        EdTipocad.enabled:=true;
        EdCodtipo.enabled:=true;
        EdPlan_conta.enabled:=true;
// 20.08.19
        EdNumerodoc.enabled:=true;
        EdNumerodoc.empty:=true;

      end;


    end else
      EdtipoSmov.enabled:=false;
    if EdLancai.enabled then begin
      if (EdLancai.isempty) and ( tp<>1 ) then begin
        EdLancai.setdate(FGeral.GetDatainiciomes(sistema.hoje));
        EdLancaf.setdate(sistema.hoje);
      end;
    end;
    if (tp=12) or (tp=13) then begin
      EdVencimentoi.enabled:=true;
      EdVencimentof.enabled:=true;
      EdTipocad.enabled:=true;
      EdCodtipo.enabled:=true;
// 27.07.09
      if tp=12 then begin
        Edemissaoini.enabled:=true;
        Edemissaofim.enabled:=true;
      end;
    end;
    EdUnid_codigo.enabled:=true;
    if (tp=14) or (tp=15) then begin
      EdLancai.enabled:=true;
      EdLancaf.enabled:=true;
      EdTipocad.enabled:=true;
      EdCodtipo.enabled:=true;
      EdUnid_codigo.enabled:=false;
      if EdLancai.isempty then begin
        EdLancai.setdate(sistema.hoje);
        EdLancaf.setdate(sistema.hoje);
      end;
    end;
    if tp=19 then begin
      EdSoRateio.enabled:=true;
      EdBaixai.enabled:=true;
      EdBaixaf.enabled:=true;
    end;
    if tp=20 then begin
      Edemissaoini.enabled:=true;
      Edemissaofim.enabled:=true;
      EdTipocad.Enabled:=true;
      EdCodtipo.Enabled:=true;
    end;
    if tp=21 then begin
      EdLancai.enabled:=true;
      EdLancaf.enabled:=true;
      EdTipocad.enabled:=true;
      EdCodtipo.enabled:=true;
    end;
// 20.04.11 - Abra - Paulo
    if tp=17 then
      EdPlan_conta.enabled:=true;
    EdMesano.enabled:=( (tp=17) );
    EdMesanoorcado.enabled:=tp=17;
// 26.02.10
    EdCompete.enabled:=( (tp=17) or (tp=22) );
// 19.03.10
    EdMesanofinal.enabled:=( (tp=17) );
// 06.08.15
    EdMesanof.enabled:=( (tp=22) );
    EdMesanofinal1.enabled:=( (tp=22) );
    EdMesanof01.enabled:=( (tp=22) );
    EdMesanofinal02.enabled:=( (tp=22) );
    EdAtivos.enabled:=( (tp=2) and (Recpag='R') and ( FGeral.Getconfig1asinteger('DIASINATIVO')>0 ) );
    EdSeto_codigo.enabled:=( (tp=17) or (tp=27) );
// 26.08.13
    if ( Global.Topicos[1365] ) and (  ((tp>=1) and (tp<=4)) or (tp=11) or (tp=27) ) then EdSeto_codigo.enabled:=true;
// 31.08.09 - 14.02.11
    if ( tp=16 ) or ( tp=5 ) then begin
// 21.02.20
      EdNumerodoc.enabled:=true;
      EdNUmerodocf.enabled:=true

    end else

      EdNUmerodocf.enabled:=false;

    FGeral.SetaItemsMovimento(EdTipomov);
// 17.05.10 - para nao afetar outros relatorios q nao usam mas esta na sql...
    if not EdCodtipo.enabled then begin
      EdCodtipo.text:='';
      EdTipocad.text:='';
    end;
    if not EdVencimentoi.Enabled then begin
      EdVencimentoi.text:='';
      EdVencimentof.text:='';
    end;
// 20.08.19
    if tp=28 then begin

      EdCodtipo.enabled:=true;
      EdTipocad.enabled:=true;
      EdLancai.enabled:=true;
      EdLancaf.enabled:=true;

    end;

    largura:=80;
    SaiOk:=False;
// 28.08.12
    if (tp=2) and (ycodigo>0) then
  // 28.08.12
      FRElfinan.baplicarClick(FRElfinan.Owner)
    else
      FRelFinan.ShowModal;
// 01.07.09 - jamais fazer isto...da 'bostex'...
//    FRelFinan.Show;
    Result:=SaiOk;
  end;
end;

procedure FRelFinan_Incluidas(RecPag:string);
begin
  FRelFinan_Pendencias(RecPag,'INC',1);
end;

procedure FRelFinan_Pendentes(RecPag:string;xcodigo:integer=0);
///////////////////////////////////////////////////////////////
begin

  if xcodigo>0 then begin
// 28.08.12
    if recpag='R' then FRelFinan.EdTipocad.text:='C' else FRelFinan.EdTipocad.text:='F';
    FRelFinan.EdCodtipo.setvalue(xcodigo);
    FRelFinan.EdCodtipo.validfind;
  end;
  FRelFinan_Pendencias(RecPag,'PEN',2,xcodigo);

end;

procedure FRelFinan_Baixadas(RecPag:string);
begin
  FRelFinan_Pendencias(RecPag,'BAI',3);
end;

//////////////////////////////////////////////////////////////////////////////////
procedure FRelFinan_Pendencias(RecPag,Rel:string;Tp:integer;ycodigo:integer=0);    // 1
//////////////////////////////////////////////////////////////////////////////////
var statusvalidos,titulo,periodo,sqlorder,sqlrecpag,valor,sqlcodtipo,sqltipocad,tipomov,tipomovdev,oscodigos,titvencidos,
    unidadebaixa,junta,sqlconta,cemail,sqlsetor,titsetores,campos,
    titcidade,titequipamento:string;
    Q,QCom,QCon,QTemp,QC,
    QF,
    QM             :TSqlquery;
    valorx,vlrantecipa,vlrcomissao,percomissao,valorjuros:currency;
    ListaCodigos,ListaJaBaixadosBP:TStringlist;
    topico:boolean;
    baixacomissao  :TDatetime;
    UsuarioBuscado :integer;


    // 09.11.16
    function GetTransContax(t:string):string;
    /////////////////////////////////////////
    begin
      Qf:=sqltoquery('select movf_transacaocontax from movfin where movf_transacao='+stringtosql(t));
      result:=Qf.fieldbyname('movf_transacaocontax').AsString;
      FGeral.FechaQuery(QF);
    end;

    function GetDescricaoProdutos(t,nome:String):string;
    ////////////////////////////////////////////////////
    var Q:TSqlquery;
        Listacodigos:TStringlist;
        p:integer;
        s:String;
    begin
      Q:=sqltoquery('select move_esto_codigo from movestoque where move_transacao='+stringtosql(t));
      Listacodigos:=TStringlist.create;
      while not Q.eof do begin
        Listacodigos.add(Q.fieldbyname('move_esto_codigo').asstring);
        Q.Next;
      end;
      FGeral.FechaQuery(Q);
      s:='';
      for p:=0 to ListaCodigos.Count-1 do begin
        if trim(ListaCodigos[p])<>'' then begin
          s:=s+trim(FEstoque.GetDescricao(ListaCodigos[p]))+'+';
        end;
      end;
      if trim(s)<>'' then
        result:=s
      else
        result:=nome;
    end;

    function GetUnidadeCaixaBancos(transacao:string):string;
    /////////////////////////////////////////////////////////////
    var Q:TSqlquery;
    begin
      result:=space(3);
      Q:=sqltoquery('select movf_unid_codigo from movfin where movf_transacao='+stringtosql(transacao));
      if not Q.eof then
        result:=Q.fieldbyname('movf_unid_codigo').asstring;
      FGeral.FechaQuery(Q);
    end;


    procedure ChecaBaixaParcial(unidade,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer;saldo:currency);
    //////////////////////////////////////////////////////////////////////////////////////////////
    var Qbx:TSqlquery;
        status,sqlqtipo:string;
        saldox:currency;
    begin
      if Rel='PEN' then
        status:=stringtosql('P')
      else
        status:=stringtosql('N');
      if Datacont>1 then
//        sqlqtipo:=' and pend_datacont>1'
// 26.04.10
        sqlqtipo:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco)
      else
        sqlqtipo:=' and pend_datacont is null';
      QBx:=sqltoquery('select * from pendencias where pend_status='+status+' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
                      ' and pend_parcela='+inttostr(parcela)+
                      ' and pend_unid_codigo='+stringtosql(unidade)+
//                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
      if QBx.eof then begin
         QBx.close;
         Freeandnil(QBx);
         QBx:=sqltoquery('select * from pendencias where pend_status='+status+' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
//                      ' and pend_parcela='+inttostr(parcela)+
                      ' and pend_unid_codigo='+stringtosql(unidade)+
                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
     end;
      saldox:=saldo;
      while not Qbx.eof do begin

          FRel.AddCel(QBx.FieldByName('pend_transacao').AsString);
          FRel.AddCel(QBx.FieldByName('pend_operacao').AsString);
          FRel.AddCel(QBx.FieldByName('pend_unid_codigo').AsString);
// 28.11.11 - Juliana
          if ( (Global.Topicos[1204]) and (recpag='P') ) then
            FRel.AddCel('');
// 18.06.19 - Alutech - Robson
          if (Global.Topicos[1365]) and (recpag='P') then
            FRel.AddCel( '' );

          FRel.AddCel(QBx.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel(QBx.FieldByName('pend_datacont').AsString);
          FRel.AddCel(QBx.FieldByName('pend_numerodcto').AsString);
// 20.07.18 - Alutech - Fran
          if (Global.Topicos[1367]) then
            FRel.AddCel(FEquipamentos.GetDescricao( FRelFinan.GetEquipamento(Q.FieldByName('pend_transacao').AsString)));

// 02.08.07
          if recpag='P' then
            FRel.AddCel('' );  // tipo de compra
          FRel.AddCel('');  // tipo de movimento - 08.09.05
          FRel.AddCel(FCondpagto.GetReduzido(QBx.FieldByName('pend_fpgt_codigo').AsString));
          FRel.AddCel(FPortadores.GetDescricao(QBx.FieldByName('pend_port_codigo').AsString));
          FRel.AddCel(QBx.FieldByName('pend_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeTipoCad(QBx.FieldByName('pend_tipo_codigo').AsInteger,QBx.FieldByName('pend_tipocad').AsString));
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QBx.FieldByName('pend_tipo_codigo').AsInteger,QBx.FieldByName('pend_tipocad').AsString,'N'));
// 08.06.07 - elize - novicarnes
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QBx.FieldByName('pend_tipo_codigo').AsInteger,QBx.FieldByName('pend_tipocad').AsString,'R'));
// 10.01.13 - vivan -bairro pra agilizar cobrança
          if ( (Global.Topicos[1285]) and (recpag='R') ) then
            FRel.AddCel('');

          if ( (Global.Topicos[1264]) ) and (recpag='R') then
            FRel.AddCel( GetDescricaoProdutos(Q.FieldByName('pend_transacao').AsString,FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'R')));


          FRel.AddCel(QBx.FieldByName('pend_repr_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeTipoCad(QBx.FieldByName('pend_repr_codigo').AsInteger,'R'));
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QBx.FieldByName('pend_repr_codigo').AsInteger,'R','N'));
          FRel.AddCel(QBx.FieldByName('pend_datavcto').AsString);
          FRel.AddCel(QBx.FieldByName('pend_databaixa').AsString);
          FRel.AddCel(QBx.FieldByName('pend_transbaixa').AsString);
// 25.09.07
          if QBx.FieldByName('pend_status').AsString='P' then
            unidadebaixa:=GetUnidadeCaixabancos(QBx.FieldByName('pend_transacao').AsString)
          else
            unidadebaixa:=GetUnidadeCaixabancos(QBx.FieldByName('pend_transbaixa').AsString);
          FRel.AddCel(unidadebaixa);
// 03.08.06
          FRel.AddCel(QBx.FieldByName('pend_observacao').AsString);

          FRel.AddCel(QBx.FieldByName('pend_nparcelas').AsString);
          FRel.AddCel(QBx.FieldByName('pend_parcela').AsString);
          FRel.AddCel(QBx.FieldByName('pend_status').AsString);
          FRel.AddCel(formatfloat(f_cr,(-1)*texttovalor(Qbx.FieldByName('pend_valor').Asstring)));
// 31.05.11
          if (Rel='BAI') and (Global.Topicos[1280]) and (RecPag='R') then begin
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
          end;
          FRel.AddCel('');
          FRel.AddCel(Qbx.FieldByName('pend_mora').AsString);
          FRel.AddCel(Qbx.FieldByName('pend_descontos').AsString);
          saldox:=saldox-QBx.FieldByName('pend_valor').AsCurrency;
          FRel.AddCel(formatfloat(f_cr,saldox));
// 03.04.08
          if Global.Topicos[1105] then begin
            FRel.AddCel('');
          end;
// 06.11.12
          if (Global.Topicos[1281])  then begin
            FRel.AddCel('');
            FRel.AddCel('');
          end;
// 26.06.13
          if (Global.Topicos[1262])  then begin
            FRel.AddCel('');
          end;
// 09.09.14 - Vivan
          if (pos(Rel,'PEN')>0) and (Global.topicos[1291]) and (recpag='R') then
            FRel.AddCel('');
          Qbx.next;
      end;
      Qbx.close;
      Freeandnil(Qbx);
    end;

// 04.06.10
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

// 04.06.10 - Abra - Paulo
//////////////////////////////////
    function TudoBaixadoBP(xoperacao:string):boolean;
    begin
      if rel='PEN' then begin
        if ListaJaBaixadosBP.IndexOf(xoperacao)>=0 then
          result:=true
        else
          result:=false;
      end else
        result:=false;
    end;

    function Gettipomov(transacao:String):string;
    ///////////////////////////////////////////////
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select moes_tipomov from movesto where moes_transacao='+stringtosql(transacao));
      result:='';
      if not Q.eof then begin
        result:=Q.fieldbyname('moes_tipomov').asstring;
        if result=Global.CodDevolucaoConsig then   //  09.09.05 - gambia para reges -
          result:=Global.CodVendaConsig;
      end else
        result:=Global.CodPendenciaFinanceira;
      Q.close;
      Freeandnil(Q);
    end;

    function EstaValendo(vencimento:TDatetime ; rp:string ):boolean;
    ////////////////////////////////////////////////////////////////////
    var diasvencidos:integer;
        ativo:string;
        QBx1:TSqlquery;
    begin

// 15.08.19
      if (not FRelfinan.EdEqui_codigo.isempty) then begin

// 27.09.2021 - A2z

        if rp = 'R' then begin

        if FRelfinan.GetEquipamentos(Q.FieldByName('pend_transacao').AsString,FRelfinan.Edequi_codigo.text)  then
           result:=true
        else
           result:=false;

        end else


        if FRelfinan.Edequi_codigo.text <> FRelfinan.GetEquipamento(Q.FieldByName('pend_transacao').AsString)  then
           result:=false
        else
           result:=true;

      end  else if Rel='PEN' then begin
// 15.06.16
        if (not FRelfinan.EdCida_codigo.isempty) and (rp='R') then begin

           if (FRelfinan.EdCida_codigo.text<>FCadCli.getCodigoCidade(Q.fieldbyname('pend_tipo_codigo').AsInteger)) then
             result:=false
// 24.04.17 - giacomoni
           else
             result:=true;

// 17.06.13 - Vivan - Angela
        end else if (Global.Topicos[1261]) and (Q.fieldbyname('pend_tipomov').AsString=global.CodDevolucaoCompra ) then
          result:=false
// 21.09.09 - Damama
        else if ( Q.fieldbyname('pend_status').AsString='A' ) and (Q.fieldbyname('pend_databaixa').AsDatetime>1) then
// 21.02.18 - Novicarnes
        else if ( FRelfinan.Edativos.text='D' ) and ( rp='R' ) then begin
             if FCadCli.GetSituacao( Q.FieldByName('pend_tipo_codigo').AsInteger ) <>'D' then
                result:=false
             else
                result:=true;

        end else if ( Q.fieldbyname('pend_status').AsString='A' ) and (Q.fieldbyname('pend_databaixa').AsDatetime>1) then
          result:=false
//////////////
        else if (FRelfinan.Edativos.text='T' ) or ( rp='P' ) then begin

          result:=true;
          {  // 06.08.19 - retirado pois nao aparecia as CPR...
          QBx1:=sqltoquery('select sum(pend_valor) as parcial from pendencias where pend_status='+stringtosql('P')+
                      ' and pend_tipo_codigo='+stringtosql(Q.fieldbyname('pend_tipo_codigo').asstring)+
                      ' and pend_tipocad='+stringtosql(Q.fieldbyname('pend_tipocad').asstring)+
                      ' and pend_databaixa > '+DatetoSql(Global.DataMenorBanco)+
                      ' and pend_parcela='+Q.fieldbyname('pend_parcela').asstring+
// 23.03.15  - coorlafs
                      ' and pend_observacao <> '+Stringtosql('Pagamento Leite')+
                      ' and pend_unid_codigo='+stringtosql(Q.fieldbyname('pend_unid_codigo').asstring)+
                      ' and pend_numerodcto='+stringtosql(Q.fieldbyname('pend_numerodcto').asstring) );
          if not QBx1.eof then begin
            if qbx1.fieldbyname('parcial').ascurrency>=q.FieldByName('pend_valor').ascurrency then
              result:=false;
          end else
          fgeral.fechaquery(QBx1);
          }
        end else begin

          ativo:='S';
          diasvencidos:=trunc( sistema.hoje-vencimento );
          if (rp='R') and ( diasvencidos>0 )  and ( diasvencidos>FGeral.Getconfig1asinteger('DIASINATIVO') )
             and ( FGeral.Getconfig1asinteger('DIASINATIVO')>0 )  then
             ativo:='N';
          if (FRelfinan.EdAtivos.text='A') and (ativo='N') then
            result:=false
          else if (FRelfinan.EdAtivos.text='I') and (ativo='S') then
            result:=false
          else
            result:=true;
        end;

      end else if rel='INC' then begin // 09.02.10 - Abra -Paulo
// 03.04.17 - Simar - irma pegou
        result:=true;
/////////////
        if ( Q.fieldbyname('pend_status').AsString='K' ) and (Q.fieldbyname('pend_databaixa').AsDatetime>1) then
          result:=false
/////////////
      end else

        result:=true;

    end;

// 01.08.07
    function GetTipoCompra(codigo:integer ; tipocad,tipomovx:String):string;
    ////////////////////////////////////////////////////////////////////////
    var Qx:TSqlquery;
    begin
       if tipocad='F' then begin
         result:='Fornecedor'
       end else if tipocad='C' then begin
         Qx:=sqltoquery('select clie_ativo from clientes where clie_codigo='+inttostr(codigo));
         if not Qx.eof then begin
//           if tipomovx=global.CodCompraProdutor then begin
// 28.11.17
           if AnsiPos(tipomovx,global.CodCompraProdutor+';'+Global.CodEntradaProdutor)>0 then begin
             if Qx.FieldByName('clie_ativo').asstring='S' then
               result:='Compra Associado'
             else
               result:='Compra Não Associado';
           end else
             result:='Cliente';
         end else
           result:='';
         FGeral.Fechaquery(Qx);
       end;
    end;

    procedure ChecaDependentes(matricula,codigo:integer);
    ////////////////////////////////////////////////////////
    var Q:TSqlquery;
    begin
      if matricula=0 then exit;
      Q:=sqltoquery('select * from clientes where Clie_matricula='+inttostr(matricula)+' and clie_codigo<>'+inttostr(codigo));
      while not Q.eof do begin
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel('');
          FRel.AddCel('');
// 02.08.07
          if recpag='P' then
            FRel.AddCel('' );  // tipo de compra
          FRel.AddCel('');  // tipo de movimento - 08.09.05
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel(Q.FieldByName('clie_nome').AsString);
          FRel.AddCel('');
//          FRel.AddCel(FGeral.GetNomeTipoCad(QBx.FieldByName('pend_repr_codigo').AsInteger,'R'));
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
// 03.08.06
          FRel.AddCel('');

          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
// 03.04.08
          if Global.Topicos[1105] then begin
            FRel.AddCel(Q.FieldByName('Clie_grupoinv').AsString);
          end;
          if Rel='BAI' then
            FRel.AddCel('');


        Q.Next;
      end;
      FGeral.FechaQuery(Q);

    end;

// 13.04.10 = Damama
    procedure SaldoAntecipacoes;
    ///////////////////////////
    var QA:TSqlquery;
        saldo:currency;
    begin
      QA:=sqltoquery('select pend_rp,sum(pend_valor) as vlrantecipa from pendencias where pend_status='+stringtosql('A')+
                      ' and pend_tipo_codigo='+FRelfinan.EdCodTipo.assql+
                      ' and pend_tipocad='+FRelfinan.EdTipocad.assql+
                      ' and '+FGeral.GetIN('pend_unid_codigo',FRelfinan.EdUnid_codigo.text,'C')+
                      ' group by pend_rp' );
      saldo:=0;
      while not QA.eof do begin
        if QA.fieldbyname('pend_rp').asstring='R' then
          saldo:=saldo+QA.fieldbyname('vlrantecipa').ascurrency
        else
          saldo:=saldo-QA.fieldbyname('vlrantecipa').ascurrency;
        QA.Next;
      end;
      FGeral.FechaQuery(QA);

          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel('');
          FRel.AddCel('');
// 02.08.07
          if recpag='P' then
            FRel.AddCel('' );  // tipo de compra

          FRel.AddCel('');  // tipo de movimento - 08.09.05
          FRel.AddCel('');
          FRel.AddCel('');

          if recpag='R' then   // 08.06.10 - a receber tem uma coluna a mais...

            FRel.AddCel('')   // 07.06.10 - tinha uma coluna a mais...
// 16.08.2021
          else if ( recpag='P' ) then begin

             FRel.AddCel('');
             FRel.AddCel('');

          end;

          FRel.AddCel('Saldo Credor/Devedor');
          FRel.AddCel('');
//          FRel.AddCel(FGeral.GetNomeTipoCad(QBx.FieldByName('pend_repr_codigo').AsInteger,'R'));
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
// 03.08.06
          FRel.AddCel('');

          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
// 16.08.2021 - Alutech - robson percebeu quando ativou esquema de antecipacoes
// 10.09.2021 - Branutri pegou erro...  aqui parece fica errado pra alutech..
// 27.10.2021 - Alutech - Fran 'pegou de novo'....

         if (recpag='R') then begin
// credito OU saldo de duplicata
//            if ( (Global.Topicos[1264]) ) then

//                FRel.AddCel('');


         end;

          FRel.AddCel( formatfloat(f_cr,saldo) );
          FRel.AddCel('');
          FRel.AddCel( '' );
          FRel.AddCel( formatfloat(f_cr,saldo) );
          if Global.Topicos[1105] then begin
            FRel.AddCel('');
          end;
          if Rel='BAI' then
            FRel.AddCel('');

// 27.10.2021 - credito OU saldo de duplicata
          if ( (Global.Topicos[1264]) ) then

            FRel.AddCel('');

// 16.08.2021 - Alutech - robson percebeu quando ativou esquema de antecipacoes
// codigo + usuario
          if (Global.Topicos[1281]) then begin

            FRel.AddCel('');
            FRel.AddCel( '' );

          end;

    end;

// 06.05.10 = Damama
    procedure SaldoAntecipacoesTodos(TLista:TStringlist);
    ///////////////////////////
    var QA:TSqlquery;
        saldo:currency;
        x,codcli:integer;
        sqltipo:string;
    begin
      for x:=0 to Tlista.Count-1 do begin
         codcli:=strtointdef(TLista[x],0);
         sqltipo:=' and pend_tipocad=''C''';
         if recpag='P' then
           sqltipo:=' and pend_tipocad=''F''';
         if codcli>0 then begin
            QA:=sqltoquery('select pend_rp,sum(pend_valor) as vlrantecipa from pendencias where pend_status='+stringtosql('A')+
                            ' and pend_tipo_codigo='+inttostr(codcli)+
                            sqltipo+
                            ' and '+FGeral.GetIN('pend_unid_codigo',FRelfinan.EdUnid_codigo.text,'C')+
                            ' group by pend_rp' );
            saldo:=0;
            while not QA.eof do begin
              if QA.fieldbyname('pend_rp').asstring='R' then
                saldo:=saldo+QA.fieldbyname('vlrantecipa').ascurrency
              else
                saldo:=saldo-QA.fieldbyname('vlrantecipa').ascurrency;
              QA.Next;
            end;
            FGeral.FechaQuery(QA);
            if saldo<>0 then begin
                FRel.AddCel('');
                FRel.AddCel('');
                FRel.AddCel('');
                FRel.AddCel('');
                FRel.AddCel('');
                if Global.Usuario.OutrosAcessos[0701] then
                  FRel.AddCel('');
                FRel.AddCel('');
      // 02.08.07
                if recpag='P' then
                  FRel.AddCel('' );  // tipo de compra
                FRel.AddCel('');  // tipo de movimento - 08.09.05
                FRel.AddCel('');
                FRel.AddCel('');
                FRel.AddCel(inttostr(codcli));
                if recpag='P' then
                  FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(codcli,'F','N') )
                else
                  FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(codcli,'C','N') );
//                FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(codcli,'C','N')+' Crédito/Débito' );
                if recpag='R' then   // 06.07.10 - a receber tem uma coluna a mais...
                   FRel.AddCel('');
                FRel.AddCel('Saldo Credor/Devedor');
//                FRel.AddCel('');
      //          FRel.AddCel(FGeral.GetNomeTipoCad(QBx.FieldByName('pend_repr_codigo').AsInteger,'R'));
                FRel.AddCel('');
                FRel.AddCel('');
                FRel.AddCel('');
                FRel.AddCel('');
                FRel.AddCel('');
      // 03.08.06
                FRel.AddCel('');

                FRel.AddCel('');
                FRel.AddCel('');
                FRel.AddCel('');
//                  FRel.AddCel('');
//                FRel.AddCel('');
                FRel.AddCel( formatfloat(f_cr,(-1)*saldo) );

//                if saldo>0 then
//                  FRel.AddCel( formatfloat(f_cr,(-1)*saldo) )
//                else
                  FRel.AddCel( formatfloat(f_cr,saldo) );
                FRel.AddCel('');
                FRel.AddCel( '' );
                FRel.AddCel( formatfloat(f_cr,saldo) );
                if Global.Topicos[1105] then begin
                  FRel.AddCel('');
                end;
                if Rel='BAI' then
                  FRel.AddCel('');
            end;
         end; // codcli>0
      end;  // for
    end;

// 28.11.11
    function GetNroObra(xtransacao:String):string;
    //////////////////////////////////////////////
    var Q:TSqlquery;
    begin
      Q:=Sqltoquery('select moes_nroobra from movesto where moes_transacao='+Stringtosql(xtransacao));
      if not Q.eof then
        result:=Q.fieldbyname('moes_nroobra').asstring
      else
        result:='';
      FGeral.FechaQuery(Q);
    end;

    // 05.09.17
    function GetCfop( xop:string ):string;
    //////////////////////////////////////
    var Qt:TSqlquery;
    begin
       Qt:=sqltoquery('select moes_natf_codigo from movesto where moes_transacao='+Stringtosql(xop));
       if not Qt.Eof then result:=Qt.FieldByName('moes_natf_codigo').AsString else result:='';
       FGeral.FechaQuery(Qt);
    end;

////////////////////////////////////////////////////////////
begin
////////////////////////////////////////////////////////////

  with FRelFinan do begin

    if not FRelFinan_Execute(tp,Recpag,'',ycodigo) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    sqlrecpag:=' and pend_RP='+stringtosql(Recpag);
    if RecPag='R' then begin
      titulo:='Relatório de Recebimentos - ';
    end else begin
      titulo:='Relatório de Pagamentos - ';
    end;
    titvencidos:='';
    titsetores:='';
    sqlconta:='';
    if Global.Topicos[1277] then
      topico:=true
    else
      topico:=false;
// 05.10.11 - Damama
    cemail:='';
    if (Global.Topicos[1282] ) and (not EdTipoCad.isempty) and (not EdCodtipo.isempty) then begin
       cemail:=FGeral.GetEmailEntidade(EdCodtipo.asinteger,EdTipocad.text,'S')
    end;
// 26.08.13
    sqlsetor:='';
    if (Global.Topicos[1365]) and (not EdSeto_codigo.IsEmpty) then begin
       sqlsetor:='and pend_Seto_codigo='+EdSeto_codigo.AsSql;
       titsetores:=' - '+FSetores.GetDescricao(Edseto_codigo.text)
    end;
// 15.08.19
    titequipamento:='';
    if not EdEqui_codigo.IsEmpty then  begin
       titequipamento:=' - Equipamento/Veículo : '+EdEqui_codigo.Text+' - '+EdEqui_codigo.ResultFind.fieldbyname('equi_descricao').AsString;
    end;

    if Rel='INC' then begin
//      statusvalidos:='N;A;D';
// 15.12.05
      statusvalidos:='N;A;D;B;P;K';
      titulo:=titulo+'Incluídas';
      sqlorder:=' order by pend_unid_codigo,pend_tipo_codigo,pend_dataemissao';
      if not EdPlan_conta.isempty then begin
        titulo:=titulo+' - Conta : '+EdPlan_conta.text+' '+EdPlan_descricao.text;
        sqlconta:=' and pend_plan_conta='+EdPlan_conta.assql;
      end;
    end else if Rel='PEN' then begin
      statusvalidos:='N;A';
// 13.04.10 - Clessi   // Damama
      if ( Global.Topicos[1274] ) or ( Global.Topicos[1275] ) then
        statusvalidos:='N';
// 07.09.13 - Damama
      if (EdCodtipo.asinteger>0) and (EdTipocad.text='C') then
        if Edcodtipo.resultfind<>nil then
          if Edcodtipo.resultfind.fieldbyname('clie_situacao').asstring='F' then
            statusvalidos:='N;A';
/////////////////////////////////
      titulo:=titulo+'Pendentes';
      sqlorder:=' order by pend_unid_codigo,pend_tipo_codigo,pend_dataemissao,pend_databaixa,pend_datavcto,pend_numerodcto';
//      sqlorder:=' order by pend_unid_codigo,pend_repr_codigo,pend_tipo_codigo,pend_numerodcto,pend_datavcto';
//      sqlorder:=' order by pend_unid_codigo,pend_tipo_codigo,pend_datavcto,pend_numerodcto';
//      sqlorder:=' order by pend_unid_codigo,pend_tipo_codigo,pend_numerodcto,pend_datavcto';
// se mudar a ordem 'phode' a baixa parcial
      if not EdPlan_conta.isempty then begin
        titulo:=titulo+' - Conta : '+EdPlan_conta.text+' '+EdPlan_descricao.text;
        sqlconta:=' and pend_plan_conta='+EdPlan_conta.assql;
      end;
    end else begin
      statusvalidos:='B;P;E';
      titulo:=titulo+'Baixadas';
// 26.05.11
      if not EdPlan_conta.isempty then begin
        titulo:=titulo+' - Conta : '+EdPlan_conta.text+' '+EdPlan_descricao.text;
        sqlconta:=' and pend_plan_conta='+EdPlan_conta.assql;
      end;
      sqlorder:=' order by pend_unid_codigo,pend_tipo_codigo,pend_databaixa';
    end;
    sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C');
// 31.08.15 - vivan - cris pegou
    if RecPag='P' then
      sqlportadorcartao:='';
    periodo:='Periodo : ';
    if EdLancai.AsDate>1 then begin
      sqldatalan:=' and pend_datalcto>='+EdLancai.AsSql+' and pend_datalcto<='+EdLancaf.AsSql;
      periodo:=periodo+' Lançamento : '+FGeral.FormataData(EdLancai.AsDate)+' a '+FGeral.FormataData(EdLancaf.AsDate);
    end else
      sqldatalan:='';
    if EdBaixai.AsDate>1 then begin
      sqldatabai:=' and pend_databaixa>='+EdBaixai.AsSql+' and pend_databaixa<='+EdBaixaf.AsSql;
      periodo:=periodo+' Baixa : '+FGeral.FormataData(EdBaixai.AsDate)+' a '+FGeral.FormataData(EdBaixaf.AsDate);
    end else
      sqldatabai:='';
    if (EdVencimentoi.AsDate>1) and (EdVencimentof.AsDate>1) then begin
      sqldatavenci:=' and pend_datavcto>='+EdVencimentoi.AsSql+' and pend_datavcto<='+EdVencimentof.AsSql;
      periodo:=periodo+' Vencimento : '+FGeral.FormataData(EdVencimentoi.AsDate)+' a '+FGeral.FormataData(EdVencimentof.AsDate);
    end else
      sqldatavenci:='';
    if not Edtipocad.isempty then begin
      sqltipocad:=' and pend_tipocad='+Edtipocad.AsSql
    end else
      sqltipocad:='';
    if EdCodtipo.AsInteger>0 then begin
      titulo:=titulo+' - Codigo '+EdCodtipo.text+' - '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipocad.text,'N');
      if EdTipocad.text='R' then begin
        sqlcodtipo:=' and pend_repr_codigo='+Edcodtipo.AsSql;
        if RecPag='R' then
          sqltipocad:=' and pend_tipocad='+Stringtosql('C');
//        else
//          sqltipocad:=' and pend_tipocad='+Stringtosql('F');
      end else
        sqlcodtipo:=' and pend_tipo_codigo='+Edcodtipo.AsSql
    end else
      sqlcodtipo:='';
// 22.10.07
//    if ( not Edemissaoini.isempty ) and ( not Edemissaofim.isempty )  and ( rel='INC' ) then begin
// 27.07.09
    if ( not Edemissaoini.isempty ) and ( not Edemissaofim.isempty ) then begin
      sqlperiodoemissao:=' and pend_dataemissao>='+Edemissaoini.assql+' and pend_dataemissao<='+Edemissaofim.assql;
      periodo:=periodo+' Emissão : '+FGeral.FormataData(Edemissaoini.AsDate)+' a '+FGeral.FormataData(Edemissaofim.AsDate);
    end else
      sqlperiodoemissao:='';
//    Q:=sqltoquery('select * from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
// 16.04.08 - retirado o inner pois este relat. server pra clientes/fornecedores
// 08.05.08
    if ( (Global.Topicos[1105]) or (Global.Topicos[1292]) ) and (RecPag='R') then
      junta:= 'inner join clientes on ( clie_codigo=pend_tipo_codigo )'
    else
      junta:='';
// 26.09.13 - Novicarnes - Iso+jake
    if (Rel='INC') and (Global.Topicos[1287]) and (RecPag='P') then begin
       junta:= 'left join movesto on ( (moes_transacao=pend_transacao) and (moes_tipomov=pend_tipomov) )';
       campos:='*,moes_notapro ';
    end else
       campos:= '*';
// 15.06.16 - Giacomoni - Barbara
    titcidade:='';
    if not EdCida_codigo.isempty then begin
      titcidade:=EdCida_codigo.Text+' - '+EdCida_codigo.ResultFind.fieldbyname('cida_nome').asstring;
   end;

    ListaJaBaixadosBP:=TStringList.create;

    Q:=sqltoquery('select '+campos+' from pendencias '+junta+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  sqlrecpag+
                  sqlunidade+
                  sqldatalan+
                  sqldatabai+
                  sqldatavenci+
                  sqldatacont+
                  sqlcodtipo+
                  sqltipocad+
                  sqlperiodoemissao+
                  sqlconta+  // 10.03.09
                  sqlportadorcartao+  // 23.10.12
                  sqlsetor+  // 26.08.13
                  sqlorder );

// 04.06.10 - Abra - Paulo
    if (topico) and (Rel='PEN')  then begin

      Sistema.beginprocess('Checando titulos baixados com baixas parciais');
      while not Q.eof do begin
        if EstaValendo(Q.FieldByName('pend_datavcto').AsDatetime,recpag) then begin
          if Q.FieldByName('pend_status').AsString='N' then begin
           if TudoBaixado(Q.FieldByName('pend_unid_codigo').AsString,Q.FieldByName('pend_tipo_codigo').AsString,Q.FieldByName('pend_tipocad').AsString,
              Q.FieldByName('pend_numerodcto').AsString,Q.FieldByName('pend_dataemissao').Asdatetime,
              Q.FieldByName('pend_datacont').Asdatetime,Q.FieldByName('pend_datavcto').Asdatetime,
              Q.FieldByName('pend_parcela').Asinteger,0) then
                  ListaJaBaixadosBP.Add(Q.FieldByName('pend_operacao').AsString);
          end;
        end;
        Q.Next;
      end;
      Q.First;
    end;

    ListaCodigos:=TStringlist.create;
    oscodigos:='';
//    if Q.Eof then begin
//      Avisoerro('Nada encontrado para impressão');
//      oscodigos:=EdCodtipo.Text;
//    end else begin
      if Rel='INC' then
        FRel.Init('RelIncluidas')
      else if Rel='PEN' then begin
        FRel.Init('RelPendentes');
        if FGeral.Getconfig1asinteger('DIASINATIVO')>0 then begin
          if (FRelfinan.EdAtivos.text='A') then
            titvencidos:=' - Somente vencidos ATÉ '+inttostr(FGeral.Getconfig1asinteger('DIASINATIVO'))+' dias'
          else  if (FRelfinan.EdAtivos.text='I') then
            titvencidos:=' - Somente vencidos APÓS '+inttostr(FGeral.Getconfig1asinteger('DIASINATIVO'))+' dias'
          else  if (FRelfinan.EdAtivos.text='D') then
            titvencidos:=' - Somente Devedores Duvidosos'
          else
            titvencidos:=' - Todos os documentos';
        end;
        titulo:=titulo+titvencidos;
// 06.06.07
      end else
        FRel.Init('RelBaixadas');

      titulo:=titulo+titcidade;
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit(Periodo+TitSetores+titEquipamento);
      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'       ,''         ,'',false);
      FRel.AddCol( 80,0,'C','' ,''              ,'OPeracao'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
// 28.11.11 - Juliana
      if ( (Global.Topicos[1204]) and (recpag='P') ) then
        FRel.AddCol( 100,1,'C','' ,''              ,'Obra'           ,''         ,'',false);
// 18.06.19 - Alutech - Robson
      if (Global.Topicos[1365]) and (recpag='P') then
         FRel.AddCol( 100,1,'C','' ,''              ,'Setor'           ,''         ,'',false);

      FRel.AddCol( 65,1,'D','' ,''              ,'Lançamento'      ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      if Global.Usuario.OutrosAcessos[0701] then
         FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
// 26.09.13 - Novicarnes - Iso+jake
      if (Rel='INC') and (Global.Topicos[1287]) and (RecPag='P') then
        FRel.AddCol( 70,2,'N','' ,''              ,'NF Produtor'      ,''         ,'',False);
// 27.06.18 - para conferir cobrança bancaria - nosso numero
      if (Rel='INC') and (Global.Topicos[1298]) and (RecPag='R') then
        FRel.AddCol( 70,2,'N','' ,''              ,'Nosso Numero'      ,''         ,'',False);
// 10.02.14 - Patoterra - Leila - 20.07.18 - Alutech - Fran
      if ((Rel='INC') or (Rel='BAI') or (Rel='PEN') ) and (Global.Topicos[1367])  then
        FRel.AddCol(180,1,'C','' ,''              ,'Equipamento'          ,''         ,'',False);

// 01.08.07
      if recpag='P' then
        FRel.AddCol(120,0,'C','' ,''              ,'Tipo Compra'  ,''         ,'',False);
// 08.09.05
      FRel.AddCol(100,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
      FRel.AddCol( 70,0,'C','' ,''              ,'Forma Pagto'     ,''         ,'',false);
      FRel.AddCol( 90,0,'C','' ,''              ,'Portador'        ,''         ,'',false);
      if recpag='R' then begin
        FRel.AddCol( 45,0,'N','' ,''              ,'Cliente'         ,''         ,'',false);
      end else
        FRel.AddCol( 45,0,'N','' ,''              ,'Fornecedor'         ,''         ,'',false);

      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
// 10.01.13 - vivan -bairro pra agilizar cobrança
      if ( (Global.Topicos[1285]) and (recpag='R') ) then
          FRel.AddCol( 100,0,'C','' ,''              ,'Bairro'         ,''         ,'',false);
      if ( (Global.Topicos[1264]) ) and (recpag='R') then
        FRel.AddCol(150,0,'C','' ,''              ,'Produtos'            ,''         ,'',false);
      if Recpag='R' then begin

        FRel.AddCol( 45,0,'N','' ,''              ,'Representante'   ,''         ,'',false);
        if Global.topicos[1292] then
          FRel.AddCol(150,0,'C','' ,''              ,'Cidade / Fone'      ,''         ,'',false)
        else
          FRel.AddCol(150,0,'C','' ,''              ,'Nome Repr.'      ,''         ,'',false);

      end else begin

        FRel.AddCol( 45,0,'N','' ,''              ,'Conta'           ,''         ,'',false);
        FRel.AddCol(150,0,'C','' ,''              ,'Nome Conta'      ,''         ,'',false);

      end;
      FRel.AddCol( 60,1,'D','' ,''              ,'Vencimento'      ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Baixa'           ,''         ,'',false);
      FRel.AddCol( 70,1,'C','' ,''              ,'Transação Baixa' ,''         ,'',false);
      FRel.AddCol( 70,1,'C','' ,''              ,'Unidade Baixa' ,''         ,'',false);
      FRel.AddCol( 85,1,'C','' ,''              ,'Quem Pagou'      ,''         ,'',false);
      FRel.AddCol( 30,2,'N','' ,''              ,'NP'              ,''         ,'',False);
      FRel.AddCol( 30,2,'N','' ,''              ,'Parc'            ,''         ,'',False);
      FRel.AddCol( 50,2,'C','' ,''              ,'Antec./Bx Parc.' ,''         ,'',False);
      FRel.AddCol( 70,3,'N','+' ,f_cr            ,'Valor Parcela'   ,''         ,'',False);
      if (Rel='BAI') and (Global.Topicos[1280]) and (RecPag='R') then begin
        FRel.AddCol( 80,3,'N','+' ,f_cr            ,'Valor Comissão'   ,''         ,'',False);
        FRel.AddCol( 80,2,'D','' ,''               ,'Baixa Comissão'   ,''         ,'',False);
        FRel.AddCol( 60,3,'N','' ,f_cr             ,'% Comissão'   ,''         ,'',False);
      end;
      FRel.AddCol( 75,3,'N','+' ,f_cr            ,'Vlr Antecipação' ,''         ,'',False);
      FRel.AddCol( 70,3,'N','+' ,f_cr            ,'Mora/Multa'      ,''         ,'',False);
      FRel.AddCol( 70,3,'N','+' ,f_cr            ,'Valor Desconto'  ,''         ,'',False);

      if ( (Global.Topicos[1264]) ) and (recpag='R') then
        FRel.AddCol( 70,3,'N','+' ,f_cr            ,'Crédito'         ,''         ,'',False)
      else
        FRel.AddCol( 70,3,'N','-' ,f_cr            ,'Saldo Duplicata' ,''         ,'',False);

      if Global.Topicos[1105] then begin
        FRel.AddCol( 85,1,'C','' ,''              ,'Grupo'      ,''         ,'',false);
      end;
      if Rel='BAI' then begin
        FRel.AddCol( 70,1,'N','&' ,''            ,'Atraso' ,''         ,'',False);
// 05.10.09
        FRel.AddCol( 70,1,'N','&' ,''            ,'Prazo'   ,''         ,'',False);
      end;
// 13.04.10 - Damama - 16.08.2021 - retirado
//      if ( EdCodtipo.AsInteger>0 ) and ( Rel='PEN' ) and ( Global.Topicos[1275] ) then
//         SaldoAntecipacoes;


// 19.10.12 - Vivan
      if (Global.Topicos[1281])  then begin
        FRel.AddCol( 60,3,'C','' ,''              ,'Codigo',''         ,'',false);
        FRel.AddCol(100,0,'C','' ,''              ,'Usuário' ,''         ,'',false);
      end;

// 26.06.13 - Metalforte  - Vivan baixadas
      if (pos(Rel,'PEN/BAI')>0) and (Global.topicos[1262]) then
        FRel.AddCol( 75,3,'N','+' ,f_cr            ,'Vlr Atualizado' ,''         ,'',False);
// 09.09.14 - Vivan
      if (pos(Rel,'PEN')>0) and (Global.topicos[1291]) and ( recpag='R' ) then
        FRel.AddCol( 75,3,'D','' ,''            ,'Dt Cadastro' ,''         ,'',False);
// 09.11.16 - Novi+Andre
      if (pos(Rel,'BAI')>0) and (Global.Usuario.Codigo=100) and ( Global.topicos[1045] ) then
        FRel.AddCol( 75,3,'C','' ,''            ,'Dif. Contab.' ,''         ,'',False);
// 05.09.17 - Novicarnes
      if (pos(Rel,'INC')>0) and (Global.topicos[1294]) and ( recpag='P' ) then
        FRel.AddCol( 45,1,'C','' ,''            ,'CFOP' ,''         ,'',False);

// aqui em 16.08.2021 - 13.04.10 - Damama
      if ( EdCodtipo.AsInteger>0 ) and ( Rel='PEN' ) and ( Global.Topicos[1275] ) then
         SaldoAntecipacoes;

      while not Q.eof do begin

        if ( EstaValendo(Q.FieldByName('pend_datavcto').AsDatetime,recpag) ) and
           ( not TudoBaixadoBP(Q.FieldByName('pend_operacao').AsString) )
          then begin

          FRel.AddCel(Q.FieldByName('pend_transacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_operacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_unid_codigo').AsString);
// 28.11.11 - Juliana
          if ( (Global.Topicos[1204]) and (recpag='P') ) then
            FRel.AddCel( GetNroObra(Q.FieldByName('pend_transacao').AsString) );
// 18.06.19 - alutech - robson
          if ( (Global.Topicos[1365]) and (recpag='P') ) then
            FRel.AddCel( FSetores.GetDescricao(Q.FieldByName('pend_seto_codigo').AsString) );

          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
          if Global.Usuario.OutrosAcessos[0701] then

             FRel.AddCel(Q.FieldByName('pend_datacont').AsString);

          FRel.AddCel(Q.FieldByName('pend_numerodcto').AsString);
// 26.09.13 - Novicarnes - Iso+jake
          if (Rel='INC') and (Global.Topicos[1287]) and (RecPag='P') then
            FRel.AddCel(inttostr(Q.FieldByName('moes_notapro').AsInteger));
// 27.06.18 - para conferir cobrança bancaria - nosso numero
          if (Rel='INC') and (Global.Topicos[1298]) and (RecPag='R') then
            FRel.AddCel( Q.FieldByName('pend_opantecipa').AsString );

// 06.02.14 - 20.07.18 - Alutech - Fran
//          if ( global.topicos[1367] ) and (Rel='INC') then
          if ( (Rel='INC') or (Rel='BAI')  or (Rel='PEN') ) and (Global.Topicos[1367])  then begin

// 27.09.2021 - A2z

              if recpag = 'R' then begin

               if ( not GetEquipamentos(Q.FieldByName('pend_transacao').AsString,EdEqui_codigo.text) )
//                  or
                 then begin
// 28.07.2022 - A2z certeza...rs Thais
                   if Q.FieldByName('pend_status').AsString='P' then

                     FRel.AddCel( FEquipamentos.GetDescricao( GetEquipamento(
                                GetTransEquipamentoBP(Q.FieldByName('pend_numerodcto').AsString,
                                        Q.FieldByName('pend_unid_codigo').AsString,
                                        Q.FieldByName('pend_rp').AsString,
                                        Q.FieldByName('pend_tipo_codigo').AsInteger,
                                        Q.FieldByName('pend_plan_conta').AsInteger))) )
                   else

                     FRel.AddCel( FEquipamentos.GetDescricao(GetEquipamento(Q.FieldByName('pend_transacao').AsString)) )

               end else

                 FRel.AddCel('');


// 15.08.19  - aqui
              end else   if ( EdEqui_codigo.text=GetEquipamento(Q.FieldByName('pend_transacao').AsString) )
                or
                ( EdEqui_codigo.isempty )
               then begin

                   if Q.FieldByName('pend_status').AsString='P' then begin

                     FRel.AddCel( FEquipamentos.GetDescricao( GetEquipamento(
                                GetTransEquipamentoBP(Q.FieldByName('pend_numerodcto').AsString,
                                        Q.FieldByName('pend_unid_codigo').AsString,
                                        Q.FieldByName('pend_rp').AsString,
                                        Q.FieldByName('pend_tipo_codigo').AsInteger,
                                        Q.FieldByName('pend_plan_conta').AsInteger))) )

                   end else

                     FRel.AddCel( FEquipamentos.GetDescricao(GetEquipamento(Q.FieldByName('pend_transacao').AsString)) )
               end

             else
               FRel.AddCel('');

          end;

// 23.11.07
          if Q.FieldByName('pend_tipomov').asstring='' then
// 08.09.05
            tipomov:=Gettipomov(Q.FieldByName('pend_transacao').AsString)
          else
            tipomov:=Q.FieldByName('pend_tipomov').asstring;
// 01.08.07
          if recpag='P' then
            FRel.AddCel( GetTipoCompra(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,tipomov) );

//          FRel.AddCel(Q.FieldByName('pend_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('pend_tipomov').AsString));
          FRel.AddCel(Tipomov+'-'+FGeral.GetTipoMovto(Tipomov));
          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('pend_fpgt_codigo').AsString));
          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('pend_port_codigo').AsString));
// 25.05.12 - Abra - comissoes para representantes geradas na venda contrato
          if (RecPag='P') and ( EdTipocad.text='R') and ( not EdCodTipo.isempty ) and (Global.Topicos[1278])
            then begin

            QTemp:=Sqltoquery('select pend_tipo_codigo,pend_tipocad from pendencias where pend_transbaixa='+Stringtosql(Q.fieldbyname('pend_transacao').asstring)+
                   ' and '+fGeral.GetIN('pend_tipomov',Global.CodContrato+';'+Global.CodContratoNota,'C')+
                   ' and pend_rp=''R'''+
                   ' and '+FGeral.GetIN('pend_status','B','C') );
            if QTemp.eof then begin
              FGeral.FechaQuery(Qtemp);
              QTemp:=Sqltoquery('select pend_tipo_codigo,pend_tipocad from pendencias where pend_transacao='+Stringtosql(Q.fieldbyname('pend_transacao').asstring)+
                   ' and '+fGeral.GetIN('pend_tipomov',Global.CodContrato+';'+Global.CodContratoNota,'C')+
                   ' and pend_rp=''R'''+
//                   and pend_tipocad<>''R'''+
                   ' and '+FGeral.GetIN('pend_status','P','C') );
            end;
            FRel.AddCel(QTemp.FieldByName('pend_tipo_codigo').AsString);
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QTemp.FieldByName('pend_tipo_codigo').AsInteger,QTemp.FieldByName('pend_tipocad').AsString,'R'));
            FGeral.FechaQuery(Qtemp);

          end else begin

            FRel.AddCel(Q.FieldByName('pend_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'N'));
// 08.06.07 - elize - novicarnes
// 23.04.18 - Giacomoni - Barbara
            if Global.Topicos[1297] then
              FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'N'))
            else
              FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'R'));
          end;
// 10.01.13 - vivan -bairro pra agilizar cobrança
          if ( (Global.Topicos[1285]) and (recpag='R') ) then
            FRel.AddCel(FCadcli.GetBairro(Q.FieldByName('pend_tipo_codigo').AsInteger));

// 09.04.09 - mama...
          if ( (Global.Topicos[1264]) ) and (recpag='R') then
            FRel.AddCel( GetDescricaoProdutos(Q.FieldByName('pend_transacao').AsString,FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'R')));

// 12.06.07
          if Recpag='R' then begin
            FRel.AddCel(Q.FieldByName('pend_repr_codigo').AsString);
            if Global.topicos[1292] then
              FRel.AddCel(Q.FieldByName('Clie_cida_codigo_res').AsString+'-'+FCidades.GetNome(Q.FieldByName('Clie_cida_codigo_res').AsInteger)+' - '+FGEral.Formatatelefone(Q.FieldByName('clie_foneres').AsString) )
// 24.04.17
//              FRel.AddCel(Q.FieldByName('Clie_cida_codigo_res').AsString+'-'+FCidades.GetNome(Q.FieldByName('Clie_cida_codigo_res').AsInteger) )
            else
              FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_repr_codigo').AsInteger,'R','N'));
          end else begin

            FRel.AddCel(Q.FieldByName('pend_plan_conta').AsString);
            FRel.AddCel(FPlano.GetDescricao(Q.FieldByName('pend_plan_conta').AsInteger));

          end;

          FRel.AddCel(Q.FieldByName('pend_datavcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_databaixa').AsString);
          FRel.AddCel(Q.FieldByName('pend_transbaixa').AsString);
// 25.09.07
          if Q.FieldByName('pend_status').AsString='P' then
            unidadebaixa:=GetUnidadeCaixabancos(Q.FieldByName('pend_transacao').AsString)
          else
            unidadebaixa:=GetUnidadeCaixabancos(Q.FieldByName('pend_transbaixa').AsString);
          FRel.AddCel(unidadebaixa);
// 03.08.06
          FRel.AddCel(Q.FieldByName('pend_observacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_nparcelas').AsString);
          FRel.AddCel(Q.FieldByName('pend_parcela').AsString);
          FRel.AddCel(Q.FieldByName('pend_status').AsString);
          vlrantecipa:=0;
          if pos(Q.fieldbyname('pend_status').asstring,'D;E')>0 then
            vlrantecipa:=(-1)*Q.FieldByName('pend_valor').Ascurrency
          else if Q.fieldbyname('pend_status').asstring='A' then begin
            vlrantecipa:=Q.FieldByName('pend_valor').Ascurrency
          end;
  //        if Q.FieldByName('pend_valor').Ascurrency=Q.FieldByName('pend_valortitulo').Ascurrency then
          valor:=Q.FieldByName('pend_valor').Asstring;
          valorx:=0;
  //        else
  //          valor:=Q.FieldByName('pend_valortitulo').Asstring;

          if ( (Rel='INC') or (Rel='BAI')  or (Rel='PEN') ) and (Global.Topicos[1367])  then begin

             QM:=sqltoquery('select move_equi_codigo,move_qtde,move_venda from movestoque where move_transacao='+
                           Stringtosql(Q.FieldByName('pend_transacao').AsString) );

// 27.09.2021 - A2z
             if recpag = 'R' then begin

               if ( GetEquipamentos(Q.FieldByName('pend_transacao').AsString,EdEqui_codigo.text) )
                  then

// 03.03.2023
                    FRel.AddCel( FGeral.Formatavalor(GetValorEquipamentos(Q.FieldByName('pend_transacao').AsString,EdEqui_codigo.text,strtofloat(valor)),f_cr) )

               else if ( EdEqui_codigo.isempty ) then

                    FRel.AddCel( valor )

               else

                  FRel.AddCel('');
//                  FRel.AddCel( valor );


  // 15.08.19
             end else if ( EdEqui_codigo.text=GetEquipamento(Q.FieldByName('pend_transacao').AsString) )
                or
                ( EdEqui_codigo.isempty )
               then begin


//                  if ( Qm.FieldByName('move_equi_codigo').AsString=GetEquipamento(Q.FieldByName('pend_transacao').AsString) )
//                     and
                    if  ( Qm.FieldByName('move_equi_codigo').AsString<>'' )
                     then begin

//                     FRel.AddCel( '' );
                     FRel.AddCel(valor);
// 04.11.19 // 28.09.2021

                  end else if (Rel='BAI') then // 25.05.2022 - saia zerado valores

                     FRel.AddCel(valor)

                  else if (Rel='PEN') then // 25.05.2022 - saia zerado valores

                     FRel.AddCel(valor)

                  else
// 28.09.2021
                     FRel.AddCel( '' );

             end else

               FRel.AddCel('');

          end else begin


            if (pos(Q.FieldByName('pend_status').AsString,'P')>0) and (Rel='PEN') then begin
              FRel.AddCel(formatfloat(f_cr,(-1)*texttovalor(valor)));
              valorx:=(-1)*texttovalor(valor);
            end else if (pos(Q.FieldByName('pend_status').AsString,'D')>0) and (Rel='PEN') then begin
              FRel.AddCel('');
            end else if (pos(Q.FieldByName('pend_status').AsString,'E')>0) and (Rel='BAI') then begin
              FRel.AddCel('');
              vlrantecipa:=texttovalor(valor);
            end else if (pos(Q.FieldByName('pend_status').AsString,'A;E')>0) then begin
              FRel.AddCel('');
            end else begin
              FRel.AddCel(valor);
              valorx:=texttovalor(valor);
            end;

         end;

// 31.05.11 - Abra
          if (Rel='BAI') and (Global.Topicos[1280]) and (RecPag='R') then begin

            QCom:=sqltoquery('select pend_valor,pend_databaixa from pendencias where'+
                             ' pend_transacao='+Stringtosql(Q.fieldbyname('pend_transbaixa').asstring)+
// 14.06.12
                             ' and pend_numerodcto='+Stringtosql(Q.fieldbyname('pend_numerodcto').asstring+Q.fieldbyname('pend_parcela').asstring)+
// 25.05.12
                             ' and pend_tipocad=''R''') ;
            vlrcomissao:=0;baixacomissao:=Texttodate('');percomissao:=0;
            if not QCom.eof then begin
              vlrcomissao:=QCom.fieldbyname('pend_valor').ascurrency;
              QCon:=sqltoquery('select moes_percomissao,moes_permargem from movesto where'+
                               ' moes_transacao='+Stringtosql(Q.fieldbyname('pend_transacao').asstring)+
                               ' and moes_status<>''C'''+
                               ' and '+FGeral.Getin('moes_tipomov',Global.CodContrato+';'+Global.CodContratoNota,'C') );
              if QCom.fieldbyname('pend_databaixa').asdatetime > Global.DataMenorBanco then
                baixacomissao:=QCom.fieldbyname('pend_databaixa').asdatetime;
              if not QCon.eof then
                percomissao:=QCon.fieldbyname('moes_percomissao').ascurrency;
              FGeral.FechaQuery(QCon);
            end;
            FGeral.FechaQuery(QCom);
            FRel.AddCel(floattostr(vlrcomissao));
            if baixacomissao>Global.DataMenorBanco then
              FRel.AddCel( Datetostr(baixacomissao) )
            else
              FRel.AddCel( '' );
            FRel.AddCel( floattostr(percomissao) );
          end;

          FRel.AddCel(floattostr(vlrantecipa));

// 26.06.13- Metalforte
          if (Rel='PEN') and (Global.topicos[1262]) then begin

            if (Q.FieldByName('pend_datavctoori').AsDateTime<=Q.FieldByName('pend_datavcto').AsDatetime) and (Q.FieldByName('pend_datavctoori').AsdateTime>0) then
              valorjuros:=FGeral.GetValorJuros(Q.FieldByName('pend_valor').Ascurrency,Q.FieldByName('pend_datavctoori').AsDateTime,sistema.hoje,Recpag)
            else
              valorjuros:=FGeral.GetValorJuros(Q.FieldByName('pend_valor').Ascurrency,Q.FieldByName('pend_datavcto').AsDateTime,sistema.hoje,Recpag);
            FRel.AddCel(floattostr(valorjuros));

          end else if (Rel='PEN') and (RecPag='P') then begin

            valorjuros:=FGeral.GetValorJuros(Q.FieldByName('pend_valor').Ascurrency,Q.FieldByName('pend_datavcto').AsDateTime,sistema.hoje,Recpag,
                                            Q.FieldByName('pend_dataemissao').AsDateTime,Q.FieldByName('pend_tipomov').AsString);
            FRel.AddCel(floattostr(valorjuros));

          end else

            FRel.AddCel(Q.FieldByName('pend_mora').AsString);

          FRel.AddCel(Q.FieldByName('pend_descontos').AsString);
// 28.09.2021 - só pra 'rastrear' o problema...
//          FRel.AddCel( '1212' );

// 09.04.09 - mama...
          if ( (Global.Topicos[1264]) ) and (recpag='R') then begin

            if vlrantecipa>0 then
              FRel.AddCel( Floattostr(vlrantecipa))
            else
              FRel.AddCel( Floattostr((-1)*Q.FieldByName('pend_valor').AsCurrency))

          end else

            FRel.AddCel('');
// 03.04.08
          if Global.Topicos[1105] then begin

            FRel.AddCel(Q.FieldByName('Clie_grupoinv').AsString);

          end;
// 07.06.06
          if Rel='BAI' then begin
            if Q.fieldbyname('pend_databaixa').asdatetime>Q.fieldbyname('pend_datavcto').asdatetime then
              FRel.AddCel(floattostr(Q.fieldbyname('pend_databaixa').asdatetime-Q.fieldbyname('pend_datavcto').asdatetime) )
            else
              FRel.AddCel('');
// 05.10.09
            if Q.fieldbyname('pend_databaixa').asdatetime>Q.fieldbyname('pend_dataemissao').asdatetime then
              FRel.AddCel(floattostr(Q.fieldbyname('pend_databaixa').asdatetime-Q.fieldbyname('pend_dataemissao').asdatetime) )
            else
              FRel.AddCel('');
          end;
// 19.10.12 - Vivan
          if Global.Topicos[1281] then begin
// 08.10.13 - Vivan
             if Q.FieldByName('pend_usubaixa').Asinteger>0 then begin
               FRel.AddCel(Q.FieldByName('pend_usubaixa').Asstring);
               FRel.AddCel(FUsuarios.getnome(Q.FieldByName('pend_usubaixa').Asinteger));
             end else if Q.FieldByName('pend_usua_codigo').Asinteger>0 then begin
               FRel.AddCel(Q.FieldByName('pend_usua_codigo').Asstring);
               FRel.AddCel(FUsuarios.getnome(Q.FieldByName('pend_usua_codigo').Asinteger));
             end else begin
               UsuarioBuscado:=BuscaCodigoUsuario(Q.FieldByName('pend_transacao').AsString);
               FRel.AddCel( inttostr(UsuarioBuscado)  );
               FRel.AddCel(FUsuarios.getnome(UsuarioBuscado));
             end;
          end;
// 26.06.13- Metalforte - valor com multa + juros
          if (Rel='PEN') and (Global.topicos[1262]) then

            FRel.AddCel(floattostr(Q.FieldByName('pend_valor').Ascurrency+valorjuros))

          else if (Rel='BAI') and (Global.topicos[1262]) then

            FRel.AddCel(floattostr(Q.FieldByName('pend_valor').Ascurrency+Q.FieldByName('pend_mora').Ascurrency
                                  -Q.FieldByName('pend_descontos').Ascurrency) );
// 09.09.14 - Vivan
          if (pos(Rel,'PEN')>0) and (Global.topicos[1291]) and (recpag='R') then

              FRel.AddCel(FGEral.FormataData( FCadcli.GetDatadeCadastro(Q.Fieldbyname('pend_tipo_codigo').asinteger) ) );
// 09.11.16 - Novi+Andre
          if (pos(Rel,'BAI')>0) and (Global.Usuario.Codigo=100) and ( Global.topicos[1045] ) then begin

            QC:=FGeral.SqlToQueryContax('select mcon_status from movcon where mcon_transacao='+stringtosql( GetTransContax(Q.fieldbyname('pend_transbaixa').asstring) ));
            FREl.AddCel(QC.fieldbyname('mcon_status').asstring);
            if QC.fieldbyname('mcon_status').asstring='C' then
              FGeral.SistemaContax.ExecuteDirect('Update movcon set mcon_status = ''N'' where mcon_transacao='+stringtosql(GetTransContax(Q.fieldbyname('pend_transbaixa').asstring) ));
            fGeral.FechaQuery(QC);

          end;
// 05.09.17 - Novicarnes
          if (pos(Rel,'INC')>0) and (Global.topicos[1294]) and ( recpag='P' ) then
             FREl.AddCel( GetCfop(Q.fieldbyname('pend_transacao').asstring) );

//          if (Rel='PEN') and (Q.FieldByName('pend_status').AsString='N') then
          if (Rel='PEN') and (Q.FieldByName('pend_status').AsString='N') then
            ChecaBaixaParcial(Q.FieldByName('pend_unid_codigo').AsString,Q.FieldByName('pend_tipo_codigo').AsString,Q.FieldByName('pend_tipocad').AsString,Q.FieldByName('pend_numerodcto').AsString,Q.FieldByName('pend_dataemissao').Asdatetime,
               Q.FieldByName('pend_datacont').Asdatetime,Q.FieldByName('pend_datavcto').Asdatetime,Q.FieldByName('pend_parcela').Asinteger,valorx);
//        end;
// 03.04.08
          if Global.Topicos[1105] then
            ChecaDependentes(Q.FieldByName('Clie_matricula').AsInteger,Q.FieldByName('Clie_codigo').AsInteger);
// 15.08.19
          if ( (Rel='INC') or (Rel='BAI')  or (Rel='PEN') ) and (Global.Topicos[1367])  then begin

//              QM:=sqltoquery('select move_equi_codigo,move_qtde,move_venda from movestoque where move_transacao='+
//                           Stringtosql(Q.FieldByName('pend_transacao').AsString) );

//              while (not QM.Eof ) and ( recpag='R') do begin
// 28.07.2022 - A2z lógico...rs
              while (not QM.Eof ) and ( recpag='R') and (Q.FieldByName('pend_status').AsString<>'B' ) do begin

                 if trim(QM.FieldByName('move_equi_codigo').AsString)<>'' then begin

                   if (QM.FieldByName('move_equi_codigo').AsString=EdEqui_codigo.Text) or
                      ( EdEqui_codigo.isempty )
                      then begin
                      vlrantecipa:=roundvalor(QM.FieldByName('move_qtde').AsCurrency*QM.FieldByName('move_venda').AsCurrency);
                      vlrantecipa:=vlrantecipa/Q.FieldByName('pend_nparcelas').AsCurrency;
                      if recpag='P' then

                         FGeral.PulalinhaRel(FRel.GCol.ColCount,25,valortosql(vlrantecipa),08,FEquipamentos.GetDescricao( QM.FieldByName('move_equi_codigo').AsString ))

                      else

//                         FGeral.PulalinhaRel(FRel.GCol.ColCount,24,valortosql(vlrantecipa),08,FEquipamentos.GetDescricao( QM.FieldByName('move_equi_codigo').AsString ));
// 27.09.2021 - A2z
//                         FGeral.PulalinhaRel(FRel.GCol.ColCount,24,valortosql(vlrantecipa),07,FEquipamentos.GetDescricao( QM.FieldByName('move_equi_codigo').AsString ));
// 19.04.2022 - A2z
//                         FGeral.PulalinhaRel(FRel.GCol.ColCount,FRel.GCol.ColCount-5,valortosql(vlrantecipa),FRel.GCol.ColCount-22,FEquipamentos.GetDescricao( QM.FieldByName('move_equi_codigo').AsString ));
// 28.07.2022
                         FGeral.PulalinhaRel(FRel.GCol.ColCount,FRel.GCol.ColCount-5,valortosql(vlrantecipa),FRel.GCol.ColCount-24,FEquipamentos.GetDescricao( QM.FieldByName('move_equi_codigo').AsString ));


                   end;

                end;

                QM.Next;

              end;
              FGeral.FechaQuery(QM);

          end;

          if ListaCodigos.indexof(Q.FieldByName('pend_tipo_codigo').AsString)=-1 then begin
            ListaCodigos.add(Q.FieldByName('pend_tipo_codigo').AsString);
            oscodigos:=oscodigos+Q.FieldByName('pend_tipo_codigo').AsString+';';
          end;

        end;  // esta valendo

        Q.Next;

      end;

// 06.05.10 - Damama  - buscar saldo de cada cliente impresso no relatorio
      if ( EdCodtipo.AsInteger=0 ) and ( Rel='PEN' ) and ( Global.Topicos[1275] ) then
         SaldoAntecipacoesTodos(ListaCodigos);

//08.03.07
//////////////////////////////////////////////////////
      FGeral.Fechaquery(q);
      if Recpag='R' then begin
        sqlrecpag:=' and pend_RP='+stringtosql('P');
        tipomovdev:=Global.CodDevolucaoVenda+';'+Global.CodPendenciaFinanceira;
        sqltipocad:=' and pend_tipocad='+stringtosql('C');
// 17.06.13 - Vivan - Angela
        if Global.Topicos[1261] then
          tipomovdev:='??'; // para nao considerar devolucoes
      end else begin
        sqlrecpag:=' and pend_RP='+stringtosql('R');
        tipomovdev:=Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemEstoque+';'+Global.CodPendenciaFinanceira;
        sqltipocad:=' and pend_tipocad='+stringtosql('F');
      end;
//      sqltipocad:='';
// 24.07.07 - senao mistura pendencias de cliente e fornecedor com o mesmo codigo
      if (trim(oscodigos)<>'') and (trim(oscodigos)<>';') then
        sqlcodtipo:=' and '+FGeral.Getin('pend_tipo_codigo',oscodigos,'N')
      else if EdCodtipo.asinteger>0 then
        sqlcodtipo:=' and '+FGeral.Getin('pend_tipo_codigo',EdCodtipo.text,'N')
      else
        sqlcodtipo:='';
// para dar eof
      if rel='INC' then
        tipomovdev:='X1'
      else if ( rel='PEN' ) and ( Global.Topicos[1275] ) then begin
        tipomovdev:='X1';
// 07.09.13 - Damama
        if (EdCodtipo.asinteger>0) and (EdTipocad.text='C') then
          if Edcodtipo.resultfind<>nil then
            if Edcodtipo.resultfind.fieldbyname('clie_situacao').asstring='F' then
              tipomovdev:=Global.CodPendenciaFinanceira;
      end;
      Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  sqlrecpag+
                  ' and '+FGeral.Getin('pend_tipomov',tipomovdev,'C')+
                  sqlunidade+
                  sqldatalan+
                  sqldatabai+
                  sqldatavenci+
                  sqldatacont+
                  sqlcodtipo+
                  sqltipocad+
                  sqlorder );

      while not Q.eof do begin

          FRel.AddCel(Q.FieldByName('pend_transacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_operacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_unid_codigo').AsString);
// 28.11.11 - Juliana
          if ( (Global.Topicos[1204]) and (recpag='P') ) then
            FRel.AddCel( '' );
// 18.06.19 - alutech - robson
          if ( (Global.Topicos[1365]) and (recpag='P') ) then
            FRel.AddCel( '' );

          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel(Q.FieldByName('pend_datacont').AsString);
          FRel.AddCel(Q.FieldByName('pend_numerodcto').AsString);
          tipomov:=Gettipomov(Q.FieldByName('pend_transacao').AsString);
// 15.12.2021
///////////////
          if ( (Rel='INC') or (Rel='BAI')  or (Rel='PEN') ) and (Global.Topicos[1367])  then begin

             if recpag = 'R' then begin

               if ( not GetEquipamentos(Q.FieldByName('pend_transacao').AsString,EdEqui_codigo.text) )
//                  or
//                  ( EdEqui_codigo.isempty )
                 then

                 FRel.AddCel( FEquipamentos.GetDescricao(GetEquipamento(Q.FieldByName('pend_transacao').AsString)) )

               else

                 FRel.AddCel('');

          end else   if ( EdEqui_codigo.text=GetEquipamento(Q.FieldByName('pend_transacao').AsString) )
                or
                ( EdEqui_codigo.isempty )
               then
               FRel.AddCel( FEquipamentos.GetDescricao(GetEquipamento(Q.FieldByName('pend_transacao').AsString)) )
             else
               FRel.AddCel('');

          end;

///////////////
// 01.08.07
          if recpag='P' then
            FRel.AddCel( GetTipoCompra(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,tipomov) );
//////////////////////
          FRel.AddCel(Tipomov+'-'+FGeral.GetTipoMovto(Tipomov));
          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('pend_fpgt_codigo').AsString));
          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('pend_port_codigo').AsString));
          FRel.AddCel(Q.FieldByName('pend_tipo_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'N'));
// 10.01.13 - vivan -bairro pra agilizar cobrança
          if ( (Global.Topicos[1285]) and (recpag='R') ) then
            FRel.AddCel(FCadcli.GetBairro(Q.FieldByName('pend_tipo_codigo').AsInteger));

          if ( (Global.Topicos[1264]) ) and (recpag='R') then
            FRel.AddCel( GetDescricaoProdutos(Q.FieldByName('pend_transacao').AsString,FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'N')));

// 12.06.07
          if Recpag='R' then begin
            FRel.AddCel(Q.FieldByName('pend_repr_codigo').AsString);
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_repr_codigo').AsInteger,'R','N'));
          end else begin
            FRel.AddCel(Q.FieldByName('pend_plan_conta').AsString);
            FRel.AddCel(FPlano.GetDescricao(Q.FieldByName('pend_plan_conta').AsInteger));
          end;

          FRel.AddCel(Q.FieldByName('pend_datavcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_databaixa').AsString);
          FRel.AddCel(Q.FieldByName('pend_transbaixa').AsString);
// 25.09.07
          if Q.FieldByName('pend_status').AsString='P' then
            unidadebaixa:=GetUnidadeCaixabancos(Q.FieldByName('pend_transacao').AsString)
          else
            unidadebaixa:=GetUnidadeCaixabancos(Q.FieldByName('pend_transbaixa').AsString);
          FRel.AddCel(unidadebaixa);
          FRel.AddCel(Q.FieldByName('pend_observacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_nparcelas').AsString);
          FRel.AddCel(Q.FieldByName('pend_parcela').AsString);
          if (Rel='BAI') and (Global.Topicos[1280]) and (RecPag='R') then begin
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
          end;

          FRel.AddCel(Q.FieldByName('pend_status').AsString);
          vlrantecipa:=0;
          if pos(Q.fieldbyname('pend_status').asstring,'D;E')>0 then
            vlrantecipa:=(-1)*Q.FieldByName('pend_valor').Ascurrency
          else if Q.fieldbyname('pend_status').asstring='A' then
            vlrantecipa:=(-1)*Q.FieldByName('pend_valor').Ascurrency;
  //        if Q.FieldByName('pend_valor').Ascurrency=Q.FieldByName('pend_valortitulo').Ascurrency then
//          valor:=Q.FieldByName('pend_valor').Asstring;
          valor:=valortosql( (-1)*Q.FieldByName('pend_valor').AsCurrency );
          valorx:=0;
  //        else
  //          valor:=Q.FieldByName('pend_valortitulo').Asstring;
          if (pos(Q.FieldByName('pend_status').AsString,'P')>0) and (Rel='PEN') then begin
            FRel.AddCel(formatfloat(f_cr,(-1)*texttovalor(valor)));
            valorx:=(-1)*texttovalor(valor);
          end else if (pos(Q.FieldByName('pend_status').AsString,'D')>0) and (Rel='PEN') then begin
            FRel.AddCel('');
          end else if (pos(Q.FieldByName('pend_status').AsString,'E')>0) and (Rel='BAI') then begin
            FRel.AddCel('');
            vlrantecipa:=texttovalor(valor);
          end else if (pos(Q.FieldByName('pend_status').AsString,'A;E')>0) then begin
            FRel.AddCel('');
          end else begin
            FRel.AddCel(valor);
            valorx:=texttovalor(valor);
          end;

          FRel.AddCel(floattostr(vlrantecipa));
          FRel.AddCel(Q.FieldByName('pend_mora').AsString);
          FRel.AddCel(Q.FieldByName('pend_descontos').AsString);
// 09.04.09 - mama... aqui em 22.10.09
          if ( (Global.Topicos[1264]) ) and (recpag='R') then begin

            if vlrantecipa>0 then
              FRel.AddCel( Floattostr(vlrantecipa))
            else
              FRel.AddCel( Floattostr((-1)*Q.FieldByName('pend_valor').AsCurrency))

          end else

            FRel.AddCel('');
// aqui em 01.06.11.. os 'grupos' do CTG...ninguem merece
          if Global.Topicos[1105] then
            FRel.AddCel('');

          if Rel='BAI' then begin
            if Q.fieldbyname('pend_databaixa').asdatetime>Q.fieldbyname('pend_datavcto').asdatetime then
              FRel.AddCel(floattostr(Q.fieldbyname('pend_databaixa').asdatetime-Q.fieldbyname('pend_datavcto').asdatetime) )
            else
              FRel.AddCel('');
// 05.10.09
            if Q.fieldbyname('pend_databaixa').asdatetime>Q.fieldbyname('pend_dataemissao').asdatetime then
              FRel.AddCel(floattostr(Q.fieldbyname('pend_databaixa').asdatetime-Q.fieldbyname('pend_dataemissao').asdatetime) )
            else
              FRel.AddCel('');
          end;
// 06.11.12
          if (Global.Topicos[1281])  then begin
            FRel.AddCel('');
            FRel.AddCel('');
          end;
// 26.06.13
          if (Global.Topicos[1262])  then begin
            FRel.AddCel('');
          end;
// 09.09.14 - Vivan
          if (pos(Rel,'PEN')>0) and (Global.topicos[1291]) and (recpag='R') then
            FRel.AddCel('');

        Q.Next;
      end;

////////////////////    end; // 'nada encontrado...'

///////////////////////////////////////////////////////
// busca os cheques recebidos do cliente..OU emitidos se for contas a pagar
//////////////////////////////////////////////////////
      FGeral.Fechaquery(q);
      if Recpag='R' then begin
        sqlrecpag:=' and cheq_emirec='+stringtosql('R');
        sqltipocad:=' and cheq_tipocad='+stringtosql('C');
      end else begin
// 18.06.14 - devido as cheques cadastrados mas nao emitidos
        sqlrecpag:=' and cheq_emirec='+stringtosql('E')+' and cheq_valor>0';
        sqltipocad:=' and cheq_tipocad='+stringtosql('F');
      end;
      if Edcodtipo.IsEmpty then
        sqlcodtipo:=''
      else begin
        if (trim(oscodigos)<>'') and (trim(oscodigos)<>';') then
          sqlcodtipo:=' and '+FGeral.Getin('cheq_tipo_codigo',oscodigos,'N')
        else
          sqlcodtipo:='';
// 17.09.09 - Abra - Joahne
        if (trim(oscodigos)<>'') and (trim(oscodigos)<>';') then
          sqlcodtipo:=' and '+FGeral.Getin('cheq_tipo_codigo',oscodigos,'N')
        else if EdCodtipo.asinteger>0 then
          sqlcodtipo:=' and '+FGeral.Getin('cheq_tipo_codigo',EdCodtipo.text,'N')
        else
          sqlcodtipo:='';
/////////////
      end;
      if ( not EdVencimentoi.IsEmpty ) and ( not EdVencimentof.IsEmpty ) then
        sqldatavenci:=' and cheq_predata>='+EdVencimentoi.AsSql+' and cheq_predata<='+EdVencimentof.AsSql
      else
        sqldatavenci:='';
      if Global.Usuario.OutrosAcessos[0701] then
        sqldatacont:=''
      else
//        sqldatacont:=' and cheq_datacont > 1';
// 26.04.10
        sqldatacont:=' and cheq_datacont > '+DateToSql(Global.DataMenorBanco);

//      if (EdBaixai.AsDate>1) and (EdBaixaf.AsDate>1)  and (rel='BAI') then begin
//        sqldatabai:=' and cheq_deposito>='+EdBaixai.AsSql+' and cheq_deposito<='+EdBaixaf.AsSql;
//      end else
//        sqldatabai:=' and cheq_deposito is not null';
      if rel='BAI' then
        sqldatabai:=' and cheq_deposito is not null';
// 03.08.07 - ver se quiser aparecer os cheques recebidos mas dai 'dobra' no relat. de baixadas
//            deixado para NAO sair...
// para dar eof
      if (rel='INC') or (Global.Topicos[1263] ) then
        sqlcodtipo:=' and '+FGeral.Getin('cheq_tipo_codigo','989898','N');
// 04.12.09 - Abra nao quer que sair no relat. os cheques
// para dar eof
      if (Global.Topicos[1271] ) then
        sqlcodtipo:=' and '+FGeral.Getin('cheq_tipo_codigo','989898','N');
      Q:=sqltoquery('select * from cheques'+
                  ' where '+FGeral.Getin('cheq_status','N','C')+
                  sqlrecpag+
                  ' and '+FGeral.GetIN('cheq_unid_codigo',EdUnid_codigo.text,'C')+
                  sqldatavenci+
                  sqldatabai+
                  ' and cheq_deposito is null '+
                  sqldatacont+
                  sqlcodtipo+
                  sqltipocad );
      while not Q.eof do begin
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel(Q.FieldByName('cheq_unid_codigo').AsString);
// 28.11.11 - Juliana
          if ( (Global.Topicos[1204]) and (recpag='P') ) then
            FRel.AddCel( '' );
// 18.06.19 - alutech - robson
          if ( (Global.Topicos[1365]) and (recpag='P') ) then
            FRel.AddCel( '' );

          FRel.AddCel(Q.FieldByName('cheq_lancto').AsString);
          FRel.AddCel(Q.FieldByName('cheq_emissao').AsString);
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel(Q.FieldByName('cheq_datacont').AsString);
          FRel.AddCel(Q.FieldByName('cheq_cheque').AsString);
// 02.08.07
          if recpag='P' then
            FRel.AddCel('');

          if Recpag='R' then begin
            FRel.AddCel('CH'+'-'+'Cheque recebido');
            FRel.AddCel('');
          end else begin
            FRel.AddCel('CH'+'-'+'Cheque emitido');
            FRel.AddCel(Q.FieldByName('Cheq_bcoemitente').AsString);
          end;
          FRel.AddCel('');
          FRel.AddCel(Q.FieldByName('cheq_tipo_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('cheq_tipo_codigo').AsInteger,Q.FieldByName('cheq_tipocad').AsString,'N'));
// 10.01.13 - vivan -bairro pra agilizar cobrança
          if ( (Global.Topicos[1285]) and (recpag='R') ) then
            FRel.AddCel('');

          FRel.AddCel(Q.FieldByName('cheq_repr_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('cheq_repr_codigo').AsInteger,'R','N'));
// 06.07.09
          if ( (Global.Topicos[1264]) ) and (recpag='R') then
            FRel.AddCel('');

          FRel.AddCel(Q.FieldByName('cheq_predata').AsString);
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel(Q.FieldByName('cheq_obs').AsString);
          FRel.AddCel('1');
          FRel.AddCel('1');
          FRel.AddCel(Q.FieldByName('cheq_status').AsString);
          valor:=valortosql( Q.FieldByName('cheq_valor').AsCurrency );
          FRel.AddCel(valor);
// 31.05.11
          if (Rel='BAI') and (Global.Topicos[1280]) and (RecPag='R') then begin
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
          end;

          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
// aqui em 01.06.11.. os 'grupos' do CTG...ninguem merece
          if Global.Topicos[1105] then
             FRel.AddCel('');
          if Rel='BAI' then begin
            FRel.AddCel('');
            FRel.AddCel('');
          end;
// 06.11.12 - Vivan
          if (Global.Topicos[1281])  then begin
            FRel.AddCel('');
            FRel.AddCel('');
          end;
// 26.06.13 - Metalnorte
          if (Global.Topicos[1262])  then begin
            FRel.AddCel('');
          end;
// 09.09.14 - Vivan
          if (pos(Rel,'PEN')>0) and (Global.topicos[1291]) and (recpag='R') then
            FRel.AddCel('');
        Q.Next;
      end;

///////////////////////////////////////////////////////

{
      if recpag='R' then
        FRel.Setsort('Cliente')
      else
        FRel.Setsort('Fornecedor');
//}
//    if not Q.eof then   // 07.08.07

      FRel.Video('','',0,cemail);

    Sistema.EndProcess('');
    ListaJaBaixadosBP.Free;
    Q.Close;
    Freeandnil(Q);
    FRelFinan_Pendencias(RecPag,Rel,Tp);

  end;
end;

procedure FRelFinan_Posicao(RecPag:string);     // 4
///////////////////////////////////////////////////////////////
var statusvalidos,titulo,sqlorder,sqlrecpag,sqltipocod,tipomovdev,sqltipocad,oscodigos,
    sqlcodtipo,
    contascpr,
    sqltiposnao  :string;
    Q,
    Qbx,
    Qc    :TSqlquery;
    valor:currency;
    ListaCodigos:TStringlist;

    function EContaCpr( xconta:integer ):boolean;
    ///////////////////////////////////////////////
    begin

      if AnsiPos( strzero(xconta,5),contascpr ) >0 then result:=true else result:=false;

    end;

    function EstaValendo:boolean;
    ////////////////////////////////////
    begin

      if Q.Fieldbyname('pend_datamvto').asdatetime>FRElfinan.EdDtPosicao.Asdate then
        result:=false    // 15.04.09
// 10.05.19 - nao considerar as CPR
      else if EcontaCPR( Q.FieldByName('pend_plan_conta').AsInteger ) then

           result:=false

// 10.03.20 - nao considerar as CPR  pelo tipo de movimento
      else if Q.FieldByName('pend_tipomov').AsString = Global.CodCedulaProdutoRural  then

           result:=false

      else if ( pos(Q.Fieldbyname('pend_status').asstring,'B;K')>0 ) and  (Q.Fieldbyname('pend_databaixa').asdatetime>FRElfinan.EdDtPosicao.Asdate ) and (Q.Fieldbyname('pend_databaixa').asdatetime>1) then
        result:=true
      else if ( pos(Q.Fieldbyname('pend_status').asstring,'B;K')>0 ) and  (Q.Fieldbyname('pend_databaixa').asdatetime<=FRElfinan.EdDtPosicao.Asdate ) and (Q.Fieldbyname('pend_databaixa').asdatetime>1) then begin
        result:=false;
// 03.04.09 - baixas clessi 'feitas depois mas cmo data igual do movto do titulo'...
//        if (Q.Fieldbyname('pend_status').asstring='K' )  and (Datetomes(Q.Fieldbyname('pend_datamvto').asdatetime)=Datetomes(FRElfinan.EdDtPosicao.Asdate))
//          and (DatetoAno(Q.Fieldbyname('pend_datamvto').asdatetime,true)=Datetoano(FRElfinan.EdDtPosicao.Asdate,true) ) then
//          result:=true;
// 15.04.09 - assim 'phode' baixas 'normais' no mesmo dia na novicarnes
// 05.09.06
      end else if (Q.Fieldbyname('pend_status').asstring='B' ) and (Q.Fieldbyname('pend_databaixa').asdatetime<1 ) then
        result:=false
// 24.05.07
      else if (Q.Fieldbyname('pend_status').asstring='K' ) and (Q.Fieldbyname('pend_databaixa').asdatetime<1 ) then
        result:=false
//      else if Q.Fieldbyname('pend_dataemissao').asdatetime>FRElfinan.EdDtPosicao.Asdate then
      else
        result:=true;
    end;

    function EstaValendoBx(xstatus:string):boolean;
    ////////////////////////////////////////////////
    begin
      if (Qbx.Fieldbyname('pend_databaixa').asdatetime>FRElfinan.EdDtPosicao.Asdate ) and (Qbx.Fieldbyname('pend_databaixa').asdatetime>1) then begin
//        result:=false
// 08.05.06
//        result:=true
// 24.09.07
//////////////////////////
//        if pos(xstatus,'N;K')>0 then
// 01.04.09
//        if pos(xstatus,'N')>0 then  // assim 'phode tudo'...
// 15.04.09
        if pos(xstatus,'N;K')>0 then
          result:=false
        else
          result:=true;
///////////////////
      end else if (Qbx.Fieldbyname('pend_databaixa').asdatetime<=FRElfinan.EdDtPosicao.Asdate ) and (Qbx.Fieldbyname('pend_databaixa').asdatetime>1) then begin
// 22.04.08
         if pos(Q.fieldbyname('pend_status').asstring,'B')>0 then begin
            if (Qbx.Fieldbyname('pend_databaixa').asdatetime<=FRElfinan.EdDtPosicao.Asdate ) then begin
              if (QBx.fieldbyname('pend_status').asstring='P') then   // 12.05.08-izonel+vanessa
                result:=false
              else
                result:=true
            end else
              result:=false;
         end else begin
// 22.04.06
            if Ansipos(xstatus,'B;K')>0 then begin

              result:=true;
// 08.11.2021 - Novicarnes - Simone - mesmo numero de doc. em anos diferentes com BP na mesma parcela..
              if  QBx.fieldbyname('pend_dataemissao').asdatetime < Q.fieldbyname('pend_dataemissao').asdatetime  then

                  result := false;

            end else if (xstatus='N') and (QBx.fieldbyname('pend_status').asstring='P') then begin  // 05.05.08-izonel

              result:=true;

            end else

              result:=false;
         end;
//      else if Q.Fieldbyname('pend_dataemissao').asdatetime>FRElfinan.EdDtPosicao.Asdate then
      end else if Qbx.Fieldbyname('pend_datamvto').asdatetime>FRElfinan.EdDtPosicao.Asdate then
        result:=false
      else
        result:=true;
    end;

    procedure ChecaBaixaParcial(unidade,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer;
              status:string;Baixa:TDatetime;Sinal:string='+');
              /////////////////////////////////////////////////////////////////////
    var sqlqtipo:string;

    begin
      if Datacont>1 then
//        sqlqtipo:=' and pend_datacont>1'
// 26.04.10
        sqlqtipo:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco)
      else
        sqlqtipo:=' and pend_datacont is null';

      QBx:=sqltoquery('select * from pendencias where '+FGeral.getin('pend_status','P','C')+' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
//                      ' and pend_databaixa>='+Datetosql(Data)+
// 02.04.09
//                      ' and pend_databaixa>'+FRelfinan.EdDtposicao.assql+   // 02.04.09
//                      ' and pend_databaixa>='+FRelfinan.EdDtposicao.assql+     //  15.04.09
//                      ' and pend_databaixa<='+FRelfinan.EdDtposicao.assql+   // 24.05.07
// retirado condição sobre a baixa em 15.04.09 pois tem baixas parcial antes e depois
// da data pedida q tem q considerar ora somando ora descontando
// retirado em 24.09.07
                      ' and pend_unid_codigo='+stringtosql(unidade)+
//                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      ' and pend_parcela='+inttostr(parcela)+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );

      while not Qbx.eof do begin

        if EstavalendoBX(status) then begin

            FRel.AddCel(QBx.FieldByName('pend_transacao').AsString);
            FRel.AddCel(QBx.FieldByName('pend_operacao').AsString);
            FRel.AddCel(QBx.FieldByName('pend_unid_codigo').AsString);
  //          FRel.AddCel(QBx.FieldByName('pend_datalcto').AsString);
            FRel.AddCel(QBx.FieldByName('pend_datamvto').AsString);
            if Global.Usuario.OutrosAcessos[0701] then
              FRel.AddCel(QBx.FieldByName('pend_datacont').AsString);
//            FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
// 08.11.2021 - Novicarnes - Simone - 2 notas com mesmo numero mas anos diferentes na emissao...
            FRel.AddCel(QBx.FieldByName('pend_dataemissao').AsString);

            FRel.AddCel(QBx.FieldByName('pend_numerodcto').AsString);
//            FRel.AddCel(FCondpagto.GetReduzido(QBx.FieldByName('pend_fpgt_codigo').AsString));
// 10.12.08
          FRel.AddCel(QBx.FieldByName('pend_plan_conta').AsString+'-'+FPlano.GetDescricao(QBX.FieldByName('pend_plan_conta').AsInteger));
            FRel.AddCel(FPortadores.GetDescricao(QBx.FieldByName('pend_port_codigo').AsString));
            FRel.AddCel(QBx.FieldByName('pend_tipocad').AsString);
            FRel.AddCel(QBx.FieldByName('pend_tipo_codigo').AsString);
  //          FRel.AddCel(FGeral.GetNomeTipoCad(QBx.FieldByName('pend_tipo_codigo').AsInteger,QBx.FieldByName('pend_tipocad').AsString));
//            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QBx.FieldByName('pend_tipo_codigo').AsInteger,QBx.FieldByName('pend_tipocad').AsString,'N'));
// 08.06.07
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QBx.FieldByName('pend_tipo_codigo').AsInteger,QBx.FieldByName('pend_tipocad').AsString,'R'));
  //          FRel.AddCel(QBx.FieldByName('pend_repr_codigo').AsString);
  //          FRel.AddCel(FGeral.GetNomeTipoCad(QBx.FieldByName('pend_repr_codigo').AsInteger,'R'));
  //          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QBx.FieldByName('pend_repr_codigo').AsInteger,'R','N'));

            FRel.AddCel(Qbx.FieldByName('pend_datavcto').AsString);
            FRel.AddCel(Qbx.FieldByName('pend_databaixa').AsString);
            FRel.AddCel('');
            FRel.AddCel(Qbx.FieldByName('pend_nparcelas').AsString);
            FRel.AddCel(QBx.FieldByName('pend_status').AsString);
            FRel.AddCel(Qbx.FieldByName('pend_parcela').AsString);
  //          FRel.AddCel(QBx.FieldByName('pend_transbaixa').AsString);
            if Sinal='+' then begin   // 14.04.08
              if status='B' then  begin
  //              if (baixa>1) and (baixa>FRElfinan.EdDtPosicao.Asdate) then
  // 03.07.06
                if (Qbx.FieldByName('pend_databaixa').AsDatetime>1) and (baixa<=FRElfinan.EdDtPosicao.Asdate) then
                  FRel.AddCel(formatfloat(f_cr,(-1)*texttovalor(Qbx.FieldByName('pend_valor').Asstring)))
                else
                  FRel.AddCel(formatfloat(f_cr,texttovalor(Qbx.FieldByName('pend_valor').Asstring)));

              end else
                FRel.AddCel(formatfloat(f_cr,(-1)*texttovalor(Qbx.FieldByName('pend_valor').Asstring)));
            end else begin
              if status='B' then  begin
                if (Qbx.FieldByName('pend_databaixa').AsDatetime>1) and (baixa<=FRElfinan.EdDtPosicao.Asdate) then
                  FRel.AddCel(formatfloat(f_cr,(+1)*texttovalor(Qbx.FieldByName('pend_valor').Asstring)))
                else
                  FRel.AddCel(formatfloat(f_cr,(-1)*texttovalor(Qbx.FieldByName('pend_valor').Asstring)));

              end else
                FRel.AddCel(formatfloat(f_cr,(+1)*texttovalor(Qbx.FieldByName('pend_valor').Asstring)));
            end;
            FRel.AddCel(Qbx.FieldByName('pend_mora').AsString);
            FRel.AddCel(Qbx.FieldByName('pend_descontos').AsString);
// 10.11.16
            FRel.addcel('');
          end;
          Qbx.next;
      end;
      Qbx.close;
      Freeandnil(Qbx);
    end;

    // 10.11.16
    function GetConta(tipo_codigo:Integer;tipo_cad:String):string;
    ///////////////////////////////////////////////////////////////
    var xconta:integer;
    begin
       if tipo_cad='F' then xconta:=FFornece.GetContaExp(tipo_codigo,copy(FRelFinan.EdUnid_codigo.text,1,3))
       else xconta:=FCadcli.GetContaExp(tipo_codigo,copy(FRelFinan.EdUnid_codigo.text,1,3));
       if xconta>0 then
         result:=inttostr(xconta)
       else
         result:='';
    end;



begin
/////////////////////////////////////////////////////////////

  with FRelFinan do begin

    if not FRelFinan_Execute(4,Recpag) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    sqlrecpag:=' and pend_RP='+stringtosql(Recpag);
    if RecPag='R' then begin
      titulo:='Relatório de Recebimentos - ';
    end else begin
      titulo:='Relatório de Pagamentos - ';
    end;
//    statusvalidos:='N;A;B';
// 28.04.05
//    statusvalidos:='N;B';  // leila em 28.07.05 - nao sai as antecipaçoes neste relat.   até q mudem..psss..
// 24.05.07
    statusvalidos:='N;B;K';
    titulo:=titulo+'Posição Financeira em '+FGeral.FormataData(EdDtposicao.asdate);
    sqlorder:=' order by pend_unid_codigo,pend_tipo_codigo,pend_dataemissao,pend_numerodcto';
    sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C');
    if EdCodtipo.Asinteger>0 then
      sqltipocod:=' and ( (pend_tipo_codigo='+EdCodtipo.assql+') and (pend_tipocad='+EdTipocad.Assql+') )'
    else
      sqltipocod:='';

// 22.05.19
    QC:=sqltoquery('select plan_conta from plano where plan_tipo = ''P''' );
    contascpr:='';
    while not Qc.Eof do begin
       contascpr:=contascpr + strzero( QC.FieldByName('plan_conta').AsInteger,5) + ';';
       Qc.Next;
    end;
    Qc.Close;
// 06.09.19 - Novicarnes - simone
    sqltiposnao:='';
    if RecPag='R' then
       sqltiposnao := ' and '+FGeral.GetNOTIN('pend_tipomov',Global.CodDevolucaoCompra,'C');

    Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  sqltiposnao+
                  sqlrecpag+
                  sqlunidade+
                  sqldatacont+  // 24.03.06
                  sqltipocod+
                  sqlorder );


    ListaCodigos:=TStringlist.create;
    oscodigos:='';
    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      FRel.Init('RelPosicaoFin');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      if not EdCodtipo.isempty then
        FRel.Addtit('Codigo :'+EdCodtipo.text+' - '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipocad.text,'N') );
//      FRel.AddTit(Periodo);
      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'       ,''         ,'',false);
      FRel.AddCol( 80,0,'C','' ,''              ,'OPeracao'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Lançamento'      ,''         ,'',false);
      if Global.Usuario.OutrosAcessos[0701] then
         FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
//      FRel.AddCol( 80,0,'C','' ,''              ,'Forma Pagto'     ,''         ,'',false);
// 10.12.08
      FRel.AddCol( 110,0,'C','' ,''              ,'Conta      '     ,''         ,'',false);
      FRel.AddCol( 60,0,'C','' ,''              ,'Portador'        ,''         ,'',false);
      FRel.AddCol( 40,0,'C','' ,''              ,'Tipo'            ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      FRel.AddCol( 55,1,'D','' ,''              ,'Vencim.'         ,''         ,'',false);
      FRel.AddCol( 55,1,'D','' ,''              ,'Baixa'           ,''         ,'',false);
      FRel.AddCol( 40,0,'C','' ,''              ,'Tipo Mov'        ,''         ,'',False);
      FRel.AddCol( 30,2,'N','' ,''              ,'NP'              ,''         ,'',False);
      FRel.AddCol( 50,2,'C','' ,''              ,'Antec./Bx Parc.' ,''         ,'',False);
      FRel.AddCol( 30,2,'N','' ,''              ,'Parc'            ,''         ,'',False);
      FRel.AddCol( 70,3,'N','+' ,f_cr           ,'Parcela'         ,''         ,'',False);
      FRel.AddCol( 70,3,'N','+' ,f_cr           ,'Mora'            ,''         ,'',False);
      FRel.AddCol( 70,3,'N','+' ,f_cr           ,'Desconto'        ,''         ,'',False);
//
      FRel.AddCol( 70,3,'C',''  ,''            ,'Reduzido'        ,''         ,'',False);

      while not Q.eof do begin

        if Estavalendo then begin

          FRel.AddCel(Q.FieldByName('pend_transacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_operacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_unid_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_datamvto').AsString);
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel(Q.FieldByName('pend_datacont').AsString);
          FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
          FRel.AddCel(Q.FieldByName('pend_numerodcto').AsString);
//          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('pend_fpgt_codigo').AsString));
// 10.12.08
          FRel.AddCel(Q.FieldByName('pend_plan_conta').AsString+'-'+FPlano.GetDescricao(Q.FieldByName('pend_plan_conta').AsInteger));
          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('pend_port_codigo').AsString));
          FRel.AddCel(Q.FieldByName('pend_tipocad').AsString);
          FRel.AddCel(Q.FieldByName('pend_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'N'));
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'R'));
          FRel.AddCel(Q.FieldByName('pend_datavcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_databaixa').AsString);
          FRel.AddCel(Q.FieldByName('pend_tipomov').AsString);
          FRel.AddCel(Q.FieldByName('pend_nparcelas').AsString);
          FRel.AddCel(Q.FieldByName('pend_status').AsString);
          FRel.AddCel(Q.FieldByName('pend_parcela').AsString);
          valor:=Q.FieldByName('pend_valor').ascurrency;
// 14.10.05 - retirado em 11.11.05
//          if (Q.fieldbyname('pend_status').asstring='B')  then
//            valor:=Q.FieldByName('pend_valortitulo').ascurrency;

//          if Q.fieldbyname('pend_status').asstring='A' then
//            valor:=(-1)*Q.FieldByName('pend_valor').ascurrency;

          FRel.AddCel(floattostr(valor));
          FRel.AddCel(Q.FieldByName('pend_mora').AsString);
          FRel.AddCel(Q.FieldByName('pend_descontos').AsString);
// 10.11.16
          FRel.AddCel( GetConta(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString) );

          if pos(Q.FieldByName('pend_status').AsString,'N;B;K')>0 then
            ChecaBaixaParcial(Q.FieldByName('pend_unid_codigo').AsString,Q.FieldByName('pend_tipo_codigo').AsString,Q.FieldByName('pend_tipocad').AsString,Q.FieldByName('pend_numerodcto').AsString,Q.FieldByName('pend_dataemissao').Asdatetime,
                 Q.FieldByName('pend_datacont').Asdatetime,Q.FieldByName('pend_datavcto').Asdatetime,Q.FieldByName('pend_parcela').Asinteger,
                 Q.fieldbyname('pend_status').asstring,Q.FieldByName('pend_databaixa').Asdatetime);
//        end  else begin
// 22.04.08 - clessi - pendencia baixada em 30.11.07 com duas BPs depois disso na posicao de 30.11 nao aparece e nem busca as BPs
//           if ( pos(Q.Fieldbyname('pend_status').asstring,'B;K')>0 ) and ( Q.FieldByName('pend_databaixa').asdatetime<=FRElfinan.EdDtPosicao.Asdate ) then
//             ChecaBaixaParcial(Q.FieldByName('pend_unid_codigo').AsString,Q.FieldByName('pend_tipo_codigo').AsString,Q.FieldByName('pend_tipocad').AsString,Q.FieldByName('pend_numerodcto').AsString,Q.FieldByName('pend_dataemissao').Asdatetime,
//                 Q.FieldByName('pend_datacont').Asdatetime,Q.FieldByName('pend_datavcto').Asdatetime,Q.FieldByName('pend_parcela').Asinteger,
//                 'L',Q.FieldByName('pend_databaixa').Asdatetime,'-');
// 18.08.08 - retirado pois fica 'lento' - iso - novicarnes
        end;
        Q.Next;
// 14.04.08
        if ListaCodigos.indexof(Q.FieldByName('pend_tipo_codigo').AsString)=-1 then begin
            ListaCodigos.add(Q.FieldByName('pend_tipo_codigo').AsString);
            oscodigos:=oscodigos+Q.FieldByName('pend_tipo_codigo').AsString+';';
        end;
      end;
///////////////////////////// - 14.04.08
      FGeral.Fechaquery(q);
      if Recpag='R' then begin
        sqlrecpag:=' and pend_RP='+stringtosql('P');
        tipomovdev:=Global.CodDevolucaoVenda+';'+Global.CodPendenciaFinanceira+';'+
                    Global.CodDevolucaoCompraProdutor+';'+   // 28.02.19 - Simone- Novicarnes
                    Global.CodDevolucaoIgualVenda;         // 10.01.20 - Simone- Novicarnes
        sqltipocad:=' and pend_tipocad='+stringtosql('C');
// 08.01.09 - Novicarnes - Vanessa
        if Global.Topicos[1261] then
          tipomovdev:='??'; // para nao considerar devolucoes
      end else begin
        sqlrecpag:=' and pend_RP='+stringtosql('R');
        tipomovdev:=Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemEstoque+';'+Global.CodPendenciaFinanceira;
// 30.04.09 - Novicarnes - Vanessa
        if Global.Topicos[1261] then
          tipomovdev:='??'; // para nao considerar devolucoes
        sqltipocad:=' and pend_tipocad='+stringtosql('F');
      end;

//      sqltipocad:='';
// 24.07.07 - senao mistura pendencias de cliente e fornecedor com o mesmo codigo
      if (trim(oscodigos)<>'') and (trim(oscodigos)<>';') then
        sqlcodtipo:=' and '+FGeral.Getin('pend_tipo_codigo',oscodigos,'N')
      else if EdCodtipo.asinteger>0 then
        sqlcodtipo:=' and '+FGeral.Getin('pend_tipo_codigo',EdCodtipo.text,'N')
      else
        sqlcodtipo:='';
// para dar eof
//      if rel='INC' then
//        tipomovdev:='X1';  //

      Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  sqlrecpag+
                  ' and '+FGeral.Getin('pend_tipomov',tipomovdev,'C')+
                  sqlunidade+
                  sqldatalan+
                  sqldatabai+
                  sqldatavenci+
                  sqldatacont+
                  sqlcodtipo+
                  sqltipocad+
                  sqlorder );
      while not Q.eof do begin
        if Estavalendo then begin
          FRel.AddCel(Q.FieldByName('pend_transacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_operacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_unid_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_datamvto').AsString);
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel(Q.FieldByName('pend_datacont').AsString);
          FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
          FRel.AddCel(Q.FieldByName('pend_numerodcto').AsString);
          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('pend_fpgt_codigo').AsString));
          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('pend_port_codigo').AsString));
          FRel.AddCel(Q.FieldByName('pend_tipocad').AsString);
          FRel.AddCel(Q.FieldByName('pend_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'N'));
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'R'));
          FRel.AddCel(Q.FieldByName('pend_datavcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_databaixa').AsString);
          FRel.AddCel(Q.FieldByName('pend_tipomov').AsString);
          FRel.AddCel(Q.FieldByName('pend_nparcelas').AsString);
          FRel.AddCel(Q.FieldByName('pend_status').AsString);
          FRel.AddCel(Q.FieldByName('pend_parcela').AsString);
          valor:=(-1)*Q.FieldByName('pend_valor').ascurrency;
          FRel.AddCel(floattostr(valor));
          FRel.AddCel(Q.FieldByName('pend_mora').AsString);
          FRel.AddCel(Q.FieldByName('pend_descontos').AsString);
// 10.11.16
          FRel.addcel('');
          if pos(Q.FieldByName('pend_status').AsString,'N;B;K')>0 then
            ChecaBaixaParcial(Q.FieldByName('pend_unid_codigo').AsString,Q.FieldByName('pend_tipo_codigo').AsString,Q.FieldByName('pend_tipocad').AsString,Q.FieldByName('pend_numerodcto').AsString,Q.FieldByName('pend_dataemissao').Asdatetime,
                 Q.FieldByName('pend_datacont').Asdatetime,Q.FieldByName('pend_datavcto').Asdatetime,Q.FieldByName('pend_parcela').Asinteger,
                 Q.fieldbyname('pend_status').asstring,Q.FieldByName('pend_databaixa').Asdatetime,'-');
        end;
        Q.Next;
      end;
//////////////////////////////////////////////////

      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);
  end;
  FRelFinan_Posicao(Recpag);
end;

procedure TFRelFinan.FormActivate(Sender: TObject);
begin
  if FRelFinan=nil then FGeral.CreateForm(TFRelFinan, FRelFinan);
  if EdUnid_codigo.enabled then
    EdUnid_codigo.setfocus
  else
    EdLancai.setfocus;
end;

procedure TFRelFinan.baplicarClick(Sender: TObject);
begin
  if not EdUnid_codigo.ValidEdiAll(FRelFinan,99) then exit;
  Saiok:=true;
  Close;

end;

procedure TFRelFinan.Edunid_codigoValidate(Sender: TObject);
begin
  if trim(EdUnid_codigo.Text)='' then
    EdUnid_codigo.Text:=Global.Usuario.UnidadesRelatorios;

end;

procedure TFRelFinan.EdTipocadValidate(Sender: TObject);
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
  end else if EdTipoCad.text='S' then begin
    EdCodtipo.ShowForm:='FRepresentantes';
    EdCodtipo.FindTable:='representantes';
    EdCodtipo.FindField:='repr_codigo';
  end else begin
    EdCodtipo.ShowForm:='';
    EdCodtipo.FindTable:='';
    EdCodtipo.FindField:='';
  end;

end;

procedure TFRelFinan.EdCodtipoValidate(Sender: TObject);
begin
  if EdCodtipo.AsInteger>0 then begin
//    SetEdFavorecido.Text:=FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipoCad.text,'N');
//    if trim(SetEdFavorecido.Text)='' then
//      EdCodTipo.Invalid('Não encontrado');
    EdCodtipo.enabled:=true;
  end;
//    SetEdFavorecido.Text:='';
//    EdCodtipo.text:='';
//    EdCodtipo.enabled:=false;
//  end;

end;


/////////////////////////////////////
procedure FRelFinan_ImpNfsaida;     // 5
/////////////////////////////////////
var Q:Tsqlquery;
    ListaBases:TStringlist;
begin
  with FRelFinan do begin
    Q:=sqltoquery('select moes_numerodoc from movesto where moes_transacao='+stringtosql(Global.UltimaTransacao)+
                  ' and moes_status<>''C'' and '+FGeral.GetIN('moes_tipomov',Global.TiposRelVenda+';'+Global.CodCompraProdutor,'C') );
    if not Q.eof then
      EdNumerodoc.setvalue( Q.fieldbyname('moes_numerodoc').asinteger );
    FGeral.fechaquery(Q);
    if not FRelFinan_Execute(5) then Exit;
    if (EdTipomov.text=Global.CodPrestacaoServicos) and not Global.Topicos[1332] then
      FImpressao.ImprimeNotaSaidaMO(EdNumerodoc.asinteger,EdDtEmissao.AsDate,copy(EdUnid_codigo.text,1,3),EdTipomov.text)
    else
      FImpressao.ImprimeNotaSaida(EdNumerodoc.asinteger,EdDtEmissao.AsDate,copy(EdUnid_codigo.text,1,3),EdTipomov.text,EdNumerodocf.asinteger);
// 17.08.05
//////////    FRelFinan_ImpNfsaida;
//  21.02.13 - vamos ver a 'reinacao...'
    if not Global.Topicos[1006] then
      FRelFinan_ImpNfsaida
    else begin
{
       if FConfdcto.tpimpressora='V' then begin
         ListaBases:=TStringlist.create;
         ListaBases.AddStrings(FConfdcto.Texto.Lines);
         FVisualizaImpressao.Show;
         FVisualizaImpressao.Execute(ListaBases,fConfdcto.Impressora)
       end;
}
    end;
  end;
end;


procedure FRelFinan_ImpNfTransf;     // 6
///////////////////////////////////////////
begin
  with FRelFinan do begin
    if not FRelFinan_Execute(6) then Exit;
    FImpressao.ImprimeNotaTransf(EdNumerodoc.asinteger,EdDtEmissao.AsDate,copy(EdUnid_codigo.text,1,3),EdTipomov.text);
  end;
end;


//////////////////////////////////////
procedure FRelFinan_Faturamento;     // 7
//////////////////////////////////////
var statusvalidos,titulo,sqlorder,sqltipocod,sqltipomov,tiposmov,tiposvenda,tiposdev,checar,
    sqlsetor,titsetores,
    sqlequipamentos,
    titequipamento   :string;
    Q,
    QMovFin,
    QM               :TSqlquery;
    avista,aprazo,devolucao,
    porsetor,
    avistaq,
    aprazoq :currency;
    ListaDifCaixa,ListaValor,
    Lista,
    ListaSetores     :TStringlist;
    p:integer;

    function Atocooperado(xcodigo:integer):boolean;
    ///////////////////////////////////////////////
    var Qc:TSqlquery;
    begin
      result:=true;
      if Global.Topicos[1226] then begin
        Qc:=sqltoquery('select clie_ativo from clientes where clie_codigo='+inttostr(xcodigo));
        if not Qc.eof then result:=(Qc.fieldbyname('clie_ativo').AsString='S') else result:=false;
        FGeral.FechaQuery(Qc);
      end;
    end;

// 02.07.19
    function EquipamentoOK( xcodequi:string):boolean;
    /////////////////////////////////////////////////
    begin

//       if not FRelFinan.edEqui_codigo.isempty then begin

//          result:=(FRelFinan.EdEqui_codigo.text=xcodequi)


//       end else result:=true;

        result:=true;  // 14.08.19 - prevendo mais de um equipamento por nf de saida

    end;

// 07.07.20
////////////
    function GetQtde( xt:string ):currency;
    /////////////////////////////////////////
    var Qq : TSqlquery;
    begin

        Qq :=Sqltoquery( 'select sum(move_qtde) as move_qtde from movestoque where move_transacao = '+Stringtosql(xt));
        result := Qq.fieldbyname('move_qtde').ascurrency;
        FGeral.FechaQuery(qq);

    end;



begin
//////////////////
  with FRelFinan do begin

    if not FRelFinan_Execute(7) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
//    statusvalidos:='N;E';
// 28.09.14 - Vivan
    statusvalidos:='N;E;D';
//    sqlorder:=' order by moes_unid_codigo,moes_dataemissao,moes_tipo_codigo,moes_numerodoc';
    sqlorder:=' order by moes_unid_codigo,moes_dataemissao,moes_numerodoc';
    sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
    if EdCodtipo.Asinteger>0 then begin
      if Edtipocad.text='R' then
        sqltipocod:=' and moes_repr_codigo='+EdCodtipo.assql
      else if Edtipocad.text='S' then
        sqltipocod:=' and '+FGeral.Getin('moes_repr_codigo',FRepresentantes.GetCodigosRepres(EdCodtipo.asinteger),'N')
      else
        sqltipocod:=' and ( (moes_tipo_codigo='+EdCodtipo.assql+') and (moes_tipocad='+EdTipocad.Assql+') )';
    end else
      sqltipocod:='';
    if EdTiposmov.isempty then begin
      tiposmov:=Global.CodRemessaConsig+';'+Global.CodTransfEntrada+';'+
                Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodRemessaProntaEntrega+';'+Global.CodSimplesRemessa+';'+
                Global.CodDevolucaoSimbolicaConsig;  // 22.05.14
      Tiposvenda:=Global.TiposRelVenda;
//      Global.CodVendaConsig+';'+global.CodVendaDireta+';'+global.CodVendaProntaEntrega+';'+global.CodVendaSemMovEstoque+';'+
//                  global.CodVendaMagazine+';'+global.CodVendaInternet+';'+Global.CodVendaProntaEntregaFecha+';'+Global.CodVendaPecaProblema+
//                  ';'+global.CodVendaREFinal+';'+global.CodVendaRE+';'+Global.codvendaambulante+';'+Global.CodVendaConsigMercantil;
      Tiposdev:=Global.TiposRelDevVenda;
    end else begin
      tiposmov:='';
      tiposvenda:=EdTiposmov.text;
      statusvalidos:='N;E;D';

    end;

////';'+global.CodVendaSerie4+

    if trim(tiposmov)<>'' then
      sqltipomov:='and '+FGeral.GetNOTIN('moes_tipomov',tiposmov,'C')
    else
      sqltipomov:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and moes_datacont > 1';
// 26.04.10
      sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);

// 27.08.13
    sqlsetor:='';
    titsetores:='';
    if (Global.Topicos[1365]) and (not EdSeto_codigo.IsEmpty) then begin
       sqlsetor:='and moes_Seto_codigo='+EdSeto_codigo.AsSql;
       titsetores:=' - '+FSetores.GetDescricao(Edseto_codigo.text)
    end;

// 02.07.19
    titequipamento:='';
    if not EdEqui_codigo.IsEmpty then  begin
       titequipamento:='Máquina/Veículo : '+EdEqui_codigo.Text+' - '+EdEqui_codigo.ResultFind.fieldbyname('equi_descricao').AsString;
    end;

    titulo:='Faturamento de '+FGeral.FormataData(Edlancai.asdate)+' a '+FGeral.FormataData(Edlancaf.asdate)+
            ' - Tipos Impressos: '+TiposVenda+';'+TiposDev ;

    titsetores:='';
    if (Global.Topicos[1365]) and (not EdSeto_codigo.IsEmpty) then begin
       sqlsetor:='and '+FGeral.getin('moes_Seto_codigo',EdSeto_codigo.Text+';'+'9999','C');
       titsetores:=' - Setor/Obra:'+FSetores.GetDescricao(Edseto_codigo.text)
    end;

    Q:=sqltoquery('select * from movesto'+
                  ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                  ' and moes_datamvto>='+Edlancai.AsSql+' and moes_datamvto<='+Edlancaf.AsSql+
                  sqlunidade+
                  sqltipocod+
                  sqltipomov+
                  sqldatacont+
                  sqlsetor+
                  ' and '+FGeral.getin('moes_tipomov',tiposvenda+';'+tiposdev,'C')+
                  sqlorder );

    ListaDifCaixa:=TStringlist.create;
    ListaValor:=TStringlist.create;

    if Q.Eof then

      Avisoerro('Nada encontrado para impressão')

    else begin

      FRel.Init('RelFaturamento');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text)+titsetores);
      FRel.AddTit(titequipamento);
      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'       ,''         ,'',false);
      FRel.AddCol( 80,0,'C','' ,''              ,'OPeracao'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
      FRel.AddCol( 70,1,'D','' ,''              ,'Lançamento'      ,''         ,'',false);
      FRel.AddCol( 70,2,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      FRel.AddCol( 70,2,'D','' ,''              ,'Saida'           ,''         ,'',false);
      FRel.AddCol( 55,2,'C','' ,''              ,'Mes/ano'         ,''         ,'',false);
      FRel.AddCol( 70,2,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
      FRel.AddCol( 60,1,'C','' ,''              ,'Status'          ,''         ,'',False);
      FRel.AddCol( 40,0,'C','' ,''              ,'CFOP'            ,''         ,'',False);
      FRel.AddCol( 120,1,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
//      FRel.AddCol( 80,0,'C','' ,''              ,'Forma Pagto'     ,''         ,'',false);
//      FRel.AddCol( 90,0,'C','' ,''              ,'Portador'        ,''         ,'',false);
      if Global.Topicos[1465] then begin

        FRel.AddCol( 50,0,'C','' ,''              ,'Placa'          ,''         ,'',false);
        FRel.AddCol( 45,0,'C','' ,''              ,'Codigo'          ,''         ,'',false);
        FRel.AddCol(150,0,'C','' ,''              ,'Descrição'            ,''         ,'',false);

      end else begin

        FRel.AddCol( 60,0,'C','' ,''              ,'Tipo'            ,''         ,'',false);
        FRel.AddCol( 45,0,'C','' ,''              ,'Codigo'          ,''         ,'',false);
        FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);

      end;

      FRel.AddCol( 45,0,'C','' ,''              ,'Cod.repres.'     ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome repres.'    ,''         ,'',false);
      if Global.topicos[1473] then begin

         FRel.AddCol(080,3,'N','+',f_cr            ,'Qtde a Vista'   ,''         ,'',false);

      end;

      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor a Vista'   ,''         ,'',false);
      if Global.topicos[1473] then begin

         FRel.AddCol(080,3,'N','+',f_cr            ,'Qtde a Prazo'   ,''         ,'',false);

      end;

      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor a Prazo'   ,''         ,'',false);
//      if (Global.CodigoUnidade=global.unidadematriz) or (Global.CodigoUnidade='888') then
//        FRel.AddCol( 30,0,'C','' ,''              ,'Checar'          ,''         ,'',false);

      if Global.topicos[1473] then begin

         FRel.AddCol(080,3,'N','+',f_cr            ,'Qtde Total'     ,''         ,'',false);
         FRel.AddCol(080,3,'N','',f_cr            ,'Unitário'       ,''         ,'',false);

      end;


      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor Total'     ,''         ,'',false);

      FRel.AddCol(080,3,'N','+',f_cr            ,'Devoluções'      ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Total Líquido'   ,''         ,'',false);
// 06.01.14 - Patoterra
      if ( global.topicos[1367] ) then
        FRel.AddCol(180,1,'C','' ,''              ,'Equipamento'          ,''         ,'',False);
// 01.08.19 - Alutech
      if (Global.Topicos[1365]) then begin
        FRel.AddCol(070,3,'N','' ,''              ,'Cod.'           ,''         ,'',false);
        FRel.AddCol(120,1,'C','' ,''              ,'Setor/Obra'      ,''         ,'',false);
      end;

// 10.12.14 - Casa Nova - Cuiaba
      if ( global.topicos[1380] ) then
        FRel.AddCol(100,1,'C','' ,''              ,'Nome Obra'          ,''         ,'',False);
      FRel.AddCol(050,3,'N','+',''              ,'Nro.Clientes'    ,''         ,'',False);
      FRel.AddCol(100,1,'C','' ,''              ,'Cidade'          ,''         ,'',False);
      FRel.AddCol( 40,1,'C','' ,''              ,'Estado'          ,''         ,'',False);
      FRel.AddCol( 80,3,'C','' ,''              ,'População'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','' ,''              ,'Cod usuário'  ,''         ,'',False);
      FRel.AddCol(100,1,'C','' ,''              ,'Nome Usuário'  ,''         ,'',False);
//    if (pos(Global.CodVendaSerie4,Edtipomov.text)>0)  or  (pos(Global.CodVendaRE,Edtipomov.text)>0) or
//       (pos(Global.CodDevolucaoSerie5,Edtipomov.text)>0) then begin
        FRel.AddCol(080,3,'N','+',f_cr            ,'Subst.Trib.Venda'    ,''         ,'',false);
        FRel.AddCol(080,3,'N','+',f_cr            ,'Subst.Trib.Devolução',''         ,'',false);
        FRel.AddCol(080,3,'N','+',f_cr            ,'Valor IPI'           ,''         ,'',false);
//    end;
// 01.08.11 - Capeg
      if FGeral.GetConfig1AsString('Impromremaordem')<>'' then
        FRel.AddCol(100,1,'C','' ,''              ,'Transportador'       ,''         ,'',False);
      while not Q.eof do begin
// 11.03.15
        if  ( Atocooperado(Q.FieldByName('moes_tipo_codigo').AsInteger) ) and
// 02.07.19
            ( EquipamentoOK(GetEquipamento(Q.FieldByName('moes_transacao').AsString)) )

          then begin

          FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
          FRel.AddCel(Q.FieldByName('moes_operacao').AsString);
          FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
          FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
// 11.06.13
          FRel.AddCel(Q.FieldByName('moes_datasaida').AsString);
          FRel.AddCel( FormatDateTime('mm/yyyy',Q.FieldByName('moes_dataemissao').AsDateTime) );
          FRel.AddCel(Q.FieldByName('moes_datacont').AsString);
          FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('moes_status').AsString);
          FRel.AddCel(Q.FieldByName('moes_natf_codigo').AsString);
// 25.03.14
          if (pos(Q.FieldByName('moes_tipomov').AsString,Global.CodRemessaConsig)>0) and (Q.FieldByName('moes_rcmagazine').AsString='S') then
            FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-Remessa Magazine')
          else if (pos(Q.FieldByName('moes_tipomov').AsString,Global.CodRemessaConsig)>0)  then
            FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString) )
// 31.03.14
//          else if (Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1AsInteger('ConfMovECF'))
//               and
//                  ( Q.fieldbyname('moes_remessas').asstring='' )
//               then
//            FRel.AddCel(Global.CodVendaDireta+'-'+FGeral.GetTipoMovto(Global.CodVendaDireta))
          else
// 10.08.08
            FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FConfMovimento.GetDescricao(Q.fieldbyname('moes_comv_codigo').asinteger));

//          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('moes_fpgt_codigo').AsString));
//          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('moes_port_codigo').AsString));

          if Global.Topicos[1465] then begin

            FRel.AddCel( FTransp.GetPlaca( Q.FieldByName('moes_tran_codigo').AsString ) );
            FRel.AddCel(Q.FieldByName('moes_tran_codigo').AsString);
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tran_codigo').AsInteger,'T','N'));

          end else begin

            FRel.AddCel(Q.FieldByName('moes_tipocad').AsString);
            FRel.AddCel(Q.FieldByName('moes_tipo_codigo').AsString);
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'N'));

          end;

          FRel.AddCel(Q.FieldByName('moes_repr_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_repr_codigo').AsInteger,'R','N'));

          avista:=0;aprazo:=0;
          avistaq:=0;aprazoq:=0;
          checar:=' ';

          if (  pos(Q.Fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 ) then  begin

            if Q.FieldByName('moes_vispra').Asstring='V' then begin

// 07.07.20
              if Global.topicos[1473] then begin

                avistaq := GetQtde( Q.FieldByName('moes_transacao').Asstring );
                FRel.AddCel( floattostr(avistaq) );

              end;

              if Q.FieldByName('moes_datacont').Asdatetime>1 then begin
                FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
                avista:=Q.FieldByName('moes_vlrtotal').Ascurrency;
              end else begin
                FRel.AddCel(Q.FieldByName('moes_valortotal').Asstring);
                avista:=Q.FieldByName('moes_valortotal').Ascurrency;
              end;
              FRel.Addcel('');
// 07.07.20
              if Global.topicos[1473] then

                 FRel.Addcel('');

///////////// - 11.05.06
                  QMovfin:=sqltoquery('select movf_valorger,movf_operacao from movfin where movf_transacao='+stringtosql(Q.FieldByName('moes_transacao').Asstring));
                  if not QMovfin.eof then begin
//                    if QMovfin.fieldbyname('movf_valorger').ascurrency<>roundvalor(avista) then begin
//                    if QMovfin.fieldbyname('movf_valorger').ascurrency<>avista then begin
// 16.05.06
                    if formatfloat(f_cr,QMovfin.fieldbyname('movf_valorger').ascurrency)<>formatfloat(f_cr,avista) then begin
//                      avista:=QMovfin.fieldbyname('movf_valorger').ascurrency;
                      checar:='*';
// 16.05.06
                      if ListaDifCaixa.indexof(Qmovfin.fieldbyname('movf_operacao').asstring)=-1 then begin
                        ListaDifCaixa.Add(Qmovfin.fieldbyname('movf_operacao').asstring);
                        ListaValor.add(floattostr(avista));
                      end;
                    end;
                  end;
                  QMovfin.close;
///////////////////
            end else begin  //  a prazo


              if (Q.FieldByName('moes_valoravista').Ascurrency>0)  then begin
                  avista:=Q.FieldByName('moes_valoravista').Ascurrency;
// 01.06.05///////////////////
//                if pos(Q.FieldByName('moes_tipomov').Asstring,Global.CodVendaconsig+';'+Global.CodVendaProntaEntregaFecha+)>0 then  begin
                  QMovfin:=sqltoquery('select movf_valorger,movf_operacao from movfin where movf_transacao='+stringtosql(Q.FieldByName('moes_transacao').Asstring));
                  if not QMovfin.eof then begin
                    if QMovfin.fieldbyname('movf_valorger').ascurrency<>avista then begin
//                      avista:=QMovfin.fieldbyname('movf_valorger').ascurrency;
                      checar:='*';
// aqui em 21.06.06
                      if ListaDifCaixa.indexof(Qmovfin.fieldbyname('movf_operacao').asstring)=-1 then begin
                        ListaDifCaixa.Add(Qmovfin.fieldbyname('movf_operacao').asstring);
                        ListaValor.add(floattostr(avista));
                      end;

                    end;
                  end;
                  QMovfin.close;
//                end;
///////////////////////
//                FRel.Addcel(Q.FieldByName('moes_valoravista').Asstring);
                FRel.Addcel(floattostr(avista));
                if Q.FieldByName('moes_datacont').Asdatetime>1 then begin
                  aprazo:=Q.FieldByName('moes_vlrtotal').Ascurrency-avista;
                  FRel.AddCel(valortosql(aprazo));
                end else begin
                  aprazo:=Q.FieldByName('moes_valortotal').Ascurrency-avista;
                  FRel.AddCel(valortosql(aprazo));
                end;

              end else begin


                FRel.Addcel('');
// 07.07.20
                if Global.topicos[1473] then begin

                  aprazoq := GetQtde( Q.FieldByName('moes_transacao').Asstring );
                  FRel.Addcel(''); // coluna valor a vista ?
                  FRel.AddCel( floattostr( aprazoq  ) );

                end;

                if Q.FieldByName('moes_datacont').Asdatetime>1 then begin
                  FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
                  aprazo:=Q.FieldByName('moes_vlrtotal').Ascurrency;
                end else begin
                  FRel.AddCel(Q.FieldByName('moes_valortotal').Asstring);
                  aprazo:=Q.FieldByName('moes_valortotal').Ascurrency;
                end;
              end;
            end;

          end else begin   // devolucoes..

            if not EdTiposmov.isempty then begin
              if Q.FieldByName('moes_vlrtotal').Ascurrency>0 then
                avista:=Q.FieldByName('moes_vlrtotal').Ascurrency
              else
                avista:=Q.FieldByName('moes_valortotal').Ascurrency
            end;
            FRel.AddCel('');
            FRel.AddCel('');

// 07.07.20
            if Global.topicos[1473] then begin

                FRel.AddCel( '' );
// 06.11.20
                FRel.AddCel( '' );

            end;

          end;

//          if (Global.CodigoUnidade=global.unidadematriz) or (Global.CodigoUnidade='888') then
//            FRel.addcel(checar);

// 07.07.20
          if Global.topicos[1473] then begin

            FRel.AddCel( floattostr( aprazoq + avistaq ) );
            FRel.AddCel( floattostr(  Q.FieldByName('moes_vlrtotal').Ascurrency/(aprazoq + avistaq) ) );

          end;

          FRel.AddCel(valortosql(avista+aprazo));

          devolucao:=0;
          if pos( Q.FieldByName('moes_tipomov').AsString,Devolucoes )>0 then begin

            if Q.FieldByName('moes_datacont').Asdatetime>1 then begin
              FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
              devolucao:=Q.FieldByName('moes_vlrtotal').Ascurrency;
            end else begin
              FRel.AddCel(Q.FieldByName('moes_valortotal').Asstring);
              devolucao:=Q.FieldByName('moes_valortotal').Ascurrency;
            end;

          end   else

            FRel.Addcel(checar);   //  07.07.20 ??/

// 01.08.19 - so pra sair os valores
          if (Q.fieldbyname('moes_seto_codigo').asstring='9999') and ( Global.Topicos[1365]  ) then begin

            Lista:=TStringlist.create;
            strtolista(Lista,Q.fieldbyname('moes_remessas').asstring,'|',true);
            for p:=0 to Lista.count-1 do begin
              ListaSetores:=TStringlist.create;
              strtolista(ListaSetores,Lista[p],';',true);
              if ListaSetores.count>=2 then begin
                 porsetor:=Texttovalor(ListaSetores[1]);
              end;
              if p=0 then begin
                if (EdSeto_codigo.isempty) or (EdSeto_codigo.text=Listasetores[0]) then
                  FRel.AddCel(valortosql(porsetor))
                else
                  FRel.AddCel('');
              end;
            end;

          end else begin

            if ( global.topicos[1367] ) then begin

              if (EdEqui_codigo.text=GetEquipamento(Q.FieldByName('moes_transacao').AsString)) or (EdEqui_codigo.IsEmpty) then

                 FRel.AddCel(valortosql(avista+aprazo-devolucao))

              else

                 FRel.AddCel('');

            end else

               FRel.AddCel(valortosql(avista+aprazo-devolucao));

          end;

// 06.02.14
          if ( global.topicos[1367] ) then begin

            if (EdEqui_codigo.text=GetEquipamento(Q.FieldByName('moes_transacao').AsString)) or (EdEqui_codigo.IsEmpty) then

               FRel.AddCel(FEquipamentos.GetDescricao(GetEquipamento(Q.FieldByName('moes_transacao').AsString)))

            else

               FRel.AddCel('');

          end;

// 10.12.14 - Casa Nova - Cuiaba
         if ( global.topicos[1380] ) then
            FRel.AddCel(Q.FieldByName('moes_nroobra').AsString);

// 18.02.16 - setores
          if (Global.Topicos[1365]) then begin
            if (Q.fieldbyname('moes_seto_codigo').asstring='9999') then begin
              Lista:=TStringList.Create;
              strtolista(Lista,Q.fieldbyname('moes_remessas').asstring,'|',true);
              if LIsta.count=0 then begin
                FRel.AddCel('');
                FRel.AddCel('');
              end else begin
                for p:=0 to Lista.count-1 do begin
                  ListaSetores:=TStringlist.create;
                  strtolista(ListaSetores,Lista[p],';',true);
                  if ListaSetores.count>=2 then begin
                    porsetor:=Texttovalor(ListaSetores[1]);
                    FRel.AddCel( ListaSetores[0] );
                    FRel.AddCel( FSetores.GetDescricao(ListaSetores[0]));
                    break;
                  end else begin
                    Frel.addcel('');
                    Frel.addcel('');
                  end;
                  ListaSetores.Free;
                end;
              end;
              Lista.Free;

            end else begin

               FRel.AddCel( Q.fieldbyname('moes_seto_codigo').asstring );
               FRel.AddCel( FSetores.GetDescricao(Q.fieldbyname('moes_seto_codigo').asstring));

            end;

          end;

// 12.07.05
          FRel.AddCel('1');  // para q 'conte' os clientes quando sumariza por cidade ou outra coluna
          if Q.FieldByName('moes_tipocad').AsString='F' then begin
            FRel.AddCel(FFornece.GetCidade(Q.FieldByName('moes_tipo_codigo').Asinteger));
            FRel.AddCel(FFornece.GetUf(Q.FieldByName('moes_tipo_codigo').Asinteger));
          end else begin
            FRel.AddCel(FCadcli.GetCidade(Q.FieldByName('moes_tipo_codigo').Asinteger));
            FRel.AddCel(FCadcli.GetUf(Q.FieldByName('moes_tipo_codigo').Asinteger));
          end;
          FRel.AddCel(inttostr(FCadcli.GetPopulacao(Q.FieldByName('moes_tipo_codigo').Asinteger)));
// 02.09.05
          FRel.AddCel(Q.FieldByName('moes_usua_codigo').Asstring);
          FRel.AddCel(FUsuarios.getnome(Q.FieldByName('moes_usua_codigo').Asinteger));
// 11.07.05
//        if (pos(Global.CodVendaSerie4,Edtipomov.text)>0)  or  (pos(Global.CodVendaRE,Edtipomov.text)>0) or
//           (pos(Global.CodDevolucaoSerie5,Edtipomov.text)>0) then begin
             if devolucao=0 then begin
               FRel.AddCel(Q.FieldByName('moes_valoricmssutr').Asstring);
               FRel.AddCel('');
             end else begin
               FRel.AddCel('');
               FRel.AddCel(Q.FieldByName('moes_valoricmssutr').Asstring);
             end;
             FRel.AddCel(Q.FieldByName('moes_valoripi').Asstring);
// 01.08.11 - Capeg
           if FGeral.GetConfig1AsString('Impromremaordem')<>'' then
             FRel.AddCel( FTransp.GetNome(Q.FieldByName('moes_tran_codigo').Asstring) );
// 01.08.19
          if (Q.fieldbyname('moes_seto_codigo').asstring='9999') and ( Global.Topicos[1365]  ) then begin

            Lista:=TStringlist.create;
            strtolista(Lista,Q.fieldbyname('moes_remessas').asstring,'|',true);
            for p:=1 to Lista.count-1 do begin

              ListaSetores:=TStringlist.create;
              strtolista(ListaSetores,Lista[p],';',true);
              if ListaSetores.count>=2 then begin
                  porsetor:=Texttovalor(ListaSetores[1]);
                  if (EdSeto_codigo.isempty) or (EdSeto_codigo.text=ListaSetores[0]) then
                    FGeral.PulalinhaRel(FRel.GCol.ColCount,23,valortosql(porsetor),24,ListaSetores[0],25,FSetores.GetDescricao(ListaSetores[0]));
              end;
            end;
          end;
// 13.08.19 - A2z
          if ( global.topicos[1367] ) then begin
            QM:=sqltoquery('select move_equi_codigo,move_qtde,move_venda from movestoque where move_transacao='+
                           Stringtosql(Q.FieldByName('moes_transacao').AsString) );

            while not QM.Eof do begin

               if trim(QM.FieldByName('move_equi_codigo').AsString)<>'' then begin

                 if (QM.FieldByName('move_equi_codigo').AsString=EdEqui_codigo.Text) or
                    ( EdEqui_codigo.isempty )
                    then begin

                    porsetor:=roundvalor(QM.FieldByName('move_qtde').AsCurrency*QM.FieldByName('move_venda').AsCurrency);
//                    FGeral.PulalinhaRel(FRel.GCol.ColCount,23,valortosql(porsetor),24,FEquipamentos.GetDescricao( QM.FieldByName('move_equi_codigo').AsString ));
// 06.10.21
                    FGeral.PulalinhaRel(FRel.GCol.ColCount,22,valortosql(porsetor),23,FEquipamentos.GetDescricao( QM.FieldByName('move_equi_codigo').AsString ));

                 end;

              end;

              QM.Next;

            end;
            FGeral.FechaQuery(QM);

          end;

        end;

        Q.Next;

      end;

      FRel.Video;

    end;
//    if FGeral.UsuarioTeste(Global.usuario.Codigo) then begin
    if Global.usuario.OutrosAcessos[0336] then begin
      if ListaDifCaixa.count>0 then begin
        if confirma('Confirma alteração de '+inttostr(ListaDifCaixa.count)+' lançamentos do caixa ?') then begin
          for p:=0 to LIstadifcaixa.count-1 do begin
            if trim(listadifcaixa[p])<>'' then begin
              Sistema.Edit('movfin');
              Sistema.Setfield('movf_valorger',texttovalor(Listavalor[p]));
              Sistema.Setfield('movf_valorbco',texttovalor(Listavalor[p]));
              Sistema.post('movf_operacao='+stringtosql(listadifcaixa[p]));
            end;
          end;
          Sistema.beginprocess('Alterando lançamentos no caixa');
          Sistema.commit;
          Sistema.beginprocess('lançamentos alterados no caixa');
        end;
      end;
    end;
    ListaDifCaixa.Clear;
    ListaDifCaixa.free;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

    FRelFinan_Faturamento;     // 7

  end;

end;

procedure FRelFinan_ImpRomaneio;     // 8
begin
  with FRelFinan do begin
    if not FRelFinan_Execute(8) then Exit;
    FImpressao.ImprimeRomaneioRetorno(EdNumerodoc.asinteger,EdDtEmissao.AsDate,copy(EdUnid_codigo.text,1,3));
// 17.08.05
    FRelFinan_ImpRomaneio;
  end;
end;

procedure TFRelFinan.EdLancaiValidate(Sender: TObject);
begin
  if qrel=7 then begin
    if trim(EdLancai.text)='' then
      EdLancai.invalid('Obrigatório preencher o período');
  end;
end;

procedure FRelFinan_ImpNFDevolucao;  // 9
begin
  with FRelFinan do begin
    if not FRelFinan_Execute(9) then Exit;
    if pos( EdTipomov.text,Global.CodDevolucaoConsig+';'+global.CodDevolucaoTroca+';'+Global.CodDevolucaoProntaEntrega) > 0 then begin
// 24.04.05
//    if pos( EdTipomov.text,Global.CodDevolucaoConsig+';'+global.CodDevolucaoTroca+';'+Global.CodRetornoMostruario) > 0 then
      if Global.Topicos[1011] then
//        FImpressao.ImprimeRemessa(EdNumerodoc.asinteger,Eddtemissao.asdate,Global.CodigoUnidade,Global.CodDevolucaoProntaEntrega)
// 28.02.12 - nao imprimia DC e DR
        FImpressao.ImprimeRemessa(EdNumerodoc.asinteger,Eddtemissao.asdate,Global.CodigoUnidade,EdTipomov.text)
      else
        FGeral.IMpdevolucao(EdNumerodoc.asinteger,EdTipomov.text,'N',copy(EdUNid_codigo.text,1,3) )
//        FGeral.IMpdevolucao(EdNumerodoc.asinteger,EdTipomov.text,'S',copy(EdUNid_codigo.text,1,3) )
    end else
      FImpressao.ImprimeNotaSaida(EdNumerodoc.asinteger,EdDtEmissao.AsDate,copy(EdUnid_codigo.text,1,3),EdTipomov.text);
// 17.08.05
    FRelFinan_ImpNFDevolucao;
  end;
end;

procedure FRelFinan_Antecipacoes;  // 10
/////////////////////////////////////////////////
var Q,QSaldo:TSqlquery;
    titulo,statusvalidos,sqldatalan,sqlorder,periodo,sqlcodtipo,sqltipocad:string;
    vlrantecipa,vlrsaldo,saldoant,vlrante:currency;

    function GetHistoricoFin(transacao:String):string;
    var QHist:TSqlquery;
    begin
      QHist:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(transacao));
      if QHist.eof then
        result:=''
      else
        result:=FHistoricos.GetDescricao(QHist.fieldbyname('movf_hist_codigo').asinteger)+' '+QHist.fieldbyname('movf_complemento').asstring;
      QHist.close;
      Freeandnil(QHist);
    end;


begin

  with FRelFinan do begin

    if not FRelFinan_Execute(10) then Exit;
    Sistema.BeginProcess('Pesquisando');
    titulo:='Relatório de Antecipações';
    statusvalidos:='A';
//    sqlorder:=' order by pend_unid_codigo,pend_tipo_codigo,pend_dataemissao';
// 13.09.12 - Clessi - pois pra fechar com contabil fica o saldo 'de todas as unidades'
    sqlorder:=' order by pend_dataemissao,pend_tipo_codigo';
    sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C');
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and pend_datacont > 1';
// 26.04.10
      sqldatacont:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco);

    periodo:='Periodo : ';
    if EdLancai.AsDate>1 then begin
//      sqldatalan:=' and pend_datalcto>='+EdLancai.AsSql+' and pend_datalcto<='+EdLancaf.AsSql;
      sqldatalan:=' and pend_datamvto>='+EdLancai.AsSql+' and pend_datamvto<='+EdLancaf.AsSql;
      periodo:=periodo+' Lançamento : '+FGeral.FormataData(EdLancai.AsDate)+' a '+FGeral.FormataData(EdLancaf.AsDate);
    end else
      sqldatalan:='';

    if pos(Edtipocad.text,'C;F') > 0 then begin
      sqltipocad:=' and pend_tipocad='+Edtipocad.AsSql
    end else
      sqltipocad:='';

    saldoant:=0;
    if EdCodtipo.AsInteger>0 then begin
      Sistema.beginprocess('Calculando saldo anterior');
      titulo:=titulo+' - Codigo '+EdCodtipo.text+' - '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipocad.text,'N');
      if EdTipocad.text='R' then
        sqlcodtipo:=' and pend_repr_codigo='+Edcodtipo.AsSql
      else
        sqlcodtipo:=' and pend_tipo_codigo='+Edcodtipo.AsSql;
      QSaldo:=sqltoquery('select pend_valor,pend_rp  from pendencias'+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  sqlunidade+
                  ' and pend_datamvto<'+EdLancai.Assql+
                  sqldatacont+
                  sqlcodtipo+
                  sqltipocad );
      while not QSaldo.eof do begin
        if EdTipocad.text='C' then begin
              if QSaldo.fieldbyname('pend_rp').asstring='P' then
                vlrante:=(-1)*QSaldo.FieldByName('pend_valor').Ascurrency
              else
                vlrante:=QSaldo.FieldByName('pend_valor').Ascurrency;
        end else begin
              if QSaldo.fieldbyname('pend_rp').asstring='P' then
                vlrante:=QSaldo.FieldByName('pend_valor').Ascurrency
              else
                vlrante:=(-1)*QSaldo.FieldByName('pend_valor').Ascurrency;
        end;
        saldoant:=saldoant+vlrante;
        QSaldo.Next;
      end;

    end else
      sqlcodtipo:='';

    Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  sqlunidade+
                  sqldatalan+
                  sqldatacont+
                  sqlcodtipo+
                  sqltipocad+
                  sqlorder );


    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      Sistema.BeginProcess('Gerando Relatório');
      FRel.Init('RelAntecipacoes');
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit(titulo);
      FRel.AddTit(Periodo);
      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'       ,''         ,'',false);
//      FRel.AddCol( 80,0,'C','' ,''              ,'OPeracao'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
      FRel.AddCol( 65,1,'D','' ,''              ,'Lançamento'      ,''         ,'',false);
//      FRel.AddCol( 60,1,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      if Global.Usuario.OutrosAcessos[0701] then
         FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
//      FRel.AddCol( 80,0,'C','' ,''              ,'Forma Pagto'     ,''         ,'',false);
//      FRel.AddCol( 90,0,'C','' ,''              ,'Portador'        ,''         ,'',false);
      if EdCodtipo.AsInteger=0 then begin
        FRel.AddCol( 50,0,'N','' ,''              ,'Cli/Fornec.'     ,''         ,'',false);
        FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      end;
      FRel.AddCol(200,9,'C','' ,''              ,'Histórico'      ,''         ,'',False);
//      FRel.AddCol( 45,0,'C','' ,''              ,'Representante'   ,''         ,'',false);
//      FRel.AddCol(150,0,'C','' ,''              ,'Nome Repr.'      ,''         ,'',false);
//      FRel.AddCol( 60,1,'D','' ,''              ,'Vencimento'      ,''         ,'',false);
//      FRel.AddCol( 60,1,'D','' ,''              ,'Baixa'           ,''         ,'',false);
//      FRel.AddCol( 70,1,'C','' ,''              ,'Transação Baixa' ,''         ,'',false);
//      FRel.AddCol( 30,2,'N','' ,''              ,'NP'              ,''         ,'',False);
//      FRel.AddCol( 30,2,'N','' ,''              ,'Parc'            ,''         ,'',False);
//      FRel.AddCol( 50,2,'C','' ,''               ,'Antec./Bx Parc.' ,''         ,'',False);
//      FRel.AddCol( 70,3,'N','+' ,f_cr            ,'Valor'   ,''         ,'',False);
//      FRel.AddCol( 70,3,'N','+' ,''            ,'Valor'   ,''         ,'',False);
      FRel.AddCol( 70,3,'N','+' ,'##,###,##0.00'            ,'Valor'   ,''         ,'',False);
      FRel.AddCol( 70,3,'N','' ,'##,###,##0.00'            ,'Saldo'   ,''         ,'',False);
      vlrsaldo:=saldoant;

      if EdCodtipo.AsInteger>0 then begin
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            if Global.Usuario.OutrosAcessos[0701] then
              FRel.AddCel('-');
            FRel.AddCel('');
//            FRel.AddCel('');
//            FRel.AddCel('');
            FRel.AddCel('Saldo Anterior');
            FRel.AddCel('');
            FRel.AddCel(floattostr(saldoant));
      end;

      while not Q.eof do begin
//        if ( (Rel='BAI') and (not Tudobaixado(Q.FieldByName('pend_tipo_codigo').AsString,Q.FieldByName('pend_tipocad').AsString,Q.FieldByName('pend_numerodcto').AsString,Q.FieldByName('pend_databaixa').Asdatetime,Q.FieldByName('pend_parcela').Asinteger))  ) or (Rel<>'BAI')
//        then begin

          FRel.AddCel(Q.FieldByName('pend_transacao').AsString);
//          FRel.AddCel(Q.FieldByName('pend_operacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_unid_codigo').AsString);
          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
//          FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel(Q.FieldByName('pend_datacont').AsString);
          FRel.AddCel(Q.FieldByName('pend_numerodcto').AsString);
//          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('pend_fpgt_codigo').AsString));
//          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('pend_port_codigo').AsString));
          if EdCodtipo.AsInteger=0 then begin
            FRel.AddCel(Q.FieldByName('pend_tipo_codigo').AsString);
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'N'));
          end;
          FRel.AddCel(GetHistoricoFin(Q.FieldByName('pend_transacao').AsString));
//          FRel.AddCel(Q.FieldByName('pend_repr_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_repr_codigo').AsInteger,'R','N'));
//          FRel.AddCel(Q.FieldByName('pend_datavcto').AsString);
//          FRel.AddCel(Q.FieldByName('pend_databaixa').AsString);
//          FRel.AddCel(Q.FieldByName('pend_transbaixa').AsString);
//          FRel.AddCel(Q.FieldByName('pend_nparcelas').AsString);
//          FRel.AddCel(Q.FieldByName('pend_parcela').AsString);
//          FRel.AddCel(Q.FieldByName('pend_status').AsString);
          if EdTipocad.text='C' then begin
            if Q.fieldbyname('pend_rp').asstring='P' then
              vlrantecipa:=(-1)*Q.FieldByName('pend_valor').Ascurrency
            else
              vlrantecipa:=Q.FieldByName('pend_valor').Ascurrency;
          end else begin
            if Q.fieldbyname('pend_rp').asstring='P' then
              vlrantecipa:=Q.FieldByName('pend_valor').Ascurrency
            else
              vlrantecipa:=(-1)*Q.FieldByName('pend_valor').Ascurrency;
          end;
          FRel.AddCel(floattostr(vlrantecipa));
          vlrsaldo:=vlrsaldo+vlrantecipa;
          FRel.AddCel(floattostr(vlrsaldo));
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);

    FRelFinan_Antecipacoes;  // 10

  end;

end;


procedure FRelFinan_Compras;        // 11
///////////////////////////////////////////////////////////////////////////////
var statusvalidos,titulo,sqlorder,sqltipocod,sqltipomov,tiposmov,checar,tiposmovnao,
    sqldata,titconta,titsetores,
    sqlsetor,
    titequipamento  :string;
    Q,QMovFin,QTipo1:TSqlquery;
    avista,aprazo,devolucao,valorx,percfunrural,porsetor:currency;
    Lista,ListaSetores:TStringList;
    conta,contax,p:integer;

    function ContaOK(xconta:integer):boolean;
    /////////////////////////////////////////////
    var Lista:TStringList;
        i:integer;
    begin
       result:=false;
       if not FRelFinan.EdPlan_conta.IsEmpty then begin
         if xconta=FRelFinan.EdPlan_conta.AsInteger then
           result:=true;
       end else
         result:=true;
// 17.05.16
       if (Q.fieldbyname('moes_seto_codigo').asstring='9999') and ( Global.Topicos[1365] ) and ( not FRelFinan.EdSeto_codigo.isempty) then begin
            Lista:=TStringlist.create;
            result:=false;
            strtolista(Lista,Q.fieldbyname('moes_remessas').asstring,'|',true);
            for i:=0 to LIsta.count-1 do begin
              if pos(FRelFinan.EdSeto_codigo.text,Lista[i])>0 then result:=true;
            end;
       end;

    end;

// 28.06.19
    function EquipamentoOK( xcodequi:string):boolean;
    /////////////////////////////////////////////////
    begin

       if not FRelFinan.edEqui_codigo.isempty then begin

          result:=(FRelFinan.EdEqui_codigo.text=xcodequi)


       end else result:=true;


    end;


    // 28.09.16
    function GetNumeroRomaneio( xtransacao:string ):string;
    ////////////////////////////////////////////////////////
    var QR:TSqlquery;
    begin
      QR:=sqltoquery('select mova_numerodoc from movabate where mova_transacaogerada='+Stringtosql(xtransacao));
      result:='';
      if not QR.eof then begin
         if QR.fieldbyname('mova_numerodoc').asinteger>0 then
           result:=inttostr(QR.fieldbyname('mova_numerodoc').asinteger)
         else
           result:='';
      end;
      FGeral.FechaQuery(QR);
    end;

begin
////////////////////////////////////////////////////////////////////////////////

  with FRelFinan do begin

    if not FRelFinan_Execute(11) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    statusvalidos:='N;D;E';   // E devido as devolucoes do regime especial
    sqlorder:=' order by moes_unid_codigo,moes_dataemissao,moes_tipo_codigo,moes_numerodoc';
    sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
    tiposmovnao:=Global.CodEntradaprocesso+';'+Global.CodEntradaAlmox+';'+Global.CodSaidaprocesso;
    if EdCodtipo.Asinteger>0 then begin
      if Edtipocad.text='R' then
        sqltipocod:=' and moes_repr_codigo='+EdCodtipo.assql
      else
        sqltipocod:=' and ( (moes_tipo_codigo='+EdCodtipo.assql+') and (moes_tipocad='+EdTipocad.Assql+') )';
    end else
      sqltipocod:='';
    if EdTiposmov.isempty then begin
      if trim(Global.TiposRelCompra)<>'' then  // 02.09.08
        tiposmov:=Global.TiposRelCompra
      else
// 09.08.08 -retirado esta porra do caralho morfetica...
        tiposmov:=Global.TiposEntrada;
//      Global.CodCompra+';'+Global.CodCompraSemMovEstoque+';'+
//                Global.CodConhecimento+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+Global.CodCompraImobilizado+';'+
//                Global.CodCompraMatConsumo+';'+Global.Codcompraprodutor;
    end else begin
      tiposmov:=EdTiposmov.text;
    end;

    if trim(tiposmov)<>'' then
      sqltipomov:='and '+FGeral.GetIN('moes_tipomov',tiposmov,'C')
    else
      sqltipomov:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and moes_datacont > 1';
// 26.04.10
      sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);
// 06.10.09
    if ( not EdLancai.IsEmpty ) and ( not EdLancaf.IsEmpty ) then
      sqldata:=' and moes_datamvto>='+Edlancai.AsSql+' and moes_datamvto<='+Edlancaf.AsSql
    else if ( not EdLancai.IsEmpty ) then
      sqldata:=' and moes_datamvto>='+Edlancai.AsSql
    else if ( not EdLancaf.IsEmpty ) then
      sqldata:=' and moes_datamvto<='+Edlancaf.AsSql
    else
      sqldata:='';
// 25.02.10 - Abra - aqui nao preve a 'fase' de conta gravada no movesto e antes no pendencias
    titconta:='';
    if not EdPlan_conta.IsEmpty then  begin
//      sqlconta:=' and moes_plan_codigo='+EdPlan_conta.AsSql;
      titconta:='Conta '+EdPlan_conta.Text+' - '+EdPlan_conta.ResultFind.fieldbyname('plan_descricao').AsString;
    end;
// 28.06.19
    titequipamento:='';
    if not EdEqui_codigo.IsEmpty then  begin
      titequipamento:=' Máquina/Veículo : '+EdEqui_codigo.Text+' - '+EdEqui_codigo.ResultFind.fieldbyname('equi_descricao').AsString;
    end;
////////
//    titulo:='Entradas de '+FGeral.FormataData(Edlancai.asdate)+' a '+FGeral.FormataData(Edlancaf.asdate)+
//            ' - Tipos Impressos: '+TiposMov ;
    titulo:='Entradas de '+FGeral.FormataData(Edlancai.asdate)+' a '+FGeral.FormataData(Edlancaf.asdate)
            ;
// 27.08.13
    sqlsetor:='';
// 31.01.14
    if trim( FGeral.GetConfig1AsString('Setoresnaocompra') ) <> '' then
      sqlsetor:=' and '+FGeral.GetNOTIN('moes_seto_codigo',FGeral.GetConfig1AsString('Setoresnaocompra'),'C');
    titsetores:='';
    if (Global.Topicos[1365]) and (not EdSeto_codigo.IsEmpty) then begin
       sqlsetor:='and '+FGeral.getin('moes_Seto_codigo',EdSeto_codigo.Text+';'+'9999','C');
       titsetores:=' - Setor/Obra:'+FSetores.GetDescricao(Edseto_codigo.text)
    end;
// 20.08.19 - A2z
    if EdNumerodoc.AsInteger>0 then
      sqldoc:=' and moes_numerodoc='+EdNumerodoc.assql
    else
      sqldoc:='';

// 03.12.10
    Q:=sqltoquery('select * from movesto'+
                  ' left join confmov on ( comv_codigo=moes_comv_codigo )'+
                  ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                  sqldata+
                  ' and '+Fgeral.GetNOTIN('moes_tipomov',tiposmovnao,'C')+
//                  ' and substr(moes_natf_codigo,1,1) in (''1'',''2'',''3'')'+
// 02.07.19 - A2z---
                  sqlunidade+
                  sqltipocod+
                  sqldatacont+
                  sqltipomov+sqlsetor+sqldoc+
//                  sqlconta+
                  sqlorder );


    if Q.Eof then begin

      Avisoerro('Nada encontrado para impressão');
//      if Global.Usuario.Codigo=100 then
//         Avisoerro( Q.sql.text );


    end else begin

      FRel.Init('RelCompras');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text)+titsetores);
      FRel.AddTit(titconta+titequipamento);
      if Global.Topicos[1331] then
        FRel.AddTit('Incluso pendências financeiras incluídas direto no financeiro');
      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'       ,''         ,'',false);
      FRel.AddCol( 80,0,'C','' ,''              ,'OPeracao'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
//      FRel.AddCol( 60,1,'D','' ,''              ,'Lançamento'      ,''         ,'',false);
// 11.02.10 - Abra - em notas alteradas nao fica igual a data de lançamento que
// aparece da respectiva pendencia no relat. do financeiro pois aqui nao mostra
// o moes_datalcto mas sim o moes_datamvto...
      FRel.AddCol( 60,1,'D','' ,''              ,'Referência'      ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
      FRel.AddCol( 70,2,'N','' ,''              ,'Pedido/Rom'      ,''         ,'',False);
      FRel.AddCol( 40,0,'C','' ,''              ,'CFOP'            ,''         ,'',False);
      FRel.AddCol( 50,1,'C','' ,''              ,'Cod.Mov.'        ,''         ,'',False);
      FRel.AddCol( 90,1,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
//      FRel.AddCol( 80,0,'C','' ,''              ,'Forma Pagto'     ,''         ,'',false);
//      FRel.AddCol( 90,0,'C','' ,''              ,'Portador'        ,''         ,'',false);
// 01.03.18 - Novicarnes - Isonel
      FRel.AddCol( 40,0,'C','' ,''              ,'Sócio'            ,''         ,'',false);

      FRel.AddCol( 40,0,'C','' ,''              ,'Tipo'            ,''         ,'',false);
      FRel.AddCol( 45,0,'N','' ,''              ,'Codigo'          ,''         ,'',false);
//      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
// 06.08.08
      FRel.AddCol(150,0,'C','' ,''              ,'Razão Social'    ,''         ,'',false);
      FRel.AddCol(100,0,'C','' ,''              ,'CNPJ/CPF'        ,''         ,'',false);
//
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor a Vista'   ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor a Prazo'   ,''         ,'',false);
//      if (Global.CodigoUnidade=global.unidadematriz) or (Global.CodigoUnidade='888') then
//        FRel.AddCol( 30,0,'C','' ,''              ,'Checar'          ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor Total'     ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Devoluções'      ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Total Líquido'   ,''         ,'',false);
// 06.01.14 - Patoterra
      if ( global.topicos[1367] ) then
        FRel.AddCol(180,1,'C','' ,''              ,'Equipamento'          ,''         ,'',False);

      FRel.AddCol(100,1,'C','' ,''              ,'Cidade'          ,''         ,'',False);
      FRel.AddCol( 40,1,'C','' ,''              ,'Estado'          ,''         ,'',False);
      FRel.AddCol(100,1,'C','' ,''              ,'Transportador'   ,''         ,'',False);
      FRel.AddCol(070,3,'N','+',f_cr             ,'Valor Frete'   ,''         ,'',False);
//      FRel.AddCol( 80,3,'C','' ,''              ,'População'       ,''         ,'',False);
//      FRel.AddCol( 80,3,'N','' ,''              ,'Cod usuario'  ,''         ,'',False);
      FRel.AddCol(080,1,'C','' ,''              ,'Nome'  ,''         ,'',False);
      FRel.AddCol(070,3,'N','+',f_cr            ,'Funrural'       ,''         ,'',false);
      FRel.AddCol(050,3,'N','' ,f_cr            ,'% Fun.'       ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Total-Funrural'  ,''         ,'',false);
      FRel.AddCol(070,3,'N','+',f_cr            ,'Cota Capital'    ,''         ,'',false);
      FRel.AddCol(070,3,'N','' ,''              ,'Conta Ger.'      ,''         ,'',false);
      FRel.AddCol(120,1,'C','' ,''              ,'Descrição'      ,''         ,'',false);
// 18.02.16
      if (Global.Topicos[1365]) then begin
        FRel.AddCol(070,3,'N','' ,''              ,'Cod.'           ,''         ,'',false);
        FRel.AddCol(120,1,'C','' ,''              ,'Setor/Obra'      ,''         ,'',false);
      end;
      if Global.Topicos[1341] then begin
        FRel.AddCol(070,3,'N','' ,''              ,'Conta OK'      ,''         ,'',false);
        FRel.AddCol(120,1,'C','' ,''              ,'Descrição OK'      ,''         ,'',false);
      end;
      FRel.AddCol(060,1,'N','' ,''              ,'Débito'      ,''         ,'',false);
      FRel.AddCol(060,1,'N','' ,''              ,'Crédito'      ,''         ,'',false);

      while not Q.eof do begin

// 25.02.10 - aqui - pra prever conta gravada no movesto OU no pendencias
        if Q.fieldbyname('moes_plan_codigo').asinteger>0 then
          conta:=Q.fieldbyname('moes_plan_codigo').asinteger
        else
          conta:=fGeral.GetContaDespesa(Q.FieldByName('moes_transacao').Asstring);

        if ( ContaOK(conta) ) and
// 28.06.19
            ( EquipamentoOK(GetEquipamento(Q.FieldByName('moes_transacao').AsString)) )

          then begin

          FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
          FRel.AddCel(Q.FieldByName('moes_operacao').AsString);
          FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
          FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
          FRel.AddCel(Q.FieldByName('moes_datacont').AsString);
          FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
// 05.08.09 - Abra - Fran
          if pos(Q.FieldByName('moes_tipomov').AsString,Global.CodCompraProdutor+';'+Global.CodCompraProdutorMerenda+';'+
                 Global.CodEntradaProdutor)=0 then
            FRel.AddCel(Q.FieldByName('moes_pedido').AsString)
          else
            FRel.AddCel( GetNumeroRomaneio(Q.FieldByName('moes_transacao').AsString) );
          FRel.AddCel(Q.FieldByName('moes_natf_codigo').AsString);
          FRel.AddCel(inttostr(Q.fieldbyname('moes_comv_codigo').asinteger));
//          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));
// 10.08.08
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FConfMovimento.GetDescricao(Q.fieldbyname('moes_comv_codigo').asinteger));
//          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('moes_fpgt_codigo').AsString));
//          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('moes_port_codigo').AsString));
// 01.03.18
          if Q.FieldByName('moes_tipocad').AsString = 'C' then begin
             if FCadcli.Getecooperado( Q.FieldByName('moes_tipo_codigo').AsInteger ) then
               FRel.AddCel( 'S')
             else
              FRel.AddCel( 'N');
          end else
            FRel.AddCel( 'N');

          FRel.AddCel(Q.FieldByName('moes_tipocad').AsString);
          FRel.AddCel(Q.FieldByName('moes_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'N'));
// 06.08.08
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'R'));
          FRel.AddCel( FormatoCGCCPF( FGeral.GetCnpjCpfTipoCad(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString) ) );
          avista:=0;aprazo:=0;
          checar:=' ';
//          if pos(Q.Fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 then  begin
            if Q.FieldByName('moes_vispra').Asstring='V' then begin
              if Q.FieldByName('moes_datacont').Asdatetime>1 then begin
                FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
                avista:=Q.FieldByName('moes_vlrtotal').Ascurrency;
              end else begin
// 26.11.13 - Metallum - Clari
                if Q.FieldByName('moes_valortotal').Ascurrency>0 then begin
                  FRel.AddCel(Q.FieldByName('moes_valortotal').Asstring);
                  avista:=Q.FieldByName('moes_valortotal').Ascurrency;
                end else begin
                  FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
                  avista:=Q.FieldByName('moes_vlrtotal').Ascurrency;
                end;
              end;
              FRel.Addcel('');

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
///////////////////////
//                FRel.Addcel(Q.FieldByName('moes_valoravista').Asstring);
                FRel.Addcel(floattostr(avista));
                if Q.FieldByName('moes_datacont').Asdatetime>1 then begin
                  aprazo:=Q.FieldByName('moes_vlrtotal').Ascurrency-avista;
                  FRel.AddCel(valortosql(aprazo));
                end else begin
                  aprazo:=Q.FieldByName('moes_valortotal').Ascurrency-avista;
                  FRel.AddCel(valortosql(aprazo));
                end;

              end else begin

                FRel.Addcel('');
                if Q.FieldByName('moes_datacont').Asdatetime>1 then begin
                  FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
                  aprazo:=Q.FieldByName('moes_vlrtotal').Ascurrency;
                end else begin
                  valorx:=Q.FieldByName('moes_valortotal').Ascurrency;
                  if Q.FieldByName('moes_valortotal').Ascurrency=0 then begin
                    aprazo:=Q.FieldByName('moes_vlrtotal').Ascurrency;
                    valorx:=Q.FieldByName('moes_vlrtotal').Ascurrency;
                  end;
// 06.09.05
                    QTipo1:=sqltoquery('select moes_vlrtotal from movesto where moes_datacont is not null and moes_tipo_codigo='+
                          Q.FieldByName('moes_tipo_codigo').AsString+' and moes_dataemissao='+Datetosql(Q.FieldByName('moes_dataemissao').Asdatetime)+
                          ' and moes_numerodoc='+Q.FieldByName('moes_numerodoc').AsString);
                    if not QTipo1.eof then
                      valorx:=valorx-QTipo1.fieldbyname('moes_vlrtotal').ascurrency;
                    Qtipo1.close;
                    Freeandnil(Qtipo1);
                  FRel.AddCel(floattostr(valorx));
//                  aprazo:=Q.FieldByName('moes_valortotal').Ascurrency;
                  aprazo:=valorx;
                end;
              end;

            end;
//          end else begin
//            FRel.AddCel('');
//            FRel.AddCel('');
//          end;

//          if (Global.CodigoUnidade=global.unidadematriz) or (Global.CodigoUnidade='888') then
//            FRel.addcel(checar);
//          if (Q.fieldbyname('moes_seto_codigo').asstring='9999') and ( not EdSeto_codigo.isempty ) then begin
// 18.02.16
          if (Q.fieldbyname('moes_seto_codigo').asstring='9999') and ( Global.Topicos[1365]  ) then begin

            Lista:=TStringlist.create;
            strtolista(Lista,Q.fieldbyname('moes_remessas').asstring,'|',true);
            for p:=0 to Lista.count-1 do begin

              ListaSetores:=TStringlist.create;
              strtolista(ListaSetores,Lista[p],';',true);
              if ListaSetores.count>=2 then begin
                 porsetor:=Texttovalor(ListaSetores[1]);
              end;
              if p=0 then begin
                if (EdSeto_codigo.isempty) or (EdSeto_codigo.text=Listasetores[0]) then
                  FRel.AddCel(valortosql(porsetor))
                else
                  FRel.AddCel('');
              end;
//              else
//                FGeral.PulalinhaRel(FRel.GCol.ColCount,28,valortosql(porsetor));
            end;
//            FRel.AddCel(valortosql(porsetor))
          end else

            FRel.AddCel(valortosql(avista+aprazo));

          devolucao:=0;
          if pos( Q.FieldByName('moes_tipomov').AsString,Devolucoes )>0 then begin
            if Q.FieldByName('moes_datacont').Asdatetime>1 then begin
              FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
              devolucao:=Q.FieldByName('moes_vlrtotal').Ascurrency;
            end else begin
              FRel.AddCel(Q.FieldByName('moes_valortotal').Asstring);
              devolucao:=Q.FieldByName('moes_valortotal').Ascurrency;
            end;
          end else
            FRel.Addcel(checar);
          FRel.AddCel(valortosql(avista+aprazo-devolucao));
// 06.02.14
          if ( global.topicos[1367] ) then
            FRel.AddCel(FEquipamentos.GetDescricao(GetEquipamento(Q.FieldByName('moes_transacao').AsString)));

          if Q.FieldByName('moes_tipocad').Asstring='C' then begin
// 31.07.07
            if Q.FieldByName('moes_cida_codigo').asinteger=0 then begin
              FRel.AddCel(FCadcli.GetCidade(Q.FieldByName('moes_tipo_codigo').Asinteger));
              FRel.AddCel(FCadcli.GetUf(Q.FieldByName('moes_tipo_codigo').Asinteger));
            end else begin
              FRel.AddCel(FCidades.Getnome(Q.FieldByName('moes_cida_codigo').Asinteger));
              FRel.AddCel(Q.FieldByName('moes_estado').Asstring);
            end;
          end else begin
// 26.05.08
            if Q.FieldByName('moes_cida_codigo').asinteger=0 then begin
              FRel.AddCel(FFornece.GetCidade(Q.FieldByName('moes_tipo_codigo').Asinteger));
              FRel.AddCel(FFornece.GetUf(Q.FieldByName('moes_tipo_codigo').Asinteger));
            end else begin
              FRel.AddCel(FCidades.Getnome(Q.FieldByName('moes_cida_codigo').Asinteger));
              FRel.AddCel(Q.FieldByName('moes_estado').Asstring);
            end;
          end;
// 23.01.07
          FRel.AddCel(FTransp.getnome(Q.FieldByName('moes_tran_codigo').AsString));
          FRel.AddCel(valortosql(Q.FieldByName('moes_frete').AsCurrency));
// 02.09.05
//          FRel.AddCel(Q.FieldByName('moes_usua_codigo').Asstring);
          FRel.AddCel(FUsuarios.getnome(Q.FieldByName('moes_usua_codigo').Asinteger));
// 04.05.07
          FRel.AddCel(Q.FieldByName('moes_funrural').Asstring);
// 04.06.10 - Novicarnes
          percfunrural:=0;
          if (Q.FieldByName('moes_vlrtotal').AsCurrency>0) then
            percfunrural:=(Q.FieldByName('moes_funrural').AsCurrency/Q.FieldByName('moes_vlrtotal').AsCurrency)*100;
          FRel.AddCel(floattostr(percfunrural));
// 28.06.07 - isonel
          FRel.AddCel(floattostr((avista+aprazo-devolucao)-Q.FieldByName('moes_funrural').AsCurrency));
          FRel.AddCel(Q.FieldByName('moes_cotacapital').Asstring);
// 02.08.07
//          conta:=fGeral.GetContaDespesa(Q.FieldByName('moes_transacao').Asstring);
          FRel.AddCel( inttostr( conta ) );
          if conta>0 then
            FRel.AddCel( FPlano.GetDescricao(conta) )
          else
            FRel.AddCel('');
// 18.02.16 - setores
          if (Global.Topicos[1365]) then begin

            if (Q.fieldbyname('moes_seto_codigo').asstring='9999') then begin

              strtolista(Lista,Q.fieldbyname('moes_remessas').asstring,'|',true);
              if LIsta.count=0 then begin

                FRel.AddCel('');
                FRel.AddCel('');

              end else begin

                for p:=0 to Lista.count-1 do begin

                  ListaSetores:=TStringlist.create;
                  strtolista(ListaSetores,Lista[p],';',true);
                  if ListaSetores.count>=2 then begin
                    porsetor:=Texttovalor(ListaSetores[1]);
// 13.08.19
                    if (EdSeto_codigo.isempty) or (EdSeto_codigo.text=Listasetores[0]) then begin

                      FRel.AddCel( ListaSetores[0] );
                      FRel.AddCel( FSetores.GetDescricao(ListaSetores[0]));

                    end else begin

                      Frel.addcel('');
                      Frel.addcel('');

                    end;
                    break;

                  end else begin

                    Frel.addcel('');
                    Frel.addcel('');

                  end;
                end;
              end;
            end else begin

               if (EdSeto_codigo.isempty) or (EdSeto_codigo.text=Q.fieldbyname('moes_seto_codigo').asstring) then begin

                 FRel.AddCel( Q.fieldbyname('moes_seto_codigo').asstring );
                 FRel.AddCel( FSetores.GetDescricao(Q.fieldbyname('moes_seto_codigo').asstring));

               end else begin

                    Frel.addcel('');
                    Frel.addcel('');

               end;

            end;
          end;
// 10.06.10
          if Global.Topicos[1341] then begin
            contax:=FConfMovimento.GetContaGerencial(Q.FieldByName('moes_comv_codigo').AsInteger);
            if (Contax>0) and (contax<>conta) and (conta>0) then begin
              FRel.AddCel( inttostr( contax ) );
              FRel.AddCel( FPlano.GetDescricao(contax))
            end else begin
              FRel.AddCel( '' );
              FRel.AddCel( '' )
            end;
          end;

// 12.03.09
          FRel.AddCel(Q.FieldByName('comv_debito').Asstring);
          FRel.AddCel(Q.FieldByName('comv_credito').Asstring);
// 18.02.16
          if (Q.fieldbyname('moes_seto_codigo').asstring='9999') and ( Global.Topicos[1365]  ) then begin

            Lista:=TStringlist.create;
            strtolista(Lista,Q.fieldbyname('moes_remessas').asstring,'|',true);
            for p:=1 to Lista.count-1 do begin

              ListaSetores:=TStringlist.create;
              strtolista(ListaSetores,Lista[p],';',true);
              if ListaSetores.count>=2 then begin
                  porsetor:=Texttovalor(ListaSetores[1]);
                  if (EdSeto_codigo.isempty) or (EdSeto_codigo.text=ListaSetores[0]) then
                    FGeral.PulalinhaRel(FRel.GCol.ColCount,18,valortosql(porsetor),31,inttostr(conta),32,FPlano.GetDescricao(conta),33,ListaSetores[0],34,FSetores.GetDescricao(ListaSetores[0]));
              end;
            end;
          end;
////////////////////////////
        end;
        Q.Next;
      end;

///////////////////// - busca pendencias financeiras
      if Global.Topicos[1331] then begin
        FGeral.FechaQuery(Q);
        sqlorder:=' order by pend_unid_codigo,pend_dataemissao,pend_tipo_codigo,pend_numerodcto';
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C');
        tiposmovnao:=Global.CodEntradaprocesso+';'+Global.CodEntradaAlmox+';'+Global.CodSaidaprocesso;
        if EdCodtipo.Asinteger>0 then begin
          if Edtipocad.text='R' then
            sqltipocod:=' and pend_repr_codigo='+EdCodtipo.assql
          else
            sqltipocod:=' and ( (pend_tipo_codigo='+EdCodtipo.assql+') and (pend_tipocad='+EdTipocad.Assql+') )';
        end else
          sqltipocod:='';
    // 24.03.06
        if Global.Usuario.OutrosAcessos[0701] then
          sqldatacont:=''
        else
//          sqldatacont:=' and pend_datacont > 1';
// 26.04.10
          sqldatacont:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco);

        Q:=sqltoquery('select * from pendencias where '+FGeral.GetIN('pend_status','N;B','C')+
                      ' and pend_datamvto>='+Edlancai.AsSql+' and pend_datamvto<='+Edlancaf.AsSql+
                      ' and pend_parcela=''1'''+
                      ' and '+Fgeral.GetIN('pend_tipomov',Global.CodPendenciaFinanceira,'C')+
                      sqlunidade+
                      sqltipocod+
                      sqldatacont+
                      sqlorder );
        while not Q.eof do begin
/////////////
          FRel.AddCel(Q.FieldByName('pend_transacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_operacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_unid_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_datamvto').AsString);
          FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
          FRel.AddCel(Q.FieldByName('pend_datacont').AsString);
          FRel.AddCel(Q.FieldByName('pend_numerodcto').AsString);
// 05.08.09 - numero do pedido
          FRel.AddCel('');
//          FRel.AddCel(Q.FieldByName('moes_natf_codigo').AsString);
          FRel.AddCel('');
//          FRel.AddCel(inttostr(Q.fieldbyname('moes_comv_codigo').asinteger));
          FRel.AddCel('');
          FRel.AddCel(Q.FieldByName('pend_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('pend_tipomov').AsString));
//          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('moes_fpgt_codigo').AsString));
//          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('moes_port_codigo').AsString));
          FRel.AddCel(Q.FieldByName('pend_tipocad').AsString);
          FRel.AddCel(Q.FieldByName('pend_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'N'));
// 06.08.08
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'R'));
          FRel.AddCel( FormatoCGCCPF( FGeral.GetCnpjCpfTipoCad(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString) ) );
          avista:=0;
          aprazo:=0;
          checar:=' ';
          FRel.Addcel(floattostr(avista));
          aprazo:=Q.FieldByName('pend_valortitulo').Ascurrency;
          FRel.AddCel(valortosql(aprazo));
          FRel.AddCel(valortosql(avista+aprazo));
          devolucao:=0;
          FRel.AddCel(valortosql(devolucao));
          FRel.AddCel(valortosql(avista+aprazo-devolucao));
          if Q.FieldByName('pend_tipocad').Asstring='C' then begin
            FRel.AddCel(FCadcli.GetCidade(Q.FieldByName('pend_tipo_codigo').Asinteger));
            FRel.AddCel(FCadcli.GetUf(Q.FieldByName('pend_tipo_codigo').Asinteger));
          end else begin
            FRel.AddCel(FFornece.GetCidade(Q.FieldByName('pend_tipo_codigo').Asinteger));
            FRel.AddCel(FFornece.GetUf(Q.FieldByName('pend_tipo_codigo').Asinteger));
          end;
// 23.01.07
//          FRel.AddCel(FTransp.getnome(Q.FieldByName('moes_tran_codigo').AsString));
//          FRel.AddCel(valortosql(Q.FieldByName('moes_frete').AsCurrency));
          FRel.AddCel('');
          FRel.AddCel('');
// 02.09.05
//          FRel.AddCel(Q.FieldByName('moes_usua_codigo').Asstring);
          FRel.AddCel(FUsuarios.getnome(Q.FieldByName('pend_usua_codigo').Asinteger));
// 04.05.07
//          FRel.AddCel(Q.FieldByName('moes_funrural').Asstring);
          FRel.AddCel('');
// 28.06.07 - isonel
//          FRel.AddCel(floattostr((avista+aprazo-devolucao)-Q.FieldByName('moes_funrural').AsCurrency));
//          FRel.AddCel(Q.FieldByName('moes_cotacapital').Asstring);
          FRel.AddCel(valortosql(avista+aprazo-devolucao));
          FRel.AddCel('');
// 02.08.07
//          conta:=fGeral.GetContaDespesa(Q.FieldByName('moes_transacao').Asstring);
          conta:=Q.Fieldbyname('pend_plan_conta').AsInteger;
          FRel.AddCel( inttostr( conta ) );
          if conta>0 then
            FRel.AddCel( FPlano.GetDescricao(conta))
          else
            FRel.AddCel('');
          if Global.Topicos[1341] then begin
            FRel.AddCel('');
            FRel.AddCel('');
          end;
// 12.03.09
//          FRel.AddCel(Q.FieldByName('comv_debito').Asstring);
//          FRel.AddCel(Q.FieldByName('comv_credito').Asstring);
          FRel.AddCel('');
          FRel.AddCel('');

/////////////
          Q.Next;
        end;
      end;

      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

    FRelFinan_Compras;     // 11

  end;

end;

////////////////////////////////////////////////
// 30.09.05
procedure FRelFinan_PendentesRepre;     // 12
//////////////////////////////////////////////////////////
var statusvalidos,titulo,periodo,sqlorder,sqlrecpag,sqlcodtipo,sqltipocad,tipomov:string;
    Q  :TSqlquery;
    bxparcial,saldoduplicata,subparcela,subsaldo,totparcela,totsaldo:currency;
    codcliente:integer;
    ListaJaBaixadosBP  : TStringList;


    function  ChecaBaixaParcial(unidade,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer):currency;
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var Qbx:TSqlquery;
        status,sqlqtipo:string;
        valor:currency;

    begin

      status:=stringtosql('P');
      if Datacont>1 then
//        sqlqtipo:=' and pend_datacont>1'
// 26.04.10
        sqlqtipo:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco)
      else
        sqlqtipo:=' and pend_datacont is null';
      QBx:=sqltoquery('select * from pendencias where pend_status='+status+' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
                      ' and pend_unid_codigo='+stringtosql(unidade)+
                      ' and pend_parcela='+inttostr(parcela)+
                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
      valor:=0;
      while not QBx.eof do begin

        valor:=valor+QBx.fieldbyname('pend_valor').ascurrency;
        QBx.next;

      end;

      Qbx.close;
      Freeandnil(Qbx);
      result:=valor;

    end;

{  08.01.2021
    function Tudobaixado(tipocod,tipocad,numerodoc:string;Data:TDatetime;parcela:integer):boolean;
    //////////////////////////////////////////////////////////////////////////////////////////////
    var Qbx:TSqlquery;
    begin
      if Q.FieldByName('pend_status').AsString='P' then begin
        QBx:=sqltoquery('select * from pendencias where pend_status=''B'' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa<='+Datetosql(Data)+
                      ' and pend_databaixa > '+DatetoSql(Global.DataMenorBanco)+
                      ' and pend_parcela='+inttostr(parcela)+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
        result:=not Qbx.eof;
        Qbx.close;
        Freeandnil(Qbx);
      end else
        result:=false;
    end;
}

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
    ////////////////////////////////////////////////
    begin
//      if rel='PEN' then begin
        if ListaJaBaixadosBP.IndexOf(xoperacao)>=0 then
          result:=true
        else
          result:=false;
//      end else
//        result:=false;
    end;

    function Gettipomov(transacao:String):string;
    ////////////////////////////////////////////
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select moes_tipomov from movesto where moes_transacao='+stringtosql(transacao));
      result:='';
      if not Q.eof then begin
        result:=Q.fieldbyname('moes_tipomov').asstring;
        if result=Global.CodDevolucaoConsig then   //  09.09.05 - gambia para reges -
          result:=Global.CodVendaConsig;
      end else
        result:=Global.CodPendenciaFinanceira;
      Q.close;
      Freeandnil(Q);
    end;

// 03.08.09
    function GetDescricaoProdutos(t,nome:String):string;
    /////////////////////////////////////////////////////
    var Q:TSqlquery;
        Listacodigos:TStringlist;
        p:integer;
        s:String;
    begin
      Q:=sqltoquery('select move_esto_codigo from movestoque where move_transacao='+stringtosql(t));
      Listacodigos:=TStringlist.create;
      while not Q.eof do begin
        Listacodigos.add(Q.fieldbyname('move_esto_codigo').asstring);
        Q.Next;
      end;
      FGeral.FechaQuery(Q);
      s:='';
      for p:=0 to ListaCodigos.Count-1 do begin
        if trim(ListaCodigos[p])<>'' then begin
          s:=s+trim(FEstoque.GetDescricao(ListaCodigos[p]))+'+';
        end;
      end;
      if trim(s)<>'' then
        result:=s
      else
        result:=nome;
    end;

// 08.01.2021
/////////////////////////////////////////////////////////////////////////////
    function EstaValendo(vencimento:TDatetime ; rp:string ):boolean;
    ////////////////////////////////////////////////////////////////////
    var diasvencidos:integer;
        ativo:string;
        QBx1:TSqlquery;
    begin

// 15.08.19
      if (not FRelfinan.EdEqui_codigo.isempty) then begin

        if FRelfinan.Edequi_codigo.text <> FRelfinan.GetEquipamento(Q.FieldByName('pend_transacao').AsString)  then
           result:=false
        else
           result:=true;

      end  else if True then begin     // Rel='PEN'
// 15.06.16
        if (not FRelfinan.EdCida_codigo.isempty) and (rp='R') then begin

           if (FRelfinan.EdCida_codigo.text<>FCadCli.getCodigoCidade(Q.fieldbyname('pend_tipo_codigo').AsInteger)) then
             result:=false
// 24.04.17 - giacomoni
           else
             result:=true;

        end else if (Global.Topicos[1261]) and (Q.fieldbyname('pend_tipomov').AsString=global.CodDevolucaoCompra ) then
          result:=false
// 21.09.09 - Damama
        else if ( Q.fieldbyname('pend_status').AsString='A' ) and (Q.fieldbyname('pend_databaixa').AsDatetime>1) then
// 21.02.18 - Novicarnes
        else if ( FRelfinan.Edativos.text='D' ) and ( rp='R' ) then begin
             if FCadCli.GetSituacao( Q.FieldByName('pend_tipo_codigo').AsInteger ) <>'D' then
                result:=false
             else
                result:=true;

        end else if ( Q.fieldbyname('pend_status').AsString='A' ) and (Q.fieldbyname('pend_databaixa').AsDatetime>1) then
          result:=false
//////////////
        else if (FRelfinan.Edativos.text='T' ) or ( rp='P' ) then begin

          result:=true;
          {  // 06.08.19 - retirado pois nao aparecia as CPR...
          QBx1:=sqltoquery('select sum(pend_valor) as parcial from pendencias where pend_status='+stringtosql('P')+
                      ' and pend_tipo_codigo='+stringtosql(Q.fieldbyname('pend_tipo_codigo').asstring)+
                      ' and pend_tipocad='+stringtosql(Q.fieldbyname('pend_tipocad').asstring)+
                      ' and pend_databaixa > '+DatetoSql(Global.DataMenorBanco)+
                      ' and pend_parcela='+Q.fieldbyname('pend_parcela').asstring+
// 23.03.15  - coorlafs
                      ' and pend_observacao <> '+Stringtosql('Pagamento Leite')+
                      ' and pend_unid_codigo='+stringtosql(Q.fieldbyname('pend_unid_codigo').asstring)+
                      ' and pend_numerodcto='+stringtosql(Q.fieldbyname('pend_numerodcto').asstring) );
          if not QBx1.eof then begin
            if qbx1.fieldbyname('parcial').ascurrency>=q.FieldByName('pend_valor').ascurrency then
              result:=false;
          end else
          fgeral.fechaquery(QBx1);
          }
        end else begin

          ativo:='S';
          diasvencidos:=trunc( sistema.hoje-vencimento );
          if (rp='R') and ( diasvencidos>0 )  and ( diasvencidos>FGeral.Getconfig1asinteger('DIASINATIVO') )
             and ( FGeral.Getconfig1asinteger('DIASINATIVO')>0 )  then
             ativo:='N';
          if (FRelfinan.EdAtivos.text='A') and (ativo='N') then
            result:=false
          else if (FRelfinan.EdAtivos.text='I') and (ativo='S') then
            result:=false
          else
            result:=true;
        end;

//      end else if rel='INC' then begin // 09.02.10 - Abra -Paulo
/////////////
//        if ( Q.fieldbyname('pend_status').AsString='K' ) and (Q.fieldbyname('pend_databaixa').AsDatetime>1) then
//          result:=false
/////////////
      end else

        result:=true;

    end;


begin
///////////////////////

  with FRelFinan do begin

    if not FRelFinan_Execute(12) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    sqlrecpag:=' and pend_RP='+stringtosql('R');
    titulo:='Relatório de Recebimentos Pendentes para Representantes';
    statusvalidos:='N';
    sqlorder:=' order by pend_unid_codigo,pend_repr_codigo,pend_tipo_codigo,pend_numerodcto,pend_datavcto';
    sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C');
    if EdVencimentoi.asdate>1 then
      periodo:=' Vencimento : '+FGeral.FormataData(EdVencimentoi.AsDate)+' a '+FGeral.FormataData(EdVencimentof.AsDate)
    else
      periodo:='';
    if EdVencimentoi.AsDate>1 then begin
      sqldatavenci:=' and pend_datavcto>='+EdVencimentoi.AsSql+' and pend_datavcto<='+EdVencimentof.AsSql;
    end else
      sqldatavenci:='';

    if EdCodtipo.AsInteger>0 then begin
      if EdTipocad.text='R' then begin
        titulo:=titulo+' - Representante '+EdCodtipo.text+' - '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipocad.text,'N');
        sqlcodtipo:=' and pend_repr_codigo='+Edcodtipo.AsSql
      end else if Edtipocad.text='S' then begin
        sqlcodtipo:=' and '+FGeral.Getin('pend_repr_codigo',FRepresentantes.GetCodigosRepres(EdCodtipo.asinteger),'N');
        titulo:=titulo+' - Supervisor '+EdCodtipo.text+' - '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipocad.text,'N');
      end else begin
        sqlcodtipo:=' and pend_tipo_codigo='+Edcodtipo.AsSql;
        titulo:=titulo+' - Codigo '+EdCodtipo.text+' - '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipocad.text,'N');
      end;
    end else
      sqlcodtipo:='';
    if Edtipocad.text='C' then begin
      sqltipocad:=' and pend_tipocad='+Edtipocad.AsSql
    end else
      sqltipocad:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and pend_datacont > 1';
// 26.04.10
      sqldatacont:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco);

// 27.07.09
    if ( not Edemissaoini.isempty ) and ( not Edemissaofim.isempty ) then begin
      sqlperiodoemissao:=' and pend_dataemissao>='+Edemissaoini.assql+' and pend_dataemissao<='+Edemissaofim.assql;
      periodo:=periodo+' Emissão : '+FGeral.FormataData(Edemissaoini.AsDate)+' a '+FGeral.FormataData(Edemissaofim.AsDate);
      sqlorder:=' order by pend_unid_codigo,pend_repr_codigo,pend_tipo_codigo,pend_dataemissao';
    end else
      sqlperiodoemissao:='';
    Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  sqlrecpag+
                  ' and pend_databaixa is null'+
                  sqlunidade+
                  sqldatavenci+
                  sqldatacont+
                  sqlcodtipo+
                  sqltipocad+
                  sqlperiodoemissao+  // 27.07.09
                  sqlorder );


    if Q.Eof then begin

      Avisoerro('Nada encontrado para impressão');

    end else begin

      // 08.01.21 - Fama - Janina
      ListaJaBaixadosBP := TStringList.create;

      if ( Global.Topicos[1277] ) then begin

        Sistema.beginprocess('Checando titulos baixados com baixas parciais');
        while not Q.eof do begin

          if EstaValendo(Q.FieldByName('pend_datavcto').AsDatetime,'R') then begin

            if Q.FieldByName('pend_status').AsString='N' then begin

             if TudoBaixado(Q.FieldByName('pend_unid_codigo').AsString,
                            Q.FieldByName('pend_tipo_codigo').AsString,
                            Q.FieldByName('pend_tipocad').AsString,
                            Q.FieldByName('pend_numerodcto').AsString,Q.FieldByName('pend_dataemissao').Asdatetime,
                            Q.FieldByName('pend_datacont').Asdatetime,Q.FieldByName('pend_datavcto').Asdatetime,
                            Q.FieldByName('pend_parcela').Asinteger,0) then
              ListaJaBaixadosBP.Add(Q.FieldByName('pend_operacao').AsString);

            end;

          end;
          Q.Next;

        end;
        Q.First;
        Sistema.beginprocess('Iniciando relatório');

      end;


//    end else begin

      FRel.Init('RelPendentesRepre');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit(Periodo);
      FRel.AddCol(100,0,'C','' ,''              ,'Transação'       ,''         ,'',False);
      FRel.AddCol( 60,1,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      if Global.Usuario.OutrosAcessos[0701] then
         FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
// 08.09.05
      FRel.AddCol(100,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);

      FRel.AddCol( 80,0,'C','' ,''              ,'Forma Pagto'     ,''         ,'',false);
      FRel.AddCol( 90,0,'C','' ,''              ,'Portador'        ,''         ,'',false);
      if ( Edemissaoini.isempty ) and ( Edemissaofim.isempty ) then begin
        FRel.AddCol( 45,0,'N','' ,''              ,'Cliente'         ,''         ,'',false);
        FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      end;
      if ( (Global.Topicos[1264]) )  then
        FRel.AddCol(150,0,'C','' ,''              ,'Produtos'            ,''         ,'',false);
//      if EdCodtipo.AsInteger=0 then begin
        FRel.AddCol( 45,0,'C','' ,''              ,'Representante'   ,''         ,'',false);
        FRel.AddCol(150,0,'C','' ,''              ,'Nome Repr.'      ,''         ,'',false);
//      end;
      FRel.AddCol( 60,1,'D','' ,''              ,'Vencimento'      ,''         ,'',false);
      FRel.AddCol( 30,2,'N','' ,''              ,'NP'              ,''         ,'',False);
      FRel.AddCol( 30,2,'N','' ,''              ,'Parc'            ,''         ,'',False);
      if ( not Edemissaoini.isempty ) and ( not Edemissaofim.isempty ) then begin
        FRel.AddCol( 70,3,'N','' ,f_cr            ,'Valor Parcela'   ,''         ,'',False);
        FRel.AddCol( 70,3,'N','' ,f_cr            ,'Saldo Duplicata' ,''         ,'',False);
      end else begin
        FRel.AddCol( 70,3,'N','+' ,f_cr            ,'Valor Parcela'   ,''         ,'',False);
        FRel.AddCol( 70,3,'N','+' ,f_cr            ,'Saldo Duplicata' ,''         ,'',False);
      end;
      codcliente:=9898;
      subparcela:=0;subsaldo:=0;
      totparcela:=0;totsaldo:=0;

      while not Q.eof do begin

// 08.01.2020
        if ( EstaValendo(Q.FieldByName('pend_datavcto').AsDatetime,'R') ) and
           ( not TudoBaixadoBP(Q.FieldByName('pend_operacao').AsString) ) then begin

          FRel.AddCel(Q.FieldByName('pend_transacao').AsString);
  //          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
            FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
            if Global.Usuario.OutrosAcessos[0701] then
              FRel.AddCel(Q.FieldByName('pend_datacont').AsString);
            FRel.AddCel(Q.FieldByName('pend_numerodcto').AsString);
  //          FRel.AddCel(Q.FieldByName('pend_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('pend_tipomov').AsString));
  // 08.09.05
            tipomov:=Gettipomov(Q.FieldByName('pend_transacao').AsString);
            FRel.AddCel(Tipomov+'-'+FGeral.GetTipoMovto(Tipomov));
            FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('pend_fpgt_codigo').AsString));
            FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('pend_port_codigo').AsString));
            if ( Edemissaoini.isempty ) and ( Edemissaofim.isempty ) then begin
              FRel.AddCel(Q.FieldByName('pend_tipo_codigo').AsString);
              FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'N'));
            end;
            if ( (Global.Topicos[1264]) ) then
              FRel.AddCel( GetDescricaoProdutos(Q.FieldByName('pend_transacao').AsString,FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'R')));
  //          if EdCodtipo.AsInteger=0 then begin
              FRel.AddCel(Q.FieldByName('pend_repr_codigo').AsString);
              FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_repr_codigo').AsInteger,'R','N'));
  //          end;
            FRel.AddCel(Q.FieldByName('pend_datavcto').AsString);
  //          FRel.AddCel(Q.FieldByName('pend_databaixa').AsString);
            FRel.AddCel(Q.FieldByName('pend_nparcelas').AsString);
            FRel.AddCel(Q.FieldByName('pend_parcela').AsString);
            FRel.AddCel(Q.FieldByName('pend_valor').AsString);
  //          FRel.AddCel(Q.FieldByName('pend_status').AsString);
  //          FRel.AddCel(formatfloat(f_cr,(-1)*texttovalor(valor)));
            bxparcial:=ChecaBaixaParcial(Q.FieldByName('pend_unid_codigo').AsString,Q.FieldByName('pend_tipo_codigo').AsString,Q.FieldByName('pend_tipocad').AsString,Q.FieldByName('pend_numerodcto').AsString,Q.FieldByName('pend_dataemissao').Asdatetime,
                 Q.FieldByName('pend_datacont').Asdatetime,Q.FieldByName('pend_datavcto').Asdatetime,Q.FieldByName('pend_parcela').Asinteger);
            saldoduplicata:=Q.FieldByName('pend_valor').Ascurrency-bxparcial;
            FRel.AddCel(formatfloat(f_cr,saldoduplicata));
            codcliente:=Q.FieldByName('pend_tipo_codigo').AsInteger;
            subparcela:=subparcela+Q.FieldByName('pend_valor').AsCurrency;
            totparcela:=totparcela+Q.FieldByName('pend_valor').AsCurrency;
            subsaldo:=subsaldo+saldoduplicata;
            totsaldo:=totsaldo+saldoduplicata;
            Q.Next;
            if ( not Edemissaoini.isempty ) and ( not Edemissaofim.isempty ) then begin
              if (Q.FieldByName('pend_tipo_codigo').AsInteger<>codcliente) and ( not Q.eof) then begin
    //            FGERal.PulalinhaRel(FRel.gcol.ColCount-1,FREl.GetnCol(FinalStr('Valor Parcela',2)),transform(subparcela,f_cr) );
                FGERal.PulalinhaRel(15,08,FGeral.GetNomeRazaoSocialEntidade(codcliente,'C','N')  ,14,transform(subparcela,f_cr),15,transform(subsaldo,f_cr) );
                subsaldo:=0;subparcela:=0;
              end;
            end;

        end else Q.Next;

      end;

      if ( not Edemissaoini.isempty ) and ( not Edemissaofim.isempty ) then begin
        FGERal.PulalinhaRel(15,08,FGeral.GetNomeRazaoSocialEntidade(codcliente,'C','N')  ,14,transform(subparcela,f_cr),15,transform(subsaldo,f_cr) );
        FGERal.PulalinhaRel(15);
        FGERal.PulalinhaRel(15,14,transform(totparcela,f_cr),15,transform(totsaldo,f_cr) );
      end;
      FRel.Video;

    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);
    FRelFinan_PendentesRepre;

  end;
end;


////////////////////////////////////////////////
// 07.10.05
procedure FRelFinan_ResumoAberto(RecPag:string);     // 13

type Registro=record
     unidade:string;
     codrepr:integer;
     valor30a,valor60a,valor90a,valor120a,valoracimaa:currency;
     valor30v,valor60v,valor90v,valor120v,valoracimav:currency;
end;

var statusvalidos,titulo,periodo,sqlorder,sqlrecpag,valor,sqlcodtipo,sqltipocad,tipomov:string;
    Q:TSqlquery;
    x,p:integer;
    bxparcial,saldoduplicata,vencido,avencer:currency;
    Lista:Tlist;
    Ponteiro:^Registro;


    function  ChecaBaixaParcial(unidade,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer):currency;
    var Qbx:TSqlquery;
        status,sqlqtipo:string;
        valor:currency;
    begin
      status:=stringtosql('P');
      if Datacont>1 then
//        sqlqtipo:=' and pend_datacont>1'
// 26.04.10
        sqlqtipo:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco)
      else
        sqlqtipo:=' and pend_datacont is null';
      QBx:=sqltoquery('select * from pendencias where pend_status='+status+' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
                      ' and pend_unid_codigo='+stringtosql(unidade)+
                      ' and pend_parcela='+inttostr(parcela)+
                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
      valor:=0;
      while not QBx.eof do begin
        valor:=valor+QBx.fieldbyname('pend_valor').ascurrency;
        QBx.next;
      end;
      Qbx.close;
      Freeandnil(Qbx);
      result:=valor;
    end;


    function Gettipomov(transacao:String):string;
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select moes_tipomov from movesto where moes_transacao='+stringtosql(transacao));
      result:='';
      if not Q.eof then begin
        result:=Q.fieldbyname('moes_tipomov').asstring;
        if result=Global.CodDevolucaoConsig then   //  09.09.05 - gambia para reges -
          result:=Global.CodVendaConsig;
      end else
        result:=Global.CodPendenciaFinanceira;
      Q.close;
      Freeandnil(Q);
    end;

    procedure AtualizaLista(unidade:string ; codrepr:integer ; vencimento:TDatetime ; valor :currency ) ;
    var achou:boolean;
        y:integer;
        
        procedure AtualizaValor(ven:TDatetime ; vlr:currency );
        begin
          if ven>FRelFinan.EdDtposicao.asdate then begin
            if ven-FRelFinan.EdDtposicao.asdate<=30 then
              Ponteiro.valor30a:=Ponteiro.valor30a+vlr
            else if ven-FRelFinan.EdDtposicao.asdate<=60 then
              Ponteiro.valor60a:=Ponteiro.valor60a+vlr
            else if ven-FRelFinan.EdDtposicao.asdate<=90 then
              Ponteiro.valor90a:=Ponteiro.valor90a+vlr
            else if ven-FRelFinan.EdDtposicao.asdate<=120 then
              Ponteiro.valor120a:=Ponteiro.valor120a+vlr
            else
              Ponteiro.valoracimaa:=Ponteiro.valoracimaa+vlr
          end else begin
            if FRelFinan.EdDtposicao.asdate-ven<=30 then
              Ponteiro.valor30v:=Ponteiro.valor30v+vlr
            else if FRelFinan.EdDtposicao.asdate-ven<=60 then
              Ponteiro.valor60v:=Ponteiro.valor60v+vlr
            else if FRelFinan.EdDtposicao.asdate-ven<=90 then
              Ponteiro.valor90v:=Ponteiro.valor90v+vlr
            else if FRelFinan.EdDtposicao.asdate-ven<=120 then
              Ponteiro.valor120v:=Ponteiro.valor120v+vlr
            else
              Ponteiro.valoracimav:=Ponteiro.valoracimav+vlr
          end;
        end;

    begin

      achou:=false;
      for y:=0 to Lista.count-1 do begin
        Ponteiro:=Lista[y];
        if (Ponteiro.unidade=unidade) and (Ponteiro.codrepr=codrepr) then begin
          achou:=true;
          break;
        end;
      end;

      if not achou then begin
         New(Ponteiro);
         Ponteiro.unidade:=unidade;
         Ponteiro.codrepr:=codrepr;
         Ponteiro.valor30a:=0;
         Ponteiro.valor60a:=0;
         Ponteiro.valor90a:=0;
         Ponteiro.valor120a:=0;
         Ponteiro.valoracimaa:=0;
         Ponteiro.valor30v:=0;
         Ponteiro.valor60v:=0;
         Ponteiro.valor90v:=0;
         Ponteiro.valor120v:=0;
         Ponteiro.valoracimav:=0;
         Atualizavalor(vencimento,valor);
         Lista.add(Ponteiro);
      end else begin
         Atualizavalor(vencimento,valor);
      end;
    end;

begin

  with FRelFinan do begin

    if not FRelFinan_Execute(13) then Exit;
    Sistema.BeginProcess('Pesquisando dados');
    if recpag='R' then begin
      sqlrecpag:=' and pend_RP='+stringtosql('R');
      titulo:='Resumo de Recebimentos Vencidos e a Vencer';
    end else begin
      sqlrecpag:=' and pend_RP='+stringtosql('P');
      titulo:='Resumo de Pagamentos Vencidos e a Vencer';
    end;
    statusvalidos:='N;B';
    sqlorder:=' order by pend_unid_codigo,pend_repr_codigo,pend_tipo_codigo,pend_numerodcto,pend_datavcto';
    sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C');
    if EdVencimentoi.asdate>1 then
      periodo:=' Vencimento : '+FGeral.FormataData(EdVencimentoi.AsDate)+' a '+FGeral.FormataData(EdVencimentof.AsDate)
    else
      periodo:='';
    if EdVencimentoi.AsDate>1 then begin
      sqldatavenci:=' and pend_datavcto>='+EdVencimentoi.AsSql+' and pend_datavcto<='+EdVencimentof.AsSql;
    end else
      sqldatavenci:='';

    if EdCodtipo.AsInteger>0 then begin
      titulo:=titulo+' - Codigo '+EdCodtipo.text+' - '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipocad.text,'N');
      if EdTipocad.text='R' then
        sqlcodtipo:=' and pend_repr_codigo='+Edcodtipo.AsSql
      else
        sqlcodtipo:=' and pend_tipo_codigo='+Edcodtipo.AsSql
    end else
      sqlcodtipo:='';
    if Edtipocad.text='C' then begin
      sqltipocad:=' and pend_tipocad='+Edtipocad.AsSql
    end else
      sqltipocad:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else 
//      sqldatacont:=' and pend_datacont > 1';
// 26.04.10
      sqldatacont:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco);

    Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  sqlrecpag+
                  ' and pend_databaixa is null'+
                  sqlunidade+
                  sqldatavenci+
                  sqldatacont+
                  sqlcodtipo+
                  sqltipocad+
                  sqlorder );

    Lista:=Tlist.create;
    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      Sistema.BeginProcess('Separando os prazos de vencimento');
      while not Q.eof do begin
        bxparcial:=ChecaBaixaParcial(Q.FieldByName('pend_unid_codigo').AsString,Q.FieldByName('pend_tipo_codigo').AsString,Q.FieldByName('pend_tipocad').AsString,Q.FieldByName('pend_numerodcto').AsString,Q.FieldByName('pend_dataemissao').Asdatetime,
               Q.FieldByName('pend_datacont').Asdatetime,Q.FieldByName('pend_datavcto').Asdatetime,Q.FieldByName('pend_parcela').Asinteger);
        saldoduplicata:=Q.FieldByName('pend_valor').Ascurrency-bxparcial;
        AtualizaLista(Q.fieldbyname('pend_unid_codigo').asstring,Q.fieldbyname('pend_repr_codigo').asinteger,Q.fieldbyname('pend_datavcto').asdatetime,
                      saldoduplicata);
        Q.Next;
      end;

      Sistema.BeginProcess('Gerando Relatório');
      FRel.Init('RelResumoemAberto');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      if trim(periodo)<>'' then
        FRel.AddTit(Periodo+' - Data escolhida : '+formatdatetime('dd/mm/yy',EdDtposicao.asdate))
      else
        FRel.AddTit('Data escolhida : '+formatdatetime('dd/mm/yy',EdDtposicao.asdate));
      FRel.AddCol( 45,0,'C','' ,''              ,'Unidade'   ,''         ,'',false);
      FRel.AddCol( 45,0,'N','' ,''              ,'Codigo'   ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Representante'      ,''         ,'',false);
      FRel.AddCol( 90,3,'N','+' ,f_cr           ,'Vencido' ,''         ,'',False);
      FRel.AddCol( 90,3,'N','+' ,f_cr           ,'A Vencer' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'30d Vencido',''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'60d Vencido' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'90d Vencido' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'120d Vencido' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Acima' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'30d A Vencer',''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'60d A Vencer' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'90d A Vencer' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'120d A Vencer' ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Acima' ,''         ,'',False);
      for p:=0 to Lista.count-1 do begin
          Ponteiro:=Lista[p];
          FRel.AddCel(Ponteiro.unidade);
          FRel.AddCel(inttostr(Ponteiro.codrepr));
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Ponteiro.codrepr,'R','N'));
          vencido:=Ponteiro.valor30v+Ponteiro.valor60v+Ponteiro.valor90v+Ponteiro.valor120v+Ponteiro.valoracimav;
          avencer:=Ponteiro.valor30a+Ponteiro.valor60a+Ponteiro.valor90a+Ponteiro.valor120a+Ponteiro.valoracimaa;
          FRel.AddCel( floattostr(vencido) );
          FRel.AddCel( floattostr(avencer) );
          FRel.AddCel( floattostr(Ponteiro.valor30v) );
          FRel.AddCel( floattostr(Ponteiro.valor60v) );
          FRel.AddCel( floattostr(Ponteiro.valor90v) );
          FRel.AddCel( floattostr(Ponteiro.valor120v) );
          FRel.AddCel( floattostr(Ponteiro.valoracimav) );
          FRel.AddCel( floattostr(Ponteiro.valor30a) );
          FRel.AddCel( floattostr(Ponteiro.valor60a) );
          FRel.AddCel( floattostr(Ponteiro.valor90a) );
          FRel.AddCel( floattostr(Ponteiro.valor120a) );
          FRel.AddCel( floattostr(Ponteiro.valoracimaa) );
//          FRel.AddCel(formatfloat(f_cr,saldoduplicata));

      end;
      FRel.Setsort('Vencido',false);
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);
    Lista.free;
    FRelFinan_ResumoAberto(Recpag);
  end;
end;

procedure FRelFinan_AtendePrePedidos;     // 14
var statusvalidos,titulo,sqltipocod,sqldata:string;
    Q:TSqlquery;
    conta:integer;
begin
  with FRelFinan do begin
    if not FRelFinan_Execute(14) then Exit;
    Sistema.BeginProcess('Pesquisando');
    titulo:='Relatório de Atendimento de Pré-Pedidos';
    if not EdCodtipo.isempty then
      titulo:=titulo+' / '+fGeral.TituloRelCliRepre(Edcodtipo.AsInteger,EdTipocad.text);
    statusvalidos:='N';
    if EdCodtipo.Asinteger>0 then begin
      if EdTipocad.text='C' then
        sqltipocod:=' and conp_tipo_codigo='+EdCodtipo.assql
      else
        sqltipocod:=' and conp_repr_codigo='+EdCodtipo.assql;
    end else
      sqltipocod:='';
    sqldata:='';
    if EdLancai.asdate>1 then
      sqldata:=' and conp_dataentrega>='+EdLancai.assql;
    if EdLancaf.asdate>1 then
      sqldata:=sqldata+' and conp_dataentrega<='+EdLancaf.assql;

    Q:=sqltoquery('select * from conpedidos inner join clientes on (clie_codigo=conp_tipo_codigo)'+
                  ' where '+FGeral.Getin('conp_status',statusvalidos,'C')+
//                  ' and '+FGeral.getin('conp_unid_codigo',EdUnid_codigo.text,'C')+
                  sqltipocod+sqldata+
                  ' order by conp_repr_codigo,conp_datamvto');
    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      Sistema.BeginProcess('Gerando Relatório');
      FRel.Init('RelAtendimentoprepedido');
      FRel.AddTit(titulo+' / Periodo entrega '+FGeral.formatadata(EdLancai.asdate)+' a '+FGeral.formatadata(EdLancaf.asdate));
//      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddCol( 58,2,'N','' ,''              ,'No.Pedidos'        ,''         ,'',false);
      FRel.AddCol( 43,0,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Atend.'     ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Solic.'     ,''         ,'',False);
      FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Média Mes'       ,''         ,'',False);
      FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Média Tri.'  ,''         ,'',False);
      FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Liberadas'       ,''         ,'',False);
      FRel.AddCol( 70,1,'C','' ,''              ,''                ,''         ,'',False);
      FRel.AddCol( 70,2,'C','' ,''              ,'Complemento'     ,''         ,'',False);
      FRel.AddCol(150,1,'C',''  ,''             ,'Observações'      ,''         ,'',False);
      conta:=0;
      while not Q.eof do begin
        inc(conta);
        FRel.AddCel(inttostr(conta));
//        FRel.AddCel(Q.FieldByName('pend_datamvto').AsString);
        FRel.AddCel(Q.FieldByName('conp_tipo_codigo').AsString);
        FRel.AddCel(Q.FieldByName('clie_nome').AsString);
        FRel.AddCel(Q.FieldByName('conp_dataatend').AsString);
        FRel.AddCel(floattostr(Q.FieldByName('conp_qtdesolic').AsCurrency));
        FRel.AddCel(floattostr(Q.FieldByName('conp_mediamesant').AsCurrency));
        FRel.AddCel(floattostr(Q.FieldByName('conp_mediatrimestre').AsCurrency));
        FRel.AddCel(floattostr(Q.FieldByName('conp_qtdeliber').AsCurrency));
        FRel.AddCel('_____________');
        FRel.AddCel(Q.FieldByName('conp_complemento').AsString);
        FRel.AddCel(Q.FieldByName('conp_obs').AsString);
/////////
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
//////////
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);
  end;
  FRelFinan_AtendePrePedidos;

end;


procedure FRelFinan_RelacaoPrePedidos;     // 15
var statusvalidos,titulo,sqltipocod,sqldata:string;
    Q:TSqlquery;
    conta:integer;
begin
  with FRelFinan do begin
    if not FRelFinan_Execute(15) then Exit;
    Sistema.BeginProcess('Pesquisando');
    titulo:='Relatório de Pré-Pedidos Efetuados';
    if not EdCodtipo.isempty then
      titulo:=titulo+' / '+fGeral.TituloRelCliRepre(Edcodtipo.AsInteger,EdTipocad.text);
    statusvalidos:='N';
    if EdCodtipo.Asinteger>0 then begin
      if EdTipocad.text='C' then
        sqltipocod:=' and conp_tipo_codigo='+EdCodtipo.assql
      else
        sqltipocod:=' and conp_repr_codigo='+EdCodtipo.assql;
    end else
      sqltipocod:='';
    sqldata:='';
    if EdLancai.asdate>1 then
      sqldata:=' and conp_dataentrega>='+EdLancai.assql;
    if EdLancaf.asdate>1 then
      sqldata:=sqldata+' and conp_dataentrega<='+EdLancaf.assql;

    Q:=sqltoquery('select * from conpedidos inner join clientes on (clie_codigo=conp_tipo_codigo)'+
                  ' inner join representantes on ( repr_codigo=conp_repr_codigo )'+
                  ' where '+FGeral.Getin('conp_status',statusvalidos,'C')+
                  sqltipocod+sqldata+
                  ' order by conp_repr_codigo,conp_datamvto');
    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      Sistema.BeginProcess('Gerando Relatório');
      FRel.Init('RelacaoPrepedidos');
      FRel.AddTit(titulo+' / Periodo entrega '+FGeral.formatadata(EdLancai.asdate)+' a '+FGeral.formatadata(EdLancaf.asdate));
//      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddCol( 58,2,'N','' ,''              ,'No.Pedidos'        ,''         ,'',false);
      FRel.AddCol( 43,0,'N','' ,''              ,'Cliente'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome cliente'            ,''         ,'',false);
      FRel.AddCol( 43,0,'C','' ,''              ,'Repr.'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome Representante'            ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Digitação'     ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Atend.'     ,''         ,'',false);
      FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Solic.'     ,''         ,'',False);
      FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Média Mes'       ,''         ,'',False);
      FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Média Tri.'  ,''         ,'',False);
      FRel.AddCol( 60,3,'N','+' ,f_cr           ,'Liberadas'       ,''         ,'',False);
      FRel.AddCol( 70,2,'C','' ,''              ,'Complemento'     ,''         ,'',False);
      FRel.AddCol(150,1,'C',''  ,''             ,'Observações'      ,''         ,'',False);
      FRel.AddCol( 80,1,'C','' ,''              ,'Usuário Autor.'               ,''         ,'',false);
      FRel.AddCol(200,1,'C','' ,''              ,'Motivo Autorização'           ,''         ,'',false);
      conta:=0;
      while not Q.eof do begin
        inc(conta);
        FRel.AddCel(inttostr(conta));
//        FRel.AddCel(Q.FieldByName('pend_datamvto').AsString);
        FRel.AddCel(Q.FieldByName('conp_tipo_codigo').AsString);
        FRel.AddCel(Q.FieldByName('clie_nome').AsString);
        FRel.AddCel(Q.FieldByName('conp_repr_codigo').AsString);
        FRel.AddCel(Q.FieldByName('repr_nome').AsString);
        FRel.AddCel(Q.FieldByName('conp_datalcto').AsString);
        FRel.AddCel(Q.FieldByName('conp_dataatend').AsString);
        FRel.AddCel(floattostr(Q.FieldByName('conp_qtdesolic').AsCurrency));
        FRel.AddCel(floattostr(Q.FieldByName('conp_mediamesant').AsCurrency));
        FRel.AddCel(floattostr(Q.FieldByName('conp_mediatrimestre').AsCurrency));
        FRel.AddCel(floattostr(Q.FieldByName('conp_qtdeliber').AsCurrency));
        FRel.AddCel(Q.FieldByName('conp_complemento').AsString);
        FRel.AddCel(Q.FieldByName('conp_obs').AsString);
        FRel.AddCel(FUsuarios.GetNome( Q.fieldbyname('conp_usualibcred').asinteger) );
        FRel.AddCel(Q.fieldbyname('conp_obslibcredito').asstring);
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);
  end;
  FRelFinan_RelacaoPrePedidos;
end;


procedure FRelFinan_ImpBloqueto;     // 16
////////////////////////////////////////////
var Q:Tsqlquery;

begin
  with FRelFinan do begin
    if not FRelFinan_Execute(16) then Exit;
// 22.01.13 - Bavi
    Q:=sqltoquery('select moes_numerodoc from movesto where moes_transacao='+stringtosql(Global.UltimaTransacao)+
                  ' and moes_status<>''C'' and '+FGeral.GetIN('moes_tipomov',Global.TiposRelVenda+';'+Global.CodCompraProdutor,'C') );
    if not Q.eof then
      EdNumerodoc.setvalue( Q.fieldbyname('moes_numerodoc').asinteger );
    FGeral.fechaquery(Q);
    if EdVencimento.isempty then
      FImpressao.ImprimeBloqueto(EdNumerodoc.asinteger,EdNumerodocf.asinteger,EdDtEmissao.AsDate,copy(EdUnid_codigo.text,1,3),EdTipomov.text)
    else
      FImpressao.ImprimeBloqueto(EdNumerodoc.asinteger,EdNumerodocf.asinteger,EdDtEmissao.AsDate,copy(EdUnid_codigo.text,1,3),EdTipomov.text,Strtodate(EdVencimento.text));
    FRelFinan_ImpBloqueto;
  end;
end;

// 23.08.06
procedure FRelFinan_Orcamento;    //17
////////////////////////////////////////////////////////////
type TMeses=record
    mes,ano:integer;
    realizado,orcado:currency;
end;

type TOrc=record
    conta:integer;
    descricao,setor,descricaosetor,classifica:string;
//    realizado,orcado:currency;
    ListaMeses:TList;
end;

var statusvalidos,titulo,sqldata,compete,sqlcontas,sqlsetores,sqlcontaorc,sqlcontapen,sqlcontaplano,
    sqlcontanotase,sqlcontamovfin:string;
    Q,QOrc,QNotasE,QNotasAux,QPende:TSqlquery;
    p,contager,t,n:integer;
    Datai,Dataf:TDatetime;
    Ponteiro,P2:^TOrc;
    PMeses,PMeses2:^TMeses;
    Lista,ListaPlano,ListaPlano2:TList;
    difvalor,difperc,totcontaorcado,totcontarealizado:currency;
    campovlrreal:TDicionario;

    procedure Atualiza(o:string ; conta:integer ; valor:currency ; xdata:TDatetime ; setor:string='' ; vlrreal:currency=0);
    ///////////////////////////////////////////////////////////////////////////////////////////
    var x:integer;
        achou:boolean;
        ydata:TDatetime;

        procedure AtualizaMesano;
        //////////////////////////
        var y:integer;
        begin
          for y:=0 to Ponteiro.ListaMeses.Count-1 do begin
            PMeses2:=Ponteiro.ListaMeses[y];
            if ( Pmeses2.ano=Datetoano(xdata,true) ) and ( Pmeses2.mes=Datetomes(xdata) ) then begin
              if o='R' then
                PMeses2.realizado:=PMeses2.realizado + valor
              else begin
                PMeses2.orcado:=PMeses2.orcado + valor;
                if vlrreal>0 then
                  PMeses2.realizado:=vlrreal;
              end;
            end;
          end;
        end;

    begin
    ////////////////////////////////////
       achou:=false;
       for x:=0 to Lista.count-1 do begin
         Ponteiro:=Lista[x];
         if Ponteiro.conta=conta then begin
           achou:=true;
           break;
         end;
       end;
       if not achou then begin
         New(Ponteiro);
         Ponteiro.conta:=conta;
         Ponteiro.descricao:=FPlano.Getdescricao(conta);
//         Ponteiro.realizado:=0;
//         Ponteiro.orcado:=0;
// inicializar todos os meses do periodo pedido pois em certos meses
// a conta poderá não ter movimento dai fica 'sem criar o mes da conta'...
         ydata:=datai;
         Ponteiro.ListaMeses:=TList.create;
         while ydata<=dataf do begin
           New(PMeses);
           PMeses.mes:=Datetomes(ydata);
           PMeses.ano:=Datetoano(ydata,true);
           PMeses.realizado:=0;
           PMeses.orcado:=0;
           Ponteiro.ListaMeses.Add(PMeses);
           ydata:=DatetoDatemespos(ydata,1);
         end;
         Ponteiro.classifica:=FPlano.GetClassificacao(conta);
         if t=0 then
           t:=Length(trim(Ponteiro.classifica));

         if o='R' then begin
//            PMeses.realizado:=valor;
//           Ponteiro.realizado:=valor;
           AtualizaMesano;
           Ponteiro.descricaosetor:='';
         end else begin
//           Ponteiro.orcado:=valor;
//            PMeses.orcado:=valor;
           AtualizaMesano;
           if vlrreal>0 then
 //            Ponteiro.realizado:=vlrreal;
//             PMeses.realizado:=vlrreal;
             AtualizaMesano;
           if trim(setor)<>'' then begin
             Ponteiro.setor:=setor;
             Ponteiro.descricaosetor:=FSetores.Getdescricao(setor)
           end else begin
             Ponteiro.setor:='';
             Ponteiro.descricaosetor:='';
           end;
         end;
         Lista.add(Ponteiro);

       end else begin  // achou

         if o='R' then
//           Ponteiro.realizado:=Ponteiro.realizado + valor
           AtualizaMesano
         else begin
           AtualizaMesano;
//           Ponteiro.orcado:=Ponteiro.orcado + valor;
//           if vlrreal>0 then
//             Ponteiro.realizado:=vlrreal;
           if trim(setor)<>'' then begin
             Ponteiro.setor:=setor;
             Ponteiro.descricaosetor:=FSetores.Getdescricao(setor);
           end;
         end;

       end;
    end;

    function SetorOk(xsetor:string):boolean;
    begin
      result:=true;
      if ( not FRelfinan.EdSeto_codigo.isempty ) and (FRelfinan.EdSeto_codigo.text<>xsetor) then
        result:=false;
    end;

// 19.05.10 - atualiza o plano de contas com todas as contas
//////////////////////////////////////////////////////////////////
    procedure AtualizaPlano;
//////////////////////////////////////////////////////////////////
    var Qp:TSqlquery;
        p,i,n:integer;
        ydata:TDatetime;
    begin
      Qp:=sqltoquery('select plan_Classificacao,plan_conta,plan_descricao,plan_tipo from plano'+
                     sqlcontaplano+
                     ' order by plan_classificacao');
      while not Qp.eof do begin
        New(Ponteiro);
        Ponteiro.conta:=QP.fieldbyname('plan_conta').asinteger;
        Ponteiro.descricao:=QP.fieldbyname('plan_descricao').asstring;
        Ponteiro.setor:='';
        Ponteiro.descricaosetor:='';
//        Ponteiro.realizado:=0;
//        Ponteiro.orcado:=0;
// 09.05.11
        Ponteiro.classifica:=QP.fieldbyname('plan_classificacao').asstring;
        ydata:=datai;
        Ponteiro.ListaMeses:=TList.create;
        while ydata<=dataf do begin
           New(PMeses);
           PMeses.mes:=Datetomes(ydata);
           PMeses.ano:=Datetoano(ydata,true);
           PMeses.realizado:=0;
           PMeses.orcado:=0;
           Ponteiro.ListaMeses.Add(PMeses);
           ydata:=DatetoDatemespos(ydata,1);
        end;
        ListaPlano.Add(Ponteiro);
        QP.Next;
      end;
      FGeral.FechaQuery(Qp);

      for p:=0 to ListaPlano.Count-1 do begin
        Ponteiro:=ListaPlano[p];
        for i:=0 to Lista.Count-1 do begin
          P2:=Lista[i];
          if Ponteiro.conta=P2.conta then begin
            Ponteiro.setor:=P2.setor;
            Ponteiro.descricaosetor:=P2.descricaosetor;
//            Ponteiro.realizado:=P2.realizado;
//            Ponteiro.orcado:=P2.orcado;
            Ponteiro.ListaMeses.Clear;  // senao dobra a lista de meses ?
            for n:=0 to P2.ListaMeses.Count-1 do begin
              PMeses2:=P2.ListaMeses[n];
              Ponteiro.ListaMeses.Add(PMeses2)
//              if (PMeses2.ano=Ponteiro.PMeses.ano) and (PMeses2.mes=Ponteiro.PMeses.mes)
//                Ponteiro.PMeses.realizado:=P2.realizado;
//                Ponteiro.PMeses.orcado:=P2.orcado;
//              end;
            end;
          end;
        end;
      end;

      for p:=0 to ListaPlano.Count-1 do begin
        P2:=ListaPlano[p];
        ListaPlano2.Add(P2)
      end;

      p:=0;
      while p < ListaPlano.Count do begin
        Ponteiro:=ListaPlano[p];
        if FPlano.GetTipo(Ponteiro.conta)='S' then begin
          i:=0;
          while i < ListaPlano2.Count do begin
            P2:=ListaPlano2[i];
  //          if LeftStr(Ponteiro.classifica,t)=P2.classifica then begin
            if pos(trim(Ponteiro.classifica),P2.classifica)=1 then begin
//              Ponteiro.realizado:=Ponteiro.realizado+P2.realizado;
//              Ponteiro.orcado:=Ponteiro.orcado+P2.orcado;
              for n:=0 to P2.ListaMeses.Count-1 do begin
                PMeses2:=P2.ListaMeses[n];
                PMeses:=Ponteiro.ListaMeses[n];
                if (PMeses2.mes=PMeses.mes) and (Pmeses2.ano=PMeses.ano) then begin
                  PMeses.realizado:=PMeses.realizado+PMeses2.realizado;
                  PMeses.orcado:=PMeses.orcado+PMeses2.orcado;
                end;
              end;
            end;
            inc(i);
          end;
        end;
        inc(p);
      end;

    end;

begin
//////////////////////////////////////////////////////

  with FRelFinan do begin
    if not FRelFinan_Execute(17) then Exit;
    if EdMesano.isempty then begin
      Avisoerro('Mes/ano inicial tem que ser informado');
      exit;
    end;
    if EdMesanofinal.isempty then begin
      Avisoerro('Mes/ano final tem que ser informado');
      exit;
    end;
    if EdMesanoorcado.isempty then begin
      Avisoerro('Mes/ano do orçamento tem que ser informado');
      exit;
    end;
    if EdCompete.text='1' then
      compete:='N'
    else
      compete:='S';
    if (EdMesano.text=EdMesanofinal.text) then begin
      if compete<>'S' then
        titulo:='Controle Orçamentário por Caixa de '+copy(Edmesano.text,1,2)+'/'+copy(Edmesano.text,3,4)+
               ' a '+copy(Edmesanofinal.text,1,2)+'/'+copy(Edmesanofinal.text,3,4)+
               ' com orçamento de '+
               copy(Edmesanoorcado.text,1,2)+'/'+copy(Edmesanoorcado.text,3,4)
      else
        titulo:='Controle Orçamentário pela Competência de '+copy(Edmesano.text,1,2)+'/'+copy(Edmesano.text,3,4)+
                ' a '+copy(Edmesanofinal.text,1,2)+'/'+copy(Edmesanofinal.text,3,4)+
                ' com orçamento de '+
               copy(Edmesanoorcado.text,1,2)+'/'+copy(Edmesanoorcado.text,3,4);
    end else begin
      if compete<>'S' then
        titulo:='Controle Orçamentário por Caixa de '+copy(Edmesano.text,1,2)+'/'+copy(Edmesano.text,3,4)+
               ' a '+copy(Edmesanofinal.text,1,2)+'/'+copy(Edmesanofinal.text,3,4)+
               ' com orçamento do mesmo periodo'
      else
        titulo:='Controle Orçamentário pela Competência de '+copy(Edmesano.text,1,2)+'/'+copy(Edmesano.text,3,4)+
                ' a '+copy(Edmesanofinal.text,1,2)+'/'+copy(Edmesanofinal.text,3,4)+
                ' com orçamento do mesmo periodo';
    end;

    statusvalidos:='N';
    t:=0;  // tamanho da mascara do plano gerencial de contas

    datai:=texttodate('01'+EdMesano.text);
//    dataf:=Datetoultimodiames(datai);
    dataf:=texttodate('01'+EdMesanofinal.text);
    dataf:=Datetoultimodiames(dataf);
//    sqlsetores:='';
//    if not EdSeto_codigo.isempty then
//      sqlsetores:=' and '+fGeral.GetIN('dota_seto_codigo',EdSEto_codigo.text,'C');
// 20.04.11 - Abra -Paulo
    sqlcontaplano:='';
    sqlcontanotase:='';
    sqlcontapen:='';
    sqlcontamovfin:='';
    if not EdPlan_conta.IsEmpty then begin
      sqlcontaplano:=' where plan_conta = '+EdPlan_conta.AsSql;
      sqlcontanotase:=' and moes_plan_codigo = '+EdPlan_conta.AsSql;
      sqlcontapen:=' and pend_plan_conta = '+EdPlan_conta.AsSql;
      sqlcontamovfin:=' and movf_plan_contard = '+EdPlan_conta.AsSql;
    end;
    if Compete='S' then begin
      Sistema.BeginProcess('Pesquisando notas de entrada e movimento financeiro');
      statusvalidos:='N;D;E;B';
      QNotasE:=Sqltoquery('select moes_plan_codigo,moes_vlrtotal,moes_transacao,moes_datamvto from movesto'+
                  ' where '+FGeral.Getin('moes_status',statusvalidos,'C')+
                  ' and '+FGeral.Getin('moes_unid_codigo',EdUNid_codigo.text,'C')+
                  ' and '+FGeral.Getin('moes_tipomov',Global.TiposEntrada,'C')+
                  sqlcontanotase+
//                  ' and moes_plan_codigo>0'+
                  ' and moes_datamvto>='+Datetosql(datai)+' and moes_datamvto<='+Datetosql(dataf) );
//                  ' group by moes_plan_codigo' );

      QPende:=Sqltoquery('select pend_plan_conta,pend_valor,pend_datamvto from pendencias'+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  ' and '+FGeral.Getin('pend_unid_codigo',EdUNid_codigo.text,'C')+
                  ' and '+FGeral.Getin('pend_tipomov',Global.CodPendenciaFinanceira,'C')+
                  sqlcontapen+
                  ' and '+FGeral.Getin('pend_rp','P','C')+
//                  ' and moes_plan_codigo>'+
                  ' and pend_datamvto>='+Datetosql(datai)+' and pend_datamvto<='+Datetosql(dataf) );

      sqldata:=' and movf_datamvto>='+Datetosql(datai)+' and movf_datamvto<='+Datetosql(dataf);
      if trim( FGeral.GetConfig1AsString('ContasMovfin') ) <> '' then begin
        sqlcontas:=' and '+FGeral.GetIN('movf_plan_contard',FGeral.GetConfig1AsString('ContasMovfin'),'N');
        if trim( FGeral.GetConfig1AsString('ContasMovfin1') ) <> '' then
          sqlcontas:=sqlcontas+' and '+FGeral.GetIN('movf_plan_contard',FGeral.GetConfig1AsString('ContasMovfin1'),'N');
// 28.01.11
     end else
        sqlcontas:=' and movf_plan_contard=989898';  // para nao buscar nada no movfin
      Q:=sqltoquery('select * from movfin inner join plano on (plan_conta=movf_plan_contard)'+
                  ' where '+FGeral.Getin('movf_status',statusvalidos,'C')+
                  ' and '+FGeral.Getin('movf_unid_codigo',EdUNid_codigo.text,'C')+
                  sqldata+sqlcontas+sqlcontamovfin+
// 16.03.10 - Abra
                  ' and movf_tipomov='+Stringtosql(Global.CodLanCaixabancos)+
                  ' order by movf_plan_contard');
    end else begin
      Sistema.BeginProcess('Pesquisando movimento financeiro');
      sqldata:=' and movf_datamvto>='+Datetosql(datai)+' and movf_datamvto<='+Datetosql(dataf);
      Q:=sqltoquery('select * from movfin inner join plano on (plan_conta=movf_plan_contard)'+
                  ' where '+FGeral.Getin('movf_status',statusvalidos,'C')+
                  ' and '+FGeral.Getin('movf_unid_codigo',EdUNid_codigo.text,'C')+
                  sqldata+sqlcontamovfin+
                  ' order by movf_plan_contard');
    end;
    if (Q.Eof) and (Compete<>'S') then
      Avisoerro('Nada encontrado para impressão')
    else begin
      Sistema.BeginProcess('Acumulando valores por conta');
      Lista:=TList.create;
      while not Q.eof do begin
        Atualiza('R',Q.fieldbyname('movf_plan_contard').asinteger,Q.fieldbyname('movf_valorger').ascurrency,Q.fieldbyname('movf_datamvto').asdatetime);
        Q.Next;
      end;
// 22.04.10 - algumas contas busca 'todos' os lanctos e nao somente os 'LC'
      if trim( FGeral.GetConfig1AsString('ContasOrcam') ) <> '' then begin
        sqlcontas:=' and '+FGeral.GetIN('movf_plan_contard',FGeral.GetConfig1AsString('ContasOrcam'),'N');
        Q:=sqltoquery('select * from movfin inner join plano on (plan_conta=movf_plan_contard)'+
                  ' where '+FGeral.Getin('movf_status',statusvalidos,'C')+
                  ' and '+FGeral.Getin('movf_unid_codigo',EdUNid_codigo.text,'C')+
                  sqldata+sqlcontas+sqlcontamovfin+
                  ' order by movf_plan_contard');
        while not Q.eof do begin
          Atualiza('R',Q.fieldbyname('movf_plan_contard').asinteger,Q.fieldbyname('movf_valorger').ascurrency,Q.fieldbyname('movf_datamvto').asdatetime);
          Q.Next;
        end;
      end;

      if Compete='S' then begin
        while not QNotasE.eof do begin
          if QNotasE.fieldbyname('moes_plan_codigo').asinteger>0 then
            contager:=QNotasE.fieldbyname('moes_plan_codigo').asinteger
          else begin
            QNotasAux:=Sqltoquery('select pend_plan_conta from pendencias where pend_transacao='+Stringtosql(QNotasE.fieldbyname('moes_transacao').asstring));
            contager:=0;
            if not QNotasAux.eof then begin
              if QNotasAux.fieldbyname('pend_plan_conta').asinteger>0 then
                contager:=QNotasAux.fieldbyname('pend_plan_conta').asinteger;
            end;
            Fgeral.FechaQuery(QNotasAux);
          end;
          if contager>0 then
            Atualiza('R',contager,QNotasE.fieldbyname('moes_vlrtotal').ascurrency,QNotasE.fieldbyname('moes_datamvto').asdatetime);
          QNotasE.Next;
        end;
        while not QPende.eof do begin
          contager:=QPende.fieldbyname('pend_plan_conta').asinteger;
          if contager>0 then begin
// 23.04.10 - contas de emprestimo considerar somente o q é lançado no caixa bancos
            if FPlano.GetTipo( contager ) <> 'E' then
              Atualiza('R',contager,QPende.fieldbyname('pend_valor').ascurrency,QPende.fieldbyname('pend_datamvto').asdatetime);
          end;
          QPende.Next;
        end;

      end;
      if (EdMesano.text=EdMesanofinal.text) then begin
        QOrc:=sqltoquery('select * from dotacoes where '+FGeral.GetIN('dota_unid_codigo',EdUNid_codigo.TExt,'C')+
                       ' and dota_data='+Datetosql( texttodate('01'+EdMesanoorcado.text) ) );
      end else begin
        QOrc:=sqltoquery('select * from dotacoes where '+FGeral.GetIN('dota_unid_codigo',EdUNid_codigo.TExt,'C')+
                       ' and dota_data>='+Datetosql( texttodate('01'+EdMesano.text) )+
                       ' and dota_data<='+Datetosql( texttodate('01'+EdMesanofinal.text) ) );
      end;
      campovlrreal:=Sistema.GetDicionario('dotacoes','dota_vlrreal');
      while not QOrc.eof do begin
        if campovlrreal.Tipo<>'' then
          Atualiza('O',QOrc.fieldbyname('dota_plan_conta').asinteger,QOrc.fieldbyname('dota_valor').ascurrency,
                   QOrc.fieldbyname('dota_data').asdatetime,
                   QOrc.fieldbyname('dota_seto_codigo').asstring,QOrc.fieldbyname('dota_vlrreal').ascurrency)
        else
          Atualiza('O',QOrc.fieldbyname('dota_plan_conta').asinteger,QOrc.fieldbyname('dota_valor').ascurrency,
                    QOrc.fieldbyname('dota_data').asdatetime,
                    QOrc.fieldbyname('dota_seto_codigo').asstring);
        QOrc.next;
      end;
// 19.05.10 - Abra - Joce+Paulo
//
      ListaPlano:=TList.create;
      ListaPlano2:=TList.create;
      Sistema.BeginProcess('Acumulando valores por grupos e subgrupos');
      AtualizaPlano;

//////////
      Sistema.BeginProcess('Gerando Relatório');
      FRel.Init('ControleOrcamentario');
      FRel.AddTit(titulo);
      FRel.AddTit('Unidades analisadas : '+EdUnid_codigo.Text);
      if not EdSeto_codigo.isempty then
        FRel.AddTit('Setor : '+EdSeto_codigo.Text+' - '+FSetores.GetDescricao(EdSeto_codigo.Text) );
      FRel.AddCol( 50,3,'N','' ,''              ,'Conta'          ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Classificação'      ,''         ,'',false);
      FRel.AddCol(150,1,'C','' ,''              ,'Descrição'      ,''         ,'',false);
      if EdSeto_codigo.isempty then begin
        FRel.AddCol( 50,3,'N','' ,''              ,'Setor'          ,''         ,'',false);
        FRel.AddCol(150,1,'C','' ,''              ,'Descrição Setor'      ,''         ,'',false);
      end;
      Ponteiro:=ListaPlano[0];
      for p:=0 to Ponteiro.ListaMeses.Count-1 do begin
        PMeses:=Ponteiro.ListaMeses[p];
        FRel.AddCol( 90,3,'N','+' ,f_cr           ,strzero(PMeses.mes,2)+'/'+strzero(PMeses.ano,4)     ,'Orçado'         ,'',False);
        FRel.AddCol( 90,3,'N','+' ,f_cr           ,''       ,'Realizado'         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Dif.Valor'  ,''         ,'',False);
        FRel.AddCol( 60,3,'N','&' ,f_cr           ,'Dif. %'       ,''         ,'',False);
      end;
      FRel.AddCol( 90,3,'N','+' ,f_cr           ,'Total'      ,'Orçado'         ,'',False);
      FRel.AddCol( 90,3,'N','+' ,f_cr           ,'Total'      ,'Realizado'         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Dif.Tot.Valor'  ,''         ,'',False);
      FRel.AddCol( 60,3,'N','&' ,f_cr           ,'Dif.Tot. %'       ,''         ,'',False);

//      FRel.AddCol( 90,3,'N','' ,f_cr           ,'Orçado'     ,''         ,'',False);
//      FRel.AddCol( 90,3,'N','' ,f_cr           ,'Realizado'       ,''         ,'',False);

      for p:=0 to LIstaPlano.count-1 do begin
        Ponteiro:=ListaPlano[p];
        if Setorok(Ponteiro.setor) then begin
          FRel.AddCel(inttostr(Ponteiro.conta));
//          FRel.AddCel( Trans( FPlano.GetClassificacao( Ponteiro.conta) ,Stringtosql(FGeral.GetConfig1AsString('Mascaraplanoger')) ) );
//          FRel.AddCel( FPlano.FormataClassificacao(FPlano.GetClassificacao( Ponteiro.conta)));
          FRel.AddCel( FPlano.FormataClassificacao(Ponteiro.classifica) );
          FRel.AddCel(Ponteiro.descricao);
          if EdSeto_codigo.isempty then begin
            FRel.AddCel(Ponteiro.setor);
            FRel.AddCel(Ponteiro.descricaosetor);
          end;
//          FRel.AddCel(floattostr(Ponteiro.orcado));
//          FRel.AddCel(floattostr(Ponteiro.realizado));

          totcontaorcado:=0 ; totcontarealizado:=0;
          for n:=0 to Ponteiro.ListaMeses.Count-1 do begin
            PMeses:=Ponteiro.ListaMeses[n];
            FRel.AddCel(floattostr(PMeses.orcado));
            FRel.AddCel(floattostr(PMeses.realizado));
//            difvalor:=Ponteiro.orcado-Ponteiro.realizado;
            difvalor:=PMeses.orcado-PMeses.realizado;
            totcontaorcado:=totcontaorcado+PMeses.orcado;
            totcontarealizado:=totcontarealizado+PMeses.realizado;

            if PMeses.orcado>0 then begin
              if difvalor=0 then
                difperc:=0
              else if difvalor>0 then begin
                if PMeses.realizado>0 then
                  difperc:=(difvalor/PMeses.orcado)*100
                else
                  difperc:=0;
              end else
                difperc:=(difvalor/PMeses.orcado)*100;
            end else begin
              if difvalor>0 then
                difperc:=100
              else
                difperc:=-100;
            end;
            FRel.AddCel(floattostr(difvalor));
            FRel.AddCel(floattostr(difperc));
          end;  // for dos meses de cada conta
// 16.05.11 - totais de cada conta...
          FRel.AddCel(floattostr(totcontaorcado));
          FRel.AddCel(floattostr(totcontarealizado));
          if totcontaorcado>0 then begin
              if difvalor=0 then
                difperc:=0
              else if difvalor>0 then begin
                if totcontarealizado>0 then
                  difperc:=(difvalor/totcontaorcado)*100
                else
                  difperc:=0;
              end else
                difperc:=(difvalor/totcontaorcado)*100;
            end else begin
              if difvalor>0 then
                difperc:=100
              else
                difperc:=-100;
            end;
            FRel.AddCel(floattostr(difvalor));
            FRel.AddCel(floattostr(difperc));


        end;
      end;
      FRel.setsort('Classificação');
      FRel.Video;
    end;
    Lista.Free;
    ListaPlano.free;
    ListaPlano2.free;
    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);
    if compete='S' then begin
      FGeral.FechaQuery(QNotasE);
      FGeral.FechaQuery(QPende);
    end;
    FGeral.FechaQuery(QOrc);
  end;
  FRelFinan_Orcamento;
end;

////////////////////////////
procedure FRelFinan_PosicaoCheques(RecPag:string);     // 18
/////////////////////////////////////////////////////
var statusvalidos,titulo,sqlorder,sqlrecpag,sqltipocod:string;
    Q:TSqlquery;
    Qbx:TSqlquery;
    valor:currency;

// 11.10.10

    function EstaValendo:boolean;
    ///////////////////////
    begin
//      if Q.Fieldbyname('cheq_emissao').asdatetime>FRElfinan.EdDtPosicao.Asdate then
// 07.11.07 - Isonel
      if Q.Fieldbyname('cheq_lancto').asdatetime>FRElfinan.EdDtPosicao.Asdate then
        result:=false
      else if (Q.Fieldbyname('cheq_deposito').asdatetime>FRElfinan.EdDtPosicao.Asdate ) and (Q.Fieldbyname('cheq_deposito').asdatetime>1) then
        result:=true
      else if (Q.Fieldbyname('cheq_deposito').asdatetime<=FRElfinan.EdDtPosicao.Asdate ) and (Q.Fieldbyname('cheq_deposito').asdatetime>1) then
        result:=false
      else
        result:=true;
    end;

begin

  with FRelFinan do begin
    if not FRelFinan_Execute(18,Recpag) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    sqlrecpag:=' and cheq_emirec='+stringtosql(Recpag);
    if RecPag='R' then begin
      titulo:='Relatório de Cheques Recebidos - ';
    end else begin
      titulo:='Relatório de Cheques Emitidos - ';
    end;
    statusvalidos:='N';
    titulo:=titulo+'Posição Financeira de Cheques em '+FGeral.FormataData(EdDtposicao.asdate);
    sqlorder:=' order by cheq_unid_codigo,cheq_tipo_codigo,cheq_emissao,cheq_cheque';
    sqlunidade:=' and '+FGeral.getin('cheq_unid_codigo',EdUnid_codigo.text,'C');
    if EdCodtipo.Asinteger>0 then
      sqltipocod:=' and ( (cheq_tipo_codigo='+EdCodtipo.assql+') and (cheq_tipocad='+EdTipocad.Assql+') )'
    else
      sqltipocod:='';
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and cheq_datacont > 1';
// 26.04.10
      sqldatacont:=' and cheq_datacont > '+DateToSql(Global.DataMenorBanco);

    Q:=sqltoquery('select * from cheques'+
                  ' where '+FGeral.Getin('cheq_status',statusvalidos,'C')+
                  sqlrecpag+
                  ' and cheq_emissao<='+EdDtposicao.AsSql+
                  sqlunidade+
                  sqldatacont+
                  sqltipocod+
                  sqlorder );


    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      FRel.Init('RelPosicaoFinCheques');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      if not EdCodtipo.isempty then
        FRel.Addtit('Codigo :'+EdCodtipo.text+' - '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipocad.text,'N') );
//      FRel.AddTit(Periodo);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Lançamento'      ,''         ,'',false);
      if Global.Usuario.OutrosAcessos[0701] then
         FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero'          ,''         ,'',False);
      FRel.AddCol( 60,0,'C','' ,''              ,'Tipo'            ,''         ,'',false);
      FRel.AddCol( 45,1,'N','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Emitente'        ,''         ,'',false);
      FRel.AddCol( 55,1,'D','' ,''              ,'Vencim.'         ,''         ,'',false);
      FRel.AddCol( 55,1,'D','' ,''              ,'Baixa'           ,''         ,'',false);
      FRel.AddCol( 70,3,'N','+' ,f_cr           ,'Valor  '         ,''         ,'',False);
      while not Q.eof do begin
        if Estavalendo then begin
          FRel.AddCel(Q.FieldByName('cheq_unid_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('cheq_lancto').AsString);
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel(Q.FieldByName('cheq_datacont').AsString);
          FRel.AddCel(Q.FieldByName('cheq_emissao').AsString);
          FRel.AddCel(Q.FieldByName('cheq_cheque').AsString);
          FRel.AddCel(Q.FieldByName('cheq_tipocad').AsString);
          FRel.AddCel(Q.FieldByName('cheq_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'N'));
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('cheq_tipo_codigo').AsInteger,Q.FieldByName('cheq_tipocad').AsString,'R'));
          FRel.AddCel(Q.FieldByName('cheq_emitente').AsString);
          FRel.AddCel(Q.FieldByName('cheq_predata').AsString);
          FRel.AddCel(Q.FieldByName('cheq_deposito').AsString);
//          FRel.AddCel(Q.FieldByName('cheq_valor').AsString);
          if Q.FieldByName('cheq_deposito').AsDatetime>1 then begin
// 11.10.10 - baixa parcial de cheque          
            if (Q.Fieldbyname('cheq_deposito').asdatetime>=FRElfinan.EdDtPosicao.Asdate ) then begin
                FRel.AddCel(Q.FieldByName('cheq_valor').AsString);
            end else begin
              if Q.FieldByName('cheq_valorrec').AsCurrency>0 then
                FRel.AddCel(Q.FieldByName('cheq_valorrec').AsString)
              else
                FRel.AddCel(Q.FieldByName('cheq_valor').AsString);
            end;
          end else
            FRel.AddCel(Q.FieldByName('cheq_valor').AsString);

        end;
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);
  end;
  FRelFinan_PosicaoCheques(Recpag);
end;

///////////////////////////////////////////////////////////////////////////
procedure FRelFinan_Comissao;       // 19
///////////////////////////////////////////////////////////////////////////
var statusvalidos,titulo,periodo,sqlorder,sqlrecpag,valor,sqlcodtipo,sqltipocad,tipomov,tipomovdev,oscodigos,titvencidos,
    unidadebaixa,junta,sqlconta,Rel,sqlreprenaorateia,naorateia,recpag  :string;
    Q,QRepr     :TSqlquery;
    valorx,vlrtotalrec,vlrcomissao,vlrtotcom,vlrreserva:currency;
    ListaCodigos:TStringlist;


    function GetUnidadeCaixaBancos(transacao:string):string;
    var Q:TSqlquery;
    begin
      result:=space(3);
      Q:=sqltoquery('select movf_unid_codigo from movfin where movf_transacao='+stringtosql(transacao));
      if not Q.eof then
        result:=Q.fieldbyname('movf_unid_codigo').asstring;
      FGeral.FechaQuery(Q);
    end;

    procedure ChecaBaixaParcial(unidade,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer;saldo:currency);
    var Qbx:TSqlquery;
        status,sqlqtipo:string;
        saldox:currency;
    begin
      if Rel='PEN' then
        status:=stringtosql('P')
      else
        status:=stringtosql('N');
      if Datacont>1 then
//        sqlqtipo:=' and pend_datacont>1'
// 26.04.10
        sqlqtipo:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco)
      else
        sqlqtipo:=' and pend_datacont is null';
      QBx:=sqltoquery('select * from pendencias where pend_status='+status+' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
                      ' and pend_parcela='+inttostr(parcela)+
                      ' and pend_unid_codigo='+stringtosql(unidade)+
//                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
      if QBx.eof then begin
         QBx.close;
         Freeandnil(QBx);
         QBx:=sqltoquery('select * from pendencias where pend_status='+status+' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
//                      ' and pend_parcela='+inttostr(parcela)+
                      ' and pend_unid_codigo='+stringtosql(unidade)+
                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
     end;
      saldox:=saldo;
      while not Qbx.eof do begin
          FRel.AddCel(QBx.FieldByName('pend_transacao').AsString);
          FRel.AddCel(QBx.FieldByName('pend_operacao').AsString);
          FRel.AddCel(QBx.FieldByName('pend_unid_codigo').AsString);
          FRel.AddCel(QBx.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel(QBx.FieldByName('pend_datacont').AsString);
          FRel.AddCel(QBx.FieldByName('pend_numerodcto').AsString);
// 02.08.07
          if recpag='P' then
            FRel.AddCel('' );  // tipo de compra
          FRel.AddCel('');  // tipo de movimento - 08.09.05
          FRel.AddCel(FCondpagto.GetReduzido(QBx.FieldByName('pend_fpgt_codigo').AsString));
          FRel.AddCel(FPortadores.GetDescricao(QBx.FieldByName('pend_port_codigo').AsString));
          FRel.AddCel(QBx.FieldByName('pend_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeTipoCad(QBx.FieldByName('pend_tipo_codigo').AsInteger,QBx.FieldByName('pend_tipocad').AsString));
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QBx.FieldByName('pend_tipo_codigo').AsInteger,QBx.FieldByName('pend_tipocad').AsString,'N'));
// 08.06.07 - elize - novicarnes
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QBx.FieldByName('pend_tipo_codigo').AsInteger,QBx.FieldByName('pend_tipocad').AsString,'R'));
          FRel.AddCel(QBx.FieldByName('pend_repr_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeTipoCad(QBx.FieldByName('pend_repr_codigo').AsInteger,'R'));
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QBx.FieldByName('pend_repr_codigo').AsInteger,'R','N'));
          FRel.AddCel(QBx.FieldByName('pend_datavcto').AsString);
          FRel.AddCel(QBx.FieldByName('pend_databaixa').AsString);
          FRel.AddCel(QBx.FieldByName('pend_transbaixa').AsString);
// 25.09.07
          if QBx.FieldByName('pend_status').AsString='P' then
            unidadebaixa:=GetUnidadeCaixabancos(QBx.FieldByName('pend_transacao').AsString)
          else
            unidadebaixa:=GetUnidadeCaixabancos(QBx.FieldByName('pend_transbaixa').AsString);
          FRel.AddCel(unidadebaixa);
// 03.08.06
          FRel.AddCel(QBx.FieldByName('pend_observacao').AsString);

          FRel.AddCel(QBx.FieldByName('pend_nparcelas').AsString);
          FRel.AddCel(QBx.FieldByName('pend_parcela').AsString);
          FRel.AddCel(QBx.FieldByName('pend_status').AsString);
          FRel.AddCel(formatfloat(f_cr,(-1)*texttovalor(Qbx.FieldByName('pend_valor').Asstring)));
          FRel.AddCel('');
          FRel.AddCel(Qbx.FieldByName('pend_mora').AsString);
          FRel.AddCel(Qbx.FieldByName('pend_descontos').AsString);
          saldox:=saldox-QBx.FieldByName('pend_valor').AsCurrency;
          FRel.AddCel(formatfloat(f_cr,saldox));
// 03.04.08
          if Global.Topicos[1105] then begin
            FRel.AddCel('');
          end;
          Qbx.next;
      end;
      Qbx.close;
      Freeandnil(Qbx);
    end;


    function Gettipomov(transacao:String):string;
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select moes_tipomov from movesto where moes_transacao='+stringtosql(transacao));
      result:='';
      if not Q.eof then begin
        result:=Q.fieldbyname('moes_tipomov').asstring;
        if result=Global.CodDevolucaoConsig then   //  09.09.05 - gambia para reges -
          result:=Global.CodVendaConsig;
      end else
        result:=Global.CodPendenciaFinanceira;
      Q.close;
      Freeandnil(Q);
    end;

    function EstaValendo(vencimento:TDatetime ; rp:string ):boolean;
    ///////////////////////////////////////////////////////////////////
    var diasvencidos:integer;
        ativo:string;
        QBx1:TSqlquery;

    begin

      if Rel='PEN' then begin
        if (FRelfinan.Edativos.text='T' ) or ( rp='P' ) then begin

          result:=true;
          QBx1:=sqltoquery('select sum(pend_valor) as parcial from pendencias where pend_status='+stringtosql('P')+
                      ' and pend_tipo_codigo='+stringtosql(Q.fieldbyname('pend_tipo_codigo').asstring)+
                      ' and pend_tipocad='+stringtosql(Q.fieldbyname('pend_tipocad').asstring)+
                      ' and pend_databaixa > '+DatetoSql(Global.DataMenorBanco)+
                      ' and pend_parcela='+Q.fieldbyname('pend_parcela').asstring+
                      ' and pend_unid_codigo='+stringtosql(Q.fieldbyname('pend_unid_codigo').asstring)+
                      ' and pend_numerodcto='+stringtosql(Q.fieldbyname('pend_numerodcto').asstring) );
          if not QBx1.eof then begin
            if qbx1.fieldbyname('parcial').ascurrency>=q.FieldByName('pend_valor').ascurrency then
              result:=false;
          end else
          fgeral.fechaquery(QBx1);

        end else begin

          ativo:='S';
          diasvencidos:=trunc( sistema.hoje-vencimento );
          if (rp='R') and ( diasvencidos>0 )  and ( diasvencidos>FGeral.Getconfig1asinteger('DIASINATIVO') )
             and ( FGeral.Getconfig1asinteger('DIASINATIVO')>0 )  then
             ativo:='N';
          if (FRelfinan.EdAtivos.text='A') and (ativo='N') then
            result:=false
          else if (FRelfinan.EdAtivos.text='I') and (ativo='S') then
            result:=false
          else
            result:=true;
        end;
      end else
        result:=true;
    end;


////////////////////////////////////////////////////////////////////////
begin
////////////////////////////////////////////////////////////////////////

  with FRelFinan do begin

    if not FRelFinan_Execute(19) then Exit;
    Recpag:='R';
    Sistema.BeginProcess('Gerando Relatório');
    Rel:='BAI';
    sqlrecpag:=' and pend_RP='+stringtosql(Recpag);
    if RecPag='R' then begin
      titulo:='Relatório de Comissão sobre Recebimentos';
    end else begin
      titulo:='Relatório de Pagamentos - ';
    end;
    if ( trim(FGeral.GetConfig1AsString('Vendnaorateiam'))<>'' ) then begin
      if EdSorateio.text='S' then
        sqlreprenaorateia:=' and '+FGeral.GetNOTIN('pend_repr_codigo',FGeral.GetConfig1AsString('Vendnaorateiam'),'N')
      else
        sqlreprenaorateia:=' and '+FGeral.GetIN('pend_repr_codigo',FGeral.GetConfig1AsString('Vendnaorateiam'),'N');
    end else begin
      sqlreprenaorateia:='';
    end;
    titvencidos:='';
    sqlconta:='';

    statusvalidos:='B;P;E';
    sqlorder:=' order by pend_unid_codigo,pend_tipo_codigo,pend_databaixa';

    sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C');
    periodo:='Periodo : ';
    sqldatalan:='';
// 28.04.20
    if ( not EdLancai.IsEmpty ) and ( not EdLancaf.IsEmpty ) then
       sqldatalan := ' and pend_dataemissao >= '+EdLancai.AsSql+
                     ' and pend_dataemissao <= '+EdLancaf.AsSql;

    if EdBaixai.AsDate>1 then begin
      sqldatabai:=' and pend_databaixa>='+EdBaixai.AsSql+' and pend_databaixa<='+EdBaixaf.AsSql;
      periodo:=periodo+' Baixa : '+FGeral.FormataData(EdBaixai.AsDate)+' a '+FGeral.FormataData(EdBaixaf.AsDate);
    end else
      sqldatabai:='';
    if EdVencimentoi.AsDate>1 then begin
      sqldatavenci:=' and pend_datavcto>='+EdVencimentoi.AsSql+' and pend_datavcto<='+EdVencimentof.AsSql;
      periodo:=periodo+' Vencimento : '+FGeral.FormataData(EdVencimentoi.AsDate)+' a '+FGeral.FormataData(EdVencimentof.AsDate);
    end else
      sqldatavenci:='';
    if EdCodtipo.AsInteger>0 then begin
      titulo:=titulo+' - Codigo '+EdCodtipo.text+' - '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipocad.text,'N');
      if EdTipocad.text='R' then
        sqlcodtipo:=' and pend_repr_codigo='+Edcodtipo.AsSql
      else
        sqlcodtipo:=' and pend_tipo_codigo='+Edcodtipo.AsSql;
    end else
      sqlcodtipo:='';
    if not Edtipocad.isempty then begin
      sqltipocad:=' and pend_tipocad='+Edtipocad.AsSql;
    end else
      sqltipocad:='';

    sqlperiodoemissao:='';
    junta:= 'inner join clientes on ( clie_codigo=pend_tipo_codigo )';
    vlrtotalrec:=0;

    Q:=sqltoquery('select pendencias.*,moes_repr_codigo,moes_repr_codigo2,moes_percomissao,moes_percomissao2 from pendencias '+junta+
                  ' inner join movesto on (moes_transacao=pend_transacao)'+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  sqlrecpag+
                  sqlunidade+
                  sqldatalan+
                  sqldatabai+
                  sqldatavenci+
                  sqldatacont+
                  sqlcodtipo+
                  sqltipocad+
                  sqlperiodoemissao+
                  sqlreprenaorateia+
                  sqlconta+  // 10.03.09
                  sqlorder );


      if Rel='INC' then

        FRel.Init('RelIncluidas')

      else if Rel='PEN' then begin
        FRel.Init('RelPendentes');
        if FGeral.Getconfig1asinteger('DIASINATIVO')>0 then begin
          if (FRelfinan.EdAtivos.text='A') then
            titvencidos:=' - Somente vencidos ATÉ '+inttostr(FGeral.Getconfig1asinteger('DIASINATIVO'))+' dias'
          else  if (FRelfinan.EdAtivos.text='I') then
            titvencidos:=' - Somente vencidos APÓS '+inttostr(FGeral.Getconfig1asinteger('DIASINATIVO'))+' dias'
          else
            titvencidos:=' - Todos os documentos';
        end;
        titulo:=titulo+titvencidos;
// 06.06.07
      end else begin

        FRel.Init('RelComissaopelaBaixa');
        if EdSorateio.text='S' then
           titulo:=titulo+' - Somente os Rateados'
        else
           titulo:=titulo+' - Somente os Não rateados';
        if sqldatalan<>'' then titulo := titulo + ' Emissão :'+FGeral.FormataData(EdLancai.AsDate)+' a '+FGeral.FormataData(EdLancaf.AsDate)

      end;
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit(Periodo);
      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'       ,''         ,'',false);
//      FRel.AddCol( 80,0,'C','' ,''              ,'OPeracao'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
//      FRel.AddCol( 65,1,'D','' ,''              ,'Lançamento'      ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      if Global.Usuario.OutrosAcessos[0701] then
         FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
      FRel.AddCol(100,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
      if recpag='R' then
        FRel.AddCol( 45,0,'N','' ,''              ,'Cliente'         ,''         ,'',false)
      else
        FRel.AddCol( 45,0,'N','' ,''              ,'Fornecedor'         ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);

      if Recpag='R' then begin
        FRel.AddCol( 45,0,'N','' ,''              ,'Representante'   ,''         ,'',false);
        FRel.AddCol(150,0,'C','' ,''              ,'Nome Repr.'      ,''         ,'',false);
      end else begin
        FRel.AddCol( 45,0,'N','' ,''              ,'Conta'           ,''         ,'',false);
        FRel.AddCol(150,0,'C','' ,''              ,'Nome Conta'      ,''         ,'',false);
      end;

      FRel.AddCol( 60,1,'D','' ,''              ,'Vencimento'      ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Baixa'           ,''         ,'',false);
//      FRel.AddCol( 70,1,'C','' ,''              ,'Transação Baixa' ,''         ,'',false);
      FRel.AddCol( 30,2,'N','' ,''              ,'NP'              ,''         ,'',False);
      FRel.AddCol( 30,2,'N','' ,''              ,'Parc'            ,''         ,'',False);
      FRel.AddCol( 50,2,'C','' ,''              ,'Tipo Baixa'      ,''         ,'',False);
      if EdSorateio.text='N' then
        FRel.AddCol( 70,3,'N','+' ,''           ,'Valor Parcela'   ,''         ,'',False)
      else
        FRel.AddCol( 70,3,'N','' ,''           ,'Valor Parcela'   ,''         ,'',False);
      if EdSorateio.text='N' then begin
        FRel.AddCol( 80,3,'N','+' ,''           ,'Valor Comissão'  ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''           ,'Valor Res.Técnica'  ,''         ,'',False);
      end;

      while not Q.eof do begin

        if EstaValendo(Q.FieldByName('pend_datavcto').AsDatetime,recpag) then begin

          FRel.AddCel(Q.FieldByName('pend_transacao').AsString);
//          FRel.AddCel(Q.FieldByName('pend_operacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_unid_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel(Q.FieldByName('pend_datacont').AsString);
          FRel.AddCel(Q.FieldByName('pend_numerodcto').AsString);
// 23.11.07
          if Q.FieldByName('pend_tipomov').asstring='' then
// 08.09.05
            tipomov:=Gettipomov(Q.FieldByName('pend_transacao').AsString)
          else
            tipomov:=Q.FieldByName('pend_tipomov').asstring;
          FRel.AddCel(Tipomov+'-'+FGeral.GetTipoMovto(Tipomov));
//          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('pend_fpgt_codigo').AsString));
//          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('pend_port_codigo').AsString));
          FRel.AddCel(Q.FieldByName('pend_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'N'));

          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'R'));
          if Recpag='R' then begin
            if Q.FieldByName('moes_repr_codigo2').AsInteger>0 then begin
              FRel.AddCel(Q.FieldByName('moes_repr_codigo2').AsString);
              FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_repr_codigo2').AsInteger,'R','N'));
            end else begin
              FRel.AddCel(Q.FieldByName('pend_repr_codigo').AsString);
              FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_repr_codigo').AsInteger,'R','N'));
            end;
          end else begin
            FRel.AddCel(Q.FieldByName('pend_plan_conta').AsString);
            FRel.AddCel(FPlano.GetDescricao(Q.FieldByName('pend_plan_conta').AsInteger));
          end;

          FRel.AddCel(Q.FieldByName('pend_datavcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_databaixa').AsString);
//          FRel.AddCel(Q.FieldByName('pend_transbaixa').AsString);
// 03.08.06
//          FRel.AddCel(Q.FieldByName('pend_observacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_nparcelas').AsString);
          FRel.AddCel(Q.FieldByName('pend_parcela').AsString);
          FRel.AddCel(Q.FieldByName('pend_status').AsString);
          valor:=Q.FieldByName('pend_valor').Asstring;
          FRel.AddCel(formatfloat(f_cr,strtofloat(valor)));
          if EdSorateio.text='N' then begin
            if Q.FieldByName('pend_tipomov').AsString=Global.CodContrato then
              vlrcomissao:=Q.FieldByName('pend_valor').AsCurrency*(Q.FieldByName('moes_percomissao').AsCurrency/100)
            else
              vlrcomissao:=Q.FieldByName('pend_valor').AsCurrency*(FRepresentantes.GetPerComissao(Q.FieldByName('pend_repr_codigo').AsInteger)/100);
            FRel.AddCel(formatfloat(f_cr,vlrcomissao));
            vlrreserva:=0;
            if Q.FieldByName('pend_tipomov').AsString=Global.CodContrato then
              vlrreserva:=Q.FieldByName('pend_valor').AsCurrency*(Q.FieldByName('moes_percomissao2').AsCurrency/100);
//            else
//              vlrcomissao:=Q.FieldByName('pend_valor').AsCurrency*(FRepresentantes.GetPerComissao(Q.FieldByName('pend_repr_codigo2').AsInteger)/100);
            FRel.AddCel(formatfloat(f_cr,vlrreserva));
          end;
          vlrtotalrec:=vlrtotalrec+Q.FieldByName('pend_valor').AsCurrency;

        end;  // esta valendo
        Q.Next;
      end;
// se for somente as rateados sai aqui a comissao senao sai 'baixa a baixa'

      if (vlrtotalrec>0) and ( trim(FGeral.GetConfig1AsString('Vendnaorateiam'))<>'' )
         and (EdSorateio.text='S')  then begin
        QRepr:=sqltoquery('select * from representantes where '+FGeral.GetNOTIN('repr_codigo',FGeral.GetConfig1AsString('Vendnaorateiam'),'N')+
                            ' and repr_comissao>0 order by repr_nome');
        FGeral.ImprimelinhaRel(16,replicate('-',40));
        FGeral.PulalinhaRel(16,14,'%',15,'Total ',16,FGeral.Formatavalor(vlrtotalrec,f_cr));
        vlrtotcom:=0;
        while not QRepr.eof do begin
          FRel.AddCel('');     // 1
          FRel.AddCel('');     // 2
          FRel.AddCel('');     // 3
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel('');  // 4
          FRel.AddCel('');    // 5
          FRel.AddCel('');
          FRel.AddCel('');    // 6
          FRel.AddCel('');    // 7

          FRel.AddCel(QRepr.FieldByName('repr_codigo').AsString);  // 8
          FRel.AddCel(QRepr.FieldByName('repr_nome').AsString);    // 9

          FRel.AddCel('');        // 10
//          FRel.AddCel('');
          FRel.AddCel('');        // 11
          FRel.AddCel('');        //12

          FRel.AddCel( QRepr.FieldByName('repr_comissao').AsString);  // 13

          FRel.AddCel('');     // 14
          FRel.AddCel( Fgeral.formatavalor(vlrtotalrec*(QRepr.FieldByName('repr_comissao').AsCurrency/100),f_cr) );
//          FRel.AddCel('');     // 16
          vlrtotcom:=vlrtotcom+vlrtotalrec*(QRepr.FieldByName('repr_comissao').AsCurrency/100);
          QRepr.Next;
        end;
        FGeral.PulalinhaRel(16,15,'Total ',16,FGeral.Formatavalor(vlrtotcom,f_cr));
        FGeral.FechaQuery(QRepr);
      end;

    FRel.Video;

    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);

  end;

  FRelFinan_Comissao;

end;

///////////////////////////////////////////////////////

// 02.10.09 - compara venda contrato VX,VY com venda entrada VH
procedure FRelFinan_SaldoaEntregar;       // 20
//////////////////////////////////
var Q,QSaldo:TSqlquery;
    titulo,statusvalidos,sqldatalan,sqlorder,periodo,sqlcodtipo,sqltipocad,sqltipomov:string;
    totalitem,vendido,entregue,saldo,tvendido,tentregue,vendidoq,entregueq,saldoq,tvendidoq,
    tentregueq,qtdeitem,devolvido,devolvidoq,tdevolvido,tdevolvidoq:currency;
    chave,tiposentrada,sqlprodutos:string;
    ncol:integer;


begin

  with FRelFinan do begin

    if not FRelFinan_Execute(20) then Exit;

    Sistema.BeginProcess('Pesquisando');
    titulo:='Relatório Saldo de Obras a Entregar';
    statusvalidos:='N';
    sqlorder:=' order by moes_unid_codigo,moes_tipo_codigo,moes_dataemissao';
    sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C');
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and move_datacont > 1';
// 26.04.10
      sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);

    if not EdCodtipo.IsEmpty then
      Periodo:='Codigo '+EdCodtipo.text+' - '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,EdTipocad.text,'N')+' Periodo :'
    else
      periodo:='Emissão : '+FGeral.FormataData(EdEmissaoini.AsDate)+' a '+FGeral.FormataData(EdEmissaofim.AsDate);

//    sqldatalan:=' and moes_datamvto>='+EdLancai.AsSql+' and moes_datamvto<='+EdLancaf.AsSql;
    sqldatalan:=' and moes_dataemissao>='+EdEmissaoini.AsSql+' and moes_dataemissao<='+EdEmissaofim.AsSql;
//    periodo:=periodo+' Lançamento : '+FGeral.FormataData(EdLancai.AsDate)+' a '+FGeral.FormataData(EdLancaf.AsDate);

    if Edtipocad.text='C' then begin
      sqltipocad:=' and moes_tipocad='+Edtipocad.AsSql
    end else
      sqltipocad:='';

    if EdCodtipo.AsInteger>0 then begin
      if EdTipocad.text='R' then
        sqlcodtipo:=' and move_repr_codigo='+Edcodtipo.AsSql
      else
        sqlcodtipo:=' and move_tipo_codigo='+Edcodtipo.AsSql;

    end else
      sqlcodtipo:='';
// 16.03.18 - aqui ver pra criar 'terceira opcao' para vendas a fixar e vendas entrega e cria os
//            respectivos tipos de movimento proprios
    if EdVendaCompra.Text='V' then
       sqltipomov:=' and '+FGeral.GetIN('move_tipomov',Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodContratoEntrega,'C')
    else begin
       sqltipomov:=' and '+FGeral.GetIN('move_tipomov',Global.CodCompraFutura+';'+Global.CodCompraRemessaFutura+';'+Global.CodDevolucaoCompra,'C');
       titulo:='Relatório Saldo a Receber';
    end;
    if EdEsto_codigo.IsEmpty then
       sqlprodutos:=''
    else
       sqlprodutos:=' and '+FGeral.GetIN('move_esto_codigo',EdEsto_codigo.text,'C');


    Q:=sqltoquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where '+FGeral.Getin('move_status',statusvalidos,'C')+
//                  ' and '+FGeral.GetIN('move_tipomov',Global.CodContrato+';'+Global.CodContratoNota+';'+Global.CodContratoEntrega,'C')+
                  sqlunidade+
                  sqldatalan+
                  sqldatacont+
                  sqlcodtipo+
                  sqltipocad+
                  sqltipomov+
                  sqlprodutos+
                  sqlorder );


    if Q.Eof then

      Avisoerro('Nada encontrado para impressão')

    else begin

      Sistema.BeginProcess('Gerando Relatório');
      FRel.Init('RelSaldoaEntregar');
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit(titulo);
      FRel.AddTit(Periodo);
      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
//      FRel.AddCol( 65,1,'D','' ,''              ,'Lançamento'      ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      if Global.Usuario.OutrosAcessos[0701] then begin
         FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'       ,''         ,'',false);
//         ncol:=15;
      end;
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
//      FRel.AddCol( 70,2,'C','' ,''              ,'Obra'      ,''         ,'',False);
//      FRel.AddCol( 80,0,'C','' ,''              ,'Forma Pagto'     ,''         ,'',false);
//      FRel.AddCol( 90,0,'C','' ,''              ,'Portador'        ,''         ,'',false);
//      if EdCodtipo.AsInteger=0 then begin
        FRel.AddCol( 50,0,'N','' ,''              ,'Cliente'     ,''         ,'',false);
        FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
//      end;
      if EdVendaCompra.Text='V' then begin
        FRel.AddCol( 45,0,'C','' ,''              ,'Repr.'   ,''         ,'',false);
        FRel.AddCol(150,0,'C','' ,''              ,'Nome Repr.'      ,''         ,'',false);
      end;
      FRel.AddCol( 70,0,'C','' ,''              ,'Produto'   ,''         ,'',false);
      FRel.AddCol(160,0,'C','' ,''              ,'Descrição'      ,''         ,'',false);
      FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'      ,''         ,'',false);
      if EdVendaCompra.text='V' then
        FRel.AddCol( 70,3,'N','' ,'##,###,##0.00'          ,'Vendido'    ,''         ,'',False)
      else
        FRel.AddCol( 70,3,'N','' ,'##,###,##0.00'          ,'Comprado'    ,''         ,'',False);
      FRel.AddCol( 70,3,'N','' ,'##,###,##0.00'          ,'Entregue'   ,''         ,'',False);
      FRel.AddCol( 70,3,'N','' ,'##,###,##0.00'          ,'Devolvido'   ,''         ,'',False);
      FRel.AddCol( 70,3,'N',''  ,'##,###,##0.00'          ,'Saldo'   ,''         ,'',False);

      if EdVendaCompra.text='V' then
        FRel.AddCol( 70,3,'N','' ,'###,##0.00'          ,'Qtde Ven'    ,''         ,'',False)
      else
        FRel.AddCol( 70,3,'N','' ,'###,##0.00'          ,'Qtde Com'    ,''         ,'',False);
      FRel.AddCol( 70,3,'N','' ,'###,##0.00'          ,'Qtde Entr'   ,''         ,'',False);
      FRel.AddCol( 70,3,'N','' ,'###,##0.00'          ,'Qtde Devol.'   ,''         ,'',False);
      FRel.AddCol( 70,3,'N',''  ,'###,##0.00'          ,'Qtde Saldo'   ,''         ,'',False);


      tvendido:=0;tentregue:=0;
      tvendidoq:=0;tentregueq:=0;
      tdevolvidoq:=0;
      TiposEntrada:=Global.CodContrato+';'+Global.CodContratoNota;
      if EdVendaCompra.Text='C' then TiposEntrada:=Global.CodCompraFutura;
      ncol:=FRel.GCol.ColCount;

      while not Q.eof do begin

        chave:=Q.fieldbyname('moes_unid_codigo').asstring+Q.fieldbyname('moes_tipo_codigo').asstring;
        vendido:=0;entregue:=0;saldo:=0;
        while (not Q.eof) and (chave=Q.fieldbyname('moes_unid_codigo').asstring+Q.fieldbyname('moes_tipo_codigo').asstring)  do begin

          FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
//          FRel.AddCel(Q.FieldByName('pend_operacao').AsString);
          FRel.AddCel(Q.FieldByName('move_unid_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('move_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel(Q.FieldByName('move_datacont').AsString);
          FRel.AddCel(Q.FieldByName('move_numerodoc').AsString);
//          FRel.AddCel(Q.FieldByName('moes_nroobra').AsString);
//          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('pend_fpgt_codigo').AsString));
//          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('pend_port_codigo').AsString));
//          if EdCodtipo.AsInteger=0 then begin
            FRel.AddCel(Q.FieldByName('move_tipo_codigo').AsString);
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('move_tipo_codigo').AsInteger,Q.FieldByName('move_tipocad').AsString,'N'));
//          end;
          if EdVendaCompra.Text='V' then begin
            FRel.AddCel(Q.FieldByName('moes_repr_codigo').AsString);
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_repr_codigo').AsInteger,'R','N'));
          end;
          if (Global.Topicos[1209]) and (trim(Q.FieldByName('esto_referencia').AsString)<>'') then
            FRel.AddCel(Q.FieldByName('esto_referencia').AsString)
          else
            FRel.AddCel(Q.FieldByName('move_esto_codigo').AsString);
          FRel.AddCel(FEstoque.GetDescricao(Q.FieldByName('move_esto_codigo').Asstring));
          FRel.AddCel(FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').Asstring));
          totalitem:=Q.FieldByName('move_venda').AsCurrency*Q.FieldByName('move_qtde').AsCurrency;

          if pos(Q.fieldbyname('move_tipomov').asstring,TiposEntrada)>0 then begin

            FRel.AddCel(floattostr(totalitem));
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            vendido:=vendido+totalitem;
            tvendido:=tvendido+totalitem;

          end else begin

            FRel.AddCel('');
            if pos(Q.fieldbyname('move_tipomov').asstring,Global.CodDevolucaoCompra)>0 then begin
               FRel.AddCel('');
               FRel.AddCel(floattostr(totalitem));
               devolvido:=devolvido+totalitem;
               tdevolvido:=tdevolvido+totalitem;
            end else begin
              FRel.AddCel(floattostr(totalitem));
              FRel.AddCel('');
              entregue:=entregue+totalitem;
              tentregue:=tentregue+totalitem;
            end;
            FRel.AddCel('');

          end;
// 16.03.18
          qtdeitem:=Q.FieldByName('move_qtde').AsCurrency;
          if pos(Q.fieldbyname('move_tipomov').asstring,TiposEntrada)>0 then begin
            FRel.AddCel(floattostr(qtdeitem));
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            vendidoq:=vendidoq+qtdeitem;
            tvendidoq:=tvendidoq+qtdeitem;
          end else begin
            FRel.AddCel('');
            if pos(Q.fieldbyname('move_tipomov').asstring,Global.CodDevolucaoCompra)>0 then begin
              FRel.AddCel('');
              FRel.AddCel(floattostr(qtdeitem));
              devolvidoq:=devolvidoq+qtdeitem;
              tdevolvidoq:=tdevolvidoq+qtdeitem;
            end else begin
              FRel.AddCel(floattostr(qtdeitem));
              FRel.AddCel('');
              entregueq:=entregueq+qtdeitem;
              tentregueq:=tentregueq+qtdeitem;
            end;
            FRel.AddCel('');
          end;

          saldo:=vendido-entregue+devolvido;
          saldoq:=vendidoq-entregueq+devolvidoq;
//          FRel.AddCel('');
          Q.Next;

        end;

        if (vendido+entregue)>0 then begin
          FGEral.PulalinhaRel(ncol,13-2,floattostr(vendido),14-2,floattostr(entregue),15-2,floattostr(devolvido),16-2,floattostr(saldo),
                             17-2,floattostr(vendidoq),18-2,floattostr(entregueq),19-2,floattostr(devolvidoq),20-2,floattostr(saldoq) );
          FGEral.PulalinhaRel(ncol);
        end;

      end;

      if tvendido>0 then
        FGEral.PulalinhaRel(ncol,13-2,floattostr(tvendido),14-2,floattostr(tentregue),15-2,floattostr(tdevolvido),16-2,floattostr(tvendido-tentregue+tdevolvido)
                            ,17-2,floattostr(tvendidoq),18-2,floattostr(tentregueq),19-2,floattostr(tdevolvidoq),20-2,floattostr(tvendidoq-tentregueq) );
//      FRel.SetSort('Tipo Movimento');
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);

    FRelFinan_SaldoaEntregar;       // 20

  end;

end;

// 16.09.10
procedure FRelFinan_InssNfProdutor;        // 21
//////////////////////////////////////////////////////
var statusvalidos,titulo,sqlorder,sqltipocod,sqltipomov,tiposmov,checar,tiposmovnao,
    sqldata,titconta:string;
    Q,QMovFin,QTipo1:TSqlquery;
    avista,aprazo,devolucao,valorx,percfunrural,percfunrural1:currency;
    conta,contax:integer;

    function ContaOK(xconta:integer):boolean;
    begin
       result:=false;
       if not FRelFinan.EdPlan_conta.IsEmpty then begin
         if xconta=FRelFinan.EdPlan_conta.AsInteger then
           result:=true;
       end else
         result:=true;
    end;


begin
////////////////////////////////////////////////////////////////////////////////

  with FRelFinan do begin

    if not FRelFinan_Execute(21) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    statusvalidos:='N;D;E;X;Y';   // E devido as devolucoes do regime especial
    sqlorder:=' order by moes_unid_codigo,moes_dataemissao,moes_tipo_codigo,moes_numerodoc';
    sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
    tiposmovnao:=Global.CodEntradaprocesso+';'+Global.CodEntradaAlmox+';'+Global.CodSaidaprocesso;
    if EdCodtipo.Asinteger>0 then begin
      if Edtipocad.text='R' then
        sqltipocod:=' and moes_repr_codigo='+EdCodtipo.assql
      else
        sqltipocod:=' and ( (moes_tipo_codigo='+EdCodtipo.assql+') and (moes_tipocad='+EdTipocad.Assql+') )';
    end else
      sqltipocod:='';
{
    if EdTiposmov.isempty then begin
      if trim(Global.TiposRelCompra)<>'' then  // 02.09.08
        tiposmov:=Global.TiposRelCompra
      else
        tiposmov:=Global.TiposEntrada;
    end else begin
      tiposmov:=EdTiposmov.text;
    end;
}
    tiposmov:=Global.CodCompraProdutor+';'+Global.codcompraprodutormerenda+';'+
// 04.03.2021
              Global.CodNfeComplementoValorProdutor+';'+
              EdTiposMov.Text;
    if trim(tiposmov)<>'' then
      sqltipomov:='and '+FGeral.GetIN('moes_tipomov',tiposmov,'C')
    else
      sqltipomov:='';
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and moes_datacont > 1';
// 26.04.10
      sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);
// 06.10.09
    if ( not EdLancai.IsEmpty ) and ( not EdLancaf.IsEmpty ) then
      sqldata:=' and moes_datamvto>='+Edlancai.AsSql+' and moes_datamvto<='+Edlancaf.AsSql
    else if ( not EdLancai.IsEmpty ) then
      sqldata:=' and moes_datamvto>='+Edlancai.AsSql
    else if ( not EdLancaf.IsEmpty ) then
      sqldata:=' and moes_datamvto<='+Edlancaf.AsSql
    else
      sqldata:='';
// 25.02.10 - Abra - aqui nao preve a 'fase' de conta gravada no movesto e antes no pendencias
    titconta:='';
    if not EdPlan_conta.IsEmpty then  begin
//      sqlconta:=' and moes_plan_codigo='+EdPlan_conta.AsSql;
      titconta:='Conta '+EdPlan_conta.Text+' - '+EdPlan_conta.ResultFind.fieldbyname('plan_descricao').AsString;
    end;
////////
    titulo:='Inss a pagar retido nas Entradas de Produtor  de '+FGeral.FormataData(Edlancai.asdate)+' a '+FGeral.FormataData(Edlancaf.asdate)+
            ' - Tipos Impressos: '+TiposMov ;
    Q:=sqltoquery('select *,clie_depojudi,clie_contadepojudi,clie_aliinssdepjud  from movesto'+
                  ' left join confmov on ( comv_codigo=moes_comv_codigo )'+
                  ' inner join clientes on ( moes_tipo_codigo=clie_codigo )'+
                  ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                  sqldata+
                  ' and '+Fgeral.GetNOTIN('moes_tipomov',tiposmovnao,'C')+
                  sqlunidade+
                  sqltipocod+
                  sqldatacont+
                  sqltipomov+
//                  sqlconta+
                  sqlorder );


    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      FRel.Init('RelInssRetidoapagar');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
      FRel.AddTit(titconta);
      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'       ,''         ,'',false);
//      FRel.AddCol( 80,0,'C','' ,''              ,'OPeracao'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Referência'      ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
      FRel.AddCol( 70,2,'N','' ,''              ,'NF Produtor'     ,''         ,'',False);
      FRel.AddCol(200,1,'C','' ,''               ,'Situação Receita'            ,''         ,'',False);
//      FRel.AddCol( 50,1,'C','' ,''              ,'Cod.Mov.'        ,''         ,'',False);
//      FRel.AddCol( 90,1,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
      FRel.AddCol( 40,0,'C','' ,''              ,'Tipo'            ,''         ,'',false);
      FRel.AddCol( 45,0,'N','' ,''              ,'Codigo'          ,''         ,'',false);
//      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
// 06.08.08
      FRel.AddCol(150,0,'C','' ,''              ,'Razão Social'    ,''         ,'',false);
      FRel.AddCol(100,0,'C','' ,''              ,'CNPJ/CPF'    ,''         ,'',false);
//
//      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor Nota'     ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor Produtos'     ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Cidade'          ,''         ,'',False);
      FRel.AddCol( 40,1,'C','' ,''              ,'Estado'          ,''         ,'',False);
      FRel.AddCol(070,3,'N','+',f_cr            ,'Valor Funrural'   ,''         ,'',false);
      FRel.AddCol(050,3,'N','' ,f_cr            ,'% Fun.'       ,''         ,'',false);
      FRel.AddCol(070,3,'N','+',f_cr            ,'Valor GTA'     ,''         ,'',false);
      FRel.AddCol(100,0,'C','' ,''              ,'Conta Depósito'        ,''         ,'',false);

      while not Q.eof do begin

        if ContaOK(conta) then begin

          FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
          FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
          FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
          FRel.AddCel(Q.FieldByName('moes_datacont').AsString);
          FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('moes_notapro').AsString);
          FRel.AddCel(Q.FieldByName('moes_retornonfe').AsString);
          FRel.AddCel(Q.FieldByName('moes_tipocad').AsString);
          FRel.AddCel(Q.FieldByName('moes_tipo_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'R'));
          FRel.AddCel( FormatoCGCCPF( FGeral.GetCnpjCpfTipoCad(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString) ) );
//          FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
// 08.03.19
          if AnsiPos( Q.FieldByName('moes_status').AsString,'X;Y') > 0 then

            FRel.AddCel('')

          else

// 02.02.16
            FRel.AddCel(Q.FieldByName('moes_totprod').Asstring);

          if Q.FieldByName('moes_tipocad').Asstring='C' then begin
// 31.07.07
            if Q.FieldByName('moes_cida_codigo').asinteger=0 then begin
              FRel.AddCel(FCadcli.GetCidade(Q.FieldByName('moes_tipo_codigo').Asinteger));
              FRel.AddCel(FCadcli.GetUf(Q.FieldByName('moes_tipo_codigo').Asinteger));
            end else begin
              FRel.AddCel(FCidades.Getnome(Q.FieldByName('moes_cida_codigo').Asinteger));
              FRel.AddCel(Q.FieldByName('moes_estado').Asstring);
            end;
          end else begin
// 26.05.08
            if Q.FieldByName('moes_cida_codigo').asinteger=0 then begin
              FRel.AddCel(FFornece.GetCidade(Q.FieldByName('moes_tipo_codigo').Asinteger));
              FRel.AddCel(FFornece.GetUf(Q.FieldByName('moes_tipo_codigo').Asinteger));
            end else begin
              FRel.AddCel(FCidades.Getnome(Q.FieldByName('moes_cida_codigo').Asinteger));
              FRel.AddCel(Q.FieldByName('moes_estado').Asstring);
            end;
          end;
//          FRel.AddCel(FUsuarios.getnome(Q.FieldByName('moes_usua_codigo').Asinteger));
// 04.06.10 - Novicarnes
          percfunrural:=0;percfunrural1:=0;
//          if (Q.FieldByName('moes_vlrtotal').AsCurrency>0) then
//            percfunrural:=(Q.FieldByName('moes_funrural').AsCurrency/Q.FieldByName('moes_vlrtotal').AsCurrency)*100;
// 01.02.16
          if (Q.FieldByName('moes_totprod').AsCurrency>0) then
            percfunrural:=(Q.FieldByName('moes_funrural').AsCurrency/Q.FieldByName('moes_totprod').AsCurrency)*100;

          percfunrural1:=percfunrural;

// 08.03.19
          if AnsiPos( Q.FieldByName('moes_status').AsString,'X;Y') > 0 then

            FRel.AddCel('')

          else begin

            if (Q.FieldByName('clie_depojudi').AsString='S') and (Q.FieldByName('clie_aliinssdepjud').AsCurrency>0) then begin

              percfunrural:=Q.FieldByName('clie_aliinssdepjud').AsCurrency;
              FRel.AddCel( Floattostr(Q.FieldByName('moes_totprod').AsCurrency*(percfunrural/100)) );

            end else
              FRel.AddCel(Q.FieldByName('moes_funrural').Asstring);

          end;

          FRel.AddCel(floattostr(percfunrural));
// 16.04.18 - Novicarnes - Ketlen - Polli
          FRel.AddCel( Q.FieldByName('moes_vlrgta').Asstring );
          FRel.AddCel(Q.FieldByName('clie_contadepojudi').Asstring);

          if percfunrural1<>percfunrural then begin
////////////////////////////
            FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
  //          FRel.AddCel(Q.FieldByName('moes_operacao').AsString);
            FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
  //          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
            FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
            FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
            FRel.AddCel(Q.FieldByName('moes_datacont').AsString);
            FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);

            FRel.AddCel(Q.FieldByName('moes_tipocad').AsString);
            FRel.AddCel(Q.FieldByName('moes_tipo_codigo').AsString);
  //          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'N'));
  // 06.08.08
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'R'));
//            FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
// 08.03.19
            if AnsiPos( Q.FieldByName('moes_status').AsString,'X;Y') > 0 then

               FRel.AddCel('')

            else
// 02.02.16
               FRel.AddCel(Q.FieldByName('moes_totprod').Asstring);

//            FRel.AddCel('');
  //          FRel.AddCel(Q.FieldByName('moes_totprod').Asstring);

            if Q.FieldByName('moes_tipocad').Asstring='C' then begin
  // 31.07.07
              if Q.FieldByName('moes_cida_codigo').asinteger=0 then begin
                FRel.AddCel(FCadcli.GetCidade(Q.FieldByName('moes_tipo_codigo').Asinteger));
                FRel.AddCel(FCadcli.GetUf(Q.FieldByName('moes_tipo_codigo').Asinteger));
              end else begin
                FRel.AddCel(FCidades.Getnome(Q.FieldByName('moes_cida_codigo').Asinteger));
                FRel.AddCel(Q.FieldByName('moes_estado').Asstring);
              end;
            end else begin
  // 26.05.08
              if Q.FieldByName('moes_cida_codigo').asinteger=0 then begin
                FRel.AddCel(FFornece.GetCidade(Q.FieldByName('moes_tipo_codigo').Asinteger));
                FRel.AddCel(FFornece.GetUf(Q.FieldByName('moes_tipo_codigo').Asinteger));
              end else begin
                FRel.AddCel(FCidades.Getnome(Q.FieldByName('moes_cida_codigo').Asinteger));
                FRel.AddCel(Q.FieldByName('moes_estado').Asstring);
              end;

            end;
  //          FRel.AddCel(FUsuarios.getnome(Q.FieldByName('moes_usua_codigo').Asinteger));
  // 04.06.10 - Novicarnes
            percfunrural:=percfunrural1-percfunrural;
// 08.03.19
            if AnsiPos( Q.FieldByName('moes_status').AsString,'X;Y') > 0 then

               FRel.AddCel('')

            else

              FRel.AddCel( Floattostr(Q.FieldByName('moes_totprod').AsCurrency*(percfunrural/100)) );


            FRel.AddCel(floattostr(percfunrural));
            FRel.AddCel('');
//            FRel.AddCel(Q.FieldByName('clie_contadepojudi').Asstring);

///////////////////////////
          end;
        end;
        Q.Next;
      end;

      FRel.Setsort('% Fun.');
      FRel.Video;

    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

    FRelFinan_INssNfProdutor;     // 21

  end;

end;



procedure TFRelFinan.EdLancafExitEdit(Sender: TObject);
begin
  baplicarclick(FRelFinan);
end;

procedure TFRelFinan.EdTipomovExitEdit(Sender: TObject);
begin
  baplicarclick(FRelfinan);
end;

procedure TFRelFinan.EdLancafValidate(Sender: TObject);
begin
   if not EdLancaf.isempty then begin
     if EdLancaf.asdate < EdLancai.asdate then
       EdLancaf.invalid('Final tem que ser maior que inicial');
   end;
end;

procedure TFRelFinan.EdDtemissaoValidate(Sender: TObject);
var Q:TSqlquery;
    sqlemissao:string;
begin
  if qrel=16 then begin
     if not EdDtemissao.isempty then
       sqlemissao:=' and pend_dataemissao='+EdDtemissao.assql
     else
       sqlemissao:='';
     Q:=sqltoquery('select pend_datavcto,pend_valor from pendencias where pend_numerodcto='+stringtosql(EdNUmerodoc.text)+
                  ' and pend_status<>''C'' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')+
                  sqlemissao+
                  ' order by pend_datavcto' );
     EdVencimento.Items.Clear;
     while not Q.eof do begin

       EdVencimento.Items.Add( FGeral.Formatadata(Q.fieldbyname('pend_datavcto').asdatetime,true) );
//       EdVencimento.Items.Add( Q.fieldbyname('pend_datavcto').asstring );
       Q.Next;

     end;
     FGeral.fechaquery(Q);
  end;

end;

procedure TFRelFinan.EdVencimentoValidate(Sender: TObject);
var data:Tdatetime;
begin
  if not EdVencimento.isempty then begin
    if not trystrtodate(EdVencimento.text,data ) then
      EdVencimento.Invalid('Data inválida');
  end;
end;

procedure TFRelFinan.EdNumeroDocValidate(Sender: TObject);
begin
  if (EdNumerodoc.AsInteger>0) and (EdNUmerodocf.AsInteger=0) then
    EdNumerodocf.text:=EdNumerodoc.text;
end;

procedure TFRelFinan.EdMesanoValidate(Sender: TObject);
begin
  if EdMesanofinal.isempty then
    EdMesanofinal.text:=EdMesano.text;
  if EdMesanoorcado.isempty then
    EdMesanoorcado.text:=EdMesano.text;
end;

// 28.04.10
function TFRelFinan.GetPerComissao(xtransacao: string): currency;
/////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=Sqltoquery('select moes_percomissao from movesto where moes_transacao='+Stringtosql(xtransacao));
  if not Q.eof then
    result:=Q.fieldbyname('moes_percomissao').AsCurrency
  else
    result:=0;
  FGeral.FechaQuery(Q);
end;

// moes_repr_codigo2 numeric(4),
//  moes_percomissao numeric(7,3),
//  moes_percomissao2

function TFRelFinan.GetPerComissao2(xtransacao: string): currency;
///////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=Sqltoquery('select moes_percomissao2 from movesto where moes_transacao='+Stringtosql(xtransacao));
  if not Q.eof then
    result:=Q.fieldbyname('moes_percomissao2').AsCurrency
  else
    result:=0;
  FGeral.FechaQuery(Q);
end;


function TFRelFinan.GetSaldos( xconta:integer ): currency;
//////////////////////////////////////////////
    var Lista    :TStringList;
        unidades : string;
        p        :integer;

    begin

      if EdUnid_codigo.isempty then result :=  FGeral.GetSaldoInicialMovCon( xconta,
                                                 Global.CodigoUnidade , EdLancaf.AsDate+1  )

      else begin

        Lista := TStringList.Create;
        strtolista(Lista,EdUnid_codigo.text,';',true);
        result:=0;
        for p := 0 to Lista.Count-1 do begin

           if p=1 then xconta := FGeral.GetReduzidooutraUnidadeContax(xconta,Lista[p]);

           if xconta>0 then

              result :=  result + FGeral.GetSaldoInicialMovCon( xconta,Lista[p], EdLancaf.AsDate+1 );

        end;
        Lista.Free;

      end;
      if result<0 then result:=result*(-1);

    end;


// 29.04.20
function TFRelFinan.GetUltimaKM(xTran_codigo: string; xcarga:integer ; xdatacarga:TDatetime ): integer;
//////////////////////////////////////////////////////////////////////////////////
var Qx : TSqlquery;
begin
{
  Qx:=sqltoquery('select movc_km from movcargas where movc_status = ''N'''+
                ' and movc_datamvto >= '+DAtetosql(Sistema.Hoje-15)+
                ' and movc_datamvto <  '+DAtetosql(xdatacarga)+
                ' and movc_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                ' and movc_tran_codigo = '+stringtosql( xtran_codigo )+
                ' and movc_usua_codigo <> '+inttostr( 22 )+  // usuario do balançao--rever o tratamento
                ' and movc_numero <> '+inttostr(xCarga)+
                ' and movc_km > 0 '+
                ' order by movc_datamvto desc' );
}
  Qx:=sqltoquery('select movc_km from movcargas where movc_status = ''N'''+
                ' and movc_datamvto >=  '+DAtetosql(xdatacarga)+
                ' and movc_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                ' and movc_tran_codigo = '+stringtosql( xtran_codigo )+
                ' and movc_usua_codigo <> '+inttostr( 22 )+  // usuario do balançao--rever o tratamento
                ' and movc_numero <> '+inttostr(xCarga)+
                ' and movc_km > 0 '+
                ' order by movc_datamvto' );
  if not Qx.Eof then result := Qx.FieldByName('movc_km').AsInteger
  else result :=0 ;
  FGeral.FechaQuery(Qx);


end;

// 03.03.2023
function TFRelFinan.GetValorEquipamentos(xtransacao, codequi: string; valor:currency): currency;
//////////////////////////////////////////////////////////////////////////////////
var Qx:TSqlquery;
    xvalor:currency;
begin
  Qx:=sqltoquery('select move_equi_codigo,move_remessas,move_qtde*move_venda as totalitem, '+
                 ' moes_equi_codigo,moes_vlrtotal from movestoque'+
                 ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                 ' where move_transacao='+Stringtosql(Xtransacao));
  xvalor:=0;
  while not Qx.eof do  begin

     if trim(Qx.fieldbyname('move_equi_codigo').AsString)<>'' then begin

       if (Qx.fieldbyname('move_equi_codigo').AsString = codequi)
          then
            xvalor := xvalor + Qx.fieldbyname('totalitem').Ascurrency;

     end else if  ( Ansipos(codequi,Qx.fieldbyname('move_remessas').AsString)>0 )
          then
            xvalor := xvalor + Qx.fieldbyname('totalitem').Ascurrency;

     QX.Next;

  end;

  FGeral.FechaQuery(Qx);

  result:=xvalor;

end;

//////////////////////////////////////////////////////
procedure FRelFinan_DRE(nomerel:string='');        // 22
//////////////////////////////////////////////////////
type TLinhas=record
   valorcoluna01,valorcoluna02:currency;
   linharel:string;
end;

var sqldata,statusvalidos,sqlunidade,tiposmov,unidade,sqlcodigos,titulo,tiposdev,
    sqldev,mesanoi,mesanof:string;
    QRel,QSoma:TSqlquery;
    datai,dataf,datai02,dataf02,datai3,dataf3,datai03,dataf03:TDatetime;
    valormesano,valormesanofinal,variacao,multi:currency;
    PLinhas:^TLinhas;
    Linhas:TList;
    temsubtotal:boolean;

    function GetValores(col:integer;xlinhas:string):currency;
    //////////////////////////////////////////////////////////
    var p,i:integer;
        Lista:TStringList;
        r:currency;
    begin
      Lista:=TStringList.create;
      strtolista(Lista,xlinhas,';',true);
      r:=0;
      for p:=0 to Lista.count-1 do begin
        for i:=0 to Linhas.count-1 do begin
          PLinhas:=Linhas[i];
          if Plinhas.linharel=Lista[p] then begin
            if col=1 then
              r:=r+PLinhas.valorcoluna01
            else
              r:=r+PLinhas.valorcoluna02;
          end;
        end;
      end;
      result:=r;
    end;


begin
////////////////////////////////////////////////////////////////////////////////

  with FRelFinan do begin
    if not FRelFinan_Execute(22,'',nomerel) then Exit;
    unidade:=Global.CodigoUnidade;
    Sistema.BeginProcess('Checando configuração escolhida');
    QRel:=sqltoquery('select * from relgerencial where Relg_Unid_codigo='+Stringtosql(unidade)+
                     ' and relg_nomerel='+EdNomerel.AsSql+
                     ' and relg_status=''N'''+
                     ' order by relg_ordem');
    if QRel.Eof then begin
          Sistema.EndProcess('Relatório '+EdNomerel.Text+' não encontrado na unidade '+unidade);
      QRel.Close;
      exit
    end;
    temsubtotal:=false;
    while not QRel.eof do begin
      if QRel.fieldbyname('relg_tipo').asstring='M' then begin
        temsubtotal:=true;
        break;
      end;
      QRel.next;
    end;
    QRel.First;
//    titulo:=QRel.fieldbyname('relg_titulorel').asstring+' Periodos: '+copy(EdMesano.text,1,2)+'/'+copy(EdMesano.text,3,4)+' e '+copy(EdMesanofinal.text,1,2)+'/'+copy(EdMesanofinal.text,3,4);
    titulo:=QRel.fieldbyname('relg_titulorel').asstring+
//           '  - Periodo Inicial: '+copy(EdMesano.text,1,2)+'/'+copy(EdMesano.text,3,4)+' a '+copy(EdMesanofinal.text,1,2)+'/'+copy(EdMesanofinal.text,3,4)+
//           '  - Periodo Final : '+copy(EdMesanof.text,1,2)+'/'+copy(EdMesanof.text,3,4)+' a '+copy(EdMesanofinal1.text,1,2)+'/'+copy(EdMesanofinal1.text,3,4);
           '  - Periodo Inicial: '+FGeral.FormataData(Edmesanof.asdate)+' a '+FGeral.FormataData(Edmesanofinal1.asdate)+
           '  - Periodo Final : '+FGeral.FormataData(Edmesanof01.asdate)+' a '+FGeral.FormataData(Edmesanofinal02.asdate) ;
    FRel.Init('RelDemoResuExer');
    if EdCompete.Text='2' then FRel.AddTit(titulo+' - Por Competência') else FRel.AddTit(titulo+' - Por Caixa');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
    FRel.AddTit('Descontando as Devoluções DV e DX nas opções por Grupo, Subgrupo e Produto');
    FRel.AddCol(130,1,'C','' ,''              ,'Tipo Codigo'           ,''         ,'',false);
    FRel.AddCol(140,1,'C','' ,''              ,'Codigos'           ,''         ,'',false);
    FRel.AddCol(180,1,'C','' ,''              ,'Descrição'      ,''         ,'',false);
    if temsubtotal then begin
//      FRel.AddCol(090,3,'N','',f_cr            ,'Valor '+copy(EdMesano.text,1,2)+'/'+copy(EdMesano.text,3,4)     ,''         ,'',false);
//      FRel.AddCol(090,3,'N','',f_cr            ,'Valor '+copy(EdMesanofinal.text,1,2)+'/'+copy(EdMesanofinal.text,3,4)     ,''         ,'',false);
      FRel.AddCol(090,3,'N','',f_cr            ,'Valor Inicial'   ,''         ,'',false);
      FRel.AddCol(090,3,'N','',f_cr            ,'Valor Final'     ,''         ,'',false);
    end else begin
//      FRel.AddCol(090,3,'N','+',f_cr            ,'Valor '+copy(EdMesano.text,1,2)+'/'+copy(EdMesano.text,3,4)     ,''         ,'',false);
//      FRel.AddCol(090,3,'N','+',f_cr            ,'Valor '+copy(EdMesanofinal.text,1,2)+'/'+copy(EdMesanofinal.text,3,4)     ,''         ,'',false);
      FRel.AddCol(090,3,'N','+',f_cr            ,'Valor Inicial'   ,''         ,'',false);
      FRel.AddCol(090,3,'N','+',f_cr            ,'Valor Final'     ,''         ,'',false);
    end;
    FRel.AddCol(090,3,'N','' ,f_cr             ,'Var(%)'     ,''         ,'',false);

    Linhas:=TList.create;

    while not QRel.eof do begin
//////////////////////////////////////
//{
      statusvalidos:='N;D;E';
{
      datai:=texttodate('01'+EdMesano.text);
      dataf:=texttodate('01'+EdMesano.text);
      dataf:=Datetoultimodiames(dataf);
      datai02:=texttodate('01'+EdMesanofinal.text);
      dataf02:=texttodate('01'+EdMesanofinal.text);
      dataf02:=Datetoultimodiames(dataf02);

      datai3:=texttodate('01'+EdMesanof.text);
      dataf3:=texttodate('01'+EdMesanof.text);
      dataf3:=Datetoultimodiames(dataf3);
      datai03:=texttodate('01'+EdMesanofinal1.text);
      dataf03:=texttodate('01'+EdMesanofinal1.text);
      dataf03:=Datetoultimodiames(dataf03);
}
// 13.04.16
      datai:=EdMesanof.asdate;
      dataf02:=EdMesanofinal1.asdate;
      datai3:=Edmesanof01.asdate;
      dataf03:=EdMesanofinal02.asdate;
///////////////////
      Sistema.BeginProcess('Gerando Relatório');
      Tiposdev:=Global.TiposRelDevVenda;

      if QRel.fieldbyname('Relg_tipo').asstring='P' then begin
        sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
        if QRel.fieldbyname('Relg_es').asstring='E' then
          tiposmov:=Global.TiposRelCompra
        else
          tiposmov:=Global.TiposRelVenda;
        if Global.Usuario.OutrosAcessos[0701] then
          sqldatacont:=''
        else
          sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf);
// 20.07.15
        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf02);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai)+' and moes_dataemissao<='+DatetoSql(dataf02);
        sqlcodigos:=' and '+FGeral.GetIn('move_esto_codigo',QRel.fieldbyname('Relg_tipos').asstring,'C');
        sqldev:=' and '+FGeral.GetNOTIN('move_tipomov',tiposdev,'C');
        QSoma:=sqltoquery('select sum(move_qtde*move_venda) as valor from movestoque '+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=moes_tipomov )'+
                    ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('moes_tipomov',tiposmov,'C')+
                    sqldata+sqlunidade+sqlcodigos+sqldev+
                    sqldatacont );
        valormesano:=QSoma.fieldbyname('valor').ascurrency;
        FGeral.FechaQuery(QSoma);
        sqldata:=' and moes_datamvto>='+DatetoSql(datai3)+' and moes_datamvto<='+DatetoSql(dataf03);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai3)+' and moes_dataemissao<='+DatetoSql(dataf03);
        QSoma:=sqltoquery('select sum(move_qtde*move_venda) as valor from movestoque '+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=moes_tipomov )'+
                    ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('moes_tipomov',tiposmov,'C')+
                    sqldata+sqlunidade+sqlcodigos+sqldev+
                    sqldatacont );
        valormesanofinal:=QSoma.fieldbyname('valor').ascurrency;
        FGeral.FechaQuery(QSoma);

      end else if QRel.fieldbyname('Relg_tipo').asstring='G' then begin

        sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
        if QRel.fieldbyname('Relg_es').asstring='E' then
          tiposmov:=Global.TiposRelCompra+';'+Global.CodTransfEntrada
        else                                 // 10.08.16
          tiposmov:=Global.TiposRelVenda;
        if Global.Usuario.OutrosAcessos[0701] then
          sqldatacont:=''
        else
          sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf);
// 20.07.15
        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf02);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai)+' and moes_dataemissao<='+DatetoSql(dataf02);
//        sqlcodigos:=' and '+FGeral.GetIn('move_grup_codigo',QRel.fieldbyname('Relg_tipos').asstring,'N');
        sqlcodigos:=' and '+FGeral.GetIn('esto_grup_codigo',QRel.fieldbyname('Relg_tipos').asstring,'N');
        sqldev:=' and '+FGeral.GetNOTIN('move_tipomov',tiposdev,'C');
        QSoma:=sqltoquery('select sum(move_qtde*move_venda) as valor from movestoque '+
                    ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=moes_tipomov )'+
                    ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('moes_tipomov',tiposmov,'C')+
// 31.01.13
                    ' and '+FGeral.GetIn('move_tipomov',tiposmov,'C')+
                    sqldata+sqlunidade+sqlcodigos+sqldev+
                    sqldatacont );
        valormesano:=QSoma.fieldbyname('valor').ascurrency;
        FGeral.FechaQuery(QSoma);
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai02)+' and moes_datamvto<='+DatetoSql(dataf02);
        sqldata:=' and moes_datamvto>='+DatetoSql(datai3)+' and moes_datamvto<='+DatetoSql(dataf03);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai3)+' and moes_dataemissao<='+DatetoSql(dataf03);
        QSoma:=sqltoquery('select sum(move_qtde*move_venda) as valor from movestoque '+
                    ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=moes_tipomov )'+
                    ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('moes_tipomov',tiposmov,'C')+
// 31.01.13
                    ' and '+FGeral.GetIn('move_tipomov',tiposmov,'C')+
                    sqldata+sqlunidade+sqlcodigos+sqldev+
                    sqldatacont );
        valormesanofinal:=QSoma.fieldbyname('valor').ascurrency;
        FGeral.FechaQuery(QSoma);
// 16.03.12
      end else if QRel.fieldbyname('Relg_tipo').asstring='S' then begin

        sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
        if QRel.fieldbyname('Relg_es').asstring='E' then
          tiposmov:=Global.TiposRelCompra+';'+Global.CodTransfEntrada
        else
          tiposmov:=Global.TiposRelVenda;
        if Global.Usuario.OutrosAcessos[0701] then
          sqldatacont:=''
        else
          sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf);
// 20.07.15
        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf02);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai)+' and moes_dataemissao<='+DatetoSql(dataf02);
//        sqlcodigos:=' and '+FGeral.GetIn('move_grup_codigo',QRel.fieldbyname('Relg_tipos').asstring,'N');
        sqlcodigos:=' and '+FGeral.GetIn('esto_sugr_codigo',QRel.fieldbyname('Relg_tipos').asstring,'N');
        sqldev:=' and '+FGeral.GetNOTIN('move_tipomov',tiposdev,'C');
        QSoma:=sqltoquery('select sum(move_qtde*move_venda) as valor from movestoque '+
                    ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=moes_tipomov )'+
                    ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('moes_tipomov',tiposmov,'C')+
// 31.01.13
                    ' and '+FGeral.GetIn('move_tipomov',tiposmov,'C')+
                    sqldata+sqlunidade+sqlcodigos+sqldev+
                    sqldatacont );
        valormesano:=QSoma.fieldbyname('valor').ascurrency;
        FGeral.FechaQuery(QSoma);
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai02)+' and moes_datamvto<='+DatetoSql(dataf02);
        sqldata:=' and moes_datamvto>='+DatetoSql(datai3)+' and moes_datamvto<='+DatetoSql(dataf03);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai3)+' and moes_dataemissao<='+DatetoSql(dataf03);
        QSoma:=sqltoquery('select sum(move_qtde*move_venda) as valor from movestoque '+
                    ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=moes_tipomov )'+
                    ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('moes_tipomov',tiposmov,'C')+
// 31.01.13
                    ' and '+FGeral.GetIn('move_tipomov',tiposmov,'C')+
                    sqldata+sqlunidade+sqlcodigos+sqldev+
                    sqldatacont );
        valormesanofinal:=QSoma.fieldbyname('valor').ascurrency;
        FGeral.FechaQuery(QSoma);


      end else if QRel.fieldbyname('Relg_tipo').asstring='C' then begin

        if EdCompete.Text='1' then begin  // por Caixa
            sqlunidade:=' and '+FGeral.getin('movf_unid_codigo',EdUnid_codigo.text,'C');
            if QRel.fieldbyname('Relg_es').asstring='E' then
              tiposmov:=Global.TiposRelCompra+';'+Global.CodTransfEntrada
            else
              tiposmov:=Global.TiposRelVenda;
            if Global.Usuario.OutrosAcessos[0701] then
              sqldatacont:=''
            else
              sqldatacont:=' and movf_datacont > '+DateToSql(Global.DataMenorBanco);
    //        sqldata:=' and movf_datamvto>='+DatetoSql(datai)+' and movf_datamvto<='+DatetoSql(dataf);
    // 20.07.15
            sqldata:=' and movf_datamvto>='+DatetoSql(datai)+' and movf_datamvto<='+DatetoSql(dataf02);
            sqlcodigos:=' and '+FGeral.GetIn('movf_plan_contard',QRel.fieldbyname('Relg_tipos').asstring,'N');
            QSoma:=sqltoquery('select sum(movf_valorger) as valor from movfin '+
                        ' where '+FGeral.GetIN('movf_status',statusvalidos,'C')+
                        ' and movf_es='+Stringtosql(QRel.fieldbyname('Relg_es').asstring)+
                        sqldata+sqlunidade+sqlcodigos+
                        sqldatacont );
            valormesano:=QSoma.fieldbyname('valor').ascurrency;
            FGeral.FechaQuery(QSoma);
    //        sqldata:=' and movf_datamvto>='+DatetoSql(datai02)+' and movf_datamvto<='+DatetoSql(dataf02);
            sqldata:=' and movf_datamvto>='+DatetoSql(datai3)+' and movf_datamvto<='+DatetoSql(dataf03);
            QSoma:=sqltoquery('select sum(movf_valorger) as valor from movfin '+
                        ' where '+FGeral.GetIN('movf_status',statusvalidos,'C')+
                        ' and movf_es='+Stringtosql(QRel.fieldbyname('Relg_es').asstring)+
                        sqldata+sqlunidade+sqlcodigos+
                        sqldatacont );
            valormesanofinal:=Qsoma.fieldbyname('valor').ascurrency;
            FGeral.FechaQuery(QSoma);

        end else begin   // por competencia

            sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
            if QRel.fieldbyname('Relg_es').asstring='E' then
              tiposmov:=Global.TiposRelCompra+';'+Global.CodTransfEntrada
            else
              tiposmov:=Global.TiposRelVenda;
            if Global.Usuario.OutrosAcessos[0701] then
              sqldatacont:=''
            else
              sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);
            sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf02);
            sqlcodigos:=' and '+FGeral.GetIn('moes_plan_codigo',QRel.fieldbyname('Relg_tipos').asstring,'N');
            QSoma:=sqltoquery('select sum(moes_vlrtotal) as valor from movesto '+
                        ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                        sqldata+sqlunidade+sqlcodigos+
                        sqldatacont );
            valormesano:=QSoma.fieldbyname('valor').ascurrency;
            FGeral.FechaQuery(QSoma);
            sqldata:=' and moes_datamvto>='+DatetoSql(datai3)+' and moes_datamvto<='+DatetoSql(dataf03);
            QSoma:=sqltoquery('select sum(moes_vlrtotal) as valor from movesto '+
                        ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                        sqldata+sqlunidade+sqlcodigos+
                        sqldatacont );
            valormesanofinal:=Qsoma.fieldbyname('valor').ascurrency;
            FGeral.FechaQuery(QSoma);
        end;

      end else if QRel.fieldbyname('Relg_tipo').asstring='T' then begin

        sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
        if QRel.fieldbyname('Relg_es').asstring='E' then
          tiposmov:=Global.TiposRelCompra+';'+Global.CodTransfEntrada
        else
          tiposmov:=Global.TiposRelVenda;
        if Global.Usuario.OutrosAcessos[0701] then
          sqldatacont:=''
        else
          sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf);
// 20.07.15
        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf02);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai)+' and moes_dataemissao<='+DatetoSql(dataf02);
        sqlcodigos:=' and '+FGeral.GetIn('moes_tipomov',QRel.fieldbyname('Relg_tipos').asstring,'C');
        QSoma:=sqltoquery('select sum(moes_vlrtotal) as valor from movesto '+
                    ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
//                    ' and '+FGeral.GetIn('moes_tipomov',tiposmov,'C')+
                    sqldata+sqlunidade+sqlcodigos+
                    sqldatacont );
        valormesano:=QSoma.fieldbyname('valor').ascurrency;
        FGeral.FechaQuery(QSoma);
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai02)+' and moes_datamvto<='+DatetoSql(dataf02);
        sqldata:=' and moes_datamvto>='+DatetoSql(datai3)+' and moes_datamvto<='+DatetoSql(dataf03);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai3)+' and moes_dataemissao<='+DatetoSql(dataf03);
        QSoma:=sqltoquery('select sum(moes_vlrtotal) as valor from movesto '+
                    ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
//                    ' and '+FGeral.GetIn('moes_tipomov',tiposmov,'C')+
                    sqldata+sqlunidade+sqlcodigos+
                    sqldatacont );
        valormesanofinal:=QSoma.fieldbyname('valor').ascurrency;
        FGeral.FechaQuery(QSoma);

// 10.05.14 - compras/vendas a vista
///////////////////////////////////////
      end else if QRel.fieldbyname('Relg_tipo').asstring='A' then begin

        sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
        if QRel.fieldbyname('Relg_es').asstring='E' then
          tiposmov:=Global.TiposRelCompra+';'+Global.CodTransfEntrada
        else
          tiposmov:=Global.TiposRelVenda;
        if Global.Usuario.OutrosAcessos[0701] then
          sqldatacont:=''
        else
          sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf);
// 20.07.15
        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf02);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai)+' and moes_dataemissao<='+DatetoSql(dataf02);
        sqlcodigos:='';
        QSoma:=sqltoquery('select sum(moes_vlrtotal) as valor from movesto '+
                    ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('moes_tipomov',tiposmov,'C')+
                    ' and moes_vispra='+Stringtosql('V')+
                    sqldata+sqlunidade+sqlcodigos+
                    sqldatacont );
        valormesano:=QSoma.fieldbyname('valor').ascurrency;
        FGeral.FechaQuery(QSoma);
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai02)+' and moes_datamvto<='+DatetoSql(dataf02);
        sqldata:=' and moes_datamvto>='+DatetoSql(datai3)+' and moes_datamvto<='+DatetoSql(dataf03);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai3)+' and moes_dataemissao<='+DatetoSql(dataf03);
        QSoma:=sqltoquery('select sum(moes_vlrtotal) as valor from movesto '+
                    ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('moes_tipomov',tiposmov,'C')+
                    ' and moes_vispra='+Stringtosql('V')+
                    sqldata+sqlunidade+sqlcodigos+
                    sqldatacont );
        valormesanofinal:=QSoma.fieldbyname('valor').ascurrency;
        FGeral.FechaQuery(QSoma);

// 10.05.14 - Compras/Vendas a Prazo
///////////////////////////////////////
      end else if QRel.fieldbyname('Relg_tipo').asstring='B' then begin

        sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
        if QRel.fieldbyname('Relg_es').asstring='E' then
          tiposmov:=Global.TiposRelCompra+';'+Global.CodTransfEntrada
        else
          tiposmov:=Global.TiposRelVenda;
        if Global.Usuario.OutrosAcessos[0701] then
          sqldatacont:=''
        else
          sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf);
// 20.07.15
        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf02);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai)+' and moes_dataemissao<='+DatetoSql(dataf02);
        sqlcodigos:='';
        QSoma:=sqltoquery('select sum(moes_vlrtotal) as valor from movesto '+
                    ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('moes_tipomov',tiposmov,'C')+
                    ' and moes_vispra='+Stringtosql('P')+
                    sqldata+sqlunidade+sqlcodigos+
                    sqldatacont );
        valormesano:=QSoma.fieldbyname('valor').ascurrency;
        FGeral.FechaQuery(QSoma);
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai02)+' and moes_datamvto<='+DatetoSql(dataf02);
        sqldata:=' and moes_datamvto>='+DatetoSql(datai3)+' and moes_datamvto<='+DatetoSql(dataf03);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai3)+' and moes_dataemissao<='+DatetoSql(dataf03);
        QSoma:=sqltoquery('select sum(moes_vlrtotal) as valor from movesto '+
                    ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('moes_tipomov',tiposmov,'C')+
                    ' and moes_vispra='+Stringtosql('P')+
                    sqldata+sqlunidade+sqlcodigos+
                    sqldatacont );
        valormesanofinal:=QSoma.fieldbyname('valor').ascurrency;
        FGeral.FechaQuery(QSoma);

// 10.05.14 - CMV
///////////////////////////////////////
      end else if QRel.fieldbyname('Relg_tipo').asstring='D' then begin

        sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C');
        tiposmov:=Global.TiposRelVenda;
        if Global.Usuario.OutrosAcessos[0701] then
          sqldatacont:=''
        else
          sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);
//        sqldata:=' and move_datamvto>='+DatetoSql(datai)+' and move_datamvto<='+DatetoSql(dataf);
// 20.07.15
        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf02);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai)+' and moes_dataemissao<='+DatetoSql(dataf02);
        sqlcodigos:='';
        QSoma:=sqltoquery('select move_esto_codigo,move_tipomov,sum(move_qtde) as move_qtde from movestoque '+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                    ' where '+FGeral.GetIN('move_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('move_tipomov',tiposmov,'C')+
                    sqldata+sqlunidade+sqlcodigos+
                    sqldatacont+' group by move_esto_codigo,move_tipomov' );
        valormesano:=0;
        while not Qsoma.eof do begin
          if pos(QSoma.fieldbyname('move_tipomov').AsString,tiposdev)>0 then
            valormesano:=valormesano-(QSoma.fieldbyname('move_qtde').AsCurrency*FEstoque.GetCusto(QSoma.fieldbyname('move_esto_codigo').AsString,copy(EdUnid_codigo.text,1,3),'custo') )
          else
            valormesano:=valormesano+(QSoma.fieldbyname('move_qtde').AsCurrency*FEstoque.GetCusto(QSoma.fieldbyname('move_esto_codigo').AsString,copy(EdUnid_codigo.text,1,3),'custo') );
          Qsoma.Next;
        end;
        FGeral.FechaQuery(QSoma);
//        sqldata:=' and move_datamvto>='+DatetoSql(datai02)+' and move_datamvto<='+DatetoSql(dataf02);
        sqldata:=' and moes_datamvto>='+DatetoSql(datai3)+' and moes_datamvto<='+DatetoSql(dataf03);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai3)+' and moes_dataemissao<='+DatetoSql(dataf03);
        QSoma:=sqltoquery('select move_esto_codigo,move_tipomov,sum(move_qtde) as move_qtde from movestoque '+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                    ' where '+FGeral.GetIN('move_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('move_tipomov',tiposmov,'C')+
                    sqldata+sqlunidade+sqlcodigos+
                    sqldatacont+' group by move_esto_codigo,move_tipomov' );
        valormesanofinal:=0;
        while not Qsoma.eof do begin
          if pos(QSoma.fieldbyname('move_tipomov').AsString,tiposdev)>0 then
            valormesano:=valormesano-(QSoma.fieldbyname('move_qtde').AsCurrency*FEstoque.GetCusto(QSoma.fieldbyname('move_esto_codigo').AsString,copy(EdUnid_codigo.text,1,3),'custo') )
          else
            valormesano:=valormesano+(QSoma.fieldbyname('move_qtde').AsCurrency*FEstoque.GetCusto(QSoma.fieldbyname('move_esto_codigo').AsString,copy(EdUnid_codigo.text,1,3),'custo') );
          Qsoma.Next;
        end;

        FGeral.FechaQuery(QSoma);


// 10.05.14 - CMV  de serviços prestados
///////////////////////////////////////
      end else if QRel.fieldbyname('Relg_tipo').asstring='E' then begin

        sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C');
        tiposmov:=Global.CodPrestacaoServicos;
        if Global.Usuario.OutrosAcessos[0701] then
          sqldatacont:=''
        else
          sqldatacont:=' and move_datacont > '+DateToSql(Global.DataMenorBanco);
//        sqldata:=' and move_datamvto>='+DatetoSql(datai)+' and move_datamvto<='+DatetoSql(dataf);
// 20.07.15
        sqldata:=' and moes_datamvto>='+DatetoSql(datai)+' and moes_datamvto<='+DatetoSql(dataf02);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai)+' and moes_dataemissao<='+DatetoSql(dataf02);
        sqlcodigos:='';
        QSoma:=sqltoquery('select move_esto_codigo,move_tipomov,sum(move_qtde) as move_qtde from movestoque '+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                    ' where '+FGeral.GetIN('move_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('move_tipomov',tiposmov,'C')+
                    sqldata+sqlunidade+sqlcodigos+
                    sqldatacont+' group by move_esto_codigo,move_tipomov' );
        valormesano:=0;
        while not Qsoma.eof do begin
          if pos(QSoma.fieldbyname('move_tipomov').AsString,tiposdev)>0 then
            valormesano:=valormesano-(QSoma.fieldbyname('move_qtde').AsCurrency*FEstoque.GetCusto(QSoma.fieldbyname('move_esto_codigo').AsString,copy(EdUnid_codigo.text,1,3),'custo') )
          else
            valormesano:=valormesano+(QSoma.fieldbyname('move_qtde').AsCurrency*FEstoque.GetCusto(QSoma.fieldbyname('move_esto_codigo').AsString,copy(EdUnid_codigo.text,1,3),'custo') );
          Qsoma.Next;
        end;
        FGeral.FechaQuery(QSoma);
//        sqldata:=' and move_datamvto>='+DatetoSql(datai02)+' and move_datamvto<='+DatetoSql(dataf02);
        sqldata:=' and moes_datamvto>='+DatetoSql(datai3)+' and moes_datamvto<='+DatetoSql(dataf03);
// 24.10.16
        if EdCompete.text='2' then
          sqldata:=' and moes_dataemissao>='+DatetoSql(datai3)+' and moes_dataemissao<='+DatetoSql(dataf03);
        QSoma:=sqltoquery('select move_esto_codigo,move_tipomov,sum(move_qtde) as move_qtde from movestoque '+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                    ' where '+FGeral.GetIN('move_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                    ' and '+FGeral.GetIn('move_tipomov',tiposmov,'C')+
                    sqldata+sqlunidade+sqlcodigos+
                    sqldatacont+' group by move_esto_codigo,move_tipomov' );
        valormesanofinal:=0;
        while not Qsoma.eof do begin
          if pos(QSoma.fieldbyname('move_tipomov').AsString,tiposdev)>0 then
            valormesano:=valormesano-(QSoma.fieldbyname('move_qtde').AsCurrency*FEstoque.GetCusto(QSoma.fieldbyname('move_esto_codigo').AsString,copy(EdUnid_codigo.text,1,3),'custo') )
          else
            valormesano:=valormesano+(QSoma.fieldbyname('move_qtde').AsCurrency*FEstoque.GetCusto(QSoma.fieldbyname('move_esto_codigo').AsString,copy(EdUnid_codigo.text,1,3),'custo') );
          Qsoma.Next;
        end;

        FGeral.FechaQuery(QSoma);

// 11.04.16 - Valor total do inventario no periodo
      end else if QRel.FieldByName('Relg_tipo').asstring='I' then begin
      ///////////////////////////////////////////////////////////////////////////////

        mesanoi:=strzero(DatetoMes(Datai),2)+strzero(DatetoAno(Datai,true),4);
        mesanof:=strzero(DatetoMes(Dataf02),2)+strzero(DatetoAno(Dataf02,true),4);
        sqlunidade:=' and '+FGeral.getin('saes_unid_codigo',EdUnid_codigo.text,'C');
        sqldata:=' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesanoi))+' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesanof));
        sqlcodigos:='';
        QSoma:=sqltoquery('select saes_esto_codigo,sum(saes_qtde*saes_customedio) as custoitem from salestoque '+
                    ' where '+FGeral.GetIN('saes_status',statusvalidos,'C')+
                    ' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesanof))+
                    sqlunidade+sqldata+
                    ' group by saes_esto_codigo' );
        valormesano:=0;
        while not Qsoma.eof do begin
          valormesano:=valormesano+QSoma.fieldbyname('custoitem').AsCurrency;
//          *FEstoque.GetCusto(QSoma.fieldbyname('move_esto_codigo').AsString,copy(EdUnid_codigo.text,1,3),'custo') );
          Qsoma.Next;
        end;
        FGeral.FechaQuery(QSoma);
        mesanoi:=strzero(DatetoMes(Datai3),2)+strzero(DatetoAno(Datai3,true),4);
        mesanof:=strzero(DatetoMes(Dataf03),2)+strzero(DatetoAno(Dataf03,true),4);
        sqldata:=' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesanoi))+' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesanof));
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai3)+' and moes_datamvto<='+DatetoSql(dataf03);
        QSoma:=sqltoquery('select saes_esto_codigo,sum(saes_qtde*saes_customedio) as custoitem from salestoque '+
                    ' where '+FGeral.GetIN('saes_status',statusvalidos,'C')+
                   ' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesanof))+
                    sqlunidade+sqldata+
                    ' group by saes_esto_codigo' );
        valormesanofinal:=0;
        while not Qsoma.eof do begin
          valormesanofinal:=valormesanofinal+QSoma.fieldbyname('custoitem').AsCurrency;
          Qsoma.Next;
        end;

        FGeral.FechaQuery(QSoma);

// 30.05.16 - Valor total do inventario no periodo ANTERIOR ao periodo informado
      end else if QRel.FieldByName('Relg_tipo').asstring='F' then begin
      ///////////////////////////////////////////////////////////////////////////////

        mesanoi:=strzero(DatetoMes(Datai),2)+strzero(DatetoAno(Datai,true),4);
        mesanof:=strzero(DatetoMes(Dataf02),2)+strzero(DatetoAno(Dataf02,true),4);
        if mesanoi='01' then begin
          mesanoi:='12';
          mesanof:=strzero(strtoint(mesanof)-1,4);
        end else begin
          mesanoi:=strzero(strtoint(mesanoi)-1,2)
        end;
        sqlunidade:=' and '+FGeral.getin('saes_unid_codigo',EdUnid_codigo.text,'C');
        sqldata:=' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesanoi))+' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesanof));
        sqlcodigos:='';
        QSoma:=sqltoquery('select saes_esto_codigo,sum(saes_qtde*saes_customedio) as custoitem from salestoque '+
                    ' where '+FGeral.GetIN('saes_status',statusvalidos,'C')+
                    ' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesanof))+
                    sqlunidade+sqldata+
                    ' group by saes_esto_codigo' );
        valormesano:=0;
        while not Qsoma.eof do begin
          valormesano:=valormesano+QSoma.fieldbyname('custoitem').AsCurrency;
//          *FEstoque.GetCusto(QSoma.fieldbyname('move_esto_codigo').AsString,copy(EdUnid_codigo.text,1,3),'custo') );
          Qsoma.Next;
        end;
        FGeral.FechaQuery(QSoma);
        mesanoi:=strzero(DatetoMes(Datai3),2)+strzero(DatetoAno(Datai3,true),4);
        mesanof:=strzero(DatetoMes(Dataf03),2)+strzero(DatetoAno(Dataf03,true),4);
// 30.05.16
        if mesanoi='01' then begin
          mesanoi:='12';
          mesanof:=strzero(strtoint(mesanof)-1,4);
        end else begin
          mesanoi:=strzero(strtoint(mesanoi)-1,2)
        end;
        sqldata:=' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesanoi))+' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesanof));
//        sqldata:=' and moes_datamvto>='+DatetoSql(datai3)+' and moes_datamvto<='+DatetoSql(dataf03);
        QSoma:=sqltoquery('select saes_esto_codigo,sum(saes_qtde*saes_customedio) as custoitem from salestoque '+
                    ' where '+FGeral.GetIN('saes_status',statusvalidos,'C')+
                   ' and saes_mesano='+Stringtosql(FGeral.AnoMesinvertido(Mesanof))+
                    sqlunidade+sqldata+
                    ' group by saes_esto_codigo' );
        valormesanofinal:=0;
        while not Qsoma.eof do begin
          valormesanofinal:=valormesanofinal+QSoma.fieldbyname('custoitem').AsCurrency;
          Qsoma.Next;
        end;

        FGeral.FechaQuery(QSoma);

// 28.03.12 - 'formula' com linhas do relatorio já impressas..como subtotais
      end else if QRel.fieldbyname('Relg_tipo').asstring='M' then begin
      //////////////////////////////////////////////////////////////
         valormesano:=GetValores(1,QRel.fieldbyname('Relg_tipos').asstring);
         valormesanofinal:=GetValores(2,QRel.fieldbyname('Relg_tipos').asstring);
      end;
      if QRel.FieldByName('relg_tipo').AsString='C' then
        FRel.AddCel('Contas Despesa/Rec.')
      else if QRel.FieldByName('relg_tipo').AsString='P' then
        FRel.AddCel('Codigo Produtos')
      else if QRel.FieldByName('relg_tipo').AsString='G' then
        FRel.AddCel('Grupo Produtos')
      else if QRel.FieldByName('relg_tipo').AsString='S' then
        FRel.AddCel('SubGrupo Produtos')
      else if QRel.FieldByName('relg_tipo').AsString='M' then
        FRel.AddCel('Subtotal')
      else if QRel.FieldByName('relg_tipo').AsString='I' then
        FRel.AddCel('Inventário')
      else
        FRel.AddCel('Tipos de Mov.');
      FRel.AddCel(QRel.FieldByName('relg_tipos').AsString);
      FRel.AddCel(QRel.FieldByName('Relg_titulolin').AsString);
      variacao:=valormesanofinal-valormesano;
      if valormesano>0 then
        variacao:=( (variacao/valormesano)*100 )
      else
        variacao:=0;
      if QRel.FieldByName('relg_sinal').AsString='-' then
        multi:=-1
      else
        multi:=1;
      FRel.AddCel( Floattostr(multi*valormesano) );
      FRel.AddCel( Floattostr(multi*valormesanofinal) );
      FRel.AddCel( Floattostr(variacao) );
      New(PLinhas);
      PLinhas.linharel:=(QRel.FieldByName('Relg_ordem').AsString);
      PLInhas.valorcoluna01:=multi*valormesano;
      PLInhas.valorcoluna02:=multi*valormesanofinal;
      Linhas.Add(PLinhas);
//}
//////////////////////////////////////
      QRel.Next;
    end;

    FGeral.FechaQuery(QRel);
    FRel.Video;
    Sistema.EndProcess('');

    FRelFinan_DRE(nomerel);     // 22

  end;

end;


// 18.11.15
procedure FRelFinan_DepositoemConta(DtInicio,DtFim:TDatetime);        // 23
//////////////////////////////////////////////////////////////
var statusvalidos,titulo,sqlorder,sqltipomov,tiposmov,sqldata,titconta:string;
    Q:TSqlquery;

begin
////////////////////////////////////////////////////////////////////////////////

  with FRelFinan do begin
    EdLancai.setdate(DtInicio);
    EdLancaf.setdate(Dtfim);
    EdUnid_codigo.text:=Global.codigounidade;
    if not FRelFinan_Execute(23) then Exit;

    statusvalidos:='N';   // E devido as devolucoes do regime especial
    sqlorder:=' order by movf_unid_codigo,movf_datamvto';
    sqlunidade:=' and '+FGeral.getin('movf_unid_codigo',EdUnid_codigo.text,'C');
    tiposmov:=Global.CodLanCaixabancos;
    sqltipomov:='and '+FGeral.GetIN('movf_tipomov',tiposmov,'C');
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
      sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);
    if ( not EdLancai.IsEmpty ) and ( not EdLancaf.IsEmpty ) then
      sqldata:=' and movf_datamvto>='+Edlancai.AsSql+' and movf_datamvto<='+Edlancaf.AsSql
    else if ( not EdLancai.IsEmpty ) then
      sqldata:=' and movf_datamvto>='+Edlancai.AsSql
    else if ( not EdLancaf.IsEmpty ) then
      sqldata:=' and movf_datamvto<='+Edlancaf.AsSql
    else
      sqldata:='';
    titconta:='';
    if not EdPlan_conta.IsEmpty then  begin
      titconta:='Conta '+EdPlan_conta.Text+' - '+EdPlan_conta.ResultFind.fieldbyname('plan_descricao').AsString;
    end;
////////
    titulo:='Relação de Valores ref. Depósito em Conta - Período '+FGeral.FormataData(Edlancai.asdate)+' a '+FGeral.FormataData(Edlancaf.asdate);
    Q:=sqltoquery('select *  from movfin'+
                  ' where '+FGeral.GetIN('movf_status',statusvalidos,'C')+
                  ' and movf_numerodcto = '+Stringtosql('503')+
                  sqldata+
                  sqlunidade+
                  sqldatacont+
                  sqltipomov+
                  sqlorder );
    Sistema.BeginProcess('Gerando Relatório');
    if Q.Eof then begin
      Avisoerro('Nada encontrado para impressão');
      Q.close;
      Freeandnil(Q);
      Sistema.EndProcess('');
      exit;
    end else begin
      FRel.Init('RelDepositoemConta');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
      FRel.AddTit(titconta);
      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'        ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Movimento'        ,''         ,'',false);
      FRel.AddCol(200,0,'C','' ,''              ,'Histórico'        ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor Depósito'   ,''         ,'',false);
 ///     FRel.AddCol(100,0,'C','' ,''              ,'Conta Depósito'   ,''         ,'',false);

      while not Q.eof do begin
          FRel.AddCel(Q.FieldByName('movf_transacao').AsString);
          FRel.AddCel(Q.FieldByName('movf_datamvto').AsString);
          FRel.AddCel(Q.FieldByName('movf_complemento').AsString);
          FRel.AddCel(Q.FieldByName('movf_valorger').AsString);
//          FRel.AddCel(Q.FieldByName('clie_datacont').AsString);
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

    FRelFinan_DepositoemConta(EdLancai.AsDate,EdLancaf.asdate);     // 23

  end;

end;


// 19.11.15
procedure FRelFinan_PedidosFaturados;     // 24
///////////////////////////////////////////////////////////
var statusvalidos,titulo,sqlorder,sqltipocod,sqltipomov,tiposmov,tiposvenda,tiposdev:string;
    Q:TSqlquery;
    p:integer;

    function GetPedidos(xtransacao:string):string;
    ///////////////////////////////////////////////////
    var QP:TSqlquery;
    begin
      QP:=sqltoquery('select move_remessas from movestoque where move_transacao='+Stringtosql(xtransacao));
      result:=Qp.fieldbyname('move_remessas').asstring;
      FGeral.Fechaquery(QP);

    end;

begin
//////////////////
  with FRelFinan do begin
    if not FRelFinan_Execute(24) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    statusvalidos:='N;E;D';
    sqlorder:=' order by moes_unid_codigo,moes_dataemissao,moes_numerodoc';
    sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
    if EdCodtipo.Asinteger>0 then begin
      if Edtipocad.text='R' then
        sqltipocod:=' and moes_repr_codigo='+EdCodtipo.assql
      else if Edtipocad.text='S' then
        sqltipocod:=' and '+FGeral.Getin('moes_repr_codigo',FRepresentantes.GetCodigosRepres(EdCodtipo.asinteger),'N')
      else
        sqltipocod:=' and ( (moes_tipo_codigo='+EdCodtipo.assql+') and (moes_tipocad='+EdTipocad.Assql+') )';
    end else
      sqltipocod:='';
    if EdTiposmov.isempty then begin
      tiposmov:=Global.CodRemessaConsig+';'+Global.CodTransfEntrada+';'+
                Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodRemessaProntaEntrega+';'+Global.CodSimplesRemessa+';'+
                Global.CodDevolucaoSimbolicaConsig;  // 22.05.14
      Tiposvenda:=Global.TiposRelVenda;
      Tiposdev:=Global.TiposRelDevVenda;
    end else begin
      tiposmov:='';
      tiposvenda:=EdTiposmov.text;
      statusvalidos:='N;E;D';
    end;

    if trim(tiposmov)<>'' then
      sqltipomov:='and '+FGeral.GetNOTIN('moes_tipomov',tiposmov,'C')
    else
      sqltipomov:='';
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
      sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);

    titulo:='Pedidos Faturados de '+FGeral.FormataData(Edlancai.asdate)+' a '+FGeral.FormataData(Edlancaf.asdate)+
            ' - Tipos Impressos: '+TiposVenda+';'+TiposDev ;
    Q:=sqltoquery('select * from movesto'+
                  ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                  ' and moes_datamvto>='+Edlancai.AsSql+' and moes_datamvto<='+Edlancaf.AsSql+
                  sqlunidade+
                  sqltipocod+
                  sqltipomov+
                  sqldatacont+
                  ' and '+FGeral.getin('moes_tipomov',tiposvenda+';'+tiposdev,'C')+
                  sqlorder );

    if Q.Eof then
      Avisoerro('Nada encontrado para impressão')
    else begin
      FRel.Init('RelPedidosFaturados');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
//      FRel.AddTit(Periodo);
      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
      FRel.AddCol( 60,1,'C','' ,''              ,'Status'          ,''         ,'',False);
      FRel.AddCol(120,1,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
      FRel.AddCol( 60,0,'C','' ,''              ,'Tipo'            ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor Total'     ,''         ,'',false);
      FRel.AddCol(200,0,'C','' ,''              ,'Pedidos Faturados'  ,''         ,'',false);
      while not Q.eof do begin
          FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
          FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
          FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
          FRel.AddCel(Q.FieldByName('moes_datacont').AsString);
          FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('moes_status').AsString);
          FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FConfMovimento.GetDescricao(Q.fieldbyname('moes_comv_codigo').asinteger));
          FRel.AddCel(Q.FieldByName('moes_tipocad').AsString);
          FRel.AddCel(Q.FieldByName('moes_tipo_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'N'));
          FRel.AddCel(Q.FieldByName('moes_valortotal').Asstring);
          FRel.AddCel( GetPedidos(Q.FieldByName('moes_transacao').AsString) );
        Q.Next;
      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

    FRelFinan_PedidosFaturados;     // 24

  end;

end;

// 14.08.17
procedure FRelFinan_Carregados;     // 25
////////////////////////////////////////////////////////////
var Q,Q1:TSqlquery;
    statusvalidos,sqlorder,sqltipocod,sqltipomov,titulo:string;
begin
  with FRelFinan do begin

    if not FRelFinan_Execute(25) then Exit;
    statusvalidos:='N;E;D';
    sqlorder:=' order by mova_unid_codigo,mova_dtabate,mova_numerodoc';
    sqlunidade:=' and '+FGeral.getin('mova_unid_codigo',EdUnid_codigo.text,'C');
    if EdCodtipo.Asinteger>0 then begin
        sqltipocod:=' and mova_tipo_codigo='+EdCodtipo.assql;
    end else
      sqltipocod:='';
    statusvalidos:='N;E;D';

    sqltipomov:='and '+FGeral.GetIN('mova_tipomov','SA','C');
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
      sqldatacont:=' and mova_datacont > '+DateToSql(Global.DataMenorBanco);
    titulo:='Pedidos Pesados de '+FGeral.FormataData(Edlancai.asdate)+' a '+FGeral.FormataData(Edlancaf.asdate);

    Q:=sqltoquery('select movabate.*,clie_nome from movabate inner join clientes on (clie_codigo=mova_tipo_codigo)'+
                  ' where '+FGeral.GetIN('mova_status',statusvalidos,'C')+
//                  ' and movd_datamvto>='+Edlancai.AsSql+' and movd_datamvto<='+Edlancaf.AsSql+
                  ' and mova_dtabate>='+Edlancai.AsSql+' and mova_dtabate<='+Edlancaf.AsSql+
                  ' and mova_tipomov = '+Stringtosql('SA')+
                  ' and mova_status  = '+Stringtosql('N')+
                  ' and extract( year from mova_dtabate ) = extract( year from mova_datalcto )'+
                  sqlunidade+
                  sqltipocod+
                  sqltipomov+
                  sqldatacont+
                  sqlorder );
    if Q.eof then begin
      Avisoerro('Nada encontrado para impressão');
      exit;
    end;
    Sistema.BeginProcess('Gerando Relatório');
      FRel.Init('RelCarregados');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));

//      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'       ,''         ,'',false);
//      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Data'         ,''         ,'',false);
//      FRel.AddCol( 55,2,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
      FRel.AddCol( 45,0,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(200,0,'C','' ,''              ,'Nome'            ,''         ,'',false);


      FRel.AddCol( 45,0,'C','' ,''              ,'Cod.Prod.'          ,''         ,'',false);
      FRel.AddCol(250,0,'C','' ,''              ,'Descrição'            ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',''              ,'Peças'             ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Peso'          ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Balança'          ,''         ,'',false);


      while not Q.eof do begin

        Q1:=sqltoquery('select movabatedet.*,esto_descricao from movabatedet inner join estoque on ( esto_codigo=movd_esto_codigo)'+
                  ' where '+FGeral.GetIN('movd_status',statusvalidos,'C')+
                  ' and movd_tipomov = '+Stringtosql('SA')+
                  ' and movd_transacao  = '+Stringtosql(Q.fieldbyname('mova_transacao').asstring)+
//                  ' and movd_numerodoc  = '+Stringtosql(Q.fieldbyname('mova_numerodoc').asstring)+
                  ' and movd_unid_codigo = '+Stringtosql(Q.fieldbyname('mova_unid_codigo').asstring) );

        while not Q1.eof do begin

//          FRel.AddCel(Q.FieldByName('movd_transacao').AsString);
//          FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
          FRel.AddCel(Q.FieldByName('mova_dtabate').AsString);
//          FRel.AddCel(Q.FieldByName('mova_datacont').AsString);
          FRel.AddCel(Q.FieldByName('mova_numerodoc').AsString);
//          FRel.AddCel(Q.FieldByName('mova_tipomov').AsString+'-'+FConfMovimento.GetDescricao(Q.fieldbyname('moes_comv_codigo').asinteger));
//          FRel.AddCel(Q.FieldByName('moes_tipocad').AsString);
          FRel.AddCel(Q.FieldByName('mova_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('mova_tipo_codigo').AsInteger,'C','N'));
          FRel.AddCel(  Q.FieldByName('clie_nome').AsString );

          FRel.AddCel(Q1.FieldByName('movd_esto_codigo').AsString);
          FRel.AddCel(Q1.FieldByName('esto_descricao').AsString);
          FRel.AddCel(Q1.FieldByName('movd_pecas').Asstring);
          FRel.AddCel(Q1.FieldByName('movd_pesocarcaca').Asstring);
          FRel.AddCel(Q1.FieldByName('movd_pesobalanca').Asstring);

          Q1.Next;

        end;
        FGeral.FechaQuery(Q1);
        Q.Next;
      end;

    Sistema.EndProcess('');
    FRel.Video;
    Q.close;
    Freeandnil(Q);

    FRelFinan_Carregados;     // 25

  end;
end;

// 02.10.18
procedure FRelFinan_ImpostosRetidosNFServicos;        // 26
//////////////////////////////////////////////////////////////
var statusvalidos,titulo,sqlorder,sqltipocod,sqltipomov,tiposmov,checar,tiposmovnao,
    sqldata,
    titconta,
    comprovante  :string;
    Q:TSqlquery;
    Soma:currency;
    conta,contax:integer;

    function ContaOK(xconta:integer):boolean;
    ///////////////////////////////////////////
    begin
         result:=true;
    end;

    procedure ImprimeComprovante;
    /////////////////////////////
    var
      WordApp: Variant;
      Documento: Olevariant;
      xcomando,nomearquivo,xtransacao,
      xnome,
      xmes,
      retcomando         :string;
      p : byte;
      ListaComandos:TStringList;



      Function Retorno(xcom:string):string;
      //////////////////////////////////////

      begin
      ///////////////////////////////
        result:='';
        if xcom='@fontepagadora' then result:=FUnidades.GetRazaoSocial(Q.FieldByName('moes_unid_codigo').AsString)
        else if xcom='@cnpjpagadora' then result:=FGeral.Formatacnpj( FUnidades.GetCnpjcpf(Q.FieldByName('moes_unid_codigo').AsString))
        else if xcom='@cnpjfornecedor' then result:=FGeral.Formatacnpj(Q.Fieldbyname('forn_cnpjcpf').AsString)
        else if xcom='@razaosocialfornecedor' then result:=Q.FieldByName('forn_razaosocial').AsString
        else if xcom='@ano'  then result:=strzero( Datetoano( Frelfinan.EdLancaf.asdate,true ),4 );

//        else if xcom='@VALORITEM'  then result:=FGeral.Formatavalor(QU.Fieldbyname('move_qtde').AsCurrency*,f_integer)
//        else if xcom='@CNPJUNIDADE' then result:=FGeral.Formatacnpj( Qu.FieldByName('unid_cnpj').asstring )
//        else if xcom='@LOCALDATA' then result:=QU.FieldByName('Unid_municipio').AsString+','+Fgeral.FormataData(Sistema.DataMvto)
//        else if xcom='@CPF' then result:=FGeral.Formatacnpjcpf( QU.FieldByName('forn_cnpjcpf').AsString)
//        else if xcom='@mes01'  then result:=strzero( Datetomes( Q.FieldByName('moes_datamvto').Asdatetime ),2 )
//        else if xcom='@mes02'  then result:=strzero( Datetomes( Q.FieldByName('moes_datamvto').Asdatetime ),2 )
//        else if xcom='@mes03'  then result:=strzero( Datetomes( Q.FieldByName('moes_datamvto').Asdatetime ),2 );
//        else if xcom='@ENDERECOFORNEC' then result:=Q.FieldByName('Forn_endereco').AsString;

      end;

 begin
 //////////////////////////////////////////////
//  {
    NomeArquivo:= ExtractFilePath(Application.ExeName) +  'comprovanteanualirpiscofisPJ.doc' ;
    if FileExists( Nomearquivo ) then begin

      WordApp:= CreateOleObject('Word.Application');
      xnome:=Q.FieldByName('forn_razaosocial').asstring;

      try

        WordApp.Visible := True;
        Documento := WordApp.Documents.Open(NomeArquivo);

        ListaComandos:=TStringList.Create;
        ListaComandos.add('@fontepagadora');
        ListaComandos.add('@cnpjpagadora');
        ListaComandos.add('@cnpjfornecedor');
        ListaComandos.add('@razaosocialfornecedor');
        ListaComandos.add('@ano');
//        ListaComandos.add('@VALORITEM');


        ListaComandos.add('@NOME');
        ListaComandos.add('@CPF');
        ListaComandos.add('@ENDERECOFORNEC');

          for p:=0 to ListaComandos.count-1 do begin

                xcomando:=ListaComandos[p];
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := Retorno(xcomando) );

          end;

        p:=1;
        while not Q.Eof do begin

          if q.FieldByName('moes_valorpis').Ascurrency>0 then begin

                xcomando:='@mes'+strzero(p,2);
                retcomando:=strzero( Datetomes( Q.FieldByName('moes_datamvto').Asdatetime ),2 );
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );

                xcomando:='@codigoret'+strzero(p,2);
                retcomando:='5952 - Pis';
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );

                xcomando:='@valorretido'+strzero(p,2);
                retcomando:=FGeral.Formatavalor(  Q.fieldbyname('moes_valorpis').ascurrency,F_cr );
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );

                xcomando:='@valorpago'+strzero(p,2);
                retcomando:=FGeral.Formatavalor( Q.fieldbyname('moes_vlrtotal').ascurrency,f_cr);
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );
                inc(p);

          end;
          if q.FieldByName('moes_valorir').Ascurrency>0 then begin

                xcomando:='@mes'+strzero(p,2);
                retcomando:=strzero( Datetomes( Q.FieldByName('moes_datamvto').Asdatetime ),2 );
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );

                xcomando:='@codigoret'+strzero(p,2);
                retcomando:='1708 - IR';
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );

                xcomando:='@valorretido'+strzero(p,2);
                retcomando:=FGeral.Formatavalor(  Q.fieldbyname('moes_valorir').ascurrency,F_cr );
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );

                xcomando:='@valorpago'+strzero(p,2);
                retcomando:=FGeral.Formatavalor( Q.fieldbyname('moes_vlrtotal').ascurrency,f_cr);
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );
                inc(p);

          end;

          if q.FieldByName('moes_valorcofins').Ascurrency>0 then begin

                xcomando:='@mes'+strzero(p,2);
                retcomando:=strzero( Datetomes( Q.FieldByName('moes_datamvto').Asdatetime ),2 );
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );

                xcomando:='@codigoret'+strzero(p,2);
                retcomando:='5952 - Cofins';
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );

                xcomando:='@valorretido'+strzero(p,2);
                retcomando:=FGeral.Formatavalor(  Q.fieldbyname('moes_valorcofins').ascurrency,F_cr );
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );

                xcomando:='@valorpago'+strzero(p,2);
                retcomando:=FGeral.Formatavalor( Q.fieldbyname('moes_vlrtotal').ascurrency,f_cr);
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );
                inc(p);

          end;

          if q.FieldByName('moes_valorcsl').Ascurrency>0 then begin

                xcomando:='@mes'+strzero(p,2);
                retcomando:=strzero( Datetomes( Q.FieldByName('moes_datamvto').Asdatetime ),2 );
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );

                xcomando:='@codigoret'+strzero(p,2);
                retcomando:='5952 - CSLL';
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );

                xcomando:='@valorretido'+strzero(p,2);
                retcomando:=FGeral.Formatavalor(  Q.fieldbyname('moes_valorcsl').ascurrency,F_cr );
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );

                xcomando:='@valorpago'+strzero(p,2);
                retcomando:=FGeral.Formatavalor( Q.fieldbyname('moes_vlrtotal').ascurrency,f_cr);
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := retcomando );
                inc(p);
          end;

          Q.Next;
          inc( p );

        end;

// 'limpa' as linhas q não tiverem sido usadas
        ListaComandos.add('@mes01');
        ListaComandos.add('@mes02');
        ListaComandos.add('@mes03');
        ListaComandos.add('@mes04');
        ListaComandos.add('@mes05');
        ListaComandos.add('@mes06');
        ListaComandos.add('@mes07');
        ListaComandos.add('@mes08');
        ListaComandos.add('@mes09');
        ListaComandos.add('@mes10');
        ListaComandos.add('@mes11');
        ListaComandos.add('@mes12');
        ListaComandos.add('@mes13');
        ListaComandos.add('@mes14');
        ListaComandos.add('@mes15');
        ListaComandos.add('@mes16');
        ListaComandos.add('@codigoret01');
        ListaComandos.add('@codigoret02');
        ListaComandos.add('@codigoret03');
        ListaComandos.add('@codigoret04');
        ListaComandos.add('@codigoret05');
        ListaComandos.add('@codigoret06');
        ListaComandos.add('@codigoret07');
        ListaComandos.add('@codigoret08');
        ListaComandos.add('@codigoret09');
        ListaComandos.add('@codigoret10');
        ListaComandos.add('@codigoret11');
        ListaComandos.add('@codigoret12');
        ListaComandos.add('@codigoret13');
        ListaComandos.add('@codigoret14');
        ListaComandos.add('@codigoret15');
        ListaComandos.add('@codigoret16');
        ListaComandos.add('@valorretido01');
        ListaComandos.add('@valorretido02');
        ListaComandos.add('@valorretido03');
        ListaComandos.add('@valorretido04');
        ListaComandos.add('@valorretido05');
        ListaComandos.add('@valorretido06');
        ListaComandos.add('@valorretido07');
        ListaComandos.add('@valorretido08');
        ListaComandos.add('@valorretido09');
        ListaComandos.add('@valorretido10');
        ListaComandos.add('@valorretido11');
        ListaComandos.add('@valorretido12');
        ListaComandos.add('@valorretido13');
        ListaComandos.add('@valorretido14');
        ListaComandos.add('@valorretido15');
        ListaComandos.add('@valorretido16');

        ListaComandos.add('@valorpago01');
        ListaComandos.add('@valorpago02');
        ListaComandos.add('@valorpago03');
        ListaComandos.add('@valorpago04');
        ListaComandos.add('@valorpago05');
        ListaComandos.add('@valorpago06');
        ListaComandos.add('@valorpago07');
        ListaComandos.add('@valorpago08');
        ListaComandos.add('@valorpago09');
        ListaComandos.add('@valorpago10');
        ListaComandos.add('@valorpago11');
        ListaComandos.add('@valorpago12');
        ListaComandos.add('@valorpago13');
        ListaComandos.add('@valorpago14');
        ListaComandos.add('@valorpago15');
        ListaComandos.add('@valorpago16');


        for p:=0 to ListaComandos.count-1 do begin

                xcomando:=ListaComandos[p];
                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := '' );

         end;


        WordApp.Visible := True;

        Documento.SaveAs( ExtractFilePath( Application.ExeName ) + 'COMPR_'+xnome+'.doc');
        Documento.close;
        Documento := WordApp.Documents.Open( ExtractFilePath( Application.ExeName ) + 'COMPR_'+xnome+'.doc');

//        Documento.PrintOut(copies := 1 );
//        Documento.close;


      finally
//        WordApp.Quit;
//        DeleteFile( ExtractFilePath( Application.ExeName ) + 'CPR_'+xnome+'.docx');
      end;

    end else Avisoerro('Falta o arquivo '+NomeArquivo );

//
    end;

///////////////////////////////////// - imprimecomprovante


begin
////////////////////////////////////////////////////////////////////////////////

  with FRelFinan do begin

    if not FRelFinan_Execute(21) then Exit;

    comprovante:='N';
    if not Edcodtipo.IsEmpty then begin

       if confirma('Imprimir somente comprovante ?') then comprovante:='S';

    end;

    Sistema.BeginProcess('Gerando Relatório');
    statusvalidos:='N;D;E';   // E devido as devolucoes do regime especial
    sqlorder:=' order by moes_unid_codigo,moes_dataemissao,moes_tipo_codigo,moes_numerodoc';
    sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
    tiposmovnao:=Global.CodEntradaprocesso+';'+Global.CodEntradaAlmox+';'+Global.CodSaidaprocesso;
    if EdCodtipo.Asinteger>0 then begin
      if Edtipocad.text='R' then
        sqltipocod:=' and moes_repr_codigo='+EdCodtipo.assql
      else
        sqltipocod:=' and ( (moes_tipo_codigo='+EdCodtipo.assql+') and (moes_tipocad='+EdTipocad.Assql+') )';
    end else
      sqltipocod:='';

    tiposmov:=Global.CodPrestacaoServicosE+';'+EdTiposMov.Text;

    if trim(tiposmov)<>'' then
      sqltipomov:='and '+FGeral.GetIN('moes_tipomov',tiposmov,'C')
    else
      sqltipomov:='';
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and moes_datacont > 1';
      sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);

    if ( not EdLancai.IsEmpty ) and ( not EdLancaf.IsEmpty ) then
      sqldata:=' and moes_datamvto>='+Edlancai.AsSql+' and moes_datamvto<='+Edlancaf.AsSql
    else if ( not EdLancai.IsEmpty ) then
      sqldata:=' and moes_datamvto>='+Edlancai.AsSql
    else if ( not EdLancaf.IsEmpty ) then
      sqldata:=' and moes_datamvto<='+Edlancaf.AsSql
    else
      sqldata:='';
    titconta:='';
    if not EdPlan_conta.IsEmpty then  begin
      titconta:='Conta '+EdPlan_conta.Text+' - '+EdPlan_conta.ResultFind.fieldbyname('plan_descricao').AsString;
    end;

    titulo:='Impostos Retidos nas notas de Entradas de Serviços  de '+FGeral.FormataData(Edlancai.asdate)+' a '+FGeral.FormataData(Edlancaf.asdate)+
            ' - Tipos Impressos: '+TiposMov ;

    Q:=sqltoquery('select movesto.*,Forn_razaosocial,Forn_cnpjcpf,forn_contribuinte from movesto'+
                  ' left join confmov on ( comv_codigo=moes_comv_codigo )'+
                  ' inner join fornecedores on ( moes_tipo_codigo=forn_codigo )'+
                  ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                  sqldata+
                  ' and '+Fgeral.GetNOTIN('moes_tipomov',tiposmovnao,'C')+
                  sqlunidade+
                  sqltipocod+
                  sqldatacont+
                  sqltipomov+
                  sqlorder );


    if Q.Eof then

      Avisoerro('Nada encontrado para impressão')

    else begin

      if comprovante='S' then begin
         Imprimecomprovante;
         Sistema.EndProcess('');
         FGeral.FechaQuery(Q);
         exit;
      end;

      FRel.Init('RelImpostosRetidosNFServicos');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));
      FRel.AddTit(titconta);
      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
//      FRel.AddCol( 60,1,'D','' ,''              ,'Referência'      ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
//      FRel.AddCol( 40,0,'C','' ,''              ,'Tipo'            ,''         ,'',false);
      FRel.AddCol( 40,0,'C','' ,''              ,'MEI'            ,''         ,'',false);
      FRel.AddCol( 45,0,'N','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Razão Social'    ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Valor Nota'       ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Pis/Cofins/CSLL'   ,        ''         ,'',false);
      FRel.AddCol(070,3,'N','+',f_cr            ,'IR'              ,''         ,'',false);
      FRel.AddCol(070,3,'N','+',f_cr            ,'INSS'             ,''         ,'',false);

      while not Q.eof do begin

        if ContaOK(conta) then begin

          FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
          FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
//          FRel.AddCel(Q.FieldByName('moes_datacont').AsString);
          FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
          FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
          FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
//          FRel.AddCel(Q.FieldByName('moes_tipocad').AsString);
// 12.12.18
          if Q.FieldByName('forn_contribuinte').AsString = 'M' then
             FRel.AddCel('S')
          else
             FRel.AddCel('');

          FRel.AddCel(Q.FieldByName('moes_tipo_codigo').AsString);
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'R'));
          FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
          soma:=( q.FieldByName('moes_valorpis').Ascurrency+
                Q.FieldByName('moes_valorcofins').Ascurrency+
                Q.FieldByName('moes_valorcsl').Ascurrency );
          FRel.AddCel( floattostr( soma ) );
          FRel.AddCel(Q.FieldByName('moes_valorir').Asstring);
          FRel.AddCel(Q.FieldByName('moes_valorinss').Asstring);

        end;

        Q.Next;

      end;

      FRel.Video;
    end;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

    FRelFinan_ImpostosRetidosNFServicos;

  end;

end;



//////////////////////////////////////////////////////////////////////
// 22.10.2012 - Vivan
function TFRelFinan.BuscaCodigoUsuario(xtransacao: String): integer;
//////////////////////////////////////////////////////////////////////
var Qb:TSqlquery;

begin
   Qb:=sqltoquery('select moes_usua_codigo from movesto where moes_transacao='+Stringtosql(xtransacao));
   if not Qb.eof then
     result:=Qb.fieldbyname('moes_usua_codigo').asinteger
   else
     result:=0;
   FGeral.FechaQuery(Qb);
end;




function TFRelFinan.GetEquipamento(xtransacao: string): string;
////////////////////////////////////////////////////////////////
var Qx:TSqlquery;
    xoperacao:string;
begin

  Qx:=sqltoquery('select move_remessas from movestoque where move_transacao='+Stringtosql(Xtransacao));
  result:='';
  if not Qx.eof then begin
     xoperacao:=Qx.fieldbyname('move_remessas').Asstring;
     if trim(xoperacao)<>'' then result:=copy( xoperacao,pos(';',xoperacao)+1,4 );
// 02.07.19
     if length(trim(result))<>4 then result:=strzero( strtointdef(result,0) ,4);

  end;
  FGeral.FechaQuery(Qx);

end;

// 14.06.2022
function TFRelFinan.GetTransEquipamentoBP(xnumerodcto,xunidade,xrp: string ; xtipo_codigo,xplan_conta:integer): string;
/////////////////////////////////////////////////////////////////////////////////////////////////
var Qy:TSqlquery;
    sqlconta:string;
begin

   sqlconta := ' and pend_plan_conta = '+IntToStr(xplan_conta);
   if xplan_conta = 0 then sqlconta := '';

   Qy:=SqlToQuery('select pend_transacao from pendencias where pend_status = ''K'''+
                  ' and pend_numerodcto = '+Stringtosql(xnumerodcto)+
                  ' and pend_tipo_codigo = '+IntToStr(xtipo_codigo)+
                  ' and pend_rp = '+StringToSql(xrp)+
                  ' and pend_unid_codigo = '+Stringtosql(xunidade)+
                  sqlconta );
   if not Qy.eof then result:=Qy.FieldByName('pend_transacao').AsString
   else result:='xy';
   Qy.close;
   Qy.free;

end;

// 27.09.2021 - A2z
function TFRelFinan.GetEquipamentos(xtransacao,codequi: string): boolean;
////////////////////////////////////////////////////////////////
var Qx    :TSqlquery;
    xoperacao,
    xop,
    remessas   :string;

begin

  Qx:=sqltoquery('select move_equi_codigo,move_remessas from movestoque where move_transacao='+Stringtosql(Xtransacao));
  result:=false;
  xoperacao:='';
  while not Qx.eof do  begin

     if trim(Qx.fieldbyname('move_equi_codigo').AsString) <> '' then
            xoperacao := xoperacao + Qx.fieldbyname('move_equi_codigo').AsString + ';';
     remessas := Qx.fieldbyname('move_remessas').asstring;
     QX.Next;

  end;
  FGeral.FechaQuery(Qx);
  if Ansipos( codequi, xoperacao ) > 0 then

     result := true

  else begin

     Qx:=sqltoquery('select move_equi_codigo,move_remessas from movestoque where move_transacao='+Stringtosql(Xtransacao));
     xoperacao := Qx.fieldbyname('move_remessas').asstring;
     if trim(xoperacao) <> '' then xop := copy( xoperacao,Ansipos(';',xoperacao)+1,4 )
                              else xop := '';

     if length(trim(xop))<>4 then

        xop := strzero( strtointdef(xop,0) ,4);

     if  xop <> '0000' then begin

        if codequi = xop then

           result := true

        else

           result := false;

     end else result := false;

     FGeral.FechaQuery(Qx);

  end;

end;


// 15.07.19
procedure  FRelFinan_PorSetor;   // 27
/////////////////////////////////////////
var Q             : TSqlquery;
    statusvalidos,
    sqlorder,
    sqltipocod,
    tiposmov,
    tiposvenda,
    tiposdev,
    sqltipomov,
    sqlsetor,
    titsetores,
    titulo,
    titequipamento        : string;
    Lista,
    ListaSetores          : TStringlist;
    porsetor              : currency;
    p                     : integer;

begin

  with FRelFinan do begin

    if not FRelFinan_Execute(27) then Exit;
    Sistema.BeginProcess('Gerando Relatório');
    statusvalidos:='N;E;D';
    sqlorder:=' order by moes_unid_codigo,moes_dataemissao,moes_numerodoc';
    sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
    if EdCodtipo.Asinteger>0 then begin
      if Edtipocad.text='R' then
        sqltipocod:=' and moes_repr_codigo='+EdCodtipo.assql
      else if Edtipocad.text='S' then
        sqltipocod:=' and '+FGeral.Getin('moes_repr_codigo',FRepresentantes.GetCodigosRepres(EdCodtipo.asinteger),'N')
      else
        sqltipocod:=' and ( (moes_tipo_codigo='+EdCodtipo.assql+') and (moes_tipocad='+EdTipocad.Assql+') )';
    end else
      sqltipocod:='';
    if EdTiposmov.isempty then begin
      tiposmov:=Global.TiposEntrada+';'+Global.TiposSaida;
      Tiposvenda:=Global.TiposRelVenda;
      Tiposdev:=Global.TiposRelDevVenda;
    end else begin
      tiposmov:=EdTiposmov.text;
      tiposvenda:=EdTiposmov.text;
      statusvalidos:='N;E;D';

    end;

    if trim(tiposmov)<>'' then
      sqltipomov:='and '+FGeral.GetIN('moes_tipomov',tiposmov,'C')
    else
      sqltipomov:='';

    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
      sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);

    sqlsetor:='';
    titsetores:='';
    if (Global.Topicos[1365]) and (not EdSeto_codigo.IsEmpty) then begin
//       sqlsetor:='and moes_Seto_codigo='+EdSeto_codigo.AsSql;
       titsetores:=' - '+FSetores.GetDescricao(Edseto_codigo.text)
    end;

    titequipamento:='';
    if not EdEqui_codigo.IsEmpty then  begin
       titequipamento:='Máquina/Veículo : '+EdEqui_codigo.Text+' - '+EdEqui_codigo.ResultFind.fieldbyname('equi_descricao').AsString;
    end;

    titulo:='Valores por Setor de '+FGeral.FormataData(Edlancai.asdate)+' a '+FGeral.FormataData(Edlancaf.asdate);
//            ' - Tipos Impressos: '+TiposVenda+';'+TiposDev ;

    Q:=sqltoquery('select * from movesto'+
                  ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                  ' and moes_datamvto>='+Edlancai.AsSql+' and moes_datamvto<='+Edlancaf.AsSql+
                  sqlunidade+
                  sqltipocod+
                  sqltipomov+
                  sqldatacont+
                  sqlsetor+
                  ' and '+FGeral.getin('moes_tipomov',tiposmov,'C')+
                  sqlorder );

    if Q.Eof then

      Avisoerro('Nada encontrado para impressão')

    else begin

      FRel.Init('RelNotasPorSetor');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text)+titsetores);
      FRel.AddTit(titequipamento);
      FRel.AddCol( 55,2,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      FRel.AddCol( 55,2,'C','' ,''              ,'Mes/ano'         ,''         ,'',false);
      FRel.AddCol( 55,2,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
      FRel.AddCol( 120,1,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
//      FRel.AddCol( 80,0,'C','' ,''              ,'Forma Pagto'     ,''         ,'',false);
//      FRel.AddCol( 90,0,'C','' ,''              ,'Portador'        ,''         ,'',false);
      FRel.AddCol( 60,0,'C','' ,''              ,'Tipo'            ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Setor'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Descrição'        ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Entradas'     ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Saidas'     ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',f_cr            ,'Líquido'     ,''         ,'',false);

{
// 06.01.14 - Patoterra
      if ( global.topicos[1367] ) then
        FRel.AddCol(180,1,'C','' ,''              ,'Equipamento'          ,''         ,'',False);
// 10.12.14 - Casa Nova - Cuiaba
      if ( global.topicos[1380] ) then
        FRel.AddCol(100,1,'C','' ,''              ,'Nome Obra'          ,''         ,'',False);
}

      while not Q.eof do begin

        if (Q.fieldbyname('moes_seto_codigo').asstring='9999') then begin

           Lista:=TStringList.Create;
           strtolista(Lista,Q.fieldbyname('moes_remessas').asstring,'|',true);

           for p:=0 to Lista.count-1 do begin

              ListaSetores:=TStringlist.create;
              strtolista(ListaSetores,Lista[p],';',true);

              if ListaSetores.count>=2 then begin

                if ( (Global.Topicos[1365]) and (EdSeto_codigo.IsEmpty) )
                   or
                   (  EdSeto_codigo.text=ListaSetores[0]  )
                  then begin

                  FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
                  FRel.AddCel( FormatDateTime('mm/yyyy',Q.FieldByName('moes_dataemissao').AsDateTime) );
                  FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
                  FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
                  FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FConfMovimento.GetDescricao(Q.fieldbyname('moes_comv_codigo').asinteger));

        //          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('moes_fpgt_codigo').AsString));
        //          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('moes_port_codigo').AsString));

                  FRel.AddCel(Q.FieldByName('moes_tipocad').AsString);
                  FRel.AddCel(Q.FieldByName('moes_tipo_codigo').AsString);
                  FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'N'));
                  porsetor:=Texttovalor(ListaSetores[1]);
                  FRel.AddCel( ListaSetores[0] );
                  FRel.AddCel( FSetores.GetDescricao(ListaSetores[0]));
                  porsetor:=Texttovalor(ListaSetores[1]);
                  if Ansipos( Q.FieldByName('moes_tipomov').AsString,Global.TiposEntrada ) > 0 then begin
                     FRel.AddCel(valortosql(porsetor));
                     FRel.AddCel('');
                     FRel.AddCel(valortosql(porsetor*(-1) )) ;
                  end else  begin
                     FRel.AddCel('');
                     FRel.AddCel(valortosql(porsetor));
                     FRel.AddCel(valortosql(porsetor));
                  end;

//                  if p=0  then
//                     FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring)
//                  else
//                     FRel.AddCel('');
//                  FGeral.PulalinhaRel( FRel.GCol.ColCount-3 );

                end;

              end;
              ListaSetores.Free;

           end;
           Lista.Free;

        end else begin

          if ( (Global.Topicos[1365]) and (EdSeto_codigo.IsEmpty) )
             or
             (  EdSeto_codigo.text=Q.FieldByName('moes_seto_codigo').AsString  )
            then begin

            FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
            FRel.AddCel( FormatDateTime('mm/yyyy',Q.FieldByName('moes_dataemissao').AsDateTime) );
            FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
            FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
            FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FConfMovimento.GetDescricao(Q.fieldbyname('moes_comv_codigo').asinteger));

  //          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('moes_fpgt_codigo').AsString));
  //          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('moes_port_codigo').AsString));

            FRel.AddCel(Q.FieldByName('moes_tipocad').AsString);
            FRel.AddCel(Q.FieldByName('moes_tipo_codigo').AsString);
            FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moes_tipo_codigo').AsInteger,Q.FieldByName('moes_tipocad').AsString,'N'));
            FRel.AddCel(Q.FieldByName('moes_seto_codigo').AsString);
            FRel.AddCel(FSetores.GetDescricao(Q.FieldByName('moes_seto_codigo').AsString));
            if Ansipos( Q.FieldByName('moes_tipomov').AsString,Global.TiposEntrada ) > 0 then begin
              FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
              FRel.AddCel('');
              FRel.AddCel( Valortosql(Q.FieldByName('moes_vlrtotal').AsCurrency*(-1)) );
            end else begin
              FRel.AddCel('');
              FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
              FRel.AddCel(Q.FieldByName('moes_vlrtotal').Asstring);
            end;

          end;

//          if ( global.topicos[1367] ) then
//            FRel.AddCel(FEquipamentos.GetDescricao(GetEquipamento(Q.FieldByName('moes_transacao').AsString)));

        end;

        Q.Next;

      end;

      FRel.Video;

    end;

    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

    FRelFinan_PorSetor;     // 27

  end;

end;

// 16.08.19
////////////{

procedure  FRelFinan_InformeIRProdutor;   // 28
///////////////////////////////////////////////////
type TConsumo=record
    produto,descricao,referencia:string;
    mesano01,mesano02,mesano03,mesano04,mesano05,mesano06,mesano07,mesano08,mesano09,mesano10,mesano11,mesano12:string;
    valor01,valor02,valor03,valor04,valor05,valor06,valor07,valor08,valor09,valor10,valor11,valor12:currency;
    qtde01,qtde02,qtde03,qtde04,qtde05,qtde06,qtde07,qtde08,qtde09,qtde10,qtde11,qtde12:currency;
end;


var PConsumo     :^TConsumo;
    Lista,
    ListaS      :TList;
    sqlinicio,sqltermino,sqlstatus,
    devolucoes,
    sqlcodtipo,
    sqltipomovto,
    linha,
    contascpr,
    cliecodigos,
    sqlclientes   :string;
    i,
    col                     :integer;
    Q,
    Qc,
    QClie,
    QBx             :TSqlquery;
    tvalor01,tvalor02,tvalor03,tvalor04,tvalor05,tvalor06,
    tvalor07,tvalor08,tvalor09,tvalor10,tvalor11,tvalor12,
    tfunrural01,tfunrural02,tfunrural03,tfunrural04,tfunrural05,tfunrural06,
    tfunrural07,tfunrural08,tfunrural09,tfunrural10,tfunrural11,tfunrural12,
    totfunrural,
    totnota,
    funrural,
    perfunrural,
    totnotasaida     :currency;



///////////// Entradas
    procedure AtualizaLista;
    ///////////////////////////
    var p:integer;
        achou:boolean;

        procedure ConfiguraMesano;
        /////////////////////////////
        var data:TDatetime;
        begin

          data:=TExttodate( strzero(Datetodia(FRelFinan.EdLancai.asdate),2)+strzero(Datetomes(FRelFinan.EdLancai.asdate),2)+Strzero(Datetoano(FRelFinan.EdLancai.asdate,true),4) );
          PConsumo.mesano01:=strzero(Datetomes(FRelFinan.EdLancai.asdate),2)+'/'+Strzero(Datetoano(FRelFinan.EdLancai.asdate,true),4);
          PConsumo.mesano02:='';PConsumo.mesano03:='';PConsumo.mesano04:='';PConsumo.mesano05:='';PConsumo.mesano06:='';
          PConsumo.mesano07:='';PConsumo.mesano08:='';PConsumo.mesano09:='';PConsumo.mesano10:='';PConsumo.mesano11:='';
          PConsumo.mesano12:='';
          PConsumo.valor01:=0;PConsumo.valor02:=0;PConsumo.valor03:=0;PConsumo.valor04:=0;PConsumo.valor05:=0;PConsumo.valor06:=0;
          PConsumo.valor07:=0;PConsumo.valor08:=0;PConsumo.valor09:=0;PConsumo.valor10:=0;PConsumo.valor11:=0;PConsumo.valor12:=0;
          PConsumo.qtde01:=0;PConsumo.qtde02:=0;PConsumo.qtde03:=0;PConsumo.qtde04:=0;PConsumo.qtde05:=0;PConsumo.qtde06:=0;
          PConsumo.qtde07:=0;PConsumo.qtde08:=0;PConsumo.qtde09:=0;PConsumo.qtde10:=0;PConsumo.qtde11:=0;PConsumo.qtde12:=0;

          data:=DateToDateMesPos(data,1);
//          PConsumo.valor01:=0;
          while data<=FRelFinan.EdLancaf.asdate do begin

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
           unitario:=Q.fieldbyname('totalitem').ascurrency;

//          funrural:=Q.fieldbyname('moes_funrural').ascurrency;
          funrural:= unitario * (perfunrural/100);

            if PConsumo.mesano01=mesano then begin

              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
//                PConsumo.valor01:=PConsumo.valor01-unitario;
//                PConsumo.qtde01:=PConsumo.qtde01-unitario;
              end else begin
                PConsumo.valor01:=PConsumo.valor01 + funrural;
                PConsumo.qtde01:=PConsumo.qtde01+unitario;
              end;

            end;

            if PConsumo.mesano02=mesano then begin

              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
//                PConsumo.valor02:=PConsumo.valor02-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde02:=PConsumo.qtde02-unitario;
              end else begin
//                PConsumo.valor02:=PConsumo.valor02+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.valor02:=PConsumo.valor02 + funrural;
                PConsumo.qtde02:=PConsumo.qtde02+unitario;
              end;

            end;

            if PConsumo.mesano03=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
//                PConsumo.valor03:=PConsumo.valor03-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde03:=PConsumo.qtde03-unitario;
              end else begin
//                PConsumo.valor03:=PConsumo.valor03+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.valor03:=PConsumo.valor03 + funrural;
                PConsumo.qtde03:=PConsumo.qtde03+unitario;
              end;
            end;

            if PConsumo.mesano04=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
//                PConsumo.valor04:=PConsumo.valor04-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde04:=PConsumo.qtde04-unitario;
              end else begin
//                PConsumo.valor04:=PConsumo.valor04+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.valor04:=PConsumo.valor04 + funrural;
                PConsumo.qtde04:=PConsumo.qtde04+unitario;
              end;
            end;

            if PConsumo.mesano05=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
//                PConsumo.valor05:=PConsumo.valor05-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde05:=PConsumo.qtde05-unitario;
              end else begin
//                PConsumo.valor05:=PConsumo.valor05+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.valor05:=PConsumo.valor05 + funrural;
                PConsumo.qtde05:=PConsumo.qtde05+unitario;
              end;
            end;

            if PConsumo.mesano06=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
//                PConsumo.valor06:=PConsumo.valor06-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde06:=PConsumo.qtde06-unitario;
              end else begin
//                PConsumo.valor06:=PConsumo.valor06+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.valor06:=PConsumo.valor06 + funrural;
                PConsumo.qtde06:=PConsumo.qtde06+unitario;
              end;
            end;

            if PConsumo.mesano07=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
//                PConsumo.valor07:=PConsumo.valor07-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde07:=PConsumo.qtde07-unitario;
              end else begin
//                PConsumo.valor07:=PConsumo.valor07+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.valor07:=PConsumo.valor07 + funrural;
                PConsumo.qtde07:=PConsumo.qtde07+unitario;
              end;
            end;

            if PConsumo.mesano08=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
//                PConsumo.valor08:=PConsumo.valor08-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde08:=PConsumo.qtde08-unitario;
              end else begin
//                PConsumo.valor08:=PConsumo.valor08+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.valor08:=PConsumo.valor08 + funrural;
                PConsumo.qtde08:=PConsumo.qtde08+unitario;
              end;
            end;

            if PConsumo.mesano09=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
//                PConsumo.valor09:=PConsumo.valor09-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde09:=PConsumo.qtde09-unitario;
              end else begin
//                PConsumo.valor09:=PConsumo.valor09+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.valor09:=PConsumo.valor09 + funrural;
                PConsumo.qtde09:=PConsumo.qtde09+unitario;
              end;
            end;

            if PConsumo.mesano10=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
//                PConsumo.valor10:=PConsumo.valor10-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde10:=PConsumo.qtde10-unitario;
              end else begin
//                PConsumo.valor10:=PConsumo.valor10+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.valor10:=PConsumo.valor10 + funrural;
                PConsumo.qtde10:=PConsumo.qtde10+unitario;
              end;
            end;

            if PConsumo.mesano11=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
//                PConsumo.valor11:=PConsumo.valor11-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde11:=PConsumo.qtde11-unitario;
              end else begin
//                PConsumo.valor11:=PConsumo.valor11+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.valor11:=PConsumo.valor11 + funrural;
                PConsumo.qtde11:=PConsumo.qtde11+unitario;
              end;
            end;

            if PConsumo.mesano12=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
//                PConsumo.valor12:=PConsumo.valor12-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde12:=PConsumo.qtde12-unitario;
              end else begin
//                PConsumo.valor12:=PConsumo.valor12+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.valor12:=PConsumo.valor12 + funrural;
                PConsumo.qtde12:=PConsumo.qtde12+unitario;
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
{
        QClie:=sqltoquery('select clie_tipo,clie_aliinsspro from clientes where clie_codigo = '+
                             inttostr(Q.FieldByName('moes_tipo_codigo').AsInteger) );
        if QClie.FieldByName('clie_tipo').asstring='J' then
            perfunrural:=FGeral.Getconfig1asfloat('perfunruraljur')
        else if QClie.FieldByName('clie_tipo').asstring='F' then
            perfunrural:=FGeral.Getconfig1asfloat('perfunruralfis');
        if QClie.FieldByName('clie_aliinsspro').Ascurrency=99 then
            perfunrural:=0
        else if QClie.FieldByName('clie_aliinsspro').Ascurrency>0 then
            perfunrural:=QClie.FieldByName('clie_aliinsspro').Ascurrency;
        FGeral.FechaQuery( Qclie );
}
      if (Q.FieldByName('moes_vlrtotal').AsCurrency>0) then
            perfunrural:=(Q.FieldByName('moes_funrural').AsCurrency/Q.FieldByName('moes_vlrtotal').AsCurrency)*100;

      if not achou then begin

        New(PConsumo);
        PConsumo.produto:=Q.FieldByName('move_esto_codigo').asstring;
        PConsumo.descricao:='';
        PConsumo.referencia:='';
        ConfiguraMesano;
        AtualizaDadosMesano;
        Lista.add(Pconsumo);

      end else begin

        AtualizaDadosMesano;

      end;

    end;


///////////// Saidas
    procedure AtualizaListaS;
    ///////////////////////////
    var p:integer;
        achou:boolean;

        procedure ConfiguraMesano;
        /////////////////////////////
        var data:TDatetime;
        begin

          data:=TExttodate( strzero(Datetodia(FRelFinan.EdLancai.asdate),2)+strzero(Datetomes(FRelFinan.EdLancai.asdate),2)+Strzero(Datetoano(FRelFinan.EdLancai.asdate,true),4) );
          PConsumo.mesano01:=strzero(Datetomes(FRelFinan.EdLancai.asdate),2)+'/'+Strzero(Datetoano(FRelFinan.EdLancai.asdate,true),4);
          PConsumo.mesano02:='';PConsumo.mesano03:='';PConsumo.mesano04:='';PConsumo.mesano05:='';PConsumo.mesano06:='';
          PConsumo.mesano07:='';PConsumo.mesano08:='';PConsumo.mesano09:='';PConsumo.mesano10:='';PConsumo.mesano11:='';
          PConsumo.mesano12:='';
          PConsumo.valor01:=0;PConsumo.valor02:=0;PConsumo.valor03:=0;PConsumo.valor04:=0;PConsumo.valor05:=0;PConsumo.valor06:=0;
          PConsumo.valor07:=0;PConsumo.valor08:=0;PConsumo.valor09:=0;PConsumo.valor10:=0;PConsumo.valor11:=0;PConsumo.valor12:=0;
          PConsumo.qtde01:=0;PConsumo.qtde02:=0;PConsumo.qtde03:=0;PConsumo.qtde04:=0;PConsumo.qtde05:=0;PConsumo.qtde06:=0;
          PConsumo.qtde07:=0;PConsumo.qtde08:=0;PConsumo.qtde09:=0;PConsumo.qtde10:=0;PConsumo.qtde11:=0;PConsumo.qtde12:=0;
          data:=DateToDateMesPos(data,1);
//          PConsumo.valor01:=0;
          while data<=FRelFinan.EdLancaf.asdate do begin

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
           unitario:=Q.fieldbyname('totalitem').ascurrency;

            if PConsumo.mesano01=mesano then begin

              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor01:=PConsumo.valor01-unitario;
//                PConsumo.qtde01:=PConsumo.qtde01-unitario;
              end else begin
                PConsumo.valor01:=PConsumo.valor01+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde01:=PConsumo.qtde01+unitario;
              end;

            end;

            if PConsumo.mesano02=mesano then begin

              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor02:=PConsumo.valor02-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde02:=PConsumo.qtde02-unitario;
              end else begin
                PConsumo.valor02:=PConsumo.valor02+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde02:=PConsumo.qtde02+unitario;
              end;

            end;

            if PConsumo.mesano03=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor03:=PConsumo.valor03-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde03:=PConsumo.qtde03-unitario;
              end else begin
                PConsumo.valor03:=PConsumo.valor03+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde03:=PConsumo.qtde03+unitario;
              end;
            end;

            if PConsumo.mesano04=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor04:=PConsumo.valor04-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde04:=PConsumo.qtde04-unitario;
              end else begin
                PConsumo.valor04:=PConsumo.valor04+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde04:=PConsumo.qtde04+unitario;
              end;
            end;

            if PConsumo.mesano05=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor05:=PConsumo.valor05-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde05:=PConsumo.qtde05-unitario;
              end else begin
                PConsumo.valor05:=PConsumo.valor05+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde05:=PConsumo.qtde05+unitario;
              end;
            end;

            if PConsumo.mesano06=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor06:=PConsumo.valor06-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde06:=PConsumo.qtde06-unitario;
              end else begin
                PConsumo.valor06:=PConsumo.valor06+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde06:=PConsumo.qtde06+unitario;
              end;
            end;

            if PConsumo.mesano07=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor07:=PConsumo.valor07-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
 //               PConsumo.qtde07:=PConsumo.qtde07-unitario;
              end else begin
                PConsumo.valor07:=PConsumo.valor07+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde07:=PConsumo.qtde07+unitario;
              end;
            end;

            if PConsumo.mesano08=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor08:=PConsumo.valor08-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde08:=PConsumo.qtde08-unitario;
              end else begin
                PConsumo.valor08:=PConsumo.valor08+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde08:=PConsumo.qtde08+unitario;
              end;
            end;

            if PConsumo.mesano09=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor09:=PConsumo.valor09-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
 //               PConsumo.qtde09:=PConsumo.qtde09-unitario;
              end else begin
                PConsumo.valor09:=PConsumo.valor09+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde09:=PConsumo.qtde09+unitario;
              end;
            end;

            if PConsumo.mesano10=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor10:=PConsumo.valor10-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde10:=PConsumo.qtde10-unitario;
              end else begin
                PConsumo.valor10:=PConsumo.valor10+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde10:=PConsumo.qtde10+unitario;
              end;
            end;

            if PConsumo.mesano11=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor11:=PConsumo.valor11-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde11:=PConsumo.qtde11-unitario;
              end else begin
                PConsumo.valor11:=PConsumo.valor11+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde11:=PConsumo.qtde11+unitario;
              end;
            end;

            if PConsumo.mesano12=mesano then begin
              if pos(Q.fieldbyname('moes_tipomov').asstring,Devolucoes)>0 then begin
                PConsumo.valor12:=PConsumo.valor12-(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
//                PConsumo.qtde12:=PConsumo.qtde12-unitario;
              end else begin
                PConsumo.valor12:=PConsumo.valor12+(unitario*Q.fieldbyname('moes_vlrtotal').ascurrency);
                PConsumo.qtde12:=PConsumo.qtde12+unitario;
              end;
            end;

        end;

    begin
//////////////////////////////////////////////////////////////////////
      achou:=false;
      for p:=0 to ListaS.Count-1 do begin

        PConsumo:=ListaS[p];
        if PConsumo.produto=Q.FieldByName('move_esto_codigo').asstring then begin
          achou:=true;
          break
        end;

      end;

      if not achou then begin

        New(PConsumo);
        PConsumo.produto:=Q.FieldByName('move_esto_codigo').asstring;
        PConsumo.descricao:='';
        PConsumo.referencia:='';
        ConfiguraMesano;
        AtualizaDadosMesano;
        ListaS.add(Pconsumo);

      end else begin

        AtualizaDadosMesano;

      end;

    end;
///////////////////////  saidas


    function EContaCpr( xconta:integer ):boolean;
    ///////////////////////////////////////////////
    begin

      if AnsiPos( strzero(xconta,5),contascpr ) >0 then result:=true else result:=false;

    end;


    function EstaValendo:boolean;
    ////////////////////////////////////// /////
    begin

      if Q.Fieldbyname('pend_datamvto').asdatetime>FRElfinan.EdLancaf.Asdate then
        result:=false
// 02.07.20 - nao considerar as CPR
      else if EcontaCPR( Q.FieldByName('pend_plan_conta').AsInteger ) then

               result:=false

    // 02.07.20 - nao considerar as CPR  pelo tipo de movimento
      else if Q.FieldByName('pend_tipomov').AsString = Global.CodCedulaProdutoRural  then

               result:=false

      else if ( pos(Q.Fieldbyname('pend_status').asstring,'B;K')>0 ) and  (Q.Fieldbyname('pend_databaixa').asdatetime>FRElfinan.EdLancaf.Asdate ) and (Q.Fieldbyname('pend_databaixa').asdatetime>1) then
        result:=true

      else if ( pos(Q.Fieldbyname('pend_status').asstring,'B;K')>0 ) and  (Q.Fieldbyname('pend_databaixa').asdatetime<=FRElfinan.EdLancaf.Asdate ) and (Q.Fieldbyname('pend_databaixa').asdatetime>1) then begin
        result:=false;
      end else if (Q.Fieldbyname('pend_status').asstring='B' ) and (Q.Fieldbyname('pend_databaixa').asdatetime<1 ) then
        result:=false
      else if (Q.Fieldbyname('pend_status').asstring='K' ) and (Q.Fieldbyname('pend_databaixa').asdatetime<1 ) then
        result:=false
      else
        result:=true;
    end;

    function EstaValendoCPR:boolean;
    ////////////////////////////////////// /////
    begin

      if Q.Fieldbyname('pend_datamvto').asdatetime>FRElfinan.EdLancaf.Asdate then
        result:=false
      else if ( pos(Q.Fieldbyname('pend_status').asstring,'B;K')>0 ) and  (Q.Fieldbyname('pend_databaixa').asdatetime>FRElfinan.EdLancaf.Asdate ) and (Q.Fieldbyname('pend_databaixa').asdatetime>1) then
        result:=true
      else if ( pos(Q.Fieldbyname('pend_status').asstring,'B;K')>0 ) and  (Q.Fieldbyname('pend_databaixa').asdatetime<=FRElfinan.EdLancaf.Asdate ) and (Q.Fieldbyname('pend_databaixa').asdatetime>1) then begin
        result:=false;
      end else if (Q.Fieldbyname('pend_status').asstring='B' ) and (Q.Fieldbyname('pend_databaixa').asdatetime<1 ) then
        result:=false
      else if (Q.Fieldbyname('pend_status').asstring='K' ) and (Q.Fieldbyname('pend_databaixa').asdatetime<1 ) then
        result:=false
      else
        result:=true;
    end;

begin
///////////////////////////////////////////////////////////

  with FRelFinan do begin

    if not FRelFinan_Execute(28) then Exit;

    if (EdCodtipo.AsInteger=0) or ( EdTipocad.isempty ) then begin

        Avisoerro('Obrigatório informar o codigo do produtor');
        exit;

    end;

    Sistema.BeginProcess('Pesquisando');
    sqlinicio:=' and moes_datamvto>='+Datetosql(EdLancai.AsDate);
    if EdLancai.isempty then
       sqltermino:=''
    else
       sqltermino:=' and moes_datamvto<='+Datetosql(EdLancaf.Asdate);
    if EdLancai.isempty then
       sqlinicio:=''
    else
       sqlinicio:=sqlinicio;

    if EdCodtipo.isempty then

      sqlcodtipo:=''

    else begin

      sqlcodtipo:=' and moes_tipo_codigo='+EdCodtipo.assql+' and moes_tipocad = ''C''';
      if Edtipocad.text='R' then
        sqlcodtipo:=' and moes_repr_codigo='+EdCodtipo.assql+' and moes_tipocad = ''R''';

      QClie := sqltoquery('select clie_codigofinan from clientes where clie_codigo = '+EdCodtipo.AsSql);
      cliecodigos:=strzero( EdCodtipo.asinteger,7)+';';


      if (  not Qclie.Eof ) and ( Edtipocad.text='C' ) then begin

         if QClie.fieldbyname('clie_codigofinan').asinteger>0 then begin

            Qclie.Close;
            QClie := sqltoquery('select clie_codigo from clientes where clie_codigofinan = '+EdCodtipo.AsSql);
            cliecodigos:=strzero( QClie.fieldbyname('clie_codigofinan').asinteger,7)+';';

            while not Qclie.Eof do begin

               cliecodigos:=cliecodigos + strzero( QClie.FieldByName('clie_codigo').AsInteger,7)+';';
               Qclie.Next;

            end;

         end else begin

            Qclie.Close;
            QClie := sqltoquery('select clie_codigo from clientes where clie_codigofinan = '+EdCodtipo.AsSql);
//            cliecodigos:=strzero( QClie.fieldbyname('clie_codigofinan').asinteger,7)+';';
            cliecodigos:=strzero( EdCodtipo.asinteger,7)+';';

            while not Qclie.Eof do begin

               cliecodigos:=cliecodigos + strzero( QClie.FieldByName('clie_codigo').AsInteger,7)+';';
               Qclie.Next;

            end;

         end;

// 16.12.19 - clientes q não tem o pagamento centralizado...
         if not EdCodigoscli.IsEmpty then
            cliecodigos := cliecodigos + EdCodigoscli.text;

         sqlcodtipo:=' and '+FgEral.GetIN('moes_tipo_codigo',cliecodigos,'N')+
                     ' and moes_tipocad = ''C''';

      end;

      FGeral.FechaQuery(Qclie);

    end;

    devolucoes:=Global.TiposRelDevVenda;
//    sqltipomovto:=' and '+FGEral.GetIN('moes_tipomov',Global.TiposRelVenda+';'+Devolucoes,'C');
    sqltipomovto:=' and '+FGEral.GetIN('moes_tipomov',Global.TiposRelCompra,'C');
    sqlstatus:=FGeral.Getin('moes_status','N,D,E','C');

    Q:=sqltoquery('select  move_qtde*move_venda as totalitem,move_esto_codigo,moes_transacao,moes_funrural,'+
                     ' moes_tipo_codigo,moes_vlrtotal,moes_datamvto,moes_tipomov from movestoque '+
                     ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                     ' where '+sqlstatus+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+sqlcodtipo+
                     sqltipomovto+
                     ' order by moes_datamvto' );

// 25.06.20 deixado imprimir mesmo sem movimento de notas devido as cotas capital
{
    if Q.eof then begin

      Avisoerro('Nada encontrado para impressão');
      Sistema.EndProcess('');
      Q.close;
      Freeandnil(Q);
      exit;

    end;
}

    Lista:=TList.create;
    Sistema.BeginProcess('Somando entradas no periodo');
    while not Q.eof do begin

      AtualizaLista;
      Q.Next;

    end;

// busca as vendas
///////////////////////
    sqltipomovto:=' and '+FGEral.GetIN('moes_tipomov',Global.TiposRelVenda,'C');
    sqlstatus:=FGeral.Getin('moes_status','N,D,E','C');

    FGeral.FechaQuery(Q);

    Q:=sqltoquery('select  move_qtde*move_venda as totalitem,move_esto_codigo,'+
                     ' moes_tipo_codigo,moes_vlrtotal,moes_datamvto,moes_tipomov from movestoque '+
                     ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                     ' where '+sqlstatus+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+sqlcodtipo+
                     sqltipomovto+
                     ' order by moes_datamvto' );
    ListaS:=TList.create;
    Sistema.BeginProcess('Somando saidas no periodo');

    while not Q.eof do begin

      AtualizaListaS;
      Q.Next;

    end;

{
    if Lista.count=0 then begin

      Avisoerro('Não encontrado compras no período');
      Sistema.EndProcess('');
      Q.close;
      Freeandnil(Q);
      exit;

    end;
    }

    FGEral.FechaQuery(Q);
    Sistema.BeginProcess('Gerando Relatório');

    FTextRel.Init(60,nil,nil,0,true);

    FTextRel.AddTitulo('Informação para Declaração de Imposto de Renda -  Página: [NumPg]',false,false,false);
    FTextRel.AddTitulo('Unidade : '+FGeral.Gettitulounidades(EdUnid_codigo.text),false,false,true);
    FTextRel.AddTitulo('Periodo : '+formatdatetime('dd/mm/yy',FRelFinan.EdLancai.AsDate)+' a '+formatdatetime('dd/mm/yy',EdLancaf.AsDate),false,false,true);
    FTextRel.Addtitulo('Produtor: '+EdCodtipo.Text+' - '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.AsInteger,'C','N')+' -  Codigos Consolidados:'+cliecodigos,false,false,true );

// 25.06.20
    if Lista.Count>0 then begin

      PConsumo:=Lista[0];
      if PConsumo.mesano07 <> '' then

         FTextRel.Addtitulo(replicate('-',227),false,false,true )

      else

         FTextRel.Addtitulo(replicate('-',132),false,false,true );


      linha:='Produto'+space(4)+strspace('Descrição',37)+PConsumo.mesano01;
      if trim(PConsumo.mesano02)<>'' then linha:=linha+spacestr(PConsumo.mesano02,14);
      if trim(PConsumo.mesano03)<>'' then linha:=linha+spacestr(PConsumo.mesano03,14);
      if trim(PConsumo.mesano04)<>'' then linha:=linha+spacestr(PConsumo.mesano04,14);
      if trim(PConsumo.mesano05)<>'' then linha:=linha+spacestr(PConsumo.mesano05,14);
      if trim(PConsumo.mesano06)<>'' then linha:=linha+spacestr(PConsumo.mesano06,14);
      if trim(PConsumo.mesano07)<>'' then linha:=linha+spacestr(PConsumo.mesano07,14);
      if trim(PConsumo.mesano08)<>'' then linha:=linha+spacestr(PConsumo.mesano08,14);
      if trim(PConsumo.mesano09)<>'' then linha:=linha+spacestr(PConsumo.mesano09,14);
      if trim(PConsumo.mesano10)<>'' then linha:=linha+spacestr(PConsumo.mesano10,14);
      if trim(PConsumo.mesano11)<>'' then linha:=linha+spacestr(PConsumo.mesano11,14);
      if trim(PConsumo.mesano12)<>'' then linha:=linha+spacestr(PConsumo.mesano12,14);

      FTextRel.AddLinha(linha,false,false,true );

      if PConsumo.mesano07 <> '' then

         FTextRel.AddLinha(replicate('-',227),false,false,true )

      else

         FTextRel.AddLinha(replicate('-',132),false,false,true );

    end;

    tvalor01:=0;tvalor02:=0;tvalor03:=0;tvalor04:=0;tvalor05:=0;tvalor06:=0;
    tvalor07:=0;tvalor08:=0;tvalor09:=0;tvalor10:=0;tvalor11:=0;tvalor12:=0;


    for i:=0 to LIsta.count-1 do begin


      Pconsumo:=Lista[i];
//      FRel.AddCel(PConsumo.produto);
//      FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(strtoint(PConsumo.produto),'C','N') );

      linha:=FGeral.Formatavalor(PConsumo.qtde01,f_crp);
      tvalor01 := tvalor01  + PConsumo.qtde01;
      tvalor02 := tvalor02  + PConsumo.qtde02;
      tvalor03 := tvalor03  + PConsumo.qtde03;
      tvalor04 := tvalor04  + PConsumo.qtde04;
      tvalor05 := tvalor05  + PConsumo.qtde05;
      tvalor06 := tvalor06  + PConsumo.qtde06;
      tvalor07 := tvalor07  + PConsumo.qtde07;
      tvalor08 := tvalor08  + PConsumo.qtde08;
      tvalor09 := tvalor09  + PConsumo.qtde09;
      tvalor10 := tvalor10  + PConsumo.qtde10;
      tvalor11 := tvalor11  + PConsumo.qtde11;
      tvalor12 := tvalor12  + PConsumo.qtde12;
// soma dos funrural...
      tfunrural01 := tfunrural01  + PConsumo.valor01;
      tfunrural02 := tfunrural02  + PConsumo.valor02;
      tfunrural03 := tfunrural03  + PConsumo.valor03;
      tfunrural04 := tfunrural04  + PConsumo.valor04;
      tfunrural05 := tfunrural05  + PConsumo.valor05;
      tfunrural06 := tfunrural06  + PConsumo.valor06;
      tfunrural07 := tfunrural07  + PConsumo.valor07;
      tfunrural08 := tfunrural08  + PConsumo.valor08;
      tfunrural09 := tfunrural09  + PConsumo.valor09;
      tfunrural10 := tfunrural10  + PConsumo.valor10;
      tfunrural11 := tfunrural11  + PConsumo.valor11;
      tfunrural12 := tfunrural12  + PConsumo.valor12;

      if trim(PConsumo.mesano02)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde02,f_crp);
      if trim(PConsumo.mesano03)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde03,f_crp);
      if trim(PConsumo.mesano04)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde04,f_crp);
      if trim(PConsumo.mesano05)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde05,f_crp);
      if trim(PConsumo.mesano06)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde06,f_crp);
      if trim(PConsumo.mesano07)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde07,f_crp);
      if trim(PConsumo.mesano08)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde08,f_crp);
      if trim(PConsumo.mesano09)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde09,f_crp);
      if trim(PConsumo.mesano10)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde10,f_crp);
      if trim(PConsumo.mesano11)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde11,f_crp);
      if trim(PConsumo.mesano12)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde12,f_crp);

      FTExtRel.AddLinha( strspace(PConsumo.produto,10)+' '+
                         strspace(FEstoque.GetDescricao(PConsumo.produto),30)+' '+
                         linha+
                         FGeral.Formatavalor(PConsumo.qtde12+PConsumo.qtde11+PConsumo.qtde10+PConsumo.qtde09+PConsumo.qtde08+
                         PConsumo.qtde07+PConsumo.qtde06+PConsumo.qtde05+PConsumo.qtde04+PConsumo.qtde03+PConsumo.qtde02+PConsumo.qtde01,f_crp),
                         false,false,true);

    end;

// Saidas

    if ListaS.Count > 0 then begin

        if trim(PConsumo.mesano07)<>'' then

           FTextRel.AddLInha(replicate('-',227),false,false,true )

        else

           FTextRel.AddLInha(replicate('-',132),false,false,true );


// linha de totais
/////////////////////

      linha:=FGeral.Formatavalor(tvalor01,f_crp);
      if trim(PConsumo.mesano02)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor02,f_crp);
      if trim(PConsumo.mesano03)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor03,f_crp);
      if trim(PConsumo.mesano04)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor04,f_crp);
      if trim(PConsumo.mesano05)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor05,f_crp);
      if trim(PConsumo.mesano06)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor06,f_crp);
      if trim(PConsumo.mesano07)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor07,f_crp);
      if trim(PConsumo.mesano08)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor08,f_crp);
      if trim(PConsumo.mesano09)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor09,f_crp);
      if trim(PConsumo.mesano10)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor10,f_crp);
      if trim(PConsumo.mesano11)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor11,f_crp);
      if trim(PConsumo.mesano12)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor12,f_crp);

      FTExtRel.AddLinha( strspace('Entradas',10)+' '+
                         strspace('',30)+' '+
                         linha+
                         FGeral.Formatavalor(tvalor12+tvalor11+tvalor10+tvalor09+tvalor08+
                         tvalor07+tvalor06+tvalor05+tvalor04+tvalor03+tvalor02+tvalor01,f_crp),
                         false,false,true );

// totais do inss ( funrural )
////////////////////////////////
      linha:=FGeral.Formatavalor(tfunrural01,f_crp);
      if trim(PConsumo.mesano02)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tfunrural02,f_crp);
      if trim(PConsumo.mesano03)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tfunrural03,f_crp);
      if trim(PConsumo.mesano04)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tfunrural04,f_crp);
      if trim(PConsumo.mesano05)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tfunrural05,f_crp);
      if trim(PConsumo.mesano06)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tfunrural06,f_crp);
      if trim(PConsumo.mesano07)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tfunrural07,f_crp);
      if trim(PConsumo.mesano08)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tfunrural08,f_crp);
      if trim(PConsumo.mesano09)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tfunrural09,f_crp);
      if trim(PConsumo.mesano10)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tfunrural10,f_crp);
      if trim(PConsumo.mesano11)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tfunrural11,f_crp);
      if trim(PConsumo.mesano12)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tfunrural12,f_crp);

      FTExtRel.AddLinha( strspace('INSS',10)+' '+
                         strspace('',30)+' '+
                         linha+
                         FGeral.Formatavalor(tfunrural12+tfunrural11+tfunrural10+tfunrural09+tfunrural08+
                         tfunrural07+tfunrural06+tfunrural05+tfunrural04+tfunrural03+tfunrural02+tfunrural01,f_crp),
                         false,false,true );

     if trim(PConsumo.mesano07)<>'' then

           FTextRel.AddLInha(replicate('-',227),false,false,true )

        else

           FTextRel.AddLInha(replicate('-',132),false,false,true );

    end;

    tvalor01:=0;tvalor02:=0;tvalor03:=0;tvalor04:=0;tvalor05:=0;tvalor06:=0;
    tvalor07:=0;tvalor08:=0;tvalor09:=0;tvalor10:=0;tvalor11:=0;tvalor12:=0;

    for i:=0 to LIstaS.count-1 do begin

      Pconsumo:=ListaS[i];
      linha:=FGeral.Formatavalor(PConsumo.qtde01,f_crp);
      tvalor01 := tvalor01  + PConsumo.qtde01;
      tvalor02 := tvalor02  + PConsumo.qtde02;
      tvalor03 := tvalor03  + PConsumo.qtde03;
      tvalor04 := tvalor04  + PConsumo.qtde04;
      tvalor05 := tvalor05  + PConsumo.qtde05;
      tvalor06 := tvalor06  + PConsumo.qtde06;
      tvalor07 := tvalor07  + PConsumo.qtde07;
      tvalor08 := tvalor08  + PConsumo.qtde08;
      tvalor09 := tvalor09  + PConsumo.qtde09;
      tvalor10 := tvalor10  + PConsumo.qtde10;
      tvalor11 := tvalor11  + PConsumo.qtde11;
      tvalor12 := tvalor12  + PConsumo.qtde12;
      if trim(PConsumo.mesano02)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde02,f_crp);
      if trim(PConsumo.mesano03)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde03,f_crp);
      if trim(PConsumo.mesano04)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde04,f_crp);
      if trim(PConsumo.mesano05)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde05,f_crp);
      if trim(PConsumo.mesano06)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde06,f_crp);
      if trim(PConsumo.mesano07)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde07,f_crp);
      if trim(PConsumo.mesano08)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde08,f_crp);
      if trim(PConsumo.mesano09)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde09,f_crp);
      if trim(PConsumo.mesano10)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde10,f_crp);
      if trim(PConsumo.mesano11)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde11,f_crp);
      if trim(PConsumo.mesano12)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(PConsumo.qtde12,f_crp);

      FTExtRel.AddLinha( strspace(PConsumo.produto,10)+' '+
                         strspace(FEstoque.GetDescricao(PConsumo.produto),30)+' '+
                         linha+
                         FGeral.Formatavalor(PConsumo.qtde12+PConsumo.qtde11+PConsumo.qtde10+PConsumo.qtde09+PConsumo.qtde08+
                         PConsumo.qtde07+PConsumo.qtde06+PConsumo.qtde05+PConsumo.qtde04+PConsumo.qtde03+PConsumo.qtde02+PConsumo.qtde01,f_crp),
                         false,false,true);



    end;

// linha de totais
/////////////////////
// 25.06.20
    if Lista.Count > 0 then begin

      linha:=FGeral.Formatavalor(tvalor01,f_crp);
      if trim(PConsumo.mesano02)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor02,f_crp);
      if trim(PConsumo.mesano03)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor03,f_crp);
      if trim(PConsumo.mesano04)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor04,f_crp);
      if trim(PConsumo.mesano05)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor05,f_crp);
      if trim(PConsumo.mesano06)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor06,f_crp);
      if trim(PConsumo.mesano07)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor07,f_crp);
      if trim(PConsumo.mesano08)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor08,f_crp);
      if trim(PConsumo.mesano09)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor09,f_crp);
      if trim(PConsumo.mesano10)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor10,f_crp);
      if trim(PConsumo.mesano11)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor11,f_crp);
      if trim(PConsumo.mesano12)<>'' then
         linha:=linha+' '+FGeral.Formatavalor(tvalor12,f_crp);

     if trim(PConsumo.mesano07)<>'' then

           FTextRel.AddLInha(replicate('-',227),false,false,true )

        else

           FTextRel.AddLInha(replicate('-',132),false,false,true );

      FTExtRel.AddLinha( strspace('Saidas',10)+' '+
                         strspace('',30)+' '+
                         linha+
                         FGeral.Formatavalor(tvalor12+tvalor11+tvalor10+tvalor09+tvalor08+
                         tvalor07+tvalor06+tvalor05+tvalor04+tvalor03+tvalor02+tvalor01,f_crp),
                         false,false,true );

     if trim(PConsumo.mesano07)<>'' then

           FTextRel.AddLInha(replicate('-',227),false,false,true )

        else

           FTextRel.AddLInha(replicate('-',132),false,false,true );

    end;

// saldo a receber e a pagar na data final
////////////////////////////////////////////

    QC:=sqltoquery('select plan_conta from plano where plan_tipo = ''P''' );
    contascpr:='';
    while not Qc.Eof do begin
       contascpr:=contascpr + strzero( QC.FieldByName('plan_conta').AsInteger,5) + ';';
       Qc.Next;
    end;
    Qc.Close;

    Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status','N;B;K','C')+
                  ' and pend_RP='+stringtosql('P')+
                  ' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')+
                  sqldatacont+
//                  ' and ( (pend_tipo_codigo='+EdCodtipo.assql+') and (pend_tipocad='+EdTipocad.Assql+') )'+
                  ' and '+FGeral.Getin('pend_tipo_codigo',cliecodigos,'N')+
                  ' and pend_tipocad='+EdTipocad.Assql+
                  ' order by pend_unid_codigo,pend_tipo_codigo,pend_dataemissao,pend_numerodcto');

    tvalor01:=0;
    while not Q.Eof do begin

        if EstaValendo then  tvalor01:=tvalor01+Q.FieldByName('pend_valor').AsCurrency;
        Q.Next;

    end;

    FGeral.FechaQuery(Q);

    Ftextrel.AddLinha('',false,false,true);
    Ftextrel.AddLinha('Posição financeira  a  Pagar em '+FGeral.FormataData(EdLancaf.AsDate)+
                      ' '+FGeral.Formatavalor(tvalor01,f_cr)
                      ,false,false,true  );

    Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status','N;B;K','C')+
                  ' and pend_RP='+stringtosql('R')+
                  ' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')+
                  sqldatacont+
//                  ' and ( (pend_tipo_codigo='+EdCodtipo.assql+') and (pend_tipocad='+EdTipocad.Assql+') )'+
                  ' and pend_tipocad = '+EdTipocad.Assql+
                  ' and '+FGeral.Getin('pend_tipo_codigo',cliecodigos,'N')+
                  ' order by pend_unid_codigo,pend_tipo_codigo,pend_dataemissao,pend_numerodcto');

    tvalor01:=0;
    while not Q.Eof do begin

        if EstaValendo then  tvalor01:=tvalor01+Q.FieldByName('pend_valor').AsCurrency;
        Q.Next;

    end;

    FGeral.FechaQuery(Q);

    Ftextrel.AddLinha('',false,false,true);
    Ftextrel.AddLinha('Posição financeira a Receber em '+FGeral.FormataData(EdLancaf.AsDate)+
                      ' '+FGeral.Formatavalor(tvalor01,f_cr)
                      ,false,false,true  );


// relacao de notas de entradas
////////////////////////////////////
    sqltipomovto:=' and '+FGEral.GetIN('moes_tipomov',Global.TiposRelCompra,'C');
    Q:=sqltoquery('select  * from movesto '+
                     ' where '+sqlstatus+
                     ' and '+FGeral.Getin('moes_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+sqlcodtipo+
                     sqltipomovto+
                     ' order by moes_datamvto' );

    Ftextrel.AddLinha('',false,false,true);
    Ftextrel.AddLinha('Relação de Notas de Compra'
                      ,false,false,true  );

// 25.06.20
    if Lista.Count > 0 then begin

       if trim(PConsumo.mesano07)<>'' then

             FTextRel.AddLInha(replicate('-',235),false,false,true )

          else

             FTextRel.AddLInha(replicate('-',132),false,false,true );

    end;

    FTextRel.AddLInha(strspace('Conta',5)+' '+
                      strspace('Descrição',25)+' '+
                      strspace('Nota',08)+' '+
                      strspace('Série',07)+' '+
                      strspace('TM',02)+' '+
                      strspace('Tipo de Movimento',30)+' '+
                      strspace('Data',08)+' '+
                      strspace('CFOP',10)+' '+
                      strspace('Valor NF',14)+' '+
                      strspace('Valor INSS',14)
                      ,false,false,true );

// 25.06.20
    if Lista.Count > 0 then begin

       if trim(PConsumo.mesano07)<>'' then

           FTextRel.AddLInha(replicate('-',227),false,false,true )

        else

           FTextRel.AddLInha(replicate('-',132),false,false,true );

    end;

    totfunrural:=0;
    totnota    :=0;

    while not Q.Eof do begin

        FTextRel.AddLInha( strspace(Q.FieldByName('moes_plan_codigo').AsString,5)+' '+
                           strspace(FPlano.GetDescricao(Q.FieldByName('moes_plan_codigo').AsINteger),25)+' '+
                           strspace(Q.FieldByName('moes_numerodoc').AsString,8)+' '+
                           strspace(Q.FieldByName('moes_serie').AsString,02)+space(06)+
                           strspace(Q.FieldByName('moes_tipomov').AsString,2)+' '+
                           strspace( FGeral.GetTipoMovto(  Q.FieldByName('moes_tipomov').AsString),30)+' '+
                           FGEral.FormataData( Q.FieldByName('moes_datamvto').Asdatetime)+' '+
                           strspace( Q.FieldByName('moes_natf_codigo').AsString,05)+' '+
                           strspace(FGEral.FormataValor( Q.FieldByName('moes_vlrtotal').AsCurrency,f_cr),14)+' '+
                           strspace(FGEral.FormataValor( Q.FieldByName('moes_funrural').AsCurrency,f_cr),14)
                           ,false,false,true );
        totfunrural := totfunrural + Q.FieldByName('moes_funrural').AsCurrency;
        totnota     := totnota     + Q.FieldByName('moes_vlrtotal').AsCurrency;
        Q.Next;

    end;

    FGeral.FechaQuery(Q);
    if totfunrural>0 then begin

 // 25.06.20
    if Lista.Count > 0 then begin

      if trim(PConsumo.mesano07)<>'' then

           FTextRel.AddLInha(replicate('-',227),false,false,true )

        else

           FTextRel.AddLInha(replicate('-',132),false,false,true );

    end;

       FTextRel.AddLInha( strspace(' ',097)+' '+
                           strspace(FGEral.FormataValor( totnota,f_cr),14)+' '+
                           strspace(FGEral.FormataValor( totfunrural,f_cr),14)
                           ,false,false,true );

    end;

// relacao de notas de saidas
////////////////////////////////
    sqltipomovto:=' and '+FGEral.GetIN('moes_tipomov',Global.TiposRelVenda,'C');
    Q:=sqltoquery('select  * from movesto '+
                     ' where '+sqlstatus+
                     ' and '+FGeral.Getin('moes_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+sqlcodtipo+
                     sqltipomovto+
                     ' order by moes_datamvto' );

    Ftextrel.AddLinha('',false,false,true);
    Ftextrel.AddLinha('Relação de Notas de Venda'
                      ,false,false,true  );
// 25.06.20
    if Lista.Count > 0 then begin

       if trim(PConsumo.mesano07)<>'' then

           FTextRel.AddLInha(replicate('-',227),false,false,true )

        else

           FTextRel.AddLInha(replicate('-',132),false,false,true );

    end;

    FTextRel.AddLInha(strspace('Conta',5)+' '+
                      strspace('Descrição',25)+' '+
                      strspace('Nota',08)+' '+
                      strspace('Série',07)+' '+
                      strspace('TM',02)+' '+
                      strspace('Tipo de Movimento',30)+' '+
                      strspace('Data',08)+' '+
                      strspace('CFOP',10)+' '+
                      strspace('Valor NF',14)
                      ,false,false,true );

// 25.06.20
    if Lista.Count > 0 then begin

       if trim(PConsumo.mesano07)<>'' then

           FTextRel.AddLInha(replicate('-',227),false,false,true )

        else

           FTextRel.AddLInha(replicate('-',132),false,false,true );
    end;

    totnotasaida:=0;

    while not Q.Eof do begin

        FTextRel.AddLInha( strspace(Q.FieldByName('moes_plan_codigo').AsString,5)+' '+
                           strspace(FPlano.GetDescricao(Q.FieldByName('moes_plan_codigo').AsINteger),25)+' '+
                           strspace(Q.FieldByName('moes_numerodoc').AsString,8)+' '+
                           strspace(Q.FieldByName('moes_serie').AsString,02)+space(06)+
                           strspace(Q.FieldByName('moes_tipomov').AsString,2)+' '+
                           strspace( FGeral.GetTipoMovto(  Q.FieldByName('moes_tipomov').AsString),30)+' '+
                           FGEral.FormataData( Q.FieldByName('moes_datamvto').Asdatetime)+' '+
                           strspace( Q.FieldByName('moes_natf_codigo').AsString,05)+' '+
                           strspace(FGEral.FormataValor( Q.FieldByName('moes_vlrtotal').AsCurrency,f_cr),14)
                           ,false,false,true );
        totnotasaida := totnotasaida + Q.FieldByName('moes_vlrtotal').AsCurrency;
        Q.Next;

    end;

    FGeral.FechaQuery(Q);

// 25.06.20
    if Lista.Count > 0 then begin

      if trim(PConsumo.mesano07)<>'' then

           FTextRel.AddLInha(replicate('-',227),false,false,true )

        else

           FTextRel.AddLInha(replicate('-',132),false,false,true );

    end;

  FTextRel.AddLInha( strspace(' ',097)+' '+
                           strspace(FGEral.FormataValor( totnotasaida,f_cr),14)
                           ,false,false,true );

// Relação das CPR
/////////////////////
    Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status','N;B;K','C')+
                  ' and pend_RP='+stringtosql('R')+
                  ' and pend_tipomov = '+Stringtosql(Global.CodCedulaProdutoRural)+
                  ' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')+
                  sqldatacont+
                  ' and ( (pend_tipo_codigo='+EdCodtipo.assql+') and (pend_tipocad='+EdTipocad.Assql+') )'+
                  ' order by pend_unid_codigo,pend_tipo_codigo,pend_dataemissao,pend_numerodcto');

    contascpr:='';

 // 25.06.20
    if Lista.Count > 0 then begin

      if trim(PConsumo.mesano07)<>'' then

           FTextRel.AddLInha(replicate('-',227),false,false,true )

        else

           FTextRel.AddLInha(replicate('-',132),false,false,true );

    end;

    tvalor01:=0;
    Ftextrel.AddLinha('',false,false,true);

    if not Q.Eof then  begin

       FTextRel.AddLInha(strspace('Numero',08)+' '+
                      strspace('Emissão',08)+' '+
                      strspace('Vencimento',08)+' '+
                      strspace('Baixa',08)+' '+
                      strspace('Status',01)+' '+
                      strspace('Valor NF',14)
                      ,false,false,true );
    end;

    while not Q.Eof do begin

        if EstaValendoCPR then begin


           QBx:=sqltoquery('select sum(pend_valor) as valor from pendencias where pend_status=''P'''+
//                      ' and pend_tipomov = '+Stringtosql(Global.CodCedulaProdutoRural)+
                      ' and pend_RP='+stringtosql('P')+
                      ' and pend_databaixa >= '+Datetosql(Q.fieldbyname('Pend_dataemissao').AsDatetime)+
                      ' and pend_parcela='+inttostr(Q.fieldbyname('Pend_parcela').AsInteger)+
//                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      ' and ( (pend_tipo_codigo='+EdCodtipo.assql+') and (pend_tipocad='+EdTipocad.Assql+') )'+
                      ' and pend_numerodcto='+stringtosql(Q.fieldbyname('Pend_numerodcto').AsString) );

           if QBx.FieldByName('valor').AsCurrency < Q.FieldByName('pend_valor').AsCurrency then begin

              FTextRel.AddLInha(strspace(Q.fieldbyname('Pend_numerodcto').AsString,08)+' '+
                      FGeral.FormataData(Q.fieldbyname('Pend_dataemissao').AsDatetime)+' '+
                      FGeral.FormataData(Q.fieldbyname('Pend_datavcto').AsDatetime)+' '+
                      FGeral.FormataData(Q.fieldbyname('Pend_databaixa').AsDatetime)+' '+
                      Q.fieldbyname('Pend_status').Asstring+' '+
                      FGeral.FormataValor(Q.fieldbyname('Pend_valor').AsCurrency,f_cr)
                      ,false,false,true );
              tvalor01:=tvalor01+Q.FieldByName('pend_valor').AsCurrency;

           end;

           FGeral.FechaQuery( QBx );

        end;

        Q.Next;

    end;

    FGeral.FechaQuery(Q);

    Ftextrel.AddLinha('',false,false,true);
    Ftextrel.AddLinha('Total CPR a receber em '+FGeral.FormataData(EdLancaf.AsDate)+
                      ' '+FGeral.Formatavalor(tvalor01,f_cr)
                      ,false,false,true  );

/////////////////////////////////////////////////////////////////////
// Relação das Sobras definidas em AGO - Assembleia Geral Ordinaria
/////////////////////
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
      sqldatacont:=' and movf_datacont > '+DateToSql(Global.DataMenorBanco);

    sqlclientes := ' and movf_tipo_codigo = '+EdCodtipo.assql;
    if not EdCodigoscli.isempty then

       sqlclientes := ' and '+FGeral.GEtin('movf_tipo_codigo',EdCodtipo.text+';'+EdCodigoscli.text,'N');

    if FGeral.GetConfig1AsInteger('ctasobras') > 0 then

       Q:=sqltoquery('select * from movfin'+
                  ' where '+FGeral.Getin('movf_status','N','C')+
                  ' and movf_es='+stringtosql('S')+
                  ' and movf_tipomov = '+Stringtosql(Global.CodLanCaixabancos)+
                  ' and '+FGeral.getin('movf_unid_codigo',EdUnid_codigo.text,'C')+
                  ' and movf_plan_contard = '+inttostr(FGeral.GetConfig1AsInteger('ctasobras'))+
                  sqldatacont+
                  ' and movf_datamvto >= '+Datetosql(EdLancai.AsDate)+
                  ' and movf_datamvto <= '+Datetosql(EdLancaf.AsDate)+
// 10.07.20
                  sqlclientes +
                  ' and movf_tipocad='+EdTipocad.Assql+

                  ' order by movf_unid_codigo,movf_tipo_codigo,movf_datamvto')

    else

       Q:=sqltoquery('select * from movfin where movf_datacont < '+DateToSql(Global.DataMenorBanco) );


    tvalor01:=0;
    if not Q.Eof then  begin

        Ftextrel.AddLinha('',false,false,true);

// 25.06.20
        if Lista.Count > 0 then begin

          if trim(PConsumo.mesano07)<>'' then

             FTextRel.AddLInha(replicate('-',227),false,false,true )

          else

             FTextRel.AddLInha(replicate('-',132),false,false,true );

        end;

        FTextRel.AddLInha(strspace('Data',08)+' '+
                      strspace('Histórico',50)+' '+
                      strspace('Valor',08)+' '+
                      strspace('Conta',08)+' '+
                      strspace('Descrição',30)
                      ,false,false,true );
    end;

    while not Q.Eof do begin

        FTextRel.AddLInha(FGeral.FormataData(Q.fieldbyname('movf_datamvto').AsDatetime)+' '+
                      Q.fieldbyname('movf_complemento').Asstring+space(14)+
                      FGeral.FormataValor(Q.fieldbyname('movf_valorger').AsCurrency,f_cr)+' '+
                      Q.fieldbyname('movf_plan_contard').Asstring+' '+
                      FPlano.GetDescricao( Q.fieldbyname('movf_plan_contard').AsInteger )
                      ,false,false,true );
        tvalor01:=tvalor01+Q.FieldByName('movf_valorger').AsCurrency;
        Q.Next;

    end;

    Ftextrel.AddLinha('',false,false,true);
    Ftextrel.AddLinha('Total Sobras definidas em AGO recebidas no período '+
                      '  '+FGeral.Formatavalor(tvalor01,f_cr)
                      ,false,false,true  );
    FGEral.FechaQuery(Q);

 //   FTextRel.Video('',6,'G');
 //   Sistema.EndProcess('');

 ////////////////////////////////////////////////////////////////
// Saldo de conta corrente associado
/////////////////////
   if FGeral.ConectaContax then begin

     if EdCodtipo.ResultFind.FieldByName('clie_ctaccassoc').AsInteger > 0 then begin

// 25.06.20
       if Lista.Count > 0 then begin

         if trim(PConsumo.mesano07)<>'' then

             FTextRel.AddLInha(replicate('-',227),false,false,true )

          else

             FTextRel.AddLInha(replicate('-',132),false,false,true );
       end;

//        tvalor01 := FGeral.GetSaldoInicialMovCon( EdCodtipo.ResultFind.FieldByName('clie_ctaccassoc').AsInteger,
//                                                  Global.CodigoUnidade,EdLancaf.AsDate+1   );
        tvalor01 := GetSaldos(EdCodtipo.ResultFind.FieldByName('clie_ctaccassoc').AsInteger);
        Ftextrel.AddLinha('',false,false,true);
        Ftextrel.AddLinha('Saldo Conta corrente em '+FGeral.FormataData(EdLancaf.AsDate)+
                          ' '+FGeral.Formatavalor(tvalor01,f_cr)
                          ,false,false,true  );
     end else begin

        Ftextrel.AddLinha('',false,false,true);
        Ftextrel.AddLinha('Conta corrente não configurada no cadastro',false,false,true  );

     end;

     if EdCodtipo.ResultFind.FieldByName('clie_ctaeapassoc').AsInteger > 0 then begin

// 25.06.20
       if Lista.Count > 0 then begin

          if trim(PConsumo.mesano07)<>'' then

             FTextRel.AddLInha(replicate('-',227),false,false,true )

          else

             FTextRel.AddLInha(replicate('-',132),false,false,true );

       end;

//        tvalor01 := FGeral.GetSaldoInicialMovCon( EdCodtipo.ResultFind.FieldByName('clie_ctaeapassoc').AsInteger,
//                                                  Global.CodigoUnidade,EdLancaf.AsDate+1   );
        tvalor01 := GetSaldos(EdCodtipo.ResultFind.FieldByName('clie_ctaeapassoc').AsInteger);

        Ftextrel.AddLinha('',false,false,true);
        Ftextrel.AddLinha('Saldo Conta empréstimo a pagar associado em '+FGeral.FormataData(EdLancaf.AsDate)+
                          ' '+FGeral.Formatavalor(tvalor01,f_cr)
                          ,false,false,true  );
     end else begin

        Ftextrel.AddLinha('',false,false,true);
        Ftextrel.AddLinha('Conta empréstimo a pagar associado não configurada no cadastro',false,false,true  );

     end;

     if EdCodtipo.ResultFind.FieldByName('clie_ctacotassoc').AsInteger > 0 then begin

// 25.06.20
       if Lista.Count > 0 then begin

         if trim(PConsumo.mesano07)<>'' then

             FTextRel.AddLInha(replicate('-',227),false,false,true )

          else

             FTextRel.AddLInha(replicate('-',132),false,false,true );

      end;

//        tvalor01 := FGeral.GetSaldoInicialMovCon( EdCodtipo.ResultFind.FieldByName('clie_ctacotassoc').AsInteger,
//                                                  Global.CodigoUnidade,EdLancaf.AsDate +1  );
        tvalor01 := GetSaldos( EdCodtipo.ResultFind.FieldByName('clie_ctacotassoc').AsInteger ) ;
        Ftextrel.AddLinha('',false,false,true);
        Ftextrel.AddLinha('Saldo Conta Cota parte associado em '+FGeral.FormataData(EdLancaf.AsDate)+
                          ' '+FGeral.Formatavalor(tvalor01,f_cr)
                          ,false,false,true  );
     end else begin

        Ftextrel.AddLinha('',false,false,true);
        Ftextrel.AddLinha('Conta Cota parte associado não configurada no cadastro',false,false,true  );

     end;


   end;

// 25.06.20
    FTextRel.Video('',6,'G');
    Sistema.EndProcess('');


  end; // do with...

///////////////////////  FRelFinan_InformeIRProdutor;   // 28

end;
////////////}

// 29.04.20
//////////////////////////////////////////////////////////////////////
procedure FRelFinan_CargasKM;     // 29
////////////////////////////////////////////
var Q ,
    Qt    :TSqlquery;
    statusvalidos,sqlorder,sqltipocod,sqltipomov,
    titulo   :string;
    ultimakm,
    difkm      :integer;
    difkg,
    valorkilo,
    valorkm,
    difkgnotas :currency;


    function GetPeso( xpedido:integer ; xdata:TDatetime ;xunidade:string ):currency;
    /////////////////////////////////////////////////////////////////
     var Qy,
         Qc,
         Qn   :TSqlquery;
         xp   :currency;
     begin

// primeiro acha os pedidos q formam a carga...

         Qc:=sqltoquery('select mped_numerodoc,mped_tipo_codigo from movped'+
                        ' where mped_nftrans = '+inttostr(xpedido)+
                        ' and mped_status = ''N'''+
                        ' and mped_tipomov = '+Stringtosql(global.CodPedVenda)+
                        ' and mped_datamvto >= '+Datetosql(xdata-3)+
                        ' and mped_unid_codigo = '+Stringtosql(xunidade) );

         xp:=0;

         while not Qc.Eof do begin

             xpedido :=Qc.FieldByName('mped_numerodoc').AsInteger;
{
             Qy:=sqltoquery('select movd_pesocarcaca from movabatedet'+
//                         ' inner join movabate on ( (mova_transacao=movd_transacao) and (mova_tipomov=movd_tipomov) )'+
                         ' where movd_status = ''N'''+
                         ' and movd_tipomov = '+Stringtosql('SA')+
                         ' and movd_numerodoc = '+inttostr(xpedido)+
                         ' and movd_datamvto >= '+Datetosql(xdata-3)+
                         ' and movd_unid_codigo = '+Stringtosql(xunidade) );
}
             Qy:=sqltoquery('select moes_transacao from movesto where moes_pedido = '+inttostr(xpedido)+
                        ' and moes_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                        ' and moes_status = ''N'''+
                        ' and ( (moes_chavenfe <>'''')  or  (moes_chavenfe is not null) )'+
                        ' and moes_tipo_codigo = '+Qc.FieldByName('mped_tipo_codigo').AsString );

//             while not Qy.Eof do begin

//                xp:=xp + Qy.FieldByName('movd_pesocarcaca').Ascurrency;
                Qn:= sqltoquery('select sum(move_qtde) as move_qtde from movestoque where move_transacao = '+
                                 Stringtosql(Qy.fieldbyname('moes_transacao').asstring)+
                                 ' and move_status = ''N''');
                xp:=xp + Qn.FieldByName('move_qtde').Ascurrency;
                FGeral.FechaQuery( Qn );
  //              QY.Next;

//             end;

             FGeral.FechaQuery(Qy);

             Qc.Next;

         end;

         FGeral.FechaQuery(Qc);
         result:=xp;

     end;

    function GetPesoNotas( xtran:string ; xdata:TDatetime ;xunidade:string ):currency;
    /////////////////////////////////////////////////////////////////
     var Qc,
         Qn   :TSqlquery;
         xp   :currency;

     begin


         Qc:=sqltoquery('select moes_numerodoc,moes_transacao from movesto'+
                        ' where moes_tran_codigo = '+stringtosql(xtran)+
                        ' and  moes_pedido <= 0 '+
                        ' and moes_status = ''N'''+
                        ' and moes_tipomov = '+Stringtosql(global.CodVendaDireta)+
                        ' and moes_dataemissao >= '+Datetosql(xdata-3)+
                        ' and moes_unid_codigo = '+Stringtosql(xunidade) );

         xp:=0;
         while not Qc.eof do begin

             Qn:= sqltoquery('select sum(move_qtde) as move_qtde from movestoque where move_transacao = '+
                                 Stringtosql(Qc.fieldbyname('moes_transacao').asstring)+
                                 ' and move_status = ''N''');
                xp:=xp + Qn.FieldByName('move_qtde').Ascurrency;
                FGeral.FechaQuery( Qn );

            Qc.Next;

         end;

         result := xp;

     end;



begin

  with FRelFinan do begin

    if not FRelFinan_Execute(29) then Exit;
    statusvalidos:='N';
    sqlorder:=' order by movc_unid_codigo,movc_datamvto';
    sqlunidade:=' and '+FGeral.getin('movc_unid_codigo',EdUnid_codigo.text,'C');
    if EdCodtipo.Asinteger>0 then begin
        sqltipocod:=' and movc_tran_codigo = '+stringtosql( strzero(EdCodtipo.asinteger,3) );
    end else
      sqltipocod:='';

    titulo:='Comissão de Motoristas de '+FGeral.FormataData(Edlancai.asdate)+' a '+FGeral.FormataData(Edlancaf.asdate);

    Q:=sqltoquery('select * from movcargas inner join transportadores on (tran_codigo=movc_tran_codigo)'+
                  ' where '+FGeral.GetIN('movc_status',statusvalidos,'C')+
                  ' and movc_datamvto>='+Edlancai.AsSql+' and movc_datamvto<='+Edlancaf.AsSql+
                  ' and movc_cola_codigo01 <> '''''+
                  sqlunidade+
                  sqltipocod+
                  sqlorder );
    if Q.eof then begin

      Avisoerro('Nada encontrado para impressão');
      exit;

    end;

    Sistema.BeginProcess('Gerando Relatório');

      FRel.Init('RelCargasKM');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+FGeral.TituloRelCliRepre(EdCodtipo.asinteger,EdTipocad.text));

//      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
      FRel.AddCol( 65,2,'D','' ,''              ,'Data'         ,''         ,'',false);
//      FRel.AddCol( 55,2,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Carga'      ,''         ,'',False);
      FRel.AddCol( 45,0,'C','' ,''              ,'Codigo'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Veículo'            ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Cod.Mot.'          ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome Motorista'            ,''         ,'',false);
//      FRel.AddCol( 45,0,'C','' ,''              ,'Cod.Mot.02'          ,''         ,'',false);
//      FRel.AddCol(150,0,'C','' ,''              ,'Nome Mot.02'            ,''         ,'',false);
      FRel.AddCol(080,3,'N','',''               ,'Kilometragem'          ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',''              ,'KM rodados '          ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',''              ,'Comissão KM'          ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',''              ,'Peso Rateado'       ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',''              ,'Comissão Kg'          ,''         ,'',false);
      FRel.AddCol(080,3,'N','+',''              ,'Peso Carga '       ,''         ,'',false);
      FRel.AddCol(090,3,'N','+',''              ,'Peso Notas sem Pedido'       ,''         ,'',false);

      valorkm   := FGeral.GetConfig1AsFloat( 'percomkmmot' );
      valorkilo := FGeral.GetConfig1AsFloat( 'percomkilo' );

      while not Q.eof do begin

          FRel.AddCel(Q.FieldByName('movc_datamvto').AsString);
          FRel.AddCel(Q.FieldByName('movc_numero').AsString);
          FRel.AddCel(Q.FieldByName('movc_tran_codigo').AsString);
          FRel.AddCel(  Q.FieldByName('tran_nome').AsString );
          FRel.AddCel( Q.FieldByName('movc_cola_codigo01').AsString );
          FRel.AddCel( FColaboradores.GetDescricao( Q.FieldByName('movc_cola_codigo01').AsString ) );
//          FRel.AddCel( Q.FieldByName('movc_cola_codigo02').AsString );
//          FRel.AddCel( FColaboradores.GetDescricao( Q.FieldByName('movc_cola_codigo02').AsString ) );
          FRel.AddCel( Q.FieldByName('movc_km').Asstring );
          ultimaKM := GetUltimakm( Q.FieldByName('movc_tran_codigo').Asstring,
                                   Q.FieldByName('movc_numero').AsInteger,
                                   Q.FieldByName('movc_datamvto').AsDatetime ) ;
//          difkm    := Q.FieldByName('movc_km').Asinteger - ultimakm;
// 08.06.20
          if ultimakm = 0 then

            difkm :=0

          else if Q.FieldByName('movc_km').Asinteger = 0 then

            difkm :=0

          else if ultimakm < Q.FieldByName('movc_km').Asinteger then


            difkm    :=  Q.FieldByName('movc_km').Asinteger - ultimakm

          else
            difkm    :=  ultimakm -  Q.FieldByName('movc_km').Asinteger;


          if (difkm < 0) or ( difkm>1500) then difkm := 0;

          difkg    := GetPeso( Q.FieldByName('movc_numero').AsInteger,
                               Q.FieldByName('movc_datamvto').AsDatetime,
                               Q.FieldByName('movc_unid_codigo').AsString);


          if Q.FieldByName('movc_cola_codigo02').AsString<>'' then begin
             difKM := trunc(difKM/2);
             difkg := difkg/2;
          end;
          FRel.AddCel( inttostr(difkm) );
          FRel.AddCel( currtostr(difkm*valorkm) );
          FRel.AddCel( FGeral.Formatavalor( difkg ,f_cr ) );
          FRel.AddCel( currtostr(difkg*valorkilo) );
          FRel.AddCel( FGeral.Formatavalor( difkg*2 ,f_cr ) );
          FRel.AddCel( '' );

        if Q.FieldByName('movc_cola_codigo02').AsString<>'' then begin

          FRel.AddCel(Q.FieldByName('movc_datamvto').AsString);
          FRel.AddCel(Q.FieldByName('movc_numero').AsString);
          FRel.AddCel(Q.FieldByName('movc_tran_codigo').AsString);
          FRel.AddCel(  Q.FieldByName('tran_nome').AsString );
          FRel.AddCel( Q.FieldByName('movc_cola_codigo02').AsString );
          FRel.AddCel( FColaboradores.GetDescricao( Q.FieldByName('movc_cola_codigo02').AsString ) );
          FRel.AddCel( Q.FieldByName('movc_km').Asstring );
          FRel.AddCel( inttostr(difkm) );
          FRel.AddCel( currtostr(difkm*valorkm) );
          FRel.AddCel( FGeral.Formatavalor( difkg ,f_cr ) );
          FRel.AddCel( currtostr(difkg*valorkilo) );
          FRel.AddCel( '' );
          FRel.AddCel( '' );

        end;

        Q.Next;

      end;
 // buscar notas q foram feitas sem pedidos...
    FGeral.FechaQuery( Q );

    Qt := sqltoquery('select distinct moes_tran_codigo from movesto'+
                        ' where moes_status = ''N'''+
                        ' and  moes_pedido <= 0 '+
                        ' and moes_tipomov = '+Stringtosql(global.CodVendaDireta)+
                        ' and moes_dataemissao>='+Edlancai.AsSql+
                        ' and moes_dataemissao<='+Edlancaf.AsSql+
                        ' and moes_tipomov = '+Stringtosql(Global.codVendaDireta)+
                        ' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C') );

    while not Qt.eof do begin



       Q := sqltoquery('select moes_tran_codigo,moes_dataemissao,moes_unid_codigo,tran_nome,tran_cola_codigo from movesto'+
                        ' inner join transportadores on (tran_codigo = moes_tran_codigo )'+
                        ' where moes_status = ''N'''+
                        ' and tran_cola_codigo <> '''' '+
                        ' and moes_tran_codigo = '+Stringtosql(Qt.fieldbyname('moes_tran_codigo').asstring)+
                        ' and  moes_pedido <= 0 '+
                        ' and moes_tipomov = '+Stringtosql(global.CodVendaDireta)+
                        ' and moes_dataemissao>='+Edlancai.AsSql+
                        ' and moes_dataemissao<='+Edlancaf.AsSql+
                        ' and moes_tipomov = '+Stringtosql(Global.codVendaDireta)+
                        ' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C') );

       if not Q.eof then begin

          difkgnotas  := GetPesoNotas( Q.FieldByName('moes_tran_codigo').AsString,
                                       Q.FieldByName('moes_dataemissao').AsDatetime,
                                       Q.FieldByName('moes_unid_codigo').AsString);
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( Q.FieldByName('moes_tran_codigo').AsString);
          FRel.AddCel( Q.FieldByName('tran_nome').AsString );
          FRel.AddCel( Q.FieldByName('tran_cola_codigo').AsString );
          FRel.AddCel( FColaboradores.GetDescricao( Q.FieldByName('tran_cola_codigo').AsString ) );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( FGeral.Formatavalor( difkgnotas ,f_cr ) );
          FGeral.FechaQuery( Q );

       end;

       Qt.Next;

    end;

    Sistema.EndProcess('');
    FRel.Video;
    FGeral.FechaQuery( Qt );
    FRelFinan_CargasKM;     // 29

  end;

end;

procedure FRelFinan_PosicaoApro;  // 30
//////////////////////////////////////////////
var   q             : TSqlquery;
      titulo,
      statusvalidos,
      sqlorder      : string;
      saldo         : currency;

begin

  with FRelFinan do begin

    if not FRelFinan_Execute(30) then Exit;

    statusvalidos:='N';
    titulo       :='Posição Financeira de Apropriações em '+FGeral.FormataData(EdDtposicao.asdate);
    sqlorder     :=' order by apro_plan_codigo,apro_data';
    sqlunidade   :=' and '+FGeral.getin('apro_unid_codigo',EdUnid_codigo.text,'C');
//    sqldatalan   :=' and apro_data>='+EdLancai.AsSql+' and apro_data<='+EdLancaf.AsSql;
    sqldatalan   :=' and apro_data>='+Datetosql(DateToPrimeiroDiaMes(EdDtposicao.asdate))+' and apro_data<='+EdDtPosicao.AsSql;

    Q:=sqltoquery('select apropriacoes.*,moes_vlrtotal from apropriacoes'+
                  ' inner join movesto on ( apro_transacao=moes_transacao and apro_tipomov=moes_tipomov )'+
                  ' where '+FGeral.Getin('apro_status',statusvalidos,'C')+
                  ' and apro_data <= '+EdDtPosicao.assql+
                  sqldatalan+
                  sqlunidade+
                  sqlorder );
    if Q.Eof then begin

      Avisoerro('Nada encontrado para impressão');
      exit;

    end;

    Sistema.BeginProcess('Gerando Relatório');

      FRel.Init('RelApropriacoes');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));

      FRel.AddCol( 70,0,'C','' ,''              ,'Transação'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
      FRel.AddCol( 060,0,'N','' ,''              ,'Conta      '     ,''         ,'',false);
      FRel.AddCol( 180,0,'C','' ,''              ,'Descrição'       ,''         ,'',false);
//      FRel.AddCol( 40,0,'C','' ,''              ,'Tipo'            ,''         ,'',false);
//      FRel.AddCol( 45,0,'C','' ,''              ,'Codigo'          ,''         ,'',false);
//      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      FRel.AddCol( 40,0,'C','' ,''              ,'Tipo Mov'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Total Nota'         ,''         ,'',False);
      FRel.AddCol( 50,2,'N','' ,''              ,'Quantas'              ,''         ,'',False);
      FRel.AddCol( 30,2,'N','' ,''              ,'Vez'            ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Valor Mensal'         ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Valor Apropriado'         ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,f_cr           ,'A Apropriar'         ,''         ,'',False);

      while not Q.eof do begin

          FRel.AddCel(Q.FieldByName('apro_transacao').AsString);
          FRel.AddCel(Q.FieldByName('apro_unid_codigo').AsString);
          FRel.AddCel(Q.FieldByName('apro_data').AsString);
          FRel.AddCel(Q.FieldByName('apro_numerodoc').AsString);
          FRel.AddCel(Q.FieldByName('apro_plan_codigo').AsString);
          FRel.AddCel(FPlano.GetDescricao(Q.FieldByName('apro_plan_codigo').AsInteger));
//          FRel.AddCel(Q.FieldByName('pend_tipocad').AsString);
//          FRel.AddCel(Q.FieldByName('pend_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'R'));
          FRel.AddCel(Q.FieldByName('apro_tipomov').AsString);
          FRel.AddCel(Q.FieldByName('moes_vlrtotal').AsString);
          FRel.AddCel(Q.FieldByName('apro_nvezes').AsString);
          FRel.AddCel(Q.FieldByName('apro_vez').AsString);
          FRel.AddCel(Q.FieldByName('apro_valor').AsString);
          FRel.AddCel( FGeral.FormataValor( Q.FieldByName('apro_valor').Ascurrency * Q.FieldByName('apro_vez').Ascurrency, f_cr ) );
          saldo := Q.FieldByName('moes_vlrtotal').AsCurrency -
                   (Q.FieldByName('apro_valor').Ascurrency * Q.FieldByName('apro_vez').Ascurrency  );
          FRel.AddCel( FGeral.FormataValor( saldo, f_cr ) );

          q.Next;

      end;

    FRel.Video;

    Sistema.endprocess('');
    FGeral.FechaQuery( q );

  end;

  FRelFinan_PosicaoApro;

end;

end.


