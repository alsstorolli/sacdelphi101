unit expnfse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrBase, ACBrDFe, ACBrCTe, Vcl.Grids,
  SqlDtg, Vcl.StdCtrls, Vcl.Mask, SQLEd, Vcl.Buttons, SQLBtn, alabel, SQLGrid,
  Vcl.ExtCtrls, ACBrNFSe, SqlExpr, pnfsConversao,pcnconversao, Vcl.ComCtrls,
  ACBrNFSeDANFSeClass, ACBrNFSeDANFSeRLClass, ACBrDFeReport;

type
  TFExpNfse = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bExecutar: TSQLBtn;
    bSair: TSQLBtn;
    bexpxml: TSQLBtn;
    bgerenciar: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Edtermino: TSQLEd;
    EdInicio: TSQLEd;
    pgrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    Edformaemissao: TSQLEd;
    EdNumeronotas: TSQLEd;
    EdAmbiente: TSQLEd;
    EdExportadas: TSQLEd;
    EdNotas: TSQLEd;
    ACBrNFSe1: TACBrNFSe;
    RichEdit1: TRichEdit;
    bconsultapref: TSQLBtn;
    ACBrNFSeDANFSeRL1: TACBrNFSeDANFSeRL;
    procedure EdterminoValidate(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdAmbienteValidate(Sender: TObject);
    procedure EdNotasValidate(Sender: TObject);
    procedure EdformaemissaoExitEdit(Sender: TObject);
    procedure bexpxmlClick(Sender: TObject);
    procedure bconsultaprefClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute( numeronota:integer=0 ; situacaonotas:string='');
    function ContaNotas(Grid:TSqldtgrid):integer;
    procedure EnviaConsultaSefa(op:string);
    function GetRetorno(xml:string):string;
    procedure AtualizaGrid(nf:integer ; xretorno:string);
    function GetGridTransacao(nf:integer):string;
    function GetTag(ctag,xml:string):string;
  end;

var
  FExpNfse: TFExpNfse;
  tiposdemovimento,xsituacaonotas:string;
  xnumeronota:integer;
  Q:Tsqlquery;
  xmlstring:WideString;

const dirnfse:string='\NFSSAC';

implementation

{$R *.dfm}

uses geral,SqlSis,SqlFun, sintegra, Unidades, fornece, Estoque, munic, represen,
  Natureza, consulta;

// 26.06.17
procedure TFExpNfse.AtualizaGrid(nf: integer; xretorno: string);
//////////////////////////////////////////////////////////////////
var i:integer;
begin
  for i:=1 to Grid.RowCount do begin
     if strtointdef(Grid.Cells[Grid.getcolumn('moes_numerodoc'),i],0) = nf then begin
        Grid.Cells[Grid.getcolumn('retorno'),i]:=xretorno;
        break;
     end;
  end;
end;

procedure TFExpNfse.bconsultaprefClick(Sender: TObject);
begin

   EnviaConsultaSefa('C');


end;

procedure TFExpNfse.bexpxmlClick(Sender: TObject);
begin

   EnviaConsultaSefa('E');


end;

function TFExpNfse.ContaNotas(Grid: TSqldtgrid): integer;
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

procedure TFExpNfse.EdAmbienteValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var Q:Tsqlquery;
    sqltran,sqlconfmov:string;
begin
  sqltran:='';
  sqlconfmov:='';
  if FGeral.ConfiguradoECF then
    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));

  Q:=sqltoquery('select movesto.moes_numerodoc,clientes.clie_razaosocial,clientes.clie_tipo,clientes.clie_endres,clientes.clie_uf from movesto'+
                ' left join clientes on (clie_codigo=moes_tipo_codigo)'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
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

// 06.06.17
procedure TFExpNfse.EdformaemissaoExitEdit(Sender: TObject);
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
                'clientes.clie_uf,clientes.clie_nome,clientes.clie_cnpjcpf,clientes.clie_foneres,clientes.clie_email,'+
                'clientes.Clie_endrescompl,clientes.Clie_cida_codigo_res,clientes.clie_foneres,clientes.clie_bairrores,clientes.clie_cepres'+
                ' from movesto'+
                ' inner join clientes on (clie_codigo=moes_tipo_codigo)'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                 sqlconfmov+
                ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                sqltran+sqlexp+sqlnotas+
                ' order by moes_datamvto,moes_vispra' );
  if Q.eof then begin
    Avisoerro('Nada encontrado para exportação');
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

procedure TFExpNfse.EdNotasValidate(Sender: TObject);
///////////////////////////////////////////////////////
begin
   if not EdNotas.IsEmpty then begin
     EdExportadas.enabled:=false;
     EdExportadas.text:='A';
   end else begin
     EdExportadas.enabled:=true;
   end;

end;

procedure TFExpNfse.EdterminoValidate(Sender: TObject);
begin
    if EdTermino.asdate<EdInicio.asdate then
      EdTermino.invalid('Término deve ser posterior ao inicio');

end;

procedure TFExpNfse.EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
begin
  FGeral.Limpaedit(EdUnid_codigo,key);

end;

procedure TFExpNfse.EnviaConsultaSefa(op: string);
//////////////////////////////////////////////////////
var linha,transacoes,sep,codmuni,codmuniemitente,chaveacesso,vistaprazo,tipodoc,formatodanfe,codigonumerico,
    Ambiente,Finalidade,versao,numero,
    nomepais,versaolayout,qtipo,cnpjtran,cpftran,rntc,
    codigoproduto,redubasetexto,modbc,modbcst,caracteresespeciais,dadosadicionais,cretorno,
    ctransacao,senhacertificado,cfopind,ConsumidorFinal,TiposNumeracaoSaida,cretornoerro,ces,
    pathenvioexterno ,arquivoexterno,arquivoexternoret,pathenvioexternoretorno,pathretornoexterno,
    drive,codigoser:string;
    Q1,QDesti,QPend,QNfe,QItens,QRem,Q71:TSqlquery;
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


    function GetSerie(serie,tipoemissao:string):string;
    ////////////////////////////////////////////////////
    begin
      if trim(uppercase(serie))='U' then
        result:=''
      else if tipoemissao='3' then  // 05.11.2012 - Contingencia via Scan
        result:='901'
      else
        result:=trim(serie);
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
// 02.12.08 - 'ISENTO' É SOMENTE SE for contribuiente do icms mas nao estiver obrigado a ter
//                     inscrição estadual  // no do produtor rural deixar em branco
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
          Avisoerro('Senha do certificado não informada');
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
          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Endereço '+ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.xLgr+' sem numero');
          result:=false;
        end else if trim(ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.xBairro)='' then begin
          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Endereço '+ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.xLgr+' sem bairro');
          result:=false;
        end else if ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.CEP=0 then begin
          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Endereço '+ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.xLgr+' sem Cep');
          result:=false;
// 19.05.11
//        end else if ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.fone then begin
//          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Cliente '+ListaNotas.Conhecimentos.Items[x].Cte.Dest.xNome+' sem telefone');
//          result:=false;
//        end else if ( trim(ListaNotas.Conhecimentos.Items[x].Cte.Transp.veicTransp.placa )='') and (ListaNotas.Conhecimentos.Items[x].Cte.Transp.Transporta.CNPJCPF<>'') then begin
//          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Veículo sem placa');
//          result:=false;
// 11.10.11 - Cenitech pegou - não dá retorno na sefa e nem da erro de validacao
//        end else if ( length(trim(ListaNotas.Conhecimentos.Items[x].Cte.Transp.veicTransp.placa ))<>7 ) and (ListaNotas.Conhecimentos.Items[x].Cte.Transp.Transporta.CNPJCPF<>'') then begin
//          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Veículo com placa diferente de 7 caracteres');
//          result:=false;
//        end else if (trim(ListaNotas.Conhecimentos.Items[x].Cte.Transp.veicTransp.UF )='')  and (ListaNotas.Conhecimentos.Items[x].Cte.Transp.Transporta.CNPJCPF<>'') then begin
//          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Placa sem UF');
//          result:=false;
// 15.04.11
//        end else if length(trim(ListaNotas.Conhecimentos.Items[x].Cte.Dest.EnderDest.fone )) < 5 then begin
//          Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+' Destinatário sem telefone completo');
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
            Avisoerro('Nota '+inttostr(ListaNotas.Conhecimentos.Items[x].Cte.Ide.cCT)+
            ' Produtos '+Listaprodutos+' sem NCM no cadastro de Produtos' );

      end;

    end;

//{



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

//  if not DirectoryExists( dirnfse ) then
//      ForceDirectories( dirnfse  );

   ACBrNFSe1.Configuracoes.Arquivos.PathNFSe:= dirnfse;

  acbrNFSe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(EdUnid_codigo.text);
  acbrNFSe1.Configuracoes.Arquivos.PathGer:=dirnfse;
  acbrNFSe1.Configuracoes.Arquivos.PathSalvar:=dirnfse;

// 01.12.09 6 hs da matina...
  if EdAmbiente.text='1' then
      ACBrNFSe1.Configuracoes.WebServices.Ambiente:=taProducao
  else
    ACBrNFSe1.Configuracoes.WebServices.Ambiente:=taHomologacao;
  ACBrNFSe1.Configuracoes.Arquivos.PathCan:=dirnfse;

  ACBrNFSe1.Configuracoes.Arquivos.PathSalvar:=dirnfse;

  if Q=nil then exit;
  if trim(Q.SQL.Text)='' then exit;
  if trim( EdUNid_codigo.resultfind.fieldbyname('unid_cep').asstring )='' then begin
    Avisoerro('Cep no cadastro da unidade está sem preencher');
    exit;
  end;


  IF OP='E' THEN BEGIN  // 01.03.12

    if (Global.Usuario.Codigo=900) and (global.Usuario.Nome='André') then begin
      if Confirma('Checar certificado ?') then begin
        if (ACBrNFSe1.SSL.CertDataVenc>Sistema.Hoje) and
           ( trunc(ACBrNFSe1.SSL.CertDataVenc-Sistema.Hoje)<=30 )
          then begin
      //    Avisoerro('Certificado digital '+ACBrNFSe1.Configuracoes.Certificados.SelecionarCertificado+' vencido em '+Datetostr(ACBrNFSe1.Configuracoes.Certificados.DataVenc));
      //    Avisoerro('Certificado digital numero de série '+ACBrNFSe1.Configuracoes.Certificados.NumeroSerie+' vencido em '+Datetostr(ACBrNFSe1.Configuracoes.Certificados.DataVenc));
          Avisoerro('Certificado digital '+copy(ACBrNFSe1.SSL.CertRazaoSocial,1,40)+' VENCE em '+Datetostr(ACBrNFSe1.SSL.CertDataVenc));
        end;
//        if ACBrNFSe1.Configuracoes.Certificados.DataVenc<EdInicio.asdate then begin
// 10.02.14
        if ACBrNFSe1.SSL.CertDataVenc<Sistema.hoje then begin
      //    Avisoerro('Certificado digital '+ACBrNFSe1.Configuracoes.Certificados.SelecionarCertificado+' vencido em '+Datetostr(ACBrNFSe1.Configuracoes.Certificados.DataVenc));
      //    Avisoerro('Certificado digital numero de série '+ACBrNFSe1.Configuracoes.Certificados.NumeroSerie+' vencido em '+Datetostr(ACBrNFSe1.Configuracoes.Certificados.DataVenc));
          Avisoerro('Certificado digital '+copy(ACBrNFSe1.SSL.CertRazaoSocial,1,40)+' VENCIDO em '+Datetostr(ACBrNFSe1.SSL.CertDataVenc));
          exit;
        end;
      end;

    end else begin

  // 17.06.11 - Abra
  /////////////////////////
      if (ACBrNFSe1.SSL.CertDataVenc>Sistema.Hoje) and
         ( trunc(ACBrNFSe1.SSL.CertDataVenc-Sistema.Hoje)<=30 )
        then begin
    //    Avisoerro('Certificado digital '+ACBrNFSe1.Configuracoes.Certificados.SelecionarCertificado+' vencido em '+Datetostr(ACBrNFSe1.Configuracoes.Certificados.DataVenc));
    //    Avisoerro('Certificado digital numero de série '+ACBrNFSe1.Configuracoes.Certificados.NumeroSerie+' vencido em '+Datetostr(ACBrNFSe1.Configuracoes.Certificados.DataVenc));
        Avisoerro('Certificado digital '+copy(ACBrNFSe1.SSL.CertRazaoSocial,1,40)+' VENCE em '+Datetostr(ACBrNFSe1.SSL.CertDataVenc));
      end;
//      if ACBrNFSe1.Configuracoes.Certificados.DataVenc<EdInicio.asdate then begin
// 10.02.14
      if ACBrNFSe1.SSL.CertDataVenc<Sistema.hoje then begin
    //    Avisoerro('Certificado digital '+ACBrNFSe1.Configuracoes.Certificados.SelecionarCertificado+' vencido em '+Datetostr(ACBrNFSe1.Configuracoes.Certificados.DataVenc));
    //    Avisoerro('Certificado digital numero de série '+ACBrNFSe1.Configuracoes.Certificados.NumeroSerie+' vencido em '+Datetostr(ACBrNFSe1.Configuracoes.Certificados.DataVenc));
        Avisoerro('Certificado digital '+copy(ACBrNFSe1.SSL.CertRazaoSocial,1,40)+' VENCIDO em '+Datetostr(ACBrNFSe1.SSL.CertDataVenc));
        exit;
      end;
    end;
  END;

//////////////////

//  if (xnumeronota=0) and (xsituacaonotas='') then
//    if not confirma('Confirma exportação do arquivo XML ?') then exit;

//  AssignFile(Arquivo, EdPasta.text+'\'+nomearqtexto+EdUnid_codigo.text+'.SAC' );
  caracteresespeciais:='/-.;';
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
//  NotasE:=ACBrNFSe1.Create(self);

  if OP='E' then
    Numlote:=FGEral.GetContador('LOTENFSE'+EdUnid_codigo.text,false);

  ACBrNFSe1.NotasFiscais.Clear;

// 23.04.10 - emitente em outro estado que nao seja PR
  if trim(EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString)<>'' then
    ACBrNFSe1.Configuracoes.WebServices.UF:=EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString
  else
    ACBrNFSe1.Configuracoes.WebServices.UF:='PR';
  ACBrNFSe1.Configuracoes.Geral.CodigoMunicipio    := strtoint(FCidades.GetCodigoIBGE(EdUNid_codigo.resultfind.fieldbyname('unid_cida_codigo').AsInteger)); // 4118501
  ACBrNFSe1.Configuracoes.Geral.Emitente.RazSocial := EdUNid_codigo.resultfind.fieldbyname('unid_razaosocial').AsString;
  ACBrNFSe1.Configuracoes.Geral.Emitente.CNPJ      := EdUNid_codigo.resultfind.fieldbyname('unid_cnpj').AsString;
//  ACBrNFSe1.Configuracoes.Geral.Emitente.InscMun   := EdUNid_codigo.resultfind.fieldbyname('unid_inscricaomunicipal').AsString;
// 29.06.17 a I.M. é usado como Inscricao do substituto substituicao tributaria
  ACBrNFSe1.Configuracoes.Geral.Emitente.InscMun   := EdUNid_codigo.resultfind.fieldbyname('Unid_regjuntacomercial').AsString;
  ACBrNFSe1.Configuracoes.Geral.Emitente.WebUser   := FGeral.GetConfig1AsString('UserWebNFSE' );
  ACBrNFSe1.Configuracoes.Geral.Emitente.WebSenha  := FGeral.GetConfig1AsString('SenhaWebNFSE' );
  ACBrNFSe1.Configuracoes.Geral.Salvar   := True;
  ACBrNFSe1.Configuracoes.Geral.SetConfigMunicipio;

//////////////////////
  TiposNumeracaoSaida:=Global.CodEntradaImobilizado+';'+Global.CodCompraConsignado+';'+
                       Global.CodDevolucaodeRemessa+';'+Global.CodCompraProdutor+';'+
                       FGeral.GetConfig1AsString('TIPOSENUMSAIDA');
  if not Q.eof then begin
    ACBrNFSe1.Configuracoes.Arquivos.PathNFSe:=dirnfse+'\'+
                                               strzero(Datetoano(Q.fieldbyname('moes_dataemissao').AsDateTime,true),4)+
                                               strzero(Datetomes(Q.fieldbyname('moes_dataemissao').AsDateTime),2);
    if not DirectoryExists( ACBrNFSe1.Configuracoes.Arquivos.PathNFSe ) then
      ForceDirectories( ACBrNFSe1.Configuracoes.Arquivos.PathNFSe );
  end;
  Acbrnfse1.Configuracoes.Geral.PathIniCidades:=dirnfse;
  Acbrnfse1.Configuracoes.Geral.PathIniProvedor:=dirnfse;

  while not Q.eof do begin

/////////////////////////////////////////////////////////////
//    ACBrNFSe1.NotasFiscais.Add.Cte.Ide.Create(ACBrNFSe1.NotasFiscais.Add.Cte);
//////////////////////////////////////////////////////////////////
    Sistema.beginprocess('Gerando arquivos XML - 3 ');

    with  ACBrNFSe1.NotasFiscais.Add.NFSe do
    begin

      if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin
        datam:=Q.fieldbyname('moes_datamvto').asdatetime;
        tipodoc:='0';
      end else begin
        datam:=Q.fieldbyname('moes_dataemissao').asdatetime;
        campo:=Sistema.GetDicionario('movesto','moes_datasaida');
        if Campo.Tipo<>'' then begin
            if Q.fieldbyname('moes_datasaida').asdatetime>Q.fieldbyname('moes_dataemissao').asdatetime then
              datam:=Q.fieldbyname('moes_datasaida').asdatetime;
        end else begin
           if Q.fieldbyname('moes_datamvto').asdatetime>Q.fieldbyname('moes_dataemissao').asdatetime then
             datam:=Q.fieldbyname('moes_datamvto').asdatetime;
        end;
        tipodoc:='1';
      end;

      QItens:=sqltoquery('select move_qtde,move_venda from movestoque inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                     ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                     ' left join tamanhos on (tama_codigo=move_tama_codigo)'+
                     ' left join cores on (core_codigo=move_core_codigo)'+
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
        vlrdesco:= totalitens - (Q.fieldbyname('moes_vlrtotal').AsCurrency-Q.fieldbyname('moes_valoripi').AsCurrency-Q.fieldbyname('moes_frete').AsCurrency-Q.fieldbyname('moes_outrasdesp').ascurrency)
      else
        vlrdesco:=0;
      if Q.fieldbyname('moes_peracres').ascurrency>0 then
        Despacessorias:=Q.fieldbyname('moes_vlrtotal').AsCurrency-totalitens+vlrdesco-Q.fieldbyname('moes_valoripi').AsCurrency
      else
        Despacessorias:=0;
      Despacessorias:=despacessorias+Q.fieldbyname('moes_outrasdesp').ascurrency;

      dadosadicionais:='';
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
// 12.08.13 - ajustado para nao imprimir os vencimentos ref. comissão a pagar gerada na mesma transacao
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
      if ( Global.Topicos[1361] ) and (Q.fieldbyname('moes_tipocad').asstring='C') then
        dadosadicionais:=dadosadicionais+' Nome Fantasia '+(Q.fieldbyname('clie_nome').asstring) ;

      if trim(Q.fieldbyname('moes_mensagem').asstring)<>'' then begin
        dadosadicionais:='';
        if trim(dadosadicionais)<>'' then
          dadosadicionais:=dadosadicionais+' - '+Q.fieldbyname('moes_mensagem').asstring
        else
          dadosadicionais:=dadosadicionais+Q.fieldbyname('moes_mensagem').asstring;
      end;
{
      if trim(dadosadicionais)<>'' then
        with compl.ObsCont.Add do begin
          xCampo:='dados adicionais';
          xTexto:=dadosadicionais;
        end;
}
      FGeral.FechaQuery(QPend);

//        IdentificacaoRps.Numero := IntToStr(NumLote);
        IdentificacaoRps.Numero := Q.fieldbyname('moes_numerodoc').asstring;
        IdentificacaoRps.Serie  := GetSerie(Q.fieldbyname('moes_serie').asstring,EdFormaEmissao.text);
        IdentificacaoRps.Tipo   := trRPS;
        DataEmissao             := Sistema.Hoje;
        NaturezaOperacao        := no1; // StrToNaturezaOperacao(ok, cNaturezaOperacao);// no1;//  noTributacaoNoMunicipio;
//        RegimeEspecialTributacao := retMicroempresaMunicipal;
        OptanteSimplesNacional  := snNao;
        IncentivadorCultural    := snNao;
        Status                  := srNormal;
// 03.07.17
        OutrasInformacoes       := Q.fieldbyname('moes_transacao').asstring;
        Protocolo               := Q.fieldbyname('moes_protodpec').asstring;

        if EdAmbiente.Text = '1' then
          Producao := snSim
        else
          Producao := snNao;

        codigoser:=FGeral.GetConfig1AsString('TipoServicoNFSe' + Global.CodigoUnidade);
        Servico.Valores.ValorServicos          := FloatToCurr(Q.FieldByName('moes_vlrtotal').AsFloat);
        Servico.Valores.ValorDeducoes          := 0.00;
        Servico.Valores.ValorPis               := FloatToCurr(Q.FieldByName('Moes_valorPis'   ).AsFloat);
        Servico.Valores.ValorCofins            := FloatToCurr(Q.FieldByName('Moes_valorCofins').AsFloat);
        Servico.Valores.ValorInss              := 0.00;
        Servico.Valores.ValorIr                := FloatToCurr(Q.FieldByName('Moes_valorIR'  ).AsFloat);
        Servico.Valores.ValorCsll              := FloatToCurr(Q.FieldByName('Moes_valorCsl').AsFloat);
        Servico.Valores.OutrasRetencoes        := 0.00;
        Servico.Valores.DescontoIncondicionado := 0.00;
        Servico.Valores.DescontoCondicionado   := 0.00;
        Servico.Valores.BaseCalculo            := FloatToCurr(Q.FieldByName('Moes_BaseIss'    ).AsFloat);

//        if ConfigUnidade.CodNFSe = '02' then
//          Servico.Valores.Aliquota := FloatToCurr(Q.FieldByName('Mpsc_PercIss').AsFloat / 100)
//        else
          Servico.Valores.Aliquota := FloatToCurr(Q.FieldByName('Moes_PerIss'  ).AsFloat);

        if Q.FieldByName('Moes_perIss').AsFloat > 0 then        begin
          Servico.Valores.IssRetido      := stNormal;
          Servico.Valores.ValorIss       := FloatToCurr(Q.FieldByName('moes_valoriss').AsFloat);
          Servico.Valores.ValorIssRetido := 0.00;
        end
        else if Q.FieldByName('Moes_valorIss').AsFloat>0 then
        begin
          Servico.Valores.IssRetido      := stRetencao;
          Servico.Valores.ValorIss       := 0.00;
          Servico.Valores.ValorIssRetido := FloatToCurr(Q.FieldByName('Moes_valorIss').AsFloat);
        end else
        begin
          Servico.Valores.IssRetido      := stNormal;
          Servico.Valores.ValorIss       := 0;
          Servico.Valores.ValorIssRetido := 0.00;
        end;

        Servico.Valores.ValorLiquidoNfse  := FloatToCurr(Q.FieldByName('moes_vlrtotal').AsFloat);
        Servico.ItemListaServico          := codigoser; // '14.01' '4.02'
        Servico.CodigoCnae                := '';
//        Servico.CodigoTributacaoMunicipio := ConfigUnidade.CodTribMunicipio;  //Servico.CodigoTributacaoMunicipio := '4520001';
// ver do que se trata
        Servico.Discriminacao             := FEstoque.GetDescricao(codigoser);
        Servico.CodigoMunicipio           := codmuniemitente;
        Servico.ExigibilidadeISS          := exiExigivel;
        Servico.CodigoPais                := 1058;

//        Servico.MunicipioIncidencia := StrToIntDef(edtCodCidade.Text, 0);
//        with Servico.ItemServico.Add do
//        begin
//          Descricao     := sServ;
//          Quantidade    :=
//          ValorUnitario :=
//        end;

        {Prestador}
        Prestador.Cnpj               := EdUNid_codigo.resultfind.fieldbyname('unid_cnpj').AsString;
//        Prestador.InscricaoMunicipal := StrToStrNumeros(EdUNid_codigo.resultfind.fieldbyname('unid_inscricaomunicipal').AsString) ;
// 03.07.17 a I.M. é usado como Inscricao do substituto substituicao tributaria
        Prestador.InscricaoMunicipal := EdUNid_codigo.resultfind.fieldbyname('Unid_regjuntacomercial').AsString;
//        Prestador.Senha              := FGeral.GetConfig1AsString('SenhaWebNFSE' + Global.CodigoUnidade);
//        Prestador.FraseSecreta       :=
        Prestador.cUF                := strtoint(copy(codmuniemitente,1,2));

        {Tomador}
//        Tomador.IdentificacaoTomador.InscricaoEstadual := '123456';
//        Tomador.IdentificacaoTomador.InscricaoMunicipal   := '1733160024';

        if Q.Fieldbyname('Clie_Tipo').AsString = 'F' then
          Tomador.RazaoSocial := Q.Fieldbyname('clie_nome').AsString
        else
          Tomador.RazaoSocial := Q.Fieldbyname('clie_razaosocial').AsString;

        Tomador.IdentificacaoTomador.CpfCnpj := Q.Fieldbyname('clie_cnpjcpf').AsString;
        Tomador.Endereco.Endereco            := Q.Fieldbyname('clie_endres').AsString;
        Tomador.Endereco.Numero              := 'S/N';
        Tomador.Endereco.Complemento         := Q.Fieldbyname('Clie_endrescompl').AsString;
        Tomador.Endereco.Bairro              := Q.Fieldbyname('clie_bairrores').AsString;
        Tomador.Endereco.CodigoMunicipio     := FCidades.GetCodigoIBGE( Q.Fieldbyname('Clie_cida_codigo_res').AsInteger );
        Tomador.Endereco.UF                  := Q.Fieldbyname('clie_uf').AsString;
        Tomador.Endereco.CEP                 := Q.Fieldbyname('clie_cepres').AsString;
        Tomador.Contato.Telefone             := Q.Fieldbyname('clie_foneres').AsString;

        if EdAmbiente.Text = '1' then
          Tomador.Contato.Email := Q.Fieldbyname('clie_email').AsString
        else
          Tomador.Contato.Email := 'andreluis779@gmail.com';

//        if UpperCase(Q.GetString('clie_nacionalidade')) = 'BRASILEIRA' then
          Tomador.Endereco.xPais := 'BRASIL';
//        else
//          Tomador.Endereco.xPais := UpperCase(Q.GetString('clie_nacionalidade'));


    end;  // do mestre do ACBrNFSe1

//////////////////////////////////
// 24.11.08
    Sistema.edit('movesto');
    Sistema.setfield('moes_dtnfeexp',Sistema.hoje);
    Sistema.setfield('moes_nfeexp','S');
    Sistema.Post('moes_transacao='+stringtosql(Q.fieldbyname('moes_transacao').asstring));

    Q.Next;   // NO MESTRE


  end; //  ref. as notas o 'mestre'



  if  ACBrNFSe1.NotasFiscais.Count>0 then begin

    Sistema.Commit;
    Sistema.beginprocess('Gerando arquivos XML - 5 ');

    ACBrNFSe1.NotasFiscais.GerarNFSe;

    Sistema.beginprocess('Validando e Assinando arquivos XML');

    drive:=ExtractFileDrive(Application.ExeName);

/////////////////////
// 16.08.12
    Sistema.beginprocess('Salvando '+inttostr(ACBrNFSe1.NotasFiscais.Count)+ ' arquivos XML assinados');
    for i:=0 to ACBrNFSe1.NotasFiscais.Count-1 do begin
//      ACBrNFSe1.NotasFiscais.Items[i].XML.SaveToFile(ExtractFileDir(application.ExeName)+ACBrNFSe1.NotasFiscais.Items[i].XML.CteChave+'-NFe.xml');
      ACBrNFSe1.NotasFiscais.Items[i].GravarXML(ACBrNFSe1.Configuracoes.Arquivos.PathNFSe+'\'+ACBrNFSe1.NotasFiscais.Items[i].NFSe.Numero+FGeral.TiraBarra( Datetostr(ACBrNFSe1.NotasFiscais.Items[i].NFSe.DataEmissao) )+'-NFSe.xml');
      if trim(pathenvioexterno)<>'' then
        ACBrNFSe1.NotasFiscais.Items[i].GravarXML(PathenvioExterno+'\'+ACBrNFSe1.NotasFiscais.Items[i].NFse.Numero+FGeral.TiraBarra( Datetostr(ACBrNFSe1.NotasFiscais.Items[i].NFSe.DataEmissao) )+'-NFSe.xml');
    end;

    IF OP='E' THEN BEGIN
      if EdFormaemissao.text<>'2' then begin
        Sistema.beginprocess('Enviando arquivos XML para Prefeitura');

// 21.08.12
        ACBrNFSe1.Configuracoes.WebServices.Tentativas:=2;
        xmlaux:=TSTringList.create;

        cretornoerro:='';
        ChecaStatusSefa:=true;

        if ChecaStatusSefa  then begin

          Numlote:=FGEral.GetContador('LOTENFSE'+EdUnid_codigo.text,false);

            try
              ACBrNFSe1.Enviar(NumLote,false);
            except
            end;


          Sistema.beginprocess('Verificando retornos da Prefeitura');
          for i:=0 to ACBrNFSe1.NotasFiscais.Count-1 do begin

//         showmessage('codigo verificacao:'+ ACBrNFSe1.NotasFiscais.Items[i].NFSe.CodigoVerificacao );
//         showmessage('NOmearq           :'+ ACBrNFSe1.NotasFiscais.Items[i].NomeArq );
//         showmessage('Protocolo         :'+ ACBrNFSe1.NotasFiscais.Items[i].NFSe.Protocolo );


           Sistema.edit('movesto');
           Sistema.setfield('moes_protodpec',ACBrNFSe1.NotasFiscais.Items[i].NFSe.Protocolo);
           Sistema.Post('moes_transacao='+stringtosql(ACBrNFSe1.NotasFiscais.Items[i].NFSe.OutrasInformacoes));
           Sistema.Commit;

           Sistema.beginprocess('Verificando retornos do lote '+ACBrNFSe1.NotasFiscais.Items[i].NFSe.IdentificacaoRps.Numero);

           ACBrNFSe1.ConsultarSituacao(ACBrNFSe1.NotasFiscais.Items[i].NFSe.Protocolo,ACBrNFSe1.NotasFiscais.Items[i].NFSe.IdentificacaoRps.Numero);

           cretorno:=GetRetorno( ACBrNFSe1.notasfiscais.items[i].XMLNFSe );

//            showmessage(   ACBrNFSe1.notasfiscais.items[i].XMLNFSe );
            richedit1.Lines.Text:=  ( ACBrNFSe1.notasfiscais.items[i].XMLNFSe );

            aviso( 'parado' );

            if trim(cretorno)='' then cretorno:=cretornoerro;
            AtualizaGrid( strtoint(ACBrNFSe1.notasfiscais.items[i].NFSe.Numero),cretorno );
            ctransacao:=GetGridTransacao(strtoint(ACBrNFSe1.NotasFiscais.Items[i].NFSe.IdentificacaoRps.Numero));
            if ( trim(ctransacao)<>'' ) and
               ( trim(cretorno)<>'' )   and
               ( EdFormaemissao.Text<>'4' )
//               ( pos('ENCONTRADO',UPpercase(cretorno))=0 )
               then begin

               QNfe:=Sqltoquery('select moes_dtnfeauto,moes_chavenfe from movesto where moes_transacao='+Stringtosql(Trim(ctransacao))+
                                ' and moes_status<>''C''' );
               Sistema.edit('movesto');
               campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
               xmlstring:=ACBrNFSe1.NotasFiscais.Items[i].XML;
               xmlstring:=FGeral.TiraBarra(xmlstring,chr(39),'"');
               if pos('AUTORIZADO',uppercase(cretorno))>0 then begin
                 Sistema.setfield('moes_dtnfeauto',Sistema.hoje);
//                 Sistema.setfield('moes_xmlnfe',ACBrNFSe1.NotasFiscais.Items[i].XML) ;
                 Sistema.setfield('moes_xmlnfe',xmlstring) ;
                 Sistema.setfield('moes_protodpec',ACBrNFSe1.WebServices.ConsLote.Protocolo);
                 Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
                 if trim(pathenvioexterno)<>'' then
                     Sistema.setfield('moes_xmlnfet',xmlstring)
                 else if campo.tipo<>'' then // 16.07.10
                   Sistema.setfield('moes_xmlnfet',xmlstring) ;

//                 if trim(pathenvioexterno)<>'' then
                   Sistema.setfield('moes_chavenfe',copy(ACBrNFSe1.NotasFiscais.Items[i].NFSe.InfID.ID,4,44));
//                 else
  //                 Sistema.setfield('moes_chavenfe',ACBrNFSe1.NotasFiscais.Items[i].NFse.irocCTe.chCTe);
               end else if trim(cretorno)<>''  then begin
                 if Datetoano(QNfe.fieldbyname('moes_dtnfeauto').AsDatetime,true) <= 1920 then begin
// 23.08.12
//                   if trim(pathenvioexterno)<>'' then
//                     Sistema.setfield('moes_xmlnfet',xmlaux.Text)
//                   else if campo.tipo<>'' then // 16.07.10
//                     Sistema.setfield('moes_xmlnfet',ACBrNFSe1.NotasFiscais.Items[i].XML) ;
// 08.12.16
               xmlstring:=ACBrNFSe1.NotasFiscais.Items[i].XML;
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
//              cretorno:=GetRetorno( ACBrNFSe1.WebServices.EnviarDPEC.xMotivo
// 05.11.12 - mudado do retorno
//              cretorno:= ACBrNFSe1.WebServices.EnviarDPEC.xMotivo;

//              ACBrNFSe1.WebServices.EnviarDPEC.xMotivo;
//              ACBrNFSe1.NotasFiscais.Items[i].Alertas
//               mandar o xml da dpeC e nao do gerado...

              if trim( cretorno ) ='' then
//                if trim( ACBrNFSe1.WebServices.EnviarDPEC.nRegDPEC )='' then
//                  cretorno:='sem protocolo de envio ao DPEC';

  //            avisoerro('RetWs :'+UTF8Encode(ACBrNFSe1.WebServices.EnviarDPEC.RetWS));

              AtualizaGrid( strtoint(ACBrNFSe1.NotasFiscais.Items[i].NFSe.Numero),cretorno );
              campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
              Sistema.edit('movesto');
              Sistema.setfield('moes_xmlnfe',ACBrNFSe1.NotasFiscais.Items[i].XML) ;
              if campo.tipo<>'' then // 16.07.10
                Sistema.setfield('moes_xmlnfet',ACBrNFSe1.NotasFiscais.Items[i].XML) ;
              Sistema.setfield('moes_chavenfe',ACBrNFSe1.NotasFiscais.Items[i].NFSe.ChaveNFSe);
              Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
              Sistema.setfield('moes_dtnfereto',Sistema.hoje);
//              if trim( ACBrNFSe1.WebServices.EnviarDPEC.nRegDPEC )<>'' then
 //               Sistema.setfield('moes_protodpec',ACBrNFSe1.WebServices.EnviarDPEC.nRegDPEC+' '+
  //                                DateTimeToStr(ACBrNFSe1.WebServices.EnviarDPEC.DhRegDPEC) )
//              else
                Sistema.setfield('moes_protodpec','');
              Sistema.Post('moes_transacao='+stringtosql(ctransacao));
            end else
               Avisoerro('Verificar. '+cretorno);
          end;
        end;
//else
  //        Avisoerro('Status Serviço :'+ACBrNFSe1.WebServices.StatusServico.Msg);
//          Avisoerro('Status WebService Sefa :'+ACBrNFSe1.WebServices.StatusServico.xMotivo);

        try
          Sistema.Commit;
        except
          Avisoerro('Não foi possível gravar o xml de retorno no banco de dados');
        end;

//        if FileExists( pathenvioexterno+'\'+arquivoexternoret ) then
//          DeleteFile( pathenvioexterno+'\'+arquivoexternoret );

      end else begin  // 25.11.09 - caso for usar formulario de segurança apenas gerar xml
                      // para depois imprimir o danfe em form. segurança
        try
          Sistema.Commit;
        except
          Avisoerro('Não foi possível gravar o xml no banco de dados');
        end;
      end;

    END ELSE BEGIN   // Consulta RPS

    ///////////////////////////////////////////////////
    ListaXml:=TStringList.create;

     for i:=0 to ACBrNFSe1.NotasFiscais.Count-1 do begin

       if Op='C' then
          ACBrNFSe1.ConsultarSituacao(ACBrNFSe1.NotasFiscais.Items[i].NFSe.Protocolo,ACBrNFSe1.NotasFiscais.Items[i].NFSe.IdentificacaoRps.Numero);

       if OP='P' then begin
         ListaXML.Clear;
         ListaXml.Add( ACBrNFSe1.NotasFiscais.Items[i].XMLOriginal);
       end else begin
         arqxmlretorno:=ACBrNFSe1.Configuracoes.Arquivos.PathNFSe+'\'+ACBrNFSe1.NotasFiscais.Items[i].NFSe.Protocolo+'-sit.xml';
//         arqxmlretorno:=GetRetorno( ACBrNFSe1.notasfiscais.items[i].XMLNFSe );
//         if not FileExists(arqxmlretorno) then begin
         if trim(arqxmlretorno)='' then begin
              Avisoerro('Arquivo XML de retorno está vazio');
              Sistema.EndProcess('Banco de dados não atualizado');
              exit;
         end;
         ListaXML.Clear;
//         ListaXml.LoadFromFile(arqxmlretorno);
         ListaXml.Add(arqxmlretorno);
       end;

//       showmessage(ListaXml.Strings[0] ) ;

//       cretorno:= GetRetorno( ListaXml.Strings[0]  ) ;
//       cretorno:=ACBrNFSe1.NotasFiscais.Items[i].NFSe.XML

         cretorno:=AcbrNFSe1.WebServices.ConsSitLoteRPS.RetSitLote.infSit.MsgRetorno.Items[i].Mensagem;

//       if trim(cretorno)='' then
//         cretorno:=copy(ACBrNFSe1.NotasFiscais.Items[i].NFSe.Status.xMotivo,53,50);
//       if trim(cretorno)='' then
//         cretorno:=copy(ACBrNFSe1.NotasFiscais.Items[i].CTe.procCTe.xMotivo,1,80);

       if op<>'' then
         AtualizaGrid( strtoint( ACBrNFSe1.NotasFiscais.Items[i].NFSe.IdentificacaoRps.Numero),cretorno );
       ctransacao:=GetGridTransacao( strtoint(ACBrNFSe1.NotasFiscais.Items[i].NFSe.IdentificacaoRps.Numero));
//{
       if ( trim(ctransacao)<>'' ) and
             ( trim(cretorno)<>'' )   and
             ( pos('ENCONTRADO',UPpercase(cretorno))=0 )
             then begin
             QNfe:=Sqltoquery('select moes_dtnfeauto,moes_chavenfe from movesto where moes_transacao='+Stringtosql(Trim(ctransacao))+
                              ' and moes_status<>''C''' );

             campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
// 08.12.16
               xmlstring:=ACBrNFSe1.NotasFiscais.Items[i].XML;
               xmlstring:=FGeral.TiraBarra(xmlstring,chr(39),'"');

             Sistema.edit('movesto');
             if ( pos('AUTORIZADO',uppercase(cretorno))>0  ) then begin
               Sistema.setfield('moes_dtnfeauto',Sistema.hoje);
//               Sistema.setfield('moes_xmlnfe',ACBrNFSe1.NotasFiscais.Items[i].XML) ;
//               if campo.tipo<>'' then // 16.07.10
//                  Sistema.setfield('moes_xmlnfet',ACBrNFSe1.NotasFiscais.Items[i].XML) ;
// 08.12.16
               Sistema.setfield('moes_xmlnfe',xmlstring) ;
               if campo.tipo<>'' then // 16.07.10
                  Sistema.setfield('moes_xmlnfet',xmlstring) ;
               Sistema.setfield('moes_chavenfe',ACBrNFSe1.NotasFiscais.Items[i].NFSe.ChaveNFSe);
             end;
// 08.12.10 -colocado o cancelamento da nfe na sefa mas no sac sem ter atualizado
//           o banco...primeira vez com dr. Tiago
             if pos('CANCELA',uppercase(cretorno))>0 then begin
               Sistema.setfield('moes_dtnfecanc',Sistema.hoje);
               Sistema.setfield('moes_xmlnfecanc',ACBrNFSe1.NotasFiscais.Items[i].XML) ;
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
          Avisoerro('Não foi possível gravar o xml no banco de dados');
     end;

    END;

  end;


  TNotas.Free;
  if  ACBrNFSe1.NotasFiscais.Count>0 then
    Sistema.EndProcess('Enviado(s) XML(s) gerado(s) em '+ACBrNFSe1.Configuracoes.Arquivos.PathNFSe)
  else
    Sistema.EndProcess('Sem notas para enviar XML(s)');

end;

// 06.06.17
procedure TFExpNfse.Execute(numeronota: integer; situacaonotas: string);
////////////////////////////////////////////////////////////////////////////////
var numerosnotas,sqlconfmov:string;
    Q:TSqlquery;
begin
  sqlconfmov:='';
  if FGeral.ConfiguradoECF then
    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));
  tiposdemovimento:=Global.CodPrestacaoServicos;
  Show;
  Grid.clear;
  EdUnid_codigo.text:=Global.CodigoUnidade;
// 08.03.10
  if trim( FGeral.GetConfig1AsString('AmbienteNFe') )<>'' then
    EdAmbiente.text:=FGeral.GetConfig1AsString('AmbienteNFe')
  else
    EdAmbiente.text:='1';

//  if trim( FGeral.GetConfig1AsString('Pastaschemas') ) <> '' then
//    ACBrNFSe1.Configuracoes.Arquivos.PathSchemas:=FGeral.GetConfig1AsString('Pastaschemas')
//  else
    ACBrNFSe1.Configuracoes.Arquivos.PathSchemas:=ExtractFilePath( Application.ExeName )+'SchemasNFS';
    if not DirectoryExists( ACBrNFSe1.Configuracoes.Arquivos.PathSchemas ) then
       ForceDirectories( ACBrNFSe1.Configuracoes.Arquivos.PathSchemas  );

// 27.09.10
  ACBrNFSe1.Configuracoes.Arquivos.Salvar:=true;
  ACBrNFSe1.Configuracoes.WebServices.AjustaAguardaConsultaRet := True;
  if EdInicio.isempty then
    EdInicio.setdate(sistema.hoje);
  if EdTermino.isempty then
    EdTermino.setdate(sistema.hoje);
  xnumeronota:=numeronota;
  xsituacaonotas:=situacaonotas;
  if xnumeronota>0 then begin
    EdInicio.setdate( Sistema.Hoje );
    EdTermino.setdate( Sistema.Hoje );
    EdInicio.Next;
    EdTermino.Next;
    EdUnid_codigo.Next;
    EdAmbiente.Next;
    EdNotas.Text:=strzero(numeronota,6);
    EdNotas.Next;
    EdFormaEmissao.text:='1';
    EdFormaEmissao.Next;
//    bexpxmlClick(self);
//    FGerenciaCTe.Execute(inttostr(numeronota));
//    FGerenciaCTe.bimpdacteClick(self);
//    FGerenciaCTe.Close;
    Close;
  end else if xsituacaonotas<>'' then begin
    Q:=Sqltoquery('select moes_numerodoc from movesto where moes_chavenfe is null'+
                  ' and moes_datamvto='+Datetosql(Sistema.hoje)+
                  ' and moes_status<>''C'''+
                  sqlconfmov+   // 23.01.12
                  ' and moes_unid_codigo='+EdUnid_codigo.assql+
                  ' and '+FGeral.GetSqlDataNula('moes_datacont')+
                  ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C'));
    numerosnotas:='';
    while not Q.eof do begin
      if Q.fieldbyname('moes_numerodoc').AsInteger>0 then
        numerosnotas:=numerosnotas+strzero( Q.fieldbyname('moes_numerodoc').AsInteger ,6)+';';
      Q.Next;
    end;
    FGeral.FechaQuery(Q);
    if trim(numerosnotas)='' then begin
      Aviso('Não encontrado notas a enviar para Sefa');
      close;
      exit;
    end;
    EdInicio.setdate( Sistema.Hoje );
    EdTermino.setdate( Sistema.Hoje );
    EdInicio.Next;
    EdTermino.Next;
    EdUnid_codigo.Next;
    EdAmbiente.Next;
    EdNotas.Text:=numerosnotas;
    EdNotas.Next;
    EdFormaEmissao.text:='1';
    EdFormaEmissao.Next;
//    bexpxmlClick(self);
///    FGerenciaNfe.Execute(numerosnotas);
//    FGerenciaNfe.bimpdanfeClick(self);
//    FGerenciaNfe.Close;
    Close;

  end else
    EdInicio.SetFirstEd;
//  EdInicio.SetFocus;

end;

// 26.06.17
function TFExpNfse.GetGridTransacao(nf: integer): string;
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

function TFExpNfse.GetRetorno(xml: string): string;
////////////////////////////////////////////////////////////
const cautorizado:string='autorizado o uso de nfs-e';
const cautorizadooutro:string='autorizado o uso da nfs-e';
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

// 27.06.17
function TFExpNfse.GetTag(ctag, xml: string): string;
//////////////////////////////////////////////////////////
var cbuscai,cbuscaf:string;
    inicio,fim:integer;
begin
//  result:='Não encontrado tag '+ctag;
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
//    AvisoErro('Não encontrado tag '+ctag);

end;

end.
