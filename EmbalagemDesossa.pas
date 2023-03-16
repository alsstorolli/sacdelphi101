// 20.12.17
// Embala pe�as desossadas e monta uma caixa com 'n' pe�as

unit EmbalagemDesossa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrDFe, ACBrNFe, ACBrETQ, ACBrBase,
  ACBrBAL, Vcl.ExtCtrls, Vcl.Grids, SqlDtg, Vcl.StdCtrls, Vcl.Mask, SQLEd,
  Vcl.Buttons, SQLBtn, alabel, SQLGrid, SqlExpr, SqlFun, AcbrDevice,
  Math,ACBrDANFCeFortesFrEA,ACBrDANFCeFortesFrETQDES, pcnconversao,
  ShellApi, Vcl.DBGrids, AcbrDeviceSerial;

type
  TFEmbalagemDesossa = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    blebalanca: TSQLBtn;
    bretnropedido: TSQLBtn;
    bimpetq: TSQLBtn;
    EdSeqi: TSQLEd;
    EdSeqf: TSQLEd;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    Label6: TLabel;
    EdNumeroDOC: TSQLEd;
    pnomecliente: TSQLPanelGrid;
    PIns: TSQLPanelGrid;
    Label7: TLabel;
    EdPeso: TSQLEd;
    PPeso: TSQLPanelGrid;
    pNomeProduto: TSQLPanelGrid;
    EdProduto: TSQLEd;
    PPedidos: TSQLPanelGrid;
    GridPedido: TSqlDtGrid;
    PTotais: TSQLPanelGrid;
    Label1: TLabel;
    ptara: TLabel;
    PTotalPesado: TSQLPanelGrid;
    AcbrBal1: TACBrBAL;
    ACBrETQ1: TACBrETQ;
    EdPecas: TSQLEd;
    PItens: TSQLPanelGrid;
    GridItens: TSqlDtGrid;
    ACBrNFe1: TACBrNFe;
    procedure blebalancaClick(Sender: TObject);
    procedure bimpetqClick(Sender: TObject);
    procedure bretnropedidoClick(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure EdNumeroDOCKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdPecasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdSeqiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdSeqfKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdPecasExitEdit(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure EdPesoValidate(Sender: TObject);
    procedure EdNumeroDOCValidate(Sender: TObject);
    procedure EdSeqfExitEdit(Sender: TObject);
    procedure GridPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridPedidoClick(Sender: TObject);
    procedure AcbrBal1LePeso(Peso: Double; Resposta: AnsiString);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure Execute;
    Procedure ZeraCampos;
    procedure ConfiguraBalancas;
    function  AbrirPorta(qbalanca:string):boolean;
    procedure SetaEditEntradasAbate(Ed:TSqlEd);
    procedure GravaPeso;
    procedure AtualizaValores;
    procedure GravaItem(op:string;Q:Tsqlquery);
    procedure EditstoGrid(xseq:integer=0);
    function ProcuraGrid(Coluna: integer;  Pesquisa: string ; Colunatam:integer=0 ; tam:integer=0 ; colunacor:integer=0 ; cor:integer=0 ;
                         colunacopa:integer=0 ; copa:integer=0 ): integer;
    procedure ConfiguraTeclas( Key: Word );
    function arred( v:currency ):currency;
    procedure Queryitenstogrid(produto:string ; pecas:currency);
  end;

var
  FEmbalagemDesossa: TFEmbalagemDesossa;
  QPedido,QSaida:TSqlquery;
  Sqltipomov,Unidade,Transacao,TipoMov,TipoMovSai:string;
  DataPedido:TDatetime;
  Temgrid:boolean;
  Seq,CodigoCliente:integer;
  Tara:Currency;

implementation

uses Geral, SqlSis, Estoque, RelGerenciais, grupos, cadcli, pcnNFe,
  impressao, munic, Unidades,Printers, custos, StrUtils,
  ACBrNFeNotasFiscais;


{$R *.dfm}

{ TFEmbalagemDesossa }

function TFEmbalagemDesossa.AbrirPorta(qbalanca: string): boolean;
///////////////////////////////////////////////////////////////////
begin
  if (qbalanca='BAL1') or ( trim(qbalanca)='') then begin
    try
     Acbrbal1.Ativar;
     result:=true;
    except
      Avisoerro('Problemas para abrir a porta '+AcbrBal1.Porta);
      result:=false;
    end;
  end else if qbalanca='BAL2' then begin
  {
    try
     Acbrbal2.Ativar;
     result:=true;
    except
      Avisoerro('Problemas para abrir a porta '+AcbrBal2.Porta);
      result:=false;
    end;
    }
  end;
end;

// 20.04.18
procedure TFEmbalagemDesossa.AcbrBal1LePeso(Peso: Double; Resposta: AnsiString);
//////////////////////////////////////////////////////////////////////////////////
var valid : integer;
    xResposta,outra:string;
begin

//   xResposta := copy( Resposta,3,15)  ;
// 20.04.18
   xResposta := copy( Resposta,2,06)  ;


//   pPeso.Caption := xResposta ;
//   pNomeProduto.Caption:=Resposta;

//   PMens.Caption := formatFloat('###0.000', Peso )+' xResposta = '+xResposta;

   if FGeral.GetConfig1AsInteger('DIVBAL01')>0 then
        peso:=Texttovalor(xresposta)/FGeral.GetConfig1AsInteger('DIVBAL01')
   else
        peso:=Texttovalor(xresposta);

//    pPeso.Caption     := formatFloat('###0.000', Peso );

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

function TFEmbalagemDesossa.arred(v: currency): currency;
//////////////////////////////////////////////////////////
var y:currency;
begin
  y:=v-int(v);
  if y >=0.5 then  y:=0.5
  else if y<=0.499 then y:=0;
  result:=int(v) + y;
end;

procedure TFEmbalagemDesossa.AtualizaValores;
///////////////////////////////////////////
var p,r,animais:integer;
    valortotal,pesototal:currency;
    produto:string;
begin
  valortotal:=0;pesototal:=0;animais:=0;
  for r:=1 to GridPedido.RowCount do begin
     if Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),r])>0 then begin
       produto:=GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),r];
       pesototal:=pesototal+Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),r]);
//       valor:=qtde*unitario;
//       valortotal:=valortotal+valor;
//       GridPedido.cells[GridPedido.Getcolumn('movd_pesocarcaca'),r]:=FormatFloat(f_cr3,qtde);
//       GridPedido.cells[GridPedido.Getcolumn('total'),r]:=FormatFloat(f_cr,valor)
       inc(animais);
     end;
  end;
  if Global.Topicos[1318] then
    PTotalPesado.caption:=FormatFloat(f_cr3,arred(pesototal))
  else
    PTotalPesado.caption:=FormatFloat(f_cr3,pesototal);
  //panimaispesados.caption:=inttostr(animais);
//  PValorTotal.caption:=FormatFloat(f_cr,valortotal);

end;

procedure TFEmbalagemDesossa.bimpetqClick(Sender: TObject);
//////////////////////////////////////////////////////////////
begin

   EdSeqi.Visible:=true;
   EdSeqf.Visible:=true;
   EdSeqi.setfocus;

end;

procedure TFEmbalagemDesossa.blebalancaClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
var s:string;
    Lista:TStringList;
    p:integer;
begin

   if EdNumerodoc.asinteger=0 then begin
     EdNumerodoc.invalid('N�mero do pedido est� zerado');
     exit;
   end;
//   if trim(GridPedido.cells[0,1])='' then begin
//     Avisoerro('Sem itens no pedido');
//     exit;
 //  end;
   if trim(GridPedido.Cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]) = '' then begin
     Avisoerro('Posicionar no produto primeiro');
     exit;
   end;
       s:=FComposicao.GetCodigosMat(GridPedido.Cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] );
       if (trim(s)<>'') then begin
         EdProduto.ShowForm:='';
         Lista:=TStringList.Create;;
         strtolista(Lista,s,';',true);
         for p:=0 to Lista.count-1 do begin
            if trim(Lista[p])<>'' then
              EdProduto.Items.add(strspace(Lista[p],15)+' - '+FEstoque.getdescricao(Lista[p]));
         end;
         EdProduto.ItemsLength:=15;
         Lista.Free;
       end;
   EdProduto.setfocus;

 end;

procedure TFEmbalagemDesossa.bretnropedidoClick(Sender: TObject);
begin

   FEmbalagemDesossa.SetaEditEntradasAbate(FEmbalagemDesossa.EdNUmerodoc);
   EdNumerodoc.setfocus;

end;

procedure TFEmbalagemDesossa.bSairClick(Sender: TObject);
begin

  if AcbrBal1.Ativo then AcbrBal1.Desativar;
  close;
  if Global.Usuario.OutrosAcessos[0054] then Application.Terminate;

end;

procedure TFEmbalagemDesossa.ConfiguraBalancas;

  function GetStopBitsAcBR(stopbit:integer;Serial:TAcbrbal):TAcbrSerialStop;
  ///////////////////////////////////////////////////////////////////
  begin
        case StopBit of
             10: result:=s1;
             15: result:=s1eMeio;
             20: result:=s2;
        end;
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
//  if AcbrBal2.Ativo then
//    AcbrBal2.Desativar;

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
{
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
}

end;

procedure TFEmbalagemDesossa.Execute;
/////////////////////////////////////

   procedure  SetaItemsEstoque;
   //////////////////////////////
   var Lista:TStringlist;
       s:string;
       p:integer;
   begin
     FEmbalagemDesossa.EdProduto.Items.clear;
     Lista:=TStringlist.create;
//     s:=FGeral.Getconfig1asstring('Produtosnaovenda');
//     s:=FGeral.Getconfig1asstring('GrupoDesossa');
     s:='';   // fixo por enquanto ate criar nas config. gerais
     if (trim(s)<>'') then begin
       FEmbalagemDesossa.EdProduto.ShowForm:='';
       strtolista(Lista,s,';',true);
       for p:=0 to Lista.count-1 do begin
          if trim(Lista[p])<>'' then
            FEmbalagemDesossa.EdProduto.Items.add(strspace(Lista[p],15)+' - '+FEstoque.getdescricao(Lista[p]));
       end;
       FEmbalagemDesossa.EdProduto.ItemsLength:=15;
     end else begin
       FEmbalagemDesossa.EdProduto.ShowForm:='FEstoque';
       FEmbalagemDesossa.EdProduto.ItemsLength:=0;
     end;
   end;

begin

   EdNumerodoc.ClearAll(FEmbalagemDesossa,99);
   Caption:='Desossa -  Sac Vers�o '+Global.VersaoSistema;
   GridPedido.clear;
   GridItens.Clear;
   ZeraCampos;
/////   EdNumerodoc.SetValue( FGeral.GetContador('EMBALAGEM'+Global.CodigoUnidade,false,false)+1 );
   ConfiguraBalancas;
   Tipomov:=Global.CodDesossaent;
   TipomovSai:=Global.CodDesossaSai;
   if not Global.Usuario.OutrosAcessos[0040] then
     abrirporta( 'BAL1' );

   Unidade:=Global.CodigoUnidade;
   if FGeral.Getconfig1asinteger('DIASPEDIDO')>0 then
     DataPedido:=Sistema.hoje-FGeral.Getconfig1asinteger('DIASPEDIDO')
   else
     DataPedido:=Sistema.Hoje-60;
   FEmbalagemDesossa.WindowState:=wsMaximized;
   FGeral.ConfiguraColorEditsNaoEnabled(FEmbalagemDesossa);
   FEmbalagemDesossa.SetaEditEntradasAbate(FEmbalagemDesossa.EdNUmerodoc);

   SetaItemsEstoque;
   ZeraCampos;
   EdSeqi.Visible:=false;
   EdSeqf.Visible:=false;
   Show;
   EdNumeroDoc.setfocus;

end;

procedure TFEmbalagemDesossa.ConfiguraTeclas(Key: Word);
//////////////////////////////////////////////////////////////
begin

 if key = vk_f4 then blebalancaClick(self)
 else if key = vk_f5 then bimpetqClick(self)
 else if key = vk_f3 then bretnropedidoClick(self)
 else if key = vk_f6 then bSairClick(self)
// else if key = vk_f10 then bgeranotaClick(self)
// else if key = vk_f11 then bromaneioClick(self)
// else if key = VK_Back then bnotaspendentesclick(self)
// else if key = vk_f2 then bexcluipesagemClick(self);


end;

procedure TFEmbalagemDesossa.EditstoGrid(xseq: integer);
/////////////////////////////////////////////////////////
var x:integer;
    valorvenda:currency;
begin

  if xseq=0 then
    x:=ProcuraGrid(GridItens.getcolumn('movd_seq'),strzero(xseq,3),0,0,0,0,0,0 )
  else
    x:=ProcuraGrid(GridItens.getcolumn('movd_seq'),strzero(xseq,3),0,0,0,0,0,0 );
//  valorvenda:=Texttovalor( GridItens.cells[GridItens.getcolumn('mpdd_venda'),GridItens.row] );
//  if x<0 then begin
    temgrid:=false;
    GridItens.AppendRow;
    GridItens.Cells[GridItens.getcolumn('movd_seq'),Abs(x)]:=strzero(Seq,3);
    GridItens.Cells[GridItens.getcolumn('mpdd_esto_codigo'),Abs(x)]:=trim(EdProduto.text);
    GridItens.Cells[GridItens.getcolumn('esto_descricao'),Abs(x)]:=FEstoque.getdescricao(trim(EdProduto.text));
//    GridItens.Cells[GridItens.getcolumn('movd_pesocarcaca'),Abs(x)]:=trim(Transform( EdPeso.Ascurrency, f_cr3 ));
    GridItens.Cells[GridItens.getcolumn('movd_pesocarcaca'),Abs(x)]:=EdPeso.Assql;
//    GridItens.Cells[GridItens.getcolumn('movd_pecas'),Abs(x)]:=Edpecas.AsSql;
//  end else begin
//    temgrid:=true;
//    GridItens.Cells[GridItens.getcolumn('movd_pesocarcaca'),Abs(x)]:=Transform( EdPeso.Ascurrency, f_cr3 ) ;
//    GridItens.Cells[GridItens.getcolumn('movd_pecas'),Abs(x)]:=Edpecas.AsSql;
//  end;

end;


procedure TFEmbalagemDesossa.EdNumeroDOCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   ConfiguraTeclas(key);

end;


procedure TFEmbalagemDesossa.EdNumeroDOCValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////////
var sqlaberto,sqlwhere,sqldata,sqlunidades:string;
    x:integer;
begin

   sqlaberto:=' and '+Fgeral.getin('mova_situacao','P','C');
   if Global.Usuario.Codigo=100 then sqlaberto:=' and '+Fgeral.getin('mova_situacao','P;N','C');

   sqlwhere:=' where '+FGEral.getin('mova_status','N;','C')+' and mova_numerodoc='+EdNumerodOC.AsSql;
   sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);

//   if trim(Global.Usuario.UnidadesMvto)='' then
     sqlunidades:=' and '+FGeral.Getin('mova_unid_codigo',Global.CodigoUnidade,'C');
//   else
//     sqlunidades:=' and '+FGeral.Getin('mpdd_unid_codigo',Global.Usuario.UnidadesMvto,'C');
   QPedido:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao )'+
                       ' inner join estoque on ( esto_codigo = movd_esto_codigo )'+
                       sqlwhere+' and '+FGEral.getin('movd_status','N;','C')+
                       sqlaberto+sqldata+sqlunidades+
                       ' and movd_tipomov='+Stringtosql(Tipomov)+
                       ' order by mova_dtabate,movd_numerodoc,movd_ordem');

   if QPedido.eof then begin
     QPedido.close;
     QPedido:=sqltoquery('select * from movabate'+
                       sqlwhere+' and '+FGEral.getin('mova_status','N;','C')+
                       sqlaberto+sqldata+sqlunidades+
                       ' and mova_tipomov='+Stringtosql(Tipomov)+
                       ' order by mova_dtabate,mova_numerodoc');
// 02.08.16
      if not QPedido.eof then
        CodigoCliente:=QPedido.fieldbyname('mova_tipo_codigo').asinteger;
      QPedido.close;
      QPedido:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao )'+
                       ' inner join estoque on ( esto_codigo = movd_esto_codigo )'+
                       sqlwhere+' and '+FGEral.getin('movd_status','N;','C')+
                       sqlaberto+sqldata+sqlunidades+
                       ' and movd_tipomov='+Stringtosql(Tipomov)+
                       ' order by mova_dtabate,movd_numerodoc,movd_ordem');

        if QPedido.eof then Avisoerro('Entrada para Desossa n�o encontrada.')
        else CodigoCliente:=QPedido.fieldbyname('mova_tipo_codigo').asinteger;

   end else
      CodigoCliente:=QPedido.fieldbyname('mova_tipo_codigo').asinteger;


   GridItens.clear;
   Ppeso.caption:='';
   x:=1;
   while (not QPedido.eof) do begin
         GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),x]:=QPedido.fieldbyname('movd_esto_codigo').asstring;
         GridPedido.cells[GridPedido.getcolumn('esto_descricao'),x]:=QPedido.fieldbyname('esto_descricao').asstring;
         GridPedido.cells[GridPedido.getcolumn('movd_seq'),x]:=strzero(QPedido.fieldbyname('movd_ordem').asinteger,3);
//         GridPedido.cells[GridPedido.getcolumn('mpdd_pecas'),x]:=QPedido.fieldbyname('mpdd_pecas').asstring;
//         GridPedido.cells[GridPedido.getcolumn('mpdd_venda'),x]:=QPedido.fieldbyname('mpdd_venda').asstring;
         GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),x]:=Formatfloat(f_cr3,QPedido.fieldbyname('movd_pesocarcaca').ascurrency);
         inc(x);
         GridPedido.AppendRow;
     QPedido.next;
   end;
   QPedido.First;
   PNomecliente.caption:=FCadcli.GetNome(codigocliente);
   AtualizaValores;
   GridPedido.setfocus;

end;

procedure TFEmbalagemDesossa.EdPecasExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////
var Qe:TSqlquery;
    peso:currency;
begin
   if (trim(EdProduto.text)<>'') and ( pos(',',EdProduto.Text)=0 ) then begin
// 26.02.16 - ia com espa�os a esquerda quando vem do f12 dai nao achava o grupo.....
     Edproduto.text:=trim(EdProduto.text);
     QE:=Sqltoquery('select esto_qbalanca,esto_tara,esto_peso,esto_descricao,esto_taraperc from estoque where esto_codigo='+Stringtosql(trim(EdProduto.text)));
     if not QE.eof then begin
  //    balanca:=QE.fieldbyname('esto_qbalanca').asstring;
        Tara:=QE.fieldbyname('esto_tara').ascurrency;
        pnomeproduto.caption:=QE.fieldbyname('esto_descricao').asstring;
        ptara.caption:=Formatfloat('##0.000',tara);
        if Global.Usuario.outrosacessos[0040] then begin
           EdPeso.enabled:=true;
           EdPeso.setfocus;
        end else begin
           EdPeso.enabled:=false;
           try
             AcbrBal1.lepeso;
// 25.10.17
//             AcbrBal1.lepeso(2000);
           except on E:exception do begin
               avisoerro('Problemas na leitura do Peso '+E.message);
               FGeral.GravaLog(033,E.Message);
               Application.Terminate;
             end;
           end;
// 14.10.15
           if not Confirma('Confirma peso ?') then exit;
// 22.09.16
          tara:=tara + ( EdPeso.ascurrency*(QE.fieldbyname('esto_taraperc').ascurrency/100) );
          tara:=Arred(Tara);
          ptara.caption:=Formatfloat('##0.000',tara);

           peso:=EdPeso.ascurrency;
           if Global.Topicos[1318] then
               EdPeso.setvalue( arred(Peso) );
           if EdPeso.ascurrency >= 0 then begin
              EdPeso.SetValue(Edpeso.ascurrency-tara);
              pPeso.Caption     := formatFloat('###0.00', EdPeso.ascurrency );
//              pPesobalanca.Caption     := formatFloat('###0.00', Peso );
           end;
//           EdPeso.setvalue( EdPeso.ascurrency-tara );
//           pPeso.Caption     := formatFloat('###0.00', EdPeso.ascurrency );
           if EdPeso.ascurrency>0 then  begin
             Gravapeso;
             EdPeso.text:=''; //20.10.15
           end;
        end;
     end else EdProduto.invalid('Codigo n�o encontrado no estoque');
   end else GridPedido.setfocus;

end;

procedure TFEmbalagemDesossa.EdPecasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);

end;

procedure TFEmbalagemDesossa.EdPesoValidate(Sender: TObject);
var Qe:TSqlquery;
    tara:currency;
begin
  if EdPeso.ascurrency>0 then begin
     QE:=Sqltoquery('select esto_qbalanca,esto_tara,esto_peso,esto_descricao,esto_taraperc from estoque where esto_codigo='+Stringtosql(trim(EdProduto.text)));
     if not QE.eof then
        Tara:=QE.fieldbyname('esto_tara').ascurrency + ( EdPeso.ascurrency*(QE.fieldbyname('esto_taraperc').ascurrency/100))
     else
        tara:=0;
    tara:=Arred(Tara);
    if Global.Topicos[1318] then
       EdPeso.setvalue( arred(EdPeso.ascurrency) );
//    ppesobalanca.caption:=Formatfloat('##0.000',EdPeso.ascurrency);
    ptara.caption:=Formatfloat('##0.000',tara);
    EdPeso.setvalue( EdPeso.ascurrency-tara );
    ppeso.caption:=EdPeso.text;
    Gravapeso;
    FGeral.fechaquery(Qe);
  end;

end;

procedure TFEmbalagemDesossa.EdProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);

end;

procedure TFEmbalagemDesossa.EdProdutoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
var Qe:TSqlquery;
//    peso:currency;
begin

// 29.08.17
   Edpecas.Text:='';
   if (trim(EdProduto.text)<>'') and ( pos(',',EdProduto.Text)=0 ) then begin
     Edproduto.text:=trim(EdProduto.text);

     QE:=Sqltoquery('select esto_qbalanca,esto_tara,esto_peso,esto_descricao,esto_taraperc from estoque where esto_codigo='+Stringtosql(trim(EdProduto.text)));
{
     if not QE.eof then begin
        if ( Ansipos('BOI',Uppercase(QE.FieldByName('esto_descricao').AsString))>0 )
           or
           ( Ansipos('NOVILHA',Uppercase(QE.FieldByName('esto_descricao').AsString))>0 )
           or
           ( Ansipos('NOVILHO',Uppercase(QE.FieldByName('esto_descricao').AsString))>0 )
           then
         Edpecas.Enabled:=true
     end;
     }
     pnomeproduto.caption:=QE.fieldbyname('esto_descricao').asstring;
     FGeral.FechaQuery(QE);

   end else EdProduto.Invalid('Informar corretamente codigo do produto');
{
   if (trim(EdProduto.text)<>'') and ( pos(',',EdProduto.Text)=0 ) then begin
// 26.02.16 - ia com espa�os a esquerda quando vem do f12 dai nao achava o grupo.....
     Edproduto.text:=trim(EdProduto.text);
     QE:=Sqltoquery('select esto_qbalanca,esto_tara,esto_peso,esto_descricao,esto_taraperc from estoque where esto_codigo='+Stringtosql(trim(EdProduto.text)));
     if not QE.eof then begin
  //    balanca:=QE.fieldbyname('esto_qbalanca').asstring;
        Tara:=QE.fieldbyname('esto_tara').ascurrency;
        pnomeproduto.caption:=QE.fieldbyname('esto_descricao').asstring;
        ptara.caption:=Formatfloat('##0.000',tara);
        if Global.Usuario.outrosacessos[0040] then begin
           EdPeso.enabled:=true;
           EdPeso.setfocus;
        end else begin
           EdPeso.enabled:=false;
           AcbrBal1.lepeso;
// 14.10.15
           if not Confirma('Confirma peso ?') then exit;
// 22.09.16
          tara:=tara + ( EdPeso.ascurrency*(QE.fieldbyname('esto_taraperc').ascurrency/100) );
          tara:=Arred(Tara);
          ptara.caption:=Formatfloat('##0.000',tara);

           peso:=EdPeso.ascurrency;
           if Global.Topicos[1318] then
               EdPeso.setvalue( arred(Peso) );
           if EdPeso.ascurrency >= 0 then begin
              EdPeso.SetValue(Edpeso.ascurrency-tara);
              pPeso.Caption     := formatFloat('###0.00', EdPeso.ascurrency );
              pPesobalanca.Caption     := formatFloat('###0.00', Peso );
           end;
//           EdPeso.setvalue( EdPeso.ascurrency-tara );
//           pPeso.Caption     := formatFloat('###0.00', EdPeso.ascurrency );
           if EdPeso.ascurrency>0 then  begin
             Gravapeso;
             EdPeso.text:=''; //20.10.15
           end;
        end;
     end else EdProduto.invalid('Codigo n�o encontrado no estoque');
   end else GridPedido.setfocus;
   }
end;

procedure TFEmbalagemDesossa.EdSeqfExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////////
type TProdutos=record
     codigo:string;
     peso:currency;
end;

var totalpeso,totalitem:currency;
    Q1,Q2:TSqlquery;
    sqlordem,codmuniemitente,s,arquivoetiq:string;
    Lista:TList;
    PProdutos:^TProdutos;
    i,x:integer;

    {

    procedure AtualizaLista;
    ////////////////////////
    var p:integer;
        achou:boolean;
    begin
       achou:=false;
       for p:=0 to Lista.count-1 do begin
         PProdutos:=Lista[p];
         if PProdutos.codigo=Q1.fieldbyname('movd_esto_codigo').asstring then begin
           achou:=true;
           break;
         end;
       end;
       if not achou then begin
         New(PProdutos);
         PProdutos.codigo:=Q1.fieldbyname('movd_esto_codigo').asstring;
         PProdutos.peso:=Q1.fieldbyname('movd_pesocarcaca').ascurrency;
         Lista.add(PProdutos);
       end else begin
         PProdutos.peso:=PProdutos.peso+Q1.fieldbyname('movd_pesocarcaca').ascurrency;
       end;
    end;

}

    // 21.07.16
    procedure ImprimeEtiqueta( xarq:string ; Item:TNfe );
    ///////////////////////////////////////////////////////
    var Lista,ListaImp:TStringList;
        p:integer;
        Arquivo,ArqImp:TextFile;
        vtermica,comando:string;

        function ColocaDados(linha:string  ):string;
        ////////////////////////////////////////////////////////////////////////////////
        var x,p:integer;
            novalinha,troca:string;
            ListaTroca:TStringlist;

            function PoeInfo( s:string ):string;
            ////////////////////////////////////
            begin
              if s = uppercase('[codigo]') then result:=Item.Det.Items[0].Prod.cProd
              else if s = uppercase('[descricao]') then result:=copy(Item.Det.Items[0].Prod.xProd,1,24)
              else if s = uppercase('[numerodoc]') then result:=inttostr(Item.Ide.cnf)
              else if s = uppercase('[peso]') then result:=currtostr(Item.Det.Items[0].Prod.qCom)
              else if s = uppercase('[endereco]') then result:=copy(Item.Emit.EnderEmit.xLgr,1,24)
  //            else if s = uppercase('[nomecliente]') then result:=copy(Item.Emit.xNome,1,28)
              else if s = uppercase('[nomecliente]') then result:=copy(Item.Emit.xFant,1,24)
              else if s = uppercase('[codbarra]') then result:=(Item.Det.Items[0].Prod.xPed)
              else if s = uppercase('[data]') then result:=FGeral.FormataData(Sistema.Hoje)
              else result:=s;
            end;


        begin
          ListaTroca:=TSTringlist.create;
          ListaTroca.Add( '[codigo]' );
          ListaTroca.Add( '[descricao]' );
          ListaTroca.Add( '[numerodoc]' );
          ListaTroca.Add( '[peso]' );
          ListaTroca.Add( '[endereco]' );
          ListaTroca.Add( '[nomecliente]' );
          ListaTroca.Add( '[codbarra]' );
          ListaTroca.Add( '[data]' );
          novalinha:=linha;
          for p:=0 to ListaTroca.count-1 do begin
             troca:= Uppercase( ListaTroca[p] );
             x:=pos( troca ,uppercase(novalinha) );
             if x>0 then novalinha:=StuffString(novalinha,x,length(troca),PoeInfo(troca));
          end;
          result:=novalinha;
          ListaTroca.free;
        end;

    begin
    /////
      Lista:=TStringList.create;
      ListaImp:=TStringList.create;
      Lista.LoadFromFile(xarq);
      for p:=0 to Lista.count-1 do begin
        ListaImp.Add( ColocaDados( Lista[p] ) );
      end;
      Lista.free;
      if GetIni('Sacd','Config','Desenvolvimento') = 'S' then
//        vtermica:=Printer.Printers[Printer.PrinterIndex]
        vtermica:=Item.Det.Items[0].Prod.cProd+inttostr(x)+'.TXT'
      else
        vtermica:='\\'+FGeral.GetConfig1AsString('Caminhocodbarra' )+'\'+FGeral.GetConfig1AsString('Caminhocodbarra1');
      if ListaImp.count>0 then begin

//        Aviso('Imprimindo item '+inttostr(x));
        sleep(4000);   // tem q dar um tempo pra impressora senao 'come' impressao
        comando := 'Imp.bat' ;
        AssignFile ( arqimp, 'IMP.BAT' );
        Rewrite ( arqimp );
        Writeln ( arqimp, 'Type etqentradaabate.prn' +' > ' + vtermica );
        CloseFile ( arqimp );
        WinExec( PAnsiChar ( comando  ), SW_SHOWMINIMIZED );

       {
        AssignFile(Arquivo,vTermica);
        Rewrite(Arquivo);
        Write(Arquivo,ListaImp.gettext);
        Reset(Arquivo);
	      CloseFile(Arquivo);
        }
      end else Aviso('Lista para impress�o vazia');
      ListaImp.Free;
    end;

begin
//////////////////////////////////
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

    AcbrNFe1.DANFE := TACBrNFeDANFCeFortesETQDES.Create(AcbrNFe1);
    AcbrNfe1.DANFE.TipoDANFE := tiNFCE;
    if Global.usuario.outrosacessos[0510] then
      acbrnfe1.danfe.MostraPreview:=true
    else
      acbrnfe1.danfe.MostraPreview:=false;
    acbrnfe1.danfe.MargemEsquerda:=01;
    acbrnfe1.danfe.MargemDireita:=05;
    acbrnfe1.danfe.MargemSuperior:=5;
    acbrnfe1.danfe.MargemInferior:=5;
    acbrnfe1.danfe.NumCopias:=1;
//    if FileExists( ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg' ) then
//      acbrnfe1.danfe.Logo:=ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg';
//    s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPETQENT');
    s:='';
    if trim(s)<>'' then Acbrnfe1.DANFE.Impressora:=s;

      Q1:=sqltoquery('select * from movabatedet'+
                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                     ' where movd_numerodoc = '+EdNumerodoc.assql+
                     ' and movd_tipomov='+stringtosql( TipoMovSai )+
                     ' and mova_tipomov='+stringtosql( TipoMovSai)+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     sqlordem+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
                     ' order by movd_ordem' );
    if Q1.eof then aviso('N�o encontrada a etiqueta gerada');

    while not Q1.eof do begin

      with  ACBrNFe1.NotasFiscais.Add.NFe do begin

        Total.ICMSTot.vBC   := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Total.ICMSTot.vProd := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Emit.xFant          := FCadcli.GetNome(codigocliente);
        Emit.xNome          := FCadcli.GetRazaoSocial(codigocliente);
//        Emit.CNPJCPF        := FCadcli.GetCnpjCpf(codigocliente);
        Emit.EnderEmit.xLgr := FCadcli.GetEndereco(codigocliente);
        Emit.EnderEmit.nro  := '';
        Emit.EnderEmit.xCpl := '';
        codmuniemitente     := FCidades.GetCodigoIBGE( FUnidades.GetCidaCodigo(Global.CodigoUnidade) );
        Ide.cUF             := strtoint(copy(codmuniemitente,1,2));
        Ide.cNF             := Q1.fieldbyname('movd_numerodoc').asinteger;
//        Ide.dEmi            := Q1.fieldbyname('mova_dtabate').asdatetime;
        Ide.dEmi            := Sistema.hoje;
        Lista:=TList.create;

        //  para buscar o peso total do animal
        Q2:=sqltoquery('select * from movabatedet'+
                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                     ' inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                     ' where movd_numerodoc = '+EdNumerodoc.assql+
                     ' and movd_tipomov='+stringtosql(TipomovSai)+
                     ' and mova_tipomov='+stringtosql(TipomovSai)+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     ' and movd_transacao = '+Stringtosql(Q1.FieldByName('movd_transacao').AsString)+
                     ' and movd_ordem = '+inttostr(Q1.FieldByName('movd_ordem').AsInteger)+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
                     ' order by movd_ordem' );

          with  Det.Add do
          begin
            totalitem:=FGEral.Arredonda(Q1.fieldbyname('movd_pesocarcaca').ascurrency*(Q1.fieldbyname('movd_vlrarroba').asFLOAT/15),2);
            Prod.vSeg    :=  trunc(Q2.fieldbyname('movd_pesocarcaca').asfloat);
            Prod.qCom    := trunc(Q1.fieldbyname('movd_pesocarcaca').asfloat);
            Prod.qTrib   := trunc(Q1.fieldbyname('movd_pesocarcaca').asfloat);
            Prod.uCom    := Q1.fieldbyname('esto_unidade').asstring;
            Prod.uTrib   := Q1.fieldbyname('esto_unidade').asstring;
            Prod.vProd   := totalitem;
            Prod.vUnCom  := Q1.fieldbyname('movd_vlrarroba').asfloat;
            Prod.vUnTrib := Q1.fieldbyname('movd_vlrarroba').asfloat;
            Prod.xProd   := Q1.fieldbyname('esto_descricao').asstring;
            totalpeso:=totalpeso+Q1.fieldbyname('movd_pesocarcaca').asfloat;
            Prod.cProd   := Q1.fieldbyname('movd_esto_codigo').asstring;
//            Prod.cProd   := Q1.fieldbyname('movd_ordem').asstring;
            Prod.xPed    := Q1.fieldbyname('movd_operacao').asstring;
            Prod.nItem   := Q1.fieldbyname('movd_pecas').asinteger;
          end;
//          AtualizaLista;

        Total.ICMSTot.vNF   := totalpeso;
{
        for i:=0 to Lista.count-1 do begin
          PProdutos:=Lista[i];
          with pag.Add do begin
            cAut:=PProdutos.codigo;
            vPag:=trunc(PProdutos.peso/2);
          end;
        end;
}
        Lista.Clear;
        FGeral.FechaQuery(Q2);

          Q1.Next;

      end; /// with acbr

    end;  /// Q1.eof

    FGeral.FechaQuery(Q1);
    Lista.Free;

    if Global.usuario.outrosacessos[0510] then
      acbrnfe1.danfe.MostraPreview:=true
    else
      acbrnfe1.danfe.MostraPreview:=false;

      for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin

//        if Global.Usuario.OutrosAcessos[0514] then begin
//
//          arquivoetiq:='etqentradaabate.prn';
//          x:=i;
//          if trim(arquivoetiq)<>'' then
//            ImprimeEtiqueta( arquivoetiq,ACBrNFe1.NotasFiscais.Items[i].NFe )
//          else
//            aviso( 'n�o encontrado arquivo do codigo '+ACBrNFe1.NotasFiscais.Items[i].NFe.Det.Items[0].Prod.cProd );
//
//        end else

          ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

      end;

      ACBrNFe1.NOtasFiscais.clear;

end;


procedure TFEmbalagemDesossa.EdSeqfKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
///////////////////////////////////////////////////////////////////////////////////////////////////
begin

   ConfiguraTeclas(key);

end;

procedure TFEmbalagemDesossa.EdSeqiKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);

end;

procedure TFEmbalagemDesossa.GravaItem(op: string; Q: Tsqlquery);
//////////////////////////////////////////////////////////////////////
var linha:integer;
    vlrarroba:currency;
    QE:TSqlquery;
    material:string;

begin

     material:=trim(EdProduto.text) ;
     QE:=Sqltoquery('select * from estoqueqtde where esqt_unid_codigo = '+Stringtosql(Unidade)+
                    ' and esqt_esto_codigo = '+Stringtosql(material)+
                    ' and esqt_status = ''N''');
     if op='I' then begin
        linha:=ProcuraGrid(GridItens.GetColumn('movd_seq'),strzero(seq,3));
        Sistema.Insert('movabatedet');
        Sistema.SetField('movd_esto_codigo',trim(Edproduto.text));
        Sistema.SetField('movd_transacao',transacao);
        Sistema.SetField('movd_operacao',transacao+inttostr(seq) );
        Sistema.SetField('movd_numerodoc',Ednumerodoc.Asinteger);
        Sistema.SetField('movd_status','N');
        Sistema.SetField('movd_tipomov',TipoMovSai);
        Sistema.SetField('movd_unid_codigo',Unidade);
// 03.10.16
        if codigocliente>0 then
          Sistema.SetField('movd_tipo_codigo',codigocliente)
        else
          Sistema.SetField('movd_tipo_codigo',Q.fieldbyname('mova_tipo_codigo').AsInteger);
//        Sistema.SetField('movd_tipocad','C');
//        Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),linha]);
//        Sistema.SetField('movd_idade',Grid.cells[Grid.getcolumn('movd_idade'),linha]);
//        Sistema.SetField('movd_pesovivo',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesovivo'),linha]));

//        Sistema.SetField('movd_pesocarcaca',Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha]));
// 19.09.17 - para ver se para de 'as vezes' gravar o total de peso ao inves da metade
        Sistema.SetField('movd_pesocarcaca',EdPeso.AsCurrency);
//        Sistema.SetField('movd_vlrarroba',FGrupos.GetValorArroba( FEstoque.GetGrupo(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]),Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha]) ) );
// 11.01.16 - para ver se para de 'ora pegar faixa certa ora pegar faixa errada'...
        vlrarroba:=FEstoque.GetPreco( EdProduto.text,Unidade ) ;
        Sistema.SetField('movd_vlrarroba',vlrarroba  );

//         Aviso( 'Valor Arroba : '+FGeral.formatavalor(vlrarroba,f_cr) );

//        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
        Sistema.SetField('movd_ordem',inttostr(seq) );
        Sistema.SetField('movd_pecas',Edpecas.AsInteger);
//        Sistema.SetField('movd_idade',Edpecas.Text);
        Sistema.Post('');

////////////////////////////////////////////////////////////////////////////

     end else begin

     end;
     FGeral.FechaQuery(Qe);

end;

procedure TFEmbalagemDesossa.GravaPeso;
//////////////////////////////////////
var Q:TSqlquery;
    sqldata,sqltipomov,produto:string;


    procedure IncluiMestre;
    //////////////////////
    begin
            Sistema.Insert('movabate');
            Sistema.SetField('mova_transacao',transacao);
            Sistema.SetField('mova_operacao',transacao+'01');
            Sistema.SetField('mova_numerodoc',EDNumerodoc.AsInteger);
            Sistema.SetField('mova_status','N');
            Sistema.SetField('mova_tipomov',TipoMovSai);
            Sistema.SetField('mova_unid_codigo',Global.CodigoUnidade);
            Sistema.SetField('mova_datalcto',Sistema.Hoje);
            Sistema.SetField('mova_dtcarrega',Sistema.Hoje);
            Sistema.SetField('mova_dtabate',Sistema.hoje);
            Sistema.SetField('mova_dtvenci',Sistema.hoje);
            Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
      //      mova_notagerada numeric(8,0),
//            Sistema.SetField('mova_transacaogerada',Ednumerodoc.text);
            Sistema.SetField('mova_tipo_codigo',codigocliente);
      //      mova_pesovivo numeric(12,3),
//            Sistema.SetField('mova_pesocarcaca',somapesos);
            Sistema.SetField('mova_datacont',Sistema.Hoje);
      //      mova_perc numeric(12,5),
            Sistema.SetField('mova_situacao','N');
            Sistema.Post();

    end;


begin

  sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
  Sqltipomov:=' and mova_tipomov='+Stringtosql( TipomovSai );
  produto:=trim(EdProduto.text);
  Q:=sqltoquery('select * from movabate'+
                      ' where mova_numerodoc='+EdNumerodoc.assql+
                      ' and '+FGeral.Getin('mova_unid_codigo',Global.CodigoUnidade,'C')+
                      ' and mova_status=''N'''+
                      ' and mova_situacao=''P'''+
                      sqldata+sqltipomov );
  if Q.Eof then begin

     Transacao:=FGEral.GetTransacao;
     IncluiMestre;
     Sistema.Commit;
     FGeral.AlteraContador('EMBALAGEM'+Global.CodigoUnidade,EdNumerodoc.AsInteger);


  end else Transacao:=Q.fieldbyname('mova_transacao').asstring;

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

  FGeral.FechaQuery(Q);
  Sistema.EndProcess('');
  try
    Sistema.Commit;
/////    Impetiqueta('Inc');
  except
    Avisoerro('Nada gravado.   Problemas na grava��o no banco de dados');
  end;
// 07.10.17 - gambia para gravar 'sempre' o peso pela metade
{  25.10.17 - retirado pois nao foi de 'muita utilidade'
  Sistema.Edit('movabatedet');
  Sistema.SetField('movd_pesocarcaca',EdPeso.AsCurrency/2);
  Sistema.Post('movd_transacao='+Stringtosql(transacao)+' and movd_numerodoc='+EdNumerodoc.AsSql+
               ' and movd_tipomov = '+Stringtosql('PC')+' and movd_unid_codigo = '+stringtosql(unidade)+
               ' and movd_ordem = '+stringtosql(GridPedido.cells[GridPedido.getcolumn('movd_seq'),GridPedido.Row]) );

  Sistema.Commit;
  }
///////////////////////////////////////////////////////
  AtualizaValores;
  GridPedido.setfocus;

end;



// 07.03.18
procedure TFEmbalagemDesossa.GridPedidoClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var xpecas:currency;
begin

   if GridPedido.cells[Gridpedido.getcolumn('mpdd_esto_codigo'),Gridpedido.row]<>'' then begin
//     xpecas:=Texttovalor( GridPedido.cells[GridPedido.getcolumn('mpdd_pecas'),GridPedido.row] );
     xpecas:=0;
     Queryitenstogrid(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row],xpecas);
   end;

end;

procedure TFEmbalagemDesossa.GridPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   Configurateclas( key );

end;

function TFEmbalagemDesossa.ProcuraGrid(Coluna: integer; Pesquisa: string;  Colunatam, tam, colunacor, cor, colunacopa, copa: integer): integer;
////////////////////////////////////////////////////////////////////////////
var p:integer;
begin
  result:=0;seq:=0;
  {
  for p:=1 to GridPedido.RowCount do  begin
      if trim(GridPedido.Cells[GridPedido.getcolumn('movd_seq'),p])<>'' then begin
        seq:=strtoint(GridPedido.Cells[GridPedido.getcolumn('movd_seq'),p]);
        inc(seq);
      end else begin
        if seq=0 then
          seq:=1;
      end;
  end;
  }
// 07.03.18
  for p:=0 to GridItens.RowCount do  begin
      if trim(GridItens.Cells[GridItens.getcolumn('movd_seq'),p])<>'' then begin
        seq:=strtoint(GridItens.Cells[GridItens.getcolumn('movd_seq'),p]);
        inc(seq);
      end else begin
        if seq=0 then
          seq:=1;
      end;
  end;
  result:=seq;

{
  if (tam>0) and (cor>0) then begin
    if copa=0 then begin
      for p:=1 to GridPedido.RowCount do  begin
        if (trim(GridPedido.Cells[Coluna,p])=trim(Pesquisa)) and
         (trim(GridPedido.Cells[Colunatam,p])=trim(inttostr(tam))) and (trim(GridPedido.Cells[Colunacor,p])=trim(inttostr(cor))) then begin
          result:=p;
          break;
        end;
        if trim(GridPedido.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
    end else begin
      for p:=1 to GridPedido.RowCount do  begin
        if (trim(GridPedido.Cells[Coluna,p])=trim(Pesquisa)) and
         (trim(GridPedido.Cells[Colunatam,p])=trim(inttostr(tam))) and (trim(GridPedido.Cells[Colunacor,p])=trim(inttostr(cor)))
          and ( trim(GridPedido.Cells[Colunacopa,p])=trim(inttostr(copa)) ) then begin
          result:=p;
          break;
        end;
        if trim(GridPedido.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
    end;
  end else if (tam>0) and (cor=0) then begin  // 04.07.06
      for p:=1 to GridPedido.RowCount do  begin
        if (trim(GridPedido.Cells[Coluna,p])=trim(Pesquisa)) and
         ( trim(GridPedido.Cells[Colunatam,p])=trim(inttostr(tam)) ) and ( texttovalor(GridPedido.Cells[Colunacor,p])=0 ) then begin
          result:=p;
          break;
        end;
        if trim(GridPedido.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
  end else begin  // 03.10.07
      for p:=1 to GridPedido.RowCount do  begin
        if trim(GridPedido.Cells[Coluna,p])=trim(Pesquisa) then begin
          result:=p;
          break;
        end;
        if trim(GridPedido.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
  end;
}

end;

// 07.03.18
procedure TFEmbalagemDesossa.Queryitenstogrid(produto: string; pecas: currency);
///////////////////////////////////////////////////////////////////////////////////
var sqldata:string;
    qtde,vlritem,valor:currency;
    x:integer;
    QSaida:TSqlquery;
begin
/////////
   GridItens.clear;
   x:=1;
   qtde:=0;  valor:=0;
   sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
   Sqltipomov:=' and movd_tipomov='+Stringtosql( TipomovSai );
/////////////   PNomeProduto.caption:=FEstoque.GetDescricao(produto);
   QSaida:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao and mova_tipomov=movd_tipomov )'+
                      ' where movd_numerodoc='+EdNumerodoc.assql+
                      ' and '+FGeral.Getin('movd_unid_codigo',Global.CodigoUnidade,'C')+
//                      ' and movd_esto_codigo='+Stringtosql(produto)+
                      ' and movd_status=''N'''+
                      sqldata+sqltipomov+
                      ' order by movd_ordem' );

   while not QSaida.eof do begin

            GridItens.Cells[GridItens.getcolumn('esto_descricao'),Abs(x)]:=FEstoque.getdescricao(QSaida.fieldbyname('movd_esto_codigo').Asstring);
            GridItens.Cells[GridItens.getcolumn('mpdd_esto_codigo'),Abs(x)]:=QSaida.fieldbyname('movd_esto_codigo').Asstring;
            GridItens.cells[GridItens.getcolumn('movd_pesocarcaca'),x]:=formatfloat(f_cr3,QSaida.fieldbyname('movd_pesocarcaca').asfloat);
//            GridItens.cells[GridItens.getcolumn('movd_vlrarroba'),x]:=formatfloat(f_cr,QSaida.fieldbyname('movd_vlrarroba').asfloat);
            GridItens.cells[GridItens.getcolumn('movd_pecas'),x]:=formatfloat(f_cr,QSaida.fieldbyname('movd_pecas').asfloat);
            vlritem:=QSaida.fieldbyname('movd_pesocarcaca').asfloat*QSaida.fieldbyname('movd_vlrarroba').asfloat;
//            GridItens.cells[GridItens.getcolumn('total'),x]:=formatfloat(f_cr,vlritem);
            if trim(QSaida.fieldbyname('movd_ordem').Asstring)<>'' then
              GridItens.Cells[gridItens.getcolumn('movd_seq'),x]:=strzero(strtoint(QSaida.fieldbyname('movd_ordem').Asstring),3)
            else
              GridItens.Cells[gridItens.getcolumn('movd_seq'),x]:=strzero(QSaida.fieldbyname('movd_ordem').Asinteger,3);
  //          GridItens.cells[GridItens.getcolumn('movd_oprastreamento'),x]:=QSaida.fieldbyname('movd_oprastreamento').asstring;
            inc(x);
            GridItens.appendrow;
            qtde:=qtde+QSaida.fieldbyname('movd_pesocarcaca').asfloat;
            valor:=valor+vlritem;
            QSaida.Next;

   end;

end;

procedure TFEmbalagemDesossa.SetaEditEntradasAbate(Ed: TSqlEd);
///////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    Datainicial:TDatetime;
    opcao:boolean;
begin
   Ed.Items.Clear;
   DataInicial:=sistema.hoje-45;
   opcao:=true;
   if opcao then begin
     Q:=sqltoquery('select mova_numerodoc,mova_datacont,mova_tipo_codigo,clie_nome,mova_notagerada,'+
                   '(select count(*) from movabatedet  where mova_transacao=movd_transacao and movd_status=''N'') as items'+
                 ' from movabate inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                 ' where '+FGeral.Getin('mova_situacao','P','C')+
                 ' and  ( (mova_notagerada=0) or (mova_notagerada=null) )'+
                 ' and mova_tipomov='+Stringtosql(Tipomov)+
                 ' and mova_dtabate>='+Datetosql(datainicial)+
                 ' and mova_status=''N'''+
                 ' and mova_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                 ' order by clie_nome,mova_numerodoc desc');
// 15.09.15
     if Q.fieldbyname('items').asinteger=0 then begin
        Q.close;
        Q:=sqltoquery('select mova_numerodoc,mova_datacont,mova_tipo_codigo,clie_nome,mova_notagerada,mova_numerodoc as items'+
                 ' from movabate inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                 ' where '+FGeral.Getin('mova_situacao','P','C')+
                 ' and  ( (mova_notagerada=0) or (mova_notagerada=null) )'+
                 ' and mova_tipomov='+Stringtosql(Tipomov)+
                 ' and mova_dtabate>='+Datetosql(datainicial)+
                 ' and mova_status=''N'''+
                 ' and mova_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                 ' order by clie_nome,mova_numerodoc desc');
     end;
   end else
     Q:=sqltoquery('select mova_numerodoc,mova_datacont,mova_tipo_codigo,clie_nome,mova_notagerada from movabate inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                 ' where '+FGeral.Getin('mova_situacao','N;P','C')+
                 ' and mova_tipomov='+Stringtosql(Tipomov)+
                 ' and mova_dtabate>='+Datetosql(datainicial)+
                 ' and mova_status=''N'''+
                 ' and mova_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                 ' order by mova_numerodoc desc');
   while not Q.Eof do begin
     if opcao then begin
       if Q.fieldbyname('items').asinteger>=0 then begin
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

procedure TFEmbalagemDesossa.ZeraCampos;
/////////////////////////////////////////////
begin

   PTotalPesado.caption:='';
   PTara.caption:='';
   tara:=0;
   EdProduto.text:='';
   EdPeso.text:='';
   Ppeso.caption:='';
   pnomeproduto.caption:='';

end;

end.
