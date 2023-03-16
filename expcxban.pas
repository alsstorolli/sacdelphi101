unit expcxban;

interface                                                                

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  SQLGrid, ExtCtrls, DB,
  //dbf,
  Sqlsis, sqlexpr;
  // Dbtables;

type
  TFExpcaixaban = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bExecutar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Texto: TRichEdit;
/////    DbfExpant: TDbf;
    Edinicio: TSQLEd;
    Edtermino: TSQLEd;
    EdMesano: TSQLEd;
    EdSistema: TSQLEd;
    EdPasta: TSQLEd;
    brelerros: TSQLBtn;
    bexportados: TSQLBtn;
    EdContas: TSQLEd;
    EdPagrec: TSQLEd;
    Edbanco: TSQLEd;
    EdBanco_descricao: TSQLEd;
    EdTipomov: TSQLEd;
    procedure bExecutarClick(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdSistemaExitEdit(Sender: TObject);
    procedure brelerrosClick(Sender: TObject);
    procedure bexportadosClick(Sender: TObject);
    procedure EdSistemaValidate(Sender: TObject);
    procedure EdbancoValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function Formatovalorcomponto(valor:currency;tamanho,decimais:integer):string;
    function TransacaoNaoFeita(xt:string):boolean;
    function ChecaValores:boolean;

  end;

var
  FExpcaixaban: TFExpcaixaban;
  Nomearq,nomepath,nomedbf,nomearqtxt,nomearqtexto,cdebito,ccredito:string;
/////  Dbfexp:TTable;
  Arquivo:Textfile;
  QBanco :TSqlquery;


var DriveExp:string;
    ListaT:TStringlist;

const
   maximocomple:integer=50;   // 40 - 31.05.06


implementation

uses  plano , sqlfun , Geral, Arquiv, Hist, fornece, cadcli,
  TextRel, SQLRel, represen, Unidades;

{$R *.dfm}

procedure TFExpcaixaban.bExecutarClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////
type TTotais = record
     tipomov:string;
     valor,quantos:currency;
end;

var n,empresa,filial,sist,codforne,outraconta:integer;
    Q,QPend,QJuros,QDescontos:TSqlquery;
    transacao,linha,historico,tipocad,tipomovnota,ContasBloqueadas,sqlcontas,sqlpagrec,
    unidadedaconta,
    unidadetransacao,
    sqltipomov,
    sqlcontaplano,
    sqltipomovofx:string;
    debito,credito,caixafilial,p,xdebito,xcredito,xdebitomultiplo:integer;
    valortotal,vlrentradas,vlrsaidas,valortotalcreditos:currency;
    Listatotais:Tlist;
    PTotais:^TTotais;
    Datamvto:TDatetime;
    ListaJuros,
    ListaDescontos:TStringList;

    function GetOutraConta(conta:integer ; xtransacao:string ; xdata:Tdatetime=0 ; xvalor:currency=0 ; xnumerodcto:string='' ):integer;
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    var Qt:Tsqlquery;
    begin
      if xdata=0 then begin
        Qt:=sqltoquery('select movf_plan_conta from movfin where movf_transacao='+stringtosql(xtransacao)+' and movf_plan_conta<>'+inttostr(conta));
        if not Qt.eof then
          result:=Qt.fieldbyname('movf_plan_conta').asinteger
        else
          result:=0;
      end else begin  // 21.08.08
        if trim(xnumerodcto)<>''  then begin // 27.10.08
          if trim(xnumerodcto)<>'500' then  // 01.09.09 -trato de baixa de cheque recebido
            Qt:=sqltoquery('select movf_plan_conta from movfin where movf_transacao='+stringtosql(xtransacao)+' and movf_plan_conta<>'+inttostr(conta)+
//                       ' and movf_datamvto='+Datetosql(xdata)+' and movf_valorger='+Valortosql(xvalor)+
                       ' and movf_numerodcto='+stringtosql(xnumerodcto)+
                       ' and movf_valorger='+Valortosql(xvalor) )
          else
            Qt:=sqltoquery('select movf_plan_conta from movfin where movf_transacao='+stringtosql(xtransacao)+' and movf_plan_conta<>'+inttostr(conta)+
//                       ' and movf_datamvto='+Datetosql(xdata)+' and movf_valorger='+Valortosql(xvalor)+
                       ' and movf_numerodcto='+stringtosql('501')+
                       ' and movf_valorger='+Valortosql(xvalor) );
        end else begin
          Qt:=sqltoquery('select movf_plan_conta from movfin where movf_transacao='+stringtosql(xtransacao)+' and movf_plan_conta<>'+inttostr(conta)+
//                       ' and movf_datamvto='+Datetosql(xdata)+' and movf_valorger='+Valortosql(xvalor)+
                       ' and movf_valorger='+Valortosql(xvalor) );
        end;
        if not Qt.eof then
          result:=Qt.fieldbyname('movf_plan_conta').asinteger
        else
          result:=0;
      end;
      FGeral.FechaQuery(QT);
    end;

// 20.01.17
    function GetOutraUnidade(conta:integer ; xtransacao:string ):string;
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    var Qt:Tsqlquery;
    begin
      Qt:=sqltoquery('select movf_unid_codigo from movfin where movf_transacao='+stringtosql(xtransacao)+' and movf_plan_conta<>'+inttostr(conta));
      if not Qt.eof then
        result:=Qt.fieldbyname('movf_unid_codigo').asstring
      else
        result:=EdUnid_codigo.text;
      FGeral.FechaQuery(QT);
    end;


    function Estavalendo:boolean;
    /////////////////////////////
    begin
      result:=false;

      if (trim(EdMesano.text)='') and (Q.fieldbyname('movf_datacont').asdatetime<=1) then
        result:=true
      else if (trim(EdMesano.text)<>'') and (Q.fieldbyname('movf_datacont').asdatetime>1) then
        result:=true
      else if (trim(EdMesano.text)='') and (Q.fieldbyname('movf_datacont').asdatetime>1) then
        result:=false
      else if (trim(EdMesano.text)<>'') and (Q.fieldbyname('movf_datacont').asdatetime<=1) then
        result:=false;

// 27.09.05
      if result then begin

//        if (Q.fieldbyname('plan_tipo').asstring='B') and (Q.fieldbyname('movf_plan_contard').asinteger=0) then begin
        if (Q.fieldbyname('plan_tipo').asstring='B') and (Q.fieldbyname('movf_plan_contard').asinteger=0) and
          ( pos(Q.fieldbyname('movf_numerodcto').asstring,'500/501')=0 ) and
// 15.02.17
//          ( Q.FieldByName('movf_tipomov').AsString<>Global.CodJurosRecebidos)
// 25.06.18 - Vida Nova - Lan�amentos ref. baixa cobran�a banc�ria 'nunca nem vi'..
          ( AnsiPos( Q.FieldByName('movf_tipomov').AsString,Global.CodJurosRecebidos+';'+Global.CodPendenciaFinanceira) = 0)
          then begin

            result:=false;
    // 28.11.05 exce��o devido as tarifas bancarias lan�adas mas sem conta de receita/despesas
            if pos( 'Tarifa ban',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then
              result:=true
    // 21.06.07 - mais uma..
            else  if pos( 'Transfer',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then
            result:=true

// 10.09.08 - transferencia entre contas bancarias mas sem o historico 'transfer'... -carli
          else if Q.fieldbyname('movf_tipomov').asstring=Global.CodLanCaixabancos then begin

            if Transacaonaofeita(Q.fieldbyname('movf_transacao').asstring)  then
              result:=true;
          end;
// 09.08.16 - ajustes devido a baixa de cobran�a bancaria
/////////////////////////////////////////////////////////
        end else if (Q.fieldbyname('plan_tipo').asstring='B') and (Q.fieldbyname('movf_plan_contard').asinteger>0) and
          ( pos(Q.fieldbyname('movf_numerodcto').asstring,'500/501')=0 )
          then begin

          result:=false;
          if pos( 'Tarifa ban',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then
            result:=true
          else  if pos( 'Transfer',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then
            result:=true
// para prever juros / descontos da baixa de cobran�a
          else if pos(Q.fieldbyname('movf_tipomov').asstring,Global.CodJurosRecebidos+';'+Global.CodDescontosDados)>0 then
            result:=true
//10.08.16
          else if pos(Q.fieldbyname('movf_tipomov').asstring,Global.CodPendenciaFinanceira)>0 then begin
//            if Transacaonaofeita(Q.fieldbyname('movf_transacao').asstring)  then
            result:=true;
//10.08.16
          end else if pos(Q.fieldbyname('movf_tipomov').asstring,Global.CodLanCaixabancos)>0 then begin
            if Transacaonaofeita(Q.fieldbyname('movf_transacao').asstring)  then
              result:=true;
          end;

// 19.07.11 - Novicarnes - vava
////////////////////////////////
        end else if (Q.fieldbyname('plan_tipo').asstring='C') and (Q.fieldbyname('movf_plan_contard').asinteger=0) and
          ( pos(Q.fieldbyname('movf_numerodcto').asstring,'500/501')>0 ) and
          ( (Q.fieldbyname('movf_plan_conta').asinteger=Caixafilial ) ) and
          (  Global.Topicos[1023] )
          then begin
          result:=false;
          if pos( 'Tarifa ban',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then
            result:=true
          else  if pos( 'Transfer',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then
            result:=true
          else if Q.fieldbyname('movf_tipomov').asstring=Global.CodLanCaixabancos then begin
            if Transacaonaofeita(Q.fieldbyname('movf_transacao').asstring)  then
              result:=true;
          end;
/////////////////////////////////////////////////////////////////
  // 04.04.05 - retirado esta checagem - NUNCA MAIS retirar pois dobra os lan�amentos
        end else if (Q.fieldbyname('movf_plan_conta').asinteger=Caixafilial) and (Q.fieldbyname('movf_plan_contard').asinteger=0) then begin

          if (Q.fieldbyname('movf_ES').asSTRING='E') and ( pos( 'Juros Recebidos',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString  ) >0 ) then
            result:=true
          else if (Q.fieldbyname('movf_ES').asSTRING='S') and ( pos( 'Devolu',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString  ) >0 ) then
            result:=true  // 06.04.05
          else if (Q.fieldbyname('movf_ES').asSTRING='S') and ( pos( 'Depo',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString  ) >0 ) then
            result:=true  // 27.09.05
          else if (Q.fieldbyname('movf_ES').asSTRING='E') and ( pos( 'Saque',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString  ) >0 ) then
            result:=true
// 26.02.10 - Capeg - prever compras a vista
          else if (Q.fieldbyname('movf_ES').asSTRING='S') and ( pos(Q.fieldbyname('movf_tipomov').asstring,Global.CodCompraMatConsumo+';'+Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraProdutor)>0 ) then
            result:=true;
        end;
      end;

    end;

    function Buscafornecedor(transacaobaixa:string;var xtipocad:string ):integer;
    ////////////////////////////////////////////////////////////////////////////
    var Q:Tsqlquery;
        quantos:integer;
    begin
//      Q:=sqltoquery('select * from pendencias where pend_transbaixa='+stringtosql(transacaobaixa));
      Q:=sqltoquery('select pend_tipo_codigo,pend_tipocad,sum(pend_valor) as valor from pendencias'+
                    ' where pend_transbaixa='+stringtosql(transacaobaixa)+
                    ' group by pend_tipo_codigo,pend_tipocad');
      xtipocad:='';
//      if not Q.eof then begin
      if Q.fieldbyname('valor').ascurrency>0 then begin
        xtipocad:=Q.fieldbyname('pend_tipocad').asstring;
        result:=Q.fieldbyname('pend_tipo_codigo').asinteger;
        while not Q.eof do begin
          if Q.fieldbyname('pend_tipo_codigo').asinteger<>result then
            result:=-1;
          Q.Next;
        end;
      end else begin
//        if Global.Usuario.Codigo=100 then
//          showmessage('N�o encontrado como transacao  de baixa '+transacaobaixa);

        FGeral.Fechaquery(Q);  // devido as porra loka de 'baixa parcial' dos documento importados com 'mesmo numero/parcela'
        Q:=sqltoquery('select * from pendencias where pend_transacao='+stringtosql(transacaobaixa));
        if not Q.eof then begin
          xtipocad:=Q.fieldbyname('pend_tipocad').asstring;
          result:=Q.fieldbyname('pend_tipo_codigo').asinteger
        end else begin
//          if Global.Usuario.Codigo=100 then
//            showmessage('N�o encontrado como transacao normal '+transacaobaixa);
         result:=0;
        end;
      end;
    end;

    function BuscaTipoMov(transacaobaixa:string):String;
    ///////////////////////////////////////////////////////
    var Qtm:TSqlquery;
    begin
      result:='??';
      Qtm:=sqltoquery('select pend_tipomov from pendencias where pend_transbaixa='+stringtosql(transacaobaixa));
      if not Qtm.eof then
        result:=Qtm.fieldbyname('pend_tipomov').asstring
      else begin
// 17.10.19   - quando era baixa parcial nao encontrava nada...
         fGeral.FechaQuery(Qtm);
         Qtm:=sqltoquery('select pend_tipomov from pendencias where pend_databaixa='+Datetosql(Q.FieldByName('movf_datamvto').AsDateTime)+
                         ' and pend_tipo_codigo = '+inttostr(Q.FieldByName('movf_tipo_codigo').AsInteger)+
                         ' and pend_status = ''P'''+
                         ' and pend_unid_codigo = '+EdUNid_codigo.AsSql+
                         ' and pend_valor = '+Valortosql(Q.FieldByName('movf_valorger').Ascurrency) );
         if not Qtm.eof then
            result:=Qtm.fieldbyname('pend_tipomov').asstring;

      end;
      fGeral.FechaQuery(Qtm);
    end;

    procedure Somatotais(tipo:string ; valor:currency);
    ///////////////////////////////////////////////////////
    var p:integer;
        achou:boolean;
    begin
      achou:=false;
      for p:=0 to listatotais.count-1 do begin
        Ptotais:=listatotais[p];
        if ptotais.tipomov=tipo then begin
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
        New(Ptotais);
        Ptotais.tipomov:=tipo;
        ptotais.valor:=valor;
        ptotais.quantos:=1;
        listatotais.add(ptotais);
      end else begin
        ptotais.valor:=ptotais.valor+valor;
        ptotais.quantos:=ptotais.quantos+1;
      end;
    end;

    ////////////////////////////////////////////////////////
    Function Provisionado(t:string):boolean;
    //////////////////////////////////////////////////
    var Q,QP:TSqlquery;
    begin
      QP:=sqltoquery('select pend_transacao,pend_transbaixa from pendencias where pend_transbaixa='+stringtosql(t)+' and pend_status<>''C''');
      if not Qp.eof then begin
        Q:=sqltoquery('select moes_transacao from movesto where moes_transacao='+stringtosql(QP.fieldbyname('pend_transacao').asstring)+' and moes_status<>''C''');
        if not Q.eof then
          result:=true
        else
          result:=false;
        FGeral.FechaQuery(Q);
      end else begin
        QP:=sqltoquery('select pend_transacao,pend_transbaixa from pendencias where pend_transacao='+stringtosql(t)+' and pend_status<>''C''');
        if not Qp.eof then begin
          Q:=sqltoquery('select moes_transacao from movesto where moes_transacao='+stringtosql(QP.fieldbyname('pend_transacao').asstring)+' and moes_status<>''C''');
          if not Q.eof then
            result:=true
          else
            result:=false;
          FGeral.FechaQuery(Q);
        end else
          result:=false;
      end;
    end;

    // 14.05.2020
    Function BaixadeCPR(t:string):boolean;
    //////////////////////////////////////////////////
    var QP:TSqlquery;
    begin
      result:=false;

      exit;      // ver melhor com sandro e simone

      QP:=sqltoquery('select pend_transacao,pend_tipomov from pendencias where pend_transbaixa='+stringtosql(t)+' and pend_status<>''C''');
      if not Qp.eof then begin

        if Qp.fieldbyname('pend_tipomov').AsString = Global.CodCedulaProdutoRural then
          result:=true

      end;
      FGeral.FechaQuery(QP);

    end;



begin
////////////////////////////////////////////////////

  if not EdUnid_codigo.validfind then exit;
  if not EdUnid_codigo.valid then exit;
  if Trim(EdMesano.text)<>'' then begin
    if EdUNid_codigo.resultfind.fieldbyname('unid_empresa1').asinteger=0 then begin
      Avisoerro('Falta configurar o codigo da empresa 1 no cadastro de unidades');
      exit;
    end;
  end else
    if EdUNid_codigo.resultfind.fieldbyname('unid_empresa2').asinteger=0 then begin
      Avisoerro('Falta configurar o codigo da empresa 2 no cadastro de unidades');
      exit;
    end;
// 21.06.07
//  Global.ContaCTbTransNume:=EdUnid_codigo.resultfind.fieldbyname('Unid_ctbtransnume').AsInteger;
// 20.01.17
  Global.ContaCTbTransNume:=EdUnid_codigo.resultfind.fieldbyname('Unid_ctbtransnumecre').AsInteger;

  if not confirma('Confirma exporta��o ?') then exit;
// 22.05.09
  ContasBloqueadas:=FGeral.GetConfig1AsString('ContasBloq');

  ListaT:=TStringlist.create;
// 11.10.16
  ListaJuros:=TStringList.create;
  ListaDescontos:=TStringList.create;

//  if ( Edinicio.Asdate<>dbfexp.FieldByName('dataini').AsDateTime) ) or
//     ( EdTermino.Asdate<>dbfexp.FieldByName('datafinm').asdatetime ) then
//     Aviso('Aten��o !  �ltimo per�odo foi de '+dbfexp.FieldByName('dataini').Asstring+' a '+dbfexp.FieldByName('datafinm').asstring );

// 30.04.12 - reativado
  if Global.Usuario.OutrosAcessos[0716] then begin
    if trim(Edcontas.text)='' then
      sqlcontas:=''
    else
     sqlcontas:=' and '+FGeral.Getin('movf_plan_contard',EdContas.text,'N');
  end else
    sqlcontas:='';
// 13.02.2023 - devereda arquivo ofx
  sqlcontaplano:='';
  if trim(EdBanco.text)<>'' then
     sqlcontaplano:=' and '+FGeral.Getin('movf_plan_conta',EdBanco.text,'N');

  sqltipomovofx := '';
  if trim(Edtipomov.text)<>'' then sqltipomovofx :=' and '+FGeral.Getin('movf_tipomov',EdTipomov.Assql,'N');

// 01.04.16 - Questor
    sqlpagrec:='';
   if (EdSistema.text='04') then begin
      if( EdPagrec.text='P' ) then sqlpagrec:=' and movf_es=''S''' else sqlpagrec:='and movf_es=''E''';
   end;
//  caixafilial:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
  caixafilial:=EdUnid_codigo.resultfind.fieldbyname('unid_contacontabil').asinteger;
// 23.04.18 - Novicarnes -  CPR
  sqltipomov:=' and '+FGeral.GetNOTIN('movf_tipomov',Global.CodCedulaProdutoRural,'C');

  Q:=sqltoquery('select * from movfin'+
                ' left join plano on ( plan_conta=movf_plan_conta )'+
                ' where movf_status=''N'' and movf_datamvto>='+EdInicio.assql+
                ' and movf_datamvto<='+EdTermino.assql+
                sqlcontas+sqlpagrec+sqltipomov+sqlcontaplano+sqltipomovofx+
                ' and movf_unid_codigo='+EdUnid_codigo.assql+
//                ' order by movf_transacao' );
// 04.05.05
//                ' order by movf_operacao' );
// 07.11.07
//                ' order by movf_transacao,movf_es' );
// 28.11.16 - Vida Nova  - baixa varios clientes de uma vez
                ' order by movf_operacao,movf_es' );
  if Q.eof then begin
    Avisoerro('Nada encontrado para exporta��o');
    Q.Close;
    exit;
  end;

  Listatotais:=tlist.create;
  texto.clear;
{
  Sistema.beginprocess('Eliminando lan�amentos da �ltima exporta��o.  Arquuivo '+nomepath+nomedbf);
  dbfexp:=TTable.Create(Application);
  dbfexp.Databasename:=NOMEpath;
  dbfexp.Tabletype:=TTDbase;
  Sistema.beginprocess('Abrindo arquivo');
  dbfexp.tablename:=nomedbf;

  dbfexp.open;
  dbfexp.First;
  Sistema.beginprocess('Percorrendo lan�amentos');
  while not dbfexp.eof do begin
    dbfexp.delete;
    dbfexp.next;
  end;
}


// 31.05.12
  nomearqtexto:='CTBCX'+FormatDatetime('mmyyyy',EdTermino.Asdate);
   if (EdSistema.text='04') then begin
      if( EdPagrec.text='P' ) then nomearqtexto:='CTBPAG'+FormatDatetime('mmyyyy',EdTermino.Asdate) else nomearqtexto:='CTBREC'+FormatDatetime('mmyyyy',EdTermino.Asdate);
   end;

  AssignFile(Arquivo, EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.txt' );
  try
    Rewrite(Arquivo);
  except
    Avisoerro('Drive ou Pasta n�o encontrado');
    Q.Close;
    EdPasta.setfocus;
    exit;
  end;

  Sistema.beginprocess('Exportando lan�amentos');
// ver onde colocar esta configura��o da empresa no viasoft

  if Trim(EdMesano.text)<>'' then begin
    empresa:=EdUNid_codigo.resultfind.fieldbyname('unid_empresa1').asinteger;
    filial:=EdUNid_codigo.resultfind.fieldbyname('unid_filial1').asinteger;
  end else begin
    empresa:=EdUNid_codigo.resultfind.fieldbyname('unid_empresa2').asinteger;
    filial:=EdUNid_codigo.resultfind.fieldbyname('unid_filial2').asinteger;
  end;
  sist:=7;
  n:=0;
  valortotal:=0;
  vlrentradas:=0;
  vlrsaidas:=0;
/////////////////////////

  while not Q.eof do begin

    transacao:=Q.fieldbyname('movf_transacao').asstring;
    debito:=0;
    credito:=0;

    while (not Q.eof) and (transacao=Q.fieldbyname('movf_transacao').asstring) do begin

      if EstaValendo then begin

//        if (Q.fieldbyname('movf_plan_conta').asinteger=caixafilial) and ( pos('VISTA',UPPERCASE(Q.fieldbyname('movf_complemento').Asstring))>0)
//           then
//            debito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;

        codforne:=0;
        tipocad:='X';

        if Q.fieldbyname('movf_es').asstring='E' then begin    // baixa de pendencias e outras...

        ///////////////////////////////////////////////////////////////////////////////
//          if FPlano.GetConta(Q.fieldbyname('movf_plan_conta').asinteger) then
//            debito:=Arq.TPlano.fieldbyname('plan_conta').asinteger;
//            debito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
// 20.08.07 - pega o debito da conta informada na baixa
            debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text);
            credito:=EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asinteger;
// 02.03.16
            cdebito:=inttostr(FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text));
            ccredito:=EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asstring;
//
// 01.07.05
//            if Q.fieldbyname('movf_plan_contard').asinteger>0 then begin
// 01.04.16 - para questor somente recebimentos ...senao fica debito=credito
            if (Q.fieldbyname('movf_plan_contard').asinteger>0) and (Q.fieldbyname('movf_plan_contard').asinteger<>caixafilial) then begin

              credito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text);
              ccredito:=inttostr(FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text));
// 15.08.07 - transferencias da conta ch pre-datados para cofre ou caixa
            end else if (Q.fieldbyname('plan_tipo').asstring='C') then begin

              debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text);
              cdebito:=inttostr(FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text));
              outraconta:=GetOutraconta(Q.fieldbyname('movf_plan_conta').asinteger,Q.fieldbyname('movf_transacao').asstring,
                          Q.fieldbyname('movf_datamvto').asdatetime,Q.fieldbyname('movf_valorger').ascurrency,
                          '');
//              if (outraconta>0) and (FPlano.GetTipo(outraconta)='C')  then
// 18.10.07 - 'cheque troco clessi'

              if (outraconta>0)  then begin
// 31.03.17 - cheques baixados como perda no cofre
                 if ( pos(Q.fieldbyname('movf_numerodcto').asstring,'500')>0 ) and
                    ( Q.FieldByName('movf_tipomov').AsString='CH' ) then begin
                     credito:=FCadCli.GetContaExp( Q.FieldByName('movf_tipo_codigo').AsInteger,
                                   EdUnid_codigo.Text);
                     ccredito:=inttostr(credito);
                     outraconta:=0;
                 end;
// 13.01.17
                unidadedaconta:=FPlano.GetUnidadeConta(outraconta);
                unidadetransacao:=GetOutraUnidade(Q.fieldbyname('movf_plan_conta').asinteger,Q.fieldbyname('movf_transacao').asstring);
// 20.01.17
                if (outraconta>0) and (unidadetransacao=EdUnid_codigo.text) then begin
                  if trim(unidadedaconta)<>'' then begin
                    credito:=FPlano.GetContaExportacao( outraconta ,unidadedaconta);
                    ccredito:=inttostr(FPlano.GetContaExportacao( outraconta ,unidadedaconta));
                  end else begin
                    credito:=FPlano.GetContaExportacao( outraconta ,EdUnid_codigo.text);
                    ccredito:=inttostr(FPlano.GetContaExportacao( outraconta ,EdUnid_codigo.text));
                  end;
                end else if ( Q.FieldByName('movf_tipomov').AsString<>'CH' ) then begin
                  credito:=Global.ContaCTbTransNume;
                  ccredito:=inttostr(credito);
                end;
              end;
            end;

////////////////// 21.08.08 - carli
//            if (debito=credito) and (Q.fieldbyname('movf_operacao').asstring<>'989850050808') then begin
//            if (debito=credito) then begin
//              outraconta:=GetOutraconta(Q.fieldbyname('movf_plan_conta').asinteger,Q.fieldbyname('movf_transacao').asstring,
//                          Q.fieldbyname('movf_datamvto').asdatetime,Q.fieldbyname('movf_valorger').ascurrency,
//                          Q.fieldbyname('movf_numerodcto').asstring);
//              if (outraconta>0)  then
//                credito:=FPlano.GetContaExportacao( outraconta ,EdUnid_codigo.text);
//            end;
///////////////////////////
// 21.06.07
            if (Q.fieldbyname('plan_tipo').asstring='B') then begin
//              if (Q.fieldbyname('movf_plan_contard').asinteger>0)  then
//                debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text);
//              if debito=0 then
                debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text);
                cdebito:=inttostr(FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text));
// 19.03.12
             if trim(Q.fieldbyname('movf_numerodcto').asstring)='500' then  // trato de baixa de cheque recebido
               outraconta:=FUnidades.GetContaCaixa(EdUnid_codigo.text)
             else
               outraconta:=GetOutraconta(Q.fieldbyname('movf_plan_conta').asinteger,Q.fieldbyname('movf_transacao').asstring,
                          Q.fieldbyname('movf_datamvto').asdatetime,Q.fieldbyname('movf_valorger').ascurrency,
                          Q.fieldbyname('movf_numerodcto').asstring);

//              if (outraconta>0) and (FPlano.GetTipo(outraconta)='B')  then
// 20.08.07
// 20.01.17
              unidadetransacao:=GetOutraUnidade(Q.fieldbyname('movf_plan_conta').asinteger,Q.fieldbyname('movf_transacao').asstring);
              if (outraconta>0) and (unidadetransacao=EdUnid_codigo.text) then begin
                credito:=FPlano.GetContaExportacao( outraconta ,EdUnid_codigo.text);
                ccredito:=inttostr(FPlano.GetContaExportacao( outraconta ,EdUnid_codigo.text));
              end else if (outraconta>0) and (unidadetransacao<>EdUnid_codigo.text) then begin
                  credito:=Global.ContaCTbTransNume;
                  ccredito:=inttostr(credito);
              end;
            end;

// 13.04.07 - Baixa de clientes - para NAO usar a conta contabil pela conta de despesa informada na baixa
// 18.06.07 - para usar a conta do cadastro de clientes
//            if Global.Topicos[1253] then begin
// 27.07.09
            if ( ( Global.Topicos[1253] ) and ( Global.CodPendenciaFinanceira=Q.fieldbyname('movf_tipomov').asstring ) )
            then begin
//               codforne:=Buscafornecedor(Q.fieldbyname('movf_transacao').asstring,tipocad);
// 15.02.17
               codforne:=Q.fieldbyname('movf_tipo_codigo').asinteger;
               tipocad:=Q.fieldbyname('movf_tipocad').asstring;
               if codforne>0 then begin
                 if tipocad='C' then begin
//                   credito:=FCadcli.GetContaExp(codforne)
                   if EdMesano.isempty then begin   // 17.03.08 - vanessa - novicarnes - checa se � baixa de pendecia de venda a associado
                     credito:=FCadcli.GetContaExp(codforne,'','XX');
                     ccredito:=FCadcli.GetCnpjCpf(codforne,'N');
// 03.06.15 - Novicarnes - Leonir - lan�ar a baixa de venda a associado no ativo usando o campo conta01 do cad. de cliente
                   end else if FCadcli.Getecooperado(codforne) then begin
                     credito:=FCadcli.GetContaExp(codforne,EdUnid_codigo.text,'XY');
                     ccredito:=FCadcli.GetCnpjCpf(codforne,'N');
                   end else begin
                     credito:=FCadcli.GetContaExp(codforne,EdUnid_codigo.text);
                     ccredito:=FCadcli.GetCnpjCpf(codforne,'N');
                   end;
                 end else if tipocad='F' then begin
                   credito:=FFornece.GetContaExp(codforne,Q.fieldbyname('movf_unid_codigo').asstring);
                   ccredito:=FFornece.GetCnpjCpf(codforne,'N');
                 end;
//              end else if codforne=-1 then begin  // baixou mais de um cli/for na baixa
// 11.07.17
              end else if codforne=0 then begin  // baixou mais de um cli/for na baixa
                 credito:=-2;
                 ccredito:='';  // 21.03.16
               end;
            end else begin
              if Global.CodPendenciaFinanceira=Q.fieldbyname('movf_tipomov').asstring then begin
                credito:=EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asinteger;
// 21.03.16
                if EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asinteger>0 then
                  ccredito:=EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asstring
                else
                  ccredito:='';
              end;
            end;

// 04.04.05 - VER para depois mudar para usar o tipomov do movfin
            {
            if pos( 'Juros Recebidos',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString  ) >0 then begin
              credito:=FPlano.getContaJuros(Q.fieldbyname('movf_plan_conta').asinteger);
// 24.10.16 - vida nova
              ListaJuros.add( Q.fieldbyname('movf_operacao').asstring );
// 07.10.16
              QJuros:=sqltoquery('select * from movfin  where movf_transacao='+stringtosql(Q.fieldbyname('movf_transacao').asstring));
              if QJuros.RecordCount>3 then begin
                credito:=0;
                ccredito:='';
              end;
              QJuros.close;
              }
/////////////////
// 09.08.16
            if Q.fieldbyname('movf_tipomov').asstring=Global.CodJurosRecebidos then begin
              credito:=FPlano.getContaJuros(Q.fieldbyname('movf_plan_conta').asinteger);
// 24.10.16 - vida nova
              ListaJuros.add( Q.fieldbyname('movf_operacao').asstring );
            end else if Q.fieldbyname('movf_tipomov').asstring=Global.CodDescontosDados then begin
              credito:=FPlano.getContaDescontos(Q.fieldbyname('movf_plan_conta').asinteger);
///////////////////////////
            end else if pos( 'Descontos Concedidos',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then begin
              credito:=FPlano.getContaDescontos(Q.fieldbyname('movf_plan_conta').asinteger) ;
// 10.10.16
              QDescontos:=sqltoquery('select * from movfin  where movf_transacao='+stringtosql(Q.fieldbyname('movf_transacao').asstring));
              if QDescontos.RecordCount>3 then begin
                credito:=0;
                ccredito:='';
              end;
              QDescontos.close;
// 28.11.05 - para as baixas de tarifa sem conta de receita / despesa
            end else if pos( 'Tarifa ban',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then
               credito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text)
//            else if pos( 'Devolu',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then
//             credito:=EdUnid_codigo.resultfind.fieldbyname('unid_devovenda').asinteger
//            else if pos( 'Transfer',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then
//              credito:=Global.ContaCTbTransNume
            else if pos( 'Extorno',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then
              credito:=EdUnid_codigo.resultfind.fieldbyname('Unid_vendaavista').asinteger
// 28.09.05
            else if pos( 'Saque',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then begin
               credito:=FPlano.GetContaExportacao(GetOutraConta(Q.fieldbyname('movf_plan_conta').asinteger,Q.fieldbyname('movf_transacao').asstring),EdUnid_codigo.text);
               debito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
            end;
// 05.10.05 - 07.10.16 - juros recebidos
///////////////////////////////
            if (credito=0) and (Q.fieldbyname('movf_plan_contard').asinteger>0) and (Q.fieldbyname('movf_tipomov').asstring<>Global.CodJurosRecebidos) then begin
              credito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text);
              ccredito:=inttostr(FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text));
            end;
// 22.05.09 - para nao permitir exportar 'conta 20001'
////////////////////////////////////////////
             if trim(ContasBloqueadas)<>'' then begin
               if FGeral.ContaBloqueada(debito,ContasBloqueadas)  then
                 debito:=-1;
               if FGeral.ContaBloqueada(credito,ContasBloqueadas)  then
                 credito:=-1;
             end;
//////////////////
// 25.11.09 - ajustes para fazer multiplo com um lan�amento no caixa/banco e diversos em
//          cada cliente ou fornecedor
//////////////////
            if (debito=0) or (credito=0) then
//               Texto.lines.add(' transacao '+Q.fieldbyname('movf_transacao').asstring+' dia '+Q.fieldbyname('movf_datamvto').asstring+' d�bito '+inttostr(debito)+' cr�dito '+inttostr(credito));
               Texto.lines.add('Ent.op. '+Q.fieldbyname('movf_operacao').asstring+' dia '+
                            Q.fieldbyname('movf_datamvto').asstring+' d�bito '+inttostr(debito)+
                            ' cr�dito '+inttostr(credito)+' conta '+Q.fieldbyname('movf_plan_conta').asstring+
                            ' doc '+Q.fieldbyname('movf_numerodcto').asstring+
                            ' codigo '+inttostr(codforne)+' - '+tipocad+
                            ' rec/des. '+Q.fieldbyname('movf_plan_contard').Asstring+
                            ' hist�rico '+copy(Q.fieldbyname('movf_complemento').asstring,1,30));

////////////////////////////////////////////////////////////////////////////////
        end else begin   // Saidas do caixa/bancos
////////////////////////////////////////////////////////////////////////////////

            credito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
            ccredito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asstring;

// 21.10.05
            if Q.fieldbyname('movf_plan_conta').asinteger<>CaixaFilial then begin
               credito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text);
               ccredito:=inttostr(FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text));

           end;
/////////////////////

            if Q.fieldbyname('movf_plan_contard').asinteger>0 then begin
//              if not Global.Topicos[1259] then begin  // 12.11.08
                debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text);
                cdebito:=inttostr(FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text));
  // 14.08.08 - carli
                if debito=credito then begin
                  debito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asinteger;
                  cdebito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asstring;
                end;
  // 18.04.08 - conta de compensacao de cheques
                if (Q.fieldbyname('movf_plan_contard').asinteger=FGeral.GetConfig1AsInteger('Ctacheacompensar')) then begin

                  if ( not FPlano.EContachequeacompensar(Q.fieldbyname('movf_plan_conta').asinteger) ) then begin

                    credito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text);
                    debito:=FPlano.GetContaExportacao( FPlano.GetContaCompensacao(Q.fieldbyname('movf_plan_conta').asinteger),EdUnid_codigo.text);
                    ccredito:=inttostr(FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text));
                    cdebito:=inttostr(FPlano.GetContaExportacao( FPlano.GetContaCompensacao(Q.fieldbyname('movf_plan_conta').asinteger),EdUnid_codigo.text));

                  end;

                end;
//              end else
//                debito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asinteger;

            end else begin

              debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text);
              cdebito:=inttostr(FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text));
// 26.02.10 Capeg
// 26.06.12 - Vida Nova - colocado compra de produtor
              if ( pos(Q.fieldbyname('movf_tipomov').asstring,Global.CodCompra+';'+Global.CodCompraMatConsumo+';'+Global.CodCompra100+';'+Global.CodCompraProdutor)>0  )
                 and ( Q.fieldbyname('movf_plan_conta').asinteger=CaixaFilial ) then begin
                debito:=EdUnid_codigo.resultfind.fieldbyname('unid_comprasavista').asinteger;
                cdebito:=EdUnid_codigo.resultfind.fieldbyname('unid_comprasavista').asstring;
// 13.02.2022 - Devereda - Arquivo OFX
              end else if copy(Q.FieldByName('movf_transacaocontax').AsString,1,3)='OFX' then begin
                debito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asinteger;
                cdebito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asstring;
// 14.02.2023 - Devereda - ofx
                if ( Global.Topicos[1253] ) and ( Q.fieldbyname('movf_tipo_codigo').asinteger>0 ) then begin

                   codforne:=Q.fieldbyname('movf_tipo_codigo').asinteger;
                   if Q.fieldbyname('movf_tipocad').asstring='C' then begin
                     if FCadcli.Getecooperado(codforne) then begin
                       debito:=FCadcli.GetContaExp(codforne,EdUnid_codigo.text,'XY');
                       cdebito:=FCadcli.GetCnpjCpf(codforne,'N');
                     end else begin
                       debito:=FCadcli.GetContaExp(codforne,EdUnid_codigo.text);
                       cdebito:=FCadcli.GetCnpjCpf(codforne,'N');
                     end;
                   end else if Q.fieldbyname('movf_tipocad').asstring='F' then begin
                     debito:=FFornece.GetContaExp(codforne,Q.fieldbyname('movf_unid_codigo').asstring);
                     cdebito:=FFornece.GetCnpjCpf(codforne,'N');
                   end;

                end;

              end;

// 02.11.07 - transferencias  - quando primeiro � 'encontrado' a saida e nao a entrada...
// 07.11.07 - retirado pois dobra as outras transf. feitas pela entrada
// 21.08.08 - carli - recolocado - retirado
              if (debito=credito) and ( Transacaonaofeita(Q.fieldbyname('movf_transacao').asstring) ) then begin
                outraconta:=GetOutraconta(Q.fieldbyname('movf_plan_conta').asinteger,Q.fieldbyname('movf_transacao').asstring,
                          Q.fieldbyname('movf_datamvto').asdatetime,Q.fieldbyname('movf_valorger').ascurrency,
                          Q.fieldbyname('movf_numerodcto').asstring);
// 20.01.17
                unidadetransacao:=GetOutraUnidade(Q.fieldbyname('movf_plan_conta').asinteger,Q.fieldbyname('movf_transacao').asstring);
                if (outraconta>0) and (unidadetransacao=EdUnid_codigo.text) then begin
                  debito:=FPlano.GetContaExportacao( outraconta ,EdUnid_codigo.text);
                  cdebito:=inttostr(FPlano.GetContaExportacao( outraconta ,EdUnid_codigo.text));
                end else if (outraconta>0) and (unidadetransacao<>EdUnid_codigo.text) then begin
                  debito:=Global.ContaCTbTransNume;
                  cdebito:=inttostr(debito);
                end;
              end;
///////////////
            end;
// 20.08.05 - Baixa de fornecedores
////////////////////////////////////////
            if Global.CodPendenciaFinanceira=Q.fieldbyname('movf_tipomov').asstring then begin

               if Global.Topicos[1259] then begin  // 12.11.08 - vims

                 if not Provisionado(Q.fieldbyname('movf_transacao').asstring) then begin  // 19.11.08
                   codforne:=Buscafornecedor(Q.fieldbyname('movf_transacao').asstring,tipocad);
                   if codforne>0 then begin
                     if tipocad='C' then begin
// 24.04.19 - Contas P-Cedula de Produtor Rural
                       if Q.FieldByName('plan_tipo').AsString='P' then begin

                          debito:=99999;  // para q logo abaixo busque a conta contabil da conta 'P'

                       end else begin

                         debito:=FCadcli.GetContaExp(codforne,q.fieldbyname('movf_unid_codigo').asstring);
                         cdebito:=FCadcli.GetCnpjCpf(codforne,'N');

                       end;
// 23.04.10 - Abra
                     end else if tipocad='R' then begin
                       debito:=FRepresentantes.GetContaExp(codforne,q.fieldbyname('movf_unid_codigo').asstring);
                       cdebito:=inttostr(debito);
                     end else begin
                       debito:=FFornece.GetContaExp(codforne,q.fieldbyname('movf_unid_codigo').asstring);
                       cdebito:=FFornece.GetCnpjCpf(codforne,'N');
                     end;
    // 19.07.07
                     if debito=99999 then begin
                       if Q.fieldbyname('movf_plan_contard').asinteger>0 then
                         debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text)
                       else
                         debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text);
                       cdebito:=inttostr(debito);
                     end;
    //////////////////////
//                   end else
                   end else if codforne=-1 then begin  // baixou mais de um cli/for na baixa.25.11.09
                     debito:=-2;
                     cdebito:='';   // 21.03.16
                   end else
                     debito:=0;
// 01.09.09 - baixa de lan�amentos ref. adiantamento de salarios...'trato vip' - Abra - Ligiane
                   if (Q.fieldbyname('movf_plan_conta').asinteger=FGeral.GetConfig1AsInteger('Ctaadiansalario')) and
                     ( FGeral.GetConfig1AsInteger('Ctaadiansalario')>0 ) and
                      ( Q.fieldbyname('movf_plan_contard').asinteger>0 )then
                        debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text);
/////////////////////////////////
                 end else begin

                   debito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asinteger;
                   cdebito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asstring;

                 end;

               end else begin

//                   codforne:=Buscafornecedor(Q.fieldbyname('movf_transacao').asstring,tipocad);
// 16.10.19 - Novicarnes - Simone
                   codforne:=Q.fieldbyname('movf_tipo_codigo').asinteger;
                   tipocad :=Q.fieldbyname('movf_tipocad').asstring;
//
                   if codforne>0 then begin

                     if tipocad='C' then begin

                       tipomovnota:=BuscaTipoMov(Q.fieldbyname('movf_transacao').asstring);
// 15.04.09 - novicarnes - vanessa
                       if tipomovnota=Global.CodDevolucaoVenda then begin
                         debito:=FCadcli.GetContaExpDevVenda(codforne,q.fieldbyname('movf_unid_codigo').asstring);
                         cdebito:=FCadcli.GetCnpjCpf(codforne,'N');
                       end else begin
                         debito:=FCadcli.GetContaExp(codforne,q.fieldbyname('movf_unid_codigo').asstring,'',tipomovnota);
                         cdebito:=FCadcli.GetCnpjCpf(codforne,'N');
                       end;
// 23.04.10 - Abra
                     end else if tipocad='R' then begin
                       debito:=FRepresentantes.GetContaExp(codforne,q.fieldbyname('movf_unid_codigo').asstring)
/////////////////////////////////
                     end else begin

                       if BaixadeCPR( q.fieldbyname('movf_transacao').asstring ) then begin

                         debito:=FFornece.GetContaExp(codforne,q.fieldbyname('movf_unid_codigo').asstring);
                         cdebito:=FFornece.GetCnpjCpf(codforne,'N');

                       end else begin

                         debito:=FFornece.GetContaExp(codforne,q.fieldbyname('movf_unid_codigo').asstring);
                         cdebito:=FFornece.GetCnpjCpf(codforne,'N');

                       end;

                     end;
                     if debito=99999 then begin
                       if Q.fieldbyname('movf_plan_contard').asinteger>0 then
                         debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text)
                       else
                         debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text);
                       cdebito:=inttostr(debito);
                     end;
                   end else if codforne=-1 then begin  // baixou mais de um cli/for na baixa.25.11.09
                     debito:=-2;
                     cdebito:='';    // 21.03.16
                   end;
// 01.09.09 - baixa de lan�amentos ref. adiantamento de salarios...'trato vip' - Abra - Ligiane
                   if (Q.fieldbyname('movf_plan_conta').asinteger=FGeral.GetConfig1AsInteger('Ctaadiansalario')) and
                     ( FGeral.GetConfig1AsInteger('Ctaadiansalario')>0 ) and
                      ( Q.fieldbyname('movf_plan_contard').asinteger>0 )then
                        debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text);
/////////////////////////////////

               end;
            end;  // se for 'PF'..
{
// 18.06.07 - para usar a conta do cadastro de clientes
            if ( Global.Topicos[1253] ) and (debito=0) then begin
               codforne:=Buscafornecedor(Q.fieldbyname('movf_transacao').asstring);
               if codforne>0 then
                 debito:=FFornece.GetContaExp(codforne,q.fieldbyname('movf_unid_codigo').asstring)
               else debito:=0;
            end;
}

// 04.04.05
{
            if pos( 'Juros Recebidos',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then begin
              debito:=FPlano.getContaJuros(Q.fieldbyname('movf_plan_conta').asinteger);
              cdebito:=inttostr(debito);
// 24.10.16 - vida nova
              ListaJuros.add( Q.fieldbyname('movf_operacao').asstring );
              }
            if pos( 'Descontos Obtidos',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then begin
              debito:=FPlano.getContaDescontos(Q.fieldbyname('movf_plan_conta').asinteger);
              cdebito:=inttostr(debito);
//            else if pos( 'Devolu',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then
//              debito:=EdUnid_codigo.resultfind.fieldbyname('unid_devovenda').asinteger
//            else if pos( 'Transfer',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then
//              debito:=Global.ContaCTbTransNume
            end else if pos( 'Extorno',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then begin
              debito:=EdUnid_codigo.resultfind.fieldbyname('Unid_vendaavista').asinteger;
              cdebito:=inttostr(debito);
// 21.10.05
            end else if pos( 'Descontos Concedidos',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then begin
//               debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text);
// 10.08.16
               debito:=FPlano.GetContaDescontos(Q.fieldbyname('movf_plan_conta').asinteger);
               credito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text);
               cdebito:=inttostr(debito);
               ccredito:=inttostr(credito);
// 28.11.05 - para as baixas de tarifa sem conta de receita / despesa
            end else if pos( 'Tarifa ban',FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString ) >0 then begin
               if Q.fieldbyname('movf_plan_contard').asinteger>0 then
                 debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text)
               else
                 debito:=FPlano.getContaDescontos(Q.fieldbyname('movf_plan_conta').asinteger);
               credito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').asinteger,EdUnid_codigo.text);
               cdebito:=inttostr(debito);
               ccredito:=inttostr(credito);
            end;
// 05.10.05
///////////////////////////////                                                 // 02.03.16  - Questor
            if (debito=0) and (Q.fieldbyname('movf_plan_contard').asinteger>0) and (EdSistema.text<>'04' ) then begin
              debito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_contard').asinteger,EdUnid_codigo.text);
              cdebito:=inttostr(debito);
            end;
// 21.03.15
           if trim(ccredito)='0' then ccredito:='';
           if trim(cdebito)='0' then cdebito:='';
////////////////////////////////////////////////
// 22.05.09 - para nao permitir exportar 'conta 20001'
             if trim(ContasBloqueadas)<>'' then begin
               if FGeral.ContaBloqueada(debito,ContasBloqueadas)  then
                 debito:=-1;
               if FGeral.ContaBloqueada(credito,ContasBloqueadas)  then
                 credito:=-1;
             end;
//////////////////
            if ( (debito=0) or (credito=0) ) and ( EdSistema.text<>'04'  ) then
               Texto.lines.add('Sai.op. '+Q.fieldbyname('movf_operacao').asstring+' dia '+
                Q.fieldbyname('movf_datamvto').asstring+' d�bito '+inttostr(debito)+' cr�dito '+inttostr(credito)+
                ' conta '+Q.fieldbyname('movf_plan_conta').asstring+
                ' doc '+Q.fieldbyname('movf_numerodcto').asstring+
                ' codigo '+inttostr(codforne)+' - '+tipocad+
                ' rec/des. '+Q.fieldbyname('movf_plan_contard').Asstring+
                ' hist�rico '+copy(Q.fieldbyname('movf_complemento').asstring,1,30) )
// 16.05.11 - Novi - Vava - posto e retirado senao fica aparecendo as transferencias..
///////////////
{

            else  if ( (debito=credito) and (debito>0) and (credito>0) )
                 or
                  (  (debito=0) or (credito=0) )
                 then
                 Texto.lines.add('Sai.op. '+Q.fieldbyname('movf_operacao').asstring+' dia '+
                  Q.fieldbyname('movf_datamvto').asstring+' d�bito '+inttostr(debito)+' cr�dito '+inttostr(credito)+
                  ' conta '+Q.fieldbyname('movf_plan_conta').asstring+
                  ' doc '+Q.fieldbyname('movf_numerodcto').asstring+
                  ' codigo '+inttostr(codforne)+' - '+tipocad+
                  ' rec/des. '+Q.fieldbyname('movf_plan_contard').Asstring+
                  ' hist�rico '+copy(Q.fieldbyname('movf_complemento').asstring,1,30) )
//                  }
///////////////


        end;
// se for o caixa da unidade....separa os lancamentos da conta caixa somente
// 08.11.04
// 05.04.05 - retirado
//        if Q.fieldbyname('movf_plan_conta').asinteger=EdUnid_codigo.resultfind.fieldbyname('Unid_contacontabil').asinteger then begin
//          if Q.fieldbyname('movf_datacont').asdatetime>1 then begin
//            empresa:=EdUNid_codigo.resultfind.fieldbyname('unid_empresa1').asinteger;
//            filial:=EdUNid_codigo.resultfind.fieldbyname('unid_filial1').asinteger;
//          end else begin
//            empresa:=EdUNid_codigo.resultfind.fieldbyname('unid_empresa2').asinteger;
//            filial:=EdUNid_codigo.resultfind.fieldbyname('unid_filial2').asinteger;
//          end;
//        end;
// 21.03.15
           if trim(ccredito)='0' then ccredito:='';
           if trim(cdebito)='0' then cdebito:='';
////////////////////
        if ( (debito>0) and (credito>0) ) or ( (cdebito<>'') and (ccredito<>'') ) then begin
          if ( (debito<=99999) and (credito<=99999) and (Debito<>credito)  and (EdSistema.text='02') ) or
             ( (Debito<>credito)  and (EdSistema.text<>'02') ) then begin
             if Q.fieldbyname('movf_datamvto').Asdatetime>1 then begin
              datamvto:=Q.fieldbyname('movf_datamvto').Asdatetime;
            end else begin
              Texto.lines.add(' opera��o '+Q.fieldbyname('movf_operacao').asstring+' com problemas na data.  Lan�ado na data final');
              datamvto:=EdTermino.asdate;
            end;
              if ( Q.FieldByName('movf_hist_codigo').AsInteger>0 ) and ( EdSistema.text<>'04' ) then begin   // 15.05.17
                historico:=strspace(FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString,maximocomple);
              end else begin
                historico:=strspace(Q.FieldByName('movf_complemento').AsString,maximocomple);
              end;
            valortotal:=valortotal+Q.fieldbyname('movf_valorger').Ascurrency;
// 07.10.05
            if Q.FieldByName('movf_es').AsString='E' then
              vlrentradas:=vlrentradas+Q.fieldbyname('movf_valorger').Ascurrency
            else
              vlrsaidas:=vlrsaidas+Q.fieldbyname('movf_valorger').Ascurrency;
//            Somatotais(Q.fieldbyname('movf_tipomov').Asstring,dbfexp.fieldbyname('valor').ascurrency);
            Somatotais(Q.fieldbyname('movf_tipomov').Asstring,Q.fieldbyname('movf_valorger').Ascurrency);


            if EdSistema.text='02' then begin   // viasoft
              linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                   strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                   strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(Q.fieldbyname('movf_valorger').Ascurrency,14,2)+
                   space(03)+strspace(historico,160);

            end else if EdSistema.text='03' then begin   // erpesc

//              linha:=strzero(empresa,3)+';'+strzero(filial,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
// 19.06.07 - so para nao mudar no erpesc
              linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                   strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                   strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(Q.fieldbyname('movf_valorger').Ascurrency,14,2)+';'+
                   space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('movf_numerodcto').AsString+';'+
                   Q.fieldbyname('movf_plan_conta').AsString+';'+Q.fieldbyname('movf_plan_contard').AsString+';'+
                   Q.fieldbyname('movf_es').AsString+';'+Q.fieldbyname('movf_transacao').AsString+';'+
                   Q.fieldbyname('movf_tipomov').AsString+';'+
                   Q.fieldbyname('movf_tipo_codigo').AsString;
// 25.09.18 - Seip
            end else if EdSistema.text='05' then begin   // SAGE

              linha:=strzero(datetodia(datamvto),2)+'/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                   strzero(debito,7)+';'+strzero(credito,7)+';'+Formatovalorcomponto(Q.fieldbyname('movf_valorger').Ascurrency,14,2)+';'+
                   strspace(historico,160);

// 25.02.10 - Abra
            end else if EdSistema.text='04' then begin   // Questor
{
                linha:=strzero(empresa,3)+','+strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+','+
                      strzero(debito,7)+','+strzero(credito,7)+','+Formatovalorcomponto(Q.fieldbyname('movf_valorger').Ascurrency,14,2)+','+
                      '0'+',"'+trim(historico)+'"';
}
// 02.03.16 - questor nova versao escritorio erenita
//                linha:=strzero(empresa,3)+';'+strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+';'+
//                      cdebito+';'+ccredito+';'+Valortosql(Q.fieldbyname('movf_valorger').Ascurrency)+';'+
//                      '0'+';"'+trim(historico)+'"';
// 23.03.16 - questor nova ordem..escritorio erenita
                linha:='C'+';'+FGeral.Formatacnpjcpf(EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').AsString)+';'+
                      FormatDateTime('dd/mm/yyyy',datamvto)+';'+
                      Q.fieldbyname('movf_numerodcto').asstring+';'+
                      cdebito+';'+
                      ccredito+';'+
                      Valortosql(Q.fieldbyname('movf_valorger').Ascurrency)+';'+
                      '0'+
//                      ';"'+trim(historico)+'";';
// 15.05.17 - Lucas pediu ajuste
                      ';'+trim(historico)+';';

            end else begin  // '01' - ph
              linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                     Formatovalorcomponto(Q.fieldbyname('movf_valorger').Ascurrency,17,2)+
                     strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                     strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)
            end;
// 15.09.16
//            if Q.fieldbyname('movf_tipomov').asstring<>Global.CodJurosRecebidos then
//////////              ListaT.add(Q.fieldbyname('movf_transacao').AsString);
// 24.10.16
//                  if Q.fieldbyname('movf_tipomov').asstring=Global.CodJurosRecebidos then begin
// 14.02.17 -
//                    if ListaJuros.IndexOf(Q.fieldbyname('movf_operacao').asstring )=-1 then begin
//                      Writeln(Arquivo,linha);
 //                     ListaJuros.add( Q.fieldbyname('movf_operacao').asstring );
//                    end;
//                  end else
// 15.02.17 - Novicarnes - para nao dobrar transferencias
               if Q.fieldbyname('movf_tipomov').AsString=Global.CodLanCaixabancos then begin
                 if Transacaonaofeita(Q.fieldbyname('movf_transacao').AsString) then begin
                    Writeln(Arquivo,linha);
                    ListaT.add(Q.fieldbyname('movf_transacao').AsString);
                 end;
               end else
                    Writeln(Arquivo,linha);

            inc(n);
                      // 24.05.09
          end else if debito<>credito then begin

            Texto.lines.add(' debito '+inttostr(debito)+' credito '+inttostr(credito)+'. Conta rec/des. '+Q.fieldbyname('movf_plan_contard').Asstring+
                            ' Conta '+Q.fieldbyname('movf_plan_conta').Asstring+' op.'+Q.fieldbyname('movf_operacao').asstring+
                            ' Data :'+Q.fieldbyname('movf_datamvto').Asstring+
                            ' Hist : '+FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString);
// 24.05.09////////////////////////////////
          end else if ( (debito=-1) or (credito=-1) ) and (trim(EdMesano.text)<>'') then begin
            Texto.lines.add('D:'+inttostr(debito)+' C:'+inttostr(credito)+' doc. '+Q.fieldbyname('movf_numerodcto').Asstring+
               ' '+Q.fieldbyname('movf_tipocad').AsString+':'+Q.fieldbyname('movf_tipo_codigo').Asstring+' '+copy(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('movf_tipo_codigo').AsInteger,Q.fieldbyname('movf_tipocad').AsString,'R'),1,30)+
              ' sem conta' );

// 13.02.18 - devolucao de venda com nota emitida pelo cliente - Vida nova////////////////////////////////
          end else if ( (debito=credito) and (credito>0) ) and (trim(EdMesano.text)<>'')
                      and ( Q.fieldbyname('movf_plan_contard').AsInteger>0 )
            then begin

            Texto.lines.add(' debito '+inttostr(debito)+' credito '+inttostr(credito)+'. Conta rec/des. '+Q.fieldbyname('movf_plan_contard').Asstring+
                            ' Conta '+Q.fieldbyname('movf_plan_conta').Asstring+' op.'+Q.fieldbyname('movf_operacao').asstring+
                            ' Data :'+Q.fieldbyname('movf_datamvto').Asstring+
                            ' Hist : '+FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString);

          end;
//        end ; // (debito>0) and (credito>0)  // 24.05.09
        end else if ( (debito=-1) or (credito=-1) ) and (trim(EdMesano.text)<>'') then begin
            Texto.lines.add('D:'+inttostr(debito)+' C:'+inttostr(credito)+' doc. '+Q.fieldbyname('movf_numerodcto').Asstring+
               ' '+Q.fieldbyname('movf_tipocad').AsString+':'+Q.fieldbyname('movf_tipo_codigo').Asstring+' '+copy(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('movf_tipo_codigo').AsInteger,Q.fieldbyname('movf_tipocad').AsString,'R'),1,30)+
              ' sem conta' );
// 25.11.09 - lan�amento ref. baixa multipla diversos clientes OU fornecedores
///////////////////////////////////////////////////////////////////
        end else if ( debito=-2 ) or ( credito=-2 ) then begin
///////////////////////////////////////////////////////////////////

           if credito=-2 then begin  // diversos clientes
//              fazer o debito no caixa/bancos
                valortotalcreditos:=0;
                xdebito:=debito;
{
                if Q.FieldByName('movf_hist_codigo').AsInteger>0 then begin
                   historico:=strspace(FHistoricos.GetDescricao(Q.FieldByName('movf_hist_codigo').AsInteger)+' '+Q.FieldByName('movf_complemento').AsString,maximocomple);
                end else begin
                  historico:=strspace(Q.FieldByName('movf_complemento').AsString,maximocomple);
                end;
}
// 07.12.09

                if Q.fieldbyname('movf_datamvto').Asdatetime>1 then begin
                  datamvto:=Q.fieldbyname('movf_datamvto').Asdatetime;
                end else begin
                  Texto.lines.add(' opera��o '+Q.fieldbyname('movf_operacao').asstring+' com problemas na data.  Lan�ado na data final');
                  datamvto:=EdTermino.asdate;
                end;
                debito:=0;
////////////////////////////////////////////////////////////////////

// 10.08.16 // busca todos os clientes baixados na mesma transacao
                if TransacaoNaoFeita( Q.fieldbyname('movf_transacao').asstring ) then begin
                  QPend:=sqltoquery('select pend_tipo_codigo,pend_valor,pend_numerodcto,clie_razaosocial from pendencias'+
                      ' inner join clientes on ( clie_codigo = pend_tipo_codigo )'+
                      ' where pend_transbaixa='+stringtosql(Q.fieldbyname('movf_transacao').asstring)+
                      ' and pend_status<>''C''');
                  while not QPend.eof do begin
                    credito:=FCadcli.GetContaExp(QPend.fieldbyname('pend_tipo_codigo').asinteger,Q.fieldbyname('movf_unid_codigo').asstring);
                    if Credito=0 then
                      Avisoerro('Cliente codigo '+inttostr(QPend.fieldbyname('pend_tipo_codigo').asinteger)+' sem conta configurada na unidade '+Q.fieldbyname('movf_unid_codigo').asstring);
                    linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                       strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                       strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(QPend.fieldbyname('pend_valor').ascurrency,14,2)+';'+
  //                     space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('movf_numerodcto').AsString+';'+
  // 08.08.16
                       space(03)+';'+strspace(QPend.fieldbyname('pend_numerodcto').AsString+' '+QPend.fieldbyname('clie_razaosocial').AsString,160)+';'+QPend.fieldbyname('pend_numerodcto').AsString+';'+
                       Q.fieldbyname('movf_plan_conta').AsString+';'+Q.fieldbyname('movf_plan_contard').AsString+';'+
                       Q.fieldbyname('movf_es').AsString+';'+Q.fieldbyname('movf_transacao').AsString+';'+
                       Q.fieldbyname('movf_tipomov').AsString+';'+
                       Q.fieldbyname('movf_tipo_codigo').AsString;
                    Writeln(Arquivo,linha);
                    valortotalcreditos:=valortotalcreditos + QPend.fieldbyname('pend_valor').ascurrency;
                    inc(n);

// 15.09.16 - buscar os juros q houverem na transacao mas de cada documento
/////////////////////////////////////////////////////////////////////////
//                     {
                    if not Global.Topicos[1046] then begin
                    //////////////////////////
                      QJuros:=sqltoquery('select * from movfin  where movf_transacao='+stringtosql(Q.fieldbyname('movf_transacao').asstring)+
                                         ' and movf_numerodcto = '+Stringtosql(QPend.fieldbyname('pend_numerodcto').asstring)+
                                         ' and movf_tipomov = '+Stringtosql(Global.CodJurosRecebidos));
                      if (not QJuros.eof) and (ListaJuros.IndexOf(QJuros.fieldbyname('movf_operacao').asstring)=-1) then begin
                        xdebitomultiplo:=debito;
                        credito:=FPlano.GetContaJuros(Q.fieldbyname('movf_plan_conta').AsInteger);
  // 10.10.16
                        debito:=FPlano.GetContaExportacao(QJuros.fieldbyname('movf_plan_conta').AsInteger,EdUnid_codigo.text);
                        linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                           strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                           strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(QJuros.fieldbyname('movf_valorger').ascurrency,14,2)+';'+
                           space(03)+';'+'Juros '+strspace(QPend.fieldbyname('pend_numerodcto').AsString+' '+QPend.fieldbyname('clie_razaosocial').AsString,160)+';'+
                           QPend.fieldbyname('pend_numerodcto').AsString+';'+
                           QJuros.fieldbyname('movf_plan_conta').AsString+';'+QJuros.fieldbyname('movf_plan_contard').AsString+';'+
                           QJuros.fieldbyname('movf_es').AsString+';'+Q.fieldbyname('movf_transacao').AsString+';'+
                           QJuros.fieldbyname('movf_tipomov').AsString+';'+
                           QJuros.fieldbyname('movf_tipo_codigo').AsString;
                        Writeln(Arquivo,linha);
  //////////////                      valortotalcreditos:=valortotalcreditos + QJuros.fieldbyname('movf_valorger').ascurrency;
                        Somatotais(QJuros.fieldbyname('movf_tipomov').Asstring,QJuros.fieldbyname('movf_valorger').Ascurrency);
                        inc(n);
                        debito:=xdebitomultiplo;
                        ListaJuros.add( QJuros.fieldbyname('movf_operacao').asstring );
                      end;
// 10.11.16 - prever juros ref. duas parcelas pagas no mesmo dia dai fico juros 2 x sobre o mesmo documento....
                      if not QJuros.eof then begin
                         QJuros.Next;
                         if (not QJuros.eof) and (ListaJuros.IndexOf(QJuros.fieldbyname('movf_operacao').asstring)=-1) then begin
                            xdebitomultiplo:=debito;
                            credito:=FPlano.GetContaJuros(Q.fieldbyname('movf_plan_conta').AsInteger);
                            debito:=FPlano.GetContaExportacao(QJuros.fieldbyname('movf_plan_conta').AsInteger,EdUnid_codigo.text);
                            linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                               strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                               strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(QJuros.fieldbyname('movf_valorger').ascurrency,14,2)+';'+
                               space(03)+';'+'Juros '+strspace(QPend.fieldbyname('pend_numerodcto').AsString+' '+QPend.fieldbyname('clie_razaosocial').AsString,160)+';'+
                               QPend.fieldbyname('pend_numerodcto').AsString+';'+
                               QJuros.fieldbyname('movf_plan_conta').AsString+';'+QJuros.fieldbyname('movf_plan_contard').AsString+';'+
                               QJuros.fieldbyname('movf_es').AsString+';'+Q.fieldbyname('movf_transacao').AsString+';'+QJuros.fieldbyname('movf_tipomov').AsString;
                            Writeln(Arquivo,linha);
                            Somatotais(QJuros.fieldbyname('movf_tipomov').Asstring,QJuros.fieldbyname('movf_valorger').Ascurrency);
                            inc(n);
                            debito:=xdebitomultiplo;
                            ListaJuros.add( QJuros.fieldbyname('movf_operacao').asstring );
                         end;
                      end;
                      FGeral.FechaQuery(QJuros);
                    end;
// 10.10.16  - o mesmo com os descontos
// 29.11.16
                    if not Global.Topicos[1046] then begin
                      QJuros:=sqltoquery('select * from movfin  where movf_transacao='+stringtosql(Q.fieldbyname('movf_transacao').asstring)+
                                         ' and movf_numerodcto = '+Stringtosql(QPend.fieldbyname('pend_numerodcto').asstring)+
                                         ' and movf_tipomov = '+Stringtosql(Global.CodDescontosDados));
                      if (not QJuros.eof) and (ListaDescontos.IndexOf(QJuros.fieldbyname('movf_operacao').asstring)=-1) then begin
  //                      credito:=FPlano.GetContaDescontos(Q.fieldbyname('movf_plan_conta').AsInteger);
  // 10.10.16
                        credito:=FPlano.GetContaExportacao(Q.fieldbyname('movf_plan_conta').AsInteger,EdUnid_codigo.text);
                        xdebitomultiplo:=debito;
                        if QJuros.fieldbyname('movf_plan_contard').AsInteger>0 then
                          debito:=FPlano.GetContaDescontos(QJuros.fieldbyname('movf_plan_contard').AsInteger)
                        else
                          debito:=FPlano.GetContaDescontos(QJuros.fieldbyname('movf_plan_conta').AsInteger);
  ///////////////////////////////
                        linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                           strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                           strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(QJuros.fieldbyname('movf_valorger').ascurrency,14,2)+';'+
                           space(03)+';'+'Descontos Concedidos '+strspace(QPend.fieldbyname('pend_numerodcto').AsString+' '+QPend.fieldbyname('clie_razaosocial').AsString,160)+';'+
                           QPend.fieldbyname('pend_numerodcto').AsString+';'+
                           QJuros.fieldbyname('movf_plan_conta').AsString+';'+QJuros.fieldbyname('movf_plan_contard').AsString+';'+
                           QJuros.fieldbyname('movf_es').AsString+';'+Q.fieldbyname('movf_transacao').AsString+';'+
                           QJuros.fieldbyname('movf_tipomov').AsString+';'+
                           QJuros.fieldbyname('movf_tipo_codigo').AsString;
                        Writeln(Arquivo,linha);
  /////////////                      valortotalcreditos:=valortotalcreditos + QJuros.fieldbyname('movf_valorger').ascurrency;
                        Somatotais(QJuros.fieldbyname('movf_tipomov').Asstring,QJuros.fieldbyname('movf_valorger').Ascurrency);
                        inc(n);
                        debito:=xdebitomultiplo;
                        ListaDescontos.add( QJuros.fieldbyname('movf_operacao').asstring );
                      end;
                      FGeral.FechaQuery(QJuros);
                    end;
//
/////////////////////////////////////////////////////////////////////////
                    QPend.Next;
                  end;
                  FGeral.FechaQuery(QPend);


                end;
                /////////////////////////////////////////////
////
                credito:=0;debito:=xdebito;
                historico:='Recebimentos Diversos';
// 10.08.16
                if TransacaoNaoFeita( Q.fieldbyname('movf_transacao').asstring ) then begin
//                     strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(Q.fieldbyname('movf_valorger').Ascurrency,14,2)+';'+
// 08.08.16
                  linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                     strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                     strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valortotalcreditos,14,2)+';'+
                     space(03)+';'+strspace(historico,160)+';'+''+';'+
                     Q.fieldbyname('movf_plan_conta').AsString+';'+Q.fieldbyname('movf_plan_contard').AsString+';'+
//                     Q.fieldbyname('movf_es').AsString+';'+Q.fieldbyname('movf_transacao').AsString;
// 08.08.16
                     'S'+';'+Q.fieldbyname('movf_transacao').AsString+';'+Q.fieldbyname('movf_tipomov').AsString;
                  ListaT.add(Q.fieldbyname('movf_transacao').AsString);
// 24.10.16
                  if Q.fieldbyname('movf_tipomov').asstring=Global.CodJurosRecebidos then begin
// 14.02.17 -
                    if ListaJuros.IndexOf(Q.fieldbyname('movf_operacao').asstring )=-1 then begin
                      Writeln(Arquivo,linha);
                      ListaJuros.add( Q.fieldbyname('movf_operacao').asstring );
                    end;
                  end else
                    Writeln(Arquivo,linha);

                  inc(n);
// 15.09.16
                end;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                 if (Q.fieldbyname('movf_tipomov').AsString=Global.CodJurosRecebidos) and (ListaJuros.indexof(Q.fieldbyname('movf_operacao').asstring)=-1) then begin
                  credito:=FPlano.getContaJuros(Q.fieldbyname('movf_plan_conta').asinteger);
                  linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                     strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                     strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valortotalcreditos,14,2)+';'+
                     space(03)+';'+strspace(historico,160)+';'+''+';'+
                     Q.fieldbyname('movf_plan_conta').AsString+';'+Q.fieldbyname('movf_plan_contard').AsString+';'+
                     'S'+';'+Q.fieldbyname('movf_transacao').AsString+';'+
                     Q.fieldbyname('movf_tipomov').AsString+';'+
                     Q.fieldbyname('movf_tipo_codigo').AsString;
                  ListaT.add(Q.fieldbyname('movf_transacao').AsString);
                  Writeln(Arquivo,linha);
// 24.10.16
                  if Q.fieldbyname('movf_tipomov').asstring=Global.CodJurosRecebidos then
                    ListaJuros.add( Q.fieldbyname('movf_operacao').asstring );
                  inc(n);
                end;

////////////////////////////////////////////////////////////////////////////

           end else begin            // diversos fornecedores

//              fazer o credito no caixa/bancos
                debito:=0;
                cdebito:='';
// 07.12.09
                if Q.fieldbyname('movf_datamvto').Asdatetime>1 then begin
                  datamvto:=Q.fieldbyname('movf_datamvto').Asdatetime;
                end else begin
                  Texto.lines.add(' opera��o '+Q.fieldbyname('movf_operacao').asstring+' com problemas na data.  Lan�ado na data final');
                  datamvto:=EdTermino.asdate;
                end;
//////////////////
                historico:='Pagamentos Diversos';
// 10.08.16
                if TransacaoNaoFeita( Q.fieldbyname('movf_transacao').asstring ) then begin
                  linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                       strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                       strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(Q.fieldbyname('movf_valorger').Ascurrency,14,2)+';'+
                       space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('movf_numerodcto').AsString+';'+
                       Q.fieldbyname('movf_plan_conta').AsString+';'+Q.fieldbyname('movf_plan_contard').AsString+';'+
                       Q.fieldbyname('movf_es').AsString+';'+Q.fieldbyname('movf_transacao').AsString+';'+
                       Q.fieldbyname('movf_tipomov').AsString+';'+
                       Q.fieldbyname('movf_tipo_codigo').AsString;
                  ListaT.add(Q.fieldbyname('movf_transacao').AsString);

 //                 if Q.fieldbyname('movf_tipomov').asstring=Global.CodJurosRecebidos then begin
// 14.02.17 -
//                    if ListaJuros.IndexOf(Q.fieldbyname('movf_operacao').asstring )=-1 then begin
//                      Writeln(Arquivo,linha);
//                      ListaJuros.add( Q.fieldbyname('movf_operacao').asstring );
//                    end;
//                  end else
                    Writeln(Arquivo,linha);
                  inc(n);
                end;

                credito:=0;
// 10.08.16
                if TransacaoNaoFeita( Q.fieldbyname('movf_transacao').asstring ) then begin
                  QPend:=sqltoquery('select pend_tipo_codigo,pend_valor from pendencias'+
                      ' where pend_transbaixa='+stringtosql(Q.fieldbyname('movf_transacao').asstring)+
                      ' and pend_status<>''C''');
                  while not QPend.eof do begin
                    debito:=FFornece.GetContaExp(QPend.fieldbyname('pend_tipo_codigo').asinteger,Q.fieldbyname('movf_unid_codigo').asstring);
                    if debito=0 then
                      Avisoerro('Fornecedor codigo '+inttostr(QPend.fieldbyname('pend_tipo_codigo').asinteger)+' sem conta configurada na unidade '+Q.fieldbyname('movf_unid_codigo').asstring);
                    linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                       strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                       strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(QPend.fieldbyname('pend_valor').ascurrency,14,2)+';'+
                       space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('movf_numerodcto').AsString+';'+
                       Q.fieldbyname('movf_plan_conta').AsString+';'+Q.fieldbyname('movf_plan_contard').AsString+';'+
                       Q.fieldbyname('movf_es').AsString+';'+Q.fieldbyname('movf_transacao').AsString+';'+
                       Q.fieldbyname('movf_tipomov').AsString+';'+
                       Q.fieldbyname('movf_tipo_codigo').AsString;
                    Writeln(Arquivo,linha);
                    inc(n);
                    QPend.Next;
                  end;
                  FGeral.FechaQuery(QPend);
                end;
           end;
        end;

      end;  // if esta valendo

      Q.Next;
    end; // while

  end;
  Q.close;
  Freeandnil(Q);
//  dbfexp.close;
//  dbfexp.Free;

  Closefile(arquivo);
// 21.03.18 - Novicarnes
  if EdSistema.Text='03' then begin

    if (not ChecaValores) and ( Global.Usuario.Codigo<>100 ) then begin
      Avisoerro('Exporta��o cancelada');
//      DeleteFile( EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.txt')
    end;

  end;

  for p:=0 to listatotais.count-1 do begin
    Ptotais:=listatotais[p];
    texto.lines.add('Tipo mov. '+ptotais.tipomov+' '+formatfloat(f_cr,ptotais.valor)+' - '+floattostr(ptotais.quantos)+' dctos.');
  end;
  Texto.lines.add('Entradas '+formatfloat(f_cr,vlrentradas));
  Texto.lines.add('Saidas '+formatfloat(f_cr,vlrsaidas));
  Sistema.endprocess('Exportados '+inttostr(n)+' lan�amentos  Valor '+formatfloat(f_cr,valortotal));

end;

procedure TFExpcaixaban.Execute;
////////////////////////////////////
begin
//  DriveExp:='F:';
  DriveExp:='';
  nomearq:=driveexp+'\VIASOFT\CTB\IMLANCTO.DBF';
  nomearqtexto:='CTBCX';

  if not fileexists( nomearq ) then begin
    DriveExp:='C:';
    nomearq:=DriveExp+'\VIASOFT\CTB\IMLANCTO.DBF';
    if not fileexists( nomearq ) then begin
      DriveExp:='M:';
      nomearq:=DriveExp+'\VIASOFT\CTB\IMLANCTO.DBF';
    end;
  end;
  nomedbf:='IMLANCTO.DBF';
  nomepath:=DriveExp+'\VIASOFT\CTB\';
  nomearqtxt:=DriveExp+'\VIASOFT\CTB\SACCTB.TXT';
{
  if not fileexists(nomearq) then begin
    Avisoerro('N�o encontrado '+nomearq);
    close;
    exit;
  end;
}
  texto.clear;

///////////////////  dbfexp.FileName:=NOMEARQ;
//  try
//    dbfexp.open;
//    if not dbfexp.eof then begin
//      Edinicio.Setdate(dbfexp.FieldByName('dataini').AsDateTime);
//      EdTermino.setdate(dbfexp.FieldByName('datafin').asdatetime);
//    end else begin
      Edinicio.Setdate(Sistema.Hoje);
      EdTermino.setdate(Sistema.hoje);
//    end;
//  except
//    Avisoerro('N�o foi poss�vel abrir o arquivo '+nomearq);
//    close;
//    exit;
//  end;

  Show;
// 19.07.11 trazido aqui do form activate bicheira...
  if not Arq.TPlano.active then Arq.TPlano.open;
  if trim(EdUnid_codigo.text)='' then
    EdUnid_codigo.text:=Global.CodigoUnidade;
  if trim(EdMesano.text)='' then
    EdMesano.text:=strzero(Datetomes(Sistema.hoje),2)+strzero(Datetoano(Sistema.hoje,true),4);
// 30.04.12
  FPlano.SetaItems(EdContas,nil,'M');
  EdContas.enabled:=Global.Usuario.OutrosAcessos[0716];
   FGeral.EstiloForm(FExpcaixaban);
   FGeral.ConfiguraColorEditsNaoEnabled(FExpcaixaban);
   FPlano.SetaItems(EdBanco,EdBanco_descricao,'B','','','S');
  EdInicio.setfocus;
//
end;

procedure TFExpcaixaban.EdUnid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdUnid_codigo,key);
end;

function TFExpcaixaban.Formatovalorcomponto(valor: currency; tamanho,  decimais: integer): string;
//////////////////////////////////////////////////////////////////////////////////////////////////
const zeros:string='0000000000000000000000';
var vlr:string;
begin
  str(valor:tamanho:decimais,vlr);
  vlr:=trim(vlr);
  result:=copy(zeros,1,tamanho-length(vlr))+vlr;
end;

procedure TFExpcaixaban.EdbancoValidate(Sender: TObject);
begin

 QBanco:=sqltoquery('select * from plano where plan_conta='+EdBanco.assql);
 if not QBanco.eof then begin

    EdBanco_descricao.text:=QBanco.fieldbyname('plan_descricao').asstring;
    if trim(QBanco.fieldbyname('Plan_codigobanco').asstring)='' then begin
      EdBAnco.invalid('Codigo do Banco n�o configurado nas contas gerenciais');
      exit;
    end;
 end;
 if Edbanco.isempty then EdTipomov.text:='' else EdTipomov.text:='LC';


end;

procedure TFExpcaixaban.EdSistemaExitEdit(Sender: TObject);
begin
  bExecutarclick(self);
end;

procedure TFExpcaixaban.brelerrosClick(Sender: TObject);
var p:integer;
begin
   FTextrel.Init();
   FTextRel.AddTitulo(Global.NomeSistema+' '+Global.VersaoSistema+space(46)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
   Ftextrel.AddTitulo('Relat�rio de Erros na Exporta��o Cont�bil do Caixa Bancos',false,false,true);
   Ftextrel.AddTitulo('',false,false,false);
//   FTextrel.rel.lines:=Texto.lines;
   for p:=0 to Texto.Lines.Count-1 do begin
     FTExtrel.AddLinha(Texto.Lines.Strings[p],false,false,true);
   end;
   FTextrel.Video;
end;

// 21.03.18
function TFExpcaixaban.ChecaValores:boolean;
///////////////////////////////////////////
var Lista,Listalinha:TStringlist;
    p:integer;
    valord,valorc:currency;

begin

    if EdSistema.text<>'03' then begin
      Avisoerro('Relat�rio dispon�vel somente para exporta��o para o Contax');
      exit;
    end;
    if EdPasta.isempty then begin
      Avisoerro('Informar drive + pasta');
      exit;
    end;
    Lista:=TStringlist.create;
    nomearqtexto:='CTBCX'+FormatDatetime('mmyyyy',EdTermino.Asdate);
    Sistema.beginprocess('Conferindo totais de d�bito e cr�dito');
    try
      Lista.LoadFromFile( EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.txt');
    except
      Avisoerro('Problemas para ler o arquivo '+EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.txt');
      Sistema.endprocess('');
      exit;
    end;
    valord:=0;
    valorc:=0;
    for p:=0 to LIsta.count-1 do begin

      if trim(lista[p])<>'' then begin
        ListaLInha:=TStringlist.create;
        strtolista(Listalinha,Lista[p],';',true);
        if copy(listalinha[06],1,5) = '00000' then  // debito
          valord:=valord + TextToValor(listalinha[10]);
        if copy(listalinha[08],1,5) = '00000' then  // credito
          valorc:=valorc + TextToValor(listalinha[10]);

      end;

    end;
    Sistema.endprocess('');
    lista.free;
    if valorc<>valord then Avisoerro('Aten��o.  Verificar lan�amentos sem conta.    Transa��o com diferen�a de '+FGeral.Formatavalor(abs(valord-valorc),f_cr));
    result:=(valorc=valord);

end;

procedure TFExpcaixaban.bexportadosClick(Sender: TObject);
//////////////////////////////////////////////////////////
var Lista,Listalinha:TStringlist;
    p:integer;
begin
    if EdSistema.text<>'03' then begin
      Avisoerro('Relat�rio dispon�vel somente para exporta��o para o Contax');
      exit;
    end;
    if EdPasta.isempty then begin
      Avisoerro('Informar drive + pasta');
      exit;
    end;
    Lista:=TStringlist.create;
// 10.08.16
    nomearqtexto:='CTBCX'+FormatDatetime('mmyyyy',EdTermino.Asdate);
    Sistema.beginprocess('Lendo arquivo');
    try
      Lista.LoadFromFile( EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.txt');
    except
      Avisoerro('Problemas para ler o arquivo '+EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.txt');
      Sistema.endprocess('');
      exit;
    end;
    if lista.count>0 then begin
      Sistema.beginprocess('Gerando relat�rio');
      FRel.Init('RelExportacaoCaixaBancos');
      FRel.AddTit('Rela��o de Lan�amentos Exportados no arquivo '+EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.txt' );
      FRel.AddCol( 65,1,'D','' ,''              ,'Data'          ,''         ,'',false);
      FRel.AddCol(080,3,'N','+' ,f_cr           ,'Valor'           ,''         ,'',false);
      FRel.AddCol(060,3,'N','' ,''              ,'D�bito'         ,''         ,'',false);
      FRel.AddCol(060,3,'N','' ,''              ,'Cr�dito'         ,''         ,'',false);
      FRel.AddCol(250,1,'C','' ,''              ,'Hist�rico'         ,''         ,'',false);
      FRel.AddCol(060,1,'C','' ,''              ,'Documento'         ,''         ,'',false);
      FRel.AddCol(070,1,'C','' ,''              ,'Caixa/bancos'         ,''         ,'',false);
      FRel.AddCol(070,1,'C','' ,''              ,'Rec./despesa'         ,''         ,'',false);
      FRel.AddCol(040,1,'C','' ,''              ,'E/S'         ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Transa��o'         ,''         ,'',false);
      FRel.AddCol(040,1,'C','' ,''              ,'Tipo'         ,''         ,'',false);
// 10.09.18
      FRel.AddCol(040,1,'C','' ,''              ,'Cli/For'         ,''         ,'',false);
    end;
    for p:=0 to LIsta.count-1 do begin

      if trim(lista[p])<>'' then begin

        ListaLInha:=TStringlist.create;
        strtolista(Listalinha,Lista[p],';',true);
        FRel.AddCel(listalinha[05]+'/'+listalinha[04]+'/'+listalinha[03]);
        FRel.AddCel(listalinha[10]);
        FRel.AddCel(listalinha[06]);
        FRel.AddCel(listalinha[08]);
        FRel.AddCel(listalinha[12]);
        FRel.AddCel(listalinha[13]);
        FRel.AddCel(listalinha[14]);
        FRel.AddCel(listalinha[15]);
        FRel.AddCel(listalinha[16]);
        FRel.AddCel(listalinha[17]);
        FRel.AddCel(listalinha[18]);
        if ListaLInha.Count>=20 then
           FRel.AddCel(listalinha[19])
        else
           FRel.AddCel('');

      end;

    end;
    Sistema.endprocess('');
    if lista.count>0 then
      FRel.Video;
    lista.free;

end;

function TFExpcaixaban.TransacaoNaoFeita(xt: string): boolean;
/////////////////////////////////////////////////////////////
var p:integer;
begin
   result:=true;
/////////////////////
///

   if copy(xt,1,6)='989850' then exit;
   for p:=0 to ListaT.count-1 do begin
     if LIstat[p]=xt then
      result:=false;
   end;

////////////////////////
end;

procedure TFExpcaixaban.EdSistemaValidate(Sender: TObject);
begin
   if (EdSistema.text='03') and (not EdContas.IsEmpty) then
     EdSistema.invalid('Para exportar pro Contax n�o � permitido escolher contas')
   else if EdSistema.text='04' then EdPagRec.enabled:=true else EdPagRec.enabled:=false
end;

end.
