// 10.02.2023
// por enquanto somente os campos para uma unidade
// por enquanto somente para uso da unidade 001 nos campos ref. unidade 1
unit tributacaoncm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, SqlDtg, Vcl.StdCtrls,
  Vcl.Mask, SQLEd, Vcl.Buttons, SQLBtn, alabel, Vcl.ExtCtrls, SQLGrid, SqlFun, Sqlsis, SqlExpr,
   Geral, SqlRel, RelEstoque;

type
  TFTributacaoncm = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    Edcipi_cstu1_est: TSQLEd;
    Label1: TLabel;
    Label2: TLabel;
    Edcipi_cstu1_fest: TSQLEd;
    EdnCM: TSQLEd;
    Edcipi_aliicmsu1_fest: TSQLEd;
    Edcipi_aliicmsu1_est: TSQLEd;
    Edcipi_cfopu1_fest: TSQLEd;
    Edcipi_cfopu1_est: TSQLEd;

    sbpesquisa: TSpeedButton;
    brel: TSQLBtn;
    procedure sbpesquisaClick(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdncmExitEdit(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure brelClick(Sender: TObject);
    procedure Edcipi_cfopu1_festExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
  end;

var
  FTributacaoncm: TFTributacaoncm;
  Q             : TSqlquery;

implementation

{$R *.dfm}

{ TFTributacaoncm }

procedure TFTributacaoncm.bCancelarClick(Sender: TObject);
begin

   Edcipi_aliicmsu1_est.clearall(Self,1);

end;

procedure TFTributacaoncm.bGravarClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

   if EdNcm.IsEmpty then exit;
   if Q.Eof then exit;

   Sistema.Edit('codigosipi');
   if Q.fieldbyname('cipi_unid1_codigo').IsNull then
      Sistema.SetField('cipi_unid1_codigo',EdUnid_codigo.Text);
   Sistema.SetField('cipi_aliicmsu1_est',Edcipi_aliicmsu1_est.ascurrency);
   Sistema.SetField('cipi_cstu1_est',Edcipi_cstu1_est.Text);
   Sistema.SetField('cipi_cfopu1_est',Edcipi_cfopu1_est.Text);
   Sistema.SetField('cipi_aliicmsu1_fest',Edcipi_aliicmsu1_fest.ascurrency);
   Sistema.SetField('cipi_cstu1_fest',Edcipi_cstu1_fest.Text);
   Sistema.SetField('cipi_cfopu1_fest',Edcipi_cfopu1_fest.Text);
   Sistema.Post('cipi_codfiscal = '+stringtosql(Edncm.Text));
   Sistema.Commit;
   Edcipi_aliicmsu1_est.clearall(Self,1);
   EdNcm.SetFocus;

end;

procedure TFTributacaoncm.brelClick(Sender: TObject);
//////////////////////////////////////////////////////////
var sql:string;
begin
    if not Sistema.Processando then FRelEstoque_Tributacaoncm;

end;

procedure TFTributacaoncm.Edcipi_cfopu1_festExitEdit(Sender: TObject);
begin
   bGravarClick(Self);
end;

procedure TFTributacaoncm.EdncmExitEdit(Sender: TObject);
begin
  sbpesquisaClick(self);
end;

procedure TFTributacaoncm.Execute;
/////////////////////////////////////
begin

     FGeral.ConfiguraColorEditsNaoEnabled(FTributacaoncm);
     EdUNid_codigo.Valid;
     Show;
     EdNcm.SetFocus;

end;

procedure TFTributacaoncm.sbpesquisaClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
   if EdNcm.IsEmpty then exit;

   Q := sqltoquery('select * from codigosipi where cipi_codfiscal = '+stringtosql(Edncm.text));
   if Q.eof then begin
      Aviso('Codigo ncm '+Edncm.text+' ainda n�o cadastrado');
      Edcipi_aliicmsu1_est.clearall(Self,1);
   end else begin

      if Q.fieldbyname('cipi_unid1_codigo').IsNull then begin

         Aviso('Codigo ncm '+Edncm.text+' sem configura��o nesta unidade. Informar pra depois gravar');
         Edcipi_aliicmsu1_est.clearall(Self,1);

      end else begin

         Edcipi_aliicmsu1_est.setvalue(  Q.fieldbyname('cipi_aliicmsu1_est').Ascurrency );
         Edcipi_cstu1_est.text     := Q.fieldbyname('cipi_cstu1_est').AsString;
         Edcipi_cfopu1_est.text    := Q.fieldbyname('cipi_cfopu1_est').AsString;
         Edcipi_aliicmsu1_fest.setvalue(  Q.fieldbyname('cipi_aliicmsu1_fest').Ascurrency );
         Edcipi_cstu1_fest.text     := Q.fieldbyname('cipi_cstu1_fest').AsString;
         Edcipi_cfopu1_fest.text    := Q.fieldbyname('cipi_cfopu1_fest').AsString;

      end;


   end;

end;

end.
