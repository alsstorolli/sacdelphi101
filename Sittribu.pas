unit Sittribu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel, SqlSis;

type
  TFSittributaria = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bAlterar: TSQLBtn;
    bExcluir: TSQLBtn;
    bCancelar: TSQLBtn;
    bFiltrar: TSQLBtn;
    bOrdenar: TSQLBtn;
    bPesquisar: TSQLBtn;
    bRelatorio: TSQLBtn;
    bSair: TSQLBtn;
    bExpColumn: TSQLBtn;
    Bevel1: TBevel;
    bRedColumn: TSQLBtn;
    bMoveLeft: TSQLBtn;
    bMoveRight: TSQLBtn;
    bDelColumn: TSQLBtn;
    bRestColumn: TSQLBtn;
    bLoadGrid: TSQLBtn;
    bSaveGrid: TSQLBtn;
    bRestaurar: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    PEdits: TSQLPanelGrid;
    Grid: TSQLGrid;
    DSCadastro: TDataSource;
    EdSITT_CODIGO: TSQLEd;
    EdSITT_DESCRICAO: TSQLEd;
    EdSITT_CST: TSQLEd;
    EdSITT_CF: TSQLEd;
    EdSITT_USUA_CODIGO: TSQLEd;
    EdSitt_Natf_codigo: TSQLEd;
    EdNatf_descricao: TSQLEd;
    EdSITT_ES: TSQLEd;
    Edsitt_natf_codigofe: TSQLEd;
    SetEdnatf_descricao: TSQLEd;
    Edsitt_cstme: TSQLEd;
    EdSITT_CSTPIS: TSQLEd;
    EdSITT_CSTCOFINS: TSQLEd;
    EdSITT_Cbenef: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure EdSITT_CFExitEdit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure EdSITT_CSTValidate(Sender: TObject);
  private
    { Private declarations }
    Itemscodfiscal:TStringList;
  public
    { Public declarations }
    procedure SetaItemsCodFiscal(Edit:TsqlEd);
    function GetCST(codigo:integer ; Simples:string='N'):string;
    function GetCodCst(unidade:string):integer;
    function ValidaCodCst(unidade:string ; codcst:integer):boolean;
// 21.03.07
    function CSTtoCF(cst:string ; xCodigoUnidade:string='' ; xes:string=''):string;
// 15.04.08
    function GetCodigoCst(cst:string;xes:string=''):string;
// 08.09.10
//    function GetCfop(cst,natf:string):string;
    function GetCfop(codigocst:integer;natf,xtipomov:string):string;
// 13.09.10
    function ValidaCst:boolean;
    function Comparastringnula(Ed:TSqlEd):string;
    procedure SetaCstPis(Ed:TSqled);
    procedure SetaCstCofins(Ed:TSqled);
// 29.12.19
   function GetcbenefporCST( cst,xes : string):string;
   function Getcbenef( codigo:integer):string;
// 08.11.2022
   function GetCF(codigo:integer):string;
  end;

var
  FSittributaria: TFSittributaria;
  campo,
  campopis,
  campocbenef :TDicionario;

implementation

{$R *.dfm}

uses Geral, Arquiv, Sqlfun , SQLRel, Sqlexpr, Unidades;

procedure TFSittributaria.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdSitt_codigo);

end;

procedure TFSittributaria.EdSITT_CFExitEdit(Sender: TObject);
begin
   if ValidaCst then begin
     EdSitt_usua_codigo.SetValue(Global.Usuario.Codigo);
     Grid.PostInsert(EdSitt_codigo);
   end else
     EdSitt_cf.Invalid('');
end;

procedure TFSittributaria.FormActivate(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
  if not Arq.TSittributaria.Active then Arq.TSittributaria.Open;
  Fgeral.ColunasGrid(Grid,Self);
  SetaItemsCodFiscal(EdSitt_CF);
  SetaCstPis(EdSitt_cstpis);
  SetaCstCofins(EdSitt_cstcofins);
  campo       :=Sistema.GetDicionario('sittrib','sitt_natf_codigo');
  campopis   :=Sistema.GetDicionario('sittrib','sitt_cstpis');
  campocbenef:=Sistema.GetDicionario('sittrib','sitt_cbenef');
  if campo.Tipo<>'' then begin
    FSittributaria.EdSitt_natf_codigo.enabled:=true;
    FSittributaria.EdSitt_natf_codigo.Group:=0;
    FSittributaria.EdSitt_natf_codigofe.enabled:=true;
    FSittributaria.EdSitt_natf_codigofe.Group:=0;
    FSittributaria.Edsitt_cstme.enabled:=true;
    FSittributaria.EdSitt_cstme.Group:=0;
  end else begin
    FSittributaria.EdSitt_natf_codigo.enabled:=false;
    FSittributaria.EdSitt_natf_codigo.Group:=99;
    FSittributaria.EdSitt_natf_codigofe.enabled:=false;
    FSittributaria.EdSitt_natf_codigofe.Group:=99;
    FSittributaria.Edsitt_cstme.enabled:=false;
    FSittributaria.EdSitt_cstme.Group:=99;
  end;
// 14.10.11
  if campopis.Tipo<>'' then begin
    FSittributaria.EdSitt_cstpis.enabled:=true;
    FSittributaria.EdSitt_cstpis.Group:=0;
    FSittributaria.EdSitt_cstcofins.enabled:=true;
    FSittributaria.EdSitt_cstcofins.Group:=0;
    FSittributaria.EdSitt_cstpis.TableName:='sittrib';
    FSittributaria.EdSitt_cstcofins.TableName:='sittrib';
  end else begin
    FSittributaria.EdSitt_cstpis.enabled:=false;
    FSittributaria.EdSitt_cstpis.Group:=24;
    FSittributaria.EdSitt_cstcofins.enabled:=false;
    FSittributaria.EdSitt_cstcofins.Group:=24;
    FSittributaria.EdSitt_cstpis.TableName:='';
    FSittributaria.EdSitt_cstcofins.TableName:='';
  end;
// 02.08.19
  if campocbenef.Tipo<>'' then begin
    FSittributaria.EdSitt_cbenef.enabled:=true;
    FSittributaria.EdSitt_cbenef.Group:=0;
    FSittributaria.EdSitt_cbenef.TableName:='sittrib';
  end else begin
    FSittributaria.EdSitt_cbenef.enabled:=false;
    FSittributaria.EdSitt_cbenef.Group:=24;
    FSittributaria.EdSitt_cbenef.TableName:='';
  end;


end;

procedure TFSittributaria.bRelatorioClick(Sender: TObject);
begin
//    Grid.Report('CadSittrib','Rela��o de Situa��es Tribut�rias','','');
    FRel.Reportfromsql('select * from sittrib','CadSittrib','Rela��o de Situa��es Tribut�rias');
end;


procedure TFSittributaria.SetaItemsCodFiscal(Edit:TsqlEd);
begin
  Edit.ItemsLength:=1;
  Edit.Items.Assign(ItemsCodFiscal);
end;

procedure TFSittributaria.FormCreate(Sender: TObject);
begin
  ItemsCodFiscal:=TStringList.Create;
  ItemsCodFiscal.Add('1 - Tributado');
  ItemsCodFiscal.Add('2 - Isento / N�o Tributado');
  ItemsCodFiscal.Add('3 - Diferido');
  ItemsCodFiscal.Add('4 - Substitui��o Tribut�ria');
  ItemsCodFiscal.Add('5 - Outras');
end;

function TFSittributaria.GetCST(codigo: integer  ; Simples:string='N'): string;
var Q:TSqlquery;
begin
{
  if not Arq.TSittributaria.Active then Arq.TSittributaria.Open;
  if Arq.TSittributaria.locate('sitt_codigo',inttostr(codigo),[]) then
    result:=Arq.TSittributaria.fieldbyname('sitt_cst').asstring;
}
  Q:=sqltoquery('select sitt_cst,sitt_cstme from sittrib where sitt_codigo='+inttostr(codigo));
  if not Q.eof then begin
    if pos(simples,'S;2')>0 then
      result:=Q.fieldbyname('sitt_cstme').asstring
    else
      result:=Q.fieldbyname('sitt_cst').asstring
  end else
    result:='   ';
  FGeral.fechaquery(Q);
end;

procedure TFSittributaria.bExcluirClick(Sender: TObject);
var Cod:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,Msg:String):Boolean;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM '+Tabela+' WHERE '+Campo+'='+Cod);
      Result:=Q.FieldByName('Registros').AsInteger>0;
      if Result then AvisoErro('Encontrado lan�amentos com a unidade escolhida na tabela: '+Msg);
      Q.Close;Q.Free;
    end;


begin
  Cod:=StringToSql(Arq.TSittributaria.FieldByName('Sitt_Codigo').AsString);
  Found:=FoundTabela('Estoqueqtde','esqt_sitt_codestado','Estoque por unidade');
  Found:=FoundTabela('Estoqueqtde','esqt_sitt_forestado','Estoque por unidade');
//  if not Found then Found:=FoundTabela('MovGer','Mger_Unid_Codigo','Movimento Gerencial');
  if not Found then Grid.Delete;
end;


function TFSittributaria.GetCodCst(unidade: string): integer;
begin
  if pos(unidade,Global.Unidadecuritiba+';'+Global.unidadebeltrao)>0 then
    result:=3   // no cadastro � o CST '000
  else
    result:=0;
end;

function TFSittributaria.ValidaCodCst(unidade: string ; codcst:integer): boolean;
begin
//  if ( pos(unidade,Global.Unidadecuritiba+';'+Global.unidadebeltrao)>0 ) and (codcst<>3) then
//    result:=false
//  else
    result:=true;

end;

function TFSittributaria.CSTtoCF(cst: string ; xCodigoUnidade:string='' ; xes:string=''): string;
///////////////////////////////////////////////////////// ////////////////////////////////
// 19.12.11 - ajustado pra preve CST Icms pro simples
var Q:TSqlquery;
    sqles:string;
begin
  sqles:='';
  if trim(xes)<>'' then
    sqles:=' and sitt_es='+Stringtosql(xes);
  Q:=sqltoquery('select * from sittrib where sitt_cst='+stringtosql(cst)+sqles );
  if not Q.eof then
    result:=Q.fieldbyname('sitt_cf').asstring
//  else if trim(xCodigoUnidade)<>'' then begin
//    if pos( FUnidades.GetSimples(xCodigoUnidade),'S;2' ) > 0 then
//      result:='5'
    else
      result:='1';         // tributado
//  end else
//   result:='0';
// 18.06.12 - Empresas do Simples - Giacomoni - para jogar em valor contabil e outras no sintegra
// deve retornar o codigo fiscal 4 ref. subst. tributaria
  if xes='S' then begin
    if pos( cst,'201;202;203;500' ) > 0 then
      result:='4'
  end;
///////////////////
  FGeral.Fechaquery(Q);

end;

function TFSittributaria.GetCodigoCst(cst: string;xes:string=''): string;
//////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqles:string;
begin
  sqles:='';
  if trim(xes)<>'' then
    sqles:=' and sitt_es='+Stringtosql(xes);
  Q:=sqltoquery('select * from sittrib where sitt_cst='+stringtosql(cst)+sqles );
  if not Q.eof then
    result:=Q.fieldbyname('sitt_codigo').asstring
  else
    result:='0';
  FGeral.Fechaquery(Q);

end;

//function TFSittributaria.GetCfop(cst,natf: string): string;
// 12.08.19
//function TFSittributaria.Getcbenef(cst,xes: string): string;
function TFSittributaria.Getcbenef( codigo:integer): string;
//////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqles:string;
begin

//  sqles:='';
//  if trim(xes)<>'' then
//    sqles:=' and sitt_es='+Stringtosql(xes);
//  Q:=sqltoquery('select * from sittrib where sitt_cst='+stringtosql(cst)+sqles );
  Q:=sqltoquery('select sitt_cbenef from sittrib where sitt_codigo='+inttostr(codigo));
  if not Q.eof then begin

    result:=Q.fieldbyname('sitt_cbenef').asstring;

  end else begin

//    Q:=sqltoquery('select * from sittrib where sitt_cst='+stringtosql(cst) );
//    if not Q.eof then
//
 //      result:=Q.fieldbyname('sitt_cbenef').asstring
//
//    else

      result:='';

  end;
  FGeral.Fechaquery(Q);


end;

// 29.12.19
function TFSittributaria.GetcbenefporCST(cst, xes: string): string;
///////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqles:string;
begin

  sqles:='';
  if trim(xes)<>'' then
    sqles:=' and sitt_es='+Stringtosql(xes);
  Q:=sqltoquery('select * from sittrib where sitt_cst='+stringtosql(cst)+sqles );
  if not Q.eof then begin

    result:=Q.fieldbyname('sitt_cbenef').asstring;

  end else begin

    Q:=sqltoquery('select * from sittrib where sitt_cst='+stringtosql(cst) );
    if not Q.eof then

      result:=Q.fieldbyname('sitt_cbenef').asstring

    else

      result:='';

  end;
  FGeral.Fechaquery(Q);

end;

function TFSittributaria.GetCF(codigo: integer): string;
//////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

    Q:=sqltoquery('select sitt_cf from sittrib where sitt_codigo='+inttostr(codigo) );
    if not Q.eof  then result := Q.fieldbyname('sitt_cf').asstring else result := '0';
    FGeral.Fechaquery(Q);

end;

function TFSittributaria.GetCfop(codigocst:integer;natf,xtipomov:string):string;
//////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqles,dentroestado,cfop:string;
begin
  result:=natf;
  if pos( copy(natf,1,1),'1;2;3' )>0 then begin
    sqles:=' and sitt_es=''E''';
    if pos( copy(natf,1,1),'1' )>0 then
      dentroestado:='S'
    else
      dentroestado:='N';
  end else begin
    sqles:='';
    if pos( copy(natf,1,1),'5' )>0 then
      dentroestado:='S'
    else
      dentroestado:='N';
  end;
  campo:=Sistema.GetDicionario('sittrib','sitt_natf_codigo');
  cfop:='';
  if campo.Tipo<>'' then begin
{
    Q:=sqltoquery('select * from sittrib where sitt_cst='+stringtosql(cst)+sqles );
    if not Q.eof  then begin
      if dentroestado='S' then
        result:=Q.fieldbyname('sitt_natf_codigo').asstring
      else
        result:=Q.fieldbyname('sitt_natf_codigofe').asstring;
    end;
}
    Q:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr(codigocst) );
    if not Q.eof  then begin
      if dentroestado='S' then
        cfop:=Q.fieldbyname('sitt_natf_codigo').asstring
      else
        cfop:=Q.fieldbyname('sitt_natf_codigofe').asstring;
    end;
    if trim(cfop)<>'' then
      result:=cfop;
    FGeral.Fechaquery(Q);
// 06.11.13 - AGB - venda geral e venda fracionada
// 07.08.15 - Giacomoni - venda bonifica��o
    if pos(xTipomov,Global.CodVendaAmbulante+';'+Global.CodVendaBrinde)>0 then result:=natf
    else if pos(natf,'5104/6104')>0 then result:=natf
  end;

end;

function TFSittributaria.ValidaCst: boolean;
/////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from sittrib where sitt_cst='+EdSitt_cst.assql+
                ' and sitt_codigo<>'+EdSitt_codigo.AsSql+
                comparastringnula(EdSitt_es) );
  result:=true;
  if not Q.eof then begin
    if Q.FieldByName('SITT_CODIGO').AsInteger<>EdSitt_codigo.AsInteger then begin
      Avisoerro('J� existe codigo '+Q.FieldByName('SITT_CODIGO').AsString+' com este CST para uso em '+EdSitt_es.Text);
      result:=false;
    end;
  end;
  FGeral.FechaQuery(Q);
end;

function TFSittributaria.Comparastringnula(Ed:TSqlEd):string;
begin
  if Ed.text='' then
    result:=' and sitt_es is null'
  else
    result:=' and sitt_es='+Ed.assql;

end;

procedure TFSittributaria.GridNewRecord(Sender: TObject);
////////////////////////////////////////////////////////////
begin

  campopis:=Sistema.GetDicionario('sittrib','sitt_cstpis');
// 14.10.11
  if campopis.Tipo<>'' then begin
    FSittributaria.EdSitt_cstpis.enabled:=true;
    FSittributaria.EdSitt_cstpis.Group:=0;
    FSittributaria.EdSitt_cstcofins.enabled:=true;
    FSittributaria.EdSitt_cstcofins.Group:=0;
  end else begin
    FSittributaria.EdSitt_cstpis.enabled:=false;
    FSittributaria.EdSitt_cstpis.Group:=24;
    FSittributaria.EdSitt_cstcofins.enabled:=false;
    FSittributaria.EdSitt_cstcofins.Group:=24;
  end;
// 02.08.19
  if campocbenef.Tipo<>'' then begin
    FSittributaria.EdSitt_cbenef.enabled:=true;
    FSittributaria.EdSitt_cbenef.Group:=0;
    FSittributaria.EdSitt_cbenef.TableName:='sittrib';
  end else begin
    FSittributaria.EdSitt_cbenef.enabled:=false;
    FSittributaria.EdSitt_cbenef.Group:=24;
    FSittributaria.EdSitt_cbenef.TableName:='';
  end;

//  EdSitt_codigo.GetFields(FSittributaria,99);
// 24.10.11 - se mandar 99 vai 'todos' de qq forma independente da tag..GROUP JAMANTAAA
  EdSitt_codigo.GetFields(FSittributaria,0);
end;

procedure TFSittributaria.EdSITT_CSTValidate(Sender: TObject);
begin
  if not ValidaCst then EdSitt_cst.invalid('');

end;

procedure TFSittributaria.SetaCstPis(Ed: TSqled);
///////////////////////////////////////////////////////
begin
  Ed.Items.Clear;
  Ed.Items.Add('01 - Opera��o Tribut�vel com Al�quota B�sica   // valor da opera��o al�quota normal (cumulativo/n�o cumulativo))');
  Ed.Items.Add('02 - Opera��o Tribut�vel com Al�quota Diferenciada // valor da opera��o (al�quota diferenciada))');
  Ed.Items.Add('03 - Opera��o Tribut�vel com Al�quota por Unidade de Medida de Produto // quantidade vendida x al�quota por unidade de produto)');
  Ed.Items.Add('04 - Opera��o Tribut�vel Monof�sica - Revenda a Al�quota Zero');
  Ed.Items.Add('05 - Opera��o Tribut�vel por Substitui��o Tribut�ria');
  Ed.Items.Add('06 - Opera��o Tribut�vel a Al�quota Zero');
  Ed.Items.Add('07 - Opera��o Isenta da Contribui��o');
  Ed.Items.Add('08 - Opera��o sem Incid�ncia da Contribui��o');
  Ed.Items.Add('09 - Opera��o com Suspens�o da Contribui��o');
  Ed.Items.Add('49 - Outras Opera��es de Sa�da');
  Ed.Items.Add('50 - Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita Tributada no Mercado Interno');
  Ed.Items.Add('51 - Opera��o com Direito a Cr�dito � Vinculada Exclusivamente a Receita N�o Tributada no Mercado Interno');
  Ed.Items.Add('52 - Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita de Exporta��o');
  Ed.Items.Add('53 - Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno');
  Ed.Items.Add('54 - Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o');
  Ed.Items.Add('55 - Opera��o com Direito a Cr�dito - Vinculada a Receitas N�o-Tributadas no Mercado Interno e de Exporta��o');
  Ed.Items.Add('56 - Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno, e de Exporta��o');
  Ed.Items.Add('60 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita Tributada no Mercado Interno');
  Ed.Items.Add('61 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita N�o-Tributada no Mercado Interno');
  Ed.Items.Add('62 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita de Exporta��o');
  Ed.Items.Add('63 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno');
  Ed.Items.Add('64 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o');
  Ed.Items.Add('65 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas N�o-Tributadas no Mercado Interno e de Exporta��o');
  Ed.Items.Add('66 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno, e de Exporta��o');
  Ed.Items.Add('67 - Cr�dito Presumido - Outras Opera��es');
  Ed.Items.Add('70 - Opera��o de Aquisi��o sem Direito a Cr�dito');
  Ed.Items.Add('71 - Opera��o de Aquisi��o com Isen��o');
  Ed.Items.Add('72 - Opera��o de Aquisi��o com Suspens�o');
  Ed.Items.Add('73 - Opera��o de Aquisi��o a Al�quota Zero');
  Ed.Items.Add('74 - Opera��o de Aquisi��o sem Incid�ncia da Contribui��o');
  Ed.Items.Add('75 - Opera��o de Aquisi��o por Substitui��o Tribut�ria');
  Ed.Items.Add('98 - Outras Opera��es de Entrada');
  Ed.Items.Add('99 - Outras Opera��es');

end;

procedure TFSittributaria.SetaCstCofins(Ed: TSqled);
///////////////////////////////////////////////////////
begin
  Ed.Items.Clear;
  Ed.Items.Add('01 - Opera��o Tribut�vel com Al�quota B�sica  // valor da opera��o al�quota normal (cumulativo/n�o cumulativo))');
  Ed.Items.Add('02 - Opera��o Tribut�vel com Al�quota Diferenciada  // valor da opera��o (al�quota diferenciada))');
  Ed.Items.Add('03 - Opera��o Tribut�vel com Al�quota por Unidade de Medida de Produto // quantidade vendida x al�quota por unidade de produto)');
  Ed.Items.Add('04 - Opera��o Tribut�vel Monof�sica - Revenda a Al�quota Zero');
  Ed.Items.Add('05 - Opera��o Tribut�vel por Substitui��o Tribut�ria');
  Ed.Items.Add('06 - Opera��o Tribut�vel a Al�quota Zero');
  Ed.Items.Add('07 - Opera��o Isenta da Contribui��o');
  Ed.Items.Add('08 - Opera��o sem Incid�ncia da Contribui��o');
  Ed.Items.Add('09 - Opera��o com Suspens�o da Contribui��o');
  Ed.Items.Add('49 - Outras Opera��es de Sa�da');
  Ed.Items.Add('50 - Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita Tributada no Mercado Interno');
  Ed.Items.Add('51 - Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita N�o-Tributada no Mercado Interno');
  Ed.Items.Add('52 - Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita de Exporta��o');
  Ed.Items.Add('53 - Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno');
  Ed.Items.Add('54 - Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o');
  Ed.Items.Add('55 - Opera��o com Direito a Cr�dito - Vinculada a Receitas N�o Tributadas no Mercado Interno e de Exporta��o');
  Ed.Items.Add('56 - Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno e de Exporta��o');
  Ed.Items.Add('60 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita Tributada no Mercado Interno');
  Ed.Items.Add('61 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita N�o-Tributada no Mercado Interno');
  Ed.Items.Add('62 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada Exclusivamente a Receita de Exporta��o');
  Ed.Items.Add('63 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno');
  Ed.Items.Add('64 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o');
  Ed.Items.Add('65 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas N�o-Tributadas no Mercado Interno e de Exporta��o');
  Ed.Items.Add('66 - Cr�dito Presumido - Opera��o de Aquisi��o Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno e de Exporta��o');
  Ed.Items.Add('67 - Cr�dito Presumido - Outras Opera��es');
  Ed.Items.Add('70 - Opera��o de Aquisi��o sem Direito a Cr�dito');
  Ed.Items.Add('71 - Opera��o de Aquisi��o com Isen��o');
  Ed.Items.Add('72 - Opera��o de Aquisi��o com Suspens�o');
  Ed.Items.Add('73 - Opera��o de Aquisi��o a Al�quota Zero');
  Ed.Items.Add('74 - Opera��o de Aquisi��o sem Incid�ncia da Contribui��o');
  Ed.Items.Add('75 - Opera��o de Aquisi��o por Substitui��o Tribut�ria');
  Ed.Items.Add('98 - Outras Opera��es de Entrada');
  Ed.Items.Add('99 - Outras Opera��es');

end;


end.
