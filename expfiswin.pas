unit expfiswin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  SQLGrid, ExtCtrls, SqlExpr;

type
  TFExpFiscalWin = class(TForm)
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
    Edinicio: TSQLEd;
    Edtermino: TSQLEd;
    EdCv: TSQLEd;
    EdSistema: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure bExecutarClick(Sender: TObject);
    procedure EdterminoValidate(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdCvExitEdit(Sender: TObject);
    procedure EdSistemaExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
// 08.05.14
    procedure GeraRegistros60;
  end;

var
  FExpFiscalWin: TFExpFiscalWin;
  Arquivo:Textfile;
  nomearq:string;
  QGeral:TSqlquery;
  Lista60,Lista75,Lista75Aux:TStringList;
  empresa,filial:integer;

//const versao:string='069';
// 11.03.19
const versao:string='113';
      codcstoutras:string='040';
      codcstsubs:string='010';
      ufcomsubs:string='SC;RS';
      codcsttributado:string='000';
      SeriesdeServicos:string='F;';


implementation

uses Geral, Sqlsis, Sqlfun, Arquiv, represen, Unidades, munic, fornece,
  Transp, cadcli, Estoque, DB, codigosfis, codigosipi, sintegra;

{$R *.dfm}

procedure TFExpFiscalWin.Execute;
var versaook:string;
    Mat:TStringlist;
    p:integer;

begin
//  nomearq:='\SAC\FISCALWIN.TXT';
// 07.02.09
  nomearq:='FISCAL'+Global.CodigoUnidade+'.TXT';
  Mat:=TStringlist.create;
  versaook:='N';
  if fileexists(nomearq) then begin
   Mat.LoadFromFile(nomearq);
   for p:=0 to mat.count-1 do begin
	   if copy( Mat.Strings[p],1,1 )='T' then begin
   	   if copy( Mat.Strings[p],18,08 )=versao then begin
         versaook:='S';
         break;
       end;
     end;
   end;
   if versaook='S' then begin
     Edinicio.Setdate(FGeral.TextINvertidatodate(copy( Mat.Strings[p],2,8 )));
     EdTermino.setdate(FGeral.TextINvertidatodate(copy( Mat.Strings[p],34,8 )));
   end else begin
     Edinicio.Setdate(Sistema.Hoje);
     EdTermino.setdate(Datetoultimodiames(Sistema.hoje));
   end;
  end else begin
     Edinicio.Setdate(Sistema.Hoje);
     EdTermino.setdate(Datetoultimodiames(Sistema.hoje));
  end;
  texto.clear;
  FGeral.ConfiguraColorEditsNaoEnabled( FExpFiscalWin );
  EdCv.enabled:=(Global.usuario.codigo=100);
  Show;

end;

procedure TFExpFiscalWin.FormActivate(Sender: TObject);
begin
  if trim(EdUnid_codigo.text)='' then
    EdUnid_codigo.text:=Global.CodigoUnidade;
  if not Arq.Tclientes.active then Arq.Tclientes.open;
  if not Arq.TFornec.active then Arq.TFornec.open;
  if not Arq.TConfMovimento.active then Arq.TConfMovimento.open;
  if not Arq.TUnidades.active then Arq.TUnidades.open;
  if not Arq.TRepresentantes.active then Arq.TRepresentantes.open;
  if not Arq.TTransp.active then Arq.TTransp.open;
  if not Arq.TMunicipios.active then Arq.TMunicipios.open;

  EdInicio.setfocus;

end;

/////////////////////////////////////////////////////////////////////////
procedure TFExpFiscalWin.bExecutarClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
var Q,QC,QMovbase,Q71:TSqlquery;
    QTrib:TMemoryquery;
//    QTrib:TSqlquery;
    n,p,totalregE,totalregS,totalregR,totalregC,totalregI,numero,TAMDESCO,contacontabil:integer;
    EmitentesCodigo,Emitentes,Clientes,ClientesCodigo,Lista,ItensCodigo:TStringlist;
    linha,sist,es,cfop,elemento,nomecad,uf,cidade,cep,cnpjcpf,insest,endereco,tomador,tipos,tipomov,transacao,especie,
    serie,cancelada,fantasia,bairro,telefone,fax,email,codigotrib,codcst,obs,ufcidade,cstitem,tipose,tiposs,tipodoc,
    linhaipi,sep,nomecidade,sexo,tipocad,xcst,TipoImposto,TipoDetalhe,xcodigopais,
    cfop54,xcstpis,
    xsituacao:string;

    vlrdesco,vlracres,totalitem,valorzero,isentas,outras,baseicmsst,valoricmsst,valorcontabil,tvalorcontabil,baseicmsstitem,
    valoricmsstitem,rateiobaseicmsst,rateioicmsst,isentasitem,outrasitem,rateioisentas,rateiooutras,baseicmsitem,
    valoricmsitem,valorcontabilitem,aliicmsitem,rateiovalorcontabil,valoripiitem,baseipiitem,aliipiitem,
    outrasipiitem,baseicms,valoricms,aliiss,xalipis,xalicofins,
    valornf,
    aliservicos,
    basepiscofins   :currency;
    primeiroitem    :boolean;
    reducaobase     :extended;

    function GetReducaobase(tr:string):extended;
    ////////////////////////////////////////////
    var Qb:TSqlquery;
    begin
      Qb:=sqltoquery('select movb_reducaobc from movbase where movb_transacao='+stringtosql(tr));
      if not Qb.Eof then
       result:=Qb.fieldbyname('movb_reducaobc').AsFloat
      else
       result:=0;
      FGeral.fechaquery(Qb);
    end;


    procedure PesquisaEntidade(tipocad:string ; codigo:integer );
    begin
      if tipoCad='U' then
        Arq.TUnidades.locate('unid_codigo',strzero(codigo,3),[])
      else if tipoCad='R' then
        Arq.TRepresentantes.locate('repr_codigo',codigo,[])
      else if tipoCad='F' then
        QGeral:=sqltoquery('select * from fornecedores where forn_codigo='+inttostr(codigo))
      else if tipoCad='T' then
        Arq.TTransp.locate('tran_codigo',strzero(codigo,3),[])
      else
        QGeral:=sqltoquery('select * from clientes where clie_codigo='+inttostr(codigo));

      if Qgeral<>nil then begin
        if qgeral.eof then
          avisoerro('tipocad '+tipocad+' codigo '+inttostr(codigo)+' não encontrado');
      end;

    end;


    function GetCidade(tipocad:string ; codigo:integer):string;
    ////////////////////////////////////////////////////////////
    begin
      if tipoCad='U' then
//        result:=EdUnid_codigo.resultfind.fieldbyname('unid_municipio').asstring
//        result:=EdUnid_codigo.resultfind.fieldbyname('unid_cida_codigo').asstring
//  14.10.05
        result:=Arq.TUnidades.fieldbyname('unid_cida_codigo').asstring

      else if tipoCad='R' then
//        result:=FRepresentantes.GetDescricao(Arq.TRepresentantes.fieldbyname('repr_cida_codigo').asinteger)
        result:=Arq.TRepresentantes.fieldbyname('repr_cida_codigo').asstring
      else if tipoCad='F' then
//        result:=FFornece.Getcidade(QGeral.fieldbyname('forn_cida_codigo').asinteger)
        result:=QGeral.fieldbyname('forn_cida_codigo').asstring
      else if tipoCad='T' then
//        result:=FTransp.GetCidade(Arq.TTransp.fieldbyname('tran_cida_codigo').asstring)
        result:=Arq.TTransp.fieldbyname('tran_cida_codigo').asstring
      else
//        result:=FCadcli.GetCidade(QGeral.fieldbyname('clie_cida_codigo_res').asinteger);
        result:=QGeral.fieldbyname('clie_cida_codigo_res').asstring;
    end;

    function GetUF(tipocad:string;codigo:integer):string;
    begin
      if tipoCad='U' then
//        result:=Arq.TUnidades.fieldbyname('unid_uf').asstring
        result:=FUnidades.GetUF(strzero(codigo,3))
      else if tipoCad='R' then
//        result:=FCidades.GetUF(Arq.TRepresentantes.fieldbyname('repr_cida_codigo').asinteger)
        result:=FCidades.GetUF(codigo)
      else if tipoCad='F' then
//        result:=Arq.TFornec.fieldbyname('forn_uf').asstring
        result:=FFornece.getuf(codigo)
      else if tipoCad='T' then
        result:=FTransp.GetUF(codigo)
      else
//        result:=Arq.TClientes.fieldbyname('clie_uf').asstring;
        result:=FCadcli.Getuf(codigo);
// 03.02.05
      if uppercase(result)='XX' then
        result:=EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring;
    end;

    function GetCEP(tipocad:string):string;
    begin
      if tipoCad='U' then
//        result:=EdUnid_codigo.resultfind.fieldbyname('unid_cep').asstring
//   14.10.05
        result:=Arq.TUnidades.fieldbyname('unid_cep').asstring
      else if tipoCad='R' then
        result:=Arq.TRepresentantes.fieldbyname('repr_cep').asstring
      else if tipoCad='F' then
        result:=QGeral.fieldbyname('forn_cep').asstring
      else if tipoCad='T' then
        result:=Arq.TTransp.fieldbyname('tran_cep').asstring
      else
        result:=QGeral.fieldbyname('clie_cepres').asstring;
    end;

    function GetCNPJ(tipocad:string;codigo:integer=0):string;
    begin
      if tipoCad='U' then
//        result:=EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring
//   14.10.05
        result:=Arq.TUnidades.fieldbyname('unid_cnpj').asstring
      else if tipoCad='R' then
        result:=Arq.TRepresentantes.fieldbyname('repr_cnpjcpf').asstring
      else if tipoCad='F' then
//        result:=Arq.TFornec.fieldbyname('forn_cnpjcpf').asstring
        result:=QGeral.fieldbyname('forn_cnpjcpf').asstring
      else if tipoCad='T' then
        result:=Arq.TTransp.fieldbyname('Tran_CNPJCPF').asstring
      else begin
//        result:=Arq.TClientes.fieldbyname('clie_cnpjcpf').asstring;
        result:=QGeral.fieldbyname('clie_cnpjcpf').asstring
      end;
    end;

    function GetInsEst(tipocad:string;codigo:integer):string;
    begin
      if tipoCad='U' then
//        result:=EdUnid_codigo.resultfind.fieldbyname('unid_inscricaoestadual').asstring
//  14.10.05
        result:=Arq.TUnidades.fieldbyname('unid_inscricaoestadual').asstring
      else if tipoCad='R' then
        result:=Arq.TRepresentantes.fieldbyname('repr_inscricaoestadual').asstring
      else if tipoCad='F' then
        result:=qGeral.fieldbyname('forn_inscricaoestadual').asstring
      else if tipoCad='T' then
        result:=Arq.TTransp.fieldbyname('Tran_InscricaoEstadual').asstring
      else begin
        if QGeral.fieldbyname('clie_tipo').asstring='J' then
          result:=QGeral.fieldbyname('clie_rgie').asstring
        else
          result:=' ';
      end;
    end;


    function GetEndereco(tipocad:string;codigo:integer=0):string;
    begin
      if tipoCad='U' then
//        result:=EdUnid_codigo.resultfind.fieldbyname('unid_endereco').asstring
// 14.10.05
        result:=arq.TUnidades.fieldbyname('unid_endereco').asstring
      else if tipoCad='R' then
        result:=Arq.TRepresentantes.fieldbyname('repr_endereco').asstring
      else if tipoCad='F' then
        result:=QGeral.fieldbyname('forn_endereco').asstring
      else if tipoCad='T' then
        result:=Arq.TTransp.fieldbyname('tran_endereco').asstring
      else
        result:=QGeral.fieldbyname('clie_endres').asstring;
    end;

    function GetBairro(tipocad:string;codigo:integer):string;
    begin
      if tipoCad='U' then
//        result:=EdUnid_codigo.resultfind.fieldbyname('unid_bairro').asstring
// 14.10.05
        result:=Arq.TUnidades.fieldbyname('unid_bairro').asstring
      else if tipoCad='R' then
        result:=Arq.TRepresentantes.fieldbyname('repr_bairro').asstring
      else if tipoCad='F' then
        result:=QGeral.fieldbyname('forn_bairro').asstring
      else if tipoCad='T' then
        result:=Arq.TTransp.fieldbyname('tran_bairro').asstring
      else
        result:=QGeral.fieldbyname('clie_bairrores').asstring;
    end;

    function GetTelefone(tipocad:string;codigo:integer):string;
    begin
      if tipoCad='U' then
//        result:=EdUnid_codigo.resultfind.fieldbyname('unid_fone').asstring
// 14.10.05
        result:=Arq.TUnidades.fieldbyname('unid_fone').asstring
      else if tipoCad='R' then
        result:=Arq.TRepresentantes.fieldbyname('repr_fone').asstring
      else if tipoCad='F' then
        result:=QGeral.fieldbyname('forn_fone').asstring
      else if tipoCad='T' then
        result:=Arq.TTransp.fieldbyname('tran_fone').asstring
      else
        result:=QGeral.fieldbyname('clie_fonecom').asstring;
    end;



    function GetFax(tipocad:string;codigo:integer):string;
    begin
      if tipoCad='U' then
//        result:=EdUnid_codigo.resultfind.fieldbyname('unid_fax').asstring
// 14.10.05
        result:=Arq.TUnidades.fieldbyname('unid_fax').asstring
      else if tipoCad='R' then
        result:=Arq.TRepresentantes.fieldbyname('repr_fax').asstring
      else if tipoCad='F' then
        result:=QGeral.fieldbyname('forn_fax').asstring
      else if tipoCad='T' then
        result:=Arq.TTransp.fieldbyname('tran_fax').asstring
      else
        result:=QGeral.fieldbyname('clie_fonecom').asstring;
    end;

    function GetEmail(tipocad:string;codigo:integer):string;
    begin
      if tipoCad='U' then
        result:=' '
      else if tipoCad='R' then
        result:=Arq.TRepresentantes.fieldbyname('repr_email').asstring
      else if tipoCad='F' then
        result:=QGeral.fieldbyname('forn_email').asstring
      else if tipoCad='T' then
        result:=Arq.TTransp.fieldbyname('tran_email').asstring
      else
        result:=QGeral.fieldbyname('clie_email').asstring;
    end;

/////////////////////////////////////////////////////////////
   function  SomaTrib(Transacao:string):string;
// 04.03.05 - so vai dar pra somar aqui quando acertar 100% a gravação das notas
//            por enquanto esta funcão so vai retornar o cst
   var cst:string;
   begin
     QTrib.first;cst:='';
     while not QTrib.eof do begin
       if Qtrib.fieldbyname('movb_transacao').asstring=transacao then begin
         while (Qtrib.fieldbyname('movb_transacao').asstring=transacao) and (not QTrib.eof) do begin
//           isentas:=isentas+QTrib.fieldbyname('movb_isentas').asfloat;
// rever o trato com isentas
//              outras:=outras+QTrib.fieldbyname('movb_outras').asfloat;
// por enquanto retorna somente um cst - rever para o caso de mais de um cst na mesma nota
           if trim(Qtrib.fieldbyname('movb_cst').asstring)<>'' then
             cst:=Qtrib.fieldbyname('movb_cst').asstring;
           qtrib.next;
         end;
         break;
       end;
       qtrib.next;
     end;
     result:=cst;
   end;

////////////////////////////////////
begin
///////////////////////////////////

  if not EdUnid_codigo.validfind then exit;
  if not EdUnid_codigo.valid then exit;
  if not EdTermino.valid then exit;
  if not EdCV.valid then exit;
  if EdUNid_codigo.resultfind.fieldbyname('unid_empresa1').asinteger=0 then begin
    Avisoerro('Falta configurar o codigo da empresa 1 no cadastro de unidades');
    exit;
  end;
  if not confirma('Confirma exportação ?') then exit;
  texto.clear;
  Sistema.beginprocess('Lendo movimento do período');
//  tipose:=Global.CodCompra+';'+Global.CodCompraSemMovEstoque+';'+global.CodConhecimento+';'+
//01.08.09
  tipose:=Global.CodCompra+';'+Global.CodCompraSemMovEstoque+';'+
         Global.CodCompra100+';'+Global.CodRetornoMostruario+';'+
         Global.CodTransfEntrada+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoIgualVenda+';'+
         Global.CodTransfEnt+';'+Global.CodCompraX+';'+Global.CodCompraImobilizado+';'+
         Global.CodCompraMatConsumo+';'+Global.CodCompraSemfinan+';'+Global.CodTransfEntRetTempo+';'+
         Global.CodDevolucaoInd+';'+Global.CodRetornocomServicos+';'+Global.CodDevolucaoSerie5+';'+Global.CodRetornoInd+';'+
         Global.CodCompraProdutor+';'+global.CodCompraSemfinan+';'+
         Global.CodRetornoRemessaConserto+';'+Global.CodEntradaImobilizado+';'+Global.CodCompraIndustria+';'+
         Global.CodCompraFutura+';'+Global.CodCompraRemessaFutura+';'+Global.CodEntradaInd+';'+
         Global.CodEntradaBrinde;

  tiposs:=global.CodVendaDireta+';'+Global.CodVendaConsig+';'+Global.CodVendaSemMovEstoque+';'+
         Global.CodVendaProntaEntrega+';'+Global.CodVendaMagazine+';'+
         Global.CodVendaBrinde+';'+Global.CodVendaConsigMercantil+';'+
         Global.CodVendaSerie4+';'+
         global.CodVendaRomaneio+';'+global.CodVendaAmbulante+';'+Global.CodVendaMostruario+';'+
         Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodTransfSai+';'+
         Global.CodDevolucaoRoman+';'+Global.CodDevolucaoCompra+';'+
         Global.CodConsigMercantil+';'+Global.CodDevolucaoConsigMerc+';'+Global.CodVendaMostruarioII+';'+
         Global.CodDevolucaoCompraSemEstoque+';'+Global.CodRemessaInd+';'+Global.CodVendaBrindeConsig+';'+
         Global.CodRemessaInd+';'+Global.CodVendaBrindeConsig+';'+Global.CodTransMatConsumoS+';'+Global.CodRemessaConserto+';'+
         Global.CodContratoEntrega+';'+Global.CodVendaSemfinan+';'+Global.CodVendaFornecedor+';'+
         Global.CodRemessaIndPropria+';'+Global.CodVendaImobilizado+';'+Global.CodNfeComplementoQtde+';'+
// 11.02.19 - Eticon
         Global.CodPrestacaoServicos;

  if EdCv.text='C' then
    tipos:=tipose
  else if EdCv.text='V' then
    tipos:=tiposs
  else
//    tipos:=tipose+';'+tiposs;
// 28.07.09
    tipos:=Global.TiposExpFiscalNotas;  // a partir de agora usar no inicializa no geral

  Q:=sqltoquery('select * from movestoque'+
//                ' inner join movesto on (moes_transacao=move_transacao and moes_status=move_status)'+
//                ' inner join movesto on (moes_numerodoc=move_numerodoc and moes_tipomov=move_tipomov and moes_datamvto=move_datamvto and moes_unid_codigo=move_unid_codigo)'+
// 01.09.08
                ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                ' where '+FGeral.Getin('move_status','N;X;E;D','C')+
                ' and '+FGeral.Getin('moes_status','N;X;E;D','C')+
                ' and move_datamvto>='+EdInicio.assql+
                ' and move_datamvto<='+EdTermino.assql+
/// 01.09.08
//                ' and '+FGeral.GetNOTIN('moes_serie','F;F ;D','C')+
// 12.04.11 - liberado aqui para abaixo deixar somente as saidas serie 'F'
                ' and '+FGeral.GetNOTIN('moes_serie','D;D ','C')+
// 12.11.08 - nao exportar os cupons fiscais
                ' and '+FGeral.GetNOTIN('moes_especie','CF;CF ;','C')+
//                ' and substr(moes_natf_codigo,1,1) in (''1'',''2'',''3'',''5'',''6'',''7'')'+
                ' and move_unid_codigo='+EdUnid_codigo.assql+
                ' and move_tipomov=moes_tipomov'+
//                ' and moes_unid_codigo='+EdUnid_codigo.assql+
// com esta merda aqui fode a query....04.02.05 - vspqne.....
                ' and moes_datacont is not null'+
                ' and '+FGeral.getin('move_tipomov',tipos,'C')+
                ' and '+FGeral.getin('moes_tipomov',tipos,'C')+
// 08.05.17 - novicarnes
                ' and '+FGeral.GetNOTIN('move_tipomov',Global.TiposNaoFiscal,'C')+
                ' and '+FGeral.GetNOTIN('moes_tipomov',Global.TiposNaoFiscal,'C')+
//                ' and '+FGeral.GetNotin('moes_natf_codigo','1124;2124','C')+
// retirado em 26.08.08
//                ' order by move_datamvto' );
                ' order by move_numerodoc,move_tipomov,move_aliicms' );
//                ' order by moes_transacao' );
//}


  if EdCv.text<>'V' then begin

    Sistema.beginprocess('Lendo movimento de conhecimentos e notas de serviços de retorno e tomados');

    QC:=sqltoquery('select * from movesto'+
//                  ' left join movbase on (moes_transacao=movb_transacao and moes_status=movb_status and moes_tipomov=movb_tipomov)'+
// 01.09.08
                  ' left join movbase on (moes_transacao=movb_transacao and moes_tipomov=movb_tipomov)'+
                  ' where '+FGeral.Getin('moes_status','N','C')+
                  ' and moes_datamvto>='+EdInicio.assql+
                  ' and moes_datamvto<='+EdTermino.assql+
                  ' and moes_unid_codigo='+EdUnid_codigo.assql+
                  ' and '+FGeral.GetNotin('moes_natf_codigo','1902;2902;1124;2124','C')+
                  ' and moes_datacont is not null'+
                  ' and '+FGeral.getin('moes_tipomov',Global.CodConhecimento+';'+
                          Global.CodDevolucaoInd+';'+
                          Global.CodPrestacaoServicosE+';'+
                          Global.CodRetornocomServicos,'C')+
                  ' order by moes_numerodoc,moes_tipomov' );
  end else begin

    if Q.eof then begin
      Avisoerro('Não encontrado notas para exportação');
      Sistema.endprocess('');
      exit;
    end;

  end;
// ajustado pelo cfop para acertar geração para fiscal das DI...
  Sistema.beginprocess('Lendo movimento de tributação do período');
  QTrib:=sqltomemoryquery('select * from movesto'+
//  QTrib:=sqltoquery('select * from movesto'+
                ' inner join movbase on (movb_transacao=moes_transacao)'+
                ' where '+FGeral.Getin('moes_status','N;X','C')+
                ' and moes_datamvto>='+EdInicio.assql+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                ' and moes_tipomov=moes_tipomov'+
                ' and moes_datacont is not null'+
                ' and '+FGeral.getin('moes_tipomov',tipos,'C')+
                ' order by moes_transacao,moes_numerodoc,moes_tipomov' );


  Emitentes:=Tstringlist.create;
  Clientes:=Tstringlist.create;
  EmitentesCodigo:=Tstringlist.create;
  ClientesCodigo:=Tstringlist.create;
  ItensCodigo:=Tstringlist.create;
  empresa:=EdUNid_codigo.resultfind.fieldbyname('unid_empresa1').asinteger;
  filial:=EdUNid_codigo.resultfind.fieldbyname('unid_filial1').asinteger;
  sist:='999';
  n:=0;
  valorzero:=0;
  totalregE:=0;totalregS:=0;totalregR:=0;totalregC:=0;totalregI:=0;
// 07.02.09
//  nomearq:='FISCAL'+EdUNid_codigo.text+'.TXT';
// 11.04.11
//  nomearq:='FISCAL'+EdUNid_codigo.text+FormatDatetime('mmyyyy',EdTermino.Asdate)+'.TXT';
// 08.09.12
  nomearq:=ExtractFilePath(Application.ExeName)+'FISCAL'+EdUNid_codigo.text+FormatDatetime('mmyyyy',EdTermino.Asdate)+'.TXT';

  AssignFile(Arquivo, nomearq );
  Rewrite(Arquivo);
  sep:=';';
  if EdSistema.text='02' then begin  // viasoft

    linha:='A'+'A'+versao+
         DatetoTextInvertida(EdInicio.asdate,true)+
         DatetoTextInvertida(EdTermino.asdate,true)+
         DatetoTextInvertida(Sistema.hoje,true)+
         sist+
         strspace('SISTEMA SAC',20);

  end else begin

    sep:='|';
    linha:='A'+sep+'A'+sep+versao+sep+
         DatetoTextInvertida(EdInicio.asdate,true)+sep+
         DatetoTextInvertida(EdTermino.asdate,true)+sep+
         DatetoTextInvertida(Sistema.hoje,true)+sep+
         sist+sep+
         strspace('SISTEMA SAC',20);

  end;

  Writeln(Arquivo,linha);
  if EdSistema.text='02' then begin  // viasoft   // tipos de registro que serao gerados
//    linha:='A'+'B'+strzero(empresa,3)+strzero(filial,3)+'PE'+'PC'+'II'+'EC'+'EI'+'SC'+'SI';
// 26.02.14 - trocado II por MM
//    linha:='A'+'B'+strzero(empresa,3)+strzero(filial,3)+'PE'+'PC'+'MM'+'EC'+'EI'+'SC'+'SI';
// 11.03.19 - colocado PA
    linha:='A'+'B'+strzero(empresa,3)+strzero(filial,3)+'PE'+'PC'+'MM'+'EC'+'EI'+'SC'+'SI'+'PA';
//         'PE'+'PC'+'MM'+'EI'+'SI';
  end else begin
    linha:='A'+sep+'B'+sep+strzero(empresa,3)+sep+strzero(filial,3)+sep+
         'PE'+sep+'PC'+sep+'II'+sep+'EC'+sep+'EI'+sep+'SC'+sep+'SI';    // CHECAR ....BEM UISQUI...
  end;
  Writeln(Arquivo,linha);
  tvalorcontabil:=0;
  texto.clear;

  if EdCv.text<>'V' then begin

    Sistema.beginprocess('Exportando movimento de conhecimentos e notas de serviços de retorno e tomados');
// 13.11.07
    obs:=space(60);
///////////
    while not QC.eof do begin

      if Qc.fieldbyname('moes_perdesco').ascurrency>0 then
         vlrdesco:=(Qc.fieldbyname('moes_vlrtotal').ascurrency)*(Qc.fieldbyname('moes_perdesco').ascurrency/100)
      else
        vlrdesco:=0;
      tipodoc:='CT-E';
      if Qc.fieldbyname('moes_tipomov').asstring=Global.CodPrestacaoServicosE then
         tipodoc:='NFS'
      else if Qc.fieldbyname('moes_tipomov').asstring<>Global.CodConhecimento then
        tipodoc:='NFE';

      if EdSistema.text='02' then begin  // viasoft

         if Qc.FieldByName('moes_tipomov').AsString = Global.CodPrestacaoServicosE then begin

           aliservicos:=0;
           if Qc.fieldbyname('moes_baseiss').ascurrency > 0 then
              aliservicos:= (Qc.fieldbyname('moes_valoriss').ascurrency/Qc.fieldbyname('moes_baseiss').ascurrency)*100;

           linha:='EC'+strzero(empresa,3)+strzero(filial,3)+
             DatetoTextInvertida(Qc.fieldbyname('moes_datamvto').asdatetime,true)+
             DatetoTextInvertida(Qc.fieldbyname('moes_dataemissao').asdatetime,true)+
             space(10)+                         // codigo do serviço
             space(06)+                         // codigo da operacao
             Fgeral.Exportanumeros(Qc.fieldbyname('moes_vlrtotal').ascurrency,13,2)+
             Fgeral.Exportanumeros(Qc.fieldbyname('moes_baseiss').ascurrency,13,2)+
             Fgeral.Exportanumeros(aliservicos,05,2)+
             Fgeral.Exportanumeros(Qc.fieldbyname('moes_valoriss').ascurrency,13,2)+
             Fgeral.Exportanumeros(0,13,2)+        // outras
             Fgeral.Exportanumeros(0,13,2)+        // isentas
             space(06)+                         // Cód.Config.Contas para Valores
             '0070'+                           //  CST PIS
             Fgeral.Exportanumeros(0,11,2)+        // base pis
             Fgeral.Exportanumeros(0,07,4)+        // aliquota pis
             Fgeral.Exportanumeros(0,11,2)+        // valor pis
             '0070'+                           //  CST cofins
             Fgeral.Exportanumeros(0,11,2)+        // base cofins
             Fgeral.Exportanumeros(0,07,4)+        // aliquota cofins
             Fgeral.Exportanumeros(0,11,2)+        // valor cofins
             Fgeral.Exportanumeros(0,11,2)+        // valor desconto
             '0'+                                  //  **Local de Execução de Serviço
             Fgeral.Exportanumeros(0,12,2)+        // Imposto Retido
             '000';                                // Código da GIA RS


         end else begin

           linha:='EC'+strzero(empresa,3)+strzero(filial,3)+
             DatetoTextInvertida(Qc.fieldbyname('moes_datamvto').asdatetime,true)+
             DatetoTextInvertida(Qc.fieldbyname('moes_dataemissao').asdatetime,true)+
  //           strspace(Qc.fieldbyname('moes_especie').asstring,4)+
             strspace(tipodoc,4)+
             strspace(Qc.fieldbyname('moes_serie').asstring,3)+
             FGeral.exportanumeros(Qc.fieldbyname('moes_numerodoc').asinteger,10,0)+
             strspace(Qc.fieldbyname('moes_vispra').asstring,1)+
             FGeral.exportanumeros(Qc.fieldbyname('moes_tipo_codigo').asinteger,8,0)+
             Fgeral.Exportanumeros(valorzero,13,2)+  // imposto de importacao
             Fgeral.Exportanumeros(valorzero,13,2)+  // valor funrural
             Fgeral.Exportanumeros(valorzero,13,2)+  // diferencial aliquota
             Fgeral.Exportanumeros(Qc.fieldbyname('moes_frete').ascurrency,13,2)+
             strspace(Qc.fieldbyname('Moes_FreteCifFob').asstring,1)+
             Fgeral.Exportanumeros(vlrdesco,13,2)+
             Fgeral.Exportanumeros(valorzero,13,2)+  // despesas acessorias
             Fgeral.Exportanumeros(valorzero,13,2)+  // seguro
             'N'+
             obs+    // observacao
             space(06)+    // cod. config. contas pra valores
             Fgeral.Exportanumeros(valorzero,12,0)+  // numero da DI
  //           FGeral.exportanumeros(valorzero,8,0)+   // 06.10.05 - valmir
  //           FGeral.exportanumeros(strtointdef(Qc.fieldbyname('moes_tran_codigo').asstring,0),8,0)+
             strspace(FTransp.getPlaca(Qc.fieldbyname('Moes_tran_codigo').asstring),8)+
             space(07)+   // placa veiculo
             space(06)+   // codigo config. da observacao
             space(60)+   // chave da NFe
             '00'+        // situacao da CTE  00 - documento regula
             Fgeral.Exportanumeros(valorzero,12,2)+  // abatimento nao tributado
             space(02)+   // codigo de consumo gas/energia
             strspace(Qc.fieldbyname('Moes_chavenfe').asstring,44)+   // Chave do CT-e
             '0'+         // tipo do CT-e
             space(44)+   // chave do CT-e de referencia
             space(01)+   // tipo de rec. deiss - pato branco
             '0'+         // indicador tipo de frete
             space(08)+   // data execucao do serviço
             space(01)+   // indicador natureza do frete
             space(01);   // tipo de assinante D500

         end;

      end else begin  // Contax

        linha:='E'+sep+             // 0
           'C'+sep+                 //01
           strzero(empresa,3)+sep    // 02
           +strzero(filial,3)+sep+    // 03
           DatetoTextInvertida(Qc.fieldbyname('moes_datamvto').asdatetime,true)+sep+        //04
           DatetoTextInvertida(Qc.fieldbyname('moes_dataemissao').asdatetime,true)+sep+     //05
//           strspace(Qc.fieldbyname('moes_especie').asstring,4)+
           strspace(tipodoc,4)+sep+                                                         //06
           strspace(Qc.fieldbyname('moes_serie').asstring,3)+sep+                           //07
           FGeral.exportanumeros(Qc.fieldbyname('moes_numerodoc').asinteger,6,0)+sep+       //08
           strspace(Qc.fieldbyname('moes_vispra').asstring,1)+sep+                          //09
           FGeral.exportanumeros(Qc.fieldbyname('moes_tipo_codigo').asinteger,8,0)+sep+     //10
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // imposto de importacao             //11
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // valor funrural                    //12
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // diferencial aliquota              //13
           Fgeral.Exportanumeros(Qc.fieldbyname('moes_frete').ascurrency,13,2)+sep+         //14
           strspace(Qc.fieldbyname('Moes_FreteCifFob').asstring,1)+sep+                     //15
           Fgeral.Exportanumeros(vlrdesco,13,2)+sep+                                        //16
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // despesas acessorias               //17
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // seguro                            //18
           'N'+sep+                                                                         //19
           obs+sep+    // observacao                                                        //20
           space(06)+sep+    // cod. config. contas pra valores                             //21
           Fgeral.Exportanumeros(valorzero,12,0)+sep+  // numero da DI                      //22
           FGeral.exportanumeros(valorzero,8,0)+sep+   // 06.10.05 - valmir                 //23

           FGeral.exportanumeros(strtointdef(Qc.fieldbyname('moes_tran_codigo').asstring,0),8,0)+sep+     // 24
// 13.11.07 - campos q 'faltavam'
           Fgeral.Exportanumeros(Qc.fieldbyname('moes_vlrtotal').ascurrency,13,2)+sep+                 //25
           Fgeral.Exportanumeros(0,13,2)+sep+                 //26
           Fgeral.Exportanumeros(0,13,2)+sep+                //27
           Fgeral.Exportanumeros(0,13,2)+sep+                 //28
           strspace(FTransp.getPlaca(Qc.fieldbyname('Moes_tran_codigo').asstring),7)+sep+                 // 29
           Qc.fieldbyname('moes_tipocad').asstring+sep+                                                //30
           Qc.fieldbyname('moes_estado').asstring+sep+                                                 //31
           Qc.fieldbyname('moes_unid_codigo').asstring+sep+                                                //32
// 16.02.19 - Eticon - enviar retenções para Contax
// 27.02.19 - para pode exportar os cte
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorinss').ascurrency,13,2)+sep+              //33
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorpis').ascurrency,13,2)+sep+              //34
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorcofins').ascurrency,13,2)+sep+              //35
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorcsl').ascurrency,13,2)+sep+              //36
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorir').ascurrency,13,2)+sep+              //37
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valoriss').ascurrency,13,2);              //38
///////////

      end;

      if ( Qc.fieldbyname('moes_tipomov').asstring=Global.CodDevolucaoInd )
         and (copy(Qc.fieldbyname('moes_natf_codigo').asstring,2,3)='124') then
        Writeln(Arquivo,linha)
      else if Qc.fieldbyname('moes_tipomov').asstring<>Global.CodDevolucaoInd then
        Writeln(Arquivo,linha);

      cfop:=Qc.fieldbyname('moes_natf_codigo').asstring;
      codigotrib:='000';
//      baseicmsitem:=Qc.fieldbyname('moes_vlrtotal').ascurrency;
      baseicmsitem:=Qc.FieldByName('movb_basecalculo').Ascurrency;
      baseicmsstitem:=0;
      valoricmsstitem:=0;
      valoricmsitem:=Qc.fieldbyname('moes_valoricms').ascurrency;
//      valoricmsitem:=Qc.fieldbyname('movb_imposto').ascurrency;
// voltado para moes_valoricms em 13.03.19
      valorcontabilitem:=Qc.fieldbyname('moes_vlrtotal').ascurrency;
//      if Qc.fieldbyname('moes_vlrtotal').ascurrency>0 then
//        aliicmsitem:=FGeral.arredonda(Qc.fieldbyname('moes_valoricms').ascurrency/Qc.fieldbyname('moes_vlrtotal').ascurrency,2)
//      else if Qc.fieldbyname('moes_baseicms').ascurrency>0 then
//        aliicmsitem:=FGeral.arredonda(Qc.fieldbyname('moes_valoricms').ascurrency/Qc.fieldbyname('moes_baseicms').ascurrency,2)
//      else
//        aliicmsitem:=0;
//      aliicmsitem:=aliicmsitem*100;
        aliicmsitem:=Qc.fieldbyname('movb_aliquota').ascurrency;
// 02.01.08 - para evitar q conhecimentos de transporte digitados com aliquota mas sem icms exporte errado
      if valoricmsitem=0 then
        aliicmsitem:=0;
//      (totalitem-vlrdesco)*(Q.fieldbyname('move_aliicms').ascurrency/100);
      isentasitem:=0;
      outrasitem:=0;

      if (valoricmsitem=0) and (Qc.fieldbyname('moes_tipomov').asstring=Global.CodConhecimento) then begin
        baseicmsitem:=0;
        isentasitem:=valorcontabilitem;
// 31.05.06 - Valmir
      end else if  pos(Qc.fieldbyname('moes_tipomov').asstring,Global.TiposNaoCalcIcms)>0 then begin
         baseicmsitem:=0;
         isentasitem:=0;
         outrasitem:=valorcontabilitem;
      end;
// 17.07.07
/////////////////// - 10.07.09
      {
      if ( Global.Topicos[1304] ) and ( pos(Qc.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
        then begin    // entradas td em outras e valor contabil
        outrasitem:=valorcontabilitem;
        baseicmsitem:=0;
        isentasitem:=0;
      end;
      }
///////////////////
      if EdSistema.text='02' then begin  // viasoft

         if Qc.FieldByName('moes_tipomov').AsString <> Global.CodPrestacaoServicosE then begin

            linha:='E'+'I'+space(15)+
                 strspace(cfop,6)+
                 strspace(codigotrib,4)+
                 Fgeral.Exportanumeros(1,15,5)+
                 Fgeral.Exportanumeros(0,13,3)+
                 Fgeral.Exportanumeros(Qc.fieldbyname('moes_vlrtotal').ascurrency,20,9)+
                 Fgeral.Exportanumeros(vlrdesco,13,2)+
                 Fgeral.Exportanumeros(baseicmsstitem,13,2)+  // base icms s.t.  ver com 'ratear' a base da nota pelos produtos
                 Fgeral.Exportanumeros(valoricmsstitem,13,2)+  // valor icms s.t.  ou se terá q gravar em cada item
                 Fgeral.Exportanumeros(0,05,2)+               // aliquota icms s.t.  ou se terá q gravar em cada item
                 Fgeral.Exportanumeros(baseicmsitem,13,2)+   // base calculo
                 Fgeral.Exportanumeros(aliicmsitem,05,2)+
                 Fgeral.Exportanumeros(valoricmsitem,13,2)+
                 Fgeral.Exportanumeros(isentasitem,13,2)+
                 Fgeral.Exportanumeros(outrasitem,13,2)+
                 Fgeral.Exportanumeros(valorzero,13,2)+  // extras icms ( valor ipi, por exemplo)
                 Fgeral.Exportanumeros(valorcontabilitem,13,2)+    // valor contabil
                 space(06)+    // codigo config. contas para valores
                 '000'+        // codigo Gia RS
                 '000'+        // codigo tributacao pis
                 Fgeral.Exportanumeros(0,12,2)+    // base calc. PIS
                 Fgeral.Exportanumeros(0,07,4)+    // aliquota pis
                 Fgeral.Exportanumeros(0,12,3)+    // qtde base  pis
                 Fgeral.Exportanumeros(0,12,4)+    // aliquota pis em real
                 Fgeral.Exportanumeros(0,11,2)+    // valor do pis arq. digital
                 '000'+        // codigo tributacao pis
                 Fgeral.Exportanumeros(0,12,2)+    // base calc. cofins
                 Fgeral.Exportanumeros(0,07,4)+    // aliquota cofins
                 Fgeral.Exportanumeros(0,12,4)+    // aliquota cofins em real
                 Fgeral.Exportanumeros(0,11,2)+    // valor do cofins arq. digital
                 space(01)+                        // indicador tipo de cobrança
                 Fgeral.Exportanumeros(0,08,0)+    // codigo do terceiro cobrança
                 Fgeral.Exportanumeros(0,12,3)+    // qtde base  cofins
                 Fgeral.Exportanumeros(0,12,2)+    // reducao base icms
                 '0'+                              // se houve movimentacao fisica
                 space(02)+                        // base credito pis/cofins
                 space(03)+                        // Nat.Op. Isenção PIS
                 space(03)+                        // Nat.Op. Isenção cofins
                 Fgeral.Exportanumeros(0,05,0)+    // Conf. Tipo de Créd. PIS/COFINS
                 space(03)+                        // Unidade de Conversão do Item
                 Fgeral.Exportanumeros(0,07,4)+    // Diferencial de Alíquota (%)
                 Fgeral.Exportanumeros(0,12,2);    // Valor de Diferencial de Alíq
// 27.03.19
         end else begin

           aliservicos:=0;
           if Qc.fieldbyname('moes_baseiss').ascurrency > 0 then
              aliservicos:= (Qc.fieldbyname('moes_valoriss').ascurrency/Qc.fieldbyname('moes_baseiss').ascurrency)*100;

           xalipis:=1.65;
           xalicofins:=7.6;

           linha:='E'+'S'+
                 strzero(empresa,3)+
                 strzero(filial,3)+
                 strspace('8856465',10)+
                 strspace(cfop,6)+
                 Fgeral.Exportanumeros(Qc.fieldbyname('moes_vlrtotal').ascurrency,13,2)+
                 Fgeral.Exportanumeros(Qc.fieldbyname('moes_baseiss').ascurrency,13,2)+
                 Fgeral.Exportanumeros(aliservicos,05,2)+
                 Fgeral.Exportanumeros(Qc.fieldbyname('moes_valoriss').ascurrency,13,2)+
                 Fgeral.Exportanumeros(0,13,2)+                 // isentas
                 Fgeral.Exportanumeros(0,13,2)+                 // outras
                 space(06)+    // codigo config. contas para valores
                 '0051'+       // cst Pis
                 Fgeral.Exportanumeros(Qc.fieldbyname('moes_baseiss').ascurrency,11,2)+    // base calc. PIS
                 Fgeral.Exportanumeros(xalipis,07,4)+    // aliquota pis
                 Fgeral.Exportanumeros(Qc.fieldbyname('moes_baseiss').ascurrency*(xalipis/100) ,11,2)+    // valor  pis
                 '0051'+        // codigo tributacao cofins
                 Fgeral.Exportanumeros(Qc.fieldbyname('moes_baseiss').ascurrency,11,2)+    // base calc. Cofins
                 Fgeral.Exportanumeros(xalipis,07,4)+    // aliquota cofins
                 Fgeral.Exportanumeros(Qc.fieldbyname('moes_baseiss').ascurrency*(xalicofins/100) ,11,2)+    // valor cofins
                 Fgeral.Exportanumeros(vlrdesco,11,2)+
                 '0'+                              // local execucao servico
                 Fgeral.Exportanumeros(0,12,2)+          // imposto retido
                 '000'+        // codigo Gia RS
                 Fgeral.Exportanumeros(0,05,0)+    // Conf. Tipo de Créd. PIS/COFINS
                 space(02)+                        // difal UF origem
                 space(02)+                        // difal UF destino
                 Fgeral.Exportanumeros(0,12,2)+   // DIFAL - Valor FCP da UF Dest
                 Fgeral.Exportanumeros(0,12,2)+   // DIFAL - Valor ICMS UF Dest
                 Fgeral.Exportanumeros(0,12,2);   // DIFAL - Valor ICMS UF Rem



         end;

      end else begin  // Erpesc

         if Qc.FieldByName('moes_tipomov').AsString <> Global.CodPrestacaoServicosE then begin

            linha:='E'+sep+                                                                      //  0
                'I'+sep+                                                                      // 01
                 space(10)+sep+                                                               // 02
                 strspace(cfop,6)+sep+                                                        // 03
                 strspace(codigotrib,3)+sep+                                                  // 04
                 Fgeral.Exportanumeros(1,13,3)+sep+                                           // 05
                 Fgeral.Exportanumeros(Qc.fieldbyname('moes_vlrtotal').ascurrency,11,2)+sep+  // 06
                 Fgeral.Exportanumeros(vlrdesco,13,2)+sep+                                    // 07
                 Fgeral.Exportanumeros(baseicmsstitem,13,2)+sep+                              // 08
                 Fgeral.Exportanumeros(valoricmsstitem,13,2)+sep+                             // 09
                 Fgeral.Exportanumeros(baseicmsitem,13,2)+sep+                                // 10
                 Fgeral.Exportanumeros(aliicmsitem,05,2)+sep+                                 // 11
                 Fgeral.Exportanumeros(valoricmsitem,13,2)+sep+                               // 12
                 Fgeral.Exportanumeros(isentasitem,13,2)+sep+                                 // 13
                 Fgeral.Exportanumeros(outrasitem,13,2)+sep+                                  // 14
                 Fgeral.Exportanumeros(valorzero,13,2)+sep+  // extras icms ( valor ipi, por exemplo)  // 15
                 Fgeral.Exportanumeros(valorcontabilitem,13,2)+sep+           // valor contabil // 16
                 space(06)+sep+    // codigo config. contas para valores                        // 17
// 13.11.07 - campos q 'faltavam'
                 Qc.fieldbyname('moes_tipomov').AsString+sep+                                           // 18
                 Qc.fieldbyname('moes_unid_codigo').AsString+sep+                                       // 19
                 Qc.fieldbyname('moes_tipocad').AsString+sep+                                           // 20
                 Qc.fieldbyname('moes_tipo_codigo').AsString+sep+                                       // 21
                 formatdatetime('ddmmyyyy',Qc.fieldbyname('moes_datalcto').AsDatetime)+sep+             // 22
                 formatdatetime('ddmmyyyy',Qc.fieldbyname('moes_datamvto').AsDatetime)+sep+             // 23
                 Qc.fieldbyname('moes_numerodoc').AsString+sep+                                         // 24
                 Fgeral.Exportanumeros(Qc.fieldbyname('moes_vlrtotal').ascurrency,11,2)+sep+            // 25
                 Fgeral.Exportanumeros(0,11,2)+sep+                                                     // 26
// 26.08.08 - para pode dif. notas 'desdobradas' na entrada
                 Qc.fieldbyname('moes_serie').asstring;                                                  // 27

         end;

      end;

      Writeln(Arquivo,linha);
//      if EmitentesCodigo.IndexOf(QC.fieldbyname('moes_tipo_codigo').asstring)<0 then begin
// 26.10.05
      if Emitentes.IndexOf(QC.fieldbyname('moes_tipo_codigo').asstring+';'+QC.fieldbyname('moes_tipocad').asstring)<0 then begin
              Emitentes.Add(QC.fieldbyname('moes_tipo_codigo').asstring+';'+QC.fieldbyname('moes_tipocad').asstring);
              EmitentesCodigo.Add(QC.fieldbyname('moes_tipo_codigo').asstring)
      end;

      Qc.next;
    end;
  end;

  Sistema.beginprocess('Exportando movimento de entrada e saida');

  while not Q.eof do begin
//    if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposMovMovEntrada)>0 then begin
    if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin
      es:='E';
      inc(totalregE);
    end else if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodConhecimento)>0 then begin
      es:='C'
    end else begin
      es:='S';
      inc(totalregS);
    end;
// 07.02.13 - SM - Gris - anulacao de valor de conhecimento é entrada com tipo NT
    if Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimentoSaida then begin
      if pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1) ,'123' ) > 0 then
        Es:='E';
    end;

    tipomov:=Q.fieldbyname('moes_tipomov').asstring;
    numero:=Q.fieldbyname('moes_numerodoc').asinteger;
    transacao:=Q.fieldbyname('moes_transacao').asstring;
    primeiroitem:=true;
    obs:=space(60);

    if es='S' then
      tvalorcontabil:=tvalorcontabil+Q.fieldbyname('moes_vlrtotal').ascurrency;

    serie:=Q.fieldbyname('moes_serie').asstring;
    if trim(Q.fieldbyname('moes_especie').asstring)='' then begin
      texto.lines.add('Nota '+Q.fieldbyname('moes_numerodoc').asstring+' Tipo '+Q.fieldbyname('moes_tipomov').asstring+' sem especie gravada.  Colocado NF');
      especie:='NF';
    end else
      especie:=Q.fieldbyname('moes_especie').asstring;
    if trim(Q.fieldbyname('moes_serie').asstring)='' then begin
      texto.lines.add('Nota '+Q.fieldbyname('moes_numerodoc').asstring+' Tipo '+Q.fieldbyname('moes_tipomov').asstring+' sem serie gravada.  Colocado 2');
      serie:='2';
    end else
      serie:=Q.fieldbyname('moes_serie').asstring;
///////////////////////////////////////////////////
// primeiro grava o cabecalho da nota fiscal
    if Q.fieldbyname('moes_perdesco').ascurrency>0 then
       vlrdesco:=(Q.fieldbyname('moes_vlrtotal').ascurrency)*(Q.fieldbyname('moes_perdesco').ascurrency/100)
    else begin
// 21.03.19
      vlrdesco:=0;
      if ( Q.FieldByName('moes_totprod').AsCurrency > Q.FieldByName('moes_vlrtotal').AsCurrency )
         and ( es = 'E' )
         then
         vlrdesco :=Q.FieldByName('moes_totprod').AsCurrency-Q.FieldByName('moes_vlrtotal').AsCurrency
                    - Q.FieldByName('moes_valoripi').AsCurrency;
    end;

    if Q.fieldbyname('moes_peracres').ascurrency>0 then
      vlracres:=(Q.fieldbyname('moes_vlrtotal').ascurrency)*(Q.fieldbyname('moes_peracres').ascurrency/100)
    else
      vlracres:=0;
    if Q.fieldbyname('moes_status').asstring='X' then
      cancelada:='S'
//  27.05.10
    else if Q.fieldbyname('moes_status').asstring='Y' then
      cancelada:=Q.fieldbyname('moes_status').asstring
    else
      cancelada:='N';
    valoricmsst:=Q.fieldbyname('moes_valoricmssutr').ascurrency;
    baseicmsst:=Q.fieldbyname('moes_basesubstrib').ascurrency;
    isentas:=0;
    outras:=0;
    rateiooutras:=0;
    rateioicmsst:=0;
    rateiobaseicmsst:=0;
    codcst:=Somatrib(Q.fieldbyname('moes_transacao').asstring);
//    if Es='S' then begin   //  06.06.05
    if (Es='S') or ( (Es='E') and (EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring='S') )
// 12.03.2013
       or ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodConhecimentoSaida+';')>0 )
    then begin   //  08.07.05
      if (codcst=codcstoutras) or ( trim(EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring)='S' ) then
        outras:=Q.fieldbyname('moes_vlrtotal').ascurrency
// 06.10.05 - leila + valmir + marcia pedir pra retirar neste caso..
//        outras:=0
// 'desretirado' em 04.11.05
      else if codcst=codcstsubs then
        outras:=valoricmsst                                                                   // 06.01.06
      else if ( pos(EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring,ufcomsubs)>0 ) and (valoricmsst>0) then
        outras:=valoricmsst
      else if ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodVendaambulante+';'+Global.CodVendaConsigMercantil)>0 ) then begin
// 14.10.05
        if valoricmsst>0 then
          outras:=valoricmsst
        else
          outras:=Q.fieldbyname('moes_vlrtotal').ascurrency;
// 05.10.05
      end else if ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.CodTransfSai+';'+Global.CodTransfEnt)>0 ) then
//        outras:=Q.fieldbyname('moes_vlrtotal').ascurrency;
// 09.04.09 - transferencias clessi
        outras:=0;

    end else if Es='E' then begin   // 01.09.05

      if ( pos(EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring,ufcomsubs)>0 ) then
        outras:=valoricmsst;
/////////////// - 05.09.05
      if (valoricmsst>0) and (Q.fieldbyname('moes_totprod').ascurrency>0) then begin
        rateioicmsst:=FGeral.arredonda(valoricmsst/Q.fieldbyname('moes_totprod').ascurrency,4);
// 30.05.06 - notas D5 q ficaram com os total dos produtos gravado errado igual ao total da nota
//            devido ao rolo da subst. trib. embutida....
        if Q.fieldbyname('moes_totprod').ascurrency=Q.fieldbyname('moes_vlrtotal').ascurrency then
          rateioicmsst:=FGeral.arredonda(valoricmsst/(Q.fieldbyname('moes_totprod').ascurrency-Q.fieldbyname('moes_valoricmssutr').ascurrency),4);
// 05.09.05 - para notas q tem substituição mas nao tem icms...nao lembro se é venda ambulante ou aquelas nota
//            'uisqui' da 'venda de consignação'
      end else if (valoricmsst>0) and (Q.fieldbyname('moes_vlrtotal').ascurrency>0) then
        rateioicmsst:=FGeral.arredonda(valoricmsst/Q.fieldbyname('moes_vlrtotal').ascurrency,4)
      else
        rateioicmsst:=0;
      if (baseicmsst>0) and (Q.fieldbyname('moes_totprod').ascurrency>0) then begin
        rateiobaseicmsst:=FGeral.arredonda(baseicmsst/Q.fieldbyname('moes_totprod').ascurrency,4);
// 30.05.06 - notas D5 q ficaram com os total dos produtos gravado errado igual ao total da nota
//            devido ao rolo da subst. trib. embutida....
        if Q.fieldbyname('moes_totprod').ascurrency=Q.fieldbyname('moes_vlrtotal').ascurrency then
          rateiobaseicmsst:=FGeral.arredonda(baseicmsst/(Q.fieldbyname('moes_totprod').ascurrency-Q.fieldbyname('moes_valoricmssutr').ascurrency),4);
      end else
        rateiobaseicmsst:=0;
// 05.10.05
//      if ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.CodTransfSai+';'+Global.CodTransfEnt)>0 ) then
//        outras:=Q.fieldbyname('moes_vlrtotal').ascurrency;
// 09.04.09 - retirado este outras das transf. pois 'as da clessi' tem icms normal
// 23.11.05
//      if (Q.fieldbyname('moes_vlrtotal').ascurrency>Q.fieldbyname('moes_baseicms').ascurrency) and (Q.fieldbyname('moes_valoricms').ascurrency>0)
//         and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraImobilizado)>0 ) then
//        outras:=Q.fieldbyname('moes_vlrtotal').ascurrency-Q.fieldbyname('moes_baseicms').ascurrency;
///////////////
// 22.06.06
      if Q.fieldbyname('moes_natf_codigo').asstring='3102' then begin
         outras:=Q.fieldbyname('moes_valoripi').ascurrency;
         isentas:=Q.fieldbyname('moes_outrasdesp').ascurrency;
      end;

    end;
// 20.07.07
//////////////
    baseicms:=Q.fieldbyname('moes_baseicms').ascurrency;
    valoricms:=Q.fieldbyname('moes_valoricms').ascurrency;
///////////////////////////// - 10.07.09 retirado
///////////////////////////// - 04.03.11 recolocado pra quen nao tem credito de icms
{ tbem em 04.03.11 nao fez efeito nenhum...gerou com base e icms as entradas...
    if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
        then begin    // entradas td em outras e valor contabil
        outras:=Q.fieldbyname('moes_vlrtotal').ascurrency;
        isentas:=0;
        baseicms:=0;
        valoricms:=0;
    end;
}
/////////////////////////////

    if (outras>0) then begin
// 07.11.05 - estava baseicms,totprod e vlrtotal
// 08.11.05 - estava vlrttoal baseicms e totprod
// 08.11.05 - remudado de novo
// 23.11.05 - primeiro o totprod
        if (Q.fieldbyname('moes_totprod').ascurrency>0) and (outras<=Q.fieldbyname('moes_totprod').ascurrency) then begin
          rateiooutras:=FGeral.arredonda(outras/Q.fieldbyname('moes_totprod').ascurrency,4);
// 30.05.06
          if Q.fieldbyname('moes_totprod').ascurrency=Q.fieldbyname('moes_vlrtotal').ascurrency then
            rateiooutras:=FGeral.arredonda(outras/(Q.fieldbyname('moes_totprod').ascurrency-Q.fieldbyname('moes_valoricmssutr').ascurrency),4);

        end else if (Q.fieldbyname('moes_vlrtotal').ascurrency>0) and (outras<=Q.fieldbyname('moes_vlrtotal').ascurrency) then
          rateiooutras:=FGeral.arredonda(outras/Q.fieldbyname('moes_vlrtotal').ascurrency,2)
//          rateiooutras:=FGeral.arredonda(outras/Q.fieldbyname('moes_vlrtotal').ascurrency,4)
        else if (Q.fieldbyname('moes_baseicms').ascurrency>0) and (outras<=Q.fieldbyname('moes_baseicms').ascurrency) then
          rateiooutras:=FGeral.arredonda(outras/Q.fieldbyname('moes_baseicms').ascurrency,4)
        else
           rateiooutras:=0;

    end else
        rateiooutras:=0;

// 10.07.06
    if ( Es='E' ) and (isentas>0) then begin
      if (isentas>0) and (Q.fieldbyname('moes_totprod').ascurrency>0) then
        rateioisentas:=FGeral.arredonda(isentas/Q.fieldbyname('moes_totprod').ascurrency,2)
      else
        rateioisentas:=0;
    end;
/////////////////
    if Es='E' then begin

      xsituacao := '00';  // documento regular
      if Q.fieldbyname('moes_status').asstring = 'X' then
         xsituacao := '02'   // cancelada
      else if Q.fieldbyname('moes_status').asstring = 'Y' then
         xsituacao := '04'   //denegada
      else if Q.fieldbyname('moes_status').asstring = 'I' then
         xsituacao := '05' ;  // numero inutilizado

      if EdSistema.text='02' then begin  // viasoft

        if trim(Q.fieldbyname('moes_chavenfe').asstring)<>'' then especie:='NF-E';
        if especie='NFE' then especie:='NF-E';
        linha:=es+'C'+strzero(empresa,3)+strzero(filial,3)+
           DatetoTextInvertida(Q.fieldbyname('moes_datamvto').asdatetime,true)+
           DatetoTextInvertida(Q.fieldbyname('moes_dataemissao').asdatetime,true)+
           strspace(especie,4)+
           strspace(serie,3)+
           FGeral.exportanumeros(Q.fieldbyname('moes_numerodoc').asinteger,10,0)+
           strspace(Q.fieldbyname('moes_vispra').asstring,1)+
           FGeral.exportanumeros(Q.fieldbyname('moes_tipo_codigo').asinteger,8,0)+
           Fgeral.Exportanumeros(valorzero,13,2)+  // imposto de importacao
           Fgeral.Exportanumeros(valorzero,13,2)+  // valor funrural
           Fgeral.Exportanumeros(valorzero,13,2)+  // diferencial aliquota
           Fgeral.Exportanumeros(Q.fieldbyname('moes_frete').ascurrency,13,2)+
           strspace(Q.fieldbyname('Moes_FreteCifFob').asstring,1)+
           Fgeral.Exportanumeros(vlrdesco,13,2)+
           Fgeral.Exportanumeros(valorzero,13,2)+  // despesas acessorias
           Fgeral.Exportanumeros(valorzero,13,2)+  // seguro
           Cancelada+
           obs+    // observacao
           space(06)+    // cod. config. contas pra valores
           Fgeral.Exportanumeros(valorzero,12,0)+  // numero da DI
           FGeral.exportanumeros(strtointdef(Q.fieldbyname('moes_tran_codigo').asstring,0),8,0)+
           strspace(FTransp.getPlaca(Q.fieldbyname('Moes_tran_codigo').asstring),7)+
           space(06)+                             // Código da conf. da observação
           strspace(Q.fieldbyname('moes_chavenfe').asstring,60)+
//           space(02)+                             // Situação da NF
           xsituacao+
           Fgeral.Exportanumeros(valorzero,12,2)+  // Abatimento Não Tributado
           space(02)+                            // Cód. Consumo de Gás/Energia
           space(44)+                            // Chave do CT-e
           '0'+                                  // Tipo do CT-e
           space(44)+                            // Chave do CT-e de referencia
           space(01)+                            // Tipo de Rec DEISS-PB
           '0'+                                  // Indicador tipo de frete****
           space(08)+                            // Data de Execução do Serviço
           space(01)+                            // **Indicador da Natur. do Frete
           space(01)+                            // Tipo do Assinante - D500***
           '0'+                                  //  Tipo nf p/ giss
           space(01)+                            // codigo tipo de ligação
           space(02)+                            // codigo grupo de tensão
           space(68)+                            // identificador de origem
           space(01)+                            // Tipo da Nota Fiscal p/ GIIGISS
           space(01)+                            // Tipo da Nota Fiscal p/ GIIGISS
           space(02)+                            // Forma de Pagamento**
           space(21)+                            // Número do Processo do eSocial
           '0000000000'+                            // Cód. Indicativo da Suspensão
           space(05);                            // Cidade



      end else begin   // Erpesc -> Contax

        linha:=es+sep+     //0
           'C'+sep+           //1
           strzero(empresa,3)+sep+  //2
           strzero(filial,3)+sep+  // confirma se e´isto mesmo   //3
           DatetoTextInvertida(Q.fieldbyname('moes_datamvto').asdatetime,true)+sep+  //4
           DatetoTextInvertida(Q.fieldbyname('moes_dataemissao').asdatetime,true)+sep+  //5
           strspace(especie,4)+sep+  //6
           strspace(serie,3)+sep+    //7
           FGeral.exportanumeros(Q.fieldbyname('moes_numerodoc').asinteger,6,0)+sep+   //8
           strspace(Q.fieldbyname('moes_vispra').asstring,1)+sep+                      //9
           FGeral.exportanumeros(Q.fieldbyname('moes_tipo_codigo').asinteger,8,0)+sep+ //10
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // imposto de importacao        //11
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // valor funrural               //12
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // diferencial aliquota         //13
           Fgeral.Exportanumeros(Q.fieldbyname('moes_frete').ascurrency,13,2)+sep+     //14
           strspace(Q.fieldbyname('Moes_FreteCifFob').asstring,1)+sep+                 //15
           Fgeral.Exportanumeros(vlrdesco,13,2)+sep+                                   //16
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // despesas acessorias          //17
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // seguro                       //18
           Cancelada+sep+                                                              //19
           obs+sep+    // observacao                                                   //20
           space(06)+sep+    // cod. config. contas pra valores                        //21
           Fgeral.Exportanumeros(valorzero,10,0)+sep+  // numero da DI                 //22
           FGeral.exportanumeros(valorzero,8,0)+sep+   // 06.10.05 - valmir                 //23

           FGeral.exportanumeros(strtointdef(Q.fieldbyname('moes_tran_codigo').asstring,0),8,0)+sep+  //24
           Fgeral.Exportanumeros(Q.fieldbyname('moes_vlrtotal').ascurrency,13,2)+sep+                 //25
           Fgeral.Exportanumeros(baseicms,13,2)+sep+                 //26
           Fgeral.Exportanumeros(valoricms,13,2)+sep+                //27
           Fgeral.Exportanumeros(Q.fieldbyname('moes_funrural').ascurrency,13,2)+sep+                 //28
           strspace(FTransp.getPlaca(Q.fieldbyname('Moes_tran_codigo').asstring),7)+sep+              //29
           Q.fieldbyname('moes_tipocad').asstring+sep+                                                //30
           Q.fieldbyname('moes_estado').asstring+sep+                                                 //31
           Q.fieldbyname('moes_unid_codigo').asstring+sep+                                          //32
// 16.02.19 - Eticon - enviar retenções para Contax
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorinss').ascurrency,13,2)+sep+              //33
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorpis').ascurrency,13,2)+sep+              //34
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorcofins').ascurrency,13,2)+sep+              //35
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorcsl').ascurrency,13,2)+sep+              //36
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorir').ascurrency,13,2)+sep+              //37
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valoriss').ascurrency,13,2);              //38

      end;

    end else begin  // Saidas   ///////////////////////////////////////////////

      if baseicmsst>0 then begin
        obs:=strspace('Base ST.:'+formatfloat(f_cr3,baseicmsst)+' Vlr ST.:'+formatfloat(f_cr3,valoricmsst),60)
      end;
      codcst:=Somatrib(Q.fieldbyname('moes_transacao').asstring);
      if (codcst=codcstoutras) or ( trim(EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring)='S' )then
        outras:=Q.fieldbyname('moes_vlrtotal').ascurrency
      else if codcst=codcstsubs then
        outras:=valoricmsst
      else if pos(EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring,ufcomsubs)>0 then
        outras:=valoricmsst;


//      if (isentas>0) and (Q.fieldbyname('moes_vlrtotal').ascurrency>0) then
//        rateioisentas:=FGeral.arredonda(isentas/Q.fieldbyname('moes_vlrtotal').ascurrency,4)
// 08.09.05
      if (isentas>0) and (Q.fieldbyname('moes_totprod').ascurrency>0) then
        rateioisentas:=FGeral.arredonda(isentas/Q.fieldbyname('moes_totprod').ascurrency,2)
      else
        rateioisentas:=0;


      if (valoricmsst>0) and (Q.fieldbyname('moes_baseicms').ascurrency>0) then
        rateioicmsst:=FGeral.arredonda(valoricmsst/Q.fieldbyname('moes_baseicms').ascurrency,2)
// 05.09.05 - para notas q tem substituição mas nao tem icms...nao lembro se é venda ambulante ou aquelas nota
//            'uisqui' da 'venda de consignação'
      else if (valoricmsst>0) and (Q.fieldbyname('moes_totprod').ascurrency>0) then
        rateioicmsst:=FGeral.arredonda(valoricmsst/Q.fieldbyname('moes_totprod').ascurrency,2)
      else
        rateioicmsst:=0;
      if (baseicmsst>0) and (Q.fieldbyname('moes_totprod').ascurrency>0) then
        rateiobaseicmsst:=FGeral.arredonda(baseicmsst/Q.fieldbyname('moes_totprod').ascurrency,2)
// 05.09.05 - para notas q tem substituição mas nao tem icms...nao lembro se é venda ambulante ou aquelas nota
//            'uisqui' da 'venda de consignação'
      else if (baseicmsst>0) and (Q.fieldbyname('moes_vlrtotal').ascurrency>0) then
        rateiobaseicmsst:=FGeral.arredonda(baseicmsst/Q.fieldbyname('moes_vlrtotal').ascurrency,2)
      else
        rateiobaseicmsst:=0;

      TipoImposto:='C';
      if ( pos( trim(Q.fieldbyname('moes_serie').asstring),SeriesdeServicos ) > 0 ) and
        ( Es='S' ) then begin
// 11.02.19 - para ir no fiscal sem as retencoes
        TipoImposto:='S';
        valornf:=Q.fieldbyname('moes_vlrservicos').ascurrency;

      end else

        valornf:=Q.fieldbyname('moes_vlrtotal').ascurrency;

//           DatetoTextInvertida(Q.fieldbyname('moes_dataemissao').asdatetime,true)+
// 05.09.05 - Walmir
//           DatetoTextInvertida(Q.fieldbyname('moes_datalcto').asdatetime,true)+
// 06.09.05 - 2a. tentativa Walmir ref. as Vendas Ambulantes
      xsituacao := '00';  // documento regular
      if Q.fieldbyname('moes_status').asstring = 'X' then
         xsituacao := '02'   // cancelada
      else if Q.fieldbyname('moes_status').asstring = 'Y' then
         xsituacao := '04'   //denegada
      else if Q.fieldbyname('moes_status').asstring = 'I' then
         xsituacao := '05' ;  // numero inutilizado


      if EdSistema.text='02' then begin  // viasoft

        if trim(Q.fieldbyname('moes_chavenfe').asstring)<>'' then especie:='NF-E';
        if especie='NFE' then especie:='NF-E';
        linha:=es+'C'+strzero(empresa,3)+strzero(filial,3)+  // confirma se e´isto mesmo
           DatetoTextInvertida(Q.fieldbyname('moes_datamvto').asdatetime,true)+
           DatetoTextInvertida(Q.fieldbyname('moes_datamvto').asdatetime,true)+
           strspace(especie,4)+
           strspace(serie,3)+
           FGeral.exportanumeros(Q.fieldbyname('moes_numerodoc').asinteger,10,0)+
           FGeral.exportanumeros(Q.fieldbyname('moes_numerodoc').asinteger,10,0)+
           strspace(Q.fieldbyname('moes_vispra').asstring,1)+
           FGeral.exportanumeros(Q.fieldbyname('moes_tipo_codigo').asinteger,8,0)+
           Fgeral.Exportanumeros(Q.fieldbyname('moes_frete').ascurrency,13,2)+
           strspace(Q.fieldbyname('Moes_FreteCifFob').asstring,1)+
           Fgeral.Exportanumeros(vlrdesco,13,2)+
           Fgeral.Exportanumeros(valorzero,13,2)+  // despesas acessorias
           Fgeral.Exportanumeros(valorzero,13,2)+  // seguro
           Cancelada+
           obs+    // observacao
           space(60)+    // observacao servicos
           space(06)+    // cod. config. contas pra valores
           FGeral.exportanumeros(strtointdef(Q.fieldbyname('moes_tran_codigo').asstring,0),8,0)+
           strspace(FTransp.getPlaca(Q.fieldbyname('Moes_tran_codigo').asstring),7)+
           'S'+                // se é consumidor final
           space(08)+          // Data declaração exportação
           space(08)+          // Data do registro de exportação
           space(16)+          // Núm.conhecimento de embarqui
           space(08)+          // Data conhecim. de embarque
           '00'+               // Tipo do conhecimento SISCOMEX
           '00000'+            // Código de país de destino
           space(08)+          // Dt.Averbação dec.Exportação
           space(06)+          // Código da configuração da obs.
           Q.fieldbyname('moes_chavenfe').asstring+   // chave da NFe
//           space(02)+         // Situação da NFe
           xsituacao +
           Fgeral.Exportanumeros( Q.fieldbyname('moes_qtdevolume').asinteger,10,0)+
           Fgeral.Exportanumeros( Q.fieldbyname('moes_pesobru').asinteger,12,2)+
           Fgeral.Exportanumeros( Q.fieldbyname('moes_pesoliq').asinteger,12,2)+
           space(01)+                           // Informe o tipo de documento
           space(01)+                           // Natureza de exportação
           Fgeral.Exportanumeros( 0,12,2)+      // Abatimento Não Tributado
           space(02)+                          // Código Consumo de Gas/Energia
           space(44)+                          // chave do ct-e
           '0'+                                // Tipo do CT-e
           space(44)+                          // chave do ct-e de ref.
           space(01)+                          //  Tipo de Rec DEISS-PB
           '0'+                                // Indicador tipo de frete****
           space(08)+                          // Data de Execução do Serviço
           space(02);                          // **Cód. Consumo de Comunicação


      end else begin      // Contax

        linha:=es+sep+
           TipoImposto+sep+
           strzero(empresa,3)+sep+
           strzero(filial,3)+sep+  // confirma se e´isto mesmo
           DatetoTextInvertida(Q.fieldbyname('moes_datamvto').asdatetime,true)+sep+
           DatetoTextInvertida(Q.fieldbyname('moes_datamvto').asdatetime,true)+sep+
           strspace(especie,4)+sep+
           strspace(serie,3)+sep+
           FGeral.exportanumeros(Q.fieldbyname('moes_numerodoc').asinteger,6,0)+sep+   //8
           strspace(Q.fieldbyname('moes_vispra').asstring,1)+sep+                      //9
           FGeral.exportanumeros(Q.fieldbyname('moes_tipo_codigo').asinteger,8,0)+sep+ //10
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // imposto de importacao        //11
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // valor funrural               //12
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // diferencial aliquota         //13
           Fgeral.Exportanumeros(Q.fieldbyname('moes_frete').ascurrency,13,2)+sep+     //14
           strspace(Q.fieldbyname('Moes_FreteCifFob').asstring,1)+sep+                 //15
           Fgeral.Exportanumeros(vlrdesco,13,2)+sep+                                   //16
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // despesas acessorias          //17
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // seguro                       //18
           Cancelada+sep+                                                              //19
           obs+sep+    // observacao                                                   //20
           space(06)+sep+    // cod. config. contas pra valores                        //21
           Fgeral.Exportanumeros(valorzero,10,0)+sep+  // numero da DI                 //22
           FGeral.exportanumeros(valorzero,8,0)+sep+   // 06.10.05 - valmir                 //23
           FGeral.exportanumeros(strtointdef(Q.fieldbyname('moes_tran_codigo').asstring,0),8,0)+sep+  // 24
// 11.02.19 - Eticon - deduzindo as retençoes
//////////////////////////////////
           Fgeral.Exportanumeros( valornf,13,2)+sep+                 // 25
           Fgeral.Exportanumeros(Q.fieldbyname('moes_baseicms').ascurrency,13,2)+sep+                 // 26
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valoricms').ascurrency,13,2)+sep+                // 27
           Fgeral.Exportanumeros(Q.fieldbyname('moes_funrural').ascurrency,13,2)+sep+                 // 28
           strspace(FTransp.getPlaca(Q.fieldbyname('Moes_tran_codigo').asstring),7)+sep+              // 29
           Q.fieldbyname('moes_tipocad').asstring+sep+                                                 //30
           Q.fieldbyname('moes_estado').asstring+sep+                                                  //31
           Q.fieldbyname('moes_unid_codigo').asstring+sep+                                                 //32
           Q.fieldbyname('moes_transacao').asstring+sep+                                            //33
// 16.02.19 - Eticon - enviar retenções para Contax
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorinss').ascurrency,13,2)+sep+              //33
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorpis').ascurrency,13,2)+sep+              //34
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorcofins').ascurrency,13,2)+sep+              //35
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorcsl').ascurrency,13,2)+sep+              //36
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valorir').ascurrency,13,2)+sep+              //37
           Fgeral.Exportanumeros(Q.fieldbyname('moes_valoriss').ascurrency,13,2);              //38

//           Fgeral.Exportanumeros(Q.fieldbyname('moes_cotacapital').ascurrency,13,2)+sep+              // 30

      end;

    end;  // ref. entradas ou saidas - cabecalho

/////////////////////////////////////////////////// - cabecalho notas fiscais
// 12.04.11 - serie F somente saidas
   if ( pos( trim(Q.fieldbyname('moes_serie').asstring),SeriesdeServicos ) > 0 ) and
      ( Es='S' ) then
     Writeln(Arquivo,linha)
   else if ( pos( trim(Q.fieldbyname('moes_serie').asstring),SeriesdeServicos ) > 0 ) and
      ( Es<>'S' ) then
     linha:=linha  // nao exporta entradas de servicos...por enquanto...
   else
     Writeln(Arquivo,linha);

// 27.02.12 - conhecimentos de saida
////////////////////////////////////////
      if Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimentoSaida then begin
         Q71:=sqltoquery('select * from movesto where moes_transacao='+Stringtosql(Q.FieldByName('moes_transacao').asstring)+
                       ' and moes_status='+stringtosql('M')+
                       ' order by moes_datamvto' );
         while not Q71.eof do begin
           tipodoc:='NF';
           linha:='S'+sep+             // 0
           'C'+sep+                 //01
           strzero(empresa,3)+sep    // 02
           +strzero(filial,3)+sep+    // 03
           DatetoTextInvertida(Q71.fieldbyname('moes_datamvto').asdatetime,true)+sep+        //04
           DatetoTextInvertida(Q71.fieldbyname('moes_dataemissao').asdatetime,true)+sep+     //05
           strspace(tipodoc,4)+sep+                                                         //06
           strspace(Q71.fieldbyname('moes_serie').asstring,3)+sep+                           //07
           FGeral.exportanumeros(Q71.fieldbyname('moes_numerodoc').asinteger,6,0)+sep+       //08
           strspace(Q71.fieldbyname('moes_vispra').asstring,1)+sep+                          //09
           FGeral.exportanumeros(Q71.fieldbyname('moes_tipo_codigo').asinteger,8,0)+sep+     //10
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // imposto de importacao             //11
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // valor funrural                    //12
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // diferencial aliquota              //13
           Fgeral.Exportanumeros(Q71.fieldbyname('moes_frete').ascurrency,13,2)+sep+         //14
           strspace(Q71.fieldbyname('Moes_FreteCifFob').asstring,1)+sep+                     //15
           Fgeral.Exportanumeros(vlrdesco,13,2)+sep+                                        //16
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // despesas acessorias               //17
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // seguro                            //18
           'M'+sep+                                                                         //19
           obs+sep+    // observacao                                                        //20
           space(06)+sep+    // cod. config. contas pra valores                             //21
           Fgeral.Exportanumeros(valorzero,10,0)+sep+  // numero da DI                      //22
           FGeral.exportanumeros(valorzero,8,0)+sep+   // 06.10.05 - valmir                 //23

           FGeral.exportanumeros(strtointdef(Q71.fieldbyname('moes_tran_codigo').asstring,0),8,0)+sep+     // 24
// 13.11.07 - campos q 'faltavam'
           Fgeral.Exportanumeros(Q71.fieldbyname('moes_vlrtotal').ascurrency,13,2)+sep+                 //25
           Fgeral.Exportanumeros(0,13,2)+sep+                 //26
           Fgeral.Exportanumeros(0,13,2)+sep+                //27
           Fgeral.Exportanumeros(0,13,2)+sep+                 //28
           strspace('0',7)+sep+                 // 29
           Q71.fieldbyname('moes_tipocad').asstring+sep+                                                //30
           Q71.fieldbyname('moes_estado').asstring+sep+                                                 //31
           Q71.fieldbyname('moes_unid_codigo').asstring+sep+                                                //32
           Q71.fieldbyname('moes_transacao').asstring;                                                //33
           Writeln(Arquivo,linha);

           if Emitentes.IndexOf(Q71.fieldbyname('moes_tipo_codigo').asstring+';'+Q71.fieldbyname('moes_tipocad').asstring)<0 then begin
              Emitentes.Add(Q71.fieldbyname('moes_tipo_codigo').asstring+';'+Q71.fieldbyname('moes_tipocad').asstring);
              EmitentesCodigo.Add(Q71.fieldbyname('moes_tipo_codigo').asstring)
           end;
// gerando item so pra 'dar certo o cfop no contax....
           linha:='S'+sep+                                                                      //  0
                'I'+sep+                                                                      // 01
                 space(10)+sep+                                                               // 02
                 strspace(Q.fieldbyname('moes_natf_codigo').asstring,6)+sep+                                                        // 03
                 strspace('000',3)+sep+                                                  // 04
                 Fgeral.Exportanumeros(1,13,3)+sep+                                           // 05
                 Fgeral.Exportanumeros(Q71.fieldbyname('moes_vlrtotal').ascurrency,11,2)+sep+  // 06
                 Fgeral.Exportanumeros(vlrdesco,13,2)+sep+                                    // 07
                 Fgeral.Exportanumeros(baseicmsstitem,13,2)+sep+                              // 08
                 Fgeral.Exportanumeros(valoricmsstitem,13,2)+sep+                             // 09
                 Fgeral.Exportanumeros(baseicmsitem,13,2)+sep+                                // 10
                 Fgeral.Exportanumeros(aliicmsitem,05,2)+sep+                                 // 11
                 Fgeral.Exportanumeros(valoricmsitem,13,2)+sep+                               // 12
                 Fgeral.Exportanumeros(isentasitem,13,2)+sep+                                 // 13
                 Fgeral.Exportanumeros(outrasitem,13,2)+sep+                                  // 14
                 Fgeral.Exportanumeros(valorzero,13,2)+sep+  // extras icms ( valor ipi, por exemplo)  // 15
                 Fgeral.Exportanumeros(valorcontabilitem,13,2)+sep+           // valor contabil // 16
                 space(06)+sep+    // codigo config. contas para valores                        // 17
                 Q71.fieldbyname('moes_tipomov').AsString+sep+                                  // 18         // 18
                 Q71.fieldbyname('moes_unid_codigo').AsString+sep+                              // 19         // 19
                 Q71.fieldbyname('moes_tipocad').AsString+sep+                                  // 20         // 20
                 Q71.fieldbyname('moes_tipo_codigo').AsString+sep+                              // 21         // 21
                 formatdatetime('ddmmyyyy',Q71.fieldbyname('moes_datalcto').AsDatetime)+sep+    // 22         // 22
                 formatdatetime('ddmmyyyy',Q71.fieldbyname('moes_datamvto').AsDatetime)+sep+    // 23         // 23
                 Q71.fieldbyname('moes_numerodoc').AsString+sep+                                 // 24        // 24
                 Fgeral.Exportanumeros(Q71.fieldbyname('moes_vlrtotal').ascurrency,11,2)+sep+            // 25
                 Fgeral.Exportanumeros(0,11,2)+sep+                                                     // 26
                 Q71.fieldbyname('moes_serie').asstring+sep+                                                // 27
                 Q71.fieldbyname('moes_transacao').asstring;                                            //28
           Writeln(Arquivo,linha);

           Q71.Next;
         end;
         FGeral.FechaQuery(Q71);
      end;  //notas do conhecimento de saida

// 11.02.08
///////////////////////////
{
    if (EdSistema.Text='01') then begin
      QTrib.first;
      linha:=es+sep+     //0
           'C'+sep+           //1
           strzero(empresa,3)+sep+  //2
           strzero(filial,3)+sep+  // confirma se e´isto mesmo   //3
           DatetoTextInvertida(Q.fieldbyname('moes_datamvto').asdatetime,true)+sep+  //4
           DatetoTextInvertida(Q.fieldbyname('moes_dataemissao').asdatetime,true)+sep+  //5
           strspace(especie,4)+sep+  //6
           strspace(serie,2)+sep+    //7
           FGeral.exportanumeros(Q.fieldbyname('moes_numerodoc').asinteger,6,0)+sep+   //8
           strspace(Q.fieldbyname('moes_vispra').asstring,1)+sep+                      //9
           FGeral.exportanumeros(Q.fieldbyname('moes_tipo_codigo').asinteger,8,0)+sep+ //10
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // imposto de importacao        //11
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // valor funrural               //12
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // diferencial aliquota         //13
           Fgeral.Exportanumeros(Q.fieldbyname('moes_frete').ascurrency,13,2)+sep+     //14
           strspace(Q.fieldbyname('Moes_FreteCifFob').asstring,1)+sep+                 //15
           Fgeral.Exportanumeros(vlrdesco,13,2)+sep+                                   //16
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // despesas acessorias          //17
           Fgeral.Exportanumeros(valorzero,13,2)+sep+  // seguro                       //18
           Cancelada+sep+                                                              //19
           obs+sep+    // observacao                                                   //20
           space(06)+sep+    // cod. config. contas pra valores                        //21
           Fgeral.Exportanumeros(valorzero,10,0)+sep+  // numero da DI                 //22
           FGeral.exportanumeros(valorzero,8,0)+sep+   // 06.10.05 - valmir                 //23

           FGeral.exportanumeros(strtointdef(Q.fieldbyname('moes_tran_codigo').asstring,0),8,0)+sep+  //24
           Fgeral.Exportanumeros(Q.fieldbyname('moes_vlrtotal').ascurrency,13,2)+sep+                 //25
           Fgeral.Exportanumeros(baseicms,13,2)+sep+                 //26
           Fgeral.Exportanumeros(valoricms,13,2)+sep+                //27
           Fgeral.Exportanumeros(Q.fieldbyname('moes_funrural').ascurrency,13,2)+sep+                 //28
           strspace(FTransp.getPlaca(Q.fieldbyname('Moes_tran_codigo').asstring),7)+sep+              //29
           Q.fieldbyname('moes_tipocad').asstring+sep+                                                //30
           Q.fieldbyname('moes_estado').asstring+sep+                                                 //31
           Q.fieldbyname('moes_unid_codigo').asstring;                                                //32

      Writeln(Arquivo,linha);
    end;
//////////////////////
}

    reducaobase:=GetReducaoBase(Q.fieldbyname('move_transacao').asstring);
// 03.07.07
    if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodDevolucaoCompraProdutor)>0 then
      reducaobase:=0;

// 01.04.19 - Vida Nova - Viasoft
    basepiscofins:=0;

//    while (not Q.eof) and (Q.fieldbyname('moes_numerodoc').asinteger=numero) and (Q.fieldbyname('moes_tipomov').asstring=tipomov) do begin
//    while (not Q.eof) and (Q.fieldbyname('moes_transacao').asstring=transacao)  do begin
// 26.08.8
    while (not Q.eof) and (Q.fieldbyname('moes_numerodoc').asinteger=numero) and (Q.fieldbyname('moes_tipomov').asstring=tipomov) and
           (Q.fieldbyname('moes_transacao').asstring=transacao)  do begin

          totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,2);
 // 09.03.2023 - exportação deverede entrada mais de um cfop
          if Q.fieldbyname('move_venda').ascurrency = 0 then
             totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_unitarionota').ascurrency,2);

          primeiroitem:=false;
          if Q.fieldbyname('moes_perdesco').ascurrency>0 then
             vlrdesco:=totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100)
          else begin
            vlrdesco:=0;
// 21.03.19 - calcula em % para poder ratear entre os produtos...
            if ( Q.FieldByName('moes_totprod').AsCurrency > Q.FieldByName('moes_vlrtotal').AsCurrency )
               and ( es = 'E' )
              then begin

                 vlrdesco :=Q.FieldByName('moes_totprod').AsCurrency-Q.FieldByName('moes_vlrtotal').AsCurrency
                           - Q.FieldByName('moes_valoripi').AsCurrency;
                 vlrdesco := (vlrdesco/Q.FieldByName('moes_totprod').AsCurrency)  * 100;
              end;
          end;

          if Q.fieldbyname('moes_peracres').ascurrency>0 then
            vlracres:=totalitem*(Q.fieldbyname('moes_peracres').ascurrency/100)
          else
            vlracres:=0;
          valorcontabil:=Q.fieldbyname('moes_vlrtotal').ascurrency;
// 01.04.18
          basepiscofins:=totalitem - vlrdesco;

//          if Q.fieldbyname('moes_status').asstring='X' then
//            cfop:=''
//          else
// 12.04.18
          cfop54:=Q.fieldbyname('moes_natf_codigo').asstring;
// 10.10.17
          cfop:=Q.fieldbyname('move_natf_codigo').asstring;
// 12.04.11
          aliiss:=0;
// 02.08.06
///////////////////
//          if ( trim(cfop)<>'' ) then begin
// 12.04.18
          if ( trim(cfop)='' ) then begin

            QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
                             ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring)+
//                             ' and movb_natf_codigo<>'+stringtosql(cfop) );
//                             ' and movb_natf_codigo<>'+stringtosql(cfop50) );
                             ' and movb_cst='+stringtosql(Q.fieldbyname('move_cst').asstring) );
            while not QMovbase.eof do begin

              if ( QMovbase.fieldbyname('movb_cst').asstring=Q.fieldbyname('move_cst').asstring )
                 and
                 ( trim(QMovbase.fieldbyname('movb_natf_codigo').asstring)<>'' )
//                 and
//                 ( QMovbase.fieldbyname('movb_natf_codigo').asstring=Q.fieldbyname('move_natf_codigo').asstring )
                 then
                   cfop:=QMovbase.fieldbyname('movb_natf_codigo').asstring;

              if QMovbase.fieldbyname('movb_tpimposto').asstring='S' then
                 aliiss:=QMovbase.fieldbyname('movb_aliquota').ascurrency;
              QMovbase.Next;

            end;
            FGeral.fechaquery(QMovbase);

          end;
// 12.04.18
          if trim(cfop)='' then cfop:=cfop54;

///////////////////
//          codigotrib:=spacestr(copy(Q.fieldbyname('move_cst').asstring,2,2),2);  // ver se e´direto o CST ou codigo de cadastro interno do viasoft
          codigotrib:=Q.fieldbyname('move_cst').asstring;  // 23.02.14
          if trim(codigotrib)='' then
            codigotrib:='000';
          if Es='E' then
            tamdesco:=13
          else
            tamdesco:=11;
          baseicmsitem:=totalitem-vlrdesco;
// 06.01.06 ////////////////////////////////////
//          if valoricmsitem=0 then
//            baseicmsitem:=0;
// retirado em 15.04.09 - variavel valoricmsitem nem foi calculada aqui ainda...

///////////////////////////////////
// 05.09.05
          if ( (codcst=codcstoutras) and (Es='S') ) or (Q.fieldbyname('move_tipomov').asstring=Global.CodVendaAmbulante)  or
             ( (codcst=codcsttributado) and (EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring='S') )
// 07.11.05
//             ( (codcst=codcsttributado) and (Es='S') and (EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring='S') )
            then
            baseicmsitem:=0;

          if ( pos(Q.fieldbyname('move_tipomov').asstring,Global.TiposNaoCalcIcms)>0 ) or
            (pos( FUnidades.GetSimples(Q.FieldByName('move_unid_codigo').Asstring),'S;2' )>0 )
            then
            baseicmsitem:=0;
/////////////////////

          baseicmsstitem:=(totalitem-vlrdesco)*rateiobaseicmsst;
          valoricmsstitem:=(totalitem-vlrdesco)*rateioicmsst;
//09.09.05
/////////////////////////
          if valorcontabil>0 then begin
            if baseicmsitem>0 then
              rateiovalorcontabil:=FGeral.arredonda( (baseicmsitem+valoricmsstitem)/valorcontabil,2)
            else
              rateiovalorcontabil:=FGeral.arredonda((totalitem-vlrdesco+valoricmsstitem)/valorcontabil,2)
          end else
            rateiovalorcontabil:=0;

/////////////////////////
// 05.09.05
//          valoricmsitem:=(totalitem-vlrdesco)*(Q.fieldbyname('move_aliicms').ascurrency/100);
// 04.03.11
          valoricmsitem:=(baseicmsitem)*(Q.fieldbyname('move_aliicms').ascurrency/100);
          if Q.fieldbyname('move_tipomov').asstring=Global.codvendaambulante then
            valoricmsitem:=0;
///////////////////////
// 26.05.06 - Valmir
          if pos(Q.fieldbyname('move_tipomov').asstring,Global.TiposNaoCalcIcms)>0 then
            valoricmsitem:=0;
///////////////////////

//          isentasitem:=(totalitem-vlrdesco)*rateioisentas;
//          outrasitem:=(totalitem-vlrdesco)*rateiooutras;
// 04.03.11
          isentasitem:=(baseicmsitem)*rateioisentas;
          outrasitem:=(baseicmsitem)*rateiooutras;

          if baseicmsitem>0 then begin
// 11.03.08
           if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
            then     // entradas td em outras e valor contabil
              valorcontabilitem:=(baseicmsitem)  // senao 'dobra o valor contabil
            else
              valorcontabilitem:=(baseicmsitem+isentasitem+outrasitem);
          end else if (baseicmsitem=0) and (outrasitem=0) then
// devido as notas sem base de icms...09.09.05
            valorcontabilitem:=(totalitem-vlrdesco+isentasitem+outrasitem)
          else
            valorcontabilitem:=(isentasitem+outrasitem);
// 14.10.15 - SM -fama digital
          if ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 ) then
            valorcontabilitem:=valorcontabilitem+Q.fieldbyname('move_vendamin').ascurrency;
///////////////////////////////////////////////////
///
{  // 09.03.23 - retirado pra ver se vai certo pro contax quando tem mais de um cfop
// 14.03.16 - rateio de ST no item
          if Q.fieldbyname('moes_totprod').ascurrency>0 then
            valorcontabilitem:=valorcontabilitem+( (valoricmsst/Q.fieldbyname('moes_totprod').ascurrency)*valorcontabilitem ) +
                              (totalitem)*(Q.fieldbyname('move_aliipi').ascurrency/100)
          else
            valorcontabilitem:=0;
}

//          if ( not Global.Topicos[1304] ) then
//             baseicmsitem:=valorcontabilitem;
// 13.03.19 - retirado - Clessi

          /////////////////////////////////////////////////////////////////
          aliicmsitem:=Q.fieldbyname('move_aliicms').ascurrency;
// 11.03.08
          if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 ) then
            aliicmsitem:=0;

//          if pos( Q.fieldbyname('move_tipomov').asstring,Global.CodVendaConsigMercantil)>0 then begin
//             valoricmsitem:=0;
//             baseicmsitem:=0;
//             baseicmsstitem:=0;
//             valoricmsstitem:=0;
//             aliicmsitem:=0;
//          end;
// 15.04.09 - retirado
// 26.05.06 - Valmir
//////////////////////////////
          if pos(Q.fieldbyname('move_tipomov').asstring,Global.TiposNaoCalcIcms)>0 then
             aliicmsitem:=0;
///////////////////////////
// 23.11.05 - colocado tbem as transferencias
          if pos( Q.fieldbyname('move_tipomov').asstring,Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.codtransfsai+';'+global.codtransfent )>0 then begin
              if aliicmsitem=0 then begin
                 valoricmsitem:=0;
                 baseicmsitem:=0;
                 baseicmsstitem:=0;
                 valoricmsstitem:=0;
              end else if baseicmsitem=valorcontabilitem then begin   // 23.11.05
                 outrasitem:=0;
                 isentasitem:=0
              end;
          end;
//          if Q.fieldbyname('move_tipomov').asstring=Global.CodVendaAmbulante then begin
//             aliicmsitem:=0;
//          end;
// 15.04.09
// 23.11.05 ///////////////////
          if (valoricmsitem>0) and (baseicmsitem=valorcontabilitem) then begin
            outrasitem:=0;
            isentasitem:=0;
          end;
//          if (valoricmsitem=0) and (baseicmsitem>0) and(outrasitem=0) then begin
// 15.03.16
          if (valoricmsitem=0) and (baseicmsitem>0) and(outrasitem=0) and (Es='S') then begin
            outrasitem:=baseicmsitem;
            isentasitem:=0;
            baseicmsitem:=0;
          end else begin
            if reducaobase>0 then begin
              outrasitem:=baseicmsitem - (baseicmsitem*(reducaobase/100));
              baseicmsitem:=baseicmsitem*(reducaobase/100);  // 25.06.07
              isentasitem:=0;
            end;
          end;
/////////////////////////////////
// 28.08.06
//          baseipiitem:=baseicmsitem;
// 15.04.09
          if baseicmsitem>0 then
            baseipiitem:=baseicmsitem
          else
            baseipiitem:=totalitem-vlrdesco;

          valoripiitem:=(baseipiitem)*(Q.fieldbyname('move_aliipi').ascurrency/100);
// 15.04.09
          aliipiitem:=Q.fieldbyname('move_aliipi').ascurrency;
          outrasipiitem:=0;
          if valoripiitem=0 then begin
            outrasipiitem:=baseipiitem;
            baseipiitem:=0;
          end;
///////////////////////////////
// 03.07.07
//          tipocad:=Q.fieldbyname('move_tipocad').AsString;
// 28.08.08
          tipocad:=Q.fieldbyname('moes_tipocad').AsString;
//          if Q.fieldbyname('move_tipomov').asstring=global.CodCompraProdutor then begin
// 11.03.10
          if pos(Q.fieldbyname('move_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodDevolucaoCompraProdutor)>0 then begin
            tipocad:='C';
            aliicmsitem:=0;
            baseicmsitem:=0;
            outrasitem:=valorcontabilitem;
// 12.04.11
          end else if pos(Q.fieldbyname('move_tipomov').asstring,Global.CodPrestacaoServicos+';')>0 then begin
            tipocad:='C';
            aliicmsitem:=aliiss;
            baseicmsitem:=totalitem-vlrdesco;
            outrasitem:=0;
            valoricmsitem:=(baseicmsitem)*(aliicmsitem/100);
          end;

          if Q.fieldbyname('move_tipomov').asstring=global.CodDevolucaoIgualVenda then
            tipocad:='C';

          if baseicmsitem>valorcontabilitem then   // notas de combustivel com produtos>totalnota
            baseicmsitem:=valorcontabilitem;
// 20.07.07
/////////////// - 10.07.09
          {
          if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
            then begin    // entradas td em outras e valor contabil
            outrasitem:=valorcontabilitem;
            baseicmsitem:=0;
            isentasitem:=0;
            aliicmsitem:=0;
            valoricmsitem:=0;
            baseicmsstitem:=0;
            valoricmsstitem:=0;
            reducaobase:=0;
          end;
          }
//////////////////
          xcst:=Q.fieldbyname('move_cst').asstring;  // 11.03.08
          if xcst='099' then
            xcst:='090';  // pois 099 é só pro sac identifar o servico na nf de entrada

// 01.04.19 - Vida Nova -> Viasoft
          if ( AnsiPos( xcst, '060' ) > 0 ) and ( Es = 'E' ) then begin

            aliicmsitem:=0;
            baseicmsitem:=0;
            outrasitem:=valorcontabilitem;

          end;

// 12.04.11
          TipoDetalhe:='I';

          if Es = 'E' then begin

              xcstpis := ( FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) ) );


          end else  begin

              xcstpis := ( FEstoque.GetsituacaotributariaPIS(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring,'S','N') );
              if trim(xcstpis)=''  then texto.lines.add(' Produto '+Q.fieldbyname('move_esto_codigo').asstring+' sem CST PIS/COFINS informado');

//             FEstoque.GetPISpeloCSTICMS(Q.fieldbyname('move_cst').asstring,'E'),Q.fieldbyname('moes_natf_codigo').asstring,Q.fieldbyname('move_cst').asstring );

          end;

          if ( pos( trim(Q.fieldbyname('moes_serie').asstring),SeriesdeServicos ) > 0 ) and
           ( Es='S' ) then
            TipoDetalhe:='J';
// 23.02.14 - empresas do simples
//          if pos( FUnidades.GetSimples(Q.fieldbyname('Move_unid_codigo').asstring),'S/2' ) > 0 then begin
// 15.03.16 - empresas do simples e saidas
          if ( pos( FUnidades.GetSimples(Q.fieldbyname('Move_unid_codigo').asstring),'S/2' ) > 0 )
             and
             ( Es='S' )
             then begin
             outrasitem:=baseicmsitem;
             baseicmsitem:=0;
             baseicmsstitem:=0;
             valoricmsstitem:=0;
             aliicmsitem:=0;
             isentasitem:=0;
          end;

          if pos(Es,'E/S')>0 then begin

            if EdSistema.text='02' then begin  // viasoft

              xalipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                       Q.fieldbyname('move_unid_codigo').asstring,Global.UFUnidade)  );
              xalicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                       Q.fieldbyname('move_unid_codigo').asstring,Global.UFUnidade)  );
// 01.04.19
              if xalipis=0 then
                 basepiscofins:=0;

              linha:=es+'I'+strspace(Q.fieldbyname('move_esto_codigo').asstring,60)+
                 strspace(cfop,6)+
                 strspace('0'+codigotrib,4);
                 if Es = 'E' then  begin

                   linha := linha +
                   Fgeral.Exportanumeros(Q.fieldbyname('move_qtde').ascurrency,15,5)+
                   Fgeral.Exportanumeros(0,13,3)+
                   Fgeral.Exportanumeros(Q.fieldbyname('move_venda').ascurrency,20,9)+
                   Fgeral.Exportanumeros(vlrdesco,TAMDESCO,2);

                 end else begin  // saidas

                   linha := linha +
                   Fgeral.Exportanumeros(0,13,3)+     // qtde gasolina A
                   Fgeral.Exportanumeros(Q.fieldbyname('move_qtde').ascurrency,15,5)+
                   Fgeral.Exportanumeros(Q.fieldbyname('move_venda').ascurrency,20,9)+
                   Fgeral.Exportanumeros(vlrdesco,TAMDESCO,2);

                 end;

                 linha := linha +Fgeral.Exportanumeros(baseicmsstitem,13,2)+  // base icms s.t.  ver com 'ratear' a base da nota pelos produtos
                 Fgeral.Exportanumeros(0,05,2)+              // aliquota icms s.t.  ou se terá q gravar em cada item
                 Fgeral.Exportanumeros(valoricmsstitem,13,2)+  // valor icms s.t.  ou se terá q gravar em cada item
                 Fgeral.Exportanumeros(baseicmsitem,13,2)+   // base calculo
                 Fgeral.Exportanumeros(aliicmsitem,05,2)+
                 Fgeral.Exportanumeros(valoricmsitem,13,2)+
                 Fgeral.Exportanumeros(isentasitem,13,2)+
                 Fgeral.Exportanumeros(outrasitem,13,2)+
                 Fgeral.Exportanumeros(valorzero,13,2)+  // extras icms ( valor ipi, por exemplo)
//                 Fgeral.Exportanumeros(totalitem-vlrdesco+valoricmsstitem,13,2)+    // valor contabil
// 08.09.05
//                 Fgeral.Exportanumeros(baseicmsitem+valoricmsstitem,13,2)+    // valor contabil
                 Fgeral.Exportanumeros(valorcontabilitem,13,2)+    // valor contabil
//                 Fgeral.Exportanumeros(valorcontabil,13,2)+
                 space(06)+    // codigo config. contas para valores
                 '000'+        // Código GIA-RS
                 '00'+xcstPIS+    // pra ficar com C , 4 cfe layout
/////                 FEstoque.GetPISpeloCSTICMS(Q.fieldbyname('move_cst').asstring,es,EdUnid_codigo.resultfind.fieldbyname('unid_simples').asstring)+        // Código da Tributação PIS
                 Fgeral.Exportanumeros(basepiscofins,12,2)+    // Base de Cálculo PIS
                 Fgeral.Exportanumeros(xalipis,07,4)+    // aliquota de Cálculo PIS
                 Fgeral.Exportanumeros(0,12,3)+    // Quantidade Base Pis
                 Fgeral.Exportanumeros(0,12,4);    // Alíquota Pis Reais

                 if es='E' then

                   linha:=linha+Fgeral.Exportanumeros((totalitem-vlrdesco)*(xalipis/100),11,2)+    // Valor do Pis
                   '00'+xcstpis+                 // Código da Tributação Cofins C ,4
                   Fgeral.Exportanumeros(basepiscofins,12,2)+    // Base de Cálculo Cofins
                   Fgeral.Exportanumeros(xalicofins,07,4)+    // aliquota de Cálculo Cofins
                   Fgeral.Exportanumeros(0,12,4)+    // Alíquota Cofins em reais
                   Fgeral.Exportanumeros((basepiscofins)*(xalicofins/100),11,2)    // Valor do Cofins

                 else

                   linha:=linha+Fgeral.Exportanumeros((basepiscofins)*(xalipis/100),12,2)+    // Valor do Pis
                   '00'+xcstpis+                 // Código da Tributação Cofins C ,4
                   Fgeral.Exportanumeros(basepiscofins,12,2)+    // Base de Cálculo Cofins
                   Fgeral.Exportanumeros(xalicofins,07,4)+    // aliquota de Cálculo Cofins
                   Fgeral.Exportanumeros(0,12,3)+    // Quantidade Base Cofins
                   Fgeral.Exportanumeros(0,12,4)+    // Alíquota Cofins em reais
                   Fgeral.Exportanumeros((basepiscofins)*(xalicofins/100),12,2);    // Valor do Cofins


                 if Es='E' then

                   linha:=linha +

                     ' '+                               // Indicador do tipo de cobrança
                     Fgeral.Exportanumeros(0,08,0)+    // Código do terceiro da Cobrança
                     Fgeral.Exportanumeros(0,12,3)+    // Quantidade Base Cofins
                     Fgeral.Exportanumeros(0,12,2)+    // Redução da Base ICMS
                     '0'+                              // Houve Movimentação Física?
                     '00000'+                          // Conf. Tipo de Créd. PIS/COFINS
                     space(03)+                        // Unidade de Conversão do Item
                     Fgeral.Exportanumeros(0,07,4)+    // Diferencial de Alíquota (%)
                     Fgeral.Exportanumeros(0,12,2)+    // Valor de Diferencial de Alíq.
                     space(02)+                        // DIFAL - UF de Origem
                     space(02)+                        // DIFAL - UF de Destino
                     Fgeral.Exportanumeros(0,12,2)+    // DIFAL - Valor FCP da UF Dest
                     Fgeral.Exportanumeros(0,12,2)+    // DIFAL - Valor ICMS UF Dest
                     Fgeral.Exportanumeros(0,12,2)+    // DIFAL - Valor ICMS UF Rem
                     space(01)+                        // ICMS Compensável
                     space(01)+                        // Incidência de Funrural?
                     space(06)+                        // Observação Fiscal
                     space(200)+                       // Descrição da Observação Fiscal
                     Fgeral.Exportanumeros(0,12,2)+    // Valor Exclusão da Base PIS
                     Fgeral.Exportanumeros(0,12,2)+    // Valor Exclusão da Base COFINS
                     Fgeral.Exportanumeros(0,12,2)+    // Valor do Abatimento
                     Fgeral.Exportanumeros(0,12,2)+    // Valor FCP Operação
                     Fgeral.Exportanumeros(0,12,2)+    // Valor FCP ST
                     Fgeral.Exportanumeros(0,12,2)+    // Valor FCP Retido
                     Fgeral.Exportanumeros(0,12,2)+    // Base de cálculo ST Retida
                     Fgeral.Exportanumeros(0,12,2)+    // Alíquota do ST Retido
                     Fgeral.Exportanumeros(0,12,2)+    // Valor do ICMS ST Retido
                     Fgeral.Exportanumeros(0,12,2)+    // Base de cálculo FCP-ST Retida
                     Fgeral.Exportanumeros(0,12,2)+    // Alíquota do FCP-ST Retido
                     Fgeral.Exportanumeros(0,12,2)    // Valor do FCP- ST Retido


                 else begin   // saidas

                   linha:=linha +

                     Fgeral.Exportanumeros(0,12,2)+    // Redução da Base ICMS
                     '    '+                           // Classif. item Energia/Comunic.
                     ' '+                              // Indicador Tipo de Receita NF
                     Fgeral.Exportanumeros(0,08,0)+    // Código do terceiro da receita
                     '0'+                              // Houve Movimentação Física?
                     '0';                              // Tipo receita Serv. PIS/COFINS

                   if (xcstPIS  = '06' ) or ( xcstPIS = '09' ) then

                              linha := linha +
                              '110'+                        // Nat.Op. Isenção PIS
                              '110'+                        // Nat.Op. Isenção Cofins
                              space(03)                        // Unidade de Conversão do Item

                   else

                              linha := linha +
                              space(03)+                        // Nat.Op. Isenção PIS
                              space(03)+                        // Nat.Op. Isenção COFINS
                              space(03);                        // Unidade de Conversão do Item

                     linha := linha +
                     space(02)+                        // UF de consumo
                     space(02)+                        // DIFAL - UF de Origem
                     space(02)+                        // DIFAL - UF de Destino
                     Fgeral.Exportanumeros(0,12,2)+    // DIFAL - Valor FCP da UF Dest
                     Fgeral.Exportanumeros(0,12,2)+    // DIFAL - Valor ICMS UF Dest
                     Fgeral.Exportanumeros(0,12,2)+    // DIFAL - Valor ICMS UF Rem
                     space(06)+                        // Observação Fiscal
                     space(200)+                       // Descrição da Observação Fiscal
                     Fgeral.Exportanumeros(0,12,2)+    // Valor Exclusão da Base PIS
                     Fgeral.Exportanumeros(0,12,2)+    // Valor Exclusão da Base COFINS
                     Fgeral.Exportanumeros(0,12,2)+    // Valor do Abatimento
                     Fgeral.Exportanumeros(0,12,2)+    // Valor FCP Operação
                     Fgeral.Exportanumeros(0,12,2)+    // Valor FCP ST
                     Fgeral.Exportanumeros(0,12,2)+    // Valor FCP Retido
                     Fgeral.Exportanumeros(0,12,2)+    // Percent. red base ICMS Efetivo
                     Fgeral.Exportanumeros(0,12,2)+    // Base de cálculo ICMS Efetivo
                     Fgeral.Exportanumeros(0,12,2)+    // Percent. de alíq. ICMS Efetivo
                     Fgeral.Exportanumeros(0,12,2);    // Valor do ICMS Efetivo



                 end;

            end else begin   // Contax

              linha:=es+sep+                                                     // 0
                 TipoDetalhe+sep+                                                        // 1
                 strspace(Q.fieldbyname('move_esto_codigo').asstring,10)+sep+    // 2
                 strspace(cfop,6)+sep+                                           // 3
                 xcst+sep+                                                       // 4
//                 Q.fieldbyname('move_cst').asstring+sep+                         // 4
                 Fgeral.Exportanumeros(Q.fieldbyname('move_qtde').ascurrency,13,3)+sep+  // 5
                 Fgeral.Exportanumeros(Q.fieldbyname('move_venda').ascurrency,11,2)+sep+ // 6
                 Fgeral.Exportanumeros(vlrdesco,TAMDESCO,2)+sep+                         // 7
                 Fgeral.Exportanumeros(baseicmsstitem,13,2)+sep+  // base icms s.t.      // 8 ver com 'ratear' a base da nota pelos produtos
                 Fgeral.Exportanumeros(valoricmsstitem,13,2)+sep+  // valor icms s.t.    // 9 ou se terá q gravar em cada item
                 Fgeral.Exportanumeros(baseicmsitem,13,2)+sep+   // base calculo         // 10
                 Fgeral.Exportanumeros(aliicmsitem,05,2)+sep+                            // 11
                 Fgeral.Exportanumeros(valoricmsitem,13,2)+sep+                          // 12
                 Fgeral.Exportanumeros(isentasitem,13,2)+sep+                            // 13
                 Fgeral.Exportanumeros(outrasitem,13,2)+sep+                             // 14
                 Fgeral.Exportanumeros(valorzero,13,2)+sep+  // extras icms ( valor ipi, por exemplo)  // 15
//                 Fgeral.Exportanumeros(totalitem-vlrdesco+valoricmsstitem,13,2)+    // valor contabil
// 08.09.05
//                 Fgeral.Exportanumeros(baseicmsitem+valoricmsstitem,13,2)+    // valor contabil
                 Fgeral.Exportanumeros(valorcontabilitem,13,2)+sep+    // valor contabil               // 16
//                 Fgeral.Exportanumeros(valorcontabil,13,2)+
                 space(06)+sep+    // codigo config. contas para valores                               // 17
                 Q.fieldbyname('move_tipomov').AsString+sep+                                           // 18
                 Q.fieldbyname('move_unid_codigo').AsString+sep+                                       // 19
                 tipocad+sep+                                                                          // 20
                 Q.fieldbyname('move_tipo_codigo').AsString+sep+                                       // 21
                 formatdatetime('ddmmyyyy',Q.fieldbyname('move_datalcto').AsDatetime)+sep+             // 22
                 formatdatetime('ddmmyyyy',Q.fieldbyname('move_datamvto').AsDatetime)+sep+             // 23
                 Q.fieldbyname('move_numerodoc').AsString+sep+                                         // 24
                 Fgeral.Exportanumeros(Q.fieldbyname('move_vendabru').ascurrency,11,2)+sep+            // 25
//                 Fgeral.Exportanumeros(reducaobase,11,2)+sep+                                          // 26
// 10.07.09 - atualizado entao pega do movimento
                 Fgeral.Exportanumeros(Q.fieldbyname('move_redubase').ascurrency,11,2)+sep+             // 26
// 26.08.08 - para pode dif. notas 'desdobradas' na entrada
                 Q.fieldbyname('moes_serie').asstring;                                               // 27

// ate atualizar e poder pegar do movimento ?...
//                 Fgeral.Exportanumeros(Q.fieldbyname('movb_redubase').ascurrency,11,2);                // 26

            end;
///////////////// - 28.08.06 - Leila confirmou q vao todas as notas pro livro de ipi
//                  so ver a partir de quando..por enquanto fazer somente pra exportacao
            linhaipi:='';
//            if Q.fieldbyname('moes_valoripi').ascurrency>0 then begin
//            if pos( Q.fieldbyname('moes_unid_codigo').asstring,Global.unidadeexportacao) >0 then begin
// 14.04.09
            if (Global.Topicos[1005]) and ( EdSistema.text='02' ) then begin  // viasoft

                 linhaipi:=es+'P'+strspace(Q.fieldbyname('move_esto_codigo').asstring,10)+
                 strspace(cfop,6)+
                 strspace(codigotrib,3)+
                 Fgeral.Exportanumeros(Q.fieldbyname('move_qtde').ascurrency,13,3)+
                 Fgeral.Exportanumeros(Q.fieldbyname('move_venda').ascurrency,11,2)+
                 Fgeral.Exportanumeros(vlrdesco,TAMDESCO,2)+
                 Fgeral.Exportanumeros(0,13,2)+  // base icms s.t.  ver com 'ratear' a base da nota pelos produtos
                 Fgeral.Exportanumeros(0,13,2)+  // valor icms s.t.  ou se terá q gravar em cada item
                 Fgeral.Exportanumeros(baseipiitem,13,2)+   // base calculo
                 Fgeral.Exportanumeros(aliipiitem,05,2)+
                 Fgeral.Exportanumeros(valoripiitem,13,2)+
                 Fgeral.Exportanumeros(0,13,2)+
                 Fgeral.Exportanumeros(outrasipiitem,13,2)+
                 Fgeral.Exportanumeros(valorzero,13,2)+  // extras icms ( valor ipi, por exemplo)
//                 Fgeral.Exportanumeros(totalitem-vlrdesco+valoricmsstitem,13,2)+    // valor contabil
// 08.09.05
//                 Fgeral.Exportanumeros(baseicmsitem+valoricmsstitem,13,2)+    // valor contabil
                 Fgeral.Exportanumeros(valorcontabil,13,2)+
                 space(06);    // codigo config. contas para valores

            end else if (Global.Topicos[1005]) and ( EdSistema.text='01' ) then begin  // contax

                 linhaipi:=es+                                                             //  0
                 sep+'P'+                                                                  //  1
                 sep+strspace(Q.fieldbyname('move_esto_codigo').asstring,10)+              //  2
                 sep+strspace(cfop,6)+                                                     //  3
//                 sep+strspace(codigotrib,3)+
                 sep+xcst+                                                                 //  4
                 sep+Fgeral.Exportanumeros(Q.fieldbyname('move_qtde').ascurrency,13,3)+    //  5
                 sep+Fgeral.Exportanumeros(Q.fieldbyname('move_venda').ascurrency,11,2)+   //  6
                 sep+Fgeral.Exportanumeros(vlrdesco,TAMDESCO,2)+                           //  7
                 sep+Fgeral.Exportanumeros(0,13,2)+                                        //  8
                 sep+Fgeral.Exportanumeros(0,13,2)+                                        //  9
                 sep+Fgeral.Exportanumeros(baseipiitem,13,2)+                              // 10
                 sep+Fgeral.Exportanumeros(aliipiitem,05,2)+                               // 11
                 sep+Fgeral.Exportanumeros(valoripiitem,13,2)+                             // 12
                 sep+Fgeral.Exportanumeros(0,13,2)+                                        // 13
                 sep+Fgeral.Exportanumeros(outrasipiitem,13,2)+                            // 14
                 sep+Fgeral.Exportanumeros(valorzero,13,2)+  // extras icms ( valor ipi, por exemplo)  // 15
                 sep+Fgeral.Exportanumeros(valorcontabil,13,2)+                            // 16
                 sep+space(06)+    // codigo config. contas para valores                   // 17
                 sep+Q.fieldbyname('move_tipomov').AsString+                                           // 18
                 sep+Q.fieldbyname('move_unid_codigo').AsString+                                       // 19
                 sep+tipocad+                                                                          // 20
                 sep+Q.fieldbyname('move_tipo_codigo').AsString+                                       // 21
                 sep+formatdatetime('ddmmyyyy',Q.fieldbyname('move_datalcto').AsDatetime)+             // 22
                 sep+formatdatetime('ddmmyyyy',Q.fieldbyname('move_datamvto').AsDatetime)+             // 23
                 sep+Q.fieldbyname('move_numerodoc').AsString+                                         // 24
                 sep+Fgeral.Exportanumeros(Q.fieldbyname('move_vendabru').ascurrency,11,2)+            // 25
                 sep+Fgeral.Exportanumeros(reducaobase,11,2)+                                          // 26
                 sep+Q.fieldbyname('moes_serie').asstring;                                                 // 27
            end;

//////////////////
          end;

    {   // checar se e especifico para transportadoras
         else begin   // registro do conhecimento de frete
          if Q.fieldbyname('Moes_FreteCifFob').asstring='1'  then
            tomador:='R'
          else
            tomador:='D';
          uf:=GetUF(Q.fieldbyname('Moes_tipo_codigo').asstring);
          cep:=GetCEP(Q.fieldbyname('Moes_tipo_codigo').asinteger);
          cnpjcpf:=GetCnpj(Q.fieldbyname('Moes_tipo_codigo').asinteger);
          insest:=GetInsEst(Q.fieldbyname('Moes_tipo_codigo').asinteger);
          linha:='D'+DatetoTextInvertida(Q.fieldbyname('moes_datamvto').asdatetime,true)+
               Q.fieldbyname('moes_especie').asstring+
               copy(Q.fieldbyname('moes_serie').asstring,1,3)+
               tomador+spacestr(Q.fieldbyname('moes_numerodoc').asstring,8)+
               spacestr(Q.fieldbyname('Moes_nroconhec').asstring,8)+
               strspace(Ups(FGeral.GetNomeTipoCad( Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring ),30)+
               strspace(insest,18)+uf+

               space(24)+copy(Q.fieldbyname('moes_natf_codigo').asstring,3,2)+   // ver este tal do "sub_cfo"
               copy(Q.fieldbyname('move_cst').asstring,2,2)+
               cfop+
               Fgeral.Exportanumeros(totalitem,14,2)+Fgeral.Exportanumeros(totalitem-vlracres,14,2)+
               Fgeral.Exportanumeros(Q.fieldbyname('move_aliicms').ascurrency,06,2)+
               Fgeral.Exportanumeros((totalitem-vlracres)*(Q.fieldbyname('move_aliicms').ascurrency/100),14,2)+
               Fgeral.Exportanumeros(isentas,14,2)+
               Fgeral.Exportanumeros(outras,14,2)+
               Fgeral.Exportanumeros(valorzero,14,2)+  // extras icms ( valor ipi, por exemplo)
               Fgeral.Exportanumeros(valorzero,14,2)+  // base ipi
               Fgeral.Exportanumeros(valorzero,14,2)+  // valor ipi
               Fgeral.Exportanumeros(valorzero,14,2)+  // isentas ipi
               Fgeral.Exportanumeros(valorzero,14,2)+  // outras ipi
               space(48)+  // observacao
               Fgeral.Exportanumeros(valorzero,14,2)+  // funrural
               '01'+   // checar esse tal codigo da base de calculo q só tem para saida
               Fgeral.Exportanumeros(baseicmsst,14,2)+  // base icms s.t.  ver com 'ratear' a base da nota pelos produtos
               Fgeral.Exportanumeros(valoricmsst,14,2);  // valor icms s.t.  ou se terá q gravar em cada item
        end;
    }

// 22.04.19 - Alexsandra - Vida Nova  - nao exportar itens de notas canceladas
          if ( EdSistema.text='02' ) and ( Q.fieldbyname('moes_status').asstring<>'N' )  then   // viasoft
            linha := linha

          else

            Writeln(Arquivo,linha);
// 28.08.06
          if trim(linhaipi)<>'' then
            Writeln(Arquivo,linhaipi);
// 07.02.09 - retornado pelo Es.. - 03.04.09 - NP e devolucao ficam sem emitentes..novicarnes
//          if Es='E' then begin
// 27.06.07
          if Q.fieldbyname('moes_tipocad').asstring='F' then begin
            if EmitentesCodigo.IndexOf(Q.fieldbyname('moes_tipo_codigo').asstring)<0 then begin
              Emitentes.Add(Q.fieldbyname('moes_tipo_codigo').asstring+';'+Q.fieldbyname('moes_tipocad').asstring);
              EmitentesCodigo.Add(Q.fieldbyname('moes_tipo_codigo').asstring)
            end;
          end else if Q.fieldbyname('moes_tipocad').asstring<>'U' then begin

            if ClientesCodigo.IndexOf(Q.fieldbyname('moes_tipo_codigo').asstring+';'+Q.fieldbyname('moes_tipocad').asstring)<0 then begin
              Clientes.Add(Q.fieldbyname('moes_tipo_codigo').asstring+';'+Q.fieldbyname('moes_tipocad').asstring);
              ClientesCodigo.Add(Q.fieldbyname('moes_tipo_codigo').asstring+';'+Q.fieldbyname('moes_tipocad').asstring);
// 05.02.09 - nas transferencias tem q jogar como cliente e fornecedor a unidade..
//              if Q.fieldbyname('moes_tipocad').asstring='U' then begin
//                Emitentes.Add(Q.fieldbyname('moes_tipo_codigo').asstring+';'+Q.fieldbyname('moes_tipocad').asstring);
//                EmitentesCodigo.Add(Q.fieldbyname('moes_tipo_codigo').asstring)
//              end;
// ai 'phode' pois tem um emitente com o codigo da unidade
            end;
          end;
          if ItensCodigo.IndexOf(Q.fieldbyname('move_esto_codigo').asstring)<0 then begin
              ItensCodigo.Add(Q.fieldbyname('move_esto_codigo').asstring);
          end;
          sistema.beginprocess('Data '+FGeral.formatadata(Q.fieldbyname('moes_datamvto').asdatetime));
          Q.Next;
    end;
    inc(n);

  end;
// 08.05.14 - Geracao da Leitura Z registro RC
////////////////////////////////////////////////
///////////////  Lista60:=TStringlist.create;
  if Global.Topicos[1021] then begin
    GeraRegistros60;
    for p:=0 to lista60.count-1 do begin
      linha:=lista60[p];
      if trim(linha)<>'' then
        Writeln(Arquivo,linha);
    end;
  end;

  nomecidade:='';
  contacontabil:=0;
  sexo:='M';
  numero:=0;
///////////////////////////////////////////////////////////////
  sistema.beginprocess('Armazenando fornecedores');
  for p:=0 to Emitentes.count-1 do begin
    Lista:=TStringlist.create;
    elemento:=Emitentes[p];
    strtolista(lista,elemento,';',true);
//    nomecad:=Ups(FGeral.GetNomeTipoCad( strtoint(Lista[0]),Lista[1] ) );
    nomecad:=Ups(FGeral.GetNomeRazaoSocialEntidade( strtoint(Lista[0]),Lista[1],'R' ) );
    fantasia:=Ups(FGeral.getNomeRazaoSocialEntidade(strtoint(Lista[0]),Lista[1],'N' ) );
    try
       PesquisaEntidade(lista[1],strtoint(Lista[0]));
    except
       Avisoerro('Checar codigo de fornecedor '+lista[0]);
       break;
    end;
    cidade:=Ups(GetCidade(Lista[1],strtoint(Lista[0])));
    uf:=GetUF(lista[1],strtoint(Lista[0]));
    cep:=GetCEP(Lista[1]);
    cnpjcpf:=GetCnpj(Lista[1],strtoint(Lista[0]));
    insest:=GetInsEst(Lista[1],strtoint(Lista[0]));
    endereco:=GetEndereco(Lista[1]);
    bairro:=GetBairro(Lista[1],strtoint(Lista[0]));
    telefone:=GetTelefone(Lista[1],strtoint(Lista[0]));
    fax:=GetFax(Lista[1],strtoint(Lista[0]));
    email:=GetEmail(Lista[1],strtoint(Lista[0]));
    nomecidade:=FCidades.GetNome(strtoint(cidade));
    numero:=strtointdef( FSintegra.GetNumerodoEndereco(endereco) ,0);
////////////////
    contacontabil:=0;
// 05.02.09
//    if lista[1]<>'U' then begin
// 11.03.09
    if lista[1]='F' then begin
      if QGeral.fieldbyname('forn_unidexporta01').AsString=EdUnid_codigo.text then
        contacontabil:=QGeral.fieldbyname('forn_contaexp').AsInteger
      else if QGeral.fieldbyname('forn_unidexporta02').AsString=EdUnid_codigo.text then
        contacontabil:=QGeral.fieldbyname('forn_contaexp02').AsInteger
      else if QGeral.fieldbyname('forn_unidexporta03').AsString=EdUnid_codigo.text then
        contacontabil:=QGeral.fieldbyname('forn_contaexp03').AsInteger
      else if QGeral.fieldbyname('forn_unidexporta04').AsString=EdUnid_codigo.text then
        contacontabil:=QGeral.fieldbyname('forn_contaexp04').AsInteger;
      if QGeral<>nil then begin
        Qgeral.close;
        Freeandnil(QGeral);
      end;
    end;
    if EdSistema.text='02' then begin  // viasoft

      linha:='P'+'E'+strzero(empresa,3)+strzero(filial,3)+
            strzero(strtoint(Lista[0]),8)+
            strspace( nomecad,80)+
            strspace( cnpjcpf,14 )+
            strspace( insest,18 )+
            strspace( cidade,5 )+
            'N'+     //  se e produtor sem NF
            strspace( fantasia,40 )+
            strspace( endereco,40 )+
            strspace( inttostr(numero),20 )+
            strspace( bairro,40 )+
            strspace( cep,08 )+
            strspace( telefone,14 )+
            strspace( fax,14 )+
            strspace( email,60 )+
            space(3)+     // categoria do estab. p/Scanc
            space(11)+    // Incrição prod.rural
            space(09)+    // Inscrição Suframa
            'N'+          // se é orgão público
            ' '+          // Pessoa Cooperada?
            '  ';         // Classificação de Retenção

    end else begin

      linha:='P'+sep+            // 0
             'E'+sep+             // 1
              strzero(empresa,3)+sep+  // 2
              strzero(filial,3)+sep+   // 3
              strzero(strtoint(Lista[0]),8)+sep+  // 4
              strspace( nomecad,40)+sep+          // 5
              strspace( cnpjcpf,14 )+sep+         // 6
              strspace( insest,18 )+sep+          // 7
              strspace( cidade,5 )+sep+           // 8
              'N'+sep+     //  se e produtor sem NF   // 9
              strspace( fantasia,40 )+sep+        // 10
              strspace( endereco,40 )+sep+        // 11
              strspace( bairro,40 )+sep+          // 12
              strspace( cep,08 )+sep+             // 13
              strspace( telefone,14 )+sep+        // 14
              strspace( fax,14 )+sep+             // 15
              strspace( email,60 )+sep+           // 16
              space(3)+sep+     // categoria do estab. p/Scanc  // 17
              nomecidade+sep+                     // 18
              inttostr(contacontabil)+sep+        // 19
              sep+                                // 20
              uf;                                 // 21  24.11.11 nao mandava uf


    end;
    inc(totalregR);
    Writeln(Arquivo,linha);
    Freeandnil(Lista);
  end;

/////////////////////////////// CLIENTES
  sistema.beginprocess('Armazenando clientes');
  for p:=0 to Clientes.count-1 do begin

    Lista:=TStringlist.create;
    elemento:=Clientes[p];
    strtolista(lista,elemento,';',true);
    if trim(elemento)='' then
      avisoerro(' lista zerada no elemento '+inttostr(p)+' de '+inttostr(clientes.count));

//    nomecad:=Ups(FGeral.GetNomeTipoCad( strtoint(Lista[0]),Lista[1] ) );
//    nomecad:=Ups(FGeral.GetNomeRazaoSocialEntidade( strtoint(Lista[0]),Lista[1],'N' ) );
// 19.06.07
    nomecad:=Ups(FGeral.GetNomeRazaoSocialEntidade( strtoint(Lista[0]),Lista[1],'R' ) );
    fantasia:=Ups(FGeral.GetNomeRazaoSocialEntidade( strtoint(Lista[0]),Lista[1],'N' ) );
    try
       PesquisaEntidade(lista[1],strtoint(Lista[0]));
    except
       Avisoerro('Checar codigo de cliente '+lista[0]);
       break;
    end;
    try
      cidade:=Ups(GetCidade(Lista[1],strtoint(Lista[0])));
      uf:=GetUF(lista[1],strtoint(Lista[0]));
      cep:=GetCEP(Lista[1]);
      cnpjcpf:=GetCnpj(Lista[1],strtoint(Lista[0]));
      insest:=GetInsEst(Lista[1],strtoint(Lista[0]));
      endereco:=GetEndereco(Lista[1],strtoint(Lista[0]) );
      bairro:=GetBairro(Lista[1],strtoint(Lista[0]));
      telefone:=GetTelefone(Lista[1],strtoint(Lista[0]));
      fax:=GetFax(Lista[1],strtoint(Lista[0]));
      email:=GetEmail(Lista[1],strtoint(Lista[0]));
      nomecidade:=FCidades.GetNome(strtoint(cidade));
// 05.02.09
      if pos(Lista[1],'U;R;T')=0 then begin
        if Lista[1]='F' then begin
          if QGeral.fieldbyname('forn_unidexporta01').AsString=EdUnid_codigo.text then
            contacontabil:=QGeral.fieldbyname('forn_contaexp').AsInteger
          else if QGeral.fieldbyname('forn_unidexporta02').AsString=EdUnid_codigo.text then
            contacontabil:=QGeral.fieldbyname('forn_contaexp02').AsInteger
          else if QGeral.fieldbyname('forn_unidexporta03').AsString=EdUnid_codigo.text then
            contacontabil:=QGeral.fieldbyname('forn_contaexp03').AsInteger
          else if QGeral.fieldbyname('forn_unidexporta04').AsString=EdUnid_codigo.text then
            contacontabil:=QGeral.fieldbyname('forn_contaexp04').AsInteger;
          sexo:=' ';
        end else begin
          contacontabil:=QGeral.fieldbyname('clie_contacontabil').AsInteger;
          sexo:=QGeral.fieldbyname('clie_sexo').asstring;
        end;
      end else begin
        contacontabil:=0;
        sexo:=' ';
      end;
    except
      avisoerro('Problemas no cadastro do codigo '+lista[0]+' tipo '+lista[1]);
      break;
    end;
    if QGeral<>nil then begin
      Qgeral.close;
      Freeandnil(QGeral);
    end;
    if EdSistema.text='02' then begin  // viasoft
           {
      linha:='P'+'C'+strzero(empresa,3)+strzero(filial,3)+
            strzero(strtoint(Lista[0]),8)+
            strspace( nomecad,40)+
            strspace( cnpjcpf,14 )+
            strspace( insest,18 )+
            strspace( cidade,5 )+
            'N'+     //  se e produtor sem NF
            strspace( fantasia,20 )+
            strspace( endereco,40 )+
            strspace( bairro,40 )+
            strspace( cep,08 )+
            strspace( telefone,14 )+
            strspace( fax,14 )+
            strspace( email,60 )+
            space(3);    // categoria do estab. p/Scanc
            }
      linha:='P'+'C'+strzero(empresa,3)+strzero(filial,3)+
            strzero(strtoint(Lista[0]),8)+
            strspace( nomecad,80)+
            strspace( cnpjcpf,14 )+
            strspace( insest,18 )+
            strspace( cidade,5 )+
            'N'+     //  se e produtor rural
            strspace( fantasia,40 )+
            strspace( endereco,40 )+
            strspace( inttostr(numero),20 )+
            strspace( bairro,40 )+
            strspace( cep,08 )+
            strspace( telefone,14 )+
            strspace( fax,14 )+
            strspace( email,60 )+
            space(3)+     // categoria do estab. p/Scanc
            space(11)+    // Incrição prod.rural
            space(09)+    // Inscrição Suframa
            'N'+          // se é orgão público
            ' '+          // Pessoa Cooperada?
            '  ';         // Classificação de Retenção


    end else begin

      linha:='P'+sep+
            'C'+sep+
            strzero(empresa,3)+sep+
            strzero(filial,3)+sep+
            strzero(strtoint(Lista[0]),8)+sep+
            strspace( nomecad,40)+sep+
            strspace( cnpjcpf,14 )+sep+
            strspace( insest,18 )+sep+
            strspace( cidade,5 )+sep+
            'N'+sep+     //  se e produtor sem NF
            strspace( fantasia,40 )+sep+
            strspace( endereco,40 )+sep+
            strspace( bairro,40 )+sep+
            strspace( cep,08 )+sep+
            strspace( telefone,14 )+sep+
            strspace( fax,14 )+sep+
            strspace( email,60 )+sep+
            space(3)+sep+     // categoria do estab. p/Scanc
            nomecidade+sep+
            inttostr(contacontabil)+sep+
            sexo+sep+
            uf;
    end;

    inc(totalregC);

    if strtoint(lista[0])>0 then
       Writeln(Arquivo,linha);
// 21.03.19 - Vida Nova Alecxandra
    if ( contacontabil>0 ) and ( EdSistema.text='02' )  then begin
       linha := 'P' + 'X' +
                '000000' +     // conta contabil do 'emitente'
                strzero(contacontabil,6);
       Writeln(Arquivo,linha);
    end;

    Freeandnil(Lista);
  end;
/////////////////////////////ITENS
  sistema.beginprocess('Armazenando itens');

  for p:=0 to Itenscodigo.count-1 do begin

    Lista:=TStringlist.create;
//    elemento:=Itenscodigo[p];
// 23.08.11
    elemento:=trim(Itenscodigo[p]);
    cstitem:=strzero( strtointdef( FEstoque.Getsituacaotributaria(elemento,EdUnid_codigo.text,EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring,'N',0,'N','N','N') ,0),3);
    strtolista(lista,elemento,';',true);
//    linha:='I'+DatetoTextInvertida(EdInicio.asdate,true)+space(04)+space(03)+
//    codsit:= FEstoque.GetCodigosituacaotributaria(elemento,EdUnid_codigo.text,EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring);

    if EdSistema.text='02' then begin  // viasoft

//      linha:='I'+'I'+strzero(empresa,3)+strzero(filial,3)+
      linha:='M'+'M'+strzero(empresa,3)+strzero(filial,3)+
            spacestr( elemento,60)+
            strspace(FEstoque.GetDescricao(elemento),120)+
            strspace(FEstoque.GetNCMipi(elemento),8)+
            strspace(FEstoque.GetUnidade(elemento),03)+
            strspace(inttostr(FEstoque.GetGrupo(elemento)),6)+
            '0'+cstitem+    //aqui é C,4
            Fgeral.Exportanumeros(FEstoque.Getaliquotaipi(elemento),04,2)+
            Fgeral.Exportanumeros(FEstoque.Getaliquotaicms(elemento,Edunid_codigo.text,Global.UFUnidade,0,'','N',''),04,2)+
            Fgeral.Exportanumeros( FCodigosFiscais.GetAliquotaRedBase( FEstoque.GetCodigoFiscal(elemento,global.CodigoUnidade,Global.UFUnidade),'N',elemento,'' ) ,04,2)+
            Fgeral.Exportanumeros(0,13,2)+             // base icms S.T.
            space(06)+                               // Cód.Config.Contas para Valores
            strspace(FEstoque.GetNCMipi(elemento),10)+
            '000'+                                // Código do produto para DNF
            Fgeral.Exportanumeros(0,13,3)+        // Fator de conversão p/ DNF
            Fgeral.Exportanumeros(0,07,2)+        // Capacidade Volumétrica
            '00000'+                              // Grupo para o imobilizado
            '00000'+                              // Código p/Scanc tipo 40
            '   '+                                // Código p/Scanc tipo 60
            ' '+                                  // Listar no livro (LMP)
            '  '+                                 // Tipo do Item
            '  ';                                 // Código do Gênero


            {
             parte do Registro 'II' - referente a Inventário
            DatetoTextInvertida(EdTermino.asdate,true)+
            '000100'+   //  unidades por embalagem
            Fgeral.Exportanumeros(1,13,3)+  // quantidade em unidades
            Fgeral.Exportanumeros(FEstoque.GetPreco(elemento,EdUnid_codigo.text),11,2)+  //  preço unitário por embalagem
            space(60);                              // observacao
            }
    end else begin

      linha:='I'+sep+                      // 0
            'I'+sep+                       // 1
            strzero(empresa,3)+sep+        // 2
            strzero(filial,3)+sep+         // 3
            DatetoTextInvertida(EdTermino.asdate,true)+sep+        // 4
            spacestr( elemento,60)+sep+                            // 5
            strspace(FEstoque.GetDescricao(elemento),120)+sep+      // 6
            strspace(inttostr(FEstoque.GetGrupo(elemento)),6)+sep+ // 7
//            strspace(FEstoque.GetNCMipi(elemento),8)+
            cstitem+sep+                                           // 9
            strspace(FEstoque.GetUnidade(elemento),03)+sep+        // 10
            '000100'+sep+   //  unidades por embalagem             // 11
            Fgeral.Exportanumeros(1,13,3)+sep+  // quantidade em unidades   // 12
            Fgeral.Exportanumeros(FEstoque.GetPreco(elemento,EdUnid_codigo.text),11,4)+sep+  // 13  //  preço unitário por embalagem
//            Fgeral.Exportanumeros(valorzero,13,3)+  // quantidade em unidades
//            Fgeral.Exportanumeros(valorzero,11,2)+  //  preço unitário por embalagem
            space(01)+                              //Indicador de propriedade/posse
            '00000000'+sep+                          // Código do proprietário/possuid
            '00000'+sep+                             // ID. da observação
            Fgeral.Exportanumeros(0,11,2)+sep+      // Base cálculo ICMS-EFD ICMS/IPI
            Fgeral.Exportanumeros(0,11,2)+sep+      // Valor do ICMS - EFD ICMS/IPI
            space(03)+                              // Unidade de Conversão do Item
            Fgeral.Exportanumeros(0,20,9)+sep+      // Valor Total da Mercadoria
            Fgeral.Exportanumeros(0,20,2)+sep+      // Valor para Imposto de Renda
            space(06)+                              // * Cód.Config.Contas para Valores
            space(02)+                              // Motivo do Inventário**
            space(68);                              // ** Identificador de Origem

    end;
{
            spacestr( elemento,10)+
            strspace(FEstoque.GetDescricao(elemento),60)+
            space(08)+   // NCM
            strspace(FEstoque.GetUnidade(elemento),03)+
            strspace(inttostr(FEstoque.GetGrupo(elemento)),6)+
            strzero( strtointdef( FEstoque.Getsituacaotributaria(elemento,EdUnid_codigo.text,EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring) ,0),2)+
            strzero( strtointdef( FEstoque.Getsituacaotributaria(elemento,EdUnid_codigo.text,EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring) ,0),2)+
            Fgeral.Exportanumeros(valorzero,04,2)+  // % ipi
//            Fgeral.Exportanumeros(FEstoque.GetAliquotaIcms(elemento,EdUnid_codigo.resultfind.fieldbyname('unid_uf').astring),04,2)+  // % icms
            Fgeral.Exportanumeros(valorzero,04,2)+  // % redução base calc. icms - ainda nao implementado
            Fgeral.Exportanumeros(valorzero,13,2)+  // base calc. icms subst. trib. - ver o q lançar aqui
            space(06)+    // codigo config. contas para valores
            space(08)+    // NBM
            Fgeral.Exportanumeros(valorzero,03,0)+  // codigo do produto para DNF
            Fgeral.Exportanumeros(valorzero,13,3)+  // fator de conversao p/ DNF
            Fgeral.Exportanumeros(valorzero,05,0)+  // grupo pra imobilizado
            Fgeral.Exportanumeros(valorzero,05,0)+  // codigo p/ scanc tipo 40
            space(03)+                              // codigo p/ scanc tipo 60
            space(01);                              // listar no livro (LMP)
}


//            '00000'+strspace(FEstoque.Getsituacaotributaria(elemento,EdUnid_codigo.text,EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring),3)+
//            space(40)+

    Writeln(Arquivo,linha);
//    texto.lines.add('II: qtde em unid '+copy(linha,112,13)+' unitário '+copy(linha,125,11));

    Freeandnil(Lista);
  end;
  totalregI:=Itenscodigo.count;

//////////////////////////////////////// cidades  - se enviar viola a primary key no arquivo do viasoft windows

  Arq.TMunicipios.first;
// 13.03.14
  FCidades.SetaCodigosIbge(Fcidades.EdCida_codigoibge);
  while not ARq.TMunicipios.eof do begin
    ufcidade:=strspace(ARq.TMunicipios.fieldbyname('cida_uf').asstring,02);
    if uppercase(ufcidade)='XX' then
      ufcidade:=EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring;
      xcodigopais:='01058';  // Brasil
//      if trim( Arq.TMunicipios.fieldbyname('Cida_codigopais').asstring )<> '' then
//        xcodigopais:=strspace( Arq.TMunicipios.fieldbyname('Cida_codigopais').asstring , 05 );

      if EdSistema.text='02' then begin  // viasoft

        linha:='C'+'C'+strspace(ARq.TMunicipios.fieldbyname('cida_codigo').asstring,5)+
            strspace(ARq.TMunicipios.fieldbyname('cida_nome').asstring,40)+
            ufcidade+
            space(4)+    //  DDD da cidade
//            strzero(ARq.TMunicipios.fieldbyname('cida_codigo').asinteger,7)+
            strzero(0,7)+  // codig 'oficial' do municipio
            space(08)+      // cep da cidade
            xcodigopais+
            '0';
            if length(trim(ARq.TMunicipios.fieldbyname('cida_codigoibge').asstring))<>7 then
              linha:=linha+FCidades.GetCodigoListaIbge(ARq.TMunicipios.fieldbyname('cida_nome').asstring)
            else
              linha:=linha+ARq.TMunicipios.fieldbyname('cida_codigoibge').asstring;
            linha:=linha+strzero(0,7);  // codig ANP

      end else begin
        linha:='C'+sep+'C'+sep+strspace(ARq.TMunicipios.fieldbyname('cida_codigo').asstring,5)+sep+
            strspace(ARq.TMunicipios.fieldbyname('cida_nome').asstring,40)+sep+
            ufcidade+sep+
            space(4)+sep+    //  DDD da cidade
//            strzero(ARq.TMunicipios.fieldbyname('cida_codigo').asinteger,7)+
            strzero(0,7)+sep+  // codig 'oficial' do municipio
            space(08)+      // cep da cidade
            xcodigopais+
            strspace('0'+ARq.TMunicipios.fieldbyname('cida_codigoibge').asstring,8)+
            strzero(0,7);  // codig ANP
      end;
    if ( trim(ARq.TMunicipios.fieldbyname('cida_nome').asstring)<>'' ) and
       ( length(trim(ARq.TMunicipios.fieldbyname('cida_codigoibge').asstring))=7 )
       then
        Writeln(Arquivo,linha);
    ARq.TMunicipios.next;
  end;

/////////////////////////////////////////////////////////////////////////////


  Freeandnil(Emitentes);Freeandnil(EmitentesCodigo);
  Freeandnil(Clientes);Freeandnil(ClientesCodigo);
  Freeandnil(itenscodigo);
///////////////////////////////////////////////////////////

// registro de venda ecfs
{
// registro de totais
  linha:='T'+DatetoTextInvertida(EdInicio.asdate,true)+
         space(04)+space(03)+space(01)+versao+space(7)+'0'+DatetoTextInvertida(EdTermino.asdate,true)+
         space(07)+'0'+space(10)+'0.00'+space(09)+'0'+space(10)+'0.00'+space(10)+'0.00'+space(40)+space(20)+
         space(2)+space(7)+'0'+
         space(40)+space(14)+space(18)+
         spacestr(sist,4)+space(09)+'0.000'+
         FGeral.ExportaNumeros(totalregI,14,2)+  // total reg. I ( itens )
         space(06)+space(14)+
         space(10)+'0.00'+  // total reg. F
         FGeral.ExportaNumeros(totalregE,14,2)+
         space(10)+'0.00'+   // total reg. D
         FGeral.ExportaNumeros(totalregS,14,2)+
         space(10)+'0.00'+   // total reg. P
         space(10)+'0.00'+   // total reg. I ( inventário )
         FGeral.ExportaNumeros(totalregR,14,2)+
         space(48)+
         FGeral.ExportaNumeros(totalregC,14,2)+
         space(03)+space(02)+space(10)+'0.00'+space(10)+'0.00'+'!';
  Writeln(Arquivo,linha);
}

  Sistema.Endprocess('Arquivo '+nomearq+' Exportados '+inttostr(n)+' documentos de entrada e saida.  Saidas '+formatfloat(f_cr,tvalorcontabil));
  Closefile(arquivo);
end;

procedure TFExpFiscalWin.EdterminoValidate(Sender: TObject);
begin
   if EdTermino.asdate<EdInicio.Asdate then
     EdTermino.INvalid('Término tem que ser posterior ao inicio');

end;

procedure TFExpFiscalWin.EdUnid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdUNid_codigo,key);

end;

procedure TFExpFiscalWin.EdCvExitEdit(Sender: TObject);
begin
   bexecutarclick(self);
end;

procedure TFExpFiscalWin.EdSistemaExitEdit(Sender: TObject);
begin
   bexecutarclick(self);

end;


// 08.05.14
procedure TFExpFiscalWin.GeraRegistros60;
////////////////////////////////////////////
var Q:TSqlquery;
    linha,separador,tiposnao,SqlunidadesDet,sep:string;
    ListaAliquotas,ListaAliquota:TStringList;
    p,ultimanota:integer;
    valorvendas:currency;

    // 14.07.11
    ///////////////////////////////////////////
    function Getformato60(dados,tipo:string):string;
    ///////////////////////////////////////////
    var Lista:TStringlist;

        function ValorouLetras(x:string):string;
        ///////////////////////////////////////
        begin
          if ( pos('C',x)>0 ) or ( pos('F',x)>0 ) or ( pos('I',x)>0 ) or ( pos('N',x)>0 ) then
             result:=strspace(x,4)
          else
             result:=FGeral.Exportanumeros(texttovalor(lista[04]),04,2);
        end;


    begin
//////////////
      lista:=tstringlist.create;
      strtolista(Lista,dados,';',true);
      if lista.count=0 then
        result:=''
      else if tipo='M' then begin
      // de imediato para viasoft
         result:='RC'+sep+
                 strzero(empresa,3)+sep+        //
                 strzero(filial,3)+sep+         //
                 'ECF'+sep+                     // tipo do mapa VER
                 strzero(  strtoint(lista[4]) ,03 )+sep+   // Numero do Equipamento
                 FGeral.DataStringinvertida( lista[2] )+sep+  // emissao
                 strzero( strtoint(lista[8]) ,6 )+sep+   // Numero do MAPA  VER
                 strzero( strtoint(lista[8]) ,6 ) +sep+   // CRZ
                 strzero( strtoint(lista[6]) ,6 ) +sep+   // primeiro COO do dia
                 strzero( strtoint(lista[7]) ,6 ) +sep+   // ultimo COO do dia
                 strzero( 0 ,6 ) +sep+  // numero ultima NF VER
                 space( 03 ) +sep+          // série ultima NF VER
                 FGeral.Exportanumeros(texttovalor(lista[11]),14,2)+sep+   // tot.geral
                 FGeral.Exportanumeros(texttovalor(lista[10]),14,2)+sep+   // venda bruta dia
                 FGeral.Exportanumeros(texttovalor(lista[10]),14,2)+sep+   // valor contabil dia
                 space( 60 )+sep+                                          // obs
                 space( 06 )+sep+                                          // Cód.Config.Contas para Valores
                 strzero( strtoint(lista[9]) ,10 ) +sep;   // CRO

//                 strspace( lista[3] ,20 )+separador+   // Numero de Serie de fabrica
//                 strspace( lista[5] ,02 )+separador+   // Modelo do cupom fiscal

      end else if tipo='A' then begin
          result:='60'+separador+
                  tipo+separador+
                 FGeral.DataStringinvertida(lista[2])+  // emissao
                 strspace(lista[03],20)+separador+   // Numero de Serie
                 ValorouLetras( Lista[04] )+separador+   // aliquota icms/situacao
                 FGeral.Exportanumeros(texttovalor(lista[05]),12,2)+separador+   // valor ref. aliquota
// 10.07.12  - ainda nao sei pq mas na leitura Z tá invertido subst.trib. 'F' com o 'N' - isento icms
//                 FGeral.Exportanumeros( GetValorCF( ValorouLetras( Lista[04] ),Lista[2] ) ,12,2)+separador+   // valor ref. aliquota
                 space( 79 );

      end else if tipo='R' then begin  // aqui era pro sintegra ainda nao ajustado...
          result:='60'+separador+
                  tipo+separador+
                  strzero(Datetomes(EdInicio.AsDate),2)+separador+
                  strzero(Datetoano(EdInicio.AsDate,true),4)+separador+
                  strspace( Lista[01],14 )+separador+   // codigo produto
                  FGeral.Exportanumeros(texttovalor(lista[02]),13,3)+separador+   // qtde
                  FGeral.Exportanumeros(texttovalor(lista[03]),16,2)+separador+   // valor
                  FGeral.Exportanumeros(texttovalor(lista[04]),16,2)+separador+   // base icms
                  FGeral.Exportanumeros(FEstoque.Getaliquotaicms(lista[01],EdUnid_codigo.text,EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring),04,2)+separador+   // aliquota icms
                  space( 54 ) ;

      end;
      Freeandnil(lista);
    end;


    /////// 10.07.12
    function GetValorCF( xsit,xdata:string ):currency;
    /////////////////////////////////////////////
    var QCF:TSqlquery;
        sqlsituacao:string;
    begin
{
          if (  strtointdef(xsit,0) >0 ) or ( trim(xsit)='N' ) then
            sqlsituacao:=' and move_natf_codigo = '+Stringtosql( '5102' )
          else
            sqlsituacao:=' and move_natf_codigo = '+Stringtosql( '5405' );
//          sqlsituacao:=' and '+FGeral.GetIN('move_natf_codigo','5102;5405','C' );
          QCf:=sqltoquery(' select moes_especie,move_natf_codigo,sum(move_venda*move_qtde) as totalvenda,moes_especie from movestoque'+
                          ' inner join movesto on ( move_transacao=moes_transacao and move_tipomov=moes_tipomov )'+
                          ' where move_status<>''C'''+
                          ' and move_datamvto = '+Datetosql( Strtodate(xdata) )+
                          ' and moes_especie = '+Stringtosql('CF')+
                          ' and '+FGeral.GetIN('move_unid_codigo',EdUNid_codigo.text,'C') +
                          sqlsituacao+
                          ' group by moes_especie,move_natf_codigo' );
}
          if (  strtointdef(xsit,0) >0 ) or ( trim(xsit)='N' ) then
            sqlsituacao:=' and movb_natf_codigo = '+Stringtosql( '5102' )
          else if trim(xsit)='F' then
            sqlsituacao:=' and movb_natf_codigo = '+Stringtosql( '5405' )
          else
            sqlsituacao:=' and movb_natf_codigo = '+Stringtosql( '9999' );
//          sqlsituacao:=' and '+FGeral.GetIN('move_natf_codigo','5102;5405','C' );
          QCf:=sqltoquery(' select moes_especie,movb_natf_codigo,sum(movb_basecalculo) as totalvenda from movbase'+
                          ' inner join movesto on ( movb_transacao=moes_transacao and movb_tipomov=moes_tipomov )'+
                          ' where movb_status<>''C'''+
                          ' and moes_datamvto = '+Datetosql( Strtodate(xdata) )+
                          ' and moes_especie = '+Stringtosql('CF')+
                          ' and '+FGeral.GetIN('movb_unid_codigo',EdUNid_codigo.text,'C') +
                          sqlsituacao+
                          ' group by moes_especie,movb_natf_codigo' );
          result:=0;
          while not QCF.eof do begin
            result:=QCf.fieldbyname('totalvenda').ascurrency;
            QCF.Next;
          end;
          FGeral.FechaQuery(QCF);
    end;


///////////////////////
begin
///////////////////////
   Lista60:=TStringlist.create;
   separador:=';';
   sep:=';';
   tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+Global.CodContrato+';'+
            Global.CodVendaInterna;
//   Sistema.beginprocess('Gerando registros 60M e 60A');
   Sistema.beginprocess('Gerando registros 60 -  RC');
   Q:=Sqltoquery('select max(moes_numerodoc) as ultima from movesto '+
                 ' where '+FGeral.Getin('moes_status','N;X;E;D;Y','C')+
                 ' and moes_comv_codigo <>'+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF') )+
                 ' and moes_datamvto>='+EdInicio.assql+
                 ' and moes_datamvto<='+EdTermino.assql+
                 ' and '+FGeral.GetNOTIN('moes_serie','F;F ','C')+
                 ' and '+FGeral.GetNOTIN('moes_tipomov',tiposnao+';'+Global.CodConhecimento+';'+Global.CodConhecimentoSaida,'C')+
                 ' and moes_datacont is not null'+
                 ' and moes_natf_codigo is not null'+
                 ' and '+FGeral.GetIN('moes_unid_codigo',EdUNid_codigo.text,'C') );
   ultimanota:=Q.fieldbyname('ultima').asinteger;
   FGeral.FechaQuery(Q);
   Q:=sqltoquery('select * from movleituraecf where mecf_status=''N'''+
                 ' and mecf_tipo=''Z'''+
//                 ' and extract( month from mecf_data )='+inttostr(mes)+
//                 ' and extract( year from mecf_data )='+inttostr(ano)+
                 ' and mecf_data >= '+EdInicio.AsSql+
                 ' and mecf_data <= '+EdTermino.AsSql+
                 ' and '+FGeral.GetIN('mecf_unid_codigo',EdUNid_codigo.text,'C') );
   ListaAliquotas:=TStringList.create;
   ListaAliquota:=TStringList.create;
   ultimanota:=0;
   while not Q.eof do begin
//  and ( pos('60A',registrosparanaogerar)=0)
     if (Q.fieldbyname('Mecf_VendaBruta').ascurrency>0) then begin
       linha:=GetFormato60( Q.fieldbyname('Mecf_usua_codigo').asstring+';'+
                 'nada'+';'+
                 Q.fieldbyname('Mecf_Data').asstring+';'+
                 Q.fieldbyname('Mecf_NumeroSerie').asstring+';'+
                 Q.fieldbyname('Mecf_NumeroOrdem').asstring+';'+
                 '2D'+';'+
                 Q.fieldbyname('Mecf_NumeroCOOi').asstring+';'+
                 Q.fieldbyname('Mecf_NumeroCOOf').asstring+';'+
                 Q.fieldbyname('Mecf_NumeroCRZ').asstring+';'+
                 Q.fieldbyname('Mecf_NumeroCRO').asstring+';'+
                 Valortosql( Q.fieldbyname('Mecf_VendaBruta').ascurrency )+';'+
                 Valortosql( Q.fieldbyname('Mecf_TotalGeral').ascurrency )+';',
                 'M' );
       Lista60.Add( linha );
////////////////////////////////////////////////////////////////////////////////////
{
       strtolista(ListaAliquotas,Q.fieldbyname('Mecf_AliqsIcms').asstring,'|',true);
       for p:=0 to ListaAliquotas.Count-1 do begin
         strtolista(ListaAliquota,ListaAliquotas[p],';',true);
         if ListaAliquota.Count>0 then begin
           if (trim(ListaAliquota[0])<>'') and (trim(ListaAliquota[0])<>'S') then begin
// aliquota de icms > 0
             if (ListaAliquota.Count=3)  then begin
               linha:=GetFormato60( Q.fieldbyname('Mecf_usua_codigo').asstring+';'+
                     'nada'+';'+
                     Q.fieldbyname('Mecf_Data').asstring+';'+
                     Q.fieldbyname('Mecf_NumeroSerie').asstring+';'+
                     ListaAliquota[1]+';'+
                     Valortosql( TextToValor(ListaAliquota[2]) )+';' ,
                     'A' );
               if TextToValor(ListaAliquota[2]) > 0 then
                 Lista60.Add( linha );
// F - subst.   I - Isento  - N - diferido
             end else begin
               valorvendas:=TextToValor(ListaAliquota[1]);
// 17.08.13 - voltado a pegar valor do ECF - Benato
//               valorvendas:=GetValorCF(ListaAliquota[0],Q.fieldbyname('Mecf_Data').asstring);
               if (valorvendas>0) then
                 linha:=GetFormato60( Q.fieldbyname('Mecf_usua_codigo').asstring+';'+
                     'nada'+';'+
                     Q.fieldbyname('Mecf_Data').asstring+';'+
                     Q.fieldbyname('Mecf_NumeroSerie').asstring+';'+
                     ListaAliquota[0]+';'+
//                     Valortosql( TextToValor(ListaAliquota[1]) )+';' ,
                     Valortosql( valorvendas )+';' ,
                     'A' )
               else
                 linha:='';
// 15.02.12 - por enquanto nao gera substituicao
//               if ( TextToValor(ListaAliquota[1]) > 0 ) and ( ListaAliquota[0]<>'F' ) then
// 17.04.12 - gera substituicao
               if ValorVendas > 0  then
                 Lista60.Add( linha );
             end;
           end;
         end;
       end;
       }
////////////////////////////////////////////////////////////////////////////////////

     end;  // se > 0
     Q.Next;
   end;
   FGeral.FechaQuery(Q);
//////////////////////////////////////////////////////////////////////////////
{

   Sistema.beginprocess('Gerando registros 60R');
   SqlunidadesDet:=' and move_unid_codigo='+EdUnid_codigo.assql;
   if Global.Topicos[1015] then
      SqlunidadesDet:=' and '+FGeral.GetIN('move_unid_codigo',EdUnidades.text,'C');
   Q:=Sqltoquery('select move_unid_codigo,move_esto_codigo,sum(move_qtde) as tqtde,sum(move_qtde*move_venda) as tvalor'+
                 ' from movestoque '+
                 ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                 ' inner join natureza on (natf_codigo=moes_natf_codigo)'+
                 ' where '+FGeral.Getin('move_status','N;X;E;D;Y','C')+
                 ' and '+FGeral.Getin('moes_status','N;X;E;D;Y','C')+
                 ' and moes_comv_codigo ='+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF') )+
                 ' and moes_datamvto>='+EdInicio.assql+
                 ' and moes_datamvto<='+EdTermino.assql+
                 ' and move_datamvto>='+EdInicio.assql+
                 ' and move_datamvto<='+EdTermino.assql+
                 ' and '+FGeral.GetNOTIN('moes_serie','F;F ','C')+
//                 ' and '+FGeral.GetNOtIN('moes_especie','CF;CF ;','C')+
                 ' and '+FGeral.GetNOTIN('moes_tipomov',tiposnao+';'+Global.CodConhecimento+';'+Global.CodConhecimentoSaida,'C')+
//                 ' and move_datacont is not null'+
// 29.10.13 - Vivan
                 ' and moes_datacont is not null'+
                 ' and moes_natf_codigo is not null'+
                 sqlunidadesdet+
                ' group by move_unid_codigo,move_esto_codigo'+
                ' order by move_unid_codigo,move_esto_codigo' );

   while not Q.eof do begin
     if pos( FUnidades.GetSimples(Q.fieldbyname('Move_unid_codigo').asstring),'S/2' ) > 0 then
       linha:=GetFormato60( 'nada'+';'+
                 Q.fieldbyname('Move_esto_codigo').asstring+';'+
                 ValortoSql( Q.fieldbyname('tqtde').ascurrency )+';'+
                 ValortoSql( Q.fieldbyname('tvalor').ascurrency )+';'+
                 ValortoSql( 0 )+';'+
                 'nada'+';',
                 'R' )
     else
       linha:=GetFormato60( 'nada'+';'+
                 Q.fieldbyname('Move_esto_codigo').asstring+';'+
                 ValortoSql( Q.fieldbyname('tqtde').ascurrency )+';'+
                 ValortoSql( Q.fieldbyname('tvalor').ascurrency )+';'+
                 ValortoSql( Q.fieldbyname('tvalor').ascurrency )+';'+
                 'nada'+';',
                 'R' );
     Lista60.Add( linha );
// 09.02.12 - Benato - nao ia ..
     if Lista75aux.IndexOf(Q.fieldbyname('move_esto_codigo').asstring)=-1 then begin
          Lista75.Add(Q.fieldbyname('move_esto_codigo').asstring);
          Lista75aux.Add(Q.fieldbyname('move_esto_codigo').asstring);
     end;

     Q.Next;
   end;
   FGeral.FechaQuery(Q);
}
//////////////////////////////////////////////////////////////////////////////
   Sistema.endprocess('');

end;

end.
