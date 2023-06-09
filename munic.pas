unit munic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, DB, Grids, DBGrids, SQLGrid, ExtCtrls,
  Buttons, SQLBtn, alabel,SqlExpr , SqlSis;

type
  TFCidades = class(TForm)
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
    EdMuni_codigo: TSQLEd;
    EdMuni_nome: TSQLEd;
    EdMuni_regi_codigo: TSQLEd;
    EdMuni_UF: TSQLEd;
    EdCida_populacao: TSQLEd;
    EdCida_codigoibge: TSQLEd;
    EdCida_codigopais: TSQLEd;
    EdCida_nomepais: TSQLEd;
    EdCida_fatminimo: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure EdMuni_regi_codigoExitEdit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdMuni_UFValidate(Sender: TObject);
    procedure EdMuni_nomeValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   function GetUF(Codigo:Integer):String;
   function GetNome(Codigo:Integer):String;
   function GetCodigoDFC(Codigo:Integer):String;
   function GetCodigoIBGE(Codigo:Integer):String;
   function GetCodigoPais(Codigo:Integer):String;
   function GetNomePais(Codigo:Integer):String;
   procedure Open;
// 23.05.11
   function ValidaFatporCidade(Codigo,Usuario,Numnota:Integer  ; ValorNota:currency):boolean;
// 14.03.12
   procedure SetaCodigosIbge(Ed:TSqled);
   function  GetCodigoListaIbge(xMuni_nome:string):string;

  end;

var
  FCidades: TFCidades;
  campo:TDicionario;

implementation

uses Arquiv,SqlFun, SQLRel, Geral, Regioes;

{$R *.dfm}


procedure TFCidades.FormActivate(Sender: TObject);
begin
  if not Arq.TMunicipios.Active then Arq.TMunicipios.Open;
  FGeral.SetaUFs(EdMuni_UF);
  Fgeral.ColunasGrid(Grid,Self);
// 14.03.12
  SetaCodigosIbge(EdCida_codigoibge);
  campo:=Sistema.GetDicionario('cidades','cida_codigopais');
  if campo.tipo<>'' then begin
    EdCida_codigopais.enabled:=true;
    EdCida_codigopais.Group:=0;
    EdCida_codigopais.OpGrids:=[ogedit,ogfind,ogfilter];
    EdCida_nomepais.enabled:=true;
    EdCida_nomepais.Group:=0;
    EdCida_nomepais.OpGrids:=[ogedit,ogfind,ogfilter];
  end else begin
    EdCida_codigopais.enabled:=false;
    EdCida_codigopais.Group:=23;
    EdCida_codigopais.OpGrids:=[];
    EdCida_nomepais.enabled:=false;
    EdCida_nomepais.Group:=23;
    EdCida_nomepais.OpGrids:=[];
  end;
// 23.05.11
  campo:=Sistema.GetDicionario('cidades','cida_fatminimo');
  if campo.tipo<>'' then begin
    EdCida_fatminimo.enabled:=true;
    EdCida_fatminimo.Group:=0;
    EdCida_fatminimo.OpGrids:=[ogedit,ogfind,ogfilter];
  end else begin
    EdCida_fatminimo.enabled:=false;
    EdCida_fatminimo.Group:=23;
    EdCida_fatminimo.OpGrids:=[];
  end;

end;

procedure TFCidades.Open;
begin
  if not Arq.TMunicipios.Active then Arq.TMunicipios.Open;
end;

procedure TFCidades.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdMuni_Nome);
  EdMuni_codigo.setvalue(FGeral.getsequencial(1,'cida_codigo','N','cidades'));
end;


procedure TFCidades.EdMuni_regi_codigoExitEdit(Sender: TObject);
begin
//  EdMuni_Codigo.SetValue(FGeral.GetContador('cida_Codigo',False));
  EdMuni_codigo.setvalue(FGeral.getsequencial(1,'cida_codigo','N','cidades'));
  Grid.PostInsert(EdMuni_Nome);
  EdMuni_codigo.setvalue(FGeral.getsequencial(1,'cida_codigo','N','cidades'));
end;


procedure TFCidades.bRelatorioClick(Sender: TObject);
var Q:TSqlQuery;
    campo1,campo2:TDicionario;
begin
  FRel.Init('CadCidades');
  FRel.AddTit('Rela��o Das Cidades Cadastradas');
  Sistema.BeginProcess('gerando relat�rio');
  FRegioes.Open;
  FRel.AddCol(50,3,'N','','','C�digo','','C�digo da cidade',False);
  FRel.AddCol(250,1,'C','','','Nome cidade','','Nome da cidade',False);
  FRel.AddCol(25,1,'C','','','UF','','UF da cidade',False);
  FRel.AddCol(70,1,'C','','','C�d Regi�o','','C�digo da regi�o',False);
  FRel.AddCol(250,1,'C','','','Nome Regi�o','','Nome da regi�o',False);
//  FRel.AddCol(40,1,'C','','','DFC','','C�digo para DFC do cidade',False);
  FRel.AddCol(60,1,'C','','','IBGE','','C�digo da cidade no IBGE',False);
  campo1:=Sistema.GetDicionario('cidades','cida_codigopais');
  if campo1.Tipo<>'' then begin
    FRel.AddCol(60,1,'C','','','Pais','','C�digo do pais tabela Bacen',False);
    FRel.AddCol(60,1,'C','','','Nome Pais','','NOme do pais tabela Bacen',False);
  end;
  campo2:=Sistema.GetDicionario('cidades','cida_fatminimo');
  if campo2.Tipo<>'' then
    FRel.AddCol(80,3,'N','','','Fat.M�nimo','','Faturamento m�nimo para venda na cidade',False);
  Q:=SqlToQuery('SELECT * FROM cidades ORDER BY cida_Nome');
  while not Q.Eof do begin
    if FRel.Canceled then Break;
    FRel.AddCel(IntToStr(Q.FieldByName('cida_CODIGO').AsInteger));
    FRel.AddCel(Q.FieldByName('cida_NOME').AsString);
    FRel.AddCel(Q.FieldByName('cida_UF').AsString);
    FRel.AddCel(Q.FieldByName('cida_REGI_CODIGO').AsString);
    FRel.AddCel(FRegioes.GetDescricao(Q.FieldByName('cida_Regi_Codigo').AsString));
    FRel.AddCel(Q.FieldByName('cida_CODIGOIBGE').AsString);
    if campo1.Tipo<>'' then begin
      FRel.AddCel(Q.FieldByName('cida_CODIGOpais').AsString);
      FRel.AddCel(Q.FieldByName('cida_nomepais').AsString);
    end;
    if campo2.Tipo<>'' then
      FRel.AddCel(Q.FieldByName('cida_fatminimo').AsString);
    Q.Next;
  end;
  Q.Close;
  Q.Free;
  Sistema.EndProcess('');
  FRel.Video;
end;

function TFCidades.GetUF(Codigo:Integer):String;
var Q:TSqlquery;
begin
  Result:='';
  Q:=sqltoquery('select * from cidades where cida_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('cida_uf').AsString
  else
    result:='';
  FGeral.FechaQuery(Q);
end;

function TFCidades.GetNome(Codigo:Integer):String;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from cidades where cida_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('cida_nome').AsString
  else
    result:='';
  FGeral.FechaQuery(Q);
end;

function TFCidades.GetCodigoDFC(Codigo:Integer):String;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from cidades where cida_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('cida_codigoDFC').AsString
  else
    result:='';
  FGeral.FechaQuery(Q);
end;

procedure TFCidades.bExcluirClick(Sender: TObject);
var Cod:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,Msg:String):Boolean;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM '+Tabela+' WHERE '+Campo+'='+Cod);
      Result:=Q.FieldByName('Registros').AsInteger>0;
      if Result then AvisoErro('Encontradas vincula��es com a cidade; selecionado na tabela: '+Msg);
      Q.Close;Q.Free;
    end;


begin
  Cod:=IntToStr(Arq.TMunicipios.FieldByName('cida_Codigo').AsInteger);
  Found:=FoundTabela('Clientes','Clie_cida_Codigo_Res','Cadastro De Clientes');
  if not Found then Found:=FoundTabela('Empresas','Empr_cida_Codigo','Cadastro De Empresas');
  if not Found then Found:=FoundTabela('Unidades','Unid_cida_Codigo','Cadastro De Unidades');
  if not Found then Found:=FoundTabela('Fornecedores','Forn_cida_Codigo','Cadastro De Fornecedores');
  if not Found then Found:=FoundTabela('Clientes','Clie_cida_Codigo_Com','Cadastro De Clientes');
  if not Found then Found:=FoundTabela('Transportadores','Tran_cida_Codigo','Cadastro De Transportadores');
  if not Found then Grid.Delete;
end;



procedure TFCidades.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  FGeral.LiberaCadastro(Grid);
end;

procedure TFCidades.EdMuni_UFValidate(Sender: TObject);
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from cidades where cida_nome='+#39+EdMuni_nome.Text+#39+
                ' and cida_uf='+#39+EdMuni_uf.Text+#39);
  if not Q.eof then
    EdMuni_UF.Invalid('J� existe esta cidade nesta UF');
end;

function TFCidades.GetCodigoIBGE(Codigo: Integer): String;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from cidades where cida_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('cida_codigoibge').AsString
  else
    result:='';
  FGeral.FechaQuery(Q);
end;

function TFCidades.GetCodigoPais(Codigo: Integer): String;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select cida_codigopais from cidades where cida_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('cida_codigopais').AsString
  else
    result:='';
  FGeral.FechaQuery(Q);
end;

function TFCidades.GetNomePais(Codigo: Integer): String;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select cida_nomepais from cidades where cida_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('cida_nomepais').AsString
  else
    result:='';
  FGeral.FechaQuery(Q);
end;

function TFCidades.ValidaFatporCidade(Codigo,Usuario,Numnota: Integer ; ValorNota:currency): boolean;
////////////////////////////////////////////////////////////////////
var Q,Qusuario:TSqlquery;
begin
  campo:=Sistema.GetDicionario('cidades','cida_fatminimo');
  if campo.tipo='' then begin
    result:=true;
    exit;
  end;
  Q:=sqltoquery('select cida_fatminimo,cida_nome from cidades where cida_codigo='+inttostr(codigo));
  if not Q.eof then begin
    if (ValorNOta < Q.fieldbyname('cida_fatminimo').ascurrency) and (Q.fieldbyname('cida_fatminimo').ascurrency>0) then begin
        QUsuario:=sqltoquery('select Usua_OutrosAcessos from usuarios where usua_codigo='+inttostr(usuario));
        if copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,326,1)<>'S' then begin
             Avisoerro('Usu�rio sem permiss�o para faturamento POR CIDADE abaixo do m�nimo.  Solicitar autoriza��o depois prosseguir!');
           QUsuario:=sqltoquery('select Usua_OutrosAcessos from usuarios where usua_codigo='+inttostr(usuario));
           if not QUsuario.eof then begin
             if copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,326,1)='S' then begin
               result:=true;
               FGeral.GravaLog(24,'Nota '+inttostr(numnota)+' fat. m�nima por cidade '+floattostr(Q.fieldbyname('cida_fatminimo').ascurrency)+' valor nota praticado '+floattostr(valornota));
             end else begin
               result:=false;
               Avisoerro('Usu�rio Ainda sem permiss�o para faturamento abaixo do faturamento m�nimo POR CIDADE');
             end;
           end else
             result:=false;

        end else begin
           FGeral.GravaLog(24,'Nota '+inttostr(numnota)+' fat. m�nima por cidade '+floattostr(Q.fieldbyname('cida_fatminimo').ascurrency)+' valor nota praticado '+floattostr(valornota));
// 'rastrear' vendas abaixo do minimo por cidade
        end;
        QUsuario.Close;
        if not result then Avisoerro('Faturamento m�nimo para '+Q.fieldbyname('cida_nome').asstring+' � '+formatfloat(f_cr,Q.fieldbyname('cida_fatminimo').ascurrency));
    end else
      result:=true;
  end else
    result:=true;
  FGeral.FechaQuery(Q);
end;

procedure TFCidades.SetaCodigosIbge(Ed: TSqled);
//////////////////////////////////////////////////////
var Lista,ListaCidade:TStringlist;
    p:integer;
begin

   if FileExists('tabela_municipios.csv') then begin
      Lista:=TStringlist.create;
      if Ed.Items.Count=0 then begin
        Lista.LoadFromFile('tabela_municipios.csv');
        for p:=0 to Lista.count-1 do begin
           ListaCidade:=TStringlist.create;
           Strtolista(ListaCidade,Lista[p],';',true);
           if ListaCidade.count=3 then
             Ed.Items.Add(ListaCidade[1]+' '+strspace(ListaCidade[2],30)+' '+strspace(ListaCidade[0],20));
        end;
      end;
   end;

end;

procedure TFCidades.EdMuni_nomeValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
    if (not EdMuni_nome.isempty) and ( trim(EdCida_codigoibge.text)='' ) then begin
      EdCida_codigoibge.text:=GetCodigoListaIbge(EdMuni_nome.text);
    end;
end;

function TFCidades.GetCodigoListaIbge(xMuni_nome:string): string;
///////////////////////////////////////////////////////////////////
var p:integer;
    Lista:TStringlist;
begin
  result:='';
  for p:=0 to EdCida_codigoibge.items.count-1 do begin
     Lista:=TStringlist.create;
     Strtolista(Lista,EdCida_codigoibge.items.Strings[p],';',true);
     if (ansipos( uppercase(xmuni_nome),uppercase(lista[0]) )>0 ) or ( ansipos( xmuni_nome,lista[0] )>0 ) then begin
         result:=copy(Lista[0],1,7);
         break;
     end;
  end;

end;

end.
