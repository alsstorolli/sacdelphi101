unit pesagemsaida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr, Async32, ACBrBase, ACBrBAL, AcbrDevice, SqlSis,
  ACBrDANFCeFortesFrETQFAT,ACBrDANFCeFortesFrEA,pcnconversao, ACBrDFe,
  ACBrNFe;

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
    ACBrNFe1: TACBrNFe;
    EdProdutoven: TSQLEd;
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
    procedure EdPecasChange(Sender: TObject);
    procedure EdProdutovenValidate(Sender: TObject);
    procedure EdProdutoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure Execute;
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

  end;

var
  FPesagemSaida: TFPesagemSaida;
  QPedido,QSaida:TSqlquery;
  Sqltipomov,Unidade,Transacao:string;
  DataPedido:TDatetime;
  Temgrid:boolean;
  Seq,CodigoCliente:integer;
  Tara,PesoBalanca:Currency;
  campobal,CampoVen,campoopr:TDicionario;

const tipomov:string='SA';

implementation

uses Geral,SqlFun, Estoque, impressao, RelGerenciais, nfsaida,
  expnfetxt, cadcli, munic, Unidades, pcnNFe;

{$R *.dfm}

{ TFPesagemSaida }

///////////////////////////////////////////
procedure TFPesagemSaida.Execute;
//////////////////////////////////
begin
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

   EdNumeroDoc.setfocus;
end;

procedure TFPesagemSaida.EdNumeroDOCValidate(Sender: TObject);
////////////////////////////////////////////////
var sqlaberto,sqlwhere,sqldata,sqlunidades:string;
    x:integer;
begin
   sqlaberto:=' and '+Fgeral.getin('mped_situacao','P;A','C');
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
     EdNumerodoc.invalid('Não encontrado este pedido ou já feito nota fiscal');
     exit;
   end;
   GridPedido.clear;
// 14.08.12
   Ppeso.caption:='';
   x:=1;
   CodigoCliente:=QPedido.fieldbyname('mped_tipo_codigo').asinteger;
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
   QSaida:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao )'+
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
     EdNumerodoc.invalid('Número do pedido está zerado');
     exit;
   end;
   if trim(GridPedido.cells[0,1])='' then begin
     Avisoerro('Sem itens no pedido');
     exit;
   end;
   if not ConferePecas then begin
     Avisoerro('Todas as peças já foram pesadas deste item');
     exit;
   end;
   if Global.Usuario.OutrosAcessos[0512] then begin
     EdProduto.text:='';
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
        if confirma('Peso da balança menor que o peso mínimo.  Confirma ?') then begin
          FGeral.GravaLog(26,'Peso balança '+EdPeso.assql+' Peso pedido '+Valortosql(pesopedido)+' Pedido '+EdNumerodoc.text);
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
//     Serial2.Open;
     result:=true;
    except
//      Avisoerro('Problemas para abrir a porta '+Serial1.DeviceName);
      Avisoerro('Problemas para abrir a porta '+AcbrBal2.Porta);
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
// 22.07.14 - parou de ler e começou a vir '*' no lugar do T da tara
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
var ordem,produto:string;
begin
  ordem:=trim(GridItens.Cells[GridItens.getcolumn('movd_seq'),GridItens.row]);
  produto:=trim(GridPedido.Cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]);
  if ordem='' then exit;
  if not confirma('Confirma exclusão deste peso ?') then exit;
  QSaida.First;
  try
    Sistema.Edit('movabatedet');
    Sistema.SetField('movd_status','C');
    Sistema.Post('movd_transacao='+Stringtosql(QSaida.fieldbyname('movd_transacao').AsString)+
                 ' and movd_numerodoc='+EdNumerodoc.assql+
                 ' and movd_ordem='+Stringtosql(ordem)+
                 ' and movd_esto_codigo='+Stringtosql(produto)+
                 ' and movd_tipomov='+Stringtosql(Tipomov)+
                 ' and movd_unid_codigo='+Stringtosql(unidade)+
                 ' and movd_status='+Stringtosql('N')
                 );
    Sistema.Commit;
    GridItens.DeleteRow(GridItens.row);
    AtualizaValores;
  except
    Avisoerro('Não foi possível excluir.  Verificar');
  end;

end;

procedure TFPesagemSaida.bSairClick(Sender: TObject);
begin
//  if xSerial1.Enabled then
//    xSerial1.close;
  if AcbrBal1.Ativo then AcbrBal1.Desativar;
  if AcbrBal2.Ativo then AcbrBal2.Desativar;
//  if Serial2.Enabled then
//    Serial2.close;
  close;
// 13.06.11
  if Global.Usuario.OutrosAcessos[0054] then Application.Terminate;

end;

procedure TFPesagemSaida.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
/////////////////////////////////////////////////////////////////////////////////////
begin
//  if xSerial1.Enabled then begin
//    xSerial1.close;
//  end;
  if AcbrBal1.Ativo then AcbrBal1.Desativar;
  if AcbrBal2.Ativo then AcbrBal2.Desativar;
//  if Serial2.Enabled then
//    Serial2.close;
  if QSaida<>nil then begin
    if QSaida.SQL.Text<>'' then
      QSaida.close;
  end;

end;

procedure TFPesagemSaida.EdPesoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////
var PesoPedido,PesoEstoque:currency;
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
  if (EdPeso.ascurrency>0) then PPeso.caption:=TRansform( EdPeso.ascurrency, f_cr3 );
// 01.03.16
  if EdPeso.Enabled then begin
    pesobalanca:=EdPeso.ascurrency;
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
  end;
  //////////////////////
  if (EdPeso.ascurrency>0) and ( EdPeso.ascurrency<PesoPedido ) then begin
    if confirma('Peso da balança menor que o peso mínimo.  Confirma ?') then begin
      FGeral.GravaLog(26,'Peso balança '+EdPeso.assql+' Peso pedido '+Valortosql(pesopedido)+' Pedido '+EdNumerodoc.text);
      GravaPeso;
    end;
// 08.09.15 - Iso...dianteiro ' + caro'
  end else  if ( EdPeso.ascurrency>0 ) and (PesoEstoque>0) and (EdPeso.ascurrency>PesoEstoque) then begin
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
  EdPeso.enabled:=false;

end;

//////////////////////////////////////////////
procedure TFPesagemSaida.GravaPeso;
//////////////////////////////////////////////
var Q:TSqlquery;
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
       GravaItem('I',Q);  // item novo dentro de pedido ja começado com outros itens
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
    Avisoerro('Nada gravado.   Problemas na gravação no banco de dados');
  end;
// 08.08.11
  AtualizaValores;
// 10.08.12
   GridPedido.setfocus;

end;


//////////////////////////////////////////////////////////
procedure TFPesagemSaida.GravaItem(op:string;Q:TSqlquery);
//////////////////////////////////////////////////////////
var linha:integer;
begin

     if op='I' then begin
//        linha:=GridItens.row;
        linha:=ProcuraGrid(GridItens.GetColumn('movd_seq'),strzero(seq,3));
        Sistema.Insert('movabatedet');
        Sistema.SetField('movd_esto_codigo',trim(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]));
        Sistema.SetField('movd_transacao',transacao);
        Sistema.SetField('movd_operacao',copy(transacao,1,9)+GridItens.cells[GridItens.getcolumn('movd_seq'),linha]+GridPedido.cells[GridItens.getcolumn('movd_seq'),linha]);
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
        Sistema.SetField('movd_vlrarroba',Texttovalor(GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),linha]));
//        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
        Sistema.SetField('movd_ordem',strtoint(GridItens.cells[GridItens.getcolumn('movd_seq'),linha]));
//        Sistema.SetField('movd_pecas',1);
// 23.10.13 - jake + clevis
        Sistema.SetField('movd_pecas',Edpecas.AsInteger);
// 23.02.16
        if Campobal.Tipo<>'' then Sistema.SetField('movd_pesobalanca',Pesobalanca);
// 24.10.16
        if Campoven.Tipo<>'' then Sistema.SetField('movd_esto_codigoven',EdProdutoven.text);
// 25.10.16
        if Global.Usuario.OutrosAcessos[0512] then begin
          if Campoopr.Tipo<>'' then Sistema.SetField('movd_oprastreamento',EdProduto.text);
        end;

        Sistema.Post('');

     end else begin

        Sistema.Edit('movabatedet');
        Sistema.SetField('movd_tipo_codigo',QPedido.fieldbyname('mped_tipo_codigo').AsInteger);
//        Sistema.SetField('movd_tipocad','C');
//        Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),linha]);
//        Sistema.SetField('movd_idade',Grid.cells[Grid.getcolumn('movd_idade'),linha]);
//        Sistema.SetField('movd_pesovivo',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesovivo'),linha]));
        Sistema.SetField('movd_pesocarcaca',Texttovalor(Griditens.cells[GridItens.getcolumn('movd_pesocarcaca'),linha]));
        Sistema.SetField('movd_vlrarroba',Texttovalor(GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),linha]));
//        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
//        Sistema.SetField('movd_pecas',1);
// 23.10.13 - jake + clevis
        Sistema.SetField('movd_pecas',Edpecas.AsInteger);
// 23.02.16 - balanção na saida
        if Campobal.Tipo<>'' then Sistema.SetField('movd_pesobalanca',Pesobalanca);
// 24.10.16
        if Campoven.Tipo<>'' then Sistema.SetField('movd_esto_codigoven',EdProdutoven.text);
// 25.10.16
        if Global.Usuario.OutrosAcessos[0512] then begin
          if Campoopr.Tipo<>'' then Sistema.SetField('movd_oprastreamento',EdProduto.text);
        end;
        Sistema.Post('movd_numerodoc='+EdNumerodoc.AsSql+
                     ' and movd_ordem='+GridItens.cells[GridItens.getcolumn('movd_seq'),linha]+
                     ' and movd_tipomov='+Stringtosql(TipoMov)+
                     ' and movd_status=''N''');
     end;

end;

////////////////////////////////////////////////////////////////
procedure TFPesagemSaida.GravaMestre(op:string ; Q:TSqlquery );
////////////////////////////////////////////////////////////////
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

  end else begin

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
  end;
//  AtualizaValores;
// 08.08.11 - pois nao adianta atualizar sem antes ter gravado...
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
    Avisoerro('Item do pedido não escolhido OU sem quantidade de peças');
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
        Avisoerro('Pedido já gerado na nota '+QPed.fieldbyname('mped_nfvenda').asstring+
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
                     CodigoCliente,QPedido.fieldbyname('mped_fpgt_codigo').asstring,'',
                     QPedido.fieldbyname('mped_port_codigo').asstring,Texttovalor(PValortotal.caption));

  if feznfcomdif then
    FGeral.GravaLog(25,'Gerado nota com diferença ',false);

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
// 01.03.16 - ajustado devido a informacao do numero de peças
           pecaspesadas:=pecaspesadas+QSaidax.fieldbyname('movd_pecas').asinteger;
           QSaidax.Next;
       end;
       FGeral.FechaQuery(Qsaidax);
       if pecaspesadas <> Strtoint( GridPedido.cells[GridPedido.getcolumn('mpdd_pecas'),r] ) then begin
          Avisoerro('Produto '+GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),r]+
                    ' - '+GridPedido.cells[GridPedido.getcolumn('esto_descricao'),r]+
                    ' com '+inttostr(pecaspesadas)+' peças pesadas');
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
 else if key = vk_f11 then bromaneioClick(self)
 else if key = VK_Back then bnotaspendentesclick(self)
 else if key = vk_f2 then bexcluipesagemClick(self);


end;

procedure TFPesagemSaida.GridItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);

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

procedure TFPesagemSaida.bnotaspendentesClick(Sender: TObject);
begin
  FExpNfetxt.Execute(0,'não Autorizadas');
end;

procedure TFPesagemSaida.EdPecasValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
var balanca:string;
    PesoPedido,PesoEstoque:currency;
    QE:Tsqlquery;

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
    QE:=Sqltoquery('select esto_qbalanca,esto_tara,esto_peso from estoque where esto_codigo='+
                    Stringtosql( GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]) );
    balanca:=QE.fieldbyname('esto_qbalanca').asstring;
    Tara:=QE.fieldbyname('esto_tara').ascurrency*EdPecas.ascurrency;
    PesoEstoque:=QE.fieldbyname('esto_peso').ascurrency;
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
       end else
        tara:=tara+(FGeral.GetConfig1AsFloat('DESCPESOGANCHO')*Edpecas.AsCurrency)+FGeral.GetConfig1AsFloat('DESCPESO');
    end;

    Ppesobalanca.caption:=FGeral.Formatavalor(pesobalanca,f_cr);

// Isonel resolver nao tarar a balanca de inicio
// entao sera descontada a tara que estiver no produto

//    Aviso( 'Abrindo porta balança='+balanca);

    FGeral.FechaQuery(QE);

//    abrirporta( balanca );

// 08.09.15
    if Global.Usuario.OutrosAcessos[0509] then begin
// 04.03.15
      abrirporta( balanca );
      if (balanca='BAL1') or ( trim(balanca)='') then
        AcbrBal1.LePeso( 500 )
      else
        AcbrBal2.LePeso( 500 );
    end;

    if EdPeso.ascurrency>=0 then EdPeso.setvalue( EdPeso.ascurrency - tara );

    PesoPedido:=TextToValor( GridPedido.cells[GridPedido.getcolumn('mpdd_qtde'),GridPedido.row] );
    if (EdPeso.ascurrency>0) then PPeso.caption:=TRansform( EdPeso.ascurrency, f_cr3 );
// 08.09.15 - Iso...dianteiro ' + caro'
    if ( EdPeso.ascurrency>0 ) and (PesoEstoque>0) and (EdPeso.ascurrency>PesoEstoque) then begin
      Avisoerro('Peso acima do permitido.  Checar para troca de codigo');
      AcbrBal1.Desativar;
      AcbrBal2.Desativar;
      exit;
    end;
// 05.03.15 -senao grava duas vezes
//   if not Global.Topicos[1408] then begin
// 19.04.15
   if Global.Usuario.OutrosAcessos[0509] then begin
      if (EdPeso.ascurrency>0) and ( EdPeso.ascurrency<PesoPedido ) then begin
          if confirma('Peso da balança menor que o peso mínimo.  Confirma ?') then begin
            FGeral.GravaLog(26,'Peso balança '+EdPeso.assql+' Peso pedido '+Valortosql(pesopedido)+' Pedido '+EdNumerodoc.text);
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

////////////////////////////////////////////

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
                                 'Coloque o produto sobre a Balança!' ;
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
                                 'Coloque o produto sobre a Balança!' ;
        -1 : PMens.Caption := 'Peso Instavel ! ' +sLineBreak+
                                 'Tente Nova Leitura' ;
        -2 : PMens.Caption := 'Peso Negativo !' ;
       -10 : PMens.Caption := 'Sobrepeso !' ;
      end;
//      }
    end ;

end;

// 15.06.16
procedure TFPesagemSaida.EdProdutoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////
var sqlaberto,sqlwhere,sqlwhered,sqldata,sqltipomova,sqltipomovd,sqlunidades,tipomov:string;
    QPedido:TSqlquery;
begin
   tipomov:='PC';
   sqlaberto:=' and '+Fgeral.getin('mova_situacao','P','C');
   sqlwhere:=' where '+FGEral.getin('mova_status','N;','C')+' and mova_operacao='+EdProduto.AsSql;
   sqlwhered:=' where '+FGEral.getin('movd_status','N;','C')+' and movd_operacao='+EdProduto.AsSql;
   sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
   sqltipomovd:=' and '+fGeral.Getin('movd_tipomov',Tipomov,'C');
   sqltipomova:=' and '+fGeral.Getin('mova_tipomov',Tipomov,'C');
   sqlunidades:=' and '+FGeral.Getin('mova_unid_codigo',Global.CodigoUnidade,'C');
   QPedido:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao and mova_numerodoc=movd_numerodoc )'+
                       ' inner join estoque on ( esto_codigo = movd_esto_codigo )'+
                       sqlwhered+' and '+FGEral.getin('movd_status','N;','C')+
                       sqlaberto+sqldata+sqlunidades+
                       sqltipomovd+
                       ' order by mova_dtabate,movd_numerodoc,movd_ordem');
   if QPedido.eof then begin
     EdProduto.INvalid('Etiqueta não encontrada');
   end else if pos('CARCA',Uppercase(QPedido.fieldbyname('esto_descricao').AsString)) > 0 then begin
     if JaVendeuPedaco( EdNumerodoc.Text,'S' ) then EdProduto.Invalid('')
     else begin
       EdPecas.text:='1';
       EdPecas.Enabled:=false;
       EdPecas.valid;
       PNomeProduto.Caption:=QPedido.fieldbyname('esto_descricao').AsString;
       FGeral.FechaQuery(QPedido);
     end;
   end else if ( QPedido.FieldByName('movd_esto_codigo').asstring<> GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] ) then begin
     if confirma('Codigo da etiqueta é '+ QPedido.FieldByName('movd_esto_codigo').asstring+' -  '+QPedido.fieldbyname('esto_descricao').AsString+' Confirma mesmo assim ?' ) then begin
       EdPecas.text:='1';
       EdPecas.Enabled:=false;
       EdPecas.valid;
       FGeral.FechaQuery(QPedido);
       PNomeProduto.Caption:=QPedido.fieldbyname('esto_descricao').AsString;
     end else EdProduto.Invalid('');
   end else begin
       EdPecas.text:='1';
       EdPecas.Enabled:=false;
       EdPecas.valid;
       PNomeProduto.Caption:=QPedido.fieldbyname('esto_descricao').AsString;
       FGeral.FechaQuery(QPedido);
   end;

end;

procedure TFPesagemSaida.EdSeqfValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
   if (EdSeqf.asinteger>0) and (EdSeqf.asinteger<EdSeqi.asinteger) then EdSeqf.invalid('Sequencial final tem que ser amior que inicial');

end;

// 16.06.16
procedure TFPesagemSaida.EdSeqfExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////
var totalpeso,totalitem:currency;
    Q1:TSqlquery;
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
      acbrnfe1.danfe.MostrarPreview:=true
    else
      acbrnfe1.danfe.MostrarPreview:=false;
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

procedure TFPesagemSaida.EdPecasChange(Sender: TObject);
begin

end;

// 24.10.16
// 24.10.16
procedure TFPesagemSaida.EdProdutovenValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
begin

  if (not EdProdutoven.isempty ) and ( EdProdutoven.ResultFind<>nil) then begin
    PNomeProduto.Caption:=EdProdutoVen.ResultFind.FieldbyName('esto_descricao').asstring;
    if not EdProdutoVen.ResultFind.Eof then begin
      if EstaCodigosNaoVenda(EdProdutoven.text) then
        EdProdutoven.Invalid('Codigo não permitido usar em vendas');
    end else begin
      EdProdutoven.Invalid('Codigo não encontrado');
      exit;
    end;
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

   if trim(japesou)<>''then begin
     if mens='S' then
       aviso('Parte desta carcaça já foi pesada');
     result:=true
   end;

end;

end.
