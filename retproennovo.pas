unit retproennovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn,
  alabel, ExtCtrls, SQLGrid, SqlExpr, Sqlfun;

type
  TFRetprontaentreganovo = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bIncluiritem: TSQLBtn;
    bExcluiritem: TSQLBtn;
    bCancelaritem: TSQLBtn;
    bConfirma: TSQLBtn;
    bSaldo: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PSaldo: TSQLPanelGrid;
    bfechar: TSQLBtn;
    GridSaldo: TSqlDtGrid;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdRepr_codigo: TSQLEd;
    SetEdrepr_NOME: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdRemessas: TSQLEd;
    cb: TCheckListBox;
    StaticText1: TStaticText;
    EdDtMovimento: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    PPedidos: TSQLPanelGrid;
    EdCliente: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdNropedido: TSQLEd;
    EdEmissaopedido: TSQLEd;
    bGravapedido: TSQLBtn;
    EdUnitario: TSQLEd;
    EdValorvenda: TSQLEd;
    bfechamento: TSQLBtn;
    EdTipoMov: TSQLEd;
    Pcodigos: TSQLPanelGrid;
    GridCodigos: TSqlDtGrid;
    EdValorvendatotal: TSQLEd;
    EdMovimento: TSQLEd;
    PAux: TSQLPanelGrid;
    Edfpgt_codigo: TSQLEd;
    Edperdesco: TSQLEd;
    EdVlrdesco: TSQLEd;
    PParcelas: TSQLPanelGrid;
    GridParcelas: TSqlDtGrid;
    EdParcela: TSQLEd;
    EdVencimento: TSQLEd;
    EdEnviado: TSQLEd;
    EdDevolvido: TSQLEd;
    EdVenda: TSQLEd;
    EdSaldopecas: TSQLEd;
    EdSobra: TSQLEd;
    EdFalta: TSQLEd;
    Edvp: TSQLEd;
    Edvb: TSQLEd;
    Eddp: TSQLEd;
    EdVendagrid: TSQLEd;
    EdPort_codigo: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    EdCodcopa: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure EdRepr_codigoValidate(Sender: TObject);
    procedure bIncluiritemClick(Sender: TObject);
    procedure bExcluiritemClick(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure EdQtdeValidate(Sender: TObject);
    procedure EdUnitarioExitEdit(Sender: TObject);
    procedure EdRemessasValidate(Sender: TObject);
    procedure bSaldoClick(Sender: TObject);
    procedure EdEmissaopedidoValidate(Sender: TObject);
    procedure bfecharClick(Sender: TObject);
    procedure bGravapedidoClick(Sender: TObject);
    procedure EdNropedidoValidate(Sender: TObject);
    procedure EdFpgt_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure bConfirmaClick(Sender: TObject);
    procedure cbClickCheck(Sender: TObject);
    procedure bfechamentoClick(Sender: TObject);
    procedure EdClienteValidate(Sender: TObject);
    procedure EdDtMovimentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdFpgt_codigoExitEdit(Sender: TObject);
    procedure EdTipoMovValidate(Sender: TObject);
    procedure Edunid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure GridCodigosClick(Sender: TObject);
    procedure Edperdesco1Validate(Sender: TObject);
    procedure EdEmissaopedidoExitEdit(Sender: TObject);
    procedure GridParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure GridParcelasDblClick(Sender: TObject);
    procedure EdParcelaExitEdit(Sender: TObject);
    procedure EdVencimentoExitEdit(Sender: TObject);
    procedure Edfpgt_codigoValidate(Sender: TObject);
    procedure EdperdescoValidate(Sender: TObject);
    procedure EdVlrdescoValidate(Sender: TObject);
    procedure EdTipoMovKeyPress(Sender: TObject; var Key: Char);
    procedure cbDblClick(Sender: TObject);
    procedure EdCodtamanhoValidate(Sender: TObject);
    procedure EdCodcopaValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure EditstoGrid;
    function CalculaTotal:currency;
    procedure AtivaEditsParcelas;
    function ValorDesconto(valor:currency):currency;
  end;

// 27.10.11
type TCstPerc=record
     cst,tpimposto,cfop:string;
     perc,contabil,base,reducao,isentas,outras,basesubs:currency;
end;


var
  FRetprontaentreganovo: TFRetprontaentreganovo;
  QRemessas,QDevolucoes,QEstoque,QGrade:TSqlquery;
  QProdRemessa,QProdDevolvido,QSaidas,QProdRemessaFe,QProdDevolvidoFe:TMemoryquery;
  OP,PedidoGravado:string;
  Faturarepr,fechamento:boolean;
  tiposmov,tiposmovdev,produtoescolhido,tiposmovbai,RemessasOK:string;
  totalnota,totalnf,valorparteavista:currency;
  coddevnao:integer;
  ListaRemessasFechadas:TStringlist;
  PCstPerc:^TCstPerc;

implementation

uses Geral, SqlSis, Estoque, Grades, Arquiv, munic, conpagto, impressao,
  cadcor, tamanhos, cadcopa, codigosfis, Mensnf;

{$R *.dfm}

procedure TFRetprontaentreganovo.EditstoGrid;
/////////////////////////////////////////////////
var x:integer;
    aqtde:currency;
begin
  x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.GetColumn('codtamanho'),Edcodtamanho.asinteger,
                        Grid.getcolumn('codcor'),EdCodcor.asinteger,Grid.getcolumn('codcopa'),EdCodcopa.asinteger);
  if x<=0 then begin
// grid vazio
//    Result:=(Grid.RowCount=2) and (Trim(Grid.Cells[0,1])='');
    if (Grid.RowCount=2) and (Trim(Grid.Cells[0,1])='') then begin
       x:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       x:=Grid.RowCount-1;
    end;
//
    Grid.Cells[Grid.getcolumn('tipo'),Abs(x)]:=EdTipomov.text;

    Grid.Cells[Grid.getcolumn('move_esto_codigo'),Abs(x)]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;
    Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=EdQTde.AsSql;
    Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=transform(FGeral.Arredonda(EdUnitario.Ascurrency*EdQtde.ascurrency,2),f_cr);

    Grid.Cells[Grid.getcolumn('cor'),Abs(x)]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),Abs(x)]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
    Grid.Cells[Grid.getcolumn('copa'),Abs(x)]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),Abs(x)]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),Abs(x)]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('codcopa'),Abs(x)]:=EdCodcopa.text;

//
  end else begin
{
    Grid.Cells[0,x]:=EdProduto.Text;
    Grid.Cells[1,x]:=Arq.TEstoque.fieldbyname('esto_descricao').asstring;
    Grid.Cells[2,x]:=Transform(texttovalor(Grid.Cells[2,x])+EdQTde.Ascurrency,f_cr);
    Grid.Cells[4,x]:=FGeral.formatavalor(texttovalor(Grid.Cells[2,x])*texttovalor(Grid.Cells[3,x]),f_cr);
}
    Grid.Cells[Grid.getcolumn('tipo'),Abs(x)]:=EdTipomov.text;
    Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=SetEdEsto_descricao.text;
    aqtde:=EdQTde.Ascurrency+texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x]);
    Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=Valortosql(aqtde);
    Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=transform(FGeral.Arredonda(EdUnitario.Ascurrency*EdQtde.ascurrency,2),f_cr);

    Grid.Cells[Grid.getcolumn('cor'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
    Grid.Cells[Grid.getcolumn('copa'),x]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),x]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),x]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('codcopa'),x]:=EdCodcopa.text;

  end;
  EdValorVenda.setvalue(Calculatotal);
  Grid.Refresh;

end;

{
/////////////////////////////
var x:integer;

    function Procuragrid:integer;
    var x:integer;
    begin
      result:=0;
      for x:=1 to Grid.RowCount do begin
        if trim(Grid.Cells[0,x])<>'' then
           if ( trim(Grid.Cells[0,x])=trim(EdProduto.text) ) and (Grid.Cells[Grid.getcolumn('tipo'),x]=EdTipomov.text ) then begin
             result:=x;
             break;
           end;
      end;
    end;

begin
  x:=ProcuraGrid;
  if x<=0 then begin
// grid vazio
//    Result:=(Grid.RowCount=2) and (Trim(Grid.Cells[0,1])='');
    if (Grid.RowCount=2) and (Trim(Grid.Cells[0,1])='') then begin
       x:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       x:=Grid.RowCount-1;
    end;

    Grid.Cells[0,Abs(x)]:=EdProduto.Text;
    Grid.Cells[1,Abs(x)]:=SetEdesto_descricao.text;
    Grid.Cells[Grid.getcolumn('tipo'),Abs(x)]:=EdTipomov.text;
    Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=EdQTde.AsSql;
//    Grid.Cells[3,Abs(x)]:=FGeral.formatavalor(FEstoque.GetPreco(EdProduto.Text,EdUnid_codigo.Text),f_cr);
    Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=transform(FGeral.Arredonda(EdUnitario.Ascurrency*EdQtde.ascurrency,2),f_cr);
  end else begin
    Grid.Cells[0,x]:=EdProduto.Text;
    Grid.Cells[1,x]:=SetEdesto_descricao.text;
    Grid.Cells[Grid.getcolumn('tipo'),x]:=EdTipomov.text;
//    if FGeral.CodigoBarra(EdProduto.text) then
      Grid.Cells[Grid.getcolumn('move_qtde'),x]:=Transform(texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x])+EdQTde.Ascurrency,f_cr);
//    else
//      Grid.Cells[3,x]:=Transform(EdQTde.Ascurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=transform(FGeral.Arredonda(EdUnitario.Ascurrency*texttovalor(Grid.Cells[3,x]),2),f_cr);
  end;
  EdValorVenda.setvalue(Calculatotal);
  Grid.Refresh;
end;
//////////////////////
}

procedure TFRetprontaentreganovo.Execute;
begin
  tiposmov:=Global.CodVendaProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodVendaTransf+';'+Global.CodDevolucaoProntaEntrega;
// 08.04.05 - VT tem q ficar em aberto pra ser "pega" somente no acerto da consignaçao
//  tiposmovbai:=Global.CodVendaProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodDevolucaoProntaEntrega;
// 22.04.05
//  tiposmovbai:=Global.CodVendaProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodDevolucaoProntaEntrega+';'+Global.CodVendaTransf;
// 25.11.05
  tiposmovbai:=Global.CodVendaProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodDevolucaoProntaEntrega;
// 16.03.05
  tiposmovdev:=Global.CodVendaProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodDevolucaoProntaEntrega+';'+Global.CodVendaTransf;
// 27.09.05 - para nao pegar as VB q se referem a consignação...
  coddevnao:=54;
// 26.10.11 - retirado para nao fixar 'fixo' o codigo de conf.mov. 54  
  Gridsaldo.clear;
  Gridcodigos.clear;
  Psaldo.visible:=false;
  Pcodigos.visible:=false;
  EdUnid_codigo.text:=Global.CodigoUnidade;
  EdUNid_codigo.validfind;
  Show;
end;

procedure TFRetprontaentreganovo.FormActivate(Sender: TObject);
begin
  Grid.Clear;
  cb.clear;
  EdRemessas.Clear;
//  EdDtMovimento.SetDate(Sistema.Hoje);
// 27.09.10
  FGeral.setamovimento(EdDtmovimento);
  EdEmissaoPedido.SetDate(Sistema.Hoje);
  Op:='I';
  produtoescolhido:='';
  PedidoGravado:='N';
//  EdNroPedido.SetValue(FGeral.Getcontador('PEDPTAENTREGA'+Global.CodigoUnidade,false));
  EdNroPedido.SetValue(FGeral.Getcontador('PEDIDOPTAENTREGA',false));
  EdUnid_codigo.text:=Global.CodigoUnidade;
  EdUnid_codigo.validfind;
  EdRepr_codigo.SetFocus;
// 03.02.11
  if not Arq.TEstoque.active then Arq.TEstoque.open;

end;

procedure TFRetprontaentreganovo.EdRepr_codigoValidate(Sender: TObject);

   procedure QuerytoItens(Q:TSqlquery;Ed:TSqled;Chec:TCheckListbox);
   var num:integer;
       xremessas,s:string;
   begin
     Ed.Items.Clear;xremessas:='';
     Grid.Clear;
     Chec.Clear;
     while not Q.Eof do begin
       num:=Q.fieldbyname('moes_numerodoc').AsInteger;
       if pos(strzero(num,8),xremessas)=0 then begin
         xremessas:=xremessas+strzero(num,8)+';';
//         Ed.Items.Add(strzero(num,8)+' de '+Q.fieldbyname('moes_datamvto').AsString );
         Chec.Items.Add(strzero(num,8)+' de '+Q.fieldbyname('moes_datamvto').AsString);
       end;
       Q.Next;
     end;
     s:='';
     for num:=0 to chec.count-1 do begin
       chec.Checked[num]:=true;
       s:=s+copy(cb.Items[num],1,8)+';';
     end;
     if length(s)>EdRemessas.MaxLength then begin
       Avisoerro('Atenção !  Número máximo de remessas ultrapassado');
       EdRemessas.text:='';
     end else
       EdRemessas.Text:=s;
//     EdRemessas.Text:=s;

   end;

begin

  EdPerdesco.clearall(FRetprontaentregaNovo,99);
  Gridparcelas.clear;
  Fechamento:=false;

  if not FGeral.ValidaRepresentante(EdRepr_codigo) then
    EdRepr_codigo.Invalid('')
  else begin
    QRemessas:=Sqltoquery('select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,moes_repr_codigo,moes_tabp_codigo'+
//          ' from movesto,movestoque where moes_tipo_codigo='+EdRepr_codigo.AsSql+
            ' from movesto,movestoque where moes_repr_codigo='+EdRepr_codigo.AsSql+
            ' and moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodRemessaProntaEntrega)+
            ' and moes_transacao=move_transacao'+
            ' and moes_unid_codigo='+stringtosql(Global.codigounidade)+  // 16.03.05
            ' and moes_unid_codigo=move_unid_codigo'+
            ' and moes_status=move_status'+
            ' order by moes_datamvto,moes_numerodoc');
    if QRemessas.Eof then begin
      EdRepr_codigo.Invalid('Representante sem remessas em aberto');
    end else begin
      QuerytoItens(QRemessas,EdRemessas,Cb);
    end;
  end;
end;

procedure TFRetprontaentreganovo.bIncluiritemClick(Sender: TObject);
begin
  if not EdCliente.Asinteger=0 then exit;
  if Trim(EdRemessas.Text)='' then exit;
  if QProdRemessa=nil then exit;
//  bGravar.Enabled:=false;
  bGravapedido.enabled:=false;
  bSair.Enabled:=false;
  bSaldo.Enabled:=true;
  PINs.Visible:=true;
  PINs.EnableEdits;
  Edproduto.ClearAll(FRetprontaentregaNovo,99);
  EdProduto.SetFocus;

end;

procedure TFRetprontaentreganovo.bExcluiritemClick(Sender: TObject);
var codigoestoque:string;
    qtde,venda:currency;
begin
  if PIns.Visible then exit;
  if trim(Grid.Cells[0,Grid.row])='' then exit;
  if confirma('Confirma exclusão ?') then begin
    codigoestoque:=Grid.Cells[0,Grid.row];
    qtde:=texttovalor(Grid.Cells[2,Grid.row]);
    venda:=texttovalor(Grid.Cells[3,Grid.row]);
    Grid.DeleteRow(Grid.Row);
    EdValorvenda.setvalue(EdValorvenda.ascurrency-(QTde*venda));
///    if EdTipomov.text<>Global.CodVendaTransf then

    EdValorvendatotal.setvalue(EdValorvendatotal.ascurrency-(QTde*venda));
    
//    Edtotalremessa.SetValue(Calculatotal);
(*
    if OP='A' then begin
      ExecuteSql('Update movestoque set move_status=''C'' where move_status=''N'''+
          ' and move_numerodoc='+EdNumerodoc.AsSql+
          ' and move_tipomov='+Stringtosql(Global.CodRemessaConsig)+
          ' and move_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
          ' and move_tipo_codigo='+EdCliente.AsSql+
          ' and move_esto_codigo='+Stringtosql(codigoestoque)+
          ' and move_tipocad='+Stringtosql('C') );
      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,Global.CodigoUnidade,
             Global.CodRemessaConsig,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger);

    end;
    Sistema.Commit;
*)
  end;

end;

procedure TFRetprontaentreganovo.bCancelaritemClick(Sender: TObject);
begin
  if not Pins.Visible then exit;
//  bGravar.Enabled:=true;
  bGravaPedido.Enabled:=true;
//  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
//  bSaldo.Enabled:=false;
  PINs.Visible:=false;
  PINs.DisableEdits;
  PRemessa.Enabled:=true;
  EdCliente.SetFocus;

end;

procedure TFRetprontaentreganovo.EdProdutoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var QBusca,QEstoque,TEstoque:TSqlquery;
    codigobarra:boolean;
    codbarra:string;
begin
  if not FEstoque.ValidaCodigoProduto(EdProduto,EdProduto.text) then begin
    Edproduto.invalid('');
    exit;
  end;
  codigobarra:=false;
  codbarra:=EdProduto.text;
  EdUnitario.Enabled:=Global.Usuario.OutrosAcessos[0601];
// 09.03.16
  TEstoque:=sqltoquery('select * from estoque where esto_codigo='+EdProduto.assql);
  if FGeral.CodigoBarra(EdProduto.Text) then begin
    QBusca:=sqltoquery('select * from estoque where esto_Codbarra='+EdProduto.Assql);
    if not QBusca.Eof then begin
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString;
      Arq.TEstoque.locate('esto_codigo',EdProduto.text,[]);
      EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.CodigoUnidade));
    end;  //  tirado em 20.01.11 else
//      EdProduto.Invalid('Codigo de barra não encontrado');
//    FGeral.fechaquery(QBusca);
    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsCurrency,EdUNid_codigo.Text,QEstoque) then begin
       EdProduto.INvalid('Quantidade em estoque insuficiente');
       exit;
    end;
// 30.08.06
/////////////////////////
    EdCodcor.enabled:=false;
    EdCodtamanho.enabled:=false;
    EdCodcopa.enabled:=false;
    EdCodcor.text:='';
    EdCodtamanho.text:='';
    EdCodcopa.text:='';
    if QBusca.eof  then begin
      QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'''+
                       ' and esgr_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
                       ' and esgr_codbarra='+stringtosql(codbarra));
      if not QGrade.eof then begin
        EdProduto.Text:=QGrade.fieldbyname('esgr_esto_codigo').AsString;
        EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.CodigoUnidade));
        EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.CodigoUnidade));
        EdCodcor.setvalue(QGrade.fieldbyname('esgr_core_codigo').asinteger);
        EdCodcor.validfind;
        EdCodtamanho.setvalue(QGrade.fieldbyname('esgr_tama_codigo').asinteger);
        EdCodtamanho.validfind;
        EdCodcopa.setvalue(QGrade.fieldbyname('esgr_copa_codigo').asinteger);
        EdCodcopa.validfind;
        FGeral.Fechaquery(QEstoque);
        QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
        FGeral.Fechaquery(QBusca);
        QBusca:=sqltoquery('select * from estoque where esto_codigo='+EdProduto.assql);
      end else begin
        EdProduto.Invalid('Codigo de barra da grade não encontrado');
        exit;
      end;
    end;
/////////////////////////

    SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;
    EdQtde.Enabled:=false;
    EdQtde.SetValue(1);

//  end else if Arq.TEstoque.locate('esto_codigo',EdProduto.text,[]) then begin
// 09.03.16 - sempre taz o mesmo item
  end else if not TEstoque.eof then begin

    EdQtde.Enabled:=true;
    EdQtde.SetValue(0);
    EdCodcor.enabled:=true;
    EdCodtamanho.enabled:=true;
    EdCodcopa.enabled:=true;
    EdCodcor.text:='';
    EdCodtamanho.text:='';
    EdCodcopa.text:='';
    EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.CodigoUnidade));

    if (pos( EdProduto.text,FGeral.Getconfig1asstring('Produtoscopa') )>0) and ( not codigobarra) then
      EdcodCopa.enabled:=true
    else begin
      EdCodCopa.enabled:=false;
      EdCodCopa.setvalue(0);
    end;
    SetEdEsto_descricao.text:=TEstoque.fieldbyname('esto_descricao').asstring;


  end else
    EdProduto.Invalid('Produto não encontrado');



end;

procedure TFRetprontaentreganovo.EdQtdeValidate(Sender: TObject);
var
    menorpreco,maiorpreco:currency;

  function TemnasRemessas(Produto:string;Qtde:currency):boolean;
  ///////////////////////////////////////////////////////////////
  var remessa,devolvido,digitado,mediapreco:currency;
      x,z:integer;
  begin
    QProdRemessa.First;x:=0;
    remessa:=0;devolvido:=0;
    mediapreco:=9999999;menorpreco:=9999999;maiorpreco:=0;
    Sistema.beginprocess('Checando remessas');
    while not QProdRemessa.Eof do begin
//      if (QProdRemessa.FieldByName('move_esto_codigo').asstring=Produto) and FGeral.Estaemaberto(QProdRemessa.FieldByName('move_remessas').asstring,EdRemessas.text) then begin
// 18.03.05
      if (QProdRemessa.FieldByName('move_esto_codigo').asstring=Produto) and FGeral.Estaemaberto(QProdRemessa.FieldByName('moes_numerodoc').asstring,EdRemessas.text) then begin
         remessa:=remessa+QProdRemessa.FieldByName('move_qtde').asfloat;
//         mediapreco:=mediapreco+QProdRemessa.FieldByName('move_venda').ascurrency;
//         if mediapreco>QProdRemessa.FieldByName('move_venda').ascurrency then
//           mediapreco:=QProdRemessa.FieldByName('move_venda').ascurrency;
         if menorpreco>=QProdRemessa.FieldByName('move_venda').asfloat then
           menorpreco:=QProdRemessa.FieldByName('move_venda').asfloat;
         if maiorpreco<=QProdRemessa.FieldByName('move_venda').asfloat then
           maiorpreco:=QProdRemessa.FieldByName('move_venda').asfloat;
         inc(x);
      end;
      QProdRemessa.Next;
    end;


    QProdDevolvido.First;
////////////////////////////////////////
{
    QProddevolvido.close;
    Freeandnil(QProddevolvido);
    Sistema.beginprocess('Pesquisando devoluções');
    QProdDevolvido:=sqltomemoryquery('select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,movestoque.* from movesto,movestoque'+
//          ' where moes_tipo_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
          ' where moes_repr_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
          ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',tiposmovdev,'C')+
          ' and moes_unid_codigo=move_unid_codigo'+
          ' and moes_numerodoc=move_numerodoc and move_status=''N'''+
//          ' and moes_remessas='+EdRemessas.Assql+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
//          ' and moes_tipomov=move_tipomov'+
          ' and moes_transacao=move_transacao'+
          ' and moes_status=move_status'+
          ' order by move_esto_codigo,moes_numerodoc');
}
//////////////////////////////////////////////
    Sistema.beginprocess('Checando devoluções');
    while not QProdDevolvido.Eof do begin
      if QProdDevolvido.FieldByName('move_esto_codigo').asstring=Produto then begin
        while (QProdDevolvido.FieldByName('move_esto_codigo').asstring=Produto) and (not QProdDevolvido.Eof) do begin
//        if ansipos(trim(EdRemessas.text),QProdDevolvido.fieldbyname('move_remessas').AsString)>0 then
          if FGeral.EstaemAberto(QProdDevolvido.fieldbyname('move_remessas').AsString,EdRemessas.text) then
             devolvido:=devolvido+QProdDevolvido.FieldByName('move_qtde').asfloat;
           QProdDevolvido.Next;
        end;
        break;
      end;
      QProdDevolvido.Next;
    end;
    Sistema.endprocess('');
    if x>0 then begin
//      mediapreco:=FGeral.arredonda(mediapreco/x,2);
      mediapreco:=FGeral.arredonda((maiorpreco+menorpreco)/2,2);
      if menorpreco=maiorpreco then
        EdUnitario.enabled:=false
      else
        EdUnitario.enabled:=true;
      EdUnitario.setvalue(mediapreco);
    end;
    digitado:=0;
    z:=FGeral.ProcuraGrid(0,Produto,Grid);
    if z>0 then
      digitado:=texttovalor(Grid.cells[Grid.GetColumn('move_qtde'),z]);

    if Qtde>0 then begin
      result:=false;
      if Qtde>(Remessa-devolvido-digitado) then
        result:=false
      else
        result:=true;
    end else if remessa=0 then
        result:=false
    else
        result:=true;
  end;

begin
/////////////////////////////////
  if not TemnasRemessas(EdProduto.Text,0) then begin
     EdQTde.Invalid('Produto não encontrado nas remessas escolhidas');
  end else if not TemnasRemessas(EdProduto.Text,EdQtde.AsCurrency) then begin
     EdQtde.Invalid('Quantidade a ser vendida maior que a remessa ou já vendido tudo');
  end else begin
//    y:=FGeral.ProcuraGrid(0,EdProduto.Text,Grid);
//    if y>0 then begin
//      if not TemnasRemessas(EdProduto.Text,texttovalor(Grid.Cells[2,y])+EdQTde.Ascurrency) then begin
//      if not TemnasRemessas(EdProduto.Text,EdQTde.Ascurrency) then begin
//         EdQtde.Invalid('Quantidade total de produto a ser vendida maior que a remessa');
//      end;
//    end;
  end;

end;

procedure TFRetprontaentreganovo.EdUnitarioExitEdit(Sender: TObject);
begin
//  if confirma('Confirma item ?') then begin
//    if EdTipomov.text<>Global.CodVendaTransf then   // 16.03.05
    EdValorvendatotal.setvalue(EdValorvendatotal.ascurrency-(EdQTde.ascurrency*EdUnitario.ascurrency));
    EditstoGrid;
//  end;
  EdProduto.ClearAll(FRetprontaentregaNovo,99);
  EdProduto.SetFocus;

end;

procedure TFRetprontaentreganovo.EdRemessasValidate(Sender: TObject);
var remessa,venbrinde,venpronta,ventrans,totalremessa,totaldevolucoes,devolucoes,valorsaldo,saldo:currency;
    ListaDev:TStringlist;
    nrodevolucoes:string;
    p,posicao:integer;

//////////////////////////////////////////////////////////////
{
    function DevolucaoOK(remessas,tipomov:string):boolean;
    var x:integer;
        found:boolean;
    begin
       found:=false;
       if tipomov=global.CodRemessaProntaEntrega then
         found:=true
       else begin
         found:=true;
         for x:=0 to ListaremessasFechadas.count-1 do begin
           if pos( strzero(strtoint(listaremessasfechadas[x]),8) , remessas )>0 then begin
             found:=false;
             break;
           end;
         end;
       end;
       result:=found;
    end;
}
//////////////////////////////////////////////////////////////


begin

  Sistema.beginprocess('Separando produtos das remessas escolhidas');

{
  QProdRemessa:=Sqltoquery('select moes_vlrtotal,moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,movestoque.* from movesto,movestoque'+
          ' where moes_tipo_codigo='+EdRepr_codigo.AsSql+
          ' and '+FGeral.GetIN('moes_numerodoc',EdRemessas.Text,'N')+
          ' and moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodRemessaProntaEntrega)+
/////          ' and moes_numerodoc=move_numerodoc and move_status=''N'''+
          ' and moes_tipomov=move_tipomov'+
          ' and moes_transacao=move_transacao'+
          ' and moes_unid_codigo=move_unid_codigo'+
          ' and moes_status=move_status'+
          ' order by move_esto_codigo,moes_numerodoc');
}
{
    QProdRemessa:=Sqltomemoryquery('select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,moes_repr_codigo,moes_tabp_codigo,movestoque.*'+
//          ' from movesto,movestoque where moes_tipo_codigo='+EdRepr_codigo.AsSql+
            ' from movesto,movestoque where moes_repr_codigo='+EdRepr_codigo.AsSql+
            ' and moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodRemessaProntaEntrega)+
            ' and moes_unid_codigo='+EdUnid_codigo.Assql+
//            ' and '+FGeral.GetIN('moes_numerodoc',EdRemessas.Text,'N')+
            ' and moes_transacao=move_transacao'+
            ' and moes_unid_codigo=move_unid_codigo'+
            ' and moes_status=move_status'+
            ' order by move_esto_codigo,moes_numerodoc');
}
    QProdRemessa:=Sqltomemoryquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao)'+
//          ' from movesto,movestoque where moes_tipo_codigo='+EdRepr_codigo.AsSql+
            ' where move_repr_codigo='+EdRepr_codigo.AsSql+
            ' and move_status=''N'' and move_tipomov='+stringtosql(Global.CodRemessaProntaEntrega)+
            ' and move_unid_codigo='+EdUnid_codigo.Assql+
//            ' and '+FGeral.GetIN('moes_numerodoc',EdRemessas.Text,'N')+
            ' order by move_esto_codigo,moes_numerodoc');

    if fechamento then   // 28.11.05
      QProdRemessaFe:=Sqltomemoryquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao)'+
            ' where move_repr_codigo='+EdRepr_codigo.AsSql+
            ' and move_status=''N'' and move_tipomov='+stringtosql(Global.CodRemessaProntaEntrega)+
            ' and move_unid_codigo='+EdUnid_codigo.Assql+
            ' order by move_esto_codigo,moes_numerodoc');

  remessa:=0;totalremessa:=0;
  GridCodigos.clear;
  while not QProdremessa.eof do begin
    if FGeral.Estaemaberto(QProdRemessa.fieldbyname('moes_numerodoc').AsString,EdRemessas.text) then begin
      remessa:=remessa+QProdremessa.fieldbyname('move_qtde').Asfloat;
      totalremessa:=totalremessa+(QProdremessa.fieldbyname('move_qtde').Asfloat*QProdremessa.fieldbyname('move_venda').Asfloat);
      posicao:=FGeral.ProcuraGrid(0,QProdremessa.fieldbyname('move_esto_codigo').Asstring,Gridcodigos);
      if posicao<=0 then
        FGeral.IncluiGrid(Gridcodigos,QProdremessa.fieldbyname('move_esto_codigo').Asstring);
// 03.05.06
      posicao:=FGeral.ProcuraGrid(Gridcodigos.getcolumn('move_esto_codigo'),QProdremessa.fieldbyname('move_esto_codigo').Asstring,Gridcodigos);
      if posicao>0 then begin
        Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),posicao]) +
           QProdremessa.fieldbyname('move_qtde').AsFloat  );
        Gridcodigos.cells[Gridcodigos.getcolumn('move_venda'),posicao]:= QProdremessa.fieldbyname('move_venda').AsString ;
        if QProdremessa.fieldbyname('move_tipomov').asstring=Global.CodVendaProntaEntrega then
               Gridcodigos.cells[Gridcodigos.getcolumn('vp'),Posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('vp'),posicao]) +
               QProdremessa.fieldbyname('move_qtde').AsFloat  )
        else if QProdremessa.fieldbyname('move_tipomov').asstring=Global.CodVendaBrinde then
               Gridcodigos.cells[Gridcodigos.getcolumn('vb'),Posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('vb'),posicao]) +
               QProdremessa.fieldbyname('move_qtde').AsFloat  )
        else if QProdremessa.fieldbyname('move_tipomov').asstring=Global.CodDevolucaoProntaEntrega then begin
               Gridcodigos.cells[Gridcodigos.getcolumn('dp'),Posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('dp'),posicao]) +
               QProdremessa.fieldbyname('move_qtde').AsFloat  )
        end;
      end;
    end;
    QProdremessa.Next;
  end;
  Sistema.endprocess('');

////////////////////////////////// - 27.09.05
{
    ListaRemessasFechadas:=Tstringlist.create;
    Sistema.BeginProcess('Checando remessas');
    Datai:=EdDtmovimento.asdate-90;  // 27.09.05
    QSaidas:=sqltomemoryquery('select * from movestoque '+
                  ' inner join movesto on ( moes_transacao=move_transacao )'+
                  ' where move_datamvto>='+Datetosql(Datai)+' and move_datamvto<='+EdDtmovimento.AsSql+
                  ' and move_unid_codigo='+EdUnid_codigo.assql+
                  ' and '+FGeral.getin('move_tipomov',Global.CodRemessaProntaEntrega,'C',)+
                  ' and move_repr_codigo='+EdRepr_codigo.assql+
                  ' and '+FGeral.Getin('move_status','E','C')+
                  ' order by move_unid_codigo,move_repr_codigo,move_tipo_codigo,move_esto_codigo,move_tipomov' );
    while not QSaidas.eof do begin
          if ListaremessasFechadas.indexof(QSaidas.fieldbyname('move_numerodoc').asstring)=-1 then
            ListaremessasFechadas.add(QSaidas.fieldbyname('move_numerodoc').asstring);
      QSaidas.next;
    end;

//////////////////////////////////
}
  valorsaldo:=0;
  if remessa=0 then begin
    EdRemessas.Invalid('Não encontrado produtos das remessas escolhidas');
    EdRemessas.setfocus;
    exit;
  end else begin
    Sistema.beginprocess('Separando as devoluções das remessas escolhidas');

////////////////////////
{
  QProdDevolvido:=Sqltomemoryquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
          ' where move_repr_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
// 11.04.05 - para ver as VT ja fechadas pelo retorno de RC
          ' and '+FGEral.Getin('move_status','N;D','C')+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
          ' and move_tipomov<>'+inttostr(coddevnao)+   // 27.09.05 - VB ref. consignação- aqui so em 29.11.05
          ' order by move_esto_codigo,move_numerodoc');
 - diferença no order by no numerodoc
 }
/////////////////////
    QProdDevolvido:=Sqltomemoryquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
//          ' where moes_tipo_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
          ' where move_repr_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
//          ' and '+moes_status=''N'' and '+FGeral.Getin('moes_tipomov',tiposmovdev,'C')+
// 11.04.05 - para ver as VT ja fechadas pelo retorno de RC
// 24.05.05 - para ver as VT ainda nao fechadas pelo retorno de RC
          ' and '+FGEral.Getin('move_status','N;D','C')+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
//          ' and '+FGEral.Getin('move_status','N;D','C')+
//          ' and move_tipomov<>'+inttostr(coddevnao)+   // 27.09.05 - VB ref. consignação
                                                         // 26.10.11 - retirado
          ' order by move_esto_codigo,moes_numerodoc');

    venbrinde:=0;venpronta:=0;ventrans:=0;devolucoes:=0;
    totaldevolucoes:=0;
    ListaDev:=Tstringlist.create;
    nrodevolucoes:='';
    while not QProdDevolvido.eof do begin
//      if ( FGeral.EstaemAberto(QProdDevolvido.fieldbyname('move_remessas').AsString,EdRemessas.text) ) and
//         ( DevolucaoOK(QProdDevolvido.fieldbyname('move_remessas').AsString,QProdDevolvido.fieldbyname('move_tipomov').AsString) )
// 31.10.05
      if ( FGeral.EstaemAberto(QProdDevolvido.fieldbyname('move_remessas').AsString,EdRemessas.text) )
// 11.05.06
//      if ( FGeral.EstaemAberto(QProdDevolvido.fieldbyname('moes_remessas').AsString,EdRemessas.text) )
        then begin
        if Qproddevolvido.fieldbyname('move_tipomov').asstring=Global.CodVendaProntaEntrega then
          venpronta:=venpronta+QProdDevolvido.fieldbyname('move_qtde').Asfloat
        else if Qproddevolvido.fieldbyname('move_tipomov').asstring=Global.CodVendaBrinde then
          venbrinde:=venbrinde+QProdDevolvido.fieldbyname('move_qtde').Asfloat
        else if Qproddevolvido.fieldbyname('move_tipomov').asstring=Global.CodDevolucaoProntaEntrega then begin
          devolucoes:=devolucoes+QProdDevolvido.fieldbyname('move_qtde').Asfloat;
          if Listadev.indexof(Qproddevolvido.fieldbyname('move_numerodoc').asstring)=-1 then
            Listadev.add(Qproddevolvido.fieldbyname('move_numerodoc').asstring);
        end else if Qproddevolvido.fieldbyname('move_tipomov').asstring=Global.CodVendaTransf then
          ventrans:=ventrans+QProdDevolvido.fieldbyname('move_qtde').Asfloat;
// 03.05.06
        posicao:=FGeral.ProcuraGrid(Gridcodigos.getcolumn('move_esto_codigo'),QProdDevolvido.fieldbyname('move_esto_codigo').Asstring,Gridcodigos);
        if posicao <=0 then begin
//          Avisoerro(QProdDevolvido.fieldbyname('move_esto_codigo').Asstring+' possui apenas devoluções');
          FGeral.IncluiGrid(Gridcodigos,QProdDevolvido.fieldbyname('move_esto_codigo').Asstring);
          posicao:=FGeral.ProcuraGrid(Gridcodigos.getcolumn('move_esto_codigo'),QProdDevolvido.fieldbyname('move_esto_codigo').Asstring,Gridcodigos);
        end;
//        if texttovalor(  Gridcodigos.cells[Gridcodigos.getcolumn('move_venda'),posicao] )>0 then
//          totaldevolucoes:=totaldevolucoes+(QProdDevolvido.fieldbyname('move_qtde').Asfloat*texttovalor(  Gridcodigos.cells[Gridcodigos.getcolumn('move_venda'),posicao] ) ) ;
//        else
          totaldevolucoes:=totaldevolucoes+(QProdDevolvido.fieldbyname('move_qtde').Asfloat*QProddevolvido.fieldbyname('move_venda').Asfloat);
// 18.05.06          
//        if texttovalor(  Gridcodigos.cells[Gridcodigos.getcolumn('move_venda'),posicao] )>0 then begin
//          if texttovalor(  Gridcodigos.cells[Gridcodigos.getcolumn('move_venda'),posicao] )<>QProddevolvido.fieldbyname('move_venda').Asfloat then
//              avisoerro('Produto '+QProdDevolvido.fieldbyname('move_esto_codigo').Asstring+' com valor # da remessa doc. '+
//                        QProdDevolvido.fieldbyname('move_numerodoc').Asstring+' - '+QProdDevolvido.fieldbyname('move_tipomov').Asstring     )
//        end;

             Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),Posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),posicao]) -
             QProdDevolvido.fieldbyname('move_qtde').AsFloat  );
             if Qproddevolvido.fieldbyname('move_tipomov').asstring=Global.CodVendaProntaEntrega then
               Gridcodigos.cells[Gridcodigos.getcolumn('vp'),Posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('vp'),posicao]) +
               QProdDevolvido.fieldbyname('move_qtde').AsFloat  )
             else if Qproddevolvido.fieldbyname('move_tipomov').asstring=Global.CodVendaBrinde then
               Gridcodigos.cells[Gridcodigos.getcolumn('vb'),Posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('vb'),posicao]) +
               QProdDevolvido.fieldbyname('move_qtde').AsFloat  )
             else if Qproddevolvido.fieldbyname('move_tipomov').asstring=Global.CodDevolucaoProntaEntrega then begin
               Gridcodigos.cells[Gridcodigos.getcolumn('dp'),Posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('dp'),posicao]) +
               QProdDevolvido.fieldbyname('move_qtde').AsFloat  )
             end;

      end;
      QProdDevolvido.Next;
    end;
    Sistema.endprocess('');
//    EdValorvendatotal.SetValue(totalremessa-totaldevolucoes);
// 11.05.06
    EdSAldopecas.setvalue( 0 );
    EdSobra.setvalue( 0 );
    EdFalta.setvalue( 0 );
    EdVp.setvalue(0);
    EdVb.setvalue(0);
    Eddp.setvalue(0);
    EdVendagrid.setvalue(0);
    for p:=1 to GridCodigos.rowcount do begin
//      if trim(Gridcodigos.cells[Gridcodigos.getcolumn('move_venda'),P])<>'' then begin
      if trim(Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),p])<>'' then begin
        saldo:=texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),p]);
//        if saldo>0 then
        valorsaldo:=valorsaldo+ ( saldo ) *
                  texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('move_venda'),P]);

//        if texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('move_venda'),P])<=0 then
//          avisoerro('Produto '+Gridcodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),p]+' sem preço');

        EdSAldopecas.setvalue( EdSaldoPecas.ascurrency + saldo );
        if saldo>=0 then
          EdSobra.setvalue( EdSobra.ascurrency + saldo )
        else
          EdFalta.setvalue( EdFalta.ascurrency + saldo );
        if trim(Gridcodigos.cells[Gridcodigos.getcolumn('vp'),p])<>'' then
          Edvp.setvalue( Edvp.ascurrency+ texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('vp'),p]) );
        if trim(Gridcodigos.cells[Gridcodigos.getcolumn('vb'),p])<>'' then
          Edvb.setvalue( Edvb.ascurrency+ texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('vb'),p]) );
        if trim(Gridcodigos.cells[Gridcodigos.getcolumn('dp'),p])<>'' then
          Eddp.setvalue( Eddp.ascurrency+ texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('dp'),p]) );
      end;
    end;

    Edenviado.SetValue(totalremessa);
    Eddevolvido.SetValue(totaldevolucoes);
//    EdVenda.SetValue(totalremessa-totaldevolucoes);
//    EdValorvendatotal.SetValue(valorsaldo);
// 12.05.06
    EdVenda.SetValue(valorsaldo);
    EdValorvendatotal.SetValue(totalremessa-totaldevolucoes);
    for p:=0 to listadev.count-1 do begin
      nrodevolucoes:=nrodevolucoes+listadev[p]+';';
    end;


    Aviso('Qtde remessa : '+FGeral.Formatavalor(remessa,'00000')+
                      '   Qtde venda  : '+FGeral.Formatavalor(venpronta,'00000')+
                      '   Qtde brinde : '+FGeral.Formatavalor(venbrinde,'00000')+
                      '   Qtde transf.: '+FGeral.Formatavalor(ventrans,'00000')+
                      '   Qtde devolv.: '+FGeral.Formatavalor(devolucoes,'00000')+
                      '   Saldo : '+Formatfloat(f_cr,remessa-(venpronta+venbrinde+ventrans+devolucoes)) );
//                      '   Saldo : '+FGeral.Formatavalor(remessa-(venpronta+venbrinde+ventrans+devolucoes),'00000') );
  end;
//  EdNropedido.setfocus;
  EdCliente.setfocus;
///////////////  EdFpgt_codigo.text:='';  // 27.09.05
// retirado em 28.08.06 para poder alterar valores e vencimentos do grid de parcelas

//  if remessa-(venpronta+venbrinde+ventrans+devolucoes)<=0 then
//    bfechamento.enabled:=true
//  else
//    bfechamento.enabled:=false;

end;

procedure TFRetprontaentreganovo.bSaldoClick(Sender: TObject);
begin
//  if trim(EdProduto.text)='' then exit;
  pbotoes.enabled:=false;
  pins.enabled:=false;
  bGravapedido.Enabled:=false;
  bSair.Enabled:=false;
  PSaldo.visible:=true;
//  Psaldo.setfocus;
  Pcodigos.visible:=true;
  GridSaldo.clear;
{
  linha:=1;saldo:=0;
  GridSaldo.RowCount:=2;
  QProdremessa.first;
  while not QProdremessa.eof do begin
    if EdProduto.text=QProdremessa.fieldbyname('move_esto_codigo').asstring then begin
      GridSaldo.Cells[0,linha]:=QProdremessa.fieldbyname('move_datamvto').Asstring;
      GridSaldo.Cells[1,linha]:=QProdremessa.fieldbyname('move_tipomov').Asstring;
      GridSaldo.Cells[2,linha]:=QProdremessa.fieldbyname('move_qtde').Asstring;
      saldo:=saldo+QProdremessa.fieldbyname('move_qtde').Ascurrency;
      GridSaldo.Cells[3,linha]:=FGeral.formatavalor(saldo,'####0');
      inc(linha);
      GridSaldo.RowCount:=linha+1;
    end;
    QProdremessa.Next;
  end;

//  QProddevolvido.first;
// tem q buscar aqui novamente devido aos incluidos durante a digitação q a select foi executada antes...
// 15.06.04
  Sistema.beginprocess('Checando pedidos');
  QProddevolvido.close;
  QProdDevolvido.Sql.text:='select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,movestoque.* from movesto,movestoque'+
//          ' where moes_tipo_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
          ' where moes_repr_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
          ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',tiposmovdev,'C')+
          ' and moes_unid_codigo=move_unid_codigo'+
          ' and moes_numerodoc=move_numerodoc and move_status=''N'''+
          ' and moes_remessas='+EdRemessas.Assql+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
//          ' and moes_tipomov=move_tipomov'+
          ' and moes_transacao=move_transacao'+
          ' and moes_status=move_status'+
          ' order by move_esto_codigo,moes_numerodoc';
  QProddevolvido.open;
  Sistema.endprocess('');
  while not QProdDevolvido.eof do begin
    if EdProduto.text=QProddevolvido.fieldbyname('move_esto_codigo').asstring then begin
//      if (ansipos(QProdDevolvido.fieldbyname('move_remessas').AsString,trim(EdRemessas.text))>0) and
//         (QProdDevolvido.fieldbyname('move_remessas').AsString<>'')
//        then begin
        GridSaldo.Cells[0,linha]:=QProddevolvido.fieldbyname('move_datamvto').Asstring;
        GridSaldo.Cells[1,linha]:=QProddevolvido.fieldbyname('move_tipomov').Asstring;
        GridSaldo.Cells[2,linha]:=QProddevolvido.fieldbyname('move_qtde').Asstring;
        saldo:=saldo-QProddevolvido.fieldbyname('move_qtde').Ascurrency;
        GridSaldo.Cells[3,linha]:=FGeral.formatavalor(saldo,'####0');
        inc(linha);
        GridSaldo.RowCount:=linha+1;
      end;
//    end;
    QProdDevolvido.Next;
  end;
  for x:=1 to Grid.rowcount do begin
    if EdProduto.text=Grid.cells[Grid.Getcolumn('move_esto_codigo'),x] then begin
        GridSaldo.Cells[0,linha]:=formatdatetime('dd/mm/yy',EdEmissaopedido.asdate);
        GridSaldo.Cells[1,linha]:=EdTipomov.text;
        GridSaldo.Cells[2,linha]:=Grid.cells[Grid.Getcolumn('move_qtde'),x];
        saldo:=saldo-texttovalor( Grid.cells[Grid.Getcolumn('move_qtde'),x] );
        GridSaldo.Cells[3,linha]:=FGeral.formatavalor(saldo,'####0');
        inc(linha);
        GridSaldo.RowCount:=linha+1;
    end;
  end;
}
  GridCodigos.setfocus;

end;

procedure TFRetprontaentreganovo.EdEmissaopedidoValidate(Sender: TObject);
var QBusca,QPend:TSqlquery;
    x:integer;
begin
  PedidoGravado:='N';
  if (EdEmissaopedido.asdate>EdDtmovimento.asdate) and ( not EdDtmovimento.IsEmpty ) then
    EdEmissaopedido.INvalid('Emissão do pedido tem que ser menor que a data de movimento')
//  else if trim(Grid.Cells[0,1])='' then begin
  else begin
//    QBusca:=sqltoquery(FGeral.BuscaRemessa(EdNropedido.asinteger,Global.CodVendaProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodVendaTransf));
// 23.02.05 - para nao 'dar conflito' com outras numeracoes
    QBusca:=sqltoquery(FGeral.BuscaRemessa(EdNropedido.asinteger,EdTipoMov.text));
    Grid.clear;x:=1;
    if not QBusca.eof then begin
      QPend:=Sqltoquery(FGeral.BuscaPendencia(Edcliente.asinteger,EdNropedido.asinteger,'R',Edemissaopedido.asdate));
      PedidoGravado:='S';
      if not QPend.eof then begin
        EdFpgt_codigo.text:=QPend.fieldbyname('pend_fpgt_codigo').asstring;
        EdValorvenda.setvalue(QPend.fieldbyname('pend_valortitulo').ascurrency);
      end;
      QPend.close;
      Freeandnil(QPend);
    end;
    while not QBusca.eof do begin
      Grid.Cells[0,Abs(x)]:=QBusca.fieldbyname('move_esto_codigo').asstring;
      Grid.Cells[1,Abs(x)]:=FEstoque.GetDescricao(QBusca.fieldbyname('move_esto_codigo').asstring);
      Grid.Cells[2,Abs(x)]:=QBusca.fieldbyname('move_tipomov').asstring;
      Grid.Cells[3,Abs(x)]:=Transform(QBusca.fieldbyname('move_qtde').ascurrency,f_quanti);
  //    Grid.Cells[3,Abs(x)]:=FGeral.formatavalor(FEstoque.GetPreco(EdProduto.Text,EdUnid_codigo.Text),f_cr);
      Grid.Cells[4,Abs(x)]:=Transform(QBusca.fieldbyname('move_venda').ascurrency,F_cr);
      Grid.Cells[5,Abs(x)]:=transform(FGeral.Arredonda(QBusca.fieldbyname('move_venda').Ascurrency*QBusca.fieldbyname('move_qtde').ascurrency,2),f_cr);
      inc(x);
      Grid.rowcount:=x;
      QBusca.Next;
    end;
    QBusca.close;
    Freeandnil(QBusca);
  end;

end;

procedure TFRetprontaentreganovo.bfecharClick(Sender: TObject);
begin
//  bGravar.Enabled:=true;
  bGravapedido.enabled:=true;
  bSair.Enabled:=true;
  PSaldo.visible:=false;
  Pcodigos.visible:=false;
//  bSaldo.enabled:=false;
  pbotoes.enabled:=true;
  pins.enabled:=true;
  EdProduto.setfocus;

end;

procedure TFRetprontaentreganovo.bGravapedidoClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var tipomov,transacao:string;
    valorcomissao,valorvenda,percdesconto:currency;
    demissao:TDatetime; 

    procedure GravaMestre;
    //////////////////////
    var Q:TSqlquery;
        mensagemfixa:string;
    begin
      if Op='I' then begin
        Sistema.Insert('Movesto');
        Sistema.SetField('moes_transacao',Transacao);
        Sistema.SetField('moes_operacao',FGeral.GetOperacao);
//        if tipomov=Global.CodVendaTransf then
//          Sistema.SetField('moes_status','F')
//        else
// 25.05.05
          Sistema.SetField('moes_status','N');

        Sistema.SetField('moes_numerodoc',EdNropedido.asinteger);
        Sistema.SetField('moes_tipomov',TipoMov);
        Sistema.SetField('moes_unid_codigo',EdUNid_codigo.text);
        Sistema.SetField('moes_tipo_codigo',EdCliente.AsInteger);
    //    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
        Sistema.SetField('moes_estado',EdCliente.ResultFind.fieldbyname('clie_uf').AsString);
        Sistema.SetField('moes_repr_codigo',EdRepr_codigo.asinteger);
        Sistema.SetField('moes_tipocad','C');
        Sistema.SetField('moes_datalcto',Sistema.Hoje);
// 03.02.11
        if EdDtmovimento.IsEmpty then
          Sistema.SetField('moes_datamvto',Sistema.Hoje)
        else
          Sistema.SetField('moes_datamvto',EdDtmovimento.asdate);
        Sistema.SetField('moes_datacont',EdDtmovimento.asdate);
        if EdEmissaopedido.isempty then
          Sistema.SetField('moes_dataemissao',Sistema.Hoje)
        else
          Sistema.SetField('moes_dataemissao',EdEmissaopedido.asdate);
        Sistema.SetField('moes_vlrtotal',Valorvenda);
        Sistema.SetField('moes_tabp_codigo',0);
        Sistema.SetField('moes_tabaliquota',0);
        Sistema.SetField('moes_remessas',EdRemessas.text);
        Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('moes_valortotal',Valorvenda);
        Sistema.SetField('moes_perdesco',percdesconto);
        Sistema.SetField('moes_vispra',FCondpagto.GetAvPz(EdFpgt_codigo.text));
// 22.08.05
        if FCondPagto.GetAvPz(EdFpgt_codigo.text)='V' then
          Sistema.SetField('moes_valoravista',valorvenda)
        else
          Sistema.SetField('moes_valoravista',valorparteavista);
// 31.10.05
        Sistema.SetField('moes_totprod',Valorvenda);
// 27.10.11
///////////////
        Sistema.SetField('moes_cida_codigo',EdCliente.ResultFind.fieldbyname('clie_cida_codigo_res').AsInteger);
        Sistema.SetField('moes_tran_codigo','001');
        Sistema.SetField('moes_fpgt_codigo',EdFpgt_codigo.Text);
        if EdEmissaopedido.isempty then
          Sistema.SetField('moes_datasaida',Sistema.Hoje)
        else
          Sistema.SetField('moes_datasaida',EdEmissaopedido.asdate);
        if (EdDtmovimento.asdate>1) and (FGEral.GetConfig1AsInteger('Confvenconsig')>0) then begin
          Q:=sqltoquery('select * from confmov where comv_codigo='+inttostr(FGEral.GetConfig1AsInteger('Confvenconsig')));
          if not Q.Eof then begin
            if EdCliente.ResultFind.fieldbyname('clie_uf').AsString=Global.UFUnidade then
              Sistema.SetField('moes_natf_codigo',Q.fieldbyname('Comv_natf_estado').asstring)
            else
              Sistema.SetField('moes_natf_codigo',Q.fieldbyname('Comv_natf_foestado').asstring);
            Sistema.SetField('moes_especie',Q.fieldbyname('comv_especie').asstring);
            Sistema.SetField('moes_serie',Q.fieldbyname('comv_serie').asstring);
          end;
          FGeral.FechaQuery(Q);
          if FGeral.getconfig1asInteger('CODMENVEN')>0 then begin
           if pos(EdUNid_codigo.ResultFind.fieldbyname('unid_simples').asstring,'S;2')>0 then
             mensagemfixa:=FMensNotas.GetDescricao( FGeral.getconfig1asInteger('CODMENVEN') )+' ' ;
             Sistema.SetField('moes_mensagem',mensagemfixa);
          end;
        end;
        Sistema.Post();

      end else begin

        Sistema.Edit('Movesto');
        Sistema.SetField('moes_numerodoc',EdNropedido.asinteger);
        Sistema.SetField('moes_tipo_codigo',EdCliente.AsInteger);
    //    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
        Sistema.SetField('moes_estado',EdCliente.ResultFind.fieldbyname('clie_uf').AsString);
        Sistema.SetField('moes_repr_codigo',EdRepr_codigo.asinteger);
        Sistema.SetField('moes_tipocad','C');

// 03.02.11
        if EdDtmovimento.IsEmpty then
          Sistema.SetField('moes_datamvto',Sistema.Hoje)
        else
          Sistema.SetField('moes_datamvto',EdDtmovimento.asdate);
        Sistema.SetField('moes_datacont',EdDtmovimento.asdate);

//        Sistema.SetField('moes_dataemissao',EdEmissaopedido.asdate);
        if EdEmissaopedido.isempty then
          Sistema.SetField('moes_dataemissao',Sistema.Hoje)
        else
          Sistema.SetField('moes_dataemissao',EdEmissaopedido.asdate);
        Sistema.SetField('moes_vlrtotal',Valorvenda);
        Sistema.SetField('moes_tabp_codigo',0);
        Sistema.SetField('moes_tabaliquota',0);
        Sistema.SetField('moes_remessas',EdRemessas.text);
        Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('moes_valortotal',Valorvenda);
        Sistema.SetField('moes_perdesco',percdesconto);
        Sistema.SetField('moes_vispra',FCondpagto.GetAvPz(EdFpgt_codigo.text));
// 22.08.05
        if FCondPagto.GetAvPz(EdFpgt_codigo.text)='V' then
          Sistema.SetField('moes_valoravista',valorvenda)
        else
          Sistema.SetField('moes_valoravista',valorparteavista);
// 31.10.05
        Sistema.SetField('moes_totprod',Valorvenda);
        Sistema.Post('moes_transacao='+stringtosql(transacao));
      end;
    end;

// 31.10.05
    procedure GravaDetalheDividido;
///////////////////////////////////////////////////////////////
    type TMov=record
        remessa:currency;
        saldo:currency;
    end;
    var linha,x:integer;
        Q,TEstoqueQtde,QChecaRem,TSittributaria:TSqlquery;
        produto,RemessasOK:string;
        saldoprodutoremessa,qtddev,qtddevII:currency;
        Lista:Tlist;
        PMov:^TMov;
        xcst,simples:string;
        reducao,isentas,outras,ValorContabil,totalit,icmssubs,Base,icmsitem,
        totalitem,venda,qtde,aliicms,basesubs,Totalbaseicms,valoricms,
        margemlucro,TotalBaseicmsSubs,valoricmssubs,Valortotal:currency;
        ListaCstPerc:TList;


        function GetSaldo(codigo:string):currency;
        //////////////////////////////////////////
        var saldo:currency;
            nroremdev,x:integer;

            procedure Atualiza(doc:currency;qtde:currency;tipomov:string;remessasdev:string='');
            //////////////////////////////////////////////////////////////////////////////////
            var p:integer;
                found:boolean;
            begin
               found:=false;
               for p:=0 to Lista.count-1 do begin
                 PMov:=Lista[p];
                 if remessasdev='' then begin
                   if Pmov.remessa=doc then begin
                     found:=true;
                     break;
                   end;
                 end else begin
                   if pos( strzero(strtoint(currtostr(Pmov.remessa)),8),remessasdev )>0 then begin   // 21.11.05
                     found:=true;
                     break;
                   end;
                 end;
               end;
               if not found then begin
                 if tipomov=Global.CodRemessaProntaEntrega then begin  // 21.11.05
                   New(PMov);
                   PMov.remessa:=doc;
                   PMov.saldo:=qtde;
                   Lista.Add(Pmov);
                 end;
               end else begin
                 if tipomov=Global.CodRemessaProntaEntrega then
                   PMov.saldo:=PMov.saldo+qtde
                 else
                   PMov.saldo:=PMov.saldo-qtde
               end;
            end;

        begin
        //////////////////////////////////////
          saldo:=0;
          QProdremessa.first;
          while not QProdremessa.eof do begin
            if codigo=QProdremessa.fieldbyname('move_esto_codigo').asstring then begin
              if FGeral.Estaemaberto(QProdRemessa.fieldbyname('move_numerodoc').AsString,EdRemessas.text) then begin
                 saldo:=saldo+QProdremessa.fieldbyname('move_qtde').asfloat;
                 Atualiza(QProdRemessa.fieldbyname('move_numerodoc').Asfloat,QProdremessa.fieldbyname('move_qtde').asfloat,
                 QProdRemessa.fieldbyname('move_tipomov').AsString);
              end;
            end;
            QProdremessa.Next;
          end;
          QProddevolvido.first;
          while not QProdDevolvido.eof do begin
            if codigo=QProddevolvido.fieldbyname('move_esto_codigo').asstring then begin
              if FGeral.EstaemAberto(QProdDevolvido.fieldbyname('move_remessas').AsString,EdRemessas.text) then begin
                 saldo:=saldo-QProdDevolvido.fieldbyname('move_qtde').asfloat;
                 if copy(QProdDevolvido.fieldbyname('move_remessas').AsString,1,8)<>'' then begin
                   nroremdev:=strtoint(copy(QProdDevolvido.fieldbyname('move_remessas').AsString,1,8));
                   Atualiza(nroremdev,QProdDevolvido.fieldbyname('move_qtde').asfloat,QProdDevolvido.fieldbyname('move_tipomov').AsString,
                   QProdDevolvido.fieldbyname('move_remessas').AsString);
                 end;
              end;
            end;
            QProddevolvido.Next;
          end;
          result:=saldo;
        end;


    begin
    ////////////////////////////////////////////////////////////////////////////////
//      Lista:=TList.create;
      ListaCstPerc:=TList.Create;
      for linha:=1 to Grid.rowcount do begin
        if trim(Grid.Cells[0,linha])<>'' then begin
//          codigograde:=FEstoque.GetCodigoGrade(Grid.Cells[0,linha]);
          produto:=Grid.cells[Grid.getcolumn('move_esto_codigo'),linha];
          qtddev:=texttovalor(Grid.cells[Grid.getcolumn('move_qtde'),linha]);
          qtddevII:=qtddev;
          Lista:=TList.create;
          saldoprodutoremessa:=GetSaldo(produto);
          if saldoprodutoremessa>0 then begin
            for x:=0 to Lista.count-1 do begin
              PMov:=Lista[x];
              if Pmov.saldo>=qtddev then
                qtddevII:=Qtddev
              else
                qtddevII:=Pmov.saldo;
//              qtddev:=qtddev-qtddevII;
              if qtddevII>0 then begin
                qtddev:=qtddev-qtddevII;   // aqui em 21.11.05
                Sistema.Insert('Movestoque');
                Sistema.SetField('move_esto_codigo',Grid.Cells[0,linha]);
//                codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[0,linha],codigograde);
//                codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[0,linha],codigograde);
                Arq.TEstoque.Locate('esto_codigo',Grid.Cells[0,linha],[]);
// 31.01.06
                TEstoqueQtde:=sqltoquery( FEstoque.GetSqlCustos(produto,EdUnid_codigo.text) );
{//////////////////////////////
                if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
                  Sistema.SetField('move_tama_codigo',codigolinha)
                else
                  Sistema.SetField('move_core_codigo',codigolinha);
                if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
                  Sistema.SetField('move_tama_codigo',codigocoluna)
                else
                  Sistema.SetField('move_core_codigo',codigocoluna);
}
// 03.02.11
                Sistema.SetField('move_tama_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codtamanho'),linha],0 ) );
                Sistema.SetField('move_core_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcor'),linha],0 ) );
                Sistema.SetField('move_copa_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcopa'),linha],0 ) );
//////////////////////
                Sistema.SetField('move_transacao',transacao);
                Sistema.SetField('move_operacao',FGeral.GetOperacao);
                Sistema.SetField('move_numerodoc',EdNropedido.asinteger);
                Sistema.SetField('move_status','N');
                Sistema.SetField('move_tipomov',Grid.Cells[Grid.getcolumn('tipo'),linha]);
                Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
                Sistema.SetField('move_tipo_codigo',EdCliente.AsInteger);
                Sistema.SetField('move_tipocad','C');
                Sistema.SetField('move_repr_codigo',EdRepr_codigo.asinteger);
//                Sistema.SetField('move_qtde',Texttovalor(Grid.Cells[3,linha]));
                Sistema.SetField('move_qtde',qtddevII);
                Sistema.SetField('move_datalcto',Sistema.Hoje);
//                Sistema.SetField('move_datamvto',EdDtMovimento.asdate);
// 03.02.11
                if EdDtmovimento.IsEmpty then
                  Sistema.SetField('move_datamvto',Sistema.Hoje)
                else
                  Sistema.SetField('move_datamvto',EdDtmovimento.asdate);
                Sistema.SetField('move_datacont',EdDtmovimento.asdate);

                Sistema.SetField('move_qtderetorno',0);
                Sistema.SetField('move_venda',Texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),linha]));
                Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
                Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
                Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
                Sistema.SetField('move_remessas',formatfloat('00000000',PMov.remessa)+';');
// 07.07.06
                QChecaRem:=sqltoquery('select move_esto_codigo from movestoque where move_numerodoc='+floattostr(PMov.remessa)+
                                      ' and move_unid_codigo='+EdUnid_codigo.assql+' and move_status<>''C'''+
                                      ' and move_tipomov='+stringtosql(Global.CodRemessaProntaEntrega)+
                                      ' and move_repr_codigo='+EdRepr_codigo.assql );
                if QChecaRem.eof then
                   FGeral.Gravalog(10,Grid.Cells[Grid.getcolumn('tipo'),linha]+' produto '+Grid.Cells[Grid.GetColumn('move_esto_codigo'),linha]+
                                   'numero '+EdNropedido.text+' Cliente '+EdCliente.text,false,transacao);
                FGEral.fechaquery(QChecaRem);

                Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
// 31.01.06
                if not TEstoqueQtde.eof then begin
                  Sistema.SetField('move_custo',TEstoqueQtde.fieldbyname('custo').ascurrency);
                  Sistema.SetField('move_custoger',TEstoqueQtde.fieldbyname('custoger').ascurrency);
                  Sistema.SetField('move_customedio',TEstoqueQtde.fieldbyname('customedio').ascurrency);
                  Sistema.SetField('move_customeger',TEstoqueQtde.fieldbyname('customeger').ascurrency);
                end else
                  Avisoerro('Não encontrado custo do produto '+produto);
///////////////////////////
///////////////////////////
// 27.10.11
/////////////
                simples:=EdUNid_codigo.ResultFind.fieldbyname('unid_simples').asstring;
                if EdDtmovimento.asdate>1 then begin
                  aliicms:=FEstoque.Getaliquotaicms(produto,Edunid_codigo.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring,EdCliente.asinteger);
                  xcst:=FEstoque.Getsituacaotributaria(produto,EdUnid_codigo.text,
                                     EdCliente.resultfind.fieldbyname('clie_uf').asstring,Global.CodVendaProntaEntrega,0,'N',simples);
                  Sistema.SetField('move_aliicms',aliicms);
                  Sistema.SetField('move_cst',xcst);
                end;
///////////////////

                Sistema.Post('');
                FGeral.FechaQuery(TEstoqueqtde);
              end;
            end;
          end;

          if Grid.Cells[Grid.getcolumn('tipo'),linha]=Global.CodDevolucaoProntaEntrega then begin
              Q:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Grid.Cells[0,linha],EdUnid_codigo.text));
              FGeral.MovimentaQtdeEstoque(Grid.Cells[0,linha],EdUnid_codigo.text,'E',Global.CodDevolucaoProntaEntrega,Texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),linha]),
                                     Q,Texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),linha]) );
              Q.close;
              Freeandnil(Q);
          end;
///////////////////////
// 26.10.11  - Silvano - NFe - aqui gerar 'o fiscal' no movbase
///////////////////////////////////////////////////////////////////
          if EdDtmovimento.asdate>1 then begin
              venda:=Texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),linha]);
              qtde:=Texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),linha]);
              totalitem:=FGeral.Arredonda(venda*qtde,2) - FGeral.Arredonda((venda*qtde)*(Edperdesco.ascurrency/100),3);
              totalit:=FGeral.Arredonda(venda*qtde,2) - FGeral.Arredonda((venda*qtde)*(Edperdesco.ascurrency/100),3);
              icmsitem:=FGeral.arredonda(totalitem*(aliicms/100),2);
              icmssubs:=0;
              basesubs:=0;
              if icmsitem>0 then begin
                Totalbaseicms:=Totalbaseicms+totalitem;
                valoricms:=valoricms+icmsitem;
      //          vlricms:=
              end else
                totalitem:=0;
              TSittributaria:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr( FEstoque.GetCodigosituacaotributaria(produto,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring) ) );

              if (TSittributaria.fieldbyname('sitt_cf').asstring=Global.CodigoSubsTrib) and (EdCliente.resultfind.fieldbyname('clie_tipo').asstring<>'J') then begin
    //            basesubs:=basesubs+( totalitem*(1+(Global.MargemSubsTrib/100)) );
                 margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(produto,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring));
                 basesubs:=( totalitem*(1+(margemlucro/100)) );
                 icmssubs:=(totalitem*(1+(margemlucro/100))) * (aliicms/100);
                 if icmssubs>=icmsitem then
                   icmssubs:=icmssubs-icmsitem
                 else
                   icmssubs:=0;
                 TotalBaseicmsSubs:=TotalBaseicmsSubs+basesubs;
                 valoricmssubs:=valoricmssubs+icmssubs;
              end;

              FGeral.fechaquery(TSittributaria);
              reducao:=0;isentas:=0;outras:=0;
              ValorContabil:=totalit+icmssubs;
              Base:=totalit;
              Valortotal:=ValorTotal+totalit;
              if base=0 then begin
                outras:=totalit;
                base:=totalit;
              end;
              if (EdDtMovimento.asdate<=1) or (Edcliente.resultfind.fieldbyname('clie_tipo').asstring<>'F') then begin
                basesubs:=0;
                icmssubs:=0;
              end;
              if icmssubs>0 then
                outras:=icmssubs;
              FGeral.GeraListaCstPerc(xcst,aliicms,valorcontabil,totalitem,reducao,isentas,outras,basesubs,ListaCstPerc );
          end;

        end;
      end;  // percorre o grid de produtos
// 27.10.11
      if EdDtMovimento.asdate>1 then begin
         for linha:=0 to ListaCstPerc.Count-1 do begin
            PCstPerc:=Listacstperc[linha];
            Sistema.Insert('MovBase');
            Sistema.SetField('movb_transacao',Transacao);
            Sistema.SetField('movb_operacao',FGeral.GetOperacao);
            Sistema.SetField('movb_status','N');
            Sistema.SetField('movb_numerodoc',EdNropedido.asinteger);
            Sistema.SetField('Movb_cst',Pcstperc.cst);
            Sistema.SetField('Movb_TpImposto',Pcstperc.tpimposto );
            Sistema.SetField('Movb_BaseCalculo',Pcstperc.base);
            if pcstperc.reducao>0 then
                Sistema.SetField('Movb_Imposto',FGeral.Arredonda( (( pcstperc.base*(pcstperc.reducao/100) ) ) * (pcstperc.perc/100),2) )
            else
                Sistema.SetField('Movb_Imposto',FGeral.Arredonda( (pcstperc.base) * (pcstperc.perc/100),2) );
            Sistema.SetField('Movb_Aliquota',pcstperc.perc);
            Sistema.SetField('Movb_ReducaoBc',pcstperc.reducao);
            Sistema.SetField('Movb_Isentas',pcstperc.isentas);
            Sistema.SetField('Movb_Outras' ,pcstperc.outras);
            Sistema.SetField('Movb_tipomov',Global.CodVendaProntaEntrega);
            Sistema.SetField('Movb_unid_codigo',EdUnid_codigo.text);
            Sistema.SetField('Movb_natf_codigo',pcstperc.cfop);
            Sistema.Post();
         end;
      end;
      ListaCstPerc.free;

    end;


    procedure GravaDetalhe;
    ///////////////////////
    var linha:integer;
        Q,TEstoqueQtde:TSqlquery;
        produto:string;

    begin
    ///////////////////////////////////////////
      for linha:=1 to Grid.rowcount do begin
        if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha])<>'' then begin
//          codigograde:=FEstoque.GetCodigoGrade(Grid.Cells[0,linha]);
          produto:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha];
          Sistema.Insert('Movestoque');
          Sistema.SetField('move_esto_codigo',produto);
//          codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[0,linha],codigograde);
//          codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[0,linha],codigograde);
          Arq.TEstoque.Locate('esto_codigo',produto,[]);
// 31.01.06
          TEstoqueQtde:=sqltoquery( FEstoque.GetSqlCustos(produto,EdUnid_codigo.text) );

// 03.02.11
          Sistema.SetField('move_tama_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codtamanho'),linha],0 ) );
          Sistema.SetField('move_core_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcor'),linha],0 ) );
          Sistema.SetField('move_copa_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcopa'),linha],0 ) );

          Sistema.SetField('move_transacao',transacao);
          Sistema.SetField('move_operacao',FGeral.GetOperacao);
          Sistema.SetField('move_numerodoc',EdNropedido.asinteger);
//          if tipomov=Global.CodVendaTransf then
//            Sistema.SetField('move_status','F')
//          else
// 25.05.05
            Sistema.SetField('move_status','N');
          Sistema.SetField('move_tipomov',Grid.Cells[Grid.getcolumn('tipo'),linha]);
          Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
          Sistema.SetField('move_tipo_codigo',EdCliente.AsInteger);
          Sistema.SetField('move_tipocad','C');
          Sistema.SetField('move_repr_codigo',EdRepr_codigo.asinteger);
          Sistema.SetField('move_qtde',Texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),linha]));
          Sistema.SetField('move_datalcto',Sistema.Hoje);
//          Sistema.SetField('move_datamvto',EdDtMovimento.asdate);
// 03.02.11
          if EdDtmovimento.IsEmpty then
                  Sistema.SetField('move_datamvto',Sistema.Hoje)
          else
                  Sistema.SetField('move_datamvto',EdDtmovimento.asdate);
          Sistema.SetField('move_datacont',EdDtmovimento.asdate);

          Sistema.SetField('move_qtderetorno',0);
          Sistema.SetField('move_venda',Texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),linha]));
          Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
          Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
          Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
          Sistema.SetField('move_remessas',EdRemessas.text);
          Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
// 31.01.06
          if not TEstoqueQtde.eof then begin
            Sistema.SetField('move_custo',TEstoqueQtde.fieldbyname('custo').ascurrency);
            Sistema.SetField('move_custoger',TEstoqueQtde.fieldbyname('custoger').ascurrency);
            Sistema.SetField('move_customedio',TEstoqueQtde.fieldbyname('customedio').ascurrency);
            Sistema.SetField('move_customeger',TEstoqueQtde.fieldbyname('customeger').ascurrency);
          end;
          Sistema.Post('');
///////////////////
          FGeral.FechaQuery(TEstoqueqtde);
          if Grid.Cells[Grid.getcolumn('tipo'),linha]=Global.CodDevolucaoProntaEntrega then begin
            Q:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Grid.Cells[0,linha],EdUnid_codigo.text));
            FGeral.MovimentaQtdeEstoque(Grid.Cells[0,linha],EdUnid_codigo.text,'E',Global.CodDevolucaoProntaEntrega,Texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),linha]),
                                   Q,Texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),linha]) );
            Q.close;
            Freeandnil(Q);
          end;
        end;
      end;// for
    end;

begin
////////////////////////////

  if PIns.Visible then exit;
  if trim(Grid.Cells[0,Grid.row])='' then exit;
  if EdCliente.isempty then exit;  // 21.11.05
  if Pedidogravado='S' then begin
    Avisoerro('Pedido já gravado');
//    EdNroPedido.setfocus;
    EdCliente.setfocus;
    exit;
  end;
//  if not EdDtMovimento.IsEmpty then begin
//    Avisoerro('Em Pronta entrega não é permitido NFe');
//    exit;
//  end;
  if confirma('Confirma gravação deste pedido ?') then begin
    Fechamento:=false;
    Sistema.BeginTransaction('Gravando');
// 26.10.11 - Silvano - pronta entrega fazer NFe - ver a seria geral no cadastro da unidade
    if not EdDtmovimento.isempty then
      EdNroPedido.SetValue(FGeral.GetContador('NFSAIDA'+EdUnid_codigo.Text+Global.SerieUnidade,false,false)+1);

    Transacao:=FGeral.GetTransacao;
//    tipomov:=Global.CodVendaProntaEntrega;
    tipomov:=EdTipoMov.text;
    valorvenda:=EdValorvenda.ascurrency - (EdValorvenda.ascurrency*(EDperdesco.ascurrency/100));
    if Edperdesco.ascurrency=0 then
      valorvenda:=valorvenda-Edvlrdesco.ascurrency;
    if not Arq.TEstoque.active then Arq.TEstoque.open;
    if Edvlrdesco.ascurrency>0 then
      percdesconto:=(Edvlrdesco.ascurrency/Edvalorvenda.ascurrency)*100
    else
      percdesconto:=Edperdesco.ascurrency;
    GravaMestre;
    if ( (TipoMOv=Global.CodDevolucaoProntaEntrega) or (TipoMOv=Global.CodVendaProntaEntrega) or (TipoMOv=Global.CodVendaProntaEntregaFecha) ) then
//       and  (  (Global.Usuario.Codigo=1) or (Global.Usuario.Codigo=300)  ) then  // 31.10.05 - retirado 11.11.05
      GravaDetalheDividido
    else
      GravaDetalhe;

//    valorcomissao:=FGeral.CalculaComissao(EdRepr_codigo,EdFpgt_codigo.text,Grid,nil,EdUnid_codigo.text);
// 10.07.04 - olha na funcao calcula comissao a questao deste desconto no retorno
    valorcomissao:=FGeral.CalculaComissao(EdRepr_codigo,EdFpgt_codigo.text,Grid,nil,EdUnid_codigo.text);
// 03.02.11
    if Edemissaopedido.isempty then
      demissao:=Sistema.Hoje
    else
      demissao:=Edemissaopedido.asdate;
    if (tipomov=Global.codvendaprontaentrega) and (valorvenda>0) then  // 30.06.04 - checar se somente VP gera financeiro
//      FGeral.GravaPendencia(Edemissaopedido.asdate,EdDtmovimento.asdate,EdCliente,'C',EdRepr_codigo.asinteger,
//              EdUnid_codigo.text,tipomov,Transacao,EdFpgt_codigo.text,'R',EdNropedido.asinteger,
//              0,Valorvenda,Valorcomissao,'N',Valorvenda);
// 23.02.05 - A data movimento na PE nao identifica o datacont pois toda PE é tipo 2
      FGeral.GravaPendencia(dEmissao,Edmovimento.asdate,EdCliente,'C',EdRepr_codigo.asinteger,
              EdUnid_codigo.text,tipomov,Transacao,EdFpgt_codigo.text,'R',EdNropedido.asinteger,
              0,Valorvenda,Valorcomissao,'N',Valorvenda,0,GridParcelas,'',EdPort_codigo.text);

    try
      if not EdDtmovimento.isempty then  // para nao pular a numeracao se 'der pau'
        EdNroPedido.SetValue(FGeral.GetContador('NFSAIDA'+EdUnid_codigo.Text+Global.SerieUnidade,false,true));
      Sistema.EndTransaction('Pedido Gravado');
    except
      Avisoerro('Não foi possível gravar no banco de dados');
    end;
//////////////// - 16.03.05 - colocado aqui para nao fazer para cada produto digitado
    QProddevolvido.close;
    Freeandnil(QProddevolvido);
    Sistema.beginprocess('Pesquisando devoluções');
    QProdDevolvido:=sqltomemoryquery('select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,movestoque.* from movesto,movestoque'+
//          ' where moes_tipo_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
          ' where moes_repr_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
//          ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',tiposmovdev,'C')+
// 11.04.05 - para pegar as VT ja fechadas pelo retorno de RC
// 24.05.05 - para ver as VT ainda nao fechadas pelo retorno de RC
          ' and '+FGEral.Getin('moes_status','N;D','C')+
          ' and '+FGeral.Getin('moes_tipomov',tiposmovdev,'C')+
          ' and moes_unid_codigo=move_unid_codigo'+
          ' and moes_numerodoc=move_numerodoc'+
//           and move_status=''N'''+
          ' and '+FGeral.getin('moes_status','N;D','C')+
//          ' and moes_remessas='+EdRemessas.Assql+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
//          ' and moes_tipomov=move_tipomov'+
          ' and moes_transacao=move_transacao'+
          ' and moes_status=move_status'+
          ' order by move_esto_codigo,moes_numerodoc');
    Sistema.endprocess('');


///////////////
    if (TipoMov=Global.CodDevolucaoProntaEntrega) then begin
      if Global.Topicos[1011] then
        FImpressao.ImprimeRemessa(EdNropedido.asinteger,demissao,Global.CodigoUnidade,Global.CodDevolucaoProntaEntrega)
      else
        FGeral.IMpdevolucao(EdNropedido.asinteger,tipomov,'S')
    end else if (TipoMov=Global.CodVendaTransf) then begin
        FGeral.ImpRemessa(EdNropedido.asinteger,tipomov,'S')
    end else
        FIMpressao.ImprimeNotaSaida(EdNropedido.asinteger,EdEmissaopedido.asdate,EdUnid_codigo.text,tipomov);

    EdNropedido.clearall(FRetprontaentregaNovo,99);
    EdNroPedido.SetValue(FGeral.Getcontador('PEDIDOPTAENTREGA',false));
    EdEmissaoPedido.SetDate(Sistema.Hoje);
    EdDtmovimento.SetDate(Sistema.Hoje);
// 20.09.05
    EdPerdesco.clearall(FRetprontaentregaNovo,99);
//    EdNropedido.setfocus;
    EdCliente.setfocus;
    Grid.clear;
  end;

end;

function TFRetprontaentreganovo.CalculaTotal: currency;
var p:integer;
    vlrtotal:currency;
begin
  vlrtotal:=0;
  for p:=1 to Grid.RowCount do begin
    vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),p])*texttovalor(Grid.Cells[Grid.Getcolumn('move_venda'),p]),2);
  end;
  result:=vlrtotal;
end;

procedure TFRetprontaentreganovo.EdNropedidoValidate(Sender: TObject);
begin
  PedidoGravado:='N';

end;

procedure TFRetprontaentreganovo.EdFpgt_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.LimpaEdit(EdFpgt_codigo,key);
end;

procedure TFRetprontaentreganovo.bConfirmaClick(Sender: TObject);
begin
  EdRemessas.Valid;
  Grid.Clear;

end;

procedure TFRetprontaentreganovo.cbClickCheck(Sender: TObject);
var s:string;
    num:integer;
begin
   s:='';
   for num:=0 to cb.count-1 do begin
     if cb.Checked[num] then
       s:=s+copy(cb.Items[num],1,8)+';';
   end;
   EdRemessas.Text:=s;
end;

procedure TFRetprontaentreganovo.bfechamentoClick(Sender: TObject);
var saldo,valorvenda,precovenda,valorcomissao:currency;
    x:integer;
    transacao,produto,RemessasFechadas:string;
    ListaRemessas:TStringlist;

    procedure GravaMestre;
    begin
        Sistema.Insert('Movesto');
        Sistema.SetField('moes_transacao',Transacao);
        Sistema.SetField('moes_operacao',FGeral.GetOperacao);
        Sistema.SetField('moes_status','N');
//        Sistema.SetField('moes_numerodoc',EdNropedido.asinteger+1);
// 22.02.05
        Sistema.SetField('moes_numerodoc',EdNropedido.asinteger);
        Sistema.SetField('moes_tipomov',Global.CodVendaProntaEntregaFecha);
        Sistema.SetField('moes_unid_codigo',EdUNid_codigo.text);
        Sistema.SetField('moes_tipo_codigo',EdRepr_codigo.asinteger);
    //    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
        Sistema.SetField('moes_estado',FCidades.GetUF(EdRepr_codigo.ResultFind.fieldbyname('repr_cida_codigo').Asinteger));
        Sistema.SetField('moes_repr_codigo',EdRepr_codigo.asinteger);
        Sistema.SetField('moes_tipocad','R');
        Sistema.SetField('moes_datalcto',Sistema.Hoje);
        Sistema.SetField('moes_datamvto',Sistema.Hoje);
        Sistema.SetField('moes_datacont',EdDtmovimento.asdate);
        Sistema.SetField('moes_dataemissao',Sistema.hoje);
        Sistema.SetField('moes_vlrtotal',Valorvenda);
        Sistema.SetField('moes_tabp_codigo',0);
        Sistema.SetField('moes_tabaliquota',0);
        Sistema.SetField('moes_remessas',EdRemessas.text);
        Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('moes_valortotal',Valorvenda);
        Sistema.SetField('moes_totprod',valorvenda); // 16.03.05
// 31.08.05
        if FCondPagto.GetAvPz(EdFpgt_codigo.text)='V' then
          Sistema.SetField('moes_valoravista',valorvenda)
        else
          Sistema.SetField('moes_valoravista',valorparteavista);
// 17.05.06
///        Sistema.SetField('moes_devolucoes',devolucoes);

        Sistema.Post();
    end;

/////////////////// - AQUI É O FECHAMENTO DA PE
// 09.11.05
    procedure GravaDetalheDividido;
    type TMov=record
        remessa:currency;
        saldo:currency;
    end;
    var linha,codigograde,codigolinha,codigocoluna,x:integer;
        Q,QChecaRem:TSqlquery;
        RemessasOK:string;
        saldoprodutoremessa,qtddev,qtddevII:currency;
        Lista:Tlist;
        PMov:^TMov;

        function GetSaldo(codigo:string):currency;
        var saldo:currency;
            nroremdev,x:integer;

///////////////////////////////////////////////////////////////////////////////
{
            procedure Atualiza(doc:currency;qtde:currency;tipomov:string);
            var p:integer;
                found:boolean;
            begin
               found:=false;
               for p:=0 to Lista.count-1 do begin
                 PMov:=Lista[p];
                 if Pmov.remessa=doc then begin
                   found:=true;
                   break;
                 end;
               end;
               if not found then begin
                 New(PMov);
                 PMov.remessa:=doc;
                 PMov.saldo:=qtde;
                 Lista.Add(Pmov);
               end else begin
                 if tipomov=Global.CodRemessaProntaEntrega then
                   PMov.saldo:=PMov.saldo+qtde
                 else
                   PMov.saldo:=PMov.saldo-qtde
               end;
            end;
}
/////////////////////////////////////////////////////////
            procedure Atualiza(doc:currency;qtde:currency;tipomov:string;remessasdev:string='');
            var p:integer;
                found:boolean;
            begin
               found:=false;
               for p:=0 to Lista.count-1 do begin
                 PMov:=Lista[p];
                 if remessasdev='' then begin
                   if Pmov.remessa=doc then begin
                     found:=true;
                     break;
                   end;
                 end else begin
                   if pos( strzero(strtoint(currtostr(Pmov.remessa)),8),remessasdev )>0 then begin   // 21.11.05
                     found:=true;
                     break;
                   end;
                 end;
               end;
               if not found then begin
                 if tipomov=Global.CodRemessaProntaEntrega then begin  // 21.11.05
                   New(PMov);
                   PMov.remessa:=doc;
                   PMov.saldo:=qtde;
                   Lista.Add(Pmov);
                 end;
               end else begin
                 if tipomov=Global.CodRemessaProntaEntrega then
                   PMov.saldo:=PMov.saldo+qtde
                 else
                   PMov.saldo:=PMov.saldo-qtde
               end;
            end;


        begin

          saldo:=0;
          QProdremessaFE.first;
          while not QProdremessaFE.eof do begin
            if codigo=QProdremessaFE.fieldbyname('move_esto_codigo').asstring then begin
              if FGeral.Estaemaberto(QProdRemessaFE.fieldbyname('move_numerodoc').AsString,EdRemessas.text) then begin
                 saldo:=saldo+QProdremessaFE.fieldbyname('move_qtde').asfloat;
                 Atualiza(QProdRemessaFE.fieldbyname('move_numerodoc').Asfloat,QProdremessaFE.fieldbyname('move_qtde').asfloat,
                 QProdRemessaFE.fieldbyname('move_tipomov').AsString);
              end;
            end;
            QProdremessaFE.Next;
          end;
          QProddevolvidoFE.first;
          while not QProdDevolvidoFE.eof do begin
            if codigo=QProddevolvidoFE.fieldbyname('move_esto_codigo').asstring then begin
              if FGeral.EstaemAberto(QProdDevolvidoFE.fieldbyname('move_remessas').AsString,EdRemessas.text) then begin
// 18.05.06
//              if FGeral.EstaemAberto(QProdDevolvidoFE.fieldbyname('moes_remessas').AsString,EdRemessas.text) then begin
                 saldo:=saldo-QProdDevolvidoFE.fieldbyname('move_qtde').asfloat;
                 if copy(QProdDevolvidoFE.fieldbyname('move_remessas').AsString,1,8)<>'' then begin
                   nroremdev:=strtoint(copy(QProdDevolvidoFE.fieldbyname('move_remessas').AsString,1,8));
//                   Atualiza(nroremdev,QProdDevolvido.fieldbyname('move_qtde').asfloat,QProdDevolvido.fieldbyname('move_tipomov').AsString,
//                   QProdDevolvido.fieldbyname('move_remessas').AsString);
// 18.05.06
                   Atualiza(nroremdev,QProdDevolvido.fieldbyname('move_qtde').asfloat,QProdDevolvido.fieldbyname('move_tipomov').AsString,
                   QProdDevolvido.fieldbyname('moes_remessas').AsString);
                 end;
              end;
            end;
            QProddevolvidoFE.Next;
          end;
          result:=saldo;
        end;


    begin

      Lista:=TList.create;
//      for linha:=1 to Grid.rowcount do begin
//        if trim(Grid.Cells[0,linha])<>'' then begin
          codigograde:=FEstoque.GetCodigoGrade(produto);
          codigolinha:=FEstoque.GetCodigoLinha(produto,codigograde);
          codigocoluna:=FEstoque.GetCodigoColuna(produto,codigograde);

//          qtddev:=saldo;
//          qtddevII:=qtddev;
// 19.05.06
          saldoprodutoremessa:=GetSaldo(produto);
          qtddev:=saldoprodutoremessa;
          qtddevII:=saldoprodutoremessa;
          if saldoprodutoremessa>0 then begin
            for x:=0 to Lista.count-1 do begin
              PMov:=Lista[x];
              if Pmov.saldo>=qtddev then
                qtddevII:=Qtddev
              else
                qtddevII:=Pmov.saldo;
              if ( qtddevII>0 ) and ( qtddev>0 ) then begin
                qtddev:=qtddev-qtddevII;  // aqui em 19.05.06
                Sistema.Insert('Movestoque');
//                Sistema.SetField('move_esto_codigo',Grid.Cells[0,linha]);
                Sistema.SetField('move_esto_codigo',produto);
                codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[0,linha],codigograde);
                codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[0,linha],codigograde);
                Arq.TEstoque.Locate('esto_codigo',produto,[]);
                if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
                  Sistema.SetField('move_tama_codigo',codigolinha)
                else
                  Sistema.SetField('move_core_codigo',codigolinha);
                if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
                  Sistema.SetField('move_tama_codigo',codigocoluna)
                else
                  Sistema.SetField('move_core_codigo',codigocoluna);
                Sistema.SetField('move_transacao',transacao);
                Sistema.SetField('move_operacao',FGeral.GetOperacao);
                Sistema.SetField('move_numerodoc',EdNropedido.asinteger);
                Sistema.SetField('move_status','N');
                Sistema.SetField('move_tipomov',Global.CodVendaProntaEntregaFecha);
                Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
                Sistema.SetField('move_tipo_codigo',EdRepr_codigo.asinteger);
                Sistema.SetField('move_tipocad','R');
                Sistema.SetField('move_repr_codigo',EdRepr_codigo.asinteger);
//                Sistema.SetField('move_qtde',Texttovalor(Grid.Cells[3,linha]));
                Sistema.SetField('move_qtde',qtddevII);
                Sistema.SetField('move_datalcto',Sistema.Hoje);
//                Sistema.SetField('move_datamvto',EdDtMovimento.asdate);
// 03.02.11
                if EdDtmovimento.IsEmpty then
                  Sistema.SetField('move_datamvto',Sistema.Hoje)
                else
                  Sistema.SetField('move_datamvto',EdDtmovimento.asdate);
                Sistema.SetField('move_datacont',EdDtmovimento.asdate);

                Sistema.SetField('move_qtderetorno',0);
                Sistema.SetField('move_venda',precovenda);
                Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
                Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
                Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
                Sistema.SetField('move_remessas',formatfloat('00000000',PMov.remessa)+';');
// 07.07.06
                QChecaRem:=sqltoquery('select move_esto_codigo from movestoque where move_numerodoc='+floattostr(PMov.remessa)+
                                      ' and move_unid_codigo='+EdUnid_codigo.assql+' and move_status<>''C'''+
                                      ' and move_tipomov='+stringtosql(Global.CodRemessaProntaEntrega)+
                                      ' and move_repr_codigo='+EdRepr_codigo.assql );
                if QChecaRem.eof then
                   FGeral.Gravalog(10,Grid.Cells[2,linha]+' produto '+Grid.Cells[Grid.GetColumn('move_esto_codigo'),linha]+
                                   'numero '+EdNropedido.text+' Cliente '+EdCliente.text,false,transacao);
                FGEral.fechaquery(QChecaRem);

                Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
                Sistema.Post('');
              end;
            end;
          end;


     //   end;
//      end;  // percorre o grid de produtos
    end;


/////////////////

    procedure GravaDetalhe;
    var codigograde,codigolinha,codigocoluna:integer;

    begin
          codigograde:=FEstoque.GetCodigoGrade(produto);
          Sistema.Insert('Movestoque');
          Sistema.SetField('move_esto_codigo',produto);
          codigolinha:=FEstoque.GetCodigoLinha(produto,codigograde);
          codigocoluna:=FEstoque.GetCodigoColuna(produto,codigograde);
          Arq.TEstoque.Locate('esto_codigo',produto,[]);
          if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
            Sistema.SetField('move_tama_codigo',codigolinha)
          else
            Sistema.SetField('move_core_codigo',codigolinha);
          if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
            Sistema.SetField('move_tama_codigo',codigocoluna)
          else
            Sistema.SetField('move_core_codigo',codigocoluna);
          Sistema.SetField('move_transacao',transacao);
          Sistema.SetField('move_operacao',FGeral.GetOperacao);
//          Sistema.SetField('move_numerodoc',EdNropedido.asinteger+1);
//  22.02.05
          Sistema.SetField('move_numerodoc',EdNropedido.asinteger);
          Sistema.SetField('move_status','N');
          Sistema.SetField('move_tipomov',Global.CodVendaProntaEntregaFecha);
          Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
          Sistema.SetField('move_tipo_codigo',EdRepr_codigo.asinteger);
          Sistema.SetField('move_tipocad','R');
          Sistema.SetField('move_repr_codigo',EdRepr_codigo.asinteger);
          Sistema.SetField('move_qtde',saldo);
          Sistema.SetField('move_datalcto',Sistema.Hoje);
//          Sistema.SetField('move_datamvto',Sistema.Hoje);
// 03.02.11
          if EdDtmovimento.IsEmpty then
                  Sistema.SetField('move_datamvto',Sistema.Hoje)
          else
                  Sistema.SetField('move_datamvto',EdDtmovimento.asdate);
          Sistema.SetField('move_datacont',EdDtmovimento.asdate);

          Sistema.SetField('move_qtderetorno',0);
//          Sistema.SetField('move_venda',QProdremessa.fieldbyname('move_venda').asfloat);
// 31.08.05
          Sistema.SetField('move_venda',precovenda);
          Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
          Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
          Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
          Sistema.SetField('move_remessas',EdRemessas.text);
          Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
          Sistema.Post('');

//          Q:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(produto,EdUnid_codigo.text));
//          FGeral.MovimentaQtdeEstoque(produto,EdUnid_codigo.text,'E',Global.CodDevolucaoProntaEntrega,Texttovalor(Grid.Cells[3,linha]),
//                                 Q,Texttovalor(Grid.Cells[3,linha]) );
//          Freeandnil(Q);

    end;

////////////////// - 18.05.06
    procedure  GravaMestreZerado;
    begin
        Sistema.Insert('Movesto');
        Sistema.SetField('moes_transacao',Transacao);
        Sistema.SetField('moes_operacao',FGeral.GetOperacao);
        Sistema.SetField('moes_status','N');
        Sistema.SetField('moes_numerodoc',EdNropedido.asinteger);
        Sistema.SetField('moes_tipomov',Global.CodVendaProntaEntregaFecha);
        Sistema.SetField('moes_unid_codigo',EdUNid_codigo.text);
        Sistema.SetField('moes_tipo_codigo',EdRepr_codigo.asinteger);
        Sistema.SetField('moes_estado',FCidades.GetUF(EdRepr_codigo.ResultFind.fieldbyname('repr_cida_codigo').Asinteger));
        Sistema.SetField('moes_repr_codigo',EdRepr_codigo.asinteger);
        Sistema.SetField('moes_tipocad','R');
        Sistema.SetField('moes_datalcto',Sistema.Hoje);
        Sistema.SetField('moes_datamvto',Sistema.Hoje);
// 03.02.11
        Sistema.SetField('moes_datacont',EdDtmovimento.asdate);

        Sistema.SetField('moes_dataemissao',Sistema.hoje);
        Sistema.SetField('moes_vlrtotal',Valorvenda);
        Sistema.SetField('moes_tabp_codigo',0);
        Sistema.SetField('moes_tabaliquota',0);
        Sistema.SetField('moes_remessas',EdRemessas.text);
        Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('moes_valortotal',0);
        Sistema.SetField('moes_totprod',0);
        Sistema.SetField('moes_valoravista',0);
        Sistema.Post();
    end;

    procedure  GravaDetalheZerado;
      var codigograde,codigolinha,codigocoluna:integer;
          produto:string;
    begin
          produto:='87007';
          codigograde:=FEstoque.GetCodigoGrade(produto);
          Sistema.Insert('Movestoque');
          Sistema.SetField('move_esto_codigo',produto);
          codigolinha:=FEstoque.GetCodigoLinha(produto,codigograde);
          codigocoluna:=FEstoque.GetCodigoColuna(produto,codigograde);
          Arq.TEstoque.Locate('esto_codigo',produto,[]);
          if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
            Sistema.SetField('move_tama_codigo',codigolinha)
          else
            Sistema.SetField('move_core_codigo',codigolinha);
          if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
            Sistema.SetField('move_tama_codigo',codigocoluna)
          else
            Sistema.SetField('move_core_codigo',codigocoluna);
          Sistema.SetField('move_transacao',transacao);
          Sistema.SetField('move_operacao',FGeral.GetOperacao);
//          Sistema.SetField('move_numerodoc',EdNropedido.asinteger+1);
//  22.02.05
          Sistema.SetField('move_numerodoc',EdNropedido.asinteger);
          Sistema.SetField('move_status','N');
          Sistema.SetField('move_tipomov',Global.CodVendaProntaEntregaFecha);
          Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
          Sistema.SetField('move_tipo_codigo',EdRepr_codigo.asinteger);
          Sistema.SetField('move_tipocad','R');
          Sistema.SetField('move_repr_codigo',EdRepr_codigo.asinteger);
          Sistema.SetField('move_qtde',0);
          Sistema.SetField('move_datalcto',Sistema.Hoje);
//          Sistema.SetField('move_datamvto',Sistema.Hoje);
// 03.02.11
          if EdDtmovimento.IsEmpty then
                  Sistema.SetField('move_datamvto',Sistema.Hoje)
          else
                  Sistema.SetField('move_datamvto',EdDtmovimento.asdate);
          Sistema.SetField('move_datacont',EdDtmovimento.asdate);

          Sistema.SetField('move_qtderetorno',0);
          Sistema.SetField('move_venda',precovenda);
          Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
          Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
          Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
          Sistema.SetField('move_remessas',EdRemessas.text);
          Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
          Sistema.Post('');

    end;

///////////////////


// 11.05.06
//    function DevolucaoMaiorRemessa:boolean;
    function DevolucaoMaiorRemessa:string;
    var p:integer;
    begin
      result:='';
      for p:=1 to GridCodigos.rowcount do begin
        if trim(Gridcodigos.cells[0,p])<>'' then begin
          if texttovalor( Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),p] )<0 then begin
//            Avisoerro('Produto '+Gridcodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),p]+' com saldo negativo');
//            result:=true;
              result:=result+Gridcodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),p]+' : '+
                 Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),p]
                 +' ; ';
          end;
        end;
      end;
    end;

var produtosnega:string;
    demissao:TDatetime;

begin
//////////////////////////////////

  if trim(Grid.Cells[0,Grid.row])<>'' then begin
    Avisoerro('Item digitado.  Gravar o pedido ou devolução antes de fazer o fechamento');
    exit;
  end;

  Fechamento:=true;
  if not EdRemessas.valid then exit;  // 19.04.05
// 20.08.05
  EdFpgt_codigo.enabled:=true;
  EdPerdesco.enabled:=true;
  Edvlrdesco.enabled:=true;

  if EdFpgt_codigo.isempty then begin
    if not EdFpgt_codigo.valid then begin
       Avisoerro('Checar condição de pagamento');
       exit;
    end;
  end;

  if Gridparcelas.cells[1,1]='' then EdFpgt_codigo.valid;

  ListaRemessasFechadas:=Tstringlist.create;   // 31.05.06
  RemessasFechadas:='';
// 03.05.06 -
//    if DevolucaoMaiorRemessa then
//      exit;
// 12.05.06
  produtosnega:=DevolucaoMaiorremessa;
  if trim(produtosnega)<>'' then
    Showmessage('Codigos com saldo negativo :'+produtosnega);

  if not confirma('Confirma fechamento da(s) remessa(s) ?') then exit;
//////////////////////////////////////////////////////
//  ver como faturar o saldo final como venda para o representante
  if not Arq.TEstoque.active then Arq.TEstoque.open;
  Transacao:=FGeral.GetTransacao;
  EdNroPedido.SetValue(FGeral.Getcontador('PEDIDOPTAENTREGA',false));
  if QProddevolvido<>nil then begin
    QProddevolvido.close;
    Freeandnil(QProddevolvido);
  end;
  Sistema.beginprocess('Checando devoluções');
////////////////////////
{
  QProdDevolvido:=Sqltomemoryquery('select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,movestoque.* from movesto,movestoque'+
//          ' where moes_tipo_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
          ' where moes_repr_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
// 11.04.05 - para ver as VT ja fechadas pelo retorno de RC
          ' and '+FGEral.Getin('moes_status','N;D','C')+
          ' and '+FGeral.Getin('moes_tipomov',tiposmovdev,'C')+
          ' and moes_unid_codigo=move_unid_codigo'+
          ' and moes_numerodoc=move_numerodoc'+
//           and move_status=''N'''+
          ' and '+FGEral.Getin('move_status','N;D','C')+
//          ' and moes_remessas='+EdRemessas.Assql+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
//          ' and moes_tipomov=move_tipomov'+
          ' and moes_transacao=move_transacao'+
          ' and moes_status=move_status'+
          ' order by move_esto_codigo,moes_numerodoc');
}
////////////////////////
// 31.10.05
  QProdDevolvido:=Sqltomemoryquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
          ' where move_repr_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
// 11.04.05 - para ver as VT ja fechadas pelo retorno de RC
          ' and '+FGEral.Getin('move_status','N;D','C')+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
//          ' and move_tipomov<>'+inttostr(coddevnao)+   // 27.09.05 - VB ref. consignação- aqui so em 29.11.05
// 26.10.11
          ' order by move_esto_codigo,move_numerodoc');
/////////////
// 29.11.05
  QProdDevolvidoFe:=Sqltomemoryquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
          ' where move_repr_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
          ' and '+FGEral.Getin('move_status','N;D','C')+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
          ' and '+FGEral.Getin('move_status','N;D','C')+
//          ' and move_tipomov<>'+inttostr(coddevnao)+   // 27.09.05 - VB ref. consignação
// 26.10.11
          ' order by move_esto_codigo,moes_numerodoc');

  Sistema.endprocess('');
  if QProddevolvido.eof then begin
    if not confirma('Nenhuma devolução encontrada.    Efetuar fechamento mesmo assim ?') then begin
      QProddevolvido.close;
      exit;
    end;
  end;

  Sistema.Begintransaction('Efetuando fechamento');
  valorvenda:=0;
  QProdRemessa.first;
  while not QProdRemessa.eof do begin
    Produto:=QProdremessa.fieldbyname('move_esto_codigo').asstring;
    saldo:=0;
///////////    precovenda:=QProdremessa.fieldbyname('move_venda').asfloat;
// retirado pois tem q colocar o preco de venda q foi usado nas remessas
    precovenda:=0;
    while (not QProdRemessa.eof) and (Produto=QProdremessa.fieldbyname('move_esto_codigo').asstring) do begin
// 16.03.05
      if FGeral.Estaemaberto(QProdRemessa.fieldbyname('moes_numerodoc').AsString,EdRemessas.text) then begin
        saldo:=saldo+QProdremessa.fieldbyname('move_qtde').Asfloat;
        precovenda:=QProdremessa.fieldbyname('move_venda').asfloat;
      end;
      QProdRemessa.next;
    end;
    QProdDevolvido.first;
    while not QProdDevolvido.eof do begin
      if Produto=QProddevolvido.fieldbyname('move_esto_codigo').asstring then begin
        if FGeral.EstaemAberto(QProdDevolvido.fieldbyname('move_remessas').AsString,EdRemessas.text) then begin
//  17.05.06
//        if FGeral.EstaemAberto(QProdDevolvido.fieldbyname('moes_remessas').AsString,EdRemessas.text) then
          saldo:=saldo-QProddevolvido.fieldbyname('move_qtde').Asfloat;
// 31.05.06
          if ListaremessasFechadas.indexof(copy(QProdDevolvido.fieldbyname('move_remessas').AsString,1,8))=-1 then begin
                  ListaremessasFechadas.add(copy(QProdDevolvido.fieldbyname('move_remessas').AsString,1,8));
                  remessasfechadas:=remessasfechadas+copy(QProdDevolvido.fieldbyname('move_remessas').AsString,1,8)+';';
          end;
        end;  // 14.06.06
      end;
      QProdDevolvido.Next;
    end;

    for x:=1 to Grid.rowcount do begin
      if Produto=Grid.cells[Grid.Getcolumn('move_esto_codigo'),x] then begin
          saldo:=saldo-texttovalor( Grid.cells[Grid.Getcolumn('move_qtde'),x] );
      end;
    end;
    if saldo>0 then begin
// conferir se pode ser pelo preço da remessas ou pelo valor atual na época do fechamento
      x:=FGeral.ProcuraGrid(0,produto,Gridcodigos);
      if x<=0 then Avisoerro('Produto '+produto+' não encontrado no grid de codigos')
      else if saldo<>texttovalor(Gridcodigos.cells[Gridcodigos.Getcolumn('move_qtde'),x] ) then
        avisoerro('Saldo '+Gridcodigos.cells[Gridcodigos.Getcolumn('move_qtde'),x]+' -  Saldo consulta saldo '+currtostr(saldo));

       valorvenda:=valorvenda+(saldo*precovenda);
       if Precovenda=0 then begin
         Avisoerro('Produto '+Produto+' com saldo mas sem preço de venda.   Cancelado Fechamento');
         exit;
       end;
//       if  (Global.Usuario.Codigo=1) or (Global.Usuario.Codigo=300) then  // 09.11.05 - retirado  -11.11.05
         GravaDetalheDividido
//       else
//         Gravadetalhe;
    end else if saldo<0 then
      avisoerro('Produto '+produto+' com saldo negativo '+currtostr(saldo) );
//    QProdremessa.next;
  end;
  if valorvenda>0 then begin
    GravaMestre;
  end else begin  // 18.05.06
    GravaMestreZerado;
    GravaDetalheZerado;
  end;

//////////////////////////////////////////////////////
{
  ExecuteSql('Update movesto set moes_status=''E'' where moes_repr_codigo='+EdRepr_codigo.AsSql+
                     ' and '+FGeral.GetIN('moes_numerodoc',EdRemessas.TExt,'N')+
                     ' and moes_unid_codigo='+EdUnid_codigo.assql+
                     ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',Global.CodRemessaProntaEntrega,'C') );
}
// baixa as  remessas de pronta entrega
////////////////////////////////////////

  Sistema.Edit('movesto');
  Sistema.Setfield('moes_status','E');
// 02.05.06
  Sistema.Setfield('moes_dataacerto',sistema.hoje);
  Sistema.Setfield('moes_transacerto',transacao);
//  Sistema.post('moes_repr_codigo='+EdRepr_codigo.AsSql+
//               ' and '+FGeral.GetIN('moes_numerodoc',EdRemessas.TExt,'N')+
//               ' and moes_unid_codigo='+EdUnid_codigo.assql+
//               ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',Global.CodRemessaProntaEntrega,'C') );
  Sistema.post('moes_repr_codigo='+EdRepr_codigo.AsSql+
               ' and '+FGeral.GetIN('moes_numerodoc',RemessasFechadas,'N')+
               ' and moes_unid_codigo='+EdUnid_codigo.assql+
               ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',Global.CodRemessaProntaEntrega,'C') );

//////////////////////////////////////////

  Sistema.Edit('movestoque');
  Sistema.Setfield('move_status','E');
//  Sistema.post('move_repr_codigo='+EdRepr_codigo.AsSql+
//               ' and '+FGeral.GetIN('move_numerodoc',EdRemessas.TExt,'N')+
//               ' and move_unid_codigo='+EdUnid_codigo.assql+
//               ' and move_status=''N'' and '+FGeral.Getin('move_tipomov',Global.CodRemessaProntaEntrega,'C') );
  Sistema.post('move_repr_codigo='+EdRepr_codigo.AsSql+
               ' and '+FGeral.GetIN('move_numerodoc',RemessasFechadas,'N')+
               ' and move_unid_codigo='+EdUnid_codigo.assql+
               ' and move_status=''N'' and '+FGeral.Getin('move_tipomov',Global.CodRemessaProntaEntrega,'C') );

// baixa as vendas pronta entrega, brinde, devolução .etc
//////////////////////////////////////////////////////////////
// - por enquanto deixar o mestre com status N
  Sistema.Edit('movesto');
///////////////////////////  Sistema.Setfield('moes_status','E');
// 02.05.06
  Sistema.Setfield('moes_dataacerto',sistema.hoje);
  Sistema.Setfield('moes_transacerto',transacao);
  Sistema.post('moes_repr_codigo='+EdRepr_codigo.AsSql+
//               ' and moes_remessas='+EdRemessas.Assql+
// 16.03.05
//               ' and '+FGeral.similarto('moes_remessas',EdRemessas.text)+
               ' and '+FGeral.similarto('moes_remessas',RemessasFechadas)+
               ' and moes_unid_codigo='+EdUnid_codigo.assql+
//               ' and '+Fgeral.getin('moes_status','N;F','C')+
               ' and '+Fgeral.getin('moes_status','N','C')+
               ' and '+FGeral.Getin('moes_tipomov',tiposmovbai,'C') );

//////////////////////////////////////////////////////////////

///////////////////// - 05.01.06
  ListaRemessas:=TStringlist.create;
//  strtolista(ListaRemessas,EdRemessas.text,';',true);
// 31.05.06
  strtolista(ListaRemessas,RemessasFechadas,';',true);
  for x:=0 to LIstaremessas.count-1 do begin
    if strtointdef(LIstaremessas[x],0)>0 then begin
      Sistema.Edit('movestoque');
      Sistema.Setfield('move_status','E');
      Sistema.post('move_repr_codigo='+EdRepr_codigo.AsSql+
               ' and '+FGeral.similarto('move_remessas',LIstaremessas[x])+
               ' and move_unid_codigo='+EdUnid_codigo.assql+
               ' and '+Fgeral.getin('move_status','N','C')+
               ' and '+FGeral.Getin('move_tipomov',tiposmovbai,'C') );
    end;
  end;
  ListaRemessas.free;

{ - 05.01.06
  Sistema.Edit('movestoque');
  Sistema.Setfield('move_status','E');
  Sistema.post('move_repr_codigo='+EdRepr_codigo.AsSql+
//               ' and move_remessas='+EdRemessas.Assql+
//               ' and '+FGeral.similarto('move_remessas',EdRemessas.text)+
// 04.01.06 - REajustado devido a mudança de gravar apenas uma remessa por move_remessa quando faz VP ou DP...
               ' and move_remessas in ('+FGeral.Convertetoin(EdRemessas.text,';')+')'+
// 25.11.05 - ajustado devido a mudança de gravar apenas uma remessa por move_remessa quando faz VP ou DP...
//               ' and move_remessas Similar to ('+stringtosql(FGeral.Convertetoin(EdRemessas.text,';'))+')'+
               ' and move_unid_codigo='+EdUnid_codigo.assql+
//               ' and '+Fgeral.getin('move_status','N;F','C')+
               ' and '+Fgeral.getin('move_status','N','C')+
               ' and '+FGeral.Getin('move_tipomov',tiposmovbai,'C') );
}

  sistema.commit;

/////////////////////// - 25.05.05
// refeito trato das VT já fechadas na consignação
  Sistema.Edit('movesto');
  Sistema.Setfield('moes_status','F');
// 02.05.06
  Sistema.Setfield('moes_dataacerto',sistema.hoje);
  Sistema.Setfield('moes_transacerto',transacao);
  Sistema.post('moes_repr_codigo='+EdRepr_codigo.AsSql+
//               ' and '+FGeral.similarto('moes_remessas',EdRemessas.text)+
               ' and '+FGeral.similarto('moes_remessas',RemessasFechadas)+
               ' and moes_unid_codigo='+EdUnid_codigo.assql+
               ' and moes_status=''D'' and '+FGeral.Getin('moes_tipomov',Global.CodVendaTransf,'C') );

  Sistema.Edit('movestoque');
  Sistema.Setfield('move_status','F');
  Sistema.post('move_repr_codigo='+EdRepr_codigo.AsSql+
//               ' and '+FGeral.similarto('move_remessas',EdRemessas.text)+
               ' and '+FGeral.similarto('move_remessas',RemessasFechadas)+
               ' and move_unid_codigo='+EdUnid_codigo.assql+
               ' and move_status=''D'' and '+FGeral.Getin('move_tipomov',Global.CodVendaTransf,'C') );

///////////////////////

// 01.03.05 - gravacao do financeiro cfe condicao de pagto digitada
    if (not EdFpgt_codigo.isempty) and (valorvenda>0) then begin
      valorcomissao:=FGeral.CalculaComissao(EdRepr_codigo,EdFpgt_codigo.text,Grid,nil,EdUnid_codigo.text);
// 03.02.11
      if Edemissaopedido.isempty then
        demissao:=Sistema.Hoje
      else
        demissao:=Edemissaopedido.asdate;
      FGeral.GravaPendencia(demissao,Edmovimento.asdate,EdRepr_codigo,'R',EdRepr_codigo.asinteger,
              EdUnid_codigo.text,Global.CodVendaProntaEntregaFecha,Transacao,EdFpgt_codigo.text,'R',EdNropedido.asinteger,
              0,Valorvenda,Valorcomissao,'N',Valorvenda,0,GridParcelas,'',EdPort_codigo.text);
    end;

  Sistema.endtransaction('');

  if valorvenda>0 then
    FIMpressao.ImprimeNotaSaida(EdNropedido.asinteger,EdEmissaopedido.asdate,EdUnid_codigo.text,Global.CodVendaProntaEntregaFecha);

  EdRepr_codigo.clearall(FRetprontaentregaNovo,99);
// 31.05.06
  EdDtMovimento.SetDate(Sistema.Hoje);
  EdUnid_codigo.text:=Global.CodigoUnidade;
////////////////
  Cb.Clear;
  EdNropedido.clearall(FRetprontaentregaNovo,99);
  EdEmissaoPedido.SetDate(Sistema.Hoje);
  EdRepr_codigo.setfocus;
end;

procedure TFRetprontaentreganovo.EdClienteValidate(Sender: TObject);
begin
  PedidoGravado:='N';

end;

procedure TFRetprontaentreganovo.EdDtMovimentoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  FGeral.PoeData(EdDtmovimento,key);

end;

procedure TFRetprontaentreganovo.EdFpgt_codigoExitEdit(Sender: TObject);
begin
//  bincluiritemclick(FRetprontaentrega);
  bgravapedidoclick(FRetprontaentregaNovo);
end;

procedure TFRetprontaentreganovo.EdTipoMovValidate(Sender: TObject);
begin
   if EdTipomov.text=Global.CodVendaProntaEntrega then begin
     EdFpgt_codigo.enabled:=true;
     EdPerdesco.enabled:=true;
     Edvlrdesco.enabled:=true;
   end else begin
     EdFpgt_codigo.enabled:=false;
     EdFpgt_codigo.text:='';
     EdPerdesco.enabled:=false;
     Edvlrdesco.enabled:=false;
     EdPerdesco.setvalue(0);
     Edvlrdesco.setvalue(0);
   end;
end;

procedure TFRetprontaentreganovo.Edunid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.LimpaEdit(EdUnid_codigo,key);
end;

procedure TFRetprontaentreganovo.EdProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#27 then begin
    bcancelaritemclick(FRetprontaentregaNovo);
    if Edtipomov.text=Global.CodVendaProntaEntrega then begin
      EdFpgt_codigo.text:='';
      EdFpgt_codigo.valid;
//      EdFpgt_codigo.enabled:=true;
//      EdPerdesco.enabled:=true;
//      Edvlrdesco.enabled:=true;
    end else
//    EdFpgt_codigo.setfocus;
    bgravapedidoclick(FRetprontaentregaNovo);
  end;


end;

procedure TFRetprontaentreganovo.GridCodigosClick(Sender: TObject);
var linha,x:integer;
    saldo:currency;
begin
  if trim(Gridcodigos.cells[0,gridcodigos.row])='' then exit;
  produtoescolhido:=Gridcodigos.cells[0,gridcodigos.row];
  EdProduto.text:=produtoescolhido;
  GridSaldo.clear;linha:=1;saldo:=0;
  GridSaldo.RowCount:=2;
  QProdremessa.first;
  while not QProdremessa.eof do begin
// 01.03.05
    if FGeral.Estaemaberto(QProdRemessa.fieldbyname('moes_numerodoc').AsString,EdRemessas.text) then begin
      if EdProduto.text=QProdremessa.fieldbyname('move_esto_codigo').asstring then begin
        GridSaldo.Cells[GridSaldo.getcolumn('move_datamvto'),linha]:=QProdremessa.fieldbyname('move_datamvto').Asstring;
        GridSaldo.Cells[GridSaldo.getcolumn('move_numerodoc'),linha]:=QProdremessa.fieldbyname('move_numerodoc').Asstring;
        GridSaldo.Cells[GridSaldo.getcolumn('move_tipomov'),linha]:=QProdremessa.fieldbyname('move_tipomov').Asstring;
        GridSaldo.Cells[GridSaldo.getcolumn('move_qtde'),linha]:=QProdremessa.fieldbyname('move_qtde').Asstring;
        saldo:=saldo+QProdremessa.fieldbyname('move_qtde').Asfloat;
        GridSaldo.Cells[GridSaldo.getcolumn('saldo'),linha]:=FGeral.formatavalor(saldo,'####0');
        inc(linha);
        GridSaldo.RowCount:=linha+1;
      end;
    end;
    QProdremessa.Next;
  end;
  QProddevolvido.first;
  while not QProdDevolvido.eof do begin
    if EdProduto.text=QProddevolvido.fieldbyname('move_esto_codigo').asstring then begin
//      if (ansipos(QProdDevolvido.fieldbyname('move_remessas').AsString,trim(EdRemessas.text))>0) and
//         (QProdDevolvido.fieldbyname('move_remessas').AsString<>'')
//        then begin
      if FGeral.EstaemAberto(QProdDevolvido.fieldbyname('move_remessas').AsString,EdRemessas.text) then begin
// 11.05.06
//      if FGeral.EstaemAberto(QProdDevolvido.fieldbyname('moes_remessas').AsString,EdRemessas.text) then begin
        GridSaldo.Cells[GridSaldo.getcolumn('move_datamvto'),linha]:=QProddevolvido.fieldbyname('move_datamvto').Asstring;
        GridSaldo.Cells[GridSaldo.getcolumn('move_numerodoc'),linha]:=QProddevolvido.fieldbyname('move_numerodoc').Asstring;
        GridSaldo.Cells[GridSaldo.getcolumn('move_tipomov'),linha]:=QProddevolvido.fieldbyname('move_tipomov').Asstring;
        GridSaldo.Cells[GridSaldo.getcolumn('move_qtde'),linha]:=QProddevolvido.fieldbyname('move_qtde').Asstring;
        saldo:=saldo-QProddevolvido.fieldbyname('move_qtde').Asfloat;
        GridSaldo.Cells[GridSaldo.getcolumn('saldo'),linha]:=FGeral.formatavalor(saldo,'####0');
        inc(linha);
        GridSaldo.RowCount:=linha+1;
      end;
    end;
    QProdDevolvido.Next;
  end;
  for x:=1 to Grid.rowcount do begin
    if EdProduto.text=Grid.cells[Grid.Getcolumn('move_esto_codigo'),x] then begin
        GridSaldo.Cells[GridSaldo.getcolumn('move_datamvto'),linha]:=formatdatetime('dd/mm/yy',EdEmissaopedido.asdate);
        GridSaldo.Cells[GridSaldo.getcolumn('move_tipomov'),linha]:=EdTipomov.text;
        GridSaldo.Cells[GridSaldo.getcolumn('move_qtde'),linha]:=Grid.cells[Grid.Getcolumn('move_qtde'),x];
        saldo:=saldo-texttovalor( Grid.cells[Grid.Getcolumn('move_qtde'),x] );
        GridSaldo.Cells[GridSaldo.getcolumn('saldo'),linha]:=FGeral.formatavalor(saldo,'####0');
        inc(linha);
        GridSaldo.RowCount:=linha+1;
    end;
  end;
//////////  GridSaldo.Seek(GridSaldo.getcolumn('move_numerodoc'),'99999');
// 29.12.05 - retirado pois muda ordem de apresentação
end;

procedure TFRetprontaentreganovo.Edperdesco1Validate(Sender: TObject);
begin
  if EdPerdesco.ascurrency>0 then begin
    EdVlrDesco.setvalue(0);
    EdVlrdesco.enabled:=false;
  end else begin
    EdVlrDesco.setvalue(0);
    EdVlrdesco.enabled:=true;
  end;

end;

procedure TFRetprontaentreganovo.EdEmissaopedidoExitEdit(Sender: TObject);
begin
  bincluiritemclick(FRetprontaentregaNovo);
end;

procedure TFRetprontaentreganovo.GridParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    GridParcelasDblClick(FRetProntaentregaNovo);

end;

procedure TFRetprontaentreganovo.GridParcelasDblClick(Sender: TObject);
begin
  AtivaEditsParcelas;

end;

procedure TFRetprontaentreganovo.AtivaEditsParcelas;
begin
  if GridParcelas.Col=0 then begin
     EdVencimento.Top:=GridParcelas.TopEdit;
     EdVencimento.Left:=GridParcelas.LeftEdit+5;
     EdVencimento.Text:=StrToStrNumeros(GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]);
//     EdVencimento.Text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
     EdVencimento.Visible:=True;
     EdVencimento.SetFocus;
  end else if GridParcelas.Col=1 then begin
     EdParcela.Top:=GridParcelas.TopEdit;
     EdParcela.Left:=GridParcelas.LeftEdit+6;
     EdParcela.SetValue(TextToValor(GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]));
     EdParcela.Visible:=True;
     EdParcela.SetFocus;
  end;


end;

function TFRetprontaentreganovo.ValorDesconto(valor: currency): currency;
begin
    if EdPerDesco.ascurrency>0 then begin
      EdVlrdesco.setvalue(valor*(EdPerDesco.ascurrency/100));
      result:=valor*(EdPerDesco.ascurrency/100)
    end else if EdVlrdesco.ascurrency>0 then
      result:=EdVlrdesco.ascurrency
    else
      result:=0;

end;

procedure TFRetprontaentreganovo.EdParcelaExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=Transform(EdParcela.AsFloat,f_cr);
  GridParcelas.SetFocus;
  EdParcela.Visible:=False;


end;

procedure TFRetprontaentreganovo.EdVencimentoExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=DateToStr_(EdVencimento.AsDate);
  GridParcelas.SetFocus;
  EdVencimento.Visible:=False;

end;

procedure TFRetprontaentreganovo.Edfpgt_codigoValidate(Sender: TObject);
var nparcelas,n:integer;
    ListaPrazo:TStringlist;
    p:integer;
    valorparcela,valortotal,valoravista,acumulado,vlrnf:currency;
    aliicms,baseicms,vlricms,basesubs,icmssubs,valorvenda:currency;
    produto:string;

begin
  if (FCondPagto.GetAvPz(EdFpgt_codigo.text)='V') or (Fcondpagto.Getprimeiroprazo(EdFpgt_codigo.text)=0) then begin
    if EdUnid_codigo.Resultfind.fieldbyname('Unid_contacontabil').AsInteger=0 then begin
      EdFpgt_codigo.INvalid('Unidade sem conta caixa cadastrada para lançamentos a vista');
      exit;
    end;
  end;
  valorparteavista:=0;
//  if (EdFpgt_codigo.text<>EdFpgt_codigo.OldValue) then
  GridParcelas.Clear;

//  if EdValorvenda.ascurrency>0 then begin
  if fechamento then
    valorvenda:=EdValorvendatotal.ascurrency
  else
    valorvenda:=EdValorvenda.ascurrency;

  if Valorvenda>0 then begin
//////////////////////////// - 11.03.05
     vlrnf:=Valorvenda-valordesconto(Valorvenda);
     if ( pos( Global.UFUnidade,'SC;RS' ) > 0 )   and (EdDtmovimento.asdate>0) then begin
       produto:=Gridcodigos.cells[0,1];
       if Edtipomov.text=global.CodVendaRE then begin
         if trim( produto )<>'' then begin
           aliicms:=FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,EdCliente.resultfind.fieldbyname('clie_uf').asstring )
         end else
           aliicms:=17;
         baseicms:=vlrnf;
         vlricms:=baseicms*(aliicms/100);
         if EdCliente.resultfind.fieldbyname('clie_tipo').asstring='F' then begin  // 15.07.05
           basesubs:=vlrnf+( (vlrnf)*(Global.MargemSubsTrib/100) );
           icmssubs:=basesubs*(aliicms/100);
           icmssubs:=icmssubs-vlricms;
         end else begin
           basesubs:=0;
           icmssubs:=0;
         end;

       end else begin

         if trim( produto )<>'' then begin
           aliicms:=FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,FCidades.GetUF(EdRepr_codigo.resultfind.fieldbyname('repr_cida_codigo').asinteger) )
         end else
           aliicms:=17;
         baseicms:=vlrnf;
         vlricms:=baseicms*(aliicms/100);
//         if EdRepr_codigo.resultfind.fieldbyname('clie_tipo').asstring='F' then begin  // 15.07.05
// ver se futuramente precisa identificar nos representantes se é pessoa física ou juridica
//           basesubs:=vlrnf+( (vlrnf)*(Global.MargemSubsTrib/100) );
//           icmssubs:=basesubs*(aliicms/100);
//           icmssubs:=icmssubs-vlricms;
//         end else begin
           basesubs:=0;
           icmssubs:=0;
//         end;
       end;
     end else
       icmssubs:=0;
/////////////////////////////
    ListaPrazo:=TStringlist.create;
    n:=FCondPagto.GetPrazos(EdFpgt_codigo.text,ListaPrazo);
// 14.03.05
//    totalnota:=roundvalor( vlrnf+icmssubs-(valordesconto(EdValorvenda.ascurrency)) );
// 30.03.05 - vlrnf ja tem o desconto
    totalnota:=roundvalor( vlrnf+icmssubs );
    totalNf:=totalnota;
    if FCondPagto.GetAvPz(EdFpgt_codigo.text)='V' then
      valoravista:=totalnota
    else begin
      if (Fcondpagto.GetPrimeiroPrazo(EdFpgt_codigo.text)=0) and (Fcondpagto.GetNumeroParcelas(EdFpgt_codigo.text)>1) then
         valoravista:=FGeral.GetValorAvista(Listaprazo,icmssubs)
      else
         valoravista:=0;
      valorparteavista:=valoravista;
      valortotal:=totalnota - valoravista;
    end;
    nparcelas:=FCondPagto.GetNumeroParcelas(EdFpgt_codigo.text);
// 11.03.05 - reges pegou bug quando tem parte a vista e mais de duas parcelas
    acumulado:=0;
    for p:=1 to nparcelas do begin
      GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',FGeral.GetProximoDiaUtil(EdEmissaoPedido.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  );
      if (p=nparcelas) and (valoravista=0) then
        valorparcela:=valortotal-acumulado  // para deixar na ultima parcelas "as dízimas"
      else begin
        if (valoravista>0) and (nparcelas>1) then begin   // 14.03.05
          valorparcela:=FGeral.Arredonda(valortotal/(nparcelas-1),2);
          if (p=nparcelas) then
            valorparcela:=valortotal+valoravista-acumulado  // para deixar na ultima parcelas "as dízimas" - 02.06.05
        end else
          valorparcela:=FGeral.Arredonda((valortotal)/nparcelas,2);
      end;
      if (valoravista>0) and (p=1) then begin
        GridParcelas.cells[1,p]:=Transform(valoravista,f_cr);
        acumulado:=acumulado+valoravista;
      end else begin
        GridParcelas.cells[1,p]:=Transform(valorparcela,f_cr);
        acumulado:=acumulado+valorparcela;
      end;
      GridParcelas.RowCount:=GridParcelas.RowCount+1;
    end;  // for do numero de parcelas
    Freeandnil(ListaPrazo);
    Gridparcelas.setfocus;
  end;
end;

procedure TFRetprontaentreganovo.EdperdescoValidate(Sender: TObject);
begin
  if EdPerdesco.ascurrency>0 then begin
    EdVlrDesco.setvalue( EdValorvenda.ascurrency*(EdPerdesco.ascurrency/100) );
    EdVlrdesco.enabled:=false;
  end else begin
    EdVlrDesco.setvalue(0);
    EdVlrdesco.enabled:=true;
  end;
  if not EdFpgt_codigo.isempty then EDFpgt_codigo.valid;

end;

procedure TFRetprontaentreganovo.EdVlrdescoValidate(Sender: TObject);
var perdesc:currency;
begin
  if EdVlrdesco.ascurrency>0 then begin
    if EdValorvenda.ascurrency>0 then begin
      perdesc:=(EdVlrdesco.ascurrency/EdValorvenda.ascurrency)*100;
      EdPerdesco.setvalue(perdesc);
    end;
  end;
  if not EdFpgt_codigo.isempty then EDFpgt_codigo.valid;

end;

procedure TFRetprontaentreganovo.EdTipoMovKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.limpaedit( EdTipomov, key );
end;

procedure TFRetprontaentreganovo.cbDblClick(Sender: TObject);
var s,marca:string;
    num:integer;
begin
   if confirma('S - Marca todas   N - Desmarca todas') then
     marca:='S'
   else
     marca:='N';
   for num:=0 to cb.count-1 do begin
     if marca='S' then
        cb.Checked[num]:=true
     else
        cb.Checked[num]:=false;
   end;

   s:='';
   for num:=0 to cb.count-1 do begin
     if cb.Checked[num] then
       s:=s+copy(cb.Items[num],1,8)+';';
   end;
   EdRemessas.Text:=s;
end;

procedure TFRetprontaentreganovo.EdCodtamanhoValidate(Sender: TObject);
var x:integer;
begin
   if not FGeral.ValidaGrade(EdCodcor.asinteger,EdCodtamanho.asinteger,0,EdProduto.text,'cor;tamanho') then
     EdCodtamanho.invalid('')

end;

procedure TFRetprontaentreganovo.EdCodcopaValidate(Sender: TObject);
begin
   if not FGeral.ValidaGrade(EdCodcor.asinteger,EdCodtamanho.asinteger,EdCodcopa.asinteger,EdProduto.text,'cor;tamanho;copa') then
     EdCodcopa.invalid('')

end;

end.

