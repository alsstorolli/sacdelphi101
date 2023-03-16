unit expcte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SqlDtg, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  SQLGrid, ExtCtrls, ACBrCTe, SqlExpr, SqlSis, ACBrBase, pcnConversao, pcnNFe,
  ACBrSocket, ACBrIBGE, ACBrDFe, pcteConversaoCTE, ACBrDFeReport,
  ACBrCTeDACTEClass, ACBrCTeDACTeRLClass;

type
  TFExpCte = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bExecutar: TSQLBtn;
    bSair: TSQLBtn;
    bexportados: TSQLBtn;
    bexpxml: TSQLBtn;
    bgerenciar: TSQLBtn;
    bconsultasefa: TSQLBtn;
    bconsutawebser: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Edtermino: TSQLEd;
    EdInicio: TSQLEd;
    EdTran_codigo: TSQLEd;
    EdTran_nome: TSQLEd;
    pgrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    Edformaemissao: TSQLEd;
    EdNumeronotas: TSQLEd;
    EdAmbiente: TSQLEd;
    EdExportadas: TSQLEd;
    EdNotas: TSQLEd;
    ACBrCTe1: TACBrCTe;
    ACBrCTeDACTeRL1: TACBrCTeDACTeRL;
    procedure bexpxmlClick(Sender: TObject);
    procedure EdterminoValidate(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdAmbienteValidate(Sender: TObject);
    procedure EdNotasValidate(Sender: TObject);
    procedure EdformaemissaoExitEdit(Sender: TObject);
    procedure bexportadosClick(Sender: TObject);
    procedure bconsultasefaClick(Sender: TObject);
    procedure bgerenciarClick(Sender: TObject);
    procedure bconsutawebserClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute( numeronota:integer=0 ; situacaonotas:string='');
    function ContaNotas(Grid:TSqldtgrid):integer;
    procedure EnviaConsultaSefa(op:string);
    function GetCodigoUfIbge( xuf:string ):integer;
    procedure FechaArquivosXML;
    function TiraString(stringatirar,stringdeondetirar:string):string;
    function GetTag(ctag,xml:string):string;
    function GetRetorno(xml:string):string;
    procedure AtualizaGrid(nf:integer ; xretorno:string);
    function GetGridTransacao(nf:integer):string;

  end;

var
  FExpCte: TFExpCte;
  tiposdemovimento,tiposnao,
  TiposDevolucao,xsituacaonotas:string;
  Q,QMOvb,QConfMov:Tsqlquery;
  Arquivo,ArqClientes,ArqProdutos,ArqTransp:Textfile;
  RetornoVazio:boolean;
  campo:TDicionario;
  xnumeronota:integer;
  xmlstring:WideString;

implementation

uses Geral, SqlFun , sintegra, Unidades, fornece, SQLRel, Estoque, munic,
  represen, Natureza, pcteCTe, codigosfis, nfsaida, gerenciacte,
  consultawebsernfe, expnfetxt;

{$R *.dfm}

{ TFExpCte }

procedure TFExpCte.Execute(numeronota: integer; situacaonotas: string);
///////////////////////////////////////////////////////////////////////////
var numerosnotas,sqlconfmov:string;
    Q:TSqlquery;
begin
  sqlconfmov:='';
  if FGeral.ConfiguradoECF then
    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));
  tiposdemovimento:=Global.CodConhecimentoSaida;
  tiposnao:=Global.TiposNaoFiscal+';'+Global.CodPrestacaoServicos+';'+Global.CodVendaInterna;
  RetornoVazio:=true;
// 07.07.11
  TiposDevolucao:=Global.CodDevolucaoCompra+';'+Global.CodDevolucaoCompraSemEstoque+';'+
                  Global.CodDevolucaoIgualVenda+';'+Global.CodDevolucaoInd+';'+
                  Global.CodDevolucaoSimbolicaConsig+';'+
                  Global.CodDevolucaodeRemessa+';'+
                  Global.CodDevolucaoRoman+';'+
                  Global.CodDevolucaoTributada;

//  bexpxml.Visible:=Global.Usuario.Codigo=100;
//  bexpxml.Enabled:=Global.Usuario.Codigo=100;

  Show;
  Grid.clear;
  EdUnid_codigo.text:=Global.CodigoUnidade;
// 08.03.10
  if trim( FGeral.GetConfig1AsString('AmbienteCTe') )<>'' then
    EdAmbiente.text:=FGeral.GetConfig1AsString('AmbienteCTe')
  else
    EdAmbiente.text:='1';
// 02.01.14
  ACBrCte1.Configuracoes.WebServices.ProxyHost:='';
  ACBrCte1.Configuracoes.WebServices.ProxyUser:='';
  ACBrCte1.Configuracoes.WebServices.ProxyPass:='';
  ACBrCte1.Configuracoes.WebServices.ProxyPort:='';
  ACBrCte1.Configuracoes.Geral.ValidarDigest:=false;

  //    FGeral.ACBrIBPTax1.ProxyHost:='192.168.1.253';
  FGeral.ACBrIBPTax1.ProxyHost:='';
  FGeral.ACBrIBPTax1.ProxyUser:='';
//    FGeral.ACBrIBPTax1.ProxyPass:='andre2014';
  FGeral.ACBrIBPTax1.ProxyPass:='';
  FGeral.ACBrIBPTax1.ProxyPort:='';
  if Global.Topicos[1013] then begin
    ACBrCte1.Configuracoes.WebServices.ProxyHost:=FGeral.GetConfig1AsString('ipproxy');
    ACBrCte1.Configuracoes.WebServices.ProxyUser:=FGeral.GetConfig1AsString('usuarioproxy');
    ACBrCte1.Configuracoes.WebServices.ProxyPass:=FGeral.GetConfig1AsString('senhaproxy');
    ACBrCte1.Configuracoes.WebServices.ProxyPort:=FGeral.GetConfig1AsString('portaproxy');
//    FGeral.ACBrIBPTax1.ProxyHost:='192.168.1.253';
    FGeral.ACBrIBPTax1.ProxyHost:=FGeral.GetConfig1AsString('ipproxy');
    FGeral.ACBrIBPTax1.ProxyUser:=FGeral.GetConfig1AsString('usuarioproxy');
//    FGeral.ACBrIBPTax1.ProxyPass:='andre2014';
    FGeral.ACBrIBPTax1.ProxyPass:=FGeral.GetConfig1AsString('senhaproxy');
    FGeral.ACBrIBPTax1.ProxyPort:=FGeral.GetConfig1AsString('portaproxy');
  end;

// 07.07.10 - Abra
  if Global.Topicos[1014] then
    ACBrCte1.Configuracoes.WebServices.Visualizar:=true
  else
    ACBrCte1.Configuracoes.WebServices.Visualizar:=false;
// 21.09.10
  if trim( FGeral.GetConfig1AsString('Pastaschemas') ) <> '' then
    ACBrCte1.Configuracoes.Arquivos.PathSchemas:=FGeral.GetConfig1AsString('Pastaschemas')
  else
    ACBrCte1.Configuracoes.Arquivos.PathSchemas:=ExtractFilePath( Application.ExeName )+'SchemasCTe20';

// 27.09.10
  ACBrCte1.Configuracoes.Arquivos.Salvar:=true;
  if EdInicio.isempty then
    EdInicio.setdate(sistema.hoje);
  if EdTermino.isempty then
    EdTermino.setdate(sistema.hoje);
// 11.05.11
  xnumeronota:=numeronota;
// 04.10.11
  xsituacaonotas:=situacaonotas;
// 08.08.18
  Acbrcte1.Configuracoes.Geral.VersaoDF:=ve300;

  if xnumeronota>0 then begin
    EdInicio.setdate( Sistema.Hoje );
    EdTermino.setdate( Sistema.Hoje );
    EdInicio.Next;
    EdTermino.Next;
    EdUnid_codigo.Next;
    EdAmbiente.Next;
    EdTran_codigo.Next;
    EdNotas.Text:=strzero(numeronota,6);
    EdNotas.Next;
    EdFormaEmissao.text:='1';
    EdFormaEmissao.Next;
    bexpxmlClick(self);
    FGerenciaCTe.Execute(inttostr(numeronota));
    FGerenciaCTe.bimpdacteClick(self);
    FGerenciaCTe.Close;
    Close;
  end else if xsituacaonotas<>'' then begin
    Q:=Sqltoquery('select moes_numerodoc from movesto where moes_chavenfe is null'+
                  ' and moes_datamvto='+Datetosql(Sistema.hoje)+
                  ' and moes_status<>''C'''+
                  sqlconfmov+   // 23.01.12
                  ' and moes_unid_codigo='+EdUnid_codigo.assql+
                  ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                  ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                  ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C') );
    numerosnotas:='';
    while not Q.eof do begin
      if Q.fieldbyname('moes_numerodoc').AsInteger>0 then
        numerosnotas:=numerosnotas+strzero( Q.fieldbyname('moes_numerodoc').AsInteger ,6)+';';
      Q.Next;
    end;
    FGeral.FechaQuery(Q);
    if trim(numerosnotas)='' then begin
      Aviso('N�o encontrado notas a enviar para Sefa');
      close;
      exit;
    end;
    EdInicio.setdate( Sistema.Hoje );
    EdTermino.setdate( Sistema.Hoje );
    EdInicio.Next;
    EdTermino.Next;
    EdUnid_codigo.Next;
    EdAmbiente.Next;
    EdTran_codigo.Next;
    EdNotas.Text:=numerosnotas;
    EdNotas.Next;
    EdFormaEmissao.text:='1';
    EdFormaEmissao.Next;
    bexpxmlClick(self);
///    FGerenciaNfe.Execute(numerosnotas);
//    FGerenciaNfe.bimpdanfeClick(self);
//    FGerenciaNfe.Close;
    Close;

  end else
    EdInicio.SetFirstEd;
//  EdInicio.SetFocus;

end;

procedure TFExpCte.bexpxmlClick(Sender: TObject);
///////////////////////////////////////////////////////
begin

   EnviaConsultaSefa('E');

end;

procedure TFExpCte.EdterminoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
begin
    if EdTermino.asdate<EdInicio.asdate then
      EdTermino.invalid('T�rmino deve ser posterior ao inicio');

end;

procedure TFExpCte.EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
begin
  FGeral.Limpaedit(EdUnid_codigo,key);

end;

procedure TFExpCte.EdAmbienteValidate(Sender: TObject);
/////////////////////////////////////////////////////////
var Q:Tsqlquery;
    sqltran,sqlconfmov:string;
begin
  sqltran:='';
  sqlconfmov:='';
  if FGeral.ConfiguradoECF then
    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));

  if not EdTRan_codigo.isempty then
    sqltran:=' and '+FGeral.Getin('moes_tran_codigo',EdTran_codigo.text,'C');
  Q:=sqltoquery('select movesto.moes_numerodoc,clientes.clie_razaosocial,clientes.clie_tipo,clientes.clie_endres,clientes.clie_uf from movesto'+
                ' left join clientes on (clie_codigo=moes_tipo_codigo)'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                sqltran+sqlconfmov+
                ' order by moes_numerodoc' );
  EdNotas.Items.Clear;
  if not Q.eof then begin
    while not Q.eof do begin
      EdNotas.Items.add(strzero(Q.fieldbyname('moes_numerodoc').asinteger,6));
      Q.Next;
    end;
  end;
  FGeral.fechaquery(Q);

end;

procedure TFExpCte.EdNotasValidate(Sender: TObject);
////////////////////////////////////////////////////
begin
   if not EdNotas.IsEmpty then begin
     EdExportadas.enabled:=false;
     EdExportadas.text:='A';
   end else begin
     EdExportadas.enabled:=true;
   end;

end;

procedure TFExpCte.EdformaemissaoExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////
var sqltran,sqlexp,sqlnotas,sqlconfmov:string;
    p:integer;

   procedure ChecaEnderecos(Grid1:TSqlDtGrid);
   //////////////////////////////////////////////
   var i,posicaovirgula,posicaokm,posicao2numeros:integer;
       numero:string;
   begin
     for i:=1 to Grid.RowCount do begin
       if strtointdef(Grid1.Cells[Grid.getcolumn('moes_numerodoc'),i],0)>0 then begin
         posicaovirgula:=pos(',',Grid1.Cells[Grid.getcolumn('clie_endres'),i]);
         posicaokm:=pos('KM',uppercase(Grid1.Cells[Grid.getcolumn('clie_endres'),i]));
         posicao2numeros:=FSintegra.Posicao2num(Grid1.Cells[Grid.getcolumn('clie_endres'),i]);
         if (posicaovirgula+posicaokm+posicao2numeros)=0 then begin
           Grid1.Cells[Grid.getcolumn('clie_uf'),i]:='S';
//           Grid1.Cells[Grid.getcolumn('clie_tipo'),i]:='';
         end else begin
           if (posicaovirgula>0) then
             numero:=copy(Grid1.Cells[Grid.getcolumn('clie_endres'),i],posicaovirgula+1,5)
           else if (posicaokm>0) then
             numero:=copy(Grid1.Cells[Grid.getcolumn('clie_endres'),i],posicaokm+3,4)
           else
             numero:=copy(Grid1.Cells[Grid.getcolumn('clie_endres'),i],posicao2numeros,4);
           Grid1.Cells[Grid.getcolumn('clie_uf'),i]:='N';
//           Grid1.Cells[Grid.getcolumn('clie_tipo'),i]:=numero;
         end;
       end;
     end;
   end;

begin
////////////////////////////////////////////////////////////////////

  sqltran:='';sqlexp:='';sqlnotas:='';
  if not EdTRan_codigo.isempty then
    sqltran:=' and '+FGeral.Getin('moes_tran_codigo',EdTran_codigo.text,'C');
  if EdExportadas.text='S' then
    sqlexp:=' and moes_nfeexp=''S'''
  else if EdExportadas.text='N' then
    sqlexp:=' and ( (moes_nfeexp is null) or (moes_nfeexp<>''S'') )';
  if not EdNotas.isempty then
    sqlnotas:=' and '+FGeral.GetIN('moes_numerodoc',EdNOtas.text,'N');
// 23.01.12
  sqlconfmov:='';
  if FGeral.ConfiguradoECF then
    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));
  Q:=sqltoquery('select movesto.*,clientes.clie_razaosocial,clientes.clie_tipo,clientes.clie_endres,'+
                'clientes.clie_uf,clientes.clie_nome from movesto'+
                ' left join clientes on (clie_codigo=moes_tipo_codigo)'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                 sqlconfmov+   // 23.01.12
                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                sqltran+sqlexp+sqlnotas+
//                ' and moes_tipocad='+stringtosql(Cv)+
                ' order by moes_datamvto,moes_vispra' );
  if Q.eof then begin
    Avisoerro('Nada encontrado para exporta��o');
    exit;
  end;
//  Grid.QueryToGrid(Q);
  Grid.Clear;p:=1;
  while not Q.eof do begin
    Grid.Cells[Grid.GetColumn('moes_numerodoc'),p]:=Q.fieldbyname('moes_numerodoc').asstring;
    Grid.Cells[Grid.GetColumn('moes_dataemissao'),p]:=FGeral.FormataData( Q.fieldbyname('moes_dataemissao').asdatetime );
    Grid.Cells[Grid.GetColumn('moes_vlrtotal'),p]:=floattostr(Q.fieldbyname('moes_vlrtotal').Ascurrency);
    Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p]:=Q.fieldbyname('moes_tipo_codigo').asstring;
    if Q.FieldByName('moes_tipocad').AsString='C' then begin
      Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:= Q.fieldbyname('clie_razaosocial').asstring;
      Grid.Cells[Grid.GetColumn('clie_endres'),p]:=Q.fieldbyname('clie_endres').asstring
//      Grid.Cells[Grid.GetColumn('clie_uf'),p]:=Q.fieldbyname('clie_uf').asstring
    end else if Q.FieldByName('moes_tipocad').AsString='U' then begin
      Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:=FGeral.GetNomeRazaoSocialEntidade( Q.fieldbyname('moes_tipo_codigo').asinteger,
                                Q.fieldbyname('moes_tipocad').asstring,'R');
      Grid.Cells[Grid.GetColumn('clie_endres'),p]:=FUnidades.getendereco( Q.fieldbyname('moes_unid_codigo').asstring );
//      Grid.Cells[Grid.GetColumn('clie_uf'),p]:=Q.fieldbyname('clie_uf').asstring
    end else begin
      Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:=FGeral.GetNomeRazaoSocialEntidade( Q.fieldbyname('moes_tipo_codigo').asinteger,
                                Q.fieldbyname('moes_tipocad').asstring,'R');
      Grid.Cells[Grid.GetColumn('clie_endres'),p]:=FFornece.GetEndereco( Q.fieldbyname('moes_tipo_codigo').Asinteger );
//      Grid.Cells[Grid.GetColumn('clie_uf'),p]:=Q.fieldbyname('clie_uf').asstring
    end;
    Grid.Cells[Grid.GetColumn('moes_transacao'),p]:=Q.fieldbyname('moes_transacao').asstring;
    Grid.Cells[Grid.GetColumn('retorno'),p]:=Q.fieldbyname('moes_retornonfe').asstring;
    Grid.AppendRow;
    inc(p);
    Q.Next;
  end;
  ChecaEnderecos(Grid);
  EdNumeronotas.setvalue(ContaNotas(Grid));

end;


function TFExpCte.ContaNotas(Grid: TSqldtgrid): integer;
///////////////////////////////////////////////////////////
var p,n:integer;
begin
  n:=0;
  for p:=1 to Grid.RowCount do begin
    if trim( Grid.Cells[Grid.getcolumn('moes_numerodoc'),p] )<>'' then begin
      inc(n);
    end;
  end;
  result:=n;
end;

procedure TFExpCte.bexportadosClick(Sender: TObject);
///////////////////////////////////////////////////////
var p:integer;
    Lista:TStringlist;
begin
  FRel.Init('RelEnderecosCte');
  FRel.AddTit('Rela��o de Endere�os para Corre��o para CTe');
  FRel.AddTit('Per�odo Exportado '+FGeral.formatadata(Edinicio.asdate)+' a '+FGeral.formatadata(EdTermino.asdate));
  FRel.AddCol( 60,3,'N','' ,''              ,'Codigo'          ,''         ,'',false);
  FRel.AddCol(150,1,'C','' ,''              ,'Raz�o Social'           ,''         ,'',false);
  FRel.AddCol(220,1,'C','' ,''              ,'Endere�o Resid.'         ,''         ,'',false);
  Lista:=TStringlist.Create;
  for p:=1 to Grid.RowCount do begin
    if (Grid.Cells[Grid.getcolumn('clie_uf'),p]='S') and (Lista.IndexOf(Grid.Cells[Grid.getcolumn('moes_tipo_codigo'),p])=-1) then begin
      FRel.AddCel(Grid.Cells[Grid.getcolumn('moes_tipo_codigo'),p]);
      FRel.AddCel(Grid.Cells[Grid.getcolumn('clie_razaosocial'),p]);
      FRel.AddCel(Grid.Cells[Grid.getcolumn('clie_endres'),p]);
      Lista.Add(Grid.Cells[Grid.getcolumn('moes_tipo_codigo'),p]);
    end;
  end;
  FRel.Video();
  Lista.free;
end;

procedure TFExpCte.bconsultasefaClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
   EnviaConsultaSefa('C');
end;

procedure TFExpCte.EnviaConsultaSefa(op: string);
//////////////////////////////////////////////////////
var linha,transacoes,sep,codmuni,codmuniemitente,chaveacesso,vistaprazo,tipodoc,formatodanfe,codigonumerico,
    Ambiente,Finalidade,versao,numero,
    nomepais,versaolayout,qtipo,cnpjtran,cpftran,rntc,
    codigoproduto,redubasetexto,modbc,modbcst,caracteresespeciais,dadosadicionais,cretorno,
    ctransacao,senhacertificado,cfopind,ConsumidorFinal,TiposNumeracaoSaida,cretornoerro,ces,
    pathenvioexterno ,arquivoexterno,arquivoexternoret,pathenvioexternoretorno,pathretornoexterno,
    drive:string;
    Q1,QDesti,QPend,QNfe,QItens,QRem,Q71,
    QToma             :TSqlquery;
    TNOtas,TClientes,TProdutos,TClientesCodigo,TProdutosCodigo,TProdutosCodigoCst,
    TProdutosAux,ListaProdutosCst,TTransp,TTranspCodigo:TStringlist;
    Nnotas,seq,qtderegn,i,y,codigopais,NUmlote,tempo:integer;
    Datam:TDatetime;
    Totalitem,redubase,baseicms,vlricms,vlrpis,alipis,vlrcofins,alicofins,totalpis,
    totalcofins,vlrdesco,vlrii,aliicms,vlripi,totalitens,vendaliquido,despacessorias,
    baseicmssemreducao,Valortotalimpaproximado,xvTotTrib,margemlucro,basesubs,icmsitemsubs,
    vlrcarga:currency;
    rateioicmsimportacao:extended;
    NotasE:TAcBrCte;
    ListaEnvioNotas:TStringList;
    ChecaStatusSefa:boolean;
    xmlaux:TStringList;
    xLink: array[0..120] of WideChar;


var ct,ct1:string;
    ListaXML:TStringList;
    arqxmlretorno:string;
    Statusok,Temdi,cOK:boolean;

    procedure GeraArquivo(Lista:TStringlist ; tipo:string  );
    /////////////////////////////////////////////////////////
    var p:integer;
    begin
      for p:=0 to Lista.count-1 do begin
        if tipo='NOTAS' then
          Writeln(arquivo,Lista[p])
        else if tipo='PRODUTOS' then
          Writeln(arqProdutos,Lista[p])
        else if tipo='CLIENTES' then begin
          Writeln(arqClientes,'A'+SEP+versaolayout+sep);
          Writeln(arqClientes,Lista[p]);
        end else if tipo='TRANSPORTADORA' then begin
          Writeln(arqTransp,'A'+SEP+versaolayout+sep);
          Writeln(arqTransp,Lista[p]);
        end;
      end;
    end;

    function GetSerie(serie,tipoemissao:string):integer;
    ////////////////////////////////////////
    begin
      if trim(uppercase(serie))='U' then
        result:=0
      else if tipoemissao='3' then  // 05.11.2012 - Contingencia via Scan
        result:=901
      else
        result:=strtointdef(trim(serie),0);
    end;

    function GetCodigoNumerico(t:string):string;
    /////////////////////////////////////////////
    var s:integer;
    begin
      s:=length(trim(t));
      if s<9 then
        result:=t+copy('0000000000',1,9-s)
      else if s=9 then
        result:=copy(t,1,9)
      else if s=10 then
        result:=copy(t,2,9)
      else if s=11 then
        result:=copy(t,3,9)
      else
        result:=copy(t,4,9);
    end;

    function GetDvChaveAcesso(chave:string):string;
    ///////////////////////////////////////////////
    var t,i,soma,multi,n,resto:integer;
    begin
      t:=length(trim(chave));
      n:=2;soma:=0;
      for i:=t downto 1 do begin
         multi:=n*strtoint(copy(chave,i,1));
         soma:=soma+multi;
         if n=9 then
           n:=2
         else
           inc(n);

      end;

//      showmessage('soma='+inttostr(soma)+' multi='+inttostr(multi));

      resto:= (soma mod 11);
      if (resto=0) or (resto=1) then
        result:='0'
      else
        result:=inttostr(11-resto);
    end;

    function GetInsEst(s:string;tipo:string='C'):string;
    ///////////////////////////////////////////////////
    var d:string;
    begin
          if (trim(s)='')  then
//            d:='ISENTO'  // nao validou a nota
            d:=''
          else if tipo='T' then  // 10.11.08
              d:=copy(s,1,14)
          else if  Q.fieldbyname('moes_tipocad').asstring='C' then begin
            if QDesti.fieldbyname('clie_tipo').asstring='F' then begin
//              d:='ISENTO'
// 02.12.08 - 'ISENTO' � SOMENTE SE for contribuiente do icms mas nao estiver obrigado a ter
//                     inscri��o estadual  // no do produtor rural deixar em branco
// 04.02.13 - cliente da Cenitech exigiu cpf e inscricao estadual do produtor rural
              d:='';
              if QDesti.fieldbyname('Clie_contribuinte').asstring='S' then
                d:=Uppercase( copy(s,1,14) ) ;
            end else
              d:=Uppercase( copy(s,1,14) ) ;
          end else
            d:=Uppercase( copy(s,1,14) ) ;
          result:=strspace( Uppercase(d) ,14);  // uppercase em 27.09.10
    end;

    function GetCnpjCpf(s:string ; tam:integer):string;
    //////////////////////////////////////////////////
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
      if (trim(s)='') then begin
        if (Q.fieldbyname('moes_estado').asstring)<>'EX' then
          Avisoerro('Codigo '+Q.fieldbyname('moes_tipo_codigo').asstring+' de '+t+' sem CNPJ/CPF');
        d:=strzero(0,14);
      end else if length(trim(s))<tam then
        d:='000'+strspace( copy(s,1,11) ,11 )
      else
        d:=strspace(copy(s,1,14),tam);
      result:=d;
    end;

    function GetTelefone(fone:string):string;
    //////////////////////////////////////////
    begin
      if length(trim(fone))<=8 then
        result:='46'+fone
      else if copy(fone,1,1)='0' then
        result:=copy(fone,2,10)
      else if copy(fone,3,1)=' ' then // (46 )32259396
        result:=copy(fone,1,02)+copy(fone,4,08)
// 28.04.11
      else if copy(fone,1,1)=' ' then // ( 46)32259396
        result:=copy(fone,2,02)+copy(fone,4,08)
      else
        result:=copy(fone,1,10);
    end;

    function GetCodigoBarra(codigo:string):string;
    ///////////////////////////////////////////////
    begin
//      if trim(Q1.FieldByName('esto_codbarra').asstring)<>'' then
// 28.04.11
      if copy(Q1.FieldByName('esto_codbarra').asstring,1,3)='789' then
        result:=Q1.FieldByName('esto_codbarra').asstring
      else
        result:='';
    end;

    function GetCfopItem(cst,t,cfop,tipomov,xcfopind:string;ipiproduto:integer;xsimples:string='N'):string;
    ///////////////////////////////////////////////////////////////////////////////////
    var Qb,QIpi:TSqlquery;
    begin
      result:=cfop;
// 19.03.10
      if (ipiproduto<=0)  and ( Global.Topicos[1009] ) and (xsimples='N') then begin
        result:=cfop;
      end else if (ipiproduto<=0) or ( xsimples='S') then begin
        Qb:=sqltoquery('select * from movbase where movb_transacao='+stringtosql(t)+
                       ' and movb_status<>''C'' and movb_tipomov='+stringtosql(tipomov));
        while not Qb.eof do begin
          if Qb.fieldbyname('movb_cst').asstring=cst then begin
            if trim(Qb.fieldbyname('movb_natf_codigo').asstring)<>'' then begin
              result:=Qb.fieldbyname('movb_natf_codigo').asstring;
              break;
            end;
          end;
          Qb.Next;
        end;
// 16.03.10
//      TEstoque:=sqltoquery('select esto_cipi_codigo from estoque where esto_codigo='+stringtosql(produto) );
//      if TEstoque.fieldbyname('esto_cipi_codigo').asinteger>0 then begin
      end else begin
            QIpi:=sqltoquery('select * from codigosipi where cipi_codigo='+inttostr(ipiproduto));
            if not QIpi.eof then begin
               campo:=Sistema.GetDicionario('codigosipi','cipi_fabricap');
               if campo.Tipo<>'' then begin
                 if QIPI.fieldbyname('cipi_fabricap').asstring='S' then
                  result:=xcfopind;
               end else
                  result:=xcfopind;
            end;
            FGeral.Fechaquery(QIpi);
      end;
/////////////////////

// 28.10.09 - devido as variacoes de cfop 'generico'. Ex. : 59491, 59492...
//            o programa da receita de sp nao aceita..nem importa
      result:=copy(result,1,4);
      FGeral.FechaQuery(Qb);
    end;

    function GetGrupo(cst:string):string;
    //////////////////////////////////
    begin
          if copy(cst,2,2)='00' then
            result:='N02'
          else if copy(cst,2,2)='10' then
            result:='N03'
          else if copy(cst,2,2)='20' then
            result:='N04'
          else if copy(cst,2,2)='30' then
            result:='N05'
          else if pos( copy(cst,2,2),'40;41;50' ) >0 then
            result:='N06'
          else if copy(cst,2,2)='51' then
            result:='N07'
          else if copy(cst,2,2)='60' then
            result:='N08'
          else if copy(cst,2,2)='70' then
            result:='N09'
          else if copy(cst,2,2)='90' then
            result:='N10'
          else
            result:='CST';

    end;

    function GetRegistrosN(linhaproduto:string):integer;
    ///////////////////////////////////////////////////
    var x,n:integer;
        Lista:TStringlist;
    begin
      n:=0;
      Lista:=TStringList.Create;
      strtolista(Lista,linhaproduto,'|',true);
      if trim(Lista[1])<>'' then begin
        for x:=0 to TProdutosCodigoCst.count-1 do begin
//          if pos( trim(Lista[1]),trim(TProdutosCodigoCst[x]) )>0 then
// 10.11.08
          if trim(Lista[1])=copy(TProdutosCodigoCst[x],1,pos(';',TProdutosCodigoCst[x])-1)  then
            inc(n);
        end;
      end;
      result:=n;
    end;

    function GetCodigoProdutoN(linhaproduto:string):string;
    /////////////////////////////////////////////////////////
    var x,n:integer;
        Lista:TStringlist;
    begin
      n:=0;
      Lista:=TStringList.Create;
      strtolista(Lista,linhaproduto,'|',true);
      result:=Lista[1];
    end;


    function GetCst(xcst:string):TpcnCSTIcms;
    /////////////////////////////////////////
    var ccst:string;
    begin
      result:=cst00;
      ccst:=trim(xcst);
      if ccst='010' then
        result:=cst10
      else if ccst='020' then
        result:=cst20
      else if ccst='030' then
        result:=cst30
      else if ccst='040' then
        result:=cst40
      else if ccst='041' then
        result:=cst41
      else if ccst='050' then
        result:=cst50
      else if ccst='051' then
        result:=cst51
      else if ccst='060' then
        result:=cst60
      else if ccst='070' then
        result:=cst70
      else if ccst='080' then
        result:=cst80
      else if ccst='081' then
        result:=cst81
      else if ccst='090' then
        result:=cst90; //80 e 81 apenas para CTe
    end;

////////////////////// 24.10.11
    function GetCstPis(xcst:string):TpcnCSTPis;
    /////////////////////////////////////////
    var ccst:string;
    begin
      result:=pis01;
      ccst:=trim(xcst);
      if ccst='01' then
        result:=pis01
      else if ccst='02' then
        result:=pis02
      else if ccst='03' then
        result:=pis03
      else if ccst='04' then
        result:=pis04
      else if ccst='05' then
        result:=pis05
      else if ccst='06' then
        result:=pis06
      else if ccst='07' then
        result:=pis07
      else if ccst='08' then
        result:=pis08
      else if ccst='09' then
        result:=pis09
      else if ccst='49' then
        result:=pis49
      else if ccst='50' then
        result:=pis50
      else if ccst='51' then
        result:=pis51
      else if ccst='52' then
        result:=pis52
      else if ccst='53' then
        result:=pis53
      else if ccst='54' then
        result:=pis54
      else if ccst='55' then
        result:=pis55
      else if ccst='56' then
        result:=pis56
      else if ccst='60' then
        result:=pis60
      else if ccst='61' then
        result:=pis61
      else if ccst='62' then
        result:=pis62
      else if ccst='63' then
        result:=pis63
      else if ccst='64' then
        result:=pis64
      else if ccst='65' then
        result:=pis65
      else if ccst='66' then
        result:=pis66
      else if ccst='67' then
        result:=pis67
      else if ccst='70' then
        result:=pis70
      else if ccst='71' then
        result:=pis71
      else if ccst='72' then
        result:=pis72
      else if ccst='73' then
        result:=pis73
      else if ccst='74' then
        result:=pis74
      else if ccst='75' then
        result:=pis75
      else if ccst='98' then
        result:=pis98
      else if ccst='99' then
        result:=pis99;
    end;

////////////////////// 25.10.11
    function GetCstCofins(xcst:string):TpcnCSTCofins;
    /////////////////////////////////////////
    var ccst:string;
    begin
      result:=cof01;
      ccst:=trim(xcst);
      if ccst='01' then
        result:=cof01
      else if ccst='02' then
        result:=cof02
      else if ccst='03' then
        result:=cof03
      else if ccst='04' then
        result:=cof04
      else if ccst='05' then
        result:=cof05
      else if ccst='06' then
        result:=cof06
      else if ccst='07' then
        result:=cof07
      else if ccst='08' then
        result:=cof08
      else if ccst='09' then
        result:=cof09
      else if ccst='49' then
        result:=cof49
      else if ccst='50' then
        result:=cof50
      else if ccst='51' then
        result:=cof51
      else if ccst='52' then
        result:=cof52
      else if ccst='53' then
        result:=cof53
      else if ccst='54' then
        result:=cof54
      else if ccst='55' then
        result:=cof55
      else if ccst='56' then
        result:=cof56
      else if ccst='60' then
        result:=cof60
      else if ccst='61' then
        result:=cof61
      else if ccst='62' then
        result:=cof62
      else if ccst='63' then
        result:=cof63
      else if ccst='64' then
        result:=cof64
      else if ccst='65' then
        result:=cof65
      else if ccst='66' then
        result:=cof66
      else if ccst='67' then
        result:=cof67
      else if ccst='70' then
        result:=cof70
      else if ccst='71' then
        result:=cof71
      else if ccst='72' then
        result:=cof72
      else if ccst='73' then
        result:=cof73
      else if ccst='74' then
        result:=cof74
      else if ccst='75' then
        result:=cof75
      else if ccst='98' then
        result:=cof98
      else if ccst='99' then
        result:=cof99;
    end;

// 22.03.10
    function GetCstIPI(xcst:string):TpcnCSTIpi;
    ////////////////////////////////////////////
    var ccst:string;
        ok:boolean;
//C�digo da Situa��o Tribut�ria do IPI:
//00-Entrada com recupera��o de cr�dito
//49 - Outras entradas
//50-Sa�da tributada
//99-Outras sa�das
    begin
      ok:=true;
      // '50';
      ccst:=trim(xcst);
//por enquanto todos q tem ipi vao como tributados
//      if ccst='000' then
        result:=StrToCSTIPI(ok,'50');
//      else
//        result:=StrToCSTIPI(ok,'99');

    end;

    ///////////////////////////////////////////////////////////////
    function GetOrigemMercadoria(xcst,xSimples:string):TpcnOrigemMercadoria;
    ///////////////////////////////////////////////////////////////
    var ccst:string;
    begin
      result:=oeNacional;
      if xSimples<>'S' then begin   // 12.07.11 ver se precisa buscar do cadastro
        ccst:=trim(xcst);
        if copy(ccst,1,1)='1' then
          result:=oeEstrangeiraImportacaoDireta
        else if copy(ccst,1,1)='2' then
          result:=oeEstrangeiraAdquiridaBrasil;
      end else begin
// 12.07.11
        ccst:=FEstoque.Getsituacaotributaria(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,global.UFUnidade);
        if trim(ccst)='' then ccst:='000';
// 16.04.14 - retirado pois se � do simples '� nacional'...
//        if copy(ccst,1,1)='1' then
//          result:=oeEstrangeiraImportacaoDireta
//        else if copy(ccst,1,1)='2' then
//          result:=oeEstrangeiraAdquiridaBrasil;
      end;

    end;

    /////////////////////////////////////
    function GetSenhaCertificado:boolean;
    /////////////////////////////////////
    var senha:string;
    begin
      result:=true;
      senha:=FGeral.GetConfig1AsString('SenhaCertificado');
      if trim(senha)<>'' then begin
        if Input('Certificado Digital','Informe Senha',senhacertificado,150,false) then begin
          if trim(senhacertificado)<>senha then begin
            result:=false;
            Avisoerro('Senha do certificado divergente com a informada');
          end;
        end else begin
          result:=false;
          Avisoerro('Senha do certificado n�o informada');
        end;
      end;
    end;

    function ValidaNotas( ListaNotas:TACBrCTe ) :boolean;
    //////////////////////////////////////////////////////
    var x,y:integer;
        ListaProdutos:string;
    begin
      result:=true;
      for x:=0 to ListaNotas.Conhecimentos.Count-1 do begin
        if trim(ListaNotas.Conhecimentos.Items[x].CTe.Dest.EnderDest.nro)='' then begin
          Avisoerro('CTe '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Endere�o '+ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.xLgr+' sem numero');
          result:=false;
        end else if trim(ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.xBairro)='' then begin
          Avisoerro('Cte '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Endere�o '+ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.xLgr+' sem bairro');
          result:=false;
        end else if ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.CEP=0 then begin
          Avisoerro('Cte '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Endere�o '+ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.xLgr+' sem Cep');
          result:=false;
// 19.05.11
//        end else if ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.fone then begin
//          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Cliente '+ListaNotas.Conhecimentos.Items[x].Cte.Dest.xNome+' sem telefone');
//          result:=false;
//        end else if ( trim(ListaNotas.Conhecimentos.Items[x].Cte.Transp.veicTransp.placa )='') and (ListaNotas.Conhecimentos.Items[x].Cte.Transp.Transporta.CNPJCPF<>'') then begin
//          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Ve�culo sem placa');
//          result:=false;
// 11.10.11 - Cenitech pegou - n�o d� retorno na sefa e nem da erro de validacao
//        end else if ( length(trim(ListaNotas.Conhecimentos.Items[x].Cte.Transp.veicTransp.placa ))<>7 ) and (ListaNotas.Conhecimentos.Items[x].Cte.Transp.Transporta.CNPJCPF<>'') then begin
//          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Ve�culo com placa diferente de 7 caracteres');
//          result:=false;
//        end else if (trim(ListaNotas.Conhecimentos.Items[x].Cte.Transp.veicTransp.UF )='')  and (ListaNotas.Conhecimentos.Items[x].Cte.Transp.Transporta.CNPJCPF<>'') then begin
//          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Placa sem UF');
//          result:=false;
// 15.04.11
//        end else if length(trim(ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.fone )) < 5 then begin
//          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Destinat�rio sem telefone completo');
//          result:=false;
        end;
        ListaProdutos:='';
        {
        for y:=0 to ListaNotas.Conhecimentos.Items[x].Cte.Det.Count-1 do begin
          if ListaNotas.Conhecimentos.Items[x].Cte.Det.Items[y].Prod.NCM=''  then begin
//            Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+
//            ' Produto '+ListaNotas.Conhecimentos.Items[x].Cte.Det.Items[y].Prod.cProd+' sem NCM' );
            result:=false;
            ListaProdutos:=Listaprodutos+ListaNotas.Conhecimentos.Items[x].Cte.Det.Items[y].Prod.cProd+' | ';
          end;
        end;
        }
// 04.09.13
        if not result then
            Avisoerro('CTe '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+
            ' Produtos '+Listaprodutos+' sem NCM no cadastro de Produtos' );

      end;

    end;

//{
// 23.09.10 - xml 2.0 - deixado fixo em 05.05.11
//  TpcnCRT = (crtSimplesNacional, crtSimplesExcessoReceita, crtRegimeNormal);
//    {$IFDEF LIBXML2}
{  // 10.05.2022 - retirado por n�o ser mais usado t tcrt <> tpcncrt
    function GetCRT(Simples:string):TPcnCRT;
    //////////////////////////////////////////
    begin
      if (Simples='S') or (Simples='1') then //- Optante do simples
        result:=crtSimplesNacional
      else if (Simples='N') or (Simples='E') or (Simples='3') then
        result:=crtRegimeNormal
      else if (Simples='2')  then
        result:=crtSimplesExcessoReceita;

//N - N�o optante do simples
//E - Epp ( Empresa de pequeno porte )
//2 - Optante do simples mas ultrapassou faixa
//3 - N�o � optante do simples

    end;
    }

//    {$ENDIF}
///////////////////////////////
//}


//{
// 23.09.10 - xml 2.0 - fixo em 05.05.11
//  TpcnCSOSNIcms = (csosnVazio,csosn101, csosn102, csosn103, csosn201, csosn202,
//                   csosn203, csosn300, csosn400, csosn500,csosn900 );
//    {$IFDEF LIBXML2}
    function GetCSTSimples(xcst:string):TpcnCSOSNIcms;
    //////////////////////////////////////////
    var Q:TSqlquery;
    begin
        campo:=Sistema.GetDicionario('sittrib','sitt_cstme');
        result:=csosnVazio;
        if campo.tipo<>'' then begin
//        buscar no sitrib cfe o cst q veio aqui comoo parametro mas
//          Q:=sqltoquery('select * from sittrib where sitt_cst='+Stringtosql(xcst)+
//             ' and ( (sitt_es=''S'') or (sitt_es is null) )' );
//          if not Q.eof then begin
//      pegando somente cst ref. Saidas ou null no campo novo sitt_es no sittrib
////////////////////
{
            if Q.fieldbyname('sitt_cstme').asstring<>'' then begin
              if Q.fieldbyname('sitt_cstme').asstring='101' then
                result:=csosn101
              else if Q.fieldbyname('sitt_cstme').asstring='102' then
                result:=csosn102
              else if Q.fieldbyname('sitt_cstme').asstring='103' then
                result:=csosn103
              else if Q.fieldbyname('sitt_cstme').asstring='201' then
                result:=csosn201
              else if Q.fieldbyname('sitt_cstme').asstring='202' then
                result:=csosn202
              else if Q.fieldbyname('sitt_cstme').asstring='202' then
                result:=csosn202
              else if Q.fieldbyname('sitt_cstme').asstring='203' then
                result:=csosn203
              else if Q.fieldbyname('sitt_cstme').asstring='300' then
                result:=csosn300
              else if Q.fieldbyname('sitt_cstme').asstring='400' then
                result:=csosn400
              else if Q.fieldbyname('sitt_cstme').asstring='500' then
                result:=csosn500
              else if Q.fieldbyname('sitt_cstme').asstring='900' then
                result:=csosn900;
            end;
            }
////////////////////
            if xcst<>'' then begin
              if xcst='101' then
                result:=csosn101
              else if xcst='102' then
                result:=csosn102
              else if xcst='103' then
                result:=csosn103
              else if xcst='201' then
                result:=csosn201
              else if xcst='202' then
                result:=csosn202
              else if xcst='202' then
                result:=csosn202
              else if xcst='203' then
                result:=csosn203
              else if xcst='300' then
                result:=csosn300
              else if xcst='400' then
                result:=csosn400
              else if xcst='500' then
                result:=csosn500
              else if xcst='900' then
                result:=csosn900;
            end;

//          end;
//          Q.Close;
        end;
    end;
//    {$ENDIF}
//}


    function GetUnidade(xunidade:string):TUnidMed;
    ////////////////////////////////////////////
    begin
      result:=uTON;
      if xunidade='KG' then result:=uKG
      else if xunidade='TON' then result:=uTON
      else if xunidade='UN.' then result:=uUnidade
      else if xunidade='UN' then result:=uUnidade
      else if xunidade='LT' then result:=uLitros
      else if xunidade='M3' then result:=uM3
      else result:=uMMbtu;
    end;


///////////////////////////////////////////////////////
begin
////////////////////////////////////////////////////////

  if EdUnid_codigo.ResultFind=nil then begin
    Avisoerro('Escolher a unidade');
    exit;
  end;
  if not EdUnid_codigo.validfind then exit;
  if not EdUnid_codigo.valid then exit;
  if not EdFormaEmissao.valid then exit;
  SenhaCertificado:='#';  // 29.01.10
  if not GetSenhaCertificado then exit;

  if trim(FGeral.GetConfig1AsString('Pastaexpnfexml'))<>'' then
    acbrCte1.Configuracoes.Arquivos.PathCTe:=FGeral.GetConfig1AsString('Pastaexpnfexml');
// 26.06.10 - 1 ano falecimento Altair...
  acbrCte1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(EdUnid_codigo.text);
//  if trim(FGeral.GetConfig1AsString('NumSerieCert'))<>'' then
//    acbrCte1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetConfig1AsString('NumSerieCert');
  if trim(FGeral.GetConfig1AsString('Pastaretonfexml'))<>'' then begin
    acbrcte1.Configuracoes.Arquivos.PathEvento:=FGeral.GetConfig1AsString('Pastaretonfexml');
    acbrcte1.Configuracoes.Arquivos.PathSalvar:=FGeral.GetConfig1AsString('Pastaretonfexml');
  end;
// 01.12.09 6 hs da matina...
  if EdAmbiente.text='1' then
      acbrCte1.Configuracoes.WebServices.Ambiente:=taProducao
  else
    acbrCte1.Configuracoes.WebServices.Ambiente:=taHomologacao;
// 16.12.09
  if trim(FGeral.GetConfig1AsString('Pastaretonfexml'))<>'' then begin
    acbrCte1.Configuracoes.Arquivos.PathInu:=FGeral.GetConfig1AsString('Pastaretonfexml');
// 15.03.10
    acbrCte1.Configuracoes.Arquivos.PathSalvar:=FGeral.GetConfig1AsString('Pastaretonfexml');
  end;
  if Q=nil then exit;
  if trim(Q.SQL.Text)='' then exit;
  if trim( EdUNid_codigo.resultfind.fieldbyname('unid_cep').asstring )='' then begin
    Avisoerro('Cep no cadastro da unidade est� sem preencher');
    exit;
  end;


  IF OP='E' THEN BEGIN  // 01.03.12

    if (Global.Usuario.Codigo=900) and (global.Usuario.Nome='Andr�') then begin
      if Confirma('Checar certificado ?') then begin
        if (acbrCte1.SSL.CertDataVenc>Sistema.Hoje) and
           ( trunc(acbrCte1.SSL.CertDataVenc-Sistema.Hoje)<=30 )
          then begin
      //    Avisoerro('Certificado digital '+acbrCte1.Configuracoes.Certificados.SelecionarCertificado+' vencido em '+Datetostr(acbrCte1.Configuracoes.Certificados.DataVenc));
      //    Avisoerro('Certificado digital numero de s�rie '+acbrCte1.Configuracoes.Certificados.NumeroSerie+' vencido em '+Datetostr(acbrCte1.Configuracoes.Certificados.DataVenc));
          Avisoerro('Certificado digital '+copy(acbrCte1.SSL.CertRazaoSocial,1,40)+' VENCE em '+Datetostr(acbrCte1.SSL.CertDataVenc));
        end;
//        if acbrCte1.Configuracoes.Certificados.DataVenc<EdInicio.asdate then begin
// 10.02.14
        if acbrCte1.SSL.CertDataVenc<Sistema.hoje then begin
      //    Avisoerro('Certificado digital '+acbrCte1.Configuracoes.Certificados.SelecionarCertificado+' vencido em '+Datetostr(acbrCte1.Configuracoes.Certificados.DataVenc));
      //    Avisoerro('Certificado digital numero de s�rie '+acbrCte1.Configuracoes.Certificados.NumeroSerie+' vencido em '+Datetostr(acbrCte1.Configuracoes.Certificados.DataVenc));
          Avisoerro('Certificado digital '+copy(acbrCte1.SSL.CertRazaoSocial,1,40)+' VENCIDO em '+Datetostr(acbrCte1.SSL.CertDataVenc));
          exit;
        end;
      end;

    end else begin

      if (acbrCte1.SSL.CertDataVenc>Sistema.Hoje) and
         ( trunc(acbrCte1.SSL.CertDataVenc-Sistema.Hoje)<=30 )
        then begin
    //    Avisoerro('Certificado digital '+acbrCte1.Configuracoes.Certificados.SelecionarCertificado+' vencido em '+Datetostr(acbrCte1.Configuracoes.Certificados.DataVenc));
    //    Avisoerro('Certificado digital numero de s�rie '+acbrCte1.Configuracoes.Certificados.NumeroSerie+' vencido em '+Datetostr(acbrCte1.Configuracoes.Certificados.DataVenc));
        Avisoerro('Certificado digital '+copy(acbrCte1.SSL.CertRazaoSocial,1,40)+' VENCE em '+Datetostr(acbrCte1.SSL.CertDataVenc));
      end;
//      if acbrCte1.Configuracoes.Certificados.DataVenc<EdInicio.asdate then begin
// 10.02.14
      if acbrCte1.SSL.CertDataVenc<Sistema.hoje then begin
    //    Avisoerro('Certificado digital '+acbrCte1.Configuracoes.Certificados.SelecionarCertificado+' vencido em '+Datetostr(acbrCte1.Configuracoes.Certificados.DataVenc));
    //    Avisoerro('Certificado digital numero de s�rie '+acbrCte1.Configuracoes.Certificados.NumeroSerie+' vencido em '+Datetostr(acbrCte1.Configuracoes.Certificados.DataVenc));
        Avisoerro('Certificado digital '+copy(acbrCte1.SSL.CertRazaoSocial,1,40)+' VENCIDO em '+Datetostr(acbrCte1.SSL.CertDataVenc));
        exit;
      end;
    end;
  END;

//////////////////

//  if (xnumeronota=0) and (xsituacaonotas='') then
//    if not confirma('Confirma exporta��o do arquivo XML ?') then exit;

//  AssignFile(Arquivo, EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.SAC' );
  caracteresespeciais:='/-.;';
//  versaolayout:='1.11';  // s� serve pra geracao em TXT pro programa da SEFA/SP
// 23.03.11
  versaolayout:='2.00';  // s� serve pra geracao em TXT pro programa da SEFA/SP
  Sistema.beginprocess('Gerando arquivos XML - 1 ');
  Transacoes:='';nnotas:=0;
  Q.first;
  while not Q.eof do begin
    Transacoes:=Transacoes+Q.fieldbyname('moes_transacao').asstring+';';
    inc(nnotas);
    Q.Next;
  end;
  Q.first;

  Sistema.beginprocess('Gerando arquivos XML - 2 ');

  codmuniemitente:=FCidades.GetCodigoIBGE(EdUNid_codigo.resultfind.fieldbyname('unid_cida_codigo').asinteger);
  if trim(codmuniemitente)='' then begin
    Avisoerro('Cidade codigo '+EdUNid_codigo.resultfind.fieldbyname('unid_cida_codigo').asstring+' sem codigo do IBGE');
    Sistema.endprocess('');
    closefile(Arquivo);
    exit;
  end;
  codigopais:=1058;
  nomepais:='BRASIL';
  ListaProdutosCst:=TStringList.create;
//  NotasE:=acbrCte1.Create(self);

  if OP='E' then
    Numlote:=FGEral.GetContador('LOTECTE'+EdUnid_codigo.text,false);

  acbrCte1.Conhecimentos.Clear;

// 23.04.10 - emitente em outro estado que nao seja PR
  if trim(EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString)<>'' then
    acbrCte1.Configuracoes.WebServices.UF:=EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString
  else
    acbrCte1.Configuracoes.WebServices.UF:='PR';
//////////////////////
// 16.01.12
  TiposNumeracaoSaida:=Global.CodEntradaImobilizado+';'+Global.CodCompraConsignado+';'+
                       Global.CodDevolucaodeRemessa+';'+Global.CodCompraProdutor+';'+
                       FGeral.GetConfig1AsString('TIPOSENUMSAIDA');
// 01.02.12 - pastas por mes ano da emissao
  if not Q.eof then begin
    if trim(FGeral.GetConfig1AsString('Pastaexpnfexml'))<>'' then
      acbrCte1.Configuracoes.Arquivos.PathCTe:=FGeral.GetConfig1AsString('Pastaexpnfexml')+'\'+
                                               strzero(Datetoano(Q.fieldbyname('moes_dataemissao').AsDateTime,true),4)+
                                               strzero(Datetomes(Q.fieldbyname('moes_dataemissao').AsDateTime),2)
    else
      acbrCte1.Configuracoes.Arquivos.PathCTe:=acbrCte1.Configuracoes.Arquivos.PathCTe+'\'+
                                               strzero(Datetoano(Q.fieldbyname('moes_dataemissao').AsDateTime,true),4)+
                                               strzero(Datetomes(Q.fieldbyname('moes_dataemissao').AsDateTime),2);
    if not DirectoryExists( acbrCte1.Configuracoes.Arquivos.PathCTe ) then
      ForceDirectories( acbrCte1.Configuracoes.Arquivos.PathCTe );
  end;
/////
  while not Q.eof do begin

/////////////////////////////////////////////////////////////
//    acbrCte1.Conhecimentos.Add.Cte.Ide.Create(acbrCte1.Conhecimentos.Add.Cte);
//////////////////////////////////////////////////////////////////
    Sistema.beginprocess('Gerando arquivos XML - 3 ');

    with  acbrCte1.Conhecimentos.Add.Cte do
    begin

      if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin
        datam:=Q.fieldbyname('moes_datamvto').asdatetime;
        tipodoc:='0';
      end else begin
        datam:=Q.fieldbyname('moes_dataemissao').asdatetime;
  // 27.11.09
        campo:=Sistema.GetDicionario('movesto','moes_datasaida');
        if Campo.Tipo<>'' then begin
            if Q.fieldbyname('moes_datasaida').asdatetime>Q.fieldbyname('moes_dataemissao').asdatetime then
              datam:=Q.fieldbyname('moes_datasaida').asdatetime;
        end else begin
    // 20.08.09
           if Q.fieldbyname('moes_datamvto').asdatetime>Q.fieldbyname('moes_dataemissao').asdatetime then
             datam:=Q.fieldbyname('moes_datamvto').asdatetime;
        end;
        tipodoc:='1';
      end;

      QItens:=sqltoquery('select move_qtde,move_venda from movestoque inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                     ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
// 05.07.10
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' left join cores on (core_codigo=move_core_codigo)'+
//
                     ' where move_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                     ' and move_tipomov='+stringtosql(Q.fieldbyname('moes_tipomov').asstring)+
                     ' and move_unid_codigo='+stringtosql(Q.fieldbyname('moes_unid_codigo').asstring)+
                     ' and '+FGeral.GetIN('move_status','N','C') );
      totalitens:=0;
      while not QItens.eof do begin
        totalitens:=totalitens+FGEral.Arredonda(QItens.fieldbyname('move_qtde').ascurrency*QItens.fieldbyname('move_venda').ascurrency,2);
        Qitens.next;
      end;
      FGeral.FechaQuery(QItens);
      if Q.fieldbyname('moes_perdesco').ascurrency>0 then
//        vlrdesco:=FGeral.Arredonda(totalitem*(Q.fieldbyname('moes_perdesco').ascurrency/100),2)
// 18.05.11 - 29.05.12 - senao fica desconto negativo
        vlrdesco:= totalitens - (Q.fieldbyname('moes_vlrtotal').AsCurrency-Q.fieldbyname('moes_valoripi').AsCurrency-Q.fieldbyname('moes_frete').AsCurrency-Q.fieldbyname('moes_outrasdesp').ascurrency)
      else
        vlrdesco:=0;
// 29.08.11 - Janina - Acrescimo financeiro na nota
      if Q.fieldbyname('moes_peracres').ascurrency>0 then
        Despacessorias:=Q.fieldbyname('moes_vlrtotal').AsCurrency-totalitens+vlrdesco-Q.fieldbyname('moes_valoripi').AsCurrency
      else
        Despacessorias:=0;
// 11.11.2013 - Metalforte - Devolucao Tributada
      Despacessorias:=despacessorias+Q.fieldbyname('moes_outrasdesp').ascurrency;

// Novicarnes - dados adicionais do fisco e do contribuinte
// 20.12.11 - colocado tipo DN - dev. de compra de produtor
      dadosadicionais:='';
      if pos(Q.fieldbyname('moes_tipomov').asstring,global.CodCompraProdutor+';'+Global.CodDevolucaoCompraProdutor)>0 then begin
        dadosadicionais:='INSS : '+floattostr(Q.fieldbyname('moes_funrural').ascurrency);
        dadosadicionais:=dadosadicionais+' Cota Capital : '+floattostr(Q.fieldbyname('moes_cotacapital').ascurrency);
        dadosadicionais:=dadosadicionais+' NF Produtor : '+inttostr(Q.fieldbyname('moes_notapro').asinteger);
        if Q.fieldbyname('moes_notapro2').asinteger>0 then
          dadosadicionais:=dadosadicionais+' '+inttostr(Q.fieldbyname('moes_notapro2').asinteger) ;
      end;
// 01.07.13 - Metalforte
      if (Global.topicos[1364]) and ( pos(copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1),'5;6;7')>0 )
         then dadosadicionais:=dadosadicionais+'Vendedor:'+Q.fieldbyname('moes_repr_codigo').asstring+
                        ' - '+FRepresentantes.GetDescricao(Q.fieldbyname('moes_repr_codigo').asinteger);
///////////////////////////////////////////////////////////
{
// 18.05.11 - Fama - Parte/total a vista
      QPend:=sqltoquery('select * from movfin where movf_transacao='+stringtosql(Q.fieldbyname('moes_Transacao').AsString)+
                        ' and movf_status<>''C''');
      if not QPend.eof then begin
        with cobr.Dup.Add do
        begin
            nDup:=QPend.fieldbyname('movf_numerodcto').AsString+'-1' ;
            dVenc:=QPend.fieldbyname('movf_datamvto').AsDatetime ;
            vDup:=QPend.fieldbyname('movf_valorger').AsCurrency ;
        end;
      end;
      FGeral.FechaQuery(QPend);
      ///////////////////////////////
}

//////////////////////////////////////////////////
{
// 12.08.13 - ajustado para nao imprimir os vencimentos ref. comiss�o a pagar gerada na mesma transacao
      QPend:=sqltoquery('select pend_datavcto,pend_numerodcto,pend_valor,pend_parcela from pendencias where pend_transacao='+stringtosql(Q.fieldbyname('moes_transacao').Asstring)+
                        ' and pend_tipomov='+Stringtosql(Q.fieldbyname('moes_tipomov').Asstring)+
                        ' and pend_status<>''C'' order by pend_datavcto');

// 25.03.10
      while not QPend.eof do begin
        with cobr.Dup.Add do
        begin
            nDup:=QPend.fieldbyname('pend_numerodcto').AsString+'-'+inttostr(QPend.fieldbyname('pend_parcela').AsInteger) ;
            dVenc:=QPend.fieldbyname('pend_datavcto').AsDatetime ;
            vDup:=QPend.fieldbyname('pend_valor').AsCurrency ;
        end;
        QPend.Next;
      end;
      }
///////////////////
      {
      if not Qpend.Eof then begin
        if trim(dadosadicionais)<>'' then
          dadosadicionais:=dadosadicionais+' - Vencimento(s)'
        else
          dadosadicionais:=dadosadicionais+'Vencimento(s)';
      end;
      while not QPend.eof do begin
        dadosadicionais:=dadosadicionais+' '+FGeral.FormataData(QPend.fieldbyname('pend_datavcto').AsDatetime) ;
        QPend.Next;

      end;
      }
///////////////////
// 01.07.10 - Clessi - notas de exportacao
      if copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1)='7' then begin
        dadosadicionais:=dadosadicionais+' Porto Embarque:'+(Q.fieldbyname('moes_embarque').asstring) ;
        dadosadicionais:=dadosadicionais+' Porto Destino:'+(Q.fieldbyname('moes_destino').asstring) ;
        dadosadicionais:=dadosadicionais+' Numero Container:'+(Q.fieldbyname('moes_container').asstring) ;
      end;
// 01.03.2013 - nome fantasia - Bavi
      if ( Global.Topicos[1361] ) and (Q.fieldbyname('moes_tipocad').asstring='C') then
        dadosadicionais:=dadosadicionais+' Nome Fantasia '+(Q.fieldbyname('clie_nome').asstring) ;

      if trim(Q.fieldbyname('moes_mensagem').asstring)<>'' then begin
        dadosadicionais:='';
        if trim(dadosadicionais)<>'' then
          dadosadicionais:=dadosadicionais+' - '+Q.fieldbyname('moes_mensagem').asstring
        else
          dadosadicionais:=dadosadicionais+Q.fieldbyname('moes_mensagem').asstring;
      end;
// 31.01.17
      if trim(dadosadicionais)<>'' then
        with compl.ObsCont.Add do begin
          xCampo:='dados adicionais';
          xTexto:=dadosadicionais;
        end;

      FGeral.FechaQuery(QPend);

      vPrest.vRec   :=Q.fieldbyname('moes_vlrtotal').AsCurrency;
      vPrest.vTPrest:=Q.fieldbyname('moes_vlrtotal').AsCurrency;


//      retTrib.vRetPrev:=Q.fieldbyname('moes_funrural').asfloat;
//       Total.ICMSTot.vDesc:=vlrdesco;
//      Imp.vTotTrib         :=  Q.fieldbyname('moes_baseicms').AsCurrency;
// 31.01.17
      if ( pos(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring,'S;2') > 0 ) then begin
        Imp.ICMS.ICMSSN.indSN:=1;
        Imp.ICMS.SituTrib:=cstICMSSN;
      end else begin
//        Imp.ICMS.ICMS00.vICMS       :=  Q.fieldbyname('moes_valoricms').AsCurrency;
//        Imp.ICMS.SituTrib:=cst00;
// 08.08.19 - Escritorio Asterio - sempre isento de icms
        Imp.ICMS.SituTrib:=cst40;
        IMp.ICMS.ICMS45.CST:=cst40;
      end;
      Imp.vTotTrib                :=  Q.fieldbyname('moes_vlrtotal').AsCurrency;



//        Total.ICMSTot.vOutro:=despacessorias;
//      infCTFe.ID := Q.fieldbyname('moes_transacao').Asstring+Q.fieldbyname('moes_numerodoc').Asstring;

//    Ide.cUF    :=GetCodigoUfIbge( EdUnid_codigo.ResultFind.fieldbyname('Unid_uf').AsString );
//      Ide.toma03.Toma:=tmDestinatario;

      Ide.toma03.Toma:=tmRemetente;
// 19.08.19
      if FGeral.GetConfig1AsString('cteremdesti') = '2' then

         Ide.toma03.Toma:=tmDestinatario;

{
// 18.07.19
      if Q.fieldbyname('moes_clie_codigo').AsInteger<>Q.fieldbyname('moes_tipo_codigo').AsInteger then
         Ide.toma03.Toma:=tmDestinatario;
}

      Ide.natOp  := copy(Ups(FNatureza.GetDescricao(Q.fieldbyname('moes_natf_codigo').asstring)),1,50);
      Ide.cCT             := strtointdef(Q.fieldbyname('moes_transacao').Asstring,0);
      Ide.nCT             := Q.fieldbyname('moes_numerodoc').AsInteger;
      Ide.cUF             := strtoint(copy(codmuniemitente,1,2));
//      Ide.cMunFG          := strtoint(codmuniemitente);
      Ide.modelo             := 57;
      Ide.serie              := GetSerie(Q.fieldbyname('moes_serie').asstring,EdFormaEmissao.text);
      Ide.dhEmi              := Q.fieldbyname('moes_dataemissao').asdatetime;
//  TpcnTipoImpressao = (tiRetrato, tiPaisagem);
      Ide.tpImp              := tiRetrato;
// 31.05.14
      codmuniemitente:=FCidades.GetCodigoIBGE(EdUNid_codigo.resultfind.fieldbyname('unid_cida_codigo').asinteger);
      codmuni:=strspace(codmuniemitente,7);

      Ide.cMunEnv            := strtoint( codmuni );
      Ide.xMunEnv            := Ups(FCidades.GetNome( EdUNid_codigo.resultfind.fieldbyname('unid_cida_codigo').asinteger));
      Ide.UFEnv              := FCidades.GetUF(EdUNid_codigo.resultfind.fieldbyname('unid_cida_codigo').asinteger);

      InfCTe.ID              := 'CTe'+Q.fieldbyname('moes_chavenfe').asstring;
//      InfCTe.Versao          := '2.00';
//////////////////////////////
       {
      if ( Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1Asinteger('ConfNfComple') )
         and (FGeral.GetConfig1Asinteger('ConfNfComple')>0) then begin
        finNFe             := fnComplementar;
        with Ide.NFref.Add do begin
          refNFe:=Q.fieldbyname('moes_chavenferef').asstring;
        end;
// 06.08.12 - NFe de estorno
      end else if ( Q.fieldbyname('moes_tipomov').asstring=Global.CodEstornoNFeSai ) then begin
        Ide.finNFe             := fnAjuste;
        Ide.natOp  := '999 - Estorno de NF-e nao cancelada no prazo legal';
        with Ide.NFref.Add do begin
          refNFe:=Q.fieldbyname('moes_chavenferef').asstring;
        end;
      end;
      }
//////////////////////////////
      if Q.FieldByName('moes_vispra').asstring='V' then
        Ide.forPag            := fpPago
      else
        Ide.forPag            := fpAPagar;

      Ide.tpCTe      := tcNormal;
// 05.11.12 - contingencia com dpecv
      if EdFormaemissao.text='4' then begin
        Ide.dhCont:=Sistema.Hoje+Time();
        Ide.xjust:='Sefa '+Global.UFUnidade+' com problemas t�cnicos';
      end;
//
//      Ide.verProc   := versaolayout;
      if Global.Topicos[1028] then
        Ide.verProc   := '2.2.2'
      else
        Ide.verProc   := Global.VersaoSistema;

      if EdAmbiente.text='1' then
        Ide.tpAmb     := taProducao
      else
        Ide.tpAmb     := taHomologacao;
//  TpcnTipoEmissao = (teNormal, teContingencia, teSCAN, teDPEC, teFSDA);
      if EdFormaEmissao.text='1' then
        Ide.tpEmis    := teNormal
      else if EdFormaEmissao.text='2' then
        Ide.tpEmis    := teContingencia
      else if EdFormaEmissao.text='3' then
        Ide.tpEmis    := teSCAN
      else if EdFormaEmissao.text='4' then
        Ide.tpEmis    := teDPEC
      else if EdFormaEmissao.text='5' then
        Ide.tpEmis    := teFSDA;
//  TpcnProcessoEmissao = (peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco);
     Ide.procEmi:=peAplicativoContribuinte;
     Ide.modal  :=mdRodoviario;
     Ide.CFOP   := strtoint(Q.fieldbyname('moes_natf_codigo').AsString);


// 23.03.11 - Clessi - nota de exporta��o - xml 2.0
//      if copy(Ide.natOp,1,1)='7' then begin
//  07.04.11 ide.natop tem a descricao da natureza e nao o cfop jamantossauro...
////////////////////////////////
{
      if copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1)='7' then begin
        campo:=Sistema.GetDicionario('movesto','moes_estadoex');
        if campo.Tipo<>'' then
          exporta.UFembarq:=Q.fieldbyname('moes_estadoex').asstring
        else
          exporta.UFembarq:=Global.UFUnidade;
        exporta.xLocEmbarq:=copy(Q.fieldbyname('moes_embarque').asstring,1,60)
      end else begin
        exporta.UFembarq:='';
        exporta.xLocEmbarq:='';
      end;
      }
///////////////////
// 12.01.12 - Asatec
      temdi:=false;
      if copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1)='3' then begin
        campo:=Sistema.GetDicionario('movesto','moes_numerodi');
        if campo.Tipo<>'' then temdi:=true;
      end;

      QDesti:=Sqltoquery('select * from transportadores where tran_codigo='+stringtosql(Q.fieldbyname('moes_tran_codigo').AsString));

      rntc:='';
      numero:=Fsintegra.GetNumerodoEndereco(QDesti.fieldbyname('tran_endereco').asstring,0,'N');
      if length(trim(QDesti.fieldbyname('tran_cnpjcpf').asstring))<14 then begin
        cnpjtran:='';
        cpftran:=QDesti.fieldbyname('tran_cnpjcpf').asstring;
      end else begin
        cpftran:='';
        cnpjtran:=QDesti.fieldbyname('tran_cnpjcpf').asstring;
      end;

//  TpcnModalidadeFrete = (mfContaEmitente, mfContaDestinatario);
{
      if Q.fieldbyname('moes_freteciffob').asstring='1' then
        Transp.modFrete  := mfContaEmitente
      else
        Transp.modFrete  :=  mfContaDestinatario;
}
////////////////////////////////////////////////////////
{
// 01.03.2013
      if QDesti.fieldbyname('tran_cnpjcpf').asstring<>'' then begin
        Transp.Transporta.CNPJCPF := QDesti.fieldbyname('tran_cnpjcpf').asstring;
        Transp.Transporta.xNome   := UPs(QDesti.fieldbyname('tran_razaosocial').asstring);
        Transp.Transporta.IE      := GetInsEst(QDesti.fieldbyname('tran_inscricaoestadual').asstring,'T');
        Transp.Transporta.xEnder  := Ups(QDesti.fieldbyname('tran_endereco').asstring);
        Transp.Transporta.xMun    := Ups(FCidades.GetNome(QDesti.fieldbyname('tran_cida_codigo').asinteger));
        Transp.Transporta.UF      := FCidades.GetUF( QDesti.fieldbyname('tran_cida_codigo').asinteger);

        Transp.veicTransp.placa   :=fGeral.TiraBarra(QDesti.fieldbyname('tran_placa').asstring,'-');
        Transp.veicTransp.UF      :=QDesti.fieldbyname('tran_ufplaca').asstring;
  // 05.11.12
        if Q.FieldByName('moes_qtdevolume').asINTEGER > 0 then begin
          Transp.Vol.Add.qVol       :=Q.FieldByName('moes_qtdevolume').asINTEGER;
  // se usar add cria tag volume para cada add..entao cria uma e coloca 'as filhas'
          Transp.Vol.Items[0].esp   :=Q.FieldByName('moes_especievolume').AsString;
          Transp.Vol.Items[0].marca      :='';
          Transp.Vol.Items[0].pesoL      :=Q.FieldByName('moes_pesoliq').ascurrency;
          Transp.Vol.Items[0].pesoB      :=Q.FieldByName('moes_pesobru').ascurrency;
        end;
      end;
      }
///////////////////////////////
//      Emit.EnderEmit.xPais := nomepais;
//      Emit.EnderEmit.cPais := codigopais;
//       Emit.EnderEmit.nro   := 'SEM NUMERO';

      Dest.EnderDest.xPais := nomepais;
      Dest.EnderDest.cPais := codigopais;
//       Dest.EnderDest.nro   := 'SEM NUMERO';


      numero:=Fsintegra.GetNumerodoEndereco(EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring,0,'N');

//      codmuniemitente:=FCidades.GetCodigoIBGE(EdUNid_codigo.resultfind.fieldbyname('unid_cida_codigo').asinteger);
//      codmuni:=strspace(codmuniemitente,7);
      Emit.xNome     := EdUnid_codigo.resultfind.fieldbyname('Unid_razaosocial').asstring;
      Emit.xFant     := EdUnid_codigo.resultfind.fieldbyname('Unid_nome').asstring;
      Emit.CNPJ      := EdUnid_codigo.resultfind.fieldbyname('Unid_cnpj').asstring;
      Emit.IE        := EdUnid_codigo.resultfind.fieldbyname('Unid_inscricaoestadual').asstring;

      Emit.EnderEmit.fone       :=GetTelefone(EdUNid_codigo.resultfind.fieldbyname('unid_fone').asstring);
      Emit.EnderEmit.CEP        :=strtoint(EdUNid_codigo.resultfind.fieldbyname('unid_cep').asstring);
// 01.07.10 - para nao ficar sem logradouro caso nao tiver virgula...
      if pos(',',EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring)>0 then
          Emit.EnderEmit.xLgr      := Ups( copy(EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring,1,pos(',',EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring)) )
      else
         Emit.EnderEmit.xLgr      := Ups( EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring );
//      Emit.EnderEmit.xLgr       :=Ups(EdUNid_codigo.resultfind.fieldbyname('unid_endereco').asstring);

      Emit.EnderEmit.nro        :=numero;
//      Emit.EnderEmit.xCpl       := '';
      Emit.EnderEmit.xBairro    := Ups(EdUNid_codigo.resultfind.fieldbyname('unid_bairro').asstring);
      Emit.EnderEmit.cMun   := strtoint(codmuniemitente);
      Emit.EnderEmit.xMun := Ups(EdUNid_codigo.resultfind.fieldbyname('unid_municipio').asstring);
      Emit.EnderEmit.UF          := EdUNid_codigo.resultfind.fieldbyname('unid_uf').asstring;

// 15.02.10
//      Emit.IM:=EdUNid_codigo.resultfind.fieldbyname('Unid_inscricaomunicipal').asstring;
// ver se precisa do cnae quando a nota tem servi�os junto
// checar pois este campo ainda nao esta 'disponivel' no cadastro de unidades com edit, etc
//      Emit.CNAE:=EdUNid_codigo.resultfind.fieldbyname('unid_Cnaefiscal').asstring;
//      if ( Total.ISSQNtot.vServ>0 ) and (trim(Emit.CNAE)='') then begin
//        Avisoerro('Obrigat�rio informar o CNAE na Unidade em notas com servi�os');
//        FechaArquivosXML;
//        exit;
//     end;
//     Emit.CRT:=GetCRT(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring);
// 09.03.14 - Zilmar I.E. ref. Subst. Trib.
//     Emit.IEST:=EdUNid_codigo.resultfind.fieldbyname('Unid_inscricaomunicipal').AsString;

// Dados do Remetente
/////////////////////////////////////
        QRem:=Sqltoquery('select * from clientes where clie_codigo='+Q.fieldbyname('moes_clie_codigo').AsString);
        numero:=Fsintegra.GetNumerodoEndereco(Qrem.fieldbyname('clie_endres').asstring,Q.fieldbyname('moes_tipo_codigo').AsInteger,'N');
        codmuni:=FCidades.GetCodigoIBGE(QRem.fieldbyname('clie_cida_codigo_res').asinteger);
        if trim(codmuni)='' then begin
           Avisoerro('Cidade codigo '+QRem.fieldbyname('clie_cida_codigo_res').asstring+' sem codigo do IBGE');
           FechaArquivosxml;
           exit;
        end;
        if trim(QRem.fieldbyname('clie_bairrores').asstring)='' then begin
           Avisoerro('Cliente codigo '+QRem.fieldbyname('clie_codigo').asstring+' sem bairro');
           FechaArquivosxml;
           exit;
        end;
        if trim(QRem.fieldbyname('clie_cepres').asstring)='' then begin
           Avisoerro('Cliente codigo '+QRem.fieldbyname('clie_codigo').asstring+' sem Cep');
           FechaArquivosxml;
           exit;
        end;
        if length(trim(QRem.fieldbyname('clie_cnpjcpf').asstring))<14 then
          Rem.CNPJCPF                   := GetCnpjCpf(QRem.fieldbyname('clie_cnpjcpf').asstring,11)
        else
          Rem.CNPJCPF                   := GetCnpjCpf(QRem.fieldbyname('clie_cnpjcpf').asstring,14);
        Rem.IE         := QRem.fieldbyname('Clie_rgie').asstring;
        Rem.xNome      := QRem.fieldbyname('Clie_nome').asstring;
        Rem.EnderReme.CEP           := strtoint(QRem.fieldbyname('clie_cepres').asstring);
        if pos(',',QRem.fieldbyname('clie_endres').asstring)>0 then
          Rem.EnderReme.xLgr      := Ups( copy(QRem.fieldbyname('clie_endres').asstring,1,pos(',',QRem.fieldbyname('clie_endres').asstring)) )
        else
          Rem.EnderReme.xLgr      := Ups( Qrem.fieldbyname('clie_endres').asstring );
        Rem.EnderReme.xLgr   := TiraString(numero,Rem.EnderReme.xLgr);
        Rem.EnderReme.Nro           := numero;
        Rem.EnderReme.xCpl  := '';
        Rem.EnderReme.xBairro     := Ups(QRem.fieldbyname('clie_bairrores').asstring);
        Rem.EnderReme.cMun  := strtoint(codmuni);
        Rem.EnderReme.xMun  := Ups(FCidades.GetNome(QRem.fieldbyname('clie_cida_codigo_res').asinteger));
        Rem.EnderReme.UF    := QRem.fieldbyname('clie_uf').asstring;
        if QRem.FieldByName('Clie_tipo').AsString<>'F' then
          Rem.IE                    := QRem.fieldbyname('clie_rgie').asstring;
        Rem.xNome                := Ups(QRem.fieldbyname('clie_razaosocial').asstring);

        Ide.cMunIni            := strtoint(codmuni);
        Ide.xMunIni            := Ups(FCidades.GetNome(QRem.fieldbyname('clie_cida_codigo_res').asinteger));
        Ide.UFIni              := QRem.fieldbyname('clie_uf').asstring;


///////////////////////////////////////////////////////////////////////
// Dados do Destinatario
///////////////////////////
      Dest.EnderDest.cPais   := codigopais;
      Dest.EnderDest.xPais   := nomepais;
      ConsumidorFinal:='N';
      if Q.fieldbyname('moes_tipocad').AsString='F' then begin

        QDesti:=Sqltoquery('select * from fornecedores where forn_codigo='+Q.fieldbyname('moes_tipo_codigo').AsString);
        numero:=Fsintegra.GetNumerodoEndereco(QDesti.fieldbyname('forn_endereco').asstring,Q.fieldbyname('moes_tipo_codigo').AsInteger,'N');
        codmuni:=FCidades.GetCodigoIBGE(QDesti.fieldbyname('forn_cida_codigo').asinteger);
        if trim(codmuni)='' then begin
           Avisoerro('Cidade codigo '+QDesti.fieldbyname('forn_cida_codigo').asstring+' sem codigo do IBGE');
           FechaArquivosXML;
           exit;
        end;
// 29.03.10
        if trim(QDesti.fieldbyname('forn_cep').asstring)='' then begin
           Avisoerro('Fornecedor codigo '+QDesti.fieldbyname('forn_codigo').asstring+' sem Cep');
           FechaArquivosxml;
           exit;
        end;

        if length(trim(QDesti.fieldbyname('forn_cnpjcpf').asstring))<14 then
  //        linha:='E03'+sep+GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,11)+sep
          Dest.CNPJCPF                   := GetCnpjCpf(QDesti.fieldbyname('forn_cnpjcpf').asstring,11)
        else
    //      linha:='E02'+sep+GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,14)+sep;
          Dest.CNPJCPF                   := GetCnpjCpf(QDesti.fieldbyname('forn_cnpjcpf').asstring,14);

        Dest.EnderDest.CEP           := strtoint(QDesti.fieldbyname('forn_cep').asstring);
// 01.07.10 - para nao ficar sem logradouro caso nao tiver virgula...
        if pos(',',QDesti.fieldbyname('forn_endereco').asstring)>0 then
          Dest.EnderDest.xLgr      := Ups( copy(QDesti.fieldbyname('forn_endereco').asstring,1,pos(',',QDesti.fieldbyname('forn_endereco').asstring)) )
        else
          Dest.EnderDest.xLgr      := Ups( QDesti.fieldbyname('forn_endereco').asstring );

//        Dest.EnderDest.xLgr      := Ups(QDesti.fieldbyname('forn_endereco').asstring);

        Dest.EnderDest.nro           := numero;
        Dest.EnderDest.xCpl  := '';
        Dest.EnderDest.xBairro     := Ups(QDesti.fieldbyname('forn_bairro').asstring);
        Dest.EnderDest.cMun  := strtoint(codmuni);
        Dest.EnderDest.xMun := Ups(FCidades.GetNome(QDesti.fieldbyname('forn_cida_codigo').asinteger));
        Dest.EnderDest.UF               := QDesti.fieldbyname('forn_uf').asstring;
//        Dest.EnderDest.fone            := GetTelefone(QDesti.fieldbyname('forn_fone').asstring);
        Dest.IE                    := GetInsEst(QDesti.fieldbyname('forn_inscricaoestadual').asstring);
        Dest.xNome                := Ups(QDesti.fieldbyname('forn_razaosocial').asstring);

      end else if Q.fieldbyname('moes_tipocad').AsString='U' then begin

        QDesti:=Sqltoquery('select * from unidades where unid_codigo='+stringtosql(strzero(Q.fieldbyname('moes_tipo_codigo').AsInteger,3)));
        numero:=Fsintegra.GetNumerodoEndereco(QDesti.fieldbyname('unid_endereco').asstring,Q.fieldbyname('moes_tipo_codigo').AsInteger,'N');
        codmuni:=FCidades.GetCodigoIBGE(QDesti.fieldbyname('unid_cida_codigo').asinteger);
////////////
        if length(trim(QDesti.fieldbyname('unid_cnpj').asstring))<14 then
  //        linha:='E03'+sep+GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,11)+sep
          Dest.CNPJCPF                   := GetCnpjCpf(QDesti.fieldbyname('unid_cnpj').asstring,11)
        else
    //      linha:='E02'+sep+GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,14)+sep;
          Dest.CNPJCPF                   := GetCnpjCpf(QDesti.fieldbyname('unid_cnpj').asstring,14);
        Dest.EnderDest.CEP           := strtoint(QDesti.fieldbyname('unid_cep').asstring);

// 15.04.10 - 'retirada do numero para 'nao dobrar'
// 23.04.10 - para nao ficar sem logradouro caso nao tiver virgula...
        if pos(',',QDesti.fieldbyname('unid_endereco').asstring)>0 then
          Dest.EnderDest.xLgr      := Ups( copy(QDesti.fieldbyname('unid_endereco').asstring,1,pos(',',QDesti.fieldbyname('unid_endereco').asstring)) )
        else
          Dest.EnderDest.xLgr      := Ups( QDesti.fieldbyname('unid_endereco').asstring );
//        Dest.EnderDest.xLgr      := Ups(QDesti.fieldbyname('unid_endereco').asstring);

        Dest.EnderDest.nro           := numero;
        Dest.EnderDest.xCpl  := '';
        Dest.EnderDest.xBairro     := Ups(QDesti.fieldbyname('unid_bairro').asstring);
        Dest.EnderDest.cMun  := strtoint(codmuni);
        Dest.EnderDest.xMun:= Ups(FCidades.GetNome(QDesti.fieldbyname('unid_cida_codigo').asinteger));
        Dest.EnderDest.UF               := QDesti.fieldbyname('unid_uf').asstring;
//        Dest.EnderDest.fone            := GetTelefone(QDesti.fieldbyname('unid_fone').asstring);
        Dest.IE                    := GetInsEst(QDesti.fieldbyname('unid_inscricaoestadual').asstring);
        Dest.xNome                := Ups(QDesti.fieldbyname('unid_razaosocial').asstring);
////////////
      end else begin

        QDesti:=Sqltoquery('select * from clientes where clie_codigo='+Q.fieldbyname('moes_tipo_codigo').AsString);
        numero:=Fsintegra.GetNumerodoEndereco(QDesti.fieldbyname('clie_endres').asstring,Q.fieldbyname('moes_tipo_codigo').AsInteger,'N');
        codmuni:=FCidades.GetCodigoIBGE(QDesti.fieldbyname('clie_cida_codigo_res').asinteger);
        if trim(codmuni)='' then begin
           Avisoerro('Cidade codigo '+QDesti.fieldbyname('clie_cida_codigo_res').asstring+' sem codigo do IBGE');
           FechaArquivosxml;
           exit;
        end;
        if trim(QDesti.fieldbyname('clie_bairrores').asstring)='' then begin
           Avisoerro('Cliente codigo '+QDesti.fieldbyname('clie_codigo').asstring+' sem bairro');
           FechaArquivosxml;
           exit;
        end;
// 29.03.10
        if trim(QDesti.fieldbyname('clie_cepres').asstring)='' then begin
           Avisoerro('Cliente codigo '+QDesti.fieldbyname('clie_codigo').asstring+' sem Cep');
           FechaArquivosxml;
           exit;
        end;
        ConsumidorFinal:=QDesti.fieldbyname('Clie_consfinal').Asstring;
//        linha:='E05'+sep+Ups( FGeral.TiraBarra(QDesti.fieldbyname('clie_endres').asstring,caracteresespeciais) )+sep+Numero+sep+
//              sep+  // complemento
//              Ups( FGeral.TiraBarra(QDesti.fieldbyname('clie_bairrores').asstring,caracteresespeciais) )+sep+
//              codmuni+sep+Ups( FGeral.TiraBarra(FCidades.GetNome(QDesti.fieldbyname('clie_cida_codigo_res').asinteger),caracteresespeciais))+sep+
//              QDesti.fieldbyname('clie_uf').asstring+sep+
//              QDesti.fieldbyname('clie_cepres').asstring+sep+
//              codigopais+sep+nomepais+sep+
//              GetTelefone(QDesti.fieldbyname('clie_foneres').asstring)+sep;
////////////

        if length(trim(QDesti.fieldbyname('clie_cnpjcpf').asstring))<14 then
  //        linha:='E03'+sep+GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,11)+sep
          Dest.CNPJCPF                   := GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,11)
        else
    //      linha:='E02'+sep+GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,14)+sep;
          Dest.CNPJCPF                   := GetCnpjCpf(QDesti.fieldbyname('clie_cnpjcpf').asstring,14);

        Dest.EnderDest.CEP           := strtoint(QDesti.fieldbyname('clie_cepres').asstring);
//        Dest.EnderDest.xLgr      := Ups(QDesti.fieldbyname('clie_endres').asstring);
// 15.04.10 - 'retirada do numero para 'nao dobrar'
// 23.04.10 - para nao ficar sem logradouro caso nao tiver virgula...
        if pos(',',QDesti.fieldbyname('clie_endres').asstring)>0 then
          Dest.EnderDest.xLgr      := Ups( copy(QDesti.fieldbyname('clie_endres').asstring,1,pos(',',QDesti.fieldbyname('clie_endres').asstring)) )
        else
          Dest.EnderDest.xLgr      := Ups( QDesti.fieldbyname('clie_endres').asstring );
// 09.11.12 - nao dobrar o numero
        Dest.EnderDest.xLgr := TiraString(numero,Dest.EnderDest.xLgr);
        Dest.EnderDest.Nro           := numero;
        Dest.EnderDest.xCpl  := '';
        Dest.EnderDest.xBairro     := Ups(QDesti.fieldbyname('clie_bairrores').asstring);
        Dest.EnderDest.cMun  := strtoint(codmuni);
        Dest.EnderDest.xMun  := Ups(FCidades.GetNome(QDesti.fieldbyname('clie_cida_codigo_res').asinteger));
        Dest.EnderDest.UF               := QDesti.fieldbyname('clie_uf').asstring;
//        Dest.EnderDest.fone            := GetTelefone(QDesti.fieldbyname('clie_foneres').asstring);
// 14.06.13 - Abra
        if QDesti.FieldByName('Clie_tipo').AsString<>'F' then
          Dest.IE                    := GetInsEst(QDesti.fieldbyname('clie_rgie').asstring);
        Dest.xNome                := Ups(QDesti.fieldbyname('clie_razaosocial').asstring);
////////////
      end;

// 15.07.19 - campo para tomador do servi�o
/////////////////////////////////////////////////////////
{
     if Q.fieldbyname('moes_tipo_codigoind').AsInteger>0 then begin

        QToma:=Sqltoquery('select * from clientes where clie_codigo='+Q.fieldbyname('moes_tipo_codigoind').AsString);

        numero:=Fsintegra.GetNumerodoEndereco(QToma.fieldbyname('clie_endres').asstring,Q.fieldbyname('moes_tipo_codigo').AsInteger,'N');
        codmuni:=FCidades.GetCodigoIBGE(QToma.fieldbyname('clie_cida_codigo_res').asinteger);
        toma.CNPJCPF:=QToma.fieldbyname('clie_cnpjcpf').asstring;
        toma.xFant  :=QToma.fieldbyname('clie_nome').asstring;
        Toma.enderToma.xLgr := TiraString(numero,Toma.EnderToma.xLgr);
        Toma.enderToma.Nro           := numero;
        Toma.enderToma.xCpl  := '';
        Toma.enderToma.xBairro     := Ups(QToma.fieldbyname('clie_bairrores').asstring);
        Toma.enderToma.cMun  := strtoint(codmuni);
        Toma.enderToma.xMun  := Ups(FCidades.GetNome(QToma.fieldbyname('clie_cida_codigo_res').asinteger));
        Toma.enderToma.UF               := QToma.fieldbyname('clie_uf').asstring;
        if QToma.FieldByName('Clie_tipo').AsString<>'F' then
          Toma.IE                    := GetInsEst(QToma.fieldbyname('clie_rgie').asstring);
        Toma.xNome                := Ups(QToma.fieldbyname('clie_razaosocial').asstring);

     end;
}


        Ide.cMunFim            := strtoint(codmuni);
        Ide.xMunFim            := Ups(FCidades.GetNome(QDesti.fieldbyname('clie_cida_codigo_res').asinteger));
        Ide.UFFim              := QDesti.fieldbyname('clie_uf').asstring;

// 15.06.10 - Lam. Sao Caetano + Sefa Sc
      if (Q.fieldbyname('moes_estado').asstring)='EX' then begin
//        Dest.EnderDest.cPais:=2321;  // FCidades.GetCodigoPais(QDesti.fieldbyname('clie_cida_codigo_res').asinteger);
//        Dest.EnderDest.xPais:='DINAMARCA';  // Ups(FCidades.GetNomePais(QDesti.fieldbyname('clie_cida_codigo_res').asinteger));
// 30.10.10 - Asatec - Nota de IMporta��o - Entrada - Fornecedor
        if Q.fieldbyname('moes_tipocad').AsString='F' then begin
          Dest.EnderDest.cPais:=strtointdef(FCidades.GetCodigoPais(QDesti.fieldbyname('Forn_cida_codigo').asinteger),0);
          Dest.EnderDest.xPais:=Ups(FCidades.GetNomePais(QDesti.fieldbyname('Forn_cida_codigo').asinteger));
        end else begin
          Dest.EnderDest.cPais:=strtointdef(FCidades.GetCodigoPais(QDesti.fieldbyname('clie_cida_codigo_res').asinteger),0);
          Dest.EnderDest.xPais:=Ups(FCidades.GetNomePais(QDesti.fieldbyname('clie_cida_codigo_res').asinteger));
        end;
        if Dest.EnderDest.cPais=0 then begin
           Avisoerro('Sem codigo do pais no cadastro de cidades');
           FechaArquivosxml;
           exit;
        end;
        if trim(Dest.EnderDest.xPais)='' then begin
           Avisoerro('Sem nome do pais no cadastro de cidades');
           FechaArquivosxml;
           exit;
        end;
      end else begin
        Dest.EnderDest.cPais:=codigopais;  // FCidades.GetCodigoPais(QDesti.fieldbyname('clie_cida_codigo_res').asinteger);
        Dest.EnderDest.xPais:='BRASIL';  // Ups(FCidades.GetNomePais(QDesti.fieldbyname('clie_cida_codigo_res').asinteger));
      end;



//       acbrCte1.Conhecimentos.Add.Cte.Det.Add.Prod.

////////////////////////////////// - itens das notas

// 17.03.10 - refazendo para prever mais de um cfop e mesma cst na venda ( 5101 e 5102 )
      QConfmov:=sqltoquery('select * from confmov where comv_codigo='+inttostr(Q.fieldbyname('moes_comv_codigo').AsInteger));
      if copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1)='5' then
        cfopind:=QConfmov.fieldbyname('comv_natf_estadoipi').asstring
      else
        cfopind:=QConfmov.fieldbyname('comv_natf_foestadoipi').asstring;
// 19.01.11 - quando tem ncm busca o ipi de industria mas caso nao tiver configurado
//            deve ficar o 'normal'
      if trim(cfopind)='' then cfopind:=Q.fieldbyname('moes_natf_codigo').asstring;

      FGeral.Fechaquery(QConfmov);

      Q1:=sqltoquery('select * from movestoque inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                     ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
// 05.07.10
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' left join cores on (core_codigo=move_core_codigo)'+
//
                     ' where move_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                     ' and move_tipomov='+stringtosql(Q.fieldbyname('moes_tipomov').asstring)+
                     ' and move_unid_codigo='+stringtosql(Q.fieldbyname('moes_unid_codigo').asstring)+
                     ' and '+FGeral.GetIN('move_status','N','C') );
      seq:=1;
      totalcofins:=0;totalpis:=0;
// 28.05.12
      rateioicmsimportacao:=0;
// 31.01.17
      Valortotalimpaproximado:=0;
      totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').asFLOAT,2);
      xvTotTrib:=FExpNfetxt.CalculaImpostoAproximado(FEstoque.GetNCMipi(Q1.fieldbyname('move_esto_codigo').asstring),
                  Q1.fieldbyname('move_cst').asstring,totalitem);
      Valortotalimpaproximado:=Valortotalimpaproximado + xvTotTrib;

///////////////////////
{
      if not Q1.eof then begin
        if ( Q1.FieldByName('moes_vlrtotal').ascurrency < Q1.FieldByName('moes_baseicms').ascurrency )
          and
         ( Q1.FieldByName('moes_valoricms').ascurrency>0 )
          and
         ( copy(Q1.FieldByName('moes_natf_codigo').asstring,1,1)='3' )
        then
//          rateioicmsimportacao:=fGeral.Arredonda( Abs(Q1.FieldByName('moes_vlrtotal').ascurrency - Q1.FieldByName('moes_baseicms').ascurrency)/Q1.FieldByName('moes_valoricms').ascurrency ,3 )
//          rateioicmsimportacao:=fGeral.Arredonda( 100 *  (Abs(Q1.FieldByName('moes_vlrtotal').ascurrency - Q1.FieldByName('moes_baseicms').ascurrency)/Q1.FieldByName('moes_valoricms').ascurrency) ,2 )
//          rateioicmsimportacao:=fGeral.Arredonda( 100 *  (Abs(Q1.FieldByName('moes_vlrtotal').ascurrency - Q1.FieldByName('moes_baseicms').ascurrency)/Q1.FieldByName('moes_valoricms').ascurrency) ,3 )
//          rateioicmsimportacao:=fGeral.Arredonda( 100 *  (Abs(Q1.FieldByName('moes_vlrtotal').ascurrency - Q1.FieldByName('moes_baseicms').ascurrency)/Q1.FieldByName('moes_valoricms').ascurrency) ,4 )
//          rateioicmsimportacao:=fGeral.Arredonda( 100 *  (Abs(Q1.FieldByName('moes_vlrtotal').ascurrency - Q1.FieldByName('moes_baseicms').ascurrency)/Q1.FieldByName('moes_valoricms').ascurrency) ,6 )
          rateioicmsimportacao:= 100 *  (Abs(Q1.FieldByName('moes_vlrtotal').ascurrency - Q1.FieldByName('moes_baseicms').ascurrency)/Q1.FieldByName('moes_valoricms').ascurrency)
      end;
     // }
///////////////////////

      Sistema.beginprocess('Gerando arquivos XML - 4 ');

      vlrcarga:=0;
      Q71:=sqltoquery('select * from movesto where moes_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring)+
                      ' and moes_status='+stringtosql('M') );
      if Not Q71.Eof then begin

        while not Q71.eof do begin

          if Q71.fieldbyname('moes_chavenfe').AsString='' then begin

            with InfCteNorm.infDoc.infNF.Add do begin

              nDoc   := Q71.fieldbyname('moes_numerodoc').AsString;
              dEmi   := Q71.fieldbyname('moes_dataemissao').AsDatetime;
              Serie  := Q71.fieldbyname('moes_serie').AsString;
              modelo := moNF011AAvulsa;
              vBC    := Q71.fieldbyname('moes_vlrtotal').Ascurrency;
              vProd  := Q71.fieldbyname('moes_vlrtotal').Ascurrency;
              vNf    := Q71.fieldbyname('moes_vlrtotal').Ascurrency;
              ncfop  := strtointdef(Q71.fieldbyname('moes_natf_codigo').AsString,0);
              vlrcarga:=vlrcarga+Q71.fieldbyname('moes_vlrtotal').Ascurrency;
            end;

         end else begin

// 30.01.17 -tratar como nfe
            with InfCteNorm.infDoc.infNFe.Add do begin
              chave:=Q71.fieldbyname('moes_chavenfe').AsString;
              vlrcarga:=vlrcarga+Q71.fieldbyname('moes_vlrtotal').Ascurrency;
            end;
          end;
          Q71.Next;

        end;

      end else begin  // 09.07.19 - ct-e 'sem nfe'

            with InfCteNorm.infDoc.infOutros.Add do begin

              tpDoc     := tdOutros;
              descOutros:= ''
//              nDoc      := '45';

            end;


      end;

      with infCTeNorm.seg.Add do begin
        respSeg:=rsDestinatario;
        nApol:='1234567';
        xseg:='Nome Seguradora';
//        vcarga:=Q.fieldbyname('moes_totprod').ascurrency;
        vcarga:=vlrcarga;
      end;

      if not Q1.eof then begin
//        infCTeNorm.infCarga.proPred:=FEstoque.GetDescricao(Q1.fieldbyname('move_esto_codigo').asstring);
// 31.01.17
        infCTeNorm.infCarga.proPred:='Diversos';
        infCTeNorm.infCarga.vcarga:=Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency;
        with infCteNorm.infCarga.infQ.Add do begin
          cUnid:=GetUnidade(FEstoque.GetUnidade(Q1.fieldbyname('move_esto_codigo').asstring));
          tpMed:='KG';
//          qcarga:=Q1.fieldbyname('move_qtde').ascurrency;
          qcarga:=Q.FieldByName('moes_pesoliq').ascurrency;
        end;
        with infCteNorm.infCarga.infQ.Add do begin
          cUnid:=uUnidade;
//          tpMed:='PESO BRUTO';
          tpMed:=Q.FieldByName('moes_especievolume').asstring;
//          qcarga:=Q1.fieldbyname('move_qtde').ascurrency;
          qcarga:=Q.FieldByName('moes_qtdevolume').asINTEGER;
        end;

        infCteNorm.infCarga.vCarga:=vlrcarga;
//        infCteNorm.infCarga.xOutCat:='teste'; mais alguma inf. sobre a carga
      end;

      infCTeNorm.rodo.RNTRC:=Uppercase(EdUnid_codigo.ResultFind.fieldbyname('Unid_inscricaomunicipal').AsString);
      infCTeNorm.rodo.dPrev:=Q.fieldbyname('moes_datasaida').asdatetime;


      while not Q1.eof do begin

//        totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency,2);
// 21.05.12 - nova valida��o da sefa - aceita 0,01 centavos de diferen�a
//        totalitem:=Q1.fieldbyname('move_qtde').ascurrency*FGEral.Arredonda( Q1.fieldbyname('move_venda').ascurrency,4);
//        totalitem:=Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency;

// 25.05.12 - Asatec - 03.08.12 - NP - Novicarnes
        if ( Q.fieldbyname('moes_peracres').ascurrency>0 ) and
           ( Q.fieldbyname('moes_estado').asstring='EX' )
           then
//          totalitem:=Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').asFLOAT
          totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').asFLOAT,2)
// 07.08.13 - NP - Novicarnes com d�zima no valor unitario do kilo
//        else if Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor then
        else if Q1.fieldbyname('move_tipomov').asstring=Global.CodCompraProdutor then
          totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').asfloat,2)
        else
          totalitem:=FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency,2);

//        vendaliquido:=Q1.fieldbyname('move_venda').asfloat - ( Q1.fieldbyname('move_venda').asfloat*(Q.fieldbyname('moes_perdesco').ascurrency/100) );
// 24.05.11
        vendaliquido:=Q1.fieldbyname('move_venda').asfloat - ( Q1.fieldbyname('move_venda').asfloat*roundvalor(Q.fieldbyname('moes_perdesco').ascurrency/100) );
//        if Q.fieldbyname('moes_perdesco').ascurrency>0 then
//          totalitem:= FGEral.Arredonda(Q1.fieldbyname('move_qtde').ascurrency*vendaliquido,2);

        baseicms:=totalitem;
        baseicmssemreducao:=0;
// 29.08.11 - Descontos e acrescimentos na base do icms
        if Q.fieldbyname('moes_perdesco').ascurrency>0 then
          baseicms:=baseicms - roundvalor( totalitem * (Q.fieldbyname('moes_perdesco').ascurrency/100) ) ;
// 29.05.12 - Asatec..nao bate o valor calculado do icms em nota com desconto
        if ( Q.fieldbyname('moes_estado').asstring='EX' )  and (cEs='E') then begin
          baseicms:=baseicms;
        end else if Q.fieldbyname('moes_peracres').ascurrency>0 then begin
             baseicms:=baseicms + roundvalor( totalitem * (Q.fieldbyname('moes_peracres').ascurrency/100) ) ;
        end;
////////////////////////////
//        vlripi:=baseicms*(Q1.fieldbyname('move_aliipi').ascurrency/100);
// 07.07.11 - para prever notas em que soma o ipi na base do icms
        vlripi:=totalitem*(Q1.fieldbyname('move_aliipi').ascurrency/100);
// 21.05.12 - Asatec
        if ( (Global.Topicos[1327]) and (ConsumidorFinal='S') ) OR
// 17.09.12 - Asatec
           ( (Global.Topicos[1327]) and (Q.fieldbyname('moes_tipomov').asstring=Global.CodDevolucaoIgualVenda) ) then
          baseicms:=baseicms+vlripi
// aqui ver se soma ipi na base do item cfe topico do sistema
        else if ( Global.Topicos[1350] ) and ( pos(Q.fieldbyname('moes_tipomov').asstring,TiposDevolucao)>0 ) then
           baseicms:=baseicms+vlripi;

        redubase:=FCodigosFiscais.GetAliquotaRedBase( FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,
                    Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
// 28.05.12 - Asatec
        if ( Q.fieldbyname('moes_estado').asstring='EX' )  and (cEs='E') then begin
          if Q1.fieldbyname('move_aliicms').ascurrency>0 then begin
            baseicms:=( baseicms/(1-(Q1.fieldbyname('move_aliicms').ascurrency/100)) );
            baseicmssemreducao:=baseicms;
          end;
          redubase:= Q1.fieldbyname('move_redubase').ascurrency;
          if redubase>0 then begin
            baseicms:=(baseicms*(redubase/100));
          end;
        end else if (redubase >0 ) then begin
          baseicms:=(baseicms*(redubase/100));
        end;
        vlricms:=baseicms*(Q1.fieldbyname('move_aliicms').ascurrency/100);

//        vlricms:=vlricms - roundvalor(vlricms*(rateioicmsimportacao));
//        vlricms:=vlricms - (vlricms*FGeral.Arredonda(rateioicmsimportacao,3));  fica menor
//        vlricms:=vlricms - (vlricms*FGeral.Arredonda(rateioicmsimportacao,2));  // fica maior
//        vlricms:=vlricms - FGeral.Arredonda(vlricms*(rateioicmsimportacao),3);  //  1917.25
//        vlricms:=vlricms - FGeral.Arredonda(vlricms*(rateioicmsimportacao),1);  //    1917.
//        vlricms:=vlricms - FGeral.Arredonda(vlricms*(rateioicmsimportacao),6);  // 1917
//        vlricms:=vlricms - FGeral.Arredonda(vlricms*(rateioicmsimportacao),4);  // 1917
//        vlricms:=vlricms - vlricms*(rateioicmsimportacao);  //
//        vlricms:=vlricms*(rateioicmsimportacao);  //
//        vlricms:=vlricms - (vlricms*rateioicmsimportacao)/100;  //

// 30.01.12 = Clessi
        if vlricms=0 then baseicms:=0;

//////////////////////////////////////////////////////////////////////////
{
          with  Det.Add do
          begin
// 06.02.12 - cfop de subst. tributaria
            if ( pos(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring,'S;2') > 0 ) then

              Prod.CFOP     :=GetCfopItem(Q1.FieldByName('move_cst').asstring,Q1.FieldByName('move_transacao').asstring,
                              Q1.FieldByName('moes_natf_codigo').asstring,Q1.FieldByName('moes_tipomov').asstring,
                              cfopind,Q1.FieldByName('esto_cipi_codigo').asinteger,'S')
            else
              Prod.CFOP     :=GetCfopItem(Q1.FieldByName('move_cst').asstring,Q1.FieldByName('move_transacao').asstring,
                              Q1.FieldByName('moes_natf_codigo').asstring,Q1.FieldByName('moes_tipomov').asstring,
                              cfopind,Q1.FieldByName('esto_cipi_codigo').asinteger);

            Prod.cProd     := Q1.fieldbyname('move_esto_codigo').asstring;

//            Prod.xProd     :=Ups(Q1.fieldbyname('esto_descricao').asstring);
// 30.07.10 - Abra '/' no nome do produto
            Prod.xProd     := Ups(Q1.fieldbyname('esto_descricao').asstring);
// 05.07.10 - Clessi
            if Global.Topicos[1310] then
               Prod.xProd :=Ups(Q1.fieldbyname('esto_descricao').asstring+' '+
                            Q1.fieldbyname('Core_descricao').AsString+' '+
                            Q1.fieldbyname('Tama_descricao').AsString)
// 17.10.13 - Novicarnes
            else if Global.Topicos[1369] then
               Prod.xProd :=copy(Ups(Q1.fieldbyname('esto_descricao').asstring)+
                            replicate('.',40-length(trim(Q1.fieldbyname('esto_descricao').asstring))),1,40)+
                            Q1.fieldbyname('move_pecas').AsString+' PC';

            Prod.qCom    := Q1.fieldbyname('move_qtde').asfloat;
            Prod.qTrib   := Q1.fieldbyname('move_qtde').asfloat;
            Prod.uCom    := Q1.fieldbyname('esto_unidade').asstring;
            Prod.uTrib   := Q1.fieldbyname('esto_unidade').asstring;
            Prod.vProd   := totalitem;
// 18.05.11 - rateio do desconto pelos itens - ver se faz o mesmo com frete+seguro
            if Q.fieldbyname('moes_perdesco').ascurrency>0 then begin
              Prod.vUnCom  := Q1.fieldbyname('move_venda').asfloat;
              Prod.vUnTrib := Q1.fieldbyname('move_venda').asfloat;
// 30.05.11 - VC com desconto
//              Prod.vDesc   := totalitem * roundvalor(Q.fieldbyname('moes_perdesco').ascurrency/100) ;
              Prod.vDesc   := roundvalor( totalitem * (Q.fieldbyname('moes_perdesco').ascurrency/100) ) ;
            end else begin
// 07.08.13 - NP - Novicarnes com d�zima no valor unitario do kilo
              if Q.fieldbyname('moes_tipomov').asstring=Global.CodCompraProdutor then begin
                Prod.vUnCom  := Q1.fieldbyname('move_venda').asfloat;
                Prod.vUnTrib := Q1.fieldbyname('move_venda').asfloat;
              end else begin
// 30.05.12 - Asatec
                Prod.vUnCom  := Q1.fieldbyname('move_venda').ascurrency;
                Prod.vUnTrib := Q1.fieldbyname('move_venda').ascurrency;
              end;
            end;
// 29.08.11 - rateio do acrescimo pelos itens - ver se faz o mesmo com frete+seguro
            if Q.fieldbyname('moes_peracres').ascurrency>0 then
//              Prod.vOutro   := roundvalor( totalitem * (Q.fieldbyname('moes_peracres').ascurrency/100) ) ;
// 30.05.12 = Asatec
//              Prod.vOutro   := roundvalor( totalitem * (Q.fieldbyname('moes_peracres').ascurrency/100) ) ;
              Prod.vOutro   := roundvalor( totalitem * (despacessorias/Q.fieldbyname('moes_totprod').ascurrency) ) ;
// 11.11.13 - Metalforte - Devolucao tributada joga ipi no desp. acessoria
           if Despacessorias>0 then
              Prod.vOutro   := roundvalor( totalitem * (despacessorias/Q.fieldbyname('moes_totprod').ascurrency) ) ;

/////////////////////////
            Prod.cEAN    := GetCodigoBarra(Q1.fieldbyname('move_esto_codigo').asstring);
// caso tiver ean diferente para a unidade 'normal' e a unidade comercializada
//          tipo ean pro produto 'unitario' e o produto vendido em caixa
            Prod.cEANTrib:= Prod.cEAN;
            Prod.nItem   := seq;
// 30.05.12 - Simar
            if ( Q.fieldbyname('moes_frete').ascurrency>0 ) and ( Q.fieldbyname('moes_totprod').ascurrency>0 ) then begin
              Prod.vFrete  := totalitem * (Q.fieldbyname('moes_frete').ascurrency/Q.fieldbyname('moes_totprod').ascurrency);
// 19.06.12 - Simar  - caso no rateio valor for 'muito pequeno' na cabe em duas casas decimais
//            ficando zero dai sefa nao aceita item sem rateio do frete...
              if FGeral.Arredonda( Prod.vFrete,2 ) = 0 then Prod.vFrete:=0.01;
// 23.10.12 - Asatec
              baseicms:=baseicms+Prod.vFrete;
              vlricms:=baseicms*(Q1.fieldbyname('move_aliicms').ascurrency/100);
/////////////////////////
            end;
            Prod.NCM     := FEstoque.GetNCMipi(Q1.fieldbyname('move_esto_codigo').asstring);
// 12.01.12 - dados da DI - nota de importa��o
            if temdi then begin
              with Prod.DI.Add do begin
                nDi:=Q.fieldbyname('moes_numerodi').asstring;
                xLocDesemb:=Q.fieldbyname('moes_localdesen').asstring;
                dDi:=Q.fieldbyname('moes_dtregistro').asdatetime;
                dDesemb:=Q.fieldbyname('moes_dtdesen').asdatetime;
                UFDesemb:=Q.fieldbyname('moes_ufdesen').asstring;
                cExportador:=Q.fieldbyname('moes_tipo_codigo').asstring;
                with adi.Add do begin
                  nAdicao:=seq;
                  nSeqAdi:=seq;
                  cFabricante:=Q.fieldbyname('moes_tipo_codigo').asstring;
                  vDescDI:=0;
                end;
              end;
            end;
///////////
// 27.06.11
            if ( Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1Asinteger('ConfNfComple') )
               and ( FGeral.GetConfig1Asinteger('ConfNfComple')>0 ) then
              Prod.IndTot:=itNaoSomaTotalNFe;

            with Imposto do
            begin

//              if Q1.fieldbyname('move_aliicms').ascurrency=0 then begin
              if FNotaSaida.Servico(Q1.fieldbyname('move_esto_codigo').asstring) then begin
                with ISSQN do
                begin
                    vAliq := FEstoque.GetaliquotaIss(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,global.UFUnidade);
                    vIssQn :=  vBC*(vAliq/100);
                    vBC   := baseicms;
                    cMunFG := strtoint(codmuni) // codigo do municipio do Fator Gerador
                                               //  ver se precisa ser do cliente...
                end;
                with ICMS do  // senao fica com valores na coluna de icms
                begin
                    pICMS := 0;
                    vICMS := 0;
                    vBC   := 0;
                    pRedBC:= 0;
                end;
//                vTotTrib:=CalculaImpostoAproximado()
// 10.06.13 - ver como tratar o 'NBS' - codigo de servi�os

              end else begin

                with ICMS do
                begin

    //               Det.Add.Imposto.ICMS.CST.  :=
    //                CST   := Q1.fieldbyname('move_cst').asstring;
//                    if pos(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring,'S;2') > 0 then begin
// 16.01.12 - nao tinha previsto empresa do simples e nota de produtor
                    if ( pos(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring,'S;2') > 0 )
//                       and
//                       ( pos(copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1),'5;6;7')>0 )
                       then begin
                       CSOSN := GetCstSimples(Q1.fieldbyname('move_cst').asstring);
                       orig  :=  GetOrigemMercadoria(Q1.fieldbyname('move_cst').asstring,'S');
// 25.04.13 - devolucao pra quem precisa se creditar do icms
                        if pos(Q1.fieldbyname('move_tipomov').asstring,TiposDevolucao)>0 then begin
//                          if Q1.fieldbyname('move_cst').asstring='101' then begin
//                            pCredSN := Q1.fieldbyname('move_aliicms').ascurrency;
//                          vCredICMSSN := vlricms;
// assim a sefa nao autoriza..com coosn 101 continua dando dif. de base de calculo - tentado 900
//                          end else begin
//                       and
                           pICMS := Q1.fieldbyname('move_aliicms').ascurrency;
                           if ( Q1.fieldbyname('move_tipomov').asstring=Global.CodDevolucaoTributada ) then begin
                             vBC   := baseicms+roundvalor( totalitem * (despacessorias/Q.fieldbyname('moes_totprod').ascurrency) ) ;
                             vlricms:=(baseicms+roundvalor( totalitem * (despacessorias/Q.fieldbyname('moes_totprod').ascurrency) ))
                                      *(Q1.fieldbyname('move_aliicms').ascurrency/100);
                             vICMS := vlricms;
                           end else begin
                             vICMS := vlricms;
                             vBC   := baseicms;
                           end;
                        end;
// 08.03.14 - Empresa do Simples sujeita a ST
                       margemlucro:=FCodigosFiscais.GetPercBaseSubs(FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring));
                       basesubs:=( totalitem*(1+(margemlucro/100)) );
                       icmsitemsubs:=(totalitem*(1+(margemlucro/100))) * (Q1.fieldbyname('move_aliicms').ascurrency/100);
                       icmsitemsubs:=icmsitemsubs-vlricms;
                       if margemlucro>0 then begin
                         modBCST:=dbisMargemValorAgregado;
                         vBCST:=basesubs;
                         pICMSST:=Q1.fieldbyname('move_aliicms').ascurrency;
                         vICMSST:=icmsitemsubs;
                         vICMS := vlricms;
                         vBC   := baseicms;
                       end;

//////////////////////////////////

//                    end else if ( pos(EdUNid_codigo.resultfind.fieldbyname('unid_Simples').asstring,'S;2') > 0 )
//                                 and
//                                ( pos(Q.fieldbyname('moes_tipomov').asstring,TiposNumeracaoSaida)=0 )
//                       then begin
//                      CSOSN := GetCstSimples(Q1.fieldbyname('move_cst').asstring);
//                      orig  :=  GetOrigemMercadoria(Q1.fieldbyname('move_cst').asstring,'S');

                    end else begin

                      CST   := GetCst(Q1.fieldbyname('move_cst').asstring);
                      pICMS := Q1.fieldbyname('move_aliicms').ascurrency;
                      vICMS := vlricms;
                      if ( Q.fieldbyname('moes_comv_codigo').asinteger=FGeral.GetConfig1Asinteger('ConfNfComple') )
                         and ( FGeral.GetConfig1Asinteger('ConfNfComple')>0 ) then begin
                        vBC:=0;
                        pRedBc:=0;
                      end else begin
                        if baseicmssemreducao>0 then
                          vBC   := baseicmssemreducao
                        else
                          vBC   := baseicms;
                        pRedBC:= redubase;
                      end;
// 12.07.11
                      orig  :=  GetOrigemMercadoria(Q1.fieldbyname('move_cst').asstring,'N');
                    end;

  //  TpcnDeterminacaoBaseIcms = (dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao);
                    modBC :=dbiValorOperacao;
                end; // Det.Add.Imposto.Icms
// 24.10.11 - calculo do pis e cofins
                alipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,
                       Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
                alicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q1.fieldbyname('move_esto_codigo').asstring,
                        Q1.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  );
// 09.04.13 - Clessi - notas de exportacao
                if copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1)='7' then begin
                  alipis:=0;
                  alicofins:=0;
                end;
// 10.06.13 - mostrar tributos na inf. complementares
//                vTotTrib:=CalculaImpostoAproximado(Prod.NCM,Q1.fieldbyname('move_cst').asstring,totalitem);
                xvTotTrib:=CalculaImpostoAproximado(Prod.NCM,Q1.fieldbyname('move_cst').asstring,totalitem);
                Valortotalimpaproximado:=Valortotalimpaproximado + xvTotTrib;

///////////////////////
                with PIS do
                begin
                  CST:=GetCStPis( FEstoque.GetsituacaotributariaPIS(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q1.fieldbyname('moes_estado').asstring) );
                  vBC:=totalitem;
// viagem da vava
//                  if (Q.fieldbyname('moes_tipocad').AsString='C') and (ConsumidorFinal='S') then begin
//                    pPIS:=0;
//                    vlrpis:=0;
//                    vPIS:=0;
//                  end else begin
// 26.08.13
                    if TributaPIS( GetCStPis( FEstoque.GetsituacaotributariaPIS(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q1.fieldbyname('moes_estado').asstring) ) ) then begin
                      pPIS:=alipis;
                      vlrpis:=totalitem*(alipis/100);
                      vPIS:=vlrpis;
                    end else begin
                      pPis:=0;
                      vlrpis:=0;
                      vPis:=0;
                    end;
//                  end;
                end;
////////////////////////
                with COFINS do
                begin
                  CST:=GetCStCofins( FEstoque.GetsituacaotributariaCOFINS(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q1.fieldbyname('moes_estado').asstring) );;
                  vBC:=totalitem;
// viagem da vava
//                  if (Q.fieldbyname('moes_tipocad').AsString='C') and (ConsumidorFinal='S') then begin
//                    pCOFINS:=0;
//                    vlrcofins:=0;
//                    vCOFINS:=0;
//                  end else begin
// 26.08.13
                    if TributaCOFINS( GetCStCOFINS( FEstoque.GetsituacaotributariaCOFINS(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,Q1.fieldbyname('moes_estado').asstring) ) ) then begin
                      pCOFINS:=alicofins;
                      vlrcofins:=totalitem*(alicofins/100);
                      vCOFINS:=vlrcofins;
                    end else begin
                      pCOFINS:=0;
                      vlrcofins:=0;
                      vCOFINS:=vlrcofins;
                    end;
                end;
///////////////////////////////////////
                cOK:=true;
                if  ( (trim(Q1.fieldbyname('esto_cipi_codigo').asstring)<>'') and
                    ( pos(Q1.fieldbyname('moes_tipomov').asstring,Global.TiposSaida)>0 ) )
                    OR
// 13.04.11 - Devolucao DX Clessi
//                    ( (Q1.fieldbyname('move_aliipi').ascurrency>0) and (pos(Q1.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0)  )
// 16.05.12 - Importacao Asatec
                    (  ( (Q.fieldbyname('moes_estado').asstring='EX') or (Q1.fieldbyname('move_aliipi').ascurrency>0) )
                        and (pos(Q1.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0)  )
                  then begin
                  with IPI do
                  begin
//                      CST   := GetCstIPI(Q1.fieldbyname('move_cst').asstring);
// 22.03.10 - Asatec - destaque de ipi somente em saidas
                      CST:=StrToCSTIPI(cOK, FEstoque.GetCodigoCSTipi(Q1.fieldbyname('move_esto_codigo').asstring,cEs) );
//                      GetCst(Q1.fieldbyname('move_cst').asstring);
/////////////////////////
                      pIPI  := Q1.fieldbyname('move_aliipi').ascurrency;
                      vIPI  := vlripi;
                      vBC   := baseicms;
    //  TpcnDeterminacaoBaseIcms = (dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao);

                  end; // Det.Add.Imposto.IPI
                end;

              end;  // ref .if do servicos
            end; // Det.Add.Imposto
          end;  // Det.add
          }
//////////////////////////////////////////////////////

        //end;
// 23.11.11
        totalpis:=totalpis+vlrpis;
        totalcofins:=totalcofins+vlrcofins;
/////////////
        Q1.Next;
        inc(seq);
      end;

///////////////    }
// 23.11.11
//      Total.ICMSTot.vPIS       :=  totalpis;
//      Total.ICMSTot.vCOFINS    :=  totalcofins;
/////////////////////////////////////////////
// 10.06.13
//      Total.ICMSTot.vTotTrib := Valortotalimpaproximado;
//     talvez tenha que atualizar o Schema pra poder usar

      if trim(dadosadicionais)<>'' then begin
        Compl.ObsCont.Clear;
        with compl.ObsCont.Add do begin
          xCampo:='dados adicionais';
          xTexto:=dadosadicionais + ' - '+'Valor aproximado tributos '+FGeral.Formatavalor(Valortotalimpaproximado,f_cr)+' Fonte: IBPT';
        end
      end else
        with compl.ObsCont.Add do begin
          xCampo:='dados adicionais';
          xTexto:=dadosadicionais + 'Valor aproximado tributos '+FGeral.Formatavalor(Valortotalimpaproximado,f_cr)+' Fonte: IBPT';
        end;

    FGeral.Fechaquery(Q1);

    FGeral.FechaQuery(QMOvb);


    end;  // do mestre do acbrCte1

//////////////////////////////////
// 24.11.08
    Sistema.edit('movesto');
    Sistema.setfield('moes_dtnfeexp',Sistema.hoje);
    Sistema.setfield('moes_nfeexp','S');
    Sistema.Post('moes_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring));

    Q.Next;   // NO MESTRE


  end; //  ref. as notas o 'mestre'

  if  acbrCte1.Conhecimentos.Count>0 then begin
    Sistema.beginprocess('Gerando arquivos XML - 5 ');
    if (EdFormaemissao.text<>'4')  then
      acbrCte1.Conhecimentos.GerarCTe;
//    else
//      acbrCte1.Conhecimentos.GerarNFe;

    IF OP='E' THEN BEGIN  // 01.03.12
      Sistema.beginprocess('Checando as informa��es do(s) conhecimento(s)');
  // 19.01.10
      if not ValidaNotas( acbrCte1 ) then begin
        Sistema.endprocess('');
        exit;
      end;
    END;

    Sistema.beginprocess('Validando e Assinando arquivos XML');

    if (Global.Usuario.Codigo=100) and (global.Usuario.Nome='Andr�') then begin
      if confirma('Validar') then
        acbrCte1.Conhecimentos.Validar;
    end; // else

// testar com pedro conhecimento 'pra valer' pra ver se valida caso contrario
// tirar por enquanto
// 22.02.18 - retirado pois d� erro porem autoriza normal
//     acbrCte1.Conhecimentos.Validar;


// 07.02.14 - ver fazer 'validacao propria' aqui e nao fazer dentro do acbr
// 09.06.11
//    IF OP='E' THEN BEGIN  // 01.03.12
//        if (Global.Usuario.Codigo=900) and (global.Usuario.Nome='Andr�') then begin
//         if confirma('Validar ?') then
//           if not  acbrCte1.Conhecimentos.ValidacomRetorno then begin
//             Sistema.endprocess('');
//             exit;
//           end;
//      end else if not acbrCte1.Conhecimentos.ValidacomRetorno then begin
//        Sistema.endprocess('');
//        exit;
//      end;
//
//    END;

    pathenvioexterno:='';
    pathenvioexternoretorno:='';
    pathretornoexterno:='';
    drive:=ExtractFileDrive(Application.ExeName);
    if Global.Usuario.OutrosAcessos[0333] then begin
      pathenvioexterno:=Drive+'\Unimake\UniNFe\'+EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring+'\Envio';
      pathenvioexternoretorno:=Drive+'\Unimake\UniNFe\'+EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring+'\Enviado\Autorizados\'+
                        FormatDatetime('yyyymm',EdTermino.asdate) ;
      pathretornoexterno:=Drive+'\Unimake\UniNFe\'+EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring+'\Retorno';
    end;

//      C:\Unimake\UniNFe\07411627000184\Enviado\Autorizados\201208
    arquivoexterno:='ENTNFE.TXT';
    arquivoexternoret:='SAINFE.TXT';

/////////////////////
// 16.08.12
    Sistema.beginprocess('Salvando '+inttostr(acbrCte1.Conhecimentos.Count)+ ' arquivos XML assinados');
    for i:=0 to acbrCte1.Conhecimentos.Count-1 do begin
//      acbrCte1.Conhecimentos.Items[i].XML.SaveToFile(ExtractFileDir(application.ExeName)+acbrCte1.Conhecimentos.Items[i].XML.CteChave+'-NFe.xml');
      acbrCte1.Conhecimentos.Items[i].GravarXML(acbrCte1.Configuracoes.Arquivos.PathCTe+'\'+inttostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.cCT)+FGeral.TiraBarra( Datetostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.dhEmi) )+'-CTe.xml');
      if trim(pathenvioexterno)<>'' then
        acbrCte1.Conhecimentos.Items[i].GravarXML(PathenvioExterno+'\'+inttostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.cCT)+FGeral.TiraBarra( Datetostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.dhEmi) )+'-CTe.xml');
    end;

    if (Global.Usuario.Codigo=900) and (global.Usuario.Nome='Andr�') then begin
      if confirma('Parar processo') then begin
        sistema.endprocess('');
        exit;
      end;
    end;

    if ( OP='E' ) and ( Global.Topicos[1028] ) then begin
      TNotas.Free;
      Sistema.EndProcess('XML Gerado');
      exit;
    end;

//    pathenvioexterno:='\acbrCteMonitor';

    IF OP='E' THEN BEGIN
      if EdFormaemissao.text<>'2' then begin
        Sistema.beginprocess('Enviando arquivos XML para SEFA');
//        if acbrCte1.WebServices.StatusServico.Executar then begin
{
        try
          statusok:=acbrCte1.WebServices.StatusServico.Executar;
        except
          statusok:=false;
          Avisoerro('Retorno Sefa a :'+acbrCte1.WebServices.StatusServico.RetWS  );
          Avisoerro('Retorno Sefa b :'+acbrCte1.WebServices.StatusServico.xMotivo  );
          Avisoerro('Retorno Sefa c :'+acbrCte1.WebServices.StatusServico.Msg  );
          Avisoerro('Retorno Sefa :'+acbrCte1.WebServices.Retorno.xMotivo);
          Avisoerro('Retorno Sefa 1:'+acbrCte1.WebServices.Retorno.Msg);
        end;
}

// 21.08.12
        acbrCte1.Configuracoes.WebServices.Tentativas:=2;
        xmlaux:=TSTringList.create;

        cretornoerro:='';
//////////////////////////////
{
// 03.01.14 - tentar 'autenticar' no proxy
        if ( Global.Topicos[1013] ) and ( not jaautenticado ) then begin
//                   StringToWideChar('www.google.com.br', xLink, 120);
          StringToWideChar('localhost', xLink, 120);
          HlinkNavigateString(nil,xLink );
          jaautenticado:=true;
        end;
        }
/////////////

// 20.08.12 - vendo pra retirar esta checagem de status
//        Sistema.beginprocess('Checando Status do Servi�o na SEFA');
        if global.Usuario.codigo<>100 then
          ChecaStatusSefa:=true
        else
          ChecaStatusSefa:=acbrCte1.WebServices.StatusServico.Executar;

        if ChecaStatusSefa  then begin

          Numlote:=FGEral.GetContador('LOTECTE'+EdUnid_codigo.text,false);
          try
//            if EdFormaemissao.Text='4' then begin
//              Sistema.beginprocess('Enviando arquivos XML para site do DPEC');
//              acbrCte1.WebServices.EnviarDPEC.Executar;
//            end else
              if Global.usuario.OutrosAcessos[0333] then begin
                for i:=0 to acbrCte1.Conhecimentos.Count-1 do begin
                  Sistema.beginprocess('Enviando xml cte '+inttostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.nCT)+' para WebServices da SEFA');
                  ListaEnvioNotas:=TStringList.create;

{
 - Nfe.LerNfe(cArqXml) : ler arquivo XML e retorna formato INI
 - Nfe.AdicionarNfe(cArqIni,nLote)
 - Nfe.EnviarLoteNfe(nLote)
 NFe.CriarEnviarNFe
 }
                  ListaEnvioNotas.Add( 'NFE.EnviarNFe("'+acbrCte1.Configuracoes.Arquivos.PathCTe+'\'+inttostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.cCT)+FGeral.TiraBarra( Datetostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.dhEmi) )+'-NFe.xml'+'",'+inttostr(numlote)+')' );

//                  ListaEnvioNotas.Add('Nfe.LerNfe("'+acbrCte1.Configuracoes.Arquivos.PathCTe+'\'+inttostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.cCT)+FGeral.TiraBarra( Datetostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.dEmi) )+'-NFe.xml'+'")' );
//                  ListaEnvioNotas.Add('Nfe.AdicionarNfe('+
//                  ListaEnvioNotas.SavetoFile( pathenvioexterno+'\'+arquivoexterno );
//                  Sleep(500);
//                  if FileExists( pathenvioexterno+'\'+arquivoexternoret ) then
// ver se joga o retorno no proprio componente do acbr na propriedade xml

//                  ListaEnvioNotas.SavetoFile( pathenvioexterno+'\'+arquivoexterno2 );
                  ListaEnvioNotas.Free;
                end;
              end else begin

                 acbrCte1.WebServices.Envia(NumLote);

              end;
// 20.08.12
//                acbrCte1.Enviar(NumLote,false);

//              ListaEnvioNotas.SavetoFile( pathenvioexterno+'\'+arquivoexterno );
//              ListaEnvioNotas.Free;


  //            acbrCte1.WebServices.ConsultaDPEC.Executar ;
  //          end;
    //        Aviso('xmotivo='+acbrCte1.WebServices.Retorno.xMotivo );
    //        Aviso('chavenfe='+acbrCte1.WebServices.Retorno.ChaveNFe );
          except on E:exception do begin

//            Avisoerro('Retorno Sefa :'+acbrCte1.WebServices.StatusServico.xMotivo);
// 02.05.12
              cretornoerro:=acbrCte1.WebServices.Retorno.xMotivo;
              if trim(cretornoerro)<>'' then
                Aviso('Retorno Sefa :'+acbrCte1.WebServices.Retorno.xMotivo)
              else begin
  // 19.07.13
                Sistema.endprocess('Retorno da Receita :'+E.Message+
                                   ' Tentar enviar novamente e/ou usar Consulta Sefa '
                                    );
                exit;
              end;

            end;

          end;
  //        acbrCte1.Conhecimentos.Clear;
  //        acbrCte1.Conhecimentos.LoadFromFile(acbrCte1.Configuracoes.Arquivos.PathCTe+'\');

          Sistema.beginprocess('Gravando retornos da SEFA');
          for i:=0 to acbrCte1.Conhecimentos.Count-1 do begin
// 23.08.12 - adsl oi 10 megas da novi..
           if trim(pathenvioexterno)<>'' then begin
              tempo:=0;
              while (not FileExists( PathRetornoExterno+'\'+inttostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.cCT)+FGeral.TiraBarra( Datetostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.dhEmi) )+'-num-lot.xml' ) )
                and (  tempo<100000 ) do begin
                inc(tempo);
              end;
              if FileExists(  PathRetornoExterno+'\'+inttostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.cCT)+FGeral.TiraBarra( Datetostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.dhEmi) )+'-num-lot.xml' )  then
                xmlaux.LoadFromFile( PathRetornoExterno+'\'+
                          inttostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.cCT)+FGeral.TiraBarra( Datetostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.dhEmi) )+'-num-lot.xml' )
              else
                Sistema.endprocess('Arquivo com NUMERO DO LOTE  '+PathRetornoExterno+'\'+
                          inttostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.cCT)+FGeral.TiraBarra( Datetostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.dhEmi) )+'-num-lot.xml'+
                          ' n�o encontrado.  Verificar' );
              cretorno:=GetTag('NumeroLoteGerado',xmlaux.Text);
              tempo:=0;
              while (not FileExists( PathRetornoExterno+'\'+strzero(strtointdef(cretorno,0),15)+'-rec.xml' ) ) and (  tempo<100000 ) do begin
                inc(tempo);
              end;
              IF FileExists( PathRetornoExterno+'\'+strzero(strtointdef(cretorno,0),15)+'-rec.xml' ) then
                xmlaux.LoadFromFile( PathRetornoExterno+'\'+strzero(strtointdef(cretorno,0),15)+'-rec.xml' )
              else
                Sistema.endprocess('Arquivo com NUMERO DO RECIBO  '+PathRetornoExterno+'\'+
                                   strzero(strtointdef(cretorno,0),15)+'-rec.xml'+
                                   ' n�o encontrado.  Verificar' );
              cretorno:=GetTag('nRec',xmlaux.Text);
// s� sai quando encontra o arquivo
              tempo:=0;
              while (not FileExists( PathRetornoExterno+'\'+cretorno+'-pro-rec.xml' ) ) and (  tempo<100000 ) do begin
                inc(tempo);
              end;
              xmlaux.LoadFromFile( PathRetornoExterno+'\'+cretorno+'-pro-rec.xml' );
              cretorno:=GetTag('xMotivo',copy(xmlaux.Text, pos('dhRecbto',xmlaux.Text),length(xmlaux.Text) ) );
              if pos( 'AUTORIZADO',Uppercase(GetRetorno(cretorno)) )>0 then begin
                if FileExists( PathEnvioExternoRetorno+'\'+inttostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.cCT)+FGeral.TiraBarra( Datetostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.dhEmi) )+'-procCTe.xml' ) then begin
                  xmlaux.LoadFromFile( PathEnvioExternoRetorno+'\'+inttostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.cCT)+FGeral.TiraBarra( Datetostr(acbrCte1.Conhecimentos.Items[i].Cte.Ide.dhEmi) )+'-procCTe.xml' );
                  cretorno:=GetRetorno(xmlaux.Text);
                end;
              end;
           end;
// 23.08.12
           if trim(pathenvioexterno)='' then
              cretorno:=GetRetorno( acbrCte1.Conhecimentos.Items[i].XML );
// 02.05.12
            if trim(cretorno)='' then cretorno:=cretornoerro;
            AtualizaGrid( acbrCte1.Conhecimentos.Items[i].Cte.Ide.nCT,cretorno );
            ctransacao:=GetGridTransacao(acbrCte1.Conhecimentos.Items[i].Cte.Ide.nCT);
            if ( trim(ctransacao)<>'' ) and
               ( trim(cretorno)<>'' )   and
               ( EdFormaemissao.Text<>'4' ) and
               ( pos('ENCONTRADO',UPpercase(cretorno))=0 )
               then begin
               QNfe:=Sqltoquery('select moes_dtnfeauto,moes_chavenfe from movesto where moes_transacao='+Stringtosql(Trim(ctransacao))+
                                ' and moes_status<>''C''' );
               Sistema.edit('movesto');
               campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
// 08.12.16
               xmlstring:=ACBrCTe1.Conhecimentos.Items[i].XML;
               xmlstring:=FGeral.TiraBarra(xmlstring,chr(39),'"');
               if pos('AUTORIZADO',uppercase(cretorno))>0 then begin
                 Sistema.setfield('moes_dtnfeauto',Sistema.hoje);
//                 Sistema.setfield('moes_xmlnfe',acbrCte1.Conhecimentos.Items[i].XML) ;
// 08.12.16
                 Sistema.setfield('moes_xmlnfe',xmlstring) ;

// 23.08.12
                 Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
//                 if trim(pathenvioexterno)<>'' then
//                     Sistema.setfield('moes_xmlnfet',xmlaux.Text)
//                 else if campo.tipo<>'' then // 16.07.10
//                   Sistema.setfield('moes_xmlnfet',acbrCte1.Conhecimentos.Items[i].XML) ;
// 08.12.16
                 if trim(pathenvioexterno)<>'' then
                     Sistema.setfield('moes_xmlnfet',xmlstring)
                 else if campo.tipo<>'' then // 16.07.10
                   Sistema.setfield('moes_xmlnfet',xmlstring) ;

                 if trim(pathenvioexterno)<>'' then
                   Sistema.setfield('moes_chavenfe',copy(acbrCte1.Conhecimentos.Items[i].Cte.infCTe.ID,4,44))
                 else
                   Sistema.setfield('moes_chavenfe',acbrCte1.Conhecimentos.Items[i].Cte.procCTe.chCTe);
               end else if trim(cretorno)<>''  then begin
                 if Datetoano(QNfe.fieldbyname('moes_dtnfeauto').AsDatetime,true) <= 1920 then begin
// 23.08.12
//                   if trim(pathenvioexterno)<>'' then
//                     Sistema.setfield('moes_xmlnfet',xmlaux.Text)
//                   else if campo.tipo<>'' then // 16.07.10
//                     Sistema.setfield('moes_xmlnfet',acbrCte1.Conhecimentos.Items[i].XML) ;
// 08.12.16
               xmlstring:=ACBrCTe1.Conhecimentos.Items[i].XML;
               xmlstring:=FGeral.TiraBarra(xmlstring,chr(39),'"');
//               Streamxml.free;
               Sistema.setfield('moes_xmlnfe',xmlstring) ;
               if campo.tipo<>'' then // 16.07.10
                  Sistema.setfield('moes_xmlnfet',xmlstring) ;

                   Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
                   Sistema.setfield('moes_dtnfereto',Sistema.hoje);
                 end;
               end;
               FGeral.FechaQuery(QNfe);
  //             if trim(cretorno)<>'' then
  //               Sistema.setfield('moes_remessas',cretorno);
               Sistema.Post('moes_transacao='+stringtosql(ctransacao));
            end  else if EdFormaemissao.Text='4' then begin
//              cretorno:='enviado via DPEC';
//              cretorno:=GetRetorno( acbrCte1.WebServices.EnviarDPEC.xMotivo
// 05.11.12 - mudado do retorno
//              cretorno:= acbrCte1.WebServices.EnviarDPEC.xMotivo;

//              acbrCte1.WebServices.EnviarDPEC.xMotivo;
//              acbrCte1.Conhecimentos.Items[i].Alertas
//               mandar o xml da dpeC e nao do gerado...

              if trim( cretorno ) ='' then
//                if trim( acbrCte1.WebServices.EnviarDPEC.nRegDPEC )='' then
//                  cretorno:='sem protocolo de envio ao DPEC';

  //            avisoerro('RetWs :'+UTF8Encode(acbrCte1.WebServices.EnviarDPEC.RetWS));

              AtualizaGrid( acbrCte1.Conhecimentos.Items[i].Cte.Ide.nCT,cretorno );
              campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
              Sistema.edit('movesto');
              Sistema.setfield('moes_xmlnfe',acbrCte1.Conhecimentos.Items[i].XML) ;
              if campo.tipo<>'' then // 16.07.10
                Sistema.setfield('moes_xmlnfet',acbrCte1.Conhecimentos.Items[i].XML) ;
              Sistema.setfield('moes_chavenfe',acbrCte1.Conhecimentos.Items[i].Cte.procCTe.chCTe);
              Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
              Sistema.setfield('moes_dtnfereto',Sistema.hoje);
//              if trim( acbrCte1.WebServices.EnviarDPEC.nRegDPEC )<>'' then
 //               Sistema.setfield('moes_protodpec',acbrCte1.WebServices.EnviarDPEC.nRegDPEC+' '+
  //                                DateTimeToStr(acbrCte1.WebServices.EnviarDPEC.DhRegDPEC) )
//              else
                Sistema.setfield('moes_protodpec','');
              Sistema.Post('moes_transacao='+stringtosql(ctransacao));
            end else
               Avisoerro('Verificar. '+cretorno);
          end;
        end else
  //        Avisoerro('Status Servi�o :'+acbrCte1.WebServices.StatusServico.Msg);
          Avisoerro('Status WebService Sefa :'+acbrCte1.WebServices.StatusServico.xMotivo);
        try
          Sistema.Commit;
        except
          Avisoerro('N�o foi poss�vel gravar o xml de retorno no banco de dados');
        end;

//        if FileExists( pathenvioexterno+'\'+arquivoexternoret ) then
//          DeleteFile( pathenvioexterno+'\'+arquivoexternoret );

      end else begin  // 25.11.09 - caso for usar formulario de seguran�a apenas gerar xml
                      // para depois imprimir o danfe em form. seguran�a
        for i:=0 to acbrCte1.Conhecimentos.Count-1 do begin
////////////////////////          acbrCte1.Conhecimentos.Items[i].XML;
          ctransacao:=GetGridTransacao(acbrCte1.Conhecimentos.Items[i].Cte.Ide.nCT);
          cretorno:='EM CONTINGENCIA';
          AtualizaGrid( acbrCte1.Conhecimentos.Items[i].Cte.Ide.nCT,cretorno );
          campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
          Sistema.edit('movesto');
          Sistema.setfield('moes_xmlnfe',acbrCte1.Conhecimentos.Items[i].XML) ;
          if campo.tipo<>'' then // 16.07.10
             Sistema.setfield('moes_xmlnfet',acbrCte1.Conhecimentos.Items[i].XML) ;
          Sistema.setfield('moes_chavenfe',acbrCte1.Conhecimentos.Items[i].Cte.procCTe.chCTe);
          Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
          Sistema.setfield('moes_dtnfereto',Sistema.hoje);
          Sistema.Post('moes_transacao='+stringtosql(ctransacao));
        end;
        try
          Sistema.Commit;
        except
          Avisoerro('N�o foi poss�vel gravar o xml no banco de dados');
        end;
      end;

    END ELSE BEGIN   // Consulta Sefa

    ///////////////////////////////////////////////////
    ListaXml:=TStringList.create;

     for i:=0 to acbrCte1.Conhecimentos.Count-1 do begin
//       acbrCte1.WebServices.Consulta.CteChave := FExpNfetxt.GetTag('chNFe', acbrCte1.Conhecimentos.Items[i].XML );
// tiro o 'NFe' inicial do ID para ir somente os 44 digitos
       acbrCte1.WebServices.Consulta.CteChave := copy(acbrCte1.Conhecimentos.Items[i].Cte.infCTe.ID,4,44) ;
       if Op='C' then
         acbrCte1.WebServices.Consulta.Executar;


       if OP='P' then begin
         ListaXML.Clear;
         ListaXml.Add( AcbrCTe1.Conhecimentos.Items[i].XMLOriginal);
       end else begin
         arqxmlretorno:=AcbrCte1.Configuracoes.Arquivos.PathEvento+'\'+ACBrCTe1.WebServices.Consulta.CTeChave+'-sit.XML';
         if not FileExists(arqxmlretorno) then begin
              Avisoerro('Arquivo XML de retorno n�o encontrado:'+arqxmlretorno);
              Sistema.EndProcess('Banco de dados n�o atualizado');
              exit;
         end;
         ListaXML.Clear;
         ListaXml.LoadFromFile(arqxmlretorno);
       end;
       cretorno:= GetRetorno( ListaXml.Strings[0]  ) ;
       if trim(cretorno)='' then
         cretorno:=copy(ACBrCTe1.Conhecimentos.Items[i].CTe.procCte.xMotivo,53,50);
       if trim(cretorno)='' then
         cretorno:=copy(ACBrCte1.Conhecimentos.Items[i].CTe.procCTe.xMotivo,1,80);

       if op<>'' then
         AtualizaGrid( acbrCte1.Conhecimentos.Items[i].Cte.Ide.nCT,cretorno );
       ctransacao:=GetGridTransacao(acbrCte1.Conhecimentos.Items[i].Cte.Ide.nCT);
//{
       if ( trim(ctransacao)<>'' ) and
             ( trim(cretorno)<>'' )   and
             ( pos('ENCONTRADO',UPpercase(cretorno))=0 )
             then begin
             QNfe:=Sqltoquery('select moes_dtnfeauto,moes_chavenfe from movesto where moes_transacao='+Stringtosql(Trim(ctransacao))+
                              ' and moes_status<>''C''' );

             campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
// 08.12.16
               xmlstring:=ACBrCTe1.Conhecimentos.Items[i].XML;
               xmlstring:=FGeral.TiraBarra(xmlstring,chr(39),'"');

             Sistema.edit('movesto');
             if ( pos('AUTORIZADO',uppercase(cretorno))>0  ) then begin
               Sistema.setfield('moes_dtnfeauto',Sistema.hoje);
//               Sistema.setfield('moes_xmlnfe',acbrCte1.Conhecimentos.Items[i].XML) ;
//               if campo.tipo<>'' then // 16.07.10
//                  Sistema.setfield('moes_xmlnfet',acbrCte1.Conhecimentos.Items[i].XML) ;
// 08.12.16
               Sistema.setfield('moes_xmlnfe',xmlstring) ;
               if campo.tipo<>'' then // 16.07.10
                  Sistema.setfield('moes_xmlnfet',xmlstring) ;
               Sistema.setfield('moes_chavenfe',acbrCte1.Conhecimentos.Items[i].Cte.procCTe.chCTe);
             end;
// 08.12.10 -colocado o cancelamento da nfe na sefa mas no sac sem ter atualizado
//           o banco...primeira vez com dr. Tiago
             if pos('CANCELA',uppercase(cretorno))>0 then begin
               Sistema.setfield('moes_dtnfecanc',Sistema.hoje);
               Sistema.setfield('moes_xmlnfecanc',acbrCte1.Conhecimentos.Items[i].XML) ;
               Sistema.setfield('Moes_Usua_CancNfe',Global.Usuario.Codigo);
               Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
               Sistema.setfield('moes_dtnfereto',Sistema.hoje);
             end;
             if trim(cretorno)<>'' then begin
               if Datetoano(QNfe.fieldbyname('moes_dtnfeauto').AsDatetime,true) <= 1920 then begin
                 Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
                 Sistema.setfield('moes_dtnfereto',Sistema.hoje);
               end;
             end;
             Sistema.Post('moes_transacao='+stringtosql(ctransacao));
             FGeral.FechaQuery(QNfe);
       end;
//          }
     end;
     try
          Sistema.Commit;
     except
          Avisoerro('N�o foi poss�vel gravar o xml no banco de dados');
     end;

    END;

  end;


  TNotas.Free;
  if  acbrCte1.Conhecimentos.Count>0 then
    Sistema.EndProcess('Enviado(s) XML(s) gerado(s) em '+acbrCte1.Configuracoes.Arquivos.PathCTe)
  else
    Sistema.EndProcess('Sem conhecimentos para enviar XML(s)');

end;

function TFExpCte.GetCodigoUfIbge( xuf:string ):integer;
///////////////////////////////////////////////////////////
begin
  result:=41;
  if xUf='PR' then result:=41
  else if xuf='SC' then result:=42
  else if xuf='RS' then result:=43
  else if xuf='MG' then result:=31
  else if xuf='ES' then result:=32
  else if xuf='RJ' then result:=33
  else if xuf='SP' then result:=35
  else if xuf='MS' then result:=50
  else if xuf='MT' then result:=51
  else if xuf='GO' then result:=52
  else if xuf='DF' then result:=53
  else if xuf='RO' then result:=11
  else if xuf='AC' then result:=12
  else if xuf='AM' then result:=13
  else if xuf='RR' then result:=14
  else if xuf='PA' then result:=15
  else if xuf='AP' then result:=16
  else if xuf='TO' then result:=17
  else if xuf='MA' then result:=21
  else if xuf='PI' then result:=22
  else if xuf='CE' then result:=23
  else if xuf='RN' then result:=24
  else if xuf='PB' then result:=25
  else if xuf='PE' then result:=26
  else if xuf='AL' then result:=27
  else if xuf='SE' then result:=28
  else if xuf='BA' then result:=29;
end;


procedure TFExpCte.FechaArquivosXML;
///////////////////////////////////////////
begin
    CloseFile(Arquivo);
    CloseFile(ArqClientes);
    CloseFile(ArqProdutos);
    CloseFile(ArqTransp);
    sistema.endprocess('Processo Interrompido');

end;

function TFExpCte.TiraString(stringatirar,  stringdeondetirar: string): string;
////////////////////////////////////////////////////////////////////////////////////
var x:integer;
begin
  x:=pos(stringatirar,stringdeondetirar);
  if x>0 then result:=copy(stringdeondetirar,1,x-1) else result:=stringdeondetirar;
// 27.11.12 - numa nota da Giacomoni sem virgula ficou com xlogr em branco
  if trim(result)='' then result:=stringdeondetirar
end;

function TFExpCte.GetTag(ctag, xml: string): string;
//////////////////////////////////////////////////////////
var cbuscai,cbuscaf:string;
    inicio,fim:integer;
begin
//  result:='N�o encontrado tag '+ctag;
  result:='';
  cbuscai:='<'+ctag+'>';
  cbuscaf:='</'+ctag+'>';
  inicio:=ansipos( Uppercase(cbuscai),Uppercase(XML) );
  fim:=ansipos( Uppercase(cbuscaf),Uppercase(XML) );
  if (inicio>0) and (fim>0) then
//    result:=copy(xml,inicio+length(cbuscai),(fim)-(inicio+length(cbuscai)) );
// 18.02.13
    result:=copy(xml,inicio+length(cbuscai),(fim)-(inicio+length(cbuscai)) );
//  else
//    AvisoErro('N�o encontrado tag '+ctag);

end;

function TFExpCte.GetRetorno(xml: string): string;
////////////////////////////////////////////////////////////
const cautorizado:string='autorizado o uso de ct-e';
const cautorizadooutro:string='autorizado o uso da ct-e';
const ccancelada:string='Cancelamento';

begin
  if ( ansipos(Uppercase(ccancelada),Uppercase(XML))>0 ) then
    result:=GetTag('xMotivo',xml)
  else if ansipos(Uppercase(cautorizado),Uppercase(XML))>0 then
    result:='NF-e Autorizada'
// 14.06.10
  else if ansipos(Uppercase(cautorizadooutro),Uppercase(XML))>0 then
    result:='NF-e Autorizada'
  else
    result:=GetTag('xMotivo',xml);
end;

procedure TFExpCte.AtualizaGrid(nf: integer; xretorno: string);
///////////////////////////////////////////////////////////////////////
var i:integer;
begin
  for i:=1 to Grid.RowCount do begin
     if strtointdef(Grid.Cells[Grid.getcolumn('moes_numerodoc'),i],0) = nf then begin
        Grid.Cells[Grid.getcolumn('retorno'),i]:=xretorno;
        break;
     end;
  end;
end;

function TFExpCte.GetGridTransacao(nf: integer): string;
/////////////////////////////////////////////////////////////
var i:integer;
begin
  result:='';
  for i:=1 to Grid.RowCount do begin
     if strtointdef(Grid.Cells[Grid.getcolumn('moes_numerodoc'),i],0) = nf then begin
        result:=Grid.Cells[Grid.getcolumn('moes_transacao'),i];
        break;
     end;
  end;
end;

procedure TFExpCte.bgerenciarClick(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
   FGerenciaCTe.Execute( EdNotas.text );

end;

// 08.12.16
procedure TFExpCte.bconsutawebserClick(Sender: TObject);
//////////////////////////////////////////////////////////
begin
  FSiteWebservices.execute('C');

end;

end.
