unit planospendentes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr;

type
  TFPlanosPendentes = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bimpressao: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    Edencerramento: TSQLEd;
    PIns: TSQLPanelGrid;
    Edpaca_oque: TSQLEd;
    Edpaca_como: TSQLEd;
    Edpaca_quem: TSQLEd;
    Edpaca_quando: TSQLEd;
    Edpaca_porque: TSQLEd;
    Edpaca_valor: TSQLEd;
    procedure EdencerramentoExitEdit(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure GridDblClick(Sender: TObject);
    procedure bimpressaoClick(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GridNewLine(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure GridtoEdit;
    procedure ChecaPlanosPendentes;
  end;

var
  FPlanosPendentes: TFPlanosPendentes;
  Q:TSqlquery;
  Sqlusuario,TipoPlano,Planoacao:string;

implementation

uses SqlSis, Geral, SqlFun , nfcompra, Usuarios, setores, relnaoconfor;

{$R *.dfm}

{ TFPlanosPendentes }

procedure TFPlanosPendentes.Execute;

    procedure QuerytoGrid(Q:Tsqlquery);
    var i,diasatraso:integer;
    begin
      Grid.clear;i:=1;
//      Grid.Columns.Items[Grid.GetColumn('paca_quem')].Font.Style:=[fsBold];
//      Grid.Columns.Items[Grid.GetColumn('paca_quando')].Font.Style:=[fsBold];
//      Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Style:=[fsBold];
      while not Q.Eof do begin
         Grid.Cells[Grid.getcolumn('paca_usua_resp'),i]:=FUsuarios.GetNome( Q.fieldbyname('paca_usua_resp').AsINteger );
         Grid.Cells[Grid.getcolumn('paca_seto_codigo'),i]:=FSetores.GetDescricao( Q.fieldbyname('paca_seto_codigo').AsString );
         Grid.Cells[Grid.getcolumn('paca_oque'),i]:=Q.fieldbyname('paca_oque').AsString;
         Grid.Cells[Grid.getcolumn('paca_como'),i]:=Q.fieldbyname('paca_como').AsString;

//         if (Grid.GetColumn('paca_quem')=Grid.col) or (Grid.GetColumn('paca_quando')=Grid.col)
//            then begin
            diasatraso:=trunc( Sistema.hoje - Q.fieldbyname('paca_quando').asdatetime );
            if diasatraso>0 then begin
// 02.04.09
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clRed;
              Grid.Cells[Grid.getcolumn('situacao'),i]:='ATRASADO';
//               Grid.Columns.Items[Grid.GetColumn('paca_quem')].Font.Color:=clRed;
//               Grid.Columns.Items[Grid.GetColumn('paca_quando')].Font.Color:=clRed;
//               Grid.Canvas.Font.Color:=clRed;
            end else if (diasatraso>=-7) and (diasatraso<=0) then begin
              Grid.Cells[Grid.getcolumn('situacao'),i]:='NA SEMANA';
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clBlue;
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clYellow;
//               Grid.Canvas.Font.Color:=clBlue;
//               Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Style:=[];
            end else begin
              Grid.Cells[Grid.getcolumn('situacao'),i]:='EM EXECUÇÃO';
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clGreen;
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clYellow;
//              Grid.Canvas.Font.Color:=clYellow;
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Style:=[fsItalic];
            end;
//         end;

         Grid.Cells[Grid.getcolumn('paca_quem'),i]:=Q.fieldbyname('paca_quem').AsString;
         Grid.Cells[Grid.getcolumn('paca_quando'),i]:=FGeral.formatadata(Q.fieldbyname('paca_quando').asdatetime);
         Grid.Cells[Grid.getcolumn('paca_porque'),i]:=Q.fieldbyname('paca_porque').AsString;
         Grid.Cells[Grid.getcolumn('paca_valor'),i]:=floattostr(Q.fieldbyname('paca_valor').AsCurrency);
         if Q.fieldbyname('paca_dtencerra').AsDatetime>1 then
           Grid.Cells[Grid.getcolumn('paca_dtencerra'),i]:=FGeral.formatadata(Q.fieldbyname('paca_dtencerra').asdatetime)
         else
           Grid.Cells[Grid.getcolumn('paca_dtencerra'),i]:='';
         Grid.Cells[Grid.getcolumn('paca_seq'),i]:=Q.fieldbyname('paca_seq').AsString;
         Grid.Cells[Grid.getcolumn('paca_tipoplano'),i]:=Q.fieldbyname('paca_tipoplano').AsString;
         Grid.Cells[Grid.getcolumn('paca_numeroata'),i]:=Q.fieldbyname('paca_numeroata').AsString;
//{

//}
         Grid.AppendRow;
         inc(i);
         Q.Next;
      end;
    end;

    procedure QuerytoGridColuna(Q:Tsqlquery);
    var i,diasatraso:integer;
    begin
      i:=1;
//      Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Style:=[fsBold];
      while not Q.Eof do begin
            diasatraso:=trunc( Sistema.hoje - Q.fieldbyname('paca_quando').asdatetime );
            if diasatraso>0 then begin
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clRed;
              Grid.Cells[Grid.getcolumn('situacao'),i]:='ATRASADO';
//               Grid.Columns.Items[Grid.GetColumn('paca_quem')].Font.Color:=clRed;
//               Grid.Columns.Items[Grid.GetColumn('paca_quando')].Font.Color:=clRed;
//               Grid.Canvas.Font.Color:=clRed;
            end else if (diasatraso>=-7) and (diasatraso<=0) then begin
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clYellow;
              Grid.Cells[Grid.getcolumn('situacao'),i]:='NA SEMANA';
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clBlue;
//               Grid.Canvas.Font.Color:=clBlue;
//               Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Style:=[];
            end else begin
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clGreen;
              Grid.Cells[Grid.getcolumn('situacao'),i]:='EM EXECUÇÃO';
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clYellow;
//              Grid.Canvas.Font.Color:=clYellow;
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Style:=[fsItalic];
            end;
//         end;

//{

//}
         inc(i);
         Q.Next;
      end;
    end;


begin
// 02.10.08
  FGeral.EstiloForm(self);
  Show;
  Sistema.beginprocess('Pesquisando planos de ação');
//  sqlusuario:=' and paca_usua_resp='+inttostr(Global.Usuario.Codigo);
  sqlusuario:=' and paca_usua_quem='+inttostr(Global.Usuario.Codigo)+' and paca_usua_quem>0';
  if Global.Usuario.OutrosAcessos[0401] then
    sqlusuario:='';
  Q:=sqltoquery('select * from planoacao where paca_status=''N'''+
                ' and paca_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                ' and paca_situacao=''P'''+
                sqlusuario+
                ' order by paca_quando');
  if not Q.eof then begin
    QuerytoGrid(Q);
//    Q.first;
//    QuerytoGridColuna(Q);
  end;
  Sistema.endprocess('');

  Grid.Refresh;

end;

procedure TFPlanosPendentes.GridtoEdit;
begin

end;

procedure TFPlanosPendentes.EdencerramentoExitEdit(Sender: TObject);
begin
  if EdEncerramento.IsEmpty then begin
    EdEncerramento.Enabled:=false;
    EdEncerramento.Visible:=false;
    Grid.setfocus;
    exit;
  end;
  if Confirma('Confirma baixa ?') then begin
    Grid.cells[grid.getcolumn('paca_dtencerra'),grid.row]:=FGeral.formatadata(EdEncerramento.asdate);
    tipoplano:=Grid.cells[grid.getcolumn('paca_tipoplano'),grid.row];
    Planoacao:=Grid.cells[grid.getcolumn('paca_numeroata'),grid.row];
    Sistema.Edit('planoacao');
    Sistema.SetField('paca_dtencerra',EdEncerramento.asdate);
    if EdEncerramento.AsDate>0 then
      Sistema.SetField('paca_situacao','E')
    else
      Sistema.SetField('paca_situacao','P');
// 17.11.08 - usuario q encerrou a tarefa
    Sistema.SetField('paca_usua_ence',Global.Usuario.Codigo);
    Sistema.post('paca_numeroata='+stringtosql(Planoacao)+' and paca_tipoplano='+stringtosql(tipoplano)+' and paca_status=''N'''+
                 ' and paca_seq='+stringtosql(Grid.cells[Grid.getcolumn('paca_seq'),Grid.row]) );
    try
      Sistema.commit;
      Grid.DeleteRow(grid.Row);
    except
      Avisoerro('Não foi possível baixar esta tarefa');
    end;
  end;
  EdEncerramento.Enabled:=false;
  EdEncerramento.Visible:=false;
  Grid.setfocus;
end;

procedure TFPlanosPendentes.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
     Grid.OnDblClick(self);


end;

procedure TFPlanosPendentes.GridDblClick(Sender: TObject);
var aseq:integer;
begin
   if Grid.col=grid.getcolumn('paca_dtencerra') then begin
     aseq:=strtointdef(Grid.cells[Grid.getcolumn('paca_seq'),Grid.row],0);
     if aseq=0 then exit;
     EdEncerramento.Top:=Grid.TopEdit;
     EdEncerramento.Left:=Grid.LeftEdit;
     EdEncerramento.Enabled:=true;
     EdEncerramento.Visible:=true;
     EdEncerramento.setdate( Texttodate(FGeral.TiraBarra(Grid.cells[grid.getcolumn('paca_dtencerra'),grid.row])) );
     EdEncerramento.setfocus;
   end;

end;

procedure TFPlanosPendentes.bimpressaoClick(Sender: TObject);
begin
  FRelNaoConforme_PlanosdeAcao('A;R');

end;

procedure TFPlanosPendentes.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var DiasAtraso:integer;
    Quando:TDatetime;
var s:string;
    t:integer;

begin

  if (Q<>nil) and (not (gdSelected in State)) and (ARow>0) and
     ( (Acol=Grid.Getcolumn('paca_quando')) or (Acol=Grid.Getcolumn('situacao')) )
     and ( trim(Grid.Cells[Grid.GetColumn('paca_quem'),aRow])<>'' ) then begin

        Quando:=TexttoDate( FGeral.TiraBarra(Grid.Cells[Grid.GetColumn('paca_quando'),aRow]) );
        if quando>1 then
          diasatraso:=trunc( Sistema.hoje - quando )
        else
          diasatraso:=0;
        if diasatraso>0 then begin
           Grid.Canvas.Brush.Color := clred;
           s:=Grid.Cells[ACol,ARow];
           Grid.Canvas.FillRect(Rect);
           t:=Grid.Canvas.TextWidth(s)+2;
           if Grid.Columns[ACol].Alignment=taRightJustify then
              Grid.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else Grid.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
        end else if (diasatraso>=-7) and (diasatraso<=0) then begin
           Grid.Canvas.Brush.Color := clYellow;
           s:=Grid.Cells[ACol,ARow];
           Grid.Canvas.FillRect(Rect);
           t:=Grid.Canvas.TextWidth(s)+2;
           if Grid.Columns[ACol].Alignment=taRightJustify then
              Grid.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else Grid.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
        end else begin
           Grid.Canvas.Brush.Color := clBlue;
           s:=Grid.Cells[ACol,ARow];
           Grid.Canvas.FillRect(Rect);
           t:=Grid.Canvas.TextWidth(s)+2;
           if Grid.Columns[ACol].Alignment=taRightJustify then
              Grid.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else Grid.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);

        end;

  end;
//}

end;


procedure TFPlanosPendentes.ChecaPlanosPendentes;

    procedure QuerytoGrid(Q:Tsqlquery);
    var i,diasatraso:integer;
    begin
      Grid.clear;i:=1;
//      Grid.Columns.Items[Grid.GetColumn('paca_quem')].Font.Style:=[fsBold];
//      Grid.Columns.Items[Grid.GetColumn('paca_quando')].Font.Style:=[fsBold];
//      Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Style:=[fsBold];
      while not Q.Eof do begin
         Grid.Cells[Grid.getcolumn('paca_usua_resp'),i]:=FUsuarios.GetNome( Q.fieldbyname('paca_usua_resp').AsINteger );
         Grid.Cells[Grid.getcolumn('paca_seto_codigo'),i]:=FSetores.GetDescricao( Q.fieldbyname('paca_seto_codigo').AsString );
         Grid.Cells[Grid.getcolumn('paca_oque'),i]:=Q.fieldbyname('paca_oque').AsString;
         Grid.Cells[Grid.getcolumn('paca_como'),i]:=Q.fieldbyname('paca_como').AsString;

//         if (Grid.GetColumn('paca_quem')=Grid.col) or (Grid.GetColumn('paca_quando')=Grid.col)
//            then begin
            diasatraso:=round( Sistema.hoje - Q.fieldbyname('paca_quando').asdatetime );
            if diasatraso>0 then begin
//              Grid.Columns.Items[Grid.GetColumn('paca_quem')].Font.Color:=clRed;
              Grid.Cells[Grid.getcolumn('situacao'),i]:='ATRASADO';
//               Grid.Columns.Items[Grid.GetColumn('paca_quando')].Font.Color:=clRed;
//               Grid.Canvas.Font.Color:=clRed;
            end else if (diasatraso>=-7) and (diasatraso<=0) then begin
              Grid.Cells[Grid.getcolumn('situacao'),i]:='NA SEMANA';
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clBlue;
//              Grid.Canvas.Font.Color:=clBlue;
            end else begin
              Grid.Cells[Grid.getcolumn('situacao'),i]:='EM EXECUÇÃO';
//              Grid.Columns.Items[Grid.GetColumn('situacao')].Font.Color:=clGreen;
//              Grid.Canvas.Font.Color:=clGreen;
            end;
//         end;

         Grid.Cells[Grid.getcolumn('paca_quem'),i]:=Q.fieldbyname('paca_quem').AsString;
         Grid.Cells[Grid.getcolumn('paca_quando'),i]:=FGeral.formatadata(Q.fieldbyname('paca_quando').asdatetime);
         Grid.Cells[Grid.getcolumn('paca_porque'),i]:=Q.fieldbyname('paca_porque').AsString;
         Grid.Cells[Grid.getcolumn('paca_valor'),i]:=floattostr(Q.fieldbyname('paca_valor').AsCurrency);
         if Q.fieldbyname('paca_dtencerra').AsDatetime>1 then
           Grid.Cells[Grid.getcolumn('paca_dtencerra'),i]:=FGeral.formatadata(Q.fieldbyname('paca_dtencerra').asdatetime)
         else
           Grid.Cells[Grid.getcolumn('paca_dtencerra'),i]:='';
         Grid.Cells[Grid.getcolumn('paca_seq'),i]:=Q.fieldbyname('paca_seq').AsString;
         Grid.Cells[Grid.getcolumn('paca_tipoplano'),i]:=Q.fieldbyname('paca_tipoplano').AsString;
         Grid.Cells[Grid.getcolumn('paca_numeroata'),i]:=Q.fieldbyname('paca_numeroata').AsString;
//{

//}
         Grid.AppendRow;
         inc(i);
         Q.Next;
      end;
    end;

begin
//////////////////////////////////////
  Sistema.beginprocess('Pesquisando planos de ação');
//  sqlusuario:=' and paca_usua_resp='+inttostr(Global.Usuario.Codigo);
  sqlusuario:=' and paca_usua_quem='+inttostr(Global.Usuario.Codigo)+' and paca_usua_quem>0';
  if Global.Usuario.OutrosAcessos[0401] then
    sqlusuario:='';
  Q:=sqltoquery('select * from planoacao where paca_status=''N'''+
                ' and paca_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                ' and paca_situacao=''P'''+
//                ' and paca_quando<='+Datetosql(Sistema.hoje+7)+
// 12.11.08 - mostra sempre tudo q esta em aberto
                sqlusuario+
                ' order by paca_quando');
  if not Q.eof then begin
    Show;
    QuerytoGrid(Q);
  end;
  Sistema.endprocess('');

end;
// 26.02.13
procedure TFPlanosPendentes.GridNewLine(Sender: TObject);
/////////////////////////////////////////////////////////
begin
  EdPaca_oque.text:=Grid.cells[Grid.GetColumn('paca_oque'),Grid.row];
  EdPaca_como.text:=Grid.cells[Grid.GetColumn('paca_como'),Grid.row];
  EdPaca_porque.text:=Grid.cells[Grid.GetColumn('paca_porque'),Grid.row];
  EdPaca_quem.text:=Grid.cells[Grid.GetColumn('paca_quem'),Grid.row];
//  EdPaca_usua_codigo.validfind;
  EdPaca_valor.text:=Grid.cells[Grid.GetColumn('paca_valor'),Grid.row];
  EdPaca_quando.setdate( Texttodate( FGeral.TiraBarra( Grid.cells[Grid.GetColumn('paca_quando'),Grid.row]) ) );
end;

end.
