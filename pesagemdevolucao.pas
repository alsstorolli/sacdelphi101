
// 05.10.17
// Pesagem das carnes devolvidas pelos clientes para retornar ao estoque
//

unit pesagemdevolucao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrDFe, ACBrNFe, ACBrBase, ACBrBAL,
  Vcl.StdCtrls, Vcl.Grids, SqlDtg, Vcl.Mask, SQLEd, Vcl.Buttons, SQLBtn, alabel,
  Vcl.ExtCtrls, SQLGrid, SqlFun, SqlExpr, SqlSis,pcnconversao, AcbrDevice,
  ACBrDANFCeFortesFrETQFAT,ACBrDANFCeFortesFrEA,AcbrDeviceSerial;

type
  TFPesagemDevolucao = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bimpetiqueta: TSQLBtn;
    blebalanca: TSQLBtn;
    bexcluipesagem: TSQLBtn;
    bretnropedido: TSQLBtn;
    EdSeqi: TSQLEd;
    EdSeqf: TSQLEd;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    GridItens: TSqlDtGrid;
    PRemessa: TSQLPanelGrid;
    PIns: TSQLPanelGrid;
    EdPeso: TSQLEd;
    PPeso: TSQLPanelGrid;
    StaticText3: TStaticText;
    pNomeProduto: TSQLPanelGrid;
    EdPecas: TSQLEd;
    EdProduto: TSQLEd;
    EdProdutoven: TSQLEd;
    PPedidos: TSQLPanelGrid;
    GridPedido: TSqlDtGrid;
    PTotais: TSQLPanelGrid;
    PTotalPesado: TSQLPanelGrid;
    PValorTotal: TSQLPanelGrid;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    ppesobalanca: TSQLPanelGrid;
    AcbrBal1: TACBrBAL;
    ACBrBAL2: TACBrBAL;
  //  ACBrNFe1: TACBrNFe;
    EdTipo_codigo: TSQLEd;
    SQLEd1: TSQLEd;
    EdNumerodoc: TSQLEd;
    ACBrNFe1: TACBrNFe;
    bdevtotal: TSQLBtn;
    EdDataVazia: TSQLEd;
    procedure bSairClick(Sender: TObject);
    procedure bexcluipesagemClick(Sender: TObject);
    procedure bretnropedidoClick(Sender: TObject);
    procedure blebalancaClick(Sender: TObject);
    procedure bimpetiquetaClick(Sender: TObject);
    procedure EdSeqfExitEdit(Sender: TObject);
    procedure EdTipo_codigoValidate(Sender: TObject);
    procedure EdTipo_codigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridPedidoClick(Sender: TObject);
    procedure GridPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdPecasValidate(Sender: TObject);
    procedure EdPecasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bdevtotalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure Execute;
    Procedure ZeraCampos;
    procedure ConfiguraBalancas;
    function  AbrirPorta(qbalanca:string):boolean;
    procedure Queryitenstogrid(produto:string ; pecas:currency);
    procedure ConfiguraTeclas( Key: Word );
    procedure AtualizaValores;
    procedure SetaGridEntradasAbate;
    procedure GravaPeso;
    procedure GravaMestre(op:string;Q:Tsqlquery);
    procedure GravaItem(op:string;Q:Tsqlquery);
    procedure ImpEtiqueta(OP:string='Imp');
  end;

var
  FPesagemDevolucao: TFPesagemDevolucao;
  QPedido,QSaida:TSqlquery;
  Sqltipomov,Unidade,Transacao,OperacaoPesada,ChecaCodBarra:string;
  DataPedido:TDatetime;
  Temgrid:boolean;
  Seq,CodigoCliente:integer;
  Tara,PesoBalanca:Currency;
  campobal,CampoVen,campoopr:TDicionario;

const tipomov:string='DA';   // devolucao para camara fria

implementation

{$R *.dfm}

uses geral, pcnNFe, Estoque, cadcli, munic, Unidades, impressao;

{ TFPesagemDevolucao }


function TFPesagemDevolucao.AbrirPorta(qbalanca: string): boolean;
/////////////////////////////////////////////////////////////////
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

procedure TFPesagemDevolucao.AtualizaValores;
///////////////////////////////////////////////
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
       valor:=qtde*unitario;
       valortotal:=valortotal+valor;
//       GridPedido.cells[GridPedido.Getcolumn('pesopesado'),r]:=FormatFloat(f_cr3,qtde);
//       GridPedido.cells[GridPedido.Getcolumn('total'),r]:=FormatFloat(f_cr,valor)
     end;
  end;
  PTotalPesado.caption:=FormatFloat(f_cr3,pesototal);
  PValorTotal.caption:=FormatFloat(f_cr,valortotal);

end;

procedure TFPesagemDevolucao.bexcluipesagemClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////
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
// 04.07.17 - liberar a etiqueta para nova pesagem
    Sistema.Edit('movabatedet');
    Sistema.SetField('movd_pesobalanca',0);
    Sistema.Post('movd_operacao='+Stringtosql(GridItens.Cells[GridItens.getcolumn('movd_oprastreamento'),GridItens.row])+
                 ' and movd_tipomov='+Stringtosql('PC')+
                 ' and movd_unid_codigo='+Stringtosql(unidade)+
                 ' and movd_status='+Stringtosql('N')
                 );
///////////////
    Sistema.Commit;
//    GridItens.DeleteRow(GridItens.row);
//    AtualizaValores;
  except
    Avisoerro('Não foi possível excluir.  Verificar');
  end;
end;

procedure TFPesagemDevolucao.bimpetiquetaClick(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
   EdSeqi.Visible:=true;
   EdSeqf.Visible:=true;
   EdSeqi.text:='1';
   EdSeqf.text:='1';
   EdSeqi.setfocus;

end;

procedure TFPesagemDevolucao.blebalancaClick(Sender: TObject);
///////////////////////////////////////////////////////////////
var balanca:string;
    PesoPedido:currency;
begin
   if EdTipo_codigo.asinteger=0 then begin
     EdNumerodoc.invalid('Codigo do cliente está zerado');
     exit;
   end;
   if trim(GridPedido.cells[0,1])='' then begin
     Avisoerro('Sem itens no pedido');
     exit;
   end;
   EdProdutoven.Enabled:=false;
   EdProduto.text:=GridItens.Cells[GridItens.GetColumn('move_oprastreamento'),GridItens.Row];
   EdProdutoven.text:=GridItens.Cells[GridItens.GetColumn('move_esto_codigo'),GridItens.Row];
   EdPecas.Enabled:=true;
   EdNumerodoc.Text:=GridPedido.Cells[GridPedido.GetColumn('moes_numerodoc'),GridPedido.Row];
   if Global.Usuario.OutrosAcessos[0512] then begin
//     EdProduto.text:='';
     EdPecas.setfocus;
// 24.05.17
   end else if (Global.Usuario.OutrosAcessos[0516] )   then begin
     EdProduto.Enabled:=true;
     EdProdutoven.Enabled:=true;
     EdProduto.setfocus;
   end else begin
     EdPecas.SetFocus;
     EdPecas.text:='';
   end;
   if not EdProduto.IsEmpty then
     EdProduto.Next;

end;

procedure TFPesagemDevolucao.bretnropedidoClick(Sender: TObject);
////////////////////////////////////////////////////////////////////
begin
   EdTipo_codigo.setfocus;

end;

procedure TFPesagemDevolucao.bSairClick(Sender: TObject);
//////////////////////////////////////////////////////////
begin
  if AcbrBal1.Ativo then AcbrBal1.Desativar;
  if AcbrBal2.Ativo then AcbrBal2.Desativar;
  close;
//  if Global.Usuario.OutrosAcessos[0054] then Application.Terminate;

end;

procedure TFPesagemDevolucao.ConfiguraBalancas;
////////////////////////////////////////////////



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

begin

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

procedure TFPesagemDevolucao.ConfiguraTeclas(Key: Word);
/////////////////////////////////////////////////////////
begin
 if key = vk_f4 then blebalancaClick(self)
 else if key = vk_f5 then bimpetiquetaClick(self)
 else if key = vk_f3 then bretnropedidoClick(self)
 else if key = vk_f6 then bSairClick(self)
// else if key = vk_f10 then bgeranotaClick(self)
// else if key = vk_f11 then bromaneioClick(self)
// else if key = VK_Back then bnotaspendentesclick(self)
 else if key = vk_f2 then bexcluipesagemClick(self);

end;

// 24.10.17
procedure TFPesagemDevolucao.EdPecasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ConfiguraTeclas(key);
end;

procedure TFPesagemDevolucao.EdPecasValidate(Sender: TObject);
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
   if Edpecas.AsInteger>Texttovalor(GridItens.Cells[GridItens.GetColumn('move_pecas'),GridItens.row]) then begin
     EdPecas.Invalid('Quantidade de peças inválida');
     exit;
   end;

   EdPeso.text:='';
// 24.10.17 - só pra testes sem usar balança
   EdPeso.setvalue( Texttovalor(GridItens.cells[GridItens.getcolumn('move_qtde'),GridItens.row])/
                    Texttovalor(GridItens.cells[GridItens.getcolumn('move_pecas'),GridItens.row])
                   );


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

    Pesobalanca:=EdPeso.ascurrency;
    QE:=Sqltoquery('select esto_qbalanca,esto_tara,esto_peso from estoque where esto_codigo='+
                    EdProdutoven.Assql );
    balanca:=QE.fieldbyname('esto_qbalanca').asstring;
    Tara:=QE.fieldbyname('esto_tara').ascurrency*EdPecas.ascurrency;
    PesoEstoque:=QE.fieldbyname('esto_peso').ascurrency;
// 16.05.14 - cortes que usam gancho
//    if pos( GridPedido.cells[GridPedido.getcolumn('mpdd_esto_codigo'),GridPedido.row] ,FGeral.GetConfig1AsString('Codigoscomgancho') ) >0 then
// 01.09.14
    if UsaGancheira( EdProdutoven.Text ) then begin
       PesoBalanca:=Pesobalanca-FGeral.GetConfig1AsFloat('DESCPESO');
// 10.06.15
       if UsaGancheiraMenos1( EdProdutoven.Text ) then begin
         tara:=tara+(FGeral.GetConfig1AsFloat('DESCPESOGANCHO')*(Edpecas.AsCurrency-1))+FGeral.GetConfig1AsFloat('DESCPESO');
         PesoBalanca:=Pesobalanca + (Edpecas.ascurrency*FGeral.GetConfig1AsFloat('DESCPESOGANCHO')) +
                      FGeral.GetConfig1AsFloat('DESCPESOGANCHO');
       end else
        tara:=tara+(FGeral.GetConfig1AsFloat('DESCPESOGANCHO')*Edpecas.AsCurrency)+FGeral.GetConfig1AsFloat('DESCPESO');
    end;

    Ppesobalanca.caption:=FGeral.Formatavalor(pesobalanca,f_cr);
    FGeral.FechaQuery(QE);
    if Global.Usuario.OutrosAcessos[0509] then begin
      abrirporta( balanca );
      if (balanca='BAL1') or ( trim(balanca)='') then begin
        try
          AcbrBal1.LePeso( 500 );
        except
        end;
      end else
        AcbrBal2.LePeso( 500 );
    end;

    if EdPeso.ascurrency>=0 then begin
// 13.06.17
       pesobalanca:=EdPeso.AsCurrency;
       EdPeso.setvalue( EdPeso.ascurrency - tara );
    end;

   PesoPedido:=TextToValor( GridItens.cells[GridItens.getcolumn('move_qtde'),GridItens.row] );
   if (EdPeso.ascurrency>0) then PPeso.caption:=TRansform( EdPeso.ascurrency, f_cr3 );
   if Global.Usuario.OutrosAcessos[0509] then begin
      if EdPeso.ascurrency>0 then GravaPeso;
    end;

    Pmens.Caption:=pmens.Caption+' '+transform(tara,f_cr);

    AcbrBal1.Desativar;
    AcbrBal2.Desativar;

////////////////////////////////////////////
end;

procedure TFPesagemDevolucao.EdProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   Configurateclas(key);
end;

procedure TFPesagemDevolucao.EdSeqfExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////
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
// codigo de barra
// 25.10.17
            Prod.xPed    := GridItens.Cells[griditens.GetColumn('move_oprastreamento'),GridItens.Row];

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

// 20.10.17
procedure TFPesagemDevolucao.EdTipo_codigoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  configurateclas(key);
end;

procedure TFPesagemDevolucao.EdTipo_codigoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////
begin

   SetaGridEntradasAbate;
   GridPedido.SetFocus;

end;

procedure TFPesagemDevolucao.Execute;
///////////////////////////////////////
begin

   EdTipo_Codigo.ClearAll(FPesagemDevolucao,99);
   GridPedido.clear;
   GridItens.clear;
   ZeraCampos;

   ConfiguraBalancas;
   if Global.Usuario.OutrosAcessos[0509] then
     abrirporta( 'BAL1' );

   Unidade:=Global.CodigoUnidade;
//   FPesagemDevolucao.WindowState:=wsMaximized;
   FGeral.ConfiguraColorEditsNaoEnabled(FPesagemDevolucao);
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

   EdTipo_codigo.setfocus;
end;

///// 24.10.17
procedure TFPesagemDevolucao.GravaItem(op: string; Q: Tsqlquery);
/////////////////////////////////////////////////////////////////
var linha:integer;
begin

     if op='I' then begin
        Sistema.Insert('movabatedet');
        Sistema.SetField('movd_esto_codigo',EdProdutoven.Text);
        Sistema.SetField('movd_transacao',transacao);
        Sistema.SetField('movd_operacao',copy(transacao,1,9)+strzero(GridItens.Row,3) );
        Sistema.SetField('movd_numerodoc',Ednumerodoc.Asinteger);
        Sistema.SetField('movd_status','N');
        Sistema.SetField('movd_tipomov',TipoMov);
        Sistema.SetField('movd_unid_codigo',Unidade);
        Sistema.SetField('movd_tipo_codigo',Edtipo_codigo.AsInteger);
        Sistema.SetField('movd_pesocarcaca',EdPeso.AsCurrency);
        Sistema.SetField('movd_vlrarroba',Texttovalor(GridItens.cells[GridItens.getcolumn('move_venda'),GridItens.row]));
//        Sistema.SetField('movd_obs',Grid.cells[Grid.getcolumn('movd_obs'),linha]);
        Sistema.SetField('movd_ordem',1);
        Sistema.SetField('movd_pecas',Edpecas.AsInteger);
        if Campobal.Tipo<>'' then Sistema.SetField('movd_pesobalanca',Pesobalanca);
        if Campoven.Tipo<>'' then Sistema.SetField('movd_esto_codigoven',EdProdutoven.text);
        if not EdProduto.IsEmpty then begin
          if Campoopr.Tipo<>'' then Sistema.SetField('movd_oprastreamento',EdProduto.text);
        end;
        Sistema.SetField('movd_datamvto',Sistema.Hoje);

        Sistema.Post('');

     end else begin

        Sistema.Edit('movabatedet');
        Sistema.SetField('movd_tipo_codigo',EdTipo_codigo.AsInteger);
//        Sistema.SetField('movd_tipocad','C');
//        Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),linha]);
//        Sistema.SetField('movd_idade',Grid.cells[Grid.getcolumn('movd_idade'),linha]);
//        Sistema.SetField('movd_pesovivo',Texttovalor(Grid.cells[Grid.getcolumn('movd_pesovivo'),linha]));
        Sistema.SetField('movd_pesocarcaca',EdPeso.AsCurrency);
        Sistema.SetField('movd_vlrarroba',Texttovalor(GridItens.cells[GridItens.getcolumn('move_venda'),GridItens.row]));
        Sistema.SetField('movd_pecas',Edpecas.AsInteger);
        if Campobal.Tipo<>'' then Sistema.SetField('movd_pesobalanca',Pesobalanca);
        if Campoven.Tipo<>'' then Sistema.SetField('movd_esto_codigoven',EdProdutoven.text);
        if not EdProduto.IsEmpty then begin
          if Campoopr.Tipo<>'' then Sistema.SetField('movd_oprastreamento',EdProduto.text);
        end;
        Sistema.Post('movd_numerodoc='+EdNumerodoc.AsSql+
                     ' and movd_esto_codigo='+EdProdutoven.AsSql+
                     ' and movd_tipomov='+Stringtosql(TipoMov)+
                     ' and movd_status=''N''');
     end;

     if not EdProduto.IsEmpty then begin

        Sistema.Edit('movabatedet');
        Sistema.SetField('movd_pesobalanca',0);
        Sistema.Post('movd_operacao='+Stringtosql(EdProduto.Text)+
                     ' and movd_tipomov='+Stringtosql('PC')+
                     ' and movd_status=''N''');
     end;

     EdProduto.Text:='';

end;

procedure TFPesagemDevolucao.GravaMestre(op: string; Q: Tsqlquery);
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
    Sistema.SetField('mova_tipo_codigo',Edtipo_codigo.AsInteger);
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
//    Sistema.SetField('mova_tran_codigo',EdTran_codigo.text);
//    Sistema.SetField('mova_fpgt_codigo',QPedido.fieldbyname('mped_fpgt_codigo').AsString);
///////////
    Sistema.SetField('Mova_repr_codigo',EdTipo_codigo.ResultFind.fieldbyname('clie_repr_codigo').AsInteger);
    Sistema.SetField('Mova_vlrtotal',Texttovalor(PValortotal.caption));
    Sistema.SetField('Mova_perccomissao',0);
///////////
    Sistema.Post();

  end else begin

    Transacao:=Q.fieldbyname('mova_transacao').asstring;
    Sistema.Edit('Movabate');
    Sistema.SetField('mova_tipo_codigo',Edtipo_codigo.AsInteger);
    Sistema.SetField('mova_pesocarcaca',texttovalor(pTotalPesado.caption));
    Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
//    Sistema.SetField('mova_perc',EdPerc.ascurrency);
//    Sistema.SetField('mova_tran_codigo',EdTran_codigo.text);
//    Sistema.SetField('mova_fpgt_codigo',QPedido.fieldbyname('mped_fpgt_codigo').AsString);
///////////
    Sistema.SetField('Mova_repr_codigo',EdTipo_codigo.ResultFind.fieldbyname('clie_repr_codigo').AsInteger);
    Sistema.SetField('Mova_vlrtotal',Texttovalor(PValortotal.caption));
//    Sistema.SetField('Mova_perccomissao',EdPercComissao.ascurrency);
///////////
    Sistema.Post('mova_transacao='+stringtosql(transacao));
  end;
end;

procedure TFPesagemDevolucao.GravaPeso;
//////////////////////////////////////////////
var Q:TSqlquery;
    sqldata,sqltipomov,produto:string;

begin

  sqldata:=' and mova_dtabate >= '+Datetosql(DAtaPedido);
  Sqltipomov:=' and movd_tipomov='+Stringtosql( Tipomov );
  produto:=trim(EdProdutoven.Text);
  Q:=sqltoquery('select * from movabatedet inner join movabate on ( mova_transacao=movd_transacao )'+
                      ' where movd_numerodoc='+EdNumerodoc.assql+
                      ' and '+FGeral.Getin('movd_unid_codigo',Global.CodigoUnidade,'C')+
                      ' and movd_status=''N'''+
                      sqldata+sqltipomov );
//  AtualizaValores;
  if Q.Eof then begin // ainda nao pesou nada desta nfe sendo devolvida
     GravaMestre('I',Q) ;
//     Editstogrid(1);
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
//       EditstoGrid;
     GravaItem('I',Q);  // item novo dentro de pedido ja começado com outros itens
     GravaMestre('A',Q);
  end;
  Sistema.EndProcess('');
  try
    Sistema.Commit;
/////////////////////    Impetiqueta('Inc');
  except
    Avisoerro('Nada gravado.   Problemas na gravação no banco de dados');
  end;
 // AtualizaValores;
  GridPedido.setfocus;

end;

procedure TFPesagemDevolucao.GridItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Configurateclas(key);
end;

procedure TFPesagemDevolucao.GridPedidoClick(Sender: TObject);
///////////////////////////////////////////////////////////////////
var Q1,Qa:TSqlquery;
    xtransacao,xnumero,xpedido:string;
    i:integer;
begin
   xtransacao:=GridPedido.Cells[GridPedido.GetColumn('moes_transacao'),GridPedido.Row];
   xnumero:=GridPedido.Cells[GridPedido.GetColumn('moes_numerodoc'),GridPedido.Row];
   xpedido:=GridPedido.Cells[GridPedido.GetColumn('moes_pedido'),GridPedido.Row];
   if trim(xtransacao)<>'' then begin
     Q1:=sqltoquery('select move_operacao,move_esto_codigo,move_qtde,move_pecas,move_venda,esto_descricao from movestoque'+
                    ' inner join estoque on (esto_codigo=move_esto_codigo)'+
                    ' where move_transacao = '+Stringtosql(xtransacao)+
                    ' and move_status = ''N'''+
                    ' and move_numerodoc = '+stringtosql(xnumero)+
                    ' and move_unid_codigo = '+Stringtosql(Global.CodigoUnidade));
     GridItens.Clear;
     i:=1;
     while not Q1.Eof do begin
       GridItens.Cells[griditens.GetColumn('move_esto_codigo'),i]:=Q1.FieldByName('move_esto_codigo').AsString;
       GridItens.Cells[griditens.GetColumn('esto_descricao'),i]:=Q1.FieldByName('esto_descricao').AsString;
       GridItens.Cells[griditens.GetColumn('move_pecas'),i]:=Q1.FieldByName('move_pecas').AsString;
       GridItens.Cells[griditens.GetColumn('move_qtde'),i]:=Q1.FieldByName('move_qtde').AsString;
       GridItens.Cells[griditens.GetColumn('move_venda'),i]:=Q1.FieldByName('move_venda').AsString;
       QA:=sqltoquery('select movd_oprastreamento from movabatedet where movd_tipomov=''SA'''+
                       ' and movd_status = ''N'''+
                       ' and movd_numerodoc = '+(xpedido)+
                       ' and movd_esto_codigo = '+Stringtosql(Q1.FieldByName('move_esto_codigo').AsString)+
                       ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade));
       if not QA.eof then
         GridItens.Cells[griditens.GetColumn('move_oprastreamento'),i]:=QA.FieldByName('movd_oprastreamento').AsString
       else
         GridItens.Cells[griditens.GetColumn('move_oprastreamento'),i]:='';
       GridItens.AppendRow;
       inc(i);
       Q1.Next;
       FGeral.Fechaquery(Qa);
     end;
     FGeral.fechaquery(Q1);
   end;

end;

procedure TFPesagemDevolucao.GridPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ConfiguraTeclas(key);
end;

// 24.10.17
procedure TFPesagemDevolucao.ImpEtiqueta(OP: string);
////////////////////////////////////////////////////////////////////////////
var produto,sql,ordem:string;
begin
  if trim( GridItens.cells[GridItens.getcolumn('move_esto_codigo'),GridItens.row] )='' then begin
    Avisoerro('Nenhum peso indicado');
    exit;
  end;
  produto:=EdProdutoven.text;
  if op='Imp' then
//    ordem:=Inttostr( strtoint( GridItens.cells[GridItens.getcolumn('movd_seq'),GridItens.row] ) )
    ordem:='1'
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

procedure TFPesagemDevolucao.Queryitenstogrid(produto: string; pecas: currency);
//////////////////////////////////////////////////////////////////////////////////
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
//   PNomeProduto.caption:=FEstoque.GetDescricao(produto);
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
            GridItens.cells[GridItens.getcolumn('movd_pecas'),x]:=formatfloat(f_cr,QSaida.fieldbyname('movd_pecas').asfloat);
            vlritem:=QSaida.fieldbyname('movd_pesocarcaca').asfloat*QSaida.fieldbyname('movd_vlrarroba').asfloat;
            if trim(QSaida.fieldbyname('movd_ordem').Asstring)<>'' then
              GridItens.Cells[gridItens.getcolumn('movd_seq'),x]:=strzero(strtoint(QSaida.fieldbyname('movd_ordem').Asstring),3)
            else
              GridItens.Cells[gridItens.getcolumn('movd_seq'),x]:=strzero(QSaida.fieldbyname('movd_ordem').Asinteger,3);
            GridItens.cells[GridItens.getcolumn('movd_oprastreamento'),x]:=QSaida.fieldbyname('movd_oprastreamento').asstring;
            inc(x);
            GridItens.appendrow;
            qtde:=qtde+QSaida.fieldbyname('movd_pesocarcaca').asfloat;
            valor:=valor+vlritem;
            QSaida.Next;
   end;

end;

// 20.10.17
procedure TFPesagemDevolucao.SetaGridEntradasAbate;
////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    Datainicial:TDatetime;
    p,
    dias       :integer;
begin

   dias:=20;
   DataInicial:=sistema.hoje-dias;
   Q:=sqltoquery('select moes_numerodoc,moes_tipo_codigo,moes_dataemissao,moes_vlrtotal,moes_transacao,moes_pedido from movesto '+
                 ' where '+FGeral.Getin('moes_status','N','C')+
                 ' and '+FGeral.GetIN('moes_tipomov',Global.TiposSaida,'C')+
                 ' and moes_datacont > '+DateToSql(Global.DataMenorBanco)+
                 ' and moes_dataemissao >= '+Datetosql(Datainicial)+
                 ' and moes_tipo_codigo = '+EdTipo_codigo.AsSql+
                 ' and moes_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                 ' order by moes_numerodoc');
   GridPedido.Clear;
   GridItens.Clear;
   p:=1;
   if Q.Eof then begin

      Aviso('Não encontrado notas para este cliente nos últimos '+inttostr(dias)+' dias');

   end;

   while not Q.Eof do begin

      GridPedido.Cells[GridPedido.GetColumn('moes_numerodoc'),p]:=strzero(Q.fieldbyname('moes_numerodoc').asinteger,8);
      GridPedido.Cells[GridPedido.GetColumn('moes_dataemissao'),p]:=FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime);
      GridPedido.Cells[GridPedido.GetColumn('moes_vlrtotal'),p]:=FGeral.Formatavalor(Q.fieldbyname('moes_vlrtotal').ascurrency,f_cr);
      GridPedido.Cells[GridPedido.GetColumn('moes_transacao'),p]:=Q.fieldbyname('moes_transacao').asstring;
      GridPedido.Cells[GridPedido.GetColumn('moes_pedido'),p]:=Q.fieldbyname('moes_pedido').asstring;

     Q.Next;
     GridPedido.AppendRow;
     inc(p);

   end;

   fGeral.fechaquery(Q);
   EdTipo_codigo.SetFocus;

end;

procedure TFPesagemDevolucao.bdevtotalClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////
var pedido   : string;

begin

  pedido:=trim(GridPedido.Cells[GridPedido.getcolumn('moes_pedido'),GridPedido.row]);
  if pedido='' then exit;
  if not confirma('Confirma DEVOLUÇÃO TOTAL deste pedido ?') then exit;

          Sistema.Edit('movpeddet');
          Sistema.setfield('mpdd_situacao','P');
          Sistema.setfield('mpdd_qtdeenviada',0);
          Sistema.setfield('mpdd_dataenviada',EdDAtavazia.AsDate);
          Sistema.setfield('mpdd_nfvenda',0);
          Sistema.setfield('mpdd_datanfvenda',EdDAtavazia.AsDate);
          Sistema.post('mpdd_numerodoc='+pedido+
                       ' and mpdd_status=''N'''+
                       ' and mpdd_tipo_codigo='+EdTipo_codigo.AsSql+
                       ' and mpdd_unid_codigo='+Stringtosql(Global.codigounidade));

          Sistema.Edit('movped');
          Sistema.setfield('mped_situacao','P');
          Sistema.setfield('mped_nfvenda',0);
          Sistema.setfield('mped_datanfvenda',EdDAtavazia.AsDate);
          Sistema.setfield('mped_transacaovenda','');
          Sistema.post('mped_numerodoc='+pedido+
                       ' and mped_status=''N'''+
                       ' and mped_tipo_codigo='+EdTipo_codigo.AsSql+
                       ' and mped_unid_codigo='+Stringtosql(Global.codigounidade));

     try

       Sistema.Commit;
       Aviso('Pedido liberado');

     except on E:exception do begin

       Aviso('Não foi possível gravar no banco de dados. '+E.Message);

     end;

     end;

end;

procedure TFPesagemDevolucao.ZeraCampos;
/////////////////////////////////////////
begin
   PTotalPesado.caption:='';
   PValorTotal.caption:='';
   tara:=0;

end;

end.
