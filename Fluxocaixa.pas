unit Fluxocaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid;

type
  TFFluxoCaixa = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PAcerto: TSQLPanelGrid;
    EdDtinicio: TSQLEd;
    EdDtFim: TSQLEd;
    PDetalhe: TSQLPanelGrid;
    GridDetalhe: TSqlDtGrid;
    Edunid_codigo: TSQLEd;
    EdSaldoanterior: TSQLEd;
    bfechar: TSQLBtn;
    St: TStaticText;
    Edescolha: TSQLEd;
    bimpressao: TSQLBtn;
    PTotais: TSQLPanelGrid;
    EdChequesre: TSQLEd;
    EdRecebe: TSQLEd;
    Edpedvenda: TSQLEd;
    EdTotalre: TSQLEd;
    EdChequesemi: TSQLEd;
    EdPagamentos: TSQLEd;
    EdPedcompra: TSQLEd;
    EdTotalpa: TSQLEd;
    EdAtrasomedio: TSQLEd;
    Edtotal: TSQLEd;
    EdPrazodia: TSQLEd;
    EdAtraso: TSQLEd;
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure EdDtFimValidate(Sender: TObject);
    procedure GridClick(Sender: TObject);
    procedure bfecharClick(Sender: TObject);
    procedure EdescolhaExitEdit(Sender: TObject);
    procedure bimpressaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure ProcessaFluxo;
    procedure Detalha(coluna:string ; data:string );
    function TrazAtraso(codigo:integer):integer;

  end;

type TValores=record
   Dia:TDatetime;
   chequesrec,receber,chequespag,pagar,previsaopagar,pedidosvenda:currency;
end;

type TAtrasos=record
   cliente,atraso:integer;
end;

var
  FFluxoCaixa: TFFluxoCaixa;
  sqlacesso,sqlunidade:string;
  ListaValores,ListaAtrasosMedio:Tlist;
  PValores:^TValores;
  PAtrasos:^TAtrasos;


implementation

uses Geral, SqlSis, SqlExpr, Sqlfun, represen, portador, SQLRel, conpagto,
  Unidades;

{$R *.dfm}

{ TFFluxoCaixa }

procedure TFFluxoCaixa.Execute;
begin
   if EdDtinicio.isempty then begin
     EdDtinicio.setdate(sistema.hoje);
     EdDtfim.setdate(sistema.hoje);
   end;
   Grid.clear;
   GridDetalhe.clear;
   FUnidades.SetaItems(EdUnid_codigo,nil,global.Usuario.UnidadesRelatorios);
   PDetalhe.visible:=false;
   bimpressao.enabled:=false;
   show;
   if EdUnid_codigo.isempty then
     EdUnid_codigo.text:=Global.codigounidade;
   EdDtinicio.setfocus;
end;

procedure TFFluxoCaixa.Edunid_codigoValidate(Sender: TObject);
begin
  if EdUnid_codigo.isempty then
    EdUnid_codigo.Text:=Global.Usuario.UnidadesRelatorios;

end;

procedure TFFluxoCaixa.EdDtFimValidate(Sender: TObject);
begin
   if EdDtfim.asdate<EdDtinicio.asdate then
     Eddtfim.invalid('Data final tem que ser maior ou igual que inicial');
end;

procedure TFFluxoCaixa.ProcessaFluxo;
////////////////////////////////////////////////
var Q,QSaldo,QPedCompra:TSqlquery;
    saldoanterior,saldo:currency;
    data,vencimento,novovencimento:TDatetime;
    PValores:^TValores;
    p,mesant,anoant,x,atrasomedio:integer;
    mesanoanterior,mesano,checaratraso:string;
    lanca:boolean;

    function  ChecaBaixaParcial(unidade,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer):currency;
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var Qbx:TSqlquery;
        status,sqlqtipo:string;
        valor:currency;
    begin
      status:=stringtosql('P');
      if Datacont>1 then
//        sqlqtipo:=' and pend_datacont>1'
// 27.09.11
        sqlqtipo:=' and pend_datacont > '+Datetosql(Global.DataMenorBanco)
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

    procedure AtualizaAtraso(codigo,atrasomedio:integer);
    ////////////////////////////////////////////////////////
    var l:integer;
        achou:boolean;
    begin
      achou:=false;
      for l:=0 to ListaAtrasosMedio.count-1 do begin
        PAtrasos:=ListaAtrasosMedio[l];
        if PAtrasos.cliente=codigo then begin
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
        New(PAtrasos);
        PAtrasos.cliente:=codigo;
        PAtrasos.atraso:=atrasomedio;
        ListaAtrasosmedio.add(PAtrasos);
      end;
    end;

    function MediaAtraso:integer;
    //////////////////////////////
    var l,atrasos:integer;
    begin
      atrasos:=0;
      for l:=0 to ListaAtrasosMedio.count-1 do begin
        PAtrasos:=ListaAtrasosMedio[l];
        atrasos:=atrasos+PAtrasos.atraso;
      end;
      if LIstaAtrasosmedio.count>0 then
        result:=trunc(atrasos/LIstaAtrasosmedio.count)
      else
        result:=0;
    end;

begin
///////////////////////////////////////////////////////
    saldoanterior:=0;
    data:=EdDtInicio.asdate;
    ListaValores:=Tlist.create;
    ListaAtrasosMedio:=Tlist.create;
    Grid.clear;
    EdChequesre.setvalue( 0 );
    Edrecebe.setvalue( 0 );
    EdPedvenda.setvalue( 0 );
    EdTotalre.setvalue( 0 );
    EdChequesemi.setvalue( 0 );
    EdPagamentos.setvalue( 0 );
    EdPedcompra.setvalue( 0 );
    EdTotalpa.setvalue( 0 );
    EdAtrasoMedio.setvalue( 0 );
    while data<=EdDtfim.asdate do begin
      New(PValores);
      PValores.Dia:=data;
      PValores.chequesrec:=0;
      PValores.receber:=0;
      PValores.chequespag:=0;
      PValores.pagar:=0;
      PValores.previsaopagar:=0;
      PValores.pedidosvenda:=0;
      Listavalores.add(PValores);
      data:=data+1;
    end;
    if Listavalores.count=0 then exit;
    mesano:=strzero(datetomes(EdDtinicio.asdate),2)+strzero(datetoano(EdDtinicio.asdate,true),4);
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
    if pos( '1',EdEscolha.text ) > 0 then begin
      Sistema.Setmessage('Calculando valores dia a dia dos cheques recebidos');
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
//                    ' and cheq_emirec=''R'''+
                    sqlunidade+
                    ' and cheq_valor>0'+
                    ' and cheq_predata='+Datetosql(Pvalores.Dia)+sqlacesso+
                    ' and cheq_deposito is null'+
                    ' order by cheq_predata' );

        while not Q.Eof do begin
          if Q.FieldByName('cheq_emirec').AsString='R' then
            PValores.chequesrec:=PValores.chequesrec+Q.fieldbyname('cheq_valor').ascurrency
          else
            PValores.chequespag:=PValores.chequespag+Q.fieldbyname('cheq_valor').ascurrency;
          Q.Next;
        end;
      end;
      Q.close;

    end;

    if pos( '2',EdEscolha.text ) > 0 then begin
      Sistema.Setmessage('Calculando valores dia a dia do contas a receber');
      if trim(EdUnid_codigo.text)<>'' then
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')
      else
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
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

        if EdAtraso.text='S' then
          checaratraso:='S'
        else
          checaratraso:='N';
        while not Q.Eof do begin
          if checaratraso='S' then
            atrasomedio:=FGeral.GetAtrasomedio(Q.fieldbyname('pend_tipo_codigo').asinteger,'C',90,EdDtinicio.asdate,EdUnid_codigo.text)
          else
            atrasomedio:=0;
          AtualizaAtraso(Q.fieldbyname('pend_tipo_codigo').asinteger,atrasomedio);
          novovencimento:=PValores.dia+atrasomedio;
          lanca:=true;
          if atrasomedio>0 then begin
            lanca:=false;
            for x:=0 to Listavalores.count-1 do begin
              PValores:=Listavalores[x];
              if Pvalores.dia=novovencimento then begin
                lanca:=true;
                break;
              end;
            end;
          end;
          if lanca then begin
            if Q.fieldbyname('pend_status').asstring='A' then  // 31.05.05 - deduz antecipacoes
              PValores.receber:=PValores.receber-Q.fieldbyname('pend_valor').ascurrency
            else
              PValores.receber:=PValores.receber+Q.fieldbyname('pend_valor').ascurrency;
            PValores.receber:=PValores.receber-ChecaBaixaParcial(Q.fieldbyname('pend_unid_codigo').asstring,Q.fieldbyname('pend_tipo_codigo').asstring,
                              Q.fieldbyname('pend_tipocad').asstring,Q.fieldbyname('pend_numerodcto').asstring,
                              Q.fieldbyname('pend_datamvto').asdatetime,Q.fieldbyname('pend_datacont').asdatetime,
                              Q.fieldbyname('pend_datavcto').asdatetime,Q.fieldbyname('pend_parcela').asinteger );
          end;
// 29.12.06 - Reges+Joacir - 'descompasso' com relat. de pendentes
// para 'voltar no lugar'...
          PValores:=Listavalores[p];

          Q.Next;
        end;
      end;
      Q.close;
    end;

    if (pos( '4',EdEscolha.text ) > 0) or  (pos( '5',EdEscolha.text ) > 0) then begin
      Sistema.Setmessage('Calculando valores dia a dia do contas a pagar');
      if trim(EdUnid_codigo.text)<>'' then
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')
      else
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
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
          if pos(Q.fieldbyname('pend_status').asstring,'A;P')>0 then begin // 31.05.05 - deduz antecipacoes - 30.11.05 - baixas parciais
            if pos( '4',EdEscolha.text ) > 0 then
              PValores.pagar:=PValores.Pagar-Q.fieldbyname('pend_valor').ascurrency
          end else begin
            if Q.fieldbyname('pend_status').asstring='H' then begin
              if Q.fieldbyname('pend_tipomov').asstring=global.CodPendenciaFinanceira then begin
                if pos( '4',EdEscolha.text ) > 0 then
                  PValores.pagar:=PValores.Pagar+Q.fieldbyname('pend_valor').ascurrency
              end else begin
                if pos( '5',EdEscolha.text ) > 0 then begin
// 20.05.09 - checa se o pedido de compra t� em aberto, ou seja, a nota ainda nao chegou ou nao foi informado
                  QPedCompra:=Sqltoquery('select mocm_transacao from movcomp where mocm_transacao='+Stringtosql(Q.fieldbyname('pend_transacao').asstring)+
                                         ' and mocm_datarecebido is null'+
                                         ' and mocm_unid_codigo='+Stringtosql(Q.fieldbyname('pend_unid_codigo').asstring)+
                                         ' and mocm_status<>''C''');
                  if not QPedCompra.eof then
                    PValores.previsaopagar:=PValores.PrevisaoPagar+Q.fieldbyname('pend_valor').ascurrency;
                  FGeral.FechaQuery(QPedCompra);
                end;
              end;
            end else begin
              if pos( '4',EdEscolha.text ) > 0 then
                PValores.pagar:=PValores.Pagar+Q.fieldbyname('pend_valor').ascurrency;
            end;
          end;
          PValores.pagar:=PValores.pagar-ChecaBaixaParcial(Q.fieldbyname('pend_unid_codigo').asstring,Q.fieldbyname('pend_tipo_codigo').asstring,
                            Q.fieldbyname('pend_tipocad').asstring,Q.fieldbyname('pend_numerodcto').asstring,
                            Q.fieldbyname('pend_datamvto').asdatetime,Q.fieldbyname('pend_datacont').asdatetime,
                            Q.fieldbyname('pend_datavcto').asdatetime,Q.fieldbyname('pend_parcela').asinteger );
          Q.Next;
        end;
      end;
      Q.close;
    end;

// 30.10.06 - pedidos de venda j� faturado
    if pos( '6',EdEscolha.text ) > 0 then begin
//      Sistema.Setmessage('Calculando valores dia a dia dos pedidos de venda faturados');
      Sistema.Setmessage('Calculando valores dos pedidos de venda pendentes e autorizados a faturar');
      if trim(EdUnid_codigo.text)<>'' then
//        sqlunidade:=' and '+FGeral.getin('mped_unid_codigo',EdUnid_codigo.text,'C')
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')
      else
//        sqlunidade:=' and '+FGeral.getin('mped_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
      if Global.Usuario.OutrosAcessos[0701] then
        sqlacesso:=''
      else
//        sqlacesso:=' and mped_datacont is not null';
        sqlacesso:=' and pend_datacont is not null';
      data:=EdDtinicio.asdate-30;
{ Mudado para buscar os lan�amentos de status H no contas a receber
// 28.01.19 - Seip
      Q:=sqltoquery('select * from movped '+
                    ' where '+FGeral.Getin('mped_status','N','C')+
                    sqlunidade+
//                    ' and mped_situacao=''E'''+   // 29.09.09
//                    ' and mped_situacao=''P'''+
// 28.01.19 - Seip
                    ' and '+FGeral.GetIN('mped_situacao','F;P','C')+
                    ' and mped_usua_autoriza>0'+    // 29.09.09
                    ' and mped_datamvto>='+Datetosql(data)+sqlacesso+
                    ' order by mped_datamvto' );
}
      Q:=sqltoquery('select pend_valor,pend_datavcto from pendencias '+
                    ' where '+FGeral.Getin('pend_status','H','C')+
                    sqlunidade+
                    ' and pend_rp = ''R'''+
                    ' and pend_tipomov = '+Stringtosql(Global.CodPedVenda)+
                    ' and pend_datavcto >= '+Datetosql(EdDtinicio.asdate)+
                    ' and pend_datavcto <= '+Datetosql(EdDtFim.AsDate)+
                    sqlacesso+
                    ' order by pend_datavcto' );

      while not Q.eof do begin

//        vencimento:=Q.fieldbyname('mped_datamvto').asdatetime+FCondpagto.GetPrazomedio(Q.fieldbyname('mped_fpgt_codigo').asstring);
        vencimento:=Q.fieldbyname('pend_datavcto').asdatetime;
        for p:=0 to LIstaValores.count-1  do begin
          PValores:=Listavalores[p];
          if PValores.Dia=vencimento then begin
  //          PValores.receber:=PValores.receber+(Q.fieldbyname('mpdd_qtdeenviada').ascurrency*Q.fieldbyname('mpdd_venda').ascurrency);
//            PValores.pedidosvenda:=PValores.pedidosvenda+(Q.fieldbyname('mped_vlrtotal').ascurrency);
            PValores.pedidosvenda:=PValores.pedidosvenda+(Q.fieldbyname('pend_valor').ascurrency);
            break;
          end;
        end;
        Q.Next;

      end;
      Q.close;
    end;


    saldo:=saldo+saldoanterior;
    for p:=0 to LIstaValores.count-1 do begin
      PValores:=Listavalores[p];
      if p=0 then
          x:=1
      else
        inc(x);
      Grid.Cells[Grid.getcolumn('dia'),x]:=FGeral.FormataData(Pvalores.dia);
      Grid.Cells[Grid.getcolumn('chequesre'),x]:=FGeral.formatavalor(PVAlores.chequesrec,f_cr);
      Grid.Cells[Grid.getcolumn('cr'),x]:=FGeral.formatavalor(PVAlores.receber,f_cr);
      Grid.Cells[Grid.getcolumn('totalcr'),x]:=FGeral.formatavalor(PVAlores.receber+PVAlores.chequesrec+PVAlores.pedidosvenda,f_cr);
      Grid.Cells[Grid.getcolumn('chequesemi'),x]:=FGeral.formatavalor(PVAlores.chequespag,f_cr);
      saldo:=saldo+PVAlores.chequesrec+PVAlores.receber;
      Grid.Cells[Grid.getcolumn('cp'),x]:=FGeral.formatavalor(PVAlores.pagar,f_cr);
      Grid.Cells[Grid.getcolumn('pc'),x]:=FGeral.formatavalor(PVAlores.previsaopagar,f_cr);
      Grid.Cells[Grid.getcolumn('pv'),x]:=FGeral.formatavalor(PVAlores.pedidosvenda,f_cr);
      Grid.Cells[Grid.getcolumn('totalcp'),x]:=FGeral.formatavalor(PVAlores.pagar+PVAlores.previsaopagar+PVAlores.chequespag,f_cr);
      Grid.Cells[Grid.getcolumn('saldodia'),x]:=FGeral.formatavalor(PVAlores.chequesrec+PVAlores.receber-(PVAlores.chequespag+PVAlores.pagar+PVAlores.previsaopagar),f_cr);
      saldo:=saldo-(PVAlores.chequespag+PVAlores.pagar+PVAlores.previsaopagar);
      Grid.Cells[Grid.getcolumn('saldo'),x]:=FGeral.formatavalor(saldo,f_cr);
      Grid.appendrow;
      EdChequesre.setvalue( Edchequesre.ascurrency+PVAlores.chequesrec );
      Edrecebe.setvalue( Edrecebe.ascurrency+PVAlores.receber );
      EdPedvenda.setvalue( EdPedvenda.ascurrency+PVAlores.pedidosvenda );
      EdTotalre.setvalue( EdTotalre.ascurrency+PVAlores.receber+PVAlores.chequesrec+PVAlores.pedidosvenda );
      EdChequesemi.setvalue( Edchequesemi.ascurrency+PVAlores.chequespag );
      EdPagamentos.setvalue( EdPagamentos.ascurrency+PVAlores.pagar );
      EdPedcompra.setvalue( EdPedcompra.ascurrency+PVAlores.previsaopagar );
      EdTotalpa.setvalue( EdTotalpa.ascurrency+PVAlores.pagar+PVAlores.previsaopagar+PVAlores.chequespag );
      EdAtrasoMedio.setvalue( MediaAtraso );
{
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
}
    end;
    Freeandnil(Q);
    bimpressao.enabled:=true;
    Sistema.EndProcess('');


end;

procedure TFFluxoCaixa.GridClick(Sender: TObject);
begin
   if Grid.Col=Grid.GetColumn('chequesre') then
      Detalha('chequesre',Grid.cells[Grid.GetColumn('dia'),Grid.row])
// 14.04.14
   else if Grid.Col=Grid.GetColumn('chequesemi') then
      Detalha('chequesemi',Grid.cells[Grid.GetColumn('dia'),Grid.row])
   else if Grid.Col=Grid.GetColumn('cp') then
      Detalha('cp',Grid.cells[Grid.GetColumn('dia'),Grid.row])
   else if Grid.Col=Grid.GetColumn('cr') then
      Detalha('cr',Grid.cells[Grid.GetColumn('dia'),Grid.row])
   else if Grid.Col=Grid.GetColumn('pc') then
      Detalha('pc',Grid.cells[Grid.GetColumn('dia'),Grid.row])
   else if Grid.Col=Grid.GetColumn('pv') then
      Detalha('pv',Grid.cells[Grid.GetColumn('dia'),Grid.row]);
end;

procedure TFFluxoCaixa.Detalha(coluna, data: string);
////////////////////////////////////////////////////////////////
var Q,QPedCompra:TSqlquery;
    x,prazo:integer;
    vencimento:TDatetime;
    valor,receber,pagar:currency;
    sqlemirec:string;

    function  ChecaBaixaParcial(unidade,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer):currency;
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var Qbx:TSqlquery;
        status,sqlqtipo:string;
        valor:currency;
    begin
      status:=stringtosql('P');
      if Datacont>1 then
//        sqlqtipo:=' and pend_datacont>1'
// 27.09.11
        sqlqtipo:=' and pend_datacont > '+Datetosql(Global.DataMenorBanco)
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
///////////////////////////////////////////////////////
   valor:=0;
   prazo:=0;
   if (lowercase(coluna)='chequesre') or (lowercase(coluna)='chequesemi') then begin
      PDetalhe.Visible:=true;
      if (lowercase(coluna)='chequesre') then begin
        St.caption:='Cheques Recebidos';
        sqlemirec:=' and cheq_emirec=''R''';
      end else begin
        sqlemirec:=' and cheq_emirec=''E''';
        St.caption:='Cheques Emitidos';
      end;
      if Global.Usuario.OutrosAcessos[0701] then
        sqlacesso:=''
      else
        sqlacesso:=' and cheq_datacont is not null';
      if trim(EdUnid_codigo.text)<>'' then
        sqlunidade:=' and '+FGeral.getin('cheq_unid_codigo',EdUnid_codigo.text,'C')
      else
        sqlunidade:=' and '+FGeral.getin('cheq_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
      Q:=sqltoquery('select * from cheques'+
                  ' where '+FGeral.Getin('cheq_status','N','C')+
                  sqlemirec+
                  sqlunidade+
                  ' and cheq_predata='+Datetosql(Texttodate(FGeral.tirabarra(data)))+sqlacesso+
                  ' and cheq_deposito is null'+
                  ' order by cheq_predata' );
      GridDetalhe.clear;
      x:=1;
      while not Q.eof do begin
        GridDetalhe.cells[Griddetalhe.getcolumn('numero'),x]:=Q.fieldbyname('cheq_cheque').asstring;
        GridDetalhe.cells[Griddetalhe.getcolumn('valor'),x]:=FGeral.formatavalor(Q.fieldbyname('cheq_valor').ascurrency,f_cr);
        GridDetalhe.cells[Griddetalhe.getcolumn('descricao'),x]:=Q.fieldbyname('cheq_emitente').asstring;
        GridDetalhe.cells[Griddetalhe.getcolumn('varia'),x]:=FRepresentantes.GetDescricao(Q.fieldbyname('cheq_repr_codigo').asinteger);
        GridDetalhe.AppendRow;
        valor:=valor+Q.fieldbyname('cheq_valor').ascurrency;
        inc(x);
        Q.Next;
      end;
      FGeral.Fechaquery(Q);

   end else if lowercase(coluna)='cp' then begin

      PDetalhe.Visible:=true;
      St.caption:='Contas a Pagar';
      if Global.Usuario.OutrosAcessos[0701] then
        sqlacesso:=''
      else
        sqlacesso:=' and pend_datacont is not null';
      if trim(EdUnid_codigo.text)<>'' then
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')
      else
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
      Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status','N;H','C')+
                  ' and pend_rp=''P'''+
                  sqlunidade+
                  ' and  pend_datavcto='+Datetosql(Texttodate(FGeral.tirabarra(data)))+sqlacesso+
                  ' order by pend_datavcto' );

      GridDetalhe.clear;
      x:=1;
      while not Q.eof do begin
        if (Q.fieldbyname('pend_status').asstring<>'H') or ( (Q.fieldbyname('pend_status').asstring='H') and (Q.fieldbyname('pend_tipomov').asstring=Global.CodPendenciaFinanceira) ) then begin
          pagar:=Q.fieldbyname('pend_valor').ascurrency-ChecaBaixaParcial(Q.fieldbyname('pend_unid_codigo').asstring,Q.fieldbyname('pend_tipo_codigo').asstring,
                                Q.fieldbyname('pend_tipocad').asstring,Q.fieldbyname('pend_numerodcto').asstring,
                                Q.fieldbyname('pend_datamvto').asdatetime,Q.fieldbyname('pend_datacont').asdatetime,
                                Q.fieldbyname('pend_datavcto').asdatetime,Q.fieldbyname('pend_parcela').asinteger );
          GridDetalhe.cells[Griddetalhe.getcolumn('numero'),x]:=Q.fieldbyname('pend_numerodcto').asstring;
          GridDetalhe.cells[Griddetalhe.getcolumn('valor'),x]:=FGeral.formatavalor(pagar,f_cr);
          GridDetalhe.cells[Griddetalhe.getcolumn('descricao'),x]:=FPortadores.GetDescricao(Q.fieldbyname('pend_port_codigo').asstring)+
          ' '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').asinteger,Q.fieldbyname('pend_tipocad').asstring,'N') ;
  //        GridDetalhe.cells[Griddetalhe.getcolumn('varia'),x]:=FRepresentantes.GetDescricao(Q.fieldbyname('pend_repr_codigo').asinteger);
          GridDetalhe.cells[Griddetalhe.getcolumn('varia'),x]:='Parcela '+inttostr(Q.fieldbyname('pend_parcela').asinteger)+'/'+inttostr(Q.fieldbyname('pend_nparcelas').asinteger)+
                             ' '+Q.fieldbyname('pend_transacao').asstring+
                             ' - '+Q.fieldbyname('pend_status').asstring ;
          valor:=valor+pagar;
          GridDetalhe.AppendRow;
          inc(x);
        end;
        Q.Next;
      end;
      FGeral.Fechaquery(Q);

   end else if lowercase(coluna)='cr' then begin

      PDetalhe.Visible:=true;
      valor:=0;
      prazo:=0;
      St.caption:='Contas a Receber';
      if Global.Usuario.OutrosAcessos[0701] then
        sqlacesso:=''
      else
        sqlacesso:=' and pend_datacont is not null';
      if trim(EdUnid_codigo.text)<>'' then
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')
      else
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
      Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status','N','C')+
                  ' and pend_rp=''R'''+
                  sqlunidade+
                  ' and  pend_datavcto='+Datetosql(Texttodate(FGeral.tirabarra(data)))+sqlacesso+
                  ' order by pend_datavcto' );

      GridDetalhe.clear;
      EdTotal.setvalue(0);
      x:=1;
      while not Q.eof do begin
        GridDetalhe.cells[Griddetalhe.getcolumn('numero'),x]:=Q.fieldbyname('pend_numerodcto').asstring;
//        GridDetalhe.cells[Griddetalhe.getcolumn('valor'),x]:=FGeral.formatavalor(Q.fieldbyname('pend_valor').ascurrency,f_cr);
        receber:=Q.fieldbyname('pend_valor').ascurrency-ChecaBaixaParcial(Q.fieldbyname('pend_unid_codigo').asstring,Q.fieldbyname('pend_tipo_codigo').asstring,
                              Q.fieldbyname('pend_tipocad').asstring,Q.fieldbyname('pend_numerodcto').asstring,
                              Q.fieldbyname('pend_datamvto').asdatetime,Q.fieldbyname('pend_datacont').asdatetime,
                              Q.fieldbyname('pend_datavcto').asdatetime,Q.fieldbyname('pend_parcela').asinteger );
        GridDetalhe.cells[Griddetalhe.getcolumn('valor'),x]:=FGeral.formatavalor(receber,f_cr);

        GridDetalhe.cells[Griddetalhe.getcolumn('descricao'),x]:=FPortadores.GetDescricao(Q.fieldbyname('pend_port_codigo').asstring)+
        ' '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').asinteger,Q.fieldbyname('pend_tipocad').asstring,'N') ;
//        GridDetalhe.cells[Griddetalhe.getcolumn('varia'),x]:=FRepresentantes.GetDescricao(Q.fieldbyname('pend_repr_codigo').asinteger);
        GridDetalhe.cells[Griddetalhe.getcolumn('varia'),x]:='Parcela '+inttostr(Q.fieldbyname('pend_parcela').asinteger)+'/'+inttostr(Q.fieldbyname('pend_nparcelas').asinteger);
        GridDetalhe.cells[Griddetalhe.getcolumn('prazomedio'),x]:=inttostr( Trazatraso(Q.fieldbyname('pend_tipo_codigo').asinteger) );
        if Trazatraso(Q.fieldbyname('pend_tipo_codigo').asinteger)=0 then
//          valor:=valor+Q.fieldbyname('pend_valor').ascurrency;
          valor:=valor+receber;
        prazo:=prazo+Trazatraso(Q.fieldbyname('pend_tipo_codigo').asinteger);
        GridDetalhe.AppendRow;

        inc(x);
        Q.Next;
      end;
      FGeral.Fechaquery(Q);
      if x-1>0 then
        EdPrazodia.setvalue( trunc(prazo/(x-1)) )
      else
        EdPrazodia.setvalue( 0 )

   end else if lowercase(coluna)='pc' then begin

      PDetalhe.Visible:=true;
      St.caption:='Pedidos de Compra';

      if Global.Usuario.OutrosAcessos[0701] then
        sqlacesso:=''
      else
        sqlacesso:=' and pend_datacont is not null';
      if trim(EdUnid_codigo.text)<>'' then
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')
      else
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
      Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status','H','C')+
                  ' and pend_rp=''P'''+
                  ' and '+FGeral.GetNOTin('pend_tipomov',Global.CodPendenciaFinanceira,'C')+
                  sqlunidade+
                  ' and  pend_datavcto='+Datetosql(Texttodate(FGeral.tirabarra(data)))+sqlacesso+
                  ' order by pend_datavcto' );

      GridDetalhe.clear;
      x:=1;
      while not Q.eof do begin

// 20.05.09 - checa se o pedido de compra t� em aberto, ou seja, a nota ainda nao chegou ou nao foi informado
        QPedCompra:=Sqltoquery('select mocm_transacao from movcomp where mocm_transacao='+Stringtosql(Q.fieldbyname('pend_transacao').asstring)+
                                         ' and mocm_datarecebido is null'+
                                         ' and mocm_unid_codigo='+Stringtosql(Q.fieldbyname('pend_unid_codigo').asstring)+
                                         ' and mocm_status<>''C''');
        if not QPedCompra.eof then begin
          GridDetalhe.cells[Griddetalhe.getcolumn('numero'),x]:=Q.fieldbyname('pend_numerodcto').asstring;
          GridDetalhe.cells[Griddetalhe.getcolumn('valor'),x]:=FGeral.formatavalor(Q.fieldbyname('pend_valor').ascurrency,f_cr);
          GridDetalhe.cells[Griddetalhe.getcolumn('descricao'),x]:=FPortadores.GetDescricao(Q.fieldbyname('pend_port_codigo').asstring)+
          ' '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').asinteger,Q.fieldbyname('pend_tipocad').asstring,'N') ;
          GridDetalhe.cells[Griddetalhe.getcolumn('varia'),x]:='Parcela '+inttostr(Q.fieldbyname('pend_parcela').asinteger)+'/'+inttostr(Q.fieldbyname('pend_nparcelas').asinteger);
          valor:=valor+Q.fieldbyname('pend_valor').ascurrency;
          GridDetalhe.AppendRow;
          inc(x);
        end;
        FGeral.FechaQuery(QPedCompra);
        Q.Next;
      end;
      FGeral.Fechaquery(Q);

   end else if lowercase(coluna)='pv' then begin
//////////////////

      PDetalhe.Visible:=true;
      St.caption:='Pedidos de Venda';
      if trim(EdUnid_codigo.text)<>'' then
//        sqlunidade:=' and '+FGeral.getin('mped_unid_codigo',EdUnid_codigo.text,'C')
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C')
      else
//        sqlunidade:=' and '+FGeral.getin('mped_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
        sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
//      data:=EdDtinicio.asdate;
      if Global.Usuario.OutrosAcessos[0701] then
        sqlacesso:=''
      else
//        sqlacesso:=' and mped_datacont is not null';
        sqlacesso:=' and pend_datacont is not null';

//      vencimento:=EdDtinicio.asdate-30;

      vencimento:=TextToDate(  copy(Data,1,2)+copy(data,4,2)+copy(data,7,2) );

{
      Q:=sqltoquery('select * from movped '+
                    ' where '+FGeral.Getin('mped_status','N','C')+
                    sqlunidade+
                    ' and mped_situacao=''E'''+
//                    ' and  mped_datamvto>='+Datetosql(Texttodate(FGeral.tirabarra(data))-30)+sqlacesso+
                    ' and  mped_datamvto>='+Datetosql(vencimento)+sqlacesso+
                    ' order by mped_datamvto' );
}
      Q:=sqltoquery('select * from pendencias '+
                    ' where '+FGeral.Getin('pend_status','H','C')+
                    sqlunidade+
                    ' and  pend_datavcto = '+Datetosql(vencimento)+
                    ' and  pend_rp = ''R'''+
                    sqlacesso+
                    ' order by pend_datavcto' );

      GridDetalhe.clear;
      x:=1;
      while not Q.Eof do begin

        {
        vencimento:=Q.fieldbyname('mped_datamvto').asdatetime+FCondpagto.GetPrazomedio(Q.fieldbyname('mped_fpgt_codigo').asstring);
        if vencimento=Texttodate(FGeral.tirabarra(data)) then begin
          GridDetalhe.cells[Griddetalhe.getcolumn('numero'),x]:=Q.fieldbyname('mped_numerodoc').asstring;
          GridDetalhe.cells[Griddetalhe.getcolumn('valor'),x]:=FGeral.formatavalor(Q.fieldbyname('mped_vlrtotal').ascurrency,f_cr);
          GridDetalhe.cells[Griddetalhe.getcolumn('descricao'),x]:=FRepresentantes.GetDescricao(Q.fieldbyname('mped_repr_codigo').asinteger)+
          ' '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mped_tipo_codigo').asinteger,'C','N') ;
  //        GridDetalhe.cells[Griddetalhe.getcolumn('varia'),x]:=FRepresentantes.GetDescricao(Q.fieldbyname('pend_repr_codigo').asinteger);
          GridDetalhe.cells[Griddetalhe.getcolumn('varia'),x]:='Condi��o '+Q.fieldbyname('mped_fpgt_prazos').asstring;
          valor:=valor+Q.fieldbyname('mped_vlrtotal').ascurrency;
          GridDetalhe.AppendRow;
          inc(x);
        end;
        }
//        vencimento:=Q.fieldbyname('pend_vcto').asdatetime;
          GridDetalhe.cells[Griddetalhe.getcolumn('numero'),x]:=Q.fieldbyname('pend_numerodcto').asstring;
          GridDetalhe.cells[Griddetalhe.getcolumn('valor'),x]:=FGeral.formatavalor(Q.fieldbyname('pend_valor').ascurrency,f_cr);
          GridDetalhe.cells[Griddetalhe.getcolumn('descricao'),x]:=FRepresentantes.GetDescricao(Q.fieldbyname('pend_repr_codigo').asinteger)+
          ' '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').asinteger,'C','N') ;
  //        GridDetalhe.cells[Griddetalhe.getcolumn('varia'),x]:=FRepresentantes.GetDescricao(Q.fieldbyname('pend_repr_codigo').asinteger);
          GridDetalhe.cells[Griddetalhe.getcolumn('varia'),x]:='Parcela '+Q.fieldbyname('pend_parcela').asstring;
          valor:=valor+Q.fieldbyname('pend_valor').ascurrency;
          GridDetalhe.AppendRow;
          inc(x);

        Q.Next;

      end;
      FGeral.Fechaquery(Q);

/////////////////

   end;

   EdTotal.setvalue(valor);

end;

procedure TFFluxoCaixa.bfecharClick(Sender: TObject);
begin
   PDetalhe.visible:=false;
   Grid.enabled:=true;
   Grid.setfocus;

end;

procedure TFFluxoCaixa.EdescolhaExitEdit(Sender: TObject);
begin
  Grid.setfocus;
  bimpressao.enabled:=false;
  ProcessaFluxo;
  bimpressao.enabled:=true;

end;

procedure TFFluxoCaixa.bimpressaoClick(Sender: TObject);
var p:integer;
    saldo:currency;
begin
    Sistema.BeginProcess('Imprimindo Relat�rio');
    Sistema.Setmessage('Gerando relat�rio');
    FRel.Init('RelatorioFluxoCaixaII');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
    FRel.AddTit('Fluxo de Caixa Periodo : '+FGeral.formatadata(EdDtinicio.Asdate)+' a '+FGeral.formatadata(EdDtfim.asdate) );
    FRel.AddCol( 70,0,'D','' ,''              ,'Data'              ,''         ,'',false);
    if pos( '1',EdEscolha.text ) > 0 then
      FRel.AddCol(100,3,'N','+' ,f_cr            ,'Cheques Recebidos' ,''         ,'',false);
    if pos( '2',EdEscolha.text ) > 0 then
      FRel.AddCol(100,3,'N','+' ,f_cr            ,'Contas a Receber'  ,''         ,'',false);
    FRel.AddCol(100,3,'N','+' ,f_cr            ,'Total a Receber'   ,''         ,'',False);
    if pos( '3',EdEscolha.text ) > 0 then
      FRel.AddCol(100,3,'N','+' ,f_cr            ,'Cheques Emitidos'  ,''         ,'',false);
    if pos( '4',EdEscolha.text ) > 0 then
      FRel.AddCol(100,3,'N','+' ,f_cr            ,'Contas a Pagar'    ,''         ,'',false);
    if pos( '5',EdEscolha.text ) > 0 then
      FRel.AddCol(100,3,'N','+' ,f_cr            ,'Pedidos Compra'    ,''         ,'',false);
///    FRel.AddCol(020,1,'C',''  ,''              ,'P'                 ,''         ,'',false);
    FRel.AddCol(100,3,'N','+' ,f_cr            ,'Total a Pagar'     ,''         ,'',False);
    FRel.AddCol( 90,3,'N',''  ,f_cr            ,'Saldo di�rio'      ,''         ,'',False);
    FRel.AddCol( 90,3,'N',''  ,f_cr            ,'Saldo'             ,''         ,'',False);

    FRel.AddCel('');
    if pos( '1',EdEscolha.text ) > 0 then
      FRel.AddCel('');
    if pos( '2',EdEscolha.text ) > 0 then
      FRel.AddCel('');
    FRel.AddCel('');
    if pos( '3',EdEscolha.text ) > 0 then
      FRel.AddCel('');
    if pos( '4',EdEscolha.text ) > 0 then
      FRel.AddCel('');
    if pos( '5',EdEscolha.text ) > 0 then
      FRel.AddCel('');
    FRel.AddCel('');
    FRel.AddCel('');

    saldo:=0;
    FRel.AddCel(floattostr(Edsaldoanterior.ascurrency));
    saldo:=saldo+Edsaldoanterior.ascurrency;
    for p:=0 to LIstaValores.count-1 do begin
      PValores:=Listavalores[p];
      FRel.AddCel(FGeral.FormataData(Pvalores.dia));
      if pos( '1',EdEscolha.text ) > 0 then
        FRel.AddCel(floattostr(PVAlores.chequesrec));
      if pos( '2',EdEscolha.text ) > 0 then
        FRel.AddCel(floattostr(PVAlores.receber));
      FRel.AddCel(floattostr(PVAlores.chequesrec+PVAlores.receber));
      if pos( '3',EdEscolha.text ) > 0 then
        FRel.AddCel(floattostr(PVAlores.chequespag));
      saldo:=saldo+PVAlores.chequesrec+PVAlores.receber;
      if pos( '4',EdEscolha.text ) > 0 then
        FRel.AddCel(floattostr(PVAlores.pagar));
      if pos( '5',EdEscolha.text ) > 0 then
        FRel.AddCel(floattostr(PVAlores.previsaopagar));
      FRel.AddCel(floattostr(PVAlores.chequespag+PVAlores.pagar));
      FRel.AddCel(floattostr(PVAlores.chequesrec+PVAlores.receber-(PVAlores.chequespag+PVAlores.pagar)));
      saldo:=saldo-(PVAlores.chequespag+PVAlores.pagar);
      FRel.AddCel(floattostr(saldo));
    end;
    FRel.Video;
    Sistema.EndProcess('');
end;

function TFFluxoCaixa.TrazAtraso(codigo: integer): integer;
var l:integer;
begin
  result:=0;
  for l:=0 to ListaAtrasosMedio.count-1 do begin
        PAtrasos:=ListaAtrasosMedio[l];
        if PAtrasos.cliente=codigo then begin
          result:=PAtrasos.atraso;
          break;
        end;
  end;

end;

end.
