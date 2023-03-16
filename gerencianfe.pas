////// {$DEFINE WHATSAPP}

unit gerencianfe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrNFe, Grids, SqlDtg, StdCtrls, Mask, SQLEd, Buttons, SQLBtn,
  alabel, SQLGrid, ExtCtrls, SqlExpr, ACBrNFeDANFEClass,
  ACBrNFeDANFeRLClass, ACBrDANFCeFortesFrA4, ACBrDANFCeFortesFr, ACBrBase,
  ACBrDFe, DB, DBClient, SimpleDS, SqlSis, FileCtrl,
    //ACBrNFeDANFERave,
  pcnConversao, backup,pcnconversaonfe,
  ShellApi, ACBrMail,
// ACBrNFeDANFERaveCB,
  //ACBrDANFCeFortesFrA4rm,
  ACBrDANFCeFortesFrEA, tbPrn, ACBrDFeReport, ACBrDFeDANFeReport,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Vcl.OleCtrls, SHDocVw, VerificaSessaots;

type
  TFGerenciaNfe = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bconsultar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Edtermino: TSQLEd;
    EdInicio: TSQLEd;
    pgrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    bvexml: TSQLBtn;
    bimpdanfe: TSQLBtn;
    PrintDialogBoleto: TPrintDialog;
    SQLPanelGrid1: TSQLPanelGrid;
    ComboBox1: TComboBox;
    StaticText1: TStaticText;
    bcancelanfe: TSQLBtn;
    binutiliza: TSQLBtn;
    EdNumeroi: TSQLEd;
    listaarquivos: TFileListBox;
    bemail: TSQLBtn;
    bconsultasefa: TSQLBtn;
    bimpdanfexml: TSQLBtn;
    OpenDialog1: TOpenDialog;
    datas: TDataSource;
    TMovesto:TSqlds;
    bcartacorrecao: TSQLBtn;
    PCartacorrecao: TSQLPanelGrid;
    Pcartacorrecao1: TSQLPanelGrid;
    MemoResp: TMemo;
    MemoRespWs: TMemo;
    bgeraxml: TSQLBtn;
    bimpcce: TSQLBtn;
    Edtipomov: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdCliente: TSQLEd;
    bimpnfce: TSQLBtn;
//    ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes;
//    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    EdTipocad: TSQLEd;
    EdNumerof: TSQLEd;
    bxmlcanc: TSQLBtn;
    ACBrNFe1: TACBrNFe;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes;
    bwhatsapp: TSQLBtn;
    ACBrMail1: TACBrMail;
    sbchecanumeracao: TSpeedButton;
    sbchecanumeracaonfe: TSpeedButton;

    procedure EdAmbienteExitEdit(Sender: TObject);
    procedure bconsultarClick(Sender: TObject);
    procedure bvexmlClick(Sender: TObject);
    procedure bimpdanfeClick(Sender: TObject);
    procedure GridClick(Sender: TObject);
    procedure EdUnid_codigoExitEdit(Sender: TObject);
    procedure bcancelanfeClick(Sender: TObject);
    procedure binutilizaClick(Sender: TObject);
    procedure EdNumeroiValidate(Sender: TObject);
    procedure Enviaemail(xtrans:string='';xemail:string='' );
    procedure bconsultasefaClick(Sender: TObject);
    procedure bimpdanfexmlClick(Sender: TObject);
    procedure EdUnid_codigoValidate(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure bemailClick(Sender: TObject);
    procedure bcartacorrecaoClick(Sender: TObject);
    procedure bgeraxmlClick(Sender: TObject);
    procedure bimpcceClick(Sender: TObject);
    procedure Teste(Sender: TObject);
    procedure bimpnfceClick(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdTipocadValidate(Sender: TObject);
    procedure EdClienteValidate(Sender: TObject);
    procedure EdNumerofValidate(Sender: TObject);
    procedure EdNumerofExitEdit(Sender: TObject);
    procedure bxmlcancClick(Sender: TObject);
    procedure APHeadLabel1Click(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure bwhatsappClick(Sender: TObject);
    procedure sbchecanumeracaoClick(Sender: TObject);
    procedure sbchecanumeracaonfeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute( numeronota:string=''  ; situacaonotas:string='' );
    function GetSituacao(Q:TSqlquery):string;
    function GetRetornoWS(Q:TSqlquery):string;
    procedure AtualizaGrid(nf:integer ; xretorno:string);
    function TrataRetornoXMotivo( StringXml:String ):string ;
    function GetQualXml( Q:TSqlquery ;temcampo:string):String;
// 07.11.13
    procedure InutilizaNumero( xNumero,xNumerof:Integer );
// 08.07.15
    procedure ImprimeNfeNFCe( xmodelo:integer );
// 30.12.15
    procedure ConfiguraEmailAcbr;
// 21.06.2022
    function EimpressoraSetada(  impdasesssao , xsitnotas, yimp :string):Boolean;

  end;

var
  FGerenciaNfe: TFGerenciaNfe;
  Tiposdemovimento,TiposNao,arquivorave,sqlcliente,xsituacaonotas,sqlautorizadas:string;
  campo:TDicionario;
  xnumeronota,eNFCe:string;

//  ACBrNFeDANFERave1:TACBrNFeDANFERave;
//  ACBrNFe1:TACBrNFe;


implementation

uses Geral, Sqlfun, SQLRel, pcnNFe, Mostraxml, Printers,
     ACBrNFeNotasFiscais, expnfetxt, ACBrNFeConfiguracoes , Arquiv,
//  pcnCCeNFe,
  ConfDcto, pcnEnvEventoNFe, Canctrans, Transp, cadcli,
  ACBrDFeConfiguracoes,ClipBrd,System.IOUtils, gerenciawhats, fornece;

{$R *.dfm}

{ TFGerenciaNfe }

procedure TFGerenciaNfe.Execute( numeronota:string='' ; situacaonotas:string='' );
////////////////////////////////////////////////////////////////////////////////////
var codigo,s,impvalidas,
    ximp,
    user,
    idsessaots :string;
    p          :integer;
    i          : Dword;

     function  ValidaImpressoraUsuario( s,idts:string ) : string;
     ///////////////////////////////////////////////////////////////
     var u:integer;
     begin

         u := AnsiPos( 'redirecionada',s);
         if u > 0 then

            result := 'S'

         else begin

//           showmessage(s+' n�o achou '+'('+idts+' redirecionada');
           result:= 'N';

         end;

     end;


    {
    function EimpressoraSetada(  impdasesssao , xsitnotas :string):Boolean;
    //////////////////////////////////////////////////////////////////////
    var s1,
        nomeimp:string;

        function RetiraDirecionada( nomei:string):string;
        /////////////////////////////////////////////////
        var a:Integer;
        begin
           a := AnsiPos( 'redirecionada',nomei);
           result := '';
           if a > 0 then
              Result := substr(nomei,1,a-1);
        end;

    begin

       result := False;
       nomeimp := RetiraDirecionada( impdasesssao );

       if  (Global.UsaNFCe='S')  and ( xsituacaonotas = 'NFCe' ) and ( xIMP='S' ) then begin

          s1:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFCE');
           if trim(s1)<>'' then begin

              s1 := RetiraDirecionada(s1) ;
              if Trim(s1) = Trim(nomeimp) then Result := True;

          end;

      end else if  (Global.UsaNfe='S')  and ( xsituacaonotas = 'NFE' ) and ( xIMP='S' ) then begin

          s1:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFCE');
          if trim(s1)<>'' then begin

              s1 := RetiraDirecionada(s1) ;
              if Trim(s1) = Trim(nomeimp) then Result := True;

          end;

      end;

    end;
    }


begin

//  ACBrNFeDANFERave1:=TACBrNFeDANFERave.Create(self);
//  ACBrNFe1:=TACBrNFe.Create(self);
///////////////////  ACBrNFeDANFERave1.ACBrNFe:=ACBrNFe1;

//  bgeraxml.Visible:=Global.Usuario.OutrosAcessos[0334]=true;
//  bgeraxml.Enabled:=Global.Usuario.OutrosAcessos[0334]=true;

   sbchecanumeracao.enabled:=(Global.Usuario.codigo=100);
   sbchecanumeracao.Visible:=(Global.Usuario.codigo=100);
   sbchecanumeracaonfe.enabled:=(Global.Usuario.codigo=100);
   sbchecanumeracaonfe.Visible:=(Global.Usuario.codigo=100);

   arquivorave:=ExtractFilePath(Application.ExeName)+'NotaFiscalEletronica.rav';

////////////   if Global.Usuario.Codigo=100 then  arquivorave:=ExtractFilePath(Application.ExeName)+'NotaFiscalEletronicarm.rav';

   // 31.01.13
//  arquivorave:=ExtractFilePath(Application.ExeName)+'DANFE_Rave513.rav';
  if not FileExists(arquivorave) then
     arquivorave:='\nfesac\NotaFiscalEletronica.rav';
  if not FileExists(arquivorave) then begin
     Avisoerro('Arquivo .RAV n�o encontrado');
     exit;
  end;
//  ACBrNFeDANFERave1.RavFile:=arquivorave;
  Show;
  Grid.clear;
  EdUnid_codigo.text:=Global.CodigoUnidade;
  tiposdemovimento:=Global.TiposSaida+';'+Global.CodDevolucaoCompra+';'+Global.CodCompraProdutor+';'+
                    Global.CodDrawBackEnt+';'+Global.CodDevolucaoIgualVenda+';'+Global.CodEntradaImobilizado+';'+
                    Global.CodCompraProdutorReclassifica+';'+Global.CodCompraConsignado+';'+Global.CodDevolucaodeRemessa+';'+
                    Global.CodDevolucaoRoman+';'+Global.CodEstornoNFeSai+';'+Global.codCompraProdutorMerenda+';'+
                    Global.CodNfeComplementoValorProdutor+';'+
// 04.12.20
                    Global.CodDevolucaoBonificacao+';'+
                    FGeral.GetConfig1AsString('TIPOSENUMSAIDA'); // 18.05.11
// 29.07.15
//Acbrnfe1.DANFE:=ACBrNFeDANFERave1;
  Acbrnfe1.DANFE:=ACBrNFeDANFeRL1;
// 11.02.17
  ACBrNFe1.MAIL:=AcbrMail1;

// 26.03.09 - colocado tipo ET - entrada de imobilizado
// 30.09.10 - colocado tipo DA - devolucao de romaneio
// 13.04.16 - colocado DC e DR - FAma - Janina..imprimia 2 vias de cada nfe...
  tiposnao:=Global.TiposNaoFiscal+';'+Global.CodVendaInterna+';'+Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca;
  if trim(FGeral.GetConfig1AsString('Pastaexpnfexml'))<>'' then begin
    acbrnfe1.Configuracoes.Arquivos.PathNFe:=FGeral.GetConfig1AsString('Pastaexpnfexml');
    Acbrnfe1.DANFE.PathPDF:=FGeral.GetConfig1AsString('Pastaexpnfexml');
// 28.09.2021
    ACBrNFeDANFCeFortes1.PathPDF:=FGeral.GetConfig1AsString('Pastaexpnfexml');
    ACBrNFeDANFCeFortes1.PathPDF:=FGeral.GetConfig1AsString('Pastaexpnfexml');

  end;
  acbrnfe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(EdUnid_codigo.text);
//  if trim(FGeral.GetConfig1AsString('NumSerieCert'))<>'' then
//    acbrnfe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetConfig1AsString('NumSerieCert');
  if trim(FGeral.GetConfig1AsString('Pastaretonfexml'))<>'' then begin
    acbrnfe1.Configuracoes.Arquivos.PathEvento:=FGeral.GetConfig1AsString('Pastaretonfexml');
// 15.03.10
    acbrnfe1.Configuracoes.Arquivos.PathSalvar:=FGeral.GetConfig1AsString('Pastaretonfexml');
  end;
  if trim(FGeral.GetConfig1AsString('Pastainunfexml'))<>'' then
    acbrnfe1.Configuracoes.Arquivos.PathInu:=FGeral.GetConfig1AsString('Pastainunfexml');

  if trim(FGeral.GetConfig1AsString('Pastaimagemdanfe'))<>'' then begin
// 21.09.18 - Agro Geffer
    if FileExists( ExtractFilePath( Application.ExeName ) + '\logo'+Global.CodigoUnidade+'.bmp' ) then begin

        AcbrnfeDanfeRL1.Logo:=ExtractFilePath( Application.ExeName ) +  '\logo'+Global.CodigoUnidade+'.bmp';
        ACBrNFeDANFCeFortes1.Logo:=ExtractFilePath( Application.ExeName ) + '\logo'+Global.CodigoUnidade+'.bmp';
//    Acbrnfe1.DANFE.Logo:=FGeral.GetConfig1AsString('Pastaimagemdanfe')
// 28.04.11
    end else if FileExists( FGeral.GetConfig1AsString('Pastaimagemdanfe') ) then begin

        AcbrnfeDanfeRL1.Logo:=FGeral.GetConfig1AsString('Pastaimagemdanfe');
        ACBrNFeDANFCeFortes1.Logo:=FGeral.GetConfig1AsString('Pastaimagemdanfe');

    end else if FileExists( ExtractFilePath( Application.ExeName ) + FGeral.GetConfig1AsString('Pastaimagemdanfe') ) then begin

        AcbrnfeDanfeRL1.Logo:=ExtractFilePath( Application.ExeName )+ FGeral.GetConfig1AsString('Pastaimagemdanfe');
        ACBrNFeDANFCeFortes1.Logo:=ExtractFilePath( Application.ExeName )+ FGeral.GetConfig1AsString('Pastaimagemdanfe');
    end else begin

      AcbrnfeDanfeRL1.Logo:='';
      ACBrNFeDANFCeFortes1.Logo:='';
      ACBrNFe1.DANfe.Logo:='';
    end;
  end else begin
//    Acbrnfe1.DANFE.Logo:='';
    AcbrnfeDanfeRL1.Logo:='';
    ACBrNFeDANFCeFortes1.Logo:='';
  end;
  if trim(FGeral.GetConfig1AsString('AmbienteNFe'))<>'' then begin
    if FGeral.GetConfig1AsString('AmbienteNFe')='1' then
      acbrnfe1.Configuracoes.WebServices.Ambiente:=taProducao
    else
      acbrnfe1.Configuracoes.WebServices.Ambiente:=taHomologacao;
  end else
      acbrnfe1.Configuracoes.WebServices.Ambiente:=taHomologacao;
// 21.09.10 - configura aqui por caso de 'atualizar o componente'
  ACbrNfe1.Configuracoes.Arquivos.Salvar:=true;
//  if Sistema.Hoje>=Texttodate('01102010') then
//    Acbrnfe1.Configuracoes.Geral.PathSchemas:=ExtractFilePath( Application.ExeName )+'Schemas20'
  if trim( FGeral.GetConfig1AsString('Pastaschemas') ) <> '' then
    Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=FGeral.GetConfig1AsString('Pastaschemas')
  else
//    Acbrnfe1.Configuracoes.Geral.PathSchemas:=ExtractFilePath( Application.ExeName )+'Schemas';
// 01.04.2011
    Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=ExtractFilePath( Application.ExeName )+'Schemas20';
// 15.01.16
  if trim(acbrnfe1.Configuracoes.Arquivos.PathEvento)<>'' then
      acbrnfe1.Configuracoes.Arquivos.PathEvento:=FGeral.GetConfig1AsString('Pastaschemas')
// 07.04.16
  else
    Acbrnfe1.Configuracoes.Arquivos.PathEvento:=ExtractFilePath( Application.ExeName )+'Schemas20';

// 18.04.16 - pra tratar RM
   if FGeral.getconfig1asinteger('TAMFONTEDANFE')>0 then
      ACBrNFeDANFERL1.Fonte.TamanhoFonteDemaisCampos :=FGeral.getconfig1asinteger('TAMFONTEDANFE')
   else
      ACBrNFeDANFERL1.Fonte.TamanhoFonteDemaisCampos:=10;

//   if FGeral.getconfig1asinteger('TAMFONTEDANFE')>0 then
//      ACBrNFeDANFERL1.EspacoEntreProdutos:=FGeral.getconfig1asinteger('TAMFONTEDANFE')
//   else
////      ACBrNFeDANFERL1.EspacoEntreProdutos:=40;

// 04.10.2010 - path pdf para envio de email com pdf
// 19.03.15
//  if global.topicos[1041] then
//    Acbrnfe1.Configuracoes.Geral.VersaoDF:=ve310;

// 02.08.18
    Acbrnfe1.Configuracoes.Geral.VersaoDF:=ve400;

//  else
//    Acbrnfe1.Configuracoes.Geral.VersaoDF:=ve200;
// 06.07.15 - NFC-e
  xsituacaonotas:=situacaonotas;
///////////////
  if EdInicio.isempty then
    EdInicio.setdate(sistema.hoje);
  if EdTermino.isempty then
    EdTermino.setdate(sistema.hoje);
// 08.04.18 - para uso principalmente em servidor TS
  impvalidas:=LeArquivoINI('SAC','IMPRESSORAS','IMPVALIDA');
// 21.06.2022
  ximp := 'N';

  if impvalidas <> '' then begin

     for p := 0 to Printer.Printers.Count-1 do begin

       if AnsiPos( Printer.Printers.Strings[p],impvalidas ) > 0  then
         Combobox1.Items.Add(Printer.Printers.Strings[p]  );

     end;

  end else begin

    ximp := LeArquivoINI(Global.NomeSistema,'Impressoras','TS');
// preenche o combobox1 somente com as impressoras remotas validas na sessao
    if xImp = 'S' then begin

       I := 255;
       SetLength(user, I);
       Windows.GetUserName(PChar(user), I);
       user := string(PChar(user));
       idsessaots := Checa( user );
       for p := 0 to Printer.Printers.Count-1 do begin

           if ValidaImpressoraUsuario(Printer.Printers[p],idsessaots) = 'S' then begin

               Combobox1.Items.Add(Printer.Printers.Strings[p]  );
               if EimpressoraSetada(  Printer.Printers[p] , xsituacaonotas, ximp ) then
                  ComboBox1.Text:= Printer.Printers.Strings[p] ;

           end;

       end;

    end else begin

        Combobox1.Items.Assign(Printer.Printers);

    end;



  end;

//  Combobox1.ItemIndex:=Printer.PrinterIndex;
// usa a impressora configurada no impresso da nota de saida em formulario continou
  Codigo:=FGeral.GetConfig1AsString('Imprnotasaida');
//  FConfDcto.GetConfiguracao(Codigo);
  s:=GetIni(Sistema.NameSystem+'D','Impressoras','DCTO'+Codigo);
  if s<>'' then
    Combobox1.Text:=s
  else
    Combobox1.ItemIndex:=Printer.PrinterIndex;
// 10.12.15
//  if (Global.UsaNFCe='S') then begin
// 31.05.2022 - guiber - 'printer index out or range' na nfe danfe...
//              ajustado para fazer s� se vier chamado da venda balcao E for nfce
  if  (Global.UsaNFCe='S')  and ( xsituacaonotas = 'NFCe' ) and ( xIMP='N' ) then begin

     s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFCE');
     if trim(s)<>'' then begin
        Combobox1.Text:=s;
// 22.08.18 - ainda a impressao errada na jato quando....benato
        for p := 0 to Combobox1.Items.Count-1 do begin
            if Combobox1.Items.Strings[p] = s then begin
               Printer.PrinterIndex := p;
               ComboBox1.ItemIndex:=p;
            end;
        end;

     end;

  end;

// 03.06.2022 - Guiber - para nao mudar a impressora caso for chamada da nota consumidor...
  if  ( xsituacaonotas <> 'NFCe' ) then begin

    // 04.02.20 - Novicarnes - impress�o 'direta'
    s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFE');

    if s<>'' then
      Combobox1.Text:=s
    else
      Combobox1.ItemIndex:=Printer.PrinterIndex;

  end;
  xnumeronota:=numeronota;
  PCartacorrecao.Visible:=false;
  PCartacorrecao1.Visible:=false;
  if trim(xnumeronota)<>'' then begin
// 20.04.18 - pra ver se para de imprimir nfce na impressa de nfe - Benato
//    Printer.PrinterIndex := ComboBox1.ItemIndex;
    ACBrNFeDANFCeFortes1.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];
 ////////
    EdUnid_codigo.Next;   // 31.07.11
    bconsultarClick(self);
  end else begin
    EdInicio.SetFirstEd;
  end;
// 16.12.13
  bcancelanfe.Enabled:=(not Global.Topicos[1037]);
  Edcliente.Enabled:=Global.Usuario.OutrosAcessos[0339];
  EdTipocad.Enabled:=Global.Usuario.OutrosAcessos[0339];
  Edcliente.text:='';
  FGeral.ConfiguraColorEditsNaoEnabled(FGerenciaNfe);
// 04.08.18
  FGeral.ConfiguraCriptografiaAcbrNfe( AcbrNfe1 );
// 28.08.20
  bwhatsapp.visible:=false;

  if ( Global.Usuario.OutrosAcessos[0352] ) and ( FGerenciaWhats <> nil ) then begin

      if not FGerenciaWhats.login then begin

         Avisoerro('N�o foi poss�vel acessar o servi�o do Whatsapp');
         exit;

      end;
      bwhatsapp.visible:=true;

  end;

end;

procedure TFGerenciaNfe.EdAmbienteExitEdit(Sender: TObject);
begin
   bconsultarclick(self);
end;

procedure TFGerenciaNfe.bconsultarClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqlexp,sqlnotas,sqlconfmov,sqltipomov,
    sqltiposmov,
    sqlorder :string;
    p        :integer;

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
//    sqlconfmov:=' and moes_comv_codigo <> '+inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'));
// 07.11.14
    sqlconfmov:=' and '+FGeral.GetNOTIN('moes_comv_codigo',inttostr(FGeral.GetConfig1AsInteger('ConfMovECF'))+';'+inttostr(FGeral.GetConfig1AsInteger('ConfMovECFVC')),'N') ;
// 16.04.15
  sqltipomov:='';
  if Edtipomov.text='S' then sqltipomov:=' and '+FGeral.getin('moes_tipomov',Global.CodCompraProdutor,'C');
// 19.05.15 - Coorlaf Pitanga
  sqlcliente:='';
  if not Edcliente.isempty then begin
    if Edtipocad.text='T'  then
      sqlcliente:=' and moes_tran_codigo ='+Stringtosql(strzero(EdCliente.asinteger,3))
    else
      sqlcliente:=' and moes_tipo_codigo ='+EdCliente.assql+' and moes_tipocad = ''C''';
  end;
// 03.04.16 - Primos - Neto
  sqlautorizadas:='';
  if EdTipomov.text='A' then sqlautorizadas:=' and moes_dtnfeauto > '+DatetoSql(Global.DataMenorBanco)+
                                             ' and moes_dtnfecanc is null';
// 05.05.17
  sqltiposmov:='';
  if trim( FGeral.GetConfig1AsString('TIPOSNAOAUTORIZA') ) <> ''  then
    sqltiposmov:=' and '+FGeral.GetNOTIN('moes_tipomov',FGeral.GetConfig1AsString('TIPOSNAOAUTORIZA'),'C');
// 27.01.20 - Devereda LInda
  if EdInicio.AsDate = EdTermino.asdate then

     sqlorder := ' order by moes_numerodoc desc '

  else

     sqlorder := ' order by moes_numerodoc,moes_datamvto,moes_vispra ' ;

  Q:=sqltoquery('select movesto.*,clientes.clie_razaosocial,clientes.clie_tipo,clientes.clie_endres,clientes.clie_uf from movesto'+
                ' left join clientes on (clie_codigo=moes_tipo_codigo)'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N;E;D;X;I','C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                sqlconfmov+sqltipomov+sqlcliente+sqlautorizadas+
//                ' and  moes_datacont>1'+
// 18.05.11
                ' and moes_datacont > '+DatetoSql(Global.DataMenorBanco)+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                sqlexp+sqlnotas+sqltiposmov+
//                ' and moes_tipocad='+stringtosql(Cv)+
//                ' order by moes_numerodoc,moes_datamvto,moes_vispra' );
// 27.01.20 - Devereda - Linda
               sqlorder );
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
    if ( (trim(xnumeronota)<>'') and ( xnumeronota=Q.fieldbyname('moes_numerodoc').asstring) ) or ( not EdCliente.isempty )
     or ( EdTipomov.text='A' ) then
      Grid.Cells[Grid.GetColumn('marcado'),p]:='OK';

    Grid.Cells[Grid.GetColumn('moes_chavenfe'),p]:=Q.fieldbyname('moes_chavenfe').asstring;
    Grid.Cells[Grid.GetColumn('moes_transacao'),p]:=Q.fieldbyname('moes_transacao').asstring;
    Grid.Cells[Grid.GetColumn('retornows'),p]:=Q.fieldbyname('moes_retornonfe').asstring;
    Grid.Cells[Grid.GetColumn('especie'),p]:=Q.fieldbyname('moes_especie').asstring;
    Grid.AppendRow;
    inc(p);
    Q.Next;
  end;
  Grid.SetFocus;
//  GetRetornoWs(Q);

end;

function TFGerenciaNfe.GetSituacao(Q:TSqlquery): string;
///////////////////////////////////////////////////////////
begin
//  result:='XML N�O Exportado';
  result:='Nota ainda N�O autorizada';
  if Q.fieldbyname('moes_nfeexp').AsString='S' then begin
    result:='XML Exportado';
    if trim(Q.fieldbyname('moes_chavenfe').AsString)='' then
      result:='Ainda n�o autorizada pela SEFA';
    if Q.fieldbyname('moes_status').AsString='I' then
      result:='Numera��o Inutilizada';
  end;
  if  ( trim(Q.fieldbyname('moes_chavenfe').AsString) <>'' )
      then begin

      result:='Autorizada';
 // 09.09.19

      if  ( Ansipos('DENEGA',Uppercase(Q.fieldbyname('moes_retornonfe').AsString) ) > 0 ) then

        result:='a ser Denegada no sistema';

    if Datetoano(Q.fieldbyname('moes_dtnfecanc').AsDateTime,true)>1920 then
      result:='Cancelada';

  end else if Q.fieldbyname('moes_status').AsString='I' then
    result:='Numera��o Inutilizada';

end;

function TFGerenciaNfe.GetRetornoWS(Q: TSqlquery): string;
begin
//  ACBrNFe1.WebServices.StatusServico.Executar;
//  ShowMessage(ACBrNFe1.WebServices.StatusServico.Msg)
end;

procedure TFGerenciaNfe.bvexmlClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var ct,temxmltext,arqxml:string;
    Q:TSqlquery;
//    Str:TMemoryStream;
    wxml:AnsiString;
    Lista:TStringList;
begin
   ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row];
   campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
   if campo.Tipo<>'' then begin
     temxmltext:='S';
     Q:=Sqltoquery('select moes_xmlnfe,moes_xmlnfet,moes_xmlnfecanc,moes_dataemissao,moes_numerodoc from movesto where moes_transacao='+Stringtosql(ct)+
                 ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C''')
   end else
     Q:=Sqltoquery('select moes_xmlnfe,moes_dataemissao,moes_numerodoc from movesto where moes_transacao='+Stringtosql(ct)+
                 ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C''');
//   Str:=TMemoryStream.Create;
   if not Q.eof then begin
//     LoadBlob('movesto','moes_xmlnfe','moes_transacao='+Stringtosql(ct),str);
//     LoadBlob('movesto','moes_xmlnfet','moes_transacao='+Stringtosql(ct),str);
//     FMostraXml.Execute( str );
//     wxml:=Q.fieldbyname('moes_xmlnfe').asstring;
     if trim(Q.fieldbyname('moes_xmlnfecanc').asstring)<>'' then
       wxml:=GetQualxml( Q,'X' )
     else
       wxml:=GetQualxml( Q,'S' );
// 27.06.17
     if trim(wxml)='' then begin
        Lista:=TStringList.Create;
        arqxml:= acbrnfe1.Configuracoes.Arquivos.PathNFe+'\'+
                strzero(Datetoano(Q.fieldbyname('moes_dataemissao').AsDateTime,true),4)+
                strzero(Datetomes(Q.fieldbyname('moes_dataemissao').AsDateTime),2)+'\'+
                inttostr(Q.FieldByName('moes_numerodoc').AsInteger)+
                strzero(Datetodia(Q.fieldbyname('moes_dataemissao').AsDateTime),2)+
                strzero(Datetomes(Q.fieldbyname('moes_dataemissao').AsDateTime),2)+
                strzero(Datetoano(Q.fieldbyname('moes_dataemissao').AsDateTime,false),2)+
                '-NFe.xml';
        if FileExists( arqxml ) then begin
           Lista.LoadFromFile(arqxml);
           wxml:=Lista.Strings[0];
           Lista.Free;
        end;
     end;
     if trim(wxml)<>'' then
       FMostraXml.Execute(  wxml )
     else
       Avisoerro('N�o foi poss�vel encontrar o xml desta nota');
   end;
   FGeral.FechaQuery(Q);
end;

// 31.08.20
procedure TFGerenciaNfe.bwhatsappClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
var ct,
    arqpdf,
    fone,
    mensagem    :string;
    i           :integer;

begin

     if Global.Usuario.OutrosAcessos[0352] then begin


      for i:=0 to Grid.rowcount do begin

        if Grid.Cells[Grid.getcolumn('marcado'),i]='OK' then begin

          ct := trim( Grid.Cells[Grid.GetColumn('moes_transacao'),i] );
          Q  := Sqltoquery('select moes_xmlnfe,moes_dtnfeauto,moes_numerodoc,moes_dtnfecanc,moes_xmlnfet,moes_chavenfe,'+
                     ' moes_tipo_codigo,moes_tipocad from movesto where moes_transacao='+Stringtosql(ct)+
                     ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                     ' and moes_status<>''C''');

          if Q.eof then begin

              Avisoerro('Transa��o '+ct+' n�o encontrada');
              exit;

          end;

          if trim(Q.fieldbyname('moes_xmlnfet').asstring)='' then begin

            Avisoerro('Transa��o '+ct+' sem XML gravado');
            exit;

          end else if DAtetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)<=1900 then begin

            Avisoerro('Transa��o '+ct+' ainda n�o foi autorizada');
            exit;

          end else if DAtetoano(Q.fieldbyname('moes_dtnfecanc').asdatetime,true)>1900 then begin

            Avisoerro('NFe ref. Transa��o '+ct+' j� foi cancelada na Sefa em '+Fgeral.FormataData(Q.fieldbyname('moes_dtnfecanc').asdatetime));
            exit;

          end;

          if Q.fieldbyname('moes_tipocad').asstring = 'C' then

             fone := FCadCli.getcelular( Q.fieldbyname('moes_tipo_codigo').asinteger )

          else

             fone := FFornece.getcelular( Q.fieldbyname('moes_tipo_codigo').asinteger );


          if trim(fone)='' then begin

             Input('Informe telefone','Numero',fone,10,false);

          end;


          fone := strtostrnumeros( fone );
          if length(trim(fone)) < 10 then begin

             Avisoerro('Fone '+fone+' faltando d�gitos.  Verificar');
             exit;

          end else if length(trim(fone)) > 10 then begin

             Avisoerro('Fone '+fone+' sobrando d�gitos.  Verificar');
             exit;

          end;


          ACBrNFe1.NotasFiscais.Clear;
          ACBrNFe1.NotasFiscais.LoadFromStream( TStringStream.Create( Q.fieldbyname('moes_xmlnfet').asstring ) );

          if Q.fieldbyname('moes_numerodoc').asinteger<>ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF then begin

             Avisoerro('NFe escolhida '+inttostr(Q.fieldbyname('moes_numerodoc').asinteger)+
                      'NFe do XML para cancelamento '+inttostr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF) );
            exit;

          end;

          AcbrNfe1.NotasFiscais.Items[0].ImprimirPDF;

          arqpdf := ACBrNFe1.Configuracoes.Arquivos.PathNFe +
                    '\'+Q.fieldbyname('moes_chavenfe').asstring +
                    '-nfe.pdf';

          mensagem :=  'NF-e '+Q.fieldbyname('moes_numerodoc').asstring+' - '+
                       FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,
                                                  Q.fieldbyname('moes_tipocad').asstring,
                                                  'N');



          FGerenciaWhats.EnviaArquivo(fone,arqpdf,mensagem);

          DeleteFile( arqpdf );

        end;

      end;

    end;


end;

// 14.06.18
procedure TFGerenciaNfe.bxmlcancClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var ct,codigosdesti,chave,idlote,codorgao,cnpj,nseqevento,
    correcao,
    emailsdestino,
    emaildestino,
    emaildestino1,
    localxml,
    assunto       :string;
    CorpoEmail,
    ListaEmails,
    ListaAnexos,
    ListadoXml    : TStringList;

begin

   ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row];
   codigosdesti:=Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),Grid.row];
   Q:=Sqltoquery('select moes_xmlnfecanc,moes_xmlnfet,moes_dtnfeauto,moes_transacao,'+
                'moes_obs,moes_numerodoc,moes_chavenfe,moes_tipo_codigo,moes_tipocad,moes_dataemissao from movesto where '+
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
     Avisoerro('Nota sem chave da NFe.   Verificar');
     exit;
   end;
   if trim(Q.fieldbyname('moes_xmlnfecanc').AsString)='' then begin
     Avisoerro('Nota sem XML de cancelamento gravado.   Verificar');
     exit;
   end;

   ListaEmails:=TStringList.Create;
   CorpoEmail :=TStringList.Create;
   ListaAnexos:=TStringList.Create;
   ListadoXml:=TStringList.Create;

       emailsdestino:=FGeral.GetEmailEntidade(Q.fieldbyname('moes_tipo_codigo').AsInteger,Q.fieldbyname('moes_tipocad').asstring,'S');
       emaildestino:='';
       emaildestino1:='';
       if pos(';',emailsdestino)>0 then begin
         emaildestino:=copy(emailsdestino,1,pos(';',emailsdestino)-1);
         emaildestino1:=copy(emailsdestino,pos(';',emailsdestino)+1,60);
         strtolista(ListaEmails,emailsdestino,';',true);
       end else begin
         emaildestino:=emailsdestino;  // 01.06.16
         ListaEmails.Clear;
       end;
       if trim(emaildestino)='' then begin
         if not Input('Destinat�rio de e-mail','E-Mail',emaildestino,0,False)  or (emaildestino='') then exit;
       end;

       CorpoEmail.Add( 'Anexo XML cancelamento Nf-e '+Q.FieldByName('moes_numerodoc').AsString );
       CorpoEmail.Add( ' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime) );
       CorpoEmail.Add(  ' ' );
       CorpoEmail.Add(  ' ' );
       CorpoEmail.Add(  EdUnid_codigo.resultfind.fieldbyname('unid_razaosocial').AsString );
       CorpoEmail.Add(  FGeral.Formatacnpj( EdUnid_codigo.resultfind.fieldbyname('Unid_cnpj').AsString ) );
       CorpoEmail.Add(  EdUnid_codigo.resultfind.fieldbyname('Unid_endereco').AsString );
       CorpoEmail.Add(  EdUnid_codigo.resultfind.fieldbyname('Unid_bairro').AsString+' - '+
                        EdUnid_codigo.resultfind.fieldbyname('Unid_municipio').AsString  );
       CorpoEmail.Add(  FGeral.Formatatelefone( EdUnid_codigo.resultfind.fieldbyname('Unid_fone').AsString ) );
       CorpoEmail.Add(  EdUnid_codigo.resultfind.fieldbyname('Unid_email').AsString );


///////////////   Acbrnfe1.DANFE:=ACBrNFeDANFCeFortes1;
//   Acbrnfe1.DANFE:=AcbrNfeDanfeRL1;
//   ACBrNFeDANFCeFortes1.MostrarPreview := False;

   ConfiguraEmailAcbr;
   assunto := 'Anexo XML cancelamento Nf-e '+Q.FieldByName('moes_numerodoc').AsString +
              ' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime);

   ACBrNFe1.NotasFiscais.Clear;
   ACBrNFe1.NotasFiscais.LoadFromString( Q.fieldbyname('moes_xmlnfet').AsString );
   localxml := Acbrnfe1.Configuracoes.Arquivos.PathInu+'\Xmlcancelado.xml';
   ListadoXml.Add( Q.fieldbyname('moes_xmlnfecanc').AsString );
   ListadoXml.SaveToFile( localxml );
   ListaAnexos.Add( localxml );
   ACBrNFe1.EventoNFe.Evento.Clear;
//   ACBrNFe1.EventoNFe.LerXMLFromString(Q.fieldbyname('moes_xmlnfecanc').asstring) ;
//   ACBrNFe1.EventoNFe.LerXML( localxml ) ;

   codOrgao := copy(Chave,1,2);
   CNPJ := copy(Chave,7,14);

   with ACBrNFe1.EventoNFe.Evento.Add do begin

      InfEvento.tpEvento := teCancelamento;
      InfEvento.cOrgao:=StrToInt(codOrgao);
      InfEvento.chNFe:=chave;
      InfEvento.CNPJ:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').AsString;
      if FExpNfetxt.GetTag('tpAmb',Q.fieldbyname('moes_xmlnfecanc').asstring)='2' then
         InfEvento.tpAmb:=taHomologacao
      else
         InfEvento.tpAmb:=taProducao;
      infEvento.dhEvento := Texttodate(
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlnfecanc').asstring),9,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlnfecanc').asstring),6,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlnfecanc').asstring),1,04)
         );
      infEvento.nSeqEvento := strtoint(FExpNfetxt.GetTag('nSeqEvento',Q.fieldbyname('moes_xmlnfecanc').asstring));
      infEvento.detEvento.descEvento := FExpNfetxt.GetTag('xEvento',Q.fieldbyname('moes_xmlnfecanc').asstring);
      infEvento.detEvento.xCorrecao := Q.fieldbyname('moes_obs').asstring;
      infEvento.detEvento.nProt:= FExpNfetxt.GetTag('nProt',Q.fieldbyname('moes_xmlnfecanc').asstring);
      infEvento.detEvento.dhEmi:=Texttodate(
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlnfecanc').asstring),9,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlnfecanc').asstring),6,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlnfecanc').asstring),1,04)
         );
      infEvento.id  := FExpNfetxt.GetTag('idLote',Q.fieldbyname('moes_xmlnfecanc').asstring);

   end;

   FGeral.EnviaEMailcomAnexo(emaildestino,ListaAnexos,CorpoEmail,'Canc',assunto);

//   ACBrNFe1.EnviarEmailEvento(emaildestino,'XML Cancelamento NF-e '+Q.FieldByName('moes_numerodoc').AsString,
//                              nil,nil,nil,nil);
   ListaEmails.free;
   Corpoemail.free;
   ListaAnexos.free;
   ListadoXml.free;

//   Acbrnfe1.DANFE:=AcbrNfeDanfeRL1;

end;

procedure TFGerenciaNfe.bimpdanfeClick(Sender: TObject);
//////////////////////////////////////////////////////////
var s:string;
begin
  Acbrnfe1.DANFE:=ACBrNFeDANFERL1;
  ImprimeNfeNFCe( 55 );
// 11.06.18 - Benato - para ja retornar a impressorinha de nfc-e
  if (Global.UsaNFCe='S') then begin
     s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFCE');
     if trim(s)<>'' then Combobox1.Text:=s;
  end;

end;

procedure TFGerenciaNfe.GridClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////////////////////////////
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

procedure TFGerenciaNfe.EdUnid_codigoExitEdit(Sender: TObject);
begin
     bconsultarclick(self);

end;

procedure TFGerenciaNfe.bcancelanfeClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
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
     Avisoerro('Marcar apenas UMA nfe para cancelamento');
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
   ACBrNFe1.NotasFiscais.Clear;
   ACBrNFe1.NotasFiscais.LoadFromStream( TStringStream.Create( Q.fieldbyname('moes_xmlnfet').asstring ) );
   if Q.fieldbyname('moes_numerodoc').asinteger<>ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF then begin
      Avisoerro('NFe escolhida '+inttostr(Q.fieldbyname('moes_numerodoc').asinteger)+
                'NFe para cancelamento '+inttostr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF) );
      exit;
   end;
   PCartacorrecao.Visible:=true;
   PCartacorrecao1.Visible:=true;

///////////////////////////////////  por evento a
        if ( Global.Topicos[1033] ) then begin

          idLote := inttostr( GetSequencia('CancNFe'+EdUnid_codigo.text,true) );
//          if not(InputQuery('Cancelamento por Eventos: Cancelamento', 'Identificador de controle do Lote de envio do Evento', idLote)) then
//             exit;
//          if not(InputQuery('Cancelamento por Eventos: Cancelamento', 'Justificativa', vAux)) then
//             exit;
//          if length(trim(vaux))<15 then begin
//             Avisoerro('M�nimo de 15 caracteres para justificativa');
//             exit;
//          end;
          ACBrNFe1.EventoNFe.Evento.Clear;
          ACBrNFe1.EventoNFe.idLote := StrToInt(idLote) ;
          with ACBrNFe1.EventoNFe.Evento.Add do
          begin
//           infEvento.dhEvento := now;
//           infEvento.dhEvento := Sistema.hoje;
// 30.04.13 - sefa MT
           infEvento.dhEvento := Sistema.Hoje+Time();
           infEvento.tpEvento := teCancelamento;
           infEvento.detEvento.xJust := justificativa;
           InfEvento.CNPJ:=ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
//////////           InfEvento.tpAmb:=acbrnfe1.Configuracoes.WebServices.Ambiente;
           if FGeral.GetConfig1AsString('AmbienteNFe')='1' then
             InfEvento.tpAmb:=taProducao
           else
             InfEvento.tpAmb:=taHomologacao;

//           InfEvento.chNFe:=copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,3,44);
// deixado o componente colocar
//           InfEvento.cOrgao:=91;  // ambiente nacional ou 91 ??
//           InfEvento.cOrgao:=strtoint( copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,4,2) );
          end;
          Sistema.BeginProcess('Enviando Evento de Cancelamento');
//          try

            ACBrNFe1.EnviarEvento(StrToInt(idLote));

//          except
//            Aviso('Problemas ao enviar o evento');
//          end;
            if ACBrNFe1.WebServices.EnvEvento<>nil then begin
            with ACBrNFe1.WebServices.EnvEvento do begin
              if EventoRetorno<>nil then begin
                if EventoRetorno.retEvento.Count>0 then begin
                  if EventoRetorno.retEvento.Items[0].RetInfEvento.cStat <> 135 then
                  begin
                    raise Exception.CreateFmt(
                      'Ocorreu o seguinte erro ao cancelar a nota fiscal eletr�nica:'  + sLineBreak +
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

            MemoResp.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.EnvEvento.RetWS);
            memoRespWS.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.EnvEvento.RetornoWS);
            cretorno:=IntToStr(ACBrNFe1.WebServices.EnvEvento.cStat)+'-'+FExpNfetxt.GetTag('xMotivo',MemoResp.Lines.Text);
  //          LoadXML(MemoResp, WBResposta);
            ShowMessage('Retorno='+cretorno);
  //          ShowMessage('cStat='+IntToStr(ACBrNFe1.WebServices.EnvEvento.cStat));
//            ShowMessage('Nprot='+ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt);
//          except
//            Aviso('Problemas ao enviar o evento');
//          end;
        end else begin
/////////////////////////////////////
          Sistema.BeginProcess('Enviando Cancelamento');
          arqxml:= ExtractFilePath( Application.ExeName )+'CancelaNF'+Q.fieldbyname('moes_numerodoc').asstring+'.TXT';
          ListaXML:=TStringList.Create;
  //        ListaXML.Append(Q.fieldbyname('moes_xmlnfe').asstring);
          ListaXML.Append(Q.fieldbyname('moes_xmlnfet').asstring);
          ListaXml.SaveToFile(arqxml);
          AcbrNfe1.NotasFiscais.Clear;
          AcbrNfe1.NotasFiscais.LoadFromFile(arqxml);
            Sistema.BeginProcess('Cancelando usando pasta '+AcbrNfe1.Configuracoes.Arquivos.PathSalvar );
            AcbrNfe1.Cancelamento( Ups(justificativa) );
            Sistema.BeginProcess('Consultando chave');
            ACBrNFe1.WebServices.Consulta.NFeChave := FExpNfetxt.GetTag('chNFe', ACBRNfe1.NotasFiscais.Items[0].XML );
  //          arqxmlretorno:=AcbrNfe1.Configuracoes.Arquivos.GetPathCan+'\'+ACBrNFe1.WebServices.Consulta.NFeChave+'-can.XML';
  // 15.03.10 - Asatec no c:
            arqxmlretorno:=AcbrNfe1.Configuracoes.Arquivos.PathEvento+'\'+ACBrNFe1.WebServices.Consulta.NFeChave+'-can.XML';
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
        if pos(uppercase( 'processado'),uppercase(cretorno))>0 then begin
           Sistema.setfield('moes_dtnfecanc',Sistema.hoje);
//           if ( Global.Topicos[1033] ) then begin
// 14.06.18 - deixado fixo sempre por evento senao grava errado xml de cancelamento
             Sistema.setfield('moes_retornonfe',copy(cretorno,1,150));
             Sistema.setfield('Moes_Usua_CancNfe',Global.Usuario.Codigo);
             Sistema.setfield('moes_xmlnfecanc',FGeral.TiraBarra(memoRespWS.Lines.Text,chr(39),'"') );

//           end else begin
//
//             Sistema.setfield('moes_xmlnfecanc',ListaXml.Strings[0]) ;
//             Sistema.setfield('moes_retornonfe','Cancelamento de NF-e homologado');
//             Sistema.setfield('Moes_Usua_CancNfe',Global.Usuario.Codigo);
//             Listaxml.Free;
//           end;

        end;
        Sistema.setfield('moes_devolucoes',Justificativa);
        Sistema.Post('moes_transacao='+stringtosql(ct));
        if ( trim(justificativa)<>'' ) and
//           ( pos(uppercase('Cancelamento de NF-e homologado'),uppercase(cretorno))>0 ) then
           (  pos(uppercase( 'processado'),uppercase(cretorno))>0 ) then
          Sistema.Commit
        else
          Avisoerro('Verificar.  Banco de dados n�o atualizado');
        Sistema.EndProcess('Processamento Terminado');
// 28.03.16
        if not confirma('Cancelar esta nota no sistema ?') then exit;
        FCanctransacao.Execute( ct,justificativa );

      end;
   end;
   FGeral.FechaQuery(Q);
end;

procedure TFGerenciaNfe.binutilizaClick(Sender: TObject);
begin
//  if EdUNid_codigo.isempty then EdUnid_codigo.text:=Global.CodigoUnidade;
  EdUNid_codigo.ValidFind;
  EdUNid_codigo.Valid;
  EdNUmeroi.Enabled:=true;
  EdNUmerof.Enabled:=true;
  EdNUmeroi.setfocus;
end;

procedure TFGerenciaNfe.bSairClick(Sender: TObject);
begin

//    if Global.usuario.codigo = 100 then
//
//        if Confirma('Fazer logoff') then FGerenciaWhats.logout;

end;

// 23.05.17
procedure TFGerenciaNfe.EdNumerofExitEdit(Sender: TObject);
begin
  EdNUmeroi.Enabled:=false;
  EdNUmerof.Enabled:=false;

end;

procedure TFGerenciaNfe.EdNumerofValidate(Sender: TObject);
////////////////////////////////////////////////////////////
var justificativa,arqxmlretorno,cretorno,x:string;
    ListaXML:TStringList;
    p,numero:integer;
    Q:TSqlquery;
    Datapratras:TDatetime;

begin

   if EdNumerof.asinteger<EdNUmeroi.AsInteger then begin
     Avisoerro('Numero final tem que ser MAIOR q o inicial');
     exit;
   end;

   if ACBrNFe1.Configuracoes.Certificados.NumeroSerie='' then begin
     Avisoerro('N�o configurado certificado digital');
     exit;
   end;
// 25.05.16 - checar se ja foi autorizada
   Datapratras:=sistema.hoje-60;
   Q:=sqltoquery('select moes_dataemissao,moes_chavenfe,moes_dtnfeauto from movesto where moes_numerodoc = '+EdNumeroi.AsSql+
                 ' and moes_unid_codigo = '+EdUnid_codigo.assql+
// 06.06.19
                 ' and '+FGeral.GetNOTIN('moes_tipomov',Global.TiposNaoFiscal,'C')+
                 ' and moes_dataemissao >= '+DAtetosql(datapratras)+
                 ' and Moes_status=''N''');
   if not Q.eof then begin
      if ( trim(Q.fieldbyname('moes_chavenfe').asstring)<>'' ) and ( Datetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)>=1921 ) then begin
        Aviso('Numero j� usado em NF-e autorizada dia '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime));
//        exit;
// 04.02.2022 - liberado devido a caso antonio numeracao proxima nfe e nfce dentro do mesmo mes
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
    if  Confirma('� NF-e (Nota Fiscal eletr�nica N�O consumidor) ?') then begin
      try

        ACBrNFe1.WebServices.Inutiliza(EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring,
        Justificativa,Datetoano(sistema.Hoje,true),55,strtoint(EdUnid_codigo.resultfind.fieldbyname('unid_serie').asstring), EdNUmeroi.asinteger, EdNUmerof.asinteger);
        eNFCe:='N';

      except on E:Exception  do

         Avisoerro( E.message );

      end;

    end else begin
      eNFCe:='S';
      ACBrNFe1.WebServices.Inutiliza(EdUnid_codigo.resultfind.fieldbyname('unid_cnpj').asstring,
      Justificativa,Datetoano(sistema.Hoje,true),65,strtoint(FGeral.GetSerieNFCe), EdNUmeroi.asinteger, EdNUmerof.asinteger);
    end;
//////
    ListaArquivos.Items.Clear;
    ListaArquivos.FileName:=AcbrNfe1.Configuracoes.Arquivos.PathInu;
    ListaArquivos.Update;
    ListaXML:=TStringList.Create;
    numero:=EdNumeroi.AsInteger;
// 23.05.17
//    while numero <= EdNUmerof.AsInteger do begin
      for p:=0 to ListaArquivos.Items.Count-1 do begin
         if ( ansipos( uppercase('inu'),uppercase(ListaArquivos.Items.Strings[p]) ) > 0  ) and
            ( ansipos( strzero(Numero,6),ListaArquivos.Items.Strings[p] ) > 0  ) and
            ( ansipos( uppercase('ped'),uppercase(ListaArquivos.Items.Strings[p]) ) = 0  ) then begin
  // 14.04.11
           arqxmlretorno:=AcbrNfe1.Configuracoes.Arquivos.PathInu+'\'+ListaArquivos.Items.Strings[p];
           ListaXml.LoadFromFile(arqxmlretorno);
           cretorno:=FExpNfetxt.GetTag('xMotivo',ListaXml.Strings[0]);
           if trim(cretorno)<>'' then break;
         end;
      end;
//      inc(numero);
//    end;
/////////////////////////////////////
    if not FileExists(arqxmlretorno) then begin
      Sistema.EndProcess('Arquivo XML de retorno n�o encontrado em : '+AcbrNfe1.Configuracoes.Arquivos.PathInu+arqxmlretorno);
    end else begin
//      cretorno:=FExpNfetxt.GetTag('xMotivo',ListaXml.Strings[0]);
// 14.04.11
      if trim(cretorno)='' then
        Sistema.EndProcess('Tag xMotivo n�o encontrada no arquivo '+AcbrNfe1.Configuracoes.Arquivos.PathInu+arqxmlretorno)
      else begin
////////////////////////////////////////
        Sistema.EndProcess(cretorno);
// 07.11.13  - marcar com status 'I' numero de documento de saida com xml e data de autorizacao
//             para identificar nos relatorios mas nao enviar no sintegra
// 21.06.16 - Vivan - Cris
        if not Global.Usuario.OutrosAcessos[0344] then begin

          Sistema.BeginProcess('gravando');
          InutilizaNumero( EdNumeroi.AsInteger,EdNumerof.AsInteger );

        end else begin

          if confirma('Marcar a nota no sistema como INUTILIZADA ?') then begin
            Sistema.BeginProcess('gravando');
            InutilizaNumero( EdNumeroi.AsInteger,EdNumerof.AsInteger );
          end;

        end;
      end;
      ListaXML.Free;
    end;
  except
    ListaArquivos.Items.Clear;
//    ListaArquivos.FileName:=AcbrNfe1.Configuracoes.Arquivos.GetPathInu;
//    ListaArquivos.FileName:=AcbrNfe1.Configuracoes.Arquivos.PathInu;
// 08.08.16
    ListaArquivos.FileName:=AcbrNfe1.Configuracoes.Arquivos.PathSalvar;
    ListaArquivos.Update;
    ListaXML:=TStringList.Create;
    for p:=0 to ListaArquivos.Items.Count-1 do begin
       if ( ansipos( uppercase('inu'),uppercase(ListaArquivos.Items.Strings[p]) ) > 0  ) and
          ( ansipos( strzero(EdNumeroi.Asinteger,6),ListaArquivos.Items.Strings[p] ) > 0  ) and
          ( ansipos( uppercase('ped'),uppercase(ListaArquivos.Items.Strings[p]) ) = 0  ) then begin
  //      arqxmlretorno:=AcbrNfe1.Configuracoes.Arquivos.GetPathInu+'\'+ACBrNFe1.WebServices.Consulta.NFeChave+'-inu.XML';
//         arqxmlretorno:=AcbrNfe1.Configuracoes.Arquivos.GetPathInu+'\'+ListaArquivos.Items.Strings[p];
//         arqxmlretorno:=AcbrNfe1.Configuracoes.Arquivos.PathInu+'\'+ListaArquivos.Items.Strings[p];
// 08.08.16
         arqxmlretorno:=AcbrNfe1.Configuracoes.Arquivos.PathSalvar+'\'+ListaArquivos.Items.Strings[p];
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
        if confirma('Marcar a(s) nota(s) no sistema como INUTILIZADA ?') then begin
          Sistema.BeginProcess('gravando');
          InutilizaNumero( EdNumeroi.AsInteger,EdNumerof.AsInteger );
        end;
      end;
      ListaXML.Free;
    end;
  end;

end;

procedure TFGerenciaNfe.EdNumeroiValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
// 01.03.12
{
   try
     x:=ACBrNFe1.Configuracoes.Certificados.GetCertificado.SubjectName;
   except
     Avisoerro('N�o encontrado certificado digital');
     exit;
   end;
}
////////////////////////////////////////
    EdNUmerof.Text:=EdNumeroi.text;

end;

//////////////////////////////////////////////////////////////////////////////
procedure TFGerenciaNfe.Enviaemail(xtrans:string='';xemail:string='');
///////////////////////////////////////////////////////////////////////////////
var ct,arqxml,emailDestino,temxmltext,caminhoxml,emaildestino1,emailsdestino:string;
    Q:TSqlquery;
    ListaXml,ListaEmails:TStringList;
    CorpoEmail:TStringList;

begin

   if trim(fGeral.GetConfig1AsString('EMAILORIGEM'))='' then begin
     Avisoerro('Configurar todos os dados referente email nas config. gerais');
     exit;
   end;
   if ( FGeral.EmailStmpcomSSL( fGeral.GetConfig1AsString('EMAILORIGEM'))  ) and ( FGeral.SemDllsSmtp ) then begin
     Avisoerro('Email '+fGeral.GetConfig1AsString('EMAILORIGEM')+' usa SSL; faltam 3 arquivos com extens�o .dll');
     exit;
   end;
   ConfiguraEmailAcbr;
   ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row];
// 06.07.11
   if xtrans<>'' then ct:=xtrans;
   temxmltext:='N';
// 14.09.11
   campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
   if campo.Tipo<>'' then begin
     temxmltext:='S';
     Q:=Sqltoquery('select moes_xmlnfe,moes_xmlnfet,moes_numerodoc,moes_dataemissao,moes_transacao,'+
                 ' moes_tipo_codigo,moes_tipocad,moes_protodpec,moes_dtnfeauto,moes_dtnfecanc,moes_xmlnfecanc'+
                 ' from movesto where moes_transacao='+Stringtosql(ct)+
                 ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C''');

   end else
     Q:=Sqltoquery('select moes_xmlnfe,moes_numerodoc,moes_dataemissao,moes_transacao,moes_tipo_codigo,'+
                 ' moes_tipocad,moes_protodpec,moes_dtnfeauto,moes_dtnfecanc,moes_xmlnfecanc'+
                 ' from movesto where moes_transacao='+Stringtosql(ct)+
                 ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C''');

   CorpoEmail:=TStringList.Create;
   ListaEmails:=TStringList.Create;
   arqxml:='EmailDanfe.text';
//Pedir na hora..
   if not Q.eof then begin
     //checar se autorizada
      if trim(Q.fieldbyname('moes_xmlnfet').asstring)='' then begin
        Avisoerro('Transa��o '+Q.fieldbyname('moes_transacao').asstring+' sem XML gravado');
        exit;
//dpec
      end else if FExpNfetxt.GetTag('tpemis',Q.fieldbyname('moes_xmlnfet').asstring)='4' then begin
        if trim(Q.fieldbyname('moes_protodpec').asstring)='' then begin
          Avisoerro('Transa��o '+Q.fieldbyname('moes_transacao').asstring+' sem Protocolo de Envio ao DPEC');
          exit;
        end;
      end else if DAtetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)<=1900 then begin

          Avisoerro('Transa��o '+Q.fieldbyname('moes_transacao').asstring+' ainda n�o foi autorizada');
          exit;
//      end else if DAtetoano(Q.fieldbyname('moes_dtnfecanc').asdatetime,true)>1900 then begin
//        Avisoerro('NFe ref. Transa��o '+ct+' foi cancelada na Sefa');
//        exit;
// 23.06.18 - Giacomoni - 'cliente' pediu xml da nota cancelada
      end;

     //buscar email cadastro clientes..
//     emaildestino:=FGeral.GetEmailEntidade(Q.fieldbyname('moes_tipo_codigo').AsInteger,Q.fieldbyname('moes_tipocad').asstring);
// 30.05.14

     if EdTipomov.text<>'A' then begin

       emailsdestino:=FGeral.GetEmailEntidade(Q.fieldbyname('moes_tipo_codigo').AsInteger,Q.fieldbyname('moes_tipocad').asstring,'S');
       emaildestino:='';
       emaildestino1:='';
       if pos(';',emailsdestino)>0 then begin
         emaildestino:=copy(emailsdestino,1,pos(';',emailsdestino)-1);
         emaildestino1:=copy(emailsdestino,pos(';',emailsdestino)+1,60);
         strtolista(ListaEmails,emailsdestino,';',true);
       end else begin
         emaildestino:=emailsdestino;  // 01.06.16
         ListaEmails.Clear;
       end;
       if trim(emaildestino)='' then begin
         if not Input('Destinat�rio de e-mail','E-Mail',emaildestino,0,False)  or (emaildestino='') then exit;
       end;
     end else
       emaildestino:=xemail;

       CorpoEmail.Add(  'Anexo XML da NFe '+Q.fieldbyname('moes_numerodoc').asstring+
                          ' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime) );
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
       ACBrNFe1.NotasFiscais.Clear;
       AcbrNfe1.NotasFiscais.LoadFromFile(arqxml);

// 16.06.2021 - Clessi - configuracao das casas decimais da qtde e do valor unitario
////////////////////////////////////////////////////////////////////////
       if FGeral.GetConfig1AsInteger('decqtdedanfe') >0 then
         ACBrNFeDANFERL1.CasasDecimais.qCom:=FGeral.GetConfig1AsInteger('decqtdedanfe');
       if FGeral.GetConfig1AsInteger('decunitariodanfe') >0 then
         ACBrNFeDANFERL1.CasasDecimais.vUnCom:=FGeral.GetConfig1AsInteger('decunitariodanfe');
       if FGeral.GetConfig1AsInteger('decqtdedanfe') >0 then
         ACBrNFeDANFCeFortes1.CasasDecimais.qCom:=FGeral.GetConfig1AsInteger('decqtdedanfe');
       if FGeral.GetConfig1AsInteger('decunitariodanfe') >0 then
         ACBrNFeDANFCeFortes1.CasasDecimais.vUnCom:=FGeral.GetConfig1AsInteger('decunitariodanfe');
///////////////////
///
// 14.09.11
       if (AcbrNfe1.NotasFiscais.Count=0)  then
         Avisoerro('Problemas ao ler o arquivo '+arqxml+' desta nota');

       Sistema.BeginProcess('Enviando email');

       try
         if Global.Topicos[1019] then begin // usar cliente de email padrao...

//     AcBrNfe1.Configuracoes.Arquivos.PathNFe+'\'+inttostr(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.cNF)+FGeral.TiraBarra( Datetostr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.dEmi) )+'-NFe.xml';
//           FGeral.EmailClientePadrao(emaildestino,'XML NFe',FGeral.GetConfig1AsString('Pastaexpnfexml'),CorpoEmail);
           caminhoxml:=FGeral.GetConfig1AsString('Pastaexpnfexml')+'\'+copy(ACBRNfe1.NotasFiscais.Items[0].NFe.infNFe.ID,4,44)+'-NFe.xml';
           FGeral.EmailClientePadrao(emaildestino,'XML NFe',caminhoxml,CorpoEmail);

         end else if Global.Topicos[1012] then begin

// 27.09.2021
           acbrnfe1.danfe.TipoDANFE := tiretrato;
           if acbrnfe1.NotasFiscais.Items[0].NFe.Ide.modelo = 65 then begin

              Acbrnfe1.DANFE:=ACBrNFeDANFCeFortes1;
              acbrnfe1.danfe.TipoDANFE:=tiNFCe;
//              ACBrNFeDANFCeFortes1.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

           end else begin

              Acbrnfe1.DANFE:=ACBrNFeDANFeRL1;
//              AcbrNfe1.DANFE.ImprimirDANFE(AcbrNFe1.NotasFiscais.Items[0].NFe);

           end;
////////////////////////////////
// desta forma com true envia tbem o danfe em pdf
           if FGeral.EmailStmpcomSSL( FGeral.GetConfig1AsString('EMAILORIGEM') ) then

             ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(emaildestino,
                           'XML NFe '+Q.fieldbyname('moes_numerodoc').asstring+' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                           CorpoEmail,
                           True,
                           ListaEmails,
                           nil)

//              FGeral.GetConfig1AsString('SMTP'),inttostr(FGeral.GetConfig1AsInteger('PORTASMTP')),FGeral.GetConfig1AsString('USUARIOSMTP'),FGeral.GetConfig1AsString('SENHASMTP'),FGeral.GetConfig1AsString('EMAILORIGEM'),emaildestino,'XML NFe '+Q.fieldbyname('moes_numerodoc').asstring+
//                        ' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),CorpoEmail,true,true)
           else
//             ACBrNFe1.NotasFiscais.Items[0].EnviarEmail( FGeral.GetConfig1AsString('SMTP'),inttostr(FGeral.GetConfig1AsInteger('PORTASMTP')),FGeral.GetConfig1AsString('USUARIOSMTP'),FGeral.GetConfig1AsString('SENHASMTP'),FGeral.GetConfig1AsString('EMAILORIGEM'),emaildestino,'XML NFe '+Q.fieldbyname('moes_numerodoc').asstring+
//                        ' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),CorpoEmail,false,true);
             ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(emaildestino,
                           'XML NFe '+Q.fieldbyname('moes_numerodoc').asstring+' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                           CorpoEmail,
                           True,
                           ListaEmails,
                           nil);
// 20.09.2021
// para n�o ficar gerando 'monte' de pdf na pasta do executavel do sac
            if FileExists( copy(ACBRNfe1.NotasFiscais.Items[0].NFe.infNFe.ID,4,44)+'-nfe.PDF' )  then

               DeleteFile( copy(ACBRNfe1.NotasFiscais.Items[0].NFe.infNFe.ID,4,44)+'-nfe.PDF' ) ;



// 30.05.14
           if trim(emaildestino1)<>'' then
//             ACBrNFe1.NotasFiscais.Items[0].EnviarEmail( FGeral.GetConfig1AsString('SMTP'),inttostr(FGeral.GetConfig1AsInteger('PORTASMTP')),FGeral.GetConfig1AsString('USUARIOSMTP'),FGeral.GetConfig1AsString('SENHASMTP'),FGeral.GetConfig1AsString('EMAILORIGEM'),emaildestino1,'XML NFe '+Q.fieldbyname('moes_numerodoc').asstring+
//                        ' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),CorpoEmail,false,true);
             ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(emaildestino1,
                           'XML NFe '+Q.fieldbyname('moes_numerodoc').asstring+' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                           CorpoEmail,
                           True,
                           nil,
                           nil);

         end else  begin

//           ACBrNFe1.NotasFiscais.Items[0].EnviarEmail( FGeral.GetConfig1AsString('SMTP'),inttostr(FGeral.Smtp.Port),FGeral.GetConfig1AsString('USUARIOSMTP'),FGeral.GetConfig1AsString('SENHASMTP'),FGeral.GetConfig1AsString('EMAILORIGEM'),emaildestino,'XML NFe',CorpoEmail,true,false);
           if FGeral.EmailStmpcomSSL( FGeral.GetConfig1AsString('EMAILORIGEM') ) then
//             ACBrNFe1.NotasFiscais.Items[0].EnviarEmail( FGeral.GetConfig1AsString('SMTP'),inttostr(FGeral.GetConfig1AsInteger('PORTASMTP')),FGeral.GetConfig1AsString('USUARIOSMTP'),FGeral.GetConfig1AsString('SENHASMTP'),FGeral.GetConfig1AsString('EMAILORIGEM'),emaildestino,'XML NFe '+Q.fieldbyname('moes_numerodoc').asstring+
//                        ' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),CorpoEmail,True,false)
             ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(emaildestino,
                           'XML NFe '+Q.fieldbyname('moes_numerodoc').asstring+' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                           CorpoEmail,
                           False,
                           ListaEmails,
                           nil)
           else
//             ACBrNFe1.NotasFiscais.Items[0].EnviarEmail( FGeral.GetConfig1AsString('SMTP'),inttostr(FGeral.GetConfig1AsInteger('PORTASMTP')),FGeral.GetConfig1AsString('USUARIOSMTP'),FGeral.GetConfig1AsString('SENHASMTP'),FGeral.GetConfig1AsString('EMAILORIGEM'),emaildestino,'XML NFe '+Q.fieldbyname('moes_numerodoc').asstring+
//                        ' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),CorpoEmail,false,false);
             ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(emaildestino,
                           'XML NFe '+Q.fieldbyname('moes_numerodoc').asstring+' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                           CorpoEmail,
                           False,
                           ListaEmails,
                           nil);
// 30.05.14 - Novicarnes
           if trim(emaildestino1)<>'' then
//             ACBrNFe1.NotasFiscais.Items[0].EnviarEmail( FGeral.GetConfig1AsString('SMTP'),inttostr(FGeral.GetConfig1AsInteger('PORTASMTP')),FGeral.GetConfig1AsString('USUARIOSMTP'),FGeral.GetConfig1AsString('SENHASMTP'),FGeral.GetConfig1AsString('EMAILORIGEM'),emaildestino1,'XML NFe '+Q.fieldbyname('moes_numerodoc').asstring+
//                        ' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),CorpoEmail,false,false);
             ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(emaildestino1,
                           'XML NFe '+Q.fieldbyname('moes_numerodoc').asstring+' emitida em '+FGeral.FormataData(Q.fieldbyname('moes_dataemissao').asdatetime),
                           CorpoEmail,
                           False,
                           nil,
                           nil);
         end;
//           FGeral.EnviaEMail(emaildestino,'XML NFe','',CorpoEmail);
         if (EdTipomov.text<>'A') and ( not Global.Topicos[1456] ) then
           Sistema.EndProcess('Email enviado.')
         else
           Sistema.endprocess('');

       except on E:exception do

         Sistema.EndProcess('Email n�o enviado.  Checar configura��o do email '+FGeral.GetConfig1AsString('EMAILORIGEM')+
                             ' SMTP '+FGeral.GetConfig1AsString('SMTP')+
                             ' SSL : '+BoolToStr(Acbrmail1.setssl) +
                             ' SSL : '+BoolToStr(Acbrmail1.setssl) +
                             ' Senha : '+Acbrmail1.Password +
                             ' Porta : '+Acbrmail1.port+
                             ' Erro  : '+E.Message);
       end;
  //    FGeral.EnviaEMail('andre@tokefinal.com.br','XML Nfe numero '+Q.fieldbyname('moes_numerodoc').asstring,Q.fieldbyname('moes_xmlnfe').asstring,corpoemail)
       ACBrNFe1.NotasFiscais.Clear;

       ListaEmails.free;
   end;
   CorpoEmail.Clear;
   FGeral.FechaQuery(Q);

end;

procedure TFGerenciaNfe.bconsultasefaClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
var ct,ct1:string;
    Q,QNfe:TSqlquery;
    ListaXML:TStringList;
    arqxml,cretorno,ctransacao,arqxmlretorno:string;
    marc,i:integer;
begin
   ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row];
   marc:=0;
   ct1:='';
   for i:=0 to Grid.rowcount do begin
     if Grid.Cells[Grid.getcolumn('marcado'),i]='OK' then begin
       inc(marc);
       ct1:=ct1+Grid.Cells[Grid.getcolumn('moes_transacao'),i]+';';
     end;
   end;
   if ct1<>'' then ct:=ct1;
//   Q:=Sqltoquery('select moes_xmlnfe,moes_dtnfeauto from movesto where moes_transacao='+Stringtosql(ct)+
   Q:=Sqltoquery('select moes_xmlnfe,moes_dtnfeauto,moes_transacao,moes_dtnfecanc,moes_protodpec,moes_numerodoc,moes_chavenfe,moes_nfeexp from movesto where '+
                 FGeral.GetIN('moes_transacao',ct,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C''');

   AcbrNfe1.NotasFiscais.Clear;
   ListaXML:=TStringList.Create;
   arqxml:='ConsultaNFe.txt';
   while not Q.eof do begin
// gravar somente as q foram enviadas mas sem retorno da autoriza��o
//      if ( trim(Q.fieldbyname('moes_xmlnfe').asstring)<>'' ) and
      if ( trim(Q.fieldbyname('moes_xmlnfe').asstring)='' ) and
// 16.12.09 - quando nao d� retorno o xml nao fica gravado no banco
         ( trim(Q.fieldbyname('moes_chavenfe').AsString)='' ) and
         ( Datetoano(Q.fieldbyname('moes_dtnfeauto').AsDatetime,true)<1920 ) and
         (  Q.fieldbyname('moes_nfeexp').asstring='S' )
        then begin
//        Avisoerro('Transa��o '+Q.fieldbyname('moes_transacao').asstring+' sem XML gravado')
        ListaXML.Clear;
        ListaXML.Append(Q.fieldbyname('moes_xmlnfe').asstring);
        ListaXml.SaveToFile(arqxml);
        AcbrNfe1.NotasFiscais.LoadFromFile(arqxml);
      end;
      Q.Next;
   end;
   if AcbrNfe1.NotasFiscais.Count>0 then begin
     AcbrNfe1.NotasFiscais.GerarNFe;
     AcbrNfe1.NotasFiscais.Assinar;
     AcbrNfe1.NotasFiscais.Validar;
     for i:=0 to AcbrNfe1.NotasFiscais.Count-1 do begin
//       ACBrNFe1.WebServices.Consulta.NFeChave := FExpNfetxt.GetTag('chNFe', ACBRNfe1.NotasFiscais.Items[i].XML );
// tiro o 'NFe' inicial do ID para ir somente os 44 digitos
       ACBrNFe1.WebServices.Consulta.NFeChave := copy(ACBRNfe1.NotasFiscais.Items[i].NFe.infNFe.ID,4,44) ;
       ACBrNFe1.WebServices.Consulta.Executar;

//       arqxmlretorno:=AcbrNfe1.Configuracoes.Arquivos.GetPathCan+'\'+ACBrNFe1.WebServices.Consulta.NFeChave+'-sit.XML';
//   15.03.10
       arqxmlretorno:=AcbrNfe1.Configuracoes.Arquivos.PathEvento+'\'+ACBrNFe1.WebServices.Consulta.NFeChave+'-sit.XML';
       if not FileExists(arqxmlretorno) then begin
            Avisoerro('Arquivo XML de retorno n�o encontrado:'+arqxmlretorno);
            Sistema.EndProcess('Banco de dados n�o atualizado');
            exit;
       end;
       ListaXML.Clear;
       ListaXml.LoadFromFile(arqxmlretorno);
// pois nao precisa mostrar o numero da nfe...
//       cretorno:=copy(FExpNfetxt.GetRetorno( ListaXml.Strings[0] ),53,40) ;
       cretorno:= TrataRetornoXMotivo( ListaXml.Strings[0]  ) ;
       AtualizaGrid( ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF,cretorno );
       ctransacao:=FExpNfetxt.GetGridTransacao(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);
//{
       if ( trim(ctransacao)<>'' ) and
             ( trim(cretorno)<>'' )   and
             ( pos('ENCONTRADO',UPpercase(cretorno))=0 )
             then begin
             QNfe:=Sqltoquery('select moes_dtnfeauto,moes_chavenfe from movesto where moes_transacao='+Stringtosql(Trim(ctransacao))+
                              ' and moes_status<>''C''' );

             Sistema.edit('movesto');
             if pos('AUTORIZADA',uppercase(cretorno))>0 then begin
               Sistema.setfield('moes_dtnfeauto',Sistema.hoje);
               Sistema.setfield('moes_xmlnfe',ACBrNFe1.NotasFiscais.Items[i].XML) ;
               Sistema.setfield('moes_chavenfe',ACBrNFe1.NotasFiscais.Items[i].NFe.procNFe.chNFe);
             end;
             if trim(cretorno)<>'' then begin
               if Datetoano(QNfe.fieldbyname('moes_dtnfeauto').AsDatetime,true) <= 1920 then begin
                 Sistema.setfield('moes_retornonfe',cretorno);
                 Sistema.setfield('moes_dtnfereto',Sistema.hoje);
               end;
             end;
             Sistema.Post('moes_transacao='+stringtosql(ctransacao));
             FGeral.FechaQuery(QNfe);
       end;
//          }
     end;

   end;
   FGeral.FechaQuery(Q);

end;

procedure TFGerenciaNfe.APHeadLabel1Click(Sender: TObject);
//////////////////////////////////////////////////////////////////
var ct,
    arqpdf,
    fone,
    mensagem    :string;

begin

     exit;

     if Global.Usuario.OutrosAcessos[0352] then begin

//      showmessage('agora vai');
//      ShellExecute(Handle, 'open', PChar('https://api.whatsapp.com/send?phone=554699735459&text=oileilinha'), '', '', SW_HIde );
//      webbrowser1.navigate( 'https://api.whatsapp.com/send?phone=554699735459&text=oi leilinha');
//      webbrowser1.navigate( 'https://api.whatsapp.com/send?phone=554699735459&file=acbrlog.txt');
//      webbrowser1.Hide;

      ct := trim( Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row] );
      Q  := Sqltoquery('select moes_xmlnfe,moes_dtnfeauto,moes_numerodoc,moes_dtnfecanc,moes_xmlnfet,moes_chavenfe,'+
                 ' moes_tipo_codigo,moes_tipocad from movesto where moes_transacao='+Stringtosql(ct)+
                 ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C''');

      if Q.eof then begin

          Avisoerro('Transa��o '+ct+' n�o encontrada');
          exit;

      end;

      if trim(Q.fieldbyname('moes_xmlnfet').asstring)='' then begin

        Avisoerro('Transa��o '+ct+' sem XML gravado');
        exit;

      end else if DAtetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)<=1900 then begin

        Avisoerro('Transa��o '+ct+' ainda n�o foi autorizada');
        exit;

      end else if DAtetoano(Q.fieldbyname('moes_dtnfecanc').asdatetime,true)>1900 then begin

        Avisoerro('NFe ref. Transa��o '+ct+' j� foi cancelada na Sefa em '+Fgeral.FormataData(Q.fieldbyname('moes_dtnfecanc').asdatetime));
        exit;

      end;

      if Q.fieldbyname('moes_tipocad').asstring = 'C' then

         fone := FCadCli.getcelular( Q.fieldbyname('moes_tipo_codigo').asinteger )

      else

         fone := FFornece.getcelular( Q.fieldbyname('moes_tipo_codigo').asinteger );


      if trim(fone)='' then begin

         Input('Informe telefone','Numero',fone,10,false);

      end;


      fone := strtostrnumeros( fone );
      if length(trim(fone)) < 10 then begin

         Avisoerro('Fone '+fone+' faltando d�gitos.  Verificar');
         exit;

      end else if length(trim(fone)) > 10 then begin

         Avisoerro('Fone '+fone+' sobrando d�gitos.  Verificar');
         exit;

      end;


      ACBrNFe1.NotasFiscais.Clear;
      ACBrNFe1.NotasFiscais.LoadFromStream( TStringStream.Create( Q.fieldbyname('moes_xmlnfet').asstring ) );

      if Q.fieldbyname('moes_numerodoc').asinteger<>ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF then begin

         Avisoerro('NFe escolhida '+inttostr(Q.fieldbyname('moes_numerodoc').asinteger)+
                  'NFe do XML para cancelamento '+inttostr(ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.nNF) );
        exit;

      end;

      AcbrNfe1.NotasFiscais.Items[0].ImprimirPDF;

      arqpdf := ACBrNFe1.Configuracoes.Arquivos.PathNFe +
                '\'+Q.fieldbyname('moes_chavenfe').asstring +
                '-nfe.pdf';

      mensagem :=  'NF-e '+Q.fieldbyname('moes_numerodoc').asstring+' - '+
                   FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,
                                              Q.fieldbyname('moes_tipocad').asstring,
                                              'N');



      FGerenciaWhats.EnviaArquivo(fone,arqpdf,mensagem);

//      FGerenciaWhats.Execute(fone,arqpdf,mensagem);

//      if Confirma('Fazer logoff') then FGerenciaWhats.logout;
      
{
      if not FGerenciaWhats.Login then begin

          Avisoerro('N�o foi poss�vel conectar no servi�o do Whatsapp');
          exit;

      end else begin

         Aviso('conecato no servi�o');
         FGerenciaWhats.logout;

      end;
}

    end;

end;

procedure TFGerenciaNfe.AtualizaGrid(nf: integer; xretorno: string);
var i:integer;
begin
  for i:=1 to Grid.RowCount do begin
     if strtointdef(Grid.Cells[Grid.getcolumn('moes_numerodoc'),i],0) = nf then begin
        Grid.Cells[Grid.getcolumn('retornows'),i]:=xretorno;
        break;
     end;
  end;

end;

function TFGerenciaNfe.TrataRetornoXMotivo(StringXml:String): string;
///////////////////////////////////////////////////////////////////
const cautorizado:string='autorizado o uso de nf-e';
var protocolo,xmotivo:string;
begin
  if ansipos(Uppercase(cautorizado),Uppercase(StringXML))>0 then
    result:='NF-e Autorizada'
  else begin
    xmotivo:=FExpNfetxt.GetTag('xMotivo',StringXml);
    protocolo:=FExpNfetxt.GetTag('nProt',StringXml);
    if trim(protocolo)<>'' then
      result:='NF-e Autorizada'
    else if trim(xmotivo)<>'' then begin
      if pos('consta na base de dados da SEFAZ',xmotivo)>0 then
        result:=copy(xmotivo,53,40)
      else
        result:=xmotivo;
    end else
      result:=FExpNfetxt.GetRetorno( StringXML )  ;
  end;

end;

procedure TFGerenciaNfe.bimpdanfexmlClick(Sender: TObject);
var cretorno,t:string;
//    Str:TMemoryStream;

begin
  if not FileExists(arquivorave) then begin
     Avisoerro('Arquivo .RAV n�o encontrado');
     exit;
  end;
  if not OPendialog1.Execute then exit;
  AcbrNfe1.NotasFiscais.Clear;
  try
    AcbrNfe1.NotasFiscais.LoadFromFile( OPendialog1.FileName );
  except
    Avisoerro('N�o foi poss�vel ler o arquivo '+OPendialog1.FileName);
    exit;
  end;
  cretorno:=FExpNfetxt.GetTag('xMotivo',AcbrNfe1.NotasFiscais.Items[0].XML);
//  if pos('AUTORIZADO O USO DE',uppercase(cretorno))=0 then
// 02.02.10 - nfe de SP vem com 'autorizado o uso da'...
  if ( pos('AUTORIZADO O USO',uppercase(cretorno))=0 ) and ( not (Global.Usuario.OutrosAcessos[0330]) ) then
    Avisoerro('XML n�o autorizado pela Sefa')
  else begin
    Printer.PrinterIndex := ComboBox1.ItemIndex;
    ACBrNFeDANFERL1.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];
//     if FGeral.GetConfig1AsInteger('copiasdanfe')>0 then
//       PrintDialogBoleto.Copies:=FGeral.GetConfig1AsInteger('copiasdanfe');
//     if not PrintDialogBoleto.Execute then exit;
    PrintDialogBoleto.Copies:=1;
    ACBrNFeDANFERL1.NumCopias:=1;
    AcbrNfe1.DANFE.NumCopias:=1;
//    AcbrNfe1.NotasFiscais.Imprimir ;

// 26.11.12
    if Global.Topicos[1358] then begin
       ACBrNFeDANFERL1.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[0].NFe );
      if not confirma('Importar XML nas saidas ?') then exit;
      FGeral.GravaNotacomxml( ACBrNFe1 ,OPendialog1.FileName,EdUnid_codigo.text );
    end else
       ACBrNFeDANFERL1.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[0].NFe );


  end;

end;

procedure TFGerenciaNfe.EdUnid_codigoValidate(Sender: TObject);
begin
// 02.07.10 - emitente em outro estado que nao seja PR
  if trim(EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString)<>'' then
    ACBrNFe1.Configuracoes.WebServices.UF:=EdUNid_codigo.resultfind.fieldbyname('unid_uf').AsString;


end;

function TFGerenciaNfe.EimpressoraSetada(impdasesssao,  xsitnotas, yIMP: string): Boolean;
//////////////////////////////////////////////////////////////////////////////////////////
 var s1,
     nomeimp:string;

        function RetiraDirecionada( nomei:string):string;
        /////////////////////////////////////////////////
        var a:Integer;
        begin
           a := AnsiPos( 'redirecionada',nomei);
           result := '';
           if a > 0 then
              Result := substr(nomei,1,a-5);  // cuida q varia ( 50 redirecionada ou (134 redirecionada..
        end;

begin

       result := False;
       nomeimp := RetiraDirecionada( impdasesssao );

//      ShowMessage('01 nomeimp='+nomeimp+'xsituacaonotas='+xsituacaonotas+' ymp='+yimp );

       if  (Global.UsaNFCe='S')  and ( xsituacaonotas = 'NFCe' ) and ( yIMP='S' ) then begin

//           ShowMessage('02 nomeimp='+nomeimp);

          s1:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFCE');
           if trim(s1)<>'' then begin

              s1 := RetiraDirecionada(s1) ;

  //            ShowMessage('s1='+s1+' nomeimp='+nomeimp);

              if Trim(s1) = Trim(nomeimp) then Result := True;

          end;

      end else if  (Global.UsaNfe='S')  and ( xsituacaonotas = 'NFE' ) and ( yIMP='S' ) then begin

          s1:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFCE');
          if trim(s1)<>'' then begin

              s1 := RetiraDirecionada(s1) ;
              if Trim(s1) = Trim(nomeimp) then Result := True;

          end;

      end;

end;

function TFGerenciaNfe.GetQualXml(Q:TSqlquery;temcampo:string): string;
/////////////////////////////////////////////////////////////////
begin
  {
  campo:=Sistema.GetDicionario('movesto','moes_xmlnfet');
  if campo.Tipo<>'' then
    result:='moes_xmlnfet'
  else
    result:='moes_xmlnfe';
    }
//

  if temcampo='S' then begin
    if trim(Q.fieldbyname('moes_xmlnfet').asstring)='' then
      result:=Q.fieldbyname('moes_xmlnfe').asstring
    else
      result:=Q.fieldbyname('moes_xmlnfet').asstring
  end else
    result:=Q.fieldbyname('moes_xmlnfe').asstring;

  if temcampo='X' then result:=Q.fieldbyname('moes_xmlnfecanc').asstring
end;

procedure TFGerenciaNfe.EdUnid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.LimpaEdit(EdUnid_codigo,key);
end;

procedure TFGerenciaNfe.bemailClick(Sender: TObject);
///////////////////////////////////////////////////////
var i:integer;
    emaildesti:string;
begin

   PCartacorrecao.Visible:=false;
   PCartacorrecao1.Visible:=false;
   Acbrnfe1.DANFE:=ACBrNFeDANFERL1;
 // 18.04.16
    if trim( FGeral.GetConfig1AsString('PastaPdfs') ) <> '' then
      Acbrnfe1.DANFE.PathPDF:=FGeral.GetConfig1AsString('PastaPdfs')
    else
      Acbrnfe1.DANFE.PathPDF:=ExtractFilePath( Application.ExeName );

    // 31.03.16
   if EdTipocad.text='T' then begin
     if not Input('Destinat�rio de e-mail','E-Mail',emaildesti,0,False)  or (emaildesti='') then exit;
     for i:=0 to Grid.rowcount do begin
       if Grid.Cells[Grid.getcolumn('marcado'),i]='OK' then begin
         EnviaEmail( Grid.Cells[Grid.getcolumn('moes_transacao'),i],emaildesti );
       end;
     end;
     Aviso('Email(s) enviados');
// 27.08.18
   end else if Global.Topicos[1456] then begin

     for i:=0 to Grid.rowcount do begin
       if Grid.Cells[Grid.getcolumn('marcado'),i]='OK' then begin
         EnviaEmail( Grid.Cells[Grid.getcolumn('moes_transacao'),i],emaildesti );
       end;
     end;
     Aviso('Email(s) enviados');

   end else
     EnviaEmail;
end;

//  28.06.12
procedure TFGerenciaNfe.bcartacorrecaoClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var ct,codigosdesti,chave,idlote,codorgao,cnpj,nseqevento,correcao:string;
begin

   if Grid.Cells[Grid.GetColumn('marcado'),Grid.row]<>'OK' then exit;

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
     Avisoerro('Nota sem chave da NFe.   Verificar');
     exit;
   end;
//   if Acbrnfe1.Configuracoes.Certificados.DataVenc < Sistema.Hoje then begin
   if not Acbrnfe1.Configuracoes.Certificados.VerificarValidade then begin
//     Avisoerro('Certificado digital em uso vencido em '+Fgeral.FormataData(Acbrnfe1.Configuracoes.Certificados.DataVenc));
     Avisoerro('Certificado digital em uso vencido. '+Acbrnfe1.Configuracoes.Certificados.DadosPFX);
     exit;
   end;
   PCartacorrecao.Visible:=true;
   PCartacorrecao1.Visible:=true;
   idLote := inttostr( FGEral.GetContador('LOTECCE'+EdUnid_codigo.text,false) );
   codOrgao := copy(Chave,1,2);
   CNPJ := copy(Chave,7,14);
   nSeqEvento := '1';
//   Correcao := 'Corre��o a ser considerada, texto livre. A corre��o mais recente substitui as anteriores.';
//   Correcao := space(100);
// 23.02.18
   Correcao := space(500);
   if not(InputQuery('Envio de Carta de Corre��o', 'Corre��o a ser considerada', Correcao)) then
      exit;
// 02.10.2012 - Clessi
   if not(InputQuery('Evento da Carta de Corre��o', 'Sequencia de Corre��o dentro da mesma NF-e', nSeqEvento)) then
      exit;
   ACBrNFe1.CartaCorrecao.CCe.Evento.Clear;
   ACBrNFe1.CartaCorrecao.CCe.idLote := StrToInt(idLote) ;
   with ACBrNFe1.CartaCorrecao.CCe.Evento.Add do
   begin
     infEvento.chNFe := Chave;
     infEvento.cOrgao := StrToInt(codOrgao);
//     if Q.FieldByName('moes_tipocad').asstring='C' then begin
//       if length(trim(Q.fieldbyname('clie_cnpjcpf').asstring))<14 then
//         infEvento.CPF   := CNPJ
//       else
//         infEvento.CNPJ   := CNPJ;
//     end else
       infEvento.CNPJ   := CNPJ;
     infEvento.dhEvento := now;
     infEvento.tpEvento := teCCe;
     infEvento.nSeqEvento := StrToInt(nSeqEvento);
     infEvento.versaoEvento := '1.00';
     infEvento.detEvento.descEvento := 'Carta de Corre��o';
     infEvento.detEvento.xCorrecao := Correcao;
     infEvento.detEvento.xCondUso := ''; //Texto fixo conforme NT 2011.003 -  http://www.nfe.fazenda.gov.br/portal/exibirArquivo.aspx?conteudo=tsiloeZ6vBw=
//     infEvento.detEvento.xCondUso :='A Carta de Correcao e disciplinada pelo paragrafo 1o-A do art.'+
//                                    '7o do Convenio S/N, de 15 de dezembro de 1970 e pode ser utilizada '+
//                                    'para regularizacao de erro ocorrido na emissao de documento fiscal, '+
//                                    'desde que o erro nao esteja relacionado com: I - as variaveis que determinam '+
//                                    'o valor do imposto tais como: base de calculo, aliquota, diferenca de preco, '+
//                                    'quantidade, valor da operacao ou da prestacao; II - a correcao de dados cadastrais '+
//                                    'que implique mudanca do remetente ou do destinatario; III - a data de emissao ou de saida.';
     if FGeral.GetConfig1AsString('AmbienteNFe')='1' then
       InfEvento.tpAmb:=taProducao
     else
       InfEvento.tpAmb:=taHomologacao;
     infEvento.detEvento.xCorrecao := Correcao;

   end;
   Sistema.BeginProcess('Enviando carta de corre��o para Sefa');
   try
     ACBrNFe1.EnviarCartaCorrecao(StrToInt(idLote));
   finally
//     MemoResp.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.CartaCorrecao.RetWS);
//     memoRespWS.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.CartaCorrecao.RetornoWS);
     MemoResp.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.EnvEvento.RetWS);
     memoRespWS.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.EnvEvento.RetornoWS);
   end;

//   Sistema.EndProcess( ACbrNfe1.WebServices.EnvEvento.CCeRetorno.xMotivo );
//   Sistema.EndProcess( ACbrNfe1.WebServices.EnvEvento.CCeRetorno.retEvento.Items[0].RetInfEvento.xMotivo );

//    Sistema.EndProcess( memoRespWS.Lines.Text );

//   MemoResp.Lines.SaveToFile((ExtractFileDir(application.ExeName))+'\CCe01'+IdLote+'.xml');
   MemoRespWs.Lines.SaveToFile((ExtractFileDir(application.ExeName))+'\CCeNF'+strzero(Q.fieldbyname('moes_numerodoc').asinteger,6)+IdLote+'.xml');
   Q.close;
// 10.07.14
   Sistema.Edit('movesto');
//   Sistema.SetField('moes_xmlcce',MemoRespWs.Lines.Text);
//   Sistema.SetField('moes_xmlcce',MemoResp.Lines.Text);
// 07.04.16
   Sistema.SetField('moes_xmlcce',FGeral.TiraBarra( MemoResp.Lines.Text,chr(39),'"'));
   Sistema.SetField('moes_obs',Correcao);
   Sistema.Post('moes_transacao='+Stringtosql(ct));
   Sistema.Commit;
/////////////////

//   LoadXML(MemoResp, WBResposta);
//  MyMemo.Lines.SaveToFile(PathWithDelim(ExtractFileDir(application.ExeName))+'temp.xml');
//  MyWebBrowser.Navigate(PathWithDelim(ExtractFileDir(application.ExeName))+'temp.xml');

    Sistema.EndProcess( 'Cce enviada' );


end;

procedure TFGerenciaNfe.bgeraxmlClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var ct,ct1,codigosdesti,codigosdesti1,temxmltext,campoxml,ondesalvar,arq,pastasaC,
    emailescritorio,chavenfe,sqlperiodo,
    assunto :string;
    marc,i:integer;
    todos:boolean;
    ListaAnexos,Lista:TStringList;
    CorpoEmailTexto:Tstrings;

begin

   todos:=Confirma('Gerar de todos do per�odo <S> ou somente selecionados(ok)<N> ?');
   ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row];
   codigosdesti:=Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),Grid.row];
   marc:=0;
   ct1:='';
// 07.03.18
   sqlperiodo:=' and moes_datamvto>='+EdInicio.assql+
               ' and moes_datamvto<='+EdTermino.assql;

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
      Avisoerro('Sem nota escolhida');
      exit;
   end;
   if trim(codigosdesti1)='' then begin
      Avisoerro('Sem cliente OU nota escolhida');
      exit;
   end;
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
                sqlperiodo+
                ' and moes_status<>''C'' order by moes_numerodoc')
   end else
     Q:=Sqltoquery('select * from movesto where '+
                 FGeral.GetIN('moes_transacao',ct,'C')+
                ' and '+FGeral.GetIN('moes_tipo_codigo',codigosdesti,'N')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                ' and moes_unid_codigo = '+EdUnid_codigo.assql+
                sqlperiodo+
                ' and moes_status<>''C'' order by moes_numerodoc');
{ //
   if trim(Q.fieldbyname('moes_xmlnfe').asstring)='' then begin
      Avisoerro('Transa��o '+ct+' sem XML gravado');
      exit;
   end else if FExpNfetxt.GetTag('tpemis',Q.fieldbyname('moes_xmlnfe').asstring)='2' then begin
     Aviso('Transa��o '+ct+' se ref. a nfe em conting�ncia. Impress�o de Danfe em form. seguran�a');
   end else if DAtetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)<=1900 then begin
     Avisoerro('Transa��o '+ct+' aind n�o foi autorizada');
     exit;
   end else if DAtetoano(Q.fieldbyname('moes_dtnfecanc').asdatetime,true)>1900 then begin
     Avisoerro('NFe ref. Transa��o '+ct+' foi cancelada na Sefa');
     exit;
   end;
}

   AcbrNfe1.NotasFiscais.Clear;
//   ListaXML:=TStringList.Create;
//   ListaTrans:=TStringList.Create;
   if Q.eof then begin
     Avisoerro('Nada encontrado para gera��o.  Checar notas');
     FGeral.FechaQuery(Q);
     exit;
   end;
  {
  ondesalvar :=FGeral.GetConfig1AsString('Pastaexpnfexml')+'\'+
                strzero(Datetoano(Q.fieldbyname('moes_dataemissao').AsDateTime,true),4)+
                strzero(Datetomes(Q.fieldbyname('moes_dataemissao').AsDateTime),2);
                }
// 18.05.16
  ondesalvar := ExtractFilePath(Application.ExeName)+EdUnid_codigo.text+'\'+
                strzero(Datetoano(Q.fieldbyname('moes_dataemissao').AsDateTime,true),4)+
                strzero(Datetomes(Q.fieldbyname('moes_dataemissao').AsDateTime),2);
//                '\Geradas';
  if not DirectoryExists( OndeSalvar  ) then
      ForceDirectories( OndeSalvar );

// 15.08.18
   Acbrnfe1.DANFE.PathPDF:=OndeSalvar;

  ondesalvar:=ondesalvar+'\';
  Sistema.beginprocess('Gerando XML(s)');

  while not Q.eof do begin

  //    Aviso( 'Gerando XML da nota '+strzero( Q.fieldbyname('moes_numerodoc').AsInteger ,6) );

      campoxml:='moes_xmlnfet';
      if trim(Q.fieldbyname('moes_xmlnfet').asstring)='' then
        campoxml:='moes_xmlnfe';
// autorizada e nao cancelada na sefa
      if ( DAtetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)>1900 ) and
         ( DAtetoano(Q.fieldbyname('moes_dtnfecanc').asdatetime,true)<=1900 ) then begin
        AcbrNfe1.NotasFiscais.LoadFromStream( TStringStream.create( GetQualXml(Q,temxmltext) ) );
//        ListaTrans.Add(Q.fieldbyname('moes_transacao').asstring);
// 07.01.16 - Devereda - 'Out of Memory' - 320 notas de saida
       if not FileExists( ondesalvar+copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.id,4,44)+'-nfe.xml' ) then
         ACBrNFe1.NotasFiscais.Items[0].GravarXML(copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.id,4,44)+'-nfe.xml',ondesalvar);
// 15.08.18 - Polli Contadores -> Pagnoncelli
// 12.09.18 - devereda arquivo muito grande
       if Global.Topicos[1053] then  begin

         if not FileExists( ondesalvar+copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.id,4,44)+'.pdf' ) then
           ACBrNFe1.NotasFiscais.Items[0].ImprimirPDF;

       end;

// 11.10.16 - canceladas tbem - Jackson - Presidente
      end else if  Q.fieldbyname('Moes_Usua_CancNfe').asinteger>0 then begin

// 16.11.17 - jackson pegou erro
        temxmltext:='X';
//        AcbrNfe1.NotasFiscais.LoadFromStream( TStringStream.create( GetQualXml(Q,temxmltext) ) );
        Lista:=TStringList.Create;
        Lista.Append( GetQualXml(Q,temxmltext) );
        chavenfe:=FExpNfetxt.GetTag('chnfe',Lista.Text);
        if not FileExists( ondesalvar+(chavenfe)+'-can.xml' ) then
           Lista.SaveToFile( ondesalvar+(chavenfe)+'-can.xml' );
        Lista.Clear;
        temxmltext:='S';
      end;
      ACBrNFe1.NotasFiscais.Clear;

      Q.Next;
  end;
{
   if AcbrNfe1.NotasFiscais.Count>0 then begin
     for i:= 0 to AcbrNfe1.NotasFiscais.Count-1 do begin
       if not FileExists( ondesalvar+copy(ACBrNFe1.NotasFiscais.Items[i].NFe.infNFe.id,4,44)+'-nfe.xml' ) then
//         ACBrNFe1.NotasFiscais.Items[i].SaveToFile(ondesalvar+copy(ACBrNFe1.NotasFiscais.Items[i].NFe.infNFe.id,4,44)+'-nfe.xml');
         ACBrNFe1.NotasFiscais.Items[i].GravarXML(copy(ACBrNFe1.NotasFiscais.Items[i].NFe.infNFe.id,4,44)+'-nfe.xml',ondesalvar);
//       AcbrNfe1.NotasFiscais.Items[i].SaveToFile(ondesalvar+'\XML_NFe_'+strzero( AcbrNfe1.NotasFiscais.Items[i].NFe.Ide.nNF ,6)+'.XML' );
     end;
//     Aviso(strzero(marc,3)+' arquivo(s) Xml(s) gerados em '+ondesalvar);
   end;
/////////////////////
}

   FGeral.FechaQuery(Q);
// 15.08.18
   Acbrnfe1.DANFE.PathPDF:=FGeral.GetConfig1AsString('Pastaexpnfexml');

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
   if not Edcliente.IsEmpty then emailescritorio:='';

   Sistema.BeginProcess('Gerando arquivo compactado em '+ondesalvar+Arq);
//   DeleteFile( ondesalvar+Arq );  // por enquanto nao precisa pois cria novamente com todos os xmls
// pega apenas os xml que come�am por 4 ( 41, 42 )
   try
// 12.09.18 - devereda arquivo muito grande
     if Global.Topicos[1053] then

        ShellExecute(0,nil,'Winrar.exe',  PChar ('a -ep -ibck "'+OndeSalvar+'"'+Arq+' 4*.xml *.pdf' ), nil, sw_show)

     else

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
     assunto:='';
     if trim(emailescritorio)<>'' then begin
       Sistema.BeginProcess('Enviando email para '+emailescritorio);
       CorpoEmailTexto:=TstringList.Create;
       CorpoEmailTexto.Add('Anexo arquivo '+ListaAnexos[0]);
       CorpoEmailTexto.Add('XMLs refente '+strzero(Datetomes(EdTermino.AsDate),2)+'/'+
                        strzero(Datetoano(EdTermino.AsDate,true),4) );
// 14.03.2022 - escritorio q atende o pequim...
       assunto := 'Unidade:'+EdUnid_codigo.ResultFind.FieldByName('unid_razaosocial').AsString;
       assunto := assunto + ' CNPJ:'+EdUnid_codigo.ResultFind.FieldByName('unid_cnpj').AsString;
       assunto := assunto + ' Anexo arquivo '+ListaAnexos[0]+
                  ' XMLs refente '+strzero(Datetomes(EdTermino.AsDate),2)+'/'+
                        strzero(Datetoano(EdTermino.AsDate,true),4) ;

// 16.09.15 - refazendo...
       FGeral.EnviaEMailcomAnexo(emailescritorio,ListaAnexos,CorpoEmailTexto,'',assunto);
// 24.01.15
//       FRel.SendMail(emailescritorio);
       Sistema.endprocess('');
       CorpoEmailTexto.free;
     end;

   end else
     Sistema.EndProcess('Problemas ao gerar o arquivo compactado.  Verificar !');
   ListaAnexos.free;
end;

// 07.11.13
procedure TFGerenciaNfe.InutilizaNumero(xNumero,xNumerof: Integer);
//////////////////////////////////////////////////////////////////
var Q,QMovEstoque,QQtdeEstoque,QtdeEstoqueGrade:TSqlquery;
    sqldata,xtrans,sqlserie,mov,sqlcondi,romaneios:string;
    embalagem,xcodcor,xcodtamanho,xcodcopa,
    numerodoc,
    x                            :integer;
    sqlcor,sqltamanho,sqlcopa,
    xsqlcor,xsqltamanho,xsqlcopa,
    xlistapedidos                :string;
    ListaPedidos                 :TStringList;

begin
//  sqldata:=' and moes_dataemissao >= '+Datetosql( Sistema.Hoje-45 );
// 25.11.15
  sqldata:=' and moes_dataemissao >= '+Datetosql( Sistema.Hoje-360 );
// 21.09.15
//  if eNFCe<>'S' then
// 08.08.16
  if eNFCe='S' then
    sqlserie:=' and moes_serie='+Stringtosql(FGeral.GetSerieNFCE)
  else
    sqlserie:=' and moes_serie='+Stringtosql(EdUnid_codigo.resultfind.fieldbyname('unid_serie').asstring);

  sqlcondi:=' moes_numerodoc='+inttostr(xnumero);
  if xnumerof > xnumero then sqlcondi:=' moes_numerodoc >= '+inttostr(xnumero)+' and moes_numerodoc <= '+inttostr(xnumerof);
  if xnumero=0 then exit;

  Q:=sqltoquery('select moes_transacao,moes_numerodoc,moes_tipomov,moes_remessas,moes_tipo_codigo from movesto where '+
                sqlcondi+
                ' and moes_status<>''C'''+
//                ' and ( (moes_dtnfeauto is null) or (substr(moes_especie,1,3)=''NFE'') )' +
// 01.04.18 - lokuragens devereda
                ' and ( (moes_chavenfe is null) or ( moes_chavenfe='''' ) or (substr(moes_especie,1,3)=''NFE'') )' +
// 10.09.14 - para nao inutilizar notas de servi�o com mesma numeracao de nfe...
                sqlserie+
// 06.06.19
                ' and '+FGeral.GetNOTIN('moes_tipomov',Global.TiposNaoFiscal,'C')+
                ' and moes_unid_codigo='+Stringtosql(EdUNid_codigo.text)+
                sqldata+
                ' and '+FGeral.GetIN('moes_tipomov',tiposdemovimento,'C')
                );
  xtrans:='';
  numerodoc:=xnumero;
  if Q.Eof then Aviso('N�o encontrado documento(s)');

  while not Q.eof do begin
//    Sistema.BeginTransaction('');
// 21.09.15 - primeiro 'desbaixa o estoque'
    xnumero:=Q.FieldByName('moes_numerodoc').AsInteger;
////////////////////////////
// 16.10.17
    if pos(Q.FieldByName('moes_tipomov').AsString,Global.CodCompraProdutor+';'+
                                                  Global.CodEntradaProdutor+':'+
// 01.11.20 - Novicarnes
                                                  Global.CodTransfSaida)>0  then begin

      Sistema.Edit('movabate');
      Sistema.Setfield('mova_notagerada',0);
      Sistema.Setfield('mova_transacaogerada','');
      Sistema.post('mova_notagerada='+inttostr(numerodoc)+' and mova_unid_codigo='+EdUnid_codigo.assql+
                   ' and mova_tipo_codigo='+Q.FieldByName('moes_tipo_codigo').AsString+
                   ' and mova_tipomov='+stringtosql('EA')+
                   ' and mova_status=''N'' and mova_situacao=''N''');

    end;
///////////////////////////
    Sistema.BeginProcess('Inutilizando numero '+inttostr(numerodoc));
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

//22.07.20  - Novicarnes - Isonel - retornar pedido de venda
///////////////////////
    QMOvestoque:=sqltoquery('select moes_pedido,move_qtde,move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo,'+
                              'move_copa_codigo,move_tipomov,esto_embalagem from movestoque'+
                              ' inner join estoque on (esto_codigo=move_esto_codigo)'+
                              ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                              'where move_transacao = '+Stringtosql(Q.fieldbyname('moes_transacao').asstring));

// 'desbaixa' o pedido de venda usado na nf de venda  - mov � usado para retornar a qtde no est.   // 19.03.20
          if (QMovestoque.fieldbyname('moes_pedido').asinteger>0 ) and  ( length(trim(Q.fieldbyname('moes_remessas').asstring))=7 )
             then begin

             xListaPedidos:=strzero(QMovestoque.fieldbyname('moes_pedido').asinteger,7);
             ListaPedidos:=TStringList.create;
             strtolista(ListaPedidos,xListaPedidos,';',true);
             for x:=0 to ListaPedidos.Count-1 do begin

                if QMOvestoque.fieldbyname('move_core_codigo').asinteger>0 then
                  sqlcor:=' and mpdd_core_codigo='+QMOvestoque.fieldbyname('move_core_codigo').asstring
                else
                  sqlcor:=' and ( mpdd_core_codigo=0 or mpdd_core_codigo is null )';
                if QMOvestoque.fieldbyname('move_tama_codigo').asinteger>0 then
                  sqltamanho:=' and mpdd_tama_codigo='+QMOvestoque.fieldbyname('move_tama_codigo').asstring
                else
                  sqltamanho:=' and ( mpdd_tama_codigo=0 or mpdd_tama_codigo is null )';
                if QMOvestoque.fieldbyname('move_copa_codigo').asinteger>0 then
                  sqlcopa:=' and mpdd_copa_codigo='+QMOvestoque.fieldbyname('move_copa_codigo').asstring
                else
                  sqlcopa:=' and ( mpdd_copa_codigo=0 or mpdd_copa_codigo is null )';
                  Sistema.Edit('movpeddet');
                  Sistema.setfield('mpdd_situacao','P');
                  Sistema.setfield('mpdd_qtdeenviada',0);
                  Sistema.setfield('mpdd_dataenviada',Global.DataMenorBanco);
                  Sistema.setfield('mpdd_nfvenda',0);
                  Sistema.setfield('mpdd_datanfvenda',Global.DataMenorBanco);
                  Sistema.post('mpdd_numerodoc='+inttostr(strtoint(ListaPedidos[x]))+
                               ' and mpdd_status=''N'' and mpdd_tipo_codigo='+QMOvestoque.fieldbyname('move_tipo_codigo').asstring+
                               ' and mpdd_esto_codigo='+stringtosql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
                               sqlcor+
                               sqltamanho+sqlcopa
                               );

             end; // lista pedidos
             ListaPedidos.free;

          end;
    FGeral.Fechaquery(QMovEstoque);

/////////
/// ////////////////////

    Sistema.Edit('movesto');
    Sistema.SetField('moes_status','I');
    Sistema.SetField('moes_vlrtotal',0);
    Sistema.SetField('moes_baseicms',0);
// 06.05.20 - Novicarnes - simone pegou
    Sistema.SetField('moes_valoricms',0);
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
// 06.05.20
    Sistema.SetField('movb_imposto',0);
    Sistema.Post('movb_transacao = '+Stringtosql(Q.fieldbyname('moes_transacao').asstring));

    Sistema.Edit('pendencias');
    Sistema.SetField('pend_status','I');
    Sistema.SetField('pend_valor',0);
    Sistema.Post('pend_transacao = '+Stringtosql(Q.fieldbyname('moes_transacao').asstring));
// 07.07.20 - Vida Nova
    Sistema.Edit('movfin');
    Sistema.SetField('movf_status','I');
    Sistema.SetField('movf_valorger',0);
    Sistema.Post('movf_transacao = '+Stringtosql(Q.fieldbyname('moes_transacao').asstring));

//    Sistema.EndTransaction('');
// 20.07.15
    Sistema.Commit;
    if xnumero=xnumerof then
      Aviso('Numera��o Inutilizada no sistema');
// 08.11 - guardar 'algo' sobre nota inutilizada
    FGeral.GravaLog(27,'Numera��o de NFe inutilizada '+inttostr(Numerodoc),true);

//  if trim(xtrans)<>'' then
//    FCanctransacao.Execute(xtrans);


    Q.next;
  end;

  Sistema.EndProcess('');
  FGeral.FechaQuery(Q);


end;

// 14.01.2021 - Verifica 'salto' na numeracao da nfe num periodo
procedure TFGerenciaNfe.sbchecanumeracaoClick(Sender: TObject);
////////////////////////////////////////////////////////////////////
var Qx   :TSqlquery;
    serie,
    especie:string;
    numnota,
    num,
    p      :integer;

    function GetSerieNFCe:string;
    //////////////////////////////
    var QS       :TSqlquery;
        codigomov:integer;

    begin

       codigomov:=FGeral.GetConfig1Asinteger('ConfMovNFCe');
       result:='1';
       if codigomov = 0 then begin

          Avisoerro('Usando s�rie 1. N�o configurado codigo de mov. ref. NFCe nas config. gerais');

       end else begin

          QS := sqltoquery('select Comv_serie from Confmov where comv_codigo = '+inttostr(codigomov));
          if not QS.eof then result:=Qs.fieldbyname('comv_serie').asstring;
          FGeral.Fechaquery(Qs);

       end;

    end;


begin

    if ( EdTermino.isempty  ) or ( EdInicio.isempty )then exit;
    especie:='NFC';
    serie  :=GetSerieNFCe;
    Qx := sqltoquery('select moes_numerodoc,moes_especie,moes_serie,moes_dataemissao,moes_datamvto from movesto'+
                     ' where '+FGeral.getin('moes_status','N;E;D;X;I','C')+
                     ' and moes_dataemissao >= '+EdInicio.assql+
                     ' and moes_dataemissao <= '+EdTermino.assql+
                     ' and moes_serie = '+stringtosql(serie)+
                     ' and substr(moes_especie,1,3) = '+stringtosql(especie)+
                     ' and moes_unid_codigo='+EdUnid_codigo.assql+
                     ' and moes_datacont > '+DatetoSql(Global.DataMenorBanco)+
                     ' order by moes_numerodoc');
    numnota := Qx.fieldbyname('moes_numerodoc').asinteger;
    Grid.clear;
    p:=Grid.row+1;
    while not Qx.eof do begin

        numnota := Qx.fieldbyname('moes_numerodoc').asinteger;
        Qx.Next;
        if not Qx.eof then begin

           if (Qx.fieldbyname('moes_numerodoc').asinteger-numnota)>1 then begin

              for num := numnota+1 to Qx.fieldbyname('moes_numerodoc').asinteger-1 do begin

                Grid.Cells[Grid.GetColumn('moes_numerodoc'),p]:=inttostr(num);
                Grid.Cells[Grid.GetColumn('especie'),p]:=especie;
                Grid.AppendRow;
                inc(p);

              end;

           end;

        end;

    end;
    FGeral.Fechaquery(Qx);

end;


// 21.12.2022 - Devereda
procedure TFGerenciaNfe.sbchecanumeracaonfeClick(Sender: TObject);
///////////////////////////////////////////////////////////////////
var Qx   :TSqlquery;
    serie,
    especie:string;
    numnota,
    num,
    p      :integer;

    function GetSerieNFe:string;
    //////////////////////////////
    var QS       :TSqlquery;

    begin

       result:='1';
       QS := sqltoquery('select Comv_serie from Confmov where comv_especie = '+stringtosql('NFE')+
                        ' and comv_tipomovto = '+stringtosql('VD') );
       if QS.eof then

          Avisoerro('Usando s�rie 1. N�o configurado codigo de mov. NFE e VD nas config. de movimento')

       else

          result:=Qs.fieldbyname('comv_serie').asstring;

       FGeral.Fechaquery(Qs);

    end;


begin

    if ( EdTermino.isempty  ) or ( EdInicio.isempty )then exit;
    especie:='NFE';
    serie  :=GetSerieNFe;
    Qx := sqltoquery('select moes_numerodoc,moes_especie,moes_serie,moes_dataemissao,moes_datamvto from movesto'+
                     ' where '+FGeral.getin('moes_status','N;E;D;X;I','C')+
                     ' and moes_dataemissao >= '+EdInicio.assql+
                     ' and moes_dataemissao <= '+EdTermino.assql+
                     ' and moes_serie = '+stringtosql(serie)+
                     ' and substr(moes_especie,1,3) = '+stringtosql(especie)+
                     ' and moes_unid_codigo='+EdUnid_codigo.assql+
                     ' and substr(moes_natf_codigo,1,1) >= '+stringtosql('5')+
                     ' and moes_datacont > '+DatetoSql(Global.DataMenorBanco)+
                     ' order by moes_numerodoc');
    numnota := Qx.fieldbyname('moes_numerodoc').asinteger;
    Grid.clear;
    p:=Grid.row+1;
    while not Qx.eof do begin

        numnota := Qx.fieldbyname('moes_numerodoc').asinteger;
        Qx.Next;
        if not Qx.eof then begin

           if (Qx.fieldbyname('moes_numerodoc').asinteger-numnota)>1 then begin

              for num := numnota+1 to Qx.fieldbyname('moes_numerodoc').asinteger-1 do begin

                Grid.Cells[Grid.GetColumn('moes_numerodoc'),p]:=inttostr(num);
                Grid.Cells[Grid.GetColumn('especie'),p]:=especie;
                Grid.AppendRow;
                inc(p);

              end;

           end;

        end;

    end;
    FGeral.Fechaquery(Qx);
end;

//////////////////// 10.07.14
procedure TFGerenciaNfe.bimpcceClick(Sender: TObject);
///////////////////////////////////////////////////////////////
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
     Avisoerro('Nota sem chave da NFe.   Verificar');
     exit;
   end;
   if trim(Q.fieldbyname('moes_xmlcce').AsString)='' then begin
     Avisoerro('Nota sem carta de corre��o gravada.   Verificar');
     exit;
   end;

///////////////   Acbrnfe1.DANFE:=ACBrNFeDANFCeFortes1;
// 07.04.16
   Acbrnfe1.DANFE:=AcbrNfeDanfeRL1;
   ACBrNFeDANFCeFortes1.MostraPreview := True;
// 25.08.2022 - Sport A��o - Gisele - impressora 'espec�fica'..
   FGeral.ConfiguraMargemNfe( ACBrNFeDANFERl1 );

   ACBrNFe1.NotasFiscais.Clear;
   ACBrNFe1.NotasFiscais.LoadFromString( Q.fieldbyname('moes_xmlnfet').AsString );
   ACBrNFe1.EventoNFe.Evento.Clear;
   codOrgao := copy(Chave,1,2);
   CNPJ := copy(Chave,7,14);
//   ACBrNFe1.EventoNFe.LerXMLFromString(Q.fieldbyname('moes_xmlcce').AsString);
// 24.03.15

//   with ACBrNFe1.EventoNFe.Evento.Items[0] do begin
   with ACBrNFe1.EventoNFe.Evento.Add do begin
      InfEvento.tpEvento := teCCe;
      InfEvento.cOrgao:=StrToInt(codOrgao);
      InfEvento.chNFe:=chave;
      InfEvento.CNPJ:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').AsString;
      if FExpNfetxt.GetTag('tpAmb',Q.fieldbyname('moes_xmlcce').asstring)='1' then
         InfEvento.tpAmb:=taProducao
      else
         InfEvento.tpAmb:=taHomologacao;
      infEvento.dhEvento := Texttodate(
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),9,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),6,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),1,04)
         );
      infEvento.nSeqEvento := strtoint(FExpNfetxt.GetTag('nSeqEvento',Q.fieldbyname('moes_xmlcce').asstring));
      infEvento.detEvento.descEvento := FExpNfetxt.GetTag('xEvento',Q.fieldbyname('moes_xmlcce').asstring);
      infEvento.detEvento.xCorrecao := Q.fieldbyname('moes_obs').asstring;
      infEvento.detEvento.nProt:= FExpNfetxt.GetTag('nProt',Q.fieldbyname('moes_xmlcce').asstring);
      infEvento.detEvento.dhEmi:=Texttodate(
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),9,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),6,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),1,04)
         );
   end;

{
    with ACBrNFe1.EventoNFe.Evento.Add do begin
      InfEvento.tpEvento := teCCe;
      InfEvento.cOrgao:=StrToInt(codOrgao);
      InfEvento.chNFe:=chave;
      InfEvento.CNPJ:=EdUnid_codigo.ResultFind.fieldbyname('unid_cnpj').AsString;

//      if  FGeral.GetConfig1AsString('AmbienteNFe')='1' then
      if FExpNfetxt.GetTag('tpAmb',Q.fieldbyname('moes_xmlcce').asstring)='1' then
         InfEvento.tpAmb:=taProducao
      else
         InfEvento.tpAmb:=taHomologacao;
      infEvento.dhEvento := Texttodate(
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),9,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),6,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),1,04)
         );
      infEvento.nSeqEvento := strtoint(FExpNfetxt.GetTag('nSeqEvento',Q.fieldbyname('moes_xmlcce').asstring));
      infEvento.versaoEvento :='1.00';
      infEvento.detEvento.descEvento := FExpNfetxt.GetTag('xEvento',Q.fieldbyname('moes_xmlcce').asstring);
      infEvento.detEvento.xCorrecao := Q.fieldbyname('moes_obs').asstring;
      infEvento.detEvento.nProt:= FExpNfetxt.GetTag('nProt',Q.fieldbyname('moes_xmlcce').asstring);
      infEvento.detEvento.dhEmi:=Texttodate(
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),9,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),6,02)+
         copy(FExpNfetxt.GetTag('dhRegEvento',Q.fieldbyname('moes_xmlcce').asstring),1,04)
         );
    end;
}

   ACBrNFe1.ImprimirEvento;
   Acbrnfe1.DANFE:=AcbrNfeDanfeRL1;

end;

// 19.12.14
procedure TFGerenciaNfe.Teste(Sender: TObject);
/////////////////////////////////////////////////////////////
var ListaArquivo,ListaLinha:TStringList;
    p,xnfsaida:integer;
    xcodigo,xnome,xcpfcnpj,xemissao,xnf,xie,xendereco,xbairro,xfone,xcel,xcep,xestcivil,
    xcadpro,xadmissao,xconjuge,xcpfconjuge,xcontasprodutorleite,transacao,xtransacoes:string;
    xvlrbruto,xinss,xfrete,xtxadm,xtxassoc,xprecoliq:currency;
    demissao:TDatetime;
    var Q,QComv:TSqlquery;
begin
{
   if not od1.execute then exit;
   if trim(od1.FileName)='' then exit;
   ListaArquivo:=TStringList.create;
   ListaArquivo.LoadFromFile(od1.FileName);
   ListaLinha:=TStringList.create;
   strtolista(ListaLinha,ListaArquivo[p],';',true);
   if ListaLinha.Count>10 then xemissao:=ListaLinha[1]
   else xemissao:='';
   if trystrtodate( xemissao,global.datasistema ) then begin
     demissao:=strtodate(xemissao);
   end else begin
      avisoerro('Verificar data de emiss�o no inicio do arquivo');
      exit;
   end;
   if not confirma('Confirma importa��o das notas de produtor ? ') then exit;
   Sistema.BeginProcess('eliminando importa��o anterior');
   Q:=sqltoquery('select moes_transacao from movesto '+
              ' where moes_status=''N'''+
              ' and '+FGeral.getin('moes_tipomov',global.CodCompraProdutor,'C')+
              ' and '+FGeral.getin('moes_plan_codigo',xContasProdutorLeite,'C')+
              ' and moes_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
              ' and moes_dataemissao='+Datetosql(demissao) );
   xtransacoes:='';
   QComv:=sqltoquery('select comv_serie,comv_codigo from confmov where comv_tipomovto='+Stringtosql(Global.CodCompraProdutor));
   xnfsaida:=FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+FGeral.Qualserie(QComv.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,false);
   if not Q.eof then
     if not confirma('Numera��o de notas est� em '+inttostr(xnfsaida)+'.  Confirma ? ') then exit;

   while not Q.eof do begin
     xtransacoes:=xtransacoes+';'+Q.fieldbyname('moes_transacao').asstring;
     Q.Next;
   end;
   Q.close;
   if trim(xtransacoes)<>'' then begin
     Executesql('update movesto set moes_status=''C'''+
              ' where moes_status=''N'''+
              ' and '+FGeral.getin('moes_tipomov',global.CodCompraProdutor,'C')+
              ' and '+FGeral.getin('moes_plan_codigo',xContasProdutorLeite,'C')+
              ' and move_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
              ' and '+FGeral.getin('moes_transacao',xtransacoes,'C')+
              ' and moes_dataemissao='+Datetosql(demissao) );
     Executesql('update movestoque set moes_status=''C'''+
              ' where moes_status=''N'''+
              ' and '+FGeral.getin('move_tipomov',global.CodCompraProdutor,'C')+
              ' and move_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
              ' and '+FGeral.getin('move_transacao',xtransacoes,'C')+
              ' and moes_dataemissao='+Datetosql(demissao) );
     Executesql('update movbase set moes_status=''C'''+
              ' where moes_status=''N'''+
              ' and '+FGeral.getin('movb_tipomov',global.CodCompraProdutor,'C')+
              ' and movb_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
              ' and '+FGeral.getin('movb_transacao',xtransacoes,'C')+
              ' and moes_dataemissao='+Datetosql(demissao) );
     Executesql('update pendencias set pend_status=''C'''+
              ' where moes_status=''N'''+
              ' and pend_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
              ' and '+FGeral.getin('pend_tipomov',global.CodCompraProdutor,'C')+
              ' and '+FGeral.getin('pend_transacao',xtransacoes,'C') );
     Sistema.Endprocess('');
   end;

   for p:=0 to ListaArquivo.Count-1 do begin
     ListaLinha:=TStringList.create;
     strtolista(ListaLinha,ListaArquivo[p],';',true);
     if ListaLinha.Count>10 then xemissao:=ListaLinha[1];
     if trystrtodate( xemissao,Global.Datasistema ) then begin
       demissao:=strtodate(xemissao);
       xnfsaida:=FGeral.GetContador('NFSAIDA'+Global.CodigoUnidade+FGeral.Qualserie(QComv.fieldbyname('comv_serie').asstring,Global.SerieUnidade),false,true);
       transacao:=FGeral.GetTransacao;
       Sistema.Insert('movesto');
        Sistema.SetField('moes_transacao',Transacao);
        Sistema.SetField('moes_operacao',GetOperacao);
        Sistema.SetField('moes_status','N');
        Sistema.SetField('moes_numerodoc',Numero);
        Sistema.SetField('moes_tipomov',Global.CodCompraProdutor);
        Sistema.SetField('moes_comv_codigo',Qcomv.fieldbyname('comv_codigo').AsString);
        Sistema.SetField('moes_unid_codigo',Global.CodigoUnidade);
    //    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
        Sistema.SetField('moes_tipo_codigo',Fornecedor.AsInteger);
    // 31.07.07
    //    if codcidade=0 then begin
          if Tipocad='F' then begin
            Sistema.SetField('moes_estado',Fornecedor.ResultFind.fieldbyname('forn_uf').AsString);
            Sistema.SetField('moes_cida_codigo',Fornecedor.ResultFind.fieldbyname('forn_cida_codigo').AsInteger);
          end else begin
            Sistema.SetField('moes_estado',Fornecedor.ResultFind.fieldbyname('clie_uf').AsString);
            Sistema.SetField('moes_cida_codigo',Fornecedor.ResultFind.fieldbyname('clie_cida_codigo_res').AsInteger);
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
            Sistema.SetField('moes_basesubsqtrib',basesubs);
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
              Sistema.setfield('moes_chavenfe',ACBrNFe1.NotasFiscais.Items[0].NFe.procNFe.chNFe);
            end;
          end;
        end;
    //////////////////
    // 23.08.13
        if Global.Topicos[1365] then Sistema.SetField('moes_seto_codigo',cseto_codigo);

        Sistema.Post();

       Sistema.post();
       Sistema.Insert('movestoque')
       Sistema.post();
       Sistema.Insert('movbase')
       Sistema.post();
     end;
     ListaLinha.Free;
   end;
   }
end;

// 08.07.15
procedure TFGerenciaNfe.ImprimeNfeNFCe(xmodelo: integer);
//////////////////////////////////////////////////////////////
var ct,ct1,temxmltext,campoxml,
    ximpressaonfce,
    xtiponfce,
    s,
    xusaTS      :string;
    Q:TSqlquery;
    ListaXML,ListaProtDpec,ListaTrans:TStringList;
    arqxml,codigosdesti,codigosdesti1,impressoranfce,impressoranfe:string;
    marc,i,
    p                :integer;
    Papel: TtbPrnPaper;

    function GetProtocoloDpec(nNF:integer):string;
    /////////////////////////////////////////////
    var x:integer;
    begin
      result:='';
      for x:=0 to ListaProtDpec.Count-1 do begin
        if pos(';NF'+strzero(nNF,6),ListaProtDpec.Strings[x])>0 then begin
          result:=copy(ListaProtDpec.Strings[x],1,pos(';',ListaProtDpec.Strings[x])-1 );
          break;
        end;
      end;
    end;

begin
///////////////////////////////////////////////
// 08.07.15
  xtiponfce:=FGeral.Getconfig1asstring('tiponfce');
  if trim(xtiponfce)='' then xtiponfce:='1';
// 21.06.2022
  xusaTS := 'N';
  xusaTS := LeArquivoINI(Global.NomeSistema,'Impressoras','TS');

// 31.08.18 - ainda a impressao errada na jato quando....benato
  if (Global.UsaNFCe='S') and ( xusaTS<>'S') then begin

     if xmodelo=55 then
       s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFE')
     else
       s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFCE');

     if trim(s)<>'' then begin
        Combobox1.Text:=s;
        for p := 0 to Combobox1.Items.Count-1 do begin
            if Combobox1.Items.Strings[p] = s then begin
               Printer.PrinterIndex := p;
               ComboBox1.ItemIndex:=p;
            end;
        end;
     end;

  end else if (Global.UsaNFCe='S') and ( xusaTS ='S') then begin

    for p := 0 to Combobox1.Items.Count-1 do begin

//       ShowMessage('impressora '+Combobox1.Items.Strings[p]);

       if EimpressoraSetada(  Combobox1.Items.Strings[p], xsituacaonotas, xusaTS ) then
          ComboBox1.Text:= Combobox1.Items.Strings[p] ;
    end;

  end;

  if xmodelo=55 then begin

    Acbrnfe1.DANFE:=AcbrNfeDanfeRL1;
    AcbrNfe1.DANFE.TipoDANFE := tiretrato;
// 07.04.18
    Printer.PrinterIndex := ComboBox1.ItemIndex;
    ACBrNFeDANFERL1.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];
// 02.06.20 - Guiber
    if Global.Topicos[1472] then begin
  // 26.06.19
        ACBrNFeDANFCeFortes1.ImprimeNomeFantasia:=true;
        ACBrNFeDANFERl1.ImprimeNomeFantasia:=true;

    end else begin

        ACBrNFeDANFCeFortes1.ImprimeNomeFantasia:=false;
        ACBrNFeDANFERl1.ImprimeNomeFantasia:=false;

    end;
// 17.12.20 - Seip Portoes - Aline
    FGeral.ConfiguraMargemNfe( ACBrNFeDANFERl1 );

  end else if xtiponfce='1' then begin

        Acbrnfe1.DANFE:=ACBrNFeDANFCeFortes1;
        AcbrNfe1.DANFE.TipoDANFE := tiNFCE;
// 07.04.18
       Printer.PrinterIndex := ComboBox1.ItemIndex;
       ACBrNFeDANFCeFortes1.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];
// 11.07.18 - cia da fruta corta duas colunas na margem direita
// 05.06.19 - sai 'cabe' na impressao...mirvane
       ACBrNFeDANFCeFortes1.MargemDireita :=Fgeral.GetConfig1AsInteger( 'nfcemargemdir' );
       ACBrNFeDANFCeFortes1.MargemEsquerda:=Fgeral.GetConfig1AsInteger( 'nfcemargemesq' );
// 02.06.20 - Guiber
       if Global.Topicos[1472] then begin

          ACBrNFeDANFCeFortes1.ImprimeNomeFantasia:=true;
          ACBrNFeDANFCeFortes1.ImprimeEmUmaLinha:=true;
       end else begin

          ACBrNFeDANFCeFortes1.ImprimeNomeFantasia:=false ;
          ACBrNFeDANFCeFortes1.ImprimeEmUmaLinha:=false;

       end;

  end else if xtiponfce='2' then begin

        AcbrNFe1.DANFE := TACBrNFeDANFCeFortesA4.Create(AcbrNFe1);
//        AcbrNfe1.DANFE.TipoDANFE := tiNFCeA4;
// 07.02.18
        AcbrNfe1.DANFE.TipoDANFE := tiNFCe;
// 07.04.18
       Printer.PrinterIndex := ComboBox1.ItemIndex;
       ACBrNFe1.DANFE.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];

  end else if xtiponfce='3' then begin
//        AcbrNFe1.DANFE := TACBrNFeDANFCeFortesA4RM.Create(AcbrNFe1);
//        AcbrNfe1.DANFE.TipoDANFE := tiNFCeA4;
// 08.02.17
        AcbrNFe1.DANFE := TACBrNFeDANFCeFortesA4.Create(AcbrNFe1);
//        AcbrNfe1.DANFE.TipoDANFE := tiNFCeA4;
// 07.02.18
        AcbrNfe1.DANFE.TipoDANFE := tiNFCe;
// 07.04.18
       Printer.PrinterIndex := ComboBox1.ItemIndex;
       ACBrNFe1.DANFE.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];

  end else begin

        AcbrNFe1.DANFE := TACBrNFeDANFCeFortesEA.Create(AcbrNFe1);
        AcbrNfe1.DANFE.TipoDANFE := tiNFCE;
// 07.04.18
        Printer.PrinterIndex := ComboBox1.ItemIndex;
        ACBrNFe1.DANFE.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];

  end;

    if trim( FGeral.GetConfig1AsString('PastaPdfs') ) <> '' then
      Acbrnfe1.DANFE.PathPDF:=FGeral.GetConfig1AsString('PastaPdfs')
    else
      Acbrnfe1.DANFE.PathPDF:=ExtractFilePath( Application.ExeName );


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
      Avisoerro('Sem nota escolhida');
      exit;
   end;
   if trim(codigosdesti)='' then begin
      Avisoerro('Sem cliente OU nota escolhida');
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
// para nao imprimir transferencia 'duas vezes'
                ' and '+FGeral.GetIN('moes_tipo_codigo',codigosdesti,'N')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C'' order by moes_numerodoc')
   end else
     Q:=Sqltoquery('select moes_xmlnfe,moes_dtnfeauto,moes_transacao,moes_dtnfecanc,moes_protodpec,moes_numerodoc from movesto where '+
                 FGeral.GetIN('moes_transacao',ct,'C')+
// para nao imprimir transferencia 'duas vezes'
                ' and '+FGeral.GetIN('moes_tipo_codigo',codigosdesti,'N')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                 ' and moes_status<>''C'' order by moes_numerodoc');


/////////////////////////////////
///  08.02.18 - recolocado este trecho pois benato imprimiu nfc-e sem autorizar
  if (trim(Q.fieldbyname('moes_xmlnfet').asstring)='')
// 04.09.20
      and
      ( not Global.Usuario.OutrosAcessos[0353] )
  then begin

      Avisoerro('Transa��o '+ct+' sem XML gravado');
      exit;

  end else if FExpNfetxt.GetTag('tpemis',Q.fieldbyname('moes_xmlnfet').asstring)='2' then begin

     Aviso('Transa��o '+ct+' se ref. a nfe em conting�ncia. Impress�o de Danfe em form. seguran�a');

  end else if ( DAtetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)<=1900 )
      and
         ( not Global.Usuario.OutrosAcessos[0353] )
  then begin

     Avisoerro('Transa��o '+ct+' ainda n�o foi autorizada');
     exit;
// 08.02.18

  end else if ( AnsiPos('Autorizado',FExpNfetxt.GetTag('xmotivo',Q.fieldbyname('moes_xmlnfet').asstring))= 0 )
      and
      ( not Global.Usuario.OutrosAcessos[0353] )

  then begin

     Aviso('Nfe ref. Transa��o '+ct+' ainda n�o autorizada pela SEFA');
     exit;

  end else if DAtetoano(Q.fieldbyname('moes_dtnfecanc').asdatetime,true)>1900 then begin

     Avisoerro('NFe ref. Transa��o '+ct+' foi cancelada em '+FGeral.FormataData(Q.fieldbyname('moes_dtnfecanc').asdatetime));
     exit;

  end;
/////////////////////////////////

   AcbrNfe1.NotasFiscais.Clear;
   ListaXML:=TStringList.Create;
   ListaTrans:=TStringList.Create;
   arqxml:='IMPDanfe.txt';
   if not FileExists(arquivorave) then begin
     Avisoerro('Arquivo '+arquivorave+' n�o encontrado');
     exit;
   end;
// 01.07.10
   if Q.eof then begin
     Avisoerro('Nada encontrado para impress�o.  Checar notas');
     exit;
   end;
//
// 07.07.10 - Clessi - configuracao das casas decimais da qtde e do valor unitario
   if FGeral.GetConfig1AsInteger('decqtdedanfe') >0 then
     ACBrNFeDANFERL1.CasasDecimais.qCom:=FGeral.GetConfig1AsInteger('decqtdedanfe');
   if FGeral.GetConfig1AsInteger('decunitariodanfe') >0 then
     ACBrNFeDANFERL1.CasasDecimais.vUnCom:=FGeral.GetConfig1AsInteger('decunitariodanfe');
   if FGeral.GetConfig1AsInteger('decqtdedanfe') >0 then
     ACBrNFeDANFCeFortes1.CasasDecimais.qCom:=FGeral.GetConfig1AsInteger('decqtdedanfe');
   if FGeral.GetConfig1AsInteger('decunitariodanfe') >0 then
     ACBrNFeDANFCeFortes1.CasasDecimais.vUnCom:=FGeral.GetConfig1AsInteger('decunitariodanfe');
// 10.10.15
   ListaProtDpec:=TStringList.Create;

// 15.04.16 - pra tratar RM
   if FGeral.getconfig1asinteger('TAMFONTEDANFE')>0 then
      ACBrNFeDANFERL1.Fonte.TamanhoFonteDemaisCampos:=FGeral.getconfig1asinteger('TAMFONTEDANFE')
   else
      ACBrNFeDANFERL1.Fonte.TamanhoFonteDemaisCampos:=10;

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
        AcbrNfe1.NotasFiscais.LoadFromFile(arqxml);
//dpec
      end else if FExpNfetxt.GetTag('tpemis',Q.fieldbyname(campoxml).asstring)='4' then begin

        if trim(Q.fieldbyname('moes_protodpec').asstring)='' then
          Avisoerro('Transa��o '+Q.fieldbyname('moes_transacao').asstring+' sem Protocolo de Envio ao DPEC')

        else begin

          ListaXML.Clear;
          ListaXML.Append( GetQualXml(Q,temxmltext) );
          ListaXml.SaveToFile(arqxml);
          AcbrNfe1.NotasFiscais.LoadFromFile(arqxml);
          ListaProtDpec.Add(Q.fieldbyname('moes_protodpec').asstring+';NF'+strzero(Q.fieldbyname('moes_numerodoc').asinteger,6));

        end;

      end else if ( DAtetoano(Q.fieldbyname('moes_dtnfeauto').asdatetime,true)<=1900  ) and
                  ( not Global.Usuario.OutrosAcessos[0353] )

      then

        Avisoerro('Transa��o '+Q.fieldbyname('moes_transacao').asstring+' ainda n�o foi autorizada')

      else if DAtetoano(Q.fieldbyname('moes_dtnfecanc').asdatetime,true)>1900 then begin

        Avisoerro('NFe ref. Transa��o '+ct+' foi cancelada na Sefa');

      end else begin

        ListaXML.Clear;

        ListaXML.Append( GetQualXml(Q,temxmltext) );


// 16.07.20 - come�ou a dar erro de acesso negado no c:\sac\impdanfe.txt
//        ListaXml.SaveToFile(arqxml);
//        AcbrNfe1.NotasFiscais.LoadFromFile(arqxml);

        AcbrNfe1.NotasFiscais.LoadFromString( ListaXml.text,false);

        ListaTrans.Add(Q.fieldbyname('moes_transacao').asstring);

      end;
      Q.Next;
   end;
   if AcbrNfe1.NotasFiscais.Count>0 then begin

//    Printer.PrinterIndex := ComboBox1.ItemIndex;
//     ACBrNFeDANFERL1.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];
//     ACBrNFeDANFCeFortes1.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];
//     ACBrNFe1.DANFe.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];
//     ACBrNFeDANFERL1.Impressora:=Combobox1.Items.Strings[ComboBox1.ItemIndex];

     impressoranfce:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFCE');
     impressoranfe:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPNFE');
// 11.04.16
     if (xmodelo=65) and (impressoranfce<>'') then
       combobox1.text:=impressoranfce;
     if (xmodelo=55) and (impressoranfe<>'') then
       combobox1.text:=impressoranfe;

     ACBrNFeDANFCeFortes1.Impressora:=Combobox1.Text;
     ACBrNFe1.DANFe.Impressora:=Combobox1.Text;
     ACBrNFeDANFERL1.Impressora:=Combobox1.Text;

// 22.01.16
     if Printer.Printers.IndexOfName( Combobox1.text ) <> -1 then begin
         Printer.PrinterIndex:=Printer.Printers.IndexOfName( Combobox1.text );
         Papel.Width  := Printer.PageWidth;
         Papel.Height := Printer.PageHeight;
     end;


     if (FGeral.GetConfig1AsInteger('copiasdanfe')>0) and (xmodelo=55) then
       PrintDialogBoleto.Copies:=FGeral.GetConfig1AsInteger('copiasdanfe')
     else if xmodelo=65 then begin

       PrintDialogBoleto.Copies:=1;
// 13.08.2021 - contingencdia offline pra nfce
       if FExpNfetxt.GetTag('tpemis',Q.fieldbyname(campoxml).asstring)='8' then

          PrintDialogBoleto.Copies:=2;


     end;
// 19.04.11 - Capeg - leite das crian�as
       if marc>1 then  begin
         if not PrintDialogBoleto.Execute then begin
           exit;
         end;
       end;

//     AcbrNfe1.DANFE.NumCopias:=PrintDialogBoleto.Copies;
// 21.09.10
     AcbrNfeDANFERL1.NumCopias:=PrintDialogBoleto.Copies;
     ACBrNFeDANFCeFortes1.NumCopias:=PrintDialogBoleto.Copies;
     ACBrNFe1.DANFe.NumCopias:=PrintDialogBoleto.Copies;
// 02.02.10 - Novi - vava
     AcbrNfeDANFERL1.Email:=EdUnid_codigo.ResultFind.fieldbyname('unid_email').asstring;
     ACBrNFeDANFCeFortes1.Email:=EdUnid_codigo.ResultFind.fieldbyname('unid_email').asstring;
     ACBrNFe1.DANFe.Email:=EdUnid_codigo.ResultFind.fieldbyname('unid_email').asstring;
     ACBrNFe1.DANFe.logo:=ACBrNFeDANFCeFortes1.logo;
//     AcbrNfe1.DANFE.Site:=

     AcbrNfe1.NotasFiscais.GerarNFe;
// 17.03.2021 - 'caso silvano' do desconto de 0,03 centavos

// 24.05.16  - Markito
////////////////////////
        if Global.topicos[1394] then begin
          ACBrNFeDANFERL1.ExibeResumoCanhoto:=false;
//          ACBrNFeDANFCeFortes1.ExibeResumoCanhoto:=false;
        end else begin
          ACBrNFeDANFERL1.ExibeResumoCanhoto:=true;
//          ACBrNFeDANFCeFortes1.'ExibeResumoCanhoto:=true;
        end;
////////////
/////////
// 01.12.10 - Massas Granzotto -
     if marc>1 then begin

        ACBrNFeDANFERL1.MostraPreview:=false;
        ACBrNFeDANFCeFortes1.MostraPreview:=false;
// 16.12.15
        if xmodelo=65 then begin
          ACBrNFeDANFCeFortes1.Logo:='';
          ACBrNFe1.DANFe.logo:='';
        end;

     end else begin

        ACBrNFeDANFERL1.MostraPreview:=false;
// 03.02.15
        if Global.topicos[1389] then ACBrNFeDANFERl1.MostraPreview:=true;
// 18.03.20 - Novicarnes - Vagner
        if Global.Usuario.OutrosAcessos[0350] then ACBrNFeDANFERl1.MostraPreview:=true;

// 17.12.15
        if xmodelo=65 then begin

          if xtiponfce='1' then begin

            ACBrNFeDANFCeFortes1.MostraPreview:=false;
  // 10.10.15 - para nao imprmir logo na impressora nao fiscal
            ACBrNFeDANFCeFortes1.Logo:='';
  // 16.12.15
            ACBrNFe1.DANFe.logo:='';
            if Global.topicos[1383] then ACBrNFeDANFCeFortes1.MostraPreview:=true;

          end else begin

            acbrnfe1.danfe.MostraPreview:=false;
            if Global.topicos[1383] then acbrnfe1.danfe.MostraPreview:=true;
//            acbrnfe1.danfe.TipoDANFE:=tiNFCeA4;
// 07.02.18
            acbrnfe1.danfe.TipoDANFE:=tiNFCe;
          end;
        end;
     end;
     for i:=0 to AcbrNfe1.NotasFiscais.Count-1 do begin
//        if ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.Modelo=55 then begin
        if (xmodelo=55) and (ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.Modelo=xModelo) then begin

          ACBrNFeDANFERL1.Protocolo:=GetProtocoloDpec(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);
          ACBrNFeDANFERL1.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

        end else if (xmodelo=65) and (ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.Modelo=xModelo) then begin

          if xtiponfce='1' then begin

            ACBrNFeDANFCeFortes1.Protocolo:=GetProtocoloDpec(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);
            ACBrNFeDANFCeFortes1.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

          end else begin

            ACBrNFe1.DANFe.Protocolo:=GetProtocoloDpec(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);
            ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

          end;
// 12.11.15
          if marc<=1 then begin

// 16.08.2021 - contingencdia offline pra nfce
// aqui imprime 'obrigado a segunda via' da nfc-e
            if ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.tpEmis  = teOffLine then begin

                if xtiponfce='1' then begin

                  ACBrNFeDANFCeFortes1.Protocolo:=GetProtocoloDpec(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);
                  ACBrNFeDANFCeFortes1.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

                end else begin

                  ACBrNFe1.DANFe.Protocolo:=GetProtocoloDpec(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);
                  ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

                end;

            end else begin

              if confirma('Imprimir segunda via ?') then begin

                if xtiponfce='1' then begin

                  ACBrNFeDANFCeFortes1.Protocolo:=GetProtocoloDpec(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);
                  ACBrNFeDANFCeFortes1.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

                end else begin

                  ACBrNFe1.DANFe.Protocolo:=GetProtocoloDpec(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);
                  ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );

                end;
              end;

            end;

{   // 03.06.16 - vivan pegou - imprimia duas vezes a toa...
          end else begin
              if xtiponfce='1' then begin
                ACBrNFeDANFCeFortes1.ProtocoloNFe:=GetProtocoloDpec(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);
                ACBrNFeDANFCeFortes1.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );
              end else begin
                ACBrNFe1.DANFe.ProtocoloNFe:=GetProtocoloDpec(ACBrNFe1.NotasFiscais.Items[i].NFe.Ide.nNF);
                ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe );
              end;
}
          end;

        end;
     end;

// 22.01.16
    Papel.Size:=9;   // A4
    tbPrnSetPaperSize(Papel); // Restaura o tamanho

// 06.07.11                         // 10.11.15
     if (Global.Topicos[1022]) and  (xModelo=55) then begin
       for i:=0 to ListaTrans.count-1 do begin
// 12.04.12  - Granzotto
          if ( ListaTrans.count>1 ) and ( (Global.Topicos[1398]) ) then begin
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

procedure TFGerenciaNfe.bimpnfceClick(Sender: TObject);
//////////////////////////////////////////////////////////////
begin

//  Acbrnfe1.DANFE:=ACBrNFeDANFCeFortes1;
// teste imp.em A4
//     AcbrNFe1.DANFE := TACBrNFeDANFCeFortesA4.Create(AcbrNFe1);

  ImprimeNfeNFCe( 65 );

end;

// 30.11.15
procedure TFGerenciaNfe.GridKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
/////////////////////////////////////////////////////////////////////////
begin
   if key in [vk_UP, vk_Down] then  Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='';

end;

// 30.12.15
procedure TFGerenciaNfe.ConfiguraEmailAcbr;
/////////////////////////////////////////////
begin

   Acbrmail1.from:=FGeral.getconfig1asstring('EMAILORIGEM');
   Acbrmail1.Host:=FGeral.getconfig1asstring('SMTP');
   Acbrmail1.Username:=FGeral.getconfig1asstring('USUARIOSMTP');
   Acbrmail1.Password:=FGeral.getconfig1asstring('SENHASMTP');
   Acbrmail1.Port:=inttostr(FGeral.GetConfig1AsInteger('portasmtp'));
   Acbrmail1.SetSSL  :=false;
   ACBrMail1.SetTLS := true;
   if FGeral.EmailStmpcomSSL( FGeral.GetConfig1AsString('EMAILORIGEM') ) then
     Acbrmail1.SetSSL:=true;
// 03.07.20
   ACBrMail1.UseThread:= true;

//   ACBrMail1.ReadingConfirmation := False; //Pede confirmação de leitura do email


end;

// 31.03.16
procedure TFGerenciaNfe.EdTipocadValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin
  if EdTipoCad.text='T' then  begin
    EdCliente.ShowForm:='FTransp';
    EdCliente.FindTable:='';  // 'transportadores';
    EdCliente.FindField:='tran_codigo';
//    EdCliente.FindSetField:='tran_nome';
    EdCliente.Title:='Transp.';
  end else begin
    EdCliente.ShowForm:='FCadcli';
    EdCliente.FindTable:=''; // 'clientes';
    EdCliente.FindField:='clie_codigo';
//    EdCliente.FindSetField:='clie_razaosocial';
    EdCliente.Title:='Cliente';
  end;

end;

// 31.03.16
procedure TFGerenciaNfe.EdClienteValidate(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
    if Edtipocad.text='T' then
      SetEdCLIE_NOME.text:=FTransp.Getnome(strzero(Edcliente.asinteger,3))
    else
      SetEdCLIE_NOME.text:=FCadcli.Getnome(Edcliente.asinteger);
end;

end.
