unit DIVERSOS;

interface

uses
  Windows, Messages, System.SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SqlDtg, ComCtrls, Buttons, SQLBtn, StdCtrls, alabel,
  ExtCtrls, SQLGrid,SqlExpr, Mask, SQLEd, CheckLst, ImgList, DBGrids, DB,
  //dbf,
   ACBrBase, ACBrSocket, ACBrIBGE, ACBrCNIEE, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdFTP, ACBrDownload, wininet,
  Datasnap.DBClient, SimpleDS, IdExplicitTLSClientServerBase,ShellApi,
  xmldom, XMLIntf, Xml.XMLDoc, System.ImageList, ACBrCEP ;
//  IdExplicitTLSClientServerBase;

// 13.05.13
type TCampos=record
  nome,tipo:string;
  tamanho,decimais:integer;
end;



type
  TFDiversos = class(TForm)
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    Panel1: TPanel;
    PMens: TSQLPanelGrid;
    Page: TPageControl;
    PgContabUn: TTabSheet;
    GridContabUn: TSqlDtGrid;
    EContaContab: TSQLEd;
    bAltCtaContab: TSQLBtn;
    bGravarContab: TSQLBtn;
    PgGetOperacao: TTabSheet;
    Panel2: TPanel;
    EOperacao: TSQLEd;
    PgConfUnidade: TTabSheet;
    Panel3: TPanel;
    EUnidade: TSQLEd;
    PgConfBancoDados: TTabSheet;
    Panel4: TPanel;
    EServidor: TSQLEd;
    EBancoDados: TSQLEd;
    PgGetMesAno: TTabSheet;
    Panel5: TPanel;
    EMesAno: TSQLEd;
    PgGetUnidades: TTabSheet;
    Panel6: TPanel;
    CBUnidades: TCheckListBox;
    bTodas: TSQLBtn;
    PgGetOpTrans: TTabSheet;
    Panel7: TPanel;
    EOperacao2: TSQLEd;
    ETransacao2: TSQLEd;
    Imagens: TImageList;
    PgExportaMovel: TTabSheet;
    Panel8: TPanel;
    EBaixaParcial: TSQLEd;
    PgGerRel: TTabSheet;
    Panel9: TPanel;
    LBRelatorios: TListBox;
    PgVincPendFin: TTabSheet;
    GridVinc: TSqlDtGrid;
    bConfirmar: TSQLBtn;
    PgEscolha: TTabSheet;
    Panel10: TPanel;
    LBEscolha: TListBox;
    PgContabCC: TTabSheet;
    EContaContabCC: TSQLEd;
    GridContabCC: TSqlDtGrid;
    PgGetContaGerencial: TTabSheet;
    Panel11: TPanel;
    EdContaGerencial: TSQLEd;
    PgGetDataAutPgto: TTabSheet;
    Panel12: TPanel;
    EDataAutPgto: TSQLEd;
    PgGetTransacao: TTabSheet;
    Panel13: TPanel;
    ETransacao: TSQLEd;
    PgAltDataTrans: TTabSheet;
    Panel14: TPanel;
    ETransacao3: TSQLEd;
    EDataMvto: TSQLEd;
    EDataContabil: TSQLEd;
    EDataEscritaFiscal: TSQLEd;
    PgUsuAtivos: TTabSheet;
    GridUsuAtivos: TSqlDtGrid;
    PgGetCodigoLog: TTabSheet;
    LBLogs: TCheckListBox;
    bTodos: TSQLBtn;
    PgCancDctoBco: TTabSheet;
    Panel15: TPanel;
    ENumeroOperacao: TSQLEd;
    ECodDcto: TSQLEd;
    EDescDctoBco: TSQLEd;
    EDataMvto3: TSQLEd;
    EValor3: TSQLEd;
    PgCtOper: TTabSheet;
    GridCtOper: TSqlDtGrid;
    ECtOper: TSQLEd;
    PgGetEscopo: TTabSheet;
    Panel16: TPanel;
    ECodDpto: TSqlEd;
    EDescrDpto: TSqlEd;
    EGrupo: TSqlEd;
    EMarca: TSqlEd;
    ESetor: TSqlEd;
    ESetorDep: TSqlEd;
    EClasse: TSqlEd;
    ETipo: TSqlEd;
    EFornec: TSqlEd;
    EAtivos: TSqlEd;
    PgHistorico: TTabSheet;
    EContaHist: TSQLEd;
    EDescrCtaHist: TSQLEd;
    ECodHist: TSQLEd;
    EComplemento: TSQLEd;
    EDataIHist: TSQLEd;
    EDataFHist: TSQLEd;
    PgBaixaPendEst: TTabSheet;
    GridBxPendEst: TSqlDtGrid;
    EdNomeBanco: TSQLEd;
    PgImportaEstoque: TTabSheet;
    QualDbf: TOpenDialog;
    EdArquivodbf: TSQLEd;
    bqualdbf: TSQLBtn;
    Tabela: TSimpleDataSet;
    EdArquivotexto: TSQLEd;
    bqualtexto: TSQLBtn;
    QualTexto: TOpenDialog;
    EdNumerosaFrente: TSQLEd;
    Edsobrepoe: TSQLEd;
    EdInclusos: TSQLEd;
    Edalterados: TSQLEd;
    PgImpressoraPadrao: TTabSheet;
    Edimpressorapadrao: TSQLEd;
    ACBrIBGE1: TACBrIBGE;
    ACBrCNIEE1: TACBrCNIEE;
    EdFiltro: TSQLEd;
    btexportar: TSQLBtn;
    bimportar: TSQLBtn;
    EdData: TSQLEd;
    EdCodcliente: TSQLEd;
    chuftp: TIdFTP;
////    ftpacbr: TACBrDownload;
    cblocal: TCheckBox;
    EdTablet: TSQLEd;
    Memo1: TMemo;
    XMLDocument1: TXMLDocument;
    ACBrCEP1: TACBrCEP;
    Texto: TMemo;
    procedure bSairClick(Sender: TObject);
    procedure bAltCtaContabClick(Sender: TObject);
    procedure EContaContabExit(Sender: TObject);
    procedure EContaContabExitEdit(Sender: TObject);
    procedure bGravarContabClick(Sender: TObject);
    procedure EContaContabValidate(Sender: TObject);
    procedure EServidorExitEdit(Sender: TObject);
    procedure EMesAnoValidate(Sender: TObject);
    procedure bTodasClick(Sender: TObject);
    procedure CBUnidadesKeyPress(Sender: TObject; var Key: Char);
    procedure EOperacao2Validate(Sender: TObject);
    procedure LBRelatoriosKeyPress(Sender: TObject; var Key: Char);
    procedure GridVincKeyPress(Sender: TObject; var Key: Char);
    procedure bConfirmarClick(Sender: TObject);
    procedure LBEscolhaKeyPress(Sender: TObject; var Key: Char);
    procedure EContaContabCCExit(Sender: TObject);
    procedure EContaContabCCExitEdit(Sender: TObject);
    procedure EContaContabCCValidate(Sender: TObject);
    procedure ETransacao2KeyPress(Sender: TObject; var Key: Char);
    procedure ETransacao3Validate(Sender: TObject);
    procedure EDataMvtoValidate(Sender: TObject);
    procedure EDataContabilValidate(Sender: TObject);
    procedure EDataEscritaFiscalValidate(Sender: TObject);
    procedure EDataMvtoExitEdit(Sender: TObject);
    procedure bTodosClick(Sender: TObject);
    procedure ENumeroOperacaoValidate(Sender: TObject);
    procedure GridCtOperKeyPress(Sender: TObject; var Key: Char);
    procedure ECtOperExit(Sender: TObject);
    procedure ECtOperKeyPress(Sender: TObject; var Key: Char);
    procedure ECtOperExitEdit(Sender: TObject);
    procedure EAtivosExitEdit(Sender: TObject);
    procedure EContaHistValidate(Sender: TObject);
    procedure EComplementoEnter(Sender: TObject);
    procedure EDataFHistExitEdit(Sender: TObject);
    procedure GridBxPendEstKeyPress(Sender: TObject; var Key: Char);
    procedure bqualdbfClick(Sender: TObject);
    procedure bqualtextoClick(Sender: TObject);
    procedure ACBrIBGE1BuscaEfetuada(Sender: TObject);
    procedure EdFiltroExitEdit(Sender: TObject);
    procedure btexportarClick(Sender: TObject);
    procedure bimportarClick(Sender: TObject);
    procedure ftpacbrHookMonitor(Sender: TObject; const BytesToDownload,
      BytesDownloaded: Integer; const AverageSpeed: Double; const Hour,
      Min, Sec: Word);
    procedure ftpacbrBeforeDownload(Sender: TObject);
    procedure chuftpWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure chuftpWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure chuftpAfterClientLogin(Sender: TObject);
    procedure chuftpAfterGet(ASender: TObject; VStream: TStream);
  private
//    procedure ExpCadastroMovel(xCadastro: String);
    { Private declarations }
  public
    { Public declarations }
    procedure ConfUnidade;
    function ConfBancoDeDados:Boolean;
    procedure GetContabUn(ContaGer:Integer);
    procedure GetContabCC(ContaGer:Integer);
    function GetOperacao(Tit:String):String;
    function GetTransacao(Tit:String):String;
    procedure ExpCadastroMovelPortadores;
    procedure ExpCadastroMovelClientes;
    procedure ExpCadastroMovelEstoque;
    function GetOperacaoTransacao:String;
    function GetMesAno(Data:TDateTime):String;
    function GetUnidades(UnidadesValidas:String):String;
    function GetGerRel(Lista:TStringList):String;
    function GetVincPendFin(Op,Conta,Cat,Nome:String;Codigo:Integer):String;
    function GetEscolha(Lista:TStringList;Titulo,StrItemIndex:String):String;
    function GetContaGerencial:Integer;
    function GetDataAutPgto(var Data:TDateTime;var Desmarcando:Boolean):Boolean;
    procedure AlterarDatasTransacao;
    procedure UsuariosAtivos;
    function GetCodigosLog:String;
    procedure CancelarDctoBco;
    procedure CtOperacional;
    function GetEscopo:Boolean;
    procedure AltHistoricos;
    function GetPendEstBaixar(Codigos,Unidade,CatEnt:String;CodEnt:Integer):Boolean;
    procedure ImportaEstoqueDbf;
// 15.04.09
    procedure ImportaEstoqueTexto;
// 19.08.09
    procedure RenumeraNotasSaidaPeriodo;
// 23.02.10
    procedure ImportaPlanoTexto;
// 26.04.11
    procedure CriaCodigoBarra;
// 25.08.11 - Vivan
    procedure ImportaClientesTexto;
// 05.12.11 - Abra - Terminal Server
    procedure ConfImpressoraPadrao;
// 13.05.13
    procedure TransacoesDuplicadas;
    procedure GetEstruturaTabela( xtabela:string; Cpo:Pointer );
// 19.06.13
    procedure ImportaAReceberTexto;
// 13.11.14
    procedure ImpPedidosMovel;
// 27.11.15
    procedure ImportaContagemTexto;
// 19.03.16
    procedure ImportaFireBird;
// 05.01.17
    procedure importapedidosmovel(smens:string='N');
// 27.08.18 - importa xml de estoque do 'sage'
    procedure ImportaXml;
    var mostramens:string;
// 08.06.2021
    procedure ImportaPedidos(xdata:TDatetime ; viapedidos:string='N'; PMens:TPanel=nil );
// 11.08.2021
// 13.05.13
    procedure TransacaoDuplicada( xtabela,cchave1,cchave2:string );

  end;

var
  FDiversos: TFDiversos;
  Cadastro: string;
  ftp:TIdftp;

implementation

uses Plano, Unidades,SqlFun,SqlSis,Geral, Arquiv, MenuINicial, Hist,  Estoque,
  cadcli, grupos, Pedvenda, conpagto, fornece, munic;

{$R *.dfm}

var wRet:Boolean;
    PCampos:^TCampos;
    ListaCampos:TList;
///    Ftp:TIdftp;

procedure TFDiversos.GetContabUn(ContaGer:Integer);
/////////////////////////////////////////////
var Lista:TStringList;
    i,u:Integer;
    Q:TSqlQuery;
    ContaContab:Array[0..999] of String;
    CtaContab,Cod:String;
begin
  Width:=461;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgContabUn;
  ActiveControl:=GridContabUn;
  PMens.Caption:='Conta cont�bil para a unidade selecionada';
  bAltCtaContab.Visible:=True;bAltCtaContab.Top:=bSair.Top+25;
  bGravarContab.Visible:=True;bGravarContab.Top:=bAltCtaContab.Top+25;
  Caption:='Contabiliza��o Por Unidade / '+IntToStr(ContaGer)+' - '+FPlano.GetDescricao(ContaGer);
  Q:=SqlToQuery('SELECT * FROM ContabUn WHERE Cbun_Pger_Conta='+IntToStr(ContaGer));
  while not Q.Eof do begin
    ContaContab[Inteiro(Q.FieldByName('Cbun_Unid_Codigo').AsString)]:=IntToStr(Q.FieldByName('Cbun_Pcon_Conta').AsInteger);
    Q.Next;
  end;
  Q.Close;Q.Free;
  Lista:=TStringList.Create;
  FUnidades.GetListaUnidades(Lista);
  GridContabUn.RowCount:=Lista.Count+1;
  for i:=0 to Lista.Count-1 do begin
      u:=Inteiro(LeftStr(Lista[i],3));
      GridContabUn.Cells[0,i+1]:=StrZero(u,3);
      GridContabUn.Cells[1,i+1]:=FinalStr(Lista[i],7);
      GridContabUn.Cells[2,i+1]:=ContaContab[u];
  end;
  Lista.Free;
  wRet:=False;
  GridContabUn.Row:=1;
  ShowModal;
  bAltCtaContab.Visible:=False;
  bGravarContab.Visible:=False;
  if wRet then begin
     ExecuteSql('DELETE FROM ContabUn WHERE Cbun_Pger_Conta='+IntToStr(ContaGer));
     for i:=1 to GridContabUn.RowCount-1 do begin
         Cod:=StrToStrNumeros(GridContabUn.Cells[0,i]);
         CtaContab:=Trim(GridContabUn.Cells[2,i]);
         if CtaContab<>'' then ExecuteSql('INSERT INTO ContabUn (Cbun_Pger_Conta,Cbun_Unid_Codigo,Cbun_Pcon_Conta) VALUES('+IntToStr(ContaGer)+','+StringToSql(Cod)+','+CtaContab+')');
      end;
     Sistema.Commit;
  end;
end;

procedure TFDiversos.bSairClick(Sender: TObject);
begin
  wRet:=False;
  Close;
end;

procedure TFDiversos.bAltCtaContabClick(Sender: TObject);
begin
  if Page.ActivePage=PgContabUn then begin
     EContaContab.Top:=GridContabUn.TopEdit;
     EContaContab.Visible:=True;
     EContaContab.SetValue(Inteiro(GridContabUn.Cells[2,GridContabUn.Row]));
     EContaContab.SetFocus;
  end;
  if Page.ActivePage=PgContabCC then begin
     EContaContabCC.Top:=GridContabCC.TopEdit;
     EContaContabCC.Visible:=True;
     EContaContabCC.SetValue(Inteiro(GridContabCC.Cells[2,GridContabCC.Row]));
     EContaContabCC.SetFocus;
  end;
end;

procedure TFDiversos.EContaContabExit(Sender: TObject);
begin
  EContaContab.Visible:=False;
end;

procedure TFDiversos.EContaContabExitEdit(Sender: TObject);
begin
  if EContaContab.AsInteger>0 then begin
     GridContabUn.Cells[2,GridContabUn.Row]:=EContaContab.Text;
  end else begin
     GridContabUn.Cells[2,GridContabUn.Row]:='';
  end;
  GridContabUn.SetFocus;
end;

procedure TFDiversos.bGravarContabClick(Sender: TObject);
begin
  wRet:=True;
  Close;
end;

procedure TFDiversos.EContaContabValidate(Sender: TObject);
var Q:TSqlQuery;
    Un:String;
begin
  if EContaContab.AsInteger=0 then Exit;
  Un:=FUnidades.GetEmpresa(GridContabUn.Cells[0,GridContabUn.Row]);
  Q:=SqlToQuery('SELECT Pcon_Tipo FROM PlanoCon WHERE Pcon_Conta='+IntToStr(EContaContab.AsInteger)+' AND Pcon_Empr_Codigo='+StringToSql(Un));
  if (Q.isEmpty) or (Q.FieldByName('Pcon_Tipo').AsString='SS') then begin
     EContaContab.Invalid('Conta cont�bil inv�lida');
  end;
  Q.Close;Q.Free;
end;

function TFDiversos.GetOperacao(Tit:String):String;
begin
  Caption:='N�mero Da Opera��o / '+Tit;
  Width:=396;Height:=105;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgGetOperacao;
  ActiveControl:=EOperacao;
  EOperacao.Clear;
  ShowModal;
  Result:=Trim(EOperacao.Text);
end;

function TFDiversos.GetTransacao(Tit:String):String;
begin
  Caption:='N�mero Da Transa��o / '+Tit;
  Width:=396;Height:=105;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgGetTransacao;
  ActiveControl:=ETransacao;
  ETransacao.Clear;
  ShowModal;
  Result:=Trim(ETransacao.Text);
end;

function TFDiversos.GetGerRel(Lista:TStringList):String;
var l:Integer;
begin
  Result:='';
  Caption:='Sele��o Do Relat�rio';
  Width:=300;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgGerRel;
  ActiveControl:=LBRelatorios;
  LBRelatorios.Items.Clear;
  Lista.Sort;
  for l:=0 to Lista.Count-1 do LBRelatorios.Items.Add(Lista[l]);
  if LBRelatorios.Items.Count>0 then LBRelatorios.ItemIndex:=0;
  wRet:=False;
  ShowModal;
  if wRet then Result:=Trim(LBRelatorios.Items[LBRelatorios.ItemIndex]);
end;



function TFDiversos.GetOperacaoTransacao:String;
////////////////////////////////////////////////////
begin
  Caption:='N�mero Da Opera��o/Transa��o';
  Width:=396;Height:=125;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgGetOpTrans;
  ActiveControl:=EOperacao2;
  EOperacao2.Clear;
  ETransacao2.Clear;
  ShowModal;
  Result:='';
  if not EOperacao2.IsEmpty then Result:='O'+Trim(EOperacao2.Text)
  else if not ETransacao2.IsEmpty then Result:='T'+Trim(ETransacao2.Text);
end;

function TFDiversos.GetUnidades(UnidadesValidas:String):String;
var i:integer;
begin
  if not Arq.TUnidades.Active then Arq.TUnidades.Open;
  PMens.Caption:='Pressione "ENTER" para confirmar unidades';
  bTodas.Visible:=True;bTodas.Top:=bSair.Top+25;
  Caption:='Sele��o Da(s) Unidade(s)';
  Width:=300;Height:=380;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgGetUnidades;
  ActiveControl:=CBUnidades;
  CBUnidades.Items.Clear;
  for i:=1 to 999 do begin
      if Global.ReduzidoUnidades[i]<>'' then begin
         if (UnidadesValidas='') or (Pos(StrZero(i,3),UnidadesValidas)>0) then begin
            CBUnidades.Items.Add(StrZero(i,3)+' - '+Global.ReduzidoUnidades[i]);
         end;
      end;
  end;
  for i:=0 to CBUnidades.Items.Count-1 do CBUnidades.Checked[i]:=False;
  if CBUnidades.Items.Count>0 then CBUnidades.ItemIndex:=0;
  wRet:=True;
  ShowModal;
  Result:='';
  if wRet then begin
     for i:=0 to CBUnidades.Items.Count-1 do if CBUnidades.Checked[i] then Result:=Result+LeftStr(CBUnidades.Items[i],3)+';';
     if Length(Result)>0 then Result:=LeftStr(Result,Length(Result)-1);
  end;
  bTodas.Visible:=False;
end;


function TFDiversos.GetMesAno(Data:TDateTime):String;
begin
  Caption:='Informar M�s e Ano';
  Width:=278;Height:=105;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgGetMesAno;
  ActiveControl:=EMesAno;
  EMesAno.Clear;
  if Data>0 then EMesAno.Text:=StrZero(DateToDia(Data),2)+IntToStr(DateToAno(Data,True));
  wRet:=True;
  ShowModal;
  if wRet then Result:=Trim(EMesAno.Text);
end;

function TFDiversos.GetDataAutPgto(var Data:TDateTime;var Desmarcando:Boolean):Boolean;
begin
  Caption:='Data Para Pagamento';
  Width:=378;Height:=105;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgGetDataAutPgto;
  ActiveControl:=EDataAutPgto;
  EDataAutPgto.Text:=DateToText(Data);
  wRet:=True;
  Result:=False;
  Desmarcando:=False;
  ShowModal;
  if not EDataAutPgto.IsEmpty then begin
     if wRet then Result:=EDataAutPgto.Valid;
     if Result then Data:=EDataAutPgto.AsDate;
  end else begin
      Result:=True;
      Desmarcando:=True;
  end;
  Application.ProcessMessages;
end;

procedure TFDiversos.ConfUnidade;

// 07.05.07 - para nao ter q sair do sistema;;;
/////////////////////////////////////////////////////////
    procedure InicializaCodigoUnidade;
    var ipbase:string;
        Q:TSqlquery;
    begin
      Global.CodigoUnidade:=GetIni('SACD','Config','CodigoUnidade');
      if not Arq.TUnidades.Active then Arq.TUnidades.Open;
      ipbase:=' - '+Sistema.sqlserver;
//      if not Arq.TUnidades.Locate('Unid_Codigo',Global.CodigoUnidade,[]) then begin
// 17.07.07
      Q:=sqltoquery('select * from unidades where unid_codigo='+stringtosql(Global.CodigoUnidade));
      if Q.eof then begin
         AvisoErro('Aten��o, unidade da esta��o de trabalho;n�o cadastrada');
         Global.CodigoUnidade:='000';
         FMain.PUnidade.Caption:=Global.CodigoUnidade+' - N�o Cadastrada'+ipbase;
      end else begin
         Global.NomeUnidade:=q.FieldByName('Unid_Nome').AsString;
//         FUnidades.GetNome(Global.CodigoUnidade);
         Global.ReduzidoUnidade:= Arq.TUnidades.FieldByName('Unid_Reduzido').AsString;
//         FUnidades.GetReduzido(Global.CodigoUnidade);
         Global.UFUnidade:=Q.FieldByName('Unid_UF').AsString;
//         FUnidades.GetUF(Global.CodigoUnidade);
         FMain.PUnidade.Caption:=Global.CodigoUnidade+' - '+Global.NomeUnidade+ipbase;
         Global.SerieUnidade:=Q.FieldByName('Unid_Serie').AsString;
//         FUnidades.GetSerie(Global.CodigoUnidade);
      end;
      FGEral.FechaQuery(Q);
      Arq.TUnidades.BeginProcess;
      Arq.TUnidades.First;
      while not Arq.TUnidades.Eof do begin
        Global.ReduzidoUnidades[Inteiro(Arq.TUnidades.FieldByName('Unid_Codigo').AsString)]:=Trim(Arq.TUnidades.FieldByName('Unid_Reduzido').AsString);
        Global.EmpresaUnidades[Inteiro(Arq.TUnidades.FieldByName('Unid_Codigo').AsString)]:=Trim(Arq.TUnidades.FieldByName('Unid_Empr_Codigo').AsString);
        Arq.TUnidades.Next;
      end;
      Arq.TUnidades.EndProcess;
    end;


begin
  Caption:='Configura��o Da Unidade';
//  Width:=396;Height:=105;
  Width:=396;Height:=135;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgConfUnidade;
  ActiveControl:=EUnidade;
  EUnidade.Text:=Trim(Global.CodigoUnidade);
  wRet:=True;
  ShowModal;
  if wRet then begin
     if not Arq.TUnidades.Active then Arq.TUnidades.Open;
     if not Arq.TUnidades.Locate('Unid_Codigo',EUnidade.Text,[]) then begin
        AvisoErro('Unidade n�o cadastrada');
     end else begin
         if pos( EUnidade.Text,Global.Usuario.UnidadesMvto )=0 then begin
           Avisoerro('Usu�rio sem permiss�o para acessar unidade '+EUnidade.Text);
           close;
           exit;
         end;
        if (not EUnidade.isEmpty) and (Confirma('Confirma a configura��o da unidade')) then begin
           SetIni('SACD','Config','CodigoUnidade',StrZero(Inteiro(EUnidade.Text),3));
           InicializaCodigoUnidade;
           Aviso('Unidade configurada');
           Close;
           if Global.topicos[1025] then begin
              Aviso('Ser� encerrado a execu��o do sistema para filtrar o estoque');
              Sistema.Finalizando:=True;
              Application.Terminate;
           end;
// 01.10.05
//           Sistema.Finalizando:=false;
//           Application.Run;
//           Application.Initialize;

        end;
     end;
  end;
end;

function TFDiversos.ConfBancoDeDados:Boolean;
begin
  EBancoDados.Clear;
  EServidor.Clear;
  EdNomeBanco.clear;
  EBancoDados.Text:=Trim(GetIni('SACD','Config','BancoDados'));
  EServidor.Text:=Trim(GetIni('SACD','Config','EnderecoServidor'));
  EdNOmeBanco.Text:=Trim(GetIni('SACD','Config','NomeBanco'));
  Caption:='Configura��o Do Bando De Dados';
  Width:=480;Height:=160; // 120
  Position:=poMainFormCenter;
  Page.ActivePage:=PgConfBancoDados;
  ActiveControl:=EBancoDados;
  wRet:=False;
  ShowModal;
  if wRet then begin
     if Confirma('Confirma a configura��o do banco de dados') then begin
        if ( Trim(GetIni('SACD','Config','BancoDados'))='' ) or
           ( Trim(GetIni('SACD','Config','NomeBanco'))=''  ) then begin
           SetIni('SACD','Config','BancoDados',EBancoDados.Text);
           SetIni('SACD','Config','EnderecoServidor',EServidor.Text);
           SetIni('SACD','Config','NomeBanco',EdNomeBanco.Text);
        end;
        Aviso('Banco de dados configurado');
     end else begin
        wRet:=False;
     end;
  end;
  Result:=wRet;
end;

procedure TFDiversos.EServidorExitEdit(Sender: TObject);
begin
  wRet:=True;
  Close;
end;

procedure TFDiversos.EMesAnoValidate(Sender: TObject);
var Mes,Ano:Integer;
begin
  if not EMesAno.isEmpty then begin
     Mes:=Inteiro(LeftStr(EMesAno.Text,2));
     Ano:=Inteiro(FinalStr(EMesAno.Text,3));
     if (Mes<1) or (Mes>12) or (Ano=0) then begin
        EMesAno.Invalid('M�s/Ano inv�lido');
     end;
  end;
end;

procedure TFDiversos.bTodasClick(Sender: TObject);
var i:Integer;
begin
  for i:=0 to CBUnidades.Items.Count-1 do CBUnidades.Checked[i]:=True;
  wRet:=True;
  Close;
end;

procedure TFDiversos.CBUnidadesKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then begin
     CBUnidades.Checked[CBUnidades.ItemIndex]:=True;
     wRet:=True;
     Close;
  end;
end;

procedure TFDiversos.EOperacao2Validate(Sender: TObject);
begin
  if not EOperacao2.IsEmpty then Close;
end;


procedure TFDiversos.LBRelatoriosKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then begin
     wRet:=True;
     Close;
  end;
end;


function TFDiversos.GetVincPendFin(Op,Conta,Cat,Nome:String;Codigo:Integer):String;
var l:Integer;
    Tipo,PR,w,ov:String;
    Q:TSqlQuery;
begin
  Result:='F';
  Tipo:=FPlano.GetTipo(Inteiro(Conta));
  if Tipo='CP' then begin
     Caption:='Vincula��es De Contas a Receber / '+Nome;
     PR:='R';
  end else begin
     Caption:='Vincula��es De Contas a Pagar / '+Nome;
     PR:='P';
  end;
  GridVinc.Clear;
  w:=' WHERE Pfin_CodEntidade='+IntToStr(Codigo);
  w:=w+' AND '+FGeral.GetIN('Pfin_Status','P,G','C');
  w:=w+' AND Pfin_CatEntidade='+StringToSql(Cat);
  w:=w+' AND Pfin_PR='+StringToSql(PR);
  Q:=SqlToQuery('SELECT Pfin_Operacao,Pfin_DataVcto,Pfin_DataEmissao,Pfin_Valor,Pfin_Pger_Conta FROM PendFin '+w+' ORDER BY Pfin_DataVcto');
  if Q.IsEmpty then begin
     Aviso('Nenhuma pend�ncia localizada para vincula��o');
     Q.Close;Q.Free;
     Exit;
  end;
  GridVinc.Clear;
  GridVinc.QueryToGrid(Q);
  Q.Close;Q.Free;
  for l:=1 to GridVinc.RowCount-1 do GridVinc.Cells[3,l]:=FPlano.GetDescricao(Inteiro(GridVinc.Cells[2,l]));
  Q:=SqlToQuery('SELECT * FROM VincPendFin WHERE Vinc_Operacao='+StringToSql(Op)+' AND Vinc_Status='+StringToSql('N'));
  while not Q.Eof do begin
    ov:=Q.FieldByName('Vinc_OpVinculada').AsString;
    for l:=1 to GridVinc.RowCount-1 do if GridVinc.Cells[1,l]=ov then GridVinc.Cells[0,l]:='Sim';
    Q.Next;
  end;
  Q.Close;Q.Free;
  bConfirmar.Visible:=True;
  Width:=779;Height:=323;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgVincPendFin;
  ActiveControl:=GridVinc;
  wRet:=False;
  PMens.Caption:='Pressione "ENTER" para marcar/desmarcar vincula��es';
  ShowModal;
  if wRet then begin
     Result:='';
     for l:=1 to GridVinc.RowCount-1 do begin
         if Trim(GridVinc.Cells[0,l])<>'' then Result:=Result+Trim(GridVinc.Cells[1,l])+';';
     end;
  end;
  PMens.Caption:='';
  bConfirmar.Visible:=False;
end;


procedure TFDiversos.GridVincKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then begin
     if Trim(GridVinc.Cells[0,GridVinc.Row])='' then GridVinc.Cells[0,GridVinc.Row]:='Sim' else GridVinc.Cells[0,GridVinc.Row]:='';
  end;
end;

procedure TFDiversos.bConfirmarClick(Sender: TObject);
begin
  wRet:=True;
  Close;
end;

procedure TFDiversos.LBEscolhaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then begin
     Close;
     wRet:=True;
  end;
end;


function TFDiversos.GetEscolha(Lista:TStringList;Titulo,StrItemIndex:String):String;
var i,Maior:Integer;
begin
  Result:='';
  if Lista.Count=0 then Exit;
  Caption:=Titulo;
  Maior:=0;
  for i:=0 to Lista.Count-1 do if Length(Lista[i])>Maior then Maior:=Length(Lista[i]);
  Width:=100+(Maior*10);Height:=350;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgEscolha;
  ActiveControl:=LBEscolha;
  LBEscolha.Items.Assign(Lista);
  LBEscolha.ItemIndex:=0;
  for i:=0 to LBEscolha.Items.Count-1 do if LBEscolha.Items[i]=StrItemIndex then LBEscolha.ItemIndex:=i;
  wRet:=False;
  ShowModal;
  if wRet then Result:=LBEscolha.Items[LBEscolha.ItemIndex];
end;


procedure TFDiversos.GetContabCC(ContaGer:Integer);
var l,i:Integer;
    Q:TSqlQuery;
    CtaContab,Cod:String;

    procedure InicializaGrid;
    var l,c:Integer;
        Cod:String;
    begin
      for l:=1 to GridContabCC.RowCount-1 do GridContabCC.Cells[2,l]:='';
      GridContabCC.Row:=1;
      if GridContabCC.Tag=1 then Exit;
      GridContabCC.Tag:=1;
      for l:=1 to GridContabCC.RowCount-1 do for c:=0 to GridContabCC.ColCount-1 do GridContabCC.Cells[c,l]:='';
      GridContabCC.RowCount:=2;
      if not Arq.TCCustos.Active then Arq.TCCustos.Open;
      Arq.TCCustos.BeginProcess;
      Arq.TCCustos.First;
      l:=0;
      while not Arq.TCCustos.Eof do begin
        Cod:=Trim(Arq.TCCustos.FieldByName('Ccst_Codigo').AsString);
        Inc(l);
        if GridContabCC.RowCount-1<l then GridContabCC.RowCount:=GridContabCC.RowCount+1;
//        GridContabCC.Cells[0,l]:=FCCustos.FormataCodigo(Cod);
//        GridContabCC.Cells[1,l]:=FCCustos.FormataDescricao(Cod,Arq.TCCustos.FieldByName('Ccst_Descricao').AsString);
        Arq.TCCustos.Next;
      end;
      Arq.TCCustos.EndProcess;
    end;

begin
  Width:=585;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgContabCC;
  ActiveControl:=GridContabCC;
  PMens.Caption:='Conta cont�bil para o centro de custos selecionado';
  bAltCtaContab.Visible:=True;bAltCtaContab.Top:=bSair.Top+25;
  bGravarContab.Visible:=True;bGravarContab.Top:=bAltCtaContab.Top+25;
  Caption:='Contabiliza��o Por Centro De Custos / '+IntToStr(ContaGer)+' - '+FPlano.GetDescricao(ContaGer);
  InicializaGrid;
  Q:=SqlToQuery('SELECT * FROM ContabCC WHERE Cbcc_Pger_Conta='+IntToStr(ContaGer));
  while not Q.Eof do begin
    Cod:=Trim(Q.FieldByName('Cbcc_Ccst_Codigo').AsString);
    for l:=1 to GridContabCC.RowCount-1 do begin
        if StrToStrNumeros(GridContabCC.Cells[0,l])=Cod then begin
           GridContabCC.Cells[2,l]:=IntToStr(Q.FieldByName('Cbcc_Pcon_Conta').AsInteger);
        end;
    end;
    Q.Next;
  end;
  Q.Close;Q.Free;
  wRet:=False;
  ShowModal;
  bAltCtaContab.Visible:=False;
  bGravarContab.Visible:=False;
  if wRet then begin
     ExecuteSql('DELETE FROM ContabCC WHERE Cbcc_Pger_Conta='+IntToStr(ContaGer));
     for i:=1 to GridContabCC.RowCount-1 do begin
         Cod:=StrToStrNumeros(GridContabCC.Cells[0,i]);
         CtaContab:=Trim(GridContabCC.Cells[2,i]);
         if CtaContab<>'' then ExecuteSql('INSERT INTO ContabCC (Cbcc_Pger_Conta,Cbcc_Ccst_Codigo,Cbcc_Pcon_Conta) VALUES('+IntToStr(ContaGer)+','+StringToSql(Cod)+','+CtaContab+')');
      end;
     Sistema.Commit;
  end;
end;



procedure TFDiversos.EContaContabCCExit(Sender: TObject);
begin
  EContaContabCC.Visible:=False;
end;

procedure TFDiversos.EContaContabCCExitEdit(Sender: TObject);
begin
  if EContaContabCC.AsInteger>0 then begin
     GridContabCC.Cells[2,GridContabCC.Row]:=EContaContabCC.Text;
  end else begin
     GridContabCC.Cells[2,GridContabCC.Row]:='';
  end;
  GridContabCC.SetFocus;
end;

procedure TFDiversos.EContaContabCCValidate(Sender: TObject);
var Q:TSqlQuery;
    Emp:String;
begin
  if EContaContabCC.AsInteger=0 then Exit;
  Emp:=LeftStr(GridContabCC.Cells[0,GridContabCC.Row],2);
  Q:=SqlToQuery('SELECT Pcon_Tipo FROM PlanoCon WHERE Pcon_Conta='+IntToStr(EContaContabCC.AsInteger)+' AND Pcon_Empr_Codigo='+StringToSql(Emp));
  if (Q.isEmpty) or (Q.FieldByName('Pcon_Tipo').AsString='SS') then begin
     EContaContabCC.Invalid('Conta cont�bil inv�lida');
  end;
  Q.Close;Q.Free;
end;

procedure TFDiversos.ETransacao2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#32 then begin
     ETransacao2.Text:=Global.UltimaTransacao;
     Key:=#0;
  end;   
end;


function TFDiversos.GetContaGerencial:Integer;
begin
  Caption:='Conta Gerencial';
  Width:=350;Height:=105;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgGetContaGerencial;
  ActiveControl:=EdContaGerencial;
  EdContaGerencial.Clear;
  ShowModal;
  Result:=EdContaGerencial.AsInteger;
end;


procedure TFDiversos.AlterarDatasTransacao;
begin
  Caption:='Altera��o De Datas De Transa��o';
  Width:=357;Height:=175;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgAltDataTrans;
  ActiveControl:=ETransacao3;
  EDataContabil.Clear;EDataContabil.Enabled:=False;
  EDataEscritaFiscal.Clear;EDataEscritaFiscal.Enabled:=False;
  EDataMvto.Clear;ETransacao3.Clear;
  ShowModal;
end;


procedure TFDiversos.ETransacao3Validate(Sender: TObject);
var Q:TSqlQuery;
    T:String;
begin
  EDataContabil.Clear;EDataContabil.Enabled:=False;
  EDataEscritaFiscal.Clear;EDataEscritaFiscal.Enabled:=False;
  EDataMvto.Clear;
  T:=StringToSql(Trim(ETransacao3.Text));
  Q:=SqlToQuery('SELECT * FROM MovGer WHERE Mger_Transacao='+T+' AND Mger_Status<>'+StringToSql('C'));
  if not Q.IsEmpty then EDataMvto.Text:=DateToText(Q.FieldByName('Mger_DataMvto').AsDateTime);
  Q.Close;Q.Free;
  Q:=SqlToQuery('SELECT * FROM MovCon WHERE Mcon_Transacao='+T+' AND Mcon_Status<>'+StringToSql('C'));
  if not Q.IsEmpty then begin
     EDataContabil.Text:=DateToText(Q.FieldByName('Mcon_DataMvto').AsDateTime);
     if EDataMvto.IsEmpty then EDataMvto.Text:=EDataContabil.Text;
     EDataContabil.Enabled:=True;
  end;
  Q.Close;Q.Free;
  Q:=SqlToQuery('SELECT * FROM MovFiscal WHERE Mfis_Transacao='+T+' AND Mfis_Status<>'+StringToSql('C'));
  if not Q.IsEmpty then begin
     EDataEscritaFiscal.Text:=DateToText(Q.FieldByName('Mfis_DtFiscal').AsDateTime);
     if EDataMvto.IsEmpty then EDataMvto.Text:=EDataEscritaFiscal.Text;
     EDataEscritaFiscal.Enabled:=True;
  end;
  Q.Close;Q.Free;
  if EDataMvto.IsEmpty then begin
     ETransacao3.Invalid('Transa��o n�o localizada');
     Exit;
  end;
  if (EDataMvto.AsDate<FGeral.GetConfig1AsDate('DataInicialMvto')) or (EDataMvto.AsDate>FGeral.GetConfig1AsDate('DataFinalMvto')) then begin
     ETransacao3.Invalid('Data de movimento fora do per�odo configurado');
     Exit;
  end;
  if (not EDataContabil.isEmpty) and (EDataContabil.AsDate<FGeral.GetConfig1AsDate('DataInicialContabil')) or (EDataMvto.AsDate>FGeral.GetConfig1AsDate('DataFinalContabil')) then begin
     ETransacao3.Invalid('Data de cont�bil fora do per�odo configurado');
     Exit;
  end;
  if (not EDataEscritaFiscal.isEmpty) and (EDataEscritaFiscal.AsDate<FGeral.GetConfig1AsDate('DataInicialEscrita')) or (EDataMvto.AsDate>FGeral.GetConfig1AsDate('DataFinalEscrita')) then begin
     ETransacao3.Invalid('Data da escrita fiscal fora do per�odo configurado');
     Exit;
  end;
end;

procedure TFDiversos.EDataMvtoValidate(Sender: TObject);
begin
  FGeral.ValidaMvto(TSqlEd(Sender));
end;

procedure TFDiversos.EDataContabilValidate(Sender: TObject);
begin
  FGeral.ValidaDataContabil(TSqlEd(Sender));
end;

procedure TFDiversos.EDataEscritaFiscalValidate(Sender: TObject);
begin
  FGeral.ValidaDataFiscal(TSqlEd(Sender));
end;

procedure TFDiversos.EDataMvtoExitEdit(Sender: TObject);

    procedure AlteraDatasTransacao(Transacao:String;DataMvto,DataContabil,DataEscritaFiscal:TDateTime);
    var T:String;
    begin
      Sistema.BeginProcess('alterando data(s) da transa��o');
      T:=StringToSql(Transacao);
      if DataContabil>0 then begin
         Sistema.Edit('MovCon');
         Sistema.SetField('Mcon_DataMvto',DataContabil);
         Sistema.Post('Mcon_Transacao='+T);
      end;
      if DataEscritaFiscal>0 then begin
         Sistema.Edit('MovFiscal');
         Sistema.SetField('Mfis_DtFiscal',DataEscritaFiscal);
         Sistema.Post('Mfis_Transacao='+T);
      end;
      Sistema.Edit('MovGer');Sistema.SetField('Mger_DataMvto',DataMvto);Sistema.Post('Mger_Transacao='+T);
      Sistema.Edit('MovRatGer');Sistema.SetField('Mrtg_DataMvto',DataMvto);Sistema.Post('Mrtg_Transacao='+T+' AND Mrtg_Parcela=1');
      Sistema.Edit('MovDctos');Sistema.SetField('Mdoc_DataMvto',DataMvto);Sistema.Post('Mdoc_Transacao='+T);
      Sistema.Edit('MovBco');Sistema.SetField('Mbco_DataMvto',DataMvto);Sistema.Post('Mbco_Transacao='+T);
      Sistema.Edit('PendFin');Sistema.SetField('Pfin_DataMvto',DataMvto);Sistema.Post('Pfin_Transacao='+T);
      Sistema.Edit('BxParcial');Sistema.SetField('Bxpa_DataMvto',DataMvto);Sistema.Post('Bxpa_Transacao='+T);
      Sistema.Edit('MovFPDVC');Sistema.SetField('Mpdc_DataMvto',DataMvto);Sistema.Post('Mpdc_Transacao='+T);
      Sistema.Edit('MovFPDVD');Sistema.SetField('Mpdd_DataMvto',DataMvto);Sistema.Post('Mpdd_Transacao='+T);
      Sistema.Commit;
      Sistema.EndProcess('Altera��o efetivada');
    end;

begin
  if Confirma('Confirma a altera��o da(s) data(s)') then begin
     AlteraDatasTransacao(ETransacao3.Text,EDataMvto.AsDate,EDataContabil.AsDate,EDataEscritaFiscal.AsDate);
     FGeral.GravaLog(6,'N�mero da transa��o: '+ETransacao3.Text);
  end;
  ETransacao3.Clear;
  EDataContabil.Clear;EDataContabil.Enabled:=False;
  EDataEscritaFiscal.Clear;EDataEscritaFiscal.Enabled:=False;
  EDataMvto.Clear;ETransacao3.SetFocus;
end;


procedure TFDiversos.UsuariosAtivos;
var l:Integer;
    Q:TSqlQuery;
begin
  Caption:='Usu�rios Do Sistema Ativos No Momento';
  Sistema.BeginProcess('localizando usu�rios ativos');
  Width:=545;Height:=332;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgUsuAtivos;
  ActiveControl:=GridUsuAtivos;
  GridUsuAtivos.Clear;
  l:=0;
  Q:=SqlToQuery('SELECT Usua_Nome,Usua_Codigo,Usua_Unid_Codigo FROM Usuarios WHERE Usua_Acessando=''S''');
  while not Q.Eof do begin
    Inc(l);
    if l>1 then GridUsuAtivos.RowCount:=GridUsuAtivos.RowCount+1;
    GridUsuAtivos.Cells[0,l]:=IntToStr(Q.FieldByName('Usua_Codigo').AsInteger);
    GridUsuAtivos.Cells[1,l]:=Q.FieldByName('Usua_Nome').AsString;
    GridUsuAtivos.Cells[2,l]:=Q.FieldByName('Usua_Unid_Codigo').AsString;
    Q.Next;
  end;
  Q.Close;Q.Free;
  Sistema.EndProcess('');
  ShowModal;
  GridUsuAtivos.Clear;
end;

function TFDiversos.GetCodigosLog:String;
var l:Integer;
begin
  if LBLogs.Items.Count=0 then begin
     for l:=1 to High(Global.CodigosLog) do begin
         if Trim(Global.CodigosLog[l])<>'' then LBLogs.Items.Add(StrZero(l,3)+' - '+Global.CodigosLog[l]);
     end;
  end;
  for l:=0 to LBLogs.Items.Count-1 do LBLogs.Checked[l]:=False;
  LBLogs.ItemIndex:=0;
  Caption:='Sele��o Dos C�digos De Log a Considerar';
  Width:=545;Height:=332;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgGetCodigoLog;
  ActiveControl:=LBLogs;
  wRet:=False;
  bConfirmar.Visible:=True;bConfirmar.Top:=bSair.Top+25;
  bTodos.Visible:=True;bTodos.Top:=bSair.Top+25+25;
  PMens.Caption:='Para considerar todos confirme sem selecionar nenhum';
  ShowModal;
  Result:='';
  bConfirmar.Visible:=False;
  bTodos.Visible:=False;
  if wRet then begin
     Result:=',';
     for l:=0 to LBLogs.Items.Count-1 do begin
         if LBLogs.Checked[l] then Result:=Result+LeftStr(LBLogs.Items[l],3)+',';
     end;
  end;
  PMens.Caption:='';
end;



procedure TFDiversos.bTodosClick(Sender: TObject);
var l:Integer;
begin
  if Page.ActivePage=PgGetCodigoLog then begin
     for l:=0 to LBLogs.Items.Count-1 do LBLogs.Checked[l]:=True;
     wRet:=True;
     Close;
  end;
end;


procedure TFDiversos.CancelarDctoBco;
begin
  Caption:='Cancelamento De Documento Banc�rio';
  Width:=506;Height:=156;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgCancDctoBco;
  ActiveControl:=ENumeroOperacao;
  ENumeroOperacao.ClearAll(Self,258);
  ShowModal;
end;


procedure TFDiversos.ENumeroOperacaoValidate(Sender: TObject);
var Q:TSqlQuery;
begin
  Q:=SqlToQuery('SELECT * from movbco where mbco_operacao='+ENumeroOperacao.AsSql);
  if Q.IsEmpty then begin
     ENumeroOperacao.Invalid('Opera��o n�o localizada');
  end else if Trim(Q.FieldByName('mbco_transconc').AsString)<>'' then begin
     ENumeroOperacao.Invalid('Opera��o j� est� conciliada');
  end else if Q.FieldByName('mbco_status').AsString='C' then begin
     ENumeroOperacao.Invalid('Opera��o j� est� cancelada');
  end else begin
     ECodDcto.Text:=Q.FieldByName('Mbco_codb_codigo').AsString;
//     EDescDctoBco.Text:=FCodBanc.GetDescricao(ECodDcto.Text);
     EDataMvto3.Text:=DateToText(Q.FieldByName('mbco_datamvto').AsDateTime);
     EValor3.SetValue(Q.FieldByName('mbco_valorger').AsFloat);
     if Confirma('Confirma o cancelamento da opera��o') then begin
        Sistema.Edit('movbco');
        Sistema.SetField('mbco_status','C');
        Sistema.Post('mbco_operacao='+ENumeroOperacao.AsSql);
        Sistema.Commit;
        Aviso('Opera��o cancelada');
     end;
  end;
  Q.Close;Q.Free;
  ENumeroOperacao.ClearAll(Self,258);
end;

procedure TFDiversos.CtOperacional;

   procedure ConfiguraGrid;
   var Q:TSqlQuery;
       l:Integer;
   begin
     GridCtOper.Tag:=1;
     GridCtOper.Clear;
     l:=0;
     Q:=SqlToQuery('select * from departamentos order by dpto_codigo');
     while not Q.Eof do begin
       if l=0 then begin
          l:=1;
       end else begin
          GridCtOper.RowCount:=GridCtOper.RowCount+1;
          l:=GridCtOper.RowCount-1;
       end;
       GridCtOper.Cells[0,l]:=Q.FieldByName('dpto_codigo').AsString;
       GridCtOper.Cells[1,l]:=Q.FieldByName('dpto_descricao').AsString;
       Q.Next;
     end;
     Q.Close;Q.Free;
     GridCtOper.ColCount:=2;
     for l:=1 to 999 do begin
         if Global.ReduzidoUnidades[l]<>'' then begin
            GridCtOper.ColCount:=GridCtOper.ColCount+1;
            GridCtOper.Cells[GridCtOper.ColCount-1,0]:=StrZero(l,3);
         end;
     end;
     GridCtOper.FixedCols:=2;
   end;


   procedure SetaPercentuais;
   var l,c:Integer;
       d,u:String;
       Q:TSqlQuery;
   begin
     for l:=1 to GridCtOper.RowCount-1 do for c:=2 to GridCtOper.ColCount-1 do GridCtOper.Cells[c,l]:='';
     Q:=SqlToQuery('select * from ctoper');
     while not Q.Eof do begin
       u:=Q.FieldByname('Ctop_Unid_Codigo').AsString;
       d:=Q.FieldByname('Ctop_Dpto_Codigo').AsString;
       for l:=1 to GridCtOper.RowCount-1 do begin
           if GridCtOper.Cells[0,l]=d then begin
              for c:=2 to GridCtOper.ColCount-1 do begin
                  if GridCtOper.Cells[c,0]=u then begin
                     GridCtOper.Cells[c,l]:=TransformAbs(Q.FieldByName('Ctop_percentual').AsFloat,f_perc);
                     Break;
                  end;
              end;
           end;
       end;
       Q.Next;
     end;
     Q.Close;Q.Free;
   end;


begin
  if GridCtOper.Tag=0 then ConfiguraGrid;
  Caption:='Determina��o Dos Custos Operacionais Por Departamento/Unidade';
  Width:=790;Height:=450;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgCtOper;
  ActiveControl:=GridCtOper;
  SetaPercentuais;
  GridCtOper.Row:=1;GridCtOper.Col:=2;
  ShowModal;
end;


procedure TFDiversos.GridCtOperKeyPress(Sender: TObject; var Key: Char);
begin
  if isNumero(key) then begin
     ECtOper.Visible:=True;
     ECtOper.Top:=GridCtOper.TopEdit+2;
     ECtOper.Left:=GridCtOper.LeftEdit-2;
     ECtOper.Text:=Key;
     ECtOper.SetPosCursor(2);
     ECtOper.SetFocus;
     ECtOper.FFirstKey:=False;
  end;
end;

procedure TFDiversos.ECtOperExit(Sender: TObject);
begin
  ECtOper.Visible:=False;
end;

procedure TFDiversos.ECtOperKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then GridCtOper.SetFocus;
end;

procedure TFDiversos.ECtOperExitEdit(Sender: TObject);
var d,u:String;
    Q:TSqlQuery;
begin
  GridCtOper.Cells[GridCtOper.Col,GridCtOper.Row]:=TransformAbs(ECtOper.AsFloat,f_perc);
  d:=GridCtOper.Cells[0,GridCtOper.Row];
  u:=GridCtOper.Cells[GridCtOper.Col,0];
  Q:=SqlToQuery('select * from ctoper where ctop_dpto_codigo='+StringToSql(d)+' and ctop_unid_Codigo='+StringToSql(u));
  if Q.IsEmpty then begin
     Sistema.Insert('CtOper');
     Sistema.SetField('ctop_dpto_codigo',d);
     Sistema.SetField('ctop_unid_Codigo',u);
     Sistema.SetField('ctop_percentual',ECtOper.AsFloat);
     Sistema.Post;
     Sistema.Commit;
  end else begin
     Sistema.Edit('CtOper');
     Sistema.SetField('ctop_percentual',ECtOper.AsFloat);
     Sistema.Post('ctop_dpto_codigo='+StringToSql(d)+' and ctop_unid_Codigo='+StringToSql(u));
     Sistema.Commit;
  end;
  Q.Close;Q.Free;
  GridCtOper.SetFocus;
end;

function TFDiversos.GetEscopo:Boolean;
begin
  Caption:='Escopo Dos Produtos a Considerar';
  Width:=410;Height:=235;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgGetEscopo;
  bConfirmar.Visible:=True;
  ECodDpto.ClearAll(Self,125);
  ActiveControl:=ECodDpto;
  wRet:=False;
  ShowModal;
  bConfirmar.Visible:=False;
  Result:=wRet;
end;


procedure TFDiversos.EAtivosExitEdit(Sender: TObject);
begin
  wRet:=True;
  Close;
end;

procedure TFDiversos.AltHistoricos;
begin
  Caption:='Altera��o De Hist�ricos De Lan�amentos';
  Width:=592;Height:=158;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgHistorico;
  EContaHist.ClearAll(Self,99);
  ActiveControl:=EContaHist;
  ShowModal;
end;

procedure TFDiversos.EContaHistValidate(Sender: TObject);
begin
  EDescrCtaHist.Text:=FPlano.GetDescricao(EContaHist.AsInteger);
end;

procedure TFDiversos.EComplementoEnter(Sender: TObject);
begin
  FHistoricos.SetaComplemento(EComplemento,ECodHist.Asinteger,'','','',0,0);
end;

procedure TFDiversos.EDataFHistExitEdit(Sender: TObject);
var w:String;
begin
  if Confirma('Confirma a atualiza��o do hist�rico') then begin
     Sistema.BeginProcess('gravando hist�rico');
     w:='mger_pger_conta='+IntToStr(EContaHist.AsInteger);
     w:=w+' and mger_datamvto>='+DateToSql(EDataIHist.AsDate);
     w:=w+' and mger_datamvto<='+DateToSql(EDataFHist.AsDate);
     Sistema.Edit('movger');
     Sistema.SetField('Mger_Hist_Codigo',ECodHist.Text);
     Sistema.SetField('Mger_Complemento',EComplemento.Text);
     Sistema.Post(w);
     w:='mcon_pcon_conta='+IntToStr(EContaHist.AsInteger);
     w:=w+' and mcon_datamvto>='+DateToSql(EDataIHist.AsDate);
     w:=w+' and mcon_datamvto<='+DateToSql(EDataFHist.AsDate);
     Sistema.Edit('movcon');
     Sistema.SetField('Mcon_Hist_Codigo',ECodHist.Text);
     Sistema.SetField('Mcon_Complemento',EComplemento.Text);
     Sistema.Post(w);
     Sistema.Commit;
     Sistema.EndProcess('Hist�ricos atualizados');
  end;
  EContaHist.ClearAll(Self,99);
  EContaHist.SetFocus;
end;


function TFDiversos.GetPendEstBaixar(Codigos,Unidade,CatEnt:String;CodEnt:Integer):Boolean;

    function GetPendencias:Boolean;
    var Q:TSqlQuery;
        w:String;
        l,QEmb:Integer;
        Qtde,Valor:Double;
    begin
      Result:=False;
      w:=' where pest_transacaobx<''0''';
      w:=w+' and '+FGeral.GetIN('pest_cpes_codigo',Codigos,'C');
      w:=w+' and (pest_unid_codigo=''000'' or pest_unid_codigo='+StringToSql(Unidade)+')';
      if CodEnt=0 then begin
         w:=w+' and pest_codentidade=0 and pest_catentidade=''N''';
      end else begin
         w:=w+' and pest_codentidade='+IntToStr(CodEnt)+' and pest_catentidade='+StringToSql(CatEnt);
      end;
      w:=w+' and pest_status=''N''';
      l:=0;
      Q:=SqlToQuery('select pendest.*,prod_descricao,prod_codBarras,prod_trib_codigo,prod_peso from pendest left join produtos on (prod_codigo=pest_prod_codigo)'+w);
      while not Q.Eof do begin
        if l=0 then begin
           l:=1;
        end else begin
           GridBxPendEst.RowCount:=GridBxPendEst.RowCount+1;
           l:=GridBxPEndEst.RowCount-1;
        end;
        Result:=True;
        QEmb:=Q.FieldByName('pest_qemb').AsInteger;
        Qtde:=Q.FieldByName('pest_qtde').AsFloat;
        Valor:=Q.FieldByName('pest_valor').AsFloat;
        if Q.FieldByName('pest_qtdebx').AsFloat>0 then begin
           Qtde:=Q.FieldByName('pest_qtde').AsFloat-Q.FieldByName('pest_qtdebx').AsFloat;
           Valor:=Divide(Q.FieldByName('pest_valor').AsFloat,Q.FieldByName('pest_qtde').AsFloat)*Qtde;
        end;
        if QEmb>0 then Qtde:=Qtde/QEmb;
        GridBxPendEst.Cells[1,l]:=IntToStr(Q.FieldByName('pest_prod_codigo').AsInteger);
        GridBxPendEst.Cells[2,l]:=Q.FieldByName('prod_descricao').AsString;
        GridBxPendEst.Cells[3,l]:=IntToStr(QEmb);
        GridBxPendEst.Cells[4,l]:=TransformAbs(Qtde,f_quant);
        GridBxPendEst.Cells[5,l]:=Q.FieldByName('prod_codbarras').AsString;
        GridBxPendEst.Cells[6,l]:=Q.FieldByName('pest_operacao').AsString;
        GridBxPendEst.Cells[7,l]:=IntToStr(Q.FieldByName('pest_sequencial').AsInteger);
        GridBxPendEst.Cells[8,l]:=Q.FieldByName('prod_trib_codigo').AsString;
        GridBxPendEst.Cells[9,l]:=FloatToStr(Q.FieldByName('prod_peso').AsFloat);
        GridBxPendEst.Cells[10,l]:=FloatToStr(Valor);
        Q.Next;
      end;
      Q.Close;
    end;


begin

  GridBxPendEst.Clear;
  GridBxPendEst.RowCount:=2;
  if not GetPendencias then begin
     Aviso('N�o encontradas pend�ncias de estoque para baixa');
     Result:=False;
     Exit;
  end;
  Caption:='Baixa De Pend�ncias De Estoque';
  Width:=790;Height:=350;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgBaixaPendEst;
  bConfirmar.Visible:=True;
  ActiveControl:=GridBxPendEst;
  wRet:=False;
  ShowModal;
  bConfirmar.Visible:=False;
  Result:=wRet;
end;

procedure TFDiversos.GridBxPendEstKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then begin
     if Trim(GridBxPendEst.Cells[0,GridBxPendEst.Row])='' then begin
        GridBxPendEst.Cells[0,GridBxPendEst.Row]:='  Sim';
     end else begin
        GridBxPendEst.Cells[0,GridBxPendEst.Row]:='';
     end;
     if GridBxPendEst.Row<GridBxPendEst.RowCount-1 then GridBxPendEst.Row:=GridBxPendEst.Row+1;
  end;
end;

// 16.06.08
//////////////////////////////////////////////
procedure TFDiversos.ImportaEstoqueDbf;
//////////////////////////////////////////////
var QEst,QQtd:TSqlquery;
    produto,referencia:string;
    codigosub:integer;


    procedure GravaEstoque;
////////////////////////////////////////////////////

      Function Checa(qual,descricao:string):integer;
      ////////////////////////////////////////////////////
      var Q1:TSqlquery;
          codigo,tam:integer;
      begin
//        if (trim(codigo)='') or (trim(codigo)='0')  then exit;
        result:=0;
        if trim(descricao)=''  then exit;
//        if qual='G' then
//          Q1:=sqltoquery('select * from grupos where grup_codigo='+#39+codigo+#39)
//        else if qual='S' then
          tam:=length(trim(descricao));
          Q1:=sqltoquery('select * from subgrupos where substring(sugr_descricao,1,'+inttostr(tam)+')='+#39+descricao+#39);
// 13.06.18
//          Q1:=sqltoquery('select * from subgrupos where sugr_descricao like '+#39+'%'+descricao+'%'+#39);
//        else
//          Q1:=sqltoquery('select * from familias where fami_codigo='+#39+codigo+#39);
        if Q1.eof then begin
          if qual='G' then begin
            Sistema.Insert('grupos');
            Sistema.SetField('grup_codigo',codigo);
            Sistema.SetField('grup_descricao',descricao);
            Sistema.Post;

          end else if qual='S' then begin
            codigo:=FEstoque.GetProximoCodigo('subgrupos','sugr_codigo','N');
            Sistema.Insert('subgrupos');
            Sistema.SetField('sugr_codigo',codigo);
            Sistema.SetField('sugr_descricao',descricao);
            Sistema.Post;
          end else begin
            Sistema.Insert('familias');
            Sistema.SetField('fami_codigo',codigo);
            Sistema.SetField('fami_descricao',descricao);
            Sistema.Post;
          end;
          Sistema.commit;
        end else
          codigo:=Q1.fieldbyname('sugr_codigo').asinteger;
        result:=codigo;
        q1.Close;Freeandnil(Q1);
      end;

var desc:string;x:integer;

    begin
/////////////////////////////////////////////////////
      produto:=FEstoque.GetProximoCodigo('estoque','esto_codigo','C');
      codigosub:=Checa('S',trim(Tabela.FieldByName('LINHA').AsString));

      Sistema.Insert('estoque');
      Sistema.SetField('esto_codigo',produto);
      //..ok  esto_descricao varchar(50),
      desc:=copy(Tabela.FieldByName('DESCRICAO').AsString,1,50);
      x:=pos('/',desc);
      if x>0 then
        desc:=copy(desc,1,x-1)+' '+copy(desc,x+1,length(desc)-x);
      x:=pos('/',desc);
      if x>0 then
        desc:=copy(desc,1,x-1)+' '+copy(desc,x+1,length(desc)-x);
//      Sistema.SetField('esto_descricao',Specialcase(Tabela.FieldByName('DESCRICAO').AsString));
      Sistema.SetField('esto_descricao',Specialcase(desc));
      //..ok  esto_unidade varchar(10),
      Sistema.SetField('esto_unidade','PC');
      //..ok  esto_codbarra varchar(20),
//      Sistema.SetField('esto_codbarra').AsString:= Tabela.FieldByName('CODIRE').AsString;
      //..ok  esto_embalagem numeric(8),
      Sistema.SetField('esto_embalagem',1);
      //..ok  esto_peso numeric(10,3),
      Sistema.SetField('esto_peso',Tabela.FieldByName('PESO').Ascurrency);
      //..ok  esto_grup_codigo numeric(6),
////      else
//      sql_tab.FieldByName('esto_sugr_codigo').AsInteger:=strtointdef(Tabela.FieldByName('SUBGRU').Asstring,0);
//      sql_tab.FieldByName('esto_fami_codigo').AsInteger:=strtointdef(Tabela.FieldByName('SECAO').AsString,0);
//      if uppercase(Tabela.FieldByName('ATIVIT').AsString)='S' then
      Sistema.SetField('esto_emlinha','S');
      Sistema.SetField('esto_usua_codigo',999);
//      Checa('G',Tabela.FieldByName('GRUPO').AsString,Tabela.FieldByName('DESGRU').AsString);
      if codigosub>0 then
        Sistema.SetField('esto_sugr_codigo',codigosub);
//campos not null...
      Sistema.SetField('esto_fami_codigo',1);
      Sistema.SetField('esto_grup_codigo',1);
//      Checa('F',Tabela.FieldByName('SECAO').AsString,Tabela.FieldByName('DESSEC').AsString);

//  esto_qtdeminimo numeric(12,3),
//      sql_tab.FieldByName('esto_qtdeminimo').AsCurrency:=Tabela.FieldByName('MINIMO').AsCurrency;
//  esto_qtdemaximo numeric(12,3),
//      sql_tab.FieldByName('esto_qtdemaximo').AsCurrency:=Tabela.FieldByName('MAXIMO').AsCurrency;
//  esto_referencia varchar(20),
      Sistema.SetField('esto_REFERENCIA',trim(Tabela.FieldByName('CODIGO').AsString));

      Sistema.Post();
    end;

    procedure GravaEstoqueQtde;
    //////////////////////////////////
    begin
      Sistema.Insert('estoqueqtde');
      Sistema.Setfield('esqt_status','N');
      Sistema.Setfield('esqt_unid_codigo',Global.CodigoUnidade);
      Sistema.Setfield('esqt_esto_codigo',Produto);
      Sistema.Setfield('esqt_qtde',0);
      Sistema.Setfield('esqt_qtdeprev',0);
{
      Sistema.Setfield('esqt_vendavis',EdEsto_vendavis.AsCurrency);
      Sistema.Setfield('esqt_custo',EdEsto_custo.AsCurrency);
      Sistema.Setfield('esqt_custoger',EdEsto_custoger.AsCurrency);
      Sistema.Setfield('esqt_customedio',EdEsto_customedio.AsCurrency);
      Sistema.Setfield('esqt_customeger',EdEsto_customeger.AsCurrency);
      Sistema.Setfield('esqt_dtultvenda',EdEsto_dtultvenda.AsDate);
      Sistema.Setfield('esqt_dtultcompra',EdEsto_dtultcompra.AsDate);
      Sistema.Setfield('esqt_desconto',EdEsto_desconto.AsCurrency);
      Sistema.Setfield('esqt_basecomissao',EdEsto_basecomissao.AsCurrency);
}
      Sistema.Setfield('esqt_cfis_codigoest',FUnidades.GetFiscalDentro(Global.CodigoUnidade) );
      Sistema.Setfield('esqt_cfis_codigoforaest',FUnidades.GetFiscalFora(Global.CodigoUnidade));
      Sistema.Setfield('esqt_sitt_codestado',FUnidades.GetSittDentro(Global.CodigoUnidade));
      Sistema.Setfield('esqt_sitt_forestado',FUnidades.GetSittFora(Global.CodigoUnidade));

      Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
//      Sistema.Setfield('esqt_vendamin',EdEsto_vendamin.AsCurrency);
//      Sistema.Setfield('esqt_pecas',EdEsto_pecas.AsFloat);
//      Sistema.Setfield('esqt_custoser',EdMobra.AsFloat);
//      Sistema.Setfield('esqt_customedioser',EdMomedio.AsFloat);
//      Sistema.Setfield('esqt_codbarra',EdEsto_codbarra.text);
      Sistema.post;

    end;

begin
////////////////////////////////////////////////////
  Width:=561;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgImportaEstoque;
  EdArquivodbf.enabled:=true;
  ActiveControl:=EdArquivodbf;
  PMens.Caption:='Importa��o Cadastro do Estoque';
  Caption:='Importa��o Cadastro do Estoque';
  bConfirmar.Visible:=True;bConfirmar.Top:=bSair.Top+25;
  wRet:=False;
  ShowModal;
  if wret then begin
    if not FileExists(EdArquivodbf.text) then begin
      Avisoerro('Arquivo '+EdArquivodbf.text+' n�o encontrado');
      exit;;
    end;
        Tabela.FileName:=EdArquivodbf.text;
        try
          Tabela.Open;
        except
          Avisoerro('N�o foi poss�vel abrir arquivo '+Tabela.FileName);
          exit;
        end;
        Sistema.beginprocess('Importando estoque do arquivo  '+EdArquivodbf.text);
        while not Tabela.Eof do begin
          referencia:=trim(Tabela.fieldbyname('codigo').asstring);
          QEst:=sqltoquery('select esto_referencia,esto_codigo from estoque where esto_referencia='+stringtosql(referencia));
          if QEst.eof then begin
            produto:=FEstoque.GetProximoCodigo('estoque','esto_codigo','C');
            GravaEstoque;
            try
              Sistema.Commit;
              Sistema.beginprocess('Tabela estoque codigo '+produto);
            except
              Avisoerro('N�o foi gravado na tabela estoque referencia '+referencia);
            end;

          end else
            produto:=QEst.fieldbyname('esto_codigo').asstring;

          QQtd:=sqltoquery('select esqt_esto_codigo from estoqueqtde where esqt_esto_codigo='+stringtosql(produto)+
                           ' and esqt_unid_codigo='+stringtosql(Global.CodigoUnidade));
          if QQtd.eof then begin
            GravaEstoqueQtde;
            try
              Sistema.Commit;
              Sistema.beginprocess('Tabela estoqueqtde codigo '+produto);
            except
              Avisoerro('N�o foi gravado na tabela estoqueqtde codigo '+produto);
            end;
          end;

          Tabela.Next;
        end;
        Tabela.close;
        Sistema.endprocess('Importa��o terminada');

  end;
end;

////////////////

procedure TFDiversos.bqualdbfClick(Sender: TObject);
begin
  if not Qualdbf.Execute then exit;
  EdArquivodbf.text:=Qualdbf.FileName;

end;

/////////////////////////////////////////////////////////////
///////////////////////////////////////// 15.04.09
procedure TFDiversos.ImportaEstoqueTexto;
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
var QEst,QQtd,QCor,QTamanho:TSqlquery;
    produto,referencia,codbarra,separador,descr:string;
    codigosub,p,poscodigo,posdescricao,posunidade,poscodcor,poscodtamanho,
    posdescor,posdestamanho,posqtdvenda,posvalorvendainteira,posvalorvendadecimal,
    codcor,codtamanho,incluidos,posncm,posvalorvendaunitario,posvalorcustounitario,
    tamcodigo,posreferencia,posestoque,atualizados,xx,poscor,postamanho,
    poscfop,
    possubgrupo          :integer;
    ListaItens,ListaLinha:Tstringlist;
    xunidade,sqltamanho,sqlcor,
    xcfop,
    linha,
    conteudosubgrupo  :string;
    vendaunitario,qtdvendida,custounitario,qtdeestoque:currency;
    Grava,GravaRef:boolean;


    procedure GravaEstoque;
////////////////////////////////////////////////////

      Function Checa(qual,descricao:string):integer;
      ////////////////////////////////////////////////////
      var Q1:TSqlquery;
          codigo,tam:integer;
      begin
//        if (trim(codigo)='') or (trim(codigo)='0')  then exit;
        result:=0;
        if trim(descricao)=''  then exit;
//        if qual='G' then
//          Q1:=sqltoquery('select * from grupos where grup_codigo='+#39+codigo+#39)
//        else if qual='S' then
          tam:=length(trim(descricao));
          Q1:=sqltoquery('select * from subgrupos where substring(sugr_descricao,1,'+inttostr(tam)+')='+#39+descricao+#39);
// 13.06.18
//          Q1:=sqltoquery('select * from subgrupos where substring(sugr_descricao from 1 for '+inttostr(tam)+')='+#39+descricao+#39);
//          Q1:=sqltoquery('select * from subgrupos where sugr_descricao like '+#39+'%'+descricao+'%'+#39);
//        else
//          Q1:=sqltoquery('select * from familias where fami_codigo='+#39+codigo+#39);
        if Q1.eof then begin
          if qual='G' then begin
            Sistema.Insert('grupos');
            Sistema.SetField('grup_codigo',codigo);
            Sistema.SetField('grup_descricao',descricao);
            Sistema.Post;

          end else if qual='S' then begin

            codigo:=FEstoque.GetProximoCodigo('subgrupos','sugr_codigo','N');
            Sistema.Insert('subgrupos');
            Sistema.SetField('sugr_codigo',codigo);
            Sistema.SetField('sugr_descricao',descricao);
            Sistema.Post;
          end else begin
            Sistema.Insert('familias');
            Sistema.SetField('fami_codigo',codigo);
            Sistema.SetField('fami_descricao',descricao);
            Sistema.Post;
          end;
          Sistema.commit;
        end else
          codigo:=Q1.fieldbyname('sugr_codigo').asinteger;
        result:=codigo;
        q1.Close;Freeandnil(Q1);
      end;

    var desc:string;x:integer;

/////////////////////////////////////////////////////
    begin
/////////////////////////////////////////////////////

      produto:=FEstoque.GetProximoCodigo('estoque','esto_codigo','C');

      codigosub:=Checa('S',trim(conteudosubgrupo));
//      codigosub:=1;

      Sistema.Insert('estoque');
      Sistema.SetField('esto_codigo',produto);
//      desc:=copy(ListaLInha[0],posdescricao,50);
      desc:=ListaLInha[posdescricao];
      x:=pos('�',desc);
      if x>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
        desc:=copy(desc,1,x-1)+'�'+copy(desc,x+2,length(desc)-x);
//      x:=pos('�',desc);  // 241
      x:=pos('�',desc);
      if x>0 then
        desc:=copy(desc,1,x)+copy(desc,x+2,length(desc)-x);
      x:=pos('�',desc);
      if x>0 then
        desc:=copy(desc,1,x-1)+' '+copy(desc,x+2,length(desc)-x);
      x:=pos('�',desc);
      if x>0 then
        desc:=copy(desc,1,x-1)+' '+copy(desc,x+2,length(desc)-x);
// 05.01.15
      x:=pos('''',desc);
      if x>0 then
        desc:=copy(desc,1,x-1)+'"'+copy(desc,x+2,length(desc)-x);
      Sistema.SetField('esto_descricao',Specialcase( copy(desc,1,70) ));
      if (posunidade>0) and (trim(ListaLInha[posunidade])<>'') then
        Sistema.SetField('esto_unidade',Uppercase(ListaLInha[posunidade]))
      else
        Sistema.SetField('esto_unidade','UN');
//      Sistema.SetField('esto_codbarra').AsString:= Tabela.FieldByName('CODIRE').AsString;
      Sistema.SetField('esto_embalagem',1);
      //..ok  esto_peso numeric(10,3),
//      Sistema.SetField('esto_peso',Tabela.FieldByName('PESO').Ascurrency);
      //..ok  esto_grup_codigo numeric(6),
////      else
//      sql_tab.FieldByName('esto_sugr_codigo').AsInteger:=strtointdef(Tabela.FieldByName('SUBGRU').Asstring,0);
//      sql_tab.FieldByName('esto_fami_codigo').AsInteger:=strtointdef(Tabela.FieldByName('SECAO').AsString,0);
//      if uppercase(Tabela.FieldByName('ATIVIT').AsString)='S' then
      Sistema.SetField('esto_emlinha','S');
      Sistema.SetField('esto_usua_codigo',997);
//      Checa('G',Tabela.FieldByName('GRUPO').AsString,Tabela.FieldByName('DESGRU').AsString);
      if codigosub>0 then
        Sistema.SetField('esto_sugr_codigo',codigosub);
//campos not null...
      Sistema.SetField('esto_fami_codigo',1);
//      Sistema.SetField('esto_grup_codigo',1);
      Sistema.SetField('esto_grup_codigo',1);
// 21.10.13 - Metalforte
      Sistema.SetField('esto_fami_codigo',1);
      Sistema.SetField('esto_REFERENCIA',trim(referencia));
// 02.12.11 s� usar quando nao tiver grade...
//      Sistema.SetField('Esto_codbarra',codbarra);

      Sistema.Post();
    end;

    procedure GravaEstoqueQtde;
    ///////////////////////////
    begin

      Sistema.Insert('estoqueqtde');
      Sistema.Setfield('esqt_status','N');
      Sistema.Setfield('esqt_unid_codigo',Global.CodigoUnidade);
      Sistema.Setfield('esqt_esto_codigo',Produto);
      if posestoque>0 then begin
        Sistema.Setfield('esqt_qtde',TExttovalor(ListaLinha[posestoque]));
        Sistema.Setfield('esqt_qtdeprev',TExttovalor(ListaLinha[posestoque]));
      end else begin
        Sistema.Setfield('esqt_qtde',0);
        Sistema.Setfield('esqt_qtdeprev',0);
      end;
      custounitario:=0;
      vendaunitario:=0;
//      custounitario:=Texttovalor( copy(ListaLinha[0],posvalorcustounitario,10) );
//      custounitario:=Texttovalor( copy(ListaLinha[posvalorcustounitario],pos('$',ListaLinha[posvalorcustounitario])+1,10)  );
//      vendaunitario:=Texttovalor( copy(ListaLinha[posvalorvendaunitario],pos('$',ListaLinha[posvalorvendaunitario])+1,10)  );
//      vendaunitario:=Texttovalor( ListaLinha[posvalorvendainteira] ) +
//                     Texttovalor(ListaLinha[posvalorvendadecimal])/100;
// 02.12.11 - especifico vivan...lista com valor total da venda e nao unitario...
//      qtdvendida:=Texttovalor(ListaLinha[posqtdvenda]);
//      if qtdvendida>0 then vendaunitario:=vendaunitario/qtdvendida;
//      vendaunitario:=custounitario/0.60;
//      vendaunitario:=1;
      if posvalorvendaunitario>0 then begin
        vendaunitario:=Texttovalor( Listalinha[posvalorvendaunitario] );
        Sistema.Setfield('esqt_vendavis',vendaunitario);
        Sistema.Setfield('esqt_custo',custounitario);
        Sistema.Setfield('esqt_customedio',custounitario);
        Sistema.Setfield('esqt_custoger',custounitario);
        Sistema.Setfield('esqt_customeger',custounitario);
      end;
{
      Sistema.Setfield('esqt_custo',Texttovalor(ListaLInha[4]));
      Sistema.Setfield('esqt_custoger',Texttovalor(ListaLInha[4]));
      Sistema.Setfield('esqt_customedio',Texttovalor(ListaLInha[4]));
      Sistema.Setfield('esqt_customeger',Texttovalor(ListaLInha[4]));
}
{
      Sistema.Setfield('esqt_custo',EdEsto_custo.AsCurrency);
      Sistema.Setfield('esqt_custoger',EdEsto_custoger.AsCurrency);
      Sistema.Setfield('esqt_customedio',EdEsto_customedio.AsCurrency);
      Sistema.Setfield('esqt_customeger',EdEsto_customeger.AsCurrency);
      Sistema.Setfield('esqt_dtultvenda',EdEsto_dtultvenda.AsDate);
      Sistema.Setfield('esqt_dtultcompra',EdEsto_dtultcompra.AsDate);
      Sistema.Setfield('esqt_desconto',EdEsto_desconto.AsCurrency);
      Sistema.Setfield('esqt_basecomissao',EdEsto_basecomissao.AsCurrency);
}
      if poscfop>0 then begin // especifico quando tem cfop para identifcar se tem ST
        if pos(xcfop,'5405/6404')>0 then begin
          Sistema.Setfield('esqt_sitt_codestado',4);
          Sistema.Setfield('esqt_sitt_forestado',4);
        end else begin
          Sistema.Setfield('esqt_sitt_codestado',FUnidades.GetSittDentro(Global.CodigoUnidade));
          Sistema.Setfield('esqt_sitt_forestado',FUnidades.GetSittFora(Global.CodigoUnidade));
        end;
        Sistema.Setfield('esqt_cfis_codigoest',FUnidades.GetFiscalDentro(Global.CodigoUnidade) );
        Sistema.Setfield('esqt_cfis_codigoforaest',FUnidades.GetFiscalFora(Global.CodigoUnidade));
      end else begin
        Sistema.Setfield('esqt_cfis_codigoest',FUnidades.GetFiscalDentro(Global.CodigoUnidade) );
        Sistema.Setfield('esqt_cfis_codigoforaest',FUnidades.GetFiscalFora(Global.CodigoUnidade));
        Sistema.Setfield('esqt_sitt_codestado',FUnidades.GetSittDentro(Global.CodigoUnidade));
        Sistema.Setfield('esqt_sitt_forestado',FUnidades.GetSittFora(Global.CodigoUnidade));
      end;
//      Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
      Sistema.Setfield('esqt_usua_codigo',997);
//      Sistema.Setfield('esqt_vendamin',EdEsto_vendamin.AsCurrency);
//      Sistema.Setfield('esqt_pecas',EdEsto_pecas.AsFloat);
//      Sistema.Setfield('esqt_custoser',EdMobra.AsFloat);
//      Sistema.Setfield('esqt_customedioser',EdMomedio.AsFloat);
//      Sistema.Setfield('esqt_codbarra',EdEsto_codbarra.text);
      Sistema.post;

    end;


    procedure AtualizaEstoque;
    ////////////////////////////
    begin
//      vendaunitario:=Texttovalor( ListaLinha[posvalorvendainteira] ) +
//                     Texttovalor(ListaLinha[posvalorvendadecimal])/100;
//      custounitario:=Texttovalor( copy(ListaLinha[0],posvalorcustounitario,10) );
      custounitario:=Texttovalor(ListaLinha[posvalorcustounitario]);
//      vendaunitario:=Texttovalor( copy(ListaLinha[0],posvalorvendaunitario,10) );
// 02.12.11 - especifico vivan...lista com valor total da venda e nao unitario...
//      qtdvendida:=Texttovalor(ListaLinha[posqtdvenda]);
//      if qtdvendida>0 then vendaunitario:=vendaunitario/qtdvendida;
//      vendaunitario:=custounitario/0.60;    // 40% embutido
      vendaunitario:=custounitario;
      if vendaunitario > 0 then begin
        Sistema.beginprocess('Tabela estoqueqtde pre�o de venda codigo '+produto);
        Sistema.edit('estoqueqtde');
//        Sistema.Setfield('esqt_vendavis',vendaunitario);
//        Sistema.Setfield('esqt_qtde',qtdeestoque);
//        Sistema.Setfield('esqt_qtdeprev',qtdeestoque);

//        if QQtd.fieldbyname('esqt_customedio').ascurrency<=0 then begin
          Sistema.Setfield('esqt_custo',custounitario);
          Sistema.Setfield('esqt_customedio',custounitario);
          Sistema.Setfield('esqt_custoger',custounitario);
          Sistema.Setfield('esqt_customeger',custounitario);
//        end;

        Sistema.Post('esqt_esto_codigo='+stringtosql(produto)+' and esqt_status=''N'''+
                     ' and esqt_unid_codigo='+stringtosql(Global.CodigoUnidade));
      end;
    end;


    procedure GravaCor(xcodigo:integer;xdescricao:string);
    /////////////////////////////////////////////////////
    begin
      QCor:=sqltoquery('select * from cores where core_codigo='+inttostr(xcodigo));
      if Qcor.eof then begin
        Sistema.Insert('cores');
        Sistema.SetField('core_codigo',xcodigo);
        Sistema.SetField('core_descricao',xdescricao);
        Sistema.post;
      end;
      FGeral.FechaQuery(Qcor);
    end;

    procedure GravaTamanho(xcodigo:integer;xdescricao:string);
    /////////////////////////////////////////////////////
    begin
      QTamanho:=sqltoquery('select * from tamanhos where tama_codigo='+inttostr(xcodigo));
      if QTamanho.eof then begin
        Sistema.Insert('tamanhos');
        Sistema.SetField('tama_codigo',xcodigo);
        Sistema.SetField('tama_descricao',xdescricao);
        Sistema.SetField('tama_reduzido',copy(xdescricao,1,10));
        Sistema.post;
      end;
      FGeral.FechaQuery(QTamanho);
    end;

    procedure GravaGrade(xcodcor,xcodtamanho:integer);
    /////////////////////////////////////////////////////
    var QGrade:TSqlquery;
    begin
      QGrade:=sqltoquery('select * from estgrades where esgr_esto_codigo='+stringtosql(produto)+
                          ' and esgr_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                          ' and esgr_core_codigo='+inttostr(xcodcor)+
                          ' and esgr_tama_codigo='+inttostr(xcodtamanho)+
                          ' and esgr_status=''N''' );
      if QGrade.eof then begin
        Sistema.Insert('estgrades');
        Sistema.Setfield('esgr_status','N');
        Sistema.Setfield('esgr_unid_codigo',Global.codigounidade);
        Sistema.Setfield('esgr_esto_codigo',produto);
        Sistema.Setfield('esgr_grad_codigo',0);
        Sistema.Setfield('esgr_usua_codigo',998);
        Sistema.Setfield('esgr_tama_codigo',xcodtamanho);
        Sistema.Setfield('esgr_core_codigo',xCodcor);
        Sistema.Setfield('esgr_copa_codigo',0);
        Sistema.Setfield('esgr_qtde',0);
        Sistema.Setfield('esgr_qtdeprev',0);
        Sistema.Setfield('esgr_codbarra',codbarra);
        Sistema.Setfield('esgr_custo',custounitario);
        Sistema.Setfield('esgr_customedio',custounitario);
        Sistema.Setfield('esgr_custoger',custounitario);
        Sistema.Setfield('esgr_customeger',custounitario);
        Sistema.Setfield('esgr_vendavis',vendaunitario);
//        Sistema.Setfield('esgr_dtultvenda',EdEsto_dtultvenda.asdate);
//        Sistema.Setfield('esgr_dtultcompra',EdEsto_dtultcompra.asdate);
        Sistema.post;
      end else begin
//        vendaunitario:=Texttovalor( ListaLinha[posvalorvendainteira] ) +
//                       Texttovalor(ListaLinha[posvalorvendadecimal])/100;
        vendaunitario:=Texttovalor( ListaLinha[posvalorvendaunitario] );
// 01.09.12 - especifico vivan...lista com valor total da venda e nao unitario...
        qtdvendida:=Texttovalor(ListaLinha[posqtdvenda]);
        if qtdvendida>0 then vendaunitario:=vendaunitario/qtdvendida;
        if vendaunitario > 0 then begin
          Sistema.beginprocess('Tabela estgrades pre�o de venda codigo '+produto);
          Sistema.edit('estgrades');
          Sistema.Setfield('esgr_custo',custounitario);
          Sistema.Setfield('esgr_customedio',custounitario);
          Sistema.Setfield('esgr_custoger',custounitario);
          Sistema.Setfield('esgr_customeger',custounitario);
          Sistema.Setfield('esgr_vendavis',vendaunitario);
          Sistema.Post('esgr_esto_codigo='+stringtosql(produto)+' and esgr_status=''N'''+
                       ' and esgr_unid_codigo='+stringtosql(Global.CodigoUnidade));

        end;
      end;
      FGeral.FechaQuery(QGrade);
    end;

    procedure GravaNCM;
    ///////////////////
    var QNcm:TSqlquery;
        desc:string;
        x:integer;
    begin
      if trim(ListaLinha[posncm])='' then exit;
      QNCm:=Sqltoquery('select * from codigosipi where cipi_codfiscal='+Stringtosql(trim(ListaLinha[posncm])) );
      if QNcm.eof then begin
        Sistema.Insert('codigosipi');
// se de erro de substr no banco de dados ver funcao getproximocodigo
        Sistema.SetField( 'cipi_codigo',FEstoque.GetProximoCodigo('codigosipi','cipi_codigo','N') );

        desc:=copy(ListaLInha[posdescricao],1,50);
      x:=pos('�',desc);
      if x>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
        desc:=copy(desc,1,x-1)+'�'+copy(desc,x+2,length(desc)-x);
//      x:=pos('�',desc);  // 241
      x:=pos('�',desc);
      if x>0 then
        desc:=copy(desc,1,x)+copy(desc,x+2,length(desc)-x);
        Sistema.SetField('cipi_descricao',Specialcase(copy(desc,1,50) ) );
        Sistema.SetField('cipi_codfiscal',ListaLinha[posncm]);
// fab. propria, % ipi e cst ipi cfe de onde importar...do sefa sp nao tem...
        Sistema.Post();
      end;
      FGeral.FechaQuery(QNCm);
    end;


    procedure GravaCodigoNcm;
    /////////////////////////
    var QNcm:TSqlquery;
    begin
      QNCm:=Sqltoquery('select * from codigosipi where cipi_codfiscal='+Stringtosql(trim(ListaLinha[posncm])) );
      if not QNcm.eof then begin
        Sistema.edit('estoque');
        Sistema.setfield('esto_cipi_codigo',QNcm.fieldbyname('cipi_codigo').AsInteger);
        Sistema.post('esto_codigo='+Stringtosql(produto) );
      end;
      FGeral.FechaQuery(QNCm);
    end;

    // 18.03.14
    function GetCodigopelaDescricao(xdesc,xqual:string):integer;
    /////////////////////////////////////////////////////////////
    var Qc:TSqlquery;
    begin
      if xqual='C' then begin
        Qc:=sqltoquery('select core_codigo from cores where core_descricao='+Stringtosql(trim(xdesc)));
        if not Qc.eof then result:=Qc.fieldbyname('core_codigo').AsInteger else result:=0;
      end else begin
        Qc:=sqltoquery('select tama_codigo from tamanhos where tama_descricao='+Stringtosql(trim(xdesc)));
        if not Qc.eof then result:=Qc.fieldbyname('tama_codigo').AsInteger else result:=0;
      end;
      FGeral.FechaQuery(Qc);
    end;


begin
////////////////////////////////////////////////////
  Width:=561;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgImportaEstoque;
  EdArquivodbf.enabled:=false;
  ActiveControl:=EdArquivoTexto;

  Memo1.Visible:=true;

  PMens.Caption:='Importa��o Cadastro do Estoque';
  Caption:='Importa��o Cadastro do Estoque';
  bConfirmar.Visible:=True;bConfirmar.Top:=bSair.Top+25;
  wRet:=False;

///////////////////////////////////////////////////////////////////
// 26.09.17 - Listam excel .CSV - Hardsoul chapec�
///////////////////////////////////////////////////////////////////
 {
  poscodigo:=0;posdescricao:=1;posdescor:=0;
  posdestamanho:=0; posvalorvendainteira:=0 ; posvalorvendadecimal:=0;
  poscodcor:=0  ; poscodtamanho:= 0; posqtdvenda:=0;posreferencia:=0;
  posncm:=2 ; posunidade:=0 ;  posvalorvendaunitario:=6; posvalorcustounitario:=0;
  posestoque:=0; poscfop:=0;
  poscor:=0;
  postamanho:=0;
  SEPARADOR:=';';
  }
////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

// - arquivo texto exportado do Sefa-SP
////////////////////////////////////////////////////////
{
  poscodigo:=1;posdescricao:=2;posdescor:=0;
  posdestamanho:=0; posvalorvendainteira:=0 ; posvalorvendadecimal:=0;
  poscodcor:=0  ; poscodtamanho:= 0; posqtdvenda:=0;
  posncm:=4 ; posunidade:=7 ;  posvalorvendaunitario:=8;
  SEPARADOR:='|';
}

//////////////////////////////////////
// - arquivo texto de vendas por grade - vivan
{
  poscodigo:=0;posdescricao:=1;posdescor:=5;
  posdestamanho:=3; posvalorvendainteira:=0 ; posvalorvendadecimal:=0;
  poscodcor:=4  ; poscodtamanho:= 2; posqtdvenda:=6;
  posncm:=0 ; posunidade:=0 ;  posvalorvendaunitario:=7;
}
// 06.07.13 - Metalforte
/////////////////////////////////////////////
{
  poscodigo:=0;posdescricao:=4;posdescor:=0;
  posdestamanho:=0; posvalorvendainteira:=0 ; posvalorvendadecimal:=0;
  poscodcor:=0  ; poscodtamanho:= 0; posqtdvenda:=0;posreferencia:=1;
  posncm:=2 ; posunidade:=0 ;  posvalorvendaunitario:=0; posvalorcustounitario:=0;
  posestoque:=0;
  SEPARADOR:=';';
}

// 17.09.13 - Metalforte - somente atualizar sem incluir nada
// 21.10.13 - Metalforte - incluir 'produtos aluminio' - Alumifix
// 18.12.14 - Coorlaf Pitanga Leosoft-Coopnet
{
  poscodigo:=1;posdescricao:=3;posdescor:=0;
  posdestamanho:=0; posvalorvendainteira:=0 ; posvalorvendadecimal:=0;
  poscodcor:=0  ; poscodtamanho:= 0; posqtdvenda:=0;posreferencia:=0;
  posncm:=0 ; posunidade:=0 ;  posvalorvendaunitario:=0; posvalorcustounitario:=7;
  posestoque:=0;
  poscor:=0;
  postamanho:=0;
  }
// 05.01.15 - Coorlaf Santa Maria Leosoft-Coopnet
{
  poscodigo:=0;posdescricao:=2;posdescor:=0;
  posdestamanho:=0; posvalorvendainteira:=0 ; posvalorvendadecimal:=0;
  poscodcor:=0  ; poscodtamanho:= 0; posqtdvenda:=0;posreferencia:=0;
  posncm:=0 ; posunidade:=0 ;  posvalorvendaunitario:=9; posvalorcustounitario:=7;
  posestoque:=0;
  poscor:=0;
  postamanho:=0;
  }
//
// 01.01.15 - Coorlaf laranjeiras listagem a parte
///////////////////////////////////////////////////////////////////
  {
  poscodigo:=0;posdescricao:=0;posdescor:=0;
  posdestamanho:=0; posvalorvendainteira:=0 ; posvalorvendadecimal:=0;
  poscodcor:=0  ; poscodtamanho:= 0; posqtdvenda:=0;posreferencia:=0;
  posncm:=1 ; posunidade:=2 ;  posvalorvendaunitario:=4; posvalorcustounitario:=3;
  posestoque:=0;
  poscor:=0;
  postamanho:=0;
  }
///////////////////////////////////////////////////////////////////
// 28.09.15 - Listam excel .CSV - RM
///////////////////////////////////////////////////////////////////
{
  poscodigo:=0;posdescricao:=0;posdescor:=0;
  posdestamanho:=0; posvalorvendainteira:=0 ; posvalorvendadecimal:=0;
  poscodcor:=0  ; poscodtamanho:= 0; posqtdvenda:=0;posreferencia:=0;
  posncm:=2 ; posunidade:=0 ;  posvalorvendaunitario:=0; posvalorcustounitario:=0;
  posestoque:=1; poscfop:=3;
  poscor:=0;
  postamanho:=0;
  SEPARADOR:=';';
}
///////////////////////////////////////////////////////////////////
// 11.03.16 - Listam excel .CSV - Inventario Patopapel
///////////////////////////////////////////////////////////////////
{
  poscodigo:=0;posdescricao:=1;posdescor:=0;
  posdestamanho:=0; posvalorvendainteira:=0 ; posvalorvendadecimal:=0;
  poscodcor:=0  ; poscodtamanho:= 0; posqtdvenda:=0;posreferencia:=0;
  posncm:=0 ; posunidade:=0 ;  posvalorvendaunitario:=0; posvalorcustounitario:=3;
  posestoque:=0; poscfop:=0;
  poscor:=0;
  postamanho:=0;
  SEPARADOR:=';';
}
///////////////////////////////////////////////////////////////////


{ - para atualizar, incluir ncms - A FAZER
  poscodigo:=0;posdescricao:=1;posdescor:=0;
  posdestamanho:=0; posvalorvendainteira:=0 ; posvalorvendadecimal:=0;
  poscodcor:=0  ; poscodtamanho:= 0; posqtdvenda:=0;
  posncm:=2 ; posunidade:=0 ;  posvalorvendaunitario:=0;
}

//  SEPARADOR:=';';
///////////////////////////////////////////////////////////////////
// 18.10.19 - Lista excel .CSV - Guiber  - Silvano
///////////////////////////////////////////////////////////////////
 {
  poscodigo:=0;posdescricao:=3;posdescor:=0;
  posdestamanho:=0; posvalorvendainteira:=0 ; posvalorvendadecimal:=0;
  poscodcor:=0  ; poscodtamanho:= 0; posqtdvenda:=0; posreferencia:=1;
  posncm:=23 ; posunidade:=10 ;  posvalorvendaunitario:=12; posvalorcustounitario:=13;
  posestoque:=0; poscfop:=0;  possubgrupo:=6;
  poscor:=0;
  postamanho:=0;
  SEPARADOR:=';';
 }
////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
// 05.02.20 - Lista excel .CSV - Matteo  - Seip Brasil
///////////////////////////////////////////////////////////////////

  poscodigo:=1;posdescricao:=0;posdescor:=0;
  posdestamanho:=0; posvalorvendainteira:=0 ; posvalorvendadecimal:=0;
  poscodcor:=0  ; poscodtamanho:= 0; posqtdvenda:=0; posreferencia:=0;
  posncm:=0 ; posunidade:=0 ;  posvalorvendaunitario:=0; posvalorcustounitario:=04;
  posestoque:=03; poscfop:=0;  possubgrupo:=0;
  poscor:=0;
  postamanho:=0;
  SEPARADOR:=';';

////////////////////////////////////////////////////////////////////


  ShowModal;

  if wret then begin

    if not FileExists(EdArquivotexto.text) then begin
      Avisoerro('Arquivo '+EdArquivotexto.text+' n�o encontrado');
      exit;;
    end;

        Memo1.Lines.Clear;
        Memo1.Lines.LoadFromFile( EdArquivotexto.Text );

//        if not confirma('Prossegue ? ') then exit;

        ListaItens:=TStringlist.create;
        ListaItens.Assign(Memo1.Lines );
{
        try
          ListaItens.LoadFromFile(EdArquivotexto.Text);
        except
          Avisoerro('N�o foi poss�vel ler arquivo '+EdArquivotexto.Text);
          exit;
        end;
}

{
        if confirma('Zerar arquivos ?') then begin

          Sistema.beginprocess('Apagando tabelas do estoque');
          Sistema.Conexao.ExecuteDirect('truncate table estoque');
          Sistema.Conexao.ExecuteDirect('truncate table estoqueqtde');
          Sistema.Conexao.ExecuteDirect('truncate table estgrades');
          Sistema.Conexao.ExecuteDirect('truncate table codigosipi');
          Sistema.Conexao.ExecuteDirect('truncate table subgrupos');
//          Sistema.Conexao.ExecuteDirect('truncate table cores');
//          Sistema.Conexao.ExecuteDirect('truncate table tamanhos');
        end;
        }

        Sistema.beginprocess('Importando estoque do arquivo  '+EdArquivotexto.text);
        tamcodigo:=FGeral.GetConfig1AsInteger('TAMESTOQUE');

        for p:=0 to ListaItens.count-1 do begin

          ListaLInha:=TStringlist.create;
          referencia:='';
// 13.06.18
//         Caption:='Emissor Sefa SP';
         Caption:='Seip Brasil';
// 20.10.19 -
//         Caption:='Guiber - Silvano';

//         if copy(ListaItens[p],1,1)='I' then begin

//          if pos( copy(ListaItens[p],4,1),'0123456789' ) >0 then begin
//            strtolista(ListaLINha,ListaItens[p],'|',true); // arquivo TXT do SEFA SP
//            referencia:=trim(ListaLinha[poscodigo]);       // arquivo TXT do SEFA SP
//            referencia:=copy(ListaItens[p],posreferencia,12);
//            if ( Global.Topicos[1203] ) and ( FGeral.GetConfig1AsInteger('TAMESTOQUE')>0 ) then
//              referencia:=FEstoque.GetProximoCodigo('estoque','esto_codigo','C');
//        end else begin

// 20.10.19
       linha:=FGeral.TiraBarra(ListaItens[p],'"');
       strtolista(ListaLINha,Linha,SEPARADOR,true);

//       if trim(ListaLinha[poscodigo]) <> '' then begin
        if ListaLInha.Count>3 then begin

          if ( pos('$',ListaItens[p])>0 ) and (poscodigo=0) then produto:=''
          else if (ListaLInha.Count>3) and ( pos('$',ListaItens[p])>0 ) then produto:=ListaLinha[poscodigo]
          else produto:=ListaLinha[poscodigo];

          produto:=StrtostrNumeros(produto);

//          referencia:=trim(ListaLinha[poscodigo]);
//          /if ( strtointdef( referencia,0 ) > 0 ) then begin
//          if pos( copy(ListaItens[p],4,1),'0123456789' ) >0 then begin
// 21.10.13
//          if trim( produto ) <>'' then begin
//          if pos('$',ListaItens[p])>0 then begin

//            if ( copy(ListaItens[p],1,1)='I' ) then begin     // sefa sp
            IF ( trim(ListaLinha[poscodigo])<>'' ) THEN BEGIN

//            codcor:=strtointdef( ListaLinha[poscodcor],0 );
//            codtamanho:=strtointdef( ListaLinha[poscodtamanho],0 );
//////////////////////            ListaLinha.Add(LIstaItens[p]);
            codcor:=0;
            codtamanho:=0;
            if (codtamanho+codcor) >0 then
              codbarra:=StrZero( strtoint(produto),6 )+strzero(codtamanho,3)+strzero(codcor,3)
            else if trim(referencia)<>'' then
//              codbarra:=StrZero( strtoint(referencia),12 );
              codbarra:='';

            if ( posncm>0) and (ListaLInha.count>4) then GravaNcm;

            if tamcodigo>0 then
              produto:=strzero( strtoint(trim(ListaLinha[poscodigo])),tamcodigo );


//            else
             {
            if length(trim(ListaLinha[poscodigo]))=1 then
               produto:='00000'+trim(ListaLinha[poscodigo])
            else if length(trim(ListaLinha[poscodigo]))=2 then
               produto:='0000'+trim(ListaLinha[poscodigo])
            else if length(trim(ListaLinha[poscodigo]))=3 then
               produto:='000'+trim(ListaLinha[poscodigo])
            else if length(trim(ListaLinha[poscodigo]))=4 then
               produto:='00'+trim(ListaLinha[poscodigo])
            else if length(trim(ListaLinha[poscodigo]))=5 then
               produto:='0'+trim(ListaLinha[poscodigo])
            else
               produto:=trim(ListaLinha[poscodigo]);
             }
//            referencia:=trim(referencia);
            if poscfop>0 then xcfop:=ListaLinha[poscfop] else xcfop:='';
            GravaRef:=false;

              if possubgrupo>0 then
                 conteudosubgrupo:=copy( ListaLinha[possubgrupo],1,15)
              else
                 conteudosubgrupo:='';

// 05.01.15 =�opcao de pegar o codigo q veio do arquivo do texto OU gerar pelo sac
//            if Global.Topicos[1203] then
//              produto:=FEstoque.GetProximoCodigo('estoque','esto_codigo','C');
            QEst:=sqltoquery('select esto_referencia,esto_codigo from estoque where esto_codigo='+stringtosql(produto));
//            QEst:=sqltoquery('select esto_referencia,esto_codigo from estoque where esto_referencia='+stringtosql(referencia));
            if QEst.eof then Grava:=true else Grava:=false;
            if Grava then begin

//              produto:=strzero(strtoint(referencia),6);
///////////////////////////////

              inc(incluidos);
              EdInclusos.setvalue(incluidos);

              if ListaLInha.count>02 then GravaEstoque;

//              GravaNcm;
              try
                  Sistema.Commit;
                Sistema.beginprocess('Tabela estoque codigo '+produto);
              except
                Avisoerro('N�o foi gravado na tabela estoque codigo '+produto);
              end;

///////////////////////////////
//                Avisoerro('N�o encontrado na tabela estoque codigo '+produto);

            end else begin
              produto:=QEst.fieldbyname('esto_codigo').asstring;
            end;

            qtdeestoque:=0;

            QQtd:=sqltoquery('select esqt_esto_codigo,esqt_custo,esqt_customedio from estoqueqtde '+
                             ' where esqt_esto_codigo='+stringtosql(produto)+
                             ' and esqt_unid_codigo='+stringtosql(Global.CodigoUnidade));
            if not QQtd.eof then begin
//            if QQtd.eof then begin
              inc(atualizados);

              {
              Sistema.Edit('estoque');
              Sistema.SetField('esto_unidade',ListaLInha[posunidade]);
              Sistema.Post('esto_codigo='+stringtosql(produto));
}
              custounitario:=Texttovalor( ListaLinha[posvalorcustounitario] );

              Sistema.Edit('estoqueqtde');
              Sistema.SetField('esqt_custo',custounitario);
              Sistema.SetField('esqt_custoger',custounitario);
              Sistema.SetField('esqt_customeger',custounitario);
              Sistema.SetField('esqt_customedio',custounitario);
              Sistema.SetField('esqt_qtde',Texttovalor(ListaLInha[posestoque]));
              Sistema.SetField('esqt_qtdeprev',Texttovalor(ListaLInha[posestoque]));
              Sistema.Post('esqt_esto_codigo='+stringtosql(produto)+
                           ' and esqt_unid_codigo='+stringtosql(Global.CodigoUnidade) );
{
              sqlcor:='';
              sqltamanho:='';
              if trim(Listalinha[poscor])<>''   then
                sqlcor:=' and esgr_core_codigo='+inttostr(GetCodigopelaDescricao(ListaLinha[poscor],'C') );
              if trim(ListaLinha[postamanho])<>'' then
                sqltamanho:=' and esgr_tama_codigo='+inttostr(GetCodigopelaDescricao(ListaLinha[postamanho],'T') );
// atualizar custo de acessorios 'com grade' devido a cor
              Sistema.Edit('estgrades');
              Sistema.SetField('esgr_custo',custounitario);
              Sistema.SetField('esgr_custoger',custounitario);
              Sistema.SetField('esgr_customeger',custounitario);
              Sistema.SetField('esgr_customedio',custounitario);
              Sistema.SetField('esgr_qtde',Texttovalor(ListaLInha[posestoque]));
              Sistema.SetField('esgr_qtdeprev',Texttovalor(ListaLInha[posestoque]));
              Sistema.Post('esgr_esto_codigo='+stringtosql(produto)+
                           ' and esgr_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                           sqlcor+sqltamanho );

/////////////////////////////
              }

//  usar somente quando for incluir zerando a tabela antes
{
              if ListaLinha.Count>5 then begin

                GravaEstoqueQtde;
                if posncm>0 then GravaCodigoNcm;

              end;
}

              try
                Sistema.Commit;
                Sistema.beginprocess('Atualizado Tabela estoqueqtde codigo '+produto);
              except
                Avisoerro('N�o foi gravado na tabela estoqueqtde codigo '+produto);
              end;
            //}
/////////////////////////////
//              Avisoerro('N�o foi encontrado na tabela estoqueqtde codigo '+produto);
            end else if not grava then begin
// 01.09.12
              AtualizaEstoque;
////////////////////////////////////////////////////////
{
              Sistema.Edit('estoque');
//              Sistema.SetField('esto_referencia',referencia);

//              descr:=copy(ListaLInha[0],posdescricao,50);
              descr:=ListaLInha[posdescricao];
              xx:=pos('�',descr);
              if xx>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
                descr:=copy(descr,1,xx-1)+'�'+copy(descr,xx+2,length(descr)-xx);
              xx:=pos('�',descr);
              if xx>0 then
                descr:=copy(descr,1,xx)+copy(descr,xx+2,length(descr)-xx);
             Sistema.SetField('esto_descricao',Specialcase(descr));

             Sistema.Post('esto_codigo='+Stringtosql(produto));
             }
////////////////////////////////////////////////
            end;
// cor e tamanho
            if (codcor+codtamanho) > 0 then begin
              if codcor>0 then
                Gravacor(codcor,ListaLinha[posdescor]);
              if codtamanho>0 then
                Gravatamanho(codtamanho,ListaLinha[posdestamanho]);
              if (codcor+codtamanho) > 0 then
                GravaGrade(codcor,codtamanho);
              try
                  Sistema.Commit;
                  Sistema.setmessage('Cor, tamanho e grade codigo '+produto);
              except
                  Avisoerro('N�o foi gravado na tabela cor ou tamanho ou grade codigo '+produto);
              end;
            end else begin
              try
                  Sistema.Commit;
              except
                  Avisoerro('Problemas na grava��o '+produto);
              end;
            end;
            ListaLInha.free;
          end;  // se codigo for somente numeros

        end;  // if sefa sp

        end; // for
        ListaItens.Free;
        Sistema.endprocess('Importa��o terminada. Inclu�dos='+inttostr(incluidos)+' Atualizados '+inttostr(atualizados));

  end;
end;

procedure TFDiversos.bqualtextoClick(Sender: TObject);
begin
  if not QualTexto.Execute then exit;
  EdArquivotexto.text:=QualTexto.FileName;

end;

procedure TFDiversos.RenumeraNotasSaidaPeriodo;
////////////////////////////////////////////////////
type TLista=record
     numero:integer;
     transacao:string;
end;
var QEst:TSqlquery;
    tipossaida:string;
    p,maiornota:integer;
    Lista:Tlist;
    PLista:^TLista;

begin
////////////////////////////////////////////////////
  if not Sistema.GetPeriodo('Informe periodo') then exit;
  Width:=561;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgImportaEstoque;
  EdArquivodbf.enabled:=false;
  EdArquivoTexto.enabled:=false;
  ActiveControl:=EdNumerosaFrente;
  PMens.Caption:='Renumera��o Notas';
  Caption:='Renumera��o Notas';
  bConfirmar.Visible:=True;bConfirmar.Top:=bSair.Top+25;
  wRet:=False;
  ShowModal;
  tipossaida:=Global.TiposRelVenda+';'+Global.TiposRelDevVenda;
  if wret then begin
        Lista:=Tlist.create;
        Sistema.beginprocess('Lendo notas do periodo');
        QEst:=sqltoquery('select moes_transacao,moes_numerodoc  from movesto where moes_dataemissao='+Datetosql(sistema.Datai)+
                         ' and moes_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                         ' and '+FGeral.GetIN('moes_tipomov',tipossaida,'C')+
                         ' order by moes_numerodoc');
        maiornota:=0;
        if Qest.Eof then begin
           Avisoerro('Notas n�o encontradas na unidade '+Global.CodigoUnidade);
           exit;
        end;
        while not  QEst.eof do begin
          New(PLista);
          PLista.numero:=QEst.fieldbyname('moes_numerodoc').asinteger;
          PLista.transacao:=QEst.fieldbyname('moes_transacao').asstring;
          Lista.Add(PLista);
          maiornota:=QEst.fieldbyname('moes_numerodoc').asinteger;
          QEst.Next;
        end;
        maiornota:=maiornota+EdNUmerosafrente.asinteger;
        for p:=0 to Lista.Count-1 do begin
           PLista:=LIsta[p];
           Sistema.Edit('movesto');
           Sistema.SetField('moes_numerodoc',maiornota);
           Sistema.SetField('moes_dataemissao',Sistema.Hoje);
           Sistema.SetField('moes_datamvto',Sistema.Hoje);
           Sistema.Post('moes_transacao='+Stringtosql(PLista.transacao));
           Sistema.Edit('movestoque');
           Sistema.SetField('move_numerodoc',maiornota);
           Sistema.SetField('move_datamvto',Sistema.Hoje);
           Sistema.Post('move_transacao='+Stringtosql(PLista.transacao));
           inc(maiornota);
        end;
        Sistema.beginprocess('Renumerando notas do periodo');
        try
          Sistema.Commit;
          Sistema.endprocess('Notas renumeradas');
        except
          Sistema.endprocess('Problemas na renumera��o');
        end;

  end;
end;

// 23.02.10
//////////////////////////////////////////////////
procedure TFDiversos.ImportaPlanoTexto;
//////////////////////////////////////////////////
var QEst:TSqlquery;
    ListaItens,ListaLinha,ReduzidosDoSac:TStringlist;
    p,reduzidosac,reduzidoexp,contreduzidosac:integer;
    tipoconta,classifica,descricao:string;

    function ChecaReduzido(red:integer):integer;
    var Q1:Tsqlquery;
        Sair:boolean;
        redu:integer;
    begin
       Sair:=false;
       redu:=red;
       while not Sair do begin
         Q1:=sqltoquery('select plan_conta from plano where plan_conta='+inttostr(redu));
         if not Q1.eof then
           inc(redu)
         else
           Sair:=true;
         FGeral.Fechaquery(Q1);
       end;
// checa se tem algum reduzido do Sac A SER USADO pois ainda nao foi gravado...
       while ReduzidosDoSac.IndexOf(inttostr(redu))<>-1 do begin
         inc(redu)
       end;
       result:=redu;
    end;


    procedure GravaPlano;
    begin
      Sistema.Insert('plano');
      Sistema.Setfield('plan_classificacao',classifica);
      Sistema.Setfield('plan_descricao',descricao);
      Sistema.Setfield('plan_conta',contreduzidosac);
      if tipoconta<>'S' then
        Sistema.Setfield('plan_tipo','M')
      else
        Sistema.Setfield('plan_tipo','S');
//  plan_fluxocaixa varchar(1),
      Sistema.Setfield('plan_ctaexporta01',reduzidoexp);
      Sistema.Setfield('plan_ctaexporta02',reduzidoexp);
      Sistema.Setfield('plan_ctaexporta03',reduzidoexp);
      Sistema.Setfield('plan_ctaexporta04',reduzidoexp);
      Sistema.Setfield('plan_unidexporta01','001');
      Sistema.Setfield('plan_unidexporta02','002');
      Sistema.Setfield('plan_unidexporta03','003');
      Sistema.Setfield('plan_unidexporta04','589');
//  plan_tipocad varchar(1),
//  plan_tipoativ varchar(1)
      Sistema.post;
    end;

    function GetClassifica(s:string):string;
    var posi:integer;
        Q:TSqlquery;
        cla:string;
        Sair:boolean;
    begin
       posi:=pos(' ',s);
       cla:=trim(copy(s,1,posi-1));
       cla:=FGeral.TiraBarra(cla,'.');
       Sair:=false;
       while not Sair do begin
         Q:=sqltoquery('select plan_classificacao from plano where plan_classificacao='+Stringtosql(cla));
         if Q.eof then
           sair:=true
         else
           cla:= currtostr( strtocurr(cla)+1 );
       end;
       result:=cla;
    end;

    function GetDescricao(s:string):string;
    var posi:integer;
    begin
       posi:=pos(' ',s);
       result:=trim(copy(s,posi+1,60));
    end;

begin
////////////////////////////////////////////////////
  Width:=561;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgImportaEstoque;
  EdArquivodbf.enabled:=false;
  ActiveControl:=EdArquivoTexto;
  PMens.Caption:='Importa��o Contas Gerenciais(Plano de Contas)';
  Caption:='Importa��o de Contas Gerenciais';
  bConfirmar.Visible:=True;bConfirmar.Top:=bSair.Top+25;
  wRet:=False;
  ShowModal;
  contreduzidosac:=0;
  Listaitens:=TStringlist.create;
  if wret then begin
    if not FileExists(EdArquivotexto.text) then begin
      Avisoerro('Arquivo '+EdArquivotexto.text+' n�o encontrado');
      exit;;
    end;
    if confirma('Apagar o plano atual') then begin
      Sistema.beginprocess('Apagando plano atual');
      Sistema.Conexao.ExecuteDirect('Truncate table plano');
    end;
        try
          ListaItens.LoadFromFile(EdArquivotexto.Text);
        except
          Avisoerro('N�o foi poss�vel ler arquivo '+EdArquivotexto.Text);
          exit;
        end;
        Sistema.beginprocess('Importando plano do arquivo  '+EdArquivotexto.text);
        reduzidosDoSac:=TStringList.create;
        for p:=0 to ListaItens.count-1 do begin
          ListaLInha:=TStringlist.create;
          strtolista(ListaLINha,ListaItens[p],';',true);
          if ListaLinha.Count>=4 then begin
            if reduzidosDoSac.IndexOf( trim(ListaLinha[3]) )=-1 then
              ReduzidosDoSac.Add( trim(ListaLinha[3]) );
          end;
          ListaLInha.free;
        end;
        for p:=0 to ListaItens.count-1 do begin
          ListaLInha:=TStringlist.create;
          strtolista(ListaLINha,ListaItens[p],';',true);
// ver qual 'posicao' o reduzido do plano ocupa , tipo de conta = Sint./analitica
          if ListaLinha.Count>=4 then
            reduzidosac:=strtointdef(trim(ListaLinha[3]),0)
          else
            reduzidosac:=0;
          reduzidoexp:=strtointdef(trim(ListaLinha[0]),0);
          tipoconta:=trim(ListaLinha[1]);
          classifica:=GetClassifica(ListaLinha[2]);
          descricao:=GetDescricao(ListaLinha[2]);
          contreduzidosac:=reduzidosac;
// inclui primeiro as contas analiticas com reduzido do SAC preenchido
          if contreduzidosac>0 then begin
            QEst:=sqltoquery('select * from plano where plan_conta='+inttostr(contreduzidosac));
            if QEst.eof then begin
              GravaPlano;
              try
                Sistema.Commit;
                Sistema.beginprocess('Tabela plano codigo '+inttostr(contreduzidosac));
              except
                Avisoerro('N�o foi gravado na tabela plano codigo '+inttostr(contreduzidosac));
              end;

            end else begin
              contreduzidosac:=QEst.fieldbyname('plan_conta').asinteger;
              Avisoerro('Reduzido '+inttostr(contreduzidosac)+' j� existe no plano em '+QEst.fieldbyname('plan_descricao').asstring);
            end;
          end;
          ListaLInha.free;
        end;
//  inclui o q nao tem reduzido do Sac e for sintetica
        for p:=0 to ListaItens.count-1 do begin
          ListaLInha:=TStringlist.create;
          strtolista(ListaLINha,ListaItens[p],';',true);
// ver qual 'posicao' o reduzido do plano ocupa , tipo de conta = Sint./analitica
          if ListaLinha.Count>=4 then
            reduzidosac:=strtointdef(trim(ListaLinha[3]),0)
          else
            reduzidosac:=0;
          reduzidoexp:=strtointdef(trim(ListaLinha[0]),0);
          tipoconta:=trim(ListaLinha[1]);
          classifica:=GetClassifica(ListaLinha[2]);
          descricao:=GetDescricao(ListaLinha[2]);
          inc(contreduzidosac);
          contreduzidosac:=ChecaReduzido(contreduzidosac);
          if tipoconta='S' then begin
            QEst:=sqltoquery('select * from plano where plan_conta='+inttostr(contreduzidosac));
            if QEst.eof then begin
              GravaPlano;
              try
                Sistema.Commit;
                Sistema.beginprocess('Tabela plano codigo '+inttostr(contreduzidosac));
              except
                Avisoerro('N�o foi gravado na tabela plano codigo '+inttostr(contreduzidosac));
              end;

            end else begin
              contreduzidosac:=QEst.fieldbyname('plan_conta').asinteger;
              Avisoerro('Reduzido '+inttostr(contreduzidosac)+' j� existe no plano em '+QEst.fieldbyname('plan_descricao').asstring);
            end;
          end;
          ListaLInha.free;
        end;

//////////////
        ListaItens.Free;
        Sistema.endprocess('Importa��o terminada');

  end;
end;

// 27.08.18
procedure TFDiversos.ImportaXml;
////////////////////////////////////////////////////////
var i,p,
    posdescricao,posunidade,
    posestoque,posvendaunitario,
    poscfop,posncm                           :integer;
    nometag01,nometag02,
    tagcodigo,codigo,
    tagdescricao,descricao,
    produto,desc,tagunidade,
    tagncm,referencia,xcfop,
    tagprecovenda,ncm             : string;
    Lista,
    ListaLinha              :TStringList;
    custounitario,
    vendaunitario            :currency;



    function GravaNCM:integer;
    ///////////////////
    var QNcm:TSqlquery;
        desc:string;
        x,
        xcod   :integer;
    begin

      if trim(ListaLinha[posncm])='' then exit;
      QNCm:=Sqltoquery('select * from codigosipi where cipi_codfiscal='+Stringtosql(trim(ListaLinha[posncm])) );
      if QNcm.eof then begin
        Sistema.Insert('codigosipi');
// se de erro de substr no banco de dados ver funcao getproximocodigo
        xcod :=FEstoque.GetProximoCodigo('codigosipi','cipi_codigo','N');
        Sistema.SetField( 'cipi_codigo',xcod );
        result:=xcod;
        desc:=copy(ListaLInha[posdescricao],1,50);
        x:=pos('�',desc);
        if x>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
          desc:=copy(desc,1,x-1)+'�'+copy(desc,x+2,length(desc)-x);
  //      x:=pos('�',desc);  // 241
        x:=pos('�',desc);
        if x>0 then
          desc:=copy(desc,1,x)+copy(desc,x+2,length(desc)-x);
// 29.08.18
        desc:=FGeral.TiraBarra(desc,'/') ;
        desc:=FGeral.TiraBarra(desc,'''') ;

        Sistema.SetField('cipi_descricao',Specialcase(copy(desc,2,50) ) );
        Sistema.SetField('cipi_codfiscal',ListaLinha[posncm]);
  // f. propria, % ipi e cst ipi cfe de onde importar...do sefa sp nao tem...
        Sistema.Post();

        FGeral.FechaQuery(QNCm);

      end;

    end;


    function GetCodigoNcm(xncm:string):integer;
    ///////////////////////////////
    var qNcm:TSqlquery;
    begin
      QNCm:=Sqltoquery('select * from codigosipi where cipi_codfiscal='+Stringtosql(trim(ListaLinha[posncm])) );
      if not QNcm.eof then
        result:=QNcm.fieldbyname('cipi_codigo').asinteger
      else
        result:=0;
      QNcm.Close;

    end;



    procedure gravaestoque;
    ////////////////////////
    var codigosub,
        x          :integer;

    begin
/////////////////////////////////////////////////////
      referencia := '';
      produto:=FEstoque.GetProximoCodigo('estoque','esto_codigo','C');

      codigosub:=1;
      Sistema.Insert('estoque');
      Sistema.SetField('esto_codigo',produto);
      desc :=ListaLInha[posdescricao];
      x:=pos('�',desc);
     if x>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
        desc:=copy(desc,1,x-1)+'�'+copy(desc,x+2,length(desc)-x);
//      x:=pos('�',desc);  // 241
      x:=pos('�',desc);
      if x>0 then
        desc:=copy(desc,1,x)+copy(desc,x+2,length(desc)-x);
      x:=pos('�',desc);
      if x>0 then
        desc:=copy(desc,1,x-1)+' '+copy(desc,x+2,length(desc)-x);
      x:=pos('�',desc);
      if x>0 then
        desc:=copy(desc,1,x-1)+' '+copy(desc,x+2,length(desc)-x);
      x:=pos('''',desc);
      if x>0 then
        desc:=copy(desc,1,x-1)+'"'+copy(desc,x+2,length(desc)-x);
// 29.08.18
      desc:=FGeral.TiraBarra(desc,'/') ;
      desc:=FGeral.TiraBarra(desc,'''','-') ;

      Sistema.SetField('esto_descricao',Specialcase( copy(desc,2,50) ));

      if (posunidade>0) and (trim(ListaLInha[posunidade])<>'') then
        Sistema.SetField('esto_unidade',Uppercase(ListaLInha[posunidade]))
      else
        Sistema.SetField('esto_unidade','UN');
//      Sistema.SetField('esto_codbarra').AsString:= Tabela.FieldByName('CODIRE').AsString;
      Sistema.SetField('esto_embalagem',1);
      //..ok  esto_peso numeric(10,3),
//      Sistema.SetField('esto_peso',Tabela.FieldByName('PESO').Ascurrency);
      //..ok  esto_grup_codigo numeric(6),
////      else
//      sql_tab.FieldByName('esto_sugr_codigo').AsInteger:=strtointdef(Tabela.FieldByName('SUBGRU').Asstring,0);
//      sql_tab.FieldByName('esto_fami_codigo').AsInteger:=strtointdef(Tabela.FieldByName('SECAO').AsString,0);
//      if uppercase(Tabela.FieldByName('ATIVIT').AsString)='S' then
      Sistema.SetField('esto_emlinha','S');
      Sistema.SetField('esto_usua_codigo',997);
//      Checa('G',Tabela.FieldByName('GRUPO').AsString,Tabela.FieldByName('DESGRU').AsString);
      if codigosub>0 then
        Sistema.SetField('esto_sugr_codigo',codigosub);
//campos not null...
      Sistema.SetField('esto_fami_codigo',1);
//      Sistema.SetField('esto_grup_codigo',1);
      Sistema.SetField('esto_grup_codigo',1);
      Sistema.SetField('esto_fami_codigo',1);
      Sistema.SetField('esto_REFERENCIA',trim(referencia));
// 28.08.18
      if posncm>0 then
         Sistema.SetField('esto_cipi_codigo',GEtcodigoncm(ListaLinha[posncm]) );

// 02.12.11 s� usar quando nao tiver grade...
//      Sistema.SetField('Esto_codbarra',codbarra);

      Sistema.Post();
    end;

    procedure GravaEstoqueQtde;
    ///////////////////////////
    begin
      Sistema.Insert('estoqueqtde');
      Sistema.Setfield('esqt_status','N');
      Sistema.Setfield('esqt_unid_codigo',Global.CodigoUnidade);
      Sistema.Setfield('esqt_esto_codigo',Produto);
      if posestoque>0 then begin
        Sistema.Setfield('esqt_qtde',TExttovalor(ListaLinha[posestoque]));
        Sistema.Setfield('esqt_qtdeprev',TExttovalor(ListaLinha[posestoque]));
      end else begin
        Sistema.Setfield('esqt_qtde',0);
        Sistema.Setfield('esqt_qtdeprev',0);
      end;
      custounitario:=0;
      vendaunitario:=0;
//      custounitario:=Texttovalor( copy(ListaLinha[0],posvalorcustounitario,10) );
//      custounitario:=Texttovalor( copy(ListaLinha[posvalorcustounitario],pos('$',ListaLinha[posvalorcustounitario])+1,10)  );
//      vendaunitario:=Texttovalor( copy(ListaLinha[posvalorvendaunitario],pos('$',ListaLinha[posvalorvendaunitario])+1,10)  );
//      vendaunitario:=Texttovalor( ListaLinha[posvalorvendainteira] ) +
//                     Texttovalor(ListaLinha[posvalorvendadecimal])/100;
// 02.12.11 - especifico vivan...lista com valor total da venda e nao unitario...
//      qtdvendida:=Texttovalor(ListaLinha[posqtdvenda]);
//      if qtdvendida>0 then vendaunitario:=vendaunitario/qtdvendida;
//      vendaunitario:=custounitario/0.60;
//      vendaunitario:=1;
      if posvendaunitario>0 then begin
        vendaunitario:=Texttovalor( Listalinha[posvendaunitario] );
        Sistema.Setfield('esqt_vendavis',vendaunitario);
        Sistema.Setfield('esqt_custo',custounitario);
        Sistema.Setfield('esqt_customedio',custounitario);
        Sistema.Setfield('esqt_custoger',custounitario);
        Sistema.Setfield('esqt_customeger',custounitario);
      end;
{
      Sistema.Setfield('esqt_custo',Texttovalor(ListaLInha[4]));
      Sistema.Setfield('esqt_custoger',Texttovalor(ListaLInha[4]));
      Sistema.Setfield('esqt_customedio',Texttovalor(ListaLInha[4]));
      Sistema.Setfield('esqt_customeger',Texttovalor(ListaLInha[4]));
}
{
      Sistema.Setfield('esqt_custo',EdEsto_custo.AsCurrency);
      Sistema.Setfield('esqt_custoger',EdEsto_custoger.AsCurrency);
      Sistema.Setfield('esqt_customedio',EdEsto_customedio.AsCurrency);
      Sistema.Setfield('esqt_customeger',EdEsto_customeger.AsCurrency);
      Sistema.Setfield('esqt_dtultvenda',EdEsto_dtultvenda.AsDate);
      Sistema.Setfield('esqt_dtultcompra',EdEsto_dtultcompra.AsDate);
      Sistema.Setfield('esqt_desconto',EdEsto_desconto.AsCurrency);
      Sistema.Setfield('esqt_basecomissao',EdEsto_basecomissao.AsCurrency);
}
      if poscfop>0 then begin // especifico quando tem cfop para identifcar se tem ST
        if pos(xcfop,'5405/6404')>0 then begin
          Sistema.Setfield('esqt_sitt_codestado',4);
          Sistema.Setfield('esqt_sitt_forestado',4);
        end else begin
          Sistema.Setfield('esqt_sitt_codestado',FUnidades.GetSittDentro(Global.CodigoUnidade));
          Sistema.Setfield('esqt_sitt_forestado',FUnidades.GetSittFora(Global.CodigoUnidade));
        end;
        Sistema.Setfield('esqt_cfis_codigoest',FUnidades.GetFiscalDentro(Global.CodigoUnidade) );
        Sistema.Setfield('esqt_cfis_codigoforaest',FUnidades.GetFiscalFora(Global.CodigoUnidade));
      end else begin
        Sistema.Setfield('esqt_cfis_codigoest',FUnidades.GetFiscalDentro(Global.CodigoUnidade) );
        Sistema.Setfield('esqt_cfis_codigoforaest',FUnidades.GetFiscalFora(Global.CodigoUnidade));
        Sistema.Setfield('esqt_sitt_codestado',FUnidades.GetSittDentro(Global.CodigoUnidade));
        Sistema.Setfield('esqt_sitt_forestado',FUnidades.GetSittFora(Global.CodigoUnidade));
      end;
//      Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
      Sistema.Setfield('esqt_usua_codigo',997);
//      Sistema.Setfield('esqt_vendamin',EdEsto_vendamin.AsCurrency);
//      Sistema.Setfield('esqt_pecas',EdEsto_pecas.AsFloat);
//      Sistema.Setfield('esqt_custoser',EdMobra.AsFloat);
//      Sistema.Setfield('esqt_customedioser',EdMomedio.AsFloat);
//      Sistema.Setfield('esqt_codbarra',EdEsto_codbarra.text);
      Sistema.post;

    end;


begin

  Width:=561;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgImportaEstoque;
  EdArquivodbf.enabled:=false;
  ActiveControl:=EdArquivoTexto;

  PMens.Caption:='Importa��o Cadastro do Estoque VIA XML';
  Caption:='Importa��o Cadastro do Estoque';
  bConfirmar.Visible:=True;bConfirmar.Top:=bSair.Top+25;
  wRet:=False;
  showmodal;

  if not wret then  exit;

  nometag01    :='ArrayOfProdutoSW';
  nometag02    :='ProdutoSW';
  tagcodigo    :='codProduto';
  tagdescricao :='xProd';
  tagunidade   :='uTrib';
  tagprecovenda:='vUnTrib';
  tagncm       :='NCM';

  posdescricao    :=1;
  posunidade      :=2;
  posncm          :=4;
  posvendaunitario:=3;

  XMLDocument1.FileName := EdArquivotexto.text;
  XMLDocument1.Active   := True;
  Lista:=TStringList.Create;
  Sistema.BeginProcess('Lendo arquivo');

  for I := 0 to XMLDocument1.DocumentElement.ChildNodes.Count - 1 do
  begin

     nometag01    := XMLDocument1.DocumentElement.ChildNodes[i].NodeName;
     codigo       :='9999';
     descricao    :='XXXX';
     unidade      :='XX';
     vendaunitario:=9999.99;
     ncm          :='12345678';

     //.ChildNodes[ nometag02 ].ChildNodes[ tagcodigo ].Text;
// acha tag de cada produto e le os dados
     if nometag02 = nometag01 then  begin
// percorre a tag q tem os dados do produto
        for p := 0 to XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes.Count - 1 do
        begin

           nometag01    := XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes.Nodes[p].NodeName;
           if nometag01 = tagcodigo then
      //       descricao := copy( XMLDocument1.ChildNodes[i].nometag01.ChildNodes[ nometag02 ].ChildNodes[ tagdescricao ].Text,1,50);
             codigo    := copy( XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes.Nodes[p].Text,1,20)
           else if nometag01 = tagdescricao then
             descricao := copy( XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes.Nodes[p].Text,1,50)
           else if nometag01 = tagunidade then
             unidade := copy( XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes.Nodes[p].Text,1,03)
           else if nometag01 = tagprecovenda then
             vendaunitario := Texttovalor( XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes.Nodes[p].Text )
           else if nometag01 = tagncm then
             ncm := XMLDocument1.DocumentElement.ChildNodes[i].ChildNodes.Nodes[p].Text ;

           if ( codigo<>'9999' ) and ( descricao<>'XXXX' ) and ( unidade<>'XX' ) and (vendaunitario<>9999.99)
              and ( ncm <> '12345678' )
           then begin
              Lista.Add( codigo+' ; '+descricao + ' ; '+ Unidade + ';' +
                         Fgeral.Formatavalor(vendaunitario,f_cr)+ ';' + ncm );
              break;
           end;

        end;

     end;

  end;

  SelecionaItems( Lista,'','' );

  if Lista.count>0 then begin

      if confirma('Apagar tabelas ?') then begin

          Sistema.beginprocess('Apagando tabelas do estoque');
          Sistema.Conexao.ExecuteDirect('truncate table estoque');
          Sistema.Conexao.ExecuteDirect('truncate table estoqueqtde');
          Sistema.Conexao.ExecuteDirect('truncate table codigosipi');

      end;

  end;


  for p := 0 to Lista.Count-1 do begin

     Sistema.BeginProcess('Gravando NCM');
     LIstaLInha:=TStringList.create;
     strtoLista(ListaLinha,Lista[p],';',true);
     gravancm;
     ListaLinha.Free;
     Sistema.Commit;

  end;

  for p := 0 to Lista.Count-1 do begin

     Sistema.BeginProcess('Gravando produtos '+Lista[p]);
     LIstaLInha:=TStringList.create;
     strtoLista(ListaLinha,Lista[p],';',true);
     GravaEstoque;
     GravaEstoqueqtde;
     ListaLinha.Free;
     try
       Sistema.Commit;
     except

       Aviso('N�o gravado linha '+inttostr(p)+' '+Lista[p] );

     end;

  end;

  Sistema.EndProcess('Terminado');

end;

// 26.04.11
procedure TFDiversos.CriaCodigoBarra;
///////////////////////////////////////////
type TLista=record
     codigo,codbarraatual,codbarranovo:string;
end;
var QEst:TSqlquery;
    Lista:TList;
    PLista:^TLista;
    p:integer;
    codigoempresa:integer;
    codigopais,xcodigoempresa,xcodigoproduto:string;

begin
////////////////////////////////////////////////////

  Width:=561;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgImportaEstoque;
  EdArquivodbf.enabled:=false;
  EdArquivoTexto.enabled:=false;
  EdNumerosaFrente.Enabled:=false;
  ActiveControl:=EdSobrepoe;
  PMens.Caption:='Cria��o Codigo de Barras';
  Caption:='Codigo de Barras';
  bConfirmar.Visible:=True;bConfirmar.Top:=bSair.Top+25;
  wRet:=False;
  ShowModal;

  if wret then begin

        codigoempresa:=FGeral.GetConfig1AsInteger('EMPCODBARRA');
        codigopais:=FGeral.GetConfig1AsString('Paiscodbarra');
        if codigoempresa<=0 then begin
           Avisoerro('Falta configurar codigo da empresa para codigo de barra');
           exit;
        end;
        if trim(codigopais)='' then begin
           Avisoerro('Falta configurar codigo do pais codigo de barra');
           exit;
        end;
        if length(trim(codigopais))<>3 then begin
           Avisoerro('Codigo do pais codigo de barra tem que ter 3 d�gitos');
           exit;
        end;
        Lista:=Tlist.create;
        Sistema.beginprocess('Lendo itens do estoque');
        QEst:=sqltoquery('select esto_codigo,esto_codbarra from estoque order by esto_descricao');
        if Qest.Eof then begin
           Avisoerro('N�o encontrado itens no estoque');
           exit;
        end;
        xcodigoempresa:=trim( inttostr(codigoempresa) );
        while not  QEst.eof do begin
          New(PLista);
          PLista.codigo:=QEst.fieldbyname('esto_codigo').asstring;
          PLista.codbarraatual:=QEst.fieldbyname('esto_codbarra').asstring;
          if length(xcodigoempresa)=6 then
            xcodigoproduto:=strzero( strtoint( trim(copy(PLista.codigo,1,3))) ,3 )
          else if length(xcodigoempresa)=5 then
            xcodigoproduto:=strzero( strtoint( trim(copy(PLista.codigo,1,4))) ,4 )
          else
            xcodigoproduto:=strzero( strtoint( trim(copy(PLista.codigo,1,5)))  ,5 );
          PLista.codbarranovo:=codigopais+xcodigoempresa+xcodigoproduto;
          Lista.Add(PLista);
          QEst.Next;
        end;
        for p:=0 to Lista.Count-1 do begin
           PLista:=LIsta[p];
           Sistema.Edit('estoque');
           if EdSobrepoe.Text='S' then begin
             Sistema.SetField('esto_codbarra',PLista.codbarranovo)
           end else begin
             if trim(PLista.codbarraatual)='' then
               Sistema.SetField('esto_codbarra',PLista.codbarranovo);
           end;
           Sistema.Post('esto_codigo='+Stringtosql(PLista.codigo));
           if p mod 100 = 0 then begin
              Sistema.beginprocess('Gravando a cada 100 os codigos de barra '+inttostr(p));
              try
                Sistema.Commit;
//                Sistema.endprocess('Notas renumeradas');
              except
//                Sistema.endprocess('Problemas na renumera��o');
              end;
           end;
        end;
        Sistema.beginprocess('Gravando os codigos de barra finais');
        try
          Sistema.Commit;
          Sistema.endprocess('Codigos de barra gravados');
        except
          Sistema.endprocess('Problemas na grava��o dos codigos de barra');
        end;

  end;

end;

/////////////////////////////////////////////// - 25.08.11
procedure TFDiversos.ImportaClientesTexto;
///////////////////////////////////////////////
var QEst:TSqlquery;
    fone,celular,endereco,numero,bairro,codigoibge,nomecidade,uf,cep,email,descri,fonefax,
    fonecomercial,DataAdmissao,cnpjcpf,
    separador,
    complemento,
    nomevendedor,
    linha       :string;
    p,poscodigo,posnome,posfantasia,poscnpj,posinsc,posfone,poscelular,
    incluidos,alterados,posendereco,posnumero,posbairro,poscodigoibge,posnomecidade,posUf,
    poscep,posemail,codigo,xy,posfonefax,posfonecomercial,posnascimento,poscadastro,
    codigoant,
    poscomplemento,
    poscodvendedor,
    codvendedor,
    posnomevendedor,
    numerodecolunas      :integer;
    ListaItens,ListaLinha:Tstringlist;
    DataCadastro,DataNascimento:TDatetime;


    function GetCodigoCidade(xnomecidade,xuf:string):integer;
    /////////////////////////////////////////////////////
    var Q:TSqlquery;
        codigo:integer;
    begin
        Q:=sqltoquery('select * from cidades where cida_nome='+stringtosql(xnomecidade)+
                       'and cida_uf='+Stringtosql(xuf) );
        if not Q.eof then
          codigo:=Q.fieldbyname('cida_codigo').asinteger
        else
          codigo:=999;    // para gerar erro ao testar a importacao...
        Q.close;Freeandnil(Q);
        result:=codigo;
    end;


    procedure GravaCliente;
////////////////////////////////////////////////////
    var desc,fantasia:string;x:integer;
        Qv:TSqlquery;
/////////////////////////////////////////////////////
    begin
/////////////////////////////////////////////////////
      Sistema.Insert('clientes');
      Sistema.SetField('clie_codigo',codigo);
      Sistema.SetField('clie_codigo_ant',codigoant);

      desc:=copy(ListaLInha[posnome],1,40);
      if pos('',desc)>0 then desc:=copy(ListaLInha[posnome],1,pos('',desc)-1)+' '+copy(desc,pos('',desc)-1,30);
      fantasia:=copy(ListaLInha[posfantasia],1,40);
      if pos('',fantasia)>0 then fantasia:=copy(ListaLInha[posnome],1,pos('',fantasia)-1)+' '+copy(fantasia,pos('',fantasia)-1,30);
// 19.07.18
/////////////////////////
      x:=pos('�',fantasia);
      if x>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
        fantasia:=copy(fantasia,1,x-1)+'�'+copy(fantasia,x+2,length(desc)-x);
      x:=pos('�',fantasia);
      if x>0 then
        fantasia:=copy(fantasia,1,x)+copy(fantasia,x+2,length(fantasia)-x);

/////////////
      x:=pos('�',desc);
      if x>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
        desc:=copy(desc,1,x-1)+'�'+copy(desc,x+2,length(desc)-x);
      x:=pos('�',desc);
      if x>0 then
        desc:=copy(desc,1,x)+copy(desc,x+2,length(desc)-x);
      Sistema.SetField('clie_razaosocial',Specialcase(desc));
////      if (pos('/',fantasia)>0)  SEFA SP
      if (trim(fantasia)='') then //
        Sistema.SetField('clie_nome',Specialcase(desc))
      else
        Sistema.SetField('clie_nome',Specialcase(fantasia));
      Sistema.SetField('clie_cnpjcpf', cnpjcpf);
      Sistema.SetField('clie_rgie',copy(StrtoStrDigitos(ListaLInha[posinsc]),1,20) );
      Sistema.SetField('clie_foneres',fone);
      Sistema.SetField('clie_fonecel',celular);
//      Sistema.SetField('clie_dtcad',Sistema.Hoje);
      Sistema.SetField('clie_unid_codigo',Global.CodigoUnidade);
      Sistema.SetField('clie_uf',uf);
      Sistema.SetField('clie_ipi','N');
//      if ListaLInha[1]='CPF' then
      if length(trim(StrtoStrDigitos( ListaLInha[poscnpj] ))) < 14 then begin

        Sistema.SetField('clie_tipo','F');
        Sistema.SetField('clie_contribuinte','N');
        Sistema.SetField('clie_consfinal','S');

      end else begin

        Sistema.SetField('clie_tipo','J');
        if trim( copy(StrtoStrDigitos(ListaLInha[posinsc]),1,20) ) = '' then begin

          Sistema.SetField('clie_contribuinte','N');
          Sistema.SetField('clie_consfinal','S');

        end else begin

          Sistema.SetField('clie_contribuinte','S');
          Sistema.SetField('clie_consfinal','N');

        end;

      end;
      Sistema.SetField('Clie_cepres',cep);
      Sistema.SetField('Clie_cepcom',cep);
      Sistema.SetField('Clie_email',email);
      Sistema.SetField('Clie_bairrores',bairro);
      Sistema.SetField('Clie_bairrocom',bairro);
//15.10.19
      Sistema.SetField('Clie_endrescompl',complemento);
//
      if (trim(numero)<>'') and ( strtointdef(numero,0)>0 ) then begin
        Sistema.SetField('Clie_endres',copy(trim(endereco)+','+numero,1,40));
        Sistema.SetField('Clie_endcom',copy(trim(endereco)+','+numero,1,40));
      end else begin
        Sistema.SetField('Clie_endres',copy(endereco,1,40));
        Sistema.SetField('Clie_endcom',copy(endereco,1,40));
      end;
      Sistema.SetField('Clie_cida_codigo_res',GetCodigoCidade(nomecidade,uf));
      Sistema.SetField('Clie_cida_codigo_com',GetCodigoCidade(nomecidade,uf));
// 11.06.13
      Sistema.SetField('Clie_fonecom',fonecomercial);
      Sistema.SetField('Clie_dtcad',DataCadastro);
      Sistema.SetField('Clie_dtnasc',DataNascimento);
      Sistema.SetField('Clie_fax',fonefax);

      Sistema.SetField('Clie_cidade',nomecidade);
// 16.10.19
      if codvendedor > 0 then begin

         Sistema.SetField('Clie_repr_codigo',codvendedor);

      end else

         Sistema.SetField('Clie_repr_codigo',1);

////////////////////////
      Sistema.SetField('clie_usua_codigo',998);
      Sistema.Post();

      if codvendedor > 0 then begin

         Qv:=sqltoquery('select repr_codigo from representantes where repr_codigo='+inttostr(codvendedor));
         if QV.eof then begin

            Sistema.Insert('representantes');
            Sistema.SetField('repr_codigo',codvendedor);
            Sistema.SetField('repr_nome',nomevendedor);
            Sistema.SetField('repr_razaosocial',nomevendedor);
            Sistema.SetField('repr_cida_codigo',1);
            Sistema.Post();

         end;
         QV.close;Qv.free;

      end;

    end;

    procedure AdicionaCidade;
    ////////////////////////////
    var Q:TSqlquery;
        codigo:integer;
    begin
      if trim(nomecidade)<>'' then begin
        Q:=sqltoquery('select * from cidades where cida_nome='+stringtosql(nomecidade)+
                       'and cida_uf='+Stringtosql(uf) );
        if Q.eof then begin
          codigo:=FGeral.getsequencial(1,'cida_codigo','N','cidades');
          Sistema.Insert('cidades');
          Sistema.SetField('cida_codigo',codigo);
          Sistema.SetField('cida_nome',copy(nomecidade,1,40));
          Sistema.SetField('cida_uf',uf);
          Sistema.SetField('cida_regi_codigo','001');
          Sistema.SetField('cida_codigoibge',codigoibge);;
          Sistema.post;
          try
            Sistema.Commit;
          except
            Avisoerro('Problema na cidade '+nomecidade+'|'+uf+'|'+codigoibge);
          end;
        end;
        Q.close;Freeandnil(Q);
      end;
    end;

    function GetCodigoIbgepelaUF(xuf:string):string;
    //////////////////////////////////////////////////
    var I:integer;
    begin
     result:='';
     For I := 0 to ACBrIBGE1.Cidades.Count-1 do
     begin
       with ACBrIBGE1.Cidades[I] do
       begin
          {
          Memo1.Lines.Add('Cod UF: '+IntToStr(CodUF) );
          Memo1.Lines.Add('UF: '+UF);
          Memo1.Lines.Add('Cod.Munic�pio: '+IntToStr(CodMunicio) );
          Memo1.Lines.Add('Munic�pio: '+Municipio );
          Memo1.Lines.Add('�rea: '+FormatFloat('0.00', Area) );
          }
          if xuf=trim(uf) then result:=IntToStr(CodMunicipio);
       end ;
     end ;
    end;



begin
////////////////////////////////////////////////////
  Width:=561;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgImportaEstoque;
  EdArquivodbf.enabled:=false;
  ActiveControl:=EdArquivoTexto;
  PMens.Caption:='Importa��o Cadastro de Clientes';
  Caption:='Importa��o Cadastro de Clientes';
  bConfirmar.Visible:=True;bConfirmar.Top:=bSair.Top+25;
  wRet:=False;
  ShowModal;
  if wret then begin

    if not FileExists(EdArquivotexto.text) then begin
      Avisoerro('Arquivo '+EdArquivotexto.text+' n�o encontrado');
      exit;;
    end;
        ListaItens:=TStringlist.create;
        try
          ListaItens.LoadFromFile(EdArquivotexto.Text);
        except
          Avisoerro('N�o foi poss�vel ler arquivo '+EdArquivotexto.Text);
          exit;
        end;
// vivan
{
        poscodigo:=0;
        posnome:=1;
        posfantasia:=2;
        poscnpj:=3;
        posinsc:=4;
        posfone:=5;
        poscelular:=6;
}
// SEFA/SP
{
        poscodigo:=0;
        posnome:=3;
        posfantasia:=3;
        poscnpj:=2;
        posinsc:=4;
        posfone:=16;
        poscelular:=0;
        posendereco:=6;
        posnumero:=7;
        posbairro:=9;
        poscodigoibge:=10;
        posnomecidade:=11;
        posUf:=12;
        poscep:=13;
        posemail:=17;
        separador:='|';
        }
//        }
///////////////////////////////
// 11.06.13 - Metalforte
{
        poscodigo:=0;
        posnome:=1;
        posfantasia:=2;
        poscnpj:=3;
        posinsc:=4;
        posfone:=11;
        posfonefax:=12;
        posfonecomercial:=10;
        poscelular:=13;
        posendereco:=5;
        posnumero:=0;
        posbairro:=6;
        poscodigoibge:=0;
        posnomecidade:=07;
        posUf:=08;
        poscep:=09;
        posemail:=14;
        posnascimento:=15;
        poscadastro:=16;
        }
/////////////////////////
//06.01.15 - Coorlafe Santa Maria - CoopNet
///////////////////////////////////////////////
{
        poscodigo:=0;
        posnome:=1+1;
        posfantasia:=1+1;
        poscnpj:=7+1;
        posinsc:=0;
        posfone:=0;
        posfonefax:=0;
        posfonecomercial:=0;
        poscelular:=0;
        posendereco:=11+1;
        posnumero:=0;
        posbairro:=0;
        poscodigoibge:=0;
        posnomecidade:=0;
        posUf:=0;
        poscep:=0;
        posemail:=0;
        posnascimento:=0;
        poscadastro:=20+1;
        }
//////////////////////////
/////////////////////////
//10.02.15 - Coorlafe Laranjeiras - vindo do relat. Sisleite
///////////////////////////////////////////////
{
        poscodigo:=0;
        posnome:=1;
        posfantasia:=1;
        poscnpj:=4;
        posinsc:=2;
        posfone:=7;
        posfonefax:=0;
        posfonecomercial:=0;
        poscelular:=8;
        posendereco:=5;
        posnumero:=0;
        posbairro:=6;
        poscodigoibge:=0;
        posnomecidade:=0;
        posUf:=0;
        poscep:=0;
        posemail:=0;
        posnascimento:=0;
        poscadastro:=9;
        separador:=';';
}
//////////////////////////
// 21.06.18 -  sistema 'sharp' banco acess convertido pra excel para .csv
///////////////////////////////////////////////
{
        poscodigo:=0;
        posnome:=1;
        posfantasia:=1;
        poscnpj:=3;
        posinsc:=4;
        posendereco:=5;
        poscep:=6;
        posbairro:=7;
        posnomecidade:=8;
        posUf:=09;
        posfone:=10;
        posemail:=11;
        posfonefax:=12;
        poscelular:=12;
        posnascimento:=13;

        posfonecomercial:=0;
        posnumero:=0;
        poscodigoibge:=0;
        poscadastro:=0;
        separador:=';';
}
//////////////////////////
// sistema 'nhsis' do silvano guiber loja de material de limpeza
// 14.10.19 - vindo do arquivo excel gerado pelo sitema e convertido em .CSV

        poscodigo:=0;
        posnome:=4;
        posfantasia:=5;
        poscnpj:=3;
        posinsc:=19;
        posfone:=15;
        posfonefax:=0;
        posfonecomercial:=0;
        poscelular:=0;
        posendereco:=6;
        posnumero:=7;
        posbairro:=8;
        poscodigoibge:=12;
        posnomecidade:=11;
        posUf:=13;
        poscep:=10;
        posemail:=18;
        posnascimento:=0;
        poscadastro:=0;
        poscomplemento:=9;
        poscodvendedor:=29;
        posnomevendedor:=30;
        separador:=';';


        if confirma('Apagar o cadastro de clientes ?') then begin

          Sistema.beginprocess('Apagando tabelas');
          Sistema.Conexao.ExecuteDirect('delete from clientes where clie_unid_codigo='+Stringtosql(Global.CodigoUnidade));
          Sistema.Conexao.ExecuteDirect('truncate table cidades');

        end;


////////////////////////////////////////////////////

        Sistema.beginprocess('Importando cadastro de cidades do arquivo  '+EdArquivotexto.text);
        numerodecolunas:=31;
        Memo1.Visible:=true;
        Memo1.Lines.Clear;

        for p:=0 to ListaItens.count-1 do begin

          ListaLInha:=TStringlist.create;
//          strtolista(ListaLINha,ListaItens[p],'|',true);   / SEFA SP

         linha:=FGeral.TiraBarra(ListaItens[p],'"');
          strtolista(ListaLINha,Linha,';',true);
//          if ListaLInha[0]='E' then begin  // SEFA SP

        poscodigoibge:=12;
        posnomecidade:=11;
        posUf:=13;
        poscep:=10;
        posemail:=18;
        posnascimento:=0;
        poscadastro:=0;
        poscomplemento:=9;
        poscodvendedor:=29;
        posnomevendedor:=30;
        posinsc:=19;
        posfone:=15;

          if ListaLinha.Count  <> Numerodecolunas then begin

             Memo1.Lines.add('Colunas '+inttostr(ListaLinha.Count)+'dif na linha '+inttostr(p)+'|');
             inc(posuf);
             inc(posnomecidade);
             inc(poscodigoibge);
             inc(poscomplemento);
             inc(poscodvendedor);
             inc(posnomevendedor);
             inc(posinsc);
             inc(posfone);

          end;

          if copy(ListaLInha[0],1,1)<>'X' then begin

            uf:=Uppercase( ListaLinha[posuf] );
            if poscodigoibge>0 then
              codigoibge:=ListaLinha[poscodigoibge]
            else begin
              ACbrIbge1.BuscarPorNome(copy(ListaLinha[posnomecidade],1,40));
              codigoibge:=GetCodigoIbgepelaUF(uf);
            end;
            descri:=SpecialCase( copy(ListaLinha[posnomecidade],1,40) );
            xy:=pos('�',descri);
            if xy>0 then            // no arquivo sefasp vem um caracter 'loke' a mais com �
              descri:=copy(descri,1,xy-1)+'�'+copy(descri,xy+2,length(descri)-xy);
            xy:=pos('�',descri);
            if xy>0 then
              descri:=copy(descri,1,xy)+copy(descri,xy+2,length(descri)-xy);
            nomecidade:=SpecialCase( copy(descri,1,40) );
            AdicionaCidade;
          end;
          Sistema.beginprocess('Importando cadastro de cidades do arquivo  '+EdArquivotexto.text+' '+codigoibge+' '+nomecidade);
          ListaLInha.free;

        end;

////////////////////////////////////////////////////
        Sistema.beginprocess('Importando clientes do arquivo  '+EdArquivotexto.text);

        incluidos:=0;alterados:=0;
// 21.06.18 - come�a na linha 1 para nao pegar a primeira linha q geralmente
//            ter� o cabe�alho

        for p:=1 to ListaItens.count-1 do begin

          ListaLInha:=TStringlist.create;
//          strtolista(ListaLINha,ListaItens[p],'|',true);   // SEFA SP
          strtolista(ListaLINha,ListaItens[p],separador,true);
//          if strtointdef(ListaLInha[poscodigo],0)>0 then begin

//          if ListaLInha[0]='E' then begin   // SEFA SP

//          if copy(ListaLInha[0],1,1)<>'X' then begin

          if (ListaLInha.count>=10) then begin

            if poscadastro>0 then

               DataAdmissao:=trim(ListaLinha[poscadastro])

            else

               DataAdmissao:='';

            poscodigoibge:=12;
            posnomecidade:=11;
            posUf:=13;
            poscep:=10;
            posemail:=18;
            posnascimento:=0;
            poscadastro:=0;
            poscomplemento:=9;
            poscodvendedor:=29;
            posnomevendedor:=30;
            posinsc:=19;
            posfone:=15;

          if ListaLinha.Count  <> Numerodecolunas then begin

             Memo1.Lines.add('Colunas '+inttostr(ListaLinha.Count)+'dif na linha '+inttostr(p)+'|');
             inc(posuf);
             inc(posnomecidade);
             inc(poscodigoibge);
             inc(poscomplemento);
             inc(poscodvendedor);
             inc(posnomevendedor);
             inc(posinsc);
             inc(posfone);

          end;

//          if (copy(DataAdmissao,3,1)='/') then begin
//            codigo:=ListaLInha[poscodigo];
            codigo:=FCadCli.GetProxCodigo('CLIENTES',false);
            codigoant:=strtointdef(ListaLInha[poscodigo],0);
// 15.10.19
            if (codigoant > 10000) and ( codigoant<=999999) then codigoant:=strtointdef(copy( ListaLInha[poscodigo],1,6),0)
            else if codigoant > 999999 then codigoant:=strtointdef(copy( ListaLInha[poscodigo],2,6),0);
//
            if posfone>0 then
              fone:=StrToStrDigitos( ListaLInha[posfone]  )
            else
              fone:='';
            if posfonefax>0 then
              fonefax:=StrToStrDigitos( ListaLInha[posfonefax]  )
            else
              fonefax:='';
            if posfonecomercial>0 then
              fonecomercial:=StrToStrDigitos( ListaLInha[posfonecomercial]  )
            else
              fonecomercial:='';
            if poscelular>0 then
              celular:=StrToStrDigitos( ListaLInha[poscelular]  )
            else
              celular:='';
            if posuf>0 then
              uf:=Uppercase( ListaLinha[posuf] )
            else
              uf:='PR';
            if posemail>0 then
              email:=lowercase( copy(ListaLinha[posemail],1,50) )
            else
              email:='';

//            endereco:=copy(ListaLinha[posendereco],1,pos(' - ',ListaLinha[posendereco]));
            if posendereco>0 then begin
              endereco:=ListaLinha[posendereco];
              endereco:=copy(endereco,1,40);
            end else
              endereco:='';
            if pos('�',endereco) > 0 then
              endereco:=copy( copy(endereco,1,pos('�',endereco)-1) + '�' + copy(endereco,pos('�',endereco)+1,30) ,1, 30);
            if posnumero>0 then
              numero:=ListaLinha[posnumero]
            else
              numero:='';
            if posbairro>0 then
              bairro:=copy(ListaLInha[posbairro],1,30)
            else
              bairro:='';
// 15.10.19
            if poscomplemento>0 then
//              complemento:=copy(ListaLInha[poscomplemento],1,20)
// 07.11.19 - devido a cadastro 'cagado' do silvano q algum ficava com 21 e passava pro banco
              complemento:=copy(ListaLInha[poscomplemento],1,19)
            else
              complemento:='';
            if poscodigoibge>0 then
              codigoibge:=ListaLinha[poscodigoibge]
            else
              codigoibge:='';
            if (trim(ListaLInha[posCadastro])<>'') and (poscadastro>0) then
              DataCadastro:=StrtoDate(trim(ListaLInha[posCadastro]))
            else
              DataCadastro:=Sistema.hoje;
            if (trim(ListaLInha[posNascimento])<>'') and (posnascimento>0) then
              DataNascimento:=StrtoDate(trim(ListaLInha[posNascimento]))
            else
              DataNascimento:=TexttoDate('');
            if posnomecidade>0 then
              nomecidade:=SpecialCase( copy(ListaLinha[posnomecidade],1,40) )
            else
              nomecidade:='Pato Branco';
            if poscep>0 then
              cep:=StrToStrDigitos(ListaLinha[poscep])
            else
              cep:='85501000';
            if poscnpj>0 then
              cnpjcpf:=StrtoStrDigitos( ListaLInha[poscnpj] )
            else
              cnpjcpf:='';
            if length(trim(cnpjcpf))=10 then cnpjcpf:='0'+cnpjcpf;
            if length(fone)=8 then begin
              if uf = 'SC' then
                fone:='049'+fone
              else if uf = 'SP' then
                fone:='011'+fone
              else
                fone:='046'+fone;
            end else if length(fone)=10 then
                fone:='0'+fone
// 19.07.18
            else if length(fone)=12 then
                fone:=copy(fone,1,3)+copy(fone,5,8);
///////////////////////////
            if length(fonecomercial)=8 then begin
              if uf = 'SC' then
                fonecomercial:='049'+fonecomercial
              else if uf = 'SP' then
                fonecomercial:='011'+fonecomercial
              else
                fonecomercial:='046'+fonecomercial;
            end else if length(fonecomercial)=10 then
                fonecomercial:='0'+fonecomercial;
///////////////////////////
            if length(fonefax)=8 then begin
              if uf = 'SC' then
                fonefax:='049'+fonefax
              else if uf = 'SP' then
                fonefax:='011'+fonefax
              else
                fonefax:='046'+fonefax;
            end else if length(fonefax)=10 then
                fonefax:='0'+fonefax;

// 15.10.19
            if poscodvendedor>0 then
               codvendedor := strtointdef( ListaLinha[poscodvendedor],0 )
            else
               codvendedor :=0;
            if posnomevendedor>0 then
               nomevendedor :=  ListaLinha[posnomevendedor]
            else
               nomevendedor :='';
//////////////////////////////////////
///
//            if length(celular)=8 then
//              celular:='041'+celular;
//            QEst:=sqltoquery('select clie_codigo from clientes where clie_codigo='+inttostr(codigo));
// 10.02.15
            QEst:=sqltoquery('select clie_codigo from clientes where clie_cnpjcpf='+Stringtosql(StrtoStrDigitos( ListaLInha[poscnpj])) );
            if (QEst.eof) or ( trim(ListaLInha[poscnpj])='' )  then begin

              GravaCliente;
              inc(incluidos);

            end else begin

              Aviso('Cnpj :' +ListaLInha[poscnpj]+' duplicado' );
              codigo:=QEst.fieldbyname('clie_codigo').asinteger;
              inc(alterados);
              Sistema.Edit('clientes');
              Sistema.SetField('clie_foneres',fone);
              Sistema.SetField('clie_fonecel',celular);
              Sistema.SetField('clie_dtcad',Sistema.Hoje);
              Sistema.SetField('clie_unid_codigo',Global.CodigoUnidade);
              Sistema.SetField('clie_usua_codigo',998);
              Sistema.Post('clie_codigo='+inttostr(codigo));

            end;
            QEst.Close;
            try
                Sistema.Commit;
                Sistema.beginprocess('Tabela clientes codigo '+inttostr(codigo));
//            except on E:exception do begin
            except begin
                Avisoerro('N�o foi gravado na tabela clientes codigo '+inttostr(codigo));
//                           ' Problema:'+E.Message);
            end;
            end;


          end else  Aviso('linha '+inttostr(p)+' '+ListaItens[p] );

//           else
//            aviso( ListaItens[p] );
          EdInclusos.setvalue(incluidos);
          EdAlterados.setvalue(alterados);
          ListaLInha.free;

        end;

        ListaItens.Free;
        Sistema.endprocess('Importa��o terminada');

  end;
end;

// 05.12.11
procedure TFDiversos.ConfImpressoraPadrao;
/////////////////////////////////////////////
begin
  Caption:='Configura��o Da Impressora Padr�o';
  Width:=696;Height:=155;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgImpressoraPadrao;
  EdImpressoraPadrao.Items.Clear;
  EdImpressoraPadrao.Items.Assign(GetListaImpressoras);
  EdImpressorapadrao.Text:=GetIni('SACD','Impressoras','ImpressoraPadrao');
  ActiveControl:=EdImpressoraPadrao;
  wRet:=True;
  ShowModal;
  if wRet then begin
        if Confirma('Confirma a configura��o da impressora padr�o ?') then begin
           SetIni('SACD','Impressoras','ImpressoraPadrao',EdImpressorapadrao.text);
           Aviso('Impressora padr�o configurada');
           Close;
        end;
  end;

end;

// 11.09.2021 - cria tabela passada como parametro sem duplicidade se baseadn em
//              transacao ou operacao...
procedure TFDiversos.TransacaoDuplicada(xtabela, cchave1,cchave2: string);
//////////////////////////////////////////////////////////////////////////

{
type TCampos=record
  nome,tipo:string;
  tamanho,decimais:integer;
end;
}

var QEst,QNova:TSqlquery;
    tab,tabnova,ordem,condicao,chave,chavenova,cond,chave1,chave2,chave1nova,chave2nova:string;
    p,registros,maxreg:integer;
    Lista : TStringList;
//    ListaCampos : Tlist;
//    PCampos     :^TCampos;

    function GetCampoQuery(ccampo,ctipo:string):variant;
    ////////////////////////////////////////////////////////
    begin
      if ctipo='C' then
        result:=QEst.fieldbyname( ccampo ).asstring
      else if ctipo='D' then
        result:=QEst.fieldbyname( ccampo ).asdatetime
      else if ctipo='N' then
        result:=QEst.fieldbyname( ccampo ).ascurrency
      else if ctipo='M' then
        result:=QEst.fieldbyname( ccampo ).asstring
      else
        result:=QEst.fieldbyname( ccampo ).asstring;
    end;

{
    procedure GetEstruturaTabela( xtabela:string; Cpo:Pointer );
    ////////////////////////////////////////////////////////////
    var Q:TSqlquery;
    begin

      Q:=Sqltoquery('select * from dicionario where tabela = '+Stringtosql(Uppercase(xtabela)));

      while (not Q.eof)  do begin

        New(PCampos);
        Pcampos.nome    := trim(Q.fieldbyname('campo').asstring); // character varying(30) NOT NULL,
        Pcampos.tipo    := Q.fieldbyname('tipo').asstring;   //  character varying(1),
        Pcampos.tamanho := Q.fieldbyname('tamanho').asinteger;  // numeric(5,0),
        Pcampos.decimais:= Q.fieldbyname('casasdec').asinteger; // numeric(5,0),
        ListaCampos.Add(PCampos);
        Q.Next;

      end;

      FGeral.FechaQuery(q);

    end;
}


    function TabelaExiste( xtab:string ):boolean;
    ///////////////////////////////////////////////
    begin

        Lista := TStringList.create;
        Sistema.Conexao.GetTableNames(Lista,False);
        if Lista.Indexof( xtab ) = -1 then

           result := false

        else

           result := true;

        Lista.free;

    end;


begin
////////////////////////////////////////////////////
{
  tab:='pendencias';
  tabnova:='pend';
  ordem:='pend_operacao,pend_parcela';
  chave:='pend_operacao+pend_parcela';
  chave1:='pend_operacao';
  chave2:='pend_parcela';
//  chave:=tab+'.pend_operacao'+tab+'.pend_parcela';
//  cond:='where pend_tipo_codigo in (''372'',''1203'')';
//  cond:='where pend_status <> ''C''';
  cond:='where '+FGeral.GetIN('pend_status','B;P;K','C');
  }
///////////////////////////////////////////////////////
  tab     := xtabela;
  tabnova := xtabela+'COPIA';
  if trim(cchave2) <> '' then begin

    ordem   := cchave1+','+cchave2;
//    chave   :='esqt_unid_codigo+esqt_esto_codigo';

  end else begin

    ordem   := cchave1;

  end;

  chave1  := cchave1; //'esqt_unid_codigo';
  chave2  := cchave2; //esqt_esto_codigo';

//  chave:=tab+'.pend_operacao'+tab+'.pend_parcela';
//  cond:='where pend_tipo_codigo in (''372'',''1203'')';
//  cond:='where pend_status <> ''C''';
  if uppercase(tab) = 'ESTOQUEQTDE' then

     cond := 'where '+FGeral.GetIN('esqt_status','N','C')

  else if uppercase(tab) = 'MOVESTO'  then

     cond := 'where '+FGeral.GetIN('moes_status','N','C')

  else if uppercase(tab) = 'MOVESTOQUE'  then

     cond := 'where '+FGeral.GetIN('move_status','N','C')

  else if uppercase(tab) = 'MOVBASE'  then

     cond := 'where '+FGeral.GetIN('movb_status','N','C')

        else if uppercase(tab) = 'MOVFIN'  then

           cond := 'where '+FGeral.GetIN('movf_status','N','C')

  else if uppercase(tab) = 'PENDENCIAS'  then

     cond := 'where '+FGeral.GetIN('pend_status','N;H;J;A;I;L;C','C')

  else

     cond := 'TABELA N�O PREVISTA';

   if cond = 'TABELA N�O PREVISTA' then  begin

      Avisoerro( 'Tabela '+tab+' n�o prevista. Nada ser� feito' );
      exit;

   end;

////////////////////////////////////////////////////////

//  if not Confirma('Tabela '+tab+' ser� reconstru�da.   Confirma ?') then exit;
  maxreg:=500000;
{
  Width:=561;Height:=400;
  Position        := poMainFormCenter;
  Page.ActivePage :=PgImportaEstoque;
  EdArquivodbf.enabled :=false;
  EdArquivoTexto.enabled :=false;

// ShowModal;

//  ActiveControl  := FDiversos;

  PMens.Caption:= 'Transa��es em Duplicidade';
  Caption      := 'Transa��es em Duplicidade';
    bConfirmar.Visible:=True;
    bConfirmar.Top:=bSair.Top+25;
 }

  wRet := True;

  registros:=1;
  if wret then begin

        Sistema.beginprocess('Lendo todos os registros da tabela '+tab+' condicao '+cond);

        if TabelaExiste( tabnova ) then

           ExecuteSql('truncate table '+tabnova)

        else

           ExecuteSql('create table '+tabnova+' as select * from '+tab+' where 1=2');

        QEst:=sqltoquery('select * from '+tab+' '+cond+
                         ' order by '+ordem);
        if Qest.Eof then begin

           Avisoerro('N�o encontrado registros na tabela '+tab);
           exit;

        end;

        New(PCampos);
        ListaCampos:=TList.create;
        GetEstruturaTabela( tab,PCampos );

        while not  QEst.eof do begin

           chave1nova:=Stringtosql( QEst.fieldbyname( chave1 ).asstring );
           if trim(cchave2) <> '' then begin

              chave2nova:=Stringtosql( QEst.Fieldbyname( chave2 ).asstring );
              condicao:=chave1+' = '+chave1nova+' and '+chave2+' = '+chave2nova;

           end else begin

              chave2nova := '';
              condicao   := chave1+' = '+chave1nova;

           end;
           QNova:=Sqltoquery('select '+chave1nova+' from '+tabnova+' where '+condicao );
           if QNova.eof then begin

             Sistema.Insert( tabnova );
             for p:=0 to LIstaCampos.Count-1 do begin

               PCampos:=ListaCampos[p];
               Sistema.SetField( Pcampos.nome, GetCampoQuery( PCampos.nome,PCampos.tipo  ));

             end;

             Sistema.Post('');
//             //if registros div 500 = 0 then begin
                Sistema.beginprocess('Criando nova tabela '+tabnova+' registro '+inttostr(registros));
                try
                  Sistema.Commit;
                  inc(registros);
  //                Sistema.endprocess('Notas renumeradas');
                except
                  Sistema.endprocess('Problemas no commit');
                end;
//             //end;
           end;
           FGeral.FechaQuery(QNova);
           QEst.Next;
           if registros>MaxReg then break;

        end;
/////////////////
        FGeral.FechaQuery(QEst);
        ListaCampos.free;
        Sistema.endprocess('Tabela '+tabnova+' criada com '+inttostr(registros)+' registros');

/////////////////////////////////////////////////////////////////////////////////////
{
//        cond:='where '+FGeral.GetIN('pend_status','N;H;J;A;I;L;C','C');
//        cond:='where '+FGeral.GetIN('esqt_status','N','C');
        if uppercase(tab) = 'ESTOQUEQTDE' then

           cond := 'where '+FGeral.GetIN('esqt_status','N','C')

        else if uppercase(tab) = 'MOVESTO'  then

           cond := 'where '+FGeral.GetIN('moes_status','N','C')

        else if uppercase(tab) = 'MOVESTOQUE'  then

           cond := 'where '+FGeral.GetIN('move_status','N','C')

        else if uppercase(tab) = 'MOVBASE'  then

           cond := 'where '+FGeral.GetIN('movb_status','N','C')

        else if uppercase(tab) = 'MOVFIN'  then

           cond := 'where '+FGeral.GetIN('movf_status','N','C')

        else if uppercase(tab) = 'PENDENCIAS'  then

           cond := 'where '+FGeral.GetIN('pend_status','N;H;J;A;I;L;C','C');


        Sistema.beginprocess('Lendo todos os registros da tabela '+tab+' condicao '+cond);

        QEst:=sqltoquery('select * from '+tab+' '+cond+
                         ' order by '+ordem);
        if Qest.Eof then begin

           Avisoerro('N�o encontrado registros na tabela '+tab);
           exit;

        end;
        New(PCampos);
        ListaCampos:=TList.create;
        GetEstruturaTabela( tab,PCampos );

        while not  QEst.eof do begin

           chave1nova:=Stringtosql( QEst.fieldbyname( chave1 ).asstring );

           if trim(cchave2) <> '' then begin

             chave2nova:=Stringtosql( QEst.Fieldbyname(chave2).asstring );
             condicao:=chave1+' = '+chave1nova+' and '+chave2+' = '+chave2nova;

           end else begin

             chave2nova := '';
             condicao   :=chave1+' = '+chave1nova;

           end;
           QNova:=Sqltoquery('select '+chave1nova+' from '+tabnova+' where '+condicao );
           if QNova.eof then begin

             Sistema.Insert( tabnova );
             for p:=0 to LIstaCampos.Count-1 do begin

               PCampos:=ListaCampos[p];
               Sistema.SetField( Pcampos.nome, GetCampoQuery( PCampos.nome,PCampos.tipo  ));

             end;

             Sistema.Post('');
//             //if registros div 500 = 0 then begin
                Sistema.beginprocess('Criando nova tabela '+tabnova+' registro '+inttostr(registros));
                try
                  Sistema.Commit;
                  inc(registros);
  //                Sistema.endprocess('Notas renumeradas');
                except
                  Sistema.endprocess('Problemas no commit');
                end;
//             //end;
           end;
           FGeral.FechaQuery(QNova);
           QEst.Next;
           if registros>MaxReg then break;

        end;

        }
/////////////////////////////////////////////////////////////////////////////////////

//        Sistema.Commit;

  end;

//  close;

end;




// 11.05.13 - cria tabela sem duplicidade
procedure TFDiversos.TransacoesDuplicadas;
////////////////////////////////////////////////
var QEst,QNova:TSqlquery;
    tab,tabnova,ordem,condicao,chave,chavenova,cond,chave1,chave2,chave1nova,chave2nova:string;
    p,registros,maxreg:integer;

    function GetCampoQuery(ccampo,ctipo:string):variant;
    ////////////////////////////////////////////////////////
    begin
      if ctipo='C' then
        result:=QEst.fieldbyname( ccampo ).asstring
      else if ctipo='D' then
        result:=QEst.fieldbyname( ccampo ).asdatetime
      else if ctipo='N' then
        result:=QEst.fieldbyname( ccampo ).ascurrency
      else if ctipo='M' then
        result:=QEst.fieldbyname( ccampo ).asstring
      else
        result:=QEst.fieldbyname( ccampo ).asstring;
    end;

begin
////////////////////////////////////////////////////
{
  tab:='pendencias';
  tabnova:='pend';
  ordem:='pend_operacao,pend_parcela';
  chave:='pend_operacao+pend_parcela';
  chave1:='pend_operacao';
  chave2:='pend_parcela';
//  chave:=tab+'.pend_operacao'+tab+'.pend_parcela';
//  cond:='where pend_tipo_codigo in (''372'',''1203'')';
//  cond:='where pend_status <> ''C''';
  cond:='where '+FGeral.GetIN('pend_status','B;P;K','C');
  }
///////////////////////////////////////////////////////
  tab := 'estoqueqtde';
  tabnova:='estqtd';
  ordem:='esqt_unid_codigo,esqt_esto_codigo';
  chave:='esqt_unid_codigo+esqt_esto_codigo';
  chave1:='esqt_unid_codigo';
  chave2:='esqt_esto_codigo';
//  chave:=tab+'.pend_operacao'+tab+'.pend_parcela';
//  cond:='where pend_tipo_codigo in (''372'',''1203'')';
//  cond:='where pend_status <> ''C''';
  cond:='where '+FGeral.GetIN('esqt_status','N','C');

////////////////////////////////////////////////////////

  if not Confirma('Tabela '+tab+' ser� reconstru�da.   Confirma ?') then exit;
  maxreg:=500000;
  Width:=561;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgImportaEstoque;
  EdArquivodbf.enabled:=false;
  EdArquivoTexto.enabled:=false;
  ActiveControl:=EdNumerosaFrente;
  PMens.Caption:='Transa��es Duplicadas';
  Caption:='Transa��es Duplicadas';
  bConfirmar.Visible:=True;bConfirmar.Top:=bSair.Top+25;
  wRet:=False;
  ShowModal;
  registros:=1;
  if wret then begin

        Sistema.beginprocess('Lendo todos os registros da tabela '+tab+' condicao '+cond);
        if confirma('Zerar tabela '+tabnova) then
          ExecuteSql('truncate table '+tabnova);
        QEst:=sqltoquery('select * from '+tab+' '+cond+
                         ' order by '+ordem);
        if Qest.Eof then begin
           Avisoerro('N�o encontrado registros na tabela '+tab);
           exit;
        end;
        New(PCampos);
        ListaCampos:=TList.create;
        GetEstruturaTabela( tab,PCampos );

        while not  QEst.eof do begin

           chave1nova:=Stringtosql( QEst.fieldbyname( chave1 ).asstring );
           chave2nova:=Stringtosql( QEst.Fieldbyname(chave2).asstring );
           condicao:=chave1+' = '+chave1nova+' and '+chave2+' = '+chave2nova;
           QNova:=Sqltoquery('select '+chave1nova+' from '+tabnova+' where '+condicao );
           if QNova.eof then begin
             Sistema.Insert( tabnova );
             for p:=0 to LIstaCampos.Count-1 do begin
               PCampos:=ListaCampos[p];
               Sistema.SetField( Pcampos.nome, GetCampoQuery( PCampos.nome,PCampos.tipo  ));
             end;
             Sistema.Post('');
//             //if registros div 500 = 0 then begin
                Sistema.beginprocess('Criando nova tabela '+tabnova+' registro '+inttostr(registros));
                try
                  Sistema.Commit;
                  inc(registros);
  //                Sistema.endprocess('Notas renumeradas');
                except
                  Sistema.endprocess('Problemas no commit');
                end;
//             //end;
           end;
           FGeral.FechaQuery(QNova);
           QEst.Next;
           if registros>MaxReg then break;
        end;
/////////////////
        FGeral.FechaQuery(QEst);

//        cond:='where '+FGeral.GetIN('pend_status','N;H;J;A;I;L;C','C');
        cond:='where '+FGeral.GetIN('esqt_status','N','C');

        Sistema.beginprocess('Lendo todos os registros da tabela '+tab+' condicao '+cond);
//        if confirma('Zerar tabela '+tabnova) then
//          ExecuteSql('truncate table '+tabnova);
        QEst:=sqltoquery('select * from '+tab+' '+cond+
                         ' order by '+ordem);
        if Qest.Eof then begin
           Avisoerro('N�o encontrado registros na tabela '+tab);
           exit;
        end;
        New(PCampos);
        ListaCampos:=TList.create;
        GetEstruturaTabela( tab,PCampos );
        while not  QEst.eof do begin

           chave1nova:=Stringtosql( QEst.fieldbyname( chave1 ).asstring );
           chave2nova:=Stringtosql( QEst.Fieldbyname(chave2).asstring );
           condicao:=chave1+' = '+chave1nova+' and '+chave2+' = '+chave2nova;
           QNova:=Sqltoquery('select '+chave1nova+' from '+tabnova+' where '+condicao );
           if QNova.eof then begin
             Sistema.Insert( tabnova );
             for p:=0 to LIstaCampos.Count-1 do begin
               PCampos:=ListaCampos[p];
               Sistema.SetField( Pcampos.nome, GetCampoQuery( PCampos.nome,PCampos.tipo  ));
             end;
             Sistema.Post('');
//             //if registros div 500 = 0 then begin
                Sistema.beginprocess('Criando nova tabela '+tabnova+' registro '+inttostr(registros));
                try
                  Sistema.Commit;
                  inc(registros);
  //                Sistema.endprocess('Notas renumeradas');
                except
                  Sistema.endprocess('Problemas no commit');
                end;
//             //end;
           end;
           FGeral.FechaQuery(QNova);
           QEst.Next;
           if registros>MaxReg then break;
        end;

//        Sistema.Commit;
        Sistema.endprocess('Tabela '+tabnova+' criada com '+inttostr(registros)+' registros');
        FGeral.FechaQuery(QEst);
  end;
end;

// 13.05.13
procedure TFDiversos.GetEstruturaTabela( xtabela:string; Cpo:Pointer );
////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

  Q:=Sqltoquery('select * from dicionario where tabela = '+Stringtosql(Uppercase(xtabela)));

  while (not Q.eof)  do begin

    New(PCampos);
    Pcampos.nome    := trim(Q.fieldbyname('campo').asstring); // character varying(30) NOT NULL,
    Pcampos.tipo    := Q.fieldbyname('tipo').asstring;   //  character varying(1),
    Pcampos.tamanho := Q.fieldbyname('tamanho').asinteger;  // numeric(5,0),
    Pcampos.decimais:= Q.fieldbyname('casasdec').asinteger; // numeric(5,0),
    ListaCampos.Add(PCampos);
    Q.Next;

  end;

  FGeral.FechaQuery(q);

end;



procedure TFDiversos.ACBrIBGE1BuscaEfetuada(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
  if ACBrIBGE1.Cidades.Count < 1 then
     Avisoerro( 'Nenhuma Cidade encontrada' )
  else
   begin
//     Memo1.Lines.Add( IntToStr(ACBrIBGE1.Cidades.Count) + ' Cidade(s) encontrada(s)');
{
     For I := 0 to ACBrIBGE1.Cidades.Count-1 do
     begin
       with ACBrIBGE1.Cidades[I] do
       begin
          {
          Memo1.Lines.Add('Cod UF: '+IntToStr(CodUF) );
          Memo1.Lines.Add('UF: '+UF);
          Memo1.Lines.Add('Cod.Munic�pio: '+IntToStr(CodMunicio) );
          Memo1.Lines.Add('Munic�pio: '+Municipio );
          Memo1.Lines.Add('�rea: '+FormatFloat('0.00', Area) );
       end ;
     end ;
}
   end ;
//  Aviso('Resposta HTTP:'+ACBrIBGE1.RespHTTP.GetText );
end;

// 19.06.13
procedure TFDiversos.ImportaAReceberTexto;
//////////////////////////////////////////
var  ListaItens,ListaLInha:TStringlist;
     p,poscodigo,posnumerodoc,posemissao,posvalortotaltitulo,posvaloraberto,posvencimento:integer;
     recpag,transacao,operacao,tipocad,condicao,complemento:string;
     codigo,numerodoc,parcela,posfinalnumerodoc:integer;
     emissao,vencimento,movimento:Tdatetime;
     valortotaltitulo,valoraberto:currency;

     procedure GravaPendencia(xrecpag:string);
     /////////////////////////////////////////
     begin
//        Transacao:=Global.CodigoUnidade+strzero(p,5);
        Transacao:=Global.CodigoUnidade+strzero(numerodoc,6)+strzero(parcela,2);
        Operacao:=Transacao+'1';
        Sistema.Insert('Pendencias');
        Sistema.SetField('Pend_Transacao',Transacao);
        Sistema.SetField('Pend_Operacao',Operacao);
        Sistema.SetField('Pend_Status','N');
        Sistema.SetField('Pend_DataLcto',Sistema.Hoje);
        Sistema.SetField('Pend_DataMvto',Movimento);
        Sistema.SetField('Pend_DataCont',Movimento);
        Sistema.SetField('Pend_DataVcto',Vencimento);
        Sistema.SetField('pend_datavctoori',Vencimento);
        Sistema.SetField('Pend_DataEmissao',Emissao);
        Sistema.SetField('Pend_Plan_Conta',159);  // not null
        Sistema.SetField('Pend_Tipo_Codigo',Codigo );
        Sistema.SetField('Pend_TipoCad'    ,Tipocad);
        Sistema.SetField('Pend_Unid_Codigo',Global.CodigoUnidade);
        Sistema.SetField('Pend_Fpgt_Codigo',Condicao);
//        Sistema.SetField('Pend_Port_Codigo',Portador);
//        Sistema.SetField('Pend_Hist_Codigo',Global.VCHist);
//        Sistema.SetField('Pend_Moed_Codigo','');
        Sistema.SetField('Pend_Repr_Codigo','001');
        Sistema.SetField('Pend_Complemento',complemento);
        Sistema.SetField('Pend_NumeroDcto',Numerodoc);
        Sistema.SetField('Pend_Parcela',parcela);
        Sistema.SetField('Pend_NParcelas',parcela);
        Sistema.SetField('Pend_RP',xrecpag);
        Sistema.SetField('Pend_Valor',valoraberto);
        Sistema.SetField('Pend_ValorTitulo',valortotaltitulo);

       Sistema.Post();
       Sistema.Commit;
     end;

begin
/////////
  Width:=561;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgImportaEstoque;
  EdArquivodbf.enabled:=false;
  ActiveControl:=EdArquivoTexto;
  PMens.Caption:='Importa��o Contas a Receber';
  Caption:='Importa��o Contas a Receber';
  bConfirmar.Visible:=True;bConfirmar.Top:=bSair.Top+25;
  wRet:=False;
  ShowModal;
  if wret then begin
    if not FileExists(EdArquivotexto.text) then begin
      Avisoerro('Arquivo '+EdArquivotexto.text+' n�o encontrado');
      exit;;
    end;
        ListaItens:=TStringlist.create;
        try
          ListaItens.LoadFromFile(EdArquivotexto.Text);
        except
          Avisoerro('N�o foi poss�vel ler arquivo '+EdArquivotexto.Text);
          exit;
        end;
        if confirma('Apagar a tabela de pendencias ?') then begin
          Sistema.beginprocess('Apagando tabelas');
          Sistema.Conexao.ExecuteDirect('truncate table pendencias');
        end;

// Metalforte
////////////////
        if pos('RECEBER',Uppercase(EdArquivotexto.Text))>0 then begin
          recpag:='R';
          poscodigo:=106;
          posnumerodoc:=2;
          posemissao:=38;
          posvalortotaltitulo:=71;
          posvaloraberto:=101;
          posvencimento:=20;
        end else begin
          recpag:='P';
          poscodigo:=57;
          posnumerodoc:=3;
          posemissao:=38;
          posvalortotaltitulo:=74;
          posvaloraberto:=102;
          posvencimento:=20;
        end;
        p:=0;
        complemento:='Importado via SAC';
        tipocad:='C';
        Movimento:=Sistema.hoje;
        condicao:='001';
        Sistema.beginprocess('Percorrendo arquivo');
        while p <= LIstaItens.Count-1 do begin
          if ( pos('/',copy(ListaItens[p],4,16)) > 0 ) and ( pos('Parcela',ListaItens[p]) = 0 ) then begin
            posfinalnumerodoc:=pos('/',ListaItens[p])-1;
            Sistema.beginprocess( 'Linha '+inttostr(p)+' | '+ListaItens[p] );
            ListaLInha:=TStringlist.create;
            strtolista(ListaLINha,ListaItens[p],';',true);
            codigo:=strtointdef( trim(copy(ListaLinha[0],poscodigo,6)),0 );
            if codigo=0 then begin
              Aviso('Codigo 0 '+ListaLinha[0]);
              Application.terminate;
            end;
            if posfinalnumerodoc-posnumerodoc>09 then
              numerodoc:=strtointdef( trim(copy(ListaLinha[0],posnumerodoc,09)),0 )
            else
              numerodoc:=strtointdef( trim(copy(ListaLinha[0],posnumerodoc,posfinalnumerodoc-posnumerodoc)),0 );
            if numerodoc=0 then begin
//              numerodoc:=strtostr( trim(copy(ListaLinha[0],posnumerodoc,4)),0 );
              numerodoc:=Strtointdef( StrToStrNumeros(copy(ListaLinha[0],posnumerodoc,posfinalnumerodoc-posnumerodoc)), 0);
              if numerodoc=0 then begin
                Aviso('Numerodoc '+ListaLinha[0]);
                Application.terminate;
              end;
            end;
            Parcela:=strtointdef( trim(copy(ListaLInha[0],pos('/',ListaItens[p])+1,02)) ,0);
            if parcela=0 then begin
//              Aviso('Parcela '+ListaLinha[0]);
//              Application.terminate;
               parcela:=1;
            end;
            if trim( copy(ListaLInha[0],posemissao,10) ) <>'' then
              Emissao:=StrtoDate( copy(ListaLInha[0],posemissao,10) )
            else
              Emissao:=TexttoDate('');
            if trim( copy(ListaLInha[0],posVencimento,10) ) <>'' then
              Vencimento:=StrtoDate( copy(ListaLInha[0],posVencimento,10) )
            else
              Vencimento:=TexttoDate('');
            if recpag='R' then
              p:=p+3
            else
              p:=p+1;
            ListaLinha.Clear;
            strtolista(ListaLINha,ListaItens[p],';',true);
            valortotaltitulo:=TexttoValor( copy(ListaLinha[0],posvalortotaltitulo,10) );
            valoraberto:=TexttoValor( copy(ListaLinha[0],posvaloraberto,10) );
            Sistema.beginprocess('Vencimento '+FGeral.FormataData(vencimento));
            gravapendencia(recpag);
          end;
          inc(p);
        end;
        Sistema.endprocess('Terminado');

  end;

end;

// 30.10.14
procedure TFDiversos.EdFiltroExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////
var xsql,cond,servidor:string;
begin
{
  if not Confirma('Confirma exporta��o ?') then exit;
   Sistema.beginprocess('Gerando script');
   servidor:=GetIni('SACD','Config','EnderecoServidor');
   if  Cadastro='estoque' then begin
     if EdFiltro.IsEmpty then cond:='order by esto_descricao' else
     cond:='where '+FGeral.GetIN('esto_grup_codigo',EdFiltro.Text,'N')+' order by esto_descricao';
     xsql:='create table estoquetemp as select * from estoque '+cond;
     Sistema.Conexao.ExecuteDirect(xsql) ;
//       pg_dump.exe --host localhost --port 5432 --username postgres --format plain --column-inserts --verbose --file "C:\BaseDadosAndroid\teste.sql" --table public.estoque sacgiacomoni
       winexec( pchar('cmd /c pg_dump.exe --host '+servidor+' --port 5432 --username postgres --format plain --column-inserts --file scriptestoque.sql --table estoque sacgiacomoni'), SW_HIDE);
   end;
   Sistema.EndProcess('Terminado');
}
end;

procedure TFDiversos.btexportarClick(Sender: TObject);
//////////////////////////////////////////////////////////
var xsql,cond,servidor,xpath,arquivo,arquivofinal,xdrive,arquivodestino,
    arquivofinal01,nomebanco,
    PastaSac,
    PastaMovel,
    nomecidade,
    nomecliente,
    razaosocial,
    xclie_endres,
    xclie_endcom      :string;
    Lista,ListaFinal :TStringList;
    p,i:integer;
    encode:TEncoding;
    arqimp:TextFile;
    Q: TSqlquery;

begin

   if not Confirma('Confirma exporta��o ?') then exit;

   pastamovel:=FGeral.GetConfig1AsString('pastachecaped');
   if trim( pastamovel )<>'' then pastamovel:=pastamovel+'\';

   PastaSac:=ExtractFilePath( application.ExeName ) ;
                                                                                                    ;
   xdrive:= copy( pastasac,1,2 );

   xpath:=xdrive+'\Program Files (x86)\PostgreSQL\8.4\bin\';
   if not FileExists(xpath+'pg_dump.exe') then  xpath:=xdrive+'\Program Files\PostgreSQL\8.4\bin\';
   if not FileExists(xpath+'pg_dump.exe') then  xpath:=xdrive+'\PostgreSQL\9.3\bin\';
// if not FileExists(xpath+'pg_dump.exe') then  xpath:=xdrive+'\Program Files (x86)\PostgreSQL\9.6\bin\';
   if not FileExists(xpath+'pg_dump.exe') then  xpath:=xdrive+'\Program Files (x86)\PostgreSQL\9.4\bin\';
   if not FileExists(xpath+'pg_dump.exe') then  xpath:=xdrive+'\Program Files\PostgreSQL\9.3\bin\';
   if not FileExists(xpath+'pg_dump.exe') then  xpath:=xdrive+'\Program Files\PostgreSQL\9.6\bin\';
// 15.09.2021
   if not FileExists(xpath+'pg_dump.exe') then  xpath:=xdrive+'\Program Files\PostgreSQL\12\bin\';
   if not FileExists(xpath+'pg_dump.exe') then  xpath:=PastaSac;
   if not FileExists(xpath+'pg_dump.exe') then begin
        Avisoerro('N�o encontrado pg_dump.exe em '+xpath);
        Sistema.EndProcess('');
        exit;
   end;

  xpath:=trim(copy(xpath,3,100));
  Sistema.beginprocess('Gerando script de '+cadastro+' usando path '+xpath);

   servidor:=GetIni('SACD','Config','EnderecoServidor');
   nomebanco:=LowerCase( GetIni('SACD','Config','NomeBanco') );

   if  Cadastro='estoque' then begin

     if EdFiltro.IsEmpty then cond:='order by esto_descricao'
     else cond:='where '+FGeral.GetIN('esto_grup_codigo',EdFiltro.Text,'N')+' order by esto_descricao';
     try
       xsql:='drop table estoquetemp';
       Sistema.Conexao.ExecuteDirect(xsql) ;
     except
     end;
     xsql:='create table estoquetemp as select * from estoque '+cond;
     Sistema.Conexao.ExecuteDirect(xsql) ;
// 02.05.20
     Q := sqltoquery('select esto_descricao,esto_codigo from estoquetemp');
     while not Q.eof do begin

        Sistema.Edit('estoquetemp');
        Sistema.SetField('esto_descricao',Sac( Q.FieldByName('esto_descricao').AsString ));
        Sistema.Post('esto_codigo = '+Stringtosql(Q.FieldByName('esto_codigo').AsString));
        Sistema.Commit;

        Q.next;

     end;
     FGeral.FechaQuery(Q);

//       pg_dump.exe --host localhost --port 5432 --username postgres --format plain --column-inserts --verbose --file "C:\BaseDadosAndroid\teste.sql" --table public.estoque sacgiacomoni
//     winexec( pchar('cmd /c '+xpath+'pg_dump.exe --host '+servidor+' --port 5432 --username postgres --format plain --column-inserts --file c:\sac\scriptestoque.sql --table estoque sacgiacomoni'), SW_SHOW);
     arquivo:=PastaSac+PastaMovel+'scripttempproduto.sql';
     arquivofinal:=PastaSac+PastaMovel+'scriptproduto.sql';
     arquivofinal01:=PastaSac+'scriptproduto.sql';
     arquivodestino:='scriptproduto.sql';
//     winexec( pchar(xpath+'pg_dump.exe --host '+servidor+' --port 5432 --username postgres --format plain --column-inserts --file \sac\scripttempestoque.sql --table estoque sac'), SW_SHOWNORMAL);
//     winexec( pansichar(xpath+'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username postgres --format plain --column-inserts --file \sac\scripttempproduto.sql --table estoquetemp sac'), SW_Hide);
//     Delay(1000);
// 19.04.17
     if not FileExists( ExtractFilePath(Application.ExeName)+'EXPEST.BAT' ) then begin
       AssignFile ( arqimp,ExtractFilePath(Application.ExeName)+'EXPEST.BAT' );
       Rewrite ( arqimp );
       Writeln ( arqimp, 'CD'+xpath );
       Writeln ( arqimp,'set PGPASSWORD=sacd35269147' );
//       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "sac" --no-password  --format plain -C --column-inserts --file "\sac\scripttempproduto.sql" --table estoquetemp '+nomebanco );
// 15.09.2021
       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "sac" --no-password --format plain -C --column-inserts --file "'+pastasac+pastamovel+'scripttempproduto.sql" --table estoquetemp '+nomebanco );
       CloseFile( arqimp );

     end;

     if  ShellExecute(handle,'open',PChar('ExpEst.bat'), '',PChar(ExtractFilePath(Application.ExeName)),SW_HIDE) <= 32 then
         Avisoerro('Erro no shellExecute do ExpEst.bat');
     Delay(2000);

   end else if  Cadastro='portadores' then begin
{
     try
       xsql:='drop table portadorestemp';
       Sistema.Conexao.ExecuteDirect(xsql) ;
     except
     end;
     xsql:='create table portadorestemp as select * from portadores order by port_descricao';
     Sistema.Conexao.ExecuteDirect(xsql) ;
}
     arquivo       :=PastaSac+PastaMovel+'scripttempportadores.sql';
     arquivofinal  :=PastaSac+PastaMovel+'scriptportadores.sql';
     arquivofinal01:=PastaSac+'scriptportadores.sql';
     arquivodestino:='scriptportadores.sql';
//     winexec( pansichar(xpath+'pg_dump.exe --host '+servidor+' --port 5432 --username postgres --format plain --column-inserts --file \sac\scripttempestoque.sql --table estoque sac'), SW_SHOWNORMAL);
//     winexec( pansichar(xpath+'pg_dump.exe --host '+servidor+' --encoding=utf-8 --port 5432 --username postgres --format plain --column-inserts --file \sac\scripttempportadores.sql --table portadores sac'), SW_Hide);
     if not FileExists( ExtractFilePath(Application.ExeName)+'EXPPOR.BAT' ) then begin

       AssignFile ( arqimp,ExtractFilePath(Application.ExeName)+'EXPPOR.BAT' );
       Rewrite ( arqimp );
       Writeln ( arqimp, 'CD'+xpath );
//       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "postgres" --no-password  --format plain -C --column-inserts --file "\sac\scripttempportadores.sql" --table portadores '+nomebanco );
       Writeln ( arqimp, 'SET PGPASSWORD=sacd35269147' );
//       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "sac" --format plain -C --column-inserts --file "\sac\scripttempportadores.sql" --table portadores '+nomebanco );
// 15.09.2021
       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "sac" --format plain -C --column-inserts --file "'+pastasac+pastamovel+'scripttempportadores.sql" --table portadores '+nomebanco );

       CloseFile ( arqimp );

     end;

     if  ShellExecute(handle,'open',PChar('ExpPor.bat'), '',PChar(ExtractFilePath(Application.ExeName)),SW_HIDE) <= 32 then
         Avisoerro('Erro no shellExecute do ExpPor.bat');
     Delay(2000);

   end else if  Cadastro='clientes' then begin

     arquivo:=PastaSac+PastaMovel+'scripttempcliente.sql';
     arquivofinal:=PastaSac+PastaMovel+'scriptcliente.sql';
     arquivofinal01:=PastaSac+'scriptcliente.sql';
     arquivodestino:='scriptcliente.sql';
// 04.05.20
     xsql := 'drop table clientestemp';
     try
       xsql:='drop table clientestemp';
       Sistema.Conexao.ExecuteDirect(xsql) ;
     except
     end;
     xsql:='create table clientestemp as select clie_codigo,clie_nome,clie_cida_codigo_res,'+
           'clie_cidade,clie_razaosocial,clie_endres,clie_endcom,clie_rgie,clie_cnpjcpf,'+
           'clie_repr_codigo,clie_fpgt_codigo,clie_cepres,clie_cepcom,clie_bairrores,'+
           'clie_bairrocom,clie_obs'+
//           ' from clientes where clie_nome is not null order by clie_nome ';
           ' from clientes where clie_nome<>'''''+
//           ' and substr(clie_nome,1,1) = ''A'''+
           ' order by clie_nome ';
     Sistema.Conexao.ExecuteDirect(xsql) ;

//     showmessage( xpath+'|'+servidor+'|'+arquivo   );

   // winexec( pansichar(xpath+'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "postgres" --no-password --format plain --file "\sac\scripttempcliente.sql" --table "clientes" "sac"'), SW_show);

 //    ShellExecute(0,nil,PChar('"'+xpath+'"pg_dump.exe'),  PChar ('-- host "'+servidor+'" --username postgresl format plain -- file \sac\scripttempcliente.sql table clientes sac' ), nil, sw_show);
// 04.05.20
     Q := sqltoquery('select * from clientestemp');
     while not Q.eof do begin

        nomecliente := copy(Q.FieldByName('clie_nome').AsString,1,50);
        razaosocial := copy(Q.FieldByName('clie_razaosocial').AsString,1,50);
        xclie_endres := copy(Q.FieldByName('clie_endres').AsString,1,39);
        xclie_endcom := copy(Q.FieldByName('clie_endcom').AsString,1,39);
        if AnsiPos( chr(39),nomecliente)>0  then

           nomecliente := FGeral.TiraBarra(nomecliente,chr(39));
        if AnsiPos( chr(39),razaosocial)>0  then

           nomecliente := FGeral.TiraBarra(razaosocial,chr(39));

        Sistema.Edit('clientestemp');
        Sistema.SetField('clie_nome',Sac( FGeral.TiraBarra( nomecliente ) ));
        Sistema.SetField('clie_razaosocial',Sac( FGeral.TiraBarra( razaosocial ) ));
        nomecidade := FGeral.TiraBarra( Q.FieldByName('clie_cidade').AsString );
        if AnsiPos( chr(39),Q.FieldByName('clie_cidade').AsString)>0  then
           nomecidade := FGeral.TiraBarra(nomecidade,chr(39));
        Sistema.SetField('clie_cidade',Sac( nomecidade ));
        Sistema.SetField('clie_endres',Sac( FGeral.TiraBarra( xclie_endres ) ));
        Sistema.SetField('clie_endcom',Sac( FGeral.TiraBarra( xclie_endcom ) ));

        Sistema.Post('clie_codigo = '+(Q.FieldByName('clie_codigo').AsString));
        Sistema.Commit;

        Q.next;

     end;
     FGeral.FechaQuery(Q);


     if not FileExists( ExtractFilePath(Application.ExeName)+'EXPCLI.BAT' ) then begin

       AssignFile ( arqimp,ExtractFilePath(Application.ExeName)+'EXPCLI.BAT' );
       Rewrite ( arqimp );
       Writeln ( arqimp, 'CD'+xpath );
       Writeln ( arqimp,' SET PGPASSWORD=sacd35269147' );
//       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "sac"  --format plain -C --column-inserts --file "\sac\scripttempcliente.sql" --table clientestemp '+nomebanco );
//       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding latin1 --port 5432 --username "sac"  --format plain -C --column-inserts --file "\sac\scripttempcliente.sql" --table clientestemp '+nomebanco );
// 15.09.2021
       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "sac" --no-password --format plain -C --column-inserts --file "'+pastasac+pastamovel+'scripttempcliente.sql" --table clientestemp '+nomebanco );
// 24.09.2022
//       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding latin1 --port 5432 --username "sac" --no-password --format plain -C --column-inserts --file "'+pastasac+pastamovel+'scripttempcliente.sql" --table clientestemp '+nomebanco );
       CloseFile ( arqimp );

     end;

     if  ShellExecute(handle,'open',PChar('ExpCli.bat'), '',PChar(ExtractFilePath(Application.ExeName)),SW_HIDE) <= 32 then
         Avisoerro('Erro no shellExecute do ExpCli.bat');

     Delay(1000);
   end;

     Texto.Lines.clear;

     Delay(2000);
     Lista:=TStringList.Create;
     ListaFinal:=TStringList.Create;
// 15.09.2021 - nao adiantou..
//     ListaFinal.Encoding.UTF8;
//     Lista.Encoding.UTF8;
     if not FileExists( arquivo ) then begin
       Sistema.EndProcess('Arquivo '+arquivo+' n�o foi gerado.');
       exit;
     end;
     Lista.LoadFromFile( arquivo );
     for p:=0 to LIsta.Count-1 do begin

      if ( copy(Lista[p],1,12)='CREATE TABLE' ) then begin

        if pos('estoquetemp',Lista[p]) > 0 then
          Lista[p]:=copy( Lista[p], 1,pos('estoquetemp',Lista[p])-1 ) + 'estoque ' +
                    copy( Lista[p], pos('estoquetemp',Lista[p])+11+1,length(trim(Lista[p])) )
// 04.05.20
        else if pos('clientestemp',Lista[p]) > 0 then
          Lista[p]:=copy( Lista[p], 1,pos('clientestemp',Lista[p])-1 ) + 'clientes ' +
                    copy( Lista[p], pos('clientestemp',Lista[p])+11+1,length(trim(Lista[p])) );

// 15.09.2021  - postgres 12 poe o esquema antes do nome da tabela
        if Ansipos('public.',Lista[p]) > 0 then

           Lista[p]:=copy( Lista[p], 1,Ansipos('public.',Lista[p])-1 ) +
                     copy( Lista[p], Ansipos('public.',Lista[p])+07,length(trim(Lista[p])) )  ;

//        ListaFinal.Add( utf8Encode( Lista[p] ) );
        i:=p+1;
        for i:= p to Lista.Count-1 do begin
          if ansipos( 'ALTER TABLE',Uppercase(Lista[i]) )>0 then begin
//            Aviso(lista[i]);
            break;
          end;
          ListaFinal.Add( utf8Encode( Lista[i] ) );

//          texto.lines.add( 'Lista[i] = '+Lista[i] );
//          texto.lines.add( 'utf8Encode( Lista[i] ) = '+utf8Encode(Lista[i]) );
// 15.09.2021
//          ListaFinal.Add( ( Lista[i] ) );
        end;
        break;
      end

     end;

     for p:=0 to LIsta.Count-1 do begin

      if ( copy(Lista[p],1,6)='INSERT' ) then begin

// 07.06.2021 - ficava faltando o fim de certos produtos...nem imagino o porque...
// descoberto item no estoque com o campo esto_obs com linha em branco gravada
// botao 'detalhes' usado uma vez por engano e 'nunca mais'..
        if pos('estoquetemp',Lista[p]) > 0 then begin

          Lista[p]:=copy( Lista[p], 1,pos('estoquetemp',Lista[p])-1 ) + 'estoque ' +
                      copy( Lista[p], pos('estoquetemp',Lista[p])+11+1,length(trim(Lista[p])) ) ;


// 04.05.20
        end else if pos('clientestemp',Lista[p]) > 0 then

          Lista[p]:=copy( Lista[p], 1,pos('clientestemp',Lista[p])-1 ) + 'clientes ' +
                      copy( Lista[p], pos('clientestemp',Lista[p])+11+1,length(trim(Lista[p])) );

// 15.09.2021  - postgres 12 poe o esquema antes do nome da tabela
        if Ansipos('public.',Lista[p]) > 0 then

           Lista[p]:=copy( Lista[p], 1,Ansipos('public.',Lista[p])-1 ) +
                     copy( Lista[p], Ansipos('public.',Lista[p])+07,length(trim(Lista[p])) )  ;


        ListaFinal.Add( utf8Encode( Lista[p] ) );
//        texto.lines.add( 'Lista[p] = '+Lista[p] );
//        texto.lines.add( 'utf8Encode( Lista[p] ) = '+utf8Encode(Lista[p]) );

// 15.09.2021
//          ListaFinal.Add( ( Lista[p] ) );
      end

     end;

//     Aviso('Lista Final '+ListaFinal.text);
//     Texto.Lines.AddStrings( ListaFinal.text );

     ListaFinal.SaveToFile( arquivofinal,Encode.UTF8 );
     ListaFinal.SaveToFile( arquivofinal01,Encode.UTF8 );
////////////////////////////////////////////////////////
   {
// envio ao ftp 'bala'
/////////////////////////////
   ftp:=TIdftp.Create(self);
//   ftp.Disconnect;
//   ftp.DisconnectSocket;
   if cblocal.Checked then
     ftp.Host:='192.168.1.1'
   else
     ftp.Host:='storollicia.no-ip.info';
   ftp.Port:=60500;
   ftp.Passive:=true;
   ftp.Password:='clientes';
   ftp.Username:='clientes';
   Sistema.BeginProcess('Enviando '+arquivofinal+' ao ftp');
   try
     try
        ftp.Connect();
     except
       Sistema.BeginProcess('Conectando ftp:'+ftp.Host+':'+inttostr(ftp.Port));
     end;
   finally
     ftp.ChangeDir('BkpClientes');
     ftp.ChangeDir('Vendasmovel');
   end;
   ftp.Put(ArquivoFinal,ArquivoDestino);
////////////////////////////////////////////////////////
}

   if  Cadastro='estoque' then begin

     Sistema.beginprocess('Gerando script de pre�os');
     if EdFiltro.IsEmpty then cond:='order by esto_descricao'
     else cond:='where '+FGeral.GetIN('esto_grup_codigo',EdFiltro.Text,'N')+' order by esto_descricao';

     try
       xsql:='drop table estoqueqtdetemp';
       Sistema.Conexao.ExecuteDirect(xsql) ;
     except
       Avisoerro('Erro na tabela estoqueqtdetemp');
     end;

     xsql:='create table estoqueqtdetemp as select * from estoqueqtde where esqt_esto_codigo in '+
           '( select esto_codigo from estoque '+cond+') and esqt_unid_codigo='+Stringtosql(Global.CodigoUnidade);

     Sistema.beginprocess('Gerando script de pre�os - 01');

     Sistema.Conexao.ExecuteDirect(xsql) ;
     arquivo:=PastaSac+PastaMovel+'scripttempprecos.sql';
     arquivofinal:=PastaSac+PastaMovel+'scriptprecos.sql';
     arquivofinal01:=PastaSac+'scriptprecos.sql';
     arquivodestino:='scriptprecos.sql';
//     winexec( pchar(xpath+'pg_dump.exe --host '+servidor+' --port 5432 --username postgres --format plain --column-inserts --file \sac\scripttempestoque.sql --table estoque sac'), SW_SHOWNORMAL);
//     winexec( pansichar(xpath+'pg_dump.exe --host '+servidor+' --encoding=utf-8 --port 5432 --username postgres --format plain --column-inserts --file \sac\scripttempprecos.sql --table estoqueqtdetemp sac'), SW_Hide);
// 19.04.17
     if not FileExists( ExtractFilePath(Application.ExeName)+'EXPQTD.BAT' ) then begin

       AssignFile ( arqimp,ExtractFilePath(Application.ExeName)+'EXPQTD.BAT' );
       Rewrite ( arqimp );
       Writeln ( arqimp, 'CD'+xpath );
       Writeln ( arqimp,'set PGPASSWORD=sacd35269147' );
//       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "sac" --no-password  --format plain -C --column-inserts --file "\sac\scripttempprecos.sql" --table estoqueqtdetemp '+nomebanco );
// 15.09.2021
       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "sac" --no-password --format plain -C --column-inserts --file "'+pastasac+pastamovel+'scripttempprecos.sql" --table estoqueqtdetemp '+nomebanco );

       CloseFile ( arqimp );

     end;

     Sistema.beginprocess('Gerando script de pre�os - 02');


     if  ShellExecute(handle,'open',PChar('ExpQtd.bat'), '',PChar(ExtractFilePath(Application.ExeName)),SW_HIDE) <= 32 then
         Avisoerro('Erro no shellExecute do ExpQtd.bat');
     Delay(5000);

     Lista:=TStringList.Create;
     ListaFinal:=TStringList.Create;
     ListaFinal.Encoding.UTF8;
     Lista.LoadFromFile( arquivo );

     Sistema.beginprocess('Gerando script de pre�os - 03');

// 19.04.17
     for p:=0 to LIsta.Count-1 do begin

      if ( copy(Lista[p],1,12)='CREATE TABLE' ) then begin

        Lista[p]:=copy( Lista[p], 1,pos('estoqueqtdetemp',Lista[p])-1 ) + 'estoqueqtde ' +
                    copy( Lista[p], pos('estoqueqtdetemp',Lista[p])+15+1,length(trim(Lista[p])) );
//        ListaFinal.Add( utf8Encode( Lista[p] ) );
// 15.09.2021  - postgres 12 poe o esquema antes do nome da tabela
        if Ansipos('public.',Lista[p]) > 0 then

           Lista[p]:=copy( Lista[p], 1,Ansipos('public.',Lista[p])-1 ) +
                     copy( Lista[p], Ansipos('public.',Lista[p])+07,length(trim(Lista[p])) )  ;


        i:=p+1;
        for i:= p to Lista.Count-1 do begin
          if ansipos( 'ALTER TABLE',Uppercase(Lista[i]) )>0 then begin
//            Aviso(lista[i]);
            break;
          end;
          ListaFinal.Add( utf8Encode( Lista[i] ) );
        end;
        break;

      end
     end;

     for p:=0 to LIsta.Count-1 do begin

      if copy(Lista[p],1,6)='INSERT' then begin

        Lista[p]:=copy( Lista[p], 1,pos('estoqueqtdetemp',Lista[p])-1 ) + 'estoqueqtde ' +
                    copy( Lista[p], pos('estoqueqtdetemp',Lista[p])+15+1,length(trim(Lista[p])) );
// 15.09.2021  - postgres 12 poe o esquema antes do nome da tabela
        if Ansipos('public.',Lista[p]) > 0 then

           Lista[p]:=copy( Lista[p], 1,Ansipos('public.',Lista[p])-1 ) +
                     copy( Lista[p], Ansipos('public.',Lista[p])+07,length(trim(Lista[p])) )  ;


        ListaFinal.Add( utf8Encode( Lista[p] ) );

      end

     end;

     Sistema.beginprocess('Gerando script de pre�os - 04');


     ListaFinal.SaveToFile( arquivofinal,Encode.UTF8 );
     ListaFinal.SaveToFile( arquivofinal01,Encode.UTF8 );

///////////////     Sistema.BeginProcess('Enviando '+arquivofinal+' ao ftp');
////////////////     ftp.Put(ArquivoFinal,ArquivoDestino);

   end else if  Cadastro='portadores' then begin

     Sistema.beginprocess('Gerando script de condi��o de pagamento');
     if EdFiltro.IsEmpty then cond:='order by fpgt_descricao'
     else cond:='order by fpgt_descricao';

     arquivo       :=PastaSac+PastaMovel+'scripttemppagto.sql';
     arquivofinal  :=PastaSac+PastaMovel+'scriptfpagto.sql';
     arquivofinal01:=PastaSac+'scriptfpagto.sql';
     arquivodestino:='scriptfpagto.sql';

     if not FileExists( ExtractFilePath(Application.ExeName)+'EXPPAG.BAT' ) then begin

       AssignFile ( arqimp,ExtractFilePath(Application.ExeName)+'EXPPAG.BAT' );
       Rewrite ( arqimp );
       Writeln ( arqimp, 'CD'+xpath );
       Writeln ( arqimp,'set PGPASSWORD=sacd35269147' );
//       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "postgres" --no-password  --format plain -C --column-inserts --file "\sac\scripttemppagto.sql" --table fpgto '+nomebanco );
//       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "sac" --format plain -C --column-inserts --file "\sac\scripttemppagto.sql" --table fpgto '+nomebanco );
// 15.09.2021
       Writeln ( arqimp, 'pg_dump.exe --host '+servidor+' --encoding utf-8 --port 5432 --username "sac" --format plain -C --column-inserts --file "'+pastasac+pastamovel+'scripttemppagto.sql" --table fpgto '+nomebanco );
       CloseFile ( arqimp );

     end;

     if  ShellExecute(handle,'open',PChar('ExpPag.bat'), '',PChar(ExtractFilePath(Application.ExeName)),SW_HIDE) <= 32 then
         Avisoerro('Erro no shellExecute do ExpPag.bat');
     Delay(2000);
     Lista:=TStringList.Create;
     ListaFinal:=TStringList.Create;
     ListaFinal.Encoding.UTF8;

     if not FileExists( arquivo ) then begin
       Sistema.EndProcess('Arquivo '+arquivo+' n�o foi gerado.');
       exit;
     end;

     Lista.LoadFromFile( arquivo );
     for p:=0 to LIsta.Count-1 do begin

      if ( copy(Lista[p],1,12)='CREATE TABLE' ) then begin
//        ListaFinal.Add( utf8Encode( Lista[p] ) );
// 15.09.2021  - postgres 12 poe o esquema antes do nome da tabela
        if Ansipos('public.',Lista[p]) > 0 then

           Lista[p]:=copy( Lista[p], 1,Ansipos('public.',Lista[p])-1 ) +
                     copy( Lista[p], Ansipos('public.',Lista[p])+07,length(trim(Lista[p])) )  ;

        i:=p+1;
        for i:= p to Lista.Count-1 do begin

          if ansipos( 'ALTER TABLE',Uppercase(Lista[i]) )>0 then begin
//            Aviso(lista[i]);
            break;
          end;
          ListaFinal.Add( utf8Encode( Lista[i] ) );

        end;
        break;
      end

     end;

     for p:=0 to LIsta.Count-1 do begin

       if copy(Lista[p],1,6)='INSERT' then begin

// 15.09.2021  - postgres 12 poe o esquema antes do nome da tabela
        if Ansipos('public.',Lista[p]) > 0 then

           Lista[p]:=copy( Lista[p], 1,Ansipos('public.',Lista[p])-1 ) +
                     copy( Lista[p], Ansipos('public.',Lista[p])+07,length(trim(Lista[p])) )  ;

        ListaFinal.Add( utf8Encode( Lista[p] ) );

       end

     end;
// 15.09.2021
//     Texto.LInes.Text := ListaFinal.text;

     ListaFinal.SaveToFile( arquivofinal,Encode.UTF8 );
     ListaFinal.SaveToFile( arquivofinal01,Encode.UTF8 );
///////////////////////////////     ftp.Put(ArquivoFinal,ArquivoDestino);

   end;

   Lista.Free;ListaFinal.Free;
//   ftp.Disconnect();
//   ftp.Destroy;
   Sistema.EndProcess('Terminado');

end;

// 13.11.14
procedure TFDiversos.ImpPedidosMovel;
///////////////////////////////////////
begin
//  Caption:='Baixa Parcial De Pend�ncia Financeira';

  Caption:='Importa��o De Pedidos de Vendas M�vel(celular,tablet)';
  Width:=450;Height:=405;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgExportaMovel;
  btexportar.visible:=false;
  cblocal.Visible:=true;
  edfiltro.Visible:=false;
  eddata.Visible:=true;
  edtablet.Visible:=true;
  ActiveControl:=Eddata;
  mostramens:='S';
  bimportar.Visible:=true;

  EdData.SetDate( Sistema.hoje-1 );
// checagem de segunda ou sabado
  if Dayofweek(EdData.AsDate)=1 then EdData.SetDate(Sistema.Hoje-3)
  else if Dayofweek(EdData.AsDate)=6 then EdData.SetDate(Sistema.Hoje-1);
  EdFiltro.text:='';
  ShowModal;

end;

// 13.11.14
procedure TFDiversos.bimportarClick(Sender: TObject );
//////////////////////////////////////////////////////////////////////
var arquivopedido,arquivonoftp,xtransacao,Fpgt_codigo,Port_codigo,PortadorBoleto,xdrive,
    Vendedor,pastamovel,pedido,PastaSac,Tipomov,
    arquivoprocessado,
    arquivoclientes,
    arquivoproclientes :string;
    data,emissao       :Tdatetime;
    Lista,ListaCampos,ListaArq,ListaItens,
    ListaNumeros,
    Listacodigoscli,
    Listacodigoscli1                   :TStringList;
    p,i,codcliente,xnumero,N,inicio,fim:integer;
    Q                  :TSqlquery;
    valorpedido        :currency;
//    starquivopedido,
//    starquivoclientes  :TStringStream;
    gravoupedido,
    AchouArquivo,
    AchouArqClientes   :boolean;
    ListaClientes      :TStringList;

var
  hConnection, hOpen, hFind: PInteger;
  hData: TWIN32FINDDATA;


        function GetcodigoConvertido(xcodigo:string):integer;
        ///////////////////////////////////////////////////////
        var i : integer;
        begin

           result := strtoint(xcodigo);
           for i := 0 to ListaCodigosCli1.count-1 do begin

               if xcodigo = ListaCodigosCli1[i]  then result := strtoint(Listacodigoscli[i]);

           end;

        end;


    procedure GravaMestre(xLista:TStringList);
    /////////////////////
    begin
      emissao:=strtodate( xLista[1] );
      codcliente:=strtoint( xLista[2] );
// 03.02.2021 - Giacomoni - clientes incluidos via tablet
      codcliente := GetcodigoConvertido( inttostr(codcliente) );
//      EdCodcliente.text:=xLista[2];
      EdCodcliente.text:=inttostr(codcliente);
      EdCodcliente.ValidFind;
      Fpgt_codigo:=xLista[6];
      Port_codigo:=xLista[5];
      valorpedido:=Texttovalor( xlista[4] );
//      PortadorBoleto:='001';  // CRIAR CONFIGURACAO geral
// 01.06.20
      PortadorBoleto:= FGeral.GetConfig1AsString( 'Portaboletos' );
// 19.02.18
      if xLista.Count>7 then tipomov:=xLista[7] else tipomov:='PV';
      if trim(Tipomov)='' then tipomov:='PV';

      Q:=sqltoquery('select mped_numerodoc from movped where mped_status=''N'''+
                     ' and mped_tipo_codigo='+inttostr(codcliente)+
                     ' and mped_vlrtotal = '+Valortosql( valorpedido )+
                     ' and mped_datamvto = '+Eddata.AsSql+
                     ' and mped_unid_codigo = '+Stringtosql(Global.CodigoUnidade) );
      if Q.eof then begin

        xtransacao:=FGeral.GetTransacao;
        xnumero:=FGeral.GetContador('PEDVENDA',false);
        ListaNumeros.add( StrToStrNumeros(xlista[0]) +';'+inttostr(xnumero)+';'+xtransacao );
        Sistema.Insert('Movped');
        Sistema.SetField('mped_transacao',xTransacao);
        Sistema.SetField('mped_operacao',FGeral.GetOperacao);
        Sistema.SetField('mped_status','N');
        Sistema.SetField('mped_numerodoc',xNumero);
        Sistema.SetField('mped_tipomov',Global.CodPedVenda);
        Sistema.SetField('mped_unid_codigo',Global.CodigoUnidade);
        Sistema.SetField('mped_tipo_codigo',codCliente);
        Sistema.SetField('mped_datalcto',Sistema.Hoje);
        Sistema.SetField('mped_datamvto',Emissao);
//        if port_codigo=PortadorBoleto then
// 01.06.20
        if AnsiPos( port_codigo, PortadorBoleto ) > 0 then
           Sistema.SetField('mped_datacont',Emissao);

        Sistema.SetField('mped_vlrtotal',ValorPedido);
//        if FCondpagto.GetAvPz(Fpgt_codigo)='V' then
//          Sistema.SetField('mped_valoravista',Valortotal)
//        else
//          Sistema.SetField('mped_valoravista',Valorparteavista);
        Sistema.SetField('mped_tabp_codigo',0);
        Sistema.SetField('mped_fpgt_codigo',Fpgt_codigo);
//        Sistema.SetField('mped_tabaliquota',FTabela.GetAliquota(Tabela));
        Sistema.SetField('mped_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('mped_pedcliente',StrToStrNumeros(xlista[0]));
        Sistema.SetField('mped_estado',EdcodCliente.resultfind.fieldbyname('clie_uf').asstring);
        Sistema.SetField('mped_cida_codigo',EdcodCliente.resultfind.fieldbyname('clie_cida_codigo_res').asinteger);
        Sistema.SetField('mped_repr_codigo',EdcodCliente.resultfind.fieldbyname('clie_repr_codigo').asinteger);
        Sistema.SetField('mped_tipocad','C');
        Sistema.SetField('mped_dataemissao',Emissao);
        Sistema.SetField('mped_totprod',valorpedido);
        Sistema.SetField('mped_vispra',FCondpagto.GetAvPz(Fpgt_codigo));
        Sistema.SetField('mped_perdesco',0);
        Sistema.SetField('mped_peracres',0);
        Sistema.SetField('mped_situacao','P');
//        Sistema.SetField('mped_formaped',EdFormapedido.text);
        Sistema.SetField('mped_envio','R');
        Sistema.SetField('Mped_fpgt_prazos',FCondpagto.GetCampoPrazos(Fpgt_codigo));
//        Sistema.SetField('mped_contatopedido',EdContato.text);
//        Sistema.SetField('mped_datapedcli',EdDatacliente.asdate);
//        Sistema.SetField('mped_obslibcredito',obsliberacao);
//        Sistema.SetField('mped_datalibcredito',sistema.hoje);
//        Sistema.SetField('mped_usualibcred',usuariolib);
        Sistema.SetField('mped_obspedido','Vendas Movel '+vendedor);
        Sistema.SetField('mped_port_codigo',Port_codigo);
// 19.02.18 - para importar pedidos identificados como PV, CM - comodato e BN - bonificacao
        if Tipomov='PV' then
          Sistema.SetField('mped_formaped','T')
        else if Tipomov='CM' then
          Sistema.SetField('mped_formaped','C')
        else if Tipomov='BN' then
          Sistema.SetField('mped_formaped','B');

        Sistema.Post();
//        if pos(tipomov,'PV;')>0 then
          FGeral.GravaPendencia(Emissao,emissao,EdcodCliente,'C',0,global.codigounidade,'PV',xtransacao,Fpgt_codigo,'R',xNumero,0,valorpedido,
                              0,'H',valorpedido,0,nil,'','001' );

      end else Aviso('Aten��o !!!  J� encontrado pedido '+Q.FieldByName('mped_numerodoc').AsString+' de valor '+currtostr(valorpedido)+' codigo '+inttostr(codcliente)+' '+
                     FCadcli.GetNome(codcliente)+' nesta data' );

      FGeral.FechaQuery(Q);
    end;

    procedure GravaDetalhe(xLista:TStringList;xseq:integer);
    ///////////////////////////////////////////////////////////

                  procedure GetNumerodoMestre( cnumero:string );
                  /////////////////////////////////////////////////////////////
                  var i:integer;
                      ListaB:TStringList;
                  begin
                    for i:=0 to ListaNumeros.Count-1 do begin
                      ListaB:=TStringList.create;
                      strtolista(ListaB,ListaNumeros[i],';',true);
                      if cnumero=ListaB[0] then begin
                        xnumero:=strtoint( ListaB[1] );
                        xtransacao:=ListaB[2];
                        break;
                      end;
                    end;
                  end;

    begin

      Q:=sqltoquery('select mpdd_numerodoc from movpeddet where mpdd_status=''N'''+
                     ' and mpdd_tipo_codigo='+inttostr(codcliente)+
                     ' and mpdd_datamvto = '+Eddata.AsSql+
                     ' and mpdd_numerodoc = '+inttostr(xnumero) +
                     ' and mpdd_esto_codigo = '+stringtosql(xLista[2])+
                     ' and mpdd_unid_codigo = '+Stringtosql(Global.CodigoUnidade) );
      if not Arq.TEstoque.Active then Arq.TEstoque.Open();
      if Q.eof then begin

        GetNumerodoMestre(strtostrnumeros(xLista[0]));
        codcliente:=strtoint( xLista[1] );
// 03.02.2021 - Giacomoni - clientes incluidos via tablet
        codcliente := GetcodigoConvertido( inttostr(codcliente) );
        Sistema.Insert('Movpeddet');
        Sistema.SetField('mpdd_transacao',xTransacao);
        Sistema.SetField('mpdd_operacao',FGeral.GetOperacao);
        Sistema.SetField('mpdd_status','N');
        Sistema.SetField('mpdd_numerodoc',xnumero);
        Sistema.SetField('mpdd_tipomov',Global.CodPedVenda);
        Sistema.SetField('mpdd_unid_codigo',Global.CodigoUnidade);
        Sistema.SetField('mpdd_tipo_codigo',codCliente);
        Sistema.SetField('mpdd_datalcto',Sistema.Hoje);
        Sistema.SetField('mpdd_datamvto',Emissao);
//        if port_codigo=PortadorBoleto then
// 01.06.20
        if AnsiPos( port_codigo, PortadorBoleto ) > 0 then
          Sistema.SetField('mpdd_datacont',Emissao);
        Sistema.SetField('mpdd_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('mpdd_repr_codigo',EdcodCliente.resultfind.fieldbyname('clie_repr_codigo').asinteger);
        Sistema.SetField('mpdd_tipocad','C');
/////
        Sistema.SetField('mpdd_esto_codigo',xLista[2]);
//        Sistema.SetField('mpdd_tama_codigo',strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),linha],0));
//        Sistema.SetField('mpdd_core_codigo',strtointdef(Grid.cells[Grid.getcolumn('codcor'),linha],0));
        Arq.TEstoque.locate('esto_codigo',xLista[2],[]);
        Sistema.SetField('mpdd_qtde',Texttovalor( xLista[4] ) );
        Sistema.SetField('mpdd_venda',Texttovalor( xLista[3] ) );
        Sistema.SetField('mpdd_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
        Sistema.SetField('mpdd_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
        Sistema.SetField('mpdd_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
        Sistema.SetField('mpdd_mate_codigo',Arq.TEstoque.fieldbyname('esto_mate_codigo').AsInteger);
        Sistema.SetField('mpdd_emlinha',Arq.TEstoque.fieldbyname('esto_emlinha').AsString);
        Sistema.SetField('mpdd_qtdeenviada',0);
        Sistema.SetField('mpdd_vendabru',Texttovalor( xLista[3] ) );
//        Sistema.SetField('mpdd_perdesco',Texttovalor(Grid.cells[Grid.getcolumn('perdesconto'),linha]));
        Sistema.SetField('mpdd_caoc_codigo',0);
        Sistema.SetField('mpdd_situacao','P');
        Sistema.SetField('mpdd_seq',xseq );
//        Sistema.SetField('mpdd_pecas',Texttovalor(Grid.cells[Grid.getcolumn('mpdd_pecas'),linha]) );
// 24.06.18 - grava o numero do pedido no tablet
        Sistema.SetField('mpdd_transacaonftrans',xLista[0] );

        Sistema.Post('');

      end;

      FGeral.FechaQuery(Q);
    end;

   function GetCodigoCidade(xnomecidade,xuf:string):integer;
    /////////////////////////////////////////////////////
    var Q:TSqlquery;
        codigo:integer;
    begin
        Q:=sqltoquery('select * from cidades where cida_nome='+stringtosql(xnomecidade)+
                       'and cida_uf='+Stringtosql(xuf) );
        if not Q.eof then
          codigo:=Q.fieldbyname('cida_codigo').asinteger
        else
          codigo:=999;    // para gerar erro ao testar a importacao...
        Q.close;Freeandnil(Q);
        result:=codigo;
    end;

    procedure GravaCliente(xLista:TStringList);
    ///////////////////////
    var desc,
        fantasia,
        cnpjcpf,
        fone,
        celular,
        uf,
        cep,
        nomecidade,
        email,
        bairro,
        complemento,
        endereco,
        condicaopg,
        codigotablet      :string;
        x,
        codigo,
        posnome,
        posfantasia,
        poscnpjcpf,
        posinsc,
        posfone,
        poscelular ,
        poscep,
        posemail,
        posbairro,
        posendereco,
        poscodvendedor,
        codvendedor,
        poscondicaopg    :integer;
        Qv,
        Qc               :TSqlquery;
        ListaLinha       :TStringList;


/////////////////////////////////////////////////////
    begin
/////////////////////////////////////////////////////

      ListaLinha      := TStringList.create;
      ListaCodigosCli := TStringList.create;
      ListaCodigosCli1:= TStringList.create;
      posnome     := 01;
      posfantasia := 02;
      poscnpjcpf  := 03;
      posinsc     := 04;
      posfone     :=  0;
      poscelular  :=  0;
      poscep      := 07;
      posemail    :=  0;
      posbairro   := 09;
      posendereco := 05;
      poscodvendedor := 12;
      poscondicaopg  := 13;

      codigo := FCadCli.GetProxCodigo('CLIENTES',false);
// aqui guardar o codigo do cliente q ser� usado no sac para mudar quando for importar
// o pedido feito com o codigo gerado no tablet...
///////////////////////////////////////////////////{
      ListaLINha.AddStrings( xLista );

      desc      := copy(ListaLInha[posnome],1,50);
      cnpjcpf   := trim(copy( ListaLInha[poscnpjcpf],1,14 ));
      Qc        := sqltoquery(' select clie_codigo,clie_nome from clientes where clie_cnpjcpf = '+
                              stringtosql( cnpjcpf ) );
      if not Qc.eof then begin

         Avisoerro('Cliente cnpj/cpf '+cnpjcpf+' j� cadastrado no cliente '+Qc.fieldbyname('clie_codigo').asstring+' - '+
                   Qc.fieldbyname('clie_nome').asstring);
         exit;

      end;

      codigotablet := trim(copy( ListaLInha[0],1,11 ))  ;
      ListaCodigosCli.add( inttostr(codigo) );
      ListaCodigosCli1.add( codigotablet );

      if posfone > 0  then fone := trim(copy( ListaLInha[posfone],1,11 )) else fone := '';
      if poscelular > 0  then celular := trim(copy( ListaLInha[poscelular],1,11 )) else celular := '';
      if poscep > 0  then cep := trim(copy( ListaLInha[poscep],1,08 )) else cep := '';
      uf := Global.UFUnidade;
      nomecidade := FCidades.GetNOme( FUnidades.GetCidaCodigo(Global.CodigoUnidade) );

      if length( cep )=8 then begin

//         Acbrcep1.buscarporcep( cep );
//         if ACBrCEP1.Enderecos.Count > 0 then begin
         if Acbrcep1.buscarporcep( cep ) > 0 then begin

            uf         := ACBrCEP1.Enderecos[0].UF;
            nomecidade := ACBrCEP1.Enderecos[0].Municipio;

         end;

      end;

      if posbairro>0  then bairro := trim(copy( ListaLInha[posbairro],1,20 )) else bairro := '';
      if posemail>0   then email  := trim(copy( ListaLInha[posemail],1,50 )) else email := '';
      complemento := '';
      if posendereco>0  then endereco := trim(copy( ListaLInha[posendereco],1,50 )) else endereco := '';
      if poscodvendedor>0  then codvendedor := strtoint(trim(copy( ListaLInha[poscodvendedor],1,5 ))) else codvendedor := 0;
      if poscondicaopg>0  then condicaopg := (trim(copy( ListaLInha[poscondicaopg],1,3 ))) else condicaopg := '';

      if pos('',desc)>0 then desc:=copy(ListaLInha[posnome],1,pos('',desc)-1)+' '+copy(desc,pos('',desc)-1,30);
      fantasia:=copy(ListaLInha[posfantasia],1,40);
      if pos('',fantasia)>0 then fantasia:=copy(ListaLInha[posnome],1,pos('',fantasia)-1)+' '+copy(fantasia,pos('',fantasia)-1,30);
      x:=pos('�',fantasia);
      if x>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
        fantasia:=copy(fantasia,1,x-1)+'�'+copy(fantasia,x+2,length(desc)-x);
      x:=pos('�',fantasia);
      if x>0 then
        fantasia:=copy(fantasia,1,x)+copy(fantasia,x+2,length(fantasia)-x);

/////////////
      x:=pos('�',desc);
      if x>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
        desc:=copy(desc,1,x-1)+'�'+copy(desc,x+2,length(desc)-x);
      x:=pos('�',desc);
      if x>0 then
        desc:=copy(desc,1,x)+copy(desc,x+2,length(desc)-x);

      Sistema.Insert('clientes');
      Sistema.SetField('clie_codigo',codigo);
//      Sistema.SetField('clie_codigo_ant',codigoant);

      Sistema.SetField('clie_razaosocial',Specialcase(desc));
////      if (pos('/',fantasia)>0)  SEFA SP
      if (trim(fantasia)='') then //
         Sistema.SetField('clie_nome',Specialcase(desc))
      else
         Sistema.SetField('clie_nome',Specialcase(fantasia));

      Sistema.SetField('clie_cnpjcpf', cnpjcpf);
      Sistema.SetField('clie_rgie',copy(StrtoStrDigitos(ListaLInha[posinsc]),1,20) );
      Sistema.SetField('clie_foneres',fone);
      Sistema.SetField('clie_fonecel',celular);
//      Sistema.SetField('clie_dtcad',Sistema.Hoje);
      Sistema.SetField('clie_unid_codigo',Global.CodigoUnidade);
      Sistema.SetField('clie_uf',uf);
      Sistema.SetField('clie_ipi','N');
//      if ListaLInha[1]='CPF' then
      if length(trim(StrtoStrDigitos( ListaLInha[poscnpjcpf] ))) < 14 then begin

        Sistema.SetField('clie_tipo','F');
        Sistema.SetField('clie_contribuinte','N');
        Sistema.SetField('clie_consfinal','S');

      end else begin

        Sistema.SetField('clie_tipo','J');
        if trim( copy(StrtoStrDigitos(ListaLInha[posinsc]),1,20) ) = '' then begin

          Sistema.SetField('clie_contribuinte','N');
          Sistema.SetField('clie_consfinal','S');

        end else begin

          Sistema.SetField('clie_contribuinte','S');
          Sistema.SetField('clie_consfinal','N');

        end;

      end;
      Sistema.SetField('Clie_cepres',cep);
      Sistema.SetField('Clie_cepcom',cep);
      Sistema.SetField('Clie_email',email);
      Sistema.SetField('Clie_bairrores',bairro);
      Sistema.SetField('Clie_bairrocom',bairro);

      Sistema.SetField('Clie_endrescompl',complemento);
//
//      if (trim(numero)<>'') and ( strtointdef(numero,0)>0 ) then begin
//        Sistema.SetField('Clie_endres',copy(trim(endereco)+','+numero,1,40));
//        Sistema.SetField('Clie_endcom',copy(trim(endereco)+','+numero,1,40));
//      end else begin
        Sistema.SetField('Clie_endres',copy(endereco,1,50));
        Sistema.SetField('Clie_endcom',copy(endereco,1,50));
//      end;
      Sistema.SetField('Clie_cida_codigo_res',GetCodigoCidade(nomecidade,uf));
      Sistema.SetField('Clie_cida_codigo_com',GetCodigoCidade(nomecidade,uf));

      Sistema.SetField('Clie_fonecom',fone);
      Sistema.SetField('Clie_dtcad',Sistema.Hoje);
      Sistema.SetField('Clie_obs','INCLUIDO VENDAS MOVEL');
//      Sistema.SetField('Clie_dtnasc',DataNascimento);
//      Sistema.SetField('Clie_fax',fonefax);

      Sistema.SetField('Clie_cidade',nomecidade);

      if codvendedor > 0 then

         Sistema.SetField('Clie_repr_codigo',codvendedor)

      else

         Sistema.SetField('Clie_repr_codigo',1);

// 02.02.21
      if trim(condicaopg) <> '' then

         Sistema.SetField('Clie_fpgt_codigo',condicaopg)

      else

         Sistema.SetField('Clie_repr_codigo','001');

////////////////////////
      Sistema.SetField('clie_usua_codigo',998);
      Sistema.Post();

      {
      if codvendedor > 0 then begin

         Qv:=sqltoquery('select repr_codigo from representantes where repr_codigo='+inttostr(codvendedor));
         if QV.eof then begin

            Sistema.Insert('representantes');
            Sistema.SetField('repr_codigo',codvendedor);
            Sistema.SetField('repr_nome',nomevendedor);
            Sistema.SetField('repr_razaosocial',nomevendedor);
            Sistema.SetField('repr_cida_codigo',1);
            Sistema.Post();

         end;
         QV.close;Qv.free;

      end;
      }
//////////////////////////////////////////    }


    end;

begin
////////////////////////////////////////////
// busca arquivo do ftp 'bala'    desativada por enquanto
//////////////////////////////
   if Eddata.IsEmpty then begin
     Avisoerro('Problemas com a data informada');
     exit;
   end;

// 08.06.2021
   ImportaPedidos( EdData.asdate );
   exit;

////////////////////////////////////////////////////////////////////////
{
   ftp:=TIdftp.Create(self);
//   ftp.Disconnect;
   if cblocal.Checked then
     ftp.Host:='192.168.1.1'
   else
     ftp.Host:='storollicia.no-ip.info';
//   ftp.Host:='187.109.101.90';
   ftp.Port:=60500;
   ftp.Password:='clientes';
   ftp.Username:='clientes';
//   ftp.Password:='andre';
 //  ftp.Username:='andre';
   ftp.Passive:=true;
   ftp.ReadTimeout:=500000;

 //   }
   {
   ftpacbr.ftp.ftpHost:='storollicia.no-ip.info';
//   ftp.Host:='187.109.101.90';
   ftpacbr.ftp.ftpPort:='60500';
   ftpacbr.ftp.ftpPass:='clientes';
   ftpacbr.ftp.ftpUser:='clientes';
//   ftpacbr.DownloadUrl:='ftp://storollicia.no-ip.info:60500';
//   }

   data:=Eddata.AsDate;
//   arquivopedido:='C:\delphisac\programa\PEDM'+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.TXT';
   PastaSac:=ExtractFilePath( application.ExeName );
   xdrive:= 'c:';
// 05.06.18
   if not FileExists( PastaSac+'Sacxe7.exe' ) then
     xdrive:='d:';
   if not FileExists( PastaSac+'Sacxe7.exe' ) then
     xdrive:='e:';
/////////////////////////////
// 25.01.17
   pastamovel:=FGeral.GetConfig1AsString('pastachecaped');
///////////////////////////////////////////////////////////////////////////////
   gravoupedido:=false;
   inicio:=0 ; fim:=10;
   if not EdTablet.IsEmpty then begin
     inicio:=strtoint(EdTablet.text);
     fim:=(inicio);
   end;
// 01.02.2021 - primeiro importa clientes inclusos via tablet
   ListaClientes := TStringList.create;

   FOR N:= inicio TO fim DO BEGIN

       if n=0 then vendedor:='0' else vendedor:=inttostr(N);
       if trim(pastamovel)<>'' then begin

          arquivoclientes    := PastaSac+pastamovel+'\CLIE'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
          arquivoproclientes := PastaSac+pastamovel+'\CLIE'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.OK';

       end else begin

          arquivoclientes    := PastaSac+'CLIE'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
          arquivoproclientes := PastaSac+'CLIE'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.OK';

       end;

       AchouArqClientes := false;
       if FileExists( arquivoclientes ) then AchouArqClientes := true;

       if FileExists( arquivoproclientes ) then begin

          if not confirma('Arquivo de CLIENTES '+arquivoclientes+' j� importado .  Importar novamente ?') then begin
            Sistema.EndProcess('');
            exit;
          end else
            RenameFile( arquivoproclientes , copy(arquivoproclientes,1,pos('.',arquivoproclientes)-1)+'.TXT');

       end;

////////////////////////////////////////////////////////////
       Sistema.BeginProcess('Importando CLIENTES do arquivo '+arquivoclientes);
//       starquivoclientes := TStringStream.Create('');
       Lista        := TStringList.Create;
       ListaNumeros := TStringlist.Create;
//       Lista.LoadFromStream(starquivoclientes);
       if AchouArqClientes then begin

           Lista.LoadfromFile(arquivoclientes);

           if Lista.count=0 then begin
              Sistema.endprocess('IMPORTA��O INTERROMPIDA.  Arquivo '+arquivoclientes+' est� vazio');
              exit;
           end;

           Sistema.BeginProcess('Lendo arquivo de clientes');
           for p:=0 to Lista.count-1 do begin

             ListaCampos := TStringList.Create;
             strtolista(Listacampos,Lista[p],';',true);
             if Listacampos.Count>0 then
                GravaCliente( ListaCampos );
             ListaCampos.Free;

           end;
//       gravoupedido:=true;

         RenameFile( arquivoclientes , copy(arquivoclientes,1,pos('.',arquivoclientes)-1)+'.OK');
         Lista.free;
         ListaNumeros.free;

      end;

   END;
   LIstaClientes.free;
//////////////////////////////////////////////////////////////

   FOR N:= inicio TO fim DO BEGIN

//   if n=0 then vendedor:='' else vendedor:=inttostr(N);
// 30.09.19
   if n=0 then vendedor:='0' else vendedor:=inttostr(N);
   if trim(pastamovel)<>'' then begin

     arquivopedido    :=PastaSac+pastamovel+'\PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
     arquivoprocessado:=PastaSac+pastamovel+'\PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.OK';

   end else begin

     arquivopedido:=PastaSac+'PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
     arquivoprocessado:=PastaSac+'PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.OK';

   end;

// 23.10.19
   AchouArquivo:=false;
   if not FileExists( arquivopedido ) then begin

       if trim(pastamovel)<>'' then begin

         arquivopedido:=PastaSac+pastamovel+'\PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.TXT';
         arquivoprocessado:=PastaSac+pastamovel+'\PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.OK';

       end else begin

         arquivopedido:=PastaSac+'PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.TXT';
         arquivoprocessado:=PastaSac+'PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.OK';

       end;
       if FileExists( arquivopedido ) then AchouArquivo:=true;

   end else AchouArquivo:=true;

//   arquivonoftp:='BkpClientes/Vendasmovel/'+'PEDM'+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
     arquivonoftp:='PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
//   arquivonoftp:='SerialMFD.rar';

{
   ftpacbr.DownloadDest:=xdrive+'\sac';
//   ftpacbr.DownloadNomeArq:='/'+'BkpClientes'+'/'+'Vendasmovel/'+arquivonoftp;
   ftpacbr.DownloadNomeArq:=arquivonoftp;
   ftpacbr.Protocolo:=protFTP;
}

///////////////////////////////////////////
        {
  hOpen := InternetOpen ('', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
//  hConnection := InternetConnect (hOpen, pansichar(ftp.host), INTERNET_DEFAULT_FTP_PORT,
//    pansichar(ftp.username),pansichar(ftp.password), INTERNET_SERVICE_FTP, INTERNET_FLAG_PASSIVE, 0);
  hConnection := InternetConnect (hOpen, pansichar(ftp.host), ftp.port,
    pansichar(ftp.username),pansichar(ftp.password), INTERNET_SERVICE_FTP, INTERNET_REQFLAG_PASSIVE, 0);
//  FtpSetCurrentDirectory (hConnection, '/BkpClientes/Vendasmovel');
  FtpSetCurrentDirectory (hConnection, '/');
  hFind := FtpFindFirstFile (hConnection, 'desligar.sh' , hData, 0, 0);

  if hFind = nil then
    pmens.Caption := 'n�o foi encontrado'
  else
    pmens.Caption := 'encontrado';

  InternetCloseHandle (hConnection);
  InternetCloseHandle (hOpen);

  aviso('');
       }
/////////////////////////////////////////////
{
   Sistema.BeginProcess('Checando vendas no ftp');
   try
     try
//        ftp.Connect(true,10000);
        ftp.Connect();
//        ftpacbr.StartDownload;
     except
       on E:exception do
       Sistema.endProcess('Problemas para conectar no ftp:'+ftp.Host+':'+inttostr(ftp.Port));
//       Sistema.BeginEndprocess('Problemas para conectar no ftp:'+ftpacbr.ftp.ftpHost+':'+ftpacbr.ftp.ftpPort+' '+E.Message);
     end;
   finally
}
//    ftp.ChangeDir('BkpClientes');
//    ftp.ChangeDir('Vendasmovel');
//    ftp.ChangeDir('..');
//    ftp.ChangeDir('/home/clientes');
//      aviso('Problemas para conectar no ftp:'+ftpacbr.ftp.ftpHost+':'+ftpacbr.ftp.ftpPort);
//   end;
// busca pedidos de venda no ftp de 'ontem+2dias' devido a segunda buscar de sexta
///   if FileExists( arquivopedido ) then DeleteFile( arquivopedido );


   Lista:=TStringList.Create;
   Sistema.BeginProcess('Importando totais dos pedidos do arquivo '+arquivopedido);
//   starquivopedido:=TStringStream.Create('');

{
   try
     ftp.Get(Arquivonoftp,Arquivopedido,true);
//     ftp.Get(Arquivonoftp,stArquivopedido,true);
//     ftp.CheckForGracefulDisconnect();

   except on E:exception do
     avisoerro('Problemas para baixar arquivo '+Arquivonoftp+' '+E.message);
   end;
}
//   if not FileExists( arquivopedido ) then
//     Sistema.endprocess('Arquivo '+arquivopedido+' n�o encontrado')

//    if Global.Usuario.Codigo=100 then Aviso('Arquivo pedido:'+arquivopedido);

// 24.06.18
   if FileExists( arquivoprocessado ) then begin
//      Sistema.EndProcess('J� existe o arquivo '+arquivoprocessado+' .  Verificar');
//
      if not confirma('Arquivo de totais dos pedidos '+arquivopedido+' j� importado .  Importar novamente ?') then begin
        Sistema.EndProcess('');
        exit;
      end else
        RenameFile( arquivoprocessado , copy(arquivoprocessado,1,pos('.',arquivoprocessado)-1)+'.TXT');
   end;

//   if FileExists( arquivopedido ) then begin
// 23.10.19 -
   if AchouArquivo then begin

////////////////////////////////////////////////////////////
     Lista:=TStringList.Create;
     ListaNumeros:=TStringlist.Create;
  //   Lista.LoadFromFile(arquivopedido);
//     Lista.LoadFromStream(starquivopedido);
     Lista.LoadfromFile(arquivopedido);
  {
     if Lista.count=0 then begin
       arquivopedido:=xdrive+'\sac\PEDM'+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,false),4)+'.TXT';
       arquivonoftp:='PEDM'+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,false),4)+'.TXT';
       try
         ftp.Get(Arquivonoftp,Arquivopedido,true);
       except on E:exception do
     //    avisoerro('Problemas para baixar arquivo '+Arquivonoftp+' '+E.message);
       end;
       Lista.LoadFromFile(arquivopedido);
     end;
  }
     if Lista.count=0 then begin
        Sistema.endprocess('Arquivo '+arquivopedido+' est� vazio ( sem vendas )');
        exit;
     end;
// 05.06.17 - para prever 'varias importadas' no dia para q nao apare�a de novo o pedido
//            pra ser faturado
     {
     Q:=sqltoquery('select mped_transacao from movped where mped_obspedido='+Stringtosql('Vendas Movel'+vendedor)+
                   ' and mped_datamvto='+DatetoSql(data)+' and mped_unid_codigo='+Stringtosql(Global.codigounidade)+
                   ' and mped_status=''N''');
     while not Q.eof do begin
       ExecuteSql('update movpeddet set mpdd_status=''C'' where mpdd_transacao='+Stringtosql(Q.fieldbyname('mped_transacao').asstring));
       ExecuteSql('update movped set mped_status=''C'' where mped_transacao='+Stringtosql(Q.fieldbyname('mped_transacao').asstring));
       Q.Next;
     end;
     Q.close;
     }
     Sistema.BeginProcess('Lendo totais dos pedidos');
     for p:=0 to Lista.count-1 do begin

       ListaCampos:=TStringList.Create;
       strtolista(Listacampos,Lista[p],';',true);
       if Listacampos.Count>0 then
         GravaMestre( ListaCampos );
       ListaCampos.Free;

     end;
     gravoupedido:=true;

     RenameFile( arquivopedido , copy(arquivopedido,1,pos('.',arquivopedido)-1)+'.OK');

     if trim(pastamovel)<>'' then begin

       arquivopedido    :=PastaSac+pastamovel+'\PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
       arquivoprocessado:=PastaSac+pastamovel+'\PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.OK'

     end else begin

       arquivopedido    :=PastaSac+'PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
       arquivoprocessado:=PastaSac+'PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.OK';

     end;

// 23.10.19
     if not FileExists( arquivopedido ) then begin

       if trim(pastamovel)<>'' then begin

         arquivopedido    :=PastaSac+pastamovel+'\PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.TXT';
         arquivoprocessado:=PastaSac+pastamovel+'\PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.OK'

       end else begin

         arquivopedido    :=PastaSac+'PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.TXT';
         arquivoprocessado:=PastaSac+'PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.OK';

       end;

     end;


// 24.06.18
     if FileExists( arquivoprocessado ) then begin
//        Sistema.EndProcess('J� existe o arquivo '+arquivoprocessado+' .  Verificar');
// 08.08.18
          if not confirma('Arquivo de Itens dos pedidos '+arquivopedido+' j� importado .  Importar novamente ?') then begin
            Sistema.EndProcess('');
            exit;
          end else
          RenameFile( arquivoprocessado , copy(arquivoprocessado,1,pos('.',arquivoprocessado)-1)+'.TXT');
     end;

     arquivonoftp:='PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
     Sistema.BeginProcess('Importando itens dos pedidos arquivo '+arquivopedido);
  {
     if FileExists( arquivopedido ) then DeleteFile( arquivopedido );
     try
       ftp.Get(Arquivonoftp,Arquivopedido);
     except on E:exception do
       avisoerro('Problemas para baixar arquivo '+Arquivonoftp+' '+E.message);
     end;
  }
     ListaItens:=TStringList.Create;
     ListaItens.LoadFromFile(arquivopedido);

     if ListaItens.count=0 then begin
        Sistema.endprocess('Arquivo '+arquivopedido+' est� vazio ( sem itens )');
        exit;
     end;

     Sistema.BeginProcess('Lendo itens dos pedidos');

     for p:=0 to ListaItens.count-1 do begin

       ListaCampos:=TStringList.Create;
       strtolista(Listacampos,ListaItens[p],';',true);
       if ListaCampos.count>0 then
         GravaDetalhe( ListaCampos,p+1 );
       ListaCampos.Free;

     end;
   //     exit;
     ListaItens.Free;
     ListaNumeros.free;
//
   end;

   if gravoupedido then begin
      try
          sistema.Commit;
          RenameFile( arquivopedido , copy(arquivopedido,1,pos('.',arquivopedido)-1)+'.OK');
//          RenameFile( arquivoprocessado , copy(arquivoprocessado,1,pos('.',arquivoprocessado)-1)+'.TXT');
      except
          Avisoerro('Problemas na grava��o no banco de dados dos itens');
      end;
   end;

   END;   // REF. ao for
////////////////////////////////////////////////////////////////////////////

//   ftp.Disconnect;
//   ftp.Destroy;
   if gravoupedido then begin

     if mostramens='S' then  Sistema.endProcess('Importa��o Terminada');

   end else

     Sistema.endProcess('Nenhum pedido foi gravado');


end;

// 08.06.2021 - aqui inicio
/////////////////////////
// 'transformado em procedure para poder chamar e passar parametros...
procedure TFDiversos.Importapedidos(xdata: TDAtetime ; viapedidos:string='N' ; PMens:TPanel=nil);
///////////////////////////////////////////////////////////////////////////////////////////
var arquivopedido,arquivonoftp,xtransacao,Fpgt_codigo,Port_codigo,PortadorBoleto,xdrive,
    Vendedor,pastamovel,pedido,PastaSac,Tipomov,
    arquivoprocessado,
    arquivoclientes,
    arquivoproclientes :string;
    data,emissao       :Tdatetime;
    Lista,ListaCampos,ListaArq,ListaItens,
    ListaNumeros,
    Listacodigoscli,
    Listacodigoscli1                   :TStringList;
    p,i,codcliente,xnumero,N,inicio,fim:integer;
    Q                  :TSqlquery;
    valorpedido        :currency;
//    starquivopedido,
//    starquivoclientes  :TStringStream;
    gravoupedido,
    AchouArquivo,
    AchouArqClientes   :boolean;
    ListaClientes      :TStringList;

var
  hConnection, hOpen, hFind: PInteger;
  hData: TWIN32FINDDATA;


        function GetcodigoConvertido(xcodigo:string):integer;
        ///////////////////////////////////////////////////////
        var i : integer;
        begin

           result := strtoint(xcodigo);
           for i := 0 to ListaCodigosCli1.count-1 do begin

               if xcodigo = ListaCodigosCli1[i]  then result := strtoint(Listacodigoscli[i]);

           end;

        end;


    procedure GravaMestre(xLista:TStringList);
    /////////////////////
    begin
      emissao:=strtodate( xLista[1] );
      codcliente:=strtoint( xLista[2] );
// 03.02.2021 - Giacomoni - clientes incluidos via tablet
      codcliente := GetcodigoConvertido( inttostr(codcliente) );
//      EdCodcliente.text:=xLista[2];
      EdCodcliente.text:=inttostr(codcliente);
      EdCodcliente.ValidFind;
      Fpgt_codigo:=xLista[6];
      Port_codigo:=xLista[5];
      valorpedido:=Texttovalor( xlista[4] );
//      PortadorBoleto:='001';  // CRIAR CONFIGURACAO geral
// 01.06.20
      PortadorBoleto:= FGeral.GetConfig1AsString( 'Portaboletos' );
// 19.02.18
      if xLista.Count>7 then tipomov:=xLista[7] else tipomov:='PV';
      if trim(Tipomov)='' then tipomov:='PV';

      Q:=sqltoquery('select mped_numerodoc from movped where mped_status=''N'''+
                     ' and mped_tipo_codigo='+inttostr(codcliente)+
                     ' and mped_vlrtotal = '+Valortosql( valorpedido )+
//                     ' and mped_datamvto = '+Eddata.AsSql+
// 24.09.2021
                     ' and mped_datamvto = '+DatetoSql(Emissao)+
                     ' and mped_unid_codigo = '+Stringtosql(Global.CodigoUnidade) );
      if Q.eof then begin

        xtransacao:=FGeral.GetTransacao;
        xnumero:=FGeral.GetContador('PEDVENDA',false);
        ListaNumeros.add( StrToStrNumeros(xlista[0]) +';'+inttostr(xnumero)+';'+xtransacao );
        Sistema.Insert('Movped');
        Sistema.SetField('mped_transacao',xTransacao);
        Sistema.SetField('mped_operacao',FGeral.GetOperacao);
        Sistema.SetField('mped_status','N');
        Sistema.SetField('mped_numerodoc',xNumero);
        Sistema.SetField('mped_tipomov',Global.CodPedVenda);
        Sistema.SetField('mped_unid_codigo',Global.CodigoUnidade);
        Sistema.SetField('mped_tipo_codigo',codCliente);
        Sistema.SetField('mped_datalcto',Sistema.Hoje);
        Sistema.SetField('mped_datamvto',Emissao);
//        if port_codigo=PortadorBoleto then
// 01.06.20
        if AnsiPos( port_codigo, PortadorBoleto ) > 0 then
           Sistema.SetField('mped_datacont',Emissao);

        Sistema.SetField('mped_vlrtotal',ValorPedido);
//        if FCondpagto.GetAvPz(Fpgt_codigo)='V' then
//          Sistema.SetField('mped_valoravista',Valortotal)
//        else
//          Sistema.SetField('mped_valoravista',Valorparteavista);
        Sistema.SetField('mped_tabp_codigo',0);
        Sistema.SetField('mped_fpgt_codigo',Fpgt_codigo);
//        Sistema.SetField('mped_tabaliquota',FTabela.GetAliquota(Tabela));
        Sistema.SetField('mped_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('mped_pedcliente',StrToStrNumeros(xlista[0]));
        Sistema.SetField('mped_estado',EdcodCliente.resultfind.fieldbyname('clie_uf').asstring);
        Sistema.SetField('mped_cida_codigo',EdcodCliente.resultfind.fieldbyname('clie_cida_codigo_res').asinteger);
        Sistema.SetField('mped_repr_codigo',EdcodCliente.resultfind.fieldbyname('clie_repr_codigo').asinteger);
        Sistema.SetField('mped_tipocad','C');
        Sistema.SetField('mped_dataemissao',Emissao);
        Sistema.SetField('mped_totprod',valorpedido);
        Sistema.SetField('mped_vispra',FCondpagto.GetAvPz(Fpgt_codigo));
        Sistema.SetField('mped_perdesco',0);
        Sistema.SetField('mped_peracres',0);
        Sistema.SetField('mped_situacao','P');
//        Sistema.SetField('mped_formaped',EdFormapedido.text);
        Sistema.SetField('mped_envio','R');
        Sistema.SetField('Mped_fpgt_prazos',FCondpagto.GetCampoPrazos(Fpgt_codigo));
//        Sistema.SetField('mped_contatopedido',EdContato.text);
//        Sistema.SetField('mped_datapedcli',EdDatacliente.asdate);
//        Sistema.SetField('mped_obslibcredito',obsliberacao);
//        Sistema.SetField('mped_datalibcredito',sistema.hoje);
//        Sistema.SetField('mped_usualibcred',usuariolib);
        Sistema.SetField('mped_obspedido','Vendas Movel '+vendedor);
        Sistema.SetField('mped_port_codigo',Port_codigo);
// 19.02.18 - para importar pedidos identificados como PV, CM - comodato e BN - bonificacao
        if Tipomov='PV' then
          Sistema.SetField('mped_formaped','T')
        else if Tipomov='CM' then
          Sistema.SetField('mped_formaped','C')
        else if Tipomov='BN' then
          Sistema.SetField('mped_formaped','B');

        Sistema.Post();
//        if pos(tipomov,'PV;')>0 then
          FGeral.GravaPendencia(Emissao,emissao,EdcodCliente,'C',0,global.codigounidade,'PV',xtransacao,Fpgt_codigo,'R',xNumero,0,valorpedido,
                              0,'H',valorpedido,0,nil,'','001' );

      end else begin

         if mostramens='S' then

            Aviso('Aten��o !!!  J� encontrado pedido '+Q.FieldByName('mped_numerodoc').AsString+' de valor '+currtostr(valorpedido)+' codigo '+inttostr(codcliente)+' '+
                     FCadcli.GetNome(codcliente)+' nesta data' );
      end;

      FGeral.FechaQuery(Q);

    end;

    procedure GravaDetalhe(xLista:TStringList;xseq:integer);
    ///////////////////////////////////////////////////////////

                  procedure GetNumerodoMestre( cnumero:string );
                  /////////////////////////////////////////////////////////////
                  var i:integer;
                      ListaB:TStringList;
                  begin
                    for i:=0 to ListaNumeros.Count-1 do begin
                      ListaB:=TStringList.create;
                      strtolista(ListaB,ListaNumeros[i],';',true);
                      if cnumero=ListaB[0] then begin
                        xnumero:=strtoint( ListaB[1] );
                        xtransacao:=ListaB[2];
                        break;
                      end;
                    end;
                  end;

    begin

      Q:=sqltoquery('select mpdd_numerodoc from movpeddet where mpdd_status=''N'''+
                     ' and mpdd_tipo_codigo='+inttostr(codcliente)+
//                     ' and mpdd_datamvto = '+Eddata.AsSql+
// 24.09.2021
                     ' and mpdd_datamvto = '+DatetoSql(Emissao)+
                     ' and mpdd_numerodoc = '+inttostr(xnumero) +
                     ' and mpdd_esto_codigo = '+stringtosql(xLista[2])+
                     ' and mpdd_unid_codigo = '+Stringtosql(Global.CodigoUnidade) );
      if not Arq.TEstoque.Active then Arq.TEstoque.Open();
      if Q.eof then begin

        GetNumerodoMestre(strtostrnumeros(xLista[0]));
        codcliente:=strtoint( xLista[1] );
// 03.02.2021 - Giacomoni - clientes incluidos via tablet
        codcliente := GetcodigoConvertido( inttostr(codcliente) );
        Sistema.Insert('Movpeddet');
        Sistema.SetField('mpdd_transacao',xTransacao);
        Sistema.SetField('mpdd_operacao',FGeral.GetOperacao);
        Sistema.SetField('mpdd_status','N');
        Sistema.SetField('mpdd_numerodoc',xnumero);
        Sistema.SetField('mpdd_tipomov',Global.CodPedVenda);
        Sistema.SetField('mpdd_unid_codigo',Global.CodigoUnidade);
        Sistema.SetField('mpdd_tipo_codigo',codCliente);
        Sistema.SetField('mpdd_datalcto',Sistema.Hoje);
        Sistema.SetField('mpdd_datamvto',Emissao);
//        if port_codigo=PortadorBoleto then
// 01.06.20
        if AnsiPos( port_codigo, PortadorBoleto ) > 0 then
          Sistema.SetField('mpdd_datacont',Emissao);
        Sistema.SetField('mpdd_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('mpdd_repr_codigo',EdcodCliente.resultfind.fieldbyname('clie_repr_codigo').asinteger);
        Sistema.SetField('mpdd_tipocad','C');
/////
        Sistema.SetField('mpdd_esto_codigo',xLista[2]);
//        Sistema.SetField('mpdd_tama_codigo',strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),linha],0));
//        Sistema.SetField('mpdd_core_codigo',strtointdef(Grid.cells[Grid.getcolumn('codcor'),linha],0));
        Arq.TEstoque.locate('esto_codigo',xLista[2],[]);
        Sistema.SetField('mpdd_qtde',Texttovalor( xLista[4] ) );
        Sistema.SetField('mpdd_venda',Texttovalor( xLista[3] ) );
        Sistema.SetField('mpdd_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
        Sistema.SetField('mpdd_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
        Sistema.SetField('mpdd_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
        Sistema.SetField('mpdd_mate_codigo',Arq.TEstoque.fieldbyname('esto_mate_codigo').AsInteger);
        Sistema.SetField('mpdd_emlinha',Arq.TEstoque.fieldbyname('esto_emlinha').AsString);
        Sistema.SetField('mpdd_qtdeenviada',0);
        Sistema.SetField('mpdd_vendabru',Texttovalor( xLista[3] ) );
//        Sistema.SetField('mpdd_perdesco',Texttovalor(Grid.cells[Grid.getcolumn('perdesconto'),linha]));
        Sistema.SetField('mpdd_caoc_codigo',0);
        Sistema.SetField('mpdd_situacao','P');
        Sistema.SetField('mpdd_seq',xseq );
//        Sistema.SetField('mpdd_pecas',Texttovalor(Grid.cells[Grid.getcolumn('mpdd_pecas'),linha]) );
// 24.06.18 - grava o numero do pedido no tablet
        Sistema.SetField('mpdd_transacaonftrans',xLista[0] );

        Sistema.Post('');

      end;

      FGeral.FechaQuery(Q);
    end;

   function GetCodigoCidade(xnomecidade,xuf:string):integer;
    /////////////////////////////////////////////////////
    var Q:TSqlquery;
        codigo:integer;
    begin
        Q:=sqltoquery('select * from cidades where cida_nome='+stringtosql(xnomecidade)+
                       'and cida_uf='+Stringtosql(xuf) );
        if not Q.eof then
          codigo:=Q.fieldbyname('cida_codigo').asinteger
        else
          codigo:=999;    // para gerar erro ao testar a importacao...
        Q.close;Freeandnil(Q);
        result:=codigo;
    end;

    procedure GravaCliente(xLista:TStringList);
    ///////////////////////
    var desc,
        fantasia,
        cnpjcpf,
        fone,
        celular,
        uf,
        cep,
        nomecidade,
        email,
        bairro,
        complemento,
        endereco,
        condicaopg,
        codigotablet      :string;
        x,
        codigo,
        posnome,
        posfantasia,
        poscnpjcpf,
        posinsc,
        posfone,
        poscelular ,
        poscep,
        posemail,
        posbairro,
        posendereco,
        poscodvendedor,
        codvendedor,
        poscondicaopg    :integer;
        Qv,
        Qc               :TSqlquery;
        ListaLinha       :TStringList;


/////////////////////////////////////////////////////
    begin
/////////////////////////////////////////////////////

      ListaLinha      := TStringList.create;
//      ListaCodigosCli := TStringList.create;
//      ListaCodigosCli1:= TStringList.create;
      posnome     := 01;
      posfantasia := 02;
      poscnpjcpf  := 03;
      posinsc     := 04;
      posfone     :=  0;
      poscelular  :=  0;
      poscep      := 07;
      posemail    :=  0;
      posbairro   := 09;
      posendereco := 05;
      poscodvendedor := 12;
      poscondicaopg  := 13;

      codigo := FCadCli.GetProxCodigo('CLIENTES',false);
// aqui guardar o codigo do cliente q ser� usado no sac para mudar quando for importar
// o pedido feito com o codigo gerado no tablet...
///////////////////////////////////////////////////{
      ListaLINha.AddStrings( xLista );

      desc      := copy(ListaLInha[posnome],1,50);
      cnpjcpf   := trim(copy( ListaLInha[poscnpjcpf],1,14 ));
      Qc        := sqltoquery(' select clie_codigo,clie_nome from clientes where clie_cnpjcpf = '+
                              stringtosql( cnpjcpf ) );
      if not Qc.eof then begin

         Avisoerro('Cliente cnpj/cpf '+cnpjcpf+' j� cadastrado no cliente '+Qc.fieldbyname('clie_codigo').asstring+' - '+
                   Qc.fieldbyname('clie_nome').asstring);
         exit;

      end;

      codigotablet := trim(copy( ListaLInha[0],1,11 ))  ;
      ListaCodigosCli.add( inttostr(codigo) );
      ListaCodigosCli1.add( codigotablet );

      if posfone > 0  then fone := trim(copy( ListaLInha[posfone],1,11 )) else fone := '';
      if poscelular > 0  then celular := trim(copy( ListaLInha[poscelular],1,11 )) else celular := '';
      if poscep > 0  then cep := trim(copy( ListaLInha[poscep],1,08 )) else cep := '';
      uf := Global.UFUnidade;
      nomecidade := FCidades.GetNOme( FUnidades.GetCidaCodigo(Global.CodigoUnidade) );

      if length( cep )=8 then begin

//         Acbrcep1.buscarporcep( cep );
//         if ACBrCEP1.Enderecos.Count > 0 then begin
         if Acbrcep1.buscarporcep( cep ) > 0 then begin

            uf         := ACBrCEP1.Enderecos[0].UF;
            nomecidade := ACBrCEP1.Enderecos[0].Municipio;

         end;

      end;

      if posbairro>0  then bairro := trim(copy( ListaLInha[posbairro],1,20 )) else bairro := '';
      if posemail>0   then email  := trim(copy( ListaLInha[posemail],1,50 )) else email := '';
      complemento := '';
      if posendereco>0  then endereco := trim(copy( ListaLInha[posendereco],1,50 )) else endereco := '';
      if poscodvendedor>0  then codvendedor := strtoint(trim(copy( ListaLInha[poscodvendedor],1,5 ))) else codvendedor := 0;
      if poscondicaopg>0  then condicaopg := (trim(copy( ListaLInha[poscondicaopg],1,3 ))) else condicaopg := '';

      if pos('',desc)>0 then desc:=copy(ListaLInha[posnome],1,pos('',desc)-1)+' '+copy(desc,pos('',desc)-1,30);
      fantasia:=copy(ListaLInha[posfantasia],1,40);
      if pos('',fantasia)>0 then fantasia:=copy(ListaLInha[posnome],1,pos('',fantasia)-1)+' '+copy(fantasia,pos('',fantasia)-1,30);
      x:=pos('�',fantasia);
      if x>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
        fantasia:=copy(fantasia,1,x-1)+'�'+copy(fantasia,x+2,length(desc)-x);
      x:=pos('�',fantasia);
      if x>0 then
        fantasia:=copy(fantasia,1,x)+copy(fantasia,x+2,length(fantasia)-x);

/////////////
      x:=pos('�',desc);
      if x>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
        desc:=copy(desc,1,x-1)+'�'+copy(desc,x+2,length(desc)-x);
      x:=pos('�',desc);
      if x>0 then
        desc:=copy(desc,1,x)+copy(desc,x+2,length(desc)-x);

      Sistema.Insert('clientes');
      Sistema.SetField('clie_codigo',codigo);
//      Sistema.SetField('clie_codigo_ant',codigoant);

      Sistema.SetField('clie_razaosocial',Specialcase(desc));
////      if (pos('/',fantasia)>0)  SEFA SP
      if (trim(fantasia)='') then //
         Sistema.SetField('clie_nome',Specialcase(desc))
      else
         Sistema.SetField('clie_nome',Specialcase(fantasia));

      Sistema.SetField('clie_cnpjcpf', cnpjcpf);
      Sistema.SetField('clie_rgie',copy(StrtoStrDigitos(ListaLInha[posinsc]),1,20) );
      Sistema.SetField('clie_foneres',fone);
      Sistema.SetField('clie_fonecel',celular);
//      Sistema.SetField('clie_dtcad',Sistema.Hoje);
      Sistema.SetField('clie_unid_codigo',Global.CodigoUnidade);
      Sistema.SetField('clie_uf',uf);
      Sistema.SetField('clie_ipi','N');
//      if ListaLInha[1]='CPF' then
      if length(trim(StrtoStrDigitos( ListaLInha[poscnpjcpf] ))) < 14 then begin

        Sistema.SetField('clie_tipo','F');
        Sistema.SetField('clie_contribuinte','N');
        Sistema.SetField('clie_consfinal','S');

      end else begin

        Sistema.SetField('clie_tipo','J');
        if trim( copy(StrtoStrDigitos(ListaLInha[posinsc]),1,20) ) = '' then begin

          Sistema.SetField('clie_contribuinte','N');
          Sistema.SetField('clie_consfinal','S');

        end else begin

          Sistema.SetField('clie_contribuinte','S');
          Sistema.SetField('clie_consfinal','N');

        end;

      end;
      Sistema.SetField('Clie_cepres',cep);
      Sistema.SetField('Clie_cepcom',cep);
      Sistema.SetField('Clie_email',email);
      Sistema.SetField('Clie_bairrores',bairro);
      Sistema.SetField('Clie_bairrocom',bairro);

      Sistema.SetField('Clie_endrescompl',complemento);
//
//      if (trim(numero)<>'') and ( strtointdef(numero,0)>0 ) then begin
//        Sistema.SetField('Clie_endres',copy(trim(endereco)+','+numero,1,40));
//        Sistema.SetField('Clie_endcom',copy(trim(endereco)+','+numero,1,40));
//      end else begin
        Sistema.SetField('Clie_endres',copy(endereco,1,50));
        Sistema.SetField('Clie_endcom',copy(endereco,1,50));
//      end;
      Sistema.SetField('Clie_cida_codigo_res',GetCodigoCidade(nomecidade,uf));
      Sistema.SetField('Clie_cida_codigo_com',GetCodigoCidade(nomecidade,uf));

      Sistema.SetField('Clie_fonecom',fone);
      Sistema.SetField('Clie_dtcad',Sistema.Hoje);
      Sistema.SetField('Clie_obs','INCLUIDO VENDAS MOVEL');
//      Sistema.SetField('Clie_dtnasc',DataNascimento);
//      Sistema.SetField('Clie_fax',fonefax);

      Sistema.SetField('Clie_cidade',nomecidade);

      if codvendedor > 0 then

         Sistema.SetField('Clie_repr_codigo',codvendedor)

      else

         Sistema.SetField('Clie_repr_codigo',1);

// 02.02.21
      if trim(condicaopg) <> '' then

         Sistema.SetField('Clie_fpgt_codigo',condicaopg)

      else

         Sistema.SetField('Clie_repr_codigo','001');

////////////////////////
      Sistema.SetField('clie_usua_codigo',998);
      Sistema.Post();

      {
      if codvendedor > 0 then begin

         Qv:=sqltoquery('select repr_codigo from representantes where repr_codigo='+inttostr(codvendedor));
         if QV.eof then begin

            Sistema.Insert('representantes');
            Sistema.SetField('repr_codigo',codvendedor);
            Sistema.SetField('repr_nome',nomevendedor);
            Sistema.SetField('repr_razaosocial',nomevendedor);
            Sistema.SetField('repr_cida_codigo',1);
            Sistema.Post();

         end;
         QV.close;Qv.free;

      end;
      }
//////////////////////////////////////////    }


    end;

begin
////////////////////////////////////////////
// busca arquivo do ftp 'bala'    desativada por enquanto
//////////////////////////////
   if Datetoano(xdata,true) < 1902 then begin

     Avisoerro('Problemas com a data informada '+FGeral.formatadata(xdata));
     exit;

   end;
////////////////////////////////////////////////////////////////////////
{
   ftp:=TIdftp.Create(self);
//   ftp.Disconnect;
   if cblocal.Checked then
     ftp.Host:='192.168.1.1'
   else
     ftp.Host:='storollicia.no-ip.info';
//   ftp.Host:='187.109.101.90';
   ftp.Port:=60500;
   ftp.Password:='clientes';
   ftp.Username:='clientes';
//   ftp.Password:='andre';
 //  ftp.Username:='andre';
   ftp.Passive:=true;
   ftp.ReadTimeout:=500000;

 //   }
   {
   ftpacbr.ftp.ftpHost:='storollicia.no-ip.info';
//   ftp.Host:='187.109.101.90';
   ftpacbr.ftp.ftpPort:='60500';
   ftpacbr.ftp.ftpPass:='clientes';
   ftpacbr.ftp.ftpUser:='clientes';
//   ftpacbr.DownloadUrl:='ftp://storollicia.no-ip.info:60500';
//   }

   data:=xdata;
//   arquivopedido:='C:\delphisac\programa\PEDM'+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.TXT';
   PastaSac:=ExtractFilePath( application.ExeName );
   xdrive:= 'c:';
// 05.06.18
   if not FileExists( PastaSac+'Sacxe7.exe' ) then
     xdrive:='d:';
   if not FileExists( PastaSac+'Sacxe7.exe' ) then
     xdrive:='e:';
/////////////////////////////
// 25.01.17
   pastamovel:=FGeral.GetConfig1AsString('pastachecaped');
///////////////////////////////////////////////////////////////////////////////
   gravoupedido:=false;
   inicio:=0 ;
   fim   :=50;
{ // deixado pra pegar todos os arquivos q tiverem...
   if not EdTablet.IsEmpty then begin
     inicio:=strtoint(EdTablet.text);
     fim:=(inicio);
   end;
   }

// 01.02.2021 - primeiro importa clientes inclusos via tablet
   ListaClientes := TStringList.create;
// 09.06.2021 - aqui para pode chamar como fun�ao..
   ListaCodigosCli := TStringList.create;
   ListaCodigosCli1:= TStringList.create;

   FOR N:= inicio TO fim DO BEGIN

       if n=0 then vendedor:='0' else vendedor:=inttostr(N);
       if trim(pastamovel)<>'' then begin

          arquivoclientes    := PastaSac+pastamovel+'\CLIE'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
          arquivoproclientes := PastaSac+pastamovel+'\CLIE'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.OK';

       end else begin

          arquivoclientes    := PastaSac+'CLIE'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
          arquivoproclientes := PastaSac+'CLIE'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.OK';

       end;

       AchouArqClientes := false;
       if FileExists( arquivoclientes ) then AchouArqClientes := true;
{
       if FileExists( arquivoproclientes ) then begin

          if not confirma('Arquivo de CLIENTES '+arquivoclientes+' j� importado .  Importar novamente ?') then begin
            Sistema.EndProcess('');
            exit;
          end else
            RenameFile( arquivoproclientes , copy(arquivoproclientes,1,pos('.',arquivoproclientes)-1)+'.TXT');

       end;
}

////////////////////////////////////////////////////////////
       Sistema.BeginProcess('Importando CLIENTES do arquivo '+arquivoclientes);
//       starquivoclientes := TStringStream.Create('');
       Lista        := TStringList.Create;
       ListaNumeros := TStringlist.Create;
//       Lista.LoadFromStream(starquivoclientes);
       if AchouArqClientes then begin

           Lista.LoadfromFile(arquivoclientes);

           if Lista.count=0 then begin
              Sistema.endprocess('IMPORTA��O INTERROMPIDA.  Arquivo '+arquivoclientes+' est� vazio');
              exit;
           end;

           Sistema.BeginProcess('Lendo arquivo de clientes');
           for p:=0 to Lista.count-1 do begin

             ListaCampos := TStringList.Create;
             strtolista(Listacampos,Lista[p],';',true);
             if Listacampos.Count>0 then
                GravaCliente( ListaCampos );
             ListaCampos.Free;

           end;
//       gravoupedido:=true;

//         RenameFile( arquivoclientes , copy(arquivoclientes,1,pos('.',arquivoclientes)-1)+'.OK');
         RenameFile( arquivoclientes , copy(arquivoclientes,1,pos('.',arquivoclientes)-1)+'.PROC');
         Lista.free;
         ListaNumeros.free;

      end;

   END;
   LIstaClientes.free;
//////////////////////////////////////////////////////////////

   FOR N:= inicio TO fim DO BEGIN

//   if n=0 then vendedor:='' else vendedor:=inttostr(N);
// 30.09.19
   if n=0 then vendedor:='0' else vendedor:=inttostr(N);
   if trim(pastamovel)<>'' then begin

     arquivopedido    :=PastaSac+pastamovel+'\PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
     arquivoprocessado:=PastaSac+pastamovel+'\PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.OK';

   end else begin

     arquivopedido:=PastaSac+'PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
     arquivoprocessado:=PastaSac+'PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.OK';

   end;

// 23.10.19
   AchouArquivo:=false;
   if not FileExists( arquivopedido ) then begin

       if trim(pastamovel)<>'' then begin

         arquivopedido:=PastaSac+pastamovel+'\PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.TXT';
         arquivoprocessado:=PastaSac+pastamovel+'\PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.OK';

       end else begin

         arquivopedido:=PastaSac+'PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.TXT';
         arquivoprocessado:=PastaSac+'PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.OK';

       end;
       if FileExists( arquivopedido ) then AchouArquivo:=true;

   end else AchouArquivo:=true;

//   arquivonoftp:='BkpClientes/Vendasmovel/'+'PEDM'+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
     arquivonoftp:='PEDM'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
//   arquivonoftp:='SerialMFD.rar';

{
   ftpacbr.DownloadDest:=xdrive+'\sac';
//   ftpacbr.DownloadNomeArq:='/'+'BkpClientes'+'/'+'Vendasmovel/'+arquivonoftp;
   ftpacbr.DownloadNomeArq:=arquivonoftp;
   ftpacbr.Protocolo:=protFTP;
}

///////////////////////////////////////////
        {
  hOpen := InternetOpen ('', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
//  hConnection := InternetConnect (hOpen, pansichar(ftp.host), INTERNET_DEFAULT_FTP_PORT,
//    pansichar(ftp.username),pansichar(ftp.password), INTERNET_SERVICE_FTP, INTERNET_FLAG_PASSIVE, 0);
  hConnection := InternetConnect (hOpen, pansichar(ftp.host), ftp.port,
    pansichar(ftp.username),pansichar(ftp.password), INTERNET_SERVICE_FTP, INTERNET_REQFLAG_PASSIVE, 0);
//  FtpSetCurrentDirectory (hConnection, '/BkpClientes/Vendasmovel');
  FtpSetCurrentDirectory (hConnection, '/');
  hFind := FtpFindFirstFile (hConnection, 'desligar.sh' , hData, 0, 0);

  if hFind = nil then
    pmens.Caption := 'n�o foi encontrado'
  else
    pmens.Caption := 'encontrado';

  InternetCloseHandle (hConnection);
  InternetCloseHandle (hOpen);

  aviso('');
       }
/////////////////////////////////////////////
{
   Sistema.BeginProcess('Checando vendas no ftp');
   try
     try
//        ftp.Connect(true,10000);
        ftp.Connect();
//        ftpacbr.StartDownload;
     except
       on E:exception do
       Sistema.endProcess('Problemas para conectar no ftp:'+ftp.Host+':'+inttostr(ftp.Port));
//       Sistema.BeginEndprocess('Problemas para conectar no ftp:'+ftpacbr.ftp.ftpHost+':'+ftpacbr.ftp.ftpPort+' '+E.Message);
     end;
   finally
}
//    ftp.ChangeDir('BkpClientes');
//    ftp.ChangeDir('Vendasmovel');
//    ftp.ChangeDir('..');
//    ftp.ChangeDir('/home/clientes');
//      aviso('Problemas para conectar no ftp:'+ftpacbr.ftp.ftpHost+':'+ftpacbr.ftp.ftpPort);
//   end;
// busca pedidos de venda no ftp de 'ontem+2dias' devido a segunda buscar de sexta
///   if FileExists( arquivopedido ) then DeleteFile( arquivopedido );


   Lista:=TStringList.Create;
   Sistema.BeginProcess('Importando totais dos pedidos do arquivo '+arquivopedido);
//   starquivopedido:=TStringStream.Create('');

{
   try
     ftp.Get(Arquivonoftp,Arquivopedido,true);
//     ftp.Get(Arquivonoftp,stArquivopedido,true);
//     ftp.CheckForGracefulDisconnect();

   except on E:exception do
     avisoerro('Problemas para baixar arquivo '+Arquivonoftp+' '+E.message);
   end;
}
//   if not FileExists( arquivopedido ) then
//     Sistema.endprocess('Arquivo '+arquivopedido+' n�o encontrado')

//    if Global.Usuario.Codigo=100 then Aviso('Arquivo pedido:'+arquivopedido);


{
// 24.06.18
   if ( FileExists( arquivoprocessado ) ) and ( viapedidos <> 'S' ) then begin

//      Sistema.EndProcess('J� existe o arquivo '+arquivoprocessado+' .  Verificar');
//
      if not confirma('Arquivo de totais dos pedidos '+arquivopedido+' j� importado .  Importar novamente ?') then begin

        Sistema.EndProcess('');
        exit;

      end else

        RenameFile( arquivoprocessado , copy(arquivoprocessado,1,pos('.',arquivoprocessado)-1)+'.TXT');

   end else   if ( FileExists( arquivoprocessado ) ) and ( viapedidos = 'S' ) then

       achouarquivo := false;
}

//   if FileExists( arquivopedido ) then begin
// 23.10.19 -
   if AchouArquivo then begin

////////////////////////////////////////////////////////////
     Lista:=TStringList.Create;
     ListaNumeros:=TStringlist.Create;
  //   Lista.LoadFromFile(arquivopedido);
//     Lista.LoadFromStream(starquivopedido);
     Lista.LoadfromFile(arquivopedido);
  {
     if Lista.count=0 then begin
       arquivopedido:=xdrive+'\sac\PEDM'+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,false),4)+'.TXT';
       arquivonoftp:='PEDM'+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,false),4)+'.TXT';
       try
         ftp.Get(Arquivonoftp,Arquivopedido,true);
       except on E:exception do
     //    avisoerro('Problemas para baixar arquivo '+Arquivonoftp+' '+E.message);
       end;
       Lista.LoadFromFile(arquivopedido);
     end;
  }
     if Lista.count=0 then begin
        Sistema.endprocess('Arquivo '+arquivopedido+' est� vazio ( sem vendas )');
        exit;
     end;
// 05.06.17 - para prever 'varias importadas' no dia para q nao apare�a de novo o pedido
//            pra ser faturado
     {
     Q:=sqltoquery('select mped_transacao from movped where mped_obspedido='+Stringtosql('Vendas Movel'+vendedor)+
                   ' and mped_datamvto='+DatetoSql(data)+' and mped_unid_codigo='+Stringtosql(Global.codigounidade)+
                   ' and mped_status=''N''');
     while not Q.eof do begin
       ExecuteSql('update movpeddet set mpdd_status=''C'' where mpdd_transacao='+Stringtosql(Q.fieldbyname('mped_transacao').asstring));
       ExecuteSql('update movped set mped_status=''C'' where mped_transacao='+Stringtosql(Q.fieldbyname('mped_transacao').asstring));
       Q.Next;
     end;
     Q.close;
     }
     Sistema.BeginProcess('Lendo totais dos pedidos');
     for p:=0 to Lista.count-1 do begin

       ListaCampos:=TStringList.Create;
       strtolista(Listacampos,Lista[p],';',true);
       if Listacampos.Count>0 then

         GravaMestre( ListaCampos );

       ListaCampos.Free;

     end;
     gravoupedido:=true;

//     RenameFile( arquivopedido , copy(arquivopedido,1,pos('.',arquivopedido)-1)+'.OK');
     RenameFile( arquivopedido , copy(arquivopedido,1,pos('.',arquivopedido)-1)+'.PROC');
// 24.09.2021
     if FileExists( arquivopedido ) then DeleteFile( arquivopedido );

     if trim(pastamovel)<>'' then begin

       arquivopedido    :=PastaSac+pastamovel+'\PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
       arquivoprocessado:=PastaSac+pastamovel+'\PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.OK'

     end else begin

       arquivopedido    :=PastaSac+'PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
       arquivoprocessado:=PastaSac+'PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.OK';

     end;

// 23.10.19
     if not FileExists( arquivopedido ) then begin

       if trim(pastamovel)<>'' then begin

         arquivopedido    :=PastaSac+pastamovel+'\PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.TXT';
         arquivoprocessado:=PastaSac+pastamovel+'\PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.OK'

       end else begin

         arquivopedido    :=PastaSac+'PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.TXT';
         arquivoprocessado:=PastaSac+'PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),4)+'.OK';

       end;

     end;

{
/// 24.06.18
     if FileExists( arquivoprocessado ) then begin
//        Sistema.EndProcess('J� existe o arquivo '+arquivoprocessado+' .  Verificar');
// 08.08.18
          if not confirma('Arquivo de Itens dos pedidos '+arquivopedido+' j� importado .  Importar novamente ?') then begin
            Sistema.EndProcess('');
            exit;
          end else
          RenameFile( arquivoprocessado , copy(arquivoprocessado,1,pos('.',arquivoprocessado)-1)+'.TXT');
     end;
}

     arquivonoftp:='PEDD'+Vendedor+strzero(Datetodia(data),2)+strzero(Datetomes(data),2)+strzero(Datetoano(data,true),2)+'.TXT';
     Sistema.BeginProcess('Importando itens dos pedidos arquivo '+arquivopedido);
  {
     if FileExists( arquivopedido ) then DeleteFile( arquivopedido );
     try
       ftp.Get(Arquivonoftp,Arquivopedido);
     except on E:exception do
       avisoerro('Problemas para baixar arquivo '+Arquivonoftp+' '+E.message);
     end;
  }
     ListaItens:=TStringList.Create;
     ListaItens.LoadFromFile(arquivopedido);

     if ListaItens.count=0 then begin
        Sistema.endprocess('Arquivo '+arquivopedido+' est� vazio ( sem itens )');
        exit;
     end;

     Sistema.BeginProcess('Lendo itens dos pedidos');

     for p:=0 to ListaItens.count-1 do begin

       ListaCampos:=TStringList.Create;
       strtolista(Listacampos,ListaItens[p],';',true);
       if ListaCampos.count>0 then
         GravaDetalhe( ListaCampos,p+1 );
       ListaCampos.Free;

     end;
   //     exit;
     ListaItens.Free;
     ListaNumeros.free;
//
   end;

   if gravoupedido then begin
      try
          sistema.Commit;
//          RenameFile( arquivopedido , copy(arquivopedido,1,pos('.',arquivopedido)-1)+'.OK');
          RenameFile( arquivopedido , copy(arquivopedido,1,pos('.',arquivopedido)-1)+'.PROC');
// 24.09.2021
          if FileExists( arquivopedido ) then DeleteFile( arquivopedido );

//          RenameFile( arquivoprocessado , copy(arquivoprocessado,1,pos('.',arquivoprocessado)-1)+'.TXT');
      except
          Avisoerro('Problemas na grava��o no banco de dados dos itens');
      end;
   end;

   END;   // REF. ao for
////////////////////////////////////////////////////////////////////////////

//   ftp.Disconnect;
//   ftp.Destroy;
   if gravoupedido then begin

     if mostramens='S' then  Sistema.endProcess('Importa��o Terminada');
     PMens.Color:=clred;
     PMens.Caption:='Pedido(s) gravado(s)';

   end else if viapedidos = 'N' then

     Sistema.endProcess('Nenhum pedido foi gravado')

   else begin

     Sistema.endProcess('');
     if PMens<>nil then

        PMens.Color:=clred;
        PMens.Caption:='Nenhum pedido foi gravado';

   end;

end;

///////////////////////////////////////////////////////////////////////////

procedure TFDiversos.ftpacbrHookMonitor(Sender: TObject;
  const BytesToDownload, BytesDownloaded: Integer;
  const AverageSpeed: Double; const Hour, Min, Sec: Word);

  var sConnectionInfo:string;

begin
  sConnectionInfo := sConnectionInfo + '  -  ' +
                     Format('%.2d:%.2d:%.2d', [Sec div 3600, (Sec div 60) mod 60, Sec mod 60]);

  sConnectionInfo := FormatFloat('0.00 KB/s'  , AverageSpeed) + sConnectionInfo;
  sConnectionInfo := FormatFloat('###,###,##0', BytesDownloaded / 1024) + ' / ' +
                     FormatFloat('###,###,##0', BytesToDownload / 1024) +' KB  -  ' + sConnectionInfo;

  Caption := sConnectionInfo;
  showmessage( sConnectionInfo  );
end;

procedure TFDiversos.ftpacbrBeforeDownload(Sender: TObject);
begin
//   aviso('Nomearq'+ftpacbr.DownloadNomeArq+' |Url'+ftpacbr.DownloadUrl+' |Dest'+ftpacbr.DownloadDest  );
end;

procedure TFDiversos.chuftpWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
  Pmens.caption:='workbegin BoundIP:'+ftp.BoundIP;
//   bimportar.caption:='workbegin dir:'+ftp.RetrieveCurrentDir;

end;

procedure TFDiversos.chuftpWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  Pmens.caption:='work BoundIP:'+ftp.BoundIP;
// bimportar.caption:='NO work dir:'+ftp.RetrieveCurrentDir;

end;

procedure TFDiversos.chuftpAfterClientLogin(Sender: TObject);
begin
//   aviso('No after cliente login diretorio:'+ftp.RetrieveCurrentDir+'|');
//  bimportar.caption:=ftp.RetrieveCurrentDir+'|';
//  bimportar.caption:=ftp.currentReadBuffer+'|';

     Pmens.caption:='dir:'+ftp.RetrieveCurrentDir+'|'+ftp.Host;

end;

procedure TFDiversos.chuftpAfterGet(ASender: TObject; VStream: TStream);
begin
  Pmens.caption:='after get diretorio:'+ftp.RetrieveCurrentDir+'|';

end;

// 01.06.15
procedure TFDiversos.ExpCadastroMovelClientes;
////////////////////////////////////////////////
begin
  Caption:='Exporta��o De Clientes para Vendas M�vel(celular,tablet)';
  Width  :=450;
  Height :=435;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgExportaMovel;
  Cadastro:='clientes';
  bimportar.Visible:=false;
  EdTablet.Visible:=false;
  EdData.Visible:=false;
  cblocal.Visible:=true;
  edfiltro.Visible:=false;
  ShowModal;

end;

// 01.06.15
procedure TFDiversos.ExpCadastroMovelEstoque;
////////////////////////////////////////////////
begin
  Caption:='Exporta��o Do Estoque para Vendas M�vel(celular,tablet)';
  Width:=450;Height:=405;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgExportaMovel;
  Cadastro:='estoque';
  bimportar.Visible:=false;
  EdTablet.Visible:=false;
  EdData.Visible:=false;
  cblocal.Visible:=true;
  edfiltro.Visible:=true;
  ActiveControl:=EdFiltro;
  FGrupos.SetaItems(EdFiltro,nil,'','');
  EdFiltro.Title:='Grupos do Estoque';
  EdFiltro.ItemsLength:=6;
  EdFiltro.ItemsMultiples:=true;
  ShowModal;

end;

// 01.06.15
procedure TFDiversos.ExpCadastroMovelPortadores;
////////////////////////////////////////////////
begin
  Caption:='Exporta��o De Portadores/Cond.Pagto Vendas M�vel(celular,tablet)';
  Width:=450;
  Height:=435;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgExportaMovel;
  Cadastro:='portadores';
  bimportar.Visible:=false;
  EdTablet.Visible:=false;
  EdData.Visible:=false;
  cblocal.Visible:=true;
  edfiltro.Visible:=false;
  ShowModal;

end;

// 27.11.15
procedure TFDiversos.ImportaContagemTexto;
///////////////////////////////////////////
var  poscodigo,posdescricao,posdescor,posdestamanho,posestoque,poscor,postamanho,p,incluidos,codcor,
     codtamanho:integer;
     SEPARADOR,produto,transacao,TipoMovimento:string;
     ListaLinha,ListaItens,ListaNaoCad:TStringList;
     QEst:TSqlquery;
     qtde:currency;



     function GetCodigo(xtabela,xpesquisa:string):integer;
     //////////////////////////////////////////////////////
     var Qc:Tsqlquery;
         xcodigo,xsql,xdescricao:string;
     begin
       if xtabela='cores' then begin
          xcodigo:='core_codigo';
          xdescricao:='core_descricao';
       end else begin
          xcodigo:='tama_codigo';
          xdescricao:='tama_descricao';
       end;
       xsql:='select '+xcodigo+' from '+xtabela+' where '+xdescricao+' = '+Stringtosql(trim(xpesquisa));
       Qc:=sqltoquery(xsql);
       if not Qc.eof then
         result:=Qc.fieldbyname(xcodigo).asinteger
       else begin
       //  result:=0;
         //{
         result:=FGeral.GetProximoCodigoCadastro(xtabela,xcodigo);
         Sistema.Insert( xtabela);
         if xtabela='cores' then begin
            Sistema.setfield('core_codigo',result);
            Sistema.setfield('core_descricao',xpesquisa);
         end else begin
            Sistema.setfield('tama_codigo',result);
            Sistema.setfield('tama_descricao',xpesquisa);
            Sistema.setfield('tama_reduzido',xpesquisa);
         end;
         Sistema.post;
         sistema.commit;
        // }
       end;
       Qc.close;
     end;


     procedure GravaMestre;
     ////////////////////////
     begin
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacao);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',505);
      Sistema.SetField('moes_tipomov',TipoMovimento);
      Sistema.SetField('moes_unid_codigo',Global.codigounidade);
      Sistema.SetField('moes_estado',Global.ufunidade);
//      Sistema.SetField('moes_repr_codigo',Representante);
      Sistema.SetField('moes_tipo_codigo',Global.codigounidade);
      Sistema.SetField('moes_tipocad','U');
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',EdData.AsDate);
      Sistema.SetField('moes_dataemissao',EdData.AsDate);
//      Sistema.SetField('moes_vlrtotal',Valortotal);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.Post();
   end;

   procedure gravadetalhe;
   ///////////////////////////////
   begin
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',produto);
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',505);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',TipoMovimento);
      Sistema.SetField('move_unid_codigo',Global.codigounidade);
      Sistema.SetField('move_tipo_codigo',Global.codigounidade);
      Sistema.SetField('move_tipocad','U');
//      Sistema.SetField('move_repr_codigo',Representante);
      Sistema.SetField('move_qtde',qtde);
      Sistema.SetField('move_estoque',Qtde);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',EdDAta.asdate);
      if not QEst.eof then begin
        Sistema.SetField('move_grup_codigo',QESt.fieldbyname('esto_grup_codigo').AsInteger);
        Sistema.SetField('move_sugr_codigo',QESt.fieldbyname('esto_sugr_codigo').AsInteger);
        Sistema.SetField('move_fami_codigo',QESt.fieldbyname('esto_fami_codigo').AsInteger);
      end;
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_pecas',0);
      Sistema.SetField('move_estoquepc',0);
      Sistema.SetField('move_core_codigo',Codcor);
      Sistema.SetField('move_tama_codigo',Codtamanho);

      Sistema.Post('');
   end;

   procedure IncluiEstoque;
   //////////////////////////
   var desc:string;
       x:integer;
   begin
      Sistema.Insert('estoque');
      Sistema.SetField('esto_codigo',produto);
      desc:=trim(copy(ListaLinha[posdescricao]+space(50),1,50));
      x:=pos('/',desc);
      if x>0 then
        desc:=copy(desc,1,x-1)+' '+copy(desc,x+1,length(desc)-x);
      x:=pos('/',desc);
      if x>0 then
        desc:=copy(desc,1,x-1)+' '+copy(desc,x+1,length(desc)-x);
      Sistema.SetField('esto_descricao',Specialcase(desc));
      Sistema.SetField('esto_unidade','UN');
//      Sistema.SetField('esto_codbarra').AsString:= Tabela.FieldByName('CODIRE').AsString;
      Sistema.SetField('esto_embalagem',1);
      Sistema.SetField('esto_peso',0);
      Sistema.SetField('esto_emlinha','S');
      Sistema.SetField('esto_usua_codigo',995);
      Sistema.SetField('esto_sugr_codigo',1);
//campos not null...
      Sistema.SetField('esto_fami_codigo',1);
      Sistema.SetField('esto_grup_codigo',1);
      Sistema.SetField('esto_REFERENCIA','');
      Sistema.Post();

      Sistema.Insert('estoqueqtde');
      Sistema.Setfield('esqt_status','N');
      Sistema.Setfield('esqt_unid_codigo',Global.CodigoUnidade);
      Sistema.Setfield('esqt_esto_codigo',Produto);
      Sistema.Setfield('esqt_qtde',0);
      Sistema.Setfield('esqt_qtdeprev',0);
{
      Sistema.Setfield('esqt_vendavis',EdEsto_vendavis.AsCurrency);
      Sistema.Setfield('esqt_custo',EdEsto_custo.AsCurrency);
      Sistema.Setfield('esqt_custoger',EdEsto_custoger.AsCurrency);
      Sistema.Setfield('esqt_customedio',EdEsto_customedio.AsCurrency);
      Sistema.Setfield('esqt_customeger',EdEsto_customeger.AsCurrency);
      Sistema.Setfield('esqt_dtultvenda',EdEsto_dtultvenda.AsDate);
      Sistema.Setfield('esqt_dtultcompra',EdEsto_dtultcompra.AsDate);
      Sistema.Setfield('esqt_desconto',EdEsto_desconto.AsCurrency);
      Sistema.Setfield('esqt_basecomissao',EdEsto_basecomissao.AsCurrency);
}
      Sistema.Setfield('esqt_cfis_codigoest',FUnidades.GetFiscalDentro(Global.CodigoUnidade) );
      Sistema.Setfield('esqt_cfis_codigoforaest',FUnidades.GetFiscalFora(Global.CodigoUnidade));
      Sistema.Setfield('esqt_sitt_codestado',FUnidades.GetSittDentro(Global.CodigoUnidade));
      Sistema.Setfield('esqt_sitt_forestado',FUnidades.GetSittFora(Global.CodigoUnidade));

      Sistema.Setfield('esqt_usua_codigo',995);
//      Sistema.Setfield('esqt_vendamin',EdEsto_vendamin.AsCurrency);
//      Sistema.Setfield('esqt_pecas',EdEsto_pecas.AsFloat);
//      Sistema.Setfield('esqt_custoser',EdMobra.AsFloat);
//      Sistema.Setfield('esqt_customedioser',EdMomedio.AsFloat);
//      Sistema.Setfield('esqt_codbarra',EdEsto_codbarra.text);
      Sistema.post;

        Sistema.Insert('estgrades');
        Sistema.Setfield('esgr_status','N');
        Sistema.Setfield('esgr_unid_codigo',Global.codigounidade);
        Sistema.Setfield('esgr_esto_codigo',produto);
        Sistema.Setfield('esgr_grad_codigo',0);
        Sistema.Setfield('esgr_usua_codigo',995);
        Sistema.Setfield('esgr_tama_codigo',codtamanho);
        Sistema.Setfield('esgr_core_codigo',Codcor);
        Sistema.Setfield('esgr_copa_codigo',0);
        Sistema.Setfield('esgr_qtde',0);
        Sistema.Setfield('esgr_qtdeprev',0);
        Sistema.Setfield('esgr_codbarra',produto+strzero(codtamanho,3)+strzero(codcor,3));
{
        Sistema.Setfield('esgr_custo',custounitario);
        Sistema.Setfield('esgr_customedio',custounitario);
        Sistema.Setfield('esgr_custoger',custounitario);
        Sistema.Setfield('esgr_customeger',custounitario);
        Sistema.Setfield('esgr_vendavis',vendaunitario);
}
//        Sistema.Setfield('esgr_dtultvenda',EdEsto_dtultvenda.asdate);
//        Sistema.Setfield('esgr_dtultcompra',EdEsto_dtultcompra.asdate);
        Sistema.post;



   end;

begin
////////////////////
  Width:=561;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgImportaEstoque;
  EdArquivodbf.enabled:=false;
  Eddata.enabled:=true;
  Eddata.visible:=true;
  ActiveControl:=EdArquivoTexto;
  PMens.Caption:='Importa��o Contagem do Estoque';
  Caption:='Importa��o Contagem do Estoque';
// ver para pedir a data com input
  EdDAta.setdate( Texttodate('22112015') );
  bConfirmar.Visible:=True;bConfirmar.Top:=bSair.Top+25;
  wRet:=False;
  TipoMovimento:=Global.CodContagemBalancoS;
  poscodigo:=1;posdescricao:=2;posdescor:=5;
  posdestamanho:=4;
  posestoque:=6;
  poscor:=0;
  postamanho:=0;
  SEPARADOR:=';';
  ShowModal;
  if wret then begin
    if not FileExists(EdArquivotexto.text) then begin
      Avisoerro('Arquivo '+EdArquivotexto.text+' n�o encontrado');
      exit;;
    end;
    if Datetoano( EdData.asdate,true ) < 1910 then begin
      Avisoerro('Problema com a data informada');
      exit;
    end;
        ListaItens:=TStringlist.create;
        try
          ListaItens.LoadFromFile(EdArquivotexto.Text);
        except
          Avisoerro('N�o foi poss�vel ler arquivo '+EdArquivotexto.Text);
          exit;
        end;

          Sistema.beginprocess('Apagando contagem anterior');
//          Sistema.Conexao.ExecuteDirect('Update movesto set moes_status='+Stringtosql('C')+' where moes_unid_codigo='+Stringtosql(Global.codigounidade)+
          Sistema.Conexao.ExecuteDirect('Delete from movesto  where moes_unid_codigo='+Stringtosql(Global.codigounidade)+
                                         ' and '+FGeral.GetIN('moes_tipomov',Global.CodContagemBalancoE+';'+Global.CodContagemBalancoS,'C')+
                                         ' and moes_datamvto = '+EdData.assql );
//          Sistema.Conexao.ExecuteDirect('Update movestoque set move_status='+Stringtosql('C')+' where move_unid_codigo='+Stringtosql(Global.codigounidade)+
          Sistema.Conexao.ExecuteDirect('Delete from movestoque where move_unid_codigo='+Stringtosql(Global.codigounidade)+
                                         ' and '+FGeral.GetIN('move_tipomov',Global.CodContagemBalancoE+';'+Global.CodContagemBalancoS,'C')+
                                         ' and move_datamvto = '+EdData.assql ) ;

        Sistema.beginprocess('Importando contagem do arquivo  '+EdArquivotexto.text);
        incluidos:=0;
        transacao:=FGeral.gettransacao;
        ListaNaocad:=TStringlist.create;
        for p:=0 to ListaItens.count-1 do begin
          ListaLInha:=TStringlist.create;
          strtolista(ListaLINha,ListaItens[p],SEPARADOR,true);
          produto:=trim(ListaLinha[poscodigo]);
          IF ( produto<>'' ) and ( produto<>'0' ) THEN BEGIN
            codcor:=GetCodigo('cores',ListaLinha[posdescor]);
            {
            if codcor=0 then begin
              Avisoerro('Cor |'+ListaLinha[posdescor]+'|n�o encontrada');
              break;
            end;
            }
            codtamanho:=GetCodigo('tamanhos',ListaLinha[posdestamanho]);
            {
            if codtamanho=0 then begin
              Avisoerro('Cor '+ListaLinha[posdestamanho]+' n�o encontrada');
              break;
            end;
            }
            QEst:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(produto));
            if QEst.eof then begin
              ListaNaoCad.add(produto);
              IncluiEstoque;
              Sistema.commit;
              QEst.close;
              QEst:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(produto));
            end else begin
              Sistema.edit('estoqueqtde');
              Sistema.setfield('esqt_qtde',0);
              Sistema.setfield('esqt_qtdeprev',0);
              Sistema.post('esqt_esto_codigo = '+stringtosql(produto)+' and esqt_unid_codigo='+Stringtosql(Global.codigounidade));

              Sistema.edit('estgrades');
              Sistema.setfield('esgr_qtde',0);
              Sistema.setfield('esgr_qtdeprev',0);
              Sistema.post('esgr_esto_codigo = '+stringtosql(produto)+' and esgr_unid_codigo='+Stringtosql(Global.codigounidade)+
                           ' and esgr_tama_codigo = '+inttostr(codtamanho)+
                           ' and esgr_core_codigo = '+inttostr(codcor) );
//            end;
            Qtde:=Texttovalor(ListaLinha[posestoque]);
//            if not QEst.eof then begin
              inc(incluidos);
              EdInclusos.setvalue(incluidos);
              GravaDetalhe;
              Sistema.beginprocess('Produto '+produto);
              try
                Sistema.Commit;
                Sistema.beginprocess('Tabela estoque codigo '+produto);
              except
                Avisoerro('N�o foi gravado na tabela estoque codigo '+produto);
              end;
//            end else ListaNaoCad.add(produto);
            end;
            QEst.close;
          END;
          ListaLinha.free;
        end;
        GravaMestre;

        try
                Sistema.beginprocess('Gravando contagem');
                Sistema.Commit;
              except
                Avisoerro('N�o foi efetuado o commit');
        end;
        aviso( ListaNaocad.GetText );
        ListaItens.Free;
        Sistema.endprocess('Importa��o terminada. Inclu�dos='+inttostr(incluidos));

  end;

end;

// 19.03.16 - Importar do banco de dados firebird- consisanet.fcb
procedure TFDiversos.ImportaFireBird;
//////////////////////////////////////
type TEnd=record
     cd_clifor:integer;
     ds_cliforend,ds_endereco,nr_endereco,ds_bairro,nr_cep,nr_telefone,ds_email,nr_celular:string;
end;
type TEst=record
     cd_estado:integer;
     sg_estado:string;
end;

var  incluidos,codigo,codigoant:integer;
     produto,transacao:string;
     Lista,ListaESt:TList;
     PEnd:^TEnd;
     PEst:^TEst;


    procedure LocalizaEndereco(xcodigo:integer);
    ///////////////////////////////////////////////
    var p:integer;
    begin
       for p:=0 to LIsta.count-1 do begin
          PEnd:=Lista[p];
          if PEnd.cd_clifor=xcodigo then break;
       end;
    end;


    procedure LocalizaEstado(xcodigo:integer);
    ///////////////////////////////////////////////
    var p:integer;
    begin
       for p:=0 to LIstaESt.count-1 do begin
          PEst:=ListaEst[p];
          if PEst.cd_estado=xcodigo then break;
       end;
    end;


    procedure GravaCliente;
////////////////////////////////////////////////////
    var desc,fantasia,numero:string;
        x:integer;
        QCid:TSqlquery;
/////////////////////////////////////////////////////
    begin
/////////////////////////////////////////////////////
      Sistema.Insert('clientes');
      Sistema.SetField('clie_codigo',codigo);
      Sistema.SetField('clie_codigo_ant',codigoant);
      desc:=copy(Arq.SDCliefor.fieldbyname('nm_clifor').asstring,1,50);
      if pos('',desc)>0 then desc:=copy(Arq.SDCliefor.fieldbyname('nm_clifor').asstring,1,pos('',desc)-1)+' '+copy(desc,pos('',desc)-1,30);
      fantasia:=copy(Arq.SDCliefor.fieldbyname('nm_fantasia').asstring,1,50);
      if pos('',fantasia)>0 then fantasia:=copy(Arq.SDCliefor.fieldbyname('nm_fantasia').asstring,1,pos('',fantasia)-1)+' '+copy(fantasia,pos('',fantasia)-1,30);
      x:=pos('�',desc);
      if x>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
        desc:=copy(desc,1,x-1)+'�'+copy(desc,x+2,length(desc)-x);
      x:=pos('�',desc);
      if x>0 then
        desc:=copy(desc,1,x)+copy(desc,x+2,length(desc)-x);
      desc:=Fgeral.TiraBarra(desc,chr(39));
//      desc:=FGeral.TiraBarra(desc);
//      fantasia:=TiraAspas(fantasia);
      fantasia:=FGeral.TiraBarra(fantasia,chr(39));
      Sistema.SetField('clie_razaosocial',Specialcase(desc));
////      if (pos('/',fantasia)>0)  SEFA SP
      if (trim(fantasia)='') then //
        Sistema.SetField('clie_nome',Specialcase(desc))
      else
        Sistema.SetField('clie_nome',Specialcase(fantasia));
      Sistema.SetField('clie_cnpjcpf',StrToStrDigitos(Arq.SDCliefor.fieldbyname('nr_cnpjcpf').asstring));
      Sistema.SetField('clie_rgie',StrtoStrDigitos(Arq.SDCliefor.fieldbyname('nr_inscricaoestadual').asstring) );
      Sistema.SetField('clie_tipo',Arq.SDCliefor.fieldbyname('tp_fisicajuridica').asstring);
      Sistema.SetField('clie_unid_codigo',Global.CodigoUnidade);
      Sistema.SetField('clie_dtcad',Arq.SDCliefor.fieldbyname('dt_cadastro').asdatetime);

      LocalizaEndereco( codigoant );

      Sistema.SetField('clie_foneres',PEnd.nr_telefone);
//      Sistema.SetField('clie_fonecel',Arq.SDCliefor.fieldbyname('nr_celular').asstring);
      Sistema.SetField('clie_fonecel',PEnd.nr_celular);

      QCid:=sqltoquery('select * from cidades where cida_codigo='+inttostr(Arq.SDCliefor.fieldbyname('cd_municipio').asinteger));
      Sistema.SetField('clie_uf',QCid.fieldbyname('cida_uf').asstring);

//      Sistema.SetField('Clie_cepres',Arq.SDCliefor.fieldbyname('nr_cep').asstring);
//      Sistema.SetField('Clie_cepcom',Arq.SDCliefor.fieldbyname('nr_cep').asstring);
      Sistema.SetField('Clie_cepres',Pend.nr_cep);
      Sistema.SetField('Clie_cepcom',Pend.nr_cep);

//      Sistema.SetField('Clie_email',Arq.SDCliefor.fieldbyname('ds_email').asstring);
      Sistema.SetField('Clie_email',Pend.ds_email);

//      Sistema.SetField('Clie_bairrores',Arq.SDCliefor.fieldbyname('ds_bairro').asstring);
//      Sistema.SetField('Clie_bairrocom',Arq.SDCliefor.fieldbyname('ds_bairro').asstring);
      Sistema.SetField('Clie_bairrores',Pend.ds_bairro);
      Sistema.SetField('Clie_bairrocom',Pend.ds_bairro);
      numero:=Pend.nr_endereco;
      if (trim(numero)<>'') and ( strtointdef(numero,0)>0 ) then begin
        Sistema.SetField('Clie_endres',copy(trim(Pend.ds_endereco)+','+numero,1,50));
        Sistema.SetField('Clie_endcom',copy(trim(Pend.ds_endereco)+','+numero,1,50));
      end else begin
        Sistema.SetField('Clie_endres',copy(Pend.ds_endereco+',S/N',1,50));
        Sistema.SetField('Clie_endcom',copy(Pend.ds_endereco+',S/N',1,50));
      end;

      Sistema.SetField('Clie_cida_codigo_res',Arq.SDCliefor.fieldbyname('cd_municipio').asinteger);
      Sistema.SetField('Clie_cida_codigo_com',Arq.SDCliefor.fieldbyname('cd_municipio').asinteger);

      Sistema.SetField('Clie_fonecom',PEnd.nr_telefone);
 //     Sistema.SetField('Clie_fax',Arq.SDCliefor.fieldbyname('nr_fone').asstring);
      Sistema.SetField('Clie_repr_codigo',1);

      Sistema.SetField('Clie_cidade',QCid.fieldbyname('cida_nome').asstring);
      Sistema.SetField('clie_contribuinte','S');
      Sistema.SetField('clie_ipi','N');
////////////////////////
      Sistema.SetField('clie_usua_codigo',998);
      Sistema.Post();

      QCid.close;

    end;

    procedure GravaFornecedores;
    ////////////////////////////
    var desc,fantasia,numero:string;
        x:integer;
        QCid:TSqlquery;
    begin
      desc:=copy(Arq.SDCliefor.fieldbyname('nm_clifor').asstring,1,50);
      if pos('',desc)>0 then desc:=copy(Arq.SDCliefor.fieldbyname('nm_clifor').asstring,1,pos('',desc)-1)+' '+copy(desc,pos('',desc)-1,30);
      fantasia:=copy(Arq.SDCliefor.fieldbyname('nm_fantasia').asstring,1,50);
      if pos('',fantasia)>0 then fantasia:=copy(Arq.SDCliefor.fieldbyname('nm_fantasia').asstring,1,pos('',fantasia)-1)+' '+copy(fantasia,pos('',fantasia)-1,30);
      x:=pos('�',desc);
      if x>0 then                     // no arquivo sefasp vem um caracter 'loke' a mais com �
        desc:=copy(desc,1,x-1)+'�'+copy(desc,x+2,length(desc)-x);
      x:=pos('�',desc);
      if x>0 then
        desc:=copy(desc,1,x)+copy(desc,x+2,length(desc)-x);
      desc:=Fgeral.TiraBarra(desc,chr(39));
//      desc:=FGeral.TiraBarra(desc);
//      fantasia:=TiraAspas(fantasia);
      fantasia:=FGeral.TiraBarra(fantasia,chr(39));
          Sistema.Insert('fornecedores');
          Sistema.SetField('forn_codigo',codigo);
          if trim(fantasia)<>'' then
            Sistema.SetField('forn_nome',copy(SpecialCase(fantasia),1,40))
          else
            Sistema.SetField('forn_nome',copy(SpecialCase(desc),1,40));
          Sistema.SetField('forn_razaosocial',copy(SpecialCase(desc),1,40));
          Sistema.SetField('forn_cnpjcpf',strToStrDigitos(Arq.SDCliefor.fieldbyname('nr_cnpjcpf').asstring));
          Sistema.SetField('Forn_inscricaoestadual',StrtoStrDigitos(Arq.SDCliefor.fieldbyname('nr_inscricaoestadual').asstring) );
          QCid:=sqltoquery('select * from cidades where cida_codigo='+inttostr(Arq.SDCliefor.fieldbyname('cd_municipio').asinteger));
          Sistema.SetField('forn_uf',QCid.fieldbyname('cida_uf').asstring);

          LocalizaEndereco( codigoant );

          numero:=Pend.nr_endereco;
          if (trim(numero)<>'') and ( strtointdef(numero,0)>0 ) then begin
            Sistema.SetField('forn_endereco',copy(trim(Pend.ds_endereco)+','+numero,1,50));
            Sistema.SetField('Forn_enderecoind',copy(trim(Pend.ds_endereco)+','+numero,1,50));
          end else begin
            Sistema.SetField('forn_endereco',copy(Pend.ds_endereco+',S/N',1,50));
            Sistema.SetField('Forn_enderecoind',copy(Pend.ds_endereco+',S/N',1,50));
          end;
  //        Sistema.SetField('clie_endrescompl',PClifor.forn_endereco);
          Sistema.SetField('forn_bairro',SpecialCase(Pend.ds_bairro));
          Sistema.SetField('forn_cida_codigo',Arq.SDCliefor.fieldbyname('cd_municipio').asinteger);
          Sistema.SetField('forn_cep',Pend.nr_cep);

          Sistema.SetField('forn_fone',PEnd.nr_telefone);
          Sistema.SetField('Forn_foneindustria',PEnd.nr_telefone);

          Sistema.SetField('Forn_cidaind_codigo',Arq.SDCliefor.fieldbyname('cd_municipio').asinteger);
//          Sistema.SetField('clie_contacontabil',PClifor.forn_contacontabil);
          Sistema.SetField('Forn_datacad',Arq.SDCliefor.fieldbyname('dt_cadastro').asdatetime);
////////////////////////          Sistema.SetField('forn_unid_codigo',xUnidade);
          Sistema.SetField('forn_usua_codigo',998);
          Sistema.SetField('forn_contribuinte','S');
          Sistema.SetField('Forn_obstrocas','IMPFB codigo anterior '+inttostr(codigoant));
  //        Sistema.SetField('clie_caractrib varchar(1)
          Sistema.Post();
          FGeral.fechaquery(QCid);

    end;


    procedure AdicionaCidades;
    ////////////////////////////
    var codigo,primeiro:integer;
    begin
//          codigo:=FGeral.getsequencial(1,'cida_codigo','N','cidades');
      if not Arq.SDMunicipios.Active then Arq.SDMunicipios.Open;
      Arq.SDMunicipios.First;
      primeiro:=Arq.SDMunicipios.fieldbyname('cd_municipio').asinteger;
      while not Arq.SDMunicipios.Eof do begin
          codigo:=Arq.SDMunicipios.fieldbyname('cd_municipio').asinteger;

          Sistema.Insert('cidades');
          Sistema.SetField('cida_codigo',codigo);
          Sistema.SetField('cida_nome',copy(Arq.SDMunicipios.fieldbyname('ds_municipio').asstring,1,40));

          LocalizaEstado(Arq.SDMunicipios.fieldbyname('cd_estado').asinteger);

          Sistema.SetField('cida_uf',PESt.sg_estado);
          Sistema.SetField('cida_regi_codigo','001');
          Sistema.SetField('cida_codigoibge',Arq.SDMunicipios.fieldbyname('cd_municipioibge').asstring);
          Sistema.post;

          Sistema.beginprocess( Arq.SDMunicipios.fieldbyname('ds_municipio').asstring+' '+inttostr(codigo) );
//          if codigo = 5511 then aviso('');

          try
            Sistema.Commit;
          except
            Avisoerro('Problema na cidade '+Arq.SDMunicipios.fieldbyname('ds_municipio').asstring+' '+inttostr(codigo));
          end;

          Arq.SDMunicipios.Next;
          if Arq.SDMunicipios.FieldByName('cd_municipio').asinteger=primeiro then break;
      end;
    end;

    procedure LeEnderecos;
    //////////////////////////////////////////////////
    var I:integer;
    begin
      if not Arq.SDCliefor.Active then Arq.SDCliefor.Open;
      Arq.SDCliefor.First;

      while not Arq.SDCliefor.Eof do begin
          New(Pend);
          PEnd.cd_clifor:=Arq.SDCliefor.fieldbyname('cd_clifor').AsInteger;
//          PEnd.ds_cliforend:=Arq.SDCliefor.fieldbyname('cd_cliforend').AsString;
          PEnd.ds_endereco:=SpecialCase( FGEral.TiraBarra(Arq.SDCliefor.fieldbyname('ds_endereco').AsString,chr(39)) );
          PEnd.nr_endereco:=SpecialCase(FGEral.TiraBarra(Arq.SDCliefor.fieldbyname('nr_endereco').AsString,chr(39)) );
          PEnd.ds_bairro:=copy(FGeral.Tirabarra( Arq.SDCliefor.fieldbyname('ds_bairro').AsString,chr(39)),1,30);
          PEnd.nr_cep:=strtostrdigitos(Arq.SDCliefor.fieldbyname('nr_cep').AsString);
          if Arq.SDCliefor.FieldByName('cd_tipoclifor').asinteger=1 then begin
            PEnd.nr_telefone:='0'+copy(Arq.SDCliefor.fieldbyname('nr_telefone').AsString,2,2)+
                              copy(Arq.SDCliefor.fieldbyname('nr_telefone').AsString,6,4)+
                              copy(Arq.SDCliefor.fieldbyname('nr_telefone').AsString,11,4);
            PEnd.nr_celular:='0'+copy(Arq.SDCliefor.fieldbyname('nr_celular').AsString,2,2)+
                              copy(Arq.SDCliefor.fieldbyname('nr_celular').AsString,6,4)+
                              copy(Arq.SDCliefor.fieldbyname('nr_celular').AsString,11,4);
          end else begin
            PEnd.nr_telefone:=copy(Arq.SDCliefor.fieldbyname('nr_telefone').AsString,2,2)+
                              copy(Arq.SDCliefor.fieldbyname('nr_telefone').AsString,6,4)+
                              copy(Arq.SDCliefor.fieldbyname('nr_telefone').AsString,11,4);
            PEnd.nr_celular:=copy(Arq.SDCliefor.fieldbyname('nr_celular').AsString,2,2)+
                              copy(Arq.SDCliefor.fieldbyname('nr_celular').AsString,6,4)+
                              copy(Arq.SDCliefor.fieldbyname('nr_celular').AsString,11,4);
          end;
          PEnd.ds_email:=Arq.SDCliefor.fieldbyname('ds_email').AsString;
          Lista.add(PEnd);
          Arq.SDCliefor.Next;
      end;

    end;


    procedure LeEstados;
    //////////////////////////////////////////////////
    var I:integer;
    begin
      if not Arq.SDEstados.Active then Arq.SDEstados.Open;
      Arq.SDEstados.First;
      while not Arq.SDEstados.Eof do begin
          New(PEst);
          PEst.cd_estado:=Arq.SDEstados.fieldbyname('cd_estado').AsInteger;
          PEst.sg_estado:=Arq.SDEstados.fieldbyname('sg_estado').AsString;
          ListaEst.add(PEst);
          Arq.SDEstados.Next;
      end;

    end;



begin
///////////////////////////////////////////////////////////////////////////
  if not Arq.SDCliefor.active then Arq.SDCliefor.open;
  Arq.SdCliefor.first;
  Width:=561;Height:=400;
  Position:=poMainFormCenter;
  Page.ActivePage:=PgImportaEstoque;
  EdArquivodbf.enabled:=false;
  Eddata.enabled:=true;
  Eddata.visible:=true;
  ActiveControl:=EdArquivoTexto;
  PMens.Caption:='Importa��o Clientes/Fornecedores do Firebird';
  Caption:='Importa��o Clientes/Fornecedores do Firebird';
// ver para pedir a data com input
  EdDAta.setdate( Texttodate('22112015') );
  bConfirmar.Visible:=True;bConfirmar.Top:=bSair.Top+25;
  wRet:=False;
  ShowModal;
  Lista:=TList.create;
  ListaEst:=TList.create;

  if wret then begin

        Sistema.beginprocess('Apagando clientes e fornecedores');
        Sistema.Conexao.ExecuteDirect('Delete from clientes  where clie_unid_codigo='+Stringtosql(Global.codigounidade) );
        Sistema.Conexao.ExecuteDirect('truncate table fornecedores');
        Sistema.Conexao.ExecuteDirect('truncate table cidades');

        incluidos:=0;

        LeEstados;

        Sistema.beginprocess('Incluindo cidades');
        AdicionaCidades;

        Sistema.beginprocess('Lendo Endere�os');
        LeEnderecos;

        EdInclusos.setvalue(incluidos);
        Sistema.beginprocess('Cliente / Fornecedor '+inttostr(codigo));

    Arq.SDCliefor.First;
    while not Arq.SDCliefor.Eof do begin
  // clientes
        if Arq.SDCliefor.FieldByName('cd_tipoclifor').asinteger=1 then begin
            codigo:=FCadCli.GetProxCodigo('CLIENTES',false);
            codigoant:=Arq.SDCliefor.FieldByName('cd_clifor').asinteger;
            GravaCliente;
            inc(incluidos);
     // fornececores
        end else if Arq.SDCliefor.FieldByName('cd_tipoclifor').asinteger=2 then begin
            codigo:=FGeral.GetProximoCodigoCadastro('FORNECEDORES','forn_codigo');
            codigoant:=Arq.SDCliefor.FieldByName('cd_clifor').asinteger;
            GravaFornecedores;
            inc(incluidos);

        end;
        try
                Sistema.Commit;
                Sistema.beginprocess('Tabela clientes/fornecedor codigo '+inttostr(codigo));
        except
                Avisoerro('N�o foi gravado na tabela clientes codigo '+inttostr(codigo));
        end;

        Arq.SDCliefor.Next;
    end;

    Sistema.endprocess('Importa��o terminada. Inclu�dos='+inttostr(incluidos));
    Arq.ConexaoFB.Connected:=false;

  end;


end;

// 05.01.17
procedure TFDiversos.importapedidosmovel(smens: string);
///////////////////////////////////////////////////////////
begin
   mostramens:='N';
   bimportarClick(self);
end;

end.
