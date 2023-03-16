// Impressao de Ordem de Producao
// 18.04.18

unit impressaoop;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, SqlExpr, SqlSis, Data.FMTBcd,
  DbxDevartPostgreSQL, Data.DB, Arquiv, Datasnap.DBClient, SimpleDS, RLParser;

type
  TFImpressaoOP = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLLabel1: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    rldescricaoproduto: TRLLabel;
    RLnomeprocesso: TRLLabel;
    RLSystemInfo3: TRLSystemInfo;
    RLSystemInfo4: TRLSystemInfo;
    RLBand4: TRLBand;
    Ordem: TRLDBText;
    ds: TDataSource;
    nomeprocesso: TRLDBText;
    Nivel: TRLDBText;
    descricaoproduto: TRLDBText;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    rlProdutoAcabado: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    rlnomecliente: TRLDBText;
    rlpecas: TRLDBText;
    RLLabel7: TRLLabel;
    lbqtde: TRLLabel;
    rlqtde: TRLDBText;
    rldataop: TRLDBText;
    rlcodigoacabado: TRLLabel;
    rlreferencia: TRLLabel;
    RLLabel8: TRLLabel;
    BandTotais: TRLBand;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    totaltempo: TRLDBResult;
    RLExpressionParser1: TRLExpressionParser;
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure OrdemBeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure RLDBText2BeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure RLnomeclienteBeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure rlProdutoAcabadoBeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure rlpecasBeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure rlqtdeBeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure rldataopBeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure rlcodigoacabadoBeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure rlreferenciaBeforePrint(Sender: TObject; var AText: string;
      var PrintIt: Boolean);
    procedure totaltempoCompute(Sender: TObject; var Value: Variant;
      var AText: string; var ComputeIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute( xnumero:integer; xemissao:TDateTime ; xUnidade:string );

  end;

var
  FImpressaoOP: TFImpressaoOP;
  QPed,
  QCusto      : TSqlquery;
  Numero      : integer;
  Emissao     : TDateTime;
  Unidade,
  Produtoacabado     : string;
  Kilos       : currency;

implementation

uses SqlFun , Estoque, cadcli, cadservicos;


{$R *.dfm}

{ TFImpressaoOP }

procedure TFImpressaoOP.Execute(xnumero: integer; xemissao: TDateTime;  xUnidade: string);
/////////////////////////////////////////////////////////////////////////////////////////
begin


  Numero:=xnumero;
  Emissao:=xemissao;
  Unidade:=xUnidade;
  QPed:=sqltoquery('select * from movpeddet'+
        ' inner join movped on ( mped_transacao=mpdd_transacao and mped_tipomov=mpdd_tipomov )'+
        ' where mpdd_status = ''N'''+
        ' and mpdd_numerodoc = '+inttostr(NUmero)+
        ' and mped_dataemissao = '+Datetosql(emissao)+
        ' and mped_unid_codigo = '+Stringtosql(Unidade) );
  if QPed.Eof then begin
     Avisoerro('Nada encontrado para impress�o');
     exit;
  end;
  produtoacabado:=QPed.FieldByName('mpdd_esto_codigo').AsString;

  RlReport1.Preview();

end;

procedure TFImpressaoOP.OrdemBeforePrint(Sender: TObject; var AText: string;
  var PrintIt: Boolean);
begin
//    Ordem.DataField:='cust_ordem';
end;

procedure TFImpressaoOP.rlcodigoacabadoBeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
   aText:=produtoacabado;
end;

procedure TFImpressaoOP.rldataopBeforePrint(Sender: TObject; var AText: string;
  var PrintIt: Boolean);
begin
    aText:=FormatDatetime('dd/mm/yyyy',QPed.FieldByName('mped_datamvto').AsDateTime);
end;

procedure TFImpressaoOP.rlpecasBeforePrint(Sender: TObject; var AText: string;
  var PrintIt: Boolean);
begin
   aText:=QPed.FieldByName('mpdd_pecas').AsString;
end;

procedure TFImpressaoOP.rlProdutoAcabadoBeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
   aText:=FEstoque.GetDescricao( produtoacabado );
end;

procedure TFImpressaoOP.RLDBText2BeforePrint(Sender: TObject; var AText: string;
  var PrintIt: Boolean);
begin

    AText:=FormatFloat('####', Arq.Q.fieldbyname('cust_perqtde').AsCurrency*kilos*10);

end;

procedure TFImpressaoOP.rlqtdeBeforePrint(Sender: TObject; var AText: string;
  var PrintIt: Boolean);
begin
   aTExt:=QPed.FieldByName('mpdd_qtde').AsString;
   kilos:=QPed.FieldByName('mpdd_qtde').AsCurrency;
end;

procedure TFImpressaoOP.rlreferenciaBeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
   aText:=FEstoque.GetReferencia( QPed.FieldByName('mpdd_esto_codigo').AsString );
end;

procedure TFImpressaoOP.RLnomeclienteBeforePrint(Sender: TObject;
  var AText: string; var PrintIt: Boolean);
begin
   aText:=FCadCli.GetNome( QPed.FieldByName('mped_tipo_codigo').AsInteger );
end;

procedure TFImpressaoOP.RLReport1BeforePrint(Sender: TObject;  var PrintIt: Boolean);
//////////////////////////////////////////////////////////////////////////////////////////
var w,
    xorder,
    y        : string;

begin


//  w:=' left join estoque on ( esto_codigo=cust_esto_codigomat )'+
//     ' left join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N'')';
  w:=' left join cadmobra on ( cadm_codigo=cust_cadm_codigo )'+
     ' left join estoque on ( esto_codigo=cust_esto_codigomat )';
  xorder:=' order by cust_ordem,cust_cadm_codigo,cust_esto_codigomat';

  QCusto:=sqltoquery('select custos.cust_ordem,cadmobra.cadm_nivel,cadmobra.cadm_descricao,cadmobra.cadm_nivel,'+
                'estoque.esto_descricao,custos.cust_perqtde,custos.cust_qtde,'+
                'cadmobra.cadm_tempo,cadmobra.cadm_temperatura from custos'+
                 w+
                ' where cust_status='+StringtoSql('P')+
//                ' and esqt_unid_codigo='+stringtosql(Unidade)+
                ' and cust_esto_codigo='+Stringtosql(Produtoacabado)+
//                 sqlcor+sqltamanho+sqlcopa+
                 xorder
                 );
  y:='cust_status='+StringtoSql('P')+
     ' and cust_esto_codigo='+Stringtosql(Produtoacabado) ;

  if Arq.Q.Active  then Arq.Q.Close;
  Arq.Q.CommandText:=( QCusto.SQL.Text );
//  Arq.Q.Condicao:=y;
//  Arq.Q.TableName:='custos';
//  Arq.Q.OpenWith(y,'');
  Arq.Q.Open;
  if Arq.Q.eof then Avisoerro('N�o encontrado planilha de processos');
//  Ordem.DataField:='cust_ordem';
//  Rldbtext2.DataField:='esto_descricao';
//  NomeProcesso.DataField:='cadm_descricao';

end;

procedure TFImpressaoOP.totaltempoCompute(Sender: TObject; var Value: Variant;
  var AText: string; var ComputeIt: Boolean);
begin
   Value:=Arq.Q.FieldByName('cadm_tempo').AsInteger;
end;

end.

