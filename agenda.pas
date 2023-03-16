// 20.03.17
// Agendamentos ( pacientes )

unit agenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, SqlDtg, Vcl.StdCtrls,
  Vcl.Mask, SQLEd, Vcl.Buttons, SQLBtn, alabel, Vcl.ExtCtrls, SQLGrid,
  Vcl.ComCtrls, SqlExpr;

type
  TFAgendamento = class(TForm)
    PMens: TSQLPanelGrid;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bExcluir: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    SQLPanelGrid3: TSQLPanelGrid;
    Pinicial: TSQLPanelGrid;
    EdUnid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    PIns: TSQLPanelGrid;
    Edmoag_tipoage: TSQLEd;
    Edmoag_datamvto: TSQLEd;
    Edmoag_tipo_codigo: TSQLEd;
    SetEdFUNC_NOME: TSQLEd;
    DtGrid1: TSqlDtGrid;
    DateTimePicker1: TDateTimePicker;
    Edmoag_valor: TSQLEd;
    EdMoag_hora: TSQLEd;
    EdInicio: TSQLEd;
    EdFinal: TSQLEd;
    Lhora: TLabel;
    Timer1: TTimer;
    TimerAtualizacao: TTimer;
    banamnese: TSQLBtn;
    lvalor: TLabel;
    batualiza: TSQLBtn;
    procedure bIncluirClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Execute;
    procedure Edmoag_valorExitEdit(Sender: TObject);
    procedure DateTimePicker1Exit(Sender: TObject);
    procedure Edmoag_valorValidate(Sender: TObject);
    procedure EdFinalExitEdit(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TimerAtualizacaoTimer(Sender: TObject);
    procedure banamneseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAgendamento: TFAgendamento;
  Q           : TSqlquery;
  xdata       : TDatetime;
  xunidade    : string;
const
  tipocad:string='C';

implementation

uses SqlFun,SqlSis,Geral, OCORRENC;

{$R *.dfm}

// 28.03.17
procedure TFAgendamento.banamneseClick(Sender: TObject);
//////////////////////////////////////////////////////////
var codcli,clie_nome:string;
begin
   codcli := dtGrid1.Cells[dtgrid1.GetColumn('moag_tipo_codigo'),dtGrid1.Row];
   clie_nome := dtGrid1.Cells[dtgrid1.GetColumn('clie_nome'),dtGrid1.Row];
   if trim(codcli)='' then begin
     Avisoerro('Escolher um cliente primeiro');
     exit;
   end;
   FOcorrencias.Execute('C',strtoint(codcli),Clie_nome);

end;

procedure TFAgendamento.bCancelarClick(Sender: TObject);
////////////////////////////////////////////////////////
begin
   PIns.Visible := false;
   PIns.DisableEdits;
   DtGrid1.SetFocus;

end;

procedure TFAgendamento.bExcluirClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var codfun,codafas,xhora:string;
    datainicio:TDatetime;
begin
   codfun  := dtGrid1.Cells[dtgrid1.GetColumn('moag_tipo_codigo'),dtGrid1.Row];
   codafas := dtGrid1.Cells[dtgrid1.GetColumn('moag_tipoage'),dtGrid1.Row];
   xhora   := dtGrid1.Cells[dtgrid1.GetColumn('moag_hora'),dtGrid1.Row];
   datainicio:= Strtodate(dtGrid1.Cells[dtgrid1.GetColumn('moag_datamvto'),dtGrid1.Row]);
   if trim(codfun) <> '' then begin
     if confirma('Confirma exclus�o ?') then begin

       dtgrid1.DeleteRow(dtgrid1.Row);
       dtgrid1.Refresh;
       Sistema.BeginProcess('Apagando agendamento');
       Executesql('update movagenda set moag_status = ''C'''+
                  ' where moag_UNID_CODIGO = '+EdUnid_codigo.AsSql+
                  ' and moag_tipo_codigo = '+codfun+
                  ' and moag_tipocad = '+Stringtosql(tipocad)+
                  ' and moag_tipoage = '+stringtosql(codafas)+
                  ' and moag_hora = '+stringtosql(xhora)+
                  ' and moag_datamvto = '+datetosql(datainicio)+
                  ' and moag_status = ''N'''  );
       Sistema.Commit;
       Sistema.EndProcess('');
       Dtgrid1.SetFocus;
     end;
   end;
end;

procedure TFAgendamento.bIncluirClick(Sender: TObject);
/////////////////////////////////////////////////////////
begin
   PIns.EnableEdits;
   PIns.Visible := true;
   Edmoag_tipo_codigo.SetFocus;
   EdMOag_tipo_codigo.ClearAll(FAgendamento,99);
   EdMoag_Datamvto.SetDate(Sistema.hoje);
   EdMoag_Tipoage.text:='C';

end;

procedure TFAgendamento.bSairClick(Sender: TObject);
///////////////////////////////////////////////////
begin
   Execute;
end;

procedure TFAgendamento.DateTimePicker1Exit(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
  EdMoag_datamvto.SetDate( Datetimepicker1.DateTime );
  EdMoag_datamvto.setfocus;

end;

procedure TFAgendamento.EdFinalExitEdit(Sender: TObject);
begin
   Execute;
end;

procedure TFAgendamento.Edmoag_valorExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////////
var Q1:TSqlquery;
begin
//   xdata:=EdMoag_datamvto.AsDate;
   xunidade:=Global.CodigoUnidade;
   Q1:=sqltoquery('select * from movagenda where moag_datamvto = '+EdMoag_Datamvto.AsSql+
                   ' and moag_status = ''N'''+
                   ' and moag_hora = '+EdMoag_hora.AsSql+
                   ' and moag_unid_codigo = '+Stringtosql(xunidade) );
   if not Q1.Eof then begin
     Avisoerro('Hor�rio j� utilizado nesta data');
     exit;
   end;
   if Confirma('Confirma informa��es ?') then begin
     Sistema.Insert('movagenda');
     Sistema.SetField('moag_status','N');
     Sistema.SetField('moag_unid_codigo',xunidade);
     Sistema.SetField('moag_usua_codigo',Global.Usuario.codigo);
     Sistema.SetField('moag_datamvto',EdMoag_Datamvto.AsDate);
     Sistema.SetField('moag_datalcto',Sistema.Hoje);
     Sistema.SetField('moag_tipocad','C');
     Sistema.SetField('moag_tipo_codigo',EdMoag_tipo_codigo.AsInteger);
     Sistema.SetField('moag_tipoage',EdMoag_tipoage.TExt);
     Sistema.SetField('moag_hora',EdMoag_hora.TExt);
     Sistema.SetField('moag_valor',EdMoag_valor.Ascurrency);
     Sistema.Post();
     Sistema.Commit;
     Execute;
   end;
   EdMoag_tipo_codigo.ClearAll(FAgendamento,99);
   EdMoag_datamvto.SetDate( Datetimepicker1.DateTime );
   EdMoag_tipo_codigo.setfocus;

end;

procedure TFAgendamento.Edmoag_valorValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
   if (EdMoag_valor.AsCurrency=0)  and (Edmoag_tipoage.Text='C') then EdMoag_valor.Invalid('Em consultas obrigat�rio o valor');

end;

procedure TFAgendamento.Execute;
///////////////////////////////////
var p:integer;
    xtot:currency;
begin
  if FAgendamento=nil then begin
     FGeral.CreateForm(TFAgendamento,FAgendamento);
  end;
  xdata:=Sistema.Hoje;
  xunidade:=Global.CodigoUnidade;
  if EdInicio.IsEmpty then begin
    EdInicio.SetDate(Sistema.Hoje);
    EdFinal.SetDate(Sistema.Hoje);
  end;
  DateTimePicker1.DateTime:=Sistema.Hoje;
///  Timer1.enabled:=true;
/////////  TimerAtualizacao.enabled:=true;
  Q:=sqltoquery('select movagenda.*,clie_nome from movagenda inner join clientes on (clie_codigo=moag_tipo_codigo)'+
                ' where moag_datamvto >= '+EdInicio.assql+
                ' and moag_datamvto <= '+EdFinal.assql+
                ' and moag_status = ''N'''+
                ' and moag_unid_codigo = '+Stringtosql(xunidade)+
                ' order by moag_unid_codigo,moag_datamvto,moag_hora' );
  p:=1;
  DtGrid1.Clear;
  while not Q.Eof do begin
    Dtgrid1.QueryToRow(Q,p);
    if Q.FieldByName('moag_tipocad').AsString<>'C' then
      DtGrid1.Cells[Dtgrid1.getcolumn('clie_nome'),p]:=
                   Fgeral.GetNomeRazaoSocialEntidade(Q.FieldByName('moag_tipo_codigo').AsInteger,
                   Q.FieldByName('moag_tipocad').AsString,'N');
    xtot:=xtot+Q.FieldByName('moag_valor').AsCurrency;
    inc(p);
    DtGrid1.AppendRow;
    Q.Next;
  end;
  FAgendamento.Show;
  lvalor.Caption:=FGeral.Formatavalor(xtot,'###,##0.00');
  EdInicio.SetFocus;

end;

procedure TFAgendamento.FormActivate(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
  EdUnid_codigo.Text:=Global.CodigoUnidade;
  Edmoag_tipo_codigo.Clear;
  EdInicio.SetDate(Sistema.Hoje);
  EdFinal.SetDate(Sistema.Hoje);
//  Lhora.Caption:=Timetostr(Time());
  DtGrid1.setfocus;

end;

procedure TFAgendamento.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Timer1.enabled:=false;
  TimerAtualizacao.enabled:=false;

end;

procedure TFAgendamento.Timer1Timer(Sender: TObject);
begin
//   Lhora.Caption:=TimeToStr(now);
end;

procedure TFAgendamento.TimerAtualizacaoTimer(Sender: TObject);
begin
///  Execute;
end;

end.
