unit expnfpra;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB,
//   dbf,
   StdCtrls, ComCtrls, Mask, SQLEd, Buttons, SQLBtn,
  alabel, SQLGrid, ExtCtrls,SimpleDS, Datasnap.DBClient;
  //Dbtables;

type
  TFExpNFprazo = class(TForm)
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
    Edtermino: TSQLEd;
    EdMesano: TSQLEd;
//    DbfExpdesat: TDbf;
//   DbfExpdesat: TsimpleDataSet;
    EdCv: TSQLEd;
    EdInicio: TSQLEd;
    EdPasta: TSQLEd;
    EdSistema: TSQLEd;
    bexportados: TSQLBtn;
    Edtipomov: TSQLEd;
    brelerros: TSQLBtn;
    DbfExpdesat: TSimpleDataSet;
    procedure bExecutarClick(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdUnid_codigoValidate(Sender: TObject);
    procedure EdCvValidate(Sender: TObject);
    procedure EdSistemaExitEdit(Sender: TObject);
    procedure bexportadosClick(Sender: TObject);
    procedure brelerrosClick(Sender: TObject);
    procedure textValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function contagrande(conta:integer ; xtransacao:string):integer;
    function Formatovalorcomponto(valor:currency;tamanho,decimais:integer):string;
    procedure GravaContas( ctdebito:integer ; ctcredito:integer ; xtrans:string ; xmovimento:TDatetime);
// 18.02.20
    function FormatovalorSemponto(valor:currency;tamanho,decimais:integer):string;

  end;

var
  FExpNFprazo: TFExpNFprazo;
  tiposmovnao,nomearq,nomedbf,nomepath,nomearqtexto,historico:string;
  ctatransestoque:integer;
  Dbfexp:TSimpleDataset;
  DriveExp:string;
  Arquivo:Textfile;

const
   maximocomple:integer=50;

implementation

uses Arquiv, Geral, Sqlfun, Sqlsis, Sqlexpr , fornece, plano, cadcli,
  SQLRel, ConfMovi, TextRel, represen;

{$R *.dfm}

procedure TFExpNFprazo.bExecutarClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////
type TTotais = record
     tipomov:string;
     valor,quantos:currency;
end;

type TClifor = record
     codigo:integer;
     tipocad,es:string;
     valor:currency;
end;

var n,empresa,filial,sist:integer;
    Q,
    Qz,
    Qa    :TSqlquery;
    clifor,tiposdemovimento,linha,vispra,tiposdemovimentoe,tiposdemovimentos,cv,sqldatacont,condicao,sqlfornec,
    sqltipomov,ContasBloqueadas,deli,es,cdebito,ccredito:string;
    datamvto,dataes:TDatetime;
    debito,credito,p,xcredito,contagerencial,codigocontabil:integer;
    vlrdiarioavista,vlrdiario,valor,totais,cotacapital,vlrinss,aliicms,isentas,outras,vlrgta,vlrinssret,
    vlrpisret,vlrcofinsret,vlrirret,vlrcsllret,vlrissret:currency;
    Forns,
    ListaDesp              :TStringlist;
    Listatotais,ListaClifor:Tlist;
    PTotais:^TTotais;
    PClifor:^TClifor;
    campo,camponaosocio,
    camporetencoes,
    camposervicos,
    campoapropria,
    campoinsster     :TDicionario;
    xcondicao        :boolean;
    y: Integer;

    procedure Atualiza(codigo:integer;tipocad,es:string;xvalor:currency);
    ///////////////////////////////////////////////////////////////////////
    var i:integer;
        achou:boolean;
    begin
      achou:=false;
      for i:=0 to ListaClifor.count-1 do begin
        PClifor:=LIstaclifor[i];
        if (Pclifor.codigo=codigo) and (Pclifor.tipocad=tipocad)  and (Pclifor.es=es) then begin
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
        New(PClifor);
        PClifor.codigo:=codigo;
        PClifor.tipocad:=tipocad;
        PClifor.es:=es;
        PClifor.valor:=xvalor;
        LIstaClifor.add(PClifor);
      end else
        PClifor.valor:=PClifor.valor+xvalor;
    end;


    function Estavalendo:boolean;
    //////////////////////////////
    begin
      result:=false;
      if pos( Q.fieldbyname('moes_tipomov').asstring,tiposmovnao ) = 0 then begin
        if (trim(EdMesano.text)='') and (Q.fieldbyname('moes_datacont').asdatetime<=1) then
          result:=true
        else if (trim(EdMesano.text)<>'') and (Q.fieldbyname('moes_datacont').asdatetime>1) then
          result:=true;
      end;
    end;


    function EstavalendoFinan:boolean;
    ///////////////////////////////////
    begin
      result:=false;
      if (trim(EdMesano.text)='') and (Q.fieldbyname('pend_datacont').asdatetime<=1) then
          result:=true
      else if (trim(EdMesano.text)<>'') and (Q.fieldbyname('pend_datacont').asdatetime>1) then
          result:=true;
// 13.11.09 - Abra - nao contabiliza provisao ref. financiamentos pois estes ja s�o lan�ados
//    no caixa bancos
      if FPlano.GetTipo( Q.fieldbyname('pend_plan_conta').asinteger ) = 'E' then
        result:=false;
    end;


    ////////////////////////////////////////////////////////////////////////////////
    procedure GetContasExportacao(Vistaprazo,Es,tipomov:string;CodigoMov:integer=0);
    ////////////////////////////////////////////////////////////////////////////////
    var QConf,QP:TSqlquery;
        xclassi :string;

    begin

      if tipomov=Global.CodPendenciaFinanceira then begin  // 14.03.07

        if Es='V' then begin // 'vendas' - contas a receber
            debito:=EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asinteger;
            credito:=EdUnid_codigo.resultfind.fieldbyname('unid_vendaaprazo').asinteger;
            cdebito:=EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asstring;
            ccredito:=EdUnid_codigo.resultfind.fieldbyname('unid_vendaaprazo').asstring;
// 22.10.12 - Novicarnes -confirmar contas com angela / leonir - ver com saber o banco q devolveu
//            if codigomov=505 then
//              credito:=;
// 18.06.07 - para usar a conta do cadastro de clientes
             if Global.Topicos[1253] then begin
               if codigomov=505 then begin
                 debito:=FCadcli.GetContaExp(Q.fieldbyname('cheq_tipo_codigo').Asinteger,EdUNid_codigo.text);
                 cdebito:=FCadcli.GetCnpjCpf(Q.fieldbyname('cheq_tipo_codigo').Asinteger,'S');
               end else begin
                 debito:=FCadcli.GetContaExp(Q.fieldbyname('pend_tipo_codigo').Asinteger,EdUNid_codigo.text);
                 cdebito:=FCadcli.GetCnpjCpf(Q.fieldbyname('pend_tipo_codigo').Asinteger,'S');
               end;
            end;
            if Vistaprazo='V' then begin
// para nao lan�ar as vendas/compras a vista
              debito:=0;
              credito:=0;
              cdebito:='';
              ccredito:='';
            end;

        end else begin  // 'compras' - contas a pagar

//          debito:=EdUnid_codigo.resultfind.fieldbyname('unid_compras').asinteger;
          debito:=FPlano.GetContaExportacao(Q.fieldbyname('pend_plan_conta').asinteger,EdUnid_codigo.text);
          cdebito:=inttostr(FPlano.GetContaExportacao(Q.fieldbyname('pend_plan_conta').asinteger,EdUnid_codigo.text));
// 10.12.08
          if Q.fieldbyname('pend_tipocad').asstring='F' then begin
            credito:=FFornece.GetContaExp(Q.fieldbyname('pend_tipo_codigo').asinteger,EdUnid_codigo.text);
            ccredito:=FFornece.GetCnpjCpf(Q.fieldbyname('pend_tipo_codigo').asinteger,'S');
// 23.04.10 - Abra
          end else if Q.fieldbyname('pend_tipocad').asstring='R' then begin
            credito:=FRepresentantes.GetContaExp(Q.fieldbyname('pend_tipo_codigo').asinteger);
            ccredito:=inttostr(FRepresentantes.GetContaExp(Q.fieldbyname('pend_tipo_codigo').asinteger));
          end else begin
            credito:=FCadcli.GetContaExp(Q.fieldbyname('pend_tipo_codigo').Asinteger,EdUNid_codigo.text);
            ccredito:=FCadcli.GetCnpjCpf(Q.fieldbyname('pend_tipo_codigo').Asinteger,'S');
          end;

// 27.03.07
          if credito=0 then begin
//            credito:=EdUnid_codigo.resultfind.fieldbyname('unid_compras').asinteger;
            credito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asinteger;
            ccredito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asstring;
          end;

        end;

// 03.04.08
////////////////////////////////////////////////////////////////////////////////////////////
      end else if FConfMovimento.GetContaConfMovimento(CodigoMov) then begin

          QConf:=sqltoquery('select * from confmov where comv_codigo='+inttostr(CodigoMov));
          if not QConf.eof then begin
              debito:=QConf.fieldbyname('comv_debito').asinteger;
              credito:=QConf.fieldbyname('comv_credito').asinteger;
// 21.11.19 - Novicarnes - ketlen - para buscar as contas da unidade em uso
//            somente se usar contas e nao estiver na unidade 001
            if ( FGeral.SistemaContax.Connected ) and ( (debito+credito)>0 )
               and ( EdUnid_codigo.Text <> '001' )
               then begin

               if debito>0 then begin

                 QP:=FGeral.SqlToQueryContax('select pcon_classificacao from planocon where pcon_conta = '+inttostr(debito));
                 if not Qp.Eof then begin

                    xclassi := Qp.FieldByName('pcon_classificacao').AsString;
                    FGeral.FechaQuery(Qp);
                    QP:=Fgeral.SqlToQueryContax('select pcon_conta from planocon where pcon_classificacao = '+Stringtosql(xclassi)+
                                                ' and pcon_empr_codigo <> ''01''' );
                    if not Qp.Eof then debito:=QP.FieldByName('plan_conta').AsInteger;

                 end;
                 FGeral.FechaQuery(Qp);

               end;

               if credito>0 then begin

                 QP:=FGeral.SqlToQueryContax('select * from planocon where pcon_conta = '+inttostr(credito));
                 if not Qp.Eof then begin

                    xclassi := Qp.FieldByName('pcon_classificacao').AsString;
                    FGeral.FechaQuery(Qp);
                    QP:=Fgeral.SqlToQueryContax('select pcon_conta from planocon where pcon_classificacao = '+Stringtosql(xclassi)+
                                                ' and pcon_empr_codigo = ''02''' );
                    if not Qp.Eof then credito:=QP.FieldByName('pcon_conta').AsInteger;

                 end;
                 FGeral.FechaQuery(Qp);

               end;

            end;

              cdebito:=QConf.fieldbyname('comv_debito').asstring;
              ccredito:=QConf.fieldbyname('comv_credito').asstring;
          end;
// 19.03.09
          if credito=0 then begin
             if Q.FieldByName('moes_tipocad').asstring='F' then begin
               credito:=FFornece.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUnid_codigo.text);
               ccredito:=FFornece.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').asinteger,'S');
             end else
               credito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUNid_codigo.text);
          end;
// 20.03.09
        if credito=0 then
           credito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asinteger;
{ // 21.11.19
// 20.04.10 - Abra - Ligiane
        if Tipomov=Global.CodCompraImobilizado then begin

          debito:=Q.fieldbyname('moes_plan_codigo').AsInteger;
          cdebito:=Q.fieldbyname('moes_plan_codigo').AsString;

        end;
        }
// 05.09.16 - Novicarnes Vendas Diferenciadas
///////////////////
        if debito=0 then begin
             if Q.FieldByName('moes_tipocad').asstring='F' then begin
               debito:=FFornece.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUnid_codigo.text);
               cdebito:=FFornece.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').asinteger,'S');
             end else
               debito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUNid_codigo.text);
        end;
{  retirado em 14.05.19 devido compra 'a vista' futura
// 25.11.09 - capeg - leo jaime  // 21.10.11 - leo jaime mas no SM
        if (Vistaprazo='V') and (not Global.Topicos[1018]) then begin
// para nao lan�ar as compras a vista
            debito:=0;
            credito:=0;
            cdebito:='';
            ccredito:='';
}

        if (Vistaprazo='V') and (Global.Topicos[1018]) then begin
          if es='V' then begin
            debito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
            credito:=EdUnid_codigo.resultfind.fieldbyname('Unid_vendaavista').asinteger;
          end else begin
            if debito=0 then
              debito:=EdUnid_codigo.resultfind.fieldbyname('unid_comprasavista').asinteger;
            credito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
          end;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
        end;
        FGeral.FechaQuery(QConf);
/////////////////////////////////////////////////////////////
      end else if Tipomov=Global.CodTransfEntrada then begin

        debito:=EdUnid_codigo.resultfind.fieldbyname('unid_transentrada').asinteger;
// 07.08.14 - Novicarnes - Angela
//        credito:=ctatransestoque;
        credito:=EdUnid_codigo.resultfind.fieldbyname('Unid_ctbtransnume').asinteger;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);

      end else if Tipomov=Global.CodTransfSaida then begin

//        debito:=ctatransestoque;
// 07.08.14 - Novicarnes - Angela
        debito:=EdUnid_codigo.resultfind.fieldbyname('Unid_ctbtransnume').asinteger;
        credito:=EdUnid_codigo.resultfind.fieldbyname('unid_transsaida').asinteger;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
////////_//////////////////////////////////////////////////////////////
      end else if pos(Tipomov,Global.CodDevolucaoProntaEntrega+';'+
                  global.CodDevolucaoVenda+';'+Global.CodDevolucaoConsigMerc+';'+Global.CodDevolucaoIgualVenda)>0 then begin

        debito:=EdUnid_codigo.resultfind.fieldbyname('unid_devovenda').asinteger;
        cdebito:=inttostr(debito);
//        credito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
// 02.08.07
        if Global.Topicos[1253] then begin
           if Q.FieldByName('moes_tipocad').asstring='F' then begin
             credito:=FFornece.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUnid_codigo.text);
             ccredito:=FFornece.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').asinteger,'S');
           end else begin
             credito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUNid_codigo.text);
             ccredito:=FCadcli.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').asinteger,'S');
// 23.09.08 -vanessa - novicarnes
             if pos(Tipomov,Global.CodDevolucaoProntaEntrega+';'+global.CodDevolucaoVenda+';'+Global.CodDevolucaoConsigMerc+';'+Global.CodDevolucaoIgualVenda)>0 then
//               debito:=FCadcli.GetContaExpDevVenda(Q.fieldbyname('moes_tipo_codigo').asinteger);
// 08.01.09
               credito:=FCadcli.GetContaExpDevVenda(Q.fieldbyname('moes_tipo_codigo').asinteger);
           end;
        end else
          credito:=EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asinteger;
//////////////////
// 23.11.05 - ajustado em 20.04.09
      end else if pos(Tipomov,Global.CodDevolucaoCompra)>0 then begin

//        debito:=95;  // falta criar conta no cadastro de unidades
// s� hj ela finalmente disse q tinha q criar uma conta de dev. para cada fornec.
        if Global.Topicos[1253] then begin
// 25.01.10 - Abra - Ligiane
           if Global.Topicos[1008] then begin
             if Q.FieldByName('moes_tipocad').asstring='F' then begin
               debito:=FFornece.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUnid_codigo.text);
               cdebito:=FFornece.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').asinteger,'S');
             end else begin
               debito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUNid_codigo.text);
               cdebito:=FCadcli.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').asinteger,'S')
             end;
           end else begin
             if Q.FieldByName('moes_tipocad').asstring='F' then
               debito:=FFornece.GetContaExpDevCompra(Q.fieldbyname('moes_tipo_codigo').asinteger)
             else begin
               debito:=FCadcli.GetContaExpDevVenda(Q.fieldbyname('moes_tipo_codigo').asinteger);
             end;
           end;
        end else
          debito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asinteger;
        credito:=EdUnid_codigo.resultfind.fieldbyname('unid_devocompra').asinteger;

// 06.06.12 - Benato -> SM - lan�amento dos cupons fiscais
      end else if (CodigoMov=FGeral.GetConfig1AsInteger('ConfMovECF')) and ( codigomov>0 ) then begin

        debito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
        credito:=EdUnid_codigo.resultfind.fieldbyname('Unid_vendaavista').asinteger;

      end else if es='V' then begin

        debito:=EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asinteger;
        credito:=EdUnid_codigo.resultfind.fieldbyname('unid_vendaaprazo').asinteger;

// 08.07.20  - exporta��o de notas de prestacao de servi�os NFS-e  nas saidas
        if (  Q.fieldbyname('moes_tipomov').AsString = Global.codPrestacaoServicos )
           and
           (  camposervicos.tipo<>'' )
           then begin

            credito:=EdUnid_codigo.resultfind.fieldbyname('unid_contaservicos').asinteger;

        end;

          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
// 12.05.10 - Novi - devolucao de compra de produtor
        if pos(Tipomov,Global.CodDevolucaoCompraProdutor)>0 then
           credito:=EdUnid_codigo.resultfind.fieldbyname('unid_devocompra').asinteger;

// 18.06.07 - para usar a conta do cadastro de clientes
        if Global.Topicos[1253] then begin
// 05.11.16
           if Global.Topicos[1010] then begin
             debito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').Asinteger);
             cdebito:=FCadcli.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').Asinteger,'S');
           end else if EdMesano.isempty then begin
             debito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').Asinteger,EdUNid_codigo.text,'XX');
             cdebito:=FCadcli.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').Asinteger,'S');
           end else begin
             debito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').Asinteger,EdUNid_codigo.text,'XY');
             cdebito:=FCadcli.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').Asinteger,'S');
             if Global.topicos[1018] then begin
               debito:=EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asinteger;
               cdebito:=FCadcli.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').Asinteger,'S');
             end;
           end;
// 11.04.12 - para planos que nao detalham clientes
// 19.04.13 - Novicarnes - OU para clientes novos que ainda nao foi colocado o reduzido no sac
//            entao foi retirado isto pq se t� setado o 1253 � pra avisar q nao tem...
//           if debito=0 then debito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;

        end;
// 13.04.10 - Abra - Ligiane - credito para cada config. de movimento
        if codigomov>0 then begin
          QConf:=sqltoquery('select * from confmov where comv_codigo='+inttostr(CodigoMov));
          if not QConf.eof then begin
            if  QConf.fieldbyname('comv_credito').asinteger>0 then
              credito:=QConf.fieldbyname('comv_credito').asinteger;
          end;
          FGeral.FechaQuery(QConf);
        end;
        if Vistaprazo='V' then begin

// 05.11.10 - para lan�ar as vendas a vista
          if Global.Topicos[1018] then begin

            debito :=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
            credito:=EdUnid_codigo.resultfind.fieldbyname('Unid_vendaavista').asinteger;
// 08.07.20  - exporta��o de notas de prestacao de servi�os NFS-e  nas saidas
            if (  Q.fieldbyname('moes_tipomov').AsString = Global.codPrestacaoServicos )
               and
               (  camposervicos.tipo<>'' )
               then begin

                credito:=EdUnid_codigo.resultfind.fieldbyname('unid_contaservicos').asinteger;

        end;

          end else begin
// 04.05.05 - para nao lan�ar as vendas/compras a vista
            debito:=0;
            credito:=0;
          end;

          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);

        end;
// 22.10.10 - NOvi - vava - debito e credito informado na digitacao da nota de entrada
      end else if (es='C') and (pos(Tipomov,Global.CodCompraSemfinan)>0) and
                  ( Global.Topicos[1347] )
        then begin

          debito:=FPlano.GetContaExportacao(Q.fieldbyname('moes_plan_codigo').asinteger,EdUnid_codigo.Text);
          credito:=FPlano.GetContaExportacao(Q.fieldbyname('moes_plan_codigocre').asinteger,EdUnid_codigo.Text);
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);

      end else if es='C' then begin

        debito:=EdUnid_codigo.resultfind.fieldbyname('unid_compras').asinteger;
//      06.09.16
        if (camponaosocio.Tipo<>'') and ( pos(Tipomov,Global.CodCompraProdutor+';'+Global.CodDevolucaoCompraProdutor+';'+Global.codEntradaProdutor)>0 ) then begin

           if not FCadCli.Getecooperado(Q.fieldbyname('moes_tipo_codigo').asinteger) then
             debito:=EdUnid_codigo.resultfind.fieldbyname('unid_comprasNS').asinteger;

        end;
//////////////

        contagerencial:=fGeral.GetContaDespesa(Q.FieldByName('moes_transacao').asstring );
// 21.08.20  - para n�o fazer o lan�amento quando tem q fazer o multiplo do rateio
        if Contagerencial = 9999 then begin

           contagerencial := 0;
           debito         := 0;

        end;

// 02.08.07                    // 08.08.08
        if (Contagerencial>0) and ( pos(Tipomov,Global.CodCompraProdutor+';'+Global.CodDevolucaoCompraProdutor+';'+Global.CodEntradaProdutor)=0 )
           and ( not Global.Topicos[1003] )  then begin  // 05.11.10

          debito:=FPlano.GetContaExportacao(contagerencial,EdUnid_codigo.Text);
// 23.07.20 - muda a conta para despesa a apropriar caso achar a apropricao
          if campoapropria.Tipo<>'' then begin

             if not Qa.eof then begin

                debito := FPlano.GetContaExportacaoAApropriar(contagerencial,EdUNid_codigo.text);
                if debito = 0 then debito:=FPlano.GetContaExportacao(contagerencial,EdUnid_codigo.Text);

             end;

          end;

        end else if Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimento then begin
// 23.10.07
          debito:=EdUnid_codigo.resultfind.fieldbyname('unid_ctbfrete').asinteger;
          if debito=0 then
            debito:=EdUnid_codigo.resultfind.fieldbyname('unid_compras').asinteger;

            debito:=EdUnid_codigo.resultfind.fieldbyname('unid_comprasns').asinteger;

        end;

        cdebito:=inttostr(debito);
        if Global.Topicos[1253] then begin

           if Q.FieldByName('moes_tipocad').asstring='F' then begin
// 05.11.16
             if Global.Topicos[1010] then begin
               credito:=FFornece.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger);
               ccredito:=FFornece.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').asinteger,'S');
             end else begin
               credito:=FFornece.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUnid_codigo.text);
               ccredito:=FFornece.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').asinteger,'S');
             end;
// 20.03.09 - caso ainda nao houver no fornecedor a conta configurada
             if credito=0 then
                credito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asinteger;
           end else  begin
// 05.11.16
             if Global.Topicos[1010] then begin
               credito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger);
               ccredito:=FCadcli.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').asinteger,'S');
             end else  begin
//               credito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUNid_codigo.text);
// 18.12.18 - Novicarnes - Simone - Compra de Produtor  pegava conta de vendas
               credito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUNid_codigo.text,'',Q.fieldbyname('moes_tipomov').asstring);
               ccredito:=FCadcli.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').asinteger,'S');
             end;
           end;
// 30.10.09 - Abra - Ligiane - adiantamento de pagamento de despesa - credito adiantamento
//            e debito a despesa informada
           campo:=Sistema.GetDicionario('movesto','moes_plan_codigo');

           if ( Q.FieldByName('moes_tipomov').asstring=Global.CodCompraRemessaFutura )
              and ( campo.Tipo<>'' ) then begin

              QConf:=sqltoquery('select * from confmov where comv_codigo='+inttostr(CodigoMov));
              if not QConf.eof then begin
                 if QConf.fieldbyname('comv_debito').asinteger=0 then begin
//                   debito:=Q.fieldbyname('moes_plan_codigo').asinteger;  //
// 17.12.09
                   debito:=FPlano.GetContaExportacao(Q.fieldbyname('moes_plan_codigo').asinteger,Q.fieldbyname('moes_unid_codigo').asstring);
//
// aqui ver se cria parametro para 'usar mesmo reduzido da contabilidad'
// 28.10.19
                   if QConf.fieldbyname('comv_credito').asinteger>0 then

                      credito:=QConf.fieldbyname('comv_credito').asinteger

                   else

                      credito:=FFornece.GetContaExpCompraRemessaFutura( Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_unid_codigo').asstring );

                 end;
              end;
              FGeral.FechaQuery(QConf);
             ccredito:=inttostr(credito);
             cdebito:=inttostr(debito);
           end;
// 25.11.09                      // 25.10.19  - Novicarnes - compra entrega futura CL..
           if (Vistaprazo='V') and ( ES='S')  then begin
// 05.11.10 - para lan�ar as vendas a vista
              if Global.Topicos[1018] then begin
                if debito=0 then  // 21.10.11
                  debito:=EdUnid_codigo.resultfind.fieldbyname('unid_comprasavista').asinteger;
                credito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
              end else begin
// para nao lan�ar as vendas/compras a vista
                debito:=0;
                credito:=0;
              end;
             ccredito:=inttostr(credito);
             cdebito:=inttostr(debito);
           end;

        end else begin

// 22.08.08
            if EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asinteger>0 then
              credito:=EdUnid_codigo.resultfind.fieldbyname('unid_fornecedores').asinteger
            else begin
              credito:=FFornece.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUnid_codigo.text);
              ccredito:=FFornece.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').asinteger,'S');
            end;

        end;

//        if Vistaprazo='V' then begin
// 29.10.19 - Novicarnes - compras remessa futura tipo CL nao gera financeiro mas contabiliza...
        if (Vistaprazo='V') and ( AnsiPos(Q.fieldbyname('moes_tipomov').asstring, Global.TiposGeraFinanceiro)>0 )  then begin
// 05.11.10 - para lan�ar as compras a vista
              if Global.Topicos[1018] then begin
                debito:=EdUnid_codigo.resultfind.fieldbyname('unid_comprasavista').asinteger;
                credito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
              end else begin
// para nao lan�ar as compras a vista
                debito:=0;
                credito:=0;
              end;
             ccredito:=inttostr(credito);
             cdebito:=inttostr(debito);
         end;

      end;

// 22.05.09 - para nao permitir exportar 'conta 20001'
       if trim(ContasBloqueadas)<>'' then begin
         if FGeral.ContaBloqueada(debito,ContasBloqueadas)  then
           debito:=-1;
         if FGeral.ContaBloqueada(credito,ContasBloqueadas)  then
           credito:=-1;
       end;
//////////////////
// 04.11.16  - retirado para usar a conversao de reduzidos do plano
//      se tiver online no financeiro OU no faturamento checar aqui as contas de debito e credito q NAO EXIStirem
//      no plano 'em uso' cfe a unidde informada
/////////////////////////////////////
{
      if ( FGeral.SistemaContax.Connected ) and ((debito+credito)>0) then begin
         if debito>0 then begin
           QP:=FGeral.SqlToQueryContax('select * from planocon where pcon_conta = '+inttostr(debito));
           if not Qp.Eof then begin
              if strtointdef(Qp.FieldByName('pcon_empr_codigo').AsString,0) <> strtointdef(EdUnid_codigo.Text,0) then
                Texto.Lines.Add('Conta d�bito '+inttostr(debito)+' n�o pertence ao plano da unidade '+EdUnid_codigo.Text+' Transa��o '+Q.fieldbyname('moes_transacao').asstring )
           end;
           FGeral.FechaQuery(Qp);
         end;
         if credito>0 then begin
           QP:=FGeral.SqlToQueryContax('select * from planocon where pcon_conta = '+inttostr(credito));
           if not Qp.Eof then begin
              if strtointdef(Qp.FieldByName('pcon_empr_codigo').AsString,0) <> strtointdef(EdUnid_codigo.Text,0) then
                Texto.Lines.Add('Conta cr�dito '+inttostr(credito)+' n�o pertence ao plano da unidade '+EdUnid_codigo.Text+' Transa��o '+Q.fieldbyname('moes_transacao').asstring )
           end;
           FGeral.FechaQuery(Qp);
         end;
      end;
      }
/////////////////////////////////////
    end;

    procedure Somatotais(tipo:string ; valor:currency);
    /////////////////////////////////////////////////////
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

    function GetValorFinanceiro(stransacao:string):currency;
    //////////////////////////////////////////////////////////
    var valor:currency;
        QP:Tsqlquery;
    begin
       valor:=0;
       QP:=sqltoquery('select pend_valor,pend_valortitulo from pendencias where pend_transacao='+Stringtosql(stransacao)+
// 30.06.10 - Abra - Ligiane constatou q as vezes pega o valor da comissao gerada...
                      ' and pend_tipomov='+Stringtosql(Global.CodContrato));
       if not QP.eof then
         valor:=QP.fieldbyname('pend_valortitulo').AsCurrency;
       FGeral.FechaQuery(QP);
       result:=valor;
    end;


////////////////////////////////////////////////////////////////
begin
////////////////////////////////////////////////////////////////
  if not EdUnid_codigo.validfind then exit;
  if not EdUnid_codigo.valid then exit;

  if not EdCv.valid then exit;

  if Trim(EdMesano.text)<>'' then begin
    if EdUNid_codigo.resultfind.fieldbyname('unid_empresa1').asinteger=0 then begin
      Avisoerro('Falta configurar o codigo da empresa 1 no cadastro de unidades');
      exit;
    end;
  end else begin
    if EdUNid_codigo.resultfind.fieldbyname('unid_empresa2').asinteger=0 then begin
      Avisoerro('Falta configurar o codigo da empresa 2 no cadastro de unidades');
      exit;
    end;
  end;
// 14.09.16
  camporetencoes:=Sistema.GetDicionario('unidades','unid_contacofret');
// 08.07.20
  camposervicos:=Sistema.GetDicionario('unidades','unid_contaservicos');
// 23.07.20
  campoapropria := Sistema.GetDicionario('apropriacoes','apro_status');
// 10.08.20
  campoinsster:=Sistema.GetDicionario('unidades','unid_containssret');

  if not confirma('Confirma exporta��o ?') then exit;

  ContasBloqueadas:=FGeral.GetConfig1AsString('ContasBloq');
  Listatotais:=tlist.create;
  texto.clear;
  tiposdemovimentoe:=Global.CodCompra+';'+Global.CodCompraSemMovEstoque+';'+global.CodConhecimento+';'+Global.CodCompra100+';'+
         ';'+Global.CodTransfEntrada+';'+                 //  10.05.05
         Global.CodTransImobE+';'+Global.CodDevolucaoRoman+';'+global.CodCompraImobilizado+';'+global.CodCompraMatConsumo+';'+
         Global.CodDevolucaoSerie5+';'+Global.CodCompraX+';'+Global.CodDevolucaoConsigMerc+';'+
         Global.CodRetornoConsigMercanil+';'+Global.CodCompraSemfinan+';'+Global.CodDevolucaoInd+';'+
         Global.CodDevolucaoProntaEntrega+';'+Global.CodRetornocomServicos+';'+Global.CodRetornoInd+';'+
         Global.CodCompraProdutor+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoIgualVenda+';'+
         Global.CodEntradaImobilizado+';'+Global.CodCompraIndustria+';'+Global.CodCompraFutura+';'+
         Global.CodCompraRemessaFutura+';'+Global.CodEntradaSemItens+';'+Global.CodEntradaInd+';'+
         Global.CodEntradaProdutor+';'+Global.CodPrestacaoServicosE;

//         ';'+Global.CodDevolucaoVenda+';'+ retirado DV em 25.04.06 do extra caixa - valmir
// 06.11.19 - retirado entrada doa��o da exportacao - Novicarnes - Simone
// Global.CodEntradaBrinde+';'+
// retornado as 'DV' em 02.08.07
// 12.05.11 - colocado prestacao de servi�os
// 13.08.18 - colocado CQ - complemento de qtde
  tiposdemovimentos:=global.CodVendaDireta+';'+Global.CodVendaConsig+';'+Global.CodVendaSemMovEstoque+';'+
         Global.CodVendaProntaEntrega+';'+Global.CodVendaMagazine+';'+
         Global.CodVendaConsigMercantil+';'+Global.CodConsigMercantil+';'+
         Global.CodVendaInterna+';'+Global.CodVendaSerie4+';'+global.CodVendaRE+';'+global.CodVendaREFinal+';'+
         global.CodVendaRomaneio+';'+global.CodVendaAmbulante+';'+Global.CodTransfEntrada+';'+
         Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodVendaPecaProblema+';'+Global.CodVendaMostruarioII+';'+
         Global.CodRemessaInd+';'+Global.CodContratoEntrega+';'+Global.CodContrato+';'+Global.CodVendaSemfinan+';'+
         GLobal.CodDevolucaoCompra+';'+Global.CodRemessaIndPropria+';'+Global.CodVendaImobilizado+';'+
         Global.CodDevolucaoCompraProdutor+';'+Global.CodPrestacaoServicos+';'+
         Global.CodNfeComplementoQtde;
  if EdCv.text='C' then begin   // entradas
    tiposdemovimento:=tiposdemovimentoe;
  end else if EdCv.text='V'  then begin  // saidas
    tiposdemovimento:= tiposdemovimentos
  end else
//  tiposdemovimento:=tiposdemovimentoe +';'+ tiposdemovimentos ;
// 12.03.09
//    tiposdemovimento:=Global.TiposExpContabNotas;
// 16.04.09
    tiposdemovimento:=Global.TiposExpContabNotas +';'+  tiposdemovimentoe +';'+ tiposdemovimentos ;

  sqltipomov:='';
  if not Edtipomov.isempty then
   sqltipomov:=' and '+FGeral.GetIN('moes_tipomov',EdTipomov.text,'C');
// 07.04.09 - exporta pra contabilidade somente notas que geram financeiro
  if Global.Topicos[1004] then
   sqltipomov:=' and '+FGeral.GetIN('moes_tipomov',Global.TiposGeraFinanceiro,'C');

  Q:=sqltoquery('select * from movesto'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
// 05.06.12 - Benato - nao mandar individual..s� leitura Z..
                ' and '+FGeral.GetNOTIN('moes_especie','CF','C')+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
// 14.10.2021 - Clessi
//                ' and moes_obs <> '+Stringtosql('Importado XML NFe') +
// para o postgres 8.4.. ver se n�o baixa bagun�ar os da leilinha...
// certeza q 'baixou' ou melhor n�o deu certo com postgres 12...retirado
//                ' and  ( ( substring(moes_obs from 1 for 9) <> '+stringtosql('Importado')+')'+
//                ' or (moes_obs is null) )'+
                sqltipomov+
//                ' and '+FGeral.Getin('moes_tipocad','C;F','C')+
//                ' and moes_tipocad='+stringtosql(Cv)+
                ' order by moes_datamvto,moes_vispra' );
  if Q.eof then begin
    Avisoerro('Nada encontrado para exporta��o em notas de entrada e saida');
//    exit;
  end;

//  Sistema.beginprocess('Eliminando lan�amentos da �ltima exporta��o');
//////////////////  dbfexp.close;
////////////////  dbfexp.Create(FExpNFprazo);
//  if fileexists( nomearq ) then
//    Deletefile( nomearq );

//////////////////////////////////
{
  dbfexp:=TTable.Create(Application); ;
  dbfexp.Databasename:=NOMEpath;
  dbfexp.Tabletype:=TTDbase;
  dbfexp.tablename:=nomedbf;

  dbfexp.open;

  dbfexp.First;
  while not dbfexp.eof do begin
    dbfexp.delete;
    dbfexp.next;
  end;
////////////////
}
// 31.05.12
  nomearqtexto:='CTBNFS'+FormatDatetime('mmyyyy',EdTermino.Asdate);
// 04.02.16
  if EdSistema.text='04' then begin
    if EdCv.text='C' then
      nomearqtexto:='CTBCOM'+FormatDatetime('mmyyyy',EdTermino.Asdate)
    else
      nomearqtexto:='CTBVEN'+FormatDatetime('mmyyyy',EdTermino.Asdate);
// 18.02.20
  end else if EdSistema.text='06' then begin

      nomearqtexto:='LOTD'+strzero( FGeral.GetContador('EXPNFS'+EdUnid_codigo.Text,false) ,5 ) +
                    EdUnid_codigo.ResultFind.FieldByName('Unid_cnpj').AsString;

  end;

// 12.09.2022
  if not DirectoryExists(EdPasta.Text) then EdPasta.Text:=ExtractFilePath(Application.exename);

  if EdSistema.text='06' then

//    AssignFile(Arquivo, EdPasta.text+'\'+nomearqtexto+'.txt' )
    AssignFile(Arquivo, EdPasta.text+nomearqtexto+'.txt' )

  else

//    AssignFile(Arquivo, EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.txt' );
    AssignFile(Arquivo, EdPasta.text+nomearqtexto+EdUnid_codigo.text+'.txt' );

  try

    Rewrite(Arquivo);

  except

    Avisoerro('Drive ou Pasta n�o encontrado');
    Q.Close;
    EdPasta.setfocus;
    exit;

  end;

  Sistema.beginprocess('Exportando lan�amentos');
  Forns:=Tstringlist.create;
  if Trim(EdMesano.text)<>'' then begin
    empresa:=EdUNid_codigo.resultfind.fieldbyname('unid_empresa1').asinteger;
    filial:=EdUNid_codigo.resultfind.fieldbyname('unid_filial1').asinteger;
  end else begin
    empresa:=EdUNid_codigo.resultfind.fieldbyname('unid_empresa2').asinteger;
    filial:=EdUNid_codigo.resultfind.fieldbyname('unid_filial2').asinteger;
  end;
  sist:=8;
  n:=0;
  tiposmovnao:=Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai;
// 18.02.20 - Gera o header do arquivo
  if EdSistema.text='06' then begin

     linha := 'C' +  // capa de lote
              'M' +  // mensal
              FormatDatetime('ddmmyyyy',EdTermino.AsDate)+
              FormatovalorSemponto( 0,15,2) +
              strspace('Exporta��o Notas',20) +
              'LIF' +  // origem....
              space(10) +   // identificador do lote
              'L' +   // situacao do lote.. L -liberado
              EdUnid_codigo.ResultFind.FieldByName('Unid_cnpj').AsString +
              space(22) +
              '00001' ;   // inicio sequencial do arquivo

              Writeln(Arquivo,linha);

              n := 2;

  end;

/////////////////////////
  linha:='';
  texto.clear;
  ListaClifor:=Tlist.create;
  camponaosocio:=Sistema.GetDicionario('unidades','unid_comprasNS');

  while not Q.eof do begin

    datamvto:=Q.fieldbyname('moes_datamvto').asdatetime;
//    dataes:=Q.fieldbyname('moes_datamvto').asdatetime;
    vispra:=Q.fieldbyname('moes_vispra').asstring;
    debito:=0;credito:=0;vlrdiario:=0;vlrdiarioavista:=0;

    while (not Q.eof) and (datamvto=Q.fieldbyname('moes_datamvto').asdatetime) and (vispra=Q.fieldbyname('moes_vispra').asstring) do begin

      if EstaValendo then begin

        if pos( Q.fieldbyname('moes_tipomov').asstring,global.TiposEntrada ) > 0 then begin

          Cv:='C' ;
          if campoapropria.Tipo<>'' then

             Qa := sqltoquery('select * from apropriacoes where apro_transacao = '+
                   stringtosql( Q.fieldbyname('moes_transacao').asstring )+
                   ' and apro_unid_codigo = '+EdUnid_codigo.assql+
//                   ' and apro_data between '+(EdInicio.assql)+' and '+(EdTermino.assql)+
                   ' and Extract( year from apro_data ) = '+strzero(Datetoano(EdTermino.asdate,true) ,4)+
                   ' and Extract( month from apro_data ) = '+strzero(Datetomes(EdTermino.asdate) ,2)+
                   ' and apro_status = ''N''');

        end else

          Cv:='V';

        GetContasExportacao(Q.fieldbyname('moes_vispra').asstring,Cv,Q.fieldbyname('moes_tipomov').asstring,Q.fieldbyname('moes_comv_codigo').asinteger);

////////////////
        clifor:=FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring,'N');
        clifor:=Sac(clifor);
        vlrinss:=Q.fieldbyname('moes_funrural').ascurrency;
// 13.09.16
        vlrinssret:=Q.fieldbyname('moes_valorinss').ascurrency;
        vlrpisret:=Q.fieldbyname('moes_valorpis').ascurrency;
        vlrcofinsret:=Q.fieldbyname('moes_valorcofins').ascurrency;
        vlrirret:=Q.fieldbyname('moes_valorir').ascurrency;
        vlrcsllret:=Q.fieldbyname('moes_valorcsl').ascurrency;
// 08.03.19
        vlrissret:=Q.fieldbyname('moes_valoriss').ascurrency;
////
        cotacapital:=Q.fieldbyname('moes_cotacapital').ascurrency;
// 15.09.15
        campo:=Sistema.GetDicionario('movesto','moes_vlrgta');
        if campo.tipo<>'' then
          vlrgta:=Q.fieldbyname('moes_vlrgta').ascurrency
        else
          vlrgta:=0;

        if trim(EdMesano.text)='' then begin

           valor:=Q.fieldbyname('moes_valortotal').Ascurrency;
           if valor=0 then
             valor:=Q.fieldbyname('moes_vlrtotal').Ascurrency;

        end else

           valor:=Q.fieldbyname('moes_vlrtotal').Ascurrency;

// 06.04.10 - Abra
        if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodContrato)>0 then begin
          valor:=GetValorFinanceiro(Q.fieldbyname('moes_transacao').asstring);
        end;

//////////////
// 14.03.05
//        if (Q.fieldbyname('moes_vispra').asstring<>'P') or (Q.fieldbyname('moes_valoravista').ascurrency=0) then
//          vlrdiario:=vlrdiario+valor
//        else if
//          vlrdiarioavista:=vlrdiarioavista+valor;
// 05.09.05
//        if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposSaida)>0 then begin
// 09.07.07 - retirado pra fazer as compras tbem....
// 07.04.05
          if (Q.fieldbyname('moes_vispra').asstring='P') then begin
            vlrdiario:=vlrdiario+(valor-Q.fieldbyname('moes_valoravista').ascurrency);
            vlrdiarioavista:=vlrdiarioavista+Q.fieldbyname('moes_valoravista').ascurrency;
// 13.07.07
            if Global.Topicos[1253] then
              atualiza(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring,Cv,valor-Q.fieldbyname('moes_valoravista').ascurrency);
          end else
            vlrdiarioavista:=vlrdiarioavista+valor;
//        end;
///////////////////////////////////
        debito:=ContaGrande(Debito,Q.fieldbyname('moes_transacao').asstring);
        credito:=ContaGrande(credito,Q.fieldbyname('moes_transacao').asstring);
//        if (debito>0) and (credito>0) and (trim(EdMesano.text)<>'') then begin
// 20.04.10
//        if (debito>0) and (credito>0) and (trim(EdMesano.text)<>'') and ( debito<>credito )
// 04.02.16
        xcondicao:=(debito>0) and (credito>0) and (trim(EdMesano.text)<>'') and ( debito<>credito );
        if EdSistema.text='04' then xcondicao:=(trim(cdebito)<>'') and (trim(ccredito)>'') and (trim(EdMesano.text)<>'') and ( cdebito<>ccredito );

        if xcondicao then begin

          if (Q.fieldbyname('moes_vispra').asstring<>'P') or (Q.fieldbyname('moes_valoravista').ascurrency=0) then begin
// 24.04.06
////////////////
            if Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimento then
              historico:=strspace('Conhec. '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple)
            else
              historico:=strspace('NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);

            Somatotais(Q.fieldbyname('moes_tipomov').Asstring,valor);

            if EdSistema.text='02' then begin   // viasoft

               linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                     strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                     strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(valor,14,2)+
                     space(03)+strspace(historico,160);

// 18.02.20 - Sage - Seip

            end else if EdSistema.text='06' then begin   // SAGE

              linha:='L'+
                     strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+
                     strzero(debito,6)+
                     strzero(credito,6)+
                     '000'+   // codigo do historico
                     strspace(historico,025)+
                     FormatovalorSemponto(valor,15,2)+
                     '000'+   //   centro de custos
                     space(14)+  //
                     space(14)+  //
                     strzero( n,05 ); //


            end else if EdSistema.text='03' then begin   // Contax

//               linha:=strzero(empresa,3)+';'+strzero(filial,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
// 19.06.07 - so para nao mudar no erpesc
// 20.06.07
              xcredito:=credito;
              if pos( Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+';'+
///                      Global.CodEntradaProdutor+';'+  // 09.05.17
                      Global.CodDevolucaoCompraProdutor ) >0 then begin // incio do multiplo
                credito:=0;
// 10.12.19
                if pos( Q.fieldbyname('moes_tipomov').asstring,Global.CodEntradaProdutor ) > 0 then

                   valor:=Q.fieldbyname('moes_vlrtotal').ascurrency

                else
  // 14.01.16
                   valor:=Q.fieldbyname('moes_totprod').ascurrency;

              end else if pos( Q.fieldbyname('moes_tipomov').asstring,Global.CodPrestacaoServicosE ) >0 then begin // incio do multiplo

// 05.03.20
                if (vlrpisret+vlrcofinsret+vlrinssret+vlrcsllret+vlrirret+vlrissret)>0 then
                   credito:=0;

                valor:=Q.fieldbyname('moes_vlrtotal').ascurrency;

              end;
// 29.11.10 - retirado em 13.01.16
//              if Q.fieldbyname('moes_tipomov').asstring=Global.CodDevolucaoCompraProdutor then
//                valor:=valor-cotacapital-vlrinss-vlrgta
// 09.01.19 - Vida Nova - Alexsandra  - esperar definicao sobre q data vai pro fiscal
              if CV = 'V' then begin
// 15.01.19
                if Global.Topicos[1054] then
                   datamvto:=Q.fieldbyname('moes_datasaida').AsDatetime;

                linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                     strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                     strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                     space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                     Q.fieldbyname('moes_transacao').Asstring+';'+
                     Q.fieldbyname('moes_tipomov').Asstring+';'+   // 07.04.10
                     Q.fieldbyname('moes_tipo_codigo').Asstring+';'+   // 30.07.19
                     Q.fieldbyname('moes_tipocad').Asstring;   // 30.07.19

              end else

                linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                     strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                     strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                     space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                     Q.fieldbyname('moes_transacao').Asstring+';'+
                     Q.fieldbyname('moes_tipomov').Asstring+';'+   // 07.04.10
                     Q.fieldbyname('moes_tipo_codigo').Asstring+';'+   // 30.07.19
                     Q.fieldbyname('moes_tipocad').Asstring;   // 30.07.19

// 18.02.10 - Abra
            end else if EdSistema.text='04' then begin   // Questor

              xcredito:=credito;
              if Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor then  // incio do multiplo
                credito:=0;

//                linha:=strzero(empresa,3)+','+strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+','+
//                      strzero(debito,7)+','+strzero(credito,7)+','+Formatovalorcomponto(valor,14,2)+','+
//                      '0'+',"'+trim(historico)+'"';
// 08.04.14 - Novo Layout
{
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace(Q.fieldbyname('moes_numerodoc').asstring,10)+';'+
                      strzero(debito,11)+';'+strzero(credito,11 )+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';
                      }
// 04.02.16 - Usando cnpj ao inves das contas para clientes e fornecedores
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace(Q.fieldbyname('moes_numerodoc').asstring,10)+';'+
                      cdebito+';'+ccredito+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';
//                     +Q.fieldbyname('moes_numerodoc').Asstring+';'+
//                         Q.fieldbyname('moes_transacao').Asstring;

// 04.11.10 - Maximo Tributos - Esc.Asterio - Massas Granzotto
//////////////////////////////////////////
            end else if EdSistema.text='05' then begin

              xcredito:=credito;
              if Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor then  // incio do multiplo
                credito:=0;
              deli:='"';
              if pos( Q.fieldbyname('moes_tipomov').asstring,global.TiposEntrada ) > 0 then begin
                  dataes:=Q.fieldbyname('moes_datamvto').asdatetime;
                  ES:='E';
                  codigocontabil:=debito;
              end else  begin
                  dataes:=Q.fieldbyname('moes_dataemissao').asdatetime;
                  Es:='S';
                  codigocontabil:=credito;
              end;
              if Q.fieldbyname('moes_baseicms').Ascurrency>0 then begin
                  aliicms:=roundvalor(Q.fieldbyname('moes_valoricms').Ascurrency/Q.fieldbyname('moes_baseicms').Ascurrency)*100;
                  isentas:=0;
                  outras:=0;
              end else begin
                  aliicms:=0;
                  isentas:=0;
                  outras:=Q.fieldbyname('moes_valortotal').Ascurrency;
              end;
              linha:=deli+strzero(empresa,3)+deli+','+deli+ES+deli+','+deli+
                       FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asstring)+deli+','+deli+
                       Q.fieldbyname('moes_estado').asstring+deli+','+deli+
                       trim(strspace(Q.fieldbyname('moes_numerodoc').Asstring,10))+deli+','+deli+
                       trim(strspace(Q.fieldbyname('moes_especie').Asstring,06))+deli+','+deli+
                       trim(strspace(Q.fieldbyname('moes_serie').Asstring,03))+deli+','+deli+
                       '0'+deli+','+deli+    // diferenciador caso tiver mais cfops...0,1,2...
                       formatdatetime('yyyymmdd',dataes)+deli+','+deli+
                       formatdatetime('yyyymmdd',Q.fieldbyname('moes_dataemissao').asdatetime)+deli+','+deli+
                       Q.fieldbyname('moes_natf_codigo').Asstring+deli+','+
                       Formatovalorcomponto(Q.fieldbyname('moes_valortotal').Ascurrency,14,2)+','+deli+
                       strzero(codigocontabil,4)+deli+','+
                       Formatovalorcomponto(Q.fieldbyname('moes_baseicms').Ascurrency,14,2)+','+
                       Formatovalorcomponto(aliicms,07,2)+','+
                       Formatovalorcomponto(Q.fieldbyname('moes_valoricms').Ascurrency,14,2)+','+
                       Formatovalorcomponto(isentas,14,2)+','+
                       Formatovalorcomponto(outras,14,2)+','+deli+
                       trim(historico)+deli;


//                strzero(debito,7)+','+strzero(credito,7)+','+Formatovalorcomponto(valor,14,2)+','+
//                      '0'+',"'+trim(historico)+'"';
//                         Q.fieldbyname('moes_transacao').Asstring;

            end else begin  // '01' - ph

              linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                     Formatovalorcomponto(valor,17,2)+
                     strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                     strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)
            end;

/////////////////////////////////////////////////////////////
            Writeln(Arquivo,linha);
            inc(n);
/////////////////////////////////////////////////////////////
// 19.03.19
            if Global.Topicos[1055] then GravaContas( debito,credito,Q.FieldByName('moes_transacao').AsString,Q.FieldByName('moes_datamvto').AsDatetime );

// 21.08.20 - varias despesas ( debitos ) para mesma nota de entrada
            contagerencial:=fGeral.GetContaDespesa(Q.FieldByName('moes_transacao').asstring );
            if contagerencial = 9999 then begin

               ListaDesp := TStringList.create;
               strtoLista(Listadesp,Q.FieldByName('moes_devolucoes').asstring,';',true);
               for y := 0 to ListaDesp.count-1 do begin

                   if trim( ListaDesp[y] ) <> '' then begin

                      contagerencial := strtointdef( copy(ListaDesp[y],1,pos('|',ListaDesp[y])-1) ,0);
                      valor          := Texttovalor( copy(ListaDesp[y],pos('|',ListaDesp[y])+1,10) );
                      debito         := FPLano.GetContaExportacao(contagerencial,EdUnid_codigo.text);
                      historico:=strspace('Rateio NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);

                      if EdSistema.text='03' then begin   // contax

                         linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                             strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                             strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                             space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                             Q.fieldbyname('moes_transacao').Asstring+';'+
                             Q.fieldbyname('moes_tipomov').Asstring+';'+
                             Q.fieldbyname('moes_tipo_codigo').Asstring+';'+
                             Q.fieldbyname('moes_tipocad').Asstring;
                             Writeln(Arquivo,linha);
                             inc(n);

                      end else Avisoerro('Ainda n�o configurado rateio para este sistema cont�bil');

                   end;


               end;

               valor     := Q.fieldbyname('moes_vlrtotal').Ascurrency;
               debito    := 0;
               if Q.FieldByName('moes_tipocad').asstring='F' then begin
                 credito:=FFornece.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUnid_codigo.text);
               end else
                 credito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUNid_codigo.text);
               if EdSistema.text='03' then begin   // contax

                         linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                             strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                             strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                             space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                             Q.fieldbyname('moes_transacao').Asstring+';'+
                             Q.fieldbyname('moes_tipomov').Asstring+';'+
                             Q.fieldbyname('moes_tipo_codigo').Asstring+';'+
                             Q.fieldbyname('moes_tipocad').Asstring;
                             Writeln(Arquivo,linha);
                             inc(n);
               end;

            end;


// 20.06.07
//            if Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor then begin   // multiplo
// 11.05.10 - Novi - Vava
            if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodDevolucaoCompraProdutor+';'+
                   Global.CodPrestacaoServicosE)>0 then begin   // multiplo

//              debito:=0;
// 05.03.20
              credito:=xcredito;
              if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor)>0 then begin

                 valor:=valor-cotacapital-vlrinss-vlrgta;
                 if (cotacapital+vlrinss+vlrgta)>0 then
                    debito:=0;

              end else if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodPrestacaoServicosE)>0 then begin

                if ( vlrpisret+vlrcofinsret+vlrinssret+vlrcsllret+vlrirret+vlrissret ) > 0 then begin

                   valor:=valor-vlrpisret-vlrcofinsret-vlrinssret-vlrcsllret-vlrirret-vlrissret;
                   if (vlrpisret+vlrcofinsret+vlrinssret+vlrcsllret+vlrirret+vlrissret)>0 then
                      debito:=0;

                end else

                   valor :=0;


              end else

                valor:=Q.fieldbyname('moes_vlrtotal').Ascurrency;

// credita o liquido o produtor ( cadastro cliente )
////////////////////////////////////
// 19.02.20
              linha:='';

              if EdSistema.text='02' then begin   // viasoft

                 linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                       strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                       strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(valor,14,2)+
                       space(03)+strspace(historico,160);
// 18.02.20 - Sage - Seip

              end else if (EdSistema.text='06') and ( valor>0 ) and ( debito>0 ) and ( credito>0 ) then begin   // Sage

                 linha:='L'+
                        strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+
                        strzero(debito,6)+
                        strzero(credito,6)+
                        '000'+   // codigo do historico
                        strspace(historico,025)+
                        FormatovalorSemponto(valor,15,2)+
                        '000'+   //   centro de custos
                        space(14)+  //
                        space(14)+  //
                        strzero( n,05 ); //


              end else if EdSistema.text='03'  then begin   // erpesc

// 06.03.20
                 if ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodPrestacaoServicosE)>0 )
                    and
                    ( valor = 0 )
                    then
                    linha := ''

                 else

                    linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                       strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                       strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                       space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                         Q.fieldbyname('moes_transacao').Asstring+';'+
                         Q.fieldbyname('moes_tipomov').Asstring+';'+   // 07.04.10
                         Q.fieldbyname('moes_tipo_codigo').Asstring+';'+   // 30.07.19
                         Q.fieldbyname('moes_tipocad').Asstring;   // 30.07.19

              end else if EdSistema.Text='01' then begin  // '01' - ph

                linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                       Formatovalorcomponto(valor,17,2)+
                       strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                       strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)

              end;
// 19.02.20
              if trim( linha ) <> '' then begin

                 Writeln(Arquivo,linha);
                 inc(n);

              end;

// credita a conta do funrural ( inss ) OU inss retido
////////////////////////////////////////////////////////////////
// 21.05.14

              if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodPrestacaoServicosE)>0 then begin

                if camporetencoes.Tipo<>'' then begin

// 10.08.20 - para diferencia do inss( funrural ) das notas NP
                  if (Q.fieldbyname('moes_tipomov').asstring = Global.CodPrestacaoServicosE) then begin

                     if ( campoinsster.tipo<>'' ) then
                        credito:=EdUNid_codigo.ResultFind.fieldbyname('unid_containssret').asinteger
                     else
                        credito:=0;

                  end else

                     credito:=EdUNid_codigo.ResultFind.fieldbyname('unid_containss').asinteger;

                end else

                  credito:=0;

              end else begin
//                debito:=EdUNid_codigo.ResultFind.fieldbyname('unid_containss').asinteger;
// 23.09.16 - ver se sera necessario criar conta propria pra reten��o de inss q s� acontece em nf de prest. de servi�o
//             de constru�ao civil
                debito:=0;
                credito:=0;
              end;

// 10.08.20
              if Q.fieldbyname('moes_tipomov').asstring = Global.CodPrestacaoServicosE then

                 valor := vlrinssret

              else

                 valor:=vlrinss;

              historico:=strspace('Inss NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);
              if ( (credito>0) or (debito>0) ) and ( valor>0 ) then begin

                if EdSistema.text='02' then begin   // viasoft

                   linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                         strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                         strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(valor,14,2)+
                         space(03)+strspace(historico,160);


                end else if ( EdSistema.text='06' ) and ( debito>0 ) and ( credito>0 ) then begin   // sage

                    linha:='L'+
                        strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+
                        strzero(debito,6)+
                        strzero(credito,6)+
                        '000'+   // codigo do historico
                        strspace(historico,025)+
                        FormatovalorSemponto(valor,15,2)+
                        '000'+   //   centro de custos
                        space(14)+  //
                        space(14)+  //
                        strzero( n,05 ); //

                end else if EdSistema.text='03' then begin   // erpesc

                   linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                         strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                         strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                         space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                         Q.fieldbyname('moes_transacao').Asstring+';'+
                         Q.fieldbyname('moes_tipomov').Asstring+';'+   // 07.04.10
                     Q.fieldbyname('moes_tipo_codigo').Asstring+';'+   // 30.07.19
                     Q.fieldbyname('moes_tipocad').Asstring;   // 30.07.19

                end else if EdSistema.Text = '01' then  begin  // '01' - ph

                  linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                         Formatovalorcomponto(valor,17,2)+
                         strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                         strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)

                end;
                Writeln(Arquivo,linha);
                inc(n);

              end else if (credito=0) and (Q.fieldbyname('moes_tipomov').Asstring<>Global.CodEntradaProdutor) then

                 Texto.lines.add('Inss nf produtor '+inttostr(credito)+' doc. '+Q.fieldbyname('moes_numerodoc').Asstring+
                     ' tipo '+Q.fieldbyname('moes_tipomov').Asstring+' Cli/for '+Q.fieldbyname('moes_tipo_codigo').Asstring);

//////////////////////////////////
// credita a conta de valor gta - 15.09.15 - OU pis retido - 13.09.16
////////////////////////////////////////
              if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodPrestacaoServicosE)>0 then begin

                if vlrpisret>0 then begin
                  if camporetencoes.Tipo<>'' then
                    credito:=EdUNid_codigo.ResultFind.fieldbyname('unid_contapisret').asinteger
                  else
                    credito:=0;
                end else begin
                  credito:=0;
                  debito:=0;
                end;
                valor:=vlrpisret;
                historico:=strspace('PIS retido NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);

              end else begin

                if vlrgta>0 then begin
                  if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)>0 then begin
                    credito:=EdUNid_codigo.ResultFind.fieldbyname('unid_contagta').asinteger;
                  end else begin
                    debito:=EdUNid_codigo.ResultFind.fieldbyname('unid_contagta').asinteger;
                    credito:=0;
                  end;
                end else begin
                  credito:=0;
                  debito:=0;
                end;
                valor:=vlrgta;
                historico:=strspace('GTA NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);

              end;

              if ( (credito>0) or (debito>0) ) and ( valor>0 ) then begin

                if EdSistema.text='02' then begin   // viasoft

                   linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                         strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                         strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(valor,14,2)+
                         space(03)+strspace(historico,160);

                end else if EdSistema.text='03' then begin   // erpesc

                   linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                         strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                         strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                         space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                         Q.fieldbyname('moes_transacao').Asstring+';'+
                         Q.fieldbyname('moes_tipomov').Asstring+';'+   // 07.04.10
                     Q.fieldbyname('moes_tipo_codigo').Asstring+';'+   // 30.07.19
                     Q.fieldbyname('moes_tipocad').Asstring;   // 30.07.19

                end else if EdSistema.Text = '01' then begin  // '01' - ph

                  linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                         Formatovalorcomponto(valor,17,2)+
                         strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                         strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)
                end;
                Writeln(Arquivo,linha);
                inc(n);              // 13.10.15

              end else if (credito=0) and (valor>0) then

                 Texto.lines.add('GTA/PIS nf produtor/retido Cr�dito '+inttostr(credito)+' doc. '+Q.fieldbyname('moes_numerodoc').Asstring+
                     ' tipo '+Q.fieldbyname('moes_tipomov').Asstring+' Cli/for '+Q.fieldbyname('moes_tipo_codigo').Asstring);

//////////////////////////////////
// credita a conta de valor IRretido - 13.09.16
////////////////////////////////////////
              valor:=0;
              if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodPrestacaoServicosE)>0 then begin

                if vlrirret>0 then begin
                  if camporetencoes.Tipo<>'' then
                    credito:=EdUNid_codigo.ResultFind.fieldbyname('unid_contairret').asinteger
                  else
                    credito:=0;
                end else begin
                  credito:=0;
                  debito:=0;
                end;
                valor:=vlrirret;
                historico:=strspace('IR retido NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);
              end;

              if ( (credito>0) or (debito>0) ) and ( valor>0 ) then begin

                if EdSistema.text='02' then begin   // viasoft

                   linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                         strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                         strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(valor,14,2)+
                         space(03)+strspace(historico,160);

                end else if EdSistema.text='03' then begin   // erpesc

                   linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                         strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                         strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                         space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                         Q.fieldbyname('moes_transacao').Asstring+';'+
                         Q.fieldbyname('moes_tipomov').Asstring+';'+   // 07.04.10
                     Q.fieldbyname('moes_tipo_codigo').Asstring+';'+   // 30.07.19
                     Q.fieldbyname('moes_tipocad').Asstring;   // 30.07.19

                end else if EdSistema.Text = '01' then begin  // '01' - ph

                  linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                         Formatovalorcomponto(valor,17,2)+
                         strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                         strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)
                end;
                Writeln(Arquivo,linha);
                inc(n);              // 13.10.15

              end else if (credito=0) and (valor>0) then

                 Texto.lines.add('IR retido nf Cr�dito '+inttostr(credito)+' doc. '+Q.fieldbyname('moes_numerodoc').Asstring+
                     ' tipo '+Q.fieldbyname('moes_tipomov').Asstring+' Cli/for '+Q.fieldbyname('moes_tipo_codigo').Asstring);

//////////////////////////////////
// credita a conta de CSLL IRretido - 14.11.16
////////////////////////////////////////
              valor:=0;
              if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodPrestacaoServicosE)>0 then begin
                if vlrcsllret>0 then begin
                  if camporetencoes.Tipo<>'' then
                    credito:=EdUNid_codigo.ResultFind.fieldbyname('unid_contacsllret').asinteger
                  else
                    credito:=0;
                end else begin
                  credito:=0;
                  debito:=0;
                end;
                valor:=vlrcsllret;
                historico:=strspace('CSLL retido NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);
              end;

              if ( (credito>0) or (debito>0) ) and ( valor>0 ) then begin

                if EdSistema.text='02' then begin   // viasoft

                   linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                         strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                         strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(valor,14,2)+
                         space(03)+strspace(historico,160);

                end else if EdSistema.text='03' then begin   // erpesc

                   linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                         strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                         strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                         space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                         Q.fieldbyname('moes_transacao').Asstring+';'+
                         Q.fieldbyname('moes_tipomov').Asstring+';'+   // 07.04.10
                     Q.fieldbyname('moes_tipo_codigo').Asstring+';'+   // 30.07.19
                     Q.fieldbyname('moes_tipocad').Asstring;   // 30.07.19

                end else if EdSistema.Text = '01' then begin  // '01' - ph

                  linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                         Formatovalorcomponto(valor,17,2)+
                         strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                         strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)
                end;
                Writeln(Arquivo,linha);
                inc(n);              // 13.10.15

              end else if (credito=0) and (valor>0) then

                 Texto.lines.add('CSLL retido nf Cr�dito '+inttostr(credito)+' doc. '+Q.fieldbyname('moes_numerodoc').Asstring+
                     ' tipo '+Q.fieldbyname('moes_tipomov').Asstring+' Cli/for '+Q.fieldbyname('moes_tipo_codigo').Asstring);

//////////////////////////////////
// credita a conta de ISS IRretido - 08.03.19
////////////////////////////////////////
              valor:=0;
              if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodPrestacaoServicosE)>0 then begin
                if vlrissret>0 then begin
                  if camporetencoes.Tipo<>'' then
                    credito:=EdUNid_codigo.ResultFind.fieldbyname('unid_contaissret').asinteger
                  else
                    credito:=0;
                end else begin
                  credito:=0;
                  debito:=0;
                end;
                valor:=vlrissret;
                historico:=strspace('ISS retido NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);
              end;

              if ( (credito>0) or (debito>0) ) and ( valor>0 ) then begin

                if EdSistema.text='02' then begin   // viasoft

                   linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                         strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                         strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(valor,14,2)+
                         space(03)+strspace(historico,160);

                end else if EdSistema.text='03' then begin   // erpesc

                   linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                         strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                         strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                         space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                         Q.fieldbyname('moes_transacao').Asstring+';'+
                         Q.fieldbyname('moes_tipomov').Asstring+';'+   // 07.04.10
                     Q.fieldbyname('moes_tipo_codigo').Asstring+';'+   // 30.07.19
                     Q.fieldbyname('moes_tipocad').Asstring;   // 30.07.19

                end else if EdSistema.Text = '01' then begin  // '01' - ph

                  linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                         Formatovalorcomponto(valor,17,2)+
                         strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                         strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)
                end;
                Writeln(Arquivo,linha);
                inc(n);              // 13.10.15

              end else if (credito=0) and (valor>0) then

                 Texto.lines.add('ISS retido nf Cr�dito '+inttostr(credito)+' doc. '+Q.fieldbyname('moes_numerodoc').Asstring+
                     ' tipo '+Q.fieldbyname('moes_tipomov').Asstring+' Cli/for '+Q.fieldbyname('moes_tipo_codigo').Asstring);



//////////////////////////////////
// credita a conta de cota capital  OU o cofins retido - 13.09.16
////////////////////////////////////////
              if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodPrestacaoServicosE)>0 then begin
                if camporetencoes.Tipo<>'' then
                  credito:=EdUNid_codigo.ResultFind.fieldbyname('unid_contacofret').asinteger
                else
                  credito:=0;
                valor:=vlrcofinsret;
                historico:=strspace('COFINS retido NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);
              end else begin
                credito:=FCadcli.GetContaExpCotaCapital(Q.fieldbyname('moes_tipo_codigo').Asinteger,Q.fieldbyname('moes_unid_codigo').Asstring);
                valor:=cotacapital;
                historico:=strspace('Cota Capital NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);
              end;
              if (credito>0) and ( valor>0 ) then begin
                if EdSistema.text='02' then begin   // viasoft

                   linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                         strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                         strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(valor,14,2)+
                         space(03)+strspace(historico,160);

                end else if EdSistema.text='03' then begin   // erpesc

                   linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                         strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                         strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                         space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                         Q.fieldbyname('moes_transacao').Asstring+';'+
                         Q.fieldbyname('moes_tipomov').Asstring+';'+   // 07.04.10
                     Q.fieldbyname('moes_tipo_codigo').Asstring+';'+   // 30.07.19
                     Q.fieldbyname('moes_tipocad').Asstring;   // 30.07.19

// 18.02.10 - Abra
               end else if EdSistema.text='04' then begin   // Questor
               {
                   linha:=strzero(empresa,3)+','+strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+','+
                          strzero(debito,7)+','+strzero(credito,7)+','+Formatovalorcomponto(valor,14,2)+','+
                          '0'+',"'+trim(historico)+'"';
                          }
// 04.02.16 - Usando cnpf ao inves das contas para clientes e fornecedores
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace(Q.fieldbyname('moes_numerodoc').asstring,10)+';'+
                      cdebito+';'+ccredito+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';
//                     +Q.fieldbyname('moes_numerodoc').Asstring+';'+
//                         Q.fieldbyname('moes_transacao').Asstring;

                end else if EdSistema.Text = '01' then begin  // '01' - ph

                  linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                         Formatovalorcomponto(valor,17,2)+
                         strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                         strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)

                end;
                Writeln(Arquivo,linha);
                inc(n);

              end else begin

                if ( FCadcli.getecooperado(Q.fieldbyname('moes_tipo_codigo').Asinteger)) and (cotacapital>0) then
                   Texto.lines.add('Cota Capital/Cofins nf produtor/retido Cr�dito '+inttostr(credito)+' doc. '+Q.fieldbyname('moes_numerodoc').Asstring+
                     ' tipo '+Q.fieldbyname('moes_tipomov').Asstring+' Cli/for '+Q.fieldbyname('moes_tipo_codigo').Asstring);
              end;
//////////////////////////////////


            end; // se for nota de produtor - multiplo

          end else begin

// - 04.05.05 para nao lancar nada a vista
// - aqui deve lan�ar a parte a prazo
// 24.04.06
////////////////
            Somatotais(Q.fieldbyname('moes_tipomov').Asstring,valor-Q.fieldbyname('moes_valoravista').ascurrency);
            if Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimento then
              historico:=strspace('Parte Conhec. '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple)
            else
              historico:=strspace('Parte NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);

            if EdSistema.text='02' then begin   // viasoft

              linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                     strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                     strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(valor-Q.fieldbyname('moes_valoravista').ascurrency,14,2)+
                     space(03)+strspace(historico,160);

            end else if EdSistema.text='03' then begin   // erpesc
// 19.06.07 - so para nao mudar no erpesc

               linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                     strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                     strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                     space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                     Q.fieldbyname('moes_transacao').Asstring+';'+
                     Q.fieldbyname('moes_tipomov').Asstring+';'+   // 07.04.10
                     Q.fieldbyname('moes_tipo_codigo').Asstring+';'+   // 30.07.19
                     Q.fieldbyname('moes_tipocad').Asstring;   // 30.07.19

// 18.02.10 - Abra
            end else if EdSistema.text='04' then begin   // Questor
//                linha:=strzero(empresa,3)+','+strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+','+
//                      strzero(debito,7)+','+strzero(credito,7)+','+Formatovalorcomponto(valor,14,2)+','+
//                      '0'+',"'+trim(historico)+'"';
// 08.04.14 - novo layout
{
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace(Q.fieldbyname('moes_numerodoc').asstring,10)+';'+
                      strzero(debito,11)+';'+strzero(credito,11 )+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';
                      }
// 04.02.16 - Usando cnpf ao inves das contas para clientes e fornecedores
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace(Q.fieldbyname('moes_numerodoc').asstring,10)+';'+
                      cdebito+';'+ccredito+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';

              end else if EdSistema.Text = '01' then begin  // '01' - ph

                linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                       Formatovalorcomponto(valor-Q.fieldbyname('moes_valoravista').ascurrency,17,2)+
                       strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                       strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)
             end;

            Writeln(Arquivo,linha);
//////////////////////////////////////////

//          dbfexp.Post;
            inc(n);
          end;


// 21.08.20 - varias despesas ( debitos ) para mesma nota de entrada
        end else if (trim(Q.fieldbyname('moes_devolucoes').asstring) <> '') and ( credito>0) then  begin

            contagerencial:=fGeral.GetContaDespesa(Q.FieldByName('moes_transacao').asstring );
            if contagerencial = 9999 then begin

               ListaDesp := TStringList.create;
               strtoLista(Listadesp,Q.FieldByName('moes_devolucoes').asstring,'|',true);
               for y := 0 to ListaDesp.count-1 do begin

                   if trim( ListaDesp[y] ) <> '' then begin

                      contagerencial := strtointdef( copy(ListaDesp[y],1,pos(';',ListaDesp[y])-1) ,0);
                      valor          := Texttovalor( copy(ListaDesp[y],pos(';',ListaDesp[y])+1,10) );
                      debito         := FPLano.GetContaExportacao(contagerencial,EdUnid_codigo.text);
                      historico:=strspace('Rateio NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);
                      credito        := 0;

                      if EdSistema.text='03' then begin   // erpesc

                         linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                             strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                             strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                             space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                             Q.fieldbyname('moes_transacao').Asstring+';'+
                             Q.fieldbyname('moes_tipomov').Asstring+';'+
                             Q.fieldbyname('moes_tipo_codigo').Asstring+';'+
                             Q.fieldbyname('moes_tipocad').Asstring;

                         Writeln(Arquivo,linha);
                         inc(n);

                      end else Avisoerro('Ainda n�o configurado rateio para este sistema cont�bil');

                   end;

               end;

               valor          := Q.fieldbyname('moes_vlrtotal').Ascurrency;
               debito         := 0;
               historico      := strspace('NF '+Q.fieldbyname('moes_numerodoc').Asstring+' '+clifor,maximocomple);
               if Q.FieldByName('moes_tipocad').asstring='F' then begin
                 credito:=FFornece.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUnid_codigo.text);
               end else
                 credito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger,EdUNid_codigo.text);
              linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                             strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                             strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                             space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('moes_numerodoc').Asstring+';'+
                             Q.fieldbyname('moes_transacao').Asstring+';'+
                             Q.fieldbyname('moes_tipomov').Asstring+';'+
                             Q.fieldbyname('moes_tipo_codigo').Asstring+';'+
                             Q.fieldbyname('moes_tipocad').Asstring;
               Writeln(Arquivo,linha);
               inc(n);

            end;


//        end else if ( (debito=0) or (credito=0) ) and (trim(EdMesano.text)<>'') and (Q.fieldbyname('moes_vispra').asstring<>'V')
// 14.05.19 - notas de compra futura q nao gera financeiro e nem achou o debito e credito
        end else if ( (debito=0) or (credito=0) ) and (trim(EdMesano.text)<>'')
          then begin
          Texto.lines.add('D�bito '+inttostr(debito)+' Cr�dito '+inttostr(credito)+' doc. '+Q.fieldbyname('moes_numerodoc').Asstring+
              ' tipo '+Q.fieldbyname('moes_tipomov').Asstring+' Cli/for '+Q.fieldbyname('moes_tipo_codigo').Asstring);
// 20.04.10
        end else if (debito>0) and (credito>0) and ( debito=credito ) then begin
          Texto.lines.add('Contas Iguais D�bito '+inttostr(debito)+' Cr�dito '+inttostr(credito)+' doc. '+Q.fieldbyname('moes_numerodoc').Asstring+
              ' tipo '+Q.fieldbyname('moes_tipomov').Asstring+' Cli/for '+Q.fieldbyname('moes_tipo_codigo').Asstring+
              ' '+fGeral.FormataData(Q.fieldbyname('moes_datamvto').AsDatetime) );

        end else if ( (debito=-1) or (credito=-1) ) and (trim(EdMesano.text)<>'') and (Q.fieldbyname('moes_vispra').asstring<>'V')
          then begin
          Texto.lines.add('D:'+inttostr(debito)+' C:'+inttostr(credito)+' doc. '+Q.fieldbyname('moes_numerodoc').Asstring+
              ' '+Q.fieldbyname('moes_tipocad').AsString+':'+Q.fieldbyname('moes_tipo_codigo').Asstring+' '+copy(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').AsInteger,Q.fieldbyname('moes_tipocad').AsString,'R'),1,30)+
              ' sem conta' );
        end;

// 10.02.05 - para notas com parte a vista e parte a prazo
//            fazer mais um lancamento baixando o cliente
// 09.03.05 - somente para notas tipo 1
// 04.05.05
// para nao lan�ar nada a vista
{
}
      end;


      Q.Next;

    end;


// lancamento tipo 2 - total a prazo
    debito:=ContaGrande(Debito,Q.fieldbyname('moes_transacao').asstring);
    credito:=ContaGrande(credito,Q.fieldbyname('moes_transacao').asstring);
//    if (debito>0) and (credito>0) and (trim(EdMesano.text)='') and (EdCv.text<>'C') and (vlrdiario>0) then begin
// 09.07.07
    if EdCv.text='C' then
      historico:=strspace('Total Compras Dia '+formatdatetime('dd/mm/yy',datamvto),maximocomple)
    else
      historico:=strspace('Total Vendas Dia '+formatdatetime('dd/mm/yy',datamvto),maximocomple);
    if (debito>0) and (credito>0) and (trim(EdMesano.text)='')  and (vlrdiario>0) then begin
///////////////////////////////////////
{
}
//////////////////////////////////////////////
// 13.07.07
      if not Global.Topicos[1253] then begin

        if EdSistema.text='02' then begin   // viasoft

          linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                       strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                       strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(vlrdiario,14,2)+
                       space(03)+strspace(historico,160);

        end else if EdSistema.text='03' then begin   // erpesc

          linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                       strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                       strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(vlrdiario,14,2)+';'+
                       space(03)+';'+strspace(historico,160);
// 18.02.10 - Abra
        end else if EdSistema.text='04' then begin   // Questor
//                linha:=strzero(empresa,3)+','+strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+','+
//                      strzero(debito,7)+','+strzero(credito,7)+','+Formatovalorcomponto(valor,14,2)+','+
//                      '0'+',"'+trim(historico)+'"';
// 08.04.14 - Novo Layout
{
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace(Q.fieldbyname('moes_numerodoc').asstring,10)+';'+
                      strzero(debito,11)+';'+strzero(credito,11 )+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';
                      }
// 04.02.16 - Usando cnpf ao inves das contas para clientes e fornecedores
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace(Q.fieldbyname('moes_numerodoc').asstring,10)+';'+
                      cdebito+';'+ccredito+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';


        end else if EdSistema.Text = '01' then begin  // '01' - ph

          linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                 Formatovalorcomponto(vlrdiario,17,2)+
                 strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                 strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)
        end;
        Writeln(Arquivo,linha);
        inc(n);
      end;

    end else if (trim(EdMesano.text)='')  and (vlrdiario>0) and (EdCv.text<>'C') then
       Texto.lines.add('D�bito '+inttostr(debito)+' Cr�dito '+inttostr(credito)+' hist�rico '+historico+' valor '+floattostr(vlrdiario));

// 14.03.05
/////////////////////////////////////////////
// lancamento tipo 2 - total a vista
    debito:=EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger;
//    credito:=EdUnid_codigo.resultfind.fieldbyname('unid_vendaavista').asinteger;
// 04.05.05 - para nao lancar nada a vista
    credito:=0 ; debito:=0 ;

    if (debito>0) and (credito>0) and (trim(EdMesano.text)='') and (EdCv.text<>'C') and (vlrdiarioavista>0) and (EdCv.text<>'A') then begin
///////////////////////////////////////////////////////////////////////
{
}
/////////////////////////////////////////////
////////////////////////////////////////////// - 24.04.06
      historico:=strspace('Parte Venda Dia '+formatdatetime('dd/mm/yy',datamvto),maximocomple);
      if EdSistema.text='02' then begin   // viasoft

        linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                     strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                     strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(vlrdiarioavista,14,2)+
                     space(03)+strspace(historico,160);

      end else if EdSistema.text='03' then begin   // erpesc
               linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                     strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                     strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                     space(03)+';'+strspace(historico,160);
// 18.02.10 - Abra
      end else if EdSistema.text='04' then begin   // Questor
//                linha:=strzero(empresa,3)+','+strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+','+
//                      strzero(debito,7)+','+strzero(credito,7)+','+Formatovalorcomponto(valor,14,2)+','+
//                      '0'+',"'+trim(historico)+'"';
// 08.04.14 - Novo Layout
{
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace(Q.fieldbyname('moes_numerodoc').asstring,10)+';'+
                      strzero(debito,11)+';'+strzero(credito,11 )+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';
                      }
// 04.02.16 - Usando cnpf ao inves das contas para clientes e fornecedores
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace(Q.fieldbyname('moes_numerodoc').asstring,10)+';'+
                      cdebito+';'+ccredito+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';
      end else begin  // '01' - ph

        linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
               Formatovalorcomponto(vlrdiarioavista,17,2)+
               strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
               strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)

      end;
      Writeln(Arquivo,linha);
      inc(n);
    end;

  end;

  Q.close;
  Freeandnil(Q);
// 13.07.07
////////////////////////////////////////////////////
  if (Global.Topicos[1253])  and (EdMesano.isempty)then begin

    for p:=0 to LIstaclifor.count-1 do begin

       PClifor:=Listaclifor[p];
       datamvto:=EdTermino.asdate;
       vlrdiario:=PClifor.valor;
       if PClifor.es='C' then begin

          historico:=strspace('Compras '+FGeral.GetNomeRazaoSocialEntidade(PClifor.codigo,PClifor.tipocad,'R')+' periodo '+formatdatetime('dd/mm/yy',Edinicio.asdate)+' a '+formatdatetime('dd/mm/yy',Edtermino.asdate),maximocomple);
          debito:=EdUnid_codigo.resultfind.fieldbyname('unid_compras').asinteger;
          if PClifor.tipocad='F' then
             credito:=FFornece.GetContaExp(PClifor.codigo,EdUnid_codigo.text)
          else
             credito:=FCadcli.GetContaExp(PClifor.codigo,EdUNid_codigo.text)

       end else begin

          historico:=strspace('Vendas '+FGeral.GetNomeRazaoSocialEntidade(PClifor.codigo,PClifor.tipocad,'R')+' periodo '+formatdatetime('dd/mm/yy',Edinicio.asdate)+' a '+formatdatetime('dd/mm/yy',Edtermino.asdate),maximocomple);
          credito:=EdUnid_codigo.resultfind.fieldbyname('unid_vendaaprazo').asinteger;
          debito:=FCadcli.GetContaExp(PClifor.codigo,EdUNid_codigo.text,'XX');

       end;

       if EdSistema.text='02' then begin   // viasoft

          linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                       strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                       strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(vlrdiario,14,2)+
                       space(03)+strspace(historico,160);
       end else if EdSistema.text='03' then begin   // erpesc

          linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                       strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                       strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(vlrdiario,14,2)+';'+
                       space(03)+';'+strspace(historico,160);
       end else begin  // '01' - ph

          linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                 Formatovalorcomponto(vlrdiario,17,2)+
                 strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                 strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)
       end;
       if (debito>0) and (credito>0) and (vlrdiario>0) then begin
         Writeln(Arquivo,linha);
         inc(n);
       end else
         Texto.lines.add('D�bito '+inttostr(debito)+' Cr�dito '+inttostr(credito)+' hist�rico '+historico+' valor '+floattostr(vlrdiario));
    end;
  end;

  ListaClifor.Clear;

// financeiro - confirmar se � o tipo 'PF'...lan�amento das Provisoes a Pagar direto
//              no financeiro
// 07.03.07
// 14.03.07
  if Global.Topicos[1251] then begin
    Sistema.Beginprocess('Exportando a partir do financeiro');
    if EdMesano.isempty then
      sqldatacont:=''
    else
      sqldatacont:=' and pend_datacont > '+Datetosql(Global.DataMenorBanco);
//por enquanto somente para pagamentos abre pra digitar a conta de despesa
//    if EdCv.text='C' then begin   // entradas
      tiposdemovimento:='P';
//    end else if EdCv.text='V'  then begin  // saidas
//      tiposdemovimento:='R';
//    end else
//      tiposdemovimento:='R;P';
    if trim( FGeral.GetConfig1AsString('Fornnaocontab') ) <> '' then
      sqlfornec:=' and '+FGeral.GetNOTIN('pend_tipo_codigo',FGeral.GetConfig1AsString('Fornnaocontab'),'N')
    else
      sqlfornec:='';
    Q:=sqltoquery('select pend_tipo_codigo,pend_tipocad,pend_numerodcto,pend_rp,pend_fpgt_codigo,pend_tipomov,pend_datacont,'+
                  'pend_plan_conta,pend_datamvto,pend_transacao,sum(pend_valor) as somaparcelas from pendencias'+
                  ' where pend_datamvto >= '+EdInicio.assql+
//                  ' and '+FGeral.getin('pend_status','N;B','C')+
// 30.10.07 - clessi detectou o problema
                  ' and '+FGeral.getin('pend_status','N;B;K','C')+
                  ' and pend_datamvto <= '+EdTermino.assql+
                  ' and '+FGeral.Getin('pend_rp',tiposdemovimento,'C')+
                  ' and pend_unid_codigo='+EdUnid_codigo.assql+
                  sqldatacont+sqlfornec+
// 08.11.08
                  ' and pend_plan_conta > 0'+
//                  ' and pend_parcela=1'+  // 08.08.07
                  ' and '+FGeral.Getin('pend_tipomov',Global.CodPendenciaFinanceira,'C')+
                  ' group by pend_tipo_codigo,pend_tipocad,pend_numerodcto,pend_rp,pend_fpgt_codigo,pend_tipomov,pend_datacont,pend_plan_conta,pend_datamvto,pend_transacao' );
//                  ' order by pend_datamvto' );
    while not Q.eof do begin

      if EstaValendoFinan then begin

        if Q.fieldbyname('pend_rp').asstring='P' then
          Cv:='C'
        else
          Cv:='V';
        if Q.fieldbyname('pend_fpgt_codigo').asstring=FGEral.Getconfig1asstring('Fpgtoavista') then
          condicao:='V'
        else
          condicao:='P';
        GetContasExportacao(condicao,Cv,Q.fieldbyname('pend_tipomov').asstring);
////////////////
        clifor:=FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').asinteger,Q.fieldbyname('pend_tipocad').asstring,'R');
        clifor:=Sac(clifor);
// 08.08.07
        datamvto:=Q.fieldbyname('pend_datamvto').asdatetime;

//        valor:=Q.fieldbyname('pend_valortitulo').Ascurrency;
// 08.08.07
        valor:=Q.fieldbyname('somaparcelas').Ascurrency;
        Somatotais(Q.fieldbyname('pend_tipomov').Asstring,valor);
        historico:=strspace('n.fiscal '+Q.fieldbyname('pend_numerodcto').Asstring+' '+clifor,maximocomple);

//        if ( (debito=0) or (credito=0) ) and (trim(EdMesano.text)<>'') and ( Q.fieldbyname('pend_tipomov').Asstring<>Global.CodPendenciaFinanceira ) then begin
// 08.08.17
        if ( (debito=0) or (credito=0) ) and (trim(EdMesano.text)<>'') then begin
            Texto.lines.add('D�bito '+inttostr(debito)+' Cr�dito '+inttostr(credito)+' documento '+
                             Q.fieldbyname('pend_numerodcto').Asstring+' tipo '+
                             Q.fieldbyname('pend_tipomov').Asstring+
                            ' Transa��o '+Q.fieldbyname('pend_transacao').Asstring+
                            ' Cli/for.'+Q.fieldbyname('pend_tipo_codigo').Asstring);
// 20.04.10 - Abra - Ligiane
        end else if ( (debito>0) or (credito>0) ) and (trim(EdMesano.text)<>'') and (debito=credito) then begin
            Texto.lines.add('D�bito '+inttostr(debito)+' Cr�dito '+inttostr(credito)+' documento '+Q.fieldbyname('pend_numerodcto').Asstring+' tipo '+Q.fieldbyname('pend_tipomov').Asstring+
                            ' '+FGeral.FormataData(Q.fieldbyname('pend_datamvto').AsDatetime)+' Transa��o '+Q.fieldbyname('pend_transacao').Asstring+
                            ' Cli/for.'+Q.fieldbyname('pend_tipo_codigo').Asstring);
        end else if ( (debito=-1) or (credito=-1) ) and (trim(EdMesano.text)<>'')
          then begin
          Texto.lines.add('D:'+inttostr(debito)+' C:'+inttostr(credito)+' doc. '+Q.fieldbyname('pend_numerodcto').Asstring+
              ' '+Q.fieldbyname('pend_tipocad').AsString+':'+Q.fieldbyname('pend_tipo_codigo').Asstring+' '+copy(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').AsInteger,Q.fieldbyname('pend_tipocad').AsString,'R'),1,30)+
              ' sem conta' );
        end else begin
          if EdSistema.text='02' then begin   // viasoft
            linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                   strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                   strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(valor,14,2)+
                   space(03)+strspace(historico,160);
// 18.02.10 - Abra - aqui s� em 08.03.10 ..esqueci...
            end else if EdSistema.text='04' then begin   // Questor
//                linha:=strzero(empresa,3)+','+strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+','+
//                      strzero(debito,7)+','+strzero(credito,7)+','+Formatovalorcomponto(valor,14,2)+','+
//                      '0'+',"'+trim(historico)+'"';
// 08.04.14 - Novo Layout
{
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace(Q.fieldbyname('moes_numerodoc').asstring,10)+';'+
                      strzero(debito,11)+';'+strzero(credito,11 )+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';
                      }
// 04.02.16 - Usando cnpf ao inves das contas para clientes e fornecedores
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace(Q.fieldbyname('moes_numerodoc').asstring,10)+';'+
                      cdebito+';'+ccredito+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';
// 08.08.07
          end else if EdSistema.text='03' then begin   // erpesc
                 linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                       strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                       strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                       space(03)+';'+strspace(historico,160)+';'+Q.fieldbyname('pend_numerodcto').Asstring+';'+
                       Q.fieldbyname('pend_transacao').Asstring+';'+
                       Q.fieldbyname('pend_tipomov').Asstring+';'+
                     Q.fieldbyname('pend_tipo_codigo').Asstring+';'+   // 30.07.19
                     Q.fieldbyname('pend_tipocad').Asstring;   // 30.07.19
           end else begin  // '01' - ph
              linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                     Formatovalorcomponto(valor,17,2)+
                     strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                     strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)
           end;
           Writeln(Arquivo,linha);
           inc(n);
        end;

      end else
           Texto.lines.add('Doc. '+Q.fieldbyname('pend_numerodcto').Asstring+
              ' '+Q.fieldbyname('pend_tipocad').AsString+':'+Q.fieldbyname('pend_tipo_codigo').Asstring+' '+copy(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('pend_tipo_codigo').AsInteger,Q.fieldbyname('pend_tipocad').AsString,'R'),1,30)+
              ' n�o considerado.' );


      Q.Next;
    end;

  end;   // configurado para lan�ar documentos lancados diretamente no financeiro

  FGeral.FEchaquery(Q);
  Freeandnil(Forns);
/////////// 22.10.12 - lan�amentos de cheques devolvidos em aberto
////////////////////////////// - ver COMO BUSCAR O BANCO QUE DEVOLVEU O CHEQUE
{
//      if Recpag='R' then begin
//        sqlrecpag:=' and cheq_emirec='+stringtosql('R');
//        sqltipocad:=' and cheq_tipocad='+stringtosql('C');
//      end else begin
//        sqlrecpag:=' and cheq_emirec='+stringtosql('E');
//        sqltipocad:=' and cheq_tipocad='+stringtosql('F');
//      end;

      if Global.Usuario.OutrosAcessos[0701] then
        sqldatacont:=''
      else
        sqldatacont:=' and cheq_datacont > '+DateToSql(Global.DataMenorBanco);
      Q:=sqltoquery('select * from cheques'+
                  ' where '+FGeral.Getin('cheq_status','N','C')+
                  ' and cheq_devolvido='+Stringtosql('S')+
                  ' and '+FGeral.GetIN('cheq_unid_codigo',EdUnid_codigo.text,'C')+
                  ' and cheq_deposito is null '+
                  ' and cheq_emissao <= '+EdTermino.AsSql+
                  ' and cheq_lancto <= '+EdTermino.AsSql+
                  ' and cheq_emirec='+stringtosql('R')+
                  ' and cheq_tipocad='+stringtosql('C')+
                  sqldatacont );
      while not Q.eof do begin

        GetContasExportacao('P','V',Global.CodPendenciaFinanceira,505);

        if (debito>0) and (credito>0) and (trim(EdMesano.text)<>'') and ( debito<>credito )
           then begin
            historico:=strspace('Cheque numero '+Q.fieldbyname('cheq_cheque').asstring,maximocomple);
            valor:=Q.fieldbyname('cheq_valor').ascurrency;
            Somatotais('CH',valor);
            datamvto:=Q.fieldbyname('cheq_emissao').asdatetime;
            if EdSistema.text='02' then begin   // viasoft
               linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                     strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                     strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(valor,14,2)+
                     space(03)+strspace(historico,160);
            end else if EdSistema.text='03' then begin   // Contax
              linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                     strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                     strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                     space(03)+';'+strspace(historico,160)+';'+''+';'+
                     ''+';';
// 18.02.10 - Abra
            end else if EdSistema.text='04' then begin   // Questor
                linha:=strzero(empresa,3)+','+strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+','+
                      strzero(debito,7)+','+strzero(credito,7)+','+Formatovalorcomponto(valor,14,2)+','+
                      '0'+',"'+trim(historico)+'"';

// 04.11.10 - Maximo Tributos - Esc.Asterio - Massas Granzotto
//////////////////////////////////////////
            end else if EdSistema.text='05' then begin
              xcredito:=credito;
              deli:='"';
              dataes:=Q.fieldbyname('cheq_emissao').asdatetime;
              Es:='S';
              codigocontabil:=credito;
              if pos(EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring,'S;2')=0 then begin
                  aliicms:=0;
                  isentas:=0;
                  outras:=0;
              end else begin
                  aliicms:=0;
                  isentas:=0;
                  outras:=Q.fieldbyname('cheq_valor').Ascurrency;
              end;
              linha:=deli+strzero(empresa,3)+deli+','+deli+ES+deli+','+deli+
                       FGeral.GetCnpjCpfTipoCad(FGeral.GetConfig1AsInteger('clieconsumidor'),'C')+deli+','+deli+
                       Q.fieldbyname('moes_estado').asstring+deli+','+deli+
                       (strspace('',10))+deli+','+deli+
                       trim(strspace('CF',06))+deli+','+deli+
                       trim(strspace('',03))+deli+','+deli+
                       '0'+deli+','+deli+    // diferenciador caso tiver mais cfops...0,1,2...
                       formatdatetime('yyyymmdd',dataes)+deli+','+deli+
                       formatdatetime('yyyymmdd',Qz.fieldbyname('moes_dataemissao').asdatetime)+deli+','+deli+
                       '5102'+deli+','+
                       Formatovalorcomponto(Q.fieldbyname('cheq_valor').Ascurrency,14,2)+','+deli+
                       strzero(codigocontabil,4)+deli+','+
                       Formatovalorcomponto(Q.fieldbyname('cheq_valor').Ascurrency,14,2)+','+
                       Formatovalorcomponto(aliicms,07,2)+','+
                       Formatovalorcomponto(Q.fieldbyname('cheq_valor').Ascurrency,14,2)+','+
                       Formatovalorcomponto(isentas,14,2)+','+
                       Formatovalorcomponto(outras,14,2)+','+deli+
                       trim(historico)+deli;

            end else begin  // '01' - ph
              linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                     Formatovalorcomponto(valor,17,2)+
                     strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                     strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)
            end;
            Writeln(Arquivo,linha);
        end;

        Q.Next;
      end;
      }
//////////////////////////////

/////////////////////////////////////////////////////////
// 06.06.12 - leitura Z - somando total de cupom fiscal por dia de venda - SM bicheira...rs
// inicialmente lan�ado como venda a vista
    if FGeral.GetConfig1AsInteger('ConfMovECF') > 0 then begin
      Qz:=sqltoquery('select moes_dataemissao,sum(moes_vlrtotal) as totaldiario,'+
                ' sum(moes_valoricms) as moes_valoricms,sum(moes_baseicms) as moes_baseicms from movesto'+
                ' where moes_dataemissao>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N','C')+
                ' and moes_dataemissao<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
// 05.06.12 - Benato - nao mandar individual..s� leitura Z..
                ' and '+FGeral.GetIN('moes_comv_codigo',inttostr(FGeral.GetConfig1AsInteger('ConfMovECF')),'N')+
                ' group by moes_dataemissao'+
                ' order by moes_dataemissao' );
      while not Qz.eof do begin
//////////////////
        GetContasExportacao('V','V',Global.CodVendaDireta,FGeral.GetConfig1AsInteger('ConfMovECF'));

        if (debito>0) and (credito>0) and (trim(EdMesano.text)<>'') and ( debito<>credito )
           then begin
            historico:=strspace('Valor Cupom Fiscal neste dia',maximocomple);
            valor:=Qz.fieldbyname('totaldiario').ascurrency;
            datamvto:=Qz.fieldbyname('moes_dataemissao').asdatetime;
            Somatotais(Global.CodVendaDireta,valor);
            if EdSistema.text='02' then begin   // viasoft
               linha:=strzero(empresa,3)+strzero(filial,3)+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+
                     strzero(datetoano(datamvto,true),4)+strzero(datetomes(datamvto),2)+strzero(datetodia(datamvto),2)+
                     strzero(debito,5)+space(06)+strzero(credito,5)+space(06)+Formatovalorcomponto(valor,14,2)+
                     space(03)+strspace(historico,160);
            end else if EdSistema.text='03' then begin   // Contax
              linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                     strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                     strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                     space(03)+';'+strspace(historico,160)+';'+''+';'+
                     ''+';'+''+';'+''+';';
// 18.02.10 - Abra
            end else if EdSistema.text='04' then begin   // Questor
//                linha:=strzero(empresa,3)+','+strzero(datetodia(datamvto),2)+strzero(datetomes(datamvto),2)+strzero(datetoano(datamvto,true),4)+','+
//                      strzero(debito,7)+','+strzero(credito,7)+','+Formatovalorcomponto(valor,14,2)+','+
//                      '0'+',"'+trim(historico)+'"';
// 08.04.14 - Novo Layout
{
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace('',10)+';'+
                      strzero(debito,11)+';'+strzero(credito,11 )+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';
                      }
// 04.02.16 - Usando cnpf ao inves das contas para clientes e fornecedores
                linha:='C;'+EdUNid_codigo.ResultFind.fieldbyname('unid_cnpj').asstring+';'+strzero(datetodia(datamvto),2)+
                      '/'+strzero(datetomes(datamvto),2)+'/'+strzero(datetoano(datamvto,true),4)+';'+
                      strspace(Q.fieldbyname('moes_numerodoc').asstring,10)+';'+
                      cdebito+';'+ccredito+';'+Formatovalorcomponto(valor,14,2)+';'+
                      '0'+';"'+trim(historico)+'"';

// 04.11.10 - Maximo Tributos - Esc.Asterio - Massas Granzotto
//////////////////////////////////////////
            end else if EdSistema.text='05' then begin
              xcredito:=credito;
              deli:='"';
              dataes:=Qz.fieldbyname('moes_dataemissao').asdatetime;
              Es:='S';
              codigocontabil:=credito;
              if pos(EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring,'S;2')=0 then begin
                  aliicms:=roundvalor(Qz.fieldbyname('moes_valoricms').Ascurrency/Qz.fieldbyname('moes_baseicms').Ascurrency)*100;
                  isentas:=0;
                  outras:=0;
              end else begin
                  aliicms:=0;
                  isentas:=0;
                  outras:=Qz.fieldbyname('totaldiario').Ascurrency;
              end;
              linha:=deli+strzero(empresa,3)+deli+','+deli+ES+deli+','+deli+
                       FGeral.GetCnpjCpfTipoCad(FGeral.GetConfig1AsInteger('clieconsumidor'),'C')+deli+','+deli+
                       Q.fieldbyname('moes_estado').asstring+deli+','+deli+
                       (strspace('',10))+deli+','+deli+
                       trim(strspace('CF',06))+deli+','+deli+
                       trim(strspace('',03))+deli+','+deli+
                       '0'+deli+','+deli+    // diferenciador caso tiver mais cfops...0,1,2...
                       formatdatetime('yyyymmdd',dataes)+deli+','+deli+
                       formatdatetime('yyyymmdd',Qz.fieldbyname('moes_dataemissao').asdatetime)+deli+','+deli+
                       '5102'+deli+','+
                       Formatovalorcomponto(Qz.fieldbyname('totaldiario').Ascurrency,14,2)+','+deli+
                       strzero(codigocontabil,4)+deli+','+
                       Formatovalorcomponto(Qz.fieldbyname('moes_baseicms').Ascurrency,14,2)+','+
                       Formatovalorcomponto(aliicms,07,2)+','+
                       Formatovalorcomponto(Qz.fieldbyname('moes_valoricms').Ascurrency,14,2)+','+
                       Formatovalorcomponto(isentas,14,2)+','+
                       Formatovalorcomponto(outras,14,2)+','+deli+
                       trim(historico)+deli;

            end else begin  // '01' - ph
              linha:=Formatdatetime('ddmmyyyy',datamvto)+strzero(debito,8)+strzero(credito,8)+
                     Formatovalorcomponto(valor,17,2)+
                     strzero(0,8)+strspace(historico,64)+strzero(empresa,3)+strzero(empresa,3)+
                     strzero(0,3)+strzero(0,3)+strzero(0,8)+strzero(0,6)
            end;
            Writeln(Arquivo,linha);
        end;

///////////////////
        Qz.Next;
      end;
      FGeral.FechaQuery(Qz);
    end;  // se t� configurado ECF
/////////////////////////////////////////////////////////
///
  // 23.07.20 - lan�ar apropriacao caso houver no periodo
/////////////////////////////////////////////////////
            if ( campoapropria.tipo<>'' ) then begin

              FGeral.Fechaquery( Qa );
              Qa := sqltoquery('select * from apropriacoes where '+
                   ' apro_data between '+(EdInicio.assql)+' and '+(EdTermino.assql)+
                   ' and apro_unid_codigo = '+EdUnid_codigo.assql+
                   ' and apro_status = ''N''');

              while not Qa.eof do begin

                 contagerencial := Qa.fieldbyname('apro_plan_codigo').AsInteger;
                 valor      := Qa.fieldbyname('apro_valor').ascurrency;
                 datamvto   := EdTermino.asdate;
                 historico  := 'Apropriacao nf '+Qa.fieldbyname('apro_numerodoc').Asstring+
                               ' parcela '+strzero(Qa.fieldbyname('apro_vez').asinteger,2)+
                               '/'+strzero(Qa.fieldbyname('apro_nvezes').asinteger,2)+
                               ' '+FPlano.GetDescricao(Contagerencial);
                 credito    := FPlano.GetContaExportacaoAApropriar(contagerencial,EdUnid_codigo.Text);
                 debito     := FPlano.GetContaExportacao(contagerencial,EdUnid_codigo.Text);

// linha somente para exportar para contax por enquanto...
                 linha:=strzero(empresa,3)+';'+strzero(empresa,3)+';'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_reduzido').asstring,6)+';'+
                       strzero(datetoano(datamvto,true),4)+';'+strzero(datetomes(datamvto),2)+';'+strzero(datetodia(datamvto),2)+';'+
                       strzero(debito,7)+';'+space(06)+';'+strzero(credito,7)+';'+space(06)+';'+Formatovalorcomponto(valor,14,2)+';'+
                       space(03)+';'+strspace(historico,160)+';'+Qa.fieldbyname('apro_numerodoc').Asstring+';'+
                         Qa.fieldbyname('apro_transacao').Asstring+';'+
                         Qa.fieldbyname('apro_tipomov').Asstring+';'+   // 07.04.10
                         ''+';'+
                         'F';

                 if trim( linha ) <> '' then begin

                   Writeln(Arquivo,linha);
                   inc(n);

                 end;

                Qa.next;

              end;

              FGeral.FechaQuery( Qa );

            end;


  Closefile(arquivo);

  totais:=0;
  for p:=0 to listatotais.count-1 do begin
    Ptotais:=listatotais[p];
    texto.lines.add('Tipo mov.  '+ptotais.tipomov+' '+formatfloat(f_cr,ptotais.valor)+' - '+floattostr(ptotais.quantos)+' dctos.');
    totais:=totais+ptotais.valor;
  end;
  texto.lines.add(  'Total Geral '+formatfloat(f_cr,totais));
  Sistema.endprocess('Exportados '+inttostr(n)+' lan�amentos');

end;


procedure TFExpNFprazo.Execute;
///////////////////////////////
var nomedestino,arquivo:string;
begin
///////////////////////////  dbfexp.SetShowDeleted(false);
  sistema.beginprocess('checando diret�rio');
  DriveExp:='';   //// 'F:';
  nomearq:=DriveExp+'\VIASOFT\CTB\IMLANCTO.DBF';
  nomearqtexto:='CTBNFS';

  if not fileexists( nomearq ) then begin
     DriveExp:='C:';
     nomearq:=DriveExp+'\VIASOFT\CTB\IMLANCTO.DBF';
     if not fileexists( nomearq ) then begin
       DriveExp:='M:';
       nomearq:=DriveExp+'\VIASOFT\CTB\IMLANCTO.DBF';
       if not fileexists( nomearq ) then begin
         DriveExp:='';
         nomearq:=DriveExp+'\VIASOFT\CTB\IMLANCTO.DBF';
       end;
     end;
  end;
  nomedestino:=DriveExp+'\VIASOFT\CTB\INOVO.DBF';
  arquivo:=DriveExp+'\VIASOFT\CTB\IMNOVO.DBF';
  nomedbf:='IMLANCTO.DBF';
  nomepath:=DriveExp+'\VIASOFT\CTB\';
  sistema.endprocess('');

{
  if not fileexists(nomearq) then begin
    Avisoerro('N�o encontrado '+nomearq);
    close;
    exit;
  end;
}
  ctatransestoque:=FGeral.Getconfig1asinteger('ctatranestoque');

//  Sistema.Beginprocess('Criando arquivo '+nomearq);
//  FGeral.CopiaDbf(nomearq,nomedestino,arquivo);
//  sistema.endprocess('');
//  dbfexp.FileName:=NOMEARQ;

{
  dbfexp.FileName:=NOMEARQ;
  try
    dbfexp.open;
    if not dbfexp.eof then begin
      Edinicio.Setdate(dbfexp.FieldByName('dataini').AsDateTime);
      EdTermino.setdate(dbfexp.FieldByName('datafin').asdatetime);
    end else begin
      Edinicio.Setdate(Sistema.Hoje);
      EdTermino.setdate(Sistema.hoje);
    end;
  except
    Avisoerro('N�o foi poss�vel abrir o arquivo '+nomearq);
    close;
    exit;
  end;
}
  Show;

  if not Arq.TPlano.active then Arq.TPlano.open;
  if trim(EdUnid_codigo.text)='' then
    FExpNFprazo.EdUnid_codigo.text:=Global.CodigoUnidade;
  if trim(EdMesano.text)='' then
    FExpNFprazo.EdMesano.text:=strzero(Datetomes(Sistema.hoje),2)+strzero(Datetoano(Sistema.hoje,true),4);
  if not Arq.Tclientes.active then Arq.Tclientes.open;
  if not Arq.TFornec.active then Arq.TFornec.open;
  FExpNFprazo.EdInicio.setfocus;
// 12.09.2022
  EdPasta.Text:=ExtractFilePath(Application.exename);

end;

procedure TFExpNFprazo.EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
begin
  FGeral.Limpaedit(EdUnid_codigo,key);

end;

procedure TFExpNFprazo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//   dbfexp.Close;

end;

procedure TFExpNFprazo.GravaContas(ctdebito, ctcredito: integer;  xtrans: string ; xmovimento:Tdatetime);
//////////////////////////////////////////////////////////////////////////////////////////////////////
var QT:TSqlquery;
begin

  QT:=sqltoquery('select moct_transacao from movcontab where moct_transacao = '+
                 Stringtosql(xtrans)+' and moct_datamvto = '+Datetosql(xmovimento)+
                 ' and moct_tipo = '+stringtosql('NOTAS') );

  if Qt.Eof then begin

     Sistema.Insert('movcontab');
     Sistema.SetField('moct_transacao',xtrans);
     Sistema.SetField('moct_unid_codigo',EdUNid_codigo.text);
     Sistema.SetField('moct_datamvto',xmovimento);
     Sistema.SetField('moct_tipo','NOTAS');

  end else begin

     Sistema.Edit('movcontab');

  end;
  Sistema.SetField('moct_debito',ctdebito);
  Sistema.SetField('moct_credito',ctcredito);
  if Qt.Eof then
     Sistema.Post()
  else
     Sistema.Post('moct_transacao = '+stringtosql(xtrans)+' and moct_datamvto = '+Datetosql(xmovimento) );
  Sistema.Commit;

  FGeral.FechaQuery(QT);

end;

procedure TFExpNFprazo.EdUnid_codigoValidate(Sender: TObject);
begin
   if EdUnid_codigo.resultfind<>nil then begin
//     if EdUnid_codigo.resultfind.fieldbyname('unid_comprasavista').asinteger=0 then
//       EdUnid_codigo.invalid('Unidade sem conta de exporta��o de compra a vista')
     if EdUnid_codigo.resultfind.fieldbyname('unid_caixa').asinteger=0 then
       EdUnid_codigo.invalid('Unidade sem conta de exporta��o de caixa')
//     else if EdUnid_codigo.resultfind.fieldbyname('unid_compras').asinteger=0 then begin
//      avisoerro('Falta configurar a conta cont�bil de compras a prazo na configura��o da unidade');
//      close;
//      exit;
//     end;
   end;
end;

procedure TFExpNFprazo.EdCvValidate(Sender: TObject);
begin
  if Edcv.text<>'C' then begin
    if not Global.topicos[1253] then begin
      if EdUnid_codigo.resultfind.fieldbyname('unid_clientes').asinteger=0 then begin
        EdCv.invalid('Falta configurar a conta cont�bil de clientes na configura��o da unidade');
      end;
      if EdUnid_codigo.resultfind.fieldbyname('unid_vendaaprazo').asinteger=0 then begin
        EdCv.invalid('Falta configurar a conta cont�bil de vendas a prazo na configura��o da unidade');
      end;
    end;
  end;
end;

function TFExpNFprazo.contagrande(conta: integer ; xtransacao:string): integer;
begin
  result:=conta;
  if EdSistema.Text='02' then begin  // 17.12.09 - Abra - somente pra viasoft
    if conta>99999 then begin
      Texto.lines.add('Conta '+inttostr(conta)+' Transa��o '+xtransacao);
      result:=0
    end;
  end;
end;

function TFExpNFprazo.Formatovalorcomponto(valor: currency; tamanho,
  decimais: integer): string;
const zeros:string='0000000000000000000000';
var vlr:string;
begin
  str(valor:tamanho:decimais,vlr);
  vlr:=trim(vlr);
  result:=copy(zeros,1,tamanho-length(vlr))+vlr;
end;



// 18.02.20
function TFExpNFprazo.FormatovalorSemponto(valor: currency; tamanho,  decimais: integer): string;
/////////////////////////////////////////////////////////////////////////////////////////////////
const zeros:string='0000000000000000000000';
var vlr:string;
begin

  str(valor:tamanho:decimais,vlr);
  vlr:=FGeral.TiraBarra(vlr,'.');
  vlr:=trim(vlr);
  result:=copy(zeros,1,tamanho-length(vlr))+vlr;

end;

procedure TFExpNFprazo.EdSistemaExitEdit(Sender: TObject);
begin
  bexecutarclick(FExpNFprazo);

end;

procedure TFExpNFprazo.bexportadosClick(Sender: TObject);
////////////////////////////////////////////////////////////
var Lista,Listalinha:TStringlist;
    p:integer;
    trazcontas:boolean;
begin

    if EdPasta.isempty then begin
      Avisoerro('Informar drive + pasta');
      exit;
    end;
    if EdSistema.Text<>'03' then begin  // Erpesc
       Avisoerro('Relat�rio dispon�vel apenas para o sistema Contax');
       exit;
    end;
    nomearqtexto:='CTBNFS'+FormatDatetime('mmyyyy',EdTermino.Asdate);
    Lista:=TStringlist.create;
    Sistema.beginprocess('Lendo arquivo');
    try
//      Lista.LoadFromFile( EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.txt');
      Lista.LoadFromFile( EdPasta.text+nomearqtexto+EdUnid_codigo.text+'.txt');
    except
      Avisoerro('Problemas para ler o arquivo '+EdPasta.text+nomearqtexto+EdUnid_codigo.text+'.txt');
      Sistema.endprocess('');
      exit;
    end;
    if lista.count>0 then begin
      trazcontas:=FGeral.ConectaContax;
      Sistema.beginprocess('Gerando relat�rio');
      FRel.Init('RelExportacaoNotasaPrazo');
      FRel.AddTit('Rela��o de Lan�amentos Exportados no arquivo '+EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.txt' );
      FRel.AddCol( 65,1,'D','' ,''              ,'Data'          ,''         ,'',false);
      FRel.AddCol(080,3,'N','+' ,f_cr            ,'Valor'           ,''         ,'',false);
      FRel.AddCol(060,3,'N','' ,''              ,'D�bito'         ,''         ,'',false);
      if trazcontas then
         FRel.AddCol(150,1,'C','' ,''              ,'Descri��o D�bito'         ,''         ,'',false);
      FRel.AddCol(060,3,'N','' ,''              ,'Cr�dito'         ,''         ,'',false);
      if trazcontas then
         FRel.AddCol(150,1,'C','' ,''              ,'Descri��o Cr�dito'         ,''         ,'',false);
      FRel.AddCol(200,1,'C','' ,''              ,'Hist�rico'         ,''         ,'',false);
      FRel.AddCol(090,1,'N','' ,''              ,'Documento'         ,''         ,'',false);
      FRel.AddCol(090,1,'C','' ,''              ,'Transa��o'         ,''         ,'',false);
      FRel.AddCol(060,1,'C','' ,''              ,'Tipo Mov.'         ,''         ,'',false);
// 30.07.19
      FRel.AddCol(060,1,'N','' ,''              ,'Codigo'         ,''         ,'',false);
      FRel.AddCol(060,1,'C','' ,''              ,'Cli/For'         ,''         ,'',false);
    end;

    for p:=0 to LIsta.count-1 do begin

      if trim(lista[p])<>'' then begin

        ListaLInha:=TStringlist.create;
        strtolista(Listalinha,Lista[p],';',true);
        FRel.AddCel(listalinha[05]+'/'+listalinha[04]+'/'+listalinha[03]);
        FRel.AddCel(listalinha[10]);   // valor
        FRel.AddCel(listalinha[06]);   // debito
//        if (trazcontas) and (copy(Listalinha[06],1,5)<>'00000') then FRel.AddCel( FGeral.GetContaContax(strtoint(listalinha[06])));
        if (trazcontas) then FRel.AddCel( FGeral.GetContaContax(strtoint(listalinha[06])));
        FRel.AddCel(listalinha[08]);   // credito
//        if (trazcontas) and (copy(Listalinha[08],1,5)<>'00000') then FRel.AddCel( FGeral.GetContaContax(strtoint(listalinha[08])));
        if (trazcontas)  then FRel.AddCel( FGeral.GetContaContax(strtoint(listalinha[08])));
        FRel.AddCel(listalinha[12]);
        FRel.AddCel(listalinha[13]);
        FRel.AddCel(listalinha[14]);
        FRel.AddCel(listalinha[15]);
// 30.07.19
        FRel.AddCel(listalinha[16]);
        FRel.AddCel(listalinha[17]);
      end;
    end;
    Sistema.endprocess('');
    if lista.count>0 then
      FRel.Video;
    lista.free;

end;

procedure TFExpNFprazo.brelerrosClick(Sender: TObject);
var p:integer;
begin
   FTextrel.Init();
   FTextRel.AddTitulo(Global.NomeSistema+' '+Global.VersaoSistema+space(46)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
   Ftextrel.AddTitulo('Relat�rio de Erros na Exporta��o Cont�bil Notas a Prazo',false,false,true);
   Ftextrel.AddTitulo('',false,false,false);
//   FTextrel.rel.lines:=Texto.lines;
   for p:=0 to Texto.Lines.Count-1 do begin
     FTExtrel.AddLinha(Texto.Lines.Strings[p],false,false,true);
   end;
   FTextrel.Video;
end;

// 04.02.16
procedure TFExpNFprazo.textValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
begin
  if Edsistema.text='04' then EdCv.enabled:=true else EdCv.enabled:=false;
end;


end.
