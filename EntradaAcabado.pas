unit EntradaAcabado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr ;

type
  TFEntradaAcabado = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bExcluir: TSQLBtn;
    bbaixar: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    edqtdeproduzida: TSQLEd;
    PAcerto: TSQLPanelGrid;
    bmarcatodos: TSQLBtn;
    bdesmarcatodos: TSQLBtn;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdData: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdtipoEstoque: TSQLEd;
    Ednroobra: TSQLEd;
    Edtipo_codigo: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    psaidas: TSQLPanelGrid;
    Grids: TSqlDtGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    bapagasaida: TSQLBtn;
    bfechasaida: TSQLBtn;
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure edqtdeproduzidaExitEdit(Sender: TObject);
    procedure edqtdeproduzidaValidate(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure GridDblClick(Sender: TObject);
    procedure bbaixarClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bapagasaidaClick(Sender: TObject);
    procedure bfechasaidaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute();
  end;

var
  FEntradaAcabado: TFEntradaAcabado;
  xTipocad:string;

implementation

uses geral, Sqlfun, Sqlsis , Arquiv, Estoque, Unidades,
  cadcor, tamanhos;


{$R *.dfm}

{ TFEntradaAcabado }

procedure TFEntradaAcabado.Execute;
////////////////////////////////////////
var Q:TSqlquery;
    Lista:TStringlist;
    sqlperiodo:string;
begin
   EdTipoEstoque.Clearall(FEntradaAcabado,99);
   EdUNid_codigo.text:=global.codigounidade;
   EdUnid_codigo.validfind;
   EdData.setdate(sistema.hoje);
   Grid.clear;
   FGeral.SetaTiposdeEstoque(EdTipoestoque);
   EdNumerodoc.Items.Clear;
   if not Arq.TEstoque.active then Arq.TEstoque.Open;
   xTipocad:='C';
   Lista:=TStringlist.create;

     if Sistema.getperiodo('Informe periodo para filtrar pesquisa das obras') then
       sqlperiodo:=' and moes_datamvto>='+Datetosql(Sistema.datai)+' and moes_datamvto<='+Datetosql(Sistema.Dataf)
     else
       sqlperiodo:='';
     Q:=sqltoquery('select movesto.*,clie_razaosocial,clie_nome from movesto'+
                   ' inner join clientes on ( clie_codigo=moes_tipo_codigo )'+
//                   ' where moes_status=''R'''+
                   ' where moes_status=''N'''+
                   ' and moes_unid_codigo='+stringtosql(Global.codigounidade)+
//                   ' and moes_tipomov='+stringtosql(Global.CodRequisicaoAlmox)+
                   ' and moes_tipomov='+stringtosql(Global.CodContrato)+
                   sqlperiodo+
                   ' order by clie_razaosocial');
     while not Q.eof do begin
       if Lista.IndexOf(Q.fieldbyname('moes_numerodoc').AsString)=-1 then begin
         EdNumerodoc.Items.Add(strspace(Q.fieldbyname('moes_numerodoc').AsString,9)+' - '+FGeral.formatadata(Q.fieldbyname('moes_dataemissao').AsDatetime)+
                             ' - '+Q.fieldbyname('clie_razaosocial').AsString );
         Lista.Add(Q.fieldbyname('moes_numerodoc').AsString);
       end;
//                             ' - '+Q.fieldbyname('clie_nome').AsString );
       Q.Next;
     end;

   Lista.free;
   FGeral.EstiloForm(FEntradaAcabado);
   Show;
//   SetaItensConsulta(EdTipoConsulta);
   EdTipoEstoque.setfocus;

end;

procedure TFEntradaAcabado.EdNumeroDocValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    i:integer;
    sqltipo,status,sqlconsulta,peaousac:string;
    jabaixado:currency;

begin

   if EdNUmerodoc.IsEmpty then exit;
   sqltipo:=' and movo_tipomov='+stringtosql(Global.CodItemObra);
   status:='N';
   sqlconsulta:=' and movo_status=''N''';
   Q:=sqltoquery('select * from movobrasdet'+
                 ' inner join estoque on ( esto_codigo=movo_esto_codigo )'+
//                 ' left join cores on ( core_codigo=move_core_codigo )'+
//                 ' left join tamanhos on ( tama_codigo=move_tama_codigo )'+
                 ' where movo_numerodoc='+EdNumerodoc.assql+
                 ' and movo_unid_codigo='+EdUnid_codigo.assql+
                 ' and movo_status<>''C'''+
                 sqltipo+sqlconsulta+
                 ' order by movo_esto_codigo,movo_operacao');
   Grid.clear;
   peaousac:='P';
   if not Q.eof then begin
//     EdNroobra.text:=EdNumerodoc.Text
     EdNroobra.text:=Q.fieldbyname('movo_numerodoc').AsString;
     Edtipo_codigo.Text:=Q.fieldbyname('movo_tipo_codigo').AsString;
     EdTipo_codigo.validfind;
   end else begin
     EdNroobra.text:=EdNumerodoc.Text;
     Edtipo_codigo.Text:='';
   end;
   i:=1;
{  - 04.12.14 - desativado
// 03.12.14 - se nao veio do pea dai busca os produtos acabados do pedido/os no sac
   if Q.Eof then begin
     fGeral.FechaQuery(Q);
     sqltipo:=' and '+FGeral.GetIN('move_tipomov',Global.CodContrato+';'+Global.CodContratoNota,'C');
     status:='N';
     sqlconsulta:=' and move_status=''N''';
     peaousac:='S';
     Q:=sqltoquery('select * from movestoque'+
                   ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                   ' where move_numerodoc='+EdNumerodoc.assql+
                   ' and move_unid_codigo='+EdUnid_codigo.assql+
                   sqltipo+sqlconsulta+
                   ' order by move_esto_codigo,move_operacao');

   end;
}
   while not Q.Eof do begin
     if peaousac='P' then begin
       Grid.Cells[Grid.getcolumn('move_esto_codigo'),i]:=Q.fieldbyname('movo_esto_codigo').asstring;
       Grid.Cells[Grid.getcolumn('esto_descricao'),i]:=Q.fieldbyname('esto_descricao').asstring;
       Grid.Cells[Grid.getcolumn('esto_referencia'),i]:=Q.fieldbyname('esto_referencia').asstring;
//       Grid.Cells[Grid.getcolumn('core_descricao'),i]:=FCores.GetDescricao(Q.fieldbyname('move_core_codigo').asinteger);
       Grid.Cells[Grid.getcolumn('move_qtderetorno'),i]:=Valortosql(Q.fieldbyname('movo_qtdeop').ascurrency);
       Grid.Cells[Grid.getcolumn('move_qtde'),i]:=Valortosql(Q.fieldbyname('movo_qtdeop').ascurrency-Q.fieldbyname('movo_qtdeprod').ascurrency);
       Grid.Cells[Grid.getcolumn('move_operacao'),i]:=Q.fieldbyname('movo_operacao').asstring;
       Grid.Cells[Grid.getcolumn('move_transacao'),i]:=Q.fieldbyname('movo_transacao').asstring;
//       Grid.Cells[Grid.getcolumn('move_core_codigo'),i]:=Q.fieldbyname('move_core_codigo').asstring;
//       Grid.Cells[Grid.getcolumn('tama_descricao'),i]:=FTamanhos.GetDescricao(Q.fieldbyname('move_tama_codigo').asinteger);
//       Grid.Cells[Grid.getcolumn('move_tama_codigo'),i]:=Q.fieldbyname('move_tama_codigo').asstring;
       Grid.Cells[Grid.getcolumn('qtdejabaixada'),i]:=Q.fieldbyname('movo_qtdeprod').asstring;
       EdTipo_codigo.setvalue(Q.fieldbyname('movo_tipo_codigo').asinteger);
//       if Q.fieldbyname('move_status').asstring='N' then
//          Grid.Cells[Grid.getcolumn('marcado'),i]:='Ok';
       Grid.Cells[Grid.getcolumn('esto_unidade'),i]:=Q.fieldbyname('esto_unidade').asstring;
    end else begin
       Grid.Cells[Grid.getcolumn('move_esto_codigo'),i]:=Q.fieldbyname('move_esto_codigo').asstring;
       Grid.Cells[Grid.getcolumn('esto_descricao'),i]:=Q.fieldbyname('esto_descricao').asstring;
       Grid.Cells[Grid.getcolumn('esto_referencia'),i]:=Q.fieldbyname('esto_referencia').asstring;
       Grid.Cells[Grid.getcolumn('move_qtderetorno'),i]:=Valortosql(Q.fieldbyname('move_qtde').ascurrency);
       Grid.Cells[Grid.getcolumn('move_qtde'),i]:=Valortosql(Q.fieldbyname('move_qtde').ascurrency);
       Grid.Cells[Grid.getcolumn('move_operacao'),i]:=Q.fieldbyname('move_operacao').asstring;
       Grid.Cells[Grid.getcolumn('move_transacao'),i]:=Q.fieldbyname('move_transacao').asstring;
       Grid.Cells[Grid.getcolumn('qtdejabaixada'),i]:=Q.fieldbyname('move_qtderetorno').asstring;
       EdTipo_codigo.setvalue(Q.fieldbyname('move_tipo_codigo').asinteger);
       Grid.Cells[Grid.getcolumn('esto_unidade'),i]:=Q.fieldbyname('esto_unidade').asstring;
    end;
    Grid.AppendRow;
    inc(i);

    Q.Next;
   end;
   FGeral.FechaQuery(Q);
end;

procedure TFEntradaAcabado.edqtdeproduzidaExitEdit(Sender: TObject);
begin

  if ( (EdQtdeproduzida.ascurrency+texttovalor(Grid.Cells[Grid.getcolumn('qtdejabaixada'),Grid.row])) <=
       texttovalor(Grid.Cells[Grid.getcolumn('move_qtderetorno'),Grid.row]) )
     and (EdQtdeproduzida.ascurrency>0)
       then begin
    Grid.Cells[Grid.Col,Grid.Row]:=Transform(EdQtdeproduzida.AsFloat,f_cr);
    Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='Ok';
  end;
  Grid.SetFocus;
  EdQtdeproduzida.Visible:=False;

end;

procedure TFEntradaAcabado.edqtdeproduzidaValidate(Sender: TObject);
begin
   if (EdQtdeproduzida.ascurrency+texttovalor(Grid.Cells[Grid.getcolumn('qtdejabaixada'),Grid.row])) >
       texttovalor(Grid.Cells[Grid.getcolumn('move_qtderetorno'),Grid.row]) then begin
       Aviso('Atenção.   Quantidade maior que a prevista a ser produzida');
   end;

end;

procedure TFEntradaAcabado.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    Grid.OnDblClick(self);

end;

procedure TFEntradaAcabado.GridDblClick(Sender: TObject);
begin
  if Grid.Getcolumn('move_qtde')=Grid.col then begin

     EdQtdeproduzida.Top:=Grid.TopEdit;
     EdQtdeproduzida.Left:=Grid.LeftEdit+5;
//     EdQtdebaixa.Text:=StrToStrNumeros(Grid.Cells[Grid.Col,Grid.Row]);
//     EdQtdebaixa.setvalue(TextToValor(Grid.Cells[Grid.Col,Grid.Row]));
     EdQtdeproduzida.text:=Grid.Cells[Grid.Col,Grid.Row];
     EdQtdeproduzida.Visible:=True;
     EdQtdeproduzida.SetFocus;

  end else if ( Grid.col=Grid.getcolumn('marcado') ) and (Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row]<>'') then begin
     if Grid.cells[Grid.getcolumn('marcado'),Grid.row]='Ok' then begin
       Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='';
     end else begin
       Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='Ok';
     end;
   end;

end;

////////////////////////////////////////////////////////////////////////
procedure TFEntradaAcabado.bbaixarClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////
var i,codcor,codtamanho:integer;
    operacao,transacao,transacaoentrada,codestoque,sqlcor,sqltamanho:string;
    qtde:currency;
    Q,QGrade:TSqlquery;
    usougrade:boolean;



    procedure GravaMestreEntradaAcabado;
    begin
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacaoentrada);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',EdNumerodoc.asinteger);
      Sistema.SetField('moes_tipomov',Global.CodEntradaAcabado);
      Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('moes_estado',Global.UFUnidade);
      Sistema.SetField('moes_tipo_codigo',EdTipo_codigo.AsInteger);
      Sistema.SetField('moes_tipocad',xTipoCad);
      Sistema.SetField('moes_cida_codigo',EdUNid_codigo.ResultFind.fieldbyname('unid_cida_codigo').AsInteger);
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',Sistema.Hoje);
      Sistema.SetField('moes_DataCont',Sistema.Hoje);
      Sistema.SetField('moes_dataemissao',Sistema.Hoje);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.SetField('moes_nroobra',EdNroobra.text);
//      Sistema.SetField('moes_pesoliq',pesoliq);
//      Sistema.SetField('moes_pesobru',pesobru);
      Sistema.Post();
    end;

    procedure GravaDetalheEntradaAcabado;
    var Qe:TSqlquery;
    begin
      Qe:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),i]));
      Sistema.Insert('movestoque');                    
      Sistema.SetField('move_esto_codigo',Grid.cells[Grid.getcolumn('move_esto_codigo'),i]);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_transacao',transacaoentrada);
      Sistema.SetField('move_unid_codigo',EdUNid_codigo.text);
//      Sistema.SetField('move_core_codigo',texttovalor(Grid.cells[Grid.getcolumn('move_core_codigo'),i]) );
//      Sistema.SetField('move_tama_codigo',texttovalor(Grid.cells[Grid.getcolumn('move_tama_codigo'),i]) );
      Sistema.SetField('move_qtde',texttovalor(Grid.cells[Grid.getcolumn('move_qtde'),i]));
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_tipo_codigo',EdTipo_codigo.asinteger);
      Sistema.SetField('move_tipocad',xTipoCad);
      Sistema.SetField('move_numerodoc',EdNumerodoc.asinteger);
      Sistema.SetField('move_tipomov',Global.CodEntradaAcabado);
      Sistema.SetField('move_datalcto',sistema.hoje);
      Sistema.SetField('move_datamvto',EdData.asdate);
      Sistema.SetField('move_datacont',EdData.asdate);
      Sistema.SetField('move_usua_codigo',Global.Usuario.Codigo);
      Sistema.SetField('move_grup_codigo',Qe.fieldbyname('esto_grup_codigo').asinteger);
      Sistema.SetField('move_sugr_codigo',Qe.fieldbyname('esto_sugr_codigo').asinteger);
      Sistema.SetField('move_fami_codigo',Qe.fieldbyname('esto_fami_codigo').asinteger);
      Sistema.SetField('move_locales',EdTipoestoque.text);
      Sistema.SetField('move_nroobra',EdNroobra.text);
// grava operacao aqui para pode extornar a qtde produzida no movobrasdet
      Sistema.SetField('move_devolucoes',Grid.cells[Grid.getcolumn('move_operacao'),i]);
//      Sistema.SetField('move_pecas',texttovalor(Grid.cells[Grid.getcolumn('move_pecas'),i]));
      Sistema.post;

      FGeral.FechaQuery(Qe);
    end;


begin

   if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),1])='' then exit;
   if not confirma('Confirma a produção dos itens marcados ?') then exit;
   transacaoentrada:=FGeral.GetTransacao;
   Sistema.BeginProcess('Gravando a produção dos itens marcados');
   for i:=1 to Grid.RowCount do begin
     operacao:=Grid.cells[Grid.getcolumn('move_operacao'),i];
     transacao:=Grid.cells[Grid.getcolumn('move_transacao'),i];
     qtde:=texttovalor(Grid.cells[Grid.getcolumn('move_qtde'),i]);
     codcor:=strtointdef(Grid.cells[Grid.getcolumn('move_core_codigo'),i],0);
     codtamanho:=strtointdef(Grid.cells[Grid.getcolumn('move_tama_codigo'),i],0);
     codestoque:=Grid.cells[Grid.getcolumn('move_esto_codigo'),i];
     Q:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                   ' and esqt_esto_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),i])+
                   ' and esqt_status=''N''');
     if ( trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),i])<>'' ) and
         ( Grid.cells[Grid.getcolumn('marcado'),i]='Ok' )
       then begin

       Sistema.Edit('movobrasdet');
       Sistema.setfield('movo_qtdeprod',qtde+texttovalor(Grid.cells[Grid.getcolumn('qtdejabaixada'),i]));
       Sistema.setfield('movo_usua_codigo',Global.Usuario.Codigo);
       Sistema.Post('movo_operacao='+stringtosql(operacao));
       FGeral.MovimentaQtdeEstoque( Grid.cells[Grid.getcolumn('move_esto_codigo'),i] ,EdUnid_codigo.text,'E',Global.codEntradaAcabado,qtde,Q);
       GravaMestreEntradaAcabado;
       GravaDetalheEntradaAcabado;

       usougrade:=(Codcor+Codtamanho)>0;
       if usougrade then begin
          if Codcor>0 then
            sqlcor:=' and esgr_core_codigo='+inttostr(Codcor)
          else
            sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
          if Codtamanho>0 then
            sqltamanho:=' and esgr_tama_codigo='+inttostr(Codtamanho)
          else
            sqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
          QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(codestoque)+
                        ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
          FGeral.MovimentaQtdeEstoqueGrade( Grid.cells[Grid.getcolumn('move_esto_codigo'),i] ,EdUnid_codigo.text,'S',Global.codrequisicaoalmox,codcor,codtamanho,0,qtde,QGrade);
          FGeral.FechaQuery(QGrade);
       end;
     end;
     FGeral.FechaQuery(Q);
   end;
   try
     Sistema.commit;
     Sistema.endprocess('Gravado a produção dos itens marcados');
     Grid.clear;
     EdTipoEstoque.SetFocus;
   except
     Sistema.endprocess('Não foi possível efetuar a gravação');
   end;
end;

procedure TFEntradaAcabado.bExcluirClick(Sender: TObject);
var produto,sqltam,sqlcor:string;
    Q:TSqlquery;
    i:integer;
begin
   if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row])='' then exit;
   produto:=Grid.cells[Grid.getcolumn('move_esto_codigo'),grid.row];
   sqltam:='';
   if trim(Grid.cells[Grid.getcolumn('move_tama_codigo'),Grid.row])<>'' then
     sqltam:=' and move_tama_codigo='+Grid.cells[Grid.getcolumn('move_tama_codigo'),Grid.row];
   sqlcor:='';
   if trim(Grid.cells[Grid.getcolumn('move_core_codigo'),Grid.row])<>'' then
     sqlcor:=' and move_core_codigo='+Grid.cells[Grid.getcolumn('move_core_codigo'),Grid.row];
   Q:=sqltoquery('select move_tipomov,move_qtde,move_operacao,move_datamvto,move_transacao from movestoque'+
                 ' where move_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                 ' and move_esto_codigo='+stringtosql(produto)+
                 ' and move_devolucoes='+Stringtosql(Grid.cells[Grid.getcolumn('move_operacao'),Grid.row])+
                 sqltam+sqlcor+' and '+fGeral.GetIN('move_tipomov',Global.CodEntradaAcabado,'C')+
                 ' and move_status=''N'' and move_numerodoc='+EdNumerodoc.assql);
   if Q.eof then begin
     Avisoerro('Não encontrado movimento de entrada de prod. acabado');
     FGeral.FechaQuery(Q);
     exit;
   end;
   Grids.Clear;i:=1;
   while not Q.eof do begin
     Grids.cells[Grids.getcolumn('move_tipomov'),i]:=Q.fieldbyname('move_tipomov').asstring;
     Grids.cells[Grids.getcolumn('move_datamvto'),i]:=Q.fieldbyname('move_datamvto').asstring;
     Grids.cells[Grids.getcolumn('move_qtde'),i]:=Q.fieldbyname('move_qtde').asstring;
     Grids.cells[Grids.getcolumn('move_operacao'),i]:=Q.fieldbyname('move_operacao').asstring;
     Grids.cells[Grids.getcolumn('move_transacao'),i]:=Q.fieldbyname('move_transacao').asstring;
     Grids.AppendRow;
     inc(i);
     Q.Next;
   end;
   FGEral.FechaQuery(Q);
   psaidas.visible:=true;
   psaidas.enabled:=true;
   Grids.setfocus;
end;

procedure TFEntradaAcabado.bapagasaidaClick(Sender: TObject);
var operacao,sqlcor,sqltamanho:string;
    movestoque,usougrade:boolean;
    codcor,codtamanho:integer;
    Q,QGrade,QMovEstoque:TSqlquery;
    qtde:currency;
begin
   if trim(Grids.cells[Grids.getcolumn('move_operacao'),Grids.row])='' then exit;
   if not confirma('Confirma EXCLUSÃO do item escolhido ?') then exit;
//   movestoque:=confirma('Retorna a quantidade ao estoque ?');
   movestoque:=true;
   qtde:=texttovalor(Grids.cells[Grids.getcolumn('move_qtde'),Grids.row]);
//   codcor:=strtointdef( Grid.Cells[Grid.getcolumn('move_core_codigo'),Grid.row] ,0);
//   codtamanho:=strtointdef( Grid.Cells[Grid.getcolumn('move_tama_codigo'),Grid.row] ,0);
   codcor:=0;
   codtamanho:=0;
   if (codcor>0) or (codtamanho>0) then
     usougrade:=true
   else
     usougrade:=false;
   sqlcor:='';sqltamanho:='';
   if codcor>0 then
     sqlcor:=' and move_core_codigo='+inttostr(codcor);
   if codtamanho>0 then
     sqltamanho:=' and move_tama_codigo='+inttostr(codtamanho);
   Sistema.BeginProcess('Excluindo');
   operacao:=Grids.cells[Grids.getcolumn('move_operacao'),Grids.row];
   QMovestoque:=sqltoquery('select * from movestoque'+
                            ' inner join movesto on ( moes_transacao=move_transacao and moes_status=move_status )'+
                            ' where move_operacao='+Stringtosql(operacao)+
                            ' and '+FGeral.Getin('move_status','N;D;E','C')+
                            ' order by move_status,move_numerodoc,move_tipomov');

   Sistema.Edit('movestoque');
   Sistema.setfield('move_status','C');
   Sistema.setfield('move_usua_codigo',Global.Usuario.Codigo);
   Sistema.Post('move_operacao='+stringtosql(operacao));

   if Movestoque then begin
     Q:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                   ' and esqt_esto_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row])+
                   ' and esqt_status=''N''');
     FGeral.MovimentaQtdeEstoque( Grid.cells[Grid.getcolumn('move_esto_codigo'),grid.row],EdUnid_codigo.text,'S',Global.codSaidaalmox,qtde,Q);
     if usougrade then begin
          sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
          sqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
          if (codcor>0) and (codtamanho>0) then begin
              sqlcor:=' and esgr_core_codigo='+inttostr(codcor);
              sqltamanho:=' and esgr_tama_codigo='+inttostr(codtamanho);
          end else if (codcor>0) then begin
              sqlcor:=' and esgr_core_codigo='+inttostr(codcor);
          end else if (codtamanho>0) then begin
              sqltamanho:=' and esgr_tama_codigo='+inttostr(codtamanho);
          end;
          QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row])+
                 ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
          FGeral.MovimentaQtdeEstoqueGrade(Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row],EdUnid_codigo.Text,'S',Global.codSaidaalmox,codcor,codtamanho,0,qtde,QGrade,qtde,0);
          FGeral.FechaQuery(QGrade);
     end;
     FGeral.FechaQuery(Q);
      if QMOvestoque.fieldbyname('move_core_codigo').asinteger>0 then
        sqlcor:=' and movo_core_codigo='+QMOvestoque.fieldbyname('move_core_codigo').asstring
      else
        sqlcor:=' and ( movo_core_codigo=0 or movo_core_codigo is null )';
      if QMOvestoque.fieldbyname('move_tama_codigo').asinteger>0 then
        sqltamanho:=' and movo_tama_codigo='+QMOvestoque.fieldbyname('move_tama_codigo').asstring
      else
        sqltamanho:=' and ( movo_tama_codigo=0 or movo_tama_codigo is null )';
      Q:=sqltoquery('select movo_qtdeprod from movobrasdet'+
                   ' where movo_numerodoc='+QMovestoque.fieldbyname('moes_numerodoc').asstring+
                   ' and movo_status=''N'' and movo_tipo_codigo='+QMOvestoque.fieldbyname('move_tipo_codigo').asstring+
                   ' and movo_esto_codigo='+stringtosql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
                   ' and movo_unid_codigo='+stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring)+
                   ' and movo_tipomov='+Stringtosql(Global.CodItemObra)+
                   ' and movo_operacao='+stringtosql(QMOvestoque.fieldbyname('move_devolucoes').asstring)+
                   sqlcor+
                   sqltamanho );
      if not Q.eof then begin
        Sistema.Edit('movobrasdet');
        Sistema.setfield('movo_qtdeprod',Q.fieldbyname('movo_qtdeprod').ascurrency-QMovestoque.fieldbyname('move_qtde').ascurrency);
        Sistema.post('movo_numerodoc='+QMovestoque.fieldbyname('moes_numerodoc').asstring+
                     ' and movo_status=''N'' and movo_tipo_codigo='+QMOvestoque.fieldbyname('move_tipo_codigo').asstring+
                     ' and movo_esto_codigo='+stringtosql(QMOvestoque.fieldbyname('move_esto_codigo').asstring)+
                     ' and movo_unid_codigo='+stringtosql(QMOvestoque.fieldbyname('move_unid_codigo').asstring)+
                     ' and movo_tipomov='+Stringtosql(Global.CodItemObra)+
                     ' and movo_operacao='+stringtosql(QMOvestoque.fieldbyname('move_devolucoes').asstring)+
                     sqlcor+
                     sqltamanho );
     end;
     FGeral.FechaQuery(Q);

   end;
   try
     Grids.DeleteRow(Grid.Row);
     sistema.commit;
     Sistema.EndProcess('Estorno gravado');
     bfechasaidaclick(self);
   except
     Sistema.EndProcess('Não foi possível gravar');
   end;

end;

procedure TFEntradaAcabado.bfechasaidaClick(Sender: TObject);
begin
   psaidas.visible:=false;
   psaidas.enabled:=false;
   Grid.setfocus;

end;

end.
