// 08.02.2023 - Importação arquivo ofx - começando pelo Sicredi - Devereda
unit importaofx;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ACBrOFX, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, SQLEd, Geral, PLano, SqlFun, Sqlsis,
  SqlExpr;

type
  TFImportaOFX = class(TForm)
    lblCredito: TLabel;
    lblDebito: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Button1: TButton;
    cboTipos: TComboBox;
    Button2: TButton;
    DBGrid2: TDBGrid;
    Button3: TButton;
    Memo1: TMemo;
    btnPesquisar: TButton;
    cdsOfx: TClientDataSet;
    cdsOfxINDEX: TIntegerField;
    cdsOfxID: TStringField;
    cdsOfxDOCUMENT: TStringField;
    cdsOfxMOVDATE: TDateField;
    cdsOfxMOVTYPE: TStringField;
    cdsOfxVALUE: TFloatField;
    cdsOfxDESCRIPTION: TStringField;
    dsOFX: TDataSource;
    cdsTipos: TClientDataSet;
    cdsTiposTIPO: TStringField;
    cdsTiposMOVTYPE: TStringField;
    cdsTiposVALOR: TFloatField;
    dsTipos: TDataSource;
    ACBrOFX1: TACBrOFX;
    dlgOpen: TOpenDialog;
    EdBanco_descricao: TSQLEd;
    bimportar: TButton;
    Edbanco: TSQLEd;
    bsair: TButton;
    procedure btnPesquisarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure bimportarClick(Sender: TObject);
    procedure EdbancoValidate(Sender: TObject);
    procedure bsairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;

  end;

var
  FImportaOFX: TFImportaOFX;
  unidade:string;
  QBanco : TSqlquery;

implementation

{$R *.dfm}

procedure TFImportaOFX.bimportarClick(Sender: TObject);
///////////////////////////////////////////////////////////
var transacao,
    es,
    xtipocad,
    xcnpjcpf,
    transacaox:string;
    i ,
    index,
    xcodigo,
    mes,
    ano       :integer;
    valor     :currency;


    function BuscaCodigo(ycnpjcpf:string;ytipocad:string='F'):integer;
    //////////////////////////////////////////////
    var Qb:TSqlquery;
    begin

       result:=0;
       if ytipocad = 'F' then begin

          Qb := sqltoquery('select forn_codigo from fornecedores where forn_cnpjcpf = '+stringtosql(ycnpjcpf));
          if not Qb.eof then result := Qb.Fieldbyname('forn_codigo').asinteger;
          FGeral.Fechaquery(qb);

       end;

    end;

begin

     if Edbanco.IsEmpty then begin
        Avisoerro('Obrigatório informar codigo do banco');
        exit;
     end;
     if cdsofx.RecordCount=0 then begin
        Avisoerro('Sem registros a importar');
        exit;
     end;

  mes := Datetomes( TextToDate(ACBrOFX1.DateEnd) );
  ano := Datetoano( TextToDate(ACBrOFX1.DateEnd),true );
  transacaox := 'OFX'+Edbanco.Text+'-'+strzero(mes,2)+strzero(ano,4) ;

  for i := 0 to Pred(ACBrOFX1.Count) do
  begin
    Index := cboTipos.Items.IndexOf(ACBrOFX1.Get(i).Description);

    if Index < 0 then
    begin
      cboTipos.Items.Add(ACBrOFX1.Get(i).Description);
    end;

    if ACBrOFX1.Get(i).Value > 0 then
    begin
//      Creditos := Creditos + ACBrOFX1.Get(i).Value;
      es := 'E';
      valor := ACBrOFX1.Get(i).Value;
    END
    ELSE
    begin
//      Debitos := Debitos + ACBrOFX1.Get(i).Value;
      es := 'S';
      valor := ACBrOFX1.Get(i).Value * (-1)  ;
    end;

  //  cdsOfx.InsertRecord([i, ACBrOFX1.Get(i).ID, ACBrOFX1.Get(i).Document, ACBrOFX1.Get(i).MovDate, ACBrOFX1.Get(i).MovType, ACBrOFX1.Get(i).Value,
  //    ACBrOFX1.Get(i).Description]);
    xcodigo := 0;
    xtipocad := 'F';
    xcnpjcpf :=copy(ACBrOFX1.Get(i).id,11,14);
    if es = 'S' then begin  // por enquanto somente pagamentos

      xcnpjcpf := StrToStrDigitos(xcnpjcpf);
      if (length(trim(xcnpjcpf))=11) or (length(trim(xcnpjcpf))=14) then begin
          xcodigo:=Buscacodigo(xcnpjcpf,xtipocad);
      end;

    end;
    Sistema.beginprocess('Importando lançamentos '+FGeral.FormataData( ACBrOFX1.Get(i).movdate));
// necessario gerar uma transacao para cada pra exportar correto
    transacao := FGeral.GetTransacao('N') ;
    FGeral.GravaMovfin(Transacao,unidade,Es,copy(ACBrOFX1.Get(i).ID+' '+ACBrOFX1.Get(i).Description,1,100),
                            ACBrOFX1.Get(i).MovDate,ACBrOFX1.Get(i).MovDate,ACBrOFX1.Get(i).MovDate,
                            strtointdef(trim(copy(ACBrOFX1.Get(i).Document,1,10)),0),0,0,Edbanco.AsInteger,valor,
                            0,Global.CodLanCaixabancos,0,xcodigo,xtipocad,'N','1',transacaox  );
    Sistema.Commit;

  end;
  Sistema.endprocess('Importado '+Inttostr(cdsofx.RecordCount)+' lançamentos Transacao '+Transacao);

end;

procedure TFImportaOFX.bsairClick(Sender: TObject);
begin
   Close;
end;

procedure TFImportaOFX.btnPesquisarClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    Edit1.Text := dlgOpen.FileName;

end;

procedure TFImportaOFX.Button1Click(Sender: TObject);
var
  i: Integer;
  Index: Integer;
  Creditos, Debitos: Currency;
begin
  Creditos := 0;
  Debitos  := 0;

  if cdsOfx.Active then
  begin
    cdsOfx.EmptyDataSet;
    cdsTipos.EmptyDataSet;
  end
  else
  begin
    cdsOfx.CreateDataSet;
    cdsTipos.CreateDataSet;
  end;
  cboTipos.Items.Clear;

  ACBrOFX1.FileOFX := Edit1.Text;
  ACBrOFX1.Import;

  for i := 0 to Pred(ACBrOFX1.Count) do
  begin
    if not cdsTipos.Locate('TIPO', ACBrOFX1.Get(i).Description, [loCaseInsensitive, loPartialKey]) then
    begin
      cdsTipos.Append;
      cdsTipos.FieldByName('TIPO').AsString := ACBrOFX1.Get(i).Description;
      cdsTipos.FieldByName('MOVTYPE').AsString := ACBrOFX1.Get(i).MovType;
      cdsTipos.FieldByName('VALOR').AsFloat := 0;
      cdsTipos.Post;
    end;
  end;

  for i := 0 to Pred(ACBrOFX1.Count) do
  begin
    Index := cboTipos.Items.IndexOf(ACBrOFX1.Get(i).Description);

    if Index < 0 then
    begin
      cboTipos.Items.Add(ACBrOFX1.Get(i).Description);
    end;

    if ACBrOFX1.Get(i).Value > 0 then
    begin
      Creditos := Creditos + ACBrOFX1.Get(i).Value;
    END
    ELSE
    begin
      Debitos := Debitos + ACBrOFX1.Get(i).Value;
    end;

    if cdsTipos.Locate('TIPO', ACBrOFX1.Get(i).Description, [loCaseInsensitive, loPartialKey]) then
    begin
      cdsTipos.Edit;
      cdsTipos.FieldByName('VALOR').AsFloat := cdsTipos.FieldByName('VALOR').AsFloat + ACBrOFX1.Get(i).Value;
      cdsTipos.Post;
    end;

    cdsOfx.InsertRecord([i, ACBrOFX1.Get(i).ID, ACBrOFX1.Get(i).Document, ACBrOFX1.Get(i).MovDate, ACBrOFX1.Get(i).MovType, ACBrOFX1.Get(i).Value,
      ACBrOFX1.Get(i).Description]);
  end;

  lblCredito.Caption := FormatFloat('#,##0.00', Creditos);
  lblDebito.Caption := FormatFloat('#,##0.00', Debitos);
  Memo1.Lines.Clear;
  Memo1.Lines.Add('Banco: ' +ACBrOFX1.BankID+' - ' + ACBrOFX1.BankName + #13#10 + 'Agência: ' + ACBrOFX1.BranchID + ' - CC: ' + ACBrOFX1.AccountID + #13#10 + 'Data Inicial: ' +
    ACBrOFX1.DateStart + ' Data Final: ' + ACBrOFX1.DateEnd+' Registros: '+IntToStr(ACBrOFX1.Count));

end;

procedure TFImportaOFX.EdbancoValidate(Sender: TObject);
begin

 QBanco:=sqltoquery('select * from plano where plan_conta='+EdBanco.assql);
 if not QBanco.eof then begin

    EdBanco_descricao.text:=QBanco.fieldbyname('plan_descricao').asstring;
    if trim(QBanco.fieldbyname('Plan_codigobanco').asstring)='' then begin
      EdBAnco.invalid('Codigo do Banco não configurado nas contas gerenciais');
      exit;
    end;
 end;

end;

procedure TFImportaOFX.Execute;
////////////////////////////////////
begin
   FGeral.EstiloForm(FImportaofx);
   FGeral.ConfiguraColorEditsNaoEnabled(FImportaofx);
   FPlano.SetaItems(EdBanco,EdBanco_descricao,'B','','','S');
   Show;
   unidade := Global.CodigoUnidade;
   EdBanco.SetFocus;;
end;

end.
