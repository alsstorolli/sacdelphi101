unit Cadcheq2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SqlDtg, Buttons, SQLBtn, StdCtrls, alabel, ExtCtrls,
  SQLGrid, Mask, SQLEd, SqlExpr, DB, DBGrids ;

type
  TFCadcheques2 = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PGrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PEdits: TSQLPanelGrid;
    EdCheq_cheque: TSQLEd;
    EdCheq_emissao: TSQLEd;
    EdCheq_bcoemitente: TSQLEd;
    Edcheq_emitente: TSQLEd;
    Edcheq_predata: TSQLEd;
    Edcheq_valor: TSQLEd;
    Edcheq_obs: TSQLEd;
    Edcheq_prorroga: TSQLEd;
    Edcheq_repr_codigo: TSQLEd;
    Edcheq_deposito: TSQLEd;
    SetEdRepr_nome: TSQLEd;
    bAlterar: TSQLBtn;
    bExcluir: TSQLBtn;
    bcancelar: TSQLBtn;
    EdMovimento: TSQLEd;
    EdCheq_unid_codigo: TSQLEd;
    bbaixados: TSQLBtn;
    bemaberto: TSQLBtn;
    bbaixa: TSQLBtn;
    EdJuros: TSQLEd;
    procedure EdCheq_emissaoValidate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edcheq_depositoExitEdit(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure bAlterarClick(Sender: TObject);
    procedure bcancelarClick(Sender: TObject);
    procedure Edcheq_repr_codigoValidate(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure EdCheq_unid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure bbaixadosClick(Sender: TObject);
    procedure bemabertoClick(Sender: TObject);
    procedure bbaixaClick(Sender: TObject);
    procedure EdJurosValidate(Sender: TObject);
    procedure Edcheq_predataValidate(Sender: TObject);
    procedure EdCheq_bcoemitenteValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Editstogrid;
    procedure Querytoedits(Q:TSqlquery);
    procedure Execute;
    procedure Gridtoedits;

  end;

var
  FCadcheques2: TFCadcheques2;
  QBusca,QGrid,Qcheq:TSqlquery;
  Op,selectemaberto:string;

implementation

uses Arquiv, Sqlsis, SqlFun , Geral, Unidades, plano;

{$R *.dfm}

procedure TFCadcheques2.EdCheq_emissaoValidate(Sender: TObject);
begin
  if not FGeral.ValidaMvto(EdCheq_emissao) then
    EdCheq_emissao.invalid('');
{
  if not FGeral.ValidaMvto(EdCheq_emissao) then
    EdCheq_emissao.invalid('')
  else begin
    Qbusca:=sqltoquery('select * from cheques where cheq_status=''N'' and cheq_emissao='+EdCheq_emissao.AsSql+
                       ' and cheq_repr_codigo='+EdCheq_repr_codigo.AsSql+
                       ' and cheq_cheque='+EdCheq_cheque.AsSql );
    if (not QBusca.eof) and (Op='I') then
      EdCheq_emissao.invalid('Cheque já cadastrado para este representante nesta emissão')
    else begin
      if not QBusca.eof then begin
        Querytoedits(QBusca);
      end else begin
        if EdCheq_predata.AsDate<=1 then
          EdCheq_predata.setdate(edcheq_emissao.AsDate);
        EdMovimento.Setdate(sistema.hoje);
        if (QBusca.eof) and (Op<>'I') then
          EdCheq_emissao.invalid('Cheque não encontrado para este representante nesta emissão');
      end;
    end;
  end;
}
end;

procedure TFCadcheques2.FormActivate(Sender: TObject);
begin
  if not Arq.TRepresentantes.active then Arq.TRepresentantes.Open;
//  if EdCheq_emissao.AsDate<=1 then
    EdCheq_emissao.setdate(sistema.hoje);
/////  Grid.clear;

end;

procedure TFCadcheques2.Querytoedits(Q:TSqlquery);
begin
//////  EdCheq_bcoemitente.text:=Q.fieldbyname('cheq_bcoemitente').asstring;
//
  Edcheq_emitente.text:=Q.fieldbyname('cheq_emitente').asstring;
  Edcheq_predata.Setdate(Q.fieldbyname('cheq_predata').asdatetime);
  EdMovimento.Setdate(Q.fieldbyname('cheq_datacont').asdatetime);
  Edcheq_valor.setvalue(Q.fieldbyname('cheq_valor').ascurrency);
  Edcheq_obs.text:=Q.fieldbyname('cheq_obs').asstring;
  Edcheq_prorroga.setdate(Q.fieldbyname('cheq_prorroga').asdatetime);
  Edcheq_deposito.setdate(Q.fieldbyname('cheq_deposito').asdatetime);
  EdCheq_unid_codigo.text:=Q.fieldbyname('cheq_unid_codigo').asstring;
end;


procedure TFCadcheques2.Editstogrid;
begin
  Grid.Cells[grid.getcolumn('cheq_bcoemitente'),grid.row]:=edcheq_bcoemitente.text;
  Grid.Cells[grid.getcolumn('cheq_cheque'),grid.row]:=edcheq_cheque.text;
  Grid.Cells[grid.getcolumn('cheq_emitente'),grid.row]:=edcheq_emitente.text;
  Grid.Cells[grid.getcolumn('cheq_emissao'),grid.row]:=formatdatetime('dd/mm/yy',edcheq_emissao.asdate);
  if edcheq_predata.asdate>1 then
    Grid.Cells[grid.getcolumn('cheq_predata'),grid.row]:=formatdatetime('dd/mm/yy',edcheq_predata.asdate)
  else
    Grid.Cells[grid.getcolumn('cheq_predata'),grid.row]:='';
  if edcheq_deposito.asdate>1 then
    Grid.Cells[grid.getcolumn('cheq_deposito'),grid.row]:=formatdatetime('dd/mm/yy',edcheq_deposito.asdate)
  else
    Grid.Cells[grid.getcolumn('cheq_deposito'),grid.row]:='';
  if edcheq_prorroga.asdate>1 then
    Grid.Cells[grid.getcolumn('cheq_prorroga'),grid.row]:=formatdatetime('dd/mm/yy',edcheq_prorroga.asdate)
  else
    Grid.Cells[grid.getcolumn('cheq_prorroga'),grid.row]:='';
  Grid.Cells[grid.getcolumn('cheq_valor'),grid.row]:=edcheq_valor.assql;
  Grid.Cells[grid.getcolumn('cheq_obs'),grid.row]:=edcheq_obs.text;
end;


procedure TFCadcheques2.Edcheq_depositoExitEdit(Sender: TObject);
begin
  if confirma('Confirma informações ? ') then begin
    if OP='I' then
      Sistema.Insert('Cheques')
    else
      Sistema.Edit('Cheques');
    if OP='I' then begin
      Sistema.Setfield('cheq_status','N');
      Sistema.Setfield('cheq_emirec','R');
      Sistema.Setfield('cheq_cheque',Edcheq_cheque.Text);
      Sistema.Setfield('cheq_emissao',Edcheq_emissao.AsDate);
    end;
    Sistema.Setfield('cheq_bcoemitente',EdCheq_bcoemitente.Text);
    Sistema.Setfield('cheq_emitente',Edcheq_emitente.Text);
    Sistema.Setfield('cheq_predata',Edcheq_predata.AsDate);
    Sistema.Setfield('cheq_valor',Edcheq_valor.ascurrency);
    Sistema.Setfield('cheq_repr_codigo',EdCheq_repr_codigo.asinteger);
    Sistema.Setfield('cheq_deposito',Edcheq_deposito.asdate);
    Sistema.Setfield('cheq_prorroga',Edcheq_prorroga.asdate);
    Sistema.Setfield('cheq_datacont',EdMovimento.asdate);
    Sistema.Setfield('cheq_lancto',Sistema.hoje);
    Sistema.Setfield('cheq_obs',Edcheq_obs.text);
    Sistema.Setfield('cheq_unid_codigo',Edcheq_Unid_codigo.text);
    if OP='I' then
      Sistema.Post
    else begin
      Sistema.Post('cheq_status=''N'' and cheq_emissao='+EdCheq_emissao.AsSql+
                   ' and cheq_repr_codigo='+EdCheq_repr_codigo.AsSql+
                   ' and cheq_bcoemitente='+EdCheq_bcoemitente.AsSql+
                   ' and cheq_cheque='+EdCheq_cheque.AsSql );
      Editstogrid;
    end;
    Sistema.Commit;
//    EdCheq_prorroga.Clear;
//    EdCheq_deposito.clear;
//    EdCheq_valor.clear;
//    EdCheq_cheque.clear;
//    EdCheq_predata.clear;
//    EdCheq_emissao.clear;
    EdCheq_repr_codigo.ClearAll(FCadcheques2,99);
    EdCheq_emissao.setdate(sistema.hoje);
    EdCheq_repr_codigo.setfocus;
  end;
  Grid.enabled:=false;

end;

procedure TFCadcheques2.Execute;
begin
  Grid.clear;
  selectemaberto:='select * from cheques inner join representantes on ( repr_codigo=cheq_repr_codigo )'+
                   ' where cheq_status=''N'''+
                   ' and ( (cheq_deposito>'+Datetosql(texttodate('01052005'))+') or (cheq_deposito is null) )';
  QGrid:=sqltoquery( selectemaberto );
//                    ' and cheq_deposito is null');
// 10.08.05
  if not QGrid.eof then begin
    Grid.QueryToGrid(QGrid);
  end;

  Show;
end;

procedure TFCadcheques2.bIncluirClick(Sender: TObject);
begin
  Op:='I';
  PEdits.visible:=true;
  PEdits.Enabled:=true;
  balterar.enabled:=false;
  bexcluir.enabled:=false;
  bsair.enabled:=false;
  EdCheq_repr_codigo.setfocus;
end;

procedure TFCadcheques2.bAlterarClick(Sender: TObject);
begin
  Op:='A';
  PEdits.visible:=true;
  PEdits.Enabled:=true;
  bincluir.enabled:=false;
  bexcluir.enabled:=false;
  bsair.enabled:=false;
  Grid.enabled:=false;
  if trim(Grid.cells[0,1])<>'' then begin
    EdCheq_repr_codigo.text:=Grid.Cells[grid.getcolumn('cheq_repr_codigo'),Grid.row];
    EdCheq_cheque.text:=Grid.Cells[grid.getcolumn('cheq_cheque'),Grid.row];
    EdCheq_emissao.Setdate(Strtodate(Grid.Cells[grid.getcolumn('cheq_emissao'),Grid.row]));
    EdCheq_bcoemitente.text:=Grid.Cells[grid.getcolumn('cheq_bcoemitente'),Grid.row];
  end;
  EdCheq_repr_codigo.setfocus;

end;

procedure TFCadcheques2.bcancelarClick(Sender: TObject);
begin
  PEdits.enabled:=false;
  PEdits.visible:=false;
  EdCheq_repr_codigo.ClearAll(FCadcheques2,99);
  bincluir.enabled:=true;
  balterar.enabled:=true;
  bexcluir.enabled:=true;
  bsair.enabled:=true;
  Grid.enabled:=true;
  Grid.SetFocus;

end;

procedure TFCadcheques2.Edcheq_repr_codigoValidate(Sender: TObject);
//var data:TDatetime;
begin
{
  Grid.clear;
  data:=DatetoDateMesant(Sistema.hoje,1);
  QGrid:=sqltoquery('select * from cheques left join representantes on ( repr_codigo=cheq_repr_codigo )'+
                    ' where cheq_status=''N'' and cheq_repr_codigo='+EdCheq_repr_codigo.AsSql+
                    ' and cheq_emissao>='+datetosql(data) );
  if not QGrid.eof then begin
    Grid.QueryToGrid(QGrid);
  end;
 }
end;

procedure TFCadcheques2.bExcluirClick(Sender: TObject);
begin
   if trim(Grid.Cells[grid.getcolumn('cheq_cheque'),grid.row])<>'' then begin
     if confirma('Confirma exclusão ?') then begin
       EdCheq_repr_codigo.text:=Grid.Cells[grid.getcolumn('cheq_repr_codigo'),Grid.row];
       EdCheq_cheque.text:=Grid.Cells[grid.getcolumn('cheq_cheque'),Grid.row];
       EdCheq_emissao.Setdate(Strtodate(Grid.Cells[grid.getcolumn('cheq_emissao'),Grid.row]));
       EdCheq_bcoemitente.text:=Grid.Cells[grid.getcolumn('cheq_bcoemitente'),Grid.row];
       ExecuteSql('Update cheques set cheq_status=''C'' where cheq_status=''N'''+
                  ' and cheq_repr_codigo='+EdCheq_repr_codigo.AsSql+
                  ' and cheq_cheque='+EdCheq_cheque.AsSql+
                  ' and cheq_bcoemitente='+EdCheq_bcoemitente.AsSql+
                  ' and cheq_emissao='+EdCheq_Emissao.AsSql );
       Grid.DeleteRow(Grid.row);
     end;
   end;
end;

procedure TFCadcheques2.EdCheq_unid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.LimpaEdit(EdCheq_unid_codigo,key);
end;

procedure TFCadcheques2.bbaixadosClick(Sender: TObject);
begin
  Grid.clear;
  if QGrid<>nil then begin
    QGrid.close;
    Freeandnil(QGrid);
  end;
  Sistema.setmessage('Pesquisando cheques baixados');
  QGrid:=sqltoquery('select * from cheques left join representantes on ( repr_codigo=cheq_repr_codigo )'+
                    ' where cheq_status=''N'''+
                    ' and cheq_deposito is not null');
  if not QGrid.eof then begin
    Grid.QueryToGrid(QGrid);
  end;
  Sistema.setmessage('');

end;

procedure TFCadcheques2.bemabertoClick(Sender: TObject);
begin
  Grid.clear;
  if QGrid<>nil then begin
    QGrid.close;
    Freeandnil(QGrid);
  end;
//  QGrid:=sqltoquery('select * from cheques left join representantes on ( repr_codigo=cheq_repr_codigo )'+
//                    ' where cheq_status=''N'''+
//                    ' and cheq_deposito is null');
  QGrid:=sqltoquery( selectemaberto );
  if not QGrid.eof then begin
    Grid.QueryToGrid(QGrid);
  end;

end;

procedure TFCadcheques2.bbaixaClick(Sender: TObject);
begin
  if trim(Grid.Cells[grid.getcolumn('cheq_deposito'),Grid.row])='' then begin
    EdCheq_repr_codigo.text:=Grid.Cells[grid.getcolumn('cheq_repr_codigo'),Grid.row];
    EdCheq_cheque.text:=Grid.Cells[grid.getcolumn('cheq_cheque'),Grid.row];
    EdCheq_emissao.Setdate(Strtodate(Grid.Cells[grid.getcolumn('cheq_emissao'),Grid.row]));
    EdCheq_unid_codigo.text:=Grid.Cells[grid.getcolumn('cheq_unid_codigo'),Grid.row];
    EdCheq_bcoemitente.text:=Grid.Cells[grid.getcolumn('cheq_bcoemitente'),Grid.row];
//    QCheq:=sqltoquery('Select * from cheques where cheq_status=''N'''+
//                  ' and cheq_repr_codigo='+EdCheq_repr_codigo.AsSql+
//                  ' and cheq_cheque='+EdCheq_cheque.AsSql+
//                  ' and cheq_unid_codigo='+EdCheq_unid_codigo.assql+
//                  ' and cheq_emissao='+EdCheq_Emissao.AsSql );
      EdJuros.enabled:=true;
      EdJuros.visible:=true;
      EdJuros.setfocus;
  end else begin
      EdCheq_deposito.Setdate(Strtodate(Grid.Cells[grid.getcolumn('cheq_deposito'),Grid.row]));
      Avisoerro('Cheque já baixado em '+formatdatetime('dd/mm/yy',Edcheq_deposito.asdate));
  end;
end;

procedure TFCadcheques2.EdJurosValidate(Sender: TObject);
var Transacao,sqlrepr,sqlemirec:string;
    ContaCaixa,ContaJuros:integer;
begin
  if confirma('Confirma ?') then begin
//    Contacaixa:=FUnidades.getcontacaixa(EdCheq_unid_codigo.text);
    Contacaixa:=FUnidades.getcontacaixa(Global.unidadematriz);
//    ContaJuros:=FPlano.GetContaJuros(contacaixa);
// 17.08.05
    ContaJuros:=Global.ContaJurosRecebidos;
    Sistema.begintransaction('Gravando');
    Transacao:=FGeral.Gettransacao;

    if EdJuros.ascurrency>0 then begin
       FGeral.GravaMovfin(Transacao,Edcheq_unid_codigo.text,'E','Cheque '+EdCheq_cheque.text+' Juros Recebidos',sistema.hoje,Edmovimento.Asdate,
                     Sistema.hoje,EdCheq_cheque.asinteger,0,EdCheq_cheque.asinteger,ContaCaixa,EdJuros.AsCurrency,contajuros,Global.CodJurosRecebidos)
    end;
    sqlrepr:=' and cheq_repr_codigo='+Edcheq_repr_codigo.AsSql;
    sqlemirec:=' and cheq_emirec=''R''';   // por enquanto somente os recebidos

    Sistema.Edit('Cheques');
    Sistema.SetField('cheq_deposito',Sistema.hoje);
    Sistema.Post('cheq_status=''N'' and cheq_deposito is null '+
                 sqlrepr+
                 sqlemirec+
                 ' and cheq_cheque='+Edcheq_cheque.assql+
                 ' and cheq_emissao='+EdCheq_emissao.assql+
                 ' and cheq_bcoemitente='+EdCheq_bcoemitente.assql+
                 ' and cheq_unid_codigo='+EdCheq_Unid_codigo.AsSql );

    Grid.cells[Grid.getcolumn('cheq_deposito'),grid.row]:=formatdatetime('dd/mm/yy',sistema.hoje);
    Sistema.endtransaction('Lançamento Ok');

////////////    bemabertoclick(FCadcheques);
// 17.08.05
  end;
  EdJuros.enabled:=false;
  EdJuros.visible:=false;
end;

procedure TFCadcheques2.Gridtoedits;
begin
end;

procedure TFCadcheques2.Edcheq_predataValidate(Sender: TObject);
begin
   if Edcheq_predata.asdate<EdCheq_emissao.asdate then
     Edcheq_predata.invalid('Bom para tem que ser maior que a emissão');
end;

procedure TFCadcheques2.EdCheq_bcoemitenteValidate(Sender: TObject);
var QBusca:TSqlquery;
begin
    Qbusca:=sqltoquery('select * from cheques where cheq_status=''N'' and cheq_emissao='+EdCheq_emissao.AsSql+
                       ' and cheq_repr_codigo='+EdCheq_repr_codigo.AsSql+
                       ' and cheq_bcoemitente='+EdCheq_bcoemitente.AsSql+
                       ' and cheq_cheque='+EdCheq_cheque.AsSql );
    if (not QBusca.eof) and (Op='I') then
      EdCheq_bcoemitente.invalid('Cheque já cadastrado para este representante nesta emissão')
    else begin
      if not QBusca.eof then begin
        Querytoedits(QBusca);
      end else begin
        if EdCheq_predata.AsDate<=1 then
          EdCheq_predata.setdate(edcheq_emissao.AsDate);
        EdMovimento.Setdate(sistema.hoje);
        if (QBusca.eof) and (Op<>'I') then
          EdCheq_bcoemitente.invalid('Cheque não encontrado para este representante nesta emissão');
      end;
    end;

end;

end.
