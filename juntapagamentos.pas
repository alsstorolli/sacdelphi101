unit juntapagamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, SqlDtg, Vcl.StdCtrls,
  Vcl.Mask, SQLEd, Vcl.Buttons, SQLBtn, alabel, SQLGrid, Vcl.ExtCtrls;

type
  TFJuntaPagamentos = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bjuntapagamentos: TSQLBtn;
    bgeranfes: TSQLBtn;
    bmarcatodos: TSQLBtn;
    bdesmarcatodos: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Edtermino: TSQLEd;
    EdInicio: TSQLEd;
    pgrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    EdNumeronotas: TSQLEd;
    EdPesoNotas: TSQLEd;
    EdCodtipo: TSQLEd;
    SetEdFavorecido: TSQLEd;
    EdFpgt_codigo: TSQLEd;
    EdFpgt_descricao: TSQLEd;
    procedure EdterminoValidate(Sender: TObject);
    procedure bmarcatodosClick(Sender: TObject);
    procedure bdesmarcatodosClick(Sender: TObject);
    procedure GridClick(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure bjuntapagamentosClick(Sender: TObject);
    procedure EdCodtipoValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure VerificaPagamentos;

  end;

var
  FJuntaPagamentos: TFJuntaPagamentos;

implementation

uses Geral, Sqlsis, SqlExpr, SqlFun;

{$R *.dfm}

{ TFJuntaPagamentos }

procedure TFJuntaPagamentos.bdesmarcatodosClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var x:integer;
begin

  for x:=0 to Grid.rowcount do begin
    if trim( Grid.cells[Grid.getcolumn('moes_numerodoc'),x] ) <> '' then begin
        Grid.cells[Grid.getcolumn('marcado'),x]:='';
    end;
  end;

  EdNumeronotas.Clear;
  EdPesoNotas.Clear;

end;

procedure TFJuntaPagamentos.bjuntapagamentosClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////
var transacao,
    operacoes   : string;
    p,
    codrepr     : integer;

begin

  if EdFpgt_codigo.isempty then begin

     Avisoerro(' Informar a condi��o de pagamento');
     EdFpgt_codigo.setfocus;
     exit;

  end;
  if not Confirma('Confirma juntar todos os pagamentos marcados ?') then exit;

  operacoes := '';
  for p:=1 to Grid.RowCount do begin

    if (Grid.cells[Grid.Getcolumn('marcado'),p]='OK') and (Grid.cells[Grid.Getcolumn('moes_transacao'),p]<>'') then begin

       operacoes:=operacoes+';'+Grid.cells[Grid.Getcolumn('moes_transacao'),p];

    end;

  end;

  if operacoes='' then  begin

     Avisoerro('Nenhum documento marcado');
     exit;

  end;

  transacao := FGeral.GetTransacao;

  Sistema.edit('pendencias');
  Sistema.setfield('pend_status','C');
  Sistema.setfield('Pend_TransBaixa',transacao);
  Sistema.post( FGeral.Getin('pend_operacao',operacoes,'C') );

  codrepr := 0;
  FGeral.GravaPendencia(Sistema.hoje,Sistema.hoje,EdCodtipo,'F',codrepr,EdUnid_codigo.text,Global.CodPendenciaFinanceira,
                       Transacao,EdFpgt_codigo.text,'P', EdCodtipo.asinteger+Datetodia(Sistema.hoje)+Datetomes(Sistema.hoje),0,EdPesoNotas.AsCurrency,0,'N',0,0,Nil,'',
                       '','Jun��o de v�rios pagamentos' );
  try
    Sistema.commit;
    Aviso('Terminado agrupamento de pagamentos');

  except on E:exception do

    Avisoerro('N�o foi poss�vel gravar no banco de dados.  Tente mais tarde');

  end;

  Grid.clear;
  EdCodtipo.setfocus;

end;

procedure TFJuntaPagamentos.bmarcatodosClick(Sender: TObject);
////////////////////////////////////////////////////////////////
var x:integer;
    xpeso:currency;
begin

  EdNUmeronotas.SetValue(0);
  EdPesonotas.SetValue(0);
  xpeso:=0;
  for x:=0 to Grid.rowcount do begin
    if trim( Grid.cells[Grid.getcolumn('moes_numerodoc'),x] ) <> '' then begin
       Grid.cells[Grid.getcolumn('marcado'),x]:='Ok';
       Ednumeronotas.setvalue( EdNumeronotas.asinteger + 1 );
       xPeso:=xPeso + TexttoValor(Grid.cells[Grid.getcolumn('moes_vlrtotal'),x]) ;
    end;
  end;
  EdPesoNotas.SetValue( xpeso );
  EdPesoNotas.Update;

end;

procedure TFJuntaPagamentos.bSairClick(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
   Close;
end;

procedure TFJuntaPagamentos.EdCodtipoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////
begin

   if not EdCodtipo.isempty then SetEdFavorecido.text := FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,'F','N') ;

end;

procedure TFJuntaPagamentos.EdterminoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
begin

   if EdTermino.asdate < EdInicio.AsDate then EdTermino.Invalid('T�rmino tem que ser maior que inicio')
   else
     VerificaPagamentos;

end;

procedure TFJuntaPagamentos.Execute;
////////////////////////////////////////
begin

  Show;
  Grid.clear;
  EdCodTipo.clearall(self,99);
  EdUnid_codigo.text:=Global.CodigoUnidade;
  EdInicio.setdate(sistema.hoje);
  EdTermino.setdate(sistema.hoje);
  FGeral.ConfiguraColorEditsNaoEnabled(FJuntaPagamentos);
  EdCodTipo.setfocus;

end;

procedure TFJuntaPagamentos.GridClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

   if ( Grid.col=Grid.getcolumn('marcado') ) and ( trim(Grid.cells[Grid.getcolumn('moes_transacao'),Grid.row])<>'' ) then begin

     if Grid.cells[Grid.getcolumn('marcado'),Grid.row]='OK' then begin

       Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='';
       Ednumeronotas.setvalue( EdNumeronotas.asinteger - 1 );
       EdPesoNotas.SetValue( EdPesoNotas.ascurrency - TexttoValor(Grid.cells[Grid.getcolumn('moes_vlrtotal'),Grid.row]) );

     end else begin

       Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='OK';
       Ednumeronotas.setvalue( EdNumeronotas.asinteger + 1 );
       EdPesoNotas.SetValue( EdPesoNotas.ascurrency + TexttoValor(Grid.cells[Grid.getcolumn('moes_vlrtotal'),Grid.row]) );

     end;

   end;


end;

procedure TFJuntaPagamentos.VerificaPagamentos;
//////////////////////////////////////////////////////
var  Q           : TSqlquery;
     p           : integer;
     pesonotas,
     valorpedido,
     pesp         : currency;
     sqldata,
     sqltipomov,
     sqlfornec    : string;

begin

   Grid.Clear;
   p:=1;
   pesonotas:=0;
   valorpedido:=0;
   sqldata   :=' and pend_datavcto >= '+EdINicio.assql+ ' and pend_datavcto <= '+EdTermino.assql;
   sqltipomov:='';
   sqlfornec :=' and pend_tipo_codigo = '+EdCodtipo.assql;

   Q:=sqltoquery('select pendencias.*,forn_razaosocial,forn_nome from pendencias'+
                      ' inner join fornecedores on (forn_codigo=pend_tipo_codigo)'+
                      ' where pend_status = ''N'''+
                      ' and '+FGeral.Getin('pend_unid_codigo',Global.CodigoUnidade,'C')+
                      sqldata+sqltipomov+sqlfornec+
                      ' order by pend_datavcto' );

  if ( Q.Eof ) then begin

     Avisoerro('N�o encontrado documentos em aberto neste per�odo');
     exit;

  end;

  Sistema.BeginProcess('Pesquisando pedidos');

  while not Q.eof do begin

    valorpedido := Q.FieldByName('pend_valor').AsCurrency;

    if valorpedido>0 then begin

        Grid.Cells[Grid.GetColumn('moes_numerodoc'),p]  :=Q.fieldbyname('pend_numerodcto').asstring;
        Grid.Cells[Grid.GetColumn('moes_dataemissao'),p]:=FGeral.FormataData( Q.fieldbyname('pend_dataemissao').asdatetime );
        Grid.Cells[Grid.GetColumn('moes_vlrtotal'),p]   :=floattostr(valorpedido);
        Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p]:=Q.fieldbyname('pend_tipo_codigo').asstring;
        Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:=Q.fieldbyname('forn_razaosocial').asstring;
//        Grid.Cells[Grid.GetColumn('clie_endres'),p]:=Q.fieldbyname('clie_endres').asstring;
        Grid.Cells[Grid.GetColumn('moes_transacao'),p]  :=Q.fieldbyname('pend_operacao').asstring;
        Grid.Cells[Grid.GetColumn('marcado'),p]         :='OK';
        Grid.Cells[Grid.GetColumn('pend_datavcto'),p]:=FGeral.FormataData( Q.fieldbyname('pend_datavcto').asdatetime );

        pesonotas := pesonotas + valorpedido;
        EdPesonotas.setvalue( pesonotas );
        Grid.AppendRow;
        inc(p);

    end;

    Q.Next;

    EdNUmeroNOtas.setvalue(p);

  end;

  Sistema.endprocess('');

end;

end.
