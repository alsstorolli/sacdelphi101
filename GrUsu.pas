unit GrUsu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, SQLEd, DB, Grids, DBGrids, SQLGrid,
  ExtCtrls, Buttons, SQLBtn, alabel, ImgList,Menus;

type
  TFGrUsuarios = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bAlterar: TSQLBtn;
    bExcluir: TSQLBtn;
    bCancelar: TSQLBtn;
    bSair: TSQLBtn;
    bRestaurar: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    PEdits: TSQLPanelGrid;
    Grid: TSQLGrid;
    DSCadastro: TDataSource;
    EdGusu_codigo: TSQLEd;
    EdGusu_descricao: TSQLEd;
    Imagens: TImageList;
    bGravar: TSQLBtn;
    bGrade: TSQLBtn;
    BTopicos: TSQLBtn;
    Page: TPageControl;
    PgAcessos1: TTabSheet;
    Panel4: TPanel;
    Topicos1: TTreeView;
    PgAcessos2: TTabSheet;
    Panel3: TPanel;
    Topicos2: TTreeView;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdGusu_descricaoExitEdit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure Topicos1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Topicos2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bGravarClick(Sender: TObject);
    procedure PageChange(Sender: TObject);
    procedure bGradeClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure BTopicosClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure Atualizar;
  public
    { Public declarations }
    procedure CriaTopico1(n,p:Integer;o:TComponent);
    procedure CriaTopico2(n,p:Integer;s:String);
    procedure TopicosTelaCheia(Tit:String;Topic:TTreeView);
    procedure TopicosKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
  end;

var FGrUsuarios: TFGrUsuarios;

implementation

uses Arquiv, Menuinicial,SqlFun,SqlExpr,geral;

{$R *.dfm}


type TTop=record
     Obj:TComponent;
     Nivel,Posicao:Integer;
     Acesso:Boolean;
end;
type TPTop=^TTop;

var Top1,Top2:TList;PTop:TPTop;
    n11,n12,n13,n14,n15:Integer;
    n21,n22,n23,n24,n25:Integer;


procedure TFGrUsuarios.FormActivate(Sender: TObject);
begin
  if not Arq.TGrUsuarios.Active then begin
     Arq.TGrUsuarios.Open;
     Page.ActivePage:=PgAcessos1;
  end;
  Fgeral.ColunasGrid(Grid,Self);
end;

procedure TFGrUsuarios.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdGusu_Codigo);
end;

procedure TFGrUsuarios.EdGusu_descricaoExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdGusu_Codigo);
end;

procedure TFGrUsuarios.CriaTopico1(n,p:Integer;o:TComponent);
var pp:integer;
    s:String;
begin
  New(PTop);
  PTop^.Obj:=o;
  PTop^.Nivel:=n;
  PTop^.Posicao:=p;
  Top1.Add(PTop);
  if o is TMenuItem then s:=TMenuItem(O).Caption;
  if o is TSqlBtn then s:=TSqlBtn(O).Caption;
  pp:=Pos('&',s);if pp>0 then Delete(s,pp,1);
  if n=0 then begin
     Topicos1.Items.AddChildFirst(nil,s);
  end else if n=1 then begin
     Topicos1.Items.Add(Topicos1.Items[0],s);
     n11:=Topicos1.Items.Count-1;
  end else if n=2 then begin
     Topicos1.Items.AddChild(Topicos1.Items[n11],s);
     n12:=Topicos1.Items.Count-1;
  end else if n=3 then begin
     Topicos1.Items.AddChild(Topicos1.Items[n12],s);
     n13:=Topicos1.Items.Count-1;
  end else if n=4 then begin
     Topicos1.Items.AddChild(Topicos1.Items[n13],s);
     n14:=Topicos1.Items.Count-1;
  end else if n=5 then begin
     Topicos1.Items.AddChild(Topicos1.Items[n14],s);
     n15:=Topicos1.Items.Count-1;
  end else if n=6 then begin
     Topicos1.Items.AddChild(Topicos1.Items[n15],s);
  end;
  Topicos1.Items[Topicos1.Items.Count-1].ImageIndex:=0;
  Topicos1.Items[Topicos1.Items.Count-1].SelectedIndex:=0;
end;

procedure TFGrUsuarios.CriaTopico2(n,p:Integer;s:String);
begin
  New(PTop);
  PTop^.Obj:=nil;
  PTop^.Nivel:=n;
  PTop^.Posicao:=p;
  Top2.Add(PTop);
  if n=0 then begin
     Topicos2.Items.AddChildFirst(nil,s);
     n21:=Topicos2.Items.Count-1;
  end else if n=1 then begin
     Topicos2.Items.Add(Topicos2.Items[0],s);
     n21:=Topicos2.Items.Count-1;
  end else if n=2 then begin
     Topicos2.Items.AddChild(Topicos2.Items[n21],s);
     n22:=Topicos2.Items.Count-1;
  end else if n=3 then begin
     Topicos2.Items.AddChild(Topicos2.Items[n22],s);
     n23:=Topicos2.Items.Count-1;
  end else if n=4 then begin
     Topicos2.Items.AddChild(Topicos2.Items[n23],s);
     n24:=Topicos2.Items.Count-1;
  end else if n=5 then begin
     Topicos2.Items.AddChild(Topicos2.Items[n24],s);
     n25:=Topicos2.Items.Count-1;
  end else if n=6 then begin
     Topicos2.Items.AddChild(Topicos2.Items[n25],s);
  end;
  Topicos2.Items[Topicos2.Items.Count-1].ImageIndex:=0;
  Topicos2.Items[Topicos2.Items.Count-1].SelectedIndex:=0;
end;


procedure TFGrUsuarios.FormCreate(Sender: TObject);
begin
  Top1:=TList.Create;
  Top2:=TList.Create;
  Page.ActivePage:=PgAcessos1;
end;

procedure TFGrUsuarios.FormDestroy(Sender: TObject);
begin
  Top1.Free;
  Top2.Free;
end;

procedure TFGrUsuarios.Atualizar;
var t,p:integer;
    s:String;
begin
  s:=Arq.TGrUsuarios.FieldByName('Grus_ObjetosAcessados').AsString;
  s:=StrSpace(s,4000);
  for t:=0 to Topicos1.Items.Count-1 do begin
      PTop:=Top1.Items[t];
      PTop^.Acesso:=s[PTop^.Posicao]='S';
      if PTop^.Acesso then p:=1 else p:=0;
      Topicos1.Items[t].ImageIndex:=p;
      Topicos1.Items[t].SelectedIndex:=p;
  end;
  s:=Arq.TGrUsuarios.FieldByName('Grus_OutrosAcessos').AsString;
  s:=StrSpace(s,4000);
  for t:=0 to Topicos2.Items.Count-1 do begin
      PTop:=Top2.Items[t];
      PTop^.Acesso:=s[PTop^.Posicao]='S';
      if PTop^.Acesso then p:=1 else p:=0;
      Topicos2.Items[t].ImageIndex:=p;
      Topicos2.Items[t].SelectedIndex:=p;
  end;
  Arq.TGrUsuarios.GetFields(Self,3);
end;

procedure TFGrUsuarios.GridNewRecord(Sender: TObject);
begin
  Atualizar;
end;

procedure TFGrUsuarios.Topicos1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var Acesso:Boolean;
    i:integer;

    procedure Seta(n:TTreeNode);
    var p:integer;
    begin
      p:=n.AbsoluteIndex;
      PTop:=Top1.Items[p];
      PTop^.Acesso:=not PTop^.Acesso;
      if PTop^.Acesso then p:=1 else p:=0;
      Acesso:=PTop^.Acesso;
      n.ImageIndex:=p;
      n.SelectedIndex:=p;
    end;

    procedure SetaSubTopico(n:TTreeNode);
    var p:integer;
    begin
      p:=n.AbsoluteIndex;
      PTop:=Top1.Items[p];
      PTop^.Acesso:=Acesso;
      if PTop^.Acesso then p:=1 else p:=0;
      n.ImageIndex:=p;
      n.SelectedIndex:=p;
    end;

begin
  if Key=13 then begin
     if ssCtrl in Shift then begin
        Seta(Topicos1.Selected);
        for i:=0 to Topicos1.Items.Count-1 do begin
            if Topicos1.Items[i].Parent=Topicos1.Selected then SetaSubTopico(Topicos1.Items[i]);
        end;
     end else begin
        Seta(Topicos1.Selected);
     end;
  end;
  Application.ProcessMessages;
  Topicos1.Refresh;
end;


procedure TFGrUsuarios.Topicos2KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var i:integer;
    Acesso:Boolean;

    procedure Seta(n:TTreeNode);
    var p:integer;
    begin
      p:=n.AbsoluteIndex;
      PTop:=Top2.Items[p];
      PTop^.Acesso:=not PTop^.Acesso;
      if PTop^.Acesso then p:=1 else p:=0;
      Acesso:=PTop^.Acesso;
      n.ImageIndex:=p;
      n.SelectedIndex:=p;
    end;

    procedure SetaSubTopico(n:TTreeNode);
    var p:integer;
    begin
      p:=n.AbsoluteIndex;
      PTop:=Top2.Items[p];
      PTop^.Acesso:=Acesso;
      if PTop^.Acesso then p:=1 else p:=0;
      n.ImageIndex:=p;
      n.SelectedIndex:=p;
    end;

begin
  if Key=13 then begin
     if ssCtrl in Shift then begin
        Seta(Topicos2.Selected);
        for i:=0 to Topicos2.Items.Count-1 do begin
            if Topicos2.Items[i].Parent=Topicos2.Selected then SetaSubTopico(Topicos2.Items[i]);
        end;
     end else begin
        Seta(Topicos2.Selected);
     end;
  end;
  Application.ProcessMessages;
  Topicos2.Refresh;
end;

procedure TFGrUsuarios.bGravarClick(Sender: TObject);
var s1,s2:String;
    i:integer;
begin
  s1:=Space(4000);
  s2:=Space(4000);
  for i:=0 to Top1.Count-1 do begin
      PTop:=Top1.Items[i];
      if PTop^.Acesso then s1[PTop^.Posicao]:='S';
  end;
  for i:=0 to Top2.Count-1 do begin
      PTop:=Top2.Items[i];
      if PTop^.Acesso then s2[PTop^.Posicao]:='S';
  end;
  Arq.TGrUsuarios.Edit;
  Arq.TGrUsuarios.SetFields(Self,3);
  Arq.TGrUsuarios.FieldByName('Grus_ObjetosAcessados').AsString:=s1;
  Arq.TGrUsuarios.FieldByName('Grus_OutrosAcessos').AsString:=s2;
  Arq.TGrUsuarios.Post;
  Arq.TGrUsuarios.Commit;
  Grid.SetFocus;
end;

procedure TFGrUsuarios.PageChange(Sender: TObject);
begin
  if Page.ActivePage=PgAcessos1 then begin
     Topicos1.SetFocus;
     PMens.Caption:='Determina��o dos acessos � op��es de menus e bot�es';
  end;
  if Page.ActivePage=PgAcessos2 then begin
     Topicos2.SetFocus;
     PMens.Caption:='Determina��o dos acessos aos procedimentos';
  end;
end;

procedure TFGrUsuarios.bGradeClick(Sender: TObject);
begin
  Grid.SetFocus;
end;

procedure TFGrUsuarios.bExcluirClick(Sender: TObject);
var Q:TSqlQuery;
begin
  Q:=SqlToQuery('SELECT Count(*) AS Registros FROM Usuarios WHERE Usua_Grus_Codigo='+StringToSql(Arq.TGrUsuarios.FieldByName('Grus_Codigo').AsString));
  if Q.FieldByName('Registros').AsInteger>0 then begin
     AvisoErro('Encontrados usu�rios vinculados ao grupo selecionado');
  end else begin
     Grid.Delete;
  end;
  Q.Close;Q.Free;
end;


procedure TFGrUsuarios.TopicosTelaCheia(Tit:String;Topic:TTreeView);
var Form:TForm;
    Topicos:TTreeView;
    i:Integer;
begin
  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  Form.Caption := Tit;
  Form.Width:=FMain.Width-10;
  Form.Height:=FMain.Height;
  Form.Top:=0;
  Form.Left:=0;
  Topicos:=TTreeView.Create(Form);
  Topicos.Parent:=Form;
  Topicos.Align:=alClient;
  Topicos.Items.Assign(Topic.Items);
  Form.ActiveControl:=Topicos;
  Topicos.Images:=Imagens;
  Topicos.Font.Assign(Topic.Font);
  Topicos.Indent:=55;
  Topicos.OnKeyDown:=TopicosKeyDown;
  for i:=0 to Topicos.Items.Count-1 do Topicos.Items[i].Expanded:=True;
  Topicos.Selected:=Topicos.Items[0];
  Form.ShowModal;
  for i:=0 to Topicos.Items.Count-1 do begin
      Topic.Items[i].ImageIndex:=Topicos.Items[i].ImageIndex;
      Topic.Items[i].SelectedIndex:=Topicos.Items[i].SelectedIndex;
  end;
  Form.Free;
end;

procedure TFGrUsuarios.TopicosKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var i:integer;
    Acesso:Boolean;
    Top:TTreeView;

    procedure Seta(n:TTreeNode);
    var p:integer;
    begin
      p:=n.AbsoluteIndex;
      PTop:=Top1.Items[p];
      PTop^.Acesso:=not PTop^.Acesso;
      if PTop^.Acesso then p:=1 else p:=0;
      Acesso:=PTop^.Acesso;
      n.ImageIndex:=p;
      n.SelectedIndex:=p;
    end;

    procedure SetaSubTopico(n:TTreeNode);
    var p:integer;
    begin
      p:=n.AbsoluteIndex;
      PTop:=Top1.Items[p];
      PTop^.Acesso:=Acesso;
      if PTop^.Acesso then p:=1 else p:=0;
      n.ImageIndex:=p;
      n.SelectedIndex:=p;
    end;

begin
  if Key=32 then TForm(TTreeView(Sender).Owner).Close;
  if Key=27 then TForm(TTreeView(Sender).Owner).Close;
  if Key=13 then begin
     Top:=TTreeView(Sender);
     if ssCtrl in Shift then begin
        Seta(Top.Selected);
        for i:=0 to Top.Items.Count-1 do begin
            if Top.Items[i].Parent=Top.Selected then SetaSubTopico(Top.Items[i]);
        end;
     end else begin
        Seta(Top.Selected);
     end;
     Application.ProcessMessages;
     Topicos1.Refresh;
     TTreeView(Sender).Refresh;
  end;
end;




procedure TFGrUsuarios.BTopicosClick(Sender: TObject);
begin
  TopicosTelaCheia('Acesso 1 / '+Arq.TUsuarios.FieldByName('Usua_Nome').AsString,Topicos1);
end;

procedure TFGrUsuarios.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#32 then begin
     if Grid.Focused then BTopicos.ToClick;
     if Topicos1.Focused then BTopicos.ToClick;
     if Topicos2.Focused then BTopicos.ToClick;
  end;
end;

end.
