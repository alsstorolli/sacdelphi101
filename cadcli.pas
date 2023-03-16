unit cadcli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, ExtCtrls, Buttons, SQLBtn,
  StdCtrls, alabel, ComCtrls, Mask, SQLEd, SqlExpr, Menus, ACBrBase,
  ACBrSocket, ACBrConsultaCNPJ, ExtDlgs, DBClient, SimpleDS, SqlSis,
  ACBrDFe, ACBrNFe;

type
  TFCadcli = class(TForm)
    PGeral: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bAlterar: TSQLBtn;
    bExcluir: TSQLBtn;
    bCancelar: TSQLBtn;
    bFiltrar: TSQLBtn;
    bPesquisar: TSQLBtn;
    bRelatorio: TSQLBtn;
    bSair: TSQLBtn;
    bExpColumn: TSQLBtn;
    Bevel1: TBevel;
    bRedColumn: TSQLBtn;
    bMoveLeft: TSQLBtn;
    bMoveRight: TSQLBtn;
    bDelColumn: TSQLBtn;
    bRestColumn: TSQLBtn;
    bLoadGrid: TSQLBtn;
    bSaveGrid: TSQLBtn;
    bRestaurar: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Dts: TDataSource;
    Page: TPageControl;
    PgConsulta: TTabSheet;
    Grid: TSQLGrid;
    PgCadastro: TTabSheet;
    PgEnderecos: TTabSheet;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    PCadastro: TSQLPanelGrid;
    EdClie_codigo: TSQLEd;
    EdClie_nome: TSQLEd;
    EdClie_tipo: TSQLEd;
    EdClie_cnpjcpf: TSQLEd;
    EdClie_rgie: TSQLEd;
    EdClie_dtexprg: TSQLEd;
    EdClie_orgexprg: TSQLEd;
    EdClie_ufexprg: TSQLEd;
    EdClie_sexo: TSQLEd;
    EdClie_dtnasc: TSQLEd;
    EdClie_naturalidade: TSQLEd;
    EdClie_emailcorr: TSQLEd;
    EdClie_endcorr: TSQLEd;
    EdClie_rendacomprovada: TSQLEd;
    EdClie_estadocivil: TSQLEd;
    EdClie_descrestadocivil: TSQLEd;
    EdClie_escolaridade: TSQLEd;
    EdClie_emprego: TSQLEd;
    EdClie_moradia: TSQLEd;
    EdClie_valoraluguel: TSQLEd;
    EdClie_dtmoradia: TSQLEd;
    EdClie_obs: TSQLEd;
    EdClie_contagerencial: TSQLEd;
    EdNomCtaGerencial: TSQLEd;
    PEnderecos: TSQLPanelGrid;
    Bevel3: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    EdClie_endres: TSQLEd;
    EdClie_endrescompl: TSQLEd;
    EdClie_bairrores: TSQLEd;
    EdClie_muni_codigo_res: TSQLEd;
    EdMuniRes_Nome: TSQLEd;
    EdClie_cepres: TSQLEd;
    EdClie_foneres: TSQLEd;
    EdClie_fonecel: TSQLEd;
    EdClie_email: TSQLEd;
    EdClie_empresa: TSQLEd;
    EdClie_funcao: TSQLEd;
    EdClie_endcom: TSQLEd;
    EdClie_bairrocom: TSQLEd;
    EdClie_muni_codigo_com: TSQLEd;
    EdMuniCom_Nome: TSQLEd;
    EdMuniRes_UF: TSQLEd;
    EdMuniCom_Uf: TSQLEd;
    EdClie_cepcom: TSQLEd;
    EdClie_fonecom: TSQLEd;
    EdClie_ramal: TSQLEd;
    EdClie_dtadmissao: TSQLEd;
    EdClie_codcliemp: TSQLEd;
    EdClie_dtcad: TSQLEd;
    EdClie_unid_codigo: TSQLEd;
    EdClie_usua_codigo: TSQLEd;
    EdClie_dependentes: TSQLEd;
    EdClie_dtlibcad: TSQLEd;
    EdClie_usulibcad: TSQLEd;
    bProximo: TSQLBtn;
    bcnpj: TSQLBtn;
    SQLPanelGrid1: TSQLPanelGrid;
    LblCliente: TLabel;
    PgReferencias: TTabSheet;
    GridRef: TSQLGrid;
    PReferencias: TSQLPanelGrid;
    DtsRef: TDataSource;
    EdRefc_chave: TSQLEd;
    EdRefc_clie_codigo: TSQLEd;
    EdRefc_nomeref: TSQLEd;
    EdRefc_foneref: TSQLEd;
    EdRefc_obs: TSQLEd;
    EdClie_contribuinte: TSQLEd;
    EdClie_razaosocial: TSQLEd;
    EdClie_dataalt: TSQLEd;
    PopupMenu: TPopupMenu;
    Cadastro1: TMenuItem;
    EdClie_uf: TSQLEd;
    EdClie_Consfinal: TSQLEd;
    Bevel2: TBevel;
    EdClie_nomecje: TSQLEd;
    EdClie_cpfcje: TSQLEd;
    EdClie_rgcje: TSQLEd;
    EdClie_agecje: TSQLEd;
    EdClie_bcocje: TSQLEd;
    EdClie_trabalhocje: TSQLEd;
    EdClie_AnosTrabCJE: TSQLEd;
    Edrepr_codigo: TSQLEd;
    SetEdRepr_nome: TSQLEd;
    EdClie_pai: TSQLEd;
    EdClie_mae: TSQLEd;
    EdClie_fonepai: TSQLEd;
    bocorrencia: TSQLBtn;
    EdClie_situacao: TSQLEd;
    EdClie_fax: TSQLEd;
    EdClie_email1: TSQLEd;
    EdClie_ipi: TSQLEd;
    EdClie_cidade: TSQLEd;
    PgDiversos: TTabSheet;
    Pdiversos: TSQLPanelGrid;
    EdClie_ativo: TSQLEd;
    EdClie_contacontabil: TSQLEd;
    Edclie_limcredito: TSQLEd;
    Edclie_contacotacap: TSQLEd;
    Edclie_codigofinan: TSQLEd;
    SetEdclifinanceiro: TSQLEd;
    Edcaexporta: TSQLEd;
    Edplan_ctaexporta02: TSQLEd;
    pctg: TSQLPanelGrid;
    EdClie_integrante: TSQLEd;
    EdClie_tipomensa: TSQLEd;
    EdClie_tipoinver: TSQLEd;
    EdClie_qintegra: TSQLEd;
    EdClie_grupoinv: TSQLEd;
    edvlrmensalidade: TSQLEd;
    EdClie_matricula: TSQLEd;
    Edclie_contadevven01: TSQLEd;
    Edclie_aliinsspro: TSQLEd;
    Edclie_depojudi: TSQLEd;
    Edclie_contadepojudi: TSQLEd;
    Edclie_aliinssdepjud: TSQLEd;
    EdFpgt_codigo: TSQLEd;
    SQLEd1: TSQLEd;
    balteracampo: TSQLBtn;
    FichaparaCadastro1: TMenuItem;
    SQLBtn1: TSQLBtn;
    EdClie_tiposremessas: TSQLEd;
    EdClie_portadores: TSQLEd;
    ExtratoCliente: TMenuItem;
    bimportafornec: TSQLBtn;
    EdFornec: TSQLEd;
    Edclie_agencia: TSQLEd;
    Edclie_contacorrente: TSQLEd;
    PgDocumentos: TTabSheet;
    SQLPanelGrid2: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    OP1: TOpenPictureDialog;
    PD1: TPrintDialog;
    bsalvar: TSQLBtn;
    TDocumentos: TSQLDs;
    barquivo: TSQLBtn;
    bimpressao: TSQLBtn;
    Bevel4: TBevel;
    im1: TImage;
    SQLPanelGrid4: TSQLPanelGrid;
    bsalvar1: TSQLBtn;
    barquivo1: TSQLBtn;
    bimpressao1: TSQLBtn;
    Bevel7: TBevel;
    im2: TImage;
    SQLPanelGrid5: TSQLPanelGrid;
    bsalvar2: TSQLBtn;
    barquivo2: TSQLBtn;
    bimpressao2: TSQLBtn;
    Bevel8: TBevel;
    im3: TImage;
    SQLPanelGrid6: TSQLPanelGrid;
    bsalvar3: TSQLBtn;
    barquivo3: TSQLBtn;
    bimpressao3: TSQLBtn;
    Bevel9: TBevel;
    im4: TImage;
    FichaProdutor1: TMenuItem;
    bbuscar: TSQLBtn;
    Edpesquisa: TSQLEd;
    Edclie_contacompras02: TSQLEd;
    Edclie_contacotacap02: TSQLEd;
    Ocorrncias1: TMenuItem;
    EdClie_DescontoVenda: TSQLEd;
    Edclie_condicoespag: TSQLEd;
    Edclie_contato1: TSQLEd;
    Edclie_contato2: TSQLEd;
    ACBrNFe1: TACBrNFe;
    EdClie_acrescimovenda: TSQLEd;
    EdClie_tran_codigo: TSQLEd;
    SetEdtran_nome: TSQLEd;
    Edclie_ctaccassoc: TSQLEd;
    Edclie_ctaeapassoc: TSQLEd;
    Edclie_ctacotassoc: TSQLEd;
    EdMoes_tabp_codigo: TSQLEd;
    SQLEd30: TSQLEd;
    Edclie_mens_codigo: TSQLEd;
    bvisualiza: TSQLBtn;
    bvisualiza2: TSQLBtn;
    bvisualiza3: TSQLBtn;
    bvisualiza4: TSQLBtn;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure PageChange(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure tira(Sender: TObject);
    procedure EdClie_codcliempExitEdit(Sender: TObject);
    procedure EdClie_motivoExitEdit(Sender: TObject);
    procedure EdClie_muni_codigo_resValidate(Sender: TObject);
    procedure EdClie_muni_codigo_comValidate(Sender: TObject);
    procedure bAlterarClick(Sender: TObject);
    procedure EdClie_tipoChange(Sender: TObject);
    procedure EdClie_contagerencialKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdClie_contagerencialValidate(Sender: TObject);
    procedure bcnpjClick(Sender: TObject);
    procedure bProximoClick(Sender: TObject);
    procedure EdRefc_obsExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure EdClie_tipoValidate(Sender: TObject);
    procedure EdClie_estadocivilValidate(Sender: TObject);
    procedure EdClie_cnpjcpfValidate(Sender: TObject);
    procedure Cadastro1Click(Sender: TObject);
    procedure Histrico1Click(Sender: TObject);
    procedure Limites1Click(Sender: TObject);
    procedure LimitedeCheques1Click(Sender: TObject);
    procedure EdClie_cpfcjeValidate(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bocorrenciaClick(Sender: TObject);
    procedure bpesquisaClick(Sender: TObject);
    procedure EdClie_contacontabilExitEdit(Sender: TObject);
    procedure Edclie_limcreditoValidate(Sender: TObject);
    procedure Edclie_codigofinanValidate(Sender: TObject);
    procedure EdClie_qintegraValidate(Sender: TObject);
    procedure EdClie_grupoinvExitEdit(Sender: TObject);
    procedure EdClie_endresValidate(Sender: TObject);
    procedure EdClie_bairroresValidate(Sender: TObject);
    procedure EdClie_ConsfinalValidate(Sender: TObject);
    procedure FichaparaCadastro1Click(Sender: TObject);
    procedure ExtratoClienteClick(Sender: TObject);
    procedure bimportafornecClick(Sender: TObject);
    procedure EdFornecExit(Sender: TObject);
    procedure EdFornecValidate(Sender: TObject);
    procedure EdFornecKeyPress(Sender: TObject; var Key: Char);
    procedure bsalvarClick(Sender: TObject);
    procedure barquivoClick(Sender: TObject);
    procedure PageEnter(Sender: TObject);
    procedure PgDocumentosEnter(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure bimpressaoClick(Sender: TObject);
    procedure barquivo1Click(Sender: TObject);
    procedure bsalvar1Click(Sender: TObject);
    procedure bimpressao1Click(Sender: TObject);
    procedure barquivo2Click(Sender: TObject);
    procedure bsalvar2Click(Sender: TObject);
    procedure bimpressao2Click(Sender: TObject);
    procedure barquivo3Click(Sender: TObject);
    procedure bsalvar3Click(Sender: TObject);
    procedure bimpressao3Click(Sender: TObject);
    procedure EdClie_cepresValidate(Sender: TObject);
    procedure FichaProdutor1Click(Sender: TObject);
    procedure EdpesquisaExitEdit(Sender: TObject);
    procedure bbuscarClick(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure EdpesquisaExit(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdClie_contribuinteChange(Sender: TObject);
    procedure Ocorrncias1Click(Sender: TObject);
    procedure bPesquisarClick(Sender: TObject);
    procedure EdClie_rgieValidate(Sender: TObject);
    procedure bvisualizaClick(Sender: TObject);
    procedure bvisualiza2Click(Sender: TObject);
    procedure bvisualiza3Click(Sender: TObject);
    procedure bvisualiza4Click(Sender: TObject);
  private
    procedure HabilitaEdts;
    procedure DesabilitaEdts;
    procedure GravaCLiente;
    procedure Seleciona(Pg:TTabSheet);
    procedure GetFieldsCliente;
//    function GetProxCodigo(NomeTabela:String; Digito:Boolean):Integer;
    function GetDescricaoItems(Ed:TSqlEd):String;
    procedure UsadoLimite(CatEntidade,CodEntidade:String);
  public

    procedure Execute;
    function GetNome(codigo:integer):string;
    function GetRazaoSocial(codigo:integer):string;
    function GetCnpjCpf(codigo:integer;masc:string='N'):string;
    function GetInsEst(codigo:integer):string;
    function GetUf(codigo:integer):string;
    function GetCidade(codigo:integer):string;
    function GetPopulacao(codigo:integer):integer;
    procedure EditsRetirados;
    function GetContaExp(codigo:integer; unidade:string='' ; tipo:string=''; xtipomov:string='' ):integer;
    function Getecooperado(codigo:integer):boolean;
    function GetContaExpCotaCapital(codigo:integer; unidade:string=''):integer;
    procedure SetaMensalidade(Edit:TSqled);
    procedure SetaInvernada(Edit:TSqled);
    function GetValorMensalidade(Tipomen,Qintegrante:string):currency;
    function GetTipoMensalidade(Tipomen:string):string;
    function GetTipoInvernada(Tipoinv:string):string;
// 23.09.08
    function GetContaExpDevVenda(codigo:integer; unidade:string=''):integer;
// 05.10.10
    function ValidaPessoa(cnpjcpf,tipo:string):boolean;
// 08.06.11
    function GetEndereco(codigo:integer):string;
// 18.04.12 - tornado 'publica'
    function GetProxCodigo(NomeTabela:String; Digito:Boolean):Integer;
// 07.05.12
    procedure ImprimeFichaCadastro;
// 10.01.13 - Vivan
    function GetBairro(codigo:integer):string;
// 25.02.13
    procedure SetaCamponaMascara(Ed:TSqled);
// 04.04.13
    function GetCodigoCidade(codigo:integer):string;
// 05.05.13 - Vivan
    function GetLimitecredito(codigo:integer):currency;
// 11.01.14
    function GetDatadeCadastro(codigo:integer):TDateTime;
// 27.09.17
    function GetDescontoVenda(codigo:integer):currency;
// 21.02.18
    function GetSituacao(codigo:integer):string;
// 26.02.17
    function GetAcrescimoVenda(codigo:integer):currency;
// 17.04.19
    function GetCodigoMoto(codigo:integer):string;
// 09.12.19
    function NaoVisualizaCnpj( codigo:Integer):boolean;
// 16.12.19
    procedure SetaEdit(Edit:TSqled;campofiltro:string='';conteudofiltro:string='');
// 18.01.20
    function GetTabelaAcresDesc(codigo:integer):integer;
// 25.03.20
    function GetSimplesNacional(codigo:integer):string;
// 15.08.20
    function GetCelular(codigo:integer):string;
// 30.01.2021
    function GetCep(codigo:integer):string;

  end;

var
  FCadcli: TFCadcli;
  EdtLeft,EdtTop:integer;
  Visualizou    :boolean;

implementation

uses Arquiv, SqlFun, Geral, SQLRel, Munic, Ocorrenc, pesquisa,
  TextRel, Unidades, portador, RelGerenciais,
  //U_Principal,
  fornece, Printers,
  comobj, expnfetxt, usuarios,conpagto, gerapdf;
//Ocorrenc,, RelFin

var Tipo:String;
    campo,
    campoc   :TDicionario;

{$R *.dfm}

procedure TFCadcli.Execute;
/////////////////////////////////////
begin
// 09.02.15 - Coorlaf
  if Global.topicos[1111] then

    Arq.TClientes.OpenWith(FGeral.GetIN('clie_unid_codigo',Global.codigounidade,'C'),Arq.Tclientes.Ordenacao)

// 23.06.2021 - Devereda
  else if Global.topicos[1117] then

    Arq.TClientes.OpenWith(FGeral.GetNOTIN('clie_situacao','I','C'),Arq.Tclientes.Ordenacao)

  else

    if not Arq.TClientes.Active then Arq.TClientes.Open;

  Tipo:='';
  SetEdclifinanceiro.Text:='';
  FGeral.SetaUFs(EdClie_uf);
// 22.05.07
  PgDiversos.Visible:=Global.topicos[1103];
  PgDiversos.Enabled:=Global.topicos[1103];
// 05.03.08 - retiarado em 03.02.16...ctg 'tarca leonir'...
{
  if Global.topicos[1105] then begin
    EdClie_nome.CharUpperLower:=false;
    EdClie_razaosocial.CharUpperLower:=false;
  end;
  }
  pctg.Enabled:=Global.topicos[1105];
// 13.05.10
  Edclie_aliinsspro.Enabled:=Global.Usuario.OutrosAcessos[0323];
// 16.09.10 - inss dep. em conta - vanessa quis deixar livre
{
  Edclie_depojudi.Enabled:=Global.Usuario.OutrosAcessos[0323];
  Edclie_contadepojudi.Enabled:=Global.Usuario.OutrosAcessos[0323];
  Edclie_aliinssdepjud.Enabled:=Global.Usuario.OutrosAcessos[0323];
}
  if PgDiversos.Enabled then begin
    SetaMensalidade(Edclie_tipomensa);
    SetaInvernada(Edclie_tipoinver);
  end;
  FPortadores.SetaItems(EdClie_portadores);
// 01.06.18
  FCondPagto.SetaItems(Edclie_condicoespag,'');

// 01.04.15
  FGeral.ConfiguraColorEditsNaoEnabled(FCadCli);
// 17.05.16
  if trim( FGeral.GetConfig1AsString('Pastaschemas') ) <> '' then
    Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=FGeral.GetConfig1AsString('Pastaschemas')
  else
    Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=ExtractFilePath( Application.ExeName )+'Schemas20';
  acbrnfe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(Global.codigounidade);

  Visualizou := false;
  ShowModal;

end;

procedure TFCadcli.GetFieldsCliente;
////////////////////////////////////
begin

  if Arq.TClientes.IsEmpty then Exit;
  Arq.TClientes.GetFields(Self,99);
  // 25.02.13
  SetaCamponaMascara(EdClie_fonecel);

  EdClie_Muni_Codigo_ResValidate(Self);
  EdClie_Muni_Codigo_ComValidate(Self);
  EdRepr_codigo.validfind;  // 30.08.05
  LblCliente.Caption := 'Cliente Selecionado: '+Arq.TClientes.FieldByName('CLIE_NOME').AsString;
end;

procedure TFCadcli.FormActivate(Sender: TObject);
/////////////////////////////////////////////////////
begin

// 07.01.15 - Coorlaf
  if Global.topicos[1111] then

    Arq.TClientes.OpenWith(FGeral.GetIN('clie_unid_codigo',Global.codigounidade,'C'),Arq.Tclientes.Ordenacao)

// 23.06.2021 - Devereda
  else if Global.topicos[1117] then

    Arq.TClientes.OpenWith(FGeral.GetNOTIN('clie_situacao','I','C'),Arq.Tclientes.Ordenacao)

  else

    if not Arq.TClientes.Active then Arq.TClientes.Open;

  FGeral.ColunasGrid(Grid,Self);

// 06.05.10
  campo:=Sistema.GetDicionario('clientes','clie_aliinsspro');
  if campo.Tipo='' then
    Edclie_aliinsspro.Table:=nil;
// 16.09.10
  campo:=Sistema.GetDicionario('clientes','clie_depojudi');
  if campo.Tipo='' then begin
    Edclie_depojudi.Table:=nil;
    Edclie_contadepojudi.Table:=nil;
    Edclie_aliinssdepjud.Table:=nil;
  end;
// 03.11.11
  campo:=Sistema.GetDicionario('clientes','clie_fpgt_codigo');
  if campo.Tipo='' then begin
    EdFpgt_codigo.Table:=nil;
    EdFpgt_codigo.enabled:=false;
  end else
    EdFpgt_codigo.enabled:=true;
////////
// 15.07.13
  campo:=Sistema.GetDicionario('clientes','clie_tiposremessas');
  if campo.Tipo='' then begin
    EdClie_tiposremessas.Table:=nil;
    EdClie_tiposremessas.Tablename:='';
    EdClie_tiposremessas.enabled:=false;
  end else begin
    EdClie_tiposremessas.Table:=Arq.TClientes;
    EdClie_tiposremessas.Tablename:='clientes';
    EdClie_tiposremessas.enabled:=true;
  end;
////////
// 12.08.13
  campo:=Sistema.GetDicionario('clientes','clie_portadores');
  if campo.Tipo='' then begin
    EdClie_portadores.Table:=nil;
    EdClie_portadores.enabled:=false;
  end else begin
    EdFpgt_codigo.enabled:=true;
    EdClie_portadores.Tablename:='clientes';
    EdClie_portadores.Tablefield:='clie_portadores';
  end;
////////
// 01.01.15
  campo:=Sistema.GetDicionario('clientes','clie_agencia');
  if campo.Tipo='' then begin
    EdClie_agencia.Table:=nil;
    EdClie_agencia.enabled:=false;
  end else begin
    EdClie_agencia.Tablename:='clientes';
    EdClie_agencia.Tablefield:='clie_agencia';
  end;
  campo:=Sistema.GetDicionario('clientes','clie_contacorrente');
  if campo.Tipo='' then begin
    EdClie_contacorrente.Table:=nil;
    EdClie_contacorrente.enabled:=false;
  end else begin
    EdClie_contacorrente.Tablename:='clientes';
    EdClie_contacorrente.Tablefield:='clie_contacorrente';
  end;
// 16.01.17
  campo:=Sistema.GetDicionario('clientes','clie_contacompras02');
  if campo.Tipo='' then begin
    EdClie_contacompras02.Table:=nil;
    EdClie_contacompras02.enabled:=false;
  end else begin
    EdClie_contacompras02.Tablename:='clientes';
    EdClie_contacompras02.Tablefield:='clie_contacompras02';
    EdClie_contacompras02.enabled:=true;
  end;
// 03.03.17
  campo:=Sistema.GetDicionario('clientes','clie_contacotacap02');
  if campo.Tipo='' then begin
    EdClie_contacotacap02.Table:=nil;
    EdClie_contacotacap02.enabled:=false;
  end else begin
    EdClie_contacotacap02.Tablename:='clientes';
    EdClie_contacotacap02.Tablefield:='clie_contacotacap02';
    EdClie_contacotacap02.enabled:=true;
  end;
// 23.09.17
  campo:=Sistema.GetDicionario('clientes','clie_DescontoVenda');
  if campo.Tipo='' then begin
    EdClie_DescontoVenda.Table:=nil;
    EdClie_DescontoVenda.enabled:=false;
  end else begin
    EdClie_DescontoVenda.Tablename:='clientes';
    EdClie_DescontoVenda.Tablefield:='clie_DescontoVenda';
    EdClie_DescontoVenda.enabled:=true;
  end;
////////
// 01.06.18
  campo:=Sistema.GetDicionario('clientes','clie_condicoespag');
  if campo.Tipo='' then begin
    EdClie_condicoespag.Table:=nil;
    EdClie_condicoespag.enabled:=false;
  end else begin
    EdFpgt_codigo.enabled:=true;
    EdClie_condicoespag.Tablename:='clientes';
    EdClie_condicoespag.Tablefield:='clie_condicoespag';
  end;
//////////
// 01.11.18
  campoc:=Sistema.GetDicionario('clientes','clie_contato1');
  if campoc.Tipo='' then begin
    EdClie_contato1.Table:=nil;
    EdClie_contato1.enabled:=false;
    EdClie_contato2.Table:=nil;
    EdClie_contato2.enabled:=false;
  end else begin
    EdClie_contato1.enabled:=true;
    EdClie_contato1.Tablename:='clientes';
    EdClie_contato1.Tablefield:='clie_contato1';
    EdClie_contato2.enabled:=true;
    EdClie_contato2.Tablename:='clientes';
    EdClie_contato2.Tablefield:='clie_contato2';
  end;
//////////
// 26.02.19
  campo:=Sistema.GetDicionario('clientes','clie_acrescimoVenda');
  if campo.Tipo='' then begin
    EdClie_acrescimoVenda.Table:=nil;
    EdClie_acrescimoVenda.enabled:=false;
  end else begin
    EdClie_acrescimoVenda.Tablename:='clientes';
    EdClie_acrescimoVenda.Tablefield:='clie_acrescimoVenda';
    EdClie_acrescimoVenda.enabled:=true;
  end;
//////////
// 18.01.20 - Mirvane
  campo:=Sistema.GetDicionario('clientes','clie_tabp_codigo');
  if campo.Tipo='' then begin
    EdMoes_tabp_codigo.Table:=nil;
    EdMoes_tabp_codigo.enabled:=false;
  end else begin
    EdMoes_tabp_codigo.Tablename:='clientes';
    EdMoes_tabp_codigo.Tablefield:='clie_tabp_codigo';
    EdMoes_tabp_codigo.enabled:=true;
  end;

// 16.04.19
  campoc:=Sistema.GetDicionario('clientes','clie_tran_codigo');
  if campoc.Tipo <> '' then begin

    EdClie_tran_codigo.Tablename:='clientes';
    EdClie_tran_codigo.Tablefield:='clie_tran_codigo';
    EdClie_tran_codigo.enabled:=true;

  end else begin

    EdClie_tran_codigo.Table:=nil;
    EdClie_tran_codigo.enabled:=false;

  end;
// 01.10.19  - Novicarnes
  campo:=Sistema.GetDicionario('clientes','clie_ctaccassoc');
  if campo.Tipo='' then begin

    Edclie_ctaccassoc.Table:=nil;
    Edclie_ctaccassoc.enabled:=false;

    Edclie_ctacotassoc.Table:=nil;
    Edclie_ctacotassoc.enabled:=false;

    Edclie_ctaeapassoc.Table:=nil;
    Edclie_ctaeapassoc.enabled:=false;

  end else begin

    Edclie_ctaccassoc.Tablename:='clientes';
    Edclie_ctaccassoc.Tablefield:='clie_ctaccassoc';
    Edclie_ctaccassoc.enabled:=true;

    Edclie_ctacotassoc.Tablename:='clientes';
    Edclie_ctacotassoc.Tablefield:='clie_ctacotassoc';
    Edclie_ctacotassoc.enabled:=true;

    Edclie_ctaeapassoc.Tablename:='clientes';
    Edclie_ctaeapassoc.Tablefield:='clie_ctaeapassoc';
    Edclie_ctaeapassoc.enabled:=true;

  end;

// 08.04.20
  campoc:=Sistema.GetDicionario('clientes','clie_mens_codigo');
  if campoc.Tipo <> '' then begin

    EdClie_mens_codigo.Tablename:='clientes';
    EdClie_mens_codigo.Tablefield:='clie_mens_codigo';
    EdClie_mens_codigo.enabled:=true;

  end else begin

    EdClie_mens_codigo.Table:=nil;
    EdClie_mens_codigo.enabled:=false;

  end;

  if Global.Topicos[1106] then begin
     EdClie_cnpjcpf.Duplicity:=1;
  end else if Global.Topicos[1104] then begin   // 24.05.07
     EdClie_cnpjcpf.Duplicity:=1;
  end else begin
     EdClie_cnpjcpf.Duplicity:=2;
  end;
// 03.11.16
//  Page.ActivePageIndex:=0;
//  Page.ActivePage:=PgConsulta;
//  Grid.SetFocus;
//  showmessage( 'pagina atual :'+ inttostr(page.ActivePageIndex) );

// 25.06.20
  if not visualizou then

     seleciona( pgconsulta );

// 09.12.19
  if NaoVisualizaCnpj(Edclie_codigo.AsInteger) then begin

     Grid.Columns[04].Visible:=false;
     brelatorio.Enabled := false;

  end else begin

     Grid.Columns[04].Visible:=true;
     brelatorio.Enabled := true;

  end;

end;

procedure TFCadcli.bIncluirClick(Sender: TObject);
begin
//  if Page.ActivePageIndex=3 then begin
// 24.10.11
  if Page.ActivePageIndex=4 then begin
     if Arq.TClientes.IsEmpty then Exit;
     EdRefC_Clie_Codigo.ValueDefault:=Arq.TClientes.FieldByName('CLIE_CODIGO').AsString;
     GridRef.Insert(EdRefc_NomeRef);
  end else if Page.ActivePageIndex=5 then begin
     if Arq.TClientes.IsEmpty then Exit;
  end else if Page.ActivePageIndex=6 then begin
    if Arq.TClientes.IsEmpty then Exit;
  end else begin
     bAlterar.White;
     if bIncluir.Font.Color=Sistema.Btns.FontColorBlack then begin
        bIncluir.Red;
        HabilitaEdts;
        Grid.Insert(EdClie_Nome);
        EdClie_Codigo.ClearAll(Self,0);
        EdClie_Nome.SetFocus;
        Tipo:='I';
     end;
     Seleciona(PgCadastro);
  end;
  bSair.enabled:=false;
end;

procedure TFCadcli.PageChange(Sender: TObject);
var Cond:String;

  procedure SetaGridBotoes(Grd:TSQLGrid);
  begin
    if UpperCase(Grd.Name)<>'GRID' then begin
       bAlterar.Operation:=fbEdit;
       bAlterar.Grid:=Grd;
    end;
    bIncluir.Grid:=Grd;
    bExcluir.Grid:=Grd;
    bCancelar.Grid:=Grd;
    bFiltrar.Grid:=Grd;
//    bOrdenar.Grid:=Grd;
    bPesquisar.Grid:=Grd;
    bRestaurar.Grid:=Grd;
    bRelatorio.Grid:=Grd;
    balteracampo.Grid:=Grd;
    Grd.Configurar;
  end;

  procedure SelecionaReferencias;
  ///////////////////////////////
  begin
    Cond:='REFC_CLIE_CODIGO='+IntToStr(Arq.TClientes.FieldByName('CLIE_CODIGO').AsInteger);
    if Cond<>Arq.TReferencias.Condicao then Arq.TReferencias.OpenWith(Cond,'');
    SetaGridBotoes(GridRef);
    GridRef.SetFocus;
  end;

// 01.04.15
  procedure SelecionaDocumentos;
  ///////////////////////////////
  begin
    PgDocumentos.SetFocus;
  end;


  procedure Confbotoes(s:string='');
  ///////////////////////////////////
  begin
    bpesquisar.enabled:=true;
    if s='' then
      pbotoes.Enabled:=true
    else if s='1;2' then begin
      bpesquisar.enabled:=false;
    end;
// 23.03.12
    if Page.ActivePage=PgConsulta then begin
        balteracampo.Black;
        balteracampo.Operation:=fbEdit;
    end;
  end;

begin

  if Tipo='I' then begin
     if not Global.topicos[1103] then begin
       case Page.ActivePageIndex of
          1: EdClie_Codigo.SetFirstEd;
          2: EdClie_EndRes.SetFirstEd;
       end;
     end else begin
       case Page.ActivePageIndex of
          1: EdClie_Codigo.SetFirstEd;
          2: EdClie_EndRes.SetFirstEd;
          3: EdClie_Ativo.SetFirstEd;
       end;
     end;
     Exit;
  end;
  if Tipo='A' then bCancelarClick(Sender);
  SetaGridBotoes(Grid);
  bAlterar.Operation:=fbNone;
  bAlterar.Black;
  balteracampo.White;
  balteracampo.Operation:=fbNone;
  Confbotoes;
// 03.03.20 - Lei 'LGPD' - prote��o aos dados
//  if  not FGeral.LeiLGPDP then  begin
//
//     exit;
//
//  end else if not Global.topicos[1103] then begin
  if not Global.topicos[1103] then begin

     case Page.ActivePageIndex of
       0: begin bCancelarClick(Sender);  Grid.SetFocus; end;
//       1..3: GetFieldsCliente;
//       4: SelecionaReferencias;
       1..2: begin GetFieldsCliente; Confbotoes('1;2') ; end;
       4: SelecionaReferencias;
// 01.04.15 - vivan
       5: begin;GetFieldsCliente;SelecionaDocumentos;end;
     end;
  end else begin
     case Page.ActivePageIndex of
       0: begin bCancelarClick(Sender);  Grid.SetFocus; end;
       1..3: begin GetFieldsCliente; Confbotoes('1;2;3') ; EdClie_codigofinan.valid end;
       4: SelecionaReferencias;
     end;
  end;

end;

procedure TFCadcli.bCancelarClick(Sender: TObject);
begin
  DesabilitaEdts;
  bIncluir.Black;
  bAlterar.Black;
  Tipo:='';
  bSair.enabled:=true;
  GetFieldsCliente;
end;

procedure TFCadcli.DesabilitaEdts;
///////////////////////////////////
begin
  PCadastro.Enabled:=False;
  PEnderecos.Enabled:=False;
  PCadastro.DisableEdits;
  PEnderecos.DisableEdits;
// 22.05.07
  PDiversos.Enabled:=False;
  PDiversos.DisableEdits;
// 11.07.06
  FGeral.SetaCorEdits(false,FCadcli);

end;

procedure TFCadcli.HabilitaEdts;
begin
  PCadastro.Enabled:=True;
  PEnderecos.Enabled:=True;
  PCadastro.EnableEdits;
  EditsRetirados;
  PEnderecos.EnableEdits;
  if Global.topicos[1103] then begin
    PDiversos.EnableEdits;
    PDiversos.Enabled:=true;
    Edclie_limcredito.enabled:=Global.Usuario.OutrosAcessos[0038];
  end;
  if Global.topicos[1105] then begin
    PCtg.EnableEdits;
    PCtg.Enabled:=true;
    edvlrmensalidade.Enabled:=false;
  end;
  Edclie_situacao.enabled:=Global.Usuario.OutrosAcessos[0036];
// 13.05.10
  Edclie_aliinsspro.Enabled:=Global.Usuario.OutrosAcessos[0323];
// 16.09.10 - inss dep. em conta
 {
  Edclie_depojudi.Enabled:=Global.Usuario.OutrosAcessos[0323];
  Edclie_contadepojudi.Enabled:=Global.Usuario.OutrosAcessos[0323];
  Edclie_aliinssdepjud.Enabled:=Global.Usuario.OutrosAcessos[0323];
  }
end;


function TFCadcli.GetProxCodigo(NomeTabela:String; Digito:Boolean):Integer;
var Q:TSqlQuery; Sql,Cod:String;
begin
 Cod:=''; Sql:='';
 if      NomeTabela='CLIENTES'    then Sql:='Select Max(Clie_Codigo) As Proximo From Clientes'
 else if NomeTabela='REFERENCIAS' then Sql:='Select Max(Refc_Chave)  As Proximo From Referencias';
// else if NomeTabela='VINCULADOS'  then Sql:='Select Max(Vinc_Codigo) As Proximo From Vinculados';
 Q:=SqlToQuery(Sql);
 if Q.FieldByName('Proximo').AsInteger>0 then begin
    Cod:=Trim(Q.FieldByName('Proximo').AsString);
    if Digito then Cod:=LeftStr(Cod,Length(Cod)-1);
 end;
 Q.Close;
 FreeAndNil(Q);
 Result:=Inteiro(Cod)+1;
 if Digito then begin
    Cod:=IntToStr(Result);
    Result:=Inteiro(Cod+GetDigito(Cod,'MOD'));
 end;
end;


///////////////////////////////////////
procedure TFCadcli.GravaCliente;
///////////////////////////////////////
var codigocli:integer;


  procedure VerificaAlteracao;
  /////////////////////////////
  var i:Integer; Ed:TSqlEd;
  begin
    for i:=0 to ComponentCount-1 do begin
        if (Components[i] is TSQLEd) then begin
           Ed:=TSQLEd(Components[i]);
           if (UpperCase(Ed.TableName)='CLIENTES') and Ed.Enabled and Ed.ValueChanged then begin
              EdClie_DataAlt.SetDate(Sistema.Hoje);
              Break;
           end;
        end;
    end;
  end;

begin

  if trim(EdClie_Consfinal.Text)='' then EdClie_consfinal.text:='N';
  if Tipo='I' then begin
//     EdClie_Codigo.SetValue(GetProxCodigo('CLIENTES',True));
     EdClie_Codigo.SetValue(GetProxCodigo('CLIENTES',False));
     codigocli:=EdClie_Codigo.asinteger;
     EdClie_DtCad.SetDate(Sistema.Hoje);
     EdClie_Unid_Codigo.Text:=Global.CodigoUnidade;
     EdClie_Usua_Codigo.SetValue(Global.Usuario.Codigo);
     Grid.PostInsert(EdClie_Nome);
     Seleciona(PgCadastro);
     Arq.TClientes.Commit;
  end else if bAlterar.Font.Color=Sistema.Btns.FontColorRed then begin
     VerificaAlteracao;
     Arq.TClientes.Edit;
     Arq.TClientes.SetFields(Self,0);
     Arq.TClientes.Post;
     Arq.TClientes.Commit;
// 10.09.13 - vivan
     if EdClie_Limcredito.OldValue<>EdClie_Limcredito.Text then
       FGeral.GravaLog(28,'cliente '+Arq.TClientes.FieldByName('Clie_codigo').asstring+
                ' - '+Arq.TClientes.FieldByName('Clie_Nome').asstring+
                ' de '+EdClie_Limcredito.OldValue+' para '+EdClie_Limcredito.Text);
// 16.12.13 - vivan - Angela
     if EdClie_Situacao.OldValue<>EdClie_Situacao.Text then
       FGeral.GravaLog(29,'cliente '+Arq.TClientes.FieldByName('Clie_codigo').asstring+
                ' - '+Arq.TClientes.FieldByName('Clie_Nome').asstring+
                ' de '+EdClie_Situacao.OldValue+' para '+EdClie_Situacao.Text);
     bCancelarClick(Self);
  end;
// 12.12.05
//  if (Global.CodigoUnidade=Global.unidadefloripa)  or (global.usuario.codigo=300) then
//        FPesquisa01.execute(Arq.TClientes.fieldbyname('Clie_codigo').asinteger);
//       bpesquisaclick(Self);

end;

procedure TFCadcli.Seleciona(Pg:TTabSheet);
begin
  Page.ActivePage := Pg;
  PageChange(Self);
end;

procedure TFCadcli.tira(Sender: TObject);
begin
  if Tipo='I' then begin
     Seleciona(PgEnderecos);
     EdClie_endres.ClearAll(Self,0);
// 17.05.16
     if  trim(ACBrNFe1.WebServices.ConsultaCadastro.RetWS)<>'' then begin
       EdClie_endres.text:=FExpNfetxt.GetTag('xlgr',ACBrNFe1.WebServices.ConsultaCadastro.RetWS)+','+
                           FExpNfetxt.GetTag('nro',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
       EdClie_bairrores.text:=FExpNfetxt.GetTag('xbairro',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
       EdClie_cepres.text:=FExpNfetxt.GetTag('cep',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
     end;

// 18.04.14
{
     if FGeral.Tirabarra( F_Principal.ACBrConsultaCNPJ1.cnpj,'/.-') = EdClie_cnpjcpf.text then begin
        if EdClie_endres.IsEmpty then EdClie_endres.text:=F_Principal.ACBrConsultaCNPJ1.Endereco+' '+
          F_Principal.ACBrConsultaCNPJ1.Numero;
        if EdClie_bairrores.IsEmpty then EdClie_bairrores.text:=F_Principal.ACBrConsultaCNPJ1.Bairro;
        if EdClie_cepres.IsEmpty then EdClie_cepres.text:=FGeral.Tirabarra( F_Principal.ACBrConsultaCNPJ1.CEP,'-' );
     end;
     }
  end else begin
     GravaCliente;
  end;
  bSair.enabled:=true;
end;

procedure TFCadcli.EdClie_codcliempExitEdit(Sender: TObject);
begin
  if not Global.Topicos[1103] then
    GravaCliente
  else begin
    if Tipo='I' then begin
       Seleciona(PgDiversos);
       EdClie_ativo.ClearAll(Self,0);
    end else begin
       GravaCliente;
    end;
    bSair.enabled:=true;
  end;
// n�o funga direito ; n�o pega o codigo do cliente e referencia direito - 19.01.05
//  if Tipo='I' then begin
//     Seleciona(PgReferencias);
//     EdRefC_Clie_Codigo.ValueDefault:=Arq.TClientes.FieldByName('CLIE_CODIGO').AsString;
//     EdRefC_Clie_Codigo.ValueDefault:=EdClie_codigo.text;
//     GridRef.Insert(EdRefc_NomeRef);
//     bincluirclick(FCadcli);
//  end;
end;

procedure TFCadcli.EdClie_motivoExitEdit(Sender: TObject);
begin
  GravaCliente;
end;

procedure TFCadcli.EdClie_muni_codigo_resValidate(Sender: TObject);
begin
  EdMuniRes_Nome.Text:=FCidades.GetNome(EdClie_Muni_Codigo_Res.AsInteger);
  EdMuniRes_UF.Text:=FCidades.GetUF(EdClie_Muni_Codigo_Res.AsInteger);
  if uppercase(EdMuniRes_UF.Text)='XX' then begin
    avisoerro('Ajustar estado XX no cadastro de cidades');
    exit;
  end;
  if EdClie_Muni_Codigo_Res.IsEmpty then Exit;
  if EdMuniRes_Nome.Text='' then EdClie_Muni_Codigo_Res.Invalid('Cidade n�o cadastrada')
  else EdClie_cidade.text:=EdMuniRes_Nome.Text;

end;

procedure TFCadcli.EdClie_muni_codigo_comValidate(Sender: TObject);
begin
  EdMuniCom_Nome.Text:=FCidades.GetNome(EdClie_Muni_Codigo_Com.AsInteger);
  EdMuniCom_UF.Text:=FCidades.GetUF(EdClie_Muni_Codigo_Com.AsInteger);
  if uppercase(EdMunicom_UF.Text)='XX' then begin
    avisoerro('Ajustar estado XX no cadastro de cidades');
    exit;
  end;
  if EdClie_Muni_Codigo_Com.IsEmpty then Exit;
  if EdMuniCom_Nome.Text='' then EdClie_Muni_Codigo_Com.Invalid('Cidade n�o cadastrada');
end;

procedure TFCadcli.bAlterarClick(Sender: TObject);
begin
  if not Global.topicos[1103] then begin
    if not (Page.ActivePageIndex in [1..2]) then Exit;
  end else begin
    if not (Page.ActivePageIndex in [1..3]) then Exit;
  end;
  bSair.enabled:=false;
  bAlterar.Red;
  bIncluir.White;
  EdClie_Codigo.SetStatusEdits(Self,0,seEditAll);
  Tipo:='A';
  HabilitaEdts;
  if not Global.topicos[1103] then begin
    case Page.ActivePageIndex of
         1: EdClie_Codigo.SetFirstEd;
         2: EdClie_EndRes.SetFirstEd;
    end;
  end else begin
    case Page.ActivePageIndex of
         1: EdClie_Codigo.SetFirstEd;
         2: EdClie_EndRes.SetFirstEd;
         3: EdClie_Ativo.SetFirstEd;
    end;
  end;
end;

procedure TFCadcli.EdClie_tipoChange(Sender: TObject);
begin
  if EdClie_Tipo.Text = 'F' then
     EdClie_CnpjCpf.EditMask := f_Cpf
  else
     EdClie_CnpjCpf.EditMask := f_Cgc;
end;

procedure TFCadcli.EdClie_contagerencialKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//  if Key=VK_F12 then GetConta_Execute(EdClie_ContaGerencial,'CR','','C');
end;

procedure TFCadcli.EdClie_contagerencialValidate(Sender: TObject);
begin
//  if not EdClie_ContaGerencial.IsEmpty then GetConta_Validar(EdClie_ContaGerencial,Trim(EdClie_ContaGerencial.Text),'CR','','C');
end;
procedure TFCadcli.EdClie_contribuinteChange(Sender: TObject);
begin

end;

// refeito em 17.05.16
procedure TFCadcli.bcnpjClick(Sender: TObject);
////////////////////////////////////////////////////
var ps:integer;
begin
//  Arq.TClien'tes.Prior;
//  GetFieldsCliente;
//  PageChange(Self);
//  if EdClie_razaosocial.Enabled then begin
  if EdClie_cnpjcpf.Enabled then begin

    if EdClie_uf.isempty then
      ACBrNFe1.WebServices.ConsultaCadastro.UF  := Global.UfUnidade
    else
      ACBrNFe1.WebServices.ConsultaCadastro.UF  := EdClie_uf.text;
    if Length(EdClie_cnpjcpf.text) > 11 then
       ACBrNFe1.WebServices.ConsultaCadastro.CNPJ := EdClie_cnpjcpf.text
    else
       ACBrNFe1.WebServices.ConsultaCadastro.CPF := EdClie_cnpjcpf.text;


    if  ACBrNFe1.WebServices.ConsultaCadastro.Executar then begin

      EdClie_rgie.text:=FExpNfetxt.GetTag('IE',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      EdClie_razaosocial.text:=FExpNfetxt.GetTag('xnome',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      ps:=pos('&amp;',EdClie_razaosocial.text);
      if ps>0 then EdClie_razaosocial.text:=copy(EdClie_razaosocial.text,1,ps)+copy(EdClie_razaosocial.text,ps+length('&amp;'),30);
      EdClie_razaosocial.Next;
      EdClie_endres.text:=FExpNfetxt.GetTag('xlgr',ACBrNFe1.WebServices.ConsultaCadastro.RetWS)+','+
                          FExpNfetxt.GetTag('nro',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      EdClie_bairrores.text:=FExpNfetxt.GetTag('xbairro',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      EdClie_cepres.text:=FExpNfetxt.GetTag('cep',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      EdClie_uf.text:=FExpNfetxt.GetTag('uf',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      EdClie_nome.text:=FExpNfetxt.GetTag('xnome',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      if EdClie_dtcad.IsEmpty then
         EdClie_dtcad.SetDate( Sistema.Hoje );

    end else begin

//      avisoerro('CNPJ / CPF n�o encontrado na consulta pela UF '+ACBrNFe1.WebServices.ConsultaCadastro.UF);
      avisoerro( ACBrNFe1.WebServices.ConsultaCadastro.xMotivo )

    end;
//    F_Principal.Execute;
// 21.01.15
{
    F_Principal.show;
    if (trim(F_Principal.EditRazaoSocial.Text)<>'') and (F_Principal.EditSituacao.text='ATIVA') then begin
      if EdClie_tipo.Isempty then Edclie_tipo.text:='J';
      if EdClie_uf.Isempty then Edclie_uf.text:=F_Principal.EditUF.Text;
      if Edclie_razaosocial.IsEmpty then Edclie_razaosocial.Text:=F_Principal.EditRazaoSocial.Text;
      if EdClie_cnpjcpf.Isempty then EdClie_cnpjcpf.Text:=FGeral.TiraBarra( F_Principal.ACBrConsultaCNPJ1.CNPJ,'/.-' );
      if EdClie_nome.Isempty then begin
        if (trim(F_Principal.ACBrConsultaCNPJ1.Fantasia)<>'') and (copy(F_Principal.ACBrConsultaCNPJ1.Fantasia,1,4)<>'****') then
          EdClie_nome.Text:=F_Principal.ACBrConsultaCNPJ1.Fantasia
        else
          if EdClie_nome.Isempty then EdClie_nome.Text:=F_Principal.ACBrConsultaCNPJ1.RazaoSocial;
      end;
    end;
    }
  end else
    bsair.Enabled:=true;

end;

procedure TFCadcli.bPesquisarClick(Sender: TObject);
//////////////////////////////////////////////////////
var Qb:TSqlquery;
    cbusca,x:string;
    Lista:TStringList;
begin

   if not Input('Palavra para pesquisa','Informe',cbusca,30,false) then exit;
   if trim(cbusca)='' then exit;
   Qb:=sqltoquery('select clie_nome,clie_codigo from clientes where clie_nome like '+stringtosql('%'+trim(cbusca)+'%'));
   Lista:=TStringList.create;
   Lista.Add('NOME');
   while not Qb.Eof do begin
     Lista.add( Qb.FieldByName('clie_codigo').AsString+' - '+Qb.FieldByName('clie_nome').AsString );
     Qb.Next;
   end;
   Qb.Close;
   Qb:=sqltoquery('select clie_razaosocial,clie_codigo from clientes where clie_razaosocial like '+stringtosql('%'+trim(cbusca)+'%'));
   Lista.Add('RAZ�O SOCIAL');
   while not Qb.Eof do begin
     Lista.add( Qb.FieldByName('clie_codigo').AsString+' - '+Qb.FieldByName('clie_razaosocial').AsString );
     Qb.Next;
   end;
   Qb.Close;
   x:=SelecionaItems( Lista,'Encontrados','' );
   x:=copy(x,1,Ansipos('-',x)-2 );
   if Lista.Count>2 then begin

      Arq.TClientes.SetFindBrowse('clie_codigo = '+x);

   end;

   Lista.Free;

end;

procedure TFCadcli.bProximoClick(Sender: TObject);
begin
  Arq.TClientes.Next;
//  GetFieldsCliente;
  PageChange(Self);
end;




procedure TFCadcli.EdRefc_obsExitEdit(Sender: TObject);
begin
  EdRefc_Chave.SetValue(GetProxCodigo('REFERENCIAS',False));
  GridRef.PostInsert(EdRefc_NomeRef);
end;



procedure TFCadcli.bRelatorioClick(Sender: TObject);
begin
  PopupMenu.Popup(Self.Left+520,Self.Top+228);
end;

procedure TFCadcli.EdClie_tipoValidate(Sender: TObject);
begin
  if EdClie_RazaoSocial.IsEmpty then EdClie_RazaoSocial.Text:=EdClie_Nome.Text;
//  if EdClie_NomeCartao.IsEmpty then EdClie_NomeCartao.Text:=LeftStr(EdClie_Nome.Text,30);
//  EdClie_RazaoSocial.Enabled:=EdClie_Tipo.Text='J';
  EdClie_Sexo.Enabled:=EdClie_Tipo.Text='F';
  EdClie_dtexprg.Enabled:=EdClie_Tipo.Text='F';
  EdClie_orgexprg.Enabled:=EdClie_Tipo.Text='F';
  EdClie_naturalidade.Enabled:=EdClie_Tipo.Text='F';
  EdClie_estadocivil.Enabled:=EdClie_Tipo.Text='F';
  EdClie_descrestadocivil.Enabled:=EdClie_Tipo.Text='F';
  EdClie_escolaridade.Enabled:=EdClie_Tipo.Text='F';
  EdClie_ufexprg.Enabled:=EdClie_Tipo.Text='F';
  EdClie_dependentes.Enabled:=EdClie_Tipo.Text='F';
  EdClie_dtnasc.Enabled:=EdClie_Tipo.Text='F';
  EdClie_ipi.enabled:=EdClie_Tipo.Text='J';
// 09.08.11 - Janina
  EdClie_nomecje.enabled:=EdClie_Tipo.Text='F';
// 18.08.11 - Janina
  EdClie_trabalhocje.enabled:=EdClie_Tipo.Text='F';
// 13.03.17
  if Global.Topicos[1048] then begin
    EdClie_dtexprg.Enabled:=false;
    EdClie_orgexprg.Enabled:=false;
    EdClie_naturalidade.Enabled:=false;
    EdClie_estadocivil.Enabled:=false;
    EdClie_descrestadocivil.Enabled:=false;
    EdClie_escolaridade.Enabled:=false;
    EdClie_ufexprg.Enabled:=false;
    EdClie_dependentes.Enabled:=false;
    EdClie_ipi.enabled:=false;
  end;

end;

procedure TFCadcli.EdClie_estadocivilValidate(Sender: TObject);
begin
  EdClie_DescrEstadoCivil.Enabled:=EdClie_EstadoCivil.Text='4';
  if not EdClie_DescrEstadoCivil.Enabled then EdClie_DescrEstadoCivil.Text:=GetDescricaoItems(EdClie_EstadoCivil);
end;

// 27.09.17
function TFCadcli.GetDescontoVenda(codigo: integer): currency;
///////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  q:=sqltoquery('select clie_descontovenda from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then begin
    result:=Q.fieldbyname('clie_descontovenda').ascurrency;
  end else
    result:=0;
  q.close;
  freeandnil(q);
end;

function TFCadcli.GetDescricaoItems(Ed: TSqlEd): String;
var i:Integer; s:String;
begin
  Result:='';
  if Ed<>nil then begin
     for i:=0 to Ed.Items.Count-1 do begin
         s:=Ed.Items.Strings[i];
         if LeftStr(s,1)=Ed.Text then begin
            Delete(s,1,4);
            Result:=s;
         end;
     end;
  end;
end;

procedure TFCadcli.EdClie_cnpjcpfValidate(Sender: TObject);
var Ed:TSQLEd;
begin
  Ed:=TSQLEd(Sender);
///  if copy(Ed.text,1,11)='00000000000' then exit;  // 22.05.07
  if not Global.Topicos[1102] and Ed.IsEmpty then Ed.Invalid('N�o permitido vazio');
  if not Global.Topicos[1102] and not Ed.IsEmpty then FGeral.ValidaCNPJCPF(Ed);
// 05.10.10 - Novi - Vava
  if not ValidaPessoa(Ed.Text,EdClie_tipo.text) then Ed.Invalid('');
end;


procedure TFCadcli.Cadastro1Click(Sender: TObject);
//////////////////////////////////////////////////////////
var w:string;
begin
  w:=' where '+FGeral.GetIN('clie_unid_codigo',Global.Usuario.UnidadesRelatorios,'C');
  FRel.ReportFromSQL('SELECT * FROM CLIENTES '+w,'RelCadClientes','Relat�rio do Cadastro de Clientes');
end;


procedure TFCadcli.Histrico1Click(Sender: TObject);
begin
//  FRelFin.RelHistorico(Arq.TClientes.FieldByName('Clie_codigo').AsString,'C');
end;

procedure TFCadcli.Limites1Click(Sender: TObject);
begin
  UsadoLimite('C',Arq.TClientes.FieldByName('Clie_Codigo').AsString);
end;

// 09.12.19
function TFCadcli.NaoVisualizaCnpj(codigo: Integer): boolean;
/////////////////////////////////////////////////////////////////
begin

   result := not ( Global.Usuario.OutrosAcessos[0066] ) and ( Global.Topicos[1116] );

end;

// 05.06.17
procedure TFCadcli.Ocorrncias1Click(Sender: TObject);
///////////////////////////////////////////////////////////
var w:string;
    Q:TSqlquery;
begin
  if not Sistema.GetPeriodo('Periodo :') then exit;
  w:=' where ocor_data >= '+DAtetosql(sistema.Datai)+' and ocor_data <= '+Datetosql(Sistema.Dataf)+
     ' and ocor_catentidade=''C'''+
     ' and ocor_status = ''N'''+
     ' order by ocor_data';
  Q:=sqltoquery('SELECT * FROM ocorrencias inner join clientes on ( clie_codigo=ocor_codentidade ) '+w);
  if Q.Eof then begin
    Avisoerro('Nada encontrado para impress�o');
    exit;
  end;
  Sistema.BeginProcess('Imprimindo relat�rio');
    FRel.Init('RelOcoClientes');
    FRel.AddTit('Relat�rio do Ocorr�ncias de Clientes - Per�odo : '+formatdatetime('dd/mm/yy',Sistema.DAtai)+' a '+formatdatetime('dd/mm/yy',Sistema.DAtaf) );

    FRel.AddCol( 60,3,'N','' ,''              ,'Codigo'          ,''         ,'',false);
    FRel.AddCol(220,0,'C','' ,''              ,'Nome'           ,''         ,'',false);
    FRel.AddCol( 60,1,'N','' ,''              ,'Data'        ,''         ,'',false);
    FRel.AddCol(400,1,'C','' ,''              ,'Ocorr�ncia'        ,''         ,'',false);
    FRel.AddCol(120,1,'C','' ,''              ,'Usu�rio'          ,''         ,'',false);
    while not Q.eof do begin
        FRel.AddCel(Q.fieldbyname('ocor_codentidade').asstring);
        FRel.AddCel(Q.fieldbyname('clie_nome').asstring);
        FRel.AddCel( formatdatetime('dd/mm/yy',Q.fieldbyname('ocor_data').asdatetime) );
        FRel.AddCel( Q.fieldbyname('ocor_descricao').asstring );
        FRel.AddCel( FUsuarios.GetNome( Q.fieldbyname('ocor_usuario').asinteger ));
      Q.next;
    end;
    FRel.Video;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

end;

procedure TFCadcli.LimitedeCheques1Click(Sender: TObject);
begin
  UsadoLimite('G',Arq.TClientes.FieldByName('Clie_CnpjCpf').AsString);
end;

procedure TFCadcli.UsadoLimite(CatEntidade, CodEntidade: String);
begin
end;


function TFCadcli.GetNome(codigo: integer): string;
var Q:Tsqlquery;
begin
//  if not Arq.Tclientes.active then Arq.Tclientes.open;
//  if Arq.TClientes.Locate('clie_codigo',codigo,[]) then
//    result:=Arq.TClientes.fieldbyname('clie_nome').asstring
//  else
//    result:='';
  q:=sqltoquery('select clie_nome from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then
    result:=q.fieldbyname('clie_nome').asstring
  else
    result:='';
  q.close;
  freeandnil(q);
end;

procedure TFCadcli.EdClie_cpfcjeValidate(Sender: TObject);
var Ed:TSqled;
begin
  Ed:=TSQLEd(Sender);
  if not Ed.isempty then
    FGeral.ValidaCNPJCPF(Ed);

end;

function TFCadcli.GetRazaoSocial(codigo: integer): string;
var Q:Tsqlquery;
begin
//  if not Arq.Tclientes.active then Arq.Tclientes.open;
//  if Arq.TClientes.Locate('clie_codigo',codigo,[]) then
//    result:=Arq.TClientes.fieldbyname('clie_razaosocial').asstring
//  else
//    result:='';
  q:=sqltoquery('select clie_razaosocial from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then
    result:=q.fieldbyname('clie_razaosocial').asstring
  else
    result:='';
  q.close;
  freeandnil(q);

end;

// 21.02.18
// verifica se o cliente � do simples nacional
function TFCadcli.GetSimplesNacional(codigo: integer): string;
////////////////////////////////////////////////////////////////
Var Q:TSqlquery;
begin

  result:='N';
  q:=sqltoquery('select clie_contribuinte from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then begin

    if q.fieldbyname('clie_contribuinte').asstring = '1' then result:='S';

  end;

  Q.Close;

end;

function TFCadcli.GetSituacao(codigo: integer): String;
///////////////////////////////////////////////////////
Var Q:TSqlquery;
begin

  q:=sqltoquery('select clie_situacao from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then
    result:=q.fieldbyname('clie_situacao').asstring
  else
    result:=' ';
  Q.Close;

end;

function TFCadcli.GetCnpjCpf(codigo: integer;masc:string='N'): string;
//////////////////////////////////////////////////////
var q:Tsqlquery;
begin
{
  if not Arq.Tclientes.active then Arq.Tclientes.open;
  if Arq.TClientes.Locate('clie_codigo',codigo,[]) then
    result:=Arq.TClientes.fieldbyname('clie_cnpjcpf').asstring
  else
    result:='';
}
  q:=sqltoquery('select clie_cnpjcpf from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then begin
    if masc='N' then
      result:=q.fieldbyname('clie_cnpjcpf').asstring
    else
      result:=FormatoCGCCPF(Q.fieldbyname('clie_cnpjcpf').asstring);
  end else
    result:='';
  q.close;
  freeandnil(q);

end;

function TFCadcli.GetInsEst(codigo: integer): string;
var q:Tsqlquery;
begin
//  if not Arq.Tclientes.active then Arq.Tclientes.open;
//  if Arq.TClientes.Locate('clie_codigo',codigo,[]) then
//    result:=Arq.TClientes.fieldbyname('clie_rgie').asstring
//  else
//    result:='';
  q:=sqltoquery('select clie_rgie from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then
    result:=q.fieldbyname('clie_rgie').asstring
  else
    result:='';
  q.close;
  freeandnil(q);

end;

function TFCadcli.GetUf(codigo: integer): string;
/////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
{
  if not Arq.Tclientes.active then Arq.Tclientes.open;
  if Arq.TClientes.Locate('clie_codigo',codigo,[]) then
    result:=Arq.TClientes.fieldbyname('clie_uf').asstring
  else
    result:='';
}
  q:=sqltoquery('select clie_uf from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then
    result:=q.fieldbyname('clie_uf').asstring
  else
    result:='';
  q.close;
  freeandnil(q);
end;

function TFCadcli.GetCelular(codigo: integer): string;
//////////////////////////////////////////////////////////
var  Q:TSqlquery;

begin

  Q := Sqltoquery('select Clie_fonecel from clientes where clie_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('Clie_fonecel').asstring
  else
    result:='';
  fGeral.fechaquery(Q);


end;

function TFCadcli.GetCep(codigo: integer): string;
///////////////////////////////////////////////////////
var Q:TSqlquery ;
begin

  Q := Sqltoquery('select Clie_cepres from clientes where clie_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('Clie_cepres').asstring
  else
    result:='';
  fGeral.fechaquery(Q);

end;

function TFCadcli.GetCidade(codigo: integer): string;
////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  if not Arq.TMunicipios.active then Arq.TMunicipios.open;
  q:=sqltoquery('select clie_cida_codigo_res from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then begin
    if Arq.TMunicipios.Locate('cida_codigo',q.fieldbyname('clie_cida_codigo_res').asstring,[]) then
      result:=Arq.TMunicipios.fieldbyname('cida_nome').asstring
    else
      result:='';
  end else
    result:='';
  q.close;
  freeandnil(q);

end;

function TFCadcli.GetPopulacao(codigo: integer): integer;
///////////////////////////////////////////////////////////////
var Q:Tsqlquery;
begin
  if not Arq.TMunicipios.active then Arq.TMunicipios.open;
  q:=sqltoquery('select clie_cida_codigo_res from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then begin
    if Arq.TMunicipios.Locate('cida_codigo',q.fieldbyname('clie_cida_codigo_res').asstring,[]) then
      result:=Arq.TMunicipios.fieldbyname('cida_populacao').asinteger
    else
      result:=0;
  end else
    result:=0;
  q.close;
  freeandnil(q);

end;

procedure TFCadcli.bExcluirClick(Sender: TObject);
//////////////////////////////////////////////////
var Cod,Unidades:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,CampoTipoCad,Msg:String):Boolean;
    ///////////////////////////////////////////////////////////////////
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM '+Tabela+' WHERE '+Campo+'='+Cod+' and '+CampoTipocad+'=''C''' );
      Result:=Q.FieldByName('Registros').AsInteger>0;
      if Result then AvisoErro('Encontrado lan�amentos na tabela '+tabela+' ref. '+Msg);
      Q.Close;Freeandnil(Q);
    end;


begin
  Cod:=IntToStr(Arq.TClientes.FieldByName('clie_Codigo').AsInteger);
  if (Page.ActivePageIndex in [0..2]) then begin
    Found:=FoundTabela('Movesto','Moes_tipo_Codigo','Moes_tipocad','Movimento estoque');
// 17.03.10
    if not Found then Found:=FoundTabela('Pendencias','Pend_tipo_Codigo','Pend_TipoCad','Pend�ncia Financeira');
    if not Found then Grid.Delete;
  end else begin
    Gridref.delete;
  end;
end;

procedure TFCadcli.bocorrenciaClick(Sender: TObject);
begin
  EdClie_codigo.GetField;
  EdClie_nome.GetField;
  if EdClie_codigo.asinteger>0 then
    FOcorrencias.Execute('C',EdClie_codigo.asinteger,EdClie_nome.text);

end;

procedure TFCadcli.bpesquisaClick(Sender: TObject);
begin
  if (global.CodigoUnidade=Global.unidadefloripa) or (global.usuario.codigo=300) then begin
//    if EdClie_codigo.asinteger>0 then
      FPesquisa01.Execute(Arq.TClientes.fieldbyname('Clie_codigo').asinteger);
  end;
end;

procedure TFCadcli.EditsRetirados;
///////////////////////////////////////////////
begin
  EdClie_sexo.enabled:=false;
//  EdClie_emailcorr.enabled:=false;
// 11.10.2022 - recolocado
  EdClie_endcorr.enabled:=false;
  EdClie_estadocivil.enabled:=false;
  EdClie_escolaridade.enabled:=false;
  EdClie_emprego.enabled:=false;
  EdClie_moradia.enabled:=false;
  EdClie_dtmoradia.enabled:=false;
  EdClie_valoraluguel.enabled:=false;
  EdClie_rendacomprovada.enabled:=false;
//  EdClie_nomecje.enabled:=false;
// 09.08.11 - Janina
  EdClie_cpfcje.enabled:=false;
  EdClie_rgcje.enabled:=false;
  EdClie_agecje.enabled:=false;
  EdClie_bcocje.enabled:=false;
//  EdClie_trabalhocje.enabled:=false;
// 18.08.11 - Janina
  EdClie_AnosTrabCJE.enabled:=false;
  EdClie_contagerencial.enabled:=false;
  EdNomCtaGerencial.enabled:=false;
  EdClie_pai.enabled:=false;
  EdClie_mae.enabled:=false;
  EdClie_fonepai.enabled:=false;
  if Global.topicos[1105] then begin
    EdClie_pai.enabled:=true;
    EdClie_mae.enabled:=true;
    EdClie_fonepai.enabled:=true;
  end;
// 31.10.11 - Vivan         // 19.06.12 - Simar
  if (Global.topicos[1108]) and (EdClie_tipo.text='F') then begin
    EdClie_moradia.enabled:=true;
    EdClie_dtmoradia.enabled:=true;
    EdClie_valoraluguel.enabled:=true;
    EdClie_rendacomprovada.enabled:=true;
  end;
// 31.10.11 - Vivan         // 19.06.12 - Simar
  if Global.topicos[1109] and (EdClie_tipo.text='F') then begin
    EdClie_nomecje.enabled:=true;
    EdClie_cpfcje.enabled:=true;
    EdClie_rgcje.enabled:=true;
    EdClie_agecje.enabled:=true;
    EdClie_bcocje.enabled:=true;
    EdClie_trabalhocje.enabled:=true;
    EdClie_AnosTrabCJE.enabled:=true;
  end;
// 07.03.17
  EdClie_cnpjcpf.Enabled:=not Global.Topicos[1048];
  EdClie_rgie.Enabled:=not Global.Topicos[1048];
  EdClie_dtexprg.Enabled:=not Global.Topicos[1048];
  EdClie_orgexprg.Enabled:=not Global.Topicos[1048];
  EdClie_ufexprg.Enabled:=not Global.Topicos[1048];
  EdClie_dependentes.Enabled:=not Global.Topicos[1048];
  EdClie_contribuinte.Enabled:=not Global.Topicos[1048];
  EdClie_uf.Enabled:=not Global.Topicos[1048];
  EdClie_Consfinal.Enabled:=not Global.Topicos[1048];
  Edrepr_codigo.Enabled:=not Global.Topicos[1048];
  EdClie_ipi.Enabled:=not Global.Topicos[1048];
  EdClie_situacao.Enabled:=not Global.Topicos[1048];
  EdFpgt_codigo.Enabled:=not Global.Topicos[1048];
  EdClie_portadores.Enabled:=not Global.Topicos[1048];
// 01.06.18
  EdClie_condicoespag.Enabled:=not Global.Topicos[1048];
  if Global.Topicos[1048] then begin
     EdClie_uf.text:=Global.UFUnidade;
     Edrepr_codigo.text:='1';
  end;
end;

procedure TFCadcli.EdClie_contacontabilExitEdit(Sender: TObject);
begin
   if not Global.topicos[1105] then
     Gravacliente
   else
     EdClie_integrante.setfocus;
end;

procedure TFCadcli.Edclie_limcreditoValidate(Sender: TObject);
begin
  if Edclie_limcredito.ascurrency>0 then begin
    if not FGeral.Validalimitecredito(EdClie_limcredito.ascurrency) then
       EdClie_limcredito.invalid('Limite m�ximo � '+floattostr(FGeral.GetConfig1AsFloat('Limitelimcredito')));
  end;
end;

function TFCadcli.GetContaExp(codigo: integer; unidade:string=''  ; tipo:string=''; xtipomov:string=''  ): integer;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
//  if not Arq.TClientes.active then Arq.TClientes.open;
// 16.01.17
  campo:=Sistema.GetDicionario('clientes','clie_contacompras02');
  if campo.Tipo='' then
    Q:=sqltoquery('select clie_contacontabil,clie_contavendas01,clie_unid_codigo01,clie_contavendas02,'+
                'clie_unid_codigo02,clie_ativo'+
                ' from clientes where clie_codigo='+inttostr(codigo))
  else
    Q:=sqltoquery('select clie_contacontabil,clie_contavendas01,clie_unid_codigo01,clie_contavendas02,'+
                'clie_unid_codigo02,clie_ativo,clie_contacompras02'+
                ' from clientes where clie_codigo='+inttostr(codigo));
  if not Q.eof then begin
    if (trim(unidade)='') and (tipo='') and (Q.fieldbyname('clie_ativo').asstring<>'S') then
      result:=Q.fieldbyname('clie_contacontabil').asinteger
//    else if (trim(tipo)='XX') and (Q.fieldbyname('clie_ativo').asstring='S') then
// 06.10.16 - mudado devido ao trato da unidade 002 'fazenda'
// 24.10.16 - ajustes devido a vidanova
    else if (tipo='XX') and (unidade='002') then
      result:=Q.fieldbyname('clie_contavendas02').asinteger
//    else if (trim(tipo)<>'XX') and (Q.fieldbyname('clie_ativo').asstring='S')  then
// 02.06.09 - senao retornava errado compra de produtor...
    else if (tipo='XY') and (Q.fieldbyname('clie_ativo').asstring='S') and (xtipomov='') then begin

// 04.11.16
      if unidade='002' then
        result:=Q.fieldbyname('clie_contavendas02').asinteger
      else
        result:=Q.fieldbyname('clie_contavendas01').asinteger;

// 09.12.16 - novicarnes
    end else if (xtipomov<>'') and ( pos(xtipomov,Global.CodCompraProdutor+';'+Global.CodCompraProdutorMerenda+
// 13.08.19
                 ';'+Global.CodEntradaProdutor)>0 )  then begin
// 16.01.17
      if unidade='002' then
        result:=Q.fieldbyname('clie_contacompras02').asinteger
      else
        result:=Q.fieldbyname('clie_contacontabil').asinteger;
// 10.11.16
    end else if (tipo='') and (Q.fieldbyname('clie_ativo').asstring='S')  then begin

      if unidade='002' then
        result:=Q.fieldbyname('clie_contavendas02').asinteger
      else
        result:=Q.fieldbyname('clie_contavendas01').asinteger;
// 04.11.16
    end else if unidade='002' then
        result:=Q.fieldbyname('clie_contavendas02').asinteger
    else
      result:=Q.fieldbyname('clie_contacontabil').asinteger;
{
    else if unidade=Arq.TFornec.FieldByName('Forn_unidexporta01').asstring then
      result:=Arq.TFornec.fieldbyname('forn_contaexp').asinteger
    else if unidade=Arq.TFornec.FieldByName('Forn_unidexporta02').asstring then
      result:=Arq.TFornec.fieldbyname('Forn_ContaExp02').asinteger
    else if unidade=Arq.TFornec.FieldByName('Forn_unidexporta03').asstring then
      result:=Arq.TFornec.fieldbyname('Forn_ContaExp03').asinteger
    else if unidade=Arq.TFornec.FieldByName('Forn_unidexporta04').asstring then
      result:=Arq.TFornec.fieldbyname('Forn_ContaExp04').asinteger
    else
      result:=0;
}
  end else
    result:=0;
  FGeral.fechaquery(Q);

end;

function TFCadcli.Getecooperado(codigo: integer): boolean;
///////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=sqltoquery('select Clie_ativo from clientes where clie_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('clie_ativo').asstring='S'
  else
    result:=false;
  FGeral.Fechaquery(q);
end;

// ajustes em 03.03.17
function TFCadcli.GetContaExpCotaCapital(codigo: integer;  unidade: string): integer;
/////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  campo:=Sistema.GetDicionario('clientes','clie_contacotacap02');
  if campo.Tipo<>'' then
    Q:=sqltoquery('select clie_contacotacap,clie_contacotacap02 from clientes where clie_codigo='+inttostr(codigo))
  else
    Q:=sqltoquery('select clie_contacotacap from clientes where clie_codigo='+inttostr(codigo));
  if not Q.eof then begin
      if (unidade<>'002') or (trim(unidade)='') then
        result:=Q.fieldbyname('clie_contacotacap').asinteger
      else
        result:=Q.fieldbyname('clie_contacotacap02').asinteger;
  end else
    result:=0;
  FGeral.fechaquery(Q);
end;

procedure TFCadcli.Edclie_codigofinanValidate(Sender: TObject);
var Q:TSqlquery;
begin
  if not Edclie_codigofinan.IsEmpty then begin
    Q:=sqltoquery('select clie_nome,clie_codigofinan from clientes where clie_codigo='+EdClie_codigofinan.assql);
    if not Q.eof then begin
      SetEdclifinanceiro.Text:=Q.fieldbyname('clie_nome').asstring;
      if (Q.fieldbyname('clie_codigofinan').AsInteger>0) and (Q.fieldbyname('clie_codigofinan').AsInteger<>EdClie_codigofinan.AsInteger) then
        EdClie_codigofinan.invalid('Este cliente j� est� vinculado ao codigo '+Q.fieldbyname('clie_codigofinan').AsString)
    end else
      SetEdclifinanceiro.Text:='';
    FGEral.fechaquery(Q);
  end else
    SetEdclifinanceiro.Text:='';

end;


procedure TFCadcli.SetaInvernada(Edit: TSqled);
var Lista:TStringList;
begin
  if Edit.Items.Count=0 then begin
     Lista:=TStringList.Create;
     Lista.Add('01 - Mirim');
     Lista.Add('02 - Juvenil');
     Lista.Add('03 - Adulto');
     Lista.Add('04 - Xir�');
     Edit.Items.Assign(Lista);
     Lista.Free;
  end;
end;

procedure TFCadcli.SetaMensalidade(Edit: TSqled);
var Lista:TStringList;
begin
  if Edit.Items.Count=0 then begin
     Lista:=TStringList.Create;
     Lista.Add('01 - Associado');
     Lista.Add('02 - N�o Associado');
     Lista.Add('03 - N�o contribui');
     Lista.Add('04 - Outras');
     Edit.Items.Assign(Lista);
     Lista.Free;
  end;
end;

procedure TFCadcli.EdClie_qintegraValidate(Sender: TObject);
begin
  if Edclie_qintegra.isempty then exit;
  EdVlrmensalidade.SetValue(GetValorMensalidade(EdClie_tipomensa.text,EdClie_qintegra.text));

end;

// 05.02.02
procedure TFCadcli.EdClie_rgieValidate(Sender: TObject);
////////////////////////////////////////////////////////
begin

   if tipo = 'I' then begin

     if ( EdClie_rgie.IsEmpty )  or (  EdClie_tipo.Text = 'F') then begin

         EdClie_contribuinte.Text := 'N';
         EdClie_Consfinal.Text    := 'S';

     end else begin

         EdClie_contribuinte.Text := 'S';
         EdClie_Consfinal.Text    := 'N';

     end;

   end;

end;

function TFCadcli.GetValorMensalidade(Tipomen,
  Qintegrante: string): currency;

begin
  result:=0;
  if tipomen='01' then begin   // associdado
    if qintegrante='1' then
      result:=FGeral.GetConfig1AsFloat('mens01as')
    else if qintegrante='2' then
      result:=FGeral.GetConfig1AsFloat('mens02as')
    else if qintegrante='3' then
      result:=FGeral.GetConfig1AsFloat('mens03as')
    else
      result:=FGeral.GetConfig1AsFloat('mens04as');
  end else if tipomen='02' then begin       // nao associdado
    if qintegrante='1' then
      result:=FGeral.GetConfig1AsFloat('mens01na')
    else if qintegrante='2' then
      result:=FGeral.GetConfig1AsFloat('mens02na')
    else if qintegrante='3' then
      result:=FGeral.GetConfig1AsFloat('mens03na')
    else
      result:=FGeral.GetConfig1AsFloat('mens04na');
  end else if tipomen='03' then        // nao contribui
      result:=FGeral.GetConfig1AsFloat('mens01nc')
  else if tipomen='04' then        // outras
      result:=FGeral.GetConfig1AsFloat('mens01ou');
end;

// 18.01.20
function TFCadcli.GetTabelaAcresDesc(codigo: integer): integer;
////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

  Q:=sqltoquery('select clie_tabp_codigo from clientes where clie_codigo='+inttostr(codigo));
  if not Q.eof then begin
      result:=Q.fieldbyname('clie_tabp_codigo').asinteger
  end else
    result:=0;
  FGeral.fechaquery(Q);

end;

function TFCadcli.GetTipoInvernada(Tipoinv: string): string;
begin
  if tipoinv='01' then result:='Mirim'
  else if tipoinv='02' then result:='Juvenil'
  else if tipoinv='03' then result:='Adulto'
  else if tipoinv='04' then result:='Xir�'
  else result:='';

end;

function TFCadcli.GetTipoMensalidade(Tipomen: string): string;
begin
   if tipomen='01' then result:='Associado'
   else if tipomen='02' then result:='N�o Associado'
   else if tipomen='03' then result:='N�o contribui'
   else result:='Outras';

end;

procedure TFCadcli.EdClie_grupoinvExitEdit(Sender: TObject);
begin
  Gravacliente;
end;

function TFCadcli.GetContaExpDevVenda(codigo: integer;  unidade: string): integer;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select clie_contadevven01 from clientes where clie_codigo='+inttostr(codigo));
  if not Q.eof then begin
      result:=Q.fieldbyname('clie_contadevven01').asinteger
  end else
    result:=0;
  FGeral.fechaquery(Q);

end;

procedure TFCadcli.EdClie_endresValidate(Sender: TObject);
begin
  if EdClie_endcom.isempty then EdClie_endcom.Text:=EdClie_endres.Text;
end;

procedure TFCadcli.EdClie_bairroresValidate(Sender: TObject);
begin
  if EdClie_bairrocom.isempty then EdClie_bairrocom.Text:=EdClie_bairrores.Text;

end;

procedure TFCadcli.EdClie_ConsfinalValidate(Sender: TObject);
begin
   if (EdClie_consfinal.text='R') and ( not Global.topicos[1107] ) then
     Edclie_consfinal.invalid('N�o liberado uso da op��o R - Revenda');
end;

function TFCadcli.ValidaPessoa(cnpjcpf, tipo: string): boolean;
begin
   result:=true;
   if trim(cnpjcpf)='' then exit;
   if (length(trim(cnpjcpf))=11) and (tipo<>'F') then begin
     Avisoerro('em CPF � obrigat�rio ser pessoa f�sica');
     result:=false;
   end else if (length(trim(cnpjcpf))=14) and (tipo<>'J') then begin
     Avisoerro('em CNPJ � obrigat�rio ser pessoa jur�dica');
     result:=false;
   end;
end;

function TFCadcli.GetEndereco(codigo: integer): string;
begin
  q:=sqltoquery('select clie_endres from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then
    result:=q.fieldbyname('clie_endres').asstring
  else
    result:='';
  FGeral.FechaQuery(Q);
end;

procedure TFCadcli.FichaparaCadastro1Click(Sender: TObject);
///////////////////////////////////////////////////////////////
var qtd:string;
    p:integer;
var margem,largura:integer;
    unidade:string;
begin
  qtd:='';
  if not Input('Quantas fichas ?','C�pias:',qtd,3,false) then exit;
  if trim(qtd)='' then exit;
    margem:=FTextRel.MargemEsquerda;
    largura:=74;   // 80 passa 6 colunas em matricial
    unidade:=global.codigounidade;

    FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309]);
    FTextRel.Titulo.Clear;
    FTextRel.ClearColunas;
  for p:=1 to strtoint(qtd) do begin
    ImprimeFichaCadastro;
    if ( (p mod 2)=0 ) and ( p<strtoint(qtd) ) then FTextRel.NovaPagina;
//    if (p mod 2)=0 then begin
//       FTextRel.SaltaLinha(30);
{
      FTextRel.AddTitulo(FGeral.Centra('Ficha para Cadastro de Cliente',largura),false,false,false);
      FTextRel.AddTitulo(space(margem)+replicate('-',largura+3),false,false,false);
      FTextRel.AddTitulo(space(margem)+'Unidade : '+unidade+' - '+copy(FUnidades.Getnome(Unidade),1,40)+space(35)+'  Pg: [NumPg]',false,false,false);
      FTextRel.AddTitulo(space(margem)+replicate('-',largura+3),false,false,false);
      }
//    end;

  end;
  FTextRel.Video('',9);
end;

procedure TFCadcli.ImprimeFichaCadastro;
/////////////////////////////////////////
var margem,largura:integer;
    unidade:string;
begin
    margem:=FTextRel.MargemEsquerda;
    largura:=74;   // 80 passa 6 colunas em matricial
    unidade:=global.codigounidade;

//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
      FTextRel.SaltaLinha(01);
      FTextRel.SaltaLinha(01);
      FTextRel.AddLinha(FGeral.Centra('Ficha para Cadastro de Cliente',largura),false,false,false);
      FTextRel.AddLinha(space(margem)+replicate('-',largura+3),false,false,false);
      FTextRel.AddLinha(space(margem)+'Unidade : '+unidade+' - '+copy(FUnidades.Getnome(Unidade),1,40),false,false,false);
      FTextRel.AddLinha(space(margem)+replicate('-',largura+3),false,false,false);

        FTextRel.SaltaLinha(01);
        FTextREl.AddLinha('Nome..........: '+replicate('_',40),false,false,false);
        FTextRel.SaltaLinha(01);
        FTextREl.AddLinha('Raz�o Social..: '+replicate('_',40),false,false,false);
        FTextRel.SaltaLinha(01);
        FTextREl.AddLinha('Endere�o......: '+replicate('_',40),false,false,false);
        FTextRel.SaltaLinha(01);
        FTextREl.AddLinha('Bairro........: '+replicate('_',30)+' Cep.......: '+replicate('_',08)
                         ,false,false,false);
        FTextRel.SaltaLinha(01);
        FTextREl.AddLinha('Cidade........: '+replicate('_',30)+' UF........: '+replicate('_',02)
                         ,false,false,false);
        FTextRel.SaltaLinha(01);
        FTextREl.AddLinha('Telefone......: '+replicate('_',30)+' Celular ..: '+replicate('_',17)
                         ,false,false,false);
        FTextRel.SaltaLinha(01);
        FTextREl.AddLinha('CPF...........: '+replicate('_',30)+' RG........: '+replicate('_',17)
                         ,false,false,false);
        FTextRel.SaltaLinha(01);
        FTextREl.AddLinha('Data cadastro.: '+replicate('_',10)+' Nascimento: '+replicate('_',10)
                         ,false,false,false);
        FTextRel.SaltaLinha(01);
        FTextREl.AddLinha('End. Cobran�a.: '+replicate('_',50)
                         ,false,false,false);
        FTextRel.SaltaLinha(01);

        FTextRel.AddLinha(space(margem-3)+replicate('-',largura+3),false,false,false);

        FTextRel.SaltaLinha(01);


end;

////////////// 10.01.13

// 26.02.19
function TFCadcli.GetAcrescimoVenda(codigo: integer): currency;
/////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

  q:=sqltoquery('select clie_acrescimovenda from clientes where clie_codigo = '+inttostr(codigo));
  if not q.eof then begin
    result:=Q.fieldbyname('clie_acrescimovenda').ascurrency;
  end else
    result:=0;
  q.close;
  freeandnil(q);

end;

function TFCadcli.GetBairro(codigo: integer): string;
//////////////////////////////////////////////////////
begin
  q:=sqltoquery('select Clie_bairrores from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then
    result:=q.fieldbyname('Clie_bairrores').asstring
  else
    result:='';
  FGeral.FechaQuery(Q);

end;

// 25.02.13
procedure TFCadcli.SetaCamponaMascara(Ed: TSqled);
//////////////////////////////////////////////////////
begin
  if pos( UpperCase( Ed.TableField ),'CLIE_FONECEL/' ) > 0 then
    if copy( ed.Text,1,1 ) = '0' then
      Ed.text:=copy( ed.Text,2,10 );
end;
// 16.12.19
procedure TFCadcli.SetaEdit(Edit: TSqled; campofiltro, conteudofiltro: string);
//////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqlfiltro:string;

begin

  sqlfiltro:='';
  if ( Trim(campofiltro)<>'' ) and ( trim(conteudofiltro)<>'' ) then
     sqlfiltro:= ' where '+campofiltro+' = '+stringtosql( conteudofiltro );

  Q:=sqltoquery('select clie_codigo,clie_nome,clie_razaosocial from clientes'+
                sqlfiltro+ ' order by clie_nome' );

  Edit.Items.Clear;
  while not Q.Eof do begin

     Edit.Items.Add( strzero(Q.FieldByName('clie_codigo').AsInteger,7)+ ' | '+
                     strspace( Q.FieldByName('clie_nome').AsString,40)+ ' | '+
                     strspace( Q.FieldByName('clie_razaosocial').AsString,40) );
     Q.Next;

  end;
  FGeral.FechaQuery(q);

end;



function TFCadcli.GetCodigoCidade(codigo: integer): string;
///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  q:=sqltoquery('select clie_cida_codigo_res from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then begin
    result:=Q.fieldbyname('clie_cida_codigo_res').asstring
  end else
    result:='';
  q.close;
  freeandnil(q);
end;

function TFCadcli.GetCodigoMoto(codigo: integer): string;
/////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

  q:=sqltoquery('select clie_tran_codigo from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then begin
    result:=Q.fieldbyname('clie_tran_codigo').asstring;
  end else
    result:='';
  q.close;
  freeandnil(q);

end;

function TFCadcli.GetLimitecredito(codigo: integer): currency;
////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  q:=sqltoquery('select clie_limcredito from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then begin
    result:=Q.fieldbyname('clie_limcredito').ascurrency
  end else
    result:=0;
  q.close;
  freeandnil(q);
end;

// 06.01.14
procedure TFCadcli.ExtratoClienteClick(Sender: TObject);
///////////////////////////////////////////////////////////
begin
   FRelGerenciais_PosicaoCliente
end;

//////////////////////////////////////////////////////////////////
function TFCadcli.GetDatadeCadastro(codigo: integer): TDateTime;
//////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  q:=sqltoquery('select clie_dtcad from clientes where clie_codigo='+inttostr(codigo));
  if not q.eof then begin
    result:=Q.fieldbyname('clie_dtcad').asdatetime
  end else
    result:=0;
  q.close;
  freeandnil(q);
end;

procedure TFCadcli.bimportafornecClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////
begin
  Edfornec.Visible:=true;
  Edfornec.Enabled:=true;
  EdFornec.SetFocus;
end;

procedure TFCadcli.EdFornecExit(Sender: TObject);
begin
  Edfornec.Visible:=false;
  Edfornec.Enabled:=false;
end;

procedure TFCadcli.EdFornecValidate(Sender: TObject);
//////////////////////////////////////////////////////////
var codigocli:integer;
    Q:TSqlquery;
begin

  if edfornec.isempty then exit;
  Q:=sqltoquery('select clie_codigo,clie_cnpjcpf from clientes where clie_cnpjcpf='+
                 Stringtosql(EdFornec.ResultFind.fieldbyname('forn_cnpjcpf').asstring));
  if not q.eof then begin
    Edfornec.Invalid('Cnpj/cpf encontrado no cliente '+Q.fieldbyname('clie_codigo').asstring);
    exit;
  end;

  if not confirma('Criar novo cliente com os dados do fornecedor '+edFornec.text+' - '+
          Edfornec.Resultfind.fieldbyname('forn_razaosocial').asstring+' ?' ) then exit;
  Sistema.BeginProcess('Incluindo');
  codigocli:=(GetProxCodigo('CLIENTES',False));

  Sistema.Insert('clientes');
  Sistema.SetField('clie_codigo',codigocli);
  Sistema.SetField('clie_nome',copy(EdFornec.ResultFind.fieldbyname('forn_nome').asstring,1,40));
  Sistema.SetField('clie_razaosocial',copy(EdFornec.ResultFind.fieldbyname('forn_razaosocial').asstring,1,40));
  Sistema.SetField('clie_tipo','C');
  Sistema.SetField('clie_cnpjcpf',EdFornec.ResultFind.fieldbyname('forn_cnpjcpf').asstring);
  Sistema.SetField('clie_rgie',EdFornec.ResultFind.fieldbyname('forn_inscricaoestadual').asstring);
  Sistema.SetField('clie_uf',EdFornec.ResultFind.fieldbyname('forn_uf').asstring);
  Sistema.SetField('clie_endres',copy(EdFornec.ResultFind.fieldbyname('forn_endereco').asstring,1,40));
//  Sistema.SetField('clie_endrescompl', character varying(20),
  Sistema.SetField('clie_bairrores',copy(EdFornec.ResultFind.fieldbyname('forn_bairro').asstring,1,30));
  Sistema.SetField('clie_cida_codigo_res',EdFornec.ResultFind.fieldbyname('forn_cida_codigo').asinteger);
  Sistema.SetField('clie_cepres',EdFornec.ResultFind.fieldbyname('forn_cep').asstring);
  Sistema.SetField('clie_foneres',EdFornec.ResultFind.fieldbyname('forn_fone').asstring);
  Sistema.SetField('clie_fonecel',EdFornec.ResultFind.fieldbyname('forn_fax').asstring);
  Sistema.SetField('clie_email',EdFornec.ResultFind.fieldbyname('forn_email').asstring);
// 11.10.2022 - recolocado - Centro - Email de cobran�a
  Sistema.SetField('clie_emailcorr',Edclie_emailcorr.text);
//  Sistema.SetField('clie_endcorr', character varying(1),
  Sistema.SetField('clie_endcom',copy(EdFornec.ResultFind.fieldbyname('forn_endereco').asstring,1,50));
  Sistema.SetField('clie_bairrocom',copy(EdFornec.ResultFind.fieldbyname('forn_bairro').asstring,1,30));
  Sistema.SetField('clie_cida_codigo_com',EdFornec.ResultFind.fieldbyname('forn_cida_codigo').asinteger);
  Sistema.SetField('clie_cepcom',EdFornec.ResultFind.fieldbyname('forn_cep').asstring);
  Sistema.SetField('clie_fonecom',EdFornec.ResultFind.fieldbyname('forn_fone').asstring);
//  clie_ramal numeric(5,0),
//  clie_dtadmissao date,
  Sistema.SetField('clie_obs','Importado do fornecedor '+EdFornec.text);
  Sistema.SetField('clie_dtcad',Sistema.hoje);
//  clie_dataalt date,
  Sistema.SetField('clie_unid_codigo',Global.codigounidade);
  Sistema.SetField('clie_usua_codigo',Global.Usuario.codigo);
//  clie_repr_codigo numeric(4,0),
  Sistema.SetField('clie_email1',EdFornec.ResultFind.fieldbyname('forn_email1').asstring);
  Sistema.SetField('clie_fax', EdFornec.ResultFind.fieldbyname('forn_fax').asstring);
//  clie_ipi character varying(1),
//  clie_ativo character varying(1),
  Sistema.SetField('clie_cidade',Fcidades.GetNome(EdFornec.ResultFind.fieldbyname('forn_cida_codigo').asinteger));

  Sistema.Post();
  try
    Sistema.Commit;
    Arq.TClientes.Commit;
  except
    Sistema.EndProcess('N�o foi poss�vel gravar no banco de dados');
  end;
  EdFornec.enabled:=false;
  EdFornec.visible:=false;

  Sistema.EndProcess('Terminado');



end;

procedure TFCadcli.EdFornecKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then begin
    EdFornec.enabled:=false;
    EdFornec.visible:=false;
  end;
end;

procedure TFCadcli.bsalvarClick(Sender: TObject);
/////////////////////////////////////////////////////
var Q:Tsqlquery;
//    foto: TFileStream;
    Str:TMemoryStream;
    arquivo:string;
begin
  if confirma('Confirma grava�ao ?') then begin
     if not TDocumentos.Active then TDocumentos.Active:=true;
//     foto := TFileStream.Create(OP1.FileName, fmOpenRead);
     Q:=sqltoquery('select clid_codigo from clientesdoc where clid_codigo='+Arq.TClientes.fieldbyname('clie_codigo').asstring);
     if Q.Eof then begin
       TDocumentos.Insert;
       TDocumentos.FieldByName('clid_codigo').AsInteger:=Arq.TClientes.fieldbyname('clie_codigo').asinteger;
       TDocumentos.Commit;
//       Sistema.Insert('clientesdoc');
//       Sistema.SetField('clid_codigo',Arq.TClientes.fieldbyname('clie_codigo').asinteger);
     end;
//     if Q.Eof then
//       Sistema.post
//     else
//       Sistema.post('clid_codigo='+Arq.TClientes.fieldbyname('clie_codigo').asstring);
//     Sistema.commit;
/////////////////////
       if Im1.Picture.Height>0 then begin
         arquivo:='SaveImagem'+inttostr(global.Usuario.codigo)+'.jpg';
         Str:=TMemoryStream.Create;
         Im1.Picture.SaveToFile(arquivo);
         Str.LoadFromFile(arquivo);
         SaveBlob('clientesdoc','clid_doc1','clid_codigo='+EdClie_codigo.AsSql,Str);
         Str.Free;
         Deletefile(arquivo);
       end;
  end;

end;

procedure TFCadcli.bvisualiza2Click(Sender: TObject);
/////////////////////////////////////////////////////////
begin

   if Im2.Picture.Width > 0 then begin

      FGerapdf.Visualiza( im2.Picture );
      Visualizou := true;

   end;

end;

procedure TFCadcli.bvisualiza3Click(Sender: TObject);
//////////////////////////////////////////////////////
begin

   if Im3.Picture.Width > 0 then

      FGerapdf.Visualiza( im3.Picture );

end;

procedure TFCadcli.bvisualiza4Click(Sender: TObject);
////////////////////////////////////////////////////
begin

   if Im4.Picture.Width > 0 then

      FGerapdf.Visualiza( im4.Picture );

end;

procedure TFCadcli.bvisualizaClick(Sender: TObject);
////////////////////////////////////////////////////
begin

   if Im1.Picture.Width > 0 then begin

      FGerapdf.Visualiza( im1.Picture );
      Visualizou := true;

   end;

end;

procedure TFCadcli.barquivoClick(Sender: TObject);
////////////////////////////////////////////////////////
begin
  if not op1.Execute then exit;
  if FileExists( op1.FileName ) then begin
     Im1.Picture.LoadFromFile( op1.FileName );
  end;
end;

procedure TFCadcli.PageEnter(Sender: TObject);
begin

end;
// 01.04.15
procedure TFCadcli.PgDocumentosEnter(Sender: TObject);
//////////////////////////////////////////////////////////////
var arquivo:string;
    Str:TMemoryStream;
begin
//////////////////////////////////
     Sistema.beginprocess('lendo imagens');
     Im1.Picture:=nil;
     Str:=TMemoryStream.Create;
     if Edclie_codigo.AsInteger=0 then EdClie_codigo.setvalue(Arq.TClientes.fieldbyname('clie_codigo').AsInteger);
    //  FEstoque.EdEsto_Codigo.GetFields(FEstoque,99);
      LoadBlob('clientesdoc','clid_doc1','clid_codigo='+Arq.TClientes.fieldbyname('clie_codigo').AsString,Str);
      arquivo:='LoadImagem'+inttostr(global.Usuario.codigo)+'.jpg';
      if Str.Size>1 then begin
        Str.SaveToFile(arquivo);
        Im1.Picture.LoadFromFile(arquivo);
        Deletefile(arquivo);
      end;
      Str.Free;
     Im2.Picture:=nil;
     Str:=TMemoryStream.Create;
     if Edclie_codigo.AsInteger=0 then EdClie_codigo.setvalue(Arq.TClientes.fieldbyname('clie_codigo').AsInteger);
    //  FEstoque.EdEsto_Codigo.GetFields(FEstoque,99);
      LoadBlob('clientesdoc','clid_doc2','clid_codigo='+Arq.TClientes.fieldbyname('clie_codigo').AsString,Str);
      arquivo:='LoadImagem'+inttostr(global.Usuario.codigo)+'.jpg';
      if Str.Size>1 then begin
        Str.SaveToFile(arquivo);
        Im2.Picture.LoadFromFile(arquivo);
        Deletefile(arquivo);
      end;
      Str.Free;
     Im3.Picture:=nil;
     Str:=TMemoryStream.Create;
     if Edclie_codigo.AsInteger=0 then EdClie_codigo.setvalue(Arq.TClientes.fieldbyname('clie_codigo').AsInteger);
    //  FEstoque.EdEsto_Codigo.GetFields(FEstoque,99);
      LoadBlob('clientesdoc','clid_doc3','clid_codigo='+Arq.TClientes.fieldbyname('clie_codigo').AsString,Str);
      arquivo:='LoadImagem'+inttostr(global.Usuario.codigo)+'.jpg';
      if Str.Size>1 then begin
        Str.SaveToFile(arquivo);
        Im3.Picture.LoadFromFile(arquivo);
        Deletefile(arquivo);
      end;
      Str.Free;
     Im4.Picture:=nil;
     Str:=TMemoryStream.Create;
     if Edclie_codigo.AsInteger=0 then EdClie_codigo.setvalue(Arq.TClientes.fieldbyname('clie_codigo').AsInteger);
    //  FEstoque.EdEsto_Codigo.GetFields(FEstoque,99);
      LoadBlob('clientesdoc','clid_doc4','clid_codigo='+Arq.TClientes.fieldbyname('clie_codigo').AsString,Str);
      arquivo:='LoadImagem'+inttostr(global.Usuario.codigo)+'.jpg';
      if Str.Size>1 then begin
        Str.SaveToFile(arquivo);
        Im4.Picture.LoadFromFile(arquivo);
        Deletefile(arquivo);
      end;
      Str.Free;
      Sistema.endprocess('');

/////////////////////////////

end;

// 01.04.15
procedure TFCadcli.GridNewRecord(Sender: TObject);
//////////////////////////////////////////////////////
begin

 if not Arq.TClientes.IsEmpty then  LblCliente.Caption := 'Cliente Selecionado: '+Arq.TClientes.FieldByName('CLIE_NOME').AsString;

end;

procedure TFCadcli.bimpressaoClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var Rect: TRect;
    Escala: Integer;
    Altura, Largura: Integer;
begin
  if not pd1.Execute then exit;
  Altura:=Im1.Height*15;
  Largura:=Im1.Width*15;
  Rect.Top:=0;
  Rect.Left:=0;
  Rect.Bottom:=Altura;
  Rect.Right:=Largura;
  Printer.BeginDoc;
  Printer.Canvas.StretchDraw(Rect,Im1.Picture.Graphic);
  Printer.EndDoc;
end;

procedure TFCadcli.barquivo1Click(Sender: TObject);
//////////////////////////////////////////////////
begin
  if not op1.Execute then exit;
  if FileExists( op1.FileName ) then begin
     Im2.Picture.LoadFromFile( op1.FileName );
  end;
end;

procedure TFCadcli.bsalvar1Click(Sender: TObject);
//////////////////////////////////////////////////
var Q:Tsqlquery;
    Str:TMemoryStream;
    arquivo:string;
begin
  if confirma('Confirma grava�ao ?') then begin
     if not TDocumentos.Active then TDocumentos.Active:=true;
     Q:=sqltoquery('select clid_codigo from clientesdoc where clid_codigo='+Arq.TClientes.fieldbyname('clie_codigo').asstring);
     if Q.Eof then begin
       TDocumentos.Insert;
       TDocumentos.FieldByName('clid_codigo').AsInteger:=Arq.TClientes.fieldbyname('clie_codigo').asinteger;
       TDocumentos.Commit;
     end;
       if Im2.Picture.Height>0 then begin
         arquivo:='SaveImagem'+inttostr(global.Usuario.codigo)+'.jpg';
         Str:=TMemoryStream.Create;
         Im2.Picture.SaveToFile(arquivo);
         Str.LoadFromFile(arquivo);
         SaveBlob('clientesdoc','clid_doc2','clid_codigo='+EdClie_codigo.AsSql,Str);
         Str.Free;
         Deletefile(arquivo);
       end;
  end;

end;

procedure TFCadcli.bimpressao1Click(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var Rect: TRect;
    Escala: Integer;
    Altura, Largura: Integer;
begin
  if not pd1.Execute then exit;
  Altura:=Im2.Height*15;
  Largura:=Im2.Width*15;
  Rect.Top:=0;
  Rect.Left:=0;
  Rect.Bottom:=Altura;
  Rect.Right:=Largura;
  Printer.BeginDoc;
  Printer.Canvas.StretchDraw(Rect,Im2.Picture.Graphic);
  Printer.EndDoc;
end;

procedure TFCadcli.barquivo2Click(Sender: TObject);
//////////////////////////////////////////////////////////
begin
  if not op1.Execute then exit;
  if FileExists( op1.FileName ) then begin
     Im3.Picture.LoadFromFile( op1.FileName );
  end;

end;

procedure TFCadcli.bsalvar2Click(Sender: TObject);
////////////////////////////////////////////////////////////
var Q:Tsqlquery;
    Str:TMemoryStream;
    arquivo:string;
begin
  if confirma('Confirma grava�ao ?') then begin
     if not TDocumentos.Active then TDocumentos.Active:=true;
     Q:=sqltoquery('select clid_codigo from clientesdoc where clid_codigo='+Arq.TClientes.fieldbyname('clie_codigo').asstring);
     if Q.Eof then begin
       TDocumentos.Insert;
       TDocumentos.FieldByName('clid_codigo').AsInteger:=Arq.TClientes.fieldbyname('clie_codigo').asinteger;
       TDocumentos.Commit;
     end;
       if Im3.Picture.Height>0 then begin
         arquivo:='SaveImagem'+inttostr(global.Usuario.codigo)+'.jpg';
         Str:=TMemoryStream.Create;
         Im3.Picture.SaveToFile(arquivo);
         Str.LoadFromFile(arquivo);
         SaveBlob('clientesdoc','clid_doc3','clid_codigo='+EdClie_codigo.AsSql,Str);
         Str.Free;
         Deletefile(arquivo);
       end;
  end;

end;

procedure TFCadcli.bimpressao2Click(Sender: TObject);
//////////////////////////////////////////////////////////////////
var Rect: TRect;
    Escala: Integer;
    Altura, Largura: Integer;
begin
  if not pd1.Execute then exit;
  Altura:=Im3.Height*15;
  Largura:=Im3.Width*15;
  Rect.Top:=0;
  Rect.Left:=0;
  Rect.Bottom:=Altura;
  Rect.Right:=Largura;
  Printer.BeginDoc;
  Printer.Canvas.StretchDraw(Rect,Im3.Picture.Graphic);
  Printer.EndDoc;
end;

procedure TFCadcli.barquivo3Click(Sender: TObject);
//////////////////////////////////////////////////////
begin
  if not op1.Execute then exit;
  if FileExists( op1.FileName ) then begin
     Im4.Picture.LoadFromFile( op1.FileName );
  end;


end;

//  06.04.15
procedure TFCadcli.bsalvar3Click(Sender: TObject);
////////////////////////////////////////////////////////
var Q:Tsqlquery;
    Str:TMemoryStream;
    arquivo:string;
begin
  if confirma('Confirma grava�ao ?') then begin
     if not TDocumentos.Active then TDocumentos.Active:=true;
     Q:=sqltoquery('select clid_codigo from clientesdoc where clid_codigo='+Arq.TClientes.fieldbyname('clie_codigo').asstring);
     if Q.Eof then begin
       TDocumentos.Insert;
       TDocumentos.FieldByName('clid_codigo').AsInteger:=Arq.TClientes.fieldbyname('clie_codigo').asinteger;
       TDocumentos.Commit;
     end;
       if Im3.Picture.Height>0 then begin
         arquivo:='SaveImagem'+inttostr(global.Usuario.codigo)+'.jpg';
         Str:=TMemoryStream.Create;
         Im4.Picture.SaveToFile(arquivo);
         Str.LoadFromFile(arquivo);
         SaveBlob('clientesdoc','clid_doc4','clid_codigo='+EdClie_codigo.AsSql,Str);
         Str.Free;
         Deletefile(arquivo);
       end;
  end;

end;

procedure TFCadcli.bimpressao3Click(Sender: TObject);
//////////////////////////////////////////////////////////////////
var Rect: TRect;
    Escala: Integer;
    Altura, Largura: Integer;
begin
  if not pd1.Execute then exit;
  Altura:=Im4.Height*15;
  Largura:=Im4.Width*15;
  Rect.Top:=0;
  Rect.Left:=0;
  Rect.Bottom:=Altura;
  Rect.Right:=Largura;
  Printer.BeginDoc;
  Printer.Canvas.StretchDraw(Rect,Im4.Picture.Graphic);
  Printer.EndDoc;
end;

// 01.09.15
procedure TFCadcli.EdClie_cepresValidate(Sender: TObject);
////////////////////////////////////////////////////////////
begin
  if (length(Edclie_cepres.text)<>8) and (Global.topicos[1113]) then EdClie_cepres.invalid('Cep incorreto');
end;

// 19.11.15
procedure TFCadcli.FichaProdutor1Click(Sender: TObject);
///////////////////////////////////////////////////////////
var  Excel : Variant;
     arqu,nomecoluna:string;
     coluna,linhafim,linha,pos:integer;
     ListaCampos,ListaCampos1:TStringList;
     QU:TSqlquery;

     function trocacelula(xpos,xlinha,xcoluna:integer):string;
     ///////////////////////////////////////////////////
     begin
       Excel.Cells[xlinha,xcoluna]:=Uppercase( ListaCampos1[xpos] );
     end;

begin
  try
    Excel := CreateOleObject('Excel.Application');
  except
    Avisoerro('N�o foi poss�vel executar o Excel');
    exit;
  end;
  arqu:= ExtractFilePath( application.exename ) +  'fichadematricula.xlsx';
  if not FileExists( arqu ) then begin
    Avisoerro('Arquivo '+arqu+' n�o enconttrado');
    exit;
  end;
  Excel.Visible := false;
//  Excel.WorkBooks.Open( arq );
  Excel.Workbooks.Add( arqu );
  linhafim:=100;
  Linha:=1;
// procura a celula
  Coluna:=-1;
  ListaCampos:=TStringList.Create;
  ListaCampos1:=TStringList.Create;
  Qu:=sqltoquery('select * from unidades where unid_codigo='+stringtosql(Global.CodigoUnidade));
  ListaCampos.add('NOME UNIDADE');
  ListaCampos1.add( Global.NomeUnidade);
  ListaCampos.add('RAZAO SOCIAL UNIDADE');
  ListaCampos1.add( Qu.fieldbyname('Unid_razaosocial').asstring);
  ListaCampos.add('CNPJ UNIDADE');
  ListaCampos1.add( FGeral.Formatacnpjcpf( QU.fieldbyname('unid_cnpj').asstring ));
  ListaCampos.add('IE UNIDADE');
  ListaCampos1.add( QU.fieldbyname('Unid_inscricaoestadual').asstring);
  ListaCampos.add('ENDERECO UNIDADE');
  ListaCampos1.add( QU.fieldbyname('Unid_endereco').asstring);
  ListaCampos.add('BAIRRO UNIDADE');
  ListaCampos1.add( QU.fieldbyname('Unid_bairro').asstring);
  ListaCampos.add('CEP UNIDADE');
  ListaCampos1.add( QU.fieldbyname('Unid_cep').asstring);
  ListaCampos.add('CIDADE UF UNIDADE');
  ListaCampos1.add( trim(QU.fieldbyname('Unid_municipio').asstring)+' '+QU.fieldbyname('Unid_uf').asstring);
  FGeral.Fechaquery(QU);
///////////
  ListaCampos.add('NOME PRODUTOR');
  ListaCampos1.add( Arq.TClientes.fieldbyname('clie_nome').asstring );
  ListaCampos.add('ENDERECO PRODUTOR');
  ListaCampos1.add( Arq.TClientes.fieldbyname('clie_endres').asstring );
  ListaCampos.add('BAIRRO PRODUTOR');
  ListaCampos1.add( Arq.TClientes.fieldbyname('Clie_bairrores').asstring );
  ListaCampos.add('CEP PRODUTOR');
  ListaCampos1.add( FGeral.FormataCep( Arq.TClientes.fieldbyname('clie_CEPRes').asstring ) );
  ListaCampos.add('CIDADE PRODUTOR');
  ListaCampos1.add( FCidades.GetNome(Arq.TClientes.fieldbyname('Clie_cida_codigo_res').asinteger)  );
  ListaCampos.add('ESTADO PRODUTOR');
  ListaCampos1.add( Arq.TClientes.fieldbyname('Clie_uf').asstring  );
  ListaCampos.add('NASCIMENTO');
  ListaCampos1.add(  FGEral.formatadata( Arq.TClientes.fieldbyname('Clie_dtnasc').asdatetime ) );
  ListaCampos.add('NATURALIDADE');
  ListaCampos1.add(  Arq.TClientes.fieldbyname('Clie_naturalidade').asstring );
  ListaCampos.add('#NACIONALIDADE');
  ListaCampos1.add( 'BRASILEIRA'  );
  ListaCampos.add('#ESTADO CIVIL');
  if Arq.TClientes.fieldbyname('Clie_estadocivil').asstring='0' then
    ListaCampos1.add('Casado')
  else if Arq.TClientes.fieldbyname('Clie_estadocivil').asstring='1' then
    ListaCampos1.add('Solteiro')
  else if Arq.TClientes.fieldbyname('Clie_estadocivil').asstring='2' then
    ListaCampos1.add('Divorciado')
  else if Arq.TClientes.fieldbyname('Clie_estadocivil').asstring='3' then
    ListaCampos1.add('Vi�vo')
  else
    ListaCampos1.add('Outros');
  ListaCampos.add('#NOME CONJUGE');
  ListaCampos1.add( Arq.TClientes.fieldbyname('Clie_nomecje').asstring  );
  ListaCampos.add('#FONE');
  ListaCampos1.add(  FGEral.Formatatelefone( Arq.TClientes.fieldbyname('Clie_foneres').asstring ) );
  ListaCampos.add('#CELULAR');
  ListaCampos1.add(  FGEral.Formatatelefone( Arq.TClientes.fieldbyname('Clie_fonecel').asstring ) );
  ListaCampos.add('#EMAIL');
  ListaCampos1.add( Arq.TClientes.fieldbyname('Clie_nomecje').asstring  );
  ListaCampos.add('#PAI');
  ListaCampos1.add( Arq.TClientes.fieldbyname('Clie_pai').asstring  );
  ListaCampos.add('#MAE');
  ListaCampos1.add( Arq.TClientes.fieldbyname('Clie_mae').asstring  );
  ListaCampos.add('#CONTA');
  ListaCampos1.add( Arq.TClientes.fieldbyname('clie_contacorrente').asstring  );
  ListaCampos.add('#AGENCIA');
  ListaCampos1.add( Arq.TClientes.fieldbyname('clie_agencia').asstring  );
  ListaCampos.add('#CPF');
  ListaCampos1.add( FGeral.FormataCnpjcpf(Arq.TClientes.fieldbyname('Clie_cnpjcpf').asstring)  );




  While Linha < linhafim Do begin
    coluna:=1;
    While coluna < 30 Do begin
      pos:=ListaCampos.Indexof( trim( Excel.Cells.Item[linha,coluna].Value2) );
      if pos <>  -1 then
        TrocaCelula(pos,linha,coluna);
      inc(coluna);
    end;
    inc(linha);
  end;
  arqu:= ExtractFilePath( application.exename ) +  'FICHA_'+Arq.TClientes.fieldbyname('clie_nome').asstring;
//  Excel.saveas( arq );
  Excel.ActiveWorkBook.SaveAs( arqu );
  Excel.ActiveWorkBook.Close;
//  Excel.WorkBooks[1].SaveAs( arq );
  Excel.Visible := true;
  Excel.WorkBooks.Open(arqu);
end;

// 23.09.16
procedure TFCadcli.EdpesquisaExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////
var pesq:string;
begin

  if not EdPesquisa.IsEmpty then begin
//      Arq.TClientes.Close;
// 17.10.18
      Arq.TClientes.Condicao:='';
      Arq.TClientes.OPen;
      Arq.TClientes.Close;
      Arq.TClientes.Ordenacao:=EdPesquisa.TableField;

      if Global.topicos[1111] then

        Arq.TClientes.OpenWith( FGeral.GetIN('clie_unid_codigo',Global.codigounidade,'C')+
                               ' and '+EdPesquisa.TableField+' like '+Stringtosql('%'+EdPesquisa.text+'%')
                               ,Arq.Tclientes.Ordenacao)
// 23.06.2021 - Devereda
     else if Global.topicos[1117] then

       Arq.TClientes.OpenWith(FGeral.GetNOTIN('clie_situacao','I','C')+
                               ' and '+EdPesquisa.TableField+' like '+Stringtosql('%'+EdPesquisa.text+'%')
                              ,Arq.Tclientes.Ordenacao)

      else
        Arq.TClientes.OpenWith(EdPesquisa.TableField+' like '+Stringtosql('%'+EdPesquisa.text+'%')
                               ,Arq.Tclientes.Ordenacao)


  end;
  EdPesquisa.Visible:=false;
  EdPesquisa.Enabled:=false;
  Grid.SetFocus;

end;

// 23.09.16
procedure TFCadcli.bbuscarClick(Sender: TObject);
///////////////////////////////////////////////////
var Edix:TSqled;
begin
      Edix:=TSqled.Create(self);
      Edix:=Grid.GetEdt;
      EdPesquisa.Enabled:=true;
      EdPesquisa.Visible:=true;
      EdPesquisa.Left:=Edtleft;
//      EdPesquisa.top:=Edttop;
      EdPesquisa.top:=PMens.Top-20;
///////////      EdPesquisa.Clear; // senao nao mostra a primeira letra digitada...
      EdPesquisa.CharUpperLower:=Edix.CharUpperLower;
      EdPesquisa.CharCase:=Edix.CharCase;
      EdPesquisa.Width:=Edix.Width;
      EdPesquisa.Height:=Edix.Height;
      EdPesquisa.TableField:=Edix.TableField;
      EdPesquisa.Clear;
      EdPesquisa.setfocus;
end;

procedure TFCadcli.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
// 23.09.16
    if (gdSelected in State) and (gdFocused in State) then begin
     EdtTop :=Rect.Top;
     EdtLeft:=Rect.Left;
    end;

end;

procedure TFCadcli.GridKeyPress(Sender: TObject; var Key: Char);
begin
end;

// 23.09.16
procedure TFCadcli.EdpesquisaExit(Sender: TObject);
/////////////////////////////////////////////////////
begin
   EdPesquisa.Enabled:=false;
   EdPesquisa.Visible:=false;
end;

procedure TFCadcli.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Global.Topicos[1044]) then begin
      if ( Chr(Key) in ['0'..'9','a'..'z','A'..'Z'] ) and ( key<>VK_MENU ) then begin
         EdPesquisa.clear;
         EdPesquisa.SetPosCursor(1);
         bBuscarClick(self);

        Arq.TClientes.Close;
        Arq.TClientes.Condicao:='';
// 16.10.18
        Arq.TClientes.Ordenacao:=EdPesquisa.TableField;
        if Global.topicos[1111] then

          Arq.TClientes.OpenWith(FGeral.GetIN('clie_unid_codigo',Global.codigounidade,'C'),Arq.Tclientes.Ordenacao)

// 23.06.2021 - Devereda
        else if Global.topicos[1117] then

           Arq.TClientes.OpenWith(FGeral.GetNOTIN('clie_situacao','I','C'),Arq.Tclientes.Ordenacao)

        else

          Arq.TClientes.Open;

      end;

   end;



end;

end.
