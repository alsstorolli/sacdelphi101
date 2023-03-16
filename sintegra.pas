unit sintegra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  SQLGrid, ExtCtrls, SqlExpr ;

type
  TFSintegra = class(TForm)
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
    Edfinalidade: TSQLEd;
    EdCreditoPisCofins: TSQLEd;
    EdGera74: TSQLEd;
    EdMesano: TSQLEd;
    EdUnidades: TSQLEd;
    EdSoecf: TSQLEd;
    procedure EdterminoValidate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bExecutarClick(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdfinalidadeExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    function GetNumerodoEndereco(endereco:string;codigo:integer=0;mensagem:string='S'):string;
    function Posicao2num(endereco:string):integer;
// 14.07.11
    procedure GeraRegistros60;
// 27.02.14
    Function BuscaIPInositem( stransacao,xcfop50:string ):currency;

  end;

var
  FSintegra: TFSintegra;
  nomearq,registrosparanaogerar:string;
  Arquivo,ArquivoTeste,ArquivoE,ArquivoS:Textfile;
  QGeral:TSqlquery;
  Lista60,Lista75,Lista75Aux:TStringList;

const
  CstSubsTrib:string='010';        // bonificacao q pode ter ST -benato
  CfopscomST:string='1401/1403/2403/1910/2910/5401/5403/5405/5910';


implementation

uses SqlSis, Arquiv, Geral, Sqlfun, ConfMovi, represen, fornece,
  cadcli, munic, Transp, Estoque, Unidades, Sittribu, codigosfis, grupos,
  Subgrupos;

{$R *.dfm}


function TiraSintegra(s:string):string;
var d,g,r:string;
    p:integer;
begin
  d:=';,/-.';
  r:='';
  for p:=1 to length( s ) do begin
    g:=copy(s,p,1);
    if pos(g,d)=0 then
      r:=r+g;
  end;
  result:=r;
end;


procedure TFSintegra.EdterminoValidate(Sender: TObject);
begin
   if EdTermino.asdate<EdInicio.Asdate then
     EdTermino.INvalid('T�rmino tem que ser posterior ao inicio')
   else begin
     if (Datetomes(EdInicio.asdate)=1) and (Datetomes(EdTermino.asdate)=12) then begin
//     if (DatetoDia(EdInicio.asdate)=1) and (Datetomes(EdTermino.asdate)=12) then begin
       EdCreditoPisCofins.Enabled:=true;
       EdCreditoPisCofins.Visible:=true;
     end else begin
       EdCreditoPisCofins.Enabled:=false;
       EdCreditoPisCofins.Visible:=false;
     end;
   end;

end;

procedure TFSintegra.Execute;
///////////////////////////////////
begin
//  nomearq:='\SAC\SINTE';
//  Mat:=TStringlist.create;
  if Global.Topicos[1333] then begin
    EdGera74.text:='S';
    EdMesano.Enabled:=true;
  end else begin
    EdGera74.text:='N';
    EdMesano.Enabled:=false;
  end;
  if EdInicio.isempty then begin
    Edinicio.Setdate(Sistema.Hoje);
    EdTermino.setdate(Sistema.hoje);
  end;
  EdUnidades.Enabled:=Global.Topicos[1015];
  EdUnidades.text:=Global.Usuario.UnidadesMvto;
  FUnidades.SetaItems(EdUnidades,nil,Global.Usuario.UnidadesMvto);
  Show;
end;

procedure TFSintegra.FormActivate(Sender: TObject);
/////////////////////////////////////////////////////
begin
//   Edinicio.setdate(texttodate('01'+strzero(datetomes(sistema.hoje),2)+strzero(datetoano(sistema.hoje,true),4)));
//   Edtermino.setdate(texttodate('01'+strzero(datetomes(sistema.hoje),2)+strzero(datetoano(sistema.hoje,true),4)));
  if trim(EdUnid_codigo.text)='' then
    EdUnid_codigo.text:=Global.CodigoUnidade;
//  if not Arq.Tclientes.active then Arq.Tclientes.open;
//  if not Arq.TFornec.active then Arq.TFornec.open;
//  if not Arq.TConfMovimento.active then Arq.TConfMovimento.open;
//  if not Arq.TEstoque.active then Arq.TEstoque.open;
//  if not Arq.TEstoqueqtde.active then Arq.TEstoqueqtde.open;
  EdInicio.setfocus;
end;

////////////////////////////////////////////////////////////////////
procedure TFSintegra.bExecutarClick(Sender: TObject);
////////////////////////////////////////////////////////////////////
var Q,QMovBase,QC,Q71:TSqlquery;
    empresa,filial,n,p,totalregE,totalregS,totalregR,totalregC,contitem,xy,aliqsicms,numcfops,numcfopsST:integer;
    linha,sist,es,cfop,elemento,nomecad,uf,cidade,cep,cnpjcpf,insest,datanota,x,situacaonota,unid_fax,codigofiscal,cfop50,cfop54,xcst:string;
    vlrdesco,vlracres,totalitem,valorzero,isentas,outras,baseicmsst,valoricmsst,baseicms,valoripi,vlrfrete,vlrseguro,
    vlrpiscofins,valornota,basecalculo,redubase,aliqicms,vlricms,perdesco,aliqmovb,custo,redubasemestre:currency;
    Lista10,Lista11,Lista50,Lista50A,Lista54,Lista70,Lista74,Lista88,
    ListaAliquotas,Lista51,Lista50Teste,ListaBases,ListaCfops,ListaPisCofins,Lista51Ordem,
    ListaCSTs,Lista61,Lista53,Lista53Ordem,Lista85,Lista86,Lista71:TStringlist;
    Separador,tipo4snao,separa,nomearqE,nomearqS,codigosprodutos,Mesano,Codigoposse,
    NumSerieCertificado,SqlUnidades,SqlUnidadesDet,fonechu,linha902,tiposmov,
    nomesintegra,nomeexecsintegra,serie,xserie,tiposnao:string;
    h1:THandle;
    difcontabilbaseicms,difperc,totalipi,totaldesco,totalfrete,valorsubs,totalsubs,totalent,totalsai,
    valoripidositens:currency;
    valorSTporcfop:extended;

    
    procedure PesquisaEntidade(tipocad:string ; codigo:integer );
    //////////////////////////////////////////////////////////
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

      if (Qgeral<>nil) and ( pos(TipoCad,'F;C')>0 ) then begin
        if qgeral.eof then
          avisoerro('tipocad '+tipocad+' codigo '+inttostr(codigo)+' n�o encontrado');
      end;

    end;


    function Getformato50(dados:string):string;
    //////////////////////////////////////////
    var Lista:TStringlist;

        function GetInsEst(s:string):string;
        ////////////////////////////////////
        var d:string;
        begin
          if (trim(s)='')  then
            d:='ISENTO'
          else if  Q.fieldbyname('moes_tipocad').asstring='C' then begin
            if QGeral.fieldbyname('clie_tipo').asstring='F' then
              d:='ISENTO'
            else
              d:=trim( copy(s,1,14) );  // 10.02.12 - colocado trim devido validapr...
          end else
            d:=trim( copy(s,1,14) );
          result:=strspace(d,14);
        end;

        function GetCnpjCpf(s:string ; tam:integer):string;
        /////////////////////////////////////////////////////
        var d,t:string;
        begin
          if Q.fieldbyname('moes_tipocad').asstring='C' then
            t:='Cliente'
          else if Q.fieldbyname('moes_tipocad').asstring='F' then
            t:='Fornecedor'
          else if Q.fieldbyname('moes_tipocad').asstring='R' then
            t:='Representante'
          else
            t:='Unidade';
          if trim(s)='' then begin
            Texto.lines.add('Codigo '+Q.fieldbyname('moes_tipo_codigo').asstring+' de '+t+' sem CNPJ/CPF');
            d:=strzero(0,14);
          end else if length(trim(s))<tam then
            d:='000'+strspace( copy(s,1,11) ,11 )
          else
            d:=strspace(copy(s,1,14),tam);
          result:=d;
        end;

    begin
    //////////////
      if pos('50',registrosparanaogerar)>0 then begin
        result:='';
        exit;
      end;

      lista:=tstringlist.create;
      strtolista(Lista,dados,';',true);
      if lista.count=0 then
        result:=''
      else begin
        serie:=copy(lista[5],1,3);
        if (trim(serie)='0') and (Global.UFUnidade='PR') then serie:=' ';  // 11.02.12 validapr nao aceita
        if (Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimento) and (Global.UFUnidade='PR') then serie:='U';  // 12.11.13 validapr nao aceita
        if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 ) then
          result:='50'+separador+GetCnpjCpf( lista[0],14 )+
                 GetInsEst( TiraSintegra(lista[1]) )+
                 FGeral.DataStringinvertida(lista[2])+
                 strspace(lista[3],2)+   // UF
                 strspace(lista[4],2)+separador+   // Modelo
                 strspace( serie ,3)+separador+   // Serie
                 strzero(strtoint(lista[6]),6)+separador+    // NUmero
                 strspace( copy(lista[7],1,4),4)+separador+   // /cfop
                 strspace(lista[8],1)+   // P - proprio  T-terceiros
                 FGeral.Exportanumeros(texttovalor(lista[09]),13,2)+   // total nf
                 FGeral.Exportanumeros(0,13,2)+   // base icms
                 FGeral.Exportanumeros(0,13,2)+   // valor icms
                 FGeral.Exportanumeros(0,13,2)+   // isentas
                 FGeral.Exportanumeros(texttovalor(lista[09]),13,2)+   // outras
                 FGeral.Exportanumeros(texttovalor(lista[14]),04,2)+   // aliquota icms
                 strspace(lista[15],1)    // situacao ( N-normal  S-cancelado   E ou X )
        else
          result:='50'+separador+GetCnpjCpf( lista[0],14 )+
                 GetInsEst( TiraSintegra(lista[1]) )+
                 FGeral.DataStringinvertida(lista[2])+
                 strspace(lista[3],2)+   // UF
                 strspace(lista[4],2)+separador+   // Modelo
                 strspace( serie,3 )+separador+   // Serie
                 strzero(strtoint(lista[6]),6)+separador+    // NUmero
                 strspace( copy(lista[7],1,4),4)+separador+   // /cfop
                 strspace(lista[8],1)+   // P - proprio  T-terceiros
                 FGeral.Exportanumeros(texttovalor(lista[09]),13,2)+   // total nf
                 FGeral.Exportanumeros(texttovalor(lista[10]),13,2)+   // base icms
                 FGeral.Exportanumeros(texttovalor(lista[11]),13,2)+   // valor icms
                 FGeral.Exportanumeros(texttovalor(lista[12]),13,2)+   // isentas
                 FGeral.Exportanumeros(texttovalor(lista[13]),13,2)+   // outras
                 FGeral.Exportanumeros(texttovalor(lista[14]),04,2)+   // aliquota icms
                 strspace(lista[15],1) ;    // situacao ( N-normal  S-cancelado   E ou X )
      end;
      Freeandnil(lista);
    end;


    function Getformato54(dados:string):string;
    ///////////////////////////////////////////////////////////////////////////
    var Lista:TStringlist;
        serie:string;

        function GetCnpjCpf(s:string ; tam:integer):string;
        var d,t:string;
        begin
          if Q.fieldbyname('moes_tipo_codigo').asstring='C' then
            t:='Cliente'
          else if Q.fieldbyname('moes_tipo_codigo').asstring='F' then
            t:='Fornecedor'
          else if Q.fieldbyname('moes_tipo_codigo').asstring='R' then
            t:='Representante'
          else
            t:='Unidade';
          if trim(s)='' then begin
            Texto.lines.add('Codigo '+Q.fieldbyname('moes_tipo_codigo').asstring+' de '+t+' sem CNPJ/CPF');
            d:=strzero(0,14);
          end else if length(trim(s))<tam then
            d:='000'+strspace( copy(s,1,11) ,11 )
          else
            d:=strspace(copy(s,1,14),tam);
          result:=d;
        end;

    begin
    //////
      if pos('54',registrosparanaogerar)>0 then begin
        result:='';
        exit;
      end;
      lista:=tstringlist.create;
      strtolista(Lista,dados,';',true);
      if lista.count=0 then
        result:=''
      else begin
        try
          if trim(lista[5])='' then
            Texto.lines.add('Documento '+lista[3]+' Cfop '+lista[4]+' Produto '+lista[7]+' sem CST');
          serie:=lista[2];
          if (trim(serie)='0') and (Global.UFUnidade='PR') then serie:=' ';  // 01.03.12 validapr nao aceita
          if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 ) then
            result:='54'+GetCnpjCpf( lista[0],14 )+
                 strspace(lista[1],2)+   // Modelo
                 strspace(serie,3)+   // Serie
                 strzero(strtoint(lista[3]),6)+    // NUmero
                 strspace(lista[4],4)+   // /cfop
                 strspace( copy(lista[5],1,3) ,3)+   // /CST
                 strspace(lista[6],3)+   // /sequencial produtos
                 strspace(lista[7],14)+   // codigo produto
                 FGeral.Exportanumeros(texttovalor(lista[08]),11,3)+   // qtde
                 FGeral.Exportanumeros(texttovalor(lista[09]),12,2)+   // valor do item ( qtde*unitario )
//                 FGeral.Exportanumeros(0,12,2)+   // desconto ou despesa acessoria
// 10.12.09 - Novicarnes - Vanessa
                 FGeral.Exportanumeros(texttovalor(lista[10]),12,2)+   // desconto ou despesa acessoria
                 FGeral.Exportanumeros(0,12,2)+   // base icms
                 FGeral.Exportanumeros(0,12,2)+   // base icms subst. trib.
                 FGeral.Exportanumeros(0,12,2)+   // valor ipi
                 FGeral.Exportanumeros(texttovalor(lista[14]),04,2)    // aliquota icms
          else
            result:='54'+GetCnpjCpf( lista[0],14 )+
                 strspace(lista[1],2)+   // Modelo
                 strspace(serie,3)+   // Serie
                 strzero(strtoint(lista[3]),6)+    // NUmero
                 strspace(lista[4],4)+   // /cfop
                 strspace( copy(lista[5],1,3) ,3)+   // /CST
                 strspace(lista[6],3)+   // /sequencial produtos
                 strspace(lista[7],14)+   // codigo produto
                 FGeral.Exportanumeros(texttovalor(lista[08]),11,3)+   // qtde
                 FGeral.Exportanumeros(texttovalor(lista[09]),12,2)+   // valor do item ( qtde*unitario )
                 FGeral.Exportanumeros(texttovalor(lista[10]),12,2)+   // desconto ou despesa acessoria
                 FGeral.Exportanumeros(texttovalor(lista[11]),12,2)+   // base icms
                 FGeral.Exportanumeros(texttovalor(lista[12]),12,2)+   // base icms subst. trib.
                 FGeral.Exportanumeros(texttovalor(lista[13]),12,2)+   // valor ipi
                 FGeral.Exportanumeros(texttovalor(lista[14]),04,2) ;   // aliquota icms
        except
           Avisoerro( lista[0]+';'+lista[1]+';'+lista[2]+';'+lista[3]+';'+lista[4]+';'+lista[5] )
//           Avisoerro( lista[0] )
        end;
      end;
      Freeandnil(lista);
    end;

///////// 10.04.07 - total de nota ref. ao ipi
    function Getformato51(dados:string):string;
    ///////////////////////////////////////////
    var Lista:TStringlist;

        function GetInsEst(s:string):string;
        ///////////////////////////////////
        var d:string;
        begin
          if (trim(s)='')  then
            d:='ISENTO'
          else if  Q.fieldbyname('moes_tipocad').asstring='C' then begin
            if QGeral.fieldbyname('clie_tipo').asstring='F' then
              d:='ISENTO'
            else
              d:=copy(s,1,14);
          end else
            d:=copy(s,1,14);
          result:=strspace(d,14);
        end;

        function GetCnpjCpf(s:string ; tam:integer):string;
        /////////////////////////////////////////////////////
        var d,t:string;
        begin
          if Q.fieldbyname('moes_tipocad').asstring='C' then
            t:='Cliente'
          else if Q.fieldbyname('moes_tipocad').asstring='F' then
            t:='Fornecedor'
          else if Q.fieldbyname('moes_tipocad').asstring='R' then
            t:='Representante'
          else
            t:='Unidade';
          if trim(s)='' then begin
            Texto.lines.add('Codigo '+Q.fieldbyname('moes_tipo_codigo').asstring+' de '+t+' sem CNPJ/CPF');
            d:=strzero(0,14);
          end else if length(trim(s))<tam then
            d:='000'+strspace( copy(s,1,11) ,11 )
          else
            d:=strspace(copy(s,1,14),tam);
          result:=d;
        end;

    begin
    ////////////
      lista:=tstringlist.create;
      strtolista(Lista,dados,';',true);
      if lista.count=0 then
        result:=''
      else
        result:='51'+GetCnpjCpf( lista[0],14 )+
                 GetInsEst( TiraSintegra(lista[1]) )+
                 FGeral.DataStringinvertida(lista[2])+
                 strspace(lista[3],2)+   // UF
//                 strspace(lista[4],2)+   // Modelo
                 strspace( copy(lista[5],1,3) ,3)+   // Serie
                 strzero(strtoint(lista[6]),6)+    // NUmero
                 strspace( copy(lista[7],1,4),4)+   // /cfop
//                 strspace(lista[8],1)+   // P - proprio  T-terceiros
                 FGeral.Exportanumeros(texttovalor(lista[09]),13,2)+   // total nf
                 FGeral.Exportanumeros(texttovalor(lista[10]),13,2)+   // total ipi
                 FGeral.Exportanumeros(texttovalor(lista[12]),13,2)+   // isentas
                 FGeral.Exportanumeros(texttovalor(lista[13]),13,2)+   // outras
                 space(20)+
                 strspace(lista[15],1) ;    // situacao ( N-normal  S-cancelado   E ou X )


      Freeandnil(lista);
    end;

/////////

///////// 11.08.11 - total de nota ref. a substituicao tributaria
    function Getformato53(dados:string):string;
    ///////////////////////////////////////////
    var Lista:TStringlist;

        function GetInsEst(s:string):string;
        ///////////////////////////////////
        var d:string;
        begin
          if (trim(s)='')  then
            d:='ISENTO'
          else if  Q.fieldbyname('moes_tipocad').asstring='C' then begin
            if QGeral.fieldbyname('clie_tipo').asstring='F' then
              d:='ISENTO'
            else
              d:=copy(s,1,14);
          end else
            d:=copy(s,1,14);
          result:=strspace(d,14);
        end;

        function GetCnpjCpf(s:string ; tam:integer):string;
        /////////////////////////////////////////////////////
        var d,t:string;
        begin
          if Q.fieldbyname('moes_tipocad').asstring='C' then
            t:='Cliente'
          else if Q.fieldbyname('moes_tipocad').asstring='F' then
            t:='Fornecedor'
          else if Q.fieldbyname('moes_tipocad').asstring='R' then
            t:='Representante'
          else
            t:='Unidade';
          if trim(s)='' then begin
            Texto.lines.add('Codigo '+Q.fieldbyname('moes_tipo_codigo').asstring+' de '+t+' sem CNPJ/CPF');
            d:=strzero(0,14);
          end else if length(trim(s))<tam then
            d:='000'+strspace( copy(s,1,11) ,11 )
          else
            d:=strspace(copy(s,1,14),tam);
          result:=d;
        end;

    begin
    ////////////
      lista:=tstringlist.create;
      strtolista(Lista,dados,';',true);
      if lista.count=0 then
        result:=''
      else
        result:='53'+GetCnpjCpf( lista[0],14 )+
                 GetInsEst( TiraSintegra(lista[1]) )+
                 FGeral.DataStringinvertida(lista[2])+
                 strspace(lista[3],2)+   // UF
                 strspace(lista[4],2)+   // Modelo
                 strspace( copy(lista[5],1,3) ,3)+   // Serie
                 strzero(strtoint(lista[6]),6)+    // NUmero
                 strspace( copy(lista[7],1,4),4)+   // /cfop
                 strspace(lista[8],1)+   // P - proprio  T-terceiros
                 FGeral.Exportanumeros(texttovalor(lista[09]),13,2)+   // base sub.trib.
                 FGeral.Exportanumeros(texttovalor(lista[10]),13,2)+   // icms retido
                 FGeral.Exportanumeros(texttovalor(lista[11]),13,2)+   // despeas acessorias
                 strspace(lista[12],1)+    // situacao ( N-normal  S-cancelado   E ou X )
                 strspace(lista[13],1)+    // codigo da antecipacao 1 a 6
                 space(29);

      Freeandnil(lista);
    end;

/////////


    function Getformato70(dados:string):string;    // conhecimentos de transporte
    //////////////////////////////////////////////////////////////////
    var Lista:TStringlist;

        function GetInsEst(s:string):string;
        //////////////////////////////////////
        var d:string;
        begin
          if trim(s)='' then
            d:=strspace('ISENTO',14)
          else
            d:=strspace(s,14);
          result:=d;
        end;

    begin
// 29.07.14
      if pos('70',registrosparanaogerar)>0 then begin
        result:='';
        exit;
      end;

      lista:=tstringlist.create;
      strtolista(Lista,dados,';',true);
// 05.03.14
//      if (trim(xserie)='0') and (Global.UFUnidade='PR') then xserie:=' ';  // 11.02.12 validapr nao aceita
//      if (Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimento) and (Global.UFUnidade='PR') then xserie:='U';  // 12.11.13 validapr nao aceita
      if lista.count=0 then
        result:=''
      else
        result:='70'+
                 strspace(lista[0],14)+
                 GetInsEst( lista[1] )+
                 FGeral.DataStringinvertida(lista[2])+
                 strspace(lista[3],2)+   // UF
                 strspace(lista[4],2)+   // Modelo
                 strspace(lista[5],1)+   // Serie
                 '  '+                   // subserie chupisca - 21.03.07
                 strzero(strtoint(lista[6]),6)+    // NUmero
                 strspace(lista[7],4)+   // /cfop
                 FGeral.Exportanumeros(texttovalor(lista[08]),13,2)+   // total nf
                 FGeral.Exportanumeros(texttovalor(lista[09]),14,2)+   // base icms
                 FGeral.Exportanumeros(texttovalor(lista[10]),14,2)+   // valor icms
                 FGeral.Exportanumeros(texttovalor(lista[11]),14,2)+   // isentas
                 FGeral.Exportanumeros(texttovalor(lista[12]),14,2)+   // outras
                 strspace( lista[13],1 )+                              // cif/fob
                 strspace( lista[14],1 ) ;    // situacao ( N-normal  S-cancelado   E ou X )

      Freeandnil(lista);
    end;

    function Getformato71(dados:string):string; // notas dos conhecimentos de transporte
    //////////////////////////////////////////////////////////////////
    var Lista:TStringlist;

        function GetInsEst(s:string):string;
        ////////////////////////////////////
        var d:string;
        begin
          if trim(s)='' then
            d:=strspace('ISENTO',14)
          else
            d:=strspace(s,14);
          result:=d;
        end;

    begin
      lista:=tstringlist.create;
      strtolista(Lista,dados,';',true);
      if lista.count=0 then
        result:=''
      else
        result:='71'+
                 strspace(lista[0],14)+
                 GetInsEst( lista[1] )+
                 FGeral.DataStringinvertida(lista[2])+
                 strspace(lista[3],2)+   // UF
                 strspace(lista[4],2)+   // Modelo
                 strspace(lista[5],3)+   // Serie
                 strzero(strtoint(lista[6]),6)+    // NUmero
//                 strspace(lista[7],4)+   // /cfop
//
                 strspace(lista[17],2)+   // UF
                 strspace(lista[15],14)+
                 GetInsEst( lista[16] )+
                 FGeral.DataStringinvertida(lista[18])+
                 strspace(lista[19],2)+   // Modelo
                 strspace(lista[20],3)+   // Serie
                 strzero(strtoint(lista[21]),6)+    // NUmero
                 FGeral.Exportanumeros(texttovalor(lista[22]),14,2)+   // total nf
                 space(12);  // 16.01.13
                 ;

      Freeandnil(lista);
    end;

/////////////// 15.08.11
///////// total de nota ref. exportacao
    function Getformato85(dados:string):string;
    ///////////////////////////////////////////
    var Lista:TStringlist;
    begin
    ////////////
      lista:=tstringlist.create;
      strtolista(Lista,dados,';',true);
      if lista.count=0 then
        result:=''
      else
        result:='85'+
                 strzero( strtoint(lista[0]),11 )+  // num. declaracao exportacao
                 FGeral.DataStringinvertida(lista[1])+  // data da declaracao
                 strspace(lista[2],1)+   // tabela de 1 a 4
                 strzero( strtoint(lista[3]),12 )+  // REGISTRO de exportacao
                 FGeral.DataStringinvertida(lista[1])+  // data do registro
                 strspace('PROPRIO',16)+    // 'proprio' - numero do conhec. embarque
//                 strzero( 0,8 )+     // data do conhecimento
//                 space( 08 )+     // data do conhecimento   quando nao tem conhec....
// valida pr nao aceitou os 8 zeros...
                 FGeral.DataStringinvertida(lista[1])+  // data do conhecimento
                 '99'+   // tipo do conhec. 'AWB' , etc tabela...
                 strspace( copy(Lista[4],1,4) ,04 )+    // codigo do pais de destino
                 strzero( 0,8 )+     // filler
                 FGeral.DataStringinvertida(lista[1])+  // data averbacao decl. export.
                 strzero(strtoint(lista[5]),6)+    // NUmero da nf de export. emit. exportador
                 FGeral.DataStringinvertida(lista[1])+  // data emissao desta nota
                 strspace(lista[6],2)+   // Modelo
                 strspace(lista[7],3)+   // Serie
                 space(19);

      Freeandnil(lista);
    end;
/////////////// 17.08.11
///////// itens de nota ref. exportacao
    function Getformato86(dados:string):string;
    ///////////////////////////////////////////
    var Lista:TStringlist;

        function GetInsEst(s:string):string;
        ///////////////////////////////////
        var d:string;
        begin
          if (trim(s)='')  then
            d:='ISENTO'
          else if  Q.fieldbyname('moes_tipocad').asstring='C' then begin
            if QGeral.fieldbyname('clie_tipo').asstring='F' then
              d:='ISENTO'
            else
              d:=copy(s,1,14);
          end else
            d:=copy(s,1,14);
          result:=strspace(d,14);
        end;

        function GetCnpjCpf(s:string ; tam:integer):string;
        /////////////////////////////////////////////////////
        var d,t:string;
        begin
          if Q.fieldbyname('moes_tipocad').asstring='C' then
            t:='Cliente'
          else if Q.fieldbyname('moes_tipocad').asstring='F' then
            t:='Fornecedor'
          else if Q.fieldbyname('moes_tipocad').asstring='R' then
            t:='Representante'
          else
            t:='Unidade';
          if trim(s)='' then begin
            Texto.lines.add('Codigo '+Q.fieldbyname('moes_tipo_codigo').asstring+' de '+t+' sem CNPJ/CPF');
            d:=strzero(0,14);
          end else if length(trim(s))<tam then
            d:='000'+strspace( copy(s,1,11) ,11 )
          else
            d:=strspace(copy(s,1,14),tam);
          result:=d;
        end;

    begin
    //////////////////////////////////
      lista:=tstringlist.create;
      strtolista(Lista,dados,';',true);
      if lista.count=0 then
        result:=''
      else
        result:='86'+
                 strzero( strtoint(lista[  11 ]),12 )+  // REGISTRO de exportacao
                 FGeral.DataStringinvertida(lista[ 06 ])+  // data do registro
                 GetCnpjCpf( lista[0],14 )+
                 GetInsEst( lista[ 01 ] )+
                 strspace(lista[  05 ],2)+   // UF
                 strzero(strtoint(lista[3]),6)+    // NUmero
                 FGeral.DataStringinvertida(lista[ 06 ])+  // data nota
                 strspace(lista[04],2)+   // Modelo
                 strspace(lista[02],3)+   // Serie
                 strspace(lista[7],14)+   // codigo produto
                 FGeral.Exportanumeros(texttovalor(lista[08]),11,3)+   // qtde
                 FGeral.Exportanumeros(texttovalor(lista[ 09 ]),12,2)+  // valor unitario do item
                 FGeral.Exportanumeros(texttovalor(lista[ 10 ]),12,2)+   // valor do item ( qtde*unitario )
                 '0'+   // tabela de 0 a 3 cfe RIcms
                 space(05) ; // filler
      Freeandnil(lista);
    end;

/////////

/////////


///////////////////////////////////////

////////////////////////////////////////////////////////////////////
    function GetModelo(tipomov:string):string;
    ////////////////////////////////////////////
//modelo de documento fiscal     01 - nf modelo 1 ou 1A     02 - nf venda consumidor modelo 2
//                               04 - nf produtor   e MAIS UM MONTE...
    begin
      result:='01';
// 21.01.10 - nfe
      if ( ( Q.fieldbyname('moes_dtnfecanc').AsDateTime>1 ) or
         ( Q.fieldbyname('moes_dtnfeauto').AsDateTime>1 ) ) and
         (  NumSerieCertificado<>'' )
         then
         result:='55'
// 10.04.12
      else if uppercase(Q.fieldbyname('moes_especie').AsString)='NFE' then
         result:='55'
      else if pos(tipomov,Global.CodConhecimento+';'+Global.CodConhecimentoSaida)>0 then begin
        result:='08';
// 29.07.10 - Clessi
        if uppercase(Q.fieldbyname('moes_especie').AsString)='CTE' then begin
          result:='57';
// 12.11.13 - validapr nao aceita 57
          if EdUnid_codigo.ResultFind.FieldByName('unid_uf').asstring='PR' then
            result:='08';
        end;
// 23.03.07
      end else if pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,2,3),'251;252;253') > 0 then
        result:='06'    // contas de energia eletrica
// 08.07.09 - novicarnes
      else if pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,2,3),'302;303') > 0 then
        result:='22'    // contas de telefone
// 05.07.10 - Granzotto - NF venda consumidor
      else  if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'567')>0 ) then begin
           Result:='02';
        end;
    end;


    function GetCidade(tipocad:string):string;
    ////////////////////////////////////////////
    begin
      if tipoCad='U' then
        result:=Arq.TUnidades.fieldbyname('unid_municipio').asstring
      else if tipoCad='R' then
        result:=FRepresentantes.GetDescricao(Arq.TRepresentantes.fieldbyname('repr_cida_codigo').asinteger)
      else if tipoCad='F' then
        result:=FFornece.GetNome(Arq.TFornec.fieldbyname('forn_cida_codigo').asinteger)
      else if tipoCad='T' then
        result:=FTransp.GetNome(Arq.TTransp.fieldbyname('tran_cida_codigo').asstring)
      else
        result:=FCadcli.GetNome(Arq.TClientes.fieldbyname('clie_cida_codigo_res').asinteger);
    end;

    function GetUF(tipocad:string;codigo:integer):string;
    /////////////////////////////////////////////////////////
    begin
      if tipoCad='U' then
        result:=FUnidades.GetUF(strzero(codigo,3))
      else if tipoCad='R' then
        result:=FCidades.GetUF(codigo)
      else if tipoCad='F' then
        result:=FFornece.getuf(codigo)
      else if tipoCad='T' then
        result:=FTransp.GetUF(codigo)
      else
        result:=FCadcli.Getuf(codigo);
      if result='XX' then
        result:=EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring;
    end;

    function GetCEP(tipocad:string):string;
    ///////////////////////////////////////////
    begin
      if tipoCad='U' then
        result:=EdUnid_codigo.resultfind.fieldbyname('unid_cep').asstring
      else if tipoCad='R' then
        result:=Arq.TRepresentantes.fieldbyname('repr_cep').asstring
      else if tipoCad='F' then
        result:=QGeral.fieldbyname('forn_cep').asstring
      else if tipoCad='T' then
        result:=Arq.TTransp.fieldbyname('tran_cep').asstring
      else
        result:=QGeral.fieldbyname('clie_cepres').asstring;
    end;

    function TemAliquota(aliq:currency):boolean;
    ////////////////////////////////////////////////////
    var p:integer;
    begin
      result:=false;
      for p:=0 to ListaAliquotas.count-1 do begin
        if texttovalor( Listaaliquotas[p] ) = aliq then begin
          result:=true;
          break
        end;
      end;
    end;

// 11.02.08
///////////////////////////////////
    function TemBase(base:currency):boolean;
    ////////////////////////////////////////////
    var p:integer;
    begin
      result:=false;
      for p:=0 to ListaBases.count-1 do begin
//        if texttovalor( Listabases[p] ) = base then begin
//        if strtocurr( Listabases[p] ) = base then begin
        if roundvalor(texttovalor( Listabases[p] ) ) = base then begin
          result:=true;
          break
        end;
      end;
    end;

// 04.03.08
///////////////////////////////////
    function TemCfop(xcfop:string):boolean;
    /////////////////////////////////////////
    var p:integer;
    begin
      result:=false;
      if trim(xcfop)='' then begin   // 10.09.08
        result:=true;
        exit;
      end;
      for p:=0 to ListaCfops.count-1 do begin
        if ListaCfops[p]=xcfop then begin
          result:=true;
          break
        end;
      end;
    end;

// 18.12.09
///////////////////////////////////
    function TemCST(xcst:string):boolean;
    var p:integer;
    begin
      result:=false;
      if trim(xcst)='' then begin
        result:=true;
        exit;
      end;
      for p:=0 to ListaCSTs.count-1 do begin
        if ListaCSTs[p]=xcst then begin
          result:=true;
          break
        end;
      end;
    end;
///////////////////////

    function GetformatoPisCofins(dados,tiporeg:string):string;
    ///////////////////////////////////////////////////////////////////////////
    var Lista:TStringlist;
        QP:TSqlquery;
        TipoPessoa,Socio:string;

        function GetCnpjCpf(s:string ; tam:integer):string;
        var d,t:string;
        begin
          if Q.fieldbyname('moes_tipo_codigo').asstring='C' then
            t:='Cliente'
          else if Q.fieldbyname('moes_tipo_codigo').asstring='F' then
            t:='Fornecedor'
          else if Q.fieldbyname('moes_tipo_codigo').asstring='R' then
            t:='Representante'
          else
            t:='Unidade';
          if trim(s)='' then begin
            Texto.lines.add('Codigo '+Q.fieldbyname('moes_tipo_codigo').asstring+' de '+t+' sem CNPJ/CPF');
            d:=strzero(0,14);
          end else if length(trim(s))<tam then
            d:='000'+strspace( copy(s,1,11) ,11 )
          else
            d:=strspace(copy(s,1,14),tam);
          result:=d;
        end;

        procedure PosicionaCliFor(codigo:integer;tipocad:string);
        begin
          if tipocad='F' then begin
            TipoPessoa:='PJ';
            Socio:='NAO SOCIO';
            QP:=Sqltoquery('select Forn_inscricaoestadual,''N'' as socios from fornecedores where forn_codigo='+inttostr(codigo));
            if not QP.eof then begin
              if trim(QP.fieldbyname('Forn_inscricaoestadual').asstring)='' then
                TipoPessoa:='PF';
            end;
          end else begin
            TipoPessoa:='PJ';
            QP:=Sqltoquery('select clie_tipo,clie_contacotacap from clientes where clie_codigo='+inttostr(codigo));
            Socio:='NAO SOCIO';
            if not QP.eof then begin
              if QP.fieldbyname('clie_tipo').asstring='F' then begin
                TipoPessoa:='PF';
                if QP.fieldbyname('clie_contacotacap').asinteger>0 then
                  Socio:='SOCIO';
              end;
            end
          end;
          FGeral.FechaQuery(QP);
        end;

    begin
    ////////////////////////////////////////////////////////////////
      lista:=tstringlist.create;
      strtolista(Lista,dados,';',true);
      if lista.count=0 then
        result:=''
      else begin
        try
//          if trim(lista[5])='' then
//            Texto.lines.add('Documento '+lista[3]+' Cfop '+lista[4]+' Produto '+lista[7]+' sem CST');
          PosicionaCliFor(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asString);
          if tiporeg='54' then begin
            result:=EdUNid_codigo.text+
                 separa+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime)+
                 separa+datanota+
                 separa+Q.fieldbyname('moes_especie').AsString+
                 separa+strzero(strtoint(lista[3]),6)+    // NUmero
                 separa+strspace(lista[2],3)+   // Serie
                 separa+'VALIDO'+
                 separa+strspace(lista[4],4)+   // /cfop
                 separa+Q.fieldbyname('moes_comv_codigo').asstring+
                 separa+FConfMovimento.GetDescricao(Q.fieldbyname('moes_comv_codigo').asinteger)+
                 separa+FGrupos.GetDescricao( Q.fieldbyname('move_grup_codigo').asinteger )+
                 separa+FSubgrupos.GetDescricao( Q.fieldbyname('move_sugr_codigo').asinteger )+
                 separa+strspace(lista[7],14)+   // codigo produto
                 separa+FEstoque.getdescricao(lista[7])+   // descricao produto
                 separa+strspace(lista[6],3)+   // /sequencial produtos
                 separa+FEstoque.GetNCMipi(Q.fieldbyname('move_esto_codigo').asstring)+
                 separa+FEstoque.GetUnidade(Q.fieldbyname('move_esto_codigo').asstring)+
                 separa+FGeral.Exportanumeros(texttovalor(lista[08]),11,3,'S')+   // qtde
                 separa+FGeral.Exportanumeros(texttovalor(lista[09]),12,2,'S')+   // valor do item ( qtde*unitario )
                 separa+FGeral.Exportanumeros(texttovalor(lista[13]),12,2,'S')+   // valor ipi
                 separa+FGeral.Exportanumeros(texttovalor(lista[12]),12,2,'S')+   // base icms subst. trib.
                 separa+GetCnpjCpf( lista[0],14 )+
                 separa+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asString,'N')+
                 separa+TipoPessoa+
                 separa+Socio;
          end else begin
            result:=EdUNid_codigo.text+
                 separa+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime)+
                 separa+datanota+
                 separa+Q.fieldbyname('moes_especie').AsString+
                 separa+strzero(strtoint(lista[3]),6)+    // NUmero
                 separa+strspace(lista[2],3)+   // Serie
                 separa+'VALIDO'+
                 separa+strspace(lista[4],4)+   // /cfop
                 separa+Q.fieldbyname('moes_comv_codigo').asstring+
                 separa+FConfMovimento.GetDescricao(Q.fieldbyname('moes_comv_codigo').asinteger)+
                 separa+''+
                 separa+''+
                 separa+strspace(lista[7],14)+   // codigo produto
                 separa+strspace(lista[6],3)+   // /sequencial produtos
                 separa+''+
                 separa+''+
                 separa+FGeral.Exportanumeros(1,11,3,'S')+   // qtde
                 separa+FGeral.Exportanumeros(texttovalor(lista[10]),12,2,'S')+   // valor do item ( qtde*unitario )
                 separa+FGeral.Exportanumeros(texttovalor(lista[13]),12,2,'S')+   // valor ipi
                 separa+FGeral.Exportanumeros(texttovalor(lista[12]),12,2,'S')+   // base icms subst. trib.
                 separa+GetCnpjCpf( lista[0],14 )+
                 separa+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.fieldbyname('moes_tipocad').asString,'N')+
                 separa+TipoPessoa+
                 separa+Socio;
          end;
        except
           Avisoerro( lista[0]+';'+lista[1]+';'+lista[2]+';'+lista[3]+';'+lista[4]+';'+lista[5] )
//           Avisoerro( lista[0] )
        end;
      end;
      Freeandnil(lista);
    end;

// 05.07.10
    function Getformato61(dados:string):string;
    ///////////////////////////////////////////
    var Lista:TStringlist;
    begin
      lista:=tstringlist.create;
      strtolista(Lista,dados,';',true);
      if lista.count=0 then
        result:=''
      else begin
          result:='61'+separador+
                 space( 14 )+
                 Space( 14 )+
                 FGeral.DataStringinvertida(lista[2])+  // emissao
//                 strspace(lista[3],2)+   // UF
                 strspace(lista[4],2)+separador+   // Modelo
                 strspace( copy(lista[5],1,3) ,3)+separador+   // Serie
                 space( 02 )+separador+   // Sub-Serie
                 strzero(strtoint(lista[6]),6)+separador+    // NUmero
                 strzero(strtoint(lista[6]),6)+separador+    // NUmero
//                 strspace( copy(lista[7],1,4),4)+separador+   // /cfop
//                 strspace(lista[8],1)+   // P - proprio  T-terceiros
                 FGeral.Exportanumeros(texttovalor(lista[09]),13,2)+separador+   // total nf
                 FGeral.Exportanumeros(texttovalor(lista[10]),13,2)+separador+   // base icms
                 FGeral.Exportanumeros(texttovalor(lista[11]),12,2)+separador+   // valor icms
                 FGeral.Exportanumeros(texttovalor(lista[12]),13,2)+separador+   // isentas
                 FGeral.Exportanumeros(texttovalor(lista[13]),13,2)+separador+   // outras
                 FGeral.Exportanumeros(texttovalor(lista[14]),04,2)+separador+   // aliquota icms
                 space( 1 ) ;
      end;
      Freeandnil(lista);
    end;


begin
/////////////////////////////////////////////////////////////////////

//  if not EdUnid_codigo.validfind then exit;
  if not EdUnid_codigo.valid then exit;
  if not EdTermino.valid then exit;
  if not confirma('Confirma exporta��o ?') then exit;
  texto.clear;
  registrosparanaogerar:='';
// 29.07.14 - Vivan - escritorio Contafix
  if Edsoecf.text='S' then
     registrosparanaogerar:='50;54;70';
//     registrosparanaogerar:='50;54;60A;70';
/////////////
  sistema.beginprocess('Pesquisando conhecimentos');
  Lista70:=TStringlist.create;
  Lista50:=TStringlist.create;
  Lista53:=TStringlist.create;
  Lista85:=TStringlist.create;
  Lista86:=TStringlist.create;
  Lista53Ordem:=TStringlist.create;
//  Lista50Teste:=TStringlist.create;
  Lista51:=TStringlist.create;
  Lista51Ordem:=TStringlist.create;
  Lista50A:=TStringlist.create;
// 14.05.09
  ListaPisCofins:=TStringlist.create;
// 27.02.11
  Lista71:=TStringlist.create;
  separa:=';';
  totalipi:=0;totaldesco:=0;totalfrete:=0;totalsubs:=0;totalent:=0;totalsai:=0;
//
// 22.01.10
  NumSerieCertificado:=trim( FGeral.GetConfig1AsString('NumSerieCert') );
// 05.07.10
  Lista61:=TStringlist.create;
  Sqlunidades:=' and moes_unid_codigo='+EdUnid_codigo.assql;
  if Global.Topicos[1015] then
    Sqlunidades:=' and '+FGeral.GetIN('moes_unid_codigo',EdUnidades.text,'C');
  Q:=sqltoquery('select * from movesto'+
                ' inner join natureza on (natf_codigo=moes_natf_codigo)'+
                ' where '+FGeral.Getin('moes_status','N','C')+' and moes_datamvto>='+EdInicio.assql+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and '+FGeral.Getin('moes_tipomov',Global.CodConhecimento+';'+Global.CodConhecimentoSaida,'C')+
                ' and moes_datacont is not null'+
                sqlunidades+
                ' and moes_natf_codigo is not null'+
//                ' order by moes_transacao,moes_datamvto,moes_numerodoc' );
// 16.10.08 - 'ordem chupisca' da receita
                ' order by moes_datamvto,moes_numerodoc' );
  while not Q.eof do begin
// 22.03.07
      QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(q.fieldbyname('moes_transacao').asstring)+
                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('moes_tipomov').asstring));

      datanota:=Q.fieldbyname('moes_datamvto').asstring;
// 07.05.14
      xserie:=copy(Q.fieldbyname('moes_serie').asstring,1,1);
      if (EdUnid_codigo.ResultFind.FieldByName('unid_uf').asstring='PR') and
         (Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimento) and
         (Q.fieldbyname('moes_especie').asstring='CTE' )
         then
        xserie:='U';
///////////////
      linha:=GetFormato70( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 datanota+';'+
                 Q.fieldbyname('moes_estado').asstring+';'+
                 GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                 xserie+';'+
                 Q.fieldbyname('moes_numerodoc').asstring+';'+
                 copy(Q.fieldbyname('moes_natf_codigo').asstring,1,4)+';'+
                 Q.FieldByName('moes_vlrtotal').Asstring+';'+
//                 Q.FieldByName('moes_baseicms').Asstring+';'+
                 QMovbase.FieldByName('movb_basecalculo').Asstring+';'+
                 QMovbase.FieldByName('movb_imposto').Asstring+';'+
                 valortosql( 0 )+';'+
                 valortosql( 0 )+';'+
                 Q.FieldByName('moes_freteciffob').asstring+';'+
                 'N'+';' );
// 29.07.14 - vivan
     if trim(linha)<>'' then
       Lista70.Add(linha);
// 27.02.12
     if Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimentoSaida then begin
       Q71:=sqltoquery('select * from movesto where moes_transacao='+Stringtosql(Q.FieldByName('moes_transacao').asstring)+
                       ' and moes_status='+stringtosql('M')+
                       ' order by moes_datamvto' );
       while not Q71.eof do begin
         linha:=GetFormato71( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 datanota+';'+
                 Q.fieldbyname('moes_estado').asstring+';'+
                 GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                 copy(Q.fieldbyname('moes_serie').asstring,1,1)+';'+
                 Q.fieldbyname('moes_numerodoc').asstring+';'+
                 copy(Q.fieldbyname('moes_natf_codigo').asstring,1,4)+';'+
                 Q.FieldByName('moes_vlrtotal').Asstring+';'+
//                 Q.FieldByName('moes_baseicms').Asstring+';'+
                 QMovbase.FieldByName('movb_basecalculo').Asstring+';'+
                 QMovbase.FieldByName('movb_imposto').Asstring+';'+
                 valortosql( 0 )+';'+
                 valortosql( 0 )+';'+
                 Q.FieldByName('moes_freteciffob').asstring+';'+
                 'N'+';'+
// dados do fornecedor das notas acobertadas pelo conhecimento emitido
                 FGeral.GetCnpjCpfTipoCad(Q71.fieldbyname('Moes_tipo_codigo').asinteger,Q71.fieldbyname('Moes_tipocad').asstring)+';'+
                 FGeral.GetInscEstadualTipoCad(Q71.fieldbyname('Moes_tipo_codigo').asinteger,Q71.fieldbyname('Moes_tipocad').asstring)+';'+
                 Q71.fieldbyname('moes_estado').asstring+';'+  // 17
                 Q71.fieldbyname('moes_datamvto').asstring+';'+ // 18
                 GetModelo(Q71.fieldbyname('moes_tipomov').asstring)+';'+  //19
                 copy(Q71.fieldbyname('moes_serie').asstring,1,1)+';'+   // 20
                 Q71.fieldbyname('moes_numerodoc').asstring+';'+  //21
                 Q71.FieldByName('moes_vlrtotal').Asstring        //22
                  );
          Lista71.Add(linha);
          Q71.Next;
       end;
       FGeral.FechaQuery(Q71);
     end;
// 15.05.09
     if EdCreditopiscofins.Text='S' then begin
        linha:=GetFormatoPisCofins( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                 Q.fieldbyname('moes_serie').asstring+';'+
//                 space(02)+';'+   // subserie
                 Q.fieldbyname('moes_numerodoc').asstring+';'+
                 copy(Q.fieldbyname('moes_natf_codigo').asstring,1,4)+
                 ';'+
                 ';'+
                 xcst+';'+
                 strzero(contitem,3)+
                 ';'+
                 ''+
                 ';'+
                 ''+
                 ';'+
                 Q.FieldByName('moes_vlrtotal').Asstring+';'+
                 Valortosql(0)+';'+
                 QMovbase.FieldByName('movb_basecalculo').Asstring+';'+
                 Valortosql(0)+';'+
                 Valortosql(0)+';'+
                 QMovbase.FieldByName('movb_aliquota').Asstring , '70' );
{////////////////////////////////
                 DataNota+';'+
                 Q.fieldbyname('moes_dataemissao').asdatetime+';'+
                 Q.fieldbyname('moes_especie').asstring+';'+
                 Q.fieldbyname('moes_comv_codigo').asstring+';'+
                 FConfMovimento.GetDescricao(Q.fieldbyname('moes_comv_codigo').asinteger)+';')
/////////////////////////}
        ListaPisCofins.add(linha);
     end;

     FGeral.Fechaquery(QMovbase);
     Q.Next;
  end;
  FGeral.Fechaquery(q);
////////////
  sistema.beginprocess('Pesquisando documentos');
// 01.06.11 - VI - damama marmitas
  tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+Global.CodContrato+';'+
            Global.CodVendaInterna;
// 15.09.11 - romaneios capeg e para ficar padrao com a exportacao para o fiscal
  tiposmov:=Global.TiposExpFiscalNotas;

// 19.08.10
  SqlunidadesDet:=' and move_unid_codigo='+EdUnid_codigo.assql;
  if Global.Topicos[1015] then
    SqlunidadesDet:=' and '+FGeral.GetIN('move_unid_codigo',EdUnidades.text,'C');

  Q:=sqltoquery('select * from movestoque'+
                ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
//                ' inner join movbase on (movb_transacao=move_transacao)'+
//                ' left join movbase on (movb_transacao=moes_transacao)'+
// 21.03.07 - se deixar o movbase pode 'enuplicar' os itens
                ' inner join natureza on (natf_codigo=moes_natf_codigo)'+
                ' where '+FGeral.Getin('move_status','N;X;E;D;Y','C')+' and move_datamvto>='+EdInicio.assql+
                ' and '+FGeral.Getin('moes_status','N;X;E;D;Y','C')+' and move_datamvto>='+EdInicio.assql+
                ' and move_datamvto<='+EdTermino.assql+
// 01.09.08
//                ' and '+FGeral.GetNOTIN('moes_serie','F;F ','C')+
// 21.01.09
//                ' and '+FGeral.GetNOTIN('moes_serie','F;F ;D;D ','C')+
// 05.07.10 - Notas Serie 2 - Venda Consumidor tem q gerar
                ' and '+FGeral.GetNOTIN('moes_serie','F;F ','C')+
// 22.06.09 - Ligiane
                ' and '+FGeral.GetNOTIN('moes_especie','CF;CF ;','C')+
// 15.12.15  - NFC-e
                ' and '+FGeral.GetNOTIN('moes_especie','NFC;NFCE;','C')+
                ' and '+FGeral.GetNOTIN('moes_tipomov',tiposnao+';'+Global.CodConhecimento+';'+Global.CodConhecimentoSaida,'C')+
// 15.09.11 - Capeg - romaneios e padronizao com exportacao fiscal
                ' and '+FGeral.GetIN('moes_tipomov',tiposmov,'C')+
//
                ' and move_datacont is not null'+
                sqlunidadesdet+
//                ' and moes_natf_codigo>0'+
                ' and moes_natf_codigo is not null'+
//                ' order by move_datamvto' );
//                ' order by move_transacao,move_datamvto,move_numerodoc' );
// 23.10.07
                ' order by move_transacao,move_datamvto,move_numerodoc,move_aliicms' );
  if Q.eof then begin
    Avisoerro('Nao encontrado notas fiscais para exporta��o.  Ser� gerado SEM movimento ou somente com conhecimentos');
//    sistema.endprocess('');
//    exit;
// 25.06.10 - gerar zerado - Abra
  end;

  Lista10:=TStringlist.create;
  Lista11:=TStringlist.create;

  Lista54:=TStringlist.create;
  Lista74:=TStringlist.create;
  Lista75:=TStringlist.create;
  Lista75aux:=TStringlist.create;
  Lista88:=TStringlist.create;

  Sistema.beginprocess('Exportando movimento de entrada e saida');
  n:=0;
  valorzero:=0;isentas:=0;outras:=0;valoricmsst:=0;baseicmsst:=0;
  totalregE:=0;totalregS:=0;totalregR:=0;totalregC:=0;baseicms:=0;vlricms:=0;
// 13.11.07
  separador:='';
  if EdCreditopiscofins.Text='S' then begin
    nomearqE:='ENTRADAS'+strzero(DatetoAno(EdTermino.AsDate,true),4)+EdUNid_codigo.resultfind.fieldbyname('unid_nome').asstring;
    nomearqS:='SAIDAS'+strzero(DatetoAno(EdTermino.AsDate,true),4)+EdUNid_codigo.resultfind.fieldbyname('unid_nome').asstring;
  end else begin
    nomearqE:='';
    nomearqS:='';
  end;
// 13.08.10
//  nomearq:='\SAC\SI'+EdUnid_codigo.text+copy(EdTermino.text,3,4);
// 12.12.13
  nomearq:=ExtractFilePath( Application.ExeName )+'SI'+EdUnid_codigo.text+copy(EdTermino.text,3,4);
// 29.07.14 - Vivan
  if EdSoecf.text='S' then nomearq:=ExtractFilePath( Application.ExeName )+'ECF'+EdUnid_codigo.text+copy(EdTermino.text,3,4);

  while not Q.eof do begin

//    Sistema.setmessage('Exportando movimento de entrada e saida - mestre '+Q.fieldbyname('moes_transacao').asstring);
    Sistema.setmessage('Exportando movimento de entrada e saida - mestre '+fGeral.formatadata(Q.fieldbyname('moes_datamvto').asdatetime));
//    if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposMovMovEntrada)>0 then begin
// 10.06.08 - CI - Novicarnes 'entendia' como saida...
    if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin
      es:='E';
      inc(totalregE);
//    end else if pos(Q.fieldbyname('moes_tipomov').asstring,Global.CodConhecimento)>0 then begin
//      es:='C';
    end else begin
      es:='S';
      inc(totalregS);
    end;
//    if Q.fieldbyname('moes_status').asstring='X' then
//      cfop:='   0'
//    else if Q.fieldbyname('moes_status').asstring='Y' then
//      cfop:='   0'
//    else
// 07.10.10 - Abra - Unidade Pato Branco - ValidaPr nao aceita sem cfop mesmo cancelada
      cfop:=copy(Q.fieldbyname('moes_natf_codigo').asstring,1,4);

    contitem:=1;
    vlrseguro:=0;  //  REVER
    vlrpiscofins:=0;
    if Es='E' then begin
// 15.02.2012 - para benato
//      if  Q.fieldbyname('moes_vispra').asstring='V' then
      if ( Q.fieldbyname('moes_dataemissao').asdatetime<=EdTermino.asdate ) and
         ( Q.fieldbyname('moes_dataemissao').asdatetime>=EdInicio.asdate ) then
        datanota:=Q.fieldbyname('moes_dataemissao').asstring
      else
        datanota:=Q.fieldbyname('moes_datamvto').asstring;
      vlrfrete:=0;  // 21.03.07  - nf de entrada � s� para entrar no custo do produto
// 03.07.14 - caso o frete estiver destacado na nota - Metalforte
       if Q.fieldbyname('moes_freteciffob').asstring='2' then
         vlrfrete:=q.fieldbyname('moes_frete').ascurrency;
    end else begin
      datanota:=Q.fieldbyname('moes_dataemissao').asstring;
      vlrfrete:=q.fieldbyname('moes_frete').ascurrency;
    end;

    QMovbase:=sqltoquery('select count(*) as ncfops from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring)+
//                           ' group by movb_natf_codigo');
// 10.07.09 - mudado para contar aliquotas e nao cfops...
                           ' group by movb_aliquota');
    aliqsicms:=0;
    while not QMovbase.eof do begin
      inc(aliqsicms);
      QMovbase.next;
    end;
// aqui em 21.03.07
    FGeral.FechaQuery(QMovbase);
// 10.07.09
    QMovbase:=sqltoquery('select movb_natf_codigo,count(*) as ncfops from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring)+
                           ' group by movb_natf_codigo');
    numcfops:=0;numcfopsST:=0;
    while not QMovbase.eof do begin
      inc(numcfops);
// 15.04.14
      if pos(QMovbase.fieldbyname('movb_natf_codigo').asstring,cfopscomST)>0 then
        inc(numcfopsST);
      QMovbase.next;
    end;
    FGeral.FechaQuery(QMovbase);
/////////////////////////

    QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring)+
//                           ' and movb_natf_codigo<>'+stringtosql(cfop)+  // 12.03.08
//                           ' order by movb_aliquota');
// 07.10.10 - dobra no validapr o registro 50
                           'and movb_tipomov <> '+Stringtosql(Global.CodPrestacaoServicos)+
                           ' order by movb_natf_codigo');
    if pos(Qmovbase.fieldbyname('movb_status').asstring,'X;Y;I')>0 then
      situacaonota:='S'
    else
      situacaonota:='N';

    QMovbase.first;

    PesquisaEntidade(Q.fieldbyname('moes_tipocad').asstring,Q.fieldbyname('moes_tipo_codigo').asinteger);
// aqui em 23.10.07
    ListaAliquotas:=TStringlist.create;
    ListaBases:=TStringlist.create;
// 04.03.08
    ListaCfops:=TStringlist.create;
// 18.12.09
   ListaCSTs:=TStringlist.create;

//    if Q.fieldbyname('Natf_produtos').asstring='T' then begin   // conhecimentos
//21.03.07 - nao acha os conhecimentos pois nao tem movestoque...


//     x:=q.fieldbyname('moes_transacao').asstring+q.fieldbyname('moes_datalcto').asstring+q.fieldbyname('moes_numerodoc').asstring;
// 28.06.04
//     x:=q.fieldbyname('moes_transacao').asstring+q.fieldbyname('moes_datamvto').asstring+q.fieldbyname('moes_numerodoc').asstring;

     x:=q.fieldbyname('move_transacao').asstring+q.fieldbyname('move_datamvto').asstring+q.fieldbyname('move_numerodoc').asstring;
////////////////////////////////////////////////////////////////////////////////////
// 21.03.07
//     codigofiscal:=FSittributaria.CSttoCF(Qmovbase.FieldByName('movb_cst').Asstring,Qmovbase.FieldByName('movb_unid_codigo').Asstring);
// 18.06.12 - Giacomoni + Esc. Asterio
     codigofiscal:=FSittributaria.CSttoCF(Qmovbase.FieldByName('movb_cst').Asstring,Qmovbase.FieldByName('movb_unid_codigo').Asstring,ES);
// 04.07.07
     if QMovbase.FieldByName('movb_reducaobc').AsCurrency>0 then
       codigofiscal:='2';
     isentas:=0;outras:=0;
     baseicms:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
// 04.07.07
     if Q.FieldByName('move_tipomov').AsString=Global.CodCompraProdutor then
       baseicms:=0;

     if ( pos( codigofiscal,'2;3' ) >0 ) and (QMovbase.FieldByName('movb_reducaobc').AsCurrency=0) then begin
//       isentas:=Q.FieldByName('moes_baseicms').AsCurrency
       isentas:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
       baseicms:=0;
// 04.07.07
     end else if ( pos( codigofiscal,'2;3' ) >0 ) and (QMovbase.FieldByName('movb_reducaobc').AsCurrency>0) then begin
       isentas:=QMovbase.FieldByName('movb_basecalculo').AsCurrency-(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
       baseicms:=(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
// 21.12.09 - Novi ref. 10.2007
       if ( aliqsicms=1 ) and ( numcfops=1 ) then begin
         isentas:=Q.FieldByName('moes_vlrtotal').AsCurrency-Q.FieldByName('moes_baseicms').AsCurrency;
         baseicms:=Q.FieldByName('moes_baseicms').AsCurrency;
       end;
////////////
     end else if codigofiscal='5' then begin
//       outras:=Q.FieldByName('moes_baseicms').AsCurrency
       if QMovbase.FieldByName('movb_reducaobc').AsCurrency>0 then begin
         outras:=QMovbase.FieldByName('movb_basecalculo').AsCurrency-(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
         baseicms:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100);
       end else begin
         outras:=Qmovbase.FieldByName('movb_basecalculo').AsCurrency;
         baseicms:=0;
       end;
// 19.12.11 - empresa do simples
//////////////////////////////////////
     end else if ( pos( FUnidades.GetSimples(Qmovbase.FieldByName('movb_unid_codigo').Asstring),'S;2' ) > 0 )
              and ( Es='S' )       then begin
       if QMovbase.FieldByName('movb_reducaobc').AsCurrency>0 then begin
         outras:=QMovbase.FieldByName('movb_basecalculo').AsCurrency-(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
         baseicms:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100);
       end else if QMovbase.FieldByName('movb_aliquota').Ascurrency>0 then begin
         outras:=0;
//         baseicms:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
// 13.12.13 - Metalforte - Escritorio  Aspef- Ivanka
         baseicms:=0;
       end else begin
         outras:=Qmovbase.FieldByName('movb_basecalculo').AsCurrency;
         baseicms:=0;
       end;

     end else
       outras:=Q.FieldByName('moes_valoripi').AsCurrency;
// 13.11.07
     if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 then begin
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
     end else begin
// 17.04.07
//       valornota:=QMovbase.FieldByName('movb_basecalculo').AsCurrency+Q.fieldbyname('moes_valoripi').ascurrency;
// 16.11.07
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
       if (Q.FieldByName('moes_tipomov').asstring=Global.CodVendaConsigMercantil) and (QMovbase.FieldByName('movb_basecalculo').AsCurrency=0) then begin
         valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency+Q.fieldbyname('moes_valoripi').ascurrency;
         baseicms:=Q.FieldByName('moes_baseicms').AsCurrency;
// 10.09.09
       end else if (Q.FieldByName('moes_tipomov').asstring=Global.CodCompraIndustria) and (QMovbase.FieldByName('movb_basecalculo').AsCurrency=0) then begin
         valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
         baseicms:=Q.FieldByName('moes_baseicms').AsCurrency;
       end;
     end;
// 04.07.07
     vlricms:=QMovbase.FieldByName('movb_imposto').Ascurrency;
     if ( QMovbase.FieldByName('movb_aliquota').Ascurrency>0 ) and (QMovbase.FieldByName('movb_basecalculo').AsCurrency>0) then
       vlricms:=baseicms*(QMovbase.FieldByName('movb_aliquota').Ascurrency/100);

     aliqicms:=QMovbase.FieldByName('movb_aliquota').Ascurrency;
// 13.12.13 - Metalforte - devolucoes tributadas
//////////////////////////////////////
     if ( pos( FUnidades.GetSimples(Qmovbase.FieldByName('movb_unid_codigo').Asstring),'S;2' ) > 0 )
                and ( Es='S' ) and ( numcfops=1 )  then begin
// 07.04.13 - Granzotto - Simples mas sujeito a ST - dai deixa o q tiver gravado no banco
       if (QMovbase.FieldByName('movb_aliquota').Ascurrency>0) and
         (  (pos(QMovbase.fieldbyname('movb_natf_codigo').asstring,cfopscomST)>0) OR
           (pos(QMovbase.fieldbyname('movb_tipomov').asstring,Global.CodDevolucaoTributada+';'+Global.CodDevolucaoCompra)>0)  ) then
         aliqicms:=QMovbase.FieldByName('movb_aliquota').Ascurrency
       else
         aliqicms:=0;
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
       vlricms:=0;
       baseicms:=0;
// 04.07.14
     end else if ( pos( FUnidades.GetSimples(Qmovbase.FieldByName('movb_unid_codigo').Asstring),'S;2' ) > 0 )
                and ( Es='S' ) and ( numcfops>1 )  then begin
       vlricms:=0;
       baseicms:=0;
     end;
// 23.10.07
     if QMovbase.fieldbyname('movb_natf_codigo').asstring<>'' then
       cfop50:=copy(QMovbase.fieldbyname('movb_natf_codigo').asstring,1,4)
     else
       cfop50:=cfop;

     if (Q.FieldByName('moes_tipomov').asstring=Global.Codcompraprodutor)
       or (situacaonota='S')
       or (Q.FieldByName('moes_tipomov').asstring=Global.CodPrestacaoServicos)
       then begin  // 16.09.10 - Abra
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
       baseicms:=0;
       vlricms:=0;
       aliqicms:=0;
     end;
// notas de combustivel elize...
     if baseicms>valornota then
        baseicms:=valornota;
     if (baseicms>0) and (vlricms=0) then begin
       baseicms:=0;
       valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
     end;
// 02.07.14 - colocado aqui calculo do desconto/acrescimeto independente do numero de cfops na nota
     vlracres:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(Q.fieldbyname('moes_peracres').ascurrency/100);
     vlrdesco:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100);
///////////////////////////
// 06.07.07                                                                              // 17.12.13
     if ( Q.FieldByName('moes_vlrtotal').AsCurrency>QMovbase.fieldbyname('movb_basecalculo').ascurrency ) and
        ( QMovbase.FieldByName('movb_basecalculo').AsCurrency>0 ) and ( aliqsicms=1 ) then begin
// 26.05.14 - saidas giacomoni q nao desmebrava correto por scfop na saida
       if numcfops=1 then
         valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency
       else
         valornota:=Qmovbase.FieldByName('movb_basecalculo').AsCurrency;
// 11.02.08 - entradas com mercadorias e servi�os cfops 1556 e 1933 e td lan�ado em 1556 - quando lanca o 'primeiro'
//            registro 50 desmembrando a nota
// 04.03.08
//       if (Q.fieldbyname('moes_vlrtotal').ascurrency>Q.fieldbyname('moes_totprod').ascurrency) and
//          (Q.fieldbyname('moes_natf_codigo').asstring='1556') and
//          (Q.fieldbyname('moes_totprod').ascurrency>0) then
//          valornota:=Q.fieldbyname('moes_totprod').ascurrency;
// 11.02.08  - 12.03.08
// 10.07.09 - caso tiver mais de um registro mas com mesma aliquota e cfop diferente
// 13.11.13 - tratamento de ipi e icms subst. trib. quando tem mais de um cfop
// 27.02.14 - ajustes segundo escritorio Daniel
// 09.05.14
        valoripi:=0;valoripidositens:=0;
        if( es='E' ) and ( Q.fieldbyname('moes_valoripi').ascurrency>0 ) then begin
          valoripidositens:=BuscaIPInositem(Q.FieldByName('moes_transacao').AsString, '' );
          if valoripidositens>0 then
            valoripi:=BuscaIPInositem(Q.FieldByName('moes_transacao').AsString, cfop50 )
          else begin
// 17.04.14 - trato notas 'da coca' com ipi somente em valor e aliquta 0
            if (Q.fieldbyname('moes_valoripi').ascurrency>0) then begin
               if Q.fieldbyname('moes_totprod').ascurrency>0 then begin
                 valoripi:=(Q.fieldbyname('moes_valoripi').ascurrency/Q.fieldbyname('moes_totprod').ascurrency)*100;
                 valoripi:=FGeral.Arredonda(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(valoripi/100),2) ;
               end else
                 valoripi:=0;
            end;
          end;
        end;
//        if numcfops>1 then begin
// 17.04.14
//        if Q.fieldbyname('moes_peracres').ascurrency>0 then
//          vlracres:=FGeral.Arredonda(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(Q.fieldbyname('moes_peracres').ascurrency/100),2)
          vlracres:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(Q.fieldbyname('moes_peracres').ascurrency/100);
//        else
//          vlracres:=0;
// 14.05.14 - Benatto
//        if numcfops>1 then
//          vlrdesco:=FGeral.Arredonda(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100),2)
          vlrdesco:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100);


// 15.04.14
//        if numcfops>=1 then begin  // rateio ST por cfop
// 07.05.14
        if (numcfops>=1) and (es='E') then begin  // rateio ST por cfop
          if numcfopsST=1 then
            valorSTporcfop:=Q.FieldByName('moes_valoricmssutr').AsCurrency
          else
            valorSTporcfop:=(Q.FieldByName('moes_valoricmssutr').AsCurrency/Q.FieldByName('moes_totprod').AsCurrency)*
                        QMovbase.FieldByName('movb_basecalculo').AsCurrency;
// 03.07.14 - Metalforte
          vlrfrete:=0;
          if (Q.fieldbyname('moes_frete').ascurrency>0) and ( Es='E' ) then begin
// 04.07.14
            if (numcfops=1) and (es='E') then begin  // rateio Frete por cfop
                vlrfrete  :=Q.fieldbyname('moes_frete').ascurrency;
            end else begin
              if Q.fieldbyname('moes_vlrtotal').ascurrency>0 then
                vlrfrete  :=(Q.fieldbyname('moes_frete').ascurrency/Q.fieldbyname('moes_totprod').ascurrency)*100;
              vlrfrete:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(vlrfrete/100);
            end;
            if Q.fieldbyname('moes_freteciffob').asstring<>'2' then vlrfrete:=0;
          end;
//////////////////////////////
          if pos(cfop50,'1556;2556;1401;1403;2403;1910;2910;')>0 then begin                                                                   // 20.02.14
//            valornota:=QMovbase.FieldByName('movb_basecalculo').AsCurrency+Q.FieldByName('moes_valoricmssutr').AsCurrency+(valoripi)
// 15.04.14
            valornota:=QMovbase.FieldByName('movb_basecalculo').AsCurrency+(valorSTporcfop)+(valoripi)+vlrfrete
          end else                                                            // 13.11.13
            valornota:=QMovbase.FieldByName('movb_basecalculo').AsCurrency+(valoripi)+vlrfrete;
        end;
     end  else if ( Q.FieldByName('moes_vlrtotal').AsCurrency>QMovbase.fieldbyname('movb_basecalculo').ascurrency ) and
        ( QMovbase.FieldByName('movb_basecalculo').AsCurrency>0 ) and ( aliqsicms>1 ) then begin
          valornota:=QMovbase.FieldByName('movb_basecalculo').AsCurrency+vlrdesco;
     end  else if ( Q.FieldByName('moes_vlrtotal').AsCurrency<Q.fieldbyname('moes_totprod').ascurrency ) and
        ( Q.FieldByName('moes_perdesco').AsCurrency>0 ) then
//          valornota:=QMovbase.FieldByName('movb_basecalculo').AsCurrency-vlrdesco;
// 03.07.14
        valornota:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;

     perdesco:=0;
     if (Q.FieldByName('moes_vlrtotal').AsCurrency<Q.FieldByName('moes_totprod').AsCurrency) and
        (Q.FieldByName('moes_baseicms').AsCurrency=0)
         then begin
       perdesco:= 100 - ( (Q.FieldByName('moes_vlrtotal').AsCurrency/Q.FieldByName('moes_totprod').AsCurrency)*100 );
       perdesco:=roundvalor(perdesco);
     end;
///////////////
{
// 23.07.07
     if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
        then begin    // entradas td em outras e valor contabil
        outras:=valornota;
        baseicms:=0;
        isentas:=0;
        vlricms:=0;
        aliqicms:=0;       // 10.07.09
     end;
     }
/////////////////////

// 05.07.10 - Granzotto - NF venda consumidor
     if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'567')>0 ) then begin
       linha:=GetFormato61( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 datanota+';'+Q.fieldbyname('moes_estado').asstring+';'+
                 GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                 Q.fieldbyname('moes_serie').asstring+';'+
                 Q.fieldbyname('moes_numerodoc').asstring+';'+
                 cfop50+';'+'P'+';'+    //P - o pr�prio estabelecimento emite  T - emitida por terceiros
//                 Q.FieldByName('moes_vlrtotal').Asstring+';'+     // para ver se considera o ipi no total da nota
                 Valortosql( valornota )+';'+   // 21.03.07
//                 Valortosql( Q.FieldByName('moes_baseicms').AsCurrency ) +';'+
//                 QMovbase.FieldByName('movb_basecalculo').Asstring+';'+
// 22.03.07
                 Valortosql( baseicms )+';'+
//                 QMovbase.FieldByName('movb_imposto').Asstring+';'+
                 Valortosql( vlricms )+';'+
                 Valortosql( isentas )+';'+
                 Valortosql( outras )+';'+
                 Valortosql( aliqicms )+';'+
//                 QMovbase.FieldByName('movb_aliquota').Asstring+';'+
                 situacaonota+';' );
                 Lista61.Add( linha );
// 14.07.11 - ECF - cupom fiscal
///////////
     end else if (  Q.FieldByName('moes_comv_codigo').asinteger=FGeral.GetConfig1AsInteger('ConfMovECF') )
                 and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'567')>0 )
                 and ( FGeral.GetConfig1AsInteger('ConfMovECF')>0 )  // 28.10.11
                 then begin

       linha:='x';  // nao gera Nada aqui // tem q buscar as reduzoes Z

     end else if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'123')>0 ) then begin
       linha:='x';  // nao gerada
     end else begin
// 02.12.15 - Nota cancelada ainda ficava com o % de icms
//  16.08.16 - colocado 'do valornota em diante'
      if situacaonota='S' then begin
        aliqicms:=0;
        valornota:=0;
        baseicms:=0;
        vlricms:=0;
        baseicms:=0;
        isentas:=0;
        outras:=0;
      end;
       linha:=GetFormato50( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 datanota+';'+Q.fieldbyname('moes_estado').asstring+';'+
                 GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                 Q.fieldbyname('moes_serie').asstring+';'+
                 Q.fieldbyname('moes_numerodoc').asstring+';'+
                 cfop50+';'+'P'+';'+    //P - o pr�prio estabelecimento emite  T - emitida por terceiros
//                 Q.FieldByName('moes_vlrtotal').Asstring+';'+     // para ver se considera o ipi no total da nota
                 Valortosql( valornota )+';'+   // 21.03.07
//                 Valortosql( Q.FieldByName('moes_baseicms').AsCurrency ) +';'+
//                 QMovbase.FieldByName('movb_basecalculo').Asstring+';'+
// 22.03.07
                 Valortosql( baseicms )+';'+
//                 QMovbase.FieldByName('movb_imposto').Asstring+';'+
                 Valortosql( vlricms )+';'+
                 Valortosql( isentas )+';'+
                 Valortosql( outras )+';'+
                 Valortosql( aliqicms )+';'+
//                 QMovbase.FieldByName('movb_aliquota').Asstring+';'+
                 situacaonota+';' );
        if trim(linha)<>'' then begin
          Lista50.Add( linha );
          Lista50A.Add(copy(linha,1,2)+copy(linha,31,8)+'['+linha );
          if pos( copy(cfop50,1,1),'1;2;3')>0 then
            totalent:=totalent+valornota
          else
            totalsai:=totalsai+valornota;
        end;
// 15.08.11
//////////// - geracao registro 53 por enquanto pra sintegra - ref. substituicao tributaria
////////////////////
        if (Q.fieldbyname('moes_valoricms').ascurrency>0) and (pos(Q.fieldbyname('moes_status').asstring,'X;Y')=0)
          and ( Global.Usuario.OutrosAcessos[0327] )
          then begin
          linha:=GetFormato53( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                   FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                   datanota+';'+
                   Q.fieldbyname('moes_estado').asstring+';'+
                   GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                   Q.fieldbyname('moes_serie').asstring+';'+
                   Q.fieldbyname('moes_numerodoc').asstring+';'+
                   cfop+';'
                   +'P'+';'+    //P - o pr�prio estabelecimento emite  T - emitida por terceiros
                   Valortosql( baseicms )+';'+
                   Q.fieldbyname('moes_valoricms').asstring+';'+
                   Valortosql( 0 )+';'+  // despesas acessorias
                   situacaonota+';'+
                   '1'+';' );  //  tabela de 1 a 6 ref. como � pago o icms
          Lista53.Add( linha );
        end;
/////////////////
// 15.08.11
//////////// - geracao registro 85 e 86 por enquanto pra sintegra - ref. exportacao
////////////////////
        if (pos(Q.fieldbyname('moes_status').asstring,'X;Y')=0)
          and ( Global.Usuario.OutrosAcessos[0327] ) and ( copy(cfop,1,1)='7' )
          then begin
          linha:=GetFormato85( Q.fieldbyname('moes_numerodoc').asstring+Q.fieldbyname('moes_numerodoc').asstring +';'+
                   datanota+';'+
                   '1'+';'+  // tabela 1 a 4 ref. nat. da exportacao
                   strzero(Q.fieldbyname('moes_numerodoc').asinteger+7,6)+';'+
                   datanota+';'+
                   FCidades.GetCodigoPais( Q.fieldbyname('moes_cida_codigo').asinteger )+';'+
                   datanota+';'+   // data averbacao...
                   strzero(Q.fieldbyname('moes_numerodoc').asinteger+11,6)+';'+ // nf emit. exportador
                   datanota+';'+  // data desta nota
                   GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                   Q.fieldbyname('moes_serie').asstring );
          Lista85.Add( linha );
          linha:=GetFormato86( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 Q.fieldbyname('moes_serie').asstring+';'+
                 Q.fieldbyname('moes_numerodoc').asstring+';'+
                 GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                 Q.fieldbyname('moes_estado').asstring+';'+
                 datanota+';'+
                 Q.fieldbyname('move_esto_codigo').asstring+';'+
                 Q.fieldbyname('move_qtde').asstring+';'+
                 Q.fieldbyname('move_venda').asstring+';'+
                 Valortosql(totalitem)+';'+
                 strzero(Q.fieldbyname('moes_numerodoc').asinteger+7,6) );  // reg. exportacao
          Lista86.Add( linha );
        end;

     end;

// 13.11.07
//      Lista50Teste.Add( strzero(Q.fieldbyname('moes_numerodoc').asinteger,6)+';'+cfop50+';'+formatfloat( '######0.00',valornota ) );

// 23.10.07
      ListaAliquotas.add( Valortosql( aliqicms ) );
      ListaBases.add( Valortosql( valornota ) );
// 04.03.08
//      ListaCfops.add( cfop );
// 11.03.08
      ListaCfops.add( cfop50 );
// 18.12.09
      ListaCSTs.add( QMovbase.FieldByName('movb_cst').AsString );

// 10.04.07                                           // 09.12.09
      if (Q.fieldbyname('moes_valoripi').ascurrency>0) and (pos(Q.fieldbyname('moes_status').asstring,'X;Y')=0) and
// 04.09.12
         ( pos( FUnidades.GetSimples(Q.FieldByName('moes_unid_codigo').Asstring),'S;2' ) = 0 ) and
// 10.01.2014 - Novicarnes
         ( Global.topicos[1009] )
        then begin
        linha:=GetFormato51( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                   FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                   datanota+';'+
                   Q.fieldbyname('moes_estado').asstring+';'+
                   GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                   Q.fieldbyname('moes_serie').asstring+';'+
                   Q.fieldbyname('moes_numerodoc').asstring+';'+
                   cfop+';'
                   +'P'+';'+    //P - o pr�prio estabelecimento emite  T - emitida por terceiros
                   Valortosql( Q.FieldByName('moes_vlrtotal').AsCurrency)+';'+
                   Valortosql( baseicms )+';'+
                   Q.fieldbyname('moes_valoripi').asstring+';'+
                   Valortosql( 0 )+';'+
                   Valortosql( 0 )+';'+
                   Valortosql( 0 )+';'+
                   situacaonota+';' );
        Lista51.Add( linha );
      end;

//                 Q.FieldByName('movb_isentas').Asstring+';'+
//                 Q.FieldByName('movb_outras').Asstring+';'+
// 11.07.06
///////////////////
//      QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
//                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring));

      cfop50:=cfop;
      cfop54:=cfop;

      while (not QMovbase.eof) do begin
// 23.10.07
        if QMovbase.fieldbyname('movb_natf_codigo').asstring<>'' then
             cfop50:=copy(QMovbase.fieldbyname('movb_natf_codigo').asstring,1,4);
        aliqmovb:=QMovbase.fieldbyname('movb_aliquota').ascurrency;
// 13.12.13 - empresa do simples
////////////////////////////////
         if ( pos( FUnidades.GetSimples(Qmovbase.FieldByName('movb_unid_codigo').Asstring),'S;2' ) > 0 )
              and ( Es='S' ) then begin
// 07.04.13 - Granzotto - Simples mas sujeito a ST - dai deixa o q tiver gravado no banco
            if (QMovbase.FieldByName('movb_aliquota').Ascurrency>0) and (pos(QMovbase.fieldbyname('movb_natf_codigo').asstring,cfopscomST)>0) then
              aliqmovb:=QMovbase.fieldbyname('movb_aliquota').ascurrency;
// 16.08.16 -  zilmar              
//            else
//              aliqmovb:=0;
         end;
///////////////////////////
// 12.03.08
//        if (Global.Topicos[1304])  and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 ) then
//          aliqmovb:=0;
// retirado em 10.07.09
// 13.11.07
//        if ( ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)=0 )
// 03.03.08
        if ( ( Global.Topicos[1304] )
            and
            ( (not TemAliquota(aliqmovb) )
               or (not TemCfop(QMovbase.fieldbyname('movb_natf_codigo').asstring))
// 18.12.09
//               or (not TemCST(QMovbase.fieldbyname('movb_cst').asstring))
                )  )
// 11.02.08
//           ( not TemBase(QMovbase.fieldbyname('movb_basecalculo').ascurrency) )  )
           OR
           ( ( not Global.Topicos[1304] )  )
            and
           ( not TemAliquota(QMovbase.fieldbyname('movb_aliquota').ascurrency) )
// 05.10.11 - Bavi - entradas de distribuidor
            or (not TemCfop(QMovbase.fieldbyname('movb_natf_codigo').asstring))
//           ( not TemBase(QMovbase.fieldbyname('movb_basecalculo').ascurrency) )
           then begin

           totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,2);
// 17.04.14
//          if Q.fieldbyname('moes_peracres').ascurrency>0 then
            vlracres:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(Q.fieldbyname('moes_peracres').ascurrency/100);
//          else
//            vlracres:=0;

// 14.05.14 - Benatto
///        if numcfops>1 then begin
//        if Q.fieldbyname('moes_perdesco').ascurrency>0 then
//          vlrdesco:=FGeral.Arredonda(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100),2)
          vlrdesco:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(Q.fieldbyname('moes_perdesco').ascurrency/100);
//        else
//          vlrdesco:=0;

//////////
//           valoripi:=totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100);
// 27.02.14
//           valoripi:=BuscaIPInositem(Q.fieldbyname('move_transacao').asstring,cfop50);
// 17.04.14
          valoripidositens:=BuscaIPInositem(Q.FieldByName('moes_transacao').AsString, '' );
          if valoripidositens>0 then
            valoripi:=BuscaIPInositem(Q.FieldByName('moes_transacao').AsString, cfop50 )
          else begin
// 17.04.14 - trato notas 'da coca' com ipi somente em valor e aliquta 0
            if (Q.fieldbyname('moes_valoripi').ascurrency>0) then begin
              if Q.fieldbyname('moes_totprod').ascurrency>0 then begin
                valoripi:= Q.fieldbyname('moes_valoripi').ascurrency/Q.fieldbyname('moes_totprod').ascurrency*100;
                valoripi:=FGeral.arredonda(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(valoripi/100),2) ;
              end else
                valoripi:=0;
            end;
          end;
// 18.06.12
           codigofiscal:=FSittributaria.CSttoCF(QMovbase.FieldByName('movb_cst').Asstring,QMovbase.FieldByName('movb_unid_codigo').Asstring,ES);
           isentas:=0;outras:=0;
           basecalculo:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
// 04.07.07
          if Q.FieldByName('move_tipomov').AsString=Global.CodCompraProdutor then
             basecalculo:=0;
// 13.11.13 - tratamento de ipi e icms subst. trib. quando tem mais de um cfop
          if pos(cfop50,'1556;2556;1401;1403;2403;1910;2910;5401;5405')>0 then begin
// 15.04.14
            if numcfopsST=1 then
              valorSTporcfop:=Q.FieldByName('moes_valoricmssutr').AsCurrency
            else
              valorSTporcfop:=(Q.FieldByName('moes_valoricmssutr').AsCurrency/Q.FieldByName('moes_totprod').AsCurrency)*
                             QMovbase.FieldByName('movb_basecalculo').AsCurrency;

//            basecalculo:=QMovbase.FieldByName('movb_basecalculo').AsCurrency+Q.FieldByName('moes_valoricmssutr').AsCurrency+(Q.fieldbyname('moes_valoripi').ascurrency/numcfops)
//            basecalculo:=QMovbase.FieldByName('movb_basecalculo').AsCurrency+Q.FieldByName('moes_valoricmssutr').AsCurrency+(valoripi)
            basecalculo:=QMovbase.FieldByName('movb_basecalculo').AsCurrency+valorstporcfop+(valoripi)+vlrfrete;
          end else
            basecalculo:=QMovbase.FieldByName('movb_basecalculo').AsCurrency+(valoripi)+vlrfrete;
// 09.05.14 - para notas sem base no movbase tipo ES
          if basecalculo=0 then basecalculo:=Q.fieldbyname('moes_vlrtotal').ascurrency;
//////////////////////////////// - 14.07.09
          valornota:=basecalculo;
          if QMovbase.FieldByName('movb_reducaobc').AsCurrency>0 then
             codigofiscal:='2';
          isentas:=0;outras:=0;
           if ( pos( codigofiscal,'2;3' ) >0 ) and (QMovbase.FieldByName('movb_reducaobc').AsCurrency=0) then begin
      //       isentas:=Q.FieldByName('moes_baseicms').AsCurrency
             isentas:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
             basecalculo:=0;
      // 04.07.07
           end else if ( pos( codigofiscal,'2;3' ) >0 ) and (QMovbase.FieldByName('movb_reducaobc').AsCurrency>0) then begin
             isentas:=QMovbase.FieldByName('movb_basecalculo').AsCurrency-(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
             valornota:=basecalculo;
             basecalculo:=(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
           end else if codigofiscal='5' then begin
             if QMovbase.FieldByName('movb_reducaobc').AsCurrency>0 then begin
               outras:=QMovbase.FieldByName('movb_basecalculo').AsCurrency-(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
               basecalculo:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100);
             end else begin
               outras:=Qmovbase.FieldByName('movb_basecalculo').AsCurrency;
               basecalculo:=0;
             end;
// 19.12.11 - empresa do simples
////////////////////////////////
           end else if ( pos( FUnidades.GetSimples(Qmovbase.FieldByName('movb_unid_codigo').Asstring),'S;2' ) > 0 )
              and ( Es='S' ) then begin
             if QMovbase.FieldByName('movb_reducaobc').AsCurrency>0 then begin
               outras:=QMovbase.FieldByName('movb_basecalculo').AsCurrency-(QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100));
               basecalculo:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(QMovbase.FieldByName('movb_reducaobc').AsCurrency/100);
             end else if QMovbase.FieldByName('movb_aliquota').Ascurrency>0 then begin
               outras:=0;
//               basecalculo:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
// 13.12.13 - Metalforte - devolucao de compra tributada
               vlricms:=0;
               basecalculo:=0;
             end else begin
               outras:=Qmovbase.FieldByName('movb_basecalculo').AsCurrency;
               basecalculo:=0;
             end;
           end else
             outras:=Q.FieldByName('moes_valoripi').AsCurrency;
//////////////////// - 14.07.09

//////////////////////////
{
           if pos( codigofiscal,'2;3' ) >0 then begin
             isentas:=basecalculo;
           end else if codigofiscal='5' then
             outras:=basecalculo
           else
             outras:=valoripi;
             }
//////////////////
//////
///////////////
// 23.07.07
//           valornota:=basecalculo;
           aliqicms:=QMovbase.FieldByName('movb_aliquota').Ascurrency;
           vlricms:=QMovbase.FieldByName('movb_imposto').Ascurrency;
// 05.10.10 - Abra - PS - canceladas ou nao
           if (Q.FieldByName('moes_tipomov').asstring=Global.CodPrestacaoServicos)
             or
             ( ( pos( FUnidades.GetSimples(Qmovbase.FieldByName('movb_unid_codigo').Asstring),'S;2' ) > 0 )
              and ( Es='S' )  and (numcfops=1)
             )
             then begin
// 07.04.13 - Granzotto - Simples mas sujeito a ST - dai deixa o q tiver gravado no banco
             if (QMovbase.FieldByName('movb_aliquota').Ascurrency>0) and (pos(QMovbase.fieldbyname('movb_natf_codigo').asstring,cfopscomST)>0) then
               aliqicms:=QMovbase.FieldByName('movb_aliquota').Ascurrency
             else
               aliqicms:=0;
             valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
             baseicms:=0;
             vlricms:=0;
// 04.07.14
           end else if ( pos( FUnidades.GetSimples(Qmovbase.FieldByName('movb_unid_codigo').Asstring),'S;2' ) > 0 )
                      and ( Es='S' ) and ( numcfops>1 )  then begin
             vlricms:=0;
             baseicms:=0;
           end;

///////////////////////////////////////////
{ - 10.07.09 - retirado
           if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 ) and
// 04.03.08
              ( QMovbase.FieldByName('movb_cst').AsString<>'000' )
              then begin    // entradas td em outras e valor contabil
              outras:=valornota;
              basecalculo:=0;
              isentas:=0;
              vlricms:=0;
//              aliqicms:=0;  // 10.07.09
           end;
           }
/////////////////////
///////////
          if (  Q.FieldByName('moes_comv_codigo').asinteger=FGeral.GetConfig1AsInteger('ConfMovECF') )
              and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'123')>0 )
              and ( FGeral.GetConfig1AsInteger('ConfMovECF')>0 )  // 28.10.11
              then begin
             linha:='x';
          end else if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'123')>0 ) then begin
             linha:='x';
          end else begin
// 02.12.15
            if situacaonota='S' then begin
               aliqicms:=0;
// 16.08.16
                valornota:=0;
                baseicms:=0;
                vlricms:=0;
                baseicms:=0;
                isentas:=0;
                outras:=0;
            end;
            linha:=GetFormato50( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 datanota+';'+Q.fieldbyname('moes_estado').asstring+';'+
                 GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                 Q.fieldbyname('moes_serie').asstring+';'+
                 Q.fieldbyname('moes_numerodoc').asstring+';'+
                 cfop50+';'+'P'+';'+    //P - o pr�prio estabelecimento emite  T - emitida por terceiros
//                 Q.FieldByName('moes_vlrtotal').Asstring+';'+
//                 Valortosql( QMovbase.FieldByName('movb_basecalculo').Ascurrency+valoripi )+';'+
// 23.07.07
                 Valortosql( valornota )+';'+
                 Valortosql( basecalculo )+';'+
                 Valortosql( vlricms )+';'+
                 Valortosql( isentas )+';'+
                 Valortosql( outras )+';'+
                 Valortosql( aliqicms )+';'+
                 situacaonota+';' );

//                 QMovbase.FieldByName('movb_isentas').Asstring+';'+
//                 QMovbase.FieldByName('movb_outras').Asstring+';'+
            if trim(linha)<>'' then begin
              Lista50.Add( linha );
              Lista50A.Add(copy(linha,1,2)+copy(linha,31,8)+'['+linha );
//              ListaAliquotas.add( QMovbase.FieldByName('movb_aliquota').AsString );
//              ListaBases.add( QMovbase.FieldByName('movb_basecalculo').AsString );
// 07.04.14
              ListaAliquotas.add( ValortoSql(QMovbase.FieldByName('movb_aliquota').AsCurrency) );
              ListaBases.add( ValortoSql(QMovbase.FieldByName('movb_basecalculo').AsCurrency) );
              ListaCfops.add ( cfop50 ) ;
              if pos( copy(cfop50,1,1),'1;2;3')>0 then
                totalent:=totalent+valornota
              else
                totalsai:=totalsai+valornota;
    // 18.12.09
              ListaCSTs.add( QMovbase.FieldByName('movb_cst').AsString );
            end;
         end;

///////////////////////////////////////////////////////////
{
//        end else if (QMovbase.FieldByName('movb_natf_codigo').Asstring='1556') and
// 03.03.08 - gerou tipo 50 zerado e 'a mais'...
        end else if (QMovbase.FieldByName('movb_natf_codigo').Asstring='1556') and
           (Q.fieldbyname('moes_natf_codigo').asstring<>QMovbase.FieldByName('movb_natf_codigo').Asstring) and
           (Q.fieldbyname('moes_vlrtotal').ascurrency>Q.fieldbyname('moes_totprod').ascurrency) and
           (Q.fieldbyname('moes_totprod').ascurrency>0)
           then begin  // 11.02.08 - tratamento para entradas que precisa desmembrar...
///////////
           totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,2);
           valoripi:=totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100);
// 21.03.07
           codigofiscal:=FSittributaria.CSttoCF(QMovbase.FieldByName('movb_cst').Asstring);
           isentas:=0;outras:=0;
           basecalculo:=QMovbase.FieldByName('movb_basecalculo').AsCurrency;
// 04.07.07
           if Q.FieldByName('move_tipomov').AsString=Global.CodCompraProdutor then
             basecalculo:=0;

           if pos( codigofiscal,'2;3' ) >0 then
             isentas:=basecalculo
           else if codigofiscal='5' then
             outras:=basecalculo
           else
             outras:=valoripi;
//////
///////////////
// 23.07.07 - 11.02.08
           valornota:=Q.fieldbyname('moes_vlrtotal').ascurrency-basecalculo;
           aliqicms:=QMovbase.FieldByName('movb_aliquota').Ascurrency;
           vlricms:=QMovbase.FieldByName('movb_imposto').Ascurrency;
           if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
              then begin    // entradas td em outras e valor contabil
              outras:=valornota;
              basecalculo:=0;
              isentas:=0;
              vlricms:=0;
              aliqicms:=0;
           end;
           cfop50:='1933';
/////////////////////
          linha:=GetFormato50( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 FGeral.GetInscEstadualTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 datanota+';'+Q.fieldbyname('moes_estado').asstring+';'+
                 GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                 Q.fieldbyname('moes_serie').asstring+';'+
                 Q.fieldbyname('moes_numerodoc').asstring+';'+
                 cfop50+';'+'P'+';'+    //P - o pr�prio estabelecimento emite  T - emitida por terceiros
//                 Q.FieldByName('moes_vlrtotal').Asstring+';'+
//                 Valortosql( QMovbase.FieldByName('movb_basecalculo').Ascurrency+valoripi )+';'+
// 23.07.07
                 Valortosql( valornota )+';'+
                 Valortosql( basecalculo )+';'+
                 Valortosql( vlricms )+';'+
                 Valortosql( isentas )+';'+
                 Valortosql( outras )+';'+
                 Valortosql( aliqicms )+';'+
                 situacaonota+';' );
          Lista50.Add( linha );
          Lista50Teste.Add( strzero(Q.fieldbyname('moes_numerodoc').asinteger,6)+';'+cfop50+';'+formatfloat( '######0.00',valornota ) );
          Lista50A.Add(copy(linha,1,2)+copy(linha,31,8)+'['+linha );
          ListaAliquotas.add( QMovbase.FieldByName('movb_aliquota').AsString );
          ListaBases.add( QMovbase.FieldByName('movb_basecalculo').AsString );

////////////
}
        end;
        QMovbase.next;
      end;
      fGeral.Fechaquery(QMovbase);

///////////////////

//    while ( q.fieldbyname('moes_transacao').asstring+q.fieldbyname('moes_datalcto').asstring+q.fieldbyname('moes_numerodoc').asstring=x ) and
// 11.07.06
//     GERACAO DOS ITENS DAS NOTAS FISCAIS...
// AQUI tbem em 04.09.12 - Simar - gerando registro de frete na nota 'seguinte'...e com cfop errado..
{
    if Es='E' then begin
      vlrfrete:=0;  // nf de entrada � s� para entrar no custo do produto
    end else begin
      vlrfrete:=q.fieldbyname('moes_frete').ascurrency;
    end;
}
///////////////////////////////////////////
/// Itens das Notas - registro 54
///////////////////////////////////

    while ( q.fieldbyname('move_transacao').asstring+q.fieldbyname('move_datamvto').asstring+q.fieldbyname('move_numerodoc').asstring=x ) and
        ( not Q.eof )
       do begin

//      Sistema.setmessage('Exportando movimento de entrada e saida - detalhe');

//      totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,2);
// 17.12.13
      totalitem:=Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency;
      baseicms:=totalitem;
// 27.06.07
//      if Q.fieldbyname('move_redubase').ascurrency>0 then
//        baseicms:=baseicms*(Q.fieldbyname('move_redubase').ascurrency/100) ;
// 04.07.07
      redubase:=FCodigosFiscais.GetAliquotaRedBase( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
      aliqicms:=Q.fieldbyname('move_aliicms').ascurrency;
// 11.12.09 - Novicarnes - Vanessa - notas feitas erradas sem redu�ao de base mas q nos itens
//            agora t� configurado como com reducao
//      QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
//                           ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring));
// 17.12.13
      QMovbase:=sqltoquery('select * from movbase where movb_transacao='+Stringtosql(Q.fieldbyname('move_transacao').asstring)+
                          ' and movb_status=''N'''+
                          ' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring)+
                          ' and movb_natf_codigo='+Stringtosql(Q.fieldbyname('move_natf_codigo').asstring) );
      if not QMovBase.eof then begin
        redubasemestre:=QMovBase.fieldbyname('movb_reducaobc').ascurrency;
      end else
        redubasemestre:=0;
//////////////////////////
//      if (redubase>0) then begin
      if (redubase>0) and (redubasemestre>0) then begin
        baseicms:=(baseicms*(redubase/100));
      end;

      if q.fieldbyname('move_cst').asstring=CstSubsTrib then
        baseicmsst:=( totalitem*(1+(Global.MargemSubsTrib/100)) )  // rever posteriormente se tiver mais de um % subst.
      else
        baseicmsst:=0;

      if (Q.fieldbyname('moes_perdesco').ascurrency>0) then
//       and (Q.fieldbyname('moes_totprod').ascurrency<Q.fieldbyname('moes_vlrtotal').ascurrency) then
        vlrdesco:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100),2)
      else
        vlrdesco:=0;
//28.05.14
      vlracres:=(totalitem*(Q.fieldbyname('moes_peracres').ascurrency/100));

// 21.03.07 - trato com ipi
//
      valoripi:=totalitem*(Q.fieldbyname('move_aliipi').ascurrency/100);
// 14.12.13 - trato com ipi   quando � informado apenas no total da nota
// 17.04.14 - nota 'da coca' com ipi em valor e aliquota zero...
// 25.09.14 - retirado para deixar somente com a aliquota do item
////////////////////////////
{
      if (valoripi=0) and ( Es='E' ) and (Q.fieldbyname('moes_valoripi').ascurrency>0) then begin
        if Q.fieldbyname('moes_vlrtotal').ascurrency>0 then begin
          valoripi:= (Q.fieldbyname('moes_valoripi').ascurrency/Q.fieldbyname('moes_totprod').ascurrency)*100;
          valoripi:=QMovbase.FieldByName('movb_basecalculo').AsCurrency*(valoripi/100) ;
        end else
          valoripi:=0;  // 17.12.13
        valoripi:=totalitem*(valoripi/100) ;
      end;
      }
////////////////
// 17.12.13
      valorsubs:=0;
//      codigofiscal:=FSittributaria.CSttoCF(QMovbase.FieldByName('movb_cst').Asstring,QMovbase.FieldByName('movb_unid_codigo').Asstring,ES);
//      if ( Es='E')  and ( codigofiscal='4' ) then begin
      if pos( Q.FieldByName('move_natf_codigo').AsString,'1401;1403;2403;1910;2910' )>0 then begin
      //        valorsubs:=(Q.fieldbyname('moes_valoricmssutr').ascurrency/Q.fieldbyname('moes_vlrtotal').ascurrency)*100;
        if QMovbase.fieldbyname('movb_basecalculo').ascurrency>0 then
          valorsubs:=(Q.fieldbyname('moes_valoricmssutr').ascurrency/QMovbase.fieldbyname('movb_basecalculo').ascurrency)*100
        else
          valorsubs:=0;
        valorsubs:=totalitem*(valorsubs/100);
      end;

// 13.12.13                                   // 17.12.13
      difcontabilbaseicms:=0;
///////////////////
      if ( pos( FUnidades.GetSimples(Q.FieldByName('move_unid_codigo').Asstring),'S;2' ) > 0 )
          and (Q.fieldbyname('moes_tipomov').asstring=Global.CodDevolucaoTributada) then begin
         difcontabilbaseicms:=Q.fieldbyname('moes_vlrtotal').ascurrency-QMovbase.fieldbyname('movb_basecalculo').ascurrency;
         if difcontabilbaseicms>0 then
           difperc:=(difcontabilbaseicms/totalitem)*100
         else
           difperc:=0;
         difcontabilbaseicms:=totalitem*(difperc/100);
      end;
//////////////////
// 14.12.13
      if  (Es='E' ) and ( vlrdesco>0 ) and (Q.fieldbyname('moes_totprod').ascurrency<Q.fieldbyname('moes_vlrtotal').ascurrency) then begin
//        difcontabilbaseicms:=difcontabilbaseicms;
        totaldesco:=totaldesco+vlrdesco;
        totalitem:=totalitem-vlrdesco+vlracres;
      end;
      if (Q.fieldbyname('moes_frete').ascurrency>0) and ( Es='E' ) then begin
        if Q.fieldbyname('moes_vlrtotal').ascurrency>0 then
          vlrfrete:=(Q.fieldbyname('moes_frete').ascurrency/Q.fieldbyname('moes_totprod').ascurrency)*100
        else
          vlrfrete:=0;
        vlrfrete:=totalitem*(vlrfrete/100);
        if Q.fieldbyname('moes_freteciffob').asstring<>'2' then vlrfrete:=0;
        difcontabilbaseicms:=difcontabilbaseicms+vlrfrete;
        totalfrete:=totalfrete+vlrfrete;
        vlrfrete:=0;
      end;
//
// 14.12.13
      if Q.fieldbyname('moes_peracres').ascurrency>0 then
        vlracres:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_peracres').ascurrency/100),2)
      else
        vlracres:=0;
// 23.03.07
//     codigofiscal:=FSittributaria.CSttoCF(Qmovbase.FieldByName('movb_cst').Asstring);
//      if ( (outras>0) or (isentas>0) ) and (valoripi=0) then
      if ( Q.fieldbyname('move_aliicms').ascurrency=0 ) or (Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor) then
         baseicms:=0;
      if (Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor) then
         aliqicms:=0;
// 04.07.07 - notas 'elize'..
      if (baseicms>0) and (baseicms>totalitem) and (vlrdesco=0) and (Es='E') then
        totalitem:=baseicms;

// 05.10.10 - Abra - PS - canceladas ou nao
      if (Q.FieldByName('moes_tipomov').asstring=Global.CodPrestacaoServicos)
             or
          ( ( pos( FUnidades.GetSimples(Qmovbase.FieldByName('movb_unid_codigo').Asstring),'S;2' ) > 0 )
              and ( Es='S' )   )
         then begin
//         valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
// 17.12.13
         baseicms:=0;
         vlricms:=0;
// 03.07.14 - Granzotto - Simples mas sujeito a ST - dai deixa o q tiver gravado no banco
         if (QMovbase.FieldByName('movb_aliquota').Ascurrency>0) and (pos(QMovbase.fieldbyname('movb_natf_codigo').asstring,cfopscomST)>0) then
           aliqicms:=QMovbase.FieldByName('movb_aliquota').Ascurrency;
// 16.08.16 - zilmar
//         else
 //          aliqicms:=0;
//////////////////
       end;
      if perdesco>0 then begin
//        totalitem:=totalitem - ( totalitem*(perdesco/100) );
// 10.12.09 - Novicarnes retirado do valor do items
        baseicms:=baseicms - ( baseicms*(perdesco/100) );
      end;

// 23.07.07
      if ( Global.Topicos[1304] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 )
          then begin    // entradas td em outras e valor contabil
          baseicms:=0;
//          aliqicms:=0;  // 10.07.09
      end;
// 11.11.14 - Giacomoni - para garantir q aliquotas ,etc fiquem zeradas no itens tbem...
///////////////////////////////////////////////////////////////////////////////////////////
       if (Q.FieldByName('moes_tipomov').asstring=Global.Codcompraprodutor)
         or (situacaonota='S')
         or (Q.FieldByName('moes_tipomov').asstring=Global.CodPrestacaoServicos)
         then begin  // 16.09.10 - Abra
         valornota:=Q.FieldByName('moes_vlrtotal').AsCurrency;
         baseicms:=0;
         vlricms:=0;
         aliqicms:=0;
       end;

/////////////////////
// aqui em 23.10.07
//      cfop54:=cfop;
// 11.03.08
      cfop54:=cfop50;
      if listaaliquotas.count>0 then begin
        if trim( Q.fieldbyname('move_natf_codigo').asstring )='' then begin
          QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(q.fieldbyname('move_transacao').asstring)+
                             ' and movb_status<>''C'' and movb_tipomov='+stringtosql(q.fieldbyname('move_tipomov').asstring)+
//                             ' and movb_natf_codigo<>'+stringtosql(cfop) );
//                             ' and movb_natf_codigo<>'+stringtosql(cfop50) );
                             ' and movb_cst='+stringtosql(Q.fieldbyname('move_cst').asstring) );
// 11.03.08
//                             ' and movb_aliquota='+valortosql(aliqicms) );
          if not QMovbase.eof then begin
            if QMovbase.fieldbyname('movb_natf_codigo').asstring<>'' then
              cfop54:=copy(QMovbase.fieldbyname('movb_natf_codigo').asstring,1,4);
          end;
          FGeral.FechaQuery(QMovbase);
        end else // 13.02.12
          cfop54:=copy(Q.fieldbyname('move_natf_codigo').asstring,1,4);
      end;
// 17.12.13 - para somar somente nos itens com cfops abaixo
      if pos(cfop54,'1401;1403;2403;1910;2910')=0 then valorsubs:=0;
      totalsubs:=totalsubs+valorsubs;

//  04.03.08
      xcst:=Q.fieldbyname('move_cst').asstring;
      if xcst='099' then xcst:='090';
// 09.12.09 - pra prevenir eventuais 'bostex' onde o move_cst fica sem preencher...
      if trim(xcst)='' then
        xcst:=FEstoque.Getsituacaotributaria(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring,
               Global.UFUnidade);
///
// 05.07.10
      if ( copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) then
        linha:='x'  // para nao gerar o 54
// 14.07.11
      else if (  Q.FieldByName('moes_comv_codigo').asinteger=FGeral.GetConfig1AsInteger('ConfMovECF') )
            and ( FGeral.GetConfig1AsInteger('ConfMovECF')>0 )  // 28.10.11
           then
        linha:='x'  // para nao gerar o 54
      else begin
// 02.12.15 - Nota cancelada ainda ficava com o % de icms
        if situacaonota='S' then begin
          aliqicms:=0;
          baseicmsst:=0;
          baseicms:=0;
          valoripi:=0;
        end;
        linha:=GetFormato54( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                 GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                 Q.fieldbyname('moes_serie').asstring+';'+
//                 space(02)+';'+   // subserie
                 Q.fieldbyname('moes_numerodoc').asstring+';'+
                 cfop54+';'+xcst+';'+
                 strzero(contitem,3)+';'+Q.fieldbyname('move_esto_codigo').asstring+';'+
                 Q.fieldbyname('move_qtde').asstring+';'+
                 Valortosql(totalitem+difcontabilbaseicms+valoripi+valorsubs)+';'+Valortosql(vlrdesco)+';'+
                 Valortosql(baseicms)+';'+Valortosql(baseicmsst)+';'+
                 Valortosql(valoripi)+';'+Valortosql( aliqicms ) );
        totalipi:=totalipi+valoripi;

// 12.06.17
        if Q.fieldbyname('move_qtde').ascurrency<0 then Linha:='';

        inc(contitem);
        inc(n);
        if trim(linha)<>'' then
          Lista54.add(linha);
// 14.05.09
        if EdCreditopiscofins.Text='S' then begin
          linha:=GetFormatoPisCofins( FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                   GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                   Q.fieldbyname('moes_serie').asstring+';'+
  //                 space(02)+';'+   // subserie
                   Q.fieldbyname('moes_numerodoc').asstring+';'+
                   cfop54+';'+
                   xcst+';'+
                   strzero(contitem-1,3)+';'+Q.fieldbyname('move_esto_codigo').asstring+';'+
                   Q.fieldbyname('move_qtde').asstring+';'+
                   Valortosql(totalitem)+';'+Valortosql(vlrdesco)+';'+
                   Valortosql(baseicms)+';'+Valortosql(baseicmsst)+';'+
                   Valortosql(valoripi)+';'+Valortosql( aliqicms ), '54' );
  {////////////////////////////////
                   DataNota+';'+
                   Q.fieldbyname('moes_dataemissao').asdatetime+';'+
                   Q.fieldbyname('moes_especie').asstring+';'+
                   Q.fieldbyname('moes_comv_codigo').asstring+';'+
                   FConfMovimento.GetDescricao(Q.fieldbyname('moes_comv_codigo').asinteger)+';')
  /////////////////////////}
          ListaPisCofins.add(linha);
        end;
        if trim(linha)<>'' then begin
          if Lista75aux.IndexOf(Q.fieldbyname('move_esto_codigo').asstring)=-1 then begin
            Lista75.Add(Q.fieldbyname('move_esto_codigo').asstring);
            Lista75aux.Add(Q.fieldbyname('move_esto_codigo').asstring);
          end;
        end;

      end;  // serie D nao tem itens

// 04.09.12 - aqui
///////////////////////////////////////
      if (vlrfrete>0) and (contitem=1) then begin
        linha:=GetFormato54(FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                   GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                   Q.fieldbyname('moes_serie').asstring+';'+
  //                 space(02)+';'+   // subserie
                   Q.fieldbyname('moes_numerodoc').asstring+';'+
                   cfop54+';'+Q.fieldbyname('move_cst').asstring+';'+
                   '991'+';'+Q.fieldbyname('move_esto_codigo').asstring+';'+
                   Q.fieldbyname('move_qtde').asstring+';'+
                   Valortosql(totalitem)+';'+Valortosql(vlrdesco)+';'+
                   Valortosql(baseicms)+';'+Valortosql(baseicmsst)+';'+
                   Valortosql(0)+';'+Q.fieldbyname('move_aliicms').asstring);

         if trim(linha)<>'' then
           Lista54.add(linha);
      end;
      if (vlrseguro>0)  and (contitem=1)  then begin
        linha:=GetFormato54(FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                   GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                   Q.fieldbyname('moes_serie').asstring+';'+
    //               space(02)+';'+   // subserie
                   Q.fieldbyname('moes_numerodoc').asstring+';'+
                   cfop54+';'+Q.fieldbyname('move_cst').asstring+';'+
                   '992'+';'+Q.fieldbyname('move_esto_codigo').asstring+';'+
                   Q.fieldbyname('move_qtde').asstring+';'+
                   Valortosql(totalitem)+';'+Valortosql(vlrdesco)+';'+
                   Valortosql(baseicms)+';'+Valortosql(baseicmsst)+';'+
                   Valortosql(0)+';'+Q.fieldbyname('move_aliicms').asstring);
// 12.06.17
         if Q.fieldbyname('move_qtde').ascurrency<0 then Linha:='';

         if trim(linha)<>'' then
           Lista54.add(linha);
      end;

      if (vlrpiscofins>0)  and (contitem=1)  then begin
        linha:=GetFormato54(FGeral.GetCnpjCpfTipoCad(Q.fieldbyname('Moes_tipo_codigo').asinteger,Q.fieldbyname('Moes_tipocad').asstring)+';'+
                   GetModelo(Q.fieldbyname('moes_tipomov').asstring)+';'+
                   Q.fieldbyname('moes_serie').asstring+';'+
  //                 space(02)+';'+   // subserie
                   Q.fieldbyname('moes_numerodoc').asstring+';'+
                   cfop54+';'+Q.fieldbyname('move_cst').asstring+';'+
                   '993'+';'+Q.fieldbyname('move_esto_codigo').asstring+';'+
                   Q.fieldbyname('move_qtde').asstring+';'+
                   Valortosql(totalitem)+';'+Valortosql(vlrdesco)+';'+
                   Valortosql(baseicms)+';'+Valortosql(baseicmsst)+';'+
                   Valortosql(0)+';'+Q.fieldbyname('move_aliicms').asstring);
         if trim(linha)<>'' then
           Lista54.add(linha);
      end;
///////////////////////////////////////
      Q.Next;

    end;  // ref. detalhes

    ListaAliquotas.free;
    ListaBases.free;
    ListaCfops.free;
    ListaCSTs.free;
//    Sistema.setmessage('Exportando movimento de entrada e saida - mestre '+Q.fieldbyname('moes_transacao').asstring);
// 04.09.12 - era aqui o '991','992'...

    if QGeral<>nil then begin
      Qgeral.close;
      Freeandnil(QGeral);
    end;

  end; // ref. mestre

// 14.07.11 - Geracao dos registros 60 - 60M, 60A e 60R
  Lista60:=TStringlist.create;
  if Global.Topicos[1021] then
    GeraRegistros60;


//
//  Sistema.setmessage('Criando arquivo texto '+nomearq+EdUnid_codigo.text+'.txt');
//  AssignFile(Arquivo, nomearq+EdUnid_codigo.text+'.txt' );

//  aviso(' Nomearq='+nomearq+'|') ;

  Sistema.beginprocess('Criando arquivo texto '+nomearq+'.txt');
  AssignFile(Arquivo, nomearq+'.txt' );
  Rewrite(Arquivo);
// 14.05.09
  if trim(nomearqE+nomearqS)<>'' then begin
    AssignFile(ArquivoE, nomearqE+'.txt' );
    Rewrite(ArquivoE);
    AssignFile(ArquivoS, nomearqS+'.txt' );
    Rewrite(ArquivoS);
  end;
// 13.11.07
//  AssignFile(ArquivoTeste, '\SAC\TESTE'+EdUnid_codigo.text+'.txt' );
//  Rewrite(ArquivoTeste);

// aqui usar as stringlist geradas na leitura da query
  linha:='10';
  unid_fax:=EdUnid_codigo.resultfind.fieldbyname('unid_fax').asstring;
  unid_fax:=Fgeral.tirabarra(unid_fax,' ');
  if trim(unid_fax)='' then
    unid_fax:=Fgeral.tirabarra(EdUnid_codigo.resultfind.fieldbyname('unid_fone').asstring,' ');
// 05.10.10 - validador sintegra SC considera 00000000000
  if (length(unid_fax)=08) then
    unid_fax:='00'+unid_fax
  else if (length(unid_fax)=09) then
    unid_fax:='0'+unid_fax
  else
    unid_fax:=strspace(unid_fax,10);
  linha:='10'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring,14)+
         strspace(TiraSintegra(EdUnid_codigo.resultfind.fieldbyname('unid_inscricaoestadual').asstring),14)+
         strspace(EdUnid_codigo.resultfind.fieldbyname('unid_razaosocial').asstring,35)+
         strspace(EdUnid_codigo.resultfind.fieldbyname('unid_municipio').asstring,30)+
         strspace(EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring,02)+
//         strzero( strtointdef(Fgeral.tirabarra(unid_fax,' '),0) ,10)+
         unid_fax+
         FGeral.DataStringinvertida(Edinicio.text)+
         FGeral.DataStringinvertida(Edtermino.text)+
         '3'+     // codigo da identificacao do convenio
         '3'+     // natureza das informacoes 3- todas
         EdFinalidade.text;    // finalidade do arquivo magnetico

  Writeln(Arquivo,linha);
  fonechu:=spacestr( Fgeral.tirabarra(EdUnid_codigo.resultfind.fieldbyname('unid_fone').asstring,' ') ,12);
// 05.10.10 - validador sintegra SC considera 00000000000
  if (copy(fonechu,1,2)=space(02)) and (length(fonechu)=12) then
    fonechu:='00'+copy(fonechu,3,10);
  linha:='11'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_endereco').asstring,34)+  // logradouro
         strzero( strtointdef(GetNumerodoEndereco(EdUnid_codigo.resultfind.fieldbyname('unid_endereco').asstring),0) ,5)+  // numero
         strspace('.',22)+    // complemento
         strspace(EdUnid_codigo.resultfind.fieldbyname('unid_bairro').asstring,15)+
         strspace(EdUnid_codigo.resultfind.fieldbyname('unid_cep').asstring,08)+
         strspace(EdUnid_codigo.resultfind.fieldbyname('unid_contador').asstring,28)+  // contato
//         spacestr('004632254295',12);     // telefone do contato
// 14.09.09
//         strzero( strtointdef(Fgeral.tirabarra(EdUnid_codigo.resultfind.fieldbyname('unid_fone').asstring,' '),0) ,12);
// 05.10.10
         fonechu;
//         spacestr('004632254295',12);     // telefone do contato

  Writeln(Arquivo,linha);
  Lista50a.sorted:=true;
  for p:=0 to lista50a.count-1 do begin
    for xy:=0 to lista50.count-1 do begin
      if lista50[xy]=copy(lista50a[p],pos('[',lista50a[p])+1,300) then begin
        linha:=lista50[xy];
        break;
      end;
    end;
    if trim(linha)<>'' then
      Writeln(Arquivo,linha);
  end;
// 09.12.09 - pra sair o registro 51 em ordem da data de emissao
  for p:=0 to lista51.count-1 do begin
    Lista51Ordem.Add( copy(lista51[p],31,8) + lista51[p] );
  end;
// 10.04.07
  lista51Ordem.sorted:=true;
  for p:=0 to lista51Ordem.count-1 do begin
    linha:=copy( lista51Ordem[p],09,400 );
    Writeln(Arquivo,linha);
  end;
/////////// 15.08.11
// pra sair o registro 53 em ordem da data de emissao
  for p:=0 to lista53.count-1 do begin
    Lista53Ordem.Add( copy(lista53[p],31,8) + lista53[p] );
  end;
  lista53Ordem.sorted:=true;
  for p:=0 to lista53Ordem.count-1 do begin
    linha:=copy( lista53Ordem[p],09,400 );
    Writeln(Arquivo,linha);
  end;
////////////
  for p:=0 to lista54.count-1 do begin
    linha:=lista54[p];
    if trim(linha)<>'' then
      Writeln(Arquivo,linha);
  end;
// aqui gerar os registros 60M,60A e 60R
// 14.07.11
    for p:=0 to lista60.count-1 do begin
      linha:=lista60[p];
      if trim(linha)<>'' then
        Writeln(Arquivo,linha);
    end;
// 05.07.10
  for p:=0 to lista61.count-1 do begin
    linha:=lista61[p];
    Writeln(Arquivo,linha);
  end;
  for p:=0 to lista70.count-1 do begin
    linha:=lista70[p];
    Writeln(Arquivo,linha);
  end;
// 27.02.12
  for p:=0 to lista71.count-1 do begin
    linha:=lista71[p];
    Writeln(Arquivo,linha);
  end;
// 13.11.07
//  for p:=0 to lista50teste.count-1 do begin
//    linha:=lista50teste[p];
//    Writeln(ArquivoTeste,linha);
//  end;
///////////////////////
////////////////// - 20.07.09
// 20.07.09
  codigosprodutos:='';
  if EdGera74.text='S' then begin
    for p:=0 to Lista75.count-1 do begin
      if trim(Lista75[p])<>'' then
        codigosprodutos:=codigosprodutos+Lista75[p]+';';
    end;
//    Mesano:=strzero(Datetomes(EdTermino.Asdate),2)+strzero(Datetoano(EdTermino.Asdate,true),4);
// 12.08.09
    Mesano:=EdMesano.text;
    QGeral:=Sqltoquery('select * from salestoque where saes_status=''N'''+
//              ' and '+FGeral.GetIN('saes_esto_codigo',codigosprodutos,'C')+
              ' and saes_unid_codigo='+EdUnid_codigo.AsSql+
              ' and saes_mesano='+stringtosql(FGeral.AnoMesinvertido(Mesano))+
              ' and saes_qtde>=0'+
              ' order by saes_esto_codigo' );
    if QGeral.Eof then
      Avisoerro('N�o encontrado invent�rio ref. '+Mesano+'.  Registro 74 n�o gerado');

    while not QGeral.Eof do begin
      custo:=QGeral.fieldbyname('saes_customedio').ascurrency;
      Codigoposse:='1';
{
1 Mercadorias de propriedade do
Informante e em seu poder
2 Mercadorias de propriedade do
Informante em poder de
terceiros
3 Mercadorias de propriedade de
terceiros em poder do
Informante
}
//    if QGeral.fieldbyname('saes_qtde').ascurrency>0 then begin
// 10.10.13 - Asterio - Giacomoni - gerar zerado
      if QGeral.fieldbyname('saes_qtde').ascurrency>=0 then begin
        linha:='74'+
             FGeral.Datetostringinvertida(Edtermino.asdate)+   // data inventario
             strspace(QGeral.fieldbyname('saes_esto_codigo').asstring,14)+   // codigo do produto
             FGeral.Exportanumeros(QGeral.fieldbyname('saes_qtde').ascurrency,13,3)+    // qtde
             FGeral.Exportanumeros(QGeral.fieldbyname('saes_qtde').ascurrency*Custo,13,2)+               // TOTAL ITEM ( UNITARIO*QTDE )
             Codigoposse+   // codigo de posse da mercadoria
//             strspace(EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring,14)+  // cnpj possuidor mercad.
//             strspace( tirasintegra(EdUnid_codigo.resultfind.fieldbyname('unid_inscricaoestadual').asstring) ,14)+
// codigo de posse = 1 envia zerados ou espa�os
             strzero(0,14)+  // cnpj possuidor mercad.
             space(14)+
             strspace(EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring,2)+  // UF possuidor mercad.
             space(45);
             Writeln(Arquivo,linha);
             Lista74.Add(linha);  // s� pra contar os registros 74
             if Lista75.IndexOf(QGeral.fieldbyname('saes_esto_codigo').asstring)=-1 then begin
               Lista75.Add(QGeral.fieldbyname('saes_esto_codigo').asstring);
               Lista75aux.Add(Q.fieldbyname('move_esto_codigo').asstring);
             end
      end;
      QGeral.Next;
    end;
////////////////    FGeral.FechaQuery(QGeral);
// 17.08.11
  end;

  for p:=0 to Lista75.count-1 do begin
    linha:='75'+FGeral.Datetostringinvertida(Edinicio.asdate)+
           FGeral.Datetostringinvertida(Edtermino.asdate)+
           strspace(lista75[p],14)+   // codigo do produto
           strspace(lista75[p],08)+   // codigo NCM - Nomenclatura Comum no Mercosul
           strspace(FEstoque.getdescricao(lista75[p]),53)+   // descricao produto
           strspace(FEstoque.getunidade(lista75[p]),06)+     // unidade
           FGeral.Exportanumeros(0,05,2)+                  // aliquota ipi
           FGeral.Exportanumeros(FEstoque.Getaliquotaicms(lista75[p],EdUnid_codigo.text,EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring),04,2)+                  // aliquota icms
           FGeral.Exportanumeros(0,05,2)+               // % de redu��o de base de c�lculo
           FGeral.Exportanumeros(0,13,2);               // base de c�lculo de subst. tributaria

    Writeln(Arquivo,linha);
  end;

// 15.08.11
  for p:=0 to lista85.count-1 do begin
    linha:=lista85[p];
    Writeln(Arquivo,linha);
  end;
  for p:=0 to lista86.count-1 do begin
    linha:=lista86[p];
    Writeln(Arquivo,linha);
  end;
/////////////////////////////

  linha:='90'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring,14)+
         strspace( tirasintegra(EdUnid_codigo.resultfind.fieldbyname('unid_inscricaoestadual').asstring) ,14);
  if lista50.Count>0 then
    linha:=linha+'50'+strzero(lista50.count,8);
  if lista51.Count>0 then
    linha:=linha+'51'+strzero(lista51.count,8);
  if lista53.Count>0 then
    linha:=linha+'53'+strzero(lista53.count,8);
  if lista54.Count>0 then
    linha:=linha+'54'+strzero(lista54.count,8);
  if lista60.Count>0 then
    linha:=linha+'60'+strzero(lista60.count,8);
  if lista61.Count>0 then
    linha:=linha+'61'+strzero(lista61.count,8);
  if lista70.Count>0 then
    linha:=linha+'70'+strzero(lista70.count,8);
  if lista71.Count>0 then
    linha:=linha+'71'+strzero(lista71.count,8);
  if lista74.Count>0 then
    linha:=linha+'74'+strzero(lista74.count,8);
  if lista75.Count>0 then
    linha:=linha+'75'+strzero(lista75.count,8);
  if lista85.Count>0 then
    linha:=linha+'85'+strzero(lista85.count,8);
  if length(linha)>=110 then begin
    linha902:='90'+strspace(EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring,14)+
         strspace( tirasintegra(EdUnid_codigo.resultfind.fieldbyname('unid_inscricaoestadual').asstring) ,14);
    if lista86.Count>0 then
      linha902:=linha902+'86'+strzero(lista86.count,8);
    linha:=strspace(linha,125)+'2';
    Writeln(Arquivo,linha);
    linha902:=linha902+'99'+strzero(lista50.count+lista51.count+lista53.count+lista54.count+
           lista70.count+lista71.count+lista74.count+lista75.count+Lista61.Count+4+Lista60.count+Lista85.count+Lista86.count,8);   // +4 ref. aos tipos 10,11 e 2 do 90
    linha902:=strspace(linha902,125)+'2';
    Writeln(Arquivo,linha902);
  end else begin
    linha902:='';
    if lista86.Count>0 then
      linha:=linha+'86'+strzero(lista86.count,8);
    linha:=linha+'99'+strzero(lista50.count+lista51.count+lista53.count+lista54.count+
           lista70.count+lista71.count+lista74.count+lista75.count+Lista61.Count+3+Lista60.count+Lista85.count+Lista86.count,8);   // +3 ref. aos tipos 10,11 e 90
    linha:=strspace(linha,125)+'1';
    Writeln(Arquivo,linha);
  end;
// 15.05.09
  if trim(nomearqe+nomearqs)<>'' then begin
    lista70.Clear;  // usado lista 70 so pra nao criar outro...
    for p:=0 to listaPisCofins.count-1 do begin
      linha:=listaPisCofins[p];
      strtolista(Lista70,linha,';',true);
      if pos( copy(LIsta70[7],1,1),'5;6;7' ) >0 then
        Writeln(ArquivoS,linha)
      else
        Writeln(ArquivoE,linha);
      Lista70.Clear;
    end;
    Closefile(arquivoE);
    Closefile(arquivoS);
  end;
  Sistema.setmessage('Criando arquivo texto '+nomearq+'.txt');

  Sistema.Endprocess('Arquivo '+nomearq+'.txt'+': Exportados '+inttostr(n)+' documentos de entrada e saida');
  if trim(nomearqe+nomearqs)<>'' then
    Sistema.Endprocess('Exportados '+inttostr(n)+' documentos de entrada e saida para Pis/Cofins');
  Closefile(arquivo);
  Lista50.Clear;Lista54.Clear;
  Lista61.Clear;Lista70.clear;Lista71.clear;
  Lista60.clear;Lista53.Clear;
  Lista85.clear;Lista86.Clear;

  Texto.Lines.Add('Total Notas Ent:'+floattostr(totalent));
  Texto.Lines.Add('Total Notas Sai:'+floattostr(totalsai));
  Texto.Lines.Add('IPI total      :'+floattostr(totalipi));
  Texto.Lines.Add('Desconto total :'+floattostr(totaldesco));
  Texto.Lines.Add('Frete total    :'+floattostr(totalfrete));
  Texto.Lines.Add('Subst. total   :'+floattostr(totalsubs));

// 06.10.11 - j� valida com o sintegra - por enquanto s� PR
  if EdUnid_codigo.ResultFind.FieldByName('unid_uf').asstring='PR' then
    nomesintegra:='C:\Arquivos de programas\ValidaPR\ValidaPR.exe'
  else
    nomesintegra:='';
  if nomesintegra<>'' then begin
    if not fileexists( nomesintegra ) then nomesintegra:='D:\Arquivos de programas\ValidaPR\ValidaPR.exe';
    if not fileexists( nomesintegra ) then nomesintegra:='E:\Arquivos de programas\ValidaPR\ValidaPR.exe';
    if not fileexists( nomesintegra ) then nomesintegra:='G:\Arquivos de programas\ValidaPR\ValidaPR.exe';
// 10.07.12
    if not fileexists( nomesintegra ) then nomesintegra:='C:\Program Files (x86)\ValidaPR\ValidaPR.exe'
    else if not fileexists( nomesintegra ) then nomesintegra:='D:\Program Files (x86)\ValidaPR\ValidaPR.exe'
    else nomesintegra:='E:\Program Files (x86)\ValidaPR\ValidaPR.exe';


  //    if fileexists('\Lei\Aciwin\acilei.exe') then begin
    if fileexists( nomesintegra ) then begin
  //      h1:=findwindow(nil,'ACI Windows');
  //      h1:=findwindow(nil,'ACI');
//        h1:=findwindow(nil,'VALIDA-PR');
        h1:=findwindow(nil,'VALIDAPR');
//        nomeexecsintegra:=nomesintegra+' , "'+nomearq+'.txt'+'"';
//        nomeexecsintegra:='"'+nomesintegra+' "'+nomearq+'.txt'+'"';
//        nomeexecsintegra:=nomesintegra+','+nomearq+'.txt';
        nomeexecsintegra:=nomesintegra+' , '+nomearq+'.txt';
        if iswindow(h1)=false then begin
          Sistema.beginprocess('Acessando Valida-PR');
//          WinExec( PAnsiChar( nomeexecsintegra ), SW_SHOW);
          WinExec( PAnsiChar( nomeexecsintegra ), SW_SHOW);
          Sistema.endprocess('');
        end else begin
          showwindow(h1,sw_show);
          SetForegroundWindow(H1);
        end;
    end;
  end;

// 13.11.07
//  Closefile(arquivoteste);

end;

procedure TFSintegra.EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
////////////////////////////////////////////////////////////////////////////
begin
   FGeral.limpaedit(EdUNid_codigo,key)
end;

function TFSintegra.GetNumerodoEndereco(endereco: string;codigo:integer=0;mensagem:string='S'): string;
var posicaovirgula,posicaokm,posicao2numeros:integer;
begin
   posicaovirgula:=pos(',',endereco);
   posicaokm:=pos('KM',uppercase(endereco));
   posicao2numeros:=Posicao2num(endereco);
   if posicaovirgula>0 then
     result:=copy(endereco,posicaovirgula+1,5)
   else if posicaokm>0 then
     result:=copy(endereco,posicaokm+3,4)
   else if posicao2numeros>0 then
     result:=copy(endereco,posicao2numeros,4)
   else begin
     result:='';
     if (mensagem='S') and (codigo>0) then
       Avisoerro('Falta colocar a v�rgula antes do numero no endere�o '+endereco+' Codigo '+inttostr(codigo));
   end;
end;

procedure TFSintegra.EdfinalidadeExitEdit(Sender: TObject);
begin
  bexecutarclick(self);
end;

function TFSintegra.Posicao2num(endereco: string): integer;
var t,p,n:integer;
begin
  t:=length(trim(endereco));
  n:=0;
//  for p:=0 to t do begin
  for p:=1 to t do begin
    if endereco[p] in ['0'..'9'] then begin
      if endereco[p+1] in ['0'..'9'] then begin
        n:=p;
        break;
      end
    end;
  end;
  result:=n;
end;

////////////////////////////////////////
procedure TFSintegra.GeraRegistros60;
///////////////////////////////////////
var Q:TSqlquery;
    linha,separador,tiposnao,SqlunidadesDet:string;
    ListaAliquotas,ListaAliquota:TStringList;
    p:integer;
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
          result:='60'+separador+
                 tipo+separador+
                 FGeral.DataStringinvertida( lista[2] )+separador+  // emissao
                 strspace( lista[3] ,20 )+separador+   // Numero de Serie de fabrica
                 strzero(  strtoint(lista[4]) ,03 )+separador+   // Numero do Equipamento
                 strspace( lista[5] ,02 )+separador+   // Modelo do cupom fiscal
                 strzero( strtoint(lista[6]) ,6 ) +separador+   // primeiro COO do dia
                 strzero( strtoint(lista[7]) ,6 ) +separador+   // ultimo COO do dia
                 strzero( strtoint(lista[8]) ,6 ) +separador+   // CRZ
                 strzero( strtoint(lista[9]) ,3 ) +separador+   // CRO
                 FGeral.Exportanumeros(texttovalor(lista[10]),16,2)+separador+   // venda bruta
                 FGeral.Exportanumeros(texttovalor(lista[11]),16,2)+separador+   // tot.geral
                 space( 37 ) ;
      end else if tipo='A' then begin
          result:='60'+separador+
                  tipo+separador+
                 FGeral.DataStringinvertida(lista[2])+  // emissao
                 strspace(lista[03],20)+separador+   // Numero de Serie
                 ValorouLetras( Lista[04] )+separador+   // aliquota icms/situacao
                 FGeral.Exportanumeros(texttovalor(lista[05]),12,2)+separador+   // valor ref. aliquota
// 10.07.12  - ainda nao sei pq mas na leitura Z t� invertido subst.trib. 'F' com o 'N' - isento icms
//                 FGeral.Exportanumeros( GetValorCF( ValorouLetras( Lista[04] ),Lista[2] ) ,12,2)+separador+   // valor ref. aliquota
                 space( 79 );

      end else if tipo='R' then begin
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
   separador:='';
   tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+Global.CodContrato+';'+
            Global.CodVendaInterna;
   Sistema.beginprocess('Gerando registros 60M e 60A');
   Q:=sqltoquery('select * from movleituraecf where mecf_status=''N'''+
                 ' and mecf_tipo=''Z'''+
//                 ' and extract( month from mecf_data )='+inttostr(mes)+
//                 ' and extract( year from mecf_data )='+inttostr(ano)+
                 ' and mecf_data >= '+EdInicio.AsSql+
                 ' and mecf_data <= '+EdTermino.AsSql+
                 ' and '+FGeral.GetIN('mecf_unid_codigo',EdUNid_codigo.text,'C') );
   ListaAliquotas:=TStringList.create;
   ListaAliquota:=TStringList.create;
   while not Q.eof do begin
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
     end;  // se > 0
     Q.Next;
   end;

   FGeral.FechaQuery(Q);
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
   Sistema.endprocess('');

end;

// 27.02.14
function TFSintegra.BuscaIPInositem(stransacao, xcfop50: string): currency;
///////////////////////////////////////////////////////////////////////////////
var QI:TSqlQuery;
    xvalor,yretorno:currency;
    sqlcfop:string;
begin
  sqlcfop:='';
  if trim(xcfop50)<>'' then sqlcfop:=' and move_natf_codigo='+Stringtosql(xcfop50);
  QI:=Sqltoquery('select move_venda,move_qtde,move_aliipi from movestoque where move_transacao='+
                 Stringtosql(stransacao)+' and move_status=''N'''+
                 sqlcfop );
  yretorno:=0;
  while not QI.Eof do begin
//    xvalor:=( QI.fieldbyname('move_venda').ascurrency*QI.fieldbyname('move_qtde').ascurrency ) *
//            ( QI.fieldbyname('move_aliipi').ascurrency/100 );
// 14.06.14
    xvalor:=( ( QI.fieldbyname('move_venda').ascurrency*QI.fieldbyname('move_qtde').ascurrency ) *
            ( QI.fieldbyname('move_aliipi').ascurrency ) )/100;
    xvalor:=FGeral.Arredonda(xvalor,2);
    yretorno:=yretorno+xvalor;
    QI.next;
  end;
  FGeral.FechaQuery(QI);
  result:=yretorno;
end;

end.
