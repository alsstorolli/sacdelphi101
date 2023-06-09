unit baixacob;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, ACBrBase, ACBrBoleto, SqlExpr;

type
  TFBaixaCobranca = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bbaixar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PAcerto: TSQLPanelGrid;
    OpenDialog1: TOpenDialog;
    EdArquivo: TSQLEd;
    bprocurar: TSQLBtn;
    EdNrobloquetes: TSQLEd;
    EdValorpago: TSQLEd;
    EdSeunumero: TSQLEd;
    Edencontrados: TSQLEd;
    Ednaotratados: TSQLEd;
    Edvencimento: TSQLEd;
    bpendentes: TSQLBtn;
    AcbrBoleto1: TACBrBoleto;
    EdDataBaixa: TSQLEd;
    bexclui: TSQLBtn;
    EdBoletosEntrada: TSQLEd;
    EdBoletosEnviados: TSQLEd;
    botaostatus: TBitBtn;
    Edbanco: TSQLEd;
    EdBanco_descricao: TSQLEd;
    procedure bbaixarClick(Sender: TObject);
    procedure bprocurarClick(Sender: TObject);
    procedure EdArquivoValidate(Sender: TObject);
    procedure griddblclick(Sender: TObject);
    procedure EdSeunumeroExitEdit(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure EdSeunumeroValidate(Sender: TObject);
    procedure EdvencimentoExitEdit(Sender: TObject);
    procedure bpendentesClick(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure EdDataBaixaValidate(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure bexcluiClick(Sender: TObject);
    procedure EdbancoValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;

  end;

var
  FBaixaCobranca: TFBaixaCobranca;
  NumeroBanco,unidadetituloachado,transacaocontax,Ocorrencias,sqldatacont:string;
  Banco    :TAcbrBanco;
  Titulo   :TAcbrTitulo;
  DataBaixa,
  BaixaInicial,
  BaixaFinal   :TDatetime;
  QBanco       :TSqlquery;

implementation


uses sqlfun , Geral, Sqlsis , plano, relfinan, Unidades, cadcli;

{$R *.dfm}

{ TFBaixaCobranca }

procedure TFBaixaCobranca.Execute;
/////////////////////////////////
begin
   show;
   Grid.clear;
   FGeral.ConfiguraColorEditsNaoEnabled(FBAixaCobranca);
// 11.02.20
   FPlano.SetaItems(EdBanco,EdBanco_descricao,'B','','','S');
   EdDataBaixa.SetFocus;
//   EdArquivo.setfocus;
   unidadetituloachado:=Global.CodigoUnidade;
   DataBaixa:=Sistema.Hoje;
   EdDataBaixa.setdate(sistema.hoje);
// 13.07.18 - Giacomoni
    if Global.Usuario.OutrosAcessos[0721] then
        sqldatacont:=''
    else
      sqldatacont:=' and pend_datacont > '+DatetoSql(Global.DataMenorBanco);

end;

procedure TFBaixaCobranca.bbaixarClick(Sender: TObject);
///////////////////////////////////////////////////////////////
var Transacao,
    seunumero,
    xsenha ,
    xunidade   :string;
    p,x,contabanco,ContaDesrec,contajuros,contadescontos,contadescontostarifaban,numerodoc,titulosbaixados,
    tipocodigo:integer;
    lista:TStringlist;
    descontos,tarifa,juros,valor:currency;
    vencimento,
    xBaixa:TDatetime;
    complemento,descjuros,descdescontos,motivo,motivos,ocorrencia,cnossonumero:string;
    Q,
    QNN:Tsqlquery;

    Function FaltaCodigoCliente:boolean;
    ////////////////////////////////////
    var i,xcodigo:integer;
        seunumero,numeros,bx:string;
    begin
      result:=false;
      numeros:='';
      for i:=0 to Grid.Rowcount do begin           xcodigo:=Strtointdef( Grid.cells[Grid.getcolumn('pend_tipo_codigo'),i] ,0);
        seunumero:=Grid.cells[Grid.getcolumn('pend_numerodcto'),i];
        bx:=Grid.cells[Grid.getcolumn('clie_nome'),i];
        if (trim(seunumero)<>'') and (xcodigo=0)and (bx<>'J� Baixado')  then
          numeros:=numeros+seunumero+' | ';
      end;
      if trim(numeros)<>'' then begin
          Avisoerro('Falta codigo do cliente no(s) documento(s) '+numeros);
          result:=true;
      end;
    end;

    Function FaltaContaCliente:boolean;
    ////////////////////////////////////
    var i,xcodigo,seunumero:integer;
        numeros,bx:string;

    begin
      result:=false;
      numeros:='';
      for i:=0 to Grid.RowCount do begin
        xcodigo:=Strtointdef( Grid.cells[Grid.getcolumn('pend_tipo_codigo'),i] ,0);
        seunumero:=(FCadCli.GetContaExp( xcodigo,Global.CodigoUnidade));
        bx:=Grid.cells[Grid.getcolumn('clie_nome'),i];
        if (seunumero=0) and (xcodigo>0)and (bx<>'J� Baixado')  then
          numeros:=numeros+inttostr(xcodigo)+' | ';
      end;
      if trim(numeros)<>'' then begin
          Avisoerro('Falta conta cont�bil no(s) cliente(s)  '+numeros);
          result:=true;
      end;
    end;

    function NotasSomadas:string;
    //////////////////////////////
    var QO:TSqlquery;
    begin

       Qo:=sqltoquery('select pend_numerodcto from pendencias where'+
                       ' pend_status=''N'''+
                       ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                       ' and '+FGeral.GetIN('pend_unid_codigo',Global.Usuario.UnidadesMvto,'C')+
                       ' and pend_rp=''R'''+
                       ' and pend_opantecipa = '+Stringtosql(cnossonumero) );
       result:='Notas ';
       while not qo.Eof do begin
          result:=result+Qo.FieldByName('pend_numerodcto').AsString+';';
          qo.Next;
       end;
       FGeral.FechaQuery(Qo);

    end;


begin

  if Edarquivo.isempty then exit;
  ContaBanco := EdBanco.AsInteger;
// 27.05.20


   QBanco:=sqltoquery('select * from plano where plan_conta = '+EdBanco.assql);

//    numerobanco := QBanco.fieldbyname('Plan_codigobanco').asstring

  if QBanco.Eof then begin

     Avisoerro('Conta de banco '+EdBanco.Text+' n�o encontrada');
     Close;
     exit;

  end;

// 03.11.16
  if (Global.topicos[1045]) then begin
    if FaltaCodigocliente then exit;
    if FaltaContaCliente then exit;
  end;

  if Numerobanco='748' then begin

    motivos:='H5,H6,H8,00 A8,X1,X2,X3,X4,X5,X0,X6,X7,X8,X9,XA,XB';
//    ocorrencias:='03,06,09,10,12,13,15,17,19,20,23';
    ocorrencias:='06;07;09';

  end else if Numerobanco='756' then begin

    motivos:='01';
//    ocorrencias:='06';
// 24.04.18 - Vida Nova - titulos q foi pedido a baixa vai sistema do banco
// 26.09.18 - Vida Nova - titulos q foi pedido a baixa via sistema do banco OU  vencido
//            a mais de 180 dias dai nao baixar no SAC pois n�o cai na conta o din din...
//    ocorrencias:='06;09';
    ocorrencias:='06';
// 10.12.18
  end else if Numerobanco='104' then begin

    motivos:='01';
    ocorrencias:='06';
// 30.01.20

  end else if Numerobanco='001' then begin

    motivos:='01';
    ocorrencias:='04;06';

  end else begin

    motivos:='01';
    ocorrencias:='06';

  end;

// 08.11.16 - devido ter q refazer algumas baixas retroativo
  DataBaixa:=EdDatabaixa.asdate;

// 06.01.20 - Vida Nova
  if ( (DataBaixa < (BaixaInicial+1) ) or (DataBaixa > (BaixaFinal+1) ) )
     and ( DatetoAno(BaixaFinal,true ) > 1901 )
     then begin

      Avisoerro( 'ATEN��O !! Data da baixa '+FGeral.FormataData(DataBaixa)+
                 ' est� fora do per�odo '+FGeral.FormataData(baixainicial)+
                 ' a '+FGeral.FormataData(baixafinal)+
                 ' deste arquivo retorno'  );
      if not Input('Autoriza��o necess�ria','Senha',xsenha,10,true )then exit;
      if xsenha<>'85500' then exit;


  end;

  if not confirma('Confirma baixa dos boletos com o SEU NUMERO e VENCIMENTO informado  e com ocorr�ncia(s) '+ocorrencias+' ?') then exit;

  Sistema.begintransaction('Baixando titulos');
  Transacao:=FGeral.gettransacao;
//  ContaDesrec:=Global.ContaDescontosobtidos;
// 08.08.16
  ContaDesrec:=FGeral.GetConfig1AsInteger('Ctabaixarec');
  titulosbaixados:=0;
// 24.09.16
   if (Global.topicos[1045]) then begin
      transacaocontax:=FGeral.GetTransacaoContax(strzero(FUnidades.GetEmpresaContax(Global.codigounidade),3),True);
   end;

  for p:=0 to Grid.rowcount do begin

    seunumero:=Grid.cells[Grid.getcolumn('pend_numerodcto'),p];
    motivo:=copy( Grid.cells[Grid.getcolumn('motivo'),p],1,2);
    ocorrencia:=copy( Grid.cells[Grid.getcolumn('ocorrencia'),p],1,2);
// 16.04.18
    cnossonumero:=trim( Grid.cells[Grid.getcolumn('nossonumero'),p]  );
    valor:= Texttovalor( Grid.cells[Grid.getcolumn('pend_valor'),p] );
// 26.06.18
    DataBaixa:=EdDatabaixa.asdate;
{   // 12.07.18 - retirado - Giacomoni
    if trim( copy( Grid.cells[Grid.getcolumn('data'),p],1,2 ) ) <> '' then begin
      xBaixa:=Texttodate( FGeral.TiraBarra( Grid.cells[Grid.getcolumn('data'),p] ) );
      if datetoano(xbaixa,true) > 1902 then DataBaixa:=xBaixa;
    end;
}
// 19.10.2022 - Guiber - documentos em q o vencimento 'do banco' difere do informado no Sac
//              dai n�o encontra o documento ficando sem a unidade no grid gerando erro no post...
    xunidade := trim(Grid.cells[Grid.getcolumn('pend_unid_codigo'),p]);

    if (trim(xunidade)='') and (trim(seunumero)<>'') then begin

       Avisoerro('Documento '+seunumero+' pode estar com vencimento divergente.  N�O SER� BAIXADO');
       seunumero:='';
       cnossonumero:='';

    end;

    if (trim(seunumero)<>'') and (trim(Grid.cells[Grid.getcolumn('pend_datavcto'),p])<>'')
        and ( pos(ocorrencia,ocorrencias)>0)      // 14.09.15
////////////       and ( pos(motivo,motivos)>0)   // 25.02.15 - retirado em 02.09.15
      then begin
      vencimento:=Texttodate( FGeral.tirabarra(Grid.cells[Grid.getcolumn('pend_datavcto'),p]) );
      Lista:=Tstringlist.create;
      strtolista(Lista,seunumero,';',true);
      tarifa:=texttovalor( Grid.cells[Grid.getcolumn('tarifa'),p] );
      juros:=texttovalor( Grid.cells[Grid.getcolumn('juros'),p] );
      descontos:=texttovalor( Grid.cells[Grid.getcolumn('descontos'),p] );
      descjuros:=' Juros Recebidos';
      descdescontos:=' Descontos Concedidos';
      ContaJuros:=Global.ContaJurosRecebidos;
//      ContaDescontos:=Global.ContaDescontosConcedidos;
// 04.11.16
      ContaDescontos:=FGEral.getconfig1asinteger('Ctadescconc');
      ContaDescontosTarifaban:=Global.ContaDescontosConcTarifaBan;
// 23.09.16
      TipoCodigo:=StrtoINtdef( Grid.cells[Grid.getcolumn('pend_tipo_codigo'),p],0 );

      for x:=0 to lista.count-1 do begin

        if (trim(lista[x])<>'') and (trim(lista[x])<>'0') then begin
          Sistema.Edit('Pendencias');
          Sistema.SetField('pend_status','B');
          if x=1 then begin
            juros:=0;
            descontos:=0;
            tarifa:=0;
          end;
          Sistema.SetField('pend_mora',Juros);
          Sistema.SetField('pend_descontos',Descontos);
          Sistema.SetField('pend_transbaixa',Transacao);
          Sistema.SetField('pend_contabaixa',ContaBanco);
          Sistema.SetField('pend_databaixa',DataBaixa);
          Sistema.SetField('pend_observacao','CLIENTE');
          Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);
          if lista.count=1 then begin

             if ( trim(cnossonumero)<>'') and ( Global.Topicos[1293] ) then begin
 // 20.08.18
               if Numerobanco='748' then begin

                  QNN:=sqltoquery('select pend_operacao from pendencias where pend_opantecipa='+Stringtosql(cnossonumero)+
                                  ' and pend_rp=''R'''+
                                   ' and '+FGeral.GetIN('pend_unid_codigo',Grid.cells[Grid.getcolumn('pend_unid_codigo'),p],'C'));
                  if not QNN.Eof then

                     Sistema.Post('pend_status=''N'' and pend_numerodcto='+stringtosql(inttostr(strtoint(lista[x])))+
                         ' and pend_datavcto='+Datetosql(vencimento)+
                         ' and pend_opantecipa='+Stringtosql(cnossonumero)+
                         ' and pend_rp=''R'''+
                         ' and '+FGeral.GetIN('pend_unid_codigo',Grid.cells[Grid.getcolumn('pend_unid_codigo'),p],'C')+
                         ' and pend_valor='+Valortosql(valor) )
                  else

                     Sistema.Post('pend_status=''N'' and pend_numerodcto='+stringtosql(inttostr(strtoint(lista[x])))+
                          ' and pend_datavcto='+Datetosql(vencimento)+
//                         ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                          sqldatacont+
                          ' and pend_rp=''R'''+
                          ' and '+FGeral.GetIN('pend_unid_codigo',Grid.cells[Grid.getcolumn('pend_unid_codigo'),p],'C')+
                          ' and pend_valor='+Valortosql(valor) );

                   QNN.Close;


               end else

                  Sistema.Post('pend_status=''N'' and pend_numerodcto='+stringtosql(inttostr(strtoint(lista[x])))+
                         ' and pend_datavcto='+Datetosql(vencimento)+
                         ' and pend_opantecipa='+Stringtosql(cnossonumero)+
                         ' and pend_rp=''R'''+
                         ' and '+FGeral.GetIN('pend_unid_codigo',Grid.cells[Grid.getcolumn('pend_unid_codigo'),p],'C')+
                         ' and pend_valor='+Valortosql(valor) )

             end else

               Sistema.Post('pend_status=''N'' and pend_numerodcto='+stringtosql(inttostr(strtoint(lista[x])))+
                         ' and pend_datavcto='+Datetosql(vencimento)+
//                         ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                         sqldatacont+
                         ' and pend_rp=''R'''+
                         ' and '+FGeral.GetIN('pend_unid_codigo',Grid.cells[Grid.getcolumn('pend_unid_codigo'),p],'C')+
                         ' and pend_valor='+Valortosql(valor) );

          end else

            Sistema.Post('pend_status=''N'' and pend_numerodcto='+stringtosql(inttostr(strtoint(lista[x])))+
                         ' and pend_datavcto='+Datetosql(vencimento)+
//                         ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                         sqldatacont+
                         ' and '+FGeral.GetIN('pend_unid_codigo',Grid.cells[Grid.getcolumn('pend_unid_codigo'),p],'C')+
                         ' and pend_rp=''R'''+
                         ' and pend_valor<'+Valortosql(valor) );
          complemento:=lista[x]+' '+Grid.cells[Grid.getcolumn('clie_nome'),p];
          if lista.count=1 then   // so lanca se for somente um titulo
            FGeral.GravaMovfin(Transacao,Global.codigoUnidade,'E',complemento,
                             DAtaBaixa,DAtaBaixa,
                             DAtaBaixa,strtoint(lista[x]),999,0,contabanco,valor,ContaDesrec,Global.CodPendenciaFinanceira,
                             0,tipocodigo,'C','N','1',transacaocontax);
        end;

      end;  // for caso tiver mais de um titulo a baixar

      if lista.count>1 then begin  // para lancar no banco cada valor de cada titulo 'juntado' no boleto

        Q:=sqltoquery('select pend_valor,pend_numerodcto,pend_tipocad,pend_tipo_codigo from pendencias where pend_status=''N'''+
                      ' and '+FGeral.Getin('pend_numerodcto',Grid.cells[Grid.getcolumn('pend_numerodcto'),p],'N')+
                      ' and pend_datavcto='+Datetosql(vencimento)+
                      ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                      ' and pend_rp=''R'''+
                      ' and pend_valor<'+Valortosql(valor) );
        while not Q.eof do begin
          if trim( Grid.cells[Grid.getcolumn('clie_nome'),p] )<>'' then
            complemento:=Q.fieldbyname('pend_numerodcto').asstring+' '+Grid.cells[Grid.getcolumn('clie_nome'),p]
          else
            complemento:=Q.fieldbyname('pend_numerodcto').asstring+' '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').AsInteger,Q.fieldbyname('pend_tipocad').AsString,'N');
          valor:=Q.fieldbyname('pend_valor').ascurrency;
          FGeral.GravaMovfin(Transacao,Global.codigoUnidade,'E',complemento,
                             DAtaBaixa,DataBaixa,
                             DAtaBaixa,strtoint(Q.fieldbyname('pend_numerodcto').asstring),999,0,contabanco,valor,ContaDesrec,Global.CodPendenciaFinanceira,
                             0,tipocodigo,'C','N','1',transacaocontax);

          Q.Next;
        end;
        FGeral.fechaquery(Q);
      end;
      Numerodoc:=strtoint(lista[0]);  //  pega o primeiro titulo

      if Juros>0 then
             FGeral.GravaMovfin(Transacao,Global.codigoUnidade,'E',complemento+descjuros,DAtaBaixa,DataBaixa,
                             DAtaBaixa,Numerodoc,999,0,contabanco,Juros,ContaJuros,Global.CodJurosRecebidos,
                             0,tipocodigo,'C','N','1',transacaocontax)
      else if Descontos>0 then
             FGeral.GravaMovfin(Transacao,Global.codigoUnidade,'S',complemento+descdescontos,DAtaBaixa,DataBaixa,
                             DAtaBaixa,Numerodoc,999,0,contabanco,Descontos,ContaDescontos,Global.CodDescontosDados,
                             0,tipocodigo,'C','N','1',transacaocontax);
      if (Tarifa>0) and ( not Global.Topicos[1516])  then
            FGeral.GravaMovfin(Transacao,Global.codigoUnidade,'S','Tarifa banc�ria',DAtaBaixa,DataBaixa,
                             DAtaBaixa,Numerodoc,999,0,contabanco,Tarifa,ContaDescontosTarifaban,Global.CodDescontosTarifaBan,
                             0,tipocodigo,'C','N','1',transacaocontax);

          // if do seunumero e vencimento
// 16.04.18
    end else  if ( trim(cnossonumero)<>'' )
                 and ( pos(ocorrencia,ocorrencias)>0)
                 and ( Grid.Cells[grid.getcolumn('clie_nome'),p]<>'J� Baixado' )
              then begin

// 15.04.18 - baixa de boleto somado varias notas

          Sistema.Edit('Pendencias');
          Sistema.SetField('pend_status','B');
          Sistema.SetField('pend_mora',Juros);
          Sistema.SetField('pend_descontos',Descontos);
          Sistema.SetField('pend_transbaixa',Transacao);
          Sistema.SetField('pend_contabaixa',ContaBanco);
          Sistema.SetField('pend_databaixa',DataBaixa);
          Sistema.SetField('pend_observacao','CLIENTE');
          Sistema.SetField('pend_usubaixa',Global.Usuario.codigo);
          Sistema.Post('pend_status=''N'''+
//                       ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                       sqldatacont+
                       ' and '+FGeral.GetIN('pend_unid_codigo',Global.Usuario.UnidadesMvto ,'C')+
                       ' and pend_rp=''R'''+
                       ' and pend_opantecipa = '+Stringtosql(cnossonumero) );
          complemento:=NotasSomadas;
          FGeral.GravaMovfin(Transacao,Global.codigoUnidade,'E',complemento,
                             DAtaBaixa,DAtaBaixa,
                             DAtaBaixa,0,999,0,contabanco,valor,ContaDesrec,Global.CodPendenciaFinanceira,
                             0,0,'C','N','1',transacaocontax);
          if Juros>0 then
                 FGeral.GravaMovfin(Transacao,Global.codigoUnidade,'E',complemento+descjuros,DAtaBaixa,DataBaixa,
                                 DAtaBaixa,Numerodoc,999,0,contabanco,Juros,ContaJuros,Global.CodJurosRecebidos,
                                 0,tipocodigo,'C','N','1',transacaocontax)
          else if Descontos>0 then
                 FGeral.GravaMovfin(Transacao,Global.codigoUnidade,'S',complemento+descdescontos,DAtaBaixa,DataBaixa,
                                 DAtaBaixa,Numerodoc,999,0,contabanco,Descontos,ContaDescontos,Global.CodDescontosDados,
                                 0,tipocodigo,'C','N','1',transacaocontax);
//          if Tarifa>0 then
// 24.08.2021
      if (Tarifa>0) and ( not Global.Topicos[1516])  then
                FGeral.GravaMovfin(Transacao,Global.codigoUnidade,'S','Tarifa banc�ria',DAtaBaixa,DataBaixa,
                                 DAtaBaixa,Numerodoc,999,0,contabanco,Tarifa,ContaDescontosTarifaban,Global.CodDescontosTarifaBan,
                                 0,tipocodigo,'C','N','1',transacaocontax);


    end;

  end;  // for do grid
  try
    Sistema.endtransaction('Baixa de boletos terminada');
  except
    Sistema.endtransaction('Aten��o.   Baixa na� efetuada');
  end;
  Grid.clear;
  Edarquivo.setfocus;

end;

////////////////////////////////////////////////////////////
procedure TFBaixaCobranca.bprocurarClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

   if opendialog1.execute then begin
     EdArquivo.text:=Opendialog1.FileName;
     EdArquivo.valid;
     Grid.setfocus;
   end;

end;

///////////////////////////////////////////////////////////////
procedure TFBaixaCobranca.EdArquivoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
type TJurosDesc=record
     nossonumero   : string;
     juros,
     desconto      : currency;
end;

var g_erro,dia,mes,ano,cnossonumero,cnab240400:string;
    Mat,
    ListaV:Tstringlist;
    p,nbloquetos,x,nencontrados,nnaoprocessados,colnossonum,tamnossonum,colparcela,tamparcela,
    coldecimais,colvencimento,tamvencimento,tamnumerodoc,colnumerodoc,colocorrencia,colmotivo,
    tammotivo,tamdataocor,coldataocor,coljuros,tamjuros,coldescontos,tamdescontos,
    nboletosent,nboletosenv:integer;

    Q,QBanco:TSqlquery;
    vencimento:Tdatetime;
    valor,valortotalpago,jurosrecebidos,descontosconcedidos:currency;
    condicao:boolean;
    ListaJD    : TList;
    PJurosDesc : ^TJurosDesc;


    function GetOcorrencia(y:string):string;
    ///////////////////////////////////////////
    var x:string;
    begin
       result:='';
       x:=trim(y);
       if numerobanco='748' then begin

         if x='01' then result:='Cadastro de t�tulo'
         else if x='02' then result:='Entrada Confirmada'
         else if x='03' then result:='Entrada Rejeitada'
         else if x='04' then result:='Tarifa de Protesto'
         else if x='06' then result:='Liquida��o Normal'
// 12.11.2021
         else if x='07' then result:='Inten��o de Pagamento'
         else if x='08' then result:='Tarifa de Custas de Protesto'
         else if x='09' then result:='Baixado autom�tico via arquivo'
         else if x='10' then result:='Baixado cfe instru��es de coop.de cr�dito'
         else if x='12' then result:='Abatimento concedido'
         else if x='13' then result:='Abatimento cancelada'
         else if x='14' then result:='Vencimento alterado'
         else if x='15' then result:='Liquida��o em cart�rio'
         else if x='17' then result:='Liquidado ap�s baixa'
         else if x='19' then result:='Recebida instru��o de protesto'
         else if x='23' then result:='Entrada t�tulo em cart�rio'
         else if x='24' then result:='Rejeitado por CEP irregular'
         else if x='27' then result:='Baixa rejeitada'
         else if x='28' then result:='Valor tarifa'
         else if x='29' then result:='Rejei��o do pagador'
         else if x='30' then result:='Altera��o rejeitada'
         else if x='32' then result:='Instru��o rejeitada'
         else if x='33' then result:='Altera��o de outros dados aceita'
         else if x='34' then result:='Retirado do cart�rio e retorno a carteira'
         else if x='35' then result:='Aceite do pagador'
         else result:='VER MANUAL DO BANCO';

       end else if numerobanco='341' then begin

         if x='01' then result:='Cadastro de t�tulo'
         else if x='02' then result:='Entrada Confirmada'
         else if x='03' then result:='Entrada Rejeitada'
         else if x='04' then result:='Altera��o de Dados/Nova entrada aceita'
         else if x='06' then result:='Liquida��o Normal'
         else if x='07' then result:='Liquida��o Parcial - Cobran�a Inteligente'
         else if x='08' then result:='Liquida��o em cart�rio'
         else if x='09' then result:='Baixado simples'
         else if x='10' then result:='Baixado por ter sido liquidado'
         else if x='12' then result:='Abatimento concedido'
         else if x='13' then result:='Abatimento cancelada'
         else if x='14' then result:='Vencimento alterado'
         else if x='15' then result:='Baixa rejeitada'
         else if x='16' then result:='Instru��es Rejeitadas'
         else if x='17' then result:='Altera��o/Exclus�o de dados rejeitados'
         else if x='18' then result:='Cobran�a contratual'
         else if x='19' then result:='Confirma recebimento de inst. de protesto'
         else if x='23' then result:='Entrada t�tulo em cart�rio'
         else if x='24' then result:='Instru��o protesto rejeitada'
         else if x='27' then result:='Tarifa de Extrato'
         else if x='28' then result:='Tarifa rela��o de liquida��es'
         else result:='VER MANUAL DO BANCO';
// 10.12.18 - caixa
       end else if numerobanco='104' then begin

         if x='01' then result:='Solicita��o de Impress�o de T�tulos Confirmada'
         else if x='02' then result:='Entrada Confirmada'
         else if x='03' then result:='Entrada Rejeitada'
         else if x='04' then result:='Transfer�ncia de Carteira/Entrada'
         else if x='05' then result:='Transfer�ncia de Carteira/Baixa'
         else if x='06' then result:='Liquida��o'
         else if x='07' then result:='Confirma��o do Recebimento da Instru��o de Desconto'
         else if x='08' then result:='Confirma��o do Recebimento do Cancelamento do Desconto'
         else if x='09' then result:='Baixa'
         else if x='12' then result:='Confirma��o Recebimento Instru��o de Abatimento'
         else if x='13' then result:='Confirma��o Recebimento Instru��o de Cancelamento Abatimento'
         else if x='14' then result:='Confirma��o Recebimento Instru��o Altera��o de Vencimento'
         else if x='19' then result:='Confirma��o Recebimento Instru��o de Protesto'
         else if x='20' then result:='Confirma��o Recebimento Instru��o de Susta��o/Cancelamento de Protesto'
         else if x='23' then result:='Remessa a Cart�rio'
         else if x='24' then result:='Retirada de Cart�rio'
         else if x='25' then result:='Protestado e Baixado (Baixa por Ter Sido Protestado)'
         else if x='26' then result:='Instru��o Rejeitada'
         else if x='27' then result:='Confirma��o do Pedido de Altera��o de Outros Dados'
         else if x='28' then result:='D�bito de Tarifas/Custas'
         else if x='30' then result:='Altera��o de Dados Rejeitada'
         else if x='35' then result:='Confirma��o de Inclus�o Banco de Sacado'
         else if x='36' then result:='Confirma��o de Altera��o Banco de Sacado'
         else if x='37' then result:='Confirma��o de Exclus�o Banco de Sacado'
         else if x='38' then result:='Emiss�o de Bloquetos de Banco de Sacado'
         else if x='39' then result:='Manuten��o de Sacado Rejeitada'
         else if x='40' then result:='Entrada de T�tulo via Banco de Sacado Rejeitada'
         else if x='41' then result:='Manuten��o de Banco de Sacado Rejeitada'
         else if x='44' then result:='Estorno de Baixa / Liquida��o'
         else if x='45' then result:='Altera��o de Dados'
         else result:='VER MANUAL DO BANCO';

// 19.12.19 - BBrasil
       end else if numerobanco='001' then begin

         if x='01' then result:=''
         else if x='02' then result:='Entrada Confirmada'
         else if x='03' then result:='Entrada Rejeitada'
         else if x='04' then result:='Boleto Negociado(Desconto)'
         else if x='05' then result:=''
         else if x='06' then result:='Liquida��o'
         else if x='07' then result:='Confirma��o do Recebimento da Instru��o de Desconto'
         else if x='08' then result:='Confirma��o do Recebimento do Cancelamento do Desconto'
         else if x='09' then result:='Baixa'
         else if x='10' then result:='Confirma��o do Recebimento da Instru��o de Repactua��o'
         else if x='12' then result:='Confirma��o Recebimento Instru��o de Abatimento'
         else if x='13' then result:='Confirma��o Recebimento Instru��o de Cancelamento Abatimento'
         else if x='14' then result:='Confirma��o Recebimento Instru��o Altera��o de Vencimento'
         else if x='17' then result:='Liquida��o ap�s Baixa ou Liquida��o T�tulo n�o Registrado'
{
         else if x='19' then result:='Confirma��o Recebimento Instru��o de Protesto'
         else if x='20' then result:='Confirma��o Recebimento Instru��o de Susta��o/Cancelamento de Protesto'
         else if x='23' then result:='Remessa a Cart�rio'
         else if x='24' then result:='Retirada de Cart�rio'
         else if x='25' then result:='Protestado e Baixado (Baixa por Ter Sido Protestado)'
         }
         else if x='26' then result:='Instru��o Rejeitada'
         else if x='27' then result:='Confirma��o do Pedido de Altera��o de Outros Dados'
//         else if x='28' then result:='D�bito de Tarifas/Custas'
         else if x='30' then result:='Altera��o de Dados Rejeitada'
//         else if x='35' then result:='Confirma��o de Inclus�o Banco de Sacado'
         else if x='36' then result:='Confirma��o de Altera��o Banco de Sacado'
         else if x='37' then result:='T�tulos debitados a Empresa ap�s o t�rmino da car�ncia'
         else if x='38' then result:='T�tulos pagos em atraso creditados a Empresa'
         else result:='VER MANUAL DO BANCO';

// 27.10.17
       end else if numerobanco='756' then begin

         if x='02' then result:='Entrada Confirmada'
         else if x='03' then result:='Entrada Rejeitada'
         else if x='04' then result:='Transfer�ncia de Carteira/Entrada'
         else if x='05' then result:='Transfer�ncia de Carteira/Baixa'
         else if x='06' then result:='Liquida��o'
         else if x='07' then result:='Confirma��o do Recebimento da Instru��o de Desconto'
         else if x='08' then result:='Confirma��o do Recebimento do Cancelamento do Desconto'
         else if x='09' then result:='Baixa'
         else if x='11' then result:='T�tulos em Carteira (Em Ser)'
         else if x='12' then result:='Confirma��o Recebimento Instru��o de Abatimento'
         else if x='13' then result:='Confirma��o Recebimento Instru��o de Cancelamento Abatimento'

          else if x='14'  then result:='Confirma��o Recebimento Instru��o Altera��o de Vencimento'
          else if x='15'  then result:='Franco de Pagamento'
          else if x='17' then result:='Liquida��o Ap�s Baixa ou Liquida��o T�tulo N�o Registrado'
          else if x='19' then result:='Confirma��o Recebimento Instru��o de Protesto'
          else if x='20' then result:='Confirma��o Recebimento Instru��o de Susta��o/Cancelamento de Protesto'
          else if x='23' then result:='Remessa a Cart�rio (Aponte em Cart�rio)'
          else if x='24' then result:='Retirada de Cart�rio e Manuten��o em Carteira'
          else if x='25' then result:='Protestado e Baixado (Baixa por Ter Sido Protestado)'
          else if x='26' then result:='Instru��o Rejeitada'
          else if x='27' then result:='Confirma��o do Pedido de Altera��o de Outros Dados'
          else if x='28' then result:='D�bito de Tarifas/Custas'
          else if x='29' then result:='Ocorr�ncias do Pagador'
          else if x='30' then result:='Altera��o de Dados Rejeitada'
          else if x='33' then result:='Confirma��o da Altera��o dos Dados do Rateio de Cr�dito'
          else if x='34' then result:='Confirma��o do Cancelamento dos Dados do Rateio de Cr�dito'
          else if x='35' then result:='Confirma��o do Desagendamento do D�bito Autom�tico'
          else if x='36' then result:='Confirma��o de envio de e-mail/SMS'
          else if x='37' then result:='Envio de e-mail/SMS rejeitado'
          else if x='38' then result:='Confirma��o de altera��o do Prazo Limite de Recebimento'
          else if x='39' then result:='Confirma��o de Dispensa de Prazo Limite de Recebimento'
          else if x='48' then result:='Confirma��o de instru��o de transfer�ncia de carteira/modalidade de cobran�a'
          else if x='49' then result:='Altera��o de contrato de cobran�a'

// 05.02.20
       end else if numerobanco='422' then begin

         if x='02'    then result:='Entrada Confirmada'
         else if x='03' then result:='Entrada Rejeitada'
         else if x='04' then result:='Transfer�ncia de Carteira/Entrada'
         else if x='05' then result:='Transfer�ncia de Carteira/Baixa'
         else if x='06' then result:='Liquida��o'
         else if x='07' then result:='Confirma��o do Recebimento da Instru��o de Desconto'
         else if x='08' then result:='Confirma��o do Recebimento do Cancelamento do Desconto'
         else if x='09' then result:='Baixado autom�tico via arquivo'
         else if x='11' then result:='Arquivo de t�tulos pendentes (Em Ser)'
         else if x='12' then result:='Confirma��o Recebimento Instru��o de Abatimento'
         else if x='13' then result:='Confirma��o Recebimento Instru��o de Cancelamento Abatimento'
         else if x='14' then result:='Confirma��o Recebimento Instru��o Altera��o de Vencimento'
         else if x='15' then result:='Franco de Pagamento'
         else if x='17' then result:='Liquida��o Ap�s Baixa ou Liquida��o T�tulo N�o Registrado'
         else if x='19' then result:='Confirma��o Recebimento Instru��o de Protesto'
         else if x='20' then result:='Confirma��o Recebimento Instru��o de Susta��o/Cancelamento de Protesto'
         else if x='23' then result:='Remessa a Cart�rio (Aponte em Cart�rio)'
         else if x='24' then result:='Retirada de Cart�rio e Manuten��o em Carteira'
         else if x='25' then result:='Protestado e Baixado (Baixa por Ter Sido Protestado'
         else if x='26' then result:='Instru��o Rejeitada'
         else if x='27' then result:='Confirma��o do Pedido de Altera��o de Outros Dados'
         else if x='28' then result:='D�bito de Tarifas/Custas'
         else if x='29' then result:='Ocorr�ncias do Pagador'
         else if x='30' then result:='Altera��o de Dados Rejeitada'
         else if x='33' then result:='Confirma��o da Altera��o dos Dados do Rateio de Cr�dito'
         else if x='34' then result:='Confirma��o do Cancelamento dos Dados do Rateio de Cr�dito'
         else if x='35' then result:='Confirma��o do Desagendamento do D�bito Autom�tico'
         else if x='36' then result:='Confirma��o de envio de e-mail/SMS'
         else if x='37' then result:='Envio de e-mail/SMS rejeitado'
         else if x='38' then result:='Confirma��o de altera��o do Prazo Limite de Recebimento';


// 16.08.19
       end else if numerobanco='237' then begin

         if x='02' then result:='Entrada Confirmada'
         else if x='03' then result:='Entrada Rejeitada'
         else if x='04' then result:='Transfer�ncia de Carteira/Entrada'
         else if x='05' then result:='Transfer�ncia de Carteira/Baixa'
         else if x='06' then result:='Liquida��o'
         else if x='07' then result:='Confirma��o do Recebimento da Instru��o de Desconto'
         else if x='08' then result:='Confirma��o do Recebimento do Cancelamento do Desconto'
         else if x='09' then result:='Baixado autom�tico via arquivo'
         else if x='10' then result:='Baixado conforme instru��es da Ag�ncia(verificar motivo pos.319 a 328)'
         else if x='11' then result:='Arquivo de t�tulos pendentes (Em Ser)'
         else if x='12' then result:='Confirma��o Recebimento Instru��o de Abatimento'
         else if x='13' then result:='Confirma��o Recebimento Instru��o de Cancelamento Abatimento'

          else if x='14' then result:='Confirma��o Recebimento Instru��o Altera��o de Vencimento'
          else if x='15' then result:='Liquida��o em cart�rio'
          else if x='16' then result:='Pago em cheque'
          else if x='17' then result:='Liquida��o Ap�s Baixa ou Liquida��o T�tulo N�o Registrado'
          else if x='19' then result:='Confirma��o Recebimento Instru��o de Protesto'
          else if x='20' then result:='Confirma��o Recebimento Instru��o de Susta��o/Cancelamento de Protesto'
          else if x='23' then result:='Remessa a Cart�rio (Aponte em Cart�rio)'
          else if x='24' then result:='Entrada rejeitada por CEP Irregular (verificar motivo pos.319 a 328)'
          else if x='25' then result:='Confirma��o Receb.Inst.de Protesto Falimentar (verificar pos.295 a 295)'
          else if x='26' then result:='Instru��o Rejeitada'
          else if x='27' then result:='Baixa Rejeitada (verificar motivo posi��o 319 a 328)'
          else if x='28' then result:='D�bito de Tarifas/Custas'
          else if x='29' then result:='Ocorr�ncias do Pagador'
          else if x='30' then result:='Altera��o de Dados Rejeitada'
          else if x='33' then result:='Confirma��o da Altera��o dos Dados do Rateio de Cr�dito'
          else if x='34' then result:='Confirma��o do Cancelamento dos Dados do Rateio de Cr�dito'
          else if x='35' then result:='Confirma��o do Desagendamento do D�bito Autom�tico'
          else if x='36' then result:='Confirma��o de envio de e-mail/SMS'



{
�40� = Confirma��o da altera��o do n�mero do t�tulo dado pelo Benefici�rio
�41� = Confirma��o da altera��o do n�mero controle do Participante
�42� = Confirma��o da altera��o dos dados do Pagador
�43� = Confirma��o da altera��o dos dados do Pagadorr/Avalista
�44� = T�tulo pago com cheque devolvido
�45� = T�tulo pago com cheque compensado
�46� = Instru��o para cancelar protesto confirmada
�47� = Instru��o para protesto para fins falimentares confirmada
�50� = T�tulo pago com cheque pendente de liquida��o
�51� = T�tulo DDA reconhecido pelo Pagador
�52� = T�tulo DDA n�o reconhecido pelo Pagador
�53� = T�tulo DDA recusado pela CIP
�54� = Confirma��o da Instru��o de Baixa de T�tulo Negativado sem Protesto
�55� = Confirma��o de Pedido de Dispensa de Multa
�56� = Confirma��o do Pedido de Cobran�a de Multa
�57� = Confirma��o do Pedido de Altera��o de Cobran�a de Juros
�58� = Confirma��o do Pedido de Altera��o do Valor/Data de Desconto
�59� = Confirma��o do Pedido de Altera��o do Benefici�rio do T�tulo
�60� = Confirma��o do Pedido de Dispensa de Juros de Mora"""
          }
         else result:='VER MANUAL DO BANCO';


       end;
    end;


    function GetMotivo(y:string):string;
    ///////////////////////////////////////////
    var x:string;
    begin
       result:='';
       x:=trim(y);
       if numerobanco='748' then begin

         if x='01' then result:='Codigo do banco inv�lido'
         else if x='00' then result:='Sem Motivo'
         else if x='02' then result:='Codigo registro detalhe inv�lido'
         else if x='03' then result:='Codigo ocorr�ncia inv�lido'
         else if x='04' then result:='Codigo ocorr�ncia n�o permitido nesta carteira'
         else if x='05' then result:='Codigo ocorr�ncia n�o num�rico'
         else if x='07' then result:='Cooperativa/ag�ncia/conta/digito inv�lidos'
         else if x='08' then result:='Nosso n�mero inv�lido'
         else if x='09' then result:='Nosso n�mero duplicado'
         else if x='10' then result:='Carteira inv�lida'
         else if x='14' then result:='T�tulo protestado'
         else if x='15' then result:='Cooperativa/carteira/ag�ncia/conta/nosso n�mero inv�lidos'
         else if x='16' then result:='Data de vencimento inv�lida'
         else if x='17' then result:='Data de vencimento anterior a emiss�o'
         else if x='18' then result:='Vencimento fora do prazo de opera��o'
         else if x='20' then result:='Valor do t�tulo inv�lido'
         else if x='21' then result:='Esp�cie do t�tulo inv�lido'
         else if x='22' then result:='Esp�cie n�o permitida para a carteira'
         else if x='24' then result:='Data de emiss�o inv�lida'
         else if x='29' then result:='Valor do desconto maior/igual ao do t�tulo'
         else if x='31' then result:='Desconto j� feito no t�tulo'
         else if x='38' then result:='Prazo para protesto inv�lido'
         else if x='39' then result:='Pedido para protesto n�o permitido'
         else if x='40' then result:='T�tulo com ordem de protesto emitida'
         else if x='48' then result:='CEP irregular'
         else if x='H5' then result:='Recebido fora da rede do banco'
         else if x='H8' then result:='Recebido fora da rede do banco via compensa��o'
         else if x='C6' then result:='T�tulo j� liquidado'
         else if x='C7' then result:='T�tulo j� baixado'
         else if x='B3' then result:='Tarifa de Registro de Entrada do t�tulo'
         else if x='B1' then result:='Tarifa de Baixa da Carteira'
         else if x='C9' then result:='Instru��o pr�via de concess�o de abatimento n�o existe ou n�o confirmada'
         else if x='63' then result:='Envio de t�tulo j� existente no banco'
         else result:='VER MANUAL DO BANCO';
// 19.12.19
       end else if numerobanco='001' then begin

         if x='A9' then result:='N�o autoriza pagamento parcial'
         else if x='A2' then result:= 'Rejei��o da altera��o dos dados do Pagador'
         else if x='A3' then result:= 'Rejei��o da altera��o dos dados do Sacador/avalista'
         else if x='A4' then result:= 'Pagador DDA'
         else if x='A5' then result:= 'Registro Rejeitado � T�tulo j� Liquidado'
         else if x='A6' then result:= 'C�digo do Convenente Inv�lido ou Encerrado'
         else if x='A7' then result:= 'T�tulo j� se encontra na situa��o Pretendida'
         else if x='A8' then result:= 'Valor do Abatimento inv�lido para cancelamento'
         else if x='B1' then result:= 'Autoriza recebimento parcial'
         else if x='B2' then result:= 'Valor Nominal do T�tulo Conflitante'
         else if x='B3' then result:= 'Tipo de Pagamento Inv�lido'
         else if x='B4' then result:= 'Valor M�ximo/Percentual Inv�lido'
         else if x='B5' then result:= 'Valor M�nimo/Percentual Inv�lido'
         else result:='VER MANUAL DO BANCO';
// 05.02.20
       end else if numerobanco = '422' then begin

         if x='01' then result:='Codigo do banco inv�lido'
         else if x='00' then result:='Entrada Confirmada'
         else if x='02' then result:='Codigo registro detalhe inv�lido'
         else if x='03' then result:='Codigo ocorr�ncia inv�lido'
         else if x='04' then result:='Codigo ocorr�ncia n�o permitido nesta carteira'
         else if x='05' then result:='Codigo ocorr�ncia n�o num�rico'
         else if x='07' then result:='Ag�ncia/conta/digito inv�lidos'
         else if x='08' then result:='Nosso n�mero inv�lido'
         else if x='09' then result:='Nosso n�mero duplicado'
         else if x='10' then result:='Carteira inv�lida'
         else if x='14' then result:='Identifica��o da Distribui��o do Boleto de Pagamento Inv�lida'
         else if x='15' then result:='Carteira/ag�ncia/conta/nosso n�mero inv�lidos'
         else if x='16' then result:='Data de vencimento inv�lida'
         else if x='17' then result:='Data de vencimento anterior a emiss�o'
         else if x='18' then result:='Vencimento fora do prazo de opera��o'
         else if x='20' then result:='Valor do t�tulo inv�lido'
         else if x='21' then result:='Esp�cie do t�tulo inv�lido'
         else if x='22' then result:='Esp�cie n�o permitida para a carteira'
         else if x='24' then result:='Data de emiss�o inv�lida'
         else if x='29' then result:='Valor do desconto maior/igual ao do t�tulo'
         else if x='31' then result:='Desconto j� feito no t�tulo'
         else if x='38' then result:='Prazo para protesto inv�lido'
         else if x='39' then result:='Pedido para protesto n�o permitido'
         else if x='40' then result:='T�tulo com ordem de protesto emitida'
         else if x='48' then result:='CEP irregular'
         else if x='H5' then result:='Recebido fora da rede do banco'
         else if x='H8' then result:='Recebido fora da rede do banco via compensa��o'
         else if x='C6' then result:='T�tulo j� liquidado'
         else if x='C7' then result:='T�tulo j� baixado'
         else if x='B3' then result:='Tarifa de Registro de Entrada do t�tulo'
         else if x='B1' then result:='Tarifa de Baixa da Carteira'
         else if x='C9' then result:='Instru��o pr�via de concess�o de abatimento n�o existe ou n�o confirmada'
         else if x='63' then result:='Envio de t�tulo j� existente no banco'
         else result:='VER MANUAL DO BANCO';

       end;

    end;

    Function GetBolEnviados(xdata:TDate):integer;
    /////////////////////////////////////////////////
    var QEnv    : TSqlquery;
        ydata,
        datai,
        dataf   : TDatetime;
        i       : integer;
        sqldata :string;

    begin
      result:=0;
      ydata:=xdata-1;
//      datai:=Texttodate( FGeral.TiraBarra( Grid.cells[Grid.getcolumn('data'),1] ) );
      for i := 1 to Grid.RowCount do begin
        if ( trim(copy(Grid.cells[Grid.getcolumn('data'),i],1,2))<>'' )
           and
           ( pos(copy(Grid.Cells[Grid.getcolumn('ocorrencia'),i],1,2),ocorrencias)=0 ) and (Grid.Cells[Grid.getcolumn('nossonumero'),i]<>'') and
           (Grid.Cells[grid.getcolumn('clie_nome'),i]<>'J� Baixado')
          then
          dataf:=Texttodate( FGeral.TiraBarra( Grid.cells[Grid.getcolumn('data'),i] ) );
      end;
      datai:=dataf;

      if ( Datetoano(datai,true)>1902 ) and ( Datetoano(dataf,true)>1902 ) then
          sqldata:=' and pend_dataemissao >= '+Datetosql( datai )+
                   ' and pend_dataemissao <= '+Datetosql( dataf )
      else
          sqldata:=' and pend_dataemissao = '+Datetosql( ydata );

      QEnv:=sqltoquery('select pend_operacao from pendencias where pend_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                       sqldata+
                       ' and pend_opantecipa is not null' +
                       ' and pend_status <> ''C''' )  ;

//////////////////////////////////////////

      if QEnv.Eof then begin

         ydata:=ydata-1;
         FGeral.FechaQuery(Qenv);
         QEnv:=sqltoquery('select pend_operacao from pendencias where pend_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                       ' and pend_dataemissao = '+Datetosql( ydata )+
                       ' and pend_opantecipa is not null' +
                       ' and pend_status <> ''C''' )  ;
         if QEnv.Eof then begin
            ydata:=ydata-1;
            FGeral.FechaQuery(Qenv);
            QEnv:=sqltoquery('select pend_operacao from pendencias where pend_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                       ' and pend_dataemissao = '+Datetosql( ydata )+
                       ' and pend_opantecipa is not null' +
                       ' and pend_status <> ''C''' )  ;
            if QEnv.Eof then begin
                ydata:=ydata-1;
                FGeral.FechaQuery(Qenv);
                QEnv:=sqltoquery('select pend_operacao from pendencias where pend_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                       ' and pend_dataemissao = '+Datetosql( ydata )+
                       ' and pend_opantecipa is not null' +
                       ' and pend_status <> ''C''' )  ;

            end else sqldata:= ' and pend_dataemissao = '+Datetosql( ydata );


         end else sqldata:= ' and pend_dataemissao = '+Datetosql( ydata );

      end;

//////////////////////////////////////////

      if not QEnv.Eof then
         FGeral.FechaQuery(Qenv);
         QEnv:=sqltoquery('select count(*) as quantos from pendencias where pend_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                         ' and '+FGeral.GetNOTIN('pend_status','C;B;P','C')+
                         sqldata+
                         ' and (pend_opantecipa is not null) ');
         result:=QEnv.FieldByName('quantos').AsInteger;
         FGeral.FechaQuery(Qenv);
    end;

// 19.12.19
    function GetAcessorios(Lista:TList;xnossonumero:string; tipo:string ):currency;
    ///////////////////////////////////////////////////////////////////////////////
    var k:integer;
    begin

       for k := 0 to Lista.Count-1 do begin

           PJurosDesc:=Lista[k];
           if PJurosDesc.nossonumero = xnossonumero then begin

              if Tipo = 'D' then begin
                  result:=PJurosDesc.desconto;
              end else if Tipo = 'J' then begin
                  result:=PJurosDesc.juros;
              end;
              break;

           end;

       end;

    end;



///////////////////////////////////////////////////////////////
begin
///////////////////////////////////////////////////////////////

   if not Fileexists( EdArquivo.text ) then begin
     EdArquivo.INvalid('Arquivo '+EdArquivo.text+' n�o encontrado');
     exit;
   end;

// 29.11.17 - banco itau vai remessa com 240 e volta retorno com 400
   cnab240400:='400';

   Sistema.BeginProcess('Lendo arquivo '+EdArquivo.Text);

   Mat:=TStringList.Create;
   Mat.LoadFromFile(EdArquivo.text);

   Try
  		g_erro := copy( Mat.Strings[0],10,1 );
   Except
      Sistema.EndProcess('Arquivo de retorno inv�lido');
      Mat.Free;
      exit;
   End;
   Grid.clear;
   nbloquetos:=0;
   valortotalpago:=0;
   nencontrados:=0;
   nnaoprocessados:=0;
   nboletosenv:=0;
   nboletosent:=0;

//   numerobanco:='XXX';
{
// 27.10.17
    if copy( Mat.Strings[0],001,03 ) = '756' then
      numerobanco:='756'
    else
     numerobanco:=copy( Mat.Strings[0],077,03 );
}
// 10.12.18
// 18.12.18
   numerobanco:=copy( Mat.Strings[0],001,03 );
   if AnsiPos( 'ITAU',Uppercase(Mat.Strings[0]) ) > 0  then
      numerobanco:='341'
// 23.04.19 - Giacomoni
   else if AnSiPos( 'BANSICREDI' , Uppercase(Mat.Strings[0]) ) > 0  then
      numerobanco:='748'
// 16.08.19 - Bradesco
   else if AnSiPos( 'BRADESCO' , Uppercase(Mat.Strings[0]) ) > 0  then
      numerobanco:='237'
// 05.02.20
   else if AnSiPos( 'SAFRA' , Uppercase(Mat.Strings[0]) ) > 0  then
      numerobanco:='422'
// 12.11.2021
   else if AnSiPos( 'SICREDI' , Uppercase(Mat.Strings[0]) ) > 0  then

      numerobanco:='748';


   if  AnsiPos(  copy( Mat.Strings[0],001,03 ),'341;104;001;422') > 0 then cnab240400:='240';

   colnossonum:=47;
   tamnossonum:=11;
   colparcela:=82;
   tamparcela:=11;
   coldecimais:=95;
   colvencimento:=74;
   tamvencimento:=8;
   tamnumerodoc:=0;
   colnumerodoc:=0;
   colocorrencia:=0;
   colmotivo:=0;
   coldataocor:=0;
   tamdataocor:=6;
   coljuros:=267;
   tamjuros:=11;
   coldescontos:=241;
   tamdescontos:=11;

   if numerobanco='748' then begin

     colnossonum:=48;
     tamnossonum:=15;
     colparcela:=153;
     tamparcela:=11;
     coldecimais:=164;
     colvencimento:=111;
     tamvencimento:=6;
     tamnumerodoc:=10;
     colnumerodoc:=117;
     colocorrencia:=109;
     coljuros:=0;
     tamjuros:=0;
     coldescontos:=0;
     tamdescontos:=0;

// 16.08.19 - Bradesco
   end else if numerobanco='237' then begin

     colnossonum:=127;
     tamnossonum:=20;
     colparcela:=153;
     tamparcela:=11;
     coldecimais:=164;
     colvencimento:=147;
     tamvencimento:=6;
     tamnumerodoc:=10;
     colnumerodoc:=117;
     colocorrencia:=109;
     coljuros:=202;
     tamjuros:=13;
     coldescontos:=241;
     tamdescontos:=13;


   end else if numerobanco='341' then begin

     if cnab240400='400' then begin

       colnossonum:=63;
       tamnossonum:=08;
       colparcela:=153;
       tamparcela:=11;
       coldecimais:=164;
       colvencimento:=147;
       tamvencimento:=6;
       tamnumerodoc:=10;
       colnumerodoc:=117;
       colocorrencia:=109;

     end else begin

       colnossonum:=38;
       tamnossonum:=20;
       colparcela:=082;
       tamparcela:=13;
       coldecimais:=095;
       colvencimento:=74;
       tamvencimento:=8;
       tamnumerodoc:=15;
       colnumerodoc:=059;
       colocorrencia:=109;

     end;
// 27.10.17
   end else if numerobanco='756' then begin

     colnossonum:=37;
//     tamnossonum:=20;
// 05.04.18  - Vidanova
     tamnossonum:=10;
     colparcela:=082;
     tamparcela:=13;
     coldecimais:=095;
     colvencimento:=74;
     tamvencimento:=8;
     tamnumerodoc:=15;
     colnumerodoc:=059;
     colocorrencia:=16;
// 26.06.18
     coldataocor:=138;
     tamdataocor:=8;
     colmotivo  :=16;
     tammotivo  :=2;

// 10.10.18 - Caixa
   end else if numerobanco='104' then begin  // (  e cnab 240... )

//     colnossonum:=40;
// 20.08.2021 - Novicarnes
     colnossonum:=42;
     tamnossonum:=15;
     colparcela:=082;
     tamparcela:=13;
     coldecimais:=095;
     colvencimento:=74;
     tamvencimento:=8;
     tamnumerodoc:=25;
     colnumerodoc:=106;
     colocorrencia:=16;
     coldataocor:=16;
     tamdataocor:=0;
     colmotivo  :=16;
     tammotivo  :=2;

// 19.12.19 - Banco do Brasil e 240 posicoes   - Simar - Julho
   end else if numerobanco='001' then begin  // (  e cnab 240... )

     colnossonum:=38;
     tamnossonum:=20;
     colparcela:=082;
     tamparcela:=13;
     coldecimais:=095;
     colvencimento:=74;
     tamvencimento:=8;
     tamnumerodoc:=15;
     colnumerodoc:=059;

//     colocorrencia:=214;
     colocorrencia:=16;

     coldataocor:=0;
     tamdataocor:=0;

//     colmotivo  :=16;
     colmotivo  :=214;

     tammotivo  :=2;
     coljuros   :=18;
     tamjuros   :=13;
     coldescontos :=33;
     tamdescontos :=13;

// 05.02.20
   end else if numerobanco='422' then begin

     colnossonum:=38;
     tamnossonum:=20;
     colparcela:=082;
     tamparcela:=13;
     coldecimais:=095;
     colvencimento:=74;
     tamvencimento:=8;
     tamnumerodoc:=15;
     colnumerodoc:=059;
     colocorrencia:=16;
     coldataocor:=0;
     tamdataocor:=0;
     colmotivo  :=214;
     tammotivo  :=02;

   end;
{
   Acbrboleto1.DirArqRetorno:= ExtractFilePath( EdArquivo.text );
   Acbrboleto1.NomeArqRetorno:= ExtractFileName( EdArquivo.text );
   AcbrBoleto1.LayoutRemessa:=c400;
   Acbrboleto1.Banco.TipoCobranca:=cobBancoDoBrasil;
   AcbrBoleto1.Banco.Numero:=strtoint(numerobanco);
   QBanco:=sqltoquery('select * from plano where plan_codigobanco='+Stringtosql(numerobanco));
   if numerobanco='748' then begin
     Acbrboleto1.Banco.TipoCobranca:=cobSicred;
     ACBrBoleto1.Cedente.Conta:=QBanco.fieldbyname('plan_contacorrente').AsString;
     ACBrBoleto1.Cedente.CodigoCedente :=QBanco.fieldbyname('Plan_convenio').asstring ;
     Titulo.Acbrboleto.LerRetorno;
     Titulo.ACBrBoleto.ListadeBoletos.Items[0].
     exit;
   end;
}

// 24.09.18 - verificar somente de um dia cfe topicos do sistema
/////////////////////////////////////////////////////////////////////
   if Global.Topicos[1299] then begin

      ListaV := TStringList.Create;
      for p:=0 to Mat.count-1 do begin

        condicao:=true;
        if numerobanco='756' then
          condicao:=( AnsiPos( copy( Mat.Strings[p],14,1 ),'U')>0 )
        else
//          condicao:=( copy( Mat.Strings[p],108,1 )='I' ) ;
// 10.12.18 - Caixa  - 104
          condicao:=( copy( Mat.Strings[p],108,1 )='T' ) ;

        if numerobanco='748' then
           condicao:=( copy( Mat.Strings[p],01,01 )='1' )
                      and ( pos(copy( Mat.Strings[p],colmotivo,02 ),'B3/04')=0 )
                      and ( pos(copy( Mat.Strings[p],colocorrencia,02 ),'28')=0 )

        else if (numerobanco='341')  then
           condicao:= ( pos(copy( Mat.Strings[p],colocorrencia,02 ),'02/28/29')=0 ) and ( copy( Mat.Strings[p],1,1 )<>'9' )

        else if (numerobanco='237')  then
           condicao:= ( copy( Mat.Strings[p],1,1 )='1' ) ;

//                      18.12.18 - para nunca pegar a primeira linha do arquivo retorno
        if ( condicao ) and ( p>0 ) then begin

             if coldataocor>0 then begin
               if ListaV.indexof( copy( Mat.Strings[p],coldataocor,tamdataocor ) )=-1 then

                  ListaV.add( copy( Mat.Strings[p],coldataocor,tamdataocor ) );

             end;

        end;

      end;
      if Listav.count>1 then begin
         Sistema.EndProcess('N�o permitido arquivo retorno com mais de um dia de baixas');
         exit;
      end;

   end;

// 19.12.19
   ListaJD := TList.Create;

   if  ( AnsiPos(  copy( Mat.Strings[0],001,03 ),'001') > 0 ) and ( cnab240400 = '240' ) then begin

      for p:=0 to Mat.count-1 do begin

          if  ( AnsiPos( copy( Mat.Strings[p],14,1 ),'T')>0 ) then begin

              cnossonumero:=trim( copy( Mat.Strings[p],colnossonum,tamnossonum ) );
              New(PJurosDesc);
              PJurosDesc.nossonumero := cnossonumero;
              PJurosDesc.desconto    := 0;
              PJurosDesc.juros       := 0;
              ListaJD.Add(PJurosDesc);

              if p < Mat.Count then  begin

                if  ( AnsiPos( copy( Mat.Strings[p+1],14,1 ),'U')>0 ) then begin

                   if coljuros>0 then
                      PJurosDesc.juros       := TexttoValor( copy(Mat.Strings[p+1],coljuros,tamjuros)+'.'+copy(Mat.Strings[p+1],coljuros+tamjuros,02) );
                   if coldescontos>0 then
                      PJurosDesc.desconto    := TexttoValor( copy(Mat.Strings[p+1],coldescontos,tamdescontos)+'.'+copy(Mat.Strings[p+1],coldescontos+tamdescontos,02) );

                end;

              end;

          end;


      end;

   end;

   BaixaFinal  :=Texttodate( '' );
   BaixaInicial:=Texttodate( '' );

   for p:=0 to Mat.count-1 do begin

      condicao:=true;
      if numerobanco='756' then
        condicao:=( AnsiPos( copy( Mat.Strings[p],14,1 ),'T')>0 )
// 10.12.18
      else if numerobanco='104' then
        condicao:=( AnsiPos( copy( Mat.Strings[p],14,1 ),'T')>0 ) and ( trim(copy( Mat.Strings[p],colnossonum,11))<>'' )

      else if (numerobanco='237')  then

           condicao:= ( copy( Mat.Strings[p],1,1 )='1' )
// 18.12.19
      else if (numerobanco='001')  then

//           condicao:= ( AnsiPos( copy( Mat.Strings[p],14,1 ),'T;U')>0 )
           condicao:= ( AnsiPos( copy( Mat.Strings[p],14,1 ),'T')>0 )
// 05.02.20
      else if (numerobanco='422')  then  begin

         if not Global.topicos[1512] then

           condicao:= ( AnsiPos( copy( Mat.Strings[p],14,1 ),'T')>0 )
                      and
                      ( copy( Mat.Strings[p],16,2)='06'  )
         else

           condicao:= ( AnsiPos( copy( Mat.Strings[p],14,1 ),'T')>0 );

// ver como tratar o segmento U ref. juros..talvez fazer lista pelo nosso numero e guardar
//  juro ou desconto de cada titulo para colocar na mesma linha do titulo pra dar baixa depois

      end else

        condicao:=( copy( Mat.Strings[p],108,1 )='I' ) ;

      if numerobanco='748' then
//         condicao:=( copy( Mat.Strings[p],014,1 )='T' ) and ( trim(copy( Mat.Strings[p],047,11))<>'' );
// 27.03.14
         condicao:=( copy( Mat.Strings[p],01,01 )='1' )
// 07.05.15 - somente os titulos q 'cairam' no banco para 'n�o confundir'
//         and  (copy( Mat.Strings[p],14,01 )='C' )
                    and ( pos(copy( Mat.Strings[p],colmotivo,02 ),'B3/04')=0 )
//                    and ( pos(copy( Mat.Strings[p],colocorrencia,02 ),'02/28')=0 );
// 03.07.18 - recolocado as entradas para conferencia se houve boletos rejeitados
                    and ( pos(copy( Mat.Strings[p],colocorrencia,02 ),'28')=0 );
// 04.11.16 - itau
      if (numerobanco='341')  then
         condicao:= ( pos(copy( Mat.Strings[p],colocorrencia,02 ),'02/28/29')=0 ) and ( copy( Mat.Strings[p],1,1 )<>'9' )   ;

//         and ( texttovalor(copy( Mat.Strings[p],254,13))<>0 )
// 25.02.15 - retorno sicredi 'com e sem' registro no mesmo arquivo
       if (numerobanco='748') then begin

         if (copy( Mat.Strings[p],14,01 )='C' ) then begin
           colnossonum:=48;
           tamnossonum:=09;
           colparcela:=153;
           tamparcela:=11;
           coldecimais:=164;
           colvencimento:=0;
           tamvencimento:=0;
           tamnumerodoc:=0;
           colnumerodoc:=0;
           colmotivo:=319;
           colocorrencia:=109;
           tammotivo:=2;
           coldataocor:=111;
           tamdataocor:=6;

         end else begin  // com registro

           colnossonum:=48;
           tamnossonum:=09;
           colparcela:=153;
           tamparcela:=11;
           coldecimais:=164;
           colvencimento:=147;
           tamvencimento:=6;
           tamnumerodoc:=10;
           colnumerodoc:=117;
           colmotivo:=319;
           colocorrencia:=109;
           tammotivo:=2;   //10; deixado 2 por 'estetica
           coldataocor:=111;
           tamdataocor:=6;
         end;
       end;

//     if condicao then begin
//    18.12.18 - para nunca pegar a primeira linha do arquivo retorno
     if ( condicao ) and ( p>0 ) then begin

//        x:=FGeral.Procuragrid(grid.getcolumn('nossonumero'),copy( Mat.Strings[p],047,11 ),Grid);
        if p=0 then
          x:=1
        else
          inc(x);
// 14.09.16
        cnossonumero:=trim( copy( Mat.Strings[p],colnossonum,tamnossonum ) );

        if numerobanco='237' then begin
           cnossonumero:=copy( cnossonumero,09,15);
           Grid.Cells[grid.getcolumn('nossonumero'),abs(x)]:=trim( cnossonumero );
        end else begin

           Grid.Cells[grid.getcolumn('nossonumero'),abs(x)]:=trim( copy( Mat.Strings[p],colnossonum,tamnossonum ) );

        end;

        if colnumerodoc>0 then
          Grid.Cells[grid.getcolumn('pend_numerodcto'),abs(x)]:=trim( copy( Mat.Strings[p],colnumerodoc,tamnumerodoc ) );
        Grid.Cells[grid.getcolumn('pend_valor'),abs(x)]:=fGeral.formatavalor( texttovalor( copy(Mat.Strings[p],colparcela,tamparcela)+'.'+copy(Mat.Strings[p],coldecimais,02) ) ,f_cr);
//        if copy( Mat.Strings[p],colvencimento,tamvencimento )<>copy('00000000',1,tamvencimento) then begin

           if numerobanco='748' then begin

              if colvencimento>0 then begin
                dia:=copy( Mat.Strings[p],colvencimento,2 );
                mes:=copy( Mat.Strings[p],colvencimento+2,2 );
                ano:=copy( Mat.Strings[p],colvencimento+4,2 );
                Grid.Cells[grid.getcolumn('pend_datavcto'),abs(x)]:=FGeral.formatadata( Texttodate( dia+mes+ano) );
                vencimento:=Texttodate( dia+mes+ano ) ;
              end else begin
                vencimento:=Sistema.hoje;
//                vencimento:=0;
              end;
              Grid.Cells[grid.getcolumn('ocorrencia'),abs(x)]:=copy( Mat.Strings[p],colocorrencia,2 ) + '-' +
                                                                 GetOcorrencia(copy( Mat.Strings[p],colocorrencia,2 ));
              Grid.Cells[grid.getcolumn('motivo'),abs(x)]:=copy( Mat.Strings[p],colmotivo,tammotivo ) +  '-'+
                                                                 GetMotivo(copy( Mat.Strings[p],colmotivo,tammotivo ));
              if copy( Mat.Strings[p],14,01 ) = 'A' then begin
                Grid.Cells[grid.getcolumn('comsemreg'),abs(x)]:='S';
                dia:=copy( Mat.Strings[p],coldataocor,tamdataocor );
                Grid.Cells[grid.getcolumn('data'),abs(x)]:=FGeral.formatadata( Texttodate( dia) );
              end else begin
                Grid.Cells[grid.getcolumn('comsemreg'),abs(x)]:='N';
                dia:=copy( Mat.Strings[p],coldataocor,tamdataocor );
                Grid.Cells[grid.getcolumn('data'),abs(x)]:=FGeral.formatadata( Texttodate( dia) );
              end;

           end else begin

             if colvencimento>0 then begin

               Grid.Cells[grid.getcolumn('pend_datavcto'),abs(x)]:=FGeral.formatadata( Texttodate(copy( Mat.Strings[p],colvencimento,tamvencimento )) );
               vencimento:=Texttodate( copy( Mat.Strings[p],colvencimento,tamvencimento ) );

             end else vencimento:=Sistema.Hoje;  // 03.06.16

             Grid.Cells[grid.getcolumn('ocorrencia'),abs(x)]:=copy( Mat.Strings[p],colocorrencia,2 ) + '-' +
                                                                  GetOcorrencia(copy( Mat.Strings[p],colocorrencia,2 ));
             Grid.Cells[grid.getcolumn('motivo'),abs(x)]:=copy( Mat.Strings[p],colmotivo,tammotivo ) +  '-'+
                                                                 GetMotivo(copy( Mat.Strings[p],colmotivo,tammotivo ));

           end;
//        end;
        valor:=texttovalor( copy(Mat.Strings[p],colparcela,tamparcela)+'.'+copy(Mat.Strings[p],coldecimais,02) );
// 16.06.16
        jurosrecebidos:=0;
        descontosconcedidos:=0;
        if (numerobanco='001') and ( cnab240400='240' ) then begin


          if coljuros>0 then jurosrecebidos:=GetAcessorios(ListaJD, cnossonumero,'J' );
          if coldescontos>0 then descontosconcedidos:=GetAcessorios(ListaJD,cnossonumero,'D' );

        end else begin

           if coljuros>0 then jurosrecebidos:=TexttoValor( copy(Mat.Strings[p],coljuros,tamjuros)+'.'+copy(Mat.Strings[p],coljuros+tamjuros,02) );
           if coldescontos>0 then descontosconcedidos:=TexttoValor( copy(Mat.Strings[p],coldescontos,tamdescontos)+'.'+copy(Mat.Strings[p],coldescontos+tamdescontos,02) );

        end;

        Grid.Cells[grid.getcolumn('juros'),abs(x)]:=FGeral.formatavalor(jurosrecebidos,f_cr);
        Grid.Cells[grid.getcolumn('descontos'),abs(x)]:=FGeral.formatavalor(descontosconcedidos,f_cr);

// 09.09.16
//        if Global.Topicos[1293] then begin
// 12.07.18
        if ( Global.Topicos[1293] ) and ( AnsiPos( 'Entrada Confirmada', Grid.Cells[grid.getcolumn('ocorrencia'),abs(x)] ) = 0 )
          then begin

          Q:=sqltoquery('select pend_numerodcto,pend_tipo_codigo,pend_tipo_codigo,port_descricao,pend_unid_codigo,pend_datavcto from pendencias'+
                        ' left join portadores on ( port_codigo=pend_port_codigo )'+
                        ' where pend_opantecipa='+Stringtosql(cnossonumero)+
//                        ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                        sqldatacont+
                        ' and pend_status=''N'''+
                        ' and pend_rp=''R'''+
                        ' and pend_valor='+Valortosql(valor)+
                        ' and '+FGeral.GetIN('pend_unid_codigo',global.usuario.UnidadesMvto,'C') );
          if Q.eof then begin
// 15.04.18 - verifica se � boleto q somou varias notas
            Q.close ;
            Q:=sqltoquery('select pend_transacao from pendencias'+
                        ' left join portadores on ( port_codigo=pend_port_codigo )'+
                        ' where pend_opantecipa='+Stringtosql(cnossonumero)+
                        ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                        ' and pend_status=''N'''+
                        ' and pend_rp=''R'''+
                        ' and '+FGeral.GetIN('pend_unid_codigo',global.usuario.UnidadesMvto,'C') );

            if Q.Eof then begin

              Q.Close;
              Q:=sqltoquery('select pend_transacao from pendencias'+
                        ' left join portadores on ( port_codigo=pend_port_codigo )'+
                        ' where pend_opantecipa='+Stringtosql(cnossonumero)+
//                        ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                        sqldatacont+
                        ' and pend_status=''B'''+
                        ' and pend_rp=''R'''+
                        ' and '+FGeral.GetIN('pend_unid_codigo',global.usuario.UnidadesMvto,'C') );
              if Q.Eof then begin
                Grid.Cells[grid.getcolumn('pend_datavcto'),abs(x)]:='';
                Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:='Nosso numero n�o encontrado.';
              end else begin
                Grid.Cells[grid.getcolumn('pend_datavcto'),abs(x)]:='';
                Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:='J� Baixado';
              end;


            end else begin

                Grid.Cells[grid.getcolumn('pend_datavcto'),abs(x)]:='';
                Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:='V�rias Notas somadas';

            end;

          end else begin

            Grid.Cells[grid.getcolumn('pend_datavcto'),abs(x)]:=FGeral.formatadata( Q.fieldbyname('pend_datavcto').asdatetime );
            Grid.Cells[grid.getcolumn('pend_numerodcto'),abs(x)]:=formatfloat('000000',texttovalor(Q.fieldbyname('pend_numerodcto').asstring));
            Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:=FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').asinteger,
                                                         'C','N');
            Grid.Cells[grid.getcolumn('portador'),abs(x)]:=Q.fieldbyname('port_descricao').asstring;
            Grid.Cells[grid.getcolumn('pend_unid_codigo'),abs(x)]:=Q.fieldbyname('pend_unid_codigo').asstring;
            Grid.Cells[grid.getcolumn('pend_tipo_codigo'),abs(x)]:=inttostr(Q.fieldbyname('pend_tipo_codigo').asinteger);
            inc(nencontrados);

          end;
// 12.11.2021
// retirado pois inicializa no inicio
////////////////////////
{
          if Numerobanco='748' then begin
            ocorrencias:='06;09';
          end else begin
            ocorrencias:='06;08';
          end;
          }
//////////////////////////////////
          if pos( copy( Mat.Strings[p],colocorrencia,2 ),ocorrencias) > 0 then
            valortotalpago:=valortotalpago+valor;
          if Q.eof then begin
              FGeral.Fechaquery(Q);
              Q:=sqltoquery('select pend_numerodcto,pend_tipo_codigo,pend_tipo_codigo,port_descricao,pend_unid_codigo,pend_datavcto from pendencias'+
                          ' left join portadores on ( port_codigo=pend_port_codigo )'+
                          ' where pend_datavcto>'+Datetosql(vencimento-10)+
//                          ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                          sqldatacont+
                          ' and pend_status=''B'''+
                          ' and pend_rp=''R'''+
                          ' and pend_valor='+Valortosql(valor)+
                          ' and '+FGeral.GetIN('pend_unid_codigo',global.usuario.UnidadesMvto,'C') );
              if not Q.eof then
                 Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:='J� Baixado';
          end;
          FGeral.Fechaquery(Q);

        end else if vencimento > 0 then begin

          Q:=sqltoquery('select pend_numerodcto,pend_tipo_codigo,pend_tipo_codigo,port_descricao,pend_unid_codigo from pendencias'+
                        ' left join portadores on ( port_codigo=pend_port_codigo )'+
                        ' where pend_datavcto='+Datetosql(vencimento)+
//                        ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                        sqldatacont+
                        ' and pend_status=''N'''+
                        ' and pend_rp=''R'''+
                        ' and pend_valor='+Valortosql(valor)+
                        ' and '+FGeral.GetIN('pend_unid_codigo',global.usuario.UnidadesMvto,'C') );
// 27.03.14
          if Q.Eof then begin
            FGeral.FechaQuery(Q);
            Q:=sqltoquery('select pend_numerodcto,pend_tipo_codigo,pend_tipo_codigo,port_descricao,pend_unid_codigo,pend_datavcto from pendencias'+
                        ' left join portadores on ( port_codigo=pend_port_codigo )'+
                        ' where pend_datavcto>'+Datetosql(vencimento-60)+
//                        ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                        sqldatacont+
                        ' and pend_status=''N'''+
                        ' and pend_rp=''R'''+
                        ' and pend_valor='+Valortosql(valor)+
                        ' and '+FGeral.GetIN('pend_unid_codigo',global.usuario.UnidadesMvto,'C') );
            if Q.RecordCount=1 then
//            if not Q.eof then
              Grid.Cells[grid.getcolumn('pend_datavcto'),abs(x)]:=FGeral.formatadata( Q.fieldbyname('pend_datavcto').asdatetime )
            else begin
              Grid.Cells[grid.getcolumn('pend_datavcto'),abs(x)]:='';
            end;
          end;
          if (not Q.eof) and (Q.RecordCount=1) then begin
            Grid.Cells[grid.getcolumn('pend_numerodcto'),abs(x)]:=formatfloat('000000',texttovalor(Q.fieldbyname('pend_numerodcto').asstring));
            Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:=FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').asinteger,
                                                         'C','N');
            Grid.Cells[grid.getcolumn('portador'),abs(x)]:=Q.fieldbyname('port_descricao').asstring;
// 30.09.10
            Grid.Cells[grid.getcolumn('pend_unid_codigo'),abs(x)]:=Q.fieldbyname('pend_unid_codigo').asstring;
            Grid.Cells[grid.getcolumn('pend_tipo_codigo'),abs(x)]:=inttostr(Q.fieldbyname('pend_tipo_codigo').asinteger);
            inc(nencontrados);
          end;
// 18.07.16 - Novicarnes - Rose ( auxiliar Sandro ) - somar somente o que 'caiu na conta' sem alteracoes de vencimento
// 12.11.2021 - retirado pois ja inicializa 'acima'
///////////////////////////////////////
{
          if Numerobanco='748' then begin
            ocorrencias:='06;09';
          end else begin
            ocorrencias:='06;08';
          end;
          }
//////////////////
          if pos( copy( Mat.Strings[p],colocorrencia,2 ),ocorrencias) > 0 then
            valortotalpago:=valortotalpago+valor;
///////////////
// 28.03.14 - ver se ja foi baixado e informar na tela
          if Q.eof then begin
              FGeral.Fechaquery(Q);
              Q:=sqltoquery('select pend_numerodcto,pend_tipo_codigo,pend_tipo_codigo,port_descricao,pend_unid_codigo,pend_datavcto from pendencias'+
                          ' left join portadores on ( port_codigo=pend_port_codigo )'+
                          ' where pend_datavcto>'+Datetosql(vencimento-60)+
//                          ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                          sqldatacont+
                          ' and pend_status=''B'''+
                          ' and pend_rp=''R'''+
                          ' and pend_valor='+Valortosql(valor)+
                          ' and '+FGeral.GetIN('pend_unid_codigo',global.usuario.UnidadesMvto,'C') );
              if not Q.eof then
                 Grid.Cells[grid.getcolumn('clie_nome'),abs(x)]:='J� Baixado';
          end;
          FGeral.Fechaquery(Q);
        end;


        if numerobanco='104' then begin
          if copy( Mat.Strings[p],047,06 )='870000' then
            inc(nbloquetos)
          else
            inc(nnaoprocessados);
          Grid.Cells[grid.getcolumn('tarifa'),abs(x)]:=fGeral.formatavalor( texttovalor( copy(Mat.Strings[p],199,13)+'.'+copy(Mat.Strings[p],212,02) ) ,'##0.00');
        end else
          inc(nnaoprocessados);
// 23.06.18
        if AnsiPos( 'Entrada Confirmada', Grid.Cells[grid.getcolumn('ocorrencia'),abs(x)] ) > 0 then
           Inc(nboletosent);

        Grid.AppendRow;

      end else if copy( Mat.Strings[p],014,1 )='U' then begin
//        if copy( Mat.Strings[p],138,08 )<>'00000000' then
//          Grid.Cells[grid.getcolumn('ocorrencia'),p]:=FGeral.formatadata( Texttodate(copy( Mat.Strings[p],138,08 )) );
        valortotalpago:=valortotalpago+texttovalor( copy(Mat.Strings[p],018,13)+'.'+copy(Mat.Strings[p],031,02) );
        Grid.Cells[grid.getcolumn('juros'),x]:=fGeral.formatavalor( texttovalor( copy(Mat.Strings[p],018,13)+'.'+copy(Mat.Strings[p],031,02) ) ,'##0.00');
        Grid.Cells[grid.getcolumn('descontos'),x]:=fGeral.formatavalor( texttovalor( copy(Mat.Strings[p],033,13)+'.'+copy(Mat.Strings[p],046,02) ) ,'##0.00');
// 27.06.18
        dia:=copy( Mat.Strings[p],coldataocor,tamdataocor );
        Grid.Cells[grid.getcolumn('data'),abs(x)]:=FGeral.formatadata( Texttodate( dia) );

//        Grid.AppendRow;
      end;
// 06.01.20 - Vida Nova
//////////////////////////
        if ( trim(copy(Grid.cells[Grid.getcolumn('data'),x],1,2))<>'' )
           and
           ( pos(copy(Grid.Cells[Grid.getcolumn('ocorrencia'),x],1,2),ocorrencias)>0 )
           and (Grid.Cells[Grid.getcolumn('nossonumero'),x]<>'') and
           (Grid.Cells[grid.getcolumn('clie_nome'),x]<>'J� Baixado')
          then begin

          if BaixaInicial <  Texttodate( FGeral.TiraBarra( Grid.cells[Grid.getcolumn('data'),x] ) ) then

             BaixaInicial:=Texttodate( FGeral.TiraBarra( Grid.cells[Grid.getcolumn('data'),x] ) )

          else

             BaixaFinal:=Texttodate( FGeral.TiraBarra( Grid.cells[Grid.getcolumn('data'),x] ) );


        end;

   end;

   Sistema.EndProcess('');

   Ednrobloquetes.setvalue(nbloquetos);
   EdValorpago.setvalue(valortotalpago);
   Edencontrados.setvalue(nencontrados);
   Ednaotratados.setvalue(nnaoprocessados);
// 23.06.18
   EdBoletosentrada.SetValue( nboletosent );
   EdBoletosenviados.SetValue( GetBolEnviados( EdDataBaixa.AsDate ) );
   if EdBoletosentrada.AsInteger<>EdBoletosenviados.AsInteger then
      botaostatus.Kind:=bkno
   else
      botaostatus.Kind:=bkOK;

   Grid.setfocus;
end;

procedure TFBaixaCobranca.griddblclick(Sender: TObject);
////////////////////////////////////////////////////////////
var ocorrencia : string;

   procedure Setatitulos;
   //////////////////////
   var Q:TSqlquery;
       vencimento:TDatetime;
       detalhe:string;
       valor:currency;
   begin
     EdSeunumero.Items.clear;
     valor:= Texttovalor( Grid.cells[Grid.getcolumn('pend_valor'),Grid.row] );
     if trim(Grid.cells[Grid.getcolumn('pend_datavcto'),Grid.row])<>'' then begin
       vencimento:=Texttodate( FGeral.tirabarra(Grid.cells[Grid.getcolumn('pend_datavcto'),Grid.row]) );
       Q:=sqltoquery('select pend_numerodcto,pend_tipo_codigo,pend_tipo_codigo,port_descricao,clie_nome,pend_valor,'+
                        ' pend_datavcto,pend_UNID_CODIGO,pend_parcela,pend_operacao from pendencias'+
                        ' left join portadores on ( port_codigo=pend_port_codigo )'+
                        ' left join clientes on ( clie_codigo=pend_tipo_codigo )'+
                        ' where pend_datavcto='+Datetosql(vencimento)+
                        ' and '+FGeral.GetIN('pend_unid_codigo',global.usuario.UnidadesMvto,'C')+
//                        ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                        sqldatacont+
// 28.03.14
                        ' and pend_valor='+Valortosql(valor)+
                        ' and pend_rp=''R'''+
                        ' and pend_status=''N'''+
                        ' order by pend_numerodcto' );
     end else begin
       vencimento:=Sistema.hoje-20;
       Q:=sqltoquery('select pend_numerodcto,pend_tipo_codigo,pend_tipo_codigo,port_descricao,'+
                        'clie_nome,pend_valor,pend_datavcto,pend_unid_codigo,pend_parcela,pend_operacao from pendencias'+
                        ' left join portadores on ( port_codigo=pend_port_codigo )'+
                        ' left join clientes on ( clie_codigo=pend_tipo_codigo )'+
                        ' where '+FGEral.GetIN('pend_unid_codigo',global.usuario.UnidadesMvto,'C')+
                        ' and pend_datavcto>='+Datetosql(vencimento)+
//                        ' and pend_datacont > '+Datetosql(Global.DataMenorBanco)+
                        sqldatacont+
// 28.03.14
                        ' and pend_valor='+Valortosql(valor)+
                        ' and pend_rp=''R'''+
                        ' and pend_datavcto<='+Datetosql(Sistema.hoje+20)+
                        ' and pend_status=''N'''+
                        ' order by pend_numerodcto' );
     end;
     while not Q.eof do begin
         detalhe:=formatfloat('000000',texttovalor(Q.fieldbyname('pend_numerodcto').asstring))+'  '+
//                  strspace(Q.fieldbyname('pend_valor').asstring,10)+'  '+
                  fGeral.formatavalor(Q.fieldbyname('pend_valor').ascurrency,'##,##0.00')+'  '+
                  fGeral.formatadata(Q.fieldbyname('pend_datavcto').asdatetime)+' '+
                  copy(Q.fieldbyname('clie_nome').asstring,1,20)+' Parc.  '+
                  Q.fieldbyname('pend_parcela').asstring+ ' Un. '+
                  Q.fieldbyname('pend_unid_codigo').asstring+' OP.:'+Q.fieldbyname('pend_operacao').asstring ;
         unidadetituloachado:=Q.fieldbyname('pend_unid_codigo').asstring;
         EdSeunumero.Items.add(detalhe);
         Q.Next;
     end;
   end;

begin

// 12.11.2021 - s� deixa procurar o numero nos baixados no banco
  ocorrencia := copy( Grid.Cells[Grid.getcolumn('ocorrencia'),Grid.Row],1,2);
  if ( AnsiPos( ocorrencia,Ocorrencias ) > 0 )  and ( trim(ocorrencia)<>'' ) then begin

    if Grid.Col=Grid.getcolumn('pend_numerodcto') then begin

       EdSeuNumero.Top:=Grid.TopEdit;
       EdSeuNumero.Left:=Grid.LeftEdit+1;
  //     EdSeuNumero.Text:=StrToStrNumeros(GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]);
       EdSeuNumero.Visible:=True;
       EdSeuNumero.Enabled:=True;
       EdSeunumero.text:=Grid.Cells[Grid.Col,Grid.Row];
       Setatitulos;
       EdSeuNumero.SetFocus;

    end else if Grid.Col=Grid.getcolumn('pend_datavcto') then begin

       EdVencimento.Top:=Grid.TopEdit;
       EdVencimento.Left:=Grid.LeftEdit+1;
       EdVencimento.Visible:=True;
       EdVencimento.Enabled:=True;
       EdVencimento.text:=FGeral.tirabarra(Grid.Cells[Grid.Col,Grid.Row]);
       EdVencimento.SetFocus;

    end;

  end;

end;

procedure TFBaixaCobranca.EdSeunumeroExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////////////
var x:integer;
    xcodcli:string;

     Function GetTipoCodigo(s:string):string;
     //////////////////////////////////////////
     var d:integer;
         c:string;
         QC:TSqlquery;
     begin
       d:=pos('OP.:',s);
       if d>0 then begin
         d:=d+4;
         c:=trim(copy(s,d,16));
         Qc:=sqltoquery('select pend_tipo_codigo from pendencias where pend_operacao='+Stringtosql(c));
         if not Qc.eof then c:=Qc.fieldbyname('pend_tipo_codigo').AsString else c:='';
         Qc.Close;
       end else c:='';
       result:=c;
     end;

begin

  if not EdSeuNumero.IsEmpty then begin
    Grid.Cells[Grid.Col,Grid.Row]:=copy(EdSeunumero.text,1,6);
// 30.09.10
    Grid.Cells[Grid.GetColumn('pend_unid_codigo'),Grid.Row]:=unidadetituloachado;
// 28.03.14
{
    for x:=0 to EdSeuNumero.Items.Count-1 do begin
      if pos(EdSeunumero.text,EdSeuNumero.Items.Strings[x])>0 then
        Grid.Cells[Grid.GetColumn('pend_datavcto'),Grid.Row]:=copy(EdSeuNumero.Items.Strings[x],20,8);
    end;
    }
// 03.06.16
    Grid.Cells[Grid.GetColumn('pend_datavcto'),Grid.Row]:=copy(EdSeuNumero.text,20,8);
// 04.11.16
    xcodcli:= GetTipoCodigo(EdSeuNumero.text);
    Grid.Cells[Grid.GetColumn('pend_tipo_codigo'),Grid.Row]:=xcodcli;
    Grid.Cells[Grid.GetColumn('clie_nome'),Grid.Row]:=FGeral.GetNomeRazaoSocialEntidade(strtointdef(xcodcli,0),'C','R' );
  end;
  Grid.SetFocus;
  EdEncontrados.setvalue(EdEncontrados.asinteger+1);
  EdSeunumero.Visible:=False;
  EdSeunumero.Enabled:=False;

end;

procedure TFBaixaCobranca.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    griddblclick(self);
end;

procedure TFBaixaCobranca.EdSeunumeroValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var p:integer;
    achou:boolean;

begin
  achou:=false;
  if not EdSeunumero.isempty then begin
    for p:=1 to Grid.rowcount do begin
//      if ( Grid.cells[grid.getcolumn('pend_numerodcto'),p]=EdSeunumero.text ) and
      if ( pos(Grid.cells[grid.getcolumn('pend_numerodcto'),p],EdSeunumero.text)>0 ) and
         ( p<>grid.row ) then begin
         achou:=true;
         break
      end;
    end;
    if achou then
      EdSeunumero.invalid('N�mero j� utilizado no nosso n�mero '+Grid.cells[grid.getcolumn('nossonumero'),p]);
  end;
end;

procedure TFBaixaCobranca.EdvencimentoExitEdit(Sender: TObject);
begin
  if not EdVencimento.IsEmpty then
    Grid.Cells[Grid.Col,Grid.Row]:=FGeral.formatadata(EdVencimento.asdate)
  else
    Grid.Cells[Grid.Col,Grid.Row]:='';
  Grid.SetFocus;
  EdVencimento.Visible:=False;
  EdVencimento.Enabled:=False;

end;

procedure TFBaixaCobranca.bpendentesClick(Sender: TObject);
begin
  if not Sistema.Processando then FRelFinan_Pendentes('R'); ;

end;

procedure TFBaixaCobranca.GridDrawCell(Sender: TObject; ACol,  ARow: Integer; Rect: TRect; State: TGridDrawState);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var s:string;
    t:integer;
begin
  if (not (gdSelected in State)) and (ARow>0) then begin

// 26.09.18 - Vidanova
    if  (Grid.Cells[Grid.getcolumn('pend_datavcto'),arow]<>'') and (Grid.Cells[Grid.getcolumn('nossonumero'),arow]<>'') and
       ( AnsiPos( 'BAIXA',Uppercase(Grid.Cells[grid.getcolumn('ocorrencia'),arow]))>0 )
    then begin
           Grid.Canvas.Brush.Color := clyellow;
           s:=Grid.Cells[ACol,ARow];
           Grid.Canvas.FillRect(Rect);
           t:=Grid.Canvas.TextWidth(s)+2;
           if Grid.Columns[ACol].Alignment=taRightJustify then
              Grid.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else Grid.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);


 // 23.11.16
    end else if  ( pos(copy(Grid.Cells[Grid.getcolumn('ocorrencia'),arow],1,2),ocorrencias)=0 ) and (Grid.Cells[Grid.getcolumn('nossonumero'),arow]<>'') and
       (Grid.Cells[grid.getcolumn('clie_nome'),arow]<>'J� Baixado')
    then begin
           Grid.Canvas.Brush.Color := clAqua;
           s:=Grid.Cells[ACol,ARow];
           Grid.Canvas.FillRect(Rect);
           t:=Grid.Canvas.TextWidth(s)+2;
           if Grid.Columns[ACol].Alignment=taRightJustify then
              Grid.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else Grid.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);

    end else if (Grid.Cells[Grid.getcolumn('pend_datavcto'),arow]='') and (Grid.Cells[Grid.getcolumn('nossonumero'),arow]<>'') and
       ( pos('encontrado',Grid.Cells[grid.getcolumn('clie_nome'),arow])>0 )
    then begin
           Grid.Canvas.Brush.Color := clMoneyGreen;
           s:=Grid.Cells[ACol,ARow];
           Grid.Canvas.FillRect(Rect);
           t:=Grid.Canvas.TextWidth(s)+2;
           if Grid.Columns[ACol].Alignment=taRightJustify then
              Grid.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else Grid.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);

    end else if  (Grid.Cells[Grid.getcolumn('pend_datavcto'),arow]='') and (Grid.Cells[Grid.getcolumn('nossonumero'),arow]<>'') and
       (Grid.Cells[grid.getcolumn('clie_nome'),arow]<>'J� Baixado')
    then begin
           Grid.Canvas.Brush.Color := clred;
           s:=Grid.Cells[ACol,ARow];
           Grid.Canvas.FillRect(Rect);
           t:=Grid.Canvas.TextWidth(s)+2;
           if Grid.Columns[ACol].Alignment=taRightJustify then
              Grid.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else Grid.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);

    end else begin
// 13.07.18
           Grid.Canvas.Brush.Color := clSkyblue;
           s:=Grid.Cells[ACol,ARow];
           Grid.Canvas.FillRect(Rect);
           t:=Grid.Canvas.TextWidth(s)+2;
           if Grid.Columns[ACol].Alignment=taRightJustify then
              Grid.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else Grid.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);

    end;

  end;
end;

// 08.11.16
procedure TFBaixaCobranca.EdDataBaixaValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin
   if not FGeral.ValidaMvto(EdDAtaBaixa) then EdDataBaixa.Invalid('');
end;

procedure TFBaixaCobranca.bSairClick(Sender: TObject);
begin

end;

// 08.11.16
procedure TFBaixaCobranca.bexcluiClick(Sender: TObject);
/////////////////////////////////////////////////////////
var valor:currency;
    seunumero:string;
begin
  seunumero:=Grid.cells[Grid.getcolumn('pend_numerodcto'),Grid.row];
  if not confirma('Confirma a exclus�o do boleto ref. documento '+seunumero+' ?') then exit;
   EdEncontrados.setvalue(EdEncontrados.asinteger-1);
   valor:= Texttovalor( Grid.cells[Grid.getcolumn('pend_valor'),Grid.row] );
   EdValorpago.setvalue(EdValorpago.ascurrency-valor);
   Grid.DeleteRow(Grid.row);
   Grid.Refresh;
end;

// 11.02.20
procedure TFBaixaCobranca.EdbancoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
begin

 QBanco:=sqltoquery('select * from plano where plan_conta='+EdBanco.assql);
 if not QBanco.eof then begin

    EdBanco_descricao.text:=QBanco.fieldbyname('plan_descricao').asstring;
    if trim(QBanco.fieldbyname('Plan_codigobanco').asstring)='' then begin
      EdBAnco.invalid('Codigo do Banco n�o configurado nas contas gerenciais');
      exit;
    end;

    opendialog1.filterindex:=1 ;

    if trim(QBanco.fieldbyname('Plan_codigobanco').asstring)='422' then begin

       opendialog1.filterindex:=3

    end else if trim(QBanco.fieldbyname('Plan_codigobanco').asstring)='748' then begin

       opendialog1.filterindex:=2

    end;
// 12.11.2021 - Guiber  - aqui para direcionar 'geral' o q mostra/baixa
    if Numerobanco='748' then begin

      ocorrencias:='06;07;09';

    end else if Numerobanco=' 756' then begin

  //    ocorrencias:='06;09';
      ocorrencias:='06';

    end else if Numerobanco='104' then begin

      ocorrencias:='06';

    end else if Numerobanco='001' then begin

      ocorrencias:='04;06';

    end else begin

      ocorrencias:='06';

    end;

 end else

    EdBAnco.invalid('Banco n�o encontrado');



end;

end.
