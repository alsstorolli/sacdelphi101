unit pesagemsaida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr, Async32, ACBrBase, ACBrBAL, AcbrDevice, SqlSis,
  ACBrDANFCeFortesFrETQFAT,ACBrDANFCeFortesFrEA,pcnconversao, ACBrDFe,
  ACBrNFe, ACBrDeviceSerial;

type
  TFPesagemSaida = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bimpetiqueta: TSQLBtn;
    bgeranota: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    GridItens: TSqlDtGrid;
    PRemessa: TSQLPanelGrid;
    PIns: TSQLPanelGrid;
    PPedidos: TSQLPanelGrid;
    GridPedido: TSqlDtGrid;
    PTotais: TSQLPanelGrid;
    EdNumeroDOC: TSQLEd;
    EdPeso: TSQLEd;
    blebalanca: TSQLBtn;
    PPeso: TSQLPanelGrid;
    PTotalPesado: TSQLPanelGrid;
    PValorTotal: TSQLPanelGrid;
//    xSerial1: TComm;
//    SeriaL2: TComm;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    bexcluipesagem: TSQLBtn;
    StaticText3: TStaticText;
    pNomeProduto: TSQLPanelGrid;
    bretnropedido: TSQLBtn;
    bromaneio: TSQLBtn;
    bnotaspendentes: TSQLBtn;
    EdPecas: TSQLEd;
    AcbrBal1: TACBrBAL;
    ACBrBAL2: TACBrBAL;
    ppesobalanca: TSQLPanelGrid;
    EdProduto: TSQLEd;
    EdSeqi: TSQLEd;
    EdSeqf: TSQLEd;
    EdProdutoven: TSQLEd;
    bnfbonificacao: TSQLBtn;
    Edpesobalanca: TSQLEd;
    EdUnitario: TSQLEd;
    ACBrNFe1: TACBrNFe;
    ACBrBAL3: TACBrBAL;
    EdCliente: TSQLEd;
    bpedidomovel: TSQLBtn;
    procedure EdNumeroDOCValidate(Sender: TObject);
    procedure GridPedidoClick(Sender: TObject);
    procedure blebalancaClick(Sender: TObject);
    procedure SeriaL2RxChar(Sender: TObject; Count: Integer);
    procedure xSerial1RxChar(Sender: TObject; Count: Integer);
    procedure bexcluipesagemClick(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdPesoExitEdit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bgeranotaClick(Sender: TObject);
    procedure bretnropedidoClick(Sender: TObject);
    procedure bimpetiquetaClick(Sender: TObject);
    procedure GridItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bromaneioClick(Sender: TObject);
    procedure bnotaspendentesClick(Sender: TObject);
    procedure EdPecasValidate(Sender: TObject);
    procedure AcbrBal1LePeso(Peso: Double; Resposta: AnsiString);
    procedure FormActivate(Sender: TObject);
    procedure ACBrBAL2LePeso(Peso: Double; Resposta: AnsiString);
    procedure EdProdutoValidate(Sender: TObject);
    procedure EdSeqfValidate(Sender: TObject);
    procedure EdSeqfExitEdit(Sender: TObject);
    procedure EdProdutovenValidate(Sender: TObject);
    procedure EdProdutoChange(Sender: TObject);
    procedure EdPecasExitEdit(Sender: TObject);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure bnfbonificacaoClick(Sender: TObject);
    procedure GridItensClick(Sender: TObject);
    procedure GridItensKeyPress(Sender: TObject; var Key: Char);
    procedure EdpesobalancaExitEdit(Sender: TObject);
    procedure EdUnitarioExitEdit(Sender: TObject);
    procedure ACBrBAL3LePeso(Peso: Double; Resposta: AnsiString);
    procedure APHeadLabel1DblClick(Sender: TObject);
    procedure bpedidomovelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure Execute(op:string='' ; xnropedido:integer=0 ; xtran_codigo:string='' ; xcola_codigo:string='' );
    Procedure ZeraCampos;
    procedure Queryitenstogrid(produto:string ; pecas:currency);
    function  AbrirPorta(qbalanca:string):boolean;
    procedure ConfiguraBalancas;
    procedure GravaPeso;
    procedure EditstoGrid(xseq:integer=0);
    procedure GravaMestre(op:string;Q:Tsqlquery);
    procedure GravaItem(op:string;Q:Tsqlquery);
    function ProcuraGrid(Coluna: integer;  Pesquisa: string ; Colunatam:integer=0 ; tam:integer=0 ; colunacor:integer=0 ; cor:integer=0 ;
                         colunacopa:integer=0 ; copa:integer=0 ): integer;
    procedure AtualizaValores;
    function  ConferePecas:boolean;
    function  ConferePecasTodas:boolean;
    procedure ConfiguraTeclas( Key: Word );
    procedure ImpEtiqueta(OP:string='Imp');
    Function Converte( cmd : String) : String;
    function EstaCodigosNaoVenda(produto:string):boolean;
    function JaVendeuPedaco( Etiqueta,Mens:string):boolean;
    function GetCodigoOrigem( xTransacaoPesada,xOperacaoPesada:string ; xOrdemPesada:integer ):string;
    function GetUlitmoNumeroPedidoMovel:string;

  end;

var
  FPesagemSaida: TFPesagemSaida;
  QPedido,
  QSaida:TSqlquery;
  Sqltipomov,Unidade,Transacao,OperacaoPesada,ChecaCodBarra,xop,Tipomov,IncluiPed,
  TransacaoGerada,
  BoiCasado,
  TransacaoPesada,
  BoiCasadoCorte,
  CodigoLido,
  TipoMovLido,
  CodigoTransp,
  CodigoCola01                     :string;
  DataPedido:TDatetime;
  Temgrid:boolean;
  Seq,CodigoCliente,
  OrdemPesada                    :integer;
  Tara,PesoBalanca,PesoComposicao:Currency;
  campobal,CampoVen,
  campoopr                       :TDicionario;

  const tipomovcongelado:string='EC';

implementation

uses Geral,SqlFun, Estoque, impressao, RelGerenciais, nfsaida,
  expnfetxt, cadcli, munic, Unidades, pcnNFe, grupos, custos, diversos;

{$R *.dfm}

{ TFPesagemSaida }

//////////////////////////////////////////////////////////////////////
procedure TFPesagemSaida.Execute(op:string=''; xnropedido:integer=0; xtran_codigo:string='' ; xcola_codigo:string='' );
///////////////////////////////////////////////////////////////////////
begin

   xop:=op;
   tipomov:='SA';
   IncluiPed:='N';
   EdNumerodoc.ClearAll(FPesagemSaida,99);
   GridPedido.clear;
   GridItens.clear;
   ZeraCampos;
   if FGeral.getconfig1asstring('cabecapecas')<>'' then begin
      EdPecas.Title:=FGeral.getconfig1asstring('cabecapecas');
      Griditens.columns[3].Title.caption:=FGeral.getconfig1asstring('cabecapecas');
   end;

   ConfiguraBalancas;
//   if not Global.Topicos[1408] then
// 19.04.15
   if Global.Usuario.OutrosAcessos[0509] then
     abrirporta( 'BAL1' );

   Unidade:=Global.CodigoUnidade;
   if FGeral.Getconfig1asinteger('DIASPEDIDO')>0 then
     DataPedido:=Sistema.hoje-FGeral.Getconfig1asinteger('DIASPEDIDO')
   else
     DataPedido:=Sistema.Hoje-60;
   FPesagemSaida.WindowState:=wsMaximized;
   FGeral.ConfiguraColorEditsNaoEnabled(FPesagemSaida);
// 23.02.16
   campobal:=Sistema.GetDicionario('movabatedet','movd_pesobalanca');
// 24.10.16
   campoven:=Sistema.GetDicionario('movabatedet','movd_esto_codigoven');
// 25.10.16
   campoopr:=Sistema.GetDicionario('movabatedet','movd_oprastreamento');
   EdSeqi.Visible:=false;
   EdSeqf.Visible:=false;
   Show;
   if Global.Usuario.OutrosAcessos[0512] then begin
     EdProduto.Enabled:=true;
     EdPecas.enabled:=false;
   end else begin
     EdProduto.Enabled:=false;
     EdPecas.enabled:=true;
   end;
// 23.09.17
   campo:=Sistema.GetDicionario('grupos','Grup_SomenteCodBarra');
   if trim(campo.tipo)='' then begin
     ChecaCodBarra:='N';
   end else begin
     ChecaCodBarra:='S';
   end;
// 28.04.20
   CodigoTransp := xtran_codigo;
   CodigoCola01 := xcola_codigo;

   if xop='D' then begin

      Caption:='Entrada para Desossa';
      bgeranota.Visible:=false;
      bnfbonificacao.Visible:=false;

// 13.05.20
   end else if xop='C' then begin

      Caption:='Pesagem de Saida POR CARGA';
      bgeranota.Visible:=true;
      bnfbonificacao.Visible:=false;

   end else begin

      Caption:='Pesagem de Saida';
      bgeranota.Visible:=true;
      bnfbonificacao.Visible:=true;

   end;

// 24.04.18
   if xnropedido>0 then begin
      EdNumerodoc.Text:=inttostr(xnropedido);
      EdNumerodoc.Next;
   end else
     EdNumeroDoc.setfocus;

end;

procedure TFPesagemSaida.EdNumeroDOCValidate(Sender: TObject);
////////////////////////////////////////////////
var sqlaberto,sqlwhere,sqldata,sqlunidades:string;
    x:integer;
    QCliente : TSqlQuery;

begin

   sqlaberto:=' and '+Fgeral.getin('mped_situacao','P;A','C');
// 07.01.20
   if Global.Usuario.Codigo = 100 then
      sqlaberto:='';

   sqlwhere:=' where '+FGEral.getin('mpdd_status','N;','C')+' and mpdd_numerodoc='+EdNumerodOC.AsSql;
   sqldata:=' and mped_dataemissao >= '+Datetosql(DAtaPedido);
//   if trim(Global.Usuario.UnidadesMvto)='' then
     sqlunidades:=' and '+FGeral.Getin('mpdd_unid_codigo',Global.CodigoUnidade,'C');
//   else
//     sqlunidades:=' and '+FGeral.Getin('mpdd_unid_codigo',Global.Usuario.UnidadesMvto,'C');
   QPedido:=sqltoquery('select * from movpeddet inner join movped on ( mped_transacao=mpdd_transacao )'+
                       ' inner join estoque on ( esto_codigo = mpdd_esto_codigo )'+
                       sqlwhere+
                       sqlaberto+sqldata+sqlunidades+
                       ' order by mped_datamvto,mpdd_numerodoc,mpdd_seq');

   if QPedido.eof then begin
     EdNumerodoc.invalid('N�o encontrado este pedido ou j� feito nota fiscal');
     exit;
   end;
   GridPedido.clear;
// 05.03.18
   tipomov:='SA';
   if ( FGeral.GetConfig1AsInteger('cliedesossa') > 0 )
            and ( FGeral.GetConfig1AsInteger('cliedesossa')=QPedido.fieldbyname('mped_tipo_codigo').AsInteger  )
            then
           tipomov:=Global.CodDesossaEnt;
// 14.08.12
   Ppeso.caption:='';
   x:=1;
   CodigoCliente:=QPedido.fieldbyname('mped_tipo_codigo').asinteger;
   QCliente:=sqltoquery('select clie_nome from clientes where clie_codigo = '+inttostr(codigocliente));
   if not QCliente.Eof then  Edcliente.Text:=Qcliente.FieldByName('clie_nome').AsString;
   Qcliente.Close;

   while not QPedido.eof do begin

         GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),x]:=QPedido.fieldbyname('mpdd_esto_codigo').asstring;
         GridPedido.cells[GridPedido.getcolumn('esto_descricao'),x]:=QPedido.fieldbyname('esto_descricao').asstring;
         GridPedido.cells[GridPedido.getcolumn('mpdd_qtde'),x]:=QPedido.fieldbyname('mpdd_qtde').asstring;
         GridPedido.cells[GridPedido.getcolumn('mpdd_pecas'),x]:=QPedido.fieldbyname('mpdd_pecas').asstring;
         GridPedido.cells[GridPedido.getcolumn('mpdd_venda'),x]:=QPedido.fieldbyname('mpdd_venda').asstring;
// 08.08.11
         GridPedido.cells[GridPedido.getcolumn('pesoestimado'),x]:=Formatfloat(f_cr3,QPedido.fieldbyname('mpdd_pecas').ascurrency*QPedido.fieldbyname('mpdd_qtde').ascurrency);
         inc(x);
         GridPedido.AppendRow;
     QPedido.next;

   end;
   GridPedido.OnClick(self);
   QPedido.First;
   AtualizaValores;
end;

procedure TFPesagemSaida.ZeraCampos;
begin
//   EdValorpedidos.text:='';
   PTotalPesado.caption:='';
   PValorTotal.caption:='';
   tara:=0;
end;

procedure TFPesagemSaida.GridPedidoClick(Sender: TObject);
var xpecas:currency;
begin
   if GridPedido.cells[Gridpedido.getcolumn('mpdd_esto_codigo'),Gridpedido.row]<>'' then begin
     xpecas:=Texttovalor( GridPedido.cells[GridPedido.getcolumn('mpdd_pecas'),GridPedido.row] );
     Queryitenstogrid(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row],xpecas);
   end;

end;

/////////////////////////////////////////////////////////////////////////////
procedure TFPesagemSaida.Queryitenstogrid(produto: string ; pecas:currency);
/////////////////////////////////////////////////////////////////////////////
var sqldata:string;
    qtde,vlritem,valor:currency;
    x:integer;
begin
/////////
   GridItens.clear;
   x:=1;
   qtde:=0;  valor:=0;
   sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
   Sqltipomov:=' and movd_tipomov='+Stringtosql( Tipomov );
   PNomeProduto.caption:=FEstoque.GetDescricao(produto);
   QSaida:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao and mova_tipomov=movd_tipomov )'+
                      ' where movd_numerodoc='+EdNumerodoc.assql+
                      ' and '+FGeral.Getin('movd_unid_codigo',Global.CodigoUnidade,'C')+
                      ' and movd_esto_codigo='+Stringtosql(produto)+
                      ' and movd_status=''N'''+
                      sqldata+sqltipomov+
                      ' order by movd_ordem' );

   while not QSaida.eof do begin

            GridItens.cells[GridItens.getcolumn('movd_pesocarcaca'),x]:=formatfloat(f_cr3,QSaida.fieldbyname('movd_pesocarcaca').asfloat);
            GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),x]:=formatfloat(f_cr,QSaida.fieldbyname('movd_vlrarroba').asfloat);
// 23.10.13 - jake+clevis
            GridItens.cells[GridItens.getcolumn('movd_pecas'),x]:=formatfloat(f_cr,QSaida.fieldbyname('movd_pecas').asfloat);
            vlritem:=QSaida.fieldbyname('movd_pesocarcaca').asfloat*QSaida.fieldbyname('movd_vlrarroba').asfloat;
//            GridItens.cells[GridItens.getcolumn('total'),x]:=formatfloat(f_cr,vlritem);
            if trim(QSaida.fieldbyname('movd_ordem').Asstring)<>'' then
              GridItens.Cells[gridItens.getcolumn('movd_seq'),x]:=strzero(strtoint(QSaida.fieldbyname('movd_ordem').Asstring),3)
            else
              GridItens.Cells[gridItens.getcolumn('movd_seq'),x]:=strzero(QSaida.fieldbyname('movd_ordem').Asinteger,3);
            GridItens.cells[GridItens.getcolumn('movd_oprastreamento'),x]:=QSaida.fieldbyname('movd_oprastreamento').asstring;
// 30.10.18
            GridItens.cells[GridItens.getcolumn('boicasado'),x]:=QSaida.fieldbyname('movd_brinco').asstring;
            GridItens.cells[GridItens.getcolumn('movd_transacao'),x]:=QSaida.fieldbyname('movd_transacao').asstring;
//            GridItens.Cells[gridItens.getcolumn('movd_operacao'),Abs(x)]:=QSaida.fieldbyname('movd_operacao').asstring;

            inc(x);
            GridItens.appendrow;
            qtde:=qtde+QSaida.fieldbyname('movd_pesocarcaca').asfloat;
            valor:=valor+vlritem;
            QSaida.Next;
   end;
//   PTotalPesado.caption:=FormatFloat(f_cr3,qtde);
//   PValorTotal.caption:=FormatFloat(f_cr,valor);
//   GridPedido.cells[GridPedido.Getcolumn('pesopesado'),GridPedido.row]:=FormatFloat(f_cr3,qtde);
//   GridPedido.cells[GridPedido.Getcolumn('total'),GridPedido.row]:=FormatFloat(f_cr,valor*pecas)
end;

procedure TFPesagemSaida.blebalancaClick(Sender: TObject);
//////////////////////////////////////////////////////////////////
var balanca:string;
    PesoPedido:currency;
begin

   if EdNumerodoc.asinteger=0 then begin
     EdNumerodoc.invalid('N�mero do pedido est� zerado');
     exit;
   end;
   if trim(GridPedido.cells[0,1])='' then begin
     Avisoerro('Sem itens no pedido');
     exit;
   end;
   if not ConferePecas then begin
     Avisoerro('Todas as pe�as j� foram pesadas deste item');
     exit;
   end;
   EdProdutoven.Enabled:=true;
// 07.07.17
   EdProduto.text:='';
// 15.08.17 - para poder pesar manual e com leitor
   EdPecas.Enabled:=true;
   if Global.Usuario.OutrosAcessos[0512] then begin
     EdProduto.text:='';
     EdProduto.setfocus;
// 24.05.17
   end else if (Global.Usuario.OutrosAcessos[0516] )   then begin
     EdProduto.Enabled:=true;
     EdProdutoven.Enabled:=true;
     EdProduto.setfocus;
   end else begin
     EdPecas.SetFocus;
     EdPecas.text:='';
   end;
////////////////////////////////////////////////////////////////////
{
   EdPeso.text:='';
   if Global.Topicos[1408] then begin
//     PIns.Visible:=true;
//     PIns.Enabled:=true;
     EdPeso.Enabled:=true;
     EdPeso.Visible:=true;
     EdPeso.setfocus;
   end else begin
//     PIns.Visible:=false;
//     PIns.Enabled:=false;
//     EdPeso.Visible:=false;
     EdPeso.Enabled:=false;
//     EdPeso.Enabled:=false;
    end;

    balanca:=QPedido.fieldbyname('esto_qbalanca').asstring;
// ver como e quando enviar a tara de cada produto antes de ler a pesagem
     Tara:=QPedido.fieldbyname('esto_tara').ascurrency;
// Isonel resolver nao tarar a balanca de inicio
// entao sera descontada a tara que estiver no produto

//    Aviso( 'Abrindo porta '+balanca);

    abrirporta( balanca );

    PesoPedido:=TextToValor( GridPedido.cells[GridPedido.getcolumn('mpdd_qtde'),GridPedido.row] );

//     Aviso( 'Peso Pedido:'+valortosql(pesopedido)+'|EdPeso:'+EdPeso.text);
//    EdPeso.Refresh;
//    EdPeso.Update;
    Aviso( 'Enter para confirme o peso lido' );
    if (EdPeso.ascurrency>0) then PPeso.caption:=TRansform( EdPeso.ascurrency, f_cr3 );
    if (EdPeso.ascurrency>0) and ( EdPeso.ascurrency<PesoPedido ) then begin
        if confirma('Peso da balan�a menor que o peso m�nimo.  Confirma ?') then begin
          FGeral.GravaLog(26,'Peso balan�a '+EdPeso.assql+' Peso pedido '+Valortosql(pesopedido)+' Pedido '+EdNumerodoc.text);
          GravaPeso;
        end;
    end else if EdPeso.ascurrency>0 then GravaPeso;
// 14.08.12
//    Aviso('fechando portas');
    serial1.close;serial2.close;
    }
////////////////////////////////////////////

end;

function TFPesagemSaida.AbrirPorta( qbalanca:string ):boolean;
////////////////////////////////////////////////////////////////
begin

  if (qbalanca='BAL1') or ( trim(qbalanca)='') then begin
    try
//     aviso('abrindo porta serial '+qbalanca);
//     Serial1.Open;
     Acbrbal1.Ativar;
     result:=true;
    except
//      Avisoerro('Problemas para abrir a porta '+Serial1.DeviceName);
      Avisoerro('Problemas para abrir a porta '+AcbrBal1.Porta);
      result:=false;
    end;

  end else if qbalanca='BAL2' then begin

    try
     Acbrbal2.Ativar;
     result:=true;
    except
      Avisoerro('Problemas para abrir a porta '+AcbrBal2.Porta);
      result:=false;
    end;

// 20.11.18
  end else if qbalanca='BAL3' then begin

    try
     Acbrbal3.Ativar;
     result:=true;
    except
      Avisoerro('Problemas para abrir a porta '+AcbrBal3.Porta);
      result:=false;
    end;

  end;

end;


//////////////////////////////////////////////////////////////
procedure TFPesagemSaida.ConfiguraBalancas;
//////////////////////////////////////////////////////////////

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
{
  if Serial1.Enabled then
    Serial1.Close;
  if Serial2.Enabled then
    Serial2.Close;
}
  if AcbrBal1.Ativo then
    AcbrBal1.Desativar;
  if AcbrBal2.Ativo then
    AcbrBal2.Desativar;
  if AcbrBal3.Ativo then
    AcbrBal3.Desativar;

//  if Serial2.Enabled then
//    Serial2.Close;
{
  if FGeral.GetConfig1AsString('PORTASERIALNF')<>'' then
    Serial1.DeviceName:=FGeral.GetConfig1AsString('PORTASERIALNF');
  if FGeral.GetConfig1AsInteger('saivelocbal1')>0 then
    Serial1.BaudRate:=GetBaudRate(FGeral.GetConfig1AsInteger('saivelocbal1'),Serial1);
  if FGeral.GetConfig1AsInteger('saidatabitsbal1')>0 then
    Serial1.Databits:=GetDataBits(FGeral.GetConfig1AsInteger('saidatabitsbal1'),Serial1);
  if FGeral.GetConfig1AsInteger('saistopbitsbal1')>0 then
    Serial1.Stopbits:=GetStopBits(FGeral.GetConfig1AsInteger('saistopbitsbal1'),Serial1);
  if FGeral.GetConfig1AsString('saiparidade1')<>'' then
    Serial1.Parity:=GetParidade(FGeral.GetConfig1AsString('saiparidade1'));
}

  if FGeral.GetConfig1AsString('PORTASERIALNF')<>'' then
    AcbrBal1.Device.porta:=FGeral.GetConfig1AsString('PORTASERIALNF');
  if FGeral.GetConfig1AsInteger('saivelocbal1')>0 then
    AcbrBal1.Device.Baud := FGeral.GetConfig1AsInteger('saivelocbal1');
  if FGeral.GetConfig1AsInteger('saidatabitsbal1')>0 then
    AcbrBal1.Device.Data :=FGeral.GetConfig1AsInteger('saidatabitsbal1');
  if FGeral.GetConfig1AsInteger('saistopbitsbal1')>0 then
    AcbrBal1.Device.Stop :=GetStopBitsAcBR( FGeral.GetConfig1AsInteger('saistopbitsbal1'),AcbrBal1);
  if FGeral.GetConfig1AsString('saiparidade1')<>'' then
    AcbrBal1.Device.Parity:=GetParidadeAcbr(FGeral.GetConfig1AsString('saiparidade1'));

   ACBrBAL1.Modelo           := TACBrBALModelo( balFilizola );
   ACBrBAL1.Device.HandShake := TACBrHandShake( hsNenhum );

{
  if FGeral.GetConfig1AsString('PORTASERIALNF2')<>'' then
    Serial2.DeviceName:=FGeral.GetConfig1AsString('PORTASERIALNF2');
  if FGeral.GetConfig1AsInteger('saivelocbal2')>0 then
    Serial2.BaudRate:=GetBaudRate(FGeral.GetConfig1AsInteger('saivelocbal2'),Serial2);
  if FGeral.GetConfig1AsInteger('saidatabitsbal2')>0 then
    Serial2.Databits:=GetDataBits(FGeral.GetConfig1AsInteger('saidatabitsbal2'),Serial2);
  if FGeral.GetConfig1AsInteger('saistopbitsbal2')>0 then
    Serial2.Stopbits:=GetStopBits(FGeral.GetConfig1AsInteger('saistopbitsbal2'),Serial2);
  if FGeral.GetConfig1AsString('saiparidade2')<>'' then
    Serial2.Parity:=GetParidade(FGeral.GetConfig1AsString('saiparidade1'));
}

// 02.03.15
  if FGeral.GetConfig1AsString('PORTASERIALNF2')<>'' then
    AcbrBal2.Device.porta:=FGeral.GetConfig1AsString('PORTASERIALNF2');
  if FGeral.GetConfig1AsInteger('saivelocbal2')>0 then
    AcbrBal2.Device.Baud := FGeral.GetConfig1AsInteger('saivelocbal2');
  if FGeral.GetConfig1AsInteger('saidatabitsbal2')>0 then
    AcbrBal2.Device.Data :=FGeral.GetConfig1AsInteger('saidatabitsbal2');
  if FGeral.GetConfig1AsInteger('saistopbitsbal2')>0 then
    AcbrBal2.Device.Stop :=GetStopBitsAcBR( FGeral.GetConfig1AsInteger('saistopbitsbal2'),AcbrBal1);
  if FGeral.GetConfig1AsString('saiparidade2')<>'' then
    AcbrBal2.Device.Parity:=GetParidadeAcbr(FGeral.GetConfig1AsString('saiparidade2'));

   ACBrBAL2.Modelo           := TACBrBALModelo( balFilizola );
   ACBrBAL2.Device.HandShake := TACBrHandShake( hsNenhum );

// 20.11.18 - 3a. balan�a
  if FGeral.GetConfig1AsString('PORTASERIALNF3')<>'' then
    AcbrBal3.Device.porta:=FGeral.GetConfig1AsString('PORTASERIALNF3');
  if FGeral.GetConfig1AsInteger('saivelocbal3')>0 then
    AcbrBal3.Device.Baud := FGeral.GetConfig1AsInteger('saivelocbal3');
  if FGeral.GetConfig1AsInteger('saidatabitsbal3')>0 then
    AcbrBal3.Device.Data :=FGeral.GetConfig1AsInteger('saidatabitsbal3');
  if FGeral.GetConfig1AsInteger('saistopbitsbal3')>0 then
    AcbrBal3.Device.Stop :=GetStopBitsAcBR( FGeral.GetConfig1AsInteger('saistopbitsbal3'),AcbrBal1);
  if FGeral.GetConfig1AsString('saiparidade3')<>'' then
    AcbrBal3.Device.Parity:=GetParidadeAcbr(FGeral.GetConfig1AsString('saiparidade3'));

   ACBrBAL3.Modelo           := TACBrBALModelo( balFilizola );
   ACBrBAL3.Device.HandShake := TACBrHandShake( hsNenhum );


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

//////////////////////////////////////////////////////////////////
procedure TFPesagemSaida.SeriaL2RxChar(Sender: TObject; Count: Integer);
////////////////////////////////////////////////////////////////////////
{
var Buffer:array[1..1024] of char; s:String; i,q:Integer;
    tamstringlida:integer;
    valorlido:currency;

    Function TrataValorLidoBalanca(t:string):currency;
    ///////////////////////////////////////////////////
    begin
//      if FGeral.GetConfig1AsInteger('MULTIBALANCA')>0 then
//        result:=Texttovalor(t)*FGeral.GetConfig1AsInteger('MULTIBALANCA')
//      else
//        result:=Texttovalor(t);
// 08.07.11
      if FGeral.GetConfig1AsInteger('DIVBAL01')>0 then
        result:=Texttovalor(t)/FGeral.GetConfig1AsInteger('DIVBAL01')
      else
        result:=Texttovalor(t);
    end;
 }
begin
///////////////////////
  {
  Sleep(100);
  s:='';
  tamstringlida:=8;  // 13;  // 8
  q:=serial2.InQueCount;
  Serial2.Read(Buffer,q);

//  aviso( 'Lendo porta '+serial1.DeviceName) ;

//  aviso( 'Lendo porta '+AcbrBal1.Device.Porta) ;

  for i:=1 to q do begin
      if Buffer[i] in ['0'..'9'] then s:=s+Buffer[i];
      if Buffer[i] in ['T' ] then break;
// 08.07.11
// leitor alfa vem peso  PB: 0126,2 T: 0000,0
  end;

  if Trim(s)<>'' then begin
     valorlido:=TrataValorLidoBalanca(LeftStr(s,tamstringlida)) - tara;
     EdPeso.SetValue( valorlido  );
     if Global.Topicos[1318] then
       EdPeso.setvalue( round_(EdPeso.ascurrency,2) );
     ppeso.Caption:=EdPeso.text
  end;
}
end;

procedure TFPesagemSaida.xSerial1RxChar(Sender: TObject; Count: Integer);
////////////////////////////////////////////////////////////////////////
{
var Buffer:array[1..1024] of char; s:String; i,q:Integer;
    tamstringlida:integer;
    valorlido:currency;

    Function TrataValorLidoBalanca(t:string):currency;
    ///////////////////////////////////////////////////
    begin
//      if FGeral.GetConfig1AsInteger('MULTIBALANCA')>0 then
//        result:=Texttovalor(t)*FGeral.GetConfig1AsInteger('MULTIBALANCA')
//      else
//        result:=Texttovalor(t);
// 08.07.11
      if FGeral.GetConfig1AsInteger('DIVBAL01')>0 then
        result:=Texttovalor(t)/FGeral.GetConfig1AsInteger('DIVBAL01')
      else
        result:=Texttovalor(t);
//        result:=Texttovalor(t)/10
    end;
}
begin
//////////////////
{
  Sleep(100);
 // Sleep(10);
  tamstringlida:=8;  //  10;  //13;  // 8
  s:='';
  q:=xserial1.InQueCount;
  xSerial1.Read(Buffer,q);

 // aviso( 'Lendo porta '+serial1.DeviceName) ;

  for i:=1 to q do begin
      if Buffer[i] in ['0'..'9'] then  begin
        s:=s+Buffer[i];
        ppeso.Caption:=S;
      end;
      if Buffer[i] in ['T' ] then break;
// 22.07.14
      if Buffer[i] in ['*' ] then break;
// 08.07.11
// leitor alfa vem peso  PB: 0126,2 T: 0000,0
// 22.07.14 - parou de ler e come�ou a vir '*' no lugar do T da tara
// leitor alfa vem peso  PB: 0126,2 T: 0000,0
  end;

//  aviso( 'Lido s='+s+'Buffer='+buffer) ;


  if Trim(s)<>'' then begin
//     EdPesocarcaca.Text:=LeftStr(s,tamstringlida);
     valorlido:=TrataValorLidoBalanca(LeftStr(s,tamstringlida)) - tara;
     EdPeso.SetValue( valorlido  );
     if Global.Topicos[1318] then
       EdPeso.setvalue( round_(EdPeso.ascurrency,2) );

//     if FGeral.GetConfig1AsInteger('DIVBALANCA')>0 then
//        EdPeso.setvalue( (valorlido/FGeral.GetConfig1AsInteger('DIVBALANCA') ) - DescPeso )
//     else
//        EdPeso.setvalue( valorlido - DescPeso  );
//     lpeso.Caption:=EdPesocarcaca.text;
//     lpeso.Caption:=s;
//     pmens.Caption:=LeftStr(s,tamstringlida);
     ppeso.Caption:=EdPeso.Text;
  end else
     ppeso.Caption:=S;
 }
end;

procedure TFPesagemSaida.bexcluipesagemClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////////////////
var ordem,produto,sqldata,
    sqltipomov,
    boicasado,
    xoperacao,
    xcorte         :string;
    Q              :TSqlquery;


begin

  ordem     :=trim(GridItens.Cells[GridItens.getcolumn('movd_seq'),GridItens.row]);
  produto   :=trim(GridPedido.Cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]);
  produto   :=trim(GridPedido.Cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]);
  boicasado :=trim(GridItens.Cells[GridItens.getcolumn('boicasado'),GridItens.row]);
//  xtransacao:=trim(GridItens.Cells[GridItens.getcolumn('movd_transacao'),GridItens.row]);
  xoperacao :=trim(GridItens.Cells[GridItens.getcolumn('movd_oprastreamento'),GridItens.row]);
  if trim(xoperacao)='' then begin

     Avisoerro('Escolher pesagem a ser excluida');
     exit;

  end;

  if not confirma('Confirma exclus�o deste peso ?') then exit;

//  QSaida.First;
// 10.04.18 - na primeira vez 'quase nunca' dava certo a exclusao da pesagem...
   sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
   Sqltipomov:=' and '+FGeral.Getin('movd_tipomov',Tipomov+';ER;EC','C' );
   PNomeProduto.caption:=FEstoque.GetDescricao(produto);

   QSaida:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao and mova_tipomov=movd_tipomov )'+
                      ' where movd_numerodoc='+EdNumerodoc.assql+
                      ' and '+FGeral.Getin('movd_unid_codigo',Global.CodigoUnidade,'C')+
                      ' and movd_esto_codigo='+Stringtosql(produto)+
                      ' and movd_status=''N'''+
                      sqldata+sqltipomov+
                      ' order by movd_ordem' );

  try

    Sistema.Edit('movabatedet');
    Sistema.SetField('movd_status','C');
    Sistema.Post('movd_transacao='+Stringtosql(QSaida.fieldbyname('movd_transacao').AsString)+
                 ' and movd_numerodoc='+EdNumerodoc.assql+
                 ' and movd_ordem='+Stringtosql(ordem)+
                 ' and movd_esto_codigo='+Stringtosql(produto)+
                 ' and '+FGeral.Getin('movd_tipomov',Tipomov+';ER;EC','C' )+
                 ' and movd_unid_codigo='+Stringtosql(unidade)+
                 ' and movd_status='+Stringtosql('N')
                 );
// 04.07.17 - liberar a etiqueta para nova pesagem
    Sistema.Edit('movabatedet');
    Sistema.SetField('movd_pesobalanca',0);
    Sistema.SetField('movd_brinco','');
    Sistema.Post('movd_operacao='+Stringtosql(GridItens.Cells[GridItens.getcolumn('movd_oprastreamento'),GridItens.row])+
                 ' and '+FGeral.Getin('movd_tipomov','PC;ER;EC','C' )+
                 ' and movd_unid_codigo='+Stringtosql(unidade)+
                 ' and movd_status='+Stringtosql('N')
                 );

///////////////
    Sistema.Commit;

// 30.10.18
    if boicasado='CASADO' then begin

        Q:=Sqltoquery('select movd_ordem,movd_transacao,movd_obs from movabatedet where movd_operacao = '+stringtosql( xoperacao ) );
        if AnsiPos('QUARTO DIANTEIRO1',Q.FieldByName('movd_obs').AsString )>0 then
          xcorte:='QUARTO TRASEIRO4'
        else if AnsiPos('QUARTO DIANTEIRO2',Q.FieldByName('movd_obs').AsString )>0 then
          xcorte:='QUARTO TRASEIRO5'
// 19.09.19
        else if AnsiPos('QUARTO TRASEIRO4',Q.FieldByName('movd_obs').AsString )>0 then
          xcorte:='QUARTO TRASEIRO5'
        else if AnsiPos('QUARTO TRASEIRO5',Q.FieldByName('movd_obs').AsString )>0 then
          xcorte:='QUARTO TRASEIRO4'
        else
          xcorte:=Q.FieldByName('movd_obs').AsString;

        Sistema.Edit('movabatedet');

// 19.09.19
          if ( xcorte = 'QUARTO TRASEIRO5' ) or ( xcorte = 'QUARTO TRASEIRO4' ) then begin

             Sistema.SetField('movd_status','N');
             Sistema.Post('movd_transacao='+Stringtosql(Q.FieldByName('movd_transacao').AsString)+
                 ' and movd_tipomov='+Stringtosql('PC')+
                 ' and movd_unid_codigo='+Stringtosql(unidade)+
                 ' and movd_ordem = '+inttostr( Q.FieldByName('movd_ordem').AsInteger )+
//                 ' and movd_brinco = '+Stringtosql('CASADO')+
                 ' and movd_obs = '+Stringtosql(xcorte)+
                 ' and movd_status='+Stringtosql('C') );

        end else begin

           Sistema.SetField('movd_pesobalanca',0);
           Sistema.SetField('movd_brinco','');
           Sistema.Post('movd_transacao='+Stringtosql(Q.FieldByName('movd_transacao').AsString)+
                 ' and movd_tipomov='+Stringtosql('PC')+
                 ' and movd_unid_codigo='+Stringtosql(unidade)+
                 ' and movd_ordem = '+inttostr( Q.FieldByName('movd_ordem').AsInteger )+
                 ' and movd_brinco = '+Stringtosql('CASADO')+
                 ' and movd_obs = '+Stringtosql(xcorte)+
                 ' and movd_status='+Stringtosql('N') );

        end;

        Sistema.Commit;
        Q.Close;

    end;

    GridItens.DeleteRow(GridItens.row);
    AtualizaValores;
  except
    Avisoerro('N�o foi poss�vel excluir.  Verificar');
  end;

end;

procedure TFPesagemSaida.bSairClick(Sender: TObject);
////////////////////////////////////////////////////////////
var Qc:TSqlquery;

begin
//  if xSerial1.Enabled then
//    xSerial1.close;
  if AcbrBal1.Ativo then AcbrBal1.Desativar;
  if AcbrBal2.Ativo then AcbrBal2.Desativar;
  if AcbrBal3.Ativo then AcbrBal3.Desativar;
//  if Serial2.Enabled then
//    Serial2.close;
  close;
// 19.05.20 - Novicarnes - atualiza os pesos deste pedido em sua carga...
  if ( not EdNumerodoc.IsEmpty ) then  begin

     if not QPedido.Eof then begin

        if trim(QPedido.FieldByName('mped_nftrans').AsString)<>'' then begin

          Qc := sqltoquery('select movc_numero from movcargas where movc_status = ''N'''+
                           ' and movc_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                           ' and movc_numero = '+QPedido.FieldByName('mped_nftrans').AsString+
                           ' and movc_datamvto >= '+Datetosql(Sistema.Hoje-30) );
          if (not Qc.Eof) and ( texttovalor(pTotalPesado.caption)>0 ) then begin

             Sistema.Edit('movcargas');
             Sistema.SetField('movc_pesopedidos',texttovalor(pTotalPesado.caption));
             Sistema.Post('movc_numero = '+QPedido.FieldByName('mped_nftrans').AsString+
                           ' and movc_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                           ' and movc_status = ''N'''+
                           ' and movc_datamvto >= '+Datetosql(Sistema.Hoje-30) );
             Sistema.commit;

          end;
          FGeral.FechaQuery(Qc);

        end;

     end;

  end;
//////////////////////////////////

// 13.06.11                               // 13.05.20 - para nao fechar quando pesa pela carga...
  if (Global.Usuario.OutrosAcessos[0054]) and ( xop<>'C' ) then Application.Terminate;

end;

procedure TFPesagemSaida.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
/////////////////////////////////////////////////////////////////////////////////////
begin
//  if xSerial1.Enabled then begin
//    xSerial1.close;
//  end;
  if AcbrBal1.Ativo then AcbrBal1.Desativar;
  if AcbrBal2.Ativo then AcbrBal2.Desativar;
  if AcbrBal3.Ativo then AcbrBal3.Desativar;
//  if Serial2.Enabled then
//    Serial2.close;
  if QSaida<>nil then begin
    if QSaida.SQL.Text<>'' then
      QSaida.close;
  end;

end;

procedure TFPesagemSaida.EdPesoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////
var PesoPedido,PesoEstoque,toleranciaproduto,maximotolerancia:currency;
    produto:string;
// 28.06.16
    function UsaGancheira(xproduto:string):boolean;
    ///////////////////////////////////////////////////
    var Lista:TStringList;
        p:integer;
    begin
      Lista:=TStringList.create;
      result:=false;
      strtolista(Lista,FGeral.GetConfig1AsString('Codigoscomgancho'),';',true);
      for p:=0 to Lista.count-1 do begin
        if Lista[p]=xproduto then begin
          result:=true;
          break;
        end;
      end;
    end;

    function UsaGancheiraMenos1(xproduto:string):boolean;
    ///////////////////////////////////////////////////
    var Lista:TStringList;
        p:integer;
    begin
      Lista:=TStringList.create;
      result:=false;
      strtolista(Lista,FGeral.GetConfig1AsString('Codigosgancho1'),';',true);
      for p:=0 to Lista.count-1 do begin
        if Lista[p]=xproduto then begin
          result:=true;
          break;
        end;
      end;
    end;


begin

  PesoPedido:=TextToValor( GridPedido.cells[GridPedido.getcolumn('mpdd_qtde'),GridPedido.row] );
  produto:=trim(GridPedido.Cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]);
  PesoEstoque:=FEstoque.getpeso(produto);
  toleranciaproduto:=FEstoque.GetTolerancia(produto);
  if (EdPeso.ascurrency>0) then PPeso.caption:=TRansform( EdPeso.ascurrency, f_cr3 );
// 01.03.16
  pesobalanca:=EdPeso.ascurrency;
  pesocomposicao:=EdPeso.ascurrency;
  if EdPeso.Enabled then begin
  /////////////////////
// 28.06.16
      if UsaGancheira( GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] ) then begin
         PesoBalanca:=Pesobalanca-FGeral.GetConfig1AsFloat('DESCPESO');
  // 10.06.15
         if UsaGancheiraMenos1( GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] ) then begin
           PesoBalanca:=Pesobalanca + (Edpecas.ascurrency*FGeral.GetConfig1AsFloat('DESCPESOGANCHO')) +
                        FGeral.GetConfig1AsFloat('DESCPESOGANCHO');
         end;
      end;
// 09.10.17
    OPeracaopesada:=EdProduto.Text;

  end;
  //////////////////////
// 21.09.18
     if toleranciaproduto>0 then
       maximotolerancia:= PesoComposicao + PesoComposicao*(toleranciaproduto/100)*EdPecas.AsCurrency
     else
       maximotolerancia:= PesoComposicao +  PesoComposicao*(FGeral.GetConfig1AsFloat('pertolerbavendas')/100);
  ///
  if (EdPeso.ascurrency>0) and ( EdPeso.ascurrency<PesoPedido ) then begin
    if confirma('Peso da balan�a menor que o peso m�nimo.  Confirma ?') then begin
      FGeral.GravaLog(26,'Peso balan�a '+EdPeso.assql+' Peso pedido '+Valortosql(pesopedido)+' Pedido '+EdNumerodoc.text);
      GravaPeso;
    end;
// 08.09.15 - Iso...dianteiro ' + caro'
  end else  if ( EdPeso.ascurrency>0 ) and (PesoEstoque>0) and (EdPeso.ascurrency>Maximotolerancia) then begin
      Avisoerro('Peso acima do permitido.  Checar para troca de codigo');
      exit;
  end else if EdPeso.ascurrency>0 then begin
    if EdPeso.Enabled then EdPeso.setvalue(EdPeso.ascurrency-tara);  // 21.03.16 - Primos
    GravaPeso;
  end;


//  PIns.Visible:=false;
//  PIns.Enabled:=false;
// 14.08.12
//  Aviso('fechando portas seriais');
//  xserial1.close;
//  serial2.close;
  AcbrBal1.Desativar;
  AcbrBal2.Desativar;
  AcbrBal3.Desativar;
  EdPeso.enabled:=false;

end;

//////////////////////////////////////////////
procedure TFPesagemSaida.GravaPeso;
//////////////////////////////////////////////
var Q                         :TSqlquery;
    sqldata,sqltipomov,produto:string;

begin

  sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
  Sqltipomov:=' and movd_tipomov='+Stringtosql( Tipomov );
  produto:=trim(GridPedido.Cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]);
  Q:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao )'+
                      ' where movd_numerodoc='+EdNumerodoc.assql+
                      ' and '+FGeral.Getin('movd_unid_codigo',Global.CodigoUnidade,'C')+
                      ' and movd_status=''N'''+
                      sqldata+sqltipomov );
// 01.10.12
  AtualizaValores;
  if Q.Eof then begin // ainda nao pesou nada deste pedido
     GravaMestre('I',Q);
     Editstogrid(1);
     Sistema.BeginProcess('Gravando Item');
     GravaItem('I',Q);
  end else begin
  // 29.11.17
    if not Q.Eof then
      Transacao:=Q.fieldbyname('mova_transacao').asstring;

    FGeral.FechaQuery(Q);
    Q:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao )'+
                      ' where movd_numerodoc='+EdNumerodoc.assql+
                      ' and '+FGeral.Getin('movd_unid_codigo',Global.CodigoUnidade,'C')+
                      ' and movd_esto_codigo='+Stringtosql(produto)+
                      ' and movd_status=''N'''+
                      sqldata+sqltipomov );
     Sistema.BeginProcess('Gravando Item');
// sempre 'inclui' o item' pois todos tera o mesmo codigo so mudando o peso...
//     if Q.Eof then begin
       EditstoGrid;
       GravaItem('I',Q);  // item novo dentro de pedido ja come�ado com outros itens
//     end else begin
//       seq:=strtoint(GridItens.Cells[gridItens.getcolumn('movd_ordem'),GridItens.row]);
//       EditstoGrid(seq);
//       GravaItem('A',Q);
//     end;
     GravaMestre('A',Q);
  end;
  Sistema.EndProcess('');
  try
    Sistema.Commit;
    Impetiqueta('Inc');
  except
    Avisoerro('Nada gravado.   Problemas na grava��o no banco de dados');
  end;
// 08.08.11
  AtualizaValores;
// 10.08.12 - 25.09.18 retirado pra ler 'direto' sem precisar dar f4 td vez para pesar
   GridPedido.setfocus;
// 27.09.18 - recolocado para criticar numero de pe�as no pedido
//   blebalancaClick(self);

end;


//////////////////////////////////////////////////////////
function TFPesagemSaida.GetCodigoOrigem(xTransacaoPesada, xOperacaoPesada: string ; xOrdemPesada:integer): string;
//////////////////////////////////////////////////////////////////////////////////////////////////
var Qz:TSqlquery;
begin

   QZ:=sqltoquery( 'select movd_esto_codigo from movabatedet where movd_status = ''N'''+
                   ' and movd_transacao  = '+Stringtosql(xtransacaopesada)+
                   ' and movd_ordem = '+inttostr(xOrdemPesada)+
                   ' and movd_tipomov = '+Stringtosql('EA') );
   if not Qz.Eof then result:=Qz.FieldByName('movd_esto_codigo').asstring else result:='';
   FGeral.FechaQuery(Qz);

end;

function TFPesagemSaida.GetUlitmoNumeroPedidoMovel: string;
/////////////////////////////////////////////////////////////
var QP :TSqlquery;
begin

   QP := sqltoquery('select max(mped_numerodoc) as ultimo from movped where mped_status = ''N'''+
                    ' and mped_situacao = ''P'''+
                    ' and mped_datamvto >= '+Datetosql(Sistema.Hoje-2)+
                    ' and mped_unid_codigo = '+STringtosql(Global.CodigoUnidade)+
                    ' and substr(mped_obspedido,1,12) = '+Stringtosql( 'Vendas Movel' ));
   if not QP.Eof then result := inttostr(QP.FieldByName('ultimo').AsInteger)
   else result:='';
   FGeral.FechaQuery(QP);

end;

procedure TFPesagemSaida.GravaItem(op:string;Q:TSqlquery);
//////////////////////////////////////////////////////////
var linha:integer;
    Qx,
    Qa         :TSqlquery;
    xcorte     : String;
    pesorateio : currency;


             procedure GravaDesossaDetalhe( xOP:string );
             ////////////////////////////////////////////
             begin

//               exit;

               if xop='I' then begin
                  Sistema.Insert('movestoque');
                  Sistema.SetField('move_esto_codigo',trim(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]));
                  Sistema.SetField('move_transacao',transacao);
//                  Sistema.SetField('move_operacao',copy(transacao,1,9)+GridItens.cells[GridItens.getcolumn('movd_seq'),linha]);
// 05.03.18
                  Sistema.SetField('move_operacao',copy(transacao,1,9)+strzero(GridPedido.row,2) );
                  Sistema.SetField('move_numerodoc',Ednumerodoc.Asinteger);
                  Sistema.SetField('move_status','N');
                  Sistema.SetField('move_tipomov',Global.CodDesossaEnt);
                  Sistema.SetField('move_unid_codigo',Unidade);
                  Sistema.SetField('move_tipocad','C');
                  Sistema.SetField('move_tipo_codigo',QPedido.fieldbyname('mped_tipo_codigo').AsInteger);
                  Sistema.SetField('move_qtde',Texttovalor(GridItens.cells[GridItens.getcolumn('movd_pesocarcaca'),linha]));
                  Sistema.SetField('move_venda',Texttovalor(GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),linha]));
                  Sistema.SetField('move_pecas',Edpecas.AsInteger);
                  Sistema.SetField('move_datamvto',Sistema.Hoje);
                  Sistema.SetField('move_datacont',Sistema.Hoje);
                  Sistema.SetField('move_datalcto',Sistema.Hoje);
                  Sistema.SetField('move_grup_codigo',FEstoque.GetGrupo(trim(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row])));
                  Sistema.SetField('move_sugr_codigo',FEstoque.GetSubGrupo(trim(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row])));
                  Sistema.SetField('move_fami_codigo',FEstoque.GetFamilia(trim(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row])));
                  Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);

                  Sistema.Post('');

               end else begin

                  Sistema.Edit('movestoque');
                  Sistema.SetField('move_tipo_codigo',QPedido.fieldbyname('mped_tipo_codigo').AsInteger);
                  Sistema.SetField('move_qtde',Texttovalor(Griditens.cells[GridItens.getcolumn('movd_pesocarcaca'),linha]));
                  Sistema.SetField('move_venda',Texttovalor(GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),linha]));
                  Sistema.SetField('move_pecas',Edpecas.AsInteger);
                  Sistema.SetField('move_grup_codigo',FEstoque.GetGrupo(trim(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row])));
                  Sistema.SetField('move_sugr_codigo',FEstoque.GetSubGrupo(trim(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row])));
                  Sistema.SetField('move_fami_codigo',FEstoque.GetFamilia(trim(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row])));
                  Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
                  Sistema.Post( 'movd_numerodoc='+EdNumerodoc.AsSql+
//                               ' and movd_ordem='+GridItens.cells[GridItens.getcolumn('movd_seq'),linha]+
                               ' and move_tipomov='+Stringtosql(Global.CodDesossaEnt)+
                               ' and move_unid_codigo = '+Stringtosql(Unidade )+
                               ' and move_esto_codigo = '+Stringtosql( trim(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]) )+
                               ' and move_status=''N''' );

               end;
             end;


begin
///////////////////////////////////////////////////


     if op='I' then begin

//        linha:=GridItens.row;
        linha:=ProcuraGrid(GridItens.GetColumn('movd_seq'),strzero(seq,3));
        Sistema.Insert('movabatedet');
// 10.04.18 - fixo sempre do pedido
//        if Edprodutoven.IsEmpty then
          Sistema.SetField('movd_esto_codigo',trim(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]));
//        else
//          Sistema.SetField('movd_esto_codigo',EdProdutoven.text);

        Sistema.SetField('movd_transacao',transacao);
        Sistema.SetField('movd_operacao',copy(transacao,1,9)+GridItens.cells[GridItens.getcolumn('movd_seq'),linha]);
// 05.03.18
//        Sistema.SetField('movd_operacao',copy(transacao,1,9)+strzero(GridPedido.col,2) );

        Sistema.SetField('movd_numerodoc',Ednumerodoc.Asinteger);
        Sistema.SetField('movd_status','N');
        Sistema.SetField('movd_tipomov',TipoMov);
        Sistema.SetField('movd_unid_codigo',Unidade);
        Sistema.SetField('movd_tipo_codigo',QPedido.fieldbyname('mped_tipo_codigo').AsInteger);
//        Sistema.SetField('movd_tipocad','C');
//        Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),linha]);
//        Sistema.SetField('movd_idade',Grid.cells[Grid.getcolumn('movd_idade'),linha]);
//        Sistema.SetField('movd_pesovivo',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesovivo'),linha]));
        Sistema.SetField('movd_pesocarcaca',Texttovalor(GridItens.cells[GridItens.getcolumn('movd_pesocarcaca'),linha]));
// 06.11.17 - desmudado - vanderlei diz q pre�os ficam errados...e q ja estava ficando pelo preco do pedido
        Sistema.SetField('movd_vlrarroba',Texttovalor(GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),linha]));
// 03.11.17 - usar o pre�o unitario do pedido - Isonel
//        Sistema.SetField('movd_vlrarroba',Texttovalor(GridPedido.cells[GridPedido.getcolumn('mpdd_venda'),linha]));

        //        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
        Sistema.SetField('movd_ordem',strtoint(GridItens.cells[GridItens.getcolumn('movd_seq'),linha]));
//        Sistema.SetField('movd_pecas',1);
// 23.10.13 - jake + clevis
        Sistema.SetField('movd_pecas',Edpecas.AsInteger);
// 24.10.16
//        if Campoven.Tipo<>'' then Sistema.SetField('movd_esto_codigoven',EdProdutoven.text);
// 08.01.19
        Sistema.SetField('movd_esto_codigoven',CodigoLido);
        if not EdProduto.IsEmpty then begin
          if Campoopr.Tipo<>'' then Sistema.SetField('movd_oprastreamento',EdProduto.text);
        end;
// 14.08.17
        Sistema.SetField('movd_datamvto',Sistema.Hoje);
        if Boicasado = 'S' then begin

           Qa:=sqltoquery('select movd_esto_codigo from movabatedet '+
                          ' where movd_status = ''N'''+
                          ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                          ' and movd_tipomov = '+stringtosql('PC')+
                          ' and movd_operacao = '+stringtosql(EdProduto.text) );

//           pesorateio:=FComposicao.GetPesoComposicao( EdProdutoven.Text,
//                             Qa.FieldByName('movd_esto_codigo').AsString,
//                             Pesobalanca);
// 16.01.20
//           if pesorateio = 0 then pesorateio := Pesobalanca; // ver tratar no relat. de rastreamento
// 28.02.20
//           pesorateio := PesoBalanca/2;
// 02.03.20
           pesorateio := PesoBalanca;

           Sistema.SetField('movd_pesobalanca',pesorateio);
           Sistema.SetField('movd_brinco','CASADO');

        end else

           Sistema.SetField('movd_pesobalanca',Pesobalanca);

        Sistema.Post('');
// 07.11.17
//        if ( FGeral.GetConfig1AsInteger('cliedesossa') > 0 )
//            and ( FGeral.GetConfig1AsInteger('cliedesossa')=QPedido.fieldbyname('mped_tipo_codigo').AsInteger  ) then
//            GravaDesossaDetalhe( OP );
// retirado em 05.03.18

     end else begin

        Sistema.Edit('movabatedet');
        Sistema.SetField('movd_tipo_codigo',QPedido.fieldbyname('mped_tipo_codigo').AsInteger);
//        Sistema.SetField('movd_tipocad','C');
//        Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),linha]);
//        Sistema.SetField('movd_idade',Grid.cells[Grid.getcolumn('movd_idade'),linha]);
//        Sistema.SetField('movd_pesovivo',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesovivo'),linha]));

        Sistema.SetField('movd_pesocarcaca',Texttovalor(Griditens.cells[GridItens.getcolumn('movd_pesocarcaca'),linha]));
// 06.11.17 - desmudado - vanderlei...
        Sistema.SetField('movd_vlrarroba',Texttovalor(GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),linha]));
// 03.11.17 - usar o pre�o unitario do pedido - Isonel
//        Sistema.SetField('movd_vlrarroba',Texttovalor(GridPedido.cells[GridPedido.getcolumn('mpdd_venda'),linha]));

//        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
//        Sistema.SetField('movd_pecas',1);
// 23.10.13 - jake + clevis
        Sistema.SetField('movd_pecas',Edpecas.AsInteger);
// 23.02.16 - balan��o na saida
        if Campobal.Tipo<>'' then Sistema.SetField('movd_pesobalanca',Pesobalanca);
// 24.10.16
//        if Campoven.Tipo<>'' then Sistema.SetField('movd_esto_codigoven',EdProdutoven.text);
// 08.01.19
        Sistema.SetField('movd_esto_codigoven',CodigoLido);
// 25.10.16
        if not EdProduto.IsEmpty then begin
          if Campoopr.Tipo<>'' then Sistema.SetField('movd_oprastreamento',EdProduto.text);
        end;
// 30.10.18
        Sistema.SetField('movd_datamvto',Sistema.Hoje);

        if Boicasado = 'S' then
           Sistema.SetField('movd_brinco','CASADO');
/////////////////
        Sistema.Post('movd_numerodoc='+EdNumerodoc.AsSql+
                     ' and movd_ordem='+GridItens.cells[GridItens.getcolumn('movd_seq'),linha]+
                     ' and movd_tipomov='+Stringtosql(TipoMov)+
                     ' and movd_status=''N''');
// 07.11.17
//        if ( FGeral.GetConfig1AsInteger('cliedesossa') > 0 )
//            and ( FGeral.GetConfig1AsInteger('cliedesossa')=QPedido.fieldbyname('mped_tipo_codigo').AsInteger  ) then
//            GravaDesossaDetalhe( OP );
// retirado em 05.03.18


     end;

// 09.05.17 - marcar como 'ja pesado'
     if trim(operacaopesada)<>'' then begin

/////     Aviso('etiqueta pesada |'+Operacaopesada+'|'+formatfloat(f_cr,pesobalanca)+'|');


        Qx:=sqltoquery('select movd_obs,movd_esto_codigo from movabatedet '+
                       ' where movd_operacao = '+Stringtosql(Operacaopesada)+
//                       ' and movd_tipomov='+Stringtosql('PC')+
// 15.03.19 - para baixar as caixas de miudos q veio da desossa
                       ' and '+FGeral.GetIN('movd_tipomov','PC;ER;EC','C')+
                       ' and movd_status=''N''');

        if AnsiPos('QUARTO DIANTEIRO1',Qx.FieldByName('movd_obs').AsString )>0 then
          xcorte:='QUARTO TRASEIRO4'
        else if AnsiPos('QUARTO DIANTEIRO2',Qx.FieldByName('movd_obs').AsString )>0 then
          xcorte:='QUARTO TRASEIRO5'
// 19.09.19
        else if AnsiPos('QUARTO TRASEIRO4',Qx.FieldByName('movd_obs').AsString )>0 then
//          xcorte:='QUARTO TRASEIRO5'
// 18.06.20 - Aviso de Vanderlei
          xcorte:='QUARTO DIANTEIRO1'
        else if AnsiPos('QUARTO TRASEIRO5',Qx.FieldByName('movd_obs').AsString )>0 then
// 18.06.20 - Aviso de Vanderlei
//          xcorte:='QUARTO TRASEIRO4'
          xcorte:='QUARTO DIANTEIRO2'
//////////////
        else
          xcorte:=Qx.FieldByName('movd_obs').AsString;

        Sistema.Edit('movabatedet');
// 28.02.20
        Sistema.SetField('movd_datamvto',Sistema.Hoje);

        if Boicasado = 'S' then begin

           Qa:=sqltoquery('select movd_esto_codigo,movd_obs from movabatedet '+
                          ' where movd_status = ''N'''+
                          ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                          ' and movd_tipomov = '+stringtosql('PC')+
                          ' and movd_operacao = '+stringtosql(OperacaoPesada) );
          Sistema.SetField('movd_brinco','CASADO');
//          pesorateio:=FComposicao.GetPesoComposicao( EdProdutoven.Text,
//                             Qa.FieldByName('movd_esto_codigo').AsString,
//                             Pesobalanca);
// 24.02.20
          pesorateio:=Pesobalanca;
//          if AnsiPos('QUARTO TRASEIRO',Qa.FieldByName('movd_obs').AsString )>0 then
//          pesorateio:=pesorateio/2;
// 02.03.20
          pesorateio:=pesorateio;

          Sistema.SetField('movd_pesobalanca',pesorateio);

        end else

          Sistema.SetField('movd_pesobalanca',PesoBalanca);


        Sistema.Post('movd_operacao='+Stringtosql(Operacaopesada)+
//                     ' and movd_tipomov='+Stringtosql('PC')+
// 15.03.19 - para baixar as caixas de miudos q veio da desossa
                       ' and '+FGeral.GetIN('movd_tipomov','PC;ER;EC','C')+
                     ' and movd_status=''N''');

// 19.09.18 - baixa a etiqueta que n�o foi lida do traseiro ou dianteiro
// 19.09.19 - Isonel + Wanderlei - elimina estas etiquetas mas somente
//            do traseiro
        if Boicasado = 'S' then  begin

          Qa:=sqltoquery('select movd_esto_codigo,movd_obs from movabatedet '+
                          ' where movd_status = ''N'''+
                          ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                          ' and movd_tipomov = '+stringtosql('PC')+
                          ' and movd_ordem = '+inttostr(Ordempesada)+
                          ' and movd_obs = '+Stringtosql( xcorte )+
                          ' and movd_operacao  <> '+Stringtosql(Operacaopesada) );
          Sistema.Edit('movabatedet');

          Sistema.SetField('movd_datamvto',Sistema.Hoje);
//          pesorateio:=FComposicao.GetPesoComposicao( EdProdutoven.Text,
//                             Qa.FieldByName('movd_esto_codigo').AsString,
//                             Pesobalanca);
// 24.02.20
          pesorateio:=pesobalanca;

//          if AnsiPos('QUARTO TRASEIRO',Qa.FieldByName('movd_obs').AsString )>0 then
             pesorateio:=pesorateio/2;
// 19.09.19
          if ( xcorte = 'QUARTO TRASEIRO5' ) or ( xcorte = 'QUARTO TRASEIRO4' ) then

             Sistema.SetField('movd_status','C')

          else begin

             Sistema.SetField('movd_pesobalanca',pesorateio);
// 30.10.18
             Sistema.SetField('movd_brinco','CASADO');

          end;

          Sistema.Post('movd_operacao <>'+Stringtosql(Operacaopesada)+
                       ' and movd_transacao = '+Stringtosql(TransacaoPesada)+
                       ' and movd_esto_codigo <> '+stringtosql(GridItens.cells[GridItens.getcolumn('movd_esto_codigo'),GridItens.Row] )+
// 30.10.18
                       ' and movd_ordem = '+inttostr(Ordempesada)+
// 06.11.18
                       ' and movd_obs = '+Stringtosql( xcorte )+
                       ' and ( (movd_pesobalanca is null) or (movd_pesobalanca=0) )'+
                       ' and movd_tipomov='+Stringtosql('PC')+
                       ' and movd_status=''N''');

        end;

        FGeral.FechaQuery(Qx);

////////////////////////////
/// 16.03.18  - Novicarnes - Isonel
{
     if IncluiPed='S' then begin

        Sistema.Insert('movpeddet');
        Sistema.setfield('mpdd_status','N');
        Sistema.setfield('mpdd_transacao',QPedido.fieldbyname('mped_transacao').AsString );
        Sistema.setfield('mpdd_operacao',QPedido.fieldbyname('mped_transacao').AsString+
                                         GridItens.cells[GridItens.getcolumn('movd_seq'),linha]);
        Sistema.setfield('mpdd_tipomov',Global.codPedvenda);
        Sistema.SetField('mpdd_esto_codigo',EdProdutoven.Text);
        Sistema.SetField('mpdd_numerodoc',Ednumerodoc.Asinteger);
        Sistema.SetField('mpdd_unid_codigo',Unidade);
        Sistema.SetField('mpdd_tipo_codigo',QPedido.fieldbyname('mped_tipo_codigo').AsInteger);
        Sistema.SetField('mpdd_qtde',PesoBalanca);
        Sistema.SetField('mpdd_venda',Texttovalor(GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),linha]) );
        Sistema.SetField('mpdd_pecas',EdPecas.AsInteger);
        Sistema.SetField('mpdd_datalcto',Sistema.Hoje);
        Sistema.SetField('mpdd_datamvto',Sistema.Hoje);
        Sistema.SetField('mpdd_usua_codigo',Global.Usuario.codigo);
        Sistema.SetField('mpdd_repr_codigo',QPedido.fieldbyname('mped_repr_codigo').AsInteger);
        Sistema.SetField('mpdd_vendabru',Texttovalor(GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),linha]));
        Sistema.SetField('mpdd_seq',strtointdef(GridItens.cells[GridItens.getcolumn('movd_seq'),linha],0) );
        Sistema.Post('');

     end;
     }
/////////////////////////
     end;
     EdProduto.Text:='';
end;

////////////////////////////////////////////////////////////////
procedure TFPesagemSaida.GravaMestre(op:string ; Q:TSqlquery );
////////////////////////////////////////////////////////////////

             // 07.11.17
             procedure GravaDesossa( xOP:string );
             //////////////////////////////////////
             begin

//                exit;

                if xOp='I' then begin
                  Sistema.Insert('Movesto');
                  Sistema.SetField('moes_transacao',Transacao);
                  Sistema.SetField('moes_operacao',Transacao+'02');
                  Sistema.SetField('moes_status','N');
                  Sistema.SetField('moes_numerodoc',EdNumerodoc.asinteger);
                  Sistema.SetField('moes_tipomov',Global.CodDesossaEnt);
                  Sistema.SetField('moes_unid_codigo',Unidade);
                  Sistema.SetField('moes_tipo_codigo',QPedido.fieldbyname('mped_tipo_codigo').AsInteger);
                  Sistema.SetField('moes_datalcto',Sistema.Hoje);
                  Sistema.SetField('moes_datamvto',Sistema.Hoje);
                  Sistema.SetField('moes_tipocad','C');
                  Sistema.SetField('moes_estado',Global.UFUnidade);
                  Sistema.SetField('moes_dataemissao',Sistema.Hoje);
                  Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);

                end else begin

                  Sistema.Edit('movesto');

                end;

                Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
                Sistema.SetField('Moes_repr_codigo',QPedido.fieldbyname('mped_repr_codigo').AsInteger);
                Sistema.SetField('Moes_vlrtotal',Texttovalor(PValortotal.caption));
              ///////////
                if xOp='I' then
                  Sistema.Post()
                else
                  Sistema.Post('moes_transacao='+stringtosql(transacao)+
                               ' and moes_tipomov = '+Stringtosql(Global.CodDesossaEnt));


             end;


begin

  Sistema.BeginProcess('Gravando Mestre');
  if Op='I' then begin
    Transacao:=Global.CodigoUnidade+ Inttostr( FGeral.GetContador('TRANSA'+Unidade,false) );
    Sistema.Insert('Movabate');
    Sistema.SetField('mova_transacao',Transacao);
    Sistema.SetField('mova_operacao',Transacao+'01');
    Sistema.SetField('mova_status','N');
    Sistema.SetField('mova_numerodoc',EdNumerodoc.asinteger);
    Sistema.SetField('mova_tipomov',TipoMov);
    Sistema.SetField('mova_unid_codigo',Unidade);
    Sistema.SetField('mova_tipo_codigo',QPedido.fieldbyname('mped_tipo_codigo').AsInteger);
//    Sistema.SetField('mova_tipocad','C');
    Sistema.SetField('mova_datalcto',Sistema.Hoje);
    Sistema.SetField('mova_dtabate',Sistema.Hoje);
    Sistema.SetField('mova_dtcarrega',Sistema.Hoje);
    Sistema.SetField('mova_dtvenci',Sistema.Hoje);
    Sistema.SetField('mova_notagerada',0);
    Sistema.SetField('mova_transacaogerada','');
    Sistema.SetField('mova_pesovivo',0);
    Sistema.SetField('mova_pesocarcaca',texttovalor(pTotalPesado.caption));
    Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('mova_datacont',Sistema.hoje);
    Sistema.SetField('mova_situacao','P');
// ver quando informa ou de onde busca o transportador...talvez no pedido ?
//    Sistema.SetField('mova_tran_codigo',EdTran_codigo.text);
    Sistema.SetField('mova_fpgt_codigo',QPedido.fieldbyname('mped_fpgt_codigo').AsString);
///////////
    Sistema.SetField('Mova_repr_codigo',QPedido.fieldbyname('mped_repr_codigo').AsInteger);
    Sistema.SetField('Mova_vlrtotal',Texttovalor(PValortotal.caption));
    Sistema.SetField('Mova_perccomissao',0);
///////////
    Sistema.Post();

// 07.11.17
    if ( FGeral.GetConfig1AsInteger('cliedesossa') > 0 )
        and ( FGeral.GetConfig1AsInteger('cliedesossa')=QPedido.fieldbyname('mped_tipo_codigo').AsInteger  ) then
      GravaDesossa( OP );

  end else begin

  // 29.11.17
    if not Q.Eof then
      Transacao:=Q.fieldbyname('mova_transacao').asstring;
    Sistema.Edit('Movabate');
    Sistema.SetField('mova_tipo_codigo',QPedido.fieldbyname('mped_tipo_codigo').AsInteger);
//    Sistema.SetField('mova_tipocad','C');
//    Sistema.SetField('mova_datalcto',Sistema.Hoje);
//    Sistema.SetField('mova_dtabate',EdDtabate.asdate);
//    Sistema.SetField('mova_dtcarrega',EdDtcarrega.asdate);
//    Sistema.SetField('mova_dtvenci',EdVencimento.asdate);
//    Sistema.SetField('mova_notagerada',0);
//    Sistema.SetField('mova_transacaogerada','');
//    Sistema.SetField('mova_pesovivo',EdTotalpesovivo.ascurrency);
    Sistema.SetField('mova_pesocarcaca',texttovalor(pTotalPesado.caption));
    Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
//    Sistema.SetField('mova_perc',EdPerc.ascurrency);
//    Sistema.SetField('mova_tran_codigo',EdTran_codigo.text);
    Sistema.SetField('mova_fpgt_codigo',QPedido.fieldbyname('mped_fpgt_codigo').AsString);
///////////
    Sistema.SetField('Mova_repr_codigo',QPedido.fieldbyname('mped_repr_codigo').AsInteger);
    Sistema.SetField('Mova_vlrtotal',Texttovalor(PValortotal.caption));
//    Sistema.SetField('Mova_perccomissao',EdPercComissao.ascurrency);
///////////
    Sistema.Post('mova_transacao='+stringtosql(transacao));
// 07.11.17
    if ( FGeral.GetConfig1AsInteger('cliedesossa') > 0 )
        and ( FGeral.GetConfig1AsInteger('cliedesossa')=QPedido.fieldbyname('mped_tipo_codigo').AsInteger  ) then
      GravaDesossa( OP );

  end;
end;

/////////////////////////////////////////////////////////
procedure TFPesagemSaida.Editstogrid(xseq:integer=0);
/////////////////////////////////////////////////////////
var x:integer;
    valorvenda:currency;
begin

  if xseq=0 then
    x:=ProcuraGrid(GridItens.getcolumn('movd_seq'),strzero(xseq,3),0,0,0,0,0,0 )
  else
    x:=ProcuraGrid(GridItens.getcolumn('movd_seq'),strzero(xseq,3),0,0,0,0,0,0 );
  valorvenda:=Texttovalor( GridPedido.cells[GridPedido.getcolumn('mpdd_venda'),GridPedido.row] );

  if x<0 then begin

    temgrid:=false;
    GridItens.AppendRow;
    GridItens.Cells[gridItens.getcolumn('movd_seq'),Abs(x)]:=strzero(Seq,3);
//    Grid.Cells[grid.getcolumn('movd_esto_codigo'),Abs(x)]:=EdProduto.Text;
//    Grid.Cells[grid.getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;
//    Grid.Cells[grid.getcolumn('movd_brinco'),Abs(x)]:=EdBrinco.Text;
    GridItens.Cells[gridItens.getcolumn('movd_pesocarcaca'),Abs(x)]:=Transform( EdPeso.Ascurrency, f_cr3 );
//    GridItens.Cells[gridItens.getcolumn('total'),Abs(x)]:=TRansform( (EdPeso.AsCurrency*valorvenda) ,f_cr );
    GridItens.Cells[gridItens.getcolumn('movd_vlrarroba'),Abs(x)]:=TRansform( valorvenda,f_cr );
// 23.10.13 - jake + clevis
    GridItens.Cells[gridItens.getcolumn('movd_pecas'),Abs(x)]:=Edpecas.AsSql;
// 09.10.17
    GridItens.Cells[gridItens.getcolumn('movd_oprastreamento'),Abs(x)]:=OperacaoPesada;
// 02.10.18
    GridItens.Cells[gridItens.getcolumn('movd_esto_codigo'),Abs(x)]:=EdProdutoven.Text;
// 30.10.18
    if boicasado='S' then begin
       GridItens.Cells[gridItens.getcolumn('boicasado'),Abs(x)]:='CASADO';
    end;
    GridItens.Cells[gridItens.getcolumn('movd_transacao'),Abs(x)]:=TransacaoPesada;
    GridItens.Cells[gridItens.getcolumn('movd_operacao'),Abs(x)]:=EdProduto.Text;


  end else begin

    temgrid:=true;
//    Grid.Cells[grid.getcolumn('movd_esto_codigo'),x]:=EdProduto.Text;
//    Grid.Cells[grid.getcolumn('esto_descricao'),x]:=SetEdEsto_descricao.text;
//    Grid.Cells[grid.getcolumn('movd_brinco'),Abs(x)]:=EdBrinco.Text;
//    Grid.Cells[grid.getcolumn('movd_pesovivo'),Abs(x)]:=EdPesovivo.AsSql;
    GridItens.Cells[gridItens.getcolumn('movd_pesocarcaca'),Abs(x)]:=Transform( EdPeso.Ascurrency, f_cr3 ) ;
    GridItens.Cells[gridItens.getcolumn('total'),Abs(x)]:=TRansform( (EdPeso.AsCurrency*valorvenda) ,f_cr );
    GridItens.Cells[gridItens.getcolumn('movd_vlrarroba'),Abs(x)]:=TRansform( valorvenda,f_cr );
//    Grid.Cells[grid.getcolumn('movd_pecas'),Abs(x)]:=Edmovd_pecas.AsSql;
// 23.10.13 - jake + clevis
    GridItens.Cells[gridItens.getcolumn('movd_pecas'),Abs(x)]:=Edpecas.AsSql;
// 09.10.17
    GridItens.Cells[gridItens.getcolumn('movd_oprastreamento'),Abs(x)]:=OperacaoPesada;
// 02.10.18
    GridItens.Cells[gridItens.getcolumn('movd_esto_codigo'),Abs(x)]:=EdProdutoven.Text;
// 30.10.18
    if boicasado='S' then begin
       GridItens.Cells[gridItens.getcolumn('boicasado'),Abs(x)]:='CASADO';
    end;
    GridItens.Cells[gridItens.getcolumn('movd_transacao'),Abs(x)]:=TransacaoPesada;
    GridItens.Cells[gridItens.getcolumn('movd_operacao'),Abs(x)]:=EdProduto.Text;

  end;
end;


//////////////////////////////////////////////////////////////////////////
function TFPesagemSaida.ProcuraGrid(Coluna: integer; Pesquisa: string;
  Colunatam, tam, colunacor, cor, colunacopa, copa: integer): integer;
//////////////////////////////////////////////////////////////////////////
var p:integer;

begin

  result:=0;seq:=0;
  for p:=1 to GridItens.RowCount do  begin
      if trim(GridItens.Cells[GridItens.getcolumn('movd_seq'),p])<>'' then begin
        seq:=strtoint(GridItens.Cells[GridItens.getcolumn('movd_seq'),p]);
        inc(seq);
      end else begin
        if seq=0 then
          seq:=1;
      end;
  end;
  if (tam>0) and (cor>0) then begin
    if copa=0 then begin
      for p:=1 to GridItens.RowCount do  begin
        if (trim(GridItens.Cells[Coluna,p])=trim(Pesquisa)) and
         (trim(GridItens.Cells[Colunatam,p])=trim(inttostr(tam))) and (trim(GridItens.Cells[Colunacor,p])=trim(inttostr(cor))) then begin
          result:=p;
          break;
        end;
        if trim(GridItens.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
    end else begin
      for p:=1 to GridItens.RowCount do  begin
        if (trim(GridItens.Cells[Coluna,p])=trim(Pesquisa)) and
         (trim(GridItens.Cells[Colunatam,p])=trim(inttostr(tam))) and (trim(GridItens.Cells[Colunacor,p])=trim(inttostr(cor)))
          and ( trim(GridItens.Cells[Colunacopa,p])=trim(inttostr(copa)) ) then begin
          result:=p;
          break;
        end;
        if trim(GridItens.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
    end;
  end else if (tam>0) and (cor=0) then begin  // 04.07.06
      for p:=1 to GridItens.RowCount do  begin
        if (trim(GridItens.Cells[Coluna,p])=trim(Pesquisa)) and
         ( trim(GridItens.Cells[Colunatam,p])=trim(inttostr(tam)) ) and ( texttovalor(GridItens.Cells[Colunacor,p])=0 ) then begin
          result:=p;
          break;
        end;
        if trim(GridItens.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
  end else begin  // 03.10.07
      for p:=1 to GridItens.RowCount do  begin
        if trim(GridItens.Cells[Coluna,p])=trim(Pesquisa) then begin
          result:=p;
          break;
        end;
        if trim(GridItens.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
  end;
end;

procedure TFPesagemSaida.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);
end;

/////////////////////////////////////////
procedure TFPesagemSaida.AtualizaValores;
/////////////////////////////////////////
var p,r:integer;
    valortotal,pesototal,qtde,valor,pecas,unitario:currency;
    QSaidax:TSqlquery;
    sqldata,sqltipomov,produto:string;

begin

  valortotal:=0;pesototal:=0;
  sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
  Sqltipomov:=' and movd_tipomov='+Stringtosql( Tipomov );
  for r:=1 to GridPedido.RowCount do begin

     if Texttovalor(GridPedido.cells[GridPedido.getcolumn('mpdd_qtde'),r])>0 then begin
       produto:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),r];
       pecas:=Texttovalor( GridPedido.cells[GridPedido.getcolumn('mpdd_pecas'),r] );
       unitario:=Texttovalor( GridPedido.cells[GridPedido.getcolumn('mpdd_venda'),r] );
       QSaidax:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao )'+
                      ' where movd_numerodoc='+EdNumerodoc.assql+
                      ' and '+FGeral.Getin('movd_unid_codigo',Global.CodigoUnidade,'C')+
                      ' and movd_esto_codigo='+Stringtosql(produto)+
                      ' and movd_status=''N'''+
                      sqldata+sqltipomov+
                      ' order by movd_ordem' );
       qtde:=0;
       while not Qsaidax.eof do begin
         qtde:=qtde+QSaidaX.fieldbyname('movd_pesocarcaca').asfloat;
         QSaidax.Next;
       end;
       FGeral.FechaQuery(Qsaidax);
       pesototal:=pesototal+qtde;
//       valor:=qtde*unitario*pecas;
// 08.08.11- Andreia 9 anos...  // assim somente no pedido
       valor:=qtde*unitario;
       valortotal:=valortotal+valor;
       GridPedido.cells[GridPedido.Getcolumn('pesopesado'),r]:=FormatFloat(f_cr3,qtde);
       GridPedido.cells[GridPedido.Getcolumn('total'),r]:=FormatFloat(f_cr,valor)
     end;

  end;
  PTotalPesado.caption:=FormatFloat(f_cr3,pesototal);
  PValorTotal.caption:=FormatFloat(f_cr,valortotal);

{
  for p:=1 to GridItens.RowCount do begin
    if Texttovalor(GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),p])>0 then begin
      valortotal:=valortotal+Texttovalor( GridItens.cells[GridItens.getcolumn('total'),p] );
      pesototal:=pesototal+Texttovalor( GridItens.cells[GridItens.getcolumn('movd_pesocarcaca'),p] );
    end;
  end;
  PValortotal.caption:=Transform( valortotal, f_cr );
}
end;

//////////////////////////////////////////////
function  TFPesagemSaida.ConferePecas:boolean;
//////////////////////////////////////////////
var p,pecaspesadas:integer;

begin

  result:=true;
  if Strtointdef( GridPedido.cells[GridPedido.getcolumn('mpdd_pecas'),GridPedido.row],0 ) = 0 then begin
    Avisoerro('Item do pedido n�o escolhido OU sem quantidade de pe�as');
    exit;
  end;
  pecaspesadas:=0;
  for p:=1 to GridItens.RowCount do begin
    if Texttovalor(GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),p])>0 then
      inc(pecaspesadas);
  end;
  if pecaspesadas = Strtoint( GridPedido.cells[GridPedido.getcolumn('mpdd_pecas'),GridPedido.row] ) then
    result:=false;
end;

procedure TFPesagemSaida.bgeranotaClick(Sender: TObject);
///////////////////////////////////////////////////////////
var feznfcomdif:boolean;

    function NotaJaGerada:boolean;
    /////////////////////////////////
    var QPEd:TSQlQuery;
        sqlaberto,sqlwhere,sqldata,sqlunidades:string;
    begin
      result:=false;
      sqlaberto:=' and '+Fgeral.getin('mped_situacao','P;A;E','C');
      sqlwhere:=' where '+FGEral.getin('mped_status','N;','C')+' and mped_numerodoc='+EdNumerodOC.AsSql;
      sqldata:=' and mped_dataemissao >= '+Datetosql(DAtaPedido);
      sqlunidades:=' and '+FGeral.Getin('mped_unid_codigo',Global.CodigoUnidade,'C');
      QPed:=sqltoquery('select * from movped '+
                              sqlwhere+
                              sqlaberto+sqldata+sqlunidades+
                              ' order by mped_datamvto,mped_numerodoc');

      if QPed.fieldbyname('mped_situacao').asstring='E' then begin
        result:=true;
        Avisoerro('Pedido j� gerado na nota '+QPed.fieldbyname('mped_nfvenda').asstring+
                  ' de '+FGeral.FormataData(QPed.fieldbyname('mped_datanfvenda').asdatetime) );
      end;
      FGeral.FechaQuery(qPed);
    end;

begin
////////////////////////////
  feznfcomdif:=false;

  if NotaJaGerada then
       exit;

  if not ConferePecasTodas then begin
    feznfcomdif:=confirma('Gerar nota assim mesmo ?');
    if not feznfcomdif then exit;
  end;

  FNotaSaida.Execute('G','N',Fgeral.GetConfig1AsInteger('ConfMovAbate'),EdNumerodoc.AsInteger,
                     CodigoCliente,QPedido.fieldbyname('mped_fpgt_codigo').asstring,
                     CodigoTransp,
                     QPedido.fieldbyname('mped_port_codigo').asstring,
                     Texttovalor(PValortotal.caption),
                     CodigoCola01
                     );

  if feznfcomdif then
    FGeral.GravaLog(25,'Gerado nota com diferen�a ',false);

end;

//////////////////////////////////////////////////
function TFPesagemSaida.ConferePecasTodas: boolean;
//////////////////////////////////////////////////
var p,r,pecaspesadas:integer;
    sqldata,Sqltipomov,produto:string;
    QSaidaX:TSqlquery;
begin
  result:=true;
  for r:=0 to GridPedido.RowCount do begin
     if Texttovalor(GridPedido.cells[GridPedido.getcolumn('mpdd_qtde'),r])>0 then begin
       produto:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),r];
       sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
       Sqltipomov:=' and movd_tipomov='+Stringtosql( Tipomov );
       QSaidax:=sqltoquery('select movd_pecas from movabatedet inner join movabate on ( mova_transacao=movd_transacao )'+
                      ' where movd_numerodoc='+EdNumerodoc.assql+
                      ' and '+FGeral.Getin('movd_unid_codigo',Global.CodigoUnidade,'C')+
                      ' and movd_esto_codigo='+Stringtosql(produto)+
                      ' and movd_status=''N'''+
                      sqldata+sqltipomov+
                      ' order by movd_ordem' );

       pecaspesadas:=0;
       while not Qsaidax.eof do begin
//           inc(pecaspesadas);
// 01.03.16 - ajustado devido a informacao do numero de pe�as
           pecaspesadas:=pecaspesadas+QSaidax.fieldbyname('movd_pecas').asinteger;
           QSaidax.Next;
       end;
       FGeral.FechaQuery(Qsaidax);
       if pecaspesadas <> Strtoint( GridPedido.cells[GridPedido.getcolumn('mpdd_pecas'),r] ) then begin
          Avisoerro('Produto '+GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),r]+
                    ' - '+GridPedido.cells[GridPedido.getcolumn('esto_descricao'),r]+
                    ' com '+inttostr(pecaspesadas)+' pe�as pesadas');
          result:=false;
//          exit;
       end;
     end;
  end;

end;

procedure TFPesagemSaida.bretnropedidoClick(Sender: TObject);
begin
   EdNumerodoc.setfocus;
end;

procedure TFPesagemSaida.bimpetiquetaClick(Sender: TObject);
////////////////////////////////////////////////////////////////
begin

//  ImpEtiqueta;
// 01.08.12  - na novi inibido por enquanto
   EdSeqi.Visible:=true;
   EdSeqf.Visible:=true;
   EdSeqi.setfocus;

end;

procedure TFPesagemSaida.ConfiguraTeclas( Key: Word );
///////////////////////////////////////////////////////
begin
 if key = vk_f4 then blebalancaClick(self)
 else if key = vk_f5 then bimpetiquetaClick(self)
 else if key = vk_f3 then bretnropedidoClick(self)
 else if key = vk_f6 then bSairClick(self)
 else if key = vk_f10 then bgeranotaClick(self)
// else if key = VK_f9 then bnfbonificacaoClick(self)
// 20.09.19  - Wagner  - Tiago...proxima do F10...
 else if key = VK_f7 then bnfbonificacaoClick(self)
// 01.06.20  - ..
 else if key = VK_f8 then bpedidomovelclick(self)
 else if key = vk_f11 then bromaneioClick(self)
 else if key = VK_Back then bnotaspendentesclick(self)
 else if key = vk_f2 then bexcluipesagemClick(self);


end;

// 19.12.17
procedure TFPesagemSaida.GridItensClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

  if Global.Usuario.OutrosAcessos[0518] then begin

    if GridItens.Col=GridItens.GetColumn('movd_pesocarcaca') then begin
       Edpesobalanca.Top:=GridItens.TopEdit;
       Edpesobalanca.Left:=GridItens.LeftEdit;
       Edpesobalanca.setvalue( Texttovalor(GridItens.Cells[GridItens.Col,GridItens.Row]) );
       Edpesobalanca.Height:=29;
       Edpesobalanca.Visible:=True;
       Edpesobalanca.Enabled:=True;
       Edpesobalanca.SetFocus;
    end else if GridItens.Col=GridItens.GetColumn('movd_vlrarroba') then begin
       EdUnitario.Top:=GridItens.TopEdit;
       EdUnitario.Left:=GridItens.LeftEdit;
       EdUnitario.SetValue(TextToValor(GridItens.Cells[GridItens.Col,GridItens.Row]));
       EdUnitario.Visible:=True;
       EdUnitario.enabled:=True;
       EdUnitario.Height:=29;
       EdUnitario.SetFocus;
    end;


  end;


end;

procedure TFPesagemSaida.GridItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);

end;

procedure TFPesagemSaida.GridItensKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    GridItensClick(Self);

end;

procedure TFPesagemSaida.ImpEtiqueta(OP:string='Imp');
///////////////////////////////////////////////////////
var produto,sql,ordem:string;
begin
  if trim( GridItens.cells[GridItens.getcolumn('movd_seq'),GridItens.row] )='' then begin
    Avisoerro('Nenhum peso indicado');
    exit;
  end;
// 10.08.12 - inibido por enquanto
  exit;

  produto:=trim( GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] );
  if op='Imp' then
    ordem:=Inttostr( strtoint( GridItens.cells[GridItens.getcolumn('movd_seq'),GridItens.row] ) )
  else begin
    if seq=1 then
      ordem:=Inttostr(seq)
    else
      ordem:=Inttostr(seq-1);
  end;
  sql:='select movd_esto_codigo,movd_pesocarcaca,movd_pecas,estoque.*,clientes.* from movabatedet'+
       ' inner join movabate on ( mova_transacao=movd_transacao )'+
       ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
       ' inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
//       ' where movd_transacao='+Stringtosql(transacao)+
       ' where movd_numerodoc='+EdNumerodoc.assql+
       ' and movd_esto_codigo='+Stringtosql(produto)+
       ' and movd_tipomov='+Stringtosql(Tipomov)+
       ' and movd_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
       ' and mova_numerodoc='+EdNumerodoc.assql+
       ' and mova_tipomov='+Stringtosql(Tipomov)+
//       ' and movd_ordem='+Inttostr( strtoint( GridItens.cells[GridItens.getcolumn('movd_seq'),GridItens.row] ) )+
       ' and movd_ordem='+ordem+
       ' and movd_status=''N''';
  if Global.Topicos[1213] then
    FImpressao.ImprimeEtqBalanca(sql,1,'X','N')
//  end else if Global.Topicos[1216] then begin
  else
    FImpressao.ImprimeEtqBalanca(sql,1,'ACBR','N');


end;

procedure TFPesagemSaida.bromaneioClick(Sender: TObject);
begin
  FRelGerenciais_EntradadeAbate(EdNumerodoc.asinteger,Global.CodigoUnidade,'SA');

end;

// 22.11.17
procedure TFPesagemSaida.bnfbonificacaoClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
var feznfcomdif:boolean;

    function NotaJaGerada:boolean;
    /////////////////////////////////
    var QPEd:TSQlQuery;
        sqlaberto,sqlwhere,sqldata,sqlunidades:string;
    begin
      result:=false;
      sqlaberto:=' and '+Fgeral.getin('mped_situacao','P;A;E','C');
      sqlwhere:=' where '+FGEral.getin('mped_status','N;','C')+' and mped_numerodoc='+EdNumerodOC.AsSql;
      sqldata:=' and mped_dataemissao >= '+Datetosql(DAtaPedido);
      sqlunidades:=' and '+FGeral.Getin('mped_unid_codigo',Global.CodigoUnidade,'C');
      QPed:=sqltoquery('select * from movped '+
                              sqlwhere+
                              sqlaberto+sqldata+sqlunidades+
                              ' order by mped_datamvto,mped_numerodoc');

      if QPed.fieldbyname('mped_situacao').asstring='E' then begin
        result:=true;
        Avisoerro('Pedido j� gerado na nota '+QPed.fieldbyname('mped_nfvenda').asstring+
                  ' de '+FGeral.FormataData(QPed.fieldbyname('mped_datanfvenda').asdatetime) );
      end;
      FGeral.FechaQuery(qPed);
    end;

begin
////////////////////////////
  if Fgeral.GetConfig1AsInteger('ConfMovBonif')=0 then begin
    Avisoerro('Falta configurar tipo de saida referente bonifica��o');
    exit;
  end;
// 27.11.17
  if EdNumerodoc.IsEmpty then exit;

  feznfcomdif:=false;
  if NotaJaGerada then
    exit;
  if not ConferePecasTodas then begin
    feznfcomdif:=confirma('Gerar BONIFICA��O  assim mesmo ?');
    if not feznfcomdif then exit;
  end;

  FNotaSaida.Execute('G','N',Fgeral.GetConfig1AsInteger('ConfMovBonif'),EdNumerodoc.AsInteger,
                     CodigoCliente,QPedido.fieldbyname('mped_fpgt_codigo').asstring,'',
                     QPedido.fieldbyname('mped_port_codigo').asstring,Texttovalor(PValortotal.caption));

  if feznfcomdif then
    FGeral.GravaLog(25,'Gerado nota com diferen�a ',false);

end;

procedure TFPesagemSaida.bnotaspendentesClick(Sender: TObject);
begin
  FExpNfetxt.Execute(0,'n�o Autorizadas');
end;

procedure TFPesagemSaida.bpedidomovelClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin

    Fdiversos.eddata.setdate( Sistema.Hoje-1 );
    FDiversos.mostramens:='S';
    FDiversos.bimportarClick(self);
    FDiversos.Close;
    EdNumerodoc.Text := GetUlitmoNumeroPedidoMovel;
    EdNumerodoc.SetFocus;
    EdNUmerodoc.Next;

end;

procedure TFPesagemSaida.EdPecasValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
var balanca,xbalancas:string;
    PesoPedido,PesoEstoque,maximotolerancia,toleranciaproduto:currency;
    QE,QRast:Tsqlquery;
    Lista:TStringList;
    p:integer;


    function UsaGancheira(xproduto:string):boolean;
    ///////////////////////////////////////////////////
    var Lista:TStringList;
        p:integer;
    begin
      Lista:=TStringList.create;
      result:=false;
      strtolista(Lista,FGeral.GetConfig1AsString('Codigoscomgancho'),';',true);
      for p:=0 to Lista.count-1 do begin
        if Lista[p]=xproduto then begin
          result:=true;
          break;
        end;
      end;
    end;

    function UsaGancheiraMenos1(xproduto:string):boolean;
    ///////////////////////////////////////////////////
    var Lista:TStringList;
        p:integer;
    begin
      Lista:=TStringList.create;
      result:=false;
      strtolista(Lista,FGeral.GetConfig1AsString('Codigosgancho1'),';',true);
      for p:=0 to Lista.count-1 do begin
        if Lista[p]=xproduto then begin
          result:=true;
          break;
        end;
      end;
    end;


begin
///////////////////////////////////////////////////////////////////

   EdPeso.text:='';
//   if Global.Topicos[1408] then begin
// 19.04.15
   if not Global.Usuario.OutrosAcessos[0509] then begin
//     PIns.Visible:=true;
//     PIns.Enabled:=true;
     EdPeso.Enabled:=true;
     EdPeso.Visible:=true;
     EdPeso.setfocus;
   end else begin
//     PIns.Visible:=false;
//     PIns.Enabled:=false;
//     EdPeso.Visible:=false;
     EdPeso.Enabled:=false;
//     EdPeso.Enabled:=false;
    end;

// 23.02.16
    Pesobalanca:=EdPeso.ascurrency;
    QE:=Sqltoquery('select esto_qbalanca,esto_tara,esto_peso,esto_taracf,esto_taraperc,esto_grup_codigo from estoque where esto_codigo='+
                    Stringtosql( GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]) );
    balanca:=QE.fieldbyname('esto_qbalanca').asstring;
// 12.03.19 - para ler as caixas do miudos q podem ser resfriadas ou congeldas...
    if TipoMovLido = 'ER' then

       Tara:=QE.fieldbyname('esto_taracf').ascurrency*EdPecas.ascurrency

    else

       Tara:=QE.fieldbyname('esto_tara').ascurrency*EdPecas.ascurrency;

    PesoEstoque:=QE.fieldbyname('esto_peso').ascurrency;
// 20.09.18
//    toleranciaproduto:=QE.FieldByName('esto_taraperc').AsCurrency;
// 10.01.20
    toleranciaproduto:=FGrupos.GetTolerancia( QE.FieldByName('esto_grup_codigo').AsInteger);
// 15.01.19 -
    if (not Edprodutoven.IsEmpty) and ( EdProduto.IsEmpty )then codigolido:=Edprodutoven.text;

// 16.05.14 - cortes que usam gancho
//    if pos( GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] ,FGeral.GetConfig1AsString('Codigoscomgancho') ) >0 then
// 01.09.14
    if UsaGancheira( GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] ) then begin
       PesoBalanca:=Pesobalanca-FGeral.GetConfig1AsFloat('DESCPESO');
// 10.06.15
       if UsaGancheiraMenos1( GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] ) then begin
         tara:=tara+(FGeral.GetConfig1AsFloat('DESCPESOGANCHO')*(Edpecas.AsCurrency-1))+FGeral.GetConfig1AsFloat('DESCPESO');
         PesoBalanca:=Pesobalanca + (Edpecas.ascurrency*FGeral.GetConfig1AsFloat('DESCPESOGANCHO')) +
                      FGeral.GetConfig1AsFloat('DESCPESOGANCHO');
       end else begin
// 20.09.18 - boi casado com corte 'despaleteado'...
        if BoiCasadoCorte = 'S' then
           tara:=tara+(FGeral.GetConfig1AsFloat('DESCPESOGANCHO1')*Edpecas.AsCurrency)+FGeral.GetConfig1AsFloat('DESCPESO')
        else
           tara:=tara+(FGeral.GetConfig1AsFloat('DESCPESOGANCHO')*Edpecas.AsCurrency)+FGeral.GetConfig1AsFloat('DESCPESO');

       end;
    end;

    Ppesobalanca.caption:=FGeral.Formatavalor(pesobalanca,f_cr);

// Isonel resolver nao tarar a balanca de inicio
// entao sera descontada a tara que estiver no produto

//    Aviso( 'Abrindo porta balan�a='+balanca);

    FGeral.FechaQuery(QE);

//    abrirporta( balanca );

// 08.09.15
    if Global.Usuario.OutrosAcessos[0509] then begin
// 10.04.18
      if global.Usuario.Codigo=101 then begin

        EdPeso.SetValue(060);

      end else begin

          if Ansipos(';',balanca) > 0 then begin

             Lista:=TStringList.Create;
             strtolista(Lista,balanca,';',true );
             balanca:=SelecionaItems(Lista,'Qual Balan�a ?');

              abrirporta( balanca );
              if (balanca='BAL1') then
                AcbrBal1.LePeso( 500 )
              else if (balanca='BAL2') then
                AcbrBal2.LePeso( 500 )
              else
                AcbrBal3.LePeso( 500 );


          end else begin

              abrirporta( balanca );
              if (balanca='BAL1') or ( trim(balanca)='') then
                AcbrBal1.LePeso( 500 )
              else if (balanca='BAL2') then
                AcbrBal2.LePeso( 500 )
              else
                AcbrBal3.LePeso( 500 );
          end;

      end;

    end;

    if EdPeso.ascurrency>=0 then begin
// 13.06.17
       pesobalanca:=EdPeso.AsCurrency;
       EdPeso.setvalue( EdPeso.ascurrency - tara );
    end;


    {   // retirado em 25.09.18 para ficar somente uma checagem de peso
    PesoPedido:=TextToValor( GridPedido.cells[GridPedido.getcolumn('mpdd_qtde'),GridPedido.row] );
    if (EdPeso.ascurrency>0) then PPeso.caption:=TRansform( EdPeso.ascurrency, f_cr3 );
// 08.09.15 - Iso...dianteiro ' + caro'
    if ( EdPeso.ascurrency>0 ) and (PesoEstoque>0) and (EdPeso.ascurrency>MaximoTolerancia) then begin
      Avisoerro('Peso acima do permitido.  Checar para troca de codigo');
      AcbrBal1.Desativar;
      AcbrBal2.Desativar;
      exit;
    end;

    }


// 14.05.18 - 25.09.18
   if (FGeral.GetConfig1AsFloat('pertolerbavendas') > 0 ) or ( toleranciaproduto>0 )
   then begin
   {
     TransacaoGerada:=copy(EdProduto.Text,1,length(EdProduto.Text)-1);
     QRast:=sqltoquery('select movd_esto_codigo,movd_pesocarcaca from movabatedet ' +
                             ' inner join movabate on ( mova_transacao=movd_transacao )'+
                             ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                             ' where movd_operacao = '+Stringtosql(TransacaoGerada)+
                             ' and movd_status = ''N'''+
                             ' and movd_tipomov = '+Stringtosql('PC')+
                             ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade) );
                             }
//    PesoComposicao:=QPedido.FieldByName('movd_pesocarcaca').AsCurrency;
//    if not QRast.Eof then PesoComposicao:=
//       FComposicao.GetPesoComposicao(QRast.fieldbyname('movd_esto_codigo').asstring,
//                                                             EdProdutoVen.Text,
//                                                             QRast.fieldbyname('movd_pesocarcaca').ascurrency);

//     QRast.close;
////////////////

// 24.09.18 - miudos ( bucho...) e outros e ainda nao leem pela etiqueta
     if EdProduto.IsEmpty then PesoComposicao:=PesoEstoque;

     if toleranciaproduto>0 then
       maximotolerancia:= PesoComposicao*(toleranciaproduto/100)*EdPecas.AsCurrency
     else
       maximotolerancia:= PesoComposicao*(FGeral.GetConfig1AsFloat('pertolerbavendas')/100);

//     if Pesocomposicao>0 then begin

        if (Abs(PesoComposicao-EdPeso.AsCurrency) > maximotolerancia) and (maximotolerancia>0) then begin
//          Avisoerro('Peso acima da tolerancia por PE�A(S). '+FGeral.Formatavalor(Pesocomposicao,f_cr) );
          Avisoerro('Peso acima da tolerancia por PE�A(S). Peso Abate '+FGeral.Formatavalor(Pesocomposicao,f_cr)+
                     ' Toler�ncia '+FGeral.Formatavalor(maximotolerancia,f_cr) );
          AcbrBal1.Desativar;
          AcbrBal2.Desativar;
          AcbrBal3.Desativar;
          exit;
        end;

//     end;

//   Aviso( 'Peso Composicao '+FGeral.Formatavalor(Pesocomposicao,f_cr) );
   end;



// 05.03.15 -senao grava duas vezes
//   if not Global.Topicos[1408] then begin
// 19.04.15
   if Global.Usuario.OutrosAcessos[0509] then begin
      if (EdPeso.ascurrency>0) and ( EdPeso.ascurrency<PesoPedido ) then begin
          if confirma('Peso da balan�a menor que o peso m�nimo.  Confirma ?') then begin
            FGeral.GravaLog(26,'Peso balan�a '+EdPeso.assql+' Peso pedido '+Valortosql(pesopedido)+' Pedido '+EdNumerodoc.text);
            GravaPeso;
          end;
      end else if EdPeso.ascurrency>0 then GravaPeso;
    end;

    Pmens.Caption:=pmens.Caption+' '+transform(tara,f_cr);

// 14.08.12
//   Aviso('fechando portas');
//    xSerial1.close;
//    serial2.close;
    AcbrBal1.Desativar;
    AcbrBal2.Desativar;
    AcbrBal3.Desativar;
// 28.09.18
   GridPedido.setfocus;


////////////////////////////////////////////

end;

// 19.12.17
procedure TFPesagemSaida.EdpesobalancaExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////////
var sqltipomov,produto:string;
begin

  if not EdPesobalanca.IsEmpty then begin
    GridItens.Cells[GridItens.Col,GridItens.Row]:=(Edpesobalanca.Text);
    Sqltipomov:=' and movd_tipomov='+Stringtosql( Tipomov );
    produto:=trim(GridPedido.Cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]);
    Sistema.Edit('movabatedet');
    Sistema.SetField('movd_pesocarcaca',EdPesobalanca.AsCurrency);
    Sistema.Post('movd_numerodoc='+EdNumerodoc.assql+
                  ' and '+FGeral.Getin('movd_unid_codigo',Global.CodigoUnidade,'C')+
                  ' and movd_esto_codigo='+Stringtosql(produto)+
                  ' and movd_status=''N'''+
                  ' and movd_ordem = '+GridItens.Cells[gridItens.getcolumn('movd_seq'),GridItens.row]+
                   sqltipomov);

    Sistema.Commit;

//    GridItens.cells[GridItens.getcolumn('movd_pesocarcaca'),x]:=formatfloat(f_cr3,QSaida.fieldbyname('movd_pesocarcaca').asfloat);
//    GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),x]:=formatfloat(f_cr,QSaida.fieldbyname('movd_vlrarroba').asfloat);
//    GridItens.Cells[gridItens.getcolumn('movd_seq'),x]:=strzero(strtoint(QSaida.fieldbyname('movd_ordem').Asstring),3)



  end;
  GridItens.SetFocus;
  EdPesoBalanca.Enabled:=False;
  EdPesoBalanca.visible:=False;

end;

procedure TFPesagemSaida.AcbrBal1LePeso(Peso: Double; Resposta: AnsiString);
////////////////////////////////////////////////////////////////////////////
var valid : integer;
    xResposta,outra:string;
begin


//   pPeso.Caption     := formatFloat('##0.000', Peso );

//   xResposta := copy( Converte( Resposta ) ,1,15)  ;
   xResposta := copy( Resposta,3,15)  ;

//   outra:=Acbrbal1.Device.LeString(200,11);
//   ptotalpesado.Caption:=outra;

   pPeso.Caption := xResposta ;
//   pNomeProduto.Caption:=Resposta;
//   PMens.Caption := formatFloat('###0.000', Peso )+' xResposta = '+xResposta;

   if FGeral.GetConfig1AsInteger('DIVBAL01')>0 then
        peso:=Texttovalor(xresposta)/FGeral.GetConfig1AsInteger('DIVBAL01')
   else
        peso:=Texttovalor(xresposta);

//   pPeso.Caption     := formatFloat('###0.000', Peso );

    if Peso >= 0 then begin
//      PMens.Caption := 'Leitura OK !';
      PMens.Caption := resposta+' - '+xresposta;
      EdPeso.SetValue(peso);
      pPeso.Caption     := formatFloat('###0.00', Peso );
   end else
    begin
      valid := Trunc(AcbrBal1.UltimoPesoLido);
//      {
      case valid of
         0 : PMens.Caption := 'TimeOut !'+sLineBreak+
                                 'Coloque o produto sobre a Balan�a!' ;
        -1 : PMens.Caption := 'Peso Instavel ! ' +sLineBreak+
                                 'Tente Nova Leitura' ;
        -2 : PMens.Caption := 'Peso Negativo !' ;
       -10 : PMens.Caption := 'Sobrepeso !' ;
      end;
//      }
    end ;

end;

function TFPesagemSaida.Converte(cmd: String): String;
//////////////////////////////////////////////////////////////
var A : Integer ;
begin
  Result := '' ;
  For A := 1 to length( cmd ) do
  begin
     if not (cmd[A] in ['A'..'Z','a'..'z',
//     if not (cmd[A] in ['0'..'9','P','L',':','*',
                        ' ','.',',','/','?','<','>',';',':',']','[','{','}',
                        '\','|','=','+','_',')','(','*','&','^','%','$',
                        '#','@','!','~',']' ]) then
//        Result := Result + '#' + IntToStr(ord( cmd[A] )) + ' '
     else
        Result := Result + cmd[A] + ' ';

  end ;


end;

// 02.03.15 - pra ver se para de 'nao excluir' algumas vezes
procedure TFPesagemSaida.FormActivate(Sender: TObject);
/////////////////////////////////////////////////////////
begin
   Unidade:=Global.CodigoUnidade;

end;

// 02.03.15
procedure TFPesagemSaida.ACBrBAL2LePeso(Peso: Double; Resposta: AnsiString);
///////////////////////////////////////////////////////////////////////////////
var valid : integer;
    xResposta,outra:string;
begin
   xResposta := copy( Resposta,3,15)  ;

   pPeso.Caption := xResposta ;

   if FGeral.GetConfig1AsInteger('DIVBAL02')>0 then
        peso:=Texttovalor(xresposta)/FGeral.GetConfig1AsInteger('DIVBAL02')
   else
        peso:=Texttovalor(xresposta);
    if Peso >= 0 then begin
//      PMens.Caption := 'Leitura OK !';
      PMens.Caption := resposta+' - '+xresposta;
      EdPeso.SetValue(peso);
      pPeso.Caption     := formatFloat('###0.00', Peso );
   end else
    begin
      valid := Trunc(AcbrBal1.UltimoPesoLido);
//      {
      case valid of
         0 : PMens.Caption := 'TimeOut !'+sLineBreak+
                                 'Coloque o produto sobre a Balan�a!' ;
        -1 : PMens.Caption := 'Peso Instavel ! ' +sLineBreak+
                                 'Tente Nova Leitura' ;
        -2 : PMens.Caption := 'Peso Negativo !' ;
       -10 : PMens.Caption := 'Sobrepeso !' ;
      end;
//      }
    end ;

end;

// 20.11.18 - 3a. balan�a
procedure TFPesagemSaida.ACBrBAL3LePeso(Peso: Double; Resposta: AnsiString);
////////////////////////////////////////////////////////////////////////////
var valid : integer;
    xResposta,outra:string;
begin

   xResposta := copy( Resposta,3,15)  ;
   pPeso.Caption := xResposta ;
   if FGeral.GetConfig1AsInteger('DIVBAL03')>0 then
        peso:=Texttovalor(xresposta)/FGeral.GetConfig1AsInteger('DIVBAL03')
   else
        peso:=Texttovalor(xresposta);

    if Peso >= 0 then begin
      PMens.Caption := resposta+' - '+xresposta;
      EdPeso.SetValue(peso);
      pPeso.Caption     := formatFloat('###0.00', Peso );
   end else
    begin
      valid := Trunc(AcbrBal3.UltimoPesoLido);
//      {
      case valid of
         0 : PMens.Caption := 'TimeOut !'+sLineBreak+
                                 'Coloque o produto sobre a Balan�a!' ;
        -1 : PMens.Caption := 'Peso Instavel ! ' +sLineBreak+
                                 'Tente Nova Leitura' ;
        -2 : PMens.Caption := 'Peso Negativo !' ;
       -10 : PMens.Caption := 'Sobrepeso !' ;
      end;
//      }
    end ;


end;

procedure TFPesagemSaida.APHeadLabel1DblClick(Sender: TObject);
begin
end;

// 15.06.16
procedure TFPesagemSaida.EdProdutoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////
var sqlaberto,sqlwhere,sqlwhered,sqldata,sqltipomova,sqltipomovd,sqlunidades,tipomov:string;
    QPedido,
    QOutraEtq:TSqlquery;
    PesoOutraEtiqueta:currency;


    function InicioDescricao(produtopedido,produtopesado:string):boolean;
    //////////////////////////////////////////////////////////////////////
    var descr1,descr2:string;
    begin

//      descr1:=FEstoque.GetDescricao(produtopedido);
//      descr2:=FEstoque.GetDescricao(produtopesado);
//      result:=AnsiPos( copy(descr1,1,05),descr2) >0;
        descr1:=inttostr( FEstoque.GetSubGrupo(produtopedido) );
        descr2:=inttostr( FEstoque.GetSubGrupo(produtopesado) );
        if strtoint( descr1 ) <> strtoint( descr2) then
           result:=false
        else
          result:=true;

    end;

    function GetValidade:TDatetime;
    ///////////////////////////////
    begin


// 17.10.19 - Novicarnes - Vanderlei
         if  QPedido.FieldByName('movd_tipomov').AsString=TipoMovCongelado then begin

             if  QPedido.FieldByName('esto_validaderes').AsInteger=0 then begin

                 result:= ( 180 +
                       QPedido.FieldByName('movd_datamvto').AsDatetime ) +
                       3;

             end else

              result:= ( QPedido.FieldByName('esto_validaderes').AsInteger +
                       QPedido.FieldByName('movd_datamvto').AsDatetime ) +
                       3;


         end else begin

             if  QPedido.FieldByName('esto_validade').AsInteger=0 then begin

    //             Aviso('Produto '+QPedido.FieldByName('esto_codigo').AsString+' sem validade informada no cadastro');
    //            // deixa passar sem validar jogando 90 dias de validade
                 result:= ( 90 +
                       QPedido.FieldByName('movd_datamvto').AsDatetime ) +
                       3;

             end else

              result:= ( QPedido.FieldByName('esto_validade').AsInteger +
                       QPedido.FieldByName('movd_datamvto').AsDatetime ) +
                       3;
         end;

    end;


begin

   EdProdutoven.enabled:=false;
// 19.09.18
   BoiCasado:='N';
   BoiCasadoCorte:='N';
// 08.01.19 - codigo do q foi lido e n�o o do pedido
   CodigoLido:='';
// 14.03.19
   TipoMovLido:='PC';

   if ( Global.Usuario.OutrosAcessos[0516] )   then begin
     if EdProduto.IsEmpty then begin
// 23.09.17
       if ChecaCodBarra='S' then begin
         if FGrupos.GetUsocodBarra( FEstoque.GetGrupo( GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] ) ) = 'S' then begin
           EdProduto.invalid('Obrigat�rio pesar utilizando codigo de barra');
         end else begin
           EdProdutoven.Text:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row];
           exit;
         end;
       end else begin
         EdProdutoven.Text:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row];
         exit;
       end;
     end;
   end else if EdProduto.IsEmpty then begin

     EdProduto.Invalid('Obrigat�rio informar codigo da etiqueta');

   end;

   tipomov:='PC';
//   sqlaberto:=' and '+Fgeral.getin('mova_situacao','P','C');
// 15.05.17 - para achar os da entrada de abate quando � a tal venda casada
   sqlaberto:=' and '+Fgeral.getin('mova_situacao','N;P','C');
   sqlwhere:=' where '+FGEral.getin('mova_status','N;','C')+' and mova_operacao='+EdProduto.AsSql;
   sqlwhered:=' where '+FGEral.getin('movd_status','N;','C')+' and movd_operacao='+EdProduto.AsSql;
   sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
// 08.03.19 - para achar as etiquetas geradas na desossa -> caixas congelado ou resfriado
   sqltipomovd:=' and '+fGeral.Getin('movd_tipomov',Tipomov+';ER;EC','C');
   sqltipomova:=' and '+fGeral.Getin('mova_tipomov',Tipomov+';ER;EC','C');
   sqlunidades:=' and '+FGeral.Getin('mova_unid_codigo',Global.CodigoUnidade,'C');
   QPedido:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc )'+
                       ' inner join estoque on ( esto_codigo = movd_esto_codigo )'+
                       sqlwhered+' and '+FGEral.getin('movd_status','N;','C')+
                       sqlaberto+sqldata+sqlunidades+
                       sqltipomovd+
                       ' order by mova_dtabate,movd_numerodoc,movd_ordem');
   OPeracaoPesada:='';
// 19.09.18
   BoiCasado:='N';
   BoiCasadoCorte:='N';
   TransacaoPesada:='';
   TransacaoGerada:=QPedido.FieldByName('mova_transacaogerada').AsString;
   OrdemPesada:=0;

   IncluiPed:='N';
// 14.05.18 - variacao maxima e relacao ao peso estimado na composicao ( 5% )
   PesoComposicao:=QPedido.FieldByName('movd_pesocarcaca').AsCurrency;
// 08.01.19 - codigo do q foi lido e n�o o do pedido
   if (not QPedido.eof) then  begin

      codigolido    := QPedido.fieldbyname('movd_esto_codigo').AsString;
      tipomovlido   := QPedido.fieldbyname('movd_tipomov').AsString;

   end;

   if (QPedido.eof) then begin
     EdProduto.INvalid('Etiqueta n�o encontrada');

// 09.05.17
   end else if ( QPedido.fieldbyname('movd_pesobalanca').AsCurrency > 0 )
// 30.01.19 - Novicarnes - devido ao novo esquema de gerar nova com o q foi lido dai
//            nao encontra composi��o para fazer o rateio do peso
            or
               ( QPedido.fieldbyname('movd_brinco').AsString <> '' )
      then begin

     EdProduto.INvalid('Etiqueta j� pesada');

// 29.05.19
   end else if ( Global.Topicos[1056] )
            and
//               ( Global.Usuario.Codigo >= 100 )
//            and
               ( Sistema.Hoje >  GetValidade )
      then begin

     EdProduto.INvalid('Etiqueta vencida em '+FGeral.FormataData(GetValidade));

//  07.07.17 - tirado a 'regra da carca�a' - recolocado em 10.07.17
   end else if pos('CARCA',Uppercase(QPedido.fieldbyname('esto_descricao').AsString)) > 0 then begin

//     if JaVendeuPedaco( EdNumerodoc.Text,'S' ) then EdProduto.Invalid('')
// 04.07.2017
//     if QPedido.fieldbyname('movd_esto_codigo').AsString<>GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] then begin
// 02.10.18 - deixar pesar 'somente traseiro e dianteiro' quando for carca�a e dai
//            pedir se � boi casado
     if ( AnsiPos('TRASEIRO',UpperCase(QPedido.fieldbyname('esto_descricao').AsString)) > 0 )
        OR
        ( AnsiPos('DIANTEIRO',UpperCase(QPedido.fieldbyname('esto_descricao').AsString)) > 0 )
         then begin

// 19.07.18 - pedir se � boi casadoo dai baixa etiqueta 'origem' da q esta sendo lida
// 19.09.18 - devido a mudan�as das etiquetas no abate tem q somar o peso da 'outra' etiqueta
//            feita, ou seja, se ler o traseiro tem q buscar o dianteiro e vice versa..
//            e baixar a etiqueta somada para passar na balan�a sem dar problema com
//            a tolerancia de peso

       if Confirma('Etiqueta ref. Casado ?') then begin
// 30.10.18
//       if False then begin

         OPeracaoPesada :=QPedido.FieldByName('movd_operacao').AsString;
         TransacaoPesada:=QPedido.FieldByName('movd_transacao').AsString;
// 30.10.18
         OrdemPesada    :=QPedido.FieldByName('movd_ordem').AsInteger;
         BoiCasado:='S';
         BoiCasadoCorte:='N';
// 11.01.19 - codigo do q foi lido e n�o o do pedido  MENOS no boi casado
         codigolido:=FComposicao.GetCodigoOrigem( codigolido );
// 16.01.20
         if trim(codigolido)='' then codigolido:=EdProdutoven.Text;

// gambiarra para fixar o codigo da meia carca�a de boi quando le etiqueta de boi
         if AnsiPos( 'DE BOI',UpperCase(QPedido.fieldbyname('esto_descricao').AsString) ) > 0 then
            codigolido:='49'
// 16.01.20
         else if AnsiPos( 'DE VACA',UpperCase(QPedido.fieldbyname('esto_descricao').AsString) ) > 0 then
//            codigolido:='94'
// 24.04.20
            codigolido:='6'
// 07.02.20
         else if AnsiPos( 'DE NOVILHA',UpperCase(QPedido.fieldbyname('esto_descricao').AsString) ) > 0 then
            codigolido:='96';

// 29.01.19
//         codigolido:=GetCodigoOrigem( TransacaoPesada,OperacaoPesada,OrdemPesada )  ;
// 29.01.19 - retirado pois nao � mais feito etiqueta de meia carca�a...

// 20.09.18
//////////         if Confirma('� com cortes ?') then Boicasadocorte:='S';

// 19.09.18
         PesoOutraEtiqueta:=0;
         QOutraEtq:=sqltoquery('select movd_pesocarcaca from movabatedet where movd_tipomov = '+Stringtosql(TipoEntradaAbate)+
                               ' and movd_status = ''N'''+
                               ' and movd_transacao = '+Stringtosql(TransacaoPesada)+
                               ' and movd_ordem = '+inttostr(ordempesada) );
         if not QOutraEtq.eof then PesoOutraEtiqueta:= QOUtraEtq.fieldbyname('movd_pesocarcaca').ascurrency/2
         else PesoOutraEtiqueta:=0;
         FGEral.FechaQuery( QOutraEtq );

//         PesoComposicao:=PesoComposicao+PesoOutraEtiqueta;
// 16.01.20
         PesoComposicao:=PesoOutraEtiqueta;

         EdPecas.text:='1';
         EdProdutoven.Text:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row];
         EdPecas.Enabled:=false;
         EdPecas.valid;
         PNomeProduto.Caption:=GridPedido.cells[GridPedido.getcolumn('esto_descricao'),GridPedido.row];

       end else if confirma('Codigo da etiqueta � '+ QPedido.FieldByName('movd_esto_codigo').asstring+' -  '+QPedido.fieldbyname('esto_descricao').AsString+' Confirma mesmo assim ?' ) then begin

         OPeracaoPesada:=QPedido.FieldByName('movd_operacao').AsString;
         EdPecas.text:='1';
         EdProdutoven.Text:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row];
         EdPecas.Enabled:=false;
         EdPecas.valid;
         PNomeProduto.Caption:=QPedido.fieldbyname('esto_descricao').AsString;
//         IncluiPed:='S';
// 02.04.18 - inibido por enquanto ate ajeitar 'td de novo'
         IncluiPed:='N';
       end else begin

         PNomeProduto.Caption:=QPedido.fieldbyname('esto_descricao').AsString;
         EdProduto.Invalid('Codigo lido diferente codigo do pedido')

       end;

     end else begin

       OPeracaoPesada:=QPedido.FieldByName('movd_operacao').AsString ;
       TransacaoPesada:=QPedido.FieldByName('movd_transacao').AsString ;
       EdPecas.text:='1';
       EdPecas.Enabled:=false;
       EdPecas.valid;
// 26.07.17
       EdProdutoven.Text:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row];
       PNomeProduto.Caption:=QPedido.fieldbyname('esto_descricao').AsString;

     end;

// 19.07.18
////////////////////////////////////////////////////
   end else if pos('CARCA',Uppercase(GridPedido.cells[GridPedido.getcolumn('esto_descricao'),GridPedido.row])) > 0 then begin

// 02.10.18
     if ( AnsiPos('TRASEIRO',UpperCase(QPedido.fieldbyname('esto_descricao').AsString)) > 0 )
        OR
        ( AnsiPos('DIANTEIRO',UpperCase(QPedido.fieldbyname('esto_descricao').AsString)) > 0 )
         then begin

// 19.07.18 - pedir se � boi casado dai baixa etiqueta 'origem' da q esta sendo lida
       if Confirma('Etiqueta ref. Casado ?') then begin
// 30.10.18
//       if False then begin

         BoiCasado:='S';
         TransacaoPesada:=QPedido.FieldByName('movd_transacao').AsString;
         OPeracaoPesada:=QPedido.FieldByName('movd_operacao').AsString;
         OrdemPesada   :=QPedido.FieldByName('movd_ordem').AsInteger;
// 11.01.19 - codigo do q foi lido e n�o o do pedido MENOS no boi casado
         codigolido:=FComposicao.GetCodigoOrigem( codigolido );
// gambiarra para fixar o codigo da meia carca�a de boi quando le etiqueta de boi
         if AnsiPos( 'DE BOI',UpperCase(QPedido.fieldbyname('esto_descricao').AsString) ) > 0 then
            codigolido:='49'
// 08.07.19
         else if AnsiPos( 'DE VACA',UpperCase(QPedido.fieldbyname('esto_descricao').AsString) ) > 0 then
//            codigolido:='94'
// 24.04.20
            codigolido:='6'
// 07.02.20
         else if AnsiPos( 'DE NOVILHA',UpperCase(QPedido.fieldbyname('esto_descricao').AsString) ) > 0 then
            codigolido:='96';

// 25.01.19 - buscar pelo rastreamento e nao pela composi��o para nao ter quer criar muitos
//           codigos especifico de quarto traseiro e dianteiro ref. boi holandes
//         codigolido:=GetCodigoOrigem( TransacaoPesada,OperacaoPesada,OrdemPesada )  ;
// 29.01.19 - retirado pois n�o � mais feito etiqueta com codigo de meia carca�a

// 02.10.18
         PesoOutraEtiqueta:=0;
         QOutraEtq:=sqltoquery('select movd_pesocarcaca from movabatedet where movd_tipomov = '+Stringtosql('EA')+
                               ' and movd_status = ''N'''+
                               ' and movd_transacao = '+Stringtosql(TransacaoPesada)+
                               ' and movd_esto_codigo <> '+stringtosql(QPedido.FieldByName('movd_esto_codigo').AsString)+
//                               ' and ( (movd_pesobalanca is null) or (movd_pesobalanca=0) )'+
// 18.02.20
                               ' and movd_ordem = '+inttostr(ordempesada) +
                               ' and movd_operacao <> '+Stringtosql(OPeracaoPesada) );
         if not QOutraEtq.eof then PesoOutraEtiqueta:=QOUtraEtq.fieldbyname('movd_pesocarcaca').ascurrency/2
         else PesoOutraEtiqueta:=0;
         FGEral.FechaQuery( QOutraEtq );
////////////////////////////////////
// 16.01.20
//         PesoComposicao:=PesoComposicao+PesoOutraEtiqueta;
         PesoComposicao:=PesoOutraEtiqueta;

         EdPecas.text:='1';
         EdProdutoven.Text:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row];
         EdPecas.Enabled:=false;
         EdPecas.valid;
         PNomeProduto.Caption:=GridPedido.cells[GridPedido.getcolumn('esto_descricao'),GridPedido.row];

       end else if confirma('Codigo da etiqueta � '+ QPedido.FieldByName('movd_esto_codigo').asstring+' -  '+QPedido.fieldbyname('esto_descricao').AsString+' Confirma mesmo assim ?' ) then begin

         OPeracaoPesada:=QPedido.FieldByName('movd_operacao').AsString;
         Transacao     :=QPedido.FieldByName('movd_transacao').AsString;
         EdPecas.text:='1';
         EdProdutoven.Text:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row];
         EdPecas.Enabled:=false;
         EdPecas.valid;
         PNomeProduto.Caption:=QPedido.fieldbyname('esto_descricao').AsString;
         IncluiPed:='N';
       end else begin
         PNomeProduto.Caption:=QPedido.fieldbyname('esto_descricao').AsString;
         EdProduto.Invalid('Codigo lido diferente codigo do pedido')
       end;
 // 02.10.18
     end else if QPedido.fieldbyname('movd_esto_codigo').AsString<>GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] then begin

       EdProduto.invalid('Codigo da etiqueta � '+ QPedido.FieldByName('movd_esto_codigo').asstring+' -  '+QPedido.fieldbyname('esto_descricao').AsString );


     end else begin

       OPeracaoPesada :=QPedido.FieldByName('movd_operacao').AsString ;
       TransacaoPesada:=QPedido.FieldByName('movd_transacao').AsString ;
       EdPecas.text:='1';
       EdPecas.Enabled:=false;
       EdPecas.valid;
       EdProdutoven.Text:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row];
       PNomeProduto.Caption:=QPedido.fieldbyname('esto_descricao').AsString;

     end;
///////////////////////////////////////////////////////////////////////////

   end else if ( QPedido.FieldByName('movd_esto_codigo').asstring<> GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] ) then begin
// 22.05.17

     if InicioDescricao(QPedido.FieldByName('movd_esto_codigo').asstring,GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row])  then begin

       if confirma('Codigo da etiqueta � '+ QPedido.FieldByName('movd_esto_codigo').asstring+' -  '+QPedido.fieldbyname('esto_descricao').AsString+' Confirma mesmo assim ?' ) then begin

         OPeracaoPesada:=QPedido.FieldByName('movd_operacao').AsString;
         EdPecas.text:='1';
         EdProdutoven.Text:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row];
         EdPecas.Enabled:=false;
         EdPecas.valid;
         PNomeProduto.Caption:=QPedido.fieldbyname('esto_descricao').AsString;
//         IncluiPed:='S';
         IncluiPed:='N';

       end else EdProduto.Invalid('');

     end else  EdProduto.Invalid('Codigo da etiqueta � '+ QPedido.FieldByName('movd_esto_codigo').asstring+' -  '+QPedido.fieldbyname('esto_descricao').AsString);

   end else begin

       OPeracaoPesada:=QPedido.FieldByName('movd_operacao').AsString;
       EdProdutoven.Text:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row];
       EdPecas.text:='1';
       EdPecas.Enabled:=false;
       EdPecas.valid;
       PNomeProduto.Caption:=QPedido.fieldbyname('esto_descricao').AsString;

   end;
   FGeral.FechaQuery(QPedido);


end;

procedure TFPesagemSaida.EdSeqfValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
   if (EdSeqf.asinteger>0) and (EdSeqf.asinteger<EdSeqi.asinteger) then EdSeqf.invalid('Sequencial final tem que ser amior que inicial');

end;

// 19.12.17
procedure TFPesagemSaida.EdUnitarioExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////////
var produto,sqltipomov:string;
begin

  if not EdUnitario.IsEmpty then begin

    GridItens.Cells[GridItens.Col,GridItens.Row]:=(Edunitario.Text);
    Sqltipomov:=' and movd_tipomov='+Stringtosql( Tipomov );
    produto:=trim(GridPedido.Cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]);
    Sistema.Edit('movabatedet');
    Sistema.SetField('movd_vlrarroba',EdUnitario.AsCurrency);
    Sistema.Post('movd_numerodoc='+EdNumerodoc.assql+
                  ' and '+FGeral.Getin('movd_unid_codigo',Global.CodigoUnidade,'C')+
                  ' and movd_esto_codigo='+Stringtosql(produto)+
                  ' and movd_status=''N'''+
                  ' and movd_ordem = '+GridItens.Cells[gridItens.getcolumn('movd_seq'),GridItens.row]+
                   sqltipomov);

    Sistema.Commit;

  end;

  GridItens.SetFocus;
  EdUnitario.Enabled:=False;
  EdUnitario.visible:=False;


end;

// 16.06.16
procedure TFPesagemSaida.EdSeqfExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////
var totalpeso,totalitem:currency;
    Q1,QNutri,Qconserva:TSqlquery;
    sqlordem,codmuniemitente,s:string;
    i:integer;

begin

    EdSeqi.visible:=false;
    EdSeqf.visible:=false;
    EdNumerodoc.setfocus;
    ACBrNFe1.NotasFiscais.Clear;
    totalpeso:=0;
    if (EdSeqi.asinteger>0) and (EdSeqf.asinteger>0) then
      sqlordem:=' and movd_ordem >= '+EdSeqi.AsSql+' and movd_ordem <= '+EdSeqf.AsSql
    else if (EdSeqi.asinteger>0) then
      sqlordem:=' and movd_ordem = '+EdSeqi.AsSql
    else if (EdSeqf.asinteger>0) then
      sqlordem:=' and movd_ordem = '+EdSeqf.AsSql
    else
      sqlordem:='';

    AcbrNFe1.DANFE := TACBrNFeDANFCeFortesETQFAT.Create(AcbrNFe1);
    AcbrNfe1.DANFE.TipoDANFE := tiNFCE;
    if Global.usuario.outrosacessos[0510] then
      acbrnfe1.danfe.MostraPreview:=true
    else
      acbrnfe1.danfe.MostraPreview:=false;
    acbrnfe1.danfe.MargemEsquerda:=01;
    acbrnfe1.danfe.MargemDireita:=10;
    acbrnfe1.danfe.MargemSuperior:=18;
    acbrnfe1.danfe.MargemInferior:=10;
    acbrnfe1.danfe.NumCopias:=2;
//    if FileExists( ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg' ) then
//      acbrnfe1.danfe.Logo:=ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg';
    s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPETQCAM');
    if trim(s)<>'' then Acbrnfe1.DANFE.Impressora:=s;

      Q1:=sqltoquery('select * from movabatedet'+
                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                     ' inner join clientes on ( clie_codigo=movd_tipo_codigo )'+
                     ' left join ingredientes on (ingr_codigo=esto_ingr_codigo)'+
                     ' left join nutricionais on (nutr_codigo=esto_nutr_codigo)'+
                     ' where mova_numerodoc = '+EdNumerodoc.assql+
                     ' and movd_tipomov='+stringtosql(tipomov)+
                     ' and mova_tipomov='+stringtosql(tipomov)+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     sqlordem+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
                     ' order by movd_ordem' );
    while not Q1.eof do begin

      with  ACBrNFe1.NotasFiscais.Add.NFe do begin
        Total.ICMSTot.vBC   := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Total.ICMSTot.vProd := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Emit.xFant          := FCadcli.GetNome(codigocliente);
        Emit.xNome          := FCadcli.GetRazaoSocial(codigocliente);
        Emit.CNPJCPF        := FCadcli.GetCnpjCpf(codigocliente);
        Emit.EnderEmit.xLgr := Q1.fieldbyname('clie_endres').asstring;
        Emit.EnderEmit.nro  := '';
        Emit.EnderEmit.xCpl := '';
        codmuniemitente     := FCidades.GetCodigoIBGE( FUnidades.GetCidaCodigo(Global.CodigoUnidade) );
        Ide.cUF             := strtoint(copy(codmuniemitente,1,2));
        Ide.cNF             := Q1.fieldbyname('movd_numerodoc').asinteger;
        Ide.dEmi            := Q1.fieldbyname('mova_dtabate').asdatetime;

          with  Det.Add do
          begin
            totalitem:=FGEral.Arredonda(Q1.fieldbyname('movd_pesocarcaca').ascurrency*(Q1.fieldbyname('movd_vlrarroba').asFLOAT/15),2);
            Prod.qCom    := trunc(Q1.fieldbyname('movd_pesocarcaca').asfloat);
//            Prod.qTrib   := trunc(Q1.fieldbyname('movd_pesocarcaca').asfloat);
            Prod.uCom    := Q1.fieldbyname('esto_unidade').asstring;
            Prod.uTrib   := Q1.fieldbyname('esto_unidade').asstring;
            Prod.vProd   := totalitem;
            Prod.vUnCom  := Q1.fieldbyname('movd_vlrarroba').asfloat;
            Prod.vUnTrib := Q1.fieldbyname('movd_vlrarroba').asfloat;
            Prod.xProd   := Q1.fieldbyname('esto_descricao').asstring;
            totalpeso:=totalpeso+Q1.fieldbyname('movd_pesocarcaca').asfloat;
//            Prod.cProd   := Q1.fieldbyname('movd_esto_codigo').asstring;
            Prod.cProd   := Q1.fieldbyname('movd_ordem').asstring;
            Prod.xPed    := Q1.fieldbyname('movd_operacao').asstring;
            Prod.NCM     := currtostr(Q1.fieldbyname('nutr_qtdeporcao').AsInteger);
            Prod.cEAN    := currtostr(Q1.fieldbyname('nutr_calorias').AsCurrency);
            Prod.vFrete  := (Q1.fieldbyname('nutr_carboidratos').AsCurrency);
            Prod.vDesc   := (Q1.fieldbyname('nutr_proteinas').AsCurrency);
            Prod.vOutro  := (Q1.fieldbyname('nutr_gordtotais').AsCurrency);
            Prod.vSeg    := (Q1.fieldbyname('Nutr_fibras').AsCurrency);
            Prod.qtrib   := (Q1.fieldbyname('Nutr_sodio').AsCurrency);

// 10.07.17
            Prod.NCM:=Q1.FieldByName('esto_validade').AsString;
            QNutri:=sqltoquery('select * from nutricionais where nutr_codigo='+inttostr(Q1.FieldByName('esto_nutr_codigo').AsInteger));
            if not QNutri.Eof then begin
              with Prod.arma.Add do begin
                descr:=QNutri.FieldByName('Nutr_porcaocaseira').AsString;
                nCano:=QNutri.FieldByName('Nutr_qtdeporcao').AsString;
              end;
              Prod.vFrete:=QNutri.FieldByName('Nutr_carboidratos').AsCurrency;
              Prod.vDesc:=QNutri.FieldByName('Nutr_proteinas').AsCurrency;
              Prod.vOutro:=QNutri.FieldByName('Nutr_gordtotais').AsCurrency;
              Prod.vSeg:=QNutri.FieldByName('Nutr_fibras').AsCurrency;
              Prod.qTrib:=QNutri.FieldByName('Nutr_sodio').AsCurrency;
              Prod.vUnTrib:=QNutri.FieldByName('Nutr_calorias').AsCurrency;
            end;
            QNutri.Close;
            QConserva:=sqltoquery('select * from conservacao where cons_codigo='+inttostr(Q1.FieldByName('esto_cons_codigo').AsInteger));
            if not Qconserva.Eof then begin
              Prod.uCom:=QConserva.FieldByName('cons_linha1').AsString;
            end;
            Qconserva.Close;

          end;

        Total.ICMSTot.vNF   := totalpeso;

          Q1.Next;
      end; /// with acbr

    end;  /// Q1.eof
    FGeral.FechaQuery(Q1);

      for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin
         ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );
// 2 vias de cada etiqueta
//         ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );
      end;
      ACBrNFe1.NOtasFiscais.clear;

end;

procedure TFPesagemSaida.EdPecasExitEdit(Sender: TObject);
begin

end;

// 24.10.16
// 24.10.16
procedure TFPesagemSaida.EdProdutovenValidate(Sender: TObject);
///////////////////////////////////////////////////////////////

    function InicioDescricao(produtopedido,produtopesado:string):boolean;
    //////////////////////////////////////////////////////////////////////
    var descr1,descr2:string;
    begin
      descr1:=FEstoque.GetDescricao(produtopedido);
      descr2:=FEstoque.GetDescricao(produtopesado);
      result:=AnsiPos( copy(descr1,1,11),descr2) >0;
    end;

begin

  if (not EdProdutoven.isempty ) and ( EdProdutoven.ResultFind<>nil) then begin
    PNomeProduto.Caption:=EdProdutoVen.ResultFind.FieldbyName('esto_descricao').asstring;
    if not EdProdutoVen.ResultFind.Eof then begin
      if EstaCodigosNaoVenda(EdProdutoven.text) then
        EdProdutoven.Invalid('Codigo n�o permitido usar em vendas');
    end else begin
      EdProdutoven.Invalid('Codigo n�o encontrado');
      exit;
    end;
  end;
// 15.01.19 - itens q ainda nao s�o lidos com etiqueta dai informa o codigo e
// n�o preenche o campo da etiqueta passando com enter...
   if (not Edprodutoven.IsEmpty) and ( EdProduto.IsEmpty ) then codigolido:=Edprodutoven.text;

  if Edprodutoven.IsEmpty then Edprodutoven.Invalid('Obrigat�rio informar o codigo do produto')
  else if (EdProdutoven.Text<>GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row])
        then begin
        if confirma('Codigo � diferente do codigo do pedido.  Confirma mesmo assim ?' ) then begin
          EdPecas.text:='';
          EdPecas.Enabled:=true;
          EdPecas.setfocus;
        end;
  end else begin
          EdPecas.text:='';
          EdPecas.Enabled:=true;
          EdPecas.setfocus;
  end;


end;

// 24.10.16
function TFPesagemSaida.EstaCodigosNaoVenda(produto: string): boolean;
//////////////////////////////////////////////////////////////////////////
var Lista:TStringlist;
    codigosnaovenda,GruposNaoVenda:string;
    p:integer;
    Q:TSqlquery;
begin

  codigosnaovenda:=FGeral.GetConfig1AsString('Produtosnaovenda');
  GruposNaoVenda:=FGeral.GetConfig1AsString('GRUPOSNAOVEN');
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
    Lista.free;
  end;
  if trim(GruposNaoVenda)<>'' then begin
    Q:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(produto) );
    if not Q.eof then begin
      Lista:=TStringlist.create;
      strtolista(Lista,GruposNaoVenda,';',true);
      for p:=0 to Lista.count-1 do begin
        if strtointdef(Lista[p],0)>0 then begin
          if strtointdef(Lista[p],0)=strtointdef(Q.fieldbyname('esto_grup_codigo').asstring,0) then begin
            result:=true;
            break;
          end;
        end;
      end;
      Lista.free;
    end;
    FGEral.FechaQuery(Q);
  end;
end;

procedure TFPesagemSaida.EdProdutoChange(Sender: TObject);
////////////////////////////////////////////////////////////////
begin
   if ( (copy(EdProduto.Text,1,3)='001') and ( length(trim(Edproduto.Text))=10 ) and
      ( copy(Edproduto.Text,11,1)=' ' ) ) or
      ( length(trim(Edproduto.Text))>=12 )
   then begin
// 23.06.17 - etiqueta dos 'casados' tem 12 digitos
/////     showmessage(  '|'+EdProduto.Text+'|' );
     EdProduto.Valid;
   end;

end;


procedure TFPesagemSaida.EdProdutoKeyPress(Sender: TObject; var Key: Char);
begin

end;

// 26.10.16
function TFPesagemSaida.JaVendeuPedaco(Etiqueta, Mens: string): boolean;
////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqlaberto,sqlwhere,sqldata,sqlunidades,tipomov,japesou,sqltipomovd:string;
begin


   tipomov:='PC';
   result:=false;
//  15.05.17 - liberado senao nao passa a etq dos casados...revisar
   exit;


   sqlaberto:=' and '+Fgeral.getin('mova_situacao','P','C');
   sqlwhere:=' where '+FGEral.getin('mova_status','N;','C')+' and mova_transacaogerada='+EdProduto.AsSql;
//   sqlwhered:=' where '+FGEral.getin('movd_status','N;','C')+' and movd_operacao='+EdProduto.AsSql;
//   sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
   sqltipomovd:=' and '+fGeral.Getin('movd_tipomov',Tipomov,'C');
//   sqltipomova:=' and '+fGeral.Getin('mova_tipomov',Tipomov,'C');
   sqlunidades:=' and '+FGeral.Getin('mova_unid_codigo',Global.CodigoUnidade,'C');
   Q:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc )'+
                       ' inner join estoque on ( esto_codigo = movd_esto_codigo )'+
                       sqlwhere+' and '+FGEral.getin('movd_status','N;','C')+
                       sqlaberto+sqlunidades+
                       sqltipomovd+
                       ' order by mova_dtabate,movd_numerodoc,movd_ordem');
   japesou:='';
   {
   while not Q.Eof do begin
       if Q.fieldbyname('movd_pesobalanca').ascurrency>= Q.fieldbyname('movd_pesocarcaca').ascurrency then  begin
         japesou:=Q.fieldbyname('movd_operacao').asstring;
         break;
       end;
      Q.Next;
   end;
   }
   if not Q.Eof then japesou:=Q.fieldbyname('movd_operacao').asstring;
   Q.Close;

   if trim(japesou)<>'' then begin
     if mens='S' then
       aviso('Parte desta carca�a j� foi pesada');
     result:=true
   end;

end;

end.
