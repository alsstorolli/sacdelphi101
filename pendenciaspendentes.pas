unit pendenciaspendentes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr,Mimemess, mimepart;

type
  TFPendenciasPendentes = class(TForm)
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
    PIns: TSQLPanelGrid;
    GridCheques: TSqlDtGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    bemail: TSQLBtn;
    procedure bimpressaoClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure bemailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ChecaPendenciasPendentes(tp:string='P');
  end;

var
  FPendenciasPendentes: TFPendenciasPendentes;
  qtipo:string;

implementation

uses Geral,Sqlsis,Sqlfun, BaixaPen, cadcli;

{$R *.dfm}

{ TFPendenciasPendentes }

procedure TFPendenciasPendentes.ChecaPendenciasPendentes(tp: string);
////////////////////////////////////////////////////////////////////////
var sqlusuario,sqlcontas:string;
    Q:TSqlquery;


    procedure QuerytoGrid(Q:Tsqlquery);
    //////////////////////////////////////
    var i,diasatraso:integer;
    begin
      Grid.clear;i:=1;
      while not Q.Eof do begin
         Grid.Cells[Grid.getcolumn('pend_datavcto'),i]:=FGeral.formatadata(Q.fieldbyname('pend_datavcto').asdatetime);
         Grid.Cells[Grid.getcolumn('pend_numerodcto'),i]:=Q.fieldbyname('pend_numerodcto').AsString;
         Grid.Cells[Grid.getcolumn('pend_tipo_codigo'),i]:=Q.fieldbyname('pend_tipo_codigo').AsString;
         Grid.Cells[Grid.getcolumn('razaosocial'),i]:=FGeral.GetNomeRazaoSocialEntidade( Q.fieldbyname('pend_tipo_codigo').AsInteger,
                    Q.fieldbyname('pend_tipocad').AsString,'R');

         Grid.Cells[Grid.getcolumn('pend_parcela'),i]:=Q.fieldbyname('pend_parcela').AsString;
         Grid.Cells[Grid.getcolumn('pend_valor'),i]:=floattostr( Q.fieldbyname('pend_valor').AsCurrency );

          diasatraso:=round( Sistema.hoje - Q.fieldbyname('pend_Datavcto').asdatetime );
{
            if diasatraso>0 then begin
              Grid.Cells[Grid.getcolumn('situacao'),i]:='ATRASADO';
            end else if (diasatraso>=-7) and (diasatraso<=0) then begin
              Grid.Cells[Grid.getcolumn('situacao'),i]:='NA SEMANA';
            end else begin
              Grid.Cells[Grid.getcolumn('situacao'),i]:='EM EXECUÇÃO';
            end;
}
         Grid.Cells[Grid.getcolumn('atraso'),i]:=inttostr(diasatraso);
         Grid.AppendRow;
         inc(i);
         Q.Next;
      end;
    end;

    procedure QuerytoGridCheques(Q:Tsqlquery);
    //////////////////////////////////////
    var i,diasatraso:integer;
    begin
      GridCheques.clear;i:=1;
      while not Q.Eof do begin
         GridCheques.Cells[GridCheques.getcolumn('pend_datavcto'),i]:=FGeral.formatadata(Q.fieldbyname('movf_dataprevista').asdatetime);
         GridCheques.Cells[GridCheques.getcolumn('pend_numerodcto'),i]:=Q.fieldbyname('movf_numerodcto').AsString;
         GridCheques.Cells[GridCheques.getcolumn('pend_tipo_codigo'),i]:=Q.fieldbyname('movf_tipo_codigo').AsString;
         GridCheques.Cells[GridCheques.getcolumn('razaosocial'),i]:='Cheque emitido';
//         FGeral.GetNomeRazaoSocialEntidade( Q.fieldbyname('pend_tipo_codigo').AsInteger,
//                    Q.fieldbyname('pend_tipocad').AsString,'R');

         GridCheques.Cells[GridCheques.getcolumn('pend_parcela'),i]:='1';
         GridCheques.Cells[GridCheques.getcolumn('pend_valor'),i]:=floattostr( Q.fieldbyname('movf_valorger').AsCurrency );

//          diasatraso:=round( Sistema.hoje - Q.fieldbyname('movf_Dataprevista').asdatetime );
          diasatraso:=0;
{
            if diasatraso>0 then begin
              Grid.Cells[Grid.getcolumn('situacao'),i]:='ATRASADO';
            end else if (diasatraso>=-7) and (diasatraso<=0) then begin
              Grid.Cells[Grid.getcolumn('situacao'),i]:='NA SEMANA';
            end else begin
              Grid.Cells[Grid.getcolumn('situacao'),i]:='EM EXECUÇÃO';
            end;
}
//         GridCheques.Cells[GridCheques.getcolumn('atraso'),i]:=inttostr(diasatraso);
         GridCheques.AppendRow;
         inc(i);
         Q.Next;
      end;
    end;


begin
//////////////////////////////////////

  Pins.Visible:=false;
  Pins.Enabled:=false;
  bemail.visible:=( tp='R' );

  Sistema.beginprocess('Pesquisando pendencias em atraso/avencer');

  qtipo:=tp;
//  sqlusuario:=' and paca_usua_resp='+inttostr(Global.Usuario.Codigo);
  sqlusuario:='';
  Q:=sqltoquery('select * from pendencias where pend_status=''N'''+
                ' and pend_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                ' and pend_rp='+stringtosql(qtipo)+
                ' and pend_databaixa is null'+
//                ' and pend_datavcto-now()<=0'+
                ' and pend_datavcto<='+Datetosql(Sistema.hoje+3)+
// 10.03.10
                ' and pend_datavcto>='+Datetosql(Sistema.hoje-30)+
                sqlusuario+
                ' order by pend_datavcto');
  if not Q.eof then begin
    Show;
    QuerytoGrid(Q);
  end;
// 19.07.12 - Damama - cheques emitidos
  FGeral.FechaQuery(Q);
  if qtipo='R' then Caption:='Checagem de Recebimentos Pendentes' else Caption:='Checagem de Pagamentos Pendentes';
// criar campo para diversas contas na configuracao geral
//  sqlcontas:=' and '+FGeral.GetIN('movf_plan_conta','2075;2074','N');
  if trim( FGeral.GetConfig1AsString('Contaschacomp') ) <>'' then begin
    sqlcontas:=' and '+FGeral.GetIN('movf_plan_conta',FGeral.GetConfig1AsString('Contaschacomp'),'N');
// ver como pegar somente cheques em aberto ( talvez com sum por numero do documento )
// por enquanto ficamos 'só no lembre'
    Q:=sqltoquery('select * from movfin where movf_status=''N'''+
                  ' and movf_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                  ' and movf_es='+stringtosql('E')+
                  sqlcontas+
//                  ' and movf_dataprevista <= '+Datetosql(Sistema.hoje-3)+
                  ' and movf_dataprevista >= '+Datetosql(Sistema.hoje-3)+
                  ' order by movf_dataprevista');
    if not Q.eof then begin
      Pins.Visible:=true;
      Pins.Enabled:=true;
      QuerytoGridCheques(Q);
    end;
    FGeral.FechaQuery(Q);
  end;

  Sistema.endprocess('');
end;

// 18.02.19
procedure TFPendenciasPendentes.bemailClick(Sender: TObject);
///////////////////////////////////////////////////////////////
var xemail,
    xcodcliente  :string;
    Corpo:TMimeMess;
    Parte1:TMimePart;
    endereco:string;
    Lista:TStringList;
    p:integer;
    QU   :TSqlQuery;

begin

   xcodcliente := Grid.Cells[Grid.GetColumn('pend_tipo_codigo'),Grid.row];
   if trim( xcodcliente ) <> '' then begin

      Sistema.beginprocess('Enviando email');
      QU:=sqltoquery('select * from unidades where unid_codigo = '+Stringtosql(Global.CodigoUnidade));

      xemail := FGeral.GetEmailEntidade( strtoint(xcodcliente),'C' );
        Corpo:=TMimeMess.Create;
        Parte1:=TMimePart.Create;
        Parte1 := Corpo.AddPartMultipart('mixed', nil);
        Lista:=TStringList.create;
        Lista.Add('');
        Lista.Add('');
        Lista.Add( 'Boleto referente nota fiscal '+Grid.Cells[Grid.GetColumn('pend_numerodcto'),Grid.row]+
                   ' vence em '+Grid.Cells[Grid.GetColumn('pend_datavcto'),Grid.row] +
                   ' de valor R$ '+FGeral.Formatavalor( TextToValor(Grid.Cells[Grid.GetColumn('pend_valor'),Grid.row]),f_cr) );
        Lista.Add('');
        Lista.Add('');

       Lista.Add(  QU.fieldbyname('unid_razaosocial').AsString );
       Lista.Add(  FGeral.Formatacnpj( Qu.fieldbyname('Unid_cnpj').AsString ) );
       Lista.Add(  Qu.fieldbyname('Unid_endereco').AsString );
       Lista.Add(  Qu.fieldbyname('Unid_bairro').AsString+' - '+
                        Qu.fieldbyname('Unid_municipio').AsString  );
       Lista.Add(  FGeral.Formatatelefone( Qu.fieldbyname('Unid_fone').AsString ) );
       Lista.Add(  QU.fieldbyname('Unid_email').AsString );

        Lista.SaveToFile('emailcobranca.txt');

        Corpo.AddPartTextFromFile( 'emailcobranca.txt' , Parte1);
        Corpo.Header.From:=FGeral.GetConfig1AsString('EMAILORIGEM');
        Corpo.Header.ToList.Text:=xemail;
        Corpo.Header.Subject:='Lembrete de vencimento de boleto';
        Corpo.EncodeMessage;
        FGeral.SendMime( FGeral.GetConfig1AsString('SMTP'),FGeral.GetConfig1AsString('USUARIOSMTP'),FGeral.GetConfig1AsString('SENHASMTP'),Corpo );
        Sistema.EndProcess('');
        Corpo.Free;
        Lista.Free;

        Sistema.Endprocess('Email enviado');

   end;

end;

procedure TFPendenciasPendentes.bimpressaoClick(Sender: TObject);
begin
   FBaixaPendencia.Execute;
end;


procedure TFPendenciasPendentes.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    FPendenciasPendentes.FreeOnRelease;
end;

// 15.02.17
procedure TFPendenciasPendentes.GridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
////////////////////////////////////////////////////////////
var s:string;
    t:integer;
begin
  if (not (gdSelected in State)) and (ARow>0) then begin
        if Arow mod 2 = 0 then begin
           Grid.Canvas.Brush.Color := clwhite;
           s:=Grid.Cells[ACol,ARow];
           Grid.Canvas.FillRect(Rect);
           t:=Grid.Canvas.TextWidth(s)+2;
           if Grid.Columns[ACol].Alignment=taRightJustify then
              Grid.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else Grid.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
        end else begin
           Grid.Canvas.Brush.Color := clYellow;
           s:=Grid.Cells[ACol,ARow];
           Grid.Canvas.FillRect(Rect);
           t:=Grid.Canvas.TextWidth(s)+2;
           if Grid.Columns[ACol].Alignment=taRightJustify then
              Grid.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else Grid.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
        end;
  end;
end;

end.
