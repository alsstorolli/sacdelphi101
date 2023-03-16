{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit configdemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, SimpleDS, SqlSis, Grids, DBGrids, SQLGrid,
  StdCtrls, Mask, SQLEd, ExtCtrls, Buttons, SQLBtn, alabel;

type
  TFConfigDemo = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bAlterar: TSQLBtn;
    bExcluir: TSQLBtn;
    bCancelar: TSQLBtn;
    bOrdenar: TSQLBtn;
    bPesquisar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    PEdits: TSQLPanelGrid;
    EdRelcodigo: TSQLEd;
    EdReltipos: TSQLEd;
    EdReltipo: TSQLEd;
    Grid: TSQLGrid;
    DSCadastro: TDataSource;
    PNomerel: TSQLPanelGrid;
    TConfigRel: TSQLDs;
    EdNomeRel: TSQLEd;
    Edtitulorel: TSQLEd;
    Edrelordem: TSQLEd;
    EdReltitulocol: TSQLEd;
    EdReles: TSQLEd;
    EdUsua_codigo: TSQLEd;
    EdUnid_codigo: TSQLEd;
    EdRelStatus: TSQLEd;
    EdRelsinal: TSQLEd;
    brel: TSQLBtn;
    procedure bIncluirClick(Sender: TObject);
    procedure EdNomeRelValidate(Sender: TObject);
    procedure EdReltipoValidate(Sender: TObject);
    procedure EdReltiposValidate(Sender: TObject);
    procedure EdRelesExitEdit(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure bAlterarClick(Sender: TObject);
    procedure EdrelordemValidate(Sender: TObject);
    procedure brelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure GetProximo( Ed:TSqled ; campo:string );
    procedure ConfiguraEdit( tipoc:string ; Ed:TSqled );
    function GetDescricaoItem(tipoc:string ; codigo:string ):string;
    procedure SetaItemsOrdem(Ed:TSqled);
  end;

var
  FConfigDemo: TFConfigDemo;
  OP,UNidade:string;

implementation

{$R *.dfm}

uses Geral, SqlExpr, SqlFun, plano, Estoque, grupos, Subgrupos, Relfinan;

{ TFConfigDemo }

procedure TFConfigDemo.Execute;
//////////////////////////////////
var Q:TSqlquery;
begin
   if Tconfigrel.Active then TConfigrel.Close;
   Unidade:=Global.CodigoUnidade;
   Show;
   Q:=sqltoquery('select distinct Relg_NomeRel from relgerencial where Relg_Unid_codigo='+Stringtosql(unidade)+
                 ' and relg_status=''N''');
   EdNomeRel.ClearAll(FConfigDemo,99);
   EdNomerel.Items.Clear;
   while not Q.eof do begin
     EdNomerel.Items.Add(Q.fieldbyname('relg_nomerel').asstring);
     q.Next;
   end;
   fgeral.FechaQuery(Q);
   EdNomerel.SetFocus;
end;

procedure TFConfigDemo.bIncluirClick(Sender: TObject);
////////////////////////////////////////////////////////
begin
  if ( EdNomerel.IsEmpty ) or ( Edtitulorel.isempty ) then exit;
  OP:='I';
  Grid.Insert(EdRelOrdem);
  GetProximo( EdRelCodigo,'relg_codigo' );
  GetProximo( EdRelOrdem,'relg_ordem' );
end;

procedure TFConfigDemo.EdNomeRelValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
var condicao,ordem:string;
begin
  condicao:='relg_nomerel='+EdNomerel.AsSql+' and relg_status=''N'''+
            ' and relg_unid_codigo='+Stringtosql(Unidade);
  ordem:='relg_ordem';
  Tconfigrel.Condicao:=condicao;
  TConfigrel.OpenWith(condicao,ordem);
  if not Tconfigrel.Eof then
    Edtitulorel.text:=TConfigrel.fieldbyname('relg_titulorel').asstring
  else
    Edtitulorel.text:='';

end;

procedure TFConfigDemo.GetProximo(Ed: TSqled; campo: string);
/////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    maior:integer;
begin
  Q:=Sqltoquery('select ('+campo+') as maximo from relgerencial where relg_nomerel='+EdNomerel.AsSql+
                ' and relg_status=''N'''+
                ' and relg_unid_codigo='+Stringtosql(Unidade) );

  if Q.eof then
    Ed.Text:='1'
  else begin
    maior:=1;
    while not Q.eof do begin
      if strtoint(Q.fieldbyname('maximo').asstring) > maior then
        maior:=strtoint(Q.fieldbyname('maximo').asstring);
      Q.Next;
    end;
    Ed.Text:=inttostr( maior + 10);
  end;
  Q.close;
end;

procedure TFConfigDemo.EdReltipoValidate(Sender: TObject);
/////////////////////////////////////////////////////////
begin
  ConfiguraEdit(Edreltipo.text,EdRelTipos);
end;

procedure TFConfigDemo.ConfiguraEdit(tipoc: string; Ed: TSqled);
/////////////////////////////////////////////////////////
begin
  Ed.Items.Clear;
  Ed.enabled:=true;
  if tipoc='C' then begin
    Ed.ItemsLength:=5;
    FPlano.SetaItems(Ed,nil,'M','','')
  end else if tipoc='P' then begin
    Ed.ItemsLength:=07;  // pra ficar de acordo com setaitens em FEstoque
    FEstoque.SetaItems(Ed,nil,'','')
  end else if tipoc='G' then begin
    Ed.ItemsLength:=06;
    FGrupos.SetaItems(Ed,nil,'','')
  end else if tipoc='S' then begin
    Ed.ItemsLength:=04;
    FSubGrupos.SetaItems(Ed,nil,'','')
  end else if tipoc='M' then begin
    Ed.ItemsLength:=04;
    SetaItemsOrdem(Ed)
  end else if tipoc='I' then begin
    Ed.enabled:=false;
  end else if tipoc='F' then begin
    Ed.enabled:=false;
  end else begin
    Ed.ItemsLength:=02;
    FGeral.SetaItemsMovimento(Ed);
  end;
end;

procedure TFConfigDemo.EdReltiposValidate(Sender: TObject);
//////////////////////////////////////////////////////////
var Lista:TStringList;
begin
  Lista:=TStringList.Create;
  Strtolista(Lista,EdReltipos.text,';',true);
  if pos(OP,'I;F')>0 then begin
    if Lista.count=1 then EdRelTitulocol.text:=GetDescricaoItem(EdReltipo.text,Lista[0])
  end;
end;

function TFConfigDemo.GetDescricaoItem(tipoc, codigo: string): string;
/////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
begin
  result:='';
  if tipoc='C' then begin
    Q:=Sqltoquery('select plan_descricao from plano where plan_conta='+codigo);
    if not Q.eof then
      result:=Q.fieldbyname('plan_descricao').asstring;
    Q.Close;
  end else if tipoc='P' then begin
    Q:=Sqltoquery('select esto_descricao from estoque where esto_codigo='+Stringtosql(codigo));
    if not Q.eof then
      result:=Q.fieldbyname('esto_descricao').asstring;
    Q.Close;
  end else if tipoc='G' then begin
    Q:=Sqltoquery('select grup_descricao from grupos where grup_codigo='+codigo);
    if not Q.eof then
      result:=Q.fieldbyname('grup_descricao').asstring;
    Q.Close;
  end else if tipoc='S' then begin
    Q:=Sqltoquery('select sugr_descricao from subgrupos where sugr_codigo='+codigo);
    if not Q.eof then
      result:=Q.fieldbyname('sugr_descricao').asstring;
    Q.Close;
  end else if tipoc='T' then begin
    result:=FGeral.GetTipoMovto(codigo)
  end;
end;

procedure TFConfigDemo.EdRelesExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////
begin
   Edusua_codigo.SetValue(Global.Usuario.Codigo);
   EdUnid_codigo.text:=unidade;
   EdRelStatus.text:='N';
   if OP='I' then begin
     Grid.PostInsert(EdRelOrdem);
     TConfigrel.Refresh;
     GetProximo( EdRelCodigo,'relg_codigo' );
     GetProximo( EdRelOrdem,'relg_ordem' );
   end else begin
    {
     TConfigrel.Edit;
     TConfigrel.SetFields(FConfigDemo,99);
     TConfigrel.Post;
     TConfigrel.Commit;
     PEdits.Visible:=false;
     Grid.setfocus;
     }
   end;
end;

procedure TFConfigDemo.GridNewRecord(Sender: TObject);
//////////////////////////////////////////////////////////////
begin
  if not TConfigRel.IsEmpty then TConfigRel.GetFields(Self,0);

end;

procedure TFConfigDemo.bAlterarClick(Sender: TObject);
begin
  Op:='A';
///////////////////  Grid.Cancel;
//  PEdits.Visible:=true;
///  PEdits.EnableEdits;
//////////////////  EdEsto_codigo.SetStatusEdits(Self,99,seEditall);
//  EdRelOrdem.GetFields(FConfigDemo,99);
//  EdRelOrdem.setfocus;

end;

procedure TFConfigDemo.EdrelordemValidate(Sender: TObject);
begin
   if TConfigrel.Locate('relg_ordem',EdRelOrdem.text,[]) then
     EdRelOrdem.Invalid('Ordem já existente neste relatório');
end;

procedure TFConfigDemo.brelClick(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_DRE(EdNomeRel.text);

end;

procedure TFConfigDemo.SetaItemsOrdem(Ed: TSqled);
var Q:TSqlQuery;
begin
    Q:=sqltoquery('select * from relgerencial where Relg_Unid_codigo='+Stringtosql(Global.codigounidade)+
                  ' and relg_nomerel='+EdNomerel.AsSql+
                  ' and relg_status=''N'''+
                  ' order by relg_ordem');
    Ed.Items.Clear;
    while not Q.Eof do begin
      Ed.Items.Add(Q.fieldbyname('relg_ordem').asstring);
      Q.Next;
    end;
    FGeral.FechaQuery(Q);

end;

end.
