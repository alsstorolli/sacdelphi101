unit Hist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, ExtCtrls, Buttons, SQLBtn,
  StdCtrls, alabel, Mask, SQLEd;

type
  TFHistoricos = class(TForm)
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
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    PEdits: TSQLPanelGrid;
    Grid: TSQLGrid;
    DSHist: TDataSource;
    EdHist_codigo: TSQLEd;
    EdHist_descricao: TSQLEd;
    EdHist_complemento: TSQLEd;
    bRestaurar: TSQLBtn;
    procedure bIncluirClick(Sender: TObject);
    procedure EdHist_complementoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdHist_codigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open;
    function GetDescricao(Codigo:Integer):String;
    function GetComplemento(Codigo:Integer):String;
    function SetaComplemento(EditComplemento:TSqlEd;CodHist:integer;CodUnidade,NumeroDcto,CodEspecie:String;DataMvto,DataContabil:TDateTime;Entidade:String=''):String;
    function GetHistorico(Codigo:integer;Complemento:String=''):String;
  end;

var
  FHistoricos: TFHistoricos;


implementation

uses Arquiv, SQLRel,SqlSis,SqlFun,SqlExpr, Geral;

{$R *.dfm}

procedure TFHistoricos.FormActivate(Sender: TObject);
begin
  if not Arq.THistoricos.Active then Arq.THistoricos.Open;
  Fgeral.ColunasGrid(Grid,Self);
end;

procedure TFHistoricos.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdHist_Codigo);
end;

procedure TFHistoricos.EdHist_complementoExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdHist_Codigo);
end;

procedure TFHistoricos.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('CadHist','Relação Dos Históricos Cadastrados','','');
  Frel.Reportfromsql('select * from historicos','CadHist','Relação Dos Históricos Cadastrados');
end;

function TFHistoricos.GetDescricao(Codigo:Integer):String;
begin
  Result:='';
  if Codigo>0 then begin
    if not Arq.THistoricos.Active then Arq.THistoricos.Open;
    if Arq.THistoricos.Locate('Hist_Codigo',Codigo,[]) then Result:=Arq.THistoricos.FieldByName('Hist_Descricao').AsString;
  end;
end;

procedure TFHistoricos.Open;
begin
  if not Arq.THistoricos.Active then Arq.THistoricos.Open;
end;

function TFHistoricos.GetComplemento(Codigo:Integer):String;
begin
  Result:='';
  if Codigo>0 then begin
    if not Arq.THistoricos.Active then Arq.THistoricos.Open;
    if Arq.THistoricos.Locate('Hist_Codigo',Codigo,[]) then Result:=Arq.THistoricos.FieldByName('Hist_Complemento').AsString;
  end;
end;


function TFHistoricos.SetaComplemento(EditComplemento:TSqlEd;CodHist:integer;CodUnidade,NumeroDcto,CodEspecie:String;DataMvto,DataContabil:TDateTime;Entidade:String=''):String;
var c:String;

    function GetNomeEntidade(NR:String):String;
    var Codigo:Integer;
        Cat:String;
    begin
      Cat:='';
      if Pos('Forn',Entidade)>0 then Cat:='F';
      if Pos('Cliente',Entidade)>0 then Cat:='C';
      if Pos('Func',Entidade)>0 then Cat:='I';
      if Pos('CNPJ',Entidade)>0 then Cat:='J';
      if (Cat='F') or (Cat='I') or (Cat='C') then begin
         Codigo:=Inteiro(StrToStrNumeros(Entidade));
         Result:=FGeral.GetNomeRazaoSocialEntidade(Codigo,Cat,NR);
      end;
      if Cat='J' then Result:=Entidade;
    end;

    function Substitui(const s,so,sd:String):String;
    var p:integer;
    begin
      Result:=s;
      repeat
        p:=Pos(so,Result);
        if p>0 then begin
           Delete(Result,p,Length(so));
           Insert(sd,Result,p);
        end;
      until p=0;
    end;

    function ProcessaMacros(c:String):String;
    begin
      Result:=c;
      Result:=Substitui(Result,'#001',NumeroDcto);
      Result:=Substitui(Result,'#002',CodUnidade);
      Result:=Substitui(Result,'#003',CodEspecie);
      Result:=Substitui(Result,'#004',Entidade);
      Result:=Substitui(Result,'#005',GetNomeEntidade('N'));
      Result:=Substitui(Result,'#006',GetNomeEntidade('R'));
      Result:=Substitui(Result,'#020',DateToStr_(DataMvto));
      Result:=Substitui(Result,'#021',StrZero(DateToMes(DataMvto),2));
      Result:=Substitui(Result,'#022',StrZero(DateToMes(DataMvto),2)+'/'+RightStr(DateToStr_(DataMvto),2));
      Result:=Substitui(Result,'#030',DateToStr_(DataContabil));
      Result:=Substitui(Result,'#031',StrZero(DateToMes(DataContabil),2));
      Result:=Substitui(Result,'#032',StrZero(DateToMes(DataContabil),2)+'/'+RightStr(DateToStr_(DataContabil),2));
    end;

begin
  if CodHist>0 then begin
     if not Arq.THistoricos.Active then Arq.THistoricos.Open;
     if Arq.THistoricos.Locate('Hist_Codigo',CodHist,[]) then begin
        c:=Trim(Arq.THistoricos.FieldByName('Hist_Complemento').AsString)+' ';
        Result:=ProcessaMacros(c);
        if EditComplemento<>nil then begin
           EditComplemento.TagStr:=c;
           if Trim(EditComplemento.Text)='' then begin
               EditComplemento.Text:=Result;
               EditComplemento.SetPosCursor(Length(Result));
            end;
        end;
     end;
  end;
end;


procedure TFHistoricos.bExcluirClick(Sender: TObject);
var Cod:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,Msg:String):Boolean;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM '+Tabela+' WHERE '+Campo+'='+Cod);
      Result:=Q.FieldByName('Registros').AsInteger>0;
      if Result then AvisoErro('Encontrado(s) lançamentos com o histórico; selecionado na tabela: '+Msg);
      Q.Close;Q.Free;
    end;


begin
  Cod:=StringToSql(Arq.THistoricos.FieldByName('Hist_Codigo').AsString);
  Found:=FoundTabela('Movfin','Movf_Hist_codigo','Movimento Financeiro');
//  if not Found then Found:=FoundTabela('Documentos','Dcto_Hist_Codigo','Cadastro De Documentos');
  if not Found then Grid.Delete;
end;

function TFHistoricos.GetHistorico(Codigo:integer;Complemento:String=''):String;
begin
  Result:=Complemento;
  if Codigo>0 then begin
    if not Arq.THistoricos.Active then Arq.THistoricos.Open;
    if Arq.THistoricos.Locate('Hist_Codigo',Codigo,[]) then Result:=Trim(Arq.THistoricos.FieldByName('Hist_Descricao').AsString)+' '+Trim(Complemento);
  end;
end;



procedure TFHistoricos.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  FGeral.LiberaCadastro(Grid);
end;

procedure TFHistoricos.EdHist_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
//  FGeral.Limpaedit(EdHist_codigo,key);
end;

end.
