unit retroman;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn,
  alabel, ExtCtrls, SQLGrid, SqlExpr, Sqlfun;

type
  TFRetRomaneio = class(TForm)
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
    EdReprcli: TSQLEd;
    EdComv_codigo: TSQLEd;
    PAux: TSQLPanelGrid;
    Edfpgt_codigo: TSQLEd;
    Edperdesco: TSQLEd;
    EdVlrdesco: TSQLEd;
    PParcelas: TSQLPanelGrid;
    GridParcelas: TSqlDtGrid;
    EdParcela: TSQLEd;
    EdVencimento: TSQLEd;
    EdPecas: TSQLEd;
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
    procedure EdVlrdescoValidate(Sender: TObject);
    procedure EdFpgt_codigoValidate(Sender: TObject);
    procedure EdEmissaopedidoExitEdit(Sender: TObject);
    procedure EdVlrdescoExitEdit(Sender: TObject);
    procedure EdperdescoValidate(Sender: TObject);
    procedure EdPagtoKeyPress(Sender: TObject; var Key: Char);
    procedure EdPagtoValidate(Sender: TObject);
    procedure EdVencimentoExitEdit(Sender: TObject);
    procedure EdParcelaExitEdit(Sender: TObject);
    procedure GridParcelasDblClick(Sender: TObject);
    procedure GridParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure EdTipoMovKeyPress(Sender: TObject; var Key: Char);
    procedure cbDblClick(Sender: TObject);
    procedure EdProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure EditstoGrid;
    function CalculaTotal:currency;
    function ValorDesconto(valor:currency):currency;
    procedure AtivaEditsParcelas;
    function GetPrecoSaida(produto:string):currency;
    function CalculaTotalQtde:currency;
  end;

var
  FRetRomaneio: TFRetRomaneio;
  QRemessas,QDevolucoes,QEstoque,QGrade:TSqlquery;
  QProdRemessa,QProdDevolvido,QProdRemessaFe,QProdDevolvidoFe:TMemoryquery;
  OP,PedidoGravado:string;
  Faturarepr:boolean;
  tiposmov,tiposmovdev,produtoescolhido,tiposmovbai,Serie4:string;
  codigobarra,fechamento,comsubs:boolean;
  totalnota,totalnf,valorparteavista,precobase,vlrsubsnota:currency;

implementation

uses Geral, SqlSis, Estoque, Grades, Arquiv, munic, conpagto, impressao,
  codigosfis, Sittribu, cadcor, tamanhos, cadcopa;

{$R *.dfm}

procedure TFRetRomaneio.EditstoGrid;
var x:integer;

    function Procuragrid:integer;
    var x:integer;
    begin
      result:=0;
      for x:=1 to Grid.RowCount do begin
        if trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),x])<>'' then
           if ( trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),x])=trim(EdProduto.text) ) and (Grid.Cells[Grid.Getcolumn('move_tipomov'),x]=EdTipomov.text ) then begin
             result:=x;
             break;
           end;
      end;
    end;

begin
//  x:=ProcuraGrid;
//  04.09.06
  x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.GetColumn('codtamanho'),Edcodtamanho.asinteger,
                        Grid.getcolumn('codcor'),EdCodcor.asinteger,Grid.getcolumn('codcopa'),EdCodcopa.asinteger);

  if x<=0 then begin
// grid vazio
//    Result:=(Grid.RowCount=2) and (Trim(Grid.Cells[0,1])='');
    if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),1])='') then begin
       x:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       x:=Grid.RowCount-1;
    end;

    Grid.Cells[Grid.Getcolumn('move_esto_codigo'),Abs(x)]:=EdProduto.Text;
    Grid.Cells[Grid.Getcolumn('esto_descricao'),Abs(x)]:=SetEdesto_descricao.text;
    Grid.Cells[Grid.Getcolumn('move_tipomov'),Abs(x)]:=EdTipomov.text;
    Grid.Cells[Grid.Getcolumn('move_qtde'),Abs(x)]:=EdQTde.AsSql;
//    Grid.Cells[3,Abs(x)]:=FGeral.formataval|or(FEstoque.GetPreco(EdProduto.Text,EdUnid_codigo.Text),f_cr);
    Grid.Cells[Grid.Getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.Getcolumn('totalunitario'),Abs(x)]:=transform(FGeral.Arredonda(EdUnitario.Ascurrency*texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),x]),2),f_cr);
    Grid.Cells[Grid.Getcolumn('precobase'),Abs(x)]:=transform(precobase,f_cr);
    Grid.Cells[Grid.Getcolumn('unitariosubs'),Abs(x)]:=transform(EdUnitario.ascurrency-precobase,f_cr);
// 04.09.06
    Grid.Cells[Grid.getcolumn('cor'),Abs(x)]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),Abs(x)]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
    Grid.Cells[Grid.getcolumn('copa'),Abs(x)]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),Abs(x)]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),Abs(x)]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('codcopa'),Abs(x)]:=EdCodcopa.text;

  end else begin
  
    Grid.Cells[Grid.Getcolumn('move_esto_codigo'),x]:=EdProduto.Text;
    Grid.Cells[Grid.Getcolumn('esto_descricao'),x]:=SetEdesto_descricao.text;
    Grid.Cells[Grid.Getcolumn('move_tipomov'),x]:=EdTipomov.text;
//    if FGeral.CodigoBarra(EdProduto.text) then
      Grid.Cells[Grid.Getcolumn('move_qtde'),x]:=Transform(texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),x])+EdQTde.Ascurrency,f_cr);
//    else
//      Grid.Cells[3,x]:=Transform(EdQTde.Ascurrency,f_cr);
    Grid.Cells[Grid.Getcolumn('move_venda'),x]:=EdUnitario.AsSql;
    Grid.Cells[Grid.Getcolumn('totalunitario'),x]:=transform(FGeral.Arredonda(EdUnitario.Ascurrency*texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),x]),2),f_cr);
    Grid.Cells[Grid.Getcolumn('precobase'),x]:=transform(precobase,f_cr);
    Grid.Cells[Grid.Getcolumn('unitariosubs'),x]:=transform(EdUnitario.ascurrency-precobase,f_cr);
// 04.09.06
    Grid.Cells[Grid.getcolumn('cor'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
    Grid.Cells[Grid.getcolumn('copa'),x]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),x]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),x]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('codcopa'),x]:=EdCodcopa.text;

  end;
  EdValorVenda.setvalue(Calculatotal);
  EdPecas.setvalue(Calculatotalqtde);
  Grid.Refresh;
end;

procedure TFRetRomaneio.Execute;
begin
  tiposmov:=Global.CodVendaRE+';'+Global.CodVendaREBrinde+';'+Global.CodDevolucaoSerie5;
  tiposmovbai:=Global.CodVendaRE+';'+Global.CodVendaREBrinde+';'+Global.CodDevolucaoSerie5;
  tiposmovdev:=Global.CodVendaRE+';'+Global.CodVendaREBrinde+';'+Global.CodDevolucaoSerie5;
  Serie4:='4';
  precobase:=0;
  EdFpgt_codigo.enabled:=true;
  EdPerdesco.enabled:=true;
  Edvlrdesco.enabled:=true;
  GridParcelas.clear;
  valorparteavista:=0;
  comsubs:=true;
  Show;
end;

procedure TFRetRomaneio.FormActivate(Sender: TObject);
begin
  Grid.Clear;
  cb.clear;
  EdRemessas.Clear;
  EdDtMovimento.SetDate(Sistema.Hoje);
  EdDtMovimento.enabled:=Global.Usuario.OutrosAcessos[0702];
  EdEmissaoPedido.SetDate(Sistema.Hoje);
  Op:='I';
  produtoescolhido:='';
  PedidoGravado:='N';
///////////////////  EdNroPedido.SetValue(FGeral.Getcontador('VENDAREGESPECIAL'+Global.CodigoUnidade,false));
// 02.06.06 - tirado esta cagada daqui...
  EdUnid_codigo.text:=Global.CodigoUnidade;
  EdUNid_codigo.validfind;
  EdRepr_codigo.SetFocus;
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if not Arq.TEstoqueQtde.Active then Arq.TEstoqueQtde.Open;

end;

procedure TFRetRomaneio.EdRepr_codigoValidate(Sender: TObject);

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

  EdReprcli.setvalue(0);
  EdPerdesco.clearall(FRetRomaneio,99);
  Fechamento:=false;
  Gridparcelas.clear;
  if Edrepr_codigo.resultfind.fieldbyname('clie_repr_codigo').asinteger=0 then begin
    EdRepr_codigo.Invalid('Cliente sem codigo do representante no cadastro');
    exit;
  end;
  if not FGeral.ValidaRepresentante(EdRepr_codigo) then
    EdRepr_codigo.Invalid('')
  else begin
    QRemessas:=Sqltoquery('select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,moes_repr_codigo,moes_tabp_codigo'+
          ' from movesto,movestoque where moes_tipo_codigo='+EdRepr_codigo.AsSql+
//            ' from movesto,movestoque where moes_repr_codigo='+EdRepr_codigo.AsSql+
            ' and moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodVendaSerie4)+
            ' and moes_transacao=move_transacao'+
            ' and moes_unid_codigo='+stringtosql(Global.codigounidade)+  // 16.03.05
            ' and moes_unid_codigo=move_unid_codigo'+
            ' and moes_status=move_status'+
            ' order by moes_datamvto,moes_numerodoc');
    if QRemessas.Eof then begin
      EdRepr_codigo.Invalid('Cliente sem remessas em aberto');
    end else begin
      EdReprcli.setvalue(QRemessas.fieldbyname('moes_repr_codigo').asinteger);
      QuerytoItens(QRemessas,EdRemessas,Cb);
//      EdReprcli.setvalue(Edrepr_codigo.resultfind.fieldbyname('clie_repr_codigo').asinteger);
// 21.07.05
      EdReprcli.validfind;
    end;
  end;
end;

procedure TFRetRomaneio.bIncluiritemClick(Sender: TObject);
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
  Edproduto.ClearAll(FRetRomaneio,99);
  EdProduto.SetFocus;

end;

procedure TFRetRomaneio.bExcluiritemClick(Sender: TObject);
var codigoestoque:string;
    qtde,venda:currency;
begin
  if PIns.Visible then exit;
  if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row])='' then exit;
  if confirma('Confirma exclusão ?') then begin
    codigoestoque:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
    qtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
    venda:=texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),Grid.row]);
    precobase:=FEstoque.GetPreco(codigoestoque,Global.unidadematriz);
    Grid.DeleteRow(Grid.Row);
    EdValorvenda.setvalue(EdValorvenda.ascurrency-(QTde*venda));
    EdPecas.setvalue(EdPecas.ascurrency-qtde);
///    if EdTipomov.text<>Global.CodVendaTransf then

//    EdValorvendatotal.setvalue(EdValorvendatotal.ascurrency-(QTde*precobase));
// 13.04.06
    EdValorvendatotal.setvalue(EdValorvendatotal.ascurrency+(QTde*precobase));

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

procedure TFRetRomaneio.bCancelaritemClick(Sender: TObject);
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

procedure TFRetRomaneio.EdProdutoValidate(Sender: TObject);
var QBusca:TSqlquery;
    codbarra:string;
begin
  codigobarra:=false;
  codbarra:=EdProduto.text;
  if not FEstoque.ValidaCodigoProduto(EdProduto,EdProduto.text) then begin
    Edproduto.invalid('');
    exit;
  end;
  if FGeral.CodigoBarra(EdProduto.Text) then begin
    codigobarra:=true;
    QBusca:=sqltoquery('select * from estoque where esto_Codbarra='+EdProduto.Assql);
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString;
//    else
//      EdProduto.Invalid('Codigo de barra não encontrado');
    EdQtde.Enabled:=false;
    EdQtde.SetValue(1);
    SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;

// 04.09.06
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


  end else begin

    QBusca:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.Assql);
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
      EdProduto.Invalid('Codigo não encontrado');
      exit;
    end;
    EdQtde.Enabled:=true;
    EdQtde.SetValue(0);
// 04.09.06
    EdCodcor.enabled:=true;
    EdCodtamanho.enabled:=true;
    EdCodcopa.enabled:=true;
    EdCodcor.text:='';
    EdCodtamanho.text:='';
    EdCodcopa.text:='';
    if (pos( EdProduto.text,FGeral.Getconfig1asstring('Produtoscopa') )>0) and ( not codigobarra) then
      EdcodCopa.enabled:=true
    else begin
      EdCodCopa.enabled:=false;
      EdCodCopa.setvalue(0);
    end;

  end;

  SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;
  QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));

//////////////////  - 25.01.06
  if length( FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_codestado').asinteger) )<> 3 then begin
     EdProduto.Invalid('Situação tributária no estado inválida');
     exit;
  end;
  if length( FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_forestado').asinteger) ) <> 3 then begin
     EdProduto.Invalid('Situação tributária fora do estado inválida');
     exit;
  end;
// 25.01.06
  if not FGeral.ChecaCst(FSittributaria.GetCST(QEstoque.fieldbyname('esqt_sitt_codestado').asinteger),EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring)  then
    exit;

/////////////////

//  EdUnitario.Setvalue(QEstoque.fieldbyname('esqt_vendavis').AsCurrency);
// 19.09.05
  EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.unidadematriz));
  precobase:=(FEstoque.GetPreco(EdProduto.text,Global.unidadematriz));
//  if EdTipomov.text=Global.CodVendaRE then // 11.04.06 - para 'ficar igual' ao romaneio q 'vai junto' com a VN com subst. trib.
  if pos(EdTipomov.text,Global.CodVendaRE+';'+Global.CodDevolucaoSerie5)>0 then begin// 03.05.06 - idem acima para 'bater' o valor em tela antes de fechar a D5
//    EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.unidadematriz,Edcliente.resultfind.fieldbyname('clie_uf').asstring,
//                        FEstoque.Getaliquotaicms(EdProduto.text,Global.CodigoUnidade,Edcliente.resultfind.fieldbyname('clie_uf').asstring),
//                        Edcliente.resultfind.fieldbyname('clie_tipo').asstring,EdUnitario.ascurrency ));
// 15.05.06 - para buscar o valor de venda na nf (remessa ) ) devido a aumento de preços
    precobase:=GetPrecoSaida(EdProduto.text);
    if comsubs then
      EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.unidadematriz,Edcliente.resultfind.fieldbyname('clie_uf').asstring,
                        FEstoque.Getaliquotaicms(EdProduto.text,Global.CodigoUnidade,Edcliente.resultfind.fieldbyname('clie_uf').asstring),
                        Edcliente.resultfind.fieldbyname('clie_tipo').asstring,GetPrecoSaida(EdProduto.text)) )
    else
      EdUnitario.setvalue(precobase);  // 19.05.06
  end;

//  EdVendabruto.setvalue(QEstoque.fieldbyname('esqt_vendavis').AsCurrency);
//  if (not codigobarra) then begin
// para validar a qtde se nao ultrapassa o saldo....
     if (not EdQtde.Enabled) then begin
        if not EdQtde.valid then
          EdProduto.Invalid('');
     end;
//  end;


// ver
//    if op='A' then begin
//      x:=ProcuraGrid(0,EdProduto.Text);
//      if x>0 then
//        EdProduto.Invalid('Produto já existente.   Excluir e incluir.');
//    end;

end;

procedure TFRetRomaneio.EdQtdeValidate(Sender: TObject);
var
    menorpreco,maiorpreco:currency;

  function TemnasRemessas(Produto:string;Qtde:currency):boolean;
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
// 15.09.06 - retirado
//      if menorpreco=maiorpreco then
//        EdUnitario.enabled:=false
//      else
//        EdUnitario.enabled:=true;
//      if EdTipomov.text<>Global.CodVendaRE then  // 11.04.06
      if pos(EdTipomov.text,Global.CodVendaRE+';'+Global.CodDevolucaoSerie5)=0 then  // 03.05.06
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

procedure TFRetRomaneio.EdUnitarioExitEdit(Sender: TObject);
begin
  if not codigobarra then  begin
    if not confirma('Confirma item ?') then exit;
  end;
//    if EdTipomov.text<>Global.CodVendaTransf then   // 16.03.05
    EdValorvendatotal.setvalue(EdValorvendatotal.ascurrency-(EdQTde.ascurrency*precobase));
    EditstoGrid;

  EdProduto.ClearAll(FRetRomaneio,99);
  EdProduto.SetFocus;

end;

procedure TFRetRomaneio.EdRemessasValidate(Sender: TObject);

var remessa,venbrinde,venpronta,ventrans,devolucoes,precovenda,precovendaatual,totalremessa,totaldevolucoes:currency;
    posicao:integer;
    QSaida,QEntrada:Tsqlquery;
    Dataremessas:TDatetime;

begin

  GridCodigos.Clear;
  Sistema.beginprocess('Separando produtos das remessas escolhidas');
  QProdRemessa:=Sqltomemoryquery('select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,moes_repr_codigo,moes_tabp_codigo,movestoque.*'+
//          ' from movesto,movestoque where moes_tipo_codigo='+EdRepr_codigo.AsSql+
//            ' from movesto,movestoque where moes_repr_codigo='+EdRepr_codigo.AsSql+
// 12.07.05
            ' from movesto,movestoque where moes_clie_codigo='+EdRepr_codigo.AsSql+
            ' and moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodVendaSerie4)+
            ' and move_status=''N'''+
            ' and moes_unid_codigo='+EdUnid_codigo.Assql+
//            ' and '+FGeral.GetIN('moes_numerodoc',EdRemessas.Text,'N')+
            ' and moes_transacao=move_transacao'+
            ' and moes_unid_codigo=move_unid_codigo'+
            ' and moes_status=move_status'+
            ' order by move_esto_codigo,moes_numerodoc');


    if fechamento then   // aqui em 04.07.06
      QProdRemessaFe:=Sqltomemoryquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao)'+
            ' where move_clie_codigo='+EdRepr_codigo.AsSql+
            ' and move_status=''N'' and move_tipomov='+stringtosql(Global.CodVendaSerie4)+
            ' and move_unid_codigo='+EdUnid_codigo.Assql+
            ' order by move_esto_codigo,moes_numerodoc');


  remessa:=0;totalremessa:=0;
  Dataremessas:=99999;
  while not QProdremessa.eof do begin
//    if FGeral.EstaemAberto(QProdRemessa.fieldbyname('move_remessas').AsString,EdRemessas.text) then begin
// 21.02.05
    if FGeral.Estaemaberto(QProdRemessa.fieldbyname('moes_numerodoc').AsString,EdRemessas.text) then begin
      if Dataremessas<=QProdremessa.fieldbyname('move_datamvto').AsDatetime then
        DataRemessas:=QProdremessa.fieldbyname('move_datamvto').AsDatetime;

      remessa:=remessa+QProdremessa.fieldbyname('move_qtde').Asfloat;
// 03.05.06 - tentar checar se a nf VN saiu com ou sem a subst. embutida no unitario
      precovenda:=QProdremessa.fieldbyname('move_venda').Asfloat;
      precovendaatual:=QProdremessa.fieldbyname('move_venda').Asfloat;
//      if Fechamento then begin // 31.05.06
        precovendaatual:=(FEstoque.GetPreco(QProdremessa.fieldbyname('move_esto_codigo').Asstring,Global.unidadematriz,EdRepr_codigo.resultfind.fieldbyname('clie_uf').asstring,
                        FEstoque.Getaliquotaicms(QProdremessa.fieldbyname('move_esto_codigo').Asstring,Global.CodigoUnidade,EdRepr_codigo.resultfind.fieldbyname('clie_uf').asstring),
                        EdRepr_codigo.resultfind.fieldbyname('clie_tipo').asstring,precovenda ));
        if precovendaatual>precovenda then
          precovenda:=precovendaatual;
//      end;
//////////////
      totalremessa:=totalremessa+(QProdremessa.fieldbyname('move_qtde').Asfloat*precovenda);
      posicao:=FGeral.ProcuraGrid(0,QProdremessa.fieldbyname('move_esto_codigo').Asstring,Gridcodigos);
      if posicao=0 then
        FGeral.IncluiGrid(Gridcodigos,QProdremessa.fieldbyname('move_esto_codigo').Asstring);
// 03.05.06
      posicao:=FGeral.ProcuraGrid(Gridcodigos.getcolumn('move_esto_codigo'),QProdremessa.fieldbyname('move_esto_codigo').Asstring,Gridcodigos);
      if posicao>0 then begin
        Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),posicao]) +
           QProdremessa.fieldbyname('move_qtde').AsFloat  );
        Gridcodigos.cells[Gridcodigos.getcolumn('move_venda'),posicao]:= floattostr( QProdremessa.fieldbyname('move_venda').AsFloat  );
      end;

    end;
    QProdremessa.Next;
  end;
  Sistema.endprocess('');

  if remessa=0 then begin
    EdRemessas.Invalid('Não encontrado produtos das remessas escolhidas');
    EdRemessas.setfocus;
    exit;
  end else begin
    Sistema.beginprocess('Separando as devoluções das remessas escolhidas');
    QProdDevolvido:=Sqltomemoryquery('select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,movestoque.* from movesto,movestoque'+
//          ' where moes_tipo_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
//          ' where moes_repr_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
//          ' where moes_repr_codigo='+EdReprcli.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
// 12.07.05
          ' where moes_clie_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
//          ' and '+FGEral.Getin('moes_status','N','C')+   // 07.07.06
          ' and '+FGeral.Getin('moes_tipomov',tiposmovdev,'C')+
          ' and moes_unid_codigo=move_unid_codigo'+
          ' and moes_numerodoc=move_numerodoc'+
          ' and '+FGEral.Getin('move_status','N','C')+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
          ' and moes_transacao=move_transacao'+
          ' order by move_esto_codigo,moes_numerodoc');
    venbrinde:=0;venpronta:=0;ventrans:=0;devolucoes:=0;
    totaldevolucoes:=0;
    while not QProdDevolvido.eof do begin
      if FGeral.EstaemAberto(QProdDevolvido.fieldbyname('move_remessas').AsString,EdRemessas.text) then begin
{
        if QProddevolvido.fieldbyname('move_datamvto').asdatetime<Dataremessas then
          showmessage('Documento '+QProddevolvido.fieldbyname('move_numerodoc').asstring+' tipo '+
               QProddevolvido.fieldbyname('move_tipomov').asstring+'  data '+
               QProddevolvido.fieldbyname('move_datamvto').asstring+
                QProdDevolvido.fieldbyname('move_remessas').AsString);
}
        if Qproddevolvido.fieldbyname('move_tipomov').asstring=Global.CodVendaRE then
          venpronta:=venpronta+QProdDevolvido.fieldbyname('move_qtde').Asfloat
        else if Qproddevolvido.fieldbyname('move_tipomov').asstring=Global.CodVendaREBrinde then
          venbrinde:=venbrinde+QProdDevolvido.fieldbyname('move_qtde').Asfloat
        else if Qproddevolvido.fieldbyname('move_tipomov').asstring=Global.CodDevolucaoSerie5 then
          devolucoes:=devolucoes+QProdDevolvido.fieldbyname('move_qtde').Asfloat;
// 03.05.06 - tentar checar se a nf VN saiu com ou sem a subst. embutida no unitario
//        precovenda:=QProddevolvido.fieldbyname('move_venda').Asfloat;
//        precovendaatual:=QProddevolvido.fieldbyname('move_venda').Asfloat;
// 12.05.06
        precovenda:=Getprecosaida(QProdDevolvido.fieldbyname('move_esto_codigo').Asstring);
        precovendaatual:=Getprecosaida(QProdDevolvido.fieldbyname('move_esto_codigo').Asstring);
//        if Fechamento then begin
          precovendaatual:=(FEstoque.GetPreco(QProdDevolvido.fieldbyname('move_esto_codigo').Asstring,Global.unidadematriz,EdRepr_codigo.resultfind.fieldbyname('clie_uf').asstring,
                          FEstoque.Getaliquotaicms(QProdDevolvido.fieldbyname('move_esto_codigo').Asstring,Global.CodigoUnidade,EdRepr_codigo.resultfind.fieldbyname('clie_uf').asstring),
                          EdRepr_codigo.resultfind.fieldbyname('clie_tipo').asstring,precovenda ));
          if precovendaatual>precovenda then
            precovenda:=precovendaatual;
//        end;

        totaldevolucoes:=totaldevolucoes+(QProdDevolvido.fieldbyname('move_qtde').Asfloat*precovenda);
// 02.06.06
        posicao:=FGeral.ProcuraGrid(Gridcodigos.getcolumn('move_esto_codigo'),QProdDevolvido.fieldbyname('move_esto_codigo').Asstring,Gridcodigos);
        if posicao <=0 then begin
//          Avisoerro(QProdDevolvido.fieldbyname('move_esto_codigo').Asstring+' possui apenas devoluções');
          FGeral.IncluiGrid(Gridcodigos,QProdDevolvido.fieldbyname('move_esto_codigo').Asstring);
          posicao:=FGeral.ProcuraGrid(Gridcodigos.getcolumn('move_esto_codigo'),QProdDevolvido.fieldbyname('move_esto_codigo').Asstring,Gridcodigos);
        end;
// 03.05.06
//           posicao:=FGeral.ProcuraGrid(Gridcodigos.getcolumn('move_esto_codigo'),QProdDevolvido.fieldbyname('move_esto_codigo').Asstring,Gridcodigos);
           if posicao >0 then
             Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),Posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),posicao]) -
             QProdDevolvido.fieldbyname('move_qtde').AsFloat  );
/////////

/////////////////////
      end;
      QProdDevolvido.Next;
    end;

    Sistema.endprocess('');
//    EdValorvendatotal.SetValue(totalremessa-totaldevolucoes);
// 12.05.06
//    QSaida:=sqltoquery('select moes_vlrtotal as vlrtotal from movesto where moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodVendaSerie4)+
//                       ' and moes_tipo_codigo='+EdRepr_codigo.assql+' and '+FGeral.Getin('moes_numerodoc',EdRemessas.text,'N') );
// 24.05.06
    QSaida:=sqltoquery('select sum(moes_vlrtotal) as vlrtotal from movesto where moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodVendaSerie4)+
                       ' and moes_tipo_codigo='+EdRepr_codigo.assql+' and '+FGeral.Getin('moes_numerodoc',EdRemessas.text,'N') );
    QEntrada:=sqltoquery('select moes_vlrtotal as vlrtotal from movesto where moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodDevolucaoSerie5)+
                       ' and moes_tipo_codigo='+EdRepr_codigo.assql+' and moes_remessas like '+stringtosql('%'+copy(EdRemessas.text,1,8)+'%' ) );
    if not QEntrada.eof then begin
// 24.05.06  - "PE" no regime especial
//       if Fechamento then begin
// 26.05.06 - colocado o "-1" devido a questoes maravilhosas de arredondamento...
         if totaldevolucoes-1<QEntrada.fieldbyname('vlrtotal').ascurrency then
           totaldevolucoes:=QEntrada.fieldbyname('vlrtotal').ascurrency;
//       end;
    end;
    if not QSaida.eof then begin
      if QSaida.fieldbyname('vlrtotal').ascurrency>0 then
        EdValorvendatotal.SetValue(QSaida.fieldbyname('vlrtotal').ascurrency-totaldevolucoes)
      else
        EdValorvendatotal.SetValue(totalremessa-totaldevolucoes);
    end else
        EdValorvendatotal.SetValue(totalremessa-totaldevolucoes);
    FGeral.FechaQuery(Qsaida);
    FGeral.FechaQuery(QEntrada);
    Aviso('Qtde remessa : '+FGeral.Formatavalor(remessa,'00000')+
                      '   Qtde venda  : '+FGeral.Formatavalor(venpronta,'00000')+
                      '   Qtde brinde : '+FGeral.Formatavalor(venbrinde,'00000')+
                      '   Qtde devolv.: '+FGeral.Formatavalor(devolucoes,'00000')+
                      '   Saldo : '+FGeral.Formatavalor(remessa-(venpronta+venbrinde+ventrans+devolucoes),'00000') );
  end;
//  EdNropedido.setfocus;
  EdCliente.setfocus;
//  if remessa-(venpronta+venbrinde+ventrans+devolucoes)<=0 then
//    bfechamento.enabled:=true
//  else
//    bfechamento.enabled:=false;

end;

procedure TFRetRomaneio.bSaldoClick(Sender: TObject);
var x,posicao:integer;
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
//////////// - 09.05.06 - atualizar se tem algo no grid q ainda nao foi gravado
{  - rever...cada vez q consulta 'baixa de novo' o saldo no grid codigos...
  for x:=1 to Grid.rowcount do begin
           posicao:=FGeral.ProcuraGrid(Gridcodigos.getcolumn('move_esto_codigo'),Grid.cells[Grid.Getcolumn('move_esto_codigo'),x],Gridcodigos);
           if posicao >0 then
               Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),Posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),posicao]) -
               Texttovalor(Grid.cells[Grid.Getcolumn('move_qtde'),x])  )
  end;
}
///////////

  GridCodigos.setfocus;

end;

procedure TFRetRomaneio.EdEmissaopedidoValidate(Sender: TObject);
var QBusca,QPend:TSqlquery;
    x:integer;
begin
  PedidoGravado:='N';
  if (EdEmissaopedido.asdate>EdDtmovimento.asdate) and (not EdDtmovimento.isempty) then
    EdEmissaopedido.INvalid('Emissão do pedido tem que ser menor que a data de movimento')
  else if (EdEmissaopedido.asdate<EdDtmovimento.asdate-2) and (not EdDtmovimento.isempty) then  // 24.05.06
    EdEmissaopedido.INvalid('Checar data de emissão do pedido')
  else begin
    QBusca:=sqltoquery(FGeral.BuscaRemessa(EdNropedido.asinteger,EdTipoMov.text));
    x:=1;
    if not QBusca.eof then begin
      Grid.clear;
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
      Grid.Cells[Grid.Getcolumn('move_esto_codigo'),Abs(x)]:=QBusca.fieldbyname('move_esto_codigo').asstring;
      Grid.Cells[Grid.Getcolumn('esto_descricao'),Abs(x)]:=FEstoque.GetDescricao(QBusca.fieldbyname('move_esto_codigo').asstring);
      Grid.Cells[Grid.Getcolumn('move_tipomov'),Abs(x)]:=QBusca.fieldbyname('move_tipomov').asstring;
      Grid.Cells[Grid.Getcolumn('move_qtde'),Abs(x)]:=Transform(QBusca.fieldbyname('move_qtde').ascurrency,f_quanti);
  //    Grid.Cells[3,Abs(x)]:=FGeral.formatavalor(FEstoque.GetPreco(EdProduto.Text,EdUnid_codigo.Text),f_cr);
      Grid.Cells[Grid.Getcolumn('move_venda'),Abs(x)]:=Transform(QBusca.fieldbyname('move_venda').ascurrency,F_cr);
      Grid.Cells[Grid.Getcolumn('totalunitario'),Abs(x)]:=transform(FGeral.Arredonda(QBusca.fieldbyname('move_venda').Ascurrency*QBusca.fieldbyname('move_qtde').ascurrency,2),f_cr);
      inc(x);
      Grid.rowcount:=x;
      QBusca.Next;
    end;
    QBusca.close;
    Freeandnil(QBusca);
  end;

end;

procedure TFRetRomaneio.bfecharClick(Sender: TObject);
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

procedure TFRetRomaneio.bGravapedidoClick(Sender: TObject);
var tipomov,transacao:string;
    valorcomissao,valorvenda,percdesconto,valoravista,vlrsubs:currency;
    numero:integer;
    ListaCores:TList;


    procedure GravaMestre;
    begin
      if Op='I' then begin
        Sistema.Insert('Movesto');
        Sistema.SetField('moes_transacao',Transacao);
        Sistema.SetField('moes_operacao',FGeral.GetOperacao);
        Sistema.SetField('moes_status','N');
        Sistema.SetField('moes_numerodoc',EdNropedido.asinteger);
        Sistema.SetField('moes_tipomov',TipoMov);
        Sistema.SetField('moes_unid_codigo',EdUNid_codigo.text);
        if tipomov=Global.CodDevolucaoSerie5 then
          Sistema.SetField('moes_tipo_codigo',EdRepr_codigo.AsInteger)
        else
          Sistema.SetField('moes_tipo_codigo',EdCliente.AsInteger);
    //    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
        Sistema.SetField('moes_estado',EdCliente.ResultFind.fieldbyname('clie_uf').AsString);
//        Sistema.SetField('moes_repr_codigo',EdRepr_codigo.asinteger);
        Sistema.SetField('moes_repr_codigo',EdReprcli.asinteger);
        Sistema.SetField('moes_tipocad','C');
        Sistema.SetField('moes_datalcto',Sistema.Hoje);
        Sistema.SetField('moes_datamvto',EdDtmovimento.asdate);
        if EdEmissaopedido.asdate>1 then
          Sistema.SetField('moes_datacont',EdDtmovimento.asdate)
        else
          Sistema.SetField('moes_datacont',sistema.hoje);
        Sistema.SetField('moes_dataemissao',EdEmissaopedido.asdate);
        Sistema.SetField('moes_tabp_codigo',0);
        Sistema.SetField('moes_tabaliquota',0);
        Sistema.SetField('moes_remessas',EdRemessas.text);
        Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('moes_perdesco',percdesconto);
        Sistema.SetField('moes_vispra',FCondpagto.GetAvPz(EdFpgt_codigo.text));
// 12.07.05
        Sistema.SetField('moes_clie_codigo',EdRepr_codigo.AsInteger);
//        Sistema.SetField('moes_datacont',EdEmissaopedido.asdate);
// 18.07.05
//        Sistema.SetField('moes_serie',FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade,Edtipomov.text));
//        Sistema.SetField('moes_especie',EdComv_codigo.resultfind.fieldbyname('comv_especie').asstring);
// 19.08.05
//        Sistema.SetField('moes_valoravista',valoravista);
// 17.04.06
        vlrsubs:=0;
//        if ( Fgeral.UsuarioTeste(Global.usuario.codigo) ) and ( EdTipomov.text=Global.CodVendaRE ) and (vlrsubsnota>0)then begin
//        if ( EdTipomov.text=Global.CodVendaRE ) and (vlrsubsnota>0)then begin
// 03.05.06
        if ( pos(EdTipomov.text,Global.CodVendaRE+';'+Global.CodDevolucaoSerie5)>0 ) and (vlrsubsnota>0)then begin
          vlrsubs:=vlrsubsnota;
        end;
// 22.08.05
        Sistema.SetField('moes_vlrtotal',Valorvenda);
        Sistema.SetField('moes_valortotal',Valorvenda);
        if FCondPagto.GetAvPz(EdFpgt_codigo.text)='V' then
          Sistema.SetField('moes_valoravista',valorvenda)
        else
          Sistema.SetField('moes_valoravista',valorparteavista);
// 01.11.05
        Sistema.SetField('moes_totprod',Valorvenda-vlrsubs);
// 05.05.06
        Sistema.SetField('moes_fpgt_codigo',EdFpgt_codigo.text);

        Sistema.Post();

      end else begin

        Sistema.Edit('Movesto');
        Sistema.SetField('moes_numerodoc',EdNropedido.asinteger);
        if tipomov=Global.CodDevolucaoSerie5 then
          Sistema.SetField('moes_tipo_codigo',EdRepr_codigo.AsInteger)
        else
          Sistema.SetField('moes_tipo_codigo',EdCliente.AsInteger);
    //    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
        Sistema.SetField('moes_estado',EdCliente.ResultFind.fieldbyname('clie_uf').AsString);
//        Sistema.SetField('moes_repr_codigo',EdRepr_codigo.asinteger);
        Sistema.SetField('moes_repr_codigo',EdReprcli.asinteger);
        Sistema.SetField('moes_tipocad','C');
        Sistema.SetField('moes_datamvto',EdDtmovimento.asdate);
        Sistema.SetField('moes_dataemissao',EdEmissaopedido.asdate);
        Sistema.SetField('moes_vlrtotal',Valorvenda);
        Sistema.SetField('moes_tabp_codigo',0);
        Sistema.SetField('moes_tabaliquota',0);
        Sistema.SetField('moes_remessas',EdRemessas.text);
        Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('moes_valortotal',Valorvenda);
        Sistema.SetField('moes_perdesco',percdesconto);
        Sistema.SetField('moes_vispra',FCondpagto.GetAvPz(EdFpgt_codigo.text));
// 12.07.05
        Sistema.SetField('moes_clie_codigo',EdRepr_codigo.AsInteger);
        if EdEmissaopedido.asdate>1 then
          Sistema.SetField('moes_datacont',EdEmissaopedido.asdate)
        else
          Sistema.SetField('moes_datacont',Sistema.hoje);
// 18.07.05
//        Sistema.SetField('moes_serie',FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade,Edtipomov.text));
//        Sistema.SetField('moes_especie',EdComv_codigo.resultfind.fieldbyname('comv_especie').asstring);
// 22.08.05
        if FCondPagto.GetAvPz(EdFpgt_codigo.text)='V' then
          Sistema.SetField('moes_valoravista',valorvenda)
        else
          Sistema.SetField('moes_valoravista',valorparteavista);
// 01.11.05
        Sistema.SetField('moes_totprod',Valorvenda);
        Sistema.Post('moes_transacao='+stringtosql(transacao));
      end;
    end;


////////////////////////////////////////////////////////////////
// inicio ajustes para ficar igual PE
// 04.07.06
    procedure GravaDetalheDividido;
    type TMov=record
        remessa:currency;
        saldo:currency;
    end;
    var linha,codigograde,codigolinha,codigocoluna,x:integer;
        Q,TEstoqueQtde,TEstoque:TSqlquery;
        produto,RemessasOK:string;
        saldoprodutoremessa,qtddev,qtddevII:currency;
        Lista:Tlist;
        PMov:^TMov;


        function GetSaldo(codigo:string):currency;
        var saldo:currency;
            nroremdev,x:integer;

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
                 if tipomov=Global.CodVendaSerie4 then begin  // 21.11.05
                   New(PMov);
                   PMov.remessa:=doc;
                   PMov.saldo:=qtde;
                   Lista.Add(Pmov);
                 end;
               end else begin
                 if tipomov=Global.CodVendaSerie4 then
                   PMov.saldo:=PMov.saldo+qtde
                 else
                   PMov.saldo:=PMov.saldo-qtde
               end;
            end;

        begin

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

//      Lista:=TList.create;
      for linha:=1 to Grid.rowcount do begin
        if trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha])<>'' then begin
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
              if qtddevII>0 then begin
                qtddev:=qtddev-qtddevII;
                Sistema.Insert('Movestoque');
                Sistema.SetField('move_esto_codigo',Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha]);
//                codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha],codigograde);
//                codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha],codigograde);
//                Arq.TEstoque.Locate('esto_codigo',Grid.Cells[0,linha],[]);
// 08.08.06
                TEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );
// 31.01.06
                TEstoqueQtde:=sqltoquery( FEstoque.GetSqlCustos(produto,EdUnid_codigo.text) );
{
                if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
                  Sistema.SetField('move_tama_codigo',codigolinha)
                else
                  Sistema.SetField('move_core_codigo',codigolinha);
                if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
                  Sistema.SetField('move_tama_codigo',codigocoluna)
                else
                  Sistema.SetField('move_core_codigo',codigocoluna);
}
                Sistema.SetField('move_transacao',transacao);
                Sistema.SetField('move_operacao',FGeral.GetOperacao);
//                if Edtipomov.text=Global.CodDevolucaoSerie5 then
//                  Sistema.SetField('move_numerodoc',numero)
//                else
                  Sistema.SetField('move_numerodoc',EdNropedido.asinteger);
                Sistema.SetField('move_status','N');
//                Sistema.SetField('move_tipomov',Grid.Cells[2,linha]);
// 06.07.06
                Sistema.SetField('move_tipomov',EdTipoMov.text);
                Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
                Sistema.SetField('move_tipo_codigo',EdCliente.AsInteger);
                Sistema.SetField('move_tipocad','C');
                Sistema.SetField('move_repr_codigo',EdReprcli.asinteger);
//                Sistema.SetField('move_qtde',Texttovalor(Grid.Cells[3,linha]));
                Sistema.SetField('move_qtde',qtddevII);
                Sistema.SetField('move_datalcto',Sistema.Hoje);
                Sistema.SetField('move_datamvto',EdDtMovimento.asdate);
                Sistema.SetField('move_qtderetorno',0);
                Sistema.SetField('move_venda',Texttovalor(Grid.Cells[Grid.Getcolumn('move_venda'),linha]));
                Sistema.SetField('move_grup_codigo',TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
                Sistema.SetField('move_sugr_codigo',TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
                Sistema.SetField('move_fami_codigo',TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
                Sistema.SetField('move_remessas',formatfloat('00000000',PMov.remessa)+';');
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
                Sistema.SetField('move_clie_codigo',EdRepr_codigo.AsInteger);
// 04.09.06
                Sistema.SetField('move_tama_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codtamanho'),linha],0 ) );
                Sistema.SetField('move_core_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcor'),linha],0 ) );
                Sistema.SetField('move_copa_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcopa'),linha],0 ) );

                Sistema.Post('');
                FGeral.FechaQuery(TEstoqueqtde);
                FGeral.FechaQuery(TEstoque);
              end;
            end;
          end;

          if Grid.Cells[Grid.Getcolumn('move_tipomov'),linha]=Global.CodDevolucaoSerie5 then begin
              Q:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha],EdUnid_codigo.text));
              FGeral.MovimentaQtdeEstoque(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha],EdUnid_codigo.text,'E',Global.CodDevolucaoSerie5,Texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),linha]),
                                     Q,Texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),linha]) );
              Q.close;
              Freeandnil(Q);
          end;

        end;
      end;  // percorre o grid de produtos
    end;

/////////////////////////////////////////////////////////////////


    procedure GravaDetalhe;
    var linha,codigograde,codigolinha,codigocoluna:integer;

    begin
      vlrsubsnota:=0;
      for linha:=1 to Grid.rowcount do begin
//        if trim(Grid.Cells[0,linha])<>'' then begin
// 14.07.05
        if trim(Grid.Cells[grid.getcolumn('move_esto_codigo'),linha])<>'' then begin
          codigograde:=FEstoque.GetCodigoGrade(Grid.Cells[grid.getcolumn('move_esto_codigo'),linha]);
          Sistema.Insert('Movestoque');
          Sistema.SetField('move_esto_codigo',Grid.Cells[grid.getcolumn('move_esto_codigo'),linha]);
          codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[grid.getcolumn('move_esto_codigo'),linha],codigograde);
          codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[grid.getcolumn('move_esto_codigo'),linha],codigograde);
          Arq.TEstoque.Locate('esto_codigo',Grid.Cells[grid.getcolumn('move_esto_codigo'),linha],[]);
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
//          Sistema.SetField('move_tipomov',Grid.Cells[2,linha]);
          Sistema.SetField('move_tipomov',TipoMov);
          Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
          if Grid.Cells[Grid.Getcolumn('move_tipomov'),linha]=Global.CodDevolucaoSerie5 then
            Sistema.SetField('move_tipo_codigo',EdRepr_codigo.AsInteger)
          else
            Sistema.SetField('move_tipo_codigo',EdCliente.AsInteger);
          Sistema.SetField('move_tipocad','C');
//          Sistema.SetField('move_repr_codigo',EdRepr_codigo.asinteger);
          Sistema.SetField('move_repr_codigo',EdReprcli.asinteger);
          Sistema.SetField('move_qtde',Texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
          Sistema.SetField('move_datalcto',Sistema.Hoje);
          Sistema.SetField('move_datamvto',EdDtMovimento.asdate);
          Sistema.SetField('move_datacont',EdDtmovimento.asdate);
          Sistema.SetField('move_qtderetorno',0);
//          Sistema.SetField('move_venda',Texttovalor(Grid.Cells[4,linha]));
// 17.04.06
//        if ( Fgeral.UsuarioTeste(Global.usuario.codigo) ) and ( EdTipomov.text=Global.CodVendaRE ) then begin
//        if  ( EdTipomov.text=Global.CodVendaRE ) then begin
// 03.05.06
        if  ( pos(EdTipomov.text,Global.CodVendaRE+';'+Global.CodDevolucaoSerie5)>0 ) then begin
            Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('precobase'),linha]));
            Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('precobase'),linha]));
          end else begin
            Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
            Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
          end;

          Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
          Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
          Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
          Sistema.SetField('move_remessas',EdRemessas.text);
          Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
// 12.07.05
          Sistema.SetField('move_clie_codigo',EdRepr_codigo.AsInteger);
// 04.09.06
          Sistema.SetField('move_tama_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codtamanho'),linha],0 ) );
          Sistema.SetField('move_core_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcor'),linha],0 ) );
          Sistema.SetField('move_copa_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcopa'),linha],0 ) );

          Sistema.Post('');
// 17.04.06
          vlrsubsnota:=vlrsubsnota+( texttovalor(Grid.Cells[grid.getcolumn('unitariosubs'),linha]) *
                        texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]) )
        end;

      end;

    end;

////////////////////////////////////////////////////////
// 06.07.06
    procedure GravaDevolucaoDividido(Gridx:TSqlDtGrid);
    type TMov=record
        remessa:currency;
        saldo:currency;
    end;
    var linha,p,x:integer;
        codigograde,codigolinha,codigocoluna:integer;
        venda,qtde,reducao,isentas,outras,base,basesubs,valorcontabil,icmssubs,margemlucro,totalitem,icmsitem,
        baseicmsnota,icmsnota,basesubsnota,icmssubsnota,vendauni:currency;
        devolucoes,produto:string;
        TEstoqueqtde,QCodigosfis,TEstoque:TSqlquery;
        ListaCstPerc:Tlist;
        saldoprodutoremessa,qtddev,qtddevII:currency;
        Lista:Tlist;
        PMov:^TMov;


/////////////////////////
        function GetSaldo(codigo:string):currency;
        var saldo:currency;
            nroremdev,x:integer;

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
                 if tipomov=Global.CodVendaSerie4 then begin  // 21.11.05
                   New(PMov);
                   PMov.remessa:=doc;
                   PMov.saldo:=qtde;
                   Lista.Add(Pmov);
                 end;
               end else begin
                 if tipomov=Global.CodVendaSerie4 then
                   PMov.saldo:=PMov.saldo+qtde
                 else
                   PMov.saldo:=PMov.saldo-qtde
               end;
            end;

        begin

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


//////////////////////// - gravacao de devolucao dividida
    begin
////////////////////////
//grava os itens e calcula o icms e a substituição tributária
      if not Arq.TSittributaria.active then Arq.TSittributaria.open;
//      if not Arq.TCodigosFiscais.active then Arq.TCodigosFiscais.open;
      if ListaCstPerc=nil then
         ListaCstPerc:=Tlist.create;
      ListaCstPerc.clear;
      devolucoes:=Global.CodDevolucaoSerie5;
      Numero:=FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false);
// 24.05.06
//      FGeral.Checacontador(numero-1,Global.CodDevolucaoSerie5,sistema.hoje);
// 29.05.06
//      FGeral.Checacontador(numero-1,FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),sistema.hoje);
// 06.06.06 - retirado pois como as meninas gravam notas de forma 'simultanea' aparece a mensagem  q nao acha mas é
//            porque a gravação ainda nao terminou em outro terminal;;;..psss
      baseicmsnota:=0 ; icmsnota:=0;
      basesubsnota:=0; icmssubsnota:=0;
      valorvenda:=0;   // 03.05.06 - recalculo o valor da nf devolucao devido ao rolo da subst .cobrada cliente

      for linha:=1 to Grid.rowcount do begin
        if trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha])<>'' then begin
//          Arq.TEstoque.locate('esto_codigo',Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],[]);
// 08.08.06
          TEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );

          Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([EdUNid_codigo.text,Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]]),[]);
//            avisoerro('Não encontrou o produto '+Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]+' na unidade '+EdUNid_codigo.text);
// 25.01.06 - client dataset do caramba nao tava 'atualizado ainda' com a qtde em estoque 'as vezes'...
          TEStoqueqtde:=sqltoquery('select esqt_qtde,esqt_qtdeprev from estoqueqtde where esqt_status=''N'''+
                       ' and esqt_unid_codigo='+stringtosql(EdUnid_codigo.text)+' and esqt_esto_codigo='+
                       stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );

          codigograde:=FEstoque.GetCodigoGrade(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]);
///////////////////
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
              if qtddevII>0 then begin
                qtddev:=qtddev-qtddevII;
///////////////////////
                Sistema.setmessage('incluindo produto '+Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]);
                Sistema.Insert('Movestoque');
                Sistema.SetField('move_esto_codigo',Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]);
{
                codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],codigograde);
                codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],codigograde);
                if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
                  Sistema.SetField('move_tama_codigo',codigolinha)
                else
                  Sistema.SetField('move_core_codigo',codigolinha);
                if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
                  Sistema.SetField('move_tama_codigo',codigocoluna)
                else
                  Sistema.SetField('move_core_codigo',codigocoluna);
}
                Sistema.SetField('move_transacao',transacao);
                Sistema.SetField('move_operacao',FGeral.GetOperacao);
                Sistema.SetField('move_numerodoc',numero);
                Sistema.SetField('move_status','N');
                Sistema.SetField('move_tipomov',Global.CodDevolucaoSerie5);
                Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
                Sistema.SetField('move_tipo_codigo',EdRepr_codigo.AsInteger);
                Sistema.SetField('move_tipocad','C');
                Sistema.SetField('move_repr_codigo',EdReprcli.asinteger);
                Sistema.SetField('move_qtde',qtddevII);
                Sistema.SetField('move_datalcto',Sistema.Hoje);
                Sistema.SetField('move_datacont',EdMovimento.asdate);
                Sistema.SetField('move_datamvto',EdEmissaopedido.asdate);
                Sistema.SetField('move_qtderetorno',0);
                Sistema.SetField('move_custo',Arq.TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
                Sistema.SetField('move_custoger',Arq.TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
                Sistema.SetField('move_customedio',Arq.TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
                Sistema.SetField('move_customeger',Arq.TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
                Arq.TSittributaria.Locate('sitt_codigo',Arq.TEstoqueQtde.fieldbyname('esqt_sitt_codestado').asstring,[]);
                Sistema.SetField('move_cst',Arq.TSittributaria.fieldbyname('sitt_cst').AsString );
      //          Arq.TCodigosFiscais.locate('cfis_codigo',Arq.TEstoqueQtde.fieldbyname('esqt_cfis_codigoest').asstring,[]);
      //          Sistema.SetField('move_aliicms',Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').ascurrency);
      // 23.06.06
                QCodigosfis:=sqltoquery('select * from codigosfis where cfis_codigo='+stringtosql(Arq.TEstoqueQtde.fieldbyname('esqt_cfis_codigoest').asstring));
                Sistema.SetField('move_aliicms',QCodigosFis.fieldbyname('cfis_aliquota').ascurrency);
      ////
      //          Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
      //          Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
      // 03.05.06 - deixado igual a venda RE para 'bater valor' com romaneio
                Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('precobase'),linha]));
                Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('precobase'),linha]));
                vendauni:= texttovalor(Grid.Cells[grid.getcolumn('precobase'),linha])  * qtddevII  ;
                valorvenda:=valorvenda+( vendauni );
      //
                Sistema.SetField('move_grup_codigo',TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
                Sistema.SetField('move_sugr_codigo',TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
                Sistema.SetField('move_fami_codigo',TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
                Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
                Sistema.SetField('move_perdesco',EdPerDesco.ascurrency);
                Sistema.SetField('move_remessas',formatfloat('00000000',PMov.remessa)+';');
                Sistema.SetField('move_clie_codigo',EdRepr_codigo.AsInteger);
// 04.09.06
                Sistema.SetField('move_tama_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codtamanho'),linha],0 ) );
                Sistema.SetField('move_core_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcor'),linha],0 ) );
                Sistema.SetField('move_copa_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcopa'),linha],0 ) );

                Sistema.Post('');

                if ( pos( EdTipomov.text,Global.TiposMovMovEstoque ) > 0  ) then begin
                  Sistema.Edit('Estoqueqtde');
                  if pos(EdTipomov.text,devolucoes)>0 then begin
                    Sistema.Setfield('esqt_qtdeprev',TEstoqueqtde.fieldbyname('esqt_qtdeprev').ascurrency+qtddevII);
                    Sistema.Setfield('esqt_qtde',TEstoqueqtde.fieldbyname('esqt_qtde').ascurrency+qtddevII);
                  end else begin
                    Sistema.Setfield('esqt_qtdeprev',TEstoqueqtde.fieldbyname('esqt_qtdeprev').ascurrency-qtddevII);
                    Sistema.Setfield('esqt_qtde',TEstoqueqtde.fieldbyname('esqt_qtde').ascurrency-qtddevII);
                  end;
                  Sistema.setfield('esqt_dtultvenda',EdEmissaopedido.asdate);
                end else begin
                  Sistema.Edit('Estoqueqtde');
                  Sistema.setfield('esqt_dtultvenda',EdEmissaopedido.asdate);
                end;
                Sistema.Post('esqt_status=''N'' and esqt_unid_codigo='+stringtosql(EdUnid_codigo.text)+' and esqt_esto_codigo='+
                         stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );

                reducao:=0;isentas:=0;outras:=0;
                venda:=texttovalor(Grid.Cells[grid.getcolumn('precobase'),linha]);
                qtde:=qtddevII;
                totalitem:=FGeral.Arredonda(venda*qtde,2);
                icmsitem:=roundvalor( totalitem*( QCodigosFis.fieldbyname('cfis_aliquota').ascurrency/100 ) ) ;
                ValorContabil:=totalitem;
                Base:=totalitem;
                margemlucro:=QCodigosfis.fieldbyname('cfis_percbase').AsCurrency;

                if (Margemlucro>0) and (EdRepr_codigo.resultfind.fieldbyname('clie_tipo').asstring='F') then begin
                  basesubs:=base*(1+(margemlucro/100));
                  icmssubs:=roundvalor( basesubs*( QCodigosFis.fieldbyname('cfis_aliquota').ascurrency/100 ) );
                  icmssubs:=icmssubs-icmsitem;
                end else begin
                  basesubs:=0;
                  icmssubs:=0;
                end;
                valorcontabil:=valorcontabil+icmssubs;
                if base=0 then begin
                  outras:=valorcontabil;
                  base:=valorcontabil;
                end;
                if basesubs>0 then
                  outras:=icmssubs;
                baseicmsnota:=baseicmsnota+base;
                icmsnota:=icmsnota+icmsitem;
                basesubsnota:=basesubsnota+basesubs;
                icmssubsnota:=icmssubsnota+icmssubs;
                FGeral.GeraListaCstPerc(Arq.TSittributaria.fieldbyname('sitt_cst').AsString,QCodigosFis.fieldbyname('cfis_aliquota').ascurrency,
                                 valorcontabil,base,reducao,isentas,outras,basesubs,ListaCstPerc);
                FGeral.Fechaquery(QCodigosfis);
              end;  // qtdeII>0
            end;  // for

            TEStoqueqtde.close; Freeandnil(TEStoqueqtde);
          end;  // saldoprodutoremesssa>0
          FGeral.FechaQuery(TEstoque);
        end;  // trim(Grid.Cells[0,linha])<>''
      end; // ref. ao grid


      for p:=0 to ListaCstPerc.Count-1 do begin
            PCstPerc:=Listacstperc[p];
            Sistema.setmessage('incluindo base de calculo nota '+inttostr(numero));
            Sistema.Insert('MovBase');
            Sistema.SetField('movb_transacao',Transacao);
            Sistema.SetField('movb_operacao',FGeral.GetOperacao);
            Sistema.SetField('movb_status','N');
            Sistema.SetField('movb_numerodoc',Numero);
            Sistema.SetField('Movb_cst',Pcstperc.cst);
            Sistema.SetField('Movb_TpImposto','I');   // fixo I-Icms
            if p=0 then
              Sistema.SetField('Movb_BaseCalculo',Pcstperc.base)
            else
              Sistema.SetField('Movb_BaseCalculo',Pcstperc.base);
            Sistema.SetField('Movb_Aliquota',pcstperc.perc);
            Sistema.SetField('Movb_ReducaoBc',pcstperc.reducao);
            Sistema.SetField('Movb_Imposto',FGeral.Arredonda(pcstperc.base*(pcstperc.perc/100),2) );
            Sistema.SetField('Movb_Isentas',pcstperc.isentas);
            Sistema.SetField('Movb_Outras' ,pcstperc.outras);
            Sistema.SetField('Movb_tipomov',EdTipoMov.text);
            Sistema.Post();

      end;

// 15.05.06 - gambiarra devido ao rolo de embutir a substi. no unitario
      valorvenda:=EdValorvenda.ascurrency;
      icmssubsnota:=  valorvenda-baseicmsnota;
//////////////////////////////////////////
//grava o mestre no movesto
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacao);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',Numero);
      Sistema.SetField('moes_romaneio',0);
      Sistema.SetField('moes_tipomov',EdTipoMov.text);
      Sistema.SetField('moes_comv_codigo',EdComv_codigo.text);
      Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('moes_tipo_codigo',EdRepr_codigo.AsInteger);
      Sistema.SetField('moes_estado',EdRepr_codigo.ResultFind.fieldbyname('clie_uf').AsString);
      Sistema.SetField('moes_repr_codigo',EdReprcli.asinteger);
      Sistema.SetField('moes_tipocad','C');
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',EdEmissaopedido.asdate);
      if EdEmissaopedido.asdate>1 then
        Sistema.SetField('moes_DataCont',EdEmissaopedido.asdate)
      else
        Sistema.SetField('moes_DataCont',Sistema.hoje);
      Sistema.SetField('moes_dataemissao',EdEmissaopedido.asdate);
//      Sistema.SetField('moes_vlrtotal',ValorVenda+icmssubsnota);
// 15.05.06
      Sistema.SetField('moes_vlrtotal',ValorVenda);
//      Sistema.SetField('moes_tabp_codigo',);
//      Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
      Sistema.SetField('moes_cida_codigo',EdRepr_codigo.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger);
      Sistema.SetField('moes_natf_codigo',EdComv_codigo.Resultfind.fieldbyname('comv_natf_estado').asstring);
      Sistema.SetField('moes_freteciffob','1');   // por conta do emitente
      Sistema.SetField('moes_baseicms',baseicmsnota);
      Sistema.SetField('moes_valoricms',icmsnota);
      Sistema.SetField('moes_basesubstrib',basesubsnota);
      Sistema.SetField('moes_valoricmssutr',icmssubsnota);
      Sistema.SetField('moes_frete',0);
      Sistema.SetField('moes_vispra',FCondPagto.GetAvPz(EdFpgt_codigo.text));
      Sistema.SetField('moes_especie',EdComv_codigo.resultfind.fieldbyname('comv_especie').asstring);
      Sistema.SetField('moes_serie',FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade,Edtipomov.text));
      Sistema.SetField('moes_tran_codigo','001');
      Sistema.SetField('Moes_qtdevolume',0);
      Sistema.SetField('Moes_especievolume','');
//      Sistema.SetField('moes_totprod',ValorVenda);
// 30.05.06 - rolo da subst. embutida
      Sistema.SetField('moes_totprod',ValorVenda-icmssubsnota);

//      Sistema.SetField('moes_valortotal',ValorVenda+icmssubsnota);
// 15.05.06
      Sistema.SetField('moes_valortotal',ValorVenda);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.SetField('Moes_Perdesco',Edperdesco.ascurrency);
      if FCondPagto.GetAvPz(EdFpgt_codigo.text)='V' then
        Sistema.SetField('moes_valoravista',valorvenda)
      else
        Sistema.SetField('moes_valoravista',valorparteavista);
      Sistema.SetField('moes_remessas',Edremessas.text);
      Sistema.SetField('moes_clie_codigo',EdRepr_codigo.AsInteger);
      Sistema.Post();


    end;


///////////////////////////////////////////////////////

    procedure GravaDevolucao(Gridx:TSqlDtGrid);
    var linha,p:integer;
        codigograde,codigolinha,codigocoluna:integer;
        venda,qtde,reducao,isentas,outras,base,basesubs,valorcontabil,icmssubs,margemlucro,totalitem,icmsitem,
        baseicmsnota,icmsnota,basesubsnota,icmssubsnota,vendauni:currency;
        devolucoes:string;
        TEstoqueqtde,QCodigosfis:TSqlquery;
        ListaCstPerc:Tlist;
    begin
//grava os itens e calcula o icms e a substituição tributária
      if not Arq.TSittributaria.active then Arq.TSittributaria.open;
//      if not Arq.TCodigosFiscais.active then Arq.TCodigosFiscais.open;
      if ListaCstPerc=nil then
         ListaCstPerc:=Tlist.create;
      ListaCstPerc.clear;
      devolucoes:=Global.CodDevolucaoSerie5;
      Numero:=FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false);
// 24.05.06
//      FGeral.Checacontador(numero-1,Global.CodDevolucaoSerie5,sistema.hoje);
// 29.05.06
//      FGeral.Checacontador(numero-1,FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.SerieUnidade),sistema.hoje);
// 06.06.06 - retirado pois como as meninas gravam notas de forma 'simultanea' aparece a mensagem  q nao acha mas é
//            porque a gravação ainda nao terminou em outro terminal;;;..psss
      baseicmsnota:=0 ; icmsnota:=0;
      basesubsnota:=0; icmssubsnota:=0;
      valorvenda:=0;   // 03.05.06 - recalculo o valor da nf devolucao devido ao rolo da subst .cobrada cliente

      for linha:=1 to Grid.rowcount do begin
        if trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha])<>'' then begin
          Arq.TEstoque.locate('esto_codigo',Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],[]);

//          Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([EdUNid_codigo.text,Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]]),[]);

//            avisoerro('Não encontrou o produto '+Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]+' na unidade '+EdUNid_codigo.text);
// 25.01.06 - client dataset do caramba nao tava 'atualizado ainda' com a qtde em estoque 'as vezes'...
          TEStoqueqtde:=sqltoquery('select * from estoqueqtde where esqt_status=''N'''+
                       ' and esqt_unid_codigo='+stringtosql(EdUnid_codigo.text)+' and esqt_esto_codigo='+
                       stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );

          codigograde:=FEstoque.GetCodigoGrade(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]);
          Sistema.Insert('Movestoque');
          Sistema.SetField('move_esto_codigo',Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]);
          codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],codigograde);
          codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],codigograde);
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
          Sistema.SetField('move_numerodoc',numero);
          Sistema.SetField('move_status','N');
          Sistema.SetField('move_tipomov',Global.CodDevolucaoSerie5);
          Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
          Sistema.SetField('move_tipo_codigo',EdRepr_codigo.AsInteger);
          Sistema.SetField('move_tipocad','C');
          Sistema.SetField('move_repr_codigo',EdReprcli.asinteger);
          Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
          Sistema.SetField('move_datalcto',Sistema.Hoje);
          Sistema.SetField('move_datacont',EdMovimento.asdate);
          Sistema.SetField('move_datamvto',EdEmissaopedido.asdate);
          Sistema.SetField('move_qtderetorno',0);
          Sistema.SetField('move_custo',TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
          Sistema.SetField('move_custoger',TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
          Sistema.SetField('move_customedio',TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
          Sistema.SetField('move_customeger',TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
          Arq.TSittributaria.Locate('sitt_codigo',TEstoqueQtde.fieldbyname('esqt_sitt_codestado').asstring,[]);
          Sistema.SetField('move_cst',Arq.TSittributaria.fieldbyname('sitt_cst').AsString );
//          Arq.TCodigosFiscais.locate('cfis_codigo',Arq.TEstoqueQtde.fieldbyname('esqt_cfis_codigoest').asstring,[]);
//          Sistema.SetField('move_aliicms',Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').ascurrency);
// 23.06.06
          QCodigosfis:=sqltoquery('select * from codigosfis where cfis_codigo='+stringtosql(TEstoqueQtde.fieldbyname('esqt_cfis_codigoest').asstring));
          Sistema.SetField('move_aliicms',QCodigosFis.fieldbyname('cfis_aliquota').ascurrency);
////
//          Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
//          Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
// 03.05.06 - deixado igual a venda RE para 'bater valor' com romaneio
          Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('precobase'),linha]));
          Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('precobase'),linha]));
          vendauni:= texttovalor(Grid.Cells[grid.getcolumn('precobase'),linha]) * texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha] );
          valorvenda:=valorvenda+( vendauni );
//
          Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
          Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
          Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
          Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
          Sistema.SetField('move_perdesco',EdPerDesco.ascurrency);
          Sistema.SetField('move_remessas',Edremessas.text);
          Sistema.SetField('move_clie_codigo',EdRepr_codigo.AsInteger);
// 04.09.06
          Sistema.SetField('move_tama_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codtamanho'),linha],0 ) );
          Sistema.SetField('move_core_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcor'),linha],0 ) );
          Sistema.SetField('move_copa_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcopa'),linha],0 ) );
          Sistema.Post('');

//          if ( Global.Topicos[1201] ) and ( pos( TipoMovimento,Global.TiposMovMovEstoque ) > 0  ) then begin
          if ( pos( EdTipomov.text,Global.TiposMovMovEstoque ) > 0  ) then begin
//            Arq.TEstoqueqtde.edit;
            Sistema.Edit('Estoqueqtde');
            if pos(EdTipomov.text,devolucoes)>0 then begin
//              Sistema.Setfield('esqt_qtdeprev',Arq.TEstoqueqtde.fieldbyname('esqt_qtdeprev').ascurrency+texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
//              Sistema.Setfield('esqt_qtde',Arq.TEstoqueqtde.fieldbyname('esqt_qtde').ascurrency+texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
// 25.01.06
              Sistema.Setfield('esqt_qtdeprev',TEstoqueqtde.fieldbyname('esqt_qtdeprev').ascurrency+texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
              Sistema.Setfield('esqt_qtde',TEstoqueqtde.fieldbyname('esqt_qtde').ascurrency+texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
            end else begin
              Sistema.Setfield('esqt_qtdeprev',TEstoqueqtde.fieldbyname('esqt_qtdeprev').ascurrency-texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
              Sistema.Setfield('esqt_qtde',TEstoqueqtde.fieldbyname('esqt_qtde').ascurrency-texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
            end;
//            Arq.TEstoqueqtde.fieldbyname('esqt_dtultvenda').asdatetime:=EdEmissaopedido.asdate;
            Sistema.setfield('esqt_dtultvenda',EdEmissaopedido.asdate);
//            Arq.TEstoqueqtde.post;
    //        Arq.TEstoqueqtde.commit;
          end else begin
            Sistema.Edit('Estoqueqtde');
            Sistema.setfield('esqt_dtultvenda',EdEmissaopedido.asdate);
//            Arq.TEstoqueqtde.post;
    //        Arq.TEstoqueqtde.commit;
          end;
          Sistema.Post('esqt_status=''N'' and esqt_unid_codigo='+stringtosql(EdUnid_codigo.text)+' and esqt_esto_codigo='+
                         stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );

          TEStoqueqtde.close; Freeandnil(TEStoqueqtde);

          reducao:=0;isentas:=0;outras:=0;
//          venda:=texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]);
// - 03.05.06
          venda:=texttovalor(Grid.Cells[grid.getcolumn('precobase'),linha]);
          qtde:=texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]);
          totalitem:=FGeral.Arredonda(venda*qtde,2);
//          icmsitem:=totalitem*( Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').ascurrency/100 );
// 15.05.06
//          icmsitem:=roundvalor( totalitem*( Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').ascurrency/100 ) ) ;
          icmsitem:=roundvalor( totalitem*( QCodigosFis.fieldbyname('cfis_aliquota').ascurrency/100 ) ) ;
    ///////////
//          if EdPerdesco.ascurrency>0 then begin
//            totalitem:=totalitem-FGEral.Arredonda( totalitem*(EdPerdesco.ascurrency/100) ,2 );
//          end;
          ValorContabil:=totalitem;
          Base:=totalitem;
//          margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],EdUnid_codigo.text,Cliente.resultfind.fieldbyname('clie_uf').asstring));
//          margemlucro:=FCodigosFiscais.GetPercBaseSubs(Arq.TEstoqueQtde.fieldbyname('esqt_cfis_codigoest').asstring);
// 23.06.06
          margemlucro:=QCodigosfis.fieldbyname('cfis_percbase').AsCurrency;

          if (Margemlucro>0) and (EdRepr_codigo.resultfind.fieldbyname('clie_tipo').asstring='F') then begin
            basesubs:=base*(1+(margemlucro/100));
//            icmssubs:=basesubs*( Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').ascurrency/100 );
// 15.05.06
//            icmssubs:=roundvalor( basesubs*( Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').ascurrency/100 ) );
// 23.06.06
            icmssubs:=roundvalor( basesubs*( QCodigosFis.fieldbyname('cfis_aliquota').ascurrency/100 ) );
            icmssubs:=icmssubs-icmsitem;
          end else begin
            basesubs:=0;
            icmssubs:=0;
          end;
          valorcontabil:=valorcontabil+icmssubs;
          if base=0 then begin
            outras:=valorcontabil;
            base:=valorcontabil;
          end;
          if basesubs>0 then
            outras:=icmssubs;
          baseicmsnota:=baseicmsnota+base;
          icmsnota:=icmsnota+icmsitem;
          basesubsnota:=basesubsnota+basesubs;
          icmssubsnota:=icmssubsnota+icmssubs;
          FGeral.GeraListaCstPerc(Arq.TSittributaria.fieldbyname('sitt_cst').AsString,QCodigosFis.fieldbyname('cfis_aliquota').ascurrency,
                           valorcontabil,base,reducao,isentas,outras,basesubs,ListaCstPerc);
          FGeral.Fechaquery(QCodigosfis);  // 23.06.06
       end;
      end; // ref. ao grid


      for p:=0 to ListaCstPerc.Count-1 do begin
            PCstPerc:=Listacstperc[p];
            Sistema.Insert('MovBase');
            Sistema.SetField('movb_transacao',Transacao);
            Sistema.SetField('movb_operacao',FGeral.GetOperacao);
            Sistema.SetField('movb_status','N');
            Sistema.SetField('movb_numerodoc',Numero);
            Sistema.SetField('Movb_cst',Pcstperc.cst);
            Sistema.SetField('Movb_TpImposto','I');   // fixo I-Icms
            if p=0 then
              Sistema.SetField('Movb_BaseCalculo',Pcstperc.base)
            else
              Sistema.SetField('Movb_BaseCalculo',Pcstperc.base);
            Sistema.SetField('Movb_Aliquota',pcstperc.perc);
            Sistema.SetField('Movb_ReducaoBc',pcstperc.reducao);
            Sistema.SetField('Movb_Imposto',FGeral.Arredonda(pcstperc.base*(pcstperc.perc/100),2) );
            Sistema.SetField('Movb_Isentas',pcstperc.isentas);
            Sistema.SetField('Movb_Outras' ,pcstperc.outras);
            Sistema.SetField('Movb_tipomov',EdTipoMov.text);
            Sistema.Post();

      end;

// 15.05.06 - gambiarra devido ao rolo de embutir a substi. no unitario
    valorvenda:=EdValorvenda.ascurrency;
//    baseicmsnota:= EdValorvenda.ascurrency - ( EdValorvenda.ascurrency*(6.35/100) );
//    icmsnota:= baseicmsnota*(Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').ascurrency/100);
//    basesubsnota:= baseicmsnota + ( baseicmsnota * margemlucro/100 );
//    icmssubsnota:= ( basesubsnota*(Arq.TCodigosFiscais.fieldbyname('cfis_aliquota').ascurrency/100) ) - icmsnota;
    icmssubsnota:=  valorvenda-baseicmsnota;
//////////////////////////////////////////
//grava o mestre no movesto
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacao);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',Numero);
      Sistema.SetField('moes_romaneio',0);
      Sistema.SetField('moes_tipomov',EdTipoMov.text);
      Sistema.SetField('moes_comv_codigo',EdComv_codigo.text);
      Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('moes_tipo_codigo',EdRepr_codigo.AsInteger);
      Sistema.SetField('moes_estado',EdRepr_codigo.ResultFind.fieldbyname('clie_uf').AsString);
      Sistema.SetField('moes_repr_codigo',EdReprcli.asinteger);
      Sistema.SetField('moes_tipocad','C');
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',EdEmissaopedido.asdate);
      if EdEmissaopedido.asdate>1 then
        Sistema.SetField('moes_DataCont',EdEmissaopedido.asdate)
      else
        Sistema.SetField('moes_DataCont',Sistema.hoje);
      Sistema.SetField('moes_dataemissao',EdEmissaopedido.asdate);
//      Sistema.SetField('moes_vlrtotal',ValorVenda+icmssubsnota);
// 15.05.06
      Sistema.SetField('moes_vlrtotal',ValorVenda);
//      Sistema.SetField('moes_tabp_codigo',);
//      Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
      Sistema.SetField('moes_cida_codigo',EdRepr_codigo.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger);
      Sistema.SetField('moes_natf_codigo',EdComv_codigo.Resultfind.fieldbyname('comv_natf_estado').asstring);
      Sistema.SetField('moes_freteciffob','1');   // por conta do emitente
      Sistema.SetField('moes_baseicms',baseicmsnota);
      Sistema.SetField('moes_valoricms',icmsnota);
      Sistema.SetField('moes_basesubstrib',basesubsnota);
      Sistema.SetField('moes_valoricmssutr',icmssubsnota);
      Sistema.SetField('moes_frete',0);
      Sistema.SetField('moes_vispra',FCondPagto.GetAvPz(EdFpgt_codigo.text));
      Sistema.SetField('moes_especie',EdComv_codigo.resultfind.fieldbyname('comv_especie').asstring);
      Sistema.SetField('moes_serie',FGeral.Qualserie(EdComv_codigo.resultfind.fieldbyname('comv_serie').asstring,Global.serieunidade,Edtipomov.text));
      Sistema.SetField('moes_tran_codigo','001');
      Sistema.SetField('Moes_qtdevolume',0);
      Sistema.SetField('Moes_especievolume','');
//      Sistema.SetField('moes_totprod',ValorVenda);
// 30.05.06 - rolo da subst. embutida
      Sistema.SetField('moes_totprod',ValorVenda-icmssubsnota);

//      Sistema.SetField('moes_valortotal',ValorVenda+icmssubsnota);
// 15.05.06
      Sistema.SetField('moes_valortotal',ValorVenda);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.SetField('Moes_Perdesco',Edperdesco.ascurrency);
      if FCondPagto.GetAvPz(EdFpgt_codigo.text)='V' then
        Sistema.SetField('moes_valoravista',valorvenda)
      else
        Sistema.SetField('moes_valoravista',valorparteavista);
      Sistema.SetField('moes_remessas',Edremessas.text);
      Sistema.SetField('moes_clie_codigo',EdRepr_codigo.AsInteger);
      Sistema.Post();

    end;


begin
////////////////////////////////////////////////////////////////////
/////// - gravaçao da nota de venda ou devolucao
  if PIns.Visible then exit;
  EdDtMovimento.SetDate(Sistema.Hoje);   // 19.10.05
//  if trim(Grid.Cells[0,Grid.row])='' then exit;
  if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),1])='' then exit;
  if Pedidogravado='S' then begin
    Avisoerro('Documento já gravado');
//    EdNroPedido.setfocus;
    EdCliente.setfocus;
    exit;
  end;
// 02.03.06
  if not FGeral.ValidaGridVencimentos(GridParcelas,EdFpgt_codigo.text,'I') then exit;

  if confirma('Confirma gravação ?') then begin
//    if not EdCliente.ValidEdiAll(FRetRomaneio,99) then exit;   // 13.07.05 - no validate da emissao limpa o grid...
    if EdCliente.isempty then exit;   // 14.07.05
    Fechamento:=false;
    if EdValorvenda.ascurrency<=0 then exit; // 14.07.05
    if (Gridparcelas.cells[1,1]='') and (EdTipomov.text=global.CodVendaRE) then begin   // 18.08.05
      if not EdFpgt_codigo.valid then begin
         Avisoerro('Checar condição de pagamento');
         exit;
      end;
    end;
// 05.05.06
    if EdTipomov.text<>Global.CodDevolucaoSerie5 then begin
       if not EdFpgt_codigo.validfind then begin
         avisoerro('Checar condição de pagamento');
         exit;
      end;
    end;
///////////////
    Sistema.BeginTransaction('Gravando');
    Transacao:=FGeral.GetTransacao;
    tipomov:=EdTipoMov.text;
////    if EdNroPedido.isempty then

    EdNroPedido.SetValue(FGeral.Getcontador('VENDAREGESPECIAL'+Global.CodigoUnidade,false));

////////////////////////////

//    valorvenda:=EdValorvenda.ascurrency - (EdValorvenda.ascurrency*(EDperdesco.ascurrency/100));
//    if Edperdesco.ascurrency=0 then
//      valorvenda:=valorvenda-Edvlrdesco.ascurrency;
// 19.04.06 - retirado devido ao esquema do com ou sem subst. trib.
    valorvenda:=EdValorvenda.ascurrency ;

    if not Arq.TEstoque.active then Arq.TEstoque.open;
//    if Edvlrdesco.ascurrency>0 then
//      percdesconto:=(Edvlrdesco.ascurrency/Edvalorvenda.ascurrency)*100
//    else
      percdesconto:=Edperdesco.ascurrency;
    if EdTipomov.text=Global.CodDevolucaoSerie5 then begin
      Sistema.beginprocess('Gravando devolução');
//      if  (Global.Usuario.Codigo=10) or (Global.Usuario.Codigo=300)  then   // 06.07.06
        GravaDevolucaoDividido(Grid)
//      else
//        GravaDevolucao(Grid);
    end else begin
      Sistema.beginprocess('Gravando detalhe');
//      GravaDetalhe;
// 06.07.06
      if ( (TipoMOv=Global.CodVendaRE) or (TipoMOv=Global.CodVendaREFinal) ) then
//         and  (  (Global.Usuario.Codigo=10) or (Global.Usuario.Codigo=300)  ) then  // 06.07.06
        GravaDetalheDividido
      else
        GravaDetalhe;

      Sistema.beginprocess('Gravando mestre');
      GravaMestre;
    end;
//    valorcomissao:=FGeral.CalculaComissao(EdRepr_codigo,EdFpgt_codigo.text,Grid,nil,EdUnid_codigo.text);
    valorcomissao:=FGeral.CalculaComissao(EdReprcli,EdFpgt_codigo.text,Grid,nil,EdUnid_codigo.text);

    if tipomov=Global.CodVendaRE then begin
      Sistema.beginprocess('Gravando pendencia financeira');
      FGeral.GravaPendencia(Edemissaopedido.asdate,Eddtmovimento.asdate,EdCliente,'C',EdReprcli.asinteger,
              EdUnid_codigo.text,tipomov,Transacao,EdFpgt_codigo.text,'R',EdNropedido.asinteger,
              0,Valorvenda,Valorcomissao,'N',Valorvenda,0,GridParcelas,'',EdPort_codigo.text);
      GridParcelas.clear;
    end;

    Sistema.EndProcess('');
    Sistema.EndTransaction('Documento Gravado');

//////////////// - 16.03.05 - colocado aqui para nao fazer para cada produto digitado
    QProddevolvido.close;
    Freeandnil(QProddevolvido);
    Sistema.beginprocess('Pesquisando devoluções');
    QProdDevolvido:=sqltomemoryquery('select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,movestoque.* from movesto,movestoque'+
//          ' where moes_tipo_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
//          ' where moes_repr_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
//          ' where moes_repr_codigo='+EdReprcli.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
// 12.07.05
          ' where moes_clie_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
          ' and '+FGEral.Getin('moes_status','N','C')+
          ' and '+FGeral.Getin('moes_tipomov',tiposmovdev,'C')+
          ' and moes_unid_codigo=move_unid_codigo'+
          ' and moes_numerodoc=move_numerodoc'+
          ' and '+FGeral.getin('move_status','N','C')+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
          ' and moes_transacao=move_transacao'+
          ' and moes_status=move_status'+
          ' order by move_esto_codigo,moes_numerodoc');
    Sistema.endprocess('');
/////////////
// 06.07.06
  QProdDevolvidoFe:=Sqltomemoryquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
          ' where move_clie_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
          ' and '+FGEral.Getin('move_status','N','C')+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
          ' order by move_esto_codigo,moes_numerodoc');


///////////////
    if (TipoMov=Global.CodDevolucaoSerie5) then
//        FGeral.IMpdevolucao(Numero,tipomov,'S')
// 16.08.05 - D5 com layout de nota e especifico da serie 5
        FIMpressao.ImprimeNotaSaida(Numero,EdEmissaopedido.asdate,EdUnid_codigo.text,tipomov)
    else
        FIMpressao.ImprimeNotaSaida(EdNropedido.asinteger,EdEmissaopedido.asdate,EdUnid_codigo.text,tipomov);
// 06.07.05 - ver se alguma venda 'picada' será impressa

    EdNropedido.clearall(FRetRomaneio,99);
    EdPerdesco.clearall(FRetRomaneio,99); // 13.01.06
//    EdNroPedido.SetValue(FGeral.Getcontador('PEDIDOPTAENTREGA',false));
//    EdNroPedido.SetValue(FGeral.Getcontador('VENDAREGESPECIAL'+Global.CodigoUnidade,false));
// 02.08.06 retirado daqui para 'nao perder' numeração
    EdEmissaoPedido.SetDate(Sistema.Hoje);
// 26.09.05
    EdDtMovimento.SetDate(Sistema.Hoje);
    EdCliente.setfocus;
    Grid.clear;
  end;

end;

function TFRetRomaneio.CalculaTotal: currency;
var p:integer;
    vlrtotal:currency;
begin
  vlrtotal:=0;
  for p:=1 to Grid.RowCount do begin
    vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[Grid.Getcolumn('move_qtde'),p])*texttovalor(Grid.Cells[Grid.Getcolumn('move_venda'),p]),2);
  end;
  result:=vlrtotal;
end;

procedure TFRetRomaneio.EdNropedidoValidate(Sender: TObject);
begin
  PedidoGravado:='N';

end;

procedure TFRetRomaneio.EdFpgt_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.LimpaEdit(EdFpgt_codigo,key);
end;

procedure TFRetRomaneio.bConfirmaClick(Sender: TObject);
begin
  EdRemessas.Valid;
  Grid.Clear;

end;

procedure TFRetRomaneio.cbClickCheck(Sender: TObject);
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


///////////////////////////////////////////////////////////////////////////////////////
procedure TFRetRomaneio.bfechamentoClick(Sender: TObject);
{
type TLista=record
    produto:string;
    codcor,codtamanho,codcopa:currency;
    qtdeenviada,qtdedevolvida:currency;
end;
}

var saldo,valorvenda,precovenda,valorcomissao,icmssubs,vlrnf,baseicms,aliicms,vlricms,basesubs,precovendaatual,
    valorvendadetalhe:currency;
    x,y:integer;
    transacao,produto,RemessasFechadas:string;
    ListaRemessasFechadas,ListaRemessas:TStringlist;
//    ListaCores:TList;
//    PLista:^TLista;

    procedure GravaMestre;
    begin
        Sistema.Insert('Movesto');
        Sistema.SetField('moes_transacao',Transacao);
        Sistema.SetField('moes_operacao',FGeral.GetOperacao);
        Sistema.SetField('moes_status','N');
//        Sistema.SetField('moes_numerodoc',EdNropedido.asinteger+1);
// 22.02.05
        Sistema.SetField('moes_numerodoc',EdNropedido.asinteger);
        Sistema.SetField('moes_tipomov',Global.CodVendaREFinal);
        Sistema.SetField('moes_unid_codigo',EdUNid_codigo.text);
        Sistema.SetField('moes_tipo_codigo',EdRepr_codigo.asinteger);
    //    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
//        Sistema.SetField('moes_repr_codigo',EdRepr_codigo.asinteger);
//        Sistema.SetField('moes_estado',FCidades.GetUF(EdRepr_codigo.ResultFind.fieldbyname('repr_cida_codigo').Asinteger));
        Sistema.SetField('moes_estado',EdRepr_codigo.ResultFind.fieldbyname('clie_uf').AsString);
        Sistema.SetField('moes_repr_codigo',EdReprcli.asinteger);
//        Sistema.SetField('moes_tipocad','R');
        Sistema.SetField('moes_tipocad','C');
        Sistema.SetField('moes_datalcto',EdDtmovimento.asdate);
        Sistema.SetField('moes_datamvto',EdDtmovimento.asdate);
        Sistema.SetField('moes_dataemissao',EdDtmovimento.asdate);
        Sistema.SetField('moes_datacont',EdDtmovimento.asdate);
        Sistema.SetField('moes_tabp_codigo',0);
        Sistema.SetField('moes_tabaliquota',0);
        Sistema.SetField('moes_remessas',EdRemessas.text);
        Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
////////////////////////////////
        vlrnf:=VAlorvenda;
//        if ( Fgeral.UsuarioTeste(Global.usuario.codigo) )  and ( pos( Global.UFUnidade,Global.UfComSubstituicao ) > 0 )   and (EdDtmovimento.asdate>0) and (EdRepr_codigo.resultfind.fieldbyname('clie_tipo').asstring='F') then begin
        if  ( pos( Global.UFUnidade,Global.UfComSubstituicao ) > 0 )   and (EdDtmovimento.asdate>0) and (EdRepr_codigo.resultfind.fieldbyname('clie_tipo').asstring='F') then begin
           produto:=Gridcodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),1];
           if trim( produto )<>'' then
             aliicms:=FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,EdRepr_codigo.resultfind.fieldbyname('clie_uf').asstring )
           else
             aliicms:=17;
           baseicms:=vlrnf;
           vlricms:=baseicms*(aliicms/100);
           if ( pos(EdRepr_codigo.resultfind.fieldbyname('clie_uf').asstring,'SC;RS')>0 ) then begin
             basesubs:=vlrnf+( (vlrnf)*(Global.MargemSubsTrib/100) );
             icmssubs:=basesubs*(aliicms/100);
             icmssubs:=icmssubs-vlricms;
           end else begin
             basesubs:=0;
             icmssubs:=0;
           end;
// 19.04.06 - q rrrrrrrrrrrrooolo - se dá desconto nao fechava agora se dá tbem nao fecha....
//           if EdVlrdesco.ascurrency>0 then begin
             Sistema.SetField('moes_valortotal',Valorvenda);
             Sistema.SetField('moes_vlrtotal',Valorvenda);
//           end else begin
//             Sistema.SetField('moes_valortotal',Valorvenda+icmssubs);
//             Sistema.SetField('moes_vlrtotal',Valorvenda+icmssubs);
//           end;

        end else  begin
////////////////////////////////
          Sistema.SetField('moes_valortotal',Valorvenda);
          Sistema.SetField('moes_vlrtotal',Valorvenda);
        end;
        Sistema.SetField('moes_totprod',valorvenda); // 16.03.05
//        Sistema.SetField('moes_valoravista',valorparteavista);   // 19.08.05
// 23.08.05
        if FCondPagto.GetAvPz(EdFpgt_codigo.text)='V' then
          Sistema.SetField('moes_valoravista',valorvenda)
        else
          Sistema.SetField('moes_valoravista',valorparteavista);
// 27.09.05
        Sistema.SetField('moes_vispra',FCondpagto.GetAvPz(EdFpgt_codigo.text));
// 05.05.06
        Sistema.SetField('moes_fpgt_codigo',EdFpgt_codigo.text);
        Sistema.Post();

    end;

/////////////////////////////////////////////////////////////
/////////////////// - AQUI É O FECHAMENTO  do regime especial
// 04.07.06
    procedure GravaDetalheDividido;

    type TMov=record
        remessa:currency;
        saldo:currency;
    end;

    type TLista=record
        produto:string;
        codcor,codtamanho,codcopa:currency;
        qtdeenviada,qtdedevolvida:currency;
    end;


    var linha,codigograde,codigolinha,codigocoluna,x,y:integer;
        Q:TSqlquery;
        RemessasOK:string;
        saldoprodutoremessa,qtddev,qtddevII,saldograde:currency;
        Lista,ListaCores:Tlist;
        PMov:^TMov;
        PLista:^TLista;

        function GetSaldo(codigo:string):currency;
        var saldo:currency;
            nroremdev,x:integer;

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
                 if tipomov=Global.CodVendaSerie4 then begin
                   New(PMov);
                   PMov.remessa:=doc;
                   PMov.saldo:=qtde;
                   Lista.Add(Pmov);
                 end;
               end else begin
                 if tipomov=Global.CodVendaSerie4 then
                   PMov.saldo:=PMov.saldo+qtde
                 else
                   PMov.saldo:=PMov.saldo-qtde
               end;
            end;

// inicio da Getsaldo q apura o saldo por codigo
        begin

          saldo:=0;
          QProdremessaFE.first;
          while not QProdremessaFE.eof do begin
            if codigo=QProdremessaFE.fieldbyname('move_esto_codigo').asstring then begin
              if FGeral.Estaemaberto(QProdRemessaFE.fieldbyname('move_numerodoc').AsString,EdRemessas.text) then begin
                 saldo:=saldo+QProdremessaFE.fieldbyname('move_qtde').asfloat;
                 Atualiza(QProdRemessaFE.fieldbyname('move_numerodoc').Asfloat,QProdremessaFE.fieldbyname('move_qtde').asfloat,
                          QProdRemessaFE.fieldbyname('move_tipomov').AsString);
// 06.09.06
                 FGeral.apuravenda(Listacores,codigo, texttovalor( QProdremessaFE.fieldbyname('move_core_codigo').asstring ) ,
                            texttovalor( QProdremessaFE.fieldbyname('move_tama_codigo').asstring ),texttovalor( QProdremessaFE.fieldbyname('move_copa_codigo').asstring ),
                            QProdremessaFE.fieldbyname('move_qtde').asfloat,Global.CodVendaSerie4);

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
                   Atualiza(nroremdev,QProdDevolvidoFe.fieldbyname('move_qtde').asfloat,QProdDevolvidoFE.fieldbyname('move_tipomov').AsString,
                           QProdDevolvidoFE.fieldbyname('moes_remessas').AsString);
// 06.09.06
                   FGeral.apuravenda(Listacores,codigo, texttovalor( QProdDevolvidoFE.fieldbyname('move_core_codigo').asstring ) ,
                            texttovalor( QProdDevolvidoFE.fieldbyname('move_tama_codigo').asstring ),texttovalor( QProdDevolvidoFE.fieldbyname('move_copa_codigo').asstring ),
                            QProdDevolvidoFE.fieldbyname('move_qtde').asfloat,Global.CodDevolucaoSerie5);
                 end;
              end;
            end;
            QProddevolvidoFE.Next;
          end;
          result:=saldo;
        end;

// inicio de GravaDetalheDividido;
    begin

      Lista:=TList.create;
      Listacores:=TList.create;
//      for linha:=1 to Grid.rowcount do begin
//        if trim(Grid.Cells[0,linha])<>'' then begin

///          codigograde:=FEstoque.GetCodigoGrade(produto);
///          codigolinha:=FEstoque.GetCodigoLinha(produto,codigograde);
///          codigocoluna:=FEstoque.GetCodigoColuna(produto,codigograde);

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
                if FGeral.UsuarioTesteGrade(global.Usuario.Codigo) then begin
                  for y:=0 to ListaCores.count-1 do begin
                    PLista:=ListaCores[y];
                    if PLista.produto=produto then begin
                      saldograde:=Plista.qtdeenviada-PLista.qtdedevolvida;
                      if saldograde>0 then begin
                        Sistema.Insert('Movestoque');
                        Sistema.SetField('move_esto_codigo',produto);
                        Sistema.SetField('move_core_codigo',PLista.codcor);
                        Sistema.SetField('move_tama_codigo',PLista.codtamanho);
                        Sistema.SetField('move_copa_codigo',PLista.codcopa);
                        Sistema.SetField('move_transacao',transacao);
                        Sistema.SetField('move_operacao',FGeral.GetOperacao);
                        Sistema.SetField('move_numerodoc',EdNropedido.asinteger);
                        Sistema.SetField('move_status','N');
                        Sistema.SetField('move_tipomov',Global.CodVendaREFinal);
                        Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
                        Sistema.SetField('move_tipo_codigo',EdRepr_codigo.asinteger);
                        Sistema.SetField('move_tipocad','C');
                        Sistema.SetField('move_repr_codigo',EdReprcli.asinteger);
                        if saldograde<=qtddevII then
                          Sistema.SetField('move_qtde',saldograde)
                        else
                          Sistema.SetField('move_qtde',qtddevII);
                        Sistema.SetField('move_datalcto',Sistema.Hoje);
                        Sistema.SetField('move_datamvto',EdDtMovimento.asdate);
                        Sistema.SetField('move_qtderetorno',0);
                        Sistema.SetField('move_venda',precovenda);
                        Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
                        Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
                        Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
                        Sistema.SetField('move_remessas',formatfloat('00000000',PMov.remessa)+';');
                        Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
                        Sistema.SetField('move_clie_codigo',EdRepr_codigo.AsInteger);
                        Sistema.Post('');
                      end;
                    end;
                  end;

                end else begin

                  Sistema.Insert('Movestoque');
                  Sistema.SetField('move_esto_codigo',produto);
{
                  codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha],codigograde);
                  codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha],codigograde);
                  Arq.TEstoque.Locate('esto_codigo',produto,[]);
                  if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
                    Sistema.SetField('move_tama_codigo',codigolinha)
                  else
                    Sistema.SetField('move_core_codigo',codigolinha);
                  if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
                    Sistema.SetField('move_tama_codigo',codigocoluna)
                  else
                    Sistema.SetField('move_core_codigo',codigocoluna);
}
                  Sistema.SetField('move_core_codigo',0);
                  Sistema.SetField('move_tama_codigo',0);
                  Sistema.SetField('move_copa_codigo',0);
                  Sistema.SetField('move_transacao',transacao);
                  Sistema.SetField('move_operacao',FGeral.GetOperacao);
                  Sistema.SetField('move_numerodoc',EdNropedido.asinteger);
                  Sistema.SetField('move_status','N');
                  Sistema.SetField('move_tipomov',Global.CodVendaREFinal);
                  Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
                  Sistema.SetField('move_tipo_codigo',EdRepr_codigo.asinteger);
                  Sistema.SetField('move_tipocad','C');
                  Sistema.SetField('move_repr_codigo',EdReprcli.asinteger);
  //                Sistema.SetField('move_qtde',Texttovalor(Grid.Cells[3,linha]));
                  Sistema.SetField('move_qtde',qtddevII);
                  Sistema.SetField('move_datalcto',Sistema.Hoje);
                  Sistema.SetField('move_datamvto',EdDtMovimento.asdate);
                  Sistema.SetField('move_qtderetorno',0);
                  Sistema.SetField('move_venda',precovenda);
                  Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
                  Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
                  Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
                  Sistema.SetField('move_remessas',formatfloat('00000000',PMov.remessa)+';');
                  Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
                  Sistema.SetField('move_clie_codigo',EdRepr_codigo.AsInteger);
                  Sistema.Post('');
                end;
              end;
            end;
          end;


     //   end;
//      end;  // percorre o grid de produtos
    end;

/////////////////////////////////////////////////////////////

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
          Sistema.SetField('move_tipomov',Global.CodVendaREFinal);
          Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
          Sistema.SetField('move_tipo_codigo',EdRepr_codigo.asinteger);
          Sistema.SetField('move_tipocad','C');
//          Sistema.SetField('move_repr_codigo',EdRepr_codigo.asinteger);
          Sistema.SetField('move_repr_codigo',EdReprcli.asinteger);
          Sistema.SetField('move_qtde',saldo);
          Sistema.SetField('move_datalcto',EdDtmovimento.asdate);
          Sistema.SetField('move_datamvto',EdDtmovimento.asdate);
          Sistema.SetField('move_datacont',EdDtmovimento.asdate);
          Sistema.SetField('move_qtderetorno',0);
//          Sistema.SetField('move_venda',QProdremessa.fieldbyname('move_venda').asfloat);
          Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
          Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
          Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
          Sistema.SetField('move_remessas',EdRemessas.text);
          Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
          Sistema.SetField('move_venda',precovenda);
          Sistema.Post('');

//          Q:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(produto,EdUnid_codigo.text));
//          FGeral.MovimentaQtdeEstoque(produto,EdUnid_codigo.text,'E',Global.CodDevolucaoProntaEntrega,Texttovalor(Grid.Cells[3,linha]),
//                                 Q,Texttovalor(Grid.Cells[3,linha]) );
//          Freeandnil(Q);

    end;


////////////////// - 30.06.06
    procedure  GravaMestreZerado;
    begin
        Sistema.Insert('Movesto');
        Sistema.SetField('moes_transacao',Transacao);
        Sistema.SetField('moes_operacao',FGeral.GetOperacao);
        Sistema.SetField('moes_status','N');
        Sistema.SetField('moes_numerodoc',EdNropedido.asinteger);
        Sistema.SetField('moes_tipomov',Global.CodVendaREFinal);
        Sistema.SetField('moes_unid_codigo',EdUNid_codigo.text);
        Sistema.SetField('moes_tipo_codigo',EdRepr_codigo.asinteger);
        Sistema.SetField('moes_estado',FCidades.GetUF(EdRepr_codigo.ResultFind.fieldbyname('clie_cida_codigo_res').Asinteger));
        Sistema.SetField('moes_repr_codigo',EdReprcli.asinteger);
        Sistema.SetField('moes_tipocad','C');
        Sistema.SetField('moes_datalcto',Sistema.Hoje);
        Sistema.SetField('moes_datamvto',Sistema.Hoje);
        Sistema.SetField('moes_datacont',Sistema.Hoje);  // 14.07.06
        Sistema.SetField('moes_dataemissao',Sistema.hoje);
        Sistema.SetField('moes_vlrtotal',0);
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
          Sistema.SetField('move_tipomov',Global.CodVendaREFinal);
          Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
          Sistema.SetField('move_tipo_codigo',EdRepr_codigo.asinteger);
          Sistema.SetField('move_tipocad','C');
          Sistema.SetField('move_repr_codigo',EdReprcli.asinteger);
          Sistema.SetField('move_qtde',0);
          Sistema.SetField('move_datalcto',Sistema.Hoje);
          Sistema.SetField('move_datamvto',Sistema.Hoje);
          Sistema.SetField('move_datacont',Sistema.Hoje);  // 14.07.06
          Sistema.SetField('move_qtderetorno',0);
          Sistema.SetField('move_venda',0);
          Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
          Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
          Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
          Sistema.SetField('move_remessas',EdRemessas.text);
          Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
          Sistema.Post('');

    end;

///////////////////

////  Fechamento do regime especial de SC
begin


  if trim(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),Grid.row])<>'' then begin
    Avisoerro('Item digitado.  Gravar o pedido ou devolução antes de fazer o fechamento');
    exit;
  end;

  Fechamento:=true;
  if not EdRemessas.valid then exit;  // 19.04.05

  EdFpgt_codigo.enabled:=true;
  EdPerdesco.enabled:=true;
  Edvlrdesco.enabled:=true;
  EdDtMovimento.SetDate(Sistema.Hoje);   // 19.10.05 - alguma filhas das puta a vista ficam 2 no movfin...

  EdTipomov.text:=global.CodVendaREFinal;  // 18.04.06
  if EdFpgt_codigo.isempty then begin
    if not EdFpgt_codigo.valid then begin
       avisoerro('Checar condição de pagamento');
       exit;
    end;
  end;

// 05.05.06
  if not EdFpgt_codigo.validfind then begin
       avisoerro('Checar condição de pagamento');
       exit;
  end;

  if Gridparcelas.cells[1,1]='' then EdFpgt_codigo.valid;

  ListaRemessasFechadas:=Tstringlist.create;   // 07.07.06
  RemessasFechadas:='';

// 02.03.06
  if not FGeral.ValidaGridVencimentos(GridParcelas,EdFpgt_codigo.text,'I') then exit;

  icmssubs:=0;   // 18.04.06

  if not confirma('Confirma fechamento da(s) remessa(s) ?') then exit;
//////////////////////////////////////////////////////
//  ver como faturar o saldo final como venda para o representante
  if not Arq.TEstoque.active then Arq.TEstoque.open;
  Transacao:=FGeral.GetTransacao;
//  EdNroPedido.SetValue(FGeral.Getcontador('PEDIDOPTAENTREGA',false));
  EdNroPedido.SetValue(FGeral.Getcontador('VENDAREGESPECIAL'+Global.CodigoUnidade,false));
  if QProddevolvido<>nil then begin
    QProddevolvido.close;
    Freeandnil(QProddevolvido);
  end;
  Sistema.beginprocess('Checando devoluções');
  QProdDevolvido:=Sqltomemoryquery('select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,movestoque.* from movesto,movestoque'+
//          ' where moes_tipo_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
//          ' where moes_repr_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
//          ' where moes_repr_codigo='+EdReprcli.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
// 12.07.05
          ' where moes_clie_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
//          ' and '+FGEral.Getin('moes_status','N','C')+    // 07.07.06
          ' and '+FGeral.Getin('moes_tipomov',tiposmovdev,'C')+
          ' and moes_unid_codigo=move_unid_codigo'+
          ' and moes_numerodoc=move_numerodoc'+
          ' and '+FGEral.Getin('move_status','N','C')+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
          ' and moes_transacao=move_transacao'+
          ' order by move_esto_codigo,moes_numerodoc');
// 06.07.06
  QProdDevolvidoFe:=Sqltomemoryquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
          ' where moes_clie_codigo='+EdRepr_codigo.assql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
          ' and '+FGEral.Getin('move_status','N;D','C')+
          ' and '+FGeral.Getin('move_tipomov',tiposmovdev,'C')+
          ' order by move_esto_codigo,moes_numerodoc');

  Sistema.endprocess('');
  if QProddevolvido.eof then begin
    if not confirma('Nenhuma devolução digitada.    Efetuar fechamento mesmo assim ?') then begin
      QProddevolvido.close;
      QProddevolvidoFE.close;
      exit;
    end;
// 11.07.06
    RemessasFechadas:=EdRemessas.text;
  end;

  Sistema.Begintransaction('Efetuando fechamento');
  valorvenda:=0;
  valorvendadetalhe:=0;
  QProdRemessa.first;

  while not QProdRemessa.eof do begin
    Produto:=QProdremessa.fieldbyname('move_esto_codigo').asstring;
    saldo:=0;
    precovenda:=QProdremessa.fieldbyname('move_venda').asfloat;
    while (not QProdRemessa.eof) and (Produto=QProdremessa.fieldbyname('move_esto_codigo').asstring) do begin
// 16.03.05
      if FGeral.Estaemaberto(QProdRemessa.fieldbyname('moes_numerodoc').AsString,EdRemessas.text) then begin
        saldo:=saldo+QProdremessa.fieldbyname('move_qtde').Asfloat;
        precovenda:=QProdremessa.fieldbyname('move_venda').asfloat;
// 05.09.06
//        FGeral.apuravenda(Listacores,QProdRemessa.fieldbyname('move_esto_codigo').asstring,QProdRemessa.fieldbyname('move_core_codigo').asfloat,
//                              QProdRemessa.fieldbyname('move_tama_codigo').asfloat,QProdRemessa.fieldbyname('move_copa_codigo').asfloat,
//                              QProdRemessa.fieldbyname('move_qtde').asfloat,QProdRemessa.fieldbyname('move_tipomov').asstring);
      end;
      QProdRemessa.next;
    end;
    QProdDevolvido.first;
    while not QProdDevolvido.eof do begin
      if Produto=QProddevolvido.fieldbyname('move_esto_codigo').asstring then begin
        if FGeral.EstaemAberto(QProdDevolvido.fieldbyname('move_remessas').AsString,EdRemessas.text) then begin
          saldo:=saldo-QProddevolvido.fieldbyname('move_qtde').Asfloat;
// 04.09.06
//          FGeral.apuravenda(Listacores,QProdDevolvido.fieldbyname('move_esto_codigo').asstring,QProdDevolvido.fieldbyname('move_core_codigo').asfloat,
//                              QProdDevolvido.fieldbyname('move_tama_codigo').asfloat,QProdDevolvido.fieldbyname('move_copa_codigo').asfloat,
//                              QProdDevolvido.fieldbyname('move_qtde').asfloat,QProdDevolvido.fieldbyname('move_tipomov').asstring);
// 07.07.06
          if ListaremessasFechadas.indexof(copy(QProdDevolvido.fieldbyname('move_remessas').AsString,1,8))=-1 then begin
                  ListaremessasFechadas.add(copy(QProdDevolvido.fieldbyname('move_remessas').AsString,1,8));
                  remessasfechadas:=remessasfechadas+copy(QProdDevolvido.fieldbyname('move_remessas').AsString,1,8)+';';
          end;

        end;
      end;
      QProdDevolvido.Next;
    end;

    for x:=1 to Grid.rowcount do begin
      if Produto=Grid.cells[Grid.Getcolumn('move_esto_codigo'),x] then begin
          saldo:=saldo-texttovalor( Grid.cells[Grid.Getcolumn('move_qtde'),x] );
      end;
    end;
// 03.05.06 - tentar checar se a nf VN saiu com ou sem a subst. embutida no unitario
    precovendaatual:=(FEstoque.GetPreco(Produto,Global.unidadematriz,EdRepr_codigo.resultfind.fieldbyname('clie_uf').asstring,
                        FEstoque.Getaliquotaicms(Produto,Global.CodigoUnidade,EdRepr_codigo.resultfind.fieldbyname('clie_uf').asstring),
                        EdRepr_codigo.resultfind.fieldbyname('clie_tipo').asstring,precovenda ));
    if precovendaatual>precovenda then
      precovenda:=precovendaatual;
/////////////////////////
    if saldo>0 then begin
// conferir se pode ser pelo preço da remessas ou pelo valor atual na época do fechamento
       valorvenda:=valorvenda+(saldo*precovenda);
       valorvendadetalhe:=valorvendadetalhe+(saldo*precovenda);  // 05.07.06
//       Gravadetalhe;
//06.07.06
//       if  (Global.Usuario.Codigo=10) or (Global.Usuario.Codigo=300) then  // 06.07.06
         GravaDetalheDividido
//        else
//          Gravadetalhe;

    end;
//    QProdremessa.next;
  end;

// 19.04.06
//  valorvenda:=valorvenda-EdVlrdesco.ascurrency;
// 17.05.06 - rolo dos arredondamentos de embutir a subst. trib. no unitario
  valorvenda:=EdValorvendatotal.ascurrency-EdVlrdesco.ascurrency;
//  if (valorvenda>0) then begin
// 05.07.06
  if (valorvenda<0) and (valorvendadetalhe>0) then  // 06.07.06
    valorvenda:=valorvendadetalhe;
  if (valorvenda>0) then begin
    GravaMestre;
  end else begin  // 30.06.06
    GravaMestreZerado;
    GravaDetalheZerado;
  end;

// 04.09.06 - caso nao encontrar fica o conteudo do edit
  if trim(remessasfechadas)='' then
    RemessasFechadas:=EdRemessas.text;

// baixa as notas fiscais serie 4
  Sistema.Edit('movesto');
  Sistema.Setfield('moes_status','E');
  Sistema.Setfield('moes_dataacerto',sistema.hoje);  // 27.04.06
  Sistema.Setfield('moes_transacerto',transacao);
//  if (Global.usuario.codigo=10) or (Global.usuario.codigo=300) then
    Sistema.post('moes_tipo_codigo='+EdRepr_codigo.AsSql+
               ' and '+FGeral.GetIN('moes_numerodoc',RemessasFechadas,'N')+
               ' and moes_tipocad=''C'''+
               ' and moes_unid_codigo='+EdUnid_codigo.assql+
               ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',Global.CodVendaSerie4,'C') );
//  else
//    Sistema.post('moes_tipo_codigo='+EdRepr_codigo.AsSql+
//               ' and '+FGeral.GetIN('moes_numerodoc',EdRemessas.TExt,'N')+
//               ' and moes_tipocad=''C'''+
//               ' and moes_unid_codigo='+EdUnid_codigo.assql+
//               ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',Global.CodVendaSerie4,'C') );

  Sistema.Edit('movestoque');
  Sistema.Setfield('move_status','E');
//  if (Global.usuario.codigo=10) or (Global.usuario.codigo=300) then
    Sistema.post('move_tipo_codigo='+EdRepr_codigo.AsSql+
               ' and '+FGeral.GetIN('move_numerodoc',RemessasFechadas,'N')+
               ' and move_tipocad=''C'''+
               ' and move_unid_codigo='+EdUnid_codigo.assql+
               ' and move_status=''N'' and '+FGeral.Getin('move_tipomov',Global.CodVendaSerie4,'C') );
//  else
//    Sistema.post('move_tipo_codigo='+EdRepr_codigo.AsSql+
//               ' and '+FGeral.GetIN('move_numerodoc',EdRemessas.TExt,'N')+
//               ' and move_tipocad=''C'''+
//               ' and move_unid_codigo='+EdUnid_codigo.assql+
//               ' and move_status=''N'' and '+FGeral.Getin('move_tipomov',Global.CodVendaSerie4,'C') );

// baixa as vendas no regime, brinde, devolução .etc
//  Sistema.Edit('movesto');
//  Sistema.Setfield('moes_status','E');
//  Sistema.Setfield('moes_dataacerto',sistema.hoje);  // 27.04.06
//  Sistema.Setfield('moes_transacerto',transacao);
//  Sistema.post('moes_tipo_codigo='+EdRepr_codigo.AsSql+
//  if (Global.usuario.codigo=10) or (Global.usuario.codigo=300) then
//     Sistema.post('moes_clie_codigo='+EdRepr_codigo.AsSql+
//               ' and moes_tipocad=''C'''+
//               ' and '+FGeral.similarto('moes_remessas',RemessasFechadas)+
//               ' and moes_unid_codigo='+EdUnid_codigo.assql+
//               ' and '+Fgeral.getin('moes_status','N','C')+
//               ' and '+FGeral.Getin('moes_tipomov',tiposmovbai,'C') ) ;
//  else
//     Sistema.post('moes_clie_codigo='+EdRepr_codigo.AsSql+
//               ' and moes_tipocad=''C'''+
//               ' and '+FGeral.similarto('moes_remessas',EdRemessas.text)+
//               ' and moes_unid_codigo='+EdUnid_codigo.assql+
//               ' and '+Fgeral.getin('moes_status','N','C')+
//               ' and '+FGeral.Getin('moes_tipomov',tiposmovbai,'C') );


///////////////////// - 05.01.06
  ListaRemessas:=TStringlist.create;
// 07.07.06
//  if (Global.usuario.codigo=10) or (Global.usuario.codigo=300) then begin
    strtolista(ListaRemessas,RemessasFechadas,';',true);
//////// - 07.08.06
    for x:=0 to LIstaremessas.count-1 do begin
      if strtointdef(LIstaremessas[x],0)>0 then begin
        Sistema.Edit('movesto');   // 07.08.06 - colocado aqui para baixar o mestre na primeira 'baixada' dos detalhes
        Sistema.Setfield('moes_status','E');   // principalmente  devido as D5 q o mestre ficava 'travado'...
        Sistema.Setfield('moes_dataacerto',sistema.hoje);  // 27.04.06
        Sistema.Setfield('moes_transacerto',transacao);
        Sistema.post('moes_clie_codigo='+EdRepr_codigo.AsSql+
                     ' and moes_tipocad=''C'''+
                     ' and '+FGeral.similarto('moes_remessas',LIstaremessas[x])+
                     ' and moes_unid_codigo='+EdUnid_codigo.assql+
                     ' and '+Fgeral.getin('moes_status','N','C')+
                     ' and '+FGeral.Getin('moes_tipomov',tiposmovbai,'C') ) ;
      end;
    end;
////////
    for x:=0 to LIstaremessas.count-1 do begin
      if strtointdef(LIstaremessas[x],0)>0 then begin
        Sistema.Edit('movestoque');
        Sistema.Setfield('move_status','E');
        Sistema.post('move_clie_codigo='+EdRepr_codigo.AsSql+
                 ' and '+FGeral.similarto('move_remessas',LIstaremessas[x])+
                 ' and move_unid_codigo='+EdUnid_codigo.assql+
                 ' and '+Fgeral.getin('move_status','N','C')+
                 ' and '+FGeral.Getin('move_tipomov',tiposmovbai,'C') );
      end;
    end;

    ListaRemessas.free;
////////////////////////////////
{
  end else begin
    Sistema.Edit('movestoque');
    Sistema.Setfield('move_status','E');
    Sistema.post('move_clie_codigo='+EdRepr_codigo.AsSql+
               ' and move_tipocad=''C'''+
               ' and '+FGeral.similarto('move_remessas',EdRemessas.text)+
               ' and move_unid_codigo='+EdUnid_codigo.assql+
               ' and '+Fgeral.getin('move_status','N','C')+
               ' and '+FGeral.Getin('move_tipomov',tiposmovbai,'C') );
  end;
////////////////////////////////
}
////////////  sistema.commit;  -- retirado em 04.09.06

// 01.03.05 - gravacao do financeiro cfe condicao de pagto digitada
    if not EdFpgt_codigo.isempty then begin
//      valorcomissao:=FGeral.CalculaComissao(EdRepr_codigo,EdFpgt_codigo.text,Grid,nil,EdUnid_codigo.text);
// 18.08.05
      valorcomissao:=FGeral.CalculaComissao(EdReprcli,EdFpgt_codigo.text,Grid,nil,EdUnid_codigo.text);
//      FGeral.GravaPendencia(Edemissaopedido.asdate,Edmovimento.asdate,EdRepr_codigo,'C',EdReprcli.asinteger,
//              EdUnid_codigo.text,Global.CodVendaREFinal,Transacao,EdFpgt_codigo.text,'R',EdNropedido.asinteger,
//              0,Valorvenda,Valorcomissao,'N',Valorvenda,0,Gridparcelas);
// 06.07.06 - neste caso nao monta o grid pois o valor é negativo
      if (EdValorvendatotal.ascurrency<0) and (valorvenda>0) then
        FGeral.GravaPendencia(EdDtMovimento.asdate,EdDtmovimento.asdate,EdRepr_codigo,'C',EdReprcli.asinteger,
              EdUnid_codigo.text,Global.CodVendaREFinal,Transacao,EdFpgt_codigo.text,'R',EdNropedido.asinteger,
              0,Valorvenda,Valorcomissao,'N',Valorvenda,0,nil,'',EdPort_codigo.text)
      else
        FGeral.GravaPendencia(EdDtMovimento.asdate,EdDtmovimento.asdate,EdRepr_codigo,'C',EdReprcli.asinteger,
              EdUnid_codigo.text,Global.CodVendaREFinal,Transacao,EdFpgt_codigo.text,'R',EdNropedido.asinteger,
              0,Valorvenda,Valorcomissao,'N',Valorvenda,0,Gridparcelas,'',EdPort_codigo.text);
    end;

  Sistema.endtransaction('Fechamento efetuado');

  if valorvenda>0 then
//    FIMpressao.ImprimeNotaSaida(EdNropedido.asinteger,EdEmissaopedido.asdate,EdUnid_codigo.text,Global.CodVendaREFinal);
// 22.08.05
    FIMpressao.ImprimeNotaSaida(EdNropedido.asinteger,EdDtMovimento.asdate,EdUnid_codigo.text,Global.CodVendaREFinal);

  EdRepr_codigo.clearall(FRetRomaneio,99);
  EdUnid_codigo.text:=Global.CodigoUnidade;  // 14.07.05
  Cb.Clear;
  EdNropedido.clearall(FRetRomaneio,99);

  EdDtMovimento.SetDate(Sistema.Hoje);
  EdEmissaoPedido.SetDate(Sistema.Hoje);
  EdRepr_codigo.setfocus;
end;

procedure TFRetRomaneio.EdClienteValidate(Sender: TObject);
begin
  PedidoGravado:='N';
  if not FGeral.ValidaCliente( EdCliente,Global.CodVendaSerie4 ) then
      EdCliente.Invalid('')

end;

procedure TFRetRomaneio.EdDtMovimentoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  FGeral.PoeData(EdDtmovimento,key);

end;

procedure TFRetRomaneio.EdFpgt_codigoExitEdit(Sender: TObject);
begin
//  bincluiritemclick(FRetRomaneio);
end;

procedure TFRetRomaneio.EdTipoMovValidate(Sender: TObject);
var Q:TSqlquery;
begin
   EdComv_codigo.text:='';
   if EdTipomov.text=Global.CodDevolucaoSerie5 then begin
     EdComv_codigo.setvalue(FGeral.getconfig1asinteger('Confdevserie5'));
     if EdComv_codigo.isempty then begin
       Avisoerro('Falta informar o codigo da configuração de movimento da devolução série 5');
       exit;
     end;
// 19.05.06
//     if FGeral.UsuarioTeste(Global.usuario.codigo) then
//       comsubs:=confirma('Calcular substituição tributária no valor unitário ?');
// 07.07.06
     comsubs:=true;

     EdComv_codigo.ValidFind;
     EdFpgt_codigo.enabled:=false;
     EdFpgt_codigo.text:='';
     EdPerdesco.enabled:=false;
     Edvlrdesco.enabled:=false;
     EdPerdesco.setvalue(0);
     Edvlrdesco.setvalue(0);
//     Q:=Sqltoquery('select * from movesto where moes_tipo_codigo='+EdRepr_codigo.AsSql+
     Q:=Sqltoquery('select * from movesto where moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodDevolucaoSerie5)+
            ' and moes_unid_codigo='+EdUnid_codigo.Assql+
            ' and moes_tipo_codigo='+EdRepr_codigo.AsSql+
            ' order by moes_numerodoc');
     if not Q.eof then begin
       Edtipomov.invalid('Já existe a devolução '+Q.fieldbyname('moes_numerodoc').asstring+' de '+formatdatetime('dd/mm/yy',Q.fieldbyname('moes_dataemissao').asdatetime)+' em aberto');
     end;

   end else if EdTipomov.text=Global.CodVendaRE then begin
     EdFpgt_codigo.enabled:=true;   // liberado em 02.05.06
     EdPerdesco.enabled:=true;
     Edvlrdesco.enabled:=true;
// 24.05.06 - Neimar com vendas sem subst embutida..inclusive venda de 05/2006 - bia passou janina
//    comsubs:=confirma('Calcular substituição tributária no valor unitário ?');
// 07.07.06
     comsubs:=true;

   end else begin
//     EdFpgt_codigo.enabled:=false;
    EdFpgt_codigo.text:='';
//     EdPerdesco.enabled:=false;
//     Edvlrdesco.enabled:=false;
     EdPerdesco.setvalue(0);
     Edvlrdesco.setvalue(0);
   end;

end;

procedure TFRetRomaneio.Edunid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.LimpaEdit(EdUnid_codigo,key);
end;

procedure TFRetRomaneio.EdProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#27 then begin
    bcancelaritemclick(FRetRomaneio);
    if EdTipomov.text=global.CodVendaRE then begin
       EdFpgt_codigo.text:='';
       EdFpgt_codigo.valid;
    end else
      bgravapedidoclick(FRetRomaneio);
  end;


end;

procedure TFRetRomaneio.GridCodigosClick(Sender: TObject);
var linha,x:integer;
    saldo:currency;

    procedure MontaGrid(Grid:TSqldtgrid ; Q:TMemoryquery );
    var x:integer;

         function ProcuraGrid(coluna1,coluna2:integer ; busca1,busca2:string ):integer;
         var p:integer;
         begin
           result:=0;
           for p:=1 to Grid.rowcount do  begin
               if (coluna1>0) and (coluna2>0) then begin
                 if (Grid.cells[coluna1,p]=busca1) and  (Grid.cells[coluna2,p]=busca2) then begin
                   result:=p;
                   break;
                 end;
               end else begin
                 if (Grid.cells[coluna1,p]=busca1)  then begin
                   result:=p;
                   break;
                 end;
               end;
           end;
         end;

    begin

      x:=ProcuraGrid( Grid.GetColumn('move_numerodoc'),Grid.getcolumn('move_tipomov'),Q.fieldbyname('move_numerodoc').Asstring,Q.fieldbyname('move_tipomov').Asstring );
      if x=0 then begin
        Grid.Cells[Grid.getcolumn('move_numerodoc'),linha]:=Q.fieldbyname('move_numerodoc').Asstring;
        Grid.Cells[Grid.getcolumn('move_datamvto'),linha]:=Q.fieldbyname('move_datamvto').Asstring;
        Grid.Cells[Grid.getcolumn('move_tipomov'),linha]:=Q.fieldbyname('move_tipomov').Asstring;
        Grid.Cells[Grid.getcolumn('move_qtde'),linha]:=Q.fieldbyname('move_qtde').Asstring;
        if pos(Q.fieldbyname('move_tipomov').Asstring,Global.CodDevolucaoSerie5+';'+Global.CodVendaRE+';'+Global.CodVendaREBrinde)=0  then
          saldo:=saldo+Q.fieldbyname('move_qtde').Asfloat
        else
          saldo:=saldo-Q.fieldbyname('move_qtde').Asfloat;
        Grid.Cells[Grid.getcolumn('saldo'),linha]:=FGeral.formatavalor(saldo,'####0');
        inc(linha);
        Grid.RowCount:=linha+1;
      end else begin
        Grid.Cells[Grid.getcolumn('move_qtde'),x]:=floattostr( texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x])+Q.fieldbyname('move_qtde').Asfloat );
        if pos(Q.fieldbyname('move_tipomov').Asstring,Global.CodDevolucaoSerie5+';'+Global.CodVendaRE+';'+Global.CodVendaREBrinde)=0  then
          saldo:=saldo+Q.fieldbyname('move_qtde').Asfloat
        else
          saldo:=saldo-Q.fieldbyname('move_qtde').Asfloat;
        Grid.Cells[Grid.getcolumn('saldo'),x]:=FGeral.formatavalor(saldo,'####0');
      end;
    end;


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
// 04.09.06
        MontaGrid( GridSaldo,QProdremessa );
{
        GridSaldo.Cells[GridSaldo.Getcolumn('move_numerodoc'),linha]:=QProdremessa.fieldbyname('move_numerodoc').Asstring;
        GridSaldo.Cells[GridSaldo.Getcolumn('move_datamvto'),linha]:=QProdremessa.fieldbyname('move_datamvto').Asstring;
        GridSaldo.Cells[GridSaldo.Getcolumn('move_tipomov'),linha]:=QProdremessa.fieldbyname('move_tipomov').Asstring;
        GridSaldo.Cells[GridSaldo.Getcolumn('move_qtde'),linha]:=QProdremessa.fieldbyname('move_qtde').Asstring;
        saldo:=saldo+QProdremessa.fieldbyname('move_qtde').Asfloat;
        GridSaldo.Cells[GridSaldo.Getcolumn('saldo'),linha]:=FGeral.formatavalor(saldo,'####0');
        inc(linha);
        GridSaldo.RowCount:=linha+1;
}
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
// 04.09.06
        MontaGrid( GridSaldo,QProdDevolvido );
{
        GridSaldo.Cells[GridSaldo.Getcolumn('move_numerodoc'),linha]:=QProddevolvido.fieldbyname('move_numerodoc').Asstring;
        GridSaldo.Cells[GridSaldo.Getcolumn('move_datamvto'),linha]:=QProddevolvido.fieldbyname('move_datamvto').Asstring;
        GridSaldo.Cells[GridSaldo.Getcolumn('move_tipomov'),linha]:=QProddevolvido.fieldbyname('move_tipomov').Asstring;
        GridSaldo.Cells[GridSaldo.Getcolumn('move_qtde'),linha]:=QProddevolvido.fieldbyname('move_qtde').Asstring;
        saldo:=saldo-QProddevolvido.fieldbyname('move_qtde').Asfloat;
        GridSaldo.Cells[GridSaldo.Getcolumn('saldo'),linha]:=FGeral.formatavalor(saldo,'####0');
        inc(linha);
        GridSaldo.RowCount:=linha+1;
}
      end;
    end;
    QProdDevolvido.Next;
  end;

  for x:=1 to Grid.rowcount do begin
    if EdProduto.text=Grid.cells[Grid.Getcolumn('move_esto_codigo'),x] then begin
        GridSaldo.Cells[GridSaldo.Getcolumn('move_datamvto'),linha]:=formatdatetime('dd/mm/yy',EdEmissaopedido.asdate);
        GridSaldo.Cells[GridSaldo.Getcolumn('move_tipomov'),linha]:=EdTipomov.text;
        GridSaldo.Cells[GridSaldo.Getcolumn('move_qtde'),linha]:=Grid.cells[Grid.Getcolumn('move_qtde'),x];
        saldo:=saldo-texttovalor( Grid.cells[Grid.Getcolumn('move_qtde'),x] );
        GridSaldo.Cells[GridSaldo.Getcolumn('saldo'),linha]:=FGeral.formatavalor(saldo,'####0');
        inc(linha);
        GridSaldo.RowCount:=linha+1;
    end;
  end;
end;

procedure TFRetRomaneio.Edperdesco1Validate(Sender: TObject);
begin
  if EdPerdesco.ascurrency>0 then begin
    EdVlrDesco.setvalue(0);
    EdVlrdesco.enabled:=false;
  end else begin
    EdVlrDesco.setvalue(0);
    EdVlrdesco.enabled:=true;
  end;

end;

procedure TFRetRomaneio.EdVlrdescoValidate(Sender: TObject);
var perdesc:currency;
begin
  if EdVlrdesco.ascurrency>0 then begin
    if EdValorvenda.ascurrency>0 then begin
      perdesc:=(EdVlrdesco.ascurrency/EdValorvenda.ascurrency)*100;
      EdPerdesco.setvalue(perdesc);
    end;
  end;
end;

procedure TFRetRomaneio.EdFpgt_codigoValidate(Sender: TObject);
var nparcelas,n:integer;
    ListaPrazo:TStringlist;
    p:integer;
    valorparcela,valortotal,valoravista,acumulado,vlrnf,totalnota:currency;
    aliicms,baseicms,vlricms,basesubs,icmssubs:currency;
    produto:string;
begin
  if (FCondPagto.GetAvPz(EdFpgt_codigo.text)='V') or (Fcondpagto.Getprimeiroprazo(EdFpgt_codigo.text)=0) then begin
    if EdUnid_codigo.Resultfind<>nil then begin
      if EdUnid_codigo.Resultfind.fieldbyname('Unid_contacontabil').AsInteger=0 then begin
        EdFpgt_codigo.INvalid('Unidade sem conta caixa cadastrada para lançamentos a vista');
        exit;
      end;
    end;
  end;

  if EdValorVenda.ascurrency>0 then begin
    ListaPrazo:=TStringlist.create;
    n:=FCondPagto.GetPrazos(EdFpgt_codigo.text,ListaPrazo);
// 14.03.05
//    totalnota:=roundvalor( vlrnf+icmssubs-(valordesconto(EdValorvenda.ascurrency)) );
// 30.03.05 - vlrnf ja tem o descont
    totalnota:=EdValorvenda.ascurrency;
    if FCondPagto.GetAvPz(EdFpgt_codigo.text)='V' then
      valoravista:=totalnota
    else begin
      if (Fcondpagto.GetPrimeiroPrazo(EdFpgt_codigo.text)=0) and (Fcondpagto.GetNumeroParcelas(EdFpgt_codigo.text)>1) then
         valoravista:=FGeral.GetValorAvista(Listaprazo,icmssubs)
      else
         valoravista:=0;
      valortotal:=totalnota - valoravista;
    end;
    nparcelas:=FCondPagto.GetNumeroParcelas(EdFpgt_codigo.text);
// 11.03.05 - reges pegou bug quando tem parte a vista e mais de duas parcelas
    acumulado:=0;
//    GridParcelas.visible:=true;
    if ListaPrazo.count>0 then begin
      for p:=1 to nparcelas do begin
        GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',FGeral.GetProximoDiaUtil(EdEmissaopedido.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  );
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
    end;

    Freeandnil(ListaPrazo);
//    Gridparcelas.setfocus;
  end;

end;

procedure TFRetRomaneio.EdEmissaopedidoExitEdit(Sender: TObject);
begin
  bincluiritemclick(FRetRomaneio);

end;

procedure TFRetRomaneio.EdVlrdescoExitEdit(Sender: TObject);
begin
    bgravapedidoclick(FRetRomaneio);

end;

procedure TFRetRomaneio.EdperdescoValidate(Sender: TObject);
begin
  if EdPerdesco.ascurrency>0 then begin
    EdVlrDesco.setvalue( EdValorvenda.ascurrency*(EdPerdesco.ascurrency/100) );
    EdVlrdesco.enabled:=false;
  end else begin
    EdVlrDesco.setvalue(0);
    EdVlrdesco.enabled:=true;
  end;

end;

procedure TFRetRomaneio.EdPagtoKeyPress(Sender: TObject; var Key: Char);
begin
  FGeral.LImpaEdit(EdFpgt_codigo,key);

end;

procedure TFRetRomaneio.EdPagtoValidate(Sender: TObject);
var nparcelas,n:integer;
    ListaPrazo:TStringlist;
    p:integer;
    valorparcela,valortotal,valoravista,acumulado,vlrnf:currency;
    aliicms,baseicms,vlricms,basesubs,icmssubs,valorvenda:currency;
    produto,tipo:string;

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
  if fechamento then begin
    valorvenda:=EdValorvendatotal.ascurrency;
  end else begin
    valorvenda:=EdValorvenda.ascurrency;
    EdValorvenda.setvalue(EdValorvenda.ascurrency-EdVlrdesco.ascurrency);  // 19.04.06
  end;


  if (Valorvenda>0) and (not EdFpgt_codigo.isEmpty) then begin
//////////////////////////// - 11.03.05
     vlrnf:=Valorvenda-valordesconto(Valorvenda);
     if ( pos( Global.UFUnidade,'SC;RS' ) > 0 )   and (EdDtmovimento.asdate>0) then begin
       produto:=Gridcodigos.cells[0,1];
       if pos(Edtipomov.text,global.CodVendaRE+';'+Global.CodVendaREFinal)>0 then begin
         tipo:='F';
         if trim( produto )<>'' then begin
           if Edtipomov.text=global.CodVendaRE then begin
             aliicms:=FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,EdCliente.resultfind.fieldbyname('clie_uf').asstring );
             tipo:=EdCliente.resultfind.fieldbyname('clie_tipo').asstring;
           end else begin
             aliicms:=FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,EdRepr_codigo.resultfind.fieldbyname('clie_uf').asstring );
             tipo:=EdRepr_codigo.resultfind.fieldbyname('clie_tipo').asstring;
           end;
         end else
           aliicms:=17;
         baseicms:=vlrnf;
         vlricms:=baseicms*(aliicms/100);
         if tipo='F' then begin
           basesubs:=vlrnf+( (vlrnf)*(Global.MargemSubsTrib/100) );
           icmssubs:=basesubs*(aliicms/100);
           icmssubs:=icmssubs-vlricms;
         end else begin
           basesubs:=0;
           icmssubs:=0;
         end;

       end else begin

         if trim( produto )<>'' then begin
           aliicms:=FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,EdRepr_codigo.resultfind.fieldbyname('clie_uf').asstring )
         end else
           aliicms:=17;
         baseicms:=vlrnf;
         vlricms:=baseicms*(aliicms/100);
//         if EdRepr_codigo.resultfind.fieldbyname('clie_tipo').asstring='F' then begin  // 15.07.05
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
//    totalnota:=roundvalor( vlrnf+icmssubs );
// 19.04.06 - mudanças no esquema 'com ou sem ' subst.
    totalnota:=roundvalor( vlrnf );
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
      if EdDtmovimento.enabled=true then
        GridParcelas.cells[0,p]:=formatdatetime('dd/mm/yy',FGeral.GetProximoDiaUtil(EdDtmovimento.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  )
      else
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

////   bgravarclick(FRetConsig);


end;

procedure TFRetRomaneio.EdVencimentoExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=DateToStr_(EdVencimento.AsDate);
  GridParcelas.SetFocus;
  EdVencimento.Visible:=False;

end;

procedure TFRetRomaneio.EdParcelaExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=Transform(EdParcela.AsFloat,f_cr);
  GridParcelas.SetFocus;
  EdParcela.Visible:=False;

end;

function TFRetRomaneio.ValorDesconto(valor: currency): currency;
begin
    if EdPerDesco.ascurrency>0 then begin
      EdVlrdesco.setvalue(valor*(EdPerDesco.ascurrency/100));
      result:=valor*(EdPerDesco.ascurrency/100)
    end else if EdVlrdesco.ascurrency>0 then
      result:=EdVlrdesco.ascurrency
    else
      result:=0;

end;

procedure TFRetRomaneio.GridParcelasDblClick(Sender: TObject);
begin
  AtivaEditsParcelas;

end;

procedure TFRetRomaneio.GridParcelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    GridParcelasDblClick(FRetRomaneio);

end;

procedure TFRetRomaneio.AtivaEditsParcelas;
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

function TFRetRomaneio.GetPrecoSaida(produto:string): currency;
var p:integer;
begin
      p:=FGeral.ProcuraGrid(Gridcodigos.getcolumn('move_esto_codigo'),produto,Gridcodigos);
      if P>0 then
        result:=texttovalor( Gridcodigos.cells[Gridcodigos.getcolumn('move_venda'),p] )
      else
        result:=0;
end;


function TFRetRomaneio.CalculaTotalQtde: currency;
var p:integer;
    vlrtotal:currency;
begin
  vlrtotal:=0;
  for p:=1 to Grid.RowCount do begin
    vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),p]),2);
  end;
  result:=vlrtotal;
end;

procedure TFRetRomaneio.EdTipoMovKeyPress(Sender: TObject; var Key: Char);
begin
  FGeral.LimpaEdit(EdTipoMOv,key);
end;

procedure TFRetRomaneio.cbDblClick(Sender: TObject);
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

procedure TFRetRomaneio.EdProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if key=18 then
//    Aviso('Enter pra retornar ao programa');

end;

end.
