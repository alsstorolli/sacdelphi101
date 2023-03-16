// 15.06.20
// entrada de cupins cfe indicado no abate o numero de carcaças com cupim

unit entradadecupim;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrBase, ACBrDFe, ACBrNFe, Vcl.Grids,
  SqlDtg, Vcl.StdCtrls, Vcl.Mask, SQLEd, Vcl.Buttons, SQLBtn, alabel,
  Vcl.ExtCtrls, SQLGrid, SqlExpr;

type
  TFEntradadecupim = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    betiqueta: TSQLBtn;
    EdCaoc_codigo: TSQLEd;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdDtdesossa: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    Edqtde: TSQLEd;
    EdPecas: TSQLEd;
    ACBrNFe1: TACBrNFe;
    procedure EdDtdesossaValidate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure LimpaEdits;
    procedure GravaMestre;
    procedure GravaItens;


  end;

var
  FEntradadecupim: TFEntradadecupim;
  kiloscupim     : currency;
  codigocupim,
  transacao    : string;

implementation

uses Geral, Sqlsis, Sqlfun, Estoque;

{$R *.dfm}

{ TFEntradadecupim }

procedure TFEntradadecupim.bGravarClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var NUmero    :integer;
    Q         : Tsqlquery;

begin

   if EdQtde.AsCurrency=0 then begin
      Avisoerro('Kilos tem que ser maior que zero');
      exit;
   end;
   q := sqltoquery('select move_transacao from movestoque where move_status = ''N'''+
                   ' and move_tipomov = '+Stringtosql(Global.CodDesossaEnt)+
                   ' and move_datamvto = '+EdDtdesossa.AsSql+
                   ' and move_unid_codigo = '+EdUnid_codigo.AsSql+
                   ' and move_esto_codigo = '+EdProduto.AsSql );

   if not confirma('Confirma a gravação ?') then  exit;

     if Q.eof then begin

        Numero:=FGeral.GetContador('DESOSSA'+EdUnid_codigo.text,false);
        EdNumerodoc.Text:=inttostr(Numero);

        Sistema.BeginProcess('Gravando');
        Transacao:=FGeral.GetTransacao;
        GravaMestre;
        GravaItens;
        try
          Sistema.Commit;
          Sistema.EndProcess('Gravado entrada numero '+EdNUmerodoc.text);
        except
          Avisoerro('Problemas na gravação.  Nada foi gravado.');
        end;

     end else begin

        Sistema.BeginProcess('Gravando');
        Sistema.Edit('movestoque');
        Sistema.SetField('move_qtde',EdQtde.AsCurrency);
        Sistema.SetField('move_pecas',Edpecas.AsCurrency);
        Sistema.Post('move_status = ''N'''+
                   ' and move_tipomov = '+Stringtosql(Global.CodDesossaEnt)+
                   ' and move_datamvto = '+EdDtdesossa.AsSql+
                   ' and move_unid_codigo = '+EdUnid_codigo.AsSql+
                   ' and move_transacao  = '+Stringtosql(Q.fieldbyname('move_transacao').asstring) );
        Sistema.commit;
        Sistema.EndProcess('Alterado entrada');

     end;

    LimpaEdits;
    EdDtDesossa.setfocus;


end;


procedure TFEntradadecupim.EdDtdesossaValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
var Q   :Tsqlquery;
    peso: currency;

begin

   if not FGeral.ValidaMvto(EdDtdesossa) then

     EdDtdesossa.Invalid('')

   else begin

      Q := sqltoquery('select sum(movd_pesocarcaca) as kilos,count(*) as pecas from movabatedet'+
                      ' where movd_datamvto = '+EdDtDesossa.AsSql+
                      ' and movd_unid_codigo = '+EdUNid_codigo.assql+
                      ' and movd_cupim = ''S''');


      peso := Q.FieldByName('kilos').AsCurrency;
      peso := peso * 0.01;    // considerando 1% os kilos em media ref. cupim

      EdProduto.Text := codigocupim;
      EdPecas.SetValue( Q.FieldByName('pecas').AsCurrency );
      EdQtde.SetValue(  Q.FieldByName('kilos').AsCurrency );
      FGeral.FechaQuery(Q);
      bgravarclick(self);

   end;

end;

procedure TFEntradadecupim.Execute;
///////////////////////////////////
var numero:integer;
begin

    FGeral.ConfiguraColorEditsNaoEnabled(Fentradadecupim);
    Numero:=FGeral.GetContador('DESOSSA'+EdUnid_codigo.text,false,false);
    EdNumerodoc.Text:=inttostr(Numero);
    codigocupim := '81';
    Show;
    LimpaEdits;
    EdUnid_codigo.text:=Global.CodigoUnidade;
    EdUNid_codigo.validfind;
    EdDtDesossa.setdate( Sistema.hoje );
    EdDtdesossa.setfocus;

end;

procedure TFEntradadecupim.GravaItens;
/////////////////////////////////////////
var TEstoqueQtde :TSqlquery;

begin

      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',EdProduto.text);
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',Ednumerodoc.asinteger);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',Global.CodDesossaent);
      Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('move_tipo_codigo',EdUNid_codigo.AsInteger);
      Sistema.SetField('move_tipocad','U');
      Sistema.SetField('move_repr_codigo',0);
      Sistema.SetField('move_qtde',EdQtde.ascurrency);
      Sistema.SetField('move_venda',FEstoque.GetPreco(EdProduto.text,EdUNid_codigo.text));
//      Sistema.SetField('move_datacont',Entrada);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',EdDtdesossa.AsDate);
      Sistema.SetField('move_qtderetorno',0);

      TEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_status=''N'' and esqt_unid_codigo='+EdUnid_codigo.assql+
                               ' and esqt_esto_codigo='+Edproduto.assql );

      if TEstoqueQtde.fieldbyname('esqt_custo').ascurrency > 0 then begin
        Sistema.SetField('move_custo',TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
        Sistema.SetField('move_custoger',TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
        Sistema.SetField('move_customedio',TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
        Sistema.SetField('move_customeger',TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
      end;
      Sistema.SetField('move_venda',TEstoqueQtde.fieldbyname('esqt_vendavis').ascurrency);
      Sistema.SetField('move_cst','');
      Sistema.SetField('move_aliicms',0);
      Sistema.SetField('move_grup_codigo',EdProduto.resultfind.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',EdProduto.resultfind.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',EdProduto.resultfind.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_aliipi',0);
      Sistema.SetField('move_pecas',EdPecas.ascurrency);
      Sistema.SetField('move_redubase',0);
      Sistema.Post('');

        if not TEstoqueqtde.Eof then
          FGeral.MovimentaQtdeEstoque(EdProduto.text,EdUnid_codigo.text,'E',Global.CodDesossaEnt,EdQtde.ascurrency ,TEstoqueqtde);

      FGeral.FechaQuery(TEstoqueqtde);


end;

procedure TFEntradadecupim.GravaMestre;
//////////////////////////////////////////////
begin

    Sistema.Insert('Movesto');
    Sistema.SetField('moes_transacao',Transacao);
    Sistema.SetField('moes_operacao',fGeral.GetOperacao);
    Sistema.SetField('moes_status','N');
//                Sistema.SetField('moes_numerodoc',100+numero);
    Sistema.SetField('moes_numerodoc',EdNumerodoc.asinteger);
    Sistema.SetField('moes_tipomov',Global.CodDesossaent);
    Sistema.SetField('moes_comv_codigo',0);
    Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
//    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
    Sistema.SetField('moes_tipo_codigo',EdUnid_codigo.asinteger);
    Sistema.SetField('moes_estado',EdUnid_codigo.ResultFind.fieldbyname('unid_uf').AsString);
    Sistema.SetField('moes_cida_codigo',EdUnid_codigo.ResultFind.fieldbyname('unid_cida_codigo').AsInteger);
    Sistema.SetField('moes_tipocad','U');
    Sistema.SetField('moes_datalcto',Sistema.Hoje);
    Sistema.SetField('moes_dataemissao',Sistema.Hoje);
    Sistema.SetField('moes_datamvto',EdDtDesossa.asdate);
//    Sistema.SetField('moes_DataCont',Movimento);
    Sistema.SetField('moes_vlrtotal',0);
    Sistema.SetField('moes_baseicms',0);
    Sistema.SetField('moes_valoricms',0);
    Sistema.SetField('moes_basesubstrib',0);
    Sistema.SetField('moes_valoricmssutr',0);
    Sistema.SetField('moes_totprod',0);
    Sistema.SetField('moes_vlrtotal',0);
    Sistema.SetField('moes_valortotal',0);
    Sistema.SetField('moes_natf_codigo','');
    Sistema.SetField('moes_freteciffob','');
    Sistema.SetField('moes_frete',0);
//              Sistema.SetField('moes_vispra',FCondPagto.GetAvPz(Condicao));
    Sistema.SetField('moes_especie','');
    Sistema.SetField('moes_serie','');
    Sistema.SetField('moes_tran_codigo','');
    Sistema.SetField('Moes_Perdesco',0);
    Sistema.SetField('Moes_Peracres',0);
    Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('moes_pedido',0);
    Sistema.Post();


end;

procedure TFEntradadecupim.LimpaEdits;
/////////////////////////////////////////
begin

  Edproduto.clear;
  EdQtde.clear;
  EdPecas.Clear;

end;

end.
