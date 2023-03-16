unit Transrem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr ;

type
  TFTransfrem = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PRemessa: TSQLPanelGrid;
    EdCliente: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdDtemissao: TSQLEd;
    EdTotalRemessa: TSQLEd;
    EdNumeroDoc: TSQLEd;
    Edtotalqtde: TSQLEd;
    EdClidesti: TSQLEd;
    SQLEd2: TSQLEd;
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdClidestiValidate(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Campostoedits(Q:TSqlquery);
    procedure Campostogrid(Q:TSqlquery);
    function CalculaTotal:currency;
    function CalculaTotalQtde:currency;
    procedure Execute;
  end;

var
  FTransfrem: TFTransfrem;
  QBusca:TSqlquery;

implementation

uses Geral, Estoque, Sqlfun, Sqlsis;

{$R *.dfm}

procedure TFTransfrem.EdNumeroDocValidate(Sender: TObject);

    function buscaremessa( Numero: Integer ; Tipomov:string='' ; status:string='N'): String;
    begin
      result:='select movesto.*,movestoque.* from movesto,movestoque'+
            ' where moes_numerodoc='+inttostr(Numero)+
            ' and '+Fgeral.getin('moes_status',status,'C')+
            ' and '+FGeral.Getin('moes_tipomov',tipomov,'C')+
            ' and moes_numerodoc=move_numerodoc'+
            ' and '+FGeral.Getin('move_tipomov',tipomov,'C')+
            ' and '+Fgeral.getin('move_status',status,'C')+
            ' and moes_unid_codigo='+stringtosql(Global.CodigoUnidade)+
            ' and move_unid_codigo='+stringtosql(Global.CodigoUnidade)+
            ' and '+FGeral.Getin('move_tipomov',tipomov,'C')+
            ' order by move_esto_codigo' ;
    end;

begin
  if EdNumerodoc.AsInteger>0 then begin
     QBusca:=sqltoquery(buscaremessa(EdNumerodoc.AsInteger,Global.CodRemessaConsig,'N'));
     if QBusca.eof then begin
       EdNUmerodoc.INvalid('Numero de remessa n�o encontrado ou j� baixada');
       EdNumerodoc.ClearAll(FTransfrem,99);
       Grid.Clear;
     end else begin
       Campostoedits(Qbusca);
       Campostogrid(Qbusca);
       EdCliente.ValidFind;
     end;
  end;

end;

procedure TFTransfrem.Campostoedits(Q:TSqlquery);
begin
  EdDtEmissao.SetDate(Q.fieldbyname('moes_dataemissao').AsDateTime);
  EdTotalremessa.SetValue(Q.fieldbyname('moes_vlrtotal').AsCurrency);
  EdCliente.text:=Q.fieldbyname('moes_tipo_codigo').asstring;
  EdCliente.validateedit;
end;

procedure TFTransfrem.Campostogrid(Q:TSqlquery);
var p:integer;
begin
  Grid.Clear;p:=1;Q.First;
  while not Q.Eof do begin
    Grid.Cells[0,p]:=Q.fieldbyname('move_esto_codigo').Asstring;
    Grid.Cells[1,p]:=FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').Asstring);
    Grid.Cells[2,p]:=transform(Q.fieldbyname('move_qtde').Ascurrency,f_cr);
    Grid.Cells[3,p]:=transform(Q.fieldbyname('move_venda').Ascurrency,f_cr);
    Grid.Cells[4,p]:=transform(FGeral.Arredonda(Q.fieldbyname('move_venda').Ascurrency*Q.fieldbyname('move_qtde').Ascurrency,2),f_cr);
    inc(p);
    Grid.AppendRow;
    Q.Next;
  end;
  EdTotalqtde.setvalue(calculatotalqtde);
  EdTotalRemessa.setvalue(CalculaTotal);
end;


function TFTransfrem.CalculaTotal: currency;
var p:integer;
    vlrtotal:currency;
begin
  vlrtotal:=0;
  for p:=1 to Grid.RowCount do begin
    vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[2,p])*texttovalor(Grid.Cells[3,p]),2);
  end;
  result:=vlrtotal;
end;

function TFTransfrem.CalculaTotalQtde: currency;
var p:integer;
    vlrtotal:currency;
begin
  vlrtotal:=0;
  for p:=1 to Grid.RowCount do begin
    vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[2,p]),2);
  end;
  result:=vlrtotal;
end;

procedure TFTransfrem.bGravarClick(Sender: TObject);
begin

   if EdNumerodoc.isempty then exit;
   if not Edclidesti.valid then begin
     Avisoerro('Problemas no cliente destino');
     exit;
   end;
   if QBusca=nil then begin
     Avisoerro('Problemas para encontrar a remessa');
     exit;
   end;
   if not confirma('Confirma transfer�ncia') then exit;

   Sistema.beginprocess('Gravando');
   Sistema.Edit('Movesto');
   Sistema.Setfield('moes_tipo_codigo',EdClidesti.asinteger);
// 03.03.20 - Fama - mudar tbem o representante...
   Sistema.Setfield('moes_repr_codigo',EdClidesti.resultfind.FieldByName('clie_repr_codigo').AsInteger );
   Sistema.Post('moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodRemessaConsig)+
                'and moes_tipo_codigo='+Edcliente.assql+' and moes_numerodoc='+EdNumerodoc.assql+
                ' and moes_unid_codigo='+stringtosql(global.CodigoUnidade)+' and moes_dataemissao='+EdDtemissao.assql );
   Sistema.Edit('Movestoque');
   Sistema.Setfield('move_tipo_codigo',EdClidesti.asinteger);
   Sistema.Setfield('move_repr_codigo',EdClidesti.resultfind.FieldByName('clie_repr_codigo').AsInteger );
// 03.03.20
   Sistema.Post('move_status=''N'' and move_tipomov='+stringtosql(Global.CodRemessaConsig)+
                'and move_tipo_codigo='+Edcliente.assql+' and move_numerodoc='+EdNumerodoc.assql+
                ' and move_unid_codigo='+stringtosql(global.codigounidade)+' and move_datamvto='+EdDtemissao.assql );
   if not Sistema.Commit then
     Sistema.endprocess('Problemas no comando commit')
   else
     Sistema.endprocess('Transferencia realizada');

   Grid.clear;
   EdNumerodoc.clearall(FTransfrem,99);
   EdNumerodoc.setfocus;
end;

procedure TFTransfrem.EdClidestiValidate(Sender: TObject);
begin
  if Edclidesti.asinteger=Edcliente.asinteger then begin
     Edclidesti.invalid('Cliente destino tem que ser diferente do cliente origem');
  end;
end;

procedure TFTransfrem.bSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFTransfrem.Execute;
///////////////////////////////////
begin

   FGeral.ConfiguraColorEditsNaoEnabled(FTransfrem);
   show;

end;

procedure TFTransfrem.FormActivate(Sender: TObject);
begin
   EdNumerodoc.setfocus;
end;

end.
