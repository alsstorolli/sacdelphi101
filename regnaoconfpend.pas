unit regnaoconfpend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr ;

type
  TFRegNaoConfPendentes = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bimpressao: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    EdAprovada: TSQLEd;
    bcausas: TSQLBtn;
    bplanoacao: TSQLBtn;
    bconsenso: TSQLBtn;
    bprodutonaoconf: TSQLBtn;
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure EdAprovadaExitEdit(Sender: TObject);
    procedure bcausasClick(Sender: TObject);
    procedure bplanoacaoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bconsensoClick(Sender: TObject);
    procedure bresalcancadoClick(Sender: TObject);
    procedure bprodutonaoconfClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetSituacaoRnc(Q:TSqlquery):string;
    function NaotemPlanoAcao(xnumerornc:integer):string;
    procedure AtivaEdit(Ed:Tsqled);
    procedure DesAtivaEdit(Ed:Tsqled);
    procedure QuerytoGrid(Q:Tsqlquery);
    procedure MontaGrid;
    function ValidaBotao(tipo:string):boolean;
    procedure ChecaRegNaoConformidadesPendentes;
    function RnccomProdutoDestinado(xnumero:integer):boolean;

  end;

var
  FRegNaoConfPendentes: TFRegNaoConfPendentes;
  Q,QUsu:TSqlquery;
  Sqlusuario,TipoPlano:string;

implementation

uses Usuarios, Geral, setores, SqlSis, SqlFun , regnaoconf;

{$R *.dfm}

{ TFRegNaoConfPendentes }

procedure TFRegNaoConfPendentes.Execute;
begin
// 02.10.08
//  FGeral.EstiloForm(self);
  Show;
  MontaGrid;
end;

function TFRegNaoConfPendentes.GetSituacaoRnc(Q: TSqlquery): string;
begin
   if Q.fieldbyname('mrnc_aprovada').asstring<>'S' then
     result:='01 - Aguardando Aprovação'
   else if ( trim(Q.fieldbyname('mrnc_inspetor').asstring+Q.fieldbyname('mrnc_op').asstring)='' ) and
        (Q.fieldbyname('mrnc_especie').asstring='2') then
     result:='00 - Aguardando Produto Não Conforme'
   else if  trim( Q.fieldbyname('mrnc_maquina').asstring+
           (Q.fieldbyname('mrnc_matprima').asstring)+
           (Q.fieldbyname('mrnc_meioambiente').asstring)+
           (Q.fieldbyname('mrnc_maoobra').asstring)+
           (Q.fieldbyname('mrnc_medida').asstring) ) = '' then
     result:='02 - Aguardando Análise das Causas'
   else if NaotemPlanoAcao(Q.fieldbyname('mrnc_numerornc').asinteger)='N' then
     result:='03 - Aguardando Plano de Ação'
//   else if NaotemPlanoAcao(Q.fieldbyname('mrnc_numerornc').asinteger)='E' then
   else if NaotemPlanoAcao(Q.fieldbyname('mrnc_numerornc').asinteger)='P' then
     result:='04 - Aguardando Execução das Ações'
   else if Q.fieldbyname('mrnc_usua_consemit').asinteger=0 then
     result:='05 - Aguardando Consenso Setor Emitente'
//   else if Q.fieldbyname('mrnc_resalcancado').asstring='' then
//     result:='06 - Aguardando Resultado Alcançado'
   else
     result:='99 - Não Prevista-Checar';


end;

function TFRegNaoConfPendentes.NaotemPlanoAcao(  xnumerornc: integer): string;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select paca_numeroata,paca_situacao from planoacao where paca_mrnc_numerornc='+inttostr(xnumerornc)+
                ' and paca_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                ' and paca_status=''N'' and paca_tipoplano=''R''');
  if Q.eof then
    result:='N'
  else begin
    result:='E';
    while not Q.eof do begin
      if Q.fieldbyname('paca_situacao').asstring='P' then begin
        result:='P';
        break;
      end;
      Q.Next;
    end;
  end;
  FGeral.FechaQuery(Q);
end;

procedure TFRegNaoConfPendentes.GridDblClick(Sender: TObject);
var numero:integer;
begin
   numero:=strtointdef(Grid.cells[Grid.GetColumn('MRNC_numerornc'),Grid.row],0);
   if numero=0 then exit;
   if Grid.GetColumn('MRNC_APROVADA')=Grid.Col then begin
     EdAprovada.text:=Grid.cells[Grid.GetColumn('MRNC_APROVADA'),Grid.row];
     if EdAprovada.text='S' then begin
       Avisoerro('RNC já aprovada');
       EdAprovada.text:='';
       exit;
     end;
     if ( pos( NaotemPlanoacao(numero),'E;P' ) >0 )  and (EdAprovada.text='S') then begin
       Avisoerro('RNC já aprovada e com plano de ação');
       exit;
     end else begin
       AtivaEdit(EdAprovada);
     end;
   end;
end;

procedure TFRegNaoConfPendentes.GridKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    Griddblclick(self);
end;

procedure TFRegNaoConfPendentes.AtivaEdit(Ed: Tsqled);
begin
  Ed.Top:=Grid.TopEdit;
  Ed.Left:=Grid.LeftEdit;
  Ed.Enabled:=true;
  Ed.Visible:=true;
  Ed.SetFocus;
end;

procedure TFRegNaoConfPendentes.DesAtivaEdit(Ed: Tsqled);
begin
  Ed.Enabled:=false;
  Ed.Visible:=false;
  Grid.setfocus;
end;

procedure TFRegNaoConfPendentes.EdAprovadaExitEdit(Sender: TObject);
var numero:integer;
begin
   numero:=strtointdef(Grid.cells[Grid.GetColumn('MRNC_numerornc'),Grid.row],0);
   if not EdAprovada.isempty then begin
     try
       Grid.cells[Grid.GetColumn('MRNC_APROVADA'),Grid.row]:=EdAprovada.text;
       Sistema.Edit('movrnc');
       Sistema.SetField('mrnc_aprovada',Edaprovada.Text);
       Sistema.Post('mrnc_numerornc='+inttostr(numero)+' and mrnc_unid_codigo='+stringtosql(Global.CodigoUnidade));
       Sistema.Commit;
       MontaGrid;
     except
       Avisoerro('Não foi possível gravar a informação');
     end;

   end;
   Desativaedit(EdAprovada);
end;

procedure TFRegNaoConfPendentes.bcausasClick(Sender: TObject);
var numero:integer;
begin
   if not ValidaBotao('C') then exit;
   numero:=strtointdef(Grid.cells[Grid.GetColumn('MRNC_numerornc'),Grid.row],0);
   FRegNaoConformidade.Execute('C',numero);
end;

procedure TFRegNaoConfPendentes.QuerytoGrid(Q: Tsqlquery);
var i:integer;
begin
  Grid.clear;i:=1;
  while not Q.Eof do begin
//         Grid.Cells[Grid.getcolumn('paca_usua_resp'),i]:=FUsuarios.GetNome( Q.fieldbyname('paca_usua_resp').AsINteger );
     Grid.Cells[Grid.getcolumn('mrnc_descricao'),i]:=Q.fieldbyname('mrnc_descricao').AsString;
     Grid.Cells[Grid.getcolumn('mrnc_aprovada'),i]:=Q.fieldbyname('mrnc_aprovada').AsString;
     Grid.Cells[Grid.getcolumn('situacao'),i]:=GetSituacaoRnc(Q);
     Grid.Cells[Grid.getcolumn('mrnc_numerornc'),i]:=Q.fieldbyname('mrnc_numerornc').AsString;
     Grid.Cells[Grid.getcolumn('mrnc_usua_produto'),i]:=Q.fieldbyname('mrnc_usua_produto').AsString;
     Grid.Cells[Grid.getcolumn('mrnc_especie'),i]:=Q.fieldbyname('mrnc_especie').AsString;
     inc(i);
     Grid.AppendRow;
     Q.Next;
  end;
end;

procedure TFRegNaoConfPendentes.MontaGrid;
var setores,sqlusu:string;
begin
  QUsu:=sqltoquery('select * from setores where seto_usua_codigo='+inttostr(Global.Usuario.Codigo));
  if QUsu.eof then begin
//    Avisoerro('Usuário não encontrado em nenhum setor');
    Close;
    exit;
  end;
  setores:='';
  while not QUsu.Eof do begin
    setores:=setores+Qusu.fieldbyname('seto_codigo').asstring+';';
    QUsu.Next;
  end;
  if trim(setores)='' then begin
//    Avisoerro('Usuário não está configurado em nenhum setor');
    Close;
    exit;
  end;
  Sistema.beginprocess('Pesquisando não conformidades');
  sqlusuario:=' and '+FGeral.GetIN('mrnc_seto_ocorre',Setores,'C');
  FRegNaoconfPendentes.Caption:='Registros de Não Conformidades - Setor '+FSetores.GetDescricao(Qusu.fieldbyname('seto_codigo').asstring);
  sqlusu:='';
  if Global.Usuario.OutrosAcessos[0401] then begin
    sqlusuario:='';
    FRegNaoconfPendentes.Caption:='Registros de Não Conformidades - Todos os Setores ';
  end;
  if Global.Usuario.OutrosAcessos[0404] then begin
    sqlusu:=' and mrnc_usua_produto='+inttostr(Global.Usuario.Codigo);
    sqlusuario:='';
  end;
  Q:=sqltoquery('select * from movrnc where mrnc_status=''N'''+
                ' and mrnc_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                ' and mrnc_situacao=''P'''+
                sqlusuario+sqlusu+
                ' order by mrnc_data');
  if not Q.eof then
    QuerytoGrid(Q);
  Sistema.endprocess('');

end;

procedure TFRegNaoConfPendentes.bplanoacaoClick(Sender: TObject);
var numero:integer;
begin
   if not ValidaBotao('P') then exit;
   numero:=strtointdef(Grid.cells[Grid.GetColumn('MRNC_numerornc'),Grid.row],0);
   FRegNaoConformidade.Execute('P',numero);
end;

procedure TFRegNaoConfPendentes.FormActivate(Sender: TObject);
begin
  MontaGrid;  // 17.10.08 - aqui pra ficar 'sempre atualizado'
end;

procedure TFRegNaoConfPendentes.bconsensoClick(Sender: TObject);
var numero:integer;
begin
  if not ValidaBotao('E') then exit;
  numero:=strtointdef(Grid.cells[Grid.GetColumn('MRNC_numerornc'),Grid.row],0);
  if (not RnccomProdutoDestinado(numero)) and (Grid.cells[Grid.GetColumn('MRNC_numerornc'),Grid.row]='2') then exit;
  FRegNaoConformidade.Execute('E',numero);

end;

function TFRegNaoConfPendentes.ValidaBotao(tipo: string): boolean;
var r:string;
begin
   result:=true;
   r:=copy(Grid.cells[Grid.getcolumn('situacao'),grid.Row],1,2);
   if (tipo='C') and ( pos(r,'02;00')=0 ) then
     result:=false
   else if (tipo='P') and ( pos(r,'03;04')=0 ) then
     result:=false
   else if (tipo='E') and ( pos(r,'05')=0 ) then
     result:=false
   else if (tipo='L') and ( pos(r,'06')=0 ) then
     result:=false
   else if (tipo='D') and ( pos(r,'00')=0 ) then
     result:=false;
   if not result then
     Avisoerro('Na situação '+Grid.cells[Grid.getcolumn('situacao'),grid.Row]+' não é permitido')
end;

procedure TFRegNaoConfPendentes.bresalcancadoClick(Sender: TObject);
//var numero:integer;
begin
//  if not ValidaBotao('L') then exit;
//   numero:=strtointdef(Grid.cells[Grid.GetColumn('MRNC_numerornc'),Grid.row],0);
//   FRegNaoConformidade.Execute('L',numero);

end;

procedure TFRegNaoConfPendentes.bprodutonaoconfClick(Sender: TObject);
var numero:integer;
begin
  if not Global.Usuario.OutrosAcessos[0404] then begin
    Avisoerro('Usuário sem permissão de informar produto não conforme');
    exit;
  end;
  if not ValidaBotao('D') then exit;
   numero:=strtointdef(Grid.cells[Grid.GetColumn('MRNC_numerornc'),Grid.row],0);
   FRegNaoConformidade.Execute('D',numero);

end;


procedure TFRegNaoConfPendentes.ChecaRegNaoConformidadesPendentes;
begin
  MontaGrid;
  if trim(Grid.cells[Grid.getcolumn('mrnc_numerornc'),01])='' then exit;

end;

function TFRegNaoConfPendentes.RnccomProdutoDestinado(  xnumero: integer): boolean;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select mrnc_inspetor,mrnc_op  from movrnc where mrnc_numerornc='+inttostr(xnumero)+' and mrnc_unid_codigo='+stringtosql(Global.CodigoUnidade));
  result:=false;
  if not Q.Eof then begin
    if trim(Q.fieldbyname('mrnc_inspetor').asstring+Q.fieldbyname('mrnc_op').asstring)='' then begin
      Avisoerro('Rnc ainda sem produto destinado');
      result:=false;
    end else begin
      result:=true;
    end;
  end;
  FGeral.FechaQuery(Q);

end;

end.
