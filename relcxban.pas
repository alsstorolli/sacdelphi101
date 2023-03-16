unit relcxban;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid;

type
  TFRelcxbancos = class(TForm)
    PRel: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    baplicar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Eddatai: TSQLEd;
    Eddataf: TSQLEd;
    EdPlan_conta: TSQLEd;
    EdPlan_descricao: TSQLEd;
    EdHist_codigo: TSQLEd;
    EdHist_descricaoe: TSQLEd;
    Edunid_codigo: TSQLEd;
    EdTiporel: TSQLEd;
    EdSaldoanterior: TSQLEd;
    Edsinana: TSQLEd;
    Edtipo_codigo: TSQLEd;
    SeEdrepr_nome: TSQLEd;
    EdStatus: TSQLEd;
    EdQContas: TSQLEd;
    blancar: TSQLBtn;
    bjuros: TSQLBtn;
    bjuroscpr: TSQLBtn;
    EdQdata: TSQLEd;
    procedure baplicarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EddatafValidate(Sender: TObject);
    procedure EdTiporelExitEdit(Sender: TObject);
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure EdPlan_contaValidate(Sender: TObject);
    procedure blancarClick(Sender: TObject);
    procedure bjurosClick(Sender: TObject);
    procedure bjuroscprClick(Sender: TObject);
  private
    { Private declarations }
    SaiOk:Boolean;
  public
    { Public declarations }
     procedure Lancajuros(xOP:String='A');
  end;

var
  FRelcxbancos: TFRelcxbancos;
  sqlunidade,sqlperiodo,sqlconta,sqlhistorico,sqlacesso,sqlcodtipo,sqlstatus,sqltipomov:string;
  rel:integer;

procedure FRelCxBancos_Extrato;          // 1
procedure FRelCxBancos_DespRece;         // 2
procedure FRelCxBancos_FluxoCaixa;       // 3
procedure FRelCxBancos_ResumoComissoes;  // 4   // 29.05.06
procedure FRelCxBancos_ExtratoSintetico; // 5   // 02.07.07
procedure FRelCxBancos_RecebimentoDiario; // 6   // 10.08.15


implementation

uses Geral, Unidades, SQLRel, SqlExpr, plano, Hist, Sqlsis, Sqlfun,
  represen, Usuarios, relfinan, Estoque, portador, confplano;

{$R *.dfm}

function TituloConta(Conta:integer):string;
begin
  if conta>0 then begin
    result:=inttostr(conta)+' - '+FPlano.GetDescricao(conta);
  end else
    result:='Todas as contas';
end;

function TituloPeriodo(datai,dataf:TDatetime):string;
begin
  if datai>1 then
    result:=FGeral.formatadata(Datai)+' a '+FGeral.formatadata(Dataf)
  else
    result:='Sem per�odo escolhido pelo usu�rio';
end;

function TituloHistorico(codigo:integer):string;
begin
  if codigo>0 then
    result:=inttostr(codigo)+' - '+FHistoricos.GetDescricao(codigo)
  else
    result:='Sem hist�rico escolhido pelo usu�rio';
end;

// 23.05.05 - para
procedure SetaItensTipoRel;
begin
  FRelcxbancos.EdTiporel.Items.Clear;
  if not Global.usuario.OutrosAcessos[0701] then begin
    FRelcxbancos.EdTiporel.visible:=false;
    FRelcxbancos.EdTiporel.enabled:=false;
    FRelcxbancos.EdTiporel.text:='1';
  end else if Global.usuariopadrao<>Global.usuario.codigo then begin
    if Global.usuario.OutrosAcessos[0701] then begin
      FRelcxbancos.EdTiporel.Items.Add('1');
      FRelcxbancos.EdTiporel.Items.Add('2');
      FRelcxbancos.EdTiporel.Items.Add('9 - Ambos');
    end else begin
      FRelcxbancos.EdTiporel.Items.Add('1');
    end;
  end;
end;

function FRelCxBancos_Execute(Tp:Integer):Boolean;
/////////////////////////////////////////////////////
begin
  if FRelCxBancos=nil then FGeral.CreateForm(TFRelCxBancos, FRelCxBancos);
  result:=true;
  rel:=tp;
  SetaItensTiporel;
  with FRelCxBancos do begin

    EdQdata.enabled := False;
    EdQdata.visible := False;

    FUnidades.SetaItems(EdUnid_codigo,nil,Global.Usuario.UnidadesRelatorios);
// 08.03.06
    if EdUnid_codigo.isempty then
      EdUnid_codigo.text:=Global.CodigoUnidade;
//    FGeral.SetaItemsMovimento(EdTipomov);
    sqlunidade:='';
    if tp=1 then
      Caption:='Extrato de Movimenta��o da Conta'
    else if tp=2 then begin

      Caption:='Relat�rio de Receitas/Despesas';
// 10.06.2022
      EdQdata.enabled :=True;
      EdQdata.visible := True;

    end else if tp=3 then
      Caption:='Relat�rio de Fluxo de Caixa'
    else if tp=4 then
      Caption:='Relat�rio de Comiss�es'
    else if tp=5 then
      Caption:='Extrato Sint�tico com o saldos das Contas'
    else if tp=6 then
      Caption:='Resumo Di�rio por Usu�rio';
    SaiOk:=False;
    EdUnid_codigo.enabled:=true;
    if EdDAtai.isempty then
      EdDatai.setdate(sistema.hoje);
    if EdDAtaf.isempty then
      EdDataf.setdate(sistema.hoje);
    if (tp=1) or ( tp=5 ) or ( tp=2 ) then
      EdTiporel.enabled:=true
    else
      EdTiporel.enabled:=tp=1;
    EdSaldoanterior.enabled:=tp=3;
    EdPlan_conta.enabled:=true;
    EdHist_codigo.enabled:=true;
    if tp=3 then begin
      EdPlan_conta.enabled:=false;
      EdHist_codigo.enabled:=false;
    end;
    EdSinana.enabled:=tp=2;
//    if (tp=2) or (tp=4) then begin
//      Edtipo_codigo.enabled:=true;
//      EdStatus.enabled:=true;
//    end else begin
//      Edtipo_codigo.enabled:=false;
//      EdStatus.enabled:=false;
//    end;
    EdQcontas.enabled:=tp=2;
    FRelCxBancos.ShowModal;
    FRelCxBancos.blancar.visible:=( not global.Usuario.OutrosAcessos[0723]);
    FRelCxBancos.blancar.Enabled:=( not global.usuario.outrosacessos[0723]);
    Result:=SaiOk;
  end;
end;

//////////////////////////////////////////////////
procedure FRelCxBancos_Extrato;          // 1
////////////////////////////////////////////

type TTipos=record
    historico:string;
    valor:currency;
    contarecdes:integer;
end;

var Q,QSaldo,QContas:TSqlquery;
    saldoanterior,saldo,entant,saiant,saldogeral,saldogeralsemmov,saldocor,txjuros,vlrjuros:currency;
    inicio,dataant:TDatetime;
    sqlorder,contas:string;
    ListaSaldos,ListaContas,ListaPortadores,ListaPortadoresValores,ListaImp:Tstringlist;
    Diasatraso:integer;

var Lista:Tlist;
    PTipos:^ttipos;
    p,x,conta:integer;
    historico:string;


//    function procura(descricao:string):integer;
    function procura(conta:integer):integer;
    ////////////////////////////////////////
    var p:integer;
    begin
      result:=-1;
      for p:=0 to Lista.count-1 do begin
        Ptipos:=lista[p];
//        if ptipos.historico=descricao then begin
        if conta=ptipos.contarecdes then begin
          result:=p;
          break;
        end;
      end;
    end;

    procedure AtualizaSaldo(xconta:integer;xsaldo:currency);
    //////////////////////////////////////////////////////////
    var xpos:integer;
    begin
      xpos:=Listacontas.IndexOf(strzero(xconta,8));
      if xpos =-1 then begin
        ListaContas.Add(strzero(xconta,8));
        ListaSaldos.Add(valortosql(xsaldo))
      end else begin
        ListaSaldos[xpos]:=(valortosql(xsaldo))
      end;
    end;

    function GetSaldoGeral:currency;
    ///////////////////////////////////
    var s:integer;
        xsaldo:currency;
    begin
      xsaldo:=0;
      for s:=0 to ListaSaldos.Count-1 do xsaldo:=xsaldo+texttovalor(ListaSaldos[s]);
      result:=xsaldo;
    end;

    function GetSaldoGeralSemMov:currency;
    ///////////////////////////////////
    var s,xconta:integer;
        xsaldo,xsaldoanterior:currency;
        Listax:TStringList;
    begin
      xsaldo:=0;
      Listax:=TStringList.create;
      strtoLista(Listax,contas,';',true); // todas as contas marcadas
      for s:=0 to Listax.Count-1 do begin
//        caso nao foi impresso dai soma saldo anterior
          if ListaContas.IndexOf( strzero(strtointdef(Listax[s],0),8) ) = -1 then begin
            xconta:=strtointdef( Listax[s],0 );
            if xconta>0 then begin
              if (FRelcxbancos.Edtiporel.text='2') then
                xsaldoanterior:=FGeral.SaldoAnterior(xconta,FRelcxbancos.EdUnid_codigo.text,'samf_saldomov',inicio)-
                               FGeral.SaldoAnterior(xconta,FRelcxbancos.EdUnid_codigo.text,'samf_saldocont',inicio)
              else if (FRelcxbancos.Edtiporel.text='9') then
                xsaldoanterior:=FGeral.SaldoAnterior(xconta,FRelcxbancos.EdUnid_codigo.text,'samf_saldomov',inicio)
              else
                xsaldoanterior:=FGeral.SaldoAnterior(xconta,FRelcxbancos.EdUnid_codigo.text,'samf_saldocont',inicio);
              xsaldo:=xsaldo+xsaldoanterior ;
            end;
          end;
      end;
      Listax.Free;
      result:=xsaldo;
    end;

// 14.03.14
    function GetDescricaoProdutos(t,nome:String):string;
    ////////////////////////////////////////////////////
    var Q:TSqlquery;
        Listacodigos:TStringlist;
        p:integer;
        s:String;
    begin
      Q:=sqltoquery('select move_esto_codigo from movestoque where move_transacao='+stringtosql(t));
      Listacodigos:=TStringlist.create;
      while not Q.eof do begin
        Listacodigos.add(Q.fieldbyname('move_esto_codigo').asstring);
        Q.Next;
      end;
      FGeral.FechaQuery(Q);
      s:='';
      for p:=0 to ListaCodigos.Count-1 do begin
        if trim(ListaCodigos[p])<>'' then begin
          s:=s+trim(FEstoque.GetDescricao(ListaCodigos[p]))+'+';
        end;
      end;
      if trim(s)<>'' then
        result:=s
      else
        result:=nome;
    end;
////////////////////////////////////


    procedure AcumulaPortador(xtransacao:String);
    //////////////////////////////////////////////
    var QP:TSqlquery;
        busca:integer;
        Lista:TStringList;
    begin
      Qp:=sqltoquery('select pend_valor,pend_port_codigo,port_descricao from pendencias inner join portadores on ( port_codigo=pend_port_codigo )'+
                     ' where pend_transbaixa='+Stringtosql(xtransacao));
      if not Qp.eof then begin
        busca:=ListaPortadores.IndexOf(QP.fieldbyname('pend_port_codigo').asstring);
        if busca = -1 then begin
          ListaPortadores.Add(QP.fieldbyname('pend_port_codigo').asstring);
          ListaPortadoresValores.Add(QP.fieldbyname('port_descricao').asstring+';'+FGeral.Formatavalor(Q.fieldbyname('movf_valorger').ascurrency,f_cr));
        end else begin
          Lista:=TStringList.create;
          strtolista(Lista,ListaPortadoresValores[busca],';',true);
          ListaPortadoresValores[busca]:=QP.fieldbyname('port_descricao').asstring+';'+FGeral.Formatavalor(TextToValor(Lista[1])+Q.fieldbyname('movf_valorger').ascurrency,f_cr);
          Lista.free;
        end;
      end;
      FGeral.fechaquery(QP);
/////////////////////
{
       else begin
        FGeral.fechaquery(QP);
        Qp:=sqltoquery('select moes_port_codigo,port_descricao from movesto inner join portadores on ( port_codigo=moes_port_codigo )'+
                       ' where moes_transacao='+Stringtosql(xtransacao));
        if not Qp.eof then begin
          busca:=ListaPortadores.IndexOf(QP.fieldbyname('moes_port_codigo').asstring);
          if busca = -1 then begin
            ListaPortadores.Add(QP.fieldbyname('moes_port_codigo').asstring);
            ListaPortadoresValores.Add(QP.fieldbyname('port_descricao').asstring+';'+FGeral.Formatavalor(Q.fieldbyname('movf_valorger').ascurrency,f_cr));
          end else begin
            Lista:=TStringList.create;
            strtolista(Lista,ListaPortadoresValores[busca],';',true);
            ListaPortadoresValores[busca]:=QP.fieldbyname('port_descricao').asstring+';'+FGeral.Formatavalor(TextToValor(Lista[1])+Q.fieldbyname('movf_valorger').ascurrency,f_cr);
            Lista.free;
          end;
        end;
        FGeral.fechaquery(QP);
      end;
}
//////////////////////
    end;




begin
//////////////////
  with FRelCxBancos do begin
    if not FRelCxBancos_Execute(1) then Exit;
    sqlunidade:=' and '+FGeral.getin('movf_unid_codigo',EdUnid_codigo.text,'C');
    if EdDAtai.Asdate<=1 then begin
      sqlperiodo:='';
      inicio:=Sistema.hoje;
    end else begin
      if EdPlan_conta.asinteger>0 then begin
        inicio:=DateToPrimeiroDiaMes(EdDatai.Asdate);
        sqlperiodo:=' and movf_datamvto>='+DatetoSql(inicio)+' and movf_datamvto<='+EdDataf.AsSql;
      end else begin
        sqlperiodo:=' and movf_datamvto>='+EdDatai.AsSql+' and movf_datamvto<='+EdDataf.AsSql;
        inicio:=EdDatai.Asdate;
      end;
    end;
    contas:='';
    txjuros:=0;
    if EdPlan_conta.AsInteger=0 then begin
      sqlconta:='';
// 19.03.08
      QContas:=sqltoquery('select plan_conta from plano where plan_imprimeextrato=''S''');
      while not Qcontas.eof do begin
        contas:=contas+Qcontas.fieldbyname('plan_conta').asstring+';';
        QContas.Next;
      end;
      if trim(contas)<>'' then
        sqlconta:=' and '+FGeral.GetIN('movf_plan_conta',contas,'N');
      saldoanterior:=0;
    end else begin
      txjuros:=EdPlan_conta.ResultFind.FieldByName('Plan_taxajuros').AsCurrency;
      sqlconta:=' and movf_plan_conta='+EdPlan_conta.AsSql;
// 03.04.13
      if EdPlan_conta.Resultfind.fieldbyname('plan_contaabatimentos').AsInteger=0 then begin
//      if Global.Usuario.OutrosAcessos[0701] then
          if (Edtiporel.text='2') then
    //        saldoanterior:=FGeral.SaldoAnterior(EdPlan_conta.asinteger,copy(EdUnid_codigo.text,1,3),'samf_saldomov',inicio)-
    //                       FGeral.SaldoAnterior(EdPlan_conta.asinteger,copy(EdUnid_codigo.text,1,3),'samf_saldocont',inicio)
    // 09.12.05
            saldoanterior:=FGeral.SaldoAnterior(EdPlan_conta.asinteger,EdUnid_codigo.text,'samf_saldomov',inicio)-
                           FGeral.SaldoAnterior(EdPlan_conta.asinteger,EdUnid_codigo.text,'samf_saldocont',inicio)
          else if (Edtiporel.text='9') then
    //        saldoanterior:=FGeral.SaldoAnterior(EdPlan_conta.asinteger,Global.CodigoUnidade,'samf_saldomov',inicio)
            saldoanterior:=FGeral.SaldoAnterior(EdPlan_conta.asinteger,EdUnid_codigo.text,'samf_saldomov',inicio)
          else
            saldoanterior:=saldoanterior+FGeral.SaldoAnterior(EdPlan_conta.asinteger,EdUnid_codigo.text,'samf_saldocont',inicio);
      end else
        saldoanterior:=0
    end;
    if EdHist_codigo.AsInteger=0 then
      sqlhistorico:=''
    else
      sqlhistorico:=' and movf_hist_codigo='+EdHIst_codigo.AsSql;

//    if Global.Usuario.OutrosAcessos[0701] then
    if (Edtiporel.text='9') then
      sqlacesso:=''
    else if (Edtiporel.text='2') then
      sqlacesso:=' and movf_datacont is null'
    else
      sqlacesso:=' and movf_datacont is not null';
// 18.07.16 - Novicarnes - Sandro - retirado esta condicao e deixado por ordem da transacao
//    if pos( global.unidadematriz,EdUnid_codigo.text ) >0 then
      sqlorder:=' order by movf_plan_conta,movf_datamvto,movf_transacao';
//    else
//      sqlorder:=' order by movf_plan_conta,movf_datamvto,movf_plan_contard';

    ListaSaldos:=Tstringlist.Create;
    ListaContas:=Tstringlist.Create;

    Sistema.Setmessage('Gerando relat�rio');
//    Q:=sqltoquery('select * from movfin left join plano on (plan_conta=movf_plan_conta)'+
    if Eddatai.AsDate=EdDataf.AsDate then
      Q:=sqltoquery('select * from movfin'+
                  ' left join historicos on (hist_codigo=movf_hist_codigo)'+
                  ' where '+FGeral.Getin('movf_status','N','C')+
                  sqlunidade+
                  sqlperiodo+sqlconta+sqlhistorico+sqlacesso+
                  sqlorder )
//                  ' order by movf_plan_conta,movf_datamvto,movf_complemento' )
//                  ' order by movf_plan_conta,movf_datamvto,movf_plan_contard' )
    else
      Q:=sqltoquery('select * from movfin'+
                  ' left join historicos on (hist_codigo=movf_hist_codigo)'+
                  ' where '+FGeral.Getin('movf_status','N','C')+
                  sqlunidade+
                  sqlperiodo+sqlconta+sqlhistorico+sqlacesso+
//                  ' order by movf_plan_conta,movf_datamvto,movf_transacao,movf_numerodcto' );
// 11.04.05
                  ' order by movf_plan_conta,movf_datamvto,movf_tipomov,movf_transacao,movf_numerodcto' );

    if Q.Eof then begin
      if EdPlan_conta.ResultFind<>nil then begin
        if EdPlan_conta.ResultFind.FieldByName('plan_contaabatimentos').asinteger=0 then begin
          Sistema.EndProcess('Nada encontrado para impress�o');
          exit;
        end;
      end else begin
        Sistema.EndProcess('Nada encontrado para impress�o');
        exit;
      end;
    end;
    Sistema.BeginProcess('Imprimindo Relat�rio');
    Lista:=tlist.create;
    entant:= 0; saiant:=0;
    ListaPortadores:=Tstringlist.Create;
    ListaPortadoresValores:=Tstringlist.Create;
    if EdPlan_conta.asinteger>0 then begin
      while (not Q.Eof) and (Q.fieldbyname('movf_datamvto').asdatetime<EdDatai.Asdate) do begin
        if pos( Q.FieldByName('movf_unid_codigo').AsString,EdUnid_codigo.text ) >0 then begin  // 09.09.05
          if Q.FieldByName('movf_Es').AsString='E' then begin
            saldoanterior:=saldoanterior+Q.fieldbyname('movf_valorger').ascurrency;
            entant:=entant+Q.fieldbyname('movf_valorger').ascurrency;
          end else begin
            saldoanterior:=saldoanterior-Q.fieldbyname('movf_valorger').ascurrency;
            saiant:=saiant+Q.fieldbyname('movf_valorger').ascurrency;
          end;
        end;
        Q.Next;
      end;

////////////      showmessage('entradas:'+floattostr(entant)+' saidas:'+floattostr(saiant)) ;

    end;
    FRel.Init('ExtratoCxBancos');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
    FRel.AddTit('Conta : '+TituloConta(EdPlan_conta.asinteger));
    FRel.AddTit('Periodo : '+TituloPeriodo(EdDatai.Asdate,EdDataf.asdate)+' - Hist�rico : '+TituloHistorico(EdHist_codigo.asinteger));
    if Global.Topicos[1276] then
      FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    if EdPlan_conta.asinteger=0 then begin
      FRel.AddCol( 90,0,'C','' ,''              ,'Conta'          ,''         ,'',false);
      FRel.AddCol( 90,0,'C','' ,''              ,'Descri��o'      ,''         ,'',false);
    end;
//    FRel.AddCol( 90,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
    FRel.AddCol( 90,0,'C','' ,''              ,'Opera��o'       ,''         ,'',false);
    FRel.AddCol( 60,2,'D','' ,''              ,'Lan�amento'  ,''         ,'',false);
    FRel.AddCol( 60,2,'D','' ,''              ,'Movimento'  ,''         ,'',false);
    FRel.AddCol( 60,2,'D','' ,''              ,'Bom Para '       ,''         ,'',false);
    FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc.'     ,''         ,'',False);
    FRel.AddCol( 35,1,'C','' ,''              ,'Tipo'     ,''         ,'',False);
//    FRel.AddCol( 60,0,'D','' ,''              ,'Confer�ncia'     ,''         ,'',False);
    FRel.AddCol( 70,2,'N','' ,''              ,'No Cheque'       ,''         ,'',False);
    FRel.AddCol(240,0,'C','' ,''              ,'Hist�rico'       ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+',f_cr            ,'Entradas'        ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+',f_cr            ,'Saidas'          ,''         ,'',False);
//    if EdPlan_conta.asinteger>0 then
      FRel.AddCol( 80,3,'N','',f_cr            ,'Saldo'   ,''         ,'',False);
    saldo:=saldoanterior;
    saldocor:=saldoanterior;
// 10.05.17
//    if (EdPlan_conta.asinteger>0) and (txjuros>0) then
//      FRel.AddCol( 80,3,'N','',f_cr            ,'Saldo Corrigido'   ,''         ,'',False);
    FRel.AddCol( 80,2,'C','' ,''              ,'Rec./Desp.',''         ,'',false);
    FRel.AddCol(160,0,'C','' ,''              ,'Descri��o conta' ,''         ,'',false);
// 27.08.11
    if Global.Topicos[1281] then begin
      FRel.AddCol( 60,3,'C','' ,''              ,'Codigo',''         ,'',false);
      FRel.AddCol(100,0,'C','' ,''              ,'Usu�rio' ,''         ,'',false);
    end;
    txjuros:=0;   // para nao fazer nada aqui por enquanto
/////////////////////////
{
    if EdPlan_conta.asinteger>0 then begin
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('Saldo anterior');
      if Q.FieldByName('movf_Es').AsString='E' then begin
        FRel.AddCel('');
        FRel.AddCel('');
      end else begin
        FRel.AddCel('');
        FRel.AddCel('');
      end;
      FRel.AddCel(FGeral.Formatavalor(saldo,f_cr));
      FRel.AddCel('');
      FRel.AddCel('');
    end;
}
/////////////////////////
    conta:=989809;
    while not Q.eof do begin
//      FRel.AddCel(Q.FieldByName('movf_unid_codigo').AsString);
//      if EdPlan_conta.asinteger=0 then begin
/////////////////////////
        if (conta<>Q.FieldByName('movf_plan_conta').AsInteger) then begin
          if EdPlan_conta.asinteger=0 then begin  // 11.07.08 - Elize detectou q meio 'dobrava' o saldo anterior
            if (Edtiporel.text='2') then
              saldoanterior:=FGeral.SaldoAnterior(Q.FieldByName('movf_plan_conta').AsInteger,EdUnid_codigo.text,'samf_saldomov',EdDatai.asdate)-
                             FGeral.SaldoAnterior(Q.FieldByName('movf_plan_conta').AsInteger,EdUnid_codigo.text,'samf_saldocont',EdDatai.asdate)
            else if (Edtiporel.text='9') then
              saldoanterior:=FGeral.SaldoAnterior(Q.FieldByName('movf_plan_conta').AsInteger,EdUnid_codigo.text,'samf_saldomov',EdDatai.asdate)
            else
              saldoanterior:=FGeral.SaldoAnterior(Q.FieldByName('movf_plan_conta').AsInteger,EdUnid_codigo.text,'samf_saldocont',EdDatai.asdate);
// 05.08.08
            saldo:=saldoanterior;
            if Global.Topicos[1276] then begin // clessi viu mas tem coluna da unidade - 10.2010
               // 27.08.11
               if Global.Topicos[1281] then
                 FGeral.PulalinhaRel(20)
               else
                 FGeral.PulalinhaRel(16);
            end else begin
               // 27.08.11
               if Global.Topicos[1281] then
                 FGeral.PulalinhaRel(19)
               else;
                 FGeral.PulalinhaRel(15);   // 05.08.08
            end;

          end;
          if Global.Topicos[1276] then
            FRel.AddCel('');
          if EdPlan_conta.asinteger=0 then begin
            FRel.AddCel('');
            FRel.AddCel('');
          end;
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('Saldo anterior');
          if Q.FieldByName('movf_Es').AsString='E' then begin
            FRel.AddCel('');
            FRel.AddCel('');
          end else begin
            FRel.AddCel('');
            FRel.AddCel('');
          end;
          FRel.AddCel(FGeral.Formatavalor(saldoanterior,f_cr));
// 10.05.17
          if (EdPlan_conta.asinteger>0) and (txjuros>0) then
            FRel.AddCel('');
          FRel.AddCel('');
          FRel.AddCel('');
// 27.08.11
          if Global.Topicos[1281] then begin
            FRel.AddCel('');
            FRel.AddCel('');
          end;
        end;
/////////////////////////
//      end;
//      FRel.AddCel(Q.FieldByName('movf_transacao').AsString);
      if Global.Topicos[1276] then
          FRel.AddCel(Q.FieldByName('movf_unid_codigo').AsString);
      if EdPlan_conta.asinteger=0 then begin
          FRel.AddCel(Q.FieldByName('movf_plan_conta').AsString);
          FRel.AddCel(FPlano.GetDescricao(Q.FieldByName('movf_plan_conta').AsInteger));
      end;
// 27.07.15  - resumo por portador usado na baixa
      if (Global.Topicos[1294]) and ( not EdPlan_conta.isempty ) then
         if EdPlan_conta.ResultFind.fieldbyname('plan_tipo').asstring='C' then
           AcumulaPortador(Q.FieldByName('movf_transacao').AsString);

      FRel.AddCel(Q.FieldByName('movf_operacao').AsString);
      FRel.AddCel(Q.FieldByName('movf_datamvto').AsString);
      FRel.AddCel(Q.FieldByName('movf_datacont').AsString);
      FRel.AddCel(Q.FieldByName('movf_dataprevista').AsString);
      FRel.AddCel(Q.FieldByName('movf_numerodcto').AsString);
      FRel.AddCel(Q.FieldByName('movf_tipomov').AsString);
//      FRel.AddCel(Q.FieldByName('movf_dataextrato').AsString);
      FRel.AddCel(Q.FieldByName('movf_numerocheque').AsString);
      FRel.AddCel(FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString);
      historico:=FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString;
      if Q.FieldByName('movf_Es').AsString='E' then begin
        FRel.AddCel(Q.FieldByName('movf_valorger').AsString);
        FRel.AddCel('');
        saldo:=saldo+Q.FieldByName('movf_valorger').AsCurrency;
      end else begin
        FRel.AddCel('');
        FRel.AddCel(Q.FieldByName('movf_valorger').AsString);
        saldo:=saldo-Q.FieldByName('movf_valorger').AsCurrency;
      end;
      dataant:=Q.FieldByName('movf_datamvto').AsDateTime;
  ///////////////////    if EdPlan_conta.asinteger>0 then
      FRel.AddCel(FGeral.Formatavalor(saldo,f_cr));

// 10.05.17
{
      if (EdPlan_conta.asinteger>0) and (txjuros>0) then begin
        Q.Next;
        diasatraso:=Trunc(Q.FieldByName('movf_datamvto').AsDateTime-DataAnt);
        Q.Prior;
        saldocor:=saldo * ( (txjuros/30)/100 ) * diasatraso;
        FRel.AddCel(FGeral.Formatavalor(saldocor,f_cr));
      end;
}
// 13.02.14 - Vivan - Liane
      AtualizaSaldo(Q.FieldByName('movf_plan_conta').AsInteger,saldo);

      FRel.AddCel(Q.FieldByName('movf_plan_contard').AsString);
      FRel.AddCel(FPlano.GetDescricao(Q.FieldByName('movf_plan_contard').AsInteger));
      if Global.Topicos[1281] then begin
         FRel.AddCel(Q.FieldByName('movf_usua_codigo').Asstring);
         FRel.AddCel(FUsuarios.getnome(Q.FieldByName('movf_usua_codigo').Asinteger));
      end;

//      x:=procura(copy(historico,1,14));
//      x:=procura(copy(Q.FieldByName('movf_complemento').AsString,1,10));
//      x:=procura(Q.FieldByName('movf_tipomov').AsString);
      x:=Procura( Q.fieldbyname('movf_plan_contard').asinteger );
      if x<0 then begin
        New(Ptipos);
//        ptipos.historico:=copy(Q.FieldByName('movf_complemento').AsString,1,10);
        ptipos.historico:=copy(historico,1,14);
        ptipos.contarecdes:=Q.fieldbyname('movf_plan_contard').asinteger;
//        ptipos.historico:=Q.FieldByName('movf_tipomov').AsString;
        ptipos.valor:=Q.FieldByName('movf_valorger').AsCurrency;
        Lista.add(Ptipos);
      end else begin
        ptipos:=lista[x];
        ptipos.valor:=ptipos.valor+Q.FieldByName('movf_valorger').Ascurrency;
      end;
      conta:=Q.FieldByName('movf_plan_conta').AsInteger;
      Q.Next;
    end;

// 16.02.14 - Vivan - Liane
//////////////////////////////
    if (listaSaldos.count>=1) and (EdPlan_conta.asinteger=0) then begin
      saldogeral:=GetSaldoGeral;
      saldogeralsemmov:=GetSaldoGeralSemmov;
      saldogeral:=saldogeral+saldogeralsemmov;
      FGeral.PulalinhaRel(17);
      if EdPlan_conta.asinteger=0 then begin
        FRel.AddCel('');
        FRel.AddCel('');
      end;
      if Global.Topicos[1276] then
            FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('Sem movimento per�odo');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel(floattostr(saldogeralsemmov));
      FRel.AddCel('');
      FRel.AddCel('');
      if Global.Topicos[1281] then begin
            FRel.AddCel('');
            FRel.AddCel('');
      end;
      if EdPlan_conta.asinteger=0 then begin
        FRel.AddCel('');
        FRel.AddCel('');
      end;
      if Global.Topicos[1276] then
            FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('Soma dos Saldos');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel(floattostr(saldogeral));
      FRel.AddCel('');
      FRel.AddCel('');
      if Global.Topicos[1281] then begin
            FRel.AddCel('');
            FRel.AddCel('');
      end;

    end;


//////////////////////////////////////////////////////
//    showmessage(inttostr(lista.count));

///////////////////    FRel.AddCel('');  // 26.06.12
    if (lista.count>1) and ( Global.Topicos[1283])  then begin
      if EdPlan_conta.asinteger=0 then begin
        FRel.AddCel('');
        FRel.AddCel('');
      end;
      if Global.Topicos[1276] then
            FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('RESUMO DO MOVIMENTO');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
// 10.05.17
      if (EdPlan_conta.asinteger>0) and (txjuros>0) then
        FRel.AddCel('');
// 27.08.11
      if Global.Topicos[1281] then begin
            FRel.AddCel('');
            FRel.AddCel('');
      end;
    end;

// 26.06.12 - Damama - Fabi
    if ( Global.Topicos[1283])  then begin
      for p:=0 to lista.count-1 do begin
        ptipos:=lista[p];
        if EdPlan_conta.asinteger=0 then begin
          FRel.AddCel('');
          FRel.AddCel('');
        end;
        if Global.Topicos[1276] then
           FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
  //      FRel.AddCel(ptipos.historico+' - '+FGEral.GetTipoMovto(ptipos.historico,false));
  //      FRel.AddCel(ptipos.historico);
        if ptipos.contarecdes=0 then
  //        FRel.AddCel(inttostr(Global.CodContaVendaaVista)+' - '+FPlano.GetDescricao(Global.CodContaVendaaVista) )
          FRel.AddCel('Lan�amentos sem conta de receita/despesa')
        else
          FRel.AddCel(inttostr(ptipos.contarecdes)+' - '+FPlano.GetDescricao(ptipos.contarecdes));
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel(formatfloat(f_cr,ptipos.valor));
// 10.05.17
        if (EdPlan_conta.asinteger>0) and (txjuros>0) then
          FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
  // 27.08.11
        if Global.Topicos[1281] then begin
              FRel.AddCel('');
              FRel.AddCel('');
        end;
      end;
    end;
// 27.07.15  - resumo por portador usado na baixa
////////////////////////////////////////////////////////////////////
    if (Global.Topicos[1284]) and ( not EdPlan_conta.isempty ) then begin
    if EdPlan_conta.ResultFind.fieldbyname('plan_tipo').asstring='C' then begin
      ListaImp:=Tstringlist.create;
      FGeral.PulalinhaRel(13);
      if Global.Topicos[1281] then
        FGeral.PulalinhaRel(15);
      for p:=0 to listaportadoresvalores.count-1 do begin
        strtolista(ListaImp,ListaPortadoresValores[p],';',true);
        if EdPlan_conta.asinteger=0 then begin
          FRel.AddCel('');
          FRel.AddCel('');
        end;
        if Global.Topicos[1276] then
           FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
          FRel.AddCel( ListaImp[0] );
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel( ListaImp[1] );
        if Global.Topicos[1281] then begin
              FRel.AddCel('');
              FRel.AddCel('');
        end;
      end;
      ListaImp.free;
    end;
    end;
//////////////////////////////////////////

// 14.03.14 - Damama - Acerto com funcionarios - busca no contas a receber do periodo por emissao do
//            relatorio o que estiver em Aberto.
    if EdPlan_conta.ResultFind<>nil then begin
      if EdPlan_conta.ResultFind.FieldByName('plan_contaabatimentos').asinteger>0 then begin
         QSaldo:=sqltoquery('select * from pendencias where pend_tipo_codigo='+inttostr(EdPlan_conta.ResultFind.FieldByName('plan_contaabatimentos').asinteger)+
                 ' and pend_rp=''R'' and pend_dataemissao >= '+EdDatai.AsSql+
                 ' and pend_dataemissao <= '+EdDataf.AsSql+
                 ' and pend_status<>''C'' and pend_tipocad=''C'''+
                 ' and '+FGeral.GetIN('pend_unid_codigo',EdUnid_codigo.text,'C') );
         while not QSaldo.eof do begin
            if Global.Topicos[1276] then
                FRel.AddCel(QSaldo.FieldByName('pend_unid_codigo').AsString);
            if EdPlan_conta.asinteger=0 then begin
                FRel.AddCel('');
                FRel.AddCel('');
            end;
            FRel.AddCel(QSaldo.FieldByName('pend_operacao').AsString);
            FRel.AddCel(QSaldo.FieldByName('pend_datamvto').AsString);
            FRel.AddCel(QSaldo.FieldByName('pend_datacont').AsString);
            FRel.AddCel(QSaldo.FieldByName('pend_datamvto').AsString);
            FRel.AddCel(QSaldo.FieldByName('pend_numerodcto').AsString);
            FRel.AddCel(QSaldo.FieldByName('pend_tipomov').AsString);
            FRel.AddCel('');
            FRel.AddCel( GetDescricaoProdutos(QSaldo.FieldByName('pend_transacao').AsString,FGeral.GetNomeRazaoSocialEntidade(QSaldo.FieldByName('pend_tipo_codigo').AsInteger,QSaldo.FieldByName('pend_tipocad').AsString,'R')));
//            if Q.FieldByName('movf_Es').AsString='E' then begin
//              FRel.AddCel(QSaldo.FieldByName('pend_valor').AsString);
//              FRel.AddCel('');
//              saldo:=saldo+QSaldo.FieldByName('pend_valor').AsCurrency;
//            end else begin
              FRel.AddCel('');
              FRel.AddCel(QSaldo.FieldByName('pend_valor').AsString);
              saldo:=saldo-QSaldo.FieldByName('pend_valor').AsCurrency;
//            end;

        ///////////////////    if EdPlan_conta.asinteger>0 then
            FRel.AddCel(FGeral.Formatavalor(saldo,f_cr));
            FRel.AddCel(QSaldo.FieldByName('pend_plan_conta').AsString);
            FRel.AddCel(FPlano.GetDescricao(QSaldo.FieldByName('pend_plan_conta').AsInteger));
            if Global.Topicos[1281] then begin
               FRel.AddCel(QSaldo.FieldByName('pend_usua_codigo').Asstring);
               FRel.AddCel(FUsuarios.getnome(QSaldo.FieldByName('pend_usua_codigo').Asinteger));
            end;
           QSaldo.Next;
         end;
         FGeral.FechaQuery(Qsaldo);
      end;
    end;

////////////////////////////////////////////

    FRel.Video;
    Q.close;
    Freeandnil(Q);
    Freeandnil(Lista);
    Sistema.EndProcess('');
//  17.01.06
    FRelCxBancos_Extrato;          // 1

  end;

//  FRelCxBancos_Execute(1);

end;


////////////////////////////////////////////////////
procedure FRelCxBancos_DespRece;         // 2
////////////////////////////////////////////////////
var Q,QAdian:TSqlquery;
    saldoanterior,saldo,comissao,txjuros,saldocor,vlrjuros,jurosacm:currency;
    inicio,dataant:TDatetime;
    sqlqcontas,titulocontas,sqlorder,
    titqdata:string;
    diasatraso:integer;

begin

  with FRelCxBancos do begin
    if not FRelCxBancos_Execute(2) then Exit;
    sqlunidade:=' and '+FGeral.getin('movf_unid_codigo',EdUnid_codigo.text,'C');
    titulocontas:='';
    if EdQdata.text='M' then titqdata := ' - usando a data informada'
                        else titqdata := ' - usando a data em que foi lan�ado';
    if EdDAtai.Asdate<=1 then begin
      sqlperiodo:='';
      inicio:=Sistema.hoje;
    end else begin
      if EdPlan_conta.asinteger>0 then begin
        inicio:=DateToPrimeiroDiaMes(EdDatai.Asdate);
//        sqlperiodo:=' and movf_datamvto>='+DatetoSql(inicio)+' and movf_datamvto<='+EdDataf.AsSql;
// 25.05.06
        sqlperiodo:=' and movf_dataprevista>='+DatetoSql(inicio)+' and movf_dataprevista<='+EdDataf.AsSql;
// 10.06.22
        if EdQdata.text = 'D' then

            sqlperiodo:=' and movf_datalcto>='+DatetoSql(inicio)+' and movf_datalcto<='+EdDataf.AsSql;

      end else begin
//        sqlperiodo:=' and movf_datamvto>='+EdDatai.AsSql+' and movf_datamvto<='+EdDataf.AsSql;
// 25.05.06
        sqlperiodo:=' and movf_dataprevista>='+EdDatai.AsSql+' and movf_dataprevista<='+EdDataf.AsSql;
        inicio:=EdDatai.Asdate;
// 10.06.22
        if EdQdata.text = 'D' then

           sqlperiodo:=' and movf_datalcto>='+EdDatai.AsSql+' and movf_datalcto<='+EdDataf.AsSql;

      end;
    end;
    txjuros:=0;
// 19.06.2012 - Damama
    sqlorder:=' order by movf_plan_contard,movf_datamvto';
// 10.06.22
        if EdQdata.text = 'D' then

           sqlorder:=' order by movf_plan_contard,movf_datalcto';

    if EdPlan_conta.AsInteger=0 then begin
// 14.08.08
      if Global.Topicos[1257] then
        sqlconta:=' and movf_plan_conta>0'
      else
        sqlconta:=' and movf_plan_contard>0';
      saldoanterior:=0;

    end else begin
//  Sistema.Setfield('movf_plan_contard',Contarecdes);

        sqlconta:=' and movf_plan_contard='+EdPlan_conta.AsSql;
// 02.06.17
      saldoanterior:=FGeral.SaldoAnteriorRecDes(EdPlan_conta.asinteger,EdUNid_codigo.Text,'samf_saldomov',inicio);
//      saldoanterior:=0;
//      sqlorder:=' order by movf_plan_contard,movf_dataprevista';
// 04.07.17
      sqlorder:=' order by movf_plan_contard,movf_dataprevista,movf_numerodcto';
      txjuros:=EdPlan_conta.ResultFind.FieldByName('Plan_taxajuros').AsCurrency;
// 10.06.22
      if EdQdata.text = 'D' then

        sqlorder:=' order by movf_plan_contard,movf_datalcto,movf_numerodcto';

    end;

    if EdHist_codigo.AsInteger=0 then
      sqlhistorico:=''
    else
      sqlhistorico:=' and movf_hist_codigo='+EdHIst_codigo.AsSql;
{
    if Global.Usuario.OutrosAcessos[0701] then
      sqlacesso:=''
    else
      sqlacesso:=' and movf_datacont is not null';
}
// 16.12.08
    if EdTipoRel.text='9' then
      sqlacesso:=''
    else if EdTipoRel.text='1' then
      sqlacesso:=' and movf_datacont is not null'
    else
      sqlacesso:=' and movf_datacont is null';
    sqlcodtipo:='';
    sqltipomov:='';
    if not Edtipo_codigo.isempty then begin
      sqlcodtipo:=' and movf_tipo_codigo='+Edtipo_codigo.assql;
// 27.06.06 - para nao misturar os lan�amentos ref. a antecipa��es dos "representantes/clientes"
      if EdPlan_conta.AsInteger=0 then begin
//        sqlconta:=' and movf_plan_contard>0 and '+FGeral.Getnotin('movf_plan_contard','317;316','N');
        sqltipomov:=' and '+FGeral.Getnotin('movf_tipomov',Global.CodComissaoRepr,'C') ;
      end;
    end;
    sqlstatus:='N';
    if EdStatus.text='N' then begin
      if (EdPlan_conta.asinteger=0) and (Edtipo_codigo.asinteger>0) then
        sqlstatus:='N;G';  // para que quando imprima normalmente o relat. 'apare�a automatico' os lancamos 'G' cfe bom para
//      sqlstatus:='N'  // para que quando imprima normalmente o relat. 'apare�a automatico' os lancamos 'G' cfe bom para
    end else if not EdStatus.isempty then
      sqlstatus:=EdStatus.text;
// mudado aqui em 03.09.09 -antes so afetava o sintetico
    if FRelCxBancos.EdQContas.text='S' then
      sqlqcontas:=' and Plan_fluxocaixa=''S'''
    else if EdQContas.text='N' then
      sqlqcontas:=' and Plan_fluxocaixa=''N'''
    else
      sqlqcontas:='';
    Sistema.Setmessage('Gerando relat�rio');
//    Q:=sqltoquery('select * from movfin left join plano on (plan_conta=movf_plan_conta)'+
    if FRelCxBancos.EdSinana.text='A' then
      Q:=sqltoquery('select * from movfin'+
                  ' left join historicos on (hist_codigo=movf_hist_codigo)'+
                  ' left join plano on ( plan_conta=movf_plan_contard )'+
                  ' where '+FGeral.Getin('movf_status',sqlstatus,'C')+
                  sqlunidade+
                  sqlcodtipo+sqlqcontas+
                  sqlperiodo+sqlconta+sqlhistorico+sqlacesso+sqltipomov+
                  sqlorder )
//                  ' order by movf_plan_contard,movf_datamvto,movf_transacao,movf_numerodcto' );
    else begin
      Q:=sqltoquery('select movf_plan_contard,movf_es,sum(movf_valorger) as movf_valorger from movfin'+
                  ' inner join plano on ( plan_conta=movf_plan_contard )'+
                  ' where '+FGeral.Getin('movf_status',sqlstatus,'C')+
                  sqlunidade+
                  sqlcodtipo+
                  sqlqcontas+
                  sqlperiodo+sqlconta+sqlhistorico+sqlacesso+sqltipomov+
                  ' group by movf_plan_contard,movf_es' );
    end;
    if Q.Eof then begin
      Sistema.EndProcess('Nada encontrado para impress�o');
      Q.close;
      exit;
    end;
    Sistema.BeginProcess('Imprimindo Relat�rio');
    if (EdPlan_conta.asinteger>0) and (EdSinana.text='A') then begin
// 19.06.12 - Damama - mudade movf_datamvto para neste while do saldo anterior movf_dataprevista
      while (not Q.Eof) and (Q.fieldbyname('movf_dataprevista').asdatetime<EdDatai.Asdate) do begin
        if Q.FieldByName('movf_Es').AsString='E' then
          saldoanterior:=saldoanterior+Q.fieldbyname('movf_valorger').ascurrency
        else
          saldoanterior:=saldoanterior-Q.fieldbyname('movf_valorger').ascurrency;
        Q.Next;
      end;
    end;
    if EdSinana.text='A' then
      FRel.Init('RelatorioRecDes')
    else begin
      FRel.Init('RelatorioRecDessin');
      if EdQContas.text='T' then
        titulocontas:=''
      else if EdQContas.text='S' then
        titulocontas:=' - Somente contas configuradas para impress�o'
      else
        titulocontas:=' - Somente contas configuradas para N�O imprimir';

    end;
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+titqdata);
    FRel.AddTit('Conta : '+TituloConta(EdPlan_conta.asinteger)+FGeral.TituloRelCliRepre(EdTipo_codigo.asinteger,'C')+titulocontas  );
    FRel.AddTit('Periodo : '+TituloPeriodo(EdDatai.Asdate,EdDataf.asdate)+' - Hist�rico : '+TituloHistorico(EdHist_codigo.asinteger)+' - Status '+EdStatus.text );
//    FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    if EdPlan_conta.asinteger=0 then begin
      FRel.AddCol( 40,0,'N','' ,''              ,'Conta'          ,''         ,'',false);
      FRel.AddCol(210,0,'C','' ,''              ,'Descri��o'      ,''         ,'',false);
    end;
    if EdSinana.text='A' then begin
//      FRel.AddCol( 80,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
      FRel.AddCol( 80,0,'C','' ,''              ,'Opera��o'       ,''         ,'',false);
      FRel.AddCol( 60,2,'D','' ,''              ,'Lan�amento'  ,''         ,'',false);
      FRel.AddCol( 60,2,'D','' ,''              ,'Movimento'  ,''         ,'',false);
      FRel.AddCol( 60,2,'D','' ,''              ,'Bom Para '       ,''         ,'',false);
      FRel.AddCol( 40,1,'C','' ,''              ,'Tipo'     ,''         ,'',False);
      FRel.AddCol( 60,2,'N','' ,''              ,'Nro.Doc.'     ,''         ,'',False);
//      FRel.AddCol( 60,0,'D','' ,''              ,'Confer�ncia'     ,''         ,'',False);
      FRel.AddCol( 60,2,'N','' ,''              ,'Cheque'       ,''         ,'',False);
      FRel.AddCol( 60,3,'N','' ,''              ,'Cod.His.'       ,''         ,'',False);
      FRel.AddCol(220,0,'C','' ,''              ,'Hist�rico'       ,''         ,'',False);
    end;
    FRel.AddCol( 80,3,'N','+',f_cr            ,'Entradas'        ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+',f_cr            ,'Saidas'          ,''         ,'',False);

    if (EdPlan_conta.asinteger>0) and (EdSinana.text='A') then begin
      FRel.AddCol( 80,3,'N','',f_cr            ,'Saldo'   ,''         ,'',False);
// 10.05.17
      if (EdPlan_conta.asinteger>0) and (txjuros>0) then begin
        FRel.AddCol( 80,3,'N','',f_cr            ,'Saldo Corrigido'   ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+',f_cr            ,'Valor Juros'   ,''         ,'',False);
      end;
// 23.11.05
      FRel.AddCol( 45,0,'C','' ,''              ,'Conta'                ,''         ,'',false);
      FRel.AddCol(200,0,'C','' ,''              ,'Descr. Caixa/banco'      ,''         ,'',false);
// 22.05.06
      FRel.AddCol( 45,0,'N','' ,''              ,'Repr.'          ,''         ,'',false);
      FRel.AddCol(200,0,'C','' ,''              ,'Nome'      ,''         ,'',false);
      saldo:=saldoanterior;
//      if (EdSinana.text='A') and (EdPlan_conta.asinteger<>FGeral.getconfig1asinteger('Contaacertos')) then begin
      if (EdSinana.text='A') and (Edtipo_codigo.asinteger=0) then begin
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');   // 23.03.10
        FRel.AddCel('');   // 26.10.11 - codigo do historico
//        FRel.AddCel('Saldo anterior');
        FRel.AddCel('');   // 28.09.05
        FRel.AddCel('Saldo anterior'); // aqui em 24.03.10
        if Q.FieldByName('movf_Es').AsString='E' then begin
          FRel.AddCel('');
          FRel.AddCel('');
        end else begin
          FRel.AddCel('');
          FRel.AddCel('');
        end;
        FRel.AddCel(Formatfloat(f_cr,saldo));
// 10.05.17
        if (EdPlan_conta.asinteger>0) and (txjuros>0) then begin
          FRel.AddCel('');
          FRel.AddCel('');
        end;

        FRel.AddCel('');
        FRel.AddCel('');
  // 22.05.06
        FRel.AddCel('');
        FRel.AddCel('');
      end;

//      FRel.AddCel(FGeral.Formatavalor(saldo,f_cr));
    end else if (EdPlan_conta.asinteger=0) and (EdSinana.text='A') then begin
// 27.06.06
      FRel.AddCol( 80,3,'N','',f_cr            ,'Liquido'   ,''         ,'',False);
      saldo:=0;
// 23.11.05
      FRel.AddCol( 45,0,'C','' ,''              ,'Conta'                ,''         ,'',false);
      FRel.AddCol(200,0,'C','' ,''              ,'Descr. Caixa/banco'      ,''         ,'',false);
// 22.05.06
      FRel.AddCol( 45,0,'N','' ,''              ,'Repr.'          ,''         ,'',false);
      FRel.AddCol(200,0,'C','' ,''              ,'Nome'      ,''         ,'',false);
    end;

    dataant:=EdDatai.AsDate-1;

    saldocor:=saldo;
    jurosacm:=0;
    while not Q.eof do begin
//      FRel.AddCel(Q.FieldByName('movf_unid_codigo').AsString);
      if EdPlan_conta.asinteger=0 then begin
        FRel.AddCel(Q.FieldByName('movf_plan_contard').AsString);
        FRel.AddCel(FPlano.GetDescricao(Q.FieldByName('movf_plan_contard').AsInteger));
      end;
      if EdSinana.text='A' then begin
//        FRel.AddCel(Q.FieldByName('movf_transacao').AsString);
        FRel.AddCel(Q.FieldByName('movf_operacao').AsString);
        FRel.AddCel(Q.FieldByName('movf_datamvto').AsString);
        FRel.AddCel(Q.FieldByName('movf_datacont').AsString);
        FRel.AddCel(Q.FieldByName('movf_dataprevista').AsString);
        FRel.AddCel(Q.FieldByName('movf_tipomov').AsString);
        FRel.AddCel(Q.FieldByName('movf_numerodcto').AsString);
//        FRel.AddCel(Q.FieldByName('movf_dataextrato').AsString);
        FRel.AddCel(Q.FieldByName('movf_numerocheque').AsString);
// 26.10.11
        FRel.AddCel(Q.FieldByName('movf_hist_codigo').AsString);
        FRel.AddCel(FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString);
      end;
      vlrjuros:=0;
      if (EdPlan_conta.asinteger>0) and (txjuros>0) and ( Q.FieldByName('movf_tipomov').AsString<>Global.CodJurosRecebidos  ) then begin
          diasatraso:=Trunc(Q.FieldByName('movf_datamvto').AsDateTime-DataAnt);
          vlrjuros:= ( saldo * ( (txjuros/30)/100 ) * diasatraso );
          jurosacm:=jurosacm+vlrjuros;
      end;
      if Q.FieldByName('movf_Es').AsString='E' then begin
        FRel.AddCel(Q.FieldByName('movf_valorger').AsString);
        FRel.AddCel('');
        saldo:=saldo+Q.FieldByName('movf_valorger').AsCurrency;
      end else begin
        FRel.AddCel('');
        FRel.AddCel(Q.FieldByName('movf_valorger').AsString);
        saldo:=saldo-Q.FieldByName('movf_valorger').AsCurrency;
      end;
      if (EdPlan_conta.asinteger>0) and (EdSinana.text='A') then begin
        FRel.AddCel(FGeral.Formatavalor(saldo,f_cr));
// 10.05.17
        if (EdPlan_conta.asinteger>0) and (txjuros>0) then begin
          saldocor:= saldo  + jurosacm;
          FRel.AddCel(FGeral.Formatavalor(saldocor,f_cr));
          FRel.AddCel(FGeral.Formatavalor(vlrjuros,f_cr));
          dataant:=Q.FieldByName('movf_datamvto').AsDateTime;
        end;
        FRel.AddCel(Q.FieldByName('movf_plan_conta').AsString);
        FRel.AddCel(FPlano.GetDescricao(Q.FieldByName('movf_plan_conta').AsInteger));
// 22.05.06
        FRel.AddCel(Q.FieldByName('movf_tipo_codigo').AsString);
        if Q.FieldByName('movf_tipo_codigo').Asinteger>0 then
          FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('movf_tipo_codigo').AsInteger,Q.FieldByName('movf_tipocad').AsString,'N') )
        else
          FRel.AddCel('');
      end else if (EdPlan_conta.asinteger=0) and (EdSinana.text='A') then begin
        FRel.AddCel(FGeral.Formatavalor(saldo,f_cr));
        FRel.AddCel(Q.FieldByName('movf_plan_conta').AsString);
        FRel.AddCel(FPlano.GetDescricao(Q.FieldByName('movf_plan_conta').AsInteger));
        FRel.AddCel(Q.FieldByName('movf_tipo_codigo').AsString);
        FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('movf_tipo_codigo').AsInteger,Q.FieldByName('movf_tipocad').AsString,'N') );
      end;
      Q.Next;

    end;
    if (EdSinana.text='A')
       and (Edtipo_codigo.asinteger>0) then begin
////////      FGeral.PulalinhaRel(FREl.GCol.ColCount);
/////////////////////////////////////////
      if EdPlan_conta.asinteger=0 then begin
        FRel.AddCel('');
        FRel.AddCel('');
      end;
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');   // 26.10.11 - codigo historico
      if EdPlan_conta.asinteger=0 then begin
         FRel.AddCel('Comiss�o Venda : ') ;
         comissao:=FGeral.GetVlrComissao(Edtipo_codigo.resultfind.fieldbyname('clie_repr_codigo').AsInteger,
                   'R',EdDAtai.asdate,EdDataf.asdate,Global.CodVendaMostruarioII) ;
         FRel.AddCel(formatfloat(f_cr,comissao ) ) ;
         saldo:=saldo+comissao;
      end else begin
        FRel.AddCel('');
        FRel.AddCel('');
      end;
      FRel.AddCel('');
      if (EdPlan_conta.asinteger>0) and (EdSinana.text='A') then begin
        FRel.AddCel(FGeral.Formatavalor(saldo,f_cr));
// 10.05.17
        if (EdPlan_conta.asinteger>0) and (txjuros>0) then begin
          FRel.AddCel('');
          FRel.AddCel('');
        end;
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
      end else if (EdPlan_conta.asinteger=0) and (EdSinana.text='A') then begin
        FRel.AddCel(FGeral.Formatavalor(saldo,f_cr));
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
      end;
/////////////////////////////////////////
      if EdPlan_conta.asinteger=0 then begin
        FRel.AddCel('');
        FRel.AddCel('');
      end;
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      if EdPlan_conta.asinteger=0 then begin
         FRel.AddCel('Comiss�o Mostru�rio : ') ;
         comissao:=FGeral.GetVlrComissao(Edtipo_codigo.resultfind.fieldbyname('clie_repr_codigo').AsInteger,
                   'R',EdDAtai.asdate,EdDataf.asdate,'',Global.CodVendaMostruarioII) ;
         FRel.AddCel(formatfloat(f_cr,comissao ) ) ;
         saldo:=saldo+comissao;
      end else begin
        FRel.AddCel('');
        FRel.AddCel('');
      end;
      FRel.AddCel('');
      if (EdPlan_conta.asinteger>0) and (EdSinana.text='A') then begin
        FRel.AddCel(FGeral.Formatavalor(saldo,f_cr));
// 10.05.17
        if (EdPlan_conta.asinteger>0) and (txjuros>0) then begin
          FRel.AddCel('');
          FRel.AddCel('');
        end;
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
      end else if (EdPlan_conta.asinteger=0) and (EdSinana.text='A') then begin
        FRel.AddCel(FGeral.Formatavalor(saldo,f_cr));
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
      end;



/////////////////////////////////////////
      FGeral.PulalinhaRel(FREl.GCol.ColCount);
      if EdPlan_conta.asinteger=0 then begin
        FRel.AddCel('');
        FRel.AddCel('');
      end;
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      FRel.AddCel('');
      if EdPlan_conta.asinteger=0 then begin
        QAdian:=sqltoquery('select sum(movf_valorger) as valor from movfin where movf_status=''G'''+
                         ' and movf_tipo_codigo='+Edtipo_codigo.Assql+
                         ' and movf_dataprevista>'+EdDataf.assql );
        comissao:=QAdian.fieldbyname('valor').ascurrency;
        FRel.AddCel('Saldo Adiantamentos : '+formatfloat(f_cr,comissao )) ;
      end else begin
        FRel.AddCel('' );
      end;
      FRel.AddCel('' );
      FRel.AddCel('');
      if (EdPlan_conta.asinteger>0) and (EdSinana.text='A') then begin
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
// 10.05.17
        if (EdPlan_conta.asinteger>0) and (txjuros>0) then begin
          FRel.AddCel('');
          FRel.AddCel('');
        end;
      end else if (EdPlan_conta.asinteger=0) and (EdSinana.text='A') then begin
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
      end;
      FGeral.Fechaquery(QAdian);
//////////////////////////////////////
    end;
    FRel.Video;
    Q.Close;
    Freeandnil(Q);
    Sistema.EndProcess('');
// 23.05.06
    FRelCxBancos_DespRece;         // 2

  end;


end;

procedure FRelCxBancos_FluxoCaixa;       // 3
//////////////////////////////////////////////

type TValores=record
   Dia:TDatetime;
   chequesrec,receber,chequespag,pagar,previsaopagar:currency;
   end;

var Q,QSaldo:TSqlquery;
    saldoanterior,saldo:currency;
    inicio,data:TDatetime;
    PValores:^TValores;
    ListaValores:Tlist;
    p,mesant,anoant:integer;
    mesanoanterior,mesano:string;

    function  ChecaBaixaParcial(unidade,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer):currency;
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var Qbx:TSqlquery;
        status,sqlqtipo:string;
        valor:currency;
    begin
      status:=stringtosql('P');
      if Datacont>1 then
//        sqlqtipo:=' and pend_datacont>1'
// 27.05.10
        sqlqtipo:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco)
      else
        sqlqtipo:=' and pend_datacont is null';
      QBx:=sqltoquery('select * from pendencias where pend_status='+status+' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
                      ' and pend_unid_codigo='+stringtosql(unidade)+
                      ' and ( pend_parcela='+inttostr(parcela)+' or pend_datavcto='+Datetosql(Vencimento)+')'+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
      valor:=0;
      while not QBx.eof do begin
        valor:=valor+QBx.fieldbyname('pend_valor').ascurrency;
        QBx.next;
      end;
      Qbx.close;
      Freeandnil(Qbx);
      result:=valor;
    end;



begin

  with FRelCxBancos do begin
    if not FRelCxBancos_Execute(3) then Exit;

//    if EdDAtai.Asdate<=1 then begin
//      sqlperiodo:='';
//      inicio:=Sistema.hoje;
//    end else begin
//        inicio:=DateToPrimeiroDiaMes(EdDatai.Asdate);
//        sqlperiodo:=' and movf_datamvto>='+DatetoSql(inicio)+' and movf_datamvto<='+EdDataf.AsSql;
//    end;
    saldoanterior:=0;

// deixar saldo 'por ultimo'... - 13.08.04
// deixado cheques a pagar para depois para ver se pega do mesmo arquivo cheq_... ou de caixa/bancos
// conforme o hist�rico...
    data:=EdDatai.asdate;
    ListaValores:=Tlist.create;
    while data<=EdDAtaf.asdate do begin
      New(PValores);
      PValores.Dia:=data;
      PValores.chequesrec:=0;
      PValores.receber:=0;
      PValores.chequespag:=0;
      PValores.pagar:=0;
      PValores.previsaopagar:=0;
      Listavalores.add(PValores);
      data:=data+1;
    end;
    if Listavalores.count=0 then exit;
    mesano:=strzero(datetomes(EdDatai.asdate),2)+strzero(datetoano(EdDatai.asdate,true),4);
    mesant := strtoint(copy(mesano,1,2)) ;
     anoant := strtoint(copy(mesano,3,4)) ;
    if mesant = 01 then begin
      mesant:=12;dec(anoant);
    end else
      dec(mesant);
    mesanoanterior:=strzero(mesant,2)+inttostr(anoant);
{
///////////////////////////
    Sistema.Setmessage('Calculando saldo inicial');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('samf_unid_codigo',EdUnid_codigo.text,'C',)
    else
      sqlunidade:=' and '+FGeral.getin('samf_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
    Q:=sqltoquery('select * from salmovfin'+
                  ' where '+FGeral.Getin('samf_status','N','C')+
                  ' and samf_mesano='+stringtosql(FGeral.Anomesinvertido(mesanoanterior))+
                  sqlunidade+
                  ' order by samf_plan_conta' );
    while not Q.eof do begin
      if Global.Usuario.OutrosAcessos[0701] then
        saldoanterior:=saldoanterior+Q.fieldbyname('samf_saldomov').ascurrency
      else
        saldoanterior:=saldoanterior+Q.fieldbyname('samf_saldocont').ascurrency;
      Q.next;
    end;
    Q.Close;
    Sistema.Setmessage('Descontando cheques pr�datados');
    if Global.Usuario.OutrosAcessos[0701] then
      sqlacesso:=''
    else
      sqlacesso:=' and cheq_datacont is not null';
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('cheq_unid_codigo',EdUnid_codigo.text,'C',)
    else
      sqlunidade:=' and '+FGeral.getin('cheq_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
    Q:=sqltoquery('select * from cheques'+
                  ' where '+FGeral.Getin('cheq_status','N','C')+
                  ' and cheq_emirec=''R'''+
                  sqlunidade+
                  ' and cheq_predata>cheq_emissao'+
                  ' and cheq_predata<'+Datetosql(EdDatai.asdate)+
                  sqlacesso+
                  ' order by cheq_predata' );
    while not Q.eof do begin
      if Global.Usuario.OutrosAcessos[0701] then
        saldoanterior:=saldoanterior-Q.fieldbyname('cheq_valor').ascurrency
      else
        saldoanterior:=saldoanterior-Q.fieldbyname('cheq_valor').ascurrency;
      Q.Next;
    end;
    Q.Close;
//////////////////////////////////////////////
}
    saldoanterior:=EdSaldoanterior.ascurrency;
    Sistema.Setmessage('Calculando valores dia a dia dos cheques recebidos');
    data:=EdDatai.asdate;
    if Global.Usuario.OutrosAcessos[0701] then
      sqlacesso:=''
    else
      sqlacesso:=' and cheq_datacont is not null';
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('cheq_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:=' and '+FGeral.getin('cheq_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
    for p:=0 to LIstaValores.count-1  do begin
      PValores:=Listavalores[p];
      Q:=sqltoquery('select * from cheques'+
                  ' where '+FGeral.Getin('cheq_status','N','C')+
                  ' and cheq_emirec=''R'''+
                  sqlunidade+
                  ' and cheq_predata='+Datetosql(Pvalores.Dia)+sqlacesso+
// 10.08.05
                  ' and cheq_deposito is null'+
                  ' and cheq_predata='+Datetosql(Pvalores.Dia)+sqlacesso+
                  ' order by cheq_predata' );

      while not Q.Eof do begin
        PValores.chequesrec:=PValores.chequesrec+Q.fieldbyname('cheq_valor').ascurrency;
        Q.Next;
      end;
    end;
    Q.close;

    Sistema.Setmessage('Calculando valores dia a dia dos contas a receber');
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
    data:=EdDatai.asdate;
    if Global.Usuario.OutrosAcessos[0701] then
      sqlacesso:=''
    else
      sqlacesso:=' and pend_datacont is not null';
    for p:=0 to LIstaValores.count-1  do begin
      PValores:=Listavalores[p];
      Q:=sqltoquery('select * from pendencias'+
// 16.08.05 -retirado as antecipacoes por enquanto
//                  ' where '+FGeral.Getin('pend_status','N;P;A','C')+
                  ' where '+FGeral.Getin('pend_status','N','C')+
                  ' and pend_rp=''R'''+
                  sqlunidade+
                  ' and  pend_datavcto='+Datetosql(Pvalores.Dia)+sqlacesso+
                  ' order by pend_datavcto' );

      while not Q.Eof do begin
        if Q.fieldbyname('pend_status').asstring='A' then  // 31.05.05 - deduz antecipacoes
          PValores.receber:=PValores.receber-Q.fieldbyname('pend_valor').ascurrency
        else
          PValores.receber:=PValores.receber+Q.fieldbyname('pend_valor').ascurrency;
        PValores.receber:=PValores.receber-ChecaBaixaParcial(Q.fieldbyname('pend_unid_codigo').asstring,Q.fieldbyname('pend_tipo_codigo').asstring,
                          Q.fieldbyname('pend_tipocad').asstring,Q.fieldbyname('pend_numerodcto').asstring,
                          Q.fieldbyname('pend_datamvto').asdatetime,Q.fieldbyname('pend_datacont').asdatetime,
                          Q.fieldbyname('pend_datavcto').asdatetime,Q.fieldbyname('pend_parcela').asinteger );
        Q.Next;
      end;
    end;
    Q.close;

    Sistema.Setmessage('Calculando valores dia a dia dos contas a pagar');
    data:=EdDatai.asdate;
    if Global.Usuario.OutrosAcessos[0701] then
      sqlacesso:=''
    else
      sqlacesso:=' and pend_datacont is not null';
    for p:=0 to LIstaValores.count-1  do begin
      PValores:=Listavalores[p];
      Q:=sqltoquery('select * from pendencias'+
//                  ' where '+FGeral.Getin('pend_status','N;P;A','C')+
// 16.08.05 -retirado as antecipacoes por enquanto
// 16.06.06 - colocado status H - previsao baseada em pedido de compra digitado
                  ' where '+FGeral.Getin('pend_status','N;H','C')+
                  ' and pend_rp=''P'''+
                  sqlunidade+
                  ' and  pend_datavcto='+Datetosql(Pvalores.Dia)+sqlacesso+
                  ' order by pend_datavcto' );

      while not Q.Eof do begin
        if pos(Q.fieldbyname('pend_status').asstring,'A;P')>0 then  // 31.05.05 - deduz antecipacoes - 30.11.05 - baixas parciais
          PValores.pagar:=PValores.Pagar-Q.fieldbyname('pend_valor').ascurrency
        else begin
          PValores.pagar:=PValores.Pagar+Q.fieldbyname('pend_valor').ascurrency;
          if Q.fieldbyname('pend_status').asstring='H' then
            PValores.previsaopagar:=PValores.PrevisaoPagar+Q.fieldbyname('pend_valor').ascurrency;
        end;
        PValores.pagar:=PValores.pagar-ChecaBaixaParcial(Q.fieldbyname('pend_unid_codigo').asstring,Q.fieldbyname('pend_tipo_codigo').asstring,
                          Q.fieldbyname('pend_tipocad').asstring,Q.fieldbyname('pend_numerodcto').asstring,
                          Q.fieldbyname('pend_datamvto').asdatetime,Q.fieldbyname('pend_datacont').asdatetime,
                          Q.fieldbyname('pend_datavcto').asdatetime,Q.fieldbyname('pend_parcela').asinteger );
        Q.Next;
      end;
    end;
    Q.close;

    Sistema.BeginProcess('Imprimindo Relat�rio');
    Sistema.Setmessage('Gerando relat�rio');
    FRel.Init('RelatorioFluxoCaixa');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
    FRel.AddTit('Fluxo de Caixa Periodo : '+TituloPeriodo(EdDatai.Asdate,EdDataf.asdate));
//    FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    FRel.AddCol( 70,0,'D','' ,''              ,'Data'              ,''         ,'',false);
    FRel.AddCol(100,3,'N','+' ,f_cr            ,'Cheques Recebidos' ,''         ,'',false);
    FRel.AddCol(100,3,'N','+' ,f_cr            ,'Contas a Receber'  ,''         ,'',false);
    FRel.AddCol(100,3,'N','+' ,f_cr            ,'Total a Receber'   ,''         ,'',False);
    FRel.AddCol(100,3,'N','+' ,f_cr            ,'Cheques Emitidos'  ,''         ,'',false);
    FRel.AddCol(100,3,'N','+' ,f_cr            ,'Contas a Pagar'    ,''         ,'',false);
    FRel.AddCol(020,1,'C',''  ,''              ,'P'                 ,''         ,'',false);
    FRel.AddCol(100,3,'N','+' ,f_cr            ,'Total a Pagar'     ,''         ,'',False);
    FRel.AddCol( 90,3,'N',''  ,f_cr            ,'Saldo di�rio'      ,''         ,'',False);
    FRel.AddCol( 90,3,'N',''  ,f_cr            ,'Saldo'             ,''         ,'',False);
    FRel.AddCel('');
    FRel.AddCel('');
    FRel.AddCel('');
    FRel.AddCel('');
    FRel.AddCel('');
    FRel.AddCel('');
    FRel.AddCel('');
    FRel.AddCel('');
    FRel.AddCel('');
    FRel.AddCel(floattostr(saldoanterior));
    saldo:=saldo+saldoanterior;
    for p:=0 to LIstaValores.count-1 do begin
      PValores:=Listavalores[p];
      FRel.AddCel(FGeral.FormataData(Pvalores.dia));
      FRel.AddCel(floattostr(PVAlores.chequesrec));
      FRel.AddCel(floattostr(PVAlores.receber));
      FRel.AddCel(floattostr(PVAlores.chequesrec+PVAlores.receber));
      FRel.AddCel(floattostr(PVAlores.chequespag));
      saldo:=saldo+PVAlores.chequesrec+PVAlores.receber;
      FRel.AddCel(floattostr(PVAlores.pagar));
      if PValores.previsaopagar>0 then
        FRel.AddCel('*')
      else
        FRel.AddCel('');
      FRel.AddCel(floattostr(PVAlores.chequespag+PVAlores.pagar));
      FRel.AddCel(floattostr(PVAlores.chequesrec+PVAlores.receber-(PVAlores.chequespag+PVAlores.pagar)));
      saldo:=saldo-(PVAlores.chequespag+PVAlores.pagar);
      FRel.AddCel(floattostr(saldo));
    end;
    FRel.Video;
    Freeandnil(Q);
    Sistema.EndProcess('');
  end;

  FRelCxBancos_FluxoCaixa;       // 3

end;


procedure TFRelcxbancos.baplicarClick(Sender: TObject);
begin
  if not EdDatai.ValidEdiAll(FRelCxBancos,99) then exit;
  Saiok:=true;
  close;

end;

procedure TFRelcxbancos.FormActivate(Sender: TObject);
////////////////////////////////////////////////////////////
begin

  FGeral.ConfiguraColorEditsNaoEnabled(FRelCxBancos);
  FRelCxBancos.Eddatai.setfocus;

end;

procedure TFRelcxbancos.EddatafValidate(Sender: TObject);
begin
    if (Eddataf.asdate<Eddatai.asdate) and  (not EdDataf.isempty) and (not EdDatai.isempty) then
      EdDataf.invalid('Data final tem que ser maior que a inicial');
end;

procedure TFRelcxbancos.EdTiporelExitEdit(Sender: TObject);
begin
 baplicarclick(FRelcxbancos);
end;

procedure TFRelcxbancos.Edunid_codigoValidate(Sender: TObject);
begin
  if FRelcxbancos.EdUnid_codigo.isempty then
    FRelcxbancos.EdUnid_codigo.Text:=Global.Usuario.UnidadesRelatorios;

end;

procedure TFRelcxbancos.EdPlan_contaValidate(Sender: TObject);
begin
//   if (EdPlan_conta.asinteger>0) and (EdPlan_Conta.asinteger=FGeral.getconfig1asinteger('Contaacertos')) then
// 26.11.09
 if (EdPlan_conta.asinteger>0) then begin
    EdQcontas.enabled:=false;
    EdQContas.text:='T';
 end else
    EdQcontas.enabled:=(rel=2);

end;



procedure FRelCxBancos_ResumoComissoes;  // 4   // 29.05.06

type TRegistro=record
    codigo,clie_repr:integer;
    unidade:string;
    adianta,plano:currency;
end;

var Q,QAdian:TSqlquery;
    comissao:currency;
    inicio:TDatetime;
    Lista:Tlist;
    PRegistro:^TRegistro;
    x:integer;

    procedure Atualiza(codigo:integer;unidade:string;valor:currency ; historico:string);
    var p:integer;
        achou:boolean;
    begin
      achou:=false;
      for p:=0 to Lista.count-1 do begin
        PRegistro:=LIsta[p];
        if (Pregistro.codigo=codigo) and (PRegistro.unidade=unidade) then begin
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
        New(PRegistro);
        PRegistro.unidade:=unidade;
        PRegistro.codigo:=codigo;
        PRegistro.adianta:=0;
        PRegistro.plano:=0;
        PRegistro.clie_repr:=Q.fieldbyname('clie_repr_codigo').asinteger;
        if ansipos('SAUDE',uppercase(historico))>0 then
          PRegistro.plano:=valor
        else
          PRegistro.adianta:=valor;
        Lista.Add(Pregistro);
      end else begin
        if ansipos('SAUDE',uppercase(historico))>0 then
          PRegistro.plano:=PRegistro.plano+valor
        else
          PRegistro.adianta:=PRegistro.adianta+valor;
      end;
    end;

begin

  with FRelCxBancos do begin
    if not FRelCxBancos_Execute(4) then Exit;
    sqlunidade:=' and '+FGeral.getin('movf_unid_codigo',EdUnid_codigo.text,'C');
    if EdDAtai.Asdate<=1 then begin
      sqlperiodo:='';
      inicio:=Sistema.hoje;
    end else begin
      if EdPlan_conta.asinteger>0 then begin
        inicio:=DateToPrimeiroDiaMes(EdDatai.Asdate);
//        sqlperiodo:=' and movf_datamvto>='+DatetoSql(inicio)+' and movf_datamvto<='+EdDataf.AsSql;
// 25.05.06
        sqlperiodo:=' and movf_dataprevista>='+DatetoSql(inicio)+' and movf_dataprevista<='+EdDataf.AsSql;
      end else begin
//        sqlperiodo:=' and movf_datamvto>='+EdDatai.AsSql+' and movf_datamvto<='+EdDataf.AsSql;
// 25.05.06
        sqlperiodo:=' and movf_dataprevista>='+EdDatai.AsSql+' and movf_dataprevista<='+EdDataf.AsSql;
        inicio:=EdDatai.Asdate;
      end;
    end;
    if EdHist_codigo.AsInteger=0 then
      sqlhistorico:=''
    else
      sqlhistorico:=' and movf_hist_codigo='+EdHIst_codigo.AsSql;

    if Global.Usuario.OutrosAcessos[0701] then
      sqlacesso:=''
    else
      sqlacesso:=' and movf_datacont is not null';
    sqlcodtipo:='';
    sqltipomov:='';
    sqltipomov:=' and '+FGeral.Getnotin('movf_tipomov',Global.CodComissaoRepr,'C');
    if not Edtipo_codigo.isempty then begin
      sqlcodtipo:=' and movf_tipo_codigo='+Edtipo_codigo.assql;
//      sqltipomov:=' and '+FGeral.Getnotin('movf_tipomov',Global.CodComissaoRepr,'C');
// 28.06.06
//      sqltipomov:='';
    end;
    sqlstatus:='N';
    if EdStatus.text='N' then
      sqlstatus:='N;G'  // para que quando imprima normalmente o relat. 'apare�a automatico' os lancamos 'G' cfe bom para
// 28.06.06
//      sqlstatus:='N'  // para que quando imprima normalmente o relat. 'apare�a automatico' os lancamos 'G' cfe bom para
    else if not EdStatus.isempty then
      sqlstatus:=EdStatus.text;
    Lista:=TList.create;
    Sistema.Beginprocess('Gerando relat�rio');
// 28.06.06
    sqlconta:=' and movf_plan_contard>0 and '+FGeral.Getnotin('movf_plan_contard','317;316','N');

//    Q:=sqltoquery('select * from movfin left join plano on (plan_conta=movf_plan_conta)'+
    Q:=sqltoquery('select movfin.*,historicos.*,clie_repr_codigo from movfin'+
                  ' left join historicos on (hist_codigo=movf_hist_codigo)'+
                  ' left join clientes on (movf_tipo_codigo=clie_codigo)'+
                  ' where '+FGeral.Getin('movf_status',sqlstatus,'C')+
                  ' and movf_tipo_codigo>0 and movf_tipocad=''C'''+
                  sqlunidade+
                  sqlcodtipo+sqlconta+
                  sqlperiodo+sqlhistorico+sqlacesso+sqltipomov+
                  ' order by movf_plan_contard,movf_datamvto' );
    if Q.Eof then begin
      Sistema.EndProcess('Nada encontrado para impress�o');
      Q.close;
      exit;
    end;
    while not Q.eof do  begin
      Atualiza(Q.FieldByName('movf_tipo_codigo').AsInteger,Q.FieldByName('movf_unid_codigo').AsString,
               Q.FieldByName('movf_valorger').AsCurrency,Q.FieldByName('movf_complemento').AsString);
      Q.next;
    end;
    Sistema.BeginProcess('Imprimindo Relat�rio');
    FRel.Init('RelResumoComissoes');
    FRel.AddTit('Resumo de Comiss�es');
    FRel.AddTit('Unidade : '+EdUNid_codigo.text+FGeral.TituloRelCliRepre(EdTipo_codigo.asinteger,'C')  );
    FRel.AddTit('Periodo  : '+TituloPeriodo(EdDatai.Asdate,EdDataf.asdate) );
    FRel.AddCol( 45,0,'C','' ,''              ,'Unidade.'          ,''         ,'',false);
    FRel.AddCol( 45,0,'N','' ,''              ,'Repr.'          ,''         ,'',false);
    FRel.AddCol(180,0,'C','' ,''              ,'Nome'      ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+',f_cr            ,'Comiss�o'             ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+',f_cr            ,'Adiantamentos'        ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+',f_cr            ,'Plano Sa�de'          ,''         ,'',False);
    FRel.AddCol( 90,3,'N','+',f_cr            ,'Comiss�o l�quida'          ,''         ,'',False);
    FRel.AddCol(100,3,'N','+',f_cr            ,'Saldo Adiantamentos'          ,''         ,'',False);

    for x:=0 to LIsta.count-1 do begin
      PRegistro:=Lista[x];
      FRel.AddCel(Pregistro.unidade);
      FRel.AddCel(inttostr(PRegistro.codigo));
      FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(PRegistro.codigo,'C','N') );
      if PRegistro.unidade=global.unidadematriz then begin
        comissao:=FGeral.GetVlrComissao(PRegistro.clie_repr,'R',EdDAtai.asdate,EdDataf.asdate,Global.CodVendaMostruarioII) ;
        comissao:=comissao+FGeral.GetVlrComissao(PRegistro.clie_repr,'R',EdDAtai.asdate,EdDataf.asdate,'',Global.CodVendaMostruarioII) ;
      end else
        comissao:=0;
      FRel.AddCel(floattostr(comissao));
      FRel.AddCel(floattostr(PREgistro.adianta));
      FRel.AddCel(floattostr(PREgistro.plano));
      FRel.AddCel(floattostr(comissao-PREgistro.adianta-PREgistro.plano));
      QAdian:=sqltoquery('select sum(movf_valorger) as valor from movfin where movf_status=''G'''+
                         ' and movf_tipo_codigo='+inttostr(PRegistro.codigo)+
                         ' and movf_dataprevista>'+EdDataf.assql );
      comissao:=QAdian.fieldbyname('valor').ascurrency;
      if PRegistro.unidade=global.unidadematriz then
         FRel.AddCel(floattostr(comissao))
      else
         FRel.AddCel('');
      FGeral.Fechaquery(QAdian);
    end;

    FRel.Setsort('Nome');
    FRel.Video;
    Q.Close;
    Freeandnil(Q);
    Sistema.EndProcess('');
// 23.05.06
    FRelCxBancos_ResumoComissoes;  // 4   // 29.05.06

  end;


end;


procedure FRelCxBancos_ExtratoSintetico; // 5   // 02.07.07
////////////////////////////////////////////////////////////////////
type TContas=record
   conta:integer;
   saldo,saldoant,ent,sai:currency
end;

var Q,QContas:TSqlquery;
    inicio:TDatetime;
    saldoanterior,entradas,saidas,entant,saiant,saldo:currency;
    sqlorder,sqlconta2:string;
    PContas:^TContas;
    Lista:TList;
    p:integer;

    procedure Atualiza(anterior:string;conta:integer);
    ///////////////////////////////////////////////////////
    var i:integer;
        achou:boolean;
    begin
      achou:=false;
      for i:=0 to LIsta.count-1 do begin
        PContas:=LIsta[i];
        if PContas.conta=conta then begin
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
        New(PContas);
        PContas.conta:=conta;
        PContas.ent:=0;
        PContas.sai:=0;
        PContas.saldo:=0;
        PContas.saldoant:=0;
        if (FRelcxbancos.Edtiporel.text='2') then
          PContas.saldoant:=FGeral.SaldoAnterior(PContas.conta,FRelcxbancos.EdUnid_codigo.text,'samf_saldomov',inicio)-
                         FGeral.SaldoAnterior(PContas.conta,FRelcxbancos.EdUnid_codigo.text,'samf_saldocont',inicio)
        else if (FRelcxbancos.Edtiporel.text='9') then
          PContas.saldoant:=FGeral.SaldoAnterior(PContas.conta,FRelcxbancos.EdUnid_codigo.text,'samf_saldomov',inicio)
        else
          PContas.saldoant:=FGeral.SaldoAnterior(PContas.conta,FRelcxbancos.EdUnid_codigo.text,'samf_saldocont',inicio);
        if anterior='N' then begin
          if Q.FieldByName('movf_Es').AsString='E' then begin
            PContas.saldo:=PContas.saldo+Q.fieldbyname('movf_valorger').ascurrency;
          end else begin
            PContas.saldo:=PContas.saldo-Q.fieldbyname('movf_valorger').ascurrency;
          end;
        end;
        Lista.Add(PContas);
      end else begin
        if anterior='S' then begin
          if Q.FieldByName('movf_Es').AsString='E' then begin
            PContas.saldoant:=PContas.saldoant+Q.fieldbyname('movf_valorger').ascurrency;
          end else begin
            PContas.saldoant:=PContas.saldoant-Q.fieldbyname('movf_valorger').ascurrency;
          end;
        end else begin
          if Q.FieldByName('movf_Es').AsString='E' then begin
            PContas.saldo:=PContas.saldo+Q.fieldbyname('movf_valorger').ascurrency;
          end else begin
            PContas.saldo:=PContas.saldo-Q.fieldbyname('movf_valorger').ascurrency;
          end;
        end;
      end;

    end;

begin
////////////////////////////////////////////////////

  with FRelCxBancos do begin
    if not FRelCxBancos_Execute(5) then Exit;
    sqlunidade:=' and '+FGeral.getin('movf_unid_codigo',EdUnid_codigo.text,'C');
    if EdDAtai.Asdate<=1 then begin
      sqlperiodo:='';
      inicio:=Sistema.hoje;
    end else begin
      inicio:=DateToPrimeiroDiaMes(EdDatai.Asdate);
      sqlperiodo:=' and movf_datamvto>='+DatetoSql(inicio)+' and movf_datamvto<='+EdDataf.AsSql;
    end;

    if EdPlan_conta.AsInteger=0 then begin
      sqlconta:='';
    end else begin
      sqlconta:=' and movf_plan_conta='+EdPlan_conta.AsSql;
    end;
    if EdPlan_conta.AsInteger=0 then begin
      sqlconta2:='';
    end else begin
      sqlconta2:=' and plan_conta='+EdPlan_conta.AsSql;
    end;
    if EdHist_codigo.AsInteger=0 then
      sqlhistorico:=''
    else
      sqlhistorico:=' and movf_hist_codigo='+EdHIst_codigo.AsSql;

    if (Edtiporel.text='9') then
      sqlacesso:=''
    else if (Edtiporel.text='2') then
      sqlacesso:=' and movf_datacont is null'
    else
      sqlacesso:=' and movf_datacont is not null';
//    sqlorder:=' order by movf_plan_conta,movf_datamvto,movf_transacao';
// 17.07.07
    sqlorder:=' order by movf_datamvto,movf_transacao';

    QContas:=sqltoquery('select * from plano where '+FGeral.GetIN('plan_tipo','C;B','C')+sqlconta2+
            ' and plan_movfluxo<>''N'''+
            ' order by plan_conta');
    if QContas.Eof then begin
      Sistema.EndProcess('Sem contas cadastradas');
      FGeral.FechaQuery(QContas);
      exit;
    end;
    Lista:=TList.create;
    while not QContas.eof do begin
      Atualiza('S',QContas.fieldbyname('plan_conta').asinteger);
      QContas.Next;
    end;
    Sistema.BeginProcess('Pesquisando movimento');
    Q:=sqltoquery('select * from movfin'+
                  ' inner join plano on ( plan_conta=movf_plan_conta )'+
                  ' left join historicos on (hist_codigo=movf_hist_codigo)'+
                  ' where '+FGeral.Getin('movf_status','N','C')+
                  sqlunidade+
                  ' and plan_movfluxo<>''N'''+
                  ' and '+FGeral.GetIn('plan_tipo','C;B','C')+
                  sqlperiodo+sqlconta+sqlhistorico+sqlacesso+
                  sqlorder );

    if Q.Eof then begin
      FGeral.FechaQuery(Q);
      Sistema.EndProcess('Nada encontrado para impress�o');
      exit;
    end;

    Sistema.Setmessage('Calculando saldos');

      entant:= 0; saiant:=0;
      while (not Q.Eof) and (Q.fieldbyname('movf_datamvto').asdatetime<EdDatai.Asdate) do begin
        if pos( Q.FieldByName('movf_unid_codigo').AsString,EdUnid_codigo.text ) >0 then begin  // 09.09.05
          if Q.FieldByName('movf_Es').AsString='E' then begin
            entant:=entant+Q.fieldbyname('movf_valorger').ascurrency;
          end else begin
            saiant:=saiant+Q.fieldbyname('movf_valorger').ascurrency;
          end;
          Atualiza('S',Q.fieldbyname('movf_plan_conta').asinteger);
        end;
        Q.Next;
      end;

      while (not Q.Eof) and (Q.fieldbyname('movf_datamvto').asdatetime>=EdDatai.Asdate) do begin
        if pos( Q.FieldByName('movf_unid_codigo').AsString,EdUnid_codigo.text ) >0 then begin  // 09.09.05
          if Q.FieldByName('movf_Es').AsString='E' then begin
            entant:=entant+Q.fieldbyname('movf_valorger').ascurrency;
          end else begin
            saiant:=saiant+Q.fieldbyname('movf_valorger').ascurrency;
          end;
          Atualiza('N',Q.fieldbyname('movf_plan_conta').asinteger);
        end;
        Q.Next;
      end;

    Sistema.BeginProcess('Imprimindo Relat�rio');
    FRel.Init('ExtratoCxBancosSintetico');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
    FRel.AddTit('Extrato Sint�tico do Caixa/bancos');
    FRel.AddTit('Periodo : '+TituloPeriodo(EdDatai.Asdate,EdDataf.asdate)+' - Hist�rico : '+TituloHistorico(EdHist_codigo.asinteger));
//    FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    FRel.AddCol( 50,0,'C','' ,''              ,'Conta'          ,''         ,'',false);
    FRel.AddCol(150,0,'C','' ,''              ,'Descri��o'      ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+',f_cr             ,'Saldo'   ,''         ,'',False);
//    FRel.AddCol( 80,3,'N','+',f_cr             ,'Saldo anterior'   ,''         ,'',False);
//    FRel.AddCol( 80,3,'N','+',f_cr             ,'Saldo periodo'   ,''         ,'',False);
    for p:=0 to LIsta.count-1 do begin
      PContas:=Lista[p];
      FRel.AddCel(inttostr(PContas.conta));
      FRel.AddCel(FPlano.GetDescricao(PContas.conta));
      FRel.AddCel(FGeral.Formatavalor(PContas.saldo+PContas.saldoant,f_cr));
//      FRel.AddCel(FGeral.Formatavalor(PContas.saldoant,f_cr));
//      FRel.AddCel(FGeral.Formatavalor(PContas.saldo,f_cr));
    end;

  end;
  FGeral.FechaQuery(Q);
  Sistema.endProcess('');
  FRel.Video;

end;

// 10.08.15
procedure FRelCxBancos_RecebimentoDiario; // 6
//////////////////////////////////////////////////////////////////////////
type TContas=record
     portador:string;
     vendasavista,recebidodia,juros,prazo:currency
end;
var Q,QContas:TSqlquery;
    inicio:TDatetime;
    entradas,saidas,entant,saiant,saldo:currency;
    sqlorder,sqlconta2,sqlusuario:string;
    PContas:^TContas;
    Lista:TList;
    p:integer;

    procedure Atualiza(xtransacao:string;conta:string);
    ///////////////////////////////////////////////////////
    var i:integer;
        achou:boolean;
        QP:TSqlquery;
        busca:string;
    begin
      achou:=false;
      Qp:=sqltoquery('select pend_valor,pend_port_codigo,port_descricao,pend_fpgt_codigo from pendencias inner join portadores on ( port_codigo=pend_port_codigo )'+
                     ' where pend_transbaixa='+Stringtosql(xtransacao));
      if Qp.eof then begin
        FGeral.Fechaquery(QP);
        Qp:=sqltoquery('select pend_valor,pend_port_codigo,port_descricao,pend_fpgt_codigo from pendencias inner join portadores on ( port_codigo=pend_port_codigo )'+
                        ' where pend_transacao='+Stringtosql(xtransacao)+' and pend_status=''P''');
      end;
      busca:=(QP.fieldbyname('pend_port_codigo').asstring);
      if trim(busca)='' then Busca:=Q.fieldbyname('movf_tipomov').asstring;
        for i:=0 to LIsta.count-1 do begin
          PContas:=LIsta[i];
          if PContas.portador=busca then begin
            achou:=true;
            break;
          end;
        end;
        if not achou then begin
          New(PContas);
          PContas.portador:=busca;
          PContas.vendasavista:=0;
          PContas.recebidodia:=0;
          PContas.juros:=0;
          PContas.prazo:=0;
          if Q.FieldByName('movf_Es').AsString='E' then begin
              if Q.fieldbyname('movf_tipomov').asstring='JR' then
                PContas.juros:=PContas.juros+Q.fieldbyname('movf_valorger').ascurrency
              else if QP.fieldbyname('pend_fpgt_codigo').asstring=FGeral.GetConfig1AsString('Fpgtoavista') then
                PContas.vendasavista:=PContas.vendasavista+Q.fieldbyname('movf_valorger').ascurrency
              else if pos(busca,Global.TiposGeraFinanceiro)>0 then
                PContas.vendasavista:=PContas.vendasavista+Q.fieldbyname('movf_valorger').ascurrency
              else
               PContas.recebidodia:=PContas.recebidodia+Q.fieldbyname('movf_valorger').ascurrency;
  //             PContas.prazo:=PContas.prazo+Q.fieldbyname('movf_valorger').ascurrency;
          end;
          Lista.Add(PContas);
        end else begin
          if Q.FieldByName('movf_Es').AsString='E' then begin
              if Q.fieldbyname('movf_tipomov').asstring='JR' then
                PContas.juros:=PContas.juros+Q.fieldbyname('movf_valorger').ascurrency
              else if  QP.fieldbyname('pend_fpgt_codigo').asstring=FGeral.GetConfig1AsString('Fpgtoavista') then
                PContas.vendasavista:=PContas.vendasavista+Q.fieldbyname('movf_valorger').ascurrency
              else if pos(busca,Global.TiposGeraFinanceiro)>0 then
                PContas.vendasavista:=PContas.vendasavista+Q.fieldbyname('movf_valorger').ascurrency
              else
               PContas.recebidodia:=PContas.recebidodia+Q.fieldbyname('movf_valorger').ascurrency;
  //             PContas.prazo:=PContas.prazo+Q.fieldbyname('movf_valorger').ascurrency;
          end;
        end;
    end;

    procedure AtualizaCh(xtipo:string);
    ///////////////////////////////////////////////////////
    var i:integer;
        achou:boolean;
        QP:TSqlquery;
        busca:string;
    begin
      achou:=false;
      busca:=xtipo;
        for i:=0 to LIsta.count-1 do begin
          PContas:=LIsta[i];
          if PContas.portador=busca then begin
            achou:=true;
            break;
          end;
        end;
        if not achou then begin
          New(PContas);
          PContas.portador:=busca;
          PContas.vendasavista:=0;
          PContas.recebidodia:=0;
          PContas.juros:=0;
          PContas.prazo:=0;
          if Q.fieldbyname('cheq_predata').asdatetime=Q.fieldbyname('cheq_deposito').asdatetime then
                PContas.vendasavista:=PContas.vendasavista+Q.fieldbyname('cheq_valor').ascurrency
          else if pos(busca,Global.TiposGeraFinanceiro)>0 then
                PContas.prazo:=PContas.prazo+Q.fieldbyname('cheq_valor').ascurrency;
          Lista.Add(PContas);
        end else begin
          if Q.fieldbyname('cheq_predata').asdatetime=Q.fieldbyname('cheq_deposito').asdatetime then
                PContas.vendasavista:=PContas.vendasavista+Q.fieldbyname('cheq_valor').ascurrency
          else if pos(busca,Global.TiposGeraFinanceiro)>0 then
                PContas.prazo:=PContas.prazo+Q.fieldbyname('cheq_valor').ascurrency;
       end;
    end;


begin

  with FRelCxBancos do begin
    if not FRelCxBancos_Execute(6) then Exit;
    sqlunidade:=' and '+FGeral.getin('movf_unid_codigo',EdUnid_codigo.text,'C');
    if EdDAtai.Asdate<=1 then begin
      sqlperiodo:='';
      inicio:=Sistema.hoje;
    end else begin
      inicio:=(EdDatai.Asdate);
      sqlperiodo:=' and movf_datamvto>='+DatetoSql(inicio)+' and movf_datamvto<='+EdDataf.AsSql;
    end;
    sqlusuario:=' and movf_usua_codigo='+inttostr(Global.usuario.codigo);
//    if EdPlan_conta.AsInteger=0 then begin
      sqlconta:='';
//    end else begin
//      sqlconta:=' and movf_plan_conta='+EdPlan_conta.AsSql;
//   end;
    sqlconta2:='';
    if EdHist_codigo.AsInteger=0 then
      sqlhistorico:=''
    else
      sqlhistorico:=' and movf_hist_codigo='+EdHIst_codigo.AsSql;

//    if (Edtiporel.text='9') then
      sqlacesso:='';
//    else if (Edtiporel.text='2') then
//      sqlacesso:=' and movf_datacont is null'
//    else
//      sqlacesso:=' and movf_datacont is not null';
    sqlorder:=' order by movf_datamvto,movf_transacao';

    QContas:=sqltoquery('select * from plano where '+FGeral.GetIN('plan_tipo','C;B','C')+sqlconta2+
            ' and plan_movfluxo<>''N'''+
            ' order by plan_conta');
    if QContas.Eof then begin
      Sistema.EndProcess('Sem contas cadastradas');
      FGeral.FechaQuery(QContas);
      exit;
    end;
    Sistema.BeginProcess('Pesquisando movimento');
    Q:=sqltoquery('select * from movfin'+
                  ' inner join plano on ( plan_conta=movf_plan_conta )'+
                  ' left join historicos on (hist_codigo=movf_hist_codigo)'+
                  ' where '+FGeral.Getin('movf_status','N','C')+
                  sqlunidade+
                  ' and plan_movfluxo<>''N'''+
                  ' and '+FGeral.GetIn('plan_tipo','C;B','C')+
                  sqlperiodo+sqlconta+sqlhistorico+sqlacesso+sqlusuario+
                  sqlorder );

    if Q.Eof then begin
      FGeral.FechaQuery(Q);
      Sistema.EndProcess('Nada encontrado para impress�o');
      exit;
    end;
    Lista:=TList.create;

      while (not Q.Eof)  do begin
        if pos( Q.FieldByName('movf_unid_codigo').AsString,EdUnid_codigo.text ) >0 then begin
          Atualiza(Q.fieldbyname('movf_transacao').asstring,Q.fieldbyname('movf_plan_conta').asstring);
        end;
        Q.Next;
      end;
// - busca os cheques no cadastro de cheques
// 11.08.15
//////////////////////////////// cheques nao tem cmapo de usuario rever
{
      sqlunidade:=' and '+FGeral.getin('cheq_unid_codigo',EdUnid_codigo.text,'C',);
      if EdDAtai.Asdate<=1 then begin
        sqlperiodo:='';
        inicio:=Sistema.hoje;
      end else begin
        inicio:=(EdDatai.Asdate);
        sqlperiodo:=' and cheq_deposito>='+DatetoSql(inicio)+' and cheq_deposito<='+EdDataf.AsSql;
      end;
      sqlusuario:=' and cheq_usua_codigo='+inttostr(Global.usuario.codigo);

  //    if (Edtiporel.text='9') then
        sqlacesso:='';
  //    else if (Edtiporel.text='2') then
  //      sqlacesso:=' and movf_datacont is null'
  //    else
  //      sqlacesso:=' and movf_datacont is not null';
      sqlorder:=' order by cheq_datamvto';
      Q.close;

      Q:=sqltoquery('select * from cheques'+
                  ' where '+FGeral.Getin('cheq_status','N','C')+
                  sqlunidade+
                  ' and cheq_emirec=''R'''+
                  sqlperiodo+sqlusuario );
      while (not Q.Eof)  do begin
        AtualizaCh('CH');
        Q.Next;
      end;
      }
////////////////////////////////

    Sistema.BeginProcess('Imprimindo Relat�rio');
    FRel.Init('MovimentoDiarioUsuario');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
    FRel.AddTit('Resumo Movimento Di�rio  - Usu�rio:'+inttostr(Global.usuario.Codigo)+' - '+Global.Usuario.Nome);
    FRel.AddTit('Periodo : '+TituloPeriodo(EdDatai.Asdate,EdDataf.asdate));
//    FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    FRel.AddCol( 50,0,'C','' ,''              ,'Portador'          ,''         ,'',false);
    FRel.AddCol(150,0,'C','' ,''              ,'Descri��o'      ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+',f_cr            ,'Vendas Vista'   ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+',f_cr            ,'Vendas '   ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+',f_cr            ,'Juros '   ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+',f_cr            ,'Recebido '   ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+',f_cr            ,'Total '   ,''         ,'',False);
//    FRel.AddCol( 80,3,'N','+',f_cr             ,'Saldo anterior'   ,''         ,'',False);
//    FRel.AddCol( 80,3,'N','+',f_cr             ,'Saldo periodo'   ,''         ,'',False);
    for p:=0 to LIsta.count-1 do begin
      PContas:=Lista[p];
      FRel.AddCel((PContas.portador));
      FRel.AddCel(FPortadores.GetDescricao(PContas.portador));
      FRel.AddCel(FGeral.Formatavalor(PContas.vendasavista,f_cr));
      FRel.AddCel(FGeral.Formatavalor(PContas.prazo,f_cr));
      FRel.AddCel(FGeral.Formatavalor(PContas.juros,f_cr));
      FRel.AddCel(FGeral.Formatavalor(PContas.recebidodia,f_cr));
      FRel.AddCel(FGeral.Formatavalor(PContas.vendasavista+PContas.prazo+PContas.juros+PContas.recebidodia,f_cr));
    end;

  end;
  FGeral.FechaQuery(Q);
  Lista.free;
  Sistema.endProcess('');
  FRel.Video;
end;


// 11.05.17 -
procedure TFRelcxbancos.bjurosClick(Sender: TObject);
//////////////////////////////////////////////////////
begin

     LancaJuros;

end;

procedure TFRelcxbancos.bjuroscprClick(Sender: TObject);
///////////////////////////////////////////////////////////
begin

   LancaJuros('P');

end;

// 09.04.19
procedure TFRelcxbancos.lancajuros(xOP:String='A');
//////////////////////////////////////////////////////
var ncontas:integer;
    Q,QM:TSqlquery;
    sqlunidade,sqlperiodo,sqlorder,sqlconta,transacao :string;
    inicio,dataant:TDatetime;
    txjuros,saldo,saldocor,vlrjuros,totaljuros:currency;
    diasatraso:integer;

begin


   if xOP='A' then begin

      if not confirma('Confirmar lan�ar juros de toda(s) a(s) conta(s) de adiantamento ?') then exit;

   end else  begin

      if not confirma('Confirmar lan�ar juros de toda(s) a(s) conta(s) de CPR ?') then exit;

   end;
   sqlconta:='';
   if not EdPlan_conta.IsEmpty then sqlconta:=' and plan_conta = '+EdPlan_conta.AsSql;

   ncontas:=0;
   if xOP='A' then begin

       Q:=Sqltoquery('select plan_conta,plan_taxajuros from plano where Plan_tipoativ = '+Stringtosql('A')+
                      sqlconta );
    //                 'and Plan_contajuros>0');
       if q.Eof then begin
         Avisoerro('N�o encontrado contas identificadas como de adiantamento');
         exit;
       end;

   end else begin

       Q:=Sqltoquery('select plan_conta,plan_taxajuros from plano where Plan_tipo = '+Stringtosql('P')+
                      sqlconta );
       if q.Eof then begin
         Avisoerro('N�o encontrado contas identificadas como de CPR');
         exit;
       end;

   end;
//   Sistema.GetDataMvto('Informe data para lan�amento dos juros');

    Sistema.DataMvto:=EdDataf.AsDate;
    sqlunidade:=' and '+FGeral.getin('movf_unid_codigo',EdUnid_codigo.text,'C');

    inicio:=DateToPrimeiroDiaMes(Sistema.datamvto);
// 21.09.20 - Novicarnes - para fezer mais de um calculo de juros dentro do mes
//    inicio:=EdDatai.asdate;

    sqlperiodo:=' and movf_datamvto>='+DatetoSql(inicio)+
                 ' and movf_datamvto<='+DatetoSql(Sistema.datamvto);
    sqlorder:=' order by movf_plan_contard,movf_dataprevista,movf_numerodcto';

   Sistema.beginprocess('Gerando lan�amentos de juros em '+FGeral.formatadata(sistema.datamvto));

   while not q.Eof do begin

     txjuros:=Q.FieldByName('Plan_taxajuros').AsCurrency;

     if txjuros>0  then begin

// 05.09.19 - n�o estava consirando as BP pois estas n�o grava no movf_plan_conta e sim no ...rd
//        if xOP = 'A' then

          sqlconta:=' and movf_plan_contard = '+inttostr(Q.fieldbyname('plan_conta').asinteger);

//        else

//          sqlconta:=' and movf_plan_conta = '+inttostr(Q.fieldbyname('plan_conta').asinteger);


       QM:=sqltoquery('select * from movfin'+
                  ' left join plano on ( plan_conta=movf_plan_contard )'+
                  ' where '+FGeral.Getin('movf_status','N','C')+
                  ' and movf_tipomov <> '+Stringtosql('JR')+
                  sqlunidade+
                  sqlperiodo+sqlconta+sqlorder );
       if xOP = 'A' then

          saldo:=FGeral.SaldoAnteriorRecDes(Q.FieldByName('plan_conta').AsInteger,EdUNid_codigo.Text,'samf_saldomov',EdDAtai.AsDate)

       else

//          saldo:=FGeral.SaldoAnterior(Q.FieldByName('plan_conta').AsInteger,EdUNid_codigo.Text,'samf_saldomov',EdDAtai.AsDate);
// 06.08.19 - n�o estava calculando juros sobre o saldo devedor...
          saldo:=FGeral.SaldoAnteriorRecDes(Q.FieldByName('plan_conta').AsInteger,EdUNid_codigo.Text,'samf_saldomov',EdDAtai.AsDate);

       Sistema.beginprocess('Gerando lan�amentos de juros em '+FGeral.formatadata(sistema.datamvto)+' conta '+inttostr(Q.fieldbyname('plan_conta').asinteger));
       dataant:=EdDatai.AsDate-1;
       totaljuros:=0;

       if Global.Usuario.codigo = 100 then aviso('Qm.sql.text='+Qm.sql.text );

       while not QM.eof do begin

          diasatraso:=Trunc(QM.FieldByName('movf_datamvto').AsDateTime-DataAnt);
// 04.01.2021  - quando nao tem movimento no mes q vai gerar juros...
          if diasatraso<0 then diasatraso:=0;

          vlrjuros:= ( saldo * ( (txjuros/30)/100 ) * diasatraso );
          totaljuros:=totaljuros+vlrjuros;
          saldocor:=saldo + vlrjuros;
          if Qm.FieldByName('movf_Es').AsString='E' then begin
            saldo:=saldo+Qm.FieldByName('movf_valorger').AsCurrency;
          end else begin
            saldo:=saldo-Qm.FieldByName('movf_valorger').AsCurrency;
          end;
// 11.05.17
          dataant:=QM.FieldByName('movf_datamvto').AsDateTime;
          Qm.next;

          if Global.Usuario.codigo = 100 then aviso('dias no while atraso='+inttostr(diasatraso)+' Mvto '+FGeral.formatadata(QM.FieldByName('movf_datamvto').AsDateTime) );

       end;

       if dataant <= EdDataf.AsDate then begin

          diasatraso:=Trunc(EdDataf.AsDate-DataAnt);
          vlrjuros:= ( saldo * ( (txjuros/30)/100 ) * diasatraso );
          totaljuros:=totaljuros+vlrjuros;
          if Global.Usuario.codigo = 100 then aviso('dias fora while atraso='+inttostr(diasatraso) );

       end;

       dataant:=dataant+1;

       FGEral.fechaquery(qm);
//       if ( abs(saldocor)-abs(saldo) )>0 then begin
       if totaljuros<>0 then begin

         QM:=sqltoquery('select movf_transacao from movfin where movf_status = ''N'''+
                        ' and movf_plan_contard = '+inttostr(Q.fieldbyname('plan_conta').asinteger)+
                        ' and movf_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                        ' and movf_tipomov = '+Stringtosql('JR')+
                        ' and movf_datamvto = '+Datetosql(Sistema.DataMvto)+
                        ' and movf_es = '+Stringtosql('S') );
         if not Qm.eof then begin
           Sistema.Edit('movfin');
           Sistema.SetField('movf_status','C');
           Sistema.Post('movf_transacao = '+Stringtosql(QM.FieldByName('movf_transacao').AsString)+
                        ' and movf_status = ''N''');
         end;
         transacao:=FGeral.GetTransacao;
         inc(ncontas);
         if xOP='A' then

           FGeral.GravaMovfin(transacao,Global.CodigoUnidade,'S','Juros ref. '+fGeral.FormataData(EddAtai.AsDate)+' a '+fGeral.FormataData(EddAtaf.AsDate),Sistema.DataMvto,
                            Sistema.DataMvto,Sistema.DataMvto,506,0,0,FGEral.getconfig1asinteger('CtaJurosrec'),abs(totaljuros),
                             Q.fieldbyname('plan_conta').asinteger ,'JR' )

         else

           FGeral.GravaMovfin(transacao,Global.CodigoUnidade,'S','Juros ref. '+fGeral.FormataData(EddAtai.AsDate)+' a '+fGeral.FormataData(EddAtaf.AsDate),Sistema.DataMvto,
                            Sistema.DataMvto,Sistema.DataMvto,507,0,0,FGEral.getconfig1asinteger('CtaJurosrec'),abs(totaljuros),
                             Q.fieldbyname('plan_conta').asinteger ,'JR' );
         Sistema.Commit;

       end;

     end;
     q.Next;
   end;
   FGEral.fechaquery(q);
   Sistema.endprocess('Lan�ado juros em '+inttostr(ncontas)+' contas');
end;

procedure TFRelcxbancos.blancarClick(Sender: TObject);
///////////////////////////////////////////////////////////]
var saldo:currency;
    QSaldo,Q:TSqlquery;
    lanfuncionario,xtransacao,xoperacao:string;
    xdata,xdatai,xdataf:TDatetime;
begin
// 14.03.14 - Damama - Acerto com funcionarios - busca no contas a receber do periodo por emissao do
//            relatorio o que estiver em Aberto.
    if not Sistema.GetDataMvto('Data do lan�amento') then exit;
    xdata:=Sistema.DataMvto;
    xdatai:=DateToPrimeiroDiaMes(xdata);
    xdataf:=DateToUltimoDiaMes(xdata);
    lanfuncionario:='ACERTOFUNC';
    saldo:=0;
    if EdPlan_conta.ResultFind<>nil then begin
      Q:=sqltoquery('select movf_valorger,movf_es from movfin'+
                  ' left join historicos on (hist_codigo=movf_hist_codigo)'+
                  ' where '+FGeral.Getin('movf_status','N','C')+
                  ' and '+FGeral.GetIN('movf_unid_codigo',EdUnid_codigo.text,'C')+
                  ' and movf_plan_conta='+EdPlan_conta.assql+
                  ' and movf_datamvto >= '+EdDatai.AsSql+
                  ' and movf_datamvto <= '+EdDataf.AsSql+
                  ' order by movf_plan_conta,movf_datamvto,movf_tipomov,movf_transacao,movf_numerodcto' );
      while not Q.eof do begin
        if Q.fieldbyname('movf_es').asstring='S' then
           saldo:=saldo+Q.fieldbyname('movf_valorger').ascurrency
        else
           saldo:=saldo-Q.fieldbyname('movf_valorger').ascurrency;
        Q.Next;
      end;
      if EdPlan_conta.ResultFind.FieldByName('plan_contaabatimentos').asinteger>0 then begin
         QSaldo:=sqltoquery('select * from pendencias where pend_tipo_codigo='+inttostr(EdPlan_conta.ResultFind.FieldByName('plan_contaabatimentos').asinteger)+
                 ' and pend_rp=''R'' and pend_dataemissao >= '+EdDatai.AsSql+
                 ' and pend_dataemissao <= '+EdDataf.AsSql+
                 ' and pend_status<>''C'' and pend_tipocad=''C'''+
                 ' and '+FGeral.GetIN('pend_unid_codigo',EdUnid_codigo.text,'C') );
         while not QSaldo.eof do begin
           saldo:=saldo+QSaldo.FieldByName('pend_valor').AsCurrency;
           QSaldo.Next;
         end;
         FGeral.FechaQuery(Qsaldo);
      end;
      FGeral.FechaQuery(Q);
    end;
    if confirma( 'Confirma valor '+fGeral.formatavalor(saldo,f_cr)+' ?' ) then begin
        Q:=Sqltoquery('select movf_transacao from movfin where movf_transconc='+Stringtosql(lanfuncionario)+
                      ' and movf_plan_contard='+EdPlan_conta.assql+
                      ' and movf_datamvto >= '+Datetosql( xdatai )+
                      ' and movf_datamvto <= '+Datetosql( xdataf )+
                      ' and movf_status=''N''');
        if Q.eof then begin
          xtransacao:=FGeral.GetTransacao;
          xoperacao:=FGeral.GetOperacao;
          Sistema.Insert('movfin');
          Sistema.setfield('movf_transacao',xtransacao);
          Sistema.setfield('movf_operacao',xoperacao);
          Sistema.setfield('movf_status','N');
          Sistema.setfield('movf_unid_codigo',Global.CodigoUnidade);
          Sistema.setfield('movf_datalcto',Sistema.hoje);
          Sistema.setfield('movf_datamvto',Sistema.hoje);
          Sistema.setfield('movf_datacont',Sistema.hoje);
          Sistema.setfield('movf_dataprevista',Sistema.hoje);
//        movf_dataextrato date,
          Sistema.setfield('movf_plan_conta',FUnidades.GetContaCaixa(Global.CodigoUnidade));
//        movf_hist_codigo numeric(3,0),
          Sistema.setfield('movf_complemento',copy('Acerto '+EdPlan_conta.resultfind.fieldbyname('plan_descricao').asstring,1,100));
          Sistema.setfield('movf_numerodcto','601');
//        movf_codb_codigo character varying(3),
          Sistema.setfield('movf_es','S');
//        movf_favorecido character varying(100),
//        movf_numerocheque numeric(8,0),
          Sistema.setfield('movf_valorger',saldo);
//        movf_valorbco numeric(12,2),
          Sistema.setfield('movf_transconc',lanfuncionario);
//        movf_seqlcto numeric(5,0),
          Sistema.setfield('movf_plan_contard',EdPlan_conta.asinteger);
          Sistema.setfield('movf_tipomov',Global.CodLanCaixabancos);
          Sistema.setfield('movf_usua_codigo',Global.Usuario.codigo);
//        movf_repr_codigo numeric(4,0),
//        movf_tipo_codigo numeric(8,0),
//        movf_tipocad character varying(1)
          Sistema.Post();
        end else begin
          xtransacao:=Q.fieldbyname('movf_transacao').asstring;
          Sistema.edit('movfin');
          Sistema.setfield('movf_valorger',saldo);
          Sistema.post(' movf_transacao='+Stringtosql(xtransacao)+
                      ' and movf_plan_contard='+EdPlan_conta.assql+
                      ' and movf_datamvto >= '+EdDatai.AsSql+
                      ' and movf_datamvto <= '+EdDataf.AsSql+
                      ' and movf_status=''N''');
        end;
        Sistema.commit;
        Aviso('Lan�amento efetuado');
    end;
end;

end.
