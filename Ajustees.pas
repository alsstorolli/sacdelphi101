unit Ajustees;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, Sqlexpr;

type
  TFAjustesaldos = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bExcluir: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PAcerto: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdData: TSQLEd;
    EdNumeroDoc: TSQLEd;
    PIns: TSQLPanelGrid;
    EdEsto_codigo: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    EdEntSai: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    EdCodcopa: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    procedure Edunid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdDataValidate(Sender: TObject);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure EdEsto_codigoValidate(Sender: TObject);
    procedure EdEntSaiExitEdit(Sender: TObject);
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdEsto_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdCodtamanhoValidate(Sender: TObject);
    procedure EdCodcopaValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(tipomov:string);
  end;

var
  FAjustesaldos: TFAjustesaldos;
  Q:TSqlquery;
  tipos,transacao,tipoent,tiposai:string;

implementation

uses Geral, Sqlsis, Sqlfun, munic, Estoque, Grades, cadcor, tamanhos,
  cadcopa;

{$R *.dfm}

procedure TFAjustesaldos.Edunid_codigoKeyPress(Sender: TObject; var Key: Char);
begin
  FGeral.Limpaedit(EdUnid_codigo,key);

end;

procedure TFAjustesaldos.EdDataValidate(Sender: TObject);
begin
  if not FGeral.validamvto(EdData) then
    EdData.INvalid('');

end;

procedure TFAjustesaldos.EdNumeroDocValidate(Sender: TObject);

begin
  Sistema.beginprocess('Checando ajustes nesta data');
{
  Q:=sqltoquery('select movesto.*,movestoque.*,esto_descricao from movesto,movestoque,estoque'+
          ' left join cores on ( core_codigo=move_core_codigo )'+
          ' left join tamanhos on ( tama_codigo=move_tama_codigo )'+
          ' left join copas on ( copa_codigo=move_copa_codigo )'+
          ' where moes_status=''N'' and '+FGeral.GetIn('moes_tipomov',tipos,'C')+
          ' and moes_datamvto='+EdData.AsSql+' and moes_unid_codigo='+EdUnid_codigo.AsSql+
          ' and moes_numerodoc='+EdNUmerodoc.AsSql+
          ' and move_numerodoc='+EdNUmerodoc.AsSql+
          ' and move_datamvto='+EdData.AsSql+' and move_unid_codigo='+EdUnid_codigo.AsSql+
          ' and moes_numerodoc=move_numerodoc and move_status=''N'''+
          ' and esto_codigo=move_esto_codigo'+
          ' and '+FGeral.GetIn('move_tipomov',tipos,'C') );
}
  Q:=sqltoquery('select * from movestoque'+
          ' inner join movesto on ( moes_numerodoc=move_numerodoc and moes_datamvto=move_datamvto and moes_unid_codigo=move_unid_codigo )'+
          ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
          ' left join cores on ( core_codigo=move_core_codigo )'+
          ' left join tamanhos on ( tama_codigo=move_tama_codigo )'+
          ' left join copas on ( copa_codigo=move_copa_codigo )'+
          ' where move_status=''N'' and '+FGeral.GetIn('move_tipomov',tipos,'C')+
          ' and move_datamvto='+EdData.AsSql+' and move_unid_codigo='+EdUnid_codigo.AsSql+
          ' and moes_numerodoc='+EdNUmerodoc.AsSql+
          ' and move_numerodoc='+EdNUmerodoc.AsSql+
          ' and move_datamvto='+EdData.AsSql+' and move_unid_codigo='+EdUnid_codigo.AsSql+
          ' and moes_numerodoc=move_numerodoc'+
          ' and '+FGeral.GetIn('move_tipomov',tipos,'C') );
  Grid.Clear;
  Sistema.endprocess('');
  if not Q.eof then
    Grid.QueryToGrid(Q);
  Q.close;
  Freeandnil(Q);

end;

procedure TFAjustesaldos.bIncluirClick(Sender: TObject);
begin
  if not EdUnid_codigo.ValidEdiAll(FAjusteSaldos,99) then exit;
  Pins.Visible:=true;
  bSair.Enabled:=false;
  PAcerto.Enabled:=false;
  EdEsto_codigo.SetFocus;

end;

procedure TFAjustesaldos.bCancelarClick(Sender: TObject);
begin
  Pins.Visible:=false;
  bSair.Enabled:=true;
  PAcerto.Enabled:=true;
  EdUnid_codigo.SetFocus;

end;

procedure TFAjustesaldos.bExcluirClick(Sender: TObject);
var codestoque,tipomovimento,sqlcor,sqltamanho:string;
    qtdemov:currency;
    Q:Tsqlquery;
begin
  if PIns.Visible then exit;
//  if not EdUnid_codigo.ValidEdiAll(FAcertos,99) then exit;
  if Grid.RowCount<2 then exit;
  codestoque:=Grid.Cells[0,Grid.row];
  if trim(codestoque)<>'' then begin
    qtdemov:=texttovalor( Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row] );
    if confirma('Confirma a exclusão e retorno da quantidade ao estoque ?') then begin
      if trim(Grid.cells[Grid.getcolumn('move_core_codigo'),Grid.row])<>'' then
        sqlcor:=' and move_core_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_core_codigo'),Grid.row])
      else
        sqlcor:=' and ( move_core_codigo=0 or move_core_codigo is null )';
      if trim(Grid.cells[Grid.getcolumn('move_tama_codigo'),Grid.row])<>'' then
        sqltamanho:=' and move_tama_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_tama_codigo'),Grid.row])
      else
        sqltamanho:=' and ( move_tama_codigo=0 or move_tama_codigo is null )';
      Sistema.BeginTransaction('Eliminando acerto de estoque');
      ExecuteSql('Update movestoque set move_status=''C'' where move_status=''N'''+
          ' and move_numerodoc='+EdNumerodoc.AsSql+
          ' and '+FGeral.getin('move_tipomov',Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai,'C')+
          ' and move_unid_codigo='+EdUnid_codigo.AsSql+
          ' and move_tipo_codigo='+EdUnid_codigo.AsSql+
          ' and move_datamvto='+EdDAta.AsSql+
          ' and move_esto_codigo='+Stringtosql(codestoque)+
          sqlcor+sqltamanho );
      Q:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+Stringtosql(codestoque)+
                ' and esqt_unid_codigo='+EdUnid_codigo.AsSql);
      if Grid.cells[4,grid.Row]=Global.CodAcertoEsSai then
        tipomovimento:='E'   // inverte pois esta excluindo um acerto de estoque
      else
        tipomovimento:='S';
      FGeral.MovimentaQtdeEstoque(codestoque,EdUnid_codigo.Text,tipomovimento,Global.CodAcertoEsEnt,qtdemov,Q);
      Grid.DeleteRow(grid.Row);
      Q.close;
      freeandnil(Q);
      Sistema.EndTransaction('');
    end;
  end;
end;

procedure TFAjustesaldos.EdEsto_codigoValidate(Sender: TObject);
//var p:integer;
begin
//  p:=FGeral.ProcuraGrid(0,EdEsto_codigo.text,Grid);
end;

procedure TFAjustesaldos.EdEntSaiExitEdit(Sender: TObject);
var tipoMovimento,EntSai,codestoque,sqlcor,sqltamanho:string;
    QEstoque,QBusca,QGrade:TSqlquery;
    qtdeemestoque,qtdeajustada:currency;
    Numerodoc:integer;
    usougrade:boolean;


   procedure gravaacertomestre;
   begin
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacao);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',EdNumerodoc.AsInteger);
      Sistema.SetField('moes_tipomov',TipoMovimento);
      Sistema.SetField('moes_unid_codigo',EdUNid_codigo.Text);
      Sistema.SetField('moes_estado',FCidades.GetUF(EdUnid_codigo.ResultFind.fieldbyname('unid_cida_codigo').AsInteger));
//      Sistema.SetField('moes_repr_codigo',Representante);
      Sistema.SetField('moes_tipo_codigo',EdUnid_codigo.text);
      Sistema.SetField('moes_tipocad','U');
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',EdData.AsDate);
      Sistema.SetField('moes_dataemissao',EdData.AsDate);
//      Sistema.SetField('moes_vlrtotal',Valortotal);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.Post();
   end;

   procedure gravaacertodetalhe;
   var codigograde,codigocoluna,codigolinha:integer;
   begin
      codigograde:=FEstoque.GetCodigoGrade(EdESto_codigo.text);
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',EdESto_codigo.Text);
      codigolinha:=FEstoque.GetCodigoLinha(EdESto_codigo.Text,codigograde);
      codigocoluna:=FEstoque.GetCodigoColuna(EdESto_codigo.Text,codigograde);
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
      Sistema.SetField('move_numerodoc',Ednumerodoc.AsInteger);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',TipoMovimento);
      Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('move_tipo_codigo',EdUnid_codigo.text);
      Sistema.SetField('move_tipocad','U');
//      Sistema.SetField('move_repr_codigo',Representante);
      Sistema.SetField('move_qtde',EdQtde.ascurrency);
      Sistema.SetField('move_estoque',qtdeajustada);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',EdData.AsDate);
//      Sistema.SetField('move_qtderetorno',0);
//      Sistema.SetField('move_venda',Texttovalor(Grid.Cells[3,linha]));
      Sistema.SetField('move_grup_codigo',EdEsto_codigo.resultfind.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',EdEsto_codigo.resultfind.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',EdEsto_codigo.resultfind.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_core_codigo',EdCodcor.asinteger);
      Sistema.SetField('move_tama_codigo',EdCodtamanho.asinteger);
      Sistema.SetField('move_copa_codigo',Edcodcopa.asinteger);
      Sistema.Post('');
   end;

   procedure EditstoGrid;
   var x:integer;
   begin
//      x:=FGeral.ProcuraGrid(0,EdEsto_codigo.Text,Grid);
    x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdEsto_codigo.Text,Grid,Grid.GetColumn('move_tama_codigo'),Edcodtamanho.asinteger,
                        Grid.getcolumn('move_core_codigo'),EdCodcor.asinteger,Grid.getcolumn('move_copa_codigo'),EdCodcopa.asinteger);
      if x=0 then begin
        if trim(Grid.Cells[0,1])<>'' then begin
          Grid.RowCount:=Grid.RowCount+1;
          x:=Grid.RowCount-1;
        end else
          x:=1;
        Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdEsto_codigo.Text;
        Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=EdEsto_codigo.ResultFind.fieldbyname('esto_descricao').asstring;
        Grid.Cells[Grid.getcolumn('move_estoque'),x]:=currtostr(EdQTde.AsCurrency);
        Grid.Cells[Grid.getcolumn('move_qtde'),x]:=currtostr(qtdeajustada);
        Grid.Cells[Grid.getcolumn('move_tipomov'),x]:=Tipomovimento;
        Grid.Cells[Grid.getcolumn('move_core_codigo'),x]:=EdCodcor.assql;
        Grid.Cells[Grid.getcolumn('move_tama_codigo'),x]:=EdCodtamanho.assql;
        Grid.Cells[Grid.getcolumn('move_copa_codigo'),x]:=EdCodcopa.assql;
        Grid.Cells[Grid.getcolumn('core_descricao'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
        Grid.Cells[Grid.getcolumn('tama_descricao'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
        Grid.Cells[Grid.getcolumn('copa_descricao'),x]:=fcopas.Getdescricao(EdCodcopa.asinteger);
      end else begin
        Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdEsto_codigo.Text;
        Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=EdEsto_codigo.ResultFind.fieldbyname('esto_descricao').asstring;
        Grid.Cells[Grid.getcolumn('move_estoque'),x]:=currtostr(EdQTde.AsCurrency);
        Grid.Cells[Grid.getcolumn('move_qtde'),x]:=currtostr(qtdeajustada);
        Grid.Cells[Grid.getcolumn('move_tipomov'),x]:=Tipomovimento;
        Grid.Cells[Grid.getcolumn('move_core_codigo'),x]:=EdCodcor.assql;
        Grid.Cells[Grid.getcolumn('move_tama_codigo'),x]:=EdCodtamanho.assql;
        Grid.Cells[Grid.getcolumn('move_copa_codigo'),x]:=EdCodcopa.assql;
        Grid.Cells[Grid.getcolumn('core_descricao'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
        Grid.Cells[Grid.getcolumn('tama_descricao'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
        Grid.Cells[Grid.getcolumn('copa_descricao'),x]:=fcopas.Getdescricao(EdCodcopa.asinteger);
      end;
      Grid.Refresh;
   end;


///////////////////28.04.08
    procedure IncluiGrade;
    begin
        Sistema.Insert('Estgrades');
        Sistema.Setfield('esgr_status','N');
        Sistema.Setfield('esgr_esto_codigo',EdEsto_codigo.text);
        Sistema.Setfield('esgr_unid_codigo',EdUnid_codigo.text);
        Sistema.Setfield('esgr_grad_codigo',0);
//        Sistema.Setfield('esgr_qtde',EdQtde.ascurrency );
//        Sistema.Setfield('esgr_qtdeprev',EdQtde.ascurrency );
        Sistema.Setfield('esgr_qtde',0 );
        Sistema.Setfield('esgr_qtdeprev',0 );
        Sistema.Setfield('esgr_codbarra','');
        Sistema.Setfield('esgr_custo',QEstoque.fieldbyname('esqt_custo').ascurrency);
        Sistema.Setfield('esgr_customedio',QEstoque.fieldbyname('esqt_customedio').ascurrency);
        Sistema.Setfield('esgr_custoger',QEstoque.fieldbyname('esqt_custoger').ascurrency);
        Sistema.Setfield('esgr_customeger',QEstoque.fieldbyname('esqt_customeger').ascurrency);
        Sistema.Setfield('esgr_vendavis',QEstoque.fieldbyname('esqt_vendavis').ascurrency);
        Sistema.Setfield('esgr_dtultvenda',EdData.asdate);
        Sistema.Setfield('esgr_dtultcompra',EdData.asdate);
        Sistema.Setfield('esgr_usua_codigo',Global.Usuario.codigo);
        Sistema.Setfield('esgr_tama_codigo',EdCodtamanho.asinteger);
        Sistema.Setfield('esgr_core_codigo',Edcodcor.AsInteger);
//        Sistema.Setfield('esgr_copa_codigo',xcodcopa);
        Sistema.Setfield('esgr_custoser',qEstoque.fieldbyname('esqt_custoser').ascurrency);
        Sistema.Setfield('esgr_customedioser',QEstoque.fieldbyname('esqt_customedioser').ascurrency);
        Sistema.Post();
        Sistema.Commit;
    end;

begin

  if not confirma('Confirma lançamento') then exit;
  QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdEsto_codigo.AsSql+
                ' and esqt_unid_codigo='+EdUnid_codigo.AsSql);
// 18.08.05
  if QEstoque.eof then begin
    Avisoerro('Codigo ainda não cadastrado nesta unidade');
    exit;
  end;
  EntSai:=EdEntsai.text;
// 24.04.08
  usougrade:=(EdCodcor.AsInteger+EdCodtamanho.asinteger)>0;
  if usougrade then begin
    codestoque:=edEsto_codigo.Text;
    if EdCodcor.AsInteger>0 then
      sqlcor:=' and esgr_core_codigo='+EdCodcor.assql
    else
      sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
    if EdCodtamanho.asinteger>0 then
      sqltamanho:=' and esgr_tama_codigo='+EdCodtamanho.assql
    else
      sqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
    QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(codestoque)+
                  ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
    if (QGrade.eof) then begin
      IncluiGrade;
      QGrade.close;
      QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(codestoque)+
                  ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
    end;

    qtdeemestoque:=FGeral.QualQtde(Global.Usuario.Codigo,QGrade.fieldbyname('esgr_qtde').Ascurrency,QGrade.fieldbyname('esgr_qtdeprev').Ascurrency);;
  end else
    qtdeemestoque:=FGeral.QualQtde(Global.Usuario.Codigo,QEstoque.fieldbyname('esqt_qtde').Ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').Ascurrency);
  if Entsai='E' then begin
//    TipoMovimento:=Global.CodAcertoEsEnt;
    TipoMovimento:=tipoent;  // 07.12.05
    qtdeajustada:=qtdeemestoque + EdQtde.ascurrency;
  end else begin
//    TipoMovimento:=Global.CodAcertoEsSai;
    TipoMovimento:=tiposai;
    qtdeajustada:=qtdeemestoque - EdQtde.ascurrency;
  end;

  if EdNumerodoc.AsInteger>0 then begin
    Numerodoc:=FGeral.GetContador('AJUSTESALDO',false);
    sistema.beginprocess('Checando contador');
    QBusca:=sqltoquery('select movesto.* from movesto'+
          ' where moes_status=''N'' and '+FGeral.GetIn('moes_tipomov',tipos,'C')+
          ' and moes_numerodoc='+EdNumerodoc.AsSql+' and moes_datamvto='+EdData.AsSql+' and moes_unid_codigo='+EdUnid_codigo.AsSql);
    sistema.endprocess('');
  end;
  Sistema.BeginTransaction('Gravando ajuste');
  Transacao:=FGeral.GetTransacao;
  if EdNumerodoc.AsInteger>0 then begin
    if QBusca.Eof then begin
      GravaAcertoMestre;
    end else begin
      Transacao:=QBusca.fieldbyname('moes_transacao').AsString;
    end;
    QBusca.close;
    Freeandnil(QBusca);
  end else begin
     EdNumerodoc.SetValue(Numerodoc);
     GravaAcertoMestre;
  end;
  GravaAcertoDetalhe;
// depois ver se faz a gravacao cfe a permissao do usuario ref. a qtde em estoque
// nao mexe no estoque até ter o estoque por grade
  if (EdCodcor.asinteger=0) and (Edcodtamanho.asinteger=0) and (Edcodcopa.asinteger=0) then begin
    Sistema.Edit('Estoqueqtde');
    Sistema.Setfield('esqt_qtde',qtdeajustada);
    Sistema.Setfield('esqt_qtdeprev',qtdeajustada);
    Sistema.Post('esqt_esto_codigo='+EdEsto_codigo.assql+' and esqt_unid_codigo='+EdUNid_codigo.assql+
               ' and esqt_status=''N'''  );
  end;
// 28.04.08 - movimentacao da grade se houver
///////////////////////////////////////
  if usougrade then begin
//    if FGeral.QualQtde(Global.Usuario.Codigo,QEstoque.fieldbyname('esqt_qtde').Ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').Ascurrency) >= 0 then
//      FGeral.MovimentaQtdeEstoque(EdEsto_codigo.Text,EdUnid_codigo.Text,EntSai,tipomovimento,abs(dif),QEstoque,0,abs(difpecas))
//    else
//      FGeral.MovimentaQtdeEstoque(EdEsto_codigo.Text,EdUnid_codigo.Text,EntSai,tipomovimento,EdQTde.ascurrency,QEstoque,0,EdPecas.ascurrency);
  // 28.04.08
    if usougrade then begin
      Sistema.Edit('Estgrades');
      Sistema.Setfield('esgr_qtde',qtdeajustada);
      Sistema.Setfield('esgr_qtdeprev',qtdeajustada);
      Sistema.Post('esgr_esto_codigo='+EdEsto_codigo.assql+' and esgr_unid_codigo='+EdUNid_codigo.assql+
                 ' and esgr_status=''N'''+sqlcor+sqltamanho  );
    end;

  end;
///////////////////////////////////////
  Editstogrid;

  Sistema.EndTransaction('');
  QEstoque.close;
  Freeandnil(QEstoque);
  EdEsto_codigo.ClearAll(FAjustesaldos,99);
  EdEsto_codigo.Setfocus;
end;

procedure TFAjustesaldos.Execute(tipomov:string);
begin
  if FAjustesaldos=nil then
    FGeral.CreateForm(TFAjustesaldos,FAjustesaldos);
  FAjustesaldos.Grid.clear;
  if tipomov='AJ' then begin
    tipos:=Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai;
    tipoent:=Global.CodAcertoEsEnt;
    tiposai:=Global.CodAcertoEsSai;
    FAjustesaldos.caption:='Ajuste de Saldo de Estoque';
  end else begin
    tipos:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai;
    tipoent:=Global.CodBaixaMatEnt;
    tiposai:=Global.CodBaixaMatSai;
    FAjustesaldos.caption:='Baixa de Materia Prima';
  end;
  FAjustesaldos.Show;
  FAjustesaldos.EdUnid_codigo.setfocus;
end;

procedure TFAjustesaldos.Edunid_codigoValidate(Sender: TObject);
begin
   if not fGeral.ValidaUnidadesMvtoUsuario(EdUnid_codigo) then
     EdUnid_codigo.invalid('');
end;

procedure TFAjustesaldos.FormActivate(Sender: TObject);
begin
  EdUnid_codigo.SetFocus;
  EdData.SetDate(Sistema.hoje);

end;

procedure TFAjustesaldos.EdEsto_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#27 then
    bcancelarclick(FAjustesaldos);
end;

procedure TFAjustesaldos.EdCodtamanhoValidate(Sender: TObject);
var p:integer;
begin
  p:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdESto_codigo.Text,Grid,Grid.GetColumn('move_tama_codigo'),Edcodtamanho.asinteger,
                        Grid.getcolumn('move_core_codigo'),EdCodcor.asinteger,Grid.getcolumn('move_copa_codigo'),EdCodcopa.asinteger);
  if p>0 then
    EdcodTamanho.Invalid('Já digitado nesta unidade neste dia');

end;

procedure TFAjustesaldos.EdCodcopaValidate(Sender: TObject);
var p:integer;
begin
  p:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdESto_codigo.Text,Grid,Grid.GetColumn('move_tama_codigo'),Edcodtamanho.asinteger,
                        Grid.getcolumn('move_core_codigo'),EdCodcor.asinteger,Grid.getcolumn('move_copa_codigo'),EdCodcopa.asinteger);
  if p>0 then
    EdEsto_codigo.Invalid('Já digitado nesta unidade neste dia');

end;

end.
