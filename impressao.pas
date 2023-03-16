
unit impressao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, SqlExpr, ACBrBase, ACBrETQ, Printers, ComObj,
  Word2000 ;

type
  TFImpressao = class(TForm)
    Memo: TMemo;
  private
    { Private declarations }
    function SetaDadosEntidade(p,Codigo:Integer;Categoria:String):String;
  public
    { Public declarations }
    procedure ConfChequesEmitidos(Codigo,Descricao:String);
    function ImprimeCheques(xconta,cheqi,cheqf:Integer;xtrans:string=''):Boolean;

    procedure ConfNotaSaida(Codigo,Descricao:String);
    function ImprimeNotaSaida(Nota:Integer;DataMvto:TDatetime;Unidade:string; tipomov:string='' ; Notaf:integer=0 ):Boolean;
    function ImprimeRomaneioRetorno(Nota:Integer;DataMvto:TDatetime;Unidade:string):Boolean;
// 24.05.10 - Silvano - Laser que nao imprime o textrel
    function ImprimeRemessa(Nota:Integer;DataMvto:TDatetime;Unidade:string; tipomov:string=''):Boolean;
// 30.06.11 - Capeg - Romaneio
//    function ImprimeRomaneioRemessaaOrdem(Nota:Integer;DataMvto:TDatetime;Unidade:string; tipomov:string=''):Boolean;

    procedure ConfNotaTransf(Codigo,Descricao:String);
    function ImprimeNotaTransf(Nota:Integer;DataMvto:TDatetime;Unidade:string;TipoMov:string=''):Boolean;

    procedure ConfReciboPen(Codigo,Descricao:String);
    function ImprimeReciboPen(Operacao:string;xTipo:string='';xValor:currency=0):Boolean;

// 14.09.05
    procedure ConfEtqCliente(Codigo,Descricao:String);
    function ImprimeEtqCliente(comando:string ; Ativos:string ; Datai,Dataf:TDatetime): Boolean;
// 22.09.05
    procedure ConfPedidoVenda(Codigo,Descricao:String);
    function ImprimePedidoVenda(Nota:Integer;DataMvto:TDatetime;Unidade:string;SemValor:string='N';xTipoMov:string='PV'):Boolean;

    function tiraaspas(comando:string):string;
// 16.06.06
    procedure Confbloqueto(Codigo,Descricao:String);
    function ImprimeBloqueto(Nota,NotaF:Integer;DataMvto:TDatetime;Unidade:string; tipomov:string='' ; xvenc:TDatetime=0;notas:string='';xvalor:currency=0):Boolean;
// 26.06.06
    function ImprimeInstrucoescobranca(impresso:string;qtde:integer ):Boolean;
// 31.07.06
    procedure Adicionalista(Lista:TStringlist ; s:string);
    function GetLIsta(Lista:TStringlist ; separador:string):string;
// 04.03.09
    procedure ConfNotaSaidaMo(Codigo,Descricao:String);
    function ImprimeNotaSaidaMo(Nota:Integer;DataMvto:TDatetime;Unidade:string; tipomov:string=''):Boolean;
// 08.09.09 - aqui em 20.05.10
    procedure ConfEtqProduto(Codigo,Descricao:String);
    function ImprimeEtqProduto(comando:string ; qtdetiquetas: integer ; colunas:integer ; tipo:string='X' ; PedeImp:boolean=true): Boolean;
// 12.08.10
    procedure ConfReciboCaixa(Codigo,Descricao:String);
    function ImprimeReciboCaixa(Operacao:string; xconf:string='S'):Boolean;
// 17.06.11 - Novicarnes - balança na saida
    procedure ConfEtqbalanca(Codigo,Descricao:String);
    function ImprimeEtqBalanca(comando:string ; colunas:integer ; tipo,confirmaimpressao:string ): Boolean;
// 19.08.13 - Metalfornte
    procedure ConfOrcamentoObra(Codigo,Descricao:String);
//    function ImprimeOrcamentoObra(Numero:Integer;DataMvto:TDatetime;Unidade,xNomeorcam:string):Boolean;
    function ImprimeOrcamentoObra(Numero:Integer;Unidade,xNomeorcam:string):Boolean;
//  05.11.18
    function GeraArquivoImagem(xCodigo:string):string;
// 21.02.20
    function ProdutoGenerico(codigo:string):boolean;
// 22.06.2022
    procedure ConfPedidoCompra(Codigo,Descricao:String);
    function ImprimePedidoCompra(Nota:Integer;DataMvto:TDatetime;Unidade:string;SemValor:string='N';xTipoMov:string='PV'):Boolean;

  end;

var
  FImpressao: TFImpressao;
  Visualiza:Boolean;
  sqlportadorcartao,sqlportadorboleto:string;

implementation

uses ConfDcto,SqlFun, Plano, Arquiv, CAdImp,SqlSis,Geral, Munic,
  ConPagto, Portador, Hist, Moedas, Unidades, Usuarios , Natureza, Estoque,
  ConfMovi, represen, TextRel, Ocorrenc, tabela, tamanhos, cadservicos,
  cadcor, dadosgrade;

type TEntidade=record
     Codigo,CNPJCPF,Nome,Razao,Classe,Conta,NomeConta,Endereco:String;
     Bairro,Cidade,UF,Fone,CEP,InscrEst,RG:String;
end;

type TDetalhe=Record
     Codigoproduto,Descricaoproduto,Cst,Unidade,DescricaoCor,DescricaoTamanho,DescricaoCopa,Ncmipi,Qualidade,Medidas:string;
     Unitario,Total,icms,quantidade,Tquantidade,perdesco,vendabru,ipi,descubagem,pecas,
     unitario1,unitario2,unitario3,pecasXqtde,pecasXqtdeXuni,
     margem,
     PesoProduto:currency;
     Codigocor,CodigoTamanho,Seq,Codigocopa,Codigoipi,Fardos,Pacotes:integer;
     Cubagem:extended;
end;


var QMovBco,QMestre,QDetalhe,QClientes,QPendencia,QMestre1,TTransp,QMestreDetalhe:TSqlQuery;
    QMestreCli:TMemoryquery;
    TamLinhaExtenso1,Tpecastotal:Integer;
    Entidade:Array[1..100] of TEntidade;
//    ValorParcelaPendFin:Array[0..99] of Currency;
//    VctoParcelaPendFin:Array[0..99] of TDateTime;
    NPar,NroPagina,NroPaginas,TamanhoImpressaoDescricao:Integer;
    Retorno:Array[1..50] of String;
    Listadetalhe:TList;
    PDetalhe:^TDetalhe;
    ven1,ven2,ven3,ven4,ven5,ven6,dataven01,dataven02,dataven03,dataven04,dataven05,dataven06,
    dataven07,dataven08,dataven09,dataven10:TDatetime;
    venc1,venc2,venc3,venc4,venc5,venc6,parc1,parc2,parc3,parc4,parc5,parc6,condicao,numero01,numero02,numero03,
    numero04,numero05,numero06,numero07,numero08,numero09,numero10:string;
    Tipomovtonfsaida,PedidoPendente,Listaclassificaoipi,cfop01,cfop02,cfop03,descricaogrande:string;
    Valorrecibo,Tqtdetotal,valoravista,baseicms01,baseicms02,baseicms03,
    Tvalortotal1,Tvalortotal2,Tvalortotal3,TPesoTotal,valorven01,valorven02,valorven03,valorven04,
    valorven05,valorliquido,valorvendas,valornp,valorbp,valorven06,valorven07,valorven08,valorven09,
    valorven10,valorbpantes:currency;
    ListaNcm,ListaComandos:TStringlist;
    Campo:TDicionario;


{$R *.dfm}




function TFImpressao.SetaDadosEntidade(p,Codigo:Integer;Categoria:String):String;
////////////////////////////////////////////////////////////////////////////////////
var QFornecedores,QFuncionarios,QUnidades:TSqlQuery;
begin
  if p>100 then Exit;
  with Entidade[p] do begin
    Codigo:='';CNPJCPF:='';Nome:='';Razao:='';Classe:='';Conta:='';NomeConta:='';Endereco:='';Bairro:='';
    Cidade:='';UF:='';Fone:='';CEP:='';InscrEst:='';RG:='';
  end;
  if Categoria='F' then begin
     QFornecedores:=SqlToQuery('SELECT * FROM Fornecedores WHERE Forn_Codigo='+IntToStr(Codigo));
     QFornecedores.Name:='QFornecedores';
     if not QFornecedores.IsEmpty then begin
        Entidade[p].Razao:=Trim(QFornecedores.FieldByName('Forn_RazaoSocial').AsString);
        if Entidade[p].Razao='' then Entidade[p].Razao:=Trim(QFornecedores.FieldByName('Forn_Nome').AsString);
        Entidade[p].Nome:=Trim(QFornecedores.FieldByName('Forn_Nome').AsString);
        Entidade[p].Codigo:=IntToStr(Codigo);
        Entidade[p].CNPJCPF:=FormatoCGCCPF(QFornecedores.FieldByName('Forn_CNPJCPF').AsString);
        Entidade[p].Endereco:=Trim(QFornecedores.FieldByName('Forn_Endereco').AsString);
        Entidade[p].Bairro:=Trim(QFornecedores.FieldByName('Forn_Bairro').AsString);
        Entidade[p].Cidade:=FCidades.GetNome(QFornecedores.FieldByName('Forn_Muni_Codigo').AsInteger);
        Entidade[p].UF:=FCidades.GetUF(QFornecedores.FieldByName('Forn_Muni_Codigo').AsInteger);
        Entidade[p].Fone:=Trans(QFornecedores.FieldByName('Forn_Fone').AsString,f_fone);
        Entidade[p].CEP:=Trans(QFornecedores.FieldByName('Forn_CEP').AsString,f_CEP);
        Entidade[p].InscrEst:=Trim(QFornecedores.FieldByName('Forn_InscricaoEstadual').AsString);
     end;
     QFornecedores.Close;QFornecedores.Free;
  end else if Categoria='C' then begin
     QClientes:=SqlToQuery('SELECT * FROM Clientes WHERE Clie_Codigo='+IntToStr(Codigo));
     QClientes.Name:='QClientes';
     if not QClientes.IsEmpty then begin
        Entidade[p].Razao:=Trim(QClientes.FieldByName('Clie_RazaoSocial').AsString);
        if Entidade[p].Razao='' then Entidade[p].Razao:=Trim(QClientes.FieldByName('Clie_Nome').AsString);
        Entidade[p].Nome:=Trim(QClientes.FieldByName('Clie_Nome').AsString);
        Entidade[p].Codigo:=IntToStr(Codigo);
        Entidade[p].CNPJCPF:=FormatoCGCCPF(QClientes.FieldByName('Clie_CNPJCPF').AsString);
        Entidade[p].Endereco:=Trim(QClientes.FieldByName('Clie_EndRes').AsString);
        Entidade[p].Bairro:=Trim(QClientes.FieldByName('Clie_BairroRes').AsString);
        Entidade[p].Cidade:=FCidades.GetNome(QClientes.FieldByName('Clie_Muni_Codigo_Res').AsInteger);
        Entidade[p].UF:=FCidades.GetUF(QClientes.FieldByName('Clie_Muni_Codigo_Res').AsInteger);
        Entidade[p].Fone:=Trans(QClientes.FieldByName('Clie_FoneRes').AsString,f_fone);
        Entidade[p].CEP:=Trans(QClientes.FieldByName('Clie_CEPRes').AsString,f_CEP);
        Entidade[p].InscrEst:=Trim(QClientes.FieldByName('Clie_RGIE').AsString);
        Entidade[p].RG:=Trim(QClientes.FieldByName('Clie_RGIE').AsString);
     end;
     QClientes.Close;QClientes.Free;
  end else if Categoria='I' then begin
     QFuncionarios:=SqlToQuery('SELECT * FROM Funcionarios WHERE Func_Codigo='+IntToStr(Codigo));
     QFuncionarios.Name:='QFuncionarios';
     if not QFuncionarios.IsEmpty then begin
        Entidade[p].Razao:=Trim(QFuncionarios.FieldByName('Func_Nome').AsString);
        Entidade[p].Nome:=Trim(QFuncionarios.FieldByName('Func_Nome').AsString);
        Entidade[p].Codigo:=IntToStr(Codigo);
        Entidade[p].CNPJCPF:=FormatoCGCCPF(QFuncionarios.FieldByName('Func_CPF').AsString);
        Entidade[p].Endereco:=Trim(QFuncionarios.FieldByName('Func_Endereco').AsString);
        Entidade[p].Bairro:=Trim(QFuncionarios.FieldByName('Func_Bairro').AsString);
        Entidade[p].Cidade:=FCidades.GetNome(QFuncionarios.FieldByName('Func_Muni_Codigo').AsInteger);
        Entidade[p].UF:=FCidades.GetUF(QFuncionarios.FieldByName('Func_Muni_Codigo').AsInteger);
        Entidade[p].Fone:=Trans(QFuncionarios.FieldByName('Func_TeleFone').AsString,f_fone);
        Entidade[p].CEP:=Trans(QFuncionarios.FieldByName('Func_CEP').AsString,f_CEP);
     end;
     QFuncionarios.Close;QFuncionarios.Free;
  end else if Categoria='U' then begin
     QUnidades:=SqlToQuery('SELECT * FROM Unidades WHERE Unid_Codigo='+StringToSql(StrZero(Codigo,3)));
     QUnidades.Name:='QUnidades';
     if not QUnidades.IsEmpty then begin
        Entidade[p].Razao:=Trim(QUnidades.FieldByName('Unid_RazaoSocial').AsString);
        if Entidade[p].Razao='' then Entidade[p].Razao:=Trim(QUnidades.FieldByName('Unid_Nome').AsString);
        Entidade[p].Nome:=Trim(QUnidades.FieldByName('Unid_Nome').AsString);
        Entidade[p].Codigo:=IntToStr(Codigo);
        Entidade[p].CNPJCPF:=FormatoCGCCPF(QUnidades.FieldByName('Unid_CNPJ').AsString);
        Entidade[p].Endereco:=Trim(QUnidades.FieldByName('Unid_Endereco').AsString);
        Entidade[p].Bairro:=Trim(QUnidades.FieldByName('Unid_Bairro').AsString);
        Entidade[p].Cidade:=FCidades.GetNome(QUnidades.FieldByName('Unid_Muni_Codigo').AsInteger);
        Entidade[p].UF:=FCidades.GetUF(QUnidades.FieldByName('Unid_Muni_Codigo').AsInteger);
        Entidade[p].Fone:=Trans(QUnidades.FieldByName('Unid_Fone').AsString,f_fone);
        Entidade[p].CEP:=Trans(QUnidades.FieldByName('Unid_CEP').AsString,f_CEP);
        Entidade[p].InscrEst:=Trim(QUnidades.FieldByName('Unid_InscricaoEstadual').AsString);
     end;
     QUnidades.Close;QUnidades.Free;
  end;
end;

//////////////////////// CHEQUES EMITIDOS ///////////////////////////////////////////////////

procedure TFImpressao.ConfChequesEmitidos(Codigo,Descricao:String);
//////////////////////////////////////////////////////////////////////////////
var Tit:String;
    LComandos:TStringList;
begin
  Tit:='Configuração Cheques / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
  LComandos.Add('Valor do cheque');
  LComandos.Add('Favorecido');
  LComandos.Add('Dia emissão');
  LComandos.Add('Mês emissão');
  LComandos.Add('Ano emissão (aaaa)');
  LComandos.Add('Ano emissão (aa)');
  LComandos.Add('Numero');
  LComandos.Add('ExtensoLinha1 {xxx}');
  LComandos.Add('ExtensoLinha2 {xxx}');
  LComandos.Add('Bom Para');
  LComandos.Add('Cidade');
  LComandos.Add('"String Constante"');
//  LComandos.Add('Chr(xx) = Retorna Codigos ASCII');
//  LComandos.Add('[Macro] = Executa Macro-Subtituição');
  FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  LComandos.Free;
end;

function RetornoChequesEmitidos(Comando,Especie:String):String;
///////////////////////////////////////////////////////////////////
var Dt:TDateTime;
    pp,tt:integer;
    s:String;
    Valor:Currency;

    function GetPosicaoSeparador(p:Integer;s:String):Integer;
    var i:integer;
    begin
      Result:=0;
      if Length(s)>(p+1) then begin
         for i:=p+1 downto 1 do begin
             if s[i]=#32 then begin
               Result:=i;
               break;
             end;
        end;
      end;
    end;

    function FinalizaResult(s:String;t:Integer):String;
    var n:integer;
    begin
      Result:=s;
      n:=(t-Length(s)) div 2;
      if Length(s)<t then Result:=s+' '+Replicate('x.',n);
    end;

begin
  Dt:=QMovBco.FieldByName('Cheq_predata').AsDateTime;
  Valor:=QMovBco.FieldByName('cheq_Valor').AsFloat;
  if Comando='Valor do cheque' then Result:=FConfDcto.TransformDcto(Valor,FConfDcto.FormatoValores);
  if Comando='Favorecido' then Result:=Trim(QMovBco.FieldByName('clie_nome').AsString);
  if Comando='Dia emissão' then Result:=StrZero(DateToDia(Dt),2);
  if Comando='Mês emissão' then Result:=UpperCaseBras(NomeMes(DateToMes(Dt),1));
  if Comando='Ano emissão (aaaa)' then Result:=IntToStr(DateToAno(Dt,True));
  if Comando='Ano emissão (aa)' then Result:=StrZero(DateToAno(Dt,False),2);
  if Comando='Numero' then Result:=QMovBco.FieldByName('cheq_cheque').AsString;
// 19.05.15
  if Comando='Cidade' then Result:=FCidades.GetNome(FUnidades.getcidacodigo(Global.CodigoUnidade));
  if LeftStr(Comando,13)='ExtensoLinha1' then begin
     s:=StrContida(Comando,'{','}');
     TamLinhaExtenso1:=Inteiro(s);
     if TamLinhaExtenso1=0 then TamLinhaExtenso1:=50;
     Result:=UpperCaseBras(Extenso(RoundValor(Valor)));
     pp:=GetPosicaoSeparador(TamLinhaExtenso1,Result);
     if pp>0 then begin
        if pp>Length(Result) then begin
           Result:=FinalizaResult(LeftStr(Result,pp),TamlinhaExtenso1);
        end else begin
           Result:=LeftStr(Result,pp);
        end;
     end else begin
        Result:=FinalizaResult(Result,TamLinhaExtenso1);
     end;
  end;
  if LeftStr(Comando,13)='ExtensoLinha2' then begin
     s:=StrContida(Comando,'{','}');
     tt:=Inteiro(s);
     if tt=0 then tt:=70;
     Result:=UpperCaseBras(Extenso(RoundValor(Valor)));
     pp:=GetPosicaoSeparador(TamLinhaExtenso1,Result);
     if (pp>0) and (Length(Result)>pp) then begin
        Result:=FinalStr(Result,pp+1);
        Result:=FinalizaResult(Result,tt);
     end else begin
//        Result:='';
// 18.05.15
        Result:='x.';
     end;
  end;
  if Comando='Bom Para' then if Dt>QMovBco.FieldByName('cheq_emissao').AsDateTime then Result:='Bom Para: '+DateToStr_(Dt);
end;

// 25.01.15
function TFImpressao.ImprimeCheques(xconta,cheqi,cheqf:integer;xtrans:string=''):Boolean;
////////////////////////////////////////////////////////////////////////////////////
var n,nn:Integer;
    FormaImpressao,Codigo,w,xtransb:String;
    TPlano,Qb:Tsqlquery;
    valortotalcheque:currency;
begin
  Result:=True;
  FCadImp.Open;
  try
    if xtrans='' then begin
//      w:='WHERE cast(cheq_cheque AS NUMERIC(15,2)) >= '+inttostr(cheqi)+' and cast(cheq_cheque AS NUMERIC(15,2)) <= '+inttostr(cheqf)+
      w:='WHERE cheq_cheque >= '+stringtosql(inttostr(cheqi))+' and cheq_cheque <= '+stringtosql(inttostr(cheqf))+
          ' and Cheq_emit_conta='+inttostr(xconta)+
          ' and Cheq_unid_codigo='+stringtosql(Global.CodigoUnidade)+
          ' and cheq_status=''N''';
      QMovBco:=SqlToQuery('SELECT cheques.*,clie_nome FROM cheques inner join clientes '+
              ' on ( clie_codigo=cheq_tipo_codigo ) ' +
              w+' ORDER BY cheq_Cheque');
    end else begin
      Qb:=sqltoquery('select pend_transbaixa from pendencias where '+
                     FGeral.GetIN('pend_transacao',xtrans,'C')+
                     ' and pend_status <>''C''' );
      xtransb:=Qb.fieldbyname('pend_transbaixa').asstring;
      w:='WHERE Cheq_emit_conta='+inttostr(xconta)+' and cheq_cmc7='+STringtosql(xtransb)+' and cheq_status=''N'''+
                   ' and Cheq_unid_codigo='+stringtosql(Global.CodigoUnidade) ;
      QMovBco:=SqlToQuery('SELECT cheques.*,clie_nome FROM cheques '+
               ' left join clientes on ( clie_codigo=cheq_tipo_codigo ) ' +
               w+' ORDER BY cheq_Cheque');
      qb.close;
    end;
    QMovBco.Name:='QMovBco';
    TPlano:=sqltoquery('select Plan_Impr_Cheque from plano where plan_conta='+inttostr(xconta));
    if not QMovBco.isEmpty then begin
       Codigo:=TPlano.FieldByName('Plan_Impr_Cheque').AsString;

       FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
//       if (FormaImpressao='2') or ((FormaImpressao='1') and (Confirma('Confirma a impressão do(s) cheque(s)'))) then begin
// 14.05.15
       if (FormaImpressao='2') or ((FormaImpressao='1')) then begin
          Result:=FConfDcto.GetConfiguracao(Codigo);
          if Result then begin
             Sistema.BeginProcess('imprimindo cheque(s)');
             nn:=0;
             while not QMovBco.Eof do begin
               Inc(nn);
               QMovBco.Next;
             end;
             QMovBco.First;
             n:=0;
             while not QMovBco.Eof do begin
               Inc(n);
               Result:=FConfDcto.Print(Codigo,RetornoChequesEmitidos,n=1,n=nn);
               if not Result then Break;
               QMovBco.Next;
             end;
             Sistema.endProcess('');
          end;
       end;
    end;
  except
  end;
  Sistema.EndProcess('');
  QMovBco.Close;QMovBco.Free;
end;




////////////////////////////////////////////////////////////////
procedure TFImpressao.ConfNotaSaida(Codigo, Descricao: String);
////////////////////////////////////////////////////////////////
var Tit:String;
    LComandos:TStringList;
begin

  Tit:='Configuração Nota Fiscal de Saida / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
  ListaComandos:=TStringList.Create;
  LComandos.Add('Codigo Tipo de Movimento');
  LComandos.Add('Tipo de Movimento');
  LComandos.Add('Natureza da Operação');
  LComandos.Add('CFOP-Codigo fiscal da operação');
  LComandos.Add('Inscrição Estadual do emitente');
  LComandos.Add('Inscrição Municipal do emitente');
  LComandos.Add('CNPJ do emitente');
// 20.02.20
  LComandos.Add('Razão Social emitente');
  LComandos.Add('Nome Fantasia emitente');

  LComandos.Add('Endereço emitente');
  LComandos.Add('Bairro emitente');
  LComandos.Add('CEP emitente');
  LComandos.Add('Municipio emitente');
  LComandos.Add('UF emitente');
  LComandos.Add('Telefone emitente');

  LComandos.Add('Codigo destinatário');
  LComandos.Add('Razão Social destinatário');
// 11.08.11
  LComandos.Add('Nome Fantasia destinatário');
  LComandos.Add('CNPJ/CPF destinatário');
  LComandos.Add('Data emissão');
  LComandos.Add('Endereço destinatário');
  LComandos.Add('Bairro destinatário');
  LComandos.Add('CEP destinatário');
  LComandos.Add('Data Saída');
  LComandos.Add('Municipio destinatário');
  LComandos.Add('Telefone destinatário');
  LComandos.Add('UF destinatário');
  LComandos.Add('Inscrição Estadual do destinatário');
// 21.03.11 - Bavi
  LComandos.Add('Codigo Portador');
  LComandos.Add('Descrição Portador');
/////////////////
  LComandos.Add('Hora Saída');
  LComandos.Add('Numero Nota');
  LComandos.Add('Numero Romaneio');
  LComandos.Add('Vencimento 1');
  LComandos.Add('Parcela 1');
  LComandos.Add('Vencimento 2');
  LComandos.Add('Parcela 2');
  LComandos.Add('Vencimento 3');
  LComandos.Add('Parcela 3');
  LComandos.Add('Vencimento 4');
  LComandos.Add('Parcela 4');
  LComandos.Add('Vencimento 5');
  LComandos.Add('Parcela 5');
  LComandos.Add('Vencimento 6');
  LComandos.Add('Parcela 6');
// ITENS DA NOTA
  LComandos.Add('Codigo produto');
  LComandos.Add('Descrição produto');
  LComandos.Add('Descrição produto (25)');
  LComandos.Add('ST-Situação tributária');
  LComandos.Add('Unidade produto');
  LComandos.Add('Quantidade');
  LComandos.Add('Valor unitário');
  LComandos.Add('Valor total');
  LComandos.Add('Alíquota ICMS');
// 12.02.09
  LComandos.Add('Alíquota ICMS sem decimais');
  LComandos.Add('Perc. desconto');
  LComandos.Add('Unitário bruto');
// 07.05.07
  LComandos.Add('Peças');
// 30.10.07
  LComandos.Add('Vlr IPI Produto');
// 13.04.11 - Jada Confeccoes
  LComandos.Add('Valor unitário Cond.1');
  LComandos.Add('Valor unitário Cond.2');
  LComandos.Add('Valor unitário Cond.3');

// 14.04.11
  LComandos.Add('Valor total dos produtos Cond.1');
  LComandos.Add('Valor total dos produtos Cond.2');
  LComandos.Add('Valor total dos produtos Cond.3');
////////
  LComandos.Add('Base cálculo do ICMS');
  LComandos.Add('Valor do ICMS');
  LComandos.Add('Base cálculo do ICMS substituição');
  LComandos.Add('Valor do ICMS substituição');
  LComandos.Add('Valor total dos produtos');
  LComandos.Add('Valor do frete');
  LComandos.Add('Valor do seguro');
  LComandos.Add('Valor Acréscimo/Desconto sobre Total da nota');
  LComandos.Add('Valor Total da nota');
// 18.09.09
  LComandos.Add('Valor total dos serviços');
  LComandos.Add('Valor do iss');
/////////////////////////
  LComandos.Add('Nome transportador');    // 28.07.11
  LComandos.Add('Razão Social transportador');
  LComandos.Add('Tipo de Frete ( CIF/FOB )');
  LComandos.Add('Placa do veículo');
  LComandos.Add('UF veículo');
  LComandos.Add('CNPJ/CPF transportador');
  LComandos.Add('Endereço transportador');
  LComandos.Add('Municipio transportador');
  LComandos.Add('UF transportador');
  LComandos.Add('Inscrição Estadual transportador');
  LComandos.Add('Quantidade volumes');
  LComandos.Add('Espécie volumes');
  LComandos.Add('Total Quantidade');
  LComandos.Add('de transporte');
  LComandos.Add('a transportar');
  LComandos.Add('Codigo usuário');
  LComandos.Add('Nome usuário');
  LComandos.Add('X - Referente entrada');
  LComandos.Add('X - Referente saida');
  LComandos.Add('Condição de Pagamento');
  LComandos.Add('Valor a Vista');
  LComandos.Add('Codigo representante');
  LComandos.Add('Nome representante');
// 08.07.05
  LComandos.Add('Notas devolução');
// 01.09.05
  LComandos.Add('Mensagem 1 (50 caracteres)');
  LComandos.Add('Mensagem 2 (50 caracteres)');
  LComandos.Add('Mensagem 3 (50 caracteres)');
  LComandos.Add('Mensagem 4 (50 caracteres)');
  LComandos.Add('Mensagem 5 (50 caracteres)');
// 13.11.07
  LComandos.Add('Mensagem 1 (90 caracteres)');
  LComandos.Add('Mensagem 2 (90 caracteres)');
  LComandos.Add('Mensagem 3 (90 caracteres)');
  LComandos.Add('Mensagem 4 (90 caracteres)');
  LComandos.Add('Mensagem 5 (90 caracteres)');
// 18.12.07
  LComandos.Add('Mensagem 6 (90 caracteres)');
  LComandos.Add('Mensagem 7 (90 caracteres)');
  LComandos.Add('Mensagem 8 (90 caracteres)');
  LComandos.Add('Mensagem 9 (90 caracteres)');
  LComandos.Add('Mensagem 10(90 caracteres)');
// 15.11.05
  LComandos.Add('Peso Líquido');
  LComandos.Add('Peso Bruto');
  LComandos.Add('Transação');
// 22.06.06
  LComandos.Add('Valor do ipi');
  LComandos.Add('Outras Despesas Acessórias');
// 31.07.06
  LComandos.Add('Codigo IPI');
  LComandos.Add('Classificação IPI(NCM)');
// 25.08.06
  LComandos.Add('Alíquota IPI');
// 19.02.09
  LComandos.Add('Alíquota IPI sem decimais');
//
  LComandos.Add('Lista Classificação IPI(NCM) 01 (40 caracteres)');
  LComandos.Add('Lista Classificação IPI(NCM) 02 (40 caracteres)');
// 09.08.06
  LComandos.Add('Base Icms 01');
  LComandos.Add('Base Icms 02');
  LComandos.Add('Base Icms 03');
  LComandos.Add('CFOP 01');
  LComandos.Add('CFOP 02');
  LComandos.Add('CFOP 03');
// 07.05.07
  LComandos.Add('Nota Produtor');
// 12.12.07
  LComandos.Add('Nota Produtor 2');
  LComandos.Add('Nota Produtor 3');
  LComandos.Add('Nota Produtor 4');
  LComandos.Add('Nota Produtor 5');
/////////
  LComandos.Add('INSS ( antigo funrural )');
  LComandos.Add('Cota Capital');
// 29.05.07
  LComandos.Add('Total Nota - (Cota Capital-INSS)');
// 03.01.08
  LComandos.Add('Porto Embarque');
  LComandos.Add('Porto Destino');
  LComandos.Add('Numero Container');
// 28.02.08
  LComandos.Add('Valor por extenso (linha1)');
  LComandos.Add('Valor por extenso (linha2)');
// 30.06.11
  LComandos.Add('Quantidade por extenso');
// 11.09.17 - Janina
  LComandos.Add('Mensagem Recebimento/Devolução para RC e DR');
  LComandos.Add('Data para Acerto( RC )');
// 07.11.18  - para usar na impressao do orcamento em word
  LComandos.Add('@Total Pedido');

//  LComandos.Add('Chr(xx) = Retorna Codigos ASCII');
//  LComandos.Add('[Macro] = Executa Macro-Subtituição');
// 06.07.17
  if codigo <> '999' then
    FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  ListaComandos.Assign(LComandos);
  LComandos.Free;
end;

/////////////////////////////////////////////////////////////////
function RetornoNotaSaida(Comando,Especie:String):String;
/////////////////////////////////////////////////////////////////
var Dtemissao:TDateTime;
    Valornota,TotalProdutos,Valormaisdesconto,QtdeProdutos,Baseicms,Valoricms,BaseicmsSubs,ValoricmsSubs,
    Valornotamenor:Currency;
    pesoliq,pesobru:Currency;
    esp,qtdvolumes,tam:integer;
    ext,espvolumes,extqtde:string;


    function GetX(cfop,es:string):string;
    /////////////////////////////////////
    begin
      if es='S' then begin
        if pos( copy(cfop,1,1),'5;6;7' )>0 then
          result:='X'
        else
          result:=' ';
      end else begin
        if pos( copy(cfop,1,1),'1;2;3' )>0 then
          result:='X'
        else
          result:=' ';
      end;
    end;


// 10.08.08
    function Tratavalor(valor:currency):string;
    ////////////////////////////////////////////
    begin
       result:='XX';
       if valor>0 then
         result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
       else begin           // 08.09.09
         if (Nropaginas=1) or (NroPaginas=NroPagina) then
           result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
         else
           result:='******,**';
       end;
    end;

// 19.02.09
    function TratavalorItens(valor:currency;mascara:string):string;
    ////////////////////////////////////////////////////////////////
    begin
       result:='XX';
       if valor>0 then
         result:=FConfDcto.TransformDcto(valor,mascara)
       else begin          // 08.09.09 - nos itens sempre imprimir 'zerado'
//         if (Nropaginas=1) or (NroPaginas=NroPagina) then
           result:=''
//         else
//           result:='******,**';
       end;
    end;

begin
///////////////////////////////////////////////////////////////////////////////

  Dtemissao:=QMestre.FieldByName('Moes_Dataemissao').AsDateTime;
  result:='';
  if (NroPagina=NroPaginas) and ( Nropaginas=1) then begin
    ValorNota:=QMestre.FieldByName('Moes_Vlrtotal').AsFloat;
    if (QMestre.FieldByName('Moes_Vlrtotal').AsFloat<>QMestre.FieldByName('Moes_Valortotal').AsFloat) and
       (QMestre.FieldByName('Moes_Valortotal').AsFloat>0) then
      ValorNOta:=QMestre.FieldByName('Moes_Valortotal').AsFloat; // 16.09.05
    TotalProdutos:=QMestre.FieldByName('moes_totprod').AsFloat;
    QtdeProdutos:=Tqtdetotal;
    Baseicms:=QMestre.FieldByName('Moes_Baseicms').AsFloat;
    Valoricms:=QMestre.FieldByName('Moes_Valoricms').AsFloat;
    BaseicmsSubs:=QMestre.FieldByName('moes_basesubstrib').AsFloat;
    ValoricmsSubs:=QMestre.FieldByName('moes_valoricmssutr').AsFloat;
    if Comando='de transporte' then result:='';
    if Comando='a transportar' then result:='';
// 26.06.08 - aqui em 08.09.09
    pesoliq:=QMestre.fieldbyname('moes_pesoliq').ascurrency;
    pesobru:=QMestre.fieldbyname('moes_pesobru').ascurrency;
    qtdvolumes:=QMestre.fieldbyname('Moes_qtdevolume').asinteger;
    espvolumes:=QMestre.fieldbyname('Moes_especievolume').asstring;
  end else if (NroPagina<NroPaginas) and ( Nropaginas>1) then begin
// 26.06.08 - aqui em 08.09.09
    pesoliq:=0;
    pesobru:=0;
    qtdvolumes:=0;
    espvolumes:='';
//////////
    ValorNota:=0;
    TotalProdutos:=0;
    QtdeProdutos:=0;
    Baseicms:=0;
    Valoricms:=0;
    BaseicmsSubs:=0;
    ValoricmsSubs:=0;
    if NroPagina=1 then begin
       if Comando='de transporte' then result:='';
    end else begin
      if Comando='de transporte' then result:='de transporte';
    end;
    if Comando='a transportar' then result:='a transportar';
  end else begin
// 26.06.08 - 08.09.09
    pesoliq:=QMestre.fieldbyname('moes_pesoliq').ascurrency;
    pesobru:=QMestre.fieldbyname('moes_pesobru').ascurrency;
    qtdvolumes:=QMestre.fieldbyname('Moes_qtdevolume').asinteger;
    espvolumes:=QMestre.fieldbyname('Moes_especievolume').asstring;
///////////////////////////
    ValorNota:=QMestre.FieldByName('Moes_Vlrtotal').AsFloat;
    TotalProdutos:=QMestre.FieldByName('moes_totprod').AsFloat;
    QtdeProdutos:=Tqtdetotal;
    Baseicms:=QMestre.FieldByName('Moes_Baseicms').AsFloat;
    Valoricms:=QMestre.FieldByName('Moes_Valoricms').AsFloat;
    BaseicmsSubs:=QMestre.FieldByName('moes_basesubstrib').AsFloat;
    ValoricmsSubs:=QMestre.FieldByName('moes_valoricmssutr').AsFloat;
    if Comando='de transporte' then result:='de transporte';
    if Comando='a transportar' then result:='';
//  if Comando='Favorecido' then Result:=Trim(QMovBco.FieldByName('Mbco_Favorecido').AsString);
//  if Comando='Bom Para' then Result:='Bom Para: '+DateToStr_(Dt);
  end;
// 29.05.07
  Valornotamenor:=ValorNota-QMestre.fieldbyname('Moes_cotacapital').ascurrency-QMestre.fieldbyname('Moes_funrural').ascurrency;

  if Comando='Codigo Tipo de Movimento' then Result:=QMestre.fieldbyname('Moes_tipomov').asstring
  else if Comando='Tipo de Movimento' then Result:=FGeral.GetTipoMovto(QMestre.fieldbyname('Moes_tipomov').asstring)
  else if Comando='Natureza da Operação' then Result:=FNatureza.GEtDescricao(QMestre.fieldbyname('Moes_Natf_Codigo').asstring)
  else if Comando='CFOP-Codigo fiscal da operação' then Result:=FGEral.FormataNatf(QMestre.fieldbyname('Moes_Natf_Codigo').asstring)
  else if Comando='Inscrição Estadual do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_inscricaoestadual').asstring
  else if Comando='CNPJ do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cnpj').asstring
  else if Comando='Endereço emitente' then Result:=Arq.TUnidades.fieldbyname('unid_endereco').asstring
  else if Comando='Bairro emitente' then Result:=Arq.TUnidades.fieldbyname('unid_bairro').asstring
  else if Comando='CEP emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cep').asstring
  else if Comando='Municipio emitente' then Result:=Arq.TUnidades.fieldbyname('unid_municipio').asstring
  else if Comando='UF emitente' then Result:=Arq.TUnidades.fieldbyname('unid_uf').asstring
  else if Comando='Telefone emitente' then Result:=FGeral.Formatatelefone(Arq.TUnidades.fieldbyname('unid_fone').asstring)
// 20.02.20
  else if Comando='Razão Social emitente' then result:=Arq.TUnidades.fieldbyname('unid_razaosocial').asstring
  else if Comando='Nome Fantasia emitente' then result:=Arq.TUnidades.fieldbyname('unid_nome').asstring

  else if Comando='Data emissão' then Result:=FGeral.formatadata(QMestre.fieldbyname('moes_dataemissao').Asdatetime)
//  else if Comando='Data Saída' then result:=FGeral.formatadata(QMestre.fieldbyname('Moes_DataMvto').asdatetime)
// 29.07.11 - romaneios capeg
  else if Comando='Data Saída' then result:=FGeral.formatadata(QMestre.fieldbyname('Moes_DataSaida').asdatetime)
// 18.09.09
  else if Comando='Inscrição Municipal do emitente' then Result:=Arq.TUnidades.fieldbyname('Unid_inscricaomunicipal').AsString;
//  if QMestre.fieldbyname('moes_tipomov').Asstring<>Global.coddevolucaocompra then begin
// 16.09.05
//  if ( pos(QMestre.fieldbyname('moes_tipomov').asstring,Global.coddevolucaocompra+';'+global.CodCompra+';'+Global.CodCompra100+';'+
//     Global.CodCompraX+';'+Global.CodConhecimento+';'+Global.CodCompraImobilizado+';'+Global.CodCompraMatConsumo+';'+
//     Global.coddevolucaocompraSemestoque+';'+Global.CodRetornoInd+';'+Global.CodRetornocomServicos+';'+
//     Global.CodDevolucaoInd+';'+Global.CodRemessaDemo+';'+Global.CodCompraSemfinan )=0 ) and (QMestre.fieldbyname('moes_tipocad').AsString<>'R') then begin
//// 14.12.07 - clolocado uso do campo tipocad...
  if QMestre.fieldbyname('moes_tipocad').AsString='C' then begin

    if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('clie_razaosocial').asstring
// 11.08.11
    else if Comando='Nome Fantasia destinatário' then Result:=QClientes.fieldbyname('clie_nome').asstring
    else if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('clie_cnpjcpf').asstring)
    else if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('clie_codigo').asstring
    else if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('clie_endres').asstring
    else if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('clie_bairrores').asstring
    else if Comando='CEP destinatário' then result:=QClientes.fieldbyname('clie_cepres').asstring
// 31.07.07 - retirado para nao ficar endereço de 'um lugar' e 'cidade outra'...
//    if QMestre.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor then begin
//      if Comando='Municipio destinatário' then result:=FCidades.GetNome(QMestre.fieldbyname('moes_cida_codigo').asinteger);
//      if Comando='UF destinatário' then result:=QMestre.fieldbyname('moes_estado').asstring;
//    end else begin
    else  if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('clie_cida_codigo_res').asinteger)
    else  if Comando='UF destinatário' then result:=QClientes.fieldbyname('clie_uf').asstring
//    end;
    else if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('clie_foneres').asstring)
    else if Comando='Inscrição Estadual do destinatário' then begin
      if QClientes.fieldbyname('clie_tipo').asstring='F' then
        Result:='Isento'
      else
        result:=QClientes.fieldbyname('clie_rgie').asstring;
    end;
// 18.05.06

  end else if QMestre.fieldbyname('moes_tipocad').AsString='R' then begin

    if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('repr_razaosocial').asstring
// 11.08.11
    else if Comando='Nome Fantasia destinatário' then Result:=QClientes.fieldbyname('repr_nome').asstring
    else if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('repr_cnpjcpf').asstring)
    else if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('repr_codigo').asstring
    else if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('repr_endereco').asstring
    else if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('repr_bairro').asstring
    else if Comando='CEP destinatário' then result:=QClientes.fieldbyname('repr_cep').asstring
    else if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('repr_cida_codigo').asinteger)
    else if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('repr_fone').asstring)
    else if Comando='UF destinatário' then result:=FCidades.GetUF(QClientes.fieldbyname('repr_cida_codigo').asinteger)
    else if Comando='Inscrição Estadual do destinatário' then  result:=QClientes.fieldbyname('repr_inscricaoestadual').asstring;
//////////////////////////
  end else begin
    if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('forn_razaosocial').asstring
// 11.08.11
    else if Comando='Nome Fantasia destinatário' then Result:=QClientes.fieldbyname('forn_nome').asstring
    else if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('forn_cnpjcpf').asstring)
    else if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('forn_codigo').asstring
    else if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('forn_endereco').asstring
    else if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('forn_bairro').asstring
    else if Comando='CEP destinatário' then result:=QClientes.fieldbyname('forn_cep').asstring
    else if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('forn_cida_codigo').asinteger)
    else if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('forn_fone').asstring)
    else if Comando='UF destinatário' then result:=QClientes.fieldbyname('forn_uf').asstring
    else if Comando='Inscrição Estadual do destinatário' then begin
      result:=QClientes.fieldbyname('forn_inscricaoestadual').asstring;
    end;
  end;
  if Comando='Hora Saída' then result:=Timetostr(Time);
//  if Comando='Numero Nota' then result:=QMestre.fieldbyname('moes_numerodoc').asstring;
// 11.11.05 - fical chupisco no porta nao gosta de nf com nros 7,8,9,,tem q ser 007, 008,,,bichona loka mesmo...
  if Comando='Numero Nota' then result:=strzero(QMestre.fieldbyname('moes_numerodoc').asinteger,7);
  if Comando='Numero Romaneio' then result:=QMestre.fieldbyname('moes_romaneio').asstring;

  if Comando='Vencimento 1' then result:=venc1;
  if Comando='Parcela 1' then result:=parc1 else
  if Comando='Vencimento 2' then result:=venc2 else
  if Comando='Parcela 2' then result:=parc2 else
  if Comando='Vencimento 3' then result:=venc3 else
  if Comando='Parcela 3' then result:=parc3 else
  if Comando='Vencimento 4' then result:=venc4 else
  if Comando='Parcela 4' then result:=parc4 else
  if Comando='Vencimento 5' then result:=venc5 else
  if Comando='Parcela 5' then result:=parc5 else
  if Comando='Vencimento 6' then result:=venc6 else
  if Comando='Parcela 6' then result:=parc6
// 24.05.10
  else if copy(Uppercase(comando),1,5)='LINHA' then begin
    if pos('[',comando)+1=pos(']',comando)-1 then
      tam:=1
    else
      tam:=strtoint( copy(comando,pos('[',comando)+1,pos(']',comando)-pos('[',comando)-1 ) );
    result:=replicate('-',tam);
  end;


// dados q "se repetem"
  esp:=Inteiro(especie)-1;
  if ( esp >= 0) and (Inteiro(especie)<=ListaDetalhe.Count) then begin
    PDetalhe:=ListaDetalhe[esp];
//  if ListaDetalhe.Count>0 then begin
//    FImpressao.EdPosicao.setvalue(esp);  // 03.09.04

    if Comando='Codigo produto' then result:=PDetalhe.Codigoproduto
    else if Comando='Descrição produto' then result:=strspace(PDetalhe.Descricaoproduto,50)
// 12.05.14
    else if Comando='Descrição produto (25)' then result:=copy(PDetalhe.Descricaoproduto,1,25)
    else if Comando='ST-Situação tributária' then result:=PDetalhe.Cst
    else if Comando='Unidade produto' then result:=PDetalhe.Unidade
//    else if Comando='Quantidade' then result:=FGeral.Formatavalor(PDetalhe.Quantidade,FConfDcto.FormatoQtdes)
    else if Comando='Quantidade' then result:=TratavalorItens(PDetalhe.Quantidade,FConfDcto.FormatoQtdes)
    else if Comando='Valor unitário' then result:=TratavalorItens(PDetalhe.Unitario,FConfDcto.FormatoValoresUn)
    else if Comando='Valor total' then result:=TratavalorItens(PDetalhe.Total,FConfDcto.FormatoValores)
    else if Comando='Alíquota ICMS' then result:=TratavalorItens(PDetalhe.icms,'#0.0')
// 12.02.09
    else if Comando='Alíquota ICMS sem decimais' then result:=TratavalorItens(PDetalhe.icms,'#0')
    else if Comando='Perc. desconto' then result:=FGeral.Formatavalor(PDetalhe.perdesco,FConfDcto.FormatoValores)
    else if Comando='Unitário bruto' then result:=TratavalorItens(PDetalhe.vendabru,FConfDcto.FormatoValores)
// 31.07.06
    else if Comando='Codigo IPI' then result:=inttostr(PDetalhe.Codigoipi)
    else if Comando='Classificação IPI(NCM)' then result:=PDetalhe.Ncmipi
// 25.08.06
    else if Comando='Alíquota IPI' then result:=TratavalorItens(PDetalhe.ipi,'#0.0')
// 19.02.09
    else if Comando='Alíquota IPI sem decimais' then result:=TratavalorItens(PDetalhe.ipi,'#0')
//  07.05.07
    else if Comando='Peças' then result:=FGeral.Formatavalor(PDetalhe.pecas,FConfDcto.FormatoQtdes)
//  31.10.07
    else if Comando='Vlr IPI Produto' then result:=TratavalorItens(PDetalhe.Total*(PDetalhe.ipi/100),FConfDcto.FormatoValores)
// 13.04.11
    else if Comando='Valor unitário Cond.1'  then result:=TratavalorItens(PDetalhe.Unitario1,FConfDcto.FormatoValoresUn)
    else if Comando='Valor unitário Cond.2'  then result:=TratavalorItens(PDetalhe.Unitario2,FConfDcto.FormatoValoresUn)
    else if Comando='Valor unitário Cond.3'  then result:=TratavalorItens(PDetalhe.Unitario3,FConfDcto.FormatoValoresUn)
// 30.06.11 - romaneio capeg - 28.07.11 ajuste
    else if Comando='Quantidade por extenso'  then begin
      extqtde:=Extenso(PDetalhe.Quantidade);
      extqtde:=copy(extqtde,1,pos('Rea',extqtde)-1);
      result:=UpperCaseBras( ExtQtde )
// 09.08.05 - ajuste em 26.11.10 para nao repetir a string nas linha q nao tem item
//    end else if pos('String',Comando)>0 then
// 30.01.13
    end else if Ansipos('String',Comando)>0 then
       result:=comando; // para imprimir strings colocadas no detalhe
  end;                                 ///       FConfDcto.TransformDcto(Valor,FConfDcto.FormatoValores);

//  if Comando='Base cálculo do ICMS' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_Baseicms').ascurrency,FConfDcto.FormatoValores);
//  if Comando='Base cálculo do ICMS' then result:=FConfDcto.TransformDcto(Baseicms,FConfDcto.FormatoValores);
  if Comando='Base cálculo do ICMS' then result:=Tratavalor(Baseicms);
//  if Comando='Valor do ICMS' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_Valoricms').ascurrency,FConfDcto.FormatoValores);
// 08.08.05
//  if Comando='Valor do ICMS' then result:=FConfDcto.TransformDcto(Valoricms,FConfDcto.FormatoValores);
  if Comando='Valor do ICMS' then result:=Tratavalor(Valoricms);

  ext:=UpperCaseBras( Extenso(valornota) );

  if Comando='Base cálculo do ICMS substituição' then result:=Tratavalor(BaseIcmsSubs)
  else if Comando='Valor do ICMS substituição' then result:=Tratavalor(ValorIcmsSubs)
//  if Comando='Valor total dos produtos' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_totprod').ascurrency,FConfDcto.FormatoValores);
  else if Comando='Valor do frete' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_frete').ascurrency,FConfDcto.FormatoValores)
  else if Comando='Valor do seguro' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_seguro').ascurrency,FConfDcto.FormatoValores)
// 14.04.11
  else if Comando='Valor total dos produtos Cond.1' then result:=Tratavalor(tvalortotal1)
  else if Comando='Valor total dos produtos Cond.2' then result:=Tratavalor(tvalortotal2)
  else if Comando='Valor total dos produtos Cond.3' then result:=Tratavalor(tvalortotal3);

  if Comando='Valor Total da nota' then begin
    if QMestre.fieldbyname('moes_tipomov').AsString=Global.CodDevolucaoCompraProdutor then
      result:=Tratavalor(valornotamenor)
    else
      result:=Tratavalor(valornota);
  end else if Comando='Valor total dos produtos' then
    result:=Tratavalor(totalprodutos);

  if Comando='Razão Social transportador' then begin
// 18.08.05
    if TTransp.fieldbyname('tran_razaosocial').asstring='' then
      result:=TTransp.fieldbyname('tran_nome').asstring
    else
      result:=TTransp.fieldbyname('tran_razaosocial').asstring;
  end else if Comando='Nome transportador' then    // 28.07.11
      result:=TTransp.fieldbyname('tran_nome').asstring;

  if Comando='Tipo de Frete ( CIF/FOB )' then result:=QMestre.fieldbyname('Moes_FreteCifFob').asstring;
  if Comando='Placa do veículo' then result:=TTransp.fieldbyname('tran_placa').asstring;
  if Comando='UF veículo' then result:=TTransp.fieldbyname('tran_ufplaca').asstring;
  if Comando='CNPJ/CPF transportador' then result:=TTransp.fieldbyname('tran_cnpjcpf').asstring;
  if Comando='Endereço transportador' then result:=TTransp.fieldbyname('tran_endereco').asstring;
  if Comando='Municipio transportador' then result:=FCidades.GetNome(TTransp.fieldbyname('tran_cida_codigo').asinteger);
  if Comando='UF transportador' then result:=FCidades.GetUF(TTransp.fieldbyname('tran_cida_codigo').asinteger);
  if Comando='Inscrição Estadual transportador' then result:=TTransp.fieldbyname('tran_inscricaoestadual').asstring;
  if Comando='Quantidade volumes' then result:=QMestre.fieldbyname('Moes_qtdevolume').asstring;
  if Comando='Espécie volumes' then result:=QMestre.fieldbyname('Moes_especievolume').asstring;
//  if Comando='Total Quantidade' then result:=FConfDcto.TransformDcto(PDetalhe.Tquantidade,FConfDcto.formatoQtdesInt);
// 07.04.05
  if Comando='Total Quantidade' then result:=FConfDcto.TransformDcto(Qtdeprodutos,FConfDcto.formatoQtdesInt);
  if Comando='Valor Acréscimo/Desconto sobre Total da nota' then begin
    if QMestre.fieldbyname('Moes_perdesco').ascurrency>0 then begin
//      result:='Desconto  : '+FConfDcto.TransformDcto( (totalprodutos)/(QMestre.fieldbyname('Moes_perdesco').ascurrency/100) ,FConfDcto.FormatoValores)
// 08.03.05
//      Valormaisdesconto:=(totalprodutos)/(1-(QMestre.fieldbyname('Moes_perdesco').ascurrency/100));
//  result:='Desconto  : '+FConfDcto.TransformDcto(Valormaisdesconto-totalprodutos ,FConfDcto.FormatoValores)
// 26.09.11
      if (totalprodutos-valornota>=0) then
        result:='Desconto  : '+FConfDcto.TransformDcto(totalprodutos-valornota ,FConfDcto.FormatoValores)
      else
        result:='';
    end else if QMestre.fieldbyname('Moes_peracres').ascurrency>0 then begin
      result:='Acréscimo : '+FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_peracres').ascurrency,FConfDcto.FormatoValores)
    end else
      result:='';
  end;
  if Comando='Codigo usuário' then result:=QMestre.fieldbyname('moes_usua_codigo').asstring
  else if Comando='Nome usuário' then result:=FUsuarios.GetNome(QMestre.fieldbyname('moes_usua_codigo').asinteger)
// 17.05.05
  else if Comando='X - Referente entrada' then result:=GetX(QMestre.fieldbyname('moes_natf_codigo').asstring,'E')
  else if Comando='X - Referente saida' then result:=GetX(QMestre.fieldbyname('moes_natf_codigo').asstring,'S')
// 21.03.11 - Bavi - 06.07.17 - caso for a vista qpendencia tem o movfin e nao o pendencias
  else if ( Comando='Codigo Portador' ) and (QMestre.FieldByName('moes_tipomov').AsString<>'RO') then begin

     result:=QPendencia.fieldbyname('pend_port_codigo').asstring
//     result:=QMestre.fieldbyname('moes_port_codigo').asstring

  end else if (Comando='Descrição Portador') and (QMestre.FieldByName('moes_tipomov').AsString<>'RO') then begin

    result:=FPortadores.GetDescricao(QPendencia.fieldbyname('pend_port_codigo').asstring)

////
  end else if Comando='Condição de Pagamento' then result:=FCondpagto.getreduzido(condicao)
  else if Comando='Valor a Vista' then result:=FConfDcto.TransformDcto(valoravista,FConfDcto.FormatoValores)
  else if Comando='Codigo representante' then result:=QMestre.fieldbyname('moes_repr_codigo').asstring
  else if Comando='Nome representante' then result:=FRepresentantes.GetDescricao(QMestre.fieldbyname('moes_repr_codigo').asinteger)
// 08.07.05
  else if Comando='Notas devolução' then result:=(QMestre.fieldbyname('moes_remessas').asstring)
// 01.09.05
  else if Comando='Mensagem 1 (50 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,001,50)
  else if Comando='Mensagem 2 (50 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,051,50)
  else if Comando='Mensagem 3 (50 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,101,50)
  else if Comando='Mensagem 4 (50 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,151,50)
  else if Comando='Mensagem 5 (50 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,201,50)
// 13.11.07
  else if Comando='Mensagem 1 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,001,90)
  else if Comando='Mensagem 2 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,091,90)
  else if Comando='Mensagem 3 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,181,90)
  else if Comando='Mensagem 4 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,271,90)
  else if Comando='Mensagem 5 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,361,90)
// 18.12.07
  else if Comando='Mensagem 6 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,451,90)
  else if Comando='Mensagem 7 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,541,90)
  else if Comando='Mensagem 8 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,631,90)
  else if Comando='Mensagem 9 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,721,90)
  else if Comando='Mensagem 10(90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,811,90)

// 15.11.05
  else if Comando='Peso Líquido' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('moes_pesoliq').ascurrency,FConfDcto.FormatoQtdesInt)
  else if Comando='Peso Bruto' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('moes_pesobru').ascurrency,FConfDcto.FormatoQtdesInt)
// 05.01.06
  else if Comando='Transação' then result:=QMestre.fieldbyname('moes_transacao').asstring
// 22.06.06
  else if Comando='Valor do ipi' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_valoripi').ascurrency,FConfDcto.FormatoValores)
  else if Comando='Outras Despesas Acessórias' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_outrasdesp').ascurrency,FConfDcto.FormatoValores);
// 31.07.06
  if Comando='Base Icms 01' then result:=FConfDcto.TransformDcto(baseicms01,FConfDcto.FormatoValores)
  else if Comando='Base Icms 02' then begin
    if trim(cfop02)<>'' then
      result:=FConfDcto.TransformDcto(baseicms02,FConfDcto.FormatoValores)
    else
      result:='';
  end else if Comando='Base Icms 03' then begin
    if trim(cfop03)<>'' then
      result:=FConfDcto.TransformDcto(baseicms03,FConfDcto.FormatoValores)
    else
      result:='';
  end else if Comando='Lista Classificação IPI(NCM) 01 (40 caracteres)' then result:=copy(Listaclassificaoipi,1,40)
  else if Comando='Lista Classificação IPI(NCM) 02 (40 caracteres)' then result:=copy(Listaclassificaoipi,41,40)
  else if Comando='CFOP 01' then result:=cfop01
  else if Comando='CFOP 02' then result:=cfop02
  else if Comando='CFOP 03' then result:=cfop03
// 07.05.07
  else if Comando='Nota Produtor' then result:=QMestre.fieldbyname('Moes_notapro').asstring
// 12.12.07
  else if Comando='Nota Produtor 2' then result:=QMestre.fieldbyname('Moes_notapro2').asstring
  else if Comando='Nota Produtor 3' then result:=QMestre.fieldbyname('Moes_notapro3').asstring
  else if Comando='Nota Produtor 4' then result:=QMestre.fieldbyname('Moes_notapro4').asstring
  else if Comando='Nota Produtor 5' then result:=QMestre.fieldbyname('Moes_notapro5').asstring
  else if Comando='INSS ( antigo funrural )' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_funrural').ascurrency,FConfDcto.FormatoValores)
  else if Comando='Cota Capital' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_cotacapital').ascurrency,FConfDcto.FormatoValores)
// 29.05.07
  else if Comando='Total Nota - (Cota Capital-INSS)' then result:=FConfDcto.TransformDcto(Valornotamenor,FConfDcto.FormatoValores)
// 03.01.08
  else if Comando='Porto Embarque' then begin
    if trim(QMestre.fieldbyname('Moes_embarque').asstring)<>'' then
      result:='Porto Embarque : '+QMestre.fieldbyname('Moes_embarque').asstring
    else
      result:='';
  end else if Comando='Porto Destino' then begin
     if trim(QMestre.fieldbyname('Moes_destino').asstring)<>'' then
       result:='Porto Destino : '+QMestre.fieldbyname('Moes_destino').asstring
     else
       result:='';
  end else if Comando='Numero Container' then  begin
    if trim(QMestre.fieldbyname('Moes_container').asstring)<>'' then
      result:='Nro. Container : '+QMestre.fieldbyname('Moes_container').asstring
    else
      result:='';
  end else if Comando='Valor por extenso (linha1)' then result:=copy(ext,1,55)
  else if Comando='Valor por extenso (linha2)' then result:=copy(ext,56,55)
// 18.09.09
  else if Comando='Valor total dos serviços' then result:=Tratavalor(QMestre.fieldbyname('moes_baseiss').ascurrency)
  else if Comando='Valor do iss' then result:=Tratavalor(QMestre.fieldbyname('moes_valoriss').ascurrency)
// 11.09.17
  else if Comando='Mensagem Recebimento/Devolução para RC e DR' then begin
     if QMestre.FieldByName('moes_tipomov').AsString=Global.CodRemessaConsig then
       result:='Declaro que recebi as mercadorias acima discriminadas :'
     else
      result:='Declaro que devolvi as mercadorias acima discriminadas : ';
  end else if Comando='Data para Acerto( RC )' then result:=Fgeral.FormataData( QMestre.FieldByName('moes_dataemissao').Asdatetime+30 );


end;

///////////////////////////////////////////////////////////////////////////////////////////
function TFImpressao.ImprimeNotaSaida(Nota: Integer; DataMvto: TDatetime ; Unidade : string ; tipomov:string='' ; Notaf:integer=0 ): Boolean;
///////////////////////////////////////////////////////////////////////////////////////////
var n,nn,p:Integer;
    FormaImpressao,Codigo,sqltipomovm,sqltipomovd,xcodigo,sqlemissao,DescricaoTamanho,
    DescricaoCor,Sqlpendencia,sqlnumeronota,sqlorder:String;
    valortotal,Tvalortotal,
    base,
    xcopias   :currency;
    QMovbase  :TSqlquery;
    ListaCfops,ListaBases:TStringlist;
    achou     :boolean;

// 06.07.17
    function PreencherDadosArquivo(const NomeArquivo: string): Boolean;
    /////////////////////////////////////////////////////////////////////
    var
      WordApp: Variant;
      Documento: Olevariant;
      xcomando:string;
      p : byte;

    begin
      if not FileExists( NomeArquivo ) then begin
        Avisoerro('Arquivo '+NomeArquivo+' não encontrado');
        exit;
      end;
      WordApp:= CreateOleObject('Word.Application');
      try

        WordApp.Visible := False;
        Documento := WordApp.Documents.Open(NomeArquivo);

        ConfNotaSaida('999','');

        for p:=0 to ListaComandos.count-1 do begin
          xcomando:=ListaComandos[p];
          if (xcomando='Descrição produto') or (xcomando='Quantidade') or (xcomando='Quantidade por extenso') or (xcomando='Unidade produto') then
            Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoNotaSaida(xcomando,'1'))
          else
            Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoNotaSaida(xcomando,''));
        end;
// 2 x devido a  ter mais de uma vez a mesma informacao

        for p:=0 to ListaComandos.count-1 do begin
          xcomando:=ListaComandos[p];
          if (xcomando='Descrição produto') or (xcomando='Quantidade') or (xcomando='Quantidade por extenso') or (xcomando='Unidade produto') then
            Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoNotaSaida(xcomando,'1'))
          else
            Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoNotaSaida(xcomando,''));
        end;

//        WordApp.Visible := True;

        Documento.SaveAs( ExtractFilePath( Application.ExeName ) + 'ROMA'+QMestre.fieldbyname('moes_numerodoc').asstring+'.docx');
        Documento.close;
        Documento := WordApp.Documents.Open( ExtractFilePath( Application.ExeName ) + 'ROMA'+QMestre.fieldbyname('moes_numerodoc').asstring+'.docx');

//        if pos('Indica',FConfDcto.Impressora) = 0 then begin
//          if Printer.Printers.IndexOf(FConfDcto.Impressora) <> -1 then
//             Printer.PrinterIndex := Printer.Printers.IndexOf(FConfDcto.Impressora);
//        end;
//
//          Printer.SetPrinter() FConfDcto.SetImpressora(FConfDcto.Impressora);

//        for p := 0 to FConfDcto.NumCopias-1 do Documento.PrintOut(false);
// desta forma a impressora se perde....
//        Documento.PrintOut(false);
        Documento.PrintOut(copies := FConfDcto.NumCopias );

        Documento.close;


//        Documento.open;
      finally
        WordApp.Quit;
        DeleteFile( ExtractFilePath( Application.ExeName ) + 'ROMA'+QMestre.fieldbyname('moes_numerodoc').asstring+'.docx');
      end;
    end;




    procedure Envia_Impressora;
    ///////////////////////////
    var count,countgeral,i,p:integer;
    begin
      NroPagina:=1;
      NroPaginas:=1;
{
      count:=1;countgeral:=0;
      for i:=0 to ListaDetalhe.count-1 do begin
        Inc(countgeral);
        if countgeral>FConfdcto.NumLgPg then begin   // ver quantas páginas tera a nota
          inc(count);
          countgeral:=0;
        end;
      end;
}

      if FConfdcto.NumLgPg>0 then begin
        if Listadetalhe.count mod FConfdcto.NumLgPg = 0 then
          count:= Listadetalhe.count div FConfdcto.NumLgPg
        else
          count:= Listadetalhe.count div FConfdcto.NumLgPg + 1;
        if count=0 then
          count:=1;
      end else
        count:=1;

      NroPaginas:=count;
      for i:=1 to count do begin
        NroPagina:=i;
// 18.04.11 - imprimir em mais de uma pagina em jato/laser
        if FConfDcto.TpImpressora='J' then
          FConfDcto.Print(Codigo, RetornoNotaSaida, i = 1, i = count,Visualiza,(i-1)*FConfdcto.NumLgPg)
        else if FConfDcto.TpImpressora='V' then begin
//          for p := 0 to FConfDcto.NumCopias-1 do PreencherDadosArquivo( ExtractFilePath( Application.ExeName )+'Romaneio.docx')
           PreencherDadosArquivo( ExtractFilePath( Application.ExeName )+'Romaneio.docx');
        end else
          FConfDcto.Print(Codigo, RetornoNotaSaida, i = 1, i = count,Visualiza);
// 08.09.09

        if count>1 then
          FConfDcto.GetConfiguracao(Codigo,(i*FConfdcto.NumLgPg));
// 24.10.06
//        if count>1 then
//          FConfDcto.GetConfiguracao(Codigo);

      end;
    end;

////////////////////////////////////////////////////////////
begin
//////////////////////////////////////////////////////////////

  Result:=True;
// 15.07.09
  Visualiza:=Global.Topicos[1006];
// 19.02.09
  TamanhoImpressaoDescricao:=FGeral.GetConfig1AsInteger('TAMDESCRINF');
  if not Arq.TUnidades.active then Arq.TUnidades.Open;
//  if not Arq.TClientes.active then Arq.TClientes.Open;
  if not Arq.TNatFisc.active then Arq.TNatFisc.open;

//  if Arq.TTransp.active then Arq.TTransp.close;
//  Arq.TTransp.open;
// 27.03.09
  if trim(tipomov)='' then begin
// 12.06.07 - colocado estes tipos 'padrao'
// 15.01.10 - colocado tipos do relat. faturamento a mais...
    sqltipomovm:=' and '+FGeral.GetIN('moes_tipomov',Global.CodVendaDireta+';'+Global.CodCompraProdutor+';'+Global.CodVendaSemMovEstoque+';'+Global.CodVendaBrinde+';'+Global.TiposRelVenda,'C') ;
    sqltipomovd:=' and '+FGeral.GetIN('move_tipomov',Global.CodVendaDireta+';'+Global.CodCompraProdutor+';'+Global.CodVendaSemMovEstoque+';'+Global.CodVendaBrinde+';'+Global.TiposRelVenda,'C') ;
// 20.08.10
    Sqlpendencia:=' and '+FGeral.GetIN('pend_tipomov',Global.CodVendaDireta+';'+Global.CodCompraProdutor+';'+Global.CodVendaSemMovEstoque+';'+Global.CodVendaBrinde+';'+Global.TiposRelVenda,'C') ;
  end else begin
    sqltipomovm:=' and moes_tipomov='+stringtosql(tipomov);
    sqltipomovd:=' and move_tipomov='+stringtosql(tipomov);
    if tipomov=global.CodRomaSerie4 then begin   // 06.08.05
      sqltipomovm:=' and moes_tipomov='+stringtosql(global.CodVendaSerie4);
      sqltipomovd:=' and move_tipomov='+stringtosql(global.CodVendaSerie4);
    end;
// 20.08.10
    Sqlpendencia:=' and '+FGeral.GetIN('pend_tipomov',tipomov,'C') ;
  end;
// 12.06.07
  if Datetoano(Datamvto,true)<1910 then
    sqlemissao:=''
  else
    sqlemissao:=' and moes_dataemissao='+Datetosql(Datamvto);
// 14.02.11 - Bavi - impressão de varias 'notas' de uma vez dentro de uma sequencia
  sqlnumeronota:=' where moes_numerodoc='+inttostr(Nota);
  if (notaf>0) and (notaf>nota) then
    sqlnumeronota:=' where moes_numerodoc>='+inttostr(Nota)+' and moes_numerodoc<='+inttostr(Notaf);

  try
    QMestre:=sqltoquery('select * from movesto '+
                     sqlnumeronota+
//                     ' where moes_numerodoc='+inttostr(Nota)+
//                     ' and moes_datamvto='+Datetosql(Datamvto)+
// 11.02.05 - reges viadinho fez nota com emissao retroativa e nao disse....horas em cima ate descobrir...
                     sqlemissao+
                     ' and moes_unid_codigo='''+unidade+''''+
                     sqltipomovm+
//                     ' and substr(moes_transacao,1,1)<>''I'''+  // 26.01.05
                     ' and '+Fgeral.getin('moes_status','N;D;E;F','C')+
                     ' order by moes_numerodoc' );
    QMestre.Name:='QMestre';
    if not QMestre.Eof then begin
      if QMestre.fieldbyname('moes_Datacont').asdatetime<=1 then
          Codigo:=FGeral.GetConfig1AsString('Imprnotasaidas')
      else
          Codigo:=FGeral.GetConfig1AsString('Imprnotasaida');
      if trim(codigo)='' then
          codigo:=xcodigo;
//      if (tipomov=Global.CodCompraProdutor) and (QMestre.fieldbyname('moes_Datacont').asdatetime>1) then
// 07.07.07
      if (QMestre.fieldbyname('moes_tipomov').asSTRING=Global.CodCompraProdutor) and (QMestre.fieldbyname('moes_Datacont').asdatetime>1) then
          Codigo:=FGeral.GetConfig1AsString('Imprnfprodutor');
// 22.07.09
      if (QMestre.fieldbyname('moes_tipomov').asSTRING=Global.CodPrestacaoServicos) and (QMestre.fieldbyname('moes_Datacont').asdatetime>1) then begin
        if pos('F',QMestre.fieldbyname('moes_serie').asSTRING)>0 then  // 18.09.09
          Codigo:=FGeral.GetConfig1AsString('Imprnotasaimo')
        else
          Codigo:=FGeral.GetConfig1AsString('Imprnotasaiser1');
      end;
// 30.06.11 - Romaneio Capeg
      if (QMestre.fieldbyname('moes_tipomov').asSTRING=Global.CodRomaneioRemessaaOrdem) and (QMestre.fieldbyname('moes_Datacont').asdatetime>1) then
        Codigo:=FGeral.GetConfig1AsString('Impromremaordem');
// 24.07.14 - Vivan devolucoes
      if (QMestre.fieldbyname('moes_tipomov').asSTRING=Global.CodDevolucaoVenda)  then
        Codigo:=FGeral.GetConfig1AsString('Imprdevvenda')
// 25.05.15 - Coorlaf Pitanga
      else if Global.Usuario.Outrosacessos[0341]  then
        Codigo:=FGeral.GetConfig1AsString('Imprnfmatricial');

{
///////////////////////////////////////////////
// 08.07.05
      if tipomov=Global.CodVendaSerie4 then
          Codigo:=FGeral.GetConfig1AsString('Imprnfserie4')
      else if tipomov=Global.CodRomaSerie4 then
          Codigo:=FGeral.GetConfig1AsString('Imprromaretorno')   // 06.08.05
      else if tipomov=Global.CodDevolucaoSerie5 then
          Codigo:=FGeral.GetConfig1AsString('Impromaserie5')
// 07.05.07
      else if tipomov=Global.CodCompraProdutor then
          Codigo:=FGeral.GetConfig1AsString('Imprnfprodutor');
// 28.08.06 - nf da exportacao com valores de ipi
      if unidade=Global.unidadeexportacao then begin
          if trim( FGeral.GetConfig1AsString('notasaida100') )<>'' then
            codigo:=FGeral.GetConfig1AsString('notasaida100');
      end;
///////////////////////////
}
      if trim(codigo)='' then begin
         Avisoerro('Falta configurar o codigo deste impresso na configuração geral');
         QMestre.close;
         Freeandnil(QMestre);
         exit;
      end;
// 02.07.07
//      if (tipomov=Global.CodCompraProdutor) and (QMestre.fieldbyname('moes_Datacont').asdatetime>1)
      if (QMestre.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor) and (QMestre.fieldbyname('moes_Datacont').asdatetime>1)
         and ( codigo<>FGeral.GetConfig1AsString('Imprnfprodutor') ) then begin
//         and ( trim(QMestre.fieldbyname('Moes_notapro').asstring)='' ) then
//          FGEral.Gravalog(99,'NF produtor '+QMestre.fieldbyname('moes_numerodoc').asstring+' impresso='+codigo,true,
//                          QMestre.fieldbyname('moes_transacao').asstring);
// mariane q ao reimprimir nf de produtor nao indicava o tipomov NP...
         Avisoerro('Codigo impresso de nota de produtor deveria ser '+FGeral.GetConfig1AsString('Imprnfprodutor')+' e esta '+codigo);
         QMestre.close;
         Freeandnil(QMestre);
         exit;
     end;
//////////

      Arq.TUnidades.locate('unid_codigo',unidade,[]);
      QPendencia:=sqltoquery('select * from pendencias where pend_transacao='+stringtosql(QMestre.fieldbyname('moes_Transacao').AsString)+
                            ' and pend_status<>''C'' and pend_unid_codigo='+stringtosql(unidade)+
                            sqlpendencia+
                            ' order by pend_datavcto');
      npar:=0;
      parc1:='';parc2:='';parc3:='';parc4:='';parc5:='';parc6:='';
      venc1:='';venc2:='';venc3:='';venc4:='';venc5:='';venc6:='';
      condicao:='001';
      valoravista:=QMestre.fieldbyname('moes_vlrtotal').ascurrency;
// 10.08.05
      Result:=FConfDcto.GetConfiguracao(Codigo);
// 15.06.20
      if ( Global.topicos[1428] ) and  (FConfDcto.TpImpressora<>'V' )   then begin

         xcopias := 1;
         FGEral.Getvalor(xcopias,'Cópias');
         FConfDcto.numcopias := trunc(xcopias);

      end;

      if not QPendencia.eof then begin
        valoravista:=QMestre.fieldbyname('moes_valoravista').ascurrency;
        npar:=1;
        condicao:=QPendencia.fieldbyname('pend_fpgt_codigo').asstring;
        while not QPendencia.eof do begin
          if npar=1 then begin
// 01.07.05
//             if (valoravista>0) and (valoravista<>QPendencia.fieldbyname('pend_valor').ascurrency) then begin
// 06.07.11 - para imprimir mesmo com valores iguais - Janina
             if (valoravista>0)  then begin
               venc1:='a Vista ';
               parc1:=formatfloat(FConfDcto.FormatoValores,valoravista);
               venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
//               parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,'###,###.##')
//               parc2:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('pend_valor').ascurrency);
             end else begin
               venc1:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
//             parc1:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
// 01.07.05 - algumas notas com parte a vista e a prazo não imprimiam o valor da primeira parcela somente o vencimento
               parc1:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('pend_valor').ascurrency);
             end;
          end else if npar=2 then begin
             if valoravista=0 then begin
               parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores);
               venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             end else begin
               parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores);
               venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             end;
          end else if npar=3 then begin
             if valoravista=0 then begin
               venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end else begin
               venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end;
          end else if npar=4 then begin
             if valoravista=0 then begin
               venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end else begin
               venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end;
          end else if npar=5 then begin
             venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=6 then begin
             venc6:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc6:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end;
          inc(npar);
          QPendencia.Next;
        end;
      end else begin   // se for toda a vista
        QPendencia.close;
        QPendencia:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(QMestre.fieldbyname('moes_Transacao').AsString)+
                               ' and movf_status<>''C''');
        if not QPendencia.eof then begin
           venc1:='a Vista ';
           parc1:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('movf_valorger').ascurrency);
        end;
      end;
// 14.12.07 - clolocado uso do campo tipocad...
//      if ( pos(QMestre.fieldbyname('moes_tipomov').asstring,Global.coddevolucaocompra+';'+global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+
//         Global.CodConhecimento+';'+Global.CodCompraImobilizado+';'+Global.CodCompraMatConsumo+';'+Global.coddevolucaocompraSemEstoque+';'+
//         Global.CodDevolucaoInd+';'+Global.CodRetornoInd+';'+Global.CodRetornocomServicos+';'+Global.CodRemessaDemo+';'+Global.CodCompraSemfinan)>0 )
//         and (QMestre.fieldbyname('moes_tipocad').AsString<>'R')  then
      if  (QMestre.fieldbyname('moes_tipocad').AsString='F')  then
        QClientes:=sqltoquery('select * from fornecedores where forn_codigo='+QMestre.fieldbyname('moes_tipo_codigo').asstring)
// 18.05.06
      else if QMestre.fieldbyname('moes_tipocad').asstring='R' then
        QClientes:=sqltoquery('select * from representantes where repr_codigo='+QMestre.fieldbyname('moes_tipo_codigo').asstring)
      else
        QClientes:=sqltoquery('select * from clientes where clie_codigo='+QMestre.fieldbyname('moes_tipo_codigo').asstring);
      if QClientes.Name<>'' then
        QClientes.Name:='QClientes';
///////////      Arq.TTransp.First;   // 10.08.05

//      Arq.TTransp.Locate('tran_codigo',QMestre.fieldbyname('moes_tran_codigo').asstring,[]);
// 27.03.09 - retirado daqui em 31.07.11
//      TTransp:=sqltoquery('select * from transportadores where tran_codigo='+stringtosql(QMestre.fieldbyname('moes_tran_codigo').asstring));
      ListaNcm:=TStringlist.create;
// 08.08.06
      Baseicms01:=0;baseicms02:=0;baseicms03:=0;
      QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(QMestre.fieldbyname('moes_Transacao').AsString)+
                           ' and movb_status<>''C''');
      ListaCfops:=TStringlist.create;
      ListaBases:=TStringlist.create;
      cfop01:='';cfop02:='';cfop03:='';
      while not Qmovbase.eof do begin
        if trim(QMovbase.fieldbyname('movb_natf_codigo').asstring)<>'' then begin
           if ListaCfops.indexof(QMovbase.fieldbyname('movb_natf_codigo').asstring)=-1 then begin
             Listacfops.add(QMovbase.fieldbyname('movb_natf_codigo').asstring);
             ListaBases.add(QMovbase.fieldbyname('movb_basecalculo').asstring)
           end else begin
             base:=strtofloat( LIstabases[ListaCfops.indexof(QMovbase.fieldbyname('movb_natf_codigo').asstring)] )
                   +QMovbase.fieldbyname('movb_basecalculo').ascurrency ;
             LIstabases[ListaCfops.indexof(QMovbase.fieldbyname('movb_natf_codigo').asstring)]:=floattostr(base);
           end;
        end;
        QMovbase.next;
      end;
      FGeral.Fechaquery(QMovbase);
      for p:=0 to ListaCfops.count-1 do begin
        if p=0 then begin
          baseicms01:=strtofloat(ListaBases[p]);
          cfop01:=Listacfops[p];
        end else if p=1 then begin
          baseicms02:=strtofloat(ListaBases[p]);
          cfop02:=Listacfops[p];
        end else if p=2 then begin
          baseicms03:=strtofloat(ListaBases[p]);
          cfop03:=Listacfops[p];
        end;
      end;
      FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
//       if (FormaImpressao='2') or ((FormaImpressao='1') and (Confirma('Confirma a impressão ?'))) then begin
// 05.02.15 - coorlaf santa maria
       if (FormaImpressao='2') or (FormaImpressao='1')  then begin
//          Result:=FConfDcto.GetConfiguracao(Codigo);
          if Result then begin
             Sistema.BeginProcess('imprimindo nota fiscal');
             nn:=0;
             QMestre.First;
             while not QMestre.Eof do begin
               Inc(nn);
               QMestre.Next;
             end;
             QMestre.First;
             n:=0;
             while not QMestre.Eof do begin
// 28.10.11 - Bavi - imprime varias com uma 'grande' as seguinte nao imprime itens
               if (notaf>0) and (notaf>nota)  and (nota>0) then begin
//                 FConfDcto.GetConfiguracao(Codigo,0,0);
// 21.01.15
                 FConfDcto.GetConfiguracao(Codigo);
               end;
////////////////////
               Inc(n);
// detalhes q se repetem
// 17.01.12 - Bavi
               sqlorder:=' order by move_aliicms,move_esto_codigo';
               if (QMestre.fieldbyname('moes_Datacont').asdatetime<=1) and
                  (Global.topicos[1353]) then
                 sqlorder:=' order by esto_grup_codigo,esto_descricao';
               QDetalhe:=sqltoquery('select * from movestoque '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo)'+
                     ' left join codigosipi on (cipi_codigo=esto_cipi_codigo)'+
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' left join cores on (core_codigo=move_core_codigo)'+
                     ' where move_transacao='''+QMestre.fieldbyname('moes_transacao').asstring+''''+
                     ' and '+FGeral.GetIN('move_status','N;D;E;F','C')+
                     sqltipomovd+
                     ' and move_numerodoc='+QMestre.fieldbyname('moes_numerodoc').asstring+
                     sqlorder );
               ListaDetalhe := TList.Create;valortotal:=0;TValortotal:=0;TQtdetotal:=0;
               if Qdetalhe.eof then  // 01.07.05
                 Avisoerro('Iten(s) não encontrados ou não cadastrados no estoque');
               while not QDetalhe.Eof do begin
// 16.08.06 - para 'condensar' cores e tamanhos somente na impressao
                 achou:=false;
// 12.11.07 - por enquanto retirado para nao condensar mais...futuramente criar configuração geral..
//                 for p:=0 to ListaDetalhe.count-1 do begin
//                   PDetalhe:=ListaDetalhe[p];
//                   if (PDetalhe.Codigoproduto=Qdetalhe.fieldbyname('Move_esto_codigo').AsString) then begin
///                      (PDetalhe.CodigoTamanho=Qdetalhe.fieldbyname('Move_tama_codigo').AsInteger) and
///                      (PDetalhe.CodigoCor=Qdetalhe.fieldbyname('Move_core_codigo').AsInteger)  then begin
//                      achou:=true;
//                      break;
//                   end;
//                 end;
                 if not achou then begin
                   New(PDetalhe);
                   PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('Move_esto_codigo').AsString;
// 19.02.09
                   if Global.Topicos[1208] then
                     PDetalhe.Descricaoproduto:=Qdetalhe.fieldbyname('esto_descricao').Asstring
                   else
                     PDetalhe.Descricaoproduto:=copy(Qdetalhe.fieldbyname('esto_descricao').Asstring,1,50);
// 19.02.09
                   if (length(trim(PDetalhe.Descricaoproduto))>TamanhoImpressaoDescricao) and (TamanhoImpressaoDescricao>0) then
                     PDetalhe.Descricaoproduto:=copy(Qdetalhe.fieldbyname('esto_descricao').Asstring,1,TamanhoImpressaoDescricao);
// 12.11.09
                   if Global.Topicos[1310] then begin
                     DescricaoTamanho:=Qdetalhe.fieldbyname('Tama_descricao').AsString;
                     DescricaoCor:=Qdetalhe.fieldbyname('Core_descricao').AsString;
                     PDetalhe.Descricaoproduto:=PDetalhe.Descricaoproduto+' '+Descricaocor+' '+DescricaoTamanho;
                   end;
                   PDetalhe.Cst:=Qdetalhe.fieldbyname('Move_cst').AsString;
                   PDetalhe.Unidade:=Qdetalhe.fieldbyname('Esto_unidade').Asstring;
// 12.05.14
                   PDetalhe.Quantidade:=Qdetalhe.fieldbyname('move_qtde').Ascurrency;
                   if Global.Topicos[1374] then begin
                     PDetalhe.Unitario:=0;
                     valortotal:=0;
                     PDetalhe.Total:=valortotal;
                   end else begin
                     PDetalhe.Unitario:=Qdetalhe.fieldbyname('move_venda').AsCurrency;
                     valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('move_venda').AsCurrency*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
                     PDetalhe.Total:=valortotal;
                   end;
                   PDetalhe.TQuantidade:=PDetalhe.TQuantidade+Qdetalhe.fieldbyname('move_qtde').AsCurrency;
                   PDetalhe.icms:=Qdetalhe.fieldbyname('move_aliicms').AsCurrency;
                   PDetalhe.perdesco:=Qdetalhe.fieldbyname('move_perdesco').AsCurrency;
                   PDetalhe.vendabru:=Qdetalhe.fieldbyname('move_vendabru').AsCurrency;
  // 31.07.06
                   PDetalhe.Codigoipi:=QDetalhe.fieldbyname('esto_cipi_codigo').asinteger;
                   PDetalhe.Ncmipi:=QDetalhe.fieldbyname('cipi_codfiscal').asstring;
// 25.08.06
                   PDetalhe.ipi:=Qdetalhe.fieldbyname('move_aliipi').AsCurrency;
// 07.05.07
                   PDetalhe.pecas:=Qdetalhe.fieldbyname('move_pecas').AsCurrency;
                   ListaDetalhe.Add(Pdetalhe);
                   Adicionalista(ListaNcm,QDetalhe.fieldbyname('esto_cipi_codigo').asstring+'-'+QDetalhe.fieldbyname('cipi_codfiscal').asstring);
// 19.02.09
                   if (length(trim(Qdetalhe.fieldbyname('esto_descricao').Asstring))>TamanhoImpressaoDescricao) and (TamanhoImpressaoDescricao>0)
                     then begin
                     descricaogrande:=Qdetalhe.fieldbyname('esto_descricao').Asstring;
                     New(PDetalhe);
                     PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('Move_esto_codigo').AsString;
                     PDetalhe.Descricaoproduto:=copy(Descricaogrande,TamanhoImpressaoDescricao+1,50);
                     if Global.Topicos[1310] then begin
                       DescricaoTamanho:=Qdetalhe.fieldbyname('Tama_descricao').AsString;
                       DescricaoCor:=Qdetalhe.fieldbyname('Core_descricao').AsString;
                       PDetalhe.Descricaoproduto:=PDetalhe.Descricaoproduto+' '+Descricaocor+' '+DescricaoTamanho;
                     end;
                     PDetalhe.Cst:='';
                     PDetalhe.Unidade:='';
                     PDetalhe.Quantidade:=0;
                     PDetalhe.TQuantidade:=0;
                     PDetalhe.Unitario:=0;
                     PDetalhe.Total:=0;
                     PDetalhe.icms:=0;
                     PDetalhe.perdesco:=0;
                     PDetalhe.vendabru:=0;
                     PDetalhe.Codigoipi:=0;
                     PDetalhe.Ncmipi:='';
                     PDetalhe.ipi:=0;
                     PDetalhe.pecas:=0;
                     ListaDetalhe.Add(Pdetalhe);
// 12.05.14 - Devereda  - Impressao de cupom nao fiscal
//////////////////////////////////////////////////////////
                   end else if Global.Topicos[1374] then begin
                     New(PDetalhe);
                     PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('Move_esto_codigo').AsString;
                     valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('move_venda').AsCurrency*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
//                     PDetalhe.Descricaoproduto:=rtrim(TRansform(Qdetalhe.fieldbyname('move_venda').AsCurrency,FConfDcto.FormatoValoresUn))+' '+
//                                                TRansform(valortotal,FConfDcto.FormatoValores);
//                     PDetalhe.Descricaoproduto:=(strspace(currtostr(Qdetalhe.fieldbyname('move_venda').AsCurrency),14))+' '+
//                                                (strspace(currtostr(valortotal),14));
                     PDetalhe.Descricaoproduto:=spacestr(
                                                (FGeral.Formatavalor(Qdetalhe.fieldbyname('move_venda').AsCurrency,FConfDcto.FormatoValoresUn))+' '+
                                                (FGeral.Formatavalor(valortotal,FConfDcto.FormatoValores)),
                                                25);
                     if Global.Topicos[1310] then begin
                       DescricaoTamanho:=Qdetalhe.fieldbyname('Tama_descricao').AsString;
                       DescricaoCor:=Qdetalhe.fieldbyname('Core_descricao').AsString;
//                       PDetalhe.Descricaoproduto:=PDetalhe.Descricaoproduto+' '+Descricaocor+' '+DescricaoTamanho;
                     end;
                     PDetalhe.Cst:='';
                     PDetalhe.Unidade:='';
                     PDetalhe.Quantidade:=0;
                     PDetalhe.TQuantidade:=PDetalhe.TQuantidade+Qdetalhe.fieldbyname('move_qtde').AsCurrency;
                     PDetalhe.Unitario:=0;
                     PDetalhe.Total:=0;
                     PDetalhe.icms:=Qdetalhe.fieldbyname('move_aliicms').AsCurrency;
                     PDetalhe.perdesco:=Qdetalhe.fieldbyname('move_perdesco').AsCurrency;
                     PDetalhe.vendabru:=Qdetalhe.fieldbyname('move_vendabru').AsCurrency;
                     PDetalhe.Codigoipi:=QDetalhe.fieldbyname('esto_cipi_codigo').asinteger;
                     PDetalhe.Ncmipi:=QDetalhe.fieldbyname('cipi_codfiscal').asstring;
                     PDetalhe.ipi:=Qdetalhe.fieldbyname('move_aliipi').AsCurrency;
                     PDetalhe.pecas:=Qdetalhe.fieldbyname('move_pecas').AsCurrency;
                     ListaDetalhe.Add(Pdetalhe);
                   end;

                 end else begin
                   PDetalhe.quantidade:=PDetalhe.quantidade+Qdetalhe.fieldbyname('move_qtde').AsCurrency;
                   valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('move_venda').AsCurrency*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
                   PDetalhe.Total:=PDetalhe.Total+valortotal;
                 end;
                 Tvalortotal:=Tvalortotal+valortotal;
                 TQtdetotal:=TQtdetotal+Qdetalhe.fieldbyname('move_qtde').Ascurrency;
                 QDetalhe.Next;
               end;
// 31.07.06
               Listaclassificaoipi:=GetLista(LIstaNcm,' ');
                                            // 15.08.05 - tentar imprimir devolução sem itens - credito de peaçs
               if (not QDetalhe.IsEmpty) or (tipomov=Global.CodDevolucaoVenda) then begin
// 14.02.11 - Bavi - varias notas de uma vez - aqui de novo...
/////////////////////////////////////////////////////////////////
                 if (notaf>0) and (notaf>nota) then begin
                    QClientes.Close;
                    if  (QMestre.fieldbyname('moes_tipocad').AsString='F')  then
                      QClientes:=sqltoquery('select * from fornecedores where forn_codigo='+QMestre.fieldbyname('moes_tipo_codigo').asstring)
                    else if QMestre.fieldbyname('moes_tipocad').asstring='R' then
                      QClientes:=sqltoquery('select * from representantes where repr_codigo='+QMestre.fieldbyname('moes_tipo_codigo').asstring)
                    else
                      QClientes:=sqltoquery('select * from clientes where clie_codigo='+QMestre.fieldbyname('moes_tipo_codigo').asstring);
                    QPendencia:=sqltoquery('select * from pendencias where pend_transacao='+stringtosql(QMestre.fieldbyname('moes_Transacao').AsString)+
                            ' and pend_status<>''C'' and pend_unid_codigo='+stringtosql(unidade)+
                            sqlpendencia+
                            ' order by pend_datavcto');
                    npar:=0;
                    parc1:='';parc2:='';parc3:='';parc4:='';parc5:='';parc6:='';
                    venc1:='';venc2:='';venc3:='';venc4:='';venc5:='';venc6:='';
                    condicao:='001';
                    valoravista:=QMestre.fieldbyname('moes_vlrtotal').ascurrency;
                    if not QPendencia.eof then begin
                      valoravista:=QMestre.fieldbyname('moes_valoravista').ascurrency;
                      npar:=1;
                      condicao:=QPendencia.fieldbyname('pend_fpgt_codigo').asstring;
                      while not QPendencia.eof do begin
                        if npar=1 then begin
                           if (valoravista>0) and (valoravista<>QPendencia.fieldbyname('pend_valor').ascurrency) then begin
                             venc1:='a Vista ';
                             parc1:=formatfloat(FConfDcto.FormatoValores,valoravista);
                             venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
                             parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
                           end else begin
                             venc1:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
                             parc1:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('pend_valor').ascurrency);
                           end;
                        end else if npar=2 then begin
                           if valoravista=0 then begin
                             parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores);
                             venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
                           end else begin
                             parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores);
                             venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
                           end;
                        end else if npar=3 then begin
                           if valoravista=0 then begin
                             venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
                             parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
                           end else begin
                             venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
                             parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
                           end;
                        end else if npar=4 then begin
                           if valoravista=0 then begin
                             venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
                             parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
                           end else begin
                             venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
                             parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
                           end;
                        end else if npar=5 then begin
                           venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
                           parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
                        end else if npar=6 then begin
                           venc6:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
                           parc6:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
                        end;
                        inc(npar);
                        QPendencia.Next;
                      end;
                    end else begin   // se for toda a vista
                      QPendencia.close;
                      QPendencia:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(QMestre.fieldbyname('moes_Transacao').AsString)+
                                             ' and movf_status<>''C''');
                      if not QPendencia.eof then begin
                         venc1:='a Vista ';
                         parc1:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('movf_valorger').ascurrency);
                      end;
                    end;

                 end;
/////////////////////////////////////////////////////
// aqui em 31.07.11 - romaneio capeg
                 TTransp:=sqltoquery('select * from transportadores where tran_codigo='+stringtosql(QMestre.fieldbyname('moes_tran_codigo').asstring));
                 Envia_Impressora;
               end;  // QDetalhe.isempty

               QDetalhe.Close;Listadetalhe.Free;
               QMestre.Next;
             end;
             Sistema.EndProcess('');

//             if (Global.CodigoUnidade<>Global.UnidadeMatriz) and ( pos('EPSON',uppercase(FConfDcto.ImprMat.NomeImpressora))=0 )
//               then
//               FGeral.Gravalog(99,'Impressora '+FConfDcto.ImprMat.NomeImpressora,true);
          end;

       end;

       Qclientes.close;
       QPendencia.close;
       Freeandnil(Qclientes);
       Freeandnil(QPendencia);
       if TTransp<>nil then begin  // 26.10.11
         TTransp.close;
         Freeandnil(TTransp);
       end;

    end else begin   // 29.04.05 - ijui 'começou a nao imprimir a nf de VC logo depois do acerto'

      Avisoerro('Nota fiscal '+inttostr(Nota)+' de '+Datetostr(Datamvto)+' não encontrada.  Tipo '+tipomov);
//      Avisoerro(QMestre.sql.text);
// 10.02.05 - com avisoerro nao 'cabe' a select
//      showmessage(QMestre.sql.text);
// 11.02.05 - mudado para data emissao na select

    end;

    QMestre.Close;Freeandnil(QMestre);
    if QDetalhe<>nil then
       Freeandnil(QDetalhe);
  except
  end;
  Sistema.EndProcess('');

end;

//////////////////////////// - impressao do romaneio de retorno
// 11.08.05
function RetornoRomaneioRetorno(Comando,Especie:String):String;
//////////////////////////////////////////////////////////////////
var Dtemissao:TDateTime;
    Valornota,TotalProdutos,Valormaisdesconto,QtdeProdutos,Baseicms,Valoricms,BaseicmsSubs,ValoricmsSubs:Currency;
    esp:integer;


    function GetX(cfop,es:string):string;
    begin
      if es='S' then begin
        if pos( copy(cfop,1,1),'5;6;7' )>0 then
          result:='X'
        else
          result:=' ';
      end else begin
        if pos( copy(cfop,1,1),'1;2;3' )>0 then
          result:='X'
        else
          result:=' ';
      end;
    end;

// 10.08.08
    function Tratavalor(valor:currency):string;
    begin
       result:='XX';
       if valor>0 then
         result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
       else begin
         if Nropaginas=1 then
           result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
         else
           result:='******,**';
       end;
    end;


begin

  Dtemissao:=QMestre.FieldByName('Moes_Dataemissao').AsDateTime;
  result:='';
  if (NroPagina=NroPaginas) and ( Nropaginas=1) then begin
    ValorNota:=QMestre.FieldByName('Moes_Vlrtotal').AsFloat;
    TotalProdutos:=QMestre.FieldByName('moes_totprod').AsFloat;
    QtdeProdutos:=Tqtdetotal;
    Baseicms:=QMestre.FieldByName('Moes_Baseicms').AsFloat;
    Valoricms:=QMestre.FieldByName('Moes_Valoricms').AsFloat;
    BaseicmsSubs:=QMestre.FieldByName('moes_basesubstrib').AsFloat;
    ValoricmsSubs:=QMestre.FieldByName('moes_valoricmssutr').AsFloat;
    if Comando='de transporte' then result:='';
    if Comando='a transportar' then result:='';
  end else if (NroPagina<NroPaginas) and ( Nropaginas>1) then begin
    ValorNota:=0;
    TotalProdutos:=0;
    QtdeProdutos:=0;
    Baseicms:=0;
    Valoricms:=0;
    BaseicmsSubs:=0;
    ValoricmsSubs:=0;
    if NroPagina=1 then begin
       if Comando='de transporte' then result:='';
    end else begin
      if Comando='de transporte' then result:='de transporte';
    end;
    if Comando='a transportar' then result:='a transportar';
  end else begin
    ValorNota:=QMestre.FieldByName('Moes_Vlrtotal').AsFloat;
    TotalProdutos:=QMestre.FieldByName('moes_totprod').AsFloat;
    QtdeProdutos:=Tqtdetotal;
    Baseicms:=QMestre.FieldByName('Moes_Baseicms').AsFloat;
    Valoricms:=QMestre.FieldByName('Moes_Valoricms').AsFloat;
    BaseicmsSubs:=QMestre.FieldByName('moes_basesubstrib').AsFloat;
    ValoricmsSubs:=QMestre.FieldByName('moes_valoricmssutr').AsFloat;
    if Comando='de transporte' then result:='de transporte';
    if Comando='a transportar' then result:='';
//  if Comando='Favorecido' then Result:=Trim(QMovBco.FieldByName('Mbco_Favorecido').AsString);
//  if Comando='Bom Para' then Result:='Bom Para: '+DateToStr_(Dt);
  end;
  if Comando='Codigo Tipo de Movimento' then Result:=QMestre.fieldbyname('Moes_tipomov').asstring;
  if Comando='Tipo de Movimento' then Result:=FGeral.GetTipoMovto(QMestre.fieldbyname('Moes_tipomov').asstring);
  if Comando='Natureza da Operação' then Result:=FNatureza.GEtDescricao(QMestre.fieldbyname('Moes_Natf_Codigo').asstring);
  if Comando='CFOP-Codigo fiscal da operação' then Result:=FGEral.FormataNatf(QMestre.fieldbyname('Moes_Natf_Codigo').asstring);
  if Comando='Inscrição Estadual do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_inscricaoestadual').asstring;
  if Comando='CNPJ do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cnpj').asstring;
  if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('clie_razaosocial').asstring;
  if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('clie_cnpjcpf').asstring);
  if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('clie_codigo').asstring;

  if Comando='Endereço emitente' then Result:=Arq.TUnidades.fieldbyname('unid_endereco').asstring;
  if Comando='Bairro emitente' then Result:=Arq.TUnidades.fieldbyname('unid_bairro').asstring;
  if Comando='CEP emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cep').asstring;
  if Comando='Municipio emitente' then Result:=Arq.TUnidades.fieldbyname('unid_municipio').asstring;
  if Comando='UF emitente' then Result:=Arq.TUnidades.fieldbyname('unid_uf').asstring;
  if Comando='Telefone emitente' then Result:=FGeral.Formatatelefone(Arq.TUnidades.fieldbyname('unid_fone').asstring);

  if Comando='Data emissão' then Result:=FGeral.formatadata(QMestre.fieldbyname('moes_dataemissao').Asdatetime);

  if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('clie_endres').asstring;
  if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('clie_bairrores').asstring;
  if Comando='CEP destinatário' then result:=QClientes.fieldbyname('clie_cepres').asstring;
  if Comando='Data Saída' then result:=FGeral.formatadata(QMestre.fieldbyname('Moes_DataMvto').asdatetime);
  if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('clie_cida_codigo_res').asinteger);
  if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('clie_foneres').asstring);
  if Comando='UF destinatário' then result:=QClientes.fieldbyname('clie_uf').asstring;
  if Comando='Inscrição Estadual do destinatário' then begin
    if QClientes.fieldbyname('clie_tipo').asstring='F' then
      Result:='Isento'
    else
      result:=QClientes.fieldbyname('clie_rgie').asstring;
  end;
  if Comando='Hora Saída' then result:=Timetostr(Time);
  if Comando='Numero Nota' then result:=QMestre.fieldbyname('moes_numerodoc').asstring;
  if Comando='Numero Romaneio' then result:=QMestre.fieldbyname('moes_romaneio').asstring;

  if Comando='Vencimento 1' then result:=venc1;
  if Comando='Parcela 1' then
     result:=parc1 else
  if Comando='Vencimento 2' then result:=venc2 else
  if Comando='Parcela 2' then result:=parc2 else
  if Comando='Vencimento 3' then result:=venc3 else
  if Comando='Parcela 3' then result:=parc3 else
  if Comando='Vencimento 4' then result:=venc4 else
  if Comando='Parcela 4' then result:=parc4 else
  if Comando='Vencimento 5' then result:=venc5 else
  if Comando='Parcela 5' then result:=parc5 else
  if Comando='Vencimento 6' then result:=venc6 else
  if Comando='Parcela 6' then result:=parc6;

// dados q "se repetem"
  esp:=Inteiro(especie)-1;
  if ( esp >= 0) and (Inteiro(especie)<=ListaDetalhe.Count) then begin
    PDetalhe:=ListaDetalhe[esp];

//  if ListaDetalhe.Count>0 then begin
//    FImpressao.EdPosicao.setvalue(esp);  // 03.09.04

    if Comando='Codigo produto' then result:=PDetalhe.Codigoproduto
    else if Comando='Descrição produto' then result:=PDetalhe.Descricaoproduto
    else if Comando='ST-Situação tributária' then result:=PDetalhe.Cst
    else if Comando='Unidade produto' then result:=PDetalhe.Unidade
    else if Comando='Quantidade' then result:=FGeral.Formatavalor(PDetalhe.Quantidade,FConfDcto.FormatoQtdes)
    else if Comando='Valor unitário' then result:=FGeral.Formatavalor(PDetalhe.Unitario,FConfDcto.FormatoValoresUn)
    else if Comando='Valor total' then result:=FGeral.Formatavalor(PDetalhe.Total,FConfDcto.FormatoValores)
    else if Comando='Alíquota ICMS' then result:=FGeral.Formatavalor(PDetalhe.icms,'#0.0')
    else if Comando='Perc. desconto' then result:=FGeral.Formatavalor(PDetalhe.perdesco,FConfDcto.FormatoValores)
    else if Comando='Unitário bruto' then result:=FGeral.Formatavalor(PDetalhe.vendabru,FConfDcto.FormatoValores)
// 09.08.05
    else result:=tiraaspas(comando); // para imprimir strings colocadas no detalhe
  end;                                 ///       FConfDcto.TransformDcto(Valor,FConfDcto.FormatoValores);

//  if Comando='Base cálculo do ICMS' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_Baseicms').ascurrency,FConfDcto.FormatoValores);
//  if Comando='Base cálculo do ICMS' then result:=FConfDcto.TransformDcto(Baseicms,FConfDcto.FormatoValores);
  if Comando='Base cálculo do ICMS' then result:=Tratavalor(Baseicms);
//  if Comando='Valor do ICMS' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_Valoricms').ascurrency,FConfDcto.FormatoValores);
// 08.08.05
//  if Comando='Valor do ICMS' then result:=FConfDcto.TransformDcto(Valoricms,FConfDcto.FormatoValores);
  if Comando='Valor do ICMS' then result:=Tratavalor(Valoricms);
  if Comando='Base cálculo do ICMS substituição' then result:=Tratavalor(BaseIcmsSubs);
  if Comando='Valor do ICMS substituição' then result:=Tratavalor(ValorIcmsSubs);
//  if Comando='Valor total dos produtos' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_totprod').ascurrency,FConfDcto.FormatoValores);
  if Comando='Valor do frete' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_frete').ascurrency,FConfDcto.FormatoValores);
  if Comando='Valor do seguro' then result:=FConfDcto.TransformDcto(0,FConfDcto.FormatoValores);

  if Comando='Valor Total da nota' then
    result:=Tratavalor(valornota);
  if Comando='Valor total dos produtos' then
    result:=Tratavalor(totalprodutos);

  if Comando='Razão Social transportador' then result:=Arq.TTransp.fieldbyname('tran_razaosocial').asstring;
  if Comando='Tipo de Frete ( CIF/FOB )' then result:=QMestre.fieldbyname('Moes_FreteCifFob').asstring;
  if Comando='Placa do veículo' then result:=Arq.TTransp.fieldbyname('tran_placa').asstring;
  if Comando='UF veículo' then result:=Arq.TTransp.fieldbyname('tran_ufplaca').asstring;
  if Comando='CNPJ/CPF transportador' then result:=Arq.TTransp.fieldbyname('tran_cnpjcpf').asstring;
  if Comando='Endereço transportador' then result:=Arq.TTransp.fieldbyname('tran_endereco').asstring;
  if Comando='Municipio transportador' then result:=FCidades.GetNome(Arq.TTransp.fieldbyname('tran_cida_codigo').asinteger);
  if Comando='UF transportador' then result:=FCidades.GetUF(Arq.TTransp.fieldbyname('tran_cida_codigo').asinteger);
  if Comando='Inscrição Estadual transportador' then result:=Arq.TTransp.fieldbyname('tran_inscricaoestadual').asstring;
  if Comando='Quantidade volumes' then result:=QMestre.fieldbyname('Moes_qtdevolume').asstring;
  if Comando='Espécie volumes' then result:=QMestre.fieldbyname('Moes_especievolume').asstring;
//  if Comando='Total Quantidade' then result:=FConfDcto.TransformDcto(PDetalhe.Tquantidade,FConfDcto.formatoQtdesInt);
// 07.04.05
    if Comando='Total Quantidade' then result:=FConfDcto.TransformDcto(Qtdeprodutos,FConfDcto.formatoQtdesInt);
  if Comando='Valor Acréscimo/Desconto sobre Total da nota' then begin
    if QMestre.fieldbyname('Moes_perdesco').ascurrency>0 then begin
//      result:='Desconto  : '+FConfDcto.TransformDcto( (totalprodutos)/(QMestre.fieldbyname('Moes_perdesco').ascurrency/100) ,FConfDcto.FormatoValores)
// 08.03.05
      Valormaisdesconto:=(totalprodutos)/(1-(QMestre.fieldbyname('Moes_perdesco').ascurrency/100));
      result:='Desconto  : '+FConfDcto.TransformDcto(Valormaisdesconto-totalprodutos ,FConfDcto.FormatoValores)
    end else if QMestre.fieldbyname('Moes_peracres').ascurrency>0 then begin
      result:='Acréscimo : '+FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_peracres').ascurrency,FConfDcto.FormatoValores)
    end else
      result:='';
  end;
  if Comando='Codigo usuário' then result:=QMestre.fieldbyname('moes_usua_codigo').asstring
  else if Comando='Nome usuário' then result:=FUsuarios.GetNome(QMestre.fieldbyname('moes_usua_codigo').asinteger)
  else if Comando='X - Referente entrada' then result:=GetX(QMestre.fieldbyname('moes_natf_codigo').asstring,'E')
  else if Comando='X - Referente saida' then result:=GetX(QMestre.fieldbyname('moes_natf_codigo').asstring,'S')
  else if Comando='Condição de Pagamento' then result:=FCondpagto.getreduzido(condicao)
  else if Comando='Valor a Vista' then result:=FConfDcto.TransformDcto(valoravista,FConfDcto.FormatoValores)
  else if Comando='Codigo representante' then result:=QMestre.fieldbyname('moes_repr_codigo').asstring
  else if Comando='Nome representante' then result:=FRepresentantes.GetDescricao(QMestre.fieldbyname('moes_repr_codigo').asinteger)
  else if Comando='Notas devolução' then result:=(QMestre.fieldbyname('moes_remessas').asstring);

end;


////////////////////////////////////////////////////
function TFImpressao.ImprimeRomaneioRetorno(Nota: Integer;
  DataMvto: TDatetime ; Unidade : string): Boolean;
var n,nn:Integer;
    FormaImpressao,Codigo:String;
    valortotal,Tvalortotal:currency;

    procedure Envia_Impressora;
    var count,countgeral,i:integer;
    begin
      NroPagina:=1;
      NroPaginas:=1;
      if FConfdcto.NumLgPg>0 then begin
        if Listadetalhe.count mod FConfdcto.NumLgPg = 0 then
          count:= Listadetalhe.count div FConfdcto.NumLgPg
        else
          count:= Listadetalhe.count div FConfdcto.NumLgPg + 1;
      end else
        count:=1;

      NroPaginas:=count;
      for i:=1 to count do begin
        NroPagina:=i;
        FConfDcto.Print(Codigo, RetornoNotaSaida, i = 1, i = count);
//        FConfDcto.GetConfiguracao(Codigo,(i*FConfdcto.NumLgPg+1));
//        if count>1 then
//          FConfDcto.GetConfiguracao(Codigo,(i*FConfdcto.NumLgPg));
// 24.10.06
        if count>1 then
          FConfDcto.GetConfiguracao(Codigo);

      end;
    end;


begin

  Result:=True;
  if not Arq.TUnidades.active then Arq.TUnidades.Open;
//  if not Arq.TClientes.active then Arq.TClientes.Open;
  if not Arq.TNatFisc.active then Arq.TNatFisc.open;
  if not Arq.TTransp.active then Arq.TTransp.open;
  Codigo:=FGeral.GetConfig1AsString('Imprromaretorno');
///  Codigo:=FGeral.GetConfig1AsString('Impromaserie5');
  if trim(codigo)='' then begin
     Avisoerro('Falta configurar o codigo deste impresso na configuração geral');
     exit
  end;
  try
// 11.08.05
    Result:=FConfDcto.GetConfiguracao(Codigo);
// 03.07.06
    if unidade<>Global.CodigoUnidade then begin
      Avisoerro('Romaneio não pode ser impresso em unidade sem regime especial');
      exit;
    end;
    QMestre:=sqltoquery('select * from movesto '+
                     ' where moes_numerodoc='+inttostr(Nota)+
// 09.08.05 - retornado ao nro. da nf pois sera o mesmo
// 04.07.05 - ver se precisa criar um indice pelo numero do romaneio
//                     ' where moes_romaneio='+inttostr(Nota)+
                     ' and moes_datamvto='+Datetosql(Datamvto)+
                     ' and moes_unid_codigo='''+unidade+''''+
//                     ' and moes_tipomov='+stringtosql(Global.CodRomaSerie4)+
// 04.07.05
                     ' and moes_tipomov='+stringtosql(Global.CodVendaSerie4)+
                     ' and moes_status=''N'''+
                     ' order by moes_numerodoc' );
    QMestre.Name:='QMestre';
    if not QMestre.Eof then begin
      Arq.TUnidades.locate('unid_codigo',unidade,[]);
      QPendencia:=sqltoquery('select * from pendencias where pend_transacao='+stringtosql(QMestre.fieldbyname('moes_Transacao').AsString)+
                            ' and pend_status<>''C'''+
                            ' order by pend_datavcto');
      npar:=0;
      parc1:='';parc2:='';parc3:='';parc4:='';parc5:='';parc6:='';
      venc1:='';venc2:='';venc3:='';venc4:='';venc5:='';venc6:='';
      if not QPendencia.eof then begin
        npar:=1;
        while not QPendencia.eof do begin
          if npar=1 then begin
             venc1:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc1:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=2 then begin
             venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=3 then begin
             venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=4 then begin
             venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=5 then begin
             venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=6 then begin
             venc6:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc6:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end;
          inc(npar);
          QPendencia.Next;
        end;
      end;
      QClientes:=sqltoquery('select * from clientes where clie_codigo='+QMestre.fieldbyname('moes_tipo_codigo').asstring);
      QClientes.Name:='QClientes';
      Arq.TTransp.Locate('tran_codigo',QMestre.fieldbyname('moes_tran_codigo').asstring,[]);
      FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
       if (FormaImpressao='2') or ((FormaImpressao='1') and (Confirma('Confirma a impressão ?'))) then begin
//          Result:=FConfDcto.GetConfiguracao(Codigo);
          if Result then begin
             Sistema.BeginProcess('imprimindo romaneio de retorno');
             nn:=0;
             QMestre.First;
             while not QMestre.Eof do begin
               Inc(nn);
               QMestre.Next;
             end;
             QMestre.First;
             n:=0;
             while not QMestre.Eof do begin
               Inc(n);
// detalhes q se repetem
               QDetalhe:=sqltoquery('select * from movestoque '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo)'+
                     ' where move_transacao='''+QMestre.fieldbyname('moes_transacao').asstring+''''+
                     ' and '+FGeral.GetIN('move_status','N','C')+
//                     ' and move_tipomov='+stringtosql(Global.CodRomaSerie4)+
// 09.08.05
                     ' and move_tipomov='+stringtosql(Global.CodVendaSerie4)+
                     ' and move_numerodoc='+QMestre.fieldbyname('moes_numerodoc').asstring+
                     ' order by move_aliicms,move_esto_codigo' );
//                     ' and detalhe.mfod_tipo<>''S'''+  // fgts nao...
               ListaDetalhe := TList.Create;valortotal:=0;Tvalortotal:=0;TQtdetotal:=0;
               while not QDetalhe.Eof do begin
                 New(PDetalhe);
//                 if ListaDetalhe.count=0 then
// 23.02.05
                 if Tvalortotal=0 then
                   PDetalhe.TQuantidade:=0;
                 PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('Move_esto_codigo').AsString;
                 PDetalhe.Descricaoproduto:=Qdetalhe.fieldbyname('esto_descricao').Asstring;
                 PDetalhe.Cst:=Qdetalhe.fieldbyname('Move_cst').AsString;
                 PDetalhe.Unidade:=Qdetalhe.fieldbyname('Esto_unidade').Asstring;
                 PDetalhe.Quantidade:=Qdetalhe.fieldbyname('move_qtde').Ascurrency;
                 PDetalhe.TQuantidade:=PDetalhe.TQuantidade+Qdetalhe.fieldbyname('move_qtde').AsCurrency;
// testando em 23.03.06 - reges+idete
//                 if Global.Usuario.codigo<>1 then begin
//                   PDetalhe.Unitario:=Qdetalhe.fieldbyname('move_venda').AsCurrency;
                   valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('move_venda').AsCurrency*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
// 01.02.06 - impressao do romaneio embutindo a subst. trib. no valor unitario somente na impressao
// 09.02.06 - deixado 'no jeito'
//                 end else begin
// 27.03.06 - colocado em atividade..
                  PDetalhe.Unitario:=FEstoque.GetPreco(Qdetalhe.fieldbyname('Move_esto_codigo').AsString,unidade,
                                      Qclientes.fieldbyname('clie_uf').asstring,Qdetalhe.fieldbyname('move_aliicms').AsCurrency,
                                      Qclientes.fieldbyname('clie_tipo').asstring,
                                      QDetalhe.fieldbyname('move_venda').AsCurrency);
                   valortotal:=FGeral.Arredonda(PDetalhe.Unitario*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
//                 end;

                 PDetalhe.Total:=valortotal;
                 PDetalhe.icms:=Qdetalhe.fieldbyname('move_aliicms').AsCurrency;
                 ListaDetalhe.Add(Pdetalhe);
                 Tvalortotal:=Tvalortotal+valortotal;
                 TQtdetotal:=TQtdetotal+Qdetalhe.fieldbyname('move_qtde').Ascurrency;
                 QDetalhe.Next;
               end;

               if not QDetalhe.IsEmpty then begin
//                 Result:=FConfDcto.Print(Codigo,RetornoRomaneioRetorno,n=1,n=nn);
//                 if not Result then Break;
                   Envia_Impressora;
               end;
               QDetalhe.Close;Listadetalhe.Free;
               QMestre.Next;
             end;
             Sistema.EndProcess('');
          end;
       end;
       Freeandnil(Qclientes);
       Freeandnil(QPendencia);
    end else
      Avisoerro('Nota fiscal não encontrada');
    QMestre.Close;Freeandnil(QMestre);
    if QDetalhe<>nil then begin
       QDetalhe.Close;
       Freeandnil(QDetalhe);
    end;
  except
  end;
  Sistema.EndProcess('');

end;


// 21.02.20
function TFImpressao.ProdutoGenerico(codigo: string): boolean;
///////////////////////////////////////////////////////////////
begin

   result := copy(codigo,1,4 ) = 'PROD' ;

end;

///////////////////////////
procedure TFImpressao.ConfNotaTransf(Codigo, Descricao: String);
var Tit:String;
    LComandos:TStringList;
begin
  Tit:='Configuração Nota Fiscal de Transferência / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
  LComandos.Add('Natureza da Operação');
  LComandos.Add('CFOP-Codigo fiscal da operação');
  LComandos.Add('Inscrição Estadual do emitente');
  LComandos.Add('CNPJ do emitente');
  LComandos.Add('Endereço emitente');
  LComandos.Add('Bairro emitente');
  LComandos.Add('CEP emitente');
  LComandos.Add('Municipio emitente');
  LComandos.Add('UF emitente');
  LComandos.Add('Telefone emitente');

  LComandos.Add('Codigo destinatário');
  LComandos.Add('Razão Social destinatário');
  LComandos.Add('CNPJ/CPF destinatário');
  LComandos.Add('Data emissão');
  LComandos.Add('Endereço destinatário');
  LComandos.Add('Bairro destinatário');
  LComandos.Add('CEP destinatário');
  LComandos.Add('Data Saída');
  LComandos.Add('Municipio destinatário');
  LComandos.Add('Telefone destinatário');
  LComandos.Add('UF destinatário');
  LComandos.Add('Inscrição Estadual do destinatário');
  LComandos.Add('Hora Saída');
  LComandos.Add('Numero Nota');
  LComandos.Add('Vencimento 1');
  LComandos.Add('Parcela 1');
  LComandos.Add('Vencimento 2');
  LComandos.Add('Parcela 2');
  LComandos.Add('Vencimento 3');
  LComandos.Add('Parcela 3');
  LComandos.Add('Vencimento 4');
  LComandos.Add('Parcela 4');
  LComandos.Add('Vencimento 5');
  LComandos.Add('Parcela 5');
  LComandos.Add('Vencimento 6');
  LComandos.Add('Parcela 6');
  LComandos.Add('Codigo produto');
  LComandos.Add('Descrição produto');
  LComandos.Add('ST-Situação tributária');
  LComandos.Add('Unidade produto');
// 28.01.05
  LComandos.Add('Quantidade');

  LComandos.Add('Valor unitário');
  LComandos.Add('Valor total');
  LComandos.Add('Alíquota ICMS');
  LComandos.Add('Base cálculo do ICMS');
  LComandos.Add('Valor do ICMS');
  LComandos.Add('Base cálculo do ICMS substituição');
  LComandos.Add('Valor do ICMS substituição');
  LComandos.Add('Valor total dos produtos');
  LComandos.Add('Valor do frete');
  LComandos.Add('Valor do seguro');
  LComandos.Add('Valor Total da nota');
  LComandos.Add('Razão Social transportador');
  LComandos.Add('Tipo de Frete ( CIF/FOB )');
  LComandos.Add('Placa do veículo');
  LComandos.Add('UF veículo');
  LComandos.Add('CNPJ/CPF transportador');
  LComandos.Add('Endereço transportador');
  LComandos.Add('Municipio transportador');
  LComandos.Add('UF transportador');
  LComandos.Add('Inscrição Estadual transportador');
  LComandos.Add('Quantidade volumes');
  LComandos.Add('Espécie volumes');
  LComandos.Add('Codigo usuário');
  LComandos.Add('Nome usuário');
  LComandos.Add('X - Referente entrada');
  LComandos.Add('X - Referente saida');
  LComandos.Add('Codigo representante');
  LComandos.Add('Nome representante');
  LComandos.Add('Total Quantidade');
// 02.09.05
  LComandos.Add('Mensagem 1 (40 caracteres)');
  LComandos.Add('Mensagem 2 (40 caracteres)');
  LComandos.Add('Mensagem 3 (40 caracteres)');
  LComandos.Add('Mensagem 4 (40 caracteres)');
  LComandos.Add('Mensagem 5 (40 caracteres)');
// 15.11.05
  LComandos.Add('Peso Líquido');
  LComandos.Add('Peso Bruto');
//  LComandos.Add('Chr(xx) = Retorna Codigos ASCII');
//  LComandos.Add('[Macro] = Executa Macro-Subtituição');
  FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  LComandos.Free;
end;

function RetornoNotaTransf(Comando,Especie:String):String;
////////////////////////////////////////////////////////////////
var Dtemissao:TDateTime;
    Valornota,TotalProdutos,QtdeProdutos,Baseicms,Valoricms:Currency;
    esp:integer;

    function GetX(cfop,es:string):string;
    begin
      if es='S' then begin
        if pos( copy(cfop,1,1),'5;6;7' )>0 then
          result:='X'
        else
          result:=' ';
      end else begin
        if pos( copy(cfop,1,1),'1;2;3' )>0 then
          result:='X'
        else
          result:=' ';
      end;

    end;

// 08.08.08
    function Tratavalor(valor:currency):string;
    begin
       result:='XX';
       if valor>0 then
         result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
       else begin
         if Nropaginas=1 then
           result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
         else
           result:='******,**';
       end;
    end;

begin

  Dtemissao:=QMestre.FieldByName('Moes_Dataemissao').AsDateTime;
//  ValorNota:=QMestre.FieldByName('Moes_Vlrtotal').AsFloat;
// 20.06.05
  if (NroPagina=NroPaginas) and ( Nropaginas=1) then begin
    ValorNota:=QMestre.FieldByName('Moes_Vlrtotal').AsFloat;
    TotalProdutos:=QMestre.FieldByName('moes_totprod').AsFloat;
    QtdeProdutos:=Tqtdetotal;
    Baseicms:=QMestre.FieldByName('Moes_Baseicms').AsFloat;
    Valoricms:=QMestre.FieldByName('Moes_Valoricms').AsFloat;
    if Comando='de transporte' then result:='';
    if Comando='a transportar' then result:='';
  end else if (NroPagina<NroPaginas) and ( Nropaginas>1) then begin
    ValorNota:=0;
    TotalProdutos:=0;
    QtdeProdutos:=0;
    Baseicms:=0;
    Valoricms:=0;
    if NroPagina=1 then begin
       if Comando='de transporte' then result:='';
    end else begin
      if Comando='de transporte' then result:='de transporte';
    end;
    if Comando='a transportar' then result:='a transportar';
  end else begin
    ValorNota:=QMestre.FieldByName('Moes_Vlrtotal').AsFloat;
    TotalProdutos:=QMestre.FieldByName('moes_totprod').AsFloat;
    QtdeProdutos:=Tqtdetotal;
    Baseicms:=QMestre.FieldByName('Moes_Baseicms').AsFloat;
    Valoricms:=QMestre.FieldByName('Moes_Valoricms').AsFloat;
    if Comando='de transporte' then result:='de transporte';
    if Comando='a transportar' then result:='';
//  if Comando='Favorecido' then Result:=Trim(QMovBco.FieldByName('Mbco_Favorecido').AsString);
//  if Comando='Bom Para' then Result:='Bom Para: '+DateToStr_(Dt);
  end;

//  if Comando='Favorecido' then Result:=Trim(QMovBco.FieldByName('Mbco_Favorecido').AsString);
//  if Comando='Bom Para' then Result:='Bom Para: '+DateToStr_(Dt);
  if Comando='Natureza da Operação' then Result:=FNatureza.GEtDescricao(QMestre.fieldbyname('Moes_Natf_Codigo').asstring);
  if Comando='CFOP-Codigo fiscal da operação' then Result:=FGEral.FormataNatf(QMestre.fieldbyname('Moes_Natf_Codigo').asstring);
  if Comando='Inscrição Estadual do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_inscricaoestadual').asstring;
  if Comando='CNPJ do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cnpj').asstring;

  if Comando='Endereço emitente' then Result:=Arq.TUnidades.fieldbyname('unid_endereco').asstring;
  if Comando='Bairro emitente' then Result:=Arq.TUnidades.fieldbyname('unid_bairro').asstring;
  if Comando='CEP emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cep').asstring;
  if Comando='Municipio emitente' then Result:=Arq.TUnidades.fieldbyname('unid_municipio').asstring;
  if Comando='UF emitente' then Result:=Arq.TUnidades.fieldbyname('unid_uf').asstring;
  if Comando='Telefone emitente' then Result:=FGeral.Formatatelefone(Arq.TUnidades.fieldbyname('unid_fone').asstring);

//  if Comando='Valor Total da nota' then
//    result:=FConfDcto.TransformDcto(valornota,FConfDcto.FormatoValores);
//  if Comando='Valor total dos produtos' then
//    result:=FConfDcto.TransformDcto(totalprodutos,FConfDcto.FormatoValores);


  if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('unid_codigo').asstring;
  if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('unid_razaosocial').asstring;
  if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('unid_cnpj').asstring);
  if Comando='Data emissão' then Result:=FGeral.formatadata(QMestre.fieldbyname('moes_dataemissao').Asdatetime);
  if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('unid_endereco').asstring;
  if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('unid_bairro').asstring;
  if Comando='CEP destinatário' then result:=QClientes.fieldbyname('unid_cep').asstring;
  if Comando='Data Saída' then result:=FGeral.formatadata(QMestre.fieldbyname('Moes_DataMvto').asdatetime);
  if Comando='Municipio destinatário' then result:=QClientes.fieldbyname('unid_municipio').asstring;
  if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('unid_fone').asstring);
  if Comando='UF destinatário' then result:=QClientes.fieldbyname('unid_uf').asstring;
  if Comando='Inscrição Estadual do destinatário' then result:=QClientes.fieldbyname('unid_inscricaoestadual').asstring;
  if Comando='Hora Saída' then result:=Timetostr(Time);
  if Comando='Numero Nota' then result:=QMestre.fieldbyname('moes_numerodoc').asstring;

  if Comando='Vencimento 1' then result:=venc1;
  if Comando='Parcela 1' then result:=parc1;
  if Comando='Vencimento 2' then result:=venc2;
  if Comando='Parcela 2' then result:=parc2;
  if Comando='Vencimento 3' then result:=venc3;
  if Comando='Parcela 3' then result:=parc3;
  if Comando='Vencimento 4' then result:=venc4;
  if Comando='Parcela 4' then result:=parc4;
  if Comando='Vencimento 5' then result:=venc5;
  if Comando='Parcela 5' then result:=parc5;
  if Comando='Vencimento 6' then result:=venc6;
  if Comando='Parcela 6' then result:=parc6;

// dados q "se repetem"
  esp:=Inteiro(especie)-1;
  if ( esp >= 0) and (Inteiro(especie)<=ListaDetalhe.Count) then begin
    PDetalhe:=ListaDetalhe[esp];
    if Comando='Codigo produto' then result:=PDetalhe.Codigoproduto;
    if Comando='Descrição produto' then result:=PDetalhe.Descricaoproduto;
    if Comando='ST-Situação tributária' then result:=PDetalhe.Cst;
    if Comando='Unidade produto' then result:=PDetalhe.Unidade;

    if Comando='Quantidade' then result:=FGeral.Formatavalor(PDetalhe.Quantidade,FConfDcto.FormatoQtdes);

    if Comando='Valor unitário' then result:=FGeral.Formatavalor(PDetalhe.Unitario,FConfDcto.FormatoValoresUn);
    if Comando='Valor total' then result:=FGeral.Formatavalor(PDetalhe.Total,FConfDcto.FormatoValores);
    if Comando='Alíquota ICMS' then result:=FGeral.Formatavalor(PDetalhe.icms,'#0.0');
  end;                                 ///       FConfDcto.TransformDcto(Valor,FConfDcto.FormatoValores);
//  if Comando='Base cálculo do ICMS' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_Baseicms').ascurrency,FConfDcto.FormatoValores);
//  if Comando='Valor do ICMS' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_Valoricms').ascurrency,FConfDcto.FormatoValores);
  if Comando='Base cálculo do ICMS substituição' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_BaseSubstrib').ascurrency,FConfDcto.FormatoValores);
  if Comando='Valor do ICMS substituição' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_Valoricmssutr').ascurrency,FConfDcto.FormatoValores);
  if Comando='Valor do frete' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_frete').ascurrency,FConfDcto.FormatoValores);
  if Comando='Valor do seguro' then result:=FConfDcto.TransformDcto(0,FConfDcto.FormatoValores);

//  if Comando='Valor Total da nota' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_vlrtotal').ascurrency,FConfDcto.FormatoValores);
//  if Comando='Valor total dos produtos' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_totprod').ascurrency,FConfDcto.FormatoValores);

  if Comando='Valor Total da nota' then
    result:=tratavalor(valornota);
//    result:=FConfDcto.TransformDcto(valornota,FConfDcto.FormatoValores);
  if Comando='Valor total dos produtos' then
    result:=tratavalor(totalprodutos);
//    result:=FConfDcto.TransformDcto(totalprodutos,FConfDcto.FormatoValores);
// 08.08.08
  if Comando='Base cálculo do ICMS' then begin
     if baseicms>0 then
       result:=FConfDcto.TransformDcto(Baseicms,FConfDcto.FormatoValores)
     else begin
       if Nropaginas=1 then
         result:=FConfDcto.TransformDcto(Baseicms,FConfDcto.FormatoValores)
       else
         result:='******,**';
     end;
  end;
  if Comando='Valor do ICMS' then begin
    result:=tratavalor(Valoricms);
  end;
  if Comando='Razão Social transportador' then result:=Arq.TTransp.fieldbyname('tran_razaosocial').asstring;
  if Comando='Tipo de Frete ( CIF/FOB )' then result:=QMestre.fieldbyname('Moes_FreteCifFob').asstring;
  if Comando='Placa do veículo' then result:=Arq.TTransp.fieldbyname('tran_placa').asstring;
  if Comando='UF veículo' then result:=Arq.TTransp.fieldbyname('tran_ufplaca').asstring;
  if Comando='CNPJ/CPF transportador' then result:=Arq.TTransp.fieldbyname('tran_cnpjcpf').asstring;
  if Comando='Endereço transportador' then result:=Arq.TTransp.fieldbyname('tran_endereco').asstring;
  if Comando='Municipio transportador' then result:=FCidades.GetNome(Arq.TTransp.fieldbyname('tran_cida_codigo').asinteger);
  if Comando='UF transportador' then result:=FCidades.GetUF(Arq.TTransp.fieldbyname('tran_cida_codigo').asinteger);
  if Comando='Inscrição Estadual transportador' then result:=Arq.TTransp.fieldbyname('tran_inscricaoestadual').asstring;
  if Comando='Quantidade volumes' then result:=QMestre.fieldbyname('Moes_qtdevolume').asstring;
  if Comando='Espécie volumes' then result:=QMestre.fieldbyname('Moes_especievolume').asstring;
  if Comando='Codigo usuário' then result:=QMestre.fieldbyname('moes_usua_codigo').asstring;
  if Comando='Nome usuário' then result:=FUsuarios.GetNome(QMestre.fieldbyname('moes_usua_codigo').asinteger);
// 24.05.05
  if Comando='X - Referente entrada' then result:=GetX(QMestre.fieldbyname('moes_natf_codigo').asstring,'E');
  if Comando='X - Referente saida' then result:=GetX(QMestre.fieldbyname('moes_natf_codigo').asstring,'S');
  if Comando='Codigo representante' then result:=QMestre.fieldbyname('moes_repr_codigo').asstring;
  if Comando='Nome representante' then result:=FRepresentantes.GetDescricao(QMestre.fieldbyname('moes_repr_codigo').asinteger);
// 20.06.05  
  if Comando='Total Quantidade' then
    result:=FConfDcto.TransformDcto(Qtdeprodutos,FConfDcto.formatoQtdesInt);
// 02.09.05
  if Comando='Mensagem 1 (40 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,001,40);
  if Comando='Mensagem 2 (40 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,041,40);
  if Comando='Mensagem 3 (40 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,081,40);
  if Comando='Mensagem 4 (40 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,121,40);
  if Comando='Mensagem 5 (40 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,161,40);
// 15.11.05  
  if Comando='Peso Líquido' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('moes_pesoliq').ascurrency,FConfDcto.FormatoQtdesInt);
  if Comando='Peso Bruto' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('moes_pesobru').ascurrency,FConfDcto.FormatoQtdesInt);

end;



function TFImpressao.ImprimeNotaTransf(Nota: Integer; DataMvto: TDatetime;Unidade: string ;TipoMov:string='' ): Boolean;
var n,nn,p:Integer;
    FormaImpressao,Codigo,Sqltipomov:String;
    valortotal,Tvalortotal:currency;
    QMestre1:TSqlquery;
    achou:boolean;

    procedure Envia_Impressora;
    var count,countgeral,i:integer;
    begin
      NroPagina:=1;
      NroPaginas:=1;
{
      count:=1;countgeral:=0;
      for i:=0 to ListaDetalhe.count-1 do begin
        Inc(countgeral);
        if countgeral>FConfdcto.NumLgPg then begin   // ver quantas páginas tera a nota
          inc(count);
          countgeral:=0;
        end;
      end;
}

      if FConfdcto.NumLgPg>0 then begin
        if Listadetalhe.count mod FConfdcto.NumLgPg = 0 then
          count:= Listadetalhe.count div FConfdcto.NumLgPg
        else
          count:= Listadetalhe.count div FConfdcto.NumLgPg + 1;
      end else
        count:=1;

      NroPaginas:=count;
      for i:=1 to count do begin
        NroPagina:=i;
        FConfDcto.Print(Codigo, RetornoNotaTransf, i = 1, i = count);
//        FConfDcto.GetConfiguracao(Codigo,(i*FConfdcto.NumLgPg+1));
//        if count>1 then
//          FConfDcto.GetConfiguracao(Codigo,(i*FConfdcto.NumLgPg));
        if count>1 then
          FConfDcto.GetConfiguracao(Codigo);
      end;
    end;


begin

  Result:=True;
  Codigo:=FGeral.GetConfig1AsString('Imprnotatransf');
  if trim(codigo)='' then begin
    Avisoerro('Falta configurar o codigo do impresso de nota de transferência');
    exit;
  end;
 if not Arq.TUnidades.active then Arq.TUnidades.Open;
//  if not Arq.TClientes.active then Arq.TClientes.Open;
  if not Arq.TNatFisc.active then Arq.TNatFisc.open;
  if not Arq.TTransp.active then Arq.TTransp.open;
  if trim(tipomov)='' then
    sqltipomov:=Global.CodTransfSaida+';'+Global.CodTransImob+';'+Global.CodTransfSaidaTempo+';'+
                Global.CodTransfSaiRetTempo+';'+Global.CodTransMatConsumoS
  else
    sqltipomov:=tipomov;

  try
    QMestre:=sqltoquery('select * from movesto '+
                     ' where moes_numerodoc='+inttostr(Nota)+
                     ' and moes_datamvto='+Datetosql(Datamvto)+
                     ' and moes_unid_codigo='''+unidade+''''+
                     ' and moes_status=''N'''+
//                     ' and '+FGeral.getin('moes_tipomov',Global.CodTransfSaida+';'+Global.CodTransfEntrada,'C')+
// 28.01.05
//                     ' and '+FGeral.getin('moes_tipomov',Global.CodTransfEntrada,'C')+
                     ' and '+FGeral.getin('moes_tipomov',sqltipomov,'C')+
                     ' order by moes_tipomov,moes_numerodoc' );
//   Global.CodTransfEntradaTempo:='XE';
//   Global.CodTransfSaidaTempo:='XS';


    QMestre.Name:='QMestre';
    if not QMestre.Eof then begin
// 28.01.05 - pra ficar 'posicionado' na TE q tem a unidade de destino ( dados do destinatario na nf )
      QMestre1:=sqltoquery('select * from movesto '+
                     ' where moes_numerodoc='+inttostr(Nota)+
                     ' and moes_datamvto='+Datetosql(Datamvto)+
                     ' and moes_unid_codigo<>'''+unidade+''''+
                     ' and moes_status=''N'''+
                     ' and '+FGeral.getin('moes_tipomov',Global.CodTransfEntrada+';'+Global.CodTransImobE+';'+Global.CodTransfEntradaTempo+';'+Global.CodTransfEntRetTempo+';'+Global.CodTransMatConsumoE,'C')+
                     ' order by moes_tipomov,moes_numerodoc' );

      QPendencia:=sqltoquery('select * from pendencias where pend_transacao='+stringtosql(QMestre.fieldbyname('moes_Transacao').AsString)+
                            ' and pend_status<>''C'''+
                            ' order by pend_datavcto');
      npar:=0;
      parc1:='';parc2:='';parc3:='';parc4:='';parc5:='';parc6:='';
      venc1:='';venc2:='';venc3:='';venc4:='';venc5:='';venc6:='';
      if not QPendencia.eof then begin
        npar:=1;
        while not QPendencia.eof do begin
          if npar=1 then begin
             venc1:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc1:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=2 then begin
             venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=3 then begin
             venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=4 then begin
             venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=5 then begin
             venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=6 then begin
             venc6:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc6:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end;
          inc(npar);
          QPendencia.Next;
        end;
      end;
//      Arq.TUnidades.locate('unid_codigo',unidade,[]);
// 28.01.05
      Arq.TUnidades.locate('unid_codigo',QMestre.fieldbyname('moes_unid_codigo').asstring,[]);
//      QClientes:=sqltoquery('select * from unidades where unid_codigo='+QMestre.fieldbyname('moes_tipo_codigo').asstring);
// 27.01.05
      if QMestre1.eof then
        QClientes:=sqltoquery('select * from unidades where unid_codigo='+stringtosql(QMestre.fieldbyname('moes_unid_codigo').asstring))
      else
        QClientes:=sqltoquery('select * from unidades where unid_codigo='+stringtosql(QMestre1.fieldbyname('moes_unid_codigo').asstring));
      QClientes.Name:='QClientes';
      Arq.TTransp.Locate('tran_codigo',QMestre.fieldbyname('moes_tran_codigo').asstring,[]);
      Codigo:=FGeral.GetConfig1AsString('Imprnotatransf');
      FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
       if (FormaImpressao='2') or ((FormaImpressao='1') and (Confirma('Confirma a impressão ?'))) then begin
          Result:=FConfDcto.GetConfiguracao(Codigo);
          if Result then begin
             Sistema.BeginProcess('imprimindo nota fiscal de transferência');
             nn:=0;
             QMestre.First;
             while not QMestre.Eof do begin
               Inc(nn);
               QMestre.Next;
             end;
             QMestre.First;
             n:=0;
             while not QMestre.Eof do begin
               Inc(n);
// detalhes q se repetem

               QDetalhe:=sqltoquery('select * from movestoque '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo)'+
                     ' where move_transacao='''+QMestre.fieldbyname('moes_transacao').asstring+''''+
                     ' and '+FGeral.GetIN('move_status','N','C')+
                     ' and '+FGeral.getin('move_tipomov',sqltipomov,'C')+
                     ' and move_numerodoc='+QMestre.fieldbyname('moes_numerodoc').asstring+
                     ' order by move_aliicms,move_esto_codigo' );

// 22.02.06 - para 'condensar' cores e tamanhos somente na impressao
               ListaDetalhe := TList.Create;valortotal:=0;Tvalortotal:=0;TQtdetotal:=0;
               while not QDetalhe.Eof do begin
                 achou:=false;
                 for p:=0 to ListaDetalhe.count-1 do begin
                   PDetalhe:=ListaDetalhe[p];
                   if (PDetalhe.Codigoproduto=Qdetalhe.fieldbyname('Move_esto_codigo').AsString) then begin
//                      (PDetalhe.CodigoTamanho=Qdetalhe.fieldbyname('Move_tama_codigo').AsInteger) and
//                      (PDetalhe.CodigoCor=Qdetalhe.fieldbyname('Move_core_codigo').AsInteger)  then begin
                      achou:=true;
                      break;
                   end;
                 end;
                 if not achou then begin
                   New(PDetalhe);
  //                 if ListaDetalhe.count=0 then
  // 23.02.05
                   if Tvalortotal=0 then
                     PDetalhe.TQuantidade:=0;
                   PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('Move_esto_codigo').AsString;
                   PDetalhe.Descricaoproduto:=Qdetalhe.fieldbyname('esto_descricao').Asstring;
                   PDetalhe.Cst:=Qdetalhe.fieldbyname('Move_cst').AsString;
                   PDetalhe.Unidade:=Qdetalhe.fieldbyname('Esto_unidade').Asstring;
                   PDetalhe.quantidade:=Qdetalhe.fieldbyname('move_qtde').AsCurrency;
                   PDetalhe.Unitario:=Qdetalhe.fieldbyname('move_venda').AsCurrency;
                   valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('move_venda').AsCurrency*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
                   PDetalhe.Total:=valortotal;
                   PDetalhe.icms:=Qdetalhe.fieldbyname('move_aliicms').AsCurrency;
                   PDetalhe.Codigocor:=Qdetalhe.fieldbyname('Move_core_codigo').AsInteger;
                   PDetalhe.CodigoTamanho:=Qdetalhe.fieldbyname('Move_tama_codigo').AsInteger;
                   ListaDetalhe.Add(Pdetalhe);
                 end else begin
                   PDetalhe.quantidade:=PDetalhe.quantidade+Qdetalhe.fieldbyname('move_qtde').AsCurrency;
                   valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('move_venda').AsCurrency*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
                   PDetalhe.Total:=PDetalhe.Total+valortotal;
                 end;
                 Tvalortotal:=Tvalortotal+valortotal;
                 TQtdetotal:=TQtdetotal+Qdetalhe.fieldbyname('move_qtde').Ascurrency;
                 QDetalhe.Next;
               end;

               if not QDetalhe.IsEmpty then begin
////                 Result:=FConfDcto.Print(Codigo,RetornoNotaTransf,n=1,n=nn);
                 Envia_Impressora;
//                 if not Result then Break;
               end;
               QDetalhe.Close;Listadetalhe.Free;
               QMestre.Next;
             end;
             Sistema.EndProcess('');
          end;
       end;
       Freeandnil(Qclientes);
    end else
      Avisoerro('Nota fiscal não encontrada');
    if not QMestre.eof then begin
      if QDetalhe<>nil then begin
        QDetalhe.Close;Freeandnil(QDetalhe);
      end;
    end;
    QMestre.Close;Freeandnil(QMestre);
  except
  end;
  Sistema.EndProcess('');
end;

procedure TFImpressao.ConfReciboPen(Codigo, Descricao: String);
///////////////////////////////////////////////////////////////////
var Tit:String;
    LComandos:TStringList;
begin
  Tit:='Configuração Recibo de Pendência Financeira / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
  LComandos.Add('Nome da Unidade');
  LComandos.Add('CNPJ da unidade');
  LComandos.Add('Cidade da unidade');
// 05.03.08
  LComandos.Add('Inscrição Estadual da unidade');
  LComandos.Add('Razão Social da unidade');
  LComandos.Add('Endereço da unidade');
  LComandos.Add('Bairro da unidade');
  LComandos.Add('CEP da unidade');
  LComandos.Add('Fone da unidade');
  LComandos.Add('Email da unidade');
  LComandos.Add('Estado da unidade');
//
  LComandos.Add('Numero recibo');
  LComandos.Add('Numero documento');
  LComandos.Add('Razão Social');
  LComandos.Add('Nome');
  LComandos.Add('CNPJ/CPF');
  LComandos.Add('Data emissão');
  LComandos.Add('Data Baixa');
  LComandos.Add('Valor Parcela');
  LComandos.Add('Vencimento Parcela');
  LComandos.Add('Parcela/Nro parcelas');
  LComandos.Add('Valor por extenso (linha1)');
  LComandos.Add('Valor por extenso (linha2)');
// 04.03.08
  LComandos.Add('Histórico');
// 19.03.19
  LComandos.Add('Histórico 1');
  LComandos.Add('Histórico 2');
  LComandos.Add('Codigo usuário');
  LComandos.Add('Nome usuário');
  LComandos.Add('Valor Nota Entrada Produtor');
  LComandos.Add('Valor Líquido');
  LComandos.Add('Valor das Vendas');
  LComandos.Add('Valor 01 Nota Venda ao Produtor');
  LComandos.Add('Data 01 Nota Venda ao Produtor');
  LComandos.Add('Numero 01 Nota Venda ao Produtor');
  LComandos.Add('Valor 02 Nota Venda ao Produtor');
  LComandos.Add('Data 02 Nota Venda ao Produtor');
  LComandos.Add('Numero 02 Nota Venda ao Produtor');
  LComandos.Add('Valor 03 Nota Venda ao Produtor');
  LComandos.Add('Data 03 Nota Venda ao Produtor');
  LComandos.Add('Numero 03 Nota Venda ao Produtor');
  LComandos.Add('Valor 04 Nota Venda ao Produtor');
  LComandos.Add('Data 04 Nota Venda ao Produtor');
  LComandos.Add('Numero 04 Nota Venda ao Produtor');
  LComandos.Add('Valor 05 Nota Venda ao Produtor');
  LComandos.Add('Data 05 Nota Venda ao Produtor');
  LComandos.Add('Numero 05 Nota Venda ao Produtor');
  LComandos.Add('Valor 06 Nota Venda ao Produtor');
  LComandos.Add('Data 06 Nota Venda ao Produtor');
  LComandos.Add('Numero 06 Nota Venda ao Produtor');
  LComandos.Add('Valor 07 Nota Venda ao Produtor');
  LComandos.Add('Data 07 Nota Venda ao Produtor');
  LComandos.Add('Numero 07 Nota Venda ao Produtor');
  LComandos.Add('Valor 08 Nota Venda ao Produtor');
  LComandos.Add('Data 08 Nota Venda ao Produtor');
  LComandos.Add('Numero 08 Nota Venda ao Produtor');
  LComandos.Add('Valor 09 Nota Venda ao Produtor');
  LComandos.Add('Data 09 Nota Venda ao Produtor');
  LComandos.Add('Numero 09 Nota Venda ao Produtor');
  LComandos.Add('Valor 10 Nota Venda ao Produtor');
  LComandos.Add('Data 10 Nota Venda ao Produtor');
  LComandos.Add('Numero 10 Nota Venda ao Produtor');
  FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  LComandos.Free;
end;

function RetornoReciboPen(Comando,Especie:String):String;
///////////////////////////////////////////////////////////////////////
var ext,
    linhahist :string;
    tam       :integer;


    // 06.01.15
    function Tratavalor(valor:currency):string;
    ////////////////////////////////////////////
    begin
       result:='';
       if valor>0 then
         result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores);
    end;

    function GetBaixas( xt:string ):string;
    ///////////////////////////////////////
    var Qb:TSqlquery;
        s :string;
    begin

       Qb:=sqltoquery('select pend_numerodcto,pend_parcela from pendencias where pend_transbaixa = '+
                      stringtosql( xt )+' and pend_status = ''B''');
// 15.02.2022 - Benato baixas crediario
//       if Qb.RecordCount=1 then result:= QMestre.FieldByName('pend_complemento').asstring
       if Qb.RecordCount=1 then result:=QMestre1.fieldbyname('movf_complemento').asstring
       else begin
          s:='';
          while not Qb.Eof do begin
              s:=s+Qb.FieldByName('pend_numerodcto').AsString+'-'+Qb.FieldByName('pend_parcela').AsString+' ';
              Qb.Next;
          end;
          result:=s;
       end;
       FGeral.FechaQuery(Qb);

    end;


begin
////////////
  if Comando='Nome da Unidade' then Result:=QMestre.fieldbyname('unid_nome').asstring
// 05.03.08
  else if Comando='Inscrição Estadual da unidade' then Result:=QMestre.fieldbyname('unid_inscricaoestadual').asstring
  else if Comando='Razão Social da unidade' then Result:=QMestre.fieldbyname('unid_razaosocial').asstring
  else if Comando='Endereço da unidade' then Result:=QMestre.fieldbyname('unid_endereco').asstring
  else if Comando='Bairro da unidade' then Result:=QMestre.fieldbyname('unid_bairro').asstring
  else if Comando='CEP da unidade' then Result:=FGEral.formatacep(QMestre.fieldbyname('unid_cep').asstring)
  else if Comando='Fone da unidade' then Result:=FGeral.Formatatelefone(QMestre.fieldbyname('unid_fone').asstring)
  else if Comando='Email da unidade' then Result:=QMestre.fieldbyname('unid_email').asstring
  else if Comando='Estado da unidade' then Result:=QMestre.fieldbyname('unid_uf').asstring
  else if Comando='Numero recibo' then Result:=inttostr( FGeral.GetContador('RECIBOPEN',false) )
  else if Comando='Numero documento' then Result:=QMestre.fieldbyname('pend_numerodcto').asstring
  else if Comando='CNPJ da unidade' then Result:=FGeral.Formatacnpj(QMestre.fieldbyname('unid_cnpj').asstring)
  else if Comando='Cidade da unidade' then Result:=QMestre.fieldbyname('unid_municipio').asstring
  else if Comando='Razão Social' then Result:=FGEral.GetRazSocialTipoCad(QMestre.fieldbyname('pend_tipo_codigo').asinteger,QMestre.fieldbyname('pend_tipocad').asstring)
//  if Comando='Nome' then Result:=FGEral.GetNomeTipoCad(QMestre.fieldbyname('pend_tipo_codigo').asinteger,QMestre.fieldbyname('pend_tipocad').asstring);
  else if Comando='Nome' then Result:=FGEral.GetNomeRazaoSocialEntidade(QMestre.fieldbyname('pend_tipo_codigo').asinteger,QMestre.fieldbyname('pend_tipocad').asstring,'N')
  else if Comando='CNPJ/CPF' then Result:=FGEral.GetCnpjCpfTipoCad(QMestre.fieldbyname('pend_tipo_codigo').asinteger,QMestre.fieldbyname('pend_tipocad').asstring)
  else if Comando='Data emissão' then Result:=FGeral.FormataData(QMestre.fieldbyname('pend_dataemissao').asdatetime);
  if Comando='Data Baixa' then begin
    if QMestre.fieldbyname('pend_databaixa').asdatetime>1 then
      Result:=FGeral.FormataData(QMestre.fieldbyname('pend_databaixa').asdatetime)
    else
      Result:=FGeral.FormataData(Sistema.hoje);
  end;
  ext:=UpperCaseBras( Extenso(valorrecibo) );
  if AnsiPos( 'Histórico', Comando ) > 0 then begin
      if AnsiPos(QMestre.fieldbyname('pend_status').asstring,'P;K') = 0 then

         linhahist:=GetBaixas( QMestre.fieldbyname('pend_transbaixa').asstring )

      else

         linhahist:=GetBaixas( QMestre.fieldbyname('pend_operacao').asstring );

  end else linhahist:='';

// 15.02.2022 - Benato baixas crediario
  if trim(linhahist)='' then linhahist:=QMestre1.fieldbyname('movf_complemento').asstring;

  if (Comando='Valor Parcela')  then Result:=FGeral.FormataValor(valorrecibo,FConfDcto.FormatoValores)
  else if Comando='Parcela/Nro parcelas' then Result:=strzero(QMestre.fieldbyname('pend_parcela').asinteger,3)+'/'+strzero(QMestre.fieldbyname('pend_nparcelas').asinteger,3)
  else if Comando='Vencimento Parcela' then Result:=FGeral.FormataData(QMestre.fieldbyname('pend_datavcto').asdatetime)
  else if Comando='Valor por extenso (linha1)' then Result:=copy(ext,1,80)
  else if Comando='Valor por extenso (linha2)' then Result:=copy(ext,81,80)
  else if Comando='Codigo usuário' then result:=QMestre.fieldbyname('pend_usubaixa').asstring
  else if Comando='Nome usuário' then result:=FUsuarios.GetNome(QMestre.fieldbyname('pend_usubaixa').asinteger)
// 04.03.08
//  else if Comando='Histórico' then result:= QMestre.fieldbyname('pend_complemento').asstring
// 19.03.19 - Vida Nova - alecxandra
  else if Comando='Histórico' then   result:=copy( linhahist,01,40 )
  else if Comando='Histórico 1' then result:=copy( linhahist,41,40 )
  else if Comando='Histórico 2' then result:=copy( linhahist,82,40 )
// 06.01.15
  else if Comando='Valor Nota Entrada Produtor' then result:=FGeral.FormataValor(valorNP,FConfDcto.FormatoValores)
  else if Comando='Valor 01 Nota Venda ao Produtor' then result:=TrataValor(valorven01)
  else if Comando='Data 01 Nota Venda ao Produtor' then result:=FGeral.FormataData(dataven01)
  else if Comando='Numero 01 Nota Venda ao Produtor' then result:=(numero01)
  else if Comando='Valor 02 Nota Venda ao Produtor' then result:=TrataValor(valorven02)
  else if Comando='Data 02 Nota Venda ao Produtor' then result:=FGeral.FormataData(dataven02)
  else if Comando='Numero 02 Nota Venda ao Produtor' then result:=(numero02)
  else if Comando='Valor 03 Nota Venda ao Produtor' then result:=TrataValor(valorven03)
  else if Comando='Data 03 Nota Venda ao Produtor' then result:=FGeral.FormataData(dataven03)
  else if Comando='Numero 03 Nota Venda ao Produtor' then result:=(numero03)
  else if Comando='Valor 04 Nota Venda ao Produtor' then result:=TrataValor(valorven04)
  else if Comando='Data 04 Nota Venda ao Produtor'  then result:=FGeral.FormataData(dataven04)
  else if Comando='Numero 04 Nota Venda ao Produtor' then result:=(numero04)
  else if Comando='Valor 05 Nota Venda ao Produtor' then result:=TrataValor(valorven05)
  else if Comando='Data 05 Nota Venda ao Produtor'  then result:=FGeral.FormataData(dataven05)
  else if Comando='Numero 05 Nota Venda ao Produtor' then result:=(numero05)
  else if Comando='Valor 06 Nota Venda ao Produtor' then result:=TrataValor(valorven06)
  else if Comando='Data 06 Nota Venda ao Produtor'  then result:=FGeral.FormataData(dataven06)
  else if Comando='Numero 06 Nota Venda ao Produtor' then result:=(numero06)
  else if Comando='Valor 07 Nota Venda ao Produtor' then result:=TrataValor(valorven07)
  else if Comando='Data 07 Nota Venda ao Produtor'  then result:=FGeral.FormataData(dataven07)
  else if Comando='Numero 07 Nota Venda ao Produtor' then result:=(numero07)
  else if Comando='Valor 08 Nota Venda ao Produtor' then result:=TrataValor(valorven08)
  else if Comando='Data 08 Nota Venda ao Produtor'  then result:=FGeral.FormataData(dataven08)
  else if Comando='Numero 08 Nota Venda ao Produtor' then result:=(numero08)
  else if Comando='Valor 09 Nota Venda ao Produtor' then result:=TrataValor(valorven09)
  else if Comando='Data 09 Nota Venda ao Produtor'  then result:=FGeral.FormataData(dataven09)
  else if Comando='Numero 09 Nota Venda ao Produtor' then result:=(numero09)
  else if Comando='Valor 10 Nota Venda ao Produtor' then result:=TrataValor(valorven10)
  else if Comando='Data 10 Nota Venda ao Produtor'  then result:=FGeral.FormataData(dataven10)
  else if Comando='Numero 10 Nota Venda ao Produtor' then result:=(numero10)
  else if Comando='Valor Líquido' then result:=FGeral.FormataValor(ValorLiquido,FConfDcto.FormatoValores)
  else if Comando='Valor das Vendas' then result:=TrataValor(ValorVendas)
  else if copy(Uppercase(comando),1,5)='LINHA' then begin
    if pos('[',comando)+1=pos(']',comando)-1 then
      tam:=1
    else
      tam:=strtoint( copy(comando,pos('[',comando)+1,pos(']',comando)-pos('[',comando)-1 ) );
    result:=replicate('-',tam);
  end;
end;

function TFImpressao.ImprimeReciboPen(Operacao:string;xTipo:string='';xValor:currency=0): Boolean;
/////////////////////////////////////////////////////////////////////////////////////////////////////////
var n,nn,x:Integer;
    FormaImpressao,Codigo,w,sqltipo:String;
    Q:TSqlquery;

    function GetValorNP:currency;
    /////////////////////////////
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select pend_valor from pendencias where pend_transbaixa='+
                    Stringtosql(QMestre.fieldbyname('pend_transbaixa').asstring)+
                    ' and pend_tipo_codigo='+QMestre.fieldbyname('pend_tipo_codigo').asstring+
                    ' and pend_status <> ''C'''+
                    ' and pend_unid_codigo='+Stringtosql(QMestre.fieldbyname('pend_unid_codigo').asstring)+
                    ' and pend_tipomov='+stringtosql(Global.CodCompraProdutor) );
      if not Q.Eof then result:=Q.fieldbyname('pend_valor').ascurrency else result:=0;
      FGeral.FechaQuery(Q);
    end;

    function GetValorBP:currency;
    /////////////////////////////
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select pend_valor from pendencias where pend_status = ''P'''+
                    ' and pend_tipo_codigo='+QMestre.fieldbyname('pend_tipo_codigo').asstring+
                    ' and pend_unid_codigo='+Stringtosql(QMestre.fieldbyname('pend_unid_codigo').asstring)+
                    ' and pend_rp = ''R'''+
                    ' and extract( month from pend_databaixa ) = '+inttostr(Datetomes(QMestre.fieldbyname('pend_databaixa').asdatetime))+
                    ' and extract( year from pend_databaixa ) = '+inttostr(Datetoano(QMestre.fieldbyname('pend_databaixa').asdatetime,true)) );
      if not Q.Eof then result:=Q.fieldbyname('pend_valor').ascurrency else result:=0;
      FGeral.FechaQuery(Q);
    end;

    function GetValorChequeaemitir:currency;
    //////////////////////////////////////////
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select movf_valorger from movfin where movf_transacao='+
                    Stringtosql(QMestre.fieldbyname('pend_transbaixa').asstring)+
                    ' and movf_status <> ''C'''+
                    ' and movf_tipomov='+Stringtosql('CH')+
                    ' and movf_unid_codigo='+Stringtosql(QMestre.fieldbyname('pend_unid_codigo').asstring));
      if not Q.Eof then result:=Q.fieldbyname('movf_valorger').ascurrency else result:=0;
      FGeral.FechaQuery(Q);
    end;


begin
////////////////////////////////////////////////
  Result:=True;
  FCadImp.Open;
  valorrecibo:=0;valorBP:=0;valorbpantes:=0;
  valorven01:=0;valorven02:=0;valorven03:=0;valorven04:=0;valorven05:=0;
  valorven06:=0;valorven07:=0;valorven08:=0;valorven09:=0;valorven10:=0;
  dataven01:=TexttoDate('');
  dataven02:=TexttoDate('');
  dataven03:=TexttoDate('');
  dataven04:=TexttoDate('');
  dataven05:=TexttoDate('');
  dataven06:=TexttoDate('');
  dataven07:=TexttoDate('');
  dataven08:=TexttoDate('');
  dataven09:=TexttoDate('');
  dataven10:=TexttoDate('');
  numero01:='';numero02:='';numero03:='';numero04:='';numero05:='';
  numero06:='';numero07:='';numero08:='';numero09:='';numero10:='';
  try
    QMestre:=sqltoquery('select * from pendencias left join unidades on (unid_codigo=pend_unid_codigo)'+
             ' where pend_operacao='+stringtosql(operacao)+' and pend_status<>''C''' );
    QMestre.Name:='QMestre';
    if not QMestre.isEmpty then begin
      if QMestre.fieldbyname('pend_datacont').asdatetime>1 then
//        sqltipo:=' and pend_datacont>1'
        sqltipo:=' and pend_datacont > '+DateToSql(Global.DataMenorBanco)
      else
        sqltipo:='';

        //      valorrecibo:=QMestre.fieldbyname('pend_valor').ascurrency;    // valor do capital ou da BP
//      if trim(QMestre.fieldbyname('Pend_transbaixa').asstring)='' then begin  // baixa parcial
// 01.12.09
      valorrecibo:=0;
      if pos(QMestre.fieldbyname('Pend_status').asstring,'P;K')>0 then begin
        valorbp:=QMestre.fieldbyname('pend_valor').ascurrency;
// 21.01.2013 - Vivan - em baixa 'normal' de parcela inteira dobrava o valor
//              deixado sempre ir buscar os valores no movfin ( caixa/bancos )

{
        QBxParcial:=sqltoquery('select pend_valor,pend_transacao from pendencias where pend_status=''P'''+
          ' and pend_tipo_codigo = '+QMestre.fieldbyname('pend_tipo_codigo').asstring+
          ' and pend_databaixa <= '+Datetosql(sistema.hoje)+
          ' and Pend_NumeroDcto = '+stringtosql(QMestre.fieldbyname('Pend_NumeroDcto').asstring)+
          sqltipo+   // 26.09.05
          ' and pend_parcela='+stringtosql(QMestre.fieldbyname('Pend_parcela').asstring)+
          ' order by pend_databaixa desc' );
          }
//        if not QBxParcial.eof then
//           valorrecibo:=QBxParcial.fieldbyname('pend_valor').ascurrency;
        QMestre1:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(QMestre.fieldbyname('pend_transacao').asstring)+
            ' and '+FGeral.Getin('movf_status','N;A','C') );
//        FGeral.FechaQuery(QBxParcial);
      end else begin
//busca juros ou descontos mesmo em baixa parcial
        QMestre1:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(QMestre.fieldbyname('pend_transbaixa').asstring)+
            ' and '+FGeral.Getin('movf_status','N;A','C') );
      end;
/////////////////////////         valorrecibo:=0;
///
         while not QMestre1.eof do begin

           if Global.CodJurosRecebidos=QMestre1.fieldbyname('movf_tipomov').asstring then
             valorrecibo:=valorrecibo+QMestre1.fieldbyname('movf_valorger').ascurrency
           else if Global.CodDescontosDados=QMestre1.fieldbyname('movf_tipomov').asstring then
             valorrecibo:=valorrecibo-QMestre1.fieldbyname('movf_valorger').ascurrency
           else begin
             if (QMestre1.fieldbyname('movf_es').asstring='S') and (QMestre.fieldbyname('pend_rp').asstring='P') then
               valorrecibo:=valorrecibo+QMestre1.fieldbyname('movf_valorger').ascurrency
             else if (QMestre1.fieldbyname('movf_es').asstring='E') and (QMestre.fieldbyname('pend_rp').asstring='R') then
               valorrecibo:=valorrecibo+QMestre1.fieldbyname('movf_valorger').ascurrency;
           end;
           QMestre1.next;

         end;

// 15.09.2022 - baixa parcial somente sobre o total da 'n' pendencias...
//     if xvalor>0 then valorrecibo:=xvalor;

// 15.02.2022 - baixas benato
     QMestre1.first;
     if valorrecibo=0 then begin

        valorrecibo:=QMestre1.fieldbyname('movf_valorger').ascurrency

     end;

//      end;
// 05.01.2015 - Coorlaf
       valornp:=0;
       if xtipo='L' then begin
///////////////////////////////////

         valornp:=GetValornp;
         valorbpantes:=GetValorbp;
         Q:=sqltoquery('select pend_valor,pend_dataemissao,pend_tipomov,pend_status from pendencias where pend_status <> ''C'''+
                    ' and  pend_transbaixa='+Stringtosql(QMestre.fieldbyname('pend_transbaixa').asstring)+
                    ' and pend_tipo_codigo='+QMestre.fieldbyname('pend_tipo_codigo').asstring+
                    ' and pend_unid_codigo='+Stringtosql(QMestre.fieldbyname('pend_unid_codigo').asstring)+
                    ' and pend_tipomov<>'+stringtosql(Global.CodCompraProdutor)+
                    ' order by pend_dataemissao' );
         valorvendas:=0;valorliquido:=0;
         while not Q.eof do begin
             if valorven01=0 then begin
               valorven01:=Q.fieldbyname('pend_valor').ascurrency;
               dataven01:=Q.fieldbyname('pend_dataemissao').asdatetime;
               numero01:=Q.fieldbyname('pend_numerodcto').asstring;
             end else if valorven02=0 then begin
               valorven02:=Q.fieldbyname('pend_valor').ascurrency;
               dataven02:=Q.fieldbyname('pend_dataemissao').asdatetime;
               numero02:=Q.fieldbyname('pend_numerodcto').asstring;
             end else if valorven03=0 then begin
               valorven03:=Q.fieldbyname('pend_valor').ascurrency;
               dataven03:=Q.fieldbyname('pend_dataemissao').asdatetime;
               numero03:=Q.fieldbyname('pend_numerodcto').asstring;
             end else if valorven04=0 then begin
               valorven04:=Q.fieldbyname('pend_valor').ascurrency;
               dataven04:=Q.fieldbyname('pend_dataemissao').asdatetime;
               numero04:=Q.fieldbyname('pend_numerodcto').asstring;
             end else if valorven05=0 then begin
               valorven05:=Q.fieldbyname('pend_valor').ascurrency;
               dataven05:=Q.fieldbyname('pend_dataemissao').asdatetime;
               numero05:=Q.fieldbyname('pend_numerodcto').asstring;
             end else if valorven06=0 then begin
               valorven06:=Q.fieldbyname('pend_valor').ascurrency;
               dataven06:=Q.fieldbyname('pend_dataemissao').asdatetime;
               numero06:=Q.fieldbyname('pend_numerodcto').asstring;
             end else if valorven07=0 then begin
               valorven07:=Q.fieldbyname('pend_valor').ascurrency;
               dataven07:=Q.fieldbyname('pend_dataemissao').asdatetime;
               numero07:=Q.fieldbyname('pend_numerodcto').asstring;
             end else if valorven08=0 then begin
               valorven08:=Q.fieldbyname('pend_valor').ascurrency;
               dataven08:=Q.fieldbyname('pend_dataemissao').asdatetime;
               numero08:=Q.fieldbyname('pend_numerodcto').asstring;
             end else if valorven09=0 then begin
               valorven09:=Q.fieldbyname('pend_valor').ascurrency;
               dataven09:=Q.fieldbyname('pend_dataemissao').asdatetime;
               numero09:=Q.fieldbyname('pend_numerodcto').asstring;
             end else begin
               valorven10:=Q.fieldbyname('pend_valor').ascurrency;
               dataven10:=Q.fieldbyname('pend_dataemissao').asdatetime;
               numero10:=Q.fieldbyname('pend_numerodcto').asstring;
             end;
             valorvendas:=valorvendas+Q.fieldbyname('pend_valor').ascurrency;
           Q.Next;
         end;
         FGeral.FechaQuery(Q);
         if (valorvendas=0) and (valorbpantes>0) then begin
           valorvendas:=valorbpantes;
           valorliquido:=valorvendas
         end else begin
           valorvendas:=valorvendas-valorbpantes;
           valorliquido:=valornp-valorvendas;
         end;
//         if valorbp>0 then valorrecibo:=valorbp
//         else valorrecibo:=valorliquido;
//////////////////////////////////////
         valorrecibo:=GetValorChequeaemitir;
       end;

       Codigo:=FGeral.GetConfig1AsString('imprrecibo');
       if trim(codigo)='' then begin
         Avisoerro('Falta configurar o codigo do impresso de recibo de quitação');
         Freeandnil(QMestre);
         exit;
       end;
       FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
//       if (FormaImpressao='2') or ((FormaImpressao='1') and (Confirma('Confirma a impressão do recibo'))) then begin
// 06.01.15
       if (FormaImpressao='2') or (FormaImpressao='1') then begin
          Result:=FConfDcto.GetConfiguracao(Codigo);
          if Result then begin
             Sistema.BeginProcess('imprimindo recibo');
             nn:=0;
             while not QMestre.Eof do begin
               Inc(nn);
               QMestre.Next;
             end;
             QMestre.First;
             n:=0;
//             for x:=0 to FConfDcto.NumCopias do begin
               while not QMestre.Eof do begin
                 Inc(n);
                 Result:=FConfDcto.Print(Codigo,RetornoReciboPen,n=1,n=nn);
                 if not Result then Break;
                 QMestre.Next;
               end;
//             end;
             Sistema.endProcess('');
          end;
       end;
    end else
      Avisoerro('Operação não encontrada');
  except
    Avisoerro('Não foi possível imprimir');
  end;
  Sistema.EndProcess('');
  Freeandnil(QMestre);
end;



function TFImpressao.tiraaspas(comando: string): string;
/////////////////////////////////////////////////////////
var s,x,xcomando:string;
    p:integer;
begin
   s:='';
   if copy(comando,1,2)='IP' then begin
     xcomando:=strcontida(comando,'(',')');
     for p:=1 to length(xcomando) do begin
       x:=copy(xcomando,p,1);
       if x<>'' then begin
         if pos(x,'"')=0 then
           s:=s+x;
       end;
     end;
   end;
   result:=s;
end;

procedure TFImpressao.ConfEtqCliente(Codigo, Descricao: String);
var Tit:String;
    LComandos:TStringList;
begin
  Tit:='Configuração Etiqueta Cliente / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
  LComandos.Add('Codigo');
  LComandos.Add('Nome');
  LComandos.Add('Razão Social');
  LComandos.Add('Endereço Residencial');
  LComandos.Add('Complemento');
  LComandos.Add('Bairro');
  LComandos.Add('CEP');
  LComandos.Add('Cidade');
  LComandos.Add('Estado');
  LComandos.Add('Mes/ano Aniversário');
  FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  LComandos.Free;
end;


function RetornoEtqCliente(Comando,Especie:String):String;
////////////////////////////////////////////////////////////////////////
var ext:string;
    tam:integer;

    procedure Impressaocolunas( campo:string ; coluna:integer=1 ; informacao:string='') ;  // 23.01.13
    ////////////////////////////////////////////////////////////////////////////////////
    begin
      if (coluna<=1) and (not QMestreCli.eof) then
        QMestreCli.next;
      if (coluna<=2)  and (not QMestreCli.eof) then
        QMestreCli.next;
      if ( coluna<=3)  and (not QMestreCli.eof) then
        QMestreCli.next;
      if not QMestreCli.Eof then
        Result:=QMestreCli.fieldbyname( campo ).asstring
      else if trim(informacao)<>'' then
        Result:=informacao
      else
        Result:='';
      if (coluna<=1) and (not QMestreCli.eof) then
        QMestreCli.Prior;
      if ( coluna<=2 ) and (not QMestreCli.eof)then
        QMestreCli.Prior;
      if ( coluna<=3 ) and (not QMestreCli.eof)then
        QMestreCli.Prior;
    end;

begin
//////////////////////////
  if Comando='Codigo' then Result:=QMestreCli.fieldbyname('clie_codigo').asstring
  else if Comando='Nome' then Result:=QMestreCli.fieldbyname('clie_nome').asstring
  else if Comando='Nome1' then
    Impressaocolunas( 'clie_nome' )
//    QMestreCli.next;
//    if not QMestreCli.Eof then
//      Result:=QMestreCli.fieldbyname('clie_nome').asstring
//    else
//      Result:='';
//    QMestreCli.Prior;
  else if Comando='Nome2' then
    Impressaocolunas( 'clie_nome',2 )
  else if Comando='Nome3' then
    Impressaocolunas( 'clie_nome',3 )
  else if Comando='Razão Social' then Result:=QMestreCli.fieldbyname('clie_razaosocial').asstring
  else if Comando='Razão Social1' then
    Impressaocolunas( 'clie_razaosocial' )
  else if Comando='Razão Social2' then
    Impressaocolunas( 'clie_razaosocial',2 )
  else if Comando='Endereço Residencial' then Result:=QMestreCli.fieldbyname('clie_endres').asstring
  else if Comando='Complemento' then Result:=QMestreCli.fieldbyname('clie_endrescompl').asstring
  else if Comando='Bairro' then Result:=QMestreCli.fieldbyname('clie_bairrores').asstring
  else if Comando='CEP' then Result:=fGeral.FormataCep(QMestreCli.fieldbyname('clie_cepres').asstring)
//  else if Comando='CEP1' then Impressaocolunas( 'clie_cepres' )
//  else if Comando='CEP2' then Impressaocolunas( 'clie_cepres' ,2)
  else if Comando='Cidade' then Result:=Fcidades.GetNome(QMestreCli.fieldbyname('clie_cida_codigo_res').asinteger)
//  else if Comando='Cidade1' then Result:=Impressaocolunas( '',1, Fcidades.GetNome(QMestreCli.fieldbyname('clie_cida_codigo_res').asinteger)  )
//  else if Comando='Cidade2' then Result:=Impressaocolunas( '',2, Fcidades.GetNome(QMestreCli.fieldbyname('clie_cida_codigo_res').asinteger)  )
  else if Comando='Estado' then Result:=Fcidades.GetUF(QMestreCli.fieldbyname('clie_cida_codigo_res').asinteger)
  else if Comando='Mes/ano Aniversário' then Result:=formatdatetime('mm/yy',QMestreCli.fieldbyname('clie_dtnasc').asdatetime)
  else if copy(Uppercase(comando),1,5)='LINHA' then begin
    if pos('[',comando)+1=pos(']',comando)-1 then
      tam:=1
    else
      tam:=strtoint( copy(comando,pos('[',comando)+1,pos(']',comando)-pos('[',comando)-1 ) );
    result:=replicate('-',tam);
  end;
end;


//////////////////////////////////////////////////////////////////////////////////////////////////
function TFImpressao.ImprimeEtqCliente(Comando:string ; Ativos:string ; Datai,Dataf:TDatetime): Boolean;
//////////////////////////////////////////////////////////////////////////////////////////////////
var n,nn,v,ncolunas,etiquetasfolha,espacosentreetq,linhainiciofolha,linhasentreetq:Integer;
    FormaImpressao,Codigo,w,operacao,l0,l1,l2,l3,l4,cidcli,ufcli,l5,clientesok:String;
    ultimaposicao,porpagina:integer;
    ListaPar:TStringList;

    function EstaValendo(Cliente:integer;Nascimento:TDatetime):boolean;
    //////////////////////////////////////////////////////////////////////////////////
    begin
// 20.08.14
       if Ativos='T' then
         result:=true
       else if fGeral.Parabens(Nascimento,DAtai,Dataf) then begin
         result:=true;
         if Ativos='T' then
           result:=true
         else if (Ativos='A') and (FGeral.EstaAtivo(cliente,'C') ) then
           result:=true
         else if (pos(Ativos,'A/T')=0) and ( not FGeral.EstaAtivo(cliente,'C') ) then
           result:=true
         else
           result:=false;
       end else
         result:=false;
    end;

begin
//////////////////////////
  Result:=True;
  FCadImp.Open;
  QMestre:=sqltoquery(comando);
  clientesok:='';
// ver onde configurar
// vivan
/////////////////////////
{
  ncolunas:=3;
  etiquetasfolha:=10;
  espacosentreetq:=2;
  linhainiciofolha:=7;
  linhasentreetq:=3;
  }
////////////////////////////
// tivi
/////////////////////////
  ListaPar:=TStringList.Create;
  if trim( FGeral.GetConfig1AsString('parametqcliente') ) <> '' then
    StrtoLista(ListaPar,FGeral.GetConfig1AsString('parametqcliente'),';',true)
  else begin
    ListaPar.Add('3');
    ListaPar.Add('10');
    ListaPar.Add('2');
    ListaPar.Add('7');
    ListaPar.Add('3');
  end;
  ncolunas:=strtoint(Listapar[0]);
  etiquetasfolha:=strtoint(Listapar[1]);
  espacosentreetq:=strtoint(Listapar[2]);
  linhainiciofolha:=strtoint(Listapar[3]);
  linhasentreetq:=strtoint(Listapar[4]);

////////////////////////////

//  QMestreCli:=sqltomemoryquery(comando);
//  try
    QMestre.Name:='QMestre';
    if not QMestre.isEmpty then begin
       Codigo:=FGeral.GetConfig1AsString('impretqcli');
       if trim(codigo)='' then begin
         Avisoerro('Falta configurar o codigo do impresso da etiqueta do cliente');
         Freeandnil(QMestre);
         exit;
       end;
       FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
//       if (FormaImpressao='2') or ((FormaImpressao='1') and (Confirma('Confirma a impressão'))) then begin
       if (Confirma('Confirma a impressão')) then begin
//          Result:=FConfDcto.GetConfiguracao(Codigo);
          Result:=true;
          if Result then begin
             Sistema.BeginProcess('imprimindo etiqueta');
             nn:=0;
             while not QMestre.Eof do begin
               if Ativos<>'T' then begin
                 if Estavalendo(QMestre.fieldbyname('clie_codigo').asinteger,QMestre.fieldbyname('clie_dtnasc').asdatetime) then begin
                   Inc(nn);
                   clientesok:=clientesok+QMestre.fieldbyname('clie_codigo').asstring+';';
                 end;
               end;
               QMestre.Next;
             end;
             if trim(clientesok)<>'' then
               QMestrecli:=Sqltomemoryquery( comando + ' and '+FGeral.GetIN('clie_codigo',clientesok,'N')+ ' order by Clie_endres,clie_nome' )
             else
               QMestrecli:=Sqltomemoryquery( comando + 'order by Clie_endres,clie_nome' );

             n:=0;
//             FTextrel.Init(60);
// 05.12.05
//             FTextrel.Init(59);
// 22.06.06
//             FTextrel.Init(60);
// 25.10.12
//             FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309]);

//             FTextrel.Impr.LinPol8(true);

             l0:='';
             l1:='';l2:='';l3:='';l4:='';l5:='';
///             Ftextrel.Saltalinha(1);
             FTextRel.Init(etiquetasfolha*(6+linhasentreetq),nil,nil,0,Global.Usuario.OutrosAcessos[3309]);
//             v:=0;
             porpagina:= 70 div FConfDcto.NumLgPg;
             Ftextrel.SaltaLinha(linhainiciofolha);

             while not QMestrecli.Eof do begin
//               if Estavalendo(QMestrecli.fieldbyname('clie_codigo').asinteger,QMestrecli.fieldbyname('clie_dtnasc').asdatetime) then begin
                 Inc(n);

//                 Result:=FConfDcto.Print(Codigo,RetornoEtqCliente,n=1,n=nn,Visualiza,(n-1)*FConfDcto.NumLgPg,'L',3);
//                 Result:=FConfDcto.Print(Codigo,RetornoEtqCliente,n=1,n=nn,Visualiza,(n-1)*FConfDcto.NumLgPg,'L',3);

//                 Result:=FConfDcto.Print(Codigo,RetornoEtqCliente,n=1,n=nn,Visualiza,trunc(((n-1)*FConfDcto.NumLgPg)/3),'L',2);
//                 FConfDcto.GetConfiguracao(Codigo,trunc(((n-1)*FConfDcto.NumLgPg)/3));
///////////////////////////////////
{
                 if n=1 then begin
//                          Result:=FConfDcto.Print(Codigo,RetornoEtqCliente,n=1,n=nn+1,Visualiza,(n-1)*FConfDcto.NumLgPg,'L',2);
// fixo por enquanto - preve colocar 'linha no inicio'...
                          Result:=FConfDcto.Print(Codigo,RetornoEtqCliente,n=1,n=nn+1,Visualiza,FConfDcto.NumLgPg-3,'L',2);
                          FConfDcto.GetConfiguracao(Codigo,n*FConfDcto.NumLgPg);
//                        end else if (FConfDcto.NumLgFinal>0) and ( (n mod 2)=0 ) and ( i=1 ) then begin
//                          Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,i=0,i=quantos+1,Visualiza,(i)*FConfDcto.NumLgPg+(FConfDcto.NumLgFinal));
//                          FConfDcto.GetConfiguracao(Codigo,i*FConfDcto.NumLgPg*FConfDcto.NumLgFinal+(FConfDcto.NumLgFinal));
//                          ultimaposicao:=(n-1)*FConfDcto.NumLgPg
                          ultimaposicao:=FConfDcto.NumLgPg-3;
                  end else begin
//                          Result:=FConfDcto.Print(Codigo,RetornoEtqCliente,n=0,n=nn,Visualiza,ultimaposicao,'L',2,(n mod porpagina)=0);
                          if (n mod 11)=0 then begin
                             ultimaposicao:=FConfDcto.NumLgPg-3;
                             Result:=FConfDcto.Print(Codigo,RetornoEtqCliente,n=0,n=nn,Visualiza,ultimaposicao,'L',2,true);
                             FConfDcto.GetConfiguracao(Codigo,ultimaposicao,0);
                          end else begin
                             ultimaposicao:=ultimaposicao+(FConfDcto.NumLgPg );
                             Result:=FConfDcto.Print(Codigo,RetornoEtqCliente,n=0,n=nn,Visualiza,ultimaposicao,'L',2,false);
                             FConfDcto.GetConfiguracao(Codigo,ultimaposicao);
                          end;
                  end;
}
/////////////////////////////////////

//                 Result:=FConfDcto.Print(Codigo,RetornoEtqCliente,n=1,n=nn);
                  cidcli:=FCidades.GetNome(QMestrecli.fieldbyname('clie_cida_codigo_res').asinteger);
                  ufcli:=FCidades.GetUf(QMestrecli.fieldbyname('clie_cida_codigo_res').asinteger);
//                  l0:=l0+strspace('A/C'+space(18)+'('+strzero(QMestre.fieldbyname('clie_codigo').asinteger,6)+' DN:'+formatdatetime('dd/mm',QMestre.fieldbyname('clie_dtnasc').asdatetime)+')',43)+space(3);
                  l1:=l1+strspace(Uppercase(QMestrecli.fieldbyname('clie_nome').asstring),40)+space(espacosentreetq);
                  l2:=l2+strspace(QMestrecli.fieldbyname('clie_endres').asstring,40)+space(espacosentreetq);
                  l3:=l3+strspace(QMestrecli.fieldbyname('clie_bairrores').asstring+' '+QMestrecli.fieldbyname('Clie_endrescompl').asstring,40)+space(espacosentreetq);
                  l4:=l4+strspace(FGeral.formatacep(QMestrecli.fieldbyname('clie_cepres').asstring)+'-'+cidcli+'/'+ufcli,40)+space(espacosentreetq);
//                  l5:=l5+strspace(FGeral.formatacep(QMestrecli.fieldbyname('clie_cepres').asstring),40)+space(espacosentreetq);
                  if (n mod ncolunas = 0) and ( n >= ncolunas ) then begin
///////////////////////////////
//                    Ftextrel.AddLinha(l0,false,false,true );
                    Ftextrel.AddLinha(l1,false,false,true );
                    Ftextrel.AddLinha(l2,false,false,true );
                    Ftextrel.AddLinha(l3,false,false,true );
                    Ftextrel.AddLinha(l4,false,false,true );
                    Ftextrel.AddLinha(l5,false,false,true );
                    Ftextrel.SaltaLinha( linhasentreetq );

///////////////////////                    n:=0; ;; senao 'phode' o controle acima no while...
                    l0:='';l1:='';l2:='';l3:='';l4:='';l5:='';
                    if  (n mod etiquetasfolha = 0) and ( n>=etiquetasfolha ) then begin
//                      FTextRel.NovaPagina;
//                    Inc(v);
                      Ftextrel.AddLinha('Fim Página',false,false,true );
                      Ftextrel.SaltaLinha(linhainiciofolha);
                    end;

                  end;

//                 if not Result then Break;
//               end;
               QMestrecli.Next;
             end;
///////////////////////////
             if n mod ncolunas <> 0 then begin
//                    Ftextrel.AddLinha(l0,false,false,true );
                    Ftextrel.AddLinha(l1,false,false,true );
                    Ftextrel.AddLinha(l2,false,false,true );
                    Ftextrel.AddLinha(l3,false,false,true );
                    Ftextrel.AddLinha(l4,false,false,true );
                    Ftextrel.AddLinha(l5,false,false,true );
             end;

///////////////
//             if confirma('Deseja visualizar') then
               FTextRel.Video('',8);

//               FTextrel.Impr.LinPol8(false);

//             else begin
//               FTextrel.Impr.NomeImpressora:=FTextrel.Impr.PegaImpPadrao;
//               FTextRel.Print;
//               FGeral.Imprimesemvideo(5);
//             end;

// 03.01.2013 - // finaliza aqui a impressao...// 08.01.2013 - creio nao ser necessario
////////////////////////////////             Printer.EndDoc;

             Sistema.endProcess('');

          end;
       end;
    end else
      Avisoerro('Nada encontrado para impressão');
//  except
//    Avisoerro('Não foi possível imprimir');
// end;
  Sistema.EndProcess('');
  Freeandnil(QMestre);
  Freeandnil(QMestrecli);
end;


procedure TFImpressao.ConfPedidoCompra(Codigo, Descricao: String);
//////////////////////////////////////////////////////////////////
var Tit:String;
    LComandos:TStringList;
begin
  Tit:='Configuração Pedido de Compra / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
  LComandos.Add('Codigo Tipo de Movimento');
  LComandos.Add('Tipo de Movimento');
  LComandos.Add('Inscrição Estadual do emitente');
  LComandos.Add('CNPJ do emitente');
  LComandos.Add('Razão Social emitente');
  LComandos.Add('Endereço emitente');
  LComandos.Add('Bairro emitente');
  LComandos.Add('CEP emitente');
  LComandos.Add('Municipio emitente');
  LComandos.Add('UF emitente');
  LComandos.Add('Telefone emitente');

  LComandos.Add('Codigo destinatário');
  LComandos.Add('Razão Social destinatário');
  LComandos.Add('Nome Fantasia destinatário');
  LComandos.Add('CNPJ/CPF destinatário');
  LComandos.Add('Data emissão');
  LComandos.Add('Endereço destinatário');
  LComandos.Add('Bairro destinatário');
  LComandos.Add('CEP destinatário');
  LComandos.Add('Data Saída');
  LComandos.Add('Municipio destinatário');
  LComandos.Add('Telefone destinatário');
  LComandos.Add('UF destinatário');
  LComandos.Add('Inscrição Estadual do destinatário');
  LComandos.Add('Celular destinatário');
  LComandos.Add('Complemento destinatário');
  LComandos.Add('Email destinatário');

  LComandos.Add('Hora Saída');
  LComandos.Add('Numero');
  LComandos.Add('Codigo produto');
  LComandos.Add('Referência produto');
  LComandos.Add('Descrição produto');
  LComandos.Add('Descrição produto(30)');
  LComandos.Add('Descrição produto(50)');
  LComandos.Add('Unidade produto');
  LComandos.Add('Quantidade');
  LComandos.Add('Valor unitário');
  LComandos.Add('Valor unitário sem Margem');
  LComandos.Add('Valor total');
  LComandos.Add('Alíquota ICMS');
  LComandos.Add('Perc. desconto');
  LComandos.Add('Unitário bruto');
  LComandos.Add('Codigo cor');
  LComandos.Add('Descrição cor');
  LComandos.Add('Codigo tamanho');
  LComandos.Add('Descrição tamanho');
  LComandos.Add('Sequencial item');
  LComandos.Add('Qualidade');
  LComandos.Add('Peças');
  LComandos.Add('Classificação IPI(NCM)');
  LComandos.Add('Peso Total do Produto');
  LComandos.Add('Valor Peso Total do Produto');
  LComandos.Add('Valor total dos produtos');
  LComandos.Add('Valor Acréscimo/Desconto sobre Total do pedido');
  LComandos.Add('Valor Total do pedido');
  LComandos.Add('@Total Pedido');
  LComandos.Add('Total Quantidade');
  LComandos.Add('Total Peças');
  LComandos.Add('Peso Total');
  LComandos.Add('de transporte');
  LComandos.Add('a transportar');
  LComandos.Add('Codigo usuário');
  LComandos.Add('Nome usuário');
  LComandos.Add('Condição de Pagamento');
  LComandos.Add('Valor a Vista');
//  LComandos.Add('Codigo representante');
//  LComandos.Add('Nome representante');
//  LComandos.Add('Forma Envio');
  LComandos.Add('Obs-linha 01 ( 40 caracteres )');
  LComandos.Add('Obs-linha 02 ( 40 caracteres )');
  LComandos.Add('Obs-linha 03 ( 40 caracteres )');
  LComandos.Add('Obs-linha 04 ( 40 caracteres )');
  LComandos.Add('Obs-linha 05 ( 40 caracteres )');
  LComandos.Add('Obs-linha 06 ( 40 caracteres )');
  LComandos.Add('Obs-linha 07 ( 40 caracteres )');
  LComandos.Add('Obs-linha 08 ( 40 caracteres )');
  LComandos.Add('Obs-linha 09 ( 40 caracteres )');
  LComandos.Add('Pendencias');
  LComandos.Add('Forma Contato');
  LComandos.Add('Desconto tabela');
  LComandos.Add('Data Pedido cliente');
  LComandos.Add('Observações');
  LComandos.Add('Observações linha 01 ( 50 caracteres )');
  LComandos.Add('Observações linha 02 ( 50 caracteres )');
  LComandos.Add('Observações linha 03 ( 50 caracteres )');
  LComandos.Add('Observações linha 04 ( 50 caracteres )');
  LComandos.Add('Observações linha 05 ( 50 caracteres )');
  LComandos.Add('Observações linha 06 ( 50 caracteres )');
  LComandos.Add('Observações linha 08 ( 50 caracteres )');
  LComandos.Add('Observações linha 09 ( 50 caracteres )');
  LComandos.Add('Observações linha 10 ( 50 caracteres )');
  LComandos.Add('Vencimento 1');
  LComandos.Add('Parcela 1');
  LComandos.Add('Vencimento 2');
  LComandos.Add('Parcela 2');
  LComandos.Add('Vencimento 3');
  LComandos.Add('Parcela 3');
  LComandos.Add('Vencimento 4');
  LComandos.Add('Parcela 4');
{
  LComandos.Add('Codigo produto OP');
  LComandos.Add('Referência produto OP');
  LComandos.Add('Descrição produto OP');
  LComandos.Add('Descrição produto(30) OP');
  LComandos.Add('Descrição produto(50) OP');
  LComandos.Add('Unidade produto OP');
  LComandos.Add('Quantidade OP');
  LComandos.Add('Codigo cor OP');
  LComandos.Add('Descrição cor OP');
  LComandos.Add('Codigo tamanho OP');
  LComandos.Add('Descrição tamanho OP');
  LComandos.Add('Sequencial item OP');
  LComandos.Add('Peças OP' );
}
  LComandos.Add('Quantidade por peso');
  LComandos.Add('Peso do Produto')  ;
  LComandos.Add('Contato')  ;

//  LComandos.Add('Chr(xx) = Retorna Codigos ASCII');
//  LComandos.Add('[Macro] = Executa Macro-Subtituição');
  FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  LComandos.Free;

end;

procedure TFImpressao.ConfPedidoVenda(Codigo, Descricao: String);
//////////////////////////////////////////////////////////////////
var Tit:String;
    LComandos:TStringList;
begin
  Tit:='Configuração Pedido de Venda / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
  LComandos.Add('Codigo Tipo de Movimento');
  LComandos.Add('Tipo de Movimento');
  LComandos.Add('Inscrição Estadual do emitente');
  LComandos.Add('CNPJ do emitente');
  LComandos.Add('Razão Social emitente');
  LComandos.Add('Endereço emitente');
  LComandos.Add('Bairro emitente');
  LComandos.Add('CEP emitente');
  LComandos.Add('Municipio emitente');
  LComandos.Add('UF emitente');
  LComandos.Add('Telefone emitente');

  LComandos.Add('Codigo destinatário');
  LComandos.Add('Razão Social destinatário');
  LComandos.Add('Nome Fantasia destinatário');
  LComandos.Add('CNPJ/CPF destinatário');
  LComandos.Add('Data emissão');
  LComandos.Add('Endereço destinatário');
  LComandos.Add('Bairro destinatário');
  LComandos.Add('CEP destinatário');
  LComandos.Add('Data Saída');
  LComandos.Add('Municipio destinatário');
  LComandos.Add('Telefone destinatário');
  LComandos.Add('UF destinatário');
  LComandos.Add('Inscrição Estadual do destinatário');
// 25.04.14
  LComandos.Add('Celular destinatário');
  LComandos.Add('Complemento destinatário');
  LComandos.Add('Email destinatário');

  LComandos.Add('Hora Saída');
  LComandos.Add('Numero');
  LComandos.Add('Codigo produto');
  LComandos.Add('Referência produto');  // 15.07.13
  LComandos.Add('Descrição produto');
  LComandos.Add('Descrição produto(30)');
  LComandos.Add('Descrição produto(50)');
  LComandos.Add('Unidade produto');
  LComandos.Add('Quantidade');
  LComandos.Add('Valor unitário');
  LComandos.Add('Valor unitário sem Margem');
  LComandos.Add('Valor total');
  LComandos.Add('Alíquota ICMS');
  LComandos.Add('Perc. desconto');
  LComandos.Add('Unitário bruto');
  LComandos.Add('Codigo cor');
  LComandos.Add('Descrição cor');
  LComandos.Add('Codigo tamanho');
  LComandos.Add('Descrição tamanho');
// 19.06.06
  LComandos.Add('Codigo copa');
  LComandos.Add('Descrição copa');
// 13.12.05
  LComandos.Add('Sequencial item');
// 02.02.07
  LComandos.Add('Fardos');
  LComandos.Add('Pacotes');
  LComandos.Add('Cubagem');
  LComandos.Add('Medidas');
  LComandos.Add('Qualidade');
  LComandos.Add('Desconto Cubagem');
  LComandos.Add('Peças');
// 09.10.20
  LComandos.Add('Classificação IPI(NCM)');

// 21.03.12
  LComandos.Add('Peso Total do Produto');
  LComandos.Add('Valor Peso Total do Produto');
  LComandos.Add('Valor total dos produtos');
  LComandos.Add('Valor Acréscimo/Desconto sobre Total do pedido');
  LComandos.Add('Valor Total do pedido');
// 07.11.18
  LComandos.Add('@Total Pedido');
  LComandos.Add('Total Quantidade');
// 22.03.12
  LComandos.Add('Total Peças');
// 02.08.12
  LComandos.Add('Peso Total');
  LComandos.Add('de transporte');
  LComandos.Add('a transportar');
  LComandos.Add('Codigo usuário');
  LComandos.Add('Nome usuário');
  LComandos.Add('Condição de Pagamento');
  LComandos.Add('Valor a Vista');
  LComandos.Add('Codigo representante');
  LComandos.Add('Nome representante');
  LComandos.Add('Forma Envio');
  LComandos.Add('Obs-linha 01 ( 40 caracteres )');
  LComandos.Add('Obs-linha 02 ( 40 caracteres )');
  LComandos.Add('Obs-linha 03 ( 40 caracteres )');
  LComandos.Add('Obs-linha 04 ( 40 caracteres )');
  LComandos.Add('Obs-linha 05 ( 40 caracteres )');
  LComandos.Add('Obs-linha 06 ( 40 caracteres )');
  LComandos.Add('Obs-linha 07 ( 40 caracteres )');
// 13.12.05
  LComandos.Add('Obs-linha 08 ( 40 caracteres )');
  LComandos.Add('Obs-linha 09 ( 40 caracteres )');
// 21.11.05
  LComandos.Add('Pendencias');
// 25.11.05
  LComandos.Add('Forma Contato');
// 07.12.05
  LComandos.Add('Desconto tabela');
// 13.12.05
  LComandos.Add('Data Pedido cliente');
// 12.03.10
  LComandos.Add('Observações');
  LComandos.Add('Observações linha 01 ( 50 caracteres )');
  LComandos.Add('Observações linha 02 ( 50 caracteres )');
  LComandos.Add('Observações linha 03 ( 50 caracteres )');
  LComandos.Add('Observações linha 04 ( 50 caracteres )');
  LComandos.Add('Observações linha 05 ( 50 caracteres )');
  LComandos.Add('Observações linha 06 ( 50 caracteres )');
  LComandos.Add('Observações linha 07 ( 50 caracteres )');
  LComandos.Add('Observações linha 08 ( 50 caracteres )');
  LComandos.Add('Observações linha 09 ( 50 caracteres )');
  LComandos.Add('Observações linha 10 ( 50 caracteres )');
// 22.09.2022
  LComandos.Add('Observações linha 01 ( 80 caracteres )');
  LComandos.Add('Observações linha 02 ( 80 caracteres )');
  LComandos.Add('Observações linha 03 ( 80 caracteres )');
  LComandos.Add('Observações linha 04 ( 80 caracteres )');
  LComandos.Add('Observações linha 05 ( 80 caracteres )');
  LComandos.Add('Observações linha 06 ( 80 caracteres )');
  LComandos.Add('Observações linha 07 ( 80 caracteres )');
  LComandos.Add('Observações linha 08 ( 80 caracteres )');
  LComandos.Add('Observações linha 09 ( 80 caracteres )');
  LComandos.Add('Observações linha 10 ( 80 caracteres )');
  LComandos.Add('Vencimento 1');
  LComandos.Add('Parcela 1');
  LComandos.Add('Vencimento 2');
  LComandos.Add('Parcela 2');
  LComandos.Add('Vencimento 3');
  LComandos.Add('Parcela 3');
  LComandos.Add('Vencimento 4');
  LComandos.Add('Parcela 4');
// 02.11.17 - OP
  LComandos.Add('Codigo produto OP');
  LComandos.Add('Referência produto OP');
  LComandos.Add('Descrição produto OP');
  LComandos.Add('Descrição produto(30) OP');
  LComandos.Add('Descrição produto(50) OP');
  LComandos.Add('Unidade produto OP');
  LComandos.Add('Quantidade OP');
  LComandos.Add('Codigo cor OP');
  LComandos.Add('Descrição cor OP');
  LComandos.Add('Codigo tamanho OP');
  LComandos.Add('Descrição tamanho OP');
  LComandos.Add('Sequencial item OP');
  LComandos.Add('Peças OP' );
// 20.09.18
  LComandos.Add('Quantidade por peso');
  LComandos.Add('Peso do Produto')  ;
// 16.12.19
  LComandos.Add('Contato')  ;

//  LComandos.Add('Chr(xx) = Retorna Codigos ASCII');
//  LComandos.Add('[Macro] = Executa Macro-Subtituição');
  FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  LComandos.Free;
end;

////////////////////////////////////////////////////////////
function RetornoPedidoVenda(Comando,Especie:String):String;
//////////////////////////////////////////////////////////////
var Dtemissao:TDateTime;
    Valornota,TotalProdutos,Valormaisdesconto,QtdeProdutos,Baseicms,Valoricms,BaseicmsSubs,
    ValoricmsSubs,QtdePeso:Currency;
    esp,r,QtdePecas,tam:integer;
    obs,s,obs1,obs2,obs3,obs4,obs5,obs6,obs7,obs8,obs9:string;
    ListaEnter:TStringlist;

    function Tratavalor(valor:currency):string;
    /////////////////////////////////////////////
    begin
       result:='XX';
       if valor>0 then
         result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
       else begin
         if Nropaginas=1 then
           result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
         else
           result:='******,**';
       end;
    end;


///////////////////////////////////////////////////////////////
begin
///////////////////////////////////////////////////////////////
  Dtemissao:=QMestre.FieldByName('Mped_Dataemissao').AsDateTime;
  result:='';
  obs:='';
  obs1:='';obs2:='';obs3:='';obs4:='';obs5:='';obs6:='';obs7:='';obs8:='';obs9:='';
  if (NroPagina=NroPaginas) and ( Nropaginas=1) then begin;
    ValorNota:=QMestre.FieldByName('Mped_Vlrtotal').AsFloat;
    TotalProdutos:=QMestre.FieldByName('Mped_totprod').AsFloat;
    QtdeProdutos:=Tqtdetotal;
    Qtdepecas:=Tpecastotal;
    QtdePeso:=TPesototal;
    if Comando='de transporte' then result:='';
    if Comando='a transportar' then result:='';
  end else if (NroPagina<NroPaginas) and ( Nropaginas>1) then begin
    ValorNota:=0;
    TotalProdutos:=0;
    QtdeProdutos:=0;
    Qtdepecas:=0;
    QtdePeso:=0;
    if NroPagina=1 then begin
       if Comando='de transporte' then result:='';
    end else begin
      if Comando='de transporte' then result:='de transporte';
    end;
    if Comando='a transportar' then result:='a transportar';
  end else begin
    ValorNota:=QMestre.FieldByName('Mped_Vlrtotal').AsFloat;
    TotalProdutos:=QMestre.FieldByName('mped_totprod').AsFloat;
    QtdeProdutos:=Tqtdetotal;
    QtdePecas:=TPecastotal;
    QtdePeso:=TPesoTotal;
    if Comando='de transporte' then result:='de transporte';
    if Comando='a transportar' then result:='';
  end;
  if Comando='Codigo Tipo de Movimento' then Result:=QMestre.fieldbyname('Mped_tipomov').asstring;
  if Comando='Tipo de Movimento' then Result:=FGEral.GetTipoMovto(QMestre.fieldbyname('Mped_tipomov').asstring);
  if Comando='Inscrição Estadual do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_inscricaoestadual').asstring;
  if Comando='CNPJ do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cnpj').asstring;
  if Comando='Razão Social emitente' then Result:=Arq.TUnidades.fieldbyname('unid_razaosocial').asstring;
  if Comando='Endereço emitente' then Result:=Arq.TUnidades.fieldbyname('unid_endereco').asstring;
  if Comando='Bairro emitente' then Result:=Arq.TUnidades.fieldbyname('unid_bairro').asstring;
  if Comando='CEP emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cep').asstring;
  if Comando='Municipio emitente' then Result:=Arq.TUnidades.fieldbyname('unid_municipio').asstring;
  if Comando='UF emitente' then Result:=Arq.TUnidades.fieldbyname('unid_uf').asstring;
  if Comando='Telefone emitente' then Result:=FGeral.Formatatelefone(Arq.TUnidades.fieldbyname('unid_fone').asstring);

  if Comando='Data emissão' then Result:=FGeral.formatadata(QMestre.fieldbyname('mped_dataemissao').Asdatetime);
  if Comando='Data Saída' then result:=FGeral.formatadata(QMestre.fieldbyname('Mped_DataMvto').asdatetime);

    if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('clie_razaosocial').asstring else
    if Comando='Nome Fantasia destinatário' then Result:=QClientes.fieldbyname('clie_nome').asstring else
    if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('clie_cnpjcpf').asstring) else
    if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('clie_codigo').asstring else
    if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('clie_endres').asstring else
    if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('clie_bairrores').asstring else
    if Comando='CEP destinatário' then result:=QClientes.fieldbyname('clie_cepres').asstring else
    if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('clie_cida_codigo_res').asinteger) else
    if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('clie_foneres').asstring) else
    if Comando='UF destinatário' then result:=QClientes.fieldbyname('clie_uf').asstring else
    if Comando='Inscrição Estadual do destinatário' then begin
      if QClientes.fieldbyname('clie_tipo').asstring='F' then
        Result:='Isento'
      else
        result:=QClientes.fieldbyname('clie_rgie').asstring;
    end else
// 25.04.14
    if Comando='Celular destinatário'  then result:=FGeral.Formatatelefonecel(QClientes.fieldbyname('Clie_fonecel').asstring) else
    if Comando='Complemento destinatário'  then result:=QClientes.fieldbyname('Clie_endrescompl').asstring else
    if Comando='Email destinatário'  then result:=QClientes.fieldbyname('Clie_email').asstring;

  if Comando='Hora Saída' then result:=Timetostr(Time);
  if Comando='Numero' then result:=QMestre.fieldbyname('mped_numerodoc').asstring;

// dados q "se repetem"
  esp:=Inteiro(especie)-1;
  if ( esp >= 0) and (Inteiro(especie)<=ListaDetalhe.Count) then begin
    PDetalhe:=ListaDetalhe[esp];

    if Comando='Codigo produto' then result:=PDetalhe.Codigoproduto
// 15.07.13
    else if Comando='Referência produto' then result:=FEstoque.GetReferencia(PDetalhe.Codigoproduto)
    else if Comando='Descrição produto' then result:=copy(PDetalhe.Descricaoproduto,1,30)
// 04.07.06
    else if Comando='Descrição produto(30)' then result:=copy(PDetalhe.Descricaoproduto,1,30)
    else if Comando='Descrição produto(50)' then result:=copy(PDetalhe.Descricaoproduto,1,50)

    else if Comando='ST-Situação tributária' then result:=PDetalhe.Cst
    else if Comando='Unidade produto' then result:=PDetalhe.Unidade
    else if Comando='Quantidade' then result:=FGeral.Formatavalor(PDetalhe.Quantidade,FConfDcto.FormatoQtdes)
    else if Comando='Valor unitário' then result:=FGeral.Formatavalor(PDetalhe.Unitario,FConfDcto.FormatoValoresUn)
// 22.11.13
    else if Comando='Valor unitário sem Margem' then result:=FGeral.Formatavalor(PDetalhe.Unitario*((100-PDetalhe.margem)/100),FConfDcto.FormatoValoresUn)
//    else if Comando='Valor total' then result:=FGeral.Formatavalor(PDetalhe.Total,FConfDcto.FormatoValores)
// 15.07.13 - pois na Laser ficar 'desencolunado' os valor totais de cada item...
//    else if Comando='Valor total' then result:=FormatFloat(FConfDcto.FormatoValores,PDetalhe.Total)
    else if Comando='Valor total' then result:=Transform(PDetalhe.Total,FConfDcto.FormatoValores)
    else if Comando='Alíquota ICMS' then result:=FGeral.Formatavalor(PDetalhe.icms,'#0.0')
    else if Comando='Perc. desconto' then result:=FGeral.Formatavalor(PDetalhe.perdesco,FConfDcto.FormatoValores)
    else if Comando='Unitário bruto' then result:=FGeral.Formatavalor(PDetalhe.vendabru,FConfDcto.FormatoValores)
    else if Comando='Codigo cor' then result:=strzero(PDetalhe.codigocor,3)
    else if Comando='Descrição cor' then result:=PDetalhe.DescricaoCor
    else if Comando='Codigo tamanho' then result:=strzero(PDetalhe.codigotamanho,3)
    else if Comando='Descrição tamanho' then result:=PDetalhe.DescricaoTamanho
// 19.06.06
    else if Comando='Codigo copa' then result:=strzero(PDetalhe.codigocopa,3)
    else if Comando='Descrição copa' then result:=PDetalhe.DescricaoCopa
  // 13.12.05
    else if Comando='Sequencial item' then result:=strzero(PDetalhe.seq,3)
// 02.02.07
    else if Comando='Fardos' then result:=strzero(PDetalhe.fardos,4)
    else if Comando='Pacotes' then result:=strzero(PDetalhe.pacotes,4)
    else if Comando='Cubagem' then result:=FGeral.Formatavalor(PDetalhe.cubagem,f_cr3)
    else if Comando='Qualidade' then result:=PDetalhe.qualidade
    else if Comando='Medidas' then result:=PDetalhe.medidas
    else if Comando='Desconto Cubagem' then result:=FGEral.Formatavalor(PDetalhe.descubagem,f_cr)
// 02.06.11
    else if Comando='Peças' then result:=FGEral.Formatavalor(PDetalhe.pecas,FConfDcto.formatoQtdesInt)
// 09.10.20

    else if Comando='Classificação IPI(NCM)' then result:=PDetalhe.Ncmipi

// 21.03.12
    else if Comando='Peso Total do Produto' then result:=FGEral.Formatavalor(PDetalhe.pecasXqtde,f_cr)
    else if Comando='Valor Peso Total do Produto' then result:=FGEral.Formatavalor(PDetalhe.pecasXqtdeXuni,f_cr)
// 20.09.18
    else if Comando='Quantidade por peso' then begin

       if PDetalhe.PesoProduto>0 then result:=FGEral.Formatavalor(PDetalhe.quantidade/PDetalhe.PesoProduto,f_cr)
       else result:='';

    end
    else if Comando='Peso do Produto' then begin
       if PDetalhe.PesoProduto>0 then
          result:=FGEral.Formatavalor(PDetalhe.PesoProduto,f_cr)
       else
          result:='';
    end
//////
    else result:=tiraaspas(comando); // para imprimir strings colocadas no detalhe
  end;                                 ///       FConfDcto.TransformDcto(Valor,FConfDcto.FormatoValores);

  if Comando='Valor Total do pedido' then
    result:=Tratavalor(valornota)
  else if Comando='@Total Pedido' then
    result:=Tratavalor(valornota);

  if Comando='Valor total dos produtos' then
    result:=Tratavalor(totalprodutos);

  if Comando='Total Quantidade' then result:=FConfDcto.TransformDcto(Qtdeprodutos,FConfDcto.formatoQtdesInt)
  else if Comando='Total Peças' then result:=FConfDcto.TransformDcto(Qtdepecas,FConfDcto.formatoQtdesInt)
  else if Comando='Peso Total' then result:=FConfDcto.TransformDcto(Qtdepeso,FConfDcto.FormatoQtdes);

  if Comando='Valor Acréscimo/Desconto sobre Total do pedido' then begin
    if QMestre.fieldbyname('Mped_perdesco').ascurrency>0 then begin
//      result:='Desconto  : '+FConfDcto.TransformDcto( (totalprodutos)/(QMestre.fieldbyname('Moes_perdesco').ascurrency/100) ,FConfDcto.FormatoValores)
// 08.03.05
      Valormaisdesconto:=(totalprodutos)/(1-(QMestre.fieldbyname('Mped_perdesco').ascurrency/100));
      result:='Desconto  : '+FConfDcto.TransformDcto(Valormaisdesconto-totalprodutos ,FConfDcto.FormatoValores)
    end else if QMestre.fieldbyname('Mped_peracres').ascurrency>0 then begin
      result:='Acréscimo : '+FConfDcto.TransformDcto(QMestre.fieldbyname('Mped_peracres').ascurrency,FConfDcto.FormatoValores)
    end else
      result:='';
  end;
  if Comando='Codigo usuário' then result:=QMestre.fieldbyname('mped_usua_codigo').asstring
  else if Comando='Nome usuário' then result:=FUsuarios.GetNome(QMestre.fieldbyname('mped_usua_codigo').asinteger);
// 17.05.05
  if Comando='Condição de Pagamento' then result:=FCondpagto.getreduzido(condicao)
  else if Comando='Valor a Vista' then result:=FConfDcto.TransformDcto(valoravista,FConfDcto.FormatoValores);
  if Comando='Codigo representante' then result:=QMestre.fieldbyname('mped_repr_codigo').asstring;
  if Comando='Nome representante' then result:=FRepresentantes.GetDescricaoSql(QMestre.fieldbyname('mped_repr_codigo').asinteger);
// 02.11.05
  if Comando='Forma Envio' then result:=FGeral.GetFormaEnvio(QMestre.fieldbyname('mped_envio').asstring);
// 25.11.05
  if Comando='Forma Contato' then result:=FGeral.GetFormaPedido(QMestre.fieldbyname('mped_formaped').asstring);
// 16.12.19 - Benato
  if Comando='Contato' then result:=(QMestre.fieldbyname('mped_contatopedido').asstring);
  if pos('Obs-',comando)>0 then begin
    obs:=FOcorrencias.GetObservacao('C',QClientes.fieldbyname('clie_codigo').asinteger,QMestre.fieldbyname('mped_numerodoc').asinteger);
    FImpressao.Memo.Clear ;
    FImpressao.Memo.Lines.Add(obs);
    r:=0;
    while r<FImpressao.Memo.Lines.Count do begin
      if r=0 then
        obs1:=FImpressao.Memo.lines.Strings[r]
      else if r=1 then
        obs2:=FImpressao.Memo.lines.Strings[r]
      else if r=2 then
        obs3:=FImpressao.Memo.lines.Strings[r]
      else if r=3 then
        obs4:=FImpressao.Memo.lines.Strings[r]
      else if r=4 then
        obs5:=FImpressao.Memo.lines.Strings[r]
      else if r=5 then
        obs6:=FImpressao.Memo.lines.Strings[r]
      else if r=6 then
        obs7:=FImpressao.Memo.lines.Strings[r]
      else if r=7 then
        obs8:=FImpressao.Memo.lines.Strings[r]
      else
        obs9:=FImpressao.Memo.lines.Strings[r];
      inc(r);
    end;
  end;
///////////////////////////////////////////
{
    r:=1;
    ListaEnter:=TStringlist.create;
    while r <= length(obs) do begin
      s:=copy(obs,r,1);
      if s=#10 then begin
        ListaEnter.add(inttostr(r));
      end;
      inc(r);
    end;
    for r:=0 to Listaenter.count-1 do begin
        if obs1='' then
          obs1:=copy(obs,1,strtoint(listaenter[r])-1 )
        else if (obs2='') and (listaenter.count-1>=r+1) then
          obs2:=copy(obs,strtoint(listaenter[r-1])+2,strtoint(listaenter[r])-strtoint(listaenter[r-1])+3 )
        else if (obs3='') and (listaenter.count-1>=r+1) then
          obs3:=copy(obs,strtoint(listaenter[r-1])+2,strtoint(listaenter[r])-strtoint(listaenter[r-1])+3 )
        else if (obs4='') and (listaenter.count-1>=r+1) then
          obs4:=copy(obs,strtoint(listaenter[r-1])+2,strtoint(listaenter[r])-strtoint(listaenter[r-1])+3 )
    end;
    }
///////////////////////////////////////////
// 07.12.05
  if Comando='Desconto tabela' then
    result:=FTabela.GetDescAliquota(QMestre.fieldbyname('mped_tabp_codigo').asinteger);

// 30.11.05 - rever como fazer com 'os enter' - talvez tirar o memo do form de ocorrencias
/////////////////////////////////////////////  obs1:='';obs2:='';obs3:='';obs4:='';

  if Comando='Obs-linha 01 ( 40 caracteres )' then begin
    if obs1='' then
      result:=copy(obs,001,40)
    else
      result:=obs1;
  end;
  if Comando='Obs-linha 02 ( 40 caracteres )' then begin
    if obs2='' then
      result:=copy(obs,041,40)
    else
      result:=obs2;
  end;
  if Comando='Obs-linha 03 ( 40 caracteres )' then begin
    if obs3='' then
      result:=copy(obs,081,40)
    else
      result:=obs3;
  end;
  if Comando='Obs-linha 04 ( 40 caracteres )' then begin
    if obs4='' then
      result:=copy(obs,121,40)
    else
      result:=obs4;
  end;
  if Comando='Obs-linha 05 ( 40 caracteres )' then begin
    if obs5='' then
      result:=copy(obs,161,40)
    else
      result:=obs5;
  end;
  if Comando='Obs-linha 06 ( 40 caracteres )' then begin
    if obs6='' then
      result:=copy(obs,201,40)
    else
      result:=obs6;
  end;
  if Comando='Obs-linha 07 ( 40 caracteres )' then begin
    if obs7='' then
      result:=copy(obs,241,40)
    else
      result:=obs7;
  end;
  if Comando='Pendencias' then begin
    if PedidoPendente='S' then
      result:=' - Pendencias do Pedido'
    else
      result:='';
  end;
  if Comando='Obs-linha 08 ( 40 caracteres )' then begin
    if obs8='' then
      result:=copy(obs,281,40)
    else
      result:=obs8;
  end;
  if Comando='Obs-linha 09 ( 40 caracteres )' then begin
    if obs9='' then
      result:=copy(obs,321,40)
    else
      result:=obs9;
  end;
// 13.12.05
  if Comando='Data Pedido cliente' then begin
    if QMestre.fieldbyname('mped_datapedcli').asdatetime>1 then
      result:=FGeral.Formatadata(QMestre.fieldbyname('mped_datapedcli').asdatetime)
    else
      result:='';
  end;
// 12.03.10
  if Comando='Observações' then result:=QMestre.fieldbyname('mped_obspedido').asstring
// 04.02.19 - Seip
  else if Comando='Observações linha 01 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,001,50)
  else if Comando='Observações linha 02 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,051,50)
  else if Comando='Observações linha 03 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,101,50)
  else if Comando='Observações linha 04 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,151,50)
  else if Comando='Observações linha 05 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,201,50)
  else if Comando='Observações linha 06 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,251,50)
  else if Comando='Observações linha 07 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,301,50)
  else if Comando='Observações linha 08 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,351,50)
  else if Comando='Observações linha 09 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,401,50)
  else if Comando='Observações linha 10 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,451,50)
// 22.09.22 - Olstri
  else if Comando='Observações linha 01 ( 80 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,001,80)
  else if Comando='Observações linha 02 ( 80 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,081,80)
  else if Comando='Observações linha 03 ( 80 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,161,80)
  else if Comando='Observações linha 04 ( 80 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,241,80)
  else if Comando='Observações linha 05 ( 80 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,321,80)
  else if Comando='Observações linha 06 ( 80 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,401,80)
  else if Comando='Observações linha 07 ( 80 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,481,80)
  else if Comando='Observações linha 08 ( 80 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,561,80)
  else if Comando='Observações linha 09 ( 80 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,641,80)
  else if Comando='Observações linha 10 ( 80 caracteres )' then result:=copy(QMestre.fieldbyname('mped_obspedido').asstring,721,80)

  else if Comando='Vencimento 1' then result:=venc1
  else if Comando='Parcela 1' then result:=parc1
  else if Comando='Vencimento 2' then result:=venc2
  else if Comando='Parcela 2' then result:=parc2
  else if Comando='Vencimento 3' then result:=venc3
  else if Comando='Parcela 3' then result:=parc3
  else if Comando='Vencimento 4' then result:=venc4
  else if Comando='Parcela 4' then result:=parc4
// 02.11.17 - OP
  else  if Comando='Codigo produto OP' then result:=QMestreDetalhe.FieldByName('mpdd_esto_codigo').AsString
    else if Comando='Referência produto OP' then result:=FEstoque.GetReferencia(QMestreDetalhe.FieldByName('mpdd_esto_codigo').AsString)
    else if Comando='Descrição produto OP' then result:=copy(QMestreDetalhe.FieldByName('esto_descricao').AsString,1,30)
    else if Comando='Descrição produto(30) OP' then result:=copy(QMestreDetalhe.FieldByName('esto_descricao').AsString,1,30)
    else if Comando='Descrição produto(50) OP' then result:=copy(QMestreDetalhe.FieldByName('esto_descricao').AsString,1,50)
    else if Comando='Unidade produto OP' then result:=QMestreDetalhe.FieldByName('esto_unidade').AsString
    else if Comando='Quantidade OP' then result:=FGeral.Formatavalor(QMestreDetalhe.FieldByName('mpdd_qtde').AsCurrency,FConfDcto.FormatoQtdes)
    else if Comando='Codigo cor OP' then result:=strzero(QMestreDetalhe.FieldByName('mpdd_core_codigo').AsInteger,3)
    else if Comando='Descrição cor OP' then result:=QMestreDetalhe.FieldByName('mpdd_core_descricao').AsString
    else if Comando='Codigo tamanho OP' then result:=strzero(QMestreDetalhe.FieldByName('mpdd_tama_codigo').AsInteger,3)
    else if Comando='Descrição tamanho OP' then result:=QMestreDetalhe.FieldByName('mpdd_tama_descricao').AsString
    else if Comando='Sequencial item OP' then result:=strzero(QMestreDetalhe.FieldByName('mpdd_seq').AsInteger,3)
    else if Comando='Peças OP' then result:=FGEral.Formatavalor(QMestreDetalhe.FieldByName('mpdd_pecas').AsCurrency,FConfDcto.formatoQtdesInt)

// 02.02.07
    else if Comando='Fardos' then result:=strzero(PDetalhe.fardos,4)
    else if Comando='Pacotes' then result:=strzero(PDetalhe.pacotes,4)
    else if Comando='Cubagem' then result:=FGeral.Formatavalor(PDetalhe.cubagem,f_cr3)
    else if Comando='Qualidade' then result:=PDetalhe.qualidade
    else if Comando='Medidas' then result:=PDetalhe.medidas
    else if Comando='Desconto Cubagem' then result:=FGEral.Formatavalor(PDetalhe.descubagem,f_cr)
// 05.11.18
    else if Comando='Imagem Produto' then result:=Fimpressao.Geraarquivoimagem(Pdetalhe.Codigoproduto)

// 02.06.11
  else if copy(Uppercase(comando),1,5)='LINHA' then begin
    if pos('[',comando)+1=pos(']',comando)-1 then
      tam:=1
    else
      tam:=strtoint( copy(comando,pos('[',comando)+1,pos(']',comando)-pos('[',comando)-1 ) );
    result:=replicate('-',tam);
  end;

end;

// 22.06.2022 - guiber
/////////////////////////////////////////////////////////////////////////////////////////////////////
function RetornoPedidoCompra(Comando,Especie:String):String;
//////////////////////////////////////////////////////////////
var Dtemissao:TDateTime;
    Valornota,TotalProdutos,Valormaisdesconto,QtdeProdutos,Baseicms,Valoricms,BaseicmsSubs,
    ValoricmsSubs,QtdePeso:Currency;
    esp,r,QtdePecas,tam:integer;
    obs,s,obs1,obs2,obs3,obs4,obs5,obs6,obs7,obs8,obs9:string;
    ListaEnter:TStringlist;

    function Tratavalor(valor:currency):string;
    /////////////////////////////////////////////
    begin
       result:='XX';
       if valor>0 then
         result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
       else begin
         if Nropaginas=1 then
           result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
         else
           result:='******,**';
       end;
    end;


///////////////////////////////////////////////////////////////
begin
///////////////////////////////////////////////////////////////
  Dtemissao:=QMestre.FieldByName('Mocm_Datamvto').AsDateTime;
  result:='';
  obs:='';
  obs1:='';obs2:='';obs3:='';obs4:='';obs5:='';obs6:='';obs7:='';obs8:='';obs9:='';
  if (NroPagina=NroPaginas) and ( Nropaginas=1) then begin;
    ValorNota:=QMestre.FieldByName('Mocm_Vlrtotal').AsFloat;
    TotalProdutos:=QMestre.FieldByName('Mocm_totprod').AsFloat;
    QtdeProdutos:=Tqtdetotal;
    Qtdepecas:=Tpecastotal;
    QtdePeso:=TPesototal;
    if Comando='de transporte' then result:='';
    if Comando='a transportar' then result:='';
  end else if (NroPagina<NroPaginas) and ( Nropaginas>1) then begin
    ValorNota:=0;
    TotalProdutos:=0;
    QtdeProdutos:=0;
    Qtdepecas:=0;
    QtdePeso:=0;
    if NroPagina=1 then begin
       if Comando='de transporte' then result:='';
    end else begin
      if Comando='de transporte' then result:='de transporte';
    end;
    if Comando='a transportar' then result:='a transportar';
  end else begin
    ValorNota:=QMestre.FieldByName('Mocm_Vlrtotal').AsFloat;
    TotalProdutos:=QMestre.FieldByName('mocm_totprod').AsFloat;
    QtdeProdutos:=Tqtdetotal;
    QtdePecas:=TPecastotal;
    QtdePeso:=TPesoTotal;
    if Comando='de transporte' then result:='de transporte';
    if Comando='a transportar' then result:='';
  end;
  if Comando='Codigo Tipo de Movimento' then Result:=QMestre.fieldbyname('Mocm_tipomov').asstring;
  if Comando='Tipo de Movimento' then Result:=FGEral.GetTipoMovto(QMestre.fieldbyname('Mocm_tipomov').asstring);
  if Comando='Inscrição Estadual do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_inscricaoestadual').asstring;
  if Comando='CNPJ do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cnpj').asstring;
  if Comando='Razão Social emitente' then Result:=Arq.TUnidades.fieldbyname('unid_razaosocial').asstring;
  if Comando='Endereço emitente' then Result:=Arq.TUnidades.fieldbyname('unid_endereco').asstring;
  if Comando='Bairro emitente' then Result:=Arq.TUnidades.fieldbyname('unid_bairro').asstring;
  if Comando='CEP emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cep').asstring;
  if Comando='Municipio emitente' then Result:=Arq.TUnidades.fieldbyname('unid_municipio').asstring;
  if Comando='UF emitente' then Result:=Arq.TUnidades.fieldbyname('unid_uf').asstring;
  if Comando='Telefone emitente' then Result:=FGeral.Formatatelefone(Arq.TUnidades.fieldbyname('unid_fone').asstring);

  if Comando='Data emissão' then Result:=FGeral.formatadata(QMestre.fieldbyname('mocm_datamvto').Asdatetime);
  if Comando='Data Saída' then result:=FGeral.formatadata(QMestre.fieldbyname('Mocm_DataMvto').asdatetime);

    if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('forn_razaosocial').asstring else
    if Comando='Nome Fantasia destinatário' then Result:=QClientes.fieldbyname('forn_nome').asstring else
    if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('forn_cnpjcpf').asstring) else
    if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('forn_codigo').asstring else
    if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('forn_endereco').asstring else
    if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('forn_bairro').asstring else
    if Comando='CEP destinatário' then result:=QClientes.fieldbyname('forn_cep').asstring else
    if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('forn_cida_codigo').asinteger) else
    if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('forn_fone').asstring) else
    if Comando='UF destinatário' then result:=QClientes.fieldbyname('forn_uf').asstring else
    if Comando='Inscrição Estadual do destinatário' then begin
      if QClientes.fieldbyname('forn_contribuinte').asstring='N' then
        Result:=''
      else
        result:=QClientes.fieldbyname('Forn_inscricaoestadual').asstring;
    end else
    if Comando='Celular destinatário'  then result:=FGeral.Formatatelefonecel(QClientes.fieldbyname('forn_fax').asstring) else
//    if Comando='Complemento destinatário'  then result:=QClientes.fieldbyname('Clie_endrescompl').asstring else
    if Comando='Email destinatário'  then result:=QClientes.fieldbyname('forn_email').asstring;

  if Comando='Hora Saída' then result:=Timetostr(Time);
  if Comando='Numero' then result:=QMestre.fieldbyname('mocm_numerodoc').asstring;

// dados q "se repetem"
  esp:=Inteiro(especie)-1;
  if ( esp >= 0) and (Inteiro(especie)<=ListaDetalhe.Count) then begin
    PDetalhe:=ListaDetalhe[esp];

    if Comando='Codigo produto' then result:=PDetalhe.Codigoproduto
    else if Comando='Referência produto' then result:=FEstoque.GetReferencia(PDetalhe.Codigoproduto)
    else if Comando='Descrição produto' then result:=copy(PDetalhe.Descricaoproduto,1,30)
    else if Comando='Descrição produto(30)' then result:=copy(PDetalhe.Descricaoproduto,1,30)
    else if Comando='Descrição produto(50)' then result:=copy(PDetalhe.Descricaoproduto,1,50)
    else if Comando='ST-Situação tributária' then result:=PDetalhe.Cst
    else if Comando='Unidade produto' then result:=PDetalhe.Unidade
    else if Comando='Quantidade' then result:=FGeral.Formatavalor(PDetalhe.Quantidade,FConfDcto.FormatoQtdes)
    else if Comando='Valor unitário' then result:=FGeral.Formatavalor(PDetalhe.Unitario,FConfDcto.FormatoValoresUn)
    else if Comando='Valor unitário sem Margem' then result:=FGeral.Formatavalor(PDetalhe.Unitario*((100-PDetalhe.margem)/100),FConfDcto.FormatoValoresUn)
    else if Comando='Valor total' then result:=Transform(PDetalhe.Total,FConfDcto.FormatoValores)
    else if Comando='Alíquota ICMS' then result:=FGeral.Formatavalor(PDetalhe.icms,'#0.0')
    else if Comando='Perc. desconto' then result:=FGeral.Formatavalor(PDetalhe.perdesco,FConfDcto.FormatoValores)
    else if Comando='Unitário bruto' then result:=FGeral.Formatavalor(PDetalhe.vendabru,FConfDcto.FormatoValores)
    else if Comando='Codigo cor' then result:=strzero(PDetalhe.codigocor,3)
    else if Comando='Descrição cor' then result:=PDetalhe.DescricaoCor
    else if Comando='Codigo tamanho' then result:=strzero(PDetalhe.codigotamanho,3)
    else if Comando='Descrição tamanho' then result:=PDetalhe.DescricaoTamanho
    else if Comando='Codigo copa' then result:=strzero(PDetalhe.codigocopa,3)
    else if Comando='Descrição copa' then result:=PDetalhe.DescricaoCopa
    else if Comando='Sequencial item' then result:=strzero(PDetalhe.seq,3)
{
    else if Comando='Fardos' then result:=strzero(PDetalhe.fardos,4)
    else if Comando='Pacotes' then result:=strzero(PDetalhe.pacotes,4)
    else if Comando='Cubagem' then result:=FGeral.Formatavalor(PDetalhe.cubagem,f_cr3)
    else if Comando='Qualidade' then result:=PDetalhe.qualidade
    else if Comando='Medidas' then result:=PDetalhe.medidas
    else if Comando='Desconto Cubagem' then result:=FGEral.Formatavalor(PDetalhe.descubagem,f_cr)
}
    else if Comando='Peças' then result:=FGEral.Formatavalor(PDetalhe.pecas,FConfDcto.formatoQtdesInt)

    else if Comando='Classificação IPI(NCM)' then result:=PDetalhe.Ncmipi

    else if Comando='Peso Total do Produto' then result:=FGEral.Formatavalor(PDetalhe.pecasXqtde,f_cr)
    else if Comando='Valor Peso Total do Produto' then result:=FGEral.Formatavalor(PDetalhe.pecasXqtdeXuni,f_cr)
    else if Comando='Quantidade por peso' then begin

       if PDetalhe.PesoProduto>0 then result:=FGEral.Formatavalor(PDetalhe.quantidade/PDetalhe.PesoProduto,f_cr)
       else result:='';

    end
    else if Comando='Peso do Produto' then begin
       if PDetalhe.PesoProduto>0 then
          result:=FGEral.Formatavalor(PDetalhe.PesoProduto,f_cr)
       else
          result:='';
    end
//////
    else result:=tiraaspas(comando); // para imprimir strings colocadas no detalhe
  end;                                 ///       FConfDcto.TransformDcto(Valor,FConfDcto.FormatoValores);

  if Comando='Valor Total do pedido' then
    result:=Tratavalor(valornota)
  else if Comando='@Total Pedido' then
    result:=Tratavalor(valornota);

  if Comando='Valor total dos produtos' then
    result:=Tratavalor(totalprodutos);

  if Comando='Total Quantidade' then result:=FConfDcto.TransformDcto(Qtdeprodutos,FConfDcto.formatoQtdesInt)
  else if Comando='Total Peças' then result:=FConfDcto.TransformDcto(Qtdepecas,FConfDcto.formatoQtdesInt)
  else if Comando='Peso Total' then result:=FConfDcto.TransformDcto(Qtdepeso,FConfDcto.FormatoQtdes);
{ // em pedido de compra não tem acrescimo ou descontos...ver se será preciso...
  if Comando='Valor Acréscimo/Desconto sobre Total do pedido' then begin
    if QMestre.fieldbyname('Mocm_perdesco').ascurrency>0 then begin
//      result:='Desconto  : '+FConfDcto.TransformDcto( (totalprodutos)/(QMestre.fieldbyname('Moes_perdesco').ascurrency/100) ,FConfDcto.FormatoValores)
// 08.03.05
      Valormaisdesconto:=(totalprodutos)/(1-(QMestre.fieldbyname('Mped_perdesco').ascurrency/100));
      result:='Desconto  : '+FConfDcto.TransformDcto(Valormaisdesconto-totalprodutos ,FConfDcto.FormatoValores)
    end else if QMestre.fieldbyname('Mped_peracres').ascurrency>0 then begin
      result:='Acréscimo : '+FConfDcto.TransformDcto(QMestre.fieldbyname('Mped_peracres').ascurrency,FConfDcto.FormatoValores)
    end else
      result:='';
  end;
  }
  if Comando='Codigo usuário' then result:=QMestre.fieldbyname('mocm_usua_codigo').asstring
  else if Comando='Nome usuário' then result:=FUsuarios.GetNome(QMestre.fieldbyname('mocm_usua_codigo').asinteger);
  if Comando='Condição de Pagamento' then result:=FCondpagto.getreduzido(condicao)
  else if Comando='Valor a Vista' then result:=FConfDcto.TransformDcto(valoravista,FConfDcto.FormatoValores);
{
  if Comando='Codigo representante' then result:=QMestre.fieldbyname('mped_repr_codigo').asstring;
  if Comando='Nome representante' then result:=FRepresentantes.GetDescricaoSql(QMestre.fieldbyname('mped_repr_codigo').asinteger);
}
  if Comando='Forma Envio' then result:=FGeral.GetFormaEnvio(QMestre.fieldbyname('mocm_formaentrega').asstring);
//  if Comando='Forma Contato' then result:=FGeral.GetFormaPedido(QMestre.fieldbyname('mped_formaped').asstring);
//  if Comando='Contato' then result:=FGeral.GetFormaPedido(QMestre.fieldbyname('mped_contatopedido').asstring);

{ -- ver se terá ocorrencias para pedido de compra
  if pos('Obs-',comando)>0 then begin
    obs:=FOcorrencias.GetObservacao('C',QClientes.fieldbyname('clie_codigo').asinteger,QMestre.fieldbyname('mped_numerodoc').asinteger);
    FImpressao.Memo.Clear ;
    FImpressao.Memo.Lines.Add(obs);
    r:=0;
    while r<FImpressao.Memo.Lines.Count do begin
      if r=0 then
        obs1:=FImpressao.Memo.lines.Strings[r]
      else if r=1 then
        obs2:=FImpressao.Memo.lines.Strings[r]
      else if r=2 then
        obs3:=FImpressao.Memo.lines.Strings[r]
      else if r=3 then
        obs4:=FImpressao.Memo.lines.Strings[r]
      else if r=4 then
        obs5:=FImpressao.Memo.lines.Strings[r]
      else if r=5 then
        obs6:=FImpressao.Memo.lines.Strings[r]
      else if r=6 then
        obs7:=FImpressao.Memo.lines.Strings[r]
      else if r=7 then
        obs8:=FImpressao.Memo.lines.Strings[r]
      else
        obs9:=FImpressao.Memo.lines.Strings[r];
      inc(r);
    end;
  end;
  }

  if Comando='Desconto tabela' then
    result:=FTabela.GetDescAliquota(QMestre.fieldbyname('mocm_tabp_codigo').asinteger);


  if Comando='Obs-linha 01 ( 40 caracteres )' then begin
    if obs1='' then
      result:=copy(obs,001,40)
    else
      result:=obs1;
  end;
  if Comando='Obs-linha 02 ( 40 caracteres )' then begin
    if obs2='' then
      result:=copy(obs,041,40)
    else
      result:=obs2;
  end;
  if Comando='Obs-linha 03 ( 40 caracteres )' then begin
    if obs3='' then
      result:=copy(obs,081,40)
    else
      result:=obs3;
  end;
  if Comando='Obs-linha 04 ( 40 caracteres )' then begin
    if obs4='' then
      result:=copy(obs,121,40)
    else
      result:=obs4;
  end;
  if Comando='Obs-linha 05 ( 40 caracteres )' then begin
    if obs5='' then
      result:=copy(obs,161,40)
    else
      result:=obs5;
  end;
  if Comando='Obs-linha 06 ( 40 caracteres )' then begin
    if obs6='' then
      result:=copy(obs,201,40)
    else
      result:=obs6;
  end;
  if Comando='Obs-linha 07 ( 40 caracteres )' then begin
    if obs7='' then
      result:=copy(obs,241,40)
    else
      result:=obs7;
  end;
  if Comando='Pendencias' then begin
    if PedidoPendente='S' then
      result:=' - Pendencias do Pedido'
    else
      result:='';
  end;
  if Comando='Obs-linha 08 ( 40 caracteres )' then begin
    if obs8='' then
      result:=copy(obs,281,40)
    else
      result:=obs8;
  end;
  if Comando='Obs-linha 09 ( 40 caracteres )' then begin
    if obs9='' then
      result:=copy(obs,321,40)
    else
      result:=obs9;
  end;
{
  if Comando='Data Pedido cliente' then begin
    if QMestre.fieldbyname('mped_datapedcli').asdatetime>1 then
      result:=FGeral.Formatadata(QMestre.fieldbyname('mped_datapedcli').asdatetime)
    else
      result:='';
  end;
  }
  if Comando='Observações' then result:=QMestre.fieldbyname('mocm_obspedido').asstring
  else if Comando='Observações linha 01 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mocm_obspedido').asstring,001,50)
  else if Comando='Observações linha 02 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mocm_obspedido').asstring,051,50)
  else if Comando='Observações linha 03 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mocm_obspedido').asstring,092,50)
  else if Comando='Observações linha 04 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mocm_obspedido').asstring,133,50)
  else if Comando='Observações linha 05 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mocm_obspedido').asstring,174,50)
  else if Comando='Observações linha 06 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mocm_obspedido').asstring,215,50)
  else if Comando='Observações linha 08 ( 50 caracteres )' then result:=copy(QMestre.fieldbyname('mocm_obspedido').asstring,256,50)
  else if Comando='Observações linha 09 ( 50 caracteres )' then result:=''
  else if Comando='Observações linha 10 ( 50 caracteres )' then result:=''

  else if Comando='Vencimento 1' then result:=venc1
  else if Comando='Parcela 1' then result:=parc1
  else if Comando='Vencimento 2' then result:=venc2
  else if Comando='Parcela 2' then result:=parc2
  else if Comando='Vencimento 3' then result:=venc3
  else if Comando='Parcela 3' then result:=parc3
  else if Comando='Vencimento 4' then result:=venc4
  else if Comando='Parcela 4' then result:=parc4
 {
  else  if Comando='Codigo produto OP' then result:=QMestreDetalhe.FieldByName('mpdd_esto_codigo').AsString
    else if Comando='Referência produto OP' then result:=FEstoque.GetReferencia(QMestreDetalhe.FieldByName('mpdd_esto_codigo').AsString)
    else if Comando='Descrição produto OP' then result:=copy(QMestreDetalhe.FieldByName('esto_descricao').AsString,1,30)
    else if Comando='Descrição produto(30) OP' then result:=copy(QMestreDetalhe.FieldByName('esto_descricao').AsString,1,30)
    else if Comando='Descrição produto(50) OP' then result:=copy(QMestreDetalhe.FieldByName('esto_descricao').AsString,1,50)
    else if Comando='Unidade produto OP' then result:=QMestreDetalhe.FieldByName('esto_unidade').AsString
    else if Comando='Quantidade OP' then result:=FGeral.Formatavalor(QMestreDetalhe.FieldByName('mpdd_qtde').AsCurrency,FConfDcto.FormatoQtdes)
    else if Comando='Codigo cor OP' then result:=strzero(QMestreDetalhe.FieldByName('mpdd_core_codigo').AsInteger,3)
    else if Comando='Descrição cor OP' then result:=QMestreDetalhe.FieldByName('mpdd_core_descricao').AsString
    else if Comando='Codigo tamanho OP' then result:=strzero(QMestreDetalhe.FieldByName('mpdd_tama_codigo').AsInteger,3)
    else if Comando='Descrição tamanho OP' then result:=QMestreDetalhe.FieldByName('mpdd_tama_descricao').AsString
    else if Comando='Sequencial item OP' then result:=strzero(QMestreDetalhe.FieldByName('mpdd_seq').AsInteger,3)
    else if Comando='Peças OP' then result:=FGEral.Formatavalor(QMestreDetalhe.FieldByName('mpdd_pecas').AsCurrency,FConfDcto.formatoQtdesInt)
}
{
    else if Comando='Fardos' then result:=strzero(PDetalhe.fardos,4)
    else if Comando='Pacotes' then result:=strzero(PDetalhe.pacotes,4)
    else if Comando='Cubagem' then result:=FGeral.Formatavalor(PDetalhe.cubagem,f_cr3)
    else if Comando='Qualidade' then result:=PDetalhe.qualidade
    else if Comando='Medidas' then result:=PDetalhe.medidas
    else if Comando='Desconto Cubagem' then result:=FGEral.Formatavalor(PDetalhe.descubagem,f_cr)
}
    else if Comando='Imagem Produto' then result:=Fimpressao.Geraarquivoimagem(Pdetalhe.Codigoproduto)

  else if copy(Uppercase(comando),1,5)='LINHA' then begin
    if pos('[',comando)+1=pos(']',comando)-1 then
      tam:=1
    else
      tam:=strtoint( copy(comando,pos('[',comando)+1,pos(']',comando)-pos('[',comando)-1 ) );
    result:=replicate('-',tam);
  end;

end;

// 22.06.2022 - guiber
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TFImpressao.ImprimePedidoCompra(Nota: Integer; DataMvto: TDatetime;
         Unidade, SemValor, xTipoMov: string): Boolean;

var n,nn,itenspedido,nitensped :Integer;
    FormaImpressao,Codigo,sqltipomovm,sqltipomovd,CodigoU:String;
    valortotal,
    Tvalortotal,
    xcopias      :currency;
    sepergunta   : boolean;


    function PreencherDadosArquivo(const NomeArquivo: string): Boolean;
    /////////////////////////////////////////////////////////////////////
    var
      WordApp,
      XFind     : Variant;
      Documento: Olevariant;
      xcomando,
      tipodocword,
      varq  :string;
      p,
      i,
      n : byte;
      ListaProdutos  :TStringList;

    begin

      if not FileExists( NomeArquivo ) then begin
        Avisoerro('Arquivo '+NomeArquivo+' não encontrado');
        exit;
      end;

      WordApp:= CreateOleObject('Word.Application');
      tipodocword:='Application';


      try

        if tipodocword='Basic' then  begin
        WordApp.FileOpen( NOmearquivo );

        end else begin

          WordApp.Visible := False;
          Documento := WordApp.Documents.Open(NomeArquivo);

        end;


        ConfNotaSaida('999','');

        ListaProdutos:=TStringList.Create;
        ListaProdutos.add('Codigo produto');
        ListaProdutos.add('Referência produto');
        ListaProdutos.add('Descrição produto');
        ListaProdutos.add('Descrição produto(30)');
        ListaProdutos.add('Descrição produto(50)');
        ListaProdutos.add('Unidade produto');
        ListaProdutos.add('Quantidade');
        ListaProdutos.add('Valor unitário');
        ListaProdutos.add('Valor unitário sem Margem');
        ListaProdutos.add('Valor total');
        ListaProdutos.add('Alíquota ICMS');
        ListaProdutos.add('Perc. desconto');
        ListaProdutos.add('Unitário bruto');
        ListaProdutos.add('Codigo cor');
        ListaProdutos.add('Descrição cor');
        ListaProdutos.add('Codigo tamanho');
        ListaProdutos.add('Descrição tamanho');
        ListaProdutos.add('Sequencial item');
        ListaProdutos.add('Desconto Cubagem');
        ListaProdutos.add('Peças');
        ListaProdutos.add('Peso Total do Produto');
        ListaProdutos.add('Valor Peso Total do Produto');
        ListaProdutos.add('Quantidade por peso');
        ListaProdutos.add('Imagem Produto');

        for p:=0 to ListaComandos.count-1 do begin

             xcomando:=ListaComandos[p];

                if tipodocword='Basic' then begin
                   WordApp.Find.Execute(FindText := xcomando , ReplaceWith := RetornoPedidoCompra(xcomando,''))
                end else
                   Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoPedidoCompra(xcomando,''));

        end;

        varq:=ExtractFilePath(Application.ExeName)+ '0006.jpg';

        i:=1;
        for n := 0 to ListaDetalhe.Count-1 do begin


            for p:=0 to ListaProdutos.count-1 do begin

              xcomando:=ListaProdutos[p];
              if xcomando = '!!@@Imagem Produto' then begin

//                Documento.InsertPicture( ExtractFilePath(Application.ExeName)+ '0005.jpg' )
 //                WordApp.InsertPicture( ExtractFilePath(Application.ExeName)+ '0005.jpg' )
                                                        ////                                fmessa
                    wordapp.Selection.EndKey(unit :=wdStory) ;
//                    wordapp.Selection.InlineShapes.AddPicture( varq, False, True, '' )
                    wordapp.Selection.InlineShapes.AddPicture( varq  )

//                  WordApp.Selection.InlineShapes.AddPicture(
//                            ExtractFilePath(Application.ExeName)+ '0005.jpg', False, True, '' )
//Shape := WordApplication1.Selection.InlineShapes.AddPicture(
//FileName2, LinkToFile, SaveWithDocument, EmptyParam);

              end else begin

                if tipodocword='Basic' then
                   WordApp.Find.Execute(FindText := xcomando , ReplaceWith := RetornoPedidoCompra(xcomando,inttostr(i)))
                else
                   Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoPedidoCompra(xcomando,inttostr(i)));

              end;

              if xcomando = 'Valor total' then
                   inc(i);

            end;

        end;

/////////////////        EXIT;


// 'limpando' o texto das variaveis dos produtos não utilizados
        for n := 0 to 30 do begin

              xcomando:='Quantidade';
              Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := '' );
              xcomando:='Descrição produto';
              Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := '' );
              xcomando:='Valor unitário';
              Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := '' );
              xcomando:='Valor total';
              Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := '' );


        end;

        if tipodocword='Basic' then begin

          WordApp.AppShow;
          WordApp.FileSaveAs( ExtractFilePath( Application.ExeName ) + 'PEDIDOCOMPRA'+QMestre.fieldbyname('clie_nome').asstring+'.docx',0);

        end else begin

          WordApp.Visible := True;
          Documento.SaveAs( ExtractFilePath( Application.ExeName ) + 'PEDIDOCOMPRA'+QMestre.fieldbyname('clie_nome').asstring+'.docx');
          Documento.close;
          Documento := WordApp.Documents.Open( ExtractFilePath( Application.ExeName ) + 'PEDIDOCOMPRA'+QMestre.fieldbyname('clie_nome').asstring+'.docx');

        end;


      finally
         ListaProdutos.Free;
      end;

    end;




    procedure Envia_Impressora;
    ///////////////////////////
    var count,countgeral,i:integer;
    begin
      NroPagina:=1;
      NroPaginas:=1;

      if FConfdcto.NumLgPg>0 then begin

        if Listadetalhe.count mod FConfdcto.NumLgPg = 0 then
          count:= Listadetalhe.count div FConfdcto.NumLgPg
        else
          count:= Listadetalhe.count div FConfdcto.NumLgPg + 1;
        if count=0 then  //  15.08.05 - credito de chu peças sem itens
          count:=1;
      end else

        count:=1;

      NroPaginas:=count;
      for i:=1 to count do begin

        NroPagina:=i;
        if QMestre.FieldByName('mocm_tipomov').AsString=Global.CodOrcamento then begin

           if FileExists( ExtractFilePath( Application.ExeName )+'PedidoCompra.doc') then

              PreencherDadosArquivo( ExtractFilePath( Application.ExeName )+'PedidoCompra.doc')

           else if FileExists( ExtractFilePath( Application.ExeName )+'PedidoCompra.docx') then

              PreencherDadosArquivo( ExtractFilePath( Application.ExeName )+'PedidoCompra.docx')

           else

              FConfDcto.Print(Codigo, RetornoPedidoCompra, i = 1, i = count);

        end else
           FConfDcto.Print(Codigo, RetornoPedidoCompra, i = 1, i = count);

        if count>1 then
          FConfDcto.GetConfiguracao(Codigo);
      end;

    end;

begin
//////////////////////////////////////
  Result:=True;
  sqltipomovm:='';
    sqltipomovd:=' and moco_tipomov='+stringtosql(xtipomov);
  if not Arq.TUnidades.active then Arq.TUnidades.Open;
  try
    QMestre:=sqltoquery('select *,forn_nome as clie_nome from movcomp '+
                     ' left join fornecedores on ( forn_codigo=mocm_tipo_codigo )'+
                     ' where mocm_numerodoc='+inttostr(Nota)+
                     ' and mocm_datamvto='+Datetosql(Datamvto)+
                     sqltipomovm+
                     ' and '+Fgeral.getin('mocm_status','N;B','C')+
                     ' order by mocm_numerodoc' );

    if not QMestre.Eof then begin
      if Semvalor='S' then
        Codigo:=FGeral.GetConfig1AsString('Pedidosempreco')
      else if Semvalor='C' then
        Codigo:=FGeral.GetConfig1AsString('Pedidocomcusto')
      else if Semvalor='V' then
        Codigo:=FGeral.GetConfig1AsString('Pedidoviaemail')
      else
        Codigo:=FGeral.GetConfig1AsString('Imprpedidocom');

// mpressao do pedido de venda 'automatico' cfe o numero de itens configurado - Patopapel
      itenspedido:=FGeral.GetConfig1asinteger('itenspedido');
// Codigo Impresso Pedido de Venda por usuario
      CodigoU:=FUsuarios.GetImpressoPedidoVenda(Global.Usuario.Codigo);
      if trim(codigou)<>'' then codigo:=codigou;
//////////////////////
      if trim(codigo)='' then begin
         Avisoerro('Falta configurar o codigo deste impresso na configuração geral aba impressos');
         QMestre.close;
         Freeandnil(QMestre);
         exit;
      end;
      Arq.TUnidades.locate('unid_codigo',unidade,[]);
      npar:=0;
      parc1:='';parc2:='';parc3:='';parc4:='';parc5:='';parc6:='';
      venc1:='';venc2:='';venc3:='';venc4:='';venc5:='';venc6:='';
      condicao:=QMestre.fieldbyname('mocm_fpgt_codigo').asstring;
      if ( FCondpagto.GetAvPz(condicao)='V' ) then
        valoravista:=QMestre.fieldbyname('mocm_vlrtotal').ascurrency
      else
        valoravista:=0;
      QPendencia:=sqltoquery('select * from pendencias where pend_transacao='+stringtosql(QMestre.fieldbyname('mocm_Transacao').AsString)+
                            ' and pend_status<>''C'' and pend_unid_codigo='+stringtosql(unidade)+
                            ' order by pend_datavcto');
      if not QPendencia.eof then begin
        npar:=1;
        while not QPendencia.eof do begin
          if npar=1 then begin
             if (valoravista>0) and (valoravista<>QPendencia.fieldbyname('pend_valor').ascurrency) then begin
               venc1:='a Vista ';
               parc1:=formatfloat(FConfDcto.FormatoValores,valoravista);
               venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
//               parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,'###,###.##')
//               parc2:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('pend_valor').ascurrency);
             end else begin
               venc1:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
//             parc1:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
// 01.07.05 - algumas notas com parte a vista e a prazo não imprimiam o valor da primeira parcela somente o vencimento
               parc1:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('pend_valor').ascurrency);
             end;
          end else if npar=2 then begin
             if valoravista=0 then begin

//               parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores);
// 06.02.19
               parc2:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('pend_valor').ascurrency);
               venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);

             end else begin
               parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores);
               venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             end;
          end else if npar=3 then begin
             if valoravista=0 then begin
               venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end else begin
               venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end;
          end else if npar=4 then begin
             if valoravista=0 then begin
               venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end else begin
               venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end;
          end else if npar=5 then begin
             venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=6 then begin
             venc6:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc6:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end;
          inc(npar);
          QPendencia.Next;
        end;
      end else begin   // se for toda a vista
        QPendencia.close;
        QPendencia:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(QMestre.fieldbyname('mocm_Transacao').AsString)+
                               ' and movf_status<>''C''');
        if not QPendencia.eof then begin
           venc1:='a Vista ';
           parc1:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('movf_valorger').ascurrency);
        end;
      end;

      nitensped:=0;
      if itenspedido>0 then begin
         QDetalhe:=sqltoquery('select * from movcompras '+
                     ' left join estoque on (esto_codigo=moco_esto_codigo)'+
                     ' left  join cores on (moco_core_codigo=core_codigo)'+
                     ' left  join tamanhos on (moco_tama_codigo=tama_codigo)'+
                     ' left  join copas on (moco_copa_codigo=copa_codigo)'+
                     ' left join grupos on (grup_codigo=esto_grup_codigo)'+
                     ' where mpdd_transacao='''+QMestre.fieldbyname('mocm_transacao').asstring+''''+
                     ' and '+FGeral.GetIN('moco_status','N;B','C')+
                     sqltipomovd+
                     ' and moco_numerodoc='+QMestre.fieldbyname('mocm_numerodoc').asstring+
                     ' order by moco_seq' );

        while not QDetalhe.eof do begin
          inc(nitensped);
          QDetalhe.Next;
        end;

        FGeral.FechaQuery(QDetalhe);
//        if nitensped>itenspedido then codigo:=FGeral.GetConfig1AsString('Pedidosempreco')

      end;

      Result:=FConfDcto.GetConfiguracao(Codigo);
      if ( Global.topicos[1428] ) and  (FConfDcto.TpImpressora<>'V' )   then begin

         xcopias := 1;
         FGEral.Getvalor(xcopias,'Cópias');
         FConfDcto.numcopias := trunc(xcopias);

      end;

      QClientes:=sqltoquery('select * from fornecedores where forn_codigo='+QMestre.fieldbyname('mocm_tipo_codigo').asstring);
//      QClientes.Name:='QClientes';

{
      if Global.Topicos[1420] then

               QMestreDetalhe:=sqltoquery('select * from movcompras '+
                     ' left join estoque on (esto_codigo=moco_esto_codigo)'+
                     ' left  join cores on (moco_core_codigo=core_codigo)'+
                     ' left  join tamanhos on (moco_tama_codigo=tama_codigo)'+
                     ' left  join grupos on (grup_codigo=esto_grup_codigo)'+
                     ' where moco_transacao='''+QMestre.fieldbyname('mocm_transacao').asstring+''''+
                     ' and '+FGeral.GetIN('moco_status','N;B','C')+
                     ' and moco_tipomov = ''OS'''+
                     ' and moco_numerodoc='+QMestre.fieldbyname('mocm_numerodoc').asstring+
                     ' order by moco_seq' )
      else

                QMestreDetalhe:=nil;
}

      FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
      if  Global.Usuario.OutrosAcessos[0519] then
         sepergunta:=true
      else if Semvalor='V' then
         sepergunta:=true
      else
         sepergunta :=  Confirma('Confirma a impressão ?');

       if (FormaImpressao='2') or ((FormaImpressao='1') and ( sepergunta )) then begin

          if Result then begin

             if Semvalor <> 'V' then
               Sistema.BeginProcess('imprimindo pedido de compra');

             nn:=0;
             QMestre.First;

             while not QMestre.Eof do begin
               Inc(nn);
               QMestre.Next;
             end;

             QMestre.First;
             n:=0;
             while not QMestre.Eof do begin
               Inc(n);
// detalhes q se repetem
               QDetalhe:=sqltoquery('select * from movcompras '+
                     ' left join estoque on (esto_codigo=moco_esto_codigo)'+
                     ' left  join cores on (moco_core_codigo=core_codigo)'+
                     ' left  join tamanhos on (moco_tama_codigo=tama_codigo)'+
                     ' left  join copas on (moco_copa_codigo=copa_codigo)'+
                     ' left join grupos on (grup_codigo=esto_grup_codigo)'+
                     ' left join codigosipi on (cipi_codigo=esto_cipi_codigo)'+
                     ' where moco_transacao='''+QMestre.fieldbyname('mocm_transacao').asstring+''''+
                     ' and '+FGeral.GetIN('moco_status','N;B','C')+
                     sqltipomovd+
                     ' and moco_numerodoc='+QMestre.fieldbyname('mocm_numerodoc').asstring+
                     ' order by moco_seq' );
               ListaDetalhe := TList.Create;valortotal:=0;TValortotal:=0;TQtdetotal:=0;Tpecastotal:=0;
               TPesoTotal:=0;
               if Qdetalhe.eof then
                 Avisoerro('Iten(s) não encontrados ou não cadastrados no estoque');

               PedidoPendente:='N';

               while not QDetalhe.Eof do begin

                 New(PDetalhe);
                 PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('Moco_esto_codigo').AsString;
                 PDetalhe.Descricaoproduto:=Qdetalhe.fieldbyname('esto_descricao').Asstring;
                 if ProdutoGenerico( Qdetalhe.fieldbyname('Moco_esto_codigo').AsString  ) then
                    PDetalhe.Descricaoproduto:=Qdetalhe.fieldbyname('moco_esto_descricao').Asstring;

                 PDetalhe.Cst:='';
                 PDetalhe.Unidade:=Qdetalhe.fieldbyname('Esto_unidade').Asstring;
                 PDetalhe.Quantidade:=Qdetalhe.fieldbyname('moco_qtde').Ascurrency;
                 PDetalhe.TQuantidade:=PDetalhe.TQuantidade+Qdetalhe.fieldbyname('moco_qtde').AsCurrency;
                 PDetalhe.Unitario:=Qdetalhe.fieldbyname('moco_unitario').AsCurrency;
                 if QDetalhe.fieldbyname('moco_tipomov').asstring='PV' then
                   PDetalhe.Margem:=(Qdetalhe.fieldbyname('grup_markup').AsCurrency)
                 else
                   PDetalhe.Margem:=(Qdetalhe.fieldbyname('grup_margem').AsCurrency);
                 valortotal:=(Qdetalhe.fieldbyname('moco_unitario').AsCurrency*Qdetalhe.fieldbyname('moco_qtde').AsCurrency);
                 PDetalhe.Total:=valortotal;
                 PDetalhe.icms:=0;
                 PDetalhe.perdesco:=0;
                 PDetalhe.vendabru:=Qdetalhe.fieldbyname('moco_unitario').AsCurrency;
                 PDetalhe.Codigocor:=Qdetalhe.fieldbyname('moco_core_codigo').AsInteger;
                 PDetalhe.DescricaoCor:=copy( Qdetalhe.fieldbyname('core_descricao').Asstring,1,10 );
                 PDetalhe.CodigoTamanho:=Qdetalhe.fieldbyname('moco_tama_codigo').AsInteger;
                 PDetalhe.DescricaoTamanho:=copy( Qdetalhe.fieldbyname('tama_descricao').Asstring,1,10 );
                 PDetalhe.Seq:=Qdetalhe.fieldbyname('moco_seq').Asinteger;
                 PDetalhe.Codigocopa:=Qdetalhe.fieldbyname('moco_copa_codigo').AsInteger;
                 PDetalhe.DescricaoCopa:=Qdetalhe.fieldbyname('copa_descricao').Asstring;
{
                 PDetalhe.Fardos:=Qdetalhe.fieldbyname('mpdd_fardos').Asinteger;
                 PDetalhe.Pacotes:=Qdetalhe.fieldbyname('mpdd_pacotes').Asinteger;
                 PDetalhe.Cubagem:=Qdetalhe.fieldbyname('mpdd_cubagem').AsFloat;
                 PDetalhe.Qualidade:=Qdetalhe.fieldbyname('mpdd_qualidade').AsString;
                 PDetalhe.Medidas:=FTamanhos.GetMedidas(QDetalhe.fieldbyname('mpdd_tama_codigo').asinteger);
                 PDetalhe.descubagem:=Qdetalhe.fieldbyname('mpdd_perdescre').Ascurrency;
}
                 PDetalhe.PesoProduto:=Qdetalhe.fieldbyname('Esto_peso').Ascurrency;
                 PDetalhe.Ncmipi:=QDetalhe.fieldbyname('cipi_codfiscal').asstring;

                   ListaDetalhe.Add(Pdetalhe);
                   Tvalortotal:=Tvalortotal+valortotal;
                   TQtdetotal:=TQtdetotal+Qdetalhe.fieldbyname('moco_qtde').Ascurrency;
                   TPecastotal:=TPecastotal+Qdetalhe.fieldbyname('moco_pecas').AsInteger;
//                 if Qdetalhe.fieldbyname('moco_qtdeenviada').ascurrency>0 then
//                   PedidoPendente:='S';
                 PDetalhe.pecas:=Qdetalhe.fieldbyname('moco_pecas').ascurrency;
                 PDetalhe.pecasXqtde:=Qdetalhe.fieldbyname('moco_qtde').Ascurrency*Qdetalhe.fieldbyname('moco_pecas').ascurrency;
                 TPesototal:=TPesototal+PDetalhe.pecasXqtde;
                 PDetalhe.pecasXqtdeXuni:=FGeral.Arredonda( Qdetalhe.fieldbyname('moco_qtde').Ascurrency*
                                          Qdetalhe.fieldbyname('moco_pecas').ascurrency*
                                          Qdetalhe.fieldbyname('moco_unitario').AsCurrency,2);
// 1evereda - mostrar o 'retorno' - ver se vai usar aqui no pedido de compras
//////////////////////////////////////////////
{
                 if (Global.Usuario.OutrosAcessos[0335]) and  (Qdetalhe.fieldbyname('mpdd_qtdeenviada').AsCurrency>0)
                   and ( Qdetalhe.fieldbyname('mpdd_situacao').asstring='B' )    // 08.01.15
                   then begin
                   New(PDetalhe);
                   PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('Mpdd_esto_codigo').AsString;
                   PDetalhe.Descricaoproduto:='Retorno';
                   PDetalhe.Cst:='';
                   PDetalhe.Unidade:=Qdetalhe.fieldbyname('Esto_unidade').Asstring;
                   PDetalhe.Quantidade:=Qdetalhe.fieldbyname('mpdd_qtdeenviada').Ascurrency;
                   PDetalhe.TQuantidade:=PDetalhe.TQuantidade-Qdetalhe.fieldbyname('mpdd_qtdeenviada').AsCurrency;
                   PDetalhe.Unitario:=Qdetalhe.fieldbyname('mpdd_venda').AsCurrency;
                   if QDetalhe.fieldbyname('mpdd_tipomov').asstring='PV' then
                     PDetalhe.Margem:=(Qdetalhe.fieldbyname('grup_markup').AsCurrency)
                   else
                     PDetalhe.Margem:=(Qdetalhe.fieldbyname('grup_margem').AsCurrency);
                   valortotal:=(-1)*FGeral.Arredonda(Qdetalhe.fieldbyname('mpdd_venda').AsCurrency*Qdetalhe.fieldbyname('mpdd_qtdeenviada').AsCurrency,2);
                   PDetalhe.Total:=valortotal;
                   PDetalhe.icms:=0;
                   PDetalhe.perdesco:=Qdetalhe.fieldbyname('mpdd_perdesco').AsCurrency;
                   PDetalhe.vendabru:=Qdetalhe.fieldbyname('mpdd_vendabru').AsCurrency;
                   PDetalhe.Codigocor:=Qdetalhe.fieldbyname('mpdd_core_codigo').AsInteger;
                   PDetalhe.DescricaoCor:=copy( Qdetalhe.fieldbyname('core_descricao').Asstring,1,10 );
                   PDetalhe.CodigoTamanho:=Qdetalhe.fieldbyname('mpdd_tama_codigo').AsInteger;
                   PDetalhe.DescricaoTamanho:=copy( Qdetalhe.fieldbyname('tama_descricao').Asstring,1,10 );
                   PDetalhe.Seq:=Qdetalhe.fieldbyname('mpdd_seq').Asinteger;
                   PDetalhe.Codigocopa:=Qdetalhe.fieldbyname('mpdd_copa_codigo').AsInteger;
                   PDetalhe.DescricaoCopa:=Qdetalhe.fieldbyname('copa_descricao').Asstring;
                   PDetalhe.Fardos:=Qdetalhe.fieldbyname('mpdd_fardos').Asinteger;
                   PDetalhe.Pacotes:=Qdetalhe.fieldbyname('mpdd_pacotes').Asinteger;
                   PDetalhe.Cubagem:=Qdetalhe.fieldbyname('mpdd_cubagem').AsFloat;
                   PDetalhe.Qualidade:=Qdetalhe.fieldbyname('mpdd_qualidade').AsString;
                   PDetalhe.Medidas:=FTamanhos.GetMedidas(QDetalhe.fieldbyname('mpdd_tama_codigo').asinteger);
                   PDetalhe.descubagem:=Qdetalhe.fieldbyname('mpdd_perdescre').Ascurrency;
                   ListaDetalhe.Add(Pdetalhe);
                   Tvalortotal:=Tvalortotal+valortotal;
                   TQtdetotal:=TQtdetotal-Qdetalhe.fieldbyname('mpdd_qtdeenviada').Ascurrency;
//                     TPecastotal:=TPecastotal+Qdetalhe.fieldbyname('mpdd_pecas').AsInteger;
                   PDetalhe.pecas:=Qdetalhe.fieldbyname('mpdd_pecas').ascurrency;
                   PDetalhe.pecasXqtde:=Qdetalhe.fieldbyname('mpdd_qtdeenviada').Ascurrency*Qdetalhe.fieldbyname('mpdd_pecas').ascurrency;

                   TPesototal:=TPesototal-PDetalhe.pecasXqtde;
                   PDetalhe.pecasXqtdeXuni:=FGeral.Arredonda( Qdetalhe.fieldbyname('mpdd_qtdeenviada').Ascurrency*
                                            Qdetalhe.fieldbyname('mpdd_pecas').ascurrency*
                                            Qdetalhe.fieldbyname('mpdd_venda').AsCurrency,2);
                 end;
///////////////////////////////////////////////
}
                 QDetalhe.Next;
               end;

               if (not QDetalhe.IsEmpty)  then begin
                  Envia_Impressora;

               end;  // QDetalhe.isempty

               QDetalhe.Close;
               Freeandnil(QDetalhe);
               Listadetalhe.Free;
               QMestre.Next;
             end;
             if Semvalor <> 'V' then
                Sistema.EndProcess('');

          end;
       end;
       Qclientes.close;
       Freeandnil(Qclientes);
       QPendencia.close;
       Freeandnil(QPendencia);

    end else begin

      Avisoerro('Pedido de Compra '+inttostr(Nota)+' de '+Datetostr(Datamvto)+' não encontrado.');

    end;

    QMestre.Close;
    Freeandnil(QMestre);
    if QDetalhe<>nil then
       Freeandnil(QDetalhe);

  except on E: Exception do

    begin
      FGeral.FechaQuery(QMestre);
      Freeandnil(QMestre);
      FGeral.FechaQuery(QClientes);
      Freeandnil(QClientes);
      Avisoerro( E.message );
    end;

  end;

  Sistema.EndProcess('');
end;

function TFImpressao.ImprimePedidoVenda(Nota: Integer; DataMvto: TDatetime;  Unidade: string;SemValor:string='N';xTipoMov:string='PV'): Boolean;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var n,nn,itenspedido,nitensped :Integer;
    FormaImpressao,Codigo,sqltipomovm,sqltipomovd,CodigoU:String;
    valortotal,
    Tvalortotal,
    xcopias      :currency;
    sepergunta   : boolean;


// 01.11.18
    function PreencherDadosArquivo(const NomeArquivo: string): Boolean;
    /////////////////////////////////////////////////////////////////////
    var
      WordApp,
      XFind     : Variant;
      Documento: Olevariant;
      xcomando,
      tipodocword,
      varq  :string;
      p,
      i,
      n : byte;
      ListaProdutos  :TStringList;

    begin

      if not FileExists( NomeArquivo ) then begin
        Avisoerro('Arquivo '+NomeArquivo+' não encontrado');
        exit;
      end;

      WordApp:= CreateOleObject('Word.Application');
      tipodocword:='Application';

//      WordApp:= CreateOleObject('Word.Basic');
//      tipodocword:='Basic';

      try

        if tipodocword='Basic' then  begin
//        WordApp.AppShow;
        WordApp.FileOpen( NOmearquivo );

        end else begin

          WordApp.Visible := False;
          Documento := WordApp.Documents.Open(NomeArquivo);

        end;


        ConfNotaSaida('999','');

        ListaProdutos:=TStringList.Create;
        ListaProdutos.add('Codigo produto');
        ListaProdutos.add('Referência produto');
        ListaProdutos.add('Descrição produto');
        ListaProdutos.add('Descrição produto(30)');
        ListaProdutos.add('Descrição produto(50)');
        ListaProdutos.add('Unidade produto');
        ListaProdutos.add('Quantidade');
        ListaProdutos.add('Valor unitário');
        ListaProdutos.add('Valor unitário sem Margem');
        ListaProdutos.add('Valor total');
        ListaProdutos.add('Alíquota ICMS');
        ListaProdutos.add('Perc. desconto');
        ListaProdutos.add('Unitário bruto');
        ListaProdutos.add('Codigo cor');
        ListaProdutos.add('Descrição cor');
        ListaProdutos.add('Codigo tamanho');
        ListaProdutos.add('Descrição tamanho');
        ListaProdutos.add('Sequencial item');
        ListaProdutos.add('Desconto Cubagem');
        ListaProdutos.add('Peças');
        ListaProdutos.add('Peso Total do Produto');
        ListaProdutos.add('Valor Peso Total do Produto');
        ListaProdutos.add('Quantidade por peso');
        ListaProdutos.add('Imagem Produto');

        for p:=0 to ListaComandos.count-1 do begin

             xcomando:=ListaComandos[p];
    //          if (xcomando='Descrição produto') or (xcomando='Quantidade') or (xcomando='Valor Unitário') or (xcomando='Unidade produto') then
//              if ListaProdutos.indexof(xcomando)>=0 then begin

//                Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoPedidoVenda(xcomando,inttostr(i)));
//                if xcomando = 'Valor total' then
//                   inc(i);
//
//              end else

                if tipodocword='Basic' then begin
                   WordApp.Find.Execute(FindText := xcomando , ReplaceWith := RetornoPedidoVenda(xcomando,''))
                end else
                   Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoPedidoVenda(xcomando,''));

        end;

        varq:=ExtractFilePath(Application.ExeName)+ '0005.jpg';

        i:=1;
        for n := 0 to ListaDetalhe.Count-1 do begin


            for p:=0 to ListaProdutos.count-1 do begin

              xcomando:=ListaProdutos[p];
              if xcomando = '!!@@Imagem Produto' then begin

//                Documento.InsertPicture( ExtractFilePath(Application.ExeName)+ '0005.jpg' )
 //                WordApp.InsertPicture( ExtractFilePath(Application.ExeName)+ '0005.jpg' )
                                                        ////                                fmessa
                    wordapp.Selection.EndKey(unit :=wdStory) ;
//                    wordapp.Selection.InlineShapes.AddPicture( varq, False, True, '' )
                    wordapp.Selection.InlineShapes.AddPicture( varq  )

//                  WordApp.Selection.InlineShapes.AddPicture(
//                            ExtractFilePath(Application.ExeName)+ '0005.jpg', False, True, '' )
//Shape := WordApplication1.Selection.InlineShapes.AddPicture(
//FileName2, LinkToFile, SaveWithDocument, EmptyParam);

              end else begin

                if tipodocword='Basic' then
                   WordApp.Find.Execute(FindText := xcomando , ReplaceWith := RetornoPedidoVenda(xcomando,inttostr(i)))
                else
                   Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoPedidoVenda(xcomando,inttostr(i)));

              end;

              if xcomando = 'Valor total' then
                   inc(i);

            end;

        end;

/////////////////        EXIT;


// 'limpando' o texto das variaveis dos produtos não utilizados
        for n := 0 to 30 do begin

              xcomando:='Quantidade';
              Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := '' );
              xcomando:='Descrição produto';
              Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := '' );
              xcomando:='Valor unitário';
              Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := '' );
              xcomando:='Valor total';
              Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := '' );


        end;

        if tipodocword='Basic' then begin

          WordApp.AppShow;
          WordApp.FileSaveAs( ExtractFilePath( Application.ExeName ) + 'ORCAMENTO'+QMestre.fieldbyname('clie_nome').asstring+'.docx',0);

        end else begin

          WordApp.Visible := True;
          Documento.SaveAs( ExtractFilePath( Application.ExeName ) + 'ORCAMENTO'+QMestre.fieldbyname('clie_nome').asstring+'.docx');
          Documento.close;
          Documento := WordApp.Documents.Open( ExtractFilePath( Application.ExeName ) + 'ORCAMENTO'+QMestre.fieldbyname('clie_nome').asstring+'.docx');

        end;

//        if pos('Indica',FConfDcto.Impressora) = 0 then begin
//          if Printer.Printers.IndexOf(FConfDcto.Impressora) <> -1 then
//             Printer.PrinterIndex := Printer.Printers.IndexOf(FConfDcto.Impressora);
//        end;
//
//          Printer.SetPrinter() FConfDcto.SetImpressora(FConfDcto.Impressora);

//        for p := 0 to FConfDcto.NumCopias-1 do Documento.PrintOut(false);
// desta forma a impressora se perde....
//        Documento.PrintOut(false);

//        Documento.PrintOut(copies := FConfDcto.NumCopias );

//        Documento.close;
//        Documento.open;

      finally
//        WordApp.Quit;
         ListaProdutos.Free;
//        end;
 //       DeleteFile( ExtractFilePath( Application.ExeName ) + 'ORCAMENTO'+QMestre.fieldbyname('clie_nome').asstring+'.docx');
      end;

    end;




    procedure Envia_Impressora;
    ///////////////////////////
    var count,countgeral,i:integer;
    begin
      NroPagina:=1;
      NroPaginas:=1;

      if FConfdcto.NumLgPg>0 then begin

        if Listadetalhe.count mod FConfdcto.NumLgPg = 0 then
          count:= Listadetalhe.count div FConfdcto.NumLgPg
        else
          count:= Listadetalhe.count div FConfdcto.NumLgPg + 1;
        if count=0 then  //  15.08.05 - credito de chu peças sem itens
          count:=1;
      end else

        count:=1;

      NroPaginas:=count;
      for i:=1 to count do begin

        NroPagina:=i;
        if QMestre.FieldByName('mped_tipomov').AsString=Global.CodOrcamento then begin

           if FileExists( ExtractFilePath( Application.ExeName )+'Orcamento.doc') then

              PreencherDadosArquivo( ExtractFilePath( Application.ExeName )+'Orcamento.doc')

// 15.06.20
           else if FileExists( ExtractFilePath( Application.ExeName )+'Orcamento.docx') then

              PreencherDadosArquivo( ExtractFilePath( Application.ExeName )+'Orcamento.docx')

           else

              FConfDcto.Print(Codigo, RetornoPedidoVenda, i = 1, i = count);

        end else
           FConfDcto.Print(Codigo, RetornoPedidoVenda, i = 1, i = count);

// 03.11.15
//        FConfDcto.Print(Codigo, RetornoPedidoVenda, i = 1, i = count+1);
//        FConfDcto.GetConfiguracao(Codigo,(i*FConfdcto.NumLgPg+1));
//        if count>1 then
//          FConfDcto.GetConfiguracao(Codigo,(i*FConfdcto.NumLgPg));
        if count>1 then
          FConfDcto.GetConfiguracao(Codigo);
      end;

// 03.11.15
//      FConfDcto.Print(Codigo, RetornoPedidoVenda, i = 1, i = count);

    end;

begin
//////////////////////////////////////
  Result:=True;
  sqltipomovm:='';
//    sqltipomovm:=' and mped_tipomov='+stringtosql(tipomov);
// 01.11.17
    sqltipomovd:=' and mpdd_tipomov='+stringtosql(xtipomov);
//  campo:=Sistema.GetDicionario('movpeddet','mpdd_pecas');
//21.03.12 -retirado esta checagem
  if not Arq.TUnidades.active then Arq.TUnidades.Open;
  try
    QMestre:=sqltoquery('select *,clie_nome from movped '+
                     ' left join clientes on ( clie_codigo=mped_tipo_codigo )'+
                     ' where mped_numerodoc='+inttostr(Nota)+
//                     ' and moes_datamvto='+Datetosql(Datamvto)+
// 11.02.05 - reges viadinho fez nota com emissao retroativa e nao disse....horas em cima ate descobrir...
                     ' and mped_dataemissao='+Datetosql(Datamvto)+
//                     ' and mped_unid_codigo='''+unidade+''''+
                     sqltipomovm+
                     ' and '+Fgeral.getin('mped_status','N;B','C')+
                     ' order by mped_numerodoc' );
  //  if Qmestre.Name='' then
  //    QMestre.Name:='QMestre';
  // retirado 'qmestre' 01.11.2021

    if not QMestre.Eof then begin
// 29.04.09
      if Semvalor='S' then
        Codigo:=FGeral.GetConfig1AsString('Pedidosempreco')
// 22.11.13
      else if Semvalor='C' then
        Codigo:=FGeral.GetConfig1AsString('Pedidocomcusto')
// 12.06.20
      else if Semvalor='V' then
        Codigo:=FGeral.GetConfig1AsString('Pedidoviaemail')
      else
        Codigo:=FGeral.GetConfig1AsString('Imprpedidoven');

// 19.10.15 - impressao do pedido de venda 'automatico' cfe o numero de itens configurado - Patopapel
      itenspedido:=FGeral.GetConfig1asinteger('itenspedido');
// 27.08.12 - Codigo Impresso Pedido de Venda por usuario
      CodigoU:=FUsuarios.GetImpressoPedidoVenda(Global.Usuario.Codigo);
      if trim(codigou)<>'' then codigo:=codigou;
//////////////////////
      if trim(codigo)='' then begin
         Avisoerro('Falta configurar o codigo deste impresso na configuração geral aba impressos');
         QMestre.close;
         Freeandnil(QMestre);
         exit;
      end;
      Arq.TUnidades.locate('unid_codigo',unidade,[]);
      npar:=0;
      parc1:='';parc2:='';parc3:='';parc4:='';parc5:='';parc6:='';
      venc1:='';venc2:='';venc3:='';venc4:='';venc5:='';venc6:='';
      condicao:=QMestre.fieldbyname('mped_fpgt_codigo').asstring;
      if ( FCondpagto.GetAvPz(condicao)='V' ) then
        valoravista:=QMestre.fieldbyname('mped_vlrtotal').ascurrency
      else
        valoravista:=0;
// 12.03.10
      QPendencia:=sqltoquery('select * from pendencias where pend_transacao='+stringtosql(QMestre.fieldbyname('mped_Transacao').AsString)+
                            ' and pend_status<>''C'' and pend_unid_codigo='+stringtosql(unidade)+
                            ' order by pend_datavcto');
      if not QPendencia.eof then begin
        npar:=1;
//        condicao:=QPendencia.fieldbyname('pend_fpgt_codigo').asstring;
        while not QPendencia.eof do begin
          if npar=1 then begin
// 01.07.05
             if (valoravista>0) and (valoravista<>QPendencia.fieldbyname('pend_valor').ascurrency) then begin
               venc1:='a Vista ';
               parc1:=formatfloat(FConfDcto.FormatoValores,valoravista);
               venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
//               parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,'###,###.##')
//               parc2:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('pend_valor').ascurrency);
             end else begin
               venc1:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
//             parc1:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
// 01.07.05 - algumas notas com parte a vista e a prazo não imprimiam o valor da primeira parcela somente o vencimento
               parc1:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('pend_valor').ascurrency);
             end;
          end else if npar=2 then begin
             if valoravista=0 then begin

//               parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores);
// 06.02.19
               parc2:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('pend_valor').ascurrency);
               venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);

             end else begin
               parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores);
               venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             end;
          end else if npar=3 then begin
             if valoravista=0 then begin
               venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end else begin
               venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end;
          end else if npar=4 then begin
             if valoravista=0 then begin
               venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end else begin
               venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end;
          end else if npar=5 then begin
             venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=6 then begin
             venc6:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc6:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end;
          inc(npar);
          QPendencia.Next;
        end;
      end else begin   // se for toda a vista
        QPendencia.close;
        QPendencia:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(QMestre.fieldbyname('mped_Transacao').AsString)+
                               ' and movf_status<>''C''');
        if not QPendencia.eof then begin
           venc1:='a Vista ';
           parc1:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('movf_valorger').ascurrency);
        end;
      end;

// 19.10.15 - para contar quantos itens tem no pedido/os
      nitensped:=0;
      if itenspedido>0 then begin
         QDetalhe:=sqltoquery('select * from movpeddet '+
                     ' left join estoque on (esto_codigo=mpdd_esto_codigo)'+
                     ' left  join cores on (mpdd_core_codigo=core_codigo)'+
                     ' left  join tamanhos on (mpdd_tama_codigo=tama_codigo)'+
                     ' left  join copas on (mpdd_copa_codigo=copa_codigo)'+
                     ' left join grupos on (grup_codigo=esto_grup_codigo)'+
                     ' where mpdd_transacao='''+QMestre.fieldbyname('mped_transacao').asstring+''''+
                     ' and '+FGeral.GetIN('mpdd_status','N;B','C')+
                     sqltipomovd+
                     ' and mpdd_numerodoc='+QMestre.fieldbyname('mped_numerodoc').asstring+
                     ' order by mpdd_seq' );

        while not QDetalhe.eof do begin
          inc(nitensped);
          QDetalhe.Next;
        end;

        FGeral.FechaQuery(QDetalhe);
        if nitensped>itenspedido then codigo:=FGeral.GetConfig1AsString('Pedidosempreco')

      end;

// 10.08.05
      Result:=FConfDcto.GetConfiguracao(Codigo);
// 15.06.20
      if ( Global.topicos[1428] ) and  (FConfDcto.TpImpressora<>'V' )   then begin

         xcopias := 1;
         FGEral.Getvalor(xcopias,'Cópias');
         FConfDcto.numcopias := trunc(xcopias);

      end;

      QClientes:=sqltoquery('select * from clientes where clie_codigo='+QMestre.fieldbyname('mped_tipo_codigo').asstring);
      QClientes.Name:='QClientes';

// 02.11.17
      if Global.Topicos[1420] then

               QMestreDetalhe:=sqltoquery('select * from movpeddet '+
                     ' left join estoque on (esto_codigo=mpdd_esto_codigo)'+
                     ' left  join cores on (mpdd_core_codigo=core_codigo)'+
                     ' left  join tamanhos on (mpdd_tama_codigo=tama_codigo)'+
                     ' left  join grupos on (grup_codigo=esto_grup_codigo)'+
                     ' where mpdd_transacao='''+QMestre.fieldbyname('mped_transacao').asstring+''''+
                     ' and '+FGeral.GetIN('mpdd_status','N;B','C')+
                     ' and mpdd_tipomov = ''OS'''+
                     ' and mpdd_numerodoc='+QMestre.fieldbyname('mped_numerodoc').asstring+
                     ' order by mpdd_seq' )
      else

                QMestreDetalhe:=nil;


      FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
// 10.03.20
      if  Global.Usuario.OutrosAcessos[0519] then
         sepergunta:=true
// 15.06.20 - para nao pedir se quer imprimir na visualização/geração de pdf
      else if Semvalor='V' then
         sepergunta:=true
// 27.10.2021 - Pequim ativar depois q 'ajeitar tudo'
      else if FGeral.GetConfig1AsString('balmonitora') = 'S' then
         sepergunta:=true

      else
         sepergunta :=  Confirma('Confirma a impressão ?');

       if (FormaImpressao='2') or ((FormaImpressao='1') and ( sepergunta )) then begin

          if Result then begin

             if Semvalor <> 'V' then
               Sistema.BeginProcess('imprimindo pedido de venda');

             nn:=0;
             QMestre.First;

             while not QMestre.Eof do begin
               Inc(nn);
               QMestre.Next;
             end;

             QMestre.First;
             n:=0;
             while not QMestre.Eof do begin
               Inc(n);
// detalhes q se repetem
               QDetalhe:=sqltoquery('select * from movpeddet '+
                     ' left join estoque on (esto_codigo=mpdd_esto_codigo)'+
                     ' left  join cores on (mpdd_core_codigo=core_codigo)'+
                     ' left  join tamanhos on (mpdd_tama_codigo=tama_codigo)'+
                     ' left  join copas on (mpdd_copa_codigo=copa_codigo)'+
                     ' left join grupos on (grup_codigo=esto_grup_codigo)'+
// 09.10.20
                     ' left join codigosipi on (cipi_codigo=esto_cipi_codigo)'+
                     ' where mpdd_transacao='''+QMestre.fieldbyname('mped_transacao').asstring+''''+
                     ' and '+FGeral.GetIN('mpdd_status','N;B','C')+
                     sqltipomovd+
                     ' and mpdd_numerodoc='+QMestre.fieldbyname('mped_numerodoc').asstring+
                     ' order by mpdd_seq' );   // 10.11.05
//                     ' order by mpdd_operacao' );
               ListaDetalhe := TList.Create;valortotal:=0;TValortotal:=0;TQtdetotal:=0;Tpecastotal:=0;
               TPesoTotal:=0;
               if Qdetalhe.eof then  // 01.07.05
                 Avisoerro('Iten(s) não encontrados ou não cadastrados no estoque');

               PedidoPendente:='N';

               while not QDetalhe.Eof do begin
                 New(PDetalhe);
//                 if ListaDetalhe.count=0 then
// 23.02.05 - cada vez imprimia um total no total de qtde
//                 if Tvalortotal=0 then
//                   PDetalhe.TQuantidade:=0;
                 PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('Mpdd_esto_codigo').AsString;

                 PDetalhe.Descricaoproduto:=Qdetalhe.fieldbyname('esto_descricao').Asstring;
// 21.02.20
                 if ProdutoGenerico( Qdetalhe.fieldbyname('Mpdd_esto_codigo').AsString  ) then
                    PDetalhe.Descricaoproduto:=Qdetalhe.fieldbyname('mpdd_esto_descricao').Asstring;

                 PDetalhe.Cst:='';
                 PDetalhe.Unidade:=Qdetalhe.fieldbyname('Esto_unidade').Asstring;
                 PDetalhe.Quantidade:=Qdetalhe.fieldbyname('mpdd_qtde').Ascurrency;
                 PDetalhe.TQuantidade:=PDetalhe.TQuantidade+Qdetalhe.fieldbyname('mpdd_qtde').AsCurrency;
                 PDetalhe.Unitario:=Qdetalhe.fieldbyname('mpdd_venda').AsCurrency;
                 if QDetalhe.fieldbyname('mpdd_tipomov').asstring='PV' then
                   PDetalhe.Margem:=(Qdetalhe.fieldbyname('grup_markup').AsCurrency)
                 else
                   PDetalhe.Margem:=(Qdetalhe.fieldbyname('grup_margem').AsCurrency);
//                 valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('mpdd_venda').AsCurrency*Qdetalhe.fieldbyname('mpdd_qtde').AsCurrency,2);
// 12.08.14 - Benato = -1 x 50 deu -49,99.....
                 valortotal:=(Qdetalhe.fieldbyname('mpdd_venda').AsCurrency*Qdetalhe.fieldbyname('mpdd_qtde').AsCurrency);
                 PDetalhe.Total:=valortotal;
                 PDetalhe.icms:=0;
                 PDetalhe.perdesco:=Qdetalhe.fieldbyname('mpdd_perdesco').AsCurrency;
                 PDetalhe.vendabru:=Qdetalhe.fieldbyname('mpdd_vendabru').AsCurrency;
// 02.11.05
                 PDetalhe.Codigocor:=Qdetalhe.fieldbyname('mpdd_core_codigo').AsInteger;
//                 PDetalhe.DescricaoCor:=Qdetalhe.fieldbyname('core_descricao').Asstring;
// 19.06.06
                 PDetalhe.DescricaoCor:=copy( Qdetalhe.fieldbyname('core_descricao').Asstring,1,10 );
                 PDetalhe.CodigoTamanho:=Qdetalhe.fieldbyname('mpdd_tama_codigo').AsInteger;
//                 PDetalhe.DescricaoTamanho:=Qdetalhe.fieldbyname('tama_descricao').Asstring;
// 19.06.06
                 PDetalhe.DescricaoTamanho:=copy( Qdetalhe.fieldbyname('tama_descricao').Asstring,1,10 );
// 16.12.05
                 PDetalhe.Seq:=Qdetalhe.fieldbyname('mpdd_seq').Asinteger;
// 19.06.06
                 PDetalhe.Codigocopa:=Qdetalhe.fieldbyname('mpdd_copa_codigo').AsInteger;
                 PDetalhe.DescricaoCopa:=Qdetalhe.fieldbyname('copa_descricao').Asstring;
// 02.02.07
                 PDetalhe.Fardos:=Qdetalhe.fieldbyname('mpdd_fardos').Asinteger;
                 PDetalhe.Pacotes:=Qdetalhe.fieldbyname('mpdd_pacotes').Asinteger;
                 PDetalhe.Cubagem:=Qdetalhe.fieldbyname('mpdd_cubagem').AsFloat;
                 PDetalhe.Qualidade:=Qdetalhe.fieldbyname('mpdd_qualidade').AsString;
                 PDetalhe.Medidas:=FTamanhos.GetMedidas(QDetalhe.fieldbyname('mpdd_tama_codigo').asinteger);
                 PDetalhe.descubagem:=Qdetalhe.fieldbyname('mpdd_perdescre').Ascurrency;
// 20.09.18
                 PDetalhe.PesoProduto:=Qdetalhe.fieldbyname('Esto_peso').Ascurrency;
// 09.10.20 - Guiber
                 PDetalhe.Ncmipi:=QDetalhe.fieldbyname('cipi_codfiscal').asstring;

// 21.11.05 - imprimir somente pendentes - 22.11.13 - Metalforte - imprimir sempre todos
//                 if Qdetalhe.fieldbyname('mpdd_qtde').Ascurrency>Qdetalhe.fieldbyname('mpdd_qtdeenviada').ascurrency then begin
                   ListaDetalhe.Add(Pdetalhe);
                   Tvalortotal:=Tvalortotal+valortotal;
                   TQtdetotal:=TQtdetotal+Qdetalhe.fieldbyname('mpdd_qtde').Ascurrency;
// 22.03.2012
                   TPecastotal:=TPecastotal+Qdetalhe.fieldbyname('mpdd_pecas').AsInteger;
//                 end;
                 if Qdetalhe.fieldbyname('mpdd_qtdeenviada').ascurrency>0 then
                   PedidoPendente:='S';
// 02.06.11
//                 PDetalhe.pecas:=0;
//                 if campo.Tipo<>'' then  // 21.03.12
                   PDetalhe.pecas:=Qdetalhe.fieldbyname('mpdd_pecas').ascurrency;
                 PDetalhe.pecasXqtde:=Qdetalhe.fieldbyname('mpdd_qtde').Ascurrency*Qdetalhe.fieldbyname('mpdd_pecas').ascurrency;
// 02.08.12
                 TPesototal:=TPesototal+PDetalhe.pecasXqtde;
                 PDetalhe.pecasXqtdeXuni:=FGeral.Arredonda( Qdetalhe.fieldbyname('mpdd_qtde').Ascurrency*
                                          Qdetalhe.fieldbyname('mpdd_pecas').ascurrency*
                                          Qdetalhe.fieldbyname('mpdd_venda').AsCurrency,2);
// 12.08.14 - Devereda - mostrar o 'retorno'
//////////////////////////////////////////////
                 if (Global.Usuario.OutrosAcessos[0335]) and  (Qdetalhe.fieldbyname('mpdd_qtdeenviada').AsCurrency>0)
                   and ( Qdetalhe.fieldbyname('mpdd_situacao').asstring='B' )    // 08.01.15
                   then begin
                   New(PDetalhe);
                   PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('Mpdd_esto_codigo').AsString;
                   PDetalhe.Descricaoproduto:='Retorno';
                   PDetalhe.Cst:='';
                   PDetalhe.Unidade:=Qdetalhe.fieldbyname('Esto_unidade').Asstring;
                   PDetalhe.Quantidade:=Qdetalhe.fieldbyname('mpdd_qtdeenviada').Ascurrency;
                   PDetalhe.TQuantidade:=PDetalhe.TQuantidade-Qdetalhe.fieldbyname('mpdd_qtdeenviada').AsCurrency;
                   PDetalhe.Unitario:=Qdetalhe.fieldbyname('mpdd_venda').AsCurrency;
                   if QDetalhe.fieldbyname('mpdd_tipomov').asstring='PV' then
                     PDetalhe.Margem:=(Qdetalhe.fieldbyname('grup_markup').AsCurrency)
                   else
                     PDetalhe.Margem:=(Qdetalhe.fieldbyname('grup_margem').AsCurrency);
                   valortotal:=(-1)*FGeral.Arredonda(Qdetalhe.fieldbyname('mpdd_venda').AsCurrency*Qdetalhe.fieldbyname('mpdd_qtdeenviada').AsCurrency,2);
                   PDetalhe.Total:=valortotal;
                   PDetalhe.icms:=0;
                   PDetalhe.perdesco:=Qdetalhe.fieldbyname('mpdd_perdesco').AsCurrency;
                   PDetalhe.vendabru:=Qdetalhe.fieldbyname('mpdd_vendabru').AsCurrency;
                   PDetalhe.Codigocor:=Qdetalhe.fieldbyname('mpdd_core_codigo').AsInteger;
                   PDetalhe.DescricaoCor:=copy( Qdetalhe.fieldbyname('core_descricao').Asstring,1,10 );
                   PDetalhe.CodigoTamanho:=Qdetalhe.fieldbyname('mpdd_tama_codigo').AsInteger;
                   PDetalhe.DescricaoTamanho:=copy( Qdetalhe.fieldbyname('tama_descricao').Asstring,1,10 );
                   PDetalhe.Seq:=Qdetalhe.fieldbyname('mpdd_seq').Asinteger;
                   PDetalhe.Codigocopa:=Qdetalhe.fieldbyname('mpdd_copa_codigo').AsInteger;
                   PDetalhe.DescricaoCopa:=Qdetalhe.fieldbyname('copa_descricao').Asstring;
                   PDetalhe.Fardos:=Qdetalhe.fieldbyname('mpdd_fardos').Asinteger;
                   PDetalhe.Pacotes:=Qdetalhe.fieldbyname('mpdd_pacotes').Asinteger;
                   PDetalhe.Cubagem:=Qdetalhe.fieldbyname('mpdd_cubagem').AsFloat;
                   PDetalhe.Qualidade:=Qdetalhe.fieldbyname('mpdd_qualidade').AsString;
                   PDetalhe.Medidas:=FTamanhos.GetMedidas(QDetalhe.fieldbyname('mpdd_tama_codigo').asinteger);
                   PDetalhe.descubagem:=Qdetalhe.fieldbyname('mpdd_perdescre').Ascurrency;
                   ListaDetalhe.Add(Pdetalhe);
                   Tvalortotal:=Tvalortotal+valortotal;
                   TQtdetotal:=TQtdetotal-Qdetalhe.fieldbyname('mpdd_qtdeenviada').Ascurrency;
//                     TPecastotal:=TPecastotal+Qdetalhe.fieldbyname('mpdd_pecas').AsInteger;
                   PDetalhe.pecas:=Qdetalhe.fieldbyname('mpdd_pecas').ascurrency;
                   PDetalhe.pecasXqtde:=Qdetalhe.fieldbyname('mpdd_qtdeenviada').Ascurrency*Qdetalhe.fieldbyname('mpdd_pecas').ascurrency;

                   TPesototal:=TPesototal-PDetalhe.pecasXqtde;
                   PDetalhe.pecasXqtdeXuni:=FGeral.Arredonda( Qdetalhe.fieldbyname('mpdd_qtdeenviada').Ascurrency*
                                            Qdetalhe.fieldbyname('mpdd_pecas').ascurrency*
                                            Qdetalhe.fieldbyname('mpdd_venda').AsCurrency,2);
                 end;
///////////////////////////////////////////////
                 QDetalhe.Next;
               end;

               if (not QDetalhe.IsEmpty)  then begin
                  Envia_Impressora;

               end;  // QDetalhe.isempty

               QDetalhe.Close;
               Freeandnil(QDetalhe);
               Listadetalhe.Free;
               QMestre.Next;
             end;
  // 15.06.20
             if Semvalor <> 'V' then
                Sistema.EndProcess('');

          end;
       end;
       Qclientes.close;
       Freeandnil(Qclientes);
       QPendencia.close;
       Freeandnil(QPendencia);

    end else begin   // 29.04.05 - ijui 'começou a nao imprimir a nf de VC logo depois do acerto'
      Avisoerro('Pedido '+inttostr(Nota)+' de '+Datetostr(Datamvto)+' não encontrado.');

    end;

    QMestre.Close;
    Freeandnil(QMestre);
    if QDetalhe<>nil then
       Freeandnil(QDetalhe);

  except on E: Exception do

    begin
      FGeral.FechaQuery(QMestre);
      Freeandnil(QMestre);
      FGeral.FechaQuery(QClientes);
      Freeandnil(QClientes);
      Avisoerro( E.message );
    end;

  end;

  Sistema.EndProcess('');

end;

procedure TFImpressao.Confbloqueto(Codigo, Descricao: String);
//////////////////////////////////////////////////////////////////
var Tit:String;
    LComandos:TStringList;
begin
  Tit:='Configuração Boleto de Cobrança / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
// 29.03.19 - para fazer no word impressao duplicata
  ListaComandos:=TStringList.Create;
  LComandos.Add('Tipo de Movimento');

  LComandos.Add('Codigo destinatário');
  LComandos.Add('Razão Social destinatário');
  LComandos.Add('CNPJ/CPF destinatário');
  LComandos.Add('Data emissão');
  LComandos.Add('Endereço destinatário');
  LComandos.Add('Bairro destinatário');
  LComandos.Add('CEP destinatário');
  LComandos.Add('Data Saída');
  LComandos.Add('Municipio destinatário');
  LComandos.Add('Telefone destinatário');
  LComandos.Add('UF destinatário');
  LComandos.Add('Inscrição Estadual do destinatário');
  LComandos.Add('Email destinatário');
  LComandos.Add('Numero Nota');
  LComandos.Add('Data Vencimento');
  LComandos.Add('Parcela');
  LComandos.Add('Valor Parcela');
  LComandos.Add('Codigo usuário');
  LComandos.Add('Nome usuário');
  LComandos.Add('Condição de Pagamento');
  LComandos.Add('Codigo representante');
  LComandos.Add('Nome representante');
  LComandos.Add('Transação');
// 31.05.07
  LComandos.Add('Codigo Portador');
  LComandos.Add('Descrição Portador');
// 27.02.08
  LComandos.Add('Valor por extenso (linha1)');
  LComandos.Add('Valor por extenso (linha2)');
// 10.09.09
  LComandos.Add('Juros Mora Diária');
// 19.11.09 - Capeg
  LComandos.Add('Observações');
// 03.03.10 - SM
  LComandos.Add('Competência');
// 13.04.10 - Abra
  LComandos.Add('Unidade emitente');
  LComandos.Add('Nome emitente');
  LComandos.Add('Razão Social emitente');
  LComandos.Add('CNPJ emitente');
  LComandos.Add('I.E. emitente');
  LComandos.Add('Endereço emitente');
  LComandos.Add('Cidade emitente');
  LComandos.Add('Fone emitente');
  LComandos.Add('Estado emitente');
  LComandos.Add('Cep emitente');
  LComandos.Add('Histórico');
// 29.03.19
  if codigo <> '999' then
     FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  ListaComandos.Assign(LComandos);

  LComandos.Free;

end;


function RetornoBloqueto(Comando,Especie:String):String;
//////////////////////////////////////////
var Dtemissao:TDateTime;
    Valornota:Currency;
    esp:integer;
    ext:string;

    function Tratavalor(valor:currency):string;
    ///////////////////////////////////////////////
    begin
       result:='XX';
       if valor>0 then
         result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
       else begin
         if Nropaginas=1 then
           result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
         else
           result:='******,**';
       end;
    end;


begin

  Dtemissao:=QMestre.FieldByName('Pend_Dataemissao').AsDateTime;
  result:='';
  ValorNota:=QMestre.FieldByName('Pend_Valor').AsFloat;
  if Comando='Codigo Tipo de Movimento' then Result:=QMestre.fieldbyname('pend_tipomov').asstring;
  if Comando='Tipo de Movimento' then Result:=FGeral.GetTipoMovto(QMestre.fieldbyname('pend_tipomov').asstring);
  if Comando='Data emissão' then Result:=FGeral.formatadata(QMestre.fieldbyname('pend_dataemissao').Asdatetime);
  if Comando='Data Saída' then result:=FGeral.formatadata(QMestre.fieldbyname('pend_DataMvto').asdatetime);
//  if QMestre.fieldbyname('moes_tipomov').Asstring<>Global.coddevolucaocompra then begin
// 16.09.05
//  if ( pos(QMestre.fieldbyname('pend_tipomov').asstring,Global.coddevolucaocompra+';'+global.CodCompra+';'+Global.CodCompra100+';'+
//     Global.CodCompraX+';'+Global.CodConhecimento+';'+Global.CodCompraImobilizado+';'+Global.CodCompraMatConsumo+';'+
//     Global.coddevolucaocompraSemestoque+';'+Global.CodRetornoInd+';'+Global.CodRetornocomServicos+';'+
//     Global.CodDevolucaoInd )=0 ) and (QMestre.fieldbyname('pend_tipocad').AsString<>'R') then begin
// 28.01.09 - Carli - Fran
  if (QMestre.fieldbyname('pend_tipocad').AsString='C') then begin

    if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('clie_razaosocial').asstring;
    if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('clie_cnpjcpf').asstring);
    if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('clie_codigo').asstring;
    if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('clie_endres').asstring;
    if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('clie_bairrores').asstring;
    if Comando='CEP destinatário' then result:=FGeral.Formatacep( QClientes.fieldbyname('clie_cepres').asstring);
    if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('clie_cida_codigo_res').asinteger);
    if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('clie_foneres').asstring);
    if Comando='UF destinatário' then result:=QClientes.fieldbyname('clie_uf').asstring;
    if Comando='Email destinatário' then result:=QClientes.fieldbyname('clie_email').asstring;
    if Comando='Inscrição Estadual do destinatário' then begin
      if QClientes.fieldbyname('clie_tipo').asstring='F' then
        Result:='Isento'
      else
        result:=QClientes.fieldbyname('clie_rgie').asstring;
    end;
// 18.05.06
  end else if QMestre.fieldbyname('pend_tipocad').AsString='R' then begin

    if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('repr_razaosocial').asstring;
    if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('repr_cnpjcpf').asstring);
    if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('repr_codigo').asstring;
    if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('repr_endereco').asstring;
    if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('repr_bairro').asstring;
    if Comando='CEP destinatário' then result:=QClientes.fieldbyname('repr_cep').asstring;
    if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('repr_cida_codigo').asinteger);
    if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('repr_fone').asstring);
    if Comando='UF destinatário' then result:=FCidades.GetUF(QClientes.fieldbyname('repr_cida_codigo').asinteger);
    if Comando='Inscrição Estadual do destinatário' then  result:=QClientes.fieldbyname('repr_inscricaoestadual').asstring;
//////////////////////////
  end else begin
    if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('forn_razaosocial').asstring;
    if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('forn_cnpjcpf').asstring);
    if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('forn_codigo').asstring;
    if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('forn_endereco').asstring;
    if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('forn_bairro').asstring;
    if Comando='CEP destinatário' then result:=QClientes.fieldbyname('forn_cep').asstring;
    if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('forn_cida_codigo').asinteger);
    if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('forn_fone').asstring);
    if Comando='UF destinatário' then result:=QClientes.fieldbyname('forn_uf').asstring;
    if Comando='Inscrição Estadual do destinatário' then begin
      result:=QClientes.fieldbyname('forn_inscricaoestadual').asstring;
    end;
  end;
  ext:=UpperCaseBras( Extenso(valornota) );

  if Comando='Hora Saída' then result:=Timetostr(Time);
  if Comando='Numero Nota' then result:=QMestre.fieldbyname('pend_numerodcto').asstring;
// 11.11.05 - fical chupisco no porta nao gosta de nf com nros 7,8,9,,tem q ser 007, 008,,,bichona loka mesmo...
//  if Comando='Numero Nota' then result:=strzero(QMestre.fieldbyname('pend_numerodcto').asinteger,7);
// 19.11.09 - retirado este strzero - Capeg

  if Comando='Data Vencimento' then result:=FGeral.formatadata(QMestre.fieldbyname('pend_datavcto').asdatetime);
//  if Comando='Parcela' then result:=FGeral.formatavalor(QMestre.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores);
// 29.05.07
  if Comando='Parcela' then result:=strzero(QMestre.fieldbyname('pend_parcela').asinteger,2)
  else if Comando='Valor Parcela' then  result:=Tratavalor(valornota)
  else if Comando='Codigo usuário' then result:=QMestre.fieldbyname('pend_usua_codigo').asstring
  else if Comando='Nome usuário' then result:=FUsuarios.GetNome(QMestre.fieldbyname('pend_usua_codigo').asinteger)
// 17.05.05
  else if Comando='Condição de Pagamento' then result:=FCondpagto.getreduzido(condicao)
  else if Comando='Codigo representante' then result:=QMestre.fieldbyname('pend_repr_codigo').asstring
  else if Comando='Nome representante' then result:=FRepresentantes.GetDescricao(QMestre.fieldbyname('pend_repr_codigo').asinteger)
  else if Comando='Transação' then result:=QMestre.fieldbyname('pend_transacao').asstring
// 31.05.07
  else if Comando='Codigo Portador' then result:=QMestre.fieldbyname('pend_port_codigo').asstring
  else if Comando='Descrição Portador' then result:=FPortadores.GetDescricao(QMestre.fieldbyname('pend_port_codigo').asstring)
// 27.02.08
  else if Comando='Valor por extenso (linha1)' then result:=copy(ext,1,55)
  else if Comando='Valor por extenso (linha2)' then result:=copy(ext,56,55)
// 10.09.09
  else if Comando='Juros Mora Diária' then result:= TrataVAlor( ( valornota*(FGEral.getconfig1asfloat('JUROSMORA')/100) )/30 )
// 19.11.09 - Capeg
  else if Comando='Observações' then result:=QMestre.fieldbyname('pend_observacao').asstring
// 03.03.10 - SM
//  else if Comando='Competência' then result:=FormatDatetime('MM/yyyy',QMestre.fieldbyname('pend_dataemissao').Asdatetime)
// 19.08.10
// assim nao adianta por inclui por ex. em 03.2010 12 parcelas...dai td parcela fica
// com competencia 03.2010
  else if Comando='Competência' then begin
    if pos('13',QMestre.fieldbyname('pend_complemento').asstring)>0 then
      result:='13/'+strzero(DateToAno(QMestre.fieldbyname('pend_datavcto').Asdatetime,true),4)
    else
      result:=FormatDatetime('MM/yyyy',DateToDateMesAnt(QMestre.fieldbyname('pend_datavcto').Asdatetime,1));
// 13.04.10 - Abra
  end else if Comando='Unidade emitente' then result:=QMestre.fieldbyname('pend_unid_codigo').AsString
  else if Comando='Nome emitente' then result:=FUnidades.GetNome( QMestre.fieldbyname('pend_unid_codigo').AsString )
  else if Comando='Razão Social emitente' then result:=FUnidades.GetRazaoSocial(QMestre.fieldbyname('pend_unid_codigo').AsString)
// 30.11.13 - SM
  else if Comando='Histórico' then result:=QMestre.fieldbyname('pend_complemento').asstring
// 29.03.19 - Vida Nova ... alem do boleto...
  else if Comando='CNPJ emitente' then result:=FGeral.Formatacnpj( FUnidades.GetCnpjcpf(QMestre.fieldbyname('pend_unid_codigo').AsString))
  else if Comando='I.E. emitente' then result:=FUnidades.GetInsEst(QMestre.fieldbyname('pend_unid_codigo').AsString)
  else if Comando='Endereço emitente' then result:=FUnidades.GetEndereco(QMestre.fieldbyname('pend_unid_codigo').AsString)
  else if Comando='Cidade emitente' then result:=QMestre.fieldbyname('unid_municipio').AsString
  else if Comando='Fone emitente' then result:=FGeral.Formatatelefone( QMestre.fieldbyname('unid_fone').AsString)
  else if Comando='Cep emitente' then result:=FGeral.Formatacep( QMestre.fieldbyname('unid_cep').AsString)
  else if Comando='Estado emitente' then result:= QMestre.fieldbyname('unid_uf').AsString;


end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
function TFImpressao.ImprimeBloqueto(Nota,Notaf: Integer; DataMvto: TDatetime;  Unidade:string ; tipomov:string='' ; xvenc:TDatetime=0;notas:string='';xvalor:currency=0): Boolean;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
var n,nn,cliente,numero,
    ultimaposicao,
    retorno         :Integer;
    FormaImpressao,Codigo,sqltipomovm,sqlvencimento,sqlnumeronota,
    sqlnotas,
    nomearquivo     :String;
    valortotal,
    Tvalortotal     :currency;
    QSomatitulos    : Tsqlquery;
    Dlg,
    Documento       : Olevariant;
    WordApp         : Variant;

    function Numeros(nropendencia:string):boolean;
    //////////////////////////////////////////////////
    var numero:integer;
    begin
      result:=true;
      if (nota=notaf) or (notaf=0) then exit;
      numero:=strtointdef(nropendencia,0);
      if (numero>=nota) and (numero<=notaf) then
        result:=true
      else
        result:=false;

    end;

    procedure GravaPendencia;
    ////////////////////////
    begin
        numero:=FGeral.GetContador('IMPBOLETO'+Global.CodigoUnidade,false);
        Sistema.SetField('Pend_Transacao',inttostr(numero) );
        Sistema.SetField('Pend_Operacao',inttostr(numero)+'01');
        Sistema.SetField('Pend_Status','I');
        Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
        Sistema.SetField('Pend_DataMvto',sistema.hoje);
        Sistema.SetField('Pend_ValorComissao',0);
        Sistema.SetField('Pend_DataVcto',xvenc);
        Sistema.SetField('pend_datavctoori',xvenc );
        Sistema.SetField('Pend_DataEmissao',sistema.hoje);
        Sistema.SetField('Pend_Plan_Conta',0);
        Sistema.SetField('Pend_Tipo_Codigo',QMestre.fieldbyname('pend_tipo_codigo').Asinteger );
        cliente:=QMestre.fieldbyname('pend_tipo_codigo').Asinteger;
        Sistema.SetField('Pend_TipoCad','C' );
        Sistema.SetField('Pend_Unid_Codigo',Unidade);
        Sistema.SetField('Pend_Fpgt_Codigo','001');
        Sistema.SetField('Pend_Port_Codigo','');
        Sistema.SetField('Pend_Hist_Codigo',0);
        Sistema.SetField('Pend_Moed_Codigo','');
        Sistema.SetField('Pend_Repr_Codigo',0);
        Sistema.SetField('Pend_Complemento','');
        Sistema.SetField('Pend_NumeroDcto','');
        Sistema.SetField('Pend_Parcela',1);
        Sistema.SetField('Pend_NParcelas',1);
        Sistema.SetField('Pend_RP','R');
        Sistema.SetField('Pend_Valor',xvalor);
        Sistema.SetField('Pend_ValorTitulo',xvalor);
        Sistema.SetField('Pend_Juros',0);
        Sistema.SetField('Pend_Multa',0);
        Sistema.SetField('Pend_Mora',0);
        Sistema.SetField('Pend_Acrescimos',0);
        Sistema.SetField('Pend_Descontos',0);
        Sistema.SetField('Pend_TransBaixa','');  // no. transacao da baixa
        Sistema.SetField('Pend_ContaBaixa',0);
        Sistema.SetField('Pend_Observacao',notas);
        Sistema.SetField('Pend_Impresso',0);   // numero do impresso relacionado
        Sistema.SetField('Pend_ImprDcto','');  // S ou N se o impresso já foi enviado para impressão
        Sistema.SetField('Pend_LoteCNAB',0);  // no. lote para exportação bancária (CNAB )
        Sistema.SetField('Pend_tipomov','IB');  // 'Impressao de Boleto'...
        Sistema.SetField('Pend_DataCont',sistema.hoje);
        Sistema.SetField('Pend_usua_codigo',Global.Usuario.Codigo);
    end;

    // aqui em 29.03.19
    function PreencherDadosArquivo(const NomeArquivo: string ; primeiro:integer=0): Boolean;
    ///////////////////////////////////////////////////////////////////// /////////
    var
//      WordApp: Variant;
//      Documento: Olevariant;
      xcomando:string;
      p : byte;

    begin

      if not FileExists( NomeArquivo ) then begin
        Avisoerro('Arquivo '+NomeArquivo+' não encontrado');
        exit;
      end;

//      WordApp:= CreateOleObject('Word.Application');

      try

        WordApp.Visible := False;
        Documento := WordApp.Documents.Open(NomeArquivo);

        ConfBloqueto('999','');

        for p:=0 to ListaComandos.count-1 do begin

          xcomando:=ListaComandos[p];
          if (xcomando='Descrição produto') or (xcomando='Quantidade') or (xcomando='Quantidade por extenso') or (xcomando='Unidade produto') then
            Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoBloqueto(xcomando,'1'))
          else
            Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoBloqueto(xcomando,''));

        end;

    // 2 x devido a  ter mais de uma vez a mesma informacao

        for p:=0 to ListaComandos.count-1 do begin

          xcomando:=ListaComandos[p];
          if (xcomando='Descrição produto') or (xcomando='Quantidade') or (xcomando='Quantidade por extenso') or (xcomando='Unidade produto') then
            Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoBloqueto(xcomando,'1'))
          else
            Documento.Content.Find.Execute(FindText := xcomando , ReplaceWith := RetornoBloqueto(xcomando,''));

        end;


        Documento.SaveAs( ExtractFilePath( Application.ExeName ) +
                  'DUPL'+QMestre.fieldbyname('Pend_numerodcto').asstring+
                  QMestre.fieldbyname('Pend_parcela').asstring+'.docx');
        Documento.close;
        Documento := WordApp.Documents.Open( ExtractFilePath( Application.ExeName ) +
                  'DUPL'+QMestre.fieldbyname('Pend_numerodcto').asstring+
                  QMestre.fieldbyname('Pend_parcela').asstring+'.docx');

//        if pos('Indica',FConfDcto.Impressora) = 0 then begin
//          if Printer.Printers.IndexOf(FConfDcto.Impressora) <> -1 then
//             Printer.PrinterIndex := Printer.Printers.IndexOf(FConfDcto.Impressora);
//        end;
//
//          Printer.SetPrinter() FConfDcto.SetImpressora(FConfDcto.Impressora);

//        for p := 0 to FConfDcto.NumCopias-1 do Documento.PrintOut(false);
// desta forma a impressora se perde....
//        Documento.PrintOut(false);
{
        if primeiro=1 then begin

          Dlg:=Documento.Application.Dialogs.Item(wdDialogFilePrint); // chamo a caixa de impressao do word
//          WordApp.Visible := True;
          Retorno:= Dlg.Display; // mostro a caixa
//          if Retorno = -1 then Dlg.Execute;

//          WordApp.Visible := False;

        end;
}

        Documento.PrintOut(copies := FConfDcto.NumCopias );
        Documento.close;

      finally

//        WordApp.Quit;
        DeleteFile( ExtractFilePath( Application.ExeName ) + 'DUPL'+QMestre.fieldbyname('Pend_numerodcto').asstring+
                   QMestre.fieldbyname('pend_parcela').asstring+'.docx');

      end;

    end;


begin
//////////////////////////////////////////////

  Result:=True;
  if not Arq.TUnidades.active then Arq.TUnidades.Open;
//  if not Arq.TClientes.active then Arq.TClientes.Open;
  if not Arq.TNatFisc.active then Arq.TNatFisc.open;
  if Arq.TTransp.active then Arq.TTransp.close;
  Arq.TTransp.open;
  cliente:=0;numero:=0;
  if trim(tipomov)='' then begin
    sqltipomovm:='';
  end else begin
    sqltipomovm:=' and pend_tipomov='+stringtosql(tipomov);
  end;
  sqlnumeronota:='';
  if (nota=notaf) or ( notaf=0) then
    sqlnumeronota:=' and pend_numeroDcto='+Stringtosql(inttostr(nota))
// 03.03.10 - SM
  else if (notaf>nota) and ( notaf>0 ) and ( nota>0 ) then
    sqlnumeronota:=' and pend_numeroDcto>='+Stringtosql(inttostr(nota))+
                   ' and pend_numeroDcto<='+Stringtosql(inttostr(notaf))  ;
// 11.08.08
  if xvenc>0 then
    sqlvencimento:=' and pend_datavcto='+Datetosql(xvenc)
  else
    sqlvencimento:='';
// 18.11.09
  sqlnotas:='';
  if trim(notas)<>'' then
    sqlnotas:=' and pend_datavcto>='+DatetoSql(Sistema.Datai)+' and pend_datavcto<='+DatetoSql(Sistema.Dataf);
// 04.03.13 - Vivan - para não imprimir contas a receber ref. recebimento com cartão de credito
  sqlportadorcartao:='';
  if trim( FGeral.GetConfig1AsString('Portadorcartao') )<>'' then
    sqlportadorcartao:=' and '+FGeral.GetNOTIN('pend_port_codigo',FGeral.GetConfig1AsString('Portadorcartao'),'C');

  sqlportadorboleto:='';
//  if trim( FGeral.GetConfig1AsString('Portaboletos') )<>'' then
//    sqlportadorboleto:=' and '+FGeral.GetNOTIN('pend_port_codigo',FGeral.GetConfig1AsString('Portaboletos'),'C');
// 29.03.19 - retirado para fazer duplicata 'em cima' de boleto'








    if trim(notas)<>'' then begin
      QMestre:=sqltoquery('select pend_tipo_codigo,sum(pend_valor) as valor from pendencias '+
                     ' where pend_unid_codigo='''+unidade+''''+
                     sqlnotas+
                     ' and '+Fgeral.getin('pend_status','N','C')+
                     ' and pend_rp=''R'''+
                     sqlportadorcartao+sqlportadorboleto+
                     ' group by pend_tipo_codigo');
      if QMestre.fieldbyname('valor').ascurrency>0 then begin
        Sistema.Insert('pendencias');
        GravaPendencia;
        Sistema.Post();
        try
          Sistema.Commit;
        except
          Avisoerro('Não foi possível gravar o total dos documentos marcados.  Tente mais tarde');
          exit;
        end;
        FGeral.FechaQuery(QMestre);
        QMestre:=sqltoquery('select * from pendencias inner join unidades on ( unid_codigo=pend_unid_codigo )'+
                     ' where pend_unid_codigo='''+unidade+''''+
                     ' and '+Fgeral.getin('pend_status','I','C')+
                     ' and pend_tipo_codigo='+inttostr(Cliente)+
                     ' and Pend_Transacao='+inttostr(numero) );
        if QMestre.Eof then begin
          Avisoerro('Lançamento status I transação '+inttostr(numero)+' não encontrado');
          FGeral.FechaQuery(QMestre);
          exit;
        end;
      end;
    end else
      QMestre:=sqltoquery('select * from pendencias inner join unidades on ( unid_codigo=pend_unid_codigo )'+
                     ' where pend_unid_codigo='''+unidade+''''+
                     ' and pend_dataemissao='+Datetosql(Datamvto)+
                     sqltipomovm+sqlvencimento+sqlnumeronota+sqlportadorcartao+sqlportadorboleto+
//                     ' and '+Fgeral.getin('pend_status','N;B','C')+
// 16.05.2022 - eticon - não imprimir se baixado
                     ' and '+Fgeral.getin('pend_status','N','C')+
                     ' and pend_rp=''R'''+  // 20.07.09 para nao pegar ref. comissao
                     ' order by pend_dataemissao,pend_numerodcto,pend_datavcto' );

//    QMestre.Name:='QMestre';
// retirado em 02.03.10 - sm
  try
    if not QMestre.Eof then begin

// 16.06.06 - por enquanto usar o mesmo bloquete para tipo1 e 2
        if QMestre.fieldbyname('pend_Datacont').asdatetime<=1 then
          Codigo:=FGeral.GetConfig1AsString('Imprbloqueto')
        else
          Codigo:=FGeral.GetConfig1AsString('Imprbloqueto');
      if trim(codigo)='' then begin
         Avisoerro('Falta configurar o codigo deste impresso na configuração geral');
         QMestre.close;
         Freeandnil(QMestre);
         exit;
      end;
      Arq.TUnidades.locate('unid_codigo',unidade,[]);

      Result:=FConfDcto.GetConfiguracao(Codigo);

//      if ( pos(QMestre.fieldbyname('pend_tipomov').asstring,Global.coddevolucaocompra+';'+global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+
//         Global.CodConhecimento+';'+Global.CodCompraImobilizado+';'+Global.CodCompraMatConsumo+';'+Global.coddevolucaocompraSemEstoque+';'+
//         Global.CodDevolucaoInd+';'+Global.CodRetornoInd+';'+Global.CodRetornocomServicos)>0 )
//         and (QMestre.fieldbyname('pend_tipocad').AsString<>'R')  then
// 28.01.09 - Carli - Francieli
      if QMestre.fieldbyname('pend_tipocad').AsString='F'  then
        QClientes:=sqltoquery('select * from fornecedores where forn_codigo='+QMestre.fieldbyname('pend_tipo_codigo').asstring)
      else if QMestre.fieldbyname('pend_tipocad').asstring='R' then
        QClientes:=sqltoquery('select * from representantes where repr_codigo='+QMestre.fieldbyname('pend_tipo_codigo').asstring)
      else
        QClientes:=sqltoquery('select * from clientes where clie_codigo='+QMestre.fieldbyname('pend_tipo_codigo').asstring);

//      QClientes.Name:='QClientes';

//      Arq.TTransp.Locate('tran_codigo',QMestre.fieldbyname('moes_tran_codigo').asstring,[]);

      FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
       if (FormaImpressao='2') or ((FormaImpressao='1') and (Confirma('Confirma a impressão ?'))) then begin


          if Result then begin
// 15.04.19
             if FConfDcto.TpImpressora='V' then begin

                Nomearquivo:=ExtractFilePath( Application.ExeName )+'ModeloDup.docx';
                if not FileExists( NomeArquivo ) then begin
                  Avisoerro('Arquivo '+NomeArquivo+' não encontrado');
                  exit;
                end;

                WordApp:= CreateOleObject('Word.Application');

             //                WordApp.Visible := False;
  //              Documento := WordApp.Documents.Open(NomeArquivo);

//                Dlg:=Documento.Application.Dialogs.Item(wdDialogFilePrint); // chamo a caixa de impressao do word
//                Retorno:= Dlg.Display; // mostro a caixa
//                if Retorno = -1 then // se o retorno for -1 então executa
//                   Dlg.Execute;
//                if Retorno <> -1 then Exit;

             end;

             Sistema.BeginProcess('imprimindo duplicata');

             nn:=0;
             QMestre.First;

             while not QMestre.Eof do begin

               if Numeros(QMestre.fieldbyname('pend_numerodcto').asstring) then begin
                 Inc(nn);
               end;
               QMestre.Next;

             end;

             QMestre.First;
             n:=0;
             ultimaposicao:=0;
             while not QMestre.Eof do begin

               Result:=true; // 03.03.10
               if Numeros(QMestre.fieldbyname('pend_numerodcto').asstring) then begin
                 Inc(n);
  // 02.09.09 - Capeg - Mari
                 if Notaf>nota then begin
                   QClientes.Close;
                   if QMestre.fieldbyname('pend_tipocad').AsString='F'  then
                     QClientes:=sqltoquery('select * from fornecedores where forn_codigo='+QMestre.fieldbyname('pend_tipo_codigo').asstring)
                   else if QMestre.fieldbyname('pend_tipocad').asstring='R' then
                     QClientes:=sqltoquery('select * from representantes where repr_codigo='+QMestre.fieldbyname('pend_tipo_codigo').asstring)
                   else
                     QClientes:=sqltoquery('select * from clientes where clie_codigo='+QMestre.fieldbyname('pend_tipo_codigo').asstring);
                 end;
//                 Result:=FConfDcto.Print(Codigo,RetornoBloqueto,n=1,n=nn);  // 03.03.10
//                 Result:=FConfDcto.Print(Codigo,RetornoBloqueto,n=1,n=nn,false,n-1);  // 24.05.11
// 29.03.19 - Vida Nova
                  if FConfDcto.TpImpressora='V' then begin

                    PreencherDadosArquivo( ExtractFilePath( Application.ExeName )+'ModeloDup.docx',n);

                  end else
                    Result:=FConfDcto.Print(Codigo,RetornoBloqueto,n=1,n=nn,false,ultimaposicao,'',0);

                 if not Fconfdcto.Ejetar then begin
                   ultimaposicao:=ultimaposicao+FConfdcto.NumLgPg+1;
                   FConfDcto.GetConfiguracao(Codigo,ultimaposicao);
                 end;

               end;
//               Result:=FConfDcto.Print(Codigo,RetornoBloqueto,n=1,n=nn);
               if not Result then Break;
               QMestre.Next;

             end;
             Sistema.EndProcess('');

             if FConfDcto.TpImpressora='V' then  WordApp.Quit;

          end;
       end;
       Qclientes.close;
       Freeandnil(Qclientes);

    end else begin

      Avisoerro('Nota fiscal '+inttostr(Nota)+' de '+Datetostr(Datamvto)+' não encontrada.  Tipo '+tipomov);

    end;

    QMestre.Close;Freeandnil(QMestre);

  except on E:exception do Avisoerro( E.Message );

  end;
  Sistema.EndProcess('');

end;


function TFImpressao.ImprimeInstrucoescobranca(impresso:string;qtde:integer ):Boolean;
/////////////////////////////////////////////////////////////////////////////////////////
var n,nn,ultimaposicao:Integer;
    FormaImpressao:String;

begin

      Result:=FConfDcto.GetConfiguracao(impresso);

      FormaImpressao:=FCadImp.GetFormaImpressao(impresso);
       if (FormaImpressao='2') or ((FormaImpressao='1') and (Confirma('Confirma a impressão ?'))) then begin
          if Result then begin
             Sistema.BeginProcess('imprimindo');
             nn:=qtde;
             n:=0;
             ultimaposicao:=0;
             while n<=nn do begin
               Inc(n);
//               Result:=FConfDcto.Print(Impresso,RetornoBloqueto,n=1,n=nn,false,0,'X',qtde);
// 31.07.13
               if Global.Topicos[1213] then begin
                 Result:=FConfDcto.Print(Impresso,RetornoBloqueto,n=1,n=nn,false,ultimaposicao,'',0);
                 if not Fconfdcto.Ejetar then begin
                   ultimaposicao:=ultimaposicao+FConfdcto.NumLgPg+1;
                   FConfDcto.GetConfiguracao(Impresso,ultimaposicao);
                 end;
               end else if Global.Topicos[1216] then begin
//  assim nao imprime nada Result:=FConfDcto.Print(Impresso,RetornoBloqueto,n=1,n=nn,false,ultimaposicao,'ACBR',0);
// 20.08.13
                 Result:=FConfDcto.Print(Impresso,RetornoBloqueto,true,true,false,ultimaposicao,'ACBR',qtde);
//etq estoque    Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,true,true,Visualiza,(n-1)*FConfDcto.NumLgPg,'ACBR',qtdetiquetas);
                 if not Fconfdcto.Ejetar then begin
                   ultimaposicao:=ultimaposicao+FConfdcto.NumLgPg+1;
                   FConfDcto.GetConfiguracao(Impresso,ultimaposicao);
                 end;

               end;
               if not Result then Break;
             end;
             Sistema.EndProcess('');
          end;
       end;

end;



procedure TFImpressao.Adicionalista(Lista: TStringlist; s: string);
var p:integer;
    achou:boolean;
begin
   if trim(s)='' then exit;
   achou:=false;
   for p:=0 to Lista.Count-1 do begin
     if Lista[p]=s then begin
       achou:=true;
       break;
     end;
   end;
   if not achou then
     Lista.add(s);
end;

// 05.11.18
function TFImpressao.GeraArquivoImagem(xCodigo: string):string;
/////////////////////////////////////////////////////////////
var Str:TMemoryStream;
    arquivo:string;
begin

  Str:=TMemoryStream.Create;
  LoadBlob('estoque','esto_imagem','esto_codigo='+stringtosql(xcodigo),Str);
  arquivo:=xcodigo+'.jpg';
  if Str.Size>1 then begin
    Str.SaveToFile(arquivo);
  end;
  Str.Free;
  result:=arquivo;

end;

function TFImpressao.GetLIsta(Lista: TStringlist;  separador: string): string;
var p:integer;
begin
  result:='';
  for p:=0 to Lista.count-1 do begin
    result:=result+Lista[p]+separador;
  end;

end;

procedure TFImpressao.ConfNotaSaidaMo(Codigo, Descricao: String);
var Tit:String;
    LComandos:TStringList;
begin
  Tit:='Configuração Nota Fiscal de Saida / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
  LComandos.Add('Codigo Tipo de Movimento');
  LComandos.Add('Tipo de Movimento');
  LComandos.Add('Natureza da Operação');
  LComandos.Add('CFOP-Codigo fiscal da operação');
  LComandos.Add('Inscrição Estadual do emitente');
  LComandos.Add('CNPJ do emitente');

  LComandos.Add('Endereço emitente');
  LComandos.Add('Bairro emitente');
  LComandos.Add('CEP emitente');
  LComandos.Add('Municipio emitente');
  LComandos.Add('UF emitente');
  LComandos.Add('Telefone emitente');

  LComandos.Add('Codigo destinatário');
  LComandos.Add('Razão Social destinatário');
  LComandos.Add('CNPJ/CPF destinatário');
  LComandos.Add('Data emissão');
  LComandos.Add('Endereço destinatário');
  LComandos.Add('Bairro destinatário');
  LComandos.Add('CEP destinatário');
  LComandos.Add('Data Saída');
  LComandos.Add('Municipio destinatário');
  LComandos.Add('Telefone destinatário');
  LComandos.Add('UF destinatário');
  LComandos.Add('Inscrição Estadual do destinatário');
  LComandos.Add('Hora Saída');
  LComandos.Add('Numero Nota');
  LComandos.Add('Numero Romaneio');
  LComandos.Add('Vencimento 1');
  LComandos.Add('Parcela 1');
  LComandos.Add('Vencimento 2');
  LComandos.Add('Parcela 2');
  LComandos.Add('Vencimento 3');
  LComandos.Add('Parcela 3');
  LComandos.Add('Vencimento 4');
  LComandos.Add('Parcela 4');
  LComandos.Add('Vencimento 5');
  LComandos.Add('Parcela 5');
  LComandos.Add('Vencimento 6');
  LComandos.Add('Parcela 6');
// ITENS DA NOTA
  LComandos.Add('Codigo serviço');
  LComandos.Add('Descrição do serviço');
  LComandos.Add('ST-Situação tributária');
  LComandos.Add('Unidade serviço');
  LComandos.Add('Quantidade');
  LComandos.Add('Valor unitário');
  LComandos.Add('Valor total');
  LComandos.Add('Alíquota INSS');
// 12.02.09
  LComandos.Add('Alíquota INSS sem decimais');
  LComandos.Add('Perc. desconto');
  LComandos.Add('Unitário bruto');
// 07.05.07
  LComandos.Add('Peças');
// 30.10.07
  LComandos.Add('Vlr IPI Produto');

  LComandos.Add('Base cálculo do INSS');
  LComandos.Add('Valor do INSS');
  LComandos.Add('Base cálculo do ISS');
  LComandos.Add('Valor do ISS');
  LComandos.Add('Valor total dos serviços');
  LComandos.Add('Valor do frete');
  LComandos.Add('Valor do seguro');
  LComandos.Add('Valor Acréscimo/Desconto sobre Total da nota');
  LComandos.Add('Valor Total da nota');
  LComandos.Add('Razão Social transportador');
  LComandos.Add('Tipo de Frete ( CIF/FOB )');
  LComandos.Add('Placa do veículo');
  LComandos.Add('UF veículo');
  LComandos.Add('CNPJ/CPF transportador');
  LComandos.Add('Endereço transportador');
  LComandos.Add('Municipio transportador');
  LComandos.Add('UF transportador');
  LComandos.Add('Inscrição Estadual transportador');
  LComandos.Add('Quantidade volumes');
  LComandos.Add('Espécie volumes');
  LComandos.Add('Total Quantidade');
  LComandos.Add('de transporte');
  LComandos.Add('a transportar');
  LComandos.Add('Codigo usuário');
  LComandos.Add('Nome usuário');
  LComandos.Add('X - Referente entrada');
  LComandos.Add('X - Referente saida');
  LComandos.Add('Condição de Pagamento');
  LComandos.Add('Valor a Vista');
  LComandos.Add('Codigo representante');
  LComandos.Add('Nome representante');
// 08.07.05
  LComandos.Add('Notas devolução');
// 01.09.05
  LComandos.Add('Mensagem 1 (50 caracteres)');
  LComandos.Add('Mensagem 2 (50 caracteres)');
  LComandos.Add('Mensagem 3 (50 caracteres)');
  LComandos.Add('Mensagem 4 (50 caracteres)');
  LComandos.Add('Mensagem 5 (50 caracteres)');
// 13.11.07
  LComandos.Add('Mensagem 1 (90 caracteres)');
  LComandos.Add('Mensagem 2 (90 caracteres)');
  LComandos.Add('Mensagem 3 (90 caracteres)');
  LComandos.Add('Mensagem 4 (90 caracteres)');
  LComandos.Add('Mensagem 5 (90 caracteres)');
// 18.12.07
  LComandos.Add('Mensagem 6 (90 caracteres)');
  LComandos.Add('Mensagem 7 (90 caracteres)');
  LComandos.Add('Mensagem 8 (90 caracteres)');
  LComandos.Add('Mensagem 9 (90 caracteres)');
  LComandos.Add('Mensagem 10(90 caracteres)');
// 15.11.05
  LComandos.Add('Peso Líquido');
  LComandos.Add('Peso Bruto');
  LComandos.Add('Transação');
// 22.06.06
  LComandos.Add('Valor do ipi');
  LComandos.Add('Outras Despesas Acessórias');
// 31.07.06
  LComandos.Add('Codigo IPI');
  LComandos.Add('Classificação IPI(NCM)');
// 25.08.06
  LComandos.Add('Alíquota IPI');
// 19.02.09
  LComandos.Add('Alíquota IPI sem decimais');
//
  LComandos.Add('Lista Classificação IPI(NCM) 01 (40 caracteres)');
  LComandos.Add('Lista Classificação IPI(NCM) 02 (40 caracteres)');
// 09.08.06
  LComandos.Add('Base Icms 01');
  LComandos.Add('Base Icms 02');
  LComandos.Add('Base Icms 03');
  LComandos.Add('CFOP 01');
  LComandos.Add('CFOP 02');
  LComandos.Add('CFOP 03');
// 07.05.07
  LComandos.Add('Nota Produtor');
// 12.12.07
  LComandos.Add('Nota Produtor 2');
  LComandos.Add('Nota Produtor 3');
  LComandos.Add('Nota Produtor 4');
  LComandos.Add('Nota Produtor 5');
/////////
  LComandos.Add('INSS ( antigo funrural )');
  LComandos.Add('Cota Capital');
// 29.05.07
  LComandos.Add('Total Nota - (Cota Capital-INSS)');
// 03.01.08
  LComandos.Add('Porto Embarque');
  LComandos.Add('Porto Destino');
  LComandos.Add('Numero Container');
// 28.02.08
  LComandos.Add('Valor por extenso (linha1)');
  LComandos.Add('Valor por extenso (linha2)');
// 04.03.09
  LComandos.Add('Valor PIS');
  LComandos.Add('Valor COFINS');
  LComandos.Add('Valor CSL');
  LComandos.Add('Valor IR');
  LComandos.Add('Valor Líquido');
// 05.07.10
  LComandos.Add('Alíquota ISS');
// 07.11.18  - para impressao do orçamento no word...
  LComandos.Add('@Total Pedido');

//  LComandos.Add('Chr(xx) = Retorna Codigos ASCII');
//  LComandos.Add('[Macro] = Executa Macro-Subtituição');
  FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  LComandos.Free;
end;

/////////////////////////////////////////////////////////////////
function RetornoNotaSaidaMo(Comando,Especie:String):String;
///////////////////////////////////////////////////////////////////////////
var Dtemissao:TDateTime;
    Valornota,TotalProdutos,Valormaisdesconto,QtdeProdutos,Baseicms,Valoricms,BaseicmsSubs,ValoricmsSubs,
    Valornotamenor:Currency;
    esp:integer;
    ext:string;


    function GetX(cfop,es:string):string;
    begin
      if es='S' then begin
        if pos( copy(cfop,1,1),'5;6;7' )>0 then
          result:='X'
        else
          result:=' ';
      end else begin
        if pos( copy(cfop,1,1),'1;2;3' )>0 then
          result:='X'
        else
          result:=' ';
      end;
    end;


// 10.08.08
    function Tratavalor(valor:currency):string;
    begin
       result:='XX';
       if valor>0 then
         result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
       else begin
         if Nropaginas=1 then
           result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
         else
           result:='******,**';
       end;
    end;

// 19.02.09
    function TratavalorItens(valor:currency;mascara:string):string;
    begin
       result:='XX';
       if valor>0 then
         result:=FConfDcto.TransformDcto(valor,mascara)
       else begin
         if Nropaginas=1 then
           result:=''
         else
           result:='******,**';
       end;
    end;

begin
///////////////////////////////////////////////////////////////////////////////

  Dtemissao:=QMestre.FieldByName('Moes_Dataemissao').AsDateTime;
  result:='';
  if (NroPagina=NroPaginas) and ( Nropaginas=1) then begin
    ValorNota:=QMestre.FieldByName('Moes_Vlrtotal').AsFloat;
    if (QMestre.FieldByName('Moes_Vlrtotal').AsFloat<>QMestre.FieldByName('Moes_Valortotal').AsFloat) and
       (QMestre.FieldByName('Moes_Valortotal').AsFloat>0) then
      ValorNOta:=QMestre.FieldByName('Moes_Valortotal').AsFloat; // 16.09.05
    TotalProdutos:=QMestre.FieldByName('moes_totprod').AsFloat;
    QtdeProdutos:=Tqtdetotal;
//    Baseicms:=QMestre.FieldByName('Moes_Baseicms').AsFloat;
//    Valoricms:=QMestre.FieldByName('Moes_Valoricms').AsFloat;
    Baseicms:=QMestre.FieldByName('Moes_Baseinss').AsFloat;
    Valoricms:=QMestre.FieldByName('Moes_Valorinss').AsFloat;
//    BaseicmsSubs:=QMestre.FieldByName('moes_basesubstrib').AsFloat;
//    ValoricmsSubs:=QMestre.FieldByName('moes_valoricmssutr').AsFloat;
    BaseicmsSubs:=QMestre.FieldByName('moes_baseiss').AsFloat;
    ValoricmsSubs:=QMestre.FieldByName('moes_valoriss').AsFloat;
    if Comando='de transporte' then result:='';
    if Comando='a transportar' then result:='';
  end else if (NroPagina<NroPaginas) and ( Nropaginas>1) then begin
    ValorNota:=0;
    TotalProdutos:=0;
    QtdeProdutos:=0;
    Baseicms:=0;
    Valoricms:=0;
    BaseicmsSubs:=0;
    ValoricmsSubs:=0;
    if NroPagina=1 then begin
       if Comando='de transporte' then result:='';
    end else begin
      if Comando='de transporte' then result:='de transporte';
    end;
    if Comando='a transportar' then result:='a transportar';
  end else begin
    ValorNota:=QMestre.FieldByName('Moes_Vlrtotal').AsFloat;
    TotalProdutos:=QMestre.FieldByName('moes_totprod').AsFloat;
    QtdeProdutos:=Tqtdetotal;
//    Baseicms:=QMestre.FieldByName('Moes_Baseicms').AsFloat;
//    Valoricms:=QMestre.FieldByName('Moes_Valoricms').AsFloat;
//    BaseicmsSubs:=QMestre.FieldByName('moes_basesubstrib').AsFloat;
//    ValoricmsSubs:=QMestre.FieldByName('moes_valoricmssutr').AsFloat;
    Baseicms:=QMestre.FieldByName('Moes_Baseinss').AsFloat;
    Valoricms:=QMestre.FieldByName('Moes_Valorinss').AsFloat;
    BaseicmsSubs:=QMestre.FieldByName('moes_baseiss').AsFloat;
    ValoricmsSubs:=QMestre.FieldByName('moes_valoriss').AsFloat;
    if Comando='de transporte' then result:='de transporte';
    if Comando='a transportar' then result:='';
//  if Comando='Favorecido' then Result:=Trim(QMovBco.FieldByName('Mbco_Favorecido').AsString);
//  if Comando='Bom Para' then Result:='Bom Para: '+DateToStr_(Dt);
  end;
// 29.05.07
  Valornotamenor:=ValorNota-QMestre.fieldbyname('Moes_cotacapital').ascurrency-QMestre.fieldbyname('Moes_funrural').ascurrency;

  if Comando='Codigo Tipo de Movimento' then Result:=QMestre.fieldbyname('Moes_tipomov').asstring
  else if Comando='Tipo de Movimento' then Result:=FGeral.GetTipoMovto(QMestre.fieldbyname('Moes_tipomov').asstring)
  else if Comando='Natureza da Operação' then Result:=FNatureza.GEtDescricao(QMestre.fieldbyname('Moes_Natf_Codigo').asstring)
  else if Comando='CFOP-Codigo fiscal da operação' then Result:=FGEral.FormataNatf(QMestre.fieldbyname('Moes_Natf_Codigo').asstring)
  else if Comando='Inscrição Estadual do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_inscricaoestadual').asstring
  else if Comando='CNPJ do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cnpj').asstring
  else if Comando='Endereço emitente' then Result:=Arq.TUnidades.fieldbyname('unid_endereco').asstring
  else if Comando='Bairro emitente' then Result:=Arq.TUnidades.fieldbyname('unid_bairro').asstring
  else if Comando='CEP emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cep').asstring
  else if Comando='Municipio emitente' then Result:=Arq.TUnidades.fieldbyname('unid_municipio').asstring
  else if Comando='UF emitente' then Result:=Arq.TUnidades.fieldbyname('unid_uf').asstring
  else if Comando='Telefone emitente' then Result:=FGeral.Formatatelefone(Arq.TUnidades.fieldbyname('unid_fone').asstring)
  else if Comando='Data emissão' then Result:=FGeral.formatadata(QMestre.fieldbyname('moes_dataemissao').Asdatetime)
  else if Comando='Data Saída' then result:=FGeral.formatadata(QMestre.fieldbyname('Moes_DataMvto').asdatetime);
//  if QMestre.fieldbyname('moes_tipomov').Asstring<>Global.coddevolucaocompra then begin
// 16.09.05
//  if ( pos(QMestre.fieldbyname('moes_tipomov').asstring,Global.coddevolucaocompra+';'+global.CodCompra+';'+Global.CodCompra100+';'+
//     Global.CodCompraX+';'+Global.CodConhecimento+';'+Global.CodCompraImobilizado+';'+Global.CodCompraMatConsumo+';'+
//     Global.coddevolucaocompraSemestoque+';'+Global.CodRetornoInd+';'+Global.CodRetornocomServicos+';'+
//     Global.CodDevolucaoInd+';'+Global.CodRemessaDemo+';'+Global.CodCompraSemfinan )=0 ) and (QMestre.fieldbyname('moes_tipocad').AsString<>'R') then begin
//// 14.12.07 - clolocado uso do campo tipocad...
  if QMestre.fieldbyname('moes_tipocad').AsString='C' then begin

    if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('clie_razaosocial').asstring
    else if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('clie_cnpjcpf').asstring)
    else if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('clie_codigo').asstring
    else if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('clie_endres').asstring
    else if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('clie_bairrores').asstring
    else if Comando='CEP destinatário' then result:=QClientes.fieldbyname('clie_cepres').asstring;
// 31.07.07 - retirado para nao ficar endereço de 'um lugar' e 'cidade outra'...
//    if QMestre.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor then begin
//      if Comando='Municipio destinatário' then result:=FCidades.GetNome(QMestre.fieldbyname('moes_cida_codigo').asinteger);
//      if Comando='UF destinatário' then result:=QMestre.fieldbyname('moes_estado').asstring;
//    end else begin
      if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('clie_cida_codigo_res').asinteger);
      if Comando='UF destinatário' then result:=QClientes.fieldbyname('clie_uf').asstring;
//    end;
    if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('clie_foneres').asstring);
    if Comando='Inscrição Estadual do destinatário' then begin
      if QClientes.fieldbyname('clie_tipo').asstring='F' then
        Result:='Isento'
      else
        result:=QClientes.fieldbyname('clie_rgie').asstring;
    end;
// 18.05.06

  end else if QMestre.fieldbyname('moes_tipocad').AsString='R' then begin

    if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('repr_razaosocial').asstring
    else if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('repr_cnpjcpf').asstring)
    else if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('repr_codigo').asstring
    else if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('repr_endereco').asstring
    else if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('repr_bairro').asstring
    else if Comando='CEP destinatário' then result:=QClientes.fieldbyname('repr_cep').asstring
    else if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('repr_cida_codigo').asinteger)
    else if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('repr_fone').asstring)
    else if Comando='UF destinatário' then result:=FCidades.GetUF(QClientes.fieldbyname('repr_cida_codigo').asinteger)
    else if Comando='Inscrição Estadual do destinatário' then  result:=QClientes.fieldbyname('repr_inscricaoestadual').asstring;
//////////////////////////
  end else begin
    if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('forn_razaosocial').asstring
    else if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('forn_cnpjcpf').asstring)
    else if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('forn_codigo').asstring
    else if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('forn_endereco').asstring
    else if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('forn_bairro').asstring
    else if Comando='CEP destinatário' then result:=QClientes.fieldbyname('forn_cep').asstring
    else if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('forn_cida_codigo').asinteger)
    else if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('forn_fone').asstring)
    else if Comando='UF destinatário' then result:=QClientes.fieldbyname('forn_uf').asstring
    else if Comando='Inscrição Estadual do destinatário' then begin
      result:=QClientes.fieldbyname('forn_inscricaoestadual').asstring;
    end;
  end;
  if Comando='Hora Saída' then result:=Timetostr(Time);
//  if Comando='Numero Nota' then result:=QMestre.fieldbyname('moes_numerodoc').asstring;
// 11.11.05 - fical chupisco no porta nao gosta de nf com nros 7,8,9,,tem q ser 007, 008,,,bichona loka mesmo...
  if Comando='Numero Nota' then result:=strzero(QMestre.fieldbyname('moes_numerodoc').asinteger,7);
  if Comando='Numero Romaneio' then result:=QMestre.fieldbyname('moes_romaneio').asstring;

  if Comando='Vencimento 1' then result:=venc1;
  if Comando='Parcela 1' then
     result:=parc1 else
  if Comando='Vencimento 2' then result:=venc2 else
  if Comando='Parcela 2' then result:=parc2 else
  if Comando='Vencimento 3' then result:=venc3 else
  if Comando='Parcela 3' then result:=parc3 else
  if Comando='Vencimento 4' then result:=venc4 else
  if Comando='Parcela 4' then result:=parc4 else
  if Comando='Vencimento 5' then result:=venc5 else
  if Comando='Parcela 5' then result:=parc5 else
  if Comando='Vencimento 6' then result:=venc6 else
  if Comando='Parcela 6' then result:=parc6;

// dados q "se repetem"
  esp:=Inteiro(especie)-1;
  if ( esp >= 0) and (Inteiro(especie)<=ListaDetalhe.Count) then begin
    PDetalhe:=ListaDetalhe[esp];

//  if ListaDetalhe.Count>0 then begin
//    FImpressao.EdPosicao.setvalue(esp);  // 03.09.04

    if Comando='Codigo serviço' then result:=PDetalhe.Codigoproduto
    else if Comando='Descrição do serviço' then result:=PDetalhe.Descricaoproduto
    else if Comando='ST-Situação tributária' then result:=PDetalhe.Cst
    else if Comando='Unidade serviço' then result:=PDetalhe.Unidade
//    else if Comando='Quantidade' then result:=FGeral.Formatavalor(PDetalhe.Quantidade,FConfDcto.FormatoQtdes)
    else if Comando='Quantidade' then result:=TratavalorItens(PDetalhe.Quantidade,FConfDcto.FormatoQtdes)
    else if Comando='Valor unitário' then result:=TratavalorItens(PDetalhe.Unitario,FConfDcto.FormatoValoresUn)
    else if Comando='Valor total' then result:=TratavalorItens(PDetalhe.Total,FConfDcto.FormatoValores)
    else if Comando='Alíquota INSS' then result:=TratavalorItens(PDetalhe.icms,'#0.0')
// 12.02.09
    else if Comando='Alíquota INSS sem decimais' then result:=TratavalorItens(PDetalhe.icms,'#0')
    else if Comando='Perc. desconto' then result:=FGeral.Formatavalor(PDetalhe.perdesco,FConfDcto.FormatoValores)
    else if Comando='Unitário bruto' then result:=TratavalorItens(PDetalhe.vendabru,FConfDcto.FormatoValores)
// 31.07.06
    else if Comando='Codigo IPI' then result:=inttostr(PDetalhe.Codigoipi)
    else if Comando='Classificação IPI(NCM)' then result:=PDetalhe.Ncmipi
// 25.08.06
    else if Comando='Alíquota IPI' then result:=TratavalorItens(PDetalhe.ipi,'#0.0')
// 19.02.09
    else if Comando='Alíquota IPI sem decimais' then result:=TratavalorItens(PDetalhe.ipi,'#0')
//  07.05.07
    else if Comando='Peças' then result:=FGeral.Formatavalor(PDetalhe.pecas,FConfDcto.FormatoQtdes)
//  31.10.07
    else if Comando='Vlr IPI Produto' then result:=TratavalorItens(PDetalhe.Total*(PDetalhe.ipi/100),FConfDcto.FormatoValores)
// 09.08.05
    else result:=tiraaspas(comando); // para imprimir strings colocadas no detalhe
  end;                                 ///       FConfDcto.TransformDcto(Valor,FConfDcto.FormatoValores);

//  if Comando='Base cálculo do ICMS' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_Baseicms').ascurrency,FConfDcto.FormatoValores);
//  if Comando='Base cálculo do ICMS' then result:=FConfDcto.TransformDcto(Baseicms,FConfDcto.FormatoValores);
  if Comando='Base cálculo do INSS' then result:=Tratavalor(Baseicms);
//  if Comando='Valor do ICMS' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_Valoricms').ascurrency,FConfDcto.FormatoValores);
// 08.08.05
//  if Comando='Valor do ICMS' then result:=FConfDcto.TransformDcto(Valoricms,FConfDcto.FormatoValores);
  if Comando='Valor do INSS' then result:=Tratavalor(Valoricms);

  ext:=UpperCaseBras( Extenso(valornota) );

  if Comando='Base cálculo do ISS' then result:=Tratavalor(BaseIcmsSubs);
  if Comando='Valor do ISS' then result:=Tratavalor(ValorIcmsSubs);
//  if Comando='Valor total dos produtos' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_totprod').ascurrency,FConfDcto.FormatoValores);
  if Comando='Valor do frete' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_frete').ascurrency,FConfDcto.FormatoValores);
  if Comando='Valor do seguro' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_seguro').ascurrency,FConfDcto.FormatoValores);

  if Comando='Valor Total da nota' then
    result:=Tratavalor(valornota);
  if Comando='Valor total dos produtos' then
    result:=Tratavalor(totalprodutos);

  if Comando='Razão Social transportador' then begin
// 18.08.05
    if Arq.TTransp.fieldbyname('tran_razaosocial').asstring='' then
      result:=Arq.TTransp.fieldbyname('tran_nome').asstring
    else
      result:=Arq.TTransp.fieldbyname('tran_razaosocial').asstring;
  end;
  if Comando='Tipo de Frete ( CIF/FOB )' then result:=QMestre.fieldbyname('Moes_FreteCifFob').asstring;
  if Comando='Placa do veículo' then result:=Arq.TTransp.fieldbyname('tran_placa').asstring;
  if Comando='UF veículo' then result:=Arq.TTransp.fieldbyname('tran_ufplaca').asstring;
  if Comando='CNPJ/CPF transportador' then result:=Arq.TTransp.fieldbyname('tran_cnpjcpf').asstring;
  if Comando='Endereço transportador' then result:=Arq.TTransp.fieldbyname('tran_endereco').asstring;
  if Comando='Municipio transportador' then result:=FCidades.GetNome(Arq.TTransp.fieldbyname('tran_cida_codigo').asinteger);
  if Comando='UF transportador' then result:=FCidades.GetUF(Arq.TTransp.fieldbyname('tran_cida_codigo').asinteger);
  if Comando='Inscrição Estadual transportador' then result:=Arq.TTransp.fieldbyname('tran_inscricaoestadual').asstring;
  if Comando='Quantidade volumes' then result:=QMestre.fieldbyname('Moes_qtdevolume').asstring;
  if Comando='Espécie volumes' then result:=QMestre.fieldbyname('Moes_especievolume').asstring;
//  if Comando='Total Quantidade' then result:=FConfDcto.TransformDcto(PDetalhe.Tquantidade,FConfDcto.formatoQtdesInt);
// 07.04.05
    if Comando='Total Quantidade' then result:=FConfDcto.TransformDcto(Qtdeprodutos,FConfDcto.formatoQtdesInt);
  if Comando='Valor Acréscimo/Desconto sobre Total da nota' then begin
    if QMestre.fieldbyname('Moes_perdesco').ascurrency>0 then begin
//      result:='Desconto  : '+FConfDcto.TransformDcto( (totalprodutos)/(QMestre.fieldbyname('Moes_perdesco').ascurrency/100) ,FConfDcto.FormatoValores)
// 08.03.05
      Valormaisdesconto:=(totalprodutos)/(1-(QMestre.fieldbyname('Moes_perdesco').ascurrency/100));
      result:='Desconto  : '+FConfDcto.TransformDcto(Valormaisdesconto-totalprodutos ,FConfDcto.FormatoValores)
    end else if QMestre.fieldbyname('Moes_peracres').ascurrency>0 then begin
      result:='Acréscimo : '+FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_peracres').ascurrency,FConfDcto.FormatoValores)
    end else
      result:='';
  end;
  if Comando='Codigo usuário' then result:=QMestre.fieldbyname('moes_usua_codigo').asstring
  else if Comando='Nome usuário' then result:=FUsuarios.GetNome(QMestre.fieldbyname('moes_usua_codigo').asinteger)
// 17.05.05
  else if Comando='X - Referente entrada' then result:=GetX(QMestre.fieldbyname('moes_natf_codigo').asstring,'E')
  else if Comando='X - Referente saida' then result:=GetX(QMestre.fieldbyname('moes_natf_codigo').asstring,'S')
  else if Comando='Condição de Pagamento' then result:=FCondpagto.getreduzido(condicao)
  else if Comando='Valor a Vista' then result:=FConfDcto.TransformDcto(valoravista,FConfDcto.FormatoValores)
  else if Comando='Codigo representante' then result:=QMestre.fieldbyname('moes_repr_codigo').asstring
  else if Comando='Nome representante' then result:=FRepresentantes.GetDescricao(QMestre.fieldbyname('moes_repr_codigo').asinteger)
// 08.07.05
  else if Comando='Notas devolução' then result:=(QMestre.fieldbyname('moes_remessas').asstring)
// 01.09.05
  else if Comando='Mensagem 1 (50 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,001,50)
  else if Comando='Mensagem 2 (50 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,051,50)
  else if Comando='Mensagem 3 (50 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,101,50)
  else if Comando='Mensagem 4 (50 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,151,50)
  else if Comando='Mensagem 5 (50 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,201,50)
// 13.11.07
  else if Comando='Mensagem 1 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,001,90)
  else if Comando='Mensagem 2 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,091,90)
  else if Comando='Mensagem 3 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,181,90)
  else if Comando='Mensagem 4 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,271,90)
  else if Comando='Mensagem 5 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,361,90)
// 18.12.07
  else if Comando='Mensagem 6 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,451,90)
  else if Comando='Mensagem 7 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,541,90)
  else if Comando='Mensagem 8 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,631,90)
  else if Comando='Mensagem 9 (90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,721,90)
  else if Comando='Mensagem 10(90 caracteres)' then result:=copy(QMestre.fieldbyname('moes_mensagem').asstring,811,90)

// 15.11.05
  else if Comando='Peso Líquido' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('moes_pesoliq').ascurrency,FConfDcto.FormatoQtdesInt)
  else if Comando='Peso Bruto' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('moes_pesobru').ascurrency,FConfDcto.FormatoQtdesInt)
// 05.01.06
  else if Comando='Transação' then result:=QMestre.fieldbyname('moes_transacao').asstring
// 22.06.06
  else if Comando='Valor do ipi' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_valoripi').ascurrency,FConfDcto.FormatoValores)
  else if Comando='Outras Despesas Acessórias' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_outrasdesp').ascurrency,FConfDcto.FormatoValores);
// 31.07.06
  if Comando='Base Icms 01' then result:=FConfDcto.TransformDcto(baseicms01,FConfDcto.FormatoValores)
  else if Comando='Base Icms 02' then begin
    if trim(cfop02)<>'' then
      result:=FConfDcto.TransformDcto(baseicms02,FConfDcto.FormatoValores)
    else
      result:='';
  end else if Comando='Base Icms 03' then begin
    if trim(cfop03)<>'' then
      result:=FConfDcto.TransformDcto(baseicms03,FConfDcto.FormatoValores)
    else
      result:='';
  end else if Comando='Lista Classificação IPI(NCM) 01 (40 caracteres)' then result:=copy(Listaclassificaoipi,1,40)
  else if Comando='Lista Classificação IPI(NCM) 02 (40 caracteres)' then result:=copy(Listaclassificaoipi,41,40)
  else if Comando='CFOP 01' then result:=cfop01
  else if Comando='CFOP 02' then result:=cfop02
  else if Comando='CFOP 03' then result:=cfop03
// 07.05.07
  else if Comando='Nota Produtor' then result:=QMestre.fieldbyname('Moes_notapro').asstring
// 12.12.07
  else if Comando='Nota Produtor 2' then result:=QMestre.fieldbyname('Moes_notapro2').asstring
  else if Comando='Nota Produtor 3' then result:=QMestre.fieldbyname('Moes_notapro3').asstring
  else if Comando='Nota Produtor 4' then result:=QMestre.fieldbyname('Moes_notapro4').asstring
  else if Comando='Nota Produtor 5' then result:=QMestre.fieldbyname('Moes_notapro5').asstring
  else if Comando='INSS ( antigo funrural )' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_funrural').ascurrency,FConfDcto.FormatoValores)
  else if Comando='Cota Capital' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('Moes_cotacapital').ascurrency,FConfDcto.FormatoValores)
// 29.05.07
  else if Comando='Total Nota - (Cota Capital-INSS)' then result:=FConfDcto.TransformDcto(Valornotamenor,FConfDcto.FormatoValores)
// 03.01.08
  else if Comando='Porto Embarque' then begin
    if trim(QMestre.fieldbyname('Moes_embarque').asstring)<>'' then
      result:='Porto Embarque : '+QMestre.fieldbyname('Moes_embarque').asstring
    else
      result:='';
  end else if Comando='Porto Destino' then begin
     if trim(QMestre.fieldbyname('Moes_destino').asstring)<>'' then
       result:='Porto Destino : '+QMestre.fieldbyname('Moes_destino').asstring
     else
       result:='';
  end else if Comando='Numero Container' then  begin
    if trim(QMestre.fieldbyname('Moes_container').asstring)<>'' then
      result:='Nro. Container : '+QMestre.fieldbyname('Moes_container').asstring
    else
      result:='';
  end else if Comando='Valor por extenso (linha1)' then result:=copy(ext,1,55)
  else if Comando='Valor por extenso (linha2)' then result:=copy(ext,56,55)
// 04.03.09
  else if Comando='Valor PIS' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('moes_valorpis').ascurrency,FConfDcto.FormatoValores)
  else if Comando='Valor COFINS' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('moes_valorcofins').ascurrency,FConfDcto.FormatoValores)
  else if Comando='Valor CSL' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('moes_valorcsl').ascurrency,FConfDcto.FormatoValores)
  else if Comando='Valor IR' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('moes_valorir').ascurrency,FConfDcto.FormatoValores)
  else if Comando='Valor Líquido' then result:=FConfDcto.TransformDcto(valornota-(QMestre.fieldbyname('moes_valoriss').ascurrency+QMestre.fieldbyname('moes_valorir').ascurrency+QMestre.fieldbyname('moes_valorcsl').ascurrency+QMestre.fieldbyname('moes_valorcofins').ascurrency+QMestre.fieldbyname('moes_valorpis').ascurrency+Valoricms),FConfDcto.FormatoValores)
  else if Comando='Alíquota ISS' then result:=FConfDcto.TransformDcto(QMestre.fieldbyname('moes_periss').ascurrency,'##.00');
// 05.07.10

end;

function TFImpressao.ImprimeNotaSaidaMo(Nota: Integer; DataMvto: TDatetime;  Unidade, tipomov: string): Boolean;
/////////////////////////////////////////////////////////////////////////////////////
var n,nn,p,r:Integer;
    FormaImpressao,Codigo,sqltipomovm,sqltipomovd,xcodigo,sqlemissao,DescricaoTamanho,DescricaoCor:String;
    valortotal,Tvalortotal,base:currency;
    QMovbase,QSer:TSqlquery;
    ListaCfops,ListaBases:TStringlist;
    achou:boolean;

    procedure Envia_Impressora;
    var count,countgeral,i:integer;
    begin
      NroPagina:=1;
      NroPaginas:=1;
{
      count:=1;countgeral:=0;
      for i:=0 to ListaDetalhe.count-1 do begin
        Inc(countgeral);
        if countgeral>FConfdcto.NumLgPg then begin   // ver quantas páginas tera a nota
          inc(count);
          countgeral:=0;
        end;
      end;
}

      if FConfdcto.NumLgPg>0 then begin
        if Listadetalhe.count mod FConfdcto.NumLgPg = 0 then
          count:= Listadetalhe.count div FConfdcto.NumLgPg
        else
          count:= Listadetalhe.count div FConfdcto.NumLgPg + 1;
        if count=0 then  //  15.08.05 - credito de chu peças sem itens
          count:=1;
      end else
        count:=1;

      NroPaginas:=count;
      for i:=1 to count do begin
        NroPagina:=i;
        FConfDcto.Print(Codigo, RetornoNotaSaidaMo, i = 1, i = count);
        if count>1 then
          FConfDcto.GetConfiguracao(Codigo);

      end;
    end;


begin
//////////////////////////////////////////////////////////////

  Result:=True;
// 19.02.09 - 09.03.09 -
  TamanhoImpressaoDescricao:=FGeral.GetConfig1AsInteger('TAMDESCRINFSER');

  if not Arq.TUnidades.active then Arq.TUnidades.Open;
//  if not Arq.TClientes.active then Arq.TClientes.Open;
  if not Arq.TNatFisc.active then Arq.TNatFisc.open;
  if Arq.TTransp.active then Arq.TTransp.close;
  Arq.TTransp.open;
  if trim(tipomov)='' then begin
// 12.06.07 - colocado estes tipos 'padrao'
    sqltipomovm:=' and '+FGeral.GetIN('moes_tipomov',Global.CodPrestacaoServicos,'C') ;
    sqltipomovd:=' and '+FGeral.GetIN('move_tipomov',Global.CodPrestacaoServicos,'C') ;
  end else begin
    sqltipomovm:=' and moes_tipomov='+stringtosql(tipomov);
    sqltipomovd:=' and move_tipomov='+stringtosql(tipomov);
  end;
// 12.06.07
  if Datetoano(Datamvto,true)<1910 then
    sqlemissao:=''
  else
    sqlemissao:=' and moes_dataemissao='+Datetosql(Datamvto);
  try
    QMestre:=sqltoquery('select * from movesto '+
                     ' where moes_numerodoc='+inttostr(Nota)+
                     sqlemissao+
                     ' and moes_unid_codigo='''+unidade+''''+
                     sqltipomovm+
                     ' and '+Fgeral.getin('moes_status','N;D;E;F','C')+
                     ' order by moes_numerodoc' );
    QMestre.Name:='QMestre';
    if not QMestre.Eof then begin
//      if QMestre.fieldbyname('moes_Datacont').asdatetime<=1 then
//          Codigo:=FGeral.GetConfig1AsString('Imprnotasaidas')
//      else
        Codigo:=FGeral.GetConfig1AsString('ImprnotasaiMO');
{
///////////////////////////////////////////////
// 08.07.05
      if tipomov=Global.CodVendaSerie4 then
          Codigo:=FGeral.GetConfig1AsString('Imprnfserie4')
      else if tipomov=Global.CodRomaSerie4 then
          Codigo:=FGeral.GetConfig1AsString('Imprromaretorno')   // 06.08.05
      else if tipomov=Global.CodDevolucaoSerie5 then
          Codigo:=FGeral.GetConfig1AsString('Impromaserie5')
// 07.05.07
      else if tipomov=Global.CodCompraProdutor then
          Codigo:=FGeral.GetConfig1AsString('Imprnfprodutor');
// 28.08.06 - nf da exportacao com valores de ipi
      if unidade=Global.unidadeexportacao then begin
          if trim( FGeral.GetConfig1AsString('notasaida100') )<>'' then
            codigo:=FGeral.GetConfig1AsString('notasaida100');
      end;
///////////////////////////
}
      if trim(codigo)='' then begin
         Avisoerro('Falta configurar o codigo deste impresso na configuração geral');
         QMestre.close;
         Freeandnil(QMestre);
         exit;
      end;

      Arq.TUnidades.locate('unid_codigo',unidade,[]);
      QPendencia:=sqltoquery('select * from pendencias where pend_transacao='+stringtosql(QMestre.fieldbyname('moes_Transacao').AsString)+
                            ' and pend_status<>''C'' and pend_unid_codigo='+stringtosql(unidade)+
                            ' order by pend_datavcto');
      npar:=0;
      parc1:='';parc2:='';parc3:='';parc4:='';parc5:='';parc6:='';
      venc1:='';venc2:='';venc3:='';venc4:='';venc5:='';venc6:='';
      condicao:='001';
      valoravista:=QMestre.fieldbyname('moes_vlrtotal').ascurrency;
// 10.08.05
      Result:=FConfDcto.GetConfiguracao(Codigo);

      if not QPendencia.eof then begin
        valoravista:=QMestre.fieldbyname('moes_valoravista').ascurrency;
        npar:=1;
        condicao:=QPendencia.fieldbyname('pend_fpgt_codigo').asstring;
        while not QPendencia.eof do begin
          if npar=1 then begin
// 01.07.05
             if (valoravista>0) and (valoravista<>QPendencia.fieldbyname('pend_valor').ascurrency) then begin
               venc1:='a Vista ';
               parc1:=formatfloat(FConfDcto.FormatoValores,valoravista);
               venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
//               parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,'###,###.##')
//               parc2:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('pend_valor').ascurrency);
             end else begin
               venc1:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
//             parc1:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
// 01.07.05 - algumas notas com parte a vista e a prazo não imprimiam o valor da primeira parcela somente o vencimento
               parc1:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('pend_valor').ascurrency);
             end;
          end else if npar=2 then begin
             if valoravista=0 then begin
               parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores);
               venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             end else begin
               parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores);
               venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             end;
          end else if npar=3 then begin
             if valoravista=0 then begin
               venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end else begin
               venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end;
          end else if npar=4 then begin
             if valoravista=0 then begin
               venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end else begin
               venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
               parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
             end;
          end else if npar=5 then begin
             venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=6 then begin
             venc6:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc6:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end;
          inc(npar);
          QPendencia.Next;
        end;
      end else begin   // se for toda a vista
        QPendencia.close;
        QPendencia:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(QMestre.fieldbyname('moes_Transacao').AsString)+
                               ' and movf_status<>''C''');
        if not QPendencia.eof then begin
           venc1:='a Vista ';
           parc1:=formatfloat(FConfDcto.FormatoValores,QPendencia.fieldbyname('movf_valorger').ascurrency);
        end;
      end;
// 14.12.07 - clolocado uso do campo tipocad...
//      if ( pos(QMestre.fieldbyname('moes_tipomov').asstring,Global.coddevolucaocompra+';'+global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+
//         Global.CodConhecimento+';'+Global.CodCompraImobilizado+';'+Global.CodCompraMatConsumo+';'+Global.coddevolucaocompraSemEstoque+';'+
//         Global.CodDevolucaoInd+';'+Global.CodRetornoInd+';'+Global.CodRetornocomServicos+';'+Global.CodRemessaDemo+';'+Global.CodCompraSemfinan)>0 )
//         and (QMestre.fieldbyname('moes_tipocad').AsString<>'R')  then
      if  (QMestre.fieldbyname('moes_tipocad').AsString='F')  then
        QClientes:=sqltoquery('select * from fornecedores where forn_codigo='+QMestre.fieldbyname('moes_tipo_codigo').asstring)
// 18.05.06
      else if QMestre.fieldbyname('moes_tipocad').asstring='R' then
        QClientes:=sqltoquery('select * from representantes where repr_codigo='+QMestre.fieldbyname('moes_tipo_codigo').asstring)
      else
        QClientes:=sqltoquery('select * from clientes where clie_codigo='+QMestre.fieldbyname('moes_tipo_codigo').asstring);
      QClientes.Name:='QClientes';
///////////      Arq.TTransp.First;   // 10.08.05

      Arq.TTransp.Locate('tran_codigo',QMestre.fieldbyname('moes_tran_codigo').asstring,[]);
      ListaNcm:=TStringlist.create;
// 08.08.06
      Baseicms01:=0;baseicms02:=0;baseicms03:=0;
      QMovbase:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(QMestre.fieldbyname('moes_Transacao').AsString)+
                           ' and movb_status<>''C''');
      ListaCfops:=TStringlist.create;
      ListaBases:=TStringlist.create;
      cfop01:='';cfop02:='';cfop03:='';
      while not Qmovbase.eof do begin
        if trim(QMovbase.fieldbyname('movb_natf_codigo').asstring)<>'' then begin
           if ListaCfops.indexof(QMovbase.fieldbyname('movb_natf_codigo').asstring)=-1 then begin
             Listacfops.add(QMovbase.fieldbyname('movb_natf_codigo').asstring);
             ListaBases.add(QMovbase.fieldbyname('movb_basecalculo').asstring)
           end else begin
             base:=strtofloat( LIstabases[ListaCfops.indexof(QMovbase.fieldbyname('movb_natf_codigo').asstring)] )
                   +QMovbase.fieldbyname('movb_basecalculo').ascurrency ;
             LIstabases[ListaCfops.indexof(QMovbase.fieldbyname('movb_natf_codigo').asstring)]:=floattostr(base);
           end;
        end;
        QMovbase.next;
      end;
      FGeral.Fechaquery(QMovbase);
      for p:=0 to ListaCfops.count-1 do begin
        if p=0 then begin
          baseicms01:=strtofloat(ListaBases[p]);
          cfop01:=Listacfops[p];
        end else if p=1 then begin
          baseicms02:=strtofloat(ListaBases[p]);
          cfop02:=Listacfops[p];
        end else if p=2 then begin
          baseicms03:=strtofloat(ListaBases[p]);
          cfop03:=Listacfops[p];
        end;
      end;
      FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
       if (FormaImpressao='2') or ((FormaImpressao='1') and (Confirma('Confirma a impressão ?'))) then begin
//          Result:=FConfDcto.GetConfiguracao(Codigo);
          if Result then begin
             Sistema.BeginProcess('imprimindo nota fiscal');
             nn:=0;
             QMestre.First;
             while not QMestre.Eof do begin
               Inc(nn);
               QMestre.Next;
             end;
             QMestre.First;
             n:=0;
             while not QMestre.Eof do begin
               Inc(n);
// detalhes q se repetem
               QDetalhe:=sqltoquery('select * from movestoque '+
//                     ' inner join estoque on (esto_codigo=move_esto_codigo)'+
//                     ' inner join cadmobra on (cadm_codigo=move_esto_codigo)'+
//                     ' left join codigosipi on (cipi_codigo=esto_cipi_codigo)'+
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' left join cores on (core_codigo=move_core_codigo)'+
                     ' where move_transacao='''+QMestre.fieldbyname('moes_transacao').asstring+''''+
                     ' and '+FGeral.GetIN('move_status','N;D;E;F','C')+
                     sqltipomovd+
                     ' and move_numerodoc='+QMestre.fieldbyname('moes_numerodoc').asstring+
                     ' order by move_aliicms,move_esto_codigo' );
               ListaDetalhe := TList.Create;valortotal:=0;TValortotal:=0;TQtdetotal:=0;
               if Qdetalhe.eof then  // 01.07.05
                 Avisoerro('Iten(s) não encontrados ou não cadastrados no estoque');
               while not QDetalhe.Eof do begin
// 16.08.06 - para 'condensar' cores e tamanhos somente na impressao
                 achou:=false;
                 QSer:=sqltoquery('select * from cadmobra where cadm_codigo='+inttostr(strtoint(QDetalhe.fieldbyname('move_esto_codigo').asstring)));
// 12.11.07 - por enquanto retirado para nao condensar mais...futuramente criar configuração geral..
//                 for p:=0 to ListaDetalhe.count-1 do begin
//                   PDetalhe:=ListaDetalhe[p];
//                   if (PDetalhe.Codigoproduto=Qdetalhe.fieldbyname('Move_esto_codigo').AsString) then begin
///                      (PDetalhe.CodigoTamanho=Qdetalhe.fieldbyname('Move_tama_codigo').AsInteger) and
///                      (PDetalhe.CodigoCor=Qdetalhe.fieldbyname('Move_core_codigo').AsInteger)  then begin
//                      achou:=true;
//                      break;
//                   end;
//                 end;
                 if not achou then begin
                   New(PDetalhe);
                   PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('Move_esto_codigo').AsString;
// 19.02.09
                   if Global.Topicos[1208] then
                     PDetalhe.Descricaoproduto:=Qdetalhe.fieldbyname('Move_descricao').Asstring
                   else
                     PDetalhe.Descricaoproduto:=copy(Qdetalhe.fieldbyname('move_descricao').Asstring,1,50);
// 19.02.09
                   if (length(trim(PDetalhe.Descricaoproduto))>TamanhoImpressaoDescricao) and (TamanhoImpressaoDescricao>0) then
                     PDetalhe.Descricaoproduto:=copy(Qdetalhe.fieldbyname('move_descricao').Asstring,1,TamanhoImpressaoDescricao);
// 12.11.09
                   if Global.Topicos[1310] then begin
                     DescricaoTamanho:=Qdetalhe.fieldbyname('Tama_descricao').AsString;
                     DescricaoCor:=Qdetalhe.fieldbyname('Core_descricao').AsString;
                     PDetalhe.Descricaoproduto:=PDetalhe.Descricaoproduto+' '+Descricaocor+' '+DescricaoTamanho;
                   end;
                   PDetalhe.Cst:=Qdetalhe.fieldbyname('Move_cst').AsString;
//                   PDetalhe.Unidade:=Qdetalhe.fieldbyname('cadm_unidade').Asstring;
// 04.03.09 - nao da pra fazer inner join do movestoque com cadmobra pois neste o codigo é
//            numerico
                   PDetalhe.Unidade:=FCadServicos.GetUnidade( strtointdef(Qdetalhe.fieldbyname('move_esto_codigo').Asstring,0) );
                   PDetalhe.Quantidade:=Qdetalhe.fieldbyname('move_qtde').Ascurrency;
                   PDetalhe.TQuantidade:=PDetalhe.TQuantidade+Qdetalhe.fieldbyname('move_qtde').AsCurrency;
                   PDetalhe.Unitario:=Qdetalhe.fieldbyname('move_venda').AsCurrency;
                   valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('move_venda').AsCurrency*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
                   PDetalhe.Total:=valortotal;
                   PDetalhe.icms:=Qdetalhe.fieldbyname('move_aliicms').AsCurrency;
                   PDetalhe.perdesco:=Qdetalhe.fieldbyname('move_perdesco').AsCurrency;
                   PDetalhe.vendabru:=Qdetalhe.fieldbyname('move_vendabru').AsCurrency;
  // 31.07.06
                   PDetalhe.Codigoipi:=0; // QDetalhe.fieldbyname('esto_cipi_codigo').asinteger;
                   PDetalhe.Ncmipi:='';  // QDetalhe.fieldbyname('cipi_codfiscal').asstring;
// 25.08.06
                   PDetalhe.ipi:=Qdetalhe.fieldbyname('move_aliipi').AsCurrency;
// 07.05.07
                   PDetalhe.pecas:=Qdetalhe.fieldbyname('move_pecas').AsCurrency;
                   ListaDetalhe.Add(Pdetalhe);
//                   Adicionalista(ListaNcm,QDetalhe.fieldbyname('esto_cipi_codigo').asstring+'-'+QDetalhe.fieldbyname('cipi_codfiscal').asstring);
// 19.02.09
                   if (length(trim(Qdetalhe.fieldbyname('move_descricao').Asstring))>TamanhoImpressaoDescricao) and (TamanhoImpressaoDescricao>0)
                     then begin
                     descricaogrande:=Qdetalhe.fieldbyname('move_descricao').Asstring;
                     New(PDetalhe);
                     PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('Move_esto_codigo').AsString;
                     PDetalhe.Descricaoproduto:=copy(Descricaogrande,TamanhoImpressaoDescricao+1,50);
                     if Global.Topicos[1310] then begin
                       DescricaoTamanho:=Qdetalhe.fieldbyname('Tama_descricao').AsString;
                       DescricaoCor:=Qdetalhe.fieldbyname('Core_descricao').AsString;
                       PDetalhe.Descricaoproduto:=PDetalhe.Descricaoproduto+' '+Descricaocor+' '+DescricaoTamanho;
                     end;
                     PDetalhe.Cst:='';
                     PDetalhe.Unidade:='';
                     PDetalhe.Quantidade:=0;
                     PDetalhe.TQuantidade:=0;
                     PDetalhe.Unitario:=0;
                     PDetalhe.Total:=0;
                     PDetalhe.icms:=0;
                     PDetalhe.perdesco:=0;
                     PDetalhe.vendabru:=0;
                     PDetalhe.Codigoipi:=0;
                     PDetalhe.Ncmipi:='';
                     PDetalhe.ipi:=0;
                     PDetalhe.pecas:=0;
                     ListaDetalhe.Add(Pdetalhe);
                   end;
// 13.03.09 - pula linhas
                   if QSer.fieldbyname('Cadm_Pulalinha').asinteger>0 then begin
                     for r:=1 to QSer.fieldbyname('Cadm_Pulalinha').asinteger do begin
                       New(PDetalhe);
                       PDetalhe.Codigoproduto:='';
                       PDetalhe.Descricaoproduto:='';
                       if Global.Topicos[1310] then begin
                         DescricaoTamanho:='';
                         DescricaoCor:='';
                         PDetalhe.Descricaoproduto:='';
                       end;
                       PDetalhe.Cst:='';
                       PDetalhe.Unidade:='';
                       PDetalhe.Quantidade:=0;
                       PDetalhe.TQuantidade:=0;
                       PDetalhe.Unitario:=0;
                       PDetalhe.Total:=0;
                       PDetalhe.icms:=0;
                       PDetalhe.perdesco:=0;
                       PDetalhe.vendabru:=0;
                       PDetalhe.Codigoipi:=0;
                       PDetalhe.Ncmipi:='';
                       PDetalhe.ipi:=0;
                       PDetalhe.pecas:=0;
                       ListaDetalhe.Add(Pdetalhe);
                     end;
                   end;
                 end else begin
                   PDetalhe.quantidade:=PDetalhe.quantidade+Qdetalhe.fieldbyname('move_qtde').AsCurrency;
                   valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('move_venda').AsCurrency*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
                   PDetalhe.Total:=PDetalhe.Total+valortotal;
                 end;
                 Tvalortotal:=Tvalortotal+valortotal;
                 TQtdetotal:=TQtdetotal+Qdetalhe.fieldbyname('move_qtde').Ascurrency;
                 QDetalhe.Next;
                 FGeral.FechaQuery(QSer);
               end;
// 31.07.06
               Listaclassificaoipi:=GetLista(LIstaNcm,' ');
                                            // 15.08.05 - tentar imprimir devolução sem itens - credito de peaçs
               if (not QDetalhe.IsEmpty) or (tipomov=Global.CodDevolucaoVenda) then begin
                  Envia_Impressora;
               end;  // QDetalhe.isempty

               QDetalhe.Close;Listadetalhe.Free;
               QMestre.Next;
             end;
             Sistema.EndProcess('');

//             if (Global.CodigoUnidade<>Global.UnidadeMatriz) and ( pos('EPSON',uppercase(FConfDcto.ImprMat.NomeImpressora))=0 )
//               then
//               FGeral.Gravalog(99,'Impressora '+FConfDcto.ImprMat.NomeImpressora,true);
          end;

       end;

       Qclientes.close;
       QPendencia.close;
       Freeandnil(Qclientes);
       Freeandnil(QPendencia);
    end else begin   // 29.04.05 - ijui 'começou a nao imprimir a nf de VC logo depois do acerto'
      Avisoerro('Nota fiscal '+inttostr(Nota)+' de '+Datetostr(Datamvto)+' não encontrada.  Tipo '+tipomov);
//      Avisoerro(QMestre.sql.text);
// 10.02.05 - com avisoerro nao 'cabe' a select
//      showmessage(QMestre.sql.text);
// 11.02.05 - mudado para data emissao na select

    end;

    QMestre.Close;Freeandnil(QMestre);
    if QDetalhe<>nil then
       Freeandnil(QDetalhe);
  except
  end;
  Sistema.EndProcess('');

end;

//////// 20.05.10
procedure TFImpressao.ConfEtqProduto(Codigo, Descricao: String);
/////////////////////////////////////////////////////////////////////////
var Tit:String;
    LComandos:TStringList;
begin
  Tit:='Configuração Etiqueta Produto / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
  LComandos.Add('Codigo');
  LComandos.Add('Descrição');
// 10.07.13
  LComandos.Add('Descrição (posição 1 a 22)');
  LComandos.Add('Descrição (posição 23 a 50)');
  LComandos.Add('Unidade');
  LComandos.Add('Referência');
  LComandos.Add('Descrição Cor');
  LComandos.Add('Descrição Tamanho');
  LComandos.Add('Tamanho(Reduzido)');
  LComandos.Add('Codigo de Barra');
  LComandos.Add('Codigo de Barra com dígito');
  LComandos.Add('Codigo de Barra Ean8');
  LComandos.Add('Codigo de Barra Ean128A');
  LComandos.Add('Codigo de Barra Ean13');
  LComandos.Add('Codigo de Barra UPCA');
  LComandos.Add('Codigo de Barra Ean13 com dígito');
// 27.08.11
  LComandos.Add('Codigo de Barra Ean13 sem codigo');
// 05.11.15
  LComandos.Add('Data impressão');
// 08.02.17 - gisele armas
  LComandos.Add('Preço de Venda');

  FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  LComandos.Free;
end;


////////////////////////////////////////////////////////////////
function RetornoEtqProduto(Comando,Especie:String):String;
////////////////////////////////////////////////////////////////
var ext,descricaocor,descricaotamanho,reduzidotamanho,codigobarra:string;
    tam:integer;
begin

  descricaocor:='';
  descricaotamanho:='';
  reduzidotamanho:='';
  codigobarra:=QMestre.fieldbyname('esto_codbarra').asstring;
  if ansipos('ESTGRADES',uppercase(QMestre.SQL.Text))>0 then begin
    descricaocor:=FCores.GetDescricao(QMestre.fieldbyname('esgr_core_codigo').asinteger);
    descricaotamanho:=FTamanhos.GetDescricao(QMestre.fieldbyname('esgr_tama_codigo').asinteger);
    reduzidotamanho:=FTamanhos.GetReduzido(QMestre.fieldbyname('esgr_tama_codigo').asinteger);
    codigobarra:=QMestre.fieldbyname('esgr_codbarra').asstring;
  end;
  if Comando='Codigo' then Result:=QMestre.fieldbyname('esto_codigo').asstring
  else if Comando='Descrição' then Result:=QMestre.fieldbyname('esto_descricao').asstring
// 10.07.13 - Fama - Etiquetas Janina
  else if Comando='Descrição (posição 1 a 22)' then Result:=copy(QMestre.fieldbyname('esto_descricao').asstring,1,22)
  else if Comando='Descrição (posição 23 a 50)' then Result:=copy(QMestre.fieldbyname('esto_descricao').asstring,23,17)
//
  else if Comando='Unidade' then Result:=QMestre.fieldbyname('esto_unidade').asstring
  else if Comando='Referência' then Result:=QMestre.fieldbyname('esto_referencia').asstring
  else if Comando='Codigo de Barra' then Result:=codigobarra
  else if Comando='Codigo de Barra com dígito' then Result:='DIGCODBARRAS('+codigobarra+')'
  else if Comando='Codigo de Barra Ean8' then Result:='CODBARRAS('+codigobarra+';'+'EAN8'+')'
  else if Comando=('Codigo de Barra Ean128A')then Result:='CODBARRAS('+codigobarra+';'+'EAN128A'+')'

  else if Comando='Codigo de Barra Ean13' then Result:='CODBARRAS('+codigobarra+';'+'EAN13'+')'
// 15.10.12 - Vivan
  else if Comando='Codigo de Barra UPCA' then Result:='CODBARRAS('+codigobarra+';'+'UPCA'+')'

  else if Comando='Codigo de Barra Ean13 com dígito' then Result:='CODBARRAS('+codigobarra+';'+'EAN13'+';'+'S'+')'
  else if Comando='Descrição Cor' then Result:=descricaocor
  else if Comando='Descrição Tamanho' then Result:=descricaotamanho
  else if Comando='Tamanho(Reduzido)' then Result:=reduzidotamanho
  else if Comando='Codigo de Barra Ean13 sem codigo' then Result:='CODBARRAS('+codigobarra+';'+'EAN13'+';'+'S'+';'+'S'+')'
// 05.11.15 - Vivan - cris
  else if Comando='Data impressão' then Result:=FGeral.formatadata(Sistema.hoje)
// 08.02.17
  else if Comando='Preço de Venda' then begin
// 24.08.20 - Devereda
    if FDadosGrade.Visible then

       Result:=FConfDcto.TransformDcto( QMestre.fieldbyname('esgr_vendavis').ascurrency,
                  FConfDcto.FormatoValores)

    else

       Result:=FConfDcto.TransformDcto(FEstoque.GetPreco(QMestre.fieldbyname('esto_codigo').asstring,Global.CodigoUnidade,Global.UFUnidade),
                  FConfDcto.FormatoValores);

  end else if copy(Uppercase(comando),1,5)='LINHA' then begin
    if pos('[',comando)+1=pos(']',comando)-1 then
      tam:=1
    else
      tam:=strtoint( copy(comando,pos('[',comando)+1,pos(']',comando)-pos('[',comando)-1 ) );
    result:=replicate('-',tam);
  end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
function TFImpressao.ImprimeEtqProduto(comando:string ;  qtdetiquetas: integer;  colunas: integer; tipo:string='X' ; PedeImp:boolean=true ): Boolean;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var n,nn,v,i,quantos,linha,quantas,ultimaposicao:Integer;
    FormaImpressao,Codigo,w,operacao,l0,l1,l2,l3,l4,l5:String;
    QTemp:TSqlquery;
    Conf:boolean;
begin
  Result:=True;
// 04.10.2012
  FCadImp.Open;
{
  if qtdetiquetas>1 then begin
    Sistema.Conexao.ExecuteDirect('drop table tempetqprod');
    Sistema.Conexao.ExecuteDirect('create table tempetqprod as '+comando);
    for i:=1 to qtdetiquetas-1 do begin
      Sistema.Conexao.ExecuteDirect('insert into tempetqprod '+comando);
    end;
    comando:='select * from tempetqprod';
  end;
}

  QMestre:=sqltoquery(comando);
  try
    QMestre.Name:='QMestre';
    if not QMestre.isEmpty then begin
       if tipo='L' then
         Codigo:=FGeral.GetConfig1AsString('Impretqprolaser')
       else
         Codigo:=FGeral.GetConfig1AsString('impretqpro');
       if trim(codigo)='' then begin
         Avisoerro('Falta configurar o codigo do impresso da etiqueta do produto');
         Freeandnil(QMestre);
         exit;
       end;
// 04.10.12 - Vivan
       if PedeImp then begin
         FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
         Conf:=(FormaImpressao='2') or ((FormaImpressao='1') and (Confirma('Confirma a impressão')));
       end else
         Conf:=true;
       if Conf then begin
//          if colunas<>1 then
//            Result:=true
//          else
           if PedeImp then
             Result:=FConfDcto.GetConfiguracao(Codigo);

          if Result then begin

             Sistema.BeginProcess('imprimindo etiqueta');
             nn:=0;
             while not QMestre.Eof do begin
               Inc(nn);
               QMestre.Next;
             end;
//////             QMestre.First;
             n:=0;
             quantas := 0;
             QMestre.First;

             while not QMestre.Eof do begin

                 Inc(n);
//                 if colunas=1 then begin
                 if colunas>0 then begin

//                      Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,n=1,n=nn);
//                      if not Result then Break;

//                      Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,true,false);
//                      FConfDcto.GetConfiguracao(Codigo,20);
//                      Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,false,true,20);

                   if tipo='ACBR' then begin
//                     Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,i=1,i=qtdetiquetas,Visualiza,(i-1)*FConfDcto.NumLgPg,'ACBR',qtdetiquetas);
//   ASSIM começou a dar erro com mais de uma etiqueta na qtde
//                     Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,n=1,n=qtdetiquetas,Visualiza,(n-1)*FConfDcto.NumLgPg,'ACBR',qtdetiquetas);
// 25.05.11 -
//   ASSIM não da erro mas so imprimme uma etiqueta por vez
//                     for i:=1 to qtdetiquetas do begin
//                        Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,i=1,i=qtdetiquetas,Visualiza,(i-1)*FConfDcto.NumLgPg,'ACBR',qtdetiquetas);
//                     end;
// recolocado assim depois de tirar o newpag quando manda posicao > 0 no fconfdct.prin
// 1.80v4 testado assim
//                     Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,n=1,n=qtdetiquetas,Visualiza,(n-1)*FConfDcto.NumLgPg,'ACBR',qtdetiquetas);
// 26.05.11 - TENTAR inicializando todo hora
//                     Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,1=1,n=qtdetiquetas,Visualiza,(n-1)*FConfDcto.NumLgPg,'ACBR',qtdetiquetas);
// 1.840v5 testado assim
//                     Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,1=1,n=qtdetiquetas,Visualiza,(n-1)*FConfDcto.NumLgPg,'ACBR',qtdetiquetas);
// 1.840v6 testado assim...e FUNCIONOOOOOOOOOU..tem q inicializar e finalizar toda vez a impressora 'fia da puta'
                     Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,true,true,Visualiza,(n-1)*FConfDcto.NumLgPg,'ACBR',qtdetiquetas);

                   end else begin

                     if FDadosGrade.Visible then begin  // 28.06.13 - só pra grade
                       qtdetiquetas:=0;
                       with FDadosGrade.Grid do begin
                          for linha:=1 to RowCount do begin
                            if ( strtointdef( Cells[GetColumn('esgr_tama_codigo'),linha],0 )=QMestre.fieldbyname('esgr_tama_codigo').asinteger ) and
                               ( strtointdef( Cells[GetColumn('esgr_core_codigo'),linha],0 )=QMestre.fieldbyname('esgr_core_codigo').asinteger ) and
                               ( strtointdef( Cells[GetColumn('(qtdeimpressao)'),linha],0 ) >0 ) then
                            qtdetiquetas:=strtointdef( Cells[GetColumn('(qtdeimpressao)'),linha],0 );
                          end;
                       end;
                     end;
                     quantos:=trunc(qtdetiquetas/colunas);
                     if quantos<1 then quantos:=1;
                     for i:=1 to quantos  do begin
//                        Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,i=1,i=quantos,Visualiza,(i-1)*FConfDcto.NumLgPg);
//                        Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,i=1,i=quantos+1,Visualiza,(i-1)*FConfDcto.NumLgPg);
                        if n=1 then begin
                          Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,i=1,i=quantos+1,Visualiza,(i-1)*FConfDcto.NumLgPg,tipo,2);
                          FConfDcto.GetConfiguracao(Codigo,i*FConfDcto.NumLgPg);
//                        end else if (FConfDcto.NumLgFinal>0) and ( (n mod 2)=0 ) and ( i=1 ) then begin
//                          Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,i=0,i=quantos+1,Visualiza,(i)*FConfDcto.NumLgPg+(FConfDcto.NumLgFinal));
//                          FConfDcto.GetConfiguracao(Codigo,i*FConfDcto.NumLgPg*FConfDcto.NumLgFinal+(FConfDcto.NumLgFinal));
                          ultimaposicao:=(i-1)*FConfDcto.NumLgPg
                        end else begin
                          ultimaposicao:=ultimaposicao+(FConfDcto.NumLgPg );
                          Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,i=0,i=quantos+1,Visualiza,ultimaposicao,tipo,2);
                          FConfDcto.GetConfiguracao(Codigo,ultimaposicao);
                        end;
//                        else
//                          Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,i=0,i=quantos+1,Visualiza,(i)*FConfDcto.NumLgPg*n);
//                        Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,true,true,Visualiza,(i-1)*FConfDcto.NumLgPg);
// 04.09.12
//                          Result:=FConfDcto.Print(Codigo,RetornoEtqProduto,true,true,Visualiza,(n-1)*FConfDcto.NumLgPg);
// 04.10.12
                     end;

                     quantas:=quantas+quantos;

                   end;
                   if not Result then Break;
                 end;
               QMestre.Next;
             end;
// 09.12.2012 -
             if Tipo<>'ACBR' then
               Printer.EndDoc;  // finaliza aqui a impressao...
             Sistema.endProcess('');
          end;
       end;
    end else
      Avisoerro('Nada encontrado para impressão');
  except
    Avisoerro('Não foi possível imprimir');
  end;
  Sistema.EndProcess('');
  Freeandnil(QMestre);
end;


//////////////////////////////////////////////////////////////////////////////////////////
function TFImpressao.ImprimeRemessa(Nota: Integer; DataMvto: TDatetime;  Unidade, tipomov: string): Boolean;
//////////////////////////////////////////////////////////////////////////////////////////
var n,nn,p:Integer;
    FormaImpressao,Codigo,tiposimp:String;
    valortotal,Tvalortotal,percuni1,percuni2,percuni3,
    valortotal1,valortotal2,valortotal3:currency;
    achou:boolean;

//////////////////////////////////////////////
    procedure Envia_Impressora;
    ///////////////////////////
    var count,countgeral,i,p:integer;
    begin
      NroPagina:=1;
      NroPaginas:=1;

      if FConfdcto.NumLgPg>0 then begin
        if Listadetalhe.count mod FConfdcto.NumLgPg = 0 then
          count:= Listadetalhe.count div FConfdcto.NumLgPg
        else
          count:= Listadetalhe.count div FConfdcto.NumLgPg + 1;
        if count=0 then
          count:=1;
      end else
        count:=1;

      NroPaginas:=count;
      for i:=1 to count do begin
        NroPagina:=i;
        if FConfDcto.TpImpressora='J' then
          FConfDcto.Print(Codigo, RetornoNotaSaida, i = 1, i = count,Visualiza,(i-1)*FConfdcto.NumLgPg)
        else
          FConfDcto.Print(Codigo, RetornoNotaSaida, i = 1, i = count,Visualiza);

        if count>1 then
          FConfDcto.GetConfiguracao(Codigo,(i*FConfdcto.NumLgPg));

      end;
    end;


///////////////////
begin
///////////////////////////////////////////////////////////
  Result:=True;
  if not Arq.TUnidades.active then Arq.TUnidades.Open;
  if not Arq.TNatFisc.active then Arq.TNatFisc.open;
  if not Arq.TTransp.active then Arq.TTransp.open;
  if tipomov=Global.CodRemessaProntaEntrega then
    Codigo:=FGeral.GetConfig1AsString('Impremessape')
  else
    Codigo:=FGeral.GetConfig1AsString('Impremessaco');
  if trim(codigo)='' then begin
     Avisoerro('Falta configurar o codigo deste impresso na configuração geral');
     exit
  end;
  try
// 11.08.05
///    Result:=FConfDcto.GetConfiguracao(Codigo);

    tiposimp:=Global.CodRemessaConsig+';'+Global.CodRemessaProntaEntrega;
    if trim(tipomov)<>'' then
      tiposimp:=tipomov;
    QMestre:=sqltoquery('select * from movesto '+
                     ' where moes_numerodoc='+inttostr(Nota)+
                     ' and moes_datamvto='+Datetosql(Datamvto)+
                     ' and moes_unid_codigo='''+unidade+''''+
                     ' and '+FGeral.GetIN('moes_tipomov',tiposimp,'C')+
//                     ' and moes_status=''N'''+
// 01.04.11 - para poder reimprimir já fechadas..
                     ' and '+FGeral.GetIN('moes_status','N;D;E','C')+
                     ' order by moes_numerodoc' );
    QMestre.Name:='QMestre';
    if not QMestre.Eof then begin
      Arq.TUnidades.locate('unid_codigo',unidade,[]);
      QPendencia:=sqltoquery('select * from pendencias where pend_transacao='+stringtosql(QMestre.fieldbyname('moes_Transacao').AsString)+
                            ' and pend_status<>''C'''+
                            ' order by pend_datavcto');
      npar:=0;
      parc1:='';parc2:='';parc3:='';parc4:='';parc5:='';parc6:='';
      venc1:='';venc2:='';venc3:='';venc4:='';venc5:='';venc6:='';
      if not QPendencia.eof then begin
        npar:=1;
        while not QPendencia.eof do begin
          if npar=1 then begin
             venc1:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc1:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=2 then begin
             venc2:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc2:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=3 then begin
             venc3:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc3:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=4 then begin
             venc4:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc4:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=5 then begin
             venc5:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc5:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end else if npar=6 then begin
             venc6:=FGeral.Formatadata(QPendencia.fieldbyname('pend_datavcto').asdatetime);
             parc6:=FGeral.Formatavalor(QPendencia.fieldbyname('pend_valor').ascurrency,FConfDcto.FormatoValores)
          end;
          inc(npar);
          QPendencia.Next;
        end;
      end;
      QClientes:=sqltoquery('select * from clientes where clie_codigo='+QMestre.fieldbyname('moes_tipo_codigo').asstring);
      QClientes.Name:='QClientes';
      Arq.TTransp.Locate('tran_codigo',QMestre.fieldbyname('moes_tran_codigo').asstring,[]);
      FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
       if (FormaImpressao='2') or ((FormaImpressao='1') and (Confirma('Confirma a impressão ?'))) then begin
          Result:=FConfDcto.GetConfiguracao(Codigo);
          if Result then begin
             Sistema.BeginProcess('imprimindo remessa');
             nn:=0;
             QMestre.First;
             while not QMestre.Eof do begin
               Inc(nn);
               QMestre.Next;
             end;
             QMestre.First;
             n:=0;
// 13.04.11
             percuni1:=0;percuni2:=0;percuni3:=0;
             if FGeral.getconfig1asstring('Fpgto2x')<>'' then
               percuni1:=FCondpagto.GetPerDesconto( FGeral.getconfig1asstring('Fpgto2x') );
             if FGeral.getconfig1asstring('Fpgto1mais2')<>'' then
               percuni2:=FCondpagto.GetPerDesconto( FGeral.getconfig1asstring('Fpgto1mais2') );
             if FGeral.getconfig1asstring('Fpgto1mais1')<>'' then
               percuni3:=FCondpagto.GetPerDesconto( FGeral.getconfig1asstring('Fpgto1mais1') );

             while not QMestre.Eof do begin
               Inc(n);
// detalhes q se repetem
               QDetalhe:=sqltoquery('select * from movestoque '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo)'+
                     ' where move_transacao='''+QMestre.fieldbyname('moes_transacao').asstring+''''+
//                     ' and '+FGeral.GetIN('move_status','N','C')+
// 01.04.11 - para poder reimprimir já fechadas..
                     ' and '+FGeral.GetIN('move_status','N;D;E','C')+
                     ' and '+FGeral.GetIN('move_tipomov',tiposimp,'C')+
                     ' and move_numerodoc='+QMestre.fieldbyname('moes_numerodoc').asstring+
                     ' order by move_aliicms,move_esto_codigo' );
//                     ' and detalhe.mfod_tipo<>''S'''+  // fgts nao...
               ListaDetalhe := TList.Create;valortotal:=0;Tvalortotal:=0;TQtdetotal:=0;
               Tvalortotal1:=0;Tvalortotal2:=0;Tvalortotal3:=0;
               while not QDetalhe.Eof do begin
                 achou:=false;
// 01.04.11 - Doce Pimenta - Silvano condensar tamanhos e cores no mesmo codigo
                 for p:=0 to ListaDetalhe.count-1 do begin
                   PDetalhe:=ListaDetalhe[p];
                   if (PDetalhe.Codigoproduto=Qdetalhe.fieldbyname('Move_esto_codigo').AsString) then begin
                      achou:=true;
                      break;
                   end;
                 end;
                 if not achou then begin
                   New(PDetalhe);
                   if Tvalortotal=0 then
                     PDetalhe.TQuantidade:=0;
                   PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('Move_esto_codigo').AsString;
  // 08.09.10
                   if Global.Topicos[1208] then
                     PDetalhe.Descricaoproduto:=Qdetalhe.fieldbyname('esto_descricao').Asstring
                   else
                     PDetalhe.Descricaoproduto:=copy(Qdetalhe.fieldbyname('esto_descricao').Asstring,1,50);
  ////////////////////////////////
                   PDetalhe.Cst:=Qdetalhe.fieldbyname('Move_cst').AsString;
                   PDetalhe.Unidade:=Qdetalhe.fieldbyname('Esto_unidade').Asstring;
                   PDetalhe.Quantidade:=Qdetalhe.fieldbyname('move_qtde').Ascurrency;
                   PDetalhe.TQuantidade:=PDetalhe.TQuantidade+Qdetalhe.fieldbyname('move_qtde').AsCurrency;
                   valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('move_venda').AsCurrency*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
  // 01.02.06 - impressao do romaneio embutindo a subst. trib. no valor unitario somente na impressao
  // 09.02.06 - deixado 'no jeito'
  //                 end else begin
  // 27.03.06 - colocado em atividade..
//                   PDetalhe.Unitario:=FEstoque.GetPreco(Qdetalhe.fieldbyname('Move_esto_codigo').AsString,unidade,
//                                        Qclientes.fieldbyname('clie_uf').asstring,Qdetalhe.fieldbyname('move_aliicms').AsCurrency,
//                                        Qclientes.fieldbyname('clie_tipo').asstring,
//                                        QDetalhe.fieldbyname('move_venda').AsCurrency);
// 14.04.11 - deixado preço de venda da hora da gravacao da remessa
                   PDetalhe.Unitario:=QDetalhe.fieldbyname('move_venda').AsCurrency;
                   PDetalhe.unitario1:=PDetalhe.unitario - PDetalhe.unitario*(percuni1/100);
                   PDetalhe.unitario2:=PDetalhe.unitario - PDetalhe.unitario*(percuni2/100);
                   PDetalhe.unitario3:=PDetalhe.unitario - PDetalhe.unitario*(percuni3/100);
                   valortotal:=FGeral.Arredonda(PDetalhe.Unitario*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);

                   valortotal1:=FGeral.Arredonda(PDetalhe.Unitario1*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
                   valortotal2:=FGeral.Arredonda(PDetalhe.Unitario2*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
                   valortotal3:=FGeral.Arredonda(PDetalhe.Unitario3*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
  //                 end;

                   PDetalhe.Total:=valortotal;
                   PDetalhe.icms:=Qdetalhe.fieldbyname('move_aliicms').AsCurrency;
                   ListaDetalhe.Add(Pdetalhe);
                 end else begin
                   PDetalhe.quantidade:=PDetalhe.quantidade+Qdetalhe.fieldbyname('move_qtde').AsCurrency;
                   valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('move_venda').AsCurrency*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
                   PDetalhe.Total:=PDetalhe.Total+valortotal;
// 14.04.11
                   valortotal1:=FGeral.Arredonda(PDetalhe.Unitario1*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
                   valortotal2:=FGeral.Arredonda(PDetalhe.Unitario2*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
                   valortotal3:=FGeral.Arredonda(PDetalhe.Unitario3*Qdetalhe.fieldbyname('move_qtde').AsCurrency,2);
                 end;
                 Tvalortotal:=Tvalortotal+valortotal;
// 14.04.11 - Jada
                 Tvalortotal1:=Tvalortotal1+valortotal1;
                 Tvalortotal2:=Tvalortotal2+valortotal2;
                 Tvalortotal3:=Tvalortotal3+valortotal3;
                 TQtdetotal:=TQtdetotal+Qdetalhe.fieldbyname('move_qtde').Ascurrency;
                 QDetalhe.Next;
               end;


               if not QDetalhe.IsEmpty then begin
                   Envia_Impressora;
               end;
               QDetalhe.Close;Listadetalhe.Free;
               QMestre.Next;
             end;
             Sistema.EndProcess('');
          end;
       end;
       Freeandnil(Qclientes);
       Freeandnil(QPendencia);
    end else
      Avisoerro('Remessa/Devolução não encontrada');
    QMestre.Close;Freeandnil(QMestre);
    if QDetalhe<>nil then begin
       QDetalhe.Close;
       Freeandnil(QDetalhe);
    end;
  except
    Avisoerro('Problemas na impressão da remessa');
  end;
  Sistema.EndProcess('');


end;

// 12.08.10
procedure TFImpressao.ConfReciboCaixa(Codigo, Descricao: String);
///////////////////////////////////////////////////////////////////
var Tit:String;
    LComandos:TStringList;
begin
  Tit:='Configuração Comprovante de Lançamento de Caixa / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
  LComandos.Add('Nome da Unidade');
  LComandos.Add('CNPJ da unidade');
  LComandos.Add('Cidade da unidade');
// 05.03.08
  LComandos.Add('Inscrição Estadual da unidade');
  LComandos.Add('Razão Social da unidade');
  LComandos.Add('Endereço da unidade');
  LComandos.Add('Bairro da unidade');
  LComandos.Add('CEP da unidade');
  LComandos.Add('Fone da unidade');
  LComandos.Add('Email da unidade');
  LComandos.Add('Estado da unidade');
//
//  LComandos.Add('Numero comprovante');
  LComandos.Add('Numero documento');
//  LComandos.Add('Razão Social');
  LComandos.Add('Nome');
  LComandos.Add('CNPJ/CPF');
  LComandos.Add('Data');
  LComandos.Add('Valor');
  LComandos.Add('Valor por extenso (linha1)');
  LComandos.Add('Valor por extenso (linha2)');
  LComandos.Add('Histórico');
  LComandos.Add('Codigo usuário');
  LComandos.Add('Nome usuário');
  LComandos.Add('Numero cheque');
  LComandos.Add('Conta Entrada');
  LComandos.Add('Conta Saida');
  LComandos.Add('Conta Receita/Despesa');
  LComandos.Add('Operação');
  FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  LComandos.Free;
end;

function RetornoReciboCaixa(Comando,Especie:String):String;
////////////////////////////////////////////////////////
var ext:string;
    tam:integer;
begin
  if Comando='Nome da Unidade' then Result:=QMestre.fieldbyname('unid_nome').asstring
// 05.03.08
  else if Comando='Inscrição Estadual da unidade' then Result:=QMestre.fieldbyname('unid_inscricaoestadual').asstring
  else if Comando='Razão Social da unidade' then Result:=QMestre.fieldbyname('unid_razaosocial').asstring
  else if Comando='Endereço da unidade' then Result:=QMestre.fieldbyname('unid_endereco').asstring
  else if Comando='Bairro da unidade' then Result:=QMestre.fieldbyname('unid_bairro').asstring
  else if Comando='CEP da unidade' then Result:=FGEral.formatacep(QMestre.fieldbyname('unid_cep').asstring)
  else if Comando='Fone da unidade' then Result:=FGeral.Formatatelefone(QMestre.fieldbyname('unid_fone').asstring)
  else if Comando='Email da unidade' then Result:=QMestre.fieldbyname('unid_email').asstring
  else if Comando='Estado da unidade' then Result:=QMestre.fieldbyname('unid_uf').asstring
//

//  else if Comando='Numero comprovante' then Result:=inttostr( FGeral.GetContador('RECIBOCXA',false) )
  else if Comando='Numero documento' then Result:=QMestre.fieldbyname('movf_numerodcto').asstring
  else if Comando='CNPJ da unidade' then Result:=FGeral.Formatacnpj(QMestre.fieldbyname('unid_cnpj').asstring)
  else if Comando='Cidade da unidade' then Result:=QMestre.fieldbyname('unid_municipio').asstring
//  else if Comando='Razão Social' then Result:=FGEral.GetRazSocialTipoCad(QMestre.fieldbyname('movf_tipo_codigo').asinteger,QMestre.fieldbyname('movf_tipocad').asstring)
//  if Comando='Nome' then Result:=FGEral.GetNomeTipoCad(QMestre.fieldbyname('pend_tipo_codigo').asinteger,QMestre.fieldbyname('pend_tipocad').asstring);
  else if Comando='Nome' then Result:=QMestre.fieldbyname('clie_nome').asstring
 else if Comando='CNPJ/CPF' then Result:=FGEral.Formatacnpjcpf( QMestre.fieldbyname('clie_cnpjcpf').asstring)
  else if Comando='Data' then Result:=FGeral.FormataData(QMestre.fieldbyname('movf_datamvto').asdatetime);
  ext:=UpperCaseBras( Extenso(valorrecibo) );
  if (Comando='Valor')  then Result:=FGeral.FormataValor(valorrecibo,FConfDcto.FormatoValores)
  else if Comando='Valor por extenso (linha1)' then Result:=copy(ext,1,80)
  else if Comando='Valor por extenso (linha2)' then Result:=copy(ext,81,80)
  else if Comando='Codigo usuário' then result:=QMestre.fieldbyname('movf_usua_codigo').asstring
  else if Comando='Nome usuário' then result:=FUsuarios.GetNome(QMestre.fieldbyname('movf_usua_codigo').asinteger)
// 04.03.08
  else if Comando='Histórico' then result:=QMestre.fieldbyname('movf_complemento').asstring
  else if Comando='Numero cheque' then result:=QMestre.fieldbyname('movf_numerocheque').asstring
  else if Comando='Conta' then result:=QMestre.fieldbyname('movf_plan_conta').asstring+' - '+FPlano.GetDescricao(QMestre.fieldbyname('movf_plan_conta').asinteger)
  else if Comando='Conta Receita/Despesa' then result:=QMestre.fieldbyname('movf_plan_contard').asstring+' - '+FPlano.GetDescricao(QMestre.fieldbyname('movf_plan_contard').asinteger)
  else if Comando='Operação' then result:=QMestre.fieldbyname('movf_operacao').asstring ;
  if copy(Uppercase(comando),1,5)='LINHA' then begin
    if pos('[',comando)+1=pos(']',comando)-1 then
      tam:=1
    else
      tam:=strtoint( copy(comando,pos('[',comando)+1,pos(']',comando)-pos('[',comando)-1 ) );
    result:=replicate('-',tam);
  end;
end;


function TFImpressao.ImprimeReciboCaixa(Operacao: string ; xconf:string='S'): Boolean;
//////////////////////////////////////////////////////////////////////////
var n,nn,x:Integer;
    FormaImpressao,Codigo,w,sqltipo:String;
    bconf : boolean;

begin
  Result:=True;
  FCadImp.Open;
  valorrecibo:=0;
  try

    QMestre:=sqltoquery('select movfin.*,clie_nome,clie_cnpjcpf,unidades.* from movfin'+
             ' inner join plano on ( plan_conta = movf_plan_contard )'+
             ' inner join clientes on ( clie_codigo = plan_contaabatimentos )'+
             ' left join unidades on (unid_codigo=movf_unid_codigo)'+
             ' where movf_operacao='+stringtosql(operacao)+' and movf_status<>''C''' );
//             ' where movf_transacao='+stringtosql(operacao)+' and movf_status<>''C''' );
    QMestre.Name:='QMestre';

    if not QMestre.isEmpty then begin

       if QMestre.fieldbyname('movf_datacont').asdatetime>1 then
         sqltipo:=' and movf_datacont > '+Datetosql(Global.DataMenorBanco)
       else
         sqltipo:='';
       valorrecibo:=QMestre.fieldbyname('movf_valorger').ascurrency;

       Codigo:=FGeral.GetConfig1AsString('Impcomlan');
       if trim(codigo)='' then begin
         Avisoerro('Falta configurar o codigo do impresso de comprovante de lançamento no caixa');
         Freeandnil(QMestre);
         exit;
       end;
       FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
       if xconf = 'S'  then

          bconf:=Confirma('Confirma a impressão do comprovante')

       else

          bconf:=true;

       if (FormaImpressao='2') or ( (FormaImpressao='1') and ( bconf )) then begin

          Result:=FConfDcto.GetConfiguracao(Codigo);
          if Result then begin
             Sistema.BeginProcess('imprimindo comprovante');
             nn:=0;
             while not QMestre.Eof do begin
               Inc(nn);
               QMestre.Next;
             end;
             QMestre.First;
             n:=0;
               while not QMestre.Eof do begin
                 Inc(n);
                 Result:=FConfDcto.Print(Codigo,RetornoReciboCaixa,n=1,n=nn);
                 if not Result then Break;
                 QMestre.Next;
               end;
             Sistema.endProcess('');
          end;
       end;
    end else
      Avisoerro('Transação '+operacao+' não encontrada');

  except on E:Exception do

    Avisoerro('Não foi possível imprimir.  '+E.Message);

  end;

  Sistema.EndProcess('');
  Freeandnil(QMestre);
end;

//////////////////////////////////////////////////////////////////////
procedure TFImpressao.ConfEtqbalanca(Codigo, Descricao: String);
//////////////////////////////////////////////////////////////////////
var Tit:String;
    LComandos:TStringList;
begin
  Tit:='Configuração Etiqueta Balança / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
  LComandos.Add('Codigo');
  LComandos.Add('Descrição');
  LComandos.Add('Unidade');
  LComandos.Add('Referência');
  LComandos.Add('Quantidade(Peso)');
  LComandos.Add('Validade');
  LComandos.Add('Descrição Cor');
  LComandos.Add('Descrição Tamanho');
  LComandos.Add('Tamanho(Reduzido)');
  LComandos.Add('Codigo de Barra');
  LComandos.Add('Codigo de Barra com dígito');
  LComandos.Add('Codigo de Barra Ean8');
  LComandos.Add('Codigo de Barra Ean13');
  LComandos.Add('Codigo de Barra Ean13 com dígito');
//////////////dados do cliente
  LComandos.Add('Codigo destinatário');
  LComandos.Add('Nome');
  LComandos.Add('Razão Social');
  LComandos.Add('CNPJ/CPF');
  LComandos.Add('Data emissão');
  LComandos.Add('Endereço');
  LComandos.Add('Bairro');
  LComandos.Add('CEP');
//  LComandos.Add('Data Saída');
  LComandos.Add('Cidade');
  LComandos.Add('Telefone');
  LComandos.Add('Estado');
  FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  LComandos.Free;
end;


/////////////////////////////////////////////////////////////////
function RetornoEtqBalanca(Comando,Especie:String):String;
/////////////////////////////////////////////////////////////////
var ext,descricaocor,descricaotamanho,reduzidotamanho,codigobarra:string;
    tam:integer;
begin
  if Comando='Codigo destinatário' then Result:=QMestre.fieldbyname('clie_codigo').asstring
  else if Comando='Nome' then Result:=QMestre.fieldbyname('clie_nome').asstring
  else if Comando='Razão Social' then Result:=QMestre.fieldbyname('clie_razaosocial').asstring
  else if Comando='Endereço' then Result:=QMestre.fieldbyname('clie_endres').asstring
  else if Comando='Complemento' then Result:=QMestre.fieldbyname('clie_endrescompl').asstring
  else if Comando='Bairro' then Result:=QMestre.fieldbyname('clie_bairrores').asstring
  else if Comando='CEP' then Result:=fGeral.FormataCep(QMestre.fieldbyname('clie_cepres').asstring)
  else if Comando='Cidade' then Result:=Fcidades.GetNome(QMestre.fieldbyname('clie_cida_codigo_res').asinteger)
  else if Comando='Estado' then Result:=Fcidades.GetUF(QMestre.fieldbyname('clie_cida_codigo_res').asinteger)
  else if Comando='Telefone' then result:=FGeral.Formatatelefone(QMestre.fieldbyname('clie_foneres').asstring)
  else if Comando='Inscrição Estadual' then begin
    if QMestre.fieldbyname('clie_tipo').asstring='F' then
      Result:='Isento'
    else
      result:=QMestre.fieldbyname('clie_rgie').asstring;
  end;
  descricaocor:='';
  descricaotamanho:='';
  reduzidotamanho:='';
  codigobarra:=QMestre.fieldbyname('esto_codbarra').asstring;
  if ansipos('ESTGRADES',uppercase(QMestre.SQL.Text))>0 then begin
    descricaocor:=FCores.GetDescricao(QMestre.fieldbyname('esgr_core_codigo').asinteger);
    descricaotamanho:=FTamanhos.GetDescricao(QMestre.fieldbyname('esgr_tama_codigo').asinteger);
    reduzidotamanho:=FTamanhos.GetReduzido(QMestre.fieldbyname('esgr_tama_codigo').asinteger);
    codigobarra:=QMestre.fieldbyname('esgr_codbarra').asstring;
  end;
  if Comando='Codigo' then Result:=QMestre.fieldbyname('esto_codigo').asstring
  else if Comando='Descrição' then Result:=QMestre.fieldbyname('esto_descricao').asstring
  else if Comando='Unidade' then Result:=QMestre.fieldbyname('esto_unidade').asstring
  else if Comando='Referência' then Result:=QMestre.fieldbyname('esto_referencia').asstring
  else if Comando='Codigo de Barra' then Result:=codigobarra
  else if Comando='Codigo de Barra com dígito' then Result:='DIGCODBARRAS('+codigobarra+')'
  else if Comando='Codigo de Barra Ean8' then Result:='CODBARRAS('+codigobarra+';'+'EAN8'+')'
  else if Comando='Codigo de Barra Ean13' then Result:='CODBARRAS('+codigobarra+';'+'EAN13'+')'
  else if Comando='Codigo de Barra Ean13 com dígito' then Result:='CODBARRAS('+codigobarra+';'+'EAN13'+';'+'S'+')'
  else if Comando='Descrição Cor' then Result:=descricaocor
  else if Comando='Descrição Tamanho' then Result:=descricaotamanho
  else if Comando='Tamanho(Reduzido)' then Result:=reduzidotamanho
  else if Comando='Quantidade(Peso)' then Result:=Transform(QMestre.fieldbyname('movd_pesocarcaca').ascurrency,f_cr3)
  else if Comando='Data emissão' then Result:=FormatDateTime('dd/mm/yy',Sistema.hoje)
  else if Comando='Validade' then Result:=Transform(QMestre.fieldbyname('esto_validade').asinteger,FConfDcto.FormatoQtdesInt )

  else if copy(Uppercase(comando),1,5)='LINHA' then begin
    if pos('[',comando)+1=pos(']',comando)-1 then
      tam:=1
    else
      tam:=strtoint( copy(comando,pos('[',comando)+1,pos(']',comando)-pos('[',comando)-1 ) );
    result:=replicate('-',tam);
  end;

end;


/////////////////////////////////////////////////////////////////////////////////////////////
function TFImpressao.ImprimeEtqBalanca(comando: string; colunas: integer;  tipo,confirmaimpressao: string): Boolean;
/////////////////////////////////////////////////////////////////////////////////////////////
var n,nn,v,i,qtdetiquetas:Integer;
    conf:boolean;
    FormaImpressao,Codigo,w,operacao:String;
begin
  Result:=True;
  FCadImp.Open;
  QMestre:=sqltoquery(comando);
  try
    QMestre.Name:='QMestre';
    if not QMestre.isEmpty then begin
       Codigo:=FGeral.GetConfig1AsString('impretqbal');
       if trim(codigo)='' then begin
         Avisoerro('Falta configurar o codigo do impresso da etiqueta para balança de venda');
         Freeandnil(QMestre);
         exit;
       end;
       if QMestre.fieldbyname('esto_qetiqbalanca').asinteger > 1 then
         qtdetiquetas:=QMestre.fieldbyname('esto_qetiqbalanca').asinteger
       else
         qtdetiquetas:=1;
       FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
       if confirmaimpressao='S' then
         conf:=Confirma('Confirma a impressão')
       else
         conf:=true;
       if (FormaImpressao='2') or ((FormaImpressao='1') and ( conf )) then begin
          Result:=FConfDcto.GetConfiguracao(Codigo);
          if Result then begin
             Sistema.BeginProcess('imprimindo etiqueta');
             nn:=0;
             while not QMestre.Eof do begin
               Inc(nn);
               QMestre.Next;
             end;
             n:=0;
             QMestre.First;

             while not QMestre.Eof do begin

                 Inc(n);
                 if colunas=1 then begin
                   if tipo='ACBR' then begin
// 1.840v6 testado assim...e FUNCIONOOOOOOOOOU..tem q inicializar e finalizar toda vez a impressora 'fia da puta'
                     Result:=FConfDcto.Print(Codigo,RetornoEtqBalanca,true,true,Visualiza,(n-1)*FConfDcto.NumLgPg,'ACBR',qtdetiquetas);
                   end else begin
                     for i:=1 to qtdetiquetas do begin
                        Result:=FConfDcto.Print(Codigo,RetornoEtqBalanca,i=1,i=qtdetiquetas,Visualiza,(i-1)*FConfDcto.NumLgPg);
//                        FConfDcto.GetConfiguracao(Codigo,i*FConfDcto.NumLgPg);
                     end;
                   end;
                   if not Result then Break;
                 end;

               QMestre.Next;
             end;

             Sistema.endProcess('');
          end;
       end;
    end else
      Avisoerro('Nada encontrado para impressão');
  except
    Avisoerro('Não foi possível imprimir');
  end;
  Sistema.EndProcess('');
  Freeandnil(QMestre);
end;


// 19.08.13
////////////////////////////////////////////////////////////////////
procedure TFImpressao.ConfOrcamentoObra(Codigo, Descricao: String);
////////////////////////////////////////////////////////////////////
var Tit:String;
    LComandos:TStringList;
begin
  Tit:='Configuração Orcamento de Obra / '+Codigo+' - '+Descricao;
  LComandos:=TStringList.Create;
  LComandos.Add('Tipo de Obra');
  LComandos.Add('Inscrição Estadual do emitente');
  LComandos.Add('CNPJ do emitente');

  LComandos.Add('Endereço emitente');
  LComandos.Add('Bairro emitente');
  LComandos.Add('CEP emitente');
  LComandos.Add('Municipio emitente');
  LComandos.Add('UF emitente');
  LComandos.Add('Telefone emitente');

  LComandos.Add('Codigo destinatário');
  LComandos.Add('Razão Social destinatário');
  LComandos.Add('CNPJ/CPF destinatário');
  LComandos.Add('Endereço destinatário');
  LComandos.Add('Bairro destinatário');
  LComandos.Add('CEP destinatário');
  LComandos.Add('Municipio destinatário');
  LComandos.Add('Telefone destinatário');
  LComandos.Add('UF destinatário');
  LComandos.Add('Inscrição Estadual do destinatário');
///////////////////////////
  LComandos.Add('Data Orçamento');
  LComandos.Add('Numero');
////////////////////////////
  LComandos.Add('Codigo produto');
  LComandos.Add('Referência produto');  // 15.07.13
  LComandos.Add('Descrição produto');
  LComandos.Add('Descrição produto(30)');
  LComandos.Add('Descrição produto(50)');
  LComandos.Add('Unidade produto');
  LComandos.Add('Quantidade');
  LComandos.Add('Valor unitário');
  LComandos.Add('Valor total');
  LComandos.Add('Codigo cor');
  LComandos.Add('Descrição cor');
  LComandos.Add('Codigo tamanho');
  LComandos.Add('Descrição tamanho');
  LComandos.Add('Sequencial item');
  LComandos.Add('Peso Unitário');
  LComandos.Add('Peso Total do Produto');
/////////////////
  LComandos.Add('Peso Total dos produtos');
  LComandos.Add('Valor total dos produtos');
  LComandos.Add('Valor Desconto sobre Total do Orçamento');
  LComandos.Add('Valor Total do Orçamento');
  LComandos.Add('Peso Total');
  LComandos.Add('de transporte');
  LComandos.Add('a transportar');
  LComandos.Add('Codigo usuário');
  LComandos.Add('Nome usuário');
  LComandos.Add('Condição de Pagamento');
  LComandos.Add('Valor a Vista');
  LComandos.Add('Codigo representante');
  LComandos.Add('Nome representante');
  LComandos.Add('Observações');
  LComandos.Add('Observações   1 a 100');
  LComandos.Add('Observações 101 a 200');
  LComandos.Add('Vencimento 1');
  LComandos.Add('Parcela 1');
  LComandos.Add('Vencimento 2');
  LComandos.Add('Parcela 2');
  LComandos.Add('Vencimento 3');
  LComandos.Add('Parcela 3');
  LComandos.Add('Vencimento 4');
  LComandos.Add('Parcela 4');
  FConfDcto.Execute(Tit,LComandos,nil,nil,Codigo,True);
  LComandos.Free;
end;

// 19.08.13
////////////////////////////////////////////////////////////
function RetornoOrcamentoObra(Comando,Especie:String):String;
//////////////////////////////////////////////////////////////
var Dtemissao:TDateTime;
    Valornota,TotalProdutos,Valormaisdesconto,QtdeProdutos,Baseicms,Valoricms,BaseicmsSubs,
    ValoricmsSubs,QtdePeso:Currency;
    esp,r,QtdePecas:integer;
    obs,s,obs1,obs2,obs3,obs4,obs5,obs6,obs7,obs8,obs9:string;
    ListaEnter:TStringlist;

    function Tratavalor(valor:currency):string;
    ///////////////////////////////////////////
    begin
       result:='XX';
       if valor>0 then
         result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
       else begin
         if Nropaginas=1 then
           result:=FConfDcto.TransformDcto(valor,FConfDcto.FormatoValores)
         else
           result:='******,**';
       end;
    end;


///////////////////////////////////////////////////////////////
begin
///////////////////////////////////////////////////////////////
  Dtemissao:=QMestre.FieldByName('orca_datamvto').AsDateTime;
  result:='';
  obs:='';
  if (NroPagina=NroPaginas) and ( Nropaginas=1) then begin;
    ValorNota:=QMestre.FieldByName('Orca_Valor').AsFloat;
    TotalProdutos:=QMestre.FieldByName('Orca_Valor').AsFloat;
    QtdeProdutos:=Tqtdetotal;
    Qtdepecas:=Tpecastotal;
    QtdePeso:=TPesototal;
    if Comando='de transporte' then result:='';
    if Comando='a transportar' then result:='';
  end else if (NroPagina<NroPaginas) and ( Nropaginas>1) then begin
    ValorNota:=0;
    TotalProdutos:=0;
    QtdeProdutos:=0;
    Qtdepecas:=0;
    QtdePeso:=0;
    if NroPagina=1 then begin
       if Comando='de transporte' then result:='';
    end else begin
      if Comando='de transporte' then result:='de transporte';
    end;
    if Comando='a transportar' then result:='a transportar';
  end else begin
    ValorNota:=QMestre.FieldByName('Orca_Valor').AsFloat;
    TotalProdutos:=QMestre.FieldByName('Orca_Valor').AsFloat;
    QtdeProdutos:=Tqtdetotal;
    QtdePecas:=TPecastotal;
    QtdePeso:=TPesoTotal;
    if Comando='de transporte' then result:='de transporte';
    if Comando='a transportar' then result:='';
  end;
  if Comando='Tipo de Obra' then Result:=QMestre.fieldbyname('Orca_prodser').asstring;
  if Comando='Inscrição Estadual do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_inscricaoestadual').asstring;
  if Comando='CNPJ do emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cnpj').asstring;
  if Comando='Endereço emitente' then Result:=Arq.TUnidades.fieldbyname('unid_endereco').asstring;
  if Comando='Bairro emitente' then Result:=Arq.TUnidades.fieldbyname('unid_bairro').asstring;
  if Comando='CEP emitente' then Result:=Arq.TUnidades.fieldbyname('unid_cep').asstring;
  if Comando='Municipio emitente' then Result:=Arq.TUnidades.fieldbyname('unid_municipio').asstring;
  if Comando='UF emitente' then Result:=Arq.TUnidades.fieldbyname('unid_uf').asstring;
  if Comando='Telefone emitente' then Result:=FGeral.Formatatelefone(Arq.TUnidades.fieldbyname('unid_fone').asstring);

  if Comando='Data Orçamento' then Result:=FGeral.formatadata(QMestre.fieldbyname('orca_datamvto').Asdatetime);

    if Comando='Razão Social destinatário' then Result:=QClientes.fieldbyname('clie_razaosocial').asstring;
    if Comando='CNPJ/CPF destinatário' then Result:=FormatoCGCCPF(QClientes.fieldbyname('clie_cnpjcpf').asstring);
    if Comando='Codigo destinatário' then Result:=QClientes.fieldbyname('clie_codigo').asstring;
    if Comando='Endereço destinatário' then result:=QClientes.fieldbyname('clie_endres').asstring;
    if Comando='Bairro destinatário' then result:=QClientes.fieldbyname('clie_bairrores').asstring;
    if Comando='CEP destinatário' then result:=QClientes.fieldbyname('clie_cepres').asstring;
    if Comando='Municipio destinatário' then result:=FCidades.GetNome(QClientes.fieldbyname('clie_cida_codigo_res').asinteger);
    if Comando='Telefone destinatário' then result:=FGeral.Formatatelefone(QClientes.fieldbyname('clie_foneres').asstring);
    if Comando='UF destinatário' then result:=QClientes.fieldbyname('clie_uf').asstring;
    if Comando='Inscrição Estadual do destinatário' then begin
      if QClientes.fieldbyname('clie_tipo').asstring='F' then
        Result:='Isento'
      else
        result:=QClientes.fieldbyname('clie_rgie').asstring;
    end;

  if Comando='Numero' then result:=QMestre.fieldbyname('orca_numerodoc').asstring;

// dados q "se repetem"
  esp:=Inteiro(especie)-1;
  if ( esp >= 0) and (Inteiro(especie)<=ListaDetalhe.Count) then begin
    PDetalhe:=ListaDetalhe[esp];

    if Comando='Codigo produto' then result:=PDetalhe.Codigoproduto
    else if Comando='Referência produto' then begin
      if pos(PDetalhe.Qualidade,'S;T')>0 then
        result:=''
      else
        result:=FEstoque.GetReferencia(PDetalhe.Codigoproduto);
    end else if Comando='Descrição produto' then result:=copy(PDetalhe.Descricaoproduto,1,30)
    else if Comando='Descrição produto(30)' then result:=copy(PDetalhe.Descricaoproduto,1,30)
    else if Comando='Descrição produto(50)' then result:=copy(PDetalhe.Descricaoproduto,1,50)
    else if Comando='Unidade produto' then result:=PDetalhe.Unidade
    else if Comando='Quantidade' then result:=Transform(PDetalhe.Quantidade,FConfDcto.FormatoQtdes)
    else if Comando='Valor unitário' then result:=Transform(PDetalhe.Unitario,FConfDcto.FormatoValoresUn)
    else if Comando='Valor total' then result:=Transform(PDetalhe.Total,FConfDcto.FormatoValores)
    else if Comando='Codigo cor' then result:=strzero(PDetalhe.codigocor,3)
    else if Comando='Descrição cor' then result:=PDetalhe.DescricaoCor
    else if Comando='Codigo tamanho' then result:=strzero(PDetalhe.codigotamanho,3)
    else if Comando='Descrição tamanho' then result:=PDetalhe.DescricaoTamanho
    else if Comando='Sequencial item' then result:=strzero(PDetalhe.seq,3)
    else if Comando='Peso Unitário' then result:=Transform(FEstoque.Getpeso(PDetalhe.Codigoproduto),f_cr3)
    else if Comando='Peso Total do Produto' then result:=Transform(FEstoque.Getpeso(PDetalhe.Codigoproduto)*FTamanhos.GetComprimento(PDetalhe.CodigoTamanho),f_cr)
    else result:=tiraaspas(comando); // para imprimir strings colocadas no detalhe
  end;                                 ///       FConfDcto.TransformDcto(Valor,FConfDcto.FormatoValores);

  if Comando='Valor Total do Orçamento' then
    result:=Tratavalor(valornota);
  if Comando='Valor total dos produtos' then
    result:=Tratavalor(totalprodutos);

  if Comando='Total Quantidade' then result:=FConfDcto.TransformDcto(Qtdeprodutos,FConfDcto.formatoQtdesInt)
  else if Comando='Total Peças' then result:=FConfDcto.TransformDcto(Qtdepecas,FConfDcto.formatoQtdesInt)
  else if Comando='Peso Total' then result:=FConfDcto.TransformDcto(Qtdepeso,FConfDcto.FormatoQtdes);

  if Comando='Valor Desconto sobre Total do Orçamento' then begin
    if QMestre.fieldbyname('Orcc_desconto01').ascurrency>0 then begin
      Valormaisdesconto:=(totalprodutos)/(1-(QMestre.fieldbyname('Orcc_desconto01').ascurrency/100));
      result:='Desconto  : '+FConfDcto.TransformDcto(Valormaisdesconto-totalprodutos ,FConfDcto.FormatoValores)
    end else
      result:='';
  end;
  if Comando='Codigo usuário' then result:=QMestre.fieldbyname('orca_usua_codigo').asstring
  else if Comando='Nome usuário' then result:=FUsuarios.GetNome(QMestre.fieldbyname('orca_usua_codigo').asinteger);
  if Comando='Condição de Pagamento' then result:=FCondpagto.getreduzido(QMestre.fieldbyname('orcc_fpgt_codigo').asstring)
  else if Comando='Valor a Vista' then result:=FConfDcto.TransformDcto(valoravista,FConfDcto.FormatoValores);
  if Comando='Codigo representante' then result:=QMestre.fieldbyname('orca_repr_codigo').asstring;
  if Comando='Nome representante' then result:=FRepresentantes.GetDescricaoSql(QMestre.fieldbyname('orca_repr_codigo').asinteger);
  if Comando='Observações' then result:=QMestre.fieldbyname('orca_obs').asstring
  else if Comando='Observações   1 a 100' then result:=copy(QMestre.fieldbyname('orca_obs').asstring,1,100)
  else if Comando='Observações 101 a 200' then result:=copy(QMestre.fieldbyname('orca_obs').asstring,101,099)
  else if Comando='Vencimento 1' then result:=venc1
  else if Comando='Parcela 1' then result:=parc1
  else if Comando='Vencimento 2' then result:=venc2
  else if Comando='Parcela 2' then result:=parc2
  else if Comando='Vencimento 3' then result:=venc3
  else if Comando='Parcela 3' then result:=parc3
  else if Comando='Vencimento 4' then result:=venc4
  else if Comando='Parcela 4' then result:=parc4;

end;

// 19.08.13
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//function TFImpressao.ImprimeOrcamentoObra(Numero: Integer;  DataMvto: TDatetime; Unidade,xNomeorcam: string): Boolean;
function TFImpressao.ImprimeOrcamentoObra(Numero: Integer;  Unidade,xNomeorcam: string): Boolean;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var n,nn,p,seq:Integer;
    FormaImpressao,Codigo,sqltipomovm,sqltipomovd,CodigoU:String;
    valortotal,Tvalortotal,acumulado,valorparcela:currency;
    venci:TDatetime;
    ListaPrazo:TStringlist;


    procedure Envia_Impressora;
    ///////////////////////////
    var count,countgeral,i:integer;
    begin
      NroPagina:=1;
      NroPaginas:=1;

      if FConfdcto.NumLgPg>0 then begin
        if Listadetalhe.count mod FConfdcto.NumLgPg = 0 then
          count:= Listadetalhe.count div FConfdcto.NumLgPg
        else
          count:= Listadetalhe.count div FConfdcto.NumLgPg + 1;
        if count=0 then  //  15.08.05 - credito de chu peças sem itens
          count:=1;
      end else
        count:=1;

      NroPaginas:=count;
      for i:=1 to count do begin
        NroPagina:=i;
        FConfDcto.Print(Codigo, RetornoOrcamentoObra, i = 1, i = count);
        if count>1 then
          FConfDcto.GetConfiguracao(Codigo);

      end;
    end;

begin
//////////////////////////////////////
  Result:=True;
  if not Arq.TUnidades.active then Arq.TUnidades.Open;
/////////////////////  try
    QMestre:=sqltoquery('select * from orcamencal '+
                     ' inner join orcamentos on (orca_numerodoc=orcc_numerodoc)'+
                     ' where orcc_numerodoc='+inttostr(Numero)+
//                     ' and orcc_datamvto='+Datetosql(Datamvto)+
                     ' and orcc_unid_codigo='+Stringtosql(unidade)+
                     ' and '+Fgeral.getin('orcc_status','N','C')+
                     ' and orcc_nome='+stringtosql(xnomeorcam)+
                     ' order by orcc_numerodoc' );
    QMestre.Name:='QMestre';
    if not QMestre.Eof then begin
      Codigo:=FGeral.GetConfig1AsString('Improrcobra');
// 27.08.12 - Codigo Impresso Pedido de Venda por usuario
//      CodigoU:=FUsuarios.GetImpressoPedidoVenda(Global.Usuario.Codigo);
//      if trim(codigou)<>'' then codigo:=codigou;
      if trim(codigo)='' then begin
         Avisoerro('Falta configurar o codigo deste impresso na configuração geral aba impressos');
         QMestre.close;
         Freeandnil(QMestre);
         exit;
      end;
      Arq.TUnidades.locate('unid_codigo',unidade,[]);
      npar:=0;
      parc1:='';parc2:='';parc3:='';parc4:='';parc5:='';parc6:='';
      venc1:='';venc2:='';venc3:='';venc4:='';venc5:='';venc6:='';
      condicao:=QMestre.fieldbyname('orcc_fpgt_codigo').asstring;
      if ( FCondpagto.GetAvPz(condicao)='V' ) then begin
        valoravista:=QMestre.fieldbyname('orcc_venda').ascurrency;
        venc1:='a Vista ';
        parc1:=formatfloat(FConfDcto.FormatoValores,QMestre.fieldbyname('orca_venda').ascurrency);
      end else begin
        valoravista:=0;

        ListaPrazo:=TStringlist.create;
        strtolista(ListaPrazo,FCondPagto.GetCampoPrazos(condicao),';',true);
        npar:=FCondpagto.GetNumeroParcelas(condicao);
        acumulado:=0;
        valortotal:=QMestre.fieldbyname('orcc_venda').ascurrency;
        for p:=1 to npar do begin
          venci:=FGeral.GetProximoDiaUtil(QMestre.fieldbyname('orca_datamvto').Asdatetime+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1])) ;
          if FCondPagto.GetAvPz(condicao)='P' then
            venci:=FGeral.GetVencimentoPadrao(venci);
          if p=1 then
            venc1:=FGeral.formatadata( venci )
          else if p=2 then
            venc2:=FGeral.formatadata( venci )
          else if p=3 then
            venc3:=FGeral.formatadata( venci )
          else if p=4 then
            venc4:=FGeral.formatadata( venci )
          else if p=5 then
            venc5:=FGeral.formatadata( venci )
          else if p=6 then
            venc6:=FGeral.formatadata( venci );
          if (p=npar) and (valoravista=0) then
            valorparcela:=valortotal-acumulado  // para deixar na ultima parcelas "as dízimas"
          else begin
            if (valoravista>0) then begin
              valorparcela:=FGeral.Arredonda(valortotal/(npar-1),2);
              if (p=npar) then
                valorparcela:=valortotal+valoravista-acumulado  // para deixar na ultima parcelas "as dízimas" - 01.06.05
            end else
              valorparcela:=FGeral.Arredonda((valortotal)/npar,2);
          end;
///          if (valoravista>0) and (p=1) then begin
//            GridParcelas.cells[1,p]:=Transform(valoravista,f_cr);
//            acumulado:=acumulado+valoravista;
//          end else begin
          if p=1 then
            parc1:=Transform(valorparcela,f_cr)
          else if p=2 then
            parc2:=Transform(valorparcela,f_cr)
          else if p=3 then
            parc3:=Transform(valorparcela,f_cr)
          else if p=4 then
            parc4:=Transform(valorparcela,f_cr)
          else if p=5 then
            parc5:=Transform(valorparcela,f_cr)
          else if p=6 then
            parc6:=Transform(valorparcela,f_cr);
        end;  // for do numero de parcelas
      end;
//////////////////////////////////////////////


// 10.08.05
      Result:=FConfDcto.GetConfiguracao(Codigo);

      QClientes:=sqltoquery('select * from clientes where clie_codigo='+QMestre.fieldbyname('orca_tipo_codigo').asstring);
      QClientes.Name:='QClientes';

      FormaImpressao:=FCadImp.GetFormaImpressao(Codigo);
       if (FormaImpressao='2') or ((FormaImpressao='1') and (Confirma('Confirma a impressão ?'))) then begin
          if Result then begin
             Sistema.BeginProcess('imprimindo orçamento de obra');
             nn:=0;
             QMestre.First;
             while not QMestre.Eof do begin
               Inc(nn);
               QMestre.Next;
             end;
             QMestre.First;
             n:=0;
             while not QMestre.Eof do begin
               Inc(n);
// detalhes q se repetem
               QDetalhe:=sqltoquery('select * from orcamendet '+
//                     ' leff join estoque on (esto_codigo=orcd_codigo)'+
                     ' left join cores on (core_codigo=orcd_core_codigo)'+
                     ' left join tamanhos on (orcd_tama_codigo=tama_codigo)'+
                     ' where orcd_numerodoc='+inttostr(QMestre.fieldbyname('orca_numerodoc').asinteger)+
                     ' and orcd_nome='+stringtosql(xnomeorcam)+
                     ' and orcd_unid_codigo='+stringtosql(Unidade)+
                     ' and '+FGeral.GetIN('orcd_status','N','C')+
                     ' order by orcd_tipoitem' );
               ListaDetalhe := TList.Create;
               valortotal:=0;TValortotal:=0;TQtdetotal:=0;Tpecastotal:=0;TPesoTotal:=0;
               if Qdetalhe.eof then
                 Avisoerro('Iten(s) não encontrados ou não cadastrados no estoque');
               PedidoPendente:='N';
               seq:=0;
               while not QDetalhe.Eof do begin
                 New(PDetalhe);
                 inc(seq);
// VEr orcd_tipoitem=''C'''+ tem q buscar no cadatro de mao de obra do SAC
///////////////////////////////////////////////////////////////////////////////
                 PDetalhe.Qualidade:=Qdetalhe.fieldbyname('orcd_tipoitem').AsString;
//                 if Qdetalhe.fieldbyname('orcd_tipoitem').AsString='C' then begin
                   PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('orcd_codigo').AsString;
                   PDetalhe.Descricaoproduto:=Qdetalhe.fieldbyname('orcd_descricao').Asstring;
                   PDetalhe.Cst:='';
                   PDetalhe.Unidade:=Qdetalhe.fieldbyname('orcd_unidade').Asstring;
                   PDetalhe.Quantidade:=Qdetalhe.fieldbyname('orcd_qtde').Ascurrency;
                   PDetalhe.TQuantidade:=PDetalhe.TQuantidade+Qdetalhe.fieldbyname('orcd_qtde').AsCurrency;
                   PDetalhe.Unitario:=Qdetalhe.fieldbyname('orcd_unitario').AsCurrency;
                   valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('orcd_unitario').AsCurrency*Qdetalhe.fieldbyname('orcd_qtde').AsCurrency,2);
                   PDetalhe.Total:=valortotal;
                   PDetalhe.icms:=0;
                   PDetalhe.perdesco:=0;
                   PDetalhe.vendabru:=Qdetalhe.fieldbyname('orcd_unitario').AsCurrency;
                   PDetalhe.Codigocor:=Qdetalhe.fieldbyname('orcd_core_codigo').AsInteger;
                   PDetalhe.DescricaoCor:=copy( Qdetalhe.fieldbyname('core_descricao').Asstring,1,10 );
                   PDetalhe.CodigoTamanho:=Qdetalhe.fieldbyname('orcd_tama_codigo').AsInteger;
                   PDetalhe.DescricaoTamanho:=copy( Qdetalhe.fieldbyname('tama_descricao').Asstring,1,10 );
                   PDetalhe.Seq:=seq;
                   PDetalhe.Codigocopa:=0;
                   PDetalhe.DescricaoCopa:='';
                   PDetalhe.Fardos:=0;
                   PDetalhe.Pacotes:=0;
                   PDetalhe.Cubagem:=0;
//////////////                   PDetalhe.Qualidade:='';
                   PDetalhe.Medidas:=FTamanhos.GetMedidas(QDetalhe.fieldbyname('orcd_tama_codigo').asinteger);
                   PDetalhe.descubagem:=0;
//////////////////////////////////////////////////
                   ListaDetalhe.Add(Pdetalhe);
                   Tvalortotal:=Tvalortotal+valortotal;
                   TQtdetotal:=TQtdetotal+Qdetalhe.fieldbyname('orcd_qtde').Ascurrency;
                   TPecastotal:=TPecastotal+0;
                   PDetalhe.pecas:=0;
                   PDetalhe.pecasXqtde:=0;
                   TPesototal:=TPesototal+PDetalhe.pecasXqtde;
                   PDetalhe.pecasXqtdeXuni:=0;
//////////////////////////////////////
{
                 end else begin // demais itens do orçamento q 'ficam no estoque do sac'

                   PDetalhe.Codigoproduto:=Qdetalhe.fieldbyname('orcd_codigo').AsString;
                   PDetalhe.Descricaoproduto:=Qdetalhe.fieldbyname('orcd_descricao').Asstring;
                   PDetalhe.Cst:='';
                   PDetalhe.Unidade:=Qdetalhe.fieldbyname('orcd_unidade').Asstring;
                   PDetalhe.Quantidade:=Qdetalhe.fieldbyname('orcd_qtde').Ascurrency;
                   PDetalhe.TQuantidade:=PDetalhe.TQuantidade+Qdetalhe.fieldbyname('orcd_qtde').AsCurrency;
                   PDetalhe.Unitario:=Qdetalhe.fieldbyname('orcd_unitario').AsCurrency;
                   valortotal:=FGeral.Arredonda(Qdetalhe.fieldbyname('orcd_unitario').AsCurrency*Qdetalhe.fieldbyname('orcd_qtde').AsCurrency,2);
                   PDetalhe.Total:=valortotal;
                   PDetalhe.icms:=0;
                   PDetalhe.perdesco:=0;
                   PDetalhe.vendabru:=Qdetalhe.fieldbyname('orcd_unitario').AsCurrency;
                   PDetalhe.Codigocor:=Qdetalhe.fieldbyname('orcd_core_codigo').AsInteger;
                   PDetalhe.DescricaoCor:=copy( Qdetalhe.fieldbyname('core_descricao').Asstring,1,10 );
                   PDetalhe.CodigoTamanho:=Qdetalhe.fieldbyname('orcd_tama_codigo').AsInteger;
                   PDetalhe.DescricaoTamanho:=copy( Qdetalhe.fieldbyname('tama_descricao').Asstring,1,10 );
                   PDetalhe.Seq:=seq;
                   PDetalhe.Codigocopa:=0;
                   PDetalhe.DescricaoCopa:='';
                   PDetalhe.Fardos:=0;
                   PDetalhe.Pacotes:=0;
                   PDetalhe.Cubagem:=0;
////////////////                   PDetalhe.Qualidade:='';
                   PDetalhe.Medidas:=FTamanhos.GetMedidas(QDetalhe.fieldbyname('orcd_tama_codigo').asinteger);
                   PDetalhe.descubagem:=0;

                   ListaDetalhe.Add(Pdetalhe);
                   Tvalortotal:=Tvalortotal+valortotal;
                   TQtdetotal:=TQtdetotal+Qdetalhe.fieldbyname('orcd_qtde').Ascurrency;
                   TPecastotal:=TPecastotal+0;
                   PDetalhe.pecas:=0;
                   PDetalhe.pecasXqtde:=0;
                   TPesototal:=TPesototal+PDetalhe.pecasXqtde;
                   PDetalhe.pecasXqtdeXuni:=0;
                 end;
                 }
//////////////////////////////////////

                 QDetalhe.Next;
               end;

               if (not QDetalhe.IsEmpty)  then begin
                  Envia_Impressora;

               end;  // QDetalhe.isempty

               QDetalhe.Close;Listadetalhe.Free;
               QMestre.Next;
             end;
             Sistema.EndProcess('');
          end;
       end;
       Qclientes.close;
       Freeandnil(Qclientes);

    end else begin
//      Avisoerro('Orçamento '+inttostr(Numero)+' de '+Datetostr(Datamvto)+' não encontrado.');
      Avisoerro('Orçamento '+inttostr(Numero)+' não encontrado.');

    end;

    QMestre.Close;Freeandnil(QMestre);
    if QDetalhe<>nil then
       Freeandnil(QDetalhe);
//  except
//  end;
  Sistema.EndProcess('');

end;

end.


