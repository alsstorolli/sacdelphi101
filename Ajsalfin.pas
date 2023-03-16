unit Ajsalfin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, SQLGrid, ExtCtrls;

type
  TFAjusteSaldosFin = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    bExecutar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edmesano: TSQLEd;
    EdPlan_conta: TSQLEd;
    EdPlan_descricao: TSQLEd;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdSaldomov: TSQLEd;
    EdSAldocont: TSQLEd;
    EdSaldoconf: TSQLEd;
    procedure EdmesanoValidate(Sender: TObject);
    procedure EdPlan_contaValidate(Sender: TObject);
    procedure bExecutarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure Edunid_codigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
  end;

var
  FAjusteSaldosFin: TFAjusteSaldosFin;

implementation

uses Sqlexpr, Sqlfun,Sqlsis , Geral;

{$R *.dfm}

procedure TFAjusteSaldosFin.EdmesanoValidate(Sender: TObject);
begin
   if FGeral.Validamesano(edmesano.text) then begin
     if not FGeral.Validaperiodo(edmesano.text) then
       Edmesano.Invalid('');
   end else begin
       Edmesano.Invalid('');
   end;

end;

procedure TFAjusteSaldosFin.EdPlan_contaValidate(Sender: TObject);
begin
  if EdPlan_conta.asinteger>0 then begin
    if pos(EdPlan_conta.resultfind.fieldbyname('plan_tipo').asstring,'M;B;C')=0 then
      EdPlan_conta.invalid('Tipo de conta inválido para transferência');
  end;

end;

procedure TFAjusteSaldosFin.bExecutarClick(Sender: TObject);
var QSaldoatual:TSqlquery;
begin
  if not EdMesano.Valid then exit;
  if EdUnid_codigo.isempty then exit;
  if not EdPlan_conta.valid then exit;
  Sistema.Begintransaction('Gravando');
  QSaldoAtual:=sqltoquery('select samf_plan_conta from salmovfin where samf_status=''N'' and samf_mesano='+stringtosql(FGeral.AnoMesinvertido(EdMesano.text))+
               ' and samf_plan_conta='+Edplan_conta.assql+
               ' and samf_unid_codigo='+EdUnid_codigo.assql );
  if QSaldoAtual.Eof then begin
         Sistema.insert('salmovfin');
         Sistema.setfield('samf_status','N');
         Sistema.setfield('samf_mesano',FGeral.Anomesinvertido(EdMesano.text));
         Sistema.setfield('samf_unid_codigo',EdUnid_codigo.text);
         Sistema.setfield('samf_plan_conta',Edplan_conta.asinteger);
         Sistema.setfield('samf_saldomov',EdSaldomov.ascurrency);
         Sistema.setfield('samf_saldocont',Edsaldocont.ascurrency);
         Sistema.setfield('samf_saldoconf',Edsaldoconf.ascurrency);
         Sistema.setfield('samf_usua_codigo',Global.usuario.codigo);
         Sistema.post;
  end else begin
         Sistema.edit('salmovfin');
         Sistema.setfield('samf_saldomov',EdSaldomov.ascurrency);
         Sistema.setfield('samf_saldocont',Edsaldocont.ascurrency);
         Sistema.setfield('samf_saldoconf',Edsaldoconf.ascurrency);
         Sistema.setfield('samf_usua_codigo',Global.usuario.codigo);
         Sistema.post('samf_status=''N'' and samf_mesano='+stringtosql(FGeral.Anomesinvertido(EdMesano.text))+
                      'and samf_unid_codigo='+Edunid_codigo.assql+' and samf_plan_conta='+Edplan_conta.assql );

  end;
  Sistema.endtransaction('Saldos gravados');
  QSaldoatual.close;
  Freeandnil(QSaldoatual);
  EdMesano.clearall(FAjusteSaldosFin,99);
  EdMesano.setfocus;
end;

procedure TFAjusteSaldosFin.Execute;
begin
  show;
end;

procedure TFAjusteSaldosFin.FormActivate(Sender: TObject);
begin
  EdMesano.setfocus;
end;

procedure TFAjusteSaldosFin.Edunid_codigoValidate(Sender: TObject);
var QSaldoAtual:TSqlquery;
begin
  QSaldoAtual:=sqltoquery('select * from salmovfin where samf_status=''N'' and samf_mesano='+stringtosql(FGeral.AnoMesinvertido(EdMesano.text))+
               ' and samf_plan_conta='+Edplan_conta.assql+
               ' and samf_unid_codigo='+EdUnid_codigo.assql );
  if not QSaldoatual.eof then begin
    EdSaldomov.setvalue(QSaldoatual.fieldbyname('samf_saldomov').ascurrency);
    Edsaldocont.setvalue(QSaldoatual.fieldbyname('samf_saldocont').ascurrency);
    Edsaldoconf.setvalue(QSaldoatual.fieldbyname('samf_saldoconf').ascurrency);
  end else begin
    EdSaldomov.setvalue(0);
    Edsaldocont.setvalue(0);
    Edsaldoconf.setvalue(0);
  end;
end;

procedure TFAjusteSaldosFin.Edunid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdUNid_codigo,key);
end;

end.
