unit tiposnotas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel, CheckLst;

type
  TFTiposNotas = class(TForm)
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
    EdTipn_codigo: TSQLEd;
    EdTipn_descricao: TSQLEd;
    pincidencias: TSQLPanelGrid;
    CBTopicos: TCheckListBox;
    bgrava: TSQLBtn;
    procedure bIncluirClick(Sender: TObject);
    procedure EdTipn_descricaoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bgravaClick(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure SetaTopicos(codigo:integer);
    function TopicostoString:string;
    function GetIncidencias(codigo:integer):Pointer;

  end;


Type TCalcula=record
     CalcPis,CalcCofins,CalcCsl,CalcIR,CalcInss,CalcIss,CalcInss50:string
end;


var
  FTiposNotas: TFTiposNotas;
  s:string;
  PCalcula:^TCalcula;
// 03.03.09

implementation

uses SQLRel, Arquiv, Sqlfun, SqlExpr, Geral,SqlSis;

{$R *.dfm}

{ TFTiposNotas }

procedure TFTiposNotas.Execute;
begin
  Show;
  SetaTopicos(Arq.TTiposNota.fieldbyname('tipn_codigo').asinteger);
end;

procedure TFTiposNotas.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdTipn_codigo);
  EdTipn_codigo.text:= strzero(  FGeral.GetSequencial(1,'tipn_codigo','C','tiposnota') ,EdTipn_codigo.MaxLength);

end;

procedure TFTiposNotas.EdTipn_descricaoExitEdit(Sender: TObject);
begin
   Grid.PostInsert(EdTipn_codigo);
   EdTipn_codigo.text:= strzero(  FGeral.GetSequencial(1,'tipn_codigo','C','tiposnota') ,Edtipn_codigo.MaxLength);

end;

procedure TFTiposNotas.bRelatorioClick(Sender: TObject);
begin
   FRel.Reportfromsql('select * from tiposnota order by tipn_descricao','Cadastro de Tipos de Notas de Mão de Obra','Relação de Tipos de Notas de Mão de Obra');

end;

procedure TFTiposNotas.FormActivate(Sender: TObject);
begin
  if not Arq.TTiposNota.Active then Arq.TTiposNota.open;

end;

procedure TFTiposNotas.SetaTopicos(codigo:integer);

    procedure Inicializar;
    var Q:TSqlQuery;
        i,p:Integer;
        s:String;
    begin
      Q:=SqlToQuery('SELECT tipn_incidencias FROM Tiposnota where tipn_codigo='+inttostr(codigo));
      if not Q.eof then begin
        s:=strspace(Q.FieldByName('tipn_incidencias').AsString,100);
  //      StrTopicos:=s;
        for i:=0 to CBTopicos.Items.Count-1 do begin
            p:=Inteiro(LeftStr(CBTopicos.Items[i],4));
            CBTopicos.Checked[i]:=s[p]='S';
        end;
      end;
      Q.Close;Q.Free;
      CBTopicos.ItemIndex:=0;
    end;

begin
  CbTopicos.Items.Clear;
  CBTopicos.Items.Add('01 - Calcula Pis');
  CBTopicos.Checked[0]:=false;
  CBTopicos.Items.Add('02 - Calcula Cofins');
  CBTopicos.Checked[1]:=false;
  CBTopicos.Items.Add('03 - Calcula CSL');
  CBTopicos.Checked[2]:=false;
  CBTopicos.Items.Add('04 - Calcula IR');
  CBTopicos.Checked[3]:=false;
  CBTopicos.Items.Add('05 - Calcula INSS - 100%');
  CBTopicos.Checked[4]:=false;
  CBTopicos.Items.Add('06 - Calcula ISS');
  CBTopicos.Checked[5]:=false;
  CBTopicos.Items.Add('07 - Calcula INSS - 50%');
  CBTopicos.Checked[6]:=false;
  Inicializar;

end;

procedure TFTiposNotas.bgravaClick(Sender: TObject);
begin
  Sistema.Edit('tiposnota');
  Sistema.setfield('tipn_incidencias',TopicostoString);
  Sistema.post('tipn_codigo='+Arq.TTiposNota.fieldbyname('tipn_codigo').asstring);
  Sistema.commit;
  Arq.TTiposNota.Refresh;
end;

function TFTiposNotas.TopicostoString: string;
var s:string;
    i,p:integer;
begin
  s:=Replicate('N',100);
        for i:=0 to CBTopicos.Items.Count-1 do begin
            p:=Inteiro(LeftStr(CBTopicos.Items[i],4));
            if CBTopicos.Checked[i] then
              s[p]:='S';
        end;
  result:=s;
end;

function TFTiposNotas.GetIncidencias(codigo:integer): Pointer;
var s:string;
    Q:TSqlquery;
begin
  Q:=SqlToQuery('SELECT tipn_incidencias FROM Tiposnota where tipn_codigo='+inttostr(codigo));
  New(PCalcula);
  if not Q.eof then
    s:=strspace(Q.FieldByName('tipn_incidencias').AsString,100)
  else
    s:=Replicate('N',100);
  Q.Close;Q.Free;
   PCalcula.CalcPis:=copy(s,01,1);
   PCalcula.CalcCofins:=copy(s,02,1);
   PCalcula.CalcCsl:=copy(s,03,1);
   PCalcula.CalcIR:=copy(s,04,1);
   PCalcula.CalcInss:=copy(s,05,1);
   PCalcula.CalcIss:=copy(s,06,1);
   PCalcula.CalcInss50:=copy(s,07,1);
  result:=PCalcula;
end;


procedure TFTiposNotas.GridNewRecord(Sender: TObject);
begin
  SetaTopicos(Arq.TTiposNota.fieldbyname('tipn_codigo').asinteger);

end;

end.
