// 03.10.16
// Alteracao de brincos de cada animal nos romaneios

unit brincos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid, Grids, SqlDtg, SqlExpr;

type
  TFBrincos = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    EdBrinco: TSQLEd;
    Grid: TSqlDtGrid;
    EdBrinconovo: TSQLEd;
    EdSetorNovo: TSQLEd;
    EdBaianova: TSQLEd;
    Edpeso: TSQLEd;
    Edbaia: TSQLEd;
    EdSeto_codigo: TSQLEd;
    Edseto_descricao: TSQLEd;
    bincluipeso: TSQLBtn;
    EdOPeracao: TSQLEd;
    bmorte: TSQLBtn;
    procedure EdBrincoExitEdit(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure EdBrincoNovoExitEdit(Sender: TObject);
    procedure EdBrincoNovoValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdSetorNovoExitEdit(Sender: TObject);
    procedure EdBaianovaExitEdit(Sender: TObject);
    procedure bincluipesoClick(Sender: TObject);
    procedure EdpesoValidate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure bmorteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
  end;

var
  FBrincos: TFBrincos;
  Q:TSqlquery;
  xdata:TDatetime;

implementation

uses Geral , Sqlsis , Sqlfun;

{$R *.dfm}

{ TFBrincos }

procedure TFBrincos.Execute;
///////////////////////////////
begin
   Show;
   Grid.clear;
   FGeral.ConfiguraColorEditsNaoEnabled(FBrincos);
   EdBrinco.clear;
   EdBrinco.setfocus;
end;

procedure TFBrincos.EdBrincoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////
var i:integer;
    campos:string;
begin
   if EdBrinco.isempty then exit;
   Sistema.beginprocess('Pesquisando brinco');
   campos:='movd_brinco,movd_numerodoc,mova_dtabate,movd_pesocarcaca,movd_operacao,'+
           'movd_seto_codigo,movd_baia,movd_esto_codigo,mova_tipo_codigo';
   Q:=sqltoquery('select '+campos+' from movabatedet inner join movabate on (movd_transacao=mova_transacao'+
                 ' and movd_tipomov=mova_tipomov) '+
                 ' where movd_brinco = '+EdBrinco.assql+
                 ' and '+FGeral.GetIN('movd_tipomov',('EA;FA'),'C')+
// 29.03.18
                 ' and movd_abatido is null'+
                 ' and mova_dtabate >= '+Datetosql(Sistema.Hoje-360)+
//                 ' and movd_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                 ' and movd_status = ''N''' );
   Grid.clear;
   Sistema.endprocess('');
   if Q.Eof then begin
     Avisoerro('Brinco n�o encontrado em nenhum romaneio');
     exit;
   end;
   i:=1;
   while not Q.eof do begin

     Grid.cells[grid.getcolumn('movd_brinco'),i]:=Q.fieldbyname('movd_brinco').asstring;
     Grid.cells[grid.getcolumn('movd_baia'),i]:=Q.fieldbyname('movd_baia').asstring;
     Grid.cells[grid.getcolumn('movd_seto_codigo'),i]:=Q.fieldbyname('movd_seto_codigo').asstring;
     Grid.cells[grid.getcolumn('movd_numerodoc'),i]:=Q.fieldbyname('movd_numerodoc').asstring;
     Grid.cells[grid.getcolumn('movd_datamvto'),i]:=Q.fieldbyname('mova_dtabate').asstring;
     Grid.cells[grid.getcolumn('movd_pesocarcaca'),i]:=Q.fieldbyname('movd_pesocarcaca').asstring;
     Grid.cells[grid.getcolumn('movd_operacao'),i]:=Q.fieldbyname('movd_operacao').asstring;
     Grid.AppendRow;
     inc(i);
     Q.Next;
   end;
end;

procedure TFBrincos.GridDblClick(Sender: TObject);
////////////////////////////////////////////////////////////////
begin
   EdOperacao.Text:=Grid.Cells[Grid.GetColumn('movd_operacao'),Grid.Row];
   xdata:=TextToDate( Grid.Cells[Grid.GetColumn('movd_datamvto'),Grid.Row] );
end;

procedure TFBrincos.GridKeyPress(Sender: TObject; var Key: Char);
///////////////////////////////////////////////////////////////////
begin
  if key=#13 then begin
    if Grid.Col=Grid.getcolumn('movd_brinco') then begin
       EdBrinconovo.Top:=Grid.Top+40;
       EdBrinconovo.Left:=Grid.LeftCol;
//       EdBrinconovo.Text:=StrToStrNumeros(Grid.Cells[Grid.Col,Grid.Row]);
       EdBrinconovo.Visible:=True;
       EdBrinconovo.Enabled:=True;
       EdBrinconovo.SetFocus;
    end else if Grid.Col=Grid.getcolumn('movd_seto_codigo') then begin
       EdSetornovo.Top:=Grid.Top+40;
       EdSetornovo.Left:=Grid.LeftCol+140;
       EdSetornovo.Visible:=True;
       EdSetornovo.Enabled:=True;
       EdSetornovo.SetFocus;
    end else if Grid.Col=Grid.getcolumn('movd_baia') then begin
       EdBaianova.Top:=Grid.Top+40;
       EdBaianova.Left:=Grid.LeftCol+200;
       EdBaianova.Visible:=True;
       EdBaianova.Enabled:=True;
       EdBaianova.SetFocus;

    end;
  end;
end;

procedure TFBrincos.EdBrincoNovoExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
  if not EdBrinconovo.isempty then begin
    Grid.Cells[Grid.Col,Grid.Row]:=(EdBrinconovo.Text);
  end;
  EdBrinconovo.Visible:=False;
  EdBrinconovo.Enabled:=false;
 Grid.SetFocus;
end;

procedure TFBrincos.EdBrincoNovoValidate(Sender: TObject);
////////////////////////////////////////////////////////////
var Q1:TSqlquery;
    xnumerodoc:integer;
begin
   if not EdBrinconovo.IsEmpty then begin
     xnumerodoc:=strtoint( trim(Grid.cells[Grid.col,grid.row]) );
     Q1:=sqltoquery('select movd_brinco,movd_numerodoc from movabatedet where movd_brinco = '+EdBrinconovo.Assql+
                    ' and movd_numerodoc <> '+Inttostr(xnumerodoc) );
     if not Q1.Eof then EdBrinconovo.Invalid('Brinco encontrado no romaneio '+Q1.fieldbyname('movd_numerodoc').asstring);
     Fgeral.FechaQuery(Q1);
   end;
end;

procedure TFBrincos.EdpesoValidate(Sender: TObject);
begin

   bincluipesoClick(self);

   end;

procedure TFBrincos.bGravarClick(Sender: TObject);
/////////////////////////////////////////////////////
var i:integer;
    operacao:string;
begin
   if EdBrinco.IsEmpty then exit;
   if Q=nil then exit;
   if Q.SQL.Text='' then exit;
   if EdBrinconovo.Enabled then begin
     Aviso('Fechar campo antes de gravar');
     exit;
   end;
   for i:=1 to Grid.RowCount do begin

     operacao:=Grid.cells[Grid.getcolumn('movd_operacao'),i];
     if trim(operacao)<>'' then begin
       Sistema.Edit('movabatedet');
       Sistema.SetField('movd_brinco',Grid.cells[Grid.getcolumn('movd_brinco'),i]);
       Sistema.SetField('movd_seto_codigo',Grid.cells[Grid.getcolumn('movd_seto_codigo'),i]);
       Sistema.SetField('movd_baia',Grid.cells[Grid.getcolumn('movd_baia'),i]);
       Sistema.Post('movd_operacao='+Stringtosql(operacao));
       Sistema.Commit;
       Aviso('Gravado altera��o');
     end;
   end;

   Grid.clear;
   EdBrinco.clear;
   EdBrinco.SetFocus;
end;

procedure TFBrincos.EdSetorNovoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////
begin
  if not EdSetornovo.isempty then begin
    Grid.Cells[Grid.Col,Grid.Row]:=(EdSetornovo.Text);
  end;
  EdSetornovo.Visible:=False;
  EdSetornovo.Enabled:=false;
 Grid.SetFocus;

end;

// 23.03.18
procedure TFBrincos.bincluipesoClick(Sender: TObject);
///////////////////////////////////////////////////////
var transacao,Unid_codigo,Tipomov:string;

begin

  if EdPeso.IsEmpty then begin
     Avisoerro('Informar o peso');
     exit;
  end;
  if EdBrinco.IsEmpty then begin
     Avisoerro('Informar o brinco');
     exit;
  end;
  if EdOperacao.IsEmpty then begin
     Avisoerro('Escolher com duplo clique a opera��o');
     exit;
  end;
  if not confirma('Confirma peso ?') then exit;

        Unid_codigo:=Global.CodigoUnidade;
        Tipomov:='FM';   // movimento na fazenda , local / tipo de confinamento

   Sistema.BeginProcess('Gravando');
// 29.03.18 - para gravar corretamente
   Q.Close;
   Q:=sqltoquery('select * from movabatedet inner join movabate on ( movd_transacao=mova_transacao and mova_tipomov=movd_tipomov)'+
        ' where movd_operacao = '+EdOperacao.AsSql+
        ' and mova_dtabate = '+Datetosql(xdata)  );

        Transacao:=Global.CodigoUnidade+ Inttostr( FGeral.GetContador('TRANEACONF'+Unid_codigo,false) );
        Sistema.Insert('Movabate');
        Sistema.SetField('mova_transacao',Transacao);
        Sistema.SetField('mova_operacao',Transacao+'01');
        Sistema.SetField('mova_status','N');
        Sistema.SetField('mova_numerodoc',strtoint( copy(transacao,1,6) ) );
        Sistema.SetField('mova_tipomov',TipoMov);
        Sistema.SetField('mova_unid_codigo',Unid_codigo);
        Sistema.SetField('mova_tipo_codigo',Q.FieldByName('mova_tipo_codigo').AsInteger);
    //    Sistema.SetField('mova_tipocad','C');
        Sistema.SetField('mova_datalcto',Sistema.Hoje);
//        Sistema.SetField('mova_dtabate',Sistema.Hoje);
        Sistema.SetField('mova_dtcarrega',Sistema.Hoje);
        Sistema.SetField('mova_dtvenci',Sistema.Hoje);
        Sistema.SetField('mova_notagerada',0);
        Sistema.SetField('mova_transacaogerada','');
        Sistema.SetField('mova_pesovivo',0);
        Sistema.SetField('mova_pesocarcaca',EdPeso.ascurrency);
        Sistema.SetField('mova_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('mova_datacont',Sistema.Hoje);
        Sistema.SetField('mova_situacao','P');
{
        Sistema.SetField('mova_tran_codigo',EdTran_codigo.text);
        Sistema.SetField('mova_fpgt_codigo',EdFpgt_codigo.text);
        Sistema.SetField('Mova_repr_codigo',EdRepr_codigo.AsInteger);
        Sistema.SetField('Mova_vlrtotal',EdTotalRemessa.ascurrency);
        Sistema.SetField('Mova_perccomissao',EdPercComissao.ascurrency);
        Sistema.SetField('Mova_vlrgta',Edvalorgta.ascurrency);
}
    ///////////
        Sistema.Post();

        Sistema.Insert('movabatedet');
        Sistema.SetField('movd_esto_codigo',Q.FieldByName('movd_esto_codigo').AsString );
        Sistema.SetField('movd_transacao',transacao);
        Sistema.SetField('movd_operacao',transacao+'01');
        Sistema.SetField('movd_numerodoc',strtoint( copy(transacao,1,6) ) );
        Sistema.SetField('movd_status','N');
        Sistema.SetField('movd_tipomov',TipoMov);
        Sistema.SetField('movd_unid_codigo',Unid_codigo);
        Sistema.SetField('movd_esto_codigo',Q.FieldByName('movd_esto_codigo').AsString );
        Sistema.SetField('movd_tipo_codigo',Q.FieldByName('mova_tipo_codigo').AsInteger);
//        Sistema.SetField('movd_tipocad','C');
        Sistema.SetField('movd_brinco',Edbrinco.Text);
//        Sistema.SetField('movd_idade',0);
//        Sistema.SetField('movd_pesovivo',0);
        Sistema.SetField('movd_pesovivo',EdPeso.AsCurrency);
        Sistema.SetField('movd_vlrarroba',0);
//        Sistema.SetField('movd_obs','');
        Sistema.SetField('movd_ordem',1);
        Sistema.SetField('movd_pecas',1);
        Sistema.SetField('movd_baia',edBaia.text);
        Sistema.SetField('movd_datamvto',Sistema.Hoje);
        Sistema.SetField('movd_seto_codigo',EdSeto_codigo.text);
        Sistema.Post('');

   try
     sistema.Commit;
   except
     Sistema.EndProcess('Erro na grava��o no banco de dados');
   end;
   Sistema.EndProcess('Brinco movimentado');
   EdBrinco.ClearAll(Self,0);
   EdBrinco.SetFocus;

end;

// 14.06.19
procedure TFBrincos.bmorteClick(Sender: TObject);
/////////////////////////////////////////////////////
begin

   if EdBrinco.IsEmpty then begin
      Aviso('Preencher campo do brinco primeiro');
      exit;
   end;

   if EdOperacao.IsEmpty then begin
       Aviso('Escolher uma das opera��es do brinco primeiro');
       exit;
   end;

    if not confirma('Confirma morte ? <S/N>') then exit;

       Sistema.Edit('movabatedet');
//       Sistema.SetField('movd_brinco','');
       Sistema.SetField('movd_status','M');
       Sistema.Post('movd_operacao='+Edoperacao.AsSql);
       Sistema.Commit;
       Aviso('Gravado morte do aninal');


end;

procedure TFBrincos.EdBaianovaExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////
begin

  if not Edbaianova.isempty then begin
    Grid.Cells[Grid.Col,Grid.Row]:=(EdBaianova.Text);
  end;
  EdBaianova.Visible:=False;
  EdBaianova.Enabled:=false;
  Grid.SetFocus;

end;

end.

