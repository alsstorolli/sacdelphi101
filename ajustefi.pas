unit ajustefi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, SQLGrid, ExtCtrls;

type
  TFAjustefiliais = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    bExecutar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edmesano: TSQLEd;
    Edunid_codigoorigem: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdUnid_codigodestino: TSQLEd;
    SQLEd2: TSQLEd;
    procedure bExecutarClick(Sender: TObject);
    procedure EdUnid_codigodestinoValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAjustefiliais: TFAjustefiliais;

implementation

uses SqlSis, Sqlexpr, Sqlfun;

{$R *.dfm}

procedure TFAjustefiliais.bExecutarClick(Sender: TObject);
var QOrigem,QDestino,Q:TSqlquery;
begin
  if not EdMesano.ValidEdiAll(FAjustefiliais,99) then exit;
  if not confirma('Confirma o ajuste ? ( É irreversível )') then exit;

  QOrigem:=sqltoquery('select esqt_esto_codigo,esqt_qtde,esqt_qtdeprev from estoqueqtde where esqt_unid_codigo='+EdUnid_codigoorigem.assql+' and esqt_status=''N''');
  if qorigem.eof then begin
    Avisoerro('Nenhum produto da unidade de origem foi encontrado na tabela estoqueqtde');
    exit;
  end;
  QDestino:=sqltoquery('select esqt_esto_codigo,esqt_qtde,esqt_qtdeprev from estoqueqtde where esqt_unid_codigo='+EdUnid_codigodestino.assql+' and esqt_status=''N''');
  if qdestino.eof then begin
    Avisoerro('Nenhum produto da unidade de destino foi encontrado na tabela estoqueqtde');
    exit;
  end;
// gerar movimento justificando o novo saldo em estoque
  Sistema.BeginTransaction;
  while not QOrigem.eof do begin
    if QOrigem.fieldbyname('esqt_qtde').ascurrency>0 then begin
      Sistema.Edit('estoqueqtde');
      Sistema.setfield('esqt_qtde',QOrigem.fieldbyname('esqt_qtde').ascurrency)
    end else begin
    end;
    QOrigem.next;
  end;
// gerar movimento justificando o zeramento do estoque da unidade origem
  Sistema.Endtransaction;
end;

procedure TFAjustefiliais.EdUnid_codigodestinoValidate(Sender: TObject);
begin
    if Edunid_codigoorigem.text=EdUnid_codigodestino.text then
      EdUnid_codigodestino.invalid('Unidade destino deve ser diferente da origem');

end;

end.
