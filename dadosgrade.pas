unit dadosgrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr, Barcode;

type
  TFDadosgrade = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bAlteraritem: TSQLBtn;
    bCancelaritem: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PFinan: TSQLPanelGrid;
    Edesto_qtdemaximo: TSQLEd;
    EdEsto_codigo: TSQLEd;
    EdEsto_descricao: TSQLEd;
    EdEsto_unidade: TSQLEd;
    EdEsto_qtde: TSQLEd;
    EdEsto_vendavis: TSQLEd;
    EdEsto_custo: TSQLEd;
    EdEsto_customedio: TSQLEd;
    EdEsto_customeger: TSQLEd;
    EdEsto_dtultvenda: TSQLEd;
    EdEsto_dtultcompra: TSQLEd;
    EdEsto_codbarra: TSQLEd;
    EdEsto_custoger: TSQLEd;
    Edesto_qtdeminimo: TSQLEd;
    Edcodtam: TSQLEd;
    Eddesctamanho: TSQLEd;
    EdCodcor: TSQLEd;
    EdDesccor: TSQLEd;
    EdEsto_qtdeprev: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    EdCodCopa: TSQLEd;
    EdMobra: TSQLEd;
    EdMomedio: TSQLEd;
    Barcode1: TBarcode;
    EdPontoressu: TSQLEd;
    EdQtdeprocesso: TSQLEd;
    bincluir: TSQLBtn;
    bexcluir: TSQLBtn;
    bimpcodbarragrade: TSQLBtn;
    betqlaser: TSQLBtn;
    edEtiqueta: TSQLEd;
    procedure bSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridClick(Sender: TObject);
    procedure bAlteraritemClick(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure EdEsto_dtultcompraExitEdit(Sender: TObject);
    procedure EdEsto_codbarraValidate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bincluirClick(Sender: TObject);
    procedure bexcluirClick(Sender: TObject);
    procedure bimpcodbarragradeClick(Sender: TObject);
    procedure betqlaserClick(Sender: TObject);
    procedure edEtiquetaExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetaEdits(operacao:string);

  end;

var
  FDadosgrade: TFDadosgrade;
  Q:TSqlquery;
  Unidade,Op:string;

implementation

uses Estoque, Geral, Sqlfun, tamanhos, cadcor, Sqlsis, cadcopa, Arquiv,
  impressao, Unidades;

{$R *.dfm}

procedure TFDadosgrade.bSairClick(Sender: TObject);
begin
   Close;
end;

procedure TFDadosgrade.FormActivate(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
  unidade:=Global.codigounidade;
  Q:=sqltoquery('select * from estgrades where esgr_status=''N'' and esgr_unid_codigo='+stringtosql(unidade)+
                ' and esgr_esto_codigo='+FEstoque.EdEsto_codigo.assql+
                ' and esgr_status=''N''' );
  Grid.Clear;
  EdEsto_codigo.ClearAll(Self,99);
  if Q.eof then begin
    Avisoerro('Não encontrado nenhum item da grade tamanho/cor deste codigo '+FEstoque.EdEsto_codigo.text);
    Q.close;
    Freeandnil(q);
    close;
  end else begin
    Grid.QueryToGrid(Q);
    Grid.OnClick(FDadosgrade);
    Grid.setfocus;
    EdEsto_qtdeprev.Enabled:=Global.Usuario.OutrosAcessos[0010];
    EdEsto_qtdeprev.Visible:=Global.Usuario.OutrosAcessos[0010];
    EdEsto_custoger.Visible:=Global.Usuario.OutrosAcessos[0010];
    EdEsto_customeger.Visible:=Global.Usuario.OutrosAcessos[0010];
    EdEsto_custoger.Enabled:=Global.Usuario.OutrosAcessos[0010];
    EdEsto_customeger.Enabled:=Global.Usuario.OutrosAcessos[0010];
    EdEsto_unidade.Enabled:=Global.Topicos[1242];
  end;
// 16.10.09
  FGeral.ConfiguraColorEditsNaoEnabled(FDadosgrade);
  PFinan.enabled:=false;
end;


procedure TFDadosgrade.GridClick(Sender: TObject);
//////////////////////////////////////////////////////
var Q:TSqlquery;
    cor,tamanho,copa,xqtde:integer;


    procedure GridtoEdits;
    /////////////////////////
    begin
      EdEsto_codigo.text:=FEstoque.EdEsto_codigo.text;
      EdEsto_descricao.text:=Festoque.EdEsto_descricao.text;
      EdEsto_unidade.text:=Festoque.EdEsto_unidade.text;
      EdEsto_qtde.setvalue(Q.fieldbyname('esgr_qtde').ascurrency);
      EdEsto_qtdeprev.setvalue(Q.fieldbyname('esgr_qtdeprev').ascurrency);
      Edcodtam.setvalue(tamanho);
      Edcodcor.setvalue(cor);
      Edcodcopa.setvalue(copa);
      EdDesctamanho.text:=FTamanhos.getdescricao(tamanho);
      EdDesccor.text:=FCores.getdescricao(cor);
      SetEdcopa_descricao.text:=FCopas.getdescricao(copa);
      EdEsto_codbarra.text:=Q.fieldbyname('esgr_codbarra').asstring;
      EdEsto_custo.setvalue(Q.fieldbyname('esgr_custo').ascurrency);
      EdEsto_customedio.setvalue(Q.fieldbyname('esgr_customedio').ascurrency);
      EdEsto_custoger.setvalue(Q.fieldbyname('esgr_custoger').ascurrency);
      EdEsto_customeger.setvalue(Q.fieldbyname('esgr_customeger').ascurrency);
      EdEsto_vendavis.setvalue(Q.fieldbyname('esgr_vendavis').ascurrency);
      EdEsto_dtultvenda.setdate(Q.fieldbyname('esgr_dtultvenda').asdatetime);
      EdEsto_dtultcompra.setdate(Q.fieldbyname('esgr_dtultcompra').asdatetime);
      EdMobra.setvalue(Q.fieldbyname('esgr_custoser').ascurrency);
      EdMomedio.setvalue(Q.fieldbyname('esgr_customedioser').ascurrency);
      EdPontoRessu.setvalue(Q.fieldbyname('esgr_ressuprimento').asfloat);
      EdQtdeprocesso.setvalue(Q.fieldbyname('esgr_qtdeprocesso').asfloat);
      if Global.Topicos[1242] then
         EdEsto_unidade.text:=Q.fieldbyname('esgr_unidade').asstring;

    end;

begin

  unidade:=Global.codigounidade;
  if trim(Grid.cells[Grid.getcolumn('esgr_tama_codigo'),grid.row])='' then
    exit;

    cor:=strtointdef(Grid.cells[Grid.getcolumn('esgr_core_codigo'),grid.row],0);
    tamanho:=strtointdef(Grid.cells[Grid.getcolumn('esgr_tama_codigo'),grid.row],0);
    copa:=strtointdef(Grid.cells[Grid.getcolumn('esgr_copa_codigo'),grid.row],0);
    Q:=sqltoquery( FGeral.GetSqlBuscaCodigoGrade(FEstoque.EdEsto_codigo.text,unidade,cor,tamanho,copa) );
    if Q.eof then begin
      Avisoerro('Não encontrado informações deste tamanho/cor');
    end else begin
      GridtoEdits;
    end;

end;

procedure TFDadosgrade.bAlteraritemClick(Sender: TObject);
///////////////////////////////////////////////////////////////
begin
  if ( trim(Grid.Cells[Grid.getcolumn('esgr_tama_codigo'),Grid.row])='' ) and
     ( trim(Grid.Cells[Grid.getcolumn('esgr_core_codigo'),Grid.row])='' )
    then exit;
  PFinan.enabled:=true;
  OP:='A';
  SetaEdits('A');
  if Global.Topicos[1242] then

     EdEsto_unidade.SetFocus

  else

     EdEsto_qtde.setfocus;
end;

procedure TFDadosgrade.bCancelaritemClick(Sender: TObject);
begin
  PFinan.enabled:=false;

end;

procedure TFDadosgrade.bGravarClick(Sender: TObject);
var campo:TDicionario;
    Qx:TSqlquery;
begin
  if not EdEsto_codbarra.valid then exit;
  if op='I' then begin
      Qx:=sqltoquery('select esgr_esto_codigo from estgrades where esgr_status=''N'' and esgr_esto_codigo='+EdEsto_codigo.assql+' and esgr_unid_codigo='+stringtosql(unidade)+
//                     ' and esgr_tama_codigo='+EdCodtam.assql+' and esgr_core_codigo='+Edcodcor.assql+
                     ' and ( esgr_tama_codigo='+EdCodtam.assql+' or esgr_tama_codigo is null )'  +
                     ' and ( esgr_core_codigo='+EdCodcor.assql+' or esgr_core_codigo is null )'  +
                     ' and ( esgr_copa_codigo='+EdCodcopa.assql+' or esgr_copa_codigo is null )'  )   ;
      if not Qx.eof then begin
        Avisoerro('Já existe grade deste tamanho/cor');
        Qx.Close;
        exit;
      end;
  end;

  if confirma('Confirma gravação ?') then begin
    if op='A' then begin

        Sistema.Edit('estgrades');
        Sistema.Setfield('esgr_qtde',EdEsto_qtde.ascurrency);
        Sistema.Setfield('esgr_qtdeprev',EdEsto_qtdeprev.ascurrency);
        Sistema.Setfield('esgr_codbarra',EdEsto_codbarra.text);
        Sistema.Setfield('esgr_custo',EdEsto_custo.ascurrency);
        Sistema.Setfield('esgr_customedio',EdEsto_customedio.ascurrency);
        Sistema.Setfield('esgr_custoger',EdEsto_custoger.ascurrency);
        Sistema.Setfield('esgr_customeger',EdEsto_customeger.ascurrency);
        Sistema.Setfield('esgr_vendavis',EdEsto_vendavis.ascurrency);
        Sistema.Setfield('esgr_dtultvenda',EdEsto_dtultvenda.asdate);
        Sistema.Setfield('esgr_dtultcompra',EdEsto_dtultcompra.asdate);
    // 15.04.08
        Sistema.Setfield('esgr_custoser',EdMobra.ascurrency);
        Sistema.Setfield('esgr_customedioser',EdMomedio.ascurrency);
    // 25.06.09
        campo:=Sistema.GetDicionario('estgrades','esgr_ressuprimento');
        if campo.Tipo<>'' then
          Sistema.setfield('esgr_ressuprimento',EdPontoRessu.asfloat);
    // 16.10.09
        campo:=Sistema.GetDicionario('estgrades','esgr_qtdeprocesso');
        if campo.Tipo<>'' then
         Sistema.setfield('esgr_qtdeprocesso',EdQtdeprocesso.asfloat);
// 07.02.23 - devereda
        if Global.topicos[1242] then
           Sistema.Setfield('esgr_unidade',EdEsto_unidade.text);

        Sistema.Post('esgr_status=''N'' and esgr_esto_codigo='+EdEsto_codigo.assql+' and esgr_unid_codigo='+stringtosql(unidade)+
                     ' and esgr_tama_codigo='+EdCodtam.assql+' and esgr_core_codigo='+Edcodcor.assql+
                     ' and ( esgr_copa_codigo='+EdCodcopa.assql+' or esgr_copa_codigo is null )'  )   ;
    end else begin

      Sistema.Insert('estgrades');
      Sistema.Setfield('esgr_status','N');
      Sistema.Setfield('esgr_unid_codigo',Global.codigounidade);
      Sistema.Setfield('esgr_esto_codigo',EdEsto_codigo.text);
      Sistema.Setfield('esgr_grad_codigo',0);
      Sistema.Setfield('esgr_usua_codigo',Global.usuario.codigo);
      Sistema.Setfield('esgr_tama_codigo',EdCodtam.asinteger);
      Sistema.Setfield('esgr_core_codigo',EdCodcor.asinteger);
      Sistema.Setfield('esgr_copa_codigo',EdCodcopa.asinteger);
      Sistema.Setfield('esgr_qtde',EdEsto_qtde.ascurrency);
      Sistema.Setfield('esgr_qtdeprev',EdEsto_qtdeprev.ascurrency);
      Sistema.Setfield('esgr_codbarra',EdEsto_codbarra.text);
      Sistema.Setfield('esgr_custo',EdEsto_custo.ascurrency);
      Sistema.Setfield('esgr_customedio',EdEsto_customedio.ascurrency);
      Sistema.Setfield('esgr_custoger',EdEsto_custoger.ascurrency);
      Sistema.Setfield('esgr_customeger',EdEsto_customeger.ascurrency);
      Sistema.Setfield('esgr_vendavis',EdEsto_vendavis.ascurrency);
      Sistema.Setfield('esgr_dtultvenda',EdEsto_dtultvenda.asdate);
      Sistema.Setfield('esgr_dtultcompra',EdEsto_dtultcompra.asdate);
// 07.02.23 - devereda
      if Global.topicos[1242] then
         Sistema.Setfield('esgr_unidade',EdEsto_unidade.text);
      Sistema.Post('');
    end;
    Sistema.commit;
    PFinan.enabled:=false;
    if op='I' then begin
      Q:=sqltoquery('select * from estgrades where esgr_status=''N'' and esgr_unid_codigo='+stringtosql(unidade)+
                    ' and esgr_esto_codigo='+FEstoque.EdEsto_codigo.assql );
      Grid.clear;
      Grid.QueryToGrid(Q);
      FGeral.Fechaquery(Q);
    end;

  end;

end;

procedure TFDadosgrade.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if key= #13 then begin
    if Grid.Col=Grid.getcolumn('(qtdeimpressao)') then begin
       EdEtiqueta.Top:=Grid.TopEdit;
       EdEtiqueta.Left:=Grid.LeftEdit;
       EdEtiqueta.Text:=StrToStrNumeros(Grid.Cells[Grid.Col,Grid.Row]);
  //     EdVencimento.Text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
       EdEtiqueta.Visible:=True;
       EdEtiqueta.Enabled:=True;
       EdEtiqueta.SetFocus;
    end;
//    Grid.Onclick(FDadosgrade);
  end;
end;

procedure TFDadosgrade.EdEsto_dtultcompraExitEdit(Sender: TObject);
begin
   bgravar.onclick(fdadosgrade);
   Grid.setfocus;
end;

procedure TFDadosgrade.EdEsto_codbarraValidate(Sender: TObject);
var Qcodbarra:TSqlquery;
begin
// confirmar q todos tem indice pelo codigo de barra senão criar
  if not EdEsto_codbarra.isempty then begin
    Q:=sqltoquery('select * from estoque where esto_codbarra='+EdEsto_codbarra.assql);
    if not (Q.eof) and (Q.fieldbyname('esto_codbarra').asstring<>EdEsto_codbarra.text) then begin
      EdEsto_codbarra.invalid('Codigo de barra pertence ao produto '+Q.fieldbyname('esto_codigo').asstring+' - '+Q.fieldbyname('esto_descricao').asstring);
      exit;
    end else begin
      Q:=sqltoquery('select * from estgrades where esgr_codbarra='+EdEsto_codbarra.assql+' and esgr_status=''N''');
//      if not Q.eof then begin
// 01.09.12
      if (not (Q.eof)) and (Q.fieldbyname('esgr_codbarra').asstring<>EdEsto_codbarra.text) then begin
        EdEsto_codbarra.invalid('Codigo de barra pertence ao produto com grade '+Q.fieldbyname('esgr_esto_codigo').asstring);
        exit;
      end;
    end;
  end;
end;

procedure TFDadosgrade.FormCloseQuery(Sender: TObject;   var CanClose: Boolean);
///////////////////////////////////////////////////////////////////////////////////
var xqtde,xqtdeprev:currency;
    Qx:TSqlquery;
begin
  if PFinan.Enabled then begin
    if confirma('Ajustar o estoque do produto original pelas grades ?') then begin
      Qx:=sqltoquery('select * from estgrades where esgr_status=''N'' and esgr_unid_codigo='+stringtosql(unidade)+
                    ' and esgr_esto_codigo='+FEstoque.EdEsto_codigo.assql );
      xqtde:=0;xqtdeprev:=0;
      while not Qx.eof do begin
        xqtde:=xqtde+Qx.fieldbyname('esgr_qtde').ascurrency;
        xqtdeprev:=xqtdeprev+Qx.fieldbyname('esgr_qtdeprev').ascurrency;
        Qx.Next;
      end;
      FGeral.Fechaquery(Qx);
      Sistema.Edit('estoqueqtde');
      Sistema.Setfield('esqt_qtde',xqtde);
      Sistema.Setfield('esqt_qtdeprev',xqtdeprev);
      Sistema.Post('esqt_status=''N'' and esqt_esto_codigo='+EdEsto_codigo.assql+' and esqt_unid_codigo='+stringtosql(unidade));
      try
        Sistema.commit;
      except
        Avisoerro('Estoque não atualizado.  Problemas na gravação');
      end;
    end;
  end;
end;

procedure TFDadosgrade.bincluirClick(Sender: TObject);
begin
  PFinan.enabled:=true;
  OP:='I';
  SetaEdits('I');
  if Global.Topicos[1242] then

     EdEsto_unidade.SetFocus

  else

    EdEsto_qtde.setfocus;

end;

procedure TFDadosgrade.bexcluirClick(Sender: TObject);
var Q:TSqlquery;
begin
  Q:=sqltoquery('select move_transacao,move_datamvto,move_tipomov from movestoque where move_status=''N'''+
                 ' and move_esto_codigo='+EdEsto_codigo.assql+' and move_unid_codigo='+stringtosql(unidade)+
                 ' and move_tama_codigo='+EdCodtam.assql+' and move_core_codigo='+Edcodcor.assql+
                 ' and ( move_tama_codigo='+EdCodtam.assql+' or move_tama_codigo is null )'  +
                 ' and ( move_core_codigo='+EdCodcor.assql+' or move_core_codigo is null )'  +
                 ' and ( move_copa_codigo='+EdCodcopa.assql+' or move_copa_codigo is null )'  )   ;
  if not Q.eof then begin
    Avisoerro('Existe movimentação deste tamanho/cor em '+FGeral.formatadata(Q.fieldbyname('move_datamvto').asdatetime)+' transação '+Q.fieldbyname('move_transacao').asstring) ;
    exit;
  end;
  if confirma('Confirma exclusão ?') then begin
      Sistema.Edit('estgrades');
      Sistema.Setfield('esgr_status','C');
      Sistema.Setfield('esgr_usua_codigo',Global.usuario.codigo);
      Sistema.Post('esgr_status=''N'' and esgr_esto_codigo='+EdEsto_codigo.assql+' and esgr_unid_codigo='+stringtosql(global.codigounidade)+
                   ' and esgr_tama_codigo='+EdCodtam.assql+' and esgr_core_codigo='+Edcodcor.assql+
                   ' and ( (esgr_copa_codigo='+EdCodcopa.assql+') or (esgr_copa_codigo is null) )'  )   ;
      try
        Sistema.commit;
        Grid.deleterow(Grid.row);
      except
        Avisoerro('Problemas na exclusão');
      end;
      Grid.OnClick(self);
  end;

end;

procedure TFDadosgrade.SetaEdits(operacao: string);
begin
  if Operacao='I' then begin
     EdCodtam.enabled:=true;
     EdCodcor.enabled:=true;
     EdCodcopa.enabled:=true;
     EdCodtam.setvalue(0);
     EdCodcor.setvalue(0);
     EdCodcopa.setvalue(0);
     EdEsto_qtde.setvalue(0);
     EdEsto_codbarra.text:='';
     EdEsto_codigo.text:=Arq.TEstoque.fieldbyname('Esto_codigo').asstring;
     EdEsto_descricao.text:=Arq.TEstoque.fieldbyname('Esto_descricao').asstring;
     EdEsto_unidade.text:=Arq.TEstoque.fieldbyname('Esto_unidade').asstring;
//     EdEsto_custo.setvalue(0);
//     EdEsto_customedio.setvalue(0);
//     EdEsto_vendavis.setvalue(0);
     EdEsto_dtultvenda.setdate(sistema.hoje);
     EdEsto_dtultcompra.setdate(sistema.hoje);
     EdEsto_qtdeprev.setvalue(0);
     if Global.Topicos[1242] then

       EdEsto_unidade.text := Arq.TEstoque.fieldbyname('Esto_unidade').asstring;

  end else begin
     EdCodtam.enabled:=false;
     EdCodcor.enabled:=false;
     EdCodcopa.enabled:=false;
  end;

end;

procedure TFDadosgrade.bimpcodbarragradeClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////
var sqtde,vtermica,l,i,cor,tamanho,tamanhos,cores,sqltamanho,sqlcor:string;
    MatEtiqueta:TStringlist;
    qtde:integer;
    a,nporta,nativa,nbaudrate,nstopbits,ndatabits,nparity,x,seconds,tempo,p,linha,coluna,r:integer;
    Arquivo:TextFile;
    Q:TSqlquery;
begin
  if Arq.TEstoque.isempty then exit;
  if not Arq.TEstoqueqtde.active then Arq.TEstoqueqtde.open;

//  aviso('Opção em desenvolvimento');
//exit;
////////////////////////

  Input('Digite a quantidade de etiqueta(s)','Impressão etq. cod barra',sqtde,4,false);
  if (trim(sqtde)='')  then exit;
  try
    qtde:=strtointdef(sqtde,0);
  except
    avisoerro('Quantidade informada de forma errada');
    exit;
  end;
////////////////////////



// 17.12.12- Vivan
//////////////////////////////////////
{
  tamanhos:='';
  cores:='';
  for linha:=1 to Grid.RowCount do begin
    if ( strtointdef( Grid.Cells[Grid.GetColumn('(qtdeimpressao)'),linha],0 ) >0 ) then begin
      tamanhos:=tamanhos + Grid.Cells[Grid.GetColumn('esgr_tama_codigo'),linha] + ';';
      cores:=cores+ Grid.Cells[Grid.GetColumn('esgr_core_codigo'),linha] + ';' ;
    end;
  end;
  if trim(tamanhos+cores)='' then begin
    tamanhos:=Grid.Cells[Grid.GetColumn('esgr_tama_codigo'),Grid.row];
    cores:=Grid.Cells[Grid.GetColumn('esgr_core_codigo'),Grid.row];
  end;
}
/////////////////////////////////
  sqltamanho:='';
  sqlcor:='';
  if Edcodtam.asinteger>0 then
     sqltamanho:=' and esgr_tama_codigo='+EdCodtam.assql;
  if EdCodcor.asinteger>0 then
     sqlcor:= ' and esgr_core_codigo='+EdCodcor.assql;
  if Global.Topicos[1213] then begin
  {
    FImpressao.ImprimeEtqProduto('select * from estgrades inner join estoque on (esgr_esto_codigo=esto_codigo)'+
        ' where esgr_esto_codigo='+Stringtosql(Arq.Testoque.fieldbyname('esto_codigo').asstring)+
        ' and ( esgr_tama_codigo='+EdCodtam.assql+' or esgr_tama_codigo is null )'  +
        ' and ( esgr_core_codigo='+EdCodcor.assql+' or esgr_core_codigo is null )'  +
        ' and ( esgr_copa_codigo='+EdCodcopa.assql+' or esgr_copa_codigo is null )' +
        ' and esgr_status='+Stringtosql('N'),strtoint(sqtde),1);
        }
// 04.09.12  - teste para etiqueta com 2 colunas...
    FImpressao.ImprimeEtqProduto('select * from estgrades inner join estoque on (esgr_esto_codigo=esto_codigo)'+
        ' where esgr_esto_codigo='+Stringtosql(Arq.Testoque.fieldbyname('esto_codigo').asstring)+
         sqltamanho+
         sqlcor+
// 17.12.12 - vivan
//        ' and ( '+FGeral.GetIN('esgr_tama_codigo',tamanhos,'N')+' or esgr_tama_codigo is null )'  +
//        ' and ( '+FGeral.GetIN('esgr_core_codigo',cores,'N')+' or esgr_core_codigo is null )'  +
        ' and esgr_status='+Stringtosql('N'),strtoint(sqtde),2);
//    FImpressao.Impr
//imeEtqProduto('select * from estoque where esto_codigo='+Stringtosql(Arq.Testoque.fieldbyname('esto_codigo').asstring),strtoint(sqtde),2);
    exit;
  end else if Global.Topicos[1216] then begin
    FImpressao.ImprimeEtqProduto('select * from estgrades inner join estoque on (esgr_esto_codigo=esto_codigo)'+
        ' where esgr_esto_codigo='+Stringtosql(Arq.Testoque.fieldbyname('esto_codigo').asstring)+
// 17.12.12 - vivan
//        ' and ( '+FGeral.GetIN('esgr_tama_codigo',tamanhos,'N')+' or esgr_tama_codigo is null )'  +
//        ' and ( '+FGeral.GetIN('esgr_core_codigo',cores,'N')+' or esgr_core_codigo is null )'  +
        sqltamanho +
        sqlcor +
// 05.08.13 - imprimia etiquetas a mais da 'outra unidade'..e se nao tivesse o codigo de barra...
        ' and esgr_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
        ' and esgr_status='+Stringtosql('N'),strtoint(sqtde),1,'ACBR');
//    FImpressao.ImprimeEtqProduto('select * from estoque where esto_codigo='+Stringtosql(Arq.Testoque.fieldbyname('esto_codigo').asstring),strtoint(sqtde),2);
    exit;

  end;

  MatEtiqueta:=TStringList.Create;
  if FileExists('etqbarra.txt') then MatEtiqueta.LoadFromFile('etqbarra.txt')
  else begin
    Avisoerro('Não encontrado o arquivo etqbarra.txt');
    exit;
  end;
{
  ComPort:=Comport.Create(Application);
  PortaSerial[1]:='Com1';PortaSerial[2]:='Com2';PortaSerial[3]:='Com3';PortaSerial[4]:='Com4';
  BaudRate[1]:=cbr2400;BaudRate[2]:=cbr4800;BaudRate[3]:=cbr9600;BaudRate[4]:=cbr14400;BaudRate[5]:=cbr19200;
  Parity[1]:=paNone;Parity[2]:=paOdd;Parity[3]:=paEven;Parity[4]:=paMark;Parity[5]:=paSpace;
  Stopbits[1]:=sb10;Stopbits[2]:=sb15;Stopbits[3]:=sb20;
  Databits[1]:=da8;Databits[2]:=da5;Databits[3]:=da7;Databits[4]:=da6;Databits[5]:=da4;

  nPorta:=Inteiro(GetIni('Toke','Sac','T-Porta'));
  nBaudRate:=Inteiro(GetIni('Toke','Sac','T-BaudRate'));
  nParity:=Inteiro(GetIni('Toke','Sac','T-Parity'));
  nStopBits:=Inteiro(GetIni('Toke','Sac','T-StopBits'));
  nDataBits:=Inteiro(GetIni('Toke','Sac','T-DataBits'));
  nAtiva:=Inteiro(GetIni('Toke','Sac','T-Ativa'));

   if nAtiva = 1 then begin
      ComPort.Close;
      ComPort.DeviceName	 := PortaSerial[nPorta+1];
		Try
         Try
	         ComPort.Open;
         Except
         end;
	         ComPort.Close;
      Except
         Aviso('Não foi possível abrir a impressora na porta '+ComPort.DeviceName);
         exit;
      end;
   end;
}

	If GetIni('Sac','Sac','Termica')<>''  then vTermica := GetIni('Sac','Sac','Termica');
//	else vTermica := ComPort.DeviceName;

  seconds := 5 ;   // rever
  tempo:=Seconds+3;


     AssignFile(Arquivo,'Impetq.txt');
     Rewrite(Arquivo);
     for x:=1 to qtde do begin
       for a:=0 to MatEtiqueta.Count-1 do begin
           l:=MatEtiqueta.Strings[a];
           p:=Pos('Codigo',l);
           if p>0 then l:=Copy(l,1,p-1)+Arq.Testoque.fieldbyname('esto_codigo').asstring;
// 24.09.12 - Vivan
           p:=Pos('Nome Unidade',l);
           if p>0 then l:=Copy(l,1,p-1)+FUnidades.GetReduzido(Global.CodigoUnidade);
/////////////////////
           p:=Pos('Descricao',l);
           if p>0 then l:=Copy(l,1,p-1)+Uppercase(Arq.Testoque.fieldbyname('esto_descricao').asstring);
//           if (Arq.TEstoque.fieldbyname('esto_grad_codigo').asinteger>0) and
//              Q:=sqltoquery('select * from Estgrades where esgr_status=''N'' and esgr_esto_codigo='+StringtoSql(Arq.Testoque.fieldbyname('esto_codigo').asstring)+
//                ' and esgr_unid_codigo='+Stringtosql(global.CodigoUnidade)+
//                ' and esgr_tama_codigo='+EdCodtam.assql+
//                ' and esgr_core_codigo='+EdCodcor.assql );
//             if not Q.eof then begin
               Cor:=FCores.GetDescricao(EdCodCor.asinteger);
               Tamanho:=FTamanhos.GetDescricao(EdCodtam.asinteger);
               p:=Pos('Cor',l);
               if p>0 then l:=Copy(l,1,p-1)+'Cor:'+Uppercase( Cor );
               p:=Pos('Tamanho',l);
               if p>0 then l:=Copy(l,1,p-1)+'Tam:'+Uppercase( Tamanho );
//             end;
//             Freeandnil(Q);
//           end;
           p:=Pos('Codbarra',l);
           if p>0 then l:=Copy(l,1,p-1)+Arq.Testoque.fieldbyname('esto_codbarra').asstring;
// 24.09.12 -
//           p:=Pos('[',l);  // imprimir algo fixo na etiqueta...rever...
//           if p>0 then begin
//             r:=Pos(']',l);
//             if r>0 then l:=copy(l,1,p-1) + Copy(l,p+1,r-p-1) + copy(l,r+1,100);
//           end;
           i:=i+l+#13+#10;
       end;
       Writeln(Arquivo,i);
     end;
     CloseFile(Arquivo);
     MatEtiqueta.free;

//    ComPort.Close;
//    Freeandnil(ComPort);
// criar nas configuracoes nome do compartilhamento ( micro e impressora )
    if trim( FGeral.GetConfig1AsString('Caminhocodbarra') )='' then
//      vtermica:='\\localhost\generico'
// 12.09.12
//      vtermica:='lpt1'
      vtermica:='Etiqueta.prn'
    else
      vtermica:='\\'+FGeral.GetConfig1AsString('Caminhocodbarra' )+'\'+FGeral.GetConfig1AsString('Caminhocodbarra1' );

		Try
	     AssignFile(Arquivo,vTermica);
	     Rewrite(Arquivo);
	     Write(Arquivo,i);
	     CloseFile(Arquivo);
//	     Delay(1000);
//  	     WinExec(pchar('c:\imprime.bat '),SW_SHOWMINIMIZED);
     except
       Aviso('Problemas na impressão');
     end;

end;

// 19.09.12 - vivan
procedure TFDadosgrade.betqlaserClick(Sender: TObject);
//////////////////////////////////////////////////////////
var qtde,colunas,linha:integer;
    sqtde,scolunas,tamanhos,cores:string;
begin
  if Arq.TEstoque.isempty then exit;
  if not Arq.TEstoqueqtde.active then Arq.TEstoqueqtde.open;

//  sqtde:='';
//  Input('Digite a quantidade de etiqueta(s)','Impressão etq. cod barra',sqtde,4,false);
//  if (trim(sqtde)='')  then exit;
//  try
//    qtde:=strtointdef(sqtde,0);
//  except
//    avisoerro('Quantidade informada de forma errada');
//    exit;
//  end;
  scolunas:='';
  Input('Digite a quantidade de colunas','Colunas',scolunas,4,false);
  if (trim(scolunas)='')  then exit;
  try
    colunas:=strtointdef(scolunas,0);
  except
    avisoerro('Quantidade de colunas informada de forma errada');
    exit;
  end;
  tamanhos:='';
  cores:='';
  for linha:=1 to Grid.RowCount do begin
    if ( strtointdef( Grid.Cells[Grid.GetColumn('(qtdeimpressao)'),linha],0 ) >0 ) then begin
      tamanhos:=tamanhos + Grid.Cells[Grid.GetColumn('esgr_tama_codigo'),linha] + ';';
      cores:=cores+ Grid.Cells[Grid.GetColumn('esgr_core_codigo'),linha] + ';' ;
    end;
  end;

  if ( trim(tamanhos)<>'' ) and ( trim(cores)<>'' ) then
    FImpressao.ImprimeEtqProduto('select * from estgrades inner join estoque on (esgr_esto_codigo=esto_codigo)'+
//        ' where '+FGeral.Getin('esgr_esto_codigo',Arq.Testoque.fieldbyname('esto_codigo').asstring,'C')+
        ' where '+FGeral.Getin('esgr_esto_codigo',Arq.Testoque.fieldbyname('esto_codigo').asstring,'C')+
        ' and ( '+FGeral.GetIN('esgr_tama_codigo',tamanhos,'N')+' or esgr_tama_codigo is null )'  +
        ' and ( '+FGeral.GetIN('esgr_core_codigo',cores,'N')+' or esgr_core_codigo is null )'  +
//        ' and ( esgr_tama_codigo='+EdCodtam.assql+' or esgr_tama_codigo is null )'  +
//        ' and ( esgr_core_codigo='+EdCodcor.assql+' or esgr_core_codigo is null )'  +
//        ' and ( esgr_copa_codigo='+EdCodcopa.assql+' or esgr_copa_codigo is null )' +
        ' and esgr_status='+Stringtosql('N'),3,strtoint(scolunas),'L')
  else
    FImpressao.ImprimeEtqProduto('select * from estgrades inner join estoque on (esgr_esto_codigo=esto_codigo)'+
//        ' where '+FGeral.Getin('esgr_esto_codigo',Arq.Testoque.fieldbyname('esto_codigo').asstring,'C')+
        ' where '+FGeral.Getin('esgr_esto_codigo',Arq.Testoque.fieldbyname('esto_codigo').asstring,'C')+
//        ' and ( esgr_tama_codigo='+EdCodtam.assql+' or esgr_tama_codigo is null )'  +
//        ' and ( esgr_core_codigo='+EdCodcor.assql+' or esgr_core_codigo is null )'  +
        ' and esgr_status='+Stringtosql('N'),3,strtoint(scolunas),'L');


end;

procedure TFDadosgrade.edEtiquetaExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
  Grid.Cells[Grid.Col,Grid.Row]:=EdEtiqueta.Text;
  Grid.SetFocus;
  EdEtiqueta.Visible:=False;

end;

end.
