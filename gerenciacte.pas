unit gerenciacte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrCTe, DB, DBClient, SimpleDS, SqlSis, StdCtrls, FileCtrl,
  Grids, SqlDtg, Mask, SQLEd, Buttons, SQLBtn, alabel, SQLGrid, ExtCtrls,
  SqlExpr, pcnConversao, Printers, ACBrBase, ACBrDFe, ACBrCTeDACTEClass,
  ACBrCTeDACTeRLClass, ACBrMail,ShellApi, pcteConversaoCTe, ACBrDFeReport;

type
  TFGerenciaCte = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bconsultar: TSQLBtn;
    bSair: TSQLBtn;
    bimpdacte: TSQLBtn;
    bcancelacte: TSQLBtn;
    binutiliza: TSQLBtn;
    bemail: TSQLBtn;
    bcartacorrecao: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Edtermino: TSQLEd;
    EdInicio: TSQLEd;
    pgrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PCartacorrecao: TSQLPanelGrid;
    MemoResp: TMemo;
    Pcartacorrecao1: TSQLPanelGrid;
    MemoRespWs: TMemo;
    SQLPanelGrid1: TSQLPanelGrid;
    ComboBox1: TComboBox;
    StaticText1: TStaticText;
    EdNumeroi: TSQLEd;
    listaarquivos: TFileListBox;
    PrintDialogBoleto: TPrintDialog;
    OpenDialog1: TOpenDialog;
    TMovesto: TSQLDs;
    datas: TDataSource;
    ACBrCTe1: TACBrCTe;
    ACBrMail1: TACBrMail;
    Pcce: TSQLPanelGrid;
    Edscampo: TSQLEd;
    Edsvalor: TSQLEd;
    bimpcce: TSQLBtn;
    bgeraxml: TSQLBtn;
    ACBrCTeDACTeRL1: TACBrCTeDACTeRL;
    bdesacordo: TSQLBtn;
    procedure EdUnid_codigoExitEdit(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdUnid_codigoValidate(Sender: TObject);
    procedure bconsultarClick(Sender: TObject);
    procedure bimpdacteClick(Sender: TObject);
    procedure bcancelacteClick(Sender: TObject);
    procedure GridClick(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure binutilizaClick(Sender: TObject);
    procedure EdNumeroiExitEdit(Sender: TObject);
    procedure EdNumeroiValidate(Sender: TObject);
    procedure bemailClick(Sender: TObject);
    procedure bcartacorrecaoClick(Sender: TObject);
    procedure EdsvalorExitEdit(Sender: TObject);
    procedure EdscampoValidate(Sender: TObject);
    procedure bimpcceClick(Sender: TObject);
    procedure bgeraxmlClick(Sender: TObject);
    procedure bdesacordoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetSituacao(Q:TSqlquery):string;
    procedure Execute( numeronota:string='' );
    function GetQualXml( Q:TSqlquery ;temcampo:string):String;
// 29.05.20
    procedure Enviaemail(xtrans:string='';xemail:string='' );
    procedure InutilizaNumero( xNumero:Integer );
    procedure ConfiguraEmailAcbr;
  end;

var
  FGerenciaCte: TFGerenciaCte;
  Tiposdemovimento,TiposNao,arquivorave:string;
  campo:TDicionario;
  xnumeronota,enfce,sgrupo,scampo,svalor:string;

implementation

uses Geral, SqlFun, expnfetxt, Canctrans, pcteEnvEventoCTe, pcteEventoCTe,
  Unidades;

{$R *.dfm}

procedure TFGerenciaCte.EdUnid_codigoExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////////
begin
     bconsultarclick(self);

end;

procedure TFGerenciaCte.EdUnid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.LimpaEdit(EdUnid_codigo,key);

end;

procedure TFGerenciaCte.EdUnid_codigoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////////
begin
  if trim(EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString)<>'' then
    ACBrCTe1.Configuracoes.WebServices.UF:=EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString;

end;

procedure TFGerenciaCte.bconsultarClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqlexp,sqlnotas,sqlconfmov:string;
    p:integer;
begin
  sqlexp:='';
  sqlnotas:='';
  if (trim(xnumeronota)<>'') and ( trim(xnumeronota)<>'A' ) then
//    sqlnotas := 'and moes_numerodoc = '+inttostr(xnumeronota);
// 04.10.11
    sqlnotas := 'and '+FGeral.GetIN('moes_numerodoc',xnumeronota,'N');
//  sqlexp:=' and moes_nfeexp=''S'''
//  else if EdExportadas.text='N' then
//    sqlexp:=' and ( (moes_nfeexp is null) or (moes_nfeexp<>''S'') )';
//  if not EdNotas.isempty then
//    sqlnotas:=' and '+FGeral.GetIN('moes_numerodoc',EdNOtas.text,'N');
// 23.01.12
  sqlconfmov:='';
  if FGeral.ConfiguradoECF then
    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));
  Q:=sqltoquery('select movesto.*,clientes.clie_razaosocial,clientes.clie_tipo,clientes.clie_endres,clientes.clie_uf from movesto'+
                ' left join clientes on (clie_codigo=moes_tipo_codigo)'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N;E;D;X;I','C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                sqlconfmov+
//                ' and  moes_datacont>1'+
// 18.05.11
                ' and moes_datacont > '+DatetoSql(Global.DataMenorBanco)+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                sqlexp+sqlnotas+
//                ' and moes_tipocad='+stringtosql(Cv)+
                ' order by moes_numerodoc,moes_datamvto,moes_vispra' );
  if Q.eof then begin
    Avisoerro('Nada encontrado neste per�odo');
    exit;
  end;
//  Grid.QueryToGrid(Q);
  Grid.Clear;p:=1;
// 14.08.12
  MemoResp.Lines.Clear;
  MemoRespWs.Lines.Clear;
  while not Q.eof do begin
    Grid.Cells[Grid.GetColumn('moes_numerodoc'),p]:=Q.fieldbyname('moes_numerodoc').asstring;
    Grid.Cells[Grid.GetColumn('moes_dataemissao'),p]:=FGeral.FormataData( Q.fieldbyname('moes_dataemissao').asdatetime );
    Grid.Cells[Grid.GetColumn('moes_datamvto'),p]:=FGeral.FormataData( Q.fieldbyname('moes_datamvto').asdatetime );
    Grid.Cells[Grid.GetColumn('moes_vlrtotal'),p]:=floattostr(Q.fieldbyname('moes_vlrtotal').Ascurrency);
    Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p]:=Q.fieldbyname('moes_tipo_codigo').asstring;
    if Q.FieldByName('moes_tipocad').AsString='C' then begin
      Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:=Q.fieldbyname('clie_razaosocial').asstring;
    end else begin
      Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:=FGeral.GetNomeRazaoSocialEntidade( Q.fieldbyname('moes_tipo_codigo').asinteger,
                                Q.fieldbyname('moes_tipocad').asstring,'R');
    end;
    Grid.Cells[Grid.GetColumn('situacao'),p]:=GetSituacao(Q);
// 04.10.11 - Novi - vindo 'da pesagem'
    if (trim(xnumeronota)<>'') and ( xnumeronota=Q.fieldbyname('moes_numerodoc').asstring)  then
      Grid.Cells[Grid.GetColumn('marcado'),p]:='OK';

    Grid.Cells[Grid.GetColumn('moes_chavenfe'),p]:=Q.fieldbyname('moes_chavenfe').asstring;
    Grid.Cells[Grid.GetColumn('moes_transacao'),p]:=Q.fieldbyname('moes_transacao').asstring;
    Grid.Cells[Grid.GetColumn('retornows'),p]:=Q.fieldbyname('moes_retornonfe').asstring;
    Grid.AppendRow;
    inc(p);
    Q.Next;
  end;
  Grid.SetFocus;
//  GetRetornoWs(Q);

end;

// 04.10.2021 - Novicarnes - Fazenda
//              emitido um cte errado 'contra a fazenda' e so perceberam
//              depois do prazo de cancelamento
procedure TFGerenciaCte.bdesacordoClick(Sender: TObject);
//////////////////////////////////////////////////////////
var
  xObs, xUF, xUFOld: String;
  iLote: Integer;

begin

  OpenDialog1.Title := 'Selecione o CTe para enviar o Evento de Presta��o de Servi�o em Desacordo';
  OpenDialog1.DefaultExt := '*-cte.xml';
  OpenDialog1.Filter := 'Arquivos CTe (*-cte.xml)|*-cte.xml|Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrCTe1.Configuracoes.Arquivos.PathSalvar;

  PCartacorrecao.Visible :=true;
  PCartacorrecao1.Visible:=true;

  if OpenDialog1.Execute then
  begin

    if trim(Opendialog1.FileName)='' then exit;

    ACBrCTe1.Conhecimentos.Clear;
    ACBrCTe1.Conhecimentos.LoadFromFile(OpenDialog1.FileName);

//    xObs := 'Observa��o do Tomador (m�nimo 15 caracteres)';
    xObs := '                                              ';
    if not(InputQuery('Presta��o de Servi�o em Desacordo:', 'Observa��o do Tomador (m�nimo 15 caracteres)', xObs)) then
      exit;

//    xUF := '';
//    if not(InputQuery('Presta��o de Servi�o em Desacordo:', 'UF do Emitente do CT-e', xUF)) then
//      exit;

    // Salva a UF configurada no componente
    xUFOld := ACBrCTe1.Configuracoes.WebServices.UF;
    // O evento tem que ser enviado para a UF do Emitente do CT-e
    xuf := AcbrCte1.Conhecimentos.Items[0].CTe.emit.enderEmit.UF;
// o evento de descaso � para o destinatario 'fazer'
//    AcbrCte1.Conhecimentos.Items[0].CTe.ide.toma03.Toma := tmDestinatario;

    ACBrCTe1.Configuracoes.WebServices.UF := xUF;

    ACBrCTe1.EventoCTe.Evento.Clear;

    with ACBrCTe1.EventoCTe.Evento.New do
    begin
      // Para o Evento: nSeqEvento sempre = 1
      infEvento.nSeqEvento := 1;
      // Devemos informar a UF do Emitente do CT-e
      InfEvento.cOrgao     := UFtoCUF(xUF);
      infEvento.chCTe      := Copy(ACBrCTe1.Conhecimentos.Items[0].CTe.infCTe.Id, 4, 44);
      if  EdUnid_codigo.resultfind <> nil  then

         infEvento.CNPJ       := EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring

      else

         infEvento.CNPJ       := FUnidades.GetCnpjcpf( EdUnid_codigo.text );

      infEvento.dhEvento   := now;
      infEvento.tpEvento   := tePrestDesacordo;

      infEvento.detEvento.xOBS  := xObs;

    end;

    Aviso( 'Cnpj : '+ACBrCTe1.EventoCTe.Evento.Items[0].InfEvento.CNPJ );
    Aviso( 'Org�o: '+inttostr(ACBrCTe1.EventoCTe.Evento.Items[0].InfEvento.cOrgao) );

    iLote := ( GetSequencia('DesacordoCTe'+EdUnid_codigo.text,true) );
    try

       ACBrCTe1.EnviarEvento(iLote);

    finally

      ACBrCTe1.Configuracoes.WebServices.UF := xUFOld;
      MemoResp.Lines.Text   := ACBrCTe1.WebServices.EnvEvento.RetWS;
      memoRespWS.Lines.Text := ACBrCTe1.WebServices.EnvEvento.RetornoWS;

  //    LoadXML(ACBrCTe1.WebServices.EnvEvento.RetWS, WBResposta);

      Aviso(IntToStr(ACBrCTe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat));

    end;
    // Retorna a configura��o da UF
//    ShowMessage(ACBrCTe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt);

  end;

  Aviso('Finalizado');
  PCartacorrecao.Visible:=false;
  PCartacorrecao1.Visible:=false;

end;

function TFGerenciaCte.GetSituacao(Q: TSqlquery): string;
//////////////////////////////////////////////////////////////
begin
  result:='XML N�O Exportado';
  if Q.fieldbyname('moes_nfeexp').AsString='S' then begin
    result:='XML Exportado';
    if trim(Q.fieldbyname('moes_chavenfe').AsString)='' then
      result:='Ainda n�o autorizada pela SEFA';
    if Q.fieldbyname('moes_status').AsString='I' then
      result:='Numera��o Inutilizada';
  end;
  if trim(Q.fieldbyname('moes_chavenfe').AsString)<>'' then begin
    result:='Autorizada';
    if Datetoano(Q.fieldbyname('moes_dtnfecanc').AsDateTime,true)>1920 then
      result:='Cancelada';
  end else if Q.fieldbyname('moes_status').AsString='I' then
    result:='Numera��o Inutilizada';

end;

procedure TFGerenciaCte.Execute(numeronota: string);
/////////////////////////////////////////////////////////
var codigo,s:string;
begin
{
  arquivorave:=ExtractFilePath(Application.ExeName)+'NotaFiscalEletronica.rav';
  if not FileExists(arquivorave) then
     arquivorave:='\nfesac\NotaFiscalEletronica.rav';
  if not FileExists(arquivorave) then begin
     Avisoerro('Arquivo .RAV n�o encontrado');
     exit;
  end;
  ACBrNFeDANFERave1.RavFile:=arquivorave;
}
  Show;
  Grid.clear;
  EdUnid_codigo.text:=Global.CodigoUnidade;
  tiposdemovimento:=Global.CodConhecimentoSaida;

  tiposnao:=Global.TiposNaoFiscal+';'+Global.CodVendaInterna;
  if trim(FGeral.GetConfig1AsString('Pastaexpnfexml'))<>'' then
    acbrCte1.Configuracoes.Arquivos.PathCTe:=FGeral.GetConfig1AsString('Pastaexpnfexml');

  acbrCte1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(EdUnid_codigo.text);
//  if trim(FGeral.GetConfig1AsString('NumSerieCert'))<>'' then
//    acbrCte1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetConfig1AsString('NumSerieCert');
  if trim(FGeral.GetConfig1AsString('Pastaretonfexml'))<>'' then begin
    acbrCte1.Configuracoes.Arquivos.Pathevento:=FGeral.GetConfig1AsString('Pastaretonfexml');
// 15.03.10
    acbrCte1.Configuracoes.Arquivos.PathSalvar:=FGeral.GetConfig1AsString('Pastaretonfexml');
  end;
  if trim(FGeral.GetConfig1AsString('Pastainunfexml'))<>'' then
    acbrCte1.Configuracoes.Arquivos.PathInu:=FGeral.GetConfig1AsString('Pastainunfexml');
 /////////////////////////////
 {
  if trim(FGeral.GetConfig1AsString('Pastaimagemdanfe'))<>'' then begin
    if FileExists( FGeral.GetConfig1AsString('Pastaimagemdanfe') ) then
      AcbrnfeDanfeRave1.Logo:=FGeral.GetConfig1AsString('Pastaimagemdanfe')
    else
      AcbrnfeDanfeRave1.Logo:='';
  end else
//    acbrCte1.DANFE.Logo:='';
    AcbrnfeDanfeRave1.Logo:='';
      }
 /////////////////////////////
  if trim(FGeral.GetConfig1AsString('AmbienteCte'))<>'' then begin
    if FGeral.GetConfig1AsString('AmbienteCte')='1' then
      acbrCte1.Configuracoes.WebServices.Ambiente:=taProducao
    else
      acbrCte1.Configuracoes.WebServices.Ambiente:=taHomologacao;
  end else
      acbrCte1.Configuracoes.WebServices.Ambiente:=taHomologacao;
  acbrCte1.Configuracoes.Arquivos.Salvar:=true;
  if trim( FGeral.GetConfig1AsString('Pastaschemas') ) <> '' then
    acbrCte1.Configuracoes.Arquivos.PathSchemas:=FGeral.GetConfig1AsString('Pastaschemas')
  else
    acbrCte1.Configuracoes.Arquivos.PathSchemas:=ExtractFilePath( Application.ExeName )+'SchemasCTE20';

  ACBrCte1.MAIL:=AcbrMail1;
// 08.08.18
  Acbrcte1.Configuracoes.Geral.VersaoDF:=ve300;

{
 acbrCte1.DACTe:=ACBrCTe1.DACTe.Create(self);
  if trim( FGeral.GetConfig1AsString('PastaPdfs') ) <> '' then
    acbrCte1.DAcTE.PathPDF:=FGeral.GetConfig1AsString('PastaPdfs')
  else
    acbrCte1.DAcTE.PathPDF:=ExtractFilePath( Application.ExeName );
}
///////////////

  if EdInicio.isempty then
    EdInicio.setdate(sistema.hoje);
  if EdTermino.isempty then
    EdTermino.setdate(sistema.hoje);
  Combobox1.Items.Assign(Printer.Printers);
//  Combobox1.ItemIndex:=Printer.PrinterIndex;
// usa a impressora configurada no impresso da nota de saida em formulario continou
  Codigo:=FGeral.GetConfig1AsString('Imprnotasaida');
//  FConfDcto.GetConfiguracao(Codigo);
  s:=GetIni(Sistema.NameSystem+'D','Impressoras','DCTO'+Codigo);
  if s<>'' then
    Combobox1.Text:=s
  else
    Combobox1.ItemIndex:=Printer.PrinterIndex;

  xnumeronota:=numeronota;
  PCartacorrecao.Visible:=false;
  PCartacorrecao1.Visible:=false;
  if trim(xnumeronota)<>'' then begin
    EdUnid_codigo.Next;   // 31.07.11
    bconsultarClick(self);
  end else begin
    EdInicio.SetFirstEd;
  end;
// 16.12.13
  bcancelacte.Enabled:=(not Global.Topicos[1037]);
end;

procedure TFGerenciaCte.bimpdacteClick(Sender: TObject);
///////////////////////////////////////////////////////////////
var ct,ct1,temxmltext,campoxml:string;
    Q:TSqlquery;
    ListaXML,ListaProtDpec,ListaTrans:TStringList;
    arqxml,codigosdesti,codigosdesti1:string;
    marc,i:integer;

    function GetProtocoloDpec(nNF:integer):string;
    /////////////////////////////////////////////
    var x:integer;
    begin
      result:='';
      for x:=0 to ListaProtDpec.Count-1 do begin
        if pos(';CT'+strzero(nNF,6),ListaProtDpec.Strings[x])>0 then begin
          result:=copy(ListaProtDpec.Strings[x],1,pos(';',ListaProtDpec.Strings[x])-1 );
          break;
        end;
      end;
    end;

begin
///////////////////////////////////////////////
   PCartacorrecao.Visible:=false;
   PCartacorrecao1.Visible:=false;
   ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row];
   codigosdesti:=Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),Grid.row];
   marc:=0;
   ct1:='';
   codigosdesti1:='';
   for i:=0 to Grid.rowcount do begin
     if Grid.Cells[Grid.getcolumn('marcado'),i]='OK' then begin
       inc(marc);
       ct1:=ct1+Grid.Cells[Grid.getcolumn('moes_transacao'),i]+';';
       codigosdesti1:=codigosdesti1+Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),i]+';';
     end;
   end;
   if ct1<>'' then ct:=ct1;
   if trim(ct)='' then begin
      Avisoerro('Sem CTe escolhido');
      exit;
   end;
   if trim(codigosdesti)='' then begin
      Avisoerro('Sem cliente OU CTe escolhido');
      exit;
   end;
   if codigosdesti1<>'' then codigosdesti:=codigosdesti1;
//   Q:=Sqltoquery('select moes_xmlnfe,moes_dtnfeauto from movesto where moes_transacao='+Stringtosql(ct)+
   campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
   temxmltext:='N';
   if campo.Tipo<>'' then begin
     temxmltext:='S';
     Q:=Sqltoquery('select moes_xmlnfe,moes_xmlnfet,moes_dtnfeauto,moes_transacao,moes_dtnfecanc,moes_protodpec,moes_numerodoc from movesto where '+
                 FGeral.GetIN('moes_transacao',ct,'C')+
                ' and '+FGeral.GetIN('moes_tipo_codigo',codigosdesti,'N')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C'' order by moes_numerodoc')
   end else
     Q:=Sqltoquery('select moes_xmlnfe,moes_dtnfeauto,moes_transacao,moes_dtnfecanc,moes_protodpec,moes_numerodoc from movesto where '+
                 FGeral.GetIN('moes_transacao',ct,'C')+
                ' and '+FGeral.GetIN('moes_tipo_codigo',codigosdesti,'N')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C'' order by moes_numerodoc');

   acbrCte1.Conhecimentos.Clear;
   ListaXML:=TStringList.Create;
   ListaTrans:=TStringList.Create;
   arqxml:='IMPDanfe.txt';
//////////////////////////
   {
   if not FileExists(arquivorave) then begin
     Avisoerro('Arquivo '+arquivorave+' n�o encontrado');
     exit;
   end;
   }
//////////////////////////
   if Q.eof then begin
     Avisoerro('Nada encontrado para impress�o.  Checar conhecimentos');
     exit;
   end;
//////////////////////////
{
   if FGeral.GetConfig1AsInteger('decqtdedanfe') >0 then
     ACBrCTe1.Configuracoes.WebServices. CasasDecimais._qCom:=FGeral.GetConfig1AsInteger('decqtdedanfe');
   if FGeral.GetConfig1AsInteger('decunitariodanfe') >0 then
     ACBrCTe1.CasasDecimais._vUnCom:=FGeral.GetConfig1AsInteger('decunitariodanfe');
}
//////////////////////////

   ListaProtDpec:=TStringList.Create;

   while not Q.eof do begin

// 28.04.11
      campoxml:='moes_xmlnfet';
      if trim(Q.fieldbyname('moes_xmlnfet').asstring)='' then
        campoxml:='moes_xmlnfe';
/////////
//      if trim(Q.fieldbyname('moes_xmlnfe').asstring)='' then
// 09.12.10
      if ( trim(Q.fieldbyname(campoxml).asstring)='' )  then
        Avisoerro('Transa��o '+Q.fieldbyname('moes_transacao').asstring+' sem XML gravado')
// contigencia com form. seg.
      else if FExpNfetxt.GetTag('tpemis',Q.fieldbyname(campoxml).asstring)='2' then begin
        ListaXML.Clear;
        ListaXML.Append( GetQualXml(Q,temxmltext) ) ;
        ListaXml.SaveToFile(arqxml);
        acbrCte1.Conhecimentos.LoadFromFile(arqxml);
//dpec
      end else if FExpNfetxt.GetTag('tpemis',Q.fieldbyname(campoxml).asstring)='4' then begin
        if trim(Q.fieldbyname('moes_protodpec').asstring)='' then
          Avisoerro('Transa��o '+Q.fieldbyname('moes_transacao').asstring+' sem Protocolo de Envio ao DPEC')
        else begin
          ListaXML.Clear;
          ListaXML.Append( GetQualXml(Q,temxmltext) );
          ListaXml.SaveToFile(arqxml);
          acbrCte1.Conhecimentos.LoadFromFile(arqxml);
          ListaProtDpec.Add(Q.fieldbyname('moes_protodpec').asstring+';NF'+strzero(Q.fieldbyname('moes_numerodoc').asinteger,6));
        end;
      end else if DAtetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)<=1900 then
        Avisoerro('Transa��o '+Q.fieldbyname('moes_transacao').asstring+' aind n�o foi autorizada')
      else if DAtetoano(Q.fieldbyname('moes_dtnfecanc').asdatetime,true)>1900 then begin
        Avisoerro('CTe ref. Transa��o '+ct+' foi cancelada na Sefa');
      end else begin
        ListaXML.Clear;
        ListaXML.Append( GetQualXml(Q,temxmltext) );
        ListaXml.SaveToFile(arqxml);
        acbrCte1.Conhecimentos.LoadFromFile(arqxml);
        ListaTrans.Add(Q.fieldbyname('moes_transacao').asstring);
      end;
      Q.Next;
   end;
   if acbrCte1.Conhecimentos.Count>0 then begin

     Printer.PrinterIndex := ComboBox1.ItemIndex;
//     ACBrNFeDANFERave1.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];
     if FGeral.GetConfig1AsInteger('copiasdanfe')>0 then
       PrintDialogBoleto.Copies:=FGeral.GetConfig1AsInteger('copiasdanfe');
       if marc>1 then  begin
         if not PrintDialogBoleto.Execute then begin
           exit;
         end;
       end;

//     AcbrNfeDANFERave1.NumCopias:=PrintDialogBoleto.Copies;
//     AcbrNfeDANFERave1.Email:=EdUnid_codigo.ResultFind.fieldbyname('unid_email').asstring;

     acbrCte1.Conhecimentos.GerarCTe;
     if marc>1 then begin
//        ACBrCteDAcTERave1.MostrarPreview:=false;
     end else
//        ACBrCTeDAcTERave1.MostrarPreview:=true;

     for i:=0 to acbrCte1.Conhecimentos.Count-1 do begin
//        ACBrCTeDANFERave1.ProtocoloNFe:=GetProtocoloDpec(acbrCte1.Conhecimentos.Items[i].CTe.Ide.nNF);
        acbrCte1.Conhecimentos.Items[i].Imprimir;
     end;
     if Global.Topicos[1022] then begin
       for i:=0 to ListaTrans.count-1 do begin
          if ListaTrans.count>1 then begin
            if Confirma('Envia email ?') then
              Enviaemail( ListaTrans[i] );
          end else
            Enviaemail( ListaTrans[i] );

       end;
       ListaTrans.Free;
     end;

   end else
     Avisoerro('Nota(s) n�o armazenadas para impress�o.');  // 14.07.10 - Doce Pimenta

   FGeral.FechaQuery(Q);
   PrintDialogBoleto.Copies:=1;
end;

function TFGerenciaCte.GetQualXml(Q: TSqlquery; temcampo: string): String;
///////////////////////////////////////////////////////////////////////////
begin
  if temcampo='S' then begin
    if trim(Q.fieldbyname('moes_xmlnfet').asstring)='' then
      result:=Q.fieldbyname('moes_xmlnfe').asstring
    else
      result:=Q.fieldbyname('moes_xmlnfet').asstring
  end else
    result:=Q.fieldbyname('moes_xmlnfe').asstring;

  if temcampo='X' then result:=Q.fieldbyname('moes_xmlnfecanc').asstring

end;

procedure TFGerenciaCte.Enviaemail(xtrans:string='';xemail:string='' );
////////////////////////////////////////////////////////////////////////////////
var ct,arqxml,emailDestino,temxmltext,caminhoxml,emaildestino1,emailsdestino,emaildestino2:string;
    Q:TSqlquery;
    ListaXml    :TStringList;
    CorpoEmail,
    ListaEmails :TStringList;
    p           :integer;


begin

   if trim(fGeral.GetConfig1AsString('EMAILORIGEM'))='' then begin
     Avisoerro('Configurar todos os dados referente email nas config. gerais');
     exit;
   end;
   if ( FGeral.EmailStmpcomSSL( fGeral.GetConfig1AsString('EMAILORIGEM'))  ) and ( FGeral.SemDllsSmtp ) then begin
     Avisoerro('Email '+fGeral.GetConfig1AsString('EMAILORIGEM')+' usa SSL; faltam 3 arquivos com extens�o .dll');
     exit;
   end;
   ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row];
// 06.07.11
   if xtrans<>'' then ct:=xtrans;
   temxmltext:='N';
// 14.09.11
   campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
   if campo.Tipo<>'' then begin
     temxmltext:='S';
     Q:=Sqltoquery('select moes_xmlnfe,moes_xmlnfet,moes_numerodoc,moes_dataemissao,moes_transacao,moes_tipo_codigo,moes_tipocad,moes_protodpec,moes_dtnfeauto,moes_dtnfecanc'+
                 ' from movesto where moes_transacao='+Stringtosql(ct)+
                 ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C''');

   end else
     Q:=Sqltoquery('select moes_xmlnfe,moes_numerodoc,moes_dataemissao,moes_transacao,moes_tipo_codigo,moes_tipocad,moes_protodpec,moes_dtnfeauto,moes_dtnfecanc'+
                 ' from movesto where moes_transacao='+Stringtosql(ct)+
                 ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C''');
   CorpoEmail:=TStringList.Create;
   arqxml:='EmailDacte.text';
//Pedir na hora..
   if not Q.eof then begin
     //checar se autorizada
      if trim(Q.fieldbyname('moes_xmlnfe').asstring)='' then begin
        Avisoerro('Transa��o '+Q.fieldbyname('moes_transacao').asstring+' sem XML gravado');
        exit;
//dpec
      end else if FExpNfetxt.GetTag('tpemis',Q.fieldbyname('moes_xmlnfe').asstring)='4' then begin
        if trim(Q.fieldbyname('moes_protodpec').asstring)='' then begin
          Avisoerro('Transa��o '+Q.fieldbyname('moes_transacao').asstring+' sem Protocolo de Envio ao DPEC');
          exit;
        end;
      end else if DAtetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)<=1900 then begin
          Avisoerro('Transa��o '+Q.fieldbyname('moes_transacao').asstring+' aind n�o foi autorizada');
          exit;
      end else if DAtetoano(Q.fieldbyname('moes_dtnfecanc').asdatetime,true)>1900 then begin
        Avisoerro('CTe ref. Transa��o '+ct+' foi cancelado na Sefa');
        exit;
      end;

       if trim(xemail)<>'' then begin

          emaildestino := xemail;
          emaildestino1:='';emaildestino2:='';
          ListaEmails := TStringList.create;

          if Ansipos(';',emaildestino) > 0 then begin

            strtolista(ListaEmails,emaildestino,';',true);
            for p := 0 to ListaEmails.count -1  do begin

               if ListaEmails.count>2 then  begin

                 emaildestino  := ListaEmails[0];
                 emaildestino1 := ListaEmails[1];
                 emaildestino2 := ListaEmails[2];

               end else begin

                 emaildestino  := ListaEmails[0];
                 emaildestino1 := ListaEmails[1];

               end;

            end;

         end;

       end else begin

     //buscar email cadastro clientes..
//     emaildestino:=FGeral.GetEmailEntidade(Q.fieldbyname('moes_tipo_codigo').AsInteger,Q.fieldbyname('moes_tipocad').asstring);
// 30.05.14
         emailsdestino:=FGeral.GetEmailEntidade(Q.fieldbyname('moes_tipo_codigo').AsInteger,Q.fieldbyname('moes_tipocad').asstring,'S');
         emaildestino:='';emaildestino1:='';emaildestino2:='';
         ListaEmails := TStringList.create;

         if Ansipos(';',emailsdestino)>0 then begin

           emaildestino:=copy(emailsdestino,1,pos(';',emailsdestino)-1);
           emaildestino1:=copy(emailsdestino,pos(';',emailsdestino)+1,60);

         end;
         if trim(emaildestino)='' then begin
           if not Input('Destinat�rio de e-mail','E-Mail',emaildestino,0,False)  or (emaildestino='') then exit;
         end;
// 23.12.20
         if Ansipos(';',emaildestino) > 0 then begin

            strtolista(ListaEmails,emaildestino,';',true);
            for p := 0 to ListaEmails.count -1  do begin

               if ListaEmails.count>2 then  begin

                 emaildestino  := ListaEmails[0];
                 emaildestino1 := ListaEmails[1];
                 emaildestino2 := ListaEmails[2];

               end else begin

                 emaildestino  := ListaEmails[0];
                 emaildestino1 := ListaEmails[1];

               end;

            end;

         end;

       end;

       CorpoEmail.Add(  'Anexo XML do CTe '+Q.fieldbyname('moes_numerodoc').asstring+
                        ' emitido em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime) );
// 29.03.10
       CorpoEmail.Add(  ' ' );
       CorpoEmail.Add(  ' ' );
       CorpoEmail.Add(  EdUnid_codigo.resultfind.fieldbyname('unid_razaosocial').AsString );
       CorpoEmail.Add(  FGeral.Formatacnpj( EdUnid_codigo.resultfind.fieldbyname('Unid_cnpj').AsString ) );
       CorpoEmail.Add(  EdUnid_codigo.resultfind.fieldbyname('Unid_endereco').AsString );
       CorpoEmail.Add(  EdUnid_codigo.resultfind.fieldbyname('Unid_bairro').AsString+' - '+
                        EdUnid_codigo.resultfind.fieldbyname('Unid_municipio').AsString  );
       CorpoEmail.Add(  FGeral.Formatatelefone( EdUnid_codigo.resultfind.fieldbyname('Unid_fone').AsString ) );
       CorpoEmail.Add(  EdUnid_codigo.resultfind.fieldbyname('Unid_email').AsString );

       Listaxml:=TStringList.Create;
       ListaXML.Append( GetQualXml(Q,temxmltext) );
       ListaXML.SaveToFile(arqxml);
       ACBrCTe1.Conhecimentos.Clear;
       AcbrCTe1.Conhecimentos.LoadFromFile(arqxml);
// 14.09.11
       if AcbrCTe1.Conhecimentos.Count=0 then
         Avisoerro('Problemas ao ler o arquivo '+arqxml+' desta nota');

       Sistema.BeginProcess('Enviando email');

       try
         if Global.Topicos[1019] then begin // usar cliente de email padrao...

//     acbrcte1.Configuracoes.Arquivos.PathNFe+'\'+inttostr(acbrcte1.Conhecimentos.Items[i].CTe.Ide.cNF)+FGeral.TiraBarra( Datetostr(acbrcte1.Conhecimentos.Items[0].CTe.Ide.dEmi) )+'-NFe.xml';
//           FGeral.EmailClientePadrao(emaildestino,'XML NFe',FGeral.GetConfig1AsString('Pastaexpnfexml'),CorpoEmail);
           caminhoxml:=FGeral.GetConfig1AsString('Pastaexpnfexml')+'\'+copy(ACBRCTe1.Conhecimentos.Items[0].CTe.infCTe.Id,4,44)+'-CTe.xml';
           FGeral.EmailClientePadrao(emaildestino,'XML CTe',caminhoxml,CorpoEmail);

         end else if Global.Topicos[1012] then begin

// desta forma com true envia tbem o danfe em pdf
           if FGeral.EmailStmpcomSSL( FGeral.GetConfig1AsString('EMAILORIGEM') ) then
             ACBrCTe1.Conhecimentos.Items[0].EnviarEmail(emaildestino,
                       'XML CTe '+Q.fieldbyname('moes_numerodoc').asstring+
                       ' emitido em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                       CorpoEmail,true,nil,nil)

           else
             ACBrCTe1.Conhecimentos.Items[0].EnviarEmail(emaildestino,
                       'XML CTe '+Q.fieldbyname('moes_numerodoc').asstring+
                       ' emitido em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                       CorpoEmail,true,nil,nil);

           if trim(emaildestino1)<>'' then

                ACBrCTe1.Conhecimentos.Items[0].EnviarEmail(emaildestino1,
                       'XML CTe '+Q.fieldbyname('moes_numerodoc').asstring+
                       ' emitido em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                       CorpoEmail,true,nil,nil);
// 23.12.20
           if trim(emaildestino2)<>'' then

                ACBrCTe1.Conhecimentos.Items[0].EnviarEmail(emaildestino2,
                       'XML CTe '+Q.fieldbyname('moes_numerodoc').asstring+
                       ' emitido em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                       CorpoEmail,true,nil,nil);

         end else  begin

           if FGeral.EmailStmpcomSSL( FGeral.GetConfig1AsString('EMAILORIGEM') ) then
             ACBrCTe1.Conhecimentos.Items[0].EnviarEmail(emaildestino,
                       'XML CTe '+Q.fieldbyname('moes_numerodoc').asstring+
                       ' emitido em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                       CorpoEmail,false,nil,nil)

           else
             ACBrCTe1.Conhecimentos.Items[0].EnviarEmail(emaildestino,
                       'XML CTe '+Q.fieldbyname('moes_numerodoc').asstring+
                       ' emitido em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                       CorpoEmail,false,nil,nil);
           if trim(emaildestino1)<>'' then
             ACBrCTe1.Conhecimentos.Items[0].EnviarEmail(emaildestino1,
                       'XML CTe '+Q.fieldbyname('moes_numerodoc').asstring+
                       ' emitido em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                       CorpoEmail,false,nil,nil);
// 23.12.20
           if trim(emaildestino2)<>'' then
             ACBrCTe1.Conhecimentos.Items[0].EnviarEmail(emaildestino1,
                       'XML CTe '+Q.fieldbyname('moes_numerodoc').asstring+
                       ' emitido em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                       CorpoEmail,false,nil,nil);

////////         }
         end;
//           FGeral.EnviaEMail(emaildestino,'XML NFe','',CorpoEmail);
         Sistema.EndProcess('');  // tirado aviso daqui pra ficar somente de onde chama a funcao...

       except

         Sistema.EndProcess('Email n�o enviado.  Checar configura��o do email '+FGeral.GetConfig1AsString('EMAILORIGEM')+
                             ' SMTP '+FGeral.GetConfig1AsString('SMTP'));
       end;
  //    FGeral.EnviaEMail('andre@tokefinal.com.br','XML Nfe numero '+Q.fieldbyname('moes_numerodoc').asstring,Q.fieldbyname('moes_xmlnfe').asstring,corpoemail)
       ACBrCTe1.Conhecimentos.Clear;

   end;
   CorpoEmail.Clear;
   FGeral.FechaQuery(Q);

end;

// 08.12.16
procedure TFGerenciaCte.bcancelacteClick(Sender: TObject);
////////////////////////////////////////////////////////////////
var ct,justificativa,arqxml,arqxmlretorno,cretorno,idlote:string;
    Q:TSqlquery;
    Listaxml:TStringlist;
    posicaogrid,r,nok:integer;

    function TemPendenciaBaixada(xtrans:string):boolean;
    ////////////////////////////////////////////////////////
    var QP:Tsqlquery;
    begin
      result:=false;
       QP:=sqltoquery('select pend_status from pendencias where pend_transacao='+Stringtosql(xtrans));
       if not QP.eof then begin
         if pos( QP.fieldbyname('pend_status').asstring,'B;K' ) >0 then
           result:=true;
       end;
       FGeral.FechaQuery(QP);
    end;

begin
////////////////////////////

// 29.08.16 - Novicarnes - Isonel
   if not Global.Usuario.OutrosAcessos[0303] then begin
     Avisoerro('Usu�rio sem permiss�o para cancelar notas fiscais');
     exit;
   end;
   if Grid.Cells[Grid.getcolumn('marcado'),grid.row]<>'OK' then begin
     Avisoerro('Usar a coluna MARCADO para escolher qual NFe cancelar');
     exit;
   end;
   posicaogrid:=Grid.row;
   nok:=0;
   for r:=1 to Grid.RowCount do begin
      if Grid.Cells[Grid.getcolumn('marcado'),r]='OK' then inc(nok);
   end;
   if nok>1 then begin
     Avisoerro('Marcar apenas UM CTe para cancelamento');
     exit;
   end;
   ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),posicaoGrid];
   Q:=Sqltoquery('select moes_xmlnfe,moes_dtnfeauto,moes_numerodoc,moes_dtnfecanc,moes_xmlnfet from movesto where moes_transacao='+Stringtosql(ct)+
                 ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C''');
   if not Q.eof then begin
      if trim(Q.fieldbyname('moes_xmlnfet').asstring)='' then
        Avisoerro('Transa��o '+ct+' sem XML gravado')
      else if DAtetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)<=1900 then
        Avisoerro('Transa��o '+ct+' ainda n�o foi autorizada')
      else if DAtetoano(Q.fieldbyname('moes_dtnfecanc').asdatetime,true)>1900 then
        Avisoerro('NFe ref. Transa��o '+ct+' j� foi cancelada na Sefa em '+Fgeral.FormataData(Q.fieldbyname('moes_dtnfecanc').asdatetime))
// 01.07.11 - Novicarnes - Vava - ver se vai fazer mesmo...
      else if TemPendenciaBaixada( ct ) then
        Avisoerro('NFe ref. Transa��o '+ct+' tem pend�ncia j� baixada no sistema ')
      else begin
        if not Input('Justificativa ( m�nimo 15 caracteres )','Motivo Cancelamento',justificativa,150,true) then exit;
        if trim(justificativa)='' then begin
          Avisoerro('Campo de preenchimento obrigat�rio');
          exit;
        end;
        if length(trim(justificativa))<15 then begin
          Avisoerro('Minimo de 15 caracteres para justificativa');
          exit;
        end;
   acbrcte1.Conhecimentos.Clear;
   acbrcte1.Conhecimentos.LoadFromStream( TStringStream.Create( Q.fieldbyname('moes_xmlnfet').asstring ) );
   if Q.fieldbyname('moes_numerodoc').asinteger<>acbrcte1.Conhecimentos.Items[0].CTe.Ide.nCT then begin
      Avisoerro('CTe escolhida '+inttostr(Q.fieldbyname('moes_numerodoc').asinteger)+
                'CTe para cancelamento '+inttostr(acbrcte1.Conhecimentos.Items[0].CTe.Ide.nCT) );
      exit;
   end;
   PCartacorrecao.Visible:=true;
   PCartacorrecao1.Visible:=true;

///////////////////////////////////  por evento a
        if ( Global.Topicos[1033] ) then begin

          idLote := inttostr( GetSequencia('CancCTe'+EdUnid_codigo.text,true) );
//          if not(InputQuery('Cancelamento por Eventos: Cancelamento', 'Identificador de controle do Lote de envio do Evento', idLote)) then
//             exit;
//          if not(InputQuery('Cancelamento por Eventos: Cancelamento', 'Justificativa', vAux)) then
//             exit;
//          if length(trim(vaux))<15 then begin
//             Avisoerro('M�nimo de 15 caracteres para justificativa');
//             exit;
//          end;
          acbrcte1.EventoCTe.Evento.Clear;
          acbrcte1.EventoCTe.idLote := StrToInt(idLote) ;
          with acbrcte1.EventoCTe.Evento.Add do
          begin
//           infEvento.dhEvento := now;
//           infEvento.dhEvento := Sistema.hoje;
// 30.04.13 - sefa MT
           infEvento.dhEvento := Sistema.Hoje+Time();
           infEvento.tpEvento := teCancelamento;
           infEvento.detEvento.xJust := justificativa;
           InfEvento.CNPJ:=acbrcte1.Conhecimentos.Items[0].CTe.Emit.CNPJ;
//////////           InfEvento.tpAmb:=acbrcte1.Configuracoes.WebServices.Ambiente;
           if FGeral.GetConfig1AsString('AmbienteCte')='1' then
             InfEvento.tpAmb:=taProducao
           else
             InfEvento.tpAmb:=taHomologacao;

//           InfEvento.chNFe:=copy(acbrcte1.Conhecimentos.Items[0].CTe.infNFe.ID,3,44);
// deixado o componente colocar
//           InfEvento.cOrgao:=91;  // ambiente nacional ou 91 ??
//           InfEvento.cOrgao:=strtoint( copy(acbrcte1.Conhecimentos.Items[0].CTe.infNFe.ID,4,2) );
          end;
          Sistema.BeginProcess('Enviando Evento de Cancelamento');
//          try

            acbrcte1.EnviarEvento(StrToInt(idLote));

//          except
//            Aviso('Problemas ao enviar o evento');
//          end;
            if acbrcte1.WebServices.EnvEvento<>nil then begin
            with acbrcte1.WebServices.EnvEvento do begin
              if EventoRetorno<>nil then begin
                if EventoRetorno.retEvento.Count>0 then begin
                  if EventoRetorno.retEvento.Items[0].RetInfEvento.cStat <> 135 then
                  begin
                    raise Exception.CreateFmt(
                      'Ocorreu o seguinte erro ao cancelar o conhecimento eletr�nico:'  + sLineBreak +
                      'C�digo:%d' + sLineBreak +
                      'Motivo: %s', [
                        EventoRetorno.retEvento.Items[0].RetInfEvento.cStat,
                        EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo
                    ]);
                  end;
                end else Avisoerro('Sem evento de retorno');
              end else Avisoerro('Sem retorno');
            end;
            end else Avisoerro('Sem comunica��o');

            MemoResp.Lines.Text :=  UTF8Encode(acbrcte1.WebServices.EnvEvento.RetWS);
            memoRespWS.Lines.Text :=  UTF8Encode(acbrcte1.WebServices.EnvEvento.RetornoWS);
            cretorno:=IntToStr(acbrcte1.WebServices.EnvEvento.cStat)+'-'+FExpNfetxt.GetTag('xMotivo',MemoResp.Lines.Text);
  //          LoadXML(MemoResp, WBResposta);
            ShowMessage('Retorno='+cretorno);
  //          ShowMessage('cStat='+IntToStr(acbrcte1.WebServices.EnvEvento.cStat));
//            ShowMessage('Nprot='+acbrcte1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt);
//          except
//            Aviso('Problemas ao enviar o evento');
//          end;
        end else begin
/////////////////////////////////////
          Sistema.BeginProcess('Enviando Cancelamento');
          arqxml:= ExtractFilePath( Application.ExeName )+'CancelaCT'+Q.fieldbyname('moes_numerodoc').asstring+'.TXT';
          ListaXML:=TStringList.Create;
  //        ListaXML.Append(Q.fieldbyname('moes_xmlnfe').asstring);
          ListaXML.Append(Q.fieldbyname('moes_xmlnfet').asstring);
          ListaXml.SaveToFile(arqxml);
          acbrcte1.Conhecimentos.Clear;
          acbrcte1.Conhecimentos.LoadFromFile(arqxml);
            Sistema.BeginProcess('Cancelando usando pasta '+acbrcte1.Configuracoes.Arquivos.PathSalvar );
            acbrcte1.Cancelamento( Ups(justificativa) );
            Sistema.BeginProcess('Consultando chave');
            acbrcte1.WebServices.Consulta.CTeChave := FExpNfetxt.GetTag('chNFe', acbrcte1.Conhecimentos.Items[0].XML );
            arqxmlretorno:=acbrcte1.Configuracoes.Arquivos.PathEvento+'\'+acbrcte1.WebServices.Consulta.CTeChave+'-procEventoCTe.xml';
            if not FileExists(arqxmlretorno) then begin
              Avisoerro('Arquivo XML de retorno n�o encontrado:'+arqxmlretorno);
              Sistema.EndProcess('Banco de dados n�o atualizado');
              exit;
            end;
            ListaXML.Clear;
            Sistema.BeginProcess('Lendo XML de retorno');
            ListaXml.LoadFromFile(arqxmlretorno);
            Grid.Cells[Grid.GetColumn('retornows'),Grid.row]:='Nfe Cancelada na Sefa';
            cretorno:=ListaXml.Strings[0];
        end;

        Sistema.BeginProcess('Atualizando o banco de dados');
        Sistema.Edit('movesto');
//        if pos(uppercase('Cancelamento de NF-e homologado'),uppercase(cretorno))>0 then begin
// 01.04.13 - Damama--PR finalmente cancelamento por evento...
        if pos(uppercase( 'registrado'),uppercase(cretorno))>0 then begin
           Sistema.setfield('moes_dtnfecanc',Sistema.hoje);
           if ( Global.Topicos[1033] ) then begin
             Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
             Sistema.setfield('Moes_Usua_CancNfe',Global.Usuario.Codigo);
             Sistema.setfield('moes_xmlnfecanc',FGeral.TiraBarra(memoRespWS.Lines.Text,chr(39),'"') );

           end else begin
             Sistema.setfield('moes_xmlnfecanc',ListaXml.Strings[0]) ;
             Sistema.setfield('moes_retornonfe','Cancelamento de NF-e homologado');
             Sistema.setfield('Moes_Usua_CancNfe',Global.Usuario.Codigo);
             Listaxml.Free;
           end;
        end;
        Sistema.setfield('moes_devolucoes',Justificativa);
        Sistema.Post('moes_transacao='+stringtosql(ct));
        if ( trim(justificativa)<>'' ) and
//           ( pos(uppercase('Cancelamento de NF-e homologado'),uppercase(cretorno))>0 ) then
           (  pos(uppercase( 'registrado'),uppercase(cretorno))>0 ) then
          Sistema.Commit
        else
          Avisoerro('Verificar.  Banco de dados n�o atualizado');
        Sistema.EndProcess('Processamento Terminado');
// 28.03.16
        if not confirma('Cancelar este conhecimento no sistema ?') then exit;
        FCanctransacao.Execute( ct,justificativa );

      end;
   end;
   FGeral.FechaQuery(Q);
end;

procedure TFGerenciaCte.GridClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
   if ( Grid.col=Grid.getcolumn('marcado') ) and ( trim(Grid.cells[Grid.getcolumn('moes_transacao'),Grid.row])<>'' ) then begin
     if Grid.cells[Grid.getcolumn('marcado'),Grid.row]='OK' then begin
       Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='';
//       dec(Chequesmarcados);
     end else begin
       Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='OK';
//       inc(Chequesmarcados);
     end;
   end;

end;

// 08.12.16
procedure TFGerenciaCte.GridKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
///////////////////////////////////////////////////////////////////////////////////////////
begin
   if key in [vk_UP, vk_Down] then  Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='';

end;

procedure TFGerenciaCte.binutilizaClick(Sender: TObject);
begin
  EdUNid_codigo.ValidFind;
  EdUNid_codigo.Valid;
  EdNUmeroi.Enabled:=true;
  EdNUmeroi.setfocus;

end;

procedure TFGerenciaCte.EdNumeroiExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
  EdNUmeroi.Enabled:=false;

end;

// 10.12.16
procedure TFGerenciaCte.EdNumeroiValidate(Sender: TObject);
////////////////////////////////////////////////////////////
var justificativa,arqxmlretorno,cretorno,x:string;
    ListaXML:TStringList;
    p:integer;
    Q:TSqlquery;
    Datapratras:TDatetime;
begin
   if AcbrCTe1.Configuracoes.Certificados.NumeroSerie='' then begin
     Avisoerro('N�o configurado certificado digital');
     exit;
   end;
// 25.05.16 - checar se ja foi autorizada
   Datapratras:=sistema.hoje-60;
   Q:=sqltoquery('select moes_dataemissao,moes_chavenfe,moes_dtnfeauto from movesto where moes_numerodoc = '+EdNumeroi.AsSql+
                 ' and moes_unid_codigo = '+EdUnid_codigo.assql+
                 ' and moes_dataemissao >= '+DAtetosql(datapratras)+
                 ' and Moes_status=''N''');
   if not Q.eof then begin
      if ( trim(Q.fieldbyname('moes_chavenfe').asstring)<>'' ) and ( Datetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)>=1921 ) then begin
        Avisoerro('Numero j� usado em CTe autorizado dia '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime));
        exit;
      end;
   end;
   Q.Close;
   if not confirma('Confirma inutiliza��o desta numera��o ?') then exit;
   if not Input('Justificativa','Motivo Cancelamento',justificativa,150,true) then exit;
  if trim(justificativa)='' then begin
    Avisoerro('Campo de preenchimento obrigat�rio');
    exit;
  end;
  if length(trim(justificativa))<15 then begin
    Avisoerro('Minimo de 15 caracteres para justificativa');
    exit;
  end;
  Sistema.BeginProcess('Enviando inutiliza��o para Sefa');

// para testes
//   InutilizaNumero( EdNumeroi.AsInteger );

  arqxmlretorno:='';
///////////////////////////////////
  eNFCe:='N';
  try
//////
// 17.09.15
      AcbrCTe1.WebServices.Inutiliza(EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring,
      Justificativa,Datetoano(sistema.Hoje,true),57,strtoint(EdUnid_codigo.resultfind.fieldbyname('unid_serie').asstring), EdNUmeroi.asinteger, EdNUmeroi.asinteger);
      eNFCe:='N';
//////
    ListaArquivos.Items.Clear;
    ListaArquivos.FileName:=AcbrCTe1.Configuracoes.Arquivos.PathInu;
    ListaArquivos.Update;
    ListaXML:=TStringList.Create;
    for p:=0 to ListaArquivos.Items.Count-1 do begin
       if ( ansipos( uppercase('inu'),uppercase(ListaArquivos.Items.Strings[p]) ) > 0  ) and
          ( ansipos( strzero(EdNumeroi.Asinteger,6),ListaArquivos.Items.Strings[p] ) > 0  ) and
          ( ansipos( uppercase('ped'),uppercase(ListaArquivos.Items.Strings[p]) ) = 0  ) then begin
// 14.04.11
         arqxmlretorno:=AcbrCTe1.Configuracoes.Arquivos.PathInu+'\'+ListaArquivos.Items.Strings[p];
         ListaXml.LoadFromFile(arqxmlretorno);
         cretorno:=FExpNfetxt.GetTag('xMotivo',ListaXml.Strings[0]);
         if trim(cretorno)<>'' then break;
       end;
    end;
/////////////////////////////////////
    if not FileExists(arqxmlretorno) then begin
      Sistema.EndProcess('Arquivo XML de retorno n�o encontrado em : '+arqxmlretorno);
    end else begin
//      cretorno:=FExpNfetxt.GetTag('xMotivo',ListaXml.Strings[0]);
// 14.04.11
      if trim(cretorno)='' then
        Sistema.EndProcess('Tag xMotivo n�o encontrada no arquivo '+arqxmlretorno)
      else begin
////////////////////////////////////////
        Sistema.EndProcess(cretorno);
// 07.11.13  - marcar com status 'I' numero de documento de saida com xml e data de autorizacao
//             para identificar nos relatorios mas nao enviar no sintegra
// 21.06.16 - Vivan - Cris
        if not Global.Usuario.OutrosAcessos[0344] then begin
          Sistema.BeginProcess('gravando');
          InutilizaNumero( EdNumeroi.AsInteger );
        end else begin
          if confirma('Marcar o conhecimento no sistema como INUTILIZADO ?') then begin
            Sistema.BeginProcess('gravando');
            InutilizaNumero( EdNumeroi.AsInteger );
          end;
        end;
      end;
      ListaXML.Free;
    end;
  except
    ListaArquivos.Items.Clear;
//    ListaArquivos.FileName:=AcbrCTe1.Configuracoes.Arquivos.GetPathInu;
//    ListaArquivos.FileName:=AcbrCTe1.Configuracoes.Arquivos.PathInu;
// 08.08.16
    ListaArquivos.FileName:=AcbrCTe1.Configuracoes.Arquivos.PathSalvar;
    ListaArquivos.Update;
    ListaXML:=TStringList.Create;
    for p:=0 to ListaArquivos.Items.Count-1 do begin
       if ( ansipos( uppercase('inu'),uppercase(ListaArquivos.Items.Strings[p]) ) > 0  ) and
          ( ansipos( strzero(EdNumeroi.Asinteger,6),ListaArquivos.Items.Strings[p] ) > 0  ) and
          ( ansipos( uppercase('ped'),uppercase(ListaArquivos.Items.Strings[p]) ) = 0  ) then begin
  //      arqxmlretorno:=AcbrCTe1.Configuracoes.Arquivos.GetPathInu+'\'+AcbrCTe1.WebServices.Consulta.NFeChave+'-inu.XML';
//         arqxmlretorno:=AcbrCTe1.Configuracoes.Arquivos.GetPathInu+'\'+ListaArquivos.Items.Strings[p];
//         arqxmlretorno:=AcbrCTe1.Configuracoes.Arquivos.PathInu+'\'+ListaArquivos.Items.Strings[p];
// 08.08.16
         arqxmlretorno:=AcbrCTe1.Configuracoes.Arquivos.PathSalvar+'\'+ListaArquivos.Items.Strings[p];
         ListaXml.LoadFromFile(arqxmlretorno);
         cretorno:=FExpNfetxt.GetTag('xMotivo',ListaXml.Strings[0]);
         if trim(cretorno)<>'' then break;
      end;
    end;
    if not FileExists(arqxmlretorno) then begin
      Sistema.EndProcess('Aten��o.  Arquivo XML de retorno n�o encontrado em : '+arqxmlretorno);
    end else begin
//      ListaXML:=TStringList.Create;
//      ListaXml.LoadFromFile(arqxmlretorno);
//      cretorno:=FExpNfetxt.GetTag('xMotivo',ListaXml.Strings[0]);
      if trim(cretorno)='' then
        Sistema.EndProcess('Tag xMotivo n�o encontrada no arquivo '+arqxmlretorno)
      else begin
        Sistema.EndProcess(cretorno);
// 07.11.13  - marcar com status 'I' numero de documento de saida com xml e data de autorizacao
//             para identificar nos relatorios mas nao enviar no sintegra
        if confirma('Marcar o conhecimento no sistema como INUTILIZADO ?') then begin
          Sistema.BeginProcess('gravando');
          InutilizaNumero( EdNumeroi.AsInteger );
        end;
      end;
      ListaXML.Free;
    end;
  end;
////////////////////////////////////////
end;

// 10.12.16
procedure TFGerenciaCte.InutilizaNumero(xNumero: Integer);
/////////////////////////////////////////////////////////////
var Q,QMovEstoque,QQtdeEstoque,QtdeEstoqueGrade:TSqlquery;
    sqldata,xtrans,sqlserie,mov:string;
    embalagem,xcodcor,xcodtamanho,xcodcopa:integer;
    sqlcor,sqltamanho,sqlcopa,xsqlcor,xsqltamanho,xsqlcopa:string;

begin
  sqldata:=' and moes_dataemissao >= '+Datetosql( Sistema.Hoje-360 );
  if eNFCe='S' then
    sqlserie:=' and moes_serie='+Stringtosql(FGeral.GetSerieNFCE)
  else
    sqlserie:=' and moes_serie='+Stringtosql(EdUnid_codigo.resultfind.fieldbyname('unid_serie').asstring);

  Q:=sqltoquery('select moes_transacao from movesto where moes_numerodoc='+inttostr(xnumero)+
                ' and moes_status<>''C'''+
                ' and ( (moes_dtnfeauto is null) or (substr(moes_especie,1,3)=''CTE'') )' +
// 10.09.14 - para nao inutilizar notas de servi�o com mesma numeracao de nfe...
                sqlserie+
                ' and moes_unid_codigo='+Stringtosql(EdUNid_codigo.text)+
                sqldata+
                ' and '+FGeral.GetIN('moes_tipomov',tiposdemovimento,'C')
                );
  xtrans:='';
  if not Q.eof then begin
//    Sistema.BeginTransaction('');
// 21.09.15 - primeiro 'desbaixa o estoque'
    QMOvestoque:=sqltoquery('select move_qtde,move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo,'+
                            'move_copa_codigo,move_tipomov,esto_embalagem from movestoque inner join estoque on (esto_codigo=move_esto_codigo)'+
                            'where move_transacao = '+Stringtosql(Q.fieldbyname('moes_transacao').asstring));
    mov:='E';
    while not QMOvestoque.eof do begin
          embalagem:=QMOvestoque.fieldbyname('esto_embalagem').asinteger;
//          if QQtdeEstoque=nil then
               QQtdeEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
            ' and esqt_unid_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring));
//          else begin
//            QQtdeEstoque.Close;
//            QQtdeEstoque.sql.text:='select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+StringtoSql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
//            ' and esqt_unid_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring);
//            QQtdeEstoque.open;
//          end;
////////////////  21.08.06
          xcodcor:=QMOvestoque.fieldbyname('move_core_codigo').asinteger;
          xcodtamanho:=QMOvestoque.fieldbyname('move_tama_codigo').asinteger;
          xcodcopa:=QMOvestoque.fieldbyname('move_copa_codigo').asinteger;
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
//          if QtdeEstoqueGrade=nil then
            QtdeEstoqueGrade:=sqltoquery('select * from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
            ' and esgr_unid_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring)+
            xsqlcor+xsqltamanho+xsqlcopa );
//          else begin
//            QtdeEstoqueGrade.Close;
//            QtdeEstoqueGrade.sql.text:='select * from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
//            ' and esgr_unid_codigo='+Stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring)+
 //           xsqlcor+xsqltamanho+xsqlcopa ;
//            QtdeEstoqueGrade.open;
//          end;
          if embalagem=0 then embalagem:=1;
          FGeral.MovimentaQtdeEstoque(QMOvestoque.fieldbyname('move_esto_codigo').asstring,
                QMOvestoque.fieldbyname('move_unid_codigo').asstring,Mov,QMOvestoque.fieldbyname('move_tipomov').asstring,
                QMOvestoque.fieldbyname('move_qtde').ascurrency*embalagem,QQtdeEstoque );
// 21.08.06
          FGeral.MovimentaQtdeEstoqueGrade(QMOvestoque.fieldbyname('move_esto_codigo').asstring,
                QMOvestoque.fieldbyname('move_unid_codigo').asstring,Mov,QMOvestoque.fieldbyname('move_tipomov').asstring,
                QMOvestoque.fieldbyname('move_core_codigo').asinteger,QMOvestoque.fieldbyname('move_tama_codigo').asinteger,
                QMOvestoque.fieldbyname('move_copa_codigo').asinteger,
                QMOvestoque.fieldbyname('move_qtde').ascurrency,QtdeEstoqueGrade );
      QMovEstoque.next;
      FGeral.Fechaquery(QQtdeEstoque);
      FGeral.Fechaquery(QtdeEstoqueGrade);
    end;
    FGeral.Fechaquery(QMovEstoque);

    Sistema.Edit('movesto');
    Sistema.SetField('moes_status','I');
    Sistema.SetField('moes_vlrtotal',0);
    Sistema.SetField('moes_baseicms',0);
    Sistema.SetField('moes_retornonfe','Numera��o Inutilizada em '+FGeral.FormataData(sistema.Hoje));
    Sistema.Post('moes_transacao = '+Stringtosql(Q.fieldbyname('moes_transacao').asstring));

    xtrans:=Q.fieldbyname('moes_transacao').asstring;

    Sistema.Edit('movestoque');
    Sistema.SetField('move_status','I');
    Sistema.SetField('move_venda',0);
    Sistema.SetField('move_qtde',0);
    Sistema.Post('move_transacao = '+Stringtosql(Q.fieldbyname('moes_transacao').asstring));

    Sistema.Edit('movbase');
    Sistema.SetField('movb_status','I');
    Sistema.SetField('movb_basecalculo',0);
    Sistema.Post('movb_transacao = '+Stringtosql(Q.fieldbyname('moes_transacao').asstring));

    Sistema.Edit('pendencias');
    Sistema.SetField('pend_status','I');
    Sistema.SetField('pend_valor',0);
    Sistema.Post('pend_transacao = '+Stringtosql(Q.fieldbyname('moes_transacao').asstring));
//    Sistema.EndTransaction('');
// 20.07.15
    Sistema.Commit;
    Aviso('Numera��o Inutilizada no sistema');
//  if trim(xtrans)<>'' then
//    FCanctransacao.Execute(xtrans);

  end else Aviso('Numera��o n�o encontrada.   Caso tenha apenas pulado a numera��o desconsidere este aviso.');
  Sistema.EndProcess('');
  FGeral.FechaQuery(Q);
// 08.11 - guardar 'algo' sobre nota inutilizada
   FGeral.GravaLog(27,'Numera��o do CTe inutilizada '+EdNumeroi.text,true);
end;

// 10.12.16
procedure TFGerenciaCte.bemailClick(Sender: TObject);
///////////////////////////////////////////////////////////
var i,
    marcados  :integer;
    emaildesti:string;
begin

   PCartacorrecao.Visible:=false;
   PCartacorrecao1.Visible:=false;
   ConfiguraEmailAcbr;
   AcbrCTe1.DACTE:=ACBrCTeDACTERL1;
 // 18.04.16
    if trim( FGeral.GetConfig1AsString('PastaPdfs') ) <> '' then
      AcbrCTe1.DACTE.PathPDF:=FGeral.GetConfig1AsString('PastaPdfs')
    else
      AcbrCTe1.DACTE.PathPDF:=ExtractFilePath( Application.ExeName );

    {
   if EdTipocad.text='T' then begin
     if not Input('Destinat�rio de e-mail','E-Mail',emaildesti,0,False)  or (emaildesti='') then exit;
     for i:=0 to Grid.rowcount do begin
       if Grid.Cells[Grid.getcolumn('marcado'),i]='OK' then begin
         EnviaEmail( Grid.Cells[Grid.getcolumn('moes_transacao'),i],emaildesti );
       end;
     end;
     Aviso('Email(s) enviados');
   end else
   }
// 29.05.20
    marcados := 0;
    for i:=0 to Grid.rowcount do begin
       if Grid.Cells[Grid.getcolumn('marcado'),i]='OK' then inc(marcados);
    end;

    if marcados = 1 then

         EnviaEmail( Grid.Cells[Grid.getcolumn('moes_transacao'),Grid.Row] )

    else begin

      if not Input('Destinat�rio de e-mail','E-Mail',emaildesti,0,False)  or (emaildesti='') then exit;
      for i:=0 to Grid.rowcount do begin

         if Grid.Cells[Grid.getcolumn('marcado'),i]='OK' then begin
           EnviaEmail( Grid.Cells[Grid.getcolumn('moes_transacao'),i],emaildesti );
         end;

      end;

    end;

    if marcados > 0 then

       Aviso('Email(s) enviados');



    //     EnviaEmail;

end;

// 20.03.17
procedure TFGerenciaCte.bgeraxmlClick(Sender: TObject);
//////////////////////////////////////////////////////////
var ct,ct1,codigosdesti,codigosdesti1,temxmltext,campoxml,ondesalvar,arq,pastasaC,
    emailescritorio,
    chavenfe  :string;
    marc,i    :integer;
    todos:boolean;
    ListaAnexos,
    Lista          :TStringList;
    CorpoEmailTexto:Tstrings;
begin

   todos:=Confirma('Gerar de todos do per�odo <S> ou somente selecionados(ok)<N> ?');
   ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row];
   codigosdesti:=Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),Grid.row];
   marc:=0;
   ct1:='';
   if not todos then begin
     for i:=0 to Grid.rowcount do begin
       if Grid.Cells[Grid.getcolumn('marcado'),i]='OK' then begin
         inc(marc);
         ct1:=ct1+Grid.Cells[Grid.getcolumn('moes_transacao'),i]+';';
         codigosdesti1:=codigosdesti1+Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),i]+';';
       end;
     end;
   end else begin
     for i:=0 to Grid.rowcount do begin
       if trim(Grid.Cells[Grid.getcolumn('moes_numerodoc'),i])<>'' then begin
         inc(marc);
         ct1:=ct1+Grid.Cells[Grid.getcolumn('moes_transacao'),i]+';';
         codigosdesti1:=codigosdesti1+Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),i]+';';
       end;
     end;
   end;

   if ct1<>'' then ct:=ct1;
   if trim(ct)='' then begin
      Avisoerro('Sem CT-e escolhido');
      exit;
   end;
   if trim(codigosdesti1)='' then begin
      Avisoerro('Sem cliente OU CT-e escolhido');
      exit;
   end;
   ConfiguraEmailAcbr;
   AcbrCTe1.DACTE:=ACBrCTeDACTERL1;
    if trim( FGeral.GetConfig1AsString('PastaPdfs') ) <> '' then
      AcbrCTe1.DACTE.PathPDF:=FGeral.GetConfig1AsString('PastaPdfs')
    else
      AcbrCTe1.DACTE.PathPDF:=ExtractFilePath( Application.ExeName );


   if codigosdesti1<>'' then codigosdesti:=codigosdesti1;
   campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
   temxmltext:='N';
   if campo.Tipo<>'' then begin
     temxmltext:='S';
     Q:=Sqltoquery('select * from movesto where '+
                 FGeral.GetIN('moes_transacao',ct,'C')+
                ' and '+FGeral.GetIN('moes_tipo_codigo',codigosdesti,'N')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                ' and moes_unid_codigo = '+EdUnid_codigo.assql+
                ' and moes_status<>''C'' order by moes_numerodoc')
   end else
     Q:=Sqltoquery('select * from movesto where '+
                 FGeral.GetIN('moes_transacao',ct,'C')+
                ' and '+FGeral.GetIN('moes_tipo_codigo',codigosdesti,'N')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                ' and moes_unid_codigo = '+EdUnid_codigo.assql+
                ' and moes_status<>''C'' order by moes_numerodoc');

   AcbrCTe1.Conhecimentos.Clear;
   if Q.eof then begin
     Avisoerro('Nada encontrado para gera��o.  Checar conhecimentos');
     FGeral.FechaQuery(Q);
     exit;
   end;
// 18.05.16
  ondesalvar := ExtractFilePath(Application.ExeName)+EdUnid_codigo.text+'\'+
                strzero(Datetoano(Q.fieldbyname('moes_dataemissao').AsDateTime,true),4)+
                strzero(Datetomes(Q.fieldbyname('moes_dataemissao').AsDateTime),2);
//                '\Geradas';
  if not DirectoryExists( OndeSalvar  ) then
      ForceDirectories( OndeSalvar );

  ondesalvar:=ondesalvar+'\';
  Sistema.beginprocess('Gerando XML(s)');
  while not Q.eof do begin

      campoxml:='moes_xmlnfet';
      if trim(Q.fieldbyname('moes_xmlnfet').asstring)='' then
        campoxml:='moes_xmlnfe';
// autorizada e nao cancelada na sefa
      if ( DAtetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)>1900 ) and
         ( DAtetoano(Q.fieldbyname('moes_dtnfecanc').asdatetime,true)<=1900 ) then begin
        AcbrCTe1.Conhecimentos.LoadFromStream( TStringStream.create( GetQualXml(Q,temxmltext) ) );
//        ListaTrans.Add(Q.fieldbyname('moes_transacao').asstring);
       if not FileExists( ondesalvar+copy(ACBrCTe1.Conhecimentos.Items[0].CTe.infCTe.id,4,44)+'-nfe.xml' ) then
         ACBrCTe1.Conhecimentos.Items[0].GravarXML(copy(ACBrCTe1.Conhecimentos.Items[0].CTe.infCTe.id,4,44)+'-nfe.xml',ondesalvar);
// 11.10.16 - canceladas tbem - Jackson - Presidente
      end else if  Q.fieldbyname('Moes_Usua_CancNfe').asinteger>0 then begin

// 23.02.2021 - Dimas - para enviar xml do cancelamento
        temxmltext:='X';
        Lista:=TStringList.Create;
        Lista.Append( GetQualXml(Q,temxmltext) );
        chavenfe:=FExpNfetxt.GetTag('chcte',Lista.Text);
        if not FileExists( ondesalvar+(chavenfe)+'-can.xml' ) then
           Lista.SaveToFile( ondesalvar+(chavenfe)+'-can.xml' );
        Lista.Clear;
        temxmltext:='S';
 {
        AcbrCTe1.Conhecimentos.LoadFromStream( TStringStream.create( GetQualXml(Q,temxmltext) ) );
        if not FileExists( ondesalvar+copy(ACBrCTe1.Conhecimentos.Items[0].CTe.infCTe.id,4,44)+'-can.xml' ) then
        chavenfe:=FExpNfetxt.GetTag('chnfe',Lista.Text);
        if not FileExists( ondesalvar+(chavenfe)+'-can.xml' ) then
          ACBrCTe1.Conhecimentos.Items[0].GravarXML(copy(ACBrCTe1.Conhecimentos.Items[0].CTe.infCTe.id,4,44)+'-can.xml',ondesalvar);
}

      end;
      ACBrCTe1.Conhecimentos.Clear;
      Q.Next;
  end;

   FGeral.FechaQuery(Q);

   Sistema.EndProcess('');
   Arq:=strzero(Datetoano(EdTermino.AsDate,true),4)+
        strzero(Datetomes(EdTermino.AsDate),2)+'.rar';

//   if not FileExists( 'Winrar.exe' ) then begin
//   if ExtractFilePath( 'Winrar.exe' )  = '' then begin
//   if ExtractFileDir( 'Winrar.exe' )  = '' then begin
//   if ExtractFileDrive( 'Winrar.exe' )  = '' then begin
//     Sistema.EndProcess('N�o encontrado o Winrar.exe');
//     exit;
//   end;


   ChDir( OndeSalvar  ) ;

//   if not FileExists( 'Winrar.exe' ) then begin
//     Sistema.endprocess('N�o encontrado o Winrar.exe para compactar os XMLs.   Processo Interrompido !');
//     exit;
//   end;

   emailescritorio:=FGeral.GetConfig1AsString('emailcontador');
   //if not Edcliente.IsEmpty then emailescritorio:='';

   Sistema.BeginProcess('Gerando arquivo compactado em '+ondesalvar+Arq);
//   DeleteFile( ondesalvar+Arq );  // por enquanto nao precisa pois cria novamente com todos os xmls
// pega apenas os xml que come�am por 4 ( 41, 42 )
   try
     ShellExecute(0,nil,'Winrar.exe',  PChar ('a -ep -ibck "'+OndeSalvar+'"'+Arq+' 4*.xml' ), nil, sw_show);
     sleep(5000);
   except
     Sistema.endprocess('N�o foi poss�vel executar o Winrar para compactar os XMLs.   Processo Interrompido !');
     exit;
   end;
   Sistema.BeginProcess('Gerado arquivo compactado em '+ondesalvar+Arq);
   pastasac:=ExtractFileDir( Application.exename );
   ChDir( pastasac  ) ;
   ListaAnexos:=TStringList.create;
   if FileExists( ondesalvar+Arq ) then begin
     if trim(emailescritorio)='' then
       Input('Informe Destino','Email',emailescritorio,50,false);
     Sistema.EndProcess('Gerado arquivo compactado em '+ondesalvar+Arq);
     ListaAnexoS.add(ondesalvar+Arq);
     if trim(emailescritorio)<>'' then begin
       Sistema.BeginProcess('Enviando email para '+emailescritorio);
       CorpoEmailTexto:=TstringList.Create;
       CorpoEmailTexto.Add('Anexo arquivo '+ListaAnexos[0]);
       CorpoEmailTexto.Add('XMLs refente '+strzero(Datetomes(EdTermino.AsDate),2)+'/'+
                        strzero(Datetoano(EdTermino.AsDate,true),4) );
// 16.09.15 - refazendo...
       FGeral.EnviaEMailcomAnexo(emailescritorio,ListaAnexos,CorpoEmailTexto,'CT-e');
// 24.01.15
//       FRel.SendMail(emailescritorio);
       Sistema.endprocess('');
       CorpoEmailTexto.free;
     end;

   end else
     Sistema.EndProcess('Problemas ao gerar o arquivo compactado.  Verificar !');
   ListaAnexos.free;

end;

// 10.12.1
procedure TFGerenciaCte.ConfiguraEmailAcbr;
////////////////////////////////////////////////////
begin

   Acbrmail1.from:=FGeral.getconfig1asstring('EMAILORIGEM');
   Acbrmail1.Host:=FGeral.getconfig1asstring('SMTP');
   Acbrmail1.Username:=FGeral.getconfig1asstring('USUARIOSMTP');
   Acbrmail1.Password:=FGeral.getconfig1asstring('SENHASMTP');
   Acbrmail1.Port:=inttostr(FGeral.GetConfig1AsInteger('portasmtp'));
   Acbrmail1.SetSSL  :=false;
   if FGeral.EmailStmpcomSSL( FGeral.GetConfig1AsString('EMAILORIGEM') ) then
     Acbrmail1.SetSSL:=true;
   ACBrMail1.SetTLS := true; // Auto TLS
// 22.12.20
   ACBrMail1.UseThread:= true;
//   ACBrMail1.ReadingConfirmation := False; //Pede confirmação de leitura do email

end;

// 12.12.16
procedure TFGerenciaCte.bcartacorrecaoClick(Sender: TObject);
////////////////////////////////////////////////////////////////////
var ct,codigosdesti,chave,codorgao,cnpj,nseqevento,correcao:string;

    procedure SetaGrupos;
    ///////////////////////
    begin
//      EdSgrupo.Items.Clear;
//      EdSgrupo.Items.Add();
    end;

    procedure SetaCampos;
    //////////////////////
    begin
      EdScampo.Items.Clear;
      EdScampo.Items.Add('Endere�o Destinat�rio');
      EdScampo.Items.Add('Endere�o Remetente');
      EdScampo.Items.Add('Fone Destinat�rio');
    end;

begin

   if Grid.Cells[Grid.GetColumn('marcado'),Grid.row]<>'OK' then exit;

   SetaGrupos;
   SetaCampos;
   Pcce.Visible:=true;
   Pcce.Enabled:=true;
   Edscampo.SetFocus;


end;

// 12.12.16
procedure TFGerenciaCte.EdsvalorExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////
var ct,codigosdesti,chave,idlote,codorgao,cnpj,nseqevento,correcao,xmlretorno:string;
begin
   ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row];
   codigosdesti:=Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),Grid.row];
   Q:=Sqltoquery('select moes_xmlnfe,moes_xmlnfet,moes_dtnfeauto,moes_transacao,moes_dtnfecanc,moes_protodpec,moes_numerodoc,moes_chavenfe,moes_tipocad from movesto where '+
                 FGeral.GetIN('moes_transacao',ct,'C')+
                ' and '+FGeral.GetIN('moes_tipo_codigo',codigosdesti,'N')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                ' and moes_status<>''C'' order by moes_numerodoc');
   if Q.eof then begin
     Avisoerro('Nada encontrado para envio.  Checar nota');
     exit;
   end;
   chave:=Q.fieldbyname('moes_chavenfe').asstring;
   if trim(chave)='' then begin
     Avisoerro('Conhecimento sem chave (44 d�gitos).   Verificar');
     exit;
   end;
//   if Acbrnfe1.Configuracoes.Certificados.DataVenc < Sistema.Hoje then begin
   if not AcbrCTe1.Configuracoes.Certificados.VerificarValidade then begin
//     Avisoerro('Certificado digital em uso vencido em '+Fgeral.FormataData(AcbrCTe1.Configuracoes.Certificados.DataVenc));
     Avisoerro('Certificado digital em uso vencido. '+AcbrCTe1.Configuracoes.Certificados.DadosPFX);
     exit;
   end;
   Pcce.Visible:=false;
   Pcce.Enabled:=false;
   PCartacorrecao.Visible:=true;
   PCartacorrecao1.Visible:=true;
   idLote := inttostr( FGEral.GetContador('LOTECCENFE'+EdUnid_codigo.text,false) );
   codOrgao := copy(Chave,1,2);
   CNPJ := copy(Chave,7,14);
   nSeqEvento := '1';
//   Correcao := 'Corre��o a ser considerada, texto livre. A corre��o mais recente substitui as anteriores.';
   Correcao := space(100);
//   if not(InputQuery('Envio de Carta de Corre��o', 'Corre��o a ser considerada', Correcao)) then
//      exit;
// 02.10.2012 - Clessi
   if not(InputQuery('Evento da Carta de Corre��o', 'Sequencia de Corre��o dentro de um mesmo CT-e', nSeqEvento)) then
      exit;
   AcbrCTe1.EventoCTe.Evento.Clear;
   with AcbrCTe1.EventoCTe.Evento.Add do
   begin
     infEvento.chCTe := Chave;
     infEvento.cOrgao := StrToInt(codOrgao);
     infEvento.CNPJ   := CNPJ;
     infEvento.dhEvento := now;
     infEvento.tpEvento := teCCe;
     infEvento.nSeqEvento := StrToInt(nSeqEvento);
     infEvento.versaoEvento := '1.00';
     infEvento.detEvento.descEvento := 'Carta de Corre��o';
     infEvento.detEvento.xJust := Correcao;
//     sgrupo:='EnderRem';
//     scampo:='nro';
     svalor:=Edsvalor.text;
     with infEvento.detEvento.infCorrecao.Add do begin
       grupoAlterado:=sgrupo;
       campoalterado:=scampo;
       valorAlterado:=svalor;
       nroItemAlterado:=1;
     end;
//     infEvento.detEvento.xCondUso := '{"http://www.portalfiscal.inf.br/cte"}';
//     infEvento.detEvento.xCondUso :=
//           'A Carta de Corre��o � disciplinada pelo Art. 58-B do CONV�NIO/SINIEF 06/89: Fica permitida'+
//           ' a utiliza��o de carta de corre��o, para regulariza��o de erro ocorrido na emiss�o de documentos'+
//           ' fiscais relativos � presta��o de servi�o de transporte, desde que o erro n�o esteja relacionado'+
//           ' com: I - as vari�veis que determinam o valor do imposto tais como: base de c�lculo, al�quota,'+
//           ' diferen�a de pre�o, quantidade, valor da presta��o;II - a corre��o de dados cadastrais que implique'+
//           ' mudan�a do emitente, tomador, remetente ou do destinat�rio;III - a data de emiss�o ou de sa�da.';

//     infEvento.detEvento.xCondUso :='A Carta de Correcao e disciplinada pelo paragrafo 1o-A do art.'+
//                                    '7o do Convenio S/N, de 15 de dezembro de 1970 e pode ser utilizada '+
//                                    'para regularizacao de erro ocorrido na emissao de documento fiscal, '+
//                                    'desde que o erro nao esteja relacionado com: I - as variaveis que determinam '+
//                                    'o valor do imposto tais como: base de calculo, aliquota, diferenca de preco, '+
//                                    'quantidade, valor da operacao ou da prestacao; II - a correcao de dados cadastrais '+
//                                    'que implique mudanca do remetente ou do destinatario; III - a data de emissao ou de saida.';
     if FGeral.GetConfig1AsString('AmbienteCte')='1' then
       InfEvento.tpAmb:=taProducao
     else
       InfEvento.tpAmb:=taHomologacao;
     infEvento.detEvento.xJust := Correcao;

   end;
   Sistema.BeginProcess('Enviando carta de corre��o para Sefa');

   try
     AcbrCTe1.EnviarEvento(StrToInt(idLote));
   finally
     MemoResp.Lines.Text := UTF8Encode(AcbrCTe1.WebServices.EnvEvento.RetWS);
     memoRespWS.Lines.Text := UTF8Encode(AcbrCTe1.WebServices.EnvEvento.RetornoWS);
     xmlretorno:=AcbrCTe1.Configuracoes.Arquivos.PathEvento+
                  '\110110'+chave+strzero(strtoint(nSeqEvento),2)+'-procEventoCTe.xml';
     if FileExists( xmlretorno ) then
       memoRespWS.Lines.LoadFromFile( xmlretorno );
   end;

//   Sistema.EndProcess( AcbrCTe1.WebServices.EnvEvento.CCeRetorno.xMotivo );
//   Sistema.EndProcess( AcbrCTe1.WebServices.EnvEvento.CCeRetorno.retEvento.Items[0].RetInfEvento.xMotivo );

//    Sistema.EndProcess( memoRespWS.Lines.Text );

//   MemoResp.Lines.SaveToFile((ExtractFileDir(application.ExeName))+'\CCe01'+IdLote+'.xml');
//   MemoRespWs.Lines.SaveToFile((ExtractFileDir(application.ExeName))+'\CCeCT'+strzero(Q.fieldbyname('moes_numerodoc').asinteger,6)+IdLote+'.xml');
   Q.close;
// 10.07.14
   Sistema.Edit('movesto');
//   Sistema.SetField('moes_xmlcce',MemoRespWs.Lines.Text);
//   Sistema.SetField('moes_xmlcce',MemoResp.Lines.Text);
// 07.04.16
//   Sistema.SetField('moes_xmlcce',FGeral.TiraBarra( MemoResp.Lines.Text,chr(39),'"'));
// 14.12.16
   Sistema.SetField('moes_xmlcce',FGeral.TiraBarra( MemoRespWS.Lines.Text,chr(39),'"'));
   Sistema.SetField('moes_obs',Correcao);
   Sistema.Post('moes_transacao='+Stringtosql(ct));
   Sistema.Commit;
/////////////////

//   LoadXML(MemoResp, WBResposta);
//  MyMemo.Lines.SaveToFile(PathWithDelim(ExtractFileDir(application.ExeName))+'temp.xml');
//  MyWebBrowser.Navigate(PathWithDelim(ExtractFileDir(application.ExeName))+'temp.xml');

    Sistema.EndProcess( 'Cce enviada' );
end;

// 12.12.16
procedure TFGerenciaCte.EdscampoValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
   if Edscampo.text='Endere�o Destinat�rio' then begin
     sgrupo:='dest';
     scampo:='enderDest';
   end else if Edscampo.text='Fone Destinat�rio' then begin
     sgrupo:='dest';
     scampo:='fone';
   end else if EdScampo.Text='Endere�o Remetente' then begin
     sgrupo:='rem';
     scampo:='enderReme';
   end else begin
     sgrupo:='';
     scampo:='';
   end;

end;

// 13.12.16
procedure TFGerenciaCte.bimpcceClick(Sender: TObject);
///////////////////////////////////////////////////////
var ct,codigosdesti,chave,idlote,codorgao,cnpj,nseqevento,correcao:string;
begin
   ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row];
   codigosdesti:=Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),Grid.row];
   Q:=Sqltoquery('select moes_xmlcce,moes_xmlnfet,moes_dtnfeauto,moes_transacao,moes_obs,moes_numerodoc,moes_chavenfe from movesto where '+
                 FGeral.GetIN('moes_transacao',ct,'C')+
                ' and '+FGeral.GetIN('moes_tipo_codigo',codigosdesti,'N')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                ' and moes_status<>''C'' order by moes_numerodoc');
   if Q.eof then begin
     Avisoerro('Nada encontrado para envio.  Checar nota');
     exit;
   end;
   chave:=Q.fieldbyname('moes_chavenfe').asstring;
   if trim(chave)='' then begin
     Avisoerro('Conhecimento sem chave.   Verificar');
     exit;
   end;
   if trim(Q.fieldbyname('moes_xmlcce').AsString)='' then begin
     Avisoerro('Conhecimento sem carta de corre��o gravada.   Verificar');
     exit;
   end;

   AcbrCTe1.DaCTE:=AcbrCTeDaCTERL1;
   ACBrCTeDACTeRL1.MostraPreview := True;
   AcbrCTe1.Conhecimentos.Clear;
   AcbrCTe1.Conhecimentos.LoadFromString( Q.fieldbyname('moes_xmlnfet').AsString );
   AcbrCTe1.EventoCTe.Evento.Clear;
   codOrgao := copy(Chave,1,2);
   CNPJ := copy(Chave,7,14);
//   AcbrCTe1.EventoCTe.LerXMLFromString(Q.fieldbyname('moes_xmlcce').AsString);
// 24.03.15

//   with AcbrCTe1.EventoCTe.Evento.Items[0] do begin
   with AcbrCTe1.EventoCTe.Evento.Add do begin
      InfEvento.tpEvento := teCCe;
      InfEvento.cOrgao:=StrToInt(codOrgao);
      InfEvento.chCTe:=chave;
      InfEvento.CNPJ:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').AsString;
      if FExpNfetxt.GetTag('tpAmb',Q.fieldbyname('moes_xmlcce').asstring)='1' then
         InfEvento.tpAmb:=taProducao
      else
         InfEvento.tpAmb:=taHomologacao;
      infEvento.dhEvento := Texttodate(
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),9,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),6,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),1,04) )+
         StrToTime( copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),12,05) );

      infEvento.nSeqEvento := strtoint(FExpNfetxt.GetTag('nSeqEvento',Q.fieldbyname('moes_xmlcce').asstring));
      infEvento.detEvento.descEvento := FExpNfetxt.GetTag('xEvento',Q.fieldbyname('moes_xmlcce').asstring);
      infEvento.detEvento.xJust := Q.fieldbyname('moes_obs').asstring;
//      infEvento.detEvento.nProt:= FExpNfetxt.GetTag('nProt',Q.fieldbyname('moes_xmlcce').asstring);

      RetInfEvento.cStat:= strtoint( FExpNfetxt.GetTag('cStat',Q.fieldbyname('moes_xmlcce').asstring));
      RetInfEvento.xMotivo:= FExpNfetxt.GetTag('xMotivo',Q.fieldbyname('moes_xmlcce').asstring);
      RetInfEvento.nProt:=FExpNfetxt.GetTag('nProt',Q.fieldbyname('moes_xmlcce').asstring);
      RetInfEvento.dhRegEvento:=Texttodate(
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),9,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),6,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),1,04) )+
         Strtotime( copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),12,05) );

     with infEvento.detEvento.infCorrecao.Add do begin
       grupoAlterado:=FExpNfetxt.GetTag('grupoAlterado',Q.fieldbyname('moes_xmlcce').asstring);
       campoalterado:=FExpNfetxt.GetTag('campoAlterado',Q.fieldbyname('moes_xmlcce').asstring);
       valorAlterado:=FExpNfetxt.GetTag('valorAlterado',Q.fieldbyname('moes_xmlcce').asstring);
       nroItemAlterado:=1;
     end;

//      infEvento.detEvento.infCorrecao.   dhEmi:=Texttodate(
//         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),9,02)+
//         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),6,02)+
//         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),1,04)
//         );
   end;

   AcbrCTe1.ImprimirEvento;
   AcbrCTe1.DaCTE:=AcbrCTeDaCTERL1;

end;

end.
