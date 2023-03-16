unit Grades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, DB, Grids, DBGrids, SQLGrid, ExtCtrls,
  Buttons, SQLBtn, alabel, SqlDtg;
//  , DataGrid;

type
  TFGrades = class(TForm)
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
    bConfigurar: TSQLBtn;
    PGrade: TSQLPanelGrid;
    bGravar: TSQLBtn;
    EdGrade: TSQLEd;
    DtGrid1: TStringGrid;
    EdGrad_codigo: TSQLEd;
    EdGrad_descricao: TSQLEd;
    EdGrad_codigolinha: TSQLEd;
    EdGrad_codigocoluna: TSQLEd;
    EdGrad_linha: TSQLEd;
    EdGrad_coluna: TSQLEd;
    EdGrad_usua_codigo: TSQLEd;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Gridlinha: TSqlDtGrid;
    Gridcoluna: TSqlDtGrid;
    EdGrade1: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure bConfigurarClick(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdGrad_codigocolunaExitEdit(Sender: TObject);
    procedure EdGrad_codigocolunaValidate(Sender: TObject);
    procedure GridlinhaKeyPress(Sender: TObject; var Key: Char);
    procedure EdGrad_codigolinhaValidate(Sender: TObject);
    procedure EdGradeValidate(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure GridcolunaKeyPress(Sender: TObject; var Key: Char);
    procedure EdGradeKeyPress(Sender: TObject; var Key: Char);
    procedure EdGrade1KeyPress(Sender: TObject; var Key: Char);
    procedure EdGrade1Validate(Sender: TObject);
    procedure GridcolunaClick(Sender: TObject);
    procedure GridlinhaDblClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure Linhatogrid(Codigos:string);
    procedure Colunatogrid(Codigos: string);
    function Getcodigolinha(Codigo:integer):integer;
    function Getcodigocoluna(Codigo:integer):integer;
    function Getcodigoslinha(Codigo:integer):string;
    function Getcodigoscoluna(Codigo:integer):string;
  end;

var
  FGrades: TFGrades;
  TabelaLinha,CampocodigoLinha,FormLinha,Campodesclinha:string;
  TabelaColuna,CampocodigoColuna,FormColuna,CampodescColuna:string;
  CodigoLinha,CodigoColuna:integer;


implementation

uses Arquiv,Geral,Sqlfun, cadcor, Sqlexpr, tamanhos, SQLRel;

{$R *.dfm}

procedure Validatabelas(qual:integer;linhacoluna:string);
begin
  if linhacoluna='L' then begin
    if qual=2 then begin
      TabelaLinha:='Cores';
      CampocodigoLinha:='Core_codigo';
      Formlinha:='FCores';
    end else begin
      TabelaLinha:='Tamanhos';
      CampocodigoLinha:='Tama_codigo';
      Formlinha:='FTamanhos';
    end;
  end else begin
    if qual=2 then begin
      TabelaColuna:='Cores';
      CampocodigoColuna:='Core_codigo';
      FormColuna:='FCores';
    end else begin
      TabelaColuna:='Tamanhos';
      CampocodigoColuna:='Tama_codigo';
      FormColuna:='FTamanhos';
    end;
  end;
end;


procedure AtivaeditLInha;
begin

   FGrades.grid.Cancel;
   FGrades.gridlinha.Enabled:=true;
   FGrades.gridcoluna.Enabled:=false;
   FGrades.EdGrade.enabled:=true;
   FGrades.EdGrade1.enabled:=false;
   FGrades.EdGrade.Left:=FGrades.Gridlinha.LeftEdit;
   FGrades.EdGrade.Top:=FGrades.Gridlinha.TopEdit+FGrades.Gridlinha.DefaultRowHeight-4;
   FGrades.EdGrade.Visible:=true;
   FGrades.EdGrade.Enabled:=true;
   FGrades.EdGrade.Text:=FGrades.Gridlinha.Cells[FGrades.Gridlinha.Col,FGrades.Gridlinha.Row];
//   FGrades.EdGrad_codigolinha.SetValue(Arq.TGrades.fieldbyname('grad_codigolinha').AsInteger);
   Validatabelas(FGrades.EdGRad_codigolinha.AsInteger,'L');
   FGrades.EdGrade.FindTable:=TabelaLinha;
   FGrades.EdGrade.FindField:=CampoCodigoLinha;
   FGrades.EdGrade.ShowForm:=Formlinha;
   FGrades.EdGrade.SetFocus;

end;

procedure AtivaeditColuna;
begin

   FGrades.grid.Cancel;
   FGrades.gridlinha.Enabled:=false;
   FGrades.gridcoluna.Enabled:=true;
   FGrades.EdGrade.enabled:=false;
   FGrades.EdGrade1.enabled:=true;
   FGrades.EdGrade1.Left:=FGrades.GridColuna.LeftEdit;
//   FGrades.EdGrade1.Top:=FGrades.GridColuna.TopEdit+FGrades.GridColuna.DefaultRowHeight-4;
   FGrades.EdGrade1.Top:=FGrades.GridColuna.Top;
   FGrades.EdGrade1.Visible:=true;
   FGrades.EdGrade1.Enabled:=true;
   FGrades.EdGrade1.Text:=FGrades.GridColuna.Cells[FGrades.GridColuna.Col,FGrades.GridColuna.Row];
//   FGrades.EdGrad_codigolinha.SetValue(Arq.TGrades.fieldbyname('grad_codigolinha').AsInteger);
   Validatabelas(FGrades.EdGRad_codigocoluna.AsInteger,'C');
   FGrades.EdGrade1.FindTable:=TabelaColuna;
   FGrades.EdGrade1.FindField:=CampoCodigoColuna;
   FGrades.EdGrade1.ShowForm:=FormColuna;
   FGrades.EdGrade1.SetFocus;

end;

procedure DesativaeditLinha;
begin

   FGrades.EdGrade.Visible:=false;
//   FGrades.EdGrade.Enabled:=false;
//   FGrades.grid.Enabled:=true;
   FGrades.gridlinha.SetFocus;

end;

procedure DesativaeditColuna;
begin

   FGrades.EdGrade1.Visible:=false;
//   FGrades.EdGrade.Enabled:=false;
//   FGrades.grid.Enabled:=true;
   FGrades.gridcoluna.SetFocus;

end;

function Sonumeros(s:string):boolean;
const numeros:string ='0123456789';
var p:integer;
begin
  result:=false;
  if trim(s)<>'' then begin
    result:=true;
    for p:=1 to length(trim(s)) do begin
      if pos(copy(s,p,1),numeros)=0 then begin
        result:=false;
        exit;
      end;
    end;
  end;
end;


procedure TFGrades.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdGrad_codigo);
end;

procedure TFGrades.FormActivate(Sender: TObject);
begin
  if not Arq.TGrades.Active then Arq.TGrades.Open;
  if Codigolinha=0 then begin
    Codigolinha:=Arq.TGrades.fieldbyname('grad_codigolinha').AsInteger;
    if Codigolinha=2 then begin
      Tabelalinha:='Cores';
      Campocodigolinha:='Core_codigo';
      Campodesclinha:='Core_descricao';
      Formlinha:='FCores';
    end else begin
      Tabelalinha:='Tamanhos';
      Campocodigolinha:='Tama_codigo';
      Campodesclinha:='Tama_descricao';
      Formlinha:='FTamanhos';
    end;
  end;
  if CodigoColuna=0 then begin
    CodigoColuna:=Arq.TGrades.fieldbyname('grad_codigocoluna').AsInteger;
    if CodigoColuna=2 then begin
      TabelaColuna:='Cores';
      CampocodigoColuna:='Core_codigo';
      CampodescColuna:='Core_descricao';
      FormColuna:='FCores';
    end else begin
      TabelaColuna:='Tamanhos';
      CampocodigoColuna:='Tama_codigo';
      CampodescColuna:='Tama_descricao';
      FormColuna:='FTamanhos';
    end;
  end;
end;

procedure TFGrades.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('CadGrades','Relação de Grades Cadastradas','','');
  FRel.Reportfromsql('select * from grades','CadGrades','Relação de Grades Cadastradas');
end;

procedure TFGrades.Execute;
begin
  FGrades.Show;
end;

procedure TFGrades.bConfigurarClick(Sender: TObject);
begin
//  Dtgrid1.Enabled:=true;
  Grid.Enabled:=false;
  if Confirma('Configura a linha ?') then begin
    GridLinha.Enabled:=true;
    GridColuna.Enabled:=false;
    gridlinha.SetFocus;
  end else begin
    GridLinha.Enabled:=false;
    GridColuna.Enabled:=true;
    gridcoluna.SetFocus;
  end;
end;

procedure TFGrades.bGravarClick(Sender: TObject);
var s,m:string;
    p:integer;
begin
  Dtgrid1.Enabled:=false;s:='';m:='';
  for p:=0 to Gridlinha.ColCount-1 do begin
    if Gridlinha.Cells[p,0]<>'' then
      s:=s+strzero(strtoint(trim(Gridlinha.Cells[p,0])),3)+';'
    else
      break;
  end;
  for p:=0 to GridColuna.ColCount-1 do begin
    if GridColuna.Cells[p,0]<>'' then
      m:=m+strzero(strtoint(trim(GridColuna.Cells[p,0])),3)+';'
    else
      break;
  end;
  Arq.TGrades.Edit;
  Arq.TGrades.FieldByName('grad_linha').AsString:=strspace(s,100);
  Arq.TGrades.FieldByName('grad_coluna').AsString:=strspace(m,100);
  Arq.TGrades.Post;
  Arq.TGrades.Commit;
  Grid.Enabled:=true;
  GridLinha.Enabled:=false;
  Grid.SetFocus;

end;

procedure TFGrades.EdGrad_codigocolunaExitEdit(Sender: TObject);
begin
  EdGrad_Usua_codigo.SetValue(Global.Usuario.Codigo);
  Grid.postinsert(EdGrad_codigo);

end;

procedure TFGrades.EdGrad_codigocolunaValidate(Sender: TObject);
begin
  if EdGrad_codigocoluna.AsInteger=EdGrad_codigolinha.AsInteger then
    EdGrad_codigocoluna.Invalid('Codigo para a coluna tem que ser diferente do da linha');
  Codigocoluna:=EdGrad_codigocoluna.AsInteger;
  Validatabelas(EdGRad_codigocoluna.AsInteger,'C');
end;

procedure TFGrades.GridlinhaKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then begin
//    if not Sonumeros(Gridlinha.Cells[Gridlinha.Col,Gridlinha.Row]) then begin
//      Avisoerro('Digitar somente números');
//      exit;
//    end;
   ativaeditlinha;
  end  else
    Avisoerro('Teclar enter para colocar informações');

end;

procedure TFGrades.EdGrad_codigolinhaValidate(Sender: TObject);
begin
  CodigoLinha:=EdGRad_codigo.AsInteger;
  Validatabelas(EdGRad_codigolinha.AsInteger,'L');

end;

procedure TFGrades.EdGradeValidate(Sender: TObject);
var Q:TSqlquery;
begin
//  if not Sonumeros(Gridlinha.Cells[Gridlinha.Col,Gridlinha.Row]) then begin
  if not Sonumeros(EdGrade.Text) then begin
      Avisoerro('Digitar somente números');
      exit;
  end;
  if EdGRade.AsInteger>0 then begin
    Q:=sqltoquery('select * from '+Tabelalinha+' where '+Campocodigolinha+' = '+EdGrade.Text);
    if Q.FieldByName(campocodigolinha).AsInteger = 0 then
      EdGrade.Invalid('Não encontrado')
    else begin
      Gridlinha.Cells[Gridlinha.Col,Gridlinha.Row]:=strspace(Q.FieldByName(campocodigolinha).AsString,3);
      if codigolinha=1 then
        DtGrid1.Cells[0,Gridlinha.Col+1]:=FTamanhos.GetDescricao(Q.FieldByName(campocodigolinha).AsInteger)
      else
        DtGrid1.Cells[0,Gridlinha.Col+1]:=FCores.GetDescricao(Q.FieldByName(campocodigolinha).AsInteger);
    end;
    Q.free;
  end else begin
     DtGrid1.Cells[0,Gridlinha.Col+1]:='';
     Gridlinha.Cells[Gridlinha.Col,Gridlinha.Row]:=EDGrade.Text;
  end;
  Desativaeditlinha;
end;

procedure TFGrades.GridNewRecord(Sender: TObject);
begin
  EdGrad_codigo.GetFields(FGrades,99);
//  Linhatogrid(Arq.TGrades.fieldbyname('grad_linha').AsString);
  Codigolinha:=EdGrad_codigolinha.AsInteger;
  Codigocoluna:=EdGrad_codigocoluna.AsInteger;
  if Grid.Enabled then begin
    Linhatogrid(EdGrad_linha.Text);
    Colunatogrid(EdGrad_coluna.Text);
  end;
end;

procedure TFGrades.Linhatogrid(Codigos: string);
var p,c:integer;
begin
  c:=0;
  if trim(codigos)<>'' then begin
    for p:=1 to Gridlinha.ColCount do begin
      Gridlinha.Cells[c,0]:='';
      DtGrid1.Cells[0,c+1]:='';
      inc(c)
    end;
    c:=0;
    for p:=1 to length(Codigos) do begin
      if copy(codigos,p,1)=';' then begin
        Gridlinha.Cells[c,0]:=copy(codigos,p-3,3);
        if codigolinha=1 then
          DtGrid1.Cells[0,c+1]:=FTamanhos.GetDescricao(strtoint(Gridlinha.Cells[c,0]))
        else
          DtGrid1.Cells[0,c+1]:=FCores.GetDescricao(strtoint(Gridlinha.Cells[c,0]));
        inc(c);
      end;
    end;
  end else begin
    for p:=1 to Gridlinha.ColCount do begin
      Gridlinha.Cells[c,0]:='';
      DtGrid1.Cells[0,c+1]:='';
      inc(c)
    end;
  end;

end;

procedure TFGrades.Colunatogrid(Codigos: string);
var p,c:integer;
begin
  c:=0;
  if trim(codigos)<>'' then begin
    for p:=1 to GridColuna.ColCount do begin
      GridColuna.Cells[c,0]:='';
      DtGrid1.Cells[c+1,0]:='';
      inc(c)
    end;
    c:=0;
    for p:=1 to length(Codigos) do begin
      if copy(codigos,p,1)=';' then begin
        GridColuna.Cells[c,0]:=copy(codigos,p-3,3);
        if codigocoluna=1 then
          DtGrid1.Cells[c+1,0]:=FTamanhos.GetDescricao(strtoint(Gridcoluna.Cells[c,0]))
        else
          DtGrid1.Cells[c+1,0]:=FCores.GetDescricao(strtoint(Gridcoluna.Cells[c,0]));
        inc(c);
      end;
    end;
  end else begin
    for p:=1 to GridColuna.ColCount do begin
      GridColuna.Cells[c,0]:='';
      DtGrid1.Cells[c+1,0]:='';
      inc(c)
    end;
  end;

end;

procedure TFGrades.bCancelarClick(Sender: TObject);
begin
  Grid.Enabled:=true;
  Gridlinha.enabled:=false;
  Gridcoluna.enabled:=false;
  Grid.Refresh;
  Grid.setfocus;
end;

procedure TFGrades.GridcolunaKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then begin
   ativaeditcoluna;
  end  else begin
    Avisoerro('Teclar enter para colocar informações');
    Gridcoluna.SetFocus;
  end;

end;

procedure TFGrades.EdGradeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then EdGrade.Cancel;
end;

procedure TFGrades.EdGrade1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then EdGrade1.Cancel;

end;

procedure TFGrades.EdGrade1Validate(Sender: TObject);
var Q:TSqlquery;
begin
  if not Sonumeros(EdGrade1.Text) then begin
      Avisoerro('Digitar somente números');
      exit;
  end;
  if EdGRade1.AsInteger>0 then begin
    Q:=sqltoquery('select * from '+TabelaColuna+' where '+Campocodigocoluna+' = '+EdGrade1.Text);
    if Q.FieldByName(campocodigocoluna).AsInteger = 0 then
      EdGrade1.Invalid('Não encontrado')
    else begin
      Gridcoluna.Cells[Gridcoluna.Col,Gridcoluna.Row]:=strspace(Q.FieldByName(campocodigocoluna).AsString,3);
      if codigocoluna=1 then
        DtGrid1.Cells[Gridcoluna.Col+1,0]:=FTamanhos.GetDescricao(Q.FieldByName(campocodigocoluna).AsInteger)
      else
        DtGrid1.Cells[Gridcoluna.Col+1,0]:=FCores.GetDescricao(Q.FieldByName(campocodigocoluna).AsInteger);
    end;
    Q.free;
  end else begin
    DtGrid1.Cells[Gridcoluna.Col+1,0]:='';
    Gridcoluna.Cells[Gridcoluna.Col,Gridcoluna.Row]:=EDGrade.Text;
  end;
  Desativaeditcoluna;
end;

procedure TFGrades.GridcolunaClick(Sender: TObject);
begin
   ativaeditcoluna;

end;

procedure TFGrades.GridlinhaDblClick(Sender: TObject);
begin
   ativaeditlinha;

end;

function TFGrades.Getcodigocoluna(Codigo: integer): integer;
begin
  Result:=0;
  if Codigo>0 then begin
    if not Arq.TGrades.Active then Arq.TGrades.Open;
    if Arq.TGrades.Locate('grad_codigo',Codigo,[]) then Result:=Arq.TGrades.FieldByName('Grad_Codigocoluna').AsInteger;
  end;

end;

function TFGrades.Getcodigolinha(Codigo: integer): integer;
begin
  Result:=0;
  if Codigo>0 then begin
    if not Arq.TGrades.Active then Arq.TGrades.Open;
    if Arq.TGrades.Locate('grad_codigo',Codigo,[]) then Result:=Arq.TGrades.FieldByName('Grad_Codigolinha').AsInteger;
  end;

end;

function TFGrades.Getcodigoscoluna(Codigo: integer): string;
begin
  Result:='';
  if Codigo>0 then begin
    if not Arq.TGrades.Active then Arq.TGrades.Open;
    if Arq.TGrades.Locate('grad_codigo',Codigo,[]) then Result:=Arq.TGrades.FieldByName('Grad_coluna').AsString;
  end;

end;

function TFGrades.Getcodigoslinha(Codigo: integer): string;
begin
  Result:='';
  if Codigo>0 then begin
    if not Arq.TGrades.Active then Arq.TGrades.Open;
    if Arq.TGrades.Locate('grad_codigo',Codigo,[]) then Result:=Arq.TGrades.FieldByName('Grad_linha').AsString;
  end;

end;


procedure TFGrades.bExcluirClick(Sender: TObject);
begin
   showmessage('veriricar se a grade está atribuida a algum produto');
end;

end.
