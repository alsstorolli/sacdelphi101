unit explivrofis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  SQLGrid, ExtCtrls, SqlExpr;

type
  TFExpLivFiscal = class(TForm)
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
    procedure FormActivate(Sender: TObject);
    procedure bExecutarClick(Sender: TObject);
    procedure EdterminoValidate(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
  end;

var
  FExpLivFiscal: TFExpLivFiscal;
  Arquivo:Textfile;
  nomearq:string;
  QGeral:TSqlquery;

const versao:string='20010530';    ////        '20021220'

implementation

uses SqlSis, Arquiv, Geral, Sqlfun, ConfMovi, represen, fornece,
  cadcli, munic, Transp, Unidades, Estoque;


{$R *.dfm}

procedure TFExpLivFiscal.Execute;
var versaook:string;
    Mat:TStringlist;
    p:integer;

begin
  nomearq:='\SAC\IMPORTA.TXT';
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
  Show;

end;

procedure TFExpLivFiscal.FormActivate(Sender: TObject);
begin
  if trim(EdUnid_codigo.text)='' then
    EdUnid_codigo.text:=Global.CodigoUnidade;
  if not Arq.Tclientes.active then Arq.Tclientes.open;
  if not Arq.TFornec.active then Arq.TFornec.open;
  if not Arq.TConfMovimento.active then Arq.TConfMovimento.open;
  if not Arq.TUnidades.active then Arq.TUnidades.open;
  if not Arq.TRepresentantes.active then Arq.TRepresentantes.open;
  if not Arq.TTransp.active then Arq.TTransp.open; 

  EdInicio.setfocus;

end;

procedure TFExpLivFiscal.bExecutarClick(Sender: TObject);
var Q:TSqlquery;
    empresa,filial,n,p,totalregE,totalregS,totalregR,totalregC,totalregI,numero:integer;
    EmitentesCodigo,Emitentes,Clientes,ClientesCodigo,Lista,ItensCodigo:TStringlist;
    linha,sist,es,cfop,elemento,nomecad,uf,cidade,cep,cnpjcpf,insest,endereco,tomador,tipos,tipomov,transacao,especie,serie:string;
    vlrdesco,vlracres,totalitem,valorzero,isentas,outras,baseicmsst,valoricmsst,valorcontabil,tvalorcontabil:currency;
    primeiroitem:boolean;

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
    begin
      if tipoCad='U' then
        result:=EdUnid_codigo.resultfind.fieldbyname('unid_municipio').asstring
      else if tipoCad='R' then
        result:=FRepresentantes.GetDescricao(Arq.TRepresentantes.fieldbyname('repr_cida_codigo').asinteger)
      else if tipoCad='F' then
        result:=FFornece.Getcidade(QGeral.fieldbyname('forn_cida_codigo').asinteger)
      else if tipoCad='T' then
        result:=FTransp.GetCidade(Arq.TTransp.fieldbyname('tran_cida_codigo').asstring)
      else
        result:=FCadcli.GetCidade(QGeral.fieldbyname('clie_cida_codigo_res').asinteger);
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
      if result='XX' then
        result:=EdUnid_codigo.resultfind.fieldbyname('unid_uf').asstring;
    end;

    function GetCEP(tipocad:string):string;
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

    function GetCNPJ(tipocad:string;codigo:integer=0):string;
    begin
      if tipoCad='U' then
        result:=EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring
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
        result:=EdUnid_codigo.resultfind.fieldbyname('unid_inscricaoestadual').asstring
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


begin

  if not EdUnid_codigo.validfind then exit;
  if not EdUnid_codigo.valid then exit;
  if not EdTermino.valid then exit;
  if EdUNid_codigo.resultfind.fieldbyname('unid_empresa1').asinteger=0 then begin
    Avisoerro('Falta configurar o codigo da empresa 1 no cadastro de unidades');
    exit;
  end;
  if not confirma('Confirma exportação ?') then exit;
  texto.clear;
  tipos:=global.CodVendaDireta+';'+Global.CodVendaConsig+';'+Global.CodVendaSemMovEstoque+';'+
         Global.CodVendaProntaEntrega+';'+Global.CodVendaMagazine+';'+
         Global.CodCompra+';'+Global.CodCompraSemMovEstoque+';'+global.CodConhecimento+';'+
         Global.CodCompra100+';'+Global.CodVendaBrinde+';'+Global.CodDevolucaoCompra+';'+
         Global.CodVendaSerie4+';'+global.CodVendaLiqSerie4+';'+
//         global.CodVendaRomaneio+';'+global.CodVendaAmbulante;
         global.CodVendaRomaneio+';'+global.CodVendaAmbulante+';'+Global.CodTransfEntrada+';'+
         Global.CodTransfSaida+';'+Global.CodTransImob;
//  tipos:='';   // 02.02.05  'vai tudo'
// 03.02.05 - tipos q NAO VAO
//  tipos:=global.CodRemessaConsig+';'+Global.CodDevolucaoConsig+';'+Global.CodAcertoEsEnt+';'+global.CodAcertoEsSai;
  Sistema.beginprocess('Lendo movimento do período');
//
//{
  Q:=sqltoquery('select * from movestoque'+
//                ' inner join movesto on (moes_transacao=move_transacao and moes_unid_codigo=move_unid_codigo)'+
                ' inner join movesto on (moes_transacao=move_transacao)'+
//                ' inner join movbase on (movb_transacao=move_transacao)'+
//                ' inner join movesto on (moes_numerodoc=move_numerodoc and moes_tipomov=move_tipomov and moes_datamvto=move_datamvto and moes_unid_codigo=move_unid_codigo)'+
//                ' left join movbase on (movb_numerodoc=move_numerodoc and movb_tipomov=move_tipomov)'+
                ' where '+FGeral.Getin('move_status','N;X','C')+
                ' and move_datamvto>='+EdInicio.assql+
                ' and move_datamvto<='+EdTermino.assql+
//                ' and substr(moes_natf_codigo,1,1) in (''1'',''2'',''3'',''5'',''6'',''7'')'+
                ' and move_unid_codigo='+EdUnid_codigo.assql+
                ' and move_tipomov=moes_tipomov'+
//                ' and moes_unid_codigo='+EdUnid_codigo.assql+
// com esta merda aqui fode a query....04.02.05 - vspqne.....
                ' and moes_datacont is not null'+
                ' and '+FGeral.getin('move_tipomov',tipos,'C')+
                ' and '+FGeral.getin('moes_tipomov',tipos,'C')+
//                ' order by move_datamvto' );
                ' order by move_numerodoc,move_tipomov' );
//                ' order by moes_transacao' );
//}


  if Q.eof then begin
    Avisoerro('Nada encontrado para exportação');
    exit;
  end;

  Sistema.beginprocess('Exportando movimento de entrada e saida');
  Emitentes:=Tstringlist.create;
  Clientes:=Tstringlist.create;
  EmitentesCodigo:=Tstringlist.create;
  ClientesCodigo:=Tstringlist.create;
  ItensCodigo:=Tstringlist.create;
  empresa:=EdUNid_codigo.resultfind.fieldbyname('unid_empresa1').asinteger;
  filial:=EdUNid_codigo.resultfind.fieldbyname('unid_filial1').asinteger;
  sist:='99';
  n:=0;
  valorzero:=0;isentas:=0;outras:=0;valoricmsst:=0;baseicmsst:=0;
  totalregE:=0;totalregS:=0;totalregR:=0;totalregC:=0;totalregI:=0;
  AssignFile(Arquivo, nomearq );
  Rewrite(Arquivo);
  linha:=versao;
  Writeln(Arquivo,linha);
  tvalorcontabil:=0;
  texto.clear;

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
    tipomov:=Q.fieldbyname('moes_tipomov').asstring;
    numero:=Q.fieldbyname('moes_numerodoc').asinteger;
    transacao:=Q.fieldbyname('moes_transacao').asstring;
    primeiroitem:=true;
    if es='S' then
      tvalorcontabil:=tvalorcontabil+Q.fieldbyname('moes_vlrtotal').ascurrency;

//    if pos(Q.fieldbyname('moes_tipomov').asstring,global.CodVendaRomaneio+';'+global.CodVendaAmbulante+';'+Global.CodTransfEntrada+';'+Global.CodTransfSaida+';'+Global.CodTransImob)>0 then begin
//      avisoerro('Nota '+Q.fieldbyname('moes_numerodoc').asstring+' Tipo '+Q.fieldbyname('moes_tipomov').asstring+' '+formatfloat(f_cr,Q.fieldbyname('moes_vlrtotal').ascurrency));
//    end;

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

    while (not Q.eof) and (Q.fieldbyname('moes_numerodoc').asinteger=numero) and (Q.fieldbyname('moes_tipomov').asstring=tipomov) do begin
//    while (not Q.eof) and (Q.fieldbyname('moes_transacao').asstring=transacao)  do begin

          totalitem:=FGEral.Arredonda(Q.fieldbyname('move_qtde').ascurrency*Q.fieldbyname('move_venda').ascurrency,2);
          primeiroitem:=false;
          if Q.fieldbyname('moes_perdesco').ascurrency>0 then
//             vlrdesco:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100),2)
             vlrdesco:=totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100)
// 12.02.05 - mudado para ver se a base nao fica maior no livro fiscal da viasoft
//             vlrdesco:=FGeral.Arredonda(valorcontabil*(Q.fieldbyname('moes_perdesco').ascurrency/100),2)
          else
            vlrdesco:=0;
          if Q.fieldbyname('moes_peracres').ascurrency>0 then
            vlracres:=totalitem*(Q.fieldbyname('moes_peracres').ascurrency/100)
//            vlracres:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_peracres').ascurrency/100),2)
// 12.02.05 - mudado para ver se a base nao fica maior no livro fiscal da viasoft
//            vlracres:=FGeral.Arredonda(valorcontabil*(Q.fieldbyname('moes_peracres').ascurrency/100),2)
          else
            vlracres:=0;
//          if primeiroitem then begin
            valorcontabil:=Q.fieldbyname('moes_vlrtotal').ascurrency;
//          end else
//            valorcontabil:=0;
// 04.02.05
//            valorcontabil:=totalitem-vlrdesco;

          if Q.fieldbyname('moes_status').asstring='X' then
            cfop:='   0'
          else
            cfop:=copy(Q.fieldbyname('moes_natf_codigo').asstring,1,4);
          if pos(Es,'E/S')>0 then begin
            linha:=es+DatetoTextInvertida(Q.fieldbyname('moes_datamvto').asdatetime,true)+
                 strspace(especie,4)+
                 strspace(serie,3)+
    //  02.02.05 - ver pois algumas nf estao sem condicao de pagamento V ou P
                 strspace(Q.fieldbyname('moes_vispra').asstring,1)+
                 spacestr(Q.fieldbyname('moes_numerodoc').asstring,8)+
                 spacestr(Q.fieldbyname('moes_numerodoc').asstring,8)+
                 DatetoTextInvertida(Q.fieldbyname('moes_dataemissao').asdatetime,true)+
                 spacestr(Q.fieldbyname('moes_tipo_codigo').asstring,8)+
                 Fgeral.Exportanumeros(Q.fieldbyname('move_qtde').ascurrency,14,2)+
                 spacestr(Q.fieldbyname('move_esto_codigo').asstring,10)+
                 Fgeral.Exportanumeros(vlrdesco,14,2)+
                 Fgeral.Exportanumeros(vlracres,14,2)+
                 space(40)+space(20)+
//                 copy(Q.fieldbyname('moes_natf_codigo').asstring,3,2)+   // ver este tal do "sub_cfo"
// 04.02.05 - se mandar atrapalhar a alteração no viasoft - Leila+Walmir
                 space(02)+
                 spacestr(copy(Q.fieldbyname('move_cst').asstring,2,2),8)+
                 space(40)+space(14)+space(18)+
                 cfop+
                 Fgeral.Exportanumeros(valorcontabil,14,3)+
//                 Fgeral.Exportanumeros(totalitem,14,3)+
//                 Fgeral.Exportanumeros(valorcontabil-vlracres,14,2)+
// 12.02.05 - tirando o desconto
                 Fgeral.Exportanumeros(totalitem-vlrdesco,14,2)+
//                 Fgeral.Exportanumeros(Q.fieldbyname('moes_baseicms').ascurrency,14,2)+
                 Fgeral.Exportanumeros(Q.fieldbyname('move_aliicms').ascurrency,06,2)+
                 Fgeral.Exportanumeros((totalitem-vlrdesco)*(Q.fieldbyname('move_aliicms').ascurrency/100),14,2)+
// 12.02.05
// 04.02.05
//                 Fgeral.Exportanumeros((valorcontabil-vlracres)*(Q.fieldbyname('move_aliicms').ascurrency/100),14,2)+
//                 Fgeral.Exportanumeros(Q.fieldbyname('moes_baseicms').ascurrency,14,2)+
//                 Fgeral.Exportanumeros(Q.fieldbyname('moes_valoricms').ascurrency,14,2)+
                 Fgeral.Exportanumeros(isentas,14,2)+
                 Fgeral.Exportanumeros(outras,14,2)+
                 Fgeral.Exportanumeros(valorzero,14,2)+  // extras icms ( valor ipi, por exemplo)
                 Fgeral.Exportanumeros(valorzero,14,2)+  // base ipi
                 Fgeral.Exportanumeros(valorzero,14,2)+  // valor ipi
                 Fgeral.Exportanumeros(valorzero,14,2)+  // isentas ipi
                 Fgeral.Exportanumeros(valorzero,14,2)+  // outras ipi
                 space(48)+  // observacao
                 Fgeral.Exportanumeros(valorzero,14,2)+  // funrural
                 space(03)+
                 '01'+   // checar esse tal codigo da base de calculo q só tem para saida
                 Fgeral.Exportanumeros(baseicmsst,14,2)+  // base icms s.t.  ver com 'ratear' a base da nota pelos produtos
                 Fgeral.Exportanumeros(valoricmsst,14,2)+  // valor icms s.t.  ou se terá q gravar em cada item
                 '!';

    //         if   pos('S',Q.fieldbyname('moes_serie').asstring)>0 then

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
          Writeln(Arquivo,linha);
          if Es='E' then begin
            if EmitentesCodigo.IndexOf(Q.fieldbyname('moes_tipo_codigo').asstring)<0 then begin
              Emitentes.Add(Q.fieldbyname('moes_tipo_codigo').asstring+';'+Q.fieldbyname('moes_tipocad').asstring);
              EmitentesCodigo.Add(Q.fieldbyname('moes_tipo_codigo').asstring)
            end;
          end else begin
            if ClientesCodigo.IndexOf(Q.fieldbyname('moes_tipo_codigo').asstring)<0 then begin
              Clientes.Add(Q.fieldbyname('moes_tipo_codigo').asstring+';'+Q.fieldbyname('moes_tipocad').asstring);
              ClientesCodigo.Add(Q.fieldbyname('moes_tipo_codigo').asstring);
            end;
          end;
          if ItensCodigo.IndexOf(Q.fieldbyname('move_esto_codigo').asstring)<0 then begin
              ItensCodigo.Add(Q.fieldbyname('move_esto_codigo').asstring);
          end;
          Q.Next;
// ver colocar aqui o end do if datacont...
    end;
    inc(n);

  end;

///////////////////////////////////////////////////////////////
  sistema.beginprocess('Armazenando fornecedores');
  for p:=0 to Emitentes.count-1 do begin
    Lista:=TStringlist.create;
    elemento:=Emitentes[p];
    strtolista(lista,elemento,';',true);
//    nomecad:=Ups(FGeral.GetNomeTipoCad( strtoint(Lista[0]),Lista[1] ) );
    nomecad:=Ups(FGeral.GetNomeRazaoSocialEntidade( strtoint(Lista[0]),Lista[1],'N' ) );
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
    if QGeral<>nil then begin
      Qgeral.close;
      Freeandnil(QGeral);
    end;
    linha:='R'+space(08)+space(04)+space(03)+space(01)+FGeral.Exportanumeros(0,8,0)+FGeral.Exportanumeros(0,8,0)+space(8)+
            FGeral.Exportanumeros(strtoint(Lista[0]),8,0)+
            FGeral.Exportanumeros(0,14,2)+FGeral.Exportanumeros(0,10,0)+FGeral.Exportanumeros(0,14,2)+FGeral.Exportanumeros(0,14,2)+
            strspace( nomecad,40)+
            strspace( cidade,20 )+
            strspace( uf,02 )+
            strspace( cep,08 )+
            strspace( endereco,40 )+
            strspace( cnpjcpf,14 )+
            strspace( insest,18 )+
            FGeral.Exportanumeros(0,4,0)+FGeral.Exportanumeros(0,14,3)+FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,06,0)+
            FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,14,0)+
            FGeral.Exportanumeros(0,14,0)+space(14)+FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,14,0)+
            space(48)+FGeral.Exportanumeros(0,14,0)+space(03)+space(02)+FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,14,0)+'!';
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
    nomecad:=Ups(FGeral.GetNomeRazaoSocialEntidade( strtoint(Lista[0]),Lista[1],'N' ) );
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
    except
      avisoerro('Problemas cidade,uf,cep,cnpjcpf,instest');
      break;
    end;
    if QGeral<>nil then begin
      Qgeral.close;
      Freeandnil(QGeral);
    end;
    linha:='C'+space(08)+space(04)+space(03)+space(01)+FGeral.Exportanumeros(0,8,0)+FGeral.Exportanumeros(0,8,0)+space(8)+
            FGeral.Exportanumeros(strtoint(Lista[0]),8,0)+
            FGeral.Exportanumeros(0,14,2)+FGeral.Exportanumeros(0,10,0)+FGeral.Exportanumeros(0,14,2)+FGeral.Exportanumeros(0,14,2)+
//    linha:='C'+FGeral.Exportanumeros(strtoint(Lista[0]),8,0)+space(04)+space(03)+space(01)+FGeral.Exportanumeros(0,8,0)+FGeral.Exportanumeros(0,8,0)+space(8)+
            strspace( nomecad,40)+
            strspace( cidade,20 )+
            strspace( uf,02 )+
            strspace( cep,08 )+
            strspace( endereco,40 )+
            strspace( cnpjcpf,14 )+
            strspace( insest,18 )+
            FGeral.Exportanumeros(0,4,0)+FGeral.Exportanumeros(0,14,3)+FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,06,0)+
            FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,14,0)+
            FGeral.Exportanumeros(0,14,0)+space(14)+FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,14,0)+
            space(48)+FGeral.Exportanumeros(0,14,0)+space(03)+space(02)+FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,14,0)+'!';
    inc(totalregC);
    if strtoint(lista[0])>0 then
      Writeln(Arquivo,linha);
    Freeandnil(Lista);
  end;
/////////////////////////////ITENS
  sistema.beginprocess('Armazenando itens');
  for p:=0 to Itenscodigo.count-1 do begin
    Lista:=TStringlist.create;
    elemento:=Itenscodigo[p];
    strtolista(lista,elemento,';',true);
//    linha:='I'+DatetoTextInvertida(EdInicio.asdate,true)+space(04)+space(03)+
    linha:='I'+DatetoTextInvertida(EdTermino.asdate,true)+space(04)+space(03)+
            space(01)+
//            'A'+
            FGeral.Exportanumeros(0,8,0)+FGeral.Exportanumeros(0,8,0)+space(8)+
            FGeral.Exportanumeros(0,8,0)+
            FGeral.Exportanumeros(0,14,2)+
            spacestr( elemento,10)+
            FGeral.Exportanumeros(0,14,2)+
            FGeral.Exportanumeros(0,14,2)+
            strspace(FEstoque.GetDescricao(elemento),40)+
            space(20)+  // ver se esta classificação fiscal se refere ao ipi
            space(02)+
            '00000'+strspace(FEstoque.Getsituacaotributaria(elemento,EdUnid_codigo.text,EdUnid_codigo.ResultFind.fieldbyname('unid_uf').asstring),3)+
            space(40)+
            strspace(FEstoque.GetUnidade(elemento),14)+
            space(18)+   // NCM
            FGeral.Exportanumeros(0,4,0)+
            FGeral.Exportanumeros(0,14,3)+   // saldo em estoque
            FGeral.Exportanumeros(0,14,0)+   // valor unitário
            FGeral.Exportanumeros(0,06,0)+   // aliquota ipi
            FGeral.Exportanumeros(1,14,0)+   // qtde por embalagem
            FGeral.Exportanumeros(0,14,0)+   // % de redução da base do icms
            FGeral.Exportanumeros(0,14,0)+   // base de calc. subst. trib.
            FGeral.Exportanumeros(0,14,0)+   //
            FGeral.Exportanumeros(0,14,0)+  //
            FGeral.Exportanumeros(0,14,0)+  // outra aliquota de ipi
            FGeral.Exportanumeros(0,14,0)+
            FGeral.Exportanumeros(0,14,0)+
            space(48)+FGeral.Exportanumeros(0,14,0)+space(03)+space(02)+FGeral.Exportanumeros(0,14,0)+FGeral.Exportanumeros(0,14,0)+'!';
    Writeln(Arquivo,linha);
    Freeandnil(Lista);
  end;
  totalregI:=Itenscodigo.count;

  Freeandnil(Emitentes);Freeandnil(EmitentesCodigo);
  Freeandnil(Clientes);Freeandnil(ClientesCodigo);
  Freeandnil(itenscodigo);
///////////////////////////////////////////////////////////

// registro de venda ecfs
// registro de conhecimentos // Rever

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
  Sistema.Endprocess('Exportados '+inttostr(n)+' documentos de entrada e saida.  Saidas '+formatfloat(f_cr,tvalorcontabil));
  Closefile(arquivo);
end;

procedure TFExpLivFiscal.EdterminoValidate(Sender: TObject);
begin
   if EdTermino.asdate<EdInicio.Asdate then
     EdTermino.INvalid('Término tem que ser posterior ao inicio');
end;

procedure TFExpLivFiscal.EdUnid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdUNid_codigo,key);

end;

end.
