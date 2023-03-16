unit Subgrupos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel, Sqlfun, Sqlsis;

type
  TFSubgrupos = class(TForm)
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
    Dts: TDataSource;
    EdSugr_codigo: TSQLEd;
    EdSugr_descricao: TSQLEd;
    EdSugr_cfis_codigoest: TSQLEd;
    EdEsto_icmsestado: TSQLEd;
    EdSugr_cfis_codigoforaest: TSQLEd;
    EdEsto_icmsforaestado: TSQLEd;
    EdSugr_natf_estado: TSQLEd;
    EdComv_natf_foestado: TSQLEd;
    EdSugr_sitt_codestado: TSQLEd;
    SetEdsitt_cst: TSQLEd;
    EdSugr_sitt_forestado: TSQLEd;
    SetEd: TSQLEd;
    Edsugr_valorarroba: TSQLEd;
    batuprecos: TSQLBtn;
    Edsugr_percperda: TSQLEd;
    EdSUGR_CSTPIS: TSQLEd;
    EdSUGR_CSTCOFINS: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure EdSugr_descricaoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure batuprecosClick(Sender: TObject);
// 23.03.12
    procedure SetaItems(Edit,EditNomeGrupo:TSqlEd;GruposValidos,Nomevalido:String);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetDescricao(codigo:integer):string;
// 30.11.15
    function GetCodigosituacaotributaria(xcfop:string;xcodigo:integer):integer;
    function GetCodigoFiscal(xcfop:string;xcodigo:integer):string;
// 22.06.16
    function GetCST(codigo:integer;qual:string):string;
  end;

var
  FSubgrupos: TFSubgrupos;
  campopis:TDicionario;

implementation

uses Arquiv, SQLRel, SqlExpr,  Geral , Sittribu;

{$R *.dfm}

procedure TFSubgrupos.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdSugr_codigo);
  EdSugr_codigo.setvalue( FGeral.GetProximoCodigoCadastro('subgrupos','sugr_codigo') );
end;

procedure TFSubgrupos.EdSugr_descricaoExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdSugr_codigo);
  EdSugr_codigo.setvalue( FGeral.GetProximoCodigoCadastro('subgrupos','sugr_codigo') );
  
end;

procedure TFSubgrupos.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('CadSubgrupos','Relação de Subgrupos do Estoque','','');
  Frel.Reportfromsql('select * from subgrupos','CadSubgrupos','Relação de Subgrupos do Estoque');
end;

procedure TFSubgrupos.FormActivate(Sender: TObject);
////////////////////////////////////////////////////
begin
  campopis:=Sistema.GetDicionario('subgrupos','sugr_cstpis');
  if campopis.Tipo<>'' then begin
    FSubgrupos.EdSugr_cstpis.enabled:=true;
    FSubgrupos.EdSugr_cstpis.Group:=0;
    FSubgrupos.EdSugr_cstcofins.enabled:=true;
    FSubgrupos.EdSugr_cstcofins.Group:=0;
    FSubgrupos.EdSugr_cstpis.TableName:='subgrupos';
    FSubgrupos.EdSugr_cstcofins.TableName:='subgrupos';
  end else begin
    FSubgrupos.EdSugr_cstpis.enabled:=false;
    FSubgrupos.EdSugr_cstpis.Group:=24;
    FSubgrupos.EdSugr_cstcofins.enabled:=false;
    FSubgrupos.EdSugr_cstcofins.Group:=24;
    FSubgrupos.EdSugr_cstpis.TableName:='';
    FSubgrupos.EdSugr_cstcofins.TableName:='';
  end;
  FSittributaria.SetaCstPis(EdSugr_cstpis);
  FSittributaria.SetaCstCofins(EdSugr_cstcofins);

  if not Arq.TSubgrupos.active then Arq.TSubgrupos.open;
  Fgeral.ColunasGrid(Grid,Self);
end;

procedure TFSubgrupos.Execute;
begin
  FSubgrupos.show;
end;

function TFSubgrupos.GetDescricao(codigo: integer): string;
///////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Result:='';
  if Codigo>0 then begin
    Q:=sqltoquery('select sugr_descricao from subgrupos where sugr_codigo='+inttostr(codigo));
    if not Q.Eof then Result:=q.FieldByName('SuGr_Descricao').AsString;
    Fgeral.FechaQuery(Q);
  end;

end;

procedure TFSubgrupos.bExcluirClick(Sender: TObject);
var Cod:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,Msg,Chave:String):Boolean;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT '+chave+' as Codigo FROM '+Tabela+' WHERE '+Campo+'='+Cod );
      Result:=not Q.eof;
      if Result then AvisoErro('Encontrado vínculo na tabela '+tabela+' ref. '+Msg+' codigo '+Q.fieldbyname('codigo').asstring);
      Q.Close;Freeandnil(Q);
    end;


begin
  Cod:=IntToStr(Arq.TSubGrupos.FieldByName('sugr_Codigo').AsInteger);
  Found:=FoundTabela('Estoque','Esto_sugr_Codigo','Cadastro do estoque','Esto_codigo');
  if not Found then Grid.Delete;
end;


procedure TFSubgrupos.batuprecosClick(Sender: TObject);
var valorbase,novoven,novomin:currency;
    Q:Tsqlquery;
    pr:integer;
begin
  if not Arq.TSubgrupos.active then exit;
  if not confirma('Confirma atualização  subgrupo '+Arq.TSubgrupos.fieldbyname('sugr_descricao').asstring+' pelo valor '+floattostr(Arq.TSubgrupos.fieldbyname('sugr_valorarroba').ascurrency)+' ?') then exit;
  valorbase:=Arq.TSubgrupos.fieldbyname('sugr_valorarroba').ascurrency/15;
  if valorbase<=0 then exit;
  Sistema.beginprocess('Atualizando produtos do subgrupo');
  Q:=sqltoquery('select * from estoqueqtde inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                ' where esqt_unid_codigo='+stringtosql(global.codigounidade)+' and esqt_status=''N'''+
                ' and esto_codigovenda is null '+
                ' and esto_sugr_codigo='+inttostr(Arq.TSubgrupos.fieldbyname('sugr_codigo').asinteger) );
  pr:=0;
  while not Q.eof do begin
    novoven:=valorbase*(Q.fieldbyname('esto_pervenda').ascurrency/100);
    novomin:=novoven - ( novoven * (Q.fieldbyname('esto_desconto').ascurrency/100) );
    Sistema.Edit('estoqueqtde');
    Sistema.Setfield('esqt_vendavis',novoven);
    if Q.fieldbyname('esto_desconto').ascurrency>0 then
      Sistema.Setfield('esqt_vendamin',novomin);
    Sistema.post('esqt_unid_codigo='+stringtosql(global.codigounidade)+' and esqt_esto_codigo='+stringtosql(Q.fieldbyname('esqt_esto_codigo').asstring)+
                 ' and esqt_status=''N''');
    inc(pr);
    Q.Next;
  end;
  FGeral.FechaQuery(Q);
  try
    sistema.commit;
    Sistema.endprocess('Atualização terminada em '+inttostr(pr)+' produtos');
  except
    Sistema.endprocess('Problemas no banco.   Atualização não feita');
  end;
end;

procedure TFSubgrupos.SetaItems(Edit, EditNomeGrupo: TSqlEd; GruposValidos,
  Nomevalido: String);
begin
  Edit.Items.Clear;
  if not Arq.TSubGrupos.Active then Arq.TSubGrupos.Open;
  Arq.TSubGrupos.BeginProcess;
  Arq.TSubGrupos.First;
  while not Arq.TSubGrupos.Eof do begin
    if ((GruposValidos='') or (Pos(strzero(Arq.TSubGrupos.FieldByName('Sugr_Codigo').AsInteger,4),GruposValidos)>0))
       and ((NomeValido='') or (Pos(NomeValido,Uppercase(Arq.TSubGrupos.FieldByName('Sugr_Descricao').AsString))>0))
      then begin
       Edit.Items.Add(Strzero(Arq.TSubGrupos.FieldByName('Sugr_Codigo').AsInteger,4)+' - '+Trim(Arq.TSubGrupos.FieldByName('Sugr_Descricao').AsString));
    end;
    Arq.TSubGrupos.Next;
  end;
  Arq.TSubGrupos.EndProcess;
  if Edit.Items.Count=1 then begin
//     Edit.Text:=LeftStr(Edit.Items[0],3);
//     Edit.Text:=Edit.Items[0];  //retirado em 06.02.09
//     if EditNomeGrupo<>nil then EditNomeGrupo.Text:=FinalStr(Edit.Items[0],7);
     if EditNomeGrupo<>nil then EditNomeGrupo.Text:=FinalStr(Edit.Items[0],9);
  end;

end;

// 30.11.15
function TFSubgrupos.GetCodigosituacaotributaria(xcfop: string;xcodigo:integer): integer;
/////////////////////////////////////////////////////////////////////////////////////////////
var Qx:TSqlquery;
begin
  Qx:=sqltoquery('select * from subgrupos where sugr_codigo='+inttostr(xcodigo));
  if not Qx.eof then begin
    Result:=Qx.fieldbyname('Sugr_sitt_codestado').AsInteger;
    if pos( copy(xcfop,1,1),'6;7' ) > 0 then Result:=Qx.fieldbyname('Sugr_sitt_forestado').AsInteger;
  end else
    Result:=0;
  FGeral.Fechaquery(Qx);

end;

// 30.11.15
function TFSubgrupos.GetCodigoFiscal(xcfop: string;  xcodigo: integer): String;
//////////////////////////////////////////////////////////////////////////////////
var Qx:TSqlquery;
begin
  Qx:=sqltoquery('select * from subgrupos where sugr_codigo='+inttostr(xcodigo));
  if not Qx.eof then begin
    Result:=Qx.fieldbyname('sugr_cfis_codigoest').AsString;
    if pos( copy(xcfop,1,1),'6;7' ) > 0 then Result:=Qx.fieldbyname('sugr_cfis_codigoforaest').AsString;
  end else
    Result:='';
  FGeral.Fechaquery(Qx);
end;

// 22.06.16
function TFSubgrupos.GetCST(codigo: integer; qual: string): string;
/////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from subgrupos where sugr_codigo = '+inttostr(codigo));
  result:='';
  if not Q.eof then begin
     if qual='PIS' then result:=Q.fieldbyname('sugr_cstpis').asstring else result:=Q.fieldbyname('sugr_cstcofins').asstring;
  end;
  FGeral.FechaQuery(Q);
end;

end.
