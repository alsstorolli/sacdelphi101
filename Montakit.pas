unit Montakit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr;

type
  TFMontagemkit = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bExcluiritem: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PAcerto: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdData: TSQLEd;
    EdNumeroDoc: TSQLEd;
    PIns: TSQLPanelGrid;
    EdEsto_codigo: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    bgravar: TSQLBtn;
    EdMovimento: TSQLEd;
    EdCusto: TSQLEd;
    EdCustoent: TSQLEd;
    procedure Edunid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdDataValidate(Sender: TObject);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure EdEsto_codigoValidate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure bExcluiritemClick(Sender: TObject);
    procedure EdMovimentoExitEdit(Sender: TObject);
    procedure bgravarClick(Sender: TObject);
    procedure EdMovimentoValidate(Sender: TObject);
    procedure EdEsto_codigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure SetaEdits;
  end;

var
  FMontagemkit: TFMontagemkit;
  Q,QEstoque:TSqlquery;
  custo,customedio,customeger,custoant,customedioant,customegerant,custogerant,custoger:currency;

implementation

uses Geral, Sqlsis, Sqlfun, munic, Estoque, Grades;

{$R *.dfm}

procedure TFMontagemkit.Edunid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.Limpaedit(EdUnid_codigo,key);

end;

procedure TFMontagemkit.EdDataValidate(Sender: TObject);
begin
  if not FGeral.validamvto(EdData) then
    EdData.INvalid('');

end;

procedure TFMontagemkit.EdNumeroDocValidate(Sender: TObject);
begin
  if EdNumerodoc.isempty then
     EdNumerodoc.setvalue(FGEral.Getcontador('MONTAGEMKIT',false))
  else begin
    Sistema.beginprocess('Checando montagem nesta data');
    Q:=sqltoquery('select * from movestoque inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
            ' inner join estoque on (esto_codigo=move_esto_codigo)'+
            ' where move_status=''N'' and '+FGeral.GetIn('move_tipomov',Global.CodMontagemKitE+';'+Global.CodMontagemKitS,'C')+
            ' and move_datamvto='+EdData.AsSql+' and move_unid_codigo='+EdUnid_codigo.AsSql+
            ' and move_numerodoc='+EdNUmerodoc.AsSql );
    Grid.Clear;
    Sistema.endprocess('');
    if not Q.eof then
      Grid.QueryToGrid(Q);
    SetaEdits;
    Q.close;
    Freeandnil(Q);
  end;
end;

procedure TFMontagemkit.EdEsto_codigoValidate(Sender: TObject);
var p:integer;
begin
  QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdEsto_codigo.AsSql+
                ' and esqt_unid_codigo='+EdUnid_codigo.AsSql);
// 18.08.05
  if QEstoque.eof then begin
    EdEsto_codigo.invalid('Codigo ainda não cadastrado nesta unidade');
    exit;
  end;

  p:=FGeral.ProcuraGrid(0,EdEsto_codigo.text,Grid);
  if p>0 then
    EdEsto_codigo.Invalid('Codigo já digitado nesta unidade neste dia')
  else begin
    EdQTde.setvalue(FGeral.QualQtde(Global.Usuario.Codigo,QEstoque.fieldbyname('esqt_qtde').Ascurrency,QEstoque.fieldbyname('esqt_qtdeprev').Ascurrency));
    if EdQTde.ascurrency<0 then
      EdEsto_codigo.Invalid('Quantidade em estoque negativa')
  end;

end;

procedure TFMontagemkit.bIncluirClick(Sender: TObject);
begin
  if EdUnid_codigo.isempty then exit;
  if EdNumerodoc.isempty then exit;
  if EdDAta.isempty then exit;
  Pins.Visible:=true;
  bSair.Enabled:=false;
  bGravar.Enabled:=false;
  bexcluiritem.enabled:=false;
  PAcerto.Enabled:=false;
  EdEsto_codigo.SetFocus;

end;

procedure TFMontagemkit.bCancelarClick(Sender: TObject);
begin
  Pins.Visible:=false;
  bSair.Enabled:=true;
  bGravar.Enabled:=true;
  bexcluiritem.enabled:=true;
  PAcerto.Enabled:=true;
  EdNumerodoc.SetFocus;

end;

procedure TFMontagemkit.bExcluiritemClick(Sender: TObject);
var codestoque:string;
begin
  if PIns.Visible then exit;
  if Grid.RowCount<2 then exit;
  codestoque:=Grid.Cells[grid.getcolumn('move_esto_codigo'),Grid.row];
  if trim(codestoque)<>'' then begin
      Grid.DeleteRow(grid.Row);
  end;

end;

procedure TFMontagemkit.EdMovimentoExitEdit(Sender: TObject);
var tipoMovimento,EntSai:string;


   procedure EditstoGrid;
   var x:integer;
   begin
      x:=FGeral.ProcuraGrid(0,EdEsto_codigo.Text,Grid);
      if x=0 then begin
        if trim(Grid.Cells[0,1])<>'' then begin
          Grid.RowCount:=Grid.RowCount+1;
          x:=Grid.RowCount-1;
        end else
          x:=1;
        Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdEsto_codigo.Text;
        Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=EdEsto_codigo.ResultFind.fieldbyname('esto_descricao').asstring;
        Grid.Cells[Grid.getcolumn('move_qtde'),x]:=EdQTde.assql;
        if EdMovimento.text='E' then begin
          Grid.Cells[Grid.getcolumn('move_tipomov'),x]:=Global.CodMontagemkitE;
        end else begin
          Grid.Cells[Grid.getcolumn('move_tipomov'),x]:=Global.CodMontagemkitS;
        end;
        Grid.Cells[Grid.getcolumn('move_custo'),x]:=floattostr( Festoque.GetCusto(EdEsto_codigo.text,EdUnid_codigo.text,'custo') );
        Grid.Cells[Grid.getcolumn('move_custoger'),x]:=floattostr( Festoque.GetCusto(EdEsto_codigo.text,EdUnid_codigo.text,'custoger') );
        Grid.Cells[Grid.getcolumn('move_customedio'),x]:=floattostr( Festoque.GetCusto(EdEsto_codigo.text,EdUnid_codigo.text,'medio') );
        Grid.Cells[Grid.getcolumn('move_customeger'),x]:=floattostr( Festoque.GetCusto(EdEsto_codigo.text,EdUnid_codigo.text,'medioger') );
      end else begin
        Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdEsto_codigo.Text;
        Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=EdEsto_codigo.ResultFind.fieldbyname('esto_descricao').asstring;
        Grid.Cells[Grid.getcolumn('move_qtde'),x]:=EdQTde.assql;
        if EdMovimento.text='E' then begin
          Grid.Cells[Grid.getcolumn('move_tipomov'),x]:=Global.CodMontagemkitE;
        end else begin
          Grid.Cells[Grid.getcolumn('move_tipomov'),x]:=Global.CodMontagemkitS;
        end;
      end;
      Grid.Cells[Grid.getcolumn('move_custo'),x]:=floattostr( Festoque.GetCusto(EdEsto_codigo.text,EdUnid_codigo.text,'custo') );
      Grid.Cells[Grid.getcolumn('move_custoger'),x]:=floattostr( Festoque.GetCusto(EdEsto_codigo.text,EdUnid_codigo.text,'custoger') );
      Grid.Cells[Grid.getcolumn('move_customedio'),x]:=floattostr( Festoque.GetCusto(EdEsto_codigo.text,EdUnid_codigo.text,'medio') );
      Grid.Cells[Grid.getcolumn('move_customeger'),x]:=floattostr( Festoque.GetCusto(EdEsto_codigo.text,EdUnid_codigo.text,'medioger') );
      Grid.Refresh;
   end;

begin

  if not confirma('Confirma lançamento') then exit;
  Entsai:=EdMovimento.text;
  if Entsai='E' then begin
    TipoMovimento:=Global.CodMontagemKitE;
  end else begin
    TipoMovimento:=Global.CodMontagemKitS;
  end;
  Editstogrid;
  SetaEdits;
  EdEsto_codigo.ClearAll(FMontagemKit,99);
  EdEsto_codigo.Setfocus;
end;

procedure TFMontagemkit.bgravarClick(Sender: TObject);
var Transacao:string;

   procedure gravaacertomestre;
   begin
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacao);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',EdNumerodoc.AsInteger);
      Sistema.SetField('moes_tipomov',Global.CodMontagemkite);
      Sistema.SetField('moes_unid_codigo',EdUNid_codigo.Text);
      Sistema.SetField('moes_estado',FCidades.GetUF(EdUnid_codigo.ResultFind.fieldbyname('unid_cida_codigo').AsInteger));
//      Sistema.SetField('moes_repr_codigo',Representante);
      Sistema.SetField('moes_tipo_codigo',EdUnid_codigo.text);
      Sistema.SetField('moes_tipocad','U');
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',EdData.AsDate);
      Sistema.SetField('moes_dataemissao',EdData.AsDate);
//      Sistema.SetField('moes_vlrtotal',Valortotal);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.Post();

      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacao);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',EdNumerodoc.AsInteger);
      Sistema.SetField('moes_tipomov',Global.CodMontagemkits);
      Sistema.SetField('moes_unid_codigo',EdUNid_codigo.Text);
      Sistema.SetField('moes_estado',FCidades.GetUF(EdUnid_codigo.ResultFind.fieldbyname('unid_cida_codigo').AsInteger));
//      Sistema.SetField('moes_repr_codigo',Representante);
      Sistema.SetField('moes_tipo_codigo',EdUnid_codigo.text);
      Sistema.SetField('moes_tipocad','U');
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',EdData.AsDate);
      Sistema.SetField('moes_dataemissao',EdData.AsDate);
//      Sistema.SetField('moes_vlrtotal',Valortotal);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.Post();
   end;

   procedure gravaacertodetalhe;
   var codigograde,codigocoluna,codigolinha,p:integer;
       codestoque,tipomovimento,entsai:string;
       qtde:currency;
   begin
      for p:=1 to Grid.rowcount do begin
        codestoque:=Grid.cells[Grid.getcolumn('move_esto_codigo'),p];
        if trim(codestoque)<>'' then begin
          tipomovimento:=Grid.cells[Grid.getcolumn('move_tipomov'),p];
          codigograde:=FEstoque.GetCodigoGrade(codestoque);
          QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+stringtosql(codestoque)+
                            ' and esqt_unid_codigo='+EdUnid_codigo.AsSql);
          qtde:=texttovalor( Grid.cells[Grid.getcolumn('move_qtde'),p] );
          Sistema.Insert('Movestoque');
          Sistema.SetField('move_esto_codigo',codestoque);
          codigolinha:=FEstoque.GetCodigoLinha(codestoque,codigograde);
          codigocoluna:=FEstoque.GetCodigoColuna(codestoque,codigograde);
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
          Sistema.SetField('move_numerodoc',Ednumerodoc.AsInteger);
          Sistema.SetField('move_status','N');
          Sistema.SetField('move_tipomov',TipoMovimento);
          Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
          Sistema.SetField('move_tipo_codigo',EdUnid_codigo.text);
          Sistema.SetField('move_tipocad','U');
    //      Sistema.SetField('move_repr_codigo',Representante);
          Sistema.SetField('move_qtde',qtde);
          Sistema.SetField('move_estoque',0);
          Sistema.SetField('move_datalcto',Sistema.Hoje);
          Sistema.SetField('move_datamvto',EdData.AsDate);
    //      Sistema.SetField('move_qtderetorno',0);
    //      Sistema.SetField('move_venda',Texttovalor(Grid.Cells[3,linha]));
          Sistema.SetField('move_grup_codigo',FEstoque.getgrupo(codestoque));
          Sistema.SetField('move_sugr_codigo',FEstoque.getsubgrupo(codestoque));
          Sistema.SetField('move_fami_codigo',FEstoque.getfamilia(codestoque));
          Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
          custoant:=0;customedioant:=0;customegerant:=0;custogerant:=0;
          if QEstoque.fieldbyname('esqt_qtde').ascurrency>0 then begin
            custoant:=QEstoque.fieldbyname('esqt_qtde').ascurrency*QEstoque.fieldbyname('esqt_custo').ascurrency;
            customedioant:=QEstoque.fieldbyname('esqt_qtde').ascurrency*QEstoque.fieldbyname('esqt_customedio').ascurrency;
          end;
          if QEstoque.fieldbyname('esqt_qtdeprev').ascurrency>0 then begin
            custogerant:=QEstoque.fieldbyname('esqt_qtdeprev').ascurrency*QEstoque.fieldbyname('esqt_custoger').ascurrency;
            customegerant:=QEstoque.fieldbyname('esqt_qtdeprev').ascurrency*QEstoque.fieldbyname('esqt_customeger').ascurrency;
          end;
          if Tipomovimento=Global.Codmontagemkite then begin
            EntSai:='E';
            if custoant>0 then
              Sistema.SetField('move_custo',(custo+custoant)/(qtde+QEstoque.fieldbyname('esqt_qtde').ascurrency))
            else
              Sistema.SetField('move_custo',(custo)/(qtde));
            if custogerant>0 then
              Sistema.SetField('move_custoger',(EdCusto.ascurrency+custogerant)/(qtde+QEstoque.fieldbyname('esqt_qtdeprev').ascurrency) )
            else
              Sistema.SetField('move_custoger',(EdCusto.ascurrency)/(qtde) );
            if customedioant>0 then
              Sistema.SetField('move_customedio',(customedio+customedioant)/(qtde+QEstoque.fieldbyname('esqt_qtde').ascurrency) )
            else
              Sistema.SetField('move_customedio',(customedio)/(qtde) );
            if customegerant>0 then
              Sistema.SetField('move_customeger',(customeger+customegerant)/(qtde+QEstoque.fieldbyname('esqt_qtdeprev').ascurrency))
            else
              Sistema.SetField('move_customeger',(customeger)/(qtde) );
          end else begin
            Entsai:='S';
            Sistema.SetField('move_custo',texttovalor( Grid.Cells[Grid.getcolumn('move_custo'),p] ));
            Sistema.SetField('move_custoger',texttovalor( Grid.Cells[Grid.getcolumn('move_custoger'),p] ));
            Sistema.SetField('move_customedio',texttovalor( Grid.Cells[Grid.getcolumn('move_customedio'),p] ));
            Sistema.SetField('move_customeger',texttovalor( Grid.Cells[Grid.getcolumn('move_customeger'),p] ));
          end;
          Sistema.Post('');
// 17.08.06 - atualiza os custos do codigo 'q entra'
          if Tipomovimento=Global.Codmontagemkite then begin
            Sistema.Edit('estoqueqtde');
            if custoant>0 then
              Sistema.SetField('esqt_custo',(custo+custoant)/(qtde+QEstoque.fieldbyname('esqt_qtde').ascurrency))
            else
              Sistema.SetField('esqt_custo',(custo)/(qtde));
            if custogerant>0 then
              Sistema.SetField('esqt_custoger',(Custoger+custogerant)/(qtde+QEstoque.fieldbyname('esqt_qtdeprev').ascurrency) )
            else
              Sistema.SetField('esqt_custoger',(Custoger)/(qtde) );
            if customedioant>0 then
              Sistema.SetField('esqt_customedio',(Customedio+customedioant)/(qtde+QEstoque.fieldbyname('esqt_qtde').ascurrency) )
            else
              Sistema.SetField('esqt_customedio',(Customedio)/(qtde) );
            if customegerant>0 then
              Sistema.SetField('esqt_customeger',(Customeger+customegerant)/(qtde+QEstoque.fieldbyname('esqt_qtdeprev').ascurrency))
            else
              Sistema.SetField('esqt_customeger',(Customeger)/(qtde) );
            Sistema.post('esqt_unid_codigo='+EdUnid_codigo.assql+' and esqt_esto_codigo='+stringtosql(codestoque)+
                         ' and esqt_status=''N''' );
          end;

          FGeral.MovimentaQtdeEstoque(codestoque,EdUnid_codigo.Text,EntSai,TipoMovimento,qtde,QEstoque);
          QEstoque.close;
          Freeandnil(QEstoque);
       end;
     end;
   end;

   function ValidaMOntagem:boolean;
   var p,ent,sai:integer;
       tipomov:string;
   begin
      ent:=0 ; sai:=0; result:=true;
      for p:=1 to Grid.rowcount do begin
        tipomov:=Grid.cells[Grid.getcolumn('move_tipomov'),p];
        if trim(tipomov)<>'' then begin
          if tipomov=Global.CodMontagemKitS then
            inc(sai)
          else
            inc(ent);
        end;
      end;
      if ent=0 then begin
        result:=false;
        avisoerro('Falta o codigo de entrada');
      end else if sai=0 then begin
        result:=false;
        avisoerro('Falta pelo menos um codigo de saida');
      end;
   end;

begin

  if EdNumerodoc.isempty then exit;
  if not ValidaMontagem then exit;
  if not confirma('Confirma montagem') then exit;
  Sistema.BeginTransaction('Gravando montagem kit');
  Sistema.Edit('movesto');
  sistema.setfield('moes_status','C');
  Sistema.post('moes_unid_codigo='+EdUnid_codigo.assql+' and moes_numerodoc='+EdNumerodoc.assql+' and moes_datamvto='+EdData.assql+
               ' and moes_status=''N''');
  Sistema.Edit('movestoque');
  sistema.setfield('move_status','C');
  Sistema.post('move_unid_codigo='+EdUnid_codigo.assql+' and move_numerodoc='+EdNumerodoc.assql+' and move_datamvto='+EdData.assql+
               ' and move_status=''N''');
  Transacao:=FGeral.GetTransacao;
  GravaAcertoMestre;
  GravaAcertoDetalhe;

  Sistema.EndTransaction('Gravado montagem '+EDNumerodoc.text);
  EdUnid_codigo.ClearAll(FMontagemKit,99);
  EdData.setdate(Sistema.hoje);
  Grid.clear;
  EdUnid_codigo.Setfocus;
end;

procedure TFMontagemkit.EdMovimentoValidate(Sender: TObject);
var p:integer;
begin
  if EdMovimento.text='E' then begin
    p:=FGeral.ProcuraGrid(Grid.getcolumn('move_tipomov'),EdEsto_codigo.text,Grid);
    if p>0 then
      EdMovimento.Invalid('Já digitado codigo para entrada nesta montagem')
  end;
end;

procedure TFMontagemkit.Execute;
begin
   show;
   EdData.setdate(Sistema.hoje);
   EdCusto.setvalue(0);
   EdCustoent.setvalue(0);
   EdUnid_codigo.setfocus;
end;

procedure TFMontagemkit.EdEsto_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   if key=#27 then
     bcancelarclick(FMontagemkit);
end;

procedure TFMontagemkit.SetaEdits;
var p:integer;
    produto:string;
    custogers,qtdee,qtde,custox,move_custo,move_customedio,
    move_customeger,tmove_custo,tmove_customedio,tmove_customeger,tmove_custoger:currency;
begin
  custogers:=0;qtdee:=0;
  custo:=0;customedio:=0;customeger:=0;custoger:=0;
  tmove_custo:=0;tmove_customedio:=0;tmove_customeger:=0;tmove_custoger:=0;
  for p:=1 to Grid.rowcount do begin
    produto:=Grid.cells[Grid.getcolumn('move_esto_codigo'),p];
    if trim(produto)<>'' then begin
      qtde:=texttovalor(Grid.cells[Grid.getcolumn('move_qtde'),p]);
      custox:=texttovalor(Grid.cells[Grid.getcolumn('move_custoger'),p]);
      move_custo:=texttovalor(Grid.cells[Grid.getcolumn('move_custo'),p]);
      move_customedio:=texttovalor(Grid.cells[Grid.getcolumn('move_customedio'),p]);
      move_customeger:=texttovalor(Grid.cells[Grid.getcolumn('move_customeger'),p]);
      if Grid.cells[Grid.getcolumn('move_tipomov'),p]=Global.CodMontagemKitS then begin
         custogers:=custogers+(qtde*custox);
         tmove_custo:=tmove_custo+(qtde*Move_custo);
         tmove_customedio:=tmove_customedio+(qtde*Move_customedio);
         tmove_customeger:=tmove_customeger+(qtde*Move_customeger);
         tmove_custoger:=tmove_custoger+(qtde*custox);
      end else begin
         qtdee:=qtde;
      end;
    end;
  end;
  EdCusto.setvalue(custogers);
  if qtdee>0 then begin
    EdCustoent.setvalue(custogers/qtdee);
//    Custo:=(tmove_custo/qtdee);
//    Customedio:=(tmove_customedio/qtdee);
//    Customeger:=(tmove_customeger/qtdee);
    Custo:=(tmove_custo);
    Customedio:=(tmove_customedio);
    Customeger:=(tmove_customeger);
// 17.08.06
    Custoger:=tmove_custoger;

  end else
    EdCustoent.setvalue(0);
end;

end.
