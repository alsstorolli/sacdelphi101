unit Remproen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr;

type
  TFRemProntaEntrega = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bIncluiritem: TSQLBtn;
    bExcluiritem: TSQLBtn;
    bCancelaritem: TSQLBtn;
    bImpressao: TSQLBtn;
    bdevolucao: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdCliente: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdDtemissao: TSQLEd;
    EdRepr_codigo: TSQLEd;
    SQLEd3: TSQLEd;
    EdTotalRemessa: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdMoes_tabp_codigo: TSQLEd;
    SetEdTABP_ALIQUOTA: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    EdUnitario: TSQLEd;
    EdVendabruto: TSQLEd;
    Edtotalqtde: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    EdCodcopa: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure EdClienteValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure EdRepr_codigoValidate(Sender: TObject);
    procedure bIncluiritemClick(Sender: TObject);
    procedure EdQtdeValidate(Sender: TObject);
    procedure EdUnitarioExitEdit(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure bExcluiritemClick(Sender: TObject);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure bImpressaoClick(Sender: TObject);
    procedure bdevolucaoClick(Sender: TObject);
    procedure EdMoes_tabp_codigoValidate(Sender: TObject);
    procedure EdDtemissaoValidate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdCodcopaValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditstoGrid;
    function ProcuraGrid(Coluna: integer; Pesquisa: string):integer;
    procedure LimpaEditsItens;
    function CalculaTotal:currency;
    procedure Campostoedits(Q:TSqlquery);
    procedure Campostogrid(Q:TSqlquery);
    procedure AtivaEdits;
    procedure DesativaEdits;
    procedure GravaItemConsignacao(xnovo:string='N');
    procedure ReservaEstoque(Codigo, IncExc: string; Qtde: currency);
    procedure RetornaReserva;
    procedure GravaItemDevolucao;
    function CalculaTotalQtde:currency;
  end;

var
  FRemProntaEntrega: TFRemProntaEntrega;
  QBusca,QEstoque,QGrade:TSqlquery;
  Op,Transacao,semvideo:string;
  TotalRemessa,perc:Currency;
  ListaReservacodigo,ListaReservaQtde:TStringList;


procedure RemessaPE_Execute(Opx:string);    // I / A  /  D  /  X

implementation

uses Arquiv, Geral, tabela, Estoque, Grades, TextRel, SqlFun, SqlSis ,
  represen, Usuarios, cadcor, tamanhos, cadcopa, impressao;

{$R *.dfm}

procedure TFRemProntaEntrega.EditstoGrid;
var x:integer;
    aqtde:currency;
begin
  Sistema.beginprocess('Atualizando grid');
  x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.getcolumn('codtamanho'),EdCodtamanho.asinteger,
                        Grid.getcolumn('codcor'),Edcodcor.asinteger,Grid.getcolumn('codcopa'),EdCodcopa.asinteger );
  if x<=0 then begin
    if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),1])='') then begin
       x:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       x:=Grid.RowCount-1;
    end;
    Grid.Cells[Grid.getcolumn('move_esto_codigo'),Abs(x)]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;
    Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=EdQTde.AsSql;
    Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=TRansform(EdQTde.AsCurrency*EdUnitario.AsCurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_vendabru'),Abs(x)]:=EdVendabruto.AsSql;
    Grid.Cells[Grid.getcolumn('move_perdesco'),Abs(x)]:=currtostr(perc);
    if op='A' then
      Grid.Cells[Grid.getcolumn('novo'),Abs(x)]:='S';
// 29.11.06
    Grid.Cells[Grid.getcolumn('cor'),Abs(x)]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),Abs(x)]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
    Grid.Cells[Grid.getcolumn('copa'),Abs(x)]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),Abs(x)]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),Abs(x)]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('codcopa'),Abs(x)]:=EdCodcopa.text;
  end else begin
    Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=SetEdEsto_descricao.text;
    aqtde:=EdQTde.Ascurrency+texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x]);
//    Grid.Cells[2,x]:=Transform(EdQTde.Ascurrency,f_cr);
// 08.04.05
    Grid.Cells[Grid.getcolumn('move_venda'),x]:=Transform(EdUnitario.Ascurrency,f_cr);
    if OP='A' then begin
      Grid.Cells[Grid.getcolumn('total'),x]:=TRansform(EdQTde.AsCurrency*EdUnitario.AsCurrency,f_cr);
      Grid.Cells[Grid.getcolumn('move_qtde'),x]:=Transform(EdQTde.Ascurrency,f_cr);
    end else begin
      Grid.Cells[Grid.getcolumn('move_qtde'),x]:=Transform(EdQTde.Ascurrency+texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x]),f_cr);
      Grid.Cells[Grid.getcolumn('total'),x]:=TRansform(aQTde*EdUnitario.AsCurrency,f_cr);
    end;
    Grid.Cells[Grid.getcolumn('move_vendabru'),x]:=Transform(EdVendabruto.Ascurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_perdesco'),x]:=Transform(perc,'###.##');
// 29.11.06
    Grid.Cells[Grid.getcolumn('cor'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
    Grid.Cells[Grid.getcolumn('copa'),x]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),x]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),x]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('codcopa'),x]:=EdCodcopa.text;
  end;
  Grid.Refresh;
  sistema.endprocess('');
end;

function TFRemProntaEntrega.CalculaTotalQtde: currency;
var p:integer;
    vlrtotal:currency;
begin
  vlrtotal:=0;
  for p:=1 to Grid.RowCount do begin
    vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),p]),2);
  end;
  result:=vlrtotal;
end;


procedure TFRemProntaEntrega.FormActivate(Sender: TObject);
begin
  bCancelar.Enabled:=Op='A';
  if (op='A') or (op='X') then
    bImpressao.Enabled:=true;
  bDevolucao.Enabled:=OP='D';
  bCancelaritem.Enabled:=true;
  if not Arq.TEstoque.Active then Arq.TEstoque.Open;
  if pos(OP,'A/D/X')>0 then begin
    DesativaEdits;
    EdNumerodoc.Enabled:=true;
    if op<>'X' then
      EdMoes_tabp_codigo.Enabled:=true
    else
      EdMoes_tabp_codigo.Enabled:=false;
    if OP='D' then
      bCancelaritem.Enabled:=false;
  end else begin
    AtivaEdits;
    EdNumerodoc.Enabled:=false;
  end;
  if (OP='D') or (OP='X') then begin
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
    if OP='X' then begin
    bincluiritem.enabled:=false;
    bexcluiritem.enabled:=false;
    bcancelaritem.enabled:=false;
    bdevolucao.enabled:=false;
  end else begin
    bincluiritem.enabled:=true;
    bexcluiritem.enabled:=true;
    bcancelaritem.enabled:=true;
    bdevolucao.enabled:=true;
  end;

  ListaReservaCodigo:=TStringlist.Create;
  ListaReservaQTde:=TStringlist.Create;
//////////////////  FRemessa.Grid.Clear;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
  if Op='I' then begin
    EdCliente.ClearAll(FRemProntaEntrega,99);
    if trim(EdDtemissao.Text)='' then
       EdDtemissao.SetDate(Date);
    EdCliente.SetFocus;
    EdNumerodoc.Setvalue(0);
  end else
    EdNumerodoc.SetFocus;

end;

procedure TFRemProntaEntrega.EdClienteValidate(Sender: TObject);
begin
  if not FGeral.ValidaCliente(EdCliente,Global.CodRemessaProntaEntrega) then
    EdCliente.Invalid('')
  else begin
//    EdUnid_Codigo.Text:=EdCliente.ResultFind.fieldbyname('clie_unid_codigo').AsString;
    EdUnid_Codigo.Text:=Global.CodigoUnidade;
    if EdCliente.ResultFind<>nil then
      EdRepr_Codigo.Text:=EdCliente.ResultFind.fieldbyname('clie_repr_codigo').AsString;
    EdUnid_codigo.ValidFind;
  end;

end;


procedure RemessaPE_Execute(Opx:string);
begin
  Op:=Opx;
  FRemProntaEntrega.Grid.Clear;
  FRemProntaEntrega.Show;
end;

procedure TFRemProntaEntrega.bGravarClick(Sender: TObject);
var Numero:integer;
    Q2:TSqlquery;
begin
  if (EdDtemissao.AsDate<=1) or (EdCliente.AsInteger=0) or (EdRepr_codigo.AsInteger=0)
    or (Grid.RowCount<=1)then
    exit;
  if confirma('Confirma gravação ?') then begin
    ListaReservaCodigo.Clear;
    ListaReservaQtde.Clear;
    if OP='I' then begin
      Sistema.BeginTransaction('Gravando');
      Numero:=FGeral.GetContador('PRONTAEN'+EdUnid_codigo.text,false);
      EdNumerodoc.Text:=inttostr(Numero);
      Transacao:=FGeral.GetTransacao;
      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
             Global.CodRemessaProntaEntrega,Transacao,Numero,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger);
      FGeral.GravaItensConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
             Global.CodRemessaProntaEntrega,Transacao,Numero,Grid);
      Sistema.EndTransaction('');
    end else if OP='A' then begin
// 30.06.06
     Q2:=Sqltoquery('select moes_status,moes_transacao from movesto where moes_status=''N'''+
          ' and moes_numerodoc='+EdNumerodoc.AsSql+
          ' and moes_tipomov='+Stringtosql(Global.CodRemessaProntaEntrega)+
          ' and moes_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and moes_tipo_codigo='+EdCliente.AsSql+
          ' and moes_tipocad=''C''' );
     if Q2.Eof then begin
      Avisoerro('Não encontrado esta remessa para incluir este item');
      exit;
     end;
     Transacao:=Q2.fieldbyname('moes_transacao').Asstring;
     FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
             Global.CodRemessaProntaEntrega,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,Op);
     Sistema.Commit;
    end;
    semvideo:='S';
    if confirma('Imprimir remessa ?') then
      bimpressaoclick(FRemProntaEntrega);
    EdCliente.Clearall(FRemProntaEntrega,99);
    EdDtEmissao.setdate(sistema.hoje);
    Grid.Clear;
    if OP='I' then
      EdCliente.Setfocus
    else
      EdNumerodoc.SetFocus;
  end;

end;

procedure TFRemProntaEntrega.bCancelarClick(Sender: TObject);
var QBusca:TSqlquery;
begin
   if (EdDtemissao.Asdate<=1) or (EdCliente.AsInteger=0) or (EdRepr_codigo.AsInteger=0) or (OP='I') then
     exit;
   QBusca:=sqltoquery('select * from movesto where moes_numerodoc='+inttostr(EdNumeroDoc.AsInteger)+
          ' and moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodRemessaProntaEntrega) );

   if QBusca.eof then
     Aviso('Numero de remessa não encontrado')
   else begin
     if confirma('Confirma exclusão ?') then begin
       ExecuteSql('Update movesto set moes_status=''C'' where moes_numerodoc='+inttostr(EdNumeroDoc.AsInteger)+
                  ' and moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodRemessaProntaEntrega) );
       ExecuteSql('Update movestoque set move_status=''C'' where move_numerodoc='+inttostr(EdNumeroDoc.AsInteger)+
                  ' and move_status=''N'' and move_tipomov='+stringtosql(Global.CodRemessaProntaEntrega) );
       Sistema.Commit;
       EdNumerodoc.ClearAll(FRemProntaEntrega,99);
       Grid.Clear;
     end;
   end;
   QBusca.Free;
   EdNumeroDoc.Setfocus;

end;

procedure TFRemProntaEntrega.EdRepr_codigoValidate(Sender: TObject);
begin
  if not FGeral.ValidaRepresentante(EdRepr_codigo) then
    EdRepr_Codigo.SetFocus;

end;

procedure TFRemProntaEntrega.bIncluiritemClick(Sender: TObject);
begin
  if EdCliente.AsInteger=0 then exit;
  if EdRepr_codigo.AsInteger=0 then exit;
  PRemessa.Enabled:=false;
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
  bCancelar.Enabled:=false;
  PINs.Visible:=true;
  PINs.EnableEdits;
  LimpaEditsItens;
  EdProduto.SetFocus;

end;

procedure TFRemProntaEntrega.EdQtdeValidate(Sender: TObject);
begin
  if EdQtde.AsCurrency>0 then begin
    if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsCurrency,EdUNid_codigo.Text,QEstoque) then begin
       EdQTde.INvalid('Quantidade em estoque insuficiente');
    end;
// provavelmente nao precisara de grade aqui
//    if EdProduto.ResultFind.FieldByName('esto_grad_codigo').AsInteger>0 then begin
// mostrar grade para digitação na grade e sua consistencia com o total digitado no edit
// se ok lançar todos os tamanhos/cores do dtgrid
//       FGrade.Execute(EdUnid_codigo.text,EdProduto.Text,EdProduto.ResultFind.FieldByName('esto_grad_codigo').AsInteger);
//    end;
  end;

end;

procedure TFRemProntaEntrega.EdUnitarioExitEdit(Sender: TObject);
var qtde:currency;
    x:integer;
    novo:string;
begin

// 15.02.05 - retirado a confirmacao - reges
//  if confirma('Confirma item ?') then begin

    EditstoGrid;
    sistema.beginprocess('Reservando estoque');
    novo:='N';
    if OP='A' then begin
//       x:=ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text);
       x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.getcolumn('codtamanho'),EdCodtamanho.asinteger,
                        Grid.getcolumn('codcor'),Edcodcor.asinteger,Grid.getcolumn('codcopa'),EdCodcopa.asinteger );

       qtde:=Texttovalor(Grid.cells[Grid.getcolumn('move_qtde'),x]);
       ReservaEstoque(EdProduto.Text,'E',qtde);
       novo:=Grid.Cells[Grid.getcolumn('novo'),x];   // 06.07.06
    end;
    ReservaEstoque(EdProduto.Text,'I',EdQtde.AsCurrency);
    sistema.beginprocess('Somando itens');
    EdTotalRemessa.setvalue(CalculaTotal);
    EdTotalqtde.setvalue(CalculatotalQtde);
    if op='A' then begin
      GravaItemConsignacao(novo);;
      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
             Global.CodRemessaProntaEntrega,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,Op);
      Sistema.Commit;
      ListaReservaCodigo.Clear;
      ListaReservaQtde.Clear;
    end;
//  end;

  sistema.endprocess('');
  LimpaEditsItens;
  EdProduto.SetFocus;
  QEstoque.close;
  Freeandnil(QEstoque);

end;

procedure TFRemProntaEntrega.bCancelaritemClick(Sender: TObject);
begin
  if EdRepr_codigo.AsInteger=0 then exit;
  bGravar.Enabled:=true;
  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
  PINs.Visible:=false;
  PINs.DisableEdits;
  AtivaEdits;
  PRemessa.Enabled:=true;
  EdCliente.SetFocus;

end;


function TFRemProntaEntrega.ProcuraGrid(Coluna: integer; Pesquisa: string):integer;
var p:integer;
begin
  result:=0;
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

procedure TFRemProntaEntrega.LimpaEditsItens;
begin
  EdProduto.Clear;
  EdQtde.Clear;
  EdUnitario.Clear;
  SetedEsto_descricao.Clear;
end;


procedure TFRemProntaEntrega.EdProdutoValidate(Sender: TObject);
var x:integer;
    QBusca:TSqlquery;
    codbarra:string;
    codigobarra:boolean;
begin
  if  FGeral.CodigoBarra(EdProduto.Text) then begin
    QBusca:=sqltoquery('select * from estoque where esto_Codbarra='+EdProduto.AsSql);
    codbarra:=EdProduto.text;
    codigobarra:=true;
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
//      EdProduto.Invalid('Codigo de barra não encontrado');
//      exit;
    end;
    EdQtde.Enabled:=false;
    EdQtde.SetValue(1);
    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsCurrency,EdUNid_codigo.Text,QEstoque) then begin
       EdProduto.INvalid('Quantidade em estoque insuficiente');
       exit;
    end;
// 29.11.06
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

    QBusca:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.AsSql);
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
      EdProduto.Invalid('Codigo não encontrado');
      exit;
    end;
    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    EdQtde.Enabled:=true;
    EdQtde.SetValue(0);
// 23.08.06
    EdCodcor.enabled:=true;
    EdCodcor.setvalue(0);
    EdCodtamanho.enabled:=true;
    EdCodtamanho.setvalue(0);
    EdCodcopa.enabled:=true;
    EdCodcopa.setvalue(0);

  end;

  SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;
  QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
//  EdUnitario.Setvalue(QEstoque.fieldbyname('esqt_vendavis').AsCurrency);
//  EdVendabruto.setvalue(QEstoque.fieldbyname('esqt_vendavis').AsCurrency);
// 19.09.05
//  EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.unidadematriz));
// 07.03.08
  EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.CodigoUnidade));
  EdVendabruto.setvalue(EdUnitario.ascurrency);

  if EdUnitario.asinteger<=0 then
    Edproduto.invalid('Preço de venda zerado.  Checar');
// 29.11.06
  if (pos( EdProduto.text,FGeral.Getconfig1asstring('Produtoscopa') )>0) and ( not codigobarra) then
    EdcodCopa.enabled:=true
  else begin
    EdCodCopa.enabled:=false;
    EdCodCopa.setvalue(0);
  end;


  if not EdQtde.Enabled then begin
    if not EdQtde.valid then
      EdProduto.Invalid('');
  end;
  if EdMoes_tabp_codigo.AsInteger>0 then
     EdUnitario.setvalue(FGeral.CalcDescAcre(EdVendabruto.ascurrency,perc,Arq.TTabelaPreco.fieldbyname('tabp_tipo').asstring));
// ver
//  EdUnitario.enabled:=Global.usuario.ObjetosAcessados[1042];
// 11.04.11
  EdUnitario.Enabled:=Global.Usuario.OutrosAcessos[0601];
{
  if (op='A') and  not (Global.usuario.ObjetosAcessados[1042]) then begin
      x:=ProcuraGrid(0,EdProduto.Text);
      if x>0 then
        EdProduto.Invalid('Produto já existente.   Excluir e incluir.');
  end else if op='A' then begin
      x:=ProcuraGrid(0,EdProduto.Text);
      if x>0 then
        EdQtde.setvalue(texttovalor(Grid.cells[Grid.getcolumn('move_qtde'),x]));
  end;
}

end;


function TFRemProntaEntrega.CalculaTotal:currency;
var p:integer;
    vlrtotal:currency;
begin
  vlrtotal:=0;
  for p:=1 to Grid.RowCount do begin
    vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),p])*texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),p]),2);
  end;
  result:=vlrtotal;
end;



procedure TFRemProntaEntrega.bExcluiritemClick(Sender: TObject);
var codigoestoque,sqlcor,sqltamanho,sqlcopa:string;
    qtde:currency;
begin
  if EdRepr_codigo.AsInteger=0 then exit;
  if trim(Grid.Cells[0,Grid.row])='' then exit;
  if confirma('Confirma exclusão ?') then begin
    codigoestoque:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
    qtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
    Grid.DeleteRow(Grid.Row);
    if trim(Grid.Cells[Grid.getcolumn('codcor'),Grid.row])<>'' then
      sqlcor:=' and move_core_codigo='+Grid.Cells[Grid.getcolumn('codcor'),Grid.row]
    else
      sqlcor:='';
    if trim(Grid.Cells[Grid.getcolumn('codtamanho'),Grid.row])<>'' then
      sqltamanho:=' and move_tama_codigo='+Grid.Cells[Grid.getcolumn('codtamanho'),Grid.row]
    else
      sqltamanho:='';
    if trim(Grid.Cells[Grid.getcolumn('codcopa'),Grid.row])<>'' then
      sqlcopa:=' and move_copa_codigo='+Grid.Cells[Grid.getcolumn('codcopa'),Grid.row]
    else
      sqlcopa:='';
    Edtotalremessa.SetValue(Calculatotal);
    Edtotalqtde.SetValue(Calculatotalqtde);
    ReservaEstoque(Codigoestoque,'E',qtde);
    if OP='A' then begin
      ExecuteSql('Update movestoque set move_status=''C'' where move_status=''N'''+
          ' and move_numerodoc='+EdNumerodoc.AsSql+
          ' and move_tipomov='+Stringtosql(Global.CodRemessaProntaEntrega)+
          ' and move_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and move_tipo_codigo='+EdCliente.AsSql+
          ' and move_esto_codigo='+Stringtosql(codigoestoque)+
          sqlcor+sqltamanho+sqlcopa+
          ' and move_tipocad='+Stringtosql('C') );
      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
             Global.CodRemessaProntaEntrega,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,Op);

    end;
    Sistema.Commit;
  end;
end;


procedure TFRemProntaEntrega.Campostoedits(Q:TSqlquery);
begin
  EdCliente.Text:=Q.fieldbyname('moes_tipo_codigo').AsString;
  EdUnid_codigo.Text:=Q.fieldbyname('moes_unid_codigo').AsString;
  EdDtEmissao.SetDate(Q.fieldbyname('moes_dataemissao').AsDateTime);
  EdRepr_codigo.Text:=Q.fieldbyname('moes_repr_codigo').AsString;
  EdTotalremessa.SetValue(Q.fieldbyname('moes_vlrtotal').AsCurrency);
  EdMoes_tabp_codigo.SetValue(Q.fieldbyname('moes_tabp_codigo').AsInteger);
  SetEdTabp_aliquota.Text:=FTabela.GetDescAliquota(Q.fieldbyname('moes_tabp_codigo').AsInteger);
  EdUnid_codigo.ValidateEdit;
  EdRepr_codigo.ValidateEdit;
  EdCliente.ValidateEdit;
end;

procedure TFRemProntaEntrega.Campostogrid(Q:TSqlquery);
var p:integer;
begin
  Grid.Clear;p:=1;Q.First;
  while not Q.Eof do begin
    Grid.Cells[Grid.Getcolumn('move_esto_codigo'),p]:=Q.fieldbyname('move_esto_codigo').Asstring;
    Grid.Cells[Grid.Getcolumn('esto_descricao'),p]:=FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').Asstring);
    Grid.Cells[Grid.Getcolumn('move_qtde'),p]:=transform(Q.fieldbyname('move_qtde').Ascurrency,f_cr);
    Grid.Cells[Grid.Getcolumn('move_venda'),p]:=transform(Q.fieldbyname('move_venda').Ascurrency,f_cr);
    Grid.Cells[Grid.Getcolumn('total'),p]:=transform(FGeral.Arredonda(Q.fieldbyname('move_venda').Ascurrency*Q.fieldbyname('move_qtde').Ascurrency,2),f_cr);
// 29.11.06
    Grid.Cells[Grid.getcolumn('cor'),p]:=FCores.Getdescricao(Q.fieldbyname('move_core_codigo').AsInteger);
    Grid.Cells[Grid.getcolumn('tamanho'),p]:=FTamanhos.Getdescricao(Q.fieldbyname('move_tama_codigo').AsInteger);
    Grid.Cells[Grid.getcolumn('copa'),p]:=FCopas.Getdescricao(Q.fieldbyname('move_copa_codigo').AsInteger);
    Grid.Cells[Grid.getcolumn('codcor'),p]:=Q.fieldbyname('move_core_codigo').Asstring;
    Grid.Cells[Grid.getcolumn('codtamanho'),p]:=Q.fieldbyname('move_tama_codigo').Asstring;
    Grid.Cells[Grid.getcolumn('codcopa'),p]:=Q.fieldbyname('move_copa_codigo').Asstring;

    inc(p);
    Grid.AppendRow;
    Q.Next;
  end;
end;

procedure TFRemProntaEntrega.AtivaEdits;
begin
  PRemessa.Enabled:=true;
  if OP='I' then begin
    PRemessa.EnableEdits;
    EdNumerodoc.Enabled:=false;
  end else
    EdNumerodoc.Enabled:=true;
end;

procedure TFRemProntaEntrega.DesativaEdits;
begin
  PRemessa.DisableEdits;
  EdNumerodoc.Enabled:=true;

end;


procedure TFRemProntaEntrega.EdNumeroDocValidate(Sender: TObject);
begin
  if EdNumerodoc.AsInteger>0 then begin
     QBusca:=sqltoquery(FGeral.buscaremessa(EdNumerodoc.AsInteger,Global.CodRemessaProntaEntrega));
     if QBusca.eof then begin
       EdNUmerodoc.INvalid('Numero de remessa não encontrado');
       EdNumerodoc.ClearAll(FRemProntaEntrega,99);
       Grid.Clear;
     end else begin
       Campostoedits(Qbusca);
       Campostogrid(Qbusca);
       Edtotalqtde.setvalue(calculatotalqtde);   // 29.11.06
       Edtotalremessa.setvalue(calculatotal);   // 25.05.10
       EdCliente.ValidFind;
       TotalRemessa:=EdTotalremessa.AsCurrency;
       EdRepr_codigo.ValidFind;
       EdUnid_codigo.ValidFind;
     end;
  end;

end;

procedure TFRemProntaEntrega.GravaItemConsignacao(xnovo:string='N');
var sqlcor,sqltamanho,sqlcopa:string;
    Q2:TSqlquery;
begin
   Q2:=Sqltoquery('select moes_status,moes_transacao from movesto where moes_status=''N'''+
          ' and moes_numerodoc='+EdNumerodoc.AsSql+
          ' and moes_tipomov='+Stringtosql(Global.CodRemessaProntaEntrega)+
          ' and moes_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and moes_tipo_codigo='+EdCliente.AsSql+
          ' and moes_tipocad=''C''' );
    if trim(Grid.Cells[Grid.getcolumn('codcor'),Grid.row])<>'' then
      sqlcor:=' and move_core_codigo='+Grid.Cells[Grid.getcolumn('codcor'),Grid.row]
    else
      sqlcor:='';
    if trim(Grid.Cells[Grid.getcolumn('codtamanho'),Grid.row])<>'' then
      sqltamanho:=' and move_tama_codigo='+Grid.Cells[Grid.getcolumn('codtamanho'),Grid.row]
    else
      sqltamanho:='';
    if trim(Grid.Cells[Grid.getcolumn('codcopa'),Grid.row])<>'' then
      sqlcopa:=' and move_copa_codigo='+Grid.Cells[Grid.getcolumn('codcopa'),Grid.row]
    else
      sqlcopa:=' and ( move_copa_codigo=0 or move_copa_codigo is null )';

    if Q2.Eof then begin
      Avisoerro('Não encontrado esta remessa para incluir este item');
      exit;
    end else begin
      Transacao:=Q2.fieldbyname('moes_transacao').Asstring;
      if (OP='I') or (xnovo='S') then begin
        Sistema.Insert('Movestoque');
        Sistema.SetField('move_esto_codigo',EdProduto.Text);
        Sistema.SetField('move_transacao',transacao);
        Sistema.SetField('move_operacao',FGeral.GetOperacao);
        Sistema.SetField('move_numerodoc',Ednumerodoc.Asinteger);
        Sistema.SetField('move_status','N');
        Sistema.SetField('move_tipomov',Global.CodRemessaProntaEntrega);
        Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
        Sistema.SetField('move_tipo_codigo',EdCliente.AsInteger);
        Sistema.SetField('move_tipocad','C');
        Sistema.SetField('move_repr_codigo',EdRepr_codigo.AsInteger);
        Sistema.SetField('move_datamvto',Sistema.Hoje);
        Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
        Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
        Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
// 29.11.06
        Sistema.SetField('move_core_codigo',Edcodcor.asinteger);
        Sistema.SetField('move_tama_codigo',Edcodtamanho.asinteger);
        Sistema.SetField('move_copa_codigo',Edcodcopa.asinteger);

      end else
        Sistema.Edit('Movestoque');
        
      Sistema.SetField('move_qtde',EdQtde.AsCurrency);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_venda',EdUnitario.AsCurrency);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      if (OP='I') or (xnovo='S') then
         Sistema.Post('')
      else
         Sistema.Post('move_transacao='+stringtosql(transacao)+' and move_esto_codigo='+EdProduto.assql+
                       sqlcor+sqltamanho+sqlcopa);
      Sistema.Commit;
    end;
    Q2.close;
    Freeandnil(Q2);
end;



procedure TFRemProntaEntrega.bSairClick(Sender: TObject);
begin
//  Grid.Clear;
  Close;

end;

procedure TFRemProntaEntrega.ReservaEstoque(Codigo, IncExc: string; Qtde: currency);
var p:integer;
begin
  if not Global.Topicos[1201] then begin
    if Incexc='I' then begin
      ListaReservaCodigo.Add(Codigo);
      ListaReservaQtde.Add(transform(Qtde,'#,###,###.00'));
      FGeral.ReservaEstoque(Codigo,EdUnid_codigo.text,'S',Global.CodRemessaProntaEntrega,Qtde);
    end else begin
      p:=ListaReservaCodigo.IndexOf(Codigo);
      if p>-1 then begin
        ListaReservaCodigo.Delete(p);
        ListaReservaQtde.Delete(p);
      end;
  // 15.06.04
      FGeral.ReservaEstoque(Codigo,EdUnid_codigo.text,'E',Global.CodRemessaProntaEntrega,Qtde);
    end;
    Sistema.Commit;
  end;
end;

procedure TFRemProntaEntrega.RetornaReserva;
var p:integer;
begin
  if not Global.Topicos[1201] then begin
    if ListaReservaCodigo<>nil then begin
      if ListaReservaCodigo.Count>0 then begin
        for p:=0 to ListaReservaCodigo.Count-1 do begin
          FGeral.ReservaEstoque(ListaReservaCodigo[p],EdUnid_codigo.text,'E',Global.CodRemessaProntaEntrega,texttovalor(ListaReservaQtde[p]));
        end;
        Sistema.Commit;
        ListaReservaCodigo.Clear;
        ListaReservaQTde.Clear;
      end;
    end;
  end;

end;



procedure TFRemProntaEntrega.bImpressaoClick(Sender: TObject);
var largura,titem,linhaspp,produtospp:integer;
    QBusca,QClientes:TSqlquery;
    tqtde,liquido,Tdescacre,valorbruto,qtde,venda:currency;
    descacre,produto:string;
begin
//  if not EdCliente.ValidEdiAll(FRemProntaEntrega,99) then exit;
  if (EdNumerodoc.isempty) and (OP='X') then exit;
  if not EdCliente.Valid then exit;
  if not EdRepr_codigo.Valid then exit;
  QBusca:=sqltoquery(FGeral.buscaremessa(EdNumerodoc.AsInteger,Global.CodRemessaProntaEntrega,'N;E'));
  if QBusca.Eof then begin
    Avisoerro('Remessa não encontrada');
    exit;
  end;
  if not Global.Topicos[1011] then begin
    if not Confirma('Confirma impressão ?') then exit;
  end;
  
  Sistema.BeginProcess('');

  largura:=80;
  linhaspp:=60;
  produtospp:=35;
  if not Arq.TUnidades.Active then Arq.TUnidades.Open;
//  if not Arq.TClientes.Active then Arq.TClientes.Open;
  if not Arq.TMunicipios.Active then Arq.TMunicipios.Open;
  Arq.TUnidades.Locate('unid_codigo',QBusca.Fieldbyname('Moes_Unid_codigo').Asstring,[]);
  QClientes:=sqltoquery('select * from clientes where clie_codigo='+stringtosql(QBusca.Fieldbyname('Moes_tipo_codigo').Asstring) );
//  Arq.TMunicipios.Locate('cida_codigo',Arq.TClientes.Fieldbyname('clie_cida_codigo_res').AsInteger,[]);
// 27.09.06
  Arq.TMunicipios.Locate('cida_codigo',QClientes.Fieldbyname('clie_cida_codigo_res').AsInteger,[]);
  tqtde:=0;titem:=0;
  if Arq.TTabelaPreco.Locate('tabp_codigo',QBusca.Fieldbyname('Moes_tabp_codigo').AsInteger,[]) then begin
    descacre:=Arq.TTabelaPreco.Fieldbyname('tabp_tipo').AsString;
  end else
    descacre:='';
  valorbruto:=0;

  if Global.Topicos[1011] then begin
    FImpressao.ImprimeRemessa(QBusca.fieldbyname('moes_numerodoc').AsInteger,QBusca.fieldbyname('moes_datamvto').AsDatetime,QBusca.fieldbyname('moes_unid_codigo').Asstring,Global.CodRemessaProntaEntrega);
    Sistema.EndProcess('');
    QBusca.Close;
    Freeandnil(QBusca);
    QClientes.Close;
    Freeandnil(QClientes);
    exit;
  end else begin
    FTextRel.Init(linhaspp);
    FTextRel.MargemEsquerda:=3;
    FTextRel.Titulo.Clear;
    FTextRel.ClearColunas;

  end;

    FTextRel.AddTitulo(FGeral.Centra('Remessa de Pronta Entrega',largura),true,False,false);
//    FTextrel.SaltaLinha(2);
    FTextRel.AddTitulo('Emissão : '+QBusca.fieldbyname('moes_dataemissao').Asstring+space(40)+
                      'Número : '+QBusca.fieldbyname('moes_numerodoc').Asstring
                      ,false,False,false);
    FTextRel.AddTitulo('Vendedor: '+QBusca.fieldbyname('moes_repr_codigo').Asstring+' - '+
                      FRepresentantes.GetDescricao(QBusca.fieldbyname('moes_repr_codigo').AsInteger)+
                      space(36)+'  Pg: [NumPg]'
                      ,false,False,false);
    FTextRel.AddTitulo(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
//    FTextrel.SaltaLinha(1);
    FTextRel.AddTitulo('Cliente......: '+QClientes.fieldbyname('clie_nome').AsString,false,False,false);
    FTextRel.AddTitulo('Codigo.......: '+QClientes.Fieldbyname('clie_codigo').Asstring,false,False,false);
    FTextRel.AddTitulo('Razão Social : '+strspace(QClientes.Fieldbyname('clie_razaosocial').Asstring,43)+
                      'Tel.:'+FGeral.Formatatelefone(QClientes.Fieldbyname('clie_foneres').Asstring)
                      ,false,False,false);
    FTextRel.AddTitulo('Endereço.....: '+strspace(QClientes.Fieldbyname('clie_endres').Asstring,40)+space(03)+
                      'CPF :'+FGeral.Formatacpf(QClientes.Fieldbyname('clie_cnpjcpf').Asstring)
                      ,false,False,false);
    FTextRel.AddTitulo('Bairro.......: '+strspace(QClientes.Fieldbyname('clie_bairrores').Asstring,40)
                      ,false,False,false);
    FTextRel.AddTitulo('Cep/Cidade/UF: '+FGeral.formatacep(QClientes.Fieldbyname('clie_cepres').Asstring)+' - '+
                      Arq.TMunicipios.Fieldbyname('cida_nome').Asstring+' - '+
                      strspace(Arq.TMunicipios.Fieldbyname('cida_uf').Asstring,02)
                      ,false,False,false);
    FTextRel.AddTitulo(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
//    FTextRel.SaltaLinha(2);
    FTextRel.AddTitulo(space(04)+'Codigo'+space(12)+'Quantidade'+space(5)+'Devolução'+space(2)+'Descrição'+space(36)+'Peças Vendidas'+
                      space(01)+'Vlr. Unitário'
                      ,false,False,true);
    FTextRel.AddTitulo(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);


  while not QBusca.Eof do begin

    produto:=Qbusca.fieldbyname('move_esto_codigo').asstring;
    qtde:=0;
    venda:=QBusca.Fieldbyname('Move_venda').AsCurrency;
    while ( not QBusca.Eof ) and (produto=Qbusca.fieldbyname('move_esto_codigo').asstring) do begin
      qtde:=qtde+QBusca.Fieldbyname('Move_qtde').AsCurrency;
      tqtde:=tqtde+QBusca.Fieldbyname('Move_qtde').AsCurrency;
      valorbruto:=valorbruto+(QBusca.Fieldbyname('Move_qtde').AsCurrency*QBusca.Fieldbyname('Move_vendabru').AsCurrency);
      QBusca.next;
    end;

    FTextRel.AddLinha(space(04)+strspace(produto,13)+space(03)+
                    FGeral.Formatavalor(qtde,'###,##0.000')+space(02)+
                    replicate('_',12)+space(02)+strspace(FEstoque.GetDescricao(produto),45)+
                    space(02)+replicate('_',12)+space(02)+FGeral.Formatavalor(venda,f_cr)
                    ,false,False,true);
    inc(titem);



  end;

  QBusca.First;
//////////////////////////////////////////////////////////////////////////////
//    if (QBusca.eof) then begin
      FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
    //  FTextRel.AddLinha(space(39)+'Total Mercadorias....: R$ '+FGeral.Formatavalor(QBusca.fieldbyname('moes_vlrtotal').AsCurrency,f_cr),false,False,false);
    //  tdescacre:=FGeral.Arredonda(QBusca.fieldbyname('moes_vlrtotal').AsCurrency*(QBusca.fieldbyname('moes_tabaliquota').AsCurrency/100) ,2);
      tdescacre:=FGeral.Arredonda(valorbruto-QBusca.fieldbyname('moes_vlrtotal').AsCurrency ,2);
//      if tdescacre>0 then
//        FTextRel.AddLinha(space(39)+'Total Mercadorias....: R$ '+FGeral.Formatavalor(valorbruto,'###,##0.00'),false,False,false)
//      else
        FTextRel.AddLinha(space(39)+'Total Mercadorias....: R$ '+FGeral.Formatavalor(QBusca.fieldbyname('moes_vlrtotal').AsCurrency,'###,##0.00'),false,False,false);
      if descacre='D' then begin
        FTextRel.AddLinha(space(39)+'Desconto sobre total.: R$ '+FGeral.Formatavalor(tdescacre,'###,##0.00'),false,False,false);
        liquido:=QBusca.fieldbyname('moes_vlrtotal').AsCurrency-tdescacre;
      end else if descacre='A' then begin
        liquido:=QBusca.fieldbyname('moes_vlrtotal').AsCurrency+tdescacre;
        FTextRel.AddLinha(space(39)+'Acréscimo sobre total: R$ '+FGeral.Formatavalor(tdescacre,'###,##0.00'),false,False,false);
      end;
      if tdescacre>0 then
        FTextRel.AddLinha(space(39)+'Total líquido........: R$ '+FGeral.Formatavalor(liquido,f_cr),false,False,false);
//      FTextRel.AddLinha(space(39)+'Total em Quantidade..:    '+FGeral.Formatavalor(tqtde,'###,##0.00'),false,False,false);
      FTextRel.AddLinha(strzero(QBusca.fieldbyname('moes_usua_codigo').asinteger,4)+' - '+strspace(FUsuarios.getnome(QBusca.fieldbyname('moes_usua_codigo').asinteger),32)+'Total em Quantidade..:    '+FGeral.Formatavalor(tqtde,'###,##0.000'),false,False,false);
      FTextRel.AddLinha(space(39)+'Total de Itens.......:    '+FGeral.Formatavalor(titem,'####'),false,False,false);
      FTextRel.SaltaLinha(2);
      FTextRel.AddLinha('Data para acerto : '+formatdatetime('dd/mm/yy',QBusca.fieldbyname('moes_dataemissao').AsDateTime+30)+
                        space(06)+'Data segunda visita ____/____/____',false,False,false);
      FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
      FTextRel.AddLinha(space(50)+QBusca.fieldbyname('moes_numerodoc').Asstring+' - '+QBusca.fieldbyname('moes_status').Asstring,false,False,false);
      FTextRel.SaltaLinha(1);
    FTextRel.AddLinha('Declaro que recebi as mercadorias acima discriminadas : '+
                        replicate('_',21),false,False,false);
//    end;
/////////////////////////////////////////////////////////////////////
// 10.05.06
    if op='A' then
      semvideo:='N';

    if semvideo='N' then
      FTextRel.Video
    else begin
      FGeral.Imprimesemvideo(FTextrel.PaginaAtual);
    end;

  Sistema.EndProcess('');
  QBusca.Close;
  Freeandnil(QBusca);
  QClientes.Close;
  Freeandnil(QClientes);
end;

procedure TFRemProntaEntrega.bdevolucaoClick(Sender: TObject);
var codigoestoque:string;
    qtde:currency;
    Q:TSqlquery;
begin
  if EdRepr_codigo.AsInteger=0 then exit;
  if trim(Grid.Cells[0,Grid.row])='' then exit;
  codigoestoque:=Grid.Cells[0,Grid.row];
  Q:=Sqltoquery('select move_status from movestoque where move_status=''N'''+
          ' and move_numerodoc='+EdNumerodoc.AsSql+
          ' and move_tipomov='+Stringtosql(Global.CodDevolucaoConsig)+
          ' and move_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and move_tipo_codigo='+EdCliente.AsSql+
          ' and move_esto_codigo='+Stringtosql(codigoestoque)+
          ' and move_tipocad='+Stringtosql('C') );
  if not Q.Eof then begin
      Avisoerro('Produto já devolvido nesta consignação');
      exit;
  end;
  if confirma('Confirma devolução ?') then begin
    qtde:=texttovalor(Grid.Cells[2,Grid.row]);
////    Calculatotal(Edtotalremessa);
////    ReservaEstoque(Codigoestoque,'E',qtde);
    if Q.Eof then begin
      GravaItemDevolucao;
      Grid.DeleteRow(Grid.Row);
      Sistema.Commit;
    end;
    Q.free;
  end;

end;
//}
////////////////////////////////////////

procedure TFRemProntaEntrega.GravaItemDevolucao;
var codigograde,codigolinha,codigocoluna:integer;
    codigoestoque:string;
    qtde,venda,totaldevolucao,vlr,qtd:currency;
    Q,QEstQtde:TSqlquery;
begin
    Q:=Sqltoquery('select move_venda,move_qtde from movestoque where move_status=''N'''+
          ' and move_numerodoc='+EdNumerodoc.AsSql+
          ' and move_tipomov='+Stringtosql(Global.CodDevolucaoConsig)+
          ' and move_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and move_tipo_codigo='+EdCliente.AsSql+
          ' and move_tipocad='+Stringtosql('C') );
    totaldevolucao:=0;
    while not Q.Eof do begin
      vlr:=Q.fieldbyname('move_qtde').AsCurrency;
      qtd:=Q.fieldbyname('move_venda').AsCurrency;
      totaldevolucao:=totaldevolucao+FGeral.Arredonda(vlr*qtd,2);
      Q.Next;
    end;
    codigoestoque:=Grid.Cells[0,Grid.row];
    codigograde:=FEstoque.GetCodigoGrade(EdProduto.Text);
    qtde:=texttovalor(Grid.Cells[2,Grid.row]);
    venda:=texttovalor(Grid.Cells[3,Grid.row]);
    totaldevolucao:=totaldevolucao+FGeral.Arredonda(venda*qtde,2);
    Transacao:=FGeral.GetTransacao;
    FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
             Global.CodDevolucaoConsig,Transacao,EdNumerodoc.AsInteger,TotalDevolucao,EdMoes_Tabp_codigo.AsInteger,'A');
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',codigoestoque);
      codigolinha:=FEstoque.GetCodigoLinha(codigoestoque,codigograde);
      codigocoluna:=FEstoque.GetCodigoColuna(codigoestoque,codigograde);
      Arq.TEstoque.Locate('esto_codigo',codigoestoque,[]);
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
      Sistema.SetField('move_numerodoc',Ednumerodoc.Asinteger);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',Global.CodDevolucaoConsig);
      Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('move_tipo_codigo',EdCliente.AsInteger);
      Sistema.SetField('move_tipocad','C');
      Sistema.SetField('move_repr_codigo',EdRepr_codigo.AsInteger);
      Sistema.SetField('move_qtde',Qtde);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',EdDtEmissao.AsDate);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_venda',Venda);
      Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.Setfield('move_remessas',strzero(EdNumerodoc.asinteger,8));
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.Post('');

      Sistema.Edit('MovEstoque');
      Sistema.SetField('move_qtderetorno',Qtde);
      Sistema.Post('move_numerodoc='+EdNumerodoc.AsSql+' and move_tipomov='+stringtosql(Global.CodRemessaProntaEntrega)+
                   'and move_esto_codigo='+stringtosql(codigoestoque)+
                   'and move_tipo_codigo='+EdCliente.AsSql+
                   'and move_unid_codigo='+stringtosql(EdUnid_codigo.text));

      Sistema.Commit;

    QEstQtde:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Codigoestoque,EdUnid_codigo.text));
    if not QEstQtde.Eof then
      FGeral.MovimentaQtdeEstoque(codigoestoque,EdUnid_codigo.text,'E',Global.CodRemessaProntaEntrega,Qtde,QEstqtde);
    QEstQtde.Free;Q.free;
end;


procedure TFRemProntaEntrega.EdMoes_tabp_codigoValidate(Sender: TObject);
begin
  if EdMoes_tabp_codigo.asinteger>0 then begin
    if Arq.TTabelaPreco.Locate('tabp_codigo',EdMoes_tabp_codigo.AsInteger,[]) then begin
      SetEdTabp_aliquota.Text:=FTabela.GetDescAliquota(EdMoes_tabp_codigo.asinteger);
      perc:=FTabela.GetAliquota(EdMoes_tabp_codigo.AsInteger);
    end else begin
      SetEdTabp_aliquota.Text:='';
      EdMoes_tabp_codigo.Invalid('Tabela não encontrada');
    end;
  end else begin
    SetEdTabp_aliquota.Text:='';
    perc:=0;
  end;
  bIncluiritemClick(FRemProntaEntrega);


end;

procedure TFRemProntaEntrega.EdDtemissaoValidate(Sender: TObject);
begin
  if not FGeral.ValidaMvto(EdDtemissao) then
    EdDtemissao.Invalid('');

end;

procedure TFRemProntaEntrega.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var QMestre:TSqlquery;
begin
  if (EdCliente.AsInteger>0) and (EdRepr_codigo.AsInteger>0) then begin
    if OP='I' then begin
      QMestre:=Sqltoquery('select moes_status from movesto where moes_status=''N'''+
          ' and moes_tipomov='+Stringtosql(Global.CodRemessaProntaEntrega)+
          ' and moes_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and moes_tipo_codigo='+EDCliente.AsSql+
          ' and moes_datamvto='+EdDtEmissao.AsSql+
          ' and moes_tipocad='+Stringtosql('C') );
      if QMestre.Eof then begin
        if Confirma('É provável que este documento ainda não foi gravado.  Gravar ?') then
          bgravarclick(Self);
      end;
      RetornaReserva;
    end else if TotalRemessa<>EdTotalremessa.AsCurrency then begin
      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
             Global.CodRemessaProntaEntrega,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,Op);
      Sistema.Commit;
    end;
    Grid.clear;
  end;

  if ListaReservaCodigo<>nil then ListaReservaCodigo.Free;
  if ListaReservaQtde<>nil then ListaReservaQtde.Free;

end;

procedure TFRemProntaEntrega.EdProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#27 then begin
    bcancelaritemclick(FRemProntaEntrega);
    bgravarclick(FRemProntaEntrega);
  end;

end;

procedure TFRemProntaEntrega.EdCodcopaValidate(Sender: TObject);
var x:integer;
begin
   if not FGeral.ValidaGrade(EdCodcor.asinteger,EdCodtamanho.asinteger,EdCodcopa.asinteger,EdProduto.text,'cor;tamanho;copa') then
     EdCodcopa.invalid('')
   else begin
      if op='A' then begin
    //      x:=ProcuraGrid(0,EdProduto.Text);
          x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.GetColumn('codtamanho'),Edcodtamanho.asinteger,
                            Grid.getcolumn('codcor'),EdCodcor.asinteger,Grid.getcolumn('codcopa'),EdCodcopa.asinteger);
          if x>0 then
            Edcodcopa.Invalid('Produto já existente.   Excluir e incluir.');
      end;
   end;

end;

end.
