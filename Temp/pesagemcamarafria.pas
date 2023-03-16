// 07.06.16
// Pesagem dentro da camara fria para 'dar saida do produto q entra e entrada do produto que sai'
/////////////////////////////////////////////////////////////////////////////////////////////////////

unit pesagemcamarafria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrDFe, ACBrNFe, ACBrETQ, ACBrBase, ACBrBAL, ExtCtrls, Grids,
  SqlDtg, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, SQLGrid, AcbrDevice,
  Math, ACBrDANFCeFortesFrEA,ACBrDANFCeFortesFrETQEA, pcnconversao,SqlExpr,
  Vcl.FileCtrl;

type
  TFPesagemCamaraFria = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    blebalanca: TSQLBtn;
    bretnropedido: TSQLBtn;
    bromaneio: TSQLBtn;
    bimpetq: TSQLBtn;
    EdSeqi: TSQLEd;
    EdSeqf: TSQLEd;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    EdNumeroDOC: TSQLEd;
    pnomecliente: TSQLPanelGrid;
    PIns: TSQLPanelGrid;
    Label3: TLabel;
    Label7: TLabel;
    EdPeso: TSQLEd;
    PPeso: TSQLPanelGrid;
    pNomeProduto: TSQLPanelGrid;
    EdProduto: TSQLEd;
    PPedidos: TSQLPanelGrid;
    GridPedido: TSqlDtGrid;
    PTotais: TSQLPanelGrid;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ppesobalanca: TLabel;
    ptara: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    PTotalPesado: TSQLPanelGrid;
    panimaispesados: TSQLPanelGrid;
 //   AcbrBal1: TACBrBAL;
 //   ACBrETQ1: TACBrETQ;
 //   ACBrNFe1: TACBrNFe;
    PCortes: TSQLPanelGrid;
    GridCortes: TSqlDtGrid;
    bgrava: TSQLBtn;
    Label2: TLabel;
    ACBrBAL1: TACBrBAL;
    ACBrNFe1: TACBrNFe;
    ACBrETQ1: TACBrETQ;
    Diretorio: TFileListBox;
    procedure EdNumeroDOCKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure blebalancaClick(Sender: TObject);
    procedure bimpetqClick(Sender: TObject);
    procedure bretnropedidoClick(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure bromaneioClick(Sender: TObject);
    procedure EdNumeroDOCValidate(Sender: TObject);
    procedure EdNumeroDOCKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdProdutoChange(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure bgravaClick(Sender: TObject);
    procedure EdPesoValidate(Sender: TObject);
    procedure EdSeqfValidate(Sender: TObject);
    procedure EdSeqfExitEdit(Sender: TObject);
    procedure EdTiposdeCorteValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConfiguraTeclas( Key: Word );
    Procedure Execute;
    Procedure ZeraCampos;
    procedure ConfiguraBalancas;
    function  AbrirPorta(qbalanca:string):boolean;
    procedure AtualizaValores;
    function arred( v:currency ):currency;
    procedure GravaPeso;
//    procedure GravaItem(op:string;Q:Tsqlquery);
    procedure GravaItem(op:string;linha:integer);
    procedure EditstoGridCorte(xseq:integer=0);
    function ProcuraGrid(Coluna: integer;  Pesquisa: string ; Colunatam:integer=0 ; tam:integer=0 ; colunacor:integer=0 ; cor:integer=0 ;
                         colunacopa:integer=0 ; copa:integer=0 ): integer;
  end;

var
  FPesagemCamaraFria: TFPesagemCamaraFria;
  Sqltipomova,sqltipomovd,Unidade,Transacao,TipoMov,TipoEntradaAbate,codigoasercortado,
  sexo:string;
  DataPedido:TDatetime;
  Tara,pesoorigem:Currency;
  QPedido,QSaida:TSqlquery;
  Seq,CodigoCliente,NumeroDoc,codigoasercortadocor:integer;
  Temgrid:boolean;

implementation

uses Geral, Estoque,PcnNfe, SqlFun, SqlSis, cadcli, custos, munic,
  Unidades, cadcor, StrUtils, ShellApi;

{$R *.dfm}

procedure TFPesagemCamaraFria.ConfiguraBalancas;
//////////////////////////////////////////

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

procedure TFPesagemCamaraFria.ConfiguraTeclas(Key: Word);
//////////////////////////////////////////////////////
begin
 if key = vk_f4 then blebalancaClick(self)
 else if key = vk_f5 then bimpetqClick(self)
 else if key = vk_f3 then bretnropedidoClick(self)
 else if key = vk_f6 then bSairClick(self)
 else if key = vk_f2 then bgravaClick(self)
 else if key = vk_f11 then bromaneioClick(self)
////// else if key = vk_f2 then bexcluipesagemClick(self);

end;

procedure TFPesagemCamaraFria.EdNumeroDOCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);

end;

procedure TFPesagemCamaraFria.Execute;
////////////////////////////////
begin

   EdNumerodoc.ClearAll(FPesagemCamaraFria,99);
   codigoasercortado:='';
   codigoasercortadocor:=0;
   pesoorigem:=0;
   GridPedido.clear;
   GridCortes.clear;
   ZeraCampos;
   ConfiguraBalancas;
   TipoEntradaAbate:='PC';
   Tipomov:=TipoEntradaAbate;
   if not Global.Usuario.OutrosAcessos[0040] then
     abrirporta( 'BAL1' );

   Unidade:=Global.CodigoUnidade;
   if FGeral.Getconfig1asinteger('DIASPEDIDO')>0 then
     DataPedido:=Sistema.hoje-FGeral.Getconfig1asinteger('DIASPEDIDO')
   else
     DataPedido:=Sistema.Hoje-60;
   FPesagemCamaraFria.WindowState:=wsMaximized;
   FGeral.ConfiguraColorEditsNaoEnabled(FPesagemCamarafria);
//////////////   FPesagemCamaraFria.SetaEditEntradasAbate(FPesagemCamarafria.EdNUmerodoc);
// ver se vai ter consulta com f12
//   SetaItemsEstoque;
   EdSeqi.Visible:=false;
   EdSeqf.Visible:=false;
   Show;
   EdNumeroDoc.setfocus;
   sexo:='Q';
end;

procedure TFPesagemCamaraFria.ZeraCampos;
//////////////////////////////////
begin
   PTotalPesado.caption:='';
   PTara.caption:='';
   tara:=0;
   EdProduto.text:='';
   EdPeso.text:='';
   Ppeso.caption:='';
   pnomeproduto.caption:='';

end;

procedure TFPesagemCamaraFria.blebalancaClick(Sender: TObject);
begin
   if EdNumerodoc.asinteger=0 then begin
     EdNumerodoc.invalid('Número do pedido está zerado');
     exit;
   end;
    
   if Qpedido.fieldbyname('movd_pesobalanca').ascurrency>= Qpedido.fieldbyname('movd_pesocarcaca').ascurrency then begin
     aviso('Etiqueta JÁ PESADA');
     exit;
   end;

//   if trim(GridPedido.cells[0,1])='' then begin
//     Avisoerro('Sem itens no pedido');
//     exit;
 //  end;
   EdProduto.setfocus;

end;

procedure TFPesagemCamaraFria.bimpetqClick(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
   EdSeqi.Visible:=true;
   EdSeqf.Visible:=true;
   EdSeqi.setfocus;

end;

procedure TFPesagemCamaraFria.bretnropedidoClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin
////////////////////////////   FPesagemCamaraFria.SetaEditEntradasAbate(FPesagemCamaraFria.EdNUmerodoc);
   EdNumerodoc.setfocus;

end;

procedure TFPesagemCamaraFria.bSairClick(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
  if AcbrBal1.Ativo then AcbrBal1.Desativar;
  close;
  if Global.Usuario.OutrosAcessos[0054] then Application.Terminate;

end;

procedure TFPesagemCamaraFria.bromaneioClick(Sender: TObject);
begin

/////////////////////////    ImprimeRomaneio(EdNumerodoc.asinteger,Global.CodigoUnidade);

end;

function TFPesagemCamaraFria.AbrirPorta(qbalanca: string): boolean;
////////////////////////////////////////////////////////////////////
begin
// por enquanto sem usar balança só pra fazer etiqueta
///////////////////////////////////////////////////////////////
  exit;
  
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

procedure TFPesagemCamaraFria.EdNumeroDOCValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////////////
var sqlaberto,sqlwhere,sqldata,sqlunidades,sqlwhered,ccorte:string;
    x:integer;
    QC,QP:Tsqlquery;
    ListaCores,ListaC:Tstringlist;

   procedure  SetaItemsEstoque;
   //////////////////////////////
   var Lista:TStringlist;
       s:string;
       p:integer;
   begin
     FPesagemCamaraFria.EdProduto.Items.clear;
     Lista:=TStringlist.create;
     s:=FComposicao.GetCodigosMat(codigoasercortado);
     if (trim(s)<>'') and (Tipomov=TipoEntradaAbate) then begin
       FPesagemCamaraFria.EdProduto.ShowForm:='';
       strtolista(Lista,s,';',true);
       for p:=0 to Lista.count-1 do begin
          if trim(Lista[p])<>'' then
            FPesagemCamaraFria.EdProduto.Items.add(strspace(Lista[p],15)+' - '+FEstoque.getdescricao(Lista[p]));
       end;
       FPesagemCamaraFria.EdProduto.ItemsLength:=15;
     end else begin
       FPesagemCamaraFria.EdProduto.ShowForm:='FEstoque';
       FPesagemCamaraFria.EdProduto.ItemsLength:=0;
     end;
   end;

   procedure GeraeGravaPesos;
   ///////////////////////////
   var sqlcor:string;
       Q,QE:TSqlquery;
       peso,somapesos:currency;
       grava:boolean;
       p:integer;
   begin
     Numerodoc:=FGeral.GetContador('CORTES'+Global.CodigoUnidade,false,true);
     Transacao:=Global.CodigoUnidade+strzero(numerodoc,6);
     sqlcor:='';
     codigoasercortadocor:=strtointdef(ccorte,0);
     if codigoasercortadocor>0 then sqlcor:=' and cust_core_codigo = '+inttostr(codigoasercortadocor);
     Q:=sqltoquery('select * from custos where cust_status = ''N'''+
                   ' and cust_esto_codigo = '+stringtosql(codigoasercortado)+
                   sqlcor+
                   ' and cust_tipo = ''E''');
     p:=1;somapesos:=0;
     grava:=false;
     while not Q.eof do begin
         if Q.fieldbyname('cust_perqtde').ascurrency>0 then begin
             peso:=arred(PesoOrigem*(Q.fieldbyname('cust_perqtde').ascurrency/100));
             somapesos:=somapesos+peso;
             QE:=Sqltoquery('select * from estoqueqtde where esqt_unid_codigo = '+Stringtosql(Unidade)+
                           ' and esqt_esto_codigo = '+Stringtosql(Q.fieldbyname('cust_esto_codigomat').AsString)+
                           ' and esqt_status = ''N''');
              grava:=true;
              Sistema.Insert('movabatedet');
              Sistema.SetField('movd_esto_codigo',(Q.fieldbyname('cust_esto_codigomat').AsString));
              Sistema.SetField('movd_transacao',transacao);
              Sistema.SetField('movd_operacao',transacao+inttostr(p));
              inc(p);
              Sistema.SetField('movd_numerodoc',numerodoc);
              Sistema.SetField('movd_status','N');
              Sistema.SetField('movd_tipomov',TipoMov);
              Sistema.SetField('movd_unid_codigo',Unidade);
              Sistema.SetField('movd_tipo_codigo',codigocliente);
      //        Sistema.SetField('movd_tipocad','C');
      //        Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),linha]);
      //        Sistema.SetField('movd_idade',Grid.cells[Grid.getcolumn('movd_idade'),linha]);
      //        Sistema.SetField('movd_pesovivo',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesovivo'),linha]));
              Sistema.SetField('movd_pesocarcaca',peso);
      //        Sistema.SetField('movd_vlrarroba',FGrupos.GetValorArroba( FEstoque.GetGrupo(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]),Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha]) ) );
      //        vlrarroba:=FGrupos.GetValorArroba( FEstoque.GetGrupo(EdProduto.text),Texttovalor(GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),linha]),EdProduto.text ) ;
      //        Sistema.SetField('movd_vlrarroba',vlrarroba  );
      //        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
              Sistema.SetField('movd_ordem',p);
              Sistema.SetField('movd_pecas',1);
              Sistema.Post('');
      // 09.06.16 - entra no estoque do corte informado e gera movimento do codigo dele
      //          - baixa do estoque da etiqueta lida
      //          - gera etiqueta do corte informado
      ///////////////////////////////////////////////////////////////////////////////////////////////
              FGeral.MovimentaQtdeEstoque( Q.fieldbyname('cust_esto_codigomat').AsString ,Unidade,'S',TipoMov,peso,Qe,0,2);
              QE.close;
         end;
         Q.Next;
     end;
         if grava then begin
            Sistema.Insert('movabate');
            Sistema.SetField('mova_transacao',transacao);
            Sistema.SetField('mova_operacao',transacao+'01');
            Sistema.SetField('mova_numerodoc',Numerodoc);
            Sistema.SetField('mova_status','N');
            Sistema.SetField('mova_tipomov',TipoMov);
            Sistema.SetField('mova_unid_codigo',Global.CodigoUnidade);
            Sistema.SetField('mova_datalcto',Sistema.Hoje);
            Sistema.SetField('mova_dtcarrega',Sistema.Hoje);
            Sistema.SetField('mova_dtabate',Sistema.hoje);
            Sistema.SetField('mova_dtvenci',Sistema.hoje);
            Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
      //      mova_notagerada numeric(8,0),
            Sistema.SetField('mova_transacaogerada',Ednumerodoc.text);
            Sistema.SetField('mova_tipo_codigo',codigocliente);
      //      mova_pesovivo numeric(12,3),
            Sistema.SetField('mova_pesocarcaca',somapesos);
            Sistema.SetField('mova_datacont',Sistema.Hoje);
      //      mova_perc numeric(12,5),
            Sistema.SetField('mova_situacao','P');
      //      mova_tran_codigo character varying(3),
      //      mova_fpgt_codigo character varying(3),
      //      mova_repr_codigo numeric(4,0),
      //      mova_vlrtotal numeric(12,3),
      //      mova_perccomissao numeric(8,3),
      //      mova_vlrgta numeric(12,3)
            Sistema.Post();
            try
               Sistema.commit;
               Aviso('Pesos gravados');
               EdSeqf.OnExitEdit(self);
               Zeracampos;
               Ednumerodoc.setfocus;
            except
               Avisoerro('Pesos NÃO GRAVADOS');
            end;
         end;
////////////////////////////////////////////
     Fgeral.FechaQuery(Q);
   end;


//////////////////////////////////////////
begin
///////////////////////////////////////////
//   sqlaberto:=' and '+Fgeral.getin('mova_situacao','P','C');
//   sqlaberto:=' and '+Fgeral.getin('mova_situacao','N','C');
// 10.11.16 - para achar os da entrada de abate e do propria camara fria
   sqlaberto:=' and '+Fgeral.getin('mova_situacao','N;P','C');
   sqlwhere:=' where '+FGEral.getin('mova_status','N;','C')+' and mova_operacao='+EdNumerodOC.AsSql;
   sqlwhered:=' where '+FGEral.getin('movd_status','N;','C')+' and movd_operacao='+EdNumerodOC.AsSql;
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

   codigocliente:=0;
   if not QPedido.eof then
      CodigoCliente:=QPedido.fieldbyname('mova_tipo_codigo').asinteger;

   GridPedido.clear;
   Ppeso.caption:='';
   x:=1;
   if QPedido.eof then begin
     aviso('Etiqueta não encontrada');
     exit;
   end;
   if Qpedido.fieldbyname('movd_pesobalanca').ascurrency>= Qpedido.fieldbyname('movd_pesocarcaca').ascurrency then begin
     aviso('Etiqueta JÁ PESADA');
     exit;
   end;
   if QPedido.FieldByName('esto_categoria').AsString='MA' then sexo:='M'
   else if QPedido.FieldByName('esto_categoria').AsString='FE' then sexo:='F'
   else sexo:='Q';


   Numerodoc:=FGeral.GetContador('CORTES'+Global.CodigoUnidade,false,false);
   codigoasercortado:='';
   while (not QPedido.eof) do begin
         GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),x]:=QPedido.fieldbyname('movd_esto_codigo').asstring;
         GridPedido.cells[GridPedido.getcolumn('esto_descricao'),x]:=QPedido.fieldbyname('esto_descricao').asstring;
         GridPedido.cells[GridPedido.getcolumn('movd_seq'),x]:=strzero(QPedido.fieldbyname('movd_ordem').asinteger,3);
//         GridPedido.cells[GridPedido.getcolumn('mpdd_pecas'),x]:=QPedido.fieldbyname('mpdd_pecas').asstring;
//         GridPedido.cells[GridPedido.getcolumn('mpdd_venda'),x]:=QPedido.fieldbyname('mpdd_venda').asstring;
         GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),x]:=Formatfloat(f_cr3,QPedido.fieldbyname('movd_pesocarcaca').ascurrency);
         if trim(codigoasercortado)='' then begin
           codigoasercortado:=QPedido.fieldbyname('movd_esto_codigo').asstring;
           pesoorigem:=QPedido.fieldbyname('movd_pesocarcaca').ascurrency;
         end;
         inc(x);
         GridPedido.AppendRow;
     QPedido.next;
   end;
   QPedido.First;
   PNomecliente.caption:=FCadcli.GetNome(codigocliente);
// mostra grid de cortes
///////////////////////////////
   QC:=sqltoquery('select esto_descricao,movd_esto_codigo,movd_ordem,movd_pesocarcaca from movabatedet'+
                  ' inner join movabate on (mova_transacao=movd_transacao and mova_tipomov=movd_tipomov)'+
                  ' inner join estoque on ( movd_esto_codigo=esto_codigo )'+
                  ' where movd_tipomov = '+Stringtosql(tipomov)+
                  ' and movd_status = ''N'''+
                  ' and mova_transacaogerada = '+EdNumerodoc.assql+
                  ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade));
   GridCortes.Clear;
   ListaCores:=Tstringlist.create;
   ListaC:=Tstringlist.create;
   if Qc.eof then begin
//     ver se tem mais de uma composicao dai pedir qual vai usar
     QP:=sqltoquery('select cust_core_codigo from custos where cust_status = ''N'''+
                   ' and cust_esto_codigo = '+stringtosql(codigoasercortado)+
                   ' and cust_tipo = ''E'' order by cust_core_codigo');
     while not Qp.Eof do begin
       if (Qp.FieldByName('cust_core_codigo').AsInteger>0) and (ListaCores.indexof(Qp.FieldByName('cust_core_codigo').AsString)=-1) then begin
         ListaCores.add(Qp.FieldByName('cust_core_codigo').Asstring);
         ListaC.add(strzero(Qp.FieldByName('cust_core_codigo').AsInteger,3) + ' - '+FCores.GetDescricao(Qp.FieldByName('cust_core_codigo').Asinteger));
       end;
       QP.Next;
     end;
     QP.close;
     if ListaCores.Count>0 then begin
//       EdTiposdeCorte.enabled:=true;
//       EdTiposdeCorte.Items.Assign(ListaC);
//       EdTiposdeCorte.setfocus;
       ccorte:=copy( SelecionaItems(ListaC,'Escolha TIPO DE CORTE','',false,3) ,1,3 );
       if trim(ccorte)='' then exit;
//       strtolista(Lista,ctransacoes,'|',true);

     end;

     GeraeGravaPesos;
     FGeral.FechaQuery(QC);
     QC:=sqltoquery('select esto_descricao,movd_esto_codigo,movd_ordem,movd_pesocarcaca from movabatedet'+
                  ' inner join movabate on (mova_transacao=movd_transacao and mova_tipomov=movd_tipomov)'+
                  ' inner join estoque on ( movd_esto_codigo=esto_codigo )'+
                  ' where movd_tipomov = '+Stringtosql(tipomov)+
                  ' and movd_status = ''N'''+
                  ' and mova_transacaogerada = '+EdNumerodoc.assql+
                  ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade));
   end;
   x:=1;
   while not Qc.eof do begin
     GridCortes.cells[GridCortes.getcolumn('mpdd_esto_codigo'),x]:=Qc.fieldbyname('movd_esto_codigo').asstring;
     GridCortes.cells[GridCortes.getcolumn('esto_descricao'),x]:=Qc.fieldbyname('esto_descricao').asstring;
     GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),x]:=FGeral.formatavalor( Qc.fieldbyname('movd_pesocarcaca').ascurrency,f_cr) ;
     GridCortes.cells[GridCortes.getcolumn('movd_seq'),x]:=strzero(Qc.fieldbyname('movd_ordem').asinteger,3);
     inc(x);
     GridCortes.AppendRow;
     QC.Next;
   end;
   FGeral.FechaQuery(QC);
   SetaItemsEstoque;
   AtualizaValores;
///////////////////   GridPedido.setfocus;

end;

procedure TFPesagemCamaraFria.AtualizaValores;
///////////////////////////////////////////////////////////
var p,r,animais:integer;
    valortotal,pesototal:currency;
    produto:string;
begin
  valortotal:=0;pesototal:=0;animais:=0;
  for r:=1 to GridCortes.RowCount do begin
     if Texttovalor(GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),r])>0 then begin
       produto:=GridCortes.cells[GridCortes.getcolumn('mpdd_esto_codigo'),r];
       pesototal:=pesototal+Texttovalor(GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),r]);
//       valor:=qtde*unitario;
//       valortotal:=valortotal+valor;
//       GridCortes.cells[GridCortes.Getcolumn('movd_pesocarcaca'),r]:=FormatFloat(f_cr3,qtde);
//       GridCortes.cells[GridCortes.Getcolumn('total'),r]:=FormatFloat(f_cr,valor)
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

function TFPesagemCamaraFria.arred(v: currency): currency;
/////////////////////////////////////////////////////////////
var y:currency;
begin
  y:=v-int(v);
  if y >=0.6 then  y:=0.5
  else if y<=0.49 then y:=0;
  result:=int(v) + y;
end;

procedure TFPesagemCamaraFria.EdNumeroDOCKeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
///////////////////////////////////////////////////////////////////////////////////////////////////////////
begin
   ConfiguraTeclas( key );
end;

procedure TFPesagemCamaraFria.EdProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   ConfiguraTeclas(key);

end;

procedure TFPesagemCamaraFria.EdProdutoChange(Sender: TObject);
begin

end;

// 09.06.16
procedure TFPesagemCamaraFria.EdProdutoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var Qe:TSqlquery;
    peso:currency;
begin
   if trim(EdProduto.text)<>'' then begin
     Edproduto.text:=trim(EdProduto.text);
     QE:=Sqltoquery('select esto_qbalanca,esto_tara,esto_peso,esto_descricao from estoque where esto_codigo='+Stringtosql(trim(EdProduto.text)));
     if not QE.eof then begin
        Tara:=QE.fieldbyname('esto_tara').ascurrency;
        pnomeproduto.caption:=QE.fieldbyname('esto_descricao').asstring;
        ptara.caption:=Formatfloat('##0.000',tara);
        EdPeso.enabled:=false;
        Gravapeso;
////////////////////
{
        if Global.Usuario.outrosacessos[0040] then begin
           EdPeso.enabled:=true;
           EdPeso.setfocus;
        end else begin
           EdPeso.enabled:=false;
           AcbrBal1.lepeso;
           if not Confirma('Confirma peso ?') then exit;
           peso:=EdPeso.ascurrency;
           if Global.Topicos[1318] then
               EdPeso.setvalue( arred(Peso) );
           if EdPeso.ascurrency >= 0 then begin
              EdPeso.SetValue(Edpeso.ascurrency-tara);
              pPeso.Caption     := formatFloat('###0.00', EdPeso.ascurrency );
              pPesobalanca.Caption     := formatFloat('###0.00', Peso );
           end;
           if EdPeso.ascurrency>0 then  begin
             Gravapeso;
//             gravar peso 'no final' para checar o kilos q entram com o q sai..
             EdPeso.text:='';
           end;
        end;
        }
////////////////////
     end else EdProduto.invalid('Codigo não encontrado no estoque');
   end else GridPedido.setfocus;
end;

// 09.06.16
procedure TFPesagemCamaraFria.GravaPeso;
/////////////////////////////////////////
var Q:TSqlquery;
    sqldata,sqltipomov,produto:string;
begin
  sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
  Sqltipomov:=' and mova_tipomov='+Stringtosql( Tipomov );
  produto:=trim(EdProduto.text);
  Q:=sqltoquery('select * from movabate'+
                      ' where mova_numerodoc='+inttostr(Numerodoc)+
                      ' and '+FGeral.Getin('mova_unid_codigo',Global.CodigoUnidade,'C')+
                      ' and mova_status=''N'''+
                      ' and mova_situacao=''P'''+
                      sqldata+sqltipomov );
  if Q.eof then begin
    Numerodoc:=FGeral.GetContador('CORTES'+Global.CodigoUnidade,false,false);
    Transacao:=Global.CodigoUnidade+strzero(numerodoc,6);
  end else begin
    Transacao:=Q.fieldbyname('mova_transacao').AsString;
  end;

    EditstoGridCorte;
// gravar somente no final os pesos dos cortes...
////    GravaItem('I',Q);  // item novo dentro de pedido ja começado com outros itens

  FGeral.FechaQuery(Q);
  try
    Sistema.Commit;
/////    Impetiqueta('Inc');
  except
    Avisoerro('Nada gravado.   Problemas na gravação no banco de dados');
  end;
  AtualizaValores;
  EdProduto.setfocus;
end;

// 09.06.16
//procedure TFPesagemCamaraFria.GravaItem(op: string; Q: Tsqlquery);
procedure TFPesagemCamaraFria.GravaItem(op: string ; linha:integer );
/////////////////////////////////////////////////////////////////////
var vlrarroba,pesojapesado:currency;
    QE,Qp:TSqlquery;
    material:string;
begin

     QE:=Sqltoquery('select * from estoqueqtde where esqt_unid_codigo = '+Stringtosql(Unidade)+
                    ' and esqt_esto_codigo = '+Stringtosql(EdProduto.text)+
                    ' and esqt_status = ''N''');
     if op='I' then begin
        Sistema.Insert('movabatedet');
        Sistema.SetField('movd_esto_codigo',trim(Edproduto.text));
        Sistema.SetField('movd_transacao',transacao);
        Sistema.SetField('movd_operacao',transacao+GridCortes.cells[GridPedido.getcolumn('movd_seq'),linha]);
        Sistema.SetField('movd_numerodoc',numerodoc);
        Sistema.SetField('movd_status','N');
        Sistema.SetField('movd_tipomov',TipoMov);
        Sistema.SetField('movd_unid_codigo',Unidade);
        Sistema.SetField('movd_tipo_codigo',codigocliente);
//        Sistema.SetField('movd_tipocad','C');
//        Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),linha]);
//        Sistema.SetField('movd_idade',Grid.cells[Grid.getcolumn('movd_idade'),linha]);
//        Sistema.SetField('movd_pesovivo',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesovivo'),linha]));
        Sistema.SetField('movd_pesocarcaca',Texttovalor(GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),linha]));
//        Sistema.SetField('movd_vlrarroba',FGrupos.GetValorArroba( FEstoque.GetGrupo(GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row]),Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha]) ) );
//        vlrarroba:=FGrupos.GetValorArroba( FEstoque.GetGrupo(EdProduto.text),Texttovalor(GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),linha]),EdProduto.text ) ;
//        Sistema.SetField('movd_vlrarroba',vlrarroba  );
//        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
        Sistema.SetField('movd_ordem',strtoint(GridCortes.cells[GridCortes.getcolumn('movd_seq'),linha]));
        Sistema.SetField('movd_pecas',1);
        Sistema.Post('');
// 09.06.16 - entra no estoque do corte informado e gera movimento do codigo dele
//          - baixa do estoque da etiqueta lida
//          - gera etiqueta do corte informado
///////////////////////////////////////////////////////////////////////////////////////////////
        if trim(material)<>'' then begin
          FGeral.MovimentaQtdeEstoque( material ,Unidade,'S',TipoMov,
                 TexttoValor(GridCortes.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha]),Qe,0,2);
        end;

       {
       FGeral.MovimentaQtdeEstoque( EdProduto.Text ,Unidade,'E',TipoMov,
                 TexttoValor(GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),linha]),Qe,0,2);
       QP:=sqltoquery('select movd_pesobalanca from movabatedet where movd_status = ''N'''+
                      ' and movd_operacao = '+Ednumerodoc.assql+
                      ' and movd_tipomov = '+Stringtosql(tipomov));

       pesojapesado:=TextTovalor( ptotalpesado.caption );
       Sistema.edit('movabatedet');
       Sistema.SetField('movd_pesobalanca',pesojapesado+TexttoValor(GridCortes.cells[GridCortes.getcolumn('movd_pesocarcaca'),linha]));
       Sistema.Post('movd_operacao='+EdNumerodoc.AsSql+' and movd_tipomov = '+Stringtosql(tipomov)+' and movd_status = ''N''');
       }
////////////////////////////////////////////////////////////////////////////

     end else begin

        Sistema.Edit('movabatedet');
        Sistema.SetField('movd_tipo_codigo',QPedido.fieldbyname('mped_tipo_codigo').AsInteger);
//        Sistema.SetField('movd_tipocad','C');
//        Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),linha]);
//        Sistema.SetField('movd_idade',Grid.cells[Grid.getcolumn('movd_idade'),linha]);
//        Sistema.SetField('movd_pesovivo',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesovivo'),linha]));
        Sistema.SetField('movd_pesocarcaca',Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_pesocarcaca'),linha]));
        Sistema.SetField('movd_vlrarroba',Texttovalor(GridPedido.cells[GridPedido.getcolumn('movd_vlrarroba'),linha]));
//        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
        Sistema.Post('movd_numerodoc='+EdNumerodoc.AsSql+
                     ' and movd_ordem='+GridPedido.cells[GridPedido.getcolumn('movd_seq'),linha]+
                     ' and movd_tipomov='+Stringtosql(TipoMov)+
                     ' and movd_status=''N''');
     end;
     FGeral.FechaQuery(Qe);
end;

// 09.06.16
procedure TFPesagemCamaraFria.EditstoGridCorte(xseq: integer);
/////////////////////////////////////////////////////////////////
var x:integer;
    valorvenda:currency;
begin
  if xseq=0 then
    x:=ProcuraGrid(GridCortes.getcolumn('movd_seq'),strzero(xseq,3),0,0,0,0,0,0 )
  else
    x:=ProcuraGrid(GridCortes.getcolumn('movd_seq'),strzero(xseq,3),0,0,0,0,0,0 );
    temgrid:=false;
    GridCortes.AppendRow;
    GridCortes.Cells[GridCortes.getcolumn('movd_seq'),Abs(x)]:=strzero(Seq,3);
    GridCortes.Cells[GridCortes.getcolumn('mpdd_esto_codigo'),Abs(x)]:=trim(EdProduto.text);
    GridCortes.Cells[GridCortes.getcolumn('esto_descricao'),Abs(x)]:=FEstoque.getdescricao(trim(EdProduto.text));
//    GridCortes.Cells[GridCortes.getcolumn('movd_pesocarcaca'),Abs(x)]:=trim(Transform( EdPeso.Ascurrency, f_cr3 ));
    GridCortes.Cells[GridCortes.getcolumn('movd_pesocarcaca'),Abs(x)]:=EdPeso.Assql;
//    GridCortes.Cells[GridCortes.getcolumn('movd_pecas'),Abs(x)]:=Edpecas.AsSql;
//  end else begin
//    temgrid:=true;
//    GridCortes.Cells[GridCortes.getcolumn('movd_pesocarcaca'),Abs(x)]:=Transform( EdPeso.Ascurrency, f_cr3 ) ;
//    GridCortes.Cells[GridCortes.getcolumn('movd_pecas'),Abs(x)]:=Edpecas.AsSql;
//  end;

end;

// 09.06.16
function TFPesagemCamaraFria.ProcuraGrid(Coluna: integer; Pesquisa: string;
  Colunatam, tam, colunacor, cor, colunacopa, copa: integer): integer;
  //////////////////////////////////////////////////////////////////////////////
var p:integer;
begin
  result:=0;seq:=0;
  for p:=1 to GridCortes.RowCount do  begin
      if trim(GridCortes.Cells[GridCortes.getcolumn('movd_seq'),p])<>'' then begin
        seq:=strtoint(GridCortes.Cells[GridCortes.getcolumn('movd_seq'),p]);
        inc(seq);
      end else begin
        if seq=0 then
          seq:=1;
      end;
  end;
  if (tam>0) and (cor>0) then begin
    if copa=0 then begin
      for p:=1 to GridCortes.RowCount do  begin
        if (trim(GridCortes.Cells[Coluna,p])=trim(Pesquisa)) and
         (trim(GridCortes.Cells[Colunatam,p])=trim(inttostr(tam))) and (trim(GridCortes.Cells[Colunacor,p])=trim(inttostr(cor))) then begin
          result:=p;
          break;
        end;
        if trim(GridCortes.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
    end else begin
      for p:=1 to GridCortes.RowCount do  begin
        if (trim(GridCortes.Cells[Coluna,p])=trim(Pesquisa)) and
         (trim(GridCortes.Cells[Colunatam,p])=trim(inttostr(tam))) and (trim(GridCortes.Cells[Colunacor,p])=trim(inttostr(cor)))
          and ( trim(GridCortes.Cells[Colunacopa,p])=trim(inttostr(copa)) ) then begin
          result:=p;
          break;
        end;
        if trim(GridCortes.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
    end;
  end else if (tam>0) and (cor=0) then begin  // 04.07.06
      for p:=1 to GridCortes.RowCount do  begin
        if (trim(GridCortes.Cells[Coluna,p])=trim(Pesquisa)) and
         ( trim(GridCortes.Cells[Colunatam,p])=trim(inttostr(tam)) ) and ( texttovalor(GridCortes.Cells[Colunacor,p])=0 ) then begin
          result:=p;
          break;
        end;
        if trim(GridCortes.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
  end else begin  // 03.10.07
      for p:=1 to GridCortes.RowCount do  begin
        if trim(GridCortes.Cells[Coluna,p])=trim(Pesquisa) then begin
          result:=p;
          break;
        end;
        if trim(GridCortes.Cells[Coluna,p])='' then begin   // linha a ser usada
          result:=(-1)*p;
          break;
        end;
      end;
  end;
end;

// 09.06.16
procedure TFPesagemCamaraFria.bgravaClick(Sender: TObject);
////////////////////////////////////////////////////////////////
var p:integer;
    xcodigo:string;
    peso,pesototal:currency;
    grava:boolean;
begin

   if Qpedido.fieldbyname('movd_pesobalanca').ascurrency>= Qpedido.fieldbyname('movd_pesocarcaca').ascurrency then begin
     aviso('Etiqueta JÁ PESADA');
     exit;
   end;

   pesototal:=0;
   for p:=0 to GridCortes.RowCount do begin
     xcodigo:=GridCortes.cells[GridCortes.getcolumn('mpdd_esto_codigo'),p];
     peso:=Texttovalor( GridCortes.Cells[GridCortes.getcolumn('movd_pesocarcaca'),p] );
     if peso > 0 then pesototal:=pesototal+peso;
   end;
//  ver se cria config. para a tolerancia
{
   if ( pesototal > (pesoorigem+(pesoorigem*0.10)) ) or ( pesototal < (pesoorigem-(pesoorigem*0.10)) )  then begin
      Aviso('Soma dos pesos : '+fGeral.formatavalor(Pesototal,f_cr)+' Peso da etiqueta : '+fGeral.formatavalor(Pesoorigem,f_cr) );
      exit;
   end;
   }
   if not confirma('Confirma a gravação ?') then exit;
   grava:=false;
   Numerodoc:=FGeral.GetContador('CORTES'+Global.CodigoUnidade,false,true);
   for p:=0 to GridCortes.RowCount do begin
     xcodigo:=GridCortes.cells[GridCortes.getcolumn('mpdd_esto_codigo'),p];
     peso:=Texttovalor( GridCortes.Cells[GridCortes.getcolumn('movd_pesocarcaca'),p] );
//     if peso > 0 then begin
     if trim(xcodigo)<>'' then begin
        grava:=true;
        GravaItem('I',p);
     end;
   end;
   if grava then begin
      Sistema.Insert('movabate');
      Sistema.SetField('mova_transacao',transacao);
      Sistema.SetField('mova_operacao',transacao+'01');

      Sistema.SetField('mova_numerodoc',Numerodoc);
      Sistema.SetField('mova_status','N');
      Sistema.SetField('mova_tipomov',TipoMov);
      Sistema.SetField('mova_unid_codigo',Global.CodigoUnidade);
      Sistema.SetField('mova_datalcto',Sistema.Hoje);
      Sistema.SetField('mova_dtcarrega',Sistema.Hoje);
      Sistema.SetField('mova_dtabate',Sistema.hoje);
      Sistema.SetField('mova_dtvenci',Sistema.hoje);
      Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
//      mova_notagerada numeric(8,0),
      Sistema.SetField('mova_transacaogerada',Ednumerodoc.text);
      Sistema.SetField('mova_tipo_codigo',codigocliente);
//      mova_pesovivo numeric(12,3),
      Sistema.SetField('mova_pesocarcaca',Texttovalor(PTotalPesado.Caption));
      Sistema.SetField('mova_datacont',Sistema.Hoje);
//      mova_perc numeric(12,5),
      Sistema.SetField('mova_situacao','P');
//      mova_tran_codigo character varying(3),
//      mova_fpgt_codigo character varying(3),
//      mova_repr_codigo numeric(4,0),
//      mova_vlrtotal numeric(12,3),
//      mova_perccomissao numeric(8,3),
//      mova_vlrgta numeric(12,3)
      Sistema.Post();
      try
         Sistema.commit;
         Aviso('Pesos gravados');
         Zeracampos;
         Ednumerodoc.setfocus;
      except
         Avisoerro('Pesos NÃO GRAVADOS');
      end;
   end;

end;

// 09.06.16
procedure TFPesagemCamaraFria.EdPesoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////
var Qe:TSqlquery;
    tara:currency;
begin
  if EdPeso.ascurrency>0 then begin
     QE:=Sqltoquery('select esto_qbalanca,esto_tara,esto_peso,esto_descricao from estoque where esto_codigo='+Stringtosql(trim(EdProduto.text)));
     if not QE.eof then
        Tara:=QE.fieldbyname('esto_tara').ascurrency
     else
        tara:=0;
    if Global.Topicos[1318] then
       EdPeso.setvalue( arred(EdPeso.ascurrency) );
    ppesobalanca.caption:=Formatfloat('##0.000',EdPeso.ascurrency);
    EdPeso.setvalue( EdPeso.ascurrency-tara );
    ppeso.caption:=EdPeso.text;
    Gravapeso;
    FGeral.fechaquery(Qe);
  end;

end;

procedure TFPesagemCamaraFria.EdSeqfValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////
begin
   if (EdSeqf.asinteger>0) and (EdSeqf.asinteger<EdSeqi.asinteger) then EdSeqf.invalid('Sequencial final tem que ser amior que inicial');

end;

procedure TFPesagemCamaraFria.EdSeqfExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////
type TCamara = record
     linha :widestring;
end;

var totalpeso,totalitem:currency;
    Q1:TSqlquery;
    sqlordem,codmuniemitente,s,arquivoetiq,linha:string;
    i:integer;
    arqimp,arqlido,arqlista:TextFile;
    PCamara:^TCamara;
    ListaCamara:TList;
    linhaw,comando:widestring;

    // 25.07.16
    procedure ImprimeEtiqueta( xarq:string ; Item:TNfe );
    ///////////////////////////////////////////////////////
    var Lista,ListaImp:TStringList;
        p:integer;
        Arquivo:TextFile;
        vtermica:string;

        function ColocaDados(linha:string  ):string;
        ////////////////////////////////////////////////////////////////////////////////
        var x,p:integer;
            novalinha,troca:string;
            ListaTroca:TStringlist;

            function PoeInfo( s:string ):string;
            ////////////////////////////////////
            begin
              if s = uppercase('[codigo]') then result:=Item.Det.Items[0].Prod.cProd
              else if s = uppercase('[descricao]') then result:=Item.Det.Items[0].Prod.xProd
              else if s = uppercase('[numerodoc]') then result:=inttostr(Item.Ide.cnf)
              else if s = uppercase('[peso]') then result:=currtostr(Item.Det.Items[0].Prod.qCom)
              else if s = uppercase('[endereco]') then result:=(Item.Emit.EnderEmit.xLgr)
              else if s = uppercase('[nomecliente]') then result:=(Item.Emit.xNome)
              else if s = uppercase('[codbarra]') then result:=(Item.Det.Items[0].Prod.xPed)
              else if s = uppercase('1234') then result:=(Item.Det.Items[0].Prod.xPed)
//              else if s = uppercase('123456789012') then result:=(Item.Det.Items[0].Prod.xPed)
              else if s = uppercase('[data]') then result:=FGeral.FormataData(Sistema.Hoje)
              else if s = uppercase('/17') then result:=FGeral.FormataData(Sistema.Hoje)
              else if s = uppercase('/18') then result:=FGeral.FormataData(Sistema.Hoje)
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
          ListaTroca.Add( '1234' );
  //        ListaTroca.Add( '123456789012' );
          ListaTroca.Add( '/17' );
          ListaTroca.Add( '/18' );
          ListaTroca.Add( '[data]' );
          novalinha:=linha;
          for p:=0 to ListaTroca.count-1 do begin
             troca:= Uppercase( ListaTroca[p] );
             x:=pos( troca ,uppercase(novalinha) );
             if x>0 then begin
                if troca='/17' then
                  novalinha:=StuffString(novalinha,x-5,length(troca)+5,PoeInfo(troca))
                else if troca= '1234' then
                  novalinha:=StuffString(novalinha,x,length(troca),PoeInfo(troca))
//                  novalinha:=copy(novalinha,1,x)+PoeInfo(troca)+space(10)
                else
                  novalinha:=StuffString(novalinha,x,length(troca),PoeInfo(troca));
             end;
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

      while not eof(arqlido) do begin
        Readln ( arqlido,linha );
        linhaw:=ColocaDados(linha);
        New(PCamara);

  //      aviso('lendo arqlido '+xarq );

        Pcamara.linha:=linhaw;
        ListaCamara.Add(PCamara);
      end;
      CloseFile ( arqlido );


      AssignFile(arqlista,ExtractFilePath(Application.ExeName)+'impetqcamarafria.prn');
      Rewrite( arqlista );

      if Listacamara.Count=0 then aviso ('ListaCamara zerado');


      for p:=0 to ListaCamara.Count-1 do begin
        PCamara:=ListaCamara[p];
//        Writeln(arqlista,PCamara.linha);
        ListaImp.Add(PCamara.linha);
      end;
      CloseFile ( arqlista );

       ListaImp.SaveToFile(ExtractFilePath(Application.ExeName)+'impetqcamarafria.prn');

 //    Aviso('vendo campos para troca '+xarq);

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
      if FGeral.GetConfig1AsString('Microcamarafria' )='' then
       vtermica:='lpt1'
//        vtermica:='\\localhost\d:\delphisac\programas\impressao.text'
      else
        vtermica:='\\'+FGeral.GetConfig1AsString('Microcamarafria' )+'\'+FGeral.GetConfig1AsString('Nomemicrocf' );


//      comando:='command.com /c Type '+ExtractFilePath( Application.ExeName ) + xarq+' > '+vtermica;

     comando :=ExtractFilePath(Application.ExeName)+'Imp.bat' ;

//      Aviso( comando );

///{
      AssignFile ( arqimp,ExtractFilePath(Application.ExeName)+'IMP.BAT' );

 //     ExtractFilePath(Application.ExeName)+'Sistema'

      Rewrite ( arqimp );
//      Writeln ( arqimp, 'Type ' + xarq + ' > ' + vtermica );
//      Writeln ( arqimp, 'Type ' + arqlido + ' > ' + vtermica );
//      Writeln ( arqimp, copy(ExtractFilePath(Application.ExeName),1,2) );
//      Writeln ( arqimp, 'Cd'+trim(copy(ExtractFilePath(Application.ExeName),3,50)) );
      Writeln ( arqimp, 'Type impetqcamarafria.prn' +' > ' + vtermica );
/////      Writeln ( arqimp, 'Pause' +' > ' + vtermica );

      CloseFile ( arqimp );
//      WinExec( PChar ( comando  ), SW_HIDE );

//   aviso('fazendo o winexec comando '+comando);

//      WinExec( PAnsiChar ( comando  ), SW_SHOWMINIMIZED );
//      WinExec( PAnsiChar ( comando  ), SW_NORMAL );

      Diretorio.Directory:=ExtractFilePath(Application.ExeName);

//      WinExec( PAnsiChar ( 'Imp.bat'  ), SW_SHOWMINIMIZED );

      if  ShellExecute(handle,'open',PChar('Imp.bat'), '',PChar(Diretorio.Directory),SW_HIDE) <= 32 then

        Avisoerro('Erro no shellExecute');

////
{
      if ListaImp.count>0 then begin
        Aviso('Imprimindo etiquetas');
        AssignFile(Arquivo,vTermica);
        Rewrite(Arquivo);
//        Write(Arquivo,ListaImp.gettext);
        Write(Arquivo,ArqGravado.Lines.gettext);
        Reset(Arquivo);
	      CloseFile(Arquivo);
      end else Aviso('Lista para impressão vazia');
}
      ListaImp.Free;
    end;


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

    AcbrNFe1.DANFE := TACBrNFeDANFCeFortesETQEA.Create(AcbrNFe1);
    AcbrNfe1.DANFE.TipoDANFE := tiNFCE;
    if Global.usuario.outrosacessos[0510] then
      acbrnfe1.danfe.MostrarPreview:=true
    else
      acbrnfe1.danfe.MostrarPreview:=false;
      {
    acbrnfe1.danfe.MargemEsquerda:=01;
    acbrnfe1.danfe.MargemDireita:=10;
    acbrnfe1.danfe.MargemSuperior:=18;
    acbrnfe1.danfe.MargemInferior:=10;
    acbrnfe1.danfe.NumCopias:=2;
    }
//    if FileExists( ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg' ) then
//      acbrnfe1.danfe.Logo:=ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg';
    s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPETQCAM');
    if trim(s)<>'' then Acbrnfe1.DANFE.Impressora:=s;

      Q1:=sqltoquery('select * from movabatedet'+
                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                     ' inner join clientes on ( clie_codigo=movd_tipo_codigo )'+
                     ' where mova_transacaogerada = '+EdNumerodoc.assql+
//                     ' and movd_tipomov='+stringtosql('EA')+
                     ' and movd_tipomov='+stringtosql('PC')+
                     ' and mova_tipomov='+stringtosql('PC')+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     sqlordem+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
                     ' order by movd_ordem' );

    if Q1.Eof then Avisoerro('Não encontrado transacao gerada '+EdNumerodoc.Text);

    while not Q1.eof do begin

      with  ACBrNFe1.NotasFiscais.Add.NFe do begin
        Total.ICMSTot.vBC   := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Total.ICMSTot.vProd := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Emit.xFant          := FCadcli.GetNome(codigocliente);
        Emit.xNome          := FCadcli.GetRazaoSocial(codigocliente);
        Emit.CNPJCPF        := '';   // FCadcli.GetCnpjCpf(codigocliente);
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
          end;

        Total.ICMSTot.vNF   := totalpeso;

          Q1.Next;
      end; /// with acbr

    end;  /// Q1.eof
    FGeral.FechaQuery(Q1);
    Sistema.beginprocess('Imprimindo');

    if ACBrNFe1.NotasFiscais.Count=0 then avisoerro('componente acbr ficou vazio');


      for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin
//         ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );
// 2 vias de cada etiqueta
//         ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

 //        Aviso('buscando qual o arquivo do produto');

// 25.07.16
        arquivoetiq:=FEstoque.GetArqEtiqueta( ACBrNFe1.NotasFiscais.Items[i].NFe.Det.Items[0].Prod.cProd,sexo);

//       aviso('arquivo de impressao '+arquivoetiq );

        if trim(arquivoetiq)<>'' then
          ImprimeEtiqueta( arquivoetiq,ACBrNFe1.NotasFiscais.Items[i].NFe )
        else
//          ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );
          aviso( 'não encontrado arquivo do codigo '+ACBrNFe1.NotasFiscais.Items[i].NFe.Det.Items[0].Prod.cProd );

//          aviso('imprimiu primeira do '+ACBrNFe1.NotasFiscais.Items[i].NFe.Det.Items[0].Prod.cProd);
         sleeP(100);  // senao da i/o error

      end;

      Sistema.endprocess('');
      ACBrNFe1.NOtasFiscais.clear;

end;


procedure TFPesagemCamaraFria.EdTiposdeCorteValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////////////
begin
   Showmessage('espere aqui');
end;

end.
