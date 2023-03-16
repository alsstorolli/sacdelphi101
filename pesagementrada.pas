unit pesagementrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrBase, ACBrBAL, StdCtrls, Mask, SQLEd, Grids, SqlDtg,
  Buttons, SQLBtn, alabel, ExtCtrls, SQLGrid, SqlExpr, SqlFun, AcbrDevice,
  Math, ACBrNFe,ACBrDANFCeFortesFrEA,ACBrDANFCeFortesFrETQEA, pcnconversao, ACBrDFe, ACBrETQ,
  ShellApi, ACBrDanfCeFortesFrETQFAT, ACBrDanfCeFortesFrETQFATAdapar,
  AcbrDeviceSerial ;
type
  TFPesagemEntrada = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    blebalanca: TSQLBtn;
    bretnropedido: TSQLBtn;
    bromaneio: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    EdNumeroDOC: TSQLEd;
    PIns: TSQLPanelGrid;
    EdPeso: TSQLEd;
    PPeso: TSQLPanelGrid;
    pNomeProduto: TSQLPanelGrid;
    PPedidos: TSQLPanelGrid;
    GridPedido: TSqlDtGrid;
    PTotais: TSQLPanelGrid;
    PTotalPesado: TSQLPanelGrid;
    AcbrBal1: TACBrBAL;
    EdProduto: TSQLEd;
    pnomecliente: TSQLPanelGrid;
    panimaispesados: TSQLPanelGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ppesobalanca: TLabel;
    ptara: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    ACBrETQ1: TACBrETQ;
    bimpetq: TSQLBtn;
    EdSeqi: TSQLEd;
    EdSeqf: TSQLEd;
    Edidade: TSQLEd;
    EdBrinco: TSQLEd;
    ACBrNFe1: TACBrNFe;
    EdCupim: TSQLEd;
    procedure blebalancaClick(Sender: TObject);
    procedure AcbrBal1LePeso(Peso: Double; Resposta: AnsiString);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bretnropedidoClick(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure bromaneioClick(Sender: TObject);
    procedure bexcluipesagemClick(Sender: TObject);
    procedure EdNumeroDOCValidate(Sender: TObject);
    procedure EdPesoValidate(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure bimpetqClick(Sender: TObject);
    procedure EdSeqfValidate(Sender: TObject);
    procedure EdSeqfExitedit(Sender: TObject);
    procedure EdProdutoExitEdit(Sender: TObject);
    procedure PMensClick(Sender: TObject);
    procedure EdBrincoValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure Execute( xTipomov:string='EA' );
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
// 24.10.15
    procedure ImprimeRomaneio(xnumerodoc:integer;xCodigoUnidade:string);
//30.12.19
    procedure ImprimeEtiquetasAdapar;

  end;

var
  FPesagemEntrada: TFPesagemEntrada;
  QPedido,QSaida:TSqlquery;
  Sqltipomov,Unidade,Transacao,TipoMov,TipoEntradaAbate,
  TipoFazenda,
  CorteMaterial:string;
  DataPedido:TDatetime;
  Temgrid:boolean;
  Seq,CodigoCliente:integer;
  Tara,xpeso:Currency;

implementation

uses Geral, SqlSis, Estoque, RelGerenciais, grupos, cadcli, pcnNFe,
  impressao, munic, Unidades,Printers, custos, StrUtils,
  ACBrNFeNotasFiscais;

{$R *.dfm}

function TFPesagemEntrada.AbrirPorta(qbalanca: string): boolean;
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

procedure TFPesagemEntrada.blebalancaClick(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
   if EdNumerodoc.asinteger=0 then begin
     EdNumerodoc.invalid('N�mero do pedido est� zerado');
     exit;
   end;
//   if trim(GridPedido.cells[0,1])='' then begin
//     Avisoerro('Sem itens no pedido');
//     exit;
 //  end;
   EdProduto.setfocus;
end;

procedure TFPesagemEntrada.ConfiguraBalancas;
////////////////////////////////////////////////////


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

procedure TFPesagemEntrada.Execute( xTipomov:string='EA' );
/////////////////////////////////////////////////////////

   procedure  SetaItemsEstoque;
   //////////////////////////////
   var Lista:TStringlist;
       s:string;
       p:integer;
   begin
     FPesagemEntrada.EdProduto.Items.clear;
     Lista:=TStringlist.create;
     s:=FGeral.Getconfig1asstring('Produtosnaovenda');
//     if (trim(s)<>'') and (Tipomov=TipoEntradaAbate) then begin
// 23.05.18
     if (trim(s)<>'') then begin
       FPesagemEntrada.EdProduto.ShowForm:='';
       strtolista(Lista,s,';',true);
       for p:=0 to Lista.count-1 do begin
          if trim(Lista[p])<>'' then
            FPesagemEntrada.EdProduto.Items.add(strspace(Lista[p],15)+' - '+FEstoque.getdescricao(Lista[p]));
       end;
       FPesagemEntrada.EdProduto.ItemsLength:=15;
     end else begin
       FPesagemEntrada.EdProduto.ShowForm:='FEstoque';
       FPesagemEntrada.EdProduto.ItemsLength:=0;
     end;
   end;

begin

// 23.05.18
   TipoEntradaAbate:='EA';
   TipoFazenda:='FA';
   Tipomov:=xTipoMov;
   EdNumerodoc.ClearAll(FPesagemEntrada,99);

   if tipomov=TipoEntradaAbate then
      Caption:='Pesagem de Entrada de Abate - Sac Vers�o '+Global.VersaoSistema
   else
      Caption:='Pesagem de Entrada de Vivos - Sac Vers�o '+Global.VersaoSistema;

   GridPedido.clear;
   ZeraCampos;
   ConfiguraBalancas;
   if not Global.Usuario.OutrosAcessos[0040] then
     abrirporta( 'BAL1' );

   Unidade:=Global.CodigoUnidade;
   if FGeral.Getconfig1asinteger('DIASPEDIDO')>0 then
     DataPedido:=Sistema.hoje-FGeral.Getconfig1asinteger('DIASPEDIDO')
   else
     DataPedido:=Sistema.Hoje-60;
   FPesagemEntrada.WindowState:=wsMaximized;
   FGeral.ConfiguraColorEditsNaoEnabled(FPesagemEntrada);
   FPesagemEntrada.SetaEditEntradasAbate(FPesagemEntrada.EdNUmerodoc);

   SetaItemsEstoque;
   ZeraCampos;
   EdSeqi.Visible:=false;
   EdSeqf.Visible:=false;
   Show;
// 07.07.18 - ver criar configuracao para identificar o corte a ser considerado da meia
//            carca�a para emissao das etiquetas
   cortematerial:='14';
   EdNumeroDoc.setfocus;

end;

// 12.09.15
procedure TFPesagemEntrada.ZeraCampos;
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

procedure TFPesagemEntrada.AcbrBal1LePeso(Peso: Double; Resposta: AnsiString);
////////////////////////////////////////////////////////////////////////////
var valid : integer;
    xResposta,outra:string;
begin
   xResposta := copy( Resposta,5,06)  ;
//   pPeso.Caption := xResposta ;
//   pPesobalanca.Caption := xResposta ;
   if FGeral.GetConfig1AsInteger('DIVBALANCA')>0 then
        peso:=Texttovalor(xresposta)/FGeral.GetConfig1AsInteger('DIVBALANCA')
   else
        peso:=Texttovalor(xresposta);
// caso estiver somente com a tara da balanca
    if pos('-',xresposta)>0 then peso:=0;
    EdPeso.setvalue(peso);
    PMens.Caption := resposta+' - '+xresposta;
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
     end;
end;

procedure TFPesagemEntrada.SetaEditEntradasAbate(Ed: TSqlEd);
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

procedure TFPesagemEntrada.GravaPeso;
//////////////////////////////////////
var Q,QC:TSqlquery;
    sqldata,sqltipomov,
    produto,
    material:string;

begin

  sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
  Sqltipomov:=' and mova_tipomov='+Stringtosql( Tipomov );
  produto:=trim(EdProduto.text);
// 06.07.18 - Novicarnes - Isonel
//  material:=FComposicao.getcodigocomposicao( Produto );
  material:=Produto;
  QC:=sqltoquery('select * from custos '+
                ' inner join estoque on ( cust_esto_codigomat = esto_codigo )'+
                ' where cust_status='+StringtoSql('N')+
//                ' and cust_core_codigo = '+cortematerial+
                ' and cust_esto_codigo='+stringtosql(material) );
//                ' and cust_unid_codigo='+stringtosql(Global.codigounidade) );
  if QC.Eof then begin
     Avisoerro('Falta configurar a composi��o do codigo '+material+'. Peso n�o gravado');
     exit;
  end;
  Q:=sqltoquery('select * from movabate'+
                      ' where mova_numerodoc='+EdNumerodoc.assql+
                      ' and '+FGeral.Getin('mova_unid_codigo',Global.CodigoUnidade,'C')+
                      ' and mova_status=''N'''+
                      ' and mova_situacao=''P'''+
                      sqldata+sqltipomov );
    Transacao:=Q.fieldbyname('mova_transacao').asstring;
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
  EdBrinco.Clear;
  GridPedido.setfocus;
end;

procedure TFPesagemEntrada.AtualizaValores;
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
  panimaispesados.caption:=inttostr(animais);
//  PValorTotal.caption:=FormatFloat(f_cr,valortotal);

end;

// 15.05.20
procedure TFPesagemEntrada.EdBrincoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
var Qb:TSqlquery;
begin

  if not EdBrinco.IsEmpty then begin

     Qb:=sqltoquery('select movd_brinco from movabatedet'+
//                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' where movd_numerodoc = '+EdNumerodoc.assql+
                     ' and movd_tipomov='+stringtosql('EA')+
//                     ' and mova_tipomov='+stringtosql('EA')+
                     ' and movd_brinco = '+EdBrinco.AsSql+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     ' and movd_datamvto >= '+Datetosql(Sistema.Hoje-180)+
                     ' and '+FGeral.GetIN('movd_status','N','C'));
      if not Qb.Eof then begin

         FGeral.FechaQuery(Qb);
         EdBrinco.Invalid('Brinco j� usado neste pedido')

      end else begin

// 17.11.20 - se � 'da fazenda'
         if codigocliente = 3465 then begin

           FGeral.FechaQuery(Qb);
           Qb:=sqltoquery('select movd_brinco,movd_numerodoc from movabatedet'+
  //                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                       ' where movd_numerodoc <> '+EdNumerodoc.assql+
                       ' and movd_tipomov='+stringtosql('EA')+
                       ' and movd_brinco = '+EdBrinco.AsSql+
                       ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                       ' and movd_datamvto >= '+Datetosql(Sistema.Hoje-180)+
                       ' and '+FGeral.GetIN('movd_status','N','C'));
          if not Qb.Eof then begin

             Avisoerro('ATEN��O - Brinco j� usado EM OUTRO PEDIDO no. '+Qb.fieldbyname('movd_numerodoc').asstring);
             FGeral.GravaLog(039,'Brinco '+Edbrinco.text+' Pedido '+EdNumerodoc.text);

          end;

          FGeral.FechaQuery(Qb);

        end;

      end;
// 16.11.20 - se � 'da fazenda'
      if codigocliente = 3465 then begin

        Qb:=sqltoquery('select movd_brinco,movd_operacao from movabatedet where movd_brinco = '+EdBrinco.AsSql+
                     ' and movd_status = ''N'' and movd_tipomov='+Stringtosql(TipoFazenda));
        if Qb.eof then begin

         Avisoerro('Brinco n�o encontrado na FAZENDA');
         FGeral.GravaLog(038,'Brinco '+Edbrinco.text+' Pedido '+EdNumerodoc.text);

        end;
        FGeral.FechaQuery(Qb);

      end;

  end;

end;

procedure TFPesagemEntrada.EditstoGrid(xseq: integer);
/////////////////////////////////////////////////////////
var x:integer;
    valorvenda:currency;
begin
  if xseq=0 then
    x:=ProcuraGrid(GridPedido.getcolumn('movd_seq'),strzero(xseq,3),0,0,0,0,0,0 )
  else
    x:=ProcuraGrid(GridPedido.getcolumn('movd_seq'),strzero(xseq,3),0,0,0,0,0,0 );
//  valorvenda:=Texttovalor( GridPedido.cells[GridPedido.getcolumn('mpdd_venda'),GridPedido.row] );
//  if x<0 then begin
    temgrid:=false;
    GridPedido.AppendRow;
    GridPedido.Cells[GridPedido.getcolumn('movd_seq'),Abs(x)]:=strzero(Seq,3);
    GridPedido.Cells[GridPedido.getcolumn('mpdd_esto_codigo'),Abs(x)]:=trim(EdProduto.text);
    GridPedido.Cells[GridPedido.getcolumn('esto_descricao'),Abs(x)]:=FEstoque.getdescricao(trim(EdProduto.text));
//    GridPedido.Cells[GridPedido.getcolumn('movd_pesocarcaca'),Abs(x)]:=trim(Transform( EdPeso.Ascurrency, f_cr3 ));
    GridPedido.Cells[GridPedido.getcolumn('movd_pesocarcaca'),Abs(x)]:=EdPeso.Assql;
//    GridPedido.Cells[GridPedido.getcolumn('movd_pecas'),Abs(x)]:=Edpecas.AsSql;
//  end else begin
//    temgrid:=true;
//    GridPedido.Cells[GridPedido.getcolumn('movd_pesocarcaca'),Abs(x)]:=Transform( EdPeso.Ascurrency, f_cr3 ) ;
//    GridPedido.Cells[GridPedido.getcolumn('movd_pecas'),Abs(x)]:=Edpecas.AsSql;
//  end;

end;


procedure TFPesagemEntrada.GravaItem(op: string; Q: Tsqlquery);
//////////////////////////////////////////////////////////////////
var linha,
    pdianteiro,
    ptraseiro,
    qtraseiro,
    p,
    i,
    dian,
    tras            :integer;
    vlrarroba,
    xqtde,xpesocarcaca     :currency;
    QE,QC:TSqlquery;
    material  :string;

begin


//    material:=FComposicao.getcodigocomposicao( trim(EdProduto.text) );

     material:=trim(EdProduto.text) ;


     if op='I' then begin

        linha:=ProcuraGrid(GridPedido.GetColumn('movd_seq'),strzero(seq,3));
        Sistema.Insert('movabatedet');
        Sistema.SetField('movd_esto_codigo',trim(Edproduto.text));
        Sistema.SetField('movd_transacao',transacao);
        Sistema.SetField('movd_operacao',transacao+GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]);
        Sistema.SetField('movd_numerodoc',Ednumerodoc.Asinteger);
        Sistema.SetField('movd_status','N');
        Sistema.SetField('movd_tipomov',TipoMov);
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
// 23.05.18 - gravacao de pesos de animais vivos da fazenda
        if tipomov=TipoEntradaAbate then begin

          Sistema.SetField('movd_pesocarcaca',xPeso);
// 18.09.19 - Isonel
          Sistema.SetField('movd_pesobalanca',xPeso+texttovalor(ptara.Caption) ) ;

        end else
          Sistema.SetField('movd_pesovivo',xPeso );


        //        Sistema.SetField('movd_vlrarroba',FGrupos.GetValorArroba( FEstoque.GetGrupo(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]),Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha]) ) );
// 11.01.16 - para ver se para de 'ora pegar faixa certa ora pegar faixa errada'...
        vlrarroba:=FGrupos.GetValorArroba( FEstoque.GetGrupo(EdProduto.text),Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha]),EdProduto.text,tipomov ) ;
        Sistema.SetField('movd_vlrarroba',vlrarroba  );

//         Aviso( 'Valor Arroba : '+FGeral.formatavalor(vlrarroba,f_cr) );

//        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
        Sistema.SetField('movd_ordem',strtoint(GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]));
        Sistema.SetField('movd_pecas',1);
// 28.06.17
        Sistema.SetField('movd_idade',EdIdade.Text);
// 24.05.18
        Sistema.SetField('movd_brinco',EdBrinco.Text);
// 15.05.20
        Sistema.SetField('movd_datamvto',Sistema.Hoje);
// 05.06.20
        Sistema.SetField('movd_cupim',EdCupim.Text);
        Sistema.Post('');

///////////////////////////////////////////////////////////////////////////////////////////
// 08.06.16 - entra no estoque da carca�a e gera movimento do codigo dela de duas carca�as
///////////////////////////////////////////////////////////////////////////////////////////////
///      if ( trim(material)<>'' ) and (tipomov=TipoEntradaAbate) then begin
// 05.07.18 - entra no estoque das pe�as da composicao e gera movimento delas
///////////////////////////////////////////////////////////////////////////////////////////////
///  23.10.18 - usar o campo de qtde da composicao para definir o numero de etiquetas impressas
///
       QC:=sqltoquery('select * from custos '+
                ' inner join estoque on ( cust_esto_codigomat = esto_codigo )'+
                ' where cust_status='+StringtoSql('N')+
//                ' and cust_core_codigo = '+cortematerial+
                ' and cust_esto_codigo='+stringtosql(material)+
// 23.04.20 - ordem da impressao para bovinos.. QD, QD, QT
                ' order by esto_descricao' );

 //               ' and cust_unid_codigo='+stringtosql(Global.codigounidade) );

       pdianteiro:=1;
       ptraseiro:=4;
       qtraseiro:=0;
       dian:=1;
       tras:=2;
       p:=0;

       while  not Qc.eof do begin

          inc(p);
          material:=Qc.FieldByName('cust_esto_codigomat').AsString;
          xqtde   :=(Qc.FieldByName('cust_perqtde').AsCurrency/100)*TexttoValor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha]);
          xpeso   :=xqtde;

          QE:=Sqltoquery('select *,esto_descricao from estoqueqtde'+
                      ' inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                      ' where esqt_unid_codigo = '+Stringtosql(Unidade)+
                      ' and esqt_esto_codigo = '+Stringtosql(material)+
                      ' and esqt_status = ''N''');


          if ( trim(material)<>'' ) and (tipomov=TipoEntradaAbate) then begin

//            FGeral.MovimentaQtdeEstoque( material ,Unidade,'E',TipoMov,
//                   TexttoValor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha]),Qe,0,2);
            FGeral.MovimentaQtdeEstoque( material ,Unidade,'E',TipoMov,xqtde,Qe,0,2);


            xpeso:=xpeso/2;

{
          if AnsiPos('QUARTO DIANTEIRO', Uppercase(QE.FieldByName('esto_descricao').AsString) ) >0 then begin
             if dian>1 then p:=dian else
             begin
                p:=dian;
                dian:=4;
             end;
          end else if AnsiPos('QUARTO TRASEIRO', Uppercase(QE.FieldByName('esto_descricao').AsString) ) >0 then begin
                p:=tras;
                inc(tras);
          end;
}


//            xpeso:=xqtde/2;
           for i := 1 to Qc.FieldByName('cust_qtde').AsInteger do begin

              Sistema.Insert('movabatedet');
              Sistema.SetField('movd_esto_codigo',material);
              Sistema.SetField('movd_transacao',transacao);
  //            Sistema.SetField('movd_operacao',transacao+GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]+'0');
  // 16.07.18
              Sistema.SetField('movd_operacao',transacao+GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]+inttostr(p) );
              Sistema.SetField('movd_numerodoc',Ednumerodoc.Asinteger);
              Sistema.SetField('movd_status','N');
              Sistema.SetField('movd_tipomov','PC');
              Sistema.SetField('movd_unid_codigo',Unidade);
              Sistema.SetField('movd_tipo_codigo',codigocliente);
    //          Sistema.SetField('movd_pesocarcaca',Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha])/2);
    // 19.09.17
              Sistema.SetField('movd_pesocarcaca',xPeso);
              Sistema.SetField('movd_vlrarroba',vlrarroba  );
              Sistema.SetField('movd_ordem',strtoint(GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]));
              Sistema.SetField('movd_pecas',1);
              Sistema.SetField('movd_datamvto',Sistema.Hoje);
// 06.11.18 - pra depois usar no boi casado os termos quarto dianteiro e quarto traseiro
              if AnsiPos('QUARTO TRASEIRO',Uppercase( FEstoque.GetDescricao(material)) )>0 then begin

                 Sistema.SetField('movd_obs','QUARTO TRASEIRO' + inttostr(ptraseiro) );
                 if ptraseiro=4 then
                    Sistema.SetField('movd_baia','B')
                 else if ptraseiro=5 then
                    Sistema.SetField('movd_baia','D');

                 inc(ptraseiro);
                 inc(qtraseiro);
                 if qtraseiro=1 then dec(ptraseiro);
                 if qtraseiro=3 then dec(ptraseiro);


              end else if AnsiPos('QUARTO DIANTEIRO',Uppercase( FEstoque.GetDescricao(material)) )>0 then begin

                 Sistema.SetField('movd_obs','QUARTO DIANTEIRO' + inttostr(pdianteiro) );
                 if pdianteiro=1 then
                    Sistema.SetField('movd_baia','A')
                 else if pdianteiro=2 then
                    Sistema.SetField('movd_baia','C');

                 inc(pdianteiro);

              end else
                 Sistema.SetField('movd_obs',Uppercase(copy(FEstoque.GetDescricao(material),1,20)) );

              Sistema.Post('');
      ///////////////////////////////////////
// 23.10.18 - para gerar 2 etiquetas iguais quando for 4, 6... na qtde na composicao
              if Qc.FieldByName('cust_qtde').AsInteger>=4 then begin

                 if ( i=1 ) or ( i=3 ) then begin

                 end else begin

                    inc(p);

                 end;

              end else

                inc(p);
{
              Sistema.Insert('movabatedet');
              Sistema.SetField('movd_esto_codigo',material);
              Sistema.SetField('movd_transacao',transacao);
  //            Sistema.SetField('movd_operacao',transacao+GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]+'1');
  // 16.07.18
              Sistema.SetField('movd_operacao',transacao+GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]+inttostr(p));
              Sistema.SetField('movd_numerodoc',Ednumerodoc.Asinteger);
              Sistema.SetField('movd_status','N');
              Sistema.SetField('movd_tipomov','PC');
              Sistema.SetField('movd_unid_codigo',Unidade);
              Sistema.SetField('movd_tipo_codigo',codigocliente);
    //          Sistema.SetField('movd_pesocarcaca',Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha])/2);
    // 19.09.17
              Sistema.SetField('movd_pesocarcaca',xPeso);
              Sistema.SetField('movd_vlrarroba',vlrarroba  );
              Sistema.SetField('movd_ordem',strtoint(GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]));
              Sistema.SetField('movd_pecas',1);
              Sistema.Post('');
}

           end;  // for da qtde na composicao


          end;

          QC.Next;

          FGeral.FechaQuery(Qe);

       end;
////////////////////////////////////////////////////////////////////////////

     end;


end;

procedure TFPesagemEntrada.PMensClick(Sender: TObject);
//////////////////////////////////////////////////////////
var linha:integer;
    produto,material,transacao,sqldata:string;
    Q,QC:TSqlquery;
    xpeso,xqtde,vlrarroba:currency;

begin

  if not confirma('confirma repesagem ?') then exit;

  sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);

  Q:=sqltoquery('select * from movabate'+
                          ' where mova_numerodoc='+EdNumerodoc.assql+
                          ' and '+FGeral.Getin('mova_unid_codigo',Global.CodigoUnidade,'C')+
                          ' and mova_status=''N'''+
                          ' and mova_situacao=''P'''+
                          sqldata+sqltipomov );

  Transacao:=Q.fieldbyname('mova_transacao').asstring;

  for linha:= 1 to GridPedido.rowcount do begin

    produto:=trim(GridPedido.Cells[GridPedido.getcolumn('mpdd_esto_codigo'),linha]);

    if produto<>'' then begin
{
      QC:=sqltoquery('select * from custos '+
                    ' inner join estoque on ( cust_esto_codigomat = esto_codigo )'+
                    ' where cust_status='+StringtoSql('N')+
                    ' and cust_esto_codigo='+stringtosql(produto) );
    //                ' and cust_unid_codigo='+stringtosql(Global.codigounidade) );
      if QC.Eof then begin
         Avisoerro('Falta configurar a composi��o do codigo '+produto+'. Peso n�o gravado');
         exit;
      end;
}
       material:=FComposicao.GetCodigoComposicao(produto);
       xpeso := Texttovalor( GridPedido.Cells[GridPedido.getcolumn('movd_pesocarcaca'),linha] );

       Sistema.BeginProcess('Gravando codigo '+produto);

       vlrarroba:=FGrupos.GetValorArroba( FEstoque.GetGrupo(EdProduto.text),Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha]),EdProduto.text,tipomov ) ;

       QC:=sqltoquery('select * from custos '+
                ' inner join estoque on ( cust_esto_codigomat = esto_codigo )'+
                ' where cust_status='+StringtoSql('N')+
//                ' and cust_core_codigo = '+cortematerial+
                ' and cust_esto_codigo='+stringtosql(material));
 //               ' and cust_unid_codigo='+stringtosql(Global.codigounidade) );

//       while  not Qc.eof do begin

//          material:=Qc.FieldByName('cust_esto_codigomat').AsString;
//          xqtde   :=(Qc.FieldByName('cust_perqtde').AsCurrency/100)*TexttoValor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha]);


          if ( trim(material)<>'' ) and (tipomov=TipoEntradaAbate) then begin

//            xpeso:=xqtde/2;

            xpeso:=xpeso/2;
            Sistema.Insert('movabatedet');
            Sistema.SetField('movd_esto_codigo',material);
            Sistema.SetField('movd_transacao',transacao);
            Sistema.SetField('movd_operacao',transacao+GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]+'0');
            Sistema.SetField('movd_numerodoc',Ednumerodoc.Asinteger);
            Sistema.SetField('movd_status','N');
            Sistema.SetField('movd_tipomov','PC');
            Sistema.SetField('movd_unid_codigo',Unidade);
            Sistema.SetField('movd_tipo_codigo',codigocliente);
  //          Sistema.SetField('movd_pesocarcaca',Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha])/2);
  // 19.09.17
            Sistema.SetField('movd_pesocarcaca',xPeso);
            Sistema.SetField('movd_vlrarroba',vlrarroba  );
            Sistema.SetField('movd_ordem',strtoint(GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]));
            Sistema.SetField('movd_pecas',1);
            Sistema.Post('');
    ///////////////////////////////////////
            Sistema.Insert('movabatedet');
            Sistema.SetField('movd_esto_codigo',material);
            Sistema.SetField('movd_transacao',transacao);
            Sistema.SetField('movd_operacao',transacao+GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]+'1');
            Sistema.SetField('movd_numerodoc',Ednumerodoc.Asinteger);
            Sistema.SetField('movd_status','N');
            Sistema.SetField('movd_tipomov','PC');
            Sistema.SetField('movd_unid_codigo',Unidade);
            Sistema.SetField('movd_tipo_codigo',codigocliente);
  //          Sistema.SetField('movd_pesocarcaca',Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha])/2);
  // 19.09.17
            Sistema.SetField('movd_pesocarcaca',xPeso);
            Sistema.SetField('movd_vlrarroba',vlrarroba  );
            Sistema.SetField('movd_ordem',strtoint(GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]));
            Sistema.SetField('movd_pecas',1);
            Sistema.Post('');

          end;

//          QC.Next;


//       end;


        end;

  end;

  try
     Sistema.Commit;
     Sistema.EndProcess('Terminado');
  except
     Sistema.EndProcess('Problemas para gravar no banco de dados');

  end;

end;

function TFPesagemEntrada.ProcuraGrid(Coluna: integer; Pesquisa: string;
  Colunatam, tam, colunacor, cor, colunacopa, copa: integer): integer;
////////////////////////////////////////////////////////////////////////////
var p:integer;
begin
  result:=0;seq:=0;
  for p:=1 to GridPedido.RowCount do  begin
      if trim(GridPedido.Cells[GridPedido.getcolumn('movd_seq'),p])<>'' then begin
        seq:=strtoint(GridPedido.Cells[GridPedido.getcolumn('movd_seq'),p]);
        inc(seq);
      end else begin
        if seq=0 then
          seq:=1;
      end;
  end;
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
end;

procedure TFPesagemEntrada.ConfiguraTeclas(Key: Word);
//////////////////////////////////////////////////////////
begin
 if key = vk_f4 then blebalancaClick(self)
 else if key = vk_f5 then bimpetqClick(self)
 else if key = vk_f3 then bretnropedidoClick(self)
 else if key = vk_f6 then bSairClick(self)
// else if key = vk_f10 then bgeranotaClick(self)
 else if key = vk_f11 then bromaneioClick(self)
// else if key = VK_Back then bnotaspendentesclick(self)
 else if key = vk_f2 then bexcluipesagemClick(self);

end;

procedure TFPesagemEntrada.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);

end;

procedure TFPesagemEntrada.bretnropedidoClick(Sender: TObject);
begin
// 22.10.15 - para atualizar pedidos recem digitados
   FPesagemEntrada.SetaEditEntradasAbate(FPesagemEntrada.EdNUmerodoc);
   EdNumerodoc.setfocus;
end;

procedure TFPesagemEntrada.bSairClick(Sender: TObject);
begin
  if AcbrBal1.Ativo then AcbrBal1.Desativar;
  close;
  if Global.Usuario.OutrosAcessos[0054] then Application.Terminate;

end;

procedure TFPesagemEntrada.bromaneioClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin
//  FRelGerenciais_EntradadeAbate(EdNumerodoc.asinteger,Global.CodigoUnidade,'EA');
//  if global.usuario.codigo<>100 then
    ImprimeRomaneio(EdNumerodoc.asinteger,Global.CodigoUnidade);
//  else
///    FRelGerenciais_EntradadeAbate(EdNumerodoc.asinteger,Global.CodigoUnidade,'PA');


end;

procedure TFPesagemEntrada.bexcluipesagemClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////////////
//var ordem:integer;
//    produto:string;
begin
{
  ordem:=strtoint(GridPedido.Cells[GridPedido.getcolumn('movd_seq'),GridPedido.row]);
  produto:=trim(GridPedido.Cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]);
  if ordem=0 then exit;
  if not confirma('Confirma exclus�o deste peso ?') then exit;
  try
    Sistema.Edit('movabatedet');
    Sistema.SetField('movd_status','C');
    Sistema.Post('movd_numerodoc='+EdNumerodoc.assql+
                 ' and movd_ordem='+inttostr(ordem)+
                 ' and movd_esto_codigo='+Stringtosql(produto)+
                 ' and movd_tipomov='+Stringtosql(Tipomov)+
                 ' and movd_unid_codigo='+Stringtosql(unidade)+
                 ' and movd_status='+Stringtosql('N')
                 );
    Sistema.Commit;
    GridPedido.DeleteRow(GridPedido.row);
    AtualizaValores;
  except
    Avisoerro('N�o foi poss�vel excluir.  Verificar');
  end;
}

end;

procedure TFPesagemEntrada.EdNumeroDOCValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
var sqlaberto,sqlwhere,sqldata,sqlunidades:string;
    x:integer;
begin

   sqlaberto:=' and '+Fgeral.getin('mova_situacao','P','C');
// 18.11.16
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
// 24.02.20
                       ' and movd_numerodoc = '+EdNUmerodoc.AsSql+
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
// 24.02.20
                       ' and movd_numerodoc = '+EdNUmerodoc.AsSql+
                       ' and movd_tipomov='+Stringtosql(Tipomov)+
                       ' order by mova_dtabate,movd_numerodoc,movd_ordem');
        if QPedido.eof then Avisoerro('Entrada de abate n�o encontrada.')
        else CodigoCliente:=QPedido.fieldbyname('mova_tipo_codigo').asinteger;

   end else

      CodigoCliente:=QPedido.fieldbyname('mova_tipo_codigo').asinteger;


   GridPedido.clear;
   Ppeso.caption:='';
   x:=1;

   while (not QPedido.eof) do begin

         GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),x]:=QPedido.fieldbyname('movd_esto_codigo').asstring;
         GridPedido.cells[GridPedido.getcolumn('esto_descricao'),x]:=QPedido.fieldbyname('esto_descricao').asstring;
         GridPedido.cells[GridPedido.getcolumn('movd_seq'),x]:=strzero(QPedido.fieldbyname('movd_ordem').asinteger,3);
//         GridPedido.cells[GridPedido.getcolumn('mpdd_pecas'),x]:=QPedido.fieldbyname('mpdd_pecas').asstring;
//         GridPedido.cells[GridPedido.getcolumn('mpdd_venda'),x]:=QPedido.fieldbyname('mpdd_venda').asstring;
// 23.05.18
         if Tipomov=TipoFazenda then
           GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),x]:=Formatfloat(f_cr3,QPedido.fieldbyname('movd_pesovivo').ascurrency)
         else
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

procedure TFPesagemEntrada.EdPesoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
var Qe:TSqlquery;
    tara:currency;
begin
// 23.05.18
  tara:=0;
  if (EdPeso.ascurrency>0)  then begin
     QE:=Sqltoquery('select esto_qbalanca,esto_tara,esto_peso,esto_descricao,esto_taraperc from estoque where esto_codigo='+Stringtosql(trim(EdProduto.text)));
     if not QE.eof then
//        Tara:=QE.fieldbyname('esto_tara').ascurrency + ( EdPeso.ascurrency*(QE.fieldbyname('esto_taraperc').ascurrency/100))
// 03.05.19  - primeiro tira a tara
        Tara:=   QE.fieldbyname('esto_tara').ascurrency + ( (EdPeso.ascurrency-QE.fieldbyname('esto_tara').ascurrency)*(QE.fieldbyname('esto_taraperc').ascurrency/100))
     else
        tara:=0;
    tara:=Arred(Tara);
    if (Tipomov=TipoFazenda) then tara:=0;

    if Global.Topicos[1318] then
       EdPeso.setvalue( arred(EdPeso.ascurrency) );
    ppesobalanca.caption:=Formatfloat('##0.000',EdPeso.ascurrency);
    ptara.caption:=Formatfloat('##0.000',tara);
    EdPeso.setvalue( EdPeso.ascurrency-tara );
    ppeso.caption:=EdPeso.text;
// 28.03.18
    xpeso:=Texttovalor(PPeso.Caption);
    Gravapeso;
    FGeral.fechaquery(Qe);
  end;

end;
{
procedure TFPesagemEntrada.EdNumeroDOCValidate(Sender: TObject);
begin

end;
}
// 28.06.17
procedure TFPesagemEntrada.EdProdutoExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////
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
// 23.05.18
        if (Tipomov=TipoFazenda) then tara:=0;

        pnomeproduto.caption:=QE.fieldbyname('esto_descricao').asstring;
        ptara.caption:=Formatfloat('##0.000',tara);
        if Global.Usuario.outrosacessos[0040] then begin

           EdPeso.enabled:=true;
           EdPeso.setfocus;

        end else begin

           EdPeso.enabled:=false;
           try
//             AcbrBal1.lepeso;
// 25.10.17
             AcbrBal1.lepeso(2000);

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
// 28.03.18
              xpeso:=TextTovalor( ppeso.Caption );
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

end;

procedure TFPesagemEntrada.EdProdutoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var Qe:TSqlquery;
//    peso:currency;
begin

// 28.06.17
   Edidade.Enabled:=false;
// 05.06.20
   Edcupim.Enabled:=false;

// 29.08.17
   Edidade.Text:='-';
   if (trim(EdProduto.text)<>'') and ( pos(',',EdProduto.Text)=0 ) then begin
     Edproduto.text:=trim(EdProduto.text);
     QE:=Sqltoquery('select esto_qbalanca,esto_tara,esto_peso,esto_descricao,esto_taraperc from estoque where esto_codigo='+Stringtosql(trim(EdProduto.text)));
     if not QE.eof then begin
        if ( Ansipos('BOI',Uppercase(QE.FieldByName('esto_descricao').AsString))>0 )
           or
           ( Ansipos('NOVILHA',Uppercase(QE.FieldByName('esto_descricao').AsString))>0 )
           or
           ( Ansipos('NOVILHO',Uppercase(QE.FieldByName('esto_descricao').AsString))>0 )
           then begin
              Edidade.Enabled:=true;
              Edcupim.Enabled:=true;
           end;
     end;
// 08.09.17 - Wagner
     if ( Ansipos('VACA',Uppercase(QE.FieldByName('esto_descricao').AsString))>0 ) then Edidade.text:='+';
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

// 26.09.15  - 03.05.19 - isonel tirou o arredondamento
function TFPesagemEntrada.arred(v: currency): currency;
//////////////////////////////////////////////////////////
var y:currency;
begin
{
  y:=v-int(v);
//  if y >=0.6 then  y:=0.5
// 30.01.17
  if y >=0.5 then  y:=0.5
  else if y<=0.499 then y:=0;
  result:=int(v) + y;
}
  result:=v;

end;

// 30.12.19
procedure TFPesagemEntrada.ImprimeEtiquetasAdapar;
///////////////////////////////////////////////////
var totalpeso,totalitem,ypeso:currency;
    Q1,Q2,QNutri,Qconserva:TSqlquery;
    sqlordem,codmuniemitente,s,arquivoetiq:string;
    Lista:TList;
    i,x:integer;

// 16.07.18
    function GetPesoCarcaca( xt,xordem:string ):currency;
    ///////////////////////////////////////////////
    var Qt:TSqlquery;
    begin

       Qt:=sqltoquery('select movd_pesocarcaca from movabatedet where movd_transacao = '+stringtosql(xt)+
                      ' and movd_ordem = '+xordem+
                      ' and movd_tipomov='+stringtosql('EA') );
       if not Qt.Eof then result:=Qt.FieldByName('movd_pesocarcaca').AsCurrency else result:=0;
       fgeral.FechaQuery(Qt);

    end;

begin

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

    if Global.Usuario.OutrosAcessos[0067] then begin
// 18.10.19
      AcbrNFe1.DANFE := TACBrNFeDANFCeFortesETQFATAdapar.Create(AcbrNFe1);
// 18.12.19  - etiqueta adapar
      acbrnfe1.danfe.MargemSuperior:=1;
      acbrnfe1.danfe.MargemInferior:=10;
      acbrnfe1.danfe.MargemEsquerda:=01;

    end else begin
// 13.07.18
      AcbrNFe1.DANFE := TACBrNFeDANFCeFortesETQFAT.Create(AcbrNFe1);
      acbrnfe1.danfe.MargemSuperior:=18;

    end;

    AcbrNfe1.DANFE.TipoDANFE := tiNFCE;
    if Global.usuario.outrosacessos[0510] then
      acbrnfe1.danfe.MostraPreview:=true
    else
      acbrnfe1.danfe.MostraPreview:=false;

    acbrnfe1.danfe.MargemEsquerda:=01;
    acbrnfe1.danfe.MargemDireita:=05;

    acbrnfe1.danfe.NumCopias:=1;

    s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPETQENTADA');
    if trim(s)<>'' then Acbrnfe1.DANFE.Impressora:=s;


      Q1:=sqltoquery('select * from movabatedet'+
                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                     ' inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                     ' where movd_numerodoc = '+EdNumerodoc.assql+
                     ' and movd_tipomov='+stringtosql('PC')+
                     ' and mova_tipomov='+stringtosql('EA')+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     sqlordem+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
//                     ' order by movd_ordem,movd_baia' );
// 31.12.19
                     ' order by movd_operacao' );

    if Q1.eof then aviso('N�o encontrada a etiqueta gerada');

    Sistema.BeginProcess('Enviando para impressora '+Acbrnfe1.DANFE.Impressora);

    with  ACBrNFe1.NotasFiscais.Add.NFe do begin

      while not Q1.eof do begin

        ypeso:=GetPesoCarcaca( Q1.FieldByName('movd_transacao').AsString,Q1.FieldByName('movd_ordem').AsString );
        ypeso:=ypeso/2;

        Total.ICMSTot.vBC   := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Total.ICMSTot.vProd := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Emit.xFant          := FCadcli.GetNome(codigocliente);
        Emit.xNome          := FCadcli.GetRazaoSocial(codigocliente);
//        Emit.CNPJCPF        := FCadcli.GetCnpjCpf(codigocliente);
        Emit.EnderEmit.xLgr := FCadcli.GetEndereco(codigocliente);
        Emit.EnderEmit.nro  := '';
        Emit.EnderEmit.xCpl := '';
        Ide.modelo          := trunc(ypeso);
        codmuniemitente     := FCidades.GetCodigoIBGE( FUnidades.GetCidaCodigo(Global.CodigoUnidade) );
        Ide.cUF             := strtoint(copy(codmuniemitente,1,2));
        Ide.cNF             := Q1.fieldbyname('movd_numerodoc').asinteger;
//        Ide.dEmi            := Q1.fieldbyname('mova_dtabate').asdatetime;
        Ide.dEmi            := Sistema.hoje;
// 18.12.19
        infNFeSupl.qrCode   := Q1.fieldbyname('movd_operacao').AsString;

//                               ' Data '+FormatDatetime('dd/mm/yyyy',sistema.Hoje)+
//                               ' '+FCadcli.GetRazaoSocial(codigocliente)+
//                               ' '+Q1.fieldbyname('esto_descricao').asstring  ;

        Lista:=TList.create;
// 17.09.18 - busca o codigo do 'produto carca�a'
        Q2:=sqltoquery('select movd_esto_codigo,esto_descricao from movabatedet'+
                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                     ' inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                     ' where movd_numerodoc = '+EdNumerodoc.assql+
                     ' and movd_tipomov='+stringtosql('EA')+
                     ' and mova_tipomov='+stringtosql('EA')+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     ' and movd_transacao = '+Stringtosql(Q1.FieldByName('movd_transacao').AsString)+
                     ' and movd_ordem = '+inttostr(Q1.FieldByName('movd_ordem').AsInteger)+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
                     ' order by movd_ordem' );


          with  Det.Add do
          begin

            totalitem:=FGEral.Arredonda(Q1.fieldbyname('movd_pesocarcaca').ascurrency*(Q1.fieldbyname('movd_vlrarroba').asFLOAT/15),2);

            Prod.qCom    := trunc(Q1.fieldbyname('movd_pesocarcaca').asfloat);
            Prod.qTrib   := trunc(Q1.fieldbyname('movd_pesocarcaca').asfloat);
            Prod.uCom    := Q1.fieldbyname('esto_unidade').asstring;
            Prod.uTrib   := Q1.fieldbyname('esto_unidade').asstring;
            Prod.vProd   := totalitem;
            Prod.vUnCom  := Q1.fieldbyname('movd_vlrarroba').asfloat;
            Prod.vUnTrib := Q1.fieldbyname('movd_vlrarroba').asfloat;
            Prod.xProd   := Q1.fieldbyname('esto_descricao').asstring;
// 17.09.18 - para identificar as classifacacoes 'piores'
//            if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'102;103;104') > 0 then
//               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' HOL'
// 04.06.20 - Isonel reaproveitou codigo 102 que virou premim
            if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'103;104') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' HOL'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'446;48;369') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' CIS'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'453;345;393') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' BAT'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'071;196;167') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' SC'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'106;084;045') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' SC1'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'108;024;062') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' SC2'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'075') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' HSC'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'442') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' SCB' ;


            totalpeso:=totalpeso+Q1.fieldbyname('movd_pesocarcaca').asfloat;
            Prod.cProd   := Q1.fieldbyname('movd_esto_codigo').asstring;
//            Prod.cProd   := Q1.fieldbyname('movd_ordem').asstring;
            Prod.xPed    := Q1.fieldbyname('movd_operacao').asstring;

// 14.07.18 - nova forma de emitir etiquetas no abate
            if Q1.FieldByName('esto_validade').AsInteger >0 then
              Prod.NCM:=inttostr( Q1.FieldByName('esto_validade').AsInteger )
            else
              Prod.NCM:='';
// 02.01.2020  - etiqueta adapar 'com duas por etiqueta'
            Prod.nItem   := trunc(ypeso);
            Prod.cEAN    := Q1.fieldbyname('movd_operacao').AsString;
// 09.01.2020 - Novicarnes - etq adapar
            Prod.cEANTrib:= FGrupos.GetCodigoAdapar( Q1.FieldByName('esto_grup_codigo').AsInteger );
// 28.01.20
            Prod.CEST    := Q1.fieldbyname('movd_ordem').AsString;
// 04.02.20 - identifica��o dos 'super'
            Prod.CFOP    := Q2.fieldbyname('esto_descricao').AsString;

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
              Prod.vUnCom:=QNutri.FieldByName('Nutr_gordsaturadas').AsCurrency;

              if QNutri.FieldByName('nutr_validade').AsInteger >0 then
                Prod.NCM:=inttostr( QNutri.FieldByName('nutr_validade').AsInteger )
              else
                Prod.NCM:='';
            end;
            QNutri.Close;
            QConserva:=sqltoquery('select * from conservacao where cons_codigo='+inttostr(Q1.FieldByName('esto_cons_codigo').AsInteger));
            if not Qconserva.Eof then begin
              Prod.uCom:=QConserva.FieldByName('cons_linha1').AsString;
            end;
            Qconserva.Close;

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

// 30.06.16
    if Global.usuario.outrosacessos[0510] then

      acbrnfe1.danfe.MostraPreview:=true

    else

      acbrnfe1.danfe.MostraPreview:=false;

// 02.01.2020
    AcbrNFe1.NotasFiscais.Items[0].NFe.Transp.vagao  :=EdSeqi.Text;
    AcbrNFe1.NotasFiscais.Items[0].NFe.Transp.balsa  :=EdSeqf.Text;
    AcbrNFe1.NotasFiscais.Items[0].NFe.InfAdic.infCpl:=panimaispesados.caption;

    Sistema.endProcess('');

//      for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin

          ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[0].NFe );

//      end;

      ACBrNFe1.NOtasFiscais.clear;


end;
///////////////////////////////////////////////////////////////////////////////////


// 24.10.15
procedure TFPesagemEntrada.ImprimeRomaneio(xnumerodoc: integer;  xCodigoUnidade: string);
//////////////////////////////////////////////////////////////////////////////////////////
type TProdutos=record
     codigo:string;
     peso:currency;
end;
type TCamara = record
     linha :widestring;
end;

var Q1:TSqlquery;
    totalitem,totalpeso:currency;
    Lista:TList;
    PProdutos:^TProdutos;
    i:integer;
    codmuniemitente,s,linha,arquivoetiq,suinos:string;
    ListaCamara:TList;
    arqimp,arqlido,arqlista:TextFile;
    linhaw:widestring;
    PCamara:^TCamara;

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

         if tipomov=TipoFazenda then
           PProdutos.peso:=Q1.fieldbyname('movd_pesovivo').ascurrency
         else
           PProdutos.peso:=Q1.fieldbyname('movd_pesocarcaca').ascurrency;

         if  Ansipos('SUINOS',UpperCase( FEstoque.GetDescricao(Q1.fieldbyname('movd_esto_codigo').asstring))) >0 then
           suinos:='S';
         Lista.add(PProdutos);
       end else begin

         if tipomov=TipoFazenda then
           PProdutos.peso:=PProdutos.peso + Q1.fieldbyname('movd_pesovivo').ascurrency
         else
           PProdutos.peso:=PProdutos.peso+Q1.fieldbyname('movd_pesocarcaca').ascurrency;

       end;
    end;


    procedure ImprimeEtiqueta( xarq:string ; Item:TAcbrnfe );
    ////////////////////////////////////////////////////////////
    var Lista,ListaImp:TStringList;
        i,pixelx,pixely:integer;
        Arquivo:TextFile;
        vtermica,comando,ultimalinha:string;

        function ColocaDados(linha:string  ):string;
        ////////////////////////////////////////////////////////////////////////////////
        var x,p:integer;
            novalinha,troca:string;
            ListaTroca:TStringlist;

            function PoeInfo( s:string ):string;
            ////////////////////////////////////
            var i:integer;
            begin
              if s = uppercase('[codigo1]') then result:=Item.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.cProd
              else if s = uppercase('[descricao1]') then result:=Item.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.xProd
              else if s = uppercase('[geralpeso]') then result:=FormatFloat(',0', Item.NotasFiscais.Items[0].NFe.Total.ICMSTot.vNF)
              else if s = uppercase('[codigo2]') then begin
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=2 then
                   result:=Item.NotasFiscais.Items[0].NFe.Det.Items[1].Prod.cProd
                 else
                   result:='';
              end else if s = uppercase('[descricao2]') then  begin
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=2 then
                   result:=Item.NotasFiscais.Items[0].NFe.Det.Items[1].Prod.xProd
                 else
                   result:='';
              end else if s = uppercase('[codigo3]') then begin
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=3 then
                   result:=Item.NotasFiscais.Items[0].NFe.Det.Items[2].Prod.cProd
                 else
                   result:='';
              end else if s = uppercase('[descricao3]') then begin
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=3 then
                   result:=Item.NotasFiscais.Items[0].NFe.Det.Items[2].Prod.xProd
                 else
                   result:='';
              end else if s = uppercase('[codigo4]') then begin
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=4 then
                   result:=Item.NotasFiscais.Items[0].NFe.Det.Items[3].Prod.cProd
                 else
                   result:='';
              end else if (pos('CODIGO',s) > 0)  then begin
                 if copy(s,09,1)=']' then i:=strtoint(copy(s,08,1))
                 else if copy(s,11,1)=']' then i:=strtoint(copy(s,08,3))
                 else i:=strtoint(copy(s,08,2));
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=i then
                   result:=Item.NotasFiscais.Items[0].NFe.Det.Items[i-1].Prod.cProd
                 else
                   result:='';

              end else if s = uppercase('[descricao4]') then begin
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=4 then
                   result:=Item.NotasFiscais.Items[0].NFe.Det.Items[3].Prod.xProd
                 else
                   result:='';
              end else if (pos('DESCRICAO',s) > 0)  then begin
                 if copy(s,12,1)=']' then i:=strtoint(copy(s,11,1))
                 else if copy(s,14,1)=']' then i:=strtoint(copy(s,11,3))
                 else i:=strtoint(copy(s,11,2));
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=i then
                   result:=Item.NotasFiscais.Items[0].NFe.Det.Items[i-1].Prod.xProd
                 else
                   result:='';
              end else if s = uppercase('[numerodoc]') then result:=inttostr(Item.NotasFiscais.Items[0].NFe.Ide.cnf)
              else if s = uppercase('[peso1]') then begin
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=1 then
                   result:=currtostr(Item.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.qCom)
                 else
                   result:='';
              end else if s = uppercase('[peso2]') then begin
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=2 then
                   result:=currtostr(Item.NotasFiscais.Items[0].NFe.Det.Items[1].Prod.qCom)
                 else
                   result:='';
              end else if s = uppercase('[peso3]') then begin
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=3 then
                   result:=currtostr(Item.NotasFiscais.Items[0].NFe.Det.Items[2].Prod.qCom)
                 else
                   result:='';
              end else if s = uppercase('[peso4]') then begin
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=4 then
                   result:=currtostr(Item.NotasFiscais.Items[0].NFe.Det.Items[3].Prod.qCom)
                 else
                   result:='';
              end else if s = uppercase('[peso5]') then begin
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=5 then
                   result:=currtostr(Item.NotasFiscais.Items[0].NFe.Det.Items[4].Prod.qCom)
                 else
                   result:='';
              end else if (pos('PESO',s) > 0) and ( copy(s,6,1)<>'T' ) then begin
                 if copy(s,7,1)=']' then i:=strtoint(copy(s,6,1))
                 else if copy(s,9,1)=']' then i:=strtoint(copy(s,6,3))
                 else i:=strtoint(copy(s,6,2));
                 if Item.NotasFiscais.Items[0].NFe.Det.Count>=i then
                   result:=currtostr(Item.NotasFiscais.Items[0].NFe.Det.Items[i-1].Prod.qCom)
                 else
                   result:='';
              end else if s = uppercase('[endereco]') then result:=(Item.NotasFiscais.Items[0].Nfe.Emit.EnderEmit.xLgr)
              else if s = uppercase('[nomecliente]') then result:=copy(Item.NotasFiscais.Items[0].Nfe.Emit.xNome,1,30)
              else if s = uppercase('[animaisgeral]') then result:=FormatFloat(',0', Item.NotasFiscais.Items[0].NFe.Det.Count)
              else if s = uppercase('[codbarra]') then result:=(Item.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.xPed)
              else if s = uppercase('[data]') then result:=FGeral.FormataData(Sistema.Hoje)
              else if s = uppercase('[desctotal1]') then result:=FEstoque.GetDescricao(Item.NotasFiscais.Items[0].NFe.pag.Items[0].cAut)
              else if s = uppercase('[pesototal1]') then result:=FormatFloat(',0##',Item.NotasFiscais.Items[0].NFe.pag.Items[0].vPag)
              else if s = uppercase('[desctotal2]') then begin
                 if Item.NotasFiscais.Items[0].NFe.Pag.Count>=2 then
                   result:=FEstoque.GetDescricao(Item.NotasFiscais.Items[0].NFe.pag.Items[1].cAut)
                 else
                   result:='';
              end else if (pos('DESCTOTAL',s) > 0)  then begin
                 if copy(s,12,1)=']' then i:=strtoint(copy(s,11,1)) else i:=strtoint(copy(s,11,2));
                 if Item.NotasFiscais.Items[0].NFe.Pag.Count>=i then
                   result:=FEstoque.GetDescricao(Item.NotasFiscais.Items[0].NFe.pag.Items[i-1].cAut)
                 else
                   result:='';
              end else if s = uppercase('[pesototal2]') then begin
                 if Item.NotasFiscais.Items[0].NFe.Pag.Count>=2 then
                   result:=FormatFloat(',0##',Item.NotasFiscais.Items[0].NFe.pag.Items[1].vPag)
                 else
                   result:='';
              end else if (pos('PESOTOTAL',s) > 0)  then begin
                 if copy(s,12,1)=']' then i:=strtoint(copy(s,11,1)) else i:=strtoint(copy(s,11,2));
                 if Item.NotasFiscais.Items[0].NFe.Pag.Count>=i then
                   result:=FormatFloat(',0##',Item.NotasFiscais.Items[0].NFe.pag.Items[i-1].vPag)
                 else
                   result:='';
              end else result:=s;
            end;

        begin
          ListaTroca:=TSTringlist.create;
          ListaTroca.Add( '[codigo4]' );
          ListaTroca.Add( '[descricao4]' );
          ListaTroca.Add( '[codigo1]' );
          ListaTroca.Add( '[descricao1]' );
          ListaTroca.Add( '[codigo2]' );
          ListaTroca.Add( '[descricao2]' );
          ListaTroca.Add( '[codigo3]' );
          ListaTroca.Add( '[descricao3]' );
          ListaTroca.Add( '[codigo5]' );
          ListaTroca.Add( '[descricao5]' );
          ListaTroca.Add( '[codigo6]' );
          ListaTroca.Add( '[descricao6]' );
          ListaTroca.Add( '[codigo7]' );
          ListaTroca.Add( '[descricao7]' );
          ListaTroca.Add( '[codigo8]' );
          ListaTroca.Add( '[descricao8]' );
          ListaTroca.Add( '[codigo9]' );
          ListaTroca.Add( '[descricao9]' );
          ListaTroca.Add( '[codigo10]' );
          ListaTroca.Add( '[descricao10]' );
          ListaTroca.Add( '[codigo11]' );
          ListaTroca.Add( '[descricao11]' );
          ListaTroca.Add( '[codigo12]' );
          ListaTroca.Add( '[descricao12]' );
          ListaTroca.Add( '[codigo13]' );
          ListaTroca.Add( '[descricao13]' );
          ListaTroca.Add( '[codigo14]' );
          ListaTroca.Add( '[descricao14]' );
          ListaTroca.Add( '[codigo15]' );
          ListaTroca.Add( '[descricao15]' );
          ListaTroca.Add( '[codigo16]' );
          ListaTroca.Add( '[descricao16]' );
          ListaTroca.Add( '[codigo17]' );
          ListaTroca.Add( '[descricao17]' );
          ListaTroca.Add( '[codigo18]' );
          ListaTroca.Add( '[descricao18]' );
          ListaTroca.Add( '[codigo19]' );
          ListaTroca.Add( '[descricao19]' );
          ListaTroca.Add( '[codigo20]' );
          ListaTroca.Add( '[descricao20]' );
          ListaTroca.Add( '[codigo21]' );
          ListaTroca.Add( '[descricao21]' );
          ListaTroca.Add( '[codigo22]' );
          ListaTroca.Add( '[descricao22]' );
          ListaTroca.Add( '[codigo23]' );
          ListaTroca.Add( '[descricao23]' );
          ListaTroca.Add( '[codigo24]' );
          ListaTroca.Add( '[descricao24]' );
          ListaTroca.Add( '[codigo25]' );
          ListaTroca.Add( '[descricao25]' );
          ListaTroca.Add( '[codigo26]' );
          ListaTroca.Add( '[descricao26]' );
          ListaTroca.Add( '[codigo27]' );
          ListaTroca.Add( '[descricao27]' );
          ListaTroca.Add( '[codigo28]' );
          ListaTroca.Add( '[descricao28]' );
          ListaTroca.Add( '[codigo29]' );
          ListaTroca.Add( '[descricao29]' );
          ListaTroca.Add( '[codigo30]' );
          ListaTroca.Add( '[descricao30]' );
          ListaTroca.Add( '[codigo31]' );
          ListaTroca.Add( '[descricao31]' );
          ListaTroca.Add( '[codigo32]' );
          ListaTroca.Add( '[descricao32]' );
          ListaTroca.Add( '[codigo33]' );
          ListaTroca.Add( '[descricao33]' );
          ListaTroca.Add( '[codigo34]' );
          ListaTroca.Add( '[descricao34]' );
          ListaTroca.Add( '[codigo35]' );
          ListaTroca.Add( '[descricao35]' );
          ListaTroca.Add( '[codigo36]' );
          ListaTroca.Add( '[descricao36]' );
          ListaTroca.Add( '[codigo37]' );
          ListaTroca.Add( '[descricao37]' );
          ListaTroca.Add( '[codigo38]' );
          ListaTroca.Add( '[descricao38]' );
          ListaTroca.Add( '[codigo39]' );
          ListaTroca.Add( '[descricao39]' );
          ListaTroca.Add( '[codigo40]' );
          ListaTroca.Add( '[descricao40]' );
          ListaTroca.Add( '[codigo41]' );
          ListaTroca.Add( '[descricao41]' );
          ListaTroca.Add( '[codigo42]' );
          ListaTroca.Add( '[descricao42]' );
          ListaTroca.Add( '[codigo43]' );
          ListaTroca.Add( '[descricao43]' );
          ListaTroca.Add( '[codigo44]' );
          ListaTroca.Add( '[descricao44]' );
          ListaTroca.Add( '[codigo45]' );
          ListaTroca.Add( '[descricao45]' );
          ListaTroca.Add( '[codigo46]' );
          ListaTroca.Add( '[descricao46]' );
          ListaTroca.Add( '[codigo47]' );
          ListaTroca.Add( '[descricao47]' );
          ListaTroca.Add( '[codigo48]' );
          ListaTroca.Add( '[descricao48]' );
          ListaTroca.Add( '[codigo49]' );
          ListaTroca.Add( '[descricao49]' );
          ListaTroca.Add( '[codigo50]' );
          ListaTroca.Add( '[descricao50]' );
          ListaTroca.Add( '[codigo51]' );
          ListaTroca.Add( '[descricao51]' );
          ListaTroca.Add( '[codigo52]' );
          ListaTroca.Add( '[descricao52]' );
          ListaTroca.Add( '[codigo53]' );
          ListaTroca.Add( '[descricao53]' );
          ListaTroca.Add( '[codigo54]' );
          ListaTroca.Add( '[descricao54]' );
          ListaTroca.Add( '[codigo55]' );
          ListaTroca.Add( '[descricao55]' );
          ListaTroca.Add( '[codigo56]' );
          ListaTroca.Add( '[descricao56]' );
          ListaTroca.Add( '[codigo57]' );
          ListaTroca.Add( '[descricao57]' );
          ListaTroca.Add( '[codigo58]' );
          ListaTroca.Add( '[descricao58]' );
          ListaTroca.Add( '[codigo59]' );
          ListaTroca.Add( '[descricao59]' );
          ListaTroca.Add( '[codigo60]' );
          ListaTroca.Add( '[descricao60]' );

          ListaTroca.Add( '[codigo61]' );
          ListaTroca.Add( '[descricao61]' );
          ListaTroca.Add( '[codigo62]' );
          ListaTroca.Add( '[descricao62]' );
          ListaTroca.Add( '[codigo63]' );
          ListaTroca.Add( '[descricao63]' );
          ListaTroca.Add( '[codigo64]' );
          ListaTroca.Add( '[descricao64]' );
          ListaTroca.Add( '[codigo65]' );
          ListaTroca.Add( '[descricao65]' );
          ListaTroca.Add( '[codigo66]' );
          ListaTroca.Add( '[descricao66]' );
          ListaTroca.Add( '[codigo67]' );
          ListaTroca.Add( '[descricao67]' );
          ListaTroca.Add( '[codigo68]' );
          ListaTroca.Add( '[descricao68]' );
          ListaTroca.Add( '[codigo69]' );
          ListaTroca.Add( '[descricao69]' );
          ListaTroca.Add( '[codigo70]' );
          ListaTroca.Add( '[descricao70]' );

          ListaTroca.Add( '[codigo71]' );
          ListaTroca.Add( '[descricao71]' );
          ListaTroca.Add( '[codigo72]' );
          ListaTroca.Add( '[descricao72]' );
          ListaTroca.Add( '[codigo73]' );
          ListaTroca.Add( '[descricao73]' );
          ListaTroca.Add( '[codigo74]' );
          ListaTroca.Add( '[descricao74]' );
          ListaTroca.Add( '[codigo75]' );
          ListaTroca.Add( '[descricao75]' );
          ListaTroca.Add( '[codigo76]' );
          ListaTroca.Add( '[descricao76]' );
          ListaTroca.Add( '[codigo77]' );
          ListaTroca.Add( '[descricao77]' );
          ListaTroca.Add( '[codigo78]' );
          ListaTroca.Add( '[descricao78]' );
          ListaTroca.Add( '[codigo79]' );
          ListaTroca.Add( '[descricao79]' );
          ListaTroca.Add( '[codigo80]' );
          ListaTroca.Add( '[descricao80]' );

          ListaTroca.Add( '[codigo81]' );
          ListaTroca.Add( '[descricao81]' );
          ListaTroca.Add( '[codigo82]' );
          ListaTroca.Add( '[descricao82]' );
          ListaTroca.Add( '[codigo83]' );
          ListaTroca.Add( '[descricao83]' );
          ListaTroca.Add( '[codigo84]' );
          ListaTroca.Add( '[descricao84]' );
          ListaTroca.Add( '[codigo85]' );
          ListaTroca.Add( '[descricao85]' );
          ListaTroca.Add( '[codigo86]' );
          ListaTroca.Add( '[descricao86]' );
          ListaTroca.Add( '[codigo87]' );
          ListaTroca.Add( '[descricao87]' );
          ListaTroca.Add( '[codigo88]' );
          ListaTroca.Add( '[descricao88]' );
          ListaTroca.Add( '[codigo89]' );
          ListaTroca.Add( '[descricao89]' );
          ListaTroca.Add( '[codigo90]' );
          ListaTroca.Add( '[descricao90]' );

          ListaTroca.Add( '[codigo91]' );
          ListaTroca.Add( '[descricao91]' );
          ListaTroca.Add( '[codigo92]' );
          ListaTroca.Add( '[descricao92]' );
          ListaTroca.Add( '[codigo93]' );
          ListaTroca.Add( '[descricao93]' );
          ListaTroca.Add( '[codigo94]' );
          ListaTroca.Add( '[descricao94]' );
          ListaTroca.Add( '[codigo95]' );
          ListaTroca.Add( '[descricao95]' );
          ListaTroca.Add( '[codigo96]' );
          ListaTroca.Add( '[descricao96]' );
          ListaTroca.Add( '[codigo97]' );
          ListaTroca.Add( '[descricao97]' );
          ListaTroca.Add( '[codigo98]' );
          ListaTroca.Add( '[descricao98]' );
          ListaTroca.Add( '[codigo99]' );
          ListaTroca.Add( '[descricao99]' );
          ListaTroca.Add( '[codigo100]' );
          ListaTroca.Add( '[descricao100]' );
          ListaTroca.Add( '[codigo101]' );
          ListaTroca.Add( '[descricao101]' );
          ListaTroca.Add( '[codigo102]' );
          ListaTroca.Add( '[descricao102]' );
          ListaTroca.Add( '[codigo103]' );
          ListaTroca.Add( '[descricao103]' );
          ListaTroca.Add( '[codigo104]' );
          ListaTroca.Add( '[descricao104]' );
          ListaTroca.Add( '[codigo105]' );
          ListaTroca.Add( '[descricao105]' );
          ListaTroca.Add( '[codigo106]' );
          ListaTroca.Add( '[descricao106]' );
          ListaTroca.Add( '[codigo107]' );
          ListaTroca.Add( '[descricao107]' );
          ListaTroca.Add( '[codigo108]' );
          ListaTroca.Add( '[descricao108]' );
          ListaTroca.Add( '[codigo109]' );
          ListaTroca.Add( '[descricao109]' );
          ListaTroca.Add( '[codigo110]' );
          ListaTroca.Add( '[descricao110]' );

          ListaTroca.Add( '[numerodoc]' );
          ListaTroca.Add( '[peso1]' );
          ListaTroca.Add( '[peso2]' );
          ListaTroca.Add( '[peso3]' );
          ListaTroca.Add( '[peso4]' );
          ListaTroca.Add( '[peso5]' );
          ListaTroca.Add( '[peso6]' );
          ListaTroca.Add( '[peso7]' );
          ListaTroca.Add( '[peso8]' );
          ListaTroca.Add( '[peso9]' );
          ListaTroca.Add( '[peso10]' );
          ListaTroca.Add( '[peso11]' );
          ListaTroca.Add( '[peso12]' );
          ListaTroca.Add( '[peso13]' );
          ListaTroca.Add( '[peso14]' );
          ListaTroca.Add( '[peso15]' );
          ListaTroca.Add( '[peso16]' );
          ListaTroca.Add( '[peso17]' );
          ListaTroca.Add( '[peso18]' );
          ListaTroca.Add( '[peso19]' );
          ListaTroca.Add( '[peso20]' );
          ListaTroca.Add( '[peso21]' );
          ListaTroca.Add( '[peso22]' );
          ListaTroca.Add( '[peso23]' );
          ListaTroca.Add( '[peso24]' );
          ListaTroca.Add( '[peso25]' );
          ListaTroca.Add( '[peso26]' );
          ListaTroca.Add( '[peso27]' );
          ListaTroca.Add( '[peso28]' );
          ListaTroca.Add( '[peso29]' );
          ListaTroca.Add( '[peso30]' );
          ListaTroca.Add( '[peso31]' );
          ListaTroca.Add( '[peso32]' );
          ListaTroca.Add( '[peso33]' );
          ListaTroca.Add( '[peso34]' );
          ListaTroca.Add( '[peso35]' );
          ListaTroca.Add( '[peso36]' );
          ListaTroca.Add( '[peso37]' );
          ListaTroca.Add( '[peso38]' );
          ListaTroca.Add( '[peso39]' );
          ListaTroca.Add( '[peso40]' );
          ListaTroca.Add( '[peso41]' );
          ListaTroca.Add( '[peso42]' );
          ListaTroca.Add( '[peso43]' );
          ListaTroca.Add( '[peso44]' );
          ListaTroca.Add( '[peso45]' );
          ListaTroca.Add( '[peso46]' );
          ListaTroca.Add( '[peso47]' );
          ListaTroca.Add( '[peso48]' );
          ListaTroca.Add( '[peso49]' );
          ListaTroca.Add( '[peso50]' );

          ListaTroca.Add( '[peso51]' );
          ListaTroca.Add( '[peso52]' );
          ListaTroca.Add( '[peso53]' );
          ListaTroca.Add( '[peso54]' );
          ListaTroca.Add( '[peso55]' );
          ListaTroca.Add( '[peso56]' );
          ListaTroca.Add( '[peso57]' );
          ListaTroca.Add( '[peso58]' );
          ListaTroca.Add( '[peso59]' );
          ListaTroca.Add( '[peso60]' );

          ListaTroca.Add( '[peso61]' );
          ListaTroca.Add( '[peso62]' );
          ListaTroca.Add( '[peso63]' );
          ListaTroca.Add( '[peso64]' );
          ListaTroca.Add( '[peso65]' );
          ListaTroca.Add( '[peso66]' );
          ListaTroca.Add( '[peso67]' );
          ListaTroca.Add( '[peso68]' );
          ListaTroca.Add( '[peso69]' );
          ListaTroca.Add( '[peso70]' );

          ListaTroca.Add( '[peso71]' );
          ListaTroca.Add( '[peso72]' );
          ListaTroca.Add( '[peso73]' );
          ListaTroca.Add( '[peso74]' );
          ListaTroca.Add( '[peso75]' );
          ListaTroca.Add( '[peso76]' );
          ListaTroca.Add( '[peso77]' );
          ListaTroca.Add( '[peso78]' );
          ListaTroca.Add( '[peso79]' );
          ListaTroca.Add( '[peso80]' );

          ListaTroca.Add( '[peso81]' );
          ListaTroca.Add( '[peso82]' );
          ListaTroca.Add( '[peso83]' );
          ListaTroca.Add( '[peso84]' );
          ListaTroca.Add( '[peso85]' );
          ListaTroca.Add( '[peso86]' );
          ListaTroca.Add( '[peso87]' );
          ListaTroca.Add( '[peso88]' );
          ListaTroca.Add( '[peso89]' );
          ListaTroca.Add( '[peso90]' );

          ListaTroca.Add( '[peso91]' );
          ListaTroca.Add( '[peso92]' );
          ListaTroca.Add( '[peso93]' );
          ListaTroca.Add( '[peso94]' );
          ListaTroca.Add( '[peso95]' );
          ListaTroca.Add( '[peso96]' );
          ListaTroca.Add( '[peso97]' );
          ListaTroca.Add( '[peso98]' );
          ListaTroca.Add( '[peso99]' );
          ListaTroca.Add( '[peso100]' );
          ListaTroca.Add( '[peso101]' );
          ListaTroca.Add( '[peso102]' );
          ListaTroca.Add( '[peso103]' );
          ListaTroca.Add( '[peso104]' );
          ListaTroca.Add( '[peso105]' );
          ListaTroca.Add( '[peso106]' );
          ListaTroca.Add( '[peso107]' );
          ListaTroca.Add( '[peso108]' );
          ListaTroca.Add( '[peso109]' );
          ListaTroca.Add( '[peso110]' );

          ListaTroca.Add( '[endereco]' );
          ListaTroca.Add( '[nomecliente]' );
          ListaTroca.Add( '[geralpeso]' );
          ListaTroca.Add( '[animaisgeral]' );
          ListaTroca.Add( '[codbarra]' );
          ListaTroca.Add( '[data]' );
          ListaTroca.Add( '[desctotal1]' );
          ListaTroca.Add( '[pesototal1]' );
          ListaTroca.Add( '[desctotal2]' );
          ListaTroca.Add( '[pesototal2]' );
          ListaTroca.Add( '[desctotal3]' );
          ListaTroca.Add( '[pesototal3]' );
          ListaTroca.Add( '[desctotal4]' );
          ListaTroca.Add( '[pesototal4]' );
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
      ListaCamara:=TList.create;

      AssignFile(arqlido,xarq);
      Reset( arqlido );

      i:=0;
      while not eof(arqlido) do begin
        Readln ( arqlido,linha );
        linhaw:=ColocaDados(linha);
        New(PCamara);
        Pcamara.linha:=linhaw;
        ListaCamara.Add(PCamara);
      end;
      CloseFile ( arqlido );

      {
// ler a partir do segundo item do romaneio
      for i:=1 to Item.NotasFiscais.Count-1 do begin
        linhaw:=ColocaDados(linha);
        New(PCamara);
        Pcamara.linha:=linhaw;
        ListaCamara.Add(PCamara);
      end;
}
      AssignFile(arqlista,'impromaentrada.prn');
      Rewrite( arqlista );
      for i:=0 to ListaCamara.Count-1 do begin
        PCamara:=ListaCamara[i];
//        if PCamara.linha='P1' then begin
//            Writeln(arqlista,copy(ultimalinha,1,19)+',"."');
//            Writeln(arqlista,copy(ultimalinha,1,05)+inttostr( strtoint(copy(ultimalinha,6,03))+100)+
 //                   copy(ultimalinha,09,11)+',"."');
//            Writeln(arqlista,PCamara.linha)
        if  ( copy(PCamara.linha,20,02)<> '""' ) and ( copy(PCamara.linha,21,02)<> '""' ) then  begin
            Writeln(arqlista,PCamara.linha);
            {
            if copy(PCamara.linha,5,1) =',' then begin
              if ultimalinha<>'' then begin
                if strtoint(copy(PCamara.linha,2,3)) > strtoint(copy(ultimalinha,2,3)) then
                  ultimalinha:=PCamara.linha;
              end else
                ultimalinha:=PCamara.linha;
            end;
            }
        end;
      end;


      CloseFile ( arqlista );


//      Aviso('vendo campos para troca '+xarq);

//      for p:=0 to ArqGravado.Lines.count-1 do begin
//         ArqGravado.Lines.Strings[p]:=( ColocaDados( ArqGravado.Lines.Strings[p] ) );
//      end;


{
      for p:=0 to Lista.count-1 do begin
         ListaImp.Add( ColocaDados( Lista[p] ) );
      end;
}
      ListaImp.Assign(Lista);
      Lista.free;

//      vtermica:=Acbrnfe1.DANFE.Impressora;
//      if FGeral.GetConfig1AsString('Microcamarafria' )='' then
//        vtermica:='lpt1'
//        vtermica:='\\localhost\d:\delphisac\programas\impressao.text'
//      else
        vtermica:='\\127.0.0.1\'+Acbrnfe1.DANFE.Impressora;
        if pos('\',Acbrnfe1.DANFE.Impressora)>0  then
          vtermica:='\\127.0.0.1'+Acbrnfe1.DANFE.Impressora;


//      comando:='command.com /c Type '+ExtractFilePath( Application.ExeName ) + xarq+' > '+vtermica;

      comando := 'Imp.bat' ;
// 18.08.17 - ver assim pra dai nao usar o winexec
//      if Global.Usuario.Codigo=100 then begin
        AssignFile ( arqimp, vtermica );
//        aviso( 'vtermica='+vtermica );
//      end else begin

        AssignFile ( arqimp, 'IMP.BAT' );
        Rewrite ( arqimp );

//      end;

//      Writeln ( arqimp, 'Type ' + xarq + ' > ' + vtermica );
//      Writeln ( arqimp, 'Type ' + arqlido + ' > ' + vtermica );

//      if Global.Usuario.Codigo=100 then begin
//        for i := 0 to ListaImp.count-1 do begin
//        Writeln ( arqimp, ListaImp[i] );
//          ListaImp.
//        end;
//
//      end else begin
        Writeln ( arqimp, 'Type impromaentrada.prn' +' > ' + vtermica );
        Writeln ( arqimp, 'Type impro.prn' +' > ' + vtermica );
//      end;

      CloseFile ( arqimp );
//      WinExec( PChar ( comando  ), SW_HIDE );
//      if global.Usuario.Codigo<>100 then
//        WinExec( PAnsiChar ( comando  ), SW_SHOWMINIMIZED )
//      else begin
//        aviso('vai executar o shellexecute');
        ShellExecute(handle,'open',PChar('imp.bat'),'',nil,sw_hide  );
//      end;

// 03.10.16
//      comando := 'ImpF.bat' ;
 //     AssignFile ( arqimp, 'IMPF.BAT' );
 //     Rewrite ( arqimp );
//      Writeln ( arqimp, 'Type ' + xarq + ' > ' + vtermica );
//      Writeln ( arqimp, 'Type ' + arqlido + ' > ' + vtermica );
//      Writeln ( arqimp, 'Type impro.prn' +' > ' + vtermica );
//      CloseFile ( arqimp );
//      WinExec( PChar ( comando  ), SW_SHOWMINIMIZED );

      ListaImp.Free;
    end;


//////////////////////////////////////////////////////
begin
////////////////////////////////////////////////////
    ACBrNFe1.NotasFiscais.Clear;
    Lista:=TList.create;
    totalpeso:=0;
    // 29.07.16
//    if codigocliente>0 then
//      Aviso('Codigo do Cliente : '+inttostr(codigocliente))
//    else
//      Aviso('codigo do cliente zerado');

    with  ACBrNFe1.NotasFiscais.Add.NFe do begin

      Q1:=sqltoquery('select * from movabatedet inner join movabate on ( movd_numerodoc=mova_numerodoc and mova_tipomov=movd_tipomov )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                     ' inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                     ' where movd_numerodoc = '+inttostr(xnumerodoc)+
                     ' and movd_tipomov='+stringtosql( TipoMov )+
                     ' and movd_unid_codigo='+stringtosql(xcodigounidade)+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
                     ' order by movd_ordem' );
      Total.ICMSTot.vBC   := Q1.fieldbyname('mova_pesovivo').ascurrency;
      Total.ICMSTot.vProd := Q1.fieldbyname('mova_pesovivo').ascurrency;
      Emit.xFant          := FCadcli.GetNome(codigocliente);
      Emit.xNome          := FCadcli.GetRazaoSocial(codigocliente);
///      Emit.CNPJCPF        := FCadcli.GetCnpjCpf(codigocliente);
      Emit.EnderEmit.xLgr := Q1.fieldbyname('clie_endres').asstring;
      Emit.EnderEmit.nro  := '';
      Emit.EnderEmit.xCpl := '';
      codmuniemitente:=FCidades.GetCodigoIBGE( FUnidades.GetCidaCodigo(Global.CodigoUnidade) );
      Ide.cUF             := strtoint(copy(codmuniemitente,1,2));
      Ide.cNF             := Q1.fieldbyname('movd_numerodoc').asinteger;
      Ide.dEmi            := Q1.fieldbyname('mova_dtabate').asdatetime;

      suinos:='N';
      while not Q1.eof do begin
          with  Det.Add do
          begin
            totalitem:=FGEral.Arredonda(Q1.fieldbyname('movd_pesocarcaca').ascurrency*(Q1.fieldbyname('movd_vlrarroba').asFLOAT/15),2);
            if tipomov=TipoFazenda then begin
              Prod.qCom    := trunc(Q1.fieldbyname('movd_pesovivo').asfloat);
              Prod.qTrib   := trunc(Q1.fieldbyname('movd_pesovivo').asfloat);
            end else begin
              Prod.qCom    := trunc(Q1.fieldbyname('movd_pesocarcaca').asfloat);
              Prod.qTrib   := trunc(Q1.fieldbyname('movd_pesocarcaca').asfloat);
            end;
            Prod.uCom    := Q1.fieldbyname('esto_unidade').asstring;
            Prod.uTrib   := Q1.fieldbyname('esto_unidade').asstring;
            Prod.vProd   := totalitem;
            Prod.vUnCom  := Q1.fieldbyname('movd_vlrarroba').asfloat;
            Prod.vUnTrib := Q1.fieldbyname('movd_vlrarroba').asfloat;
            Prod.xProd   := Q1.fieldbyname('esto_descricao').asstring;
            if tipomov=TipoFazenda then
              totalpeso:=totalpeso+Q1.fieldbyname('movd_pesovivo').asfloat
            else
              totalpeso:=totalpeso+Q1.fieldbyname('movd_pesocarcaca').asfloat;

//            Prod.cProd   := Q1.fieldbyname('movd_esto_codigo').asstring;
            Prod.cProd   := Q1.fieldbyname('movd_ordem').asstring;
          end;
          AtualizaLista;
          Q1.Next;
      end;
      FGeral.FechaQuery(Q1);
      Total.ICMSTot.vNF   := totalpeso;
      for i:=0 to Lista.count-1 do begin
        PProdutos:=Lista[i];
        with pag.Add do begin
          cAut:=PProdutos.codigo;
          vPag:=PProdutos.peso;
        end;
      end;
      Lista.free;
    end;  /// with acbr

//    AcbrNFe1.DANFE := TACBrNFeDANFCeFortesEA.Create(AcbrNFe1);
// 14.07.18
    AcbrNFe1.DANFE := TACBrNFeDANFCeFortesETQFAT.Create(AcbrNFe1);
    AcbrNfe1.DANFE.TipoDANFE := tiNFCE;
//  ACBrNFe1.DANFe.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];
//    acbrnfe1.danfe.ProdutosPorPagina:=50;
    if Global.usuario.outrosacessos[0510] then
      acbrnfe1.danfe.MostraPreview:=true
    else
      acbrnfe1.danfe.MostraPreview:=false;


    if FileExists( ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg' ) then
      acbrnfe1.danfe.Logo:=ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg';
    s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPROMENT');
    if trim(s)<>'' then Acbrnfe1.DANFE.Impressora:=s;
    Sistema.beginprocess('Imprimindo');
// 29.09.16
    if Global.Usuario.OutrosAcessos[0515] then begin
//      for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin

        if suinos<>'S' then
          arquivoetiq:='romaneioentradaabate.prn'
        else
          arquivoetiq:='romaneioentradaabatesuino.prn';
        if trim(arquivoetiq)<>'' then
            ImprimeEtiqueta( arquivoetiq,ACBrNFe1 )
         else
            aviso( 'n�o encontrado arquivo do codigo '+ACBrNFe1.NotasFiscais.Items[i].NFe.Det.Items[0].Prod.cProd );

         sleeP(100);  // senao da i/o error

//      end;
    end else
      ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[0].NFe );

    Sistema.endprocess('');
    ACBrNFe1.NOtasFiscais.clear;

//    }
end;

// 21.01.16
procedure TFPesagemEntrada.bimpetqClick(Sender: TObject);
///////////////////////////////////////////////////////////
begin

   EdSeqi.Visible:=true;
   EdSeqf.Visible:=true;
   EdSeqi.setfocus;


end;

procedure TFPesagemEntrada.EdSeqfValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
   if (EdSeqf.asinteger>0) and (EdSeqf.asinteger<EdSeqi.asinteger) then EdSeqf.invalid('Sequencial final tem que ser amior que inicial');
end;

/////////////////////////////////////////////////////////////
procedure TFPesagemEntrada.EdSeqfExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////
type TProdutos=record
     codigo:string;
     peso:currency;
end;

var totalpeso,totalitem,ypeso:currency;
    Q1,Q2,QNutri,Qconserva:TSqlquery;
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

// 16.07.18
    function GetPesoCarcaca( xt,xordem:string ):currency;
    ///////////////////////////////////////////////
    var Qt:TSqlquery;
    begin

       Qt:=sqltoquery('select movd_pesocarcaca from movabatedet where movd_transacao = '+stringtosql(xt)+
                      ' and movd_ordem = '+xordem+
                      ' and movd_tipomov='+stringtosql('EA') );
       if not Qt.Eof then result:=Qt.FieldByName('movd_pesocarcaca').AsCurrency else result:=0;
       fgeral.FechaQuery(Qt);

    end;

begin
//////////////////////////////////
    EdSeqi.visible:=false;
    EdSeqf.visible:=false;
    EdNumerodoc.setfocus;

    if Global.Usuario.OutrosAcessos[0067] then begin
       ImprimeEtiquetasAdapar;
       exit;
    end;


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
{
    acbrnfe1.danfe.MargemEsquerda:=01;
    acbrnfe1.danfe.MargemDireita:=05;
    acbrnfe1.danfe.MargemSuperior:=5;
    acbrnfe1.danfe.MargemInferior:=5;
}
 // 14.07.18
    acbrnfe1.danfe.MargemEsquerda:=01;
    acbrnfe1.danfe.MargemDireita:=05;
    acbrnfe1.danfe.MargemSuperior:=18;
// 18.12.19  - etiqueta adapar
//    acbrnfe1.danfe.MargemSuperior:=1;
//    acbrnfe1.danfe.MargemInferior:=10;

    acbrnfe1.danfe.NumCopias:=1;

//    if FileExists( ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg' ) then
//      acbrnfe1.danfe.Logo:=ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg';
    s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPETQENT');
    if trim(s)<>'' then Acbrnfe1.DANFE.Impressora:=s;

      Q1:=sqltoquery('select * from movabatedet'+
                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                     ' inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                     ' where movd_numerodoc = '+EdNumerodoc.assql+
//                     ' and movd_tipomov='+stringtosql('EA')+
                     ' and movd_tipomov='+stringtosql('PC')+
//                     ' and movd_transacao = mova_transacao'+
// 17.11.17
                     ' and mova_tipomov='+stringtosql('EA')+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     sqlordem+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
//                     ' order by movd_ordem' );
// 23.11.18
                     ' order by movd_ordem,movd_baia' );

    if Q1.eof then aviso('N�o encontrada a etiqueta gerada');

//  aqui ver buscar o peso da carca�a e ver em qual variavel jogar no acbrnfe para ser
//  impresso
// 16.07.18
//    ypeso:=GetPesoCarcaca( Q1.FieldByName('movd_transacao').AsString,Q1.FieldByName('movd_ordem').AsString );

    Sistema.BeginProcess('Enviando para impressora '+Acbrnfe1.DANFE.Impressora);

    while not Q1.eof do begin


    ypeso:=GetPesoCarcaca( Q1.FieldByName('movd_transacao').AsString,Q1.FieldByName('movd_ordem').AsString );
    ypeso:=ypeso/2;

      with  ACBrNFe1.NotasFiscais.Add.NFe do begin

        Total.ICMSTot.vBC   := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Total.ICMSTot.vProd := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Emit.xFant          := FCadcli.GetNome(codigocliente);
        Emit.xNome          := FCadcli.GetRazaoSocial(codigocliente);
//        Emit.CNPJCPF        := FCadcli.GetCnpjCpf(codigocliente);
        Emit.EnderEmit.xLgr := FCadcli.GetEndereco(codigocliente);
        Emit.EnderEmit.nro  := '';
        Emit.EnderEmit.xCpl := '';
// 16.07.18
        Ide.modelo          := trunc(ypeso);
        codmuniemitente     := FCidades.GetCodigoIBGE( FUnidades.GetCidaCodigo(Global.CodigoUnidade) );
        Ide.cUF             := strtoint(copy(codmuniemitente,1,2));
        Ide.cNF             := Q1.fieldbyname('movd_numerodoc').asinteger;
//        Ide.dEmi            := Q1.fieldbyname('mova_dtabate').asdatetime;
        Ide.dEmi            := Sistema.hoje;
// 18.12.19
        infNFeSupl.qrCode   := 'Lote '+strzero(Q1.fieldbyname('movd_numerodoc').asinteger,7)+
                               ' Data '+FormatDatetime('dd/mm/yyyy',sistema.Hoje)+
                               ' '+FCadcli.GetRazaoSocial(codigocliente)+
                               ' '+Q1.fieldbyname('esto_descricao').asstring  ;

        Lista:=TList.create;
// 17.09.18 - busca o codigo do 'produto carca�a'
        Q2:=sqltoquery('select movd_esto_codigo from movabatedet'+
                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                     ' inner join clientes on ( clie_codigo=mova_tipo_codigo )'+
                     ' where movd_numerodoc = '+EdNumerodoc.assql+
                     ' and movd_tipomov='+stringtosql('EA')+
                     ' and mova_tipomov='+stringtosql('EA')+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     ' and movd_transacao = '+Stringtosql(Q1.FieldByName('movd_transacao').AsString)+
                     ' and movd_ordem = '+inttostr(Q1.FieldByName('movd_ordem').AsInteger)+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
                     ' order by movd_ordem' );


          with  Det.Add do
          begin

            totalitem:=FGEral.Arredonda(Q1.fieldbyname('movd_pesocarcaca').ascurrency*(Q1.fieldbyname('movd_vlrarroba').asFLOAT/15),2);
// 06.11.17 - checa se o peso da meia carca�a est� correto senao regrava...'misterios da balan�a'..
//            Prod.vSeg    :=  trunc(Q2.fieldbyname('movd_pesocarcaca').asfloat);
//            if ( Q2.fieldbyname('movd_pesocarcaca').asfloat - Q1.fieldbyname('movd_pesocarcaca').asfloat ) <= 3 then begin
// 15.04.18 - deixado sempre regravar o peso devido a 'problemas da balan�a'
// 23.05.18 - retirado pois creio q 'achamos' q era pq na alteracao para informar o peso vivo
//            para fazer o acerto com o produtor regravar 'por cima' os pesos pesados....
{
              Sistema.Edit('movabatedet');
              Sistema.SetField('movd_pesocarcaca',Q2.fieldbyname('movd_pesocarcaca').asfloat/2);
              Sistema.Post('movd_operacao='+stringtosql(Q1.FieldByName('movd_operacao').AsString));
              Sistema.Commit;
}
//            end;

            Prod.qCom    := trunc(Q1.fieldbyname('movd_pesocarcaca').asfloat);
            Prod.qTrib   := trunc(Q1.fieldbyname('movd_pesocarcaca').asfloat);
            Prod.uCom    := Q1.fieldbyname('esto_unidade').asstring;
            Prod.uTrib   := Q1.fieldbyname('esto_unidade').asstring;
            Prod.vProd   := totalitem;
            Prod.vUnCom  := Q1.fieldbyname('movd_vlrarroba').asfloat;
            Prod.vUnTrib := Q1.fieldbyname('movd_vlrarroba').asfloat;
            Prod.xProd   := Q1.fieldbyname('esto_descricao').asstring;
// 17.09.18 - para identificar as classifacacoes 'piores'
            if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'102;103;104') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' HOL'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'446;48;369') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' CIS'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'453;345;393') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' BAT'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'071;196;167') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' SC'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'106;084;045') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' SC1'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'108;024;062') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' SC2'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'075') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' HSC'
            else if AnsiPos(strzero(strtoint(Q2.fieldbyname('movd_esto_codigo').asstring),3),'442') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' SCB' ;


            totalpeso:=totalpeso+Q1.fieldbyname('movd_pesocarcaca').asfloat;
            Prod.cProd   := Q1.fieldbyname('movd_esto_codigo').asstring;
//            Prod.cProd   := Q1.fieldbyname('movd_ordem').asstring;
            Prod.xPed    := Q1.fieldbyname('movd_operacao').asstring;

// 14.07.18 - nova forma de emitir etiquetas no abate
            if Q1.FieldByName('esto_validade').AsInteger >0 then
              Prod.NCM:=inttostr( Q1.FieldByName('esto_validade').AsInteger )
            else
              Prod.NCM:='';
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
              Prod.vUnCom:=QNutri.FieldByName('Nutr_gordsaturadas').AsCurrency;

              if QNutri.FieldByName('nutr_validade').AsInteger >0 then
                Prod.NCM:=inttostr( QNutri.FieldByName('nutr_validade').AsInteger )
              else
                Prod.NCM:='';
            end;
            QNutri.Close;
            QConserva:=sqltoquery('select * from conservacao where cons_codigo='+inttostr(Q1.FieldByName('esto_cons_codigo').AsInteger));
            if not Qconserva.Eof then begin
              Prod.uCom:=QConserva.FieldByName('cons_linha1').AsString;
            end;
            Qconserva.Close;

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

 //         ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[0].NFe );
 //         ACBrNFe1.NOtasFiscais.clear;

          Q1.Next;

      end; /// with acbr

    end;  /// Q1.eof
    FGeral.FechaQuery(Q1);
    Lista.Free;

// 30.06.16
    if Global.usuario.outrosacessos[0510] then

      acbrnfe1.danfe.MostraPreview:=true

    else

      acbrnfe1.danfe.MostraPreview:=false;
    Sistema.EndProcess('');

      for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin

        if Global.Usuario.OutrosAcessos[0514] then begin

          arquivoetiq:='etqentradaabate.prn';
          x:=i;
          if trim(arquivoetiq)<>'' then
            ImprimeEtiqueta( arquivoetiq,ACBrNFe1.NotasFiscais.Items[i].NFe )
          else
            aviso( 'n�o encontrado arquivo do codigo '+ACBrNFe1.NotasFiscais.Items[i].NFe.Det.Items[0].Prod.cProd );

        end else

          ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

      end;

      ACBrNFe1.NOtasFiscais.clear;

end;

end.
