unit BxMenTem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, SQLEd, Buttons, SQLBtn, SQLGrid,
  ExtCtrls, SqlExpr;

type
  TFBaixaVendaTemporaria = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    bExecutar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    Edunidade: TSQLEd;
    Edmesano: TSQLEd;
    EdUnid_codigo: TSQLEd;
    Texto: TRichEdit;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdUnid_baixa: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    procedure EdmesanoValidate(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure bExecutarClick(Sender: TObject);
    procedure EdProdutoExitEdit(Sender: TObject);
    procedure EdUnid_baixaExitEdit(Sender: TObject);
    procedure EdUnid_baixaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
  end;

var
  FBaixaVendaTemporaria: TFBaixaVendaTemporaria;

implementation

uses Geral, Sqlfun, Estoque, Sqlsis, Grades, transfes, munic;

{$R *.dfm}

procedure TFBaixaVendaTemporaria.EdmesanoValidate(Sender: TObject);
begin
   if FGeral.Validamesano(edmesano.text) then begin
     if not FGeral.Validaperiodo(edmesano.text) then
       Edmesano.Invalid('');
   end else begin
       Edmesano.Invalid('');
   end;


end;

procedure TFBaixaVendaTemporaria.EdUnid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.limpaedit(EdUNid_codigo,key);

end;

procedure TFBaixaVendaTemporaria.FormActivate(Sender: TObject);
begin
  if EdUnid_codigo.isempty then
    EdUnid_codigo.Text:=Global.CodigoUnidade;
  FBaixaVendaTemporaria.Edmesano.SetFocus;

end;

procedure TFBaixaVendaTemporaria.bExecutarClick(Sender: TObject);
var transacao,sqlproduto,dettransacao:string;
    Q,Q1:TSqlquery;
    numerodoc,codrepr:integer;
    Datamovto:Tdatetime;
    Valortotal:currency;

   procedure gravaacertomestre;
   begin

      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacao);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',Numerodoc);
      Sistema.SetField('moes_tipomov',Global.CodAcertoEsSai);
      Sistema.SetField('moes_unid_codigo',EdUNid_Baixa.Text);
      Sistema.SetField('moes_estado',FCidades.GetUF(EdUnid_Baixa.ResultFind.fieldbyname('unid_cida_codigo').AsInteger));
      Sistema.SetField('moes_repr_codigo',codrepr);
      Sistema.SetField('moes_tipo_codigo',EdUnid_codigo.text);
      Sistema.SetField('moes_tipocad','U');
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',Datamovto);
      Sistema.SetField('moes_dataemissao',Datamovto);
      Sistema.SetField('moes_vlrtotal',Valortotal);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.SetField('moes_tabp_codigo',Q.fieldbyname('moes_tabp_codigo').asinteger);
      Sistema.SetField('moes_tabaliquota',Q.fieldbyname('moes_tabaliquota').ascurrency);
      Sistema.SetField('moes_natf_codigo',Q.fieldbyname('moes_natf_codigo').asstring);
      Sistema.SetField('moes_cida_codigo',Q.fieldbyname('moes_cida_codigo').asinteger);
      Sistema.SetField('moes_datacont',Q.fieldbyname('moes_datacont').asdatetime);
      Sistema.SetField('moes_totprod',Q.fieldbyname('moes_totprod').ascurrency);
      Sistema.SetField('moes_baseicms',Q.fieldbyname('moes_baseicms').ascurrency);
      Sistema.SetField('moes_valoricms',Q.fieldbyname('moes_valoricms').ascurrency);
      Sistema.SetField('moes_basesubstrib',Q.fieldbyname('moes_basesubstrib').ascurrency);
      Sistema.SetField('moes_valoricmssutr',Q.fieldbyname('moes_valoricmssutr').ascurrency);
      Sistema.SetField('moes_frete',Q.fieldbyname('moes_frete').ascurrency);
      Sistema.SetField('moes_freteciffob',Q.fieldbyname('moes_freteciffob').asstring);
      Sistema.SetField('moes_remessas',Q.fieldbyname('moes_remessas').asstring);
      Sistema.SetField('moes_vispra',Q.fieldbyname('moes_vispra').asstring);
      Sistema.SetField('moes_especie',Q.fieldbyname('moes_especie').asstring);
      Sistema.SetField('moes_serie',Q.fieldbyname('moes_serie').asstring);
      Sistema.SetField('moes_tran_codigo',Q.fieldbyname('moes_tran_codigo').asstring);
      Sistema.SetField('moes_qtdevolume',Q.fieldbyname('moes_qtdevolume').asinteger);
      Sistema.SetField('moes_especievolume',Q.fieldbyname('moes_especievolume').asstring);
      Sistema.SetField('moes_perdesco',Q.fieldbyname('moes_perdesco').ascurrency);
      Sistema.SetField('moes_peracres',Q.fieldbyname('moes_peracres').ascurrency);
      Sistema.SetField('moes_valortotal',Q.fieldbyname('moes_valortotal').ascurrency);
      Sistema.SetField('moes_valoravista',Q.fieldbyname('moes_valoravista').ascurrency);
      Sistema.SetField('moes_fpgt_codigo',Q.fieldbyname('moes_fpgt_codigo').asstring);
      Sistema.SetField('moes_pesobru',Q.fieldbyname('moes_pesobru').ascurrency);
      Sistema.SetField('moes_pesoliq',Q.fieldbyname('moes_pesoliq').ascurrency);
      Sistema.SetField('moes_devolucoes',EdMesano.text);
      Sistema.Post();

   end;

   procedure gravaacertodetalhe;
   var codigograde,codigocoluna,codigolinha:integer;
       esto_codigo:string;
   begin
      esto_codigo:=Q.fieldbyname('move_esto_codigo').asstring;
      codigograde:=FEstoque.GetCodigoGrade(ESto_codigo);

      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',ESto_codigo);
      codigolinha:=FEstoque.GetCodigoLinha(ESto_codigo,codigograde);
      codigocoluna:=FEstoque.GetCodigoColuna(ESto_codigo,codigograde);
      if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
        Sistema.SetField('move_tama_codigo',codigolinha)
      else
        Sistema.SetField('move_core_codigo',codigolinha);
      if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
        Sistema.SetField('move_tama_codigo',codigocoluna)
      else
        Sistema.SetField('move_core_codigo',codigocoluna);
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',numerodoc);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',Global.CodAcertoEsSai);
      Sistema.SetField('move_unid_codigo',EdUnid_Baixa.text);
      Sistema.SetField('move_tipo_codigo',EdUnid_codigo.text);
      Sistema.SetField('move_tipocad','U');
      Sistema.SetField('move_repr_codigo',Q.fieldbyname('move_repr_codigo').asinteger);
      Sistema.SetField('move_qtde',Q.fieldbyname('move_Qtde').ascurrency);
      Sistema.SetField('move_estoque',0);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',Datamovto);
//      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_venda',Q.fieldbyname('move_venda').ascurrency);
      Sistema.SetField('move_grup_codigo',FEstoque.getgrupo(Esto_codigo));
      Sistema.SetField('move_sugr_codigo',FEstoque.GetSubGrupo(Esto_codigo));
      Sistema.SetField('move_fami_codigo',FEstoque.GetFamilia(Esto_codigo));
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);

      Sistema.SetField('move_custo',Q.fieldbyname('move_custo').ascurrency);
      Sistema.SetField('move_custoger',Q.fieldbyname('move_custoger').ascurrency);
      Sistema.SetField('move_customedio',Q.fieldbyname('move_customedio').ascurrency);
      Sistema.SetField('move_customeger',Q.fieldbyname('move_customeger').ascurrency);
      Sistema.SetField('move_cst',Q.fieldbyname('move_cst').asstring);
      Sistema.SetField('move_aliicms',Q.fieldbyname('move_aliicms').ascurrency);
      Sistema.SetField('move_perdesco',Q.fieldbyname('move_perdesco').ascurrency);
      Sistema.SetField('move_vendabru',Q.fieldbyname('move_vendabru').ascurrency);
      Sistema.SetField('move_devolucoes',EdMesano.text);

      Sistema.Post('');

   end;


begin

  if not EdMesano.ValidEdiAll(FBaixaVendaTemporaria,99) then exit;
  sqlproduto:='';
  if not EdProduto.isempty then
    sqlproduto:=' and move_esto_codigo='+EdProduto.assql;
  Q:=sqltoquery('select * from movestoque inner join movesto on ( moes_transacao=move_transacao )'+
                ' and move_unid_codigo='+EdUnid_codigo.assql+
                sqlproduto+
                ' and extract( month from move_datamvto )='+copy(EdMesano.text,1,2)+
                ' and extract( year from move_datamvto )='+copy(EdMesano.text,3,4)+
                ' and '+fGeral.getin('move_tipomov',Global.CodVendaDireta,'C')+
                ' and move_status=''N'' order by move_transacao,move_operacao');
  if Q.eof then begin
    Avisoerro('Não encontrado movimento nesta unidade neste período');
    Q.close;
    exit;
  end;
  if not confirma('Confirma baixa mensal da venda da unidade temporária '+EdUnid_codigo.text+' no estoque da unidade '+EdUnid_baixa.text+' ?') then exit;

{
  Q1:=sqltoquery('select * from movesto '+
                ' where moes_unid_codigo='+EdUnid_baixa.assql+
                sqlproduto+
                ' and extract( month from moes_datamvto )='+copy(EdMesano.text,1,2)+
                ' and extract( year from moes_datamvto )='+copy(EdMesano.text,3,4)+
                ' and moes_status=''N'' order by moes_transacao,moes_operacao');
  if not Q1.eof then begin
    sistema.beginprocess('Eliminando baixa anterior - mestre');
    while not Q1.eof do begin
      Sistema.edit('movesto');
      Sistema.setfield('moes_status','C');
      sistema.post('moes_transacao='+stringtosql(Q1.fieldbyname('moes_transacao').asstring);
      Q1.next;
    end;
    sistema.beginprocess('Eliminando baixa anterior - detalhe');
    Q1:=sqltoquery('select * from movestoque inner join movesto on ( moes_transacao=move_transacao  and moes_tipomov=move_tipomov )'+
                ' and move_unid_codigo='+EdUnid_baixa.assql+
                sqlproduto+
                ' and extract( month from move_datamvto )='+copy(EdMesano.text,1,2)+
                ' and extract( year from move_datamvto )='+copy(EdMesano.text,3,4)+
                ' and move_status=''N'' order by move_transacao,move_operacao');
    while not Q1.eof do begin
      Sistema.edit('movestoque');
      Sistema.setfield('move_status','C');
      sistema.post('move_operacao='+stringtosql(Q1.fieldbyname('move_operacao').asstring);
      Q1.next;
    end;
    sistema.endprocess('');
  end;
}

  Sistema.BeginTransaction('Gravando ajuste');
//  Transacao:=FGeral.GetTransacao;
// devido as selects dos porras dos caralahos filhos das putas de AS q fode a transf. mensal e o
// extrato por produto/// 04.01.06
  Datamovto:=Datetoultimodiames(texttodate('01'+EdMesano.text));
  while not Q.eof do begin
     dettransacao:=Q.fieldbyname('move_transacao').asstring;
     numerodoc:=Q.fieldbyname('moes_numerodoc').asinteger;
     codrepr:=Q.fieldbyname('moes_repr_codigo').asinteger;
     valortotal:=Q.fieldbyname('moes_vlrtotal').ascurrency;
     Transacao:=FGeral.GetTransacao;
     GravaAcertoMestre;
     sistema.setmessage('Movimento de '+FGeral.FormataData(Q.fieldbyname('moes_datamvto').asdatetime));
     while (not Q.eof)  and (dettransacao=Q.fieldbyname('move_transacao').asstring) do begin
       GravaAcertoDetalhe;
       Q.next;
     end;
  end;

  try
    Sistema.beginprocess('Gravando movimento');
    Sistema.EndTransaction('Movimento Gerado - Transação '+Transacao);
    Sistema.endprocess('');
  except
    Avisoerro('Falha ao gerar movimento de saida na unidade '+EdUnid_baixa.text);
  end;
  FTransSaldos.Execute;

end;

procedure TFBaixaVendaTemporaria.Execute;
begin
  if FBaixaVendaTemporaria=nil then FGeral.CreateForm(TFBaixaVendaTemporaria,FBaixaVendaTemporaria);
  if FBaixaVendaTemporaria.Edmesano.isempty then
    FBaixaVendaTemporaria.Edmesano.Text := strzero(DateTomes(Sistema.Hoje),2)+Inttostr(Datetoano(Sistema.Hoje,true));
  FBaixaVendaTemporaria.Show;

end;

procedure TFBaixaVendaTemporaria.EdProdutoExitEdit(Sender: TObject);
begin
   bexecutarclick(self);
end;

procedure TFBaixaVendaTemporaria.EdUnid_baixaExitEdit(Sender: TObject);
begin
   bexecutarclick(Fbaixavendatemporaria);

end;

procedure TFBaixaVendaTemporaria.EdUnid_baixaKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.limpaedit(EdUNid_Baixa,key);

end;

end.
