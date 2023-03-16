unit gerenciaecf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SqlDtg, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  SQLGrid, ExtCtrls, SqlExpr;

type
  TFGerenciaECF = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bimpcupom: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Edtermino: TSQLEd;
    EdInicio: TSQLEd;
    pgrid: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    OpenDialog1: TOpenDialog;
    bmarcacf: TSQLBtn;
    procedure EdUnid_codigoValidate(Sender: TObject);
    procedure bimpcupomClick(Sender: TObject);
    procedure bmarcacfClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute( xtransacao:string='' ; xtipomovimento:string=''; xvalortroco:currency=0);
    procedure ConsultaMovimentoCupons;
    function GetSituacao(Q:TSqlquery):string;
    procedure imprimecupom(xvalortroco:currency=0);
    procedure   EnviaNfce;

  end;

var
  FGerenciaECF: TFGerenciaECF;
  ttransacao,ttipomovimento,tiposdemovimento,tiposnao,ambiente:string;
  CodigoMovECF,CodigoMovECFVC:integer;
  ValorTroco:currency;

implementation

uses Geral, SqlFun, SqlSis,
     ECFTeste1,
     expnfetxt, gerencianfe;

{$R *.dfm}

{ TFGerenciaECF }

//////////////////////////////////////////////////////////////
procedure TFGerenciaECF.ConsultaMovimentoCupons;
/////////////////////////////////////////////////
var Q:TSqlquery;
    sqlexp,sqlnotas:string;
    p:integer;
begin
  CodigoMovECF:=FGeral.GetConfig1AsInteger('ConfMovECF');
  CodigoMovECFVC:=FGeral.GetConfig1AsInteger('ConfMovECFVC');
  if ( FGeral.GetConfig1AsInteger('ConfMovNFCe')>0 ) then begin
    CodigoMovECF:=FGeral.GetConfig1AsInteger('ConfMovNFCe');
    CodigoMovECFVC:=FGeral.GetConfig1AsInteger('ConfMovNFCeVC');
  end;
  if CodigoMOvecf=0 then begin
    Avisoerro('Falta configurar o codigo da configuração de movimento referente ECF/NFC-e');
    exit;
  end;
  sqlexp:='';
  sqlnotas:='';
  if trim(ttransacao)<>'' then
    sqlnotas := 'and moes_transacao = '+Stringtosql(ttransacao);
  tiposdemovimento:=Global.TiposSaida;
  Q:=sqltoquery('select movesto.*,clientes.clie_razaosocial,clientes.clie_tipo,clientes.clie_endres,clientes.clie_uf'+
                ' from movesto'+
                ' left join clientes on (clie_codigo=moes_tipo_codigo)'+
                ' where moes_datamvto>='+EdInicio.assql+
                ' and '+FGeral.getin('moes_status','N;E;D','C')+
                ' and moes_datamvto<='+EdTermino.assql+
                ' and moes_unid_codigo='+EdUnid_codigo.assql+
                ' and moes_datacont > '+DatetoSql(Global.DataMenorBanco)+
//                ' and moes_comv_codigo='+Inttostr(CodigoMovECF)+
// 31.03.14
                ' and '+FGeral.GetIn('moes_comv_codigo',Inttostr(CodigoMovECF)+';'+Inttostr(CodigoMovECFVC),'N')+
                ' and '+FGeral.Getin('moes_tipomov',tiposdemovimento,'C')+
                ' and '+FGeral.GetNOtin('moes_tipomov',tiposnao,'C')+
                sqlexp+sqlnotas+
//                ' and moes_tipocad='+stringtosql(Cv)+
                ' order by moes_numerodoc,moes_datamvto,moes_vispra' );
  if Q.eof then begin
    Avisoerro('Nada encontrado neste período');
    exit;
  end;
  Grid.Clear;p:=1;
  while not Q.eof do begin
    Grid.Cells[Grid.GetColumn('moes_numerodoc'),p]:=Q.fieldbyname('moes_numerodoc').asstring;
    Grid.Cells[Grid.GetColumn('moes_dataemissao'),p]:=FGeral.FormataData( Q.fieldbyname('moes_dataemissao').asdatetime );
    Grid.Cells[Grid.GetColumn('moes_datamvto'),p]:=FGeral.FormataData( Q.fieldbyname('moes_datamvto').asdatetime );
    Grid.Cells[Grid.GetColumn('moes_vlrtotal'),p]:=floattostr(Q.fieldbyname('moes_vlrtotal').Ascurrency);
    Grid.Cells[Grid.GetColumn('moes_tipo_codigo'),p]:=Q.fieldbyname('moes_tipo_codigo').asstring;
    if Q.FieldByName('moes_tipocad').AsString='C' then begin
      Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:=Q.fieldbyname('clie_razaosocial').asstring;
    end else begin
      Grid.Cells[Grid.GetColumn('clie_razaosocial'),p]:=FGeral.GetNomeRazaoSocialEntidade( Q.fieldbyname('moes_tipo_codigo').asinteger,
                                Q.fieldbyname('moes_tipocad').asstring,'R');
    end;
    Grid.Cells[Grid.GetColumn('situacao'),p]:=GetSituacao(Q);
    Grid.Cells[Grid.GetColumn('moes_transacao'),p]:=Q.fieldbyname('moes_transacao').asstring;
    Grid.Cells[Grid.GetColumn('moes_tipomov'),p]:=Q.fieldbyname('moes_tipomov').asstring;
// 31.08.15
    Grid.Cells[Grid.GetColumn('moes_chavenfe'),p]:=Q.fieldbyname('moes_chavenfe').asstring;
    Grid.AppendRow;
    inc(p);
    Q.Next;
  end;
  Grid.SetFocus;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TFGerenciaECF.Execute(xtransacao:string='' ; xtipomovimento:string=''; xvalortroco:currency=0);
////////////////////////////////////////////////////////////////////////////////////////////////////////
begin
  Show;
  Grid.clear;
  tiposdemovimento:=Global.TiposSaida;
  tiposnao:=Global.TiposNaoFiscal+';'+Global.CodDevolucaoConsig+';'+
            Global.CodDevolucaoTroca+';'+Global.CodDevolucaoProntaEntrega+';'+
            Global.CodDevolucaoSerie5;
  EdUnid_codigo.text:=Global.CodigoUnidade;
  valortroco:=xvalortroco;
  if EdInicio.isempty then
    EdInicio.setdate(sistema.hoje);
  if EdTermino.isempty then
    EdTermino.setdate(sistema.hoje);
  ttransacao:=xtransacao;
  ttipomovimento:=xtipomovimento;
//  EdInicio.SetFirstEd;
  ConsultaMovimentoCupons;
  {
// 31.08.15
  if ( FGeral.GetConfig1AsInteger('ConfMovNFCe')>0 ) then begin
     bimpcupom.caption:='Imp.NFC-e';
     bmarcacf.caption:='Marca NFC-e';
  end;
  }
  EdInicio.Setfocus;

end;

///////////////////////////////////////////////////////////
function TFGerenciaECF.GetSituacao(Q: TSqlquery): string;
///////////////////////////////////////////////////////////
begin
  result:='Cupom/NFC-e NÃO Impresso';
  if Q.fieldbyname('moes_chavenfe').AsString<>'' then
    result:='NFC-e Já Autorizada'
  else if Q.fieldbyname('moes_envio').AsString='E' then begin
    result:='Cupom/NFC-e Já impresso';
  end;
end;

procedure TFGerenciaECF.EdUnid_codigoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin

  ConsultaMovimentoCupons;

end;

///////////////////////////////////////////////////////////
procedure TFGerenciaECF.bimpcupomClick(Sender: TObject );
/////////////////////////////////////////////////////////////////////////////////////
var chave,numero:string;
    Q:TSqlquery;
begin
{
// 31.08.15
  if ( FGeral.GetConfig1AsInteger('ConfMovNFCE')>0 ) then begin
    chave:=Grid.Cells[Grid.GetColumn('moes_chavenfe'),Grid.row];
    numero:=Grid.Cells[Grid.GetColumn('moes_numerodoc'),Grid.row];
    if trim( chave ) <> '' then
      FGerenciaNfe.Execute(numero)
    else begin
      FExpNfetxt.Execute(0,'NFCE');
      FGerenciaNfe.Execute(numero)
    end;
  end else
  }
    ImprimeCupom;


end;

// 27.03.13
procedure TFGerenciaECF.imprimecupom(xvalortroco: currency=0);
////////////////////////////////////////////////////////////////
var ct,tipomov,situacao:string;
begin
  ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row];
  tipomov:=Grid.Cells[Grid.GetColumn('moes_tipomov'),Grid.row];
  situacao:=Grid.Cells[Grid.GetColumn('situacao'),Grid.row];
  if situacao='Cupom Já impresso' then begin
    Avisoerro('Cupom já impresso nesta transação');
    exit;
  end;
  if trim(ct)='' then begin
    Avisoerro('Escolher uma transação para impressão do cupom');
    exit;
  end;
// 06.12.13 - Vivan - Sandra - impressao mais de uma vez o cupom
  Grid.Enabled:=false;
  bimpcupom.Enabled:=false;
//  try
    if Form1.ImprimeCupomFiscal(trim(ct),trim(tipomov),xvalortroco) then begin
      try
        Sistema.Edit('movesto');
        Sistema.SetField('moes_envio','E');
        Sistema.Post( 'moes_transacao='+Stringtosql(ct)+' and moes_tipomov='+Stringtosql(tipomov) );
        Sistema.Commit;
        Grid.Cells[Grid.GetColumn('situacao'),Grid.row]:='Cupom Já impresso';
      except
        Sistema.endprocess('Problemas na gravação do status de cupom impresso');
      end;
    end else begin
//  except
      Sistema.endprocess('Problemas na impressão do cupom fiscal');
    end;
// 06.12.13 - Vivan - Sandra - impressao mais de uma vez o cupom
    Grid.Enabled:=true;
    bimpcupom.Enabled:=true;

//    if confirma('Cupom impresso - mudar status') then begin
//    end;
end;

// 21.11.13 - marca como 'desmitido' pra poder cancelar a transacao ref. a CF
procedure TFGerenciaECF.bmarcacfClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////////////
var ct,tipomov,situacao:string;
begin
  ct:=Grid.Cells[Grid.GetColumn('moes_transacao'),Grid.row];
  tipomov:=Grid.Cells[Grid.GetColumn('moes_tipomov'),Grid.row];
  situacao:=Grid.Cells[Grid.GetColumn('situacao'),Grid.row];
  if trim(ct)='' then begin
    Avisoerro('Escolher uma transação para impressão do cupom');
    exit;
  end;
  try
        Sistema.Edit('movesto');
        Sistema.SetField('moes_envio','');
        Sistema.Post( 'moes_transacao='+Stringtosql(ct)+' and moes_tipomov='+Stringtosql(tipomov) );
        Sistema.Commit;
        Grid.Cells[Grid.GetColumn('situacao'),Grid.row]:='Cupom NÃO Impresso';
  except
      Sistema.endprocess('Problemas na na gravação.  Tentar mais tarde');
  end;

end;

procedure TFGerenciaECF.EnviaNfce;
begin
end;

end.
