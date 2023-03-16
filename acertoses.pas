unit acertoses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr;
//  , DataGrid;

type
  TFAcertos = class(TForm)
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
    PIns: TSQLPanelGrid;
    EdEsto_codigo: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    EdData: TSQLEd;
    EdNumeroDoc: TSQLEd;
    Edpecas: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    EdCodcopa: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    batualizaestoque: TSQLBtn;
    EdTotalQtde: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure EdEsto_codigoValidate(Sender: TObject);
    procedure EdQtdeExitEdit(Sender: TObject);
    procedure Edunid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure bExcluirClick(Sender: TObject);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure EdDataValidate(Sender: TObject);
    procedure EdCodtamanhoValidate(Sender: TObject);
    procedure EdEsto_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure batualizaestoqueClick(Sender: TObject);
    procedure EdNumeroDocExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(tipo:string;Acumula:boolean=false);
  end;

var
  FAcertos: TFAcertos;
  tipos,transacao,tipoEntrada,TipoSaida:string;
  Q,QBuscaEs,QEstoque,QGrade,QM:TSqlquery;
  Acum:Boolean;


implementation

uses Geral, SqlSis, SqlFun, munic, Estoque, Grades , cadcor, tamanhos,
  Arquiv;

{$R *.dfm}

procedure TFAcertos.FormActivate(Sender: TObject);
begin
//  tipos:=Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai;
// 28.11.05
  tipos:=tipoentrada+';'+tiposaida;
end;

procedure TFAcertos.Execute(Tipo:string;Acumula:boolean=false);
//////////////////////////////////////////////////////////////////
begin
  if FAcertos=nil then
    FGeral.CreateForm(TFAcertos,FAcertos);
  FACertos.Grid.clear;
  Acum:=acumula;
  if pos(tipo,Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai)>0 then begin
    FAcertos.Caption:='Acertos de Estoque';
    tipoentrada:=Global.CodAcertoEsEnt;
    tiposaida:=Global.CodAcertoEsSai;
  end else begin
    if Acum then begin
      FAcertos.Caption:='Contagem Balanço ACUMULADO utilizando LEITOR DE CODIGO DE BARRAS';
      tipoentrada:=Global.CodContagemBalancoE;
      tiposaida:=Global.CodContagemBalancoS;
// 04.07.13 - senao nao deixa passar codigo de barra jamanta...
      FAcertos.EdEsto_codigo.FindTable:='';
      FAcertos.EdEsto_codigo.FindField:='';

    end else begin
      FAcertos.Caption:='Contagem Balanço';
      tipoentrada:=Global.CodContagemBalancoE;
      tiposaida:=Global.CodContagemBalancoS;
    end;
  end;
  FAcertos.Edpecas.Enabled:=Global.Topicos[1302];
  FGeral.EstiloForm(FAcertos);
  FGeral.ConfiguraColorEditsNaoEnabled(FAcertos);
  if Global.Topicos[1206] then begin
    EdEsto_codigo.FindField:='esto_referencia';
    EdEsto_codigo.Title:='Referência';
  end else begin
    EdEsto_codigo.FindField:='esto_codigo';
    EdEsto_codigo.Title:='Código';
  end;
  EdEsto_codigo.Update;
// 10.04.12
  EdCodcor.Enabled:=Global.Topicos[1233];
  EdCodTamanho.Enabled:=Global.Topicos[1233];
  EdCodcor.Visible:=Global.Topicos[1233];
  EdCodTamanho.Visible:=Global.Topicos[1233];
  SetEdcor.Visible:=Global.Topicos[1233];
  SetEdTamanho.Visible:=Global.Topicos[1233];
  EdCodcor.Enabled:=Global.Topicos[1233];
  EdCodTamanho.Enabled:=Global.Topicos[1233];
// 24.02.11
  EdCodcor.Visible:=Global.Topicos[1233];
  EdCodTamanho.Visible:=Global.Topicos[1233];
  SetEdcor.Visible:=Global.Topicos[1233];
  SetEdTamanho.Visible:=Global.Topicos[1233];
  if Global.Topicos[1233] then begin
    SetEdESTO_DESCRICAO.Width:=127;
  end else begin
    SetEdESTO_DESCRICAO.Width:=250;
  end;
///////////
  FAcertos.Show;
// 09.04.2012
  if not Arq.TEstoqueqtde.active then Arq.TEstoqueQtde.open;
// 01.10.08
  if  FAcertos.EdData.isempty then
    FAcertos.EdData.SetDate(Sistema.hoje);
// 19.05.14
  EdCodcor.Empty:=( (acum) and (Global.Topicos[1038]) );
  EdCodtamanho.Empty:=( (acum) and (Global.Topicos[1038]) );

  FAcertos.EdUnid_codigo.SetFocus;
end;

procedure TFAcertos.bIncluirClick(Sender: TObject);
begin
  if not EdUnid_codigo.ValidEdiAll(FAcertos,99) then exit;
  Pins.Visible:=true;
  bSair.Enabled:=false;
  PAcerto.Enabled:=false;
  EdEsto_codigo.SetFocus;
end;

procedure TFAcertos.bCancelarClick(Sender: TObject);
begin
  Pins.Visible:=false;
  bSair.Enabled:=true;
  PAcerto.Enabled:=true;
  EdUnid_codigo.SetFocus;
end;

procedure TFAcertos.EdEsto_codigoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
var p:integer;
    codigobarra:boolean;
    codbarra:string;
begin
//  p:=FGeral.ProcuraGrid(0,EdEsto_codigo.text,Grid);
//  if p>0 then
//    EdEsto_codigo.Invalid('Codigo já digitado nesta unidade neste dia');
  if (Global.Topicos[1206]) and ( not EdEsto_codigo.isempty ) then begin
     EdEsto_codigo.text:=EdEsto_codigo.resultfind.fieldbyname('esto_codigo').asstring;
  end else if not FEstoque.ValidaCodigoProduto(EdEsto_codigo,EdEsto_codigo.text) then
    exit;

  codigobarra:=false;
  if FGeral.CodigoBarra(EdEsto_codigo.Text,EdEsto_codigo) then begin
    QBuscaEs:=sqltoquery('select * from estoque where esto_Codbarra='+EdEsto_codigo.assql);
    codbarra:=EdEsto_codigo.text;
    if not QBuscaES.Eof then begin
      EdEsto_codigo.Text:=QBuscaEs.fieldbyname('esto_codigo').AsString;
      SetEdEsto_descricao.text:=QBuscaES.fieldbyname('esto_descricao').asstring;
    end else begin
//          EdEsto_codigo.Invalid('Codigo de barra não encontrado');
//          exit;
    end;
    codigobarra:=true;
//    EdQtde.Enabled:=false;
//    EdQtde.SetValue(1);
//    EdPerdesconto.enabled:=false;
    if acum then begin
      EdQtde.Enabled:=false;
      EdQtde.SetValue(1);
    end else begin
      EdQtde.SetValue(0);
      if not Qbuscaes.eof then begin
        QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdEsto_codigo.AsSql+
                           ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
        if not FGeral.TemEstoque(EdEsto_codigo.Text,EdQtde.AsFloat,EdUNid_codigo.Text,QEstoque) then begin
           EdEsto_codigo.INvalid('Quantidade em estoque insuficiente');
           exit;
        end;
      end;
    end;
    EdCodcor.enabled:=false;
    EdCodtamanho.enabled:=false;
//    EdCodcopa.enabled:=false;
    EdCodcor.text:='';
    EdCodtamanho.text:='';
//    EdCodcopa.text:='';
//    if QBusca.FieldByName('esto_grad_codigo').asinteger>0 then begin
    if QBuscaes.eof  then begin
      QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'''+
                       ' and esgr_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
                       ' and esgr_codbarra='+stringtosql(codbarra));
// 21.03.14 - Vivan - cadastra produto numa unidade e faz contagem em outra
/////////////////////////////////////////////////////////////////
      if QGrade.eof then begin
         QGrade.Close;
// procura o codigo em outras unidades..
          QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'''+
                       ' and '+FGeral.GetIN('esgr_unid_codigo',Global.Usuario.UnidadesMvto,'C')+
                       ' and esgr_codbarra='+stringtosql(codbarra));
          if not QGrade.eof then begin
            Sistema.Insert('Estgrades');
            Sistema.Setfield('esgr_status','N');
            Sistema.Setfield('esgr_esto_codigo',QGrade.fieldbyname('esgr_esto_codigo').asstring);
            Sistema.Setfield('esgr_unid_codigo',EdUnid_codigo.text);
            Sistema.Setfield('esgr_grad_codigo',0);
            Sistema.Setfield('esgr_qtde',0 );
            Sistema.Setfield('esgr_qtdeprev',0 );
            Sistema.Setfield('esgr_codbarra',copy(EdEsto_codigo.text,1,12));
            Sistema.Setfield('esgr_custo',QGrade.fieldbyname('esgr_custo').ascurrency);
            Sistema.Setfield('esgr_customedio',QGrade.fieldbyname('esgr_customedio').ascurrency);
            Sistema.Setfield('esgr_custoger',QGrade.fieldbyname('esgr_custoger').ascurrency);
            Sistema.Setfield('esgr_customeger',QGrade.fieldbyname('esgr_customeger').ascurrency);
            Sistema.Setfield('esgr_vendavis',FEstoque.GetPreco(QGrade.fieldbyname('esgr_esto_codigo').asstring,Global.Usuario.UnidadesMvto));
//            Sistema.Setfield('esgr_dtultvenda',emissao);
//            Sistema.Setfield('esgr_dtultcompra',emissao);
            Sistema.Setfield('esgr_usua_codigo',Global.Usuario.codigo);
            Sistema.Setfield('esgr_tama_codigo',QGrade.fieldbyname('esgr_tama_codigo').asinteger);
            Sistema.Setfield('esgr_core_codigo',QGrade.fieldbyname('esgr_core_codigo').asinteger);
            Sistema.Setfield('esgr_copa_codigo',QGrade.fieldbyname('esgr_copa_codigo').asinteger);
            Sistema.Setfield('esgr_custoser',QGrade.fieldbyname('esgr_custoser').ascurrency);
            Sistema.Setfield('esgr_customedioser',QGrade.fieldbyname('esgr_customedioser').ascurrency);
            Sistema.Post();
            Sistema.Commit;
          end;
          QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'''+
                            ' and esgr_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
                            ' and esgr_codbarra='+stringtosql(codbarra));
      end;
//////////////////
      if not QGrade.eof then begin
        EdEsto_codigo.Text:=QGrade.fieldbyname('esgr_esto_codigo').AsString;
        EdCodcor.setvalue(QGrade.fieldbyname('esgr_core_codigo').asinteger);
        EdCodcor.validfind;
        EdCodtamanho.setvalue(QGrade.fieldbyname('esgr_tama_codigo').asinteger);
        EdCodtamanho.validfind;
//        EdCodcopa.setvalue(QGrade.fieldbyname('esgr_copa_codigo').asinteger);
  //      EdCodcopa.validfind;
        FGeral.Fechaquery(QEstoque);
        QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdEsto_codigo.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
        QBuscaes.close;
        QBuscaes:=sqltoquery('select * from estoque where esto_codigo='+EdEsto_codigo.assql);
// 19.05.14
        if (acum) and (Global.Topicos[1038]) then begin
          if EdCodcor.IsEmpty then begin
            EdEsto_codigo.Invalid('Codigo da cor não encontrado');
            exit;
          end;
        end;
      end else begin
        EdEsto_codigo.Invalid('Codigo de barra da grade não encontrado');
        exit;
      end;
    end else begin
// 19.05.14
        if (acum) and (Global.Topicos[1038]) then begin
          if EdCodcor.IsEmpty then begin
            EdEsto_codigo.Invalid('Codigo da cor não encontrado');
            EdCodcor.Enabled:=true;
            EdCodcor.Empty:=false;
            EdCodtamanho.Enabled:=true;
            EdCodtamanho.Empty:=false;
            exit;
          end;
          if EdCodtamanho.IsEmpty then begin
            EdEsto_codigo.Invalid('Codigo do tamanho não encontrado');
            EdCodtamanho.Enabled:=true;
            EdCodtamanho.Empty:=false;
            EdCodcor.Enabled:=true;
            EdCodcor.Empty:=false;
            exit;
          end;
        end;
    end;

  end else if trim(EdEsto_codigo.text)<>'' then begin

    QBuscaes:=sqltoquery('select * from estoque where esto_Codigo='+EdEsto_codigo.assql);
//    QBusca:=sqltoquery('select * from estoque where esto_Codigo='+Stringtosql(xProduto));
    if not QBuscaes.Eof then begin
      EdEsto_codigo.Text:=QBuscaes.fieldbyname('esto_codigo').AsString;
      SetEdEsto_descricao.text:=QBuscaes.fieldbyname('esto_descricao').asstring;
    end else begin
      EdEsto_codigo.Invalid('Codigo não encontrado');
      exit;
    end;
    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdEsto_codigo.AsSql+
                       ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    if QEstoque.eof then begin
       EdEsto_codigo.INvalid('Codigo não encontrado no estoque da unidade '+EdUnid_codigo.text);
       exit;
    end;
// 20.05.13
    if not Arq.Testoque.active then Arq.Testoque.open;
    Arq.TEstoque.locate('esto_codigo',EdEsto_codigo.text,[]);
    EdCodcor.setvalue(0);
    EdCodtamanho.setvalue(0);
// 19.05.14
    if (Global.Topicos[1038]) then begin
            EdCodcor.Enabled:=true;
            EdCodcor.Empty:=false;
            EdCodtamanho.Enabled:=true;
            EdCodtamanho.Empty:=false;
    end;
//    EdCodcopa.setvalue(0);
    EdQtde.Enabled:=true;
    EdQtde.SetValue(0);

  end;


end;

procedure TFAcertos.EdQtdeExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////
var tipoMovimento,EntSai,sqlcor,sqltamanho,sqlcorM,sqltamanhoM:string;
//    QEstoque,QBusca,QGrade:TSqlquery;
    QBusca:TSqlquery;
    dif,difpecas,aqtde:currency;

   procedure gravaacertomestre;
   //////////////////////////////
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
   ///////////////////////////////
   var codigograde,codigocoluna,codigolinha:integer;
   begin
      codigograde:=FEstoque.GetCodigoGrade(EdESto_codigo.text);
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',EdESto_codigo.Text);
{
      codigolinha:=FEstoque.GetCodigoLinha(EdESto_codigo.Text,codigograde);
      codigocoluna:=FEstoque.GetCodigoColuna(EdESto_codigo.Text,codigograde);
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
      Sistema.SetField('move_qtde',abs(dif));
      Sistema.SetField('move_estoque',EdQtde.ascurrency);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',EdData.AsDate);
//      Sistema.SetField('move_qtderetorno',0);
//      Sistema.SetField('move_venda',Texttovalor(Grid.Cells[3,linha]));
      Sistema.SetField('move_grup_codigo',QBuscaes.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',QBuscaes.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',QBuscaes.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_pecas',abs(difpecas));
// 03.11.07
      Sistema.SetField('move_estoquepc',EdPecas.ascurrency);
// 24.04.08
      Sistema.SetField('move_core_codigo',EdCodcor.asinteger);
      Sistema.SetField('move_tama_codigo',EdCodtamanho.asinteger);

      Sistema.Post('');
   end;

// 30.01.13
   procedure AlteraAcertoDetalhe;
   ///////////////////////////////
   begin
      Sistema.Edit('Movestoque');
//      Sistema.SetField('move_esto_codigo',EdESto_codigo.Text);
//      Sistema.SetField('move_transacao',transacao);
//      Sistema.SetField('move_operacao',FGeral.GetOperacao);
//      Sistema.SetField('move_numerodoc',Ednumerodoc.AsInteger);
//      Sistema.SetField('move_status','N');
//      Sistema.SetField('move_tipomov',TipoMovimento);
//      Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
//      Sistema.SetField('move_tipo_codigo',EdUnid_codigo.text);
//      Sistema.SetField('move_tipocad','U');
//      Sistema.SetField('move_repr_codigo',Representante);
      Sistema.SetField('move_qtde',abs(dif));
      Sistema.SetField('move_estoque',EdQtde.ascurrency+aqtde);
//      Sistema.SetField('move_datalcto',Sistema.Hoje);
//      Sistema.SetField('move_datamvto',EdData.AsDate);
//      Sistema.SetField('move_qtderetorno',0);
//      Sistema.SetField('move_venda',Texttovalor(Grid.Cells[3,linha]));
//      Sistema.SetField('move_grup_codigo',QBuscaes.fieldbyname('esto_grup_codigo').AsInteger);
//      Sistema.SetField('move_sugr_codigo',QBuscaes.fieldbyname('esto_sugr_codigo').AsInteger);
//      Sistema.SetField('move_fami_codigo',QBuscaes.fieldbyname('esto_fami_codigo').AsInteger);
//      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
//      Sistema.SetField('move_pecas',abs(difpecas));
//      Sistema.SetField('move_core_codigo',EdCodcor.asinteger);
//      Sistema.SetField('move_tama_codigo',EdCodtamanho.asinteger);

      Sistema.Post('move_unid_codigo='+EdUnid_codigo.AsSql+' and move_status=''N'''+
                   ' and move_esto_codigo='+EdEsto_codigo.assql+sqltamanhoM+sqlcorM+
                   ' and move_tipomov = '+Stringtosql(QM.fieldbyname('move_tipomov').asstring)+
                   ' and move_numerodoc='+EdNumerodoc.assql+
                   ' and move_datamvto='+EdData.AsSql );

   end;



   procedure EditstoGrid;
   //////////////////////
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
        Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=QBuscaES.fieldbyname('esto_descricao').asstring;
        Grid.Cells[Grid.getcolumn('esto_referencia'),x]:=QBuscaES.fieldbyname('esto_referencia').asstring;
        Grid.Cells[Grid.getcolumn('move_estoquepc'),x]:=currtostr(abs(difpecas));
// 14.02.13
        if acum then begin
          Grid.Cells[Grid.getcolumn('move_estoque'),x]:=currtostr(EdQTde.AsCurrency );
          if dif>=0 then begin
//            Grid.Cells[Grid.getcolumn('move_qtde'),x]:=currtostr(abs(dif)) ;
            Grid.Cells[Grid.getcolumn('move_tipomov'),x]:=tiposaida; //Global.CodAcertoEsSai;
          end else begin
//            Grid.Cells[Grid.getcolumn('move_qtde'),x]:=currtostr(EdQTde.AsCurrency);
            Grid.Cells[Grid.getcolumn('move_tipomov'),x]:=tipoentrada;  //Global.CodAcertoEsEnt;
          end;
        end else begin
          Grid.Cells[Grid.getcolumn('move_estoque'),x]:=currtostr(abs(dif));
          if dif>=0 then begin
            Grid.Cells[Grid.getcolumn('move_qtde'),x]:=currtostr(EdQTde.AsCurrency);
            Grid.Cells[Grid.getcolumn('move_tipomov'),x]:=tiposaida; //Global.CodAcertoEsSai;
          end else begin
            Grid.Cells[Grid.getcolumn('move_qtde'),x]:=currtostr(EdQTde.AsCurrency);
            Grid.Cells[Grid.getcolumn('move_tipomov'),x]:=tipoentrada;  //Global.CodAcertoEsEnt;
          end;
        end;

        Grid.Cells[Grid.getcolumn('move_pecas'),x]:=currtostr(EdPecas.AsCurrency);
// 24.04.08
        Grid.Cells[Grid.getcolumn('move_core_codigo'),x]:=EdCodcor.assql;
        Grid.Cells[Grid.getcolumn('move_tama_codigo'),x]:=EdCodtamanho.assql;
        Grid.Cells[Grid.getcolumn('core_descricao'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
        Grid.Cells[Grid.getcolumn('tama_descricao'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);

      end else begin

        Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdEsto_codigo.Text;
        Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=QBuscaES.fieldbyname('esto_descricao').asstring;
        Grid.Cells[Grid.getcolumn('esto_referencia'),x]:=QBuscaES.fieldbyname('esto_referencia').asstring;
        Grid.Cells[Grid.getcolumn('move_estoquepc'),x]:=currtostr(abs(difpecas));
// 14.02.13
        if acum then begin
          Grid.Cells[Grid.getcolumn('move_estoque'),x]:=currtostr( Texttovalor(Grid.Cells[Grid.getcolumn('move_estoque'),x]) +EdQTde.AsCurrency );
{
          if dif>=0 then begin
            Grid.Cells[Grid.getcolumn('move_qtde'),x]:=currtostr( Texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x]) + abs(dif) );
          end else begin
            Grid.Cells[Grid.getcolumn('move_qtde'),x]:=currtostr( Texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x]) +  EdQTde.AsCurrency);
          end;
}
        end else begin
          Grid.Cells[Grid.getcolumn('move_estoque'),x]:=currtostr(abs(dif));
          if dif>=0 then begin
            Grid.Cells[Grid.getcolumn('move_qtde'),x]:=currtostr(EdQTde.AsCurrency);
            Grid.Cells[Grid.getcolumn('move_tipomov'),x]:=tiposaida;  //Global.CodAcertoEsSai;
          end else begin
            Grid.Cells[Grid.getcolumn('move_qtde'),x]:=currtostr(EdQTde.AsCurrency);
            Grid.Cells[Grid.getcolumn('move_tipomov'),x]:=tipoentrada;   // Global.CodAcertoEsEnt;
          end;
        end;
        Grid.Cells[Grid.getcolumn('move_pecas'),x]:=currtostr(EdPecas.AsCurrency);
// 24.04.08
        Grid.Cells[Grid.getcolumn('move_core_codigo'),x]:=EdCodcor.assql;
        Grid.Cells[Grid.getcolumn('move_tama_codigo'),x]:=EdCodtamanho.assql;
        Grid.Cells[Grid.getcolumn('core_descricao'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
        Grid.Cells[Grid.getcolumn('tama_descricao'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
      end;
      Grid.Refresh;
      Edtotalqtde.setvalue( EdTotalqtde.AsCurrency+EdQtde.ascurrency );
   end;

var Numerodoc:integer;
    codestoque:string;
    usougrade:boolean;

    procedure IncluiGrade;
    ///////////////////////
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

////////////////////////////////////////////////
begin

  if not acum then begin
    if not confirma('Confirma lançamento') then exit;
  end;

  QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdEsto_codigo.AsSql+
                ' and esqt_unid_codigo='+EdUnid_codigo.AsSql);
// 18.08.05
  if QEstoque.eof then begin
    Avisoerro('Codigo ainda não cadastrado nesta unidade');
    exit;
  end;
// 24.04.08
  usougrade:=(EdCodcor.AsInteger+EdCodtamanho.asinteger)>0;
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
  if (QGrade.eof) and (usougrade) then begin
    IncluiGrade;
    QGrade.close;
    QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(codestoque)+
                ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
  end;
/////////////////////
  if FGeral.QualQtde(Global.Usuario.Codigo,QEstoque.fieldbyname('esqt_qtde').Ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').Ascurrency) < 0 then begin
    dif:=abs(FGeral.QualQtde(Global.Usuario.Codigo,QEstoque.fieldbyname('esqt_qtde').Ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').Ascurrency))
       + EdQtde.AsCurrency;
    difpecas:=abs(QEstoque.fieldbyname('esqt_pecas').Ascurrency) + EdPecas.AsCurrency;
    EntSai:='E';
    TipoMovimento:=tipoentrada;   //Global.CodAcertoEsEnt;
  end else begin
    dif:=FGeral.QualQtde(Global.Usuario.Codigo,QEstoque.fieldbyname('esqt_qtde').Ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').Ascurrency)
       - EdQtde.AsCurrency;
    difpecas:=QEstoque.fieldbyname('esqt_pecas').Ascurrency - EdPecas.AsCurrency;
    if dif>=0 then begin
      EntSai:='S';
      TipoMovimento:=tiposaida;  // Global.CodAcertoEsSai;
    end else begin
      EntSai:='E';
      TipoMovimento:=tipoentrada; // Global.CodAcertoEsEnt;
    end;
  end;
  if EdNumerodoc.AsInteger>0 then begin
    Numerodoc:=FGeral.GetContador('ACERTO',false);
    QBusca:=sqltoquery('select * from movesto'+
          ' where moes_status=''N'' and '+FGeral.GetIn('moes_tipomov',tipos,'C')+
          ' and moes_numerodoc='+EdNumerodoc.AsSql+' and moes_datamvto='+EdData.AsSql+
          ' and moes_unid_codigo='+EdUnid_codigo.AsSql);
  end;

  if Acum then begin
    if EdCodcor.AsInteger>0 then
      sqlcorM:=' and move_core_codigo='+EdCodcor.assql
    else
      sqlcorM:=' and ( move_core_codigo=0 or move_core_codigo is null )';
    if EdCodtamanho.asinteger>0 then
      sqltamanhoM:=' and move_tama_codigo='+EdCodtamanho.assql
    else
      sqltamanhoM:=' and ( move_tama_codigo=0 or move_tama_codigo is null )';
    QM:=sqltoquery('select * from movestoque where move_status=''N'' and move_esto_codigo='+Stringtosql(codestoque)+
                   ' and move_unid_codigo='+EdUnid_codigo.AsSql+sqltamanhoM+sqlcorM+
                   ' and '+FGeral.GetIN('move_tipomov',Global.CodContagemBalancoE,'C')+
                   ' and move_numerodoc='+EdNumerodoc.assql+
                   ' and move_datamvto='+EdData.AsSql );
    if QM.eof then begin
      QM.close;
      QM:=sqltoquery('select * from movestoque where move_status=''N'' and move_esto_codigo='+Stringtosql(codestoque)+
                   ' and move_unid_codigo='+EdUnid_codigo.AsSql+sqltamanhoM+sqlcorM+
                   ' and '+FGeral.GetIN('move_tipomov',Global.CodContagemBalancoS,'C')+
                   ' and move_numerodoc='+EdNumerodoc.assql+
                   ' and move_datamvto='+EdData.AsSql );
    end;

  end;

  Sistema.BeginTransaction('Gravando acerto');
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

//  GravaAcertoDetalhe;
  if not Acum then begin
    if FGeral.QualQtde(Global.Usuario.Codigo,QEstoque.fieldbyname('esqt_qtde').Ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').Ascurrency) >= 0 then
      FGeral.MovimentaQtdeEstoque(EdEsto_codigo.Text,EdUnid_codigo.Text,EntSai,tipoentrada,abs(dif),QEstoque,0,abs(difpecas))
    else
      FGeral.MovimentaQtdeEstoque(EdEsto_codigo.Text,EdUnid_codigo.Text,EntSai,tipoentrada,EdQTde.ascurrency,QEstoque,0,EdPecas.ascurrency);
  end;
// 24.04.08
  if usougrade then begin
      if FGeral.QualQtde(Global.Usuario.Codigo,QGrade.fieldbyname('esgr_qtde').Ascurrency,QGrade.fieldbyname('esgr_qtdeprev').Ascurrency) < 0 then begin
        dif:=abs(FGeral.QualQtde(Global.Usuario.Codigo,QGrade.fieldbyname('esgr_qtde').Ascurrency,QGrade.fieldbyname('esgr_qtdeprev').Ascurrency))
           + EdQtde.AsCurrency;
        difpecas:=abs(QGrade.fieldbyname('esgr_pecas').Ascurrency) + EdPecas.AsCurrency;
        EntSai:='E';
        TipoMovimento:=tipoentrada;   //Global.CodAcertoEsEnt;
      end else begin
        dif:=FGeral.QualQtde(Global.Usuario.Codigo,QGrade.fieldbyname('esgr_qtde').Ascurrency,QGrade.fieldbyname('esgr_qtdeprev').Ascurrency)
           - EdQtde.AsCurrency;
        difpecas:=QGrade.fieldbyname('esgr_pecas').Ascurrency - EdPecas.AsCurrency;
        if dif>=0 then begin
          EntSai:='S';
          TipoMovimento:=tiposaida;  // Global.CodAcertoEsSai;
        end else begin
          EntSai:='E';
          TipoMovimento:=tipoentrada; // Global.CodAcertoEsEnt;
        end;
      end;
  end;

  if not acum then
    GravaAcertoDetalhe
  else begin
    if QM.eof then
       GravaAcertoDetalhe
    else begin
       aqtde:=QM.fieldbyname('move_estoque').ascurrency;
       AlteraAcertoDetalhe;
    end;
  end;

  FGeral.fechaquery(QGrade);
  QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(codestoque)+
                ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
  if not Acum then begin
    if usougrade then begin
      if FGeral.QualQtde(Global.Usuario.Codigo,QGrade.fieldbyname('esgr_qtde').Ascurrency,QGrade.fieldbyname('esgr_qtdeprev').Ascurrency) >= 0 then
        FGeral.MovimentaQtdeEstoqueGrade(codestoque,EdUnid_codigo.Text,EntSai,tipomovimento,Edcodcor.asinteger,Edcodtamanho.asinteger,0,abs(dif),QGrade,abs(dif),abs(difpecas))
      else
        FGeral.MovimentaQtdeEstoqueGrade(codestoque,EdUnid_codigo.Text,EntSai,tipomovimento,Edcodcor.asinteger,Edcodtamanho.asinteger,0,EdQtde.ascurrency,QGrade,EdQtde.ascurrency,Edpecas.ascurrency);
    end;
  end;
  Editstogrid;

  Sistema.EndTransaction('');
  QEstoque.close;
  Freeandnil(QEstoque);
  FGeral.fechaquery(QGrade);
  EdEsto_codigo.ClearAll(FAcertos,99);
  EdEsto_codigo.Setfocus;
end;

procedure TFAcertos.Edunid_codigoKeyPress(Sender: TObject; var Key: Char);
///////////////////////////////////////////////////////////////////////////
begin
  FGeral.Limpaedit(EdUnid_codigo,key);
end;

procedure TFAcertos.bExcluirClick(Sender: TObject);
var codestoque,tipomovimento,sqlcor,sqltamanho:string;
    qtdemov,pecas,estoque:currency;
    codcor,codtamanho:integer;
    Q,QGrade:Tsqlquery;
begin
  if PIns.Visible then exit;
//  if not EdUnid_codigo.ValidEdiAll(FAcertos,99) then exit;
///  if Grid.RowCount<2 then exit;
  codestoque:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
  if trim(codestoque)<>'' then begin
    qtdemov:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
// 15.02.13
    estoque:=texttovalor(Grid.Cells[Grid.getcolumn('move_estoque'),Grid.row]);
    pecas:=texttovalor( Grid.Cells[Grid.getcolumn('move_pecas'),Grid.row] );
    codcor:=strtointdef( Grid.Cells[Grid.getcolumn('move_core_codigo'),Grid.row] ,0);
    codtamanho:=strtointdef( Grid.Cells[Grid.getcolumn('move_tama_codigo'),Grid.row] ,0);
    if confirma('Confirma a exclusão e retorno da quantidade ao estoque ?') then begin
      Sistema.BeginTransaction('Eliminando acerto de estoque');
//      ExecuteSql('Update movesto set moes_status=''C'' where moes_status=''N'''+
//          ' and move_numerodoc='+EdNumerodoc.AsSql+
//          ' and '+FGeral.getin('moes_tipomov',Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai,'C')+
//          ' and moes_unid_codigo='+EdUnid_codigo.AsSql+
//          ' and moes_tipo_codigo='+EdUnid_codigo.AsSql+
//          ' and moes_datamvto='+EdDAta.AsSql );
      if trim(Grid.cells[Grid.getcolumn('move_core_codigo'),Grid.row])<>'' then
        sqlcor:=' and move_core_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_core_codigo'),Grid.row])
      else
        sqlcor:=' and ( move_core_codigo=0 or move_core_codigo is null )';
      if trim(Grid.cells[Grid.getcolumn('move_tama_codigo'),Grid.row])<>'' then
        sqltamanho:=' and move_tama_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_tama_codigo'),Grid.row])
      else
        sqltamanho:=' and ( move_tama_codigo=0 or move_tama_codigo is null )';
      ExecuteSql('Update movestoque set move_status=''C'' where move_status=''N'''+
          ' and move_numerodoc='+EdNumerodoc.AsSql+
          ' and '+FGeral.getin('move_tipomov',tipoentrada+';'+tiposaida,'C')+
          ' and move_unid_codigo='+EdUnid_codigo.AsSql+
          ' and move_tipo_codigo='+EdUnid_codigo.AsSql+
          ' and move_datamvto='+EdDAta.AsSql+
          ' and move_esto_codigo='+Stringtosql(codestoque)+
          sqlcor+sqltamanho );
      Q:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+Stringtosql(codestoque)+
                ' and esqt_unid_codigo='+EdUnid_codigo.AsSql);
//      if Grid.cells[4,grid.Row]=Global.CodAcertoEsSai then
      if Grid.cells[Grid.GetColumn('move_tipomov'),grid.Row]=tiposaida then
        tipomovimento:='E'   // inverte pois esta excluindo um acerto de estoque
      else
        tipomovimento:='S';
      FGeral.MovimentaQtdeEstoque(codestoque,EdUnid_codigo.Text,tipomovimento,tipoentrada,qtdemov,Q,0,pecas);
// 24.04.08
      sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
      sqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
      if (codcor>0) and (codtamanho>0) then begin
          sqlcor:=' and esgr_core_codigo='+inttostr(codcor);
          sqltamanho:=' and esgr_tama_codigo='+inttostr(codtamanho);
      end else if (codcor>0) then begin
          sqlcor:=' and esgr_core_codigo='+inttostr(codcor);
      end else if (codtamanho>0) then begin
          sqltamanho:=' and esgr_tama_codigo='+inttostr(codtamanho);
      end;
      QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(codestoque)+
                ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
      FGeral.MovimentaQtdeEstoqueGrade(codestoque,EdUnid_codigo.Text,tipomovimento,tipoentrada,codcor,codtamanho,0,qtdemov,QGrade,qtdemov,pecas);
// 15.02.13
      Edtotalqtde.text:=FGeral.Formatavalor( EdTotalqtde.AsCurrency-Estoque,f_cr );
      Grid.DeleteRow(grid.Row);
      FGeral.FechaQuery(Q);
      FGeral.FechaQuery(QGrade);
      Sistema.EndTransaction('');
    end;
  end;
end;

procedure TFAcertos.EdNumeroDocValidate(Sender: TObject);
begin
  if not EdNUmerodoc.isempty then begin
    Sistema.beginprocess('Checando acertos nesta data');
{
    Q:=sqltoquery('select movesto.*,movestoque.*,esto_descricao from movesto,movestoque,estoque'+
          ' where moes_status=''N'' and '+FGeral.GetIn('moes_tipomov',tipos,'C')+
          ' and moes_datamvto='+EdData.AsSql+' and moes_unid_codigo='+EdUnid_codigo.AsSql+
          ' and moes_numerodoc='+EdNUmerodoc.AsSql+
          ' and move_numerodoc='+EdNUmerodoc.AsSql+
          ' and move_datamvto='+EdData.AsSql+' and move_unid_codigo='+EdUnid_codigo.AsSql+
//          ' and moes_transacao=move_transacao and move_status=''N'''+
          ' and moes_numerodoc=move_numerodoc and move_status=''N'''+
          ' and esto_codigo=move_esto_codigo'+
          ' and '+FGeral.GetIn('move_tipomov',tipos,'C') );
}
// 15.02.13 - vivan
  Q:=sqltoquery('select sum(move_estoque) as contagem,sum(move_estoquepc) as contagempc from movestoque'+
          ' left join movesto on ( moes_numerodoc=move_numerodoc and moes_datamvto=move_datamvto and moes_unid_codigo=move_unid_codigo )'+
          ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
          ' where move_status=''N'' and '+FGeral.GetIn('move_tipomov',tipos,'C')+
          ' and moes_datamvto='+EdData.AsSql+' and moes_unid_codigo='+EdUnid_codigo.AsSql+
          ' and moes_numerodoc='+EdNUmerodoc.AsSql+
          ' and move_numerodoc='+EdNUmerodoc.AsSql+
          ' and move_datamvto='+EdData.AsSql+' and move_unid_codigo='+EdUnid_codigo.AsSql+
          ' and moes_numerodoc=move_numerodoc'+
          ' and '+FGeral.GetIn('move_tipomov',tipos,'C') );
  EdTotalQtde.text:=Fgeral.Formatavalor(Q.fieldbyname('contagem').ascurrency,f_cr);
// 24.04.08
  FGeral.FechaQuery(Q);
  Q:=sqltoquery('select * from movestoque'+
          ' left join movesto on ( moes_numerodoc=move_numerodoc and moes_datamvto=move_datamvto and moes_unid_codigo=move_unid_codigo )'+
          ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
          ' left join cores on ( core_codigo=move_core_codigo )'+
          ' left join tamanhos on ( tama_codigo=move_tama_codigo )'+
          ' left join copas on ( copa_codigo=move_copa_codigo )'+
          ' where move_status=''N'' and '+FGeral.GetIn('move_tipomov',tipos,'C')+
          ' and moes_datamvto='+EdData.AsSql+' and moes_unid_codigo='+EdUnid_codigo.AsSql+
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
end;

procedure TFAcertos.EdDataValidate(Sender: TObject);
begin
  if not FGeral.validamvto(EdData) then
    EdData.INvalid('');
end;

procedure TFAcertos.EdCodtamanhoValidate(Sender: TObject);
var p:integer;
begin
  p:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdESto_codigo.Text,Grid,Grid.GetColumn('move_tama_codigo'),Edcodtamanho.asinteger,
                        Grid.getcolumn('move_core_codigo'),EdCodcor.asinteger,Grid.getcolumn('move_copa_codigo'),EdCodcopa.asinteger);
  if p>0 then
    EdCodtamanho.Invalid('Já digitado nesta unidade neste dia');

end;

procedure TFAcertos.EdEsto_codigoKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then
    bcancelarclick(self)
  else
    FGeral.Limpaedit(EdEsto_codigo,key);

end;

procedure TFAcertos.batualizaestoqueClick(Sender: TObject);
//////////////////////////////////////////////////////////////
type TListaaZerar=record
     produto,unidade:string;
     codcor,codtamanho:integer;
end;

const xNumerodoc:integer=98998501;

var QE,QEstoque,QGrade:TSqlquery;
    ListaaZerar:TList;
    PListaaZerar:^TListaaZerar;
    dif,difpecas:currency;
    Entsai,TipoMovimento,sqlcor,sqltamanho,xtransacao:string;
    p:integer;
    achou:boolean;

begin
  if ( EdData.isempty ) or ( EdUNid_codigo.isempty ) or ( EdNumerodoc.isempty ) then exit;
  Qe:=sqltoquery('select * from movestoque'+
          ' left join movesto on ( moes_numerodoc=move_numerodoc and moes_datamvto=move_datamvto and moes_unid_codigo=move_unid_codigo )'+
          ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
          ' where move_status=''N'' and '+FGeral.GetIn('move_tipomov',tipos,'C')+
          ' and moes_datamvto='+EdData.AsSql+' and moes_unid_codigo='+EdUnid_codigo.AsSql+
          ' and moes_numerodoc='+EdNUmerodoc.AsSql+
          ' and move_numerodoc='+EdNUmerodoc.AsSql+
          ' and move_datamvto='+EdData.AsSql+' and move_unid_codigo='+EdUnid_codigo.AsSql+
          ' and moes_numerodoc=move_numerodoc'+
          ' and '+FGeral.GetIn('move_tipomov',tipos,'C') +
          ' order by move_esto_codigo' );
  if QE.eof then begin
    Avisoerro('Não encontrado nenhuma contagem com esta data ou numero');
    Qe.close;
    exit;
  end;
  if not confirma('Confirma atualização do estoque ?') then exit;
//  Sistema.beginprocess('Atualizando estoque com a contagem');
  ListaaZerar:=TList.create;
  xtransacao:=FGeral.GetTransacao;
//  Sistema.beginprocess('Zerando estoque da unidade');
  ExecuteSql('update estoqueqtde set esqt_qtde=0,esqt_qtdeprev=0 '+
                       ' where esqt_status=''N'''+
                       ' and esqt_unid_codigo='+EdUNid_codigo.assql);
  ExecuteSql('update estgrades set esgr_qtde=0,esgr_qtdeprev=0 '+
                       ' where esgr_status=''N'''+
                       ' and esgr_unid_codigo='+EdUNid_codigo.assql);

  while not qe.Eof do begin
    QEstoque:=sqltoquery('select * from estoqueqtde where esqt_status='+Stringtosql('N')+
                         ' and esqt_unid_codigo='+Stringtosql(Qe.fieldbyname('move_unid_codigo').asstring)+
                         ' and esqt_esto_codigo='+Stringtosql(Qe.fieldbyname('move_esto_codigo').asstring) );
    Sistema.beginprocess('Atualizando estoque com a contagem codigo '+Qe.fieldbyname('move_esto_codigo').asstring);
    New(PListaaZerar);
    PListaaZerar.produto:=Qe.fieldbyname('move_esto_codigo').asstring;
    PListaaZerar.unidade:=Qe.fieldbyname('move_unid_codigo').asstring;
    PListaaZerar.codcor:=Qe.fieldbyname('move_core_codigo').asinteger;
    PListaaZerar.codtamanho:=Qe.fieldbyname('move_tama_codigo').asinteger;
    ListaaZerar.Add(PListaaZerar);
// produto sem grade
///////////////////////
    if FGeral.QualQtde(Global.Usuario.Codigo,QEstoque.fieldbyname('esqt_qtde').Ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').Ascurrency) < 0 then begin
      dif:=abs(FGeral.QualQtde(Global.Usuario.Codigo,QEstoque.fieldbyname('esqt_qtde').Ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').Ascurrency))
           + Qe.fieldbyname('move_estoque').AsCurrency;
      difpecas:=abs(QEstoque.fieldbyname('esqt_pecas').Ascurrency) + EdPecas.AsCurrency;
      EntSai:='E';
      TipoMovimento:=tipoentrada;   //Global.CodAcertoEsEnt;
    end else begin
      dif:=FGeral.QualQtde(Global.Usuario.Codigo,QEstoque.fieldbyname('esqt_qtde').Ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').Ascurrency)
         - EdQtde.AsCurrency;
      difpecas:=QEstoque.fieldbyname('esqt_pecas').Ascurrency - Qe.fieldbyname('move_estoquepc').AsCurrency;
      if dif>=0 then begin
        EntSai:='S';
        TipoMovimento:=tiposaida;  // Global.CodAcertoEsSai;
      end else begin
        EntSai:='E';
        TipoMovimento:=tipoentrada; // Global.CodAcertoEsEnt;
      end;
    end;

    if FGeral.QualQtde(Global.Usuario.Codigo,QEstoque.fieldbyname('esqt_qtde').Ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').Ascurrency) >= 0 then
      FGeral.MovimentaQtdeEstoque(Qe.fieldbyname('move_esto_codigo').asstring,
                                  Qe.fieldbyname('move_unid_codigo').asstring,
                                  EntSai,tipoentrada,abs(dif),QEstoque,0,abs(difpecas))
    else
      FGeral.MovimentaQtdeEstoque(Qe.fieldbyname('move_esto_codigo').asstring,
                                  Qe.fieldbyname('move_unid_codigo').asstring,
                                  EntSai,tipoentrada,EdQTde.ascurrency,QEstoque,0,EdPecas.ascurrency);

/// grade do produto
//////////////////////////
    sqlcor:=' and esgr_core_codigo='+stringtosql(Qe.fieldbyname('move_core_codigo').asstring);
    sqltamanho:=' and esgr_tama_codigo='+stringtosql(Qe.fieldbyname('move_tama_codigo').asstring);
    QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'''+
                  ' and esgr_esto_codigo='+Stringtosql(Qe.fieldbyname('move_esto_codigo').asstring)+
                  ' and esgr_unid_codigo='+Stringtosql(Qe.fieldbyname('move_unid_codigo').asstring)+
                  sqltamanho+sqlcor);
    if FGeral.QualQtde(Global.Usuario.Codigo,QGrade.fieldbyname('esgr_qtde').Ascurrency,QGrade.fieldbyname('esgr_qtdeprev').Ascurrency) < 0 then begin
      dif:=abs(FGeral.QualQtde(Global.Usuario.Codigo,QGrade.fieldbyname('esgr_qtde').Ascurrency,QGrade.fieldbyname('esgr_qtdeprev').Ascurrency))
         + Qe.fieldbyname('move_estoque').AsCurrency;
      difpecas:=abs(QGrade.fieldbyname('esgr_pecas').Ascurrency) + Qe.fieldbyname('move_estoquepc').AsCurrency;
      EntSai:='E';
      TipoMovimento:=tipoentrada;   //Global.CodAcertoEsEnt;
    end else begin
      dif:=FGeral.QualQtde(Global.Usuario.Codigo,QGrade.fieldbyname('esgr_qtde').Ascurrency,QGrade.fieldbyname('esgr_qtdeprev').Ascurrency)
         - Qe.fieldbyname('move_estoque').AsCurrency;
      difpecas:=QGrade.fieldbyname('esgr_pecas').Ascurrency - Qe.fieldbyname('move_estoquepc').AsCurrency;
      if dif>=0 then begin
        EntSai:='S';
        TipoMovimento:=tiposaida;  // Global.CodAcertoEsSai;
      end else begin
        EntSai:='E';
        TipoMovimento:=tipoentrada; // Global.CodAcertoEsEnt;
      end;
    end;

    Sistema.edit('movestoque');
    Sistema.SetField('move_pecas',abs(difpecas));
    Sistema.SetField('move_qtde',abs(dif));
    Sistema.SetField('move_estoque',Qe.fieldbyname('move_estoque').AsCurrency);
    Sistema.SetField('move_estoquepc',Qe.fieldbyname('move_estoquepc').AsCurrency);
    Sistema.Post('move_operacao='+Stringtosql(Qe.fieldbyname('move_operacao').asstring));

    if FGeral.QualQtde(Global.Usuario.Codigo,QGrade.fieldbyname('esgr_qtde').Ascurrency,QGrade.fieldbyname('esgr_qtdeprev').Ascurrency) >= 0 then
      FGeral.MovimentaQtdeEstoqueGrade(Qe.fieldbyname('move_esto_codigo').AsString,
            Qe.fieldbyname('move_unid_codigo').AsString,EntSai,tipomovimento,
            Qe.fieldbyname('move_core_codigo').AsInteger,
            Qe.fieldbyname('move_tama_codigo').AsInteger,0,
            abs(dif),QGrade,abs(dif),abs(difpecas))
    else
      FGeral.MovimentaQtdeEstoqueGrade(Qe.fieldbyname('move_esto_codigo').AsString,
            Qe.fieldbyname('move_unid_codigo').AsString,EntSai,tipomovimento,
            Qe.fieldbyname('move_core_codigo').AsInteger,
            Qe.fieldbyname('move_tama_codigo').AsInteger,0,
            Qe.fieldbyname('move_estoque').Ascurrency,QGrade,
            Qe.fieldbyname('move_estoque').Ascurrency,
            Qe.fieldbyname('move_estoquePC').Ascurrency);
    Qe.Next;
    QGrade.close;
  end;

  SISTEMA.Commit;
////////////////////////////////

  Sistema.beginprocess('Eliminando zeramento anterior');
  ExecuteSql('update movestoque set move_status=''C'' where move_numerodoc='+inttostr(xNumerodoc)+
             ' and move_datamvto='+EdData.AsSql+
             ' and move_status=''N'''+
             ' and move_unid_codigo='+EdUnid_codigo.AsSql);
  ExecuteSql('update movesto set moes_status=''C'' where moes_numerodoc='+inttostr(xNumerodoc)+
             ' and moes_datamvto='+EdData.AsSql+
             ' and moes_status=''N'''+
             ' and moes_unid_codigo='+EdUnid_codigo.AsSql);

  Sistema.beginprocess('Zerando o estoque dos produtos Não Contados');

// 01.02.13 - por enquanto somente com grade - 15.02.13 vivan financeiro pediu pra zerar tbem
////////////////////////////////////////////////////////////////////////////////////////////////
  QEstoque.close;
  QEstoque:=Sqltoquery('select *,esto_grup_codigo,esto_sugr_codigo,esto_fami_codigo from estoqueqtde'+
                       ' inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                       ' where esqt_status=''N'''+
                       ' and esqt_unid_codigo='+EdUNid_codigo.assql+
                       ' order by esqt_esto_codigo');
  while not QEstoque.Eof do begin
    achou:=false;
    for p:=0 to ListaaZerar.Count-1 do begin
      PListaaZerar:=ListaaZerar[p];
      if (PListaaZerar.produto=QEstoque.fieldbyname('esqt_esto_codigo').asstring)
         and ( PListaaZerar.codcor=0 ) and ( PListaaZerar.codtamanho=0 ) then begin
         achou:=true;
         break;
      end;
    end;
    if not achou then begin
      Sistema.beginprocess('Zerando o estoque dos produtos Não Contados Codigo '+QEstoque.fieldbyname('esqt_esto_codigo').asstring);
{
      Sistema.Edit('estoqueqtde');
      Sistema.setfield('esqt_qtde',0);
      Sistema.setfield('esqt_qtdeprev',0);
      Sistema.Post('esqt_status=''N'''+
                   ' and esqt_esto_codigo='+Stringtosql(QEstoque.fieldbyname('esqt_esto_codigo').asstring)+
                   ' and esqt_unid_codigo='+Stringtosql(PListaaZerar.unidade) );
}
///////////////////
// 07.04.14
      Sistema.Insert('movestoque');
      Sistema.setfield('move_transacao',xtransacao);
      Sistema.setfield('move_operacao',FGeral.GetOperacao);
      Sistema.setfield('move_esto_codigo',QEstoque.fieldbyname('esqt_esto_codigo').asstring);
      Sistema.setfield('move_unid_codigo',QEstoque.fieldbyname('esqt_unid_codigo').asstring);
      Sistema.setfield('move_status','N');
      Sistema.setfield('move_datamvto',EdData.AsDate);
      Sistema.setfield('move_datacont',EdData.AsDate);
      Sistema.setfield('move_datalcto',EdData.AsDate);
      Sistema.SetField('move_tipomov',Global.CodContagemBalancoE);
      Sistema.SetField('move_numerodoc',(xNumerodoc));
      Sistema.SetField('move_pecas',QEstoque.fieldbyname('esqt_pecas').ascurrency);
      Sistema.SetField('move_qtde',abs(QEstoque.fieldbyname('esqt_qtde').ascurrency));
      Sistema.SetField('move_estoque',0);
      Sistema.SetField('move_estoquepc',0);
      Sistema.SetField('move_custo',QEstoque.fieldbyname('esqt_custo').ascurrency);
      Sistema.SetField('move_custoger',QEstoque.fieldbyname('esqt_custoger').ascurrency);
      Sistema.SetField('move_customedio',QEstoque.fieldbyname('esqt_customedio').ascurrency);
      Sistema.SetField('move_customeger',QEstoque.fieldbyname('esqt_customeger').ascurrency);
      Sistema.SetField('move_venda',QEstoque.fieldbyname('esqt_vendavis').ascurrency);
      Sistema.SetField('move_grup_codigo',QEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',QEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',QEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.Codigo);
      Sistema.Post('');
///////////////////

////////////////      Sistema.Commit;

    end;
    QEstoque.Next;
  end;
// criar um mestre a parte
// 07.04.14
      Sistema.Insert('movesto');
      Sistema.setfield('moes_transacao',xtransacao);
      Sistema.setfield('moes_operacao',FGeral.GetOperacao);
      Sistema.setfield('moes_unid_codigo',EdUnid_codigo.text);
      Sistema.setfield('moes_status','N');
      Sistema.setfield('moes_datamvto',EdData.AsDate);
      Sistema.setfield('moes_datacont',EdData.AsDate);
      Sistema.setfield('moes_datalcto',EdData.AsDate);
      Sistema.setfield('moes_dataemissao',EdData.AsDate);
      Sistema.SetField('moes_tipomov',Global.CodContagemBalancoE);
      Sistema.SetField('moes_numerodoc',(xNumerodoc));
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.Post('');

//////////////////      Sistema.Commit;

///////////////////

///////////////////////////

  QEstoque.close;
  QEstoque:=Sqltoquery('select *,esto_grup_codigo,esto_sugr_codigo,esto_fami_codigo from estgrades'+
                       ' inner join estoque on ( esgr_esto_codigo=esto_codigo )'+
                       ' where esgr_status=''N'''+
                       ' and esgr_unid_codigo='+EdUnid_codigo.assql+
                       ' order by esgr_esto_codigo');
  while not QEstoque.Eof do begin
    achou:=false;
    for p:=0 to ListaaZerar.Count-1 do begin
      PListaaZerar:=ListaaZerar[p];
      if (PListaaZerar.produto=QEstoque.fieldbyname('esgr_esto_codigo').asstring)
         and ( (PListaaZerar.codcor=QEstoque.fieldbyname('esgr_core_codigo').asinteger) and (PListaaZerar.codcor>0)  )
         and ( (PListaaZerar.codtamanho=QEstoque.fieldbyname('esgr_tama_codigo').asinteger ) and (PListaaZerar.codtamanho>0) ) then begin
         achou:=true;
         break;
      end;
    end;
    if QEstoque.fieldbyname('esgr_core_codigo').asinteger>0 then
      sqlcor:=' and esgr_core_codigo='+inttostr(QEstoque.fieldbyname('esgr_core_codigo').asinteger)
    else
      sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
    if QEstoque.fieldbyname('esgr_tama_codigo').asinteger>0 then
      sqltamanho:=' and esgr_tama_codigo='+inttostr(QEstoque.fieldbyname('esgr_tama_codigo').asinteger)
    else
      sqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
    if not achou then begin
      Sistema.beginprocess('Zerando o estoque dos produtos Não Contados codigo '+QEstoque.fieldbyname('esgr_esto_codigo').asstring);
      {
      Sistema.Edit('estgrades');
      Sistema.setfield('esgr_qtde',0);
      Sistema.setfield('esgr_qtdeprev',0);
      Sistema.Post('esgr_status=''N'''+
                   ' and esgr_esto_codigo='+Stringtosql(QEstoque.fieldbyname('esgr_esto_codigo').asstring)+
                   ' and esgr_unid_codigo='+Stringtosql(PListaaZerar.unidade)+
                   sqlcor+sqltamanho );
                   }
///////////////////
// 07.04.14
      Sistema.Insert('movestoque');
      Sistema.setfield('move_transacao',xtransacao);
      Sistema.setfield('move_operacao',FGeral.GetOperacao);
      Sistema.setfield('move_esto_codigo',QEstoque.fieldbyname('esgr_esto_codigo').asstring);
      Sistema.setfield('move_tama_codigo',QEstoque.fieldbyname('esgr_tama_codigo').asstring);
      Sistema.setfield('move_core_codigo',QEstoque.fieldbyname('esgr_core_codigo').asstring);
      Sistema.setfield('move_unid_codigo',QEstoque.fieldbyname('esgr_unid_codigo').asstring);
      Sistema.setfield('move_status','N');
      Sistema.setfield('move_datamvto',EdData.AsDate);
      Sistema.setfield('move_datacont',EdData.AsDate);
      Sistema.setfield('move_datalcto',EdData.AsDate);
      Sistema.SetField('move_tipomov',Global.CodContagemBalancoE);
      Sistema.SetField('move_numerodoc',(xNumerodoc));
      Sistema.SetField('move_pecas',QEstoque.fieldbyname('esgr_pecas').ascurrency);
      Sistema.SetField('move_qtde',abs(QEstoque.fieldbyname('esgr_qtde').ascurrency));
      Sistema.SetField('move_estoque',0);
      Sistema.SetField('move_estoquepc',0);
      Sistema.SetField('move_custo',QEstoque.fieldbyname('esgr_custo').ascurrency);
      Sistema.SetField('move_custoger',QEstoque.fieldbyname('esgr_custoger').ascurrency);
      Sistema.SetField('move_customedio',QEstoque.fieldbyname('esgr_customedio').ascurrency);
      Sistema.SetField('move_customeger',QEstoque.fieldbyname('esgr_customeger').ascurrency);
      Sistema.SetField('move_venda',QEstoque.fieldbyname('esgr_vendavis').ascurrency);
      Sistema.SetField('move_grup_codigo',QEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',QEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',QEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.Codigo);
      Sistema.Post('');
///////////////////
    end;
    QEstoque.Next;
  end;

  Sistema.beginprocess('Finalizando e Gravando');
  try
    Sistema.commit;
    Sistema.endprocess('Atualização terminada');
  except
    Sistema.endprocess('Não foi possível gravar.  Checar');
  end;
  ListaaZerar.free;
  FGeral.FechaQuery(QGrade);
  FGeral.FechaQuery(QE);
  FGeral.FechaQuery(QEstoque);


end;

procedure TFAcertos.EdNumeroDocExitEdit(Sender: TObject);
begin
   bincluirclick(self);
end;

end.
