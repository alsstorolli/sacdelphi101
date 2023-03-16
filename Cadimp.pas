unit Cadimp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, DB, Grids, DBGrids, SQLGrid, ExtCtrls,
  Buttons, SQLBtn, alabel,Printers;

type
  TFCadimp = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bAlterar: TSQLBtn;
    bExcluir: TSQLBtn;
    bCancelar: TSQLBtn;
    bFiltrar: TSQLBtn;
    bOrdenar: TSQLBtn;
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
    PEdits: TSQLPanelGrid;
    Grid: TSQLGrid;
    DSCadastros: TDataSource;
    EdImpr_codigo: TSQLEd;
    EdImpr_descricao: TSQLEd;
    EdImpr_formaimpressao: TSQLEd;
    EdImpr_tipo: TSQLEd;
    EdImpr_nomecontador: TSQLEd;
    EdImpr_geral: TSQLEd;
    BConfigurar: TSQLBtn;
    bImpressora: TSQLBtn;
    bAlteraContador: TSQLBtn;
    procedure FormActivate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdImpr_formaimpressaoExitEdit(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure BConfigurarClick(Sender: TObject);
    procedure bImpressoraClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bAlteraContadorClick(Sender: TObject);
    procedure EdImpr_codigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SetaTiposImpressos(Edit:TSqlEd);
  public
    function GetDescricao(Codigo:String):String;
    function GetTipo(Codigo:String):String;
    function GetFormaImpressao(Codigo:String):String;
    procedure SetaItems(Edit:TSqlEd;Tipos:String);
    function ValidaTipo(Edit:TSqlEd):Boolean;
    procedure Open;
    procedure Execute;
    { Public declarations }
  end;

var
  FCadimp: TFCadimp;

implementation

uses Arquiv,SqlFun,SqlExpr, Diversos,Geral,SqlSis, impressao , SQLRel;
//ImprDcto, Divers02, Uimpdcto

{$R *.dfm}

procedure TFCadimp.Execute;
begin
  FCadimp.show;
end;

procedure TFCadimp.FormActivate(Sender: TObject);
begin
  if not Arq.TImpressos.Active then Arq.TImpressos.Open;
  SetaTiposImpressos(EdImpr_tipo);
  FGeral.ColunasGrid(Grid,Self);
end;

procedure TFCadimp.bIncluirClick(Sender: TObject);
begin
  Grid.Insert(EdImpr_Codigo);
end;

procedure TFCadimp.EdImpr_formaimpressaoExitEdit(Sender: TObject);
begin
  Grid.PostInsert(EdImpr_Codigo);
end;

procedure TFCadimp.bRelatorioClick(Sender: TObject);
begin
//  Grid.Report('CadImpressos','Relação Dos Impressos Cadastrados','','');
  FRel.Reportfromsql('select * from impressos','CadImpressos','Relação Dos Impressos Cadastrados');
end;

function TFCadimp.GetDescricao(Codigo:String):String;
begin
  Result:='';
  if Trim(Codigo)<>'' then begin
    if not Arq.TImpressos.Active then Arq.TImpressos.Open;
    if Arq.TImpressos.Locate('Impr_Codigo',Codigo,[]) then Result:=Arq.TImpressos.FieldByName('Impr_Descricao').AsString;
  end;
end;

procedure TFCadimp.Open;
begin
  if not Arq.TImpressos.Active then Arq.TImpressos.Open;
end;

function TFCadimp.GetTipo(Codigo:String):String;
begin
  Result:='';
  if Trim(Codigo)<>'' then begin
    if not Arq.TImpressos.Active then Arq.TImpressos.Open;
    if Arq.TImpressos.Locate('Impr_Codigo',Codigo,[]) then Result:=Arq.TImpressos.FieldByName('Impr_Tipo').AsString;
  end;
end;

function TFCadimp.GetFormaImpressao(Codigo:String):String;
begin
  Result:='';
  if Trim(Codigo)<>'' then begin
    if not Arq.TImpressos.Active then Arq.TImpressos.Open;
    if Arq.TImpressos.Locate('Impr_Codigo',Codigo,[]) then Result:=Arq.TImpressos.FieldByName('Impr_FormaImpressao').AsString;
  end;
end;


procedure TFCadimp.SetaTiposImpressos(Edit:TSqlEd);
begin
  if Edit.Items.Count=0 then begin
//     Edit.Items.Add('BLO - Financeiro / Bloquete bancário');
     Edit.Items.Add('NFS - Faturamento / Nota Fiscal de Saida');
     Edit.Items.Add('NFT - Faturamento / Nota Fiscal de Transferência');
     Edit.Items.Add('RRE - Faturamento / Romaneio de Retorno');
     Edit.Items.Add('PEV - Faturamento / Pedido de Venda');
     Edit.Items.Add('ETB - Faturamento / Etiqueta para balança nas vendas');
     Edit.Items.Add('RRO - Faturamento / Romaneio de Remessa a Ordem');
     Edit.Items.Add('RPR - Financeiro  / Recibo de Pendência Financeira');
     Edit.Items.Add('CHQ - Financeiro  / Cheque emitido');
     Edit.Items.Add('ETQ - Cadastros   / Etiqueta para clientes');
     Edit.Items.Add('ETE - Cadastros   / Etiqueta para produtos');
     Edit.Items.Add('PEV - Faturamento / Pedido de Venda');
     Edit.Items.Add('BLO - Faturamento / Bloquete de Cobrança');
     Edit.Items.Add('SER - Faturamento / Nota Fiscal Prestação Serviços');
     Edit.Items.Add('RPE - Faturamento / Remessa de Pronta Entrega');
     Edit.Items.Add('RCO - Faturamento / Remessa do Consignado');
     Edit.Items.Add('CCX - Financeiro  / Comprovante de lançamento no caixa');
     Edit.Items.Add('ORO - Orçamentos  / Orçamento de Obra');
     Edit.Items.Add('PEC - Faturamento / Pedido de Compra');
  end;
end;


procedure TFCadimp.SetaItems(Edit:TSqlEd;Tipos:String);
begin
  Edit.Items.Clear;
  if not Arq.TImpressos.Active then Arq.TImpressos.Open;
  Arq.TImpressos.BeginProcess;
  Arq.TImpressos.First;
  while not Arq.TImpressos.Eof do begin
    if Pos(Arq.TImpressos.FieldByName('Impr_Tipo').AsString,Tipos)>0 then begin
       Edit.Items.Add(Arq.TImpressos.FieldByName('Impr_Codigo').AsString+' - '+Trim(Arq.TImpressos.FieldByName('Impr_Descricao').AsString));
    end;
    Arq.TImpressos.Next;
  end;
  Arq.TImpressos.EndProcess;
end;

function TFCadimp.ValidaTipo(Edit:TSqlEd):Boolean;
begin
  Result:=True;
  if (not Edit.isEmpty) and (Trim(Edit.TagStr)<>'') then begin
     if GetTipo(Edit.Text)<>Edit.TagStr then begin
        Edit.Invalid('Impresso de tipo inválido');
        Result:=False;
     end;
  end;
end;


procedure TFCadimp.bExcluirClick(Sender: TObject);
var Cod:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,Msg:String):Boolean;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM '+Tabela+' WHERE '+Campo+'='+Cod);
      Result:=Q.FieldByName('Registros').AsInteger>0;
      if Result then AvisoErro('Encontrados lançamentos com a cidade; escolhido na tabela: '+Msg);
      Q.Close;Q.Free;
    end;


begin
//  Cod:=StringToSql(Arq.TImpressos.FieldByName('Impr_Codigo').AsString);
//  Found:=FoundTabela('PlanoGer','Pger_Impr_Baixa','Plano Gerencial');
//  if not Found then Found:=FoundTabela('PlanoGer','Pger_Impr_Inclusao','Plano Gerencial');
//  if not Found then Found:=FoundTabela('PlanoGer','Pger_Impr_Cheque','Plano Gerencial');
//  if not Found then Found:=FoundTabela('Documentos','Dcto_Impr_Codigo','Cadastro De Documentos');
//  if not Found then Grid.Delete;
  Grid.Delete;
end;

procedure TFCadimp.BConfigurarClick(Sender: TObject);
var Codigo,Descricao,Tp:String;
begin
  Codigo:=Arq.TImpressos.FieldByName('Impr_Codigo').AsString;
  Descricao:=Arq.TImpressos.FieldByName('Impr_Descricao').AsString;
  Tp:=Arq.TImpressos.FieldByName('Impr_Tipo').AsString;
//  if Tp='CHQ' then FImpressao.ConfChequesEmitidos(Codigo,Descricao);
//  if Tp='GPS' then FImprDctoFolha.Conf_GPS(Codigo,Descricao);
  if Tp='NFS' then FImpressao.ConfNotaSaida(Codigo,Descricao);
  if Tp='NFT' then FImpressao.ConfNotaTransf(Codigo,Descricao);
  if Tp='RRE' then FImpressao.ConfNotaSaida(Codigo,Descricao);
  if Tp='RPR' then FImpressao.ConfReciboPen(Codigo,Descricao);
  if Tp='ETQ' then FImpressao.ConfEtqCliente(Codigo,Descricao);
  if Tp='PEV' then FImpressao.ConfPedidoVenda(Codigo,Descricao);
  if Tp='BLO' then FImpressao.ConfBloqueto(Codigo,Descricao);
  if Tp='SER' then FImpressao.ConfNotaSaidaMO(Codigo,Descricao);
// 20.05.10
  if Tp='ETE' then FImpressao.ConfEtqProduto(Codigo,Descricao);
// 24.05.10
  if Tp='RPE' then FImpressao.ConfNotaSaida(Codigo,Descricao);
// 07.06.10
  if Tp='RCO' then FImpressao.ConfNotaSaida(Codigo,Descricao);
// 12.08.10
  if Tp='CCX' then FImpressao.ConfReciboCaixa(Codigo,Descricao);
// 20.06.11
  if Tp='ETB' then FImpressao.ConfEtqbalanca(Codigo,Descricao);
// 30.06.11
  if Tp='RRO' then FImpressao.ConfNotaSaida(Codigo,Descricao);
// 20.08.13
  if Tp='ORO' then FImpressao.ConfOrcamentoObra(Codigo,Descricao);
// 25.01.15
  if tp='CHQ'  then FImpressao.ConfChequesEmitidos(Codigo,Descricao);
// 14.06.2022
  if Tp='PEC' then FImpressao.ConfPedidoCompra(Codigo,Descricao);

end;


procedure TFCadimp.bImpressoraClick(Sender: TObject);
var Lista:TStringList;
    i:Integer;
    NomeImpressora,Codigo:String;
    Device,Driver,Port: String; DevMode:THandle;
begin
  Codigo:=Arq.TImpressos.FieldByName('Impr_Codigo').AsString;
  Lista:=TStringList.Create;
  Lista.Add('Indica na impressão');
  for i:=0 to Printer.Printers.Count-1 do begin
      Printer.PrinterIndex:=i;
      SetLength(Device,255);
      SetLength(Driver,255);
      SetLength(Port,255);
      Printer.GetPrinter(PChar(Device),PChar(Driver),PChar(Port),DevMode);
      Lista.Add(StrPas(PChar(Device)));
  end;
  NomeImpressora:=GetIni(Sistema.NameSystem,'Impressoras','DCTO'+Codigo);
  NomeImpressora:=FDiversos.GetEscolha(Lista,'Seleção Da Impressora Para o Documento',NomeImpressora);
  if NomeImpressora<>'' then SetIni(Sistema.NameSystem,'Impressoras','DCTO'+Codigo,NomeImpressora);
  Lista.Free;
end;

procedure TFCadimp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FGeral.LiberaCadastro(Grid);
end;

procedure TFCadimp.bAlteraContadorClick(Sender: TObject);
var Codigo,Atual:String;
    Novo:Integer;
begin
  Codigo:=Arq.TImpressos.FieldByName('Impr_Codigo').AsString;
  Atual:=IntToStr(FGeral.ConsultaContadorImpresso(Codigo)+1);
  if Input('Alteração De Contador De Impresso','Informe o Próximo Número',Atual,8,True) then begin
     if Inteiro(Atual)>1 then begin
        Novo:=Inteiro(Atual)-1;
        FGeral.AlteraContadorImpresso(Codigo,Novo);
        Aviso('Alteração do contador do impresso efetivada');
     end;
  end;
end;

procedure TFCadimp.EdImpr_codigoKeyPress(Sender: TObject; var Key: Char);
begin
   FGeral.Limpaedit(EdImpr_codigo,key);
end;

end.
