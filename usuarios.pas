unit Usuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, ExtCtrls, Buttons, SQLBtn,
  StdCtrls, alabel, Mask, SQLEd, ComCtrls,Menus, ImgList,SqlExpr,
  System.ImageList;

type
  TFUsuarios = class(TForm)
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
    bigualar: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    PEdits: TSQLPanelGrid;
    Grid: TSQLGrid;
    DSCadastro: TDataSource;
    EdUsua_codigo: TSQLEd;
    EdUsua_nome: TSQLEd;
    EdUsua_gusu_codigo: TSQLEd;
    EdUsua_unid_codigo: TSQLEd;
    EdUsua_senha: TSQLEd;
    EdUsua_datasenha: TSQLEd;
    Page: TPageControl;
    PgAcessos1: TTabSheet;
    Panel4: TPanel;
    Topicos1: TTreeView;
    PgAcessos2: TTabSheet;
    Panel3: TPanel;
    Topicos2: TTreeView;
    PgAcessos3: TTabSheet;
    Panel2: TPanel;
    bGravar: TSQLBtn;
    bGrade: TSQLBtn;
    Imagens: TImageList;
    EdUsua_unidadesmvto: TSQLEd;
    EdUsua_unidadesrelatorios: TSQLEd;
    BTopicos: TSQLBtn;
    EdUsua_senhasuper: TSQLEd;
    bliberavenda: TSQLBtn;
    EdUsua_email: TSQLEd;
    bliberacredito: TSQLBtn;
    brestricaocredito: TSQLBtn;
    Edimpressopedido: TSQLEd;
    SQLEd8: TSQLEd;
    EdUsua_ContasCaixaValidas: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdUsua_unid_codigoExitEdit(Sender: TObject);
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
    procedure bRelatorioClick(Sender: TObject);
    procedure EdUsua_contascaixavalidasKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure EdUsua_contascaixavalidasValidate(Sender: TObject);
    procedure EdUsua_tpdctosrelatoriosEnter(Sender: TObject);
    procedure BTopicosClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure bliberavendaClick(Sender: TObject);
    procedure bigualarClick(Sender: TObject);
    procedure bliberacreditoClick(Sender: TObject);
    procedure brestricaocreditoClick(Sender: TObject);
    procedure bPesquisarClick(Sender: TObject);
    procedure GridCellClick(Column: TColumn);
  private
    { Private declarations }
    procedure Atualizar;
    function GetUsuario(Codigo,Senha:String;Codigoatual:integer=0):Boolean;
    function TestaSenhaSuporte(s:Integer):Boolean;
    function CadastraSenha(Anterior:String;codusuario:string):Boolean;
    function CalcSenha(s:String):Integer;
  public
    { Public declarations }
    procedure CriaTopico1(n,p:Integer;o:TComponent);
    procedure CriaTopico2(n,p:Integer;s:String);
    procedure CriaTopicosAcessoObjetos;
    procedure CriaTopicosOutrosAcessos;
    function GetSenhaDiaria(Dt:TDateTime):Integer;
    function GetSenha:Boolean;
    function GetSenhaSupervisor:Boolean;
    procedure ProcessaAcessoObjetos;
    function GetSenhaTempo:Boolean;
    function GetNovoUsuario:Boolean;
    function TestaAcesso(Posicao:Integer):Boolean;
    function Acesso(Posicao:Integer):Boolean;
    function TestaInicioInstalacao:Boolean;
    procedure TopicosTelaCheia(Tit:String;Topic:TTreeView);
    procedure TopicosKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    function GetNome(Codigo:Integer):String;
    procedure SetaItems(Edit:TSqlEd);
    procedure AlteraSenha;
    function GetSenhaProcesso:Boolean;
    procedure GravaAcessando(s:String);
    function GetSenhaAutorizacao(posicao:integer):integer;
    function UsuarioProduto(Codigo:Integer):boolean;
// 23.05.11
    procedure GravaOutrosAcessos(posicao,usuario:integer;conteudo:string);
// 27.08.12
    function GetImpressoPedidoVenda(Codigo:Integer):String;

  end;

var
  FUsuarios: TFUsuarios;

implementation

uses Arquiv,SqlFun, Geral,SqlSis, GrUsu, Menuinicial, Unidades, Regioes,
  munic, Empresas, Natureza, Sittribu, represen, plano, cadcli, fornece,
  Hist, conpagto, portador, Feriados, Cadimp, cadcor, motivobl, tamanhos,
  grupos, Subgrupos, Grades, familias, Estoque , SQLRel, tabela, ConfMovi,
  Transp, material, Cotarepr, Mensnf, cadocor, Pedvenda, cadcopa, custos,
  codigosipi, Orcamento, Ocorrenc, Emitentes, precos, entabate, similares,
  BaixaPen, setores, nfsaida, ataspacao, regnaoconf, cadorcam,
  regnaoconfpend, requisicao, cadservicos, tiposnotas, boletos,
  indicadores, Pedcomp, tabcomissao, saldoestoque, colaboradores,
  expnfetxt, gerencianfe, RetConsi, nutricionais, ingredientes,
  conservacao, Lancapen, nfcompra, faixas, equipamentos, Ajustees,
  acertoses, Cadcheq, codigosfis, agenda, relcxban, expnfse, montagemcarga,
  lancamfin, baias, pesagemporcarga, montagemcargacte,pospedi, cadccustos,
  centroscusto, contratos, nftransf, contratosatu, telemarketing,
  tributacaoncm;

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
    SenhaSuporte:Array[1..100] of Integer;
    PosicaoTopico:Array[1..4000] of Boolean;
    campo: TDicionario;

procedure TFUsuarios.FormActivate(Sender: TObject);
///////////////////////////////////////////////////
begin
  campo:=Sistema.GetDicionario('usuarios','Usua_imppedido');
  if trim(campo.Tipo)='' then begin
    Edimpressopedido.TableName:='';
    Edimpressopedido.Enabled:=false;
  end else begin
    Edimpressopedido.Enabled:=true;
    Edimpressopedido.TableName:='usuarios';
  end;
  if not Arq.TUsuarios.Active then Arq.TUsuarios.Open;
  FGeral.ColunasGrid(Grid,Self);
  if EdUsua_unidadesmvto.Items.Count=0 then FUnidades.SetaItems(EdUsua_unidadesmvto,nil,'');
  if EdUsua_unidadesrelatorios.Items.Count=0 then FUnidades.SetaItems(EdUsua_unidadesrelatorios,nil,'');
// 29.10.15
  if EdUsua_ContasCaixaValidas.Items.Count=0 then FConfMovimento.SetaItems(EdUsua_ContascaixaValidas);
  bliberavenda.enabled:=Global.Usuario.OutrosAcessos[0037];
// 27.08.12
end;

procedure TFUsuarios.bIncluirClick(Sender: TObject);
begin
  EdUsua_unidadesmvto.ClearAll(Self,3);
  Grid.Insert(EdUsua_Codigo);
end;

procedure TFUsuarios.EdUsua_unid_codigoExitEdit(Sender: TObject);
var Q:TSqlQuery;
begin
  if not Arq.TGrUsuarios.Active then Arq.TGrUsuarios.Open;
  Q:=SqlToQuery('SELECT * FROM GrupoUsu WHERE Grus_Codigo='+EdUsua_gusu_codigo.AsSql);
  Arq.TUsuarios.Insert;
  Arq.TUsuarios.FieldByName('Usua_Codigo').AsString:=EdUsua_codigo.Text;
  Arq.TUsuarios.FieldByName('Usua_Nome').AsString:=EdUsua_Nome.Text;
  Arq.TUsuarios.FieldByName('Usua_Grus_Codigo').AsString:=EdUsua_Gusu_Codigo.Text;
  Arq.TUsuarios.FieldByName('Usua_Unid_Codigo').AsString:=EdUsua_Unid_Codigo.Text;
  Arq.Tusuarios.FieldByName('Usua_ObjetosAcessados').AsString:=Q.FieldByName('Grus_ObjetosAcessados').AsString;
  Arq.Tusuarios.FieldByName('Usua_OutrosAcessos').AsString:=Q.FieldByName('Grus_OutrosAcessos').AsString;
  Arq.TUsuarios.FieldByName('Usua_LimiteMaximo').AsFloat:=Q.FieldByName('Grus_LimiteMaximo').AsFloat;
  Arq.TUsuarios.FieldByName('Usua_DescontoMaximo').AsFloat:=Q.FieldByName('Grus_DescontoMaximo').AsFloat;
  Arq.TUsuarios.FieldByName('Usua_TpDctosRelatorios').AsString:=Q.FieldByName('Grus_TpDctosRelatorios').AsString;
  Arq.TUsuarios.FieldByName('Usua_TpDctosRelatorios').AsString:=Q.FieldByName('Grus_TpDctosRelatorios').AsString;
  Arq.TUsuarios.FieldByName('USUA_UNIDADESMVTO').AsString:=EdUsua_Unid_Codigo.Text;
  Arq.TUsuarios.FieldByName('USUA_UNIDADESRelatorios').AsString:=EdUsua_Unid_Codigo.Text;
  Arq.TUsuarios.Post;
  Arq.TUsuarios.Commit;
  Q.Close;Q.Free;
  EdUsua_unidadesmvto.ClearAll(Self,3);
  EdUsua_codigo.ClearAll(Self,99);
  Arq.TUsuarios.GetFields(Self,3);
end;


procedure TFUsuarios.CriaTopico1(n,p:Integer;o:TComponent);
//////////////////////////////////////////////////////////////
var s:String;
    pp:Integer;
begin
  New(PTop);
  PTop^.Obj:=o;
  PTop^.Nivel:=n;
  PTop^.Posicao:=p;
  Top1.Add(PTop);
  if PosicaoTopico[p] then ShowMessage('Posi��o Conflitante No Bloqueio De Objetos, No Cadastro De Usu�rios: '+IntToStr(p)+' /'+o.Name);
  PosicaoTopico[p]:=True;
  if o is TMenuItem then s:=TMenuItem(O).Caption;
  if o is TSqlBtn then s:=TSqlBtn(O).Caption;
  pp:=Pos('&',s);if pp>0 then Delete(s,pp,1);
  if n=0 then begin
     Topicos1.Items.AddChildFirst(nil,s);
     n11:=Topicos1.Items.Count-1;
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

procedure TFUsuarios.CriaTopico2(n,p:Integer;s:String);
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


procedure TFUsuarios.FormCreate(Sender: TObject);
var i:integer;
begin
  Top1:=TList.Create;
  Top2:=TList.Create;
  Page.ActivePage:=PgAcessos1;
  for i:=1 to 4000 do PosicaoTopico[i]:=False;
end;

procedure TFUsuarios.FormDestroy(Sender: TObject);
begin
  Top1.Free;
  Top2.Free;
end;


procedure TFUsuarios.Atualizar;
/////////////////////////////////////////////////
var t,p:integer;
    s:String;
begin
//  campo:=Sistema.GetDicionario('usuarios','Usua_imppedido');
  if trim(campo.Tipo)='' then begin
    Edimpressopedido.TableName:='';
    Edimpressopedido.Enabled:=false;
  end else begin
    Edimpressopedido.Enabled:=true;
    Edimpressopedido.TableName:='usuarios';
  end;
  s:=Arq.TUsuarios.FieldByName('Usua_ObjetosAcessados').AsString;
  s:=StrSpace(s,4000);
  for t:=0 to Topicos1.Items.Count-1 do begin
      PTop:=Top1.Items[t];
      PTop^.Acesso:=s[PTop^.Posicao]='S';
      if PTop^.Acesso then p:=1 else p:=0;
      Topicos1.Items[t].ImageIndex:=p;
      Topicos1.Items[t].SelectedIndex:=p;
  end;
  s:=Arq.TUsuarios.FieldByName('Usua_OutrosAcessos').AsString;
  s:=StrSpace(s,4000);
  for t:=0 to Topicos2.Items.Count-1 do begin
      PTop:=Top2.Items[t];
      PTop^.Acesso:=s[PTop^.Posicao]='S';
      if PTop^.Acesso then p:=1 else p:=0;
      Topicos2.Items[t].ImageIndex:=p;
      Topicos2.Items[t].SelectedIndex:=p;
  end;
  Arq.TUsuarios.GetFields(Self,3);
//  Topicos1.Repaint;
//  Topicos2.Repaint;
  Topicos1.Refresh;
  Topicos2.Refresh;
end;


// 03.01.17
procedure TFUsuarios.GridCellClick(Column: TColumn);
///////////////////////////////////////////////////////
begin
  Atualizar;
end;

procedure TFUsuarios.GridNewRecord(Sender: TObject);
begin
  Atualizar;
end;

procedure TFUsuarios.Topicos1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var i:integer;
    Acesso:Boolean;

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

procedure TFUsuarios.Topicos2KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
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

procedure TFUsuarios.bGravarClick(Sender: TObject);
var s1,s2:String;
    i:integer;
begin
  if not EdUsua_unidadesmvto.ValidEdiAll(Self,99) then Exit;
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
{
  Arq.TUsuarios.Edit;
  Arq.TUsuarios.SetFields(Self,3);
  Arq.TUsuarios.FieldByName('Usua_ObjetosAcessados').AsString:=s1;
  Arq.TUsuarios.FieldByName('Usua_OutrosAcessos').AsString:=s2;
  Arq.TUsuarios.Post;
  Arq.TUsuarios.Commit;
  }
// 17.10.08 - tentativa do erro de novo
  Sistema.Edit('usuarios');
  Sistema.SetField('usua_unidadesmvto',(EdUsua_unidadesmvto.text));
  Sistema.SetField('usua_unidadesrelatorios',(EdUsua_unidadesrelatorios.text));
  Sistema.SetField('usua_email',(EdUsua_email.text));
  Sistema.SetField('usua_senhasuper',EdUsua_senhasuper.AsInteger);
  Sistema.SetField('Usua_OutrosAcessos',s2);
  Sistema.SetField('Usua_objetosacessados',s1);
// 29.10.15
  Sistema.SetField('Usua_ContasCaixaValidas',EdUsua_ContasCaixaValidas.text);
// 27.08.12
  if trim(campo.Tipo)<>'' then
    Sistema.SetField('Usua_imppedido',Edimpressopedido.text);
  Sistema.Post('usua_codigo='+Arq.TUsuarios.fieldbyname('usua_codigo').asstring);
  Sistema.Commit;
  Arq.TUsuarios.Refresh;
/////////////////  Sistema.Commit;
// 15.04.04 - ver aquele erro podre quando grava usuario
// 03.10.08 - esta merda erro q ocorre 'as vezes' se refere o clientdatachu....
  FGeral.GravaLog(0020,'Usu�rio '+inttostr(Global.Usuario.Codigo)+' gravou ref. usu�rio '+Arq.TUsuarios.FieldByName('Usua_codigo').asstring);
  Grid.SetFocus;
end;

procedure TFUsuarios.PageChange(Sender: TObject);
begin
  if Page.ActivePage=PgAcessos1 then begin
     Topicos1.SetFocus;
     PMens.Caption:='Determina��o dos acessos � op��es de menus e bot�es';
  end;
  if Page.ActivePage=PgAcessos2 then begin
     Topicos2.SetFocus;
     PMens.Caption:='Determina��o dos acessos aos procedimentos';
  end;
  if Page.ActivePage=PgAcessos3 then EdUsua_unidadesmvto.SetFocus;
end;

procedure TFUsuarios.bGradeClick(Sender: TObject);
begin
  Grid.SetFocus;
end;



function TFUsuarios.GetSenha:Boolean;
//////////////////////////////////////
var Form: TForm;
    Edts,Edtc:TSqlEd;
    ContadorSenha:Integer;
    B:TBevel;
begin
  ContadorSenha:=0;
  Result:=False;
  Screen.Cursor:=crDefault;
  Global.SistemaParado:=True;
  while ContadorSenha<=2 do begin
    Inc(ContadorSenha);
    Result:=False;
    Form := TForm.Create(Application);
    with Form do begin
      BorderStyle := bsDialog;
      Caption := 'Usu�rio e Senha De Acesso';
      Color:=clCream;
      SetBounds(225,220,220,100);
      Position:=poScreenCenter;
      B:=TBevel.Create(Form);
      B.Align:=alClient;
      B.Parent:=Form;
      Edtc:=TSqlEd.Create(Form);
      with Edtc do begin
        Parent := Form;
        TypeValue:=tvInteger;
        TitlePos:=tppLeft;TitlePixels:=120;
        Title:='C�digo Do Usu�rio';
        TitleFont.Style:=[fsBold];
        SetBounds(135,10,55,25);
      end;
      Edts:=TSqlEd.Create(Form);
      with Edts do begin
        Parent := Form;
        PasswordChar:='*';
        CharCase:=ecUpperCase;
        MaxLength:=10;
        CloseForm:=True;
        TitlePos:=tppLeft;TitlePixels:=120;
        Title:='Senha Do Usu�rio';
        TitleFont.Style:=[fsBold];
        SetBounds(135,40,55,25);
      end;
      Form.ActiveControl:=Edtc;
      ShowModal;
      if Inteiro(Edtc.Text)=0 then begin
         Application.Terminate;
         Break;
      end;
      if not GetUsuario(Edtc.Text,Edts.Text) then begin
         if ContadorSenha=3 then begin
            AvisoErro('Acesso negado, o sistema ser� finalizado');
            Application.Terminate;
         end;
      end else begin
         Result:=True;
         Break;
      end;
    end;
    Form.Free;
  end;
  Global.SistemaParado:=False;
end;


procedure TFUsuarios.GravaAcessando(s:String);
///////////////////////////////////////////////
begin
  if Global.Usuario.Codigo<4001 then begin
{
     Sistema.Edit('Usuarios');
     Sistema.SetField('Usua_Acessando',s);
     Sistema.Post('Usua_Codigo='+IntToStr(Global.Usuario.Codigo));
     Sistema.Commit;
}
// 28.01.17 - delphi xe7
     Arq.TUsuarios.Edit;
     Arq.TUsuarios.FieldByName('Usua_Acessando').AsString:=s;
     Arq.TUsuarios.Post;
     Arq.TUsuarios.Commit;

  end;
end;

function TFUsuarios.CadastraSenha(Anterior:String;codusuario:string):Boolean;
var Form: TForm;
    Edt,Edt2:TSqlEd;
begin
  Result:=False;
  Form := TForm.Create(Application);
  Global.SistemaParado:=True;
  with Form do begin
    BorderStyle := bsDialog;
    Caption := 'Cadastramento De Senha';
    Color:=clCream;
    SetBounds(225,180,180,110);
    Position:=poScreenCenter;
    Edt:=TSqlEd.Create(Form);
    with Edt do begin
      Parent := Form;
      CharCase:=ecUpperCase;
      PasswordChar:='*';
      MinLength:=3;
      Empty:=False;
      MaxLength:=10;
      TitlePos:=tppLeft;TitlePixels:=110;
      TitleFont.Style:=[fsBold];
      Title:='Senha Do Usu�rio';
      SetBounds(115,10,50,25);
    end;
    Edt2:=TSqlEd.Create(Form);
    with Edt2 do begin
      Parent := Form;
      CharCase:=ecUpperCase;
      PasswordChar:='*';
      MinLength:=3;
      Empty:=False;
      MaxLength:=10;
      TitlePos:=tppLeft;TitlePixels:=110;
      TitleFont.Style:=[fsBold];
      Title:='Redigite a Senha';
      SetBounds(115,50,50,25);
      CloseForm:=True;
    end;
    ActiveControl:=Edt;
    ShowModal;
    if (Anterior<>'') and (Edt.Text=Anterior) then begin
       AvisoErro('Nova senha deve ser diferente da senha anterior');
    end else if Edt.Text<>Edt2.Text then begin
       AvisoErro('Senhas divergentes');
    end else begin
//////////////////////////
// 28.01.17 - delphi xe7 da erro no sistema.commit...vai entender..
{
       Arq.TUsuarios.Edit;
       Arq.TUsuarios.FieldByName('Usua_Senha').AsInteger:=CalcSenha(Edt.Text);
       Arq.TUsuarios.FieldByName('Usua_DataSenha').AsDateTime:=Sistema.Hoje;
       Arq.TUsuarios.Post;
       Arq.TUsuarios.Commit;
}
//////////////////////////
// 20.06.06 - 'bostex' no client data set...alterado
// 24.08.17 - realterado pois nao gravava a senha
//{
       Sistema.Edit('Usuarios');
       Sistema.setfield('usua_senha',CalcSenha(Edt.Text));
       Sistema.setfield('usua_datasenha',Sistema.hoje);
       Sistema.Post('Usua_Codigo='+codusuario);
       Sistema.commit;
//       }
       Result:=True;
    end;
    Form.Free;
  end;
  Global.SistemaParado:=False;
end;


procedure TFUsuarios.AlteraSenha;
var Form: TForm;
    Edt1,Edt2,Edt3:TSqlEd;
begin
  if (Global.Usuario.Suporte) or (Global.Usuario.SenhaDiaria) then begin
     AvisoErro('Usu�rio suporte, n�o permitida altera��o de senha');
     Exit;
  end;
  Form := TForm.Create(Application);
  Global.SistemaParado:=True;
  with Form do begin
    BorderStyle := bsDialog;
    Caption := 'Altera��o De Senha';
    Color:=clCream;
    SetBounds(225,180,220,150);
    Position:=poScreenCenter;
    Edt1:=TSqlEd.Create(Form);
    with Edt1 do begin
      Parent := Form;
      CharCase:=ecUpperCase;
      PasswordChar:='*';
      MinLength:=3;
      Empty:=False;
      MaxLength:=10;
      TitleFont.Style:=[fsBold];
      TitlePos:=tppLeft;TitlePixels:=140;
      Title:='Senha Atual';
      SetBounds(145,10,50,25);
    end;
    Edt2:=TSqlEd.Create(Form);
    with Edt2 do begin
      Parent := Form;
      CharCase:=ecUpperCase;
      PasswordChar:='*';
      MinLength:=3;
      Empty:=False;
      MaxLength:=10;
      TitlePos:=tppLeft;TitlePixels:=140;
      TitleFont.Style:=[fsBold];
      Title:='Nova Senha';
      SetBounds(145,50,50,25);
    end;
    Edt3:=TSqlEd.Create(Form);
    with Edt3 do begin
      Parent := Form;
      CharCase:=ecUpperCase;
      PasswordChar:='*';
      MinLength:=3;
      Empty:=False;
      MaxLength:=10;
      TitlePos:=tppLeft;TitlePixels:=140;
      TitleFont.Style:=[fsBold];
      Title:='Redigite a Nova Senha';
      SetBounds(145,90,50,25);
      CloseForm:=True;
    end;
    ActiveControl:=Edt1;
    ShowModal;
    if (not Edt1.isEmpty) and (not Edt2.IsEmpty) and (not Edt3.IsEmpty) then begin
       if Edt1.Text<>Global.Usuario.Senha then begin
          AvisoErro('Senha atual inv�lida');
       end else if Edt2.Text<>Edt3.Text then begin
          AvisoErro('Divergencia na senha redigitada');
       end else begin
          Sistema.Edit('Usuarios');
          Sistema.SetField('Usua_Senha',CalcSenha(Edt2.Text));
          Sistema.SetField('Usua_DataSenha',Sistema.Hoje);
          Sistema.Post('Usua_Codigo='+IntToStr(Global.Usuario.Codigo));
          Sistema.Commit;
          Global.Usuario.Senha:=Edt2.Text;
          Aviso('Senha alterada');
       end;
    end;
    Form.Free;
  end;
  Global.SistemaParado:=False;
end;




function TFUsuarios.GetNovoUsuario:Boolean;
var Form: TForm;
    Edts,Edtc:TSqlEd;
    ContadorSenha:Integer;
    B:TBevel;
begin
  Global.Usuario.Desenvolvimento:=False;
  GravaAcessando('N');
  ContadorSenha:=0;
  Result:=False;
  Screen.Cursor:=crDefault;
  Global.SistemaParado:=True;
  while ContadorSenha<=2 do begin
    Inc(ContadorSenha);
    Result:=False;
    Form := TForm.Create(Application);
    with Form do begin
      BorderStyle := bsDialog;
      Caption := 'Substitui��o De Usu�rio';
      SetBounds(225,220,220,100);
      Position:=poScreenCenter;
      B:=TBevel.Create(Form);
      B.Align:=alClient;
      Color:=clCream;
      B.Parent:=Form;
      Edtc:=TSqlEd.Create(Form);
      with Edtc do begin
        Parent := Form;
        TypeValue:=tvInteger;
        TitlePos:=tppLeft;TitlePixels:=120;
        Title:='C�digo Do Usu�rio';
        TitleFont.Style:=[fsBold];
        SetBounds(135,10,55,25);
      end;
      Edts:=TSqlEd.Create(Form);
      with Edts do begin
        Parent := Form;
        PasswordChar:='*';
        CharCase:=ecUpperCase;
        MaxLength:=10;
        CloseForm:=True;
        TitlePos:=tppLeft;TitlePixels:=120;
        Title:='Senha Do Usu�rio';
        TitleFont.Style:=[fsBold];
        SetBounds(135,40,55,25);
      end;
      Form.ActiveControl:=Edtc;
      ShowModal;
      if Inteiro(Edtc.Text)=0 then begin
         Application.Terminate;
         Break;
      end;
      if not GetUsuario(Edtc.Text,Edts.Text) then begin
         if ContadorSenha=3 then begin
            AvisoErro('Acesso negado, o sistema ser� finalizado');
            Application.Terminate;
         end;
      end else begin
         Result:=True;
         Break;
      end;
    end;
    Form.Free;
  end;
  Global.SistemaParado:=False;
  Global.MensagemPendente:=False;
  FGeral.AlertaMensagem;
end;


function TFUsuarios.CalcSenha(s:String):Integer;
var i:integer;
begin
  Result:=348545;
  for i:=1 to Length(s) do Result:=Result+(Ord(s[i])*177);
end;

function TFUsuarios.GetUsuario(Codigo,Senha:String;Codigoatual:integer=0):Boolean;
var SenhaGravada:Integer;
    s:String;
    i:integer;
    Q:TSqlquery;
begin
  Result:=False;
  Global.Usuario.Suporte:=False;
  Global.Usuario.SenhaDiaria:=False;
  Global.Usuario.Senha:=Senha;
  if Inteiro(Codigo)=9999 then begin
     if Inteiro(Senha)=9999 then begin
        if TestaInicioInstalacao then begin
           Global.Usuario.Codigo:=9997;
           Global.Usuario.Nome:='Instala��o';
           Global.Usuario.SenhaDiaria:=True;
           Sistema.CodigoUsuario:=IntToStr(Global.Usuario.Codigo);
           Sistema.NomeUsuario:=Global.Usuario.Nome;
           Result:=True;
           for i:=1 to 4000 do Global.Usuario.ObjetosAcessados[i]:=True;
        end;
     end else if TestaSenhaSuporte(Inteiro(Senha)) then begin
        Global.Usuario.Codigo:=9998;
        Global.Usuario.Nome:='Suporte';
        Global.Usuario.Suporte:=True;
        Sistema.CodigoUsuario:=IntToStr(Global.Usuario.Codigo);
        Sistema.NomeUsuario:=Global.Usuario.Nome;
        Result:=True;
        for i:=1 to 4000 do Global.Usuario.ObjetosAcessados[i]:=True;
     end else if Inteiro(Senha)=GetSenhaDiaria(Sistema.Hoje) then begin
        Global.Usuario.Codigo:=9999;
        Global.Usuario.Nome:='Senha Di�ria';
        Global.Usuario.SenhaDiaria:=True;
        Sistema.CodigoUsuario:=IntToStr(Global.Usuario.Codigo);
        Sistema.NomeUsuario:=Global.Usuario.Nome;
        for i:=1 to 4000 do Global.Usuario.OutrosAcessos[i]:=False;
        Result:=True;
     end;
     if not Result then AvisoErro('Senha inv�lida');
  end else begin
     Q:=sqltoquery('select * from usuarios where usua_codigo='+codigo);
//     if Arq.TUsuarios.Locate('Usua_Codigo',Codigo,[]) then begin
     if not Q.eof then begin
        SenhaGravada:=Q.FieldByName('Usua_Senha').AsInteger;
        if SenhaGravada=0 then begin
           Result:=CadastraSenha('',codigo);
        end else begin
           Result:=SenhaGravada=CalcSenha(Senha);
           if not Result then AvisoErro('Senha inv�lida');
           if (Result) and (FGeral.GetConfig1AsInteger('PRAZOSENHA')>0) then begin
              if Trunc(Sistema.Hoje)-Trunc(Q.FieldByName('Usua_DataSenha').AsDateTime)>FGeral.GetConfig1AsInteger('PRAZOSENHA') then begin
                 Aviso('Aten��o, extrapolado prazo de validade de sua senha, cadastre uma nova');
                 Result:=CadastraSenha(Senha,codigo);
              end;
           end;
        end;
// 01.06.06 - ////////////////////////
        if Codigoatual>0 then begin
          Arq.TUsuarios.Locate('Usua_Codigo',inttostr(CodigoAtual),[]);
        end else
          Arq.TUsuarios.Locate('Usua_Codigo',Codigo,[]);
////////////////////////
     end else begin
        AvisoErro('Usu�rio n�o cadastrado');
     end;
     if (Result) and (CodigoAtual=0) then begin
        Global.Usuario.Nome:=Q.FieldByName('Usua_Nome').AsString;
        Global.Usuario.Codigo:=Inteiro(Codigo);
        Sistema.CodigoUsuario:=IntToStr(Global.Usuario.Codigo);
        Sistema.NomeUsuario:=Global.Usuario.Nome;
        Global.Usuario.UnidadesMvto:=Trim(Q.FieldByName('Usua_UnidadesMvto').AsString);
        Global.Usuario.UnidadesRelatorios:=Trim(Q.FieldByName('Usua_UnidadesRelatorios').AsString);
        Global.Usuario.TiposDctosRelatorios:=Trim(Q.FieldByName('Usua_TpDctosRelatorios').AsString);
        Global.Usuario.ContasCaixaValidas:=';'+Trim(Q.FieldByName('Usua_ContasCaixaValidas').AsString)+';';
//        Global.Usuario.ContasAutPgto:=';'+FPlanoGer.GetContasSubordinadas(Trim(Arq.TUsuarios.FieldByName('Usua_ContasAutPgto').AsString),'CR,CP');
        s:=StrSpace(Q.FieldByName('Usua_ObjetosAcessados').AsString,4000);
        for i:=1 to 4000 do Global.Usuario.ObjetosAcessados[i]:=s[i]='S';
        s:=StrSpace(Q.FieldByName('Usua_OutrosAcessos').AsString,4000);
        for i:=1 to 4000 do Global.Usuario.OutrosAcessos[i]:=s[i]='S';
        GravaAcessando('S');
     end;
     Q.close;Freeandnil(Q);

  end;
end;

function TFUsuarios.TestaInicioInstalacao:Boolean;
begin
  Result:=True;
       if GlobAL.Contadores.ConfigGeral>10 then begin
          Result:=False;
       end;
end;

(*
function TFUsuarios.TestaInicioInstalacao:Boolean;
var Q:TSqlQuery;
begin
  Result:=True;
  Q:=SqlToQuery('SELECT * FROM Contadores');
  while not Q.Eof do begin
    if UpperCase(LeftStr(Q.FieldByName('Cont_Nome').AsString,9))='TRANSACAO' then begin
       if Q.FieldByName('Cont_Posicao').AsInteger>10 then begin
          Result:=False;
          Break;
       end;
    end;
    Q.Next;
  end;
  Q.Close;Q.Free;
end;
*)

function TFUsuarios.GetSenhaDiaria(Dt:TDateTime):Integer;
var s,ss:String;
    d,i,n,t:Integer;

    function DateToStrInvertida(const Dt:TDateTime):String;
    var Ano,Mes,Dia:String;
    begin
      Ano:=IntToStr(DateToAno(Dt,True));
      Mes:=StrZero(DateToMes(Dt),2);
      Dia:=StrZero(DateToDia(Dt),2);
      Result:=Ano+Mes+Dia;
    end;
begin
  d:=DateToDia(Dt)*13;
  s:=DateToStrInvertida(Dt);
  ss:=DateToText(Dt);
  t:=0;n:=0;
  for i:=1 to Length(ss) do t:=t+(Ord(ss[i])*d);
  for i:=1 to Length(s) do n:=n+Ord(s[i])*(i+t);
  for i:=1 to Length(s) do n:=n+Ord(s[i]);
  n:=n+6321565;
  Result:=Inteiro(RightStr(IntToStr(n),6));
end;

procedure TFUsuarios.ProcessaAcessoObjetos;
var i:integer;
begin
  Sistema.BeginProcess('processando acessos');
  for i:=0 to Top1.Count-1 do begin
      PTop:=Top1.Items[i];
      if PTop^.Obj is TMenuItem then begin
         if TMenuItem(PTop^.Obj).Tag=2 then begin
            TMenuItem(PTop^.Obj).Visible:=Global.Usuario.ObjetosAcessados[PTop^.Posicao];
            TMenuItem(PTop^.Obj).Enabled:=Global.Usuario.ObjetosAcessados[PTop^.Posicao];
         end;
      end;
      if PTop^.Obj is TSqlBtn then TSqlBtn(PTop^.Obj).Enabled:=Global.Usuario.ObjetosAcessados[PTop^.Posicao];
      if PTop^.Obj is TTabSheet then TTabSheet(PTop^.Obj).Visible:=Global.Usuario.ObjetosAcessados[PTop^.Posicao];
  end;
  Sistema.EndProcess('');

end;

function TFUsuarios.GetSenhaTempo:Boolean;
var Form: TForm;
    Edts:TSqlEd;
    B:TBevel;
    ContadorSenha:Integer;
begin
  ContadorSenha:=0;
  Result:=False;
  Screen.Cursor:=crDefault;
  Global.SistemaParado:=True;
  while ContadorSenha<=2 do begin
    Inc(ContadorSenha);
    Form := TForm.Create(Application);
    with Form do begin
      BorderStyle := bsDialog;
      Caption := 'Redigita��o Da Senha';
      SetBounds(225,220,210,80);
      Position:=poScreenCenter;
      B:=TBevel.Create(Form);
      B.Parent:=Form;
      B.Align:=alClient;
      Edts:=TSqlEd.Create(Form);
      Color:=clCream;
      with Edts do begin
        Parent := Form;
        PasswordChar:='*';
        CharCase:=ecUpperCase;
        MaxLength:=10;
        CloseForm:=True;
        TitlePos:=tppLeft;TitlePixels:=115;
        Title:='Senha Do Usu�rio';
        TitleFont.Style:=[fsBold];
        SetBounds(130,17,55,25);
      end;
      Form.ActiveControl:=Edts;
      ShowModal;
      if Trim(Edts.Text)<>Trim(Global.Usuario.Senha) then begin
         AvisoErro('Senha inv�lida');
         if ContadorSenha=3 then begin
            AvisoErro('Acesso negado, o sistema ser� finalizado');
            Break;
         end;
      end else begin
         Result:=True;
         Break;
      end;
    end;
    Form.Free;
  end;
  Global.SistemaParado:=False;
  if not Result then Application.Terminate;
end;

function TFUsuarios.GetSenhaProcesso:Boolean;
var Form: TForm;
    Edts:TSqlEd;
    B:TBevel;
    ContadorSenha:Integer;
begin
  ContadorSenha:=0;
  Result:=False;
  Screen.Cursor:=crDefault;
  Global.SistemaParado:=True;
  while ContadorSenha<=2 do begin
    Inc(ContadorSenha);
    Form := TForm.Create(Application);
    with Form do begin
      BorderStyle := bsDialog;
      Caption := 'Senha Do Usu�rio';
      SetBounds(225,220,210,80);
      Position:=poScreenCenter;
      B:=TBevel.Create(Form);
      B.Parent:=Form;
      B.Align:=alClient;
      Edts:=TSqlEd.Create(Form);
      Color:=clCream;
      with Edts do begin
        Parent := Form;
        PasswordChar:='*';
        CharCase:=ecUpperCase;
        MaxLength:=10;
        CloseForm:=True;
        TitlePos:=tppLeft;TitlePixels:=115;
        Title:='Senha Do Usu�rio';
        TitleFont.Style:=[fsBold];
        SetBounds(130,17,55,25);
      end;
      Form.ActiveControl:=Edts;
      ShowModal;
      if Trim(Edts.Text)<>Trim(Global.Usuario.Senha) then begin
         AvisoErro('Senha inv�lida');
         if ContadorSenha=3 then begin
            AvisoErro('Acesso negado');
            Break;
         end;
      end else begin
         Result:=True;
         Break;
      end;
    end;
    Form.Free;
  end;
  Global.SistemaParado:=False;
end;



procedure TFUsuarios.TopicosTelaCheia(Tit:String;Topic:TTreeView);
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

procedure TFUsuarios.TopicosKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
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


procedure TFUsuarios.BTopicosClick(Sender: TObject);
begin
  TopicosTelaCheia('Acesso 1 / '+Arq.TUsuarios.FieldByName('Usua_Nome').AsString,Topicos1);
end;

procedure TFUsuarios.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#32 then begin
     if Grid.Focused then BTopicos.ToClick;
     if Topicos1.Focused then BTopicos.ToClick;
     if Topicos2.Focused then BTopicos.ToClick;
  end;
end;


function TFUsuarios.TestaAcesso(Posicao:Integer):Boolean;
begin
  Result:=Global.Usuario.OutrosAcessos[Posicao];
  if not Result then AvisoErro('Usu�rio n�o autorizado');
end;

function TFUsuarios.Acesso(Posicao:Integer):Boolean;
begin
  Result:=Global.Usuario.OutrosAcessos[Posicao];
end;

procedure TFUsuarios.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('CadUsuarios','Rela��o Dos Usu�rios Cadastrados','','');
  Frel.Reportfromsql('select * from usuarios','CadUsuarios','Rela��o Dos Usu�rios Cadastrados');
end;

procedure TFUsuarios.EdUsua_contascaixavalidasKeyDown(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
//  if Key=VK_F12 then GetConta_Execute(TSqlEd(Sender),TSqlEd(Sender).TagStr,'','');
end;

procedure TFUsuarios.EdUsua_contascaixavalidasValidate(Sender: TObject);
begin
//  GetConta_Validar(TSqlEd(Sender),TSqlEd(Sender).Text,TSqlEd(Sender).TagStr,'','');
end;

procedure TFUsuarios.EdUsua_tpdctosrelatoriosEnter(Sender: TObject);
begin
//  if EdUsua_tpdctosrelatorios.Items.Count=0 then FDocumentos.SetaTiposDocumentos(EdUsua_tpdctosrelatorios,'');
end;

function TFUsuarios.GetNome(Codigo:Integer):String;
var Q:TSqlquery;
begin
  Result:='';
  if Codigo>0 then begin
//    if not Arq.TUsuarios.Active then Arq.TUsuarios.Open;
//    if Arq.TUsuarios.Locate('Usua_Codigo',Codigo,[]) then Result:=Trim(Arq.TUsuarios.FieldByName('Usua_Nome').AsString);
    Q:=sqltoquery('select usua_nome from usuarios where usua_codigo='+inttostr(codigo));
    if not Q.eof then result:=Trim(Q.FieldByName('Usua_Nome').AsString);
    Q.close;Freeandnil(Q);
  end;
end;

procedure TFUsuarios.SetaItems(Edit:TSqlEd);
begin
  Edit.Items.Clear;
  if not Arq.TUsuarios.Active then Arq.TUsuarios.Open;
  Arq.TUsuarios.BeginProcess;
  Arq.TUsuarios.First;
  while not Arq.TUsuarios.Eof do begin
    Edit.Items.Add(StrSpace(IntToStr(Arq.TUsuarios.FieldByName('Usua_Codigo').AsInteger),4)+' - '+Trim(Arq.TUsuarios.FieldByName('Usua_Nome').AsString));
    Arq.TUsuarios.Next;
  end;
  Arq.TUsuarios.EndProcess;
end;



function TFUsuarios.TestaSenhaSuporte(s:Integer):Boolean;
var i:integer;
begin
  SenhaSuporte[001]:=344564;
  SenhaSuporte[002]:=576579;
  SenhaSuporte[003]:=976141;
  SenhaSuporte[004]:=745434;
  SenhaSuporte[005]:=129786;
  Result:=False;
  for i:=1 to 5 do begin
      if s=SenhaSuporte[i] then begin
         Result:=True;
         Break;
      end;
  end;
end;


procedure TFUsuarios.CriaTopicosAcessoObjetos;
/////////////////////////////////////////////////

   procedure CriaTopico(n,p:Integer;o:TComponent);
   ////////////////////////////////////////////////
   begin
     if p>4000 then AvisoErro('Posi��o inv�lida para t�picos1 de acesso de usu�rios: '+IntToStr(p));
     if o is TMenuItem then begin
       TMenuItem(o).Tag:=2;
// 08.12.15
       Sistema.beginprocess( TMenuItem(o).Caption )
     end;
     FGrUsuarios.CriaTopico1(n,p,o);
     FUsuarios.CriaTopico1(n,p,o);
   end;

begin


  CriaTopico(0,0001,FMain.Cadastros);
////////////////////////////////////////////////////////
    CriaTopico(2,0010,FMain.GrupoUsurios1);
      CriaTopico(3,0011,FGrUsuarios.bIncluir);
      CriaTopico(3,0012,FGrUsuarios.bAlterar);
      CriaTopico(3,0013,FGrUsuarios.bExcluir);
      CriaTopico(3,0014,FGrUsuarios.bGravar);
    CriaTopico(2,0020,FMain.Usurios1);
      CriaTopico(3,0021,FUsuarios.bIncluir);
      CriaTopico(3,0022,FUsuarios.bAlterar);
      CriaTopico(3,0023,FUsuarios.bExcluir);
      CriaTopico(3,0024,FUsuarios.bGravar);
// 03.03.17
      CriaTopico(3,0025,FUsuarios.bPesquisar);
      CriaTopico(3,0026,FUsuarios.bigualar);
//      CriaTopico(3,0027,FUsuarios.bliberavenda);
//     ja tinha no acessos 2
      CriaTopico(3,0027,FUsuarios.bliberacredito);
      CriaTopico(3,0028,FUsuarios.brestricaocredito);
    CriaTopico(2,0030,FMain.Regies1);
      CriaTopico(3,0031,FRegioes.bIncluir);
      CriaTopico(3,0032,FRegioes.bAlterar);
      CriaTopico(3,0033,FRegioes.bExcluir);
    CriaTopico(2,0040,FMain.Cidades1);
      CriaTopico(3,0041,FCidades.bIncluir);
      CriaTopico(3,0042,FCidades.bAlterar);
      CriaTopico(3,0043,FCidades.bExcluir);
    CriaTopico(2,0060,FMain.Empresas1);
      CriaTopico(3,0061,FEmpresas.bIncluir);
      CriaTopico(3,0062,FEmpresas.bEditar);
      CriaTopico(3,0063,FEmpresas.bExcluir);
    CriaTopico(2,0070,FMain.Unidades1);
      CriaTopico(3,0071,FUnidades.bIncluir);
      CriaTopico(3,0072,FUnidades.bEditar);
      CriaTopico(3,0073,FUnidades.bExcluir);
    CriaTopico(2,0080,FMain.NaturezasFiscais1);
      CriaTopico(3,0081,FNatureza.bIncluir);
      CriaTopico(3,0082,FNatureza.bAlterar);
      CriaTopico(3,0083,FNatureza.bExcluir);
// 28.02.17
    CriaTopico(2,0280,FMain.CodigosdeAlquotas1);
      CriaTopico(3,0281,FCodigosFiscais.bIncluir);
      CriaTopico(3,0282,FCodigosFiscais.bAlterar);
      CriaTopico(3,0283,FCodigosFiscais.bExcluir);
    CriaTopico(2,0090,FMain.SituaesTributrias1);
      CriaTopico(3,0091,FSitTributaria.bIncluir);
      CriaTopico(3,0092,FSitTributaria.bAlterar);
      CriaTopico(3,0093,FSitTributaria.bExcluir);
    CriaTopico(2,0100,FMain.Representantes1);
      CriaTopico(3,0101,FRepresentantes.bIncluir);
      CriaTopico(3,0102,FRepresentantes.bAlterar);
      CriaTopico(3,0103,FRepresentantes.bExcluir);
      CriaTopico(3,0104,FRepresentantes.bOcorrencia);
    CriaTopico(2,0110,FMain.ContasGerenciais);
      CriaTopico(3,0111,FPlano.bIncluir);
      CriaTopico(3,0112,FPlano.bAlterar);
      CriaTopico(3,0113,FPlano.bExcluir);

    CriaTopico(2,0120,FMain.CadClientes);

      CriaTopico(3,0121,FCadcli.bIncluir);
      CriaTopico(3,0122,FCadcli.bAlterar);
      CriaTopico(3,0123,FCadcli.bExcluir);
      CriaTopico(3,0124,FCadcli.bocorrencia);
//      CriaTopico(3,0125,FCadcli.bpesquisa);
      CriaTopico(3,0125,FCadcli.bimportafornec);

    CriaTopico(2,0130,FMain.CadFornecedores);

      CriaTopico(3,0131,FFornece.bIncluir);
      CriaTopico(3,0132,FFornece.bAlterar);
      CriaTopico(3,0133,FFornece.bEditar);
      CriaTopico(3,0134,FFornece.bExcluir);

    CriaTopico(2,0140,FMain.CadProdutos);
      CriaTopico(3,0141,FEstoque.bIncluir);
      CriaTopico(3,0142,FEstoque.bAlterar);
      CriaTopico(3,0143,FEstoque.bExcluir);
      CriaTopico(3,0144,FEstoque.Btgravar);
      CriaTopico(3,0145,FEstoque.bdigitargrade);
      CriaTopico(3,0146,FEstoque.bterminargrade);
      CriaTopico(3,0147,FEstoque.bDadosgrade);
      CriaTopico(3,0148,FEstoque.bduplicar);
      CriaTopico(3,0149,FEstoque.benviabalanca); // 24.05.11

    CriaTopico(2,0150,FMain.CustosdeMateriais1);

      CriaTopico(3,0155,FMain.ComposicaoEstoque1);
        CriaTopico(4,0151,FComposicao.bgravar);
        CriaTopico(4,0152,FComposicao.bsalvarcomo);
        CriaTopico(4,0153,FComposicao.bapagacomposicao);
        CriaTopico(4,0154,FComposicao.bExcluiritem);
// 16.06.18
    CriaTopico(2,0165,FMain.Processos1);

    CriaTopico(2,0160,FMain.Oramento1);
      CriaTopico(3,0161,FOrcamento.bGravar);
      CriaTopico(3,0162,FOrcamento.bexclusao);
// 23.08.06
    CriaTopico(2,0170,FMain.Ocorrencias1);
      CriaTopico(3,0171,FOcorrencias.bAlterar);
// 09.09.2021
      CriaTopico(3,0172,FOcorrencias.bExcluir);
      CriaTopico(3,0173,FOcorrencias.bReceita);
      CriaTopico(3,0174,FOcorrencias.bimpatestado);
      CriaTopico(3,0175,FOcorrencias.boculos);

// 31.05.07
    CriaTopico(2,0180,FMain.Precos1);
      CriaTopico(3,0181,FPrecos.balterar);
      CriaTopico(3,0182,FPrecos.bprecos);

// 13.09.13
    CriaTopico(2,0240,FMain.Equipamentos1);

      CriaTopico(3,0241,FEquipamentos.bIncluir);
      CriaTopico(3,0242,FEquipamentos.balterar);
      CriaTopico(3,0243,FEquipamentos.bExcluir);
      CriaTopico(3,0244,FEquipamentos.bliberamanut);

// 17.09.08
    CriaTopico(2,0250,FMain.Setores1);
      CriaTopico(3,0251,FSetores.bIncluir);
      CriaTopico(3,0252,FSetores.balterar);
      CriaTopico(3,0253,FSetores.bExcluir);
// 30.01.09
    CriaTopico(2,0260,FMain.ModeObra1);
      CriaTopico(3,0261,FCadServicos.bIncluir);
      CriaTopico(3,0262,FCadServicos.balterar);
      CriaTopico(3,0263,FCadServicos.bExcluir);

// 27.10.09
    CriaTopico(2,0270,FMain.Colaboradores1);

      CriaTopico(3,0271,FColaboradores.bIncluir);
      CriaTopico(3,0272,FColaboradores.balterar);
      CriaTopico(3,0273,FColaboradores.bExcluir);

// 07.05.19
    CriaTopico(2,0660,FMain.Baias1);
      CriaTopico(3,0661,FBaias.bIncluir);
      CriaTopico(3,0662,FBaias.balterar);
      CriaTopico(3,0663,FBaias.bExcluir);

    CriaTopico(2,0190,FMain.CadFinanceiro);

      CriaTopico(3,0200,FMain.CadFormasDePagamento);
        CriaTopico(4,0201,FCondPagto.bIncluir);
        CriaTopico(4,0202,FCondPagto.bAlterar);
        CriaTopico(4,0203,FCondPagto.bExcluir);
      CriaTopico(3,0210,FMain.CadPortadores);
        CriaTopico(4,0211,FPortadores.bIncluir);
        CriaTopico(4,0212,FPortadores.bAlterar);
        CriaTopico(4,0213,FPortadores.bExcluir);
      CriaTopico(3,0215,FMain.ConfiguraDemonstrativo1);
// 22.05.20
      CriaTopico(3,0220,FMain.CentrosdeCusto1);
        CriaTopico(4,0221,FCcustos.bIncluir);
        CriaTopico(4,0222,FCcustos.bAlterar);
        CriaTopico(4,0223,FCcustos.bExcluir);
// 27.05.20
      CriaTopico(3,0225,FMain.ValoresCentrosdeCusto1);
        CriaTopico(4,0226,FCentroscusto.bgravar);
        CriaTopico(4,0227,FCentroscusto.bexclusao);

    CriaTopico(2,0300,FMain.CadEstoque);

      CriaTopico(3,0310,FMain.Cores1);
        CriaTopico(4,0311,FCores.bIncluir);
        CriaTopico(4,0312,FCores.bAlterar);
        CriaTopico(4,0313,FCores.bExcluir);
      CriaTopico(3,0320,FMain.amanhos1);
        CriaTopico(4,0321,FTamanhos.bIncluir);
        CriaTopico(4,0322,FTamanhos.bAlterar);
        CriaTopico(4,0323,FTamanhos.bExcluir);
      CriaTopico(3,0330,FMain.Grupos1);
        CriaTopico(4,0331,FGrupos.bIncluir);
        CriaTopico(4,0332,FGrupos.bAlterar);
        CriaTopico(4,0333,FGrupos.bExcluir);
      CriaTopico(3,0340,FMain.SubGrupos1);
        CriaTopico(4,0341,FSubGrupos.bIncluir);
        CriaTopico(4,0342,FSubGrupos.bAlterar);
        CriaTopico(4,0343,FSubGrupos.bExcluir);
      CriaTopico(3,0350,FMain.Familias1);
        CriaTopico(4,0351,FFamilias.bIncluir);
        CriaTopico(4,0352,FFamilias.bAlterar);
        CriaTopico(4,0353,FFamilias.bExcluir);
      CriaTopico(3,0360,FMain.Grades1);
        CriaTopico(4,0361,FGrades.bIncluir);
        CriaTopico(4,0362,FGrades.bAlterar);
        CriaTopico(4,0363,FGrades.bExcluir);
        CriaTopico(4,0364,FGrades.bConfigurar);
        CriaTopico(4,0365,FGrades.bGravar);
      CriaTopico(3,0370,FMain.abelasPreo1);
        CriaTopico(4,0371,FTabela.bIncluir);
        CriaTopico(4,0372,FTabela.bAlterar);
        CriaTopico(4,0373,FTabela.bExcluir);
      CriaTopico(3,0380,FMain.MaterialPredominante1);
        CriaTopico(4,0381,FMaterial.bIncluir);
        CriaTopico(4,0382,FMaterial.bAlterar);
        CriaTopico(4,0383,FMaterial.bExcluir);
      CriaTopico(3,0385,FMain.Copas1);
        CriaTopico(4,0386,FCopas.bIncluir);
        CriaTopico(4,0387,FCopas.bAlterar);
        CriaTopico(4,0388,FCopas.bExcluir);
      CriaTopico(3,0390,FMain.ClassificaoIPI1);
        CriaTopico(4,0391,FCodigosipi.bIncluir);
        CriaTopico(4,0392,FCodigosipi.bAlterar);
        CriaTopico(4,0393,FCodigosipi.bExcluir);
      CriaTopico(3,0400,FMain.Similares1);
        CriaTopico(4,0401,FSimilares.bIncluir);
        CriaTopico(4,0402,FSimilares.bExcluir);
      CriaTopico(3,0410,FMain.ManutInventario);
        CriaTopico(4,0411,FSaldoEStoque.bIncluir);
        CriaTopico(4,0413,FSaldoEStoque.bExcluir);
      CriaTopico(3,0420,FMain.InfNutricionais1);
        CriaTopico(4,0421,FNutricionais.bIncluir);
        CriaTopico(4,0422,FNutricionais.bAlterar);
        CriaTopico(4,0423,FNutricionais.bExcluir);
      CriaTopico(3,0430,FMain.Ingredientes1);
        CriaTopico(4,0431,FIngredientes.bIncluir);
        CriaTopico(4,0432,FIngredientes.bAlterar);
        CriaTopico(4,0433,FIngredientes.bEditar);
        CriaTopico(4,0434,FIngredientes.bExcluir);
      CriaTopico(3,0440,FMain.Conservacao1);
        CriaTopico(4,0441,FConservacao.bIncluir);
        CriaTopico(4,0442,FConservacao.bAlterar);
        CriaTopico(4,0443,FConservacao.bEditar);
        CriaTopico(4,0444,FConservacao.bExcluir);
// 10.02.2023
      CriaTopico(3,0445,FMain.Tributacaoncm);
        CriaTopico(4,0446,FTributacaoncm.bgravar);
        CriaTopico(4,0447,FTributacaoncm.brel);

    CriaTopico(2,0500,FMain.CadOutros);
      CriaTopico(3,0520,FMain.CadHistoricos);
        CriaTopico(4,0521,FHistoricos.bIncluir);
        CriaTopico(4,0522,FHistoricos.bAlterar);
        CriaTopico(4,0523,FHistoricos.bExcluir);
      CriaTopico(3,0530,FMain.Feriados);
        CriaTopico(4,0531,FFeriados.bIncluir);
        CriaTopico(4,0532,FFeriados.bAlterar);
        CriaTopico(4,0533,FFeriados.bExcluir);
      CriaTopico(3,0540,FMain.CadImpressos);
        CriaTopico(4,0541,FCadImp.bIncluir);
        CriaTopico(4,0542,FCadImp.bAlterar);
        CriaTopico(4,0543,FCadImp.bExcluir);
        CriaTopico(4,0544,FCadImp.bConfigurar);
        CriaTopico(4,0545,FCadImp.bImpressora);
        CriaTopico(4,0546,FCadImp.bAlteraContador);
      CriaTopico(3,0550,FMain.CadMotivosdeBloqueio);
        CriaTopico(4,0551,FMotivosBloq.bIncluir);
        CriaTopico(4,0552,FMotivosBloq.bAlterar);
        CriaTopico(4,0553,FMotivosBloq.bExcluir);
// conf.movimento
      CriaTopico(3,0560,FMain.ConfiguraodeMovimentos1);
        CriaTopico(4,0561,FConfMovimento.bIncluir);
        CriaTopico(4,0562,FConfMovimento.bEditar);
        CriaTopico(4,0563,FConfMovimento.bExcluir);
// transportadores
      CriaTopico(3,0570,FMain.ransportadores1);
        CriaTopico(4,0571,FTransp.bIncluir);
        CriaTopico(4,0572,FTransp.bEditar);
        CriaTopico(4,0573,FTransp.bExcluir);
// cotas mensais por representante
      CriaTopico(3,0580,FMain.CotasporRepres1);
        CriaTopico(4,0581,FCotasRepr.bIncluir);
        CriaTopico(4,0582,FCotasRepr.bAlterar);
        CriaTopico(4,0583,FCotasRepr.bExcluir);
      CriaTopico(3,0590,FMain.MensagensNotasFiscais1);
        CriaTopico(4,0591,FMensNotas.bIncluir);
        CriaTopico(4,0592,FMensNotas.bAlterar);
        CriaTopico(4,0593,FMensNotas.bExcluir);
      CriaTopico(3,0600,FMain.CadastroOcorrncias1);
        CriaTopico(4,0601,FCadOcorrencias.bIncluir);
        CriaTopico(4,0602,FCadOcorrencias.bAlterar);
        CriaTopico(4,0603,FCadOcorrencias.bExcluir);
      CriaTopico(3,0610,FMain.CadastroEmitentes1);
        CriaTopico(4,0611,FEmitentes.bIncluir);
        CriaTopico(4,0612,FEmitentes.bAlterar);
        CriaTopico(4,0613,FEmitentes.bExcluir);
// 02.03.09
      CriaTopico(3,0620,FMain.TiposNota1);
        CriaTopico(4,0621,FTiposNotas.bIncluir);
        CriaTopico(4,0622,FTiposNotas.bAlterar);
        CriaTopico(4,0623,FTiposNotas.bExcluir);
// 11.05.09
      CriaTopico(3,0630,FMain.Indicadores1);
        CriaTopico(4,0631,FIndicadores.bIncluir);
        CriaTopico(4,0632,FIndicadores.bAlterar);
        CriaTopico(4,0633,FIndicadores.bExcluir);
// 06.07.09
      CriaTopico(3,0640,FMain.ComissoVendedores1);
        CriaTopico(4,0641,FTabelaComissao.bIncluir);
        CriaTopico(4,0642,FTabelaComissao.bAlterar);
        CriaTopico(4,0643,FTabelaComissao.bExcluir);
// 21.09.12
      CriaTopico(3,0650,FMain.FaixasdeValores1);
        CriaTopico(4,0651,FFaixas.bIncluir);
        CriaTopico(4,0652,FFaixas.bAlterar);
        CriaTopico(4,0653,FFaixas.bExcluir);

//////////////////////////////////////////////////////////////////////////////////////////////

  CriaTopico(1,1000,FMain.Movimentos);

  // 27.07.18
     CriaTopico(2,1001,FMain.Consignacaomenu);

       CriaTopico(3,1002,FMain.Remessa1);
       CriaTopico(3,1012,FMain.AlteraoConsignao1);
//       CriaTopico(3,1022,FMain.DevoluodeConsignao1);
       CriaTopico(3,1032,FMain.RetornoConsigAcerto1);
// 18.05.11
         CriaTopico(4,1088,FRetConsig.bgeranfe);
       CriaTopico(3,1033,FMain.ImpressoRemessa1);
       CriaTopico(3,1034,FMain.RemMagazine1);
       CriaTopico(3,1035,FMain.RemTrocaCredito);
       CriaTopico(3,1036,FMain.RemCompraGarantida1);

     CriaTopico(2,1040,FMain.ProntaEntrega1);

       CriaTopico(3,1041,FMain.Remessa1);
       CriaTopico(3,1042,FMain.AlteraodeRemessa1);
       CriaTopico(3,1043,FMain.PedidosdeVenda1);
       CriaTopico(3,1044,FMain.ImpressoRemessaPE1);
       CriaTopico(3,1045,FMain.NovoPedidosdeVenda1);   // retorno PE

     CriaTopico(2,1050,FMain.PedidosCompra1);

       CriaTopico(3,1051,FMain.Incluso1);
       CriaTopico(3,1052,FMain.Alterao1);
       CriaTopico(3,1053,FMain.BaixaPedCompra1);
//       CriaTopico(3,1054,FPedCompra.bgravar);
       CriaTopico(3,1055,FPedCompra.bbaixapedido);
       CriaTopico(3,1056,FPedCompra.batualizapreco);

     CriaTopico(2,1060,FMain.NotasFiscais1);

       CriaTopico(3,1061,FMain.Saida1);

         CriaTopico(4,1077,FNotaSaida.bcontrato);   // 18.09.08
         CriaTopico(4,1079,FNotaSaida.bgeranfe);   // 25.11.10
         CriaTopico(4,1087,FNotaSaida.bgeraboleto);   // 16.05.11
         CriaTopico(4,1091,FNotaSaida.bbaixa);   // 26.04.12
         CriaTopico(4,1095,FNotaSaida.bgeracte);
// 04.12.20
         CriaTopico(4,1165,FNotaSaida.bimportanf);

       CriaTopico(3,1062,FMain.Entrada1);
//         CriaTopico(4,1091,FNotaCompra.brelauditoriafiscal );
// FNotacompra fica nos avaiables do projeto...se nao 'phode' o databasename...estranho...
// 14.06.12
       CriaTopico(3,1063,FMain.Transferncia1);
// 21.10.20
         CriaTopico(4,1071,FNotaTransf.bnfcompra);

//       CriaTopico(3,1064,FMain.SaidaECF1);
       CriaTopico(3,1065,FMain.AlteraoSaida1);
       CriaTopico(3,1066,FMain.SequnciaSaida1);
       CriaTopico(3,1067,FMain.RetornoRomaneio1);
       CriaTopico(3,1068,FMain.AlteraoEntrada1);
       CriaTopico(3,1069,FMain.ExportacaoNFElet1);

         CriaTopico(4,1082,FExpNfetxt.bexpxml  );
         CriaTopico(4,1084,FExpNfetxt.bconsultasefa  );
         CriaTopico(4,1085,FExpNfetxt.bgerenciar  );
         CriaTopico(4,1105,FExpNfetxt.baltentrada  ); // 31.08.20
// 01.01.20
         CriaTopico(4,1106,FExpNfetxt.bgeramdfe  );
     // 03.03.09
       CriaTopico(3,1080,FMain.MaodeObraSaida1);
// 09.11.09
       CriaTopico(3,1081,FMain.GerenciarNFe1);
// 07.12.09
         CriaTopico(4,1083,FGerenciaNfe.bemail);
// 27.01.10
         CriaTopico(4,1086,FGerenciaNfe.bimpdanfexml);
         CriaTopico(4,1092,FGerenciaNfe.bcartacorrecao);
// 02.01.13 - envio de xmls de saida para sefa
         CriaTopico(4,1093,FGerenciaNfe.bgeraxml);
// 12.07.14 - 'impress�o' de cce
         CriaTopico(4,1097,FGerenciaNfe.bimpcce);
// 31.08.20 - envio de danfe-pdf via whats
         CriaTopico(4,1098,FGerenciaNfe.bwhatsapp);

// 15.06.11
       CriaTopico(3,1090,FMain.AlteraoFiscal1);
// 18.03.13
       CriaTopico(3,1094,FMain.VendaBalco1);
// 18.06.14
       CriaTopico(3,1096,FMain.GerenciarCTe1);
// 24.10.16
       CriaTopico(3,1099,FMain.GeracaoCTe1);
// 27.06.17
       CriaTopico(3,1100,FMain.GeraoNFServios1);
         CriaTopico(4,1101,FExpNfse.bexpxml  );
         CriaTopico(4,1102,FExpNfse.bgerenciar  );

     CriaTopico(2,1070,FMain.PedidosVenda1);

//       CriaTopico(3,1071,FMain.PedidoVenda1);
       CriaTopico(3,1072,FMain.Alterao2);
       CriaTopico(3,1073,FMain.PosioPedido1);
          CriaTopico(4,1104,FPosicaoPedidoVenda.bcancelareserva );

       CriaTopico(3,1074,FMain.PosRepresentante1);
       CriaTopico(3,1075,FPedvenda.bcancpedido);
       CriaTopico(3,1076,FPedvenda.bexclusao);  // 1077 � impressao contrato
       CriaTopico(3,1078,FPedvenda.bgerarequisicao);
// 12.12.2017
       CriaTopico(3,1103,FPedvenda.balteracliente);
       CriaTopico(3,1089,FMain.PesagemPedido1);  // 06.06.11
// 14.04.2021
       CriaTopico(3,1107,FPedvenda.bmedicoes);


     CriaTopico(2,1120,FMain.Financeiro3);

       CriaTopico(3,1121,FMain.LancarPendencia);
         CriaTopico(4,1129,FLancaPendencia.bImpressao );
       CriaTopico(3,1122,FMain.AlterarPendencias1);
       CriaTopico(3,1125,FMain.BaixarPendncias1);
// 23.02.18
         CriaTopico(4,1153,FBaixaPendencia.balteravalor);
         CriaTopico(4,1130,FMain.BaixarporConta1);
// 03.07.18 - recolocado...
         CriaTopico(4,1128,FBaixaPendencia.brecibo);

       CriaTopico(3,1126,FMain.ChequesRecebidos1);
         CriaTopico(4,1152,FCadcheques.bgarantido);
       CriaTopico(3,1127,FMain.BaixarCheques1);
       CriaTopico(3,1132,FMain.LanarCaixaBancos1);
// 28.03.19
         CriaTopico(4,1154,FLancaMovFin.bimprecibo);

       CriaTopico(3,1133,FMain.AlterarCaixaBancos1);
       CriaTopico(3,1142,FMain.ransfernciaMensal2);
       CriaTopico(3,1143,FMain.AjustesSaldosMensais1);
       CriaTopico(3,1144,FMain.BaixaCobrana1);
       CriaTopico(3,1145,FMain.FluxodeCaixa2);
       CriaTopico(3,1146,FMain.ConciliaoBancria1);

       CriaTopico(3,1147,FMain.GeraoBoletos1);
         CriaTopico(4,1148,FBoletos.bimprimir);
         CriaTopico(4,1149,FBoletos.bgeraremessa);
         CriaTopico(4,1156,FBoletos.bemail);

       CriaTopico(3,1150,FMain.BaixarCarto1);
     CriaTopico(3,1151,FMain.ChequesEmitidos1);

     CriaTopico(3,1160,FMain.PagamentoLeite);
     CriaTopico(3,1161,FMain.PagamentoMerenda1);
// 30.04.20
     CriaTopico(3,1162,FMain.PagamentoEletrnico1);
// 13.05.20
     CriaTopico(3,1163,FMain.BaixaPagEletrnico1);
// 13.07.20
     CriaTopico(3,1164,FMain.JuntaPagamentos1);
// 03.10.2022
     CriaTopico(3,1166,FMain.Avisodecobranca);
// 08.02.2023
     CriaTopico(3,1167,FMain.ImportacaoOFX);

     CriaTopico(2,1200,FMain.Estoque1);

       CriaTopico(3,1201,FMain.Acertos1);
       CriaTopico(3,1202,FMain.AjustesdeSaldos1);
       CriaTopico(3,1203,FMain.MontagemKits1);
       CriaTopico(3,1205,FMain.ransfernciaMensal1);
       CriaTopico(3,1206,FMain.Contagem2);
// 10.10.13 - para evitar 'cagadex'
         CriaTopico(3,1213,FAcertos.batualizaestoque);
       CriaTopico(3,1207,FMain.BaixaMatriaPrima1);
       CriaTopico(3,1208,FMain.BxMensalVendaTemporria1);
       CriaTopico(3,1209,FMain.BaixaAlmox);
// 09.12.08
         CriaTopico(4,1211,FRequisicao.breprocessa );
       CriaTopico(3,1210,FMain.BaixaProcessoparaAlmox1);
// 05.10.09
       CriaTopico(3,1212,FMain.EntradaProdutoAcabado1);
// 28.08.17
       CriaTopico(3,1214,FMain.ContagemcomLeitor1);

     CriaTopico(2,1250,FMain.GerenciaisMov);

       CriaTopico(3,1251,FMain.CancelamentoTransao1);
       CriaTopico(3,1252,FMain.ExportaoCaixaBancos1);
       CriaTopico(3,1253,FMain.ExportaoComprasVendas1);
       CriaTopico(3,1254,FMain.ExportaoFiscalWindows1);
       CriaTopico(3,1255,FMain.Sintegra1);
       CriaTopico(3,1256,FMain.transfernciaRemessa1);
// 09.08.07
       CriaTopico(3,1257,FMain.AlteraoNotas1);
// 29.01.08
       CriaTopico(3,1258,FMain.Oramentos1);
         CriaTopico(4,1263,FOrcamentos.borcamento );
// 14.01.11
       CriaTopico(3,1259,FMain.GeracaoSpedFiscal1);
// 10.10.11
       CriaTopico(3,1260,FMain.GeracaoSpedPisCofins1);
// 04.02.13
       CriaTopico(3,1261,FMain.ImportaCTe1);
// 11.06.15
       CriaTopico(3,1262,FMain.ImportaNFes1);
// 13.07.17
       CriaTopico(3,1264,FMain.nfedestinadas1);
// 12.03.19
       CriaTopico(3,1265,FMain.ImportaNFSe1);
// 23.03.20
       CriaTopico(3,1266,FMain.GeraoADRCST1);
// 17.02.2021
       CriaTopico(3,1267,FMain.GeracaoDmed1);
// 23.09.2021 - registros do sped 1100  e 1500
       CriaTopico(3,1268,FMain.Registros1100e15001 );

     CriaTopico(2,1300,FMain.Pesquisas1);
       CriaTopico(3,1301,FMain.Pesquisa011);

     CriaTopico(2,1320,FMain.PrPedidos1);
       CriaTopico(3,1321,FMain.Atendimento1);

// 10.09.07
     CriaTopico(2,1330,FMain.EntradaAbate1);

       CriaTopico(3,1331,FMain.IncusaoAbate);
         CriaTopico(4,1332,FEntradaabate.bGravar);
         CriaTopico(4,1333,FEntradaabate.brateio);
         CriaTopico(4,1334,FEntradaabate.bimp);   // 30.05.08 - isonel
       CriaTopico(3,1340,FMain.AlteracaoAbate);
// 13.09.15
       CriaTopico(3,1341,FMain.Pesagem1);
// 07.06.16
       CriaTopico(3,1342,FMain.PesagemCortes1);
// 03.10.16
       CriaTopico(3,1343,FMain.Brincos1);
// 02.11.07
     CriaTopico(2,1350,FMain.Desossa1);
//       CriaTopico(3,1351,FMain.DesossaSaida);
       CriaTopico(3,1352,FMain.EntradaDesossa);
       CriaTopico(3,1353,FMain.SaidaDesossa);
       CriaTopico(3,1354,FMain.Transformacao);
// 15.06.20
       CriaTopico(3,1355,FMain.EntradadeCupim1);
// 10.09.20
       CriaTopico(3,1356,FMain.EtiquetasMiudos1);
// 07.12.20
       CriaTopico(3,1357,FMain.ExclusoEtiquetas1);

// 04.06.08
     CriaTopico(2,1360,FMain.SaidaAbate1);

       CriaTopico(3,1361,FMain.SaidaAbateInclusao);
         CriaTopico(4,1362,FEntradaabate.bGravar);
         CriaTopico(4,1363,FEntradaabate.brateio);
         CriaTopico(4,1364,FEntradaabate.bimp);
       CriaTopico(3,1370,FMain.SaidaAbateAlteracao);
// 19.09.08
     CriaTopico(2,1380,FMain.NaoConformidades1);

       CriaTopico(3,1381,FMain.AtaPlanosdeAo1);
         CriaTopico(4,1382,FAtaplanoacao.bincluir);
         CriaTopico(4,1383,FAtaplanoacao.bexcluir);
         CriaTopico(4,1384,FAtaplanoacao.bbaixar);
         CriaTopico(4,1385,FAtaplanoacao.balterar);
       CriaTopico(3,1390,FMain.AlteracaoPlanoacao1);
       CriaTopico(3,1400,FMain.RegistroNoConformidade1);
         CriaTopico(4,1401,FRegNaoConformidade.bincluir);
         CriaTopico(4,1402,FRegNaoConformidade.bexcluir);
         CriaTopico(4,1403,FRegNaoConformidade.bgravacausas);
       CriaTopico(3,1410,FMain.AlteracaoRegNaoConf1);
       CriaTopico(3,1415,FMain.PlanosPendentes1);
       CriaTopico(3,1420,FMain.RNCPendentes1);
         CriaTopico(4,1421,FRegNaoConfPendentes.bcausas);
         CriaTopico(4,1422,FRegNaoConfPendentes.bplanoacao);
         CriaTopico(4,1423,FRegNaoConfPendentes.bconsenso);
         CriaTopico(4,1424,FRegNaoConfPendentes.bprodutonaoconf);

       CriaTopico(3,1430,FMain.IndicadoresdeResultado1);

// 14.09.13
     CriaTopico(2,1440,FMain.ManutencaoEquipamento1);
// 30.09.13
     CriaTopico(2,1450,FMain.Fazenda1);

       CriaTopico(3,1451,FMain.Fazendainclusao);
         CriaTopico(4,1452,FEntradaabate.bGravar);
         CriaTopico(4,1453,FEntradaabate.brateio);
         CriaTopico(4,1454,FEntradaabate.bimp);
       CriaTopico(3,1460,FMain.Fazendaalteracao);
       CriaTopico(3,1461,FMain.PesagemVivos);
       CriaTopico(3,1462,FMain.Infopesagem);

// 26.02.16
     CriaTopico(2,1465,FMain.Cargas1);

       CriaTopico(3,1466,FMain.Montagem1);
          CriaTopico(4,1475,FMontacarga.bmontacarga );
          CriaTopico(4,1476,FMontacarga.bgeranfes );
          CriaTopico(4,1478,FMontacarga.bincluicarga );

       CriaTopico(3,1467,FMain.PesagemCaminhao2);
       CriaTopico(3,1468,FMain.VerificaoPeso1);
       CriaTopico(3,1469,FMain.PesagemProdutor1);
// 20.10.17
       CriaTopico(3,1474,FMain.PesagemDevoluo1);
// 18.04.18
       CriaTopico(3,1477,FMain.PesagemporCarga1);
// 23.05.19
          CriaTopico(4,1481,FPesagemPorcarga.bincluicarga );
          CriaTopico(4,1482,FPesagemPorcarga.bexlcuidacarga );
// 31.05.19
       CriaTopico(3,1490,FMain.GerenciaMDFe1);
// 22.10.19
       CriaTopico(3,1495,FMain.MontagemcomCTe1);
          CriaTopico(4,1496,FMontacargaCTe.bmontacarga );
          CriaTopico(4,1497,FMontacargaCTe.bincluicarga );
// 16.07.20
       CriaTopico(3,1499,FMain.MDFecomCte1);

// 20.03.17
     CriaTopico(2,1470,FMain.Agenda1);

       CriaTopico(3,1471,FAgendamento.bIncluir);
       CriaTopico(3,1472,FAgendamento.bExcluir);
       CriaTopico(3,1473,FAgendamento.bCancelar);

// 25.10.18
     CriaTopico(2,1480,FMain.Televendas1);
// 02.09.2021
        CriaTopico(3,1504,FTeleMarketing.binclusao);
        CriaTopico(3,1505,FTeleMarketing.batendimento);
        CriaTopico(3,1506,FTeleMarketing.bincpedido);
        CriaTopico(3,1507,FTeleMarketing.bverpedidos);
        CriaTopico(3,1508,FTeleMarketing.bexcluir);

// 10.04.19
     CriaTopico(2,1485,FMain.LeitedaCrianca1);
// 23.09.20 - contratos
     CriaTopico(2,1486,FMain.Contratos1);

        CriaTopico(3,1487,FContratos.binclusao);
        CriaTopico(3,1488,FContratos.bexcluir);
        CriaTopico(3,1489,FContratos.balterar);
        CriaTopico(3,1500,FContratos.batualizavalores);

// 01.09.2021 - atualiza��o de contratos

        CriaTopico(3,1501,FContratoatu.binclusao);
        CriaTopico(3,1502,FContratoatu.balterar);
        CriaTopico(3,1503,FContratoatu.bexcluir);

// 27.10.2021 - balan�a
     CriaTopico(2,1510,FMain.Balanca);

/////////////////////////////////////////////////////////////////////////////////
  CriaTopico(1,2000,FMain.Relatorios);
/////////////////////////////////////////////////////////////////////////////////

     CriaTopico(2,2400,FMain.Cadastros1);
       CriaTopico(3,2410,FMain.Clientes1);
         CriaTopico(4,2411,FMain.FichaCadastral1);
         CriaTopico(4,2412,FMain.Aniversariantes1);
         CriaTopico(4,2413,FMain.ClientesNovos1);
         CriaTopico(4,2414,FMain.ClientesNovosResumo1);
         CriaTopico(4,2415,FMain.Etiquetas1);
         CriaTopico(4,2416,FMain.VendasInativos1);
         CriaTopico(4,2417,FMain.EtiquetaVendasInativos1);
         CriaTopico(4,2418,FMain.LimiteDisponvel1);
       CriaTopico(3,2430,FMain.iposdeMovimento1);
       CriaTopico(3,2431,FMain.IntruesCobrana1);

     CriaTopico(2,2001,FMain.Financeiro2);
       CriaTopico(3,2002,FMain.ContaaPagar1);
         CriaTopico(4,2003,FMain.RelaoIncluidas1);
         CriaTopico(4,2004,FMain.RelaoPendentes1);
         CriaTopico(4,2005,FMain.RelaoBaixadas1);
         CriaTopico(4,2006,FMain.PosioFinanceira1);
         CriaTopico(4,2007,FMain.PosicaoApropriacoes1);

       CriaTopico(3,2022,FMain.ContasaReceber1);
         CriaTopico(4,2023,FMain.RelaoIncluidas2);
         CriaTopico(4,2024,FMain.RelaoPendentes2);
         CriaTopico(4,2025,FMain.RelaoBaixadas2);
         CriaTopico(4,2026,FMain.PosioFinanceira2);
         CriaTopico(4,2027,FMain.PendentesRepr1);
         CriaTopico(4,2028,FMain.ResumoVencerVencidos1);

       CriaTopico(3,2042,FMain.MovimentoBancrio1);
         CriaTopico(4,2043,FMain.ExtratoConta);
           CriaTopico(5,2068,FRelCxBancos.bjuros);
         CriaTopico(4,2044,FMain.ReceitasDespesas1);
         CriaTopico(4,2045,FMain.FluxodeCaixa1);
         CriaTopico(4,2046,FMain.Comisso1);
         CriaTopico(4,2047,FMain.ExtratoSinttico2);
         CriaTopico(4,2048,FMain.ResumoDiario1);

       CriaTopico(3,2062,FMain.ChequesRecebidos2);
       CriaTopico(3,2063,FMain.Antecipaes1);
       CriaTopico(3,2064,FMain.Oramento2);
// 09.10.07
       CriaTopico(3,2065,FMain.PosioCheques1);
// 05.05.09
       CriaTopico(3,2066,FMain.ComissaoobreRecebido1);
// 14.09.11
       CriaTopico(3,2067,FMain.DRE1);

     CriaTopico(2,2100,FMain.Estoque2);

       CriaTopico(3,2101,FMain.PosioEstoque1);
//       CriaTopico(3,2102,FMain.ExtratodoProduto1);
// 21.11.16
       CriaTopico(3,2102,FMain.ExtratodoProduto1);
       CriaTopico(3,2103,FMain.Itens);
       CriaTopico(3,2104,FMain.Inventrio1);
       CriaTopico(3,2105,FMain.InventrioConsignado1);
       CriaTopico(3,2106,FMain.InventrioProntaEntrega1);
       CriaTopico(3,2107,FMain.InventrioRegimeEspecial1);
       CriaTopico(3,2108,FMain.ExtratoSinttico1);
       CriaTopico(3,2109,FMain.InventrioRetroativoConsignado1);
       CriaTopico(3,2110,FMain.Contagem1);
       CriaTopico(3,2111,FMain.ExtratoProntaEntrega1);
       CriaTopico(3,2112,FMain.ExtratoRegimeEspecial1);
       CriaTopico(3,2113,FMain.ExtratoConsignado1);
       CriaTopico(3,2114,FMain.ExtratoProdutoFora1);
       CriaTopico(3,2115,FMain.ListaPreos1);
       CriaTopico(3,2116,FMain.VendasAbaixoMnimo1);
//       CriaTopico(3,2117,FMain.ExtratoProdutoColunas1);
       CriaTopico(3,2118,FMain.ConsumoMaterial1);
       CriaTopico(3,2119,FMain.CurvaABCConsumo1);
       CriaTopico(3,2120,FMain.CurvaABCEstoque1);
       CriaTopico(3,2121,FMain.SemMovimento1);
       CriaTopico(3,2122,FMain.CreditoMCbicos1);
       CriaTopico(3,2123,FMain.PrevistoRealizado1);
       CriaTopico(3,2124,FMain.PontoRessuprimento1);
       CriaTopico(3,2125,FMain.ReservaAlmox1);
// 28.08.17
       CriaTopico(3,2126,FMain.RastreamentoProdutos1);
       CriaTopico(3,2127,FMain.PosicaoEstoqueporPeso1);
// 19.09.17
       CriaTopico(3,2128,FMain.RastreamentoVendas1);
// 16.11.20
       CriaTopico(3,2129,FMain.EstoqueCamaraFria1);

     CriaTopico(2,2200,FMain.NotasFiscais2);

       CriaTopico(3,2201,FMain.Saidas1);
       CriaTopico(3,2202,FMain.ransferncia1);
       CriaTopico(3,2203,FMain.DevoluoRomaneio1);
       CriaTopico(3,2204,FMain.Faturamento1);
       CriaTopico(3,2205,FMain.RomaneioRetorno1);
       CriaTopico(3,2206,FMain.Compras2);
       CriaTopico(3,2207,FMain.Bloqueto1);
       CriaTopico(3,2208,FMain.SaldoaEntregar1);
       CriaTopico(3,2209,FMain.InssNotaProdutor1);
       CriaTopico(3,2210,FMain.PedidosFaturados1);
       CriaTopico(3,2211,FMain.ImpostosRetidos1);
       CriaTopico(3,2212,FMain.PorSetor1);
       CriaTopico(3,2213,FMain.InformeIRProdutor1);

     CriaTopico(2,2300,FMain.Gerenciais1);

       CriaTopico(3,2301,FMain.ransao1);
       CriaTopico(3,2302,FMain.AuditoriaFiscal1);
//       CriaTopico(3,2303,FMain.ChequesRecebidos2);
       CriaTopico(3,2304,FMain.AuditoriaCustos1);
       CriaTopico(3,2305,FMain.Vendas1);
       CriaTopico(3,2306,FMain.VendasQtde1);
       CriaTopico(3,2310,FMain.Vendas2);
       CriaTopico(3,2311,FMain.ConfernciaDescontos1);
//       CriaTopico(3,2307,FMain.Consignaesemaberto1);
// 17.05.10 - reativado
       CriaTopico(3,2307,FMain.ConsignaoemAberto1);
       CriaTopico(3,2308,FMain.ProntaEntregaemaberto1);
       CriaTopico(3,2309,FMain.Compras1);
//       CriaTopico(3,2312,FMain.MdiaVendas1);
// 21.09.11 - reativado - janinia
       CriaTopico(3,2313,FMain.DetalheVendaConsig1);
//       CriaTopico(3,2314,FMain.ResumoConsigAberto1);
//       CriaTopico(3,2315,FMain.ConferePE1);
//       CriaTopico(3,2316,FMain.ConfereRC1);
// 02.06.05
       CriaTopico(3,2317,FMain.AtendimentoRepr1);
// 21.07.05
//       CriaTopico(3,2318,FMain.ResumoRegEspAbertp1);
// 22.08.05
//       CriaTopico(3,2319,FMain.MdiaVendasProntaEntrega1);
// 10.09.05
       CriaTopico(3,2320,FMain.CMV1);
// 21.09.05
//       CriaTopico(3,2321,FMain.MdiaVendasRegEspecial1);
// 26.09.05
//       CriaTopico(3,2322,FMain.InadimplnciaCheques1);
// 29.09.05
       CriaTopico(3,2323,FMain.VendaProduto1);
// 03.03.06
//       CriaTopico(3,2324,FMain.ConfereRE1);
// 18.04.06
//       CriaTopico(3,2325,FMain.RemessasMagazine1);
////////////////////////////////////////////////////////////////////
// 24.11.05
// 28.09.07
       CriaTopico(3,2324,FMain.EntradadeAbate1);
// 01.07.08
       CriaTopico(3,2325,FMain.SaidaAbate2);
// 23.09.08
       CriaTopico(3,2326,FMain.PosioCliente1);
// 24.12.08
       CriaTopico(3,2327,FMain.VendasComissoporGrupo1);
// 24.08.09
       CriaTopico(3,2328,FMain.AuditoriaFisItens1);
// 28.10.09
       CriaTopico(3,2329,FMain.Veiculos1);
// 03.12.09
       CriaTopico(3,2330,FMain.AuditoriaBaseItens1);
// 17.02.10
       CriaTopico(3,2331,FMain.RelCarga1);
// 22.02.10
       CriaTopico(3,2332,FMain.TransfCorrigidas1);
// 24.01.11
       CriaTopico(3,2333,FMain.ComissoAbate1);
// 13.06.19
       CriaTopico(3,2334,FMain.LotesFazenda1);
// 17.06.19
       CriaTopico(3,2335,FMain.ComissoBoiadeiros1);
// 14.01.20
       CriaTopico(3,2336,FMain.ConfAcrescimos1);
// 06.08.20
       CriaTopico(3,2337,FMain.LotesFazResumo1);

     CriaTopico(2,2450,FMain.PedidoVenda2);
       CriaTopico(3,2451,FMain.ReprCliente1);
       CriaTopico(3,2457,FMain.ReprProduto1);
       CriaTopico(3,2452,FMain.PeasPendente1);
       CriaTopico(3,2453,FMain.PedidosVenda2);
       CriaTopico(3,2458,FMain.RelImpPedidos1);
       CriaTopico(3,2454,FMain.MaisVendiso1);
         CriaTopico(4,2455,FMain.ProdutosPedidos);
         CriaTopico(4,2456,FMain.ProdutoRepresentante1);
// 22.01.14
       CriaTopico(3,2459,FMain.cmvproducao);

// 17.05.05
     CriaTopico(2,2500,FMain.Auditorias1);

       CriaTopico(3,2501,FMain.TransaesCanceladas1);
       CriaTopico(3,2502,FMain.EvoluoCusto1);   // 19.01.06
       CriaTopico(3,2503,FMain.ComparativoInventrios1);   // 20.02.06
       CriaTopico(3,2504,FMain.ChecaSaldo1);   // 23.03.06
       CriaTopico(3,2506,FMain.NotascomFinanceiro1);   // 26.06.07

// 26.04.06
     CriaTopico(2,2530,FMain.PrPedidos2);
       CriaTopico(3,2531,FMain.Atendimento2);
       CriaTopico(3,2532,FMain.Relacaoprepedidos);
// 12.06.06
     CriaTopico(2,2550,FMain.Compras3);
       CriaTopico(3,2551,FMain.ImpressoPedido1);
       CriaTopico(3,2552,FMain.Recebimento1);
       CriaTopico(3,2553,FMain.ExtratoMatriaPrima1);
       CriaTopico(3,2554,FMain.ExtratoMatPrimaResumido1);
       CriaTopico(3,2555,FMain.ContagemRecebimento1);

// 12.06.06
     CriaTopico(2,2560,FMain.Malote1);
       CriaTopico(3,2561,FMain.ChequesRecebidos3);
       CriaTopico(3,2562,FMain.PendentesRepr2);

// 16.01.08
     CriaTopico(2,2570,FMain.Produo1);
       CriaTopico(3,2571,FMain.Cortes1);
       CriaTopico(3,2572,FMain.Barras1);
       CriaTopico(3,2573,FMain.ItensdaObra1);
       CriaTopico(3,2574,FMain.CortescomEstoque1);
// 22.09.08
     CriaTopico(2,2580,FMain.RelNaoConformidade1);
       CriaTopico(3,2581,FMain.RelPlanodeAcao1);
//       CriaTopico(3,2582,FMain.NoConformidadePendente1);
       CriaTopico(3,2583,FMain.IndicadoresdeResultado2);

// 09.10.13
     CriaTopico(2,2590,FMain.Equipamentos);
       CriaTopico(3,2591,FMain.FichaTecnica);
       CriaTopico(3,2592,FMain.Notasequipamentos);
       CriaTopico(3,2593,FMain.PrximasTrocas1);
       CriaTopico(3,2594,FMain.MediaConsumo1);
// 14.08.17
     CriaTopico(2,2600,FMain.Carregamento1);
       CriaTopico(3,2601,FMain.Carregados1);
// 29.04.20
       CriaTopico(3,2602,FMain.ComissaoMotoristas1);


// 04.07.11 - modulo ECF
  CriaTopico(1,3400,FMain.ECF1);
     CriaTopico(2,3401,FMain.CupomFiscal1);
//      CriaTopico(3,3411,FGerenciaEcf.bmarcacf);
     CriaTopico(2,3402,FMain.LeituraX1);
     CriaTopico(2,3403,FMain.ReducaoZ);
     CriaTopico(2,3404,FMain.CancelaCupom1);
     CriaTopico(2,3410,FMain.OpcoesEcf);

  CriaTopico(1,3100,FMain.Configuracoes);
     CriaTopico(2,3101,FMain.ConfiguracaoGeral);
// 23.01.18 - Novicarnes
     CriaTopico(2,3102,FMain.Periodos1);
     CriaTopico(2,3105,FMain.ConfiguraoDaUnidade1);
//     CriaTopico(2,3106,FMain.ConfigImpPadro1);

  CriaTopico(1,3200,FMain.Utilitarios);
    CriaTopico(2,3203,FMain.UsuriosAtivos1);
    CriaTopico(2,3204,FMain.ReorganizarBancoDados1);
    CriaTopico(2,3205,FMain.RelLogs1);
    CriaTopico(2,3206,FMain.ImpviaSintegra1);
    CriaTopico(2,3207,FMain.ImpEstoqueDbf1);
    CriaTopico(2,3208,FMain.ImpEstoqueviaTexto1);
    CriaTopico(2,3209,FMain.RenumeraNotas1);
    CriaTopico(2,3210,FMain.ImpContasGerenciais1);
    CriaTopico(2,3211,FMain.CodigoBarra1);
    CriaTopico(2,3212,FMain.ImpClientesTexto1);
    CriaTopico(2,3213,FMain.ImportaContagemEstoque1);
    CriaTopico(2,3214,FMain.ImportaEstoqueXML1);


end;

procedure TFUsuarios.CriaTopicosOutrosAcessos;
////////////////////////////////////////////////

   procedure CriaTopico(n,p:Integer;s:String);
   //////////////////////////////////////////////////
   begin
     if p>4000 then AvisoErro('Posi��o inv�lida para t�picos2 de acesso de usu�rios: '+IntToStr(p));
     FGrUsuarios.CriaTopico2(n,p,s);
     FUsuarios.CriaTopico2(n,p,s);
   end;

begin

  CriaTopico(0,0001,'Cadastros');

    CriaTopico(2,0010,'Gerenciar estoque f�sico');
    CriaTopico(2,0011,'Gerenciar custos zerados');
    CriaTopico(2,0031,'Libera��o remessas de consigna��o ap�s per�odo permitido');
//    CriaTopico(2,0032,'Libera��o acima limite cr�dito');
    CriaTopico(2,0033,'Atualizar pre�o de venda');
    CriaTopico(2,0034,'Mudar pre�o de venda em nota de saida');
    CriaTopico(2,0035,'Mudar pre�o de venda em nota de entrada');
    CriaTopico(2,0036,'Liberado uso do campo de situa��o do cliente');
    CriaTopico(2,0037,'Libera��o de faturamento com pre�o de venda abaixo do pre�o m�nimo');
    CriaTopico(2,0038,'Permitido incluir/alterar limite cr�dito de clientes');
    CriaTopico(2,0039,'Permitido liberar cr�dito de clientes acima do limite');
// 13.05.08
    CriaTopico(2,0040,'Permitido digitar peso na entrada de abate');
    CriaTopico(2,0041,'Permitido digitar peso(qtde) na nota de saida');
// 16.07.08
    CriaTopico(2,0042,'Permitido vender para cliente sem cr�dito');
// 28.07.08
    CriaTopico(2,0043,'Permitido lan�ar documentos fora do per�odo permitido em DIAS');
// 30.03.09
    CriaTopico(2,0044,'Permitido alterar percentuais de impostos na forma��o do pre�o de venda da obra');
// 11.05.09
    CriaTopico(2,0045,'Permitido alterar indicadores de outros usu�rios');
// 10.06.09
    CriaTopico(2,0046,'Permitido alterar indicador Previsto');
// 28.07.09
    CriaTopico(2,0047,'Permitido alterar valor unit�rio do perfil na forma��o do pre�o de venda da obra');
// 11.08.09
    CriaTopico(2,0048,'Permitido manipular or�amento de obra feitos por outros usu�rios');
// 19.10.09
    CriaTopico(2,0049,'Permitido ver valores no relat�rio de posi��o de estoque');
// 27.10.09
    CriaTopico(2,0050,'Permitido informar valores na nota de entrada em compras');
// 19.11.09
    CriaTopico(2,0051,'Permitido fazer transfer�ncia mensal do estoque fora do periodo permitido para digita��o');
// 13.04.10 - Lam. Sao Caetano
    CriaTopico(2,0052,'Permitido listar toda a movimenta��o de cr�dito de madeira');
// 23.02.11 - Dist. Bavi
    CriaTopico(2,0053,'Permitido visualizar informa��es do estoque na tela de consulta via F12');
// 13.06.11 - Novi - entrar direto no formulario de pesagem
    CriaTopico(2,0054,'Acessa o sistema direto no formul�rio de PESAGEM de Saida');
// 24.01.12 - Novi - impressao de etiqueta com mapeamento da lpt1
    CriaTopico(2,0055,'Imprime etiqueta do estoque e PESAGEM de saida mapeando a LPT1');
// 06.12.13 - vivan - altera pre�o de venda de todas as unidade do usuario
    CriaTopico(2,0056,'Atualiza pre�o de venda de todas as unidade que o usu�rio tem acesso');
// 13.09.15 - Novi - entrar direto no formulario de pesagem de entrada de abate
    CriaTopico(2,0057,'Acessa o sistema direto no formul�rio de PESAGEM de Entrada de Abate');
// 09.11.15 - Vivan - valores por portador
    CriaTopico(2,0058,'Ativa lan�amento de valores por portador no acerto do CONSIGNADO');
// 13.05.16 - Benato
    CriaTopico(2,0059,'Lembrete de produtos que est�o chegando na validade');
// 19.07.16 - Novi - entrar direto no formulario de pesagem de caminhao
    CriaTopico(2,0060,'Acessa o sistema direto no formul�rio de PESAGEM de CAMINH�O');
// 01.11.16 - Fama - Janina
    CriaTopico(2,0061,'Libera campo TABELA nas REMESSAS do consignado');
// 28.12.16
    CriaTopico(2,0062,'Permite definir fornecedor para lan�ar direto em PENDENCIAS');
// 15.02.17
    CriaTopico(2,0063,'Mostra cadastro do ESTOQUE com linhas coloridas');
// 03.03.17 - Novi - entrar direto no formulario de pesagem de caminhao
    CriaTopico(2,0064,'Acessa o sistema direto no formul�rio de PESAGEM AVULSA de CAMINH�O');
// 14.05.19 - Novi - poder excluir romaneio de entrada mesmo com nota feita
//            pra ser usado em caso de entrada de abate reajustada ( peso )
//            cuja entrada e gerada na op�ao 'reajuste pesos' na entrada de abate
    CriaTopico(2,0065,'Permite excluir entradas de abate mesmo com nota/romaneio feita');
// 09.12.19
    CriaTopico(2,0066,'Permite visualizar CNPJ/CPF de CLIENTES/FORNECEDORES e tirar RELAT�RIOS do cadastro');
// 16.01.20
    CriaTopico(2,0067,'Imprime ETIQUETA do ABATE conforme modelo da ADAPAR');
// 07.07.2021
    CriaTopico(2,0068,'Atualizar pre�o de venda com o pre�o informado na NOTA DE SAIDA e PEDIDO DE VENDA');
// 09.09.2021
    CriaTopico(2,0069,'Mostra formul�rio do TELEMARKETING pendente');

///////////////////////////////////////////////////////////////
///
  CriaTopico(1,0300,'Faturamento');

///////////////////////////////////////////////////////////////
    CriaTopico(2,0301,'Permitido faturar venda abaixo do pre�o m�nimo');
// 05.06.07
    CriaTopico(2,0302,'Libera��o venda mesmo acima limite cr�dito');
// 12.06.07
    CriaTopico(2,0303,'Permitido cancelar transa��o referente nota fiscal');
// 13.08.07
    CriaTopico(2,0304,'Ativar campo desconto unit�rio na nota de saida');
    CriaTopico(2,0305,'Ativar campo tamanho na nota de saida');
    CriaTopico(2,0306,'Ativar campo tabela desconto/acresc. na nota de saida');
    CriaTopico(2,0307,'Ativar campo frete na nota de saida');
    CriaTopico(2,0308,'Ativar campo seguro na nota de saida');
    CriaTopico(2,0309,'Ativar campo pedido na nota de saida');
// 14.09.07
    CriaTopico(2,0310,'Permitido digitar nota de entrada fora do mes atual');
// 30.01.08
    CriaTopico(2,0311,'Ativar checagem de retorno de or�amentos de venda');
// 30.05.08
    CriaTopico(2,0312,'N�o Mostra valor da arroba na entrada de abate');
// 01.09.08
    CriaTopico(2,0313,'Permitido alterar a data de emiss�o da nota de saida');
// 17.10.08
    CriaTopico(2,0314,'Libera��o momentanea de venda abaixo do pre�o m�nimo');
// 24.11.08
    CriaTopico(2,0315,'Libera��o momentanea de venda mesmo acima limite cr�dito');
// 30.12.08
    CriaTopico(2,0316,'Libera��o de venda mesmo sem cr�dito em metros c�bicos');
// 22.04.09
    CriaTopico(2,0317,'Permitido imprimir contrato de venda');
// 07.07.09
    CriaTopico(2,0318,'Permitido alterar numera��o nota de saida na altera��o gerencial de notas');
// 16.07.09
    CriaTopico(2,0319,'Permitido gerenciar nota de saida');
// 23.10.09 - Capeg - Leonir
    CriaTopico(2,0320,'Permitido informar vencimento anterior a data atual na nota de entrada');
// 30.10.09
    CriaTopico(2,0321,'Permitido gerenciar nota de entrada');
// 09.03.10   - Novicanres
    CriaTopico(2,0322,'Permitido gerar nota a partir da saida de abate( pedido de venda )');
// 13.05.10   - Novicanres - Vava
    CriaTopico(2,0323,'Permitido personalizar o % de desconto do inss em nf de produtor rural no cadastro de clientes');
// 02.03.11   - Bavi,...
    CriaTopico(2,0324,'Permitido personalizar a grade de produtos da nota de entrada');
    CriaTopico(2,0325,'Permitido personalizar a grade de produtos da nota de saida');
// 23.05.11 - NOvi
    CriaTopico(2,0326,'Permiss�o moment�nea para faturar venda abaixo do pre�o m�nimo POR CIDADE');
// 11.08.11 - SEFA PR
    CriaTopico(2,0327,'Gerar registros 53,85 e 86 no arquivo do Sintegra');
// 06.01.12 - Benatto - venda balcao
    CriaTopico(2,0328,'Inibe campos refente volumes e pesos para agilizar a venda');
// 17.01.12 - Benatto - venda balcao
    CriaTopico(2,0329,'Imprime cupom fiscal logo ap�s gravar');
// 03.02.12 - Giacomoni - XML 'nao autorizado'
    CriaTopico(2,0330,'Permitido importar XML n�o autorizado na nota de entrada');
// 13.02.12 - Benato - balan�a que 'espera pedir' o peso
    CriaTopico(2,0331,'Usa balan�a de checkout na nota de saida/cupom fiscal');
// 14.06.12 - busca o xml na consulta completa NFe no portal nacional
    CriaTopico(2,0332,'Permitido usar op��o Busca NFe na nota de entrada');
// 27.08.12 - Novi - Adsl 10 megas 'do daniel/Oi'
    CriaTopico(2,0333,'Utiliza programa UniNfe para autorizar NFe na Sefa');
// 22.04.13 - Abra chapeco
    CriaTopico(2,0334,'Mostrar consulta do estoque no F12 sem usar o NCM na nota de entrada quando importa XML');
// 22.04.13
    CriaTopico(2,0335,'Permite importar o mesmo pedido de venda v�rias vezes ( PARCIAL )');
// 01.08.13 - Vivan 'de novo'...toke...
    CriaTopico(2,0336,'Permite acertar notas de acerto(VC) a Vista que ficaram com valor diferente no caixa/bancos');
// 03.03.14 - SM+Benato
    CriaTopico(2,0337,'Mostra lembrete sobre valor estimado a faturar');
// 11.05.15 - Damama
    CriaTopico(2,0338,'Le o peso da balan�a buscando o valor ( codigos iniciado com 2 ) na venda balc�o');
// 18.05.15 - coorlaf pitanga
    CriaTopico(2,0339,'Ativa campo de codigo de cliente na impress�o da NF-e');
// 18.05.15 - Damama
    CriaTopico(2,0340,'Permite alterar a data de emiss�o na Venda BALC�O');
// 25.05.15 - Coorlaf
    CriaTopico(2,0341,'Imprime nota fiscal de saida em impressora matricial na Venda BALC�O');
// 04.07.15 - Coorlaf
    CriaTopico(2,0342,'Lembrete de NF-e emitidas e n�o autorizadas');
// 27.04.16 - Yume - Giana
    CriaTopico(2,0343,'Agiliza fechamento da venda na nota de saida');
// 21.06.16 - Vivan Financeiro
    CriaTopico(2,0344,'Permite escolher se inutiliza ou n�o a numera��o de notas eletr�nicas');
// 07.11.16 - opcao de escolher o portador quando passa na venda balcao para cartao de debito ou credito
    CriaTopico(2,0345,'Permite escolher o PORTADOR na VENDA BALC�O');
// 30.04.18 - NOvicarnes - roseeeeeeeeee
    CriaTopico(2,0346,'Permitido cancelar transa��o referente nota fiscal DE ENTRADA mas n�o eletr�nica');
// 31.12.18 - Fama
    CriaTopico(2,0347,'Permitido alterar pre�o de venda somente em VENDA COM CUPOM FISCAL');
// 16.02.19 - Vida Nova
    CriaTopico(2,0348,'Imprime relatorio gerencial VENDAS pela DATA DE SAIDA');
// 04.02.20 - Novicarnes
    CriaTopico(2,0349,'Imprime BOLETO E NFE logo ap�s PESAGEM do pedido');
// 18.03.20 - Novicarnes
    CriaTopico(2,0350,'Ativa VISUALIZA��O de NFE quando escolhe somente uma nota');
// 06.04.20 - Novicarnes
    CriaTopico(2,0351,'Ativa digita��o do ano com 4 casas no VENCIMENTO da NOTA DE SAIDA');
// 31.08.20
    CriaTopico(2,0352,'Libera envio de DANFE via WHATSAPP');
// 16.08.2021
    CriaTopico(2,0353,'Ativa NFC-e em conting�ncia OFFLINE');
// 30.08.2021 - Devereda - Suelen  - parametro 'do sistema' para 'do usuario'
    CriaTopico(2,0354,'Permite escolher cliente na NFC-e');
// 25.08.2022 - Clessi - Nota de entrada de compra de mat. de uso e consumo porem importado...
    CriaTopico(2,0355,'Permite alterar base e valor do ICMS-ST importados do XML na NOTA DE ENTRADA');

//////////////////////////////////////////////////////////////////////
  CriaTopico(1,0400,'N�o Conformidade');
//////////////////////////////////////////////////////////////////////
    CriaTopico(2,0401,'Permitido acesso aos planos de a��o de todos os usu�rios');
// 20.10.08
    CriaTopico(2,0402,'Ativar checagem de planos de a��o pendentes');
// 03.11.08
    CriaTopico(2,0403,'Ativar checagem de RNCs pendentes');
    CriaTopico(2,0404,'Libera digita��o de Produtos N�o Conformes');

// 26.09.09
  CriaTopico(1,0500,'Pedidos');
////////////////////////////////////////////////////////////////
    CriaTopico(2,0501,'Permitido digitar pre�o unit�rio no pedido de venda');
    CriaTopico(2,0502,'Confirma��o de atendimento de pedido de venda');
    CriaTopico(2,0503,'Trata Pedido de Venda para Frigor�fico');
    CriaTopico(2,0504,'Usa refer�ncia ou do codigo produto no pedido de venda');
    CriaTopico(2,0505,'Habilita cor e tamanho no pedido de venda');
    CriaTopico(2,0506,'Habilita campo de peso/cubagem no pedido de venda');
// 17.07.14 - Metalforte
    CriaTopico(2,0507,'Permite alterar a data do pedido de venda');
// 03.09.14 - Benato
    CriaTopico(2,0508,'Inibe campo de tabela no pedido de venda');
// 19.04.15 - Novicarnes
    CriaTopico(2,0509,'N�o permite informar o PESO na pesagem do pedido de venda');
// 09.11.15 - Novicarnes
    CriaTopico(2,0510,'Permite visualizar a impress�o na ENTRADA DE ABATE');
// 20.05.16 - Devereda
    CriaTopico(2,0511,'Mostra ocorr�ncias do cliente');
// 15.06.16 - Novicarnes
    CriaTopico(2,0512,'Pesagem pedido de venda somente lendo codigo da etiqueta');
// 27.06.16 - Novicarnes
    CriaTopico(2,0513,'Permite digitar peso na pesagem da carga/caminh�o');
// 15.09.16 - Novicarnes
    CriaTopico(2,0514,'Imprime etiqueta de ENTRADA DE ABATE usando ARQUIVO .PRN');
// 03.10.16 - Novicarnes  - zebra lazarenta
    CriaTopico(2,0515,'Imprime ROMANEIO de ENTRADA DE ABATE usando ARQUIVO .PRN');
// 24.05.17 - Novicarnes  - vanderlei
    CriaTopico(2,0516,'Permite pesar o pedido de venda pela ETIQUETA ou pelo CODIGO');
// 10.07.17 - Novicarnes
    CriaTopico(2,0517,'Imprime etiqueta dos CORTES na CAMARA FRIA atrav�s de modelo fixo do sistema');
// 19.12.17 - Novicarnes
    CriaTopico(2,0518,'Permite alterar peso e valor unit�rio na PESAGEM DE SAIDA');
// 05.03.20 - Balan�a para restaurantes
    CriaTopico(2,0519,'Ativa uso de BALAN�A para restaurante');

// 20.05.10
  CriaTopico(1,0600,'Pronta Entrega');
//////////////////////////////////////////////////////////////////////
    CriaTopico(2,0601,'Permitido digitar pre�o unit�rio no pedido de venda');

//////////////////////////////////////////////////////////////////////
  CriaTopico(1,0700,'Financeiro');
////////////////////////////////////////////////////////////////
    CriaTopico(2,0701,'Gerenciar valores de todas as contas');
    CriaTopico(2,0702,'Baixa e lan�amento no caixa/bancos e nf de saida em data diferente da corrente');
    CriaTopico(2,0703,'Libera��o de pedidos de venda para faturamento');
    CriaTopico(2,0704,'Baixa de pedidos de venda direto no pr�prio pedido');
    CriaTopico(2,0705,'Libera digita��o data de baixa pedidos de venda');
    CriaTopico(2,0706,'Libera venda  para cliente com restri��o de cr�dito');
    CriaTopico(2,0707,'Permite informar codigo do cliente/representante no caixa/bancos');
    CriaTopico(2,0708,'Permite baixar pendencia com juro menor que o calculado');
    CriaTopico(2,0709,'Permite informar conta rec/despesa no lan�amento de pend�ncia financeira');
// 16.11.07
    CriaTopico(2,0710,'Permite informar contas n�o configuradas de juros/descontos na baixa de pend�ncias');
// 14.03.08
    CriaTopico(2,0711,'Mostra somente as pend�ncias da unidade em uso na baixa de t�tulos');
// 27.11.08
    CriaTopico(2,0712,'Libera��o momentanea de venda mesmo com restri��o de cr�dito');
// 20.04.09
    CriaTopico(2,0713,'Permite altera��o de valor em pendencias financeiras N�O provisionadas via nota fiscal');
// 19.10.09
    CriaTopico(2,0714,'Mostra lembrete de pend�ncias financeiras a pagar pendentes ao entrar no sistema');
// 27.11.09
    CriaTopico(2,0715,'N�o permite acessar conta de receita/despesa na baixa de pendencias');
// 30.04.12 - Abra -
    CriaTopico(2,0716,'Permite escolher contas na exporta��o cont�bil do caixa/bancos');
// 04.03.13 - Vivan Cobran�a
    CriaTopico(2,0717,'Permite imprimir boleto/duplicata no acerto do consignado');
// 03.09.13 - Metalforte
    CriaTopico(2,0718,'Permite alterar vencimentos na baixa de pendencia');
// 24.02.14 - Vivan
    CriaTopico(2,0719,'N�o permite alterar emiss�o do cheque recebido');
// 24.02.14 - Metalforte
    CriaTopico(2,0720,'Permite alterar valor de parcela na op��o de baixa de pend�ncias');
// 04.06.14 - Giacomoni
    CriaTopico(2,0721,'Permite fazer boleto de todos os tipos de movimento');
// 21.10.14 - Mama
    CriaTopico(2,0722,'Permite baixar pendencia em unidade diferente em que o t�tulo foi lan�ado');
// 24.08.15 - Mama
    CriaTopico(2,0723,'Libera op��o de lan�ar o acerto mensal de funcion�rios no caixa');
// 16.06.16 - Alutech - Robson
    CriaTopico(2,0724,'Mostra lembrete de pend�ncias financeiras a receber pendentes ao entrar no sistema');
// 24.09.19 - Novicarnes -  Sandro
    CriaTopico(2,0725,'Traz como sugest�o a data do VENCIMENTO na BAIXA DE PAGAMENTOS');

//////////////////////////////////////////////////////////////////////
  CriaTopico(1,3300,'Relat�rios');
//////////////////////////////////////////////////////////////////////
    CriaTopico(2,3301,'Cria��o De Formatos');
    CriaTopico(2,3302,'Impress�o De Relat�rios');
    CriaTopico(2,3303,'Grava��o De Relat�rios');
    CriaTopico(2,3304,'Visualiza��o De Gr�ficos');
    CriaTopico(2,3305,'Grava��o Rec�lculo Estoque');
    CriaTopico(2,3306,'Salvar relat�rio texto');
// 27.09.07
    CriaTopico(2,3307,'Envio de relat�rio via email');
// 23.07.09
    CriaTopico(2,3308,'Gerar Invent�rio baseado na posi��o estoque');
// 26.08.10
    CriaTopico(2,3309,'Impress�o de relat�rios "fixos e ajustados" em impressora laser/jato');

end;





function TFUsuarios.GetSenhaSupervisor: boolean;
var Form: TForm;
    Edts,Edtc:TSqlEd;
    ContadorSenha,Usuario:Integer;
    B:TBevel;
    Q:TSqlquery;
begin
  ContadorSenha:=0;
  Result:=false;
  Screen.Cursor:=crDefault;
  Global.SistemaParado:=True;
  Usuario:=Global.Usuario.Codigo;   // 09.01.06
  while ContadorSenha<=2 do begin
    Inc(ContadorSenha);
    Result:=false;
    Form := TForm.Create(Application);
    with Form do begin
      BorderStyle := bsDialog;
      Caption := 'Usu�rio e Senha De Acesso';
      Color:=clCream;
      SetBounds(225,220,220,100);
      Position:=poScreenCenter;
      B:=TBevel.Create(Form);
      B.Align:=alClient;
      B.Parent:=Form;
      Edtc:=TSqlEd.Create(Form);
      with Edtc do begin
        Parent := Form;
        TypeValue:=tvInteger;
        TitlePos:=tppLeft;TitlePixels:=120;
        Title:='C�digo Do Usu�rio';
        TitleFont.Style:=[fsBold];
        SetBounds(135,10,55,25);
      end;
      Edts:=TSqlEd.Create(Form);
      with Edts do begin
        Parent := Form;
        PasswordChar:='*';
        CharCase:=ecUpperCase;
        MaxLength:=10;
        CloseForm:=True;
        TitlePos:=tppLeft;TitlePixels:=120;
        Title:='Senha Do Usu�rio';
        TitleFont.Style:=[fsBold];
        SetBounds(135,40,55,25);
      end;
      Form.ActiveControl:=Edtc;
      ShowModal;
//      if Inteiro(Edtc.Text)=0 then begin
//         Application.Terminate;
//         Break;
//      end;
//      if not Global.Usuario.OutrosAcessos[0031] then
      if not EdTc.isempty then begin
        if GetUsuario(Edtc.Text,Edts.Text) then begin
          Q:=sqltoquery('select * from usuarios where usua_codigo='+Edtc.assql);
          if Q.eof then
            Avisoerro('usu�rio n�o encontrado')
          else if copy(Q.fieldbyname('usua_outrosacessos').asstring,31,1)<>'S' then
//          Global.Usuario.OutrosAcessos[0031] then
             Avisoerro('Usu�rio sem permiss�o de libera��o de remessas')
          else if not GetUsuario(Edtc.Text,Edts.Text) then begin
             if ContadorSenha=3 then begin
                AvisoErro('Permiss�o negada');
             end;
          end else begin
             Result:=true;
             Break;
          end;
        end;
      end;
    end;
    Form.Free;
  end;
  Global.SistemaParado:=False;
  Global.Usuario.Codigo:=Usuario;   // 09.01.06   - ficava o usuario q autorizou ao inves do q digitou


end;

//////////////////// 24.04.06
function TFUsuarios.GetSenhaAutorizacao(posicao: integer): Integer;
////////////////////////////////////////////////////////////////////
var Form: TForm;
    Edts,Edtc:TSqlEd;
    ContadorSenha,Usuario:Integer;
    B:TBevel;
    Q:TSqlquery;
begin
  ContadorSenha:=0;
  Result:=0;
  Screen.Cursor:=crDefault;
  Global.SistemaParado:=True;
  Usuario:=Global.Usuario.Codigo;   // 09.01.06
  while ContadorSenha<=2 do begin
    Inc(ContadorSenha);
    Result:=0;
    Form := TForm.Create(Application);
    with Form do begin
      BorderStyle := bsDialog;
      Caption := 'Usu�rio e Senha De Autoriza��o';
      Color:=clCream;
      SetBounds(225,220,220,100);
      Position:=poScreenCenter;
      B:=TBevel.Create(Form);
      B.Align:=alClient;
      B.Parent:=Form;
      Edtc:=TSqlEd.Create(Form);
      with Edtc do begin
        Parent := Form;
        TypeValue:=tvInteger;
        TitlePos:=tppLeft;TitlePixels:=120;
        Title:='C�digo Do Usu�rio';
        TitleFont.Style:=[fsBold];
        SetBounds(135,10,55,25);
      end;
      Edts:=TSqlEd.Create(Form);
      with Edts do begin
        Parent := Form;
        PasswordChar:='*';
        CharCase:=ecUpperCase;
        MaxLength:=10;
        CloseForm:=True;
        TitlePos:=tppLeft;TitlePixels:=120;
        Title:='Senha Do Usu�rio';
        TitleFont.Style:=[fsBold];
        SetBounds(135,40,55,25);
      end;
      Form.ActiveControl:=Edtc;
      ShowModal;
//      if Inteiro(Edtc.Text)=0 then begin
//         Application.Terminate;
//         Break;
//      end;
//      if not Global.Usuario.OutrosAcessos[0031] then
      if not EdTc.isempty then begin
        if GetUsuario(Edtc.Text,Edts.Text,global.usuario.codigo) then begin
          Q:=sqltoquery('select * from usuarios where usua_codigo='+Edtc.assql);
          if Q.eof then
            Avisoerro('usu�rio n�o encontrado')
          else if copy(Q.fieldbyname('usua_outrosacessos').asstring,posicao,1)<>'S' then
//          Global.Usuario.OutrosAcessos[0031] then
             Avisoerro('Usu�rio sem permiss�o deste tipo de autoriza��o')
          else if not GetUsuario(Edtc.Text,Edts.Text) then begin
             if ContadorSenha=3 then begin
                AvisoErro('Permiss�o negada');
             end;
          end else begin
             Result:=EdTc.asinteger;
             Break;
          end;
        end else // 05.06.06 - sair sem informar nada
          close;
      end
    end;
    Form.Free;
  end;
  Global.SistemaParado:=False;
  Global.Usuario.Codigo:=Usuario;
end;

procedure TFUsuarios.bliberavendaClick(Sender: TObject);
////////////////////////////////////////////////////////////////
begin
  if not confirma('Confirma libera��o venda abaixo do m�nimo para usu�rio '+Arq.TUsuarios.fieldbyname('usua_nome').asstring+' ?')
    then exit;
   sistema.beginprocess('gravando');
   Sistema.Edit('usuarios');
   Sistema.SetField('Usua_OutrosAcessos',copy(Arq.TUsuarios.FieldByName('Usua_OutrosAcessos').AsString,1,313)+'S'+
                     copy(Arq.TUsuarios.FieldByName('Usua_OutrosAcessos').AsString,315,4000-315));
   Sistema.Post('usua_codigo='+inttostr(Arq.TUsuarios.fieldbyname('usua_codigo').asinteger));
   FGeral.GravaLog(15,'Usu�rio '+inttostr(Global.Usuario.codigo)+' autorizou usu�rio '+inttostr(Arq.TUsuarios.fieldbyname('usua_codigo').asinteger),false);
   try
     sistema.Commit;
     Sistema.endprocess('Autorizado');
   except
     Sistema.endprocess('Problemas na grava��o');
   end;
end;

procedure TFUsuarios.bigualarClick(Sender: TObject);
var CodOrigem,CodDestino:String;
    Q:TSqlQuery;

    procedure SetaAcessosDiversos(Tabela,CampoIndice,CampoAcessos:String);
    var Q:TSqlQuery;
        po,pd:Integer;
        s:String;
        Gravar:Boolean;
    begin
      Q:=SqlToQuery('select '+CampoIndice+','+CampoAcessos+' from '+Tabela);
      while not Q.Eof do begin
        s:=';'+Trim(Q.FieldByName(CampoAcessos).AsString)+';';
        Gravar:=False;
        po:=Pos(';'+CodOrigem+';',s);
        pd:=Pos(';'+CodDestino+';',s);
        if (pd>0) and (po=0) then begin
           Delete(s,pd,Length(CodDestino)+1);
           Gravar:=True;
        end else if (po>0) and (pd=0) then begin
           s:=s+CodDestino+';';
           Gravar:=True;
        end;
        if Gravar then begin
           s:=SubStr(s,2,Length(s)-2);
           Sistema.Edit(Tabela);
           Sistema.SetField(CampoAcessos,s);
           Sistema.Post(CampoIndice+'='+StringToSql(Q.FieldByName(CampoIndice).AsString));
        end;
        Q.Next;
      end;
      Sistema.Commit;
      Q.Close;Q.Free;
    end;

begin

  if not Input('Igualar Acessos','C�digo Usu�rio Origem',CodOrigem,4,True) then Exit;
  if CodOrigem='' then Exit;
  CodDestino:=IntToStr(Arq.TUsuarios.FieldByName('usua_codigo').AsInteger);
  Q:=SqlToQuery('select * from usuarios where usua_codigo='+CodOrigem);
  if Q.isEmpty then begin
     AvisoErro('Usu�rio origem n�o cadastrado');
     Q.Close;Q.Free;
     Exit;
  end;
  if Confirma('Confirma a atribui��o dos acessos do usu�rio '+Q.FieldByName('usua_nome').AsString+' ao usu�rio '+Arq.TUsuarios.FieldByName('usua_nome').AsString) then begin
     Sistema.Edit('Usuarios');
     Sistema.SetField('Usua_ObjetosAcessados',Q.FieldByName('Usua_ObjetosAcessados').AsString);
     Sistema.SetField('Usua_OutrosAcessos',Q.FieldByName('usua_outrosacessos').AsString);
     Sistema.SetField('Usua_UnidadesMvto',Q.FieldByName('Usua_UnidadesMvto').AsString);
     Sistema.SetField('Usua_UnidadesRelatorios',Q.FieldByName('Usua_UnidadesRelatorios').AsString);
     Sistema.Post('usua_codigo='+CodDestino);
     Sistema.Commit;
  end;
  Q.Close;Q.Free;
  Arq.TUsuarios.Refresh;
  Application.ProcessMessages;
  Atualizar;
  Topicos1.Refresh;
  Topicos2.Refresh;
  Application.ProcessMessages;
  FGeral.GravaLog(17,'Usuario: '+IntToStr(Arq.TUsuarios.FieldByName('usua_codigo').AsInteger)+' - '+Arq.TUsuarios.FieldByName('usua_nome').AsString+' com acessos do usu�rio '+CodOrigem);
  Aviso('Processo conclu�do');
end;

function TFUsuarios.UsuarioProduto(Codigo: Integer):boolean;
var Q:TSqlquery;
begin
  result:=false;
  Q:=SqlToQuery('select * from usuarios where usua_codigo='+inttostr(Codigo));
  if not Q.eof then begin
    if copy( Q.fieldbyname('usua_outrosacessos').AsString ,0404,1 ) = 'S' then
      result:=true;
  end;
  FGeral.FechaQuery(Q);

end;

procedure TFUsuarios.bliberacreditoClick(Sender: TObject);
begin
  if not confirma('Confirma libera��o venda acima limite de cr�dito para usu�rio '+Arq.TUsuarios.fieldbyname('usua_nome').asstring+' ?')
    then exit;
   sistema.beginprocess('gravando');
   Sistema.Edit('usuarios');
   Sistema.SetField('Usua_OutrosAcessos',copy(Arq.TUsuarios.FieldByName('Usua_OutrosAcessos').AsString,1,314)+'S'+
                     copy(Arq.TUsuarios.FieldByName('Usua_OutrosAcessos').AsString,316,4000-316));
   Sistema.Post('usua_codigo='+inttostr(Arq.TUsuarios.fieldbyname('usua_codigo').asinteger));
   FGeral.GravaLog(16,'Usu�rio '+inttostr(Global.Usuario.codigo)+' autorizou usu�rio '+inttostr(Arq.TUsuarios.fieldbyname('usua_codigo').asinteger),false);
   try
     sistema.Commit;
     Sistema.endprocess('Autorizado');
   except
     Sistema.endprocess('Problemas na grava��o ref. limite de cr�dito');
   end;

end;

procedure TFUsuarios.brestricaocreditoClick(Sender: TObject);
begin
  if not confirma('Confirma libera��o venda com restri��o  de cr�dito para usu�rio '+Arq.TUsuarios.fieldbyname('usua_nome').asstring+' ?')
    then exit;
   sistema.beginprocess('gravando');
   Sistema.Edit('usuarios');
   Sistema.SetField('Usua_OutrosAcessos',copy(Arq.TUsuarios.FieldByName('Usua_OutrosAcessos').AsString,1,711)+'S'+
                     copy(Arq.TUsuarios.FieldByName('Usua_OutrosAcessos').AsString,713,4000-713));
   Sistema.Post('usua_codigo='+inttostr(Arq.TUsuarios.fieldbyname('usua_codigo').asinteger));
   FGeral.GravaLog(16,'Usu�rio '+inttostr(Global.Usuario.codigo)+' autorizou usu�rio '+inttostr(Arq.TUsuarios.fieldbyname('usua_codigo').asinteger),false);
   try
     sistema.Commit;
     Sistema.endprocess('Autorizado');
   except
     Sistema.endprocess('Problemas na grava��o ref. restri��o cr�dito');
   end;

end;

procedure TFUsuarios.GravaOutrosAcessos(posicao,usuario:integer;conteudo:string);
///////////////////////////////////////////////////////////////////////////////////
var QUsuario:TSqlquery;
begin
  Qusuario:=SqlToQuery('select Usua_OutrosAcessos from usuarios where usua_codigo='+inttostr(usuario));
  if not QUsuario.eof then begin
    Sistema.Edit('usuarios');
    Sistema.SetField('Usua_OutrosAcessos',copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,1,posicao-1)+conteudo+
                      copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,posicao+1,4000-(posicao+1)));
    Sistema.Post('usua_codigo='+inttostr(usuario));
    sistema.Commit;
  end;
  FGeral.FechaQuery(QUsuario);
end;

/////////////////////////////////////// 27.08.12
function TFUsuarios.GetImpressoPedidoVenda(Codigo: Integer): String;
////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  result:='';
  campo:=Sistema.GetDicionario('usuarios','Usua_imppedido');
  if trim(campo.Tipo)='C' then begin
    Q:=SqlToQuery('select Usua_imppedido from usuarios where usua_codigo='+inttostr(Codigo));
    if not Q.eof then
        result:=Q.fieldbyname('Usua_imppedido').asstring;
    FGeral.FechaQuery(Q);
  end;
end;

// 10.09.14 - vivan...
procedure TFUsuarios.bPesquisarClick(Sender: TObject);
//////////////////////////////////////////////////////
begin
  if not confirma('Confirma zeramento de senha do usu�rio '+Arq.TUsuarios.fieldbyname('usua_codigo').AsString+' ?') then exit;
  Sistema.Edit('usuarios');
  Sistema.SetField('usua_senha',0);
  Sistema.Post('usua_codigo='+Arq.TUsuarios.fieldbyname('usua_codigo').AsString);
  Sistema.Commit;
  Arq.TUsuarios.Refresh;
end;

end.




