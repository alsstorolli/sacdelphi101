unit plano;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SQLGrid, ExtCtrls, Buttons, SQLBtn, StdCtrls,
  alabel, DB, Mask, SQLEd, SqlSis;

type
  TFPlano = class(TForm)
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
    EdPlan_classificacao: TSQLEd;
    EdPlan_descricao: TSQLEd;
    EdPlan_conta: TSQLEd;
    EdPlan_tipo: TSQLEd;
    bConfig: TSQLBtn;
    EdPlan_cstpiscofins: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure EdPlan_classificacaoValidate(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure bConfigClick(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure EdPlan_tipoExitEdit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure ConfiguraMascara;
  public
     FormatoMascara:String;
     function FormataClassificacao(Classificacao:String):String;
     function FormataDescricao(Classificacao,Descricao:String):String;
     function GetConta(Conta:Integer;Unidade:string=''):Boolean;
     function GetTipo(Conta:Integer):String;
     function GetDescricao(Conta:Integer):String;
     function SetaItems(Edit,EditDescricao:TSqlEd;ContasValidas:String;DescricaoValida:string='';Ordem:string='';xboleto:string=''):Boolean;
     function UsaAcessorios(Conta:Integer):Boolean;
     function GetContasSubordinadas(Contas,TiposValidos:String):String;
     function GetEntidade(Conta:Integer):String;
     function GetCtasAutPgto:String;
     procedure Execute;
     function GetContaExportacao(Conta:Integer;Unidade:string):integer;
     function GetContaJuros(Conta:Integer):integer;
     function GetContaDescontos(Conta:Integer):integer;
     function GetContaviaBanco(banco:string):integer;
     function EContachequeacompensar(Conta:Integer):boolean;
// 18.04.08
     function GetContaCompensacao(Conta:Integer):integer;
// 07.12.09
     function GetContasSubordinadasClassi(Contas,TiposValidos:String):String;
// 02.02.10
     procedure AbrecomFiltro(qfiltro:string);
// 09.04.10
     function GetClassificacao(Conta:Integer):String;
// 30.09.10
     function GetContaBanco(xbanco:string):integer;
// 13.01.17
     function GetUnidadeConta(Conta:Integer):String;
// 26.04.19
     function GetCSTPisCofins(Conta:Integer):String;
// 20.07.20
     function GetContaExportacaoAApropriar(Conta:Integer;Unidade:string):integer;

  end;

var
  FPlano: TFPlano;
  campo : TDicionario;

const Sinteticas = 'S';
      Analiticas = 'A';

implementation

{$R *.dfm}

uses Geral, Arquiv,SqlFun,SqlExpr, SQLRel,ConfPlano, Diversos;

var TamValido:Array[0..30] of Boolean;

const TiposValidos='M,C,B;E;P';
// M - contas de movimento : recebimentos e pagamentos
// C - contas caixa
// B - Contas bancarias
// E - Contas de emprestimo
// P - Cedula de produtor rural   // 02.04.19

procedure TFPlano.Execute;
/////////////////////////////
begin

   campo:=Sistema.GetDicionario('plano','plan_cstpiscofins');
   if campo.tipo='' then begin
      Edplan_cstpiscofins.TableName:='';
      Edplan_cstpiscofins.Enabled:=false;
   end else begin
      Edplan_cstpiscofins.TableName:='plano';
      Edplan_cstpiscofins.Enabled:=true;
   end;

   ShowModal;

end;

procedure TFPlano.ConfiguraMascara;
/////////////////////////////////////
var s,ss,sss:String;
    i:integer;
begin
  ss:='';sss:='';
  s:=FGeral.GetConfig1AsString('MASCARAPLANOGER');
  if s='' then begin
     Aviso('Aten��o, n�o configurada mascara para classifica��o');
     FormatoMascara:=' ';
     bIncluir.Enabled:=False;
  end;
  for i:=0 to 30 do TamValido[i]:=False;
  for i:=1 to Length(s) do begin
     if s[i]='9' then ss:=ss+'9';
     if s[i]='9' then sss:=sss+'9';
     if s[i]='.' then ss:=ss+'\.';
     if (s[i]='.') or (i=Length(s)) then TamValido[Length(sss)]:=True;
     if s[i]='9' then FormatoMascara:=FormatoMascara+'#';
     if s[i]='.' then FormatoMascara:=FormatoMascara+'.';
  end;
  ss:=ss+';0;_';
  Edplan_classificacao.EditMask:=ss;
end;


procedure TFPlano.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(Edplan_classificacao);
end;

procedure TFPlano.Edplan_tipoExitEdit(Sender: TObject);
var Conta:Integer;


    procedure SetaConfiguracaoDefault(Conta:Integer);
    begin
      Sistema.Edit('plano');
      Sistema.SetField('plan_FluxoCaixa','S');
      Sistema.SetField('plan_MovFluxo','N');
      Sistema.SetField('plan_MvtoCaixa','N');
//      Sistema.SetField('plan_AutPgto','N');
//      Sistema.SetField('plan_BxAudit','N');
      Sistema.SetField('plan_BxParcial','N');
//      Sistema.SetField('plan_CtrlComp','N');
//      Sistema.SetField('plan_contabindivbx','N');
      Sistema.Post('plan_Conta='+IntToStr(Conta));
      Sistema.Commit;
    end;

begin
  Conta:=Edplan_Conta.AsInteger;
  Grid.PostInsert(Edplan_classificacao);
  SetaConfiguracaoDefault(Conta);
end;

procedure TFPlano.EdPlan_classificacaoValidate(Sender: TObject);
var t,ta:integer;
    Cod:String;
    Q:TSqlQuery;

    function GetReduzido:integer;
    var Q1:Tsqlquery;
    begin
       Q1:=sqltoquery('select max(plan_conta) as ultimo from plano');
       result:=Q1.fieldbyname('ultimo').asinteger+1;
       FGeral.Fechaquery(Q1);
    end;

begin
  t:=Length(Trim(Edplan_Classificacao.Text));
  if not TamValido[t] then begin
     Edplan_Classificacao.Invalid('Classifica��o inv�lida');
     Exit;
  end;
  if t>1 then begin
     for ta:=t-1 downto 1 do if TamValido[ta] then Break;
     Cod:=LeftStr(Edplan_Classificacao.Text,ta);
     Q:=SqlToQuery('SELECT plan_Tipo FROM plano WHERE plan_Classificacao='+StringToSql(Cod));
//     if (Q.IsEmpty) or (trim(Q.FieldByName('plan_Tipo').AsString)<>'S') then begin
// 24.05.07
     if ( not Q.IsEmpty) and (trim(Q.FieldByName('plan_Tipo').AsString)<>'S') then begin
        Edplan_Classificacao.Invalid('N�o localizada conta t�tulo para a classifica��o informada');
     end;
  end;
  EdPlan_conta.setvalue(GetReduzido);
end;

procedure TFPlano.bExcluirClick(Sender: TObject);
var t,Cod:String;
    Q:TSqlQuery;

    function ValidaAcessorios:Boolean;
    var Cta:Integer;
        Found:Boolean;
    begin
      Result:=True;
      if Arq.TPlano.FieldByName('plan_Tipo').AsString<>'NN' then Exit;
      Cta:=Arq.TPlano.FieldByName('plan_Conta').AsInteger;
      Arq.TPlano.First;
      while not Arq.TPlano.Eof do begin
        Found:=False;
        if Arq.TPlano.FieldByName('plan_ContaJuros').AsInteger=Cta then Found:=True
        else if Arq.TPlano.FieldByName('plan_ContaMulta').AsInteger=Cta then Found:=True
        else if Arq.TPlano.FieldByName('plan_ContaDescontos').AsInteger=Cta then Found:=True
        else if Arq.TPlano.FieldByName('plan_ContaAbatimentos').AsInteger=Cta then Found:=True
        else if Arq.TPlano.FieldByName('plan_ContaTxAdm').AsInteger=Cta then Found:=True
        else if Arq.TPlano.FieldByName('plan_ContaCorrMonet').AsInteger=Cta then Found:=True
        else if Arq.TPlano.FieldByName('plan_ContaAcrescimos').AsInteger=Cta then Found:=True
        else if Arq.TPlano.FieldByName('plan_ContaMora').AsInteger=Cta then Found:=True;
        if Found then begin
           AvisoErro('Conta selecionada para exclus�o est�; configurada como acess�ria da conta: '+IntToStr(Arq.TPlano.FieldByName('plan_Conta').AsInteger));
           Result:=False;
        end;
        Arq.TPlano.Next;
      end;
    end;

    function ValidaMovGer:Boolean;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM MovGer WHERE Mger_plan_Conta='+IntToStr(Arq.TPlano.FieldByName('plan_Conta').AsInteger));
      Result:=Q.FieldByName('Registros').AsInteger=0;
      if not Result then AvisoErro('Aten��o, conta selecionada para exclus�o,;possui lan�amentos gerenciais');
      Q.Close;Freeandnil(Q);
    end;

    function ValidaMovFin:Boolean;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM Movfin WHERE Movf_plan_Conta='+IntToStr(Arq.TPlano.FieldByName('plan_Conta').AsInteger)+
                    ' and movf_status=''N'''  );
      Result:=Q.FieldByName('Registros').AsInteger=0;
      if not Result then AvisoErro('Aten��o, conta selecionada para exclus�o possui lan�amentos no caixa/bancos');
      Q.Close;Freeandnil(Q);
    end;


begin

  if Arq.TPlano.FieldByName('plan_Tipo').AsString='S' then begin
     Cod:=Trim(Arq.TPlano.FieldByName('plan_Classificacao').AsString);
     t:=IntToStr(Length(Cod));
     Q:=SqlToQuery('SELECT Count(*) AS Registros FROM plano WHERE SUBSTR(plan_Classificacao,1,'+t+')='+#39+Cod+#39);
     if Q.FieldByName('Registros').AsInteger>1 then begin
        AvisoErro('Conta n�o pode ser exclu�da, encontrada(s) conta(s) anal�tica(s) no grupo');
        Exit;
     end;
     Q.Close;
     Freeandnil(Q);
  end;
  if not ValidaAcessorios then Exit;
//  if not ValidaMovGer then Exit;   usar quando criar tabela movimento
  if not ValidaMovFin then Exit;
  Grid.Delete;
end;

function TFPlano.FormataClassificacao(Classificacao:String):String;
var p:integer;
begin
  if FormatoMascara='' then ConfiguraMascara;
  Result:=Trim(Trans(Classificacao,FormatoMascara));
  for p:=Length(Result) downto 1 do if isNumero(Result[p]) then Break;
  Result:=LeftStr(Result,p);
end;

function TFPlano.FormataDescricao(Classificacao,Descricao:String):String;
var t:Integer;
begin
  t:=(Length(Trim(Classificacao))-1)*2;
  Result:=Space(t)+Trim(Descricao);
end;


procedure TFPlano.bRelatorioClick(Sender: TObject);
////////////////////////////////////////////////////////
begin

  FRel.Init('CadPlano');
  FRel.AddTit('Rela��o Das Contas Gerenciais');
  Sistema.BeginProcess('gerando relat�rio');
  FRel.AddCol(200,1,'C','','','Codigo','','Classifica��o da conta',False);
  FRel.AddCol(300,0,'C','','','Descri��o Conta','','Descri��o da conta',False);
  FRel.AddCol(70,3,'N','','','Reduzido','','C�digo reduzido da conta',False);
  FRel.AddCol(40,1,'C','','','Tipo','','Tipo da conta',False);
  FRel.AddCol(70,2,'C','','','Unidade 01','','Unidade01 para exporta��o cont�bil',False);
  FRel.AddCol(70,1,'C','','','Reduzido01','','Reduzido01 do plano para exporta��o cont�bil',False);
  FRel.AddCol(70,2,'C','','','Unidade 02','','Unidade02 para exporta��o cont�bil',False);
  FRel.AddCol(70,3,'N','','','Reduzido02','','Reduzido02 do plano para exporta��o cont�bil',False);

  Arq.TPlano.DisableControls;
  Arq.TPlano.First;

  while not Arq.TPlano.Eof do begin

    if FRel.Canceled then Break;
    FRel.AddCel(FormataClassificacao(Arq.TPlano.FieldByName('plan_Classificacao').AsString));
    FRel.AddCel(FormataDescricao(Arq.TPlano.FieldByName('plan_Classificacao').AsString,Arq.TPlano.FieldByName('plan_Descricao').AsString));
    FRel.AddCel(IntToStr(Arq.TPlano.FieldByName('plan_Conta').AsInteger));
    FRel.AddCel(Arq.TPlano.FieldByName('plan_Tipo').AsString);
    FRel.AddCel( Arq.TPlano.FieldByName('plan_unidexporta01').AsString);
    FRel.AddCel( IntToStr(Arq.TPlano.FieldByName('plan_ctaexporta01').AsInteger));
    FRel.AddCel( Arq.TPlano.FieldByName('plan_unidexporta02').AsString);
    FRel.AddCel( IntToStr(Arq.TPlano.FieldByName('plan_ctaexporta02').AsInteger));
    Arq.TPlano.Next;

  end;

  FRel.SetSort('Classifica��o');
  Sistema.EndProcess('');
  FRel.Video;
  Arq.TPlano.EndProcess;

end;

procedure TFPlano.GridNewRecord(Sender: TObject);
//const TiposValidos='CR,CP,CX,CB,CS,NN';
//const TiposValidos='S,A';

begin
  if Pos(Arq.TPlano.FieldByName('plan_TIPO').AsString,TiposValidos)=0 then begin
     bConfig.White;
  end else begin
     bConfig.Black;
  end;
end;

procedure TFPlano.bConfigClick(Sender: TObject);
begin
  Confplano_Execute;
//  aviso('Op��o em desenvolvimento');
end;


function TFPlano.GetConta(Conta:Integer;Unidade:string=''):Boolean;
begin
  Result:=Arq.TPlano.FieldByName('plan_Conta').AsInteger=Conta;
  if not Result then Result:=Arq.TPlano.Locate('plan_Conta',Conta,[]);
end;

function TFPlano.GetDescricao(Conta:Integer):String;
////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Result:='';
  if Conta>0 then begin
    Q:=sqltoquery('select plan_descricao from plano where plan_conta='+inttostr(conta));
    if not Q.eof then
      result:=Q.fieldbyname('plan_descricao').asstring;
    FGeral.FechaQuery(Q);
//     if GetConta(Conta) then Result:=Arq.TPlano.FieldByName('plan_Descricao').AsString;
  end;
end;

function TFPlano.GetTipo(Conta:Integer):String;
begin
  Result:='';
  if Conta>0 then begin
     if GetConta(Conta) then Result:=Arq.TPlano.FieldByName('plan_Tipo').AsString;
  end;
end;

function TFPlano.GetEntidade(Conta:Integer):String;
begin
  Result:='N';
  if GetConta(Conta) then Result:=Arq.TPlano.FieldByName('plan_CatEntidade').AsString;
end;

function TFPlano.SetaItems(Edit,EditDescricao:TSqlEd;ContasValidas:String;DescricaoValida:string='';Ordem:string='';xboleto:string=''):Boolean;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var Lista,ListaOrdem:TStringList;
    c,p:integer;
    TPlano:TSqlquery;
begin
  Edit.Items.Clear;
//  if (Length(ContasValidas)=1) and (Pos(ContasValidas,'M,C,B')>0) then begin
// 26.06.07
  if (Length(ContasValidas)<=4)  then begin
     if trim(ordem)='' then begin
       TPlano:=sqltoquery('select * from plano order by plan_descricao');
// 08.03.15
       if xboleto='S' then begin
          TPlano.close;
//          TPlano:=sqltoquery('select * from plano where plan_codigobanco <> '''+space(03)+'''  order by plan_descricao');
// 11.05.20
          TPlano:=sqltoquery('select * from plano where plan_codigobanco is not null order by plan_descricao');
       end;
     end else
       TPlano:=sqltoquery('select * from plano order by '+ordem);

     while not TPlano.Eof do begin

       if Pos(TPlano.FieldByName('plan_Tipo').AsString,ContasValidas)>0 then begin
          if ( (descricaovalida<>'') and (ansipos(uppercase(descricaovalida),uppercase(TPlano.FieldByName('plan_Descricao').AsString))>0) ) or
               (descricaovalida='') then
            Edit.Items.Add(StrSpace(IntToStr(TPlano.FieldByName('plan_Conta').AsInteger),8)+' - '+TPlano.FieldByName('plan_Descricao').AsString);
//            Edit.Items.Add( Strzero(Arq.TPlano.FieldByName('plan_Conta').AsInteger,8)+' - '+copy(Arq.TPlano.FieldByName('plan_Descricao').AsString,1,05) );
       end;
       TPlano.Next;
     end;
     FGeral.FechaQuery(TPlano);
//     Arq.TPlano.EndProcess;
  end else begin
     Lista:=TStringList.Create;
     ListaOrdem:=TStringList.Create;
     StrToLista(Lista,ContasValidas,',;',False);
     for c:=0 to Lista.Count-1 do begin
{
         if GetConta(Inteiro(Lista[c])) then begin
            if ( (descricaovalida<>'') and (ansipos(uppercase(descricaovalida),uppercase(Arq.TPlano.FieldByName('plan_Descricao').AsString))>0) ) or
               (descricaovalida='') then
            Edit.Items.Add(StrSpace(IntToStr(Arq.TPlano.FieldByName('plan_Conta').AsInteger),8)+' - '+Arq.TPlano.FieldByName('plan_Descricao').AsString);
         end;
}   // 11.07.08
         TPlano:=sqltoquery('select * from plano where Plan_conta='+Lista[c]);
         if not TPlano.eof then begin
            if ( (descricaovalida<>'') and (ansipos(uppercase(descricaovalida),uppercase(TPlano.FieldByName('plan_Descricao').AsString))>0) ) or
               (descricaovalida='') then
            Edit.Items.Add(StrSpace(IntToStr(TPlano.FieldByName('plan_Conta').AsInteger),8)+' - '+TPlano.FieldByName('plan_Descricao').AsString);
            ListaOrdem.Add(TPlano.FieldByName('plan_Descricao').AsString+';'+StrSpace(IntToStr(TPlano.FieldByName('plan_Conta').AsInteger),8));
         end;
         FGeral.FechaQuery(TPlano);
     end;
     Lista.Free;
     if Edit.Items.Count=1 then begin
//        Edit.Text:=Trim(LeftStr(Edit.Items[0],8));
// 24.05.07
        Edit.setvalue( Strtointdef(LeftStr(Edit.Items[0],8),0) );
        if EditDescricao<>nil then EditDescricao.Text:=FinalStr(Edit.Items[0],12);
     end;
     if ListaOrdem.Count>1 then begin
       Edit.Items.Clear;
       ListaOrdem.Sort;
       Lista:=TStringList.Create;
       for c:=0 to ListaOrdem.Count-1 do begin
         strtolista(Lista,ListaOrdem[c],';',true);
         if ( trim(lista[1])<>'' ) and ( trim(lista[0])<>'' ) then
           Edit.Items.Add(lista[1]+' - '+lista[0]);
         Lista.Clear;
       end;
     end;
  end;
  Result:=Edit.Items.Count>0;
end;


function TFPlano.UsaAcessorios(Conta:Integer):Boolean;
begin
  GetConta(Conta);
  Result:=Arq.TPlano.FieldByName('plan_ContaJuros').AsInteger>0;
  if not Result then Result:=Arq.TPlano.FieldByName('plan_ContaMulta').AsInteger>0;
  if not Result then Result:=Arq.TPlano.FieldByName('plan_ContaDescontos').AsInteger>0;
  if not Result then Result:=Arq.TPlano.FieldByName('plan_ContaAbatimentos').AsInteger>0;
  if not Result then Result:=Arq.TPlano.FieldByName('plan_ContaTxAdm').AsInteger>0;
  if not Result then Result:=Arq.TPlano.FieldByName('plan_ContaCorrMonet').AsInteger>0;
  if not Result then Result:=Arq.TPlano.FieldByName('plan_ContaAcrescimos').AsInteger>0;
  if not Result then Result:=Arq.TPlano.FieldByName('plan_ContaMora').AsInteger>0;
end;


function TFPlano.GetContasSubordinadas(Contas,TiposValidos:String):String;
/////////////////////////////////////////////////////////////////////////
var Lista:TStringList;
    c,t:Integer;
    Tipo,Cl:String;
begin
  Result:='';
  Lista:=TStringList.Create;
  StrToLista(Lista,Contas,',;',False);
  for c:=0 to Lista.Count-1 do begin
      GetConta(Inteiro(Lista[c]));
      Tipo:=Arq.TPlano.FieldByName('plan_Tipo').AsString;
      if trim(Tipo)<>'S' then begin
         if (TiposValidos='') or (Pos(Tipo,TiposValidos)>0) then AnexarStr(Result,Lista[c]+';');
      end else begin
         Cl:=Trim(Arq.TPlano.FieldByName('plan_Classificacao').AsString);
         t:=Length(Cl);
         Arq.TPlano.BeginProcess;
         Arq.TPlano.First;
         while not Arq.TPlano.Eof do begin
           if LeftStr(Arq.TPlano.FieldByName('plan_Classificacao').AsString,t)=Cl then begin
              Tipo:=Arq.TPlano.FieldByName('plan_Tipo').AsString;
                      if (TiposValidos='') or (Pos(Tipo,TiposValidos)>0) then AnexarStr(Result,IntToStr(Arq.TPlano.FieldByName('plan_Conta').AsInteger)+';');
           end;
           Arq.TPlano.Next;
         end;
         Arq.TPlano.EndProcess;
      end;
  end;
  Lista.Clear;
  StrToLista(Lista,Result,';',False);
  for c:=0 to Lista.Count-1 do Lista[c]:=StrZero(Inteiro(Lista[c]),8);
  Lista.Sort;
  Result:='';
  for c:=0 to Lista.Count-1 do AnexarStr(Result,IntToStr(Inteiro(Lista[c]))+';');
  Lista.Free;
end;


// 07.12.09
function TFPlano.GetContasSubordinadasClassi(Contas,TiposValidos:String):String;
/////////////////////////////////////////////////////////////////////////
var Lista:TStringList;
    c,t:Integer;
    Tipo,Cl:String;
    Q:TSqlquery;
begin
  Result:='';
  Lista:=TStringList.Create;
  StrToLista(Lista,Contas,',;',False);
  for c:=0 to Lista.Count-1 do begin
//      GetConta(Inteiro(Lista[c]));
    if trim(Lista[c])<>'' then begin
      Q:=sqltoquery('select plan_tipo,plan_classificacao,plan_conta from plano where substr(plan_classificacao,1,1)='+stringtosql(Lista[c])+
                    ' order by plan_classificacao' );
      Tipo:=Q.FieldByName('plan_Tipo').AsString;
      if trim(Tipo)<>'S' then begin
         if (TiposValidos='') or (Pos(Tipo,TiposValidos)>0) then AnexarStr(Result,Lista[c]+';');
      end else begin
         Cl:=Trim(Q.FieldByName('plan_Classificacao').AsString);
         t:=Length(Cl);
         while not Q.Eof do begin
           if LeftStr(Q.FieldByName('plan_Classificacao').AsString,t)=Cl then begin
              Tipo:=Q.FieldByName('plan_Tipo').AsString;
                      if (TiposValidos='') or (Pos(Tipo,TiposValidos)>0) then AnexarStr(Result,IntToStr(Q.FieldByName('plan_Conta').AsInteger)+';');
           end;
           Q.Next;
         end;
      end;
    end;
  end;
  Lista.Clear;
  StrToLista(Lista,Result,';',False);
  for c:=0 to Lista.Count-1 do Lista[c]:=StrZero(Inteiro(Lista[c]),8);
  Lista.Sort;
  Result:='';
  for c:=0 to Lista.Count-1 do AnexarStr(Result,IntToStr(Inteiro(Lista[c]))+';');
  Lista.Free;
end;
///////////////

function TFPlano.GetCtasAutPgto:String;
begin
  Arq.TPlano.BeginProcess;
  Arq.TPlano.First;
  while not Arq.TPlano.Eof do begin
    if Pos(Arq.TPlano.FieldByName('plan_Tipo').AsString,'CP,CR')>0 then begin
       if Arq.TPlano.FieldByName('plan_AutPgto').AsString='S' then begin
          AnexarStr(Result,IntToStr(Arq.TPlano.FieldByName('plan_Conta').AsInteger)+';');
       end;
    end;
    Arq.TPlano.Next;
  end;
  Arq.TPlano.EndProcess;
end;



function TFPlano.GetContaExportacao(Conta: Integer;  Unidade: string): integer;
/////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from plano where plan_conta='+inttostr(conta));
  if not Q.eof then begin
{
    if unidade='001' then   // Global.unidadecuritiba then
      result:=Q.FieldByName('plan_ctaexporta01').AsInteger
    else if unidade='002' then   // lobal.unidadebeltrao then
      result:=Q.FieldByName('plan_ctaexporta02').AsInteger
    else if unidade='003' then   // Global.unidadeijui) or  (unidade=Global.unidadeijui333) then
      result:=Q.FieldByName('plan_ctaexporta03').AsInteger
    else if unidade='004' then
      result:=Q.FieldByName('plan_ctaexporta04').AsInteger
    else if unidade='005' then
      result:=Q.FieldByName('plan_ctaexporta05').AsInteger
    else if unidade='006' then
      result:=Q.FieldByName('plan_ctaexporta06').AsInteger
    else if unidade='007'  then
      result:=Q.FieldByName('plan_ctaexporta07').AsInteger
}
 // 13.05.10 - Abra - Ligiane
    if Global.Topicos[1010] then
      result:=Q.FieldByName('plan_ctaexporta01').AsInteger
 // 03.09.08
    else if unidade=Q.FieldByName('plan_unidexporta01').asstring then
      result:=Q.FieldByName('plan_ctaexporta01').AsInteger
    else if unidade=Q.FieldByName('plan_unidexporta02').asstring then
      result:=Q.FieldByName('plan_ctaexporta02').AsInteger
    else if unidade=Q.FieldByName('plan_unidexporta03').asstring then
      result:=Q.FieldByName('plan_ctaexporta03').AsInteger
    else if unidade=Q.FieldByName('plan_unidexporta04').asstring then
      result:=Q.FieldByName('plan_ctaexporta04').AsInteger
    else if unidade=Q.FieldByName('plan_unidexporta05').asstring then
      result:=Q.FieldByName('plan_ctaexporta05').AsInteger
    else if unidade=Q.FieldByName('plan_unidexporta06').asstring then
      result:=Q.FieldByName('plan_ctaexporta06').AsInteger
    else
      result:=0;
  end else
      result:=0;
  Q.close;
  freeandnil(q);
end;

// 20.07.20
function TFPlano.GetContaExportacaoAApropriar(Conta: Integer;  Unidade: string): integer;
////////////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

  Q:=sqltoquery('select * from plano where plan_conta='+inttostr(conta));
  if not Q.eof then begin

    if unidade=Q.FieldByName('plan_unidexporta01').asstring then

      result:=Q.FieldByName('plan_ctaapropriar01').AsInteger

    else if unidade=Q.FieldByName('plan_unidexporta02').asstring then

      result:=Q.FieldByName('plan_ctaapropriar02').AsInteger
 {
    else if unidade=Q.FieldByName('plan_unidexporta03').asstring then
      result:=Q.FieldByName('plan_ctaexporta03').AsInteger
    else if unidade=Q.FieldByName('plan_unidexporta04').asstring then
      result:=Q.FieldByName('plan_ctaexporta04').AsInteger
    else if unidade=Q.FieldByName('plan_unidexporta05').asstring then
      result:=Q.FieldByName('plan_ctaexporta05').AsInteger
    else if unidade=Q.FieldByName('plan_unidexporta06').asstring then
      result:=Q.FieldByName('plan_ctaexporta06').AsInteger
}
    else
      result:=0;

  end else
      result:=0;

  Q.close;
  freeandnil(q);
end;

function TFPlano.GetContaJuros(Conta: Integer): integer;
//////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
{
  if not Arq.TPlano.Active then Arq.TPlano.Open;
  if Arq.TPlano.locate('plan_conta',conta,[]) then
      result:=Arq.TPlano.FieldByName('Plan_contajuros').AsInteger
  else
      result:=0;
}
// 08.08.16
  Q:=sqltoquery('select plan_contajuros from plano where plan_conta = '+inttostr(conta));
  if not Q.eof then result:=Q.fieldbyname('plan_contajuros').asinteger else result:=0;
  FGeral.FechaQuery(Q);
end;

function TFPlano.GetContaDescontos(Conta: Integer): integer;
////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
{
  if not Arq.TPlano.Active then Arq.TPlano.Open;
  if Arq.TPlano.locate('plan_conta',conta,[]) then
      result:=Arq.TPlano.FieldByName('Plan_contadescontos').AsInteger
  else
      result:=0;
      }
// 08.08.16
  Q:=sqltoquery('select Plan_contadescontos from plano where plan_conta = '+inttostr(conta));
  if not Q.eof then result:=Q.fieldbyname('Plan_contadescontos').asinteger else result:=0;
  FGeral.FechaQuery(Q);

end;

function TFPlano.GetContaviaBanco(banco: string): integer;
var Q:TSqlquery;
begin
    Q:=sqltoquery('select plan_conta from plano where  plan_codigobanco='+stringtosql(banco));
    if not Q.eof then
      result:=Q.fieldbyname('plan_conta').asinteger
    else
      result:=0;
    FGeral.Fechaquery(Q);
end;



// 26.04.19
function TFPlano.GetCSTPisCofins(Conta: Integer): String;
///////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
    Q:=sqltoquery('select plan_cstpiscofins from plano where plan_conta = '+inttostr(conta) );
    result:='';
    if not Q.eof then begin
      result:=Q.fieldbyname('plan_cstpiscofins').asstring;
    end;
    FGeral.Fechaquery(Q);
end;

function TFPlano.EContachequeacompensar(Conta: Integer): boolean;
var Q:TSqlquery;
begin
    Q:=sqltoquery('select plan_conta,plan_ctachequescomp from plano where plan_ctachequescomp>0');
    result:=false;
    while not Q.eof do begin
      if Q.fieldbyname('plan_ctachequescomp').asinteger=conta then begin
        result:=true;
        break;
      end;
      Q.Next;
    end;
    FGeral.Fechaquery(Q);
end;

function TFPlano.GetContaCompensacao(Conta: Integer): integer;
var Q:TSqlquery;
begin
    Q:=sqltoquery('select plan_conta,plan_ctachequescomp from plano where plan_conta='+inttostr(conta));
    result:=0;
    if not Q.eof then
        result:=Q.fieldbyname('plan_ctachequescomp').asinteger;
    FGeral.Fechaquery(Q);

end;

// 02.02.10
procedure TFPlano.AbrecomFiltro(qfiltro: string);
begin
   if Arq.TPlano.Active then Arq.TPlano.Close;
//   Arq.TPlano.OpenWith(qfiltro,'plan_descricao');
   Arq.TPlano.OpenWith(qfiltro,Arq.TPlano.Ordenacao );
end;

procedure TFPlano.FormActivate(Sender: TObject);
begin
// 02.02.10 -
// Abra - Paulo
//  if trim(FGeral.getconfig1asstring('Contasnfentrada'))<>'' then begin
  if Global.PlanoFiltrado='S' then begin
    if not Arq.TPlano.Active then Arq.TPlano.Open;
  end else if trim(FGeral.getconfig1asstring('Contasnfentrada'))<>'' then begin
    if Arq.TPlano.Active then Arq.TPlano.Close;
    Arq.TPlano.OpenWith('',Arq.TPlano.Ordenacao);
    Arq.TPlano.First;
  end else
    if not Arq.TPlano.Active then Arq.TPlano.Open;
  if Tag=0 then ConfiguraMascara;
  Tag:=1;
  FGeral.ColunasGrid(Grid,self);

end;

function TFPlano.GetClassificacao(Conta: Integer): String;
var Q:TSqlquery;
begin
  Result:='';
  if Conta>0 then begin
    Q:=sqltoquery('select plan_classificacao from plano where plan_conta='+inttostr(conta));
    if not Q.eof then
      result:=Q.fieldbyname('plan_classificacao').asstring;
    FGeral.FechaQuery(Q);
  end;
end;

function TFPlano.GetContaBanco(xbanco: string): integer;
var Q:TSqlquery;
begin
   Q:=Sqltoquery('select Plan_conta from plano where Plan_codigobanco='+Stringtosql(xbanco) );
   if not Q.eof then
     result:=Q.fieldbyname('plan_conta').asinteger
   else
     result:=0;
   fGeral.FechaQuery(Q);
end;

// 13.01.17
function TFPlano.GetUnidadeConta(Conta: Integer): String;
//////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
   Q:=Sqltoquery('select Plan_unid_codigo from plano where Plan_conta='+Inttostr(conta) );
   if not Q.eof then
     result:=Q.fieldbyname('plan_unid_codigo').asstring
   else
     result:='';
   fGeral.FechaQuery(Q);

end;

end.






