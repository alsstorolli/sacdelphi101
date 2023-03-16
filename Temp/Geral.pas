
unit Geral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,SqlExpr, StdCtrls, Mask, SQLEd, ExtCtrls, CheckDoc,
  //DBXPress,
  SqlSis,Math,SqlGrid,
  AppEvnts, alabel, Grids, SqlDtg, Barcode,
 // DBTables,
  SqlFun, ShellAPI,
  IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,
  IdBaseComponent, IdMessage, DB, ACBrNFe, synautil, smtpsend, mimemess,
  mimepart, synachar, OleServer, ExcelXP, ACBrBase, ACBrECF, ACBrDevice,
  ACBrECFClass,Spin, jpeg, OleCtrls, IdIOHandler, IdIOHandlerSocket,IdSMTPServer,
  IdSSLOpenSSL,IdSocks, WinSock, Excel2000, PCNConversao, ACBrSocket,
  ACBrIBPTax, Kr_Hint, IdPOP3, ACBrMail, IdExplicitTLSClientServerBase,
  IdSMTPBase, ACBrBarCode, DbxDevartPostgreSQL   ;

//  jcldatetime;
//, Kr_Hint

type
  TFGeral = class(TForm)
    TimeGeral: TTimer;
//    CheckCNPJCPF: TCheckDoc;
    Eventos: TApplicationEvents;
    KrHint: KrHint;
    TimerAlerta: TTimer;
    APHeadLabel1: TAPHeadLabel;
    Mensagem: TIdMessage;
    chuSmtp: TIdSMTP;
    SistemaContax: TSQLConnection;
//    Excel: TExcelApplication;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    IdPOP31: TIdPOP3;
    ACBrIBPTax1: TACBrIBPTax;
    Email: TACBrMail;
    ACBrBarCode1: TACBrBarCode;
    Excel: TExcelApplication;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimeGeralTimer(Sender: TObject);
    procedure TimerAlertaTimer(Sender: TObject);
  private
    function TituloRelRepresentante(Codigo: integer): string;
  public                                                     // 04.05.10
    function GetContador(Nome:String;DigitoVerificador:Boolean;Atualiza:Boolean=True):Integer;
    procedure AlteraContador(Nome:String;Posicao:Integer);
    function ConsultaContador(Nome:String):Integer;
    function GetOperacao:String;
    function GetTransacao:String;
// 20.06.16
    function GetTransacaoContax(xunidade:string;Incrementar:boolean):string;

    function GetContadorImpresso(CodImpresso:String):Integer;
    procedure AlteraContadorImpresso(CodImpresso:String;Posicao:Integer);
    function ConsultaContadorImpresso(CodImpresso:String):Integer;
    procedure ProcessaMensagem(var Msg: tagMSG; var Handled: Boolean);
    procedure SetaTipoCad(Edit:TSqlEd);
    procedure SetaUFs(Edit:TSqlEd);
    procedure ConfiguraEditsEntidade(Categoria:String;EdCodigo,EdNome,EdUF,EdRazao,EdCNPJCPF,EdContaContabil:TSqlEd);
    function GetEntidade(EdCodigo,EdNome,EdUF,EdRazao,EdCNPJCPF,EdContaContabil,EdFPgto,EdLPgto:TSqlEd):Boolean;
    function GetNomeRazaoSocialEntidade(Codigo:Integer;Categoria,NR:String):String;
    function DiaUtil(Data:TDateTime):Boolean;
    function GetProximoDiaUtil(Data:TDateTime;prazo:integer=0):TDateTime;
    procedure AtualizarEstacao;
    procedure ValidaCNPJCPF(Edit:TSqlEd);
    function  ValidarCNPJCPF(x:string):boolean;
    function ValidaUnidadesMvtoUsuario(EdUnidade:TSqlEd):Boolean;
    function ValidaContaCaixaUsuario(EdConta:TSqlEd):Boolean;
    function ValidaMvto(EdData:TSqlEd):Boolean;
    function ValidaDataContabil(EdData:TSqlEd):Boolean;
    function ValidaDataFiscal(EdData:TSqlEd):Boolean;
    function GetValorTxAdmAutomatica(Conta:Integer;ValorPendFin:Currency):Currency;
    function GetValorImposto(BaseCalculo,Aliquota,Reducao:Extended):Currency;
    function GetContaContabil(ContaGer,ContaContabilEntidade:Integer;CodigoUnidade:String;CodigoCC:String=''):Integer;
    procedure GravaContadorRefresh(Tab:TSqlDs);
    procedure LeContadorRefresh(Tab:TSqlDs);
    procedure RefreshTabelas;
    procedure InicializaConfig1;
    function GetConfig1AsString(NomeCampo:String):String;
    function GetConfig1AsInteger(NomeCampo:String):Integer;
    function GetConfig1AsFloat(NomeCampo:String):Extended;
    function GetConfig1AsDate(NomeCampo:String):TDateTime;
    procedure GetFieldsConfig1(Form:TForm);
    procedure SetFieldsConfig1(Form:TForm);
    procedure GravaConfig1(NomeCampo,Tipo,Conteudo:String);
    function GetDataServidor:TDateTime;
    procedure GetValoresAcessoriosCalculados(Operacao:String;Conta:Integer;Valor,ValorMoeda:Currency;DtVcto:TDateTime; var Juros,Multa,Mora,TxAdm,CorrMonet,Descontos,Acrescimos,Abatimentos,ValorBxParcial:Currency);
    procedure SetDefaultEdits(Form:TForm);
    procedure EnableEdits(Form:TForm;Grupo:Integer);
    procedure DisableEdits(Form:TForm;Grupo:Integer);
    function GetVctoPendFin(Conta:Integer):TDateTime;
    function GetIN(Campo,Str,TipoCampo:String):String;
    function GetNOTIN(Campo,Str,TipoCampo:String):String;
    procedure EntidadesCreate(QOrigem:TSqlQuery;CpoCatEntidade,CpoCodEntidade:String);
    procedure EntidadesCreateStr(StrEntidades,Cat:String);
    function EntidadesGetDados(Cat:String;Codigo:Integer):Boolean;
    procedure EntidadesClear;
    function GetValorLiquidoPendFin(QPendFin:TSqlQuery):Currency;
    function GetStrPeriodo(m:String = ''):String;
    function UnidadeValidaUsuario(Unidade:String):Boolean;
    procedure GravaDiario(Data:TDateTime;Campo,Conteudo:String;Commit:Boolean);
    function GetCampoDiario(Data:TDateTime;Campo:String):String;
    function GetSaldoInicialBancario(Conta:Integer;Data:TDateTime):Currency;
    procedure GetSaldosIniciaisMovGer(Data:TDateTime;Mat:TList;ContasValidas:String);
    function GetSaldoInicialMovGer(Conta:Integer;Unidade:String;Data:TDateTime):Currency;
    function GetSaldoInicialMovGerMoeda(Conta:Integer;Unidade:String;Data:TDateTime):Currency;
    procedure GetSaldosIniciaisBancarios(Data:TDateTime;Mat:TList;ContasValidas:String);
    procedure GetSaldosIniciaisMovCon(Data:TDateTime;Mat:TList;ContasValidas:String);
    function UnidadesToNomeEmpresa(Unidades:String):String;
    function Calcula(Formula:String;ListaVariaveis:TStringList;var Retorno:Extended):Boolean;
    function GetTituloUnidades(Unidades:String):String;
    function GetTipoImposto(Codigo:String):String;
    procedure LiberaCadastro(Grid:TSqlGrid);
    function GetFornecedoresVinculados(Codigo:Integer):String;
    function UnidadeValida(Codigo:Integer):Boolean;
    procedure ValidaNumeroDcto(Edit:TSqlEd);
    procedure OrganizarBanco;
    function GetContadorOld(Nome:String;DigitoVerificador:Boolean):Integer;
    procedure AlertaMensagem;
    procedure TestaFinalizacaoAutomatica;
    procedure SolicitarUsoExclusivo;
    procedure LiberarUsoExclusivo;
    procedure GravaLog(const CodigoEvento:Integer;const ComplementoEvento:String ; comitar:boolean=true ; transacao:string='' ; usuario:integer=0 ; motivo:string='' );
    procedure SetaCodigosLog;
    procedure SetaGradientes;
    procedure CreateForm(InstanceClass: TComponentClass; var Reference);
    procedure SetaDataUltimoEncerrCont;
    function GetProximoCodigoCadastro(Cadastro,Campo:String):Integer;
    procedure Limpaedit(Ed:TSqlEd;key:char);
    procedure Linhatogrid(Grade:integer;Codigos: string;Grid:TStringgrid);
    procedure Colunatogrid(Grade:integer;Codigos: string;Grid:TStringgrid);
    function QualQtde(Usuario:integer;Qtde,Qtdeprev:Currency):Currency;
    function ValidaCliente(Edit: TSqled ; tipomov:string=''  ; condicao:string='V'; portador:string='XXX' ; unidades:string='001'; valordoc:currency=0): boolean;
    function ValidaRepresentante(Edit:TSqlEd):boolean;
    function TemEstoque(CodigoProduto:string;Qtde:Currency;Unidade:string;Q:TSqlquery ; Tipomov:string=''):boolean;
    procedure SetaCodigosMovimento;
    procedure GravaMestreConsignacao(Emissao: TDatetime; Cliente:TSqlEd ;
              Representante: integer; Unidade, TipoMovimento, Transacao : string ; Numero: Integer ; Valortotal:currency ; Tabela:Integer ; OP:string='I' ; Magazine:string='N');
    procedure GravaItensConsignacao(Emissao: TDatetime; Cliente:TSqlEd ;
              Representante: integer; Unidade, TipoMovimento,Transacao : string ; Numero: Integer ; Grid: TSqlDtGrid);
    function CodigoBarra(CodigoProduto:string; Ed:TSqled=nil):boolean;
    function Arredonda(valor:extended;decimais:integer):extended;
    function Buscaremessa(Numero:Integer ; TipoMov:string='' ; status:string='N'  ; unidade:string=''; emissao:TDatetime=0):String;
    function BuscaTransacao(Numero,Tabela,campo:string ; campostatus:string='' ; status:string='' ; campoordem:string='' ; campotipomov:string=''  ; xtipomov:string='' ):String;
    procedure ReservaEstoque(Codigo,unidade,EntSai,TipoMovimento:string ; Qtde:currency);
    function BuscaQtdeItemEstoque(Codigo,Unidade:string):string;
    procedure MovimentaQtdeEstoque(Codigo,UNidade,EntSai,TipoMovimento : string ; Qtde : currency ; Q:TSqlquery ; Qtdeprev : currency=0 ; Pecas:currency=0 );
    function  Centra(texto:string;largura:integer):string;
    function Formatatelefone(telefone:string):string;
// 15.05.14
    function Formatatelefonecel(telefone:string):string;
    function Formatacep(cep:string):string;
    function Formatacnpj(cnpj:string):string;
    function Formatacpf(cpf:string):string;
    function Formatacnpjcpf(cnpj:string):string;
    function Formatavalor(valor: currency; mascara:string; tam:integer=0): string;
    function FormataData(data: TDatetime): string;
    function FormataNatf(codigo: string): string;
    function GetTipoMovto(tipomovto: string ; reduzido:boolean=false ; caixabancos:string='N'): string;
    function GetEntSaiTipoMovto(tipomovto: string): string;
    function EstoqueAnterior(produto,unidade:string;DataInicial:TDatetime; var salantpecas:currency ;cor:integer=0;tamanho:integer=0;copa:integer=0):currency;
//    function ProcuraGrid(coluna:integer;busca:string;Grid:TSqlDtGrid):integer;
// 21.10.05
    function ProcuraGrid(coluna: integer; busca: string; Grid: TSqlDtGrid ; colunatam:integer=0; tam:integer=0 ;
             colunacor:integer=0 ; cor:integer=0 ; colunacopa:integer=0 ; copa:integer=0 ): integer;

    procedure GravaRetornoConsignacao(Emissao:TDatetime;Cliente:TSqlEd ;Representante:integer;
              Unidade,TipoMovimento,Transacao:string;Numero:Integer;Valortotal:currency; Grid:TSqlDtGrid ;
              QProdRemessa:TMemoryQuery ; QProdDevolvido:TMemoryQuery ; Remessas : String ; Condicao : string ; Movimento : TDatetime ; Percdesconto,vlrdesconto:currency;
              GridParcelas:TSqlDtGrid=nil ; TotalNf:currency=0 ; Marcoutudo:boolean=false ; Portador:string='' ;
              GravaECF:boolean=false ; TotalProdutos:currency=0 ; ValorAntecipa:currency=0 ; GridParcelas01:TSqlDtGrid=nil ;
              xPortador01:string='' ; GridParcelas02:TSqlDtGrid=nil ; xPortador02:string='' );
    function RelEstoque(campo:string):string;
    procedure SetaItemsMovimento(Ed:TSqlEd);
//    function PesqListaCstPerc(Cst:string;Perc:currency):integer;
    function  PesqListaCstPerc(Cst: string; Perc: currency ; ListaCstPerc:TList=nil ; cfop:string=''):integer;
//    procedure GeraListaCstPerc(Cst: string; Perc,contabil,base,reducao,isentas,outras,basesubs: currency);
    procedure GeraListaCstPerc(Cst: string; Perc,contabil,base,reducao,isentas,outras,basesubs: currency ;
              ListaCstPerc:TList=nil ; TpImposto:string='I' ; Cfop:string='');
    procedure GravaMestreNFSaida(Emissao,Saida: TDatetime; Cliente: TSqlEd;
              Representante: integer; Unidade, TipoMovimento, Transacao, Condicao, Natureza, ciffob,Especievolume: string;
              Numero,CodigoMov,QTdevolumes: Integer; Valortotal,baseicms,valoricms,basesubs,icmssubs,vlrfrete: currency; Tabela: Integer ;
              Movimento : TDatetime ; ValorProd,peracre,perdesco : currency ; romaneio:integer ; valoravista:currency ; remessas:string='' ;
              status:string='N' ; Mensagem:string='' ; Pedido:integer=0 ; tran_codigo:string=''  ; Pesoliq:currency=0 ; Pesobru:currency=0 ;
              moes_clie_codigo:integer=0 ; Valoripi:currency=0 ;Freteuni:currency=0 ; portoorigem:string='' ; portodestino:string='' ; container:string='' ;
              Representante2: integer=0 ;  TiposFornec:string=''; ValorServicos:currency=0 ; PercIss:currency=0 ; ValorIss:currency=0 ;
              ValorFunrural:currency=0  ; PerComissao:currency=0 ;  PerComissao2:currency=0 ;  MargemLucro:currency=0 ;
              UfEmbarque:string='' ; ChaveNfeacom:string='' ; ValorCotaCapital:currency=0 ; xColaborador:string='' ;
              xvlroutrasdespesas:currency=0 ; xNomeObra:string=''; carga:integer=0);

    procedure GravaItensNFSaida(Emissao: TDatetime; Cliente:TSqlEd ;
              Representante: integer; Unidade, TipoMovimento,Transacao : string ; Numero: Integer ; Grid: TSqlDtGrid ;
              frete , seguro , peracre , perdesco :currency  ; Movimento : TDatetime  ; remessas:string='' ; status:string='N' ;
              Pedido:integer=0 ; moes_clie_codigo:integer=0 ;cfop:string='' ; Consfinal:string='S' ; CodigoMov:integer=0 ;
              rtipocad:string='C' ; xPedidos:string='' );

    procedure GravaMovfin(Transacao,Unidade,EntSai,CompleHist:string ; Emissao,Movimento,Bompara:TDatetime ; Numero,CodHist,Cheque,Conta:integer ; valorparcela:currency ; Contarecdes :integer ;
                          Tipomov:string ; Repr_codigo:integer=0 ; Tipo_codigo:integer=0 ; tipocad:string='' ; status:string='N'; npar:string='1';
                          transacaocontax:string=''; ContaTrans:integer=0 );
    procedure GravaPendencia(Emissao,Movimento:TDatetime;Clifor:TSqlEd;TipoCad:string ;Representante:integer;Unidade,TipoMovimento,
              Transacao,Condicao,PR:string;Numero,CodigoMov:Integer;Valortotal,ValorComissao:currency;status:string='N';Total:currency=0;contagerencial:integer=0;
              GridParcelas: TSqlDtGrid=nil ; opantecipa:string='' ; Portador:string='' ; Complemento:string='' ;
              xseto_codigo:string='' );
    function  TituloRelUnidade(Unidade: string): string;
    function Custo(Unitario,pericms,perfrete,peripi,pericmsfrete,perdesc,peracre,perpis,percofins,perST:currency; simplesnacional:string='N'):currency;
    function CustoMedio(Customedio, NOvoCusto, Qtde, NovaQtde : currency): currency;
    function CustoMedioGerencial(CustomedioGer, NOvoCusto, Qtde, NovaQtde :currency):currency;
    function TipomovEntra(TipoMov:string):boolean;
    function TipomovSai(TipoMov:string):boolean;
    procedure GravaMestreNFCompra(Emissao,Entrada: TDatetime; Fornecedor: TSqlEd; TipoCad: String ;
              Unidade, TipoMovimento, Transacao, Condicao, Natureza, ciffob : string;
              Numero,CodigoMov: Integer; Valortotal,baseicms,valoricms,basesubs,icmssubs,vlrfrete,peracre,perdesco,totprod: currency ;
              total:currency=0  ; valortot:currency=0 ; Movimento:TDatetime=0 ; Mensagem:string='' ; Tipodoc:string='' ; Serie:string='' ;
              servicos:currency=0 ; Fpgt_codigo:string='' ; Pedido:integer=0 ; valoripi:currency=0 ;
              seguro:currency=0 ; outrasdesp:currency=0 ; FornecInd:integer=0 ; pesoliq:currency=0 ; nfprodutor:string='' ;
              funrural:currency=0 ; cotacapital:currency=0 ; contagerencial:integer=0 ; romaneio:string='' ; obra:string='' ;
              cola_codigo:string='' ; km:integer=0  ; ContaCredito:integer=0  ; ACBrNFe1:TACBrNfe=nil ;
              xnumerodi:string='' ; xdatadi:TDatetime=0 ; xlocaldesem:string='';xdatadesem:TDatetime=0;xufdesem:string='';
              ctran_codigo:string='' ;cseto_codigo:string='' ; xchavecte:string='' ; xGrid:TSqlDtGrid=nil ; xValorGta:currency=0 ;
              xvlrINss:currency=0;xvlrpis:currency=0;xvlrcofins:currency=0;xvlrcsll:currency=0;xvlrir:currency=0);

    procedure GravaItensNFCompra(Emissao,Entrada: TDatetime; Fornecedor:TSqlEd ;
              Unidade, TipoMovimento,Transacao : string ; Numero: Integer ; Grid: TSqlDtGrid ;
              frete , seguro , peracre , perdesco:currency  ; total:currency=0 ;  Movimento:TDatetime=0  ; Pedido:integer=0 ;
              MontaBase:string='S'; Fornecind:integer=0 ; Baseicms:currency=0 ; Valoricms:currency=0 ; xcfop:string='' ;
              xcodmov:integer=0 ; ytipocad:string='F' ; obra:string='' ; totalprodutos:currency=0 ;xtiposmuda:string='' ;
              ArqXml:string='' ; xtotalicmsst:currency=0);

    function CalculaComissao(Repr:TSqled; CodigoCondicao:string ;Grid:TSqlDtgrid ; EdTabela:TSqlEd ; Unidade:string):currency;
    procedure GravaMovbase(Transacao:string ;Numerodoc:integer ; Cst,TipoImposto:string ;Baseicms,Valoricms,Aliquota,Reducaobase,Isentas,Outras: currency
              ; TipoMov:string  ; TpImposto:string='I' ; Unidade:string='' ; xcfop:string='');
    function GetNomeTipoCad(codigo:integer ; Tipocad:string ):string;
    function Validamesano(mesano:string):boolean;
    function Validaperiodo(mesano:string):boolean;
    function  PosicaoEstoqueAnterior(produto:string;tamanho,cor,copa:integer;unidade: string; DataInicial: TDatetime;Q:TSqlquery=nil):TSqlquery;
    function Anomesinvertido(mesano:string):string;
    function SaldoAnterior(conta:integer;unidade,campo:string;DataInicial:TDatetime):currency;
    procedure GravaMestreNFTrans(Emissao: TDatetime; UnidDestino: TSqlEd; Unidade, EntSai,
              TipoMovimento, Transacao, Natureza, ciffob,Especievolume: string;
              Numero,CodigoMov,QTdevolumes: Integer; Valortotal,baseicms,valoricms,basesubs,icmssubs,vlrfrete,pesoliq,pesobru: currency;simples:string;
              Movimento:TDatetime ; Mensagem:string='' ; Tran_codigo:string='' ; Pedidos:string='' ;
              pertran:currency=0 ; Romaneios:string=''; Fornecedor:TSqlEd=nil );

    procedure GravaItensNFTrans(Emissao: TDatetime; UnidDestino:TSqlEd ; Unidade,EntSai,
              TipoMovimento,Transacao : string ; Numero: Integer ; Grid: TSqlDtGrid ;
              frete , seguro :currency ; simples:string ; movimento:TDatetime ; Pedidos:string='' ;
              Romaneio:string='' ; EdCliente:TSqlEd=nil );
    function Buscapedcompra(Numero:Integer  ; tipomov:string=''  ; ordem:string='' ; EmAberto:string='N' ):String;
    function BuscaPendencia(TipoCod,Numero:Integer;PR:string ; Emissao:TDatetime):String;
///    procedure CopiaDbf(fonte,destino,arquivo:string);
    function BuscaNf(Numero: Integer; TipoMov: string ; Emissao:TDatetime=0 ; Unidade:string=''  ; cliente:integer=0 ; Entrada:TDatetime=0 ;xtransacao:string=''): String;
    function TextInvertidatodate(d:string):TDatetime;
///////////////////    function Exportanumeros(Valor: Currency; Tam, Decimais: integer ; Zeroesquerda:string='S' ; Ponto:string='N'): String;
    function Exportanumeros(Valor:Currency;Tam,Decimais:integer;Ponto:string='N';RetornavazioseZero:boolean=false):String;
    function GetRazSocialTipoCad(codigo: integer; Tipocad: string): string;
    function GetCnpjCpfTipoCad(codigo: integer; Tipocad: string): string;
    procedure GravaRetornoRomaneio(Emissao:TDatetime;Cliente:TSqlEd ;Representante:integer;
              Unidade,TipoMovimento,Transacao:string;Numero:Integer;Valortotal:currency; Grid:TSqlDtGrid ;
              QProdRemessa:TSqlquery ; EdRemessas : TSqled ; Condicao : string ; Movimento : TDatetime ; ValorVenda:currency);
    function GetSequencial(quantos:integer ; campo,tipocampo,tabela:string ):integer ;
    procedure PoeData(Ed:TSqled ; key:word);
    function GetDiasAtraso(vencimento,hoje:TDatetime):integer;
    procedure IncluiGrid(Grid:TSqlDtgrid ;codigo:string ; campocodigo:string='');
    function CalcDescAcre(valorbruto,perc:currency;tipo:string):currency;
    procedure ImpDevolucao(numero:integer;tipomov,semvideo:string ; unidade:string='');
    procedure Imprimesemvideo(nropaginas:integer=1);
    function TiraBarra(s: string ;  caracter:string='/' ;caracternolugar:string=''): string;
    function Getvalor( var Num:Currency ; titulo:string='' ):Boolean;
    function GetValorAvista(Listaprazo: Tstringlist ; valor:currency=0): currency;
    function GetDatainiciomes(Data:TDatetime):TDatetime;
    function EstaemAberto(campo,remessas:string):boolean;
    procedure SetaEdEntidade(EdCodtipo:TSqled ; TipoCad:string);
    function GetPrecoVenda(Codigoproduto,unidade:string):currency;
    function GetSqlBuscaCodigoGrade(Codigoproduto,unidade:string;cor,tamanho,copa:integer):string;
    procedure Fechatudo;
    function GetInscEstadualTipoCad(codigo: integer; Tipocad: string): string;
    function QualSerie(serieCM,serieunidade:string;tipomov:string=''):string;
    function SimilarTo(campo,variavel:string):string;
    procedure Checaremessas(codigo:integer;unidade:string);
    function Datetostringinvertida(data:Tdatetime):string;
    function DataStringinvertida(data:string):string;
    procedure SetaCodigosUnidades;
    function Gettipoentidade(tipocad:string):string;
    procedure ImpRemessa(numero:integer;tipomov,semvideo:string);
    function EstaAtivo(codigo:integer;tipocad:string; Data :TDatetime=0):boolean;
    function  TituloRelProduto(Produto: string): string;
    function  TituloRelCliRepre(Codigo: integer ; tipo:string): string;
    function RefazSaldofin(Datalan:TDatetime ; Conta:integer):boolean;
    procedure FazSaldofin(Datalan:TDatetime ; Conta:integer ; Unidade:string);
    function CustoGer(Unitario, vlricms, perfrete, vlripi, vlricmsfrete,perdesc,peracre: currency; simplesnacional:string='N'): currency;
    function Parabens(aniversario,datai,dataf:TDatetime):boolean;
    function Buscapedvenda(Numero:Integer  ; Numeros:string='' ; situacao:string=''; somestre:string='N') :String;
    function GetSqlDataentre(campo:string ; inicio,fim:TDatetime):String;
    function GetFormaEnvio(s:string):string;
    function ChecaCst(cst,simples:string):boolean;
    function GetCodfiscalunidade(unidade,df:string):string;
    function GetCodsittunidade(unidade,df:string):integer;
    function GetFormaPedido(s:string):string;
    function Convertetoin(s,separador:string ; sepjunto:string='N'):string;
    function GetPercAtendimento(qtdentregue,qtdpedida,dias:currency):currency;
    procedure SetaTribUnidades;   // 08.12.05
    function ValidaDentroPeriodo(data,datai,dataf:TDatetime):boolean;
    procedure FechaQuery(Q:TSqlquery); overload;
    procedure FechaQuery(Q:TMemoryQuery); overload;
    procedure SetaItemsSisVenda(Ed:TSqlEd);
    function GetMovimentoEstoque(tipo:string):string;
    function GetGeraFinanceiro(tipo:string):string;
    function GetCalculaIcms(tipo:string):string;
    function GetCalculaSubstit(tipo:string):string;
    function TituloGrupoproduto(grupos:string):string;
// 03.07.14
    function TituloSubGrupoproduto(grupos:string):string;
// 21.02.06
    function ChecaMostruario(Produto,TipoMov:string;Cliente,Numerodoc:integer):boolean;
// 02.03.06
    function ValidaGridVencimentos(Grid:TSqlDtGrid ; Fpgt_codigo:string='' ; OP:string=''):boolean;
// 13.03.06
    function UsuarioTeste(codigo:integer):boolean;
// 17.03.06
    procedure SetaItemsCategoria(Ed:TSqlEd);
// 06.04.06
    function GetEntSaiTipoMovtoEsFora(tipomovto: string): string;
    function EstoqueAnteriorEsFora(produto,unidade,tipo:string;DataInicial:TDatetime):currency;
// 12.05.06
    procedure PulalinhaRel(colunas:integer ; coluna1:integer=0 ; dados1:string='' ; coluna2:integer=0 ; dados2:string='' ;
              coluna3:integer=0 ; dados3:string='' ; coluna4:integer=0 ; dados4:string='' ; coluna5:integer=0 ; dados5:string=''
              ; coluna6:integer=0 ; dados6:string='');
// 23.05.06
    function GetVlrComissao(codtipo:integer ; tipocad:string ; datai,dataf:TDatetime  ; tiposfora:string='' ; tiposdentro:string=''):currency;
    procedure Checacontador(numero:integer ; serie:string ; datareferencia:TDatetime );

//    procedure EnviaEmail(ListaTitulos,ListaCabecalho1,Listacabecalho2:TStringlist ; nomerel:string);

    procedure RelacaoLogs;
    procedure SetaItems(Ed:TSqled ; nomerel:string);
    function GetValorJuros(capital:currency ; vencimento,baixa:TDatetime ; RecPag:string ):currency;
    procedure SetaCorEdits(tipoedit:boolean ; Form:TForm);
// 17.7.06
    function ProcessaComandos(TExto:String):String;
    function GeraHTML(Texto2:String):String;
// 18.07.06
//    function EnviaEMail(email,assunto,texto2,arquivo:string):Boolean;
    function EnviaEMail(email,assunto,arquivo:string;corpo:TStrings):Boolean;
// 18.08.06
    function ValidaGrade(cor,tamanho,copa:integer;Produto:string;checar:string=''):boolean;
// 21.08.06
    procedure MovimentaQtdeEstoqueGrade(Codigo,UNidade,EntSai,TipoMovimento : string ; xcodcor,xcodtamanho,xcodcopa:integer ;
              Qtde : currency ; Q:TSqlquery ; Qtdeprev : currency=0 ; xpecas:currency=0);
// 31.08.06
    procedure Apuravenda( Lista:TList ; produto:string ; codcor,codtamanho,codcopa:currency; qtde:currency ; tipomov:string );
// 04.09.06
    function UsuarioTesteGrade(codigo:integer):boolean;
// 01.02.07
    Function GetAtrasomedio(codigo:integer;tipocad:string;diaschecagem:integer;DataFinal:TDatetime;Unidades:string):integer;
// 26.03.07
    function GetMovimentoEs(tipo:string):string;
// 02.06.07
    Function Validalimitecredito(limite:currency):boolean;
// 02.08.07
    Function GetContaDespesa(transacao:string):integer;
// 01.10.07
    Procedure InicializaSistema;
// 08.10.07
    Procedure MovimentoEstoqueComposicao(unidade, produto, entsai,xtransacao,yTipoMovimento,xtipocad: string; qtde: extended; pecas: currency;xnumero,tipo_codigo:integer;xmovimento,xEntrada:TDatetime);
// 27.11.07
    Procedure SetaTiposdeEstoque(Edit:TSqled);
// 03.12.07
    procedure SetaSeriesValidas(Ed:TSqlEd);
// 29.04.08
    procedure SetaGradeCorTamanho(EditCodCor,EditCodTamanho:TSqled;Produto,Unidade:string);
// 11.06.08
    function CnpjcpfOK(c:string):boolean;
// 29.08.08
    procedure EstiloForm(Form:TForm);
// 24.09.08
    function GetVencimentoPadrao(v:TDatetime):Tdatetime;
// 24.11.08
    function ValidaLiberacaoLimite(usuario:integer):boolean;
// 27.11.08
    function ValidaLiberacaoFinan(usuario:integer ; tipo:string) : boolean;
// 28.11.08
    procedure NegaUsuarioOutrosAcessos(usuario:integer ; posicao:integer);
// 02.12.08
    function ValidaComissao(percomissao:currency):boolean;
// 30.12.08
    function CalculaCreditoCubicos(Produto,TipoFSC,Unidade:string ; Data:TDatetime=0):extended;
// 11.02.09
    procedure ConfiguraColorEditsNaoEnabled(Form:TForm;Size:integer=0;xcor:string='');
// 03.03.09
    procedure GravaMestreNFSaidaMO(Emissao: TDatetime; Cliente: TSqlEd;
              Representante: integer; Unidade, TipoMovimento, Transacao, Condicao, Natureza, ciffob,Especievolume: string;
              Numero,CodigoMov,QTdevolumes: Integer; Valortotal,baseicms,valoricms,basesubs,icmssubs,vlrfrete: currency; Tabela: Integer ;
              Movimento : TDatetime ; ValorProd,peracre,perdesco : currency ; romaneio:integer ; valoravista:currency ; remessas:string='' ;
              status:string='N' ; Mensagem:string='' ; Pedido:integer=0 ; tran_codigo:string=''  ; Pesoliq:currency=0 ; Pesobru:currency=0 ;
              moes_clie_codigo:integer=0 ; Valoripi:currency=0 ;Freteuni:currency=0 ; portoorigem:string='' ; portodestino:string='' ; container:string='' ;
              Representante2: integer=0 ;  TiposFornec:string='' ; aliiss:currency=0;vlrcofins:currency=0;vlrcsl:currency=0;vlrir:currency=0 );

    procedure GravaItensNFSaidaMO(Emissao: TDatetime; Cliente:TSqlEd ;
              Representante: integer; Unidade, TipoMovimento,Transacao : string ; Numero: Integer ; Grid: TSqlDtGrid ;
              frete , seguro , peracre , perdesco :currency  ; Movimento : TDatetime  ; remessas:string='' ; status:string='N' ;
              Pedido:integer=0 ; moes_clie_codigo:integer=0 ;cfop:string='' ; Consfinal:string='S' ; CodigoMov:integer=0 ;
               rtipocad:string='C');


// 01.04.09
    procedure ImprimelinhaRel(colunas:integer ; s:string);
// 17.04.09
    function FormatoObra(o:string):string;
// 24.05.09
    function ContaBloqueada(conta:integer;xContasBloqueadas:string):boolean;
    function ExisteTabela(tabela:string):boolean;
// 05.06.09
    function ValidaContadorNFSaida(numero:integer ; serie,unidade:string ; datareferencia:TDatetime ):boolean;
// 06.07.09
    procedure SetaTipoRepresentante(Edit:TSqlEd);
// 08.07.09
    function GetCampoNumerico(const s:string;valor:extended;xleft,xtop:integer):extended;
// 17.07.09
    function GetLocalExternoPea:string;
// 28.07.09
    function GetGeraFiscal(tipo:string):string;
// 13.08.09
    function GetValorJurosII(capital,taxamensal: currency; meses:integer; parcelaunica:string ):currency;
// 16.09.09
    procedure GravaItensNFSaidaSer(Emissao: TDatetime; Cliente:TSqlEd ;
              Representante: integer; Unidade, TipoMovimento,Transacao : string ; Numero: Integer ; ListaSer: TList ;
              frete , seguro , peracre , perdesco :currency  ; Movimento : TDatetime  ; remessas:string='' ; status:string='N' ;
              Pedido:integer=0 ; moes_clie_codigo:integer=0 ;cfop:string='' ; Consfinal:string='S' ; CodigoMov:integer=0 ;
              rtipocad:string='C');
// 05.11.09
   procedure SetaMovimento(Ed:TSqled);
// 07.12.09
   function GetEmailEntidade(Codigo:Integer;Categoria:String ; cemails:string=''):String;
// 15.03.10
   function GetSqlDataNula(campo:string):string;
   function ConverteHorasparaHorasDec( Qtde:currency ):currency;
// 22.04.10
   function GetUsaCliFor(tipo:string):string;
// 26.06.10
   function GetNroSerieCertificado(Unid_codigo:string):string;
// 01.07.10
   function EmailStmpcomSSL( emailorigem:string ) :boolean;
   function SemDllsSmtp:boolean;
// 25.10.10
    procedure ConfiguraTamanhoEditsEnabled(Form:TForm;Tamanho:integer);
// 11.11.10
    function SqlToQueryContax(Sql:String):TSQLQuery;
    function ConectaContax: boolean;
// 06.12.10
//    procedure EnviaEmailAcbr(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sFileName: AnsiString);
// 07.12.10
    function SendMime(const SMTPHost, Username, Password:string; const Mime: TMimeMess): string;
// 17.03.11
    procedure EmailClientePadrao(emaildestino,assunto,caminhoxml:string;CorpoEmail:TStrings);
// 18.03.11
    procedure AtualizaExcel;
// 06.06.11
//    procedure ImprimeCupomFiscal(xtransacao,TipoMovimento:string);

    function ConfiguradoECF:boolean;
// 23.06.11
    Procedure GravarINI ;
    Procedure LerINI ;
// 25.10.11
    Function GetConsumidorFinal(codigo:integer ; tipocad:string):string;
    Function GetPessoaFisica(codigo:integer ; tipocad:string):string;
// 07.03.12
    Procedure AbreEstoque;
// 06.09.12
    function GetIPInternet(var HostName, IPaddr, WSAErr: string): Boolean;
    function Func_GetIP_Net : string;
    function Func_GetIP_Lan:string;
// 26.11.12
    procedure GravaNotacomxml( NotaFiscal: TACBrNFe ;xarquivoxml,xunidade:string;aviso:boolean=false);
// 03.05.13 - Vivan
    function LimiteDisponivel( xcodigo:integer ):currency;
// 22.05.13 - Abra Cuiaba
    procedure PlanoAcaoSistema(numeroref:integer;Usuarios,xUnidade,xoque,xcomo:string;xvalor:currency=0;xquando:TDatetime=0 );
// 10.06.13
    procedure ExecutaHelp(xlocal:string);
// 19.07.13
    procedure SetaTabelaIBPT;
///////////////////////////////    procedure ArmazenaTabelaIBPT(yAcbrIbptax:TAcbrIbptax);
// 08.12.13
    function StrToPChar(const Str: string): PChar;
// 29.10.14 - Giacomoni
    function GetAliquotaFixaIcmsEstado(xUF:string):currency;
// 18.03.15 - Vivan
    function ValidaCadastro(xsituacao:string):boolean;
// 16.09.15
   procedure EnviaEMailcomAnexo(xemail: string; xListaAnexos:TStringList ; xCorpoEmailTexto: TStrings);
// 17.09.15
   function GetSerieNFCe:string;
// 21.06.16
   procedure GetContasExportacao(Vistaprazo, Es, tipomov,moes_tipocad,moes_transacao,moes_unid_codigo: string;
                                 CodigoMov,Moes_tipo_codigo,Moes_plan_codigo:integer ; var debito,credito: integer );
// 20.09.16
   function TemContaContabil(CodTipo:integer;tipoCad,xunidade,modulo:string):boolean;
// 12.10.16
   function PodeIncluirNF:boolean;
// 21.11.16
   procedure ColunasGrid(xgrid:TSqlGrid;xPainel:TForm);

  end;

procedure AnexarStr(var Str1:String;const Str2:String);

function GetFiscalDentro(unidade:string):string;    // 29.11.05
function GetFiscalFora(unidade:string):string;
function GetSittDentro(unidade:string):integer;
function GetSittFora(unidade:string):integer;


type TContadores=record
     TempoSenha,Timer:Integer;
     ConfigGeral,ConfigDctos:Integer;
end;

type TUsuario=record
     Nome,Senha:String;
     Codigo:Integer;
     Suporte,SenhaDiaria,Desenvolvimento:Boolean;
     ObjetosAcessados,OutrosAcessos:Array[0..4000] of Boolean;
     DocumentosAcessados,UnidadesMvto,ContasCaixaValidas,ContasAutPgto,UnidadesRelatorios,TiposDctosRelatorios:String;
end;

type TConfig1=record
     Nome,Tipo,Conteudo:String;
end;
type TPConfig1=^TConfig1;

type TParcFin=record
     CodigoFPgto:String;
     Vcto:TDateTime;
     Valor:Currency;
end;
type TPParcFin=^TParcFin;

type TSaldo=record
     Conta:Integer;
     Unidade:String;
     Valor,ValorMoeda:Currency;
end;
type TPSaldo=^TSaldo;

type TSaldoBco=record
     Conta:Integer;
     Valor:Currency;
end;
type TPSaldoBco=^TSaldoBco;

type TRatCC=record
     Conta,Controle,Parcela:Integer;
     CodigoCC,DebCre,Unidade:String;
     Valor:Currency;
end;
type TPRatCC=^TRatCC;

type TEntidades=record
     Categoria:String;
     Codigo,ContaContabil,CodigoMunicipio,CodVinc:Integer;
     Nome,Razao,CNPJCPF,InscricaoEstadual:String;
     Endereco,Bairro,CEP:String;
end;
type TPEntidades=^TEntidades;

type TGlobal=record
     CodigoUnidade,NomeUnidade,ReduzidoUnidade,UFUnidade,SerieUnidade,Unidadecuritiba,unidadebeltrao,
     unidadeijui,unidadecrisciuma,unidadejoinvile,unidadematriz,unidadeijui333,unidadematriz999,CstTransferencia,CstTransferenciaSC,
     unidadeexportacao,unidadefloripa,UnidadesTestes,SimplesUnidade:String;
     NomeSistema,VersaoSistema,UltimoFormAberto:String;
     Usuario:TUsuario;
     SistemaParado:Boolean;
     Contadores:TContadores;
     ReduzidoUnidades:Array[1..999] of String;
     EmpresaUnidades:Array[1..999] of String;
     Config1:TList;PConfig1:TPConfig1;
     Topicos:Array[0..4000] of Boolean;
     CodigosEspecificos:Array[1..9999] of Boolean;
     DiasNaoUteisAnteriores,ContaCTbTransNume,usuariopadrao,ContaJurosRecebidos,ContaJurosPagos,ContaDescontosConcedidos,
     ContaDescontosobtidos,ContaDescontosTarifaBan,ContaDescontosConcTarifaBan:Integer;
     DataMinima,DataMenorBanco:TDateTime;
     Entidades:TList;PEntidades:TPEntidades;
     EmpresaContabil:String;
     UltimaTransacao,UsaNfe,UsaNFCe:String;
     SeqTransacao,VCConfMov,VCHist,DVConfMov,CodContaVendaaVista,CodContaDevVenda,
     CodContaDevCompra:Integer;
     MensagemPendente:Boolean;
     CodigosLog:Array[1..100] of String;
     Gradientes:Boolean;
     CodRemessaConsig,CodDevolucaoConsig,CodVendaConsig,CodVendaDireta,CodCompra,CodDevolucaoCompra,
     CodAcertoEsEnt,CodAcertoEsSai,Cfopvces,Cfopvcfoes,Cfopvdes,Cfopvdfoes,Cfopcoes,Cfopcofoes,Cfopex,
     VCespecie,VCserie,VCCPgto,VCPort,VCComplehist,TiposMovMovEstoque,TiposMovMovEntrada,CodDevolucaoCompraSemEstoque,
     CodChequeDevolvido,CodDevolucaoSimbolicaConsig,CodCompraConsignado:string;
     CodVendaSemMovEstoque,CodCompraSemMovEstoque,CodVendaProntaEntrega,CodigoSubsTrib,CodVendaMagazine,
     Codvendainterna,CodConhecimento,TiposEntrada,TiposSaida,CodPendenciaFinanceira,FpgtoAntecipa,CodTransfEntrada,
     CodTransfSaida,CodVendaBrinde,CodTransImob,CodSimplesRemessa,CodRemessaProntaEntrega,CodTransImobE:string;
     CodCompra100,CodVendaTransf,CodCompraX,CodDevolucaoProntaEntrega,CodVendaSerie4,CodRomaSerie4,CodDevolucaoSerie5,
     CodVendaLiqSerie4,CodRemessaInd,CodDevolucaoInd,CodDevolucaoTroca,CodVendaRomaneio,CodVendaAmbulante,CodDevolucaoRoman,
     TiposGeraFinanceiro,CodDevolucaoVenda,CodDevolucaoConsigMerc,CodTransfEnt,CodTransfSai,
     CodVendaREFinal,CodVendaRE,CodVendaREBrinde,CodTransMatConsumoE,CodTransMatConsumoS,CodRemessaConserto,CodCompraImobilizado,
     CodCompraMatConsumo,CodVendaImobilizado,Codestolib,CodVendaMostruarioII,CodTransfEntradaTempo,CodTransfSaidaTempo :string;
     CodConsigMercantil,CodRetornoConsigMercanil,CodVendaConsigMercantil,CodVendaMostruario,CodRetornoMostruario,
     TiposNaoCalcSubsTrib,UltimaOperacaoBaixada,CodJurosRecebidos,CodDescontosDados,CodVendaProntaEntregaFecha,
     CodVendaPecaProblema,CodDevolucaoIgualVenda,CodVendaSemfinan,CodCompraSemfinan,TiposRelVenda,TiposRelDevVenda,
     CodDescontosTarifaban,CodMontagemKitS,CodMontagemKitE,CodContagemBalancoE,CodContagemBalancoS,TiposNaoCalcIcms,
     CodPedVenda,CodPedVendaMostruario,CodBaixaMatEnt,CodBaixaMatSai,CodVendaBrindeConsig,CodPedVendaMostruarioConsig,TiposNaoCalcIpi:string;
     DataUltimoEncerrPerCont:TDateTime;
     MargemSubsTrib:currency;
     UfComSubstituicao,CodTransfEntRetTempo,CodTransfSaiRetTempo,SisVenMagazine,SisVenConsignado,SisVenProntaEntrega,
     SisVenLimitado,CodDevolucaoVendaConsig,UsuariosdeTeste,CatSofisticado,CatBasico,CatLuxo,CodRetornoInd,
     CodRetornocomServicos,CodLanCaixabancos,CodComissaoRepr,CodPedVendaPE,UsuariosdeTesteGrade,CodCompraProdutor,
     CodRetornoRemessaConserto,CodDrawBackEnt,CodDrawBackSai,CodDesossaEnt,CodDesossaSai,CodContrato,
     CodRequisicaoAlmox,CodEntradaprocesso,CodSaidaprocesso,TipoEstoqueEmProcesso,CodContratoEntrega,EstoqueemProcesso,
     CodRemessaDemo,CodEntradaAlmox,CodOrdemProducao,CodItemObra,CodCompraIndustria,TiposRelCompra,CodCompraFutura,
     CodCompraRemessaFutura,CodDevolucaoSaida,CodEntradaSemItens,CodEntradaImobilizado,TiposNaoFiscal,
     CodSaidaAlmox,CodDevolucaoImob,CodDevolucaoSemFinan,CodVendaFornecedor,CodPrestacaoServicos,
     TiposExpContabNotas,CodSaidaGarantia,CodEntradaInd,CodRemessaIndPropria,CodEntradaBrinde,CodContratoNota:string;
     TiposExpFiscalNotas,CodContratoDoacao,CodCompraProdutorReclassifica,CodEntradaAcabado,
     CodRemessaDemoClientes,CodRemessaContraOrdem,CodDevolucaodeRemessa,CodRomaneioRemessaaOrdem,
     CodNotaRemessaaOrdem,CodVendaaOrdem,CodConhecimentoSaida,CodRetornoMercDepo,CodEstornoNFeSai,
     CodDevolucaoTributada,CodFaturaAgua,CodNfeComplementoQtde,CodNfeComplementoIcms,CodNfeComplementoValorProdutor :string;
     DataSistema:TDatetime;
     PlanoFiltrado,CodDevolucaoCompraProdutor,Impressora,CodPrestacaoServicosE,CodOrdemdeServico,
     CodManutencaoEquipamento,CodEntradaProdutor,CodCompraProdutorMerenda:string;
end;

type TCstPerc=record
     cst,tpimposto,cfop:string;
     perc,contabil,base,reducao,isentas,outras,basesubs:currency;
end;

type TUnidades=record
     Unidade,fiscaldentro,fiscalfora:string;
     sittdentro,sittfora:integer;
end;

// 16.09.09
type TServicos=record
     produto:string;
     qtde,unitario,periss:currency;
end;

// 06.12.10
type
  ESMTP = class (Exception);

// 19.07.13
type TabelaIBPT=record
     InfProduto:TACBrIBPTaxRegistro;
end;


var FGeral: TFGeral;
    Global:TGlobal;
    QSeq:TSQLDataSet;
    ListaCstPerc,ListaUnidades,ListaIBPT:TList;
    PCstPerc:^TCstPerc;
    GlobalUnidades:^TUnidades;
    campo:TDicionario;
    PTabelaIBPT:^TabelaIBPT;

//    ACBrECf1:TACBrECF;


//const f_qtdestoque : string = '#,###,###';  ]
//const f_qtdestoque : string = '#######';
// 23.01.07
const f_qtdestoque : string = f_quant2;
      maximocomple:integer=50;

//      ECFTeste_VERSAO = '2.01' ;
//      Estados : array[TACBrECFEstado] of string =
//        ('N�o Inicializada', 'Desconhecido', 'Livre', 'Venda',
//        'Pagamento', 'Relat�rio', 'Bloqueada', 'Requer Z', 'Requer X', 'Nao Fiscal' );
//       _C = 'tYk*5W@' ;


implementation

uses Hist, Usuarios, Init, Menuinicial, Arquiv,
  Unidades, Moedas, munic, Empresas, tamanhos, Grades, cadcor, Estoque,
  tabela, conpagto, plano, codigosfis, Transp, cadcli, fornece, represen,
  TextRel, SQLRel, impressao , confplano, Mensnf, Sittribu, ConfMovi,
  expnfetxt, codigosipi, nfcompra, grupos, portador, importanfe;

{$R *.dfm}



procedure TFGeral.FormCreate(Sender: TObject);
////////////////////////////////////////////////////////
var i:integer;
begin
  QSeq:=TSQLDataSet.Create(nil);
  QSeq.SQLConnection:=Sistema.Conexao;
//  QSeq.NoMetadata:=True;
  with Global do begin
    SistemaParado:=False;
    Usuario.Desenvolvimento:=GetIni('SAC','DESENVOLVIMENTO','DESENVOLVIMENTO')='S';
    Contadores.TempoSenha:=0;
    Contadores.Timer:=0;
    Config1:=TList.Create;
    Entidades:=TList.Create;
    for i:=1 to 9999 do CodigosEspecificos[i]:=False;
    MensagemPendente:=False;
    Gradientes:=False;
  end;
  SetaCodigosLog;
  SetaCodigosMovimento;
  SetaCodigosUnidades;
  Global.Usuariopadrao:=99;  // 23.05.05

{
  Global.Cfopvces:=FGeral.GetConfig1AsString('vccfopes');
  Global.Cfopvcfoes:=FGeral.GetConfig1AsString('vccfopfoes');
  Global.Cfopvdes:=FGeral.GetConfig1AsString('vdcfopes');
  Global.Cfopvdfoes:=FGeral.GetConfig1AsString('vdcfopfoes');
  Global.Cfopcoes:=FGeral.GetConfig1AsString('co]cfopes');
  Global.Cfopcofoes:=FGeral.GetConfig1AsString('cocfopfoes');
  Global.Cfopex:=FGeral.GetConfig1AsString('excfop');
  Global.VCespecie:='NFF';
  Global.VCserie:='1';
  Global.VCCPgto:='001';
}
  Global.VCPort:='';
  Global.VCHist:=0;
  Global.VCComplehist:='';
  Global.CodPendenciaFinanceira:='PF';
  Global.CodJurosRecebidos:='JR';
// 11.04.05 - conta padrao de Venda a vista do plano gerencial
// depois criar configuracao - este 'depois' so chegou em 01.10.07
//  Global.CodContaVendaaVista:=11;
// 12.04.05 - conta padrao de Devolu��o de Venda do plano gerencial
// depois criar configuracao
  Global.CodContaDevVenda:=82;
  Global.CodDescontosDados:='DD';
  Global.ContaCTbTransNume:=10062;
{
// 17.08.05
  Global.ContaJurosRecebidos:=13;
// 13.09.05
////////////////////////////////
  Global.ContaJurosPagos:=62;
  Global.ContaDescontosConcedidos:=59;
  Global.ContaDescontosobtidos:=14;
}

// 21.09.05
  Global.CodContaDevCompra:=100;
// 10.03.08
// 23.09.05
  Global.TiposRelVenda:=Global.CodVendaConsig+';'+global.CodVendaDireta+';'+global.CodVendaProntaEntrega+';'+global.CodVendaSemMovEstoque+';'+
                  global.CodVendaMagazine+';'+Global.CodVendaProntaEntregaFecha+';'+Global.CodVendaPecaProblema+
                  ';'+global.CodVendaREFinal+';'+global.CodVendaRE+';'+Global.CodVendaMostruarioII+';'+Global.CodVendaFornecedor+';'+
                  Global.CodPrestacaoServicos+';'+Global.CodContrato+';'+Global.CodContratoNota+';'+
                  Global.CodVendaaOrdem;
// - 23.11.05 - retirado - reges      ';'+Global.CodVendaConsigMercantil+';'+
// - 30.11.05 - ';'+Global.codvendaambulante+ - reges
// 09.05.11  - retirado ajustes mama ';'+global.Codvendainterna+

// 28.09.05 - para liberar digita��o do valor unitario
  Global.Codestolib:='99999';
// 29.09.05
  Global.TiposRelDevVenda:=global.CodDevolucaoVenda+';'+Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoVendaConsig+';'+
                           Global.codDevolucaoSimbolicaConsig+';'+Global.CodEstornoNFeSai;
// 27.10.05
  Global.ContaDescontosConcTarifaBan:=107;  // a mesma...107 - 28.11.05
  Global.ContaDescontosTarifaBan:=107;
  Global.UfComSubstituicao:='SC;RS;PR';  // 24.03.16 - ver se precisa criar configuracao
// 14.02.06
  Global.SisVenMagazine:='MA';
  Global.SisVenConsignado:='CO';
  Global.SisVenProntaEntrega:='PE';
  Global.SisVenLimitado:='LI';
// 13.03.06
//  Global.UsuariosdeTeste:='300;001';
// 17.09.09
  Global.UsuariosdeTeste:='XXX';
// 17.03.06
  Global.CatSofisticado:='SF';
  Global.CatBasico:='BA';
  Global.CatLuxo:='LX';
// 22.05.06
  Global.CodLanCaixabancos:='LC';
// 26.05.06
  Global.CodComissaoRepr:='CR';
// 04.09.06
//  Global.UsuariosdeTesteGrade:='013;014;300';
// 17.09.09
  Global.UsuariosdeTesteGrade:='QQQ';
// 03.08.07
  Global.CodChequeDevolvido:='CD';  // para uso no movfin
// 28.11.07
  Global.EstoqueemProcesso:='01';
// 28.03.08
  Global.TiposRelCompra:=Global.CodCompra+';'+Global.CodCompraSemMovEstoque+';'+
                Global.CodConhecimento+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+Global.CodCompraImobilizado+';'+
                Global.CodCompraMatConsumo+';'+Global.Codcompraprodutor+';'+Global.CodEntradaSemItens+';'+
                Global.CodEntradaInd+';'+Global.CodEntradaprodutor+';'+Global.CodCompraProdutorMerenda;

  Global.PlanoFiltrado:='N';
////////////////////////////////
// movMOVestoque e movMOVentrada para ver quando movimenta ou n�o quantidades do estoque

  Global.TiposMovMovEstoque:=Global.CodRemessaConsig+';'+Global.CodDevolucaoConsig+';'+Global.CodVendaDireta+';'+
                             Global.CodDevolucaoCompra+';'+Global.CodAcertoEsEnt+';'+
                             Global.CodAcertoEsSai+';'+Global.CodVendaMagazine+';'+Global.Codvendainterna+
                             ';'+Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodSimplesRemessa+';'+
                             Global.CodRemessaProntaEntrega+';'+Global.CodCompra100+';'+
                             Global.CodCompraX+';'+Global.CodDevolucaoProntaEntrega+';'+
                             Global.CodVendaSerie4+';'+Global.CodDevolucaoSerie5+';'+
                             Global.CodRemessaInd+';'+Global.CodDevolucaoInd+';'+
                             Global.CodDevolucaoTroca+';'+Global.CodDevolucaoVenda+';'+
                             Global.CodVendaMostruario+';'+Global.CodRetornoMostruario+';'+Global.CodVendaBrinde+';'+
                             Global.CodTransImobE+';'+Global.CodVendaPecaProblema+';'+Global.CodDevolucaoIgualVenda+';'+
                             Global.CodVendaSemfinan+';'+Global.CodCompraSemfinan+';'+Global.CodVendaMostruarioII+';'+
                             Global.CodMontagemKitE+';'+Global.CodMontagemKitS+';'+Global.CodContagemBalancoE+';'+
                             Global.CodContagemBalancoS+';'+Global.CodTransfEntradaTempo+';'+
                             Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodVendaBrindeConsig+';'+
                             Global.CodTransfSaiRetTempo+';'+Global.CodDevolucaoVendaConsig+';'+
                             Global.CodTransMatConsumoS+';'+Global.CodTransMatConsumoE+';'+
                             Global.CodRetornoInd+';'+Global.CodCompraProdutor+';'+Global.CodDesossaEnt+';'+
                             Global.CodDesossaSai+';'+Global.CodDrawBackEnt+';'+Global.CodDrawBackSai+';'+
                             Global.CodContratoEntrega+';'+Global.CodEntradaAlmox+';'+
                             Global.CodCompraRemessaFutura+';'+Global.CodDevolucaoSaida+';'+Global.CodEntradaImobilizado+';'+
                             Global.CodSaidaAlmox+';'+Global.CodDevolucaoSemFinan+';'+Global.CodVendaFornecedor+';'+
                             Global.CodSaidaGarantia+';'+Global.CodCompraProdutorReclassifica+';'+Global.CodEntradaAcabado+';'+
                             Global.CodDevolucaoCompraProdutor+';'+Global.CodDevolucaoSimbolicaConsig+';'+
                             Global.CodCompraConsignado+';'+Global.CodDevolucaodeRemessa+';'+Global.CodRetornoMercDepo+';'+
                             Global.CodEstornoNFeSai+';'+Global.CodOrdemdeServico+';'+Global.CodDevolucaoTributada+';'+
                             Global.CodEntradaProdutor+';'+Global.CodCompraProdutorMerenda;



//  Global.TiposMovMovEntrada:=Global.CodDevolucaoConsig+';'+Global.CodCompra+';'+Global.CodAcertoEsEnt+';'+
  Global.TiposMovMovEntrada:=Global.CodDevolucaoConsig+';'+Global.CodAcertoEsEnt+';'+
                             Global.CodTransfEntrada+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+
                             Global.CodDevolucaoProntaEntrega+';'+Global.CodDevolucaoSerie5+';'+
                             ';'+Global.CodDevolucaoTroca+';'+
                             Global.CodDevolucaoVenda+';'+Global.CodBaixaMatEnt+    // 07.12.05
                             ';'+Global.CodRetornoMostruario+';'+Global.CodTransImobE+';'+
                             Global.CodCompraSemfinan+';'+Global.CodCompraMatConsumo+';'+Global.CodMontagemKitE+';'+
                             Global.CodTransfEntradaTempo+';'+Global.CodDevolucaoVendaConsig+';'+
                             Global.CodTransMatConsumoE+';'+Global.CodRetornoInd+';'+Global.CodDevolucaoInd+';'+
                             Global.CodCompraProdutor+';'+Global.CodDesossaEnt+';'+Global.CodDrawBackEnt+';'+Global.CodEntradaAlmox+';'+
                             Global.CodCompraRemessaFutura+';'+Global.CodEntradaImobilizado+';'+Global.CodDevolucaoSemFinan+';'+
                             Global.CodEntradaInd+';'+Global.CodCompraProdutorReclassifica+';'+Global.CodEntradaAcabado+';'+
                             Global.CodCompraConsignado+';'+Global.CodDevolucaodeRemessa+';'+Global.CodRetornoMercDepo+';'+
                             Global.CodEstornoNFeSai+';'+Global.CodFaturaAgua+';'+Global.CodEntradaProdutor+';'+
                             Global.CodCompraProdutorMerenda+';'+Global.CodDevolucaoIgualVenda;


  Global.TiposGeraFinanceiro:=Global.CodVendaDireta+';'+Global.CodCompra+';'+Global.CodDevolucaoCompra+';'+
                              Global.CodVendaMagazine+';'+Global.Codvendainterna+';'+Global.CodCompra100+';'+
                              Global.CodCompraX+';'+Global.CodVendaProntaEntrega+';'+Global.CodVendaProntaEntregaFecha+';'+
                              Global.CodDevolucaoVenda+';'+Global.CodVendaConsig+';'+global.CodVendaConsigMercantil+
                              ';'+Global.CodVendaPecaProblema+';'+Global.CodVendaRE+';'+Global.codvendaREfinal+';'+
                              Global.CodVendaREBrinde+';'+Global.CodCompraMatConsumo+';'+Global.CodCompraImobilizado+
                              ';'+Global.CodVendaImobilizado+';'+Global.CodConhecimento+';'+Global.CodVendaAmbulante+';'+
                              Global.CodDevolucaoIgualVenda+';'+Global.CodVendaMostruarioII+';'+Global.CodDevolucaoCompraSemEstoque+';'+
                              Global.CodDevolucaoVendaConsig+';'+Global.CodRetornocomServicos+';'+Global.CodCompraProdutor+';'+
                              Global.CodContrato+';'+Global.CodDrawBackSai+';'+Global.CodCompraIndustria+';'+Global.CodCompraFutura+
                              ';'+Global.CodEntradaSemItens+';'+Global.CodEntradaImobilizado+';'+Global.CodDevolucaoImob+';'+
                              Global.CodVendaFornecedor+';'+Global.CodPrestacaoServicos+';'+Global.CodContratoNota+';'+
                              Global.CodDevolucaoCompraProdutor+';'+Global.CodVendaaOrdem+';'+Global.CodConhecimentoSaida+';'+
                              Global.CodFaturaAgua+';'+Global.CodEntradaProdutor+';'+Global.CodCompraProdutorMerenda+';'+
                              Global.CodNfeComplementoValorProdutor+';'+Global.CodPrestacaoServicosE;

  Global.TiposNaoCalcSubsTrib:=global.CodVendaMostruario+';'+global.codretornomostruario+';'+global.CodRetornoConsigMercanil+
                               ';'+global.CodVendaConsigMercantil+';'+global.CodDevolucaoConsigMerc+';'+global.CodDevolucaoRoman+';'+
                               ';'+Global.CodConsigMercantil+';'+Global.CodTransfEntradaTempo+';'+
                               Global.CodTransfSaidaTempo+';'+Global.CodTransfEntRetTempo+';'+Global.CodTransfSaiRetTempo+
                               ';'+Global.CodTransImob+';'+Global.CodTransImobE+';'+Global.CodRemessaInd+';'+Global.CodDevolucaoInd+';'+
                               Global.CodTransMatConsumoS+';'+Global.CodTransMatConsumoE+';'+Global.CodVendaBrindeConsig+';'+Global.CodRetornoInd+';'+
                               Global.CodRemessaConserto+';'+Global.CodRetornoRemessaConserto+';'+Global.CodDrawBackEnt+';'+';'+
                               Global.CodDrawBackSai+';'+Global.CodRequisicaoAlmox+';'+Global.CodRemessaDemo+';'+Global.CodEntradaAlmox+';'+
                               Global.CodSaidaAlmox+';'+Global.CodSaidaGarantia+';'+Global.CodDevolucaoCompraProdutor+';'+Global.CodRemessaContraOrdem+';'+
                               Global.CodRomaneioRemessaaOrdem+';'+Global.CodFaturaAgua ;
//25.08.06 - VENDA de mostruario tem subst...REMESSA n�o...
// global.CodVendaMostruarioII
  Global.TiposNaoCalcIcms:=Global.CodTransfSaidaTempo+';'+Global.CodTransfEntradaTempo+';'+Global.CodTransfEntRetTempo+';'+
                           Global.CodTransfSaiRetTempo+';'+Global.CodTransImob+';'+Global.CodTransImobE+';'+Global.CodRemessaInd+';'+Global.CodDevolucaoInd+';'+
                           Global.CodTransMatConsumoS+';'+Global.CodTransMatConsumoE+';'+Global.CodRetornoInd+';'+Global.CodRemessaConserto+';'+
                           Global.CodRetornoRemessaConserto+';'+Global.CodDrawBackEnt+';'+Global.CodDrawBackSai+';'+Global.CodRequisicaoAlmox+';'+
                           Global.CodRemessaDemo+';'+Global.CodEntradaAlmox+';'+Global.CodSaidaAlmox+';'+Global.CodPrestacaoServicos+';'+
                           Global.CodSaidaGarantia+';'+Global.CodRemessaContraOrdem+';'+Global.CodPrestacaoServicosE+';'+
                           Global.CodDevolucaoSimbolicaConsig+';'+Global.CodCompraConsignado+';'+Global.CodNfeComplementoQtde+
                           ';'+Global.CodNfeComplementoValorProdutor;
// 18.03.10
  Global.TiposNaoCalcIpi:=Global.CodTransfSaidaTempo+';'+Global.CodTransfEntradaTempo+';'+Global.CodTransfEntRetTempo+';'+
                           Global.CodTransfSaiRetTempo+';'+Global.CodTransImob+';'+Global.CodTransImobE+';'+Global.CodRemessaInd+';'+Global.CodDevolucaoInd+';'+
                           Global.CodTransMatConsumoS+';'+Global.CodTransMatConsumoE+';'+Global.CodRetornoInd+';'+Global.CodRemessaConserto+';'+
                           Global.CodRetornoRemessaConserto+';'+Global.CodDrawBackEnt+';'+Global.CodDrawBackSai+';'+Global.CodRequisicaoAlmox+';'+
                           Global.CodRemessaDemo+';'+Global.CodEntradaAlmox+';'+Global.CodSaidaAlmox+';'+Global.CodPrestacaoServicos+';'+
                           Global.CodSaidaGarantia+';'+Global.CodRemessaContraOrdem+';'+Global.CodRemessaInd+';'+Global.CodPrestacaoServicosE+';'+
                           Global.CodNfeComplementoQtde+';'+Global.CodNfeComplementoIcms+';'+Global.CodNfeComplementoValorProdutor ;


//  +Global.CodRomaSerie4;

///     CodVendaLiqSerie4 // nao movimenta o estoque so 'acerta' o financeiro
  Global.MargemSubsTrib:=40;  // ate ver onde deixar configur�vel...
  Global.CodigoSubsTrib:='4';   // ate ver se poe configura�ao
  Global.TiposEntrada:=Global.TiposMovMovEntrada+';'+Global.CodConhecimento+';'+Global.CodDevolucaoSerie5+';'+Global.CodDevolucaoRoman+
                       ';'+Global.CodTransfEnt+';'+Global.CodTransMatConsumoE+';'+Global.CodCompraImobilizado+';'+
                       Global.CodCompraSemfinan+';'+Global.CodCompraSemMovEstoque+';'+Global.CodDevolucaoConsigMerc+';'+
                       Global.CodCompra+';'+Global.CodMontagemKitE+';'+Global.CodContagemBalancoE+';'+Global.CodTransfEntRetTempo+
                       ';'+Global.CodTransfEntradaTempo+';'+Global.CodRetornocomServicos+';'+Global.CodCompraProdutor+';'+
                       Global.CodRetornoRemessaConserto+';'+Global.CodDrawBackEnt+';'+Global.CodEntradaprocesso+';'+Global.CodCompraIndustria+';'+
                       Global.CodCompraFutura+';'+Global.CodEntradaSemItens+';'+Global.CodEntradaImobilizado+';'+
                       Global.CodDevolucaoImob+';'+Global.CodEntradaInd+';'+Global.CodEntradaBrinde+';'+
                       Global.CodPrestacaoServicosE+';'+Global.CodNfeComplementoValorProdutor;


  Global.TiposSaida:=Global.CodRemessaConsig+';'+Global.CodVendaDireta+';'+
                     Global.CodDevolucaoCompra+';'+Global.CodAcertoEsSai+';'+Global.CodVendaMagazine+';'+
                     Global.Codvendainterna+';'+Global.CodTransfSaida+';'+Global.CodRemessaProntaEntrega+';'+
                     Global.CodVendaTransf+';'+Global.CodVendaSerie4+';'+Global.CodRemessaInd+';'+Global.CodVendaRomaneio+';'+
                     Global.CodVendaAmbulante+';'+Global.CodVendaConsig+';'+Global.CodVendaSemMovEstoque+';'+
                     Global.CodVendaProntaEntrega+';'+Global.CodVendaBrinde+';'+Global.CodTransImob+';'+
                     global.codconsigmercantil+';'+global.codvendaconsigmercantil+';'+global.codvendamostruario+';'+
                     global.CodVendaProntaEntregaFecha+';'+Global.CodTransfSai+';'+Global.CodVendaPecaProblema+';'+
                     Global.CodVendaRE+';'+Global.codvendaREfinal+';'+Global.CodVendaREBrinde+';'+Global.CodTransMatConsumoS+
                     ';'+Global.CodRemessaConserto+';'+Global.CodVendaImobilizado+';'+Global.CodVendaSemfinan+';'+
                     Global.CodVendaMostruarioII+';'+Global.CodVendaMostruario+';'+Global.CodDevolucaoCompraSemEstoque+';'+
                     Global.CodMontagemKitS+';'+Global.CodContagemBalancoS+';'+Global.CodBaixaMatSai+';'+Global.CodVendaBrindeConsig+
                     ';'+Global.CodTransfSaiRetTempo+';'+Global.CodTransfSaidaTempo+';'+Global.CodRemessaInd+';'+
                     Global.CodTransMatConsumoS+';'+Global.CodDrawBackSai+';'+Global.CodContrato+';'+Global.CodRequisicaoAlmox+';'+
                     Global.CodSaidaprocesso+';'+Global.CodContratoEntrega+';'+Global.CodRemessaDemo+';'+Global.CodDevolucaoSaida+';'+
                     Global.CodVendaFornecedor+';'+Global.CodPrestacaoServicos+';'+Global.CodSaidaGarantia+';'+
                     Global.CodRemessaIndPropria+';'+Global.CodContratoNotA+';'+Global.CodSimplesRemessa+';'+
                     Global.CodContratoDoacao+';'+Global.CodDevolucaoCompraProdutor+';'+Global.CodRemessaDemoClientes+';'+
                     Global.CodRemessaContraOrdem+';'+Global.CodDevolucaoSimbolicaConsig+';'+Global.CodRomaneioRemessaaOrdem+';'+
                     Global.CodNotaRemessaaOrdem+';'+Global.CodVendaaOrdem+';'+Global.CodConhecimentoSaida+';'+
                     Global.CodOrdemdeServico+';'+Global.CodDevolucaoTributada+';'+Global.CodNfeComplementoQtde+';'+
                     Global.CodNfeComplementoIcms;

// 27.11.07
  Global.TipoEstoqueEmProcesso:=Global.CodEntradaprocesso+';'+Global.CodSaidaprocesso;
// 12.09.08
  Global.tiposNaoFiscal:=Global.TipoEstoqueEmProcesso+';'+Global.CodContagemBalancoE+';'+Global.CodContagemBalancoS+';'+
                         global.CodContrato+';'+Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai+';'+
                         Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaAcabado+';'+
                         Global.CodRomaneioRemessaaOrdem+';'+Global.Codvendainterna+';'+Global.CodPrestacaoServicosE; ;
// 08.06.11
//  ACBrECF1:=TACBrECF.Create(self);

end;

procedure TFGeral.FormDestroy(Sender: TObject);
begin
  QSeq.Close;
  QSeq.Free;
  with Global do begin
    Config1.Free;
    Entidades.Free;
  end;
end;


procedure TFGeral.ProcessaMensagem(var Msg: tagMSG; var Handled: Boolean);
begin
  if (Msg.Message=WM_MOUSEMOVE) or (Msg.Message=WM_SYSKEYDOWN) or (Msg.Message=WM_KEYDOWN) then begin
     Global.Contadores.TempoSenha:=0;
  end;
  if (not Sistema.Processando) and (Msg.Message=WM_KEYDOWN) then begin
//     if Msg.wParam=VK_F2 then FCalcMat.Execute;
//     if Msg.wParam=VK_F3 then FCalend.Show;
     if Msg.wParam=VK_F9 then FGeral.Fechatudo;
//////////////////////// 04.07.08
     if Msg.wParam=VK_F7 then begin
        FCadcli.Show;
        Msg.wParam:=0;
     end;
     if Msg.wParam=VK_F8 then begin
        FFornece.Show;
        Msg.wParam:=0;
     end;

/////////////////////////
  end;
end;


procedure TFGeral.AtualizarEstacao;
begin
  if FGeral.ConsultaContador('ConfigGeral')>Global.Contadores.ConfigGeral then InicializaConfig1;
//  if FGeral.ConsultaContador('ConfigDctos')>Global.Contadores.ConfigDctos then FMovDctos.SetaDocumentos;
  RefreshTabelas;
end;


procedure TFGeral.TimeGeralTimer(Sender: TObject);
begin
  Inc(Global.Contadores.Timer);
  Inc(Global.Contadores.TempoSenha);
  if (not Global.SistemaParado) and (not Sistema.Processando) then begin
     if (FGeral.GetConfig1AsInteger('TempoSenha')>0) and ((Global.Contadores.TempoSenha div 3)>FGeral.GetConfig1AsInteger('TempoSenha')) then begin
        if not Global.Usuario.Suporte then FUsuarios.GetSenhaTempo;
        Global.Contadores.TempoSenha:=0;
     end;
     if Global.Contadores.Timer mod 3=0 then TestaFinalizacaoAutomatica;
     if Global.Contadores.Timer mod 15=0 then AtualizarEstacao;
     if Global.Contadores.Timer mod 17=0 then AlertaMensagem;
     if Global.Contadores.Timer mod 45=0 then begin
        Sistema.Hoje:=FGeral.GetDataServidor;
        FMain.PData.Caption:=DateToStr_(Sistema.Hoje);
     end;
  end;
end;

procedure TFGeral.TestaFinalizacaoAutomatica;
var Q:TSqlQuery;

   procedure FinalizaSistema;
   begin
      if Global.Contadores.TempoSenha>=3 then begin
         Sistema.Finalizando:=True;
         Application.Terminate;
      end;
   end;

begin
  if not FMain.PFinalizar.Visible then begin
     Q:=SqlToQuery('SELECT Ctrl_UsuExclusivo FROM Controle WHERE Ctrl_Registro=1');
     if (Q.FieldByName('Ctrl_UsuExclusivo').AsInteger>0) and (Q.FieldByName('Ctrl_UsuExclusivo').AsInteger<>Global.Usuario.Codigo) then begin
        FMain.PFinalizar.Visible:=True;
     end else begin
        FMain.PFinalizar.Visible:=False;
     end;
     Q.Close;Q.Free;
  end else begin
     FinalizaSistema;
  end;
end;




function TFGeral.GetContadorOld(Nome:String;DigitoVerificador:Boolean):Integer;
var TD:TTransactionDesc;
begin
  Randomize;
  TD.TransactionID:=Random(100000);
  TD.GlobalID:=Random(100000);
  TD.IsolationLevel:=xilREADCOMMITTED;
  QSeq.Close;
  QSeq.CommandText := 'SELECT Cont_Posicao FROM Contadores WHERE Cont_Nome='+StringToSql(UpperCase(Trim(Nome)));
  QSeq.Open;
  if QSeq.IsEmpty then begin
     Result:=1;
     QSeq.Close;
     Sistema.Conexao.StartTransaction(TD);
     Sistema.Conexao.ExecuteDirect('INSERT INTO Contadores (Cont_Nome,Cont_Posicao) VALUES('+StringToSql(UpperCase(Trim(Nome)))+',1)');
     Sistema.Conexao.Commit(TD);
  end else begin
     Result:=QSeq.FieldByName('Cont_Posicao').AsInteger+1;
     QSeq.Close;
     Sistema.Conexao.StartTransaction(TD);
     Sistema.Conexao.ExecuteDirect('UPDATE Contadores SET Cont_Posicao='+IntToStr(Result)+' WHERE Cont_Nome='+StringToSql(UpperCase(Trim(Nome))));
     Sistema.Conexao.Commit(TD);
  end;
  QSeq.Close;
  if DigitoVerificador then Result:=StrToInt(IntToStr(Result)+GetDigito(IntToStr(Result),'MOD'));
end;


function TFGeral.GetContador(Nome:String;DigitoVerificador:Boolean;Atualiza:Boolean=True):Integer;
begin
  if Atualiza then
    Result:=GetSequencia(Nome,True)
  else
    Result:=GetSequencia(Nome,False);
  if DigitoVerificador then Result:=StrToInt(IntToStr(Result)+GetDigito(IntToStr(Result),'MOD'));
end;

procedure TFGeral.AlteraContador(Nome:String;Posicao:Integer);
begin
  SetSequencia(Nome,Posicao);
end;

function TFGeral.ConsultaContador(Nome:String):Integer;
begin
  Result:=GetSequencia(Nome,False);
end;

{
function TFGeral.GetContador(Nome:String;DigitoVerificador:Boolean):Integer;
var TD:TTransactionDesc;

  procedure IniciaTransacao;
  begin
    Randomize;
    TD.TransactionID:=Random(100000);
    TD.GlobalID:=Random(100000);
    TD.IsolationLevel:=xilREADCOMMITTED;
    Sistema.Conexao.StartTransaction(TD);
  end;

  procedure IncluiRegistro;
  begin
    QSeq.Close;
    IniciaTransacao;
    Sistema.Conexao.ExecuteDirect('INSERT INTO Contadores (Cont_Nome,Cont_Posicao) VALUES('+StringToSql(UpperCase(Trim(Nome)))+',1)');
    Sistema.Conexao.Commit(TD);
  end;

  procedure AlteraRegistro(Cont:Integer);
  begin
    QSeq.Close;
    IniciaTransacao;
    Sistema.Conexao.ExecuteDirect('UPDATE Contadores SET Cont_Posicao='+IntToStr(Cont)+' WHERE Cont_Nome='+StringToSql(UpperCase(Trim(Nome))));
    Sistema.Conexao.Commit(TD);
  end;

begin
  QSeq.Close;
  QSeq.CommandType:=ctQuery;
  if Sistema.TypeServer=tsPostGreSQL then begin
     try
       IniciaTransacao;
       Sistema.Conexao.ExecuteDirect('Lock Table Contadores In Access Exclusive Mode');
       QSeq.CommandText:='SELECT GetContador('+StringToSql(UpperCase(Trim(Nome)))+') AS Proximo';
       QSeq.Open;
       Result:=QSeq.FieldByName('Proximo').AsInteger;
       QSeq.Close;
       Sistema.Conexao.Commit(TD);
     except
       Sistema.Conexao.Rollback(TD);
       Result:=GetContadorOld(Nome,DigitoVerificador);
     end;
  end else if Sistema.TypeServer=tsOracle then begin
     QSeq.CommandType:=ctStoredProc;
     QSeq.CommandText:='GETCONTADOR';
     QSeq.Params.ParamValues['pNome']:=UpperCase(Trim(Nome));
     QSeq.ExecSQL;
     Result:=Inteiro(QSeq.Params.ParamValues['pResult']);
  end else if Sistema.TypeServer=tsInterbase then begin
     QSeq.CommandText:='Select * From GetContador('+StringToSql(UpperCase(Trim(Nome)))+')';
     QSeq.Open;
     Result:=QSeq.FieldByName('Resultado').AsInteger;
  end else begin
     QSeq.CommandText:='SELECT Cont_Posicao FROM Contadores WHERE Cont_Nome='+StringToSql(UpperCase(Trim(Nome)));
     QSeq.Open;
     if QSeq.IsEmpty then begin
        Result:=1;
        IncluiRegistro;
     end else begin
        Result:=QSeq.FieldByName('Cont_Posicao').AsInteger+1;
        AlteraRegistro(Result);
     end;
  end;
  QSeq.Close;
  QSeq.CommandType:=ctQuery;
  if DigitoVerificador then Result:=StrToInt(IntToStr(Result)+GetDigito(IntToStr(Result),'MOD'));
end;


procedure TFGeral.AlteraContador(Nome:String;Posicao:Integer);
begin
  QSeq.Close;
  QSeq.CommandText := 'SELECT Cont_Posicao FROM Contadores WHERE Cont_Nome='+StringToSql(UpperCase(Trim(Nome)));
  QSeq.Open;
  if QSeq.IsEmpty then begin
     Sistema.Conexao.ExecuteDirect('INSERT INTO Contadores (Cont_Nome,Cont_Posicao) VALUES('+StringToSql(UpperCase(Trim(Nome)))+','+IntToStr(Posicao)+')');
     Sistema.Commit;
  end else begin
     Sistema.Conexao.ExecuteDirect('UPDATE Contadores SET Cont_Posicao='+IntToStr(Posicao)+' WHERE Cont_Nome='+StringToSql(UpperCase(Trim(Nome))));
     Sistema.Commit;
  end;
  QSeq.Close;
end;

function TFGeral.ConsultaContador(Nome:String):Integer;
begin
  QSeq.Close;
  QSeq.CommandText := 'SELECT Cont_Posicao FROM Contadores WHERE Cont_Nome='+StringToSql(Trim(UpperCase(Nome)));
  QSeq.Open;
  Result:=QSeq.FieldByName('Cont_Posicao').AsInteger;
  QSeq.Close;
end;
}


function TFGeral.GetTransacao:String;
begin
  Result:=Global.CodigoUnidade+IntToStr(GetContador('Transacao'+Global.CodigoUnidade,False));
  Result:=Result+GetDigito(Result,'MOD');
  Global.UltimaTransacao:=Result;
  Global.SeqTransacao:=0;
  CopyToClipBoard(Result);
end;

function TFGeral.GetOperacao:String;
begin
  Inc(Global.SeqTransacao);
  Result:=Global.UltimaTransacao+IntToStr(Global.SeqTransacao);
end;

function TFGeral.GetContadorImpresso(CodImpresso:String):Integer;
var n:String;
begin
  Result:=0;
  if Trim(CodImpresso)='' then Exit;
  if not Arq.TImpressos.Active then Arq.TImpressos.Open;
  if not Arq.TImpressos.Locate('Impr_Codigo',CodImpresso,[]) then begin
     AvisoErro('Impresso n�o cadastrado: '+CodImpresso);
     Exit;
  end;
  n:=Trim(UpperCase(Arq.TImpressos.FieldByName('Impr_NomeContador').AsString));
  if n<>'' then begin
     if Arq.TImpressos.FieldByName('Impr_Geral').AsString='U' then n:=n+Global.CodigoUnidade;
     Result:=GetContador(n,False);
  end;
end;

procedure TFGeral.AlteraContadorImpresso(CodImpresso:String;Posicao:Integer);
var n:String;
begin
  if not Arq.TImpressos.Active then Arq.TImpressos.Open;
  if not Arq.TImpressos.Locate('Impr_Codigo',CodImpresso,[]) then begin
     AvisoErro('Impresso n�o cadastrado: '+CodImpresso);
     Exit;
  end;
  n:=Trim(UpperCase(Arq.TImpressos.FieldByName('Impr_NomeContador').AsString));
  if Arq.TImpressos.FieldByName('Impr_Geral').AsString='U' then n:=n+Global.CodigoUnidade;
  AlteraContador(n,Posicao);
end;

function TFGeral.ConsultaContadorImpresso(CodImpresso:String):Integer;
var n:String;
begin
  Result:=0;
  if not Arq.TImpressos.Active then Arq.TImpressos.Open;
  if not Arq.TImpressos.Locate('Impr_Codigo',CodImpresso,[]) then begin
     AvisoErro('Impresso n�o cadastrado: '+CodImpresso);
     Exit;
  end;
  n:=Trim(UpperCase(Arq.TImpressos.FieldByName('Impr_NomeContador').AsString));
  if Arq.TImpressos.FieldByName('Impr_Geral').AsString='U' then n:=n+Global.CodigoUnidade;
  Result:=ConsultaContador(n);
end;


procedure TFGeral.GravaContadorRefresh(Tab:TSqlDs);
var p:integer;
    Nome:String;
begin
  Nome:=LeftStr(UpperCase(Trim(Tab.TableName)),15);
  QSeq.Close;
  QSeq.CommandText := 'SELECT Refr_Posicao FROM Refresh WHERE Refr_Nome='+StringToSql(Nome);
  QSeq.Open;
  if QSeq.IsEmpty then begin
     p:=1;
     QSeq.Close;
     Sistema.Conexao.ExecuteDirect('INSERT INTO Refresh (Refr_Nome,Refr_Posicao) VALUES('+StringToSql(Nome)+',1)');
  end else begin
     p:=QSeq.FieldByName('Refr_Posicao').AsInteger+1;
     QSeq.Close;
     Sistema.Conexao.ExecuteDirect('UPDATE Refresh SET Refr_Posicao='+IntToStr(p)+' WHERE Refr_Nome='+StringToSql(Nome));
  end;
  QSeq.Close;
  Tab.Tag:=p;
end;

procedure TFGeral.LeContadorRefresh(Tab:TSqlDs);
var p:integer;
    Nome:String;
begin
  if sistema.inicializado then begin
    Nome:=LeftStr(UpperCase(Trim(Tab.TableName)),15);
    p:=0;
    QSeq.Close;
    QSeq.CommandText := 'SELECT Refr_Posicao FROM Refresh WHERE Refr_Nome='+StringToSql(Nome);
    QSeq.Open;
    if not QSeq.IsEmpty then p:=QSeq.FieldByName('Refr_Posicao').AsInteger;
    QSeq.Close;
    Tab.Tag:=p;
  end else
    avisoerro('Sistema ainda n�o inicializado');
end;


procedure TFGeral.RefreshTabelas;
type TMat=record
     Nome:String;
     Posicao:Integer;
end;
type TPMat=^TMat;
var Mat:TList;PMat:TPMat;
    NomeTabela:String;
    i,t:Integer;
    Tab:TSqlDs;
    Q:TSqlQuery;
begin
  Mat:=TList.Create;
  Q:=SqlToQuery('SELECT * FROM Refresh');
  while not Q.Eof do begin
    New(PMat);
    PMat^.Nome:=Trim(Q.FieldByName('Refr_Nome').AsString);
    PMat^.Posicao:=Q.FieldByName('Refr_Posicao').AsInteger;
    Mat.Add(PMat);
    Q.Next;
  end;
  Q.Close;Q.Free;
  for t:=0 to Arq.ComponentCount-1 do begin
      if Arq.Components[t] is TSqlDs then begin
         Tab:=TSqlDs(Arq.Components[t]);
         if (Tab.PacketRecords>999) and (Tab.Active) then begin
            NomeTabela:=LeftStr(UpperCase(Trim(TSqlDs(Arq.Components[t]).TableName)),15);
            for i:=0 to Mat.Count-1 do begin
                PMat:=Mat.Items[i];
                if PMat^.Nome=NomeTabela then begin
                   if Tab.Tag<PMat^.Posicao then begin
                      Tab.Refresh;
                      Tab.Tag:=PMat^.Posicao;
                   end;
                end;
            end;
         end;
      end;
  end;
  Mat.Free;
end;


procedure TFGeral.SetaUFs(Edit:TSqlEd);
///////////////////////////////////////////////
var Lista:TStringList;
begin
//  if Edit.Items.Count=0 then begin
    Edit.Items.Clear;
     Lista:=TStringList.Create;
     if Global.UFUnidade='SC' then begin
       Lista.Add('SC - Santa Catarina');
       Lista.Add('PR - Paran�');
     end else begin
       Lista.Add('PR - Paran�');
       Lista.Add('SC - Santa Catarina');
     end;
     Lista.Add('RS - Rio Grande Do Sul');
     Lista.Add('SP - S�o Paulo');
     Lista.Add('RJ - Rio De Janeiro');
     Lista.Add('ES - Esp�rito Santo');
     Lista.Add('MG - Minas Gerais');
     Lista.Add('MS - Mato Grosso Do Sul');
     Lista.Add('MT - Mato Grosso');
     Lista.Add('GO - Goi�s');
     Lista.Add('DF - Distrito Federal');
     Lista.Add('AC - Acre');
     Lista.Add('RO - Rond�nia');
     Lista.Add('AM - Amazonas');
     Lista.Add('AP - Amap�');
     Lista.Add('RR - Roraima');
     Lista.Add('PA - Par�');
     Lista.Add('CE - Cear�');
     Lista.Add('PI - Piau�');
     Lista.Add('MA - Maranh�o');
     Lista.Add('BA - Bahia');
     Lista.Add('PB - Para�ba');
     Lista.Add('SE - Sergipe');
     Lista.Add('AL - Alagoas');
     Lista.Add('TO - Tocantins');
     Lista.Add('RN - Rio Grando Do Norte');
     Lista.Add('PE - Pernambuco');
     Lista.Add('EX - Exterior');
//     Lista.Sort;
     Edit.Items.Assign(Lista);
     Lista.Free;
//  end;
end;

procedure TFGeral.SetaTipoCad(Edit:TSqlEd);
begin
  if Edit.Items.Count=0 then begin
     Edit.Items.Add('C - Cliente');
     Edit.Items.Add('F - Fornecedor');
     Edit.Items.Add('R - Representante');
     Edit.Items.Add('S - Supervisor');
     Edit.Items.Add('T - Transportador');
     Edit.Items.Add('U - Unidade');
     Edit.Items.Add('N - Nenhum');
  end;
end;


procedure TFGeral.ConfiguraEditsEntidade(Categoria:String;EdCodigo,EdNome,EdUF,EdRazao,EdCNPJCPF,EdContaContabil:TSqlEd);
begin
  if Categoria='C' then begin
     EdCodigo.Visible:=True;
     EdCodigo.Title:='Cliente';
     EdCodigo.ShowForm:='FClientes';
     EdCodigo.MessageStr:='C�digo ou CNPJ/CPF do cliente';
     EdCodigo.TagStr:='C';
     EdCodigo.Visible:=True;
     EdCodigo.Width:=95;
     EdCodigo.ValueFormat:='';
     if EdNome<>nil then EdNome.Visible:=True;
     if EdUF<>nil then EdUF.Visible:=True;
     if EdRazao<>nil then EdRazao.Visible:=True;
     if EdCNPJCPF<>nil then EdCNPJCPF.Visible:=True;
     if EdContaContabil<>nil then EdContaContabil.Visible:=True;
  end else if Categoria='F' then begin
     EdCodigo.Visible:=True;
     EdCodigo.Title:='Fornecedor';
     EdCodigo.MessageStr:='C�digo ou CNPJ/CPF do fornecedor';
     EdCodigo.ShowForm:='FFornec';
     EdCodigo.TagStr:='F';
     EdCodigo.Width:=95;
     EdCodigo.ValueFormat:='';
     if EdNome<>nil then EdNome.Visible:=True;
     if EdUF<>nil then EdUF.Visible:=True;
     if EdRazao<>nil then EdRazao.Visible:=True;
     if EdCNPJCPF<>nil then EdCNPJCPF.Visible:=True;
     if EdContaContabil<>nil then EdContaContabil.Visible:=True;
  end else if Categoria='I' then begin
     EdCodigo.Visible:=True;
     EdCodigo.Title:='Funcion�rio';
     EdCodigo.ShowForm:='FFuncionarios';
     EdCodigo.MessageStr:='C�digo ou CPF do funcion�rio';
     EdCodigo.TagStr:='I';
     EdCodigo.Visible:=True;
     EdCodigo.Width:=95;
     EdCodigo.ValueFormat:='';
     if EdNome<>nil then EdNome.Visible:=True;
     if EdUF<>nil then EdUF.Visible:=True;
     if EdRazao<>nil then EdRazao.Visible:=False;
     if EdCNPJCPF<>nil then EdCNPJCPF.Visible:=True;
     if EdContaContabil<>nil then EdContaContabil.Visible:=False;
  end else if Categoria='U' then begin
     EdCodigo.Visible:=True;
     EdCodigo.Title:='Unidade';
     EdCodigo.ShowForm:='FUnidades';
     EdCodigo.MessageStr:='C�digo da unidade';
     EdCodigo.TagStr:='U';
     EdCodigo.Visible:=True;
     EdCodigo.Width:=30;
     EdCodigo.ValueFormat:='000';
     if EdNome<>nil then EdNome.Visible:=True;
     if EdUF<>nil then EdUF.Visible:=True;
     if EdRazao<>nil then EdRazao.Visible:=True;
     if EdCNPJCPF<>nil then EdCNPJCPF.Visible:=True;
     if EdContaContabil<>nil then EdContaContabil.Visible:=True;
  end else if Categoria='J' then begin
     EdCodigo.Visible:=True;
     EdCodigo.Title:='CNPJ/CPF';
     EdCodigo.MessageStr:='CNPJ/CPF';
     EdCodigo.ShowForm:='';
     EdCodigo.TagStr:='J';
     EdCodigo.ValueFormat:='';
     EdCodigo.Width:=95;
     if EdNome<>nil then EdNome.Visible:=False;
     if EdUF<>nil then EdUF.Visible:=False;
     if EdRazao<>nil then EdRazao.Visible:=False;
     if EdCNPJCPF<>nil then EdCNPJCPF.Visible:=True;
     if EdContaContabil<>nil then EdContaContabil.Visible:=False;
  end else begin
     EdCodigo.Visible:=False;
     EdCodigo.Title:='';
     EdCodigo.ShowForm:='';
     EdCodigo.TagStr:='N';
     EdCodigo.Clear;
     EdCodigo.ValueFormat:='';
     if EdNome<>nil then EdNome.Visible:=False;
     if EdUF<>nil then EdUF.Visible:=False;
     if EdRazao<>nil then EdRazao.Visible:=False;
     if EdCNPJCPF<>nil then EdCNPJCPF.Visible:=False;
     if EdContaContabil<>nil then EdContaContabil.Visible:=False;
  end;
end;


function TFGeral.GetEntidade(EdCodigo,EdNome,EdUF,EdRazao,EdCNPJCPF,EdContaContabil,EdFPgto,EdLPgto:TSqlEd):Boolean;
var Cod,Cat,s:String;
    Q:TSqlQuery;
    Found:Boolean;
begin
  Result:=True;
  Cat:=EdCodigo.TagStr;
  if Cat<>'J' then Cod:=IntToStr(Inteiro(EdCodigo.Text));
  if EdNome<>nil then EdNome.Clear;
  if EdRazao<>nil then EdRazao.Clear;
  if EdUF<>nil then EdUF.Clear;
  if EdCNPJCPF<>nil then EdCNPJCPF.Clear;
  if EdContaContabil<>nil then EdContaContabil.Clear;
  if Cat='F' then begin
     s:='Forn_Codigo='+Cod;
     if Length(Cod)>=11 then s:='Forn_CNPJCPF='+StringToSql(Cod);
     Q:=SqlToQuery('SELECT Forn_Codigo,Forn_Nome,Forn_RazaoSocial,Forn_Muni_Codigo,Forn_CNPJCPF,Forn_ContaContabil,Forn_FPgt_Codigo,Forn_LPgt_Codigo FROM Fornecedores WHERE '+s);
     if Q.IsEmpty then begin
        EdCodigo.Invalid('Fornecedor n�o cadastrado');
        Result:=False;
     end else begin
        EdCodigo.Text:=IntToStr(Q.FieldByName('Forn_Codigo').AsInteger);
        if EdNome<>nil then EdNome.Text:=Q.FieldByName('Forn_Nome').AsString;
        if EdRazao<>nil then EdRazao.Text:=Q.FieldByName('Forn_RazaoSocial').AsString;
        if EdCNPJCPF<>nil then EdCNPJCPF.Text:=Q.FieldByName('Forn_CNPJCPF').AsString;
        if EdUF<>nil then EdUF.Text:=FCidades.GetUF(Q.FieldByName('Forn_Muni_Codigo').AsInteger);
        if EdContaContabil<>nil then EdContaContabil.Text:=IntToStr(Q.FieldByName('Forn_ContaContabil').AsInteger);
        if (EdLPgto<>nil) and (EdLPgto.IsEmpty) then EdLPgto.Text:=Q.FieldByName('FORN_LPGT_CODIGO').AsString;
        if (EdFPgto<>nil) and (EdFPgto.IsEmpty) then EdFPgto.Text:=Q.FieldByName('FORN_FPGT_CODIGO').AsString;
     end;
     Q.Close;
     Q.Free;
  end else if Cat='C' then begin
     s:='Clie_Codigo='+Cod;
     if Length(Cod)>=11 then s:='Clie_CNPJCPF='+StringToSql(Cod);
     Q:=SqlToQuery('SELECT Clie_Codigo,Clie_Nome,Clie_RazaoSocial,Clie_Muni_Codigo_Com,Clie_CNPJCPF,Clie_ContaContabil FROM Clientes WHERE '+s);
     if Q.IsEmpty then begin
        EdCodigo.Invalid('Cliente n�o cadastrado');
        Result:=False;
     end else begin
        EdCodigo.Text:=IntToStr(Q.FieldByName('Clie_Codigo').AsInteger);
        if EdNome<>nil then EdNome.Text:=Q.FieldByName('Clie_Nome').AsString;
        if EdRazao<>nil then EdRazao.Text:=Q.FieldByName('Clie_RazaoSocial').AsString;
        if EdCNPJCPF<>nil then EdCNPJCPF.Text:=Q.FieldByName('Clie_CNPJCPF').AsString;
        if EdUF<>nil then EdUF.Text:=FCidades.GetUF(Q.FieldByName('Clie_Muni_Codigo_Com').AsInteger);
        if EdContaContabil<>nil then EdContaContabil.Text:=IntToStr(Q.FieldByName('Clie_ContaContabil').AsInteger);
     end;
     Q.Close;
     Q.Free;
  end else if Cat='I' then begin
     s:='Func_Codigo='+Cod;
     if Length(Cod)>=11 then s:='Clie_CPF='+StringToSql(Cod);
     Q:=SqlToQuery('SELECT Func_Codigo,Func_Nome,Func_Muni_Codigo,Func_CPF FROM Funcionarios WHERE '+s);
     if Q.IsEmpty then begin
        EdCodigo.Invalid('Funcion�rio n�o cadastrado');
        Result:=False;
     end else begin
        EdCodigo.Text:=IntToStr(Q.FieldByName('Func_Codigo').AsInteger);
        if EdNome<>nil then EdNome.Text:=Q.FieldByName('Func_Nome').AsString;
        if EdRazao<>nil then EdRazao.Text:=Q.FieldByName('Func_Nome').AsString;
        if EdCNPJCPF<>nil then EdCNPJCPF.Text:=Q.FieldByName('Func_CPF').AsString;
     end;
     Q.Close;
     Q.Free;
  end else if Cat='U' then begin
     if not Arq.TUnidades.Active then Arq.TUnidades.Open;
     if Length(Cod)<=3 then begin
        Cod:=StrZero(Inteiro(Cod),3);
        Found:=Arq.TUnidades.Locate('Unid_Codigo',Cod,[]);
     end else begin
        Found:=Arq.TUnidades.Locate('Unid_CNPJ',Cod,[]);
     end;
     if not Found then begin
        EdCodigo.Invalid('Unidade n�o cadastrada');
        Result:=False;
     end else begin
        if EdNome<>nil then EdNome.Text:=Arq.TUnidades.FieldByName('Unid_Nome').AsString;
        if EdRazao<>nil then EdRazao.Text:=Arq.TUnidades.FieldByName('Unid_RazaoSocial').AsString;;
        if EdCNPJCPF<>nil then EdCNPJCPF.Text:=Arq.TUnidades.FieldByName('Unid_CNPJ').AsString;
        if EdUF<>nil then EdUF.Text:=FCidades.GetUF(Arq.TUnidades.FieldByName('Unid_Muni_Codigo').AsInteger);
        if EdContaContabil<>nil then EdContaContabil.Text:=IntToStr(Arq.TUnidades.FieldByName('Unid_ContaContabil').AsInteger);
     end;
  end else if Cat='J' then begin
     if EdCNPJCPF<>nil then EdCNPJCPF.Text:=EdCodigo.Text;
  end;
end;


function TFGeral.GetNomeRazaoSocialEntidade(Codigo:Integer;Categoria,NR:String):String;
///////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlQuery;
begin
  Result:=' ';
  if Categoria='F' then begin
     Q:=SqlToQuery('SELECT Forn_Nome,Forn_RazaoSocial FROM Fornecedores WHERE Forn_Codigo='+IntToStr(Codigo));
     if not Q.IsEmpty then begin
        Result:=Trim(Q.FieldByName('Forn_RazaoSocial').AsString);
        if (Result='') or (NR='N') then Result:=Q.FieldByName('Forn_Nome').AsString;
     end;
     Q.Close;Q.Free;
  end else if Categoria='C' then begin
     Q:=SqlToQuery('SELECT Clie_Nome,Clie_RazaoSocial FROM Clientes WHERE Clie_Codigo='+IntToStr(Codigo));
     if not Q.IsEmpty then begin
//        Result:=Trim(TiraAspas(Q.FieldByName('Clie_RazaoSocial').AsString));
// 22.02.16
        Result:=Trim(TiraBarra(Q.FieldByName('Clie_RazaoSocial').AsString,chr(39)));
//        Result:=Trim(ConvSql(Q.FieldByName('Clie_RazaoSocial').AsString));
        if (Result='') or (NR='N') then Result:=Q.FieldByName('Clie_Nome').AsString;
     end else
        Result:='Cliente n�o encontrado';
     Q.Close;Q.Free;
  end else if (Categoria='R') or (Categoria='S') then begin
     Q:=SqlToQuery('SELECT repr_Nome FROM representantes WHERE Repr_Codigo='+IntToStr(Codigo));
     if not Q.IsEmpty then begin
        Result:=Trim(Q.FieldByName('Repr_Nome').AsString);
     end;
     Q.Close;Q.Free;
  end else if Categoria='U' then begin
     Q:=SqlToQuery('SELECT Unid_Nome,Unid_RazaoSocial FROM Unidades WHERE Unid_Codigo='+StringToSql(StrZero(Codigo,3)));
     if not Q.IsEmpty then begin
        Result:=Trim(Q.FieldByName('Unid_RazaoSocial').AsString);
        if (Result='') or (NR='N') then Result:=Q.FieldByName('Unid_Nome').AsString;
     end;
     Q.Close;Q.Free;
  end else begin
     Q:=SqlToQuery('SELECT Tran_Nome,Tran_RazaoSocial FROM Transportadores WHERE Tran_Codigo='+StringToSql(StrZero(Codigo,3)));
     if not Q.IsEmpty then begin
        Result:=Trim(Q.FieldByName('Tran_RazaoSocial').AsString);
        if (Result='') or (NR='N') then Result:=Q.FieldByName('Tran_Nome').AsString;
     end;
     Q.Close;Q.Free;
  end;
end;




function TFGeral.DiaUtil(Data:TDateTime):Boolean;
var Q:TSqlQuery;
begin
  Result:=True;
  if DayOfWeek(Data)=1 then Result:=False
  else if DayOfWeek(Data)=7 then Result:=False;
  if Result then begin
     Q:=SqlToQuery('SELECT Count(*) AS Registros FROM Feriados WHERE Feri_Data='+DateToSql(Data));
     Result:=Q.FieldByName('Registros').AsInteger=0;
     Q.Close;
     Q.Free;
  end;
end;

function TFGeral.GetProximoDiaUtil(Data:TDateTime;prazo:integer=0):TDateTime;
begin
  Result:=Data;
  if not  Global.Topicos[1254] then begin   //  27.09.07
    if prazo>0 then begin
      while not DiaUtil(Result) do begin
        Result:=Result+1;
      end;
    end;
  end;
end;


procedure TFGeral.ValidaCNPJCPF(Edit:TSqlEd);
/////////////////////////////////////////////
var t:Integer;
    s:String;
begin
  s:=Trim(Edit.Text);
  if s='' then Exit;
  t:=Length(s);
  if t=11 then begin
//     FGeral.CheckCNPJCPF.Mode:=moCPF;
//     FGeral.CheckCNPJCPF.Input:=s;
//     if not FGeral.CheckCNPJCPF.Result then begin
//        Edit.Invalid('CPF inv�lido');
//     end;
  end else if t=14 then begin
     if (Global.Topicos[1104]) and (Edit.text='00000000000000') then begin   // 24.05.07
     end else begin
//       FGeral.CheckCNPJCPF.Mode:=moCGC;
//       FGeral.CheckCNPJCPF.Input:=s;
//       if not FGeral.CheckCNPJCPF.Result then begin
//          Edit.Invalid('CNPJ inv�lido');
//       end;
     end;
  end else begin
     Edit.Invalid('Conte�do inv�lido');
  end;
end;

// 22.01.16
function TFGeral.ValidarCNPJCPF(x:string):boolean;
//////////////////////////////////////////////////////////
var t:Integer;
    s:String;
    xret:boolean;
begin
  s:=Trim(x);
  result:=true;
  if s='' then Exit;
  t:=Length(s);
  xret:=false;
  if t=11 then begin
//     FGeral.CheckCNPJCPF.Mode:=moCPF;
//     FGeral.CheckCNPJCPF.Input:=s;
//     if not FGeral.CheckCNPJCPF.Result then begin
//        Avisoerro('CPF inv�lido');
//     end else xret:=true;
  end else if t=14 then begin
     if (Global.Topicos[1104]) and (x='00000000000000') then begin
     end else begin
//       FGeral.CheckCNPJCPF.Mode:=moCGC;
//       FGeral.CheckCNPJCPF.Input:=s;
//       if not FGeral.CheckCNPJCPF.Result then begin
//          Avisoerro('CNPJ inv�lido');
//       end else xret:=true;
     end;
  end else begin
     Avisoerro('Conte�do inv�lido');
  end;
  result:=xret;
end;


function TFGeral.ValidaUnidadesMvtoUsuario(EdUnidade:TSqlEd):Boolean;
begin
  Result:=Pos(EdUnidade.Text,Global.Usuario.UnidadesMvto)>0;
  if Global.Usuario.Desenvolvimento then Result:=True;
  if not Result then EdUnidade.Invalid('Unidade de movimento inv�lida para o usu�rio do sistema');
end;

function TFGeral.UnidadeValidaUsuario(Unidade:String):Boolean;
begin
  Result:=Pos(Unidade,Global.Usuario.UnidadesMvto)>0;
end;

function TFGeral.ValidaContaCaixaUsuario(EdConta:TSqlEd):Boolean;
var c:String;
begin
  c:=';'+Trim(EdConta.Text)+';';
  Result:=Pos(c,Global.Usuario.ContasCaixaValidas)>0;
  if Global.Usuario.Desenvolvimento then Result:=True;
  if not Result then EdConta.Invalid('Conta caixa inv�lida para o usu�rio do sistema');
end;

function TFGeral.ValidaMvto(EdData:TSqlEd):Boolean;
/////////////////////////////////////////////////////////
var data:TDatetime;
begin
  if EdDAta.asdate>Global.DataSistema then begin
    Result:=false;
    Avisoerro('Data posterior a data de validade do sistema');
  end else begin
// 28.07.08
//    if ( FGeral.GetConfig1Asinteger('DIASUSOSAC')>0 )  and ( pos('emissao',EdData.Name)=0 ) then begin
// 29.03.10 - dias somente para caixa bancos e nota saida
    if ( FGeral.GetConfig1Asinteger('DIASUSOSAC')>0 )  and ( pos('emissao',EdData.Name)>0 ) or
       ( FGeral.GetConfig1Asinteger('DIASUSOSAC')>0 )  and ( Global.Topicos[1368] ) then begin
      data:=Sistema.hoje-FGeral.GetConfig1AsInteger('DIASUSOSAC');
      if (EdData.asdate<data) and ( not Global.Usuario.OutrosAcessos[0043]) then begin
        EdData.Invalid('Data de movimento fora do n�mero de dias permitido para uso. Data limite '+FormataData(data));
        Result:=false;
      end else
        Result:=true;
    end else begin
      if FGeral.GetConfig1AsDate('DtInicioMvto') > 1 then begin
        Result:=(EdData.AsDate>=FGeral.GetConfig1AsDate('DtInicioMvto'));
        if FGeral.GetConfig1AsDate('DtterminoMvto') > 1 then
          Result:=(EdData.AsDate<=FGeral.GetConfig1AsDate('DtterminoMvto')) and (EdData.AsDate>=FGeral.GetConfig1AsDate('DtInicioMvto')) ;
      end else if FGeral.GetConfig1AsDate('DtterminoMvto') > 1 then
          Result:=(EdData.AsDate<=FGeral.GetConfig1AsDate('DtterminoMvto'))
      else
          Result:=true;
      if not Result then EdData.Invalid('Data de movimento fora do per�odo permitido para uso');
    end;
  end;
////////////  if result then ValidaDataFiscal(EdData);
/// 03.12.09 - aqui nao vinga pois pega 'td' o sistema'..
end;

function TFGeral.ValidaDataContabil(EdData:TSqlEd):Boolean;
//////////////////////////////////////////////////////////////////
begin
  Result:=(EdData.AsDate>=FGeral.GetConfig1AsDate('DataInicialContabil')) and (EdData.AsDate<=FGeral.GetConfig1AsDate('DataFinalContabil'));
  if not Result then EdData.Invalid('Data cont�bil fora do per�odo configurado');
  if (Result) and (Global.DataUltimoEncerrPerCont>0) then begin
     if EdData.AsDate<Global.DataUltimoEncerrPerCont then begin
        Result:=False;
        EdData.Invalid('Data de cont�bil pertence a per�odo cont�bil j� encerrado');
     end;
  end;
end;

function TFGeral.ValidaDataFiscal(EdData:TSqlEd):Boolean;
///////////////////////////////////////////////////////////
begin

  if EdDAta.asdate>Global.DataSistema then begin
    Result:=false;
    Avisoerro('Data posterior a data de validade fiscal do sistema');
  end else begin

      if FGeral.GetConfig1AsDate('Dtinicionotas') > 1 then begin
        Result:=(EdData.AsDate>=FGeral.GetConfig1AsDate('Dtinicionotas'));
        if FGeral.GetConfig1AsDate('Dtterminotas') > 1 then
          Result:=(EdData.AsDate<=FGeral.GetConfig1AsDate('Dtterminotas')) and (EdData.AsDate>=FGeral.GetConfig1AsDate('Dtinicionotas')) ;
      end else if FGeral.GetConfig1AsDate('Dtterminotas') > 1 then
          Result:=(EdData.AsDate<=FGeral.GetConfig1AsDate('Dtterminotas'))
      else
          Result:=true;
      if not Result then EdData.Invalid('Data de movimento fora do per�odo FISCAL permitido para uso');

  end;


end;

function TFGeral.GetValorTxAdmAutomatica(Conta:Integer;ValorPendFin:Currency):Currency;
begin
  Result:=0;
//  if (FPlanoGer.GetConta(Conta)) and (Arq.TPlanoGer.FieldByName('plan_TxAdmAutomatica').AsString='S') then begin
//     Result:=RoundValor(ValorPendFin*Arq.TPlanoGer.FieldByName('plan_PercTxAdm').AsFloat/100);
//  end;
end;

function TFGeral.GetValorImposto(BaseCalculo,Aliquota,Reducao:Extended):Currency;
begin
  if Reducao>0 then BaseCalculo:=BaseCalculo-RoundValor(BaseCalculo*Reducao/100);
  Result:=RoundValor(BaseCalculo*Aliquota/100);
end;


function TFGeral.GetContaContabil(ContaGer,ContaContabilEntidade:Integer;CodigoUnidade:String;CodigoCC:String = ''):Integer;
begin
  Result:=0;
//  if FPlanoGer.GetConta(ContaGer) then begin
  if false then begin
     Result:=Arq.TPlano.FieldByName('plan_ContaContabil').AsInteger;
     if Result=999999 then begin
        Result:=ContaContabilEntidade;
     end else if Result=999998 then begin
        Result:=0;
        Q:=SqlToQuery('SELECT * FROM ContabUn WHERE Cbun_plan_Conta='+IntToStr(ContaGer)+' AND Cbun_Unid_Codigo='+StringToSql(CodigoUnidade));
        if not Q.isEmpty then Result:=Q.FieldByName('Cbun_Pcon_Conta').AsInteger;
        Q.Close;Q.Free;
     end else if Result=999997 then begin
        Result:=0;
        Q:=SqlToQuery('SELECT * FROM ContabCC WHERE Cbcc_plan_Conta='+IntToStr(ContaGer)+' AND Cbcc_Ccst_Codigo='+StringToSql(CodigoCC));
        if not Q.isEmpty then Result:=Q.FieldByName('Cbcc_Pcon_Conta').AsInteger;
        Q.Close;Q.Free;
     end;
  end;
end;


procedure TFGeral.InicializaConfig1;
var Q:TSqlQuery;
begin
  Global.Config1.Clear;
  Q:=SqlToQuery('SELECT * FROM Config1');
  while not Q.Eof do begin
    New(Global.PConfig1);
    Global.PConfig1^.Nome:=Trim(UpperCase(Q.FieldByName('Cfg1_Nome').AsString));
    Global.PConfig1^.Tipo:=Trim(UpperCase(Q.FieldByName('Cfg1_Tipo').AsString));
    Global.PConfig1^.Conteudo:=Q.FieldByName('Cfg1_Conteudo').AsString;
    Global.Config1.Add(Global.PConfig1);
    Q.Next;
  end;
  Q.Close;Q.Free;

end;


function TFGeral.GetConfig1AsString(NomeCampo:String):String;
var i:integer;
begin
  Result:='';
  NomeCampo:=Trim(UpperCase(NomeCampo));
  for i:=0 to Global.Config1.Count-1 do begin
      Global.PConfig1:=Global.Config1.Items[i];
      if Global.PConfig1^.Nome=NomeCampo then begin
         Result:=Global.PConfig1^.Conteudo;
         Break;
      end;
  end;
end;


function TFGeral.GetConfig1AsInteger(NomeCampo:String):Integer;
var i:integer;
begin
  Result:=0;
  NomeCampo:=Trim(UpperCase(NomeCampo));
  for i:=0 to Global.Config1.Count-1 do begin
      Global.PConfig1:=Global.Config1.Items[i];
      if Global.PConfig1^.Nome=NomeCampo then begin
         Result:=Inteiro(Global.PConfig1^.Conteudo);
         Break;
      end;
  end;
end;

function TFGeral.GetConfig1AsFloat(NomeCampo:String):Extended;
var i:integer;
begin
  Result:=0;
  NomeCampo:=Trim(UpperCase(NomeCampo));
  for i:=0 to Global.Config1.Count-1 do begin
      Global.PConfig1:=Global.Config1.Items[i];
      if Global.PConfig1^.Nome=NomeCampo then begin
         Result:=TextToValor(Global.PConfig1^.Conteudo);
         Break;
      end;
  end;
end;

function TFGeral.GetConfig1AsDate(NomeCampo:String):TDateTime;
var i:integer;
begin
  Result:=0;
  NomeCampo:=Trim(UpperCase(NomeCampo));
  for i:=0 to Global.Config1.Count-1 do begin
      Global.PConfig1:=Global.Config1.Items[i];
      if Global.PConfig1^.Nome=NomeCampo then begin
         Result:=TextToDate(StrToStrNumeros(Global.PConfig1^.Conteudo));
         Break;
      end;
  end;
end;


procedure TFGeral.GetFieldsConfig1(Form:TForm);
var c:Integer;
    Ed:TSqlEd;
begin
  InicializaConfig1;
  for c:=0 to Form.ComponentCount-1 do begin
      if Form.Components[c] is TSqlEd then begin
         Ed:=TSqlEd(Form.Components[c]);
         if (Ed.TableName='CONFIG1') and (Trim(Ed.TableField)<>'') then begin
            case Ed.TypeValue of
                 tvString,tvDate:Ed.Text:=GetConfig1AsString(Ed.TableField);
                 tvInteger:Ed.SetValue(GetConfig1AsInteger(Ed.TableField));
                 tvFloat:Ed.SetValue(GetConfig1AsFloat(Ed.TableField));
            end;
            if Ed.IsEmpty then Ed.SetDefault; 
         end;
      end;
  end;
end;


procedure TFGeral.SetFieldsConfig1(Form:TForm);
var c:Integer;
    Ed:TSqlEd;
begin
  InicializaConfig1;
  for c:=0 to Form.ComponentCount-1 do begin
      if Form.Components[c] is TSqlEd then begin
         Ed:=TSqlEd(Form.Components[c]);
         if (Ed.TableName='CONFIG1') and (Trim(Ed.TableField)<>'') then begin
            if (Ed.TypeValue=tvString) and (Ed.Text<>GetConfig1AsString(Ed.TableField)) then GravaConfig1(Ed.TableField,'C',Ed.Text);
            if (Ed.TypeValue=tvInteger) and (Ed.AsInteger<>GetConfig1AsInteger(Ed.TableField)) then GravaConfig1(Ed.TableField,'I',IntToStr(Ed.AsInteger));
            if (Ed.TypeValue=tvFloat) and (Ed.AsFloat<>GetConfig1AsFloat(Ed.TableField)) then GravaConfig1(Ed.TableField,'F',FloatToStr(Ed.AsFloat));
            if (Ed.TypeValue=tvDate) and (Ed.AsDate<>GetConfig1AsDate(Ed.TableField)) then GravaConfig1(Ed.TableField,'D',DateToText(Ed.AsDate));
         end;
      end;
  end;
end;


procedure TFGeral.GravaConfig1(NomeCampo,Tipo,Conteudo:String);
//////////////////////////////////////////////////////////////////////
var Q:TSqlQuery;
begin
  NomeCampo:=UpperCase(Trim(NomeCampo));
  Q:=SqlToQuery('SELECT Count(*) AS Registros FROM Config1 WHERE Cfg1_Nome='+StringToSql(NomeCampo));
  if Q.FieldByName('Registros').AsInteger=0 then begin
     Sistema.Conexao.ExecuteDirect('INSERT INTO Config1 (Cfg1_Nome,Cfg1_Tipo,Cfg1_Conteudo) VALUES('+StringToSql(NomeCampo)+','+StringToSql(Tipo)+','+StringToSql(Conteudo)+')');
     Sistema.Commit;
  end else begin
     Sistema.Conexao.ExecuteDirect('UPDATE Config1 SET Cfg1_Conteudo='+StringToSql(Conteudo)+' WHERE Cfg1_Nome='+StringToSql(NomeCampo));
     Sistema.Commit;
  end;
  Q.Close;Q.Free;
end;


function TFGeral.GetDataServidor:TDateTime;
var Q:TSqlQuery;
begin
  Result:=Trunc(Date);
  if Sistema.TypeServer=tsOracle then begin
     Q:=SqlToQuery('SELECT SYSDATE FROM DUAL');
     Result:=Trunc(Q.FieldByName('SYSDATE').AsDateTime);
     Q.Close;Q.Free;
  end else if Sistema.TypeServer=tsInterbase then begin
     Q:=SqlToQuery('SELECT CURRENT_DATE AS DataAtual FROM RDB$DATABASE');
     Result:=Trunc(Q.FieldByName('DataAtual').AsDateTime);
     Q.Close;Q.Free;
  end else if Sistema.TypeServer=tsPostGreSql then begin
     Q:=SqlToQuery('SELECT CURRENT_DATE AS DataAtual');
     Result:=Trunc(Q.FieldByName('DataAtual').AsDateTime);
     Q.Close;Q.Free;
  end;
end;



procedure TFGeral.GetValoresAcessoriosCalculados(Operacao:String;Conta:Integer;Valor,ValorMoeda:Currency;DtVcto:TDateTime; var Juros,Multa,Mora,TxAdm,CorrMonet,Descontos,Acrescimos,Abatimentos,ValorBxParcial:Currency);
type TMat=record
     Data:TDateTime;
     Valor:Currency;
end;
type TPMat=^TMat;
var nDias:Integer;
    CodMoeda:String;
    Mat:TList;PMat:TPMat;

    procedure CalculaJuros;
    var Taxa:Double;
        Meses,nd,d,p:Integer;
        TaxaJuros,TaxaDia:Double;
    begin
      nd:=nDias;
      Taxa:=Arq.TPlano.FieldByName('plan_TaxaJuros').AsFloat;
      if (nDias>Arq.TPlano.FieldByName('plan_CarenciaJuros').AsInteger) and (Taxa>0) and (Arq.TPlano.FieldByName('plan_ContaJuros').AsInteger>0) then begin
         if Arq.TPlano.FieldByName('plan_TipoJuros').AsString='S' then begin
            Meses:=Trunc(Divide(nd,30));
            nd:=nd-(Meses*30);
            TaxaJuros:=Meses*Taxa;
            TaxaDia:=Divide(Taxa,30);
            TaxaJuros:=TaxaJuros+(TaxaDia*nd);
            Juros:=RoundValor(Valor*TaxaJuros/100);
            for p:=0 to Mat.Count-1 do begin
                PMat:=Mat.Items[p];
                nd:=Trunc(Sistema.Hoje-PMat^.Data);
                Meses:=Trunc(Divide(nd,30));
                nd:=nd-(Meses*30);
                TaxaJuros:=Meses*Taxa;
                TaxaDia:=Divide(Taxa,30);
                TaxaJuros:=TaxaJuros+(TaxaDia*nd);
                Juros:=Juros-RoundValor(PMat^.Valor*TaxaJuros/100);
            end;
         end else begin
            TaxaDia:=Power(((Taxa/100)+1),(1/30));
            TaxaJuros:=1;
            for d:=1 to nd do TaxaJuros:=TaxaJuros*TaxaDia;
            Juros:=RoundValor(Valor*TaxaJuros)-Valor;
            for p:=0 to Mat.Count-1 do begin
                PMat:=Mat.Items[p];
                nd:=Trunc(Sistema.Hoje-PMat^.Data);
                TaxaJuros:=1;
                for d:=1 to nd do TaxaJuros:=TaxaJuros*TaxaDia;
                Juros:=Juros-(RoundValor(PMat^.Valor*TaxaJuros)-PMat^.Valor);
            end;
         end;
      end;
    end;

    procedure CalculaMulta;
    begin
      if nDias>Arq.TPlano.FieldByName('plan_CarenciaMulta').AsInteger then begin
         if Arq.TPlano.FieldByName('plan_ContaMulta').AsInteger>0 then begin
            if Arq.TPlano.FieldByName('plan_PercMulta').AsFloat>0 then begin
               Multa:=RoundValor(Valor*Arq.TPlano.FieldByName('plan_PercMulta').AsFloat/100);
            end;
         end;
      end;
    end;

    procedure CalculaMora;
    begin
      if nDias>Arq.TPlano.FieldByName('plan_CarenciaMora').AsInteger then begin
         if Arq.TPlano.FieldByName('plan_ContaMora').AsInteger>0 then begin
            if Arq.TPlano.FieldByName('plan_ValorMora').AsFloat>0 then begin
               Mora:=RoundValor(nDias*Arq.TPlano.FieldByName('plan_ValorMora').AsFloat);
            end;
         end;
      end;
    end;

    procedure CalculaTxAdm;
    begin
      if Arq.TPlano.FieldByName('plan_ContaTxAdm').AsInteger>0 then begin
         if Arq.TPlano.FieldByName('plan_PercTxAdm').AsFloat>0 then begin
            TxAdm:=RoundValor(Valor*Arq.TPlano.FieldByName('plan_PercTxAdm').AsFloat/100);
         end;
      end;
    end;

    procedure CalculaDesconto;
    begin
      if Arq.TPlano.FieldByName('plan_ContaDescontos').AsInteger>0 then begin
         if Arq.TPlano.FieldByName('plan_PercDescontos').AsFloat>0 then begin
            if DtVcto>=Sistema.Hoje then begin
               Descontos:=RoundValor(Valor*Arq.TPlano.FieldByName('plan_PercDescontos').AsFloat/100);
            end;
         end;
      end;
    end;

    procedure CalculaCorrMonetaria;
    begin
      if nDias>Arq.TPlano.FieldByName('plan_CarenciaCorrMonet').AsInteger then begin
         if Arq.TPlano.FieldByName('plan_ContaCorrMonet').AsInteger>0 then begin
//            CorrMonet:=FInflacao.CorrigeValor(Valor,DtVcto,Sistema.Hoje)-Valor;
            CorrMonet:=0;
//            for p:=0 to Mat.Count-1 do begin
//                PMat:=Mat.Items[p];
//                CorrMonet:=CorrMonet-(FInflacao.CorrigeValor(PMat^.Valor,PMat^.Data,Sistema.Hoje)-PMat^.Valor);
//            end;
         end;
      end;
    end;

    procedure CalculaMoeda;
    var NovoValor:Currency;
    begin
      if (ValorMoeda>0) and (CodMoeda<>'') then begin
         if (Arq.TPlano.FieldByName('plan_ContaAcrescimos').AsInteger>0) and (Arq.TPlano.FieldByName('plan_ContaAbatimentos').AsInteger>0) then begin
            NovoValor:=FMoedas.MoedaToReais(CodMoeda,ValorMoeda);
            if NovoValor>Valor then Acrescimos:=NovoValor-Valor
            else if Valor>NovoValor then Abatimentos:=Valor-NovoValor;
         end;
      end;
    end;

    procedure SetaBaixasParciais;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Bxpa_Valor,Bxpa_DataMvto FROM BxParcial WHERE Bxpa_Operacao='+StringToSql(Operacao)+' AND Bxpa_Status='+StringToSql('N'));
      while not Q.Eof do begin
        New(PMat);
        PMat^.Data:=Q.FieldByName('Bxpa_DataMvto').AsDateTime;
        PMat^.Valor:=Q.FieldByName('Bxpa_Valor').AsFloat;
        Mat.Add(PMat);
        Q.Next;
      end;
      Q.Close;Q.Free;
    end;


begin
  Juros:=0;Mora:=0;Multa:=0;TxAdm:=0;CorrMonet:=0;Descontos:=0;Acrescimos:=0;Abatimentos:=0;
  Mat:=TList.Create;
  if (Global.Topicos[1272]) and (ValorBxParcial>0) then SetaBaixasParciais;
(*
  FPlano.GetConta(Conta);
  if Arq.TPlano.FieldByName('plan_Tipo').AsString='CR' then begin
     nDias:=Trunc(Sistema.Hoje-DtVcto);
     if (nDias>Global.DiasNaoUteisAnteriores) then begin
        CalculaJuros;
        CalculaMulta;
        CalculaMora;
        CalculaTxAdm;
        CalculaDesconto;
        CalculaCorrMonetaria;
     end;
  end;
  CodMoeda:=Trim(Arq.TPlano.FieldByName('plan_Moed_Codigo').AsString);
  if CodMoeda<>'' then CalculaMoeda;
*)  
  Mat.Free;
end;

procedure TFGeral.SetDefaultEdits(Form:TForm);
var Ed:TSqlEd;
    i:Integer;
begin
  for i:=0 to Form.ComponentCount-1 do begin
      if Form.Components[i] is TSqlEd then begin
         Ed:=TSqlEd(Form.Components[i]);
         if Ed.IsEmpty then Ed.SetDefault;
      end;
  end;
end;


procedure TFGeral.EnableEdits(Form:TForm;Grupo:Integer);
var c:Integer;
begin
  for c:=0 to Form.ComponentCount-1 do begin
      if Form.Components[c] is TSqlEd then begin
         if (Grupo=99) or (TSqlEd(Form.Components[c]).Group=Grupo) then TSqlEd(Form.Components[c]).Enabled:=True;
      end;
  end;
end;

procedure TFGeral.DisableEdits(Form:TForm;Grupo:Integer);
var c:Integer;
begin
  for c:=0 to Form.ComponentCount-1 do begin
      if Form.Components[c] is TSqlEd then begin
         if (Grupo=99) or (TSqlEd(Form.Components[c]).Group=Grupo) then TSqlEd(Form.Components[c]).Enabled:=False;
      end;
  end;
end;





function TFGeral.GetVctoPendFin(Conta:Integer):TDateTime;
var Dt:TDateTime;
    Dia:Integer;
begin
  Result:=0;
(*
  if FPlano.GetConta(Conta) then begin
     Result:=Arq.TPlano.FieldByName('plan_DataVcto').AsDateTime;
     if Result=0 then begin
        if Arq.TPlano.FieldByName('plan_PrazoVcto').AsInteger>0 then Result:=Sistema.Hoje+Arq.TPlano.FieldByName('plan_PrazoVcto').AsInteger;
        if Result=0 then begin
           Dia:=Inteiro(Arq.TPlano.FieldByName('plan_DiaVcto').AsString);
           if Dia>0 then begin
              if Dia=31 then begin
                 Result:=DateToUltimoDiaMes(Sistema.Hoje);
              end else begin
                 Dt:=Sistema.Hoje+1;
                 while Result=0 do begin
                   if DateToDia(Dt)=Dia then Result:=Dt;
                   Dt:=Dt+1;
                 end;
              end;
           end;
        end;
     end;
     if Result>0 then Result:=GetProximoDiaUtil(Result);
  end;
*)  
end;


function TFGeral.GetIN(Campo,Str,TipoCampo:String):String;
var Lista:TStringList;
    i:Integer;
begin
  if trim(str)<>'' then begin    // 15.03.05
    Lista:=TStringList.Create;
    StrToLista(Lista,Str,',;',False);
    if Lista.Count=1 then begin
       if TipoCampo='C' then Result:=Campo+'='+StringToSql(Lista[0]);
       if TipoCampo='N' then Result:=Campo+'='+Lista[0];
    end else if Lista.Count>1 then begin
       Result:=Campo+' IN (';
       if TipoCampo='C' then for i:=0 to Lista.Count-1 do Result:=Result+StringToSql(Lista[i])+',';
       if TipoCampo='N' then for i:=0 to Lista.Count-1 do Result:=Result+Lista[i]+',';
       Result:=LeftStr(Result,Length(Result)-1);
       Result:=Result+')';
    end;
    Lista.Free;
  end else
    result:=''
end;

function TFGeral.GetNOTIN(Campo,Str,TipoCampo:String):String;
var Lista:TStringList;
    i:Integer;
begin
  if trim(str)<>'' then begin    // 15.03.05
    Lista:=TStringList.Create;
    StrToLista(Lista,Str,',;',False);
    if Lista.Count=1 then begin
       if TipoCampo='C' then Result:=Campo+'<>'+StringToSql(Lista[0]);
       if TipoCampo='N' then Result:=Campo+'<>'+Lista[0];
    end else if Lista.Count>1 then begin
       Result:=Campo+' NOT IN (';
       if TipoCampo='C' then for i:=0 to Lista.Count-1 do Result:=Result+StringToSql(Lista[i])+',';
       if TipoCampo='N' then for i:=0 to Lista.Count-1 do Result:=Result+Lista[i]+',';
       Result:=LeftStr(Result,Length(Result)-1);
       Result:=Result+')';
    end;
    Lista.Free;
  end else
    result:=''
end;


procedure TFGeral.EntidadesCreate(QOrigem:TSqlQuery;CpoCatEntidade,CpoCodEntidade:String);
var sClientes,sFornecedores,sFuncionarios,sUnidades:String;
    Cat,Codigo:String;

    procedure SetaLista(Str,Tabela,CpoCodigo,CpoNome,CpoRazao,CpoCNPJCPF,CpoContabil,CpoMuni,CpoEndereco,CpoBairro,CpoCEP,Cat,CpoCodVinc,CpoInscrEst:String);
    var Q:TSqlQuery;
        w:String;

        function GetWhere:String;
        var Lista:TStringList;
            Menor,Maior,i:Integer;
        begin
          Menor:=9999999;Maior:=0;
          Lista:=TStringList.Create;
          StrToLista(Lista,Str,',',False);
          for i:=0 to Lista.Count-1 do begin
              if Inteiro(Lista[i])<Menor then Menor:=Inteiro(Lista[i]);
              if Inteiro(Lista[i])>Maior then Maior:=Inteiro(Lista[i]);
          end;
          Lista.Free;
          Result:=' WHERE '+CpoCodigo+' BETWEEN '+IntToStr(Menor)+' AND '+IntToStr(Maior);
        end;

    begin
      if Str='' then Exit;
      Str:=LeftStr(Str,Length(Str)-1);
      w:=' WHERE '+CpoCodigo+' IN ('+Str+')';
      if Length(w)>9000 then w:=GetWhere;
      if Cat='F' then begin
         Q:=SqlToQuery('SELECT '+CpoCodigo+','+CpoNome+','+CpoRazao+','+CpoCNPJCPF+','+CpoContabil+','+CpoMuni+','+CpoEndereco+','+CpoBairro+','+CpoCEP+','+CpoCodVinc+','+CpoInscrEst+' FROM '+Tabela+w);
      end else if Cat='I' then begin
         Q:=SqlToQuery('SELECT '+CpoCodigo+','+CpoNome+','+CpoCNPJCPF+','+CpoMuni+','+CpoEndereco+','+CpoBairro+','+CpoCEP+' FROM '+Tabela+w);
      end else begin
         Q:=SqlToQuery('SELECT '+CpoCodigo+','+CpoNome+','+CpoRazao+','+CpoCNPJCPF+','+CpoContabil+','+CpoMuni+','+CpoEndereco+','+CpoBairro+','+CpoCEP+','+CpoInscrEst+' FROM '+Tabela+w);
      end;
      while not Q.Eof do begin
        New(Global.PEntidades);
        Global.PEntidades^.Categoria:=Cat;
        Global.PEntidades^.Codigo:=Q.FieldByName(CpoCodigo).AsInteger;
        Global.PEntidades^.Nome:=Trim(Q.FieldByName(CpoNome).AsString);
        Global.PEntidades^.CodVinc:=0;
        if CpoRazao<>'' then begin
           Global.PEntidades^.Razao:=Trim(Q.FieldByName(CpoRazao).AsString);
        end else begin
           Global.PEntidades^.Razao:=Trim(Q.FieldByName(CpoNome).AsString);
        end;
        if Trim(Global.PEntidades^.Razao)='' then Global.PEntidades^.Razao:=Global.PEntidades^.Nome;
        Global.PEntidades^.CNPJCPF:=Trim(Q.FieldByName(CpoCNPJCPF).AsString);
        Global.PEntidades^.ContaContabil:=0;
        Global.PEntidades^.CodigoMunicipio:=Q.FieldByName(CpoMuni).AsInteger;
        if Cat<>'I' then Global.PEntidades^.ContaContabil:=Q.FieldByName(CpoContabil).AsInteger;
        if Cat<>'I' then Global.PEntidades^.InscricaoEstadual:=Trim(Q.FieldByName(CpoInscrEst).AsString);
        if Cat='F' then Global.PEntidades^.CodVinc:=Q.FieldByName(CpoCodVinc).AsInteger;
        Global.PEntidades^.Endereco:=Trim(Q.FieldByName(CpoEndereco).AsString);
        Global.PEntidades^.Bairro:=Trim(Q.FieldByName(CpoBairro).AsString);
        Global.PEntidades^.CEP:=Trim(Q.FieldByName(CpoCEP).AsString);
        Global.Entidades.Add(Global.PEntidades);
        Q.Next;
      end;
      Q.Close;Q.Free;
    end;
begin
  EntidadesClear;
  New(Global.PEntidades);
  Global.PEntidades^.Categoria:='';Global.PEntidades^.Codigo:=0;Global.PEntidades^.Nome:='';Global.PEntidades^.Razao:='';
  Global.PEntidades^.CNPJCPF:='';Global.PEntidades^.ContaContabil:=0;Global.PEntidades^.CodigoMunicipio:=0;Global.PEntidades^.Endereco:='';
  Global.PEntidades^.Bairro:='';Global.PEntidades^.CEP:='';
  Global.Entidades.Add(Global.PEntidades);
  QOrigem.First;
  while not QOrigem.Eof do begin
    if Length(CpoCatEntidade)=1 then begin
       Cat:=CpoCatEntidade;
    end else begin
       Cat:=QOrigem.FieldByName(CpoCatEntidade).AsString;
    end;
    Codigo:=IntToStr(QOrigem.FieldByName(CpoCodEntidade).AsInteger);
    if not EntidadesGetDados(Cat,Inteiro(Codigo)) then begin
       if Cat='C' then sClientes:=sClientes+Codigo+','
       else if Cat='F' then sFornecedores:=sFornecedores+Codigo+','
       else if Cat='I' then sFuncionarios:=sFuncionarios+Codigo+','
       else if Cat='U' then sUnidades:=sUnidades+StringToSql(StrZero(Inteiro(Codigo),3))+',';
    end;
    QOrigem.Next;
  end;
  SetaLista(sClientes,'Clientes','Clie_Codigo','Clie_Nome','Clie_RazaoSocial','Clie_CNPJCPF','Clie_ContaContabil','Clie_Muni_Codigo_Res','Clie_EndRes','Clie_BairroRes','Clie_CEPRes','C','','Clie_RgIe');
  SetaLista(sFornecedores,'Fornecedores','Forn_Codigo','Forn_Nome','Forn_RazaoSocial','Forn_CNPJCPF','Forn_ContaContabil','Forn_Muni_Codigo','Forn_Endereco','Forn_Bairro','Forn_CEP','F','Forn_CodVinc','Forn_InscricaoEstadual');
  SetaLista(sFuncionarios,'Funcionarios','Func_Codigo','Func_Nome','','Func_CPF','','Func_Muni_Codigo','Func_Endereco','Func_Bairro','Func_CEP','I','','');
  SetaLista(sUnidades,'Unidades','Unid_Codigo','Unid_Nome','Unid_RazaoSocial','Unid_CNPJ','Unid_ContaContabil','Unid_Muni_Codigo','Unid_Endereco','Unid_Bairro','Unid_CEP','U','','Unid_InscricaoEstadual');
  QOrigem.First;
end;


procedure TFGeral.EntidadesCreateStr(StrEntidades,Cat:String);
var sClientes,sFornecedores,sFuncionarios,sUnidades:String;

    procedure SetaLista(Str,Tabela,CpoCodigo,CpoNome,CpoRazao,CpoCNPJCPF,CpoContabil,CpoMuni,CpoEndereco,CpoBairro,CpoCEP,Cat:String);
    var Q:TSqlQuery;
        w:String;

        function GetWhere:String;
        var Lista:TStringList;
            Menor,Maior,i:Integer;
        begin
          Menor:=9999999;Maior:=0;
          Lista:=TStringList.Create;
          StrToLista(Lista,Str,',',False);
          for i:=0 to Lista.Count-1 do begin
              if Inteiro(Lista[i])<Menor then Menor:=Inteiro(Lista[i]);
              if Inteiro(Lista[i])>Maior then Maior:=Inteiro(Lista[i]);
          end;
          Lista.Free;
          Result:=' WHERE '+CpoCodigo+' BETWEEN '+IntToStr(Menor)+' AND '+IntToStr(Maior);
        end;

    begin
      if Str='' then Exit;
      Str:=LeftStr(Str,Length(Str)-1);
      w:=' WHERE '+CpoCodigo+' IN ('+Str+')';
      if Length(w)>9000 then w:=GetWhere;
      if CpoRazao<>'' then begin
         Q:=SqlToQuery('SELECT '+CpoCodigo+','+CpoNome+','+CpoRazao+','+CpoCNPJCPF+','+CpoContabil+','+CpoMuni+','+CpoEndereco+','+CpoBairro+','+CpoCEP+' FROM '+Tabela+w);
      end else begin
         Q:=SqlToQuery('SELECT '+CpoCodigo+','+CpoNome+','+CpoCNPJCPF+','+CpoMuni+','+CpoEndereco+','+CpoBairro+','+CpoCEP+' FROM '+Tabela+w);
      end;
      while not Q.Eof do begin
        New(Global.PEntidades);
        Global.PEntidades^.Categoria:=Cat;
        Global.PEntidades^.Codigo:=Q.FieldByName(CpoCodigo).AsInteger;
        Global.PEntidades^.Nome:=Trim(Q.FieldByName(CpoNome).AsString);
        if CpoRazao<>'' then begin
           Global.PEntidades^.Razao:=Trim(Q.FieldByName(CpoRazao).AsString);
        end else begin
           Global.PEntidades^.Razao:=Trim(Q.FieldByName(CpoNome).AsString);
        end;
        if Trim(Global.PEntidades^.Razao)='' then Global.PEntidades^.Razao:=Global.PEntidades^.Nome;
        Global.PEntidades^.CNPJCPF:=Trim(Q.FieldByName(CpoCNPJCPF).AsString);
        Global.PEntidades^.ContaContabil:=0;
        Global.PEntidades^.CodigoMunicipio:=Q.FieldByName(CpoMuni).AsInteger;
        if CpoRazao<>'' then Global.PEntidades^.ContaContabil:=Q.FieldByName(CpoContabil).AsInteger;
        Global.PEntidades^.Endereco:=Trim(Q.FieldByName(CpoEndereco).AsString);
        Global.PEntidades^.Bairro:=Trim(Q.FieldByName(CpoBairro).AsString);
        Global.PEntidades^.CEP:=Trim(Q.FieldByName(CpoCEP).AsString);
        Global.Entidades.Add(Global.PEntidades);
        Q.Next;
      end;
      Q.Close;Q.Free;
    end;
begin
  if Cat='F' then sFornecedores:=StrEntidades;
  if Cat='C' then sClientes:=StrEntidades;
  if Cat='I' then sFuncionarios:=StrEntidades;
  if Cat='U' then sUnidades:=StrEntidades;
  EntidadesClear;
  New(Global.PEntidades);
  Global.PEntidades^.Categoria:='';Global.PEntidades^.Codigo:=0;Global.PEntidades^.Nome:='';Global.PEntidades^.Razao:='';
  Global.PEntidades^.CNPJCPF:='';Global.PEntidades^.ContaContabil:=0;Global.PEntidades^.CodigoMunicipio:=0;Global.PEntidades^.Endereco:='';
  Global.PEntidades^.Bairro:='';Global.PEntidades^.CEP:='';
  Global.Entidades.Add(Global.PEntidades);
  SetaLista(sClientes,'Clientes','Clie_Codigo','Clie_Nome','Clie_RazaoSocial','Clie_CNPJCPF','Clie_ContaContabil','Clie_Muni_Codigo_Res','Clie_EndRes','Clie_BairroRes','Clie_CEPRes','C');
  SetaLista(sFornecedores,'Fornecedores','Forn_Codigo','Forn_Nome','Forn_RazaoSocial','Forn_CNPJCPF','Forn_ContaContabil','Forn_Muni_Codigo','Forn_Endereco','Forn_Bairro','Forn_CEP','F');
  SetaLista(sFuncionarios,'Funcionarios','Func_Codigo','Func_Nome','','Func_CPF','','Func_Muni_Codigo','Func_Endereco','Func_Bairro','Func_CEP','I');
  SetaLista(sUnidades,'Unidades','Unid_Codigo','Unid_Nome','Unid_RazaoSocial','Unid_CNPJ','Unid_ContaContabil','Unid_Muni_Codigo','Unid_Endereco','Unid_Bairro','Unid_CEP','U');
end;



function TFGeral.EntidadesGetDados(Cat:String;Codigo:Integer):Boolean;
var i:Integer;
begin
  Result:=False;
  for i:=0 to Global.Entidades.Count-1 do begin
      Global.PEntidades:=Global.Entidades.items[i];
      if (Global.PEntidades^.Codigo=Codigo) and (Global.PEntidades^.Categoria=Cat) then begin
         Result:=True;
         Break;
      end;
  end;
  if not Result then Global.PEntidades:=Global.Entidades.items[0];
end;

procedure TFGeral.EntidadesClear;
var i:Integer;
begin
  for i:=0 to Global.Entidades.Count-1 do begin
      Global.PEntidades:=Global.Entidades.items[i];
      Dispose(Global.PEntidades);
  end;
  Global.Entidades.Clear;
end;



function TFGeral.GetValorLiquidoPendFin(QPendFin:TSqlQuery):Currency;
begin
  Result:=QPendFin.FieldByName('Pfin_Valor').AsFloat;
  Result:=Result+QPendFin.FieldByName('Pfin_Juros').AsFloat;
  Result:=Result+QPendFin.FieldByName('Pfin_Multa').AsFloat;
  Result:=Result+QPendFin.FieldByName('Pfin_Mora').AsFloat;
  Result:=Result+QPendFin.FieldByName('Pfin_Acrescimos').AsFloat;
  Result:=Result-QPendFin.FieldByName('Pfin_Abatimentos').AsFloat;
  Result:=Result-QPendFin.FieldByName('Pfin_Descontos').AsFloat;
  Result:=Result+QPendFin.FieldByName('Pfin_CorrMonet').AsFloat;
  Result:=Result-QPendFin.FieldByName('Pfin_TxAdm').AsFloat;
  Result:=Result-QPendFin.FieldByName('Pfin_BaixaParcial').AsFloat;
end;


function TFGeral.GetStrPeriodo(m:String = ''):String;
begin
  if m<>'' then m:=' '+m;
  Result:='Per�odo'+m+': '+DateToStr_(Sistema.Datai)+' a '+DateToStr_(Sistema.Dataf);
end;

procedure TFGeral.GravaDiario(Data:TDateTime;Campo,Conteudo:String;Commit:Boolean);
var Q:TSqlQuery;
begin
  Q:=SqlToQuery('SELECT Count(*) AS Registros FROM Diario WHERE Diar_Data='+DateToSql(Data));
  if Q.FieldByName('Registros').AsInteger=0 then begin
     Sistema.Insert('Diario');
     Sistema.SetField('Diar_Data',Data);
     Sistema.SetField(Campo,Conteudo);
     Sistema.Post;
     if Commit then Sistema.Commit;
  end else begin
     Sistema.Edit('Diario');
     Sistema.SetField(Campo,Conteudo);
     Sistema.Post('Diar_Data='+DateToSql(Data));
     if Commit then Sistema.Commit;
  end;
  Q.Close;Q.Free;
end;

function TFGeral.GetCampoDiario(Data:TDateTime;Campo:String):String;
var Q:TSqlQuery;
begin
  Q:=SqlToQuery('SELECT '+Campo+' FROM Diario WHERE Diar_Data='+DateToSql(Data));
  Result:=Trim(Q.FieldByName(Campo).AsString);
  Q.Close;Q.Free;
end;


procedure TFGeral.GetSaldosIniciaisMovGer(Data:TDateTime;Mat:TList;ContasValidas:String);
var DataUltimoEncerramento:TDateTime;
    PMat:TPSaldo;
    Q:TSqlQuery;
    s:String;
    ContasValidasSaldo,ContasValidasMvto:String;

    procedure SetaMat(const Conta:Integer;const Unidade,DC:String;const Valor,ValorMoeda:Currency;Substituir:Boolean);
    var i,m:Integer;
        Found:Boolean;
        v,vm:Currency;
    begin
      m:=1;if DC='D' then m:=-1;
      v:=Valor*m;
      vm:=ValorMoeda*m;
      Found:=False;
      for i:=0 to Mat.Count-1 do begin
          PMat:=Mat.Items[i];
          if (PMat^.Conta=Conta) and (PMat^.Unidade=Unidade) then begin
             Found:=True;
             if Substituir then PMat^.Valor:=v else PMat^.Valor:=PMat^.Valor+v;
             if Substituir then PMat^.ValorMoeda:=vm else PMat^.ValorMoeda:=PMat^.ValorMoeda+vm;
             Break;
          end
      end;
      if not Found then begin
         New(PMat);
         PMat^.Conta:=Conta;
         PMat^.Unidade:=Unidade;
         PMat^.Valor:=v;
         PMat^.ValorMoeda:=vm;
         Mat.Add(PMat);
      end;
    end;

begin
  if ContasValidas<>'' then begin
     ContasValidasSaldo:=' AND '+GetIN('Sger_plan_Conta',ContasValidas,'N');
     ContasValidasMvto:=' AND '+GetIN('Mger_plan_Conta',ContasValidas,'N');
  end;
  Q:=SqlToQuery('SELECT * FROM SaldosGer WHERE Sger_Data='+DateToSql(Global.DataMinima)+ContasValidasSaldo);
  while not Q.Eof do begin
    SetaMat(Q.FieldByName('Sger_plan_Conta').AsInteger,Q.FieldByName('Sger_Unid_Codigo').AsString,Q.FieldByName('Sger_DC').AsString,Q.FieldByName('Sger_Valor').AsFloat,Q.FieldByName('Sger_ValorMoeda').AsFloat,True);
    Q.Next;
  end;
  Q.Close;Q.Free;
  Q:=SqlToQuery('SELECT MAX(Sger_Data) AS Sger_Data FROM SaldosGer WHERE Sger_Data<='+DateToSql(Data)+ContasValidasSaldo);
  DataUltimoEncerramento:=Q.FieldByName('Sger_Data').AsDateTime;
  if (DataUltimoEncerramento>Global.DataMinima) and (DataUltimoEncerramento<Data) then begin
     Q:=SqlToQuery('SELECT * FROM SaldosGer WHERE Sger_Data='+DateToSql(DataUltimoEncerramento));
     while not Q.Eof do begin
       SetaMat(Q.FieldByName('Sger_plan_Conta').AsInteger,Q.FieldByName('Sger_Unid_Codigo').AsString,Q.FieldByName('Sger_DC').AsString,Q.FieldByName('Sger_Valor').AsFloat,Q.FieldByName('Sger_ValorMoeda').AsFloat,True);
       Q.Next;
     end;
  end;
  Q.Close;Q.Free;
  if (Data-1)>DataUltimoEncerramento then begin
     s:='SELECT Mger_DC,Mger_Unid_Codigo,Mger_plan_Conta,SUM(Mger_Valor) AS Mger_Valor,SUM(Mger_ValorMoeda) AS Mger_ValorMoeda FROM MovGer';
     s:=s+' WHERE Mger_DataMvto>'+DateToSql(DataUltimoEncerramento)+' AND Mger_DataMvto<'+DateToSql(Data);
     s:=s+' AND Mger_Status='+StringToSql('N');
     s:=s+ContasValidasMvto;
     s:=s+' GROUP BY Mger_plan_Conta,Mger_Unid_Codigo,Mger_DC';
     Q:=SqlToQuery(s);
     while not Q.Eof do begin
       SetaMat(Q.FieldByName('Mger_plan_Conta').AsInteger,Q.FieldByName('Mger_Unid_Codigo').AsString,Q.FieldByName('Mger_DC').AsString,Q.FieldByName('Mger_Valor').AsFloat,Q.FieldByName('Mger_ValorMoeda').AsFloat,False);
       Q.Next;
     end;
     Q.Close;Q.Free;
  end;
end;

procedure TFGeral.GetSaldosIniciaisBancarios(Data:TDateTime;Mat:TList;ContasValidas:String);
var PMat:TPSaldoBco;
    ContasValidasSaldo,ContasValidasMvto:String;
    DataUltimoEncerramento:TDateTime;

    procedure SetaMat(const Conta:Integer;ES:String;const Valor:Currency;Substituir:Boolean);
    var i,m:Integer;
        Found:Boolean;
        v:Currency;
    begin
      m:=1;
      if ES='S' then m:=-1;
      if ES='D' then m:=-1;
      v:=Valor*m;
      Found:=False;
      for i:=0 to Mat.Count-1 do begin
          PMat:=Mat.Items[i];
          if PMat^.Conta=Conta then begin
             Found:=True;
             if Substituir then PMat^.Valor:=v else PMat^.Valor:=PMat^.Valor+v;
             Break;
          end
      end;
      if not Found then begin
         New(PMat);
         PMat^.Conta:=Conta;
         PMat^.Valor:=v;
         Mat.Add(PMat);
      end;
    end;

    procedure SetaSaldos;
    var Q:TSqlQuery;
        s:String;
    begin
       Q:=SqlToQuery('SELECT * FROM SaldosBco WHERE Sbco_Data='+DateToSql(Global.DataMinima)+' AND '+ContasValidasSaldo);
       while not Q.Eof do begin
         SetaMat(Q.FieldByName('Sbco_plan_Conta').AsInteger,Q.FieldByName('Sbco_DC').AsString,Q.FieldByName('Sbco_Valor').AsFloat,True);
         Q.Next;
       end;
       Q.Close;Q.Free;
       if Data>0 then begin
          Q:=SqlToQuery('SELECT MAX(Sbco_Data) AS Sbco_Data FROM SaldosBco WHERE Sbco_Data<='+DateToSql(Data)+' AND '+ContasValidasSaldo);
       end else begin
          Q:=SqlToQuery('SELECT MAX(Sbco_Data) AS Sbco_Data FROM SaldosBco WHERE '+ContasValidasSaldo);
       end;
       DataUltimoEncerramento:=Q.FieldByName('Sbco_Data').AsDateTime;
       if (DataUltimoEncerramento>Global.DataMinima) and ((Data=0) or (DataUltimoEncerramento<Data))  then begin
          Q:=SqlToQuery('SELECT * FROM SaldosBco WHERE Sbco_Data='+DateToSql(DataUltimoEncerramento));
          while not Q.Eof do begin
            SetaMat(Q.FieldByName('Sbco_plan_Conta').AsInteger,Q.FieldByName('Sbco_DC').AsString,Q.FieldByName('Sbco_Valor').AsFloat,True);
            Q.Next;
          end;
       end;
       Q.Close;Q.Free;
       if (Data=0) or ((Data-1)>DataUltimoEncerramento) then begin
          s:='SELECT Mbco_ES,Mbco_plan_Conta,SUM(Mbco_ValorBco) AS Mbco_ValorBco FROM MovBco';
          if Data>0 then begin
             s:=s+' WHERE Mbco_DataExtrato>'+DateToSql(DataUltimoEncerramento)+' AND Mbco_DataExtrato<'+DateToSql(Data);
          end else begin
             s:=s+' WHERE Mbco_DataExtrato>'+DateToSql(DataUltimoEncerramento);
          end;
          s:=s+' AND '+FGeral.GetIN('Mbco_Status','N;D','C');
          s:=s+' AND '+ContasValidasMvto;
          s:=s+' GROUP BY Mbco_plan_Conta,Mbco_ES';
          Q:=SqlToQuery(s);
          while not Q.Eof do begin
            SetaMat(Q.FieldByName('Mbco_plan_Conta').AsInteger,Q.FieldByName('Mbco_ES').AsString,Q.FieldByName('Mbco_ValorBco').AsFloat,False);
            Q.Next;
          end;
          Q.Close;Q.Free;
       end;
    end;

begin
  if ContasValidas<>'' then begin
     ContasValidasSaldo:=GetIN('Sbco_plan_Conta',ContasValidas,'N');
     ContasValidasMvto:=GetIN('Mbco_plan_Conta',ContasValidas,'N');
  end;
  SetaSaldos;
end;



function TFGeral.GetSaldoInicialMovGer(Conta:Integer;Unidade:String;Data:TDateTime):Currency;
var DataUltimoEncerramento:TDateTime;
    Q:TSqlQuery;

    function GetMvto(DC:String):Currency;
    var Q:TSqlQuery;
        w:String;
    begin
      w:=' WHERE Mger_DataMvto>'+DateToSql(DataUltimoEncerramento);
      w:=w+' AND Mger_DataMvto<'+DateToSql(Data);
      w:=w+' AND Mger_plan_Conta='+IntToStr(Conta);
      w:=w+' AND Mger_Unid_Codigo='+StringToSql(Unidade);
      w:=w+' AND Mger_Status='+StringToSql('N');
      w:=w+' AND Mger_DC='+StringToSql(DC);
      Q:=SqlToQuery('SELECT SUM(Mger_Valor) AS Total FROM MovGer'+w);
      Result:=Q.FieldByName('Total').AsFloat;
      Q.Close;Q.Free;
    end;

begin
  Result:=0;
  Q:=SqlToQuery('SELECT * FROM SaldosGer WHERE Sger_Data='+DateToSql(Global.DataMinima)+' AND Sger_plan_Conta='+IntToStr(Conta)+' AND Sger_Unid_Codigo='+StringToSql(Unidade));
  if not Q.isEmpty then begin
     Result:=Q.FieldByName('Sger_Valor').AsFloat;
     if Q.FieldByName('Sger_DC').AsString='D' then Result:=Result*-1;
  end;
  Q.Close;Q.Free;
  Q:=SqlToQuery('SELECT MAX(Sger_Data) AS Sger_Data FROM SaldosGer WHERE Sger_Data<='+DateToSql(Data)+' AND Sger_plan_Conta='+IntToStr(Conta)+' AND Sger_Unid_Codigo='+StringToSql(Unidade));
  DataUltimoEncerramento:=Q.FieldByName('Sger_Data').AsDateTime;
  Q.Close;Q.Free;
  if (DataUltimoEncerramento>Global.DataMinima) and (DataUltimoEncerramento<Data) then begin
     Q:=SqlToQuery('SELECT * FROM SaldosGer WHERE Sger_Data='+DateToSql(DataUltimoEncerramento)+' AND Sger_plan_Conta='+IntToStr(Conta)+' AND Sger_Unid_Codigo='+StringToSql(Unidade));
     if not Q.isEmpty then begin
        Result:=Q.FieldByName('Sger_Valor').AsFloat;
        if Q.FieldByName('Sger_DC').AsString='D' then Result:=Result*-1;
     end;
     Q.Close;Q.Free;
  end;
  if (Data-1)>DataUltimoEncerramento then begin
     Result:=Result+GetMvto('C')-GetMvto('D');
  end;
end;

function TFGeral.GetSaldoInicialMovGerMoeda(Conta:Integer;Unidade:String;Data:TDateTime):Currency;
var DataUltimoEncerramento:TDateTime;
    Q:TSqlQuery;

    function GetMvto(DC:String):Currency;
    var Q:TSqlQuery;
        w:String;
    begin
      w:=' WHERE Mger_DataMvto>'+DateToSql(DataUltimoEncerramento);
      w:=w+' AND Mger_DataMvto<'+DateToSql(Data);
      w:=w+' AND Mger_plan_Conta='+IntToStr(Conta);
      w:=w+' AND Mger_Unid_Codigo='+StringToSql(Unidade);
      w:=w+' AND Mger_Status='+StringToSql('N');
      w:=w+' AND Mger_DC='+StringToSql(DC);
      Q:=SqlToQuery('SELECT SUM(Mger_ValorMoeda) AS Total FROM MovGer'+w);
      Result:=Q.FieldByName('Total').AsFloat;
      Q.Close;Q.Free;
    end;

begin
  Result:=0;
  Q:=SqlToQuery('SELECT * FROM SaldosGer WHERE Sger_Data='+DateToSql(Global.DataMinima)+' AND Sger_plan_Conta='+IntToStr(Conta)+' AND Sger_Unid_Codigo='+StringToSql(Unidade));
  if not Q.isEmpty then begin
     Result:=Q.FieldByName('Sger_ValorMoeda').AsFloat;
     if Q.FieldByName('Sger_DC').AsString='D' then Result:=Result*-1;
  end;
  Q.Close;Q.Free;
  Q:=SqlToQuery('SELECT MAX(Sger_Data) AS Sger_Data FROM SaldosGer WHERE Sger_Data<='+DateToSql(Data)+' AND Sger_plan_Conta='+IntToStr(Conta)+' AND Sger_Unid_Codigo='+StringToSql(Unidade));
  DataUltimoEncerramento:=Q.FieldByName('Sger_Data').AsDateTime;
  Q.Close;Q.Free;
  if (DataUltimoEncerramento>Global.DataMinima) and (DataUltimoEncerramento<Data) then begin
     Q:=SqlToQuery('SELECT * FROM SaldosGer WHERE Sger_Data='+DateToSql(DataUltimoEncerramento)+' AND Sger_plan_Conta='+IntToStr(Conta)+' AND Sger_Unid_Codigo='+StringToSql(Unidade));
     if not Q.isEmpty then begin
        Result:=Q.FieldByName('Sger_ValorMoeda').AsFloat;
        if Q.FieldByName('Sger_DC').AsString='D' then Result:=Result*-1;
     end;
     Q.Close;Q.Free;
  end;
  if (Data-1)>DataUltimoEncerramento then begin
     Result:=Result+GetMvto('C')-GetMvto('D');
  end;
end;


function TFGeral.GetSaldoInicialBancario(Conta:Integer;Data:TDateTime):Currency;
var Datai:TDateTime;

   function GetSaldoAnterior:Currency;
   var Q:TSqlQuery;
       s:String;
   begin
     Result:=0;
     Datai:=Global.DataMinima;
     s:='SELECT Sbco_Valor,Sbco_Data,Sbco_DC FROM SaldosBco WHERE Sbco_plan_Conta='+IntToStr(Conta)+' AND Sbco_Data=';
     s:=s+'(SELECT MAX(Sbco_Data) FROM SaldosBco WHERE Sbco_plan_Conta='+IntToStr(Conta)+' AND Sbco_Data<='+DateToSql(Data)+')';
     Q:=SqlToQuery(s);
     if not Q.IsEmpty then begin
        Result:=Q.FieldByName('Sbco_Valor').AsFloat;
        Datai:=Q.FieldByName('Sbco_Data').AsDateTime;
        if Q.FieldByName('Sbco_DC').AsString='D' then Result:=Result*-1;
     end;
     Q.Close;Freeandnil(Q);
   end;

   function GetMvto(ES:String):Currency;
   var Q:TSqlQuery;
       w:String;
   begin
     w:=' WHERE Mbco_DataExtrato>'+DateToSql(DataI);
     w:=w+' AND Mbco_DataExtrato<='+DateToSql(Data);
     w:=w+' AND Mbco_plan_Conta='+IntToStr(Conta);
     w:=w+' AND (Mbco_Status='+StringToSql('N')+' OR Mbco_Status='+StringToSql('D')+')';
     w:=w+' AND Mbco_ES='+StringToSql(ES);
     Q:=SqlToQuery('SELECT SUM(Mbco_ValorBco) AS Total FROM MovBco'+w);
     Result:=Q.FieldByName('Total').AsFloat;
     Q.Close;Q.Free;
   end;

begin
  Result:=GetSaldoAnterior+GetMvto('E')-GetMvto('S');
end;


procedure TFGeral.GetSaldosIniciaisMovCon(Data:TDateTime;Mat:TList;ContasValidas:String);
var DataUltimoEncerramento:TDateTime;
    PMat:TPSaldo;
    Q:TSqlQuery;
    s:String;
    ContasValidasSaldo,ContasValidasMvto:String;

    procedure SetaMat(const Conta:Integer;const Unidade,DC:String;const Valor:Currency;Substituir:Boolean);
    var i,m:Integer;
        Found:Boolean;
        v:Currency;
    begin
      m:=1;if DC='D' then m:=-1;
      v:=Valor*m;
      Found:=False;
      for i:=0 to Mat.Count-1 do begin
          PMat:=Mat.Items[i];
          if (PMat^.Conta=Conta) and (PMat^.Unidade=Unidade) then begin
             Found:=True;
             if Substituir then PMat^.Valor:=v else PMat^.Valor:=PMat^.Valor+v;
             Break;
          end
      end;
      if not Found then begin
         New(PMat);
         PMat^.Conta:=Conta;
         PMat^.Unidade:=Unidade;
         PMat^.Valor:=v;
         Mat.Add(PMat);
      end;
    end;

begin
  if ContasValidas<>'' then begin
     ContasValidasSaldo:=' AND '+GetIN('Scon_Pcon_Conta',ContasValidas,'N');
     ContasValidasMvto:=' AND '+GetIN('Mcon_Pcon_Conta',ContasValidas,'N');
  end;
  Q:=SqlToQuery('SELECT * FROM SaldosCon WHERE Scon_Data='+DateToSql(Global.DataMinima)+ContasValidasSaldo);
  while not Q.Eof do begin
    SetaMat(Q.FieldByName('Scon_Pcon_Conta').AsInteger,Q.FieldByName('Scon_Unid_Codigo').AsString,Q.FieldByName('Scon_DEBCRE').AsString,Q.FieldByName('Scon_Valor').AsFloat,True);
    Q.Next;
  end;
  Q.Close;Q.Free;
  Q:=SqlToQuery('SELECT MAX(Scon_Data) AS Scon_Data FROM SaldosCon WHERE Scon_Data<='+DateToSql(Data)+ContasValidasSaldo);
  DataUltimoEncerramento:=Q.FieldByName('Scon_Data').AsDateTime;
  if (DataUltimoEncerramento>Global.DataMinima) and (DataUltimoEncerramento<Data) then begin
     Q:=SqlToQuery('SELECT * FROM SaldosCon WHERE Scon_Data='+DateToSql(DataUltimoEncerramento));
     while not Q.Eof do begin
       SetaMat(Q.FieldByName('Scon_Pcon_Conta').AsInteger,Q.FieldByName('Scon_Unid_Codigo').AsString,Q.FieldByName('Scon_DEBCRE').AsString,Q.FieldByName('Scon_Valor').AsFloat,True);
       Q.Next;
     end;
  end;
  Q.Close;Q.Free;
  if (Data-1)>DataUltimoEncerramento then begin
     s:='SELECT Mcon_DC,Mcon_Unid_Codigo,Mcon_Pcon_Conta,SUM(Mcon_Valor) AS Mcon_Valor FROM MovCon';
     s:=s+' WHERE Mcon_DataMvto>'+DateToSql(DataUltimoEncerramento)+' AND Mcon_DataMvto<'+DateToSql(Data);
     s:=s+' AND Mcon_Status='+StringToSql('N');
     s:=s+ContasValidasMvto;
     s:=s+' GROUP BY Mcon_Pcon_Conta,Mcon_Unid_Codigo,Mcon_DC';
     Q:=SqlToQuery(s);
     while not Q.Eof do begin
       SetaMat(Q.FieldByName('Mcon_Pcon_Conta').AsInteger,Q.FieldByName('Mcon_Unid_Codigo').AsString,Q.FieldByName('Mcon_DC').AsString,Q.FieldByName('Mcon_Valor').AsFloat,False);
       Q.Next;
     end;
     Q.Close;Q.Free;
  end;
end;


function TFGeral.UnidadesToNomeEmpresa(Unidades:String):String;
var Lista:TStringList;
    u:Integer;
    Emp,Emps:String;
begin
  Result:='';
  Lista:=TStringList.Create;
  StrToLista(Lista,Unidades,';,',False);
  Unidades:=StrToStrNumeros(Unidades);
  if Lista.Count>0 then begin
     Emp:=Global.EmpresaUnidades[Inteiro(Lista[0])];
     for u:=1 to 999 do begin
         if Global.EmpresaUnidades[u]=Emp then Emps:=Emps+StrZero(u,3);
     end;
  end;
  if Emps=Unidades then Result:=FEmpresas.GetNome(Emp);
  Lista.Free;
end;


function TFGeral.Calcula(Formula:String;ListaVariaveis:TStringList;var Retorno:Extended):Boolean;
type TMat=record
     Nivel:Integer;
     Dado:String;
end;
var Macro:String;
    n,Max,i,p,Nivel,NivelMax:Integer;
    Mat:Array[1..99] of TMat;
    v,c:String;
    Found:Boolean;

    function Processa(const p:Integer;var wRet:Extended):Boolean;
    var v1,v2:Extended;
        i,p1,p2:Integer;
    begin
      Result:=True;
      wRet:=0;p1:=0;p2:=0;
      for i:=p-1 downto 1 do if (p1=0) and (Mat[i].Dado<>'') then p1:=i;
      for i:=p+1 to Max do if (p2=0) and (Mat[i].Dado<>'') then p2:=i;
      try
        if (Pos(Mat[p1].Dado,'*/')>0) or (Pos(Mat[p2].Dado,'*/')>0) then begin
           AvisoErro('Erro de operadores na f�rmula: '+Formula);
           Result:=False;
           Exit;
        end;
        v1:=TextToValor(Mat[p1].Dado);
        v2:=TextToValor(Mat[p2].Dado);
        if Mat[p].Dado='+' then wRet:=v1+v2
        else if Mat[p].Dado='-' then wRet:=v1-v2
        else if Mat[p].Dado='*' then wRet:=v1*v2
        else if Mat[p].Dado='/' then wRet:=Divide(v1,v2);
        Mat[p].Dado:=FloatToStr(wRet);Mat[p1].Nivel:=0;Mat[p2].Nivel:=0;
        Mat[p1].Dado:='';Mat[p2].Dado:='';
      except
        AvisoErro('Erro na f�rmula: '+Formula);
        Result:=False;
        Exit;
      end;
    end;

begin
  Result:=True;
  Macro:=Trim(UpperCase(Formula));
  for p:=1 to 99 do Mat[p].Nivel:=0;
  p:=1;
  Nivel:=1;
  NivelMax:=0;
  Max:=0;
  for i:=1 to Length(Macro) do begin
      if Pos(Macro[i],'*-/+')>0 then begin
         Inc(p);
         Mat[p].Dado:=Macro[i];
         Mat[p].Nivel:=Nivel;
         Inc(p);
      end else if Macro[i]='(' then begin
         Inc(Nivel);Inc(p);
      end else if Macro[i]=')' then begin
         Dec(Nivel);Inc(p);
      end else begin
         Mat[p].Nivel:=Nivel;
         Mat[p].Dado:=Mat[p].Dado+Macro[i];
      end;
  end;
  Max:=p;
  if ListaVariaveis<>nil then begin
     for p:=0 to ListaVariaveis.Count-1 do begin
         v:=UpperCase(LeftStr(ListaVariaveis[p],Pos('=',ListaVariaveis[p])-1));
         c:=FinalStr(ListaVariaveis[p],Pos('=',ListaVariaveis[p])+1);
         i:=Pos('-',c);if i>0 then c[i]:='_';
         for i:=1 to Max do if Mat[i].Dado=v then Mat[i].Dado:=c;
     end;
  end;
  if Nivel<>1 then begin
     AvisoErro('Erro de parenteses na f�rmula: '+Formula);
     Result:=False;
     Exit;
  end;
  for i:=1 to Max do begin
      Mat[i].Dado:=Trim(Mat[i].Dado);
      p:=Pos('_',Mat[i].Dado);if p>0 then Mat[i].Dado[p]:='-';
      v:=Mat[i].Dado;
      for p:=1 to Length(v) do begin
          if not (v[p] in ['0'..'9',' ','+','-','/','*','.',',']) then begin
             AvisoErro('Erro de vari�veis na f�rmula: '+Formula);
             Result:=False;
             Exit;
          end;
      end;
  end;
  for i:=1 to Max do if Mat[i].Nivel>NivelMax then NivelMax:=Mat[i].Nivel;
  for n:=NivelMax downto 1 do begin
      repeat
        Found:=False;
        for p:=1 to Max do begin
            if (Mat[p].Nivel=n) and (Mat[p].Dado<>'') and (Pos(Mat[p].Dado,'*-/+')>0) then begin
               if not Processa(p,Retorno) then begin
                  Result:=False;
                  Exit;
               end;
               Found:=True;
               Break;
             end;
         end;
      until not Found;
  end;
end;


function TFGeral.GetTituloUnidades(Unidades:String):String;
var Lista:TStringList;
    u:Integer;
    Geral:String;
begin
  Result:='';
  Lista:=TStringList.Create;
  StrToLista(Lista,Unidades,';,',False);
  if Lista.Count=1 then Result:='Unidade: '+Lista[0]+' - '+FUnidades.GetNome(Lista[0]);
  if (Result='') and (Lista.Count>1) then begin
     Geral:='';
     for u:=1 to 999 do if Global.ReduzidoUnidades[u]<>'' then Geral:=Geral+StrZero(u,3);
     if Geral=StrToStrNumeros(Unidades) then Result:='Unidades: Geral';
     if Result='' then begin
        Result:=UnidadesToNomeEmpresa(Unidades);
        if Result<>'' then Result:='Empresa: '+Result;
     end;   
     if Result='' then Result:='Unidades: '+Unidades;
  end;
end;


function TFGeral.GetTipoImposto(Codigo:String):String;
begin
  Result:='';
//  if not Arq.TSimbologias.Active then Arq.TSimbologias.Open;
//  if Arq.TSimbologias.Locate('Simb_Codigo', Codigo, []) then begin
//     Result:=Trim(Arq.TSimbologias.FieldByName('Simb_Imposto').AsString);
//  end;
end;



procedure TFGeral.LiberaCadastro(Grid:TSqlGrid);
begin
  if Trim(TSQLDs(Grid.DataSource.DataSet).GetFilter)<>'' then begin
     TSQLDs(Grid.DataSource.DataSet).SetFilter('');
     Grid.Cancel;
  end;
  if Trim(TSQLDs(Grid.DataSource.DataSet).GetFindBrowse)<>'' then begin
     Grid.ClearFind;
     Grid.Cancel;
  end;
end;

procedure AnexarStr(var Str1:String;const Str2:String);
begin
  Str1:=Str1+Str2;
end;

function TFGeral.GetFornecedoresVinculados(Codigo:Integer):String;
var Q:TSqlQuery;
    CodVinc:Integer;
begin
  Q:=SqlToQuery('SELECT Forn_CodVinc FROM Fornecedores WHERE Forn_Codigo='+IntToStr(Codigo));
  CodVinc:=Q.FieldByName('Forn_CodVinc').AsInteger;
  if CodVinc=0 then begin
     Result:=IntToStr(Codigo);
     Q.Close;Q.Free;
  end else begin
     Q.Close;Q.Free;
     Q:=SqlToQuery('SELECT Forn_Codigo FROM Fornecedores WHERE Forn_CodVinc='+IntToStr(CodVinc));
     while not Q.Eof do begin
       Result:=Result+IntToStr(Q.FieldByName('Forn_Codigo').AsInteger)+';';
       Q.Next;
     end;
     Q.Close;Q.Free;
  end;
end;


function TFGeral.UnidadeValida(Codigo:Integer):Boolean;
begin
  Result:=Global.ReduzidoUnidades[Codigo]<>'';
end;



procedure TFGeral.ValidaNumeroDcto(Edit:TSqlEd);
begin
  if (Global.Topicos[1421]) and (TSqlEd(Edit).IsEmpty) then begin
     TSqlEd(Edit).Invalid('N�mero de documento deve ser informado');
  end;
end;


procedure TFGeral.OrganizarBanco;
var Lista:TStringList;
    i:Integer;
begin
  Aviso('Op��o em desenvolvimento ainda n�o dispon�vel');
  exit;
  if not Confirma('Confirma a reorganiza��o do banco de dados') then Exit;
  if not FUsuarios.GetSenhaProcesso then Exit;
  if not Confirma('Confirma a reorganiza��o do banco de dados') then Exit;
  Sistema.BeginProcess('Reorganizando Banco De Dados');
  Lista:=TStringList.Create;
  Sistema.Conexao.GetTableNames(Lista,False);

  for i:=0 to Lista.Count-1 do begin
      Sistema.SetMessage('reorganizando '+Lista[i]);
//      ExecuteSql('reindex table '+Lista[i]+' force');
      Sistema.Conexao.ExecuteDirect('reindex table '+Lista[i]+' force');
// verificar
  end;
  Lista.Free;
  GravaLog(1,'');
  Sistema.EndProcess('Reorganiza��o Efetivada');
end;

procedure TFGeral.AlertaMensagem;
var Q:TSqlQuery;
begin
  if Global.SistemaParado then Exit;
  if Sistema.Processando then Exit;
  if Global.MensagemPendente then Exit;
//  Q:=SqlToQuery('SELECT Count(*) AS Registros FROM Mensagens WHERE Mens_Status=''P'' AND Mens_UsuDest='+IntToStr(Global.Usuario.Codigo));
//  Global.MensagemPendente:=Q.FieldByName('Registros').AsInteger>0;
//  Q.Close;Q.Free;
  TimerAlerta.Enabled:=Global.MensagemPendente;
  FMain.PAlerta.Caption:='';
  FMain.PAlerta.Color:=FMain.PMsg.Color;
end;

procedure TFGeral.TimerAlertaTimer(Sender: TObject);
begin
  if FMain.PAlerta.Tag=0 then FMain.PAlerta.Tag:=1 else FMain.PAlerta.Tag:=0;
  if FMain.PAlerta.Tag=0 then begin
     FMain.PAlerta.Caption:='';
     FMain.PAlerta.Color:=FMain.PMsg.Color;
  end else begin
     if Global.MensagemPendente then begin
        FMain.PAlerta.Caption:='Mensagem';
        FMain.PAlerta.Color:=clRed;
        FMain.PAlerta.Font.Color:=clWhite;
     end;
  end;
end;

procedure TFGeral.SolicitarUsoExclusivo;
var Q:TSqlQuery;
    u:Integer;
begin
  if (Global.Usuario.Suporte) or (Global.Usuario.SenhaDiaria) then begin
     AvisoErro('Usu�rio suporte, n�o permitido solicitar uso exclusivo');
     Exit;
  end;
  if not FUsuarios.GetSenhaProcesso then Exit;
  Q:=SqlToQuery('SELECT Ctrl_UsuExclusivo FROM Controle WHERE Ctrl_Registro=1');
  u:=Q.FieldByName('Ctrl_UsuExclusivo').AsInteger;
  Q.Close;Q.Free;
  if u=Global.Usuario.Codigo then begin
     AvisoErro('Aten��o, sistema j� est� com uso exclusivo para o usu�rio atual');
     Exit;
  end;
  if u>0 then begin
     AvisoErro('Aten��o, sistema j� est� com uso exclusivo para o; usu�rio: '+IntToStr(u)+' - '+FUsuarios.GetNome(u));
     Exit;
  end;
  if Confirma('Confirma a solicita��o de uso exclusivo') then begin
     Sistema.Edit('Controle');
     Sistema.SetField('Ctrl_UsuExclusivo',Global.Usuario.Codigo);
     Sistema.Post('Ctrl_Registro=1');
     Sistema.Commit;
     Aviso('Efetivada solicita��o para uso exclusivo');
  end;
end;

procedure TFGeral.LiberarUsoExclusivo;
var Q:TSqlQuery;
    u:Integer;
begin
  if (Global.Usuario.Suporte) or (Global.Usuario.SenhaDiaria) then begin
     AvisoErro('Usu�rio suporte, n�o permitido solicitar uso exclusivo');
     Exit;
  end;
  if not FUsuarios.GetSenhaProcesso then Exit;
  Q:=SqlToQuery('SELECT Ctrl_UsuExclusivo FROM Controle WHERE Ctrl_Registro=1');
  u:=Q.FieldByName('Ctrl_UsuExclusivo').AsInteger;
  Q.Close;Q.Free;
  if u<>Global.Usuario.Codigo then begin
     AvisoErro('Aten��o, sistema j� est� com uso exclusivo para o usu�rio: '+IntToStr(u)+' - '+FUsuarios.GetNome(u));
     Exit;
  end;
  if Confirma('Confirma a libera��o de uso exclusivo') then begin
     Sistema.Edit('Controle');
     Sistema.SetField('Ctrl_UsuExclusivo',0);
     Sistema.Post('Ctrl_Registro=1');
     Sistema.Commit;
     Aviso('Sistema liberado');
  end;
end;

procedure TFGeral.GravaLog(const CodigoEvento:Integer;const ComplementoEvento:String ; comitar:boolean=true ; transacao:string='' ; usuario:integer=0 ; motivo:string='' );
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
begin
  if (CodigoEvento<=0) or (CodigoEvento>High(Global.CodigosLog)-1) or (Global.CodigosLog[CodigoEvento]='') then begin
     AvisoErro('C�digo inv�lido para evento de log');
     Exit;
  end;
  Sistema.Insert('Log');
  Sistema.SetField('Log_Codigo',CodigoEvento);
  Sistema.SetField('Log_Data',Sistema.Hoje);
  Sistema.SetField('Log_Hora',TimeToStr(Now));
  Sistema.SetField('Log_Usua_Codigo',Global.Usuario.Codigo);
  if length(trim(complementoevento))>100 then
    Sistema.SetField('Log_Complemento',copy(ComplementoEvento,1,100) )
  else
    Sistema.SetField('Log_Complemento',ComplementoEvento );
  Sistema.SetField('log_usua_canc',usuario);
  Sistema.SetField('log_motivo',motivo);
  Sistema.SetField('log_transacaocanc',transacao);
  Sistema.Post;
  if comitar then
    Sistema.Commit;
end;

procedure TFGeral.SetaCodigosLog;
//////////////////////////////////////////////
// 14.02.06 - cuidar q no maximo 100 codigos...
begin
  Global.CodigosLog[001]:='Reorganizado banco de dados';
  Global.CodigosLog[002]:='Altera��o per�odo altera��o informa��es';
  Global.CodigosLog[003]:='Cancelamento de transa��o';
  Global.CodigosLog[004]:='Altera��o movimento financeiro';
  Global.CodigosLog[005]:='Cancelamento Pedido de Venda';
  Global.CodigosLog[006]:='Altera��o custo m�dio gerencial via cadastro';
  Global.CodigosLog[007]:='Altera��o nf saida';
  Global.CodigosLog[008]:='Manuten��o config. de movimentos';
  Global.CodigosLog[009]:='Manuten��o cadastro CFOPs ( naturezas fiscais )';
  Global.CodigosLog[010]:='Venda/Devolu��o indicando remessa sem produto )';
  Global.CodigosLog[011]:='Numera��o de nota perdida';
  Global.CodigosLog[012]:='Liberado Cr�dito com cheque devolvido';
  Global.CodigosLog[013]:='Altera��o pre�o de venda via cadastro';
// 22.05.07
  Global.CodigosLog[014]:='Nota de venda abaixo do pre�o m�nimo';
  Global.CodigosLog[015]:='Autorizado nota de venda abaixo do pre�o m�nimo';
// 23.05.07
  Global.CodigosLog[016]:='Autorizado venda para cliente com restri��o de cr�dito';
// 31.05.07
  Global.CodigosLog[017]:='Utilizado op��o igualar cadastro usu�rios';
// 05.06.07
  Global.CodigosLog[018]:='Liberado venda mesmo acima limite cr�dito';
// 09.08.07
  Global.CodigosLog[019]:='Alterado cidade, cfop nota fiscal';
// 12.09.07
  Global.CodigosLog[020]:='Exclus�o entrada de abate';
// 03.10.08
  Global.CodigosLog[020]:='Grava��o cadastro de usu�rios';
// 20.04.09
  Global.CodigosLog[021]:='Altera��o Valor pendencia financeira';
// 25.08.09
  Global.CodigosLog[022]:='Altera��o de Op��o de Or�amento de Obra Aprovada';
// 17.02.11
  Global.CodigosLog[023]:='Exclus�o de codigo do estoque';
// 23.05.11
  Global.CodigosLog[024]:='Faturamento abaixo do m�nimo por cidade';
// 08.06.11
  Global.CodigosLog[025]:='Gerou nota com diferen�a de pe�as/peso';
  Global.CodigosLog[026]:='Gravou peso da balan�a menor que o m�nimo do pedido';
// 20.10.11
  Global.CodigosLog[027]:='Numero de NFe inutilizado';
// 03.05.13
  Global.CodigosLog[028]:='Altera��o limite de cr�dito do cliente';
// 16.12.13
  Global.CodigosLog[029]:='Altera��o campo situa��o do cliente';
// 28.08.14
  Global.CodigosLog[030]:='Altera��o do vencimento de pend�ncia financeira';
// 11.11.14
  Global.CodigosLog[031]:='Equipamento com manuten��o bloqueada';
// 19.04.16
  Global.CodigosLog[032]:='Altera��o da DESCRI��O no cadastro de produtos';
  Global.CodigosLog[099]:='Uso Tempor�rio';

end;


procedure TFGeral.SetaGradientes;
var c,f:Integer;
    Form:TForm;
begin
  if not Global.Topicos[1001] then Exit;
  for f:=0 to Application.ComponentCount-1 do begin
      if Application.Components[f] is TForm then begin
         Form:=TForm(Application.Components[f]);
         for c:=0 to Form.ComponentCount-1 do begin
             if (Form.Components[c] is TAPHeadLabel) and (TAPHeadLabel(Form.Components[c]).Align=alClient) then begin
                TAPHeadLabel(Form.Components[c]).Visible:=False;
             end;
         end;
      end;
  end;
end;


procedure TFGeral.CreateForm(InstanceClass: TComponentClass; var Reference);
var c:Integer;
    Form:TForm;
begin
  Application.CreateForm(InstanceClass,Reference);
  Form:=TForm(Reference);
  if Global.Topicos[1001] then begin
     for c:=0 to Form.ComponentCount-1 do begin
         if Form.Components[c] is TAPHeadLabel then TAPHeadLabel(Form.Components[c]).Visible:=False;
     end;
  end;
end;


procedure TFGeral.SetaDataUltimoEncerrCont;
begin
end;


function TFGeral.GetProximoCodigoCadastro(Cadastro,Campo:String):Integer;
var Q:TSqlQuery;
begin
  Q:=SqlToQuery('SELECT MAX('+Campo+') AS Numero FROM '+Cadastro);
  Result:=Q.FieldByName('Numero').AsInteger+1;
  Q.Close;Freeandnil(Q);
end;

procedure TFGeral.Limpaedit(Ed:TSqlEd;key:char);
begin
  if key in ['0'..'9'] then
//    if Ed.GetTextLen = Ed.MaxLength then
    if copy(Ed.text,1,1)<> '' then
      if Ed.SelStart=0 then
        Ed.Text:='';
end;

procedure TFGeral.Linhatogrid(Grade:integer;Codigos:string;Grid:TStringGrid);
var p,c,codigolinha:integer;
begin
  c:=0;
  if trim(codigos)<>'' then begin
    codigolinha:=FGrades.Getcodigolinha(Grade);
    for p:=1 to Grid.RowCount do begin
      Grid.Cells[0,c+1]:='';
      inc(c)
    end;
    c:=0;
    for p:=1 to length(Codigos) do begin
      if copy(codigos,p,1)=';' then begin
        if codigolinha=1 then
          Grid.Cells[0,c+1]:=FTamanhos.GetDescricao(strtoint(copy(codigos,p-3,3)))
        else
          Grid.Cells[0,c+1]:=FCores.GetDescricao(strtoint(copy(codigos,p-3,3)));
        inc(c);
      end;
    end;
  end else begin
    for p:=1 to Grid.RowCount do begin
      Grid.Cells[0,c+1]:='';
      inc(c)
    end;
  end;

end;
// 21.11.16
procedure TFGeral.ColunasGrid(xgrid: TSqlGrid; xPainel: TForm);
//////////////////////////////////////////////////////////////////////
var p,i:integer;
    campocoluna:string;
begin
   for i:=0 to xGrid.Columns.Count-1 do begin
     campocoluna:=xGrid.Columns[i].FieldName;
     for p:=0 to xPainel.ComponentCount-1 do begin
       if xPainel.Components[p] is TSqlEd then begin
         if Uppercase( TSqlEd( xPainel.Components[p] ).TableField ) = Uppercase( campocoluna )  then
           xGrid.Columns[i].Title.Caption:=TSqlEd( xPainel.Components[p] ).Title ;
       end;
     end;
   end;
///   xGrid.Color:=clyellow;
   xGrid.Font.Color:=clblue;
   xGrid.FixedColor:=claqua;

end;

procedure TFGeral.Colunatogrid(Grade:integer;Codigos: string;Grid:TStringGrid);
var p,c,codigocoluna:integer;
begin
  c:=0;
  if trim(codigos)<>'' then begin
    codigocoluna:=FGrades.Getcodigocoluna(Grade);
    for p:=1 to Grid.ColCount do begin
      Grid.Cells[c+1,0]:='';
      inc(c)
    end;
    c:=0;
    for p:=1 to length(Codigos) do begin
      if copy(codigos,p,1)=';' then begin
        if codigocoluna=1 then
          Grid.Cells[c+1,0]:=FTamanhos.GetDescricao(strtoint(copy(codigos,p-3,3)))
        else
          Grid.Cells[c+1,0]:=FCores.GetDescricao(strtoint(copy(codigos,p-3,3)));
        inc(c);
      end;
    end;
  end else begin
    for p:=1 to Grid.ColCount do begin
      Grid.Cells[c+1,0]:='';
      inc(c)
    end;
  end;

end;


function TFGeral.QualQtde(Usuario: integer; Qtde,  Qtdeprev: Currency): Currency;
////////////////////////////////////////////////////////////////////////////////////////
begin
  if Global.Usuario.OutrosAcessos[0010] then
    result:=Qtdeprev
  else
    result:=Qtde;
end;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TFGeral.ValidaCliente(Edit: TSqled ; tipomov:string='' ; condicao:string='V' ; portador:string='XXX' ; unidades:string='001' ; valordoc:currency=0): boolean;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var sqldatacont,numerodcto,sqlgarantido,parcela:string;
    valoraberto,valor,valorbxparcial,tolerancia,valoremessas:currency;
    datavcto:TDatetime;
    ListaJaBaixadosBP:TStringList;

    function ChecaBaixaParcial(unidades,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer):currency;
    ////////////////////////
    var Qbx:TSqlquery;
        sqlqtipo:string;
        valor:currency;
    begin
      if Datacont>1 then
//        sqlqtipo:=' and pend_datacont>1'
// 20.07.10
        sqlqtipo:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco)
      else
        sqlqtipo:=' and pend_datacont is null';
      valor:=0;
///      sistema.beginprocess('Checando vendas a prazo');
// 09.06.16 - mudado para procurar no vencimento e na parcela
      QBx:=sqltoquery('select * from pendencias where pend_status=''P'' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
//                      ' and pend_databaixa>='+Datetosql(Data)+
                      ' and pend_parcela='+inttostr(parcela)+
                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      ' and '+FGeral.Getin('pend_unid_codigo',unidades,'C')+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
{
      if QBx.eof then begin
         QBx.close;
         Freeandnil(QBx);
         QBx:=sqltoquery('select * from pendencias where pend_status=''P'' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
//                      ' and pend_databaixa>='+Datetosql(Data)+
//                      ' and pend_unid_codigo='+stringtosql(unidades)+
                      ' and '+FGeral.Getin('pend_unid_codigo',unidades,'C')+
                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
      end;
      }

      while not QBx.eof do begin
        valor:=valor+QBx.fieldbyname('pend_valor').ascurrency;
        QBx.next;
      end;
      sistema.endprocess('');
      result:=valor;
    end;


    function ChecaCheques(unidades:string):boolean;
    ///////////////////////////////////////////////
    var Q:TSqlquery;
        sqldatacont:string;
        Xdata:TDatetime;
    begin
      result:=true;
      if Global.Usuario.OutrosAcessos[0701] then
        sqldatacont:=''
      else
//        sqldatacont:=' and cheq_datacont>1';
// 20.07.10
        sqldatacont:=' and cheq_datacont > '+DateToSql(Global.DataMenorBanco);
      xdata:=(sistema.hoje-FGeral.Getconfig1asinteger('DIASVENPRAZO'));
      Q:=sqltoquery('select * from cheques where cheq_tipo_codigo='+Edit.text+' and cheq_status=''N'''+
//       and cheq_devolvido=''S'''+
//                    ' and cheq_devolvido<>''S'''+
                    sqldatacont+sqlgarantido+
                    ' and '+FGeral.Getin('cheq_unid_codigo',unidades,'C')+
                    ' and cheq_emirec='+Stringtosql('R')+  // 12.05.14
                    ' and cheq_predata<='+Datetosql(xdata)+
                    ' and cheq_deposito is null order by cheq_emissao');
      valoraberto:=0;
      valor:=0;
      while not Q.eof do begin
        if trim(numerodcto)='' then begin
          numerodcto:=Q.fieldbyname('cheq_cheque').asstring;
          datavcto:=Q.fieldbyname('cheq_predata').asdatetime;
          valor:=Q.fieldbyname('cheq_valor').ascurrency
        end;
        valoraberto:=valoraberto+Q.fieldbyname('cheq_valor').ascurrency;
        result:=false;
        Q.next;
      end;
      if not result then
//          Avisoerro('Cheque devolvido '+numerodcto+' de '+formatdatetime('dd/mm/yy',datavcto)+' valor '+FGeral.Formatavalor(valor,f_cr)+' Total cheques devolvidos '+FGeral.Formatavalor(valoraberto-valorbxparcial,f_cr));
          Avisoerro('Cheque em aberto '+numerodcto+' de '+formatdatetime('dd/mm/yy',datavcto)+' valor '+FGeral.Formatavalor(valor,f_cr)+' Total cheques '+FGeral.Formatavalor(valoraberto,f_cr));
      FGeral.Fechaquery(Q);
    end;

// 04.06.10 - aqui em 24.05.13
///////////////////////////////////////////////////////////////////////////////////////////////////
    function TudobaixadoXY(unidade,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer;saldo,xpend_valor:currency):boolean;
////////////////////////////////////////////////////////////////////////////////////////////////////////
    var Qbx:TSqlquery;
        valor:currency;
        sqldatacont:string;
    begin
//      if Q.FieldByName('pend_status').AsString='N' then begin
        valor:=xpend_valor;
        if Datacont>1 then
          sqldatacont:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco)
        else
          sqldatacont:=' and pend_datacont is null';
        QBx:=sqltoquery('select pend_valor from pendencias where pend_status=''P'' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
                      ' and pend_databaixa > '+DatetoSql(Global.DataMenorBanco)+
                      ' and pend_parcela='+inttostr(parcela)+
                      ' and pend_unid_codigo='+Stringtosql(unidade)+
                      sqldatacont+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
        while not QBx.Eof do begin
          valor:=valor-QBx.fieldbyname('pend_valor').ascurrency;
          QBx.Next;
        end;
        Qbx.close;
        Freeandnil(Qbx);
        if valor<=0 then
          result:=true
        else
          result:=false;
//      end else
//        result:=false;
    end;
////////////////////




// 04.06.10 - Abra - Paulo - aqui em 23.05.13 - vivan
//////////////////////////////////
    function TudoBaixadoBP(xoperacao:string):boolean;
    /////////////////////////////////////////////////////////
    begin
        if ListaJaBaixadosBP.IndexOf(xoperacao)>=0 then
          result:=true
        else
          result:=false;
    end;
/////////////////////////////////////////
// 04.06.10 - Abra - Paulo - 24.05.13
//////////////////////////////////
    function TudoBaixado(xoperacao:string):boolean;
    begin
        if ListaJaBaixadosBP.IndexOf(xoperacao)>=0 then
          result:=true
        else
          result:=false;
    end;


    function ChecaVendaaPrazo(unidades:string):boolean;
    //////////////////////////////////////////////////
    var Q,QCheques,QBp:TSqlquery;
        PortadorBoleto,sqlportador,sqlportadorcartao:string;
        valorcheques:currency;
        Datai,Dataf:TDatetime;

//// 24.05.13
        function EstaValendo(vencimento:TDatetime ; rp:string ):boolean;
        ////////////////////////////////////////////////////////////////////
        var diasvencidos:integer;
            ativo:string;
            QBx1:TSqlquery;
        begin
    //      if Rel='PEN' then begin
    // 21.09.09 - Damama
            if ( Q.fieldbyname('pend_status').AsString='A' ) and (Q.fieldbyname('pend_databaixa').AsDatetime>1) then
              result:=false
    //////////////
            else  begin
              result:=true;
              QBx1:=sqltoquery('select sum(pend_valor) as parcial from pendencias where pend_status='+stringtosql('P')+
                          ' and pend_tipo_codigo='+stringtosql(Q.fieldbyname('pend_tipo_codigo').asstring)+
                          ' and pend_tipocad='+stringtosql(Q.fieldbyname('pend_tipocad').asstring)+
                          ' and pend_databaixa > '+DatetoSql(Global.DataMenorBanco)+
                          ' and pend_parcela='+Q.fieldbyname('pend_parcela').asstring+
                          ' and pend_unid_codigo='+stringtosql(Q.fieldbyname('pend_unid_codigo').asstring)+
                          ' and pend_numerodcto='+stringtosql(Q.fieldbyname('pend_numerodcto').asstring) );
              if not QBx1.eof then begin
                if qbx1.fieldbyname('parcial').ascurrency>=q.FieldByName('pend_valor').ascurrency then
                  result:=false;
              end else
              fgeral.fechaquery(QBx1);
            end;
    //      end;
        end;
////////////////

// 18.11.13
/////////////////////////////////////
       function FaixadeRemessa(xvalor:currency):boolean;
       ////////////////////////////////////////////////////////
       begin
         result:=true;
         if (FGeral.GetConfig1AsFloat('faixafrc') > 0 ) then begin
           if ( xvalor<FGeral.GetConfig1AsFloat('faixairc') ) or
              ( xvalor>FGeral.GetConfig1AsFloat('faixafrc') ) then
              result:=false;
         end;
       end;

////////////////////////////


    begin
    ////////////////////
      result:=true;
//      PortadorBoleto:='002';
//      PortadorBoleto:=FGeral.getconfig1asstring('portabloqueto');
// 05.03.14 - Vivan Cecilia
      PortadorBoleto:=FGeral.getconfig1asstring('portaboletos');
      valoraberto:=0;valor:=0;valorbxparcial:=0;
      sqlportador:='';valoremessas:=0;
      if (portador='BOL') and ( trim(portadorboleto)<>'' ) then
//        sqlportador:=' and pend_port_codigo='+stringtosql(portadorboleto);
// 12.05.11 - antes era um portador e agora podem ser varios
        sqlportador:=' and '+FGeral.GetIn('pend_port_codigo',portadorboleto,'C')
// 08.10.2012 // senao tem portado identificado mostra 2 vezes 'mesma coisa'
      else if (portador='BOL') and ( trim(portadorboleto)='' ) then
        exit;
// 21.01.13 - Vivan - para n�o imprimir contas a receber ref. recebimento com cart�o de credito
      sqlportadorcartao:='';
      if trim( FGeral.GetConfig1AsString('Portadorcartao') )<>'' then
        sqlportadorcartao:=' and '+FGeral.GetNOTIN('pend_port_codigo',FGeral.GetConfig1AsString('Portadorcartao'),'C');


      if FGeral.Getconfig1asinteger('DIASVENPRAZO') <=0 then exit;
      sistema.beginprocess('Checando vendas a prazo');
      Q:=sqltoquery('select * from pendencias where '+FGeral.Getin('pend_status','N','C')+
                      ' and pend_tipo_codigo='+Edit.AsSql+
                      ' and pend_tipocad='+stringtosql('C')+
                      ' and '+FGeral.Getin('pend_unid_codigo',unidades,'C')+
                      sqldatacont+
                      sqlportador+
                      sqlportadorcartao+
                      ' and pend_RP='+stringtosql('R') );
// 23.05.13 - Vivan
//        Sistema.beginprocess('Checando titulos baixados com baixas parciais');
       ListaJaBaixadosBP:=TStringList.create;
{
        while not Q.eof do begin
//          if EstaValendo(Q.FieldByName('pend_datavcto').AsDatetime,recpag) then begin
            if Q.FieldByName('pend_status').AsString='N' then begin
             if TudoBaixadoXY(Q.FieldByName('pend_unid_codigo').AsString,Q.FieldByName('pend_tipo_codigo').AsString,Q.FieldByName('pend_tipocad').AsString,
                Q.FieldByName('pend_numerodcto').AsString,Q.FieldByName('pend_dataemissao').Asdatetime,
                Q.FieldByName('pend_datacont').Asdatetime,Q.FieldByName('pend_datavcto').Asdatetime,
                Q.FieldByName('pend_parcela').Asinteger,0,Q.FieldByName('pend_valor').Ascurrency) then
                ListaJaBaixadosBP.Add(Q.FieldByName('pend_operacao').AsString);
            end;
//          end;
          Q.Next;
        end;
        Q.First;
}

      while not Q.eof do begin
//     24.05.13
//       if ( not TudoBaixadoBP(Q.FieldByName('pend_operacao').AsString) ) or
//          ( EstaValendo(Q.FieldByName('pend_datavcto').AsDatetime,'R') )
//        then begin

// 12.05.11
        if ( pos(Q.fieldbyname('pend_port_codigo').asstring,PortadorBoleto)>0 ) and (portador='BOL') then begin
          if ( FGeral.Getconfig1asinteger('DIASVENBOLETO')>0 ) and (portadorboleto<>'') then begin
//            if (sistema.hoje-Q.fieldbyname('pend_datavcto').asdatetime)>FGeral.Getconfig1asinteger('DIASVENBOLETO') then begin
// Novicarnes - Elize - boleto 1 dias..'sempre bloqueou'
            if (sistema.hoje-Q.fieldbyname('pend_datavcto').asdatetime)>=FGeral.Getconfig1asinteger('DIASVENBOLETO') then begin
              if trim(numerodcto)='' then begin
                numerodcto:=Q.fieldbyname('pend_numerodcto').asstring;
                datavcto:=Q.fieldbyname('pend_datavcto').asdatetime;
                valor:=Q.fieldbyname('pend_valor').ascurrency;
                parcela:=inttostr(Q.fieldbyname('pend_parcela').asinteger);
              end;
              valoraberto:=valoraberto+Q.fieldbyname('pend_valor').ascurrency;
              valorbxparcial:=valorbxparcial+ChecaBaixaParcial(Global.Usuario.UnidadesRelatorios,Edit.assql,'C',
                              Q.fieldbyname('pend_numerodcto').asstring,Q.fieldbyname('pend_dataemissao').asdatetime,Q.fieldbyname('pend_datacont').asdatetime,
                              Q.fieldbyname('pend_datavcto').asdatetime,Q.fieldbyname('pend_parcela').asinteger);

              result:=false;
            end;
          end;
        end else if portador='LIM' then begin  // 05.06.07
              if trim(numerodcto)='' then begin
                numerodcto:=Q.fieldbyname('pend_numerodcto').asstring;
                datavcto:=Q.fieldbyname('pend_datavcto').asdatetime;
                valor:=Q.fieldbyname('pend_valor').ascurrency;
                parcela:=inttostr(Q.fieldbyname('pend_parcela').asinteger);
              end;
              valoraberto:=valoraberto+Q.fieldbyname('pend_valor').ascurrency;
              valorbxparcial:=valorbxparcial+ChecaBaixaParcial(Global.Usuario.UnidadesRelatorios,Edit.assql,'C',
                              Q.fieldbyname('pend_numerodcto').asstring,Q.fieldbyname('pend_dataemissao').asdatetime,Q.fieldbyname('pend_datacont').asdatetime,
                              Q.fieldbyname('pend_datavcto').asdatetime,Q.fieldbyname('pend_parcela').asinteger);

        end else if ( (sistema.hoje-Q.fieldbyname('pend_datavcto').asdatetime)>=FGeral.Getconfig1asinteger('DIASVENPRAZO') )
// 09.06.16 portador 'dup' so considera atrasados
                     and ( (sistema.hoje-Q.fieldbyname('pend_datavcto').asdatetime)>0 )
                     and ( Q.fieldbyname('pend_port_codigo').asstring<>PortadorBoleto ) then begin
              if trim(numerodcto)='' then begin
                numerodcto:=Q.fieldbyname('pend_numerodcto').asstring;
                datavcto:=Q.fieldbyname('pend_datavcto').asdatetime;
                valor:=Q.fieldbyname('pend_valor').ascurrency;
                parcela:=inttostr(Q.fieldbyname('pend_parcela').asinteger);
              end;
              valoraberto:=valoraberto+Q.fieldbyname('pend_valor').ascurrency;
              valorbxparcial:=valorbxparcial+ChecaBaixaParcial(Global.Usuario.UnidadesRelatorios,Edit.text,'C',
                              Q.fieldbyname('pend_numerodcto').asstring,Q.fieldbyname('pend_dataemissao').asdatetime,Q.fieldbyname('pend_datacont').asdatetime,
                              Q.fieldbyname('pend_datavcto').asdatetime,Q.fieldbyname('pend_parcela').asinteger);
          result:=false;
        end;
//       end; // 24.05.13
       Q.Next;
      end;
      FGeral.Fechaquery(Q);
// 08.10.12 - Vivan - RC soma na checagem limite de credito
      if Global.Topicos[1031] then begin
        datai:=Datetoprimeirodiames( Datetodatemesant(Sistema.hoje,3) );
//        dataf:=Datetoultimodiames( Datetodatemesant(Sistema.hoje,1) );
// 13.02.13 - Vivan Cobran�a - RC soma at� a data atual
        dataf:=Sistema.hoje;
        Q:=sqltoquery('select sum(moes_vlrtotal) as remessas from movesto '+
                ' where '+fGeral.getin('moes_tipomov',Global.CodRemessaConsig,'C')+
                ' and moes_status=''N'' and moes_datamvto>='+Datetosql(datai)+' and moes_datamvto<='+Datetosql(dataf)+
                ' and '+FGeral.Getin('moes_unid_codigo',Global.Usuario.UnidadesRelatorios,'C')+
// 15.05.13 - remessas 'troca de cr�dito' n�o soma pra limite
//                ' and ( '+FGeral.GetNOTIN('moes_rcmagazine','T','C')+ )
// 24.05.13 - null...sem comentarios...
                ' and ( ('+FGeral.GetIN('moes_rcmagazine','M;N','C')+') '+
                ' or (moes_rcmagazine = null) )'+
                ' and moes_tipo_codigo='+Edit.assql+' and moes_tipocad=''C''');
         valoraberto:=valoraberto+Q.fieldbyname('remessas').ascurrency;
         valoremessas:=Q.fieldbyname('remessas').ascurrency;
         FGeral.Fechaquery(Q);
// 14.02.13 - Vivan Cobran�a - DC e DR n�o estava deduzindo do credito
//////////////////////////////////////////////////////////////////////
        Q:=sqltoquery('select sum(moes_vlrtotal) as remessas from movesto '+
                ' where '+FGeral.Getin('moes_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C')+
                ' and moes_status=''N'' and moes_datamvto>='+Datetosql(datai)+' and moes_datamvto<='+Datetosql(dataf)+
                ' and '+FGeral.Getin('moes_unid_codigo',Global.Usuario.UnidadesRelatorios,'C')+
                ' and moes_tipo_codigo='+Edit.assql+' and moes_tipocad=''C''');
         valoraberto:=valoraberto-Q.fieldbyname('remessas').ascurrency;
         valoremessas:=valoremessas-Q.fieldbyname('remessas').ascurrency;
         FGeral.Fechaquery(Q);
      end;
      sistema.endprocess('');
/////////// 01.09.10 - Novicarnes - Elyze
      if (portador='LIM') then begin
        if Global.Usuario.OutrosAcessos[0701] then
          sqldatacont:=''
        else
          sqldatacont:=' and cheq_datacont > '+DateToSql(Global.DataMenorBanco);
        QCheques:=sqltoquery('select * from cheques where cheq_tipo_codigo='+Edit.text+' and cheq_status=''N'''+
                      sqldatacont+sqlgarantido+
                      ' and '+FGeral.Getin('cheq_unid_codigo',unidades,'C')+
//                      ' and cheq_predata<='+Datetosql(xdata)+
                      ' and cheq_emirec='+Stringtosql('R')+  // 12.05.14
                      ' and cheq_deposito is null order by cheq_emissao');
        while not QCheques.Eof do begin
          valoraberto:=valoraberto+QCheques.fieldbyname('cheq_valor').ascurrency;
          QCheques.Next;
        end;
        fGeral.FechaQuery(QCheques);
      end;   // Q.eof

// 21.01.13 - vivan
      valoraberto:=valoraberto-valorbxparcial;
////////////////////////////////////////
//      if valoraberto<valorbxparcial then
//        result:=true
//      else if (valoraberto=valorbxparcial) and ( valoraberto>0 ) then
//        result:=true
//      if (portador='LIM') and (Edit.resultfind.fieldbyname('Clie_limcredito').ascurrency<(valoraberto+valordoc-valorbxparcial)) then   // 05.06.07
// 21.01.13
      if (portador='LIM') and (Edit.resultfind.fieldbyname('Clie_limcredito').ascurrency<(valoraberto+valordoc)) then begin
        result:=false;
// 10.07.13 - Vivan - Angela
        if tolerancia>0 then begin
          if (Edit.resultfind.fieldbyname('Clie_limcredito').ascurrency+tolerancia>=(valoraberto+valordoc)) then
            result:=true;
        end;
// 18.02.13 - Vivan Cobranca
      end else if (portador='DUP') and (Edit.resultfind.fieldbyname('Clie_limcredito').ascurrency>=(valoraberto+valordoc)) then begin
        result:=true;
// 22.04.14 - Vivan
        if ( Global.Topicos[1289] )and (trim(numerodcto)<>'') then begin
// 01.06.16 - vivan - cecilia varias baixas parciais nas parcelas de um mesmo documento
          QBp:=sqltoquery('select sum(pend_valor) as valorbp from pendencias where pend_status = ''P'''+
                          ' and pend_numerodcto = '+Stringtosql(numerodcto)+
                          ' and pend_datavcto = '+Datetosql(datavcto)+
//                          ' and pend_datavcto <= '+Datetosql(Sistema.hoje)+
                          ' and pend_parcela = '+stringtosql(parcela)+
                          ' and pend_rp = ''R'''+
                          ' and pend_tipo_codigo = '+Edit.AsSql );
          if (QBp.fieldbyname('valorbp').ascurrency=0) then begin
             Avisoerro('Duplicata em aberto no. '+numerodcto+' vencido em '+formatdatetime('dd/mm/yy',datavcto)+' valor '+FGeral.Formatavalor(valor,f_cr) );
             result:=false;
          end else if (QBp.fieldbyname('valorbp').ascurrency < valor) and (QBp.fieldbyname('valorbp').ascurrency>0)
              and ( (sistema.hoje-datavcto)>=FGeral.Getconfig1asinteger('DIASVENPRAZO') ) then begin
            Avisoerro('Duplicata em aberto no. '+numerodcto+' vencido em '+formatdatetime('dd/mm/yy',datavcto)+' saldo '+FGeral.Formatavalor(valor-QBp.fieldbyname('valorbp').ascurrency,f_cr) );
//            Avisoerro('Duplicata em aberto no. '+numerodcto+' falta valor '+FGeral.Formatavalor(valor-QBp.fieldbyname('valorbp').ascurrency,f_cr) );
            result:=false;
          end else
            result:=true;
          QBp.close;
        end;
// 18.11.13 - Liane
      end else if (portador='REM') and ( FaixadeRemessa(valoremessas+valordoc) ) then
        result:=true;
////////////////////////////
      if not result then begin
//        if (portador=PortadorBoleto) then
// 12.05.11
        if (portador='BOL') then
//          Avisoerro('Boleto banc�rio em aberto '+numerodcto+' vencido em '+formatdatetime('dd/mm/yy',datavcto)+' valor '+FGeral.Formatavalor(valor,f_cr)+' Total atrasado '+FGeral.Formatavalor(valoraberto-valorbxparcial,f_cr))
          Avisoerro('Boleto banc�rio em aberto '+numerodcto+' vencido em '+formatdatetime('dd/mm/yy',datavcto)+' valor '+FGeral.Formatavalor(valor,f_cr)+' Total atrasado '+FGeral.Formatavalor(valoraberto,f_cr))
        else if portador='LIM' then
//          Avisoerro('Limite de cr�dido de '+FGeral.Formatavalor(Edit.resultfind.fieldbyname('Clie_limcredito').ascurrency,f_cr)+' ultrapassado.  Total em aberto '+FGeral.Formatavalor(valoraberto+valordoc-valorbxparcial,f_cr))
          Avisoerro('Limite de cr�dido de '+FGeral.Formatavalor(Edit.resultfind.fieldbyname('Clie_limcredito').ascurrency,f_cr)+' ultrapassado.  Total em aberto '+FGeral.Formatavalor(valoraberto+valordoc,f_cr))
// 18.11.13
        else if portador='REM' then begin
          Avisoerro(' Total em aberto ref.RC '+FGeral.Formatavalor(valoremessas+valordoc,f_cr)+' Limite '+
                    FGeral.Formatavalor(FGeral.getconfig1asfloat('faixafrc'),f_cr))
//        else if Global.Topicos[1289] then begin
// 08.04.14 - vivan - Liane
//          Avisoerro('Duplicata em aberto no. '+numerodcto+' vencido em '+formatdatetime('dd/mm/yy',datavcto)+' valor '+FGeral.Formatavalor(valor,f_cr) );
//          result:=false;
        end else
//          Avisoerro('Duplicata em aberto '+numerodcto+' vencido em '+formatdatetime('dd/mm/yy',datavcto)+' valor '+FGeral.Formatavalor(valor,f_cr)+' Total atrasado '+FGeral.Formatavalor(valoraberto,f_cr));
// 20.02.13 - retirado pois em baixa parcial mostra documento baixado com BP como se fosse vencido
          Avisoerro(' Total em aberto '+FGeral.Formatavalor(valoraberto,f_cr)+' '+portador);
//        if Global.usuario.codigo=300 then
//          result:=false
//        else begin
////          if (FGeral.GetConfig1AsInteger('Dtiniciocredito')>0) then begin
//            if Sistema.hoje<=FGeral.GetConfig1AsDate('Dtiniciocredito') then
//              result:=true;
//          end else
//            result:=true;
//        end;

      end;
    end;

    function ChecaValor(tipomov:string):boolean;
    /////////////////////////////////////////////
    var Q:TSqlquery;
        minimo,venda,devolucao:currency;
        datai,dataf:TDatetime;
    begin
      minimo:=FGeral.Getconfig1asfloat('VENDASCONSIG');
      venda:=0;devolucao:=0;
      datai:=Datetoprimeirodiames( Datetodatemesant(Sistema.hoje,1) );
      dataf:=Datetoultimodiames( datai );
      if minimo>0 then begin
         Q:=sqltoquery('select * from movesto '+
                ' where '+fGeral.getin('moes_tipomov',Global.CodVendaConsig+';'+Global.CodVendaREFinal+';'+Global.CodDevolucaoVendaConsig,'C')+
                ' and moes_status=''N'' and moes_datamvto>='+Datetosql(datai)+' and moes_datamvto<='+Datetosql(dataf)+
                ' and '+FGeral.Getin('moes_unid_codigo',Global.Usuario.UnidadesRelatorios,'C')+
                ' and moes_tipo_codigo='+Edit.assql+' and moes_tipocad=''C''');
        while not Q.eof do begin
          if Q.fieldbyname('moes_tipomov').asstring=Global.CodDevolucaoVendaConsig then begin
            if Q.fieldbyname('moes_valortotal').ascurrency>0 then
              devolucao:=devolucao+Q.fieldbyname('moes_valortotal').ascurrency
            else
              devolucao:=devolucao+Q.fieldbyname('moes_vlrtotal').ascurrency;
          end else begin
            if Q.fieldbyname('moes_valortotal').ascurrency>0 then
              venda:=venda+Q.fieldbyname('moes_valortotal').ascurrency
            else
              venda:=venda+Q.fieldbyname('moes_vlrtotal').ascurrency;
          end;
          Q.next;
        end;
        result:=true;
        if (venda-devolucao)<minimo then begin
          result:=false;
          Avisoerro('Valor �ltimo mes : Venda '+floattostr(venda)+' Devolu��o '+floattostr(devolucao));
        end;
        FGeral.Fechaquery(Q);
      end else
        result:=true
    end;


begin
//////////////////////////////////////////////////////
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and pend_datacont>1';
      sqldatacont:=' and pend_datacont > '+Datetosql(Global.DataMenorBanco);
// 07.12.13
    campo:=Sistema.GetDicionario('cheques','cheq_garantido');
    if campo.Tipo<>'' then
      sqlgarantido:=' and ( cheq_garantido<>''S'' or cheq_garantido is null )'
    else
      sqlgarantido:='';

  numerodcto:='';
  datavcto:=0;
  valor:=0;
// 10.07.13
  tolerancia:=FGeral.GetConfig1AsFloat('tolerancialimite');
  if Edit.ResultFind<>nil then begin
//    if Edit.ResultFind.FieldByName('clie_codigo').AsInteger>0 then
//      Aviso('Ver valida��es de clientes');
//    if Edit.Resultfind.fieldbyname('clie_contagerencial').AsInteger=0 then begin
//      Avisoerro('Cliente sem conta gerencial cadastrada');
//      result:=false;
//    end else
    result:=true;
// 11.05.06
    if Edit.ResultFind.FieldByName('clie_repr_codigo').AsInteger<=0 then begin
        Avisoerro('Cliente sem codigo de representante no cadastro');
        result:=false;
    end;
    if ( pos(tipomov,Global.CodVendaSerie4+';'+Global.CodVendaDireta+';'+Global.CodVendaBrinde+';'+
           Global.CodVendaProntaEntrega+';'+Global.CodPedVenda+';'+global.CodPedVendaMostruario+';'+
           Global.CodPedVendaMostruarioConsig+';'+global.CodVendaMagazine+';'+Global.Codvendainterna+';'+
           Global.CodPedVendaPE)>0 )
           and ( condicao<>'V' )  and ( portador<>'XXX' ) then begin
      if Portador='CHQ' then begin
        if not ChecaCheques(unidades) then begin
          result:=false;
          exit;
        end;
      end else if Portador='VLR' then begin
        if not ChecaValor(Global.CodVendaConsig) then begin
          result:=false;
          exit;
        end;
      end else if Portador='LIM' then begin
        if  Edit.resultfind.fieldbyname('Clie_limcredito').ascurrency>0 then begin
          if not ChecaVendaaPrazo(unidades) then begin
            result:=false;
            exit;
          end;
        end;
      end else if not ChecaVendaaPrazo(unidades) then begin
        result:=false;
        exit;
      end;
// 04.08.06
      if Edit.ResultFind.FieldByName('clie_situacao').AsString='R' then begin
        Avisoerro('Cliente registrado.   Solicitar dep�sito antecipado.');
      end else if Edit.ResultFind.FieldByName('clie_situacao').AsString='B' then begin
        Avisoerro('Cliente bloqueado.   Solicitar autoriza��o.');
        result:=false;
      end;
    end;
    if (tipomov=Global.CodVendaSerie4) then begin
// 04.08.06
      if Edit.ResultFind.FieldByName('clie_situacao').AsString='R' then begin
        Avisoerro('Cliente registrado.   Solicitar dep�sito antecipado.');
      end;
// checagem de juridica no regime especial - 02.03.06 - valmir
// 21.05.12 - Janina pediu pra liberar no cnpj RC e VC
      if (Edit.ResultFind.FieldByName('clie_tipo').AsString<>'F') then begin
          if not Global.topicos[1026] then begin
            Avisoerro('Venda '+Global.CodVendaSerie4+' somente permitida para pessoa f�sica; tipo cliente : '+Edit.ResultFind.FieldByName('clie_tipo').AsString);
            result:=false;
          end else
            result:=true;
        end else if (Edit.ResultFind.FieldByName('clie_uf').AsString<>'SC') then begin
          Avisoerro('Venda '+Global.CodVendaSerie4+' somente permitida em SC; UF cliente : '+Edit.ResultFind.FieldByName('clie_uf').AsString);
          result:=false;
        end;
  //    end else if pos(tipomov,Global.CodRemessaProntaEntrega+';'+Global.CodPedVenda+';'+Global.CodPedVendaMostruario)>0 then begin  // 09.01.06
  //  17.01.06 - liberado pedido de venda para pessoa juridica pois � venda direta os pedidos
      end else if pos(tipomov,Global.CodRemessaProntaEntrega+';'+Global.CodPedVendaMostruario+';'+Global.CodPedVendaMostruarioConsig)>0 then begin  // 09.01.06
  // 17.03.10 - retirado validacao para Asatec usar tipomov Rp
  //      if Edit.Resultfind.fieldbyname('clie_tipo').asstring<>'F' then begin
  //        Avisoerro('Remessa permitida somente para pessoa jur�dica');
          result:=true;
  //      end;

    end else if (tipomov=Global.CodRemessaConsig) then begin

// 03.09.12 - Fama - Janina
      if (Global.topicos[1029] ) and ( condicao<>'V' )  and ( portador<>'XXX' ) then begin
        if Portador='CHQ' then begin
          if not ChecaCheques(unidades) then begin
            result:=false;
            exit;
          end;
        end else if Portador='VLR' then begin
          if not ChecaValor(Global.CodRemessaConsig) then begin
            result:=false;
            exit;
          end;
        end else if Portador='LIM' then begin
          if  Edit.resultfind.fieldbyname('Clie_limcredito').ascurrency>0 then begin
            if not ChecaVendaaPrazo(unidades) then begin
              result:=false;
              exit;
            end;
          end;
        end else if not ChecaVendaaPrazo(unidades) then begin
          result:=false;
          exit;
        end;
      end;
//////////// - 03.09.12

// 04.08.06
      if Edit.ResultFind.FieldByName('clie_situacao').AsString='R' then begin
        Avisoerro('Cliente registrado.   Solicitar dep�sito antecipado.');
      end else if Edit.ResultFind.FieldByName('clie_situacao').AsString='B' then begin
        Avisoerro('Cliente bloqueado.   Solicitar autoriza��o.');
        result:=false;
      end;
      if Edit.Resultfind.fieldbyname('clie_tipo').asstring<>'F' then begin
// 21.05.12 - Janina pediu pra liberar no cnpj RC e VC
        if not Global.topicos[1026] then begin
          Avisoerro('Remessa permitida somente para pessoa f�sica');
          result:=false;
        end else
          result:=true;
      end else if ( FGeral.getconfig1asinteger('DIASCONSIG')>0 ) and ( FGeral.getconfig1asdate('Dtiniciorem')>1 ) then begin
        if ( sistema.hoje-Edit.Resultfind.fieldbyname('clie_dtcad').asdatetime>FGeral.getconfig1asinteger('DIASCONSIG') ) and
           ( Edit.Resultfind.fieldbyname('clie_dtcad').asdatetime>=FGeral.getconfig1asdate('Dtiniciorem') ) then begin
//           if (Global.CodigoUnidade<>Global.unidadematriz)
//              ( (Edit.resultfind.fieldbyname('clie_repr_codigo').Asinteger<>106) and  (Global.CodigoUnidade=Global.unidadematriz) )
//             then begin  // 12.05.06
           Avisoerro('Remessa de consigna��o permitida somente por '+inttostr(FGeral.getconfig1asinteger('DIASCONSIG'))+' dias');
           if FUsuarios.GetSenhaSupervisor then
             result:=true
           else
             result:=false;
        end;
      end;

    end else begin

// 04.08.06
      if Edit.ResultFind.FieldByName('clie_situacao').AsString='R' then begin
         Avisoerro('Cliente registrado.   Solicitar dep�sito antecipado.');
      end else if Edit.ResultFind.FieldByName('clie_situacao').AsString='B' then begin
        Avisoerro('Cliente bloqueado.   Solicitar autoriza��o.');
        result:=false;
      end;
    end;
  end else begin
// Rever poss�vel valida�oes de clientes
    result:=true;
  end;
end;

function TFGeral.ValidaRepresentante(Edit: TSqlEd): boolean;
begin
  if Edit.ResultFind<>nil then begin
//    if Edit.ResultFind.FieldByName('repr_codigo').AsInteger>0 then
//      Aviso('Ver valida��es de representantes');
    result:=true;
  end else
    result:=false;
end;

function TFGeral.TemEstoque(CodigoProduto:string;Qtde:Currency;Unidade:string;Q:TSqlquery;Tipomov:string=''):boolean;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var xunidades:string;
    vendesemestoque:boolean;
begin
  result:=true;
// 01.06.15 - coorlaf pitanga
  xunidades:=FGeral.GetConfig1AsString('unidadesnaovenda');
  vendesemestoque:=true;
  if trim(xunidades)<>'' then begin
    if pos(unidade,xunidades)>0 then vendesemestoque:=false;
  end else vendesemestoque:=true;
  if trim(tipomov)<>''  then begin
//    if (not Q.eof) and ( pos(Tipomov,global.CodVendaSemMovEstoque)=0 ) then begin
// 06.05.05 - checar todos os tipos q NAO movimenta estoque
// 13.06.05 - op��o para NAO checar o estoque e baixa somente quando grava o documento
    if (not Q.eof)  then begin
      if ( pos(Tipomov,global.TiposMovMovEstoque)>0 ) and ( not Global.Topicos[1201]) and ( not vendesemestoque) then begin
        if FGeral.QualQtde(Global.Usuario.Codigo,Q.fieldbyname('esqt_qtde').Ascurrency,Q.fieldbyname('esqt_qtdeprev').Ascurrency) < Qtde then
          result:=false
      end;
    end;

  end else begin

    try
      if (not Q.eof) and ( not Global.Topicos[1201])  and (not vendesemestoque) then begin
        if FGeral.QualQtde(Global.Usuario.Codigo,Q.fieldbyname('esqt_qtde').Ascurrency,Q.fieldbyname('esqt_qtdeprev').Ascurrency) < Qtde then
        result:=false;
      end;
    except
      Avisoerro('Problema na fun��o tem estoque');
      Avisoerro(inttostr(Global.Usuario.Codigo)+' Qtde '+Q.fieldbyname('esqt_qtde').Asstring+' Qtde '+Q.fieldbyname('esqt_qtdeprev').Asstring);
    end;
  end;

end;


procedure TFGeral.SetaCodigosMovimento;
//////////////////////////////////////////
begin

   Global.CodRemessaConsig:='RC';
   Global.CodRemessaProntaEntrega:='RP';
   Global.CodVendaSerie4:='VN';
   Global.CodRomaSerie4:='RR';
   Global.CodDevolucaoConsig:='DC';
   Global.CodDevolucaoCompra:='CD';
   Global.CodDevolucaoProntaEntrega:='DP';
   Global.CodDevolucaoSerie5:='D5';
   Global.CodDevolucaoTroca:='DR';
   Global.CodDevolucaoRoman:='DA';
   Global.CodDevolucaoVenda:='DV';
   Global.CodVendaDireta:='VD';
   Global.CodVendaConsig:='VC';
   Global.CodVendaSemMovEstoque:='VE';
   Global.CodVendaProntaEntrega:='VP';
   Global.CodVendaMagazine:='VM';
//   Global.Codvendainternet:='VI';
// 27.10.11 - devido mama...no futuro se necessario criar tipo de mov. para venda internet
   Global.Codvendainterna:='VI';
   Global.CodVendaBrinde:='VB';
   Global.CodVendaTransf:='VT';
   Global.CodVendaLiqSerie4:='VL';
   Global.CodVendaRomaneio:='VR';
   Global.CodVendaAmbulante:='VA';
   Global.CodCompra:='CO';
   Global.CodCompra100:='CM';
   Global.CodConhecimento:='CT';
   Global.CodCompraSemMovEstoque:='CE';
   Global.CodAcertoEsEnt:='AE';
   Global.CodAcertoEsSai:='AS';
   Global.CodTransfEntrada:='TE';
   Global.CodTransfSaida:='TS';
   Global.CodTransImob:='TI';
   Global.CodSimplesRemessa:='SR';
   Global.CodCompraX:='CX';
   Global.CodRemessaInd:='RI';
   Global.CodDevolucaoInd:='DI';
   Global.CodDevolucaoConsigMerc:='DM';
   Global.CodConsigMercantil:='MC';
   Global.CodRetornoConsigMercanil:='MR';
   Global.CodVendaConsigMercantil:='MV';
   Global.CodVendaMostruario:='SM';
   Global.CodRetornoMostruario:='RM';
   Global.CodVendaProntaEntregaFecha:='VF';   // 24.02.05  - para diferenciar das VP ( venda pedido das PE )
   Global.CodTransfEnt:='TN';
   Global.CodTransfSai:='TA';
   Global.CodTransImobE:='TM';
   Global.CodVendaPecaProblema:='PP';
   Global.CodVendaREFinal:='RF';
   Global.CodVendaRE:='RE';
   Global.CodVendaREBrinde:='RB';
// 01.08.05
   Global.CodTransMatConsumoE:='TC';
   Global.CodTransMatConsumoS:='TD';
   Global.CodRemessaConserto:='RS';
   Global.CodCompraImobilizado:='CI';
   Global.CodCompraMatConsumo:='CC';
   Global.CodVendaImobilizado:='VZ';
   Global.CodDevolucaoIgualVenda:='DX';
// 22.09.05
   Global.CodVendaSemfinan:='VS';
   Global.CodCompraSemfinan:='CF';
// 13.10.05 - outro tipo de venda mostruario mas com outro comportamento
   Global.CodVendaMostruarioII:='VO';
// 09.11.05
   Global.CodDevolucaoCompraSemEstoque:='DE';
// 26.11.05
   Global.CodMontagemKitS:='KS';
   Global.CodMontagemKitE:='KE';
// 28.11.05
   Global.CodContagemBalancoE:='BE';
   Global.CodContagemBalancoS:='BS';
// 05.12.05
   Global.CodTransfEntradaTempo:='XE';
   Global.CodTransfSaidaTempo:='XS';
// 06.12.05
   Global.CodPedVenda:='PV';
   Global.CodPedVendaMostruario:='PM';
// 07.12.05
   Global.CodBaixaMatEnt:='ME';
   Global.CodBaixaMatSai:='MS';
// 09.01.06
   Global.CodVendaBrindeConsig:='BC';
// 06.02.06
   Global.CodTransfEntRetTempo:='YE';
   Global.CodTransfSaiRetTempo:='YS';
// 14.02.06
   Global.CodPedVendaMostruarioConsig:='PC';
// 21.02.06
   Global.CodDevolucaoVendaConsig:='DB';
// 18.04.06 - tipo de movimento para retorno de industrializa��o com servi�os s� pra financeiro- rolos tipo manoel
   Global.CodRetornoInd:='RN';
// 20.04.06
   Global.CodRetornocomServicos:='ES';
// 04.07.06
   Global.CodPedVendaPE:='PE';
// 03.05.07
   Global.CodCompraProdutor:='NP';
// 24.10.07
   Global.CodRetornoRemessaConserto:='RD';
// 30.10.07
   Global.CodDrawBackEnt:='DF';
   Global.CodDrawBackSai:='DS';
// 02.11.07
   Global.CodDesossaEnt:='DG';
   Global.CodDesossaSai:='DH';
// 07.11.07
   Global.CodContrato:='VX';
// 22.11.07
   Global.CodRequisicaoAlmox:='RA';
// 27.11.07
   Global.CodEntradaprocesso:='EP';
   Global.CodSaidaprocesso:='SP';
// 28.11.07
   global.CodContratoEntrega:='VH';
// 12.12.07
   Global.CodRemessaDemo:='RG';
// 19.12.07
   Global.CodEntradaAlmox:='EA';
// 15.01.08
   Global.CodOrdemProducao:='OP';
// 24.01.08
   Global.CodItemObra:='IO';
// 25.03.08
   Global.CodCompraIndustria:='CA';
// 23.05.08
   Global.CodCompraFutura:='CG';
   Global.CodCompraRemessaFutura:='CL';
// 26.06.08
   Global.CodDevolucaoSaida:='DJ';
// 04.07.08
   Global.CodEntradaSemItens:='EI';
// 21.08.08
   Global.CodEntradaImobilizado:='ET';
// 27.10.08
   Global.CodSaidaAlmox:='SA';
// 29.10.08
   Global.CodDevolucaoImob:='DK';
// 06.11.08
   Global.CodDevolucaoSemFinan:='DL';
// 03.12.08
   Global.CodVendaFornecedor:='VJ';
// 03.03.09
   Global.CodPrestacaoServicos:='PS';
// 16.04.09
   Global.CodSaidaGarantia:='SG';
// 08.06.09
   Global.CodEntradaInd:='EN';
// 10.06.09
   Global.CodRemessaIndPropria:='RH';
// 15.06.09
   Global.CodEntradaBrinde:='EB';
// 10.08.09
   Global.CodContratoNota:='VY';
// 04.09.09
   Global.CodContratoDoacao:='DO';
   Global.CodCompraProdutorReclassifica:='NR';
// 06.10.09
   Global.CodEntradaAcabado:='AC';
// 11.03.10 - Novi
   Global.CodDevolucaoCompraProdutor:='DN';
// 22.03.10
   Global.CodRemessaDemoClientes:='RJ';
   Global.CodRemessaContraOrdem:='RK';
// 29.04.10 - Fenix
   Global.CodDevolucaoSimbolicaConsig:='DQ';
   Global.CodCompraConsignado:='CS';
// 06.05.10 - Asatec
   Global.CodDevolucaodeRemessa:='DT';
// 28.06.11 - Capeg
   Global.CodRomaneioRemessaaOrdem:='RO';
// 18.08.11 - Capeg
   Global.CodNotaRemessaaOrdem:='VQ';
// 24.08.11 - Capeg
   Global.CodVendaaOrdem:='VU';
// 28.10.11 - SM - Gris
   Global.CodConhecimentoSaida:='NT';
// 16.03.12 - Abra - Retorno de mercadoria enviado para deposito
   Global.CodRetornoMercDepo:='RQ';
// 31.07.12 - Clessi - Estorno de NFe de Saida
   Global.CodEstornoNFeSai:='EV';
// 11.07.13
   Global.CodPrestacaoServicosE:='PA';
// 22.07.13
   Global.CodOrdemdeServico:='OS';
// 14.09.13
   Global.CodManutencaoEquipamento:='MM';
// 09.11.13
   Global.CodDevolucaoTributada:='DU';
// 11.03.14
   Global.CodFaturaAgua:='FA';
// 17.05.14
   Global.CodEntradaProdutor:='CP';
// 16.03.15
   Global.CodNfeComplementoQtde:='CQ';
// 12.05.15 - Coorlaf
   Global.CodCompraProdutorMerenda:='NM';
// 12.11.15
   Global.CodNfeComplementoIcms:='IC';
// 08.08.16
   Global.CodNfeComplementoValorProdutor:='C1';
end;

//     CodConsigMercantil,CodRetornoConsigMercanil,CodVendaConsigMercantil,CodVendaMostruario,CodRetornoMostruario:string   // 09.02.05

function TFGeral.GetTipoMovto(tipomovto: string ; reduzido:boolean=false ; caixabancos:string='N'): string;
/////////////////////////////////////////////////////////////////////////////
begin
 if tipomovto=Global.CodPrestacaoServicos then
   result:=if_s(not reduzido,'Presta��o Servi�os',Global.CodPrestacaoServicos)
 else if tipomovto=Global.CodPrestacaoServicosE then
   result:=if_s(not reduzido,'Presta��o Servi�os - Entrada',Global.CodPrestacaoServicosE)
 else if tipomovto=Global.CodRemessaConsig then
   result:=if_s(not reduzido,'Remessa de Consigna��o',Global.CodRemessaConsig)
 else if tipomovto=Global.CodDevolucaoConsig then
   result:=if_s(not reduzido,'Devolu��o de Consigna��o',Global.CodDevolucaoConsig)
 else if tipomovto=Global.CodDevolucaoTroca then
   result:=if_s(not reduzido,'Devolu��o de Troca',Global.CodDevolucaoTroca)
 else if tipomovto=Global.CodVendaDireta then
   result:=if_s(not reduzido,'Venda Direta',Global.CodVendaDireta)
 else if tipomovto=Global.CodVendaSerie4 then
   result:=if_s(not reduzido,'Venda Total Serie 4',Global.CodVendaSerie4)
 else if tipomovto=Global.CodVendaLiqSerie4 then
   result:=if_s(not reduzido,'Venda L�quida Serie 4',Global.CodVendaLiqSerie4)
 else if tipomovto=Global.CodVendaConsig then
   result:=if_s(not reduzido,'Venda Consignada',Global.CodVendaConsig)
 else if tipomovto=Global.CodCompra then
   result:=if_s(not reduzido,'Compra Mercadoria',Global.CodCompra)
 else if tipomovto=Global.CodDevolucaoCompra then
   result:=if_s(not reduzido,'Devolu��o de Compra',Global.CodDevolucaoCompra)
 else if tipomovto=Global.CodRomaSerie4 then
   result:=if_s(not reduzido,'Romaneio de Retorno Serie 4',Global.CodRomaSerie4)
 else if tipomovto=Global.CodDevolucaoSerie5 then
   result:=if_s(not reduzido,'Devolu��o Romaneio de Retorno Serie 5',Global.CodDevolucaoSerie5)
 else if tipomovto=Global.CodAcertoEsEnt then
   result:=if_s(not reduzido,'Acerto Est. - Entrada',global.CodAcertoEsEnt)
 else if tipomovto=Global.CodAcertoEsSai then
//   result:=if_s(not reduzido,'Acerto Est. - Saida',global.CodAcertoEsEnt)
   result:=if_s(not reduzido,'Acerto Est. - Saida',global.CodAcertoEsSai)   //  16.06.05
 else if tipomovto=Global.CodVendaSemMovEstoque then
   result:=if_s(not reduzido,'Venda Sem Mov.Estoque - Saida',global.CodVendaSemMovEstoque)
 else if tipomovto=Global.CodCompraSemMovEstoque then
   result:=if_s(not reduzido,'Compra Sem Mov.Estoque - Entrada',global.CodCompraSemMovEstoque)
 else if tipomovto=Global.CodConhecimento then
   result:=if_s(not reduzido,'Conhecimento de Frete',global.CodConhecimento)
 else if tipomovto=Global.CodConhecimentoSaida then
   result:=if_s(not reduzido,'Conhecimento de Frete Emitido(Saida)',global.CodConhecimentoSaida)
 else if tipomovto=Global.CodTransfEntrada then
   result:=if_s(not reduzido,'Transfer�ncia - Entrada',global.CodTransfEntrada)
 else if tipomovto=Global.CodTransfSaida then
   result:=if_s(not reduzido,'Transfer�ncia - Saida',global.CodTransfSaida)
 else if tipomovto=Global.CodTransfEnt then
   result:=if_s(not reduzido,'Transfer�ncia - Entrada sem movimento',global.CodTransfEnt)
 else if tipomovto=Global.CodTransfSai then
   result:=if_s(not reduzido,'Transfer�ncia - Saida sem movimento',global.CodTransfSai)
 else if tipomovto=Global.CodVendaProntaEntrega then
   result:=if_s(not reduzido,'Venda Pronta Entrega',Global.CodVendaProntaEntrega)
 else if tipomovto=Global.CodVendaBrinde then
   result:=if_s(not reduzido,'Venda Brinde',Global.CodVendaBrinde)
 else if tipomovto=Global.CodVendaTransf then
   result:=if_s(not reduzido,'Venda Transfer�ncia',Global.CodVendaTransf)
 else if tipomovto=Global.CodVendaRomaneio then
//   result:=if_s(not reduzido,'Venda Romaneio Ambulante',Global.CodVendaRomaneio)  // para "encher o carro"
// 06.05.05
   result:=if_s(not reduzido,'Romaneio de Saida para Venda Ambulante',Global.CodVendaRomaneio)  // para "encher o carro"
 else if tipomovto=Global.CodVendaAmbulante then
   result:=if_s(not reduzido,'Venda Ambulante',Global.CodVendaAmbulante)   // "no carro"
 else if tipomovto=Global.CodTransImob then
   result:=if_s(not reduzido,'Transf. Imobilizado Saida',Global.CodTransImob)
 else if tipomovto=Global.CodTransImobE then
   result:=if_s(not reduzido,'Transf. Imobilizado Entrada',Global.CodTransImobE)
 else if tipomovto=Global.CodSimplesRemessa then
   result:=if_s(not reduzido,'Simples Remessa',Global.CodSimplesRemessa)
 else if tipomovto=Global.CodRemessaProntaEntrega then
   result:=if_s(not reduzido,'Remessa de Pronta Entrega',Global.CodRemessaProntaEntrega)
 else if tipomovto=Global.CodRemessaInd then
   result:=if_s(not reduzido,'Remessa p/ Industrializa��o',Global.CodRemessaInd)
 else if tipomovto=Global.CodCompra100 then
   result:=if_s(not reduzido,'Compra Mercadoria',Global.CodCompra100)
 else if tipomovto=Global.CodCompraX then
   result:=if_s(not reduzido,'Compra Mercadoria X',Global.CodCompraX)
 else if tipomovto=Global.CodDevolucaoProntaEntrega then
   result:=if_s(not reduzido,'Devolu��o Pronta Entrega',Global.CodDevolucaoProntaEntrega)
 else if tipomovto=Global.CodDevolucaoInd then
   result:=if_s(not reduzido,'Retorno Industrializa��o',Global.CodDevolucaoInd)
 else if tipomovto=Global.CodDevolucaoRoman then
   result:=if_s(not reduzido,'Devolu��o Romaneio Ambulante',Global.CodDevolucaoRoman)
 else if tipomovto=Global.CodDevolucaoVenda then
   result:=if_s(not reduzido,'Devolu��o Venda',Global.CodDevolucaoVenda)
 else if tipomovto=Global.CodDevolucaoImob then
   result:=if_s(not reduzido,'Devolu��o Imobilizado',Global.CodDevolucaoImob)
 else if tipomovto=Global.CodDevolucaoConsigMerc then
   result:=if_s(not reduzido,'Devolu��o Consigna��o Mercantil',Global.CodDevolucaoConsigMerc)
 else if tipomovto=Global.CodConsigMercantil then
   result:=if_s(not reduzido,'Remessa Consigna��o Mercantil',Global.CodConsigMercantil)
 else if tipomovto=Global.CodRetornoConsigMercanil then
   result:=if_s(not reduzido,'Retorno Consigna��o Mercantil',Global.CodRetornoConsigMercanil)
 else if tipomovto=Global.CodVendaConsigMercantil then
   result:=if_s(not reduzido,'Venda Consigna��o Mercantil',Global.CodVendaConsigMercantil)
 else if tipomovto=Global.CodVendaMostruario then
   result:=if_s(not reduzido,'Venda Mostru�rio',Global.CodVendaMostruario)
 else if tipomovto=Global.CodVendaProntaEntregaFecha then
   result:=if_s(not reduzido,'Venda Pronta Entrega Fechamento',Global.CodVendaProntaEntregaFecha)
 else if tipomovto=Global.CodRetornoMostruario then
   result:=if_s(not reduzido,'Retorno Mostru�rio',Global.CodRetornoMostruario)
 else if tipomovto=Global.CodPendenciaFinanceira then
   result:=if_s(not reduzido,'Pendencia Financeira',Global.CodPendenciaFinanceira)
 else if tipomovto=Global.CodJurosRecebidos then
   result:=if_s(not reduzido,'Juros Recebidos',Global.CodJurosRecebidos)
 else if tipomovto=Global.CodDescontosDados then
   result:=if_s(not reduzido,'Descontos Concedidos',Global.CodDescontosDados)
 else if tipomovto=Global.CodVendaPecaProblema then
   result:=if_s(not reduzido,'Venda Pe�a Problema',Global.CodVendaPecaProblema)
 else if tipomovto=Global.CodVendaREFinal then
   result:=if_s(not reduzido,'Venda Final S�rie 4',Global.CodVendaREFinal)
 else if tipomovto=Global.CodVendaRE then
   result:=if_s(not reduzido,'Venda Parcial S�rie 4',Global.CodVendaRE)
 else if tipomovto=Global.CodVendaREBrinde then
   result:=if_s(not reduzido,'Venda Brinde S�rie 4',Global.CodVendaREBrinde)
// 01.08.05
 else if tipomovto=Global.CodTransMatConsumoE then
   result:=if_s(not reduzido,'Transf. Material Consumo-Entrada',Global.CodTransMatConsumoE)
 else if tipomovto=Global.CodTransMatConsumoS then
   result:=if_s(not reduzido,'Transf. Material Consumo-Saida',Global.CodTransMatConsumoS)
 else if tipomovto=Global.CodRemessaConserto then
   result:=if_s(not reduzido,'Remessa para Conserto',Global.CodRemessaConserto)
 else if tipomovto=Global.CodCompraImobilizado then
   result:=if_s(not reduzido,'Compra Imobilizado',Global.CodCompraImobilizado)
 else if tipomovto=Global.CodCompraMatConsumo then
   result:=if_s(not reduzido,'Compra Mat. Uso e Consumo',Global.CodCompraMatConsumo)
 else if tipomovto=Global.CodDevolucaoIgualVenda then
   result:=if_s(not reduzido,'Devolu��o Igual Venda',Global.CodDevolucaoIgualVenda)
 else if tipomovto=Global.CodVendaSemfinan then
   result:=if_s(not reduzido,'Venda sem Financeiro',Global.CodVendaSemfinan)
 else if tipomovto=Global.CodCompraSemfinan then
   result:=if_s(not reduzido,'Compra sem Financeiro',Global.CodCompraSemfinan)
 else if tipomovto=Global.CodVendaMostruarioII then
   result:=if_s(not reduzido,'Venda Mostru�rio com Financeiro',Global.CodVendaMostruarioII)
 else if tipomovto=Global.CodDevolucaoCompraSemEstoque then
   result:=if_s(not reduzido,'Devolu��o de Compra Sem Estoque',Global.CodDevolucaoCompraSemEstoque)
 else if tipomovto=Global.CodMontagemKitE then
   result:=if_s(not reduzido,'Montagem Kit Entrada',Global.CodMontagemKitE)
 else if tipomovto=Global.CodMontagemKitS then
   result:=if_s(not reduzido,'Montagem Kit Saida',Global.CodMontagemKitS)
 else if tipomovto=Global.CodContagemBalancoS then
   result:=if_s(not reduzido,'Contagem Balan�o Saida',Global.CodContagemBalancoS)
 else if tipomovto=Global.CodContagemBalancoE then
   result:=if_s(not reduzido,'Contagem Balan�o Entrada',Global.CodContagemBalancoE)
 else if tipomovto=Global.CodTransfEntradaTempo then
   result:=if_s(not reduzido,'Transfer�ncia - Temporada Entrada',global.CodTransfEntradaTempo)
 else if tipomovto=Global.CodTransfSaidaTempo then
   result:=if_s(not reduzido,'Transfer�ncia - Temporada Saida',global.CodTransfSaidaTempo)
 else if tipomovto=Global.CodPedVenda then
   result:=if_s(not reduzido,'Pedido de Venda',global.CodPedVenda)
 else if tipomovto=Global.CodPedVendaMostruario then
   result:=if_s(not reduzido,'Pedido de Venda de Mostru�rio',global.CodPedVendaMostruario)
 else if tipomovto=Global.CodBaixaMatEnt then
   result:=if_s(not reduzido,'Mov Mat�ria Prima - Entrada',global.CodBaixaMatEnt)
 else if tipomovto=Global.CodBaixaMatSai then
   result:=if_s(not reduzido,'Mov Mat�ria Prima - Saida',global.CodBaixaMatSai)   //  07.12.05
 else if tipomovto=Global.CodVendaBrindeConsig then
   result:=if_s(not reduzido,'Venda Brinde Consignado',Global.CodVendaBrindeConsig)
 else if tipomovto=Global.CodTransfEntRetTempo then
   result:=if_s(not reduzido,'Transfer�ncia - Retorno Temporada Entrada',global.CodTransfEntRetTempo)
 else if tipomovto=Global.CodTransfSaiRetTempo then
   result:=if_s(not reduzido,'Transfer�ncia - Retorno Temporada Saida',global.CodTransfSaiRetTempo)
// 09.02.05
 else if tipomovto=Global.CodVendaImobilizado then
   result:=if_s(not reduzido,'Venda de Imobilizado',global.CodVendaImobilizado)
 else if tipomovto=Global.CodVendaMagazine then
   result:=if_s(not reduzido,'Venda Magazine',global.CodVendaMagazine)
 else if tipomovto=Global.CodPedVendaMostruarioConsig then
   result:=if_s(not reduzido,'Pedido de Venda de Mostru�rio Consignada',global.CodPedVendaMostruarioConsig)
 else if tipomovto=Global.CodDevolucaoVendaConsig then
   result:=if_s(not reduzido,'Devolu��o Venda Consignada',Global.CodDevolucaoVendaConsig)
 else if tipomovto=Global.CodRetornoInd then
   result:=if_s(not reduzido,'Retorno Indust. sem servi�o no fiscal ',Global.CodRetornoInd)
 else if tipomovto=Global.CodRetornocomServicos then
   result:=if_s(not reduzido,'Retorno Servi�o Industrializa��o ',Global.CodRetornocomServicos)
 else if tipomovto=Global.CodRetornoMercDepo then
   result:=if_s(not reduzido,'Retorno Mercadoria Dep�sito ',Global.CodRetornoMercDepo)
 else if tipomovto=Global.CodLanCaixaBancos then
   result:=if_s(not reduzido,'Lan�amento Caixa/bancos'          ,Global.CodLanCaixaBancos)
// 04.07.06
 else if tipomovto=Global.CodPedVendaPE then
   result:=if_s(not reduzido,'Pedido de Venda Pronta Entrega',global.CodPedVendaPE)
 else if tipomovto=Global.CodCompraProdutor then
   result:=if_s(not reduzido,'Compra de Produtor Rural',Global.CodCompraProdutor)
 else if tipomovto=Global.CodEntradaProdutor then
   result:=if_s(not reduzido,'Compra de Produtor Rural sem Contra Nota',Global.CodEntradaProdutor)
 else if tipomovto='CR' then
   result:=if_s(not reduzido,'Recebimentos'    ,'CR')
 else if tipomovto='CP' then
   result:=if_s(not reduzido,'Pagamentos'      ,'CP')
 else if tipomovto=Global.CodRetornoRemessaConserto then
   result:=if_s(not reduzido,'Retorno Remessa para Conserto',Global.CodRetornoRemessaConserto)
 else if tipomovto=Global.CodDrawBackEnt then
   result:=if_s(not reduzido,'Drawback Entrada',Global.CodDrawBackEnt)
 else if tipomovto=Global.CodDrawBackSai then
   result:=if_s(not reduzido,'Drawback Saida',Global.CodDrawBackSai)
 else if tipomovto=Global.CodDesossaEnt then
   result:=if_s(not reduzido,'Desossa Entrada',Global.CodDesossaEnt)
 else if tipomovto=Global.CodDesossaSai then
   result:=if_s(not reduzido,'Desossa Saida',Global.CodDesossaSai)
 else if tipomovto=Global.CodContrato then
   result:=if_s(not reduzido,'Venda Contrato',Global.CodContrato)
 else if tipomovto=Global.CodContratoNota then
   result:=if_s(not reduzido,'Venda Contrato Nota',Global.CodContratoNota)
 else if tipomovto=Global.CodContratoEntrega then
   result:=if_s(not reduzido,'Venda Contrato Entrega',Global.CodContratoEntrega)
 else if tipomovto=Global.CodRequisicaoAlmox then
   result:=if_s(not reduzido,'Requisi��o Almoxarifado',Global.CodRequisicaoAlmox)
 else if tipomovto=Global.CodEntradaprocesso then
   result:=if_s(not reduzido,'Entrada Estoque em Processo',Global.CodEntradaprocesso)
 else if tipomovto=Global.CodSaidaprocesso then
   result:=if_s(not reduzido,'Saida Estoque em Processo',Global.CodSaidaprocesso)
 else if tipomovto=Global.CodRemessaDemo then
   result:=if_s(not reduzido,'Remessa em Demonstra��o',Global.CodRemessaDemo)
 else if tipomovto=Global.CodEntradaAlmox then
   result:=if_s(not reduzido,'Entrada no Almoxarifado',Global.CodEntradaAlmox)
 else if tipomovto=Global.CodSaidaAlmox then
   result:=if_s(not reduzido,'Saida do Almoxarifado',Global.CodSaidaAlmox)
 else if tipomovto=Global.CodCompraIndustria then
   result:=if_s(not reduzido,'Compra Ind�stria',Global.CodCompraIndustria)
 else if tipomovto=Global.CodDevolucaoSaida then
   result:=if_s(not reduzido,'Devolu��o Saida',Global.CodDevolucaoSaida)
 else if tipomovto=Global.CodEntradaSemItens then
   result:=if_s(not reduzido,'Compra Sem Itens da Nota',Global.CodEntradaSemItens)
 else if tipomovto=Global.CodEntradaImobilizado then
   result:=if_s(not reduzido,'Entrada Imobilizado',Global.CodEntradaImobilizado)
 else if tipomovto=Global.CodCompraFutura then
   result:=if_s(not reduzido,'Compra Futura',Global.CodCompraRemessaFutura)
 else if tipomovto=Global.CodCompraRemessaFutura then
   result:=if_s(not reduzido,'Compra Futura Entrega',Global.CodCompraRemessaFutura)
 else if tipomovto=Global.CodDevolucaoSemFinan then
   result:=if_s(not reduzido,'Devolu��o Sem Financeiro',Global.CodDevolucaoSemFinan)
 else if tipomovto=Global.CodDevolucaodeRemessa then
   result:=if_s(not reduzido,'Devolu��o de Remessa',Global.CodDevolucaodeRemessa)
 else if tipomovto=Global.Codvendainterna then
   result:=if_s(not reduzido,'Venda Internet',Global.Codvendainterna)
 else if tipomovto=Global.CodVendaFornecedor then
   result:=if_s(not reduzido,'Venda para Fornecedor',Global.CodVendaFornecedor)
 else if tipomovto=Global.CodSaidaAlmox then
   result:=if_s(not reduzido,'Saida do Almoxarifado',Global.CodSaidaAlmox)
 else if tipomovto=Global.CodSaidaGarantia then
   result:=if_s(not reduzido,'Saida Produtos em Garantia',Global.CodSaidaGarantia)
 else if tipomovto=Global.CodEntradaInd then
   result:=if_s(not reduzido,'Entrada para Industrializa��o',Global.CodEntradaInd)
 else if tipomovto=Global.CodRemessaIndPropria then
   result:=if_s(not reduzido,'Remessa Industrializa��o Pr�pria',Global.CodRemessaIndPropria)
 else if tipomovto=Global.CodEntradaBrinde then
   result:=if_s(not reduzido,'Entrada Bonifica��o, Brinde ou Doa��o',Global.CodEntradaBrinde)
 else if tipomovto=Global.CodContratoDoacao then
   result:=if_s(not reduzido,'Venda Contrato Doa��o',Global.CodContratoDoacao)
 else if tipomovto=Global.CodCompraProdutorReclassifica then
   result:=if_s(not reduzido,'Compra de Produtor Rural Reclassifica��o',Global.CodCompraProdutorReclassifica)
 else if tipomovto=Global.CodEntradaAcabado then
   result:=if_s(not reduzido,'Entrada de Produto Acabado',Global.CodEntradaAcabado)
 else if tipomovto=Global.CodDevolucaoCompraProdutor then
   result:=if_s(not reduzido,'Devolu��o Compra de Produtor',Global.CodDevolucaoCompraProdutor)
 else if tipomovto=Global.CodRemessaDemoClientes then
   result:=if_s(not reduzido,'Remessa em Demonstra��o (Clientes)',Global.CodRemessaDemoClientes)
 else if tipomovto=Global.CodRemessaContraOrdem then
   result:=if_s(not reduzido,'Remessa Contra Ordem (Clientes)',Global.CodRemessaContraOrdem)
 else if tipomovto=Global.CodDevolucaoSimbolicaConsig then
   result:=if_s(not reduzido,'Devolu��o Simb�lica de Consigna��o',Global.CodDevolucaoSimbolicaConsig)
 else if tipomovto=Global.CodCompraConsignado then
   result:=if_s(not reduzido,'Compra Produto Consignado',Global.CodCompraConsignado)
 else if tipomovto=Global.CodRomaneioRemessaaOrdem then
   result:=if_s(not reduzido,'Romaneio de Remessa a Ordem',Global.CodRomaneioRemessaaOrdem)
 else if tipomovto=Global.CodNotaRemessaaOrdem then
   result:=if_s(not reduzido,'Nota de Remessa a Ordem',Global.CodNotaRemessaaOrdem)
 else if tipomovto=Global.CodNotaRemessaaOrdem then
   result:=if_s(not reduzido,'Nota de Remessa a Ordem',Global.CodNotaRemessaaOrdem)
 else if tipomovto=Global.CodVendaaOrdem then
   result:=if_s(not reduzido,'Venda a Ordem',Global.CodVendaaOrdem)
 else if tipomovto=Global.CodEstornoNFeSai then
   result:=if_s(not reduzido,'Estorno de NF-e de Venda n�o cancelada',Global.CodEstornoNFeSai)
 else if tipomovto=Global.CodDevolucaoTributada then
   result:=if_s(not reduzido,'Devolu��o com Cr�dito Icms/IPI',Global.CodDevolucaoTributada)
 else if tipomovto=Global.CodFaturaAgua then
   result:=if_s(not reduzido,'Conta de �gua',Global.CodFaturaAgua)
 else if tipomovto=Global.CodNfeComplementoQtde then
   result:=if_s(not reduzido,'Complemento de Quantidade',Global.CodNfeComplementoQtde)
 else if tipomovto=Global.CodNfeComplementoValorProdutor then
   result:=if_s(not reduzido,'Entrada Complemento de Valor',Global.CodNfeComplementoValorProdutor)
 else if tipomovto=Global.CodNfeComplementoIcms then
   result:=if_s(not reduzido,'Complemento de Icms',Global.CodNfeComplementoicms)
 else if tipomovto=Global.CodCompraProdutorMerenda then
   result:=if_s(not reduzido,'Compra de Produtor Rural Merenda',Global.CodCompraProdutorMerenda)
 else if trim(tipomovto)<>'' then
   result:=if_s(not reduzido,'Movto desconhecido','MD');
 if caixabancos='S' then begin
   if tipomovto=Global.CodChequeDevolvido then
     result:=if_s(not reduzido,'Cheque Devolvido',Global.CodChequeDevolvido)
   else if tipomovto=Global.CodPendenciaFinanceira then
     result:=if_s(not reduzido,'Pendencia Baixada',Global.CodPendenciaFinanceira)
   else if tipomovto='CH' then
     result:=if_s(not reduzido,'Cheque','CH')
   else
     result:=if_s(not reduzido,'Movto desconhecido','MD');
 end;
end;



function TFGeral.GetEntSaiTipoMovto(tipomovto: string): string;
//////////////////////////////////////////////////////////////////////////////
begin
 if pos(tipomovto,Global.CodContagemBalancoE+';'+Global.CodContagemBalancoS)>0 then
   result:='B'
 else if pos(tipomovto,Global.TiposMovMovEntrada)>0 then
   result:='+'
 else if pos(tipomovto,Global.TiposMovMovEstoque)>0 then
   result:='-'
 else
   result:='/'
end;

procedure TFGeral.SetaItemsMovimento(Ed: TSqlEd);
/////////////////////////////////////////////////////////
begin
  Ed.Items.clear;
  Ed.Items.Add(Global.CodPrestacaoServicos+' - Presta��o Servi�os' );
  Ed.Items.Add(Global.CodPrestacaoServicosE+' - Presta��o Servi�os Entrada' );
  Ed.Items.Add(Global.CodRemessaConsig+' - Remessa consigna��o' );
  Ed.Items.Add(Global.CodRemessaProntaEntrega+' - Remessa de pronta entrega' );
  Ed.Items.Add(Global.CodConsigMercantil+' - Remessa Consigna��o Mercantil' );
  Ed.Items.Add(Global.CodRemessaInd+' - Remessa p/ Industrializa��o');
  Ed.Items.Add(Global.CodRemessaIndPropria+' - Remessa de Industrializa��o Pr�pria');
  Ed.Items.Add(Global.CodRemessaConserto+' - Remessa p/ Conserto');
  Ed.Items.Add(Global.CodRemessaDemo+' - Remessa em Demonstra��o (Fornec.)');
  Ed.Items.Add(Global.CodRemessaDemoClientes+' - Remessa em Demonstra��o (Clientes)');
  Ed.Items.Add(Global.CodRemessaContraOrdem+' - Remessa Contra Ordem (Clientes)');
  Ed.Items.Add(Global.CodRomaneioRemessaaOrdem+' - Romaneio de Remessa a Ordem (Clientes)');
  Ed.Items.Add(Global.CodNfeComplementoQtde+' - Complemento de Quantidade');
  Ed.Items.Add(Global.CodNfeComplementoValorProdutor+' - Complemento de Valor Entrada');
  Ed.Items.Add(Global.CodNfeComplementoIcms+' - Complemento de Icms');
//   Global.CodConsigMercantil:='MC';
  Ed.Items.Add(Global.CodDevolucaoConsig+' - Devolu��o de consigna��o');
  Ed.Items.Add(Global.CodRetornoConsigMercanil+' - Retorno de consigna��o mercantil');
//   Global.CodRetornoConsigMercanil:='MR';
  Ed.Items.Add(Global.CodDevolucaoCompra+' - Devolu��o compra');
  Ed.Items.Add(Global.CodDevolucaoInd+' - Retorno Industrializa��o');
  Ed.Items.Add(Global.CodRetornoMercDepo+' - Retorno Mercadoria Dep�sito');
  Ed.Items.Add(Global.CodDevolucaoProntaEntrega+' - Devolu��o Pronta Entrega');
  Ed.Items.Add(Global.CodDevolucaoTroca+' - Devolu��o de troca na consigna��o');
  Ed.Items.Add(Global.CodDevolucaoRoman+' - Devolu��o Romaneio Ambulante');
  Ed.Items.Add(Global.CodDevolucaoVenda+' - Devolu��o de Venda');
  Ed.Items.Add(Global.CodDevolucaoVendaConsig+' - Devolu��o de Venda Consignada');
  Ed.Items.Add(Global.CodDevolucaoConsigMerc+' - Devolu��o Consigna��o Mercantil');
  Ed.Items.Add(Global.CodDevolucaoIgualVenda+' - Devolu��o Igual Venda');
  Ed.Items.Add(Global.CodDevolucaoCompraSemEstoque+' - Devolu��o Compra Sem Estoque');
  Ed.Items.Add(Global.CodDevolucaoSaida+' - Devolu��o Saida');
  Ed.Items.Add(Global.CodDevolucaoImob+' - Devolu��o Imobilizado');
  Ed.Items.Add(Global.CodDevolucaoSemFinan+' - Devolu��o Sem Financeiro');
  Ed.Items.Add(Global.CodDevolucaoCompraProdutor+' - Devolu��o de Compra de Produtor');
  Ed.Items.Add(Global.CodDevolucaoSimbolicaConsig+' - Devolu��o Simb�lica de Consigna��o');
  Ed.Items.Add(Global.CodDevolucaodeRemessa+' - Devolu��o de Remessa');
  Ed.Items.Add(Global.CodDevolucaoTributada+' - Devolu��o c/Icms e Ipi');
  Ed.Items.Add(Global.CodRomaSerie4+' - Romaneio de Retorno');
  Ed.Items.Add(Global.CodDevolucaoSerie5+' - Devolu��o Romaneio de Retorno');
  Ed.Items.Add(Global.CodRetornoMostruario+' - Retorno Mostru�rio');
  Ed.Items.Add(Global.CodRetornoRemessaConserto+' - Retorno Remessa p/ Conserto');
// 31.07.12 - Clessi - Estorno de NFe de Saida
  Ed.Items.Add(Global.CodEstornoNFeSai+' - Estorno NFe de Venda N�o Cancelada');
  Ed.Items.Add(Global.CodVendaDireta+' - Venda direta');
  Ed.Items.Add(Global.CodVendaImobilizado+' - Venda Imobilizado');
  Ed.Items.Add(Global.CodVendaBrinde+' - Venda Brinde');
  Ed.Items.Add(Global.CodVendaMostruario+' - Venda Mostru�rio');
// 07.11.07
  Ed.Items.Add(Global.CodContrato+' - Venda Contrato');
// 10.08.09
  Ed.Items.Add(Global.CodContratoNota+' - Venda Contrato Nota');
// 04.09.09
  Ed.Items.Add(Global.CodContratoDoacao+' - Venda Contrato Doa��o');
// 28.11.07
  Ed.Items.Add(Global.CodContratoEntrega+' - Venda Contrato Entrega');
  Ed.Items.Add(Global.CodSaidaGarantia+' - Saida Produto em Garantia');
  Ed.Items.Add(Global.CodVendaConsig+' - Venda consignada');
  Ed.Items.Add(Global.CodVendaProntaEntrega+' - Venda pronta entrega');
  Ed.Items.Add(Global.CodVendaProntaEntregaFecha+' - Venda pronta entrega Fechamento');
  Ed.Items.Add(Global.CodVendaSemMovEstoque+' - Venda Sem Mov.Estoque');
  Ed.Items.Add(Global.CodVendaMagazine+' - Venda Magazine');
  Ed.Items.Add(Global.Codvendainterna+' - Venda Internet');
  Ed.Items.Add(Global.CodVendaRomaneio+' - Venda Romaneio Ambulante');
  Ed.Items.Add(Global.CodVendaAmbulante+' - Venda Ambulante');
  Ed.Items.Add(Global.CodVendaSerie4+' - Venda Total Serie 4');
  Ed.Items.Add(Global.CodVendaLiqSerie4+' - Venda L�quida Serie 4');
  Ed.Items.Add(Global.CodVendaConsigMercantil+' - Venda Consigna��o Mercantil');
  Ed.Items.Add(Global.CodVendaPecaProblema+' - Venda Pe�a Problema');
  Ed.Items.Add(Global.CodVendaRE+' - Venda Parcial S�rie 4');
  Ed.Items.Add(Global.CodVendaREFinal+' - Venda Final S�rie 4');
  Ed.Items.Add(Global.CodVendaREBrinde+' - Venda Brinde S�rie 4');
  Ed.Items.Add(Global.CodVendaBrindeConsig+' - Venda Brinde Consignado');
  Ed.Items.Add(Global.CodVendaTransf+' - Venda Transfer�ncia');
//  Ed.Items.Add(Global.CodVendaImobilizado+' - Venda Transfer�ncia');
  Ed.Items.Add(Global.CodVendaSemfinan+' - Venda sem Financeiro');
  Ed.Items.Add(Global.CodVendaMostruarioII+' - Venda Mostru�rio com Financeiro');
  Ed.Items.Add(Global.CodVendaFornecedor+' - Venda para Fornecedor');
  Ed.Items.Add(Global.CodNOtaRemessaaOrdem+' - Nota de Remessa a Ordem');
  Ed.Items.Add(Global.CodVendaaOrdem+' - Venda de Remessa a Ordem');
// 14.06.16
  Ed.Items.Add(Global.CodPedVendaMostruarioConsig+' - Venda Mostru�rio Consignado');
//   Global.CodRetornoMostruario:='RM';
//   Global.CodVendaMostruario:='SM';
//   Global.CodVendaConsigMercantil:='MV';
  Ed.Items.Add(Global.CodCompra+' - Compra mercadoria');
  Ed.Items.Add(Global.CodCompra100+' - Compra mercadoria');
// 04.07.08
  Ed.Items.Add(Global.CodEntradaSemItens+' - Compras Sem Itens da Nota');
  Ed.Items.Add(Global.CodCompraX+' - Compra mercadoria X');
  Ed.Items.Add(Global.CodConhecimento+' - Conhecimento de Frete');
  Ed.Items.Add(Global.CodConhecimentoSaida+' - Conhecimento de Frete Emitido(Saida)');
  Ed.Items.Add(Global.CodCompraSemMovEstoque+' - Compra sem mov. estoque');
  Ed.Items.Add(Global.CodCompraImobilizado+' - Compra Imobilizado');
  Ed.Items.Add(Global.CodEntradaImobilizado+' - Entrada Imobilizado');
  Ed.Items.Add(Global.CodCompraMatConsumo+' - Compra Material Consumo');
  Ed.Items.Add(Global.CodCompraSemfinan+' - Compra sem Financeiro');
  Ed.Items.Add(Global.CodCompraProdutor+' - Compra Produtor Rural');
  Ed.Items.Add(Global.CodEntradaProdutor+' - Compra Produtor Rural sem Contra Nota');
  Ed.Items.Add(Global.CodCompraProdutorReclassifica+' - Compra Produtor Rural Reclassifica��o');
  Ed.Items.Add(Global.CodCompraProdutorMerenda+' - Compra Produtor Rural Merenda');
  Ed.Items.Add(Global.CodCompraIndustria+' - Compra Ind�stria');
// 23.05.08 e s� em 30.09.08 'disponibilizou'...jamanta...
  Ed.Items.Add(Global.CodCompraFutura+' - Compra Futura');
  Ed.Items.Add(Global.CodCompraRemessaFutura+' - Compra Futura Entrega');
  Ed.Items.Add(Global.CodCompraConsignado+' - Compra Produto Consignado');
  Ed.Items.Add(Global.CodEntradaInd+' - Entrada para Industrializa��o');
// 15.06.09
  Ed.Items.Add(Global.CodEntradaBrinde+' - Entrada Bonifica��o,Brinde ou Doa��o');
// 11.03.14
  Ed.Items.Add(Global.CodFaturaAgua+' - Conta de �gua');
  Ed.Items.Add(Global.CodAcertoEsEnt+' - Acertos estoque (entrada)');
  Ed.Items.Add(Global.CodAcertoEsSai+' - Acertos estoque (saida)');
  Ed.Items.Add(Global.CodBaixaMatSai+' - Mov Mat. Prima (saida)');
  Ed.Items.Add(Global.CodBaixaMatEnt+' - Mov Mat. Prima (entrada)');
  Ed.Items.Add(Global.CodContagemBalancoE+' - Contagem Balan�o (entrada)');
  Ed.Items.Add(Global.CodContagemBalancoS+' - Contagem Balan�o (saida)');
  Ed.Items.Add(Global.CodTransfEntrada+' - Transfer�ncia estoque (entrada)');
  Ed.Items.Add(Global.CodTransfSaida+' - Transfer�ncia estoque (saida)');
  Ed.Items.Add(Global.CodTransfEnt+' - Transfer�ncia estoque (entrada sem movimento)');
  Ed.Items.Add(Global.CodTransfSai+' - Transfer�ncia estoque (saida sem movimento)');
  Ed.Items.Add(Global.CodTransImob+' - Transfer�ncia de Imobilizado Saida');
  Ed.Items.Add(Global.CodTransImobE+' - Transfer�ncia de Imobilizado Entrada');
  Ed.Items.Add(Global.CodTransfEntradaTempo+' - Transfer�ncia estoque temporada (entrada)');
  Ed.Items.Add(Global.CodTransfSaidaTempo+' - Transfer�ncia estoque temporada (saida)');
  Ed.Items.Add(Global.CodTransfEntRetTempo+' - Transfer�ncia estoque Retorno temporada (entrada)');
  Ed.Items.Add(Global.CodTransfSaiRetTempo+' - Transfer�ncia estoque Retorno temporada (saida)');
  Ed.Items.Add(Global.CodTransMatConsumoE+' - Transfer�ncia Material Consumo Entrada');
  Ed.Items.Add(Global.CodTransMatConsumoS+' - Transfer�ncia Material Consumo Saida');

  Ed.Items.Add(Global.CodSimplesRemessa+' - Simples Remessa');
// 26.11.05
  Ed.Items.Add(Global.CodMontagemKitE+' - Montagem Kit Entrada');
  Ed.Items.Add(Global.CodMontagemKitS+' - Montagem Kit Saida');
// 18.04.06
  Ed.Items.Add(Global.CodRetornoInd+' - Retorno Indust. sem servi�o fiscal');
// 20.04.06
  Ed.Items.Add(Global.CodRetornocomServicos+' - Retorno Servi�o Industrializa��o');
// 31.10.07
  Ed.Items.Add(Global.CodDrawBackEnt+' - Drawback Entrada');
  Ed.Items.Add(Global.CodDrawBackSai+' - Drawback Saida');
// 02.11.07
  Ed.Items.Add(Global.CodDesossaEnt+' - Desossa Entrada');
  Ed.Items.Add(Global.CodDesossaSai+' - Desossa Saida');
// 22.11.07
  Ed.Items.Add(Global.CodRequisicaoAlmox+' - Requisi��o Almoxarifado');
// 11.03.09
  Ed.Items.Add(Global.CodSaidaAlmox+' - Saida Almoxarifado');
// 27.11.07
  Ed.Items.Add(Global.CodEntradaprocesso+' - Entrada Estoque em Processo');
  Ed.Items.Add(Global.CodSaidaprocesso+' - Saida Estoque em Processo');
// 06.10.09
  Ed.Items.Add(Global.CodEntradaAcabado+' - Entrada Estoque Produto Acabado');

end;



/////////////////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaItensConsignacao(Emissao: TDatetime; Cliente:TSqlEd ;
  Representante: integer; Unidade, TipoMovimento,Transacao: string ; Numero: Integer ; Grid: TSqlDtGrid);
var linha:integer;
    QEstQtde:TSqlquery;
/////////////////////////////////////////////////////////////////////////////////////////////
begin
  for linha:=1 to Grid.rowcount do begin
    if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha])<>'' then begin
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha]);
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',numero);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',TipoMovimento);
      Sistema.SetField('move_unid_codigo',Unidade);
      if TipoMovimento<>Global.CodManutencaoEquipamento then begin
        Sistema.SetField('move_core_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcor'),linha],0) );
        Sistema.SetField('move_tama_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codtamanho'),linha],0) );
        Sistema.SetField('move_copa_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcopa'),linha],0) );
        Sistema.SetField('move_perdesco',texttovalor(Grid.Cells[grid.getcolumn('move_perdesco'),linha]));
        Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('move_vendabru'),linha]));
      end else begin
// 29.11.13
        Sistema.SetField('move_pecas',Texttovalor(Grid.Cells[Grid.getcolumn('move_pecas'),linha]));
      end;
      Sistema.SetField('move_tipo_codigo',Cliente.AsInteger);
      Sistema.SetField('move_tipocad','C');
      Sistema.SetField('move_repr_codigo',Representante);
      Sistema.SetField('move_qtde',Texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),linha]));
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',Emissao);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_venda',Texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),linha]));
      Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.Post('');

// 13.06.05 - op��o de baixar o estoque somente quando grava e nao durante a digitacao
      if (global.Topicos[1201]) and ( TipoMovimento<>Global.CodManutencaoEquipamento ) then begin
        QEstQtde:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Grid.Cells[0,linha],Unidade));
        if not QEstQtde.Eof then
          FGeral.MovimentaQtdeEstoque(Grid.Cells[0,linha],Unidade,'S',Global.CodRemessaConsig,Texttovalor(Grid.Cells[2,linha]),QEstqtde);
        QEstQtde.Close;
        Freeandnil(QEstQtde);
      end;

    end;
  end;
(*
  else begin
      codigograde:=FEstoque.GetCodigoGrade(Grid.Cells[0,linha]);
      Sistema.Edit('Movestoque');
//      Sistema.SetField('move_esto_codigo',Grid.Cells[0,linha]);
      codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[0,linha],codigograde);
      codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[0,linha],codigograde);
      if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
        Sistema.SetField('move_tama_codigo',codigolinha)
      else
        Sistema.SetField('move_core_codigo',codigolinha);
      if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
        Sistema.SetField('move_tama_codigo',codigocoluna)
      else
        Sistema.SetField('move_core_codigo',codigocoluna);
//      Sistema.SetField('move_transacao',transacao);
///      Sistema.SetField('move_operacao',FGeral.GetOperacao);
//      Sistema.SetField('move_numerodoc',numero);
//      Sistema.SetField('move_status','N');
//      Sistema.SetField('move_tipomov',TipoMovimento);
//      Sistema.SetField('move_unid_codigo',Global.CodigoUnidade);
      Sistema.SetField('move_tipo_codigo',Cliente.AsInteger);
      Sistema.SetField('move_tipocad','C');
      Sistema.SetField('move_repr_codigo',Representante);
      Sistema.SetField('move_qtde',Texttovalor(Grid.Cells[2,linha]));
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_venda',Texttovalor(Grid.Cells[3,linha]));
      Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.Post('move_status=''N'''+
          ' and move_numerodoc='+inttostr(Numero)+
          ' and move_esto_codigo='+Stringtosql(Grid.Cells[0,0])+
          ' and move_tipomov='+Stringtosql(TipoMovimento)+
          ' and move_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
          ' and move_tipo_codigo='+Stringtosql('C') );

*)

end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaMestreConsignacao(Emissao: TDatetime; Cliente:TSqlEd ;
  Representante: integer; Unidade, TipoMovimento, Transacao : string ; Numero: Integer ; Valortotal:currency ; Tabela:Integer ; OP:string='I' ; Magazine:string='N');
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
begin

  if Op='I' then begin
    Sistema.Insert('Movesto');
    Sistema.SetField('moes_transacao',Transacao);
    Sistema.SetField('moes_operacao',GetOperacao);
    Sistema.SetField('moes_status','N');
    Sistema.SetField('moes_numerodoc',Numero);
    Sistema.SetField('moes_tipomov',TipoMovimento);
    Sistema.SetField('moes_unid_codigo',Unidade);
    Sistema.SetField('moes_tipo_codigo',Cliente.AsInteger);
    if tipomovimento<>Global.CodManutencaoEquipamento then begin
//    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
      Sistema.SetField('moes_estado',Cliente.ResultFind.fieldbyname('clie_uf').AsString);
      Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
    end;
    Sistema.SetField('moes_repr_codigo',Representante);
    Sistema.SetField('moes_tipocad','C');
    Sistema.SetField('moes_datalcto',Sistema.Hoje);
    Sistema.SetField('moes_datamvto',Emissao);
    Sistema.SetField('moes_dataemissao',Emissao);
    Sistema.SetField('moes_vlrtotal',Valortotal);
    Sistema.SetField('moes_tabp_codigo',Tabela);
    Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('moes_rcmagazine',magazine);
    Sistema.Post;
  end else begin
    Sistema.Edit('Movesto');
//    Sistema.SetField('moes_numerodoc',Numero);
//    Sistema.SetField('moes_tipo_codigo',Cliente.AsInteger);
// 17.12.2012 - retirado da alteracao numero e cliente
//    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
    if tipomovimento<>Global.CodManutencaoEquipamento then begin
      Sistema.SetField('moes_estado',Cliente.ResultFind.fieldbyname('clie_uf').AsString);;
      Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
    end else
       Sistema.SetField('moes_tipo_codigo',Cliente.AsInteger);

    Sistema.SetField('moes_repr_codigo',Representante);
    Sistema.SetField('moes_tipocad','C');
//    Sistema.SetField('moes_datamvto',Emissao);
//    Sistema.SetField('moes_dataemissao',Emissao);
// 22.04.05 - para nao alterar a data da remessa na alteracao
    Sistema.SetField('moes_vlrtotal',Valortotal);
    Sistema.SetField('moes_tabp_codigo',Tabela);
    Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('moes_rcmagazine',magazine);
    Sistema.Post('moes_transacao='+stringtosql(transacao));
  end;
end;

////////////////////////////////////////////////////////////////////////////
function TFGeral.CodigoBarra(CodigoProduto: string ; Ed:TSqled=nil): boolean;
////////////////////////////////////////////////////////////////////////////
begin
  result:=( copy(CodigoProduto,1,3)='789' )
//          or (copy(CodigoProduto,1,5)='00000')  // 29.06.13 - vivan codigo 'com 900' no principal
           or ( (copy(CodigoProduto,1,3)='900') and (length(trim(CodigoProduto))>=12) )
// 27.08.11 - Vivan
           or (length(trim(CodigoProduto))>=12 );
  if not Global.Topicos[1217] then result:=false;
// 24.10.12
  if (Global.Topicos[1221]) and (Ed<>nil) then ed.Text:=copy(codigoproduto,1,12);
// 06.03.13 - Benato  - s� pra passar pelo edit do codigo e nao pesquisar pelo codigo de barra 'normal'
//  if (Global.Topicos[1217]) and ( copy(codigoproduto,1,1)='2' ) and ( length(trim(codigoProduto))=13 ) then
// 20.03.14 - Vivan
  if (Global.Topicos[1225]) and ( copy(codigoproduto,1,1)='2' ) and ( length(trim(codigoProduto))=13 ) then
    result:=false ;
// 15.05.14 - Devereda - codigo de barras com 8 digitos e come�ando por 789
  if ( copy(CodigoProduto,1,3)='789' ) and (length(trim(CodigoProduto))=8 ) then result:=true;
// 28.08.14 - Devereda - codigo de barras com 8 digitos e come�ando por 'qq coisa'
  if ( length(trim(CodigoProduto))>FGeral.GetConfig1asinteger('TAMESTOQUE') ) and
     ( FGeral.GetConfig1asinteger('TAMESTOQUE') > 0 ) and
     ( Global.Topicos[1217] ) and
     ( not Global.Usuario.OutrosAcessos[0338] )
     then result:=true;

end;

function TFGeral.Arredonda(valor: extended;decimais:integer): extended;
///////////////////////////////////////////////////////////////////////
var xtam:integer;
begin
  result:=simpleroundto(valor,(-1)*(decimais));
  if result>0 then begin
    xtam:=length(Valortosql(result));
    if copy(Valortosql(result),xtam,1)='5' then begin
       if copy(valortosql(result),xtam-3,1)=',' then result:=result+0.001
    end;
  end;

end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TFGeral.Buscaremessa(Numero: Integer ; Tipomov:string='' ; status:string='N' ; unidade:string='' ; emissao:TDatetime=0 ): String;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var xunidade,sqlemissaom,sqlemissaod:string;
begin
  if trim(tipomov)='' then tipomov:=Global.CodRemessaConsig;
  xunidade:=Global.CodigoUnidade;
  if trim(unidade)<>'' then  // 05.09.06
    xunidade:=unidade;
// 07.01.14
  if emissao>0 then begin
    sqlemissaom:=' and extract(year from moes_dataemissao)='+Inttostr( DatetoAno(emissao,true) );
    sqlemissaod:=' and extract(year from move_datamvto)='+Inttostr( DatetoAno(emissao,true) );
  end else begin
    sqlemissaom:='';
    sqlemissaod:='';
  end;
  result:='select movesto.*,movestoque.* from movesto,movestoque'+
          ' where moes_numerodoc='+inttostr(Numero)+
          ' and '+Fgeral.getin('moes_status',status,'C')+
          ' and '+FGeral.Getin('moes_tipomov',tipomov,'C')+
          ' and moes_numerodoc=move_numerodoc'+
          ' and '+FGeral.Getin('move_tipomov',tipomov,'C')+
          ' and '+Fgeral.getin('move_status',status,'C')+
          sqlemissaom+sqlemissaod+
// 07.01.2014
          ' and moes_dataemissao=move_datamvto'+
          ' and moes_unid_codigo='+stringtosql(xunidade)+
          ' and move_unid_codigo='+stringtosql(xunidade)+
          ' and '+FGeral.Getin('move_tipomov',tipomov,'C')+
          ' and substr(moes_transacao,1,1)<>''I'''+   // para n�o confundir com remessas ou devoluc�eos importadas
          ' and substr(moes_transacao,1,1)<>''N'''+   // para n�o confundir com remessas ou devoluc�eos importadas
          ' and substr(move_transacao,1,1)<>''I'''+   // para n�o confundir com remessas ou devoluc�eos importadas
          ' and substr(move_transacao,1,1)<>''N'''+   // para n�o confundir com remessas ou devoluc�eos importadas
          ' order by move_esto_codigo' ;
end;


procedure TFGeral.ReservaEstoque(Codigo,unidade,EntSai,TipoMovimento: string;Qtde:currency);
//////////////////////////////////////////////////////////////////////////////////////////
var QBusca:Tsqlquery;
begin
  QBusca:=Sqltoquery(BuscaQTdeItemEstoque(Codigo,Unidade));
  if not QBusca.Eof then begin
    MovimentaQtdeEstoque(Codigo,UNidade,Entsai,TipoMovimento,Qtde,QBusca);
  end else
    Avisoerro('Produto '+codigo+' n�o encontrado em estoqueqtde na unidade '+unidade+'.  NAO MOVIMENTADO');
end;

function TFGeral.BuscaQtdeItemEstoque(Codigo,Unidade: string): string;
//////////////////////////////////////////////////////////////////////
begin
//  result:='select * from EstoqueQtde QTDe where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Codigo)+
  result:='select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Codigo)+
          ' and esqt_unid_codigo='+Stringtosql(Unidade);

end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.MovimentaQtdeEstoque(Codigo,UNidade,EntSai,TipoMovimento : string ; Qtde : currency ; Q:TSqlquery ; Qtdeprev : currency=0 ; Pecas:currency=0 );
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var hora:string;
begin

// 16.10.09
    if pos( TipoMovimento,Global.TipoEstoqueEmProcesso ) > 0 then begin
      Sistema.Edit('EstoqueQtde');
      if EntSai='E' then begin
// 16.10.09 - movimenta estoque em processo  -
          Sistema.Setfield('esqt_qtdeprocesso',Q.fieldbyname('esqt_qtdeprocesso').ascurrency+QTde);
      end else begin
          Sistema.Setfield('esqt_qtdeprocesso',Q.fieldbyname('esqt_qtdeprocesso').ascurrency-QTde);
      end;
      Sistema.Post('esqt_esto_codigo='+stringtosql(codigo)+' and esqt_unid_codigo='+stringtosql(UNidade)+
                 ' and esqt_status=''N'''  );
      exit;
    end;
////////////////////////////////////////

// 07.12.04 - checa se o tipo de movimento mexe no estoque
    if pos( TipoMovimento,Global.TiposMovMovEstoque ) = 0 then exit;

//    sistema.beginprocess('Baixando estoque');
    if Qtdeprev=0 then QTdeprev:=Qtde;
    Sistema.Edit('EstoqueQtde');
    if EntSai='E' then begin
      if (TipoMovimento=Global.CodAcertoEsEnt) or (TipoMovimento=Global.CodAcertoEsSAi) or
// 20.04.12
         (TipoMovimento=Global.CodContagemBalancoE) or (TipoMovimento=Global.CodContagemBalancoS) then begin
        if Q.fieldbyname('esqt_qtdeprev').ascurrency<0 then
          Sistema.Setfield('esqt_qtdeprev',QTdeprev)
        else
          Sistema.Setfield('esqt_qtdeprev',Q.fieldbyname('esqt_qtdeprev').ascurrency+QTdeprev);
        if Q.fieldbyname('esqt_qtde').ascurrency<0 then
          Sistema.Setfield('esqt_qtde',QTde)
        else
          Sistema.Setfield('esqt_qtde',Q.fieldbyname('esqt_qtde').ascurrency+QTde);
        Sistema.Setfield('esqt_pecas',Q.fieldbyname('esqt_pecas').ascurrency+Pecas);
      end else begin
        Sistema.Setfield('esqt_qtde',Q.fieldbyname('esqt_qtde').ascurrency+QTde);
        Sistema.Setfield('esqt_qtdeprev',Q.fieldbyname('esqt_qtdeprev').ascurrency+QTdeprev);
        Sistema.Setfield('esqt_pecas',Q.fieldbyname('esqt_pecas').ascurrency+Pecas);
      end;
// 16.10.09 - movimenta estoque em processo  -
      if pos( TipoMovimento,Global.CodSaidaAlmox ) > 0 then
        Sistema.Setfield('esqt_qtdeprocesso',Q.fieldbyname('esqt_qtdeprocesso').ascurrency-QTde)
      else if pos( TipoMovimento,Global.CodSaidaprocesso ) > 0 then
        Sistema.Setfield('esqt_qtdeprocesso',Q.fieldbyname('esqt_qtdeprocesso').ascurrency+QTde);
    end else begin
      Sistema.Setfield('esqt_qtdeprev',Q.fieldbyname('esqt_qtdeprev').ascurrency-QTdeprev);
      Sistema.Setfield('esqt_qtde',Q.fieldbyname('esqt_qtde').ascurrency-QTde);
      Sistema.Setfield('esqt_pecas',Q.fieldbyname('esqt_pecas').ascurrency-Pecas);
// 16.10.09 - movimenta estoque em processo  -
      if pos( TipoMovimento,Global.CodSaidaAlmox ) > 0 then
        Sistema.Setfield('esqt_qtdeprocesso',Q.fieldbyname('esqt_qtdeprocesso').ascurrency+QTde)
      else if pos( TipoMovimento,Global.CodSaidaprocesso ) > 0 then
        Sistema.Setfield('esqt_qtdeprocesso',Q.fieldbyname('esqt_qtdeprocesso').ascurrency-QTde);
    end;
//////////////////////////
    Sistema.Post('esqt_esto_codigo='+stringtosql(codigo)+' and esqt_unid_codigo='+stringtosql(UNidade)+
                 ' and esqt_status=''N'''  );
// 02.05.2012 - no cancelamento de transacao - 'affects more than on record'
{
// 09.04.12
/////////////////
   if not Arq.TEstoqueqtde.Active then Arq.TEstoqueqtde.open ;
   if Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([Unidade,codigo]),[]) then begin
     Arq.TEstoqueqtde.Edit;
     if EntSai='E' then begin
        if (TipoMovimento=Global.CodAcertoEsEnt) or (TipoMovimento=Global.CodAcertoEsSAi) or
// 20.04.12
         (TipoMovimento=Global.CodContagemBalancoE) or (TipoMovimento=Global.CodContagemBalancoS) then begin
          if Q.fieldbyname('esqt_qtdeprev').ascurrency<0 then
//            Sistema.Setfield('esqt_qtdeprev',QTdeprev)
            Arq.TEstoqueqtde.FieldByName('esqt_qtdeprev').AsCurrency:=Qtdeprev
          else
//            Sistema.Setfield('esqt_qtdeprev',Q.fieldbyname('esqt_qtdeprev').ascurrency+QTdeprev);
            Arq.TEstoqueqtde.FieldByName('esqt_qtdeprev').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_qtdeprev').AsCurrency+Qtdeprev;
          if Q.fieldbyname('esqt_qtde').ascurrency<0 then
//            Sistema.Setfield('esqt_qtde',QTde)
            Arq.TEstoqueqtde.FieldByName('esqt_qtde').AsCurrency:=Qtde
          else
//            Sistema.Setfield('esqt_qtde',Q.fieldbyname('esqt_qtde').ascurrency+QTde);
            Arq.TEstoqueqtde.FieldByName('esqt_qtde').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_qtde').AsCurrency+Qtde;
//          Sistema.Setfield('esqt_pecas',Q.fieldbyname('esqt_pecas').ascurrency+Pecas);
          Arq.TEstoqueqtde.FieldByName('esqt_pecas').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_pecas').AsCurrency+Pecas;
        end else begin
//          Sistema.Setfield('esqt_qtde',Q.fieldbyname('esqt_qtde').ascurrency+QTde);
//          Sistema.Setfield('esqt_qtdeprev',Q.fieldbyname('esqt_qtdeprev').ascurrency+QTdeprev);
//          Sistema.Setfield('esqt_pecas',Q.fieldbyname('esqt_pecas').ascurrency+Pecas);
          Arq.TEstoqueqtde.FieldByName('esqt_qtde').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_qtde').AsCurrency+Qtde;
          Arq.TEstoqueqtde.FieldByName('esqt_qtdeprev').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_qtdeprev').AsCurrency+Qtdeprev;
          Arq.TEstoqueqtde.FieldByName('esqt_pecas').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_pecas').AsCurrency+Pecas;
        end;
  // 16.10.09 - movimenta estoque em processo  -
        if pos( TipoMovimento,Global.CodSaidaAlmox ) > 0 then
//          Sistema.Setfield('esqt_qtdeprocesso',Q.fieldbyname('esqt_qtdeprocesso').ascurrency-QTde)
          Arq.TEstoqueqtde.FieldByName('esqt_qtdeprocesso').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_qtdeprocesso').AsCurrency-QTde
        else if pos( TipoMovimento,Global.CodSaidaprocesso ) > 0 then
//          Sistema.Setfield('esqt_qtdeprocesso',Q.fieldbyname('esqt_qtdeprocesso').ascurrency+QTde);
          Arq.TEstoqueqtde.FieldByName('esqt_qtdeprocesso').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_qtdeprocesso').AsCurrency+QTde;
      end else begin
//        Sistema.Setfield('esqt_qtdeprev',Q.fieldbyname('esqt_qtdeprev').ascurrency-QTdeprev);
//        Sistema.Setfield('esqt_qtde',Q.fieldbyname('esqt_qtde').ascurrency-QTde);
//        Sistema.Setfield('esqt_pecas',Q.fieldbyname('esqt_pecas').ascurrency-Pecas);
        Arq.TEstoqueqtde.FieldByName('esqt_qtde').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_qtde').AsCurrency-Qtde;
        Arq.TEstoqueqtde.FieldByName('esqt_qtdeprev').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_qtdeprev').AsCurrency-Qtdeprev;
        Arq.TEstoqueqtde.FieldByName('esqt_pecas').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_pecas').AsCurrency-Pecas;
        if pos( TipoMovimento,Global.CodSaidaAlmox ) > 0 then
//          Sistema.Setfield('esqt_qtdeprocesso',Q.fieldbyname('esqt_qtdeprocesso').ascurrency+QTde)
          Arq.TEstoqueqtde.FieldByName('esqt_qtdeprocesso').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_qtdeprocesso').AsCurrency+QTde
        else if pos( TipoMovimento,Global.CodSaidaprocesso ) > 0 then
//          Sistema.Setfield('esqt_qtdeprocesso',Q.fieldbyname('esqt_qtdeprocesso').ascurrency-QTde);
          Arq.TEstoqueqtde.FieldByName('esqt_qtdeprocesso').AsCurrency:=Arq.TEstoqueqtde.FieldByName('esqt_qtdeprocesso').AsCurrency-QTde;
     end;
     Arq.TEstoqueqtde.Post;
     Arq.TEstoqueqtde.Commit;
   end;
}

// 12.04.05
/////////////////////////////////////
//   if Global.Topicos[1501] then begin
// inibido em 28.11.05
/////////////////////////////////////
//    sistema.endprocess('');

end;

function TFGeral.Centra(texto:string;largura:integer):string;
var tam,col:integer;
begin
  result:=space(1);
  if (trim(texto) <> '') and (largura>0) then begin
    tam:=length(trim(texto));
    col:=(largura-tam) div 2;
    result:=space(col)+Texto;
  end;
end;

function TFGeral.Formatatelefone(telefone:string):string;
begin
  if trim(telefone)='' then
    Result:=''
  else if copy(telefone,1,1)='0' then
    Result:=Trans(telefone,'(###)####-####')
  else if copy(telefone,3,1)=' ' then
    Result:=Trans(telefone,'(###)####-####')
  else
    Result:=Trans(telefone,'(##)####-####');
end;

function TFGeral.Formatacep(cep:string):string;
begin
  Result:=Trans(cep,'#####-###')
end;

function TFGeral.Formatacnpj(cnpj:string):string;
begin
  Result:=Trans(cnpj,'##.###.###/####-##')
end;

function TFGeral.Formatacpf(cpf:string):string;
begin
  Result:=Trans(cpf,'###.###.###-##')
end;


function TFGeral.Formatavalor(valor: currency; mascara:string ; tam:integer=0 ): string;
////////////////////////////////////////////////////////////////////////////////////////////
begin
  if tam=0 then
    tam:=length(mascara);  // 08.05.07
  result:=spacestr(formatfloat(mascara,valor),tam);
end;

{
function TFGeral.GetTipoMovto(tipomovto: string ; reduzido:boolean=false): string;
begin
end;
}

{
function TFGeral.GetEntSaiTipoMovto(tipomovto: string): string;
begin
end;
}

///////////////////////////////////////////////////////////////////////////////////////
function TFGeral.EstoqueAnterior(produto,unidade: string;
  DataInicial: TDatetime ;  var salantpecas:currency ;cor:integer=0;tamanho:integer=0;copa:integer=0 ): currency;
///////////////////////////////////////////////////////////////////////////////////////
var QBusca:TSqlquery;
    saldo:currency;
    mesano,sqltamanho,sqlcor,sqlcopa:string;
    mes,ano:integer;
begin
  mes:=Datetomes(DataInicial);
  ano:=Datetoano(Datainicial,true);
  if mes=1 then begin
    mes:=12;
    dec(ano);
  end else
    dec(mes);
  mesano:=inttostr(ano)+strzero(mes,2);
// 12.09.06
  if tamanho>0 then
    sqltamanho:=' and saes_tama_codigo='+inttostr(tamanho)
  else
//    sqltamanho:=' and ( saes_tama_codigo=0 or saes_tama_codigo is null )';
    sqltamanho:='';
  if cor>0 then
    sqlcor:=' and saes_core_codigo='+inttostr(cor)
  else
    sqlcor:='';
  if copa>0 then
    sqlcopa:=' and saes_copa_codigo='+inttostr(cor)
  else
//    sqlcopa:=' and ( saes_copa_codigo=0 or saes_copa_codigo is null )';
    sqlcopa:='';
{
  QBusca:=sqltoquery('select * from salestoque where saes_status=''N'' and saes_mesano='+stringtosql(mesano)+
                     ' and saes_unid_codigo='+stringtosql(unidade)+' and saes_esto_codigo='+stringtosql(produto)+
                     sqlcor+sqltamanho+sqlcopa);
}
// 25.06.15
  QBusca:=sqltoquery('select sum(saes_qtde) as saes_qtde,sum(saes_qtdeprev) as saes_qtdeprev,sum(saes_pecas) as saes_pecas from salestoque where saes_status=''N'' and saes_mesano='+stringtosql(mesano)+
                     ' and saes_unid_codigo='+stringtosql(unidade)+' and saes_esto_codigo='+stringtosql(produto)+
                     sqlcor+sqltamanho+sqlcopa);
  saldo:=0;
  if not QBusca.Eof then begin
    saldo:=FGeral.QualQtde(Global.Usuario.Codigo,QBusca.fieldbyname('saes_qtde').AsCurrency,QBusca.fieldbyname('saes_qtdeprev').AsCurrency);
    salantpecas:=QBusca.fieldbyname('saes_pecas').AsCurrency;
  end;
  QBusca.Close;
  Freeandnil(QBusca);
  result:=saldo;
end;


function TFGeral.PosicaoEstoqueAnterior(produto:string;tamanho,cor,copa:integer;unidade: string; DataInicial: TDatetime;Q:TSqlquery=nil):TSqlquery;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
var mesano,sqltamanho,sqlcor,sqlcopa:string;
    mes,ano:integer;
begin
  mes:=Datetomes(DataInicial);
  ano:=Datetoano(Datainicial,true);
/////////////////////////
{
  if mes=1 then begin
    mes:=12;
    dec(ano);
  end else
    dec(mes);
}
//////////////////////////////////
  mesano:=inttostr(ano)+strzero(mes,2);
  if tamanho>0 then
    sqltamanho:=' and saes_tama_codigo='+inttostr(tamanho)
  else
    sqltamanho:='';
  if cor>0 then
    sqlcor:=' and saes_core_codigo='+inttostr(cor)
  else
    sqlcor:='';
  if copa>0 then
    sqlcopa:=' and saes_copa_codigo='+inttostr(cor)
  else
    sqlcopa:=' and ( saes_copa_codigo=0 or saes_copa_codigo is null )';

  if Q<>nil then begin
    Q.sql.text:='select * from salestoque where saes_status=''N'' and saes_mesano='+stringtosql(mesano)+
                  ' and saes_unid_codigo='+stringtosql(unidade)+
                  sqltamanho+sqlcor+sqlcopa+
                  ' and saes_esto_codigo='+stringtosql(produto) ;
    Q.open;
    result:=Q;
  end;
//  end else begin
//    Arq.TSalestoque.First;
//    Arq.TSalEstoque.Locate('saes_mesano;saes_unid_codigo;saes_esto_codigo',Vararrayof([mesano,unidade,produto]),[]);
//    result:='';
//  end;

end;


//////////////////////////////////////////////////////////////////////////////////
function TFGeral.ProcuraGrid(coluna: integer; busca: string; Grid: TSqlDtGrid ; colunatam:integer=0; tam:integer=0 ;
         colunacor:integer=0  ; cor:integer=0 ; colunacopa:integer=0 ; copa:integer=0 ): integer;
//////////////////////////////////////////////////////////////////////////////////
var x:integer;
begin
  result:=0;
//  if (colunatam>0) and (colunacor>0) then begin
// 16.08.06
  if (tam>0) and (cor>0) then begin
    if copa=0 then begin
      for x:=1 to Grid.RowCount do begin
        if trim(Grid.Cells[coluna,x])<>'' then
           if ( trim(Grid.Cells[coluna,x])=trim(busca) ) and ( trim(Grid.Cells[colunatam,x])=trim(inttostr(tam)) )
             and ( trim(Grid.Cells[colunacor,x])=trim(inttostr(cor)) ) then begin
             result:=x;
             break;
           end;
      end;
    end else begin
      for x:=1 to Grid.RowCount do begin
        if trim(Grid.Cells[coluna,x])<>'' then
           if (trim(Grid.Cells[coluna,x])=trim(busca)) and (trim(Grid.Cells[colunatam,x])=trim(inttostr(tam)))
               and (texttovalor(Grid.Cells[colunacor,x])=cor )
               and (texttovalor(Grid.Cells[colunacopa,x])=copa )
               then begin
             result:=x;
             break;
           end;
      end;
    end;
  end else if cor>0 then begin  // caso usar somente a cor
      for x:=1 to Grid.RowCount do begin
        if trim(Grid.Cells[coluna,x])<>'' then
           if (trim(Grid.Cells[coluna,x])=trim(busca)) and (trim(Grid.Cells[colunacor,x])=trim(inttostr(cor)))
             and ( texttovalor(Grid.Cells[colunacor,x])=cor )
             and ( texttovalor(Grid.Cells[colunatam,x])=0 )
             and ( texttovalor(Grid.Cells[colunacopa,x])=0 )
             then begin
             result:=x;
             break;
           end;
      end;

//  end else if (colunacor>0) or (colunatam>0) then begin
// 28.08.06
  end else if (cor>0) or (tam>0) then begin

    for x:=1 to Grid.RowCount do begin
      if trim(Grid.Cells[coluna,x])<>'' then
         if ( trim(Grid.Cells[coluna,x])=trim(busca) )
           and ( texttovalor(Grid.Cells[colunacor,x])=0 )
           and ( texttovalor(Grid.Cells[colunatam,x])=0 )
           and ( texttovalor(Grid.Cells[colunacopa,x])=0 )
           then begin
           result:=x;
           break;
         end;
    end;
// 24.08.06
  end else begin

    for x:=1 to Grid.RowCount do begin
      if trim(Grid.Cells[coluna,x])<>'' then
         if ( trim(Grid.Cells[coluna,x])=trim(busca) ) then begin
           result:=x;
           break;
         end;
    end;

  end;
end;


////////////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaRetornoConsignacao(Emissao: TDatetime;
  Cliente: TSqlEd; Representante: integer; Unidade, TipoMovimento,
  Transacao: string; Numero: Integer; Valortotal: currency;
  Grid:TSqlDtGrid ;   QProdRemessa : TMemoryQuery ; QProdDevolvido:TMemoryQuery; Remessas : string  ; Condicao : String ; Movimento : TDatetime ; Percdesconto,vlrdesconto:currency;
  GridParcelas:TSqlDtGrid=nil ; Totalnf:currency=0  ; Marcoutudo:boolean=false ; Portador:string='' ;
  GravaECF:boolean=false ; TotalProdutos:currency=0 ;  ValorAntecipa:currency=0 ; GridParcelas01:TSqlDtGrid=nil ;
  xPortador01:string='' ; GridParcelas02:TSqlDtGrid=nil ; xPortador02:string='' );
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

type TLista=record
    produto:string;
    codcor,codtamanho,codcopa:currency;
    qtdeenviada,qtdedevolvida:currency;
end;

var linha,codigograde,codigolinha,codigocoluna,numeronf,nremessas,p,nparcelas,n,tam,parcelaini,nrodevolucao,nitens,x,k:integer;
    TEstoqueQtde,QUnidade,TSittributaria,QChecaProdutoDevolucoes:TSqlquery;
    qtderetatu,qtde,venda,ValorContabil,Base,TotalBaseicms,reducao,isentas,outras,valorparcela,acumulado,
    icmsitem,totalitem,basesubs,icmssubs,perdescorateio,totalit,margemlucro,TotalBaseicmsSubs,
    valoricms,valoricmssubs,aliicms,xtotalnf:currency;
    codigoestoque,devolucoessemremessas,sqldevosemm,sqldevosemd,devolucoes,mensagemfixa,simples,vcsenha:string;
    ListaPrazos,ListaRemessas,ListaDevolSemRemessas,ListaDevolucoes,ListaProdutosDevolSemRemessas:TStringlist;
    ListaCores:TList;
    PLista:^TLista;
    TConfMovimento,TEstoque:TSqlquery;
    ListaMensagem:TStringList;

    procedure GravaMovFinanceiro(valorparcela:currency);  // caso for a vista
    //////////////////////////////////////////////////////////
    begin
      Arq.TPlano.locate('plan_conta',Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger,[]);
      Sistema.Insert('Movfin');
      Sistema.Setfield('movf_transacao',transacao);
      Sistema.Setfield('movf_operacao',FGeral.Getoperacao);
      Sistema.Setfield('movf_status','N');
      Sistema.Setfield('movf_unid_codigo',Unidade);
      Sistema.Setfield('movf_datalcto',Sistema.HOje);
      Sistema.SetField('movf_DataCont',Movimento);
      Sistema.Setfield('movf_datamvto',Emissao);
      Sistema.Setfield('movf_dataprevista',Emissao);
//      Sistema.Setfield('movf_dataextrato' date,
      Sistema.Setfield('movf_plan_conta',Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger);
      Arq.TPlano.locate('plan_conta',Arq.TUnidades.fieldbyname('unid_contacontabil').asstring,[]);
      Sistema.Setfield('movf_hist_codigo',Arq.TPlano.fieldbyname('plan_codhist').asinteger);
//      Sistema.Setfield('movf_complemento','Venda a vista '+cliente.text+' '+FGeral.GetNomeRazaoSocialEntidade(cliente.asinteger,'C','R'));
// 02.09.05
      Sistema.Setfield('movf_complemento','Venda a vista nf '+inttostr(Numeronf)+' '+FGeral.GetNomeRazaoSocialEntidade(cliente.asinteger,'C','R'));
//      Sistema.Setfield('movf_numerodcto',inttostr(Numero));
      Sistema.Setfield('movf_numerodcto',inttostr(Numeronf));
//      Sistema.Setfield('movf_codb_codigo', varchar(3),
      Sistema.Setfield('movf_es','E');
//      Sistema.Setfield('movf_favorecido varchar(100),
//      Sistema.Setfield('movf_numerocheque numeric(8, 0),
      Sistema.Setfield('movf_valorger',valorparcela);
      Sistema.Setfield('movf_valorbco',valorparcela);
// 16.02.05
      Sistema.Setfield('movf_tipomov',global.CodVendaConsig);
// 12.04.05
      Sistema.Setfield('movf_plan_contard',Global.CodContaVendaaVista);
// 01.08.05
      Sistema.Setfield('movf_usua_codigo',Global.Usuario.Codigo);
// 09.03.05
//      Sistema.Setfield('movf_transconc varchar(12),
//      Sistema.Setfield('movf_seqlcto numeric(5, 0)
      Sistema.Post;
    end;


begin
////////////////////////////////////////////////////////////////

//    TipoMovimento ser� usado para ver se gera nf de venda consignada

    if not Arq.TEstoque.Active then Arq.TEstoque.Open;
    if not Arq.TEstoqueQtde.Active then Arq.TEstoqueQTde.Open;
// 31.08.06
    ListaCores:=TList.create;

//    if ValorTotal>0 then begin
// 15.03.05
//    if Grid.rowcount>1 then begin
// 08.04.05
    if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),1])<>'' then begin
// grava o mestre do produtos q foram digitados no retorno de consigna��o
      Sistema.beginprocess('Gravando mestre da devolu��o');
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacao);
      Sistema.SetField('moes_operacao',GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',Numero);
      if TipoMovimento=Global.CodDevolucaoTroca then
        Sistema.SetField('moes_tipomov',Global.CodDevolucaoTroca)
      else
        Sistema.SetField('moes_tipomov',Global.CodDevolucaoConsig);
      Sistema.SetField('moes_unid_codigo',Unidade);
      Sistema.SetField('moes_tipo_codigo',Cliente.AsInteger);
  //    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
      Sistema.SetField('moes_repr_codigo',Representante);
      Sistema.SetField('moes_tipocad','C');
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',Emissao);
      Sistema.SetField('moes_dataemissao',Emissao);
      Sistema.SetField('moes_DataCont',Movimento);
      Sistema.SetField('moes_vlrtotal',Valortotal);
      Sistema.SetField('moes_remessas',Remessas);
      Sistema.SetField('moes_estado',Cliente.Resultfind.fieldbyname('clie_uf').asstring);
  //    Sistema.SetField('moes_tabp_codigo',Tabela);
  //    Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
// 29.09.10 - colocar o transportador caso quiser fazer NFe
      Sistema.SetField('moes_tran_codigo','001');  // 29.09.10

      Sistema.Post();
    end;   // valortotal ( de retorno ) > 0
// grava o detalhe dos produtos q foram digitados no retorno de consigna��o
  Sistema.beginprocess('Gravando detalhe da devolu��o');
  for linha:=1 to Grid.rowcount do begin
    if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha])<>'' then begin
//      if Arq.TEstoque.Locate('esto_codigo',Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],[]) then begin
// 24.02.16
// 24.02.16
      TEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha]) );
      if not TEstoque.eof then begin
//        codigograde:=FEstoque.GetCodigoGrade(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]);
//        Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([Unidade,Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]]),[]);
        TEstoqueqtde:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                  ' and esqt_unid_codigo='+Stringtosql(Unidade));

        Sistema.Insert('Movestoque');
        Sistema.SetField('move_esto_codigo',Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]);
{
        codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],codigograde);
        codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],codigograde);
        if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
          Sistema.SetField('move_tama_codigo',codigolinha)
        else
          Sistema.SetField('move_core_codigo',codigolinha);
        if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
          Sistema.SetField('move_tama_codigo',codigocoluna)
        else
          Sistema.SetField('move_core_codigo',codigocoluna);
}
// 30.08.06
        Sistema.SetField('move_tama_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codtamanho'),linha],0 ) );
        Sistema.SetField('move_core_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcor'),linha],0 ) );
        Sistema.SetField('move_copa_codigo',strtointdef( Grid.Cells[Grid.getcolumn('codcopa'),linha],0 ) );
// 31.08.06
        FGeral.apuravenda(Listacores,Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],texttovalor( Grid.Cells[Grid.getcolumn('codcor'),linha] ),
                              texttovalor( Grid.Cells[Grid.getcolumn('codtamanho'),linha] ),texttovalor( Grid.Cells[Grid.getcolumn('codcopa'),linha] ),
                              Texttovalor(Grid.Cells[grid.GetColumn('move_qtde'),linha]),Global.CodDevolucaoConsig);

        Sistema.SetField('move_transacao',transacao);
        Sistema.SetField('move_operacao',FGeral.GetOperacao);
        Sistema.SetField('move_numerodoc',numero);
        Sistema.SetField('move_status','N');
        if TipoMovimento=Global.CodDevolucaoTroca then
          Sistema.SetField('move_tipomov',Global.CodDevolucaoTroca)
        else
          Sistema.SetField('move_tipomov',Global.CodDevolucaoConsig);
//        Sistema.SetField('move_tipomov',Global.CodDevolucaoConsig);
        Sistema.SetField('move_unid_codigo',Unidade);
        Sistema.SetField('move_tipo_codigo',Cliente.AsInteger);
        Sistema.SetField('move_tipocad','C');
        Sistema.SetField('move_repr_codigo',Representante);
        Sistema.SetField('move_qtde',Texttovalor(Grid.Cells[grid.GetColumn('move_qtde'),linha]));
        Sistema.SetField('move_datalcto',Sistema.Hoje);
        Sistema.SetField('move_datamvto',Emissao);
        Sistema.SetField('move_qtderetorno',0);
        Sistema.SetField('move_venda',Texttovalor(Grid.Cells[grid.GetColumn('move_venda'),linha]));
        Sistema.SetField('move_grup_codigo',TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
        Sistema.SetField('move_sugr_codigo',TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
        Sistema.SetField('move_fami_codigo',TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
        Sistema.SetField('move_remessas',Remessas);
        Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
        Sistema.SetField('move_vendabru',Texttovalor(Grid.Cells[grid.GetColumn('move_venda'),linha]));
        Sistema.SetField('move_perdesco',0);
// 15.02.05
        Sistema.SetField('move_DataCont',Movimento);
// 31.01.06
        Sistema.SetField('move_custo',TEstoqueqtde.fieldbyname('esqt_custo').ascurrency);
        Sistema.SetField('move_custoger',TEstoqueqtde.fieldbyname('esqt_custoger').ascurrency);
        Sistema.SetField('move_customedio',TEstoqueqtde.fieldbyname('esqt_customedio').ascurrency);
        Sistema.SetField('move_customeger',TEstoqueqtde.fieldbyname('esqt_customeger').ascurrency);
///////////////////////////
        Sistema.Post('');

// devolver ao estoque o q voltou
        FGeral.MovimentaQtdeEstoque(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],Unidade,'E',Global.CodDevolucaoConsig,Texttovalor(Grid.Cells[grid.GetColumn('move_qtde'),linha]),TEstoqueqtde );
        TEstoqueqtde.Close;
        Freeandnil(TEstoqueqtde);
      end else begin    // if se encontrou no estoque
        aviso('Codigo '+Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]+' n�o encontrado no estoque');
      end;
    end;
  end;   // ref. ao grid

////////////////////////////////////////////////
// se for o caso gerar nf venda com a diferenca
////////////////////////////////////////////////
  ListaDevolucoes:=TStringlist.create;
  devolucoes:='';
// 04.11.13
  xtotalnf:=totalnf;
// 04.06.2012 - zerado e recalculado aqui pra evitar 'cagadex' de ficar maior que a soma dos itens
  totalnf:=0;totalprodutos:=0;
  if TipoMovimento=Global.CodVendaConsig then begin
      if not Arq.TEstoque.Active then Arq.TEstoque.Open;
      if not Arq.TEstoqueQtde.Active then Arq.TEstoqueQtde.Open;
//      if not Arq.TConfMovimento.Active then Arq.TConfMovimento.Open;
      if not Arq.TUnidades.Active then Arq.TUnidades.Open;
      if not Arq.TPlano.Active then Arq.TPlano.Open;
      Arq.TUnidades.Locate('unid_codigo',Unidade,[]);

// 10.08.10
      TConfMovimento:=sqltoquery('select * from confmov where comv_codigo='+inttostr(Global.VCConfMov));
// 08.07.11
      if GravaEcf then begin
        TConfMovimento.close;
//        TConfMovimento:=sqltoquery('select * from confmov where comv_codigo='+inttostr( FGeral.GetConfig1AsInteger('ConfMovECF') ) );
// 31.03.14 - outra config. para ecf especifico para VC
//        TConfMovimento:=sqltoquery('select * from confmov where comv_codigo='+inttostr( FGeral.GetConfig1AsInteger('ConfMovECFVC') ) );
// 31.08.15 - vivan
        TConfMovimento:=sqltoquery('select * from confmov where comv_codigo='+inttostr( FGeral.GetConfig1AsInteger('ConfMovNFCeVC') ) );

      end;
//////////////////////// - colocado mais abaixo em 01.06.11 - VC pulava numeracao
// uma hipotese era acerto 'sem Vc' , isto � ,devolveu tudo
// ver aqui 'so pegar o numero' e depois atualizar
      if movimento>1 then begin
//        Numeronf:=FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+FGeral.Qualserie(TConfMovimento.fieldbyname('comv_serie').asstring,Global.serieunidade),false);
// 01.06.11
        if GravaEcf then begin
          Numeronf:=FGeral.GetContador('NFSAIDAECF'+Global.CodigoUnidade+TConfMovimento.fieldbyname('comv_serie').asstring,false,false)+1;
// 31.08.15 - nfc-e
          Numeronf:=FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+TConfMovimento.fieldbyname('comv_serie').asstring,false,false)+1;
        end else
          Numeronf:=FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+FGeral.Qualserie(TConfMovimento.fieldbyname('comv_serie').asstring,Global.serieunidade),false,false)+1;
// 18.08.06 -
        FGeral.Checacontador(numeronf-1,FGeral.Qualserie(TConfMovimento.fieldbyname('comv_serie').asstring,Global.serieunidade),sistema.hoje);
      end else
//        Numeronf:=FGeral.GetContador('SAIDA'+Global.CodigoUnidade+TConfMovimento.fieldbyname('comv_serie').asstring,false);
        Numeronf:=FGeral.GetContador('SAIDA'+Global.CodigoUnidade+TConfMovimento.fieldbyname('comv_serie').asstring,false,false)+1;

////////////////////////

// 29.06.06 - aqui em 09.05.11 pra poder ver se � do simples naciona dai muda cst
////////////////
        mensagemfixa:='';
        simples:='N';
        QUnidade:=sqltoquery('select unid_simples,unid_uf from unidades where unid_codigo='+stringtosql(unidade));
        if not QUnidade.eof then begin
          simples:=QUnidade.fieldbyname('unid_simples').asstring;
          if (FGeral.getconfig1asinteger('MENSSIMPRS')>0)  and (Movimento>1)then begin
            if (QUnidade.fieldbyname('unid_simples').asstring='S') and (QUnidade.fieldbyname('unid_uf').asstring='RS') then
              mensagemfixa:=FMensNotas.GetDescricao( FGeral.getconfig1asInteger('MENSSIMPRS') )+' '  ;
          end else if (QUnidade.fieldbyname('unid_simples').asstring='S') then // 18.05.11
              mensagemfixa:=FMensNotas.GetDescricao( FGeral.getconfig1asInteger('CODMENVEN') )+' '  ;
        end;
        FGeral.Fechaquery(QUnidade);

      QProdRemessa.First;
      TotalBaseicms:=0;ValorTotal:=0;
      TotalBaseicmsSubs:=0;valoricms:=0;valoricmssubs:=0;
      ListaCstPerc:=TList.Create;
      ListaDevolSemRemessas:=TStringlist.create;
      ListaProdutosDevolSemRemessas:=TStringList.create;
      nitens:=0;   // 01.06.05

      while not QProdRemessa.eof do begin   // tem o q foi enviado
        venda:=0;
        codigoestoque:=QProdremessa.fieldbyname('move_esto_codigo').asstring;
        Arq.TEstoque.Locate('esto_codigo',codigoestoque,[]);

//        Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([Unidade,codigoestoque]),[]);
        TEstoqueqtde:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(codigoestoque)+
                  ' and esqt_unid_codigo='+Stringtosql(Unidade));

        qtde:=0;nremessas:=0;

//        Sistema.beginprocess('Gravando nota fiscal item '+QProdremessa.fieldbyname('move_esto_codigo').asstring);
        while (not QProdRemessa.eof) and (codigoestoque=QProdremessa.fieldbyname('move_esto_codigo').asstring) do begin   // tem o q foi enviado
// colocado esta checagem em 12.11.04
          if FGeral.Estaemaberto(QProdRemessa.fieldbyname('moes_numerodoc').AsString,Remessas) then begin
            qtde:=qtde+QProdRemessa.fieldbyname('move_qtde').asfloat;
            venda:=venda+QProdRemessa.fieldbyname('move_venda').asfloat;
            FGeral.apuravenda(Listacores,QProdRemessa.fieldbyname('move_esto_codigo').asstring,QProdRemessa.fieldbyname('move_core_codigo').asfloat,
                              QProdRemessa.fieldbyname('move_tama_codigo').asfloat,QProdRemessa.fieldbyname('move_copa_codigo').asfloat,
                              QProdRemessa.fieldbyname('move_qtde').asfloat,QProdRemessa.fieldbyname('move_tipomov').asstring);
            inc(nremessas);
          end;
          QProdRemessa.Next;
        end;
// preco medio da venda...
///////////////////////////
        if nremessas>0 then
          venda:=FGeral.arredonda(venda/nremessas,2)
        else
          venda:=0;

        linha:=FGeral.ProcuraGrid(Grid.GetColumn('move_esto_codigo'),codigoestoque,Grid);
        if linha>0 then begin
//          qtde:=qtde-texttovalor(Grid.cells[grid.GetColumn('move_qtde'),linha]);
          ListaDevolucoes.Add( inttostr(numero) );
          devolucoes:=devolucoes+strzero(numero,8)+';';
        end;
// 01.09.06 - para somar a qtde de todas as variacoes da grade
////////////////////////////////////////////////////
        for k:=1 to Grid.rowcount do begin
          if ( Grid.Cells[Grid.GetColumn('move_esto_codigo'),k]=codigoestoque ) and
             ( trim(Grid.Cells[Grid.GetColumn('move_esto_codigo'),k])<>'' )
              then begin
             qtde:=qtde-texttovalor(Grid.cells[grid.GetColumn('move_qtde'),k]);
          end;
        end;

        QProdDevolvido.First;
        nrodevolucao:=0;
        while (not QProdDevolvido.eof)  do begin   // tem o q foi devolvido
          nrodevolucao:=strtoint(QProdDevolvido.fieldbyname('move_numerodoc').asstring);
// rever o asinteger com leandro
          if (codigoestoque=QProdDevolvido.fieldbyname('move_esto_codigo').asstring) then begin
// 14.03.05
//            if (QProdDevolvido.fieldbyname('move_remessas').AsString=EdRemessas.text) and
// 17.11.04
            if FGeral.estaemaberto(QProdDevolvido.fieldbyname('move_remessas').AsString,Remessas) then begin
// 26.01.05 - retirado para ver se este � o problema da nf com vlr dif. do edit no ret. consig.
//               (QProdDevolvido.fieldbyname('move_remessas').AsString<>'') then
              qtde:=qtde-QProdDevolvido.fieldbyname('move_qtde').asfloat;
// 31.08.06
              FGeral.apuravenda(Listacores,QProdDevolvido.fieldbyname('move_esto_codigo').asstring,QProdDevolvido.fieldbyname('move_core_codigo').asfloat,
                              QProdDevolvido.fieldbyname('move_tama_codigo').asfloat,QProdDevolvido.fieldbyname('move_copa_codigo').asfloat,
                              QProdDevolvido.fieldbyname('move_qtde').asfloat,QProdDevolvido.fieldbyname('move_tipomov').asstring);
              if ListaDevolucoes.indexof(QProdDevolvido.fieldbyname('move_numerodoc').AsString)=-1 then begin
                ListaDevolucoes.Add(QProdDevolvido.fieldbyname('move_numerodoc').AsString);
                devolucoes:=devolucoes+strzero(strtoint(QProdDevolvido.fieldbyname('move_numerodoc').asstring),8)+';';
              end;
            end;
          end else begin
// 27.06.13
            if ListaProdutosDevolSemRemessas.indexof(QProdDevolvido.fieldbyname('move_esto_codigo').asstring)=-1 then
               ListaProdutosDevolSemRemessas.add(QProdDevolvido.fieldbyname('move_esto_codigo').asstring);
          end;
          QProdDevolvido.Next;
        end;

        if qtde>0 then begin
// 31.08.06 - grava��o separando pela grade...gravar somente um codigo e suas 'deriva��es' por vez...
          if FGeral.UsuarioTesteGrade(Global.Usuario.codigo) then begin
            for x:=0 to ListaCores.count-1 do begin
              aliicms:=FEstoque.Getaliquotaicms(codigoestoque,unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring,Cliente.asinteger);
              PLista:=ListaCores[x];
              if PLista.produto=codigoestoque then begin
                if Plista.qtdeenviada-PLista.qtdedevolvida>0 then begin
                  Sistema.Insert('Movestoque');
                  Sistema.SetField('move_esto_codigo',codigoestoque);
                  Sistema.SetField('move_tama_codigo',PLista.codtamanho);
                  Sistema.SetField('move_core_codigo',PLista.codcor);
                  Sistema.SetField('move_copa_codigo',PLista.codcopa);
                  Sistema.SetField('move_transacao',transacao);
                  Sistema.SetField('move_operacao',FGeral.GetOperacao);
                  Sistema.SetField('move_numerodoc',numeronf);
                  Sistema.SetField('move_status','N');
                  Sistema.SetField('move_tipomov',Global.CodVendaConsig);
                  Sistema.SetField('move_unid_codigo',Unidade);
                  Sistema.SetField('move_tipo_codigo',Cliente.AsInteger);
                  Sistema.SetField('move_tipocad','C');
                  Sistema.SetField('move_repr_codigo',Representante);
                  Sistema.SetField('move_qtde',Plista.qtdeenviada-PLista.qtdedevolvida);
                  Sistema.SetField('move_datalcto',Sistema.Hoje);
                  Sistema.SetField('move_datamvto',Emissao);
                  Sistema.SetField('move_qtderetorno',0);
                  Sistema.SetField('move_custo',TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
                  Sistema.SetField('move_custoger',TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
                  Sistema.SetField('move_customedio',TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
                  Sistema.SetField('move_customeger',TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
                  Sistema.SetField('move_venda',venda);
                  Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
                  Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
                  Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
                  Sistema.SetField('move_remessas',Remessas);
                  Sistema.SetField('Move_cst',FEstoque.Getsituacaotributaria(codigoestoque,unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring));
                  Sistema.SetField('Move_aliicms',aliicms);
                  Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
                  Sistema.SetField('move_vendabru',venda);
                  Sistema.SetField('move_devolucoes',Devolucoes);
                  Sistema.Post('');
                end;
              end;
            end;

          end else begin

            Sistema.Insert('Movestoque');
            Sistema.SetField('move_esto_codigo',codigoestoque);
  {
            codigolinha:=FEstoque.GetCodigoLinha(codigoestoque,codigograde);
            codigocoluna:=FEstoque.GetCodigoColuna(codigoestoque,codigograde);
            if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
              Sistema.SetField('move_tama_codigo',codigolinha)
            else
              Sistema.SetField('move_core_codigo',codigolinha);
            if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
              Sistema.SetField('move_tama_codigo',codigocoluna)
            else
              Sistema.SetField('move_core_codigo',codigocoluna);
  }
            Sistema.SetField('move_tama_codigo',0);
            Sistema.SetField('move_core_codigo',0);
            Sistema.SetField('move_copa_codigo',0);
            Sistema.SetField('move_transacao',transacao);
            Sistema.SetField('move_operacao',FGeral.GetOperacao);
            Sistema.SetField('move_numerodoc',numeronf);
            Sistema.SetField('move_status','N');
            Sistema.SetField('move_tipomov',Global.CodVendaConsig);
            Sistema.SetField('move_unid_codigo',Unidade);
            Sistema.SetField('move_tipo_codigo',Cliente.AsInteger);
            Sistema.SetField('move_tipocad','C');
            Sistema.SetField('move_repr_codigo',Representante);
            Sistema.SetField('move_qtde',qtde);
            Sistema.SetField('move_datalcto',Sistema.Hoje);
            Sistema.SetField('move_datamvto',Emissao);
            Sistema.SetField('move_qtderetorno',0);
            Sistema.SetField('move_custo',TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
            Sistema.SetField('move_custoger',TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
            Sistema.SetField('move_customedio',TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
            Sistema.SetField('move_customeger',TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
            Sistema.SetField('move_venda',venda);
            Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
            Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
            Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
            Sistema.SetField('move_remessas',Remessas);
//            Sistema.SetField('Move_cst',FEstoque.Getsituacaotributaria(codigoestoque,unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring));
// 09.05.11 - Nfe de VC - co..sn - cst do simples nacional
            Sistema.SetField('Move_cst',FEstoque.Getsituacaotributaria(codigoestoque,unidade,
                             Cliente.resultfind.fieldbyname('clie_uf').asstring,
                             Global.CodVendaConsig,0,'N',simples) );
            aliicms:=FEstoque.Getaliquotaicms(codigoestoque,unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring,Cliente.asinteger);
            Sistema.SetField('Move_aliicms',aliicms);
            Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
            Sistema.SetField('move_vendabru',venda);
  // 25.10.05
            Sistema.SetField('move_devolucoes',Devolucoes);
//          Sistema.SetField('move_perdesco',percdesconto);
// 20.05.05 - retirado grava��o do desconto por item pois na nf VC so tem desconto "geral"
            Sistema.Post('');  // 31.08.06 - colocado aqui o post por 'didatica'...
          end;


//        totalitem:=FGeral.Arredonda(venda*qtde,2) - FGeral.Arredonda((venda*qtde)*(percdesconto/100),2);
//        totalit:=FGeral.Arredonda(venda*qtde,2) - FGeral.Arredonda((venda*qtde)*(percdesconto/100),2);
// 18.05.11
          totalitem:=FGeral.Arredonda(venda*qtde,2) - FGeral.Arredonda((venda*qtde)*(percdesconto/100),3);
          totalit:=FGeral.Arredonda(venda*qtde,2) - FGeral.Arredonda((venda*qtde)*(percdesconto/100),3);
// 04.06.2012 - dif. Janina
           totalnf:=totalnf+totalitem;
           totalprodutos:=totalprodutos+FGeral.Arredonda(venda*qtde,2);
/////////////////
// 13.01.05 - aplicado o desconto somente pelo total da nota e nao por item
//          totalitem:=FGeral.Arredonda(venda*qtde,2) ;
//          totalit:=FGeral.Arredonda(venda*qtde,2) ;
// 14.01.05 - obrigar o desconto nos itens para ficar certo a(s) base(s) mesmo sendo em valor
//            calcular e aplicar

          icmsitem:=FGeral.arredonda(totalitem*(aliicms/100),2);
          icmssubs:=0;
          basesubs:=0;
          if icmsitem>0 then begin
            Totalbaseicms:=Totalbaseicms+totalitem;
            valoricms:=valoricms+icmsitem;
  //          vlricms:=
          end else
            totalitem:=0;

// 08.04.05 - aparentemente nao estava posicionando corretamente no arquivo da situacao tributaria de cada produto
//          Arq.TSittributaria.locate('sitt_codigo',inttostr( FEstoque.GetCodigosituacaotributaria(codigoestoque,Unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring) ), [] );
// 31.08.06
          TSittributaria:=sqltoquery('select * from sittrib where sitt_codigo='+inttostr( FEstoque.GetCodigosituacaotributaria(codigoestoque,Unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring) ) );

          if (TSittributaria.fieldbyname('sitt_cf').asstring=Global.CodigoSubsTrib) and (Cliente.resultfind.fieldbyname('clie_tipo').asstring<>'J') then begin
//            basesubs:=basesubs+( totalitem*(1+(Global.MargemSubsTrib/100)) );
             margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(codigoestoque,Unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring));
             basesubs:=( totalitem*(1+(margemlucro/100)) );
             icmssubs:=(totalitem*(1+(margemlucro/100))) * (aliicms/100);
             if icmssubs>=icmsitem then
               icmssubs:=icmssubs-icmsitem
             else
               icmssubs:=0;
             TotalBaseicmsSubs:=TotalBaseicmsSubs+basesubs;
             valoricmssubs:=valoricmssubs+icmssubs;
          end;

          FGeral.fechaquery(TSittributaria);

  // ver campos de tributa��o,  bases de calculos, etc
  // ver quando tem redu�ao da base de calculo e reduzir
          reducao:=0;isentas:=0;outras:=0;
          ValorContabil:=totalit+icmssubs;
//          Base:=totalitem;
          Base:=totalit;

  //        Valortotal:=valortotal+totalitem;
  // 12.11.04 - beltrao num tem icms....desta forma num gerava valor da nota
          Valortotal:=ValorTotal+totalit;
// 17.11.04 - isento de icms
          if base=0 then begin
            outras:=totalit;
            base:=totalit;
          end;
          if (Movimento<=1) or (cliente.resultfind.fieldbyname('clie_tipo').asstring<>'F') then begin
            basesubs:=0;
            icmssubs:=0;
          end;
          if icmssubs>0 then
            outras:=icmssubs;

          FGeral.GeraListaCstPerc(FEstoque.Getsituacaotributaria(codigoestoque,unidade,
                           Cliente.resultfind.fieldbyname('clie_uf').asstring,Global.CodVendaConsig,0,'N',simples),
                           FEstoque.Getaliquotaicms(codigoestoque,unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring,Cliente.asinteger),
                           valorcontabil,totalitem,reducao,isentas,outras,basesubs,ListaCstPerc );
          inc(nitens);

        end else begin    // se qtde>0 , isto � , se o saldo do produto for maior q zero

// 14.03.05 - devolucoes referente a remessas nao marcadas dai o saldo fica negativo ( "nao saiu mas voltou" )
          if ListaDevolSemRemessas.indexof(inttostr(nrodevolucao))=-1 then begin
            ListaDevolSemRemessas.Add(inttostr(nrodevolucao));
            devolucoessemremessas:=devolucoessemremessas+inttostr(nrodevolucao)+';'
          end;

        end;

        if TEstoqueqtde<>nil then
          FGeral.fechaquery(TEstoqueqtde);
      end;

      if listacores<>nil then
          Listacores.Clear;


{
      if (percdesconto=0) then begin  // foi dado desconto em valor
        if valortotal>0 then
          valortotal:=valortotal-vlrdesconto;
        if totalbaseicms>0 then
          totalbaseicms:=totalbaseicms-vlrdesconto;
        if TotalBaseicmsSubs>0 then  // 13.01.05
          totalbaseicmssubs:=totalbaseicmsSubs-vlrdesconto;
        if basesubs>0 then
          basesubs:=basesubs-vlrdesconto;
      end;
}
      if Movimento<=1 then begin
        TotalBaseicmsSubs:=0;
        totalbaseicms:=0;
        basesubs:=0;
        icmssubs:=0;
        valoricmssubs:=0;
      end;

      if (cliente.resultfind.fieldbyname('clie_tipo').asstring<>'F') then begin
        basesubs:=0;
        icmssubs:=0;
        valoricmssubs:=0;
      end;

// Gerando o arquivo de "mestre" da movimenta��o da nf de venda
/////////////////////////////////////////////////////////////////////////////////////
//      if totalnf>0 then begin     // 17.03.05
      if (totalnf>0) and (nitens>0) then begin     // 01.06.05 - caso devolover TUDO ou nenhum item tinha saldo...nao deixar gerar so o mestre
// 01.06.11

        Sistema.beginprocess('Gravando totais da nota fiscal');
        Sistema.Insert('Movesto');
        Sistema.SetField('moes_transacao',Transacao);
        Sistema.SetField('moes_operacao',GetOperacao);
        Sistema.SetField('moes_status','N');
        Sistema.SetField('moes_numerodoc',Numeronf);
        Sistema.SetField('moes_tipomov',Global.CodVendaConsig);
        Sistema.SetField('moes_unid_codigo',Unidade);
        Sistema.SetField('moes_tipo_codigo',Cliente.AsInteger);
  //      Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
        Sistema.SetField('moes_estado',Cliente.ResultFind.fieldbyname('clie_uf').AsString);
  //      Sistema.Setfield('moes_natf_codigo',FGeral.QNatfiscal(Tipomovimento,Cliente.ResultFind.fieldbyname('clie_uf').AsString,Unidade));
        Sistema.SetField('moes_repr_codigo',Representante);
        Sistema.SetField('moes_tipocad','C');
        Sistema.SetField('moes_datalcto',Sistema.Hoje);
        Sistema.SetField('moes_datamvto',Emissao);
        Sistema.SetField('moes_DataCont',Movimento);
        Sistema.SetField('moes_dataemissao',Emissao);
  //      Sistema.SetField('moes_vlrtotal',Valortotal+valoricmssubs);
// 04.11.13 - devido ao preco medio...               // 14.11.13
// 17.11.13
        ListaMensagem:=TStringList.create;
        if (xtotalnf>totalnf) and (xtotalnf>0) and (percdesconto=0) then begin
           ListaMensagem.add('Chegacem de totais. Xtotalnf '+FGeral.Formatavalor(xtotalnf,f_cr)+
                ' Totalnf '+FGeral.Formatavalor(totalnf,f_cr)+
                ' Parcela '+(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),1] )  );
///////////          totalnf:=xtotalnf;
// 13.12.13 0 retirado pois junto com sandra constatado que totalnf t� certo
//          ListaMensagem.SaveToFile('VC'+inttostr(Numeronf)+'.TXT');
        end;
        ListaMensagem.free;
  // 13.03.05
        Sistema.SetField('moes_vlrtotal',TotalNF);
//        Sistema.SetField('moes_comv_codigo',TConfMovimento.fieldbyname('comv_codigo').AsString);
        Sistema.SetField('moes_comv_codigo',TConfMovimento.fieldbyname('comv_codigo').AsInteger);
        Sistema.SetField('moes_baseicms',TotalBaseicms);
        Sistema.SetField('Moes_BaseSubstrib',TotalBaseicmssubs);   // ver quando tem q calcular e como
        Sistema.SetField('Moes_vispra',FCondPagto.GetAvPz(Condicao));
        Sistema.SetField('Moes_especie',TConfMovimento.fieldbyname('comv_especie').AsString);
        Sistema.SetField('Moes_serie',FGeral.Qualserie(TConfMovimento.fieldbyname('comv_serie').AsString,Global.serieunidade) );
        if CompareStrings(Cliente.ResultFind.fieldbyname('clie_uf').AsString,Arq.TUnidades.fieldbyname('unid_uf').asstring) then
          Sistema.SetField('moes_natf_codigo',TConfMovimento.fieldbyname('comv_natf_estado').AsString)
        else
          Sistema.SetField('moes_natf_codigo',TConfMovimento.fieldbyname('comv_natf_foestado').AsString);

        Sistema.SetField('moes_remessas',Remessas);
    //    Sistema.SetField('moes_tabp_codigo',Tabela);
    //    Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
        Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('moes_perdesco',percdesconto);
//        Sistema.SetField('moes_valortotal',Valortotal);  // 03.08.04
        Sistema.SetField('moes_valortotal',Totalnf);  // 07.04.05
//        Sistema.SetField('moes_totprod',Valortotal);  // 17.11.04
        Sistema.SetField('moes_totprod',TotalProdutos);  // 21.09.11 - novo parametro
//  desmudado pra deixar o total de produtos sem a substitui��o
//        Sistema.SetField('moes_totprod',Totalnf);  // 07.04.05
        Sistema.SetField('moes_valoricmssutr',valoricmssubs);  // 14.12.04
        Sistema.SetField('moes_valoricms',valoricms);       // 14.12.04
  // 23.12.04
        if FCondPagto.GetPrimeiroPrazo(Condicao)=0 then begin
          if Gridparcelas<>nil then
//            Sistema.SetField('moes_valoravista',texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),1] ) + valoricmssubs);
// 01.06.05 - somava duas vezes a subst. pois no edit da venda a vista ja vem a subst....
            Sistema.SetField('moes_valoravista',texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),1] ) );
        end;
  ////////////
//        Sistema.SetField('moes_tran_codigo',1);  // 17.06.05
        Sistema.SetField('moes_tran_codigo','001');  // 29.09.10
// 25.10.05
        Sistema.SetField('moes_devolucoes',Devolucoes);

// 29.06.06 - mudado mais acima pra checar se e simples nacional pra mudar o cst
////////////////
{
        mensagemfixa:='';
        if (FGeral.getconfig1asinteger('MENSSIMPRS')>0)  and (Movimento>1)then begin
          QUnidade:=sqltoquery('select unid_simples,unid_uf from unidades where unid_codigo='+stringtosql(unidade));
          if not QUnidade.eof then begin
            if (QUnidade.fieldbyname('unid_simples').asstring='S') and (QUnidade.fieldbyname('unid_uf').asstring='RS') then
              mensagemfixa:=FMensNotas.GetDescricao( FGeral.getconfig1asInteger('MENSSIMPRS') )+' '  ;
          end;
          FGeral.Fechaquery(QUnidade);
        end;
////////////////
}
        if trim(mensagemfixa)<>'' then
          Sistema.SetField('moes_mensagem',mensagemfixa);
// 17.11.13 - Dif. nas VC a vista
        Sistema.SetField('moes_fpgt_codigo',Condicao);

///////////////
        Sistema.Post();

  // Gerando o arquivo de bases de c�lculo conforme as situacoes tributarias existentes
  /////////////////////////////////////////////////////////////////////////////////////
        Sistema.beginprocess('Gravando bases de c�lculo da nota fiscal');
        if Movimento>1 then begin
          if TotalBaseicms>0 then
            perdescorateio:=(vlrdesconto/TotalBaseicms)*100
          else
            perdescorateio:=0;
          for p:=0 to ListaCstPerc.Count-1 do begin
            PCstPerc:=Listacstperc[p];
            Sistema.Insert('MovBase');
            Sistema.SetField('movb_transacao',Transacao);
            Sistema.SetField('movb_operacao',GetOperacao);
            Sistema.SetField('movb_status','N');
            if (percdesconto=0) then begin  // foi dado desconto em valor
              if Pcstperc.base>0 then
                Pcstperc.base:=Pcstperc.base-(Pcstperc.base*(perdescorateio/100));
              if pcstperc.isentas>0 then
                pcstperc.isentas:=pcstperc.isentas-(Pcstperc.isentas*(perdescorateio/100));
              if pcstperc.outras>0 then
                pcstperc.outras:=pcstperc.outras-(Pcstperc.outras*(perdescorateio/100));
            end;
            Sistema.SetField('movb_numerodoc',Numeronf);
            Sistema.SetField('Movb_cst',Pcstperc.cst);
    //////////        Sistema.SetField('Movb_Codigosfis',     'Simb',  talvez nao precise pois ja gravo o % icms

//            Sistema.SetField('Movb_TpImposto','I');   // fixo I-Icms
// 13.07.06
            Sistema.SetField('Movb_TpImposto',Pcstperc.tpimposto );
      // codigo de valores fiscais ( 1,,5 da impressao do livro fiscal )
    //        Sistema.SetField('Movb_CVF',cvf);    // checar - talvez nao precise
            Sistema.SetField('Movb_BaseCalculo',Pcstperc.base);
            Sistema.SetField('Movb_Aliquota',pcstperc.perc);
            Sistema.SetField('Movb_ReducaoBc',pcstperc.reducao);
//            Sistema.SetField('Movb_Imposto',FGeral.Arredonda(pcstperc.base*(pcstperc.perc/100),2) );
            Sistema.SetField('Movb_Imposto',FGeral.Arredonda( ( ( pcstperc.base*(pcstperc.reducao/100) ) ) * (pcstperc.perc/100),2) );
            Sistema.SetField('Movb_Isentas',pcstperc.isentas);
            Sistema.SetField('Movb_Outras' ,pcstperc.outras);
            Sistema.SetField('Movb_tipomov',Global.CodVendaConsig);
            Sistema.SetField('Movb_unid_codigo',Unidade);  // 13.07.06
            Sistema.Post();
          end;
        end;
      end;   // totalnf>0

// Gerando a pendencia a receber
/////////////////////////////////////////////////////////////////////////////////////
      ListaPrazos:=TStringList.Create;
      n:=FCondPagto.GetPrazos(Condicao,ListaPrazos);
// ver se for a vista jogar na conta caixa ( configura��o na unidade )
      nparcelas:=FCondPagto.GetNumeroParcelas(Condicao);
// verificar se � a vista com apenas uma parcela OU se somente a primeira parcela � a vista ( ou parte do total )
      valorparcela:=0;
//      if FCondPagto.GetPerEntrada(Condicao)>0 then begin
//        valorparcela:=FGeral.Arredonda(valortotal*(Arq.TFPgto.fieldbyname('fpgt_entrada').AsCurrency/100),2);
      if Gridparcelas<>nil then begin
        valorparcela:=texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),1] ) ;
// 13.03.05 - tentativa devido a dif. de valores entre total nf e valor do caixa
        valorparcela:=roundvalor(valorparcela);
      end;
      parcelaini:=1;
// 13.03.05
//      if FCondPagto.GetAvPz(Condicao)='V'  then begin
//         if valorparcela<>totalnf then begin
//            Avisoerro('Valor total da nota difere do valor para o caixa.');
//            valorparcela:=totalnf;
//         end;
//      end;
/////////////////////////////
      if (FCondPagto.GetPrimeiroPrazo(Condicao)=0) and (valorparcela>0) then begin
        Sistema.beginprocess('Gravando venda a vista no caixa');
//      GravaMovFinanceiro(valorparcela+valoricmssubs);    // 14.02.05 - nao somava a subst.
// 26.10.13                                               // 30.10.13
        if ( totalnf-valorparcela>1 ) and (percdesconto=0) and (FCondPagto.GetAvPz(Condicao)='V') then begin
          valorparcela:=totalnf;  // 04.11.13 - da dif. devido a media de pre�o
        end;
// 11.03.05 - assim fica errado tbem...
        GravaMovFinanceiro(valorparcela);
//        valortotal:=valortotal-valorparcela;
        parcelaini:=2;
      end;

      acumulado:=0;
      Sistema.beginprocess('Gravando pend�ncias financeiras');
      if (Gridparcelas<>nil) and (valortotal>0) then begin
        for p:=parcelaini to nparcelas do begin
// 24.05.12 - Liane . duas parcelas 'a vista' sem em cartao e em dinheiro ou cheque
          if (FCondPagto.GetPrimeiroPrazo(Condicao)=0) and
             ( (Gridparcelas.cells[Gridparcelas.getcolumn('pend_datavcto'),p]) =
               (Gridparcelas.cells[Gridparcelas.getcolumn('pend_datavcto'),p-1]) )
              then begin

              GravaMovFinanceiro(texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),p] ));

          end else begin
            Sistema.Insert('Pendencias');
            Sistema.SetField('Pend_Transacao',Transacao);
            Sistema.SetField('Pend_Operacao',GetOperacao);
            Sistema.SetField('Pend_Status','N');
            Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
            Sistema.SetField('Pend_DataCont',Movimento);
            Sistema.SetField('Pend_DataMvto',Emissao);
  //          Sistema.SetField('Pend_DataVcto',FGeral.GetProximoDiaUtil(Emissao+Inteiro(ListaPrazos[p-1])) );
            Sistema.SetField('Pend_DataVcto',Texttodate(Tirabarra(Gridparcelas.cells[Gridparcelas.getcolumn('pend_datavcto'),p]) ) );
            Sistema.SetField('Pend_DataEmissao',Emissao);
      //      Sistema.SetField('Pend_DataAutPgto','D',0,0,60,True,'Data Aut. Pgto','Data autorizada para pagamento','',True,'1','','','0');
            Sistema.SetField('Pend_Plan_Conta',Cliente.Resultfind.fieldbyname('clie_contagerencial').AsInteger);
            Sistema.SetField('Pend_Unid_Codigo',Unidade);
            Sistema.SetField('Pend_Fpgt_Codigo',Condicao);
  //          Sistema.SetField('Pend_Port_Codigo',Global.VCPort);
  // 25.10.05
  //          Sistema.SetField('Pend_Port_Codigo',Portador);
  // 24.05.12  - Vivan
            Sistema.SetField('Pend_Port_Codigo',Gridparcelas.cells[Gridparcelas.getcolumn('pend_port_codigo'),p]);
            Sistema.SetField('Pend_Hist_Codigo',Global.VCHist);
            Sistema.SetField('Pend_Moed_Codigo','');
            Sistema.SetField('Pend_Repr_Codigo',Representante);
            Sistema.SetField('Pend_Tipo_Codigo',Cliente.Asinteger);
            Sistema.SetField('Pend_TipoCad'    ,'C');
      //      Sistema.SetField('Pend_CNPJCPF',EdCliente.Resultfind('clie_cnpjcpf);
            Sistema.SetField('Pend_Complemento',global.VCComplehist);
            Sistema.SetField('Pend_NumeroDcto',Numeronf);
            Sistema.SetField('Pend_Parcela',p);
            Sistema.SetField('Pend_NParcelas',nparcelas);
            Sistema.SetField('Pend_RP','R');
  // 14.02.05 - nao estava somando a substituicao
  //          Sistema.SetField('Pend_Valor',texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),p] )+ (valoricmssubs/nparcelas));
  //          Sistema.SetField('Pend_ValorTitulo',valortotal+valoricmssubs);
  // 11.03.05 - retirado a subst
            Sistema.SetField('Pend_Valor',texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),p] ) );
            Sistema.SetField('Pend_ValorTitulo',valortotal);

            Sistema.SetField('Pend_Juros',0);
            Sistema.SetField('Pend_Multa',0);
            Sistema.SetField('Pend_Mora',0);
            Sistema.SetField('Pend_Acrescimos',0);
            Sistema.SetField('Pend_Descontos',0);
            Sistema.SetField('Pend_ValorComissao',0);
            Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
            Sistema.SetField('Pend_ContaBaixa',0);
    //        Sistema.SetField('Pend_DataBaixa',0);
            Sistema.SetField('Pend_Observacao','');
  //          Sistema.SetField('Pend_UsuAutPgto','');
            Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
            Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso j� foi enviado para impress�o
            Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exporta��o banc�ria (CNAB )
  // 09.05.11 - senao nao imprime as parcelas e vencimentos na nota..antes nao tinha este campo
            Sistema.SetField('Pend_tipomov',Global.CodVendaConsig);
            Sistema.Post;
          end;  // se for 'outra a vista
        end;

      end else if (FCondPagto.GetAvPz(Condicao)='P') and (valortotal>0) then begin

        for p:=1 to nparcelas do begin
          Sistema.Insert('Pendencias');
          Sistema.SetField('Pend_Transacao',Transacao);
          Sistema.SetField('Pend_Operacao',GetOperacao);
          Sistema.SetField('Pend_Status','N');
          Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
          Sistema.SetField('Pend_DataCont',Movimento);
          Sistema.SetField('Pend_DataMvto',Emissao);
          Sistema.SetField('Pend_DataVcto',FGeral.GetProximoDiaUtil(Emissao+Inteiro(ListaPrazos[p-1])) );
          Sistema.SetField('Pend_DataEmissao',Emissao);
    //      Sistema.SetField('Pend_DataAutPgto','D',0,0,60,True,'Data Aut. Pgto','Data autorizada para pagamento','',True,'1','','','0');
          Sistema.SetField('Pend_Plan_Conta',Cliente.Resultfind.fieldbyname('clie_contagerencial').AsInteger);
          Sistema.SetField('Pend_Unid_Codigo',Unidade);
          Sistema.SetField('Pend_Fpgt_Codigo',Condicao);
//          Sistema.SetField('Pend_Port_Codigo',Global.VCPort);
// 25.10.05
          Sistema.SetField('Pend_Port_Codigo',Portador);
          Sistema.SetField('Pend_Hist_Codigo',Global.VCHist);
          Sistema.SetField('Pend_Moed_Codigo','');
          Sistema.SetField('Pend_Repr_Codigo',Representante);
          Sistema.SetField('Pend_Tipo_Codigo',Cliente.Asinteger);
          Sistema.SetField('Pend_TipoCad'    ,'C');
    //      Sistema.SetField('Pend_CNPJCPF',EdCliente.Resultfind('clie_cnpjcpf);
          Sistema.SetField('Pend_Complemento',global.VCComplehist);
          Sistema.SetField('Pend_NumeroDcto',Numeronf);
          Sistema.SetField('Pend_Parcela',p);
          Sistema.SetField('Pend_NParcelas',nparcelas);
          Sistema.SetField('Pend_RP','R');
          if p=nparcelas then
            valorparcela:=valortotal-acumulado  // para deixar na ultima parcelas "as d�zimas"
          else
            valorparcela:=FGeral.Arredonda(valortotal/nparcelas,2);
          acumulado:=acumulado+valorparcela;
          Sistema.SetField('Pend_Valor',valorparcela);
          Sistema.SetField('Pend_ValorTitulo',valortotal);
          Sistema.SetField('Pend_Juros',0);
          Sistema.SetField('Pend_Multa',0);
          Sistema.SetField('Pend_Mora',0);
          Sistema.SetField('Pend_Acrescimos',0);
          Sistema.SetField('Pend_Descontos',0);
          Sistema.SetField('Pend_ValorComissao',0);
          Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
          Sistema.SetField('Pend_ContaBaixa',0);
  //        Sistema.SetField('Pend_DataBaixa',0);
          Sistema.SetField('Pend_Observacao','');
//          Sistema.SetField('Pend_UsuAutPgto','');
          Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
          Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso j� foi enviado para impress�o
          Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exporta��o banc�ria (CNAB )
// 09.05.11 - senao nao imprime as parcelas e vencimentos na nota..antes nao tinha este campo
          Sistema.SetField('Pend_tipomov',Global.CodVendaConsig);
          Sistema.Post;
        end;  // for do numero de parcelas
      end;   // vista ou a prazo
      Freeandnil(ListaPrazos);
// 12.11.15 - vivan
///////////////////
      if (Gridparcelas01<>nil) and (valortotal>0) then begin
        nparcelas:=0;
        for p:=1 to GridParcelas01.rowcount do begin
          if texttovalor(Gridparcelas01.cells[Gridparcelas01.getcolumn('pend_valor'),p] )  > 0 then inc(nparcelas);
        end;
        for p:=1 to GridParcelas01.rowcount do begin
          if texttovalor(Gridparcelas01.cells[Gridparcelas01.getcolumn('pend_valor'),p] ) > 0 then begin
             if Texttodate(Tirabarra(Gridparcelas01.cells[Gridparcelas01.getcolumn('pend_datavcto'),p]) ) = Sistema.hoje
                then begin
                GravaMovFinanceiro(texttovalor(Gridparcelas01.cells[Gridparcelas01.getcolumn('pend_valor'),p] ));
            end else begin
              Sistema.Insert('Pendencias');
              Sistema.SetField('Pend_Transacao',Transacao);
              Sistema.SetField('Pend_Operacao',GetOperacao);
              Sistema.SetField('Pend_Status','N');
              Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
              Sistema.SetField('Pend_DataCont',Movimento);
              Sistema.SetField('Pend_DataMvto',Emissao);
              Sistema.SetField('Pend_DataVcto',Texttodate(Tirabarra(Gridparcelas01.cells[Gridparcelas01.getcolumn('pend_datavcto'),p]) ) );
              Sistema.SetField('Pend_DataEmissao',Emissao);
              Sistema.SetField('Pend_Plan_Conta',Cliente.Resultfind.fieldbyname('clie_contagerencial').AsInteger);
              Sistema.SetField('Pend_Unid_Codigo',Unidade);
              Sistema.SetField('Pend_Fpgt_Codigo',Condicao);
              Sistema.SetField('Pend_Port_Codigo',xportador01);
              Sistema.SetField('Pend_Hist_Codigo',Global.VCHist);
              Sistema.SetField('Pend_Moed_Codigo','');
              Sistema.SetField('Pend_Repr_Codigo',Representante);
              Sistema.SetField('Pend_Tipo_Codigo',Cliente.Asinteger);
              Sistema.SetField('Pend_TipoCad'    ,'C');
              Sistema.SetField('Pend_Complemento',global.VCComplehist);
              Sistema.SetField('Pend_NumeroDcto',Numeronf);
              Sistema.SetField('Pend_Parcela',p);
              Sistema.SetField('Pend_NParcelas',nparcelas);
              Sistema.SetField('Pend_RP','R');
              Sistema.SetField('Pend_Valor',texttovalor(Gridparcelas01.cells[Gridparcelas01.getcolumn('pend_valor'),p] ) );
              Sistema.SetField('Pend_ValorTitulo',valortotal);

              Sistema.SetField('Pend_Juros',0);
              Sistema.SetField('Pend_Multa',0);
              Sistema.SetField('Pend_Mora',0);
              Sistema.SetField('Pend_Acrescimos',0);
              Sistema.SetField('Pend_Descontos',0);
              Sistema.SetField('Pend_ValorComissao',0);
              Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
              Sistema.SetField('Pend_ContaBaixa',0);
      //        Sistema.SetField('Pend_DataBaixa',0);
              Sistema.SetField('Pend_Observacao','');
    //          Sistema.SetField('Pend_UsuAutPgto','');
              Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
              Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso j� foi enviado para impress�o
              Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exporta��o banc�ria (CNAB )
              Sistema.SetField('Pend_tipomov',Global.CodVendaConsig);
              Sistema.Post;
            end;
          end;
        end;
      end;
/////////////////////////////////////////////////
// 16.11.15 - vivan
///////////////////
      if (Gridparcelas02<>nil) and (valortotal>0) then begin
        nparcelas:=0;
        for p:=1 to GridParcelas02.rowcount do begin
          if texttovalor(Gridparcelas02.cells[Gridparcelas02.getcolumn('pend_valor'),p] )  > 0 then inc(nparcelas);
        end;
        for p:=1 to GridParcelas02.rowcount do begin
          if texttovalor(Gridparcelas02.cells[Gridparcelas01.getcolumn('pend_valor'),p] ) > 0 then begin
             if Texttodate(Tirabarra(Gridparcelas02.cells[Gridparcelas02.getcolumn('pend_datavcto'),p]) ) = Sistema.hoje
                then begin
                GravaMovFinanceiro(texttovalor(Gridparcelas02.cells[Gridparcelas02.getcolumn('pend_valor'),p] ));
            end else begin
              Sistema.Insert('Pendencias');
              Sistema.SetField('Pend_Transacao',Transacao);
              Sistema.SetField('Pend_Operacao',GetOperacao);
              Sistema.SetField('Pend_Status','N');
              Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
              Sistema.SetField('Pend_DataCont',Movimento);
              Sistema.SetField('Pend_DataMvto',Emissao);
              Sistema.SetField('Pend_DataVcto',Texttodate(Tirabarra(Gridparcelas02.cells[Gridparcelas02.getcolumn('pend_datavcto'),p]) ) );
              Sistema.SetField('Pend_DataEmissao',Emissao);
              Sistema.SetField('Pend_Plan_Conta',Cliente.Resultfind.fieldbyname('clie_contagerencial').AsInteger);
              Sistema.SetField('Pend_Unid_Codigo',Unidade);
              Sistema.SetField('Pend_Fpgt_Codigo',Condicao);
              Sistema.SetField('Pend_Port_Codigo',xportador02);
              Sistema.SetField('Pend_Hist_Codigo',Global.VCHist);
              Sistema.SetField('Pend_Moed_Codigo','');
              Sistema.SetField('Pend_Repr_Codigo',Representante);
              Sistema.SetField('Pend_Tipo_Codigo',Cliente.Asinteger);
              Sistema.SetField('Pend_TipoCad'    ,'C');
              Sistema.SetField('Pend_Complemento',global.VCComplehist);
              Sistema.SetField('Pend_NumeroDcto',Numeronf);
              Sistema.SetField('Pend_Parcela',p);
              Sistema.SetField('Pend_NParcelas',nparcelas);
              Sistema.SetField('Pend_RP','R');
              Sistema.SetField('Pend_Valor',texttovalor(Gridparcelas02.cells[Gridparcelas02.getcolumn('pend_valor'),p] ) );
              Sistema.SetField('Pend_ValorTitulo',valortotal);

              Sistema.SetField('Pend_Juros',0);
              Sistema.SetField('Pend_Multa',0);
              Sistema.SetField('Pend_Mora',0);
              Sistema.SetField('Pend_Acrescimos',0);
              Sistema.SetField('Pend_Descontos',0);
              Sistema.SetField('Pend_ValorComissao',0);
              Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
              Sistema.SetField('Pend_ContaBaixa',0);
      //        Sistema.SetField('Pend_DataBaixa',0);
              Sistema.SetField('Pend_Observacao','');
    //          Sistema.SetField('Pend_UsuAutPgto','');
              Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
              Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso j� foi enviado para impress�o
              Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exporta��o banc�ria (CNAB )
              Sistema.SetField('Pend_tipomov',Global.CodVendaConsig);
              Sistema.Post;
            end;
          end;
        end;
      end;
/////////////////////////////////
///////////////////////////////////////////////
// 24.10.12 - Vivan - baixa do credito usado no acerto ...
////////////////////////////////////////////////////////////
      if valorantecipa>0 then
        FGeral.GravaPendencia(emissao,movimento,Cliente,'C',Representante,UNidade,
                                 Global.CodPendenciaFinanceira,Transacao,Global.FpgtoAntecipa,'P',
                                 Numeronf,0,ValorAntecipa,0,'A');
//////////////////////////////////////////////////////////
// marcar as remessas como ja devolvidas
      tam:=pos(';',Remessas)-1;

// 04.06.04 - senao ainda n�o tem nada gravado no banco para mudar o status                                                                                  f
//////////////////////////////////////////////////////////////////////////////////////////////
      Sistema.beginprocess('Gravando');
// 01.06.11 - colocado try e atualiza contador de nota somente se comitar
      try
        Sistema.commit;
        if movimento>1 then begin
          if GravaEcf then begin  // 08.06.11
            if (totalnf>0) and (nitens>0) then begin // 01.02.12 - devolove TUDO ou nenhum item tinha saldo...nao pula a numeracao
              FGeral.AlteraContador('NFSAIDAECF'+Global.CodigoUnidade+TConfMovimento.fieldbyname('comv_serie').asstring,Numeronf);
// 03.09.15
              FGeral.AlteraContador('NFSAIDA'+Global.CodigoUnidade+TConfMovimento.fieldbyname('comv_serie').asstring,Numeronf);
            end;
          end else begin
//            FGeral.AlteraContador('NFSAIDA'+Global.CodigoUnidade+FGeral.Qualserie(TConfMovimento.fieldbyname('comv_serie').asstring,Global.serieunidade),Numeronf)
// 25.08.11 - pra ver se 'para de pular' a numeracao as vezes na Fama Confeccoes
            if (totalnf>0) and (nitens>0) then // 01.02.12 - devolove TUDO ou nenhum item tinha saldo...nao pula a numeracao
              Numero:=FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+FGeral.Qualserie(TConfMovimento.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true);
          end
        end else begin
          if (totalnf>0) and (nitens>0) then // 01.02.12 - devolove TUDO ou nenhum item tinha saldo...nao pula a numeracao
            FGeral.AlteraContador('SAIDA'+Global.CodigoUnidade+FGeral.Qualserie(TConfMovimento.fieldbyname('comv_serie').asstring,Global.serieunidade),Numeronf);
        end;
      except
        Sistema.endprocess('Grava��o Interrompida.  Problemas para gravar no banco de dados');
        exit;
      end;

      Sistema.beginprocess('Gravando as remessas como j� totalmente devolvidas');

/////////////////////////
{
      ExecuteSql('Update movesto set moes_status=''D'' where moes_tipo_codigo='+Cliente.AsSql+
                         ' and '+FGeral.GetIN('moes_numerodoc',Remessas,'N')+
                         ' and moes_unid_codigo='+stringtosql(Unidade)+
                         ' and '+FGeral.getin('moes_status','N','C')+
                         ' and '+FGeral.Getin('moes_tipomov',Global.CodRemessaConsig+';'+Global.CodVendaTransf+';'+Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
      ExecuteSql('Update movestoque set move_status=''D'' where move_tipo_codigo='+Cliente.AsSql+
                         ' and '+FGeral.GetIN('move_numerodoc',Remessas,'N')+
                         ' and move_unid_codigo='+stringtosql(Unidade)+
                         ' and '+FGeral.getin('move_status','N','C')+
                         ' and '+FGeral.Getin('move_tipomov',Global.CodRemessaConsig+';'+Global.CodVendaTransf+';'+Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
}
///////////////////////// - 27.04.06

      Sistema.Edit('movesto');
      Sistema.Setfield('moes_status','D');
      Sistema.Setfield('moes_dataacerto',sistema.hoje);
      Sistema.Setfield('moes_transacerto',transacao);
      Sistema.post(' moes_tipo_codigo='+Cliente.AsSql+
                         ' and '+FGeral.GetIN('moes_numerodoc',Remessas,'N')+
                         ' and moes_unid_codigo='+stringtosql(Unidade)+
                         ' and '+FGeral.getin('moes_status','N','C')+
                         ' and '+FGeral.Getin('moes_tipomov',Global.CodRemessaConsig+';'+Global.CodVendaTransf+';'+Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
      Sistema.Edit('movestoque');
      Sistema.Setfield('move_status','D');
      Sistema.post('move_tipo_codigo='+Cliente.AsSql+
                         ' and '+FGeral.GetIN('move_numerodoc',Remessas,'N')+
                         ' and move_unid_codigo='+stringtosql(Unidade)+
                         ' and '+FGeral.getin('move_status','N','C')+
                         ' and '+FGeral.Getin('move_tipomov',Global.CodRemessaConsig+';'+Global.CodVendaTransf+';'+Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
//////////////////


///////////////// 25.05.05
// trato com as VT ja fechadas na pronta entrega
      Sistema.beginprocess('Gravando as vendas de transfer�ncia como j� totalmente devolvidas');
      Sistema.Edit('movesto');
      Sistema.Setfield('moes_status','F');
      Sistema.Setfield('moes_dataacerto',sistema.hoje);
      Sistema.Setfield('moes_transacerto',transacao);
      Sistema.post('moes_tipo_codigo='+Cliente.AsSql+
                         ' and '+FGeral.GetIN('moes_numerodoc',Remessas,'N')+
                         ' and moes_unid_codigo='+stringtosql(Unidade)+
                         ' and '+FGeral.getin('moes_status','E','C')+
                         ' and '+FGeral.Getin('moes_tipomov',Global.CodVendaTransf,'C') );
      Sistema.Edit('movestoque');
      Sistema.Setfield('move_status','F');
      Sistema.Post('move_tipo_codigo='+Cliente.AsSql+
                         ' and '+FGeral.GetIN('move_numerodoc',Remessas,'N')+
                         ' and move_unid_codigo='+stringtosql(Unidade)+
                         ' and '+FGeral.getin('move_status','E','C')+
                         ' and '+FGeral.Getin('move_tipomov',Global.CodVendaTransf,'C') );

////////////////////////////
      Sistema.endprocess('');

/////////////////////
//                         ' and '+FGeral.estaemaberto(QProdDevolvido.fieldbyname('move_remessas').AsString,EdRemessas.text) and
     ListaRemessas:=tstringlist.create;
     strtolista(Listaremessas,Remessas,';',true);
     Sistema.beginprocess('Baixando devolu��es');
     sqldevosemm:='';
     if trim(devolucoessemremessas)<>'' then
       sqldevosemm:=' and '+FGeral.getNOTin('moes_numerodoc',devolucoessemremessas,'N');
     sqldevosemd:='';
     if trim(devolucoessemremessas)<>'' then
       sqldevosemd:=' and '+FGeral.getNOTin('move_numerodoc',devolucoessemremessas,'N');
// 11.04.05  - so nao marca algumas devolucoes 'sem remessa' caso todas as remessas forem marcadas pro fechamento
//     if not Marcoutudo then begin
// 03.06.05
     if Marcoutudo then begin
       sqldevosemm:='';
       sqldevosemd:='';
     end;

/////////////////////////////////////////////////////
{
     if not Marcoutudo then begin
       for p:=0 to Listaremessas.count-1 do begin
         if trim(listaremessas[p])<>'' then begin
           Sistema.Edit('Movesto');
           Sistema.Setfield('moes_status','D');
           Sistema.post('moes_tipo_codigo='+Cliente.AsSql+
                       ' and moes_unid_codigo='+stringtosql(Unidade)+
    //                   ' and moes_repr_codigo='+inttostr(representante)+
                       ' and '+FGeral.SimilarTo('moes_remessas',strzero(strtoint(listaremessas[p]),8))+
                       sqldevosemm+
                       ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
           Sistema.Edit('Movestoque');
           Sistema.Setfield('move_status','D');
           Sistema.post('move_tipo_codigo='+Cliente.AsSql+
                       ' and move_unid_codigo='+stringtosql(Unidade)+
  //                     ' and move_repr_codigo='+inttostr(representante)+
                       ' and '+FGeral.SimilarTo('move_remessas',strzero(strtoint(listaremessas[p]),8))+
                       sqldevosemd+
                       ' and move_status=''N'' and '+FGeral.Getin('move_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
         end;
       end;
     end;
     }
/////////////////////////////////////////////////////

///////////////////////////////////////////////////// - 25.10.05 - nova forma de baixar as DC e DR
     if not Marcoutudo then begin
       for p:=0 to ListaDevolucoes.count-1 do begin
         if trim(ListaDevolucoes[p])<>'' then begin
           Sistema.Edit('Movesto');
           Sistema.Setfield('moes_status','D');
           Sistema.Setfield('moes_dataacerto',sistema.hoje);
           Sistema.Setfield('moes_transacerto',transacao);
           Sistema.post('moes_tipo_codigo='+Cliente.AsSql+
                       ' and moes_unid_codigo='+stringtosql(Unidade)+
    //                   ' and moes_repr_codigo='+inttostr(representante)+
                       ' and moes_numerodoc='+ListaDevolucoes[p]+
                       ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
/////////// 27.06.13 - Checar para baixar somente se tiver produtos na remessas escolhidas
           QChecaProdutoDevolucoes:=sqltoquery('select move_esto_codigo from movestoque where move_tipo_codigo='+Cliente.AsSql+
                       ' and move_unid_codigo='+stringtosql(Unidade)+
                       ' and move_numerodoc='+ListaDevolucoes[p]+
                       ' and move_status=''N'''+
                       ' and '+FGeral.Getin('move_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
           while not QChecaProdutoDevolucoes.eof do begin
             codigoestoque:=QChecaProdutoDevolucoes.fieldbyname('move_esto_codigo').asstring;
             if ListaProdutosDevolSemRemessas.indexof(codigoestoque)=-1 then begin
               Sistema.Edit('Movestoque');
               Sistema.Setfield('move_status','D');
               Sistema.post('move_tipo_codigo='+Cliente.AsSql+
                         ' and move_unid_codigo='+stringtosql(Unidade)+
    //                     ' and move_repr_codigo='+inttostr(representante)+
                         ' and move_numerodoc='+ListaDevolucoes[p]+
                         ' and move_esto_codigo='+Stringtosql(codigoestoque)+
                         ' and move_status=''N'' and '+FGeral.Getin('move_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
             end;
             QChecaProdutoDevolucoes.Next;
           end;
           QChecaProdutoDevolucoes.close;
         end;
       end;
     end;
/////////////////////////////////////////////////////

///////////////////// = 03.06.05
     if Marcoutudo then begin
         Sistema.Edit('Movesto');
         Sistema.Setfield('moes_status','D');
         Sistema.Setfield('moes_dataacerto',sistema.hoje);
         Sistema.Setfield('moes_transacerto',transacao);
         Sistema.post('moes_tipo_codigo='+Cliente.AsSql+
                     ' and moes_unid_codigo='+stringtosql(Unidade)+
//                     ' and moes_repr_codigo='+inttostr(representante)+
                     ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
         Sistema.Edit('Movestoque');
         Sistema.Setfield('move_status','D');
         Sistema.post('move_tipo_codigo='+Cliente.AsSql+
                     ' and move_unid_codigo='+stringtosql(Unidade)+
//                     ' and move_repr_codigo='+inttostr(representante)+
                     ' and move_status=''N'' and '+FGeral.Getin('move_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
     end;
/////////////////////
     if Listaremessas.count>=1 then
       Sistema.commit;
     Listaremessas.free;
{
      ExecuteSql('Update movesto set moes_status=''D'' where moes_tipo_codigo='+Cliente.AsSql+
                         ' and moes_unid_codigo='+stringtosql(Unidade)+
                         ' and moes_repr_codigo='+inttostr(representante)+
//                         ' and substr(moes_remessas,1,'+inttostr(tam)+') = '+stringtosql(copy(EdRemessas.TExt,1,tam))+
                         ' and moes_remessas = '+stringtosql(EdRemessas.TExt)+
                         ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
      ExecuteSql('Update movestoque set move_status=''D'' where move_tipo_codigo='+Cliente.AsSql+
                         ' and move_unid_codigo='+stringtosql(Unidade)+
                         ' and move_repr_codigo='+inttostr(representante)+
//                         ' and substr(move_remessas,1,'+inttostr(tam)+') = '+stringtosql(copy(EdRemessas.TExt,1,tam))+
                         ' and move_remessas = '+stringtosql(EDRemessas.TExt)+
                         ' and move_status=''N'' and '+FGeral.Getin('move_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C') );
}
// 03.11.04
      if confirma('Imprime nota agora ?') then
            FImpressao.ImprimeNotaSaida(Numeronf,Emissao,Unidade,global.CodVendaConsig);
// 04.03.12 - Vivan cobran�a
      if Global.Usuario.OutrosAcessos[0717] then begin
        if confirma('Imprime boleto/duplicata agora ?') then
          FImpressao.ImprimeBloqueto(NumeroNF,NumeroNF,emissao,Unidade,Global.CodVendaConsig);
      end;
  end;  // se gera nf de venda consinada

end;


function TFGeral.RelEstoque(campo: string): string;
begin
  result:=FGeral.Getin(campo,'N,D,E','C');
end;



/////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.GeraListaCstPerc(Cst: string; Perc,contabil,base,reducao,isentas,outras,basesubs: currency ;
           ListaCstPerc:TList=nil  ; TpImposto:string='I' ; Cfop:string='');
/////////////////////////////////////////////////////////////////////////////////
var p,x:integer;
begin
// confirmar se para substitui��o tributaria "� mais um campo ou mais um registro ou muda a base e valor do icms"
  if ListaCstperc=nil then
    x:=PesqListaCstPerc(Cst,Perc,nil,cfop)
  else
    x:=PesqListaCstPerc(Cst,Perc,ListaCstperc,cfop);
  if x<0 then begin
    New(Pcstperc);
    pcstperc.cst:=cst;
    pcstperc.perc:=perc;
    pcstperc.contabil:=contabil;
    pcstperc.base:=base;
    pcstperc.reducao:=reducao;
    pcstperc.isentas:=isentas;
    pcstperc.outras:=outras;
    pcstperc.basesubs:=basesubs;
    pcstperc.tpimposto:=tpimposto;
    pcstperc.cfop:=cfop;
    Listacstperc.Add(Pcstperc);
  end else begin
    pcstperc.contabil:=pcstperc.contabil+contabil;
    pcstperc.base:=pcstperc.base+base;
//    pcstperc.reducao:=pcstperc.reducao+reducao;
// 24.05.07 - percentual de redu��o na precisa acumular
    pcstperc.isentas:=pcstperc.isentas+isentas;
    pcstperc.outras:=pcstperc.outras+outras;
    pcstperc.basesubs:=pcstperc.basesubs+basesubs;
  end;
end;

function  TFGeral.PesqListaCstPerc(Cst: string; Perc: currency ; ListaCstPerc:TList=nil ; cfop:string=''):integer;
///////////////////////////////////////////////////////////////////////////////////////////
var p:integer;
begin
  result:=-1;
  if trim(cfop)='' then begin
    for p:=0 to ListaCstPerc.count-1 do begin
      PCstPerc:=Listacstperc[p];
//      if (Pcstperc.cst=cst) and (Pcstperc.perc=perc) then begin
// 04.03.08
      if (Pcstperc.perc=perc) then begin
        result:=p;
        break
      end;
    end;
// 01.08.06
  end else begin
    for p:=0 to ListaCstPerc.count-1 do begin
      PCstPerc:=Listacstperc[p];
//      if (Pcstperc.cst=cst) and (Pcstperc.perc=perc) and (Pcstperc.cfop=cfop) then begin
// 04.03.08 - somente por aliquota e cfop...
      if (Pcstperc.perc=perc) and (Pcstperc.cfop=cfop) then begin
        result:=p;
        break
      end;
    end;
  end;
end;

//////////////////////////////////////////////////////////////////////
function TFGeral.BuscaTransacao(Numero, Tabela,
  campo: string ; campostatus:string='' ; status:string='' ; campoordem:string='' ; campotipomov:string='' ; xtipomov:string='' ): String;
//////////////////////////////////////////////////////////////////////
begin
  if trim(campotipomov)<>'' then
    result:='select * from '+tabela+' where '+campo+' = '+Stringtosql(Numero)+' and '+
             FGeral.GetIN(campotipomov,xtipomov,'C')
  else
    result:='select * from '+tabela+' where '+campo+' = '+Stringtosql(Numero);
  if (trim(campostatus)<>'') and (trim(status)<>'') then begin
//    result:='select * from '+tabela+' where '+campo+' = '+Stringtosql(Numero)+' and '+campostatus+' = '+stringtosql(status);
    result:='select * from '+tabela+' where '+campo+' = '+Stringtosql(Numero)+' and '+
             FGeral.Getin(campostatus,status,'C');
    if trim(campotipomov)<>'' then
      result:='select * from '+tabela+' where '+campo+' = '+Stringtosql(Numero)+' and '+
             FGeral.Getin(campostatus,status,'C')+' and '+
             FGeral.GetIN(campotipomov,xtipomov,'C') ;
  end;
  if trim(campoordem)<>'' then
    result:=result+' order by '+campoordem;
end;

///////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaItensNFSaida(Emissao: TDatetime; Cliente: TSqlEd;
///////////////////////////////////////////////////////////////////////////////////////////
  Representante: integer; Unidade, TipoMovimento, Transacao: string;
  Numero: Integer; Grid: TSqlDtGrid ; frete , seguro, peracre , perdesco :currency ; Movimento : TDatetime  ; remessas:string='' ;
  status:string='N' ; Pedido:integer=0 ; moes_clie_codigo:integer=0  ;cfop:string=''  ; Consfinal:string='S' ;
  CodigoMov:integer=0 ; rtipocad:string='C' ; xPedidos:string='');

var linha,p:integer;
    codigograde,codigolinha,codigocoluna,xcodcor,xcodtamanho,xcodcopa:integer;
    venda,qtde,reducao,isentas,outras,base,basesubs,valorcontabil,icmssubs,margemlucro,totalitem,
    icmsitem,totalbaseicms,ipiitem,qtdeenviada:currency;
    devolucoes,cfopx,consfinalx,cfopind,xsqlcor,xsqltamanho,xsqlcopa,sqlcorped,
    sqltamanhoped,TiposDevolucao:string;
    QSubgrupo,TEstoque,QIpi,Qconfmov,TEstoqueQtde,QtdeEstoqueGrade,QCusto,
    QMovser,QPedido:TSqlquery;
    prim:boolean;
    Campo:TDicionario;
    Lista:TStringlist;

// 05.12.07
    procedure BaixaMateriaPrima;
    //////////////////////////
    var xTipoMovimento,xTipocad,sqlcor,sqltamanho,sqlcopa:string;
        novocusto,novocustomedio:currency;
        QCustoMat,QEst:TSqlquery;
    begin
          xTipoMovimento:=Global.CodBaixaMatSai;
//          xTipoCad:='X';  // 19.12.07 - pq esse X ?/
          xTipoCad:='C';
          if strtointdef(Grid.cells[Grid.getcolumn('codcor'),linha],0)>0 then
            sqlcor:=' and cust_core_codigo='+Grid.cells[Grid.getcolumn('codcor'),linha]
          else
            sqlcor:=' and cust_core_codigo=0';
          if strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),linha],0)>0 then
            sqltamanho:=' and cust_tama_codigo='+Grid.cells[Grid.getcolumn('codtamanho'),linha]
          else
            sqltamanho:=' and cust_tama_codigo=0';
          if strtointdef(Grid.cells[Grid.getcolumn('codcopa'),linha],0)>0 then
            sqlcopa:=' and cust_copa_codigo='+Grid.cells[Grid.getcolumn('codcopa'),linha]
          else
            sqlcopa:=' and cust_copa_codigo=0';
          QCusto:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
                  ' inner join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Global.CodigoUnidade)+' )'+
                  ' where cust_status=''N'' and cust_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                   sqlcor+sqltamanho+sqlcopa+' order by cust_esto_codigomat');
          while (not QCusto.eof)  do begin
              if prim then begin
                Sistema.Insert('Movesto');
                Sistema.SetField('moes_transacao',Transacao);
                Sistema.SetField('moes_operacao',GetOperacao);
                Sistema.SetField('moes_status','N');
//                Sistema.SetField('moes_numerodoc',100+numero);
                Sistema.SetField('moes_numerodoc',numero*10);
                Sistema.SetField('moes_tipomov',xTipoMovimento);
                Sistema.SetField('moes_comv_codigo',0);
                Sistema.SetField('moes_unid_codigo',Unidade);
            //    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
                Sistema.SetField('moes_tipo_codigo',cliente.AsInteger);
                if xtipocad='F' then begin
                  Sistema.SetField('moes_estado',Cliente.ResultFind.fieldbyname('forn_uf').AsString);
                  Sistema.SetField('moes_cida_codigo',Cliente.ResultFind.fieldbyname('forn_cida_codigo').AsInteger);
                end else begin
                  Sistema.SetField('moes_estado',Cliente.ResultFind.fieldbyname('clie_uf').AsString);
                  Sistema.SetField('moes_cida_codigo',Cliente.ResultFind.fieldbyname('clie_cida_codigo_res').AsInteger);
                end;
                Sistema.SetField('moes_tipocad',xtipocad);
                Sistema.SetField('moes_datalcto',Sistema.Hoje);
                Sistema.SetField('moes_dataemissao',Sistema.Hoje);
                Sistema.SetField('moes_datamvto',Emissao);
                Sistema.SetField('moes_DataCont',Movimento);
                Sistema.SetField('moes_vlrtotal',0);
                Sistema.SetField('moes_baseicms',0);
                Sistema.SetField('moes_valoricms',0);
                Sistema.SetField('moes_basesubstrib',0);
                Sistema.SetField('moes_valoricmssutr',0);
                Sistema.SetField('moes_totprod',0);
                Sistema.SetField('moes_vlrtotal',0);
                Sistema.SetField('moes_valortotal',0);
                Sistema.SetField('moes_natf_codigo','');
                Sistema.SetField('moes_freteciffob','');
                Sistema.SetField('moes_frete',0);
  //              Sistema.SetField('moes_vispra',FCondPagto.GetAvPz(Condicao));
                Sistema.SetField('moes_especie',Arq.TConfmovimento.fieldbyname('comv_especie').asstring);
                Sistema.SetField('moes_serie',Arq.TConfmovimento.fieldbyname('comv_serie').asstring);
                Sistema.SetField('moes_tran_codigo',Arq.TTransp.fieldbyname('tran_codigo').asstring);
                Sistema.SetField('Moes_Perdesco',0);
                Sistema.SetField('Moes_Peracres',0);
                Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
                Sistema.SetField('moes_pedido',Pedido);
                Sistema.SetField('moes_tipo_codigoind',Cliente.AsInteger);   //  27.07.06
                Sistema.Post;
                prim:=false;
              end;
              Sistema.Insert('Movestoque');
              Sistema.SetField('move_esto_codigo',QCusto.fieldbyname('cust_esto_codigomat').asstring);
              Sistema.SetField('move_tama_codigo',QCusto.fieldbyname('cust_tama_codigomat').asinteger);
              Sistema.SetField('move_core_codigo',QCusto.fieldbyname('cust_core_codigomat').asinteger);
              Sistema.SetField('move_copa_codigo',QCusto.fieldbyname('cust_copa_codigo').asinteger);
              Sistema.SetField('move_transacao',transacao);
              Sistema.SetField('move_operacao',FGeral.GetOperacao);
//              Sistema.SetField('move_numerodoc',100+numero);
              Sistema.SetField('move_numerodoc',numero*10);
              Sistema.SetField('move_status','N');
              Sistema.SetField('move_tipomov',xTipoMovimento);
              Sistema.SetField('move_unid_codigo',Unidade);
              Sistema.SetField('move_tipo_codigo',Cliente.AsInteger);
              Sistema.SetField('move_tipocad',xTipocad);
              novocusto:=0;
              novocustomedio:=0;           // 16.05.16  "invalid float point operation"
              if (Global.Topicos[1308]) and (Qcusto.fieldbyname('cust_perqtde').ascurrency>0) then begin
                novocusto:=totalitem*(Qcusto.fieldbyname('cust_percusto').ascurrency/100) / (texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100));
                Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100));
                Sistema.SetField('move_custo',novocusto );
                Sistema.SetField('move_custoger',novocusto);
                Sistema.SetField('move_venda',novocusto);
              end else begin
                Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency);
              end;
              Sistema.SetField('move_datacont',Movimento);
//              end else begin
//                Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('qtdeprev'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency);
//                Sistema.SetField('move_venda',??);
//              end;
              Sistema.SetField('move_pecas',texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency );
              Sistema.SetField('move_datalcto',Sistema.Hoje);
              Sistema.SetField('move_datamvto',Emissao);
              Sistema.SetField('move_qtderetorno',0);
              QCustoMat:=sqltoquery( FEstoque.Getsqlcustos(QCusto.fieldbyname('cust_esto_codigomat').asstring,Global.CodigoUnidade,
                          QCusto.fieldbyname('cust_tama_codigomat').asinteger,QCusto.fieldbyname('cust_core_codigomat').asinteger) );
              if (not QCustoMat.eof) and ( not Global.Topicos[1308] ) then begin
                Sistema.SetField('move_custo',QCustomat.fieldbyname('custo').ascurrency);
                Sistema.SetField('move_custoger',QCustomat.fieldbyname('custoger').ascurrency);
                Sistema.SetField('move_customedio',QCustomat.fieldbyname('customedio').ascurrency);
                Sistema.SetField('move_customeger',QCustomat.fieldbyname('customeger').ascurrency);
                Sistema.SetField('move_venda',QCustomat.fieldbyname('customeger').ascurrency);
              end;
              FGeral.Fechaquery(QCustomat);
              Sistema.SetField('move_cst','');
              Sistema.SetField('move_aliicms',0);
              QEst:=sqltoquery('select esto_grup_codigo,esto_sugr_codigo,esto_fami_codigo,esqt_qtde,esqt_qtdeprev,esqt_pecas from estoque'+
                               ' inner join estoqueqtde on ( esto_codigo=esqt_esto_codigo )'+
                               ' where esto_codigo='+stringtosql(QCusto.fieldbyname('cust_esto_codigomat').asstring)+
                               ' and esqt_status=''N'' and esqt_unid_codigo='+Stringtosql(unidade) );
              if not QEst.eof then begin
                Sistema.SetField('move_grup_codigo',QEst.FieldByName('esto_grup_codigo').AsInteger);
                Sistema.SetField('move_sugr_codigo',QEst.fieldbyname('esto_sugr_codigo').AsInteger);
                Sistema.SetField('move_fami_codigo',QEst.fieldbyname('esto_fami_codigo').AsInteger);
              end;
              Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
              Sistema.SetField('move_aliipi',0);
              Sistema.SetField('move_tipo_codigoind',Cliente.AsInteger);   //  27.07.06
              Sistema.Post;
// 02.06.12 - Benato - retirado em 20.09.12 pois s� comita no final da transacao s� baixando 'o �ltimo'...
//              FGeral.MovimentaQtdeEstoque(QCusto.fieldbyname('cust_esto_codigomat').asstring,
//                                          Unidade,'S',xTipoMovimento,
//                                          texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency,
//                                          QEst,
//                                          texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency,
//                                          texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency );
              FGeral.Fechaquery(QEst);
///////////////////////////
            QCusto.next;
          end; // percorre planilha de custos
          FGeral.Fechaquery(QCusto);

    end;

/////////////////////////////////////
begin
/////////////////////////////////////

  if ListaCstPerc=nil then
     ListaCstPerc:=Tlist.create;
  ListaCstPerc.clear;
  Grid.Index(Grid.GetColumn('move_cst'));
  devolucoes:=Global.CodDevolucaoVenda+';'+Global.CodDevolucaoRoman+';'+global.CodDevolucaoConsigMerc+';'+Global.CodDevolucaoVendaConsig;
// 07.07.11
  TiposDevolucao:=Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemEstoque+';'+
                  Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoInd+';'+
                  Global.CodDevolucaoSimbolicaConsig+';'+
                  Global.CodDevolucaodeRemessa+';'+
                  Global.CodDevolucaoRoman;
// 15.06.05 - op��o de baixar o estoque somente na gravacao
//  if ( Global.Topicos[1201] ) and ( pos( TipoMovimento,Global.TiposMovMovEstoque ) > 0  ) then begin
//    Arq.TEstoqueqtde
//  end;
// 07.08.06
  cfopind:=cfop;
  if codigomov>0 then begin
      QConfmov:=sqltoquery('select * from confmov where comv_codigo='+inttostr(codigomov));
      if copy(cfop,1,1)='5' then
        cfopind:=QConfmov.fieldbyname('comv_natf_estadoipi').asstring
      else
        cfopind:=QConfmov.fieldbyname('comv_natf_foestadoipi').asstring;
      FGeral.Fechaquery(QConfmov);
  end;

  prim:=true;  // aqui em 05.12.07
  for linha:=1 to Grid.rowcount do begin
    if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha])<>'' then begin
      TEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );

//      Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([Unidade,Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]]),[]);
//        avisoerro('N�o encontrou o produto '+Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]+' na unidade '+unidade);
// 22.08.06
      TEstoqueqtde:=sqltoquery('select * from estoqueqtde where esqt_status=''N'' and esqt_unid_codigo='+stringtosql(UNidade)+
                               ' and esqt_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );
      xcodcor:=strtointdef(Grid.Cells[Grid.getcolumn('codcor'),linha],0);
      xcodtamanho:=strtointdef(Grid.Cells[Grid.getcolumn('codtamanho'),linha],0);
      xsqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
      xsqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
      if (xcodcor>0) and (xcodtamanho>0) and (xcodcopa>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
          xsqlcopa:=' and esgr_copa_codigo='+inttostr(xcodcopa);
      end else if (xcodcor>0) and (xcodtamanho>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
      end else if (xcodcor>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
      end else if (xcodtamanho>0) then begin
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
      end;
      QtdeEstoqueGrade:=sqltoquery('select * from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
            ' and esgr_unid_codigo='+Stringtosql(Unidade)+
            xsqlcor+xsqltamanho+xsqlcopa );
//            ' and esgr_core_codigo='+Stringtosql(Grid.Cells[Grid.getcolumn('codcor'),linha])+
//            ' and esgr_tama_codigo='+Stringtosql(Grid.Cells[Grid.getcolumn('codtamanho'),linha])+
//            ' and ( esgr_copa_codigo='+Stringtosql(Grid.Cells[Grid.getcolumn('codcopa'),linha])+' or esgr_copa_codigo is null )' );
/////////////////
//      codigograde:=FEstoque.GetCodigoGrade(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha]);

      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha]);
// 17.08.06
      Sistema.SetField('move_tama_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codtamanho'),linha],0));
      Sistema.SetField('move_core_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codcor'),linha],0));
      Sistema.SetField('move_copa_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codcopa'),linha],0));
/////////////
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',numero);
//      Sistema.SetField('move_status','N');
// 20.08.05
      Sistema.SetField('move_status',status);
      Sistema.SetField('move_tipomov',TipoMovimento);
      Sistema.SetField('move_unid_codigo',Unidade);
      Sistema.SetField('move_tipo_codigo',Cliente.AsInteger);
//      if pos(Tipomovimento,global.coddevolucaocompra+';'+global.coddevolucaocompraSemestoque+';'+
//        Global.CodRemessaConserto+';'+Global.CodDevolucaoSaida)>0 then begin
// 29.08.08
      if rtipocad='F' then begin      
        Sistema.SetField('move_tipocad','F');
      end else begin
        Sistema.SetField('move_tipocad','C');
        Sistema.SetField('move_repr_codigo',Representante);
      end;
      Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datacont',Movimento);
// 09/09/05 - para sair no relat. de auditoria no 'dia da digitacao'
      if TipoMovimento=Global.codvendaambulante then
        Sistema.SetField('move_datamvto',Movimento)
      else
        Sistema.SetField('move_datamvto',Emissao);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_custo',TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
      Sistema.SetField('move_custoger',TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
      Sistema.SetField('move_customedio',TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
      Sistema.SetField('move_customeger',TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
      Sistema.SetField('move_cst',Grid.Cells[grid.getcolumn('move_cst'),linha]);
      Sistema.SetField('move_aliicms',texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha]));
      Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
      Sistema.SetField('move_grup_codigo',TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_perdesco',texttovalor(Grid.Cells[grid.getcolumn('move_perdesco'),linha]));
      Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('move_vendabru'),linha]));
// 02.01.06
      if trim(Grid.Cells[Grid.getcolumn('move_remessas'),linha])<>'' then
        Sistema.SetField('move_remessas',Grid.Cells[Grid.getcolumn('move_remessas'),linha])
      else
// 16.05.05
        Sistema.SetField('move_remessas',remessas);
// 12.07.05
      if moes_clie_codigo=0 then   // 30.12.05
        Sistema.SetField('move_clie_codigo',Cliente.AsInteger)
      else if moes_clie_codigo>0 then   // 30.12.05
        Sistema.SetField('move_clie_codigo',moes_clie_codigo);
// 28.08.06
      Sistema.SetField('move_aliipi',texttovalor(Grid.Cells[grid.getcolumn('move_aliipi'),linha]));
// 08.05.07
      Sistema.SetField('move_pecas',texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha]));
// 30.05.07
      Sistema.SetField('move_vendamin',texttovalor(Grid.Cells[grid.getcolumn('move_vendamin'),linha]));
// 19.06.07
      Sistema.SetField('move_redubase',texttovalor(Grid.Cells[grid.getcolumn('move_redubase'),linha]));
// 19.12.07
      Sistema.SetField('move_nroobra',inttostr(numero));
      if Global.Topicos[1326] then
// 23.12.08
        Sistema.SetField('move_certificado',Grid.Cells[grid.getcolumn('move_certificado'),linha]);
// 13.07.09
      if (TipoMovimento=Global.CodRemessaInd) then begin
        campo:=Sistema.GetDicionario('movestoque','move_core_codigoind');
        if campo.Tipo<>'' then
          Sistema.SetField('move_core_codigoind',strtointdef(Grid.Cells[Grid.getcolumn('move_core_codigoind'),linha],0));
      end;
// 08.09.10
      if trim(Grid.Cells[grid.getcolumn('move_natf_codigo'),linha])<>'' then begin
        campo:=Sistema.GetDicionario('movestoque','move_natf_codigo');
        if campo.Tipo<>'' then
          Sistema.SetField('move_natf_codigo',Grid.Cells[Grid.getcolumn('move_natf_codigo'),linha] );
      end;
// 09.10.13 - Patoterra - para gravar o equipamento nas saidas
      if global.topicos[1367] then
        Sistema.SetField('move_remessas',Grid.Cells[Grid.getcolumn('move_operacao'),linha])
      else
// 03.09.14 - Vivan - para guardar os pedidos faturados nesta nota
        Sistema.SetField('move_remessas',xPedidos);
      Sistema.Post('');

//      Sistema.Edit('estoqueqtde');
//      Sistema.Setfield('esqt_dtultvenda',Emissao);
// 13.06.05 - op��o de baixar o estoque somente na gravacao
      if ( Global.Topicos[1201] ) and ( pos( TipoMovimento,Global.TiposMovMovEstoque ) > 0  ) then begin
        Sistema.Edit('Estoqueqtde');
        if pos(TipoMovimento,devolucoes)>0 then begin
          Sistema.Setfield('esqt_qtdeprev',TEstoqueqtde.fieldbyname('esqt_qtdeprev').ascurrency+texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
          Sistema.Setfield('esqt_qtde',TEstoqueqtde.fieldbyname('esqt_qtde').ascurrency+texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
          Sistema.Setfield('esqt_pecas',TEstoqueqtde.fieldbyname('esqt_pecas').ascurrency+texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha]));
        end else begin
          Sistema.Setfield('esqt_qtdeprev',TEstoqueqtde.fieldbyname('esqt_qtdeprev').ascurrency-texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
          Sistema.Setfield('esqt_qtde',TEstoqueqtde.fieldbyname('esqt_qtde').ascurrency-texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
          Sistema.Setfield('esqt_pecas',TEstoqueqtde.fieldbyname('esqt_pecas').ascurrency-texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha]));
        end;
        Sistema.Setfield('esqt_dtultvenda',Emissao);
      end else begin
        Sistema.Edit('Estoqueqtde');
        Sistema.Setfield('esqt_dtultvenda',Emissao);
      end;
      Sistema.Post('esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Unidade)+' and esqt_esto_codigo='+
                     stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );
// 21.08.06
      FGeral.MovimentaQtdeEstoqueGrade(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha],
                unidade,'S',TipoMovimento,
                strtointdef(Grid.Cells[Grid.getcolumn('codcor'),linha],0),
                strtointdef(Grid.Cells[Grid.getcolumn('codtamanho'),linha],0),
                strtointdef(Grid.Cells[Grid.getcolumn('codcopa'),linha],0),
                texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]),QtdeEstoqueGrade );
/////////////////////////////////////////////////////////////////////////////////////////////
// 05.12.07
//      if ( pos( TipoMovimento,global.CodVendaDireta )>0 ) and ( Global.Topicos[1311] ) then
// 28.02.08
      if ( pos( TipoMovimento,global.CodVendaDireta )>0 ) and ( Global.Topicos[1311] )  and (TEstoque.fieldbyname('esto_baixavenda').asstring<>'N') then
        BaixaMateriaPrima;
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////
// 20.10.05 - baixa de itens do pedido de venda
// quando colocar a cor e tamanho na nf dai baixar tbem pela cor e tamanho
/////////////////////////////////////////////////////////////////////////////
// 22.04.09 - colocado op��o de cor e tamanho na nota de saida
//      if (Pedido>0 then begin
// 27.01.10 - contratos VX com numero grande da erro no mpdd_nfvenda
// 20.07.16 - para ver se para de 'nao baixar pedidos' em devereda e giacomoni
      if (Pedido>0) and (Numero<=9999999) and ( not Global.Topicos[1322] )  then begin
          sqlcorped:=' and ( mpdd_core_codigo=0 or mpdd_core_codigo is null )';
          sqltamanhoped:=' and ( mpdd_tama_codigo=0 or mpdd_tama_codigo is null )';
          if (xcodcor>0) and (xcodtamanho>0) then begin
              sqlcorped:=' and mpdd_core_codigo='+inttostr(xcodcor);
              sqltamanhoped:=' and mpdd_tama_codigo='+inttostr(xcodtamanho);
          end else if (xcodcor>0) then begin
              sqlcorped:=' and mpdd_core_codigo='+inttostr(xcodcor);
          end else if (xcodtamanho>0) then begin
              sqltamanhoped:=' and mpdd_tama_codigo='+inttostr(xcodtamanho);
          end;
// 22.04.13
         qtdeenviada:=0;
         if Global.Usuario.OutrosAcessos[0335] then begin
           QPedido:=Sqltoquery('select mpdd_qtdeenviada from movpeddet where mpdd_numerodoc='+inttostr(Pedido)+
             ' and mpdd_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
             ' and mpdd_status=''N'''+  //  'and mpdd_tipomov='+stringtosql('PV')+
             sqlcorped+sqltamanhoped+
             ' and '+FGeral.GetIN('mpdd_situacao','P;E;B','C') );
           if not Qpedido.eof then
             qtdeenviada:=QPedido.fieldbyname('mpdd_qtdeenviada').ascurrency;
         end;
         Sistema.Edit('movpeddet');
         Sistema.setfield('mpdd_situacao','E');
         Sistema.setfield('mpdd_qtdeenviada',qtdeenviada + texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
         Sistema.setfield('mpdd_dataenviada',emissao);
         Sistema.setfield('mpdd_nfvenda',numero);
         Sistema.setfield('mpdd_datanfvenda',emissao);
         Sistema.post('mpdd_numerodoc='+inttostr(Pedido)+' and mpdd_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
            ' and mpdd_status=''N'''+  //  'and mpdd_tipomov='+stringtosql('PV')+
            sqlcorped+sqltamanhoped+
            ' and '+FGeral.GetIN('mpdd_situacao','P;E;B','C') );
         FechaQuery(QPedido);
      end;
/////////////////////////////////////////////////////////////
      reducao:=0;isentas:=0;outras:=0;
      venda:=texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]);
      qtde:=texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]);
      totalitem:=FGeral.Arredonda(venda*qtde,2);
      if Peracre>0 then begin
        totalitem:=totalitem+FGEral.Arredonda( totalitem*(Peracre/100) ,2  );
      end else if Perdesco>0 then begin
        totalitem:=totalitem-FGEral.Arredonda( totalitem*(Perdesco/100) ,2 );
      end;
      ipiitem:=totalitem*(texttovalor(Grid.Cells[grid.getcolumn('move_aliipi'),linha])/100);
// 23.05.07
      totalbaseicms:=totalitem - ( totalitem*(texttovalor(Grid.Cells[grid.getcolumn('move_redubase'),linha])/100));
// 07.07.11 - Clessi - devolucao de mat. uso e consumo
      if ( Global.Topicos[1350] ) and ( pos(TipoMovimento,TiposDevolucao)>0 ) then
        totalbaseicms:=totalitem + ipiitem ;

      reducao:=texttovalor(Grid.Cells[grid.getcolumn('move_redubase'),linha]);

      icmsitem:=totalbaseicms*( texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha])/100 );
      ValorContabil:=totalitem;
      Base:=totalitem;
// 07.07.11 - Clessi - devolucao de mat. uso e consumo
      if ( Global.Topicos[1350] ) and ( pos(TipoMovimento,TiposDevolucao)>0 ) then
        base:=totalitem+ipiitem;
// 28.06.05
      if TipoMovimento=Global.CodVendaConsigMercantil then begin
        icmsitem:=0;
      end;
///////////
// 28.06.05
      if TipoMovimento=Global.CodVendaConsigMercantil then
        base:=0;
/////////////
// 08.09.05 - 12.08.08 + RI
//      if pos(Tipomovimento,global.coddevolucaocompra+';'+global.coddevolucaocompraSemestoque+';'+
//            Global.CodRemessaConserto+';'+Global.CodRemessaDemo+';'+';'+Global.CodDevolucaoSaida+';'+Global.CodRemessaInd)>0 then
// 03.12.08
      if rtipocad='F' then
        margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],Unidade,Cliente.resultfind.fieldbyname('forn_uf').asstring))
      else
        margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],Unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring));
      if Margemlucro>0 then begin
        basesubs:=base*(1+(margemlucro/100));
        icmssubs:=basesubs*( texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha])/100 );
        icmssubs:=icmssubs-icmsitem;
      end else begin
        basesubs:=0;
        icmssubs:=0;
      end;
      valorcontabil:=valorcontabil+icmssubs;
// 17.04.07 - retorna a base para gravar certo a base do icms para depois ir por sintegra ok
      if TipoMovimento=Global.CodVendaConsigMercantil then
        base:=totalitem;
////////////////////////////

// 17.11.04 - isento de icms
      if base=0 then begin
        outras:=valorcontabil;
        if TipoMovimento<>Global.CodVendaConsigMercantil then   // 30.06.05
           base:=valorcontabil;
      end;
      if basesubs>0 then
        outras:=icmssubs;
      if movimento>1 then begin
// 27.06.11
         if (CodigoMov=FGeral.GetConfig1Asinteger('ConfNfComple')) and
            ( FGeral.GetConfig1Asinteger('ConfNfComple')>0 )
          OR
            (TipoMovimento=Global.codnfecomplementoqtde  )
         then begin
//              base:=0; base nao zera pra poder calcular o icms na gravacao do movbase abaixo
              basesubs:=0;   // inclusive a nf de complement so podera ter um item
              reducao:=0;
              valorcontabil:=0;
         end;
//////////////
// 31.07.06
        cfopx:=cfop;
        consfinalx:=consfinal;
//        if consfinalx='R' then begin
// 15.03.10 - se revenda e sem ipi...
        if (consfinalx='R') and (TEstoque.fieldbyname('esto_cipi_codigo').asinteger=0) then begin
          QSubgrupo:=sqltoquery('select * from subgrupos where sugr_codigo='+TEstoque.fieldbyname('esto_sugr_codigo').Asstring);
          if not QSubgrupo.eof then begin
            if copy(cfop,1,1)='5' then
              cfopx:=QSubgrupo.fieldbyname('sugr_natf_codigoes').asstring
            else
              cfopx:=QSubgrupo.fieldbyname('sugr_natf_codigofo').asstring;
            if trim(cfopx)='' then
              cfopx:=cfop;
          end;
          FGeral.Fechaquery(QSubgrupo);

        end else begin   // 07.08.06

          if TEstoque.fieldbyname('esto_cipi_codigo').asinteger>0 then begin
            QIpi:=sqltoquery('select * from codigosipi where cipi_codigo='+TEstoque.fieldbyname('esto_cipi_codigo').asString);
            if not QIpi.eof then begin
              cfopx:=cfopind;
// 19.03.10 - Asatec
             campo:=Sistema.GetDicionario('codigosipi','cipi_fabricap');
             if campo.Tipo<>'' then begin
               if QIPI.fieldbyname('cipi_fabricap').asstring='S' then
                cfopx:=cfopind
               else
                cfopx:=cfop;
             end;
// 22.11.11 - senao ficam 'sem cfop por item' - Bavi alguns com 5405
// se na tributacao estiver preenchido vale ele senao fica o tratamento 'de industria
              if ( trim(Grid.Cells[grid.getcolumn('move_natf_codigo'),linha])<>'' )
                 then begin
                cfopx:=Grid.Cells[Grid.getcolumn('move_natf_codigo'),linha] ;
              end;
            end;
            if trim(cfopx)='' then
              cfopx:=cfop;
            FGeral.Fechaquery(QIpi);
          end else begin
// 08.09.10
            if trim(Grid.Cells[grid.getcolumn('move_natf_codigo'),linha])<>'' then begin
               cfopx:=Grid.Cells[Grid.getcolumn('move_natf_codigo'),linha] ;
            end;
          end;
        end;
// 07.03.08
        if TipoMovimento<>Global.CodContrato then begin
// 11.02.10 - gravar base separada para o iss
          if FCodigosFiscais.GetQualImposto( TEstoqueqtde.fieldbyname('esqt_cfis_codigoest').AsString )='S' then begin
// 15.12.11 - lan�ar nota de servico serie F na mesma opcao de nf modelo 1
            if trim(fGeral.GetConfig1AsString('ConfMovSer')) <> '' then
              QMovser:=sqltoquery('select * from confmov where comv_codigo='+FGeral.GetConfig1AsString('ConfMovSer'))
            else
              QMovser:=sqltoquery('select * from confmov where comv_codigo='+inttostr(codigomov) );
            if copy(cfopx,1,1)='5' then
              cfopx:= QMovSer.fieldbyname('Comv_natf_estado').asstring
            else
              cfopx:= QMovSer.fieldbyname('Comv_natf_foestado').asstring;
            FGeral.GeraListaCstPerc(Grid.Cells[grid.getcolumn('move_cst'),linha],
                   FEstoque.GetaliquotaIss(TEstoqueqtde.fieldbyname('esqt_esto_codigo').AsString,Unidade,Global.UFUnidade),
                       valorcontabil,base,reducao,isentas,outras,basesubs,ListaCstPerc,'S',cfopx);
            FGeral.FechaQuery(QMovser);
          end else
            FGeral.GeraListaCstPerc(Grid.Cells[grid.getcolumn('move_cst'),linha],texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha]),
                       valorcontabil,base,reducao,isentas,outras,basesubs,ListaCstPerc,'I',cfopx);
        end;
      end;
      FGeral.Fechaquery(TEstoque);
      FGeral.Fechaquery(TEstoqueQtde);
      FGeral.Fechaquery(QtdeEstoqueGrade);
    end;
  end; // ref. ao grid

// 20.10.05 - baixa mestre do pedido de venda - rever... somente quando tiver a grade
/////////////////////////////////////////////////
// 22.04.09 - rever se baixa o 'mestre' do pedido devido do caso de faturar parte do pedido
// 15.03.10 - grava a numero e transacacao da nota de venda
///////////////////////////////////////////////////////////////
  if (Pedido>0) and ( Pedido<9999999 ) then begin
         Sistema.Edit('movped');
         Sistema.setfield('mped_situacao','E');
         Sistema.setfield('mped_nfvenda',numero);
         Sistema.setfield('mped_datanfvenda',emissao);
         Sistema.setfield('mped_transacaovenda',transacao);
         Sistema.post('mped_numerodoc='+inttostr(Pedido)+' and mped_situacao=''P'''+
                      ' and mped_status=''N'''+
                      ' and mped_unid_codigo='+Stringtosql(Unidade) );
//                       and mped_tipomov='+stringtosql('PV') );
  end;
// 12.04.10
  if trim(xPedidos)<>'' then begin
    Lista:=TStringlist.create;
    strtolista(lista,xpedidos,';',true);
    for linha:=0 to Lista.count-1 do begin
      if ( strtointdef(lista[linha],0)>0 ) and ( strtointdef(lista[linha],0)<>Pedido ) then begin
         Sistema.Edit('movped');
         Sistema.setfield('mped_situacao','E');
         Sistema.setfield('mped_nfvenda',numero);
         Sistema.setfield('mped_datanfvenda',emissao);
         Sistema.setfield('mped_transacaovenda',transacao);
         Sistema.post('mped_numerodoc='+lista[linha]+' and mped_situacao=''P'''+
                      ' and mped_status=''N'''+
                      ' and mped_unid_codigo='+Stringtosql(Unidade) );
      end;
    end;
    Lista.free;
  end;

///////////////////////////////////////////////////////////////////

  for p:=0 to ListaCstPerc.Count-1 do begin
        PCstPerc:=Listacstperc[p];
        Sistema.Insert('MovBase');
        Sistema.SetField('movb_transacao',Transacao);
        Sistema.SetField('movb_operacao',GetOperacao);
        Sistema.SetField('movb_status','N');
        Sistema.SetField('movb_numerodoc',Numero);
        Sistema.SetField('Movb_cst',Pcstperc.cst);
///        Sistema.SetField('Movb_Codigosfis',     'Simb',  talvez nao precise pois ja gravo o % icms

//        Sistema.SetField('Movb_TpImposto','I');   // fixo I-Icms
// 13.07.06
            Sistema.SetField('Movb_TpImposto',Pcstperc.tpimposto );
  // codigo de valores fiscais ( 1,,5 da impressao do livro fiscal )
//        Sistema.SetField('Movb_CVF',cvf);    // checar - talvez nao precise
// ver como somar o frete + seguro no valor contabil agora o somente na gera��o para o livro fiscal
        if (CodigoMov=FGeral.GetConfig1Asinteger('ConfNfComple')) and
                ( FGeral.GetConfig1Asinteger('ConfNfComple')>0 ) then
          Sistema.SetField('Movb_BaseCalculo',0)
        else if p=0 then
          Sistema.SetField('Movb_BaseCalculo',Pcstperc.base+frete+seguro)
        else
          Sistema.SetField('Movb_BaseCalculo',Pcstperc.base);
        Sistema.SetField('Movb_Aliquota',pcstperc.perc);
        Sistema.SetField('Movb_ReducaoBc',pcstperc.reducao);
//        Sistema.SetField('Movb_Imposto',FGeral.Arredonda(pcstperc.base*(pcstperc.perc/100),2) );
// 23.05.07 - 19.08.09 - arrumado a cagada - so calc. icms com reducao de base
        if pcstperc.reducao>0 then
          Sistema.SetField('Movb_Imposto',FGeral.Arredonda( (( pcstperc.base*(pcstperc.reducao/100) ) ) * (pcstperc.perc/100),2) )
        else
          Sistema.SetField('Movb_Imposto',FGeral.Arredonda(pcstperc.base*(pcstperc.perc/100),2) );
        Sistema.SetField('Movb_Isentas',pcstperc.isentas);
        Sistema.SetField('Movb_Outras' ,pcstperc.outras);
        Sistema.SetField('Movb_tipomov',TipoMovimento);
        Sistema.SetField('Movb_unid_codigo',Unidade);  // 13.07.06
        Sistema.SetField('Movb_natf_codigo',pcstperc.cfop);   //   01.08.06

        Sistema.Post();
  end;

end;

////////////////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaMestreNFSaida(Emissao,Saida: TDatetime; Cliente: TSqlEd;
////////////////////////////////////////////////////////////////////////////////////////////
  Representante: integer; Unidade, TipoMovimento, Transacao, Condicao, Natureza, ciffob,Especievolume: string;
  Numero,CodigoMov,QTdevolumes: Integer; Valortotal,baseicms,valoricms,basesubs,icmssubs,vlrfrete: currency; Tabela: Integer ;
  Movimento : TDatetime ; ValorProd,peracre,perdesco : currency ; romaneio:integer ; valoravista:currency ; remessas:string='' ; status:string='N'
  ; Mensagem:string='' ; Pedido:integer=0 ; tran_codigo:string='' ; Pesoliq:currency=0 ; Pesobru:currency=0 ; moes_clie_codigo:integer=0 ;
  Valoripi:currency=0 ;Freteuni:currency=0 ; portoorigem:string='' ; portodestino:string='' ; container:string='' ;
  Representante2: integer=0  ; TiposFornec:string='' ; ValorServicos:currency=0 ; PercIss:currency=0 ; ValorIss:currency=0 ;
  ValorFunrural:currency=0 ; PerComissao:currency=0 ;  PerComissao2:currency=0 ;  MargemLucro:currency=0 ;
  UfEmbarque:string='' ; ChaveNfeacom:string=''  ; ValorCotaCapital:currency=0  ; xColaborador:string='' ;
  xvlroutrasdespesas:currency=0 ; xNomeObra:string='' ; carga:integer=0);

Var Q,QUnidade:TSqlquery;
    Especie,serie,mensagemfixa,TipoSaidaAbate,MensagemCliente,TransacaoContax,clifor,tipocad,campos,valores:string;
    posmsgcliente,debito,credito:integer;

//////////////////////////////////////////////////////// - retirado em 20.11.16
  {
    procedure Atualizalog(xtransacao:string;xusuario,codigolog:integer;emissao:Tdatetime);
    ////////////////////////////////////////////////
    begin
       Sistema.Edit('log');
       Sistema.SetField('log_transacaocanc',xtransacao);
       Sistema.SetField('log_usua_canc',xusuario);
       Sistema.Post('log_codigo='+inttostr(codigolog)+' and log_data='+DAtetosql(emissao)+' and log_transacaocanc='+stringtosql(''))
    end;
    }
////////////////////////////////////////////////////////

begin
/////////////////////////////
    mensagemfixa:='';
    TipoSaidaAbate:='SA';
    MensagemCliente:=''; posmsgcliente:=0;  // 25.05.11
    QUnidade:=sqltoquery('select * from unidades where unid_codigo='+stringtosql(unidade));
    if (FGeral.getconfig1asinteger('MENSSIMPRS')>0)  and (Movimento>1)then begin
      if not QUnidade.eof then begin
        if (QUnidade.fieldbyname('unid_simples').asstring='S') and (QUnidade.fieldbyname('unid_uf').asstring='RS') then
          mensagemfixa:=FMensNotas.GetDescricao( FGeral.getconfig1asInteger('MENSSIMPRS') )+' '  ;
      end;
    end;
    if codigomov>0 then begin
      Q:=sqltoquery('select * from confmov where comv_codigo='+inttostr(codigomov));
      especie:=Q.fieldbyname('comv_especie').asstring;
      serie:=Q.fieldbyname('comv_serie').asstring;
      FGeral.Fechaquery(Q);
    end else begin
      especie:=Arq.TConfmovimento.fieldbyname('comv_especie').asstring;
      serie:=Arq.TConfmovimento.fieldbyname('comv_serie').asstring;
    end;
// 02.01.08 - devido a cada unidade ter uma especie diferente dentro da mesma config. de movimento
//    if trim(QUnidade.fieldbyname('unid_especie').asstring)<>'' then
// 11.02.2012 - NFe com Cupom Fiscal
    if trim(especie)='' then
      especie:=QUnidade.fieldbyname('unid_especie').asstring;
///////////
    Sistema.Insert('Movesto');
    Sistema.SetField('moes_transacao',Transacao);
    Sistema.SetField('moes_operacao',GetOperacao);
// 20.08.05
//    Sistema.SetField('moes_status','N');
    Sistema.SetField('moes_status',status);
    Sistema.SetField('moes_numerodoc',Numero);
    Sistema.SetField('moes_romaneio',Romaneio);
    Sistema.SetField('moes_tipomov',TipoMovimento);
    Sistema.SetField('moes_comv_codigo',codigomov);
    Sistema.SetField('moes_unid_codigo',Unidade);
    Sistema.SetField('moes_tipo_codigo',Cliente.AsInteger);
//    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
//    if Tipomovimento=Global.CodDevolucaoCompra then begin
// 09.11.05 - 12.08.08 + RI
    if pos(Tipomovimento,global.coddevolucaocompra+';'+global.coddevolucaocompraSemestoque+';'+Global.CodRemessaConserto+';'
      +Global.CodRemessaDemo+';'+Global.CodDevolucaoSaida+';'+Global.CodRemessaInd+';'+TiposFornec+';'
      +Global.CodNfeComplementoIcms)>0 then begin
      Sistema.SetField('moes_estado',Cliente.ResultFind.fieldbyname('forn_uf').AsString);
      Sistema.SetField('moes_tipocad','F');
      Sistema.SetField('moes_cida_codigo',Cliente.ResultFind.fieldbyname('forn_cida_codigo').AsInteger);
      tipocad:='F';
    end else begin
      tipocad:='C';
      Sistema.SetField('moes_estado',Cliente.ResultFind.fieldbyname('clie_uf').AsString);
      Sistema.SetField('moes_tipocad','C');
      Sistema.SetField('moes_repr_codigo',Representante);
      Sistema.SetField('moes_cida_codigo',Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger);
// 25.05.11 - Novi - vava
      posmsgcliente:=pos('NFE:',uppercase(Cliente.ResultFind.fieldbyname('clie_obs').AsString));
      if posmsgcliente>0 then
        MensagemCliente:=copy(Cliente.ResultFind.fieldbyname('clie_obs').AsString,posmsgcliente+5,200-posmsgcliente+5);
    end;
    Sistema.SetField('moes_datalcto',Sistema.Hoje);
// 31/08/05 - para sair no relat. de auditoria no 'dia da digitacao'
//    if TipoMovimento=Global.codvendaambulante then
//      Sistema.SetField('moes_datamvto',Movimento)
//    else
// 20.08.09 - data de saida da nota ( dos produtos )
// 27.11.09 -criado campo especifico para data de saida
    campo:=Sistema.GetDicionario('movesto','moes_datasaida');
    if Campo.Tipo<>'' then begin
      Sistema.SetField('moes_datasaida',Saida);
      Sistema.SetField('moes_datamvto',Emissao);
    end else
      Sistema.SetField('moes_datamvto',Emissao);
    Sistema.SetField('moes_DataCont',Movimento);
    Sistema.SetField('moes_dataemissao',Emissao);
    Sistema.SetField('moes_tabp_codigo',Tabela);
    Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
    Sistema.SetField('moes_natf_codigo',Natureza);
    Sistema.SetField('moes_freteciffob',ciffob);
    Sistema.SetField('moes_valoricms',valoricms);
    Sistema.SetField('moes_basesubstrib',basesubs);
    Sistema.SetField('moes_valoricmssutr',icmssubs);
    Sistema.SetField('moes_frete',vlrfrete);
    Sistema.SetField('moes_vispra',FCondPagto.GetAvPz(Condicao));
//    Sistema.SetField('moes_especie',Arq.TConfmovimento.fieldbyname('comv_especie').asstring);
    Sistema.SetField('moes_especie',especie);
//    Sistema.SetField('moes_serie',FGeral.Qualserie(Arq.TConfmovimento.fieldbyname('comv_serie').asstring,Global.serieunidade,tipomovimento));
    Sistema.SetField('moes_serie',FGeral.Qualserie(serie,Global.serieunidade,tipomovimento));
//    Sistema.SetField('moes_tran_codigo',Arq.TTransp.fieldbyname('tran_codigo').asstring);
// 26.10.05
    Sistema.SetField('moes_tran_codigo',tran_codigo);
    Sistema.SetField('Moes_qtdevolume',QTdevolumes);
    Sistema.SetField('Moes_especievolume',Especievolume);
    Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('Moes_Perdesco',perdesco);
    Sistema.SetField('Moes_Peracres',peracre);
// 16.05.05
    Sistema.SetField('moes_remessas',remessas);
// 01.09.05 - 28.06.06
    if trim(mensagemfixa)<>'' then
      Sistema.SetField('moes_mensagem',mensagemfixa+mensagem)
    else
      Sistema.SetField('moes_mensagem',trim(mensagem)+' '+MensagemCliente);
// 20.10.05
    Sistema.SetField('moes_pedido',pedido);
// 15.11.05
    Sistema.SetField('moes_pesoliq',pesoliq);
    Sistema.SetField('moes_pesobru',pesobru);
// 12.07.05
    if moes_clie_codigo=0 then   // 30,12,05
      Sistema.SetField('moes_clie_codigo',Cliente.AsInteger)
// 30.12.05
    else if moes_clie_codigo>0 then   // 30.12.05
      Sistema.SetField('moes_clie_codigo',moes_clie_codigo);
// 16.06.06
    Sistema.SetField('moes_fpgt_codigo',Condicao);
// 28.08.06
    Sistema.SetField('moes_valoripi',Valoripi);
// 28.09.06
    Sistema.SetField('moes_freteuni',Freteuni);
// 10.12.14 - Casa NOva - cuiaba
    if xnomeobra<>'' then begin
       Sistema.SetField('moes_nroobra',xnomeobra)
    end else begin
// 19.12.07
     if (TipoMovimento=Global.CodContrato) and (pedido>0) then
       Sistema.SetField('moes_nroobra',inttostr(pedido))
     else
       Sistema.SetField('moes_nroobra',inttostr(numero));
    end;
// 02.01.08
    Sistema.SetField('moes_embarque',portoorigem);
    Sistema.SetField('moes_destino',portodestino);
    Sistema.SetField('moes_container',container);
// 02.12.08 - > 21.08.10
//    if TipoMovimento=Global.CodContrato then begin
      Sistema.SetField('moes_repr_codigo2',Representante2);
//      Sistema.SetField('moes_percomissao',FRepresentantes.GetPerComissao(Representante) );
//      Sistema.SetField('moes_percomissao2',FRepresentantes.GetPerComissao(Representante2) );
      Sistema.SetField('moes_percomissao',PerComissao );
      Sistema.SetField('moes_percomissao2',PerComissao2 );
//    end;
// 15.02.10 - notas com servi�os e produtos
    Sistema.SetField('moes_baseiss',valorservicos);
    Sistema.SetField('moes_valorpis',0);
    Sistema.SetField('moes_valorcofins',0);
    Sistema.SetField('moes_valoriss',valoriss);
    Sistema.SetField('moes_periss',perciss);
    Sistema.SetField('moes_vlrservicos',valorservicos);
////////////////////////////
// 11.03.10 - Novi - devolucao de nota de entrada de produtor...
    Sistema.SetField('moes_funrural',valorfunrural);
// 20.11..11 - Novi - vava+angela - devolucao de nota de entrada de produtor...
    Sistema.SetField('moes_cotacapital',valorcotacapital);
// 23.08.10 - Abra - margem de lucro usada no contrato pra calcular a comissao
    if MargemLucro>0 then
      Sistema.SetField('Moes_PerMargem',MargemLucro);
// 24.03.11 - Lam. Sao Caetano - exportacao
    campo:=Sistema.GetDicionario('movesto','moes_estadoex');
    if Campo.Tipo<>'' then
      Sistema.SetField('moes_estadoex',Ufembarque);
// 27.06.11 - Lam. Sao Caetano - exportacao
//    campo:=Sistema.GetDicionario('movesto','moes_chavenferef');
//    if Campo.Tipo<>'' then
      Sistema.SetField('moes_chavenferef',ChaveNfeacom);
    if (codigomov=FGeral.GetConfig1Asinteger('ConfNfComple'))
       and ( FGeral.GetConfig1Asinteger('ConfNfComple')>0 )
       then begin
      Sistema.SetField('moes_valoravista',0);
      Sistema.SetField('moes_totprod',0);
      Sistema.SetField('moes_valortotal',0);
      Sistema.SetField('moes_vlrtotal',0);
      Sistema.SetField('moes_baseicms',0);
    end else begin
// 23.12.04
      Sistema.SetField('moes_valoravista',valoravista);
      Sistema.SetField('moes_totprod',ValorProd);
      Sistema.SetField('moes_valortotal',Valortotal);
      Sistema.SetField('moes_vlrtotal',Valortotal);
      Sistema.SetField('moes_baseicms',baseicms);
    end;
// 16.11.12 - Novicarnes - Isonel
    if trim( xcolaborador ) <>'' then
      Sistema.SetField('moes_cola_codigo',xcolaborador);
// 11.11.13 - Metalforte - Devolucao tributada - ipi no valor de outras despesas
    Sistema.SetField('moes_outrasdesp',xvlroutrasdespesas);
// 20.06.16
    if (Global.topicos[1043]) and ( Movimento > 1 )  then begin
       transacaocontax:=GetTransacaoContax(strzero(FUnidades.GetEmpresaContax(Unidade),3),True);
       Sistema.SetField('moes_transacerto',transacaocontax);
    end;
// 06.07.16
    if carga>0 then Sistema.SetField('moes_carga',carga);
// 10.12.14
///////////////
    Sistema.Post();

// 23.04.08 - grava a transacao e o usuario no arquivo de log
///////////////////////////////////    Atualizalog(transacao,Global.Usuario.Codigo,15,emissao);
///  20.11.16 - retirado
// 01.07.08
    if (pedido>0) and (codigomov=FGeral.GetConfig1AsInteger('ConfMovAbate')) then begin
      Sistema.Edit('movabate');
      Sistema.SetField('mova_notagerada',Numero);
      Sistema.SetField('mova_transacaogerada',Transacao);
      Sistema.Post(' mova_numerodoc='+inttostr(pedido)+
                   ' and mova_status=''N'''+
                   ' and mova_tipomov='+Stringtosql(TipoSaidaAbate)+
                   ' and mova_unid_codigo='+stringtosql(Unidade)+
                   ' and mova_transacaogerada='+stringtosql('')+
                   ' and mova_tipo_codigo='+Cliente.Assql)
   end;
// 21.06.16
////////////////////////////////////////////
    if (Global.topicos[1043]) and ( Movimento > 1 )  then begin
      clifor:=FGeral.GetNomeRazaoSocialEntidade(Cliente.asinteger,tipocad,'N');
      debito:=0;credito:=0;
      GetContasExportacao(FCondPagto.GetAvPz(Condicao),'C',TipoMovimento,Tipocad,transacao,Unidade,
                                      CodigoMOv,Cliente.asinteger,0,debito,credito);
// lan�amento simples
      campos:='mcon_transacao,mcon_operacao,mcon_status,mcon_unid_codigo,mcon_pcon_conta,mcon_datamvto,mcon_datalcto,mcon_dc,'+
              'mcon_valor,mcon_zeramento,mcon_hist_codigo,mcon_complemento,mcon_numerodcto';
      if (debito>0) and (credito>0) and (valortotal>0) then begin
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'1')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(debito))+','+Datetosql(Emissao)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('D')+','+Valortosql(valortotal)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql('NF '+inttostr(numero)+' '+clifor)+','+
                 Stringtosql(inttostr(NUmero));
        SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'2')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Emissao)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(valortotal)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql('NF '+inttostr(numero)+' '+clifor)+','+
                 Stringtosql(inttostr(NUmero));
        SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );

      end;

    end;
    FGeral.Fechaquery(QUnidade);

////////////////////////////////////////////


end;


/////////////////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaMovfin(Transacao,Unidade,EntSai,CompleHist:string ; Emissao,Movimento,Bompara:TDatetime ; Numero,CodHist,Cheque,Conta:integer ; valorparcela:currency ; Contarecdes:integer ;
                              Tipomov:string ; Repr_codigo:integer=0 ; Tipo_codigo:integer=0 ; tipocad:string='' ; status:string='N' ; npar:string='1';
                              transacaocontax:string=''; ContaTrans:integer=0 );
/////////////////////////////////////////////////////////////////////////////////////////////
var campos,valores,clifor:string;
    debito,credito,caixafilial,codforne:integer;
    QUnid_codigo:TSqlquery;
begin
//  if not Arq.TPlano.Active then Arq.TPlano.Open;
//  Arq.TPlano.locate('plan_conta',Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger,[]);
  if valorparcela<>0 then begin  // 19.08.05
    Sistema.Insert('Movfin');
    Sistema.Setfield('movf_transacao',transacao);
    Sistema.Setfield('movf_operacao',FGeral.Getoperacao);
    Sistema.Setfield('movf_status',status);
    Sistema.Setfield('movf_unid_codigo',Unidade);
    Sistema.Setfield('movf_datalcto',Sistema.HOje);
    Sistema.Setfield('movf_datamvto',Emissao);
    Sistema.SetField('movf_DataCont',Movimento);
    Sistema.Setfield('movf_dataprevista',BomPara);
  //      Sistema.Setfield('movf_dataextrato' date,
  //  Sistema.Setfield('movf_plan_conta',Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger);
    Sistema.Setfield('movf_plan_conta',conta);
  //  if codhist=0 then begin
  //    Arq.TPlano.locate('plan_conta',inttostr(conta),[]);
  //    codhist:=Arq.TPlano.fieldbyname('plan_codhist').asinteger;
  //    complehist:=trim(FHistoricos.GetDescricao(Arq.TPlano.fieldbyname('plan_codhist').asinteger))+' '+;
  //  end;
// 09.08.16
    if codhist=999 then begin
       Sistema.Setfield('movf_favorecido','COBRANCA BANCARIA');
       codhist:=0;
    end;
    Sistema.Setfield('movf_hist_codigo',Codhist);
    Sistema.Setfield('movf_complemento',Complehist);
    Sistema.Setfield('movf_numerodcto',inttostr(Numero));
  //      Sistema.Setfield('movf_codb_codigo', varchar(3),
    Sistema.Setfield('movf_es',EntSai);
    Sistema.Setfield('movf_numerocheque',cheque);
    Sistema.Setfield('movf_valorger',valorparcela);
    Sistema.Setfield('movf_valorbco',valorparcela);
    Sistema.Setfield('movf_plan_contard',Contarecdes);
  // 16.02.05
    Sistema.Setfield('movf_tipomov',tipomov);
  // 01.08.05
    Sistema.Setfield('movf_usua_codigo',Global.Usuario.Codigo);
  // 09.03.05
  //      Sistema.Setfield('movf_transconc varchar(12),
  //      Sistema.Setfield('movf_seqlcto numeric(5, 0)
// 22.05.06
    Sistema.Setfield('movf_repr_codigo',Repr_Codigo);
// 23.05.06
    Sistema.Setfield('movf_tipo_codigo',Tipo_Codigo);
    Sistema.Setfield('movf_tipocad',Tipocad);
// 13.01.2014 - Metalforte
    Sistema.SetField('movf_codb_codigo',npar);
// 19.09.16
   if (Global.topicos[1045]) and ( Movimento > 1 )  then
      Sistema.SetField('movf_transacaocontax',transacaocontax);

    Sistema.Post;
// 19.09.16
   if (Global.topicos[1045]) and ( Movimento > 1 ) and (transacaocontax<>'')  then begin
      QUnid_codigo:=sqltoquery('select * from unidades where unid_codigo = '+Stringtosql(Unidade));
      caixafilial:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
// lan�amento simples
      campos:='mcon_transacao,mcon_operacao,mcon_status,mcon_unid_codigo,mcon_pcon_conta,mcon_datamvto,mcon_datalcto,mcon_dc,'+
              'mcon_valor,mcon_zeramento,mcon_hist_codigo,mcon_complemento,mcon_numerodcto';
      clifor:=Complehist;
      if EntSai='E' then begin    // baixa de recebimentos
            debito:=FPlano.GetContaExportacao(conta,Unidade);
            credito:=QUnid_codigo.fieldbyname('unid_clientes').asinteger;
            if (Contarecdes>0) and (Contarecdes<>caixafilial) then begin
              credito:=FPlano.GetContaExportacao(Contarecdes,Unidade);
            end;
// 26.09.16
            if ContaTrans>0 then credito:=FPlano.GetContaExportacao(ContaTrans,Unidade);
// Baixa de clientes - para NAO usar a conta contabil pela conta de despesa informada na baixa
            if ( Global.Topicos[1253] ) and (tipomov=Global.CodPendenciaFinanceira) then begin
               codforne:=tipo_codigo;
               tipocad:=TipoCad;
               if codforne>0 then begin
                 if tipocad='C' then begin
                   if Movimento < 1  then begin
                     credito:=FCadcli.GetContaExp(codforne,'','XX');
// Novicarnes - Leonir - lan�ar a baixa de venda a associado no ativo usando o campo conta01 do cad. de cliente
                   end else if FCadcli.Getecooperado(codforne) then begin
                     credito:=FCadcli.GetContaExp(codforne,'','XY');
                   end else begin
                     credito:=FCadcli.GetContaExp(codforne);
                   end;
                 end else if tipocad='F' then begin
                   credito:=FFornece.GetContaExp(codforne,Unidade);
                 end;
               end else if codforne=-1 then begin  // baixou mais de um cli/for na baixa
                 credito:=-2;
               end;
            end;

      end else begin   // pagamentos - saidas
/////////////////////
            credito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
            if Conta<>CaixaFilial then begin
               credito:=FPlano.GetContaExportacao(Conta,Unidade);
            end;
            if ( Global.Topicos[1253] ) and (tipomov=Global.CodPendenciaFinanceira) then begin
               codforne:=tipo_codigo;
               tipocad:=TipoCad;
               if codforne>0 then begin
                 if tipocad='C' then begin
                   if Movimento < 1  then begin
                     debito:=FCadcli.GetContaExp(codforne,'','XX');
// Novicarnes - Leonir - lan�ar a baixa de venda a associado no ativo usando o campo conta01 do cad. de cliente
                   end else if FCadcli.Getecooperado(codforne) then begin
                     debito:=FCadcli.GetContaExp(codforne,'','XY');
                   end else begin
                     debito:=FCadcli.GetContaExp(codforne);
                   end;
                 end else if tipocad='F' then begin
                   debito:=FFornece.GetContaExp(codforne,Unidade);
                 end;
// 04.10.16 - para o caso do 'fornecedor 24' q nao tem conta contabil 
                 if debito=0 then debito:=FPlano.GetContaExportacao(ContarecDes,Unidade);
               end else debito:=-1;
            end else if Contarecdes>0 then begin
                debito:=FPlano.GetContaExportacao(ContarecDes,Unidade);
                if debito=credito then begin
                  debito:=QUnid_codigo.fieldbyname('unid_fornecedores').asinteger;
                end;
  // conta de compensacao
                if (ContarecDes=FGeral.GetConfig1AsInteger('Ctacheacompensar')) then begin
                  if ( not FPlano.EContachequeacompensar(Conta) ) then begin
                    credito:=FPlano.GetContaExportacao(Conta,Unidade);
                    debito:=FPlano.GetContaExportacao( FPlano.GetContaCompensacao(Conta),Unidade);
                  end;
                end;
            end else begin
              debito:=FPlano.GetContaExportacao(conta,Unidade);
            end;

      end;   // ent/saida
      if (debito>0) and (credito>0) and (debito=credito)  then begin
        Avisoerro('Contas de d�bito e cr�dito igual a '+inttostr(debito)+'.  Sistema ser� finalizado.' );
        Application.Terminate;
      end;
      if (debito>0) and (credito>0) and (valorparcela>0)  then begin
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'1')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(debito))+','+Datetosql(Emissao)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('D')+','+Valortosql(valorparcela)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql('NF '+inttostr(numero)+' '+clifor)+','+
                 Stringtosql(inttostr(NUmero));
        SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'2')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Emissao)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(valorparcela)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql('NF '+inttostr(numero)+' '+clifor)+','+
                 Stringtosql(inttostr(NUmero));
        SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );

      end;
      fGeral.FechaQuery(QUnid_codigo);
   end;
//////////////////////

  end;

end;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaPendencia(Emissao,Movimento:TDatetime;Clifor:TSqlEd;TipoCad:string ;Representante:integer;Unidade,TipoMovimento,
              Transacao,Condicao,PR:string;Numero,CodigoMov:Integer;Valortotal,ValorComissao:currency;status:string='N';Total:currency=0;contagerencial:integer=0;
              GridParcelas: TSqlDtGrid=nil ; opantecipa:string='' ; Portador:string='' ; Complemento:string='' ;
              xseto_codigo:string='');
//////////////////////////////////////////////////////////////////////////////////////////////
var ListaPrazos:TStringlist;
    n,nparcelas,p,primeiraparcela,codhist,contarecdes,contaavista:integer;
    valorparcela,acumulado,valorpar:currency;
    entsai,complehist:string;
    gravapen:boolean;
    campoconta:TDicionario;
/////////////////////////////////
begin
/////////////////////////////////////////////
  if trim(condicao)='' then exit ;   // para permitir a "n�o gera��o" de pend�ncia financeira
  ListaPrazos:=TStringList.Create;
  n:=FCondPagto.GetPrazos(Condicao,ListaPrazos);
// ver se for a vista jogar na conta caixa ( configura��o na unidade )
  nparcelas:=FCondPagto.GetNumeroParcelas(Condicao);
  if GridParcelas<>nil then begin
    nparcelas:=0;
    for n:=1 to GridParcelas.RowCount do begin
      if texttovalor( GridParcelas.cells[GridParcelas.getcolumn('pend_valor'),n] ) > 0 then
        inc(nparcelas);
    end;
// 17.05.06 - para nao gerar nada quando o grid vier 'vazio'
    if nparcelas=0 then exit;
  end;

// verificar se � a vista com apenas uma parcela OU se somente a primeira parcela � a vista ( ou parte do total )
  valorparcela:=0;valorpar:=0;
  if PR='R' then
    EntSai:='E'
  else
    EntSai:='S';
  primeiraparcela:=1;
// 22.02.16
  contaavista:=Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger;
  campoconta:=Sistema.GetDicionario('portadores','port_plan_conta');
  if campoconta.tipo<>'' then begin
     contaavista:=FPortadores.GetConta(Portador);
     if contaavista=0 then contaavista:=Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger;
  end;

  if FCondPagto.GetPrimeiroPrazo(Condicao)=0 then begin
    if not Arq.TPlano.active then Arq.TPlano.open;
    Arq.TPlano.locate('plan_conta',Arq.TUnidades.fieldbyname('unid_contacontabil').asstring,[]);
    if pos(TipoMovimento,Global.CodDevolucaoVenda+';'+Global.CodDevolucaoRoman+';'+Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoVendaConsig )>0then begin
      codhist:=0;  //  ver de onde pegar hist. de devolu��o de venda
      complehist:='Devolu��o de Venda '+inttostr(numero)+' '+FGeral.GetNomeRazaoSocialEntidade(clifor.asinteger,tipocad,'R');
      contarecdes:=Global.CodContaDevVenda;
//    end else if TipoMovimento=Global.CodDevolucaoCompra then begin  // 14.09.05
    end else  if pos(Tipomovimento,global.coddevolucaocompra+';'+global.coddevolucaocompraSemestoque)>0 then begin  // 09.11.05
      codhist:=0;  //  ver de onde pegar hist. de devolu��o de compra
      complehist:='Devolu��o de Compra '+inttostr(numero)+' '+FGeral.GetNomeRazaoSocialEntidade(clifor.asinteger,tipocad,'R');
//      contarecdes:=Global.CodContaDevVenda;
      contarecdes:=Global.CodContaDevCompra;
    end else begin
      codhist:=Arq.TPlano.fieldbyname('plan_codhist').asinteger;
//      complehist:='Venda a vista '+clifor.text+' '+FGeral.GetNomeRazaoSocialEntidade(clifor.asinteger,tipocad,'R');
// 26.02.10 - Capeg - nao previa compras 'a vista'
      if EntSai='S' then begin
// 07.07.14 - Metallum
        if Tipomovimento=Global.CodEntradaSemItens then
          complehist:=FConfMovimento.GetDescricao(codigomov)+' '+inttostr(numero)+' '+FGeral.GetNomeRazaoSocialEntidade(clifor.asinteger,tipocad,'R')
        else
          complehist:='Compra a vista '+inttostr(numero)+' '+FGeral.GetNomeRazaoSocialEntidade(clifor.asinteger,tipocad,'R');
// 03.02.16 - Coorlaf pitanga...lan�ava pendencia a vista e caia na conta de despesa de  receitas...
        contarecdes:=contagerencial;
      end else begin
        complehist:='Venda a vista '+inttostr(numero)+' '+FGeral.GetNomeRazaoSocialEntidade(clifor.asinteger,tipocad,'R');
        contarecdes:=Global.CodContaVendaaVista;
      end;
    end;
    if GridParcelas<>nil then begin
// 09.11.05
      if (Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),1]='') or (FGeral.tirabarra(Gridparcelas.cells[Gridparcelas.getcolumn('pend_datavcto'),1])='') then
        valorparcela:=0
      else
        valorparcela:=FGeral.Arredonda(texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),1]) ,2);
      if valorparcela>0 then begin
// 31.08.05
///////////////////////////////////////////////
        if tipomovimento=global.CodVendaAmbulante then
          FGeral.GravaMovFin(Transacao,UNidade,EntSai,complehist,Movimento,Movimento,
            texttodate(FGeral.tirabarra(Gridparcelas.cells[Gridparcelas.getcolumn('pend_datavcto'),1])),Numero,codhist,0,Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger,valorparcela,contarecdes,tipomovimento,0,0,'',status)
// 21.09.04
///////////////////////////////////////////
        else if tipomovimento=global.CodDevolucaoIgualVenda then
          FGeral.GravaMovFin(Transacao,UNidade,EntSai,complehist,Movimento,Movimento,
            texttodate(FGeral.tirabarra(Gridparcelas.cells[Gridparcelas.getcolumn('pend_datavcto'),1])),Numero,codhist,0,Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger,valorparcela,contarecdes,tipomovimento,0,0,'',status)
        else
          FGeral.GravaMovFin(Transacao,UNidade,EntSai,complehist,texttodate(FGeral.tirabarra(Gridparcelas.cells[Gridparcelas.getcolumn('pend_datavcto'),1])),Movimento,
            texttodate(FGeral.tirabarra(Gridparcelas.cells[Gridparcelas.getcolumn('pend_datavcto'),1])),Numero,codhist,0,contaavista,valorparcela,contarecdes,tipomovimento,0,0,'',status);
      end;
    end else begin
      valorparcela:=valortotal;
      FGeral.GravaMovFin(Transacao,UNidade,EntSai,complehist,Emissao,Movimento,Emissao,Numero,codhist,0,Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger,valorparcela,contarecdes,tipomovimento,0,0,'',status);
    end;
//    FGeral.GravaMovFin(Transacao,UNidade,EntSai,'',Emissao,Movimento,Emissao,Numero,0,0,Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger,valorparcela);
    valortotal:=valortotal-valorparcela;
    if total>0 then
      total:=total-valorparcela;
    primeiraparcela:=2;
  end;
{  // usando o percentual de entrada definido na condi��o de pagamento
  if FCondPagto.GetPerEntrada(Condicao)>0 then begin
// mudar aqui para pegar o valor da primeira parcela dada como entrada
    if total>0 then begin
      valorpar:=FGeral.Arredonda(total*(Arq.TFPgto.fieldbyname('fpgt_entrada').AsCurrency/100),2);
      FGeral.GravaMovFin(Transacao,UNidade,EntSai,'',Emissao,Movimento,Emissao,Numero,0,0,Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger,valorpar);
    end else begin
      valorparcela:=FGeral.Arredonda(valortotal*(Arq.TFPgto.fieldbyname('fpgt_entrada').AsCurrency/100),2);
      FGeral.GravaMovFin(Transacao,UNidade,EntSai,'',Emissao,Movimento,Emissao,Numero,0,0,Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger,valorparcela);
    end;
    valortotal:=valortotal-valorparcela;
  end;
}
  valorparcela:=0;acumulado:=0;
  if FCondPagto.GetAvPz(Condicao)='P' then begin
    for p:=primeiraparcela to nparcelas do begin
// 17.11.05
      gravapen:=true;
      if GridParcelas<>nil then begin
// 09.11.05
        if ( texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),p])>0) and  ( trim(FGeral.tirabarra(Gridparcelas.cells[Gridparcelas.getcolumn('pend_datavcto'),p]))<>'' ) then
           gravapen:=true
        else                                               
           gravapen:=false;
      end;
      if gravapen then begin
        Sistema.Insert('Pendencias');
        Sistema.SetField('Pend_Transacao',Transacao);
        if Transacao=Global.UltimaTransacao then
          Sistema.SetField('Pend_Operacao',GetOperacao)
        else
          Sistema.SetField('Pend_Operacao',Transacao+strzero(p,2));
        Sistema.SetField('Pend_Status',status);
        Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
        if pr='P' then begin
          if MOvimento>1 then
            Sistema.SetField('Pend_DataMvto',Movimento)
          else
            Sistema.SetField('Pend_DataMvto',sistema.hoje)
        end else
          Sistema.SetField('Pend_DataMvto',Emissao);
  //////////////////////////////      Sistema.SetField('Pend_DataCont',Movimento);
        Sistema.SetField('Pend_ValorComissao',ValorComissao);
  //      Sistema.SetField('Pend_DataVcto',FGeral.GetProximoDiaUtil(Emissao+Inteiro(ListaPrazos[p-1])) );
        if Gridparcelas=nil then begin
          Sistema.SetField('Pend_DataVcto',FGeral.GetProximoDiaUtil(Emissao+Inteiro(ListaPrazos[p-1])) );
// 19.08.08
          Sistema.SetField('pend_datavctoori',FGeral.GetProximoDiaUtil(Emissao+Inteiro(ListaPrazos[p-1])) );
        end else begin
          Sistema.SetField('Pend_DataVcto',texttodate(FGeral.tirabarra(Gridparcelas.cells[Gridparcelas.getcolumn('pend_datavcto'),p])) );
// 19.08.08
          Sistema.SetField('pend_datavctoori',texttodate(FGeral.tirabarra(Gridparcelas.cells[Gridparcelas.getcolumn('pend_datavcto'),p])) );
        end;
        Sistema.SetField('Pend_DataEmissao',Emissao);
  //      Sistema.SetField('Pend_DataAutPgto','D',0,0,60,True,'Data Aut. Pgto','Data autorizada para pagamento','',True,'1','','','0');
//
{
        if Clifor.resultfind<>nil then begin
          if tipocad='C' then
            Sistema.SetField('Pend_Plan_Conta',Clifor.Resultfind.fieldbyname('clie_contagerencial').AsInteger)
          else if tipocad='T' then
            Sistema.SetField('Pend_Plan_Conta',Clifor.Resultfind.fieldbyname('tran_contagerencial').AsInteger)
          else if tipocad='F' then
            Sistema.SetField('Pend_Plan_Conta',Clifor.Resultfind.fieldbyname('forn_contagerencial').AsInteger)
          else if tipocad='R' then
            Sistema.SetField('Pend_Plan_Conta',Clifor.Resultfind.fieldbyname('repr_contagerencial').AsInteger);
        end else begin
          Sistema.SetField('Pend_Plan_Conta',contagerencial);
        end;
}
///////// - 23.11.06
        Sistema.SetField('Pend_Plan_Conta',contagerencial);
// 07.08.07
        if tipocad='C' then begin
// 11.03.10
          if Clifor.resultfind<>nil then begin
            if Clifor.resultfind.fieldbyname('clie_codigofinan').asinteger>0 then
              Sistema.SetField('Pend_Tipo_Codigo',Clifor.resultfind.fieldbyname('clie_codigofinan').asinteger )
            else
              Sistema.SetField('Pend_Tipo_Codigo',Clifor.Asinteger );
          end else
              Sistema.SetField('Pend_Tipo_Codigo',Clifor.Asinteger );
        end else
          Sistema.SetField('Pend_Tipo_Codigo',Clifor.Asinteger );
        Sistema.SetField('Pend_Unid_Codigo',Unidade);
        Sistema.SetField('Pend_Fpgt_Codigo',Condicao);
        if trim(portador)='' then begin
          if Arq.TPortadores.active then
            Sistema.SetField('Pend_Port_Codigo',Arq.TPortadores.fieldbyname('port_codigo').asstring);
        end else
          Sistema.SetField('Pend_Port_Codigo',Portador);
        Sistema.SetField('Pend_Hist_Codigo',Global.VCHist);
        Sistema.SetField('Pend_Moed_Codigo','');
        Sistema.SetField('Pend_Repr_Codigo',Representante);
        Sistema.SetField('Pend_TipoCad'    ,Tipocad);
  //      Sistema.SetField('Pend_CNPJCPF',EdCliente.Resultfind('clie_cnpjcpf);
// 20.10.10
        if trim(complemento)<>'' then
          Sistema.SetField('Pend_Complemento',complemento)
        else
          Sistema.SetField('Pend_Complemento',global.VCComplehist);
        Sistema.SetField('Pend_NumeroDcto',Numero);
        Sistema.SetField('Pend_Parcela',p);
        Sistema.SetField('Pend_NParcelas',nparcelas);
        Sistema.SetField('Pend_RP',PR);
  ///////////////////////////////////////////////////////////////
        if Total=0 then begin  // se for 'tipo 2'
          if p=nparcelas then begin
            valorparcela:=valortotal-acumulado;  // para deixar na ultima parcelas "as d�zimas"
            if GridParcelas<>nil then  // 21.11.05
              valorparcela:=FGeral.Arredonda(texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),p]) ,2);
          end else begin
            if GridParcelas<>nil then  // 21.08.10 - Abra - provisao comissao/reserva tec.
              valorparcela:=FGeral.Arredonda(texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),p]) ,2)
            else
              valorparcela:=FGeral.Arredonda(valortotal/nparcelas,2);
          end;
          acumulado:=acumulado+valorparcela;
          Sistema.SetField('Pend_DataCont',Movimento);
          Sistema.SetField('Pend_Valor',valorparcela);
          Sistema.SetField('Pend_ValorTitulo',valortotal);
        end else begin
          if p=nparcelas then
            valorpar:=total-acumulado  // para deixar na ultima parcelas "as d�zimas"
          else begin
  //          valorpar:=FGeral.Arredonda(texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),p]),2);
  // ver como fica o "tipo 2"
            valorpar:=FGeral.Arredonda(total/nparcelas,2);
          end;
// 21.11.05
          if GridParcelas<>nil then
            valorpar:=FGeral.Arredonda(texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),p]),2);

          acumulado:=acumulado+valorpar;
          Sistema.SetField('Pend_Valor',valorpar);
          Sistema.SetField('Pend_ValorTitulo',total);
        end;
  ///////////////////////////////////////////////////////////////

  {
        if Total=0 then begin
          if p=nparcelas then
            valorparcela:=valortotal-acumulado  // para deixar na ultima parcelas "as d�zimas"
          else
            valorparcela:=FGeral.Arredonda(valortotal/nparcelas,2);
          acumulado:=acumulado+valorparcela;
          Sistema.SetField('Pend_DataCont',Movimento);
          Sistema.SetField('Pend_Valor',valorparcela);
          Sistema.SetField('Pend_ValorTitulo',valortotal);
        end else begin
          if p=nparcelas then
            valorpar:=total-acumulado  // para deixar na ultima parcelas "as d�zimas"
          else
            valorpar:=FGeral.Arredonda(total/nparcelas,2);
          acumulado:=acumulado+valorpar;
          Sistema.SetField('Pend_Valor',valorpar);
          Sistema.SetField('Pend_ValorTitulo',total);
        end;
  }
        Sistema.SetField('Pend_Juros',0);
        Sistema.SetField('Pend_Multa',0);
        Sistema.SetField('Pend_Mora',0);
        Sistema.SetField('Pend_Acrescimos',0);
        Sistema.SetField('Pend_Descontos',0);
        Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
        Sistema.SetField('Pend_ContaBaixa',0);
  //        Sistema.SetField('Pend_DataBaixa',0);
        Sistema.SetField('Pend_Observacao','');
  //      Sistema.SetField('Pend_UsuAutPgto','');
        Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
        Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso j� foi enviado para impress�o
        Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exporta��o banc�ria (CNAB )
        if status='D' then
          Sistema.Setfield('Pend_Opantecipa',opantecipa);   // nro da antecipa�ao usada na baixa do titulo
  // 08.09.05
        Sistema.SetField('Pend_tipomov',tipomovimento);
  // 28.10.05 - Regime Especial
        if pos( tipomovimento,global.CodVendaRE+';'+Global.CodVendaREFinal ) >0 then
          Sistema.SetField('Pend_DataCont',Movimento);
  // 09.11.05
        Sistema.SetField('Pend_usua_codigo',Global.Usuario.Codigo);
// 27.08.13
        if Global.Topicos[1365] then Sistema.SetField('pend_seto_codigo',xseto_codigo);

        Sistema.Post;

      end;  // 09.11.05

    end;  // for do numero de parcelas
  end;   // vista ou a prazo
  Freeandnil(ListaPrazos);

end;


function TFGeral.TituloRelUnidade(Unidade: string): string;
begin
  if length(Unidade)<=4 then
    result:='Unidade : '+copy(unidade,1,3)+' - '+FUnidades.Getnome(unidade)
  else
    result:='Unidades : '+Unidade;
end;


function TFGeral.FormataData(data: TDatetime): string;
///////////////////////////////////////////////////////
begin
//  result:=formatdatetime('dd/mm/yy',data);
  if data>1 then
    result:=formatdatetime('dd/mm/yy',data)
  else
    result:=space(8);  // 25.09.07
end;

function TFGeral.Custo(Unitario, pericms, perfrete, peripi,pericmsfrete,perdesc,peracre,perpis,percofins,perST: currency ;
                       simplesnacional:string='N'): currency;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
begin
  unitario:=unitario*((100-perdesc))/100;
  unitario:=unitario*((100+peracre))/100;
//  result:=unitario-(unitario*(pericms/100))+(unitario*(perfrete/100))+(unitario*(peripi/100))-(unitario*(pericmsfrete/100))
// 09.08.05 - AANTAAAAAAA--- como calcula frete pelo liquido nao precisa deduzir o icms do frete....
// 25.03.08 - 24.09.14 - colocado ST no calculo do custo
  if simplesnacional='N' then
    result:=unitario-(unitario*(pericms/100))+(unitario*(perfrete/100))+(unitario*(peripi/100)) - (unitario*(perpis/100)) - (unitario*(percofins/100)) +
            +(unitario*(perSt/100))
  else
    result:=unitario +(unitario*(perfrete/100))+(unitario*(peripi/100))+(unitario*(perST/100))
end;

// 20.06.05
function TFGeral.CustoGer(Unitario, vlricms, perfrete, vlripi, vlricmsfrete,perdesc,peracre: currency ; simplesnacional:string='N'): currency;
begin
//  unitario:=unitario*((100-perdesc))/100;
// 09.08.05 - aqui o unitario ja vem com o desconto
//  result:=unitario - vlricms + (unitario*(perfrete/100)) + vlripi - vlricmsfrete
// 09.08.05 - AANTAAAAAAA--- como calcula frete pelo liquido nao precisa deduzir o icms do frete....
//  result:=unitario - vlricms + (unitario*(perfrete/100)) + vlripi
// 20.01.06 - Leila
// 25.03.08
  if simplesnacional='N' then
    result:=unitario - vlricms + ( (unitario-vlricms) *(perfrete/100)) + vlripi
  else
    result:=unitario + ( (unitario) *(perfrete/100)) + vlripi

end;

function TFGeral.TipomovEntra(TipoMov: string): boolean;
begin
  if pos(TipoMov,Global.TiposMovMovEntrada)>0 then
    result:=true
  else
    result:=false;
end;

function TFGeral.TipomovSai(TipoMov: string): boolean;
///////////////////////////////////////////////////////////
begin
  if pos(TipoMov,Global.TiposMovMovEstoque)>0 then
    result:=true
  else
    result:=false;

end;

function TFGeral.CustoMedio(Customedio, NOvoCusto,Qtde,NovaQtde : currency): currency;
/////////////////////////////////////////////////////////////////////////////////
begin
  if (qtde+NovaQtde>0) and (qtde>0) then begin
    result:= ( (Customedio*qtde)+(Novocusto*NovaQtde) )/ (qtde+NovaQTde)
  end else if (NovaQtde>0)  then begin  // 13.06.05
    result:= Novocusto
  end else
    result:=Customedio;
end;


function TFGeral.CustoMedioGerencial(CustomedioGer, NOvoCusto,  Qtde, NOvaQtde: currency): currency;
begin
  if (qtde+NovaQtde>0) and ( qtde>0 ) then begin
    result:= ( (Customedioger*qtde)+(Novocusto*NovaQtde) )/ (qtde+NovaQTde)
  end else if (NovaQtde>0)  then begin  // 13.06.05
    result:= Novocusto
  end else
    result:=CustomedioGer;

end;

/////////////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaItensNFCompra(Emissao,Entrada: TDatetime;
/////////////////////////////////////////////////////////////////////////////////////////
  Fornecedor: TSqlEd; Unidade, TipoMovimento, Transacao: string;
  Numero: Integer; Grid: TSqlDtGrid; frete, seguro, peracre , perdesco: currency ; total:currency=0 ; Movimento:TDatetime=0 ;
  Pedido:integer=0 ; MontaBase:string='S'; Fornecind:integer=0 ; Baseicms:currency=0 ; Valoricms:currency=0 ; xcfop:string='' ;
  xcodmov:integer=0 ; ytipocad:string='F' ; obra:string=''  ; totalprodutos:currency=0 ;xtiposmuda:string='' ;
  ArqXml:string=''; xtotalicmsst:currency=0  );

var linha,p:integer;
    codigograde,codigolinha,codigocoluna,codcor,codtamanho,codcopa,CstServicos:integer;
    qtde,reducao,isentas,outras,base,basesubs,valorcontabil,margemlucro,totalitem,pericms,valoripi,totalbaseicms,
    novocusto,novocustomedio,perfrete,peripi,pericmsfrete,perfreteprev,novocustoger,pericmsfreteprev,novocustomedioger,
    qtderec,embalagem,novoprecovenda,perST,totalprodcomST,perdesc:currency;
    tiposdif,sqlcor,sqltamanho,sqlcopa,xTipoMovimento,xTipocad,ycfop,simplesnacional,EntranoCusto:string;
    QCusto,QCustoMat,Qest,QEstQtde,QUnidade,TEstGrades,QPedido,QXML:Tsqlquery;
    prim:boolean;
    Cfopservicos:string;
    venda:extended;   // 17.01.08 - passado de currency para extended devido as NP

    procedure Incluigrade(xcodcor,xcodtamanho,xcodcopa:integer ; produto:string);
    /////////////////////////////////////////////////////////////////////////////
    var Q:TSqlquery;
        var xsqlcor,xsqltamanho,xsqlcopa:string;
    begin

      xsqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
      xsqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
      xsqlcopa:=' and ( esgr_copa_codigo=0 or esgr_copa_codigo is null )';
      if (xcodcor>0) and (xcodtamanho>0) and (xcodcopa>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
          xsqlcopa:=' and esgr_copa_codigo='+inttostr(xcodcopa);
      end else if (xcodcor>0) and (xcodtamanho>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
      end else if (xcodcor>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
      end else if (xcodtamanho>0) then begin
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
      end;
      Q:=sqltoquery('select esgr_esto_codigo,esgr_qtde,esgr_qtdeprev from estgrades where esgr_esto_codigo='+stringtosql(produto)+
                    ' and esgr_status=''N'' and esgr_unid_codigo='+stringtosql(unidade)+
                    xsqlcor+xsqltamanho+xsqlcopa );
      if Q.eof then begin
        Sistema.Insert('Estgrades');
        Sistema.Setfield('esgr_status','N');
        Sistema.Setfield('esgr_esto_codigo',produto);
        Sistema.Setfield('esgr_unid_codigo',unidade);
        Sistema.Setfield('esgr_grad_codigo',0);
        Sistema.Setfield('esgr_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]) );
        Sistema.Setfield('esgr_qtdeprev',texttovalor(Grid.Cells[grid.getcolumn('qtdeprev'),linha]) );
        Sistema.Setfield('esgr_codbarra','');
        Sistema.Setfield('esgr_custo',Arq.TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
        Sistema.Setfield('esgr_customedio',Arq.TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
        Sistema.Setfield('esgr_custoger',Arq.TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
        Sistema.Setfield('esgr_customeger',Arq.TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
        Sistema.Setfield('esgr_vendavis',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
        Sistema.Setfield('esgr_dtultvenda',emissao);
        Sistema.Setfield('esgr_dtultcompra',emissao);
        Sistema.Setfield('esgr_usua_codigo',Global.Usuario.codigo);
        Sistema.Setfield('esgr_tama_codigo',xcodtamanho);
        Sistema.Setfield('esgr_core_codigo',xcodcor);
        Sistema.Setfield('esgr_copa_codigo',xcodcopa);
// 15.04.08
        Sistema.Setfield('esgr_custoser',Arq.TEstoqueQtde.fieldbyname('esqt_custoser').ascurrency);
        Sistema.Setfield('esgr_customedioser',Arq.TEstoqueQtde.fieldbyname('esqt_customedioser').ascurrency);
        Sistema.Post();

      end else begin
{ - 15.04.08 - desativado por enquanto
// 21.08.09 - ativado - Abra Aluminios
// 22.10.09 - desativado pois atualiza no inicio da gravaitenf...
        Sistema.Edit('Estgrades');
        Sistema.Setfield('esgr_qtde',Q.fieldbyname('esgr_qtde').ascurrency+texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]) );
        Sistema.Setfield('esgr_qtdeprev',Q.fieldbyname('esgr_qtde').ascurrency+texttovalor(Grid.Cells[grid.getcolumn('qtdeprev'),linha]) );
        Sistema.Setfield('esgr_custo',Arq.TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
        Sistema.Setfield('esgr_custoger',Arq.TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
        Sistema.Setfield('esgr_custoser',Arq.TEstoqueQtde.fieldbyname('esqt_custoser').ascurrency);
        Sistema.Setfield('esgr_customedioser',Arq.TEstoqueQtde.fieldbyname('esqt_customedioser').ascurrency);
        Sistema.Post('esgr_esto_codigo='+stringtosql(produto)+
                    ' and esgr_status=''N'' and esgr_unid_codigo='+stringtosql(unidade)+
                    xsqlcor+xsqltamanho+xsqlcopa );
//}
      end;
      FGeral.Fechaquery(Q);
    end;

    // 07.01.14
    function AtualizaCus(cprod:string):boolean;
    //////////////////////////////
    begin
       result:=false;
       if ( ( pos( strzero( FEstoque.GetGrupo( trim(cprod) ) ,6 ) ,FGeral.GetConfig1AsString('GRUPOSNAOcus') ) = 0 )
              and
          ( trim(FGeral.GetConfig1AsString('GRUPOSNAOcus'))<>''  )  )
          OR
          ( trim(FGeral.GetConfig1AsString('GRUPOSNAOcus'))='' ) then
            result:=true;
    end;




// inicio gravacao nf entrada
////////////////////////////////////////////////////////////////////////////////
begin
/////////////////////////////////////////////////////////////////////////////////

  if ListaCstPerc=nil then
     ListaCstPerc:=Tlist.create;
  ListaCstPerc.clear;
// 26.03.08
  QUnidade:=sqltoquery('select unid_simples from unidades where unid_codigo='+stringtosql(unidade));
  simplesnacional:='N';
  if not QUnidade.eof then
    simplesnacional:=QUnidade.fieldbyname('unid_simples').asstring;
  FGeral.FechaQuery(QUnidade);
//////////
// 23.10.07
  if copy(xcfop,1,1)='1' then
    cfopservicos:=FConfMovimento.GetCfopServicoEstado(xcodmov)
  else
    cfopservicos:=FConfMovimento.GetCfopServicoForEstado(xcodmov); //campo na tabela de conf. de movimento

  cstServicos:=FConfMovimento.GetCstServicos(xcodmov) ;
// 26.03.08 - quanto o valor do frete representa do total dos produtos
  perfrete:=0;
  perfreteprev:=0;
  if totalprodutos>0 then begin
    perfrete:=(frete/totalprodutos)*100;
    perfreteprev:=(frete/totalprodutos)*100;
  end;
  if trim(xtiposmuda)='' then
    tiposdif:=Global.CodDevolucaoSerie5+';'+Global.CodDevolucaoVenda+';'+global.CodDevolucaoConsigMerc+
            ';'+global.CodRetornoConsigMercanil+';'+Global.CodRetornoMostruario+';'+Global.coddevolucaoroman+';'+
            Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoVendaConsig+';'+Global.CodCompraProdutor+';'+Global.CodDrawBackEnt+
            ';'+Global.CodEntradaImobilizado+';'+Global.CodCompraProdutorReclassifica
  else
    tiposdif:=xtiposmuda;
// 30.04.05 - colocado conf. movimento dev. romaneio (DA) retorno do represent. pois ainda pedia fornec. e nao cliente
// 13.10.09
//  EntranoCusto:=Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX;
// 22.10.09
  EntranoCusto:=Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+
                Global.CodCompraMatConsumo+';'+Global.CodCompraFutura;
//////////////////
// 11.09.14 - soma os valores dos itens com cfop de CST
  Grid.Index(Grid.GetColumn('move_cst'));   // para gravar primeiro os produtos tributados ( sit.trib.=000 )
  totalprodcomST:=0;
  for linha:=1 to Grid.rowcount do begin
    if pos( Grid.Cells[grid.GetColumn('move_natf_codigo'),linha],'1401/1403/2401/2403/1910/2910' ) > 0 then
      totalprodcomSt:=totalprodcomSt+texttovalor(Grid.Cells[grid.getcolumn('total'),linha])
  end;
////////////////
  prim:=true;  // aqui em 27.07.06 pois estava gerando um mestre para cada detalhe na explosa de mat. prima
  Grid.Index(Grid.GetColumn('move_cst'));   // para gravar primeiro os produtos tributados ( sit.trib.=000 )
////////////////////////////////////////////////////////////////////////////////////////////////////////////
  for linha:=1 to Grid.rowcount do begin
    if trim(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])<>'' then begin

//      Arq.TEstoque.locate('esto_codigo',Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],[]);
// 29.02.12
//      embalagem:=Arq.TEstoque.fieldbyname('esto_embalagem').asinteger;
// 05.09.12
//      if Global.Topicos[1356] then
//        embalagem:=Texttovalor(Grid.Cells[grid.getcolumn('move_embalagem'),linha]);
//      if embalagem=0 then embalagem:=1;

// 11.09.14
      perST:=0;
      if pos( Grid.Cells[grid.GetColumn('move_natf_codigo'),linha],'1401/1403/2401/2403/1910/2910' ) > 0 then
        if totalprodcomST > 0 then perST:=100*(xtotalicmsst/totalprodcomST);

// 02.12.11 - mudado este if para so posicionar..
//      if not Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([Unidade,Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]]),[]) then
//         avisoerro('Checar custo do produto '+Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]);
//      Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([Unidade,Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]]),[]);
// 24.04.12
      QEstQtde:=sqltoquery('select *,Esto_grup_codigo from estoqueqtde inner join estoque on (esto_codigo=esqt_esto_codigo) '+
                           ' where esqt_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                           ' and esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Unidade) );

// aqui em 19.10.15 - pela questao do grupo e nao mais usar o 'arq.testoque...'
      embalagem:=QEstQtde.fieldbyname('esto_embalagem').asinteger;
      if Global.Topicos[1356] then
        embalagem:=Texttovalor(Grid.Cells[grid.getcolumn('move_embalagem'),linha]);
      if embalagem=0 then embalagem:=1;
////////////////////
// aqui em 02.11.07
      venda:=texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]);
      qtde:=texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]);
      totalitem:=venda*qtde;
//////////////
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha]);
//      codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[0,linha],codigograde);
//      codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[0,linha],codigograde);
{
      if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
        Sistema.SetField('move_tama_codigo',codigolinha)
      else
        Sistema.SetField('move_core_codigo',codigolinha);
      if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
        Sistema.SetField('move_tama_codigo',codigocoluna)
      else
        Sistema.SetField('move_core_codigo',codigocoluna);
}
// 08.06.06
      Sistema.SetField('move_tama_codigo',strtointdef(Grid.cells[Grid.getcolumn('move_tama_codigo'),linha],0));
      Sistema.SetField('move_core_codigo',strtointdef(Grid.cells[Grid.getcolumn('move_core_codigo'),linha],0));
      Sistema.SetField('move_copa_codigo',strtointdef(Grid.cells[Grid.getcolumn('move_copa_codigo'),linha],0));
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',numero);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',TipoMovimento);
      Sistema.SetField('move_unid_codigo',Unidade);
      Sistema.SetField('move_tipo_codigo',Fornecedor.AsInteger);
//      Sistema.SetField('move_tipocad','C');
      Sistema.SetField('move_tipocad',ytipocad);
      if pos(TipoMovimento,Global.CodDevolucaoRoman+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoVendaConsig+';'+
             Global.CodCompraProdutor+';'+Global.CodCompraProdutorReclassifica+';'+Global.CodEntradaProdutor)>0 then begin
        Sistema.SetField('move_repr_codigo',Fornecedor.ResultFind.fieldbyname('clie_repr_codigo').AsInteger);
//        Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
//        Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
// retirado em 21.09.05 pois na nf tipo2 gravava uma unidade a mais na qtde
        if Movimento>1 then begin
          Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
          Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
          Sistema.SetField('move_datacont',Entrada);
        end else begin
// 16.08.05 - para prever alteracao de DV...
          if  texttovalor(Grid.Cells[grid.getcolumn('qtdeprev'),linha]) > 0 then begin
            Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('qtdeprev'),linha]));
            Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('valoruni'),linha]));
          end else begin
            Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
            Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
          end;
        end;
      end else begin
//        Sistema.SetField('move_tipocad','F');
        if total=0 then begin
          Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
          Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
//          Sistema.SetField('move_datacont',Entrada);
// 11.05.05 - devido as TE tipo 2
          Sistema.SetField('move_datacont',Movimento);
        end else begin
          Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('qtdeprev'),linha]));
          Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('valoruni'),linha]));
        end;
      end;
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',Entrada);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_custo',QEstQtde.fieldbyname('esqt_custo').ascurrency);
      Sistema.SetField('move_custoger',QEstQtde.fieldbyname('esqt_custoger').ascurrency);
      Sistema.SetField('move_customedio',QEstQtde.fieldbyname('esqt_customedio').ascurrency);
      Sistema.SetField('move_customeger',QEstQtde.fieldbyname('esqt_customeger').ascurrency);
      Sistema.SetField('move_cst',Grid.Cells[grid.getcolumn('move_cst'),linha]);
      Sistema.SetField('move_aliicms',texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha]));
// 19.10.15 - para ver gravacao errada do grupo
{
      Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
}

      Sistema.SetField('move_grup_codigo',QEstQtde.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',QEstQtde.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',QEstQtde.fieldbyname('esto_fami_codigo').AsInteger);
///////////////////////////////////////////////////////////
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_aliipi',texttovalor(Grid.Cells[grid.getcolumn('move_aliipi'),linha]));
// 27.06.06
      Sistema.SetField('move_tipo_codigoind',Fornecind);
// 03.05.07
      Sistema.SetField('move_pecas',texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha]));
// 23.05.07
      Sistema.SetField('move_redubase',texttovalor(Grid.Cells[grid.getcolumn('move_redubase'),linha]));
// 06.03.08
      Sistema.SetField('move_nroobra',obra);
// 23.12.08
      if Global.Topicos[1326] then
        Sistema.SetField('move_certificado',Grid.Cells[grid.getcolumn('move_certificado'),linha]);
// 08.09.10
      if trim(Grid.Cells[grid.getcolumn('move_natf_codigo'),linha])<>'' then begin
        campo:=Sistema.GetDicionario('movestoque','move_natf_codigo');
        if campo.Tipo<>'' then
          Sistema.SetField('move_natf_codigo',Grid.Cells[Grid.getcolumn('move_natf_codigo'),linha] );
      end;
// 05.09.12
      if Global.Topicos[1356] then begin
        Sistema.SetField('move_embalagem',Texttovalor(Grid.Cells[grid.getcolumn('move_embalagem'),linha]));
        Sistema.SetField('move_unitarionota',Texttovalor(Grid.Cells[grid.getcolumn('move_unitarionota'),linha]) );
      end;
// 09.10.13 - Patoterra
      Sistema.SetField('move_remessas',Grid.Cells[Grid.getcolumn('move_operacao'),linha]);
//////////////////////////////
      Sistema.Post('');

// 26.03.08 - Atualizacao do custo do produto e entrada no estoque exclusivo ,por enquanto, para 'DI' - dev. industrial
/////////////////////////////////////////////////////////////////////////////////////////
// 13.10.09 - Abra - caso tiver pedido de compra informado ira supor q nao foi
//              digitado nenhum produto q todos foram 'importados' direto do pedido
      if (TipoMovimento=Global.CodDevolucaoInd) or
          ( (pedido>0) and ( pos( TipoMovimento,EntranoCusto ) > 0 ) ) or
          (  trim(Grid.cells[Grid.getcolumn('move_tama_codigo'),linha])<>'' )  or // 29.06.15 - vivan
          ( trim(Arqxml)<>'' )  // 18.10.10
          then begin
          pericms:=texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha]);
          peripi:=texttovalor(Grid.Cells[grid.getcolumn('move_aliipi'),linha]);
          pericmsfrete:=0;
          qtde:=texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]);
// 27.04.15
          if texttovalor(Grid.Cells[grid.getcolumn('descontouni'),linha])>0 then begin
            perdesc:=texttovalor(Grid.Cells[grid.getcolumn('descontouni'),linha])/(texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha])*qtde);
            perdesc:=perdesc*100;
          end else
            perdesc:=0;
          novocusto:=FGeral.Custo(texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]),pericms,perfrete,peripi,pericmsfrete,perdesc,0,0,0,perST,simplesnacional);
          novocusto:=novocusto/embalagem;
// 01.10.13
          if (Global.Topicos[1366])  then
            novoprecovenda:=novocusto/( 1 - (FGrupos.GetPercentualMargem(Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger))/100 )
          else
            novoprecovenda:=0;
/////////////////////////
          novocustomedio:=FGeral.CustoMedio(QEstQtde.fieldbyname('esqt_customedio').ascurrency,novocusto,QEstQtde.fieldbyname('esqt_qtde').asfloat,Qtde*embalagem);
          novocustoger:=FGeral.CustoGer(texttovalor(Grid.Cells[grid.getcolumn('valoruni'),linha]),texttovalor(Grid.Cells[grid.getcolumn('valoruni'),linha])*(pericms/100),
                 perfreteprev,texttovalor(Grid.Cells[grid.getcolumn('valoruni'),linha])*(peripi/100),texttovalor(Grid.Cells[grid.getcolumn('valoruni'),linha])*(pericmsfreteprev/100),perdesc,0,simplesnacional);
          novocustoger:=novocustoger/embalagem;
          novocustomedioger:=FGeral.CustoMedioGerencial(QEstQtde.fieldbyname('esqt_customeger').ascurrency,novocustoger,QEstQtde.fieldbyname('esqt_qtdeprev').asfloat,qtde*embalagem);
//          novocustomedio:=novocustomedio/embalagem;
//          novocustomedioger:=novocustomedioger/embalagem;

          if strtointdef(Grid.cells[Grid.getcolumn('move_core_codigo'),linha],0)>0 then
            sqlcor:=' and esgr_core_codigo='+Grid.cells[Grid.getcolumn('move_core_codigo'),linha]
          else
            sqlcor:=' and ( (esgr_core_codigo=0) or (esgr_core_codigo is null) )';
          if strtointdef(Grid.cells[Grid.getcolumn('move_tama_codigo'),linha],0)>0 then
            sqltamanho:=' and esgr_tama_codigo='+Grid.cells[Grid.getcolumn('move_tama_codigo'),linha]
          else
            sqltamanho:=' and ( (esgr_tama_codigo=0) or (esgr_tama_codigo is null) )';

          if ( strtointdef(Grid.cells[Grid.getcolumn('move_core_codigo'),linha],0)=0 )
             and
             ( strtointdef(Grid.cells[Grid.getcolumn('move_tama_codigo'),linha],0)=0 )
             then begin
              Sistema.Edit('estoqueqtde');
              if AtualizaCus(Grid.Cells[grid.getcolumn('move_esto_codigo'),linha]) then begin
                Sistema.SetField('esqt_custo',novocusto);
                Sistema.SetField('esqt_custoger',novocustoger);
                Sistema.SetField('esqt_customedio',novocustomedio );
                Sistema.SetField('esqt_customeger',novocustomedioger);
              end;

              Sistema.SetField('esqt_qtde',QEstQtde.fieldbyname('esqt_qtde').ascurrency+(qtde*embalagem));
              Sistema.SetField('esqt_qtdeprev',QEstQtde.fieldbyname('esqt_qtdeprev').ascurrency+(qtde*embalagem));
              Sistema.SetField('esqt_pecas',QEstQtde.fieldbyname('esqt_pecas').ascurrency+texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha]));

    // 01.10.13 - Metalforte - Atualizacao automatica do preco de venda
              if (Global.Topicos[1366]) and (novoprecovenda>novocusto) then
                Sistema.SetField('esqt_vendavis',novoprecovenda);
    // 14.02.14 - metalforte
                Sistema.Setfield('esqt_dtultcompra',Emissao);
    //////////////////
              Sistema.post('esqt_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                           ' and esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Unidade) );
          end;
///////////////////////////// 15.04.08
//          if strtointdef(Grid.cells[Grid.getcolumn('move_copa_codigo'),linha],0)>0 then
//            sqlcopa:=' and moco_copa_codigo='+Grid.cells[Grid.getcolumn('move_copa_codigo'),linha]
//          else
//            sqlcopa:=' and moco_copa_codigo=0';
          TEstGrades:=sqltoquery('select * from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+stringtosql(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha])+
                      ' and esgr_unid_codigo='+stringtosql(Unidade)+sqlcor+sqltamanho);
          if not TEstGrades.eof then begin
            novocustomedio:=FGeral.CustoMedio(TEstGrades.fieldbyname('esgr_customedio').ascurrency,novocusto,TEstGrades.fieldbyname('esgr_qtde').asfloat,Qtde);
            novocustomedioger:=FGeral.CustoMedioGerencial(TEstGrades.fieldbyname('esgr_customeger').ascurrency,novocustoger,TEstGrades.fieldbyname('esgr_qtdeprev').asfloat,qtde);
            Sistema.Edit('estgrades');
            if AtualizaCus(Grid.Cells[grid.getcolumn('move_esto_codigo'),linha]) then begin
              Sistema.SetField('esgr_custo',novocusto);
              Sistema.SetField('esgr_customedio',novocustomedio);
              Sistema.SetField('esgr_custoger',novocustoger);
              Sistema.SetField('esgr_customeger',novocustomedioger);
            end;
            Sistema.SetField('esgr_qtde',TEstgrades.fieldbyname('esgr_qtde').ascurrency+qtde);
            Sistema.SetField('esgr_qtdeprev',TEstgrades.fieldbyname('esgr_qtdeprev').ascurrency+qtde);
            Sistema.SetField('esgr_pecas',TEstgrades.fieldbyname('esgr_pecas').ascurrency+texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha]));
// 01.10.13 - Metalforte - Atualizacao automatica do preco de venda
            if (Global.Topicos[1366]) and (novoprecovenda>novocusto) then
              Sistema.SetField('esgr_vendavis',novoprecovenda);
// 14.02.14 - metalforte
            Sistema.Setfield('esgr_dtultcompra',Emissao);
            Sistema.post('esgr_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                         ' and esgr_status=''N'' and esgr_unid_codigo='+stringtosql(Unidade)+sqlcor+sqltamanho);
          end else begin
// 29.06.15
            codtamanho:=strtointdef(Grid.cells[Grid.getcolumn('move_tama_codigo'),linha],0);
            codcor:=strtointdef(Grid.cells[Grid.getcolumn('move_core_codigo'),linha],0);
            codcopa:=strtointdef(Grid.cells[Grid.getcolumn('move_copa_codigo'),linha],0);
            if (codtamanho>0) and (codcor>0) then
               Incluigrade(codcor,codtamanho,0,Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha]) ;
          end;
          FGeral.FechaQuery(TEstGrades);
///////////////////////////////
      end;   // DI - devolucao industrial

//////////
// 02.04.08 - Atualizacao do custo da mao de obra do produto  'ES' - retorno da industria cobrando os servi�os
/////////////////////////////////////////////////////////////////////////////////////////
      if (TipoMovimento=Global.CodRetornocomServicos) and (Grid.Cells[grid.getcolumn('moco_industrializa'),linha]<>'N') then begin
          pericms:=texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha]);
          peripi:=texttovalor(Grid.Cells[grid.getcolumn('move_aliipi'),linha]);
          pericmsfrete:=0;
          qtde:=texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]);
          novocusto:=FGeral.Custo(texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]),pericms,perfrete,peripi,pericmsfrete,perdesc,0,0,0,0,simplesnacional);
          novocustomedio:=FGeral.CustoMedio(QEstQtde.fieldbyname('esqt_customedioser').ascurrency,novocusto,QEstQtde.fieldbyname('esqt_qtde').asfloat,Qtde);
          Sistema.Edit('estoqueqtde');
          Sistema.SetField('esqt_custoser',novocusto);
          Sistema.SetField('esqt_customedioser',novocustomedio);
          Sistema.post('esqt_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                       ' and esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Unidade) );
///////////////////////////// 15.04.08
          if strtointdef(Grid.cells[Grid.getcolumn('move_core_codigo'),linha],0)>0 then
            sqlcor:=' and esgr_core_codigo='+Grid.cells[Grid.getcolumn('move_core_codigo'),linha]
          else
            sqlcor:=' and ( (esgr_core_codigo=0) or (esgr_core_codigo is null) )';
          if strtointdef(Grid.cells[Grid.getcolumn('move_tama_codigo'),linha],0)>0 then
            sqltamanho:=' and esgr_tama_codigo='+Grid.cells[Grid.getcolumn('move_tama_codigo'),linha]
          else
            sqltamanho:=' and ( (esgr_tama_codigo=0) or (esgr_tama_codigo is null) )';
//          if strtointdef(Grid.cells[Grid.getcolumn('move_copa_codigo'),linha],0)>0 then
//            sqlcopa:=' and moco_copa_codigo='+Grid.cells[Grid.getcolumn('move_copa_codigo'),linha]
//          else
//            sqlcopa:=' and moco_copa_codigo=0';

          Sistema.Edit('estgrades');
          Sistema.SetField('esgr_custoser',novocusto);
          Sistema.SetField('esgr_customedioser',novocustomedio);
          Sistema.post('esgr_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                       ' and esgr_status=''N'' and esgr_unid_codigo='+stringtosql(Unidade)+sqlcor+sqltamanho);
///////////////////////////////
      end;
//////////
// 24.04.12
      FGeral.FechaQuery(QEstQtde);

// 12.06.06 - baixa itens do pedido de compra caso houver - menos em CA-compra industria
//                                                       17.02.11 - Abra - Robson
///////////////////////////////////////////////////////////////
      if (pedido>0) and ( Pos(TipoMovimento,Global.CodCompraIndustria)=0 ) then begin
        if strtointdef(Grid.cells[Grid.getcolumn('move_core_codigo'),linha],0)>0 then
          sqlcor:=' and moco_core_codigo='+Grid.cells[Grid.getcolumn('move_core_codigo'),linha]
        else
          sqlcor:=' and moco_core_codigo=0';
        if strtointdef(Grid.cells[Grid.getcolumn('move_tama_codigo'),linha],0)>0 then
          sqltamanho:=' and moco_tama_codigo='+Grid.cells[Grid.getcolumn('move_tama_codigo'),linha]
        else
          sqltamanho:=' and moco_tama_codigo=0';
        if strtointdef(Grid.cells[Grid.getcolumn('move_copa_codigo'),linha],0)>0 then
          sqlcopa:=' and moco_copa_codigo='+Grid.cells[Grid.getcolumn('move_copa_codigo'),linha]
        else
          sqlcopa:=' and moco_copa_codigo=0';
// 05.08.09
        qtderec:=0;
        QPedido:=sqltoquery('select moco_qtderecebida from movcompras where moco_numerodoc='+inttostr(pedido)+
                 ' and moco_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                 sqlcor+sqltamanho+sqlcopa+
                 ' and moco_tipo_codigo='+Fornecedor.AsSql+' and moco_status=''N''' );
        if not QPedido.eof then
          qtderec:=QPedido.fieldbyname('moco_qtderecebida').ascurrency;
///////////////////////
        FGeral.FechaQuery(QPedido);
        Sistema.edit('movcompras');
        Sistema.setfield('moco_qtderecebida',qtderec+texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
// 01.10.09
        Sistema.setfield('moco_datanfcompra',Entrada);
        Sistema.setfield('moco_nfcompra',numero);
        Sistema.setfield('moco_transacaocompra',transacao);
///////////////////////////////
        Sistema.post('moco_numerodoc='+inttostr(pedido)+
                 ' and moco_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                 sqlcor+sqltamanho+sqlcopa+
                 ' and moco_tipo_codigo='+Fornecedor.AsSql+' and moco_status=''N''' );
      end;  //  pedido>0
///////////////////////
////////////////////////////////////// - 13.06.06 - explosao de materia prima
//        if pos( TipoMovimento,Global.CodDevolucaoind+';'+Global.Codretornoind )>0 then begin
// 04.09.06 - coddevolucaoind=RN � compra de materia prima portanto nao precisa explodir
        if pos( TipoMovimento,Global.CodDevolucaoind+';'+global.CodCompraProdutor+';'+Global.CodEntradaProdutor )>0 then begin
          if pos( TipoMovimento,global.CodCompraProdutor+';'+Global.CodEntradaProdutor)>0 then begin
            xTipoMovimento:=Global.CodBaixaMatEnt;
            xTipocad:='C'
          end else begin
            xTipoMovimento:=Global.CodBaixaMatSai;
            xTipoCad:='F';
          end;
          if strtointdef(Grid.cells[Grid.getcolumn('move_core_codigo'),linha],0)>0 then
            sqlcor:=' and cust_core_codigo='+Grid.cells[Grid.getcolumn('move_core_codigo'),linha]
          else
            sqlcor:=' and cust_core_codigo=0';
          if strtointdef(Grid.cells[Grid.getcolumn('move_tama_codigo'),linha],0)>0 then
            sqltamanho:=' and cust_tama_codigo='+Grid.cells[Grid.getcolumn('move_tama_codigo'),linha]
          else
            sqltamanho:=' and cust_tama_codigo=0';
          if strtointdef(Grid.cells[Grid.getcolumn('move_copa_codigo'),linha],0)>0 then
            sqlcopa:=' and cust_copa_codigo='+Grid.cells[Grid.getcolumn('move_copa_codigo'),linha]
          else
            sqlcopa:=' and cust_copa_codigo=0';
          QCusto:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
                  ' inner join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Global.CodigoUnidade)+' )'+
                  ' where cust_status=''N'' and cust_esto_codigo='+stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                   sqlcor+sqltamanho+sqlcopa+' order by cust_esto_codigomat');
          while (not QCusto.eof) and (Global.Topicos[1307] ) do begin
              if prim then begin
                Sistema.Insert('Movesto');
                Sistema.SetField('moes_transacao',Transacao);
                Sistema.SetField('moes_operacao',GetOperacao);
                Sistema.SetField('moes_status','N');
//                Sistema.SetField('moes_numerodoc',100+numero);
                Sistema.SetField('moes_numerodoc',numero*10);
                Sistema.SetField('moes_tipomov',xTipoMovimento);
                Sistema.SetField('moes_comv_codigo',0);
                Sistema.SetField('moes_unid_codigo',Unidade);
            //    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
                Sistema.SetField('moes_tipo_codigo',Fornecedor.AsInteger);
                if xtipocad='F' then begin
                  Sistema.SetField('moes_estado',Fornecedor.ResultFind.fieldbyname('forn_uf').AsString);
                  Sistema.SetField('moes_cida_codigo',Fornecedor.ResultFind.fieldbyname('forn_cida_codigo').AsInteger);
                end else begin
                  Sistema.SetField('moes_estado',Fornecedor.ResultFind.fieldbyname('clie_uf').AsString);
                  Sistema.SetField('moes_cida_codigo',Fornecedor.ResultFind.fieldbyname('clie_cida_codigo_res').AsInteger);
                end;
                Sistema.SetField('moes_tipocad',xtipocad);
                Sistema.SetField('moes_datalcto',Sistema.Hoje);
                Sistema.SetField('moes_dataemissao',Sistema.Hoje);
                Sistema.SetField('moes_datamvto',Entrada);
                Sistema.SetField('moes_DataCont',Movimento);
                Sistema.SetField('moes_vlrtotal',0);
                Sistema.SetField('moes_baseicms',0);
                Sistema.SetField('moes_valoricms',0);
                Sistema.SetField('moes_basesubstrib',0);
                Sistema.SetField('moes_valoricmssutr',0);
                Sistema.SetField('moes_totprod',0);
                Sistema.SetField('moes_vlrtotal',0);
                Sistema.SetField('moes_valortotal',0);
                Sistema.SetField('moes_natf_codigo','');
                Sistema.SetField('moes_freteciffob','');
                Sistema.SetField('moes_frete',0);
  //              Sistema.SetField('moes_vispra',FCondPagto.GetAvPz(Condicao));
                Sistema.SetField('moes_especie',Arq.TConfmovimento.fieldbyname('comv_especie').asstring);
                Sistema.SetField('moes_serie',Arq.TConfmovimento.fieldbyname('comv_serie').asstring);
                Sistema.SetField('moes_tran_codigo',Arq.TTransp.fieldbyname('tran_codigo').asstring);
                Sistema.SetField('Moes_Perdesco',0);
                Sistema.SetField('Moes_Peracres',0);
                Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
                Sistema.SetField('moes_pedido',Pedido);
                Sistema.SetField('moes_tipo_codigoind',Fornecedor.AsInteger);   //  27.07.06
                Sistema.Post;
                prim:=false;
              end;
              Sistema.Insert('Movestoque');
              Sistema.SetField('move_esto_codigo',QCusto.fieldbyname('cust_esto_codigomat').asstring);
              Sistema.SetField('move_tama_codigo',QCusto.fieldbyname('cust_tama_codigomat').asinteger);
              Sistema.SetField('move_core_codigo',QCusto.fieldbyname('cust_core_codigomat').asinteger);
              Sistema.SetField('move_copa_codigo',QCusto.fieldbyname('cust_copa_codigo').asinteger);
              Sistema.SetField('move_transacao',transacao);
              Sistema.SetField('move_operacao',FGeral.GetOperacao);
//              Sistema.SetField('move_numerodoc',100+numero);
              Sistema.SetField('move_numerodoc',numero*10);
              Sistema.SetField('move_status','N');
              Sistema.SetField('move_tipomov',xTipoMovimento);
              Sistema.SetField('move_unid_codigo',Unidade);
              Sistema.SetField('move_tipo_codigo',Fornecedor.AsInteger);
              Sistema.SetField('move_tipocad',xTipocad);
//              if movimento>0 then begin
// 02.11.07
              novocusto:=0;
              novocustomedio:=0;
              if Global.Topicos[1308] then begin
                novocusto:=totalitem*(Qcusto.fieldbyname('cust_percusto').ascurrency/100) / (texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100));
                Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100));
                if (novocusto<100000) or (novocusto>-50000) then begin
                  Sistema.SetField('move_custo',novocusto );
                  Sistema.SetField('move_custoger',novocusto);
                  Sistema.SetField('move_venda',novocusto);
                end else begin
                  Sistema.SetField('move_custo',989898 );   // 16.05.08
                  Sistema.SetField('move_custoger',989898);
                  Sistema.SetField('move_venda',989898);
                end;
              end else begin
                Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency);
              end;
              Sistema.SetField('move_datacont',Movimento);
//              end else begin
//                Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('qtdeprev'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency);
//                Sistema.SetField('move_venda',??);
//              end;
              Sistema.SetField('move_pecas',texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency );
              Sistema.SetField('move_datalcto',Sistema.Hoje);
              Sistema.SetField('move_datamvto',Entrada);
              Sistema.SetField('move_qtderetorno',0);
              QCustoMat:=sqltoquery( FEstoque.Getsqlcustos(QCusto.fieldbyname('cust_esto_codigomat').asstring,Global.CodigoUnidade,
                          QCusto.fieldbyname('cust_tama_codigomat').asinteger,QCusto.fieldbyname('cust_core_codigomat').asinteger) );
              if (not QCustoMat.eof) and ( not Global.Topicos[1308] ) then begin
                Sistema.SetField('move_custo',QCustomat.fieldbyname('custo').ascurrency);
                Sistema.SetField('move_custoger',QCustomat.fieldbyname('custoger').ascurrency);
                Sistema.SetField('move_customedio',QCustomat.fieldbyname('customedio').ascurrency);
                Sistema.SetField('move_customeger',QCustomat.fieldbyname('customeger').ascurrency);
                Sistema.SetField('move_venda',QCustomat.fieldbyname('customeger').ascurrency);
              end;
              FGeral.Fechaquery(QCustomat);
              Sistema.SetField('move_cst','');
              Sistema.SetField('move_aliicms',0);
              QEst:=sqltoquery('select esto_grup_codigo,esto_sugr_codigo,esto_fami_codigo from estoque where esto_codigo='+stringtosql(QCusto.fieldbyname('cust_esto_codigomat').asstring));
              if not QEst.eof then begin
                Sistema.SetField('move_grup_codigo',QEst.FieldByName('esto_grup_codigo').AsInteger);
                Sistema.SetField('move_sugr_codigo',QEst.fieldbyname('esto_sugr_codigo').AsInteger);
                Sistema.SetField('move_fami_codigo',QEst.fieldbyname('esto_fami_codigo').AsInteger);
              end;
              FGeral.Fechaquery(QEst);
              Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
              Sistema.SetField('move_aliipi',0);
              Sistema.SetField('move_tipo_codigoind',Fornecedor.AsInteger);   //  27.07.06
              Sistema.Post;

              if Global.Topicos[1308] then begin
                QEstQtde:=sqltoquery('select * from estoqueqtde where esqt_esto_codigo='+stringtosql(QCusto.fieldbyname('cust_esto_codigomat').asstring)+
                               ' and esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Unidade) );
                if QEstQtde.fieldbyname('esqt_qtde').ascurrency>0 then
                  novocustomedio:= (novocusto*texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100) + ( QEstQtde.fieldbyname('esqt_qtde').ascurrency*QEstQtde.fieldbyname('esqt_customedio').ascurrency ) ) /
                                   ( QEstQtde.fieldbyname('esqt_qtde').ascurrency+texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100) )
                else
                  novocustomedio:= (novocusto*texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100)  ) /
                                   ( texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100) );
                Sistema.Edit('estoqueqtde');
                Sistema.SetField('esqt_custo',novocusto);
                Sistema.SetField('esqt_custoger',novocusto);
// 16.05.08 - problemas no custo dai zera para nao travar as notas NP ent. produtor
                if (QEstQtde.fieldbyname('esqt_customedio').ascurrency>100000) or (QEstQtde.fieldbyname('esqt_customedio').ascurrency<-50000) then begin
                  Sistema.SetField('esqt_customedio',0 );
                  Sistema.SetField('esqt_customeger',0);
                end else begin
                  Sistema.SetField('esqt_customedio',novocustomedio );
                  Sistema.SetField('esqt_customeger',novocustomedio);
                end;
                Sistema.post('esqt_esto_codigo='+stringtosql(QCusto.fieldbyname('cust_esto_codigomat').asstring)+
                               ' and esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Unidade) );
                FGeral.FechaQuery(QEstQtde);
              end;

//
// 08.10.07 - 02.11.07 - retirado pois esta parte ser� feita na op��o 'desossa'
//              if Global.Topicos[1203] then  // aqui caso o 'nivel 1' da composicao do boi tiver sua propria composicao
//                MovimentoEstoqueComposicao(unidade,QCusto.fieldbyname('cust_esto_codigomat').asstring,'E',transacao,xTipoMovimento,xtipocad,
//                            texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency,
//                            texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha]),100+numero,Fornecedor.AsInteger,Movimento,Entrada);

  //////////////////////////////////////
            QCusto.next;
          end; // percorre planilha de custos
          FGeral.Fechaquery(QCusto);
        end;  // somente DI e NP
////////////////////////

// 14.02.14 - retirado apra atualiza o custo e pre�o de venda quando for o caso
//      Sistema.Edit('estoqueqtde');
//      Sistema.Setfield('esqt_dtultcompra',Emissao);
//      Sistema.Post('esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Unidade)+' and esqt_esto_codigo='+
//                     stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );

      reducao:=0;isentas:=0;outras:=0;
{ - 02.11.07 - colocado 'mais pra cima'
      venda:=texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]);
      qtde:=texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]);
      totalitem:=venda*qtde;
}
      if Peracre>0 then begin
        totalitem:=totalitem+FGEral.Arredonda( totalitem*(Peracre/100) ,2  );
      end else if (Perdesco>0) and ( perdesc=0 ) then begin
        totalitem:=totalitem-FGEral.Arredonda( totalitem*(Perdesco/100) ,2 );
// 27.04.15
      end else if (Perdesco>0) and ( perdesc>0 ) then begin
        totalitem:=totalitem-FGEral.Arredonda( totalitem*(Perdesc/100) ,2 );
      end;
// 26.03.07
      valoripi:= totalitem * ( texttovalor(Grid.Cells[grid.getcolumn('move_aliipi'),linha])/100 );
/////////////////
// 23.05.07
      totalbaseicms:=totalitem - ( totalitem*(texttovalor(Grid.Cells[grid.getcolumn('move_redubase'),linha])/100));
      reducao:=texttovalor(Grid.Cells[grid.getcolumn('move_redubase'),linha]);
      if baseicms>0 then begin
        ValorContabil:=FGeral.Arredonda(totalitem + valoripi,2);
        Base:=FGeral.Arredonda(totalbaseicms + valoripi,2);
      end else begin
        ValorContabil:=FGeral.Arredonda(totalitem,2);
        Base:=FGeral.Arredonda(totalbaseicms,2);
      end;
// 23.02.05
      pericms:=texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha]);
//      if (TipoMovimento<>Global.CodDevolucaoSerie5) and (TipoMovimento<>Global.CodDevolucaoVenda) then
//      if pos( TipoMovimento,tiposdif )=0 then
// 11.12.13 - devido a nfe de estorno
      if ytipocad='F' then
        margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],Unidade,Fornecedor.resultfind.fieldbyname('forn_uf').asstring))
      else
        margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],Unidade,Fornecedor.resultfind.fieldbyname('clie_uf').asstring));
      if Margemlucro>0 then
        basesubs:=base*(1+(margemlucro/100))
      else
        basesubs:=0;
// 18.11.04
      if base=0 then begin
        outras:=valorcontabil;
        base:=valorcontabil;
      end else if valorcontabil>base then   // 23.05.07
        outras:=valorcontabil-base;
      base:=totalitem;    // para guardar a base sem a redu��o
// 23.10.07
      ycfop:=xcfop;
      if ( Grid.Cells[grid.getcolumn('move_cst'),linha]=FSittributaria.GetCST(cstservicos) )  and (cstservicos<>0) then begin
        ycfop:=cfopservicos;
        if trim(ycfop)='' then
          ycfop:=xcfop;
// 13.09.10
      end else if trim(Grid.Cells[grid.getcolumn('move_natf_codigo'),linha])<>'' then begin
               ycfop:=Grid.Cells[Grid.getcolumn('move_natf_codigo'),linha] ;
      end;

      if (total=0)  and (Montabase='S' ) then begin  // 22.06.06 - para nf de importacao nao gera base aqui...
// 11.07.13 - SM
        if pos(Grid.Cells[grid.getcolumn('move_natf_codigo'),linha],'1933/2933')>0 then
          FGeral.GeraListaCstPerc(Grid.Cells[grid.getcolumn('move_cst'),linha],pericms,
                       valorcontabil,base,reducao,isentas,outras,basesubs,ListaCstPerc,'S',ycfop)
        else
          FGeral.GeraListaCstPerc(Grid.Cells[grid.getcolumn('move_cst'),linha],pericms,
                       valorcontabil,base,reducao,isentas,outras,basesubs,ListaCstPerc,'I',ycfop);
      end;
/////// 18.10.10
      if ( trim( ArqXml )<>'' ) then begin
        QXml:=Sqltoquery('select * from movnfeestoque where mnfe_status=''N'''+
// 24.04.12
//                         ' and mnfe_esto_codigo='+Stringtosql(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha])+
                         ' and mnfe_tipo_codigo='+Inttostr(Fornecedor.AsInteger)+
                         ' and mnfe_forn_codigo='+Stringtosql(Grid.Cells[Grid.getcolumn('produtonfe'),linha]) );
        if QXml.eof then begin
          Sistema.Insert('movnfeestoque');
          Sistema.SetField('mnfe_status','N');
          Sistema.SetField('mnfe_esto_codigo',Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha] );
          Sistema.SetField('mnfe_tipo_codigo',Fornecedor.asinteger);
          Sistema.SetField('mnfe_forn_codigo',copy(Grid.Cells[Grid.getcolumn('produtonfe'),linha],1,20));
          Sistema.SetField('mnfe_data',Entrada);
          Sistema.Post();
        end else begin   // 24.04.12
          Sistema.Edit('movnfeestoque');
          Sistema.SetField('mnfe_esto_codigo',Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha] );
          Sistema.SetField('mnfe_data',Entrada);
          Sistema.Post('mnfe_status=''N'' and mnfe_tipo_codigo='+Inttostr(Fornecedor.AsInteger)+
                       ' and mnfe_forn_codigo='+Stringtosql(copy(Grid.Cells[Grid.getcolumn('produtonfe'),Grid.row],1,20) ) );
        end;
        FGeral.FechaQuery( QXml );
      end;

    end; // ref. a ter codigo preenchido no grid
//////////////////////
  end; // ref. ao grid

// 12.06.06 - baixa itens do pedido de compra caso houver
  if pedido>0 then begin
    Sistema.edit('movcomp');
    Sistema.setfield('mocm_datarecebido',entrada);
    Sistema.post('mocm_numerodoc='+inttostr(pedido)+' and mocm_status=''N''');
  end;

// 09.05.06 - colocado aqui o tipo DI
// 08.04.10 - retirado aqui o tipo DI - Abra - Ligiane - Fran
  if (pos(TipoMovimento,Global.CodDevolucaoRoman+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoVendaConsig)=0) or
//     ( (pos(TipoMovimento,Global.CodDevolucaoRoman+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoVendaConsig+';'+Global.CodDevolucaoInd)>0)
     ( (pos(TipoMovimento,Global.CodDevolucaoRoman+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoVendaConsig)>0)
        and (Movimento>1)  )
    then begin
    for p:=0 to ListaCstPerc.Count-1 do begin
        PCstPerc:=Listacstperc[p];
        Sistema.Insert('MovBase');
        Sistema.SetField('movb_transacao',Transacao);
        Sistema.SetField('movb_operacao',GetOperacao);
        Sistema.SetField('movb_status','N');
        Sistema.SetField('movb_numerodoc',Numero);
        Sistema.SetField('Movb_cst',Pcstperc.cst);
///        Sistema.SetField('Movb_Codigosfis',     'Simb',  talvez nao precise pois ja gravo o % icms

//        Sistema.SetField('Movb_TpImposto','I');   // fixo I-Icms
// 13.07.06
            Sistema.SetField('Movb_TpImposto',Pcstperc.tpimposto );
  // codigo de valores fiscais ( 1,,5 da impressao do livro fiscal )
//        Sistema.SetField('Movb_CVF',cvf);    // checar - talvez nao precise
// ver como somar o frete + seguro no valor contabil agora o somente na gera��o para o livro fiscal
//        if p=0 then begin
//          Sistema.SetField('Movb_BaseCalculo',Pcstperc.base+frete+seguro);
//          Sistema.SetField('Movb_Imposto',FGeral.Arredonda((pcstperc.base+frete+seguro)*(pcstperc.perc/100),2) );
//        end else begin
// 21.03.07 - retirado pois na entrada nao � necessario...
          Sistema.SetField('Movb_BaseCalculo',Pcstperc.base);
// 23.10.07
          if pcstperc.reducao>0 then
// 22.05.07
            Sistema.SetField('Movb_Imposto',FGeral.Arredonda( (( pcstperc.base*(pcstperc.reducao/100) ) ) * (pcstperc.perc/100),2) )
          else
            Sistema.SetField('Movb_Imposto',FGeral.Arredonda( (pcstperc.base) * (pcstperc.perc/100),2) );
 //       end;
        Sistema.SetField('Movb_Aliquota',pcstperc.perc);
        Sistema.SetField('Movb_ReducaoBc',pcstperc.reducao);
        Sistema.SetField('Movb_Isentas',pcstperc.isentas);
        Sistema.SetField('Movb_Outras' ,pcstperc.outras);
        Sistema.SetField('Movb_tipomov',TipoMovimento);
        Sistema.SetField('Movb_unid_codigo',Unidade);  // 13.07.06
        Sistema.SetField('Movb_natf_codigo',pcstperc.cfop);   //   23.10.07
        Sistema.Post();
    end;
  end;


end;

//////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaMestreNFCompra(Emissao,Entrada: TDatetime;
//////////////////////////////////////////////////////////////////////////////////
  Fornecedor: TSqlEd ; TipoCad: String; Unidade, TipoMovimento, Transacao, Condicao,
  Natureza, ciffob: string; Numero, CodigoMov: Integer; Valortotal,
  baseicms, valoricms, basesubs, icmssubs, vlrfrete,peracre,perdesco,totprod: currency ;
  total:currency=0 ; valortot:currency=0 ; Movimento:TDatetime=0 ; Mensagem:string=''  ; Tipodoc:string='' ;
  Serie:string='' ; servicos:currency=0  ; Fpgt_codigo:string=''  ; Pedido:integer=0 ; valoripi:currency=0 ;
  seguro:currency=0 ; outrasdesp:currency=0  ; FornecInd:integer=0  ; pesoliq:currency=0 ; nfprodutor:string='' ;
  funrural:currency=0 ; cotacapital:currency=0 ; contagerencial:integer=0 ; romaneio:string='' ; obra:string='' ;
  cola_codigo:string='' ; km:integer=0 ; ContaCredito:integer=0  ; ACBrNFe1:TACBrNfe=nil ;
  xnumerodi:string='' ; xdatadi:TDatetime=0 ; xlocaldesem:string='';xdatadesem:TDatetime=0;xufdesem:string='' ;
  ctran_codigo:string='';cseto_codigo:string=''; xchavecte:string='' ; xGrid:TSqlDtGrid=nil ; xValorGta:currency=0;
  xvlrINss:currency=0;xvlrpis:currency=0;xvlrcofins:currency=0;xvlrcsll:currency=0;xvlrir:currency=0);

var TiposSerieDiversos,sep,TipoEntradaAbate,xsetores,clifor,campos,valores,ccredito,cdebito,transacaocontax,historico:string;
    xnfprodutor,xnfprodutor2,xnfprodutor3,xnfprodutor4,xnfprodutor5,i:integer;
    Lista:TStringlist;
    p,credito,debito,xcredito:integer;
    campo,camponaosocio:TDicionario;
    QTransacao,QUnid_codigo:TSqlquery;
    vlrretencoes:currency;

// 20.06.16
    procedure GetContasExportacao(Vistaprazo, Es, tipomov,moes_tipocad,moes_transacao,moes_unid_codigo: string;  CodigoMov,Moes_tipo_codigo,Moes_plan_codigo: integer );
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var QConf:TSqlquery;
        contagerencial:integer;

    begin
      if FConfMovimento.GetContaConfMovimento(CodigoMov) then begin

          QConf:=sqltoquery('select * from confmov where comv_codigo='+inttostr(CodigoMov));
          if not QConf.eof then begin
              debito:=QConf.fieldbyname('comv_debito').asinteger;
              credito:=QConf.fieldbyname('comv_credito').asinteger;
              cdebito:=QConf.fieldbyname('comv_debito').asstring;
              ccredito:=QConf.fieldbyname('comv_credito').asstring;
          end;
// 19.03.09
          if credito=0 then begin
             if moes_tipocad='F' then begin
               credito:=FFornece.GetContaExp(moes_tipo_codigo);
               ccredito:=FFornece.GetCnpjCpf(moes_tipo_codigo,'S');
             end else
               credito:=FCadcli.GetContaExp(moes_tipo_codigo);
          end;
// 20.03.09
        if credito=0 then
           credito:=QUnid_codigo.fieldbyname('unid_fornecedores').asinteger;
// 20.04.10 - Abra - Ligiane
        if Tipomov=Global.CodCompraImobilizado then begin
          debito:=moes_plan_codigo;
          cdebito:=inttostr(moes_plan_codigo);
        end;
///////////////////
// 25.11.09 - capeg - leo jaime  // 21.10.11 - leo jaime mas no SM
        if (Vistaprazo='V') and (not Global.Topicos[1018]) then begin
// para nao lan�ar as compras a vista
            debito:=0;
            credito:=0;
            cdebito:='';
            ccredito:='';
        end else if (Vistaprazo='V') and (Global.Topicos[1018]) then begin
          if es='V' then begin
            debito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
            credito:=QUnid_codigo.fieldbyname('Unid_vendaavista').asinteger;
          end else begin
            if debito=0 then
              debito:=QUnid_codigo.fieldbyname('unid_comprasavista').asinteger;
            credito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
          end;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
        end;
        FGeral.FechaQuery(QConf);
/////////////////////////////////////////////////////////////
      end else if Tipomov=Global.CodTransfEntrada then begin
        debito:=QUnid_codigo.fieldbyname('unid_transentrada').asinteger;
// 07.08.14 - Novicarnes - Angela
//        credito:=ctatransestoque;
        credito:=QUnid_codigo.fieldbyname('Unid_ctbtransnume').asinteger;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
      end else if Tipomov=Global.CodTransfSaida then begin
//        debito:=ctatransestoque;
// 07.08.14 - Novicarnes - Angela
        debito:=QUnid_codigo.fieldbyname('Unid_ctbtransnume').asinteger;
        credito:=QUnid_codigo.fieldbyname('unid_transsaida').asinteger;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
////////_//////////////////////////////////////////////////////////////
      end else if pos(Tipomov,Global.CodDevolucaoProntaEntrega+';'+
                  global.CodDevolucaoVenda+';'+Global.CodDevolucaoConsigMerc+';'+Global.CodDevolucaoIgualVenda)>0 then begin
        debito:=QUnid_codigo.fieldbyname('unid_devovenda').asinteger;
        cdebito:=inttostr(debito);
//        credito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
// 02.08.07
        if Global.Topicos[1253] then begin
           if moes_tipocad='F' then begin
             credito:=FFornece.GetContaExp(moes_tipo_codigo);
             ccredito:=FFornece.GetCnpjCpf(moes_tipo_codigo,'S');
           end else begin
             credito:=FCadcli.GetContaExp(moes_tipo_codigo);
             ccredito:=FCadcli.GetCnpjCpf(moes_tipo_codigo,'S');
// 23.09.08 -vanessa - novicarnes
             if pos(Tipomov,Global.CodDevolucaoProntaEntrega+';'+global.CodDevolucaoVenda+';'+Global.CodDevolucaoConsigMerc+';'+Global.CodDevolucaoIgualVenda)>0 then
//               debito:=FCadcli.GetContaExpDevVenda(Q.fieldbyname('moes_tipo_codigo').asinteger);
// 08.01.09
               credito:=FCadcli.GetContaExpDevVenda(moes_tipo_codigo);
           end;
        end else
          credito:=QUnid_codigo.fieldbyname('unid_clientes').asinteger;
//////////////////
// 23.11.05 - ajustado em 20.04.09
      end else if pos(Tipomov,Global.CodDevolucaoCompra)>0 then begin
//        debito:=95;  // falta criar conta no cadastro de unidades
// s� hj ela finalmente disse q tinha q criar uma conta de dev. para cada fornec.
        if Global.Topicos[1253] then begin
// 25.01.10 - Abra - Ligiane
           if Global.Topicos[1008] then begin
             if moes_tipocad='F' then begin
               debito:=FFornece.GetContaExp(moes_tipo_codigo);
               cdebito:=FFornece.GetCnpjCpf(moes_tipo_codigo,'S');
             end else begin
               debito:=FCadcli.GetContaExp(moes_tipo_codigo);
               cdebito:=FCadcli.GetCnpjCpf(moes_tipo_codigo,'S')
             end;
           end else begin
             if moes_tipocad='F' then
               debito:=FFornece.GetContaExpDevCompra(moes_tipo_codigo)
             else begin
               debito:=FCadcli.GetContaExpDevVenda(moes_tipo_codigo);
             end;
           end;
        end else
          debito:=QUnid_codigo.fieldbyname('unid_fornecedores').asinteger;
        credito:=QUnid_codigo.fieldbyname('unid_devocompra').asinteger;

// 06.06.12 - Benato -> SM - lan�amento dos cupons fiscais
      end else if (CodigoMov=FGeral.GetConfig1AsInteger('ConfMovECF')) and ( codigomov>0 ) then begin

        debito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
        credito:=QUnid_codigo.fieldbyname('Unid_vendaavista').asinteger;

      end else if es='V' then begin

        debito:=QUnid_codigo.fieldbyname('unid_clientes').asinteger;
        credito:=QUnid_codigo.fieldbyname('unid_vendaaprazo').asinteger;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
// 12.05.10 - Novi - devolucao de compra de produtor
        if pos(Tipomov,Global.CodDevolucaoCompraProdutor)>0 then
           credito:=QUnid_codigo.fieldbyname('unid_devocompra').asinteger;

// 18.06.07 - para usar a conta do cadastro de clientes
        if Global.Topicos[1253] then begin
//           if EdMesano.isempty then begin
//             debito:=FCadcli.GetContaExp(moes_tipo_codigo,'','XX');
//             cdebito:=FCadcli.GetCnpjCpf(moes_tipo_codigo,'S');
//           end else begin
             debito:=FCadcli.GetContaExp(moes_tipo_codigo,'','XY');
             cdebito:=FCadcli.GetCnpjCpf(moes_tipo_codigo,'S');
             if Global.topicos[1018] then begin
               debito:=QUnid_codigo.fieldbyname('unid_clientes').asinteger;
               cdebito:=FCadcli.GetCnpjCpf(moes_tipo_codigo,'S');
             end;
//           end;
// 11.04.12 - para planos que nao detalham clientes
// 19.04.13 - Novicarnes - OU para clientes novos que ainda nao foi colocado o reduzido no sac
//            entao foi retirado isto pq se t� setado o 1253 � pra avisar q nao tem...
//           if debito=0 then debito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;

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
            debito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
            credito:=QUnid_codigo.fieldbyname('Unid_vendaavista').asinteger;
          end else begin
// 04.05.05 - para nao lan�ar as vendas/compras a vista
            debito:=0;
            credito:=0;
          end;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
        end;
{
// 22.10.10 - NOvi - vava - debito e credito informado na digitacao da nota de entrada
      end else if (es='C') and (pos(Tipomov,Global.CodCompraSemfinan)>0) and
                  ( Global.Topicos[1347] )
        then begin

          debito:=FPlano.GetContaExportacao(moes_plan_codigo,EdUnid_codigo.Text);
          credito:=FPlano.GetContaExportacao(Q.fieldbyname('moes_plan_codigocre').asinteger,EdUnid_codigo.Text);
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
}
      end else if es='C' then begin

        debito:=QUnid_codigo.fieldbyname('unid_compras').asinteger;
//      06.09.16
        if (camponaosocio.Tipo<>'') and ( pos(Tipomov,Global.CodCompraProdutor+';'+Global.CodDevolucaoCompraProdutor+';'+Global.CodEntradaProdutor)>0 ) then begin
           if not FCadCli.Getecooperado(Q.fieldbyname('moes_tipo_codigo').asinteger) then
             debito:=QUnid_codigo.fieldbyname('unid_comprasNS').asinteger;
        end;
//////////////
        contagerencial:=fGeral.GetContaDespesa(moes_transacao);
// 02.08.07                    // 08.08.08
        if (Contagerencial>0) and ( pos(Tipomov,Global.CodCompraProdutor+';'+Global.CodDevolucaoCompraProdutor+';'+Global.CodEntradaProdutor)=0 )
           and ( not Global.Topicos[1003] )  then  // 05.11.10
          debito:=FPlano.GetContaExportacao(contagerencial,moes_Unid_codigo)
        else if tipomov=Global.CodConhecimento then begin
// 23.10.07
          debito:=QUnid_codigo.fieldbyname('unid_ctbfrete').asinteger;
          if debito=0 then
            debito:=QUnid_codigo.fieldbyname('unid_compras').asinteger;
        end;
        cdebito:=inttostr(debito);
        if Global.Topicos[1253] then begin
           if moes_tipocad='F' then begin
             credito:=FFornece.GetContaExp(moes_tipo_codigo);
             ccredito:=FFornece.GetCnpjCpf(moes_tipo_codigo,'S');
// 20.03.09 - caso ainda nao houver no fornecedor a conta configurada
             if credito=0 then
                credito:=QUnid_codigo.fieldbyname('unid_fornecedores').asinteger;
           end else  begin
               credito:=FCadcli.GetContaExp(moes_tipo_codigo);
               ccredito:=FCadcli.GetCnpjCpf(moes_tipo_codigo,'S');
           end;
// 30.10.09 - Abra - Ligiane - adiantamento de pagamento de despesa - credito adiantamento
//            e debito a despesa informada
           campo:=Sistema.GetDicionario('movesto','moes_plan_codigo');
           if ( tipomov=Global.CodCompraRemessaFutura )
              and ( campo.Tipo<>'' ) then begin
              QConf:=sqltoquery('select * from confmov where comv_codigo='+inttostr(CodigoMov));
              if not QConf.eof then begin
                 if QConf.fieldbyname('comv_debito').asinteger=0 then begin
//                   debito:=Q.fieldbyname('moes_plan_codigo').asinteger;  //
// 17.12.09
                   debito:=FPlano.GetContaExportacao(moes_plan_codigo,moes_unid_codigo);
// aqui ver se cria parametro para 'usar mesmo reduzido da contabilidad'
                   credito:=QConf.fieldbyname('comv_credito').asinteger;
                 end;
              end;
              FGeral.FechaQuery(QConf);
             ccredito:=inttostr(credito);
             cdebito:=inttostr(debito);
           end;
// 25.11.09
           if Vistaprazo='V' then begin
// 05.11.10 - para lan�ar as vendas a vista
              if Global.Topicos[1018] then begin
                if debito=0 then  // 21.10.11
                  debito:=QUnid_codigo.fieldbyname('unid_comprasavista').asinteger;
                credito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
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
            if QUnid_codigo.fieldbyname('unid_fornecedores').asinteger>0 then
              credito:=QUnid_codigo.fieldbyname('unid_fornecedores').asinteger
            else begin
              credito:=FFornece.GetContaExp(moes_tipo_codigo);
              ccredito:=FFornece.GetCnpjCpf(moes_tipo_codigo,'S');
            end;

        end;

        if Vistaprazo='V' then begin
// 05.11.10 - para lan�ar as compras a vista
              if Global.Topicos[1018] then begin
                debito:=QUnid_codigo.fieldbyname('unid_comprasavista').asinteger;
                credito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
              end else begin
// para nao lan�ar as compras a vista
                debito:=0;
                credito:=0;
              end;
             ccredito:=inttostr(credito);
             cdebito:=inttostr(debito);
         end;

      end;
    end;

begin
///////////////////////////////////////////

  TipoEntradaAbate:='EA';
  if pos(TipoMovimento,Global.TiposEntrada)>0 then begin
    xnfprodutor:=0;
    xnfprodutor2:=0;
    xnfprodutor3:=0;
    xnfprodutor4:=0;
    xnfprodutor5:=0;
    sep:=';';
    if trim(nfprodutor)<>'' then begin
      if pos(',',nfprodutor)>0 then
        sep:=','
      else if pos(';',nfprodutor)>0 then
        sep:=';'
      else if pos('/',nfprodutor)>0 then
        sep:='/'
      else
        sep:='.';
      Lista:=TStringlist.create;
      strtolista(Lista,nfprodutor,sep,true);
      for p:=0 to LIsta.count-1 do begin
        if p=0 then
          xnfprodutor:=strtointdef(Lista[p],0)
        else if p=1 then
          xnfprodutor2:=strtointdef(Lista[p],0)
        else if p=2 then
          xnfprodutor3:=strtointdef(Lista[p],0)
        else if p=3 then
          xnfprodutor4:=strtointdef(Lista[p],0)
        else if p=4 then
          xnfprodutor5:=strtointdef(Lista[p],0);
      end;
    end;
    Sistema.Insert('Movesto');
    Sistema.SetField('moes_transacao',Transacao);
    Sistema.SetField('moes_operacao',GetOperacao);
    Sistema.SetField('moes_status','N');
    Sistema.SetField('moes_numerodoc',Numero);
    Sistema.SetField('moes_tipomov',TipoMovimento);
    Sistema.SetField('moes_comv_codigo',codigomov);
    Sistema.SetField('moes_unid_codigo',Unidade);
//    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
    Sistema.SetField('moes_tipo_codigo',Fornecedor.AsInteger);
// 31.07.07
//    if codcidade=0 then begin
      if Tipocad='F' then begin
        Sistema.SetField('moes_estado',Fornecedor.ResultFind.fieldbyname('forn_uf').AsString);
        Sistema.SetField('moes_cida_codigo',Fornecedor.ResultFind.fieldbyname('forn_cida_codigo').AsInteger);
      end else if Tipocad='C' then begin
        Sistema.SetField('moes_estado',Fornecedor.ResultFind.fieldbyname('clie_uf').AsString);
        Sistema.SetField('moes_cida_codigo',Fornecedor.ResultFind.fieldbyname('clie_cida_codigo_res').AsInteger);
      end else begin
        Sistema.SetField('moes_estado',FTransp.GetUF(Fornecedor.asinteger));
        Sistema.SetField('moes_cida_codigo',Fornecedor.Resultfind.fieldbyname('tran_cida_codigo').AsInteger);
      end;
//    end else begin
//        Sistema.SetField('moes_estado',FCidades.GetUF(codcidade));
//        Sistema.SetField('moes_cida_codigo',codcidade);
//    end;
    Sistema.SetField('moes_tipocad',tipocad);
    Sistema.SetField('moes_datalcto',Sistema.Hoje);
    Sistema.SetField('moes_datamvto',Entrada);
// 11.05.05 - colocado de TE 'em diante' para gravar certo a datacont ( movimento )
// +';'+Global.CodTransfEntrada+';'+Global.CodTransImobE+';'+global.CodTransfEnt
    if pos(TipoMovimento,Global.CodDevolucaoRoman+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoVendaConsig)>0 then begin
      Sistema.SetField('moes_vlrtotal',Valortotal);
      Sistema.SetField('moes_totprod',totProd);
      Sistema.SetField('moes_repr_codigo',Fornecedor.ResultFind.fieldbyname('clie_repr_codigo').AsInteger);
      if Movimento>1 then begin
        Sistema.SetField('moes_DataCont',Entrada);
        Sistema.SetField('moes_baseicms',baseicms);
        Sistema.SetField('moes_valoricms',valoricms);
        Sistema.SetField('moes_basesubstrib',basesubs);
        Sistema.SetField('moes_valoricmssutr',icmssubs);
      end else begin
//        Sistema.SetField('moes_vlrtotal',total);
//        Sistema.SetField('moes_valortotal',valortot);
        Sistema.SetField('moes_valortotal',valortotal);
      end;
    end else begin
      if total=0 then begin
//        Sistema.SetField('moes_DataCont',Entrada);  // devido as transferencias tipo 2
        Sistema.SetField('moes_DataCont',Movimento);
        Sistema.SetField('moes_vlrtotal',Valortotal);
        Sistema.SetField('moes_baseicms',baseicms);
        Sistema.SetField('moes_valoricms',valoricms);
        Sistema.SetField('moes_basesubstrib',basesubs);
        Sistema.SetField('moes_valoricmssutr',icmssubs);
//        Sistema.SetField('moes_totprod',Valortotal);
// 22.06.06
        Sistema.SetField('moes_totprod',totprod);
      end else begin
        Sistema.SetField('moes_vlrtotal',total);
        Sistema.SetField('moes_valortotal',valortot);
      end;
    end;
    Sistema.SetField('moes_dataemissao',Emissao);
    Sistema.SetField('moes_natf_codigo',Natureza);
    Sistema.SetField('moes_freteciffob',ciffob);
    Sistema.SetField('moes_frete',vlrfrete);
    Sistema.SetField('moes_vispra',FCondPagto.GetAvPz(Condicao));
// 06.10.05
    TiposSerieDiversos:=Global.CodConhecimento+';'+Global.CodCompra+';'+Global.CodCompraSemMovEstoque+';'+Global.CodCompra100+';'+
           Global.CodCompraImobilizado+';'+Global.CodCompraMatConsumo+';'+Global.CodCompraSemfinan+';'+Global.CodCompraX+';'+
           Global.CodDevolucaoConsigMerc+';'+Global.CodRetornoInd+';'+Global.CodRetornocomServicos+';'+Global.coddevolucaoind;
//    if pos(TipoMovimento,TiposSerieDiversos)>0 then begin
// deixado o q foi digitado - 23.03.07
      Sistema.SetField('moes_especie',Tipodoc);
      Sistema.SetField('moes_serie',Serie);
//    end else begin
//     Sistema.SetField('moes_especie',Arq.TConfmovimento.fieldbyname('comv_especie').asstring);
//      Sistema.SetField('moes_serie',Arq.TConfmovimento.fieldbyname('comv_serie').asstring);
//    end;
    if ctran_codigo<>'' then
// 25.02.13 - alterava errado o transportador
      Sistema.SetField('moes_tran_codigo',ctran_codigo)
    else
      Sistema.SetField('moes_tran_codigo',Arq.TTransp.fieldbyname('tran_codigo').asstring);
    Sistema.SetField('Moes_Perdesco',perdesco);
    Sistema.SetField('Moes_Peracres',peracre);
    Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
// 01.09.05
    Sistema.SetField('moes_mensagem',mensagem);
// 20.04.06
    if tipomovimento=Global.CodRetornoind then
      Sistema.SetField('moes_vlrservicos',servicos);
// 11.07.13 - SM
    if tipomovimento=Global.CodPrestacaoServicosE then
      Sistema.SetField('moes_vlrservicos',servicos);
      Sistema.SetField('moes_baseiss',servicos);
// 05.06.06
    Sistema.SetField('moes_fpgt_codigo',Fpgt_codigo);
// 12.06.06
    Sistema.SetField('moes_pedido',Pedido);
// 22.06.06
    Sistema.SetField('moes_valoripi',valoripi);
    Sistema.SetField('moes_seguro',seguro);
    Sistema.SetField('moes_outrasdesp',outrasdesp);
// 27.06.06
    Sistema.SetField('moes_tipo_codigoind',Fornecind);
// 03.04.07 - clessi
    Sistema.SetField('moes_pesoliq',pesoliq);
// 12.12.07
    if xnfprodutor>0 then
      Sistema.SetField('moes_notapro',xnfprodutor);
    if xnfprodutor2>0 then
      Sistema.SetField('moes_notapro2',xnfprodutor2);
    if xnfprodutor3>0 then
      Sistema.SetField('moes_notapro3',xnfprodutor3);
    if xnfprodutor4>0 then
      Sistema.SetField('moes_notapro4',xnfprodutor4);
    if xnfprodutor5>0 then
      Sistema.SetField('moes_notapro5',xnfprodutor5);
///////////////////
// 03.05.07
//    Sistema.SetField('moes_notapro',xnfprodutor);
    Sistema.SetField('moes_funrural',funrural);
    Sistema.SetField('moes_cotacapital',cotacapital);
// 06.03.08
    Sistema.SetField('moes_nroobra',obra);
// 28.10.09
// 13.04.10
    campo:=Sistema.GetDicionario('movesto','moes_cola_codigo');
    if campo.Tipo<>'' then
      Sistema.SetField('moes_cola_codigo',Cola_codigo);
    campo:=Sistema.GetDicionario('movesto','moes_km');
    if campo.Tipo<>'' then
      Sistema.SetField('moes_km',km);
// 30.10.09
    campo:=Sistema.GetDicionario('movesto','moes_plan_codigo');
    if campo.Tipo<>'' then
      Sistema.SetField('moes_plan_codigo',ContaGerencial);
// 22.10.10
    campo:=Sistema.GetDicionario('movesto','moes_plan_codigocre');
    if campo.Tipo<>'' then
      Sistema.SetField('moes_plan_codigocre',ContaCredito);
// 12.01.12 - Asatec
    if copy(Natureza,1,1)='3' then begin
      campo:=Sistema.GetDicionario('movesto','moes_numerodi');
      if campo.Tipo<>'' then begin
        Sistema.SetField('moes_numerodi',xnumerodi);
        Sistema.SetField('moes_dtregistro',xdatadi);
        Sistema.SetField('moes_localdesen',xlocaldesem);
        Sistema.SetField('moes_ufdesen',xufdesem);
        Sistema.SetField('moes_dtdesen',xdatadesem);
        Sistema.SetField('moes_codexp',Fornecedor.text);
      end;
    end;
// 19.11.10 - gravar xml importado na entrada
    if ACBrNFe1.NotasFiscais<>nil then begin
      if ACBrNFe1.NotasFiscais.Count>0 then begin
// 06.08.12 - para gravar o xml somente quando manda pra sefa
        if TipoMovimento=Global.CodEstornoNFeSai then
          Sistema.setfield('moes_chavenferef',ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe)
        else begin
          Sistema.setfield('moes_xmlnfet',ACBrNFe1.NotasFiscais.Items[0].XML) ;
// 17.02.15 - para tentar eviar Casa Nova q grava xml de entrada mas fica sem chave
          if trim(ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe)<>'' then
            Sistema.setfield('moes_chavenfe',ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe)
          else
            Sistema.setfield('moes_chavenfe',copy(ACBrNFe1.NotasFiscais.Items[0].XML,pos('NFe',ACBrNFe1.NotasFiscais.Items[0].XML)+3,44) );
        end;
      end else if (xchavecte<>'') and ( Tipodoc='CTE' ) then   // 12.03.15 - CTE
         Sistema.setfield('moes_chavenfe',xchavecte)
      else if (xchavecte<>'') and ( Tipodoc='NFE' ) then   // 14.08.15 - nferef das devolucoes
         Sistema.setfield('moes_chavenferef',xchavecte);
    end else if (xchavecte<>'') then   // 12.03.15 - CTE
       Sistema.setfield('moes_chavenfe',xchavecte);
//////////////////
// 23.08.13
    if Global.Topicos[1365] then Sistema.SetField('moes_seto_codigo',cseto_codigo);
// 26.05.15 - divisao por 'obra/setor'
    if cseto_codigo='9999' then begin
       xsetores:='';
      for i:=1 to xGrid.rowcount do begin
         if trim(xGrid.cells[xGrid.getcolumn('codigo'),i])<>'' then xsetores:=xsetores+xGrid.cells[xGrid.getcolumn('codigo'),i]+';'+xGrid.cells[xGrid.getcolumn('valor'),i]+'|';
      end;
      if length(trim(xsetores))>5 then Sistema.Setfield('moes_remessas',xsetores);
    end;
//////////////////
// 30.07.15
    if xvalorgta>0 then  Sistema.setfield('moes_vlrgta',xvalorgta);
// 20.06.16
    if (Global.topicos[1043]) and ( Movimento > 1 )  then begin
       transacaocontax:=GetTransacaoContax(strzero(FUnidades.GetEmpresaContax(Unidade),3),True);
       Sistema.SetField('moes_transacerto',transacaocontax);
    end;
// 13.09.16
    Sistema.SetField('moes_valorpis',xvlrpis);
    Sistema.SetField('moes_valorcofins',xvlrcofins);
    Sistema.SetField('moes_valorcsl',xvlrcsll);
    Sistema.SetField('moes_valorir',xvlrir);
    Sistema.SetField('moes_valorinss',xvlrinss);
////////////////////////////////
    Sistema.Post();
//////////////////
    if (trim(romaneio)<>'') and ( pos(TipoMovimento,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor)>0) then begin
      Sistema.Edit('movabate');
      Sistema.SetField('mova_notagerada',Numero);
      Sistema.SetField('mova_transacaogerada',Transacao);
      Sistema.Post(FGeral.GetIN('mova_numerodoc',romaneio,'N')+
                   ' and mova_status=''N'''+
                   ' and mova_tipomov='+Stringtosql(TipoEntradaAbate)+
                   ' and mova_unid_codigo='+stringtosql(Unidade)+
                   ' and mova_transacaogerada='+stringtosql('')+
                   ' and mova_tipo_codigo='+Fornecedor.Assql)
    end;
// 19.06.16
////////////////////////////////////////////
// 06.09.16
  camponaosocio:=Sistema.GetDicionario('unidades','unid_comprasNS');

    if (Global.topicos[1043]) and ( Movimento > 1 )  then begin
      QUNid_codigo:=sqltoquery('select * from unidades where unid_codigo = '+Stringtosql(Unidade));
      clifor:=FGeral.GetNomeRazaoSocialEntidade(Fornecedor.asinteger,tipocad,'N');
      GetContasExportacao(FCondPagto.GetAvPz(Condicao),'C',TipoMovimento,Tipocad,transacao,Unidade,
                                      CodigoMOv,Fornecedor.asinteger,Contagerencial);
// lan�amento simples
      campos:='mcon_transacao,mcon_operacao,mcon_status,mcon_unid_codigo,mcon_pcon_conta,mcon_datamvto,mcon_datalcto,mcon_dc,'+
              'mcon_valor,mcon_zeramento,mcon_hist_codigo,mcon_complemento,mcon_numerodcto';

      if (debito>0) and (credito>0) and (pos(tipomovimento,Global.CodCompraProdutor+';'+Global.CodCompraProdutorMerenda+';'+Global.CodPrestacaoServicosE)=0 ) then begin
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'1')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(debito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('D')+','+Valortosql(valortotal)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql('NF '+inttostr(numero)+' '+clifor)+','+
                 Stringtosql(inttostr(NUmero));
        SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'2')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(valortotal)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql('NF '+inttostr(numero)+' '+clifor)+','+
                 Stringtosql(inttostr(NUmero));
        SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );

      end else if pos(tipomovimento,Global.CodCompraProdutor+';'+Global.CodCompraProdutorMerenda)>0 then begin
// inicio do multiplo em caso de nota de produtor
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'1')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(debito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('D')+','+Valortosql(totprod)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql('NF '+inttostr(numero)+' '+clifor)+','+
                 Stringtosql(inttostr(NUmero));
        if (debito>0) and (totprod>0) then
          SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );

        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'2')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(totprod-funrural-cotacapital-xvalorgta)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql('NF '+inttostr(numero)+' '+clifor)+','+
                 Stringtosql(inttostr(NUmero));
        if (credito>0) and ( (totprod-funrural-cotacapital-xvalorgta)>0 ) then
          SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );

        credito:=QUNid_codigo.fieldbyname('unid_containss').asinteger;
        historico:=strspace('Inss NF '+inttostr(numero)+' '+clifor,maximocomple);
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'3')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(funrural)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql(historico)+','+
                 Stringtosql(inttostr(NUmero));
        if (credito>0) and (funrural>0) then
          SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );

        credito:=QUNid_codigo.fieldbyname('unid_contagta').asinteger;
        historico:=strspace('GTA NF '+inttostr(NUmero)+' '+clifor,maximocomple);
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'4')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(xvalorgta)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql(historico)+','+
                 Stringtosql(inttostr(NUmero));
        if (credito>0) and (xvalorgta>0) then
          SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );

        credito:=FCadcli.GetContaExpCotaCapital(Fornecedor.Asinteger);
        historico:=strspace('Cota Capital NF '+inttostr(numero)+' '+clifor,maximocomple);
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'5')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(cotacapital)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql(historico)+','+
                 Stringtosql(inttostr(NUmero));
        if (credito>0) and (cotacapital>0) then
          SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );
        FGeral.fechaquery(qunid_codigo);
// 13.09.16
      end else if pos(tipomovimento,Global.CodPrestacaoServicosE)>0 then begin
      //////////////////////////////////////////////////////////////////////
// inicio do multiplo em caso de entrada de presta��o de servi�os
        vlrretencoes:=xvlrpis+xvlrcofins+xvlrir+xvlrinss+xvlrcsll;
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'1')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(debito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('D')+','+Valortosql(valortotal)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql('NF '+inttostr(numero)+' '+clifor)+','+
                 Stringtosql(inttostr(NUmero));
        if (debito>0) and (valortotal>0) then
          SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );

        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'2')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(valortotal-vlrretencoes)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql('NF '+inttostr(numero)+' '+clifor)+','+
                 Stringtosql(inttostr(NUmero));
        if (credito>0) and ( (valortotal-vlrretencoes)>0 ) then
          SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );

        credito:=QUNid_codigo.fieldbyname('unid_contapisret').asinteger;
        historico:=strspace('PIS Retido NF '+inttostr(numero)+' '+clifor,maximocomple);
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'3')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(xvlrpis)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql(historico)+','+
                 Stringtosql(inttostr(NUmero));
        if (credito>0) and (xvlrpis>0) then
          SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );

        credito:=QUNid_codigo.fieldbyname('unid_contacofret').asinteger;
        historico:=strspace('COFINS Retido NF '+inttostr(NUmero)+' '+clifor,maximocomple);
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'4')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(xvlrcofins)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql(historico)+','+
                 Stringtosql(inttostr(NUmero));
        if (credito>0) and (xvlrcofins>0) then
          SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );

        credito:=QUNid_codigo.fieldbyname('unid_contairret').asinteger;
        historico:=strspace('IR Retido NF '+inttostr(numero)+' '+clifor,maximocomple);
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'5')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(xvlrir)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql(historico)+','+
                 Stringtosql(inttostr(NUmero));
        if (credito>0) and (xvlrir>0) then
          SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );
{    - ver inss � conta propria pra inss retido q s� ocorre se tiver nf de mao de obra de construcao civil
// 22.09.16 - ver se � necessario criar
        credito:=QUNid_codigo.fieldbyname('unid_containss').asinteger;
        historico:=strspace('INSS Retido NF '+inttostr(numero)+' '+clifor,maximocomple);
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'6')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(xvlrinss)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql(historico)+','+
                 Stringtosql(inttostr(NUmero));
        if (credito>0) and (xvlrinss>0) then
          SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );
}

        credito:=QUNid_codigo.fieldbyname('unid_contacsllret').asinteger;
        historico:=strspace('CSLL Retido NF '+inttostr(numero)+' '+clifor,maximocomple);
        valores:=Stringtosql(transacaocontax)+','+Stringtosql(transacaocontax+'6')+','+Stringtosql('N')+','+Stringtosql(Unidade)+','+Stringtosql(inttostr(credito))+','+Datetosql(Entrada)+','+Datetosql(Sistema.Hoje)+','+
                 Stringtosql('C')+','+Valortosql(xvlrcsll)+','+Stringtosql('2')+','+Stringtosql(' ')+','+Stringtosql(historico)+','+
                 Stringtosql(inttostr(NUmero));
        if (credito>0) and (xvlrcsll>0) then
          SistemaContax.ExecuteDirect(' Insert into movcon ('+campos+') values ('+valores+')' );
       FGeral.fechaquery(qunid_codigo);

      end;
    end;
////////////////////////////////////////////
  end;

end;

///////////////////////////////////////////////////////////////////////////
function TFGeral.CalculaComissao(Repr: TSqled; CodigoCondicao: string;
  Grid: TSqlDtgrid ; EdTabela:TSqled ; Unidade:string): currency;
//////////////////////////////////////////////////////////////
var p:integer;
    produto:string;
    basecomissao,comissao,qtde,unitario,perc:currency;
begin
  comissao:=0;basecomissao:=0;
// 26.01.12
  if Repr = nil then begin
    result:=comissao;
    exit;
  end;
  for p:=1 to Grid.RowCount do begin
    produto:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),p];
    if trim(produto)<>'' then begin
      Arq.TEstoque.locate('esto_codigo',produto,[]);
      qtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),p]);
      unitario:=texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),p]);
      basecomissao:=basecomissao+( FGeral.Arredonda(qtde*unitario,2) ) * (FEstoque.GetPerBaseComissao(produto,unidade)/100) ;
    end;
  end;
  if EdTabela<>nil then begin
    if EdTAbela.resultfind<>nil then begin
      if EdTAbela.resultfind.fieldbyname('tabp_tipo').asstring='A' then
        basecomissao:=basecomissao+( baseComissao*(EdTAbela.resultfind.fieldbyname('tabp_aliquota').ascurrency/100) )
      else
        basecomissao:=basecomissao-( baseComissao*(EdTAbela.resultfind.fieldbyname('tabp_aliquota').ascurrency/100) );
    end;
  end;
// 07.07.07 ver como tratar o 'cliente/representante' das vendas serie 4
  perc:=FCondpagto.GetPerComissao(CodigoCondicao);
  try
    if repr.resultfind<>nil then
      comissao:=basecomissao*(Repr.ResultFind.fieldbyname('repr_comissao').ascurrency/100)
    else
      comissao:=0;
{  18.08.05
    if not Arq.TRepresentantes.active then Arq.TRepresentantes.open;
    if Arq.TRepresentantes.locate('repr_codigo',repr.text,[]) then
      comissao:=basecomissao*(Arq.TRepresentantes.fieldbyname('repr_comissao').ascurrency/100)
    else
      Avisoerro('N�o encontrado representante '+repr.text+' no cadastro');
}
    if perc>0 then
      comissao:=comissao+( Comissao*(perc/100) );
  except
    if perc>0 then
      comissao:=( BaseComissao*(perc/100) );

  end;
////////////////////////////////////////////////////
  result:=comissao;
end;

procedure TFGeral.GravaMovbase(Transacao: string; Numerodoc: integer; Cst,
  TipoImposto : string ; Baseicms, Valoricms, Aliquota, Reducaobase, Isentas, Outras:currency ;
  TipoMov: string ; TpImposto:string='I' ; Unidade:string='' ; xcfop:string='');
begin

    Sistema.Insert('MovBase');
    Sistema.SetField('movb_transacao',Transacao);
    Sistema.SetField('movb_operacao',GetOperacao);
    Sistema.SetField('movb_status','N');
    Sistema.SetField('movb_numerodoc',Numerodoc);
    Sistema.SetField('Movb_cst',Cst);
//////////        Sistema.SetField('Movb_Codigosfis',     'Simb',  talvez nao precise pois ja gravo o % icms

//   Sistema.SetField('Movb_TpImposto',TipoImposto);   // fixo I-Icms - S-Iss
// 13.07.06
    Sistema.SetField('Movb_TpImposto',tpimposto );
// codigo de valores fiscais ( 1,,5 da impressao do livro fiscal )
//        Sistema.SetField('Movb_CVF',cvf);    // checar - talvez nao precise
    Sistema.SetField('Movb_BaseCalculo',baseicms);
    Sistema.SetField('Movb_Aliquota',aliquota);
    Sistema.SetField('Movb_ReducaoBc',reducaobase);
    Sistema.SetField('Movb_Imposto',valoricms);
    Sistema.SetField('Movb_Isentas',isentas);
    Sistema.SetField('Movb_Outras' ,outras);
    Sistema.SetField('Movb_tipomov',TipoMov);
    if trim(unidade)='' then
      unidade:=Global.CodigoUnidade;
    Sistema.SetField('Movb_unid_codigo',Unidade);  // 13.07.06
    Sistema.SetField('Movb_natf_codigo',xcfop);  // 08.04.10
    Sistema.Post();

end;

function TFGeral.GetNomeTipoCad(codigo: integer; Tipocad: string): string;
begin
// ver para eliminar esta funcao e usar a  getnomerazaosocialentidade

  if TipoCad='C' then
    result:=FCadcli.GetNome(codigo)
  else if TipoCad='F' then
    result:=FFornece.GetNome(codigo)
  else if TipoCad='R' then
    result:=FRepresentantes.GetDescricao(codigo)
  else if TipoCad='U' then
    result:=FUnidades.GetNome(strzero(codigo,3))
  else if TipoCad='T' then
    result:=FTransp.GetNome(strzero(codigo,3))
  else
    result:=FTransp.GetNome(strzero(codigo,3))

end;

function TFGeral.Validamesano(mesano:string):boolean;
var mes,ano:integer;
begin
   result:=false;
   if (trim(mesano) = '') or (length(trim(mesano)) < 6) or
      (pos(' ',mesano) > 0) then begin
      avisoerro('Informar o mes/ano no formato MMAAAA');
      exit;
   end;
   mes := 0 ; ano := 0;
   if copy(mesano,1,2) <> '' then
      mes := strtoint( copy(mesano,1,2) );
   if copy(mesano,3,4) <> '' then
      ano := strtoint( copy(mesano,3,4) );
   if ( mes <= 0 ) or ( mes > 12 ) then begin
     Avisoerro('Mes inv�lido');
     result:=false;exit;
   end;
   if ( ano <= 0 ) or ( ano < 1980 ) or ( ano > Datetoano(sistema.Hoje,true)+1 )
     then begin
     Avisoerro('Ano inv�lido');
     result:=false;exit;
   end;
   result:=true;
end;

function TFGeral.Validaperiodo(mesano:string):boolean;
var datadig:TDatetime;
begin
   result:=false;
// 19.11.09 - para poder fazer a transf. mensal retroativa
   if Global.Usuario.OutrosAcessos[0051] then begin
     result:=true;
     exit;
   end;
   if ( trim(FGeral.GetConfig1AsString('DtInicioMvto'))<>'' ) and
      ( trim(FGeral.GetConfig1AsString('DtTerminoMvto'))<>'' ) then begin
     datadig:=texttodate('01'+mesano);
     if ( datadig < FGeral.GetConfig1AsDate('DtInicioMvto') ) or
        ( datadig > FGeral.GetConfig1AsDate('DtTerminoMvto') ) then
         Avisoerro('Per�odo n�o pode ser alterado')
     else
        result:=true;
   end else
     result:=true;
end;


function TFGeral.Anomesinvertido(mesano: string): string;
begin
  result:=copy(mesano,3,4)+copy(mesano,1,2);
end;

function TFGeral.SaldoAnterior(conta: integer; unidade,campo: string;  DataInicial: TDatetime): currency;
///////////////////////////////////////////////////////////////////////////////////////////////////////
var QBusca,QBuscaInicio:TSqlquery;
    saldo:currency;
    mesano:string;
    mes,ano:integer;
begin
  mes:=Datetomes(DataInicial);
  ano:=Datetoano(Datainicial,true);
  if mes=1 then begin
    mes:=12;
    dec(ano);
  end else
    dec(mes);
  mesano:=inttostr(ano)+strzero(mes,2);
  saldo:=0;
  Sistema.beginprocess('Calculando saldo anterior');

//  if FGeral.UsuarioTeste(Global.usuario.codigo) then begin
//    mesano:='200507';
//    mes:=strtoint(copy(mesano,5,2));
//    ano:=strtoint(copy(mesano,1,4));
//    QBuscainicio:=sqltoquery('select * from salmovfin where samf_status=''N'' and samf_mesano='+stringtosql(mesano)+
//                       ' and samf_plan_conta='+stringtosql(inttostr(conta))+
//                       ' and '+FGeral.getin('samf_unid_codigo',unidade,'C') );
// 07.04.06 - vamos ver como se comportar o saldo chu
    QBusca:=sqltoquery('select * from movfin where movf_status=''N'' and movf_datamvto<'+DAtetosql(datainicial)+
                       ' and movf_plan_conta='+stringtosql(inttostr(conta))+
                       ' and '+FGeral.getin('movf_unid_codigo',unidade,'C')+
                       ' order by movf_datamvto' );
//    if not QBuscainicio.eof then
//      saldo:=QBuscainicio.fieldbyname(campo).ascurrency;
//  end else begin

//    QBusca:=sqltoquery('select * from salmovfin where samf_status=''N'' and samf_mesano='+stringtosql(mesano)+
//                     ' and '+FGeral.Getin('samf_unid_codigo',unidade,'C')+' and samf_plan_conta='+stringtosql(inttostr(conta)) );
//  end;

//  if FGeral.UsuarioTeste(Global.usuario.codigo) then begin
    while not QBusca.Eof do begin
  //    saldo:=saldo+QBusca.fieldbyname(campo).AsCurrency;
      if campo='samf_saldomov' then begin
        if QBusca.FieldByName('movf_Es').AsString='E' then
          saldo:=saldo+QBusca.fieldbyname('movf_valorger').AsCurrency
        else
          saldo:=saldo-QBusca.fieldbyname('movf_valorger').AsCurrency;
      end else begin
        if Qbusca.fieldbyname('movf_datacont').asdatetime > Global.DataMenorBanco then begin
          if QBusca.FieldByName('movf_Es').AsString='E' then
            saldo:=saldo+QBusca.fieldbyname('movf_valorger').AsCurrency
          else
            saldo:=saldo-QBusca.fieldbyname('movf_valorger').AsCurrency;
        end;
      end;
      QBusca.next;
    end;
//  end else begin
{
    while not QBusca.Eof do begin
      saldo:=saldo+QBusca.fieldbyname(campo).AsCurrency;
      QBusca.next;
    end;
}
//  end;
//    saldo:=FGeral.QualQtde(Global.Usuario.Codigo,QBusca.fieldbyname('saes_qtde').AsCurrency,QBusca.fieldbyname('saes_qtdeprev').AsCurrency);
  QBusca.Close;
  Freeandnil(QBusca);
  Sistema.endprocess('');
  result:=saldo;

end;

/////////////////////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaItensNFTrans(Emissao: TDatetime; UnidDestino: TSqlEd;
  Unidade, EntSai, TipoMovimento, Transacao: string; Numero: Integer;
  Grid: TSqlDtGrid; frete, seguro: currency ; simples:string ; Movimento:TDatetime ; Pedidos:string='';
  Romaneio:string=''; EdCliente:TSqlEd=nil );
/////////////////////////////////////////////////////////////////////////////////////////////////
var linha,p:integer;
    codigograde,codigolinha,codigocoluna,codigotamanho,codigocor:integer;
    venda,qtde,reducao,isentas,outras,base,basesubs,valorcontabil,margemlucro,aliicms:currency;
    Q,QQtde:TSqlquery;
    ysqlcor,ysqltamanho:string;

      procedure BaixaPedidosDetalhe;
      ///////////////////////////////
      var Lista:TStringlist;
          p:integer;
      begin
         Lista:=Tstringlist.create;
         strtolista(lista,pedidos,',',true);
         for p:=0 to Lista.count-1 do begin
           if strtointdef(Lista[p],0)>0 then begin
             Sistema.Edit('Movpeddet');
             Sistema.Setfield('mpdd_nftrans',Numero);
             Sistema.Setfield('mpdd_datanftrans',Emissao);
             Sistema.Setfield('mpdd_transacaonftrans',Transacao);
             Sistema.Post('mpdd_status=''N'' and mpdd_numerodoc='+Lista[p]+' and mpdd_situacao=''E'''+
                          ' and mpdd_esto_codigo='+stringtosql(Grid.Cells[Grid.Getcolumn('move_esto_codigo'),linha]) );
           end;
         end;
         Lista.Free;
      end;

    procedure Incluigrade(xcodcor,xcodtamanho,xcodcopa:integer ; produto:string);
    /////////////////////////////////////////////////////////////////////////////
    var Q:TSqlquery;
        var xsqlcor,xsqltamanho,xsqlcopa:string;
    begin

      xsqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
      xsqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
      xsqlcopa:=' and ( esgr_copa_codigo=0 or esgr_copa_codigo is null )';
      if (xcodcor>0) and (xcodtamanho>0) and (xcodcopa>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
          xsqlcopa:=' and esgr_copa_codigo='+inttostr(xcodcopa);
      end else if (xcodcor>0) and (xcodtamanho>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
      end else if (xcodcor>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
      end else if (xcodtamanho>0) then begin
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
      end;
      Q:=sqltoquery('select esgr_esto_codigo,esgr_qtde,esgr_qtdeprev from estgrades where esgr_esto_codigo='+stringtosql(produto)+
                    ' and esgr_status=''N'' and esgr_unid_codigo='+stringtosql(UnidDestino.text)+
                    xsqlcor+xsqltamanho+xsqlcopa );
      if Q.eof then begin
        Sistema.Insert('Estgrades');
        Sistema.Setfield('esgr_status','N');
        Sistema.Setfield('esgr_esto_codigo',produto);
        Sistema.Setfield('esgr_unid_codigo',UnidDestino.text);
        Sistema.Setfield('esgr_grad_codigo',0);
//        Sistema.Setfield('esgr_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]) );
//        Sistema.Setfield('esgr_qtdeprev',texttovalor(Grid.Cells[grid.getcolumn('qtdeprev'),linha]) );
// 15.10.08
        Sistema.Setfield('esgr_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]) );
        Sistema.Setfield('esgr_qtdeprev',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]) );
        Sistema.Setfield('esgr_codbarra',produto+strzero(xcodtamanho,3)+strzero(xcodcor,3));
        Sistema.Setfield('esgr_custo',Arq.TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
        Sistema.Setfield('esgr_customedio',Arq.TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
        Sistema.Setfield('esgr_custoger',Arq.TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
        Sistema.Setfield('esgr_customeger',Arq.TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
        Sistema.Setfield('esgr_vendavis',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
        Sistema.Setfield('esgr_dtultvenda',emissao);
        Sistema.Setfield('esgr_dtultcompra',emissao);
        Sistema.Setfield('esgr_usua_codigo',Global.Usuario.codigo);
        Sistema.Setfield('esgr_tama_codigo',xcodtamanho);
        Sistema.Setfield('esgr_core_codigo',xcodcor);
        Sistema.Setfield('esgr_copa_codigo',xcodcopa);
// 15.04.08
        Sistema.Setfield('esgr_custoser',Arq.TEstoqueQtde.fieldbyname('esqt_custoser').ascurrency);
        Sistema.Setfield('esgr_customedioser',Arq.TEstoqueQtde.fieldbyname('esqt_customedioser').ascurrency);
        Sistema.Post();
      end;
      FGeral.Fechaquery(Q);
    end;

////////////////////////////////////////////////////////////
begin
///////////////////////////////////////////////////////////
  if ListaCstPerc=nil then
     ListaCstPerc:=Tlist.create;
  ListaCstPerc.clear;
  Grid.Index(Grid.GetColumn('move_cst'));
  for linha:=1 to Grid.rowcount do begin
    if trim(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])<>'' then begin
      Arq.TEstoque.locate('esto_codigo',Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],[]);
//      if ( not Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([UnidDestino.text,Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]]),[]) )
// 04.10.13 - talvez estivesse 'enuplicando' o estoqueqtde em cada transferencia
      QQtde:=Sqltoquery('select esqt_esto_codigo from estoqueqtde where esqt_status=''N'''+
                        ' and esqt_unid_codigo='+Stringtosql(UnidDestino.text)+
                        ' and esqt_esto_codigo='+Stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]));
      if ( QQtde.eof )  and (entsai='E') then begin
        Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([Unidade,Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]]),[]);
        Sistema.Insert('EstoqueQtde');
        Sistema.Setfield('esqt_status','N');
        Sistema.Setfield('esqt_unid_codigo',UnidDestino.text);
        Sistema.Setfield('esqt_esto_codigo',Grid.Cells[0,linha]);
        Sistema.Setfield('esqt_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
        Sistema.Setfield('esqt_qtdeprev',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
        Sistema.Setfield('esqt_vendavis',Texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
        Sistema.Setfield('esqt_custo',Arq.TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
        Sistema.Setfield('esqt_custoger',Arq.TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
        Sistema.Setfield('esqt_customedio',Arq.TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
        Sistema.Setfield('esqt_customeger',Arq.TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
        Sistema.Setfield('esqt_dtultvenda',emissao);
        Sistema.Setfield('esqt_dtultcompra',emissao);
        Sistema.Setfield('esqt_desconto',Arq.TEstoqueQtde.fieldbyname('esqt_desconto').ascurrency);
        Sistema.Setfield('esqt_basecomissao',Arq.TEstoqueQtde.fieldbyname('esqt_basecomissao').ascurrency);
{ - mudado em 17.11.05
        Sistema.Setfield('esqt_cfis_codigoest',Arq.TEstoqueQtde.fieldbyname('esqt_cfis_codigoest').asstring);
        Sistema.Setfield('esqt_cfis_codigoforaest',Arq.TEstoqueQtde.fieldbyname('esqt_cfis_codigoforaest').asstring);
        Sistema.Setfield('esqt_sitt_codestado',Arq.TEstoqueQtde.fieldbyname('esqt_sitt_codestado').asinteger);
        Sistema.Setfield('esqt_sitt_forestado',Arq.TEstoqueQtde.fieldbyname('esqt_sitt_forestado').asinteger);
}
// - 17.11.05 - para evitar q fique tributa��o errada quando transfere novos produtos da matriz para filiais
        Sistema.Setfield('esqt_cfis_codigoest',FGEral.GetCodfiscalunidade(UnidDestino.text,'D'));
        Sistema.Setfield('esqt_cfis_codigoforaest',FGEral.GetCodfiscalunidade(UnidDestino.text,'F'));
        Sistema.Setfield('esqt_sitt_codestado',FGeral.GetCodsittunidade(UnidDestino.text,'D'));
        Sistema.Setfield('esqt_sitt_forestado',FGeral.GetCodsittunidade(UnidDestino.text,'F'));
///////////////
        Sistema.Setfield('esqt_vendavis',Arq.TEstoqueQtde.fieldbyname('esqt_vendavis').ascurrency);
        Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
        Sistema.Post('');
////////        Sistema.Commit;
      end else begin  // 25.01.06 fazer o custo medio caso na filial j� existir o produto...rever...
      end;
      FGeral.FechaQuery(Qqtde);
//////////////////////////////////////////////////////////////////////////////////////////
// 22.02.06
      codigotamanho:=0;
      codigocor:=0;
      if trim(Grid.Cells[grid.GetColumn('move_tama_codigo'),linha])<>'' then
        codigotamanho:=strtoint(Grid.Cells[grid.GetColumn('move_tama_codigo'),linha]);
      if trim(Grid.Cells[grid.GetColumn('move_core_codigo'),linha])<>'' then
        codigocor:=strtoint(Grid.Cells[grid.GetColumn('move_core_codigo'),linha]);
////////////////////// - 24.09.13 - Vivan - Inclusao das grades novas
      if EntSai='S' then
        IncluiGrade(codigocor,codigotamanho,0,Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha]);
/////////////////////
      Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([UnidDestino.text,Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]]),[]);
      codigograde:=FEstoque.GetCodigoGrade(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha]);
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha]);

//      codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha],codigograde);
//      codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha],codigograde);

// 22.06.06 - 24.09.13 - retirado
//      if (codigotamanho=0) and (codigocor=0) then begin
//        if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
//          Sistema.SetField('move_tama_codigo',codigolinha)
//        else
//          Sistema.SetField('move_core_codigo',codigolinha);
//        if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
//          Sistema.SetField('move_tama_codigo',codigocoluna)
//        else
//          Sistema.SetField('move_core_codigo',codigocoluna);
//      end else begin
          Sistema.SetField('move_tama_codigo',codigotamanho);
          Sistema.SetField('move_core_codigo',codigocor);
//      end;
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',numero);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',TipoMovimento);
      Sistema.SetField('move_tipocad','U');
//      Sistema.SetField('move_repr_codigo',Representante);
      Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',Emissao);
      Sistema.SetField('move_datacont',Movimento);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_custo',Arq.TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
      Sistema.SetField('move_custoger',Arq.TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
      Sistema.SetField('move_customedio',Arq.TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
      Sistema.SetField('move_customeger',Arq.TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
      Sistema.SetField('move_cst',Grid.Cells[grid.getcolumn('move_cst'),linha]);
      aliicms:=texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha]);
      if ( (entsai='E') and (simples='S') ) or ( pos(TipoMovimento,Global.TiposNaoCalcIcms)>0 ) then
        aliicms:=0;

      Sistema.SetField('move_aliicms',aliicms);

//      if EntSai='S' then begin
// 28.01.05 - 04.05.06 - ajustado gravacao de unid_codigo e tipo_codigo cfe os mestres
      if EntSai='E' then begin
        Sistema.SetField('move_unid_codigo',UnidDestino.text);
        Sistema.SetField('move_tipo_codigo',strtoint(Unidade));
      end else begin
        Sistema.SetField('move_tipo_codigo',UnidDestino.asinteger);
        Sistema.SetField('move_unid_codigo',Unidade);
//        aliicms:=FEstoque.Getaliquotaicms(Grid.Cells[0,linha],
//                               UNidDestino.text,UnidDestino.ResultFind.fieldbyname('unid_uf').asstring);
//        Sistema.SetField('move_aliicms',aliicms);
      end;
      Sistema.SetField('move_venda',Texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
      Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.Post('');

// da a entrada para transferencia de entrada
      if Entsai='E' then begin
        Q:=sqltoquery('select * from estoqueqtde where esqt_status=''N'' and esqt_unid_codigo='+UnidDestino.AsSql+' and esqt_esto_codigo='+
                     stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );
        FGeral.MovimentaQtdeEstoque( Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],UnidDestino.Text,'E',TipoMovimento,texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]),Q);
// 11.08.15  - Vivan
/////////////
        Q.close;
        ysqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
        ysqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
        if (codigocor>0) and (codigotamanho>0) then begin
            ysqlcor:=' and esgr_core_codigo='+inttostr(codigocor);
            ysqltamanho:=' and esgr_tama_codigo='+inttostr(codigotamanho);
        end else if (codigocor>0) and (codigotamanho>0) then begin
            ysqlcor:=' and esgr_core_codigo='+inttostr(codigocor);
            ysqltamanho:=' and esgr_tama_codigo='+inttostr(codigotamanho);
        end else if (codigocor>0) then begin
            ysqlcor:=' and esgr_core_codigo='+inttostr(codigocor);
        end else if (codigotamanho>0) then begin
            ysqltamanho:=' and esgr_tama_codigo='+inttostr(codigotamanho);
        end;
        Q:=sqltoquery('select * from estgrades where esgr_status=''N'' and esgr_unid_codigo='+UnidDestino.AsSql+' and esgr_esto_codigo='+
                     stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+ysqlcor+ysqltamanho );
        FGeral.MovimentaQtdeEstoqueGrade( Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],UnidDestino.Text,'E',TipoMovimento,
                                         strtointdef(Grid.Cells[grid.getcolumn('move_core_codigo'),linha],0),
                                         strtointdef(Grid.Cells[grid.getcolumn('move_tama_codigo'),linha],0),
                                         0,
                                         texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]),Q);
        Q.close;
        Freeandnil(Q);
      end;
// da a saida da unidade de origem se estiver configurado para baixar na gravacao
      if (Global.Topicos[1201]) and (EntSai='S') then begin
        Q:=sqltoquery('select * from estoqueqtde where esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Unidade)+' and esqt_esto_codigo='+
                     stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );
        FGeral.MovimentaQtdeEstoque( Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],Unidade,'S',TipoMovimento,texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]),Q);
// 11.08.15
/////////////////
        Q.close;
        ysqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
        ysqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
        if (codigocor>0) and (codigotamanho>0) then begin
            ysqlcor:=' and esgr_core_codigo='+inttostr(codigocor);
            ysqltamanho:=' and esgr_tama_codigo='+inttostr(codigotamanho);
        end else if (codigocor>0) and (codigotamanho>0) then begin
            ysqlcor:=' and esgr_core_codigo='+inttostr(codigocor);
            ysqltamanho:=' and esgr_tama_codigo='+inttostr(codigotamanho);
        end else if (codigocor>0) then begin
            ysqlcor:=' and esgr_core_codigo='+inttostr(codigocor);
        end else if (codigotamanho>0) then begin
            ysqltamanho:=' and esgr_tama_codigo='+inttostr(codigotamanho);
        end;
        Q:=sqltoquery('select * from estgrades where esgr_status=''N'' and esgr_unid_codigo='+stringtosql(Unidade)+' and esgr_esto_codigo='+
                     stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+ysqlcor+ysqltamanho );
        FGeral.MovimentaQtdeEstoqueGrade( Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],UnidaDe,'S',TipoMovimento,
                                         strtointdef(Grid.Cells[grid.getcolumn('move_core_codigo'),linha],0),
                                         strtointdef(Grid.Cells[grid.getcolumn('move_tama_codigo'),linha],0),
                                         0,
                                         texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]),Q);
        Q.close;
        Freeandnil(Q);
      end;
// 08.03.06
      if trim(Pedidos)<>'' then
        BaixaPedidosDetalhe;


//        Sistema.Edit('estoqueqtde');
//      Sistema.Setfield('esqt_dtultvenda',Emissao);
//        Sistema.Setfield('esqt_qtde',);
//        Sistema.Setfield('esqt_qtdeprev',);
//        Sistema.Post('esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Unidade)+' and esqt_esto_codigo='+
//                     stringtosql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );

      reducao:=0;isentas:=0;outras:=0;
      venda:=texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]);
      qtde:=texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]);
      ValorContabil:=FGeral.Arredonda(venda*qtde,2);
      Base:=FGeral.Arredonda(venda*qtde,2);
      if ( (entsai='E') and (simples='S') )  or ( pos(TipoMovimento,Global.TiposNaoCalcIcms)>0 ) then begin
        base:=0;
        basesubs:=0
      end else if aliicms=0 then
        base:=0;
//      margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],Unidade,UnidDestino.resultfind.fieldbyname('unid_uf').asstring));
      margemlucro:=0 ; // transf. n�o tem substitui��o trib.
      if Margemlucro>0 then
        basesubs:=base*(1+(margemlucro/100))
      else
        basesubs:=0;
      if base=0 then begin
        base:=valorcontabil;
        outras:=valorcontabil;
      end;
      FGeral.GeraListaCstPerc(Grid.Cells[grid.getcolumn('move_cst'),linha],aliicms,
                       valorcontabil,base,reducao,isentas,outras,basesubs,ListaCstPerc);
    end;
  end; // ref. ao grid

  if movimento>1 then begin
    for p:=0 to ListaCstPerc.Count-1 do begin
        PCstPerc:=Listacstperc[p];
        Sistema.Insert('MovBase');
        Sistema.SetField('movb_transacao',Transacao);
        Sistema.SetField('movb_operacao',GetOperacao);
        Sistema.SetField('movb_status','N');
        Sistema.SetField('movb_numerodoc',Numero);
        Sistema.SetField('Movb_cst',Pcstperc.cst);
///        Sistema.SetField('Movb_Codigosfis',     'Simb',  talvez nao precise pois ja gravo o % icms

//        Sistema.SetField('Movb_TpImposto','I');   // fixo I-Icms
// 13.07.06
        Sistema.SetField('Movb_TpImposto',Pcstperc.tpimposto );
  // codigo de valores fiscais ( 1,,5 da impressao do livro fiscal )
//        Sistema.SetField('Movb_CVF',cvf);    // checar - talvez nao precise
// ver como somar o frete + seguro no valor contabil agora o somente na gera��o para o livro fiscal
        if (p=0) and (EntSai='S') then
          Sistema.SetField('Movb_BaseCalculo',Pcstperc.base+frete+seguro)
        else
          Sistema.SetField('Movb_BaseCalculo',Pcstperc.base);
        Sistema.SetField('Movb_Aliquota',pcstperc.perc);
        Sistema.SetField('Movb_ReducaoBc',pcstperc.reducao);
//        Sistema.SetField('Movb_Imposto',FGeral.Arredonda(pcstperc.base*(pcstperc.perc/100),2) );
// 23.05.07
        Sistema.SetField('Movb_Imposto',FGeral.Arredonda( ( ( pcstperc.base*(pcstperc.reducao/100) ) ) * (pcstperc.perc/100),2) );
        Sistema.SetField('Movb_Isentas',pcstperc.isentas);
        Sistema.SetField('Movb_Outras' ,pcstperc.outras);
        Sistema.SetField('Movb_tipomov',TipoMovimento);
        Sistema.SetField('Movb_unid_codigo',Unidade);  // 13.07.06
        Sistema.Post();
    end;
  end;


end;


//////////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaMestreNFTrans(Emissao: TDatetime; UnidDestino: TSqlEd; Unidade, EntSai,
              TipoMovimento, Transacao, Natureza, ciffob,Especievolume: string;
              Numero,CodigoMov,QTdevolumes: Integer; Valortotal,baseicms,valoricms,basesubs,icmssubs,vlrfrete,pesoliq,pesobru: currency ;
              simples:string; Movimento:TDatetime ; Mensagem:string=''  ; Tran_codigo:string='' ; Pedidos:string='' ;
              pertran:currency=0 ; Romaneios:string='' ; Fornecedor:TSqlEd=nil);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      procedure BaixaPedidosMestre;
      //////////////////////////////
      var Lista:TStringlist;
          p:integer;
      begin
         Lista:=Tstringlist.create;
         strtolista(lista,pedidos,',',true);
         for p:=0 to Lista.count-1 do begin
           if strtointdef(Lista[p],0)>0 then begin
             Sistema.Edit('Movped');
             Sistema.Setfield('mped_nftrans',Numero);
             Sistema.Setfield('mped_datanftrans',Emissao);
             Sistema.Setfield('mped_transacaonftrans',Transacao);
             Sistema.Post('mped_status=''N'' and mped_numerodoc='+Lista[p]+' and mped_situacao=''E''' );
           end;
         end;
         Lista.free;
      end;

begin
/////////////////////////
    Sistema.Insert('Movesto');
    Sistema.SetField('moes_transacao',Transacao);
    Sistema.SetField('moes_operacao',GetOperacao);
    Sistema.SetField('moes_status','N');
    Sistema.SetField('moes_numerodoc',Numero);
    Sistema.SetField('moes_tipomov',TipoMovimento);
    Sistema.SetField('moes_comv_codigo',codigomov);
    if Entsai='E' then begin
      Sistema.SetField('moes_unid_codigo',UnidDestino.text);
//      Sistema.SetField('moes_tipo_codigo',UnidDestino.AsInteger);
//      Sistema.SetField('moes_estado',UnidDestino.ResultFind.fieldbyname('unid_uf').AsString);
//      Sistema.SetField('moes_cida_codigo',UnidDestino.ResultFind.fieldbyname('unid_cida_codigo').AsInteger);
// 26.10.05 - para gravar o codigo da unidade origem na entrada da filial...
      Sistema.SetField('moes_tipo_codigo',strtoint(Unidade));
      Sistema.SetField('moes_estado',FUnidades.GetUF(Unidade));
      Sistema.SetField('moes_cida_codigo',FUnidades.GetCidaCodigo(Unidade));
      if simples='S' then begin
        baseicms:=0;
        valoricms:=0;
        basesubs:=0;
        icmssubs:=0;
      end;
    end else begin
      Sistema.SetField('moes_unid_codigo',Unidade);
//      Sistema.SetField('moes_tipo_codigo',strtoint(Unidade));
//      Sistema.SetField('moes_estado',FUnidades.GetUF(Unidade));
//      Sistema.SetField('moes_cida_codigo',FUnidades.GetCidaCodigo(Unidade));
// 26.10.05 - para gravar o codigo da unidade origem na entrada da filial...
      Sistema.SetField('moes_tipo_codigo',UnidDestino.AsInteger);
      Sistema.SetField('moes_estado',UnidDestino.ResultFind.fieldbyname('unid_uf').AsString);
      Sistema.SetField('moes_cida_codigo',UnidDestino.ResultFind.fieldbyname('unid_cida_codigo').AsInteger);
    end;
    Sistema.SetField('moes_natf_codigo',Natureza);
//    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
//    Sistema.SetField('moes_repr_codigo',Representante);
    Sistema.SetField('moes_tipocad','U');
    Sistema.SetField('moes_datalcto',Sistema.Hoje);
    Sistema.SetField('moes_datamvto',Emissao);
    Sistema.SetField('moes_DataCont',Movimento);
    Sistema.SetField('moes_dataemissao',Emissao);
    Sistema.SetField('moes_vlrtotal',Valortotal);
//    Sistema.SetField('moes_tabp_codigo',Tabela);
//    Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
    Sistema.SetField('moes_freteciffob',ciffob);
    Sistema.SetField('moes_baseicms',baseicms);
    Sistema.SetField('moes_valoricms',valoricms);
    Sistema.SetField('moes_basesubstrib',basesubs);
    Sistema.SetField('moes_valoricmssutr',icmssubs);
    Sistema.SetField('moes_frete',vlrfrete);
//    Sistema.SetField('moes_vispra',FCondPagto.GetAvPz(Condicao));
    Sistema.SetField('moes_especie',Arq.TConfmovimento.fieldbyname('comv_especie').asstring);
    Sistema.SetField('moes_serie',FGeral.Qualserie(Arq.TConfmovimento.fieldbyname('comv_serie').asstring,Global.serieunidade));
//    Sistema.SetField('moes_tran_codigo',Arq.TTransp.fieldbyname('tran_codigo').asstring);
// 27.10.05
    Sistema.SetField('moes_tran_codigo',tran_codigo);
    Sistema.SetField('Moes_qtdevolume',QTdevolumes);
    Sistema.SetField('Moes_especievolume',Especievolume);
    Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
// 26.09.05
    if baseicms>0 then
      Sistema.SetField('moes_totprod',baseicms)
    else
      Sistema.SetField('moes_totprod',Valortotal);
// 02.09.05
    Sistema.SetField('moes_mensagem',mensagem);   //transf
// 06.10.11 - Abra
    Sistema.SetField('moes_pesoliq',pesoliq);
    Sistema.SetField('moes_pesobru',pesobru);
// 21.09.16
    campo:=Sistema.GetDicionario('movesto','moes_pertransf');
    if campo.Tipo<>'' then Sistema.SetField('moes_pertransf',pertran);
// 05.10.16
    Sistema.setfield('moes_remessas',Romaneios);
    Sistema.Post();
// 05.10.16
    if (trim(romaneios)<>'')  then begin
      Sistema.Edit('movabate');
      Sistema.SetField('mova_notagerada',Numero);
      Sistema.SetField('mova_transacaogerada',Transacao);
      Sistema.Post(FGeral.GetIN('mova_numerodoc',romaneios,'N')+
                   ' and mova_status=''N'''+
                   ' and mova_tipomov='+Stringtosql('EA')+
                   ' and mova_unid_codigo='+stringtosql(Unidade)+
                   ' and mova_transacaogerada='+stringtosql('')+
                   ' and mova_tipo_codigo='+Fornecedor.Assql)
    end;

    if trim(Pedidos)<>'' then
      BaixaPedidosMestre;

end;

function TFGeral.FormataNatf(codigo: string): string;
begin
  Result:=Trans(codigo,'#.####')

end;

function TFGeral.Buscapedcompra(Numero: Integer ; tipomov:string='' ; ordem:string='' ; EmAberto:string='N'): String;
var sqlorder,sqlaberto:string;
begin
 if trim(ordem)<>'' then begin
   if ordem='S' then
    sqlorder:=' order by moco_seq'
   else
    sqlorder:=' order by moco_esto_codigo';
 end else
   sqlorder:=' order by moco_esto_codigo';
// 05.08.09
 sqlaberto:='';
 if Emaberto='S' then
   sqlaberto:=' and ( (moco_qtderecebida<moco_qtde) or (moco_qtderecebida is null) )';
// 24.07.06
  if trim(tipomov)<>'' then
    result:='select * from movcompras '+
          ' inner join movcomp on ( mocm_numerodoc=moco_numerodoc and mocm_status=moco_status )'+
          ' left join estoque on ( esto_codigo=moco_esto_codigo )'+
          ' where moco_numerodoc='+inttostr(Numero)+
//          ' and mocm_datamvto='+Datetosql(Data)+
          ' and moco_status=''N'' and '+FGeral.Getin('moco_tipomov',tipomov,'C')+
          sqlaberto+
          ' and mocm_tipomov=moco_tipomov'+
          sqlorder
  else
    result:='select * from movcompras '+
          ' inner join movcomp on ( mocm_numerodoc=moco_numerodoc and mocm_status=moco_status )'+
          ' left join estoque on ( esto_codigo=moco_esto_codigo )'+
          ' where moco_numerodoc='+inttostr(Numero)+
//          ' and mocm_datamvto='+Datetosql(Data)+
          ' and moco_status=''N''' +
          sqlaberto+
          ' and mocm_tipomov=moco_tipomov'+
          sqlorder

end;

function TFGeral.BuscaPendencia(TipoCod, Numero: Integer;
  PR: string ; Emissao:TDatetime): String;
begin
  result:='select * from pendencias'+
          ' where pend_numerodcto='+inttostr(Numero)+
          ' and pend_status=''N'' '+
          ' and pend_dataemissao='+Datetosql(Emissao)+
          ' and pend_tipo_codigo='+inttostr(Tipocod)+
          ' and pend_unid_codigo='+Global.CodigoUnidade+   // 23.02.05
          ' and pend_rp='+stringtosql(pr);

end;

/////////////////////////////////////////////////////////////////////
{
procedure TFGeral.CopiaDbf(fonte,destino,arquivo:string);
var TabFonte, Tabdestino : TTable;
begin
  TAbfonte:=TTable.Create(application);
  with tabfonte do begin
    Databasename:=Extractfilepath(fonte);
    Tablename:=Extractfilename(fonte);
    open;
  end;
  TAbdestino:=TTable.Create(application);
  with tabdestino do begin
    Databasename:=Extractfilepath(destino);
    Tablename:=Extractfilename(destino);
    tabfonte.fielddefs.update;
    fielddefs.assign(tabfonte.fielddefs);
    tabfonte.indexdefs.update;
    indexdefs.assign(tabfonte.indexdefs);
    createtable;
  end;
  tabfonte.close;
  tabfonte.RenameTable(arquivo);
  tabdestino.close;
  tabdestino.RenameTable(fonte);
end;
}
////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TFGeral.BuscaNf(Numero: Integer; TipoMov: string ; Emissao:TDatetime=0 ; Unidade:string='' ; cliente:integer=0 ; Entrada:TDatetime=0  ;xtransacao:string=''): String;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////;;;;;;;;;;;;;;;;;;
var emissaosql,status,tiposx,sqlcliente,sqltipomov,entradasql,sqlmoestipomov,sqltransacao:string;
    xcliente:integer;
begin
  if trim(tipomov)='' then tipomov:=Global.CodVendaDireta;
// 20.08.05 - para poder fazer alteracao de notas VP,RE,VF,RF
  tiposx:=Global.CodVendaRE+';'+global.CodVendaREFinal+';'+global.CodVendaREBrinde+';'+Global.CodVendaProntaEntrega+
            ';'+Global.CodVendaProntaEntregaFecha;
// 13.02.06 - +';'+Global.CodVendaSerie4 - ver, se permitir ter� q gravar o nro do romaneio
  if Tipomov=Global.CodConhecimento then begin
    if emissao=0 then
      emissaosql:=''
    else
      emissaosql:=' and moes_dataemissao='+datetosql(emissao);
// 11.09.09
    if entrada=0 then
      entradasql:=''
    else
      entradasql:=' and moes_datamvto='+datetosql(entrada);
    sqltipomov:=' and '+FGeral.Getin('moes_tipomov',tipomov,'C');
    if unidade='' then   // 28.06.05
      unidade:=Global.CodigoUnidade;
    status:='N';
    if (tipomov<>'') and ( pos(tipomov,tiposx)>0 ) then
      status:='D;E;N;F';
    if cliente=0 then
      sqlcliente:=''
    else begin
      sqlcliente:=' and moes_tipo_codigo='+inttostr(cliente);
      emissaosql:='';
      sqltipomov:='';
    end;
  end else begin
    if emissao=0 then
      emissaosql:=''
    else
//      emissaosql:=' and moes_dataemissao='+datetosql(emissao);
// 01.09.08
//      emissaosql:=' and extract( year from moes_dataemissao )='+inttostr(datetoano(emissao,true));
// 11.12.08
//      emissaosql:=' and extract( year from moes_dataemissao )='+inttostr(datetoano(emissao,true))+
//                  ' and extract( month from moes_dataemissao )='+inttostr(datetomes(emissao));
// 05.06.09 - novi - pedido com mesmo numero de nota mas em outro dia do mesmo mes/ano
      emissaosql:=' and extract( year from moes_dataemissao )='+inttostr(datetoano(emissao,true))+
                  ' and extract( month from moes_dataemissao )='+inttostr(datetomes(emissao))+
                  ' and extract( day from moes_dataemissao )='+inttostr(datetodia(emissao));
// 11.09.09
    if entrada=0 then
      entradasql:=''
    else
// novi
      entradasql:=' and extract( year from moes_datamvto )='+inttostr(datetoano(entrada,true))+
                  ' and extract( month from moes_datamvto )='+inttostr(datetomes(entrada))+
                  ' and extract( day from moes_datamvto )='+inttostr(datetodia(entrada));

///////////////
    if unidade='' then   // 28.06.05
      unidade:=Global.CodigoUnidade;
// 25.09.15 - senao puxa itens da 'decomposicao de vendas' quando puxa dados na nf de saida na devolucao de venda - clevis novi
    if Tipomov=Global.CodConhecimento then
      sqltipomov:=' and '+FGeral.Getin('move_tipomov',tipomov,'C')
    else
      sqltipomov:=' and '+FGeral.Getin('move_tipomov',tipomov,'C')+' and '+FGeral.Getin('moes_tipomov',tipomov,'C')  ;
  // 13.02.06 - +';'+Global.CodVendaSerie4 - ver, se permitir ter� q gravar o nro do romaneio
    status:='N';
    if (tipomov<>'') and ( pos(tipomov,tiposx)>0 ) then
      status:='D;E;N;F';
    if cliente=0 then
      sqlcliente:=''
    else begin
      sqlcliente:=' and move_tipo_codigo='+inttostr(cliente);
//      emissaosql:='';   // 01.09.08
//      sqltipomov:='';   // 29.09.15 retirado
    end;
  end;
{
  result:='select movesto.*,movestoque.* from movesto,movestoque'+
          ' where moes_numerodoc='+inttostr(Numero)+
          ' and moes_unid_codigo='+stringtosql(unidade)+  // ver se poe como argumento da funcao
          ' and '+FGeral.getin('moes_status',status,'C')+
          ' and '+FGeral.Getin('moes_tipomov',tipomov,'C')+
          ' and moes_numerodoc=move_numerodoc and '+fGeral.getin('move_status',status,'C')+
          ' and moes_transacao=move_transacao'+
          emissaosql+
          ' and move_unid_codigo='+stringtosql(Unidade)+  // ver
          ' and '+FGeral.Getin('move_tipomov',tipomov,'C') ;
}

// 30.11.15
   sqltransacao:='';
   if trim(xtransacao)<>'' then sqltransacao:=' and move_transacao = '+Stringtosql(xtransacao);
// 07.05.07 - colocado parametro de codigo de cliente
// 10.12.07 - colocado checagem de conhecimento
  if Tipomov=Global.CodConhecimento then
    result:='select * from movesto '+
          ' where moes_numerodoc='+inttostr(Numero)+
          ' and moes_unid_codigo='+stringtosql(unidade)+
          ' and '+FGeral.getin('moes_status',status,'C')+
          sqltipomov+emissaosql+sqlcliente+entradasql
  else
    result:='select * from movestoque inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
          ' where move_numerodoc='+inttostr(Numero)+
          ' and move_unid_codigo='+stringtosql(unidade)+
          ' and '+FGeral.getin('move_status',status,'C')+
// 14.07.11
          ' and '+FGeral.getin('moes_status',status,'C')+
          sqltipomov+emissaosql+sqlcliente+entradasql+sqltransacao ;

end;

function TFGeral.TextInvertidatodate(d: string): TDatetime;
// 20021220 -> 20/12/2002
var s:string;
begin
  s:=copy(d,7,2)+copy(d,5,2)+copy(d,1,4);
  result:=Texttodate(s);
end;

{
//////////////////////////////////////////////////
function TFGeral.Exportanumeros(Valor: Currency; Tam, Decimais: integer ; Zeroesquerda:string='S'  ; Ponto:string='N'): String;
var retorno:string;

//////////////////////////// 02.03.05
  function zerosesquerda(s:string;tamanho:integer):string;
  begin
    if tamanho>length(s) then
      result:=strzero(0,tamanho-length(s))+s
    else
      result:=s;
  end;

begin
  if (Tam > 0) and (Tam >= Decimais+1) then begin
    str(valor:Tam:Decimais,retorno);
//    retorno:=StrToStrNumeros(retorno);
//    retorno:=strzero(0,Tam-length(retorno))+retorno;
  end else
    retorno:=space(tam);
  if zeroesquerda='S' then
    result:=zerosesquerda(trim(retorno),tam)
  else
    result:=retorno;
end;
//////////////////////////////////////////////////
}

function TFGeral.GetRazSocialTipoCad(codigo: integer;
  Tipocad: string): string;
begin
  if TipoCad='C' then
    result:=FCadcli.GetRazaoSocial(codigo)
  else if TipoCad='F' then
    result:=FFornece.GetRazaoSocial(codigo)
  else if TipoCad='R' then
    result:=FRepresentantes.GetRazaoSocial(codigo)
  else if TipoCad='U' then
    result:=FUnidades.GetRazaoSocial(strzero(codigo,3))
  else if TipoCad='T' then
    result:=FTransp.GetRazaoSocial(strzero(codigo,3))
  else
    result:=FTransp.GetRazaoSocial(strzero(codigo,3))

end;

function TFGeral.GetCnpjCpfTipoCad(codigo: integer;
  Tipocad: string): string;
begin
  if TipoCad='C' then
    result:=FCadcli.GetCnpjCpf(codigo)
  else if TipoCad='F' then
    result:=FFornece.GetCnpjCpf(codigo)
  else if TipoCad='R' then
    result:=FRepresentantes.GetCnpjCpf(codigo)
  else if TipoCad='U' then
    result:=FUnidades.GetCnpjCpf(strzero(codigo,3))
  else if TipoCad='T' then
    result:=FTransp.GetCnpjCpf(strzero(codigo,3))
  else
    result:=FTransp.GetCnpjCpf(strzero(codigo,3))

end;

procedure TFGeral.GravaRetornoRomaneio(Emissao: TDatetime; Cliente: TSqlEd;
  Representante: integer; Unidade, TipoMovimento, Transacao: string;
  Numero: Integer; Valortotal: currency; Grid: TSqlDtGrid;
  QProdRemessa: TSqlquery; EdRemessas: TSqled; Condicao: string;
  Movimento: TDatetime ; ValorVenda:currency);

var linha,codigograde,codigolinha,codigocoluna,numeronf,nremessas,p,nparcelas,n:integer;
    QQtdeEstoque:TSqlquery;
    qtderetatu,qtde,venda,ValorContabil,Base,TotalBaseicms,reducao,isentas,outras,valorparcela,acumulado,
    icmsitem,totalitem,basesubs,icmssubs,TotalIcms:currency;
    codigoestoque:string;
    ListaPrazos:TStringlist;

    procedure GravaMovFinanceiro(valorparcela:currency);
    begin
      Arq.TPlano.locate('plan_conta',Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger,[]);
      Sistema.Insert('Movfin');
      Sistema.Setfield('movf_transacao',transacao);
      Sistema.Setfield('movf_operacao',FGeral.Getoperacao);
      Sistema.Setfield('movf_status','N');
      Sistema.Setfield('movf_unid_codigo',Unidade);
      Sistema.Setfield('movf_datalcto',Sistema.HOje);
      Sistema.SetField('movf_DataCont',Movimento);
      Sistema.Setfield('movf_datamvto',Emissao);
      Sistema.Setfield('movf_dataprevista',Emissao);
//      Sistema.Setfield('movf_dataextrato' date,
      Sistema.Setfield('movf_plan_conta',Arq.TUnidades.fieldbyname('unid_contacontabil').asinteger);
      Sistema.Setfield('movf_hist_codigo',Arq.TPlano.fieldbyname('plan_codhist').asinteger);
//      Sistema.Setfield('movf_complemento',Arq.TPlano.fieldbyname('plan_codhist').asstring);
      Sistema.Setfield('movf_numerodcto',inttostr(Numero));
//      Sistema.Setfield('movf_codb_codigo', varchar(3),
      Sistema.Setfield('movf_es','E');
//      Sistema.Setfield('movf_favorecido varchar(100),
//      Sistema.Setfield('movf_numerocheque numeric(8, 0),
      Sistema.Setfield('movf_valorger',valorparcela);
      Sistema.Setfield('movf_valorbco',valorparcela);
// 01.08.05
      Sistema.Setfield('movf_usua_codigo',Global.Usuario.Codigo);
//      Sistema.Setfield('movf_transconc varchar(12),
//      Sistema.Setfield('movf_seqlcto numeric(5, 0)
      Sistema.Post;
    end;


begin

    if not Arq.TEstoque.Active then Arq.TEstoque.Open;
    if not Arq.TUnidades.Active then Arq.TUnidades.Open;
    Arq.TUnidades.Locate('unid_codigo',unidade,[]);
    if not Arq.TEstoqueQtde.Active then Arq.TEstoqueQTde.Open;

  ListaCstPerc:=TList.Create;
  Totalbaseicms:=0;Totalicms:=0;
  for linha:=1 to Grid.rowcount do begin
    if trim(Grid.Cells[0,linha])<>'' then begin
      if Arq.TEstoque.Locate('esto_codigo',Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],[]) then begin
        codigograde:=FEstoque.GetCodigoGrade(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]);
        Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([Unidade,Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]]),[]);
        Sistema.Insert('Movestoque');
        Sistema.SetField('move_esto_codigo',Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]);
        codigolinha:=FEstoque.GetCodigoLinha(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],codigograde);
        codigocoluna:=FEstoque.GetCodigoColuna(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],codigograde);
        codigoestoque:=Grid.Cells[grid.GetColumn('move_esto_codigo'),linha];
        if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
          Sistema.SetField('move_tama_codigo',codigolinha)
        else
          Sistema.SetField('move_core_codigo',codigolinha);
        if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
          Sistema.SetField('move_tama_codigo',codigocoluna)
        else
          Sistema.SetField('move_core_codigo',codigocoluna);
        Sistema.SetField('move_transacao',transacao);
        Sistema.SetField('move_operacao',FGeral.GetOperacao);
        Sistema.SetField('move_numerodoc',numero);
        Sistema.SetField('move_status','N');
        Sistema.SetField('move_tipomov',Global.CodDevolucaoSerie5);
        Sistema.SetField('move_unid_codigo',Unidade);
        Sistema.SetField('move_tipo_codigo',strtoint(unidade));
        Sistema.SetField('move_tipocad','U');
        Sistema.SetField('move_repr_codigo',Representante);
        qtde:=Texttovalor(Grid.Cells[grid.GetColumn('move_qtde'),linha]);
        Sistema.SetField('move_qtde',qtde);
        Sistema.SetField('move_datalcto',Sistema.Hoje);
        Sistema.SetField('move_datamvto',Emissao);
        Sistema.SetField('move_DataCont',Emissao);
        Sistema.SetField('move_qtderetorno',0);
        venda:=Texttovalor(Grid.Cells[grid.GetColumn('move_venda'),linha]);
        Sistema.SetField('move_custo',Arq.TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
        Sistema.SetField('move_custoger',Arq.TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
        Sistema.SetField('move_customedio',Arq.TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
        Sistema.SetField('move_customeger',Arq.TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
        Sistema.SetField('move_venda',venda);
        Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
        Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
        Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
        Sistema.SetField('move_remessas',EdRemessas.Text);
        Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
        Sistema.SetField('Move_cst',FEstoque.Getsituacaotributaria(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring));
        Sistema.SetField('Move_aliicms',FEstoque.Getaliquotaicms(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring,Cliente.asinteger));
        Sistema.Post('');

        icmsitem:=FGeral.arredonda(venda*qtde*(FEstoque.Getaliquotaicms(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],
                  unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring,Cliente.asinteger)/100),2);
        totalitem:=FGeral.Arredonda(venda*qtde,2);
        if icmsitem>0 then begin
          Totalbaseicms:=Totalbaseicms+totalitem;
          Totalicms:=Totalicms+icmsitem;
        end else
          totalitem:=0;
        if Arq.TSittributaria.fieldbyname('sitt_cf').asstring=Global.CodigoSubsTrib then begin
          basesubs:=basesubs+( totalitem*(1+(Global.MargemSubsTrib/100)) );
        end;
        reducao:=0;isentas:=0;outras:=0;
        ValorContabil:=FGeral.Arredonda(venda*qtde,2);
        Base:=FGeral.Arredonda(venda*qtde,2);

        FGeral.GeraListaCstPerc(FEstoque.Getsituacaotributaria(codigoestoque,unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring),
                                FEstoque.Getaliquotaicms(codigoestoque,unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring,Cliente.asinteger),
                         valorcontabil,totalitem,reducao,isentas,outras,basesubs,ListaCstPerc);

// devolver ao estoque o q voltou
        QQtdeEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
                  ' and esqt_unid_codigo='+Stringtosql(Unidade));

        FGeral.MovimentaQtdeEstoque(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],Unidade,'E',Global.CodDevolucaoConsig,Texttovalor(Grid.Cells[grid.GetColumn('move_qtde'),linha]),QQtdeEstoque );
        QQtdeEstoque.Close;
        QQtdeEstoque.free;
      end else begin    // if se encontrou no estoque
        aviso('Codigo '+Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]+' n�o encontrado no estoque');
      end;
    end;
  end;   // ref. ao grid

// gravando  o mestre
///////////////////////////////////////////////
    if ValorTotal>0 then begin
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacao);
      Sistema.SetField('moes_operacao',GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',Numero);
      Sistema.SetField('moes_tipomov',Global.CodDevolucaoSerie5);
      Sistema.SetField('moes_unid_codigo',Unidade);
      Sistema.SetField('moes_tipo_codigo',strtoint(UNidade));
  //    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
      Sistema.SetField('moes_repr_codigo',Representante);
      Sistema.SetField('moes_tipocad','U');
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',Emissao);
      Sistema.SetField('moes_dataemissao',Emissao);
      Sistema.SetField('moes_DataCont',Emissao);
//      Sistema.SetField('moes_DataCont',Movimento);
      Sistema.SetField('moes_vlrtotal',Valortotal);
      Sistema.SetField('moes_remessas',EdRemessas.Text);
//      Sistema.SetField('moes_estado',Cliente.Resultfind.fieldbyname('clie_uf').asstring);
      Sistema.SetField('moes_estado',Arq.TUnidades.fieldbyname('unid_uf').asstring);
      Sistema.SetField('Moes_especie',Arq.TConfMovimento.fieldbyname('comv_especie').AsString);
      Sistema.SetField('Moes_serie',Arq.TConfMovimento.fieldbyname('comv_serie').AsString );
      if CompareStrings(Cliente.ResultFind.fieldbyname('clie_uf').AsString,Arq.TUnidades.fieldbyname('unid_uf').asstring) then
        Sistema.SetField('moes_natf_codigo',Arq.TConfMovimento.fieldbyname('comv_natf_estado').AsString)
      else
        Sistema.SetField('moes_natf_codigo',Arq.TConfMovimento.fieldbyname('comv_natf_foestado').AsString);
  //    Sistema.SetField('moes_tabp_codigo',Tabela);
  //    Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.SetField('Moes_cida_codigo',Arq.TUnidades.fieldbyname('unid_cida_codigo').asstring );
      Sistema.SetField('moes_totprod',Valortotal);
      Sistema.SetField('moes_valortotal',Valortotal);
      Sistema.SetField('moes_baseicms',TotalBaseicms);
      Sistema.SetField('moes_valoricms',Totalicms);
      Sistema.SetField('moes_comv_codigo',Arq.TConfMovimento.fieldbyname('comv_codigo').AsString);
      Sistema.Post();
    end;   // valortotal ( de retorno ) > 0
/////////////////////////////////////////////////
// Gerando o arquivo de bases de c�lculo conforme as situacoes tributarias existentes
/////////////////////////////////////////////////////////////////////////////////////
        for p:=0 to ListaCstPerc.Count-1 do begin
          PCstPerc:=Listacstperc[p];
          Sistema.Insert('MovBase');
          Sistema.SetField('movb_transacao',Transacao);
          Sistema.SetField('movb_operacao',GetOperacao);
          Sistema.SetField('movb_status','N');
          Sistema.SetField('movb_numerodoc',Numero);
          Sistema.SetField('Movb_cst',Pcstperc.cst);
  //////////        Sistema.SetField('Movb_Codigosfis',     'Simb',  talvez nao precise pois ja gravo o % icms
//          Sistema.SetField('Movb_TpImposto','I');   // fixo I-Icms
// 13.07.06
          Sistema.SetField('Movb_TpImposto',Pcstperc.tpimposto );
    // codigo de valores fiscais ( 1,,5 da impressao do livro fiscal )
  //        Sistema.SetField('Movb_CVF',cvf);    // checar - talvez nao precise
          Sistema.SetField('Movb_BaseCalculo',Pcstperc.base);
          Sistema.SetField('Movb_Aliquota',pcstperc.perc);
          Sistema.SetField('Movb_ReducaoBc',pcstperc.reducao);
//          Sistema.SetField('Movb_Imposto',FGeral.Arredonda(pcstperc.base*(pcstperc.perc/100),2) );
// 23.05.07
          Sistema.SetField('Movb_Imposto',FGeral.Arredonda( ( ( pcstperc.base*(pcstperc.reducao/100) ) ) * (pcstperc.perc/100),2) );

          Sistema.SetField('Movb_Isentas',pcstperc.isentas);
          Sistema.SetField('Movb_Outras' ,pcstperc.outras);
          Sistema.SetField('Movb_tipomov',Global.CodDevolucaoSerie5);
          Sistema.SetField('Movb_unid_codigo',Unidade);  // 13.07.06
          Sistema.Post();
        end;


// se for o caso gerar nf venda com a diferenca - neste caso sempre ser� o caso, a partir do retorno do romaneio
////////////////////////////////////////////////
      if not Arq.TEstoque.Active then Arq.TEstoque.Open;
      if not Arq.TEstoqueQtde.Active then Arq.TEstoqueQtde.Open;
      if not Arq.TConfMovimento.Active then Arq.TConfMovimento.Open;
      if not Arq.TUnidades.Active then Arq.TUnidades.Open;
      Arq.TUnidades.Locate('unid_codigo',Unidade,[]);
      Numeronf:=FGeral.GetContador('NFLIQSERIE'+Arq.TConfMOvimento.fieldbyname('comv_serie').asstring,false);

// Gerando a pendencia a receber LIQUIDA - Venda serie 4 - devolucao serie 5
/////////////////////////////////////////////////////////////////////////////////////
      ListaPrazos:=TStringList.Create;
      n:=FCondPagto.GetPrazos(Condicao,ListaPrazos);
// ver se for a vista jogar na conta caixa ( configura��o na unidade )
      nparcelas:=FCondPagto.GetNumeroParcelas(Condicao);
// verificar se � a vista com apenas uma parcela OU se somente a primeira parcela � a vista ( ou parte do total )
      valorparcela:=0;
      if FCondPagto.GetPerEntrada(Condicao)>0 then begin
        valorparcela:=FGeral.Arredonda(valorvenda*(Arq.TFPgto.fieldbyname('fpgt_entrada').AsCurrency/100),2);
        GravaMovFinanceiro(valorparcela);
        valortotal:=valorvenda-valorparcela;
      end;
      valorparcela:=0;acumulado:=0;

      if FCondPagto.GetAvPz(Condicao)='P' then begin
        for p:=1 to nparcelas do begin
          Sistema.Insert('Pendencias');
          Sistema.SetField('Pend_Transacao',Transacao);
          Sistema.SetField('Pend_Operacao',GetOperacao);
          Sistema.SetField('Pend_Status','N');
          Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
          Sistema.SetField('Pend_DataCont',Movimento);
          Sistema.SetField('Pend_DataMvto',Emissao);
          Sistema.SetField('Pend_DataVcto',FGeral.GetProximoDiaUtil(Emissao+Inteiro(ListaPrazos[p-1])) );
          Sistema.SetField('Pend_DataEmissao',Emissao);
    //      Sistema.SetField('Pend_DataAutPgto','D',0,0,60,True,'Data Aut. Pgto','Data autorizada para pagamento','',True,'1','','','0');
          Sistema.SetField('Pend_Plan_Conta',Cliente.Resultfind.fieldbyname('clie_contagerencial').AsInteger);
          Sistema.SetField('Pend_Unid_Codigo',Unidade);
          Sistema.SetField('Pend_Fpgt_Codigo',Condicao);
          Sistema.SetField('Pend_Port_Codigo',Global.VCPort);
          Sistema.SetField('Pend_Hist_Codigo',Global.VCHist);
          Sistema.SetField('Pend_Moed_Codigo','');
          Sistema.SetField('Pend_Repr_Codigo',Representante);
          Sistema.SetField('Pend_Tipo_Codigo',Cliente.Asinteger);
          Sistema.SetField('Pend_TipoCad'    ,'C');
    //      Sistema.SetField('Pend_CNPJCPF',EdCliente.Resultfind('clie_cnpjcpf);
          Sistema.SetField('Pend_Complemento',global.VCComplehist);
          Sistema.SetField('Pend_NumeroDcto',Numeronf);
          Sistema.SetField('Pend_Parcela',p);
          Sistema.SetField('Pend_NParcelas',nparcelas);
          Sistema.SetField('Pend_RP','R');
          if p=nparcelas then
            valorparcela:=valorvenda-acumulado  // para deixar na ultima parcelas "as d�zimas"
          else
            valorparcela:=FGeral.Arredonda(valorvenda/nparcelas,2);
          acumulado:=acumulado+valorparcela;
          Sistema.SetField('Pend_Valor',valorparcela);
          Sistema.SetField('Pend_ValorTitulo',valorvenda);
          Sistema.SetField('Pend_Juros',0);
          Sistema.SetField('Pend_Multa',0);
          Sistema.SetField('Pend_Mora',0);
          Sistema.SetField('Pend_Acrescimos',0);
          Sistema.SetField('Pend_Descontos',0);
          Sistema.SetField('Pend_ValorComissao',0);
          Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
          Sistema.SetField('Pend_ContaBaixa',0);
  //        Sistema.SetField('Pend_DataBaixa',0);
          Sistema.SetField('Pend_Observacao','');
//          Sistema.SetField('Pend_UsuAutPgto','');
          Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
          Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso j� foi enviado para impress�o
          Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exporta��o banc�ria (CNAB )
          Sistema.Post;
        end;  // for do numero de parcelas
      end;   // vista ou a prazo
      Freeandnil(ListaPrazos);


// 04.07.05 - fazer novo botao pra fechamento igual ao da pronta entrega
{
// marcar as notas serie 4 como ja devolvidas
  ExecuteSql('Update movesto set moes_status=''D'' where moes_tipo_codigo='+Cliente.AsSql+
                     ' and '+FGeral.GetIN('moes_numerodoc',EdRemessas.TExt,'N')+
                     ' and moes_unid_codigo='+stringtosql(Unidade)+
                     ' and moes_status=''N'' and '+FGeral.Getin('moes_tipomov',Global.CodVendaSerie4,'C') );
  ExecuteSql('Update movestoque set move_status=''D'' where move_tipo_codigo='+Cliente.AsSql+
                     ' and '+FGeral.GetIN('move_numerodoc',EdRemessas.TExt,'N')+
                     ' and move_unid_codigo='+stringtosql(Unidade)+
                     ' and move_status=''N'' and '+FGeral.Getin('move_tipomov',Global.CodVendaSerie4,'C') );
}

end;

function TFGeral.GetSequencial(quantos: integer; campo,tipocampo,tabela: string): integer;
var Q:TSqlquery;
begin
  Q:=TSQLQuery.Create(Application);
  Q.SQLConnection := Sistema.Conexao;
  Q.SQL.Text:= 'select max('+campo+') as ultimo from '+tabela;
  Q.open;
  if not Q.eof then begin
    if Q.fieldbyname('ultimo').isnull then
      result:=1
    else begin
      if tipocampo='N' then
        result:=Q.fieldbyname('ultimo').asinteger+quantos
      else
        result:=strtoint(Q.fieldbyname('ultimo').asstring)+quantos;
    end;
  end else begin
    result:=1;
  end;
  Q.Close;
  Freeandnil(Q);
end;

procedure TFGeral.PoeData(Ed: TSqled; key: word);
begin
  if key=vk_f2 then
    Ed.setdate(Sistema.hoje);
end;



function TFGeral.GetDiasAtraso(vencimento, hoje: TDatetime): integer;
begin
  if vencimento<hoje then
    result:=trunc(vencimento-hoje)
  else
    result:=0;
end;

procedure TFGeral.IncluiGrid(Grid: TSqlDtgrid; codigo: string ; campocodigo:string='');
var x:integer;
begin
  if (Grid.RowCount=2) and (Trim(Grid.Cells[0,1])='') then begin
     x:=1;
  end else begin
     Grid.RowCount:=Grid.RowCount+1;
     x:=Grid.RowCount-1;
  end;
  if trim(campocodigo)='' then
    Grid.Cells[0,x]:=codigo
  else
    Grid.Cells[Grid.getcolumn(campocodigo),x]:=codigo;
end;


function TFGeral.CalcDescAcre(valorbruto, perc: currency ; Tipo:string): currency;
begin
  if tipo='D' then
    result:=valorbruto - (valorbruto*(perc/100))
  else
    result:=valorbruto + (valorbruto*(perc/100));
end;


/////////////////////////////////////////////////////////////////////////////
procedure TFGeral.ImpDevolucao(numero:integer;tipomov,semvideo:string  ; unidade:string='');
/////////////////////////////////////////////////////////////////////////////
var QBusca,QClientes:TSqlquery;
    tit,descacre,produto:string;
    valorbruto,tqtde,tdescacre,venda,pqtde,valortotal:currency;
    titem,largura:integer;
begin
//  QBusca:=sqltoquery(FGeral.buscaremessa(Numero,tipomov,'N'));
// 02.05.05 - encontrava as DC somente quando n�o fechava o acerto
  QBusca:=sqltoquery(FGeral.buscaremessa(Numero,tipomov,'N;D',unidade));
{ - 04.05.05 = ver porque esta porra, filha da puta nao encontra 4235 - RM
// 24.05.06 - quase certo q o anta estava com a base no notebook e o pgadmin no servidor..tsc, tsc
  QBusca:=sqltoquery('select movesto.*,movestoque.* from movesto,movestoque'+
          ' where moes_numerodoc='+inttostr(Numero)+
          ' and '+Fgeral.getin('moes_status','N;D','C')+
          ' and '+FGeral.Getin('moes_tipomov','RM','C')+
          ' and moes_numerodoc=move_numerodoc'+
          ' and '+FGeral.Getin('move_tipomov','RM','C')+
          ' and '+Fgeral.getin('move_status','N;D','C')+
          ' and moes_unid_codigo='+stringtosql(Global.CodigoUnidade)+
          ' and move_unid_codigo='+stringtosql(Global.CodigoUnidade)+
          ' and '+FGeral.Getin('move_tipomov','RM','C')+
          ' and substr(moes_transacao,1,1)<>''I'''+   // para n�o confundir com remessas ou devoluc�eos importadas
          ' order by move_esto_codigo' );
}
  if QBusca.Eof then begin  // 29.04.05 - � aqui q ijui diz q nao encontra no ret. de consig.
    Avisoerro(Tipomov+' numero '+inttostr(Numero)+' n�o encontrado');
    exit;
  end;
  if not Confirma('Confirma impress�o do retorno/devolu��o ?') then exit;
  Sistema.BeginProcess('');
  largura:=80;
  if Global.Usuario.OutrosAcessos[3309] then  // 26.08.10 - impressora laser/usb
    largura:=109;
  FTextRel.Init(65,nil,nil,0,Global.Usuario.OutrosAcessos[3309]);
  FTextRel.MargemEsquerda:=3;
  FTextRel.Titulo.Clear;
  FTextRel.ClearColunas;
  if tipomov=Global.CodDevolucaoConsig then
    tit:='parcial de Consigna��o'
  else if (TipoMov=Global.CodDevolucaoTroca) then
    tit:='de troca de Consigna��o'
  else
    tit:='de Pronta Entrega';
  FTextRel.AddTitulo(FGeral.Centra('Devolu��o '+tit,largura),true,False,false);
  FTextrel.SaltaLinha(2);
  FTextRel.AddLinha('Emiss�o : '+QBusca.fieldbyname('moes_dataemissao').Asstring+space(40)+
                    'N�mero : '+QBusca.fieldbyname('moes_numerodoc').Asstring
                    ,false,False,false);
  FTextRel.AddLinha('Vendedor: '+QBusca.fieldbyname('moes_repr_codigo').Asstring+' - '+
                    FRepresentantes.GetDescricao(QBusca.fieldbyname('moes_repr_codigo').AsInteger)
                    ,false,False,false);
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
  FTextrel.SaltaLinha(1);
  if not Arq.TUnidades.Active then Arq.TUnidades.Open;
//  if not Arq.TClientes.Active then Arq.TClientes.Open;
  if not Arq.TMunicipios.Active then Arq.TMunicipios.Open;
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.open;
  Arq.TUnidades.Locate('unid_codigo',QBusca.Fieldbyname('Moes_Unid_codigo').Asstring,[]);
//  Arq.TClientes.Locate('clie_codigo',QBusca.Fieldbyname('Moes_tipo_codigo').AsINteger,[]);
// 15.02.05
  QClientes:=sqltoquery('select * from clientes where clie_codigo='+QBusca.Fieldbyname('Moes_tipo_codigo').Asstring);
  Arq.TMunicipios.Locate('cida_codigo',QClientes.Fieldbyname('clie_cida_codigo_res').AsInteger,[]);
  FTextRel.AddLinha('Cliente......: '+QClientes.fieldbyname('clie_nome').AsString,false,False,false);
  FTextRel.AddLinha('Codigo.......: '+QClientes.Fieldbyname('clie_codigo').Asstring,false,False,false);
  FTextRel.AddLinha('Raz�o Social : '+strspace(QClientes.Fieldbyname('clie_razaosocial').Asstring,43)+
                    'Tel.:'+FGeral.Formatatelefone(QClientes.Fieldbyname('clie_foneres').Asstring)
                    ,false,False,false);
  FTextRel.AddLinha('Endere�o.....: '+strspace(QClientes.Fieldbyname('clie_endres').Asstring,40)+space(03)+
                    'CPF :'+FGeral.Formatacpf(QClientes.Fieldbyname('clie_cnpjcpf').Asstring)
                    ,false,False,false);
  FTextRel.AddLinha('Bairro.......: '+strspace(QClientes.Fieldbyname('clie_bairrores').Asstring,40)
                    ,false,False,false);
  FTextRel.AddLinha('Cep/Cidade/UF: '+FGeral.formatacep(QClientes.Fieldbyname('clie_cepres').Asstring)+' - '+
                    Arq.TMunicipios.Fieldbyname('cida_nome').Asstring+' - '+
                    strspace(Arq.TMunicipios.Fieldbyname('cida_uf').Asstring,02)
                    ,false,False,false);
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
  FTextRel.SaltaLinha(2);

  if Global.Usuario.OutrosAcessos[3309] then  // 26.08.10 - impressora laser/usb
    FTextRel.AddLinha(space(04)+'Codigo'+space(11)+'Quantidade'+space(5)+'Devolu��o'+space(2)+'Descri��o'+space(22)+'Pe�as Vendidas'+
                    space(01)+'Vlr. Unit�rio'
                    ,false,False,true)
  else
    FTextRel.AddLinha(space(04)+'Codigo'+space(12)+'Quantidade'+space(5)+'Devolu��o'+space(2)+'Descri��o'+space(36)+'Pe�as Vendidas'+
                    space(01)+'Vlr. Unit�rio'
                    ,false,False,true);
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
  tqtde:=0;titem:=0;
  if Arq.TTabelaPreco.Locate('tabp_codigo',QBusca.Fieldbyname('Moes_tabp_codigo').AsInteger,[]) then begin
    descacre:=Arq.TTabelaPreco.Fieldbyname('tabp_tipo').AsString;
  end else
    descacre:='';
  valorbruto:=0;valortotal:=0;

  while not QBusca.Eof do begin
    produto:=QBusca.Fieldbyname('Move_esto_codigo').AsString;
    pqtde:=0;
    while (not QBusca.Eof) and (produto=QBusca.Fieldbyname('Move_esto_codigo').AsString) do begin
      tqtde:=tqtde+QBusca.Fieldbyname('Move_qtde').AsCurrency;
      pqtde:=pqtde+QBusca.Fieldbyname('Move_qtde').AsCurrency;
      venda:=QBusca.Fieldbyname('Move_venda').AsCurrency;
      valorbruto:=valorbruto+(QBusca.Fieldbyname('Move_qtde').AsCurrency*QBusca.Fieldbyname('Move_vendabru').AsCurrency);
      valortotal:=valortotal+(QBusca.Fieldbyname('Move_qtde').AsCurrency*QBusca.Fieldbyname('Move_venda').AsCurrency);
      QBusca.Next;
    end;
    if Global.Usuario.OutrosAcessos[3309] then  // 26.08.10 - impressora laser/usb
      FTextRel.AddLinha(space(04)+strspace(produto,13)+space(03)+
                    FGeral.Formatavalor(pqtde,'###,##0.000')+space(02)+
                    replicate('_',12)+space(02)+strspace(FEstoque.GetDescricao(produto),31)+
                    space(02)+replicate('_',12)+space(01)+FGeral.Formatavalor(venda,'##,###,##0.00')
                    ,false,False,true)
    else
      FTextRel.AddLinha(space(04)+strspace(produto,13)+space(03)+
                    FGeral.Formatavalor(pqtde,'###,##0.000')+space(02)+
                    replicate('_',12)+space(02)+strspace(FEstoque.GetDescricao(produto),45)+
                    space(02)+replicate('_',12)+space(02)+FGeral.Formatavalor(venda,f_cr)
                    ,false,False,true);
    inc(titem);
  end;

  QBusca.First;
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
//  tdescacre:=FGeral.Arredonda(QBusca.fieldbyname('moes_vlrtotal').AsCurrency*(QBusca.fieldbyname('moes_tabaliquota').AsCurrency/100) ,2);
  tdescacre:=FGeral.Arredonda(valorbruto-QBusca.fieldbyname('moes_vlrtotal').AsCurrency ,2);
  if tdescacre>0 then
    FTextRel.AddLinha(space(39)+'Total Mercadorias....: R$ '+FGeral.Formatavalor(valorbruto,'###,##0.00'),false,False,false)
  else begin
// 05.09.06 - erro na gravacao da devolucao no acerto da consig.
    if QBusca.fieldbyname('moes_vlrtotal').AsCurrency>0 then
      FTextRel.AddLinha(space(39)+'Total Mercadorias....: R$ '+FGeral.Formatavalor(QBusca.fieldbyname('moes_vlrtotal').AsCurrency,'###,##0.00'),false,False,false)
    else
      FTextRel.AddLinha(space(39)+'Total Mercadorias....: R$ '+FGeral.Formatavalor(valortotal,'###,##0.00'),false,False,false);
  end;
//  if descacre='D' then begin
//    FTextRel.AddLinha(space(39)+'Desconto sobre total.: R$ '+FGeral.Formatavalor(tdescacre,'###,##0.00'),false,False,false);
//    liquido:=QBusca.fieldbyname('moes_vlrtotal').AsCurrency;   //-tdescacre;
//  end else if descacre='A' then begin
//    liquido:=QBusca.fieldbyname('moes_vlrtotal').AsCurrency;  // +tdescacre;
//    FTextRel.AddLinha(space(39)+'Acr�scimo sobre total: R$ '+FGeral.Formatavalor(tdescacre,'###,##0.00'),false,False,false);
//  end;
//  if tdescacre>0 then
//    FTextRel.AddLinha(space(39)+'Total l�quido........: R$ '+FGeral.Formatavalor(liquido,'###,##0.00'),false,False,false);
//  FTextRel.AddLinha(space(39)+'Total em Quantidade..:    '+FGeral.Formatavalor(tqtde,'###,##0.000'),false,False,false);
  FTextRel.AddLinha(strzero(QBusca.fieldbyname('moes_usua_codigo').asinteger,4)+' - '+strspace(FUsuarios.getnome(QBusca.fieldbyname('moes_usua_codigo').asinteger),32)+'Total em Quantidade..:    '+FGeral.Formatavalor(tqtde,'###,##0.000'),false,False,false);
  FTextRel.AddLinha(space(39)+'Total de Itens.......:    '+FGeral.Formatavalor(titem,'####'),false,False,false);
  FTextRel.SaltaLinha(2);
//  FTextRel.AddLinha('Data para acerto : '+formatdatetime('dd/mm/yy',QBusca.fieldbyname('moes_dataemissao').AsDateTime+30)+
//                    space(06)+'Data segunda visita ____/____/____',false,False,false);
//  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
  FTextRel.SaltaLinha(2);
  FTextRel.AddLinha('Declaro que devolvi as mercadorias acima discriminadas : '+
                    replicate('_',21),false,False,false);
  if semvideo='N' then
    FTextRel.Video
  else
//    Imprimesemvideo;
    if Global.topicos[1030] then
// 04.09.12 - Vivan - Lindacir - '2 vias'
      Imprimesemvideo( 2 )
    else
      Imprimesemvideo( 1 );

  Sistema.EndProcess('');
  QBusca.close;
  Freeandnil(QBusca);
end;


procedure TFgeral.Imprimesemvideo(nropaginas:integer=1);
//////////////////////////////////////////////////////////
begin
//  FTextrel.PrintDialog.Execute;
//  FTextrel.Impr.NomeImpressora:=FTextrel.Impr.PegaImpPadrao;
  if nropaginas=0 then nropaginas:=1;
  if Global.Usuario.OutrosAcessos[3309] then begin // 26.08.10 - impressora laser/usb
//    FTextRel.RelAux.Lines.Assign(FTextRel.Rel.Lines );
//    FTextRel.ImprimeTexto(FTextRel.RelAux);
    FTextRel.bImprimeClick(self);
  end else begin
    FTextrel.PrintDialog.Execute; // 06.05.11
    FTextrel.Impr.NomeImpressora:=FTextrel.Impr.PegaImpPadrao; // 06.05.11
    if nropaginas=2  then begin
      FTextrel.Print(1,1);
      FTextrel.Print(1,1);
    end else
      FTextrel.Print(1,nropaginas);
  end;
end;




function TFGeral.TiraBarra(s: string ;  caracter:string='/';caracternolugar:string='' ): string;
////////////////////////////////////////////////////////////////////////////////////////////////
var p:integer;
begin
  result:='';
  for p:=1 to length(s) do begin
//    if copy(s,p,1)<>caracter then
// 20.11.08
    if pos( copy(s,p,1),caracter ) =0 then
      result:=result+copy(s,p,1)
    else
      result:=result+caracternolugar;  // 11.02.15
  end;
end;

function TFGeral.GetValorAvista(Listaprazo: Tstringlist ; valor:currency=0): currency;
//var valor:currency;
begin
  result:=0;
  if ListaPrazo.count>0 then begin
    if ListaPrazo.count=1 then begin
      if inteiro(ListaPrazo[0])=0 then
         result:=0;
    end else begin
      if inteiro(ListaPrazo[0])=0 then
        Getvalor(valor);
    end;
    result:=valor;
  end;
end;


function TFGeral.Getvalor(var Num:Currency; titulo:string=''):Boolean;
//////////////////////////////////////////////////////////////////////
var Form: TForm;
    Edti:TSQLEd;
begin
  Form := TForm.Create(Application);
  with Form do begin
    BorderStyle := bsDialog;
    if trim(titulo)<>'' then
      Caption := 'Informe '+titulo
    else
      Caption := 'Informe o Valor';
//    Width:=160;Height:=70;
// 20.12.11
    Width:=190;Height:=70;
    Position:=poScreenCenter;
    Edti:=TSQLEd.Create(Form);
    with Edti do begin
      Parent:=Form;
      Alignment:=taRightjustify;
      Valueformat:='####,###.00';
      Decimals:=2;
      Valuemax:='9999999';
      Valuemin:='0';
      TypeValue:=tvFloat;
      Empty:=True;
      Title:='Valor';
      TitlePixels:=40;
      TitlePos:=tppLeft;
      CloseFormEsc:=True;
      CloseForm:=True;
      Text:=Floattostr(Num);
      SetBounds(70,10,55,21);
    end;
  end;
  Form.ActiveControl:=Edti;
  Form.ShowModal;
  Num:=Edti.AsCurrency;
  Result:=True;
//  if Length(StrToStrNumeros(Str))<>6 then Result:=False;
//  if Inteiro(LeftStr(Str,2))<=0 then Result:=False;
//  if Inteiro(LeftStr(Str,2))>12 then Result:=False;
  if not Result then begin
     Num:=0;
     AvisoErro('Valor inv�lido');
  end;
  Form.Free;
end;



function TFGeral.GetDatainiciomes(Data: TDatetime): TDatetime;
begin
  result:=texttodate( '01'+strzero(Datetomes(Data),2)+strzero(Datetoano(Data,true),4) );
end;


function TFGeral.EstaemAberto(campo, remessas: string): boolean;
//////////////////////////////////////////////////////////////////
var lista:tstringlist;
    p:integer;
begin
   result:=false;
   if trim(campo)<>'' then begin
     lista:=tstringlist.create;
     strtolista(lista,campo,';',true);
     for p:=0 to lista.count-1 do begin
       if trim( lista[p] )<>'' then begin    // 14.06.06
         if ansipos( strzero(strtointdef(lista[p],0),8),remessas )>0 then begin
// 30.12.05
 //       if pos( strzero(strtointdef(lista[p],0),8),remessas )>0 then begin
           result:=true;
           break;
         end;
       end;
     end;
   end;

//  22.02.05
//   else
//     result:=true;
end;

procedure TFGeral.SetaEdEntidade(EdCodtipo: TSqled ; TipoCad:string);
begin
  if TipoCad='U' then begin
    EdCodtipo.ShowForm:='FUnidades';
    EdCodtipo.FindTable:='unidades';
    EdCodtipo.FindField:='unid_codigo';
  end else if TipoCad='C' then begin
    EdCodtipo.ShowForm:='FCadcli';
    EdCodtipo.FindTable:='clientes';
    EdCodtipo.FindField:='clie_codigo';
    EdCodtipo.title:='Cliente';
    Edcodtipo.FindSetField:='CLIE_NOME';
  end else if TipoCad='F' then begin
    EdCodtipo.ShowForm:='FFornece';
    EdCodtipo.FindTable:='fornecedores';
    EdCodtipo.FindField:='forn_codigo';
    EdCodtipo.title:='Fornec.';
    Edcodtipo.FindSetField:='FORN_NOME';
  end else if TipoCad='T' then  begin
    EdCodtipo.ShowForm:='FTransp';
    EdCodtipo.FindTable:='transportadores';
    EdCodtipo.FindField:='tran_codigo';
  end else if TipoCad='R' then begin
    EdCodtipo.ShowForm:='FRepresentantes';
    EdCodtipo.FindTable:='representantes';
    EdCodtipo.FindField:='repr_codigo';
  end else begin
    EdCodtipo.ShowForm:='';
    EdCodtipo.FindTable:='';
    EdCodtipo.FindField:='';
  end;

end;

function TFGeral.GetPrecoVenda(Codigoproduto, unidade: string): currency;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select esqt_vendavis from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(Codigoproduto)+
                ' and esqt_unid_codigo='+Stringtosql(Unidade));
  result:=0;
  if not Q.Eof then begin
    result:=Q.fieldbyname('esqt_vendavis').AsCurrency;
  end;
  Q.close;
  Freeandnil(Q);
end;

function TFGeral.GetSqlBuscaCodigoGrade(Codigoproduto, unidade: string;
  cor, tamanho,copa: integer): string;

begin
  result:='select * from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(Codigoproduto)+
                ' and esgr_unid_codigo='+Stringtosql(Unidade)+' and esgr_tama_codigo='+inttostr(tamanho)+
                ' and esgr_core_codigo='+inttostr(cor)+' and  '+
                ' ( esgr_copa_codigo='+inttostr(copa)+' or esgr_copa_codigo is null )'  ;
end;

procedure TFGeral.Fechatudo;
var usuariopadrao,i:integer;
    s,forms:string;
    form:TForm;
begin
  usuariopadrao:=Global.usuariopadrao;
  forms:='FGERAL;FMAIN';
  if not Arq.TUsuarios.Active then Arq.TUsuarios.Open;
  if Arq.TUsuarios.Locate('Usua_Codigo',usuariopadrao,[]) then begin
    for i:=0 to Application.ComponentCount-1 do begin
        if Application.Components[i] is TForm then begin
           Form:=TForm(Application.Components[i]);
           if ansipos(uppercase(form.Name),forms)=0 then
              if Form.Active then
                Form.Close;
        end;
    end;
    Global.Usuario.Nome:=Arq.TUsuarios.FieldByName('Usua_Nome').AsString;
    Global.Usuario.Codigo:=usuariopadrao;
    Sistema.CodigoUsuario:=IntToStr(Global.Usuario.Codigo);
    Sistema.NomeUsuario:=Global.Usuario.Nome;
    Global.Usuario.UnidadesMvto:=Trim(Arq.TUsuarios.FieldByName('Usua_UnidadesMvto').AsString);
    Global.Usuario.UnidadesRelatorios:=Trim(Arq.TUsuarios.FieldByName('Usua_UnidadesRelatorios').AsString);
    Global.Usuario.TiposDctosRelatorios:=Trim(Arq.TUsuarios.FieldByName('Usua_TpDctosRelatorios').AsString);
    Global.Usuario.ContasCaixaValidas:=';'+Trim(Arq.TUsuarios.FieldByName('Usua_ContasCaixaValidas').AsString)+';';
//        Global.Usuario.ContasAutPgto:=';'+FPlanoGer.GetContasSubordinadas(Trim(Arq.TUsuarios.FieldByName('Usua_ContasAutPgto').AsString),'CR,CP');
    s:=StrSpace(Arq.TUsuarios.FieldByName('Usua_ObjetosAcessados').AsString,4000);
    for i:=1 to 4000 do Global.Usuario.ObjetosAcessados[i]:=s[i]='S';
    s:=StrSpace(Arq.TUsuarios.FieldByName('Usua_OutrosAcessos').AsString,4000);
    for i:=1 to 4000 do Global.Usuario.OutrosAcessos[i]:=s[i]='S';
    FUsuarios.GravaAcessando('S');
    FUsuarios.ProcessaAcessoObjetos;
    FMain.PUsuario.Caption:=' '+IntToStr(Global.Usuario.Codigo)+' - '+Global.Usuario.Nome;
    FRel.SetParams(Global.NomeSistema,FGeral.GetConfig1AsString('TituloRelatorios')+' - '+Global.NomeSistema+' '+Global.VersaoSistema,
        FUsuarios.Acesso(3301),FUsuarios.Acesso(3302),FUsuarios.Acesso(3304),FUsuarios.Acesso(3303),false);
  end else
    Avisoerro('Usu�rio '+inttostr(usuariopadrao)+' n�o encontrado');

end;

function TFGeral.GetInscEstadualTipoCad(codigo: integer;
  Tipocad: string): string;
begin
  if TipoCad='C' then
    result:=FCadcli.GetInsEst(codigo)
  else if TipoCad='F' then
    result:=FFornece.GetInsEst(codigo)
  else if TipoCad='R' then
    result:=FRepresentantes.GetInsEst(codigo)
  else if TipoCad='U' then
    result:=FUnidades.GetInsEst(strzero(codigo,3))
  else if TipoCad='T' then
    result:=FTransp.GetInsEst(strzero(codigo,3))
  else
    result:=FTransp.GetInsEst(strzero(codigo,3))

end;

function TFGeral.QualSerie(serieCM, serieunidade, tipomov: string): string;
//////////////////////////////////////////////////////////////////////////////
begin
   if trim(tipomov)='' then begin
//     if trim(serieunidade)<>'' then
//       result:=serieunidade
//     else
//       result:=serieCM;
     if trim(serieCM)<>'' then
       result:=serieCM
     else
       result:=serieunidade;
   end else begin
     if pos( tipomov,'VC;VD')>0 then begin
//       if trim(serieunidade)<>'' then
//         result:=serieunidade
//       else
//         result:=serieCM;
       if trim(serieCM)<>'' then
         result:=serieCM
       else
         result:=serieunidade;
     end else begin   // 18.07.05
//       if trim(serieunidade)<>'' then
//         result:=serieunidade
//       else
//         result:=serieCM;
         if trim(serieCM)<>'' then
           result:=serieCM
         else
           result:=serieunidade;
       end;
   end;

end;

function TFGeral.SimilarTo(campo, variavel: string): string;
begin
   if copy(variavel,length(variavel),1)=';' then
     variavel:=copy(variavel,1,length(variavel)-1);
   variavel:='%'+variavel+'%';
   result:=campo+' SIMILAR TO '+stringtosql(variavel);
end;

procedure TFGeral.Checaremessas(codigo: integer; unidade: string);
///////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
begin
  q:=sqltoquery('select move_numerodoc,move_status,move_tipo_codigo,move_unid_codigo from movestoque'+
          ' inner join movesto on ( moes_transacao=move_transacao )'+
          ' where '+Fgeral.getin('move_status','N','C')+
          ' and '+FGeral.Getin('move_tipomov','RC;DC;DR','C')+
          ' and move_tipo_codigo='+inttostr(codigo)+
          ' and move_unid_codigo<>'+stringtosql(unidade)+
          ' and move_tipocad=''C'''+
          ' order by move_unid_codigo') ;
  if not Q.eof then begin
    Avisoerro('ATEN��O !!! Cliente com remessas/devolu��es pendentes na unidade '+Q.fieldbyname('move_unid_codigo').asstring);
  end;
  Q.close;
  Freeandnil(Q);

end;

function TFGeral.Datetostringinvertida(data: tdatetime): string;
var ano,mes,dia:integer;
begin
  ano:=datetoano(data,true);
  mes:=datetomes(data);
  dia:=datetodia(data);
  result:=strzero(ano,4)+strzero(mes,2)+strzero(dia,2);
end;

function TFGeral.DataStringinvertida(data: string): string;
var d:Tdatetime;
begin
  if length(data)=6 then  // 100505
    result:=strzero(2000+strtoint(copy(data,5,2)),4)+copy(data,3,2)+copy(data,1,2)
  else if length(data)=8 then  // 10/05/05
    result:=strzero(2000+strtoint(copy(data,7,2)),4)+copy(data,4,2)+copy(data,1,2)
  else                         // 10/05/2005
    result:=copy(data,7,4)+copy(data,4,2)+copy(data,1,2);
{
  try
    d:=texttodate( data );
    result:=formatdatetime('yyyymmdd',d);
  except
    try
      d:=strtodate( data );
      result:=formatdatetime('yyyymmdd',d);
    except
      avisoerro('problema :'+data);
    end;
  end;
  }
end;


   function GetFiscalDentro(unidade:string):string;
   ///////////////////////////////////////////////////
   begin
     result:=FUnidades.GetFiscalDentro(unidade);
   end;


   function GetFiscalFora(unidade:string):string;
   ///////////////////////////////////////////////////
   begin
     result:=FUnidades.GetFiscalFora(unidade);
   end;

{
Unidade	fiscal estado	fiscal fora estado	cod. Cst estado	cod. Cst Fora estado
1	           2	         3	                   3                   	3
2	           2	         3	                   2	                  3
3	           1	         1	                   3	                  3
4	           2	         3	                   3	                  3
7	           1	         1	                   3	                  3
9	           2	         3	                   3	                  3
100	         1	         1	                   4	                  4
333	         2	         3                     3                  	3
}
   function GetSittDentro(unidade:string):integer;
   begin
     result:=FUnidades.GetSittDentro(unidade);
   end;

   function GetSittFora(unidade:string):integer;
   begin
     result:=FUnidades.GetSittFora(unidade);
   end;


procedure TFGeral.SetaCodigosUnidades;
////////////////////////////////////////////
{
Unidade	fiscal estado	fiscal fora estado	cod. Cst estado	cod. Cst Fora estado
1	           2	         3	                   3                   	3
2	           2	         3	                   2	                  3
3	           1	         1	                   3	                  3
4	           2	         3	                   3	                  3
7	           1	         1	                   3	                  3
9	           2	         3	                   3	                  3
100	         1	         1	                   4	                  4
333	         2	         3                     3                  	3
}


begin
   global.Unidadecuritiba:='003';
   global.unidadebeltrao:='007';
   global.unidadeijui:='004';
   global.unidadeijui333:='333';
   global.unidadecrisciuma:='002';
   global.unidadejoinvile:='009';
   global.unidadematriz:='001';
   global.unidadematriz999:='999';
   Global.CstTransferencia:='000';  // 06.07.05
   Global.CstTransferenciaSC:='051';  // 08.09.05
   global.unidadeexportacao:='100';   // 17.10.05
   Global.unidadefloripa:='900';   // 28.11.05
   Global.UnidadesTestes:='888';
end;

function TFGeral.Gettipoentidade(tipocad: string): string;
///////////////////////////////////////////////////////////////
begin
  if TipoCad='U' then begin
    Result:='Unidade'
  end else if TipoCad='C' then begin
    Result:='Cliente'
  end else if TipoCad='F' then begin
    Result:='Fornecedor';
  end else if TipoCad='T' then  begin
    Result:='Transportador';
  end else if TipoCad='R' then begin
    Result:='Representante';
  end else begin
    Result:='';
  end;

end;

// esta aqui em 03.03.05
function TFGeral.Exportanumeros(Valor:Currency;Tam,Decimais:integer;Ponto:string='N';RetornavazioseZero:boolean=false):String;
var retorno:string;
begin
  if (Tam > 0) and (Tam >= Decimais+1) then begin
    str(valor:Tam:Decimais,retorno);                   
    if ponto='N' then
      retorno:=StrToStrNumeros(retorno);
    retorno:=strzero(0,Tam-length(retorno))+retorno;
// 16.10.08    
    if (RetornaVazioseZero) and (Texttovalor(retorno)=0) then
      retorno:='';
  end else
    retorno:=strzero(0,15);
  result:=retorno;
end;

procedure TFGeral.ImpRemessa(numero: integer; tipomov, semvideo: string);
var largura,titem:integer;
    tqtde:currency;
    QBusca,Qclientes:TSqlquery;
    descacre:string;
    valorbruto,tdescacre,liquido:currency;

begin
//  if tipomov=Global.CodVendaTransf then
//    QBusca:=sqltoquery(FGeral.buscaremessa(Numero,tipomov,'F'))
//  else
// retirado if em 23.06.05 - alterado o trato com a  VT e esquecido de 'reajustar' aqui na impressao...
  QBusca:=sqltoquery(FGeral.buscaremessa(Numero,tipomov));
  if QBusca.Eof then begin
    Avisoerro('N�o encontrado');
    exit;
  end;
  if not Confirma('Confirma impress�o ?') then exit;
  if not Arq.TTabelaPreco.active then Arq.TTabelaPreco.open;
  if not Arq.TMunicipios.active then Arq.TMunicipios.open;
  Sistema.BeginProcess('');
  largura:=80;
  FTextRel.Init(65);
  FTextRel.MargemEsquerda:=3;
  FTextRel.Titulo.Clear;
  FTextRel.ClearColunas;
//  FTextRel.AddTitulo(FGeral.Centra('Remessa de Consigna��o',largura),true,False,false);
//  FTextrel.SaltaLinha(2);
//  FTextRel.AddLinha('Emiss�o : '+QBusca.fieldbyname('moes_dataemissao').Asstring+space(40)+
//                    'N�mero : '+QBusca.fieldbyname('moes_numerodoc').Asstring
//                    ,false,False,false);
  FTextRel.AddLinha('Emissao : '+QBusca.fieldbyname('moes_dataemissao').Asstring+space(2)+
                    'Vendedor: '+QBusca.fieldbyname('moes_repr_codigo').Asstring+' - '+
                    FRepresentantes.GetDescricao(QBusca.fieldbyname('moes_repr_codigo').AsInteger)
                    ,false,False,false);

//  FTextRel.AddLinha('Vendedor: '+QBusca.fieldbyname('moes_repr_codigo').Asstring+' - '+
//                    FRepresentantes.GetDescricao(QBusca.fieldbyname('moes_repr_codigo').AsInteger)
//                    ,false,False,false);

  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
//  FTextrel.SaltaLinha(1);
  if not Arq.TUnidades.Active then Arq.TUnidades.Open;
//  if not Arq.TClientes.Active then Arq.TClientes.Open;
  QClientes:=sqltoquery('select * from clientes where clie_codigo='+QBusca.Fieldbyname('Moes_tipo_codigo').Asstring);
  if not Arq.TMunicipios.Active then Arq.TMunicipios.Open;
  Arq.TUnidades.Locate('unid_codigo',QBusca.Fieldbyname('Moes_Unid_codigo').Asstring,[]);
//  Arq.TClientes.Locate('clie_codigo',QBusca.Fieldbyname('Moes_tipo_codigo').AsINteger,[]);
  Arq.TMunicipios.Locate('cida_codigo',QClientes.Fieldbyname('clie_cida_codigo_res').AsInteger,[]);
  FTextRel.AddLinha('Cliente......: '+QClientes.fieldbyname('clie_nome').AsString,false,False,false);
  FTextRel.AddLinha('Codigo.......: '+QClientes.Fieldbyname('clie_codigo').Asstring,false,False,false);
  FTextRel.AddLinha('Raz�o Social : '+strspace(QClientes.Fieldbyname('clie_razaosocial').Asstring,37)+
                    'Tel.:'+FGeral.Formatatelefone(QClientes.Fieldbyname('clie_foneres').Asstring)
                    ,false,False,false);
  FTextRel.AddLinha('Endereco.....: '+strspace(QClientes.Fieldbyname('clie_endres').Asstring,36)+space(01)+
                    'CPF :'+FGeral.Formatacpf(QClientes.Fieldbyname('clie_cnpjcpf').Asstring)
                    ,false,False,false);
  FTextRel.AddLinha('Bairro.......: '+strspace(QClientes.Fieldbyname('clie_bairrores').Asstring,40)
                    ,false,False,false);
  FTextRel.AddLinha('Cep/Cidade/UF: '+FGeral.formatacep(QClientes.Fieldbyname('clie_cepres').Asstring)+' - '+
                    strspace(Arq.TMunicipios.Fieldbyname('cida_nome').Asstring,15)+' - '+
                    strspace(Arq.TMunicipios.Fieldbyname('cida_uf').Asstring,02)
                    ,false,False,false);
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
  FTextRel.SaltaLinha(2);
  FTextRel.AddLinha(space(04)+'Codigo'+space(12)+'Quantidade'+space(3)+'Devolucao'+space(2)+'Descricao'+space(35)+'Pecas Vendidas'+
                    space(01)+'Vlr. Unitario'+space(01)+'Total R$ Desc.'
                    ,false,False,true);
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
  tqtde:=0;titem:=0;
  if Arq.TTabelaPreco.Locate('tabp_codigo',QBusca.Fieldbyname('Moes_tabp_codigo').AsInteger,[]) then begin
    descacre:=Arq.TTabelaPreco.Fieldbyname('tabp_tipo').AsString;
  end else
    descacre:='';
  valorbruto:=0;
  while not QBusca.Eof do begin
    FTextRel.AddLinha(space(04)+strspace(QBusca.Fieldbyname('Move_esto_codigo').AsString,13)+space(03)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Move_qtde').AsCurrency,'###,##0.000')+space(02)+
                    replicate('_',10)+space(02)+strspace(FEstoque.GetDescricao(QBusca.Fieldbyname('Move_esto_codigo').AsString),45)+
                    space(02)+replicate('_',10)+space(02)+FGeral.Formatavalor(QBusca.Fieldbyname('Move_venda').AsCurrency,f_cr)+space(02)+replicate('_',10)
                    ,false,False,true);
    inc(titem);
    tqtde:=tqtde+QBusca.Fieldbyname('Move_qtde').AsCurrency;
    valorbruto:=valorbruto+(QBusca.Fieldbyname('Move_qtde').AsCurrency*QBusca.Fieldbyname('Move_vendabru').AsCurrency);
    QBusca.next;
  end;
  QBusca.First;
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
//  tdescacre:=FGeral.Arredonda(QBusca.fieldbyname('moes_vlrtotal').AsCurrency*(QBusca.fieldbyname('moes_tabaliquota').AsCurrency/100) ,2);
  tdescacre:=FGeral.Arredonda(valorbruto-QBusca.fieldbyname('moes_vlrtotal').AsCurrency ,2);
  if tdescacre>0 then
    FTextRel.AddLinha(space(39)+'Total Mercadorias....: R$ '+FGeral.Formatavalor(valorbruto,'###,##0.00'),false,False,false)
  else
    FTextRel.AddLinha(space(39)+'Total Mercadorias....: R$ '+FGeral.Formatavalor(QBusca.fieldbyname('moes_vlrtotal').AsCurrency,'###,##0.00'),false,False,false);
  liquido:=valorbruto;
  if descacre='D' then begin
    FTextRel.AddLinha(space(39)+'Desconto sobre total.: R$ '+FGeral.Formatavalor(tdescacre,'###,##0.00'),false,False,false);
    liquido:=QBusca.fieldbyname('moes_vlrtotal').AsCurrency;   //-tdescacre;
  end else if descacre='A' then begin
    liquido:=QBusca.fieldbyname('moes_vlrtotal').AsCurrency;  // +tdescacre;
    FTextRel.AddLinha(space(39)+'Acr�scimo sobre total: R$ '+FGeral.Formatavalor(tdescacre,'###,##0.00'),false,False,false);
  end;
  if tdescacre>0 then
    FTextRel.AddLinha(space(39)+'Total liquido........: R$ '+FGeral.Formatavalor(liquido,'###,##0.00'),false,False,false);

//  FTextRel.AddLinha(space(39)+'Total em Quantidade..:    '+FGeral.Formatavalor(tqtde,'###,##0.000'),false,False,false);
  FTextRel.AddLinha(strzero(QBusca.fieldbyname('moes_usua_codigo').asinteger,4)+' - '+strspace(FUsuarios.getnome(QBusca.fieldbyname('moes_usua_codigo').asinteger),32)+'Total em Quantidade..:    '+FGeral.Formatavalor(tqtde,'###,##0.000'),false,False,false);
  FTextRel.AddLinha(space(39)+'Total de Itens.......:    '+FGeral.Formatavalor(titem,'####'),false,False,false);
  FTextRel.SaltaLinha(2);
  FTextRel.AddLinha('Data para acerto : '+formatdatetime('dd/mm/yy',QBusca.fieldbyname('moes_dataemissao').AsDateTime+30)+
                    space(06)+'Data segunda visita ____/____/____',false,False,false);
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
  FTextRel.AddLinha(space(54)+QBusca.fieldbyname('moes_numerodoc').Asstring,false,False,false);
  FTextRel.SaltaLinha(1);
  FTextRel.AddLinha('Declaro que recebi as mercadorias acima discriminadas : '+
                    replicate('_',21),false,False,false);
  FTextRel.AddLinha('Tipo : '+Qbusca.fieldbyname('moes_tipomov').asstring+' '+Qbusca.fieldbyname('moes_transacao').asstring,false,False,false);
  if semvideo='N' then
    FTextRel.Video
  else begin
    FGeral.Imprimesemvideo;
  end;
  Sistema.EndProcess('');
  QBusca.close;
  Freeandnil(QBusca);

end;

function TFGeral.EstaAtivo(codigo: integer; tipocad: string ; Data :TDatetime=0): boolean;
////////////////////////////////////////////////////////////////////////////////////////////
var Q,QC:TSqlquery;
    tiposmov:string;
    DAtac:TDatetime;
begin
   result:=true;
   if Data>0 then
     Datac:=data
   else
     Datac:=sistema.hoje;
   if tipocad='C' then begin
      if FGeral.getconfig1asinteger('diasinativo')>0 then begin
        tiposmov:=Global.CodRemessaConsig+';'+Global.CodRemessaProntaEntrega+';'+Global.CodVendaConsig+';'+Global.CodVendaDireta+';'+
                  Global.CodVendaMagazine+';'+Global.Codvendainterna+';'+Global.CodVendaSerie4+';'+Global.CodVendaProntaEntrega;
        Q:=sqltoquery('select max(moes_dataemissao) as uvenda from movesto where moes_tipo_codigo='+inttostr(codigo)+
           ' and moes_tipocad=''C'' and moes_status<>''C'' and '+FGeral.Getin('moes_tipomov',tiposmov,'C') );
//        if not Q.eof then begin
        if Q.fieldbyname('uvenda').asdatetime>0 then begin
          if (Sistema.hoje-Q.fieldbyname('uvenda').asdatetime)>FGeral.getconfig1asinteger('diasinativo') then
            result:=false;
        end else begin
          Qc:=sqltoquery('select clie_dtcad from clientes where clie_codigo='+inttostr(codigo));
          if not Qc.eof then begin
            if ( (Sistema.hoje-Qc.fieldbyname('clie_dtcad').asdatetime)<=FGeral.getconfig1asinteger('diasinativo') )
               and (FGeral.getconfig1asinteger('diasinativo')>0) then
               result:=true
            else
               result:=false;
          end else
            result:=false;
          Qc.close;Freeandnil(QC);
// 19.09.09 - checa se tem titulos pendentes
          if not result then begin
            Qc:=sqltoquery('select pend_valor from pendencias where pend_status=''N'' and pend_tipo_codigo='+inttostr(codigo)+
                           ' and pend_tipocad=''C'' and pend_valor>0');
            if not Qc.eof then
              result:=true;
            Qc.close;Freeandnil(QC);
          end;
        end;
        Q.close;Freeandnil(Q);
      end;
   end;
end;

function TFGeral.TituloRelProduto(Produto: string): string;
begin
  if trim(produto)<>'' then
    result:=' - Produto : '+produto+' - '+FEstoque.GetDescricao(produto)
  else
    result:='';

end;

function TFGeral.TituloRelRepresentante(Codigo: integer): string;
begin
end;

function TFGeral.TituloRelCliRepre(Codigo: integer ; tipo:string): string;
begin

  if codigo>0 then begin
    if tipo='R' then
      result:=' - Representante : '+inttostr(codigo)+' - '+FRepresentantes.GetDescricao(codigo)
    else if tipo='S' then
      result:=' - Supervisor : '+inttostr(codigo)+' - '+FRepresentantes.GetDescricao(codigo)
    else if tipo='C' then
      result:=' - Cliente : '+inttostr(codigo)+' - '+FCadcli.Getnome(codigo)
    else
      result:=' - Fornecedor : '+inttostr(codigo)+' - '+FFornece.Getnome(codigo)
  end else
    result:='';


end;

procedure TFGeral.FazSaldofin(Datalan: TDatetime; Conta: integer ; Unidade:string);

type TSaldos=record
     conta:integer;
     samf_saldomov,samf_saldocont,samf_saldoconf,asamf_saldomov,asamf_saldocont,asamf_saldoconf,
     entradas,saidas:currency;
     mesano:string;
end;


var mesano:string;
    Q:TSqlquery;
    PSaldos:^TSaldos;
    ListaSaldos:Tlist;
    p:integer;

    procedure AtualizaLista(conta:integer ; valor:currency ;tipomov,mesano:string ; Movimento,Conferencia:TDatetime );
    var p:integer;
    begin
        for p:=0 to ListaSAldos.Count-1 do begin
          PSaldos:=Listasaldos[p];
          if Psaldos.conta=conta then begin
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
        end;
    end;


begin
  mesano:=strzero(Datetoano(Datalan,true),4)+strzero(Datetomes(DAtalan),2);
  Sistema.beginprocess('Recalculando o saldo da conta '+inttostr(conta)+' desde '+Formatdatetime('dd/mm/yy',datalan));
  Q:=sqltoquery('select * from movfin where movf_status=''N'' and movf_plan_conta='+inttostr(conta)+
                     ' and movf_unid_codigo='+stringtosql(unidade)+
                     ' and movf_datamvto>='+Datetosql(DAtetoPrimeirodiames(Datalan))+
                     ' and movf_datamvto<='+Datetosql(DatetoUltimodiames(Sistema.hoje))+
                     ' order by movf_datamvto');
  ListaSaldos:=TList.Create;
  New(PSaldos);
  PSaldos.conta:=conta;
  PSaldos.asamf_saldomov:=FGeral.SaldoAnterior(conta,unidade,'samf_saldomov',datalan);
  PSaldos.asamf_saldocont:=FGeral.SaldoAnterior(conta,unidade,'samf_saldocont',datalan);
  PSaldos.asamf_saldoconf:=FGeral.SaldoAnterior(conta,unidade,'samf_saldoconf',datalan);
  PSaldos.samf_saldomov:=0;
  PSaldos.samf_saldocont:=0;
  PSaldos.samf_saldoconf:=0;
  PSaldos.entradas:=0;
  PSaldos.saidas:=0;
  PSaldos.mesano:=mesano;
  ListaSaldos.Add(PSaldos);

  while not Q.eof do begin

    mesano:=strzero(Datetoano(Q.fieldbyname('movf_datamvto').AsDateTime,true),4)+
            strzero(Datetomes(Q.fieldbyname('movf_datamvto').AsDateTime),2);
    while (not Q.eof) and ( mesano=strzero(Datetoano(Q.fieldbyname('movf_datamvto').AsDateTime,true),4)+
            strzero(Datetomes(Q.fieldbyname('movf_datamvto').AsDateTime),2) )
     do begin
      AtualizaLista(Q.fieldbyname('movf_plan_conta').asinteger,Q.fieldbyname('movf_valorger').ascurrency,Q.fieldbyname('movf_Es').asstring,mesano,
           Q.fieldbyname('movf_datacont').AsDateTime,Q.fieldbyname('movf_dataextrato').AsDateTime);
      datalan:=Q.fieldbyname('movf_datamvto').AsDateTime;
      Q.next;
    end;
    Sistema.Beginprocess('Transferindo o saldo final da conta no mes/ano '+mesano);
    for p:=0 to Listasaldos.Count-1 do begin
        PSaldos:=ListaSaldos[p];
        if ( (PSaldos.asamf_saldomov+PSaldos.samf_saldomov + PSaldos.asamf_saldocont+PSaldos.samf_saldocont  +
            PSaldos.asamf_saldoconf+PSaldos.samf_saldoconf) > 0 ) and
           ( (PSaldos.samf_saldomov<>0) and (PSaldos.samf_saldomov<>0)  ) // 08.06.05 - para nao estragar as outras contas

          then begin
          Sistema.Edit('salmovfin');
          Sistema.setfield('samf_saldomov',PSaldos.asamf_saldomov+PSaldos.samf_saldomov);
          Sistema.setfield('samf_saldocont',PSaldos.asamf_saldocont+PSaldos.samf_saldocont);
          Sistema.setfield('samf_saldoconf',PSaldos.asamf_saldoconf+PSaldos.samf_saldoconf);
          Sistema.setfield('samf_usua_codigo',Global.Usuario.Codigo);
          Sistema.Post('samf_status=''N'' and samf_mesano='+stringtosql(Mesano)+
                       ' and samf_plan_conta='+inttostr(PSaldos.conta));
          Sistema.Commit;
        end;
    end;
// zerado para proximo mes/ano
    for p:=0 to Listasaldos.Count-1 do begin
      PSaldos.asamf_saldomov:=FGeral.SaldoAnterior(conta,unidade,'samf_saldomov',datalan);
      PSaldos.asamf_saldocont:=FGeral.SaldoAnterior(conta,unidade,'samf_saldocont',datalan);
      PSaldos.asamf_saldoconf:=FGeral.SaldoAnterior(conta,unidade,'samf_saldoconf',datalan);
      PSaldos.samf_saldomov:=0;
      PSaldos.samf_saldocont:=0;
      PSaldos.samf_saldoconf:=0;
      PSaldos.entradas:=0;
      PSaldos.saidas:=0;
      PSaldos.mesano:=mesano;
    end;

  end;
  Q.Close;
  Freeandnil(Q);
  ListaSaldos.free;
  Dispose(PSaldos);
  Sistema.endprocess('');

end;

function TFGeral.RefazSaldofin(Datalan: TDatetime; Conta: integer):boolean;
var QSaldo:TSqlquery;
    mesano:string;
begin
  result:=false;
{ - 05.05.06 - retirado pois desde 15/04/06 o extrato recalcula todo o saldo desde o primeiro lan�amento
  mesano:=strzero(Datetoano(Datalan,true),4)+strzero(Datetomes(DAtalan),2);
  QSaldo:=sqltoquery('select * from salmovfin where samf_status=''N'' and samf_plan_conta='+inttostr(conta)+
          ' and samf_mesano='+stringtosql(mesano));
  if not QSaldo.eof then
    result:=true;
  QSaldo.close;
  Freeandnil(QSaldo);
}
end;



function TFGeral.Parabens(aniversario, datai, dataf: TDatetime): boolean;
/////////////////////////////////////////////////////////////////////////////
var Data:TDatetime;
begin
  result:=false;
  if Datetodia(aniversario)>0 then begin
    Data:=texttodate( strzero(Datetodia(aniversario),2) + strzero(Datetomes(aniversario),2)
          + strzero(DAtetoano(datai,true),4));
    if (data>=datai) and (data<=dataf) then
      result:=true;
  end;
end;

function TFGeral.Buscapedvenda(Numero: Integer ; Numeros:string=''; situacao:string='' ; somestre:string='N'): String;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var tipomov,sqlsituacao:string;
begin
//  tipomov:='PV';
  tipomov:=Global.CodPedVenda+';'+Global.CodPedVendaMostruario+';'+Global.CodPedVendaMostruarioConsig+';'+
           Global.CodPedVendaPE+';'+Global.CodOrdemdeServico;
  sqlsituacao:='';
  if trim(situacao)<>'' then
//    sqlsituacao:=' and mpdd_situacao='+stringtosql(situacao);
// 22.04.13
    sqlsituacao:=' and '+FGeral.GetIN('mped_situacao',situacao,'C');
  if somestre='S' then
    result:='select * from movped '+
          ' where mped_numerodoc='+inttostr(Numero)+
          ' and '+FGeral.Getin('mped_unid_codigo',Global.Usuario.UnidadesMvto,'C')+
          ' and '+FGeral.Getin('mped_status','N;X','C')+
          ' and '+FGeral.Getin('mped_tipomov',tipomov,'C')+
          ' and '+FGeral.Getin('mped_status','N;X','C')+
          sqlsituacao
  else if numeros='' then
    result:='select * from movpeddet inner join movped on (mped_transacao=mpdd_transacao)'+
          ' where mpdd_numerodoc='+inttostr(Numero)+
          ' and '+FGeral.Getin('mpdd_unid_codigo',Global.Usuario.UnidadesMvto,'C')+
          ' and '+FGeral.Getin('mpdd_status','N;X','C')+
          ' and '+FGeral.Getin('mpdd_tipomov',tipomov,'C')+
          ' and '+FGeral.Getin('mped_status','N;X','C')+   // 26.08.13
          sqlsituacao+
          ' order by mpdd_seq'
  else
    result:='select * from movpeddet inner join movped on (mped_transacao=mpdd_transacao)'+
          ' where '+FGeral.Getin('mpdd_numerodoc',Numeros,'N')+
          ' and '+FGeral.Getin('mpdd_unid_codigo',Global.Usuario.UnidadesMvto,'C')+
          sqlsituacao+
          ' and '+FGeral.Getin('mpdd_status','N;X','C')+
          ' and '+FGeral.Getin('mpdd_tipomov',tipomov,'C')+
          ' order by mpdd_seq' ;

end;

function TFGeral.GetSqlDataentre(campo: string; inicio,
  fim: TDatetime): String;
begin
  result:=campo+' Between  '+Datetosql(inicio)+' and '+Datetosql(fim);
end;

function TFGeral.GetFormaEnvio(s: string): string;
begin
  if s='R' then
    result:='Representante'
  else if s='P' then
    result:='PAC'
  else if s='C' then
    result:='Cliente retira'
  else
    result:='X';
end;

function TFGeral.ChecaCst(cst, simples: string): boolean;
var cstsimples:string;
begin
  result:=true;
  cstsimples:='101;102;103;201;202;203;300;400;500;900';
//  if (simples='S') and (cst<>'000') then begin
  if (simples='S') and ( pos(cst,cstsimples)=0 ) then begin
    Avisoerro('Produto com codigo de situa��o tribut�ria diferente de '+cstsimples+' para empresa do Simples');
    result:=false;
  end;

end;

function TFGeral.GetCodfiscalunidade(unidade,df: string): string;
//////////////////////////////////////////////////////////////////////
var p:integer;
begin
//  result:='3';
// 18.09.13 - vivan - produtos na 001 com 3
  result:='1';
  for p:=0 to ListaUnidades.count-1 do begin
     GlobalUnidades:=ListaUnidades[p];
     if GlobalUnidades.Unidade=unidade then begin
       if df='D' then
         result:=GlobalUnidades.fiscaldentro
       else
         result:=GlobalUnidades.fiscalfora;
       break;
     end;
  end;
end;

// 17.11.05 - aqui em 29.11.05 pois esta no geral no setacodigosunidade e 'fudia' ...tentava acessar o banco
//            sem q o 'sistema' estivesse conectado
// 08.12.05 - para as transferencias

procedure TFGeral.SetaTribUnidades;
///////////////////////////////////////////
begin
       if not Arq.TUnidades.active then Arq.TUnidades.open;
       ListaUnidades:=Tlist.create;
       while not Arq.Tunidades.eof do begin
         New(GlobalUnidades);
         GlobalUnidades.Unidade:=Arq.TUnidades.fieldbyname('unid_codigo').asstring;
         GlobalUnidades.fiscaldentro:=GetFiscaldentro(Arq.TUnidades.fieldbyname('unid_codigo').asstring);
         GlobalUnidades.fiscalfora:=GetFiscalfora(Arq.TUnidades.fieldbyname('unid_codigo').asstring);
         GlobalUnidades.sittdentro:=GetSittdentro(Arq.TUnidades.fieldbyname('unid_codigo').asstring);
         GlobalUnidades.sittfora:=GetSittfora(Arq.TUnidades.fieldbyname('unid_codigo').asstring);
         ListaUnidades.add(GlobalUnidades);
         Arq.TUnidades.next;
       end;
end;

function TFGeral.GetCodsittunidade(unidade, df: string): integer;
/////////////////////////////////////////////////////////////////
var p:integer;
begin
  result:=1;
  for p:=0 to ListaUnidades.count-1 do begin
     GlobalUnidades:=ListaUnidades[p];
     if GlobalUnidades.Unidade=unidade then begin
       if df='D' then
         result:=GlobalUnidades.sittdentro
       else
         result:=GlobalUnidades.sittfora;
       break;
     end;
  end;

end;

function TFGeral.GetFormaPedido(s: string): string;
begin
  if s='T' then
    result:='Telefone'
  else if s='F' then
    result:='FAX'
  else if s='E' then
    result:='Email'
  else if s='M' then
    result:='Malote'
  else if s='D' then
    result:='Direto'
  else
    result:='X';

end;

function TFGeral.Convertetoin(s, separador:string ; sepjunto:string='N'): string;
var lista:tstringlist;
    p:integer;
    x:string;
begin
  lista:=tstringlist.create;
  strtolista(lista,s,separador,true);
  x:='';
  for p:=0 to lista.count-1 do begin
     x:=x+#39+lista[p]+';'+#39;
  end;
  result:=x;
  if sepjunto='S' then begin
    for p:=0 to lista.count-1 do begin
      x:=x+#39+lista[p]+';'+';'+#39;
    end;
  end;
end;

function TFGeral.GetPercAtendimento(qtdentregue, qtdpedida,
  dias: currency): currency;
begin
  if dias>FGeral.getconfig1asinteger('DIASPEDIDO') then
    result:=(qtdentregue/qtdpedida)*100
  else begin
    if (qtdentregue/qtdpedida)*100>70 then
      result:=100
    else
      result:=(qtdentregue/qtdpedida)*100
  end;
end;

function TFGeral.ValidaDentroPeriodo(data, datai,
  dataf: TDatetime): boolean;
begin
   if (data>=datai) and (data<=dataf) then
     result:=true
   else
     result:=false;
end;

procedure TFGeral.FechaQuery(Q: TSqlquery);
begin
  if Q<>nil then begin
    Q.close;Freeandnil(Q);
  end;
end;

procedure TFGeral.FechaQuery(Q: TMemoryquery);
begin
  if Q<>nil then begin
    Q.close;Freeandnil(Q);
  end;
end;

procedure TFGeral.SetaItemsSisVenda(Ed: TSqlEd);
begin
  Ed.Items.clear;
  Ed.Items.Add(Global.SisVenConsignado+' - Consignado    ' );
  Ed.Items.Add(Global.SisVenMagazine+' - Magazine      ' );
  Ed.Items.Add(Global.SisVenLimitado+' - Limitado      ' );
  Ed.Items.Add(Global.SisVenProntaEntrega+' - Pronta Entrega' );

end;

function TFGeral.GetCalculaIcms(tipo: string): string;
begin
   if pos(tipo,Global.TiposNaoCalcIcms)>0 then
     result:='N'
   else
     result:='S';

end;

function TFGeral.GetCalculaSubstit(tipo: string): string;
begin
   if pos(tipo,Global.TiposNaoCalcSubsTrib)>0 then
     result:='N'
   else
     result:='S';

end;

function TFGeral.GetGeraFinanceiro(tipo: string): string;
begin
   if pos(tipo,Global.TiposGeraFinanceiro)>0 then
     result:='S'
   else
     result:='N';

end;

function TFGeral.GetMovimentoEstoque(tipo: string): string;
begin
   if pos(tipo,Global.TiposMovMovEstoque)>0 then
     result:='S'
   else
     result:='N';

end;

function TFGeral.TituloGrupoproduto(grupos: string): string;
begin
   if trim(grupos)<>'' then begin
     result:=' - Grupos : '+grupos
   end;
end;

function TFGeral.ChecaMostruario(Produto, TipoMov: string;Cliente,Numerodoc:integer): boolean;
var Q:TSqlquery;
    var tipos,codigosmudados:string;
begin
  result:=true;
  tipos:=Global.CodPedVendaMostruario+';'+Global.CodPedVendaMostruarioConsig;
  if tipomov=Global.CodRemessaConsig then
    tipos:=Global.CodPedVendaMostruarioConsig;  // 22.02.06
  codigosmudados:='64108';   // tania    
  if ( pos( tipomov,Global.CodPedVendaMostruario+';'+Global.CodPedVendaMostruarioConsig+';'+Global.CodRemessaConsig )>0 )
      and ( pos(produto,codigosmudados)=0 )   // 02.08.06 - tania
     then begin
    Q:=sqltoquery('select * from movpeddet where '+FGeral.Getin('mpdd_tipomov',tipos,'C')+' and mpdd_tipo_codigo='+inttostr(cliente)+
                  ' and mpdd_esto_codigo='+stringtosql(produto)+' and mpdd_status=''N''');
// numerodoc pra permitir alterar no mesmo pedido
    if (not Q.eof) and (Q.fieldbyname('mpdd_numerodoc').asinteger<>Numerodoc) then begin
      Avisoerro('Encontrado pedido de mostru�rio '+Q.fieldbyname('mpdd_tipomov').asstring+' no pedido '+Q.fieldbyname('mpdd_numerodoc').asstring+
                ' feito em '+Q.fieldbyname('mpdd_datamvto').asstring);
      result:=false;
    end;
    FGeral.Fechaquery(Q);
  end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////
function TFGeral.ValidaGridVencimentos(Grid: TSqlDtGrid ; Fpgt_codigo:string='' ; OP:string=''): boolean;
//////////////////////////////////////////////////////////////////////////////////////////////////
var p:integer;
    vencimento,data:TDatetime;
begin
  result:=true; vencimento:=0;
  for p:=1 to Grid.rowcount do begin
     if trim(Grid.cells[Grid.Getcolumn('pend_valor'),p])<>'' then begin
       data:=Texttodate(FGeral.TiraBarra(Grid.cells[Grid.Getcolumn('pend_datavcto'),p]) );
       if (trim(Fpgt_codigo)<>'') and (p=1) and (OP='I') then begin
         if(FCondpagto.GetAvPz(Fpgt_codigo)='V') or (FCondpagto.GetPrimeiroPrazo(Fpgt_codigo)=0) then begin
           if data<>Sistema.hoje then begin
             result:=false;
             Avisoerro('Vencimento a vista diferente da data atual');
             break;
           end;
         end;
       end;
       if vencimento>0 then begin
         if vencimento>=data then begin
           result:=false;
           Avisoerro('Vencimentos fora de ordem cronol�gica');
           break;
         end;
       end else
         vencimento:=data;
     end;
  end;
end;

function TFGeral.UsuarioTeste(codigo: integer): boolean;
begin
  if pos( strzero(codigo,3),Global.UsuariosdeTeste )>0 then
    result:=true
  else
    result:=false;

end;

procedure TFGeral.SetaItemsCategoria(Ed: TSqlEd);
begin
  Ed.Items.clear;
  Ed.Items.Add(Global.CatSofisticado+' - Sofisticado' );
  Ed.Items.Add(Global.CatBasico+' - B�sico' );
  Ed.Items.Add(Global.CatLuxo+' - Luxo' );

end;

function TFGeral.GetEntSaiTipoMovtoEsFora(tipomovto: string): string;
begin
 if pos(tipomovto,Global.CodRemessaProntaEntrega+';'+Global.CodVendaSerie4+';'+Global.CodRemessaConsig)>0 then
   result:='+'
 else if pos(tipomovto,Global.CodDevolucaoProntaEntrega+';'+Global.CodVendaProntaEntrega+';'+Global.CodDevolucaoSerie5+';'+
             Global.CodVendaRE+';'+Global.CodVendaREBrinde+';'+Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca+';'+Global.CodVendaConsig )>0 then
   result:='-'
 else
   result:='/'

end;

function TFGeral.EstoqueAnteriorEsFora(produto, unidade, tipo: string;
  DataInicial: TDatetime): currency;
var QBusca:TSqlquery;
    saldo:currency;
    mesano:string;
    mes,ano:integer;
begin
  mes:=Datetomes(DataInicial);
  ano:=Datetoano(Datainicial,true);
  if mes=1 then begin
    mes:=12;
    dec(ano);
  end else
    dec(mes);
  mesano:=inttostr(ano)+strzero(mes,2);
  QBusca:=sqltoquery('select * from salestoque where saes_status=''N'' and saes_mesano='+stringtosql(mesano)+
                     ' and saes_unid_codigo='+stringtosql(unidade)+' and saes_esto_codigo='+stringtosql(produto));
  saldo:=0;
  if not QBusca.Eof then begin
    if tipo=Global.CodRemessaProntaEntrega then
      saldo:=FGeral.QualQtde(Global.Usuario.Codigo,QBusca.fieldbyname('saes_qtdepronta').AsCurrency,QBusca.fieldbyname('saes_qtdepronta').AsCurrency)
    else if tipo=Global.CodVendaSerie4 then
      saldo:=FGeral.QualQtde(Global.Usuario.Codigo,QBusca.fieldbyname('saes_qtderegesp').AsCurrency,QBusca.fieldbyname('saes_qtderegesp').AsCurrency)
    else
      saldo:=FGeral.QualQtde(Global.Usuario.Codigo,QBusca.fieldbyname('saes_qtdeconsig').AsCurrency,QBusca.fieldbyname('saes_qtdeconsig').AsCurrency)
  end;
  QBusca.Close;
  Freeandnil(QBusca);
  result:=saldo;

end;

procedure TFGeral.PulalinhaRel(colunas: integer ; coluna1:integer=0 ; dados1:string='' ; coluna2:integer=0 ; dados2:string='' ;
                               coluna3:integer=0 ; dados3:string='' ; coluna4:integer=0 ; dados4:string=''; coluna5:integer=0 ; dados5:string=''
                               ; coluna6:integer=0 ; dados6:string='');
var p:integer;
begin
  for p:=1 to colunas do begin
   if (p=coluna1) and (p>0) then
     FRel.Addcel(dados1)
   else if (p=coluna2) and (p>0) then
     FRel.Addcel(dados2)
   else if (p=coluna3) and (p>0) then
     FRel.Addcel(dados3)
   else if (p=coluna4) and (p>0) then
     FRel.Addcel(dados4)
   else if (p=coluna5) and (p>0) then
     FRel.Addcel(dados5)                                                                                              
   else if (p=coluna6) and (p>0) then
     FRel.Addcel(dados6)
   else
     FRel.Addcel('');
  end;
end;


function TFGeral.GetVlrComissao(codtipo:integer ; tipocad:string ; datai,dataf:TDatetime ; tiposfora:string=''  ; tiposdentro:string=''):currency;
///////////////////////////////////////////////////////////////////////////////////////
var statusvalidos,sqlorder,sqlunidade,sqltipocod,tiposvenda,tiposdev,tiposmov,devolucoes,sqldatacont,sqltipomov:string;
    Q:TSqlquery;
    valor,avista,aprazo,devolucao,comissao,percomissao,perbonus:currency;
begin
    comissao:=0;
    statusvalidos:='N;E';
    sqlorder:=' order by moes_unid_codigo,moes_repr_codigo,moes_tipo_codigo,moes_numerodoc';
    sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',global.Usuario.UnidadesRelatorios,'C');
    if tipocad='R' then
        sqltipocod:=' and moes_repr_codigo='+inttostr(Codtipo)
    else
        sqltipocod:=' and ( (moes_tipo_codigo='+inttostr(codtipo)+') and (moes_tipocad='+stringtosql(tipocad)+') )';
    tiposmov:=Global.CodRemessaConsig+';'+Global.CodTransfEntrada+';'+
              Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodRemessaProntaEntrega+';'+Global.CodSimplesRemessa;
// 04.07.06 - kelli - calculo de comiss�o diferenciada
    if trim(tiposfora)<>'' then
      tiposmov:=tiposmov+';'+tiposfora;

    Tiposvenda:=Global.TiposRelVenda;
    Tiposdev:=Global.TiposRelDevVenda;
// 04.07.06
    if trim(tiposdentro)<>'' then begin
      Tiposvenda:=tiposdentro;
      Tiposdev:='';
    end;

    devolucoes:=Global.CodDevolucaoVenda+';'+Global.CodDevolucaoRoman+';'+Global.CodDevolucaoSerie5+';'+Global.CodDevolucaoIgualVenda;
    sqltipomov:=' and '+FGeral.GetNOTIN('moes_tipomov',tiposmov,'C')  ;
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
//      sqldatacont:=' and moes_datacont>1';
// 20.07.10
      sqldatacont:=' and moes_datacont > '+DateToSql(Global.DataMenorBanco);

    Q:=sqltoquery('select * from movesto'+
                  ' where '+FGeral.GetIN('moes_status',statusvalidos,'C')+
                  ' and moes_datamvto>='+Datetosql(datai)+' and moes_datamvto<='+Datetosql(dataf)+
                  sqlunidade+
                  sqltipocod+
                  sqltipomov+
                  sqldatacont+
                  ' and '+FGeral.getin('moes_tipomov',tiposvenda+';'+tiposdev,'C')+
                  sqlorder );


    if not Q.eof then begin
      percomissao:=FRepresentantes.GetPerComissao(Q.FieldByName('moes_repr_codigo').Asinteger);
      if trim(tiposdentro)<>'' then  // 04.07.06
        percomissao:=percomissao/2;
    end else  begin
      percomissao:=0;
      perbonus:=0;
    end;
    while not Q.eof do begin
      avista:=0;aprazo:=0;
      if pos(Q.Fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 then  begin
         aprazo:=Q.FieldByName('moes_totprod').Ascurrency;
         if (aprazo=0) and (pos(Q.Fieldbyname('moes_tipomov').asstring,Global.CodVendaProntaEntrega+';'+Global.CodVendaRE)>0) then
           aprazo:=Q.FieldByName('moes_vlrtotal').Ascurrency;
      end;
      devolucao:=0;
      if pos( Q.FieldByName('moes_tipomov').AsString,Devolucoes )>0 then begin
        devolucao:=Q.FieldByName('moes_totprod').Ascurrency;
      end;
// 14.08.06
      percomissao:=FRepresentantes.GetPerComissao(Q.FieldByName('moes_repr_codigo').Asinteger,Q.FieldByName('moes_datamvto').AsDatetime,Q.FieldByName('moes_tipomov').AsString);
      perbonus:=FRepresentantes.GetPerBonus(Q.FieldByName('moes_repr_codigo').Asinteger,Q.FieldByName('moes_datamvto').AsDatetime,Q.FieldByName('moes_tipomov').AsString);
//
      valor:=(avista+aprazo-devolucao) * (percomissao/100);
      valor:=valor + ( valor * (perbonus/100) );
      comissao:=comissao+valor;
      Q.Next;
    end;
    Fgeral.Fechaquery(Q);
    result:=comissao;
end;


procedure TFGeral.Checacontador(numero: integer; serie: string; datareferencia: TDatetime);
//////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    Data:TDatetime;
begin
//    Data:=datareferencia-30;
// 08.06.11
    Data:=datareferencia-15;
    Q:=sqltoquery('select moes_numerodoc from movesto where moes_numerodoc='+inttostr(numero)+
                  ' and moes_serie='+stringtosql(serie)+' and moes_dataemissao>='+Datetosql(data)+
                  ' and moes_unid_codigo='+stringtosql(Global.CodigoUnidade) );
    if (Q.eof) then begin
      FGeral.Gravalog(11,'Unidade '+Global.CodigoUnidade+'Nota nro '+inttostr(numero)+' S�rie '+serie+' detectado em '+FGeral.formatadata(Datareferencia),true);
    end;
    FGeral.Fechaquery(Q);
end;



procedure TFGeral.RelacaoLogs;
///////////////////////////////////////
var Q:TSqlquery;
begin
    if not Sistema.GetPeriodo('Informe o periodo ') then exit;
    Q:=sqltoquery('select * from log where log_data>='+Datetosql(Sistema.datai)+' and log_data<='+Datetosql(Sistema.dataf) );
    if Q.eof then begin
      Avisoerro('Nada encontrado para impress�o');
      FGeral.fechaquery(Q);
      exit;
    end;
    FRel.Init('RelLogs');
    FRel.AddTit('Rela��o de Logs');
//    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
    FRel.AddTit('Periodo : '+FGeral.formatadata(Sistema.Datai)+' a '+FGeral.formatadata(Sistema.Dataf));
    FRel.AddCol( 45,3,'N','' ,''              ,'Log'         ,''         ,'',false);
    FRel.AddCol(150,1,'C','' ,''              ,'Tipo de opera��o'       ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Data'  ,''         ,'',false);
    FRel.AddCol( 60,1,'C','' ,''              ,'Hora'    ,''         ,'',false);
    FRel.AddCol( 50,3,'N','' ,''              ,'Usu�rio'         ,''         ,'',False);
    FRel.AddCol(090,1,'C','' ,''              ,'Nome'                     ,''         ,'',false);
    FRel.AddCol(150,1,'C','' ,''              ,'Observa��o'    ,''         ,'',False);
    FRel.AddCol( 50,3,'N','' ,''              ,'Usu.Pediu'       ,''         ,'',False);
    FRel.AddCol(090,1,'C','' ,''              ,'Nome Pediu Canc.'         ,''         ,'',false);
    FRel.AddCol(150,1,'C','' ,''              ,'Motivo'           ,''         ,'',false);
    FRel.AddCol(090,1,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
    while not Q.eof do begin
        FRel.AddCel(Q.FieldByName('log_codigo').AsString);
        FRel.AddCel( Global.CodigosLog[Q.FieldByName('log_codigo').AsInteger] );
        FRel.AddCel(Q.FieldByName('log_data').AsString);
        FRel.AddCel(Q.FieldByName('log_hora').AsString);
        FRel.AddCel(Q.FieldByName('log_usua_codigo').AsString);
        FRel.AddCel(Fusuarios.GetNome(Q.FieldByName('log_usua_codigo').Asinteger));
        FRel.AddCel(Q.FieldByName('log_complemento').AsString);
        FRel.AddCel(Q.FieldByName('log_usua_canc').AsString);
        FRel.AddCel(Fusuarios.GetNome(Q.FieldByName('log_usua_canc').Asinteger));
        FRel.AddCel(Q.FieldByName('log_motivo').AsString);
        FRel.AddCel(Q.FieldByName('log_transacaocanc').AsString);
        Q.Next;
    end;
    FRel.Video;
    FGeral.Fechaquery(Q);
end;

procedure TFGeral.SetaItems(Ed: TSqled; nomerel: string);
var cond,ordem:string;
    Formatos:TSqlquery;
begin
    Ed.Items.clear;
    Cond := 'LOJA IN (''999'','''+Sistema.CodigoEmpresa+''')'+
            ' AND USUARIO IN (''9999'','''+Sistema.CodigoUsuario+''')'+
            ' AND UPPER(NOMEREL) = '''+UpperCase(NomeRel)+'''';
    Ordem := 'NOMEFORMATO';
    Formatos:=sqltoquery('select * from formatosrel where '+cond+' order by '+ordem);
    while not Formatos.Eof do begin
       ED.Items.Add(Formatos.FieldByName('NOMEFORMATO').AsString);
       Formatos.Next;
    end;

end;

function TFGeral.GetValorJuros(capital: currency; vencimento, baixa: TDatetime  ; RecPag:string): currency;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var diasatraso:integer;
    valor,multa:currency;
begin
   valor:=0;multa:=0;
   if RecPag='R' then begin  // por enquanto somente pendencias a receber
//     diasatraso:=trunc(Sistema.hoje-vencimento);
     diasatraso:=trunc(baixa-vencimento);
//     if Global.CodigoUnidade=Global.unidadematriz then   // carencia matriz
//       diasatraso:=diasatraso-10;
     if (diasatraso>0) and (Global.Topicos[1262]) then begin
        valor:=( capital*(( FGeral.Getconfig1asfloat('JUROSMORA')/30 )/100) )*diasatraso;
     end;
     if (diasatraso>0) and (Global.Topicos[1262]) then begin
        multa:=( capital*(( FGeral.Getconfig1asfloat('Multaboleto')/30 )/100) );
     end;
   end;
   result:=valor+multa;
end;

procedure TFGeral.SetaCorEdits(tipoedit: boolean; Form: TForm);
var p:integer;
begin
   for p:=0 to Form.ComponentCount-1 do begin
     if Form.Components[p] is TSqlEd then begin
        if TSqled( Form.Components[p] ).Enabled=tipoedit then
          TSqled( Form.Components[p] ).Color:=clWindow;
//          TSqled( Form.Components[p] ).Color:=clBlack;
//          TSqled( Form.Components[p] ).Color:=clWhite;
//          TSqled( Form.Components[p] ).ColorTextNotEnabled:=clBlack;
//          TSqled( Form.Components[p] ).Color:=clBlue;
//          TSqled( Form.Components[p] ).Color:=clBtnHighlight;
     end;
   end;
end;

////////////; - 17.07.06
function TFGeral.ProcessaComandos(TExto:String):String;
var i:integer;
        StrComando:Boolean;
        Macro:String;
begin
      StrComando:=False;Macro:='';Result:='';
      for i:=1 to Length(Texto) do begin
          if Texto[i]=#13 then Result:=Result+'</p><p>';
          if not (Texto[i] in [#13,#26,#10]) then begin
             if Texto[i]='[' then StrComando:=True;
             if StrComando then Macro:=Macro+Texto[i];
             if Texto[i]=']' then begin
                StrComando:=False;
//                Result:=Result+Sistema.Execute(Macro,FProcess);
                Macro:='';
             end else begin
                if not StrComando then Result:=Result+Texto[i];
             end;
          end;
      end;
end;

function TFGeral.GeraHTML(Texto2:String):String;
begin
//      Result:='<html> '+
{
      Result:='<text> '+
              '<body> '+
              '  <tr> '+
              Texto2+
              '  </tr> '+
              '  <p>  ';
}
      Result:='<html '+
              '<body> '+
//              '  <h4> '+
//              ' <small> '+
              ' <font size="3">'+
              Texto2 +
              '  <br> ';
//              '  </h1> ';

//              '<p>&nbsp;</p>';
//              '<p align="left">'+Texto2+'</p> ';
{
              '<p align="left"><b><u>Rela��o Do(s) T�tulo(s) Quitado(s)</u></b></p> '+
              '<table border="1" width="95%" height="100"> '+
              '  <tr> '+
              '    <td width="10%" bgcolor="#C0C0C0" height="19">Pgto/Receb</td> '+
              '    <td width="20%" bgcolor="#C0C0C0" height="19">Nosso N�mero</td> '+
              '    <td width="10%" bgcolor="#C0C0C0" height="19">Dcto Origem</td> '+
              '    <td width="10%" bgcolor="#C0C0C0" height="19">Emiss�o</td> '+
              '    <td width="10%" bgcolor="#C0C0C0" height="19">Vcto</td> '+
              '    <td width="20%" bgcolor="#C0C0C0" height="19">Valor Nominal</td> '+
              '    <td width="20%" bgcolor="#C0C0C0" height="19">Valor L�quido</td> '+
              '  </tr> ';
}
//      while not QPendFin.Eof do begin

//        Result:=Result+'</tr> ';

{
        if QPendFin.FieldByName('pfin_pr').AsString='P' then begin
           Result:=Result+'    <td width="10%" bgcolor="#FFFF00" align="left" height="19">Pgto</td> ';
           Total1:=Total1+QPendFin.FieldbyName('pfin_valor').AsFloat;
           Total2:=Total2+FGeral.GetValorLiquidoPendFin(QPendFin);
        end else begin
           Result:=Result+'    <td width="10%" bgcolor="#FFFF00" align="left" height="19">Rec(-)</td> ';
           Total1:=Total1-QPendFin.FieldbyName('pfin_valor').AsFloat;
           Total2:=Total2-FGeral.GetValorLiquidoPendFin(QPendFin);
        end;
}
//
//        Result:=Result+'    <td width="20%" bgcolor="#FFFF00" align="left" height="19">'+Trim('coluna1')+'</td> ';
//        Result:=Result+'    <td width="10%" bgcolor="#FFFF00" align="right" height="19">'+Trim('coluna2')+'</td> ';
//        Result:=Result+'    <td width="10%" bgcolor="#FFFF00" align="center" height="19">'+DateToStr_(Q.FieldbyName('pfin_dataemissao').AsDatetime)+'</td> ';
//        Result:=Result+'    <td width="10%" bgcolor="#FFFF00" align="center" height="19">'+DateToStr_(Q.FieldbyName('pfin_datavcto').AsDateTime)+'</td> ';
//        Result:=Result+'    <td width="20%" bgcolor="#FFFF00" align="right" height="19">'+Trim(TransformAbs(Q.FieldbyName('pfin_valor').AsFloat,f_crp))+'</td> ';
//        Result:=Result+'    <td width="20%" bgcolor="#FFFF00" align="right" height="19">'+Trim(TransformAbs(FGeral.GetValorLiquidoPendFin(QPendFin),f_crp))+'</td> ';
//        Result:=Result+'</tr> ';
//        QPendFin.Next;
//      end;
//      Result:=Result+'<tr> ';
//      Result:=Result+'</table> '+'</body> '+'</html>';
//      Result:=Result+'</body> '+'</text>';

end;


////////////////////////////////////////////////////

//function TFGeral.EnviaEMail(email,assunto,texto2,arquivo:string):Boolean;
function TFGeral.EnviaEMail(email,assunto,arquivo:string;corpo:TStrings):Boolean;
//////////////////////////////////////////////////////////////////////////////////
const lf:string='%0D%0A';
var i,x:integer;
//    AuthSSL: TIdSSLIOHandlerSocket;
    s,mens:string;

    function Tirax(s:string):string;
    /////////////////////////////////////
    var x:integer;
    const letrasenumeros:string='01234567890.-,/_abcdefghijklmnopqrstuvxyzkwyABCDEFGHIJKLMNOPQRSTUVXYZW ';
    begin
      result:='';
      for x:=1 to length(s) do begin
        if pos( copy(s,x,1),letrasenumeros ) >0 then
          result:=result+copy(s,x,1);
      end;
    end;


begin
////////////////
      {
      SMTP.Host:=Sistema.EmailSMTP;
      SMTP.Username:=Sistema.EmailUser  ; //'andre';
      SMTP.Password:=Sistema.EmailPassword;  //'senha';
      if FGeral.GetConfig1AsInteger('PORTASMTP')=0 then
        SMTP.Port:= 25
      else
        SMTP.Port:= FGeral.GetConfig1AsInteger('PORTASMTP');
// 01.11.11
      if FGeral.EmailStmpcomSSL( FGeral.getconfig1asstring( 'SMTP' ) ) then begin
        AuthSSL := TIdSSLIOHandlerSocket.Create(nil);
    //    AuthSSL.SSLOptions.Method := sslvSSLv2;
    // 05.10.10 - esta meeeeeeeerrrrrda mais as libs de 2004 da pasta 096m
        AuthSSL.SSLOptions.Method := sslvTLSv1;
        AuthSSL.SSLOptions.Mode := sslmClient;
        SMTP.IOHandler := AuthSSL;
      end;
      }
////
/////////////////
      with Mensagem do begin
        Encoding:=meMIME;
        ContentType:='text/html';
        Subject  := Assunto;
        From.Text:=Sistema.EmailFrom; // 'reges@tokefinal.com.br';
        Recipients.EMailAddresses:=email;  // 'andre@tokefinal.com.br';  // aqui pegar o destino ; ver quando pedir
//        Body.Text :=Texto2;
        body.clear;

        Body.Add('<PRE>');
        Mens:='';
        for i:=0 to Corpo.Count-1 do begin
//          Body.Text := Body.Text + GeraHtml(Tirax(Corpo.strings[i]));
//          Body.Text := Body.Text + GeraHtml(Corpo.strings[i]);

//          Body.Add( GeraHtml(Corpo.strings[i]) );

          x:=pos( '&',Corpo.strings[i] );
          if x>0 then
            Mens:=mens+strspace(copy(Corpo.strings[i],1,x-1)+'e'+copy(Corpo.strings[i],x+1,100),80)+lf
          else
            Mens:=mens+strspace(Corpo.strings[i],80)+lf;

          Body.Add( Corpo.strings[i] );

//          Body.Add( GeraHtml(Tirax(Corpo.strings[i]) ) ) ;

//          Body.Text := GeraHtml(Corpo.Text );
        end;
        Body.Add('</PRE>');
// 01.11.11
//////////////
//
          s := 'mailto:'+email+
              '?Subject=' + Assunto +
              '&Body='+Mens;
          ShellExecute(Handle, 'open', PChar(s), nil, nil, SW_HIDE);
          result:=true;
//}
///////////
//        Body.AddStrings(Corpo);
/////////////////
{
        try
          SMTP.Connect;
          SMTP.Send(Mensagem);
//          Inc(n);
          SMTP.Disconnect;
          Result:=True;
        except
          AvisoErro('Erro no envio do e-mail');
          SMTP.Disconnect;
          raise;
          Result:=False;
        end;
        }
///////////////
      end;
end;
////////////////////////////////////////////////////




function TFGeral.ValidaGrade(cor,tamanho,copa: integer; Produto:string ; checar:string=''): boolean;
//////////////////////////
var Q:TSqlquery;
    sqlcor,sqltamanho,sqlcopa:string;
begin
  result:=true;

//  exit;   // 18.06.06 - esperar ter a grade
// 25.04.08 - ter� a grade...

  if (cor=0) and (tamanho=0) and (copa=0) then exit;
// 23.06.08
  if not Global.Topicos[1321] then exit;  // se quer validacao da grade
  sqlcor:='';sqltamanho:='';sqlcopa:='';
//  if pos('cor',checar)>0 then begin
    if (cor>0) then
      sqlcor:=' and esgr_core_codigo='+inttostr(cor)
    else
      sqlcor:=' and ( esgr_core_codigo=0 or  esgr_core_codigo is null )';
//  end;
//  if pos('tamanho',checar)>0 then begin
    if tamanho>0 then
      sqltamanho:=' and esgr_tama_codigo='+inttostr(tamanho)
    else
      sqltamanho:=' and ( esgr_tama_codigo=0 or  esgr_tama_codigo is null )';
//  end;
//  if pos('copa',checar)>0 then begin
    if copa>0 then
      sqlcopa:=' and ( esgr_copa_codigo='+inttostr(copa)+' or  esgr_copa_codigo is null )'
    else
      sqlcopa:=' and ( esgr_copa_codigo=0 or  esgr_copa_codigo is null )';
//  end;
  Q:=sqltoquery('select * from estgrades where esgr_status=''N'' and esgr_esto_codigo='+stringtosql(produto)+
                sqlcor+sqltamanho+sqlcopa );
  if Q.Eof then begin
    Avisoerro('Grade n�o encontrada com esta cor/tamanho');
    result:=false;
  end;
  FGeral.Fechaquery(Q);

end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.MovimentaQtdeEstoqueGrade(Codigo, UNidade, EntSai,
          TipoMovimento: string; xcodcor,xcodtamanho,xcodcopa:integer ;
           Qtde: currency; Q: TSqlquery; Qtdeprev: currency=0 ; xpecas:currency=0 );
var xsqlcor,xsqltamanho,xsqlcopa:string;
begin


// 16.10.09
////////////////////////////////////////
    if pos( TipoMovimento,Global.TipoEstoqueEmProcesso ) > 0 then begin
      xsqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
      xsqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
      xsqlcopa:=' and ( esgr_copa_codigo=0 or esgr_copa_codigo is null )';
      if (xcodcor>0) and (xcodtamanho>0) and (xcodcopa>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
          xsqlcopa:=' and esgr_copa_codigo='+inttostr(xcodcopa);
      end else if (xcodcor>0) and (xcodtamanho>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
      end else if (xcodcor>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
      end else if (xcodtamanho>0) then begin
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
      end;
      Sistema.Edit('EstGrades');
      if EntSai='E' then begin
// 16.10.09 - movimenta estoque em processo  -
          Sistema.Setfield('esgr_qtdeprocesso',Q.fieldbyname('esgr_qtdeprocesso').ascurrency+QTde);
      end else begin
          Sistema.Setfield('esgr_qtdeprocesso',Q.fieldbyname('esgr_qtdeprocesso').ascurrency-QTde);
      end;
      Sistema.Post('esgr_esto_codigo='+stringtosql(codigo)+' and esgr_unid_codigo='+stringtosql(UNidade)+
                 ' and esgr_status=''N'''+
                   xsqlcor+xsqltamanho+xsqlcopa );
      exit;
    end;
////////////////////////////////////////

    if pos( TipoMovimento,Global.TiposMovMovEstoque ) = 0 then exit;
    if (xcodcor=0) and (xcodtamanho=0) then exit;

      xsqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
      xsqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
      xsqlcopa:=' and ( esgr_copa_codigo=0 or esgr_copa_codigo is null )';
      if (xcodcor>0) and (xcodtamanho>0) and (xcodcopa>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
          xsqlcopa:=' and esgr_copa_codigo='+inttostr(xcodcopa);
      end else if (xcodcor>0) and (xcodtamanho>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
      end else if (xcodcor>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
      end else if (xcodtamanho>0) then begin
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
      end;

//    sistema.beginprocess('Movimentando estoque da grade');
    if Qtdeprev=0 then QTdeprev:=Qtde;
    Sistema.Edit('EstGrades');
    if EntSai='E' then begin
      if (TipoMovimento=Global.CodAcertoEsEnt) or (TipoMovimento=Global.CodAcertoEsSAi)
//         (TipoMovimento=Global.CodContagemBalancoE) or (TipoMovimento=Global.CodContagemBalancoS)
        then begin
        if Q.fieldbyname('esgr_qtdeprev').ascurrency<0 then
          Sistema.Setfield('esgr_qtdeprev',QTdeprev)
        else
          Sistema.Setfield('esgr_qtdeprev',Q.fieldbyname('esgr_qtdeprev').ascurrency+QTdeprev);
        if Q.fieldbyname('esgr_qtde').ascurrency<0 then
          Sistema.Setfield('esgr_qtde',QTde)
        else
          Sistema.Setfield('esgr_qtde',Q.fieldbyname('esgr_qtde').ascurrency+QTde);
// 24.04.08
        Sistema.Setfield('esgr_pecas',Q.fieldbyname('esgr_pecas').ascurrency+xPecas);
      end else begin
        Sistema.Setfield('esgr_qtde',Q.fieldbyname('esgr_qtde').ascurrency+QTde);
        Sistema.Setfield('esgr_qtdeprev',Q.fieldbyname('esgr_qtdeprev').ascurrency+QTdeprev);
// 24.04.08
        Sistema.Setfield('esgr_pecas',Q.fieldbyname('esgr_pecas').ascurrency+xPecas);
// 16.10.09 - movimenta estoque em processo
      if pos( TipoMovimento,Global.CodSaidaAlmox ) > 0 then
        Sistema.Setfield('esgr_qtdeprocesso',Q.fieldbyname('esgr_qtdeprocesso').ascurrency-QTde)
      else if pos( TipoMovimento,Global.CodSaidaprocesso ) > 0 then
        Sistema.Setfield('esgr_qtdeprocesso',Q.fieldbyname('esgr_qtdeprocesso').ascurrency+QTde);

      end;
    end else begin  // SAIDA
      Sistema.Setfield('esgr_qtdeprev',Q.fieldbyname('esgr_qtdeprev').ascurrency-QTdeprev);
      Sistema.Setfield('esgr_qtde',Q.fieldbyname('esgr_qtde').ascurrency-QTde);
// 24.04.08
      Sistema.Setfield('esgr_pecas',Q.fieldbyname('esgr_pecas').ascurrency-xPecas);
// 16.10.09 - movimenta estoque em processo na grade
      if pos( TipoMovimento,Global.CodSaidaAlmox ) > 0 then
        Sistema.Setfield('esgr_qtdeprocesso',Q.fieldbyname('esgr_qtdeprocesso').ascurrency+QTde)
      else if pos( TipoMovimento,Global.CodSaidaprocesso ) > 0 then
        Sistema.Setfield('esgr_qtdeprocesso',Q.fieldbyname('esgr_qtdeprocesso').ascurrency-QTde);

    end;
    Sistema.Post('esgr_esto_codigo='+stringtosql(codigo)+' and esgr_unid_codigo='+stringtosql(UNidade)+
                 ' and esgr_status=''N'''+
                 xsqlcor+xsqltamanho+xsqlcopa );
//    Sistema.endprocess('');
end;

procedure TFGeral.Apuravenda(Lista:TList; produto: string; codcor,
  codtamanho, codcopa: currency; qtde: currency; tipomov: string);

type TLista=record
    produto:string;
    codcor,codtamanho,codcopa:currency;
    qtdeenviada,qtdedevolvida:currency;
end;

var p:integer;
    achou:boolean;
    Ponteiro:^TLista;
begin
  achou:=false;
  for p:=0 to Lista.count-1 do begin
    Ponteiro:=Lista[p];
    if (Ponteiro.produto=produto) and (Ponteiro.codcor=codcor) and (Ponteiro.codtamanho=codtamanho) and (Ponteiro.codcopa=codcopa) then begin
      achou:=true;
      break;
    end;
  end;
  if not Achou then begin
    New(Ponteiro);
    Ponteiro.produto:=produto;
    Ponteiro.codcor:=codcor;
    Ponteiro.codtamanho:=codtamanho;
    Ponteiro.codcopa:=codcopa;
    Ponteiro.qtdeenviada:=0;
    Ponteiro.qtdedevolvida:=0;
    if pos(tipomov,Global.CodRemessaConsig+';'+Global.CodRemessaProntaEntrega+';'+Global.CodVendaSerie4+';'+Global.CodVendaTransf)>0 then
      Ponteiro.qtdeenviada:=qtde
    else
      Ponteiro.qtdedevolvida:=qtde;
    Lista.add(Ponteiro);
  end else begin
    if pos(tipomov,Global.CodRemessaConsig+';'+Global.CodRemessaProntaEntrega+';'+Global.CodVendaSerie4+';'+Global.CodVendaTransf)>0 then
      Ponteiro.qtdeenviada:=Ponteiro.qtdeenviada+qtde
    else
      Ponteiro.qtdedevolvida:=Ponteiro.qtdedevolvida+qtde;
  end;
end;

function TFGeral.UsuarioTesteGrade(codigo: integer): boolean;
begin
  if pos( strzero(codigo,3),Global.UsuariosdeTesteGrade )>0 then
    result:=true
  else
    result:=false;

end;


function TFGeral.GetAtrasomedio(codigo: integer; tipocad: string;
  diaschecagem: integer; DataFinal: TDatetime; Unidades:string): integer;
///////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    Datai,Dataf:TDatetime;
    atraso,quantos:integer;
    sqltipocodigo:string;
begin
  Datai:=DataFinal-1-diaschecagem;
  Dataf:=Datafinal-1;
  if tipocad='C' then
    sqltipocodigo:=' and pend_tipo_codigo='+inttostr(codigo)
  else
    sqltipocodigo:=' and repr_tipo_codigo='+inttostr(codigo);
  Q:=sqltoquery('select pend_databaixa,pend_datavcto from pendencias where '+fGeral.Getin('pend_status','B','C')+
                ' and pend_databaixa>='+Datetosql(Datai)+' and pend_databaixa<='+Datetosql(Dataf)+
                ' and pend_rp='+stringtosql('R')+
                sqltipocodigo+
                ' and '+FGeral.Getin('pend_unid_codigo',Unidades,'C') );
  result:=0;
  atraso:=0;
  quantos:=0;
  while not Q.eof do begin
    if Q.fieldbyname('pend_databaixa').asdatetime>Q.fieldbyname('pend_datavcto').asdatetime then
      atraso:=atraso+trunc(Q.fieldbyname('pend_databaixa').asdatetime-Q.fieldbyname('pend_datavcto').asdatetime);
    inc(quantos);
    Q.Next;
  end;
  if atraso>0 then
    result:=trunc(atraso/quantos);
  FGeral.Fechaquery(Q);
end;


function TFGeral.GetMovimentoEs(tipo: string): string;
begin
   if pos(tipo,Global.TiposEntrada)>0 then
     result:='E'
   else
     result:='S';


end;

function TFGeral.Validalimitecredito(limite: currency): boolean;
begin
   result:=true;
   if FGeral.GetConfig1AsFloat('Limitelimcredito')>0 then begin
     if limite>FGeral.GetConfig1AsFloat('Limitelimcredito') then begin
       result:=Fusuarios.GetSenhaAutorizacao(0039)>0;
     end;
   end;
end;

function TFGeral.GetContaDespesa(transacao: string): integer;
var Qt:Tsqlquery;
    Campo:TDicionario;
begin
    Qt:=sqltoquery('select pend_plan_conta from pendencias where pend_transacao='+stringtosql(transacao));
    if not Qt.eof then
      result:=Qt.fieldbyname('pend_plan_conta').AsInteger
    else
      result:=0;
    FGeral.FechaQuery(qt);
// 17.12.09 - Abra
    if result=0 then begin
       campo:=Sistema.GetDicionario('movesto','moes_plan_codigo');
       if campo.Tipo<>''  then begin
         Qt:=sqltoquery('select moes_plan_codigo from movesto where moes_transacao='+stringtosql(transacao));
         if not Qt.eof then
           result:=Qt.fieldbyname('moes_plan_codigo').AsInteger
         else
           result:=0;
         FGeral.FechaQuery(qt);
       end;
    end;
end;

{
/////////////////////////
procedure TFGeral.EnviaEMail(destino:string);
const lf:string='%0D%0A';
var s,mensagem: string;
begin
    Sistema.Beginprocess('Enviando email');
    mensagem:='Funcion�rio : '+inttostr(codfun)+' - '+nome+lf;
   s := 'mailto:'+destino+
            '?Subject=Recursos Humanos' +
            '&Body='+mensagem;
//       ShellExecute(Handle, 'open', PChar(s), nil, nil, SW_SHOW);
       ShellExecute(Handle, 'open', PChar(s), nil, nil, SW_HIDE);
    Sistema.Endprocess('');

  end;

end;
/////////////////////////
}

//////////////////////////////////////////
procedure TFGeral.InicializaSistema;
//////////////////////////////////////////
var tipose,tiposs:string;
begin
  Global.CodContaVendaaVista:=FGeral.GetConfig1AsInteger('Contarecvista');
// 13.03.09 - para usar no tipoexp para CONTABILIDADE
  tipose:=Global.CodCompra+';'+Global.CodCompraSemMovEstoque+';'+global.CodConhecimento+';'+Global.CodCompra100+';'+
         ';'+Global.CodTransfEntrada+';'+                 //  10.05.05
         Global.CodTransImobE+';'+Global.CodDevolucaoRoman+';'+global.CodCompraImobilizado+';'+global.CodCompraMatConsumo+';'+
         Global.CodDevolucaoSerie5+';'+Global.CodCompraX+';'+Global.CodDevolucaoConsigMerc+';'+
         Global.CodRetornoConsigMercanil+';'+Global.CodCompraSemfinan+';'+Global.CodDevolucaoInd+';'+
         Global.CodDevolucaoProntaEntrega+';'+Global.CodRetornocomServicos+';'+Global.CodRetornoInd+';'+
         Global.CodCompraProdutor+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoIgualVenda+';'+
         Global.CodEntradaImobilizado+';'+Global.CodCompraIndustria+';'+Global.CodCompraFutura+';'+
         Global.CodCompraRemessaFutura+';'+Global.CodRetornoMercDepo+';'+Global.CodEstornoNFeSai+';'+
         Global.CodFaturaAgua+';'+Global.CodEntradaProdutor;

  tiposs:=global.CodVendaDireta+';'+Global.CodVendaConsig+';'+Global.CodVendaSemMovEstoque+';'+
         Global.CodVendaProntaEntrega+';'+Global.CodVendaMagazine+';'+
         Global.CodVendaConsigMercantil+';'+Global.CodConsigMercantil+';'+
         Global.Codvendainterna+';'+Global.CodVendaSerie4+';'+global.CodVendaRE+';'+global.CodVendaREFinal+';'+
         global.CodVendaRomaneio+';'+global.CodVendaAmbulante+';'+Global.CodTransfEntrada+';'+
         Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodVendaPecaProblema+';'+Global.CodVendaMostruarioII+';'+
         Global.CodRemessaInd+';'+Global.CodContratoEntrega+';'+Global.CodContrato+';'+Global.CodVendaSemfinan+';'+
         Global.CodSaidaGarantia+';'+Global.CodVendaFornecedor+';'+Global.CodContratoNota+';'+
         Global.CodDevolucaoCompraProdutor+';'+Global.CodConhecimentoSaida;


//////////////////////////////////////////////////////////////////
  Global.TiposExpContabNotas:=tipose+';'+tiposs+';'+FGeral.GetConfig1AsString('TIPOSCONTAB');
// 28.07.09
  tipose:=Global.CodCompra+';'+Global.CodCompraSemMovEstoque+';'+
         Global.CodCompra100+';'+Global.CodRetornoMostruario+';'+
         Global.CodTransfEntrada+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoIgualVenda+';'+
         Global.CodTransfEnt+';'+Global.CodCompraX+';'+Global.CodCompraImobilizado+';'+
         Global.CodCompraMatConsumo+';'+Global.CodCompraSemfinan+';'+Global.CodTransfEntRetTempo+';'+
         Global.CodDevolucaoInd+';'+Global.CodRetornocomServicos+';'+Global.CodDevolucaoSerie5+';'+Global.CodRetornoInd+';'+
         Global.CodCompraProdutor+';'+global.CodCompraSemfinan+';'+
         Global.CodRetornoRemessaConserto+';'+Global.CodEntradaImobilizado+';'+Global.CodCompraIndustria+';'+
         Global.CodCompraFutura+';'+Global.CodCompraRemessaFutura+';'+Global.CodEntradaInd+';'+
         Global.CodEntradaBrinde+';'+Global.CodConhecimento+';'+Global.CodDevolucaoInd+';'+Global.CodRetornocomServicos+';'+
         Global.CodCompraProdutorReclassifica+';'+Global.CodRetornoMercDepo+';'+Global.CodEstornoNFeSai+';'+
         Global.CodFaturaAgua+';'+Global.CodEntradaProdutor;

  tiposs:=global.CodVendaDireta+';'+Global.CodVendaConsig+';'+Global.CodVendaSemMovEstoque+';'+
         Global.CodVendaProntaEntrega+';'+Global.CodVendaMagazine+';'+
         Global.CodVendaBrinde+';'+Global.CodVendaConsigMercantil+';'+
         Global.Codvendainterna+';'+Global.CodVendaSerie4+';'+
         global.CodVendaRomaneio+';'+global.CodVendaAmbulante+';'+Global.CodVendaMostruario+';'+
         Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodTransfSai+';'+
         Global.CodDevolucaoRoman+';'+Global.CodDevolucaoCompra+';'+
         Global.CodConsigMercantil+';'+Global.CodDevolucaoConsigMerc+';'+Global.CodVendaMostruarioII+';'+
         Global.CodDevolucaoCompraSemEstoque+';'+Global.CodRemessaInd+';'+Global.CodVendaBrindeConsig+';'+
         Global.CodRemessaInd+';'+Global.CodVendaBrindeConsig+';'+Global.CodTransMatConsumoS+';'+Global.CodRemessaConserto+';'+
         Global.CodContratoEntrega+';'+Global.CodVendaSemfinan+';'+Global.CodVendaFornecedor+';'+
         Global.CodRemessaIndPropria+';'+Global.CodVendaImobilizado+';'+Global.CodContratoNota+';'+
         Global.CodSimplesRemessa+';'+Global.CodContratoDoacao+';'+Global.CodRemessaDemo+';'+Global.CodPrestacaoServicos+';'+
         Global.CodDevolucaoCompraProdutor+';'+Global.CodRemessaDemoClientes+';'+Global.CodRemessaContraOrdem+';'+
         Global.CodSaidaGarantia+';'+Global.CodNotaRemessaaOrdem+';'+Global.CodVendaaOrdem+';'+
         Global.CodConhecimentoSaida+';'+Global.CodDevolucaoTributada+';'+Global.CodNfeComplementoQtde;

  Global.TiposExpFiscalNotas:=tipose+';'+tiposs;

//  if FGeral.GetConfig1AsInteger('portasmtp')>0 then
//    FGeral.Smtp.Port:=FGeral.GetConfig1AsInteger('portasmtp');
// 05.10.10 - retirado por nao 'ler nada aqui'
end;

procedure TFGeral.MovimentoEstoqueComposicao(unidade, produto, entsai,xtransacao,yTipoMovimento,xtipocad: string; qtde: extended; pecas: currency;xnumero,tipo_codigo:integer;xmovimento,xEntrada:TDatetime);
var QC,QCustoMat,QEst:TSqlquery;

   procedure IncluiMovimento;
   begin
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',QC.fieldbyname('cust_esto_codigomat').asstring);
      Sistema.SetField('move_tama_codigo',0);
      Sistema.SetField('move_core_codigo',0);
      Sistema.SetField('move_copa_codigo',0);
      Sistema.SetField('move_transacao',xtransacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',xnumero+11);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',yTipoMovimento);
      Sistema.SetField('move_unid_codigo',Unidade);
      Sistema.SetField('move_tipo_codigo',tipo_codigo);
      Sistema.SetField('move_tipocad',xtipocad);

      Sistema.SetField('move_qtde',qtde*Qc.fieldbyname('cust_qtde').ascurrency);
      Sistema.SetField('move_datacont',xMovimento);
//              end else begin
//                Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('qtdeprev'),linha])*Qcusto.fieldbyname('cust_qtde').ascurrency);
//                Sistema.SetField('move_venda',??);
//              end;
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',xEntrada);
      Sistema.SetField('move_qtderetorno',0);
      QCustoMat:=sqltoquery( FEstoque.Getsqlcustos(QC.fieldbyname('cust_esto_codigomat').asstring,Global.CodigoUnidade,
                  QC.fieldbyname('cust_tama_codigomat').asinteger,QC.fieldbyname('cust_core_codigomat').asinteger) );
      if not QCustoMat.eof then begin
        Sistema.SetField('move_custo',QCustomat.fieldbyname('custo').ascurrency);
        Sistema.SetField('move_custoger',QCustomat.fieldbyname('custoger').ascurrency);
        Sistema.SetField('move_customedio',QCustomat.fieldbyname('customedio').ascurrency);
        Sistema.SetField('move_customeger',QCustomat.fieldbyname('customeger').ascurrency);
        Sistema.SetField('move_venda',QCustomat.fieldbyname('customeger').ascurrency);
      end;
      FGeral.Fechaquery(QCustomat);
      Sistema.SetField('move_cst','');
      Sistema.SetField('move_aliicms',0);
//      QEst:=sqltoquery('select esto_grup_codigo,esto_sugr_codigo,esto_fami_codigo from estoque where esto_codigo='+stringtosql(QC.fieldbyname('cust_esto_codigomat').asstring));
      QEst:=sqltoquery('select * from estoqueqtde inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                       ' where esqt_esto_codigo='+stringtosql(QC.fieldbyname('cust_esto_codigomat').asstring)+
                       ' and esqt_unid_codigo='+stringtosql(unidade) );
      if not QEst.eof then begin
        Sistema.SetField('move_grup_codigo',QEst.FieldByName('esto_grup_codigo').AsInteger);
        Sistema.SetField('move_sugr_codigo',QEst.fieldbyname('esto_sugr_codigo').AsInteger);
        Sistema.SetField('move_fami_codigo',QEst.fieldbyname('esto_fami_codigo').AsInteger);
      end;

      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_aliipi',0);
//      Sistema.SetField('move_tipo_codigoind',Fornecedor.AsInteger);   //  27.07.06
      Sistema.Post;

      FGeral.MovimentaQtdeEstoque(produto,unidade,'E',yTipoMovimento,qtde*Qc.fieldbyname('cust_qtde').ascurrency,
                                    QEst,qtde*Qc.fieldbyname('cust_qtde').ascurrency,pecas );
      FGeral.Fechaquery(QEst);
   end;


begin
  QC:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
                  ' inner join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N'' and esqt_unid_codigo='+stringtosql(Unidade)+' )'+
                  ' where cust_status=''N'' and cust_esto_codigo='+stringtosql(produto)+
//                   sqlcor+sqltamanho+sqlcopa+' order by cust_esto_codigomat');
                  ' order by cust_esto_codigomat');
  while not Qc.eof do begin
    IncluiMovimento;
    MovimentoEstoqueComposicao(unidade,Qc.fieldbyname('cust_esto_codigomat').asstring,'E',xTransacao,yTipoMovimento,xtipocad,Qc.fieldbyname('cust_qtde').ascurrency,
                               pecas,xNumero,tipo_codigo,xmovimento,xentrada );
    Qc.Next;
  end;
  Fgeral.fechaquery(Qc);
end;

procedure TFGeral.SetaTiposdeEstoque;
begin
  if Edit.Items.Count=0 then begin
     Edit.Items.Add('01 - Em Processo');
     Edit.Items.Add('02 - Acabado');
  end;

end;

procedure TFGeral.SetaSeriesValidas(Ed: TSqlEd);
var Lista:TStringlist;
    i:integer;
begin
  Ed.Items.clear;
  Ed.Items.Add('1');
  Ed.Items.Add('2');
  Ed.Items.Add('3');
  Ed.Items.Add('6');   // 24.03.08 - clessi
  Ed.Items.Add('U');
  Ed.Items.Add('D');
  Ed.Items.Add('F');
// 03.07.09 - novicarnes - vanessa
  Ed.Items.Add('B');
// 03.07.09
  if trim( FGeral.GetConfig1AsString('Seriesvalidas') )<>'' then begin
    Lista:=TStringList.create;
    strtolista(Lista,FGeral.GetConfig1AsString('Seriesvalidas'),';',true);
    for i:=0 to Lista.count-1 do begin
      Ed.Items.Add(Lista[i]);
    end;
  end;

end;

procedure TFGeral.SetaGradeCorTamanho(EditCodCor, EditCodTamanho: TSqled;  Produto, Unidade: string);
var Q:TSqlquery;
    ListaCores,ListaTamanhos:TStringlist;
begin
  Q:=sqltoquery('select * from estgrades left join cores on (core_codigo=esgr_core_codigo)'+
                ' left join tamanhos on (tama_codigo=esgr_tama_codigo)'+
                ' where esgr_esto_codigo='+stringtosql(produto)+
                ' and esgr_unid_codigo='+stringtosql(unidade)+' and esgr_status=''N''');
  EditCodcor.Items.Clear;
  EditCodtamanho.Items.Clear;
  ListaCores:=TStringlist.create;
  ListaTamanhos:=TStringlist.create;
  while not Q.eof do begin
    if Q.FieldByName('esgr_core_codigo').asinteger>0 then begin
//      if EditCodcor.Items.IndexOf(strzero(Q.FieldByName('esgr_core_codigo').asinteger,3))=-1 then
//        EditCodcor.Items.add(strzero(Q.FieldByName('esgr_core_codigo').asinteger,3)+' - '+Q.fieldbyname('Core_descricao').asstring)
      if ListaCores.IndexOf(Q.FieldByName('esgr_core_codigo').asstring)=-1 then begin
        EditCodcor.Items.add(spacestr(Q.FieldByName('esgr_core_codigo').asstring,3)+' - '+Q.fieldbyname('Core_descricao').asstring);
        ListaCores.add(Q.FieldByName('esgr_core_codigo').asstring);
      end;
    end;
    if Q.FieldByName('esgr_tama_codigo').asinteger>0 then begin
//      if EditCodtamanho.Items.IndexOf(strzero(Q.FieldByName('esgr_tama_codigo').asinteger,5))=-1 then
//        EditCodtamanho.Items.add(strzero(Q.FieldByName('esgr_tama_codigo').asinteger,5)+' - '+Q.fieldbyname('Tama_descricao').asstring)
      if ListaTamanhos.IndexOf(Q.FieldByName('esgr_tama_codigo').asstring)=-1 then begin
        EditCodtamanho.Items.add(spacestr(Q.FieldByName('esgr_tama_codigo').asstring,5)+' - '+Q.fieldbyname('Tama_descricao').asstring);
        ListaTamanhos.add(Q.FieldByName('esgr_tama_codigo').asstring);
      end;
    end;
    Q.Next;
  end;
  FGeral.FechaQuery(Q);
  if EditCodcor.Items.Count>=1 then
    EditCodcor.ShowForm:=''
  else
    EditCodcor.ShowForm:='FCores';
  if EditCodtamanho.Items.Count>=1 then
    EditCodtamanho.ShowForm:=''
  else
    EditCodtamanho.ShowForm:='FTamanhos';
  ListaCores.free;ListaTamanhos.free;
end;

// 11.06.08 - verifica cnpj em branco, zerado, 'umzado'...
function TFGeral.CnpjcpfOK(c: string): boolean;
////////////////////////////////////////////////////
begin
  result:=true;
  if not Global.Topicos[1319] then exit;  // 23.06.08
  if trim(c)='' then
    result:=false
  else if pos( copy(c,1,6),'000000;111111;222222;333333;444444;555555;666666;777777;888888;999999' ) >0 then
    result:=false;
end;


procedure TFgeral.EstiloForm(Form:TForm);
///////////////////////////////////////////////
begin
//  if FindWindow( PAnsiChar('TPropertyInspector'),Pansichar('Object Inspector') ) =0 then
//     Form.FormStyle:=fsStayontop
//  else
// 29.03.10 - retirado por dar problemas no f12...as vezes...
//     Form.FormStyle:=fsNormal;
// 03.09.10
   if Global.Topicos[1016] then begin
     if FindWindow( PWideChar('TPropertyInspector'),PWidechar('Object Inspector') ) =0 then
       Form.FormStyle:=fsStayontop
     else
       Form.FormStyle:=fsNormal;
   end else
     Form.FormStyle:=fsNormal;
end;


function TFGeral.GetVencimentoPadrao(v: TDatetime): Tdatetime;
/////////////////////////////////////////////////////////////////////
var LIsta:TStringlist;
    p:integer;
    v1,v2,v3,v4,v5,v6,v7,vx:TDatetime;
begin
   if trim(FGeral.GetConfig1AsString('Vencireceber'))<>'' then begin
     Lista:=TStringlist.create;
     strtolista(Lista,FGeral.GetConfig1AsString('Vencireceber'),';',true);
     v1:=0;v2:=0;v3:=0;v4:=0;v5:=0;v6:=0;
     for p:=0 to LIsta.count-1 do begin
       if (strtointdef(trim(LIsta[p]),0)>0) and (v1=0) then
         v1:=Texttodate( strzero(strtointdef(trim(LIsta[p]),0),2)+strzero(Datetomes(v),2)+strzero(Datetoano(v,true),4) )
       else if (strtointdef(trim(LIsta[p]),0)>0) and (v2=0) then
         v2:=Texttodate( strzero(strtointdef(trim(LIsta[p]),0),2)+strzero(Datetomes(v),2)+strzero(Datetoano(v,true),4) )
       else if (strtointdef(trim(LIsta[p]),0)>0) and (v3=0) then
         v3:=Texttodate( strzero(strtointdef(trim(LIsta[p]),0),2)+strzero(Datetomes(v),2)+strzero(Datetoano(v,true),4) )
       else if (strtointdef(trim(LIsta[p]),0)>0) and (v4=0) then
         v4:=Texttodate( strzero(strtointdef(trim(LIsta[p]),0),2)+strzero(Datetomes(v),2)+strzero(Datetoano(v,true),4) )
       else if (strtointdef(trim(LIsta[p]),0)>0) and (v5=0) then
         v5:=Texttodate( strzero(strtointdef(trim(LIsta[p]),0),2)+strzero(Datetomes(v),2)+strzero(Datetoano(v,true),4) )
       else if (strtointdef(trim(LIsta[p]),0)>0) and (v6=0) then
         v6:=Texttodate( strzero(strtointdef(trim(LIsta[p]),0),2)+strzero(Datetomes(v),2)+strzero(Datetoano(v,true),4) );
     end;
     LIsta.free;
     vx:=v;
     if v1>0 then
       vx:=v1;
     if (v<=v2) and (v2>0) then
       vx:=v2
     else  if v2>0 then
       vx:=v2;
     if (v<=v3) and (v3>0) then
       vx:=v3
     else  if v3>0 then
       vx:=v3;
     if (v<=v4) and (v4>0) then
       vx:=v4
     else  if v4>0 then
       vx:=v4;
     if (v<=v5) and (v5>0) then
       vx:=v5
     else  if v5>0 then
       vx:=v5;
     if (v<=v6) and (v6>0) then
       vx:=v6;
     if (v6>0) then
       vx:=v6;
     result:=vx;
{
     if v<=v1 then
       result:=v1
     else if v<=v2 then
       result:=v2
     else if v<=v3 then
       result:=v3
     else if v<=v4 then
       result:=v4
     else if v<=v5 then
       result:=v5
     else if v<=v6 then
       result:=v6
     else if v6>0 then
       result:=v6
     else
       result:=v;
}
   end else
     result:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TFGeral.ValidaLiberacaoLimite(usuario: integer): boolean;
/////////////////////////////////////////////////////////////////////////////////////
var Qusuario:TSqlquery;
begin
      result:=false;
      QUsuario:=sqltoquery('select Usua_OutrosAcessos from usuarios where usua_codigo='+inttostr(usuario));
      if not QUsuario.eof then begin
        if copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,302,1)<>'S' then begin
           if copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,315,1)<>'S' then
             Avisoerro('Usu�rio sem permiss�o para faturamento acima limite de cr�dito.  Solicitar autoriza��o depois prosseguir!');
           QUsuario:=sqltoquery('select Usua_OutrosAcessos from usuarios where usua_codigo='+inttostr(usuario));
           if not QUsuario.eof then begin
             if copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,315,1)='S' then begin
               result:=true;
               Sistema.Edit('usuarios');
               Sistema.SetField('Usua_OutrosAcessos',copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,1,314)+' '+
                                 copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,316,4000-316));
               Sistema.Post('usua_codigo='+inttostr(usuario));
               sistema.Commit;
             end else begin
               result:=false;
               Avisoerro('Usu�rio Ainda sem permiss�o para faturamento acima limite de cr�dito');
             end;
           end else
             result:=false;
        end else result:=true;  // 16.05.14
      end;
  FGeral.FechaQuery(QUsuario);
end;

function TFGeral.ValidaLiberacaoFinan(usuario: integer; tipo: string): boolean;
//////////////////////////////////////////////////////////////////////////////////
var Qusuario:TSqlquery;
begin
      result:=false;
      QUsuario:=sqltoquery('select Usua_OutrosAcessos from usuarios where usua_codigo='+inttostr(usuario));
      if not QUsuario.eof then begin
        if copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,706,1)<>'S' then begin
           if copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,712,1)<>'S' then
             Avisoerro('Usu�rio sem permiss�o para faturamento com restri��o de cr�dito.  Solicitar autoriza��o depois prosseguir!');
           QUsuario:=sqltoquery('select Usua_OutrosAcessos from usuarios where usua_codigo='+inttostr(usuario));
           if not QUsuario.eof then begin
             if copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,712,1)='S' then begin
               result:=true;
               Sistema.Edit('usuarios');
               Sistema.SetField('Usua_OutrosAcessos',copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,1,711)+' '+
                                 copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,713,4000-713));
               Sistema.Post('usua_codigo='+inttostr(usuario));
               sistema.Commit;
             end else begin
               result:=false;
               Avisoerro('Usu�rio Ainda sem permiss�o para faturamento com restri��o de cr�dito');
             end;
           end else
             result:=false;
        end else
          result:=true;  // caso tiver acesso ja liberado para fazer venda com restricao...

      end;
  FGeral.FechaQuery(QUsuario);
end;

procedure TFGeral.NegaUsuarioOutrosAcessos(usuario: integer; posicao: integer);
var Qusuario:TSqlquery;
begin
  QUsuario:=sqltoquery('select Usua_OutrosAcessos from usuarios where usua_codigo='+inttostr(usuario));
  try
     Sistema.Edit('usuarios');
     Sistema.SetField('Usua_OutrosAcessos',copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,1,posicao-1)+' '+
                       copy(QUsuario.FieldByName('Usua_OutrosAcessos').AsString,posicao+1,4000-(posicao+1)));
     Sistema.Post('usua_codigo='+inttostr(usuario));
     sistema.Commit;
  except
     Avisoerro('N�o foi poss�vel gravar no cadastro de usu�rios');
  end;
  FGeral.FechaQuery(QUsuario);

end;

function TFGeral.ValidaComissao(percomissao: currency): boolean;
begin
  result:=true;
  if FGeral.GetConfig1AsFloat('Permaxcomi')>0 then begin
    if percomissao>FGeral.GetConfig1AsFloat('Permaxcomi') then begin
      Avisoerro('Percentual de '+floattostr(percomissao)+' � maior que o permitido');
      result:=false;
    end;
  end;
end;


function TFGeral.CalculaCreditoCubicos(Produto,TipoFSC,Unidade: string ; Data:TDatetime=0): extended;
/////////////////////////////////////////////////////////////////////////////////////////////
var fatorconversao,credito,saidas,qtdsai:currency;
    Q:TSqlquery;
    xdata:TDatetime;
    sqlqualidade,sqlumano:string;
//////////////////
begin
//////////////////
   fatorconversao:=FGeral.GetConfig1AsFloat('percconvm3');
   credito:=0;
   saidas:=0;
   if Data>0 then
     xdata:=data
   else
     xdata:=Sistema.hoje;            // FSC - Misto
//   if (trim(tipoFSC)='') or (tipoFSC='2' ) then
//     sqlqualidade:=' and '+FGeral.Getin('move_certificado','1;2;3','C')
// 04.04.11
     sqlqualidade:=' and '+FGeral.Getin('move_certificado','1;2','C');
//   else
//     sqlqualidade:=' and '+FGeral.Getin('move_certificado',TipoFSC,'C');
   sqlumano:=' and move_datamvto>='+DatetoSql( DatetoDateMesAnt(xdata,12) );
   if fatorconversao<=0 then begin
     Avisoerro('Fator de convers�o ainda n�o informado nas configura��es do sistema');
   end else begin
// soma as entradas certificadas e converte o total em toneladas para metros cubicos
     Q:=sqltoquery('select sum(move_qtde) as move_qtde from movestoque where move_datamvto<='+Datetosql(xData)+
                   ' and move_unid_codigo='+Stringtosql(Unidade)+
                   ' and move_status=''N'''+
                   sqlqualidade+sqlumano+
                   ' and '+FGeral.GetIN('move_tipomov',Global.TiposEntrada,'C') );
     credito:=credito+Q.fieldbyname('move_qtde').ascurrency;
     FGeral.FechaQuery(Q);
     credito:=credito/fatorconversao;
// soma as saidas q estao em metros cubicos e do total caso for o subgrupo de compensados
//     Q:=sqltoquery('select sum(move_qtde) as move_qtde from movestoque where move_datamvto<='+Datetosql(xData)+
// 06.04.11 - Volmar - converte saidas em chapas para m3 quando unidade for
//            'PC'
     Q:=sqltoquery('select move_qtde,move_tama_codigo,esto_unidade from movestoque'+
                   ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                   ' where move_datamvto<='+Datetosql(xData)+
                   ' and move_unid_codigo='+Stringtosql(Unidade)+
                   ' and move_status=''N'''+
//                   ' and move_certificado=''S'''+
                   sqlqualidade+sqlumano+
                   ' and '+FGeral.GetIN('move_tipomov',Global.TiposSaida,'C') );
     while not Q.eof do begin
       if ( Q.fieldbyname('move_tama_codigo').asinteger>0 ) and (Q.fieldbyname('esto_unidade').asstring='PC') then begin
         qtdsai:=Q.fieldbyname('move_qtde').ascurrency*FTamanhos.GetCubagem(Q.fieldbyname('move_tama_codigo').asinteger);
         saidas:=saidas+qtdsai;
       end else
         saidas:=saidas+Q.fieldbyname('move_qtde').ascurrency;
       Q.Next;
     end;
     FGeral.FechaQuery(Q);
     credito:=credito-saidas;
     if credito>0 then begin
  // deduzir do valor apurado a perda em percentual q tiver no subgrupo
       Q:=Sqltoquery('select * from estoque inner join subgrupos on (sugr_codigo=esto_sugr_codigo)'+
                     ' where esto_codigo='+stringtosql(Produto));
       if not Q.eof then
          credito:=credito-(credito*(Q.fieldbyname('sugr_percperda').AsCurrency/100));
       FGeral.FechaQuery(Q);
     end;
   end;
   result:=credito;
end;

procedure TFGeral.ConfiguraColorEditsNaoEnabled(Form:TForm;Size:integer=0;xcor:string='');
///////////////////////////////////////////////////////////////////////////////////////////////////
var i:integer;

    function GetColor( cor :string ):TColor;
    ///////////////////////////////////////////
    var gcor:TColor;
    begin
      gcor:=StringToColor( cor );
    end;

begin
  for i:=0 to Form.ComponentCount-1 do begin
    if Form.Components[i] is TSqlEd then begin
      if ( not TSqlEd( Form.Components[i] ).Enabled ) then begin
// 07.04.13
        if trim(xcor)<>'' then
          TSqled( Form.Components[i] ).Color:= GetColor( xcor )
        else if Fgeral.getconfig1asstring('COREDITSNAOH')='' then
          TSqled( Form.Components[i] ).Color:=clyellow
        else // if Fgeral.getconfig1asstring('COREDITSNAOH')<> '' then begin
          TSqled( Form.Components[i] ).Color:=StringToColor( Fgeral.getconfig1asstring('COREDITSNAOH') );
        TSqled( Form.Components[i] ).Font.Color:=clBlack;
////////////////////        TSqled( Form.Components[i] ).Font.Style:=[fsbold];
// 24.04.15 - campos do fone nao cabem dentro do retangulo do edit
        if size>0 then begin
          TSqled( Form.Components[i] ).Font.Size:=size;
          TSqled( Form.Components[i] ).Height:=size;
        end;
      end;
// 01.04.15
    end else if Form.Components[i] is TSQLPanelGrid then TSqlPanelGrid( Form.components[i] ).Color:=clSilver;
  end;
end;

// 03.03.09
////////////////////////////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaMestreNFSaidaMO(Emissao: TDatetime; Cliente: TSqlEd;
////////////////////////////////////////////////////////////////////////////////////////////
  Representante: integer; Unidade, TipoMovimento, Transacao, Condicao, Natureza, ciffob,Especievolume: string;
  Numero,CodigoMov,QTdevolumes: Integer; Valortotal,baseicms,valoricms,basesubs,icmssubs,vlrfrete: currency; Tabela: Integer ;
  Movimento : TDatetime ; ValorProd,peracre,perdesco : currency ; romaneio:integer ; valoravista:currency ; remessas:string='' ; status:string='N'
  ; Mensagem:string='' ; Pedido:integer=0 ; tran_codigo:string='' ; Pesoliq:currency=0 ; Pesobru:currency=0 ; moes_clie_codigo:integer=0 ;
  Valoripi:currency=0 ;Freteuni:currency=0 ; portoorigem:string='' ; portodestino:string='' ; container:string='' ;
  Representante2: integer=0  ; TiposFornec:string=''  ; aliiss:currency=0;vlrcofins:currency=0;vlrcsl:currency=0;vlrir:currency=0);

Var Q,QUnidade:TSqlquery;
    Especie,serie,mensagemfixa,TipoSaidaAbate:string;

    procedure Atualizalog(xtransacao:string;xusuario,codigolog:integer;emissao:Tdatetime);
    begin
       Sistema.Edit('log');
       Sistema.SetField('log_transacaocanc',xtransacao);
       Sistema.SetField('log_usua_canc',xusuario);
       Sistema.Post('log_codigo='+inttostr(codigolog)+' and log_data='+DAtetosql(emissao)+' and log_transacaocanc='+stringtosql(''))
    end;

begin
    mensagemfixa:='';
    TipoSaidaAbate:='SA';
    QUnidade:=sqltoquery('select * from unidades where unid_codigo='+stringtosql(unidade));
    if codigomov>0 then begin
      Q:=sqltoquery('select * from confmov where comv_codigo='+inttostr(codigomov));
      especie:=Q.fieldbyname('comv_especie').asstring;
      serie:=Q.fieldbyname('comv_serie').asstring;
      FGeral.Fechaquery(Q);
    end else begin
      especie:=Arq.TConfmovimento.fieldbyname('comv_especie').asstring;
      serie:=Arq.TConfmovimento.fieldbyname('comv_serie').asstring;
    end;
// 02.01.08 - devido a cada unidade ter uma especie diferente dentro da mesma config. de movimento
    if trim(QUnidade.fieldbyname('unid_especie').asstring)<>'' then
      especie:=QUnidade.fieldbyname('unid_especie').asstring;
    FGeral.Fechaquery(QUnidade);
///////////
    Sistema.Insert('Movesto');
    Sistema.SetField('moes_transacao',Transacao);
    Sistema.SetField('moes_operacao',GetOperacao);
    Sistema.SetField('moes_status',status);
    Sistema.SetField('moes_numerodoc',Numero);
    Sistema.SetField('moes_romaneio',Romaneio);
    Sistema.SetField('moes_tipomov',TipoMovimento);
    Sistema.SetField('moes_comv_codigo',codigomov);
    Sistema.SetField('moes_unid_codigo',Unidade);
    Sistema.SetField('moes_tipo_codigo',Cliente.AsInteger);
// 09.11.05 - 12.08.08 + RI
    if pos(Tipomovimento,global.coddevolucaocompra+';'+global.coddevolucaocompraSemestoque+';'+Global.CodRemessaConserto+';'
      +Global.CodRemessaDemo+';'+Global.CodDevolucaoSaida+';'+Global.CodRemessaInd+';'+TiposFornec)>0 then begin
      Sistema.SetField('moes_estado',Cliente.ResultFind.fieldbyname('forn_uf').AsString);
      Sistema.SetField('moes_tipocad','F');
      Sistema.SetField('moes_cida_codigo',Cliente.ResultFind.fieldbyname('forn_cida_codigo').AsInteger);
    end else begin
      Sistema.SetField('moes_estado',Cliente.ResultFind.fieldbyname('clie_uf').AsString);
      Sistema.SetField('moes_tipocad','C');
      Sistema.SetField('moes_repr_codigo',Representante);
      Sistema.SetField('moes_cida_codigo',Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger);
    end;
    Sistema.SetField('moes_datalcto',Sistema.Hoje);
// 31/08/05 - para sair no relat. de auditoria no 'dia da digitacao'
    if TipoMovimento=Global.codvendaambulante then
      Sistema.SetField('moes_datamvto',Movimento)
    else
      Sistema.SetField('moes_datamvto',Emissao);
    Sistema.SetField('moes_DataCont',Movimento);
    Sistema.SetField('moes_dataemissao',Emissao);
    Sistema.SetField('moes_vlrtotal',Valortotal);
    Sistema.SetField('moes_tabp_codigo',Tabela);
    Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
    Sistema.SetField('moes_natf_codigo',Natureza);
    Sistema.SetField('moes_freteciffob',ciffob);
    Sistema.SetField('moes_baseicms',0);  // baseicms
    Sistema.SetField('moes_valoricms',0);  // valoricms
    Sistema.SetField('moes_basesubstrib',0);  // basesubs
    Sistema.SetField('moes_valoricmssutr',0);  // icmssubs
    Sistema.SetField('moes_frete',vlrfrete);
    Sistema.SetField('moes_vispra',FCondPagto.GetAvPz(Condicao));
//    Sistema.SetField('moes_especie',Arq.TConfmovimento.fieldbyname('comv_especie').asstring);
    Sistema.SetField('moes_especie',especie);
//    Sistema.SetField('moes_serie',FGeral.Qualserie(Arq.TConfmovimento.fieldbyname('comv_serie').asstring,Global.serieunidade,tipomovimento));
    Sistema.SetField('moes_serie',FGeral.Qualserie(serie,Global.serieunidade,tipomovimento));
//    Sistema.SetField('moes_tran_codigo',Arq.TTransp.fieldbyname('tran_codigo').asstring);
// 26.10.05
    Sistema.SetField('moes_tran_codigo',tran_codigo);
    Sistema.SetField('Moes_qtdevolume',QTdevolumes);
    Sistema.SetField('Moes_especievolume',Especievolume);
    Sistema.SetField('moes_totprod',ValorProd);
    Sistema.SetField('moes_valortotal',Valortotal);
    Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('Moes_Perdesco',perdesco);
    Sistema.SetField('Moes_Peracres',peracre);
// 23.12.04
    Sistema.SetField('moes_valoravista',valoravista);
// 16.05.05
    Sistema.SetField('moes_remessas',remessas);
// 01.09.05 - 28.06.06
    if trim(mensagemfixa)<>'' then
      Sistema.SetField('moes_mensagem',mensagemfixa+mensagem)
    else
      Sistema.SetField('moes_mensagem',mensagem);
// 20.10.05
    Sistema.SetField('moes_pedido',pedido);
// 15.11.05
    Sistema.SetField('moes_pesoliq',pesoliq);
    Sistema.SetField('moes_pesobru',pesobru);
// 12.07.05
    if moes_clie_codigo=0 then   // 30,12,05
      Sistema.SetField('moes_clie_codigo',Cliente.AsInteger)
// 30.12.05
    else if moes_clie_codigo>0 then   // 30.12.05
      Sistema.SetField('moes_clie_codigo',moes_clie_codigo);
// 16.06.06
    Sistema.SetField('moes_fpgt_codigo',Condicao);
// 28.08.06
    Sistema.SetField('moes_valoripi',0);  // Valoripi
// 28.09.06
    Sistema.SetField('moes_freteuni',Freteuni);
// 19.12.07
    Sistema.SetField('moes_nroobra',inttostr(numero));
// 02.01.08
    Sistema.SetField('moes_embarque',portoorigem);
    Sistema.SetField('moes_destino',portodestino);
    Sistema.SetField('moes_container',container);
//
    Sistema.SetField('moes_baseiss',basesubs);
    Sistema.SetField('moes_baseinss',baseicms);
    Sistema.SetField('moes_valorpis',Valoripi);
    Sistema.SetField('moes_valorcofins',vlrcofins);
    Sistema.SetField('moes_valorcsl',vlrcsl);
    Sistema.SetField('moes_valorir',vlrir);
    Sistema.SetField('moes_valorinss',valoricms);
    Sistema.SetField('moes_valoriss',icmssubs);
    Sistema.SetField('moes_periss',aliiss);
    Sistema.Post();
// 23.04.08 - grava a transacao e o usuario no arquivo de log
    Atualizalog(transacao,Global.Usuario.Codigo,15,emissao);

end;

// 03.03.09
//////////////////////////////////////////////////////////////////////
procedure TFGeral.GravaItensNFSaidaMo(Emissao: TDatetime; Cliente: TSqlEd;
///////////////////////////////////////////////////////////////////////////////////////////
  Representante: integer; Unidade, TipoMovimento, Transacao: string;
  Numero: Integer; Grid: TSqlDtGrid ; frete , seguro, peracre , perdesco :currency ; Movimento : TDatetime  ; remessas:string='' ;
  status:string='N' ; Pedido:integer=0 ; moes_clie_codigo:integer=0  ;cfop:string=''  ; Consfinal:string='S' ;
  CodigoMov:integer=0 ; rtipocad:string='C');

var linha,p:integer;
    codigograde,codigolinha,codigocoluna,xcodcor,xcodtamanho,xcodcopa:integer;
    venda,qtde,reducao,isentas,outras,base,basesubs,valorcontabil,icmssubs,margemlucro,totalitem,icmsitem,totalbaseicms:currency;
    devolucoes,cfopx,consfinalx,cfopind,xsqlcor,xsqltamanho,xsqlcopa:string;
    TEstoque:TSqlquery;
    prim:boolean;


/////////////////////////////////////
begin

  if ListaCstPerc=nil then
     ListaCstPerc:=Tlist.create;
  ListaCstPerc.clear;
  Grid.Index(Grid.GetColumn('move_cst'));
  devolucoes:=Global.CodDevolucaoVenda+';'+Global.CodDevolucaoRoman+';'+global.CodDevolucaoConsigMerc+';'+Global.CodDevolucaoVendaConsig;
  cfopind:=cfop;

  prim:=true;  // aqui em 05.12.07
  for linha:=1 to Grid.rowcount do begin
    if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha])<>'' then begin
      TEstoque:=sqltoquery('select * from cadmobra where cadm_codigo='+trim(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]) );

      xcodcor:=strtointdef(Grid.Cells[Grid.getcolumn('codcor'),linha],0);
      xcodtamanho:=strtointdef(Grid.Cells[Grid.getcolumn('codtamanho'),linha],0);
      xcodcopa:=strtointdef(Grid.Cells[Grid.getcolumn('codcopa'),linha],0);
      xsqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
      xsqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
      xsqlcopa:=' and ( esgr_copa_codigo=0 or esgr_copa_codigo is null )';
      if (xcodcor>0) and (xcodtamanho>0) and (xcodcopa>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
          xsqlcopa:=' and esgr_copa_codigo='+inttostr(xcodcopa);
      end else if (xcodcor>0) and (xcodtamanho>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
      end else if (xcodcor>0) then begin
          xsqlcor:=' and esgr_core_codigo='+inttostr(xcodcor);
      end else if (xcodtamanho>0) then begin
          xsqltamanho:=' and esgr_tama_codigo='+inttostr(xcodtamanho);
      end;
//      QtdeEstoqueGrade:=sqltoquery('select * from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha])+
//            ' and esgr_unid_codigo='+Stringtosql(Unidade)+
//            xsqlcor+xsqltamanho+xsqlcopa );
//            ' and esgr_core_codigo='+Stringtosql(Grid.Cells[Grid.getcolumn('codcor'),linha])+
//            ' and esgr_tama_codigo='+Stringtosql(Grid.Cells[Grid.getcolumn('codtamanho'),linha])+
//            ' and ( esgr_copa_codigo='+Stringtosql(Grid.Cells[Grid.getcolumn('codcopa'),linha])+' or esgr_copa_codigo is null )' );
/////////////////
//      codigograde:=FEstoque.GetCodigoGrade(Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha]);

      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',Grid.Cells[Grid.getcolumn('move_esto_codigo'),linha]);
// 17.08.06
      Sistema.SetField('move_tama_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codtamanho'),linha],0));
      Sistema.SetField('move_core_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codcor'),linha],0));
      Sistema.SetField('move_copa_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codcopa'),linha],0));
/////////////
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',numero);
//      Sistema.SetField('move_status','N');
// 20.08.05
      Sistema.SetField('move_status',status);
      Sistema.SetField('move_tipomov',TipoMovimento);
      Sistema.SetField('move_unid_codigo',Unidade);
      Sistema.SetField('move_tipo_codigo',Cliente.AsInteger);
// 29.08.08
      if rtipocad='F' then begin
        Sistema.SetField('move_tipocad','F');
      end else begin
        Sistema.SetField('move_tipocad','C');
        Sistema.SetField('move_repr_codigo',Representante);
      end;
      Sistema.SetField('move_qtde',texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]));
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datacont',Movimento);
// 09/09/05 - para sair no relat. de auditoria no 'dia da digitacao'
      if TipoMovimento=Global.codvendaambulante then
        Sistema.SetField('move_datamvto',Movimento)
      else
        Sistema.SetField('move_datamvto',Emissao);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_custo',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
      Sistema.SetField('move_custoger',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
      Sistema.SetField('move_customedio',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
      Sistema.SetField('move_customeger',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
      Sistema.SetField('move_cst',Grid.Cells[grid.getcolumn('move_cst'),linha]);
      Sistema.SetField('move_aliicms',texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha]));
      Sistema.SetField('move_venda',texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]));
      Sistema.SetField('move_grup_codigo',0);
      Sistema.SetField('move_sugr_codigo',0);
      Sistema.SetField('move_fami_codigo',0);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_perdesco',texttovalor(Grid.Cells[grid.getcolumn('move_perdesco'),linha]));
      Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('move_vendabru'),linha]));
// 02.01.06
      if trim(Grid.Cells[Grid.getcolumn('move_remessas'),linha])<>'' then
        Sistema.SetField('move_remessas',Grid.Cells[Grid.getcolumn('move_remessas'),linha])
      else
// 16.05.05
        Sistema.SetField('move_remessas',remessas);
// 28.08.06
      Sistema.SetField('move_aliipi',texttovalor(Grid.Cells[grid.getcolumn('move_aliipi'),linha]));
// 08.05.07
      Sistema.SetField('move_pecas',texttovalor(Grid.Cells[grid.getcolumn('move_pecas'),linha]));
// 30.05.07
      Sistema.SetField('move_vendamin',texttovalor(Grid.Cells[grid.getcolumn('move_vendamin'),linha]));
// 19.06.07
      Sistema.SetField('move_redubase',texttovalor(Grid.Cells[grid.getcolumn('move_redubase'),linha]));
// 19.12.07
      Sistema.SetField('move_nroobra',inttostr(numero));
      if Global.Topicos[1326] then
// 23.12.08
        Sistema.SetField('move_certificado',Grid.Cells[grid.getcolumn('move_certificado'),linha]);
// 04.03.09
      Sistema.SetField('move_descricao',Grid.Cells[grid.getcolumn('esto_descricao'),linha]);
      Sistema.Post('');

      reducao:=0;isentas:=0;outras:=0;
      venda:=texttovalor(Grid.Cells[grid.getcolumn('move_venda'),linha]);
      qtde:=texttovalor(Grid.Cells[grid.getcolumn('move_qtde'),linha]);
      totalitem:=FGeral.Arredonda(venda*qtde,2);
      if Peracre>0 then begin
        totalitem:=totalitem+FGEral.Arredonda( totalitem*(Peracre/100) ,2  );
      end else if Perdesco>0 then begin
        totalitem:=totalitem-FGEral.Arredonda( totalitem*(Perdesco/100) ,2 );
      end;
// 23.05.07
      totalbaseicms:=totalitem - ( totalitem*(texttovalor(Grid.Cells[grid.getcolumn('move_redubase'),linha])/100));
      reducao:=texttovalor(Grid.Cells[grid.getcolumn('move_redubase'),linha]);

      icmsitem:=totalbaseicms*( texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha])/100 );
      ValorContabil:=totalitem;
      Base:=totalitem;
// 28.06.05
      if TipoMovimento=Global.CodVendaConsigMercantil then begin
        icmsitem:=0;
      end;
// 03.12.08
      if rtipocad='F' then
        margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],Unidade,Cliente.resultfind.fieldbyname('forn_uf').asstring))
      else
        margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Grid.Cells[grid.GetColumn('move_esto_codigo'),linha],Unidade,Cliente.resultfind.fieldbyname('clie_uf').asstring));
      if Margemlucro>0 then begin
        basesubs:=base*(1+(margemlucro/100));
        icmssubs:=basesubs*( texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha])/100 );
        icmssubs:=icmssubs-icmsitem;
      end else begin
        basesubs:=0;
        icmssubs:=0;
      end;
      valorcontabil:=valorcontabil+icmssubs;
////////////////////////////

      FGeral.Fechaquery(TEstoque);
    end;
  end; // ref. ao grid


end;


procedure TFGeral.ImprimelinhaRel(colunas:integer ; s: string );
var p:integer;
begin
  for p:=1 to colunas do begin
     FRel.Addcel(s)
  end;

end;

function TFGeral.FormatoObra(o: string): string;
var s:string;
begin
  if length( trim(o) ) = 8 then   // 22.09.10 - nao achava no previsto e realizado do estoque
    s:=Trans(trim(o),'##-####-##')
  else  if copy(o,1,1)='0' then
    s:=Trans(trim(o),'##-####-##')
  else begin
//   '##-####-##'
    s:='0'+trim(o);
    s:=Trans(s,'##-####-##')
  end;
  result:=s;
end;

function TFGeral.ContaBloqueada(conta: integer;xContasBloqueadas: string): boolean;
var Lista:TStringList;
    p:integer;
begin
  result:=false;
  if trim(xContasBloqueadas)<>'' then begin
    Lista:=TStringList.Create;
    strtolista(Lista,xContasBloqueadas,';',true);
    for p:=0 to Lista.count-1 do begin
      if strtointdef(Lista[p],0)=conta then begin
        result:=true;
        break;
      end;
    end;
  end;
end;

function TFGeral.ExisteTabela(tabela: string): boolean;
var Q:TSqlquery;
begin
  Q:=SqltoQuery('select * from dicionario where tabela='+StringtoSql(Uppercase(tabela)));
  result:= not Q.eof;
  FGeral.FechaQuery(Q);
end;

function TFGeral.ValidaContadorNFSaida(numero: integer; serie,unidade: string;datareferencia: TDatetime): boolean;
////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    Data:TDatetime;
    senha:string;
begin
  if not Global.Topicos[1301] then begin
//    Data:=datareferencia-30;
// 05.05.11 - pra ficar 'menos demorado'
    Data:=datareferencia-15;
//    Q:=sqltoquery('select max(moes_numerodoc) as numero from movesto'+
// 24.10.11 - nova tentativa pra ficar 'menos demorado'
    Q:=sqltoquery('select moes_numerodoc as numero from movesto'+
                  ' where moes_serie='+stringtosql(serie)+
                  ' and moes_dataemissao>='+Datetosql(data)+
                  ' and moes_unid_codigo='+stringtosql(Unidade)+
                  ' and '+FGeral.GetIN('moes_tipomov',Global.TiposRelVenda,'C')+
                  ' and '+FGeral.GetNOTIN('moes_tipomov',Global.tiposNaoFiscal,'C')+
                  ' and moes_status<>''C'''+
// 12.05.15 - Vivan - nao pode contar com numeracao dos cupons fiscais
                  ' and '+FGeral.GetNOTIN('moes_serie','F;F ','C')+
                  ' and '+FGeral.GetNOTIN('moes_especie','CF;CF ;','C')+
//                  ' and moes_datacont>1');
                  ' and moes_datacont > '+DateToSql(Global.DataMenorBanco)+
                  ' order by moes_numerodoc desc');
    IF NOT Q.EOF THEN BEGIN
    if (Q.fieldbyname('numero').asinteger>numero) then begin
      if Global.UsaNfe='S' then begin  // 30.06.10
        FGeral.Fechaquery(Q);
        Q:=sqltoquery('select moes_numerodoc as numero from movesto'+
                  ' where moes_serie='+stringtosql(serie)+' and moes_dataemissao>='+Datetosql(data)+
                  ' and moes_unid_codigo='+stringtosql(Unidade)+
                  ' and '+FGeral.GetIN('moes_tipomov',Global.TiposRelVenda,'C')+
                  ' and '+FGeral.GetNOTIN('moes_tipomov',Global.tiposNaoFiscal,'C')+
// 06.05.13 - Simar - numeracao CF chegou na da NFe
                  ' and '+FGeral.GetNOTIN('moes_serie','F;F ','C')+
                  ' and '+FGeral.GetNOTIN('moes_especie','CF;CF ;','C')+
///////////////
                  ' and moes_status<>''C'''+
                  ' and moes_numerodoc='+inttostr(numero)+
                  ' and moes_datacont > '+DateToSql(Global.DataMenorBanco));
        if not Q.eof then begin
          Avisoerro('Encontrado documento '+Q.fieldbyname('numero').asstring+' nos �ltimos 15 dias. Checar numera��o.');
          result:=false;
          if Input('Autoriza��o','Senha',senha,7,false) then begin
            if trim(senha)='' then exit;
            if lowercase(senha)='wsdl'+strzero(DatetoDia(Sistema.hoje),2) then result:=true;
          end;
        end else
         result:=true;
      end else begin
        Avisoerro('Encontrado documento '+Q.fieldbyname('numero').asstring+' nos �ltimos 15 dias. Checar numera��o.');
        result:=false;
        if Input('Autoriza��o','Senha',senha,7,false) then begin
          if trim(senha)='' then exit;
          if lowercase(senha)='wsdl'+strzero(DatetoDia(Sistema.hoje),2) then result:=true;
        end;
//      FGeral.Gravalog(11,'Unidade '+Global.CodigoUnidade+'Nota nro '+inttostr(numero)+' S�rie '+serie+' detectado em '+FGeral.formatadata(Datareferencia),true);
      end;

    end else
      result:=true;
    END else result:=true; // 24.10.11 - 23.05.12
    FGeral.Fechaquery(Q);
  end else
    result:=true;
end;

procedure TFGeral.SetaTipoRepresentante(Edit: TSqlEd);
begin
  if Edit.Items.Count=0 then begin
     Edit.Items.Add('C - Consultor Externo');
     Edit.Items.Add('I - Consultor Interno');
     Edit.Items.Add('R - Representante Comercial');
     Edit.Items.Add('G - Gerente Comercial');
  end;

end;

////////////////////////////////////////////////////////// 08.07.09
function TFGeral.GetCampoNumerico(const s:String;valor:extended;xleft,xtop:integer):extended;
//////////////////////////////////////////////////////////
var Form: TForm; Edt:TSQLEd; NovaExecucao:Boolean;
begin
  NovaExecucao:=False;
  Form := TForm.Create(Application);
  with Form do begin
     BorderStyle := bsDialog;
//     Caption := 'Informe o Valor';
     Caption := 'Informe '+s;
     Width:=200;Height:=80;
     Left := xLeft;
     Top := xTop;
//     Position:=poScreenCenter;
//     Position:=poDefault;
     Position:=poDesigned;
     Edt:=TSQLEd.Create(Form);
     with Edt do begin
       Parent := Form;
       TypeValue:=tvFloat;
       Decimals:=3;
       Setvalue(valor);
       Empty:=True;
       Title:='Valor';
       TitlePixels:=60;
       TitlePos:=tppLeft;
       CloseFormEsc:=True;
       CloseForm:=True;
       MessageStr:=s;
       SetBounds(75,10,55,25);
     end;
  end;
//  Edt.SetDate(Sistema.DataMvto);
//  Sistema.SetMessage(s);
  Form.ActiveControl:=Edt;
  Form.ShowModal;
//  Result:=Edt.LastKey<>27;
  Result:=Edt.AsCurrency;
{
  if Result then begin
     if not Edt.Valid then begin
        NovaExecucao:=True;
     end else begin
//        Sistema.DataMvto:=Edt.AsDate;
     end;
  end;
}
  Form.Free;
  if NovaExecucao then GetCampoNumerico(s,Edt.AsCurrency,Edt.Left,Edt.Top);
  Sistema.SetMessage('');
end;


function TFGeral.GetLocalExternoPea:string;
var localexterno:string;
begin
  localexterno:=FGeral.Getconfig1asstring('localpea');
  result:=localexterno;
  if trim(localexterno)='' then exit;
  if not FileExists(localexterno+'OBAPROV.DBF') then begin
    if pos( ':',localexterno ) > 0 then begin
      localexterno:='E:'+copy(localexterno,pos( ':',localexterno ) + 1,50 );
      result:=localexterno;
    end;
  end;


end;

function TFGeral.GetGeraFiscal(tipo: string): string;
begin
   if pos(tipo,Global.TiposExpFiscalNotas)>0 then
     result:='S'
   else
     result:='N';

end;

function TFGeral.GetValorJurosII(capital,taxamensal: currency; meses:integer ; parcelaunica:string): currency;
var juros,montante,taxa,pmt:extended;
begin
//   S = P (1 + i) elevado a n
  taxamensal:=taxamensal/100;
  if ParcelaUnica='S' then begin
    montante:=capital * ( Power(1+taxamensal,meses) );
    juros:=montante-capital;
  end else begin
    taxa:=Power(1+taxamensal,meses) ;
//    if taxa>0 then begin
// 08.07.13
    if (taxa-1)>0 then begin
      pmt := capital * ( (taxamensal*taxa)/(taxa-1) );
      montante:=pmt*meses;
      juros:=montante-capital;
    end else
      juros:=0;
  end;
//            TaxaDia:=Power(((TaxaMensal/100)+1),(1/30));
//            TaxaJuros:=1;
//            for d:=1 to nd do TaxaJuros:=TaxaJuros*TaxaDia;
//            Juros:=RoundValor(Capital*TaxaJuros)-Capital;
  result:=juros;
end;

procedure TFGeral.GravaItensNFSaidaSer(Emissao: TDatetime; Cliente: TSqlEd;
  Representante: integer; Unidade, TipoMovimento, Transacao: string;
  Numero: Integer; ListaSer: TList; frete, seguro, peracre,
  perdesco: currency; Movimento: TDatetime; remessas, status: string;
  Pedido, moes_clie_codigo: integer; cfop, Consfinal: string;
  CodigoMov: integer; rtipocad: string);

var linha,p:integer;
    codigograde,codigolinha,codigocoluna,xcodcor,xcodtamanho,xcodcopa:integer;
    venda,qtde,reducao,isentas,outras,base,basesubs,valorcontabil,icmssubs,margemlucro,totalitem,icmsitem,totalbaseicms:currency;
    devolucoes,cfopx,consfinalx,cfopind,xsqlcor,xsqltamanho,xsqlcopa,sqlcorped,sqltamanhoped:string;
    QSubgrupo,TEstoque,QIpi,Qconfmov,TEstoqueQtde,QtdeEstoqueGrade,QCusto:TSqlquery;
    prim:boolean;
    Campo:TDicionario;
    PServicos:^TServicos;


/////////////////////////////////////
begin
/////////////////////////////////////

  devolucoes:=Global.CodDevolucaoVenda+';'+Global.CodDevolucaoRoman+';'+global.CodDevolucaoConsigMerc+';'+Global.CodDevolucaoVendaConsig;
  cfopind:=cfop;
  if codigomov>0 then begin
      QConfmov:=sqltoquery('select * from confmov where comv_codigo='+inttostr(codigomov));
      if copy(cfop,1,1)='5' then
        cfopind:=QConfmov.fieldbyname('comv_natf_estadoipi').asstring
      else
        cfopind:=QConfmov.fieldbyname('comv_natf_foestadoipi').asstring;
      FGeral.Fechaquery(QConfmov);
  end;

  prim:=true;  // aqui em 05.12.07
  for linha:=0 to ListaSer.Count-1 do begin
    PServicos:=ListaSer[linha];
    if trim(PServicos.produto)<>'' then begin
      TEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(PServicos.produto) );

//      Arq.TEstoqueqtde.Locate('esqt_unid_codigo;esqt_esto_codigo',Vararrayof([Unidade,Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]]),[]);
//        avisoerro('N�o encontrou o produto '+Grid.Cells[grid.GetColumn('move_esto_codigo'),linha]+' na unidade '+unidade);
// 22.08.06
      TEstoqueqtde:=sqltoquery('select * from estoqueqtde where esqt_status=''N'' and esqt_unid_codigo='+stringtosql(UNidade)+
                               ' and esqt_esto_codigo='+stringtosql(PServicos.produto) );
      xcodcor:=0;
      xcodtamanho:=0;
      xcodcopa:=0;
      xsqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
      xsqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
      xsqlcopa:=' and ( esgr_copa_codigo=0 or esgr_copa_codigo is null )';

      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',PServicos.produto);

// 17.08.06
      Sistema.SetField('move_tama_codigo',0);
      Sistema.SetField('move_core_codigo',0);
      Sistema.SetField('move_copa_codigo',0);
/////////////
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',numero);
//      Sistema.SetField('move_status','N');
// 20.08.05
      Sistema.SetField('move_status',status);
      Sistema.SetField('move_tipomov',TipoMovimento);
      Sistema.SetField('move_unid_codigo',Unidade);
      Sistema.SetField('move_tipo_codigo',Cliente.AsInteger);
      if rtipocad='F' then begin
        Sistema.SetField('move_tipocad','F');
      end else begin
        Sistema.SetField('move_tipocad','C');
        Sistema.SetField('move_repr_codigo',Representante);
      end;
      Sistema.SetField('move_qtde',PServicos.qtde);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datacont',Movimento);
      Sistema.SetField('move_datamvto',Emissao);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_custo',TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
      Sistema.SetField('move_custoger',TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
      Sistema.SetField('move_customedio',TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
      Sistema.SetField('move_customeger',TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
      Sistema.SetField('move_cst','000');
      Sistema.SetField('move_aliicms',PServicos.periss);
      Sistema.SetField('move_venda',PServicos.unitario);
      Sistema.SetField('move_grup_codigo',TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_perdesco',0);
      Sistema.SetField('move_vendabru',PSErvicos.unitario);
      Sistema.SetField('move_remessas',remessas);
      Sistema.SetField('move_clie_codigo',Cliente.AsInteger);
      Sistema.SetField('move_nroobra',inttostr(numero));
      Sistema.Post('');

/////////////////
// 20.10.05 - baixa de itens do pedido de venda
// quando colocar a cor e tamanho na nf dai baixar tbem pela cor e tamanho
/////////////////////////////////////////////////////////////////////////////
// 22.04.09 - colocado op��o de cor e tamanho na nota de saida
      if Pedido>0 then begin
         Sistema.Edit('movpeddet');
         Sistema.setfield('mpdd_situacao','E');
         Sistema.setfield('mpdd_qtdeenviada',PSErvicos.qtde);
         Sistema.setfield('mpdd_dataenviada',emissao);
         Sistema.setfield('mpdd_nfvenda',numero);
         Sistema.setfield('mpdd_datanfvenda',emissao);
         Sistema.post('mpdd_numerodoc='+inttostr(Pedido)+' and mpdd_esto_codigo='+stringtosql(PServicos.Produto)+
          ' and mpdd_status=''N'''+  //  'and mpdd_tipomov='+stringtosql('PV')+
          ' and mpdd_situacao=''P''') ;
      end;
/////////////////////////////////////////////////////////////
      FGeral.Fechaquery(TEstoque);
      FGeral.Fechaquery(TEstoqueQtde);
    end;
  end; // ref. a lista servicos

end;


////////////////////////////////////////////
procedure TFGeral.SetaMovimento(Ed: TSqled);
////////////////////////////////////////////
begin
   if ( Global.Topicos[1007] )  then
     Ed.SetDate(TextToDate(''))
   else
     Ed.SetDate(Sistema.Hoje);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TFGeral.GetEmailEntidade(Codigo: Integer;  Categoria: String ; cemails:string=''): String;
///////////////////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlQuery;
begin
  Result:='';
  if Categoria='F' then begin
     Q:=SqlToQuery('SELECT Forn_email,Forn_email1 FROM Fornecedores WHERE Forn_Codigo='+IntToStr(Codigo));
     if not Q.IsEmpty then begin
        Result:=Trim(Q.FieldByName('Forn_Email').AsString);
        if cemails='S' then
          Result:=Trim(Q.FieldByName('Forn_Email').AsString+';'+Q.FieldByName('Forn_Email1').AsString);
     end;
     Q.Close;Q.Free;
  end else if Categoria='C' then begin
     Q:=SqlToQuery('SELECT Clie_email,Clie_email1 FROM Clientes WHERE Clie_Codigo='+IntToStr(Codigo));
     if not Q.IsEmpty then begin
        Result:=Trim(Q.FieldByName('Clie_Email').AsString);
        if (cemails='S') and (trim(Q.FieldByName('Clie_Email1').AsString)<>'') then
          Result:=Trim(Q.FieldByName('Clie_Email').AsString+';'+Q.FieldByName('Clie_Email1').AsString);
     end;
     Q.Close;Q.Free;
  end else if (Categoria='R') or (Categoria='S') then begin
     Q:=SqlToQuery('SELECT repr_email FROM representantes WHERE Repr_Codigo='+IntToStr(Codigo));
     if not Q.IsEmpty then begin
        Result:=Trim(Q.FieldByName('Repr_email').AsString);
     end;
     Q.Close;Q.Free;
  end;
end;

function TFGeral.GetSqlDataNula(campo: string): string;
begin
  result:=campo+' is Not Null';

end;

function TFGeral.ConverteHorasparaHorasDec(Qtde: currency): currency;
var horas,minutos:currency;
begin
  minutos:= qtde-trunc(qtde) ;
  if minutos=0 then
    result:=qtde
  else
    result:=trunc(qtde) + ((minutos*100)/60);
end;

// 22.04.10
function TFGeral.GetUsaCliFor(tipo: string): string;
//////////////////////////////////////////////////////////////
var s,tiposmuda,tiposfornec:string;
begin
   if GetMovimentoEs(tipo)='E' then
     s:='Fornecedor'
   else
     s:='Cliente';
//saidas que usam fornecedores
   TiposFornec:=Global.CodRemessaconserto+';'+Global.CodRemessaDemo+';'+Global.CodDevolucaoSaida+';'+
                Global.CodRemessaInd+';'+Global.CodVendaFornecedor+';'+Global.CodDevolucaoSimbolicaConsig; ;
   if pos(tipo,Global.coddevolucaocompra+';'+Global.coddevolucaocompraSemestoque+';'+Global.CodDevolucaoSimbolicaConsig+';'+tiposfornec)>0 then
     s:='Fornecedor';
// entradas  q usam cliente
   tiposmuda:=Global.CodDevolucaoSerie5+';'+Global.CodDevolucaoVenda+';'+Global.CodDevolucaoConsigMerc+';'+Global.CodRetornoConsigMercanil+';'+
             Global.CodRetornoMostruario+';'+Global.CodDevolucaoRoman+';'+Global.CodDevolucaoIgualVenda+';'+
             Global.CodDevolucaoVendaConsig+';'+Global.CodCompraProdutor+';'+Global.CodDrawBackEnt+';'+Global.CodEntradaImobilizado+';'+
             Global.CodDevolucaoImob+';'+Global.CodDevolucaoSemFinan+';'+Global.CodDevolucaodeRemessa+';'+Global.CodEntradaProdutor;

   if pos(tipo,tiposmuda)>0 then
     s:='Cliente';
  result:=s;

end;

function TFGeral.GetNroSerieCertificado(Unid_codigo: string): string;
///////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    cert:string;
begin
  campo:=Sistema.GetDicionario('unidades','unid_nroseriecertif');
  if Campo.Tipo<>'' then begin
    Q:=Sqltoquery('select unid_nroseriecertif from unidades where unid_codigo='+Stringtosql(Unid_codigo));
    if not Q.eof then
      cert:=Q.fieldbyname('unid_nroseriecertif').asstring
    else
      cert:='';
    if trim(cert)='' then
      cert:=FGeral.GetConfig1AsString('NumSerieCert');
    FGeral.FechaQuery(Q);
  end else begin
    cert:=FGeral.GetConfig1AsString('NumSerieCert');
  end;
  result:=cert;
end;

function TFGeral.EmailStmpcomSSL(emailorigem: string): boolean;
//var Lista:Tstringlist;
//    p:integer;
begin
{
  Lista:=TStringlist.create;
  Lista.Add('GMAIL');
  result:=false;
  for p:=0 to Lista.count-1 do begin
    if Ansipos( Lista.Strings[p], uppercase(emailorigem) ) >0 then begin
      result:=true;
      break;
    end;
  end;
  Lista.free;
}
// 08.10.10  - cria topico do sistema devido sivila@docepimenta.com.br
// que fica 'dentro do gmail'..
  result:=Global.Topicos[1017];
end;

function TFGeral.SemDllsSmtp:boolean;
//////////////////////////////
var xpath:string;
begin
   result:=false;
   xpath:=ExtractFilePath(Application.ExeName );
   if (not FileExists(xpath+'\libeay32.dll')) or (not FileExists(xpath+'\ssleay32.dll')) then
//      (not FileExists('zlib1.dll')) then
// 05.10.10 - a principio 'nao precisa'
      result:=true;
end;

procedure TFGeral.ConfiguraTamanhoEditsEnabled(Form: TForm;Tamanho:integer);
///////////////////////////////////////////////////////////////////////////
var i:integer;
begin
  if tamanho=0 then tamanho:=8;  // o 'padrao'
  for i:=0 to Form.ComponentCount-1 do begin
    if Form.Components[i] is TSqlEd then begin
//      if ( TSqlEd( Form.Components[i] ).Enabled )
//         then begin
//        TSqled( Form.Components[i] ).TitleFont.Size:=size;
//        TSqled( Form.Components[i] ).Height:=TSqled( Form.Components[i] ).Height+(size-8);
        if tamanho=8 then
          TSqled( Form.Components[i] ).Height:=21  // padr�o
        else
          TSqled( Form.Components[i] ).Height:=tamanho;
        TSqled( Form.Components[i] ).Font.Size:=tamanho;
//      end;
    end;
  end;
end;

function TFGeral.SqlToQueryContax(Sql: String): TSQLQuery;
///////////////////////////////////////////////////////////
begin
  Result:=TSQLQuery.Create(Application.MainForm);
//  Result.NoMetadata:=True;
  Result.SQLConnection:=SistemaContax;
  Result.SQL.Text:=ConvSql(Sql);
  Result.Open;

end;

function TFGeral.ConectaContax: boolean;
///////////////////////////////////////////////////////
var xdatabasename,xhostname:string;
begin
   result:=false;
   xDatabasename:=GetIni('Erp','Config','Databasename');
   xHostname:=GetIni('Erp','Config','EnderecoServidor');
   if trim(xDatabasename)='' then
     xDatabasename:='contax';
   if not SistemaContax.Connected then begin
//     SistemaSac:=TSqlEnv.Create(Application.MainForm);
     SistemaContax.Params.Clear;
//     SistemaContax.Params.Add('DriverName=PostgreSQL');
     SistemaContax.Params.Add('DevartPostgreSQL');
//     SistemaContax.Params.Add('Database='+Sistema.SQLServer+'/'+LowerCase('saccarli'));
//     SistemaContax.Params.Add('Database='+Sistema.SQLServer+'/'+LowerCase(xdatabasename));
     SistemaContax.Params.Add('Database='+LowerCase(xdatabasename));
     SistemaContax.Params.Add('HostName='+xhostname);
     SistemaContax.Params.Add('User_Name='+LowerCase('erp'));
     SistemaContax.Params.Add('Password='+LowerCase('erp'+IntToStr(35269147)));
     SistemaContax.Params.Add('TransIsolation=ReadCommited');
     SistemaContax.Params.Add('ConnectionName=PGEConnection');
     SistemaContax.Params.Add('GetDriverFunc=getSQLDriverPOSTGRESQL');
//     SistemaContax.Params.Add('LibraryName=dbexppge.dll');
     SistemaContax.Params.Add('LibraryName=dbexppgsql.dll');
//     SistemaContax.Params.Add('VendorLib=libpq.dll');
     try
       SistemaContax.Open;
       result:=true;
     except
       Avisoerro('N�o foi poss�vel conectar o banco '+SistemaContax.Params[1]);
     end;
   end else
     result:=true;
end;

/////////////////////////////////////////////////////////////////////////////
function TFGeral.SendMime(const SMTPHost, Username, Password:string; const Mime: TMimeMess): string;
////////////////////////////////////////////////////////////////////////////////////////
var
   SMTP: TSMTPSend;
   s, t: string;
   sendOK: boolean;
begin
   Result := '';
   sendOK := false;
   SMTP := TSMTPSend.Create;
   try
// if you need SOCKS5 support, uncomment next lines:
//     SMTP.Sock.SocksIP := '127.0.0.1';
//     SMTP.Sock.SocksPort := '1080';
// if you need support for upgrade session to TSL/SSL,
//uncomment next lines:

    SMTP.AutoTLS := True;   // 12.01.11

// if you need support for TSL/SSL tunnel, uncomment next lines:
// 12.11.11 - ativado este FullSSL para teste Abra - nao funcionou e ainda estraga os
//            outros email como gmail
// 22.11.14 - recolocado devido a gmail da mettalum
//     if fGeral.EmailStmpcomSSL(username) then
//       SMTP.FullSSL := True;
// 02.06.16 - retirado primos...vamos ver se fica 'parelho'...
     SMTP.FullSSL := False;

     SMTP.TargetHost := Trim(SeparateLeft(SMTPHost, ':'));
     s := Trim(SeparateRight(SMTPHost, ':'));
//     if (s <> '') and (s <> SMTPHost) then
//       SMTP.TargetPort := s;
// 28.11.12 - seto aqui para nao mudar na pasta Synalist o smmtpsend.pas....
    if FGeral.GetConfig1AsString('PORTASMTP')<>'' then
      SMTP.TargetPort:=FGeral.GetConfig1AsString('PORTASMTP')
    else
      SMTP.TargetPort:='25';
//////////////
     SMTP.Username := Username;
     SMTP.Password := Password;
// 26.07.12
//     if SMTP.Login( FGeral.GetConfig1AsString('PORTASMTP') ) then
// 31.10.12 - apos atualizar acbr
     if SMTP.Login then
     begin
       if SMTP.MailFrom(GetEmailAddr(Mime.Header.From),Length(Mime.Lines.Text)) then
       begin
         s := Mime.Header.ToList.Text;
//////////////////////////////////////////////
// 04.02.14 - damama.com.br nao passa pelo 'rpc to'
//         {
         repeat
           t := GetEmailAddr(Trim(FetchEx(s, ',', '"')));
             if t <> '' then
               sendOK := SMTP.MailTo(t);
             if not sendOK then begin
               Avisoerro('Erro SMTP Mailto '+t+'|'+smtp.targethost+'|'+smtp.password+'|'+smtp.username+'.  Confirmar usu�rio e senha');
               Break;
             end;
         until s = '';
//         }
//////////////////////////////////////////////
         sendOK := SMTP.MailData(Mime.Lines);
         if (sendOK) then
         begin
//           result := sendOKString;
           result := 'OKString';
         end
         else
         begin
           result := 'Falha no envio do email: "' + SMTP.ResultString + '"';
         end;
       end else
         Avisoerro( SMtp.FullResult.GetText+';'+'Falha no envio : '+SMTP.TargetHost+' '+SMTP.TargetPort+' '+SMTP.Username+
                 ' '+SMTP.Password );

       SMTP.Logout;
     end else
         Avisoerro( SMtp.FullResult.GetText+';'+'Falha no LOGIN : '+SMTP.TargetHost+' '+SMTP.TargetPort+' '+SMTP.Username+
                 ' '+SMTP.Password );
//   finally
//     SMTP.Free;
   except
     Avisoerro('Falha : '+SMTP.TargetHost+' '+SMTP.TargetPort+' '+SMTP.Username+
                 ' '+SMTP.Password )
   end;
   SMTP.Free;
end;

// 17.03.11
// envio de email usando cliente de email padr�o
procedure TFGeral.EmailClientePadrao(emaildestino,assunto,caminhoxml:string;CorpoEmail:TStrings);
/////////////////////////////////////////////////////////////////////////////////////////
const lf:string='%0D%0A';
var s,destino,mensagem: string;
    r:integer;
begin

    destino:=emaildestino;
    if trim(destino)='' then begin
      Avisoerro('Falta configurar o email de destino');
      exit
    end;
    Sistema.Beginprocess('Usando cliente de email padr�o');
//    Sistema.Beginprocess('Enviando email');
{
    mensagem:='Funcion�rio : '+inttostr(codfun)+' - '+nome+lf;
    mensagem:=mensagem+' '+lf;
    if tipo='A' then
      mensagem:=mensagem+'Funcion�rio ADMITIDO.  Configura��o necess�ria:'+lf
    else if tipo='D' then
      mensagem:=mensagem+'Funcion�rio DEMITIDO.  Retirar configura��o existente:'+lf
    else if tipo='T' then
      mensagem:=mensagem+'Funcion�rio TRANSFERIDO.  Checar configura��o:'+lf;
    if copy(acessos,1,1)='S' then begin
      mensagem:=mensagem+'- necessita acesso a rede interna '+lf;
    end;
    if copy(acessos,2,1)='S' then begin
      mensagem:=mensagem+'- necessita acesso a internet '+lf;
    end;
///
}
//   mensagem := Corpoemail.Text;
   mensagem:='';
   for r:=0 to Corpoemail.Count-1 do begin
     mensagem := Mensagem+ FGeral.TiraBarra(Corpoemail.Strings[r],'&') + lf;
   end;

   mensagem := mensagem + lf ;

   mensagem := mensagem + 'Local de onde anexar o xml : '+ lf;

   mensagem := mensagem + lf ;

   mensagem := mensagem + caminhoxml + lf;

   s := 'mailto:'+destino+
            '?Subject=' + Assunto +
            '&Body='+mensagem;
//       ShellExecute(Handle, 'open', PChar(s), nil, nil, SW_SHOW);
// 27.04.11
//       ShellExecute(GetDesktopWindow, 'open', PChar('msimn.exe'), PChar(s), nil, SW_SHOW);
       ShellExecute(GetDesktopWindow, 'open', PChar(s), nil , nil, SW_SHOW);

//       ShellExecute(Handle, 'open', PChar(s), nil, nil, SW_HIDE);
//    Sistema.Endprocess('');


end;

/////////////////////////////////////////////////
// 18.03.11 - Gravando dados em arquivo do excel
////////////////////////////////////////////////
procedure TFGeral.AtualizaExcel;
///////////////////////////////
var

   FileName                   : OleVariant;
   WBk                        : _Workbook;
   WS                         : _WorkSheet;
   SaveChanges                : OleVariant;
   LCID: Cardinal;
   linha,coluna:integer;

begin
  LCID := GetUserDefaultLCID;


//caminho da planilha a ser alterada
   FileName:= 'E:\Documents and Settings\Andr�\Meus documentos\Clientes\tarefas2010.xls';

 //inicia o excel
   Excel.Connect;
   linha:=38;
   coluna:=5;

//abrindo uma pasta do excel que voc� pretende manipular
      WBk := Excel.Workbooks.Open( Filename, EmptyParam, EmptyParam,
                                EmptyParam, EmptyParam, EmptyParam,
                                EmptyParam, EmptyParam, EmptyParam,
                                EmptyParam, EmptyParam, EmptyParam,
                                EmptyParam, LCID );
      WS := WBk.Worksheets.Item['NF-23-Coamig'] as _Worksheet;
      WS.Activate(LCID);

      WS.Cells.Item[ linha, coluna ].Value := 1234.23;
      WS.Cells.Item[ linha, coluna+1].Value := '1234.23';
      WS.Cells.Item[ linha+1, coluna ].Value := 'texto01';
      WS.Cells.Item[ linha+1, coluna+1].Value := 'texto02';

      //salva as aaltera��es e fecha o excel.

//      SaveChanges:= True;
//      WBk.Close(SaveChanges, EmptyParam, EmptyParam, LCID);

//      Excel.Quit;

end;


//function ConvertToUTCDateString(const date: TDateTime): string;
//begin
//   DateTimeToString(result, 'yyyymmdd"T"hhnnss"Z"', DateTimeToLocalDateTime(date));
//end;

////////////////////////////////////////////////////////////////////////////
{
function SendMailCalendarEvent(const MailFrom, MailTo,Subject, SMTPHost, user, pass, Summary, Location,Description: string;
   const FromDate, ToDate : TDateTime): string;
var
   mime: TMimemess;
   mimePart, mimeHtml: TMimepart;
   i: integer;
   t: TStringList;
begin
   result := '';
   mime := TMimemess.create;
   t := TStringList.Create();
   t.Add('BEGIN:VCALENDAR');
     t.Add('PRODID:HourMailer');
     t.Add('VERSION:2.0');
     t.Add('METHOD:REQUEST');
     t.Add('BEGIN:VEVENT');

     t.Add('ATTENDEE;ROLE=REQ-PARTICIPANT;RSVP=TRUE:MAILTO:' + MailTo);
       t.Add('ORGANIZER:MAILTO:' + MailFrom);
       t.Add('DTSTART:' + ConvertToUTCDateString(FromDate));
       t.Add('DTEND:' + ConvertToUTCDateString(ToDate));
       t.Add('TRANSP:OPAQUE');
       t.Add('SEQUENCE:0');
       t.Add('UID:' + ConvertToUTCDateString(Now) + '@HourMailer');
       t.Add('DTSTAMP:' + ConvertToUTCDateString(Now));
       t.Add('SUMMARY:' + CharsetConversion(Summary,GetCurCP, UTF_8));
       if not(Location = '') then
       begin
         t.Add('LOCATION:' + CharsetConversion(Location,GetCurCP, UTF_8));
       end;
       if not(description = '') then
       begin
         t.Add('DESCRIPTION:' + CharsetConversion(description, GetCurCP, UTF_8));
       end;
       t.Add('PRIORITY:5');
       t.Add('X-MICROSOFT-CDO-IMPORTANCE:1');
       t.Add('CLASS:PUBLIC');
       t.Add('BEGIN:VALARM');
         t.Add('TRIGGER:-PT15M');
         t.Add('ACTION:DISPLAY');
         t.Add('DESCRIPTION:Reminder');
       t.Add('END:VALARM');
     t.Add('END:VEVENT');
     t.Add('END:VCALENDAR');
   try
     mimePart := mime.AddPart(nil);
     with mimePart do
     begin
       t.SaveToStream(DecodedLines);
       Primary := 'text';
       Secondary := 'calendar; method=REQUEST';
       CharsetCode := GetCurCP;
       EncodingCode := ME_8BIT;
       EncodePart;
       CharsetCode := UTF_8;
       EncodePartHeader;
     end;

     mime.header.from := MailFrom;
     mime.header.tolist.add(MailTo);
     mime.header.subject := Subject;
     mime.EncodeMessage;
//     result := SendMime(SMTPHost, user, pass, mime);
     result:='';
   finally
     mime.free;
     t.Free;
   end;
   }
////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////
{
procedure TFGeral.EnviaEmailAcbr(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sFileName: AnsiString);


var
  smtp: TSMTPSend;
  msg_lines: TStringList;
begin
  msg_lines := TStringList.Create;
  smtp := TSMTPSend.Create;
  try
    msg_lines.LoadFromFile(sFileName);
    msg_lines.Insert(0, 'From: ' + sFrom);
    msg_lines.Insert(1, 'To: ' + sTo);

    smtp.UserName := sSmtpUser;
    smtp.Password := sSmtpPasswd;

    smtp.TargetHost := sSmtpHost;
    smtp.TargetPort := sSmtpPort;

//    AddToLog('SMTP Login');
    if not smtp.Login() then
      raise ESMTP.Create('SMTP ERROR: Login:' + smtp.EnhCodeString);
//    AddToLog('SMTP StartTLS');
    if not smtp.StartTLS() then
      raise ESMTP.Create('SMTP ERROR: StartTLS:' + smtp.EnhCodeString);

//    AddToLog('SMTP Mail');
    if not smtp.MailFrom(sFrom, Length(sFrom)) then
      raise ESMTP.Create('SMTP ERROR: MailFrom:' + smtp.EnhCodeString);
    if not smtp.MailTo(sTo) then
      raise ESMTP.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString);
    if not smtp.MailData(msg_lines) then
      raise ESMTP.Create('SMTP ERROR: MailData:' + smtp.EnhCodeString);

//    AddToLog('SMTP Logout');
    if not smtp.Logout() then
      raise ESMTP.Create('SMTP ERROR: Logout:' + smtp.EnhCodeString);
//    AddToLog('OK!');
  finally
    msg_lines.Free;
    smtp.Free;
  end;
end;
}
////////////////////////////////////////////////////////////////////////////

{

///////////////////////////////////////////////////////////////////////
procedure TFGeral.ImprimeCupomFiscal(xtransacao,TipoMovimento: string);
///////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    cnpjcpf ,Nome , Endereco :string;
    vlrdesco,percdesco,totalitem,totalnf:currency;
    FPG : TACBrECFFormaPagamento ;   Necessita de uses ACBrECF
    modeloecf:TACBrECFModelo;


    function  AtivaEcf:boolean;
    /////////////////////////////
    begin
      try
         if trim( FGeral.GetConfig1AsString( 'PORTAECF1' ) ) <>'' then
            ACBrECF1.Porta := FGeral.GetConfig1AsString( 'PORTAECF1' ) ;

         if trim( FGeral.GetConfig1AsString( 'MODELOECF1' ) ) = 'Pesquisar' then
            if not ACBrECF1.AcharECF(true,False) then
            begin
               Avisoerro('Nenhum ECF encontrado.') ;
               result:=false;
               exit ;
            end ;

         if trim( FGeral.GetConfig1AsString( 'MODELOECF1' ) ) = 'ecfBematech' then
           modeloecf:=(ecfBematech)
         else if  trim( FGeral.GetConfig1AsString( 'MODELOECF1' ) ) =  'ecfSweda' then
           modeloecf:=(ecfSweda)
         else if  trim( FGeral.GetConfig1AsString( 'MODELOECF1' ) ) =  'ecfNaoFiscal' then
           modeloecf:=(ecfNaoFiscal)
         else
           modeloecf:=(ecfEpson);
         ACBrECF1.IntervaloAposComando:=ACBrEcfBase.IntervaloAposComando;  // ver criar configuracoes disto
         ACBrECF1.TimeOut:=ACBrEcfBase.TimeOut;
         ACBrECF1.Modelo:=modeloecf;
         ACBrECF1.Device.Stop:=ACBrEcfBase.Device.Stop;
         ACBrECF1.Device.HandShake:=ACBrEcfBase.Device.HandShake;
         ACBrECF1.Device.HardFlow:=ACBrEcfBase.Device.HardFlow;
         ACBrECF1.Device.SoftFlow:=ACBrEcfBase.Device.SoftFlow;
         ACBrECF1.ArqLOG:=ACBrEcfBase.ArqLOG;

//         ACBrECF1.Device.ParamsString := AcbrEcfbase.Device.ParamsString ;



         ACBrECF1.Device.Serial
         ACBrECF1.Device.Baud
         ACBrECF1.Device.Data
         ACBrECF1.Device.Parity

         ACBrECF1.Ativar ;
         result:=ACBrECF1.Ativo ;


//         GravarINI ;
//       ver se usa rotina igual o coloque 'dentro do regedit do sac'
//         ver que parametros guardar no registro

//      finally
      except
//         Self.Enabled := True ;
//         cbxModelo.ItemIndex := Integer(ACBrECF1.Modelo) ;
//         cbxPorta.Text       := ACBrECF1.Porta ;
         result:=false ;
      end ;
    end;

    function AbreCupom:boolean;
    ///////////////////////////
    var Est : String ;
    begin
      Est := Estados[ ACBrECF1.Estado ] ;
//      if Acbrecf1.ModeloStr='NaoFiscal' then begin
//        Est := Estados[ estVenda ];
//        result:=true;
//      end;
        try
           ACBrECF1.TestaPodeAbrirCupom;
           result:=true;
        except
           Avisoerro('N�o foi poss�vel abrir Cupom.  Estado Atual � '+Est) ;
           result:=false;
        end;
//      end;
    end;

    function GetAliqIcmsECF(pericms:currency):string;
    ////////////////////////////////////////////////
    begin
      if pericms=0 then
        result:='N1'  // tabela NN,FF,SI,SN,SF,II
//        result:='NN'  // tabela NN,FF,SI,SN,SF,II
      else
        result:=Valortosql(pericms);
    end;

    function GetDescValorECF:string;
    ////////////////////////////////////////////////
    // '%' em percentual   $ - em valor
    begin
      result:='%';
    end;

    function GetDescAcres:string;
    ////////////////////////////////////////////////
    // 'A' - acrescimo  D - desconto
    begin
       result:='D';
    end;


    procedure SubtotalCupom;
    ////////////////////////
    var desc,obs:string;
    begin
      Desc := '0' ;
      Obs := '';

//      if InputQuery('Subtotaliza Cupom',
//                    'Digite Valor negativo para Desconto'+#10+
//                    'ou Valor Positivo para Acrescimo' , Desc ) then
         ACBrECF1.SubtotalizaCupom( StrToFloat(Desc), Obs );
    end;


    procedure EfetuarPagamento(valor:currency);
    /////////////////////////////////////////////
    var descricao,codigo:string;
    begin
// ver se 'faz menu' pra escolher a forma de pagamento ou cfe algum parametro do cliente
// ou da venda j� define se � DUPLICATAS, CARTAO ,etc
      descricao:='DUPLICATAS';
      if InputQuery('Pesquisa Descri��o Forma Pagamento',
                'Entre com a Descri��o a Localizar ou Cadastrar(Bematech)',
                Descricao) then
     FPG := ACBrECF1.AchaFPGDescricao( Descricao ) ;

     if FPG = nil then
        raise Exception.Create('Forma de Pagamento: '+Descricao+
                               ' n�o encontrada') ;

     Codigo := FPG.Indice ;

//      Bematech permite cadastrar formas de Pagamento dinamicamente
//     if (ACBrECF1.ModeloStr = 'Bematech') and
//        (pos( FPG.Descricao, mFormas.Text ) = 0) then
//        CarregaFPG ;

      ACBrECF1.EfetuaPagamento( Codigo, Valor , '' ,true );

    end;

    procedure FecharCupom;
    //////////////////////
    Var
      Obs : String ;
      IndiceBMP : String;
    begin
//      Obs := 'Componentes ACBr|http://acbr.sourceforge.net' ;
      Obs := 'Storolli & Cia Ltda|Componentes ACBr' ;
      IndiceBMP :=  '0';
      begin
//         if (ACBrECF1.Modelo = ecfDaruma) and (ACBrECF1.MFD) then
//           if Not InputQuery('Impressao de imagem BMP ',
//                      'Digite o Indice do BMP que deseja utilizar' ,
//                       IndiceBMP ) then
//            Exit;

         Obs := StringReplace(Obs,'|',#10,[rfReplaceAll,rfIgnoreCase]) ;
         ACBrECF1.FechaCupom( Obs, StrToIntDef(IndiceBMP, 0) );
      end ;
    end;



/////////////////////////
begin
/////////////////////////

  Q:=Sqltoquery('select * from movestoque inner join movesto on ( moes_transacao=move_transacao )'+
                ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                ' where move_status=''N'''+
                ' and move_tipomov='+Stringtosql( TipoMovimento )+
                ' and moes_tipomov='+Stringtosql( TipoMovimento )+
                ' and move_transacao='+Stringtosql(xtransacao) );
  totalnf:=0;
  if not Q.eof then begin
// ativar , abrir...  ;;;
    Sistema.beginprocess( 'Ativando ECF' );
    if not AtivaECF then begin
      FGeral.FechaQuery(Q);
      Sistema.endprocess('N�o foi poss�vel ativar ECF');
      exit;
    end;
//    if Acbrecf1.ModeloStr<>'ecfNaoFiscal' then begin
//    end;

    cnpjcpf:=FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('moes_tipo_codigo').Asinteger,Q.fieldbyname('moes_tipocad').AsString);
    Nome:=FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').Asinteger,Q.fieldbyname('moes_tipocad').AsString,'N');
    if Q.fieldbyname('moes_tipocad').AsString='F' then
      Endereco:=FFornece.GetEndereco(Q.fieldbyname('moes_tipo_codigo').Asinteger)
    else if Q.fieldbyname('moes_tipocad').AsString='U' then
      Endereco:=FUnidades.GetEndereco(strzero(Q.fieldbyname('moes_tipo_codigo').Asinteger,3))
    else
      Endereco:=FCadcli.GetEndereco(Q.fieldbyname('moes_tipo_codigo').Asinteger);

    ACBrECF1.Consumidor.AtribuiConsumidor(cnpjcpf ,Nome , Endereco );
    ACBrECF1.IdentificaConsumidor( ACBrECF1.Consumidor.Documento, ACBrECF1.Consumidor.Nome, ACBrECF1.Consumidor.Endereco );

//    ACBrECF1.AbreNaoFiscal( ACBrECF1.Consumidor.Documento);

    percdesco:=Q.fieldbyname('moes_perdesco').ascurrency;
    totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,2);
    totalnf:=Q.fieldbyname('moes_vlrtotal').Ascurrency;
    if Q.fieldbyname('moes_perdesco').ascurrency>0 then
       vlrdesco:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100),2)
    else
       vlrdesco:=0;
  end;

 Sistema.beginprocess( 'Abrindo cupom' );
      if not AbreCupom then begin
        FGeral.FechaQuery(Q);
        Sistema.endprocess('');
        exit;
      end;
  Sistema.beginprocess( 'Enviando itens' );
  while not Q.eof do begin
    ACBrECf1.VendeItem(Q.fieldbyname('move_esto_codigo').AsString,
                       Ups( Q.fieldbyname('esto_descricao').AsString ),
                       GetAliqIcmsECF(Q.fieldbyname('move_aliicms').Ascurrency),
                       Q.fieldbyname('move_qtde').AsCurrency,
                       Q.fieldbyname('move_venda').AsCurrency,
                       vlrdesco,
                       Q.fieldbyname('esto_unidade').AsString,
                       GetDescValorECF,
                       GetDescAcres,
                         );

    Q.Next;
  end;
  if totalnf>0 then  begin
    SubtotalCupom;
// ver aqui rotina 'dos pagamentos'...
    EfetuarPagamento(totalnf);
    FecharCupom;
  end;
  FGeral.FechaQuery(Q);
  ACBrECF1.Desativar ;

end;

}

function TFGeral.ConfiguradoECF: boolean;
///////////////////////////////////////////
begin
   if ( (Global.topicos[1021]) ) and ( FGeral.GetConfig1AsInteger('ConfMovECF')>0 ) then
     result:=true
   else
     result:=false;
end;


procedure TFGeral.GravarINI;
begin

end;

procedure TFGeral.LerINI;
begin
end;
/// 25.10.11
function TFGeral.GetConsumidorFinal(codigo: integer;  tipocad: string): string;
///////////////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
begin
  result:='N';
  if tipocad='C' then begin
    Q:=sqltoquery('select Clie_consfinal,Clie_tipo from clientes where clie_codigo='+inttostr(codigo));
    if not Q.eof then
//      if (Q.fieldbyname('clie_consfinal').asstring='S') or (Q.fieldbyname('clie_tipo').asstring='F') then
// 30.09.16
      if (Q.fieldbyname('clie_consfinal').asstring='S') then
        result:='S';
    FechaQuery(Q);
  end;
end;

function TFGeral.GetPessoaFisica(codigo: integer; tipocad: string): string;
///////////////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
begin
  result:='N';
  if tipocad='C' then begin
    Q:=sqltoquery('select Clie_tipo from clientes where clie_codigo='+inttostr(codigo));
    if not Q.eof then begin
      if Q.fieldbyname('Clie_tipo').asstring='F' then
        result:='S';
    end;
    FechaQuery(Q);
  end;
end;

// 07.03.2012
///////////////////////////////
procedure TFGeral.AbreEstoque;
//////////////////////////////
var xsql:string;
begin
// infelizmente da pau na hora de gravar..ter� que criar novo campo no estoque
// que contenha as unidades onde ele 'est� cadastrado'
// 25.03.12 - creio que agora 'a coisa vai'...
  if Global.Topicos[1025] then begin
    if Arq.TEstoque.Active then Arq.TEstoque.Close;
//    xsql:= 'select estoque.*,esqt_status,esqt_unid_codigo from estoque inner join estoqueqtde on (esqt_esto_codigo=esto_codigo ) '+
//           ' where esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
//           ' and esqt_status=''N'''+
//           ' order by esto_descricao';
//    xsql:= 'select * from estoqueqtde inner join estoque on (esqt_esto_codigo=esto_codigo ) '+
//           ' where esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
//           ' and esqt_status=''N'''+
//           ' order by esto_descricao';
//    Arq.TEstoque.CommandText:=xsql;
{
    Arq.TEstoque.JoinType:=jtinner;
    Arq.TEstoque.JoinField:='esto_codigo';
    Arq.TEstoque.JoinedTable:='estoqueqtde';
    Arq.TEstoque.JoinedField:='esqt_esto_codigo';
    Arq.TEstoque.Condicao:='esqt_status=''N'' and esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade);
    Arq.TEstoque.Open;
}

//    Arq.TEstoque.Filter:='esqt_status=''N'' and esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade);
//    Arq.TEstoque.Filtered:=true;

    Arq.TEstoque.Open;

//    Arq.TEstoque.OpenWith('esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade),Arq.TEstoque.Ordenacao);
  end else
    if not Arq.TEstoque.Active then Arq.TEstoque.Open;
end;

////////////////// 06.09.12
function TFGeral.GetIPInternet(var HostName, IPaddr,  WSAErr: string): Boolean;
/////////////////////////////////////////////////////////////////////////////////////
type
  Name = array[0..100] of AnsiChar;
  PName = ^Name;
var
  HEnt: pHostEnt;
  HName: PName;
  WSAData: TWSAData;
  i: Integer;
begin
  Result := False;
  if WSAStartup($0101, WSAData) <> 0 then begin
    WSAErr := 'Winsock n�o est� respondendo';
    Exit;
  end;
  IPaddr := '';
  New(HName);
  if GetHostName(HName^, SizeOf(Name)) = 0 then
  begin
    HostName := StrPas(HName^);
    HEnt := GetHostByName(HName^);
    for i := 0 to HEnt^.h_length - 1 do
      IPaddr :=  Concat(IPaddr, IntToStr(Ord(HEnt^.h_addr_list^[i])) + '.');
    SetLength(IPaddr, Length(IPaddr) - 1);
    Result := True;
  end
  else begin
   case WSAGetLastError of
    WSANOTINITIALISED:WSAErr:='WSANotInitialised';
    WSAENETDOWN      :WSAErr:='WSAENetDown';
    WSAEINPROGRESS   :WSAErr:='WSAEInProgress';
   end;
  end;
  Dispose(HName);
  WSACleanup;
end;


function TFGeral.Func_GetIP_Net : string;
/////////////////////////////////////////
type
TaPInAddr = array [0..10] of PInAddr;
PaPInAddr = ^TaPInAddr;
var
phe : PHostEnt;
pptr : PaPInAddr;
Buffer : array [0..63] of Ansichar;
I : Integer;
GInitData : TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result := '\';
  GetHostName(Buffer, SizeOf(Buffer));
  phe :=GetHostByName(buffer);
  if phe = nil then Exit;
  pptr := PaPInAddr(Phe^.h_addr_list);
  I := 0;
  while pptr^[I] <> nil do begin
  result:=StrPas(inet_ntoa(pptr^[I]^));
  result := StrPas(inet_ntoa(pptr^[I]^));
  Inc(I);
  end;
  WSACleanup;
end;

function TFGeral.Func_GetIP_Lan:string;
/////////////////////////////////////////
var
WSAData: TWSAData;
HostEnt: PHostEnt;
Name:string;
begin
  WSAStartup(2, WSAData);
  SetLength(Name, 255);
  Gethostname(PAnsiChar(Name), 255);
  SetLength(Name, StrLen(PChar(Name)));
  HostEnt := gethostbyname(PAnsiChar(Name));
  with HostEnt^ do
  begin
  Result := Format('%d.%d.%d.%d\', [Byte(h_addr^[0]),Byte(h_addr^[1]), Byte(h_addr^[2]),Byte(h_addr^[3])]);
  end;
  WSACleanup;
end;
{
procedure TForm1.Button1Click(Sender: TObject);
begin
label1.Caption := \'IP da Internet \' + Func_GetIP_Net;
label2.Caption := \'IP da Local \' + Func_GetIP_Lan;
end;
}
////////  26.11.12 -grava��o de nota de saida a partir do xml
// 01.03.16 - mais ajustes para prever nfe de entrada emitida pelo proprio emitente como devolucoes de venda
procedure TFGeral.GravaNotacomxml(NotaFiscal: TACBrNFe;xarquivoxml,xunidade:string;Aviso:boolean=false);
////////////////////////////////////////////////////////////////////////////////////////////////////////
type TMunicipios=record
     nome,uf,cep,codigoibge,codigopais,nomepais:string;
     codigo:integer;
end;
var Transacao:string;
    Q,QT,TEstoque,QCadEstoque:TSqlquery;
    i,p,moes_tipo_codigo,moes_cida_codigo:integer;
    xXML:TStringList;
    LIstaMunicipios:TList;
    PMunicipios:^TMunicipios;
    moes_tipocad,moes_estado,TiposFornec,cnpjcpfemitente:string;

    function GetTipoMovimento(xcfop:string):string;
    ///////////////////////////////////////////////
    begin
// 20.08.15 - SM - FAma digital - importar xmls de entrada e saida
      if cnpjcpfemitente=NotaFiscal.NotasFiscais.Items[0].NFe.Emit.CNPJCPF then begin
        if pos( trim(xcfop),'5101/6101/5102/6102/5405/6404/5401/5403' ) > 0 then
          result:=Global.CodVendaDireta
        else if pos( trim(xcfop),'5201/6201/5202/6202' ) > 0 then
          result:=Global.CodDevolucaoCompra
        else if pos( trim(xcfop),'1101/2101/1102/2102/1405/1404/1401/1403' ) > 0 then
          result:=Global.CodCompra
        else if pos( trim(xcfop),'1201/2201/1202/2202/1411/2411' ) > 0 then
          result:=Global.CodDevolucaoVenda
// 10.03.16
        else if pos( trim(xcfop),'1915/2915/' ) > 0 then
          result:=Global.CodRetornoRemessaConserto
        else
          result:=Global.CodVendaDireta;
      end else begin
        if pos( trim(xcfop),'5101/6101/5102/6102/5405/6404/5401/5403' ) > 0 then
          result:=Global.CodCompra
        else if pos( trim(xcfop),'5201/6201/5202/6202' ) > 0 then
          result:=Global.CodDevolucaoVenda
        else
          result:=Global.CodCompra;
      end;
// ir vendo outros cfops e respectivos tipos de movimento...
    end;

// 20.08.15 - Sm - Fama Digital
////////////////////////////////
    function ConverteCFOP( xcfop:string ):string;
    //////////////////////////////////////////////
    begin
      if cnpjcpfemitente=NotaFiscal.NotasFiscais.Items[0].NFe.Emit.CNPJCPF then begin
          result:=xcfop;
      end else begin
        if trim(xcfop)='5101' then result:='1101'
        else if trim(xcfop)='6101' then result:='2101'
        else if trim(xcfop)='5102' then result:='1102'
        else if trim(xcfop)='6102' then result:='2102'
        else if trim(xcfop)='5405' then result:='1403'
        else if trim(xcfop)='6404' then result:='2403'
        else if trim(xcfop)='6403' then result:='2403'
        else if trim(xcfop)='5401' then result:='1401'
        else if trim(xcfop)='5403' then result:='1403'
        else if trim(xcfop)='5201' then result:='1201'
        else if trim(xcfop)='6201' then result:='2201'
        else if trim(xcfop)='5202' then result:='1202'
        else if trim(xcfop)='6202' then result:='2202'
        else if copy(trim(xcfop),1,1)='5' then result:='1'+copy(trim(xcfop),2,3)
        else if copy(trim(xcfop),1,1)='6' then result:='2'+copy(trim(xcfop),2,3)
        else if copy(trim(xcfop),1,1)='7' then result:='3'+copy(trim(xcfop),2,3)
        else result:=xcfop;
      end;
    end;


    function Getcodigomov( xtipomov:string ):integer;
    /////////////////////////////////////////////////
    var QM:Tsqlquery;
    begin
      QM:=sqltoquery('select * from confmov where comv_tipomovto='+Stringtosql(xtipomov));
      if not QM.eof then
        result:=QM.fieldbyname('comv_codigo').asinteger
      else
        result:=1;
      Qm.close;
    end;

    procedure LeMunicipios;
    ///////////////////////
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select * from cidades');
      ListaMunicipios:=Tlist.create;
      while not Q.eof do begin
        New(PMunicipios);
        PMunicipios.codigo:=Q.fieldbyname('cida_codigo').asinteger;
        PMunicipios.nome:=Ups(q.fieldbyname('cida_nome').asstring );
        PMunicipios.uf:=q.fieldbyname('cida_uf').asstring;
        ListaMunicipios.add( PMunicipios );
        Q.Next;
      end;
      Q.close;Freeandnil(q);
    end;

    procedure AdicionaMunicipio;
    ////////////////////////////
    var Q:TSqlquery;
        name:string;
    begin
        Q:=sqltoquery('select * from cidades where cida_codigo='+inttostr(PMUnicipios.codigo));
        if Q.eof then begin
          Sistema.Insert('cidades');
          Sistema.SetField('cida_codigo',PMUnicipios.codigo);
          Sistema.SetField('cida_nome',PMUnicipios.nome);
          Sistema.SetField('cida_uf',PMUnicipios.uf);
          Sistema.SetField('cida_regi_codigo','001');
          Sistema.SetField('cida_cep',PMunicipios.cep);
          Sistema.SetField('cida_codigoibge',PMunicipios.codigoibge);
          Sistema.SetField('cida_codigopais',PMunicipios.codigopais);
          Sistema.SetField('cida_nomepais',PMunicipios.nomepais);
          Sistema.post;
          Sistema.commit;
        end;
        Q.Close;
    end;


    function GetCodigoMunicipio(nomecidade,ufcidade:string):integer;
    ///////////////////////////////////////////////////////////////
    var p,codigo:integer;
        achou:boolean;

        function Maior:integer;
        var x,maior:integer;
        begin
          maior:=0;
          for x:=0 to LIstaMunicipios.count-1 do begin
            PMunicipios:=ListaMunicipios[x];
            if PMunicipios.codigo>maior then
              maior:=PMunicipios.codigo;
          end;
          result:=maior;
        end;

    begin
    /////////////////////////////////////////////
      achou:=false;
      for p:=0 to LIstaMunicipios.count-1 do begin
        PMunicipios:=ListaMunicipios[p];
//        if (PMunicipios.nome=ups(nomecidade) )  and (PMunicipios.uf=ufcidade )then begin
// 09.06.08
        if (ups(PMunicipios.nome)=ups(nomecidade) )  and (uppercase(PMunicipios.uf)=uppercase(ufcidade) )then begin
          result:=PMunicipios.codigo;
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
//        Q:=sqltoquery('select max(muni_codigo) as ultimo from municipios');
        codigo:=Maior+1;
//        Q.close;Freeandnil(Q);
        New(PMunicipios);
        PMunicipios.codigo:=codigo;
        PMunicipios.nome:=nomecidade;
        PMunicipios.uf:=ufcidade;
        PMunicipios.cep:=inttostr( NotaFiscal.NotasFiscais.Items[0].NFe.Emit.EnderEmit.CEP );
        PMunicipios.codigoibge:=inttostr( NotaFiscal.NotasFiscais.Items[0].NFe.Emit.EnderEmit.cMun );
        PMunicipios.codigopais:=inttostr( NotaFiscal.NotasFiscais.Items[0].NFe.Emit.EnderEmit.cPais );
        PMunicipios.nomepais:= NotaFiscal.NotasFiscais.Items[0].NFe.Emit.EnderEmit.xPais ;
        ListaMunicipios.Add( PMunicipios );
// salva na lista para no final gravar tdos os novos municipios cadastrados
        result:=codigo;
      end;
    end;


    procedure IncluiCliente;
    ///////////////////////
    var sql,cod:string;
        Q:TSqlquery;
        Codigo:integer;
    begin
        Sql:='Select Max(Clie_Codigo) As Proximo From Clientes';
        Q:=SqlToQuery(Sql);
        if Q.FieldByName('Proximo').AsInteger>0 then begin
            Cod:=Trim(Q.FieldByName('Proximo').AsString);
            Cod:=LeftStr(Cod,Length(Cod)-1);
        end;
        Q.Close; FreeAndNil(Q);
        Codigo:=Inteiro(Cod)+1;
        Cod:=IntToStr(Codigo);
        Codigo:=Inteiro(Cod+GetDigito(Cod,'MOD'));
        with NotaFiscal.NotasFiscais.Items[0].NFe do begin
          Sistema.Insert('clientes');
          Sistema.SetField('clie_codigo',codigo);
          Sistema.SetField('clie_nome',copy(SpecialCase(Dest.xNome),1,40));
          Sistema.SetField('clie_razaosocial',copy(SpecialCase(Dest.xNome),1,40));
          if length(trim(Emit.CNPJCPF))=11 then
//          Sistema.SetField('clie_tipo',GetTipo(Emit.CNPJCPF));
            Sistema.SetField('clie_tipo','F')
          else
            Sistema.SetField('clie_tipo','J');
          Sistema.SetField('clie_cnpjcpf',Dest.cnpjcpf);
          Sistema.SetField('clie_rgie',Dest.IE);
          Sistema.SetField('clie_sexo','M');
          Sistema.SetField('clie_uf',Dest.EnderDest.UF);
          Sistema.SetField('clie_endres',copy(SpecialCase(Dest.Enderdest.xLgr)+', '+Dest.EnderDest.nro,1,40));
  //        Sistema.SetField('clie_endrescompl',PClifor.forn_endereco);
          Sistema.SetField('clie_bairrores',SpecialCase(copy(Dest.EnderDest.xBairro,1,30)));
          Sistema.SetField('clie_cida_codigo_res',GetCodigoMunicipio(Dest.EnderDest.xMun,Dest.EnderDest.UF));
// 13.06.15
          Sistema.SetField('clie_cidade',Dest.EnderDest.xMun);
          Sistema.SetField('clie_cepres',inttostr(Dest.EnderDest.CEP));
          if copy(Dest.EnderDest.fone,1,1)='4' then
            Sistema.SetField('clie_foneres','0'+Dest.EnderDest.fone)
          else
            Sistema.SetField('clie_foneres',Dest.EnderDest.fone);
//          Sistema.SetField('clie_email',Emit.EnderEmit....);
          Sistema.SetField('clie_endcom',copy(SpecialCase(Dest.EnderDest.xLgr)+', '+Dest.EnderDest.nro,1,50));
          Sistema.SetField('clie_bairrocom',SpecialCase(copy(Dest.EnderDest.xBairro,1,30)));
          Sistema.SetField('clie_cida_codigo_com',GetCodigoMunicipio(Dest.EnderDest.xMun,Dest.EnderDest.UF));
          Sistema.SetField('clie_cepcom',inttostr(Dest.EnderDest.CEP));
          if copy(Dest.EnderDest.fone,1,1)='4' then
            Sistema.SetField('clie_fonecom','0'+Dest.EnderDest.fone)
          else
            Sistema.SetField('clie_fonecom',Dest.EnderDest.fone);
//          Sistema.SetField('clie_contacontabil',PClifor.forn_contacontabil);
          Sistema.SetField('clie_situacao','N');
          Sistema.SetField('clie_dtcad',Sistema.hoje);
          Sistema.SetField('clie_repr_codigo',1);
          Sistema.SetField('clie_unid_codigo',xUnidade);
          Sistema.SetField('clie_usua_codigo',Global.Usuario.Codigo);
          Sistema.SetField('clie_contribuinte','S');
          Sistema.SetField('clie_obs','IMPXML NF '+inttostr(NotaFiscal.NotasFiscais.Items[0].NFe.Ide.nNF));
  //        Sistema.SetField('clie_caractrib varchar(1)
          Sistema.Post();
          Sistema.Commit;
        end;
    end;

//////////////////////////////////////////////////
// 11.06.15
    procedure IncluiFornec;
    ///////////////////////
    var sql,cod:string;
        Q:TSqlquery;
        Codigo:integer;
    begin
        Sql:='Select Max(Forn_Codigo) As Proximo From Fornecedores';
        Q:=SqlToQuery(Sql);
        if Q.FieldByName('Proximo').AsInteger>0 then begin
            Cod:=Trim(Q.FieldByName('Proximo').AsString);
            Cod:=LeftStr(Cod,Length(Cod)-1);
        end;
        Q.Close; FreeAndNil(Q);
        Codigo:=Inteiro(Cod)+1;
        Cod:=IntToStr(Codigo);
        Codigo:=Inteiro(Cod+GetDigito(Cod,'MOD'));
        with NotaFiscal.NotasFiscais.Items[0].NFe do begin
          Sistema.Insert('fornecedores');
          Sistema.SetField('forn_codigo',codigo);
          Sistema.SetField('forn_nome',copy(SpecialCase(Emit.xNome),1,40));
          Sistema.SetField('forn_razaosocial',copy(SpecialCase(Emit.xNome),1,40));
          Sistema.SetField('forn_cnpjcpf',Emit.cnpjcpf);
          Sistema.SetField('Forn_inscricaoestadual',Emit.IE);
          Sistema.SetField('forn_uf',Emit.EnderEmit.UF);
          Sistema.SetField('forn_endereco',copy(SpecialCase(Emit.EnderEmit.xLgr)+', '+Emit.EnderEmit.nro,1,40));
  //        Sistema.SetField('clie_endrescompl',PClifor.forn_endereco);
          Sistema.SetField('forn_bairro',SpecialCase(Emit.EnderEmit.xBairro));
          Sistema.SetField('forn_cida_codigo',GetCodigoMunicipio(Emit.EnderEmit.xMun,Emit.EnderEmit.UF));
          Sistema.SetField('forn_cep',inttostr(Emit.EnderEmit.CEP));
          if copy(Emit.EnderEmit.fone,1,1)='4' then
            Sistema.SetField('forn_fone','0'+copy(Emit.EnderEmit.fone,1,10))
          else
            Sistema.SetField('forn_fone',copy(Emit.EnderEmit.fone,1,11));
          Sistema.SetField('Forn_enderecoind',copy(SpecialCase(Emit.EnderEmit.xLgr)+', '+Emit.EnderEmit.nro,1,50));
          Sistema.SetField('Forn_cidaind_codigo',GetCodigoMunicipio(Emit.EnderEmit.xMun,Emit.EnderEmit.UF));
          if copy(Emit.EnderEmit.fone,1,1)='4' then
            Sistema.SetField('Forn_foneindustria','0'+copy(Emit.EnderEmit.fone,1,10))
          else
            Sistema.SetField('Forn_foneindustria',copy(Emit.EnderEmit.fone,1,11));
//          Sistema.SetField('clie_contacontabil',PClifor.forn_contacontabil);
          Sistema.SetField('Forn_datacad',Sistema.hoje);
////////////////////////          Sistema.SetField('forn_unid_codigo',xUnidade);
          Sistema.SetField('forn_usua_codigo',Global.Usuario.Codigo);
          Sistema.SetField('forn_contribuinte','S');
          Sistema.SetField('Forn_obstrocas','IMPXML NF '+inttostr(NotaFiscal.NotasFiscais.Items[0].NFe.Ide.nNF));
  //        Sistema.SetField('clie_caractrib varchar(1)
          Sistema.Post();
          Sistema.Commit;
        end;
    end;

////////////////////////////////////////////////////

    procedure IncluiEstoque;
    /////////////////////////
    var desc,ccodigo:string;
        Qe:TSqlquery;
        tam:integer;
    begin
      ccodigo:=NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.cProd;
// 05.07.13  - puxar o codigo com tamanho certo
      if Global.Topicos[1203] then begin
        tam:=FGeral.GetConfig1AsInteger('TAMESTOQUE');
          if tam>0 then
            ccodigo:=strzero(strtoint(ccodigo),tam);
      end;

      FNotaCompra.TrataNCM(trim( NotaFiscal.NotasFiscais.Items[0].NFe.Det[i].Prod.NCM),NotaFiscal.NotasFiscais.Items[0].NFe.Det[i].Prod.xprod,NotaFiscal.NotasFiscais.Items[0].NFe.Det[i].Imposto.IPI.pIPI);

      Sistema.Insert('estoque');
      Sistema.SetField('esto_codigo',ccodigo);
      desc:=copy(NotaFiscal.NotasFiscais.Items[0].NFe.Det[i].Prod.xProd ,1,50);
      desc:=FGeral.TiraBarra(desc,chr(39));
      Sistema.SetField('esto_descricao',Specialcase(desc));
      Sistema.SetField('esto_unidade',copy(NotaFiscal.NotasFiscais.Items[0].NFe.Det[i].Prod.uTrib ,1,05));
      Sistema.SetField('esto_embalagem',1);
      Sistema.SetField('esto_peso',0);
      Sistema.SetField('esto_emlinha','S');
      Sistema.SetField('esto_usua_codigo',Global.usuario.codigo);
      Sistema.SetField('esto_sugr_codigo',1);
      Sistema.SetField('esto_fami_codigo',1);
      Sistema.SetField('esto_grup_codigo',1);

      Sistema.SetField('esto_cipi_codigo',FCodigosipi.NcmtoCodigo( NotaFiscal.NotasFiscais.Items[0].NFe.Det[i].Prod.NCM ));
//      Sistema.SetField('esto_REFERENCIA',trim(Tabela.FieldByName('CODIGO').AsString));
      Sistema.Post();

     QE:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                  ' and esqt_esto_codigo='+stringtosql(ccodigo)+' and esqt_status=''N''');
     if Qe.eof then begin
            Sistema.Insert('EstoqueQtde');
            Sistema.Setfield('esqt_status','N');
            Sistema.Setfield('esqt_unid_codigo',xUnidade);
            Sistema.Setfield('esqt_esto_codigo',ccodigo);
            Sistema.Setfield('esqt_qtde',0);
            Sistema.Setfield('esqt_qtdeprev',0);
            Sistema.Setfield('esqt_vendavis',NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.vUnCom);
            Sistema.Setfield('esqt_custo',0);
            Sistema.Setfield('esqt_custoger',0);
            Sistema.Setfield('esqt_customedio',0);
            Sistema.Setfield('esqt_customeger',0);
  //          Sistema.Setfield('esqt_dtultvenda',emissao);
//            Sistema.Setfield('esqt_dtultcompra',EdDtemissao.asdate);
//            Sistema.Setfield('esqt_desconto',QEstoqueQtde.fieldbyname('esqt_desconto').ascurrency);
//            Sistema.Setfield('esqt_basecomissao',QEstoqueQtde.fieldbyname('esqt_basecomissao').ascurrency);

            Sistema.Setfield('esqt_cfis_codigoest',GetSittDentro(Global.CodigoUnidade));
            Sistema.Setfield('esqt_cfis_codigoforaest',GetSittFora(Global.CodigoUnidade));
            Sistema.Setfield('esqt_sitt_codestado',GetSittDentro(Global.CodigoUnidade) );
            Sistema.Setfield('esqt_sitt_forestado',GetSittFora(Global.CodigoUnidade));
            Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
            Sistema.Post('');
     end;
     FGeral.FechaQuery(Qe);
     Sistema.Commit;

    end;

    procedure IncluiTransportadora;
    ///////////////////////////////
    var codigo:string;
    begin
//      codigo:=FGeral.GetProximoCodigoCadastro('transportadores','tran_codigo');
      codigo:=strzero(FGeral.getsequencial(1,'tran_codigo','C','transportadores'),3) ;
      Sistema.Insert('transportadores');
      Sistema.SetField('tran_codigo',codigo);
      Sistema.SetField('tran_nome',copy(NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Transporta.xNome ,1,40));
      Sistema.SetField('tran_razaosocial',copy(NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Transporta.xNome ,1,40));
      Sistema.SetField('tran_cnpjcpf', NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Transporta.CNPJCPF);
//      Sistema.SetField('tran_situacao character varying(1),
      Sistema.SetField('tran_inscricaoestadual', copy(NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Transporta.IE ,1,20));
//      Sistema.SetField('tran_inscricaomunicipal character varying(20),
//      Sistema.SetField('tran_regjuntacomercial character varying(20),
      Sistema.SetField('tran_endereco',copy(NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Transporta.xEnder ,1,40));  // character varying(40),
      Sistema.SetField('tran_bairro',copy(NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Transporta.xNome ,1,40));  // character varying(40),
//      Sistema.SetField('tran_cep',strtoint(NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Transporta.xNome))  // character varying(8),
//      Sistema.SetField('tran_cxpostal character varying(10),
      Sistema.SetField('tran_cida_codigo',1  );   // numeric(5,0) NOT NULL,
//      Sistema.SetField('tran_fone character',)   // varying(11),
//      Sistema.SetField('tran_fax character varying(11),
//      Sistema.SetField('tran_email character varying(40),
      Sistema.SetField('tran_placa',copy(NotaFiscal.NotasFiscais.Items[0].NFe.Transp.veicTransp.placa ,1,20)); // character varying(20),
//      Sistema.SetField('tran_ufplaca character varying(2),
//      Sistema.SetField('tran_contagerencial numeric(8,0),
      Sistema.SetField('tran_usua_codigo',Global.Usuario.Codigo); // numeric(3,0) NOT NULL,
//      Sistema.SetField('tran_comissao numeric(7,2),
//      Sistema.SetField('tran_proprio character varying(1),
//      Sistema.SetField('tran_cola_codigo character varying(4)
      Sistema.Post();
      Sistema.commit;
    end;


///////////////////

begin
///////////////////
{  // retirado em 11.06.15
  if pos( copy( NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.cfop,1,1 ) , '123' ) > 0 then begin
    Avisoerro('XML de nota de entrada.  N�o importado.');
    exit;
  end;
}
  Q:=Sqltoquery('select moes_numerodoc,moes_transacao from movesto where moes_numerodoc='+Inttostr(NotaFiscal.NotasFiscais.Items[0].NFe.Ide.nNF)+
                ' and moes_dataemissao='+Datetosql(NotaFiscal.NotasFiscais.Items[0].NFe.Ide.dEmi)+
                ' and moes_unid_codigo='+Stringtosql(xUnidade)+
                ' and moes_status='+Stringtosql('N'));
//                ' and moes_tipocad='+Stringtosql('C') );
  if not Q.Eof then begin
//    Avisoerro('Nota j� encontrada na transa��o '+Q.fieldbyname('moes_transacao').asstring+'.  N�o importado.');
     if aviso then
       FImportaNfe.Texto.Lines.Add('Nota j� encontrada na transa��o '+Q.fieldbyname('moes_transacao').asstring+'.  N�o importado.');
    exit;
  end;
  FGeral.FechaQuery(Q);
//  Sistema.Beginprocess('Lendo munic�pios');
  LeMunicipios;
///  Sistema.Endprocess('');

//  xXML:=TStringList.create;
//  if trim( NotaFiscal.NotasFiscais.Items[0].NFe.Emit.CNPJCPF )='' then begin
//     xXML.LoadFromFile(xarquivoxml);
//     NotaFiscal.NotasFiscais.Items[0].NFe.Dest.CNPJCPF:=FExpNfetxt.GetTag( 'CNPJ' ,copy(xXML.Text,pos('dest',xXML.Text),300) );
//  end;
  if trim( NotaFiscal.NotasFiscais.Items[0].NFe.Dest.CNPJCPF )='' then begin
    Avisoerro('N�o encontrado a tag referente o CNPJ/CPF neste xml');
    exit;
  end;
// 11.06.15 - prever fornecedores...
  TiposFornec:=Global.CodRemessaconserto+';'+Global.CodRemessaDemo+';'+Global.CodDevolucaoSaida+';'+
               Global.CodRemessaInd+';'+Global.CodVendaFornecedor+';'+Global.CodDevolucaoSimbolicaConsig+';'+
               Global.CodDevolucaoTributada;

// 20.08.15
  cnpjcpfemitente:=FUnidades.GetCnpjcpf(xunidade);
//  if pos( GetTipoMovimento(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.CFOP),TiposFornec )>0 then begin
  if NotaFiscal.NotasFiscais.Items[0].NFe.Emit.CNPJCPF<>cnpjcpfemitente then begin
    Q:=Sqltoquery('select * from fornecedores where forn_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Emit.CNPJCPF));
    if Q.Eof then begin
      IncluiFornec;
      Q:=Sqltoquery('select * from fornecedores where Forn_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Emit.CNPJCPF));
    end;
    moes_tipo_codigo:=Q.Fieldbyname('Forn_codigo').AsInteger;
    moes_estado:=Q.Fieldbyname('Forn_uf').AsString;
    moes_tipocad:='F';
    moes_cida_codigo:=Q.fieldbyname('Forn_cida_codigo').AsInteger;
  end else begin
    Q:=Sqltoquery('select * from clientes where Clie_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Dest.CNPJCPF));
    if Q.Eof then begin
      IncluiCliente;
      Q:=Sqltoquery('select * from clientes where Clie_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Dest.CNPJCPF));
  //    Avisoerro('Cpf/CNPJ '+NotaFiscal.NotasFiscais.Items[0].NFe.Dest.CNPJCPF+' n�o encontrado no cadastro de clientes.');
  //    exit;
    end;
    moes_tipo_codigo:=Q.Fieldbyname('Clie_codigo').AsInteger;
    moes_estado:=Q.Fieldbyname('Clie_uf').AsString;
    moes_tipocad:='C';
    moes_cida_codigo:=Q.fieldbyname('clie_cida_codigo_com').AsInteger;
  end;
  if trim(NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Transporta.CNPJCPF)<>'' then begin
    QT:=Sqltoquery('select * from transportadores where tran_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Transporta.CNPJCPF));
    if Qt.eof then begin
      IncluiTransportadora;
      QT:=Sqltoquery('select * from transportadores where tran_cnpjcpf='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Transporta.CNPJCPF));
    end;
  end else
    QT:=Sqltoquery('select * from transportadores where tran_cnpjcpf='+Stringtosql('9898981'));

    for i:=0 to NotaFiscal.NotasFiscais.Items[0].NFe.Det.Count-1 do begin

      QCadEstoque:=sqltoquery('select esto_codigo from estoque where esto_codigo='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.cProd));
      if QCadEstoque.eof then
        IncluiEstoque;
      FGeral.FechaQuery(QCadEstoque);
    end;


  ListaCstPerc:=TList.create;
// para dar eof..
/// Mestre
//{
    transacao:=GetTransacao;

    Sistema.Insert('Movesto');
    Sistema.SetField('moes_transacao',Transacao);
    Sistema.SetField('moes_operacao',GetOperacao);
    Sistema.SetField('moes_status','N');
    Sistema.SetField('moes_numerodoc',NotaFiscal.NotasFiscais.Items[0].NFe.Ide.nNF);
//    Sistema.SetField('moes_romaneio',Romaneio);
    Sistema.SetField('moes_tipomov',GetTipoMovimento(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.CFOP));
    Sistema.SetField('moes_comv_codigo',Getcodigomov(GetTipoMovimento(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.CFOP)) );
    Sistema.SetField('moes_unid_codigo',xUnidade);
    Sistema.SetField('moes_tipo_codigo',moes_tipo_codigo);
//    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
//    if pos(Tipomovimento,global.coddevolucaocompra+';'+global.coddevolucaocompraSemestoque+';'+Global.CodRemessaConserto+';'
//      +Global.CodRemessaDemo+';'+Global.CodDevolucaoSaida+';'+Global.CodRemessaInd+';'+TiposFornec)>0 then begin
//      Sistema.SetField('moes_estado',Cliente.ResultFind.fieldbyname('forn_uf').AsString);
//      Sistema.SetField('moes_tipocad','F');
//      Sistema.SetField('moes_cida_codigo',Cliente.ResultFind.fieldbyname('forn_cida_codigo').AsInteger);
//    end else begin
      Sistema.SetField('moes_estado',moes_estado);
      Sistema.SetField('moes_tipocad',moes_tipocad);
      Sistema.SetField('moes_repr_codigo',1);
      Sistema.SetField('moes_cida_codigo',moes_cida_codigo);
//    end;
    Sistema.SetField('moes_datalcto',Sistema.Hoje);
    campo:=Sistema.GetDicionario('movesto','moes_datasaida');
    if Campo.Tipo<>'' then begin
      Sistema.SetField('moes_datasaida',NotaFiscal.NotasFiscais.Items[0].NFe.Ide.dEmi);
      Sistema.SetField('moes_datamvto',NotaFiscal.NotasFiscais.Items[0].NFe.Ide.dEmi);
    end else
      Sistema.SetField('moes_datamvto',NotaFiscal.NotasFiscais.Items[0].NFe.Ide.dEmi);
    Sistema.SetField('moes_DataCont',NotaFiscal.NotasFiscais.Items[0].NFe.Ide.dEmi);
    Sistema.SetField('moes_dataemissao',NotaFiscal.NotasFiscais.Items[0].NFe.Ide.dEmi);
//    Sistema.SetField('moes_tabp_codigo',Tabela);
//    Sistema.SetField('moes_tabaliquota',FTabela.GetAliquota(Tabela));
    Sistema.SetField('moes_natf_codigo',ConverteCFOP( NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.CFOP) );
    Sistema.SetField('moes_freteciffob',NotaFiscal.NotasFiscais.Items[0].NFe.Transp.modFrete);
    Sistema.SetField('moes_valoricms',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vICMS);
    Sistema.SetField('moes_basesubstrib',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vBCST);
    Sistema.SetField('moes_valoricmssutr',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vST);
    Sistema.SetField('moes_frete',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vFrete);
    if IndPagtoStr( NotaFiscal.NotasFiscais.Items[0].NFe.ide.indPag ) = '0'  then
      Sistema.SetField('moes_vispra','V')
    else
      Sistema.SetField('moes_vispra','P');
    Sistema.SetField('moes_especie','NFE');
    Sistema.SetField('moes_serie',inttostr(NotaFiscal.NotasFiscais.Items[0].NFe.Ide.serie));
    if not qt.eof then
      Sistema.SetField('moes_tran_codigo',QT.fieldbyname('tran_codigo').asstring);
    Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('Moes_Perdesco',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vDesc);
    Sistema.SetField('Moes_Peracres',0);
//    Sistema.SetField('moes_remessas',remessas);
    Sistema.SetField('moes_mensagem',NotaFiscal.NotasFiscais.Items[0].NFe.InfAdic.infAdFisco+' '+
                                     NotaFiscal.NotasFiscais.Items[0].NFe.InfAdic.infCpl);
//    Sistema.SetField('moes_pedido',pedido);
    if NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Vol.Count>0 then begin
      Sistema.SetField('Moes_qtdevolume',NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Vol.Items[0].qVol);
      Sistema.SetField('Moes_especievolume',NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Vol.Items[0].esp);
      Sistema.SetField('moes_pesoliq',NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Vol.Items[0].pesoL);
      Sistema.SetField('moes_pesobru',NotaFiscal.NotasFiscais.Items[0].NFe.Transp.Vol.Items[0].pesoB);
    end;
//    if moes_clie_codigo=0 then   // 30,12,05
//      Sistema.SetField('moes_clie_codigo',Cliente.AsInteger)
//    else if moes_clie_codigo>0 then   // 30.12.05
//      Sistema.SetField('moes_clie_codigo',moes_clie_codigo);

    if NotaFiscal.NotasFiscais.Items[0].NFe.Cobr.Dup.Count>0 then
      Sistema.SetField('moes_fpgt_codigo',FCondpagto.GetCodigoCfeParcelas(NotaFiscal.NotasFiscais.Items[0].NFe.Cobr.Dup.Count));
    Sistema.SetField('moes_valoripi',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vIPI);
//    Sistema.SetField('moes_freteuni',Freteuni);
//    if (TipoMovimento=Global.CodContrato) and (pedido>0) then
//      Sistema.SetField('moes_nroobra',inttostr(pedido))
//    else
//      Sistema.SetField('moes_nroobra',inttostr(numero));
//    Sistema.SetField('moes_embarque',portoorigem);
//    Sistema.SetField('moes_destino',portodestino);
//    Sistema.SetField('moes_container',container);
//      Sistema.SetField('moes_repr_codigo2',Representante2);
//      Sistema.SetField('moes_percomissao',FRepresentantes.GetPerComissao(Representante) );
//      Sistema.SetField('moes_percomissao2',FRepresentantes.GetPerComissao(Representante2) );
//      Sistema.SetField('moes_percomissao',PerComissao );
//      Sistema.SetField('moes_percomissao2',PerComissao2 );
//    end;
    Sistema.SetField('moes_baseiss',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ISSQNtot.vBC);
    Sistema.SetField('moes_valorpis',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ISSQNtot.vPIS);
    Sistema.SetField('moes_valorcofins',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ISSQNtot.vCOFINS);
    Sistema.SetField('moes_valoriss',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ISSQNtot.vISS);
//    Sistema.SetField('moes_periss',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ISSQNtot.vBC);
    Sistema.SetField('moes_vlrservicos',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ISSQNtot.vServ);
////////////////////////////
//    Sistema.SetField('moes_funrural',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vServ);
//    Sistema.SetField('moes_cotacapital',valorcotacapital);
//    if MargemLucro>0 then
//      Sistema.SetField('Moes_PerMargem',MargemLucro);
// 24.03.11 - Lam. Sao Caetano - exportacao
//    campo:=Sistema.GetDicionario('movesto','moes_estadoex');
//    if Campo.Tipo<>'' then
//      Sistema.SetField('moes_estadoex',Ufembarque);
// 27.06.11 - Lam. Sao Caetano - exportacao
    campo:=Sistema.GetDicionario('movesto','moes_chavenferef');
    if ( Campo.Tipo<>'' ) and ( NotaFiscal.NotasFiscais.Items[0].NFe.Ide.NFref.Count>0 ) then
      Sistema.SetField('moes_chavenferef',NotaFiscal.NotasFiscais.Items[0].NFe.Ide.NFref.Items[0].refNFe);
//    if (codigomov=FGeral.GetConfig1Asinteger('ConfNfComple'))
//       and ( FGeral.GetConfig1Asinteger('ConfNfComple')>0 )
//       then begin
//      Sistema.SetField('moes_valoravista',0);
//      Sistema.SetField('moes_totprod',0);
//      Sistema.SetField('moes_valortotal',0);
//      Sistema.SetField('moes_vlrtotal',0);
//      Sistema.SetField('moes_baseicms',0);
//    end else begin
// 23.12.04
//      Sistema.SetField('moes_valoravista',valoravista);
      Sistema.SetField('moes_totprod',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vProd);
      Sistema.SetField('moes_valortotal',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vNF);
      Sistema.SetField('moes_vlrtotal',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vNF);
      Sistema.SetField('moes_baseicms',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vBC);
      Sistema.SetField('moes_xmlnfet',NotaFiscal.NotasFiscais.Items[0].XML)  ;
      Sistema.SetField('moes_dtnfeauto',NotaFiscal.NotasFiscais.Items[0].NFe.procNFe.dhRecbto);
      Sistema.SetField('moes_chavenfe',copy(NotaFiscal.NotasFiscais.Items[0].NFe.infNFe.ID,4,44));
      Sistema.SetField('moes_nfeexp','S');
      Sistema.SetField('moes_dtnfeexp',NotaFiscal.NotasFiscais.Items[0].NFe.procNFe.dhRecbto);
      Sistema.SetField('moes_retornonfe','NFe Autorizada');
      Sistema.SetField('moes_dtnfereto',NotaFiscal.NotasFiscais.Items[0].NFe.procNFe.dhRecbto);
      Sistema.SetField('moes_dtnfeauto',NotaFiscal.NotasFiscais.Items[0].NFe.procNFe.dhRecbto);
// 11.06.15
      Sistema.SetField('moes_obs','Importado XML NFe');

//    end;
// 16.11.12 - Novicarnes - Isonel
//    if trim( xcolaborador ) <>'' then
//      Sistema.SetField('moes_cola_codigo',xcolaborador);

///////////////
    Sistema.Post();


///////////////////    Sistema.Commit;
//}

/// Detalhe
    for i:=0 to NotaFiscal.NotasFiscais.Items[0].NFe.Det.Count-1 do begin

      TEstoque:=sqltoquery('select * from estoqueqtde inner join estoque on ( esqt_esto_codigo=esto_codigo )'+
                           ' where esqt_esto_codigo='+Stringtosql(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.cProd)+
                           ' and esqt_unid_codigo='+Stringtosql(xUnidade)+
                           ' and esqt_status='+Stringtosql('N') );
      Sistema.Insert('Movestoque');

// 05.07.13  - puxar o codigo com tamanho certo
      if Global.Topicos[1203] then begin
          if FGeral.GetConfig1AsInteger('TAMESTOQUE')>0 then
            Sistema.SetField('move_esto_codigo',strzero(strtoint(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.cProd),FGeral.GetConfig1AsInteger('TAMESTOQUE')) );
      end else
        Sistema.SetField('move_esto_codigo',NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.cProd);

//      Sistema.SetField('move_tama_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codtamanho'),linha],0));
//      Sistema.SetField('move_core_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codcor'),linha],0));
//      Sistema.SetField('move_copa_codigo',strtointdef(Grid.Cells[Grid.getcolumn('codcopa'),linha],0));
/////////////
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',NotaFiscal.NotasFiscais.Items[0].NFe.Ide.nNF);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',GetTipoMovimento(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.CFOP));
      Sistema.SetField('move_unid_codigo',xUnidade);
      Sistema.SetField('move_tipo_codigo',moes_tipo_codigo);
//      if rtipocad='F' then begin
//        Sistema.SetField('move_tipocad','F');
//      end else begin
        Sistema.SetField('move_tipocad',moes_tipocad);
        Sistema.SetField('move_repr_codigo',1);
//      end;
      Sistema.SetField('move_qtde',NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.qTrib);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datacont',Sistema.Hoje);
      Sistema.SetField('move_datamvto',NotaFiscal.NotasFiscais.Items[0].NFe.Ide.dEmi);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_custo',TEstoque.fieldbyname('esqt_custo').ascurrency);
      Sistema.SetField('move_custoger',TEstoque.fieldbyname('esqt_custoger').ascurrency);
      Sistema.SetField('move_customedio',TEstoque.fieldbyname('esqt_customedio').ascurrency);
      Sistema.SetField('move_customeger',TEstoque.fieldbyname('esqt_customeger').ascurrency);
      if NotaFiscal.NotasFiscais.Items[0].NFe.Emit.CRT=crtRegimeNormal then begin
        Sistema.SetField('move_cst','0'+CSTICMSToStr( NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.CST ) )
      end else
        Sistema.SetField('move_cst',CSOSNIcmsToStr( NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.CSOSN ) );
      Sistema.SetField('move_aliicms',NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.pICMS);
      Sistema.SetField('move_venda',NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.vUnTrib);
      Sistema.SetField('move_grup_codigo',TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_perdesco',NotaFiscal.NotasFiscais.Items[0].NFe.Total.ICMSTot.vDesc);
      Sistema.SetField('move_vendabru',NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.vUnTrib);
//      if trim(Grid.Cells[Grid.getcolumn('move_remessas'),linha])<>'' then
//        Sistema.SetField('move_remessas',Grid.Cells[Grid.getcolumn('move_remessas'),linha])
//      else
//        Sistema.SetField('move_remessas',remessas);
      Sistema.SetField('move_aliipi',NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.IPI.pIPI);
      Sistema.SetField('move_pecas',1);
//      Sistema.SetField('move_vendamin',texttovalor(Grid.Cells[grid.getcolumn('move_vendamin'),linha]));
      Sistema.SetField('move_redubase',NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.pRedBC);
//      Sistema.SetField('move_nroobra',inttostr(numero));
//      if Global.Topicos[1326] then
//        Sistema.SetField('move_certificado',Grid.Cells[grid.getcolumn('move_certificado'),linha]);
        campo:=Sistema.GetDicionario('movestoque','move_natf_codigo');
        if campo.Tipo<>'' then
          Sistema.SetField('move_natf_codigo',ConverteCFOP( NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.CFOP ) );
// 14.10.15 - guardo neste campo para depois somar na exportacao do fiscal
      Sistema.SetField('move_vendamin',NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.vICMSST+
                                       NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.IPI.vIPI);
      Sistema.Post('');


//////////////////////    Sistema.Commit;


      if NotaFiscal.NotasFiscais.Items[0].NFe.Emit.CRT=crtRegimeNormal then
        FGeral.GeraListaCstPerc( '0'+CSTIcmsToStr( NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.CST),
                 NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.pICMS,
                 NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.vProd,
                 NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.vProd,
                 0,0,0,
//                 NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.vBCST,
// 14.10.15
                 NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.vICMSST,
                 ListaCstPerc,'I',ConverteCFOP(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.CFOP) )
      else
        FGeral.GeraListaCstPerc( CSOSNICMSToStr( NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.CSOSN ),
                 NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.pICMS,
                 NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.vProd,
                 NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.vProd,
                 0,0,0,
//                 NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.vBCST,
// 14.10.15
                 NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Imposto.ICMS.vICMSST,
                 ListaCstPerc,'I',ConverteCFOP(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[i].Prod.CFOP) );

    end;  //ref. for para os produtos


    for i:=0 to ListaCstPerc.Count-1 do begin
            PCstPerc:=Listacstperc[i];
            Sistema.Insert('MovBase');
            Sistema.SetField('movb_transacao',Transacao);
            Sistema.SetField('movb_operacao',GetOperacao);
            Sistema.SetField('movb_status','N');
//            if (percdesconto=0) then begin  // foi dado desconto em valor
//              if Pcstperc.base>0 then
//                Pcstperc.base:=Pcstperc.base-(Pcstperc.base*(perdescorateio/100));
//              if pcstperc.isentas>0 then
//                pcstperc.isentas:=pcstperc.isentas-(Pcstperc.isentas*(perdescorateio/100));
//              if pcstperc.outras>0 then
//                pcstperc.outras:=pcstperc.outras-(Pcstperc.outras*(perdescorateio/100));
//            end;
            Sistema.SetField('movb_numerodoc',NotaFiscal.NotasFiscais.Items[0].NFe.Ide.nNF);
            Sistema.SetField('Movb_cst',Pcstperc.cst);
            Sistema.SetField('Movb_TpImposto',Pcstperc.tpimposto );
//            Sistema.SetField('Movb_BaseCalculo',Pcstperc.base);
// 14.10.15
            Sistema.SetField('Movb_BaseCalculo',Pcstperc.base+Pcstperc.basesubs);
            Sistema.SetField('Movb_Aliquota',pcstperc.perc);
            Sistema.SetField('Movb_ReducaoBc',pcstperc.reducao);
            Sistema.SetField('Movb_Imposto',FGeral.Arredonda( ( ( pcstperc.base*(pcstperc.reducao/100) ) ) * (pcstperc.perc/100),2) );
            Sistema.SetField('Movb_Isentas',pcstperc.isentas);
            Sistema.SetField('Movb_Outras' ,pcstperc.outras);
            Sistema.SetField('Movb_tipomov',GetTipoMovimento(NotaFiscal.NotasFiscais.Items[0].NFe.Det.Items[0].Prod.CFOP));
            Sistema.SetField('Movb_unid_codigo',xUnidade);
// 13.06.15
            Sistema.SetField('Movb_natf_codigo',pcstperc.cfop);
            Sistema.Post();

/////////////////////            Sistema.Commit;

    end;

//  Sistema.Beginprocess('Atualizando munic�pios');
    for p:=0 to ListaMunicipios.count-1 do begin
      PMunicipios:=ListaMunicipios[p];
      AdicionaMunicipio;
    end;

   try
     Sistema.Commit;
//     Aviso('Xml importado');
   except
     Avisoerro('N�o importado no banco de dados.  Checar');
   end;

end;

/////////////////////////////////////////// 03.05.13 - Vivan
function TFGeral.LimiteDisponivel(xcodigo: integer): currency;
////////////////////////////////////////////////////////////////////
    var Q,QCheques,QP:TSqlquery;
        PortadorBoleto,sqlportador,sqlportadorcartao,unidades,sqldatacont,sqlgarantido:string;
        valorcheques,valoraberto,valor,valorbxparcial,limitecliente,valorremessas:currency;
        Datai,Dataf:TDatetime;

    function ChecaBaixaParcial(unidades,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer):currency;
    ////////////////////////
    var Qbx:TSqlquery;
        sqlqtipo:string;
        valor:currency;
    begin
      if Datacont>1 then
        sqlqtipo:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco)
      else
        sqlqtipo:=' and pend_datacont is null';
      valor:=0;
      QBx:=sqltoquery('select * from pendencias where pend_status=''P'' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
                      ' and pend_parcela='+inttostr(parcela)+
                      ' and '+FGeral.Getin('pend_unid_codigo',unidades,'C')+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
      if QBx.eof then begin
         QBx.close;
         Freeandnil(QBx);
         QBx:=sqltoquery('select * from pendencias where pend_status=''P'' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
//                      ' and pend_unid_codigo='+stringtosql(unidades)+
                      ' and '+FGeral.Getin('pend_unid_codigo',unidades,'C')+
                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
      end;
      while not QBx.eof do begin
        valor:=valor+QBx.fieldbyname('pend_valor').ascurrency;
        QBx.next;
      end;
      result:=valor;
    end;


    begin
/////////
      result:=0;
      PortadorBoleto:=FGeral.getconfig1asstring('portabloqueto');
      valoraberto:=0;valor:=0;valorbxparcial:=0;
      sqlportador:='';
      unidades:=Global.Usuario.UnidadesMvto;
      if Global.Usuario.OutrosAcessos[0701] then
        sqldatacont:=''
      else
        sqldatacont:=' and pend_datacont > '+Datetosql(Global.DataMenorBanco);
 // 21.01.13 - Vivan - para n�o imprimir contas a receber ref. recebimento com cart�o de credito
      sqlportadorcartao:='';
      if trim( FGeral.GetConfig1AsString('Portadorcartao') )<>'' then
        sqlportadorcartao:=' and '+FGeral.GetNOTIN('pend_port_codigo',FGeral.GetConfig1AsString('Portadorcartao'),'C');
// 07.12.13
      campo:=Sistema.GetDicionario('cheques','cheq_garantido');
      if campo.Tipo<>'' then
        sqlgarantido:=' and ( cheq_garantido<>''S'' or cheq_garantido is null )'
      else
        sqlgarantido:='';

      QP:=sqltoquery('select * from pendencias'+
                      ' where '+FGeral.Getin('pend_status','N','C')+
                      ' and pend_tipo_codigo='+inttostr(xcodigo)+
                      ' and pend_tipocad='+stringtosql('C')+
                      ' and '+FGeral.Getin('pend_unid_codigo',unidades,'C')+
//                      sqldatacont+
                      sqlportador+
                      sqlportadorcartao+
                      ' and pend_RP='+stringtosql('R') );
     limitecliente:=FCadCli.GetLimiteCredito(xcodigo);
     while not QP.eof do begin

          valoraberto:=valoraberto+Qp.fieldbyname('pend_valor').ascurrency;
          valorbxparcial:=valorbxparcial+ChecaBaixaParcial(Global.Usuario.UnidadesRelatorios,inttostr(xcodigo),'C',
                              QP.fieldbyname('pend_numerodcto').asstring,QP.fieldbyname('pend_dataemissao').asdatetime,QP.fieldbyname('pend_datacont').asdatetime,
                              Qp.fieldbyname('pend_datavcto').asdatetime,Qp.fieldbyname('pend_parcela').asinteger);

        Qp.Next;
     end;
     valorremessas:=0;
// 08.10.12 - Vivan - RC soma na checagem limite de credito
      if Global.Topicos[1031] then begin
        datai:=Datetoprimeirodiames( Datetodatemesant(Sistema.hoje,3) );
//        dataf:=Datetoultimodiames( Datetodatemesant(Sistema.hoje,1) );
// 13.02.13 - Vivan Cobran�a - RC soma at� a data atual
        dataf:=Sistema.hoje;
        Q:=sqltoquery('select sum(moes_vlrtotal) as remessas from movesto '+
                ' where '+fGeral.getin('moes_tipomov',Global.CodRemessaConsig,'C')+
                ' and moes_status=''N'' and moes_datamvto>='+Datetosql(datai)+' and moes_datamvto<='+Datetosql(dataf)+
                ' and '+FGeral.Getin('moes_unid_codigo',Global.Usuario.UnidadesRelatorios,'C')+
// 15.05.13 - remessas 'troca de cr�dito' n�o soma pra limite
//                ' and '+FGeral.GetNOTIN('moes_rcmagazine','T','C')+
// 11.07.13
                ' and ( ('+FGeral.GetIN('moes_rcmagazine','M;N','C')+') '+
                ' or (moes_rcmagazine = null) )'+
                ' and moes_tipo_codigo='+inttostr(xcodigo)+' and moes_tipocad=''C''');
         valorremessas:=Q.fieldbyname('remessas').ascurrency;
         valoraberto:=valoraberto+valorremessas;
         FGeral.Fechaquery(Q);
// 14.02.13 - Vivan Cobran�a - DC e DR n�o estava deduzindo do credito
//////////////////////////////////////////////////////////////////////
// 02.02.15 - Vivan - caso nao tiver nenhuma remessa em aberto nao descontar as devolucoes
        if valorremessas>0 then begin
          Q:=sqltoquery('select sum(moes_vlrtotal) as remessas from movesto '+
                  ' where '+FGeral.Getin('moes_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C')+
                  ' and moes_status=''N'' and moes_datamvto>='+Datetosql(datai)+' and moes_datamvto<='+Datetosql(dataf)+
                  ' and '+FGeral.Getin('moes_unid_codigo',Global.Usuario.UnidadesRelatorios,'C')+
                  ' and moes_tipo_codigo='+inttostr(xcodigo)+' and moes_tipocad=''C''');
           valoraberto:=valoraberto-Q.fieldbyname('remessas').ascurrency;
           FGeral.Fechaquery(Q);
        end;
      end;
      sistema.endprocess('');
/////////// 01.09.10 - Novicarnes - Elyze
        if Global.Usuario.OutrosAcessos[0701] then
          sqldatacont:=''
        else
          sqldatacont:=' and cheq_datacont > '+DateToSql(Global.DataMenorBanco);
        QCheques:=sqltoquery('select * from cheques where cheq_tipo_codigo='+inttostr(xcodigo)+
                     ' and cheq_status=''N'''+
                      sqldatacont+sqlgarantido+
// 27.02.15
                      ' and cheq_emirec='+Stringtosql('R')+
                      ' and '+FGeral.Getin('cheq_unid_codigo',unidades,'C')+
//                      ' and cheq_predata<='+Datetosql(xdata)+
                      ' and cheq_deposito is null order by cheq_emissao');
        while not QCheques.Eof do begin
          valoraberto:=valoraberto+QCheques.fieldbyname('cheq_valor').ascurrency;
          QCheques.Next;
        end;
        fGeral.FechaQuery(QCheques);

      valoraberto:=valoraberto-valorbxparcial;
      result:=limitecliente-valoraberto;
      FGeral.FechaQuery(Qp);


end;


////////////////////////////////////// 22.05.13
procedure TFGeral.PlanoAcaoSistema(numeroref:integer;Usuarios,xUnidade,xoque,xcomo:string;xvalor:currency=0;xquando:TDatetime=0 );
//////////////////////////////////////////////////////////////////////////////////////////////////////////
var numeroplan,SetorSistema,xobjetivo:string;
    ListaUsuarios:TStringList;
    p,usuariosistema:integer;
begin

  ListaUsuarios:=TStringList.Create;
  strtolista(ListaUsuarios,usuarios,';',true);
  SetorSistema:='0099';
  xobjetivo:='TAREFA SISTEMA';
  if xquando=0 then xquando:=Sistema.hoje;
  for p:=0 to ListaUsuarios.count-1 do begin
    if trim(ListaUsuarios[p])<>'' then begin
        numeroplan:=inttostr( fGeral.getcontador('ATAPLANO'+Global.CodigoUnidade,false) );
        Sistema.Insert('planoacao');
        Sistema.SetField('paca_seto_codigo',SetorSistema);
        Sistema.SetField('paca_objetivo',xobjetivo);
        Sistema.SetField('paca_status','N');
        Sistema.SetField('paca_seq',strzero(1,3));
        Sistema.SetField('paca_numeroata',NumeroPlan);
        Sistema.SetField('paca_mrnc_numerornc',numeroref);
        Sistema.SetField('paca_unid_codigo',xUnidade);
        Sistema.SetField('paca_situacao','P');
        Sistema.SetField('paca_tipoplano','A');
        Sistema.SetField('paca_usua_codigo',usuariosistema);
        Sistema.SetField('paca_usua_resp',Global.Usuario.Codigo);
        Sistema.SetField('paca_usua_exclusao',0);
        Sistema.SetField('paca_data',Sistema.Hoje);
        Sistema.SetField('paca_dtlcto',Sistema.Hoje);
        Sistema.SetField('paca_oque',xoque);
        Sistema.SetField('paca_como',xcomo);
        Sistema.SetField('paca_quem',FUsuarios.GetNome(strtoint(LIstaUsuarios[p])));
        Sistema.SetField('paca_usua_quem',strtoint(LIstaUsuarios[p]));
        Sistema.SetField('paca_quando',xquando);
        Sistema.SetField('paca_porque','');
        Sistema.SetField('paca_dtencerra',Texttodate(''));
        Sistema.SetField('paca_valor',xvalor);
        Sistema.post('');
    end;
  end;

end;

procedure TFGeral.ExecutaHelp(xlocal: string);
/////////////////////////////////////////////////////////
var localarquivo:PWidechar;
    local:string;
begin
  local:='IT-GQ.02.01-00 Preenchimento de Relatorio de Nao Conformidades.PDF';
  if xlocal='FaturamentoSaida' then
//    localarquivo:='IT-GQ.02.01-00 Preenchimento de Relatorio de Nao Conformidades.PDF';
    local:=FGeral.getconfig1Asstring('helpfatusaida')
  else if xlocal='PedidoCompra' then
    local:=FGeral.getconfig1Asstring('helppedicompra')
  else if xlocal='Requisi��oAlmox' then
    local:=FGeral.getconfig1Asstring('helprequalmox')
  else if xlocal='OrcamentoObra' then
    local:=FGeral.getconfig1Asstring('helporcaobra');
  localarquivo:=PWideChar(local);
  if trim(localarquivo)='' then exit;
  if FileExists(trim(localarquivo)) then begin
     try
       ShellExecute(Handle, 'open', localarquivo , nil, nil, SW_SHOWNORMAL);
     except
       Avisoerro('Problemas ao abrir o arquivo '+localarquivo);
     end;
  end else
      Avisoerro('Arquivo '+localarquivo+' n�o encontrado !!' );

end;

//
procedure TFGeral.SetaTabelaIBPT;
/////////////////////////////////////
var p:integer;
    qtabela,versaotab:string;
begin
// 18.03.15 - nao sei pq dava msg mesmo tendo o arquivo na pasta Sac no TS da coorlfaf...
//  if not FileExists( 'TabelaIbpt.csv' ) then begin
//    AcbrIbptax1.URLDownload:='https://acbr.svn.sourceforge.net/svnroot/acbr/trunk/Exemplos/ACBrIBPTax/tabela/AcspDeOlhoNoImpostoIbptV.0.0.1.csv';
//    Sistema.beginprocess('Baixando tabela IBPT');
//    if AcbrIbptax1.Itens.Count=0 then AcbrIbptax1.DownloadTabela;
//   Aviso('Falta arquivo TabelaIbpt.csv');
//  end else begin
    qtabela:=ExtractFilePath( Application.ExeName ) +  'TabelaIbpt.csv';
//    'TabelaIBPTaxAC14.2.a.csv'
    versaotab:='14.2.a';
    qtabela:=ExtractFilePath( Application.ExeName )+'IBPT\'+'TabelaIBPTax'+uppercase(Global.UFUnidade)+versaotab+'.csv';
    if not FileExists( qtabela ) then qtabela:=ExtractFilePath( Application.ExeName ) + 'TabelaIbpt.csv';
    AcbrIbptax1.URLDownload:=qtabela;
    Sistema.beginprocess('Lendo tabela IBPT');

    if AcbrIbptax1.Itens.Count=0 then AcbrIbptax1.AbrirTabela( qtabela );

//  end;

  ListaIBPT:=TList.create;
  for p:=0 to AcbrIbptax1.Itens.Count-1 do begin
     New(PTabelaIBPT);
     PTAbelaIBPT.InfProduto:=TACBrIBPTaxRegistro.Create;
     PTAbelaIBPT.InfProduto.NCM:= AcbrIbptax1.Itens.Items[p].NCM;
     PTAbelaIBPT.InfProduto.Excecao:= AcbrIbptax1.Itens.Items[p].Excecao;
     PTAbelaIBPT.InfProduto.Tabela:= AcbrIbptax1.Itens.Items[p].Tabela;
// 07.04.15 tabela por estado
     PTAbelaIBPT.InfProduto.FederalNacional:= AcbrIbptax1.Itens.Items[p].FederalNacional;
     PTAbelaIBPT.InfProduto.FederalImportado:= AcbrIbptax1.Itens.Items[p].FederalImportado;
     PTAbelaIBPT.InfProduto.Estadual:= AcbrIbptax1.Itens.Items[p].Estadual;
     PTAbelaIBPT.InfProduto.Descricao:= AcbrIbptax1.Itens.Items[p].Descricao;
     PTAbelaIBPT.InfProduto.Municipal:= AcbrIbptax1.Itens.Items[p].Municipal;
//     PTAbelaIBPT.InfProduto.AliqNacional:= AcbrIbptax1.Itens.Items[p].AliqNacional;
//     PTAbelaIBPT.InfProduto.AliqImportado:= AcbrIbptax1.Itens.Items[p].AliqImportado;
// 24.01.15
     ListaIbpt.Add(PTabelaIBPT);
  end;
  Sistema.endprocess('');
end;


////////////////////////////////////////////////////
{

// 20.07.13
procedure TFGeral.ArmazenaTabelaIBPT(yAcbrIbptax: TAcbrIbptax);
///////////////////////////////////////////////////////////////////
var p:integer;
begin
// 13.08.13
  if ListaIbpt=nil then begin
    yAcbrIbptax.URLDownload:='https://acbr.svn.sourceforge.net/svnroot/acbr/trunk/Exemplos/ACBrIBPTax/tabela/AcspDeOlhoNoImpostoIbptV.0.0.1.csv';
    yAcbrIbptax.DownloadTabela;
   exit;
  end;
/////////////////
  for p:=0 to ListaIbpt.Count-1 do begin
     PTabelaIBPT:=ListaIbpt[p];
     with yAcbrIbptax.Itens.New do begin
       NCM:=PTAbelaIBPT.InfProduto.NCM;
       Excecao:=PTAbelaIBPT.InfProduto.Excecao;
       Tabela:=PTAbelaIBPT.InfProduto.Tabela;
//       AliqNacional:=PTAbelaIBPT.InfProduto.AliqNacional;
//       AliqImportado:=PTAbelaIBPT.InfProduto.AliqImportado;
// 24.01.15
     end;

  end;
end;
}
////////////////////////////////////////////////////

// 08.12.13
function TFGeral.StrToPChar(const Str: string): PChar;
{Converte String em Pchar}
////////////////////////////////////////////////////////
type
  TRingIndex = 0..7;
var
  Ring: array[TRingIndex] of PChar;
  RingIndex: TRingIndex;
  Ptr: PChar;
begin
  Ptr := @Str[Length(Str)];
  Inc(Ptr);
  if Ptr^ = #0 then
     begin
     Result := @Str[1];
     end
  else
     begin
     Result := StrAlloc(Length(Str)+1);
     RingIndex := (RingIndex + 1) mod (High(TRingIndex) + 1);
     StrPCopy(Result,Str);
     StrDispose(Ring[RingIndex]);
     Ring[RingIndex]:= Result;
     end;
end;



// 15.05.14
function TFGeral.Formatatelefonecel(telefone: string): string;
///////////////////////////////////////////////////////////////
begin
  if trim(telefone)='' then
    Result:=''
//  else if copy(telefone,1,1)='0' then
//    Result:=Trans(telefone,'(###)####-####')
  else
    Result:=Trans(telefone,'(##)#####-####');

end;

// 03.07.14
function TFGeral.TituloSubGrupoproduto(grupos: string): string;
///////////////////////////////////////////////////////////////////
begin
   if trim(grupos)<>'' then begin
     result:=' - SubGrupos : '+grupos
   end;

end;

// 29.10.14
function TFGeral.GetAliquotaFixaIcmsEstado(xUF: string): currency;
/////////////////////////////////////////////////////////////////////
begin
  if pos(xUF,'SC')>0 then result:=17
  else if pos(xUF,'SP/RS')>0 then result:=18
//  else if pos(xUF,'PR/MG')>0 then result:=18
// 12.07.16
  else if pos(xUF,'PR')>0 then result:=12
//
  else if pos(xUF,'MG')>0 then result:=18
  else result:=7;
end;

// 08.03.15
function TFGeral.Formatacnpjcpf(cnpj: string): string;
//////////////////////////////////////////////////////
begin
  if length(trim(cnpj))=14 then
    Result:=Trans(cnpj,'##.###.###/####-##')
  else
    Result:=Trans(cnpj,'###.###.###-##');

end;

// 18.03.15
function TFGeral.ValidaCadastro(xsituacao: string): boolean;
////////////////////////////////////////////////////////////////
begin
   if Global.topicos[1112] then begin
     result:=(xSituacao<>'P');
     if xsituacao='P' then Aviso('Pr�-cadastro n�o pode ser usado para vendas')
   end else
     result:=true;
end;


// 16.09.15 - perdida em 01.2015 - refazer com anexos
procedure TFGeral.EnviaEMailcomAnexo(xemail: string; xListaAnexos:TStringList ; xCorpoEmailTexto: TStrings);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
Var
xAnexo : Integer;
//SSLSocket: TIdSSLIOHandlerSocket;
smtp: TSMTPSend;
begin

//SSLSocket := TIdSSLIOHandlerSocket.Create(nil);
{
if EmailStmpcomSSL(xemail) then begin
  SSLSocket.SSLOptions.Method := sslvSSLv23;
  SSLSocket.SSLOptions.Mode := sslmClient;
  SSLSocket.SSLOptions.VerifyMode := [];
  SSLSocket.SSLOptions.VerifyDepth := 0;
  idsmtp.IOHandler := SSLSocket;
end;
}
//SSLSocket.SSLOptions.

{
smtp:=TSMTPSend.Create;
smtp.TargetPort:=inttostr(Sistema.EmailPorta);
smtp.UserName:=Sistema.EmailUser;
smtp.TargetHost:=Sistema.EmailSMTP;
smtp.Password:=Sistema.EmailPassword;
smtp.StartTLS;
}
/////////////////     Sistema.EmailFrom:=MailFrom;
{
idsmtp.Port:=Sistema.EmailPorta;
idsmtp.username:=Sistema.EmailUser;
idsmtp.Host:=Sistema.EmailSMTP;
idsmtp.Password:=Sistema.EmailPassword;
}
email.Port:=inttostr(Sistema.EmailPorta);
email.username:=Sistema.EmailUser;
email.Host:=Sistema.EmailSMTP;
email.Password:=Sistema.EmailPassword;
email.from:=Sistema.EmailUser;
email.fromname:=Sistema.EmailFrom;
email.settls:=true;
email.AddAddress(xemail);
if fGeral.EmailStmpcomSSL(xemail) then
  email.setssl:=true;

//IdMessage.Recipients.EMailAddresses := xemail;
//IdMessage.CCList.EMailAddresses := edtCC.Text;
//IdMessage.BccList.EMailAddresses := edtCCO.Text;

//Trata a Prioridade da mensagem
{
case cbxPrioridade.ItemIndex of
0 : IdMessage.Priority := mpHigh;
1 : IdMessage.Priority := mpNormal;
2 : IdMessage.Priority := mpLow;

end;
}

//IdMessage.Subject := 'XMLS das notas de saida';
//IdMessage.Sender.Text := xCorpoEmailTexto.Text;

//if cbxConfirmaLeitura.Checked Then
//idmessage.ReceiptRecipient.Text := IDMessage.From.Text; // Auto Resposta

//Tratando os arquivos anexos
For xAnexo := 0 to xListaAnexos.Count-1 do
//  TIdAttachment.create(idmessage.MessageParts, TFileName(xListaAnexos.Strings[xAnexo]));
   Email.AddAttachment(TFileName(xListaAnexos.Strings[xAnexo]),xListaAnexos.Strings[xAnexo]);

email.Subject:='XMLS das notas de saida';
email.Body.Text:=xCorpoEmailTexto.Text;

try
  email.Send;
  Sistema.endprocess('Email enviado');
except
  Sistema.endprocess('Problemas no envio para  email '+xemail);
end;

{
IdSMTP.Connect(500);
Try
  IdSMTP.Send(IdMessage);
Finally
  IdSMTP.Disconnect;
End;
}

end;

// 17.09.15
function TFGeral.GetSerieNFCe: string;
///////////////////////////////////////
var QConf:TSqlquery;
begin
  if FGeral.GetConfig1AsInteger('ConfMovNFCe') > 0 then begin
    QConf:=sqltoquery('select Comv_serie from confmov where comv_codigo = '+inttostr(FGeral.GetConfig1AsInteger('ConfMovNFCe')));
    if not QConf.eof then result:=Qconf.fieldbyname('comv_serie').AsString else result:='000';
    fGeral.fechaquery(QConf);
  end else result:='000'

end;


// 20.06.16
function TFGeral.GetTransacaoContax(xunidade:string;Incrementar:boolean): string;
/////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    SeqName:string;
    cont:integer;
begin
    Seqname:='Transacao'+xUnidade;
    Q:=SqlToQueryContax('Select * From Pg_Class Where RelName = '+StringToSql(LowerCase(SeqName))+' And RelKind=''S''');
    if not Q.IsEmpty then begin
       Q.Close;
       if Incrementar then begin
          Q.SQL.Text:='SELECT NextVal('+StringToSql(SeqName)+') As Proximo';
          Q.Open;
          Cont:=Q.FieldByName('Proximo').AsInteger;
       end else begin
          Q.SQL.Text:='SELECT LAST_VALUE AS PROXIMO FROM '+SeqName;
          Q.Open;
          Cont:=Q.FieldByName('Proximo').AsInteger;
       end;
    end else begin
       ExecuteSql('CREATE SEQUENCE '+SeqName);
       Cont:=GetSequencia(SeqName,Incrementar);
    end;
    Q.Close; FreeAndNil(Q);
    Result:=xunidade+inttostr(cont);

end;

// 21.06.16
// Para uso no lan�amento 'online' sem usar a exportacao das notas a prazo
procedure TFGeral.GetContasExportacao(Vistaprazo, Es, tipomov,  moes_tipocad, moes_transacao, moes_unid_codigo: string;
                                      CodigoMov,Moes_tipo_codigo, Moes_plan_codigo:integer; var debito, credito: integer);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var QConf,QUnid_codigo:TSqlquery;
        contagerencial:integer;
        cdebito,ccredito:string;
    begin
      QUNid_codigo:=sqltoquery('select * from unidades where unid_codigo = '+Stringtosql(moes_unid_codigo));
      if FConfMovimento.GetContaConfMovimento(CodigoMov) then begin

          QConf:=sqltoquery('select * from confmov where comv_codigo='+inttostr(CodigoMov));
          if not QConf.eof then begin
              debito:=QConf.fieldbyname('comv_debito').asinteger;
              credito:=QConf.fieldbyname('comv_credito').asinteger;
              cdebito:=QConf.fieldbyname('comv_debito').asstring;
              ccredito:=QConf.fieldbyname('comv_credito').asstring;
          end;
// 19.03.09
          if credito=0 then begin
             if moes_tipocad='F' then begin
               credito:=FFornece.GetContaExp(moes_tipo_codigo);
               ccredito:=FFornece.GetCnpjCpf(moes_tipo_codigo,'S');
             end else
               credito:=FCadcli.GetContaExp(moes_tipo_codigo);
          end;
// 20.03.09
        if credito=0 then
           credito:=QUnid_codigo.fieldbyname('unid_fornecedores').asinteger;
// 20.04.10 - Abra - Ligiane
        if Tipomov=Global.CodCompraImobilizado then begin
          debito:=moes_plan_codigo;
          cdebito:=inttostr(moes_plan_codigo);
        end;
// 05.09.16 - Novicarnes Vendas Diferenciadas
///////////////////
        if debito=0 then begin
             if Q.FieldByName('moes_tipocad').asstring='F' then begin
               debito:=FFornece.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger);
               cdebito:=FFornece.GetCnpjCpf(Q.fieldbyname('moes_tipo_codigo').asinteger,'S');
             end else
               debito:=FCadcli.GetContaExp(Q.fieldbyname('moes_tipo_codigo').asinteger);
        end;
///////////////////
// 25.11.09 - capeg - leo jaime  // 21.10.11 - leo jaime mas no SM
        if (Vistaprazo='V') and (not Global.Topicos[1018]) then begin
// para nao lan�ar as compras a vista
            debito:=0;
            credito:=0;
            cdebito:='';
            ccredito:='';
        end else if (Vistaprazo='V') and (Global.Topicos[1018]) then begin
          if es='V' then begin
            debito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
            credito:=QUnid_codigo.fieldbyname('Unid_vendaavista').asinteger;
          end else begin
            if debito=0 then
              debito:=QUnid_codigo.fieldbyname('unid_comprasavista').asinteger;
            credito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
          end;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
        end;
        FGeral.FechaQuery(QConf);
/////////////////////////////////////////////////////////////
      end else if Tipomov=Global.CodTransfEntrada then begin
        debito:=QUnid_codigo.fieldbyname('unid_transentrada').asinteger;
// 07.08.14 - Novicarnes - Angela
//        credito:=ctatransestoque;
        credito:=QUnid_codigo.fieldbyname('Unid_ctbtransnume').asinteger;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
      end else if Tipomov=Global.CodTransfSaida then begin
//        debito:=ctatransestoque;
// 07.08.14 - Novicarnes - Angela
        debito:=QUnid_codigo.fieldbyname('Unid_ctbtransnume').asinteger;
        credito:=QUnid_codigo.fieldbyname('unid_transsaida').asinteger;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
////////_//////////////////////////////////////////////////////////////
      end else if pos(Tipomov,Global.CodDevolucaoProntaEntrega+';'+
                  global.CodDevolucaoVenda+';'+Global.CodDevolucaoConsigMerc+';'+Global.CodDevolucaoIgualVenda)>0 then begin
        debito:=QUnid_codigo.fieldbyname('unid_devovenda').asinteger;
        cdebito:=inttostr(debito);
//        credito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
// 02.08.07
        if Global.Topicos[1253] then begin
           if moes_tipocad='F' then begin
             credito:=FFornece.GetContaExp(moes_tipo_codigo);
             ccredito:=FFornece.GetCnpjCpf(moes_tipo_codigo,'S');
           end else begin
             credito:=FCadcli.GetContaExp(moes_tipo_codigo);
             ccredito:=FCadcli.GetCnpjCpf(moes_tipo_codigo,'S');
// 23.09.08 -vanessa - novicarnes
             if pos(Tipomov,Global.CodDevolucaoProntaEntrega+';'+global.CodDevolucaoVenda+';'+Global.CodDevolucaoConsigMerc+';'+Global.CodDevolucaoIgualVenda)>0 then
//               debito:=FCadcli.GetContaExpDevVenda(Q.fieldbyname('moes_tipo_codigo').asinteger);
// 08.01.09
               credito:=FCadcli.GetContaExpDevVenda(moes_tipo_codigo);
           end;
        end else
          credito:=QUnid_codigo.fieldbyname('unid_clientes').asinteger;
//////////////////
// 23.11.05 - ajustado em 20.04.09
      end else if pos(Tipomov,Global.CodDevolucaoCompra)>0 then begin
//        debito:=95;  // falta criar conta no cadastro de unidades
// s� hj ela finalmente disse q tinha q criar uma conta de dev. para cada fornec.
        if Global.Topicos[1253] then begin
// 25.01.10 - Abra - Ligiane
           if Global.Topicos[1008] then begin
             if moes_tipocad='F' then begin
               debito:=FFornece.GetContaExp(moes_tipo_codigo);
               cdebito:=FFornece.GetCnpjCpf(moes_tipo_codigo,'S');
             end else begin
               debito:=FCadcli.GetContaExp(moes_tipo_codigo);
               cdebito:=FCadcli.GetCnpjCpf(moes_tipo_codigo,'S')
             end;
           end else begin
             if moes_tipocad='F' then
               debito:=FFornece.GetContaExpDevCompra(moes_tipo_codigo)
             else begin
               debito:=FCadcli.GetContaExpDevVenda(moes_tipo_codigo);
             end;
           end;
        end else
          debito:=QUnid_codigo.fieldbyname('unid_fornecedores').asinteger;
        credito:=QUnid_codigo.fieldbyname('unid_devocompra').asinteger;

// 06.06.12 - Benato -> SM - lan�amento dos cupons fiscais
      end else if (CodigoMov=FGeral.GetConfig1AsInteger('ConfMovECF')) and ( codigomov>0 ) then begin

        debito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
        credito:=QUnid_codigo.fieldbyname('Unid_vendaavista').asinteger;

      end else if es='V' then begin

        debito:=QUnid_codigo.fieldbyname('unid_clientes').asinteger;
        credito:=QUnid_codigo.fieldbyname('unid_vendaaprazo').asinteger;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
// 12.05.10 - Novi - devolucao de compra de produtor
        if pos(Tipomov,Global.CodDevolucaoCompraProdutor)>0 then
           credito:=QUnid_codigo.fieldbyname('unid_devocompra').asinteger;

// 18.06.07 - para usar a conta do cadastro de clientes
        if Global.Topicos[1253] then begin
//           if EdMesano.isempty then begin
//             debito:=FCadcli.GetContaExp(moes_tipo_codigo,'','XX');
//             cdebito:=FCadcli.GetCnpjCpf(moes_tipo_codigo,'S');
//           end else begin
             debito:=FCadcli.GetContaExp(moes_tipo_codigo,'','XY');
             cdebito:=FCadcli.GetCnpjCpf(moes_tipo_codigo,'S');
             if Global.topicos[1018] then begin
               debito:=QUnid_codigo.fieldbyname('unid_clientes').asinteger;
               cdebito:=FCadcli.GetCnpjCpf(moes_tipo_codigo,'S');
             end;
//           end;
// 11.04.12 - para planos que nao detalham clientes
// 19.04.13 - Novicarnes - OU para clientes novos que ainda nao foi colocado o reduzido no sac
//            entao foi retirado isto pq se t� setado o 1253 � pra avisar q nao tem...
//           if debito=0 then debito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;

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
            debito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
            credito:=QUnid_codigo.fieldbyname('Unid_vendaavista').asinteger;
          end else begin
// 04.05.05 - para nao lan�ar as vendas/compras a vista
            debito:=0;
            credito:=0;
          end;
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
        end;
{
// 22.10.10 - NOvi - vava - debito e credito informado na digitacao da nota de entrada
      end else if (es='C') and (pos(Tipomov,Global.CodCompraSemfinan)>0) and
                  ( Global.Topicos[1347] )
        then begin

          debito:=FPlano.GetContaExportacao(moes_plan_codigo,EdUnid_codigo.Text);
          credito:=FPlano.GetContaExportacao(Q.fieldbyname('moes_plan_codigocre').asinteger,EdUnid_codigo.Text);
          cdebito:=inttostr(debito);
          ccredito:=inttostr(credito);
}
      end else if es='C' then begin

        debito:=QUnid_codigo.fieldbyname('unid_compras').asinteger;
        contagerencial:=fGeral.GetContaDespesa(moes_transacao);
// 02.08.07                    // 08.08.08
        if (Contagerencial>0) and ( pos(Tipomov,Global.CodCompraProdutor+';'+Global.CodDevolucaoCompraProdutor+';'+Global.CodEntradaProdutor)=0 )
           and ( not Global.Topicos[1003] )  then  // 05.11.10
          debito:=FPlano.GetContaExportacao(contagerencial,moes_Unid_codigo)
        else if tipomov=Global.CodConhecimento then begin
// 23.10.07
          debito:=QUnid_codigo.fieldbyname('unid_ctbfrete').asinteger;
          if debito=0 then
            debito:=QUnid_codigo.fieldbyname('unid_compras').asinteger;
        end;
        cdebito:=inttostr(debito);
        if Global.Topicos[1253] then begin
           if moes_tipocad='F' then begin
             credito:=FFornece.GetContaExp(moes_tipo_codigo);
             ccredito:=FFornece.GetCnpjCpf(moes_tipo_codigo,'S');
// 20.03.09 - caso ainda nao houver no fornecedor a conta configurada
             if credito=0 then
                credito:=QUnid_codigo.fieldbyname('unid_fornecedores').asinteger;
           end else  begin
               credito:=FCadcli.GetContaExp(moes_tipo_codigo);
               ccredito:=FCadcli.GetCnpjCpf(moes_tipo_codigo,'S');
           end;
// 30.10.09 - Abra - Ligiane - adiantamento de pagamento de despesa - credito adiantamento
//            e debito a despesa informada
           campo:=Sistema.GetDicionario('movesto','moes_plan_codigo');
           if ( tipomov=Global.CodCompraRemessaFutura )
              and ( campo.Tipo<>'' ) then begin
              QConf:=sqltoquery('select * from confmov where comv_codigo='+inttostr(CodigoMov));
              if not QConf.eof then begin
                 if QConf.fieldbyname('comv_debito').asinteger=0 then begin
//                   debito:=Q.fieldbyname('moes_plan_codigo').asinteger;  //
// 17.12.09
                   debito:=FPlano.GetContaExportacao(moes_plan_codigo,moes_unid_codigo);
// aqui ver se cria parametro para 'usar mesmo reduzido da contabilidad'
                   credito:=QConf.fieldbyname('comv_credito').asinteger;
                 end;
              end;
              FGeral.FechaQuery(QConf);
             ccredito:=inttostr(credito);
             cdebito:=inttostr(debito);
           end;
// 25.11.09
           if Vistaprazo='V' then begin
// 05.11.10 - para lan�ar as vendas a vista
              if Global.Topicos[1018] then begin
                if debito=0 then  // 21.10.11
                  debito:=QUnid_codigo.fieldbyname('unid_comprasavista').asinteger;
                credito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
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
            if QUnid_codigo.fieldbyname('unid_fornecedores').asinteger>0 then
              credito:=QUnid_codigo.fieldbyname('unid_fornecedores').asinteger
            else begin
              credito:=FFornece.GetContaExp(moes_tipo_codigo);
              ccredito:=FFornece.GetCnpjCpf(moes_tipo_codigo,'S');
            end;

        end;

        if Vistaprazo='V' then begin
// 05.11.10 - para lan�ar as compras a vista
              if Global.Topicos[1018] then begin
                debito:=QUnid_codigo.fieldbyname('unid_comprasavista').asinteger;
                credito:=QUnid_codigo.fieldbyname('unid_caixa').asinteger;
              end else begin
// para nao lan�ar as compras a vista
                debito:=0;
                credito:=0;
              end;
             ccredito:=inttostr(credito);
             cdebito:=inttostr(debito);
         end;

      end;
      FEchaquery(QUNid_codigo);
   end;


// 20.09.16
function TFGeral.TemContaContabil(CodTipo:integer ;tipoCad,xunidade,modulo: string): boolean;
///////////////////////////////////////////////////////////////////////// ////////////////////
var Q:TSqlquery;
begin
  result:=true;
  if ( ( modulo='FIN' ) and ( Global.Topicos[1045] ) )
     or ( ( modulo='FAT' ) and ( Global.Topicos[1043] ) ) then begin
    if tipocad='C' then begin
      Q:=sqltoquery('select Clie_contacontabil from clientes where clie_codigo='+inttostr(codtipo));
      if not Q.eof then begin
        if Q.FieldByName('clie_contacontabil').AsInteger=0 then begin
          Avisoerro('Falta conta cont�bil neste cliente');
          result:=false;
        end;
      end;
      Q.close;
    end else begin
      Q:=sqltoquery('select Forn_ContaExp,Forn_ContaExp02,Forn_unidexporta01,Forn_unidexporta02 from fornecedores where forn_codigo='+inttostr(codtipo));
      if not Q.eof then begin
        if ( (Q.FieldByName('forn_contaexp').AsInteger>0) and ( Q.FieldByName('Forn_unidexporta01').AsString=xunidade ) )
          or (Q.FieldByName('forn_contaexp02').AsInteger>0) and ( Q.FieldByName('Forn_unidexporta02').AsString=xunidade ) then
          result:=true
        else begin
          if modulo<>'FIN' then
            Avisoerro('Falta conta cont�bil ou qual unidade neste fornecedor para unidade '+xunidade);
          result:=false;
        end;
      end;
      Q.close;
    end;
  end;
end;

////// 12.10.16
function TFGeral.PodeIncluirNF: boolean;
///////////////////////////////////////////
var Q:TSqlquery;
        tiposdemovimento,tiposnao:string;
        Lista:TStringList;
        xdata:TDatetime;
begin
  if not Global.Topicos[1396] then begin
     result:=true;
     exit;
  end;
      result:=true;
      tiposdemovimento:=Global.TiposSaida+';'+Global.CodDevolucaoCompra+';'+Global.CodCompraProdutor+';'+
                    Global.CodDrawBackEnt+';'+Global.CodDevolucaoIgualVenda+';'+Global.CodEntradaImobilizado+';'+
                    Global.CodCompraProdutorReclassifica+';'+Global.CodDevolucaoSimbolicaConsig+';'+Global.CodVendasemFinan+';'+
                    Global.CodCompraConsignado+';'+Global.CodDevolucaodeRemessa+';'+Global.CodDevolucaoRoman+';'+
                    Global.CodNotaRemessaaOrdem+';'+Global.CodEstornoNFeSai+';'+Global.CodDevolucaoTributada+';'+
                    Global.CodRemessaConserto+';'+Global.CodNfeComplementoQtde+';'+
                    FGeral.GetConfig1AsString('TIPOSENUMSAIDA');
      tiposnao:=Global.TiposNaoFiscal+';'+Global.CodPrestacaoServicos+';'+Global.CodVendaInterna;
      xdata:=Sistema.hoje-3;
      Q:=sqltoquery('select moes_numerodoc,moes_dataemissao,moes_tipo_codigo,moes_tipocad from movesto where moes_status<>''C'''+
                    ' and moes_unid_codigo='+Stringtosql(Global.codigounidade)+
                    ' and ( (moes_dtnfeauto is null) or (moes_nfeexp<>''S'') )'+
                    ' and '+FGeral.GetNOTIN('moes_status','I;X;Y','C')+
                    ' and moes_especie <> '+Stringtosql('CF')+
                    ' and moes_datamvto>='+Datetosql(xData)+
                    ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                    ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C') );
      Lista:=TStringList.create;
      if not Q.eof then begin
         Lista.Add('Notas a autorizar OU n�meros a inutilizar');
         result:=false;
      end;
      while not Q.eof do begin
        Lista.add('NF-e : '+Q.fieldbyname('moes_numerodoc').asstring+' - Data:'+FGeral.formatadata(Q.fieldbyname('moes_dataemissao').asdatetime));
        Q.Next;
      end;
      FGeral.FechaQuery(Q);
      if LIsta.count>0 then Showmessage( Lista.Text );

end;

end.





