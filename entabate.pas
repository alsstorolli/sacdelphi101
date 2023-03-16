unit entabate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SqlDtg, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr, Async32, ACBrBase, ACBrBAL, AcbrDevice,
  ACBrDeviceSerial;

type
  TFEntradaabate = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bIncluiritem: TSQLBtn;
    bExcluiritem: TSQLBtn;
    bCancelaritem: TSQLBtn;
    bimp: TSQLBtn;
    balterar: TSQLBtn;
    bexclusao: TSQLBtn;
    EdCaoc_codigo: TSQLEd;
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
    EdDtabate: TSQLEd;
    EdTotalRemessa: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdDtMovimento: TSQLEd;
    Edtotalcarcaca: TSQLEd;
    EdClie_fone: TSQLEd;
    Edvencimento: TSQLEd;
    EdClie_endres: TSQLEd;
    EdClie_bairrores: TSQLEd;
    EdMuniRes_Nome: TSQLEd;
    EdClie_cepres: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdPesovivo: TSQLEd;
    Edvlrarroba: TSQLEd;
    EdBrinco: TSQLEd;
    EdIdade: TSQLEd;
    Edpesocarcaca: TSQLEd;
    Edobs: TSQLEd;
    EdTotalpesovivo: TSQLEd;
    EdDtcarrega: TSQLEd;
    EdPerc: TSQLEd;
    brateio: TSQLBtn;
    blebalanca: TSQLBtn;
    blebalanca2: TSQLBtn;
    lpeso: TLabel;
    Edmovd_pecas: TSQLEd;
    EdFpgt_codigo: TSQLEd;
    EdFpgt_descricao: TSQLEd;
    EdTran_codigo: TSQLEd;
    EdTran_nome: TSQLEd;
    brelcarga: TSQLBtn;
    EdRepr_codigo: TSQLEd;
    EdPerccomissao: TSQLEd;
    EdbonusComissao: TSQLEd;
    Edbaia: TSQLEd;
    EdSeto_codigo: TSQLEd;
    Edseto_descricao: TSQLEd;
    Edvalorgta: TSQLEd;
    ACBrBAL1: TACBrBAL;
    ACBrBAL2: TACBrBAL;
    batubrincos: TSQLBtn;
    bbaixa: TSQLBtn;
    Edtotalpesado: TSQLEd;
    bajustapesos: TSQLBtn;
    EdBaiageral: TSQLEd;
    Edmova_ganhopeso: TSQLEd;
    EdMoes_cola_codigo: TSQLEd;
    SetEdCOLA_NOME: TSQLEd;
    Edmova_kmi: TSQLEd;
    Edmova_kmf: TSQLEd;
    brateiopesovivo: TSQLBtn;
    procedure EdclienteValidate(Sender: TObject);
    procedure bIncluiritemClick(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdobsExitEdit(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure EdpesocarcacaValidate(Sender: TObject);
    procedure EdDtMovimentoExitEdit(Sender: TObject);
    procedure EdBrincoValidate(Sender: TObject);
    procedure bExcluiritemClick(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure bimpClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure bexclusaoClick(Sender: TObject);
    procedure balterarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure brateioClick(Sender: TObject);
    procedure EdDtabateValidate(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure blebalancaClick(Sender: TObject);
    procedure SerialRxChar(Sender: TObject; Count: Integer);
    procedure EdPesovivoValidate(Sender: TObject);
    procedure EdvlrarrobaEnter(Sender: TObject);
    procedure blebalanca2Click(Sender: TObject);
    procedure Serial2RxChar(Sender: TObject; Count: Integer);
    procedure brelcargaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdRepr_codigoValidate(Sender: TObject);
    procedure EdbonusComissaoValidate(Sender: TObject);
    procedure ACBrBAL2LePeso(Peso: Double; Resposta: AnsiString);
    procedure ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
    procedure batubrincosClick(Sender: TObject);
    procedure bbaixaClick(Sender: TObject);
    procedure EdbaiaValidate(Sender: TObject);
    procedure bajustapesosClick(Sender: TObject);
    procedure EdBrincoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtotalpesadoChange(Sender: TObject);
    procedure EdBaiageralValidate(Sender: TObject);
    procedure brateiopesovivoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LimpaEditsItens;
    procedure EditstoGrid(xseq:integer=0);
    function ProcuraGrid(Coluna: integer;  Pesquisa: string ; Colunatam:integer=0 ; tam:integer=0 ; colunacor:integer=0 ; cor:integer=0 ;
                         colunacopa:integer=0 ; copa:integer=0 ): integer;
    procedure CalculaTotal;
    procedure GravaMestre;
    procedure GravaItens;
    procedure GravaItem;
    procedure DesativaEdits;
    procedure AtivaEdits;
    procedure Ativabotoes;
    procedure Desativabotoes;
    procedure Campostoedits(Q:TSqlquery);
    procedure Campostogrid(Q:TSqlquery);
    function EntradaFaturada(Numero:integer):boolean;
    procedure SetaEditEntradasAbate(Ed:TSqlEd);
    function AbrirPorta:boolean;
    function AbrirPorta2:boolean;
    function EstaCodigosNaoVenda(produto:string):boolean;
    procedure ConfiguraBalanca;
    procedure ConfiguraBalancas;

  end;

var
  FEntradaabate: TFEntradaabate;
  OP,Tipomov,Transacao,OPbotao,qedit:string;
  QEstoque,QBusca,QbuscaE:TSqlquery;
  Temgrid,SerialAberta:boolean;
  notagerada,divarrobakilo,seq:integer;
  TipoEntradaAbate,TipoSaidaAbate,TipoFazenda,xUnidadessemGTA,TipoPesagem,
  TipoLote:string;
  DescPeso:currency;

procedure EntradaAbate_Execute (Opx:string ; Numero:integer=0 ; xTipomov:string='EA');


implementation

uses Geral , Sqlsis , munic, Sqlfun, grupos, Estoque, TextRel, Arquiv,
  RelGerenciais, nfsaida, Usuarios, Unidades;

{$R *.dfm}
                                                             // 04.06.08
procedure EntradaAbate_Execute(Opx:string ; Numero:integer=0 ; xTipomov:string='EA');
//////////////////////////////////////////////////////////////////////////////////////////////

   procedure  SetaItemsEstoque;
   //////////////////////////////
   var Lista:TStringlist;
       s:string;
       p:integer;
   begin
     FEntradaabate.EdProduto.Items.clear;
     Lista:=TStringlist.create;
     s:=FGeral.Getconfig1asstring('Produtosnaovenda');
     if (trim(s)<>'') and ( pos(Tipomov,TipoEntradaAbate+';'+TipoFazenda)>0) then begin
       FEntradaabate.EdProduto.ShowForm:='';
       strtolista(Lista,s,';',true);
       for p:=0 to Lista.count-1 do begin
          if trim(Lista[p])<>'' then
            FEntradaabate.EdProduto.Items.add(strspace(Lista[p],15)+' - '+FEstoque.getdescricao(Lista[p]));
       end;
       FEntradaabate.EdProduto.ItemsLength:=15;
     end else begin
       FEntradaabate.EdProduto.ShowForm:='FEstoque';
       FEntradaabate.EdProduto.ItemsLength:=0;
     end;
   end;

   // 08.05.19
   procedure SetaBrincos;
   /////////////////////
   var Qx    :TSqlquery;
       xdata :TDatetime;
   begin

      xdata := Sistema.Hoje-090;
      Qx:=sqltoquery('select movd_brinco from movabatedet'+
                     ' where movd_unid_codigo = '+FEntradaAbate.EdUnid_codigo.assql+
                     ' and '+FGeral.GetIN('movd_tipomov',TipoEntradaAbate+';'+TipoFazenda,'C')+
                     ' and movd_datamvto >= '+Datetosql(xdata)+
                     ' and ( (movd_abatido <> ''S'') or (movd_abatido is null) )'+
                     ' and movd_status <> ''C''');
      FEntradaAbate.EdBrinco.Items.Clear ;

      while not Qx.Eof do begin

         if Qx.FieldByName('movd_brinco').AsString<>'' then
            if FEntradaAbate.EdBrinco.Items.IndexOf( Qx.FieldByName('movd_brinco').AsString )=-1 then
               FEntradaAbate.EdBrinco.Items.Add( Qx.FieldByName('movd_brinco').AsString ) ;

         Qx.Next;

      end;

      FGeral.FechaQuery(Qx);

   end;


begin
///////////////////////////
  TipoEntradaAbate:='EA';
  TipoSaidaAbate:='SA';
  TipoFazenda:='FA';
// 06.04.18
  TipoPesagem:='FM';
// 08.05.19
  TipoLote:='LO';
  xUnidadessemGTA:='002';
  Op:=Opx;
//  FEntradaabate.Caption:='Pedido de Venda - Usuário '+global.Usuario.Nome;
  FEntradaabate.EdDtabate.setdate(sistema.hoje);
  FEntradaabate.EdDtcarrega.setdate(sistema.hoje-1);
//  FEntradaabate.EdVencimento.setdate(sistema.hoje+35);
// 01.11.17 - Wagner gerente compras
  FEntradaabate.EdVencimento.setdate(sistema.hoje+6);
// 24.04.13
//  FEntradaabate.Edbonuscomissao.enabled:=false;
 // FEntradaabate.Edbonuscomissao.visible:=false;
// 04.10.16 - Novicarnes isonel pediu pra liberar
// 30.07.15
  FEntradaabate.Edvalorgta.enabled:=false;
  FEntradaabate.Edvalorgta.visible:=false;
  Tipomov:=xTipomov;
  FEntradaabate.batubrincos.visible:=(Tipomov=TipoEntradaAbate);
  FEntradaAbate.EdBaiageral.Clear;
  FEntradaAbate.EdMOva_kmi.Clear;
  FEntradaAbate.EdMOva_kmi.Visible:=false;
  FEntradaAbate.EdMOva_kmi.Enabled:=false;
  FEntradaAbate.EdMOva_kmf.Visible:=false;
  FEntradaAbate.EdMOva_kmf.Enabled:=false;
  FEntradaAbate.EdMOva_kmf.Clear;

  if Global.Usuario.OutrosAcessos[0319] then begin
    FEntradaabate.EdPerc.Visible:=true;
    FEntradaabate.EdPerc.Enabled:=true;
  end else begin
    FEntradaabate.EdPerc.Visible:=false;
    FEntradaabate.EdPerc.Enabled:=false;
    FEntradaabate.EdPerc.setvalue(0);
  end;
  SerialAberta:=false;
  if OP='I' then begin

    FEntradaabate.EdDtmovimento.setdate(sistema.hoje);
    FEntradaabate.EdPerc.enabled:=false;
    FEntradaabate.EdPerc.visible:=false;

  end else begin

    if tipomov=TipoEntradaAbate then begin
      FEntradaabate.EdPerc.enabled:=Global.Topicos[1306];
      FEntradaabate.EdPerc.visible:=Global.Topicos[1306];
    end;
    if op='A' then begin
      FEntradaabate.SetaEditEntradasAbate(FEntradaabate.EdNUmerodoc);

    end;
  end;

  FEntradaabate.blebalanca.Enabled:=Global.Topicos[1316];
  FEntradaabate.blebalanca2.Enabled:=Global.Topicos[1316];
  FEntradaabate.ConfiguraBalancas;
// 01.06.18
  FEntradaabate.Edtotalpesado.Visible:=false;
  FEntradaabate.Edtotalpesado.Enabled:=false;

  FEntradaabate.EdUnid_codigo.text:=Global.CodigoUnidade;
//  FEntradaabate.Edmovd_pecas.Enabled:=Tipomov=TipoSaidaAbate;
// 09.04.16 - Isonel..
  FEntradaabate.Edmovd_pecas.Enabled:=true;
  FEntradaabate.brateio.enabled:=false;
  FEntradaabate.brateio.visible:=false;
  FEntradaabate.EdBrinco.empty:=true;
// 13.05.19
  FEntradaabate.Edbaiageral.Enabled:=false;
  FEntradaabate.EdBaiageral.Visible:=false;
// 12.06.19
  FEntradaabate.Edmova_ganhopeso.Enabled:=false;
  FEntradaabate.Edmova_ganhopeso.Visible:=false;
  FEntradaabate.EdPesovivo.Empty:=true;
  FEntradaabate.EdProduto.visible:=true;
  FEntradaabate.Edmoes_cola_codigo.Enabled:=false;
  FEntradaabate.Edmoes_cola_codigo.Visible:=false;

// 17.10.19
  FEntradaabate.EdTotalPesovivo.Enabled:=false;

  if Tipomov=TipoEntradaAbate then begin

    FEntradaabate.Caption:='Entrada de Abate';
    FEntradaabate.EdPesocarcaca.Valueformat:='#,##0.00';
    FEntradaabate.EdPesocarcaca.Title:='Peso Carcaça';
    FEntradaabate.EdPesocarcaca.Decimals:=2;
    FEntradaabate.EdPesoVivo.Title:='Peso Vivo';
    FEntradaabate.EdVlrarroba.Title:='Vlr Arroba';
// 09.06.08
    divarrobakilo:=15;
    FEntradaabate.brateio.enabled:=Global.Topicos[1306];
    FEntradaabate.brateio.visible:=Global.Topicos[1306];
    FEntradaabate.edbrinco.enabled:=true;
    FEntradaabate.EdBrinco.visible:=true;
    FEntradaabate.EdBrinco.Refresh;
    FEntradaabate.edidade.enabled:=true;
    FEntradaabate.Edidade.visible:=true;
    FEntradaabate.edpesovivo.enabled:=true;
    FEntradaabate.Edpesovivo.visible:=true;
    FEntradaabate.EdCliente.Title:='Produtor';
    FEntradaabate.EdTotalCarcaca.Title:='Total Carcaça';
    FEntradaabate.EdTotalPesovivo.visible:=true;
    FEntradaabate.Edmovd_pecas.Left:=476;
    FEntradaabate.Edmovd_pecas.TabOrder:=6;
//    FEntradaabate.Edpesocarcaca.Empty:=false;
    FEntradaabate.EdDtAbate.Title:='Data Abate';
    FEntradaabate.EdFpgt_codigo.Visible:=false;
    FEntradaabate.EdFpgt_descricao.Visible:=false;
    FEntradaabate.EdFpgt_codigo.Enabled:=false;
    FEntradaabate.EdVencimento.Enabled:=true;
// 13.06.19 - Isonel + Vagner - para controlar comissão dos 'caminhão boiadeiro'
    FEntradaabate.EdTran_codigo.Enabled:=OP='A';
    FEntradaabate.EdTran_codigo.Visible:=OP='A';
    FEntradaabate.EdTran_nome.Visible:=OP='A';
    FEntradaabate.Edmoes_cola_codigo.Enabled:=OP='A';
    FEntradaabate.Edmoes_cola_codigo.Visible:=OP='A';

    FEntradaabate.EdRepr_codigo.Visible:=true;
    FEntradaabate.EdPerccomissao.Visible:=true;
    FEntradaabate.Edbonuscomissao.enabled:=OP='A';
    FEntradaabate.Edbonuscomissao.visible:=OP='A';
    FEntradaabate.Edvalorgta.enabled:=OP='A';
    FEntradaabate.Edvalorgta.visible:=OP='A';
    FEntradaabate.EdSeto_codigo.Enabled:=false;
    FEntradaabate.EdSeto_codigo.Visible:=false;
    FEntradaabate.EdSeto_descricao.Visible:=false;
    FEntradaabate.Edbaia.Enabled:=false;
    FEntradaabate.EdBaia.Visible:=false;
// 17.06.19
    FEntradaAbate.EdMOva_kmi.Visible:=OP='A';
    FEntradaAbate.EdMOva_kmi.Enabled:=OP='A';
    FEntradaAbate.EdMOva_kmf.Visible:=OP='A';
    FEntradaAbate.EdMOva_kmf.Enabled:=OP='A';
    if OP='A' then begin
      FEntradaabate.Edmova_kmi.Top :=FEntradaabate.EdFpgt_descricao.top;
      FEntradaabate.Edmova_kmi.Left:=FEntradaabate.EdFpgt_descricao.Left;
      FEntradaabate.Edmova_kmf.Top :=FEntradaabate.Edtotalpesado.top;
      FEntradaabate.Edmova_kmf.Left:=FEntradaabate.Edtotalpesado.Left;
// 17.10.19
      FEntradaabate.EdTotalPesovivo.Enabled:=true;
    end;

// 30.09.13

  end else if pos(Tipomov,TipoFazenda+';'+TipoPesagem+';'+TipoLote)>0 then begin

    SetaItemsEstoque;
    divarrobakilo:=30;

    if tipomov=TipoFazenda then begin

      FEntradaabate.Caption:='Movimento Fazenda';
      FEntradaabate.Edbaia.Enabled:=false;
      FEntradaabate.EdBaia.Visible:=false;

// 08.05.18
      FEntradaabate.Edbaia.Enabled:=True;
      FEntradaabate.EdBaia.Visible:=True;
      FEntradaabate.EdVlrarroba.Enabled:=false;
      FEntradaabate.EdVlrarroba.Visible:=false;
      if OP='I' then begin
        FEntradaabate.Edtotalpesado.Visible:=false;
        FEntradaabate.Edtotalpesado.Enabled:=false;
      end else begin
        FEntradaabate.Edtotalpesado.Visible:=true;
        FEntradaabate.Edtotalpesado.Enabled:=true;

      end;
// 12.06.18
      FEntradaabate.EdVencimento.Enabled:=true;

    end else if tipomov = tipolote then begin

// 13.05.19
      FEntradaabate.Caption:='Pesagem LOTE';
      FEntradaabate.EdCliente.Enabled:=false;
      FEntradaabate.EdObs.Enabled:=false;
      FEntradaabate.EdObs.Visible:=false;
      FEntradaabate.EdBaia.Enabled:=false;
      FEntradaabate.EdBaia.Visible:=false;
      FEntradaabate.Edbaiageral.Enabled:=true;
      FEntradaabate.EdBaiageral.Visible:=true;
      FEntradaabate.Edbaiageral.Top:=FEntradaabate.EdPerc.top;
      FEntradaabate.Edbaiageral.Left:=FEntradaabate.EdPerc.Left;
// 12.06.19
      FEntradaabate.Edmova_ganhopeso.Enabled:=true;
      FEntradaabate.Edmova_ganhopeso.Visible:=true;
      FEntradaabate.Edmova_ganhopeso.Top:=FEntradaabate.EdFpgt_codigo.top;
      FEntradaabate.Edmova_ganhopeso.Left:=FEntradaabate.EdFpgt_codigo.Left;
      FEntradaabate.EdCliente.Text:='99999';
      FEntradaabate.EdPesovivo.Empty:=false;
      FEntradaabate.EdProduto.visible:=false;
// 28.06.19
      FEntradaabate.EdVlrarroba.Enabled:=false;
      FEntradaabate.EdVlrarroba.Visible:=false;

    end else

      FEntradaabate.Caption:='Pesagem Fazenda';

//    FEntradaabate.EdPesocarcaca.Valueformat:='#,##0.000';
//    FEntradaabate.EdPesocarcaca.Title:='Peso ';
//    FEntradaabate.EdPesocarcaca.Decimals:=3;
    FEntradaabate.EdPesocarcaca.enabled:=false;
    FEntradaabate.EdPesocarcaca.Visible:=false;
    FEntradaabate.EdVlrarroba.Title:='Vlr Unitário';
    FEntradaabate.EdPesoVivo.Title:='Peso Entrada';
//    FEntradaabate.EdVlrarroba.Enabled:=Global.Usuario.OutrosAcessos[0034];
// 22.09.16
    FEntradaabate.EdCliente.Title:='Produtor';
//    divarrobakilo:=1;
// 30.03.17 - novicarnes Isonel mudou
//    divarrobakilo:=15;
// 13.04.17 0 Isonel
//    divarrobakilo:=30;
// diferenciar por fazenda e 'nao fazenda'
    FEntradaabate.edidade.enabled:=false;
    FEntradaabate.Edidade.visible:=false;
    FEntradaabate.edbrinco.enabled:=true;
    FEntradaabate.EdBrinco.visible:=true;
    FEntradaabate.EdBrinco.empty:=false;
// 08.05.19
    SetaBrincos;

    FEntradaabate.edpesovivo.enabled:=true;
    FEntradaabate.Edpesovivo.visible:=true;
//  FEntradaabate.EdTotalCarcaca.Title:='Total Peso';
    FEntradaabate.EdTotalPesovivo.visible:=true;
//  FEntradaabate.Edmovd_pecas.Left:=FEntradaabate.EdBrinco.Left;
//  FEntradaabate.Edmovd_pecas.TabOrder:=1;
    FEntradaabate.Edmovd_pecas.enabled:=false;
    FEntradaabate.Edmovd_pecas.visible:=false;
    FEntradaabate.EdDtAbate.Title:='Movimento';
    FEntradaabate.EdFpgt_codigo.Visible:=false;
    FEntradaabate.EdFpgt_descricao.Visible:=false;
    FEntradaabate.EdFpgt_codigo.Enabled:=false;
//    FEntradaabate.EdVencimento.Enabled:=false;
// 12.06.18
    FEntradaabate.EdTran_codigo.Enabled:=false;
    FEntradaabate.EdTran_codigo.Visible:=false;
    FEntradaabate.EdTran_nome.Visible:=false;
    FEntradaabate.EdRepr_codigo.Visible:=false;
    FEntradaabate.EdPerccomissao.Visible:=false;
    FEntradaabate.EdSeto_codigo.Enabled:=false;
    FEntradaabate.EdSeto_codigo.Visible:=false;
    FEntradaabate.EdSeto_descricao.Visible:=false;
// 04.10.16 - Novicarnes Isonel
    FEntradaabate.Edbonuscomissao.enabled:=OP='A';
    FEntradaabate.Edbonuscomissao.visible:=OP='A';

  end else begin

//    FEntradaabate.Caption:='Saida de Abate';
    FEntradaabate.Caption:='Pedido de Venda';
    FEntradaabate.EdPesocarcaca.Valueformat:='#,##0.000';
    FEntradaabate.EdPesocarcaca.Title:='Peso ';
    FEntradaabate.EdPesocarcaca.Decimals:=3;
    FEntradaabate.EdVlrarroba.Title:='Vlr Unitário';
    FEntradaabate.EdVlrarroba.Enabled:=Global.Usuario.OutrosAcessos[0034];
    FEntradaabate.EdCliente.Title:='Cliente';
// 09.06.08
    divarrobakilo:=1;
    FEntradaabate.edidade.enabled:=false;
    FEntradaabate.Edidade.visible:=false;
    FEntradaabate.edbrinco.enabled:=false;
    FEntradaabate.EdBrinco.visible:=false;
    FEntradaabate.edpesovivo.enabled:=false;
    FEntradaabate.Edpesovivo.visible:=false;
    FEntradaabate.EdTotalCarcaca.Title:='Total Peso';
    FEntradaabate.EdTotalPesovivo.visible:=false;
    FEntradaabate.Edmovd_pecas.Left:=FEntradaabate.EdBrinco.Left;
    FEntradaabate.Edmovd_pecas.TabOrder:=1;
    FEntradaabate.EdDtAbate.Title:='Data Pedido';
    FEntradaabate.EdFpgt_codigo.Visible:=true;
    FEntradaabate.EdFpgt_descricao.Visible:=true;
    FEntradaabate.EdFpgt_codigo.Enabled:=true;
    FEntradaabate.EdVencimento.Enabled:=false;
    FEntradaabate.EdTran_codigo.Enabled:=true;
    FEntradaabate.EdTran_codigo.Visible:=true;
    FEntradaabate.EdTran_nome.Visible:=true;
    FEntradaabate.EdRepr_codigo.Visible:=false;
    FEntradaabate.EdPerccomissao.Visible:=false;
//    FEntradaabate.Edpesocarcaca.Empty:=true;
  end;
  notagerada:=0;
  FEntradaabate.Show;
  FEntradaabate.Grid.clear;
// 30.05.08
  SetaItemsEstoque;
// 01.07.08
  if xTipomov=TipoEntradaAbate then
    DescPeso:= FGeral.GetConfig1AsFloat('DESCPESO')
  else
    DescPeso:=0;
// 08.05.18 - Novicarnes - Isonel
  if (tipomov<>TipoPesagem) and (tipomov<>TipoLote)  then begin

    FEntradaabate.EdVlrArroba.visible:=not Global.Usuario.OutrosAcessos[0312];
    FEntradaabate.EdVlrArroba.enabled:=not Global.Usuario.OutrosAcessos[0312];

  end;

  if not Global.Usuario.OutrosAcessos[0312] then
    FEntradaabate.Grid.Columns[FEntradaabate.Grid.GetColumn('movd_vlrarroba')].widthcolumn:=55
  else
    FEntradaabate.Grid.Columns[FEntradaabate.Grid.GetColumn('movd_vlrarroba')].widthcolumn:=1;
//  FEntradaabate.EdCliente.setfocus;
  FGeral.ConfiguraColorEditsNaoEnabled(FEntradaabate);
// 13.05.19
  if  ( OP='I') then begin
    if  tipomov<>TipoLote    then
       FEntradaabate.EdCliente.SetFocus
    else
      FEntradaabate.EdDtabate.SetFocus;

  end else

      FEntradaabate.EdNumerodoc.SetFocus;



end;


procedure TFEntradaabate.EdclienteValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
var restricao1,restricao2,restricao3,restricao4:boolean;
    usuariolib:integer;
    obsliberacao,unidades:string;
begin

  if (EdCliente.resultfind<>nil) and (EdCliente.Text<>'99999') then begin

    EdClie_fone.text:=FGeral.Formatatelefone(EdCliente.resultfind.fieldbyname('clie_foneres').asstring);
//////// - 03.08.06
    EdClie_endres.text:=EdCliente.resultfind.fieldbyname('clie_endres').asstring;
    EdClie_bairrores.text:=EdCliente.resultfind.fieldbyname('clie_bairrores').asstring;
    EdClie_cepres.text:=fGeral.formatacep(EdCliente.resultfind.fieldbyname('clie_cepres').asstring);
    EdMuniRes_Nome.text:=FCidades.GetNome(EdCliente.resultfind.fieldbyname('clie_cida_codigo_res').asinteger);
//    if EdCliente.ResultFind.fieldbyname('clie_ativo').asstring<>'S' then
//      EdCliente.Invalid('Cliente não cadastrado como cooperado(associdado)');
    if  (Tipomov=TipoSaidaAbate) and (Global.Topicos[1323]  )  and (OP='I') then begin
      restricao1:=true;
      restricao2:=true;
      restricao3:=true;
      restricao4:=true;
      usuariolib:=0;
      obsliberacao:='';
      unidades:=Global.Usuario.UnidadesMvto;
///////////////////////////////
      if (OP='I')  then begin
        restricao1:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','DUP',unidades );
        restricao2:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','BOL',unidades );
        restricao3:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','CHQ',unidades );
        restricao4:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','LIM',unidades );
      end else begin
        restricao1:=true;
        restricao2:=true;
        restricao3:=true;
        restricao4:=true;
      end;
      if not restricao1 then begin //fixo portador duplicata

// 28.11.08
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;

  //      if not Confirma('Venda a vista') then
{
         usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
          if usuariolib>0 then begin
  //          Input('Contato com representante','Observação',obsliberacao,150,true);
  //          if trim(obsliberacao)='' then begin
  //            EdCliente.Invalid('Preenchimento Obrigatório');
  //            exit;
  //          end;
            FGeral.Gravalog(16,'Romaneio Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' - DUP',true,
                            '',usuariolib,obsliberacao);
          end else begin
            EdCliente.Invalid('');
            exit;
          end;
}
      end else if not restricao2  then begin //fixo portador boleto
// 28.11.08
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;

{
  //      if not Confirma('Venda a vista') then
         usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
          if usuariolib>0 then begin
  //          Input('Contato com representante','Observação',obsliberacao,100,true);
  //          if trim(obsliberacao)='' then begin
  //            EdCliente.Invalid('Preenchimento Obrigatório');
  //            exit;
  //          end;
            FGeral.Gravalog(16,'Venda Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' - BOL',true,
                            '',usuariolib,obsliberacao);
          end else begin
            EdCliente.Invalid('');
            exit;
          end;
}
      end else if not restricao3  then begin //cheques devolvidos
// 28.11.08
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;

{
  // 13.07.06 - tania
         usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
         if usuariolib>0 then begin
  //          Input('Contato com representante','Observação',obsliberacao,100,true);
  //          if trim(obsliberacao)='' then begin
  //            EdCliente.Invalid('Preenchimento Obrigatório');
  //            exit;
  //          end;
            FGeral.Gravalog(16,'Romaneio Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' - CHQ',true,
                            '',usuariolib,obsliberacao);
          end else begin
            EdCliente.Invalid('');
            exit;
          end;
}
      end else if not restricao4  then begin // total em aberto versus limite de crédito

        if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
          EdCliente.Invalid('');
          exit;
        end;

{
  // 05.06.07
         usuariolib:=FUsuarios.GetSenhaAutorizacao(302);
         if usuariolib>0 then begin
            FGeral.Gravalog(18,'Romaneio Cliente '+EdCliente.text+' - '+SetEdCLIE_NOME.text+' - LIM',true,
                            '',usuariolib,obsliberacao);
          end else begin
            EdCliente.Invalid('');
            exit;
          end;
}
      end;
/////////////////////////
    end;
  end;
  if OP='I' then
    FEntradaabate.EdDtmovimento.setdate(sistema.hoje);
end;

procedure TFEntradaabate.bIncluiritemClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

  if EdCliente.AsInteger=0 then exit;
  OpBotao:='I';
  PRemessa.Enabled:=false;
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
  bCancelar.Enabled:=false;
  PINs.visible:=true;
  PINs.Enabled:=true;
//  PINs.EnableEdits;
  LimpaEditsItens;
  EdProduto.Empty:=false;
// 27.09.16
  if Tipomov<>TipoFazenda then begin

    if Global.Topicos[1316] then
      EdPesocarcaca.Enabled:=Global.Usuario.OutrosAcessos[0040]
    else
      EdPesocarcaca.Enabled:=true;
      if Tipomov=TipoPesagem then
        EdProduto.Empty:=true;

  end else begin

      EdPesocarcaca.Enabled:=false;

  end;

  if tipomov<>TipoLote then begin

    EdProduto.Enabled:=true;
    EdProduto.SetFocus;

  end else begin

    EdProduto.Enabled:=true;
    EdBrinco.SetFocus;

  end;

end;

procedure TFEntradaabate.LimpaEditsItens;
begin
//  EdProduto.Clearall(FEntradaAbate,99);;
   EdProduto.Clear;
   EdIdade.Clear;
   EdPesovivo.Clear;
   EdPesocarcaca.Clear;
   EdSeto_codigo.Clear;
   EdVlrarroba.Clear;
   EdMovd_pecas.Clear;
   EdObs.Clear;

end;

procedure TFEntradaabate.EdProdutoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////
//var QBuscaE:TSqlquery;
begin

// 06.04.18
    if EdProduto.IsEmpty then exit;

//    qedit:='pesovivo';
    qedit:='pesocarcaca';  // 13.05.08 - por enquanto somente carcaça
    EdProduto.text:=trim(EdProduto.Text);   // 30.05.08 - quando vem do f12 com spaces a direita ( novicarnes codigo podre...)
    QBuscae:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.Assql);
    if not QBuscae.Eof then begin
      EdProduto.Text:=QBuscae.fieldbyname('esto_codigo').AsString;
      if EstaCodigosNaoVenda(QBuscae.fieldbyname('esto_codigo').AsString) then
        EdProduto.Invalid('Codigo não permitido usar em vendas');
    end else begin
      EdProduto.Invalid('Codigo não encontrado');
      exit;
    end;
    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                       ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    if QEstoque.eof then begin
       EdProduto.INvalid('Codigo não encontrado no estoque da unidade '+EdUnid_codigo.text);
       exit;
    end;

  SetEdEsto_descricao.text:=QBuscae.fieldbyname('esto_descricao').asstring;
// 05.06.08
//  if Tipomov=TipoEntradaAbate then
//    EdVlrarroba.setvalue( FGrupos.GetValorArroba(QBuscae.fieldbyname('esto_grup_codigo').AsInteger) )
//  else
  if Tipomov=TipoSaidaAbate then
    EdVlrarroba.setvalue( QEstoque.fieldbyname('esqt_vendavis').ascurrency );
{  // 22.12.15 - retirado pois mudou para se por faixa o valor
  if EdVlrarroba.ascurrency=0 then begin
    if Global.Usuario.OutrosAcessos[0312] then begin
      EdProduto.Invalid('Atenção.   Valor da arroba zerado no cadastro de Grupos do estoque');
    end else begin
      Avisoerro('Atenção.   Valor da arroba zerado no cadastro de Grupos do estoque');
      exit;
    end;
  end;
}

end;

procedure TFEntradaabate.EdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then begin
    bcancelaritemclick(self);
    bgravarclick(self);
  end;

end;

procedure TFEntradaabate.EdobsExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////
var xbaia:string;

begin

  if (op='A') and (opbotao='A') then
// 26.11.10  - retirado 01.12.10 - cagadas pegas por isonel...
//  if (opbotao='A') then
    seq:=strtoint(Grid.Cells[grid.getcolumn('movd_ordem'),Grid.row]);
  if op='A' then begin
    if notagerada>0 then begin
//        Avisoerro('Entrada com nota '+inttostr(notagerada)+' de produtor já gerada');
        Avisoerro('Nota Fiscal '+inttostr(notagerada)+' já gerada');
        exit;
    end;
  end;

  if confirma('Confirma item ?') then begin
    if (op='A') and (opbotao='A') then
// 26.11.10
//    if (opbotao='A') then
      EditstoGrid(seq)
    else
      EditstoGrid;
    CalculaTotal;
//{
    if op='A' then begin
      GravaItem;
      GravaMestre;
      sistema.beginprocess('Gravando Item');
      Sistema.Commit;
      sistema.endprocess('');
    end;
//}
  end;
//  LimpaEditsItens;
  xbaia:=EdBaia.Text;
  EdProduto.Clearall(FEntradaAbate,99);;
  EdBaia.Text:=xbaia;
// 21.05.19
  if Tipomov=TipoLote then begin
    EdBrinco.SetFocus;
  end else if EdProduto.enabled then begin
    EdProduto.SetFocus;
  end else begin
    bcancelaritemclick(self);
  end;
  QBuscae.close;
  Freeandnil(QEstoque);

end;

procedure TFEntradaabate.EditstoGrid(xseq:integer=0);
/////////////////////////////////////////////////////////////////////
var x:integer;
    rend:currency;
begin
//  x:=ProcuraGrid(Grid.getcolumn('movd_esto_codigo'),EdProduto.Text,0,0,0,0,
//                 0,0 );
  if xseq=0 then
    x:=ProcuraGrid(Grid.getcolumn('movd_ordem'),strzero(xseq,3),0,0,0,0,0,0 )
  else
    x:=ProcuraGrid(Grid.getcolumn('movd_ordem'),strzero(xseq,3),0,0,0,0,0,0 );
  if Edpesovivo.ascurrency>0 then
    rend:=( Edpesocarcaca.ascurrency/Edpesovivo.ascurrency ) *100
  else
    rend:=0;
  if x<0 then begin
    temgrid:=false;
    Grid.AppendRow;
    Grid.Cells[grid.getcolumn('movd_ordem'),Abs(x)]:=strzero(Seq,3);
    Grid.Cells[grid.getcolumn('movd_esto_codigo'),Abs(x)]:=EdProduto.Text;
    Grid.Cells[grid.getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;
    Grid.Cells[grid.getcolumn('movd_brinco'),Abs(x)]:=EdBrinco.Text;
    Grid.Cells[grid.getcolumn('movd_idade'),Abs(x)]:=EdIdade.Text;
    Grid.Cells[grid.getcolumn('movd_pesovivo'),Abs(x)]:=EdPesovivo.AsSql;
    Grid.Cells[grid.getcolumn('movd_pesocarcaca'),Abs(x)]:=EdPesocarcaca.AsSql;
//    Grid.Cells[grid.getcolumn('totalitem'),Abs(x)]:=TRansform( (EdPesocarcaca.AsCurrency*EdVlrarroba.AsCurrency)/divarrobakilo ,f_cr );
// 23.08.18 - nfe 4.0
    Grid.Cells[grid.getcolumn('totalitem'),Abs(x)]:=TRansform( (EdPesocarcaca.AsCurrency*EdVlrarroba.AsCurrency)/divarrobakilo ,f_cr4 );
    Grid.Cells[grid.getcolumn('rendimento'),Abs(x)]:=Transform(rend,f_cr);
    Grid.Cells[grid.getcolumn('movd_vlrarroba'),Abs(x)]:=EdVlrarroba.AsSql;
    Grid.Cells[grid.getcolumn('movd_obs'),Abs(x)]:=Edobs.Text;
    Grid.Cells[grid.getcolumn('movd_pecas'),Abs(x)]:=Edmovd_pecas.text;
// 30.09.13
    Grid.Cells[grid.getcolumn('movd_baia'),Abs(x)]:=Edbaia.Text;
    Grid.Cells[grid.getcolumn('movd_seto_codigo'),Abs(x)]:=EdSeto_codigo.Text;

  end else begin
    temgrid:=true;
    Grid.Cells[grid.getcolumn('movd_esto_codigo'),x]:=EdProduto.Text;
    Grid.Cells[grid.getcolumn('esto_descricao'),x]:=SetEdEsto_descricao.text;
    Grid.Cells[grid.getcolumn('movd_brinco'),Abs(x)]:=EdBrinco.Text;
    Grid.Cells[grid.getcolumn('movd_idade'),Abs(x)]:=EdIdade.Text;
    Grid.Cells[grid.getcolumn('movd_pesovivo'),Abs(x)]:=EdPesovivo.AsSql;
    Grid.Cells[grid.getcolumn('movd_pesocarcaca'),Abs(x)]:=EdPesocarcaca.AsSql;
    Grid.Cells[grid.getcolumn('totalitem'),Abs(x)]:=TRansform( (EdPesocarcaca.AsCurrency*EdVlrarroba.AsCurrency)/divarrobakilo ,f_cr );
    Grid.Cells[grid.getcolumn('rendimento'),Abs(x)]:=Transform(rend,f_cr);
    Grid.Cells[grid.getcolumn('movd_vlrarroba'),Abs(x)]:=EdVlrarroba.AsSql;
    Grid.Cells[grid.getcolumn('movd_obs'),Abs(x)]:=Edobs.Text;
    Grid.Cells[grid.getcolumn('movd_pecas'),Abs(x)]:=Edmovd_pecas.Text;
// 30.09.13
    Grid.Cells[grid.getcolumn('movd_baia'),Abs(x)]:=Edbaia.Text;
    Grid.Cells[grid.getcolumn('movd_seto_codigo'),Abs(x)]:=EdSeto_codigo.Text;
  end;

end;

function TFEntradaabate.ProcuraGrid(Coluna: integer; Pesquisa: string;
  Colunatam, tam, colunacor, cor, colunacopa, copa: integer): integer;
//////////////////////////////////////////////////////////////////////
var p:integer;
begin
  result:=0;seq:=0;
  for p:=1 to Grid.RowCount do  begin
      if trim(Grid.Cells[Grid.getcolumn('movd_ordem'),p])<>'' then begin
        seq:=strtoint(Grid.Cells[Grid.getcolumn('movd_ordem'),p]);
        inc(seq);
      end else begin
        if seq=0 then
          seq:=1;
      end;
  end;
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
         (trim(Grid.Cells[Colunatam,p])=trim(inttostr(tam))) and (trim(Grid.Cells[Colunacor,p])=trim(inttostr(cor)))
          and ( trim(Grid.Cells[Colunacopa,p])=trim(inttostr(copa)) ) then begin
          result:=p;
          break;
        end;
        if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
    end;
  end else if (tam>0) and (cor=0) then begin  // 04.07.06
      for p:=1 to Grid.RowCount do  begin
        if (trim(Grid.Cells[Coluna,p])=trim(Pesquisa)) and
         ( trim(Grid.Cells[Colunatam,p])=trim(inttostr(tam)) ) and ( texttovalor(Grid.Cells[Colunacor,p])=0 ) then begin
          result:=p;
          break;
        end;
        if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
  end else begin  // 03.10.07
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

procedure TFEntradaabate.bCancelaritemClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin
  if EdCliente.AsInteger=0 then exit;
  bGravar.Enabled:=true;
  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
  PINs.Enabled:=false;
  PINs.DisableEdits;
  PRemessa.Enabled:=true;
  if Op<>'A' then
    edVencimento.SetFocus
  else
    Grid.setfocus;

end;

procedure TFEntradaabate.EdpesocarcacaValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////
var pesoestoque:currency;
begin
  if (Edpesocarcaca.ascurrency>0) and (Edpesovivo.ascurrency>0) then begin
    if edpesocarcaca.ascurrency>Edpesovivo.AsCurrency then
      Edpesocarcaca.invalid('Peso da carcaça tem que ser menor que o peso vivo')
    else
// 23.07.13 - quando colocava o peso vivo dai 'fu...'
// 14.11.16 - Isonel somente na inclusao busca preco
      if ( (pos(Tipomov,TipoEntradaAbate+';'+TipoFazenda)>0) ) and ( OP='I') then
        EdVlrarroba.setvalue( FGrupos.GetValorArroba(QBuscae.fieldbyname('esto_grup_codigo').AsInteger,EdPesoCarcaca.ascurrency,EdProduto.text) )

  end else if (Edpesocarcaca.ascurrency>0) then begin
  // 30.05.08
//    if Global.Topicos[1318] then
//       EdPesocarcaca.setvalue( FGeral.Arredonda(EdPesocarcaca.ascurrency,0) );
// 08.10.15 - retirado pois tem nova tela para pesagem de entrada
    lpeso.Caption:=EdPesocarcaca.text;
// 24.09.12 - Isonel
//    if (Tipomov=TipoEntradaAbate) and (OP='I') then
// 21.09.15
    if (pos(Tipomov,TipoEntradaAbate+';'+TipoFazenda)>0) and (OP='I') then
      EdVlrarroba.setvalue( FGrupos.GetValorArroba(QBuscae.fieldbyname('esto_grup_codigo').AsInteger,EdPesoCarcaca.ascurrency,EdProduto.text) )
  end;
// 09.09.15 - Iso...dianteiro ' + caro'
  if (Tipomov='SA')  then begin
    pesoestoque:=FEstoque.getpeso(EdProduto.text);
    if ( EdPesocarcaca.ascurrency>0 ) and (PesoEstoque>0) and (EdPesocarcaca.ascurrency>PesoEstoque) then begin
      EdPesocarcaca.invalid('Peso acima do permitido.  Checar para troca de codigo');
    end;
  end;

end;

procedure TFEntradaabate.CalculaTotal;
///////////////////////////////////////////
var p,xGrupoSuino,xgrupoovelha:integer;
    vlrtotal,qtdpecas,pesovivo,vlrgta,unitariogta:currency;
    temsuino,
    temovelha :boolean;

begin
  vlrtotal:=0;qtdpecas:=0;pesovivo:=0;vlrgta:=0;
  unitariogta:=FGeral.GetConfig1AsFloat('valorgta');
  temsuino:=false;
  temovelha:=false;
  xGrupoSuino:=13;
// 09.10.18
  xGrupoOvelha:=15;   // ver pra criar configuracao 'grupos gta suino'

  for p:=1 to Grid.RowCount do begin
    if Grid.Cells[grid.getcolumn('movd_esto_codigo'),p]<>'' then begin
      if FEstoque.GetGrupo(Grid.Cells[grid.getcolumn('movd_esto_codigo'),p])=xGrupoSuino then temsuino:=true;
      if FEstoque.GetGrupo(Grid.Cells[grid.getcolumn('movd_esto_codigo'),p])=xGrupoOvelha then temovelha:=true;
    end;
  end;
// 21.08.17
  if ( pos( EdUnid_codigo.text, xUnidadessemGTA ) = 0 ) and ( (  temsuino ) or ( temovelha ) ) then
    unitariogta:=FGeral.GetConfig1AsFloat('valorgtasuinos');

  for p:=1 to Grid.RowCount do begin

    if Grid.Cells[grid.getcolumn('movd_esto_codigo'),p]<>'' then begin

      vlrtotal:=vlrtotal+FGeral.Arredonda( texttovalor(Grid.Cells[grid.getcolumn('totalitem'),p]) ,2);
      qtdpecas:=qtdpecas+texttovalor(Grid.Cells[grid.getcolumn('movd_pesocarcaca'),p]);
      pesovivo:=pesovivo+texttovalor(Grid.Cells[grid.getcolumn('movd_pesovivo'),p]);
      vlrgta:=vlrgta+unitariogta;
      if FEstoque.GetGrupo(Grid.Cells[grid.getcolumn('movd_esto_codigo'),p])=xGrupoSuino then temsuino:=true;

    end;

  end;

// 14.08.15 - 21.08.17 - 31.10.18
  if ( pos( EdUnid_codigo.text, xUnidadessemGTA ) > 0 ) then
     vlrgta:=0;

  Edtotalremessa.setvalue(vlrtotal);
  EdTotalcarcaca.setvalue(qtdpecas);
  EdTotalpesovivo.setvalue(pesovivo);
  EdValorgta.setvalue(vlrgta);

end;

procedure TFEntradaabate.EdDtMovimentoExitEdit(Sender: TObject);
begin
  if OP='A' then
    Grid.setfocus
  else
    bincluiritemclick(self);
end;

procedure TFEntradaabate.EdBrincoKeyPress(Sender: TObject; var Key: Char);
/////////////////////////////////////////////////////////////////////////////
begin

  if key=#27 then begin
    bcancelaritemclick(self);
    bgravarclick(self);
  end;

end;

procedure TFEntradaabate.EdBrincoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////
var r,
    x :integer;
    Qb:TSqlquery;
begin

// 22.07.20 - brinco digitado 'com virgula'...
  if not EdBrinco.IsEmpty then begin

     if not TryStrToInt(EdBrinco.text,x) then begin

        EdBrinco.invalid('Permitido somente número');

     end;

  end;

  if AnsiPos( tipomov,TipoFazenda+';'+TipoPesagem+';'+TipoLote) > 0 then begin

     if not EdBrinco.IsEmpty then begin

       r:=Procuragrid(Grid.getcolumn('movd_brinco'),EdBrinco.text);
       if opbotao='A' then begin
//         if (r>0) and ( r<>strtoint(Grid.cells[Grid.getcolumn('movd_ordem'),grid.row]) ) then
//           EdBrinco.Invalid('Brinco '+EdBrinco.text+' já digitado na linha '+strzero(r,3));
       end else begin
         if (r>0) then
           EdBrinco.Invalid('Brinco '+EdBrinco.text+' já digitado na linha '+strzero(r,3));
       end;
       Qb:=sqltoquery('select movd_brinco,movd_numerodoc,movd_pesovivo,movd_esto_codigo,movd_vlrarroba '+
                      'from movabatedet where movd_brinco = '+EdBrinco.AsSql+
                      ' and movd_unid_codigo = '+EdUnid_codigo.assql+
//                      ' and movd_tipomov = '+stringtosql(tipoFazenda)+
// 10.05.18
//                      ' and movd_tipomov = '+stringtosql(tipomov)+
// 28.05.19
                      ' and '+FGeral.GetIN('movd_tipomov',TipoFazenda+';'+TipoLote+';'+TipoEntradaAbate,'C')+
// 22.03.17 - Isonel reaproveita brincos
                      ' and ( (movd_abatido <> ''S'') or (movd_abatido is null) )'+
                      ' and movd_status <> ''C''');

       if (not Qb.eof) then begin

         if tipomov=TipoFazenda then begin

             if EdNumerodoc.asinteger>0 then begin
                if (Qb.fieldbyname('movd_numerodoc').asinteger<>EdNUmerodoc.AsInteger) then begin
                  Aviso('Atenção.  Brinco já usado no romaneio '+Qb.fieldbyname('movd_numerodoc').asstring);
// 05.04.19 - Isonel nao vai mais reaproveitar o mesmo brinco
                  exit;
                end;
             end else begin
                  Aviso('Atenção.  Brinco já usado no romaneio '+Qb.fieldbyname('movd_numerodoc').asstring);
                  exit;
             end;

         end else begin

            EdPesovivo.setvalue(Qb.FieldByName('movd_pesovivo').AsCurrency);
            EdProduto.Text:=Qb.FieldByName('movd_esto_codigo').AsString;
// 28.06.19
            EdVlrarroba.SetValue(Qb.FieldByName('movd_vlrarroba').AsCurrency);
            EdProduto.Valid;
            QBuscae:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.Assql);
// 12.06.19
            if Tipomov=Tipolote then EdBaia.Text:=EdBaiageral.Text;

         end;

       end else if AnsiPos(Tipomov,TipoPesagem+';'+TipoLote) >0 then begin

         EdBrinco.Invalid('Brinco não encontrado para nova pesagem ou formação de lote');

       end;

       FGeral.FechaQuery(Qb);
     end;
  end;
// 21.09.15  - Isonel
   if OpBotao='A' then EdProduto.valid;
end;

procedure TFEntradaabate.bExcluiritemClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var codigoestoque,ordem:string;
begin
  if EdCliente.AsInteger=0 then exit;

  if OP='A' then begin
    if EntradaFaturada(EdNumerodoc.asinteger) then begin
       Avisoerro('Entrada de Abate já faturada');
       exit;
    end;
  end;

  if trim(Grid.Cells[0,Grid.row])='' then exit;
  if confirma('Confirma exclusão ?') then begin
    codigoestoque:=Grid.Cells[Grid.getcolumn('movd_esto_codigo'),Grid.row];
    ordem:=Grid.Cells[Grid.getcolumn('movd_ordem'),Grid.row];
    Grid.DeleteRow(Grid.Row);
    Calculatotal;

    if OP='A' then begin
      ExecuteSql('Update movabatedet set movd_status=''C'' where movd_status=''N'''+
          ' and movd_ordem='+ordem+
          ' and movd_transacao='+stringtosql(transacao)+
          ' and movd_esto_codigo='+Stringtosql(codigoestoque) ) ;
      GravaMestre;
    end;
    Sistema.Commit;

  end;
end;

procedure TFEntradaabate.bGravarClick(Sender: TObject);
///////////////////////////////////////////////////////////////
var Numero:integer;
begin

  if EdCliente.isempty then begin
    Avisoerro('Checar codigo do produtor/cliente');
    exit;
  end;
  if (EdTotalremessa.ascurrency<=0) and ( AnsiPos(TipoMov,TipoEntradaAbate+';'+TipoPesagem+';'+TipoFazenda+';'+TipoLote)=0 ) then begin
    Avisoerro('Checar o valor total');
    exit;
  end;
//  if (Grid.RowCount<=1) then
//    exit;

  if notagerada>0 then begin
        Avisoerro('Nota '+inttostr(notagerada)+' já gerada');
        exit;
  end;
{
  if Serial.Enabled then begin
    Serial.close;
    SerialAberta:=false;
  end;
  if Serial2.Enabled then
    Serial2.close;
}

  if confirma('Confirma gravação ?') then begin

    if OP='I' then begin
      if Tipomov=TipoEntradaAbate then
        Numero:=FGeral.GetContador('ENTABATE',false)
      else if Ansipos( Tipomov,TipoFazenda+';'+TipoPesagem) >0 then
        Numero:=FGeral.GetContador('FAZENDA',false)
      else if Ansipos( Tipomov,TipoLote) >0 then
        Numero:=FGeral.GetContador('LOTEFAZENDA',false)
      else
        Numero:=FGeral.GetContador('SAIABATE',false);
      EdNumerodoc.Text:=inttostr(Numero);
      Sistema.BeginProcess('Gravando');
      Transacao:=Global.CodigoUnidade+ Inttostr( FGeral.GetContador('TRANEA'+EdUnid_codigo.text,false) );
      GravaMestre;
      GravaItens;
      try
        sistema.commit;
        if Tipomov=TipoEntradaAbate then
          Sistema.EndProcess('Incluido entrada numero '+EdNUmerodoc.text)
        else if Tipomov=TipoFazenda then
          Sistema.EndProcess('Incluido numero '+EdNUmerodoc.text)
        else if Tipomov=TipoPesagem then
          Sistema.EndProcess('Incluido Pesagem numero '+EdNUmerodoc.text)
        else if Tipomov=TipoLote then
          Sistema.EndProcess('Incluido LOTE numero '+EdNUmerodoc.text)
        else
          Sistema.EndProcess('Incluido saida numero '+EdNUmerodoc.text);
      except
        Sistema.EndProcess('Problemas na gravação.  Nada foi gravado.');
      end;
// 30.05.08
      if Global.Usuario.ObjetosAcessados[1334] then begin
        if confirma('Deseja imprimir ?') then
          bimpclick(self);
// 13.06.08
// 08.02.10 - retirado da inclusao
       {
        if (Tipomov=TipoSaidaAbate) and (Confirma('Deseja fazer nota de venda ?')) then begin
          FEntradaabate.SendToBack;
          FNotaSaida.Show;
//          FNotaSaida.BringToFront;
          FNotaSaida.Execute('I','N',FGeral.Getconfig1asinteger('ConfMovAbate'),EdNumerodoc.asinteger,EdCliente.asinteger);
          FNotaSaida.SetFocus;
        end;
       }
//
      end;

    end else if OP='A' then begin

      Sistema.BeginProcess('Gravando');
      GravaMestre;
      GravaItens;
      try
        sistema.commit;
        Sistema.EndProcess('Gravado documento numero '+EdNUmerodoc.text);
      except
        Sistema.EndProcess('Problemas na gravação.  Nada foi gravado.');
        exit;
      end;

    end;

    if OP='I' then
      EdCliente.Setfocus
    else begin
      EdNumerodoc.SetFocus;
// 08.02.10 - retirado da inclusao
      if  ( Global.Usuario.OutrosAcessos[0322] ) then begin  // 09.03.10
        if (Tipomov=TipoSaidaAbate) and (Confirma('Deseja fazer nota de venda ?')) then begin
            FEntradaabate.SendToBack;
            FNotaSaida.Show;
  //          FNotaSaida.BringToFront;
            FNotaSaida.Execute('I','N',FGeral.Getconfig1asinteger('ConfMovAbate'),EdNumerodoc.asinteger,EdCliente.asinteger,EdFpgt_codigo.text,EdTran_codigo.text);
            FNotaSaida.SetFocus;
        end;
      end;
    end;

    EdCliente.Clearall(FEntradaabate,99);
    EdProduto.Clearall(FEntradaabate,99);
    EdDtabate.setdate(sistema.hoje);
//    EdVencimento.setdate(sistema.hoje+35);
    EdDtmovimento.setdate(sistema.hoje);
    EdUnid_codigo.text:=Global.CodigoUnidade;
// 30.07.08
    EdDtcarrega.setdate(sistema.hoje-1);
    Grid.Clear;


  end;
end;

procedure TFEntradaabate.GravaItem;
//////////////////////////////////////////////////
var  Q2:TSqlquery;
begin
{
   Q2:=Sqltoquery('select * from movabatedet where movd_status=''N'''+
          ' and movd_numerodoc='+EdNumerodoc.AsSql+
          ' and movd_tipomov='+Stringtosql(Tipomov)+
          ' and movd_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and movd_tipo_codigo='+EdCliente.AsSql );
          }
// 13.07.16
   Q2:=Sqltoquery('select mova_transacao from movabate where mova_status=''N'''+
          ' and mova_numerodoc='+EdNumerodoc.AsSql+
          ' and mova_tipomov='+Stringtosql(Tipomov)+
          ' and mova_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and mova_tipo_codigo='+EdCliente.AsSql );

   if Q2.Eof then begin

      Avisoerro('Não encontrado este documento para incluir este item');
      exit;

   end else if (EdProduto.enabled=false) or ( temgrid ) then begin

      Transacao:=Q2.fieldbyname('mova_transacao').Asstring;
      Sistema.Edit('movabatedet');
      Sistema.SetField('movd_tipo_codigo',EdCliente.AsInteger);
//      Sistema.SetField('movd_tipocad','C');
      Sistema.SetField('movd_brinco',EdBrinco.text);
      Sistema.SetField('movd_idade',EdIdade.text);
      Sistema.SetField('movd_pesovivo',EdPesovivo.ascurrency);
      Sistema.SetField('movd_pesocarcaca',EdPesocarcaca.ascurrency);
      Sistema.SetField('movd_vlrarroba',EdVlrarroba.ascurrency);
      Sistema.SetField('movd_obs',EdObs.text);
      Sistema.SetField('movd_pecas',EdMOvd_pecas.asinteger);
// 26.11.10 - Novicanres - Isonel - que alterar durante a inclusao
//      Sistema.SetField('movd_esto_codigo',EdProduto.text);
// 30.09.13
      Sistema.SetField('movd_baia',Edbaia.Text);
      Sistema.SetField('movd_seto_codigo',EdSeto_codigo.Text);
// 22.09.16
      Sistema.SetField('movd_datamvto',EdDtabate.AsDate);

      Sistema.Post('movd_numerodoc='+EdNumerodoc.AsSql
                   +' and movd_ordem='+Grid.cells[Grid.getcolumn('movd_ordem'),Grid.row]
// 09.05.18
                   +' and movd_tipomov = '+Stringtosql(TipoMov)+
                   ' and movd_status=''N''');

      Sistema.Commit;


   end else begin

      Transacao:=Q2.fieldbyname('mova_transacao').Asstring;
      Sistema.Insert('movabatedet');
      Sistema.SetField('movd_esto_codigo',EdProduto.text);
      Sistema.SetField('movd_transacao',transacao);
      Sistema.SetField('movd_operacao',transacao+strzero(seq,3));
      Sistema.SetField('movd_numerodoc',Ednumerodoc.Asinteger);
      Sistema.SetField('movd_status','N');
      Sistema.SetField('movd_tipomov',TipoMov);
      Sistema.SetField('movd_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('movd_tipo_codigo',EdCliente.AsInteger);
//      Sistema.SetField('movd_tipocad','C');
      Sistema.SetField('movd_brinco',EdBrinco.text);
      Sistema.SetField('movd_idade',Edidade.text);
      Sistema.SetField('movd_pesovivo',EdPesovivo.ascurrency);
      Sistema.SetField('movd_pesocarcaca',EdPesocarcaca.ascurrency);
      Sistema.SetField('movd_vlrarroba',EdVlrarroba.ascurrency);
      Sistema.SetField('movd_obs',Edobs.text);
      Sistema.SetField('movd_ordem',seq);
      Sistema.SetField('movd_pecas',EdMOvd_pecas.asinteger);
// 30.09.13
      Sistema.SetField('movd_baia',Edbaia.Text);
      Sistema.SetField('movd_seto_codigo',EdSeto_codigo.Text);
// 22.09.16
      Sistema.SetField('movd_datamvto',EdDtabate.AsDate);
      Sistema.Post('');
      Sistema.Commit;
   end;
   Q2.Close;
   Freeandnil(Q2);
end;

procedure TFEntradaabate.GravaItens;
//////////////////////////////////////////////
var linha:integer;
    Qo   :TSqlquery;

begin

  for linha:=1 to Grid.rowcount do begin

    if trim(Grid.Cells[0,linha])<>'' then begin

      if op='I' then begin

        Sistema.Insert('movabatedet');
        Sistema.SetField('movd_esto_codigo',Grid.cells[Grid.getcolumn('movd_esto_codigo'),linha]);
        Sistema.SetField('movd_transacao',transacao);
        Sistema.SetField('movd_operacao',transacao+Grid.cells[Grid.getcolumn('movd_ordem'),linha]);
        Sistema.SetField('movd_numerodoc',Ednumerodoc.Asinteger);
        Sistema.SetField('movd_status','N');
        Sistema.SetField('movd_tipomov',TipoMov);
        Sistema.SetField('movd_unid_codigo',EdUnid_codigo.text);
        Sistema.SetField('movd_tipo_codigo',EdCliente.AsInteger);
//        Sistema.SetField('movd_tipocad','C');
        Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),linha]);
        Sistema.SetField('movd_idade',Grid.cells[Grid.getcolumn('movd_idade'),linha]);
        Sistema.SetField('movd_pesovivo',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesovivo'),linha]));
        Sistema.SetField('movd_pesocarcaca',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesocarcaca'),linha]));
        Sistema.SetField('movd_vlrarroba',Texttovalor(Grid.cells[Grid.getcolumn('movd_vlrarroba'),linha]));
        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
        Sistema.SetField('movd_ordem',strtoint(Grid.cells[Grid.getcolumn('movd_ordem'),linha]));
        Sistema.SetField('movd_pecas',Texttovalor(Grid.cells[Grid.getcolumn('movd_pecas'),linha]));
// 30.09.13
        Sistema.SetField('movd_baia',Grid.cells[Grid.getcolumn('movd_baia'),linha]);
        Sistema.SetField('movd_seto_codigo',Grid.cells[Grid.getcolumn('movd_seto_codigo'),linha]);
// 08.04.18
        Sistema.SetField('movd_datamvto',EdDtabate.AsDate);
        Sistema.Post('');

      end else begin

        Sistema.Edit('movabatedet');
        Sistema.SetField('movd_tipo_codigo',EdCliente.AsInteger);
//        Sistema.SetField('movd_tipocad','C');
        Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),linha]);
        Sistema.SetField('movd_idade',Grid.cells[Grid.getcolumn('movd_idade'),linha]);
        Sistema.SetField('movd_pesovivo',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesovivo'),linha]));
        Sistema.SetField('movd_pesocarcaca',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesocarcaca'),linha]));
        Sistema.SetField('movd_vlrarroba',Texttovalor(Grid.cells[Grid.getcolumn('movd_vlrarroba'),linha]));
        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
        Sistema.SetField('movd_pecas',Texttovalor(Grid.cells[Grid.getcolumn('movd_pecas'),linha]));
// 26.11.10 - Novicarnes - Isonel
//        Sistema.SetField('movd_esto_codigo',Grid.cells[Grid.getcolumn('movd_esto_codigo'),linha]);
// 30.09.13
        Sistema.SetField('movd_baia',Grid.cells[Grid.getcolumn('movd_baia'),linha]);
        Sistema.SetField('movd_seto_codigo',Grid.cells[Grid.getcolumn('movd_seto_codigo'),linha]);
        Sistema.Post('movd_numerodoc='+EdNumerodoc.AsSql+' and movd_ordem='+Grid.cells[Grid.getcolumn('movd_ordem'),linha]+
                     ' and movd_tipomov='+Stringtosql(TipoMov)+  // 01.06.11
                     ' and movd_status=''N''');
      end;
// 22.07.20 - Novicarnes - verificar se for entrada de lote tirar o brinco de outro lote caso tiver
      if Tipomov = TipoLote then begin

         Qo := sqltoquery( 'select movd_operacao from movabatedet where movd_numerodoc <> '+EdNumerodoc.AsSql+
                     ' and movd_tipomov='+Stringtosql(TipoMov)+
                     ' and movd_brinco = '+Stringtosql( Grid.cells[Grid.getcolumn('movd_brinco'),linha])+
                     ' and movd_unid_codigo = '+EdUnid_codigo.assql+
                     ' and movd_status=''N''');
         if not Qo.eof then  begin

            Sistema.edit('movabatedet');
            Sistema.setfield('movd_status','C');
            Sistema.post('movd_operacao = '+Stringtosql(Qo.fieldbyname('movd_operacao').asstring));

         end;
         Fgeral.FechaQuery( Qo);

      end;

    end;

  end;

end;

procedure TFEntradaabate.GravaMestre;
//////////////////////////////////////////
begin
  if Op='I' then begin
    Sistema.Insert('Movabate');
    Sistema.SetField('mova_transacao',Transacao);
    Sistema.SetField('mova_operacao',Transacao+'01');
    Sistema.SetField('mova_status','N');
    Sistema.SetField('mova_numerodoc',EdNumerodoc.asinteger);
    Sistema.SetField('mova_tipomov',TipoMov);
    Sistema.SetField('mova_unid_codigo',EdUnid_codigo.text);
    Sistema.SetField('mova_tipo_codigo',EdCliente.AsInteger);
//    Sistema.SetField('mova_tipocad','C');
    Sistema.SetField('mova_datalcto',Sistema.Hoje);
    Sistema.SetField('mova_dtabate',EdDtabate.asdate);
    Sistema.SetField('mova_dtcarrega',EdDtcarrega.asdate);
    Sistema.SetField('mova_dtvenci',EdVencimento.asdate);
    Sistema.SetField('mova_notagerada',0);
    Sistema.SetField('mova_transacaogerada','');
    Sistema.SetField('mova_pesovivo',EdTotalpesovivo.ascurrency);
    Sistema.SetField('mova_pesocarcaca',EdTotalcarcaca.ascurrency);
    Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('mova_datacont',EdDtMovimento.asdate);
    Sistema.SetField('mova_situacao','P');
// 17.02.10
    Sistema.SetField('mova_tran_codigo',EdTran_codigo.text);
    Sistema.SetField('mova_fpgt_codigo',EdFpgt_codigo.text);
///////////
// 21.01.11
    Sistema.SetField('Mova_repr_codigo',EdRepr_codigo.AsInteger);
    Sistema.SetField('Mova_vlrtotal',EdTotalRemessa.ascurrency);
    Sistema.SetField('Mova_perccomissao',EdPercComissao.ascurrency);
// 30.07.15
    Sistema.SetField('Mova_vlrgta',Edvalorgta.ascurrency);
// 12.06.19
    Sistema.SetField('Mova_ganhopeso',Edmova_ganhopeso.AsCurrency);
///////////
    Sistema.Post();

  end else begin

    Sistema.Edit('Movabate');
    Sistema.SetField('mova_tipo_codigo',EdCliente.AsInteger);
//    Sistema.SetField('mova_tipocad','C');
//    Sistema.SetField('mova_datalcto',Sistema.Hoje);
    Sistema.SetField('mova_dtabate',EdDtabate.asdate);
    Sistema.SetField('mova_dtcarrega',EdDtcarrega.asdate);
    Sistema.SetField('mova_dtvenci',EdVencimento.asdate);
//    Sistema.SetField('mova_notagerada',0);
//    Sistema.SetField('mova_transacaogerada','');
    Sistema.SetField('mova_pesovivo',EdTotalpesovivo.ascurrency);
    Sistema.SetField('mova_pesocarcaca',EdTotalcarcaca.ascurrency);
    Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('mova_perc',EdPerc.ascurrency);
// 17.02.10
    Sistema.SetField('mova_tran_codigo',EdTran_codigo.text);
    Sistema.SetField('mova_fpgt_codigo',EdFpgt_codigo.text);
///////////
// 21.01.11
    Sistema.SetField('Mova_repr_codigo',EdRepr_codigo.AsInteger);
    Sistema.SetField('Mova_vlrtotal',EdTotalRemessa.ascurrency);
    Sistema.SetField('Mova_perccomissao',EdPercComissao.ascurrency);
// 30.07.15
    Sistema.SetField('Mova_vlrgta',Edvalorgta.ascurrency);
// 12.06.19
    Sistema.SetField('Mova_ganhopeso',Edmova_ganhopeso.AsCurrency);
    Sistema.SetField('Mova_cola_codigo',Edmoes_cola_codigo.Text);
// 17.06.19
    Sistema.SetField('Mova_kmi',Edmova_kmi.AsInteger);
    Sistema.SetField('Mova_kmf',Edmova_kmf.AsInteger);
///////////
    Sistema.Post('mova_transacao='+stringtosql(transacao));
  end;

end;

procedure TFEntradaabate.bimpClick(Sender: TObject);
////////////////////////////////////////////////////
type TProdutos=record
  produto:string;
  pesocarcaca,vlrarroba,pesovivo,valortotal:currency;
end;

var produtospp,largura,i:integer;
    QClientes:tSqlquery;
    tpesovivo,tpesocarcaca,rend,tvalortotal,perfunrural,percotacapital,valorfunrural,valorcotacapital:currency;
    PProdutos:^Tprodutos;
    Lista:TList;
    Datacont:TDatetime;
    ListaTexto:Tstringlist;

    procedure Atualiza(produto:string ; vlrarroba,vivo,carcaca:currency );
    ////////////////////////////////////////////////////////////////////////
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
        PProdutos.valortotal:=carcaca*FGeral.Arredonda((vlrarroba/divarrobakilo),4);
        Lista.Add(PProdutos);

      end else begin

        PProdutos.pesovivo:=PProdutos.pesovivo+vivo;
        PProdutos.pesocarcaca:=PProdutos.pesocarcaca+carcaca;
//        PProdutos.vlrarroba:=vlrarroba;
        PProdutos.valortotal:=PProdutos.valortotal+(carcaca*FGeral.Arredonda((vlrarroba/divarrobakilo),4));
      end;

    end;


begin

  FRelGerenciais_EntradadeAbate(EdNumerodoc.asinteger,EdUnid_codigo.text,tipomov);
  exit;
//////////////////////////////////////////////////////////////////////////////////////////////
{
  Sistema.BeginProcess('');
  largura:=80;
  produtospp:=35;
  FTextRel.Init(60);
  FTextRel.MargemEsquerda:=3;
  FTextRel.Titulo.Clear;
  FTextRel.ClearColunas;
  ListaTexto:=TStringlist.create;
  if QBusca=nil then
    QBusca:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao )'+
                        ' where movd_numerodoc='+EdNumerodoc.assql+' and movd_status=''N'' and movd_unid_codigo='+EdUnid_codigo.assql+
                        ' and movd_tipomov='+Stringtosql(Tipomov)+
                        ' order by movd_ordem')
  else
    QBusca.first;
  Arq.TUnidades.Locate('unid_codigo',QBusca.Fieldbyname('Mova_Unid_codigo').Asstring,[]);
  QClientes:=sqltoquery('select * from clientes where clie_codigo='+QBusca.Fieldbyname('Mova_tipo_codigo').Asstring );

  FTextRel.AddTitulo(FGeral.Centra('Entrada de Abate',largura),true,False,false);
//  FTextrel.SaltaLinha(1);
  FTextRel.AddTitulo('Carregamento : '+QBusca.fieldbyname('mova_dtcarrega').Asstring+space(33)+
                      'Número     : '+QBusca.fieldbyname('mova_numerodoc').Asstring,false,False,false);
  FTextRel.AddTitulo('Abate        : '+QBusca.fieldbyname('mova_dtabate').Asstring+space(33)+
                      'Vencimento : '+QBusca.fieldbyname('mova_dtvenci').Asstring,false,False,false);
  FTextRel.AddTitulo(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
  FTextRel.AddTitulo('Produtor.....: '+QClientes.fieldbyname('clie_nome').AsString,false,False,false);
  FTextRel.AddTitulo('Codigo.......: '+QClientes.Fieldbyname('clie_codigo').Asstring,false,False,false);
  FTextRel.AddTitulo('Razão Social : '+strspace(QClientes.Fieldbyname('clie_razaosocial').Asstring,43)+
                      'Tel.:'+FGeral.Formatatelefone(QClientes.Fieldbyname('clie_foneres').Asstring)
                      ,false,False,false);
  FTextRel.AddTitulo('Cep/Cidade/UF: '+FGeral.formatacep(QClientes.Fieldbyname('clie_cepres').Asstring)+' - '+
                      Arq.TMunicipios.Fieldbyname('cida_nome').Asstring+' - '+
                      strspace(Arq.TMunicipios.Fieldbyname('cida_uf').Asstring,02)
                      ,false,False,false);
  FTextRel.AddTitulo(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
  FTextRel.AddTitulo(' Ordem Codigo'+space(03)+'Descrição'+space(17)+'Brinco'+space(01)+'Idade'+space(1)+'Peso Vivo'+
                      space(01)+'Peso Carcaça'+space(01)+'% Rend.'+space(01)+'Arroba'+space(04)+'Vlr Total'+space(02)+'Obs'
                      ,false,False,true);
  FTextRel.AddTitulo(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);

  tpesovivo:=0;tpesocarcaca:=0;tvalortotal:=0;
  Lista:=TList.create;
  perfunrural:=FGeral.Getconfig1asfloat('perfunrural');
// 15.01.2010
//  if QClientes.fieldbyname('clie_tipo').AsString='J' then
 //   perfunrural:=FGeral.Getconfig1asfloat('perfunruraljur');
// 19.05.10
  if QClientes.FieldByName('clie_tipo').AsString='J' then
      perfunrural:=FGeral.Getconfig1asfloat('perfunruraljur');
// 05.05.10 - produtor rural Nao empregador - Novi - vava
  if QClientes.FieldByName('clie_aliinsspro').Ascurrency=99 then
      perfunrural:=0
  else if QClientes.FieldByName('clie_aliinsspro').Ascurrency>0 then
      perfunrural:=QClientes.FieldByName('clie_aliinsspro').Ascurrency;

  percotacapital:=FGeral.Getconfig1asfloat('percotacapital');
  datacont:=Qbusca.FieldByName('mova_datacont').asdatetime;
  while not QBusca.Eof do begin

    if QBusca.Fieldbyname('Movd_pesovivo').AsCurrency>0 then
      rend:=( QBusca.Fieldbyname('Movd_pesocarcaca').AsCurrency/QBusca.Fieldbyname('Movd_pesovivo').AsCurrency ) *100
    else
      rend:=0;
    FTextRel.AddLinha(strzero(QBusca.fieldbyname('movd_ordem').asinteger,3)+space(01)+strspace(QBusca.Fieldbyname('Movd_esto_codigo').AsString,08)+space(01)+
                    strspace(FEstoque.GetDescricao(QBusca.Fieldbyname('Movd_esto_codigo').AsString),25)+space(01)+
                    strspace(QBusca.Fieldbyname('Movd_brinco').AsString,08)+space(01)+
                    strspace(QBusca.Fieldbyname('Movd_idade').AsString,03)+space(01)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Movd_pesovivo').AsCurrency,'##,##0.00')+space(04)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Movd_pesocarcaca').AsCurrency,'##,##0.00')+space(02)+
                    FGeral.Formatavalor(rend,'##0.00')+space(01)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Movd_vlrarroba').AsCurrency,'##0.00')+space(03)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Movd_pesocarcaca').AsCurrency*(QBusca.Fieldbyname('Movd_vlrarroba').AsCurrency/divarrobakilo),'###,##0.00')+space(02)+
                    strspace(QBusca.Fieldbyname('Movd_obs').AsString,30)
                    ,false,False,true);
    ListaTexto.add(strzero(QBusca.fieldbyname('movd_ordem').asinteger,3)+space(01)+strspace(QBusca.Fieldbyname('Movd_esto_codigo').AsString,08)+space(01)+
                    strspace(FEstoque.GetDescricao(QBusca.Fieldbyname('Movd_esto_codigo').AsString),25)+space(01)+
                    strspace(QBusca.Fieldbyname('Movd_brinco').AsString,08)+space(01)+
                    strspace(QBusca.Fieldbyname('Movd_idade').AsString,03)+space(01)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Movd_pesovivo').AsCurrency,'##,##0.00')+space(04)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Movd_pesocarcaca').AsCurrency,'##,##0.00')+space(02)+
                    FGeral.Formatavalor(rend,'##0.00')+space(01)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Movd_vlrarroba').AsCurrency,'##0.00')+space(03)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Movd_pesocarcaca').AsCurrency*(QBusca.Fieldbyname('Movd_vlrarroba').AsCurrency/divarrobakilo),'###,##0.00')+space(02)+
                    strspace(QBusca.Fieldbyname('Movd_obs').AsString,30) );
    Atualiza(QBusca.Fieldbyname('Movd_esto_codigo').AsString,QBusca.Fieldbyname('Movd_vlrarroba').AsCurrency,
                                QBusca.Fieldbyname('Movd_pesovivo').AsCurrency,QBusca.Fieldbyname('Movd_pesocarcaca').AsCurrency);
    tpesovivo:=tpesovivo+QBusca.Fieldbyname('Movd_pesovivo').AsCurrency;
    tpesocarcaca:=tpesocarcaca+QBusca.Fieldbyname('Movd_pesocarcaca').AsCurrency;
    tvalortotal:=tvalortotal+ ( QBusca.Fieldbyname('Movd_pesocarcaca').AsCurrency*(QBusca.Fieldbyname('Movd_vlrarroba').AsCurrency/divarrobakilo) );
    QBusca.Next;
  end;

////////////////////  FGeral.EnviaEMail('andre@rpinfo.com.br','Relatório Gerencial','',Listatexto);


  if tpesovivo>0 then
    rend:=( tpesocarcaca/tpesovivo ) *100
  else
    rend:=0;
  FTextRel.AddLinha(Replicate('-',118),false,False,true);
  FTextRel.AddLinha(space(51)+FGeral.Formatavalor(tpesovivo,'###,##0.00')+space(03)+
                    FGeral.Formatavalor(tpesocarcaca,'###,##0.00')+space(02)+
                    FGeral.Formatavalor(rend,'##0.00')+space(10)+
                    FGeral.Formatavalor(tvalortotal,'###,##0.00')
                   ,false,False,true);
  if datacont>1 then begin
    valorfunrural:=tvalortotal*(perfunrural/100);
    if QClientes.FieldByName('clie_ativo').asstring='S' then
      valorcotacapital:=tvalortotal*(percotacapital/100)
    else
      valorcotacapital:=0;
  end else begin
    valorcotacapital:=0;
    valorfunrural:=0;
  end;
  FTextRel.SaltaLinha(2);
  if lista.count>0 then begin
    FTextRel.AddLinha(space(36)+'Peso Vivo'+space(01)+'Peso Carcaça'+space(01)+'% Rend.'+space(07)+'Total'+space(01)+'Médio Unitário',false,False,true);
    FTextRel.AddLinha(Replicate('-',118),false,False,true);
  end;
  for i:=0 to Lista.count-1 do begin
    PProdutos:=Lista[i];
    if PProdutos.pesovivo>0 then
      rend:=( PProdutos.pesocarcaca/PProdutos.pesovivo ) *100
    else
      rend:=0;
    FTextRel.AddLinha(strspace(PProdutos.produto,08)+space(01)+
                    strspace(FEstoque.GetDescricao(PProdutos.produto),25)+space(01)+
                    FGeral.Formatavalor(pProdutos.pesovivo,'###,##0.00')+space(03)+
                    FGeral.Formatavalor(pProdutos.pesocarcaca,'###,##0.00')+space(01)+
                    FGeral.Formatavalor(rend,'##0.00')+space(03)+
                    FGeral.Formatavalor(PProdutos.valortotal,'###,##0.00')+space(07)+
                    FGeral.Formatavalor(PProdutos.valortotal/pProdutos.pesocarcaca,'#,##0.00')
                   ,false,False,true);
  end;

  FTextRel.AddLinha(Replicate('-',118),false,False,true);
  FTextRel.SaltaLinha(2);
  FTextRel.AddLinha('Funrural '+space(01)+
                    FGeral.Formatavalor(valorfunrural,'##,##0.00')+space(01)+
                    '('+FGeral.Formatavalor(perfunrural,'%#0.00')+')'+space(02)+
                    'Cota Capital '+
                    FGeral.Formatavalor(valorcotacapital,'##,##0.00')+space(01)+
                    '('+FGeral.Formatavalor(percotacapital,'%#0.00')+')'+
                    space(04)+'Total a Receber '+
                    FGeral.Formatavalor(tvalortotal-(valorfunrural+valorcotacapital),'###,##0.00')
                   ,false,False,true);
  FTextRel.AddLinha(Replicate('-',118),false,False,true);

  FTextRel.Video;
  QClientes.Close;
  Freeandnil(QClientes);
  Sistema.EndProcess('');
//  QBusca.Close;
//  Freeandnil(QBusca);
}
//////////////////////////////////////////////////////////////////////////////////////////////

end;

procedure TFEntradaabate.bCancelarClick(Sender: TObject);
begin
   edcliente.setfocus;
end;

procedure TFEntradaabate.bexclusaoClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var Q,
    QR,
    QRa        :TSqlquery;
    Pesovivo   : currency;

begin

   if EdNumerodoc.asinteger<=0 then exit;
   if notagerada>0 then begin

      if Global.Usuario.OutrosAcessos[0065] then begin

        Aviso('Documento com nota fiscal/romaneio '+inttostr(notagerada)+' já gerada');

      end else begin

        Avisoerro('Documento com nota fiscal '+inttostr(notagerada)+' já gerada');
        exit;

      end;

   end;

   Q:=sqltoquery('select * from movabate where mova_numerodoc='+EdNumerodoc.assql+' and mova_status=''N'''+
                 ' and mova_tipomov='+Stringtosql(Tipomov) );

   if (not Q.eof)  then begin

     if Confirma('Confirma exclusão') then begin

       Sistema.beginprocess('Gravando');

       Sistema.Edit('movabate');
       Sistema.Setfield('mova_status','C');
       Sistema.post('mova_transacao='+stringtosql(Q.fieldbyname('mova_transacao').asstring));
       Sistema.Edit('movabatedet');
       Sistema.Setfield('movd_status','C');
       Sistema.post('movd_transacao='+stringtosql(Q.fieldbyname('mova_transacao').asstring));
// 14.05.19 -> 28.05.19 - aqui é pra retornar o romaneio no 'modo desajustado'
//       if Tipomov='EA' then  begin
// 19.10.20 - Novicarnes - Isonel
       if Ansipos( Tipomov, 'EA/FA' ) > 0 then  begin

          Qr:=sqltoquery('select mova_carga,mova_transacao,mova_perc from movabate '+
                         'where mova_notagerada = '+inttostr(Q.FieldByName('mova_numerodoc').AsInteger)+
                         ' and mova_tipomov = '+Stringtosql(TipoFazenda)+
                         ' and mova_unid_codigo = '+Stringtosql(Q.FieldByName('mova_unid_codigo').AsString)+
                         ' and mova_tipo_codigo = '+Inttostr(Q.FieldByName('mova_tipo_codigo').AsInteger)+
                         ' and mova_status <> ''C''');
           if not Qr.Eof then begin

             if Q.FieldByName('mova_perc').AsCurrency>0 then begin

               Sistema.Edit('movabate');
               Sistema.SetField('mova_notagerada',0);
// 11.11.20
               Sistema.post('mova_numerodoc = '+(Q.fieldbyname('mova_carga').asstring)+
                         ' and mova_tipomov = '+Stringtosql(TipoFazenda)+
                         ' and mova_unid_codigo = '+Stringtosql(Q.FieldByName('mova_unid_codigo').AsString)+
                         ' and mova_tipo_codigo = '+Inttostr(Q.FieldByName('mova_tipo_codigo').AsInteger)+
                         ' and mova_status <> ''C''');

               Qra:=sqltoquery('select movd_pesovivo,movd_operacao from movabatedet '+
                         'where movd_transacao = '+Stringtosql(QR.FieldByName('mova_transacao').AsString)+
                         ' and movd_tipomov = '+Stringtosql(TipoFazenda)+
                         ' and movd_unid_codigo = '+Stringtosql(Q.FieldByName('mova_unid_codigo').AsString)+
                         ' and movd_tipo_codigo = '+Inttostr(Q.FieldByName('mova_tipo_codigo').AsInteger)+
                         ' and movd_status <> ''C''');

               while not QRa.Eof do begin

                 Sistema.Edit('movabatedet');
                 pesovivo:= Qra.FieldByName('movd_pesovivo').AsCurrency  -
                           (Qra.FieldByName('movd_pesovivo').AsCurrency *
                           (Q.FieldByName('mova_perc').AsCurrency/Qra.FieldByName('movd_pesovivo').AsCurrency));
                 Sistema.SetField('movd_pesovivo',pesovivo);
                 Sistema.SetField('movd_pesocarcaca',pesovivo/2);
                 Sistema.post('movd_operacao='+stringtosql(Qra.fieldbyname('movd_operacao').asstring));
                 Qra.Next;

               end;

               FGEral.FechaQuery(Qra);

             end;

           end;

           FGeral.FechaQuery(Qr);

       end;

       Sistema.commit;
       FGeral.Gravalog(20,'excluido numero '+EdNumerodoc.text+' cliente '+Edcliente.text+' '+FGeral.GetNomeRazaoSocialEntidade(EdCliente.asinteger,'C','N'));
       Sistema.endprocess('');
       Grid.clear;
       EdNumerodoc.clearall(FEntradaabate,99);
       EdNumerodoc.setfocus;

     end;

   end else

     Avisoerro('Entrada não encontrada');
   Q.close;
   Freeandnil(Q);
end;

// 01.06.18
procedure TFEntradaabate.bajustapesosClick(Sender: TObject);
///////////////////////////////////////////////////////////////////
var indice         :extended;
    totalpesovivo,
    pesovivo,
    totalremessa,
    unitario       :currency;
    Numero,
    Linha          : integer;
    xTipomov       :string;
    QDet           :TSqlquery;

begin

   if EdTotalPesado.AsCurrency=0 then begin
     Avisoerro('Informar total pesado');
     exit;
   end;
   if EdTotalpesovivo.AsCurrency=0 then begin
     Avisoerro('Total vivo está zerado.   Verificar');
     exit;
   end;

   indice:=FGEral.Arredonda( EdTotalPesado.AsCurrency/EdTotalPesovivo.AsCurrency,5);

   if not confirma('Criar outro romaneio com índice '+FloatToStr(indice)+ ' ?') then exit;

   xTipoMov:=TipoEntradaAbate;

   Sistema.BeginProcess('Criando romaneio com peso ajustado');
   Transacao:=Global.CodigoUnidade+ Inttostr( FGeral.GetContador('TRANEA'+EdUnid_codigo.text,false) );
//   Numero:=FGeral.GetContador('FAZENDA',false);
   Numero:=FGeral.GetContador('ENTABATE',false);
   totalpesovivo:=0;
   totalremessa :=0;

   for linha:=1 to Grid.rowcount do begin

    if trim(Grid.Cells[0,linha])<>'' then begin

        Sistema.Insert('movabatedet');
        Sistema.SetField('movd_esto_codigo',Grid.cells[Grid.getcolumn('movd_esto_codigo'),linha]);
        Sistema.SetField('movd_transacao',transacao);
        Sistema.SetField('movd_operacao',transacao+Grid.cells[Grid.getcolumn('movd_ordem'),linha]);
        Sistema.SetField('movd_numerodoc',numero );
        Sistema.SetField('movd_status','N');
        Sistema.SetField('movd_tipomov',xTipoMov);
        Sistema.SetField('movd_unid_codigo',EdUnid_codigo.text);
        Sistema.SetField('movd_tipo_codigo',EdCliente.AsInteger);
//        Sistema.SetField('movd_tipocad','C');
        Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),linha]);
        Sistema.SetField('movd_idade',Grid.cells[Grid.getcolumn('movd_idade'),linha]);

        pesovivo:=Texttovalor(Grid.cells[Grid.getcolumn('movd_pesovivo'),linha])*indice;
        totalpesovivo:=totalpesovivo+pesovivo;
        Sistema.SetField('movd_pesovivo',pesovivo);
//        Sistema.SetField('movd_pesocarcaca',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesocarcaca'),linha]));
// 14.06.18
        Sistema.SetField('movd_pesocarcaca',pesovivo/2);
        unitario:=FGrupos.GetValorArroba(FEstoque.GetGrupo(Grid.cells[Grid.getcolumn('movd_esto_codigo'),linha]),
                                          PesoVivo,
                                          Grid.cells[Grid.getcolumn('movd_esto_codigo'),linha],
                                          TipoFazenda) ;
        Sistema.SetField('movd_vlrarroba',unitario );

        totalremessa:=totalremessa+( (pesovivo)*unitario );

        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
        Sistema.SetField('movd_ordem',strtoint(Grid.cells[Grid.getcolumn('movd_ordem'),linha]));
        Sistema.SetField('movd_pecas',Texttovalor(Grid.cells[Grid.getcolumn('movd_pecas'),linha]));
// 30.09.13
        Sistema.SetField('movd_baia',Grid.cells[Grid.getcolumn('movd_baia'),linha]);
        Sistema.SetField('movd_seto_codigo',Grid.cells[Grid.getcolumn('movd_seto_codigo'),linha]);
// 08.04.18
        Sistema.SetField('movd_datamvto',EdDtabate.AsDate);
        Sistema.Post('');

     end;
   end;

   Sistema.Insert('movabate');
    Sistema.SetField('mova_transacao',Transacao);
    Sistema.SetField('mova_operacao',Transacao+'01');
    Sistema.SetField('mova_status','N');
    Sistema.SetField('mova_numerodoc',Numero);
    Sistema.SetField('mova_tipomov',xTipoMov);
    Sistema.SetField('mova_unid_codigo',EdUnid_codigo.text);
    Sistema.SetField('mova_tipo_codigo',EdCliente.AsInteger);
//    Sistema.SetField('mova_tipocad','C');
    Sistema.SetField('mova_datalcto',Sistema.Hoje);
    Sistema.SetField('mova_dtabate',EdDtabate.asdate);
    Sistema.SetField('mova_dtcarrega',EdDtcarrega.asdate);
    Sistema.SetField('mova_dtvenci',EdVencimento.asdate);
    Sistema.SetField('mova_notagerada',0);
    Sistema.SetField('mova_transacaogerada','');
    Sistema.SetField('mova_pesovivo',Totalpesovivo);
    Sistema.SetField('mova_pesocarcaca',Totalpesovivo/2);
    Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('mova_datacont',EdDtMovimento.asdate);
    Sistema.SetField('mova_situacao','P');
    Sistema.SetField('mova_tran_codigo',EdTran_codigo.text);
    Sistema.SetField('mova_fpgt_codigo',EdFpgt_codigo.text);
    Sistema.SetField('Mova_repr_codigo',EdRepr_codigo.AsInteger);
    Sistema.SetField('Mova_vlrtotal',TotalRemessa);
    Sistema.SetField('Mova_perccomissao',EdPercComissao.ascurrency);
    Sistema.SetField('Mova_vlrgta',Edvalorgta.ascurrency);
// 28.05.19 - para que quando exclui o romaneio 'ajustado' posso voltar e
//            desajustar  o romaneio q foi ajustado
    Sistema.SetField('Mova_carga',EdNumerodoc.asinteger);
    Sistema.SetField('Mova_perc',indice);

    Sistema.Post();

// 08.07.18 - deixar o romaneio 'original' tbem com o peso corrigido
//  e para nao aparecer mais 'no f2'
    QDet:=sqltoquery('select mova_transacao,movd_operacao,movd_pesovivo from movabatedet inner join movabate on ( mova_transacao=movd_transacao )'+
                        ' where movd_numerodoc='+EdNumerodoc.assql+' and movd_status=''N'''+
                        ' and '+FGeral.GetIN('movd_tipomov',Tipomov+';'+TipoPesagem,'C')+
                        ' and '+FGeral.GetIN('mova_tipomov',Tipomov+';'+TipoPesagem,'C') );

    Sistema.Edit('movabate');
    Sistema.SetField('mova_pesovivo',Totalpesovivo);
//    Sistema.SetField('mova_notagerada',501501);
// 14.05.19 - para poder identificar o romaneio 'origem' do reajuste
    Sistema.SetField('mova_notagerada',numero);
    Sistema.Post('mova_transacao = '+Stringtosql(QDet.FieldByName('mova_transacao').AsString));


    while not QDet.eof do begin

        Sistema.Edit('movabatedet');
        pesovivo:=QDet.fieldbyname('movd_pesovivo').ascurrency*indice;
        Sistema.SetField('movd_pesovivo',pesovivo);
        Sistema.Post('movd_operacao = '+Stringtosql( QDet.fieldbyname('movd_operacao').asstring));
        QDet.Next;

    end;

   QDet.Close;

   try

     Sistema.Commit;
     Sistema.EndProcess('Criado romaneio '+inttostr(numero) );

   except

     Sistema.EndProcess('Não foi possível gravar');

   end;
    EdCliente.Clearall(FEntradaabate,99);
    EdProduto.Clearall(FEntradaabate,99);
    EdDtabate.setdate(sistema.hoje);
    EdDtmovimento.setdate(sistema.hoje);
    EdUnid_codigo.text:=Global.CodigoUnidade;
    EdDtcarrega.setdate(sistema.hoje-1);
    Grid.Clear;


end;

procedure TFEntradaabate.balterarClick(Sender: TObject);
begin

  if trim(Grid.cells[0,grid.row])='' then begin
    Avisoerro('Escolher um item primeiro');
    exit;
  end;
  PRemessa.Enabled:=false;
  OpBotao:='A';
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
  bCancelar.Enabled:=false;
  PINs.Visible:=true;
//  PINs.EnableEdits;
  PINs.Enabled:=true;
  LimpaEditsItens;
  EdProduto.text:=Grid.Cells[grid.getcolumn('movd_esto_codigo'),Grid.row];
  SetEdEsto_descricao.text:=Grid.Cells[grid.getcolumn('esto_descricao'),Grid.row];

  EdBrinco.text:=Grid.Cells[grid.getcolumn('movd_brinco'),Grid.row];
  EdIdade.text:=Grid.Cells[grid.getcolumn('movd_idade'),Grid.row];
  EdPesovivo.setvalue( texttovalor(Grid.Cells[grid.getcolumn('movd_pesovivo'),Grid.row]) );
  EdPesocarcaca.setvalue( texttovalor(Grid.Cells[grid.getcolumn('movd_pesocarcaca'),Grid.row]) );
  EdVlrarroba.setvalue( texttovalor(Grid.Cells[grid.getcolumn('movd_vlrarroba'),Grid.row]) );
  EdObs.text:=Grid.Cells[grid.getcolumn('movd_obs'),Grid.row];
// 27.09.16
  EdBaia.text:=Grid.Cells[grid.getcolumn('movd_baia'),Grid.row];
  EdSeto_codigo.text:=Grid.Cells[grid.getcolumn('movd_seto_codigo'),Grid.row];
// 16.10.08
//  EdMovd_pecas.setvalue( texttovalor(Grid.Cells[grid.getcolumn('movd_pecas'),Grid.row]) );
// 13.05.16
  EdMovd_pecas.setvalue ( texttovalor( grid.Cells[grid.getcolumn('movd_pecas'),Grid.row]) );
// 19.05.16
  if EdMovd_pecas.AsInteger=0 then EdMovd_pecas.setvalue(1);
// 02.10.2012
  QBuscae:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.Assql);

//    Grid.Cells[grid.getcolumn('move_seq'),Abs(x)]:=strzero(Seq,3);
// 19.06.06
  EdProduto.enabled:=false;
  if pos(Tipomov,TipoEntradaAbate+';'+TipoFazenda+';'+TipoPesagem+';'+TipoLote)>0 then
    EdBrinco.setfocus
// 26.11.10
//    EdProduto.setfocus
  else
    EdMovd_pecas.setfocus;
// 21.01.16
  if Global.Topicos[1316] then
    EdPesocarcaca.Enabled:=Global.Usuario.OutrosAcessos[0040]
  else
    EdPesocarcaca.Enabled:=true;
end;

procedure TFEntradaabate.FormActivate(Sender: TObject);
begin
  bCancelar.Enabled:=Op='A';
  bCancelaritem.Enabled:=true;
//  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if pos(OP,'A/D')>0 then begin
    DesativaEdits;
    EdNumerodoc.Enabled:=true;
    if OP='D' then
      bCancelaritem.Enabled:=false;
  end else begin
    AtivaEdits;
    if OP='I' then
      Ativabotoes;
    EdNumerodoc.Enabled:=false;
  end;
  if OP='D' then begin
    bIncluiritem.Enabled:=false;
    bExcluiritem.Enabled:=false;
    bCancelar.Enabled:=false;
    bGravar.Enabled:=false;
  end else begin
    bIncluiritem.Enabled:=true;
    bExcluiritem.Enabled:=true;
    bCancelar.Enabled:=true;
    bGravar.Enabled:=true;
  end;
  if Op='I' then begin
//    EdCliente.SetFocus;
    EdNumerodoc.Setvalue(0);
  end else
    EdNumerodoc.SetFocus;
//  EdUNid_codigo.text:=Global.CodigoUnidade;
//  EdUnid_codigo.validfind;

end;

procedure TFEntradaabate.DesativaEdits;
begin
  PRemessa.DisableEdits;
  EdNumerodoc.Enabled:=true;

end;

procedure TFEntradaabate.AtivaEdits;
//////////////////////////////////////
begin
  PRemessa.Enabled:=true;
  if OP='I' then begin
    PRemessa.EnableEdits;
    EdNumerodoc.Enabled:=false;
    EdCliente.Enabled:=true;
  end else begin
    EdNumerodoc.Enabled:=true;
  end;
end;

procedure TFEntradaabate.Ativabotoes;
begin
   bgravar.enabled:=true;
   bincluiritem.enabled:=true;
   bexcluiritem.enabled:=true;
   balterar.enabled:=true;
   bcancelaritem.enabled:=true;

end;

procedure TFEntradaabate.Desativabotoes;
begin
   bgravar.enabled:=false;
   bincluiritem.enabled:=false;
   bexcluiritem.enabled:=false;
   balterar.enabled:=false;
   bcancelaritem.enabled:=false;

end;

procedure TFEntradaabate.EdNumeroDocValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
var usuariocan:integer;
    obs,
    sqltipomovm,
    sqltipomovd :string;
    datamvto    :TDatetime;
begin

  notagerada:=0;
  sqltipomovd :=' and '+FGeral.GetIN('movd_tipomov',Tipomov+';'+TipoPesagem,'C');
  sqltipomovm :=' and '+FGeral.GetIN('mova_tipomov',Tipomov+';'+TipoPesagem,'C');
  if tipomov = TipoLote then begin
    sqltipomovd :=' and '+FGeral.GetIN('movd_tipomov',Tipomov,'C');
    sqltipomovm :=' and '+FGeral.GetIN('mova_tipomov',Tipomov,'C');
  end;

  if EdNumerodoc.AsInteger>0 then begin

     Sistema.Beginprocess('Pesquisando');
     QBusca:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao )'+
                        ' where movd_numerodoc='+EdNumerodoc.assql+' and movd_status=''N'''+
//                        ' and movd_tipomov='+Stringtosql(Tipomov)+
// 08.04.18
// 28.01.13
//                        ' and mova_tipomov='+Stringtosql(Tipomov)+
                        sqltipomovm+
                        sqltipomovd+
                        ' order by movd_ordem');
     if QBusca.eof then begin
       EdNUmerodoc.INvalid('Documento não encontrado');
       EdNumerodoc.ClearAll(FEntradaAbate,99);
       Sistema.endprocess('');
       Grid.Clear;
     end else begin
         if OP='A' then
           Transacao:=QBusca.fieldbyname('mova_transacao').asstring;
         notagerada:=QBusca.fieldbyname('mova_notagerada').asinteger;
// 10.05.18
         tipomov:=QBusca.FieldByName('movd_tipomov').AsString;
         QBusca:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao )'+
                        ' where movd_numerodoc='+EdNumerodoc.assql+' and movd_status=''N'''+
                        ' and '+FGeral.GetIN('movd_tipomov',Tipomov,'C')+
                        ' and '+FGeral.GetIN('mova_tipomov',Tipomov,'C')+
                        ' order by movd_ordem');
         Campostoedits(Qbusca);
         Campostogrid(Qbusca);
         ativabotoes;
         EdCliente.Valid;
         CalculaTotal;
  //       TotalRemessa:=EdTotalremessa.AsCurrency;
         EdUnid_codigo.ValidFind;
       end;
//       Edcliente.enabled:=false;
// 11.01.16 liberado alteracao codigo do produtor
// 12.06.19
       if Tipomov<>TipoLote then
          EdCliente.Enabled:=true;

       Sistema.endprocess('');
       if notagerada>0 then begin
         EdNumerodoc.invalid('Documento com nota fiscal '+inttostr(notagerada)+' já gerada');
       end;
     end;
  end;

procedure TFEntradaabate.Campostoedits(Q: TSqlquery);
//////////////////////////////////////////////////////
begin

  EdCliente.Text:=Q.fieldbyname('mova_tipo_codigo').AsString;
  EdUnid_codigo.Text:=Q.fieldbyname('mova_unid_codigo').AsString;
  EdDtAbate.SetDate(Q.fieldbyname('mova_dtabate').AsDateTime);
  EdVencimento.SetDate(Q.fieldbyname('mova_dtvenci').AsDateTime);
  EddtMovimento.SetDate(Q.fieldbyname('mova_datacont').AsDateTime);
  EdTotalpesovivo.SetValue(Q.fieldbyname('mova_pesovivo').AsCurrency);
  EdTotalcarcaca.SetValue(Q.fieldbyname('mova_pesocarcaca').AsCurrency);
// 17.02.10
  EdFpgt_codigo.text:=Q.fieldbyname('mova_fpgt_codigo').AsString;
  EdTran_codigo.text:=Q.fieldbyname('mova_tran_codigo').AsString;
  EdFpgt_codigo.ValidFind;
  EdTran_codigo.ValidFind;
///
  EdUnid_codigo.ValidateEdit;
  EdCliente.ValidateEdit;
  EdRepr_codigo.text:=Q.fieldbyname('mova_repr_codigo').AsString;
  EdPercComissao.setvalue(Q.fieldbyname('mova_perccomissao').AsCurrency);
  EdRepr_codigo.ValidFind;
// 12.06.19
  Edmova_ganhopeso.SetValue(Q.fieldbyname('mova_ganhopeso').AsCurrency);
  EdBaiageral.Text := Q.fieldbyname('movd_baia').AsString;
// 17.06.19
  EdMova_kmi.setvalue( Q.fieldbyname('mova_kmi').AsInteger );
  EdMova_kmf.setvalue( Q.fieldbyname('mova_kmf').AsInteger );

end;

procedure TFEntradaabate.Campostogrid(Q: TSqlquery);
/////////////////////////////////////////////////////////////////
var p:integer;
    rend:currency;
begin
  Grid.Clear;p:=1;Q.First;

  while not Q.Eof do begin

    Grid.Cells[grid.getcolumn('movd_ordem'),Abs(p)]:=strzero(Q.fieldbyname('movd_ordem').AsInteger,3);
    Grid.Cells[grid.getcolumn('movd_esto_codigo'),Abs(p)]:=Q.fieldbyname('movd_esto_codigo').Asstring;
    Grid.Cells[grid.getcolumn('esto_descricao'),Abs(p)]:=FEstoque.GetDescricao(Q.fieldbyname('movd_esto_codigo').Asstring);
    Grid.Cells[grid.getcolumn('movd_brinco'),Abs(p)]:=Q.fieldbyname('movd_brinco').Asstring;
    Grid.Cells[grid.getcolumn('movd_idade'),Abs(p)]:=Q.fieldbyname('movd_idade').Asstring;
    Grid.Cells[grid.getcolumn('movd_pesovivo'),Abs(p)]:=TRansform(Q.fieldbyname('movd_pesovivo').Ascurrency,f_cr);
    Grid.Cells[grid.getcolumn('movd_pesocarcaca'),Abs(p)]:=TRansform(Q.fieldbyname('movd_pesocarcaca').Ascurrency,f_cr);
    if Q.fieldbyname('movd_pesovivo').Ascurrency>0 then
      rend:=( Q.fieldbyname('movd_pesocarcaca').Ascurrency/Q.fieldbyname('movd_pesovivo').Ascurrency ) *100
    else
      rend:=0;
    Grid.Cells[grid.getcolumn('rendimento'),Abs(p)]:=TRansform(rend,f_cr);
    Grid.Cells[grid.getcolumn('movd_vlrarroba'),Abs(p)]:=TRansform(Q.fieldbyname('movd_vlrarroba').Ascurrency,f_cr);

    Grid.Cells[grid.getcolumn('totalitem'),Abs(p)]:=TRansform(Q.fieldbyname('movd_pesocarcaca').Ascurrency*(Q.fieldbyname('movd_vlrarroba').Ascurrency/divarrobakilo),f_cr);

    Grid.Cells[grid.getcolumn('movd_obs'),Abs(p)]:=Q.fieldbyname('movd_obs').Asstring;
    Grid.Cells[grid.getcolumn('movd_pecas'),Abs(p)]:=TRansform(Q.fieldbyname('movd_pecas').Ascurrency,'#####0.00');
// 03.10.13
    Grid.Cells[grid.getcolumn('movd_baia'),Abs(p)]:=Q.fieldbyname('movd_baia').Asstring;
    Grid.Cells[grid.getcolumn('movd_seto_codigo'),Abs(p)]:=Q.fieldbyname('movd_seto_codigo').Asstring;

    inc(p);
    Grid.AppendRow;
    Q.Next;
  end;
end;

function TFEntradaabate.EntradaFaturada(Numero: integer): boolean;
var Q:Tsqlquery;
begin
  Q:=sqltoquery('select * from movabate where mova_numerodoc='+inttostr(numero)+' and mova_status=''N'''+
                ' and mova_unid_codigo='+EdUnid_codigo.assql+' and mova_tipomov='+Stringtosql(Tipomov) );
  if Q.eof then
    result:=false
  else begin
    if Q.FieldByName('mova_notagerada').asinteger>0 then
      result:=true
    else
      result:=false;
  end;
  Q.close;
  Freeandnil(Q);

end;

procedure TFEntradaabate.brateioClick(Sender: TObject);
var Q:TSqlquery;

   procedure GeraRomaneio(xperc,xperc1:currency );
   var Numero:integer;
       perc:currency;
   var linha:integer;
   begin
//      Numero:=FGeral.GetContador('ENTABATE',false);
      if Tipomov=TipoEntradaAbate then
        Numero:=FGeral.GetContador('ENTABATE',false)
      else
        Numero:=FGeral.GetContador('SAIABATE',false);
      Transacao:=Global.CodigoUnidade+ Inttostr( FGeral.GetContador('TRANEA'+EdUnid_codigo.text,false) );
///////////////////////////////////////////////////////////////////
      if xperc>0 then
        perc:=xperc
      else
        perc:=xperc1;
// Mestre
      Sistema.Insert('Movabate');
      Sistema.SetField('mova_transacao',Transacao);
      Sistema.SetField('mova_operacao',Transacao+'01');
      Sistema.SetField('mova_status','N');
      Sistema.SetField('mova_numerodoc',Numero);
      Sistema.SetField('mova_tipomov',TipoMov);
      Sistema.SetField('mova_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('mova_tipo_codigo',EdCliente.AsInteger);
  //    Sistema.SetField('mova_tipocad','C');
      Sistema.SetField('mova_datalcto',Sistema.Hoje);
      Sistema.SetField('mova_dtabate',EdDtabate.asdate);
      Sistema.SetField('mova_dtcarrega',EdDtcarrega.asdate);
      Sistema.SetField('mova_dtvenci',EdVencimento.asdate);
      Sistema.SetField('mova_notagerada',0);
      Sistema.SetField('mova_transacaogerada','');
      Sistema.SetField('mova_pesovivo',EdTotalpesovivo.ascurrency*(Perc/100) );
      Sistema.SetField('mova_pesocarcaca',EdTotalcarcaca.ascurrency*(Perc/100) );
      Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
      if xPerc>0 then
        Sistema.SetField('mova_datacont',EdDtMovimento.asdate);
      Sistema.SetField('mova_situacao','N');
      Sistema.Post();
///////////////////////////////////////////////////////////////////
// Detalhe
      for linha:=1 to Grid.rowcount do begin
        if trim(Grid.Cells[0,linha])<>'' then begin
            Sistema.Insert('movabatedet');
            Sistema.SetField('movd_esto_codigo',Grid.cells[Grid.getcolumn('movd_esto_codigo'),linha]);
            Sistema.SetField('movd_transacao',transacao);
            Sistema.SetField('movd_operacao',transacao+Grid.cells[Grid.getcolumn('movd_ordem'),linha]);
            Sistema.SetField('movd_numerodoc',numero);
            Sistema.SetField('movd_status','N');
            Sistema.SetField('movd_tipomov',TipoMov);
            Sistema.SetField('movd_unid_codigo',EdUnid_codigo.text);
            Sistema.SetField('movd_tipo_codigo',EdCliente.AsInteger);
    //        Sistema.SetField('movd_tipocad','C');
            Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),linha]);
            Sistema.SetField('movd_idade',Grid.cells[Grid.getcolumn('movd_idade'),linha]);
            Sistema.SetField('movd_pesovivo',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesovivo'),linha]) * (Perc/100) );
            Sistema.SetField('movd_pesocarcaca',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesocarcaca'),linha])*(Perc/100) );
            Sistema.SetField('movd_vlrarroba',Texttovalor(Grid.cells[Grid.getcolumn('movd_vlrarroba'),linha]));
            Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
            Sistema.SetField('movd_ordem',strtoint(Grid.cells[Grid.getcolumn('movd_ordem'),linha]));
            Sistema.SetField('movd_pecas',Texttovalor(Grid.cells[Grid.getcolumn('movd_pecas'),linha]));
            Sistema.Post('');
        end;
      end;
///////////////////////////////////////////////////////////////////
   end;

begin

   if OP<>'A' then exit;
   if EdNumerodoc.isempty then exit;
   Q:=sqltoquery('select * from movabate'+
                 ' where mova_numerodoc='+EdNumerodoc.assql+' and mova_status=''N'' and mova_unid_codigo='+EdUnid_codigo.assql+
                 ' and mova_tipomov='+Stringtosql(Tipomov));
   if not Q.eof then begin
     if Q.fieldbyname('mova_situacao').asstring='N' then begin
       Avisoerro('Rateio já efetuado nesta entrada');
       exit;
     end;
   end;
   FGeral.fechaquery(Q);
   if not confirma('Confirma o rateio de '+EdPerc.text+' ? ') then exit;
   sistema.beginprocess('Efetuando rateio');
   if EdPerc.AsCurrency=0 then begin
     Sistema.Edit('movabate');
     Sistema.SetField('mova_situacao','N');
     Sistema.Setfield('mova_datacont',TExttodate('') );
     Sistema.Post('mova_numerodoc='+EdNumerodoc.assql+' and mova_unid_codigo='+EdUnid_codigo.assql+' and mova_status=''N''');
   end else if EdPerc.AsCurrency=100 then begin
     Sistema.Edit('movabate');
     Sistema.SetField('mova_situacao','N');
     Sistema.Setfield('mova_datacont',sistema.Hoje);
     Sistema.Post('mova_numerodoc='+EdNumerodoc.assql+' and mova_unid_codigo='+EdUnid_codigo.assql+' and mova_status=''N'''+
                  ' and mova_tipomov='+Stringtosql(Tipomov));
   end else begin
     Geraromaneio(EdPerc.ascurrency,0);
     Geraromaneio(0,100-EdPerc.ascurrency);
     Sistema.Edit('movabate');
     Sistema.SetField('mova_status','C');
     Sistema.Post('mova_numerodoc='+EdNumerodoc.assql+' and mova_unid_codigo='+EdUnid_codigo.assql+' and mova_status=''N'''+
                  ' and mova_tipomov='+Stringtosql(Tipomov) );
     Sistema.Edit('movabatedet');
     Sistema.SetField('movd_status','C');
     Sistema.Post('movd_numerodoc='+EdNumerodoc.assql+' and movd_unid_codigo='+EdUnid_codigo.assql+' and movd_status=''N'''+
                 ' and movd_tipomov='+Stringtosql(Tipomov) );
   end;
   try
     sistema.commit;
     sistema.EndProcess('Rateio terminado');
   except
     sistema.EndProcess('Rateio não gravado no banco de dados');
   end;
   Grid.clear;
   EdNumerodoc.ClearAll(FEntradaAbate,99);
   EdNumerodoc.SetFocus;
end;

// 17.10.19
procedure TFEntradaabate.brateiopesovivoClick(Sender: TObject);
///////////////////////////////////////////////////////////////////
var n       :integer;
    xproduto:string;
    xpesocarcaca,
    xpesovivo,
    xvaloruni   : currency;

begin

  if OP<>'A' then  exit;

  if EdTotalpesovivo.AsCurrency=0 then begin

     Avisoerro('Informar o total ref. peso vivo');
     Edtotalpesovivo.SetFocus;
     exit;

  end;

  if Edtotalpesovivo.AsCurrency<=EdTotalcarcaca.AsCurrency then begin

     Avisoerro('Peso vivo tem que ser MAIOR que peso da carcaça');
     Edtotalpesovivo.SetFocus;
     exit;

  end;

  if not confirma('Confirma rateio do peso vivo ?') then exit;

  Sistema.beginprocess('Atualizando pesos vivos');
  xvaloruni   := ( EdTotalcarcaca.AsCurrency/EdTotalPesovivo.AsCurrency ) ;

  for n:=1 to Grid.RowCount do begin

    xproduto    := Grid.Cells[grid.getcolumn('movd_esto_codigo'),n];

    if  ( trim(xproduto)<>'' ) then begin

      xpesocarcaca:= Texttovalor( Grid.Cells[grid.getcolumn('movd_pesocarcaca'),n] );
      xpesovivo   := xpesocarcaca/xvaloruni ;
      Grid.Cells[grid.getcolumn('movd_pesovivo'),n] := Valortosql( xpesovivo );

    end;

  end;

  Sistema.endprocess('peso vivo rateado');


end;

procedure TFEntradaabate.EdDtabateValidate(Sender: TObject);
begin
//  if OP='I' then
//    EdVencimento.setdate(EdDtabate.asdate+35);
// 04.02.09
    if  (Tipomov=TipoEntradaAbate) and (OP='I') then begin
      if EdCliente.resultfind.fieldbyname('clie_ativo').AsString<>'S' then
//        EdVencimento.setdate(sistema.hoje+30)
// 25.11.09 - Isonel - 37 e nao 35
        EdVencimento.setdate(EdDtAbate.AsDate+30)
//        FEntradaabate.EdVencimento.setdate(sistema.hoje+35)
      else
//        EdVencimento.setdate(EdDtAbate.AsDate+35);
// 06.12.10 - Novicarnes - Isonel via email
        EdVencimento.setdate(EdDtAbate.AsDate+30);
//        FEntradaabate.EdVencimento.setdate(sistema.hoje+30);
    end;

end;

procedure TFEntradaabate.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    if OP='A' then
      balterarclick(self);
  end;
end;

procedure TFEntradaabate.SetaEditEntradasAbate(Ed: TSqlEd);
///////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    Datainicial:TDatetime;
    opcao:boolean;
begin

   Ed.Items.Clear;
   DataInicial:=sistema.hoje-45;
   if tipomov=TipoLote then

      opcao:=false

   else
// 30.07.08
     opcao:=confirma('Consultar no F12 somente documentos EM ABERTO ?');

   if opcao then
     Q:=sqltoquery('select mova_numerodoc,mova_datacont,mova_tipo_codigo,clie_nome,mova_notagerada,'+
                   '(select count(*) from movabatedet  where mova_transacao=movd_transacao and movd_status=''N'') as items'+
//                 ' from movabate inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                 ' from movabate left join clientes on ( clie_codigo=mova_tipo_codigo )'+
                 ' where '+FGeral.Getin('mova_situacao','N;P','C')+
                 ' and  ( (mova_notagerada=0) or (mova_notagerada=null) )'+
//                 ' and '+FGeral.GetIN('mova_tipomov',Tipomov+';'+TipoPesagem,'C')+
// 17.05.18
                 ' and '+FGeral.GetIN('mova_tipomov',Tipomov,'C')+
                 ' and mova_dtabate>='+Datetosql(datainicial)+
                 ' and mova_status=''N'''+
                 ' and mova_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                 ' order by clie_nome,mova_numerodoc desc')
   else
     Q:=sqltoquery('select mova_numerodoc,mova_datacont,mova_tipo_codigo,clie_nome,mova_notagerada'+
//                 ' from movabate inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                 ' from movabate left join clientes on ( clie_codigo=mova_tipo_codigo )'+
                 ' where '+FGeral.Getin('mova_situacao','N;P','C')+
//                 ' and  (mova_notagerada=0 or mova_notagerada is null)'+
                 ' and '+FGeral.Getin('mova_tipomov',Tipomov+';'+TipoPesagem,'C')+
                 ' and mova_dtabate>='+Datetosql(datainicial)+
                 ' and mova_status=''N'''+
                 ' and mova_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                 ' order by mova_numerodoc desc');

   while not Q.Eof do begin

     if opcao then begin

       if Q.fieldbyname('items').asinteger>0 then begin
         if Q.fieldbyname('mova_notagerada').asinteger>0 then
           Ed.Items.add( strzero(Q.fieldbyname('mova_numerodoc').asinteger,8)+' '+FGeral.formatadata(Q.fieldbyname('mova_datacont').asdatetime)+
                      ' - '+strspace(Q.fieldbyname('clie_nome').asstring,35)+' - Nota Gerada '+strzero(Q.fieldbyname('mova_notagerada').asinteger,6) )
         else
           Ed.Items.add( strzero(Q.fieldbyname('mova_numerodoc').asinteger,8)+' '+FGeral.formatadata(Q.fieldbyname('mova_datacont').asdatetime)+
                      ' - '+strspace(Q.fieldbyname('clie_nome').asstring,35)+' - Sem Nota Gerada ' );
       end;
     end else begin
       if Q.fieldbyname('mova_notagerada').asinteger>0 then
         Ed.Items.add( strzero(Q.fieldbyname('mova_numerodoc').asinteger,8)+' '+FGeral.formatadata(Q.fieldbyname('mova_datacont').asdatetime)+
                    ' - '+strspace(Q.fieldbyname('clie_nome').asstring,35)+' - Nota Gerada '+strzero(Q.fieldbyname('mova_notagerada').asinteger,6) )
       else
         Ed.Items.add( strzero(Q.fieldbyname('mova_numerodoc').asinteger,8)+' '+FGeral.formatadata(Q.fieldbyname('mova_datacont').asdatetime)+
                    ' - '+strspace(Q.fieldbyname('clie_nome').asstring,35)+' - Sem Nota Gerada ' );
     end;
     Q.Next;
   end;
   fGeral.fechaquery(Q);
end;

procedure TFEntradaabate.blebalancaClick(Sender: TObject);
////////////////////////////////////////////////////////////////
begin
  if Tipomov<>TipoFazenda then begin
    if trim(qedit)<>'' then begin
      abrirporta;
    end else
      Avisoerro('Campo do peso ainda não habilitado para leitura');
  end;
end;

function TFEntradaabate.AbrirPorta: boolean;
////////////////////////////////////////////////
begin
    try
//     Serial.Open;
     result:=true;
     Acbrbal1.Ativar;
     SerialAberta:=true;
    except
//      Avisoerro('Problemas para abrir a porta '+Serial.DeviceName);
      Avisoerro('Problemas para abrir a porta '+AcbrBal1.Porta);
      result:=false;
    end;
end;

procedure TFEntradaabate.SerialRxChar(Sender: TObject; Count: Integer );
//////////////////////////////////////////////////////////////////////////////
var Buffer:array[1..1024] of char; s:String; i,q:Integer;
    tamstringlida:integer;
    valorlido:currency;

    Function TrataValorLidoBalanca(t:string):currency;
    begin
      if FGeral.GetConfig1AsInteger('MULTIBALANCA')>0 then
        result:=Texttovalor(t)*FGeral.GetConfig1AsInteger('MULTIBALANCA')
      else
        result:=Texttovalor(t);
    end;

begin
{
  Sleep(100);
  tamstringlida:=13;  // 8
  s:='';
  q:=serial.InQueCount;
  Serial.Read(Buffer,q);
  for i:=1 to q do begin
      if Buffer[i] in ['0'..'9'] then s:=s+Buffer[i];
  end;

  if Trim(s)<>'' then begin
//     EdPesocarcaca.Text:=LeftStr(s,tamstringlida);
     valorlido:=TrataValorLidoBalanca(LeftStr(s,tamstringlida));
     EdPesocarcaca.SetValue( valorlido  );
     if Global.Topicos[1318] then
       EdPesocarcaca.setvalue( round_(EdPesocarcaca.ascurrency,2) );

     if FGeral.GetConfig1AsInteger('DIVBALANCA')>0 then
        EdPesocarcaca.setvalue( (valorlido/FGeral.GetConfig1AsInteger('DIVBALANCA') ) - DescPeso )
     else
        EdPesocarcaca.setvalue( valorlido - DescPeso  );
//     lpeso.Caption:=EdPesocarcaca.text;
//     lpeso.Caption:=s;
     pmens.Caption:=LeftStr(s,tamstringlida);
     lpeso.Caption:=EdPesoCarcaca.Text;
  end;
  }
end;

procedure TFEntradaabate.EdPesovivoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
begin
  qedit:='pesocarcaca';
//  if (OP='I') and (Global.Topicos[1316]) then
//    blebalancaclick(self);
  if Tipomov=TipoFazenda then begin
     EdPesocarcaca.setvalue(EdPesovivo.ascurrency);
//     EdVlrarroba.setvalue( FGrupos.GetValorArroba(QBuscae.fieldbyname('esto_grup_codigo').AsInteger,EdPesoVivo.ascurrency,EdProduto.text) )
// 12.06.18
     EdVlrarroba.setvalue( FGrupos.GetValorArroba(QBuscae.fieldbyname('esto_grup_codigo').AsInteger,EdPesoVivo.ascurrency,EdProduto.text,Tipomov) )
  end;

end;



procedure TFEntradaabate.EdvlrarrobaEnter(Sender: TObject);
begin
{
  if Serial.Enabled then begin
    Serial.Close;
    SerialAberta:=false;
  end;
}
end;

function TFEntradaabate.EstaCodigosNaoVenda(produto: string): boolean;
var Lista:TStringlist;
    codigosnaovenda:string;
    p:integer;
begin
  if Tipomov=TipoSaidaAbate then begin
    codigosnaovenda:=FGeral.GetConfig1AsString('Produtosnaovenda');
    result:=false;
    if trim(codigosnaovenda)<>'' then begin
      Lista:=TStringlist.create;
      strtolista(Lista,codigosnaovenda,';',true);
      for p:=0 to Lista.count-1 do begin
        if trim(Lista[p])<>'' then begin
          if Lista[p]=produto then begin
            result:=true;
            break;
          end;
        end;
      end;
    end;
  end else
    result:=false;

end;

procedure TFEntradaabate.blebalanca2Click(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
  if Tipomov<>TipoFazenda then begin
    if trim(qedit)<>'' then begin
      abrirporta2;
    end else
      Avisoerro('Campo do peso ainda não habilitado para leitura');
  end;
end;

function TFEntradaabate.AbrirPorta2: boolean;
///////////////////////////////////////////////
begin
  try
//   Serial2.Open;
   Acbrbal2.Ativar;
   result:=true;
  except
//    Avisoerro('Problemas para abrir a porta '+Serial2.DeviceName);
    Avisoerro('Problemas para abrir a porta '+AcbrBal2.Porta);
    result:=false;
  end;

end;

procedure TFEntradaabate.Serial2RxChar(Sender: TObject; Count: Integer);
var Buffer:array[1..1024] of char; s:String; i,q:Integer;
begin
{
//  Sleep(100);
  Sleep(10);
  s:='';
  q:=serial.InQueCount;
  Serial2.Read(Buffer,q);
  for i:=1 to q do begin
      if Buffer[i] in ['0'..'9'] then s:=s+Buffer[i];
  end;

  if Trim(s)<>'' then begin
     if Global.Topicos[1316] then
       EdPesocarcaca.setvalue( round_(EdPesocarcaca.ascurrency,2) )
     else
       EdPesocarcaca.setvalue( ( texttovalor(LeftStr(s,08)) ) );

     if FGeral.GetConfig1AsInteger('DIVBALANCA')>0 then
        EdPesocarcaca.setvalue( ( texttovalor(LeftStr(s,08))/FGeral.GetConfig1AsInteger('DIVBALANCA') ) - DescPeso  )
     else
        EdPesocarcaca.setvalue( ( texttovalor(LeftStr(s,08)) ) - DescPeso );
     lpeso.Caption:=EdPesocarcaca.text
 end;
}

end;

procedure TFEntradaabate.ConfiguraBalanca;

  function GetBaudRate(veloc:integer;Serial:TComm):TBaudRate;
  begin
        case Veloc of
        {
             1200: FEntradaabate.Serial.BaudRate:=cbr1200;
             2400: FEntradaabate.Serial.BaudRate:=cbr2400;
             4800: FEntradaabate.Serial.BaudRate:=cbr4800;
             9600: FEntradaabate.Serial.BaudRate:=cbr9600;
             19200: FEntradaabate.Serial.BaudRate:=cbr19200;
             }
             1200: result:=cbr1200;
             2400: result:=cbr2400;
             4800: result:=cbr4800;
             9600: result:=cbr9600;
             19200: result:=cbr19200;
        end;
  end;

  function GetDataBits(databit:integer;Serial:TComm):TDataBits;
  begin
        case DataBit of
             4: result:=da4;
             5: result:=da5;
             6: result:=da6;
             7: result:=da7;
             8: result:=da8;
        end;
  end;

  function GetStopBits(stopbit:integer;Serial:TComm):TStopBits;
  begin
        case StopBit of
             10: result:=sb10;
             15: result:=sb15;
             20: result:=sb20;
        end;
  end;

// 27.08.10
  function GetParidade(paridade:string):TParity;
  begin
  {
       Case Paridade of
            'N': result:=paNone
            'E': result:=paEven
            'M': result:=paMark
            'O': result:=paOdd
            'S': result:=paSpace;
       end;
       }
       if Paridade='N' then result:=paNone
       else if Paridade='P' then result:=paEven
       else if Paridade='M' then result:=paMark
       else if Paridade='I' then result:=paOdd
       else if Paridade='S' then result:=paSpace;
  end;


begin
{
  if FGeral.GetConfig1AsString('portaserial')<>'' then
    FEntradaabate.Serial.DeviceName:=FGeral.GetConfig1AsString('portaserial');
  if FGeral.GetConfig1AsInteger('velocidadebal')>0 then
    FEntradaabate.Serial.BaudRate:=GetBaudRate(FGeral.GetConfig1AsInteger('velocidadebal'),Serial);
  if FGeral.GetConfig1AsInteger('databitsbal')>0 then
    FEntradaabate.Serial.Databits:=GetDataBits(FGeral.GetConfig1AsInteger('databitsbal'),Serial);
  if FGeral.GetConfig1AsInteger('stopbitsbal')>0 then
    FEntradaabate.Serial.Stopbits:=GetStopBits(FGeral.GetConfig1AsInteger('stopbitsbal'),Serial);
// 27.08.10
  if FGeral.GetConfig1AsString('paridade1')<>'' then
    FEntradaabate.Serial.Parity:=GetParidade(FGeral.GetConfig1AsString('paridade1'));

  if FGeral.GetConfig1AsString('portaserial2')<>'' then
    FEntradaabate.Serial2.DeviceName:=FGeral.GetConfig1AsString('portaserial2');
  if FGeral.GetConfig1AsInteger('velocidadebal2')>0 then
    FEntradaabate.Serial2.BaudRate:=GetBaudRate(FGeral.GetConfig1AsInteger('velocidadebal2'),Serial2);
  if FGeral.GetConfig1AsInteger('databitsbal2')>0 then
    FEntradaabate.Serial2.Databits:=GetDataBits(FGeral.GetConfig1AsInteger('databitsbal2'),Serial2);
  if FGeral.GetConfig1AsInteger('stopbitsbal2')>0 then
    FEntradaabate.Serial2.Stopbits:=GetStopBits(FGeral.GetConfig1AsInteger('stopbitsbal2'),Serial2);
// 27.08.10
  if FGeral.GetConfig1AsString('paridade2')<>'' then
    FEntradaabate.Serial2.Parity:=GetParidade(FGeral.GetConfig1AsString('paridade2'));
}

  { - opcoes para criar configuracao
     if not PortaSerial.IsEmpty and not SerialAberta then begin
        Serial.DeviceName:=PortaSerial.Text;   //Com1, Com2...
        case Velocidade.AsInteger of
             1200: Serial.BaudRate:=cbr1200;
             2400: Serial.BaudRate:=cbr2400;
             4800: Serial.BaudRate:=cbr4800;
             9600: Serial.BaudRate:=cbr9600;
             19200: Serial.BaudRate:=cbr19200;
        end;
        if      Paridade.Text='N' then Serial.Parity:=paNone
        else if Paridade.Text='E' then Serial.Parity:=paEven
        else if Paridade.Text='M' then Serial.Parity:=paMark
        else if Paridade.Text='O' then Serial.Parity:=paOdd
        else if Paridade.Text='S' then Serial.Parity:=paSpace;
        case DataBits.AsInteger of
             4: Serial.Databits:=da4;
             5: Serial.Databits:=da5;
             6: Serial.Databits:=da6;
             7: Serial.Databits:=da7;
             8: Serial.Databits:=da8;
        end;
        case StopBits.AsInteger of
             10: Serial.Stopbits:=sb10;
             15: Serial.Stopbits:=sb15;
             20: Serial.Stopbits:=sb20;
        end;
        Serial.Open;
        SerialAberta:=True;
     end;

}

end;

procedure TFEntradaabate.brelcargaClick(Sender: TObject);
begin
  FRelGerenciais_Carga(EdTran_codigo.text,EdUnid_codigo.text,tipomov);
  exit;

end;

procedure TFEntradaabate.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
//  if serial.Enabled then Serial.close;
//  if serial2.Enabled then Serial2.close;
end;

procedure TFEntradaabate.EdRepr_codigoValidate(Sender: TObject);
begin
  if ( EdRepr_codigo.resultfind<>nil ) and ( OP='I') then
    EdPerCcomissao.setvalue(  EdRepr_codigo.resultfind.fieldbyname('Repr_comissao').ascurrency );

end;

procedure TFEntradaabate.EdtotalpesadoChange(Sender: TObject);
begin

end;

// 24.04.13 - Novicarnes - 'bonus' da comissao
procedure TFEntradaabate.EdBaiageralValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
begin

   if EdBaiageral.ResultFind<>nil then begin
      Edmova_ganhopeso.SetValue( EdBaiageral.ResultFind.FieldByName('baia_ganhopeso').AsCurrency );
   end;

end;

// 08.05.18
procedure TFEntradaabate.EdbaiaValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin

   if (tipomov=TipoPesagem) and (  not EdBaia.IsEmpty ) then EdBaia.Enabled:=false;

end;

procedure TFEntradaabate.EdbonusComissaoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////////
var p:integer;
    vlrarroba,pesocarcaca:currency;
begin
  if OP='A' then begin
    for p:=1 to Grid.RowCount do  begin
        if trim(Grid.Cells[Grid.getcolumn('movd_vlrarroba'),p])<>'' then begin
          vlrarroba:=Texttovalor(Grid.Cells[Grid.getcolumn('movd_vlrarroba'),p])+EdBonuscomissao.ascurrency;
          pesocarcaca:=Texttovalor(Grid.Cells[Grid.getcolumn('movd_pesocarcaca'),p]);
          Grid.Cells[Grid.getcolumn('movd_vlrarroba'),p]:=transform(vlrarroba,f_cr);
          Grid.Cells[grid.getcolumn('totalitem'),p]:=TRansform( (Pesocarcaca*Vlrarroba)/divarrobakilo ,f_cr );
        end;
    end;
    CalculaTotal;
  end;
end;

procedure TFEntradaabate.ACBrBAL2LePeso(Peso: Double; Resposta: AnsiString);
/////////////////////////////////////////////////////////////////////////////
var valid : integer;
    xResposta,outra:string;
begin
   xResposta := copy( Resposta,3,15)  ;

   LPeso.Caption := xResposta ;

   if FGeral.GetConfig1AsInteger('DIVBALANCA')>0 then
        peso:=Texttovalor(xresposta)/FGeral.GetConfig1AsInteger('DIVBALANCA')
   else
        peso:=Texttovalor(xresposta);
    if Peso >= 0 then begin
//      PMens.Caption := 'Leitura OK !';
      PMens.Caption := resposta+' - '+xresposta;
      EdPesocarcaca.SetValue(peso);
      LPeso.Caption     := formatFloat('###0.00', Peso );
   end else
    begin
      valid := Trunc(AcbrBal1.UltimoPesoLido);
//      {
      case valid of
         0 : PMens.Caption := 'TimeOut !'+sLineBreak+
                                 'Coloque o produto sobre a Balança!' ;
        -1 : PMens.Caption := 'Peso Instavel ! ' +sLineBreak+
                                 'Tente Nova Leitura' ;
        -2 : PMens.Caption := 'Peso Negativo !' ;
       -10 : PMens.Caption := 'Sobrepeso !' ;
      end;
//      }
    end ;

end;

procedure TFEntradaabate.ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
///////////////////////////////////////////////////////////////
var valid : integer;
    xResposta,outra:string;
begin
   xResposta := copy( Resposta,3,15)  ;

   lPeso.Caption := xResposta ;
   if FGeral.GetConfig1AsInteger('DIVBALANCA')>0 then
        peso:=Texttovalor(xresposta)/FGeral.GetConfig1AsInteger('DIVBALANCA')
   else
        peso:=Texttovalor(xresposta);

    if Peso >= 0 then begin
      PMens.Caption := resposta+' - '+xresposta;
      EdPesocarcaca.SetValue(peso);
      lPeso.Caption     := formatFloat('###0.00', Peso );
   end else
    begin
      valid := Trunc(AcbrBal1.UltimoPesoLido);
//      {
      case valid of
         0 : PMens.Caption := 'TimeOut !'+sLineBreak+
                                 'Coloque o produto sobre a Balança!' ;
        -1 : PMens.Caption := 'Peso Instavel ! ' +sLineBreak+
                                 'Tente Nova Leitura' ;
        -2 : PMens.Caption := 'Peso Negativo !' ;
       -10 : PMens.Caption := 'Sobrepeso !' ;
      end;
//      }
    end ;

end;

procedure TFEntradaabate.ConfiguraBalancas;
////////////////////////////////////////////

  function GetBaudRate(veloc:integer;Serial:TComm):TBaudRate;
  begin
        case Veloc of
             1200: result:=cbr1200;
             2400: result:=cbr2400;
             4800: result:=cbr4800;
             9600: result:=cbr9600;
             19200: result:=cbr19200;
        end;
  end;

  function GetDataBits(databit:integer;Serial:TComm):TDataBits;
  ////////////////////////////////////////////////////////////
  begin
        case DataBit of
             4: result:=da4;
             5: result:=da5;
             6: result:=da6;
             7: result:=da7;
             8: result:=da8;
        end;
  end;

  function GetStopBits(stopbit:integer;Serial:TComm):TStopBits;
  //////////////////////////////////////////////////////////////
  begin
        case StopBit of
             10: result:=sb10;
             15: result:=sb15;
             20: result:=sb20;
        end;
  end;

  function GetStopBitsAcBR(stopbit:integer;Serial:TAcbrbal):TAcbrSerialStop;
  ///////////////////////////////////////////////////////////////////
  begin
        case StopBit of
             10: result:=s1;
             15: result:=s1eMeio;
             20: result:=s2;
        end;
  end;

  function GetParidade(paridade:string):TParity;
  /////////////////////////////////////////////////
  begin
       if Paridade='N' then result:=paNone
       else if Paridade='P' then result:=paEven
       else if Paridade='M' then result:=paMark
       else if Paridade='I' then result:=paOdd
       else if Paridade='S' then result:=paSpace;
  end;


  function GetParidadeAcBR(paridade:string):TAcbrSerialParity;
  /////////////////////////////////////////////////
  begin
       if Paridade='N' then result:=pNone
       else if Paridade='P' then result:=pEven
       else if Paridade='M' then result:=pMark
       else if Paridade='I' then result:=pOdd
       else if Paridade='S' then result:=pSpace;
  end;


//////////////////////////
begin
//////////////////////////
  if AcbrBal1.Ativo then
    AcbrBal1.Desativar;
  if AcbrBal2.Ativo then
    AcbrBal2.Desativar;

  if FGeral.GetConfig1AsString('PORTASERIAL')<>'' then
    AcbrBal1.Device.porta:=FGeral.GetConfig1AsString('PORTASERIAL');
  if FGeral.GetConfig1AsInteger('velocidadebal')>0 then
    AcbrBal1.Device.Baud := FGeral.GetConfig1AsInteger('velocidadebal');
  if FGeral.GetConfig1AsInteger('databitsbal')>0 then
    AcbrBal1.Device.Data :=FGeral.GetConfig1AsInteger('databitsbal');
  if FGeral.GetConfig1AsInteger('stopbitsbal')>0 then
    AcbrBal1.Device.Stop :=GetStopBitsAcBR( FGeral.GetConfig1AsInteger('stopbitsbal'),AcbrBal1);
  if FGeral.GetConfig1AsString('paridade1')<>'' then
    AcbrBal1.Device.Parity:=GetParidadeAcbr(FGeral.GetConfig1AsString('paridade1'));

   ACBrBAL1.Modelo           := TACBrBALModelo( balFilizola );
   ACBrBAL1.Device.HandShake := TACBrHandShake( hsNenhum );

// 02.03.15
  if FGeral.GetConfig1AsString('PORTASERIAL2')<>'' then
    AcbrBal2.Device.porta:=FGeral.GetConfig1AsString('PORTASERIAL2');
  if FGeral.GetConfig1AsInteger('velocidadebal2')>0 then
    AcbrBal2.Device.Baud := FGeral.GetConfig1AsInteger('velocidadebal2');
  if FGeral.GetConfig1AsInteger('databitsbal2')>0 then
    AcbrBal2.Device.Data :=FGeral.GetConfig1AsInteger('databitsbal2');
  if FGeral.GetConfig1AsInteger('stopbitsbal2')>0 then
    AcbrBal2.Device.Stop :=GetStopBitsAcBR( FGeral.GetConfig1AsInteger('stopbitsbal2'),AcbrBal1);
  if FGeral.GetConfig1AsString('paridade2')<>'' then
    AcbrBal2.Device.Parity:=GetParidadeAcbr(FGeral.GetConfig1AsString('paridade2'));

   ACBrBAL2.Modelo           := TACBrBALModelo( balFilizola );
   ACBrBAL2.Device.HandShake := TACBrHandShake( hsNenhum );


  { - opcoes para criar configuracao
     if not PortaSerial.IsEmpty and not SerialAberta then begin
        Serial.DeviceName:=PortaSerial.Text;   //Com1, Com2...
        case Velocidade.AsInteger of
             1200: Serial.BaudRate:=cbr1200;
             2400: Serial.BaudRate:=cbr2400;
             4800: Serial.BaudRate:=cbr4800;
             9600: Serial.BaudRate:=cbr9600;
             19200: Serial.BaudRate:=cbr19200;
        end;
        if      Paridade.Text='N' then Serial.Parity:=paNone
        else if Paridade.Text='E' then Serial.Parity:=paEven
        else if Paridade.Text='M' then Serial.Parity:=paMark
        else if Paridade.Text='O' then Serial.Parity:=paOdd
        else if Paridade.Text='S' then Serial.Parity:=paSpace;
        case DataBits.AsInteger of
             4: Serial.Databits:=da4;
             5: Serial.Databits:=da5;
             6: Serial.Databits:=da6;
             7: Serial.Databits:=da7;
             8: Serial.Databits:=da8;
        end;
        case StopBits.AsInteger of
             10: Serial.Stopbits:=sb10;
             15: Serial.Stopbits:=sb15;
             20: Serial.Stopbits:=sb20;
        end;
        Serial.Open;
        SerialAberta:=True;
     end;

}
end;

// 22.09.16
procedure TFEntradaabate.batubrincosClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var Qb:TSqlquery;
    n:integer;
    xbrinco,xproduto,
    xbrincos,
    xseq                            :string;
    xvaloruni,xpesocarcaca,xpesovivo:currency;
    gravar:boolean;

begin

  if not confirma('Confirma atualização ?') then exit;

  Sistema.beginprocess('Atualizando brincos');
  gravar:=false;
  xbrincos:='';

  for n:=1 to Grid.RowCount do begin

    xbrinco:=Grid.Cells[grid.getcolumn('movd_brinco'),n];
    xproduto:=Grid.Cells[grid.getcolumn('movd_esto_codigo'),n];
// converte preco pra arroba...
    xvaloruni:=Texttovalor( Grid.Cells[grid.getcolumn('movd_vlrarroba'),n] )/15;
    xpesocarcaca:=Texttovalor( Grid.Cells[grid.getcolumn('movd_pesocarcaca'),n] );
    xpesovivo:=Texttovalor( Grid.Cells[grid.getcolumn('movd_pesovivo'),n] );
    xseq     := Grid.Cells[grid.getcolumn('movd_ordem'),n];

    if ( trim(xbrinco)<>'' ) and ( trim(xproduto)<>'' ) then begin

      Qb:=sqltoquery('select movd_brinco,movd_operacao from movabatedet where movd_brinco = '+stringtosql(xbrinco)+
                     ' and movd_status = ''N'' and movd_tipomov='+Stringtosql(TipoFazenda));
// 26.10.16
// ´'quase nunca' é o mesmo codigo pois quando abate classifica em outro codigo
//                      and movd_esto_codigo = '+stringtosql(xproduto) );
      if not Qb.eof then begin

          gravar:=true;
          Sistema.edit('movabatedet');
// 24.05.18 - para puxar o peso vivo da fazenda e colocar no romaneio do abate
          if Tipomov=TipoEntradaAbate then begin

            Sistema.setfield('movd_dataabate',EdDtAbate.AsDate);
            Sistema.setfield('movd_vlrabate',xvaloruni );
            Sistema.setfield('movd_abatido','S');
            Sistema.setfield('movd_pesocarcaca',xpesocarcaca);
            Sistema.setfield('movd_pesovivoabate',xpesovivo);
            Sistema.setfield('movd_esto_codigoven',xproduto);

          end else begin

            Sistema.setfield('movd_pesovivoabate',Qb.FieldByName('movd_pesovivo').AsCurrency );

          end;

          Sistema.post('movd_brinco = '+stringtosql(xbrinco)+
// 21.12.17 - para prever reaproveitamento de brincos
// 12.11.20 - para ver se para de alguns brincos 'não achar
//                       ' and movd_abatido is null'+
                       ' and ( (movd_abatido <> ''S'') or (movd_abatido is null) )'+
                       ' and movd_status = ''N'' and movd_tipomov='+Stringtosql(TipoFazenda));
      end else begin

//          Aviso('Não encontrado romaneio com brinco '+xbrinco);
          xbrincos := xbrincos + xbrinco + ' ; ';
 // 23.04.20 - Isonel
          gravar:=false;

      end;

    end else if ( trim(xbrinco) = '' ) and ( trim(xproduto)<>'' ) then begin

          Avisoerro('Brinco não informado no codigo '+xproduto+' ordem '+xseq);

    end;


  end;

  if gravar then begin

     Sistema.Commit;
     Sistema.endprocess('brincos atualizados');

  end else

     Sistema.endprocess('brincos NÃO atualizados.  Brincos não encontrados : '+xbrincos);

end;



// 30.03.17
procedure TFEntradaabate.bbaixaClick(Sender: TObject);
/////////////////////////////////////////////////////
var ctransacao,cromaneio:string;
    Lista:TStringList;
    Q:Tsqlquery;
    xdata:TDatetime;

const xtipo:string='EA';

begin

   if (op<>'A') then begin
     Avisoerro('Entrar em alteração para poder baixar romaneio');
     exit;
   end;
   if (EdNumerodoc.IsEmpty) then begin
     Avisoerro('Informar o numero do romaneio a ser baixado');
     exit;
   end;
   Lista:=TStringList.Create;
   xData:=Sistema.Hoje-90;
   Q:=sqltoquery('select movabate.*,clie_nome from movabate'+
                 ' inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                 ' where mova_status <> ''C'''+
                 ' and mova_tipomov = '+stringtosql(xtipo)+
                 ' and mova_unid_codigo = '+EdUnid_codigo.AsSql+
                 ' and mova_tipo_codigo = '+Edcliente.AsSql+
// 17.05.18
                 ' and mova_situacao <> ''N'''+
//                 ' and mova_transacaogerada = '+Stringtosql('')+
                 ' and mova_dtabate >= '+DatetoSql(xdata) );
   while not Q.Eof do begin
     Lista.Add(strspace(Q.FieldByName('mova_transacao').AsString,12)+' | '+
               Q.FieldByName('mova_numerodoc').AsString+' ! '+
               strspace(Q.FieldByName('clie_nome').AsString,30)+' | '+
               FGeral.Formatavalor(Q.FieldByName('mova_vlrtotal').AsCurrency,f_cr));
     Q.Next;
   end;
   FGeral.FechaQuery(Q);
   if Lista.Count>0 then
     ctransacao:=SelecionaItems(Lista,'Romaneios','',false)
   else begin
     ctransacao:='';
     Avisoerro('Não encontrado romaneios para baixa');
   end;
   Lista.free;
   if trim(ctransacao)<>'' then begin

     if not confirma('Confirma a baixa ?') then exit;
     cromaneio:=trim(copy(ctransacao,pos('|',ctransacao)+1,pos('!',ctransacao)-1));
     ctransacao:=trim(copy(ctransacao,1,pos('|',ctransacao)-1));
     Sistema.Edit('movabate');
     Sistema.SetField('mova_transacaogerada',ctransacao);
     Sistema.SetField('mova_notagerada',strtointdef(cromaneio,0));
     Sistema.Post('mova_transacao='+stringtosql(transacao));

     Sistema.Edit('movabate');
     Sistema.SetField('mova_transacaogerada',transacao);
     Sistema.SetField('mova_notagerada',EdNumerodoc.AsInteger);
// 30.05.17 - para nao aparecer no f12 do numero na entrada de abate
     Sistema.SetField('mova_situacao','N');
     Sistema.Post('mova_transacao='+stringtosql(ctransacao));
     Sistema.Commit;
     Aviso('Romaneio baixado');

   end;

end;

end.
