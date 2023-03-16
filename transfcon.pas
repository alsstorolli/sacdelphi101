unit transfcon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, SQLEd, Buttons, SQLBtn, SQLGrid,
  ExtCtrls;

type
  TFTransContas = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    bExecutar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edmesano: TSQLEd;
    Texto: TRichEdit;
    EdPlan_conta: TSQLEd;
    EdPlan_descricao: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    Edunid_codigo: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure EdmesanoValidate(Sender: TObject);
    procedure bExecutarClick(Sender: TObject);
    procedure EdPlan_contaValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure ChecaTransferenciaMensal;
  end;

type TSaldos=record
     conta:integer;
     unidade:string;
     samf_saldomov,samf_saldocont,samf_saldoconf,asamf_saldomov,asamf_saldocont,asamf_saldoconf,
     entradas,saidas:currency;
end;

var
  FTransContas: TFTransContas;
  PSaldos:^TSaldos;
  ListaSaldos:Tlist;
  Unidade:string;

implementation

uses Geral, Arquiv, SqlFun, Sqlsis, SqlExpr ;

{$R *.dfm}

{ TFTransContas }

procedure TFTransContas.Execute;
begin
  if FTransContas=nil then FGeral.CreateForm(TFTransContas,FTransContas);
  FTransContas.Edmesano.Text := strzero(DateTomes(Sistema.Hoje),2)+Inttostr(Datetoano(Sistema.Hoje,true));
  FTransContas.Show;


end;

procedure TFTransContas.FormActivate(Sender: TObject);
begin
  Unidade:=Global.CodigoUnidade;
  FTransContas.Edmesano.SetFocus;

end;

procedure TFTransContas.EdmesanoValidate(Sender: TObject);
begin
   if FGeral.Validamesano(edmesano.text) then begin
     if not FGeral.Validaperiodo(edmesano.text) then
       Edmesano.Invalid('');
   end else begin
       Edmesano.Invalid('');
   end;

end;

procedure TFTransContas.bExecutarClick(Sender: TObject);
var Q,QSaldoanterior,QSaldoAtual:TSqlquery;
    p,mes,ano,conta,x:integer;
    saldoanterior:currency;
    mesanoant,sqlconta,sqlcadconta:string;
    Lista:TStringlist;

    procedure AtualizaLista(conta:integer ; valor:currency ;tipomov,xunidade:string ; Movimento,Conferencia:TDatetime );
    var p:integer;
    begin
        for p:=0 to ListaSAldos.Count-1 do begin
          PSaldos:=Listasaldos[p];
          if (Psaldos.conta=conta) and (Psaldos.unidade=xunidade) then begin
            if Tipomov='E' then begin
              PSaldos.entradas:=PSaldos.entradas+valor;
              if Movimento<=1 then
                PSaldos.samf_saldomov:=psaldos.samf_saldomov+valor
              else begin
                PSaldos.samf_saldomov:=psaldos.samf_saldomov+valor;
                PSaldos.samf_saldocont:=psaldos.samf_saldocont+valor;
              end;
              if Conferencia>1 then
                PSaldos.samf_saldoconf:=psaldos.samf_saldoconf+valor;
            end else begin
              PSaldos.saidas:=PSaldos.saidas+valor;
              if Movimento<=1 then
                PSaldos.samf_saldomov:=psaldos.samf_saldomov-valor
              else begin
                PSaldos.samf_saldomov:=psaldos.samf_saldomov-valor;
                PSaldos.samf_saldocont:=psaldos.samf_saldocont-valor;
              end;
              if Conferencia>1 then
                PSaldos.samf_saldoconf:=psaldos.samf_saldoconf-valor;
            end;
            break;
          end;
{
          else begin   // novos registros cfe a unidade - 10.04.06
            New(PSaldos);
            PSaldos.conta:=conta;
            PSaldos.asamf_saldomov:=FGeral.SaldoAnterior(conta,xunidade,'samf_saldomov',texttodate('01'+EdMesano.text));
            PSaldos.asamf_saldocont:=FGeral.SaldoAnterior(conta,xunidade,'samf_saldocont',texttodate('01'+EdMesano.text));
            PSaldos.asamf_saldoconf:=FGeral.SaldoAnterior(conta,xunidade,'samf_saldoconf',texttodate('01'+EdMesano.text));
            PSaldos.samf_saldomov:=0;
            PSaldos.samf_saldocont:=0;
            PSaldos.samf_saldoconf:=0;
            PSaldos.entradas:=0;
            PSaldos.saidas:=0;
            PSaldos.unidade:=xunidade;
            ListaSaldos.Add(PSaldos);
          end;
}
        end;
    end;

begin

  if not EdMesano.ValidEdiAll(FTransContas,99) then exit;
  if confirma('Confirma transferência do caixa/bancos da unidade '+EdUnid_codigo.text+' ?') then begin
    if not Arq.TPlano.Active then Arq.TPlano.Open;
// 06.05.05
    unidade:=EdUNid_codigo.text;
    ListaSaldos:=TList.Create;
    Texto.clear;
    Sistema.Beginprocess('Armazenando saldo do mes anterior');
    sqlcadconta:='';
    if not EdPlan_conta.isempty then
      sqlcadconta:=' and plan_conta='+EdPlan_conta.assql;

    QSaldoanterior:=sqltoquery('select * from plano'+
                    ' where '+FGeral.Getin('plan_tipo','M;B;C','C')+sqlcadconta+' order by plan_conta' );
    mes:=strtoint(copy(edmesano.text,1,2));
    ano:=strtoint(copy(edmesano.text,3,4));
    if mes=1 then begin
      mes:=12;
      dec(ano);
    end else
      dec(mes);
    mesanoant:=inttostr(ano)+strzero(mes,2);

    while not QSaldoanterior.eof do begin
      conta:=QSaldoanterior.fieldbyname('plan_conta').asinteger;
      New(PSaldos);
      PSaldos.conta:=conta;
      PSaldos.asamf_saldomov:=FGeral.SaldoAnterior(conta,unidade,'samf_saldomov',texttodate('01'+EdMesano.text));
      PSaldos.asamf_saldocont:=FGeral.SaldoAnterior(conta,unidade,'samf_saldocont',texttodate('01'+EdMesano.text));
      PSaldos.asamf_saldoconf:=FGeral.SaldoAnterior(conta,unidade,'samf_saldoconf',texttodate('01'+EdMesano.text));
      PSaldos.samf_saldomov:=0;
      PSaldos.samf_saldocont:=0;
      PSaldos.samf_saldoconf:=0;
      PSaldos.entradas:=0;
      PSaldos.saidas:=0;
      PSaldos.unidade:=unidade;
      ListaSaldos.Add(PSaldos);
      if EdPlan_conta.asinteger>0 then
        if EdPlan_conta.asinteger=conta then
          break;
      QSaldoanterior.next;
    end;
    Lista:=TStringlist.create;
    strtolista(Lista,Global.Usuario.UnidadesRelatorios,';',true);
    for x:=0 to LIsta.count-1 do begin
      if trim(lista[x])<>'' then begin
        if (lista[x]<>unidade) and (pos(lista[x],global.UnidadesTestes)=0) then begin
          if ( (EdPlan_conta.asinteger>0) and (EdPlan_conta.asinteger=conta) ) or (EdPlan_conta.asinteger=0) then begin
            New(PSaldos);
            PSaldos.conta:=conta;
            PSaldos.asamf_saldomov:=FGeral.SaldoAnterior(conta,lista[x],'samf_saldomov',texttodate('01'+EdMesano.text));
            PSaldos.asamf_saldocont:=FGeral.SaldoAnterior(conta,lista[x],'samf_saldocont',texttodate('01'+EdMesano.text));
            PSaldos.asamf_saldoconf:=FGeral.SaldoAnterior(conta,lista[x],'samf_saldoconf',texttodate('01'+EdMesano.text));
            PSaldos.samf_saldomov:=0;
            PSaldos.samf_saldocont:=0;
            PSaldos.samf_saldoconf:=0;
            PSaldos.entradas:=0;
            PSaldos.saidas:=0;
            PSaldos.unidade:=lista[x];
            ListaSaldos.Add(PSaldos);
          end;
        end;
      end;
    end;

{
///////////////////////////////////////////////////////////////////////////////////////
    Sistema.Beginprocess('Verificando se já tem saldo mensal neste mes/ano');
    for p:=0 to ListaSAldos.Count-1 do begin
       PSaldos:=Listasaldos[p];
       QSaldoAtual:=sqltoquery('select samf_plan_conta from salmovfin where samf_status=''N'' and samf_mesano='+stringtosql(FGeral.AnoMesinvertido(EdMesano.text))+
                   ' and samf_plan_conta='+inttostr(PSaldos.conta)+
                   ' and samf_unid_codigo='+stringtosql(unidade) );
       if QSaldoAtual.Eof then begin
         Sistema.insert('salmovfin');
         Sistema.setfield('samf_status','N');
         Sistema.setfield('samf_mesano',FGeral.Anomesinvertido(EdMesano.text));
         Sistema.setfield('samf_unid_codigo',unidade);
         Sistema.setfield('samf_plan_conta',Psaldos.conta);
         Sistema.setfield('samf_saldomov',PSaldos.samf_saldomov);
         Sistema.setfield('samf_saldocont',PSaldos.samf_saldocont);
         Sistema.setfield('samf_saldoconf',PSaldos.samf_saldoconf);
         Sistema.setfield('samf_usua_codigo',Global.usuario.codigo);
         Sistema.post;
         if p mod 500 = 0 then
           Sistema.Commit;
       end;
    end;
    Sistema.commit;
///////////////////////////////////////////////////////////////////////////////////////
}
    if EdPlan_conta.asinteger>0 then
      sqlconta:='and movf_plan_conta='+EdPlan_conta.AsSql
    else
      sqlconta:='';
    Sistema.Beginprocess('Gerando movimento');
    Q:=sqltoquery('select * from movfin where movf_status=''N'''+sqlconta+
//                     ' and movf_unid_codigo='+stringtosql(unidade)+
// 10.04.06
                     ' and movf_datamvto>='+Datetosql(texttodate('01'+EdMesano.text))+
                     ' and movf_datamvto<='+Datetosql(DatetoUltimodiames(texttodate('01'+EdMesano.text)))+
                     ' order by movf_unid_codigo,movf_plan_conta,movf_datamvto');
    Sistema.EndProcess('');
    Sistema.Beginprocess('Percorrendo movimento');
    while not Q.eof do begin
      conta:=Q.fieldbyname('movf_plan_conta').asinteger;
      AtualizaLista(conta,Q.fieldbyname('movf_valorger').ascurrency,Q.fieldbyname('movf_Es').asstring,Q.fieldbyname('movf_unid_codigo').asstring,
           Q.fieldbyname('movf_datacont').AsDateTime,Q.fieldbyname('movf_dataextrato').AsDateTime);
      Q.Next;
    end;
    Sistema.Beginprocess('Transferindo o saldo final das contas');
    for p:=0 to Listasaldos.Count-1 do begin
      PSaldos:=ListaSaldos[p];
// 06.05.05 - gravar somente contas q tem algum saldo na filial escolhida
// 08.03.06 - ajustado devido a 'mudança de paradigma'...opção de controlar o saldo da mesma conta
//            mas de unidades diferentes....
// 09.03.06 - 'desmudado'...
//      if ( (PSaldos.asamf_saldomov+PSaldos.samf_saldomov + PSaldos.asamf_saldocont+PSaldos.samf_saldocont  +
//          PSaldos.asamf_saldoconf+PSaldos.samf_saldoconf) <> 0 )
//         ( (PSaldos.samf_saldomov<>0)  ) // 08.06.05 - para nao estragar as outras contas
//        then begin
        QSaldoAtual:=sqltoquery('select samf_plan_conta from salmovfin where samf_status=''N'' and samf_mesano='+stringtosql(FGeral.AnoMesinvertido(EdMesano.text))+
                   ' and samf_plan_conta='+inttostr(PSaldos.conta)+
//                   ' and samf_unid_codigo='+stringtosql(unidade) );
                   ' and samf_unid_codigo='+stringtosql(Psaldos.unidade) );
        if QSaldoAtual.eof then begin
          Sistema.insert('salmovfin');
          Sistema.setfield('samf_status','N');
          Sistema.setfield('samf_mesano',FGeral.Anomesinvertido(EdMesano.text));
//          Sistema.setfield('samf_unid_codigo',unidade);
          Sistema.setfield('samf_unid_codigo',PSaldos.unidade);
          Sistema.setfield('samf_plan_conta',Psaldos.conta);
          Sistema.setfield('samf_saldomov',PSaldos.asamf_saldomov+PSaldos.samf_saldomov);
          Sistema.setfield('samf_saldocont',PSaldos.asamf_saldocont+PSaldos.samf_saldocont);
          Sistema.setfield('samf_saldoconf',PSaldos.asamf_saldoconf+PSaldos.samf_saldoconf);
          Sistema.setfield('samf_usua_codigo',Global.Usuario.Codigo);
          Sistema.post;
        end else begin
          Sistema.Edit('salmovfin');
          Sistema.setfield('samf_saldomov',PSaldos.asamf_saldomov+PSaldos.samf_saldomov);
          Sistema.setfield('samf_saldocont',PSaldos.asamf_saldocont+PSaldos.samf_saldocont);
          Sistema.setfield('samf_saldoconf',PSaldos.asamf_saldoconf+PSaldos.samf_saldoconf);
          Sistema.setfield('samf_usua_codigo',Global.Usuario.Codigo);
          Sistema.Post('samf_status=''N'' and samf_mesano='+stringtosql(FGeral.AnoMesinvertido(EdMesano.text))+
                       ' and samf_plan_conta='+inttostr(PSaldos.conta)+
                       ' and samf_unid_codigo='+stringtosql(PSaldos.unidade));
//                       ' and samf_unid_codigo='+stringtosql(unidade));
        end;
  //      if PSAldos.samf_saldomov<0 then
  //        Texto.Lines.Add('Conta '+inttostr(PSaldos.conta)+' com saldo negativo');
        FGeral.Fechaquery(QSaldoAtual);
        Sistema.Commit;
//      end;

    end;
//    Sistema.Commit;
    Freeandnil(ListaSaldos);
    Dispose(PSaldos);
    Sistema.Endprocess('Transferência terminada');
///////////////    EdMesano.setfocus;
  end;

end;

procedure TFTransContas.EdPlan_contaValidate(Sender: TObject);
begin
  if EdPlan_conta.asinteger>0 then begin
    if pos(EdPlan_conta.resultfind.fieldbyname('plan_tipo').asstring,'M;B;C')=0 then
      EdPlan_conta.invalid('Tipo de conta inválido para transferência');
  end;
end;

procedure TFTransContas.ChecaTransferenciaMensal;
var Q:TSqlquery;
    mes,ano,p:integer;
    mesanoant,unidades:string;
    Lista:Tstringlist;
begin
  if (Global.CodigoUnidade=Global.unidadematriz) or (Global.CodigoUnidade='888') then begin
    FTransContas.Edmesano.Text := strzero(DateTomes(Sistema.Hoje),2)+Inttostr(Datetoano(Sistema.Hoje,true));
    mes:=strtoint(copy(FTransContas.edmesano.text,1,2));
    ano:=strtoint(copy(FTransContas.edmesano.text,3,4));
    if mes=1 then begin
      mes:=12;
      dec(ano);
    end else
      dec(mes);
    mesanoant:=inttostr(ano)+strzero(mes,2);
    Q:=sqltoquery('select * from salmovfin where samf_status=''N'' and samf_mesano='+stringtosql(mesanoant));
    if Q.eof then begin
      unidades:=global.Unidadecuritiba+';'+global.unidadebeltrao+';'+global.unidadecrisciuma+';'+
                global.unidadejoinvile+';'+global.unidadeijui;
      Lista:=Tstringlist.create;
      strtolista(lista,unidades,';',true);
      FTransContas.Edmesano.Text := strzero(mes,2)+Inttostr(ano);
      for p:=0 to Lista.count-1 do begin
        FTransContas.EdUnid_codigo.text:=lista[p];
        bexecutarclick(FTransContas);
      end;
    end;
  end;
end;


end.
