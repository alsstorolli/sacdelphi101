// 07.06.16
// Pesagem dentro da camara fria para 'dar saida do produto q entra e entrada do produto que sai'
/////////////////////////////////////////////////////////////////////////////////////////////////////

unit pesagemcamarafria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrDFe, ACBrNFe, ACBrETQ, ACBrBase, ACBrBAL, ExtCtrls, Grids,
  SqlDtg, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, SQLGrid, AcbrDevice,
  Math, ACBrDANFCeFortesFrEA,ACBrDANFCeFortesFrETQFAT, pcnconversao,SqlExpr,
  Vcl.FileCtrl, AcbrDeviceSerial;

type
  TFPesagemCamaraFria = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bretnropedido: TSQLBtn;
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
    Label2: TLabel;
    ACBrBAL1: TACBrBAL;
    ACBrETQ1: TACBrETQ;
    Diretorio: TFileListBox;
    bexcluipesagem: TSQLBtn;
    ACBrNFe1: TACBrNFe;
    ACBrBAL2: TACBrBAL;
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
    procedure bexcluipesagemClick(Sender: TObject);
    procedure EdNumeroDOCChange(Sender: TObject);
    procedure ACBrBAL1LePeso(Peso: Double; Resposta: AnsiString);
    procedure ACBrBAL2LePeso(Peso: Double; Resposta: AnsiString);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConfiguraTeclas( Key: Word );
    Procedure Execute(xOP:string='');
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
  sexo,
  OP,
  TipoMovDE,
  TipoMovCong    :string;
  DataPedido     :TDatetime;
  Tara,pesoorigem:Currency;
  QPedido,
  QSaida         :TSqlquery;
  Seq,CodigoCliente,NumeroDoc,
  codigoasercortadocor,NumeroRomaneio:integer;
  Temgrid,
  casado,
  Transforma :boolean;

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
  if AcbrBal2.Ativo then
    AcbrBal2.Desativar;

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


end;

procedure TFPesagemCamaraFria.ConfiguraTeclas(Key: Word);
//////////////////////////////////////////////////////
begin
 if key = vk_f4 then blebalancaClick(self)
 else if key = vk_f5 then bimpetqClick(self)
 else if key = vk_f3 then bretnropedidoClick(self)
 else if key = vk_f6 then bSairClick(self)
///// else if key = vk_f2 then bgravaClick(self)
 else if key = vk_f11 then bromaneioClick(self)
 else if key = vk_f2 then bexcluipesagemClick(self);

end;


// 01.08.17
procedure TFPesagemCamaraFria.EdNumeroDOCChange(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin
   if ( (copy(EdNumerodoc.Text,1,3)='001') and ( length(trim(EdNumerodoc.Text))=10 ) and
      ( copy(EdNumerodoc.Text,11,1)=' ' ) ) or
      ( length(trim(EdNumerodoc.Text))>=12 )
   then begin
     EdNumerodoc.Valid;
   end;

end;

procedure TFPesagemCamaraFria.EdNumeroDOCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);

end;

procedure TFPesagemCamaraFria.Execute(xOP:string='');
/////////////////////////////////////////////////////
begin

   OP:=xOP;
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
   TipoMovDe  :='DE';
   TipoMovCong:='EC';


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
   if OP='D' then
      Caption:='Etiquetas para Desossa'

   else if OP = 'T' then

      Caption:='Etiquetas para Transforma��o para Congelamento'

   else

      Caption:='Etiquetas Camara Fria';

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
     EdNumerodoc.invalid('N�mero do pedido est� zerado');
     exit;
   end;

   if ( Qpedido.fieldbyname('movd_pesobalanca').ascurrency>= Qpedido.fieldbyname('movd_pesocarcaca').ascurrency )
       and
      ( OP <> 'T' )
     then begin

     aviso('Etiqueta J� PESADA');
     exit;

   end else if ( Qpedido.fieldbyname('movd_pesobalanca').ascurrency < Qpedido.fieldbyname('movd_pesocarcaca').ascurrency )
       and
      ( OP = 'T' )
     then begin

     aviso('Etiqueta ainda N�O PESADA');
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

  if (qbalanca='BAL1') or ( trim(qbalanca)='') then begin
    try
     Acbrbal1.Ativar;
     result:=true;
    except
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

  end;

end;


procedure TFPesagemCamaraFria.EdNumeroDOCValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////////////
var sqlaberto,sqlwhere,sqldata,sqlunidades,sqlwhered,ccorte,
    xtipo,
    balanca     :string;
    x:integer;
    QC,QP:Tsqlquery;
    ListaCores,ListaC             :Tstringlist;
    tara,
    toleranciaproduto,
    pesobalanca                   :currency;


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

     while ( (not Q.eof) and  ( OP<>'T') )
           or
           ( (not Q.eof) and (OP='T')  and ( transforma )
             and ( Ansipos('COSTELA',Uppercase(FEstoque.getdescricao(codigoasercortado)))>0 ) )

           do begin

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
              // 25.09.18 - seria entrada na desossa
              if OP='D' then
                 Sistema.SetField('movd_tipomov',TipoMovDE)
// 23.08.19
              else if OP='T' then
                 Sistema.SetField('movd_tipomov',TipoMovCong)

              else
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
// 05.10.18
              Sistema.SetField('movd_datamvto',Sistema.Hoje);
              Sistema.Post('');
      // 09.06.16 - entra no estoque do corte informado e gera movimento do codigo dele
      //          - baixa do estoque da etiqueta lida
      //          - gera etiqueta do corte informado
      ///////////////////////////////////////////////////////////////////////////////////////////////
              FGeral.MovimentaQtdeEstoque( Q.fieldbyname('cust_esto_codigomat').AsString ,Unidade,'S',TipoMov,peso,Qe,0,2);

// 18.05.20 - Novicarnes especifico - vanderlei + isonel
              if ( Q.fieldbyname('cust_esto_codigomat').AsString =  '72' )
                 or
                 ( Q.fieldbyname('cust_esto_codigomat').AsString =  '74' ) then begin

                Sistema.Insert('movabatedet');
                Sistema.SetField('movd_esto_codigo',(Q.fieldbyname('cust_esto_codigomat').AsString));
                Sistema.SetField('movd_transacao',transacao);
                Sistema.SetField('movd_operacao',transacao+inttostr(p));
                Sistema.SetField('movd_numerodoc',numerodoc);
                Sistema.SetField('movd_status','N');
// entrada na desossa
                Sistema.SetField('movd_tipomov',TipoMovDE);

                Sistema.SetField('movd_unid_codigo',Unidade);
                Sistema.SetField('movd_tipo_codigo',codigocliente);
                Sistema.SetField('movd_pesocarcaca',peso);
                Sistema.SetField('movd_ordem',p);
                Sistema.SetField('movd_pecas',1);
                Sistema.SetField('movd_datamvto',Sistema.Hoje);
                Sistema.Post('');
                FGeral.MovimentaQtdeEstoque( Q.fieldbyname('cust_esto_codigomat').AsString ,Unidade,'E',TipoMovDE,peso,Qe,0,2);


              end;

              QE.close;
         end;
         Q.Next;

     end;  // perccorre planilha de composicao...

     if (OP='T') and  ( not transforma ) then begin
//     ( ( Ansipos('COSTELA',Uppercase(FEstoque.getdescricao(codigoasercortado)))=0 ) )   then begin

        grava:=true;

         QE:=Sqltoquery('select * from estoqueqtde where esqt_unid_codigo = '+Stringtosql(Unidade)+
                       ' and esqt_esto_codigo = '+Stringtosql(codigoasercortado)+
                       ' and esqt_status = ''N''');
          peso:=Qpedido.fieldbyname('movd_pesocarcaca').ascurrency;
          grava:=true;
          Sistema.Insert('movabatedet');
          Sistema.SetField('movd_esto_codigo',codigoasercortado);
          Sistema.SetField('movd_transacao',transacao);
          Sistema.SetField('movd_operacao',transacao+inttostr(p));
          inc(p);
          Sistema.SetField('movd_numerodoc',numerodoc);
          Sistema.SetField('movd_status','N');
          Sistema.SetField('movd_tipomov',TipoMovCong);

          Sistema.SetField('movd_unid_codigo',Unidade);
          Sistema.SetField('movd_tipo_codigo',codigocliente);
          Sistema.SetField('movd_pesocarcaca',peso);
          Sistema.SetField('movd_ordem',1);
          Sistema.SetField('movd_pecas',1);
          Sistema.SetField('movd_datamvto',Sistema.Hoje);
          Sistema.SetField('movd_oprastreamento',EdNumerodoc.Text);
          Sistema.Post('');
  ///////////////////////////////////////////////////////////////////////////////////////////////
          FGeral.MovimentaQtdeEstoque( codigoasercortado ,Unidade,'S',TipoMovcong,peso,Qe,0,2);

          QE.close;


     end;

         if grava then begin

            Sistema.Insert('movabate');
            Sistema.SetField('mova_transacao',transacao);
            Sistema.SetField('mova_operacao',transacao+'01');
            Sistema.SetField('mova_numerodoc',Numerodoc);
            Sistema.SetField('mova_status','N');
            if OP='D' then

               Sistema.SetField('mova_tipomov',TipoMovDE)

            else if OP='T' then

               Sistema.SetField('mova_tipomov',TipoMovCong)

            else
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
            Sistema.SetField('mova_pesocarcaca',peso);
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
// 25.07.17
               if ccorte='001' then
// 10.05.17
                 casado:=Confirma('Etiqueta ref. Casado ?')
               else
                 casado:=false;

               EdSeqf.OnExitEdit(self);
               Zeracampos;
               Ednumerodoc.clear;
               Ednumerodoc.setfocus;

            except

               Avisoerro('Pesos N�O GRAVADOS');

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

   balanca:=QPedido.fieldbyname('esto_qbalanca').asstring;
   Tara:=QPedido.fieldbyname('esto_tara').ascurrency;

   codigocliente:=0;
   if not QPedido.eof then
      CodigoCliente:=QPedido.fieldbyname('mova_tipo_codigo').asinteger;

   GridPedido.clear;
   Ppeso.caption:='';
   casado:=false;
   x:=1;
   if QPedido.eof then begin
     aviso('Etiqueta n�o encontrada');
     exit;
   end;
   if ( Qpedido.fieldbyname('movd_pesobalanca').ascurrency>= Qpedido.fieldbyname('movd_pesocarcaca').ascurrency )
      and
      ( OP <> 'T' )
     then begin
     aviso('Etiqueta J� PESADA');
     exit;
   end;
   if QPedido.FieldByName('esto_categoria').AsString='MA' then sexo:='M'
   else if QPedido.FieldByName('esto_categoria').AsString='FE' then sexo:='F'
   else sexo:='Q';

// 22.10.18 - Novicarnes - Isonel+Vanderlei
   if OP='D' then begin

        ptara.caption:=Formatfloat('##0.000',QPedido.fieldbyname('esto_tara').ascurrency);
        if Global.Usuario.Codigo=101 then begin

           EdPeso.SetValue(  45  );
           pPesobalanca.Caption := '45';

        end else begin

            toleranciaproduto:=QPedido.FieldByName('esto_taracf').AsCurrency;

            if UsaGancheira( QPedido.FieldByName('movd_esto_codigo').AsString ) then begin
               PesoBalanca:=Pesobalanca-FGeral.GetConfig1AsFloat('DESCPESO');
               if UsaGancheiraMenos1(QPedido.FieldByName('movd_esto_codigo').AsString ) then begin
                 tara:=tara+(FGeral.GetConfig1AsFloat('DESCPESOGANCHO'))+FGeral.GetConfig1AsFloat('DESCPESO');
                 PesoBalanca:=Pesobalanca + (FGeral.GetConfig1AsFloat('DESCPESOGANCHO')) +
                              FGeral.GetConfig1AsFloat('DESCPESOGANCHO');
               end else begin

                  tara:=tara+(FGeral.GetConfig1AsFloat('DESCPESOGANCHO'))+FGeral.GetConfig1AsFloat('DESCPESO');

               end;
            end;

          abrirporta( balanca );
          if (balanca='BAL1') or ( trim(balanca)='') then
            AcbrBal1.LePeso( 500 )
          else
            AcbrBal2.LePeso( 500 );

        end;

        if EdPeso.ascurrency>=0 then begin
           pesobalanca:=EdPeso.AsCurrency;
           EdPeso.setvalue( EdPeso.ascurrency - tara );
        end;

        pesoorigem:=EdPeso.AsCurrency;

   end;

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

           if OP<>'D' then
              pesoorigem:=QPedido.fieldbyname('movd_pesocarcaca').ascurrency;
         end;
         inc(x);
         GridPedido.AppendRow;
     QPedido.next;

   end;
   QPedido.First;
   PNomecliente.caption:=FCadcli.GetNome(codigocliente);
   NumeroRomaneio:=QPedido.FieldByName('movd_numerodoc').AsInteger;
   transforma:=false;

   if OP='D' then

     xtipo:=TipomovDE

   else if OP = 'T' then begin

     xtipo:=TipoMovCong;
     if  Ansipos('COSTELA',Uppercase(FEstoque.getdescricao(codigoasercortado)))>0  then
         transforma := Confirma('Transformar a costela ? ')

   end else

     xtipo:=Tipomov;

// mostra grid de cortes
///////////////////////////////
   QC:=sqltoquery('select esto_descricao,movd_esto_codigo,movd_ordem,movd_pesocarcaca from movabatedet'+
                  ' inner join movabate on (mova_transacao=movd_transacao and mova_tipomov=movd_tipomov)'+
                  ' inner join estoque on ( movd_esto_codigo=esto_codigo )'+
                  ' where movd_tipomov = '+Stringtosql(xtipo )+
                  ' and movd_status = ''N'''+
                  ' and mova_transacaogerada = '+EdNumerodoc.assql+
                  ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade));
   GridCortes.Clear;
   ListaCores:=Tstringlist.create;
   ListaC:=Tstringlist.create;
   if (Qc.eof)  then begin
//     ver se tem mais de uma composicao dai pedir qual vai usar
     QP:=sqltoquery('select cust_core_codigo from custos where cust_status = ''N'''+
                   ' and cust_esto_codigo = '+stringtosql(codigoasercortado)+
                   ' and cust_tipo = ''E'' order by cust_core_codigo');
     if ( QP.Eof ) and ( codigoasercortado='207' )  then begin
       FGeral.FechaQuery(QP);
       QP:=sqltoquery('select cust_core_codigo from custos where cust_status = ''N'''+
                   ' and cust_esto_codigo = '+stringtosql('57')+
                   ' and cust_tipo = ''E'' order by cust_core_codigo');
     end else if ( QP.Eof ) and ( codigoasercortado='26' )  then begin
       FGeral.FechaQuery(QP);
       QP:=sqltoquery('select cust_core_codigo from custos where cust_status = ''N'''+
                   ' and cust_esto_codigo = '+stringtosql('158')+
                   ' and cust_tipo = ''E'' order by cust_core_codigo');
// 07.08.17
     end else if ( QP.Eof ) and ( codigoasercortado='1411' )  then begin
       FGeral.FechaQuery(QP);
       QP:=sqltoquery('select cust_core_codigo from custos where cust_status = ''N'''+
                   ' and cust_esto_codigo = '+stringtosql('49')+
                   ' and cust_tipo = ''E'' order by cust_core_codigo');

     end else if ( QP.Eof ) and ( codigoasercortado='1673' )  then begin
       FGeral.FechaQuery(QP);
       QP:=sqltoquery('select cust_core_codigo from custos where cust_status = ''N'''+
                   ' and cust_esto_codigo = '+stringtosql('96')+
                   ' and cust_tipo = ''E'' order by cust_core_codigo');

     end;

     while (not Qp.Eof) and ( OP<>'T') do begin

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

     if OP = 'D' then begin

        if pesoorigem<=0  then begin
           Avisoerro('Peso est� zerado.  Nada ser� gravado');
           exit;
        end else
           GeraeGravaPesos;

     end else if OP = 'F' then begin

           GeraeGravaPesos;

     end else begin

       GeraeGravaPesos;

     end;

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

// 22.10.18
procedure TFPesagemCamaraFria.ACBrBAL1LePeso(Peso: Double;  Resposta: AnsiString);
//////////////////////////////////////////////////////////////////////////////////////
var valid,
    posiD : integer;
    xResposta,outra:string;

begin


   posid := AnsiPos( 'D', Resposta)  ;
 //  if posid>0 then
//     xResposta := copy( Resposta,posiD+1,6)
//   else
     xResposta := copy( Resposta,3,15)  ;
// 28.01.20
   if OP = 'D' then xResposta := copy( Resposta,06,08);

//   pPesobalanca.Caption := xResposta ;

   peso:=Texttovalor(xresposta);
   peso:=peso - TextTovalor(ptara.Caption);
   EdPeso.SetValue(0);

    if Peso >= 0 then begin
//      PMens.Caption := 'Leitura OK !';
      PMens.Caption := resposta+' - '+xresposta;
     EdPeso.SetValue(peso);

      pPesobalanca.Caption     := formatFloat('###0.00', Peso );

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

procedure TFPesagemCamaraFria.ACBrBAL2LePeso(Peso: Double;  Resposta: AnsiString);
//////////////////////////////////////////////////////////////////////////////////////////
var valid,
    posiD : integer;
    xResposta,outra:string;

begin


   posid := AnsiPos( 'D', Resposta)  ;
//   if posid>0 then
//     xResposta := copy( Resposta,posiD+1,6)
//   else
     xResposta := copy( Resposta,3,15)  ;

//   pPesobalanca.Caption := xResposta ;

   peso:=Texttovalor(xresposta);
   peso:=peso - TextTovalor(ptara.Caption);
   EdPeso.SetValue(0);

    if Peso >= 0 then begin
//      PMens.Caption := 'Leitura OK !';
      PMens.Caption := resposta+' - '+xresposta;
     EdPeso.SetValue(peso);

      pPesobalanca.Caption     := formatFloat('###0.00', Peso );

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
     end else EdProduto.invalid('Codigo n�o encontrado no estoque');
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
////    GravaItem('I',Q);  // item novo dentro de pedido ja come�ado com outros itens

  FGeral.FechaQuery(Q);
  try
    Sistema.Commit;
/////    Impetiqueta('Inc');
  except
    Avisoerro('Nada gravado.   Problemas na grava��o no banco de dados');
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
// 29.05.19
        Sistema.SetField('movd_datamvto',Sistema.Hoje);
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

// 25.07.17
procedure TFPesagemCamaraFria.bexcluipesagemClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var QX:TSqlquery;
    t,
    xtipo:string;
begin
  if EdNUmerodoc.IsEmpty then exit;

// 27.09.18
  if OP='D' then
     xtipo:=tipomovDE
  else if OP='T' then
     xtipo:=TipoMovCong
  else
     xtipo:=tipomov;

  QX:=sqltoquery('select movd_transacao,movd_operacao,movd_ordem,movd_pesocarcaca from movabatedet'+
                  ' inner join movabate on (mova_transacao=movd_transacao and mova_tipomov=movd_tipomov)'+
                  ' inner join estoque on ( movd_esto_codigo=esto_codigo )'+
                  ' where movd_tipomov = '+Stringtosql( xtipo )+
                  ' and movd_status = ''N'''+
                  ' and mova_transacaogerada = '+EdNumerodoc.assql+
                  ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade));
  if not QX.Eof then begin
     t:=Qx.FieldByName('movd_transacao').AsString;
     while not QX.Eof do begin
       Sistema.Edit('movabatedet');
       Sistema.SetField('movd_status','C');
       Sistema.Post('movd_operacao = '+Stringtosql(Qx.FieldByName('movd_operacao').AsString));
       QX.Next;
     end;
     Sistema.Edit('movabate');
     Sistema.SetField('mova_status','C');
     Sistema.Post('mova_transacao = '+Stringtosql(t));
     try
       Sistema.Commit;
       Aviso('Excluido');
     except
       Avisoerro('N�o foi poss�vel gravar no banco de dados');
     end;
     FGeral.FechaQuery(QX);
     EdNumerodoc.setfocus;
  end else Avisoerro('Nada encontrado');

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
     aviso('Etiqueta J� PESADA');
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
   if not confirma('Confirma a grava��o ?') then exit;
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
         Avisoerro('Pesos N�O GRAVADOS');
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

var totalpeso,
totalitem:currency;
    Q1,
    QNutri,
    Qconserva:TSqlquery;
    sqlordem,codmuniemitente,s,arquivoetiq,linha,
    xtipo  :string;
    i      :integer;
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

        function ColocaDados(linha:widestring  ):widestring;
        ////////////////////////////////////////////////////////////////////////////////
        var x,p:integer;
            novalinha,troca:widestring;
            ListaTroca:TStringlist;

            function PoeInfo( s:widestring ):widestring;
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
             x:=Ansipos( troca ,uppercase(novalinha) );
             if x>0 then begin
                if (troca='/17') or (troca='/18')  then
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

//      Caption:='Utilizando arquivo '+xarq ;
      while not eof(arqlido) do begin
        Readln ( arqlido,linha );
        linhaw:=ColocaDados(linha);
        New(PCamara);

//        Caption:='Utilizando arquivo '+xarq+' linha='+linha+'linhaw='+linhaw;

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

// 14.06.17 - devido a msg do arquivo ainda em uso...
      sleep(1000);

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
      end else Aviso('Lista para impress�o vazia');
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

    AcbrNFe1.DANFE := TACBrNFeDANFCeFortesETQFAT.Create(AcbrNFe1);

    AcbrNfe1.DANFE.TipoDANFE := tiNFCE;

    if Global.usuario.outrosacessos[0510] then
      acbrnfe1.danfe.MostraPreview:=true
    else
      acbrnfe1.danfe.MostraPreview:=false;
// 22.08.17
    acbrnfe1.danfe.MargemEsquerda:=01;
    acbrnfe1.danfe.MargemDireita:=05;
    acbrnfe1.danfe.MargemSuperior:=18;
    acbrnfe1.danfe.MargemInferior:=10;


//    if FileExists( ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg' ) then
//      acbrnfe1.danfe.Logo:=ExtractFilePath( Application.ExeName ) + 'LogoBalanca.jpg';
    s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPETQCAM');
    if trim(s)<>'' then Acbrnfe1.DANFE.Impressora:=s;

// 27.09.18
      if OP='D' then
         xtipo:=tipomovDE

      else if OP = 'T' then

         xtipo:=tipomovcong           
      else

         xtipo:='PC';

      Q1:=sqltoquery('select * from movabatedet'+
                     ' inner join movabate on ( movd_numerodoc=mova_numerodoc and movd_transacao=mova_transacao )'+
                     ' inner join estoque on ( esto_codigo=movd_esto_codigo )'+
                     ' inner join clientes on ( clie_codigo=movd_tipo_codigo )'+
                     ' where mova_transacaogerada = '+EdNumerodoc.assql+
//                     ' and movd_tipomov='+stringtosql('EA')+
                     ' and movd_tipomov='+stringtosql( xtipo )+
                     ' and mova_tipomov='+stringtosql( xtipo )+
                     ' and movd_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                     sqlordem+
                     ' and '+FGeral.GetIN('movd_status','N','C')+
                     ' order by movd_ordem' );

    if Q1.Eof then Avisoerro('N�o encontrado transacao gerada ref. '+EdNumerodoc.Text);

    while not Q1.eof do begin

      with  ACBrNFe1.NotasFiscais.Add.NFe do begin

        Total.ICMSTot.vBC   := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Total.ICMSTot.vProd := Q1.fieldbyname('movd_pesovivo').ascurrency;
        Emit.xFant          := FCadcli.GetNome(codigocliente);
        Emit.xNome          := FCadcli.GetRazaoSocial(codigocliente);
        Emit.CNPJCPF        := 'DESOSSA';   // FCadcli.GetCnpjCpf(codigocliente);
        Emit.EnderEmit.xLgr := Q1.fieldbyname('clie_endres').asstring;
        Emit.EnderEmit.nro  := '';
        Emit.EnderEmit.xCpl := '';
        codmuniemitente     := FCidades.GetCodigoIBGE( FUnidades.GetCidaCodigo(Global.CodigoUnidade) );
        Ide.cUF             := strtoint(copy(codmuniemitente,1,2));
// 21.08.17
        Ide.cNF             := NumeroRomaneio;
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
            {
// nao e aqui e sim no abate...'
// 17.09.18 - para identificar as classifacacoes 'piores'
            if AnsiPos(trim(Q1.fieldbyname('movd_esto_codigo').asstring),'102;103;104') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' HOL'
            else if AnsiPos(trim(Q1.fieldbyname('movd_esto_codigo').asstring),'446;48;369') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' CIS'
            else if AnsiPos(trim(Q1.fieldbyname('movd_esto_codigo').asstring),'453;345;393') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' BAT'
            else if AnsiPos(trim(Q1.fieldbyname('movd_esto_codigo').asstring),'71;96;167') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' SC'
            else if AnsiPos(trim(Q1.fieldbyname('movd_esto_codigo').asstring),'106;84;45') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' SC1'
            else if AnsiPos(trim(Q1.fieldbyname('movd_esto_codigo').asstring),'108;24;62') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' SC2'
            else if AnsiPos(trim(Q1.fieldbyname('movd_esto_codigo').asstring),'75') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' HSC'
            else if AnsiPos(trim(Q1.fieldbyname('movd_esto_codigo').asstring),'442') > 0 then
               Prod.xProd   := trim(Q1.fieldbyname('esto_descricao').asstring)+' SCB' ;

               }

            totalpeso:=totalpeso+Q1.fieldbyname('movd_pesocarcaca').asfloat;
            Prod.cProd   := Q1.fieldbyname('movd_esto_codigo').asstring;
//            Prod.cProd   := Q1.fieldbyname('movd_ordem').asstring;
// 08.05.17
            if casado then
              Prod.xPed    := EdNumerodoc.text
            else
              Prod.xPed    := Q1.fieldbyname('movd_operacao').asstring;
// 10.07.17
            if Q1.FieldByName('esto_validade').AsInteger >0 then
              Prod.NCM:=inttostr( Q1.FieldByName('esto_validade').AsInteger )
            else
              Prod.NCM:='';

            if OP = 'T' then  begin
               Prod.NCM:='180';
               Prod.uCom:='Carne Congelada De Bovino Com Osso';
            end;

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
// 19.09.17
              if QNutri.FieldByName('nutr_validade').AsInteger >0 then
                Prod.NCM:=inttostr( QNutri.FieldByName('nutr_validade').AsInteger )
              else
                Prod.NCM:='';
              if OP = 'T' then Prod.NCM:='180';

            end;
            QNutri.Close;
//            QConserva:=sqltoquery('select * from conservacao where cons_codigo='+inttostr(Q1.FieldByName('esto_cons_codigo').AsInteger));
// 27.05.20  - Novicarnes - dica do vanderlei esto_cons_codigores
            QConserva:=sqltoquery('select * from conservacao where cons_codigo='+inttostr(Q1.FieldByName('esto_cons_codigores').AsInteger));
            if not Qconserva.Eof then begin
              Prod.uCom:=QConserva.FieldByName('cons_linha1').AsString;
// 09.08.19
              if OP = 'T' then
                 Prod.uCom:='Carne Congelada de Bovino Com Osso';

            end;
            Qconserva.Close;
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

        if Global.Usuario.OutrosAcessos[0517] then  begin

           ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe )

        end else if trim(arquivoetiq)<>'' then
          ImprimeEtiqueta( arquivoetiq,ACBrNFe1.NotasFiscais.Items[i].NFe )
        else
          aviso( 'n�o encontrado arquivo do codigo '+ACBrNFe1.NotasFiscais.Items[i].NFe.Det.Items[0].Prod.cProd );

//          aviso('imprimiu primeira do '+ACBrNFe1.NotasFiscais.Items[i].NFe.Det.Items[0].Prod.cProd);
         sleeP(2000);  // senao da i/o error

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
