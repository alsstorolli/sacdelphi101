unit grupos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, ExtCtrls,
  Buttons, SQLBtn, alabel, Sqlfun , Sqlsis;

type
  TFGrupos = class(TForm)
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
    EdGrup_codigo: TSQLEd;
    EdGrup_descricao: TSQLEd;
    batuprecos: TSQLBtn;
    EdGrup_valorarroba: TSQLEd;
    EdGrup_comissao: TSQLEd;
    EdGrup_markup: TSQLEd;
    EdFaixacustoi: TSQLEd;
    Edgrup_faixacustof: TSQLEd;
    EdGrup_margem: TSQLEd;
    EdGrup_Faix_codigo: TSQLEd;
    breajuste: TSQLBtn;
    EdGRUPOSPRECO: TSQLEd;
    EdGrup_SomenteCodBarra: TSQLEd;
    EdGrup_sitt_codestadocf: TSQLEd;
    EdGrup_sitt_forestadocf: TSQLEd;
    EdGrup_ToleBalVen: TSQLEd;
    EdGrup_CodAdapar: TSQLEd;
    procedure bIncluirClick(Sender: TObject);
    procedure EdGrup_descricaoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure batuprecosClick(Sender: TObject);
    procedure breajusteClick(Sender: TObject);
    procedure EdGRUPOSPRECOExitEdit(Sender: TObject);
    procedure EdGRUPOSPRECOValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetDescricao(codigo:integer):string;
    procedure SetaItems(Edit,EditNomeGrupo:TSqlEd;GruposValidos,Nomevalido:String);
    function GetValorArroba(codigo:integer ; xpeso:currency=0 ; xproduto:string='' ;xtipomov:string='' ):currency;
// 24.12.08
    function GetPercentualComissao(codigo:integer ; produto,unidade:string):currency;
// 24.09.12 - Novicarnes - Isonel
    function GetValorArrobaporFaixa(codigo:string ; ypeso:currency):currency;
// 09.09.13
    function GetPercentualMargem(codigo:integer):currency;
    function GetPercentualMarkup(codigo:integer):currency;
// 23.09.17
    function GetUsoCodBarra(codigo:integer):string;
// 09.01.20
    function GetCodigoAdapar(codigo:integer):string;
    function GetTolerancia(codigo:integer):currency;

  end;

var
  FGrupos: TFGrupos;
  Campo:TDicionario;

implementation

uses Arquiv, SQLRel, SqlExpr, Geral , faixas;

{$R *.dfm}

procedure TFGrupos.bIncluirClick(Sender: TObject);
begin
   Grid.Insert(EdGrup_descricao);
   EdGrup_codigo.setvalue( FGeral.GetProximoCodigoCadastro('grupos','grup_codigo') );
end;

procedure TFGrupos.EdGrup_descricaoExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdGrup_descricao);
  EdGrup_codigo.setvalue( FGeral.GetProximoCodigoCadastro('grupos','grup_codigo') );
end;

procedure TFGrupos.bRelatorioClick(Sender: TObject);
begin
//   Grid.Report('CadGrupos','Relação de Grupos do Estoque','','');
   Frel.Reportfromsql('select * from grupos','CadGrupos','Relação de Grupos do Estoque');
end;

procedure TFGrupos.FormActivate(Sender: TObject);
begin
   if not Arq.TGrupos.Active then Arq.TGrupos.Open;
   Fgeral.ColunasGrid(Grid,Self);

end;

procedure TFGrupos.Execute;
///////////////////////////////
begin

   campo:=Sistema.GetDicionario('grupos','grup_faix_codigo');
   if trim(campo.tipo)='' then begin
     EdGrup_faix_codigo.enabled:=false;
     EdGrup_faix_codigo.tablename:='';
     EdGrup_faix_codigo.group:=7;
   end else begin
     EdGrup_faix_codigo.enabled:=true;
     EdGrup_faix_codigo.tablename:='grupos';
     EdGrup_faix_codigo.group:=0;
   end;
   campo:=Sistema.GetDicionario('grupos','Grup_SomenteCodBarra');
   if trim(campo.tipo)='' then begin
     EdGrup_SomenteCodBarra.enabled:=false;
     EdGrup_SomenteCodBarra.tablename:='';
     EdGrup_SomenteCodBarra.Group:=7;
   end else begin
     EdGrup_SomenteCodBarra.enabled:=true;
     EdGrup_SomenteCodBarra.tablename:='grupos';
     EdGrup_SomenteCodBarra.group:=0;
   end;
// 03.07.19
   campo:=Sistema.GetDicionario('grupos','Grup_sitt_codestadocf');
   if trim(campo.tipo)='' then begin
     EdGrup_sitt_codestadocf.enabled:=false;
     EdGrup_sitt_codestadocf.tablename:='';
     EdGrup_sitt_codestadocf.Group:=7;
     EdGrup_sitt_forestadocf.enabled:=false;
     EdGrup_sitt_forestadocf.tablename:='';
     EdGrup_sitt_forestadocf.Group:=7;
   end else begin
     EdGrup_sitt_codestadocf.enabled:=true;
     EdGrup_sitt_codestadocf.tablename:='grupos';
     EdGrup_sitt_codestadocf.group:=0;
     EdGrup_sitt_forestadocf.enabled:=true;
     EdGrup_sitt_forestadocf.tablename:='grupos';
     EdGrup_sitt_forestadocf.group:=0;
   end;
// 09.01.20
   campo:=Sistema.GetDicionario('grupos','Grup_ToleBalVen');
   if trim(campo.tipo)='' then begin

     EdGrup_ToleBalVen.enabled:=false;
     EdGrup_ToleBalVen.tablename:='';
     EdGrup_ToleBalVen.Group:=7;
     EdGrup_CodAdapar.enabled:=false;
     EdGrup_CodAdapar.tablename:='';
     EdGrup_CodAdapar.Group:=7;

   end else begin

     EdGrup_ToleBalVen.enabled:=true;
     EdGrup_ToleBalVen.tablename:='grupos';
     EdGrup_ToleBalVen.group:=0;
     EdGrup_CodAdapar.enabled:=true;
     EdGrup_CodAdapar.tablename:='grupos';
     EdGrup_CodAdapar.group:=0;

   end;

// 'Grup_sitt_forestadocf'

   SetaItems(EdGrupospreco,nil,'','');
   FGrupos.Show;
end;

function TFGrupos.GetCodigoAdapar(codigo: integer): string;
///////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Result:='';
  if Codigo>0 then begin

    Q:=sqltoquery('select grup_codadapar from grupos where grup_codigo='+inttostr(codigo));
    if not Q.Eof then Result:=q.FieldByName('Grup_codadapar').AsString;
    Fgeral.FechaQuery(Q);

  end;

end;

function TFGrupos.GetDescricao(codigo: integer): string;
///////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Result:='';
  if Codigo>0 then begin
    Q:=sqltoquery('select grup_descricao from grupos where grup_codigo='+inttostr(codigo));
    if not Q.Eof then Result:=q.FieldByName('Grup_Descricao').AsString;
    Fgeral.FechaQuery(Q);
  end;

end;

procedure TFGrupos.SetaItems(Edit, EditNomeGrupo: TSqlEd; GruposValidos,  Nomevalido: String);
begin
  Edit.Items.Clear;
  if not Arq.TGrupos.Active then Arq.TGrupos.Open;
  Arq.TGrupos.BeginProcess;
  Arq.TGrupos.First;
  while not Arq.TGrupos.Eof do begin
    if ((GruposValidos='') or (Pos(strzero(Arq.TGrupos.FieldByName('Grup_Codigo').AsInteger,4),GruposValidos)>0))
       and ((NomeValido='') or (Pos(NomeValido,Uppercase(Arq.TGrupos.FieldByName('Grup_Descricao').AsString))>0))
      then begin
//       Edit.Items.Add(Strzero(Arq.TGrupos.FieldByName('Grup_Codigo').AsInteger,3)+' - '+Trim(Arq.TGrupos.FieldByName('Grup_Descricao').AsString));
       Edit.Items.Add(Strzero(Arq.TGrupos.FieldByName('Grup_Codigo').AsInteger,6)+' - '+Trim(Arq.TGrupos.FieldByName('Grup_Descricao').AsString));
    end;
    Arq.TGrupos.Next;
  end;
  Arq.TGrupos.EndProcess;
  if Edit.Items.Count=1 then begin
//     Edit.Text:=LeftStr(Edit.Items[0],3);
//     Edit.Text:=Edit.Items[0];  //retirado em 06.02.09
//     if EditNomeGrupo<>nil then EditNomeGrupo.Text:=FinalStr(Edit.Items[0],7);
     if EditNomeGrupo<>nil then EditNomeGrupo.Text:=FinalStr(Edit.Items[0],9);
  end;

end;


procedure TFGrupos.bExcluirClick(Sender: TObject);
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
  Cod:=IntToStr(Arq.TGrupos.FieldByName('grup_Codigo').AsInteger);
  Found:=FoundTabela('Estoque','Esto_grup_Codigo','Cadastro do estoque','Esto_codigo');
  if not Found then Grid.Delete;
end;

procedure TFGrupos.batuprecosClick(Sender: TObject);
var valorbase,novoven,novomin:currency;
    Q,QOrigem:Tsqlquery;
    pr,pr1:integer;
begin
  if not Arq.Tgrupos.active then exit;
  if not confirma('Confirma atualização grupo '+Arq.Tgrupos.fieldbyname('grup_descricao').asstring+' pelo valor '+floattostr(Arq.Tgrupos.fieldbyname('grup_valorarroba').ascurrency)+' ?') then exit;
  valorbase:=Arq.Tgrupos.fieldbyname('grup_valorarroba').ascurrency/15;
  if valorbase<=0 then exit;
  Sistema.beginprocess('Atualizando produtos do subgrupo');
  Q:=sqltoquery('select * from estoqueqtde inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                ' where esqt_unid_codigo='+stringtosql(global.codigounidade)+' and esqt_status=''N'''+
                ' and esto_codigovenda='+stringtosql('')+
                ' and esto_grup_codigo='+inttostr(Arq.Tgrupos.fieldbyname('grup_codigo').asinteger) );
  pr:=0;
  while not Q.eof do begin
    if Q.fieldbyname('esto_pervenda').ascurrency>0 then
      novoven:=valorbase + ( valorbase*(Q.fieldbyname('esto_pervenda').ascurrency/100) )
    else
      novoven:=Q.fieldbyname('esqt_vendavis').ascurrency;
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
    Sistema.endprocess('Atualização feita em '+inttostr(pr)+' produtos ');
  except
    Sistema.endprocess('Problemas no banco.   Atualização não feita');
  end;
  Q:=sqltoquery('select * from estoqueqtde inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                ' where esqt_unid_codigo='+stringtosql(global.codigounidade)+' and esqt_status=''N'''+
                ' and esto_codigovenda<>'+stringtosql('') );
//                ' and esto_grup_codigo='+inttostr(Arq.Tgrupos.fieldbyname('grup_codigo').asinteger) );
// 28.08.07 - retirado limitação do grupo - Isonel

  pr1:=0;
  while not Q.eof do begin
    QOrigem:=sqltoquery('select * from estoqueqtde inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                ' where esqt_unid_codigo='+stringtosql(global.codigounidade)+' and esqt_status=''N'''+
                ' and esqt_esto_codigo='+stringtosql(Q.fieldbyname('esto_codigovenda').AsString) );
//                ' and esto_grup_codigo='+inttostr(Arq.Tgrupos.fieldbyname('grup_codigo').asinteger) );
// 26.06.07 - isonel
    if not QOrigem.Eof then begin
      valorbase:=QOrigem.fieldbyname('esqt_vendavis').ascurrency;
      if Q.fieldbyname('esto_pervenda').ascurrency>0 then
        novoven:=valorbase*(Q.fieldbyname('esto_pervenda').ascurrency/100)
      else
        novoven:=Q.fieldbyname('esqt_vendavis').ascurrency;
      novomin:=novoven - ( novoven * (Q.fieldbyname('esto_desconto').ascurrency/100) );
      Sistema.Edit('estoqueqtde');
      Sistema.Setfield('esqt_vendavis',novoven);
      if Q.fieldbyname('esto_desconto').ascurrency>0 then
        Sistema.Setfield('esqt_vendamin',novomin);
      Sistema.post('esqt_unid_codigo='+stringtosql(global.codigounidade)+' and esqt_esto_codigo='+stringtosql(Q.fieldbyname('esqt_esto_codigo').asstring)+
                   ' and esqt_status=''N''');
    end;
    FGeral.FechaQuery(QOrigem);
    inc(pr1);
    Q.Next;
  end;
  FGeral.FechaQuery(Q);
  try
    sistema.commit;
    Sistema.endprocess('Atualização feita em '+inttostr(pr1)+' subprodutos');
  except
    Sistema.endprocess('Problemas no banco.   Atualização não feita');
  end;
end;

function TFGrupos.GetValorArroba(codigo: integer ; xpeso:currency=0 ; xproduto:string='';xtipomov:string='' ): currency;
/////////////////////////////////////////////////////////////////////////////////////////////////////
var TGrupos,TEst:TSqlquery;
begin
  Result:=0;
  if Codigo>0 then begin
//    campo:=Sistema.GetDicionario('grupos','grup_faix_codigo');
//    if not Arq.TGrupos.Active then Arq.TGrupos.Open;
//    if Arq.TGrupos.Locate('Grup_Codigo',Codigo,[]) then Result:=Arq.TGrupos.FieldByName('grup_valorarroba').AsCurrency;
// 05.12.12 - retirado 'clientdatachu'
    Tgrupos:=sqltoquery('select * from grupos where grup_codigo='+Inttostr(codigo));
    if not TGrupos.eof then Result:=TGrupos.FieldByName('grup_valorarroba').AsCurrency;
// 24.09.12 - faixas de valores da arroba - Isonel
//    if (trim(campo.Tipo)<>'') and (xpeso>0) then begin
 // 23.07.13 - as vezes parece nao fungar direito
      if (trim(TGrupos.FieldByName('grup_faix_codigo').AsString)<>'') and (xpeso>0) then begin
        result:=GetValorArrobaporFaixa(TGrupos.FieldByName('grup_faix_codigo').AsString,xpeso);
      end;
//    end;
// 16.03.16
    if trim(xproduto)<>'' then begin

      if xtipomov='FA' then
        TEst:=sqltoquery('select esto_faix_codigo002 from estoque where esto_codigo='+Stringtosql(xproduto))
      else
        TEst:=sqltoquery('select esto_faix_codigo from estoque where esto_codigo='+Stringtosql(xproduto));

    // 23.05.18
      if not TEst.eof then begin
        if xtipomov='FA' then begin

          if trim(TEst.FieldByName('esto_faix_codigo002').AsString)<>'' then
            result:=GetValorArrobaporFaixa(TEst.FieldByName('esto_faix_codigo002').AsString,xpeso);

        end else begin

          if trim(TEst.FieldByName('esto_faix_codigo').AsString)<>'' then
            result:=GetValorArrobaporFaixa(TEst.FieldByName('esto_faix_codigo').AsString,xpeso);

        end;
      end;
      fGeral.FechaQuery(TEst);
    end;

    fGeral.FechaQuery(TGrupos);
  end;

end;

function TFGrupos.GetPercentualComissao(codigo: integer ; produto,unidade:string): currency;
////////////////////////////////////////////////////////////////////////////////////////////////
var Q,Q1:TSqlquery;
begin
  Q:=sqltoquery('select * from grupos where grup_codigo='+inttostr(codigo));
  result:=0;
  if not Q.eof then begin
    result:=Q.fieldbyname('grup_comissao').ascurrency;
    Q1:=sqltoquery('select esqt_basecomissao from estoqueqtde where esqt_esto_codigo='+stringtosql(produto)+
                   ' and esqt_unid_codigo='+stringtosql(unidade)+
                   ' and esqt_status=''N''');
    if not Q1.eof then begin
      if Q1.fieldbyname('esqt_basecomissao').ascurrency>0 then
        result:=Q1.fieldbyname('esqt_basecomissao').ascurrency;
    end;
    FGeral.Fechaquery(Q1);
  end;
  FGeral.FechaQuery(Q);
end;

function TFGrupos.GetValorArrobaporFaixa(codigo: string;  ypeso: currency): currency;
////////////////////////////////////////////////////////////////////////////////////////
begin
  result:=FFaixas.GetValor(codigo,ypeso);
end;

// 09.09.13
function TFGrupos.GetPercentualMargem(codigo: integer): currency;
/////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  result:=0;
  Q:=sqltoquery('select * from grupos where grup_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('grup_margem').ascurrency;
  FGeral.FechaQuery(Q);
end;

function TFGrupos.GetPercentualMarkup(codigo: integer): currency;
/////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  result:=0;
  Q:=sqltoquery('select * from grupos where grup_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('grup_markup').ascurrency;
  FGeral.FechaQuery(Q);
end;

// 10.01.20
function TFGrupos.GetTolerancia(codigo: integer): currency;
/////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

  result:=0;
  Q:=sqltoquery('select grup_tolebalven from grupos where grup_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('Grup_tolebalven').ascurrency;
  FGeral.FechaQuery(Q);

end;

// 23.09.17
function TFGrupos.GetUsoCodBarra(codigo: integer): string;
////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  result:='N';
  Q:=sqltoquery('select * from grupos where grup_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('Grup_SomenteCodBarra').asstring;
  FGeral.FechaQuery(Q);

end;

/// 02.09.15 - Mirvane
procedure TFGrupos.breajusteClick(Sender: TObject);
//////////////////////////////////////////////////////
begin
  if not Arq.Tgrupos.active then exit;
  EdGrupospreco.visible:=true;
  EdGrupospreco.enabled:=true;
  EdGrupospreco.setfocus;

end;

procedure TFGrupos.EdGRUPOSPRECOExitEdit(Sender: TObject);
begin
   EdGrupospreco.visible:=false;
   EdGrupospreco.enabled:=false;
end;

// 02.09.15
procedure TFGrupos.EdGRUPOSPRECOValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
var valorbase,novoven,novomin,per:currency;
    Q:Tsqlquery;
    pr:integer;
begin

  if EdGrupospreco.isempty then exit;
  if not FGeral.Getvalor(per,'% Reajuste') then exit;
  if per<=0 then exit;
  if not confirma('Confirma atualização de preços pelo percentual de '+floattostr(per)+'% ?') then exit;
  Sistema.beginprocess('Atualizando produtos do(s) grupo(s) escolhidos');
  Q:=sqltoquery('select * from estoqueqtde inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                ' where esqt_unid_codigo='+stringtosql(global.codigounidade)+' and esqt_status=''N'''+
                ' and '+FGeral.GetIN('esto_grup_codigo',Edgrupospreco.text,'N') );
  pr:=0;
  while not Q.eof do begin
    novoven:=Q.fieldbyname('esqt_vendavis').ascurrency + (Q.fieldbyname('esqt_vendavis').ascurrency*(per/100));
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
    Sistema.endprocess('Atualização feita em '+inttostr(pr)+' produtos ');
  except
    Sistema.endprocess('Problemas no banco de dados.   Atualização não feita');
  end;

end;

end.
