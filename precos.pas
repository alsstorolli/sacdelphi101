unit precos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, DB, DBClient, SimpleDS, SqlSis;

type
  TFPrecos = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    balterar: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PIns: TSQLPanelGrid;
    EdPercvenda: TSQLEd;
    Grid: TSqlDtGrid;
    Edprecovenda: TSQLEd;
    Edpercdesconto: TSQLEd;
    EdProduto: TSQLEd;
    EdVendamin: TSQLEd;
    Edcodigoorigem: TSQLEd;
    SetEdesto_descricao: TSQLEd;
    bprecos: TSQLBtn;
    EdGrup_codigo: TSQLEd;
    SetEdDEPT_DESCRICAO: TSQLEd;
    EdPrecominimo: TSQLEd;
    bcancelar: TSQLBtn;
    bimpressao: TSQLBtn;
    procedure balterarClick(Sender: TObject);
    procedure EdpercdescontoExitEdit(Sender: TObject);
    procedure EdVendaminValidate(Sender: TObject);
    procedure EdpercdescontoValidate(Sender: TObject);
    procedure EdcodigoorigemValidate(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure bprecosClick(Sender: TObject);
    procedure EdPrecominimoExitEdit(Sender: TObject);
    procedure bcancelarClick(Sender: TObject);
    procedure bimpressaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure  Gridtoedits;
    procedure  EditstoGrid;

  end;

var
  FPrecos: TFPrecos;
  sqlgrupos,sqlgruposnao,sqlprodutosnao,sqlcompleta:string;

implementation

uses Arquiv, SQLRel, Sqlfun, SqlExpr, Geral;

{$R *.dfm}

procedure TFPrecos.Execute;
/////////////////////////////////
var Q:TSqlquery;
begin
   show;
   if FGeral.getconfig1asstring('GRUPOSPRECO')<>'' then
     sqlgrupos:=' and '+FGeral.GetIN('esto_grup_codigo',FGeral.getconfig1asstring('GRUPOSPRECO'),'N')
   else
     sqlgrupos:='';
// 14.01.16
   if FGeral.getconfig1asstring('GRUPOSNAOVEN')<>'' then
     sqlgruposNAO:=' and '+FGeral.GetNotIN('esto_grup_codigo',FGeral.getconfig1asstring('GRUPOSNAOVEN'),'N')
   else
     sqlgruposnao:='';
// 09.04.16
   if FGeral.getconfig1asstring('Produtosnaovenda')<>'' then
     sqlprodutosNAO:=' and '+FGeral.GetNotIN('esto_codigo',FGeral.getconfig1asstring('Produtosnaovenda'),'C')
   else
     sqlprodutosNAO:='';
   sistema.beginprocess('Buscando preços');
//   if not sdprecos.Active then begin
     Q:=sqltoquery('select * from estoqueqtde inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                                   ' left join grupos on ( grup_codigo=esto_grup_codigo )'+
                                   ' where esqt_unid_codigo='+stringtosql(Global.codigounidade)+
                                   sqlgrupos+sqlgruposnao+sqlprodutosnao+
                                   ' and esqt_status=''N'' order by esto_descricao');
//   end;
   grid.QueryToGrid( Q );
   sqlcompleta:='select esto_codigo,esto_descricao from estoqueqtde inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                                   ' left join grupos on ( grup_codigo=esto_grup_codigo )'+
                                   ' where esqt_unid_codigo='+stringtosql(Global.codigounidade)+
                                   sqlgrupos+sqlgruposnao+sqlprodutosnao+
                                   ' and esqt_status=''N'' order by esto_descricao';

   FGeral.FechaQuery(Q);
   sistema.endprocess('');
   Grid.setfocus;
end;

procedure TFPrecos.balterarClick(Sender: TObject);
var produto:string;
begin
  produto:=Grid.Cells[Grid.getcolumn('esto_codigo'),grid.row];
  if trim(produto)='' then exit;
  Pins.Visible:=true;
  Pins.EnableEdits;
  Grid.Enabled:=false;
  EdPercvenda.SetFirstEd;
  Gridtoedits;
end;

procedure TFPrecos.Gridtoedits;
begin
   EdPercvenda.SetValue(texttovalor(Grid.cells[Grid.getcolumn('esto_pervenda'),grid.row]));
   EdPercdesconto.SetValue(texttovalor(Grid.cells[Grid.getcolumn('esto_desconto'),grid.row]));
   EdPrecovenda.SetValue(texttovalor(Grid.cells[Grid.getcolumn('esqt_vendavis'),grid.row]));
   EdProduto.text:=Grid.cells[Grid.getcolumn('esto_codigo'),grid.row];
   EdVendamin.SetValue(texttovalor(Grid.cells[Grid.getcolumn('esqt_vendamin'),grid.row]));
   EdCodigoorigem.text:=Grid.cells[Grid.getcolumn('esto_codigovenda'),grid.row];
   EdGrup_codigo.text:=Grid.cells[Grid.getcolumn('esto_grup_codigo'),grid.row];
   SetEdDEPT_DESCRICAO.text:=Grid.cells[Grid.getcolumn('grup_descricao'),grid.row];
end;

procedure TFPrecos.EdpercdescontoExitEdit(Sender: TObject);
begin
   if confirma('Confirma alteração ?') then begin
     Sistema.BeginProcess('Gravando');
     Sistema.Edit('estoque');
     Sistema.SetField('esto_pervenda',Edpercvenda.ascurrency);
     Sistema.SetField('esto_desconto',Edpercdesconto.ascurrency);
     Sistema.SetField('esto_codigovenda',Edcodigoorigem.text);
     Sistema.SetField('esto_grup_codigo',EdGrup_codigo.asinteger);
     Sistema.Post('esto_codigo='+stringtosql(EdProduto.text));
     Sistema.Edit('estoqueqtde');
     Sistema.SetField('esqt_vendavis',EdPrecovenda.ascurrency);
     Sistema.SetField('esqt_vendamin',EdVendamin.ascurrency);
     Sistema.Post('esqt_esto_codigo='+stringtosql(EdProduto.text)+' and esqt_unid_codigo='+stringtosql(Global.codigounidade)+
                  ' and esqt_status=''N''');
     try
       sistema.commit;
       Editstogrid;
       Sistema.EndProcess('');
     except
       Sistema.EndProcess('Problemas na gravação');
     end;
   end;
   Pins.Visible:=false;
   Pins.DisablEedits;
   Grid.Enabled:=true;
   Grid.setfocus;
end;

procedure TFPrecos.EditstoGrid;
begin
  Grid.cells[Grid.getcolumn('esto_pervenda'),grid.row]:=floattostr(EdPercvenda.ascurrency);
  Grid.cells[Grid.getcolumn('esto_desconto'),grid.row]:=floattostr(EdPercdesconto.Ascurrency);
  Grid.cells[Grid.getcolumn('esqt_vendavis'),grid.row]:=floattostr( EdPrecovenda.Ascurrency);
  Grid.cells[Grid.getcolumn('esqt_vendamin'),grid.row]:=floattostr(EdVendamin.ascurrency);
  Grid.cells[Grid.getcolumn('esto_codigovenda'),grid.row]:=EdCodigoorigem.text;
  Grid.cells[Grid.getcolumn('esto_grup_codigo'),grid.row]:=EdGrup_codigo.text;
  Grid.cells[Grid.getcolumn('grup_descricao'),grid.row]:=SetEdDEPT_DESCRICAO.text;

end;

procedure TFPrecos.EdVendaminValidate(Sender: TObject);
begin
   if ( Edvendamin.ascurrency>0 ) and (EdVendamin.ascurrency>EdPrecovenda.ascurrency) then
     EdVendamin.Invalid('Preço mínimo tem que ser menor que o de venda');
end;

procedure TFPrecos.EdpercdescontoValidate(Sender: TObject);
begin
   if EdPercdesconto.ascurrency>0 then begin
     Edvendamin.setvalue( EdPrecovenda.ascurrency - (  EdPrecovenda.ascurrency*(EdPercdesconto.ascurrency/100) ) );
   end;
end;

procedure TFPrecos.EdcodigoorigemValidate(Sender: TObject);
begin
   if not Edcodigoorigem.isempty then begin
     if Edcodigoorigem.text=EdProduto.text then
       EdCodigoorigem.invalid('Codigo origem tem que ser diferente do produto escolhido');
   end;
end;

procedure TFPrecos.GridKeyPress(Sender: TObject; var Key: Char);
begin
// 14.02.09 - Novicarnes - Isonel
  if (key = #13) and (Grid.getcolumn('esqt_vendamin')=Grid.col) then begin
    EdPrecominimo.Left:=Grid.LeftEdit;
    EdPrecominimo.Top:=Grid.TopEdit;
    EdPrecominimo.enabled:=true;
    EdPrecominimo.visible:=true;
    EdProduto.text:=Grid.cells[Grid.getcolumn('esto_codigo'),grid.row];
    EdPrecominimo.setvalue( Texttovalor(Grid.cells[Grid.getcolumn('esqt_vendamin'),grid.row]) );
    EdPrecominimo.setfocus;
  end else if (key = #27) then begin
    EdPrecominimo.enabled:=false;
    EdPrecominimo.visible:=false;
    Grid.setfocus;
  end else if key = #13 then
    balterarclick(self);
end;

procedure TFPrecos.bprecosClick(Sender: TObject);
var Q,QEstoque:TSqlquery;
    produtoorigem:string;
    valorbase,novoven,novomin:currency;
    pr1:integer;
begin
  produtoorigem:=Grid.Cells[Grid.getcolumn('esto_codigo'),grid.row];
  if trim(produtoorigem)='' then exit;
  valorbase:=texttovalor( Grid.Cells[Grid.getcolumn('esqt_vendavis'),grid.row] );
  if not confirma('Confirma atualização dos derivados do produto '+produtoorigem+' pelo valor '+floattostr(valorbase)+' ?') then exit;
  if valorbase<=0 then exit;
  Sistema.beginprocess('Atualizando produtos');
  QEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(produtoorigem));
  Q:=sqltoquery('select * from estoqueqtde inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                ' where esqt_unid_codigo='+stringtosql(global.codigounidade)+' and esqt_status=''N'''+
                ' and esto_codigovenda='+stringtosql(produtoorigem) );
//                ' and esto_grup_codigo='+inttostr(QEstoque.fieldbyname('esto_grup_codigo').asinteger) );
// 27.06.07 - isonel - sem vinculo de grupos
  pr1:=0;
  while not Q.eof do begin
      if Q.fieldbyname('esto_pervenda').ascurrency>0 then
        novoven:=valorbase*(Q.fieldbyname('esto_pervenda').ascurrency/100)
      else
        novoven:=Q.fieldbyname('esqt_vendavis').ascurrency;
      novomin:=novoven - ( novoven * (Q.fieldbyname('esto_desconto').ascurrency/100) );
      Sistema.Edit('estoqueqtde');
      Sistema.Setfield('esqt_vendavis',novoven);
      if Q.fieldbyname('esto_desconto').ascurrency>0 then
        Sistema.Setfield('esqt_vendamin',novomin);
      Sistema.post('esqt_unid_codigo='+stringtosql(global.codigounidade)+' and esqt_esto_codigo='+stringtosql(Q.fieldbyname('esqt_esto_codigo').asstring)+
                   ' and esqt_status=''N''');
    inc(pr1);
    Q.Next;
  end;
  FGeral.FechaQuery(Q);
  FGeral.FechaQuery(QEstoque);
  try
    sistema.commit;
    Sistema.endprocess('Atualização feita em '+inttostr(pr1)+' subprodutos');
    sistema.beginprocess('Atualizando preços');
    Q:=sqltoquery('select * from estoqueqtde inner join estoque on ( esto_codigo=esqt_esto_codigo )'+
                                   ' left join grupos on ( grup_codigo=esto_grup_codigo )'+
                                   ' where esqt_unid_codigo='+stringtosql(Global.codigounidade)+
                                   sqlgrupos+sqlgruposnao+sqlprodutosnao+
                                   ' and esqt_status=''N'' order by esto_descricao');
     grid.QueryToGrid( Q );
     FGeral.FechaQuery(Q);
     sistema.endprocess('');
  except
    Sistema.endprocess('Problemas no banco.   Atualização não feita');
  end;
  Grid.SetFocus;

end;

procedure TFPrecos.EdPrecominimoExitEdit(Sender: TObject);
begin
    EdPrecominimo.enabled:=false;
    EdPrecominimo.visible:=false;
    Grid.cells[Grid.GetColumn('esqt_vendamin'),grid.row]:=EdPrecominimo.text;
    Sistema.Edit('estoqueqtde');
    Sistema.SetField('esqt_vendamin',EdPrecominimo.ascurrency);
    Sistema.Post('esqt_esto_codigo='+stringtosql(EdProduto.text)+' and esqt_unid_codigo='+stringtosql(Global.codigounidade)+
                  ' and esqt_status=''N''');
    Sistema.commit;
    Grid.setfocus;

end;

procedure TFPrecos.bcancelarClick(Sender: TObject);
begin
  Pins.Visible:=false;
  Pins.DisableEdits;
  Grid.Enabled:=true;
  EdPrecominimo.enabled:=false;
  EdPrecominimo.visible:=false;

end;

// 25.11.16
procedure TFPrecos.bimpressaoClick(Sender: TObject);
////////////////////////////////////////////////////////
begin
   FRel.ReportFromSQL(sqlcompleta,'Relação de Produtos/Cortes','','');
end;

end.
