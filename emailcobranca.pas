unit emailcobranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrBase, ACBrMail, Vcl.Grids, SqlDtg,
  Vcl.StdCtrls, Vcl.Mask, SQLEd, Vcl.Buttons, SQLBtn, alabel, Vcl.ExtCtrls,
  SQLGrid, SqlSis, SqlFun, Geral, SqlExpr;

type
  TFEmailcobranca = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bemail: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    PCheques: TSQLPanelGrid;
    GridPedidos: TSqlDtGrid;
    ACBrMail1: TACBrMail;
    Edveninicial: TSQLEd;
    Edvenfinal: TSQLEd;
    procedure EdvenfinalExitEdit(Sender: TObject);
    procedure bemailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
  end;

var
  FEmailcobranca: TFEmailcobranca;
  QPedidos:TSqlquery;

implementation

{$R *.dfm}

procedure TFEmailcobranca.bemailClick(Sender: TObject);
////////////////////////////////////////////////////////
var CorpoEmail,
    NaoEnviados   : TStringList;
    Enviados,
    p             : integer;
begin

   Acbrmail1.from:=FGeral.getconfig1asstring('EMAILORIGEM');
   Acbrmail1.Host:=FGeral.getconfig1asstring('SMTP');
   Acbrmail1.Username:=FGeral.getconfig1asstring('USUARIOSMTP');
   Acbrmail1.Password:=FGeral.getconfig1asstring('SENHASMTP');
   Acbrmail1.Port:=inttostr(FGeral.GetConfig1AsInteger('portasmtp'));
   Acbrmail1.SetSSL:=false;
   ACBrMail1.SetTLS := true;
   if FGeral.EmailStmpcomSSL( FGeral.GetConfig1AsString('EMAILORIGEM') ) then
     Acbrmail1.SetSSL:=true;
   if Edvenfinal.AsDate < EdVenInicial.AsDate then exit;
   if EdVenfinal.IsEmpty then exit;
   if QPedidos = nil then exit;
   if QPedidos.SQL = nil then exit;
   Sistema.BeginProcess('Enviando email(s)');
   Naoenviados := TStringList.Create;
   QPedidos.First;
   Enviados:=0;

   while not QPedidos.Eof do begin

      CorpoEmail := TStringList.Create;
      CorpoEmail.Add('Lembrando que dia '+FGeral.FormataData(QPedidos.FieldByName('pend_datavcto').AsDateTime)+' vence sua parcela de '+FGeral.Formatavalor(QPedidos.FieldByName('pend_valor').AsCurrency,f_cr) +'.');
      CorpoEmail.Add('');
      CorpoEmail.Add('Atenciosamente,');
      CorpoEmail.Add('');
      CorpoEmail.Add(Global.NomeUnidade);
      if AnsiPos('@',QPedidos.fieldbyname('clie_email').asstring)>0 then begin

         AcbrMail1.AddAddress(QPedidos.fieldbyname('clie_email').asstring);
         AcbrMail1.Subject:='Lembrete de Vencimento';

         AcbrMail1.Body.Clear;
         for p:=0 to CorpoEmail.Count-1 do  AcbrMail1.Body.Text:=AcbrMail1.Body.Text+CorpoEmail[p]+'<BR>';

         AcbrMail1.Send;
         inc(enviados);
      end else

         NaoEnviados.add(QPedidos.FieldByName('clie_nome').AsString);

      QPedidos.Next;
      CorpoEmail.Free;

   end;
   if NaoEnviados.Count=0 then

       Sistema.EndProcess(inttostr(enviados)+' Email(s) enviado(s)')

   else

       Sistema.EndProcess('Email(s) N�O enviado(s): '+NaoEnviados.Text);

   NaoEnviados.free;

end;

procedure TFEmailcobranca.EdvenfinalExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var sqlaberto,
    xstatus,
    sqltodos,
    sqldata,
    sqldatacont,
    sqlunidades,
    sqlorder,
    w:string;
begin
    GridPedidos.clear;
    GridPedidos.setfocus;
    Sistema.Beginprocess('Lendo documentos no periodo');
    sqlaberto:=' and pend_rp=''R''';
    xstatus:='N';
    sqltodos:='';
    sqltodos := ' and pend_databaixa is null';
    sqldata:=' and pend_datavcto >='+Edveninicial.assql+' and pend_datavcto <='+Edvenfinal.assql;
    sqlunidades:=' and '+FGeral.Getin('pend_unid_codigo',Global.CodigoUnidade,'C');
    if Global.Usuario.OutrosAcessos[0721] then
        sqldatacont:=''
    else
      sqldatacont:=' and pend_datacont > '+DatetoSql(Global.DataMenorBanco);
    sqlorder:=' order by clie_nome,pend_datavcto';

    w:='select pend_numerodcto,pend_dataemissao,pend_tipo_codigo,pend_datavcto,pend_valor,pend_operacao,'+
                  ' clie_email,clie_nome from pendencias inner join clientes on ( clie_codigo=pend_tipo_codigo )'+
                  ' where '+FGeral.GetIN('pend_status',xstatus,'C')+
                  ' and '+FGeral.GetIn('pend_tipocad','C','C')+
                  ' and clie_emailcorr = ''S'''+
                   sqltodos+
                   sqldatacont+sqlaberto+sqldata+sqlunidades+
                   sqlorder ;
    QPedidos:=sqltoquery( w );

    if QPedidos.eof then begin
      Avisoerro('N�o encontrado documentos em aberto no periodo OU clientes que permitiram enviar email');
      Edvenfinal.setfocus;
    end else begin
      GridPedidos.QuerytoGrid(QPedidos)
//      bmarcatodosclick(self);
    end;

    Sistema.endprocess('');

end;

procedure TFEmailcobranca.Execute;
/////////////////////////////////////////
begin
    GridPedidos.Clear;
    Show;
    EdVeninicial.setfocus;
    EdVeninicial.setdate(Sistema.Hoje);
    EdVenfinal.setdate(Sistema.Hoje);
end;

end.
