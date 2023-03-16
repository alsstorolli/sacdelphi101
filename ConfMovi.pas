unit ConfMovi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel;

type
  TFConfMovimento = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
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
    bEditar: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    PEdits: TSQLPanelGrid;
    Grid: TSQLGrid;
    DSCadastro: TDataSource;
    EdComv_codigo: TSQLEd;
    EdComv_descricao: TSQLEd;
    EdComv_especie: TSQLEd;
    EdComv_serie: TSQLEd;
    EdComv_natf_estado: TSQLEd;
    EdComv_natf_foestado: TSQLEd;
    EdComv_tipomovto: TSQLEd;
    EdComv_usua_codigo: TSQLEd;
    Eddesctipomovto: TSQLEd;
    EdComv_natf_estadoipi: TSQLEd;
    EdComv_natf_foestadoipi: TSQLEd;
    Edcomv_natf_estadoser: TSQLEd;
    Edcomv_natf_foestadoser: TSQLEd;
    EdSTServicos: TSQLEd;
    SetEdSt: TSQLEd;
    EdComv_debito: TSQLEd;
    EdComv_credito: TSQLEd;
    EdComv_plan_conta: TSQLEd;
    SetEdplan_descricao: TSQLEd;
    EdEditsentrada: TSQLEd;
    bcopiacampos: TSQLBtn;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure bEditarClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdComv_natf_estadoValidate(Sender: TObject);
    procedure EdComv_natf_foestadoValidate(Sender: TObject);
    procedure EdComv_natf_foestadoExitEdit(Sender: TObject);
    procedure EdComv_tipomovtoValidate(Sender: TObject);
    procedure EdComv_plan_contaValidate(Sender: TObject);
    procedure bcopiacamposClick(Sender: TObject);

  private
    function GetEspecieSerie(Codigo: integer): string;
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetEspecie(Codigo:integer):string;
    function GetSerie(Codigo:integer):string;
    function GetTipoMov(Codigo:integer):string;
    function GetCfopServicoEstado(Codigo:integer):string;
    function GetCfopServicoForEstado(Codigo:integer):string;
    function GetCstServicos(Codigo:integer):integer;
    function GetContaConfMovimento(CodigoMov:integer):boolean;
    procedure SetaItemsMovimento(Ed:TSqlEd);
    procedure SetaItemsEditsEntrada(Ed:TSqlEd);
    function GetDescricao(Codigo:integer):string;
    function GetContaGerencial(Codigo:integer):integer;
// 29.10.15
    procedure SetaItems(Ed:TSqlEd);

  end;

var
  FConfMovimento: TFConfMovimento;
  Op:string;

implementation

uses Arquiv, SqlSis, Geral, SqlExpr, Sqlfun, SQLRel, plano;

{$R *.dfm}

function Validacfop(Ed:TSqled;Estado:boolean):boolean;
var cfopvalido:string;
begin
  result:=true;
  if trim(Ed.text)='' then exit;
//  if ansipos(FConfMovimento.EdComv_tipomovto.text,Global.TiposMovMovEntrada)>0 then
  if Ed.resultfind.fieldbyname('natf_es').AsString='E' then begin
    if estado then
      cfopvalido:='1;3'
    else
      cfopvalido:='2;3'
  end else begin
    if estado then
      cfopvalido:='5;7'
    else
      cfopvalido:='6;7';
  end;
  if pos(copy(Ed.text,1,1),cfopvalido)>0 then
    result:=true
  else
    result:=false;
// 18.02.08
   if ( Ed.resultfind.fieldbyname('natf_es').AsString='E' ) and ( pos(FConfMovimento.EdComv_tipomovto.text,Global.TiposSaida )>0 ) then begin
     avisoerro('Tipo de movimento de saida n�o pode ter CFOP de entrada');
     result:=false;
   end else if ( Ed.resultfind.fieldbyname('natf_es').AsString='S' ) and ( pos(FConfMovimento.EdComv_tipomovto.text,Global.TiposSaida )=0 ) then begin
     avisoerro('Tipo de movimento de entrada n�o pode ter CFOP de saida');
     result:=false;
   end;
end;


procedure TFConfMovimento.Execute;
/////////////////////////////////////
begin
  Arq.TConfMovimento.Close;
  Arq.TConfMovimento.Open;
  SetaItemsEditsEntrada(EdEditsEntrada);
  FGeral.ConfiguraColorEditsNaoEnabled(FConfMovimento);
  ShowMOdal;
end;

procedure TFConfMovimento.FormActivate(Sender: TObject);
begin
//  if not Arq.TConfMovimento.Active then Arq.TConfMovimento.Open;
  Arq.TConfMovimento.Open;
  FGeral.SetaItemsMovimento(EdComv_tipomovto);
  EdComv_Codigo.ClearAll(Self,99);
  PEdits.DisableEdits;
  if not Arq.TConfMovimento.IsEmpty then Arq.TConfMovimento.GetFields(Self,0);
  Fgeral.ColunasGrid(Grid,Self);
  FGeral.ConfiguraColorEditsNaoEnabled(FConfMovimento);
end;

procedure TFConfMovimento.bIncluirClick(Sender: TObject);
begin
  Op:='I';
  EdComv_Codigo.SetStatusEdits(Self,99,seEdit);
  PEdits.Visible:=true;
  PEdits.EnableEdits;
//  Grid.Cancel;
  EdComv_Codigo.ClearAll(Self,99);
  EdComv_codigo.setvalue( FGeral.GetProximoCodigoCadastro('confmov','comv_codigo') );
  EdComv_Codigo.SetFocus;

end;

procedure TFConfMovimento.bCancelarClick(Sender: TObject);
begin
  EdComv_Codigo.ClearAll(Self,99);
///////////////////////////////  Grid.Cancel;
  PEdits.DisableEdits;
  PEdits.Visible:=false;
  if not Arq.TConfMovimento.IsEmpty then Arq.TConfMovimento.GetFields(Self,0);

end;

procedure TFConfMovimento.bEditarClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
begin
  if Arq.TConfMovimento.isempty then exit;
// 09.03.18
  EdComv_codigo.GetFields(Self,0);
  Op:='E';
  EdComv_Codigo.SetStatusEdits(Self,99,seEditAll);
  PEdits.Visible:=true;
  PEdits.EnableEdits;
//  EdUnid_Muni_Nome.Enabled:=False;
  EdComv_Codigo.Enabled:=False;
//  Grid.Cancel;
  EdComv_Descricao.SetFocus;

end;

procedure TFConfMovimento.bExcluirClick(Sender: TObject);
var Cod:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,Msg:String):Boolean;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM '+Tabela+' WHERE '+Campo+'='+Cod);
      Result:=Q.FieldByName('Registros').AsInteger>0;
      if Result then AvisoErro('Encontrado lan�amentos com a configura��o escolhida; na tabela: '+Msg);
      Q.Close;Q.Free;
    end;


begin
  Cod:=StringToSql(Arq.TConfMovimento.FieldByName('Comv_Codigo').AsString);
  Found:=FoundTabela('Movesto','Moes_Comv_Codigo','Movimento Mestre de Estoque');
  if not Found then begin
    Grid.Delete;
    FGeral.GravaLog(8,'Exclus�o',true);
  end;

end;

procedure TFConfMovimento.bRelatorioClick(Sender: TObject);
var Q:Tsqlquery;
    tipo:string;
begin
//  FRel.ReportFromGrid(Grid,'CadConfMovimento','Rela��o de Configura��o de Movimento','','');
  q:=sqltoquery('select * from confmov order by comv_descricao');
  if Q.eof then begin
    FGeral.fechaquery(Q);
    exit;
  end;
    Sistema.BeginProcess('Gerando Relat�rio');
    FRel.Init('RelConfigdeMovimento');
    FRel.AddTit('Rela��o das Configura��es de Movimento do Sistema');
    FRel.AddCol(040,3,'N','' ,''              ,'Codigo'         ,''         ,'',false);
    FRel.AddCol(120,1,'C','' ,''              ,'Descri�ao'      ,''         ,'',false);
    FRel.AddCol(050,1,'C','' ,''              ,'Esp�cie'        ,''         ,'',false);
    FRel.AddCol(040,1,'C','' ,''              ,'S�rie'          ,''         ,'',false);
    FRel.AddCol(070,1,'C','' ,''              ,'CFOP Est.'          ,''         ,'',false);
    FRel.AddCol(070,1,'C','' ,''              ,'CFOP Fora'          ,''         ,'',false);
    FRel.AddCol(070,1,'C','' ,''              ,'D�bito'          ,''         ,'',false);
    FRel.AddCol(070,1,'C','' ,''              ,'Cr�dito'          ,''         ,'',false);
    FRel.AddCol(060,1,'C','' ,''              ,'Tipo'   ,''         ,'',false);
    FRel.AddCol(220,0,'C','' ,''              ,'Tipo de Movimento'       ,''         ,'',false);
    FRel.AddCol(050,2,'C','' ,''              ,'Estoque'         ,''         ,'',false);
    FRel.AddCol(070,2,'C','' ,''              ,'Financeiro'       ,''         ,'',false);
    FRel.AddCol(070,2,'C','' ,''              ,'Fiscal'       ,''         ,'',false);
    FRel.AddCol(050,2,'C','' ,''              ,'Icms'        ,''         ,'',false);
    FRel.AddCol(050,2,'C','' ,''              ,'Substit.'         ,''         ,'',false);
    while not Q.eof  do begin
      FRel.AddCel(Q.fieldbyname('comv_codigo').asstring);
      FRel.AddCel(Q.fieldbyname('comv_descricao').asstring);
      FRel.AddCel(Q.fieldbyname('comv_especie').asstring);
      FRel.AddCel(Q.fieldbyname('comv_serie').asstring);
      FRel.AddCel(Q.fieldbyname('comv_natf_estado').asstring);
      FRel.AddCel(Q.fieldbyname('comv_natf_foestado').asstring);
      FRel.AddCel(Q.fieldbyname('comv_debito').asstring);
      FRel.AddCel(Q.fieldbyname('comv_credito').asstring);
      tipo:=Q.fieldbyname('comv_tipomovto').asstring;
      FRel.AddCel(Tipo);
      FRel.AddCel(FGeral.GetTipoMovto(tipo));
      FRel.AddCel(FGeral.GetMovimentoEstoque(tipo));
      FRel.AddCel(FGeral.GetGeraFinanceiro(tipo));
      FRel.AddCel(FGeral.GetGeraFiscal(tipo));
      FRel.AddCel(FGeral.GetCalculaIcms(tipo));
      FRel.AddCel(FGeral.GetCalculaSubstit(tipo));
      Q.Next;
    end;
    FRel.Video;
    Sistema.EndProcess('');
    FGeral.fechaquery(Q);

end;

procedure TFConfMovimento.GridNewRecord(Sender: TObject);
begin
  if not Arq.TConfMovimento.IsEmpty then Arq.TConfMovimento.GetFields(Self,0);
  EdDesctipomovto.text:=FGeral.gettipomovto(EdComv_tipomovto.text);
  SetEdplan_descricao.text:=FPlano.GetDescricao(EdComv_plan_conta.asinteger);

end;

procedure TFConfMovimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FGeral.LiberaCadastro(Grid);

end;

procedure TFConfMovimento.EdComv_natf_estadoValidate(Sender: TObject);
begin
  if trim(EdComv_natf_estado.text)<>'' then begin
    if not ValidaCfop(EdComv_natf_estado,true) then
      EdComv_natf_estado.Invalid('Codigo invalido para este movimento ou estado')
  end;
end;

procedure TFConfMovimento.EdComv_natf_foestadoValidate(Sender: TObject);
begin
  if trim(EdComv_natf_foestado.text)<>'' then begin
    if not ValidaCfop(EdComv_natf_foestado,false) then
      EdComv_natf_foestado.Invalid('Codigo invalido para este movimento ou fora do estado')
    else if (EdComv_natf_foestado.text=EdComv_natf_estado.text)
       and ( pos(copy(EdComv_natf_foestado.text,1,1),'37')=0 ) then
       EdComv_natf_foestado.Invalid('Codigo no estado tem que ser diferente de fora do estado');
  end;
end;

procedure TFConfMovimento.EdComv_natf_foestadoExitEdit(Sender: TObject);
var oper:string;
begin

  if not EdComv_natf_foestado.Valid then exit;
  EdComv_usua_codigo.SetValue(Global.Usuario.Codigo);

  if Op='I' then begin
     Grid.PostInsert(EdComv_Codigo);
     oper:='Inclus�o';
     EdComv_codigo.setvalue( FGeral.GetProximoCodigoCadastro('confmov','comv_codigo') );
  end else begin
{
     Arq.TConfMovimento.Edit;
     Arq.TConfMovimento.SetFields(Self,0);
     Arq.TConfMovimento.Post;
     Arq.TConfMovimento.Commit;
}
/////////////////     Grid.Cancel;
// 09.03.18
     Sistema.Edit('confmov');
     Sistema.SetField('Comv_descricao',EdComv_descricao.Text);
     Sistema.SetField('Comv_tipomovto',EdComv_tipomovto.Text);
     Sistema.SetField('Comv_especie',EdComv_especie.Text);
     Sistema.SetField('Comv_serie',EdComv_serie.Text);
     Sistema.SetField('Comv_natf_estado',EdComv_natf_estado.Text);
     Sistema.SetField('Comv_natf_foestado',EdComv_natf_foestado.Text);
     Sistema.SetField('Comv_natf_estadoipi',EdComv_natf_estadoipi.Text);
     Sistema.SetField('Comv_natf_foestadoipi',EdComv_natf_foestadoipi.Text);
     Sistema.SetField('comv_natf_estadoser',Edcomv_natf_estadoser.Text);
     Sistema.SetField('comv_natf_foestadoser',Edcomv_natf_foestadoser.Text);
     Sistema.SetField('Comv_sitt_codigo',EdSTServicos.Asinteger);
     Sistema.SetField('Comv_debito',EdComv_debito.Asinteger);
     Sistema.SetField('Comv_credito',EdComv_credito.Asinteger);
     Sistema.SetField('Comv_plan_conta',EdComv_plan_conta.Asinteger);
     Sistema.SetField('comv_editsnota',EdEditsentrada.Text);
     Sistema.Post('comv_codigo='+EdComv_codigo.AsSql);
     Sistema.Commit;
     Arq.TConfMovimento.Refresh;
     PEdits.DisableEdits;
     oper:='Altera��o';
     Grid.SetFocus;
  end;
  FGeral.GravaLog(8,oper,true);
end;

procedure TFConfMovimento.EdComv_tipomovtoValidate(Sender: TObject);
begin
  EdDesctipomovto.text:=FGeral.gettipomovto(EdComv_tipomovto.text);
  EdEditsEntrada.enabled:=( pos(EdComv_tipomovto.text,Global.TiposEntrada)>0 );
end;

function TFConfMovimento.GetEspecieSerie(Codigo: integer): string;
begin
end;

function TFConfMovimento.GetEspecie(Codigo: integer): string;
begin
  if not Arq.TConfMovimento.active then Arq.TConfMovimento.open;
  Arq.TConfMovimento.locate('comv_codigo',inttostr(codigo),[]);
  if not Arq.TConfMovimento.eof then
    result:=Arq.TConfMovimento.fieldbyname('comv_especie').asstring
  else
    result:='';

end;

function TFConfMovimento.GetSerie(Codigo: integer): string;
begin
  if not Arq.TConfMovimento.active then Arq.TConfMovimento.open;
  Arq.TConfMovimento.locate('comv_codigo',inttostr(codigo),[]);
  if not Arq.TConfMovimento.eof then
    result:=Arq.TConfMovimento.fieldbyname('comv_serie').asstring
  else
    result:='';

end;

function TFConfMovimento.GetTipoMov(Codigo: integer): string;
begin

end;

function TFConfMovimento.GetCfopServicoEstado(Codigo: integer): string;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select comv_natf_estadoser from confmov  where comv_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('comv_natf_estadoser').asstring
  else
    result:='     ';
  FGeral.fechaquery(Q);

end;

function TFConfMovimento.GetCfopServicoForEstado(Codigo: integer): string;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select comv_natf_foestadoser from confmov  where comv_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('comv_natf_foestadoser').asstring
  else
    result:='     ';
  FGeral.fechaquery(Q);
end;

function TFConfMovimento.GetCstServicos(Codigo: integer): integer;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select comv_sitt_codigo from confmov  where comv_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('comv_sitt_codigo').asinteger
  else
    result:=0;
  FGeral.fechaquery(Q);
end;

function TFConfMovimento.GetContaConfMovimento(  CodigoMov: integer): boolean;
////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  result:=false;
  if codigomov<=0 then exit;
  Q:=sqltoquery('select * from confmov where comv_codigo='+inttostr(codigomov));
  if not Q.eof then begin
    if ( (Q.fieldbyname('comv_debito').asinteger>0) and (Q.fieldbyname('comv_credito').asinteger>0)  ) or
// 19.03.09 - para poder tratar diferente... Vims
       ( (Q.fieldbyname('comv_debito').asinteger>0)  and (Q.fieldbyname('comv_credito').asinteger=0) ) or
// 21.11.19 - para poder tratar diferente... Novicarnes - venda de imbo.
       ( (Q.fieldbyname('comv_debito').asinteger=0)  and (Q.fieldbyname('comv_credito').asinteger>0) ) then
      result:=true;
  end;
  FGeral.Fechaquery(Q);
end;

procedure TFConfMovimento.EdComv_plan_contaValidate(Sender: TObject);
begin
  if EdComv_plan_conta.resultfind<>nil then begin
//    if pos( EdComv_plan_conta.ResultFind.FieldByName('Plan_tipo').asstring,'S;D' )>0 then
    if AnsiPos( EdComv_plan_conta.ResultFind.FieldByName('Plan_tipo').asstring,'M;P' ) = 0 then
      EdComv_plan_conta.invalid('Tipo de conta inv�lido');
  end;
end;

procedure TFConfMovimento.SetaItemsMovimento(Ed: TSqlEd);
var Q:TSqlquery;
begin
  Ed.Items.Clear;
  Q:=sqltoquery('select distinct comv_tipomovto from confmov order by Comv_tipomovto');
  Ed.Items.Add(Global.CodCompra100+' - '+FGeral.GetTipoMovto(Global.CodCompra100));
  while not Q.eof do begin
    Ed.Items.add(Q.fieldbyname('comv_tipomovto').asstring+' - '+FGeral.GetTipoMovto(Q.fieldbyname('comv_tipomovto').asstring) );
    Q.Next;
  end;
end;

procedure TFConfMovimento.SetaItemsEditsEntrada(Ed: TSqlEd);
/////////////////////////////////////////////////////////////////
// edits 'desabilitados' por padrao na entrada.
const tam:integer=20;
begin

   Ed.Items.Clear;
   Ed.Items.Add(strspace('EdSeguro',tam)+' - Valor do Seguro');
   Ed.Items.Add(strspace('EdUnid_codigo',tam)+' - Codigo da Unidade');
   Ed.Items.Add(strspace('EdPesoliq',tam)+' - Peso L�quido');
   Ed.Items.Add(strspace('EdConhecimento',tam)+' - Conhecimento');
   Ed.Items.Add(strspace('EdPedido',tam)+' - N�mero do Pedido');
   Ed.Items.Add(strspace('EdFrete',tam)+' - Valor do Frete');
   Ed.Items.Add(strspace('EdPericmsfrete',tam)+' - Valor do Icms do Frete');
   Ed.Items.Add(strspace('EdDigbicms',tam)+' - Base do Icms da Nota');
   Ed.Items.Add(strspace('EdDigvicms',tam)+' - Valor do Icms da Nota');
   Ed.Items.Add(strspace('EdPecas',tam)+' - Quantidade em Pe�as');
// 04.04.19
   Ed.Items.Add(strspace('EdValoripi',tam)+' - Valor do IPI da Nota');
   Ed.Items.Add(strspace('EdPerIcmsNota',tam)+' - Percentual do Icms da Nota');
   Ed.Items.Add(strspace('EdPeripi',tam)+' - Percentual do Ipi da Nota');
// 22.01.2021
   Ed.Items.Add(strspace('EdTipodoc',tam)+' - Tipo de Documento');
// 30.01.14 - A2Z
   Ed.Items.Add(strspace('DocNFiscal',tam)+' - Documento N�o Fiscal');
// ir colocando mais campos 'aos poucos'
// 12.11.12
//   Ed.Items.Add(strspace('EdMoes_tabp_codigo',tam)+' - Tabela de Pre�os');

end;

procedure TFConfMovimento.bcopiacamposClick(Sender: TObject);
var codigoorigem:string;
    Q:TSqlquery;
begin
  if not Input('Codigo origem','Cod.Mov.',codigoorigem,4,false) then exit;
  if strtointdef(codigoorigem,0)=0 then exit;
  Q:=sqltoquery('select * from confmov where comv_codigo='+trim(codigoorigem));
  if Q.eof then begin
    Avisoerro('Codigo '+codigoorigem+' n�o encontrado');
    Q.close;
    exit;
  end else begin
    if Q.FieldByName('comv_editsnota').AsString='' then begin
      Avisoerro('Campo est� em branco');
      Q.close;
      exit;
    end else begin
      Arq.TConfMovimento.Edit;
      Arq.TConfMovimento.FieldByName('comv_editsnota').AsString:=Q.FieldByName('comv_editsnota').AsString;
      Arq.TConfMovimento.Post;
      Arq.TConfMovimento.Commit;
      Arq.TConfMovimento.GetFields(FConfMovimento,99);
    end;
  end;
end;

function TFConfMovimento.GetDescricao(Codigo: integer): string;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select comv_descricao from confmov  where comv_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('comv_descricao').asstring
  else
    result:='     ';
  FGeral.fechaquery(Q);
end;

function TFConfMovimento.GetContaGerencial(Codigo: integer): integer;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select Comv_plan_conta from confmov  where comv_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('Comv_plan_conta').asinteger
  else
    result:=0;
  FGeral.fechaquery(Q);
end;

// 29.10.15
procedure TFConfMovimento.SetaItems(Ed: TSqlEd);
//////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Ed.Items.Clear;
  Q:=sqltoquery('select * from confmov order by Comv_codigo');
  while not Q.eof do begin
    Ed.Items.add(strzero(Q.fieldbyname('comv_codigo').asinteger,3)+' - '+Q.fieldbyname('comv_descricao').asstring) ;
    Q.Next;
  end;
  Q.close
end;

end.
