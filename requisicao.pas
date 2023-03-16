unit requisicao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, Sqlexpr, DB, SimpleDS, Datasnap.DBClient, ComObj;
//   dbf;

type
  TFRequisicao = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bExcluir: TSQLBtn;
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
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    edqtdebaixa: TSQLEd;
    bbaixar: TSQLBtn;
    bmarcatodos: TSQLBtn;
    bdesmarcatodos: TSQLBtn;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCliente: TSQLEd;
    EdtipoEstoque: TSQLEd;
    Ednroobra: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    bchecasimilares: TSQLBtn;
    bsimilares: TSQLBtn;
    edsimilar: TSQLEd;
    bextrato: TSQLBtn;
    Edtipoconsulta: TSQLEd;
    Eddesctipo: TSQLEd;
    Edtipo_codigo: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    psaidas: TSQLPanelGrid;
    Grids: TSqlDtGrid;
    bsaidas: TSQLBtn;
    SQLPanelGrid2: TSQLPanelGrid;
    bapagasaida: TSQLBtn;
    bfechasaida: TSQLBtn;
    breprocessa: TSQLBtn;
    bajuda: TSQLBtn;
    Edtotal: TSQLEd;
    dbforcam: TSimpleDataSet;
    bimpconsumo: TSQLBtn;
    Od2: TOpenDialog;
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure bbaixarClick(Sender: TObject);
    procedure edqtdebaixaExitEdit(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure bmarcatodosClick(Sender: TObject);
    procedure bdesmarcatodosClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure EdQtdeExitEdit(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdCodtamanhoValidate(Sender: TObject);
    procedure bchecasimilaresClick(Sender: TObject);
    procedure bsimilaresClick(Sender: TObject);
    procedure edsimilarValidate(Sender: TObject);
    procedure edsimilarKeyPress(Sender: TObject; var Key: Char);
    procedure bextratoClick(Sender: TObject);
    procedure EdtipoconsultaKeyPress(Sender: TObject; var Key: Char);
    procedure EdtipoconsultaValidate(Sender: TObject);
    procedure edqtdebaixaValidate(Sender: TObject);
    procedure bsaidasClick(Sender: TObject);
    procedure bapagasaidaClick(Sender: TObject);
    procedure bfechasaidaClick(Sender: TObject);
    procedure breprocessaClick(Sender: TObject);
    procedure EdQtdeValidate(Sender: TObject);
    procedure EdcodcorValidate(Sender: TObject);
    procedure bajudaClick(Sender: TObject);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure bimpconsumoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(op:string='S');
    procedure EditstoGrid(ctransacao:string);
    procedure GravaDetalhe(ytransacao:string='');
    procedure GravaMestres(rtransacao:string);
    procedure GravaMestre(rtransacao:string);
    function GetItem(Ed:TSqled):string;
    procedure AtivaSaidas;
    procedure DesativaSaidas;
    function TratamentotoCor(xcorid:string):string;
    procedure Totaliza;
  end;

type TRequisicao=record
     produto,descricao,obra,codigopea,corid:string;
     qtde,unitario,peso,pecas,pesosobra:currency;
     tamanho:integer;
end;

var
  FRequisicao: TFRequisicao;
  QEstoque:TSqlquery;
  codigobarra:boolean;
  OPx,tipos,goperacao,xTipoCad,nrobra:string;
  PReq:^TRequisicao;

implementation

uses geral, Sqlfun, Sqlsis , Arquiv, munic, Estoque, relestoque, Unidades,
  cadcor, tamanhos;

{$R *.dfm}

{ TFRequisicao }

procedure TFRequisicao.Execute(op:string='S');
//////////////////////////////////////////////
var Q:TSqlquery;
    Lista:TStringlist;
    sqlperiodo:string;
    xdatai:TDatetime;

    procedure SetaItensConsulta(Ed:TSqled);
    ////////////////////////////////////////
    begin
      Ed.Items.Clear;
      Ed.Items.Add('01 - S� Aberto');
      Ed.Items.Add('02 - S� Baixadas');
      Ed.Items.Add('03 - Ambas');
    end;

begin
///////////////////////////////////////////////////
   EdUNid_codigo.text:=global.codigounidade;
   EdUnid_codigo.validfind;
   EdData.setdate(sistema.hoje);
   Grid.clear;
   opx:=op;
   xTipoCad:='C';
   EdTipoEstoque.Clearall(FRequisicao,99);
   tipos:=Global.CodEntradaAlmox+';'+Global.CodSaidaprocesso;
   EdNumerodoc.Items.Clear;
   EdNroobra.enabled:=Global.Topicos[1204];
   FGeral.SetaTiposdeEstoque(EdTipoestoque);
   bchecasimilares.Enabled:=op='S';
   bsimilares.Enabled:=op='S';
   bsaidas.Enabled:=op='S';
   if not Arq.TEstoque.active then Arq.TEstoque.Open;
   bbaixar.Enabled:=Opx='S';
   breprocessa.enabled:=OPx='S';
// 06.08.13
   bajuda.Visible:=Global.Topicos[1036];
   bajuda.Enabled:=Global.Topicos[1036];

   Lista:=TStringlist.create;
   if (Opx='S') or (Opx='E') then begin
     if not Global.Topicos[1412] then begin
       if Sistema.getperiodo('Informe periodo para filtrar pesquisa das obras geradas do PEA') then
         sqlperiodo:=' and moes_datamvto>='+Datetosql(Sistema.datai)+' and moes_datamvto<='+Datetosql(Sistema.Dataf)
       else
         sqlperiodo:='';
       Q:=sqltoquery('select movesto.*,clie_razaosocial,clie_nome from movesto'+
                     ' inner join clientes on ( clie_codigo=moes_tipo_codigo )'+
                     ' where moes_status=''R'''+
                     ' and moes_unid_codigo='+stringtosql(Global.codigounidade)+
                     ' and moes_tipomov='+stringtosql(Global.CodRequisicaoAlmox)+
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
     end else begin
       if FGeral.getconfig1asinteger('DIASPEDIDO') >0 then
         xDatai:=Sistema.hoje-FGeral.getconfig1asinteger('DIASPEDIDO')
       else
         xdatai:=sistema.hoje-60;
       sqlperiodo:=' and mped_datamvto>='+Datetosql(xdatai)+' and mped_datamvto<='+Datetosql(Sistema.hoje);
       Q:=sqltoquery('select movped.*,clie_razaosocial,clie_nome from movped'+
                     ' inner join clientes on ( clie_codigo=mped_tipo_codigo )'+
                     ' where mped_status=''N'''+
                     ' and mped_situacao=''P'''+
                     ' and mped_unid_codigo='+stringtosql(Global.codigounidade)+
                     ' and '+FGeral.GetIN('mped_tipomov',Global.CodPedVenda+';'+Global.CodOrdemdeServico,'C')+
                     sqlperiodo+
                     ' order by clie_razaosocial');
       while not Q.eof do begin
         if Lista.IndexOf(Q.fieldbyname('mped_numerodoc').AsString)=-1 then begin
           EdNumerodoc.Items.Add(strspace(Q.fieldbyname('mped_numerodoc').AsString,9)+' - '+FGeral.formatadata(Q.fieldbyname('mped_datamvto').AsDatetime)+
                               ' - '+Q.fieldbyname('clie_razaosocial').AsString );
           Lista.Add(Q.fieldbyname('mped_numerodoc').AsString);
         end;
  //                             ' - '+Q.fieldbyname('clie_nome').AsString );
         Q.Next;
       end;
     end;
   end;
   Lista.free;
   if (Opx='S')  then begin
     bmarcatodos.enabled:=true;
     bdesmarcatodos.enabled:=true;
     FRequisicao.caption:='Requisi��o de SAIDA de Material do Almoxarifado para Estoque em Processo';
   end else begin
     bmarcatodos.enabled:=false;
     bdesmarcatodos.enabled:=false;
     FRequisicao.caption:='Requisi��o de ENTRADA de Material do Estoque em Processo para o Almoxarifado';
   end;
   if Global.Topicos[1412] then begin
     FRequisicao.caption:='Material usado para produzir OS/Pedido de Venda';
     bmarcatodos.enabled:=false;
     bdesmarcatodos.enabled:=false;
     Ednroobra.Enabled:=false;
   end;

   if Global.Topicos[1420] then begin
     FRequisicao.caption:='Material usado para produzir Ordem de Produ��o';
     bmarcatodos.enabled:=true;
     bdesmarcatodos.enabled:=true;
     Ednroobra.Enabled:=false;
   end;
   EdTipoEstoque.Clearall(FRequisicao,99);
// 01.10.08
   FGeral.EstiloForm(FRequisicao);
   FGeral.ConfiguraColorEditsNaoEnabled(FRequisicao);
   Show;
   SetaItensConsulta(EdTipoConsulta);
// 04.08.10
   if trim(FGeral.getconfig1asstring('CORESVALIDAS'))<>'' then
     FCores.SetaItems(EdCodcor,nil,FGeral.getconfig1asstring('CORESVALIDAS'),'');
   EdTipoEstoque.setfocus;
end;

procedure TFRequisicao.EdNumeroDocValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var Q,QP:TSqlquery;
    i:integer;
    sqltipo,status,sqlconsulta,w:string;
    jabaixado:currency;

    function GetJabaixado(numerodoc:integer;data:tdatetime;produto:string;codtam:integer;codcor:integer):currency;
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    var Qx:TSqlquery;
        sqlcor,sqltam,sqlwhere:string;
    begin
      if codcor>0 then
        sqlcor:=' and move_core_codigo='+inttostr(codcor)
      else
        sqlcor:=' and ( (move_core_codigo=0) or (move_core_codigo is null) )';
      if codtam>0 then
        sqltam:=' and move_tama_codigo='+inttostr(codtam)
      else
        sqltam:=' and ( (move_tama_codigo=0) or (move_tama_codigo is null) )';
      if Global.Topicos[1420] then
        sqlwhere:=' move_status=''N'''
      else if Global.Topicos[1412] then
        sqlwhere:=' move_status=''R'''
      else
        sqlwhere:=' move_status=''N''';
      Qx:=sqltoquery('select move_qtde from movestoque where'+
                     sqlwhere+
                     ' and move_esto_codigo='+stringtosql(produto)+
                     ' and move_numerodoc='+inttostr(numerodoc)+
                     ' and move_datamvto>='+datetosql(data)+
                     ' and '+FGeral.GetIN('move_tipomov',Global.CodSaidaAlmox+';'+Global.CodRequisicaoAlmox,'C')+
                     sqlcor+sqltam );
      result:=0;
      while not Qx.eof do begin
        result:=result+Qx.fieldbyname('move_qtde').ascurrency;
        Qx.Next;
      end;
      FGeral.FechaQuery(Qx);
    end;

begin
////////////
   if EdNUmerodoc.IsEmpty then exit;
   w:='inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)';
   if Global.Topicos[1412] then begin
     sqltipo:=' and '+FGeral.GetIN('move_tipomov',Global.CodPedVenda+';'+Global.CodOrdemdeServico,'C');
     QP:=sqltoquery('select mped_tipo_codigo from movped'+
                     ' where mped_status=''N'''+
                     ' and mped_situacao=''P'''+
                     ' and mped_numerodoc='+EdNumerodoc.AsSql+
                     ' and mped_unid_codigo='+stringtosql(Global.codigounidade)+
                     ' and '+FGeral.GetIN('mped_tipomov',Global.CodPedVenda+';'+Global.CodOrdemdeServico,'C')+

                     ' and mped_datamvto>='+datetosql(Sistema.hoje-FGeral.getconfig1asinteger('DIASPEDIDO')) );
      w:='';
   end else
     sqltipo:=' and move_tipomov='+stringtosql(Global.CodRequisicaoAlmox);
   status:='R';
   if opx='E' then begin
     sqltipo:=' and '+FGeral.Getin('move_tipomov',Global.CodEntradaAlmox,'C');
     status:='N';
     sqlconsulta:=' and move_status=''N'''
   end;
   if opx='S' then begin
    if EdTipoconsulta.text='01' then
       sqlconsulta:=' and move_status=''R'''
     else
       sqlconsulta:='';
   end;
// 01.11.17
   if (Global.Topicos[1420])  then
      Q:=sqltoquery('select * from movpeddet '+
                 ' inner join estoque on ( esto_codigo=mpdd_esto_codigo )'+
//                 ' left join cores on ( core_codigo=move_core_codigo )'+
//                 ' left join tamanhos on ( tama_codigo=move_tama_codigo )'+
                 ' where mpdd_numerodoc='+EdNumerodoc.assql+
                 ' and mpdd_unid_codigo='+EdUnid_codigo.assql+
                 ' and mpdd_status<>''C'''+
                 ' and mpdd_tipomov = ''OP'''+
                 ' order by mpdd_esto_codigo')

   else

      Q:=sqltoquery('select * from movestoque '+w+
                 ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
//                 ' left join cores on ( core_codigo=move_core_codigo )'+
//                 ' left join tamanhos on ( tama_codigo=move_tama_codigo )'+
                 ' where move_numerodoc='+EdNumerodoc.assql+
                 ' and move_datamvto>='+Datetosql(Sistema.Datai)+  // 10.11.09
                 ' and move_datamvto<='+Datetosql(Sistema.Dataf)+  // 10.11.09
                 ' and move_unid_codigo='+EdUnid_codigo.assql+' and move_status<>''C'''+
                 sqltipo+sqlconsulta+
                 ' order by move_esto_codigo');
   Grid.clear;
   if not Q.eof then begin

     if (Global.Topicos[1420])  then begin

       EdNroobra.text:=Q.fieldbyname('mpdd_numerodoc').AsString;
       Edtipo_codigo.Text:=Q.fieldbyname('mpdd_tipo_codigo').AsString;

     end else begin

       EdNroobra.text:=Q.fieldbyname('move_nroobra').AsString;
       Edtipo_codigo.Text:=Q.fieldbyname('move_tipo_codigo').AsString;
  // 20.02.17
       if (EdTipo_codigo.Text='') and (Global.Topicos[1412]) then
          EdTipo_codigo.text:=QP.fieldbyname('mped_tipo_codigo').asstring;

     end;
     EdTipo_codigo.validfind;
   end else begin

     EdNroobra.text:=EdNumerodoc.Text;
      if Global.Topicos[1412] then begin
        EdTipo_codigo.text:=QP.fieldbyname('mped_tipo_codigo').asstring;
        EdTipo_codigo.Valid;
        EdTipo_codigo.enabled:=false;
        bincluirclick(self);
      end else
       Edtipo_codigo.Text:='';

   end;
//   Grid.QueryToGrid(Q);
   i:=1;
   while not Q.Eof do begin

     if (Global.Topicos[1420])  then
       jabaixado:=GetJabaixado(EdNumerodoc.asinteger,Q.fieldbyname('mpdd_datamvto').asdatetime,Q.fieldbyname('mpdd_esto_codigo').asstring,
                               Q.fieldbyname('mpdd_tama_codigo').asinteger,
                               Q.fieldbyname('mpdd_core_codigo').asinteger)
     else
       jabaixado:=GetJabaixado(EdNumerodoc.asinteger,Q.fieldbyname('move_datamvto').asdatetime,Q.fieldbyname('move_esto_codigo').asstring,
                               Q.fieldbyname('move_tama_codigo').asinteger,
                               Q.fieldbyname('move_core_codigo').asinteger);

     if ( (EdTipoconsulta.text='02') and (jabaixado>0) ) or
       (EdTipoconsulta.text<>'02') then begin

       if (Global.Topicos[1420])  then begin

         Grid.Cells[Grid.getcolumn('move_esto_codigo'),i]:=Q.fieldbyname('mpdd_esto_codigo').asstring;
         Grid.Cells[Grid.getcolumn('esto_descricao'),i]:=Q.fieldbyname('esto_descricao').asstring;
         Grid.Cells[Grid.getcolumn('esto_referencia'),i]:=Q.fieldbyname('esto_referencia').asstring;
         Grid.Cells[Grid.getcolumn('core_descricao'),i]:=FCores.GetDescricao(Q.fieldbyname('mpdd_core_codigo').asinteger);
         Grid.Cells[Grid.getcolumn('move_qtderetorno'),i]:=floattostr( Q.fieldbyname('mpdd_qtde').ascurrency );
         Grid.Cells[Grid.getcolumn('move_qtde'),i]:=floattostr(Q.fieldbyname('mpdd_qtde').ascurrency-jabaixado);
         Grid.Cells[Grid.getcolumn('qtdejabaixada'),i]:=floattostr(jabaixado);
         Grid.Cells[Grid.getcolumn('move_operacao'),i]:=Q.fieldbyname('mpdd_operacao').asstring;
         Grid.Cells[Grid.getcolumn('move_transacao'),i]:=Q.fieldbyname('mpdd_transacao').asstring;
         Grid.Cells[Grid.getcolumn('move_core_codigo'),i]:=Q.fieldbyname('mpdd_core_codigo').asstring;
         Grid.Cells[Grid.getcolumn('tama_descricao'),i]:=FTamanhos.GetDescricao(Q.fieldbyname('mpdd_tama_codigo').asinteger);
         Grid.Cells[Grid.getcolumn('move_tama_codigo'),i]:=Q.fieldbyname('mpdd_tama_codigo').asstring;
//         Grid.Cells[Grid.getcolumn('qtdejabaixada'),i]:=floattostr(jabaixado);
         Edcliente.setvalue(Q.fieldbyname('mpdd_tipo_codigo').asinteger);
         if (Q.fieldbyname('mpdd_status').asstring='N') and (OP='S') then
            Grid.Cells[Grid.getcolumn('marcado'),i]:='Ok';
         Grid.Cells[Grid.getcolumn('esto_unidade'),i]:=Q.fieldbyname('esto_unidade').asstring;
//         Grid.Cells[Grid.getcolumn('move_venda'),i]:=floattostr(Q.fieldbyname('move_venda').ascurrency);

       end else begin

         Grid.Cells[Grid.getcolumn('move_esto_codigo'),i]:=Q.fieldbyname('move_esto_codigo').asstring;
         Grid.Cells[Grid.getcolumn('esto_descricao'),i]:=Q.fieldbyname('esto_descricao').asstring;
         Grid.Cells[Grid.getcolumn('esto_referencia'),i]:=Q.fieldbyname('esto_referencia').asstring;
         Grid.Cells[Grid.getcolumn('core_descricao'),i]:=FCores.GetDescricao(Q.fieldbyname('move_core_codigo').asinteger);
         Grid.Cells[Grid.getcolumn('move_qtderetorno'),i]:=Q.fieldbyname('move_qtderetorno').asstring;
         Grid.Cells[Grid.getcolumn('move_qtde'),i]:=floattostr(Q.fieldbyname('move_qtderetorno').ascurrency-jabaixado);
         Grid.Cells[Grid.getcolumn('move_operacao'),i]:=Q.fieldbyname('move_operacao').asstring;
         Grid.Cells[Grid.getcolumn('move_transacao'),i]:=Q.fieldbyname('move_transacao').asstring;
         Grid.Cells[Grid.getcolumn('move_core_codigo'),i]:=Q.fieldbyname('move_core_codigo').asstring;
         Grid.Cells[Grid.getcolumn('tama_descricao'),i]:=FTamanhos.GetDescricao(Q.fieldbyname('move_tama_codigo').asinteger);
         Grid.Cells[Grid.getcolumn('move_tama_codigo'),i]:=Q.fieldbyname('move_tama_codigo').asstring;
         Grid.Cells[Grid.getcolumn('qtdejabaixada'),i]:=floattostr(jabaixado);
    //     Grid.Cells[Grid.getcolumn('move_pecas'),i]:=Q.fieldbyname('move_pecas').asstring;
         Edcliente.setvalue(Q.fieldbyname('move_tipo_codigo').asinteger);
         if (Q.fieldbyname('move_status').asstring='N') and (OP='S') then
            Grid.Cells[Grid.getcolumn('marcado'),i]:='Ok';
  // 12.03.09
         Grid.Cells[Grid.getcolumn('esto_unidade'),i]:=Q.fieldbyname('esto_unidade').asstring;
  // 22.01.14
         Grid.Cells[Grid.getcolumn('move_venda'),i]:=floattostr(Q.fieldbyname('move_venda').ascurrency);

       end;

       Grid.AppendRow;
       inc(i);
     end;
     Q.Next;
   end;
end;

procedure TFRequisicao.GridDblClick(Sender: TObject);
///////////////////////////////////////////////////////
begin

  if Grid.Getcolumn('move_qtde')=Grid.col then begin

     EdQtdebaixa.Top:=Grid.TopEdit;
     EdQtdebaixa.Left:=Grid.LeftEdit+5;
//     EdQtdebaixa.Text:=StrToStrNumeros(Grid.Cells[Grid.Col,Grid.Row]);
//     EdQtdebaixa.setvalue(TextToValor(Grid.Cells[Grid.Col,Grid.Row]));
     EdQtdebaixa.text:=Grid.Cells[Grid.Col,Grid.Row];
     EdQtdebaixa.Visible:=True;
     EdQtdebaixa.SetFocus;

  end else if ( Grid.col=Grid.getcolumn('marcado') ) and (Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row]<>'') then begin
     if Grid.cells[Grid.getcolumn('marcado'),Grid.row]='Ok' then begin
       Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='';
     end else begin
       Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='Ok';
     end;
   end;


end;

procedure TFRequisicao.bbaixarClick(Sender: TObject);
/////////////////////////////////////////////////////////
var i,codcor,codtamanho:integer;
    operacao,transacao,transacaoentrada,codestoque,sqlcor,sqltamanho,referencia:string;
    qtde:currency;
    Q,QGrade:TSqlquery;
    usougrade:boolean;

    procedure GravaMestreEntProcesso;
    ///////////////////////////////////
    begin
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacaoentrada);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',EdNumerodoc.asinteger);
      Sistema.SetField('moes_tipomov',Global.CodEntradaprocesso);
//      Sistema.SetField('moes_comv_codigo',codigomov);
      Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('moes_estado',Global.UFUnidade);
//      Sistema.SetField('moes_tipo_codigo',EdCliente.AsInteger);
//      Sistema.SetField('moes_tipocad','C');
      Sistema.SetField('moes_tipo_codigo',EdTipo_codigo.AsInteger);
      Sistema.SetField('moes_tipocad',xTipoCad);
//      Sistema.SetField('moes_repr_codigo',Representante);
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


    procedure GravadetalheEntProcesso;
    /////////////////////////////////
    var Qe:TSqlquery;
    begin
      Qe:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),i]));
      Sistema.Insert('movestoque');
      Sistema.SetField('move_esto_codigo',Grid.cells[Grid.getcolumn('move_esto_codigo'),i]);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_transacao',transacaoentrada);
      Sistema.SetField('move_unid_codigo',EdUNid_codigo.text);
      Sistema.SetField('move_core_codigo',texttovalor(Grid.cells[Grid.getcolumn('move_core_codigo'),i]) );
// 29.04.08
      Sistema.SetField('move_tama_codigo',texttovalor(Grid.cells[Grid.getcolumn('move_tama_codigo'),i]) );
      Sistema.SetField('move_qtde',texttovalor(Grid.cells[Grid.getcolumn('move_qtde'),i]));
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
//      Sistema.SetField('move_tipo_codigo',EdCliente.asinteger);
//      Sistema.SetField('move_tipocad','C');
      Sistema.SetField('move_tipo_codigo',EdTipo_codigo.asinteger);
      Sistema.SetField('move_tipocad',xTipoCad);

      Sistema.SetField('move_numerodoc',EdNumerodoc.asinteger);
      Sistema.SetField('move_tipomov',Global.CodEntradaprocesso);
      Sistema.SetField('move_datalcto',sistema.hoje);
      Sistema.SetField('move_datamvto',EdData.asdate);
      Sistema.SetField('move_datacont',EdData.asdate);
      Sistema.SetField('move_usua_codigo',Global.Usuario.Codigo);
      Sistema.SetField('move_grup_codigo',Qe.fieldbyname('esto_grup_codigo').asinteger);
      Sistema.SetField('move_sugr_codigo',Qe.fieldbyname('esto_sugr_codigo').asinteger);
      Sistema.SetField('move_fami_codigo',Qe.fieldbyname('esto_fami_codigo').asinteger);
      Sistema.SetField('move_locales',EdTipoestoque.text);
      Sistema.SetField('move_nroobra',EdNroobra.text);
//      Sistema.SetField('move_pecas',texttovalor(Grid.cells[Grid.getcolumn('move_pecas'),i]));
      Sistema.post;
      FGeral.FechaQuery(Qe);
    end;

// 27.10.08
    procedure GravaMestreSaidaAlmox;
    //////////////////////////////////////
    var Q1:TSqlquery;
    begin
      Q1:=sqltoquery('select moes_transacao from movesto where moes_transacao='+Stringtosql(transacaoentrada)+
                     ' and moes_tipomov='+Stringtosql(Global.CodSaidaAlmox)+
                     ' and moes_status=''N'''+
                     ' and moes_unid_codigo='+EdUnid_codigo.AsSql);
      if Q1.eof then begin
        Sistema.Insert('Movesto');
        Sistema.SetField('moes_transacao',Transacaoentrada);
        Sistema.SetField('moes_operacao',FGeral.GetOperacao);
        Sistema.SetField('moes_status','N');
        Sistema.SetField('moes_numerodoc',EdNumerodoc.asinteger);
        Sistema.SetField('moes_tipomov',Global.CodSaidaAlmox);
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
      FGeral.FechaQuery(Q1);
    end;

    procedure GravaDetalheSaidaAlmox;
    /////////////////////////////////////
    var Qe:TSqlquery;
    begin
      Qe:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),i]));
      Sistema.Insert('movestoque');
      Sistema.SetField('move_esto_codigo',Grid.cells[Grid.getcolumn('move_esto_codigo'),i]);
// 07.11.16 - Mettalum - para poder tirar do estoque e entrar direto na OS
      if Global.Topicos[1420] then
        Sistema.SetField('move_status','N')
      else if Global.Topicos[1412] then
        Sistema.SetField('move_status','R')
      else
        Sistema.SetField('move_status','N');
      Sistema.SetField('move_transacao',transacaoentrada);
      Sistema.SetField('move_unid_codigo',EdUNid_codigo.text);
      Sistema.SetField('move_core_codigo',texttovalor(Grid.cells[Grid.getcolumn('move_core_codigo'),i]) );
      Sistema.SetField('move_tama_codigo',texttovalor(Grid.cells[Grid.getcolumn('move_tama_codigo'),i]) );
      Sistema.SetField('move_qtde',texttovalor(Grid.cells[Grid.getcolumn('move_qtde'),i]));
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_tipo_codigo',EdTipo_codigo.asinteger);
      Sistema.SetField('move_tipocad',xTipoCad);
      Sistema.SetField('move_numerodoc',EdNumerodoc.asinteger);
      Sistema.SetField('move_tipomov',Global.CodSaidaAlmox);
      Sistema.SetField('move_datalcto',sistema.hoje);
      Sistema.SetField('move_datamvto',EdData.asdate);
      Sistema.SetField('move_datacont',EdData.asdate);
      Sistema.SetField('move_usua_codigo',Global.Usuario.Codigo);
      Sistema.SetField('move_grup_codigo',Qe.fieldbyname('esto_grup_codigo').asinteger);
      Sistema.SetField('move_sugr_codigo',Qe.fieldbyname('esto_sugr_codigo').asinteger);
      Sistema.SetField('move_fami_codigo',Qe.fieldbyname('esto_fami_codigo').asinteger);
      Sistema.SetField('move_locales',EdTipoestoque.text);
      Sistema.SetField('move_nroobra',EdNroobra.text);
//      Sistema.SetField('move_pecas',texttovalor(Grid.cells[Grid.getcolumn('move_pecas'),i]));
// 31.08.15 - Mettalum
      Sistema.SetField('move_venda',Q.fieldbyname('esqt_custo').ascurrency);
      Sistema.SetField('move_custo',Q.fieldbyname('esqt_custo').ascurrency);
//
      Sistema.post;
      FGeral.FechaQuery(Qe);
    end;

    function BaixaEstoque:boolean;
    //////////////////////////////
    var qtdeestoque:currency;
    begin
      result:=true;                // 20.01.10
      if (Global.Topicos[1210]) and ( trim(codestoque)<>'' )then begin
        qtdeestoque:=FEstoque.GetQtdeEmEstoque(EdUNid_codigo.Text,codestoque,Codcor,Codtamanho);
        if QTde>qtdeestoque then begin
          Avisoerro('Codigo '+codestoque+' Ref. '+referencia+' tem '+valortosql(qtdeestoque)+' em estoque.  N�o � poss�vel baixar.');
          result:=false;
          exit;
        end;
      end;
    end;

begin
//////////////////////////////////////////////////////////

   if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),1])='' then exit;
   if EdTipoconsulta.text<>'01' then begin
     Avisoerro('Tipo de consulta inv�lido para baixas');
     exit;
   end;

   if not confirma('Confirma baixa dos itens marcados ?') then exit;

   transacaoentrada:=FGeral.GetTransacao;
   Sistema.BeginProcess('Baixando itens marcados');
   if Grid.cells[Grid.getcolumn('move_operacao'),1]<>'' then begin

     if not Global.Topicos[1420] then
       GravaMestreEntProcesso;

// 31.08.15 - gravava mais de um mestre na mesma transacao/OS
     GravaMestreSaidaAlmox;
   end;

   for i:=1 to Grid.RowCount do begin

     operacao:=Grid.cells[Grid.getcolumn('move_operacao'),i];
     transacao:=Grid.cells[Grid.getcolumn('move_transacao'),i];
     qtde:=texttovalor(Grid.cells[Grid.getcolumn('move_qtde'),i]);
     codcor:=strtointdef(Grid.cells[Grid.getcolumn('move_core_codigo'),i],0);
//   28.01.10 - prever exclusao de cor do cadastro de cor mas requisicao ja feita
//   'rolos' para acerta o estoque
     if trim(Grid.cells[Grid.getcolumn('core_descricao'),i])='' then
       codcor:=0;
     codtamanho:=strtointdef(Grid.cells[Grid.getcolumn('move_tama_codigo'),i],0);
     codestoque:=Grid.cells[Grid.getcolumn('move_esto_codigo'),i];
     referencia:=Grid.cells[Grid.getcolumn('esto_referencia'),i];
     Q:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                   ' and esqt_esto_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),i])+
                   ' and esqt_status=''N''');
     if ( trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),i])<>'' ) and
        ( Grid.cells[Grid.getcolumn('marcado'),i]='Ok' ) and
        ( BaixaEstoque )
       then begin

//       Sistema.Edit('movesto');
//       Sistema.setfield('moes_status','N');
//       Sistema.Post('moes_transacao='+stringtosql(transacao)+' and moes_tipomov='+stringtosql(Global.Codrequisicaoalmox));
// ver quando mudar o status do mestre - 14.03.08
       Sistema.Edit('movestoque');
// 27.10.08  - retirado para nova forma de controle prevendo 'baixa parcial'
//       Sistema.setfield('move_status','N');
       Sistema.setfield('move_qtde',qtde+texttovalor(Grid.cells[Grid.getcolumn('qtdejabaixada'),i]));
       Sistema.setfield('move_usua_codigo',Global.Usuario.Codigo);
       Sistema.Post('move_operacao='+stringtosql(operacao));
//       FGeral.MovimentaQtdeEstoque( Grid.cells[Grid.getcolumn('move_esto_codigo'),i] ,EdUnid_codigo.text,'S',Global.codrequisicaoalmox,qtde,Q);
// 27.10.08
//       GravaMestreSaidaAlmox;
       GravaDetalheSaidaAlmox;
       FGeral.MovimentaQtdeEstoque( Grid.cells[Grid.getcolumn('move_esto_codigo'),i] ,EdUnid_codigo.text,'S',Global.CodSaidaAlmox,qtde,Q);

       if not Global.Topicos[1420] then
         GravaDetalheEntProcesso;

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
//          FGeral.MovimentaQtdeEstoqueGrade( Grid.cells[Grid.getcolumn('move_esto_codigo'),i] ,EdUnid_codigo.text,'S',Global.codrequisicaoalmox,codcor,codtamanho,0,qtde,QGrade);
// 16.10.09 - reqalmox nao movimenta estoque..s� quando da a saida do almox
          FGeral.MovimentaQtdeEstoqueGrade( Grid.cells[Grid.getcolumn('move_esto_codigo'),i] ,EdUnid_codigo.text,'S',Global.CodSaidaAlmox,codcor,codtamanho,0,qtde,QGrade);
          FGeral.FechaQuery(QGrade);
       end;
     end;
     FGeral.FechaQuery(Q);

   end;

   try
     Sistema.commit;
     Sistema.endprocess('Baixado itens marcados');
     Grid.clear;
     EdTipoEstoque.SetFocus;
   except
     Sistema.endprocess('N�o foi poss�vel efetuar a baixa');
   end;

end;

procedure TFRequisicao.edqtdebaixaExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin

  Grid.Cells[Grid.Col,Grid.Row]:=Transform(EdQtdebaixa.AsFloat,f_cr);
  Grid.cells[Grid.getcolumn('marcado'),Grid.row]:='Ok';
  Grid.SetFocus;
  EdQtdebaixa.Visible:=False;

end;

procedure TFRequisicao.GridKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    Grid.OnDblClick(self);
end;

procedure TFRequisicao.bmarcatodosClick(Sender: TObject);
var x:integer;
begin
  for x:=0 to Grid.rowcount do begin
    if trim( Grid.cells[Grid.getcolumn('move_esto_codigo'),x] ) <> '' then begin
        Grid.cells[Grid.getcolumn('marcado'),x]:='Ok';
    end;
  end;
end;

procedure TFRequisicao.bdesmarcatodosClick(Sender: TObject);
var x:integer;
begin
  for x:=0 to Grid.rowcount do begin
    if trim( Grid.cells[Grid.getcolumn('move_esto_codigo'),x] ) <> '' then begin
        Grid.cells[Grid.getcolumn('marcado'),x]:='';
    end;
  end;

end;

procedure TFRequisicao.bExcluirClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var i:integer;
    operacao,sqlcor,sqltamanho:string;
    qtde:currency;
    Q,QGrade:TSqlquery;
    codcor,codtamanho:integer;
    usougrade:boolean;

begin

   if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),1])='' then exit;
   if not confirma('Confirma EXCLUS�O dos itens marcados ?') then exit;
   Sistema.BeginProcess('Excluindo itens marcados');
   for i:=1 to Grid.RowCount do begin
     operacao:=Grid.cells[Grid.getcolumn('move_operacao'),i];
     qtde:=texttovalor(Grid.cells[Grid.getcolumn('move_qtde'),i]);
     codcor:=strtointdef( Grid.Cells[Grid.getcolumn('move_core_codigo'),Grid.row] ,0);
     codtamanho:=strtointdef( Grid.Cells[Grid.getcolumn('move_tama_codigo'),Grid.row] ,0);
     if (codcor>0) or (codtamanho>0) then
       usougrade:=true
     else
       usougrade:=false;
     if ( trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),i])<>'' ) and
         ( Grid.cells[Grid.getcolumn('marcado'),i]='Ok' )
       then begin
       Sistema.Edit('movestoque');
       Sistema.setfield('move_status','C');
       Sistema.setfield('move_usua_codigo',Global.Usuario.Codigo);
       Sistema.Post('move_operacao='+stringtosql(operacao));
{ - 24.09.09 - aqui nao muda o estoque pois � apenas requisicao, ou seja, nao mexeu no
    estoque ainda pois � status 'R' somente para separacao
///////////////////////////////////////////
       Q:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                   ' and esqt_esto_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),i])+
                    ' and esqt_status=''N''');
       if opx='S' then
         FGeral.MovimentaQtdeEstoque( Grid.cells[Grid.getcolumn('move_esto_codigo'),i],EdUnid_codigo.text,'E',Global.codrequisicaoalmox,qtde,Q)
       else
         FGeral.MovimentaQtdeEstoque( Grid.cells[Grid.getcolumn('move_esto_codigo'),i],EdUnid_codigo.text,'S',Global.CodEntradaprocesso,qtde,Q);
// 25.04.08
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
          QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),i])+
                 ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
          if opx='S' then
            FGeral.MovimentaQtdeEstoqueGrade(Grid.cells[Grid.getcolumn('move_esto_codigo'),i],EdUnid_codigo.Text,'E',Global.codrequisicaoalmox,codcor,codtamanho,0,qtde,QGrade,qtde,0)
          else
            FGeral.MovimentaQtdeEstoqueGrade(Grid.cells[Grid.getcolumn('move_esto_codigo'),i],EdUnid_codigo.Text,'S',Global.CodEntradaprocesso,codcor,codtamanho,0,qtde,QGrade,qtde,0);
          FGeral.FechaQuery(QGrade);
       end;
//////////////////////////////
}

// tem q apagar a respectiva saida do estoque em processo quando apaga uma entrada do almox vinda do est. em processo
       if opx='E' then begin
         Q:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                    ' and esqt_esto_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),i])+
                    ' and esqt_status=''N''');
         if trim(Grid.cells[Grid.getcolumn('move_core_codigo'),Grid.row])<>'' then
           sqlcor:=' and move_core_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_core_codigo'),Grid.row])
         else
           sqlcor:=' and ( move_core_codigo=0 or move_core_codigo is null )';
         if trim(Grid.cells[Grid.getcolumn('move_tama_codigo'),Grid.row])<>'' then
           sqltamanho:=' and move_tama_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_tama_codigo'),Grid.row])
         else
         sqltamanho:=' and ( move_tama_codigo=0 or move_tama_codigo is null )';
         Sistema.Edit('movestoque');
         Sistema.setfield('move_status','C');
         Sistema.setfield('move_usua_codigo',Global.Usuario.Codigo);
         Sistema.Post('move_transacao='+stringtosql(Grid.cells[Grid.getcolumn('move_transacao'),i])+
                      ' and move_esto_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),i])+
                      ' and move_tipomov='+stringtosql(Global.CodSaidaprocesso)+
                      sqlcor+sqltamanho+
                      ' and move_status=''N''' );
//         FGeral.MovimentaQtdeEstoque( Grid.cells[Grid.getcolumn('move_esto_codigo'),i] ,EdUnid_codigo.text,'S',Global.codrequisicaoalmox,qtde,Q);
// 16.10.09
         FGeral.MovimentaQtdeEstoque( Grid.cells[Grid.getcolumn('move_esto_codigo'),i] ,EdUnid_codigo.text,'E',Global.codSaidaAlmox,qtde,Q);
         FGeral.FechaQuery(Q);
// 25.04.08
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
            QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),i])+
                 ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
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
            QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),i])+
                   ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
//            FGeral.MovimentaQtdeEstoqueGrade(Grid.cells[Grid.getcolumn('move_esto_codigo'),i],EdUnid_codigo.Text,'S',Global.codrequisicaoalmox,codcor,codtamanho,0,qtde,QGrade,qtde,0);
            FGeral.MovimentaQtdeEstoqueGrade(Grid.cells[Grid.getcolumn('move_esto_codigo'),i],EdUnid_codigo.Text,'E',Global.codSaidaalmox,codcor,codtamanho,0,qtde,QGrade,qtde,0);
            FGeral.FechaQuery(QGrade);
         end;
       end;
     end;
   end;
   try
     Sistema.commit;
     Sistema.endprocess('Excluido itens marcados');
     Grid.clear;
     Totaliza;
     EdTipoEstoque.SetFocus;
   except
     Sistema.endprocess('N�o foi poss�vel efetuar a exclus�o');
   end;

end;

procedure TFRequisicao.EdProdutoValidate(Sender: TObject);
var codigobarra:boolean;
    QBusca:TSqlquery;
    codbarra:string;
begin
  codigobarra:=false;
  if FGeral.CodigoBarra(EdProduto.Text) then begin
    QBusca:=sqltoquery('select * from estoque where esto_Codbarra='+EdProduto.assql);
    codbarra:=EdProduto.text;
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
          EdProduto.Invalid('Codigo de barra n�o encontrado');
          exit;
    end;
    codigobarra:=true;
    EdQtde.Enabled:=false;
    EdQtde.SetValue(1);
    if not Qbusca.eof then begin
      QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
      if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsFloat,EdUNid_codigo.Text,QEstoque) then begin
         EdProduto.INvalid('Quantidade em estoque insuficiente');
         exit;
      end;
    end;
{
    EdCodcor.enabled:=false;
    EdCodtamanho.enabled:=false;
    EdCodcopa.enabled:=false;
    EdCodcor.text:='';
    EdCodtamanho.text:='';
    EdCodcopa.text:='';
}

  end else if trim(edproduto.text)<>'' then begin

    QBusca:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.assql);
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
      EdProduto.Invalid('Codigo n�o encontrado');
      exit;
    end;
    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                       ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    if QEstoque.eof then begin
       EdProduto.INvalid('Codigo n�o encontrado no estoque da unidade '+EdUnid_codigo.text);
       exit;
    end;
// 31.08.15
    if QEstoque.fieldbyname('esqt_custo').ascurrency<=0 then begin
       EdProduto.INvalid('Material ainda sem custo no cadastro');
       exit;
    end;
    Arq.TEstoque.locate('esto_codigo',Edproduto.text,[]);
    EdQtde.Enabled:=true;
{
//    EdCodcor.enabled:=true;
    EdCodcor.setvalue(0);
//    EdCodtamanho.enabled:=true;
    EdCodtamanho.setvalue(0);
//    EdCodcopa.enabled:=true;
    EdCodcopa.setvalue(0);
}
    EdQtde.SetValue(0);
  end;
  if QEstoque.eof then begin
      EdProduto.Invalid('Codigo ainda n�o cadastrado na unidade '+EdUnid_codigo.text);
      exit;
  end else begin
//    FGeral.SetaGradeCorTamanho(EdCodcor,EdCodTamanho,EdProduto.text,EdUnid_codigo.text);
// retirado por enquanto ate acertar melhor a grade - 22.10.08
  end;
// 08.08.09
  if OPx='S' then begin
    EdQtde.setvalue(0);
//    EdQtde.Enabled:=false;
// retirado devido aos itens q nao tem no pea como os vidros
// Robson - 06.10.09
  end else
    EdQtde.Enabled:=true;
end;

procedure TFRequisicao.EdQtdeExitEdit(Sender: TObject);
var conf:boolean;
    QBusca,QGrade:TSqlquery;
    Transacao,codestoque,sqlcor,sqltamanho,sqltipomov:String;
    usougrade:boolean;
    qtdeestoque:currency;

///////////////////29.09.08
    procedure IncluiGrade;
    begin
        Sistema.Insert('Estgrades');
        Sistema.Setfield('esgr_status','N');
        Sistema.Setfield('esgr_esto_codigo',EdProduto.text);
        Sistema.Setfield('esgr_unid_codigo',EdUnid_codigo.text);
        Sistema.Setfield('esgr_grad_codigo',0);
//        Sistema.Setfield('esgr_qtde',EdQtde.ascurrency );
//        Sistema.Setfield('esgr_qtdeprev',EdQtde.ascurrency );
        Sistema.Setfield('esgr_qtde',EdQtde.ascurrency );
        Sistema.Setfield('esgr_qtdeprev',EdQtde.ascurrency );
        Sistema.Setfield('esgr_codbarra','');
        Sistema.Setfield('esgr_custo',QEstoque.fieldbyname('esqt_custo').ascurrency);
        Sistema.Setfield('esgr_customedio',QEstoque.fieldbyname('esqt_customedio').ascurrency);
        Sistema.Setfield('esgr_custoger',QEstoque.fieldbyname('esqt_custoger').ascurrency);
        Sistema.Setfield('esgr_customeger',QEstoque.fieldbyname('esqt_customeger').ascurrency);
        Sistema.Setfield('esgr_vendavis',QEstoque.fieldbyname('esqt_vendavis').ascurrency);
        Sistema.Setfield('esgr_dtultvenda',EdData.asdate);
        Sistema.Setfield('esgr_dtultcompra',EdData.asdate);
        Sistema.Setfield('esgr_usua_codigo',Global.Usuario.codigo);
        Sistema.Setfield('esgr_tama_codigo',EdCodtamanho.asinteger);
        Sistema.Setfield('esgr_core_codigo',Edcodcor.AsInteger);
//        Sistema.Setfield('esgr_copa_codigo',xcodcopa);
        Sistema.Setfield('esgr_custoser',qEstoque.fieldbyname('esqt_custoser').ascurrency);
        Sistema.Setfield('esgr_customedioser',QEstoque.fieldbyname('esqt_customedioser').ascurrency);
        Sistema.Post();
        Sistema.Commit;
    end;

begin
///////////////////////////////
//  if (Global.Topicos[1210]) and (OPx<>'S') then begin
// 25.01.10
  if (Global.Topicos[1210]) and (OPx='S') then begin
    qtdeestoque:=FEstoque.GetQtdeEmEstoque(EdUNid_codigo.Text,EdProduto.text,EdCodcor.AsInteger,EdCodtamanho.AsInteger);
    if EdQTde.ascurrency>qtdeestoque then begin
      EdQtde.invalid(valortosql(qtdeestoque)+' em estoque.  N�o � poss�vel baixar.');
      exit;
    end;
  end;
  if codigobarra then
    conf:=true
  else
    conf:=confirma('Confirma item ?');
  sqltipomov:=' and '+FGeral.GetIn('moes_tipomov',Global.CodRequisicaoAlmox,'C');
// 22.01.14
  if Global.Topicos[1412] then
    sqltipomov:=' and '+FGeral.GetIn('moes_tipomov',Global.CodPedVenda,'C');
  if conf then begin
//    if opx='E' then begin
      if EdNumerodoc.AsInteger>0 then begin
//        Numerodoc:=FGeral.GetContador('AJUSTESALDO',false);
        sistema.beginprocess('Checando requisi��o');
        if opx='E' then
          QBusca:=sqltoquery('select * from movesto'+
              ' where moes_status=''N'' and '+FGeral.GetIn('moes_tipomov',Global.CodEntradaAlmox,'C')+
              ' and moes_numerodoc='+EdNumerodoc.AsSql+' and moes_datamvto='+EdData.AsSql+
              ' and moes_unid_codigo='+EdUnid_codigo.AsSql)
        else
          QBusca:=sqltoquery('select * from movesto'+
              ' where '+FGEral.getin('moes_status','N;R','C')+
              sqltipomov+
              ' and moes_numerodoc='+EdNumerodoc.AsSql+' and moes_datamvto='+EdData.AsSql+
              ' and moes_unid_codigo='+EdUnid_codigo.AsSql);
        sistema.endprocess('');
        if QBusca.eof then begin
          Transacao:=FGeral.GetTransacao;
          if opx='S' then
            GravaMestre(Transacao)    // 'abre os nova' para depois ser baixada - status 'R'
          else
            GravaMestres(Transacao);
        end else
          Transacao:=QBusca.fieldbyname('moes_transacao').asstring;
      end else begin  // 11.03.08
          Transacao:='';
      end;
////////////
// 24.04.08
      usougrade:=(EdCodcor.AsInteger+EdCodtamanho.asinteger)>0;
      if usougrade then begin
        codestoque:=edProduto.Text;
        if EdCodcor.AsInteger>0 then
          sqlcor:=' and esgr_core_codigo='+EdCodcor.assql
        else
          sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
        if EdCodtamanho.asinteger>0 then
          sqltamanho:=' and esgr_tama_codigo='+EdCodtamanho.assql
        else
          sqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
        QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+Stringtosql(codestoque)+
                      ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
        if (QGrade.eof) then begin
          IncluiGrade;
        end;
        QGrade.close;
      end;
////////////
      GravaDetalhe(Transacao);;
      EditstoGrid(Transacao);
//    end else
//      GravaDetalhe;
//    EditstoGrid;
    try
      sistema.commit;
      Totaliza;
    except
      Avisoerro('N�o foi poss�vel incluir este item');
    end;
  end;
  Edproduto.ClearAll(FRequisicao,99);
  EdProduto.SetFocus;
  Edcodcor.text:='';
  Edcodtamanho.text:='';
  FGeral.FechaQuery(QEstoque);

end;

procedure TFRequisicao.EditstoGrid(ctransacao:string);
//////////////////////////////////////////////////////////
var i:integer;
begin
  i:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.getcolumn('move_tama_codigo'),EdCodtamanho.asinteger,
                        Grid.getcolumn('move_core_codigo'),EdCodcor.asinteger,0,0);
  if i<=0 then begin
    if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),1])='') then begin
       i:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       i:=Grid.RowCount-1;
    end;
//     Grid.AppendRow;
     Grid.Cells[Grid.getcolumn('move_esto_codigo'),i]:=EdProduto.text;
     Grid.Cells[Grid.getcolumn('esto_descricao'),i]:=SetEdESTO_DESCRICAO.text;
     Grid.Cells[Grid.getcolumn('esto_referencia'),i]:=EdProduto.resultfind.fieldbyname('esto_referencia').asstring;
     Grid.Cells[Grid.getcolumn('core_descricao'),i]:=Setedcor.text;
     Grid.Cells[Grid.getcolumn('move_qtderetorno'),i]:=floattostr(EdQtde.asfloat);
     Grid.Cells[Grid.getcolumn('move_qtde'),i]:=floattostr(EdQtde.asfloat);
// 22.01.14
     Grid.Cells[Grid.getcolumn('move_venda'),i]:=floattostr(FEstoque.GetCusto(EdProduto.text,EdUnid_codigo.text,'custo'));
// ver gerar operacao quando inlcui um item a mais na req. do vims
     Grid.Cells[Grid.getcolumn('move_operacao'),i]:=goperacao;
//     Grid.Cells[Grid.getcolumn('move_transacao'),i]:='';
     Grid.Cells[Grid.getcolumn('move_transacao'),i]:=cTransacao;
     Grid.Cells[Grid.getcolumn('core_descricao'),i]:=Setedtamanho.text;
// 12.03.09
     Grid.Cells[Grid.getcolumn('esto_unidade'),i]:=EdProduto.resultfind.fieldbyname('esto_unidade').asstring;;
  end else
    Avisoerro('Item j� existente');

end;


procedure TFRequisicao.GravaDetalhe(ytransacao:string='');
//////////////////////////////////////////////////////////
var xtransacao,sqlcor,sqltamanho:string;
    QQtde,QGrade:TSqlquery;
    usougrade:boolean;
    codcor,codtamanho:integer;
begin
  goperacao:='';
  if opx='S' then begin
    if trim(ytransacao)='' then
      xtransacao:=Grid.cells[Grid.getcolumn('move_transacao'),01]
    else
      xtransacao:=ytransacao;  // 16.09.08
    if trim(xtransacao)='' then begin
      Avisoerro('N�o encontrada transa��o. Lan�amento n�o incluido');
      exit;
    end;
//    goperacao:=xTransacao+strzero(Grid.Row+10,3);
// 24.09.08
    goperacao:=FGeral.getoperacao;
    Sistema.Insert('movestoque');
    Sistema.SetField('move_esto_codigo',EdProduto.text);
    Sistema.SetField('move_status','R');
    Sistema.SetField('move_transacao',xtransacao);
    Sistema.SetField('move_unid_codigo',EdUNid_codigo.text);
    Sistema.SetField('move_core_codigo',EdCodcor.asinteger);
    Sistema.SetField('move_tama_codigo',EdCodtamanho.asinteger);
    Sistema.SetField('move_qtde',EdQtde.ascurrency);
    Sistema.SetField('move_qtderetorno',EdQtde.ascurrency);
    Sistema.SetField('move_operacao',goperacao );
//    Sistema.SetField('move_tipo_codigo',EdCliente.asinteger);
//    Sistema.SetField('move_tipocad','C');
    Sistema.SetField('move_tipo_codigo',EdTipo_codigo.asinteger);
    Sistema.SetField('move_tipocad',xTipoCad);
    Sistema.SetField('move_numerodoc',EdNumerodoc.asinteger);
// 22.01.14
    if Global.Topicos[1412] then
        Sistema.SetField('move_tipomov',Global.CodPedVenda)
    else
        Sistema.SetField('move_tipomov',Global.CodRequisicaoAlmox);

    Sistema.SetField('move_datalcto',sistema.hoje);
    Sistema.SetField('move_datamvto',EdData.asdate);
    Sistema.SetField('move_datacont',EdData.asdate);
    Sistema.SetField('move_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('move_grup_codigo',Edproduto.resultfind.fieldbyname('esto_grup_codigo').asinteger);
    Sistema.SetField('move_sugr_codigo',Edproduto.resultfind.fieldbyname('esto_sugr_codigo').asinteger);
    Sistema.SetField('move_fami_codigo',Edproduto.resultfind.fieldbyname('esto_fami_codigo').asinteger);
    Sistema.SetField('move_locales',EdTipoestoque.text);
    Sistema.SetField('move_nroobra',EdNroobra.text);
// 22.01.14
    Sistema.SetField('move_venda',FEstoque.GetCusto(EdProduto.text,EdUnid_codigo.text,'custo'));
    Sistema.post;
  end else begin
    xtransacao:=ytransacao;
    goperacao:=FGeral.GetOperacao;
    Sistema.Insert('movestoque');
    Sistema.SetField('move_esto_codigo',EdProduto.text);
    Sistema.SetField('move_status','N');
    Sistema.SetField('move_transacao',xtransacao);
    Sistema.SetField('move_unid_codigo',EdUNid_codigo.text);
    Sistema.SetField('move_core_codigo',EdCodcor.asinteger);
    Sistema.SetField('move_tama_codigo',EdCodtamanho.asinteger);
    Sistema.SetField('move_qtde',EdQtde.ascurrency);
    Sistema.SetField('move_qtderetorno',EdQtde.ascurrency);
    Sistema.SetField('move_operacao',goperacao );
//    Sistema.SetField('move_tipo_codigo',EdCliente.asinteger);
//    Sistema.SetField('move_tipocad','C');
    Sistema.SetField('move_tipo_codigo',EdTipo_codigo.text);
    Sistema.SetField('move_tipocad',xTipoCad);

    Sistema.SetField('move_numerodoc',EdNumerodoc.asinteger);
    Sistema.SetField('move_tipomov',Global.CodEntradaAlmox);
    Sistema.SetField('move_datalcto',sistema.hoje);
    Sistema.SetField('move_datamvto',EdData.asdate);
    Sistema.SetField('move_datacont',EdData.asdate);
    Sistema.SetField('move_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('move_grup_codigo',Edproduto.resultfind.fieldbyname('esto_grup_codigo').asinteger);
    Sistema.SetField('move_sugr_codigo',Edproduto.resultfind.fieldbyname('esto_sugr_codigo').asinteger);
    Sistema.SetField('move_fami_codigo',Edproduto.resultfind.fieldbyname('esto_fami_codigo').asinteger);
    Sistema.SetField('move_locales',EdTipoestoque.text);
    Sistema.SetField('move_nroobra',EdNroobra.text);
    Sistema.post;
    QQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUNid_codigo.AsSql+
                      ' and esqt_esto_codigo='+EdProduto.assql+' and esqt_status=''N''');
    FGeral.MovimentaQtdeEstoque(Edproduto.Text,EdUnid_codigo.text,'E',Global.CodEntradaAlmox,EdQtde.AsCurrency,QQtde);
    FGeral.FechaQuery(QQtde);
// 29.04.08
    codcor:=EdCodcor.asinteger;
    codtamanho:=EdCodtamanho.asinteger;
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
          QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'' and esgr_esto_codigo='+EdProduto.Assql+
                        ' and esgr_unid_codigo='+EdUnid_codigo.AsSql+sqltamanho+sqlcor);
          FGeral.MovimentaQtdeEstoqueGrade( Edproduto.text ,EdUnid_codigo.text,'E',Global.CodEntradaAlmox,codcor,codtamanho,0,Edqtde.ascurrency,QGrade);
          FGeral.FechaQuery(QGrade);
    end;

    Sistema.Insert('movestoque');
    Sistema.SetField('move_esto_codigo',EdProduto.text);
    Sistema.SetField('move_status','N');
    Sistema.SetField('move_transacao',xtransacao);
    Sistema.SetField('move_unid_codigo',EdUNid_codigo.text);
    Sistema.SetField('move_core_codigo',EdCodcor.asinteger);
    Sistema.SetField('move_tama_codigo',EdCodtamanho.asinteger);
    Sistema.SetField('move_qtde',EdQtde.ascurrency);
    Sistema.SetField('move_qtderetorno',EdQtde.ascurrency);
    Sistema.SetField('move_operacao',FGeral.GetOperacao );
//    Sistema.SetField('move_tipo_codigo',EdCliente.asinteger);
//    Sistema.SetField('move_tipocad','C');
    Sistema.SetField('move_tipo_codigo',Edtipo_codigo.asinteger);
    Sistema.SetField('move_tipocad',xTipoCad);
    Sistema.SetField('move_numerodoc',EdNumerodoc.asinteger);
    Sistema.SetField('move_tipomov',Global.CodSaidaprocesso);
    Sistema.SetField('move_datalcto',sistema.hoje);
    Sistema.SetField('move_datamvto',EdData.asdate);
    Sistema.SetField('move_datacont',EdData.asdate);
    Sistema.SetField('move_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('move_grup_codigo',Edproduto.resultfind.fieldbyname('esto_grup_codigo').asinteger);
    Sistema.SetField('move_sugr_codigo',Edproduto.resultfind.fieldbyname('esto_sugr_codigo').asinteger);
    Sistema.SetField('move_fami_codigo',Edproduto.resultfind.fieldbyname('esto_fami_codigo').asinteger);
    Sistema.SetField('move_locales',EdTipoestoque.text);
    Sistema.SetField('move_nroobra',EdNroobra.text);
// 11.05.10 - gerando com o custo do material pra poder tirar relatorio 'da �poca'
    Sistema.Setfield('move_custo',QEstoque.fieldbyname('esqt_custo').ascurrency);
    Sistema.Setfield('move_customedio',QEstoque.fieldbyname('esqt_customedio').ascurrency);
    Sistema.Setfield('move_custoger',QEstoque.fieldbyname('esqt_custoger').ascurrency);
    Sistema.Setfield('move_customeger',QEstoque.fieldbyname('esqt_customeger').ascurrency);
    Sistema.Setfield('move_venda',QEstoque.fieldbyname('esqt_vendavis').ascurrency);
    Sistema.post;
  end;
end;

procedure TFRequisicao.bIncluirClick(Sender: TObject);
begin
  PIns.Visible:=true;
  Grid.enabled:=false;
  EdProduto.SetFocus;
end;

procedure TFRequisicao.bCancelarClick(Sender: TObject);
begin
   PIns.Visible:=false;
   Grid.enabled:=true;
end;

procedure TFRequisicao.GravaMestres(rtransacao:string);
/////////////////////////////////////////////////////////////
begin
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',rTransacao);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',EdNumerodoc.AsInteger);
      Sistema.SetField('moes_tipomov',Global.CodEntradaAlmox);
      Sistema.SetField('moes_unid_codigo',EdUNid_codigo.Text);
      Sistema.SetField('moes_estado',FCidades.GetUF(EdUnid_codigo.ResultFind.fieldbyname('unid_cida_codigo').AsInteger));
//      Sistema.SetField('moes_repr_codigo',Representante);
      Sistema.SetField('moes_tipo_codigo',EdTipo_codigo.AsInteger);
      Sistema.SetField('moes_tipocad',xTipoCad);
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',EdData.AsDate);
      Sistema.SetField('moes_dataemissao',EdData.AsDate);
      Sistema.SetField('moes_nroobra',Ednroobra.text);
//      Sistema.SetField('moes_vlrtotal',Valortotal);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.Post();

      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',rTransacao);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',EdNumerodoc.AsInteger);
      Sistema.SetField('moes_tipomov',Global.CodSaidaProcesso);
      Sistema.SetField('moes_unid_codigo',EdUNid_codigo.Text);
      Sistema.SetField('moes_estado',FCidades.GetUF(EdUnid_codigo.ResultFind.fieldbyname('unid_cida_codigo').AsInteger));
//      Sistema.SetField('moes_repr_codigo',Representante);
      Sistema.SetField('moes_tipo_codigo',EdTipo_codigo.AsInteger);
      Sistema.SetField('moes_tipocad',xTipoCad);
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',EdData.AsDate);
      Sistema.SetField('moes_dataemissao',EdData.AsDate);
      Sistema.SetField('moes_nroobra',Ednroobra.text);
//      Sistema.SetField('moes_vlrtotal',Valortotal);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.Post();
end;

procedure TFRequisicao.FormActivate(Sender: TObject);
begin
  if EdUnid_codigo.isempty then begin
    EdUNid_codigo.text:=global.codigounidade;
    EdUnid_codigo.validfind;
  end;
  if EdData.isempty then
    EdData.setdate(sistema.hoje);

end;

procedure TFRequisicao.EdCodtamanhoValidate(Sender: TObject);
begin
   if not FGeral.ValidaGrade(Edcodcor.AsInteger,EdCodtamanho.AsInteger,0,EdProduto.Text) then
     EdCodtamanho.invalid('');
//   if (not EdCodtamanho.isempty) and (OPX='E') then begin
// 26.05.10 - Abra - Robson
// 25.06.10 - somente se informar tamanho senao da erro jamantossssauro...
   if (not EdCodtamanho.isempty) then begin
     if not FEstoque.ValidaComprimentoMinimo(Edproduto.text,EdCodtamanho.ResultFind.fieldbyname('tama_comprimento').asfloat/1000) then
       EdCodtamanho.invalid('');
   end;
//   end;
end;

procedure TFRequisicao.bchecasimilaresClick(Sender: TObject);
var p,codcor,codtamanho:integer;
    estoque:currency;
    material,camposim:string;

    function Checasim(s:string):boolean;
    begin
      result:=false;
      if ( trim(s)='') or ( trim(s)='NOK' ) then
        result:=true;
    end;

begin
  for p:=1 to Grid.rowcount do begin
    material:=Grid.cells[Grid.getcolumn('move_esto_codigo'),p];
    camposim:=Grid.cells[Grid.getcolumn('semestoque'),p];
    if (trim(material)<>'') and ( Checasim(camposim) ) then begin
       codcor:=strtointdef(Grid.cells[Grid.getcolumn('move_core_codigo'),p],0);
       codtamanho:=strtointdef(Grid.cells[Grid.getcolumn('move_tama_codigo'),p],0);
       estoque:=FEstoque.GetQtdeEmEstoque(EdUnid_codigo.text,material,codcor,codtamanho);
       if estoque<=0 then
         Grid.cells[Grid.getcolumn('semestoque'),p]:='NOK'
       else
         Grid.cells[Grid.getcolumn('semestoque'),p]:='OK'
    end;
  end;
end;

procedure TFRequisicao.bsimilaresClick(Sender: TObject);
var material:string;
    Q:TSqlquery;
begin
   material:=Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
   if trim(material)='' then exit;
   EdSimilar.text:='';
   EdSimilar.Items.Clear;
   Q:=sqltoquery('select * from similares inner join estoque on ( esto_codigo=simi_esto_similar)'+
                   ' where simi_esto_codigo='+stringtosql(material));
   if Q.eof then begin
     Aviso('N�o encontrado similiares cadastrados');
     FGeral.FechaQuery(Q);
   end else begin
     EdSimilar.Top:=Grid.TopEdit;
     EdSimilar.Left:=Grid.LeftEdit;
     EdSimilar.visible:=true;
     EdSimilar.enabled:=true;
     EdSimilar.SetFocus;
     pbotoes.Enabled:=false;
     pacerto.Enabled:=false;
     while not Q.eof do begin
       Edsimilar.Items.Add(strspace(Q.fieldbyname('simi_esto_similar').asstring,15)+' - '+Q.fieldbyname('esto_descricao').asstring);
       Q.Next;
     end;
   end;


end;

procedure TFRequisicao.edsimilarValidate(Sender: TObject);
var operacao:string;
begin
   pacerto.Enabled:=true;
   pbotoes.Enabled:=true;
   EdSimilar.Enabled:=false;
   EdSimilar.visible:=false;
   if EdSimilar.isempty then exit;
   operacao:=Grid.cells[Grid.getcolumn('move_operacao'),Grid.row];
   try
     Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row]:=Edsimilar.text;
     Sistema.Edit('movestoque');
     Sistema.SetField('move_esto_codigo',EdSimilar.Text);
     Sistema.Post('move_operacao='+stringtosql(operacao));
     Sistema.commit;
   except
     Avisoerro('N�o foi poss�vel gravar no banco de dados');
   end;
end;

procedure TFRequisicao.edsimilarKeyPress(Sender: TObject; var Key: Char);
begin
   if key=#27 then begin
     pacerto.Enabled:=true;
     pbotoes.Enabled:=true;
     EdSimilar.Enabled:=false;
     EdSimilar.visible:=false;
     EdSimilar.text:='';
   end;
end;

procedure TFRequisicao.bextratoClick(Sender: TObject);
begin
   FRelEstoque_ExtratoColunas;

end;

// 16.09.08 - geracao apenas quando 'abre os'
procedure TFRequisicao.GravaMestre(rtransacao: string);
///////////////////////////////////////////////////////////
begin
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',rTransacao);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','R');
      Sistema.SetField('moes_numerodoc',EdNumerodoc.AsInteger);
      if Global.Topicos[1412] then
        Sistema.SetField('moes_tipomov',Global.CodPedVenda)
      else
        Sistema.SetField('moes_tipomov',Global.CodRequisicaoAlmox);
      Sistema.SetField('moes_unid_codigo',EdUNid_codigo.Text);
      Sistema.SetField('moes_estado',FCidades.GetUF(EdUnid_codigo.ResultFind.fieldbyname('unid_cida_codigo').AsInteger));
//      Sistema.SetField('moes_repr_codigo',Representante);
      Sistema.SetField('moes_tipo_codigo',EdTipo_codigo.AsInteger);
      Sistema.SetField('moes_tipocad',xTipoCad);
      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',EdData.AsDate);
      Sistema.SetField('moes_dataemissao',EdData.AsDate);
      Sistema.SetField('moes_nroobra',Ednroobra.text);
//      Sistema.SetField('moes_vlrtotal',Valortotal);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.Post();

end;

procedure TFRequisicao.EdtipoconsultaKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.Limpaedit(Edtipoconsulta,key);
end;

procedure TFRequisicao.EdtipoconsultaValidate(Sender: TObject);
begin
  EdDesctipo.text:=GetItem(EdTipoconsulta)
end;

function TFRequisicao.GetItem(Ed: TSqled): string;
var p:integer;
begin
  result:='';
  for p:=0 to Ed.Items.Count-1 do begin
    if copy(Ed.Items.Strings[p],1,Ed.ItemsLength)=Ed.Text then begin
      result:=copy(Ed.Items.Strings[p],Ed.ItemsLength+4,20);
      break;
    end;
  end;
end;

procedure TFRequisicao.edqtdebaixaValidate(Sender: TObject);
begin
   if (EdQtdebaixa.ascurrency+texttovalor(Grid.Cells[Grid.getcolumn('qtdejabaixada'),Grid.row])) >
       texttovalor(Grid.Cells[Grid.getcolumn('move_qtderetorno'),Grid.row]) then
       Aviso('Aten��o.   Quantidade maior que a prevista a ser baixada');

end;

procedure TFRequisicao.bsaidasClick(Sender: TObject);
//////////////////////////////////////////////////////////
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
                 sqltam+sqlcor+' and '+fGeral.GetIN('move_tipomov',Global.CodRequisicaoAlmox+';'+Global.CodSaidaAlmox,'C')+
                 ' and move_status=''N'''+
                 ' and (  (move_nroobra='+EdNroobra.assql+') or (move_numerodoc='+EdNumerodoc.assql+') )');
   if Q.eof then begin
     Aviso('N�o encontrado saidas do codigo '+produto);
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
   AtivaSaidas;
end;

procedure TFRequisicao.AtivaSaidas;
begin
   psaidas.visible:=true;
   psaidas.enabled:=true;
   Grids.setfocus;
end;

procedure TFRequisicao.DesativaSaidas;
begin
   psaidas.visible:=false;
   psaidas.enabled:=false;
   Grid.setfocus;
end;

procedure TFRequisicao.bapagasaidaClick(Sender: TObject);
var operacao,sqlcor,sqltamanho:string;
    movestoque,usougrade:boolean;
    codcor,codtamanho:integer;
    Q,QGrade:TSqlquery;
    qtde:currency;
begin
   if trim(Grids.cells[Grids.getcolumn('move_operacao'),Grids.row])='' then exit;
   if not confirma('Confirma EXCLUS�O do item escolhido ?') then exit;
   movestoque:=confirma('Retorna a quantidade ao estoque ?');
   qtde:=texttovalor(Grids.cells[Grids.getcolumn('move_qtde'),Grids.row]);
   codcor:=strtointdef( Grid.Cells[Grid.getcolumn('move_core_codigo'),Grid.row] ,0);
   codtamanho:=strtointdef( Grid.Cells[Grid.getcolumn('move_tama_codigo'),Grid.row] ,0);
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
   Sistema.Edit('movestoque');
   Sistema.setfield('move_status','C');
   Sistema.setfield('move_usua_codigo',Global.Usuario.Codigo);
   Sistema.Post('move_operacao='+stringtosql(operacao));
   Sistema.Edit('movestoque');
   Sistema.setfield('move_status','C');
   Sistema.setfield('move_usua_codigo',Global.Usuario.Codigo);
   Sistema.Post('move_transacao='+stringtosql(Grids.cells[Grid.getcolumn('move_transacao'),Grid.row])+
                ' and move_esto_codigo='+stringtosql(Grids.cells[Grid.getcolumn('move_esto_codigo'),Grid.row])+
                ' and move_tipomov='+stringtosql(Global.CodSaidaprocesso)+
                sqlcor+sqltamanho+
                ' and move_status=''N''' );
   if Movestoque then begin
     Q:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                   ' and esqt_esto_codigo='+stringtosql(Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row])+
                   ' and esqt_status=''N''');
     FGeral.MovimentaQtdeEstoque( Grid.cells[Grid.getcolumn('move_esto_codigo'),grid.row],EdUnid_codigo.text,'E',Global.codSaidaalmox,qtde,Q);
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
          FGeral.MovimentaQtdeEstoqueGrade(Grid.cells[Grid.getcolumn('move_esto_codigo'),Grid.row],EdUnid_codigo.Text,'E',Global.codSaidaalmox,codcor,codtamanho,0,qtde,QGrade,qtde,0);
          FGeral.FechaQuery(QGrade);
     end;
     FGeral.FechaQuery(Q);
   end;
   try
     Grids.DeleteRow(Grid.Row);
     sistema.commit;
   except
     Avisoerro('N�o foi poss�vel gravar');
   end;
   Sistema.EndProcess('');
end;

procedure TFRequisicao.bfechasaidaClick(Sender: TObject);
begin
   DesativaSaidas;
end;


// 29.01.20
procedure TFRequisicao.bimpconsumoClick(Sender: TObject);
////////////////////////////////////////////////////////////
type TMateriais = record
     codigo : string;
     qtde   : currency;
end;

var PMateriais : ^TMateriais;

type TConsumo = record
     produto    : string;
     codcliente : integer;
     ListaMat   : TList;
end;

var Excel,
    FileName,
    Password,
    Readonly,
    valor,
    celula                  : Variant;
    arqu,
    codigomat,
    codigoprod,
    Transacaox,
    TiposSaida              : string;
    ListaCampos,
    ListaColunas,
    ListaProdutos,
    ListaC                  :TStringList;
    coluna,
    p,
    linha,
    posqtde,
    posproduto,
    i,
    nlin,
    codcli,
    xpedido                :integer;
    valorc,
    unitario               :currency;
    ListaConsumo           :TList;
    PConsumo               :^TConsumo;
    QProdutosVen           :TSqlquery;


    function GetCodigoProduto( s:string ):string;
    //////////////////////////////////////////////
    begin
       result:=s;  // ver qual(is) codigos usar
{
       if Uppercase( s) = 'P1' then result:=ListaProdutos[0] // '00852'
       else if Uppercase( s) = 'P2' then result:= ListaProdutos[1] //'00853'
       else if Uppercase( s) = 'P3' then result:= ListaProdutos[2] //'00854'
       else if Uppercase( s) = 'P4' then result:= ListaProdutos[3] //'00856'
       else if Uppercase( s) = 'P5' then result:= ListaProdutos[4] //'00861'
       else if Uppercase( s) = 'P6' then result:= ListaProdutos[5] //'00863'
       else if Uppercase( s) = 'P7' then result:= ListaProdutos[6] //'00864'
       else if Uppercase( s) = 'P8' then result:= ListaProdutos[7] //'00865'
       else if Uppercase( s) = 'P9' then result:= ListaProdutos[8] //'00866';
}
       if Uppercase( s) = 'P1' then result:='00852'
       else if Uppercase( s) = 'P2' then result:= '00853'
       else if Uppercase( s) = 'P3' then result:= '00854'
       else if Uppercase( s) = 'P4' then result:= '00856'
       else if Uppercase( s) = 'P5' then result:= '00861'
       else if Uppercase( s) = 'P6' then result:= '00863'
       else if Uppercase( s) = 'P7' then result:= '00864'
       else if Uppercase( s) = 'P8' then result:= '00865'
       else if Uppercase( s) = 'P10' then result:= '00583'
       else if Uppercase( s) = 'P11' then result:= '00884'
       else if Uppercase( s) = 'P12' then result:= '00885'
       else if Uppercase( s) = 'P13' then result:= '00886'
       else if Uppercase( s) = 'P14' then result:= '00369'
       else if Uppercase( s) = 'P15' then result:= '00552'
       else if Uppercase( s) = 'P16' then result:= '00473'
       else if Uppercase( s) = 'P17' then result:= '00475'
       else if Uppercase( s) = 'P18' then result:= '00476'
// 10.09.20
       else if Uppercase( s) = 'P19' then result:= '00477'
       else if Uppercase( s) = 'P19' then result:= '00478'
       else if Uppercase( s) = 'P20' then result:= '00479'
       else if Uppercase( s) = 'P21' then result:= '00480'
       else if Uppercase( s) = 'P22' then result:= '00497'
       else if Uppercase( s) = 'P23' then result:= '00504'
       else if Uppercase( s) = 'P23' then result:= '00505'
       else if Uppercase( s) = 'P24' then result:= '00512'
       else if Uppercase( s) = 'P25' then result:= '00513'
       else if Uppercase( s) = 'P26' then result:= '00521'
       else if Uppercase( s) = 'P27' then result:= '00522'
       else if Uppercase( s) = 'P28' then result:= '00523'
       else if Uppercase( s) = 'P29' then result:= '00524'
       else if Uppercase( s) = 'P30' then result:= '00525'

       else if Uppercase( s) = 'P9' then result:= '00866';


    end;

    procedure GravaMestre;
    //////////////////////
    begin

      xPedido := FGeral.GetContador('PEDVENDA',false);
      Sistema.Insert('Movesto');
      Sistema.SetField('moes_transacao',Transacaox);
      Sistema.SetField('moes_operacao',FGeral.GetOperacao);
      Sistema.SetField('moes_status','N');
      Sistema.SetField('moes_numerodoc',xPedido);
//      Sistema.SetField('moes_tipomov',Global.CodEntradaprocesso);
      Sistema.SetField('moes_tipomov',Global.CodOrdemdeServico);
//      Sistema.SetField('moes_comv_codigo',codigomov);
      Sistema.SetField('moes_unid_codigo',Global.CodigoUnidade);
      Sistema.SetField('moes_estado',Global.UFUnidade);
//      Sistema.SetField('moes_tipo_codigo',EdCliente.AsInteger);
//      Sistema.SetField('moes_tipocad','C');
      Sistema.SetField('moes_tipo_codigo',PConsumo.codcliente);
      Sistema.SetField('moes_tipocad','C');
//      Sistema.SetField('moes_repr_codigo',Representante);
      Sistema.SetField('moes_cida_codigo',FUnidades.GetCidaCodigo(Global.CodigoUnidade));

      Sistema.SetField('moes_datalcto',Sistema.Hoje);
      Sistema.SetField('moes_datamvto',Sistema.DataMvto);
      Sistema.SetField('moes_DataCont',Sistema.DataMvto);
      Sistema.SetField('moes_dataemissao',Sistema.DataMvto);
      Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
      Sistema.SetField('moes_nroobra',xPedido);
      Sistema.SetField('moeS_devolucoes','IMPEXCEL');
  //      Sistema.SetField('moes_pesoliq',pesoliq);
  //      Sistema.SetField('moes_pesobru',pesobru);
      Sistema.Post();

// aqui j� gravar o detalhe dos produtos acabados para puxar no sped
      Sistema.Insert('movestoque');
      Sistema.SetField('move_esto_codigo',PConsumo.produto);
//      if Global.Topicos[1420] then
//        Sistema.SetField('move_status','N')
//      else if Global.Topicos[1412] then
//        Sistema.SetField('move_status','R')
//      else
        Sistema.SetField('move_status','N');
      Sistema.SetField('move_transacao',transacaox);
      Sistema.SetField('move_unid_codigo',Global.CodigoUnidade);
//      Sistema.SetField('move_core_codigo',texttovalor(Grid.cells[Grid.getcolumn('move_core_codigo'),i]) );
//      Sistema.SetField('move_tama_codigo',texttovalor(Grid.cells[Grid.getcolumn('move_tama_codigo'),i]) );
      Sistema.SetField('move_qtde',1);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_tipo_codigo',PConsumo.codcliente);
      Sistema.SetField('move_tipocad','C');
      Sistema.SetField('move_numerodoc',xPedido);
      Sistema.SetField('move_tipomov',Global.CodOrdemdeServico);
      Sistema.SetField('move_datalcto',sistema.hoje);
      Sistema.SetField('move_datamvto',sistema.datamvto);
      Sistema.SetField('move_datacont',sistema.datamvto);
      Sistema.SetField('move_usua_codigo',Global.Usuario.Codigo);
//      Sistema.SetField('move_grup_codigo',Qe.fieldbyname('esto_grup_codigo').asinteger);
//      Sistema.SetField('move_sugr_codigo',Qe.fieldbyname('esto_sugr_codigo').asinteger);
//      Sistema.SetField('move_fami_codigo',Qe.fieldbyname('esto_fami_codigo').asinteger);
      Sistema.SetField('move_locales','01'); // estoque em processo
      Sistema.SetField('move_nroobra',xPedido);
      Sistema.SetField('move_devolucoes','IMPEXCEL');
//      Sistema.SetField('move_venda',Q.fieldbyname('esqt_custo').ascurrency);
//      Sistema.SetField('move_custo',Q.fieldbyname('esqt_custo').ascurrency);
//
      Sistema.post;

        Sistema.Insert('Movesto');
        Sistema.SetField('moes_transacao',Transacaox);
        Sistema.SetField('moes_operacao',FGeral.GetOperacao);
        Sistema.SetField('moes_status','N');
        Sistema.SetField('moes_numerodoc',xPedido);
        Sistema.SetField('moes_tipomov',Global.CodSaidaAlmox);
        Sistema.SetField('moes_unid_codigo',Global.CodigoUnidade);
        Sistema.SetField('moes_estado',Global.UFUnidade);
        Sistema.SetField('moes_tipo_codigo',PConsumo.codcliente);
        Sistema.SetField('moes_tipocad','C');
        Sistema.SetField('moes_cida_codigo',FUnidades.GetCidaCodigo(Global.CodigoUnidade));
        Sistema.SetField('moes_datalcto',Sistema.Hoje);
        Sistema.SetField('moes_datamvto',Sistema.DataMvto);
        Sistema.SetField('moes_DataCont',Sistema.DataMvto);
        Sistema.SetField('moes_dataemissao',Sistema.DataMvto);
        Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('moes_nroobra',xPedido);
        Sistema.SetField('moeS_devolucoes','IMPEXCEL');
  //      Sistema.SetField('moes_pesoliq',pesoliq);
  //      Sistema.SetField('moes_pesobru',pesobru);
        Sistema.Post();

    end;

    procedure GravaDetalhe;
    //////////////////////
    var Qe,
        Qt   :  TSqlquery;

    begin

      Qe:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(PMateriais.codigo));
      Qt:=sqltoquery('select * from estoqueqtde where esqt_esto_codigo='+stringtosql(PMateriais.codigo)+
                     ' and esqt_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                     ' and esqt_status = ''C''');
      Sistema.Insert('movestoque');
      Sistema.SetField('move_esto_codigo',PMateriais.codigo);
//      if Global.Topicos[1420] then
//        Sistema.SetField('move_status','N')
//      else if Global.Topicos[1412] then
//        Sistema.SetField('move_status','R')
//      else
        Sistema.SetField('move_status','N');
      Sistema.SetField('move_transacao',transacaox);
      Sistema.SetField('move_unid_codigo',Global.CodigoUnidade);
//      Sistema.SetField('move_core_codigo',texttovalor(Grid.cells[Grid.getcolumn('move_core_codigo'),i]) );
//      Sistema.SetField('move_tama_codigo',texttovalor(Grid.cells[Grid.getcolumn('move_tama_codigo'),i]) );
      Sistema.SetField('move_qtde',PMateriais.qtde);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_tipo_codigo',PConsumo.codcliente);
      Sistema.SetField('move_tipocad','C');
      Sistema.SetField('move_numerodoc',xPedido);
      Sistema.SetField('move_tipomov',Global.CodSaidaAlmox);
      Sistema.SetField('move_datalcto',sistema.hoje);
      Sistema.SetField('move_datamvto',sistema.datamvto);
      Sistema.SetField('move_datacont',sistema.datamvto);
      Sistema.SetField('move_usua_codigo',Global.Usuario.Codigo);
      Sistema.SetField('move_grup_codigo',Qe.fieldbyname('esto_grup_codigo').asinteger);
      Sistema.SetField('move_sugr_codigo',Qe.fieldbyname('esto_sugr_codigo').asinteger);
      Sistema.SetField('move_fami_codigo',Qe.fieldbyname('esto_fami_codigo').asinteger);
      Sistema.SetField('move_locales','01'); // estoque em processo
      Sistema.SetField('move_nroobra',xPedido);
      Sistema.SetField('move_devolucoes','IMPEXCEL');
//      Sistema.SetField('move_venda',Q.fieldbyname('esqt_custo').ascurrency);
//      Sistema.SetField('move_custo',Q.fieldbyname('esqt_custo').ascurrency);
//
      Sistema.post;
      FGeral.FechaQuery(Qe);
      FGeral.MovimentaQtdeEstoque( PMateriais.codigo,Global.CodigoUnidade,'S',Global.CodSaidaAlmox,PMateriais.qtde,Qt);
      FGeral.FechaQuery(Qt);

    end;


begin

  if not Sistema.GetDataMvto('Informe data de movimenta��o') then exit;

  if not Od2.Execute then exit;
  arqu:=Od2.FileName;
  if not FileExists( arqu ) then begin
    Avisoerro('Arquivo '+arqu+' n�o enconttrado');
    exit;
  end;
  try
    Excel := CreateOleObject('Excel.Application');
  except
    Avisoerro('N�o foi poss�vel executar o Excel');
    exit;
  end;
  Excel.Visible := false;
//  Excel.WorkBooks.Open( arqu );
  Excel.WorkBooks.Open(FileName := arqu, Password := '', ReadOnly := True);

  ListaCampos:=TStringList.Create;
  ListaColunas:=TStringList.Create;

  ListaCampos.Add('COD');
  ListaCampos.Add('P1');
  ListaCampos.Add('P2');
  ListaCampos.Add('P3');
  ListaCampos.Add('P4');
  ListaCampos.Add('P5');
  ListaCampos.Add('P6');
  ListaCampos.Add('P7');
  ListaCampos.Add('P8');
  ListaCampos.Add('P9');
  ListaCampos.Add('P10');
  ListaCampos.Add('P11');
  ListaCampos.Add('P12');
  ListaCampos.Add('P13');
  ListaCampos.Add('P14');
  ListaCampos.Add('P15');
  ListaCampos.Add('P16');
  ListaCampos.Add('P17');
  ListaCampos.Add('P18');
  ListaCampos.Add('P19');
  ListaCampos.Add('P20');
  ListaCampos.Add('P21');
  ListaCampos.Add('P22');
  ListaCampos.Add('P23');
  ListaCampos.Add('P24');
  ListaCampos.Add('P25');
  ListaCampos.Add('P26');
  ListaCampos.Add('P27');
  ListaCampos.Add('P28');
  ListaCampos.Add('P29');
  ListaCampos.Add('P30');
  Linha:=1;
  Coluna:=1;
  posqtde:=-1;
  posproduto:=-1;
  Sistema.BeginProcess('Apagando importa��o anterior nesta mesma data');
// apaga os OS geradas
  ExecuteSql('update movesto set moes_status=''C'' where moes_tipomov = '+Stringtosql(Global.CodOrdemdeServico)+
             ' and moes_datamvto = '+Datetosql(Sistema.DataMvto)+
             ' and moes_status   = ''N'''+
             ' and moes_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
             ' and moes_devolucoes = '+Stringtosql('IMPEXCEL') );
  ExecuteSql('update movestoQUE set moVe_status=''C'' where move_tipomov = '+Stringtosql(Global.CodOrdemdeServico)+
             ' and move_datamvto = '+Datetosql(Sistema.DataMvto)+
             ' and move_status   = ''N'''+
             ' and move_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
             ' and move_devolucoes = '+Stringtosql('IMPEXCEL') );
// apaga os consumos gerados
  ExecuteSql('update movesto set moes_status=''C'' where moes_tipomov = '+Stringtosql(Global.CodSaidaAlmox)+
             ' and moes_datamvto = '+Datetosql(Sistema.DataMvto)+
             ' and moes_status   = ''N'''+
             ' and moes_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
             ' and moes_devolucoes = '+Stringtosql('IMPEXCEL') );
  ExecuteSql('update movestoQUE set moVe_status=''C'' where move_tipomov = '+Stringtosql(Global.CodSaidaAlmox)+
             ' and move_datamvto = '+Datetosql(Sistema.DataMvto)+
             ' and move_status   = ''N'''+
             ' and move_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
             ' and move_devolucoes = '+Stringtosql('IMPEXCEL') );

// pegando os codigos dos produtos vendidos no mes...
  TiposSaida := Global.CodVendaDireta+';'+Global.CodContrato;
  QProdutosVen := sqltoquery('select move_esto_codigo from movestoque'+
                             ' inner join movesto on ( (moes_transacao=move_transacao) and (moes_tipomov=move_tipomov) )'+
                             ' where move_status <> ''N'''+
                             ' and '+FGeral.GetIN('move_tipomov',TiposSaida,'C')+
                             ' and move_datamvto <= '+Datetosql(Sistema.DataMvto)+
                             ' and move_datamvto >= '+Datetosql( DateToPrimeiroDiaMes(Sistema.DataMvto) )+
                             ' and move_unid_codigo = '+Stringtosql(Global.CodigoUnidade) );

  ListaProdutos := TStringList.Create;
  while not QProdutosven.Eof do begin

     if LIstaProdutos.IndexOf(QProdutosven.FieldByName('move_esto_codigo').AsString) = -1 then
        ListaProdutos.Add( QProdutosven.FieldByName('move_esto_codigo').AsString );

     QProdutosven.Next;

  end;
  FGeral.FechaQuery(QProdutosven);

  for p:=0 to ListaCampos.Count-1do begin

    While coluna < 30 Do begin

      if Uppercase( trim( Excel.Cells.Item[linha,coluna].Value2 ) ) = Uppercase( ListaCampos[p] ) then begin

         if Uppercase( ListaCampos[p] ) <> 'COD' then ListaColunas.Add( inttostr(coluna) );
         if Uppercase( ListaCampos[p] ) = 'P1' then posqtde:=coluna
         else if Uppercase( ListaCampos[p] ) = 'COD' then posproduto:=coluna;
         coluna:=1;
         break;

      end;
      inc(coluna);

    end;

  end;

  if ListaColunas.Count=0 then begin
     Avisoerro('N�o encontrado PELO MENOS COLUNA COD E P1 na linha 01.  '+ListaCampos.Text);
     Excel.quit;
     exit;
  end;

  Sistema.BeginProcess('Lendo planilha do excel');
  ListaConsumo := TList.Create;

  for I := 0 to ListaColunas.Count-1 do begin

// codigo do produto acabado produzido
       valor := Excel.Cells.Item[ 1, strtoint(ListaColunas[i]) ].Value2;
       codigoprod := ( valor );
       valor  := Excel.Cells.Item[ 3, strtoint(ListaColunas[i]) ].Value2;
       codcli := ( valor );
//       combinar com matteo para informar codigo do cliente na linha 3 abaixa de cada nome
       New( PConsumo );
       PConsumo.produto   :=GetCodigoProduto( codigoprod );
       PConsumo.codcliente:=codcli;
       PConsumo.ListaMat  := TList.Create;

    for p := 4 to 120 do begin

       Sistema.BeginProcess('Lendo linha '+inttostr(p)+' da coluna '+inttostr(i));
// codigo do material consumido
       valor:=Excel.Cells.Item[ p,posproduto ].Value2;
       valorc:=-1;
       if  VarIsNumeric( valor ) then valorc:=valor
       else if VarIsFloat( valor ) then valorc:=valor
       else if VarIsStr( valor ) then valorc:=Texttovalor( valor );

       if Valorc>0 then begin

          codigomat := strzero( strtoint(currtostr(valorc)),FGeral.GetConfig1AsInteger('TAMESTOQUE') );
          celula:=Excel.Cells.Item[ p,strtoint(ListaColunas[i]) ].Value2;
          valorc:=-1;
          if  VarIsNumeric( celula ) then valorc:=celula
          else if VarIsFloat( celula ) then valorc:=celula
          else if VarIsStr( celula ) then valorc:=Texttovalor( celula );
//          else Aviso('C�lula com tipo n�o tratado');
// qtde consumida
          if valorc >0 then begin

              New(PMateriais);
              PMateriais.codigo := codigomat;
              PMateriais.qtde   := (valorc) ;
              PConsumo.ListaMat.Add(Pmateriais);

          end;

       end;

    end;  // percorre as linhas da planilha

    ListaConsumo.Add( PConsumo );

  end; // para cada coluna p1, p2...


  Grid.Clear;
  nlin := 1;
  for p := 0 to ListaConsumo.count-1 do begin

       Sistema.BeginProcess('Gerando lan�amentos de '+PConsumo.produto);
       PConsumo := ListaConsumo[p];
       Transacaox := FGeral.GetTransacao;
       xPedido    := FGeral.GetContador('PEDVENDA',false);
       Sistema.BeginProcess('Gerando lan�amentos de '+PConsumo.produto);
       GravaMestre;

       for I := 0 to PConsumo.ListaMat.Count-1 do begin

         PMateriais := Pconsumo.ListaMat[i];
         Grid.Cells[ Grid.GetColumn('move_esto_codigo'),nlin] := PMateriais.codigo;
         Grid.Cells[ Grid.GetColumn('esto_referencia'),nlin]  := FEStoque.GetReferencia( PMateriais.codigo );
         Grid.Cells[ Grid.GetColumn('esto_descricao'),nlin]   := FEStoque.GetDescricao( PMateriais.codigo );
         Grid.Cells[ Grid.GetColumn('move_qtderetorno'),nlin] := FormatFloat(f_cr,PMateriais.qtde );
         Grid.Cells[ Grid.GetColumn('move_qtde'),nlin]        := FormatFloat(f_cr,PMateriais.qtde );
         Grid.Cells[ Grid.GetColumn('qtdejabaixada'),nlin]    := FormatFloat(f_cr,PMateriais.qtde );
         Gravadetalhe;
         inc( nlin );
         Grid.AppendRow;

       end;

  end;

  if ListaConsumo.Count>0 then begin

     try

       Sistema.Commit;
       Sistema.endprocess('Movimento gravado');

     except on E:exception do begin

       Sistema.endprocess('Erro na grava��o. '+E.Message);

     end;

     end;

  end else
       Sistema.endprocess('Nada gravado');


// gerar uma mestre de os pra cada produto acabado produzido
// gerar os respectivos detalhes...

end;

/////////////////////////////////////////////////////////////
procedure TFRequisicao.breprocessaClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var ListaReq:TList;
    obra,localexterno:string;
    QEstoque,QEstoqueqtde,QGrade,Q:TSqlquery;
    produto,gravar,coresincluidas,tamanhosincluidos,produtonovo,sqlcor,sqltamanho,transacao:string;
    Grupo,subgrupo,Familia,codcor,codtam,tamcodigo,xproduto,codcornovo,codtamnovo,xprodutonovo,codtamg,
    w,GrupoPerfil,Subgrupoperfil,Familiaperfil:integer;
    achouobra:boolean;

       procedure ChecaCor(xcorid:string);
       var QCor:TSqlquery;
       begin
// 28.10.09 - colocado query pois estava incluindo cores mesmo ja cadastradas
         if trim(xcorid)<>'' then begin
           xcorid:=TratamentotoCor(xcorid);
           Qcor:=sqltoquery('select * from cores where core_descricao='+stringtosql(trim(xcorid))+
                             ' order by core_descricao');
           if not Arq.TCores.active then Arq.TCores.open;
           Arq.TCores.First;
//           if not Arq.TCores.Locate('core_descricao',xcorid,[]) then begin
           if QCor.eof then begin
  //           Sistema.insert('cores');
             Arq.TCores.Insert;
             Arq.TCores.fieldbyname('core_codigo').asinteger:=codcornovo;
             Arq.TCores.fieldbyname('core_descricao').asstring:=xcorid;
             Arq.TCores.post;
             Arq.TCores.ApplyUpdates(0);
             coresincluidas:=coresincluidas+strzero(codcor,3)+';';
             codcor:=codcornovo;
             inc(codcornovo);
           end else
//             codcor:=Arq.TCores.fieldbyname('core_codigo').asinteger;
             codcor:=QCor.fieldbyname('core_codigo').asinteger;
           FGeral.FechaQuery(QCor);
         end;
       end;

       procedure ChecaTamanho(xtamanho:integer);
       var QTamanho:TSqlquery;
       begin
// 27.08.08 - colocado query pois estava incluindo tamanhos mesmo ja cadastrados
         QTamanho:=sqltoquery('select * from tamanhos where tama_descricao='+inttostr(xtamanho));
//         if (QTamanho.eof) and ( pos(strzero(codcor,3),tamanhosincluidos)=0)  then begin
//         if not Arq.TTamanhos.active then Arq.TTamanhos.open;
         if xtamanho>0 then begin
//           Arq.TTamanhos.First;
//           if not Arq.TTamanhos.Locate('tama_descricao',inttostr(xtamanho),[]) then begin
           if QTamanho.eof then begin

             if not Arq.TTamanhos.active then Arq.TTamanhos.open;
             Arq.TTamanhos.Insert;
             Arq.TTamanhos.FieldByName('tama_codigo').asinteger:=codtamnovo;
             Arq.TTamanhos.FieldByName('tama_descricao').asstring:=inttostr(xtamanho);
             Arq.TTamanhos.FieldByName('tama_reduzido').AsString:=inttostr(xtamanho);
             Arq.TTamanhos.FieldByName('tama_comprimento').AsCurrency:=xtamanho;
             Arq.TTamanhos.post;
             Arq.TTamanhos.ApplyUpdates(0);

{
             Sistema.Insert;
             Sistema.setfield('tama_codigo',codtamnovo);
             Sistema.setfield('tama_descricao').asstring:=inttostr(xtamanho);
             Sistema.setfield('tama_reduzido').AsString:=inttostr(xtamanho);
             Sistema.setfield('tama_comprimento').AsCurrency:=xtamanho;
             Sistema.post;
             Sistema.Commit;
}
             tamanhosincluidos:=tamanhosincluidos+strzero(codtam,3)+';';
             codtam:=codtamnovo;
             inc(codtamnovo);
           end else
//             codtam:=Arq.TTamanhos.fieldbyname('tama_codigo').asinteger;
             codtam:=QTamanho.fieldbyname('tama_codigo').asinteger;
         end else
           codtam:=0;   // 23.09.08
         FGeral.FechaQuery(QTamanho);
       end;

       function ObratoNUmero(obra:string):integer;
       var s:string;
       begin
//         s:=copy(obra,6,14);
//         s:=FGeral.TiraBarra(s,'-');
//         result:=strtointdef(s,0);
// 25.09.09
         if pos('VIMS',UpperCase(Obra))>0 then
           s:=copy(obra,6,14)
         else
           s:=copy(obra,1,14);
         s:=FGeral.TiraBarra(s,'-');
         result:=strtointdef(s,0);
       end;


       function GetTamanho(codigo:string):integer;
       var p:integer;
       begin
         result:=0;
         for p:=0 to ListaReq.Count-1 do begin
           PReq:=ListaReq[p];
           if PReq.codigopea=codigo then begin
             result:=PReq.tamanho;
             break;
           end;
         end;
       end;


    procedure BuscaItensAprov(produto:string);   // PERFIS
    ////////////////////////////////////////////////////
    var i:integer;
    begin
        New(PReq);
        PREq.obra:=dbforcam.fieldbyname('CODIGO').Asstring;
        PReq.produto:=produto;
//      PReq.qtde:=dbforcam.fieldbyname('NUMBARRAS').AsFLOAT;
// 22.09.08 - trazer em metros lineares e nao em barras
        PReq.qtde:=dbforcam.fieldbyname('NUMBARRAS').AsFLOAT*(dbforcam.fieldbyname('BARRA').Asinteger/1000);
//        PReq.qtde:=dbforcam.fieldbyname('PESOBRUTO').Asfloat;
        if PReq.qtde>0 then
          PReq.unitario:=dbforcam.fieldbyname('CUSTOPERF').AsFLOAT/PReq.qtde
        else
          PReq.unitario:=dbforcam.fieldbyname('CUSTOPERF').AsFLOAT;
        PReq.descricao:='';
        PReq.codigopea:=dbforcam.fieldbyname('CODPERF').Asstring;
        PReq.peso:=dbforcam.fieldbyname('PESOBRUTO').Asfloat;
        PReq.corid:=dbforcam.fieldbyname('ID').AsString;
        PReq.tamanho:=dbforcam.fieldbyname('BARRA').Asinteger;
        PReq.pecas:=dbforcam.fieldbyname('NUMBARRAS').AsFLOAT;
// 21.01.08
        PReq.pesosobra:=dbforcam.fieldbyname('PESOSOBRA').Asfloat;
        ListaReq.add(PReq);
    end;

    procedure BuscaItensAcessorios(produto:string);
    /////////////////////////////////////////////////
    var i:integer;
        achou:boolean;
    begin
        achou:=false;
        for i:=0 to ListaReq.count-1 do begin
          PReq:=ListaREq[i];
          if PReq.codigopea=dbforcam.fieldbyname('CODACES').Asstring then begin
            achou:=true;
            break;
          end;
        end;
        if not achou then begin
          New(PReq);
          PREq.obra:=dbforcam.fieldbyname('CODIGO').Asstring;
          PReq.produto:=produto;
          PReq.qtde:=dbforcam.fieldbyname('QTDE').AsFLOAT;
          PReq.unitario:=0;
          PReq.descricao:='';
          PReq.codigopea:=dbforcam.fieldbyname('CODACES').Asstring;
          PReq.peso:=0;
          PReq.pecas:=0;
          PReq.corid:=dbforcam.fieldbyname('TRAT').AsString;
// 24.09.09 - trat � diferente de ID -- RAL9003b E SA-P-RAL...
//          PReq.corid:=GetID(); ??
          PReq.tamanho:=0;
          PReq.pesosobra:=0;  // 20.06.08
          ListaReq.add(PReq);
        end else begin
          PReq.qtde:=PReq.qtde+dbforcam.fieldbyname('QTDE').AsFLOAT;
        end;
    end;

begin
///////////////////////////////////////////////////////////
   if Ednroobra.isempty then exit;
   if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),1])='' then exit;
   if not confirma('Confirma reprocessamento da obra ?') then exit;
// 15.10.09 - Robson preciso e confirmou com ana q tem varias obras nesta situacao   
   if Confirma('Usar Vims') then
     nrobra:='VIMS-'
   else
     nrobra:='';

   Q:=sqltoquery('select move_transacao from movestoque where move_operacao='+
                 stringtosql(Grid.Cells[Grid.getcolumn('move_operacao'),1])+
                 'and move_status=''R''' );
   if Q.eof then begin
     Avisoerro('N�o encontrado a transa��o referente a opera��o '+Grid.Cells[Grid.getcolumn('move_operacao'),1]);
     exit;
   end;
   transacao:=Q.fieldbyname('move_transacao').asstring;
   Q.Close;

//   localexterno:=FGeral.Getconfig1asstring('localpea');
// 19.10.09
   localexterno:=FGeral.GetLocalExternoPea;
// 09.10.09 = para nao mudar no sac 'da red'
//   localexterno:='P:\cemwin\';

   if trim(localexterno)='' then begin
      Avisoerro('Falta configurar o local do PEA na configura��o geral do sistema');
      exit;
   end else begin
// busca os perfis
////////////////////////
      dbforcam.Close;  // sem este close as vezes nao encontra..
      Sistema.beginprocess('Pesquisando perfis');
      dbforcam.FileName:=localexterno+'OBAPROV.DBF';
      try
        dbforcam.Open;
        if dbforcam.Eof then
          Avisoerro(dbforcam.FileName+' informa fim de arquivo(eof) j� na abertura');
      except
        Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
        exit;
      end;
      ListaReq:=TList.create;
      if pos( copy(EdNroobra.text,1,1),'89' ) >0 then
        obra:=nrobra+Trans(EdNroObra.text,'0#-####-##')
      else
        obra:=nrobra+Trans(EdNroObra.text,'##-####-##');
      achouobra:=false;
      while not dbforcam.Eof do begin
        if dbforcam.FieldByName('codigo').asstring=obra then begin
          BuscaItensAprov(dbforcam.fieldbyname('CODPERF').Asstring);
          achouobra:=true;
        end;
        dbforcam.Next;
      end;
      if not achouobra then begin
        Sistema.EndProcess('Obra '+obra+' n�o encontrada no arquivo '+dbforcam.FileName+' do Pea.  Reprocessamento n�o feito.');
        exit;
      end;
////////////////////////
// busca os acessorios
////////////////////////
      Sistema.beginprocess('Pesquisando acess�rios');
      dbforcam.close;
//      dbforcam.TableName:=localexterno+'OBACES.DBF';
// 01.12.07
//      dbforcam.TableName:=localexterno+'OBCALCA.DBF';
      dbforcam.FileName:=localexterno+'OBCALCA.DBF';
      try
        dbforcam.Open;
      except
        Avisoerro('N�o foi poss�vel abrir arquivo '+dbforcam.FileName);
//        EdPedido.invalid('N�o foi poss�vel abrir arquivo '+dbforcam.TableName);
        exit;
      end;
      while not dbforcam.Eof do begin
        if dbforcam.FieldByName('codigo').asstring=obra then begin
          QEstoque:=sqltoquery('select * from estoque where esto_referencia='+stringtosql(dbforcam.FieldByName('codaces').asstring));
          if not QEstoque.Eof then begin
//            EdPedido.invalid('Acess�rio codigo '+dbforcam.FieldByName('codaces').asstring+' n�o encontrado');
//            QEstoque.Close;
//            exit;
            BuscaItensAcessorios(dbforcam.fieldbyname('CODACES').Asstring);
//            showmessage('achou acessorio '+dbforcam.fieldbyname('CODACES').Asstring);
          end;
          FGeral.fechaquery(QEstoque);
        end;
        dbforcam.Next;
      end;
      dbforcam.Close;
////////////////////////
   end;
///////////////
//   elimina itens nao baixados
//////////////////////////////////
   Sistema.beginprocess('Eliminando itens ainda n�o baixados');
// 28.10.09 - pra nao apagar itens digitados pelo almox q nao tem o 'previsto'=qtdepea
   for w:=1 to Grid.rowcount do begin
     if ( strtointdef( Grid.Cells[Grid.getcolumn('qtdejabaixada'),w],0 )=0 ) and
        ( Texttovalor(Grid.Cells[Grid.getcolumn('move_qtderetorno'),w])>0 )  // qtde pea
       then begin
       Sistema.Edit('movestoque');
       Sistema.SetField('move_status','C');
       Sistema.Post('move_operacao='+stringtosql(Grid.Cells[Grid.getcolumn('move_operacao'),w])+
                    ' and move_status=''R'' and move_numerodoc='+EdNroobra.AsSql );
     end;
   end;
// 11.11.09
     if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),1])<>''  then
       Sistema.Commit;
///////////////////////////////
// 'regera' a os //////////
      GrupoPerfil:=FGeral.getconfig1asinteger('GRUPOPERF');
      SubGrupoPerfil:=FGeral.getconfig1asinteger('SUBGRUPERF');
      FamiliaPerfil:=FGeral.getconfig1asinteger('FAMILIAPERF');
      produtonovo:=FEstoque.GetProximoCodigo('estoque','esto_codigo','C');
      codcornovo:=FEstoque.GetProximoCodigo('cores','core_codigo','N');
      codtamnovo:=FEstoque.GetProximoCodigo('tamanhos','tama_codigo','N');
      tamcodigo:=length(produtonovo);
      xproduto:=strtointdef(produtonovo,0);
      xprodutonovo:=strtointdef(produtonovo,0);
      coresincluidas:='';
      tamanhosincluidos:='';
      for w:=0 to ListaReq.Count-1 do begin
        PReq:=ListaReq[w];
        QEstoque:=sqltoquery('select * from estoque where esto_referencia='+stringtosql(PReq.codigopea));
//////////////////////////
//        produto:='';
        if QEstoque.eof then begin
          if pos( copy(PReq.codigopea,1,2),'RM;CM;IN;US' )>0 then begin
            Grupo:=GrupoPerfil;
            Subgrupo:=Subgrupoperfil;
            Familia:=Familiaperfil;
          end else begin
            Grupo:=1;
            Subgrupo:=1;
            Familia:=1;
          end;
          Sistema.Insert('estoque');
          Sistema.SetField('esto_codigo',strzero(xprodutonovo,tamcodigo));
          Sistema.SetField('esto_descricao','Perfil '+PReq.codigopea);
//          Sistema.SetField('esto_unidade','BR');
//          Sistema.SetField('esto_unidade','KG');
// 28.04.08
          Sistema.SetField('esto_unidade','MT');
          Sistema.SetField('esto_embalagem',1);
          if Preq.qtde>0 then
            Sistema.SetField('esto_peso',PREq.peso/Preq.qtde);
          Sistema.SetField('esto_grup_codigo',Grupo);  // ver como fazer com grupo, subgrupo e familia
          Sistema.SetField('esto_sugr_codigo',Subgrupo);
          Sistema.SetField('esto_fami_codigo',Familia);
          Sistema.SetField('esto_emlinha','S');
          Sistema.SetField('esto_referencia',PReq.codigopea);
          Sistema.SetField('esto_mate_codigo',0);
          Sistema.SetField('esto_usua_codigo',Global.Usuario.Codigo);
//   varchar(20),
//  esto_precocompra numeric(13,4),
//  esto_cipi_codigo numeric(4),
          Sistema.Post;
          Sistema.commit;
          gravar:='S';
          xproduto:=xprodutonovo;
          inc(xprodutonovo);
        end else
          xproduto:=QEstoque.fieldbyname('esto_codigo').asinteger;
//////////////////////////
        FGeral.FechaQuery(QEstoque);

//////////////////////////
//        if trim(produtonovo)<>'' then begin
        if xproduto>0 then begin
          QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                                       ' and esqt_esto_codigo='+stringtosql(strzero(xproduto,tamcodigo))+' and esqt_status=''N''');
          if QEstoqueQTde.eof then begin
              Sistema.Insert('EstoqueQtde');
              Sistema.Setfield('esqt_status','N');
              Sistema.Setfield('esqt_unid_codigo',EdUNid_codigo.text);
              Sistema.Setfield('esqt_esto_codigo',strzero(xproduto,tamcodigo));
              Sistema.Setfield('esqt_qtde',0);
              Sistema.Setfield('esqt_qtdeprev',0);
              Sistema.Setfield('esqt_vendavis',PReq.unitario);
              Sistema.Setfield('esqt_custo',PReq.unitario);
              Sistema.Setfield('esqt_custoger',PReq.unitario);
              Sistema.Setfield('esqt_customedio',PReq.unitario);
              Sistema.Setfield('esqt_customeger',PReq.unitario);
              Sistema.Setfield('esqt_dtultvenda',Sistema.hoje);
//              Sistema.Setfield('esqt_dtultcompra',Sistema.Hoje);
              Sistema.Setfield('esqt_desconto',0);
              Sistema.Setfield('esqt_basecomissao',0);
  // habilitar campos do cadastro de unidades -
              Sistema.Setfield('esqt_cfis_codigoest',FUnidades.GetFiscalDentro(EdUNid_codigo.text));
              Sistema.Setfield('esqt_cfis_codigoforaest',FUnidades.GetFiscalFora(EdUNid_codigo.text));
              Sistema.Setfield('esqt_sitt_codestado',FUnidades.GetSittDentro(EdUNid_codigo.text) );
              Sistema.Setfield('esqt_sitt_forestado',FUnidades.GetSittFora(EdUNid_codigo.text));
              Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
              Sistema.Post('');
              Sistema.commit;
              gravar:='S';
//////////////////              xproduto:=xprodutonovo;
              FGeral.Fechaquery(QEstoqueqtde);
// para usar na gravacao da nova grade...
              QEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_unid_codigo='+EdUnid_codigo.assql+
                                       ' and esqt_esto_codigo='+stringtosql(strzero(xproduto,tamcodigo))+' and esqt_status=''N''');
          end else begin  // 22.09.08 - atualiza o custo
// - deixar pela nota de entrada
{
              Sistema.Edit('EstoqueQtde');
              Sistema.Setfield('esqt_vendavis',PReq.unitario);
              Sistema.Setfield('esqt_custo',PReq.unitario);
              Sistema.Setfield('esqt_custoger',PReq.unitario);
              Sistema.Setfield('esqt_customedio',PReq.unitario);
              Sistema.Setfield('esqt_customeger',PReq.unitario);
              Sistema.Setfield('esqt_dtultvenda',Sistema.hoje);
              Sistema.Post('esqt_unid_codigo='+EdUnid_codigo.assql+
                           ' and esqt_esto_codigo='+stringtosql(strzero(xproduto,tamcodigo))+
                           ' and esqt_status=''N''');
              Sistema.commit;
//}
          end;
        end;
///////////////////////////////////
        ChecaCor(PReq.corid);
        ChecaTamanho(PReq.tamanho);
        QEstoque:=sqltoquery('select * from estoque where esto_codigo='+stringtosql(strzero(xproduto,tamcodigo)));
        Sistema.Insert('movestoque');
        Sistema.SetField('move_esto_codigo',strzero(xproduto,tamcodigo));
// 01.10.09 - componentes nao tem grade
        if QEstoque.fieldbyname('esto_grup_codigo').AsInteger=FGeral.GetConfig1AsInteger('Grupocompon') then begin
          codtam:=0;codcor:=0;
        end;
        Sistema.SetField('move_tama_codigo',codtam);
        Sistema.SetField('move_core_codigo',codcor);
        Sistema.SetField('move_copa_codigo',0);
        Sistema.SetField('move_transacao',transacao);
        Sistema.SetField('move_operacao',strspace(transacao+strzero(w,3),16) );
        Sistema.SetField('move_numerodoc',ObratoNumero(PReq.obra));
        Sistema.SetField('move_status','R');
        Sistema.SetField('move_tipomov',Global.CodRequisicaoAlmox);
        Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
        Sistema.SetField('move_tipo_codigo',edCliente.AsInteger);
        Sistema.SetField('move_tipocad','C');
        if EdCliente.ResultFind<>nil then
          Sistema.SetField('move_repr_codigo',EdCliente.resultfind.fieldbyname('clie_repr_codigo').asinteger);
        Sistema.SetField('move_qtde',PReq.qtde);
// 08.04.08
//        Sistema.SetField('move_qtde',PReq.peso);
        Sistema.SetField('move_datalcto',Sistema.Hoje);
        Sistema.SetField('move_datacont',Sistema.Hoje);
        Sistema.SetField('move_datamvto',Sistema.Hoje);
        Sistema.SetField('move_qtderetorno',PReq.qtde);
// 08.04.08
//        Sistema.SetField('move_qtderetorno',PReq.peso);
        Sistema.SetField('move_custo',PREq.unitario);
        Sistema.SetField('move_custoger',PREq.unitario);
        Sistema.SetField('move_customedio',PREq.unitario);
        Sistema.SetField('move_customeger',PREq.unitario);
//        Sistema.SetField('move_cst',Grid.Cells[grid.getcolumn('move_cst'),linha]);
//        Sistema.SetField('move_aliicms',texttovalor(Grid.Cells[grid.getcolumn('move_aliicms'),linha]));
        Sistema.SetField('move_venda',PREq.unitario);
        Sistema.SetField('move_grup_codigo',QEstoque.fieldbyname('esto_grup_codigo').AsInteger);
        Sistema.SetField('move_sugr_codigo',QEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
        Sistema.SetField('move_fami_codigo',QEstoque.fieldbyname('esto_fami_codigo').AsInteger);
        Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
        Sistema.SetField('move_pecas',PReq.pecas);
        Sistema.SetField('move_nroobra',ObratoNumero(PReq.obra));
// 21.01.08
        Sistema.SetField('move_peso',PReq.peso);
        Sistema.SetField('move_pesosobra',PReq.pesosobra);

//        Sistema.SetField('move_perdesco',texttovalor(Grid.Cells[grid.getcolumn('move_perdesco'),linha]));
//        Sistema.SetField('move_vendabru',texttovalor(Grid.Cells[grid.getcolumn('move_vendabru'),linha]));
//          Sistema.SetField('move_remessas',remessas);
//          Sistema.SetField('move_clie_codigo',moes_clie_codigo);
//        Sistema.SetField('move_aliipi',texttovalor(Grid.Cells[grid.getcolumn('move_aliipi'),linha]));
//        Sistema.SetField('move_vendamin',texttovalor(Grid.Cells[grid.getcolumn('move_vendamin'),linha]));
//        Sistema.SetField('move_redubase',texttovalor(Grid.Cells[grid.getcolumn('move_redubase'),linha]));
        Sistema.post;
        Sistema.commit;
// 29.04.08 - checa se precisa gravar nova grade de tamanho+cor - 'BARRAS INTEIRAS'
/////////////////////////////////////
        if  (codtam+codcor)>0 then begin
            if Codcor>0 then
              sqlcor:=' and esgr_core_codigo='+inttostr(Codcor)
            else
              sqlcor:=' and ( esgr_core_codigo=0 or esgr_core_codigo is null )';
            if Codtam>0 then
              sqltamanho:=' and esgr_tama_codigo='+inttostr(Codtam)
            else
              sqltamanho:=' and ( esgr_tama_codigo=0 or esgr_tama_codigo is null )';
            QGrade:=sqltoquery('select * from estgrades where esgr_unid_codigo='+EdUnid_codigo.assql+
                                         ' and esgr_esto_codigo='+stringtosql(strzero(xproduto,tamcodigo))+' and esgr_status=''N'''+
                                         sqlcor+sqltamanho);
            if QGrade.eof then begin
              Sistema.Insert('Estgrades');
              Sistema.Setfield('esgr_status','N');
              Sistema.Setfield('esgr_esto_codigo',strzero(xproduto,tamcodigo));
              Sistema.Setfield('esgr_unid_codigo',EdUnid_codigo.text);
              Sistema.Setfield('esgr_grad_codigo',0);
      //        Sistema.Setfield('esgr_qtde',EdQtde.ascurrency );
      //        Sistema.Setfield('esgr_qtdeprev',EdQtde.ascurrency );
              Sistema.Setfield('esgr_qtde',0 );
              Sistema.Setfield('esgr_qtdeprev',0 );
              Sistema.Setfield('esgr_codbarra','');
              Sistema.Setfield('esgr_custo',QEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
              Sistema.Setfield('esgr_customedio',QEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
              Sistema.Setfield('esgr_custoger',QEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
              Sistema.Setfield('esgr_customeger',QEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
              Sistema.Setfield('esgr_vendavis',QEstoqueQtde.fieldbyname('esqt_vendavis').ascurrency);
              Sistema.Setfield('esgr_dtultvenda',Sistema.hoje);
              Sistema.Setfield('esgr_dtultcompra',Sistema.hoje);
              Sistema.Setfield('esgr_usua_codigo',Global.Usuario.codigo);
              Sistema.Setfield('esgr_tama_codigo',Codtam);
              Sistema.Setfield('esgr_core_codigo',codcor);
      //        Sistema.Setfield('esgr_copa_codigo',xcodcopa);
              Sistema.Setfield('esgr_custoser',qEstoqueQtde.fieldbyname('esqt_custoser').ascurrency);
              Sistema.Setfield('esgr_customedioser',QEstoqueQtde.fieldbyname('esqt_customedioser').ascurrency);
              Sistema.Post();
              Sistema.commit;
            end;
            FGeral.FechaQuery(QGrade);
        end;
        FGeral.Fechaquery(QEstoqueqtde);
      end;  // ref. for dos itens
   Sistema.endprocess('Reprocessamento Terminado');
   Grid.Clear;
   EdNumerodoc.setfocus;
   EdNumerodoc.valid;
/////////////////////////////////////////////////////////////////

/////////////

end;

function TFRequisicao.TratamentotoCor(xcorid: string): string;
var xtrat:string;
begin
// ir colocando cfe as cores 'novas'
   xtrat:=uppercase(xcorid);
   if ansipos('RAL9003B',xtrat)>0 then
//     xtrat:='RAL9003B';
     xtrat:='BRANCO RAL9003B'
   else if ( ansipos('1000-A13',xtrat)>0  ) or ( ansipos('1000-A23',xtrat)>0 ) then
     xtrat:='ANOD 1000-A13'
   else if ( ansipos('1003-A13',xtrat)>0  ) or ( ansipos('1003-A23',xtrat)>0 ) then
     xtrat:='ANOD 1003-A13'
   else if ( ansipos('CM',xtrat)>0  ) or ( ansipos('TBRUTO',xtrat)>0 ) or ( ansipos('SBRUTO',xtrat)>0 ) then
     xtrat:='NATURAL - SEM TRATAMENTO';
   result:=xtrat;
end;

procedure TFRequisicao.EdQtdeValidate(Sender: TObject);
begin
  if ( Global.Topicos[1338] ) and (EdCodTamanho.AsInteger>0)
     and (EdQtde.AsFloat>0) then
    EdQtde.setvalue( (EdQtde.asfloat*FTamanhos.GetComprimento(EdCodTamanho.AsInteger))/1000 );

end;

procedure TFRequisicao.EdcodcorValidate(Sender: TObject);
begin
   if not FCores.ValidaCor(EdCodcor) then
     EdCodcor.Invalid('');
end;

procedure TFRequisicao.bajudaClick(Sender: TObject);
////////////////////////////////////////////////////////
begin
// 06.08.13
 FGeral.ExecutaHelp('Requisi��oAlmox');

end;

procedure TFRequisicao.EdProdutoKeyPress(Sender: TObject; var Key: Char);
/////////////////////////////////////////////////////////////////////////////
begin
  if key=#27 then bcancelarclick(self);
end;

// 22.01.14
procedure TFRequisicao.Totaliza;
///////////////////////////////
var p:integer;
    vlr,qtd,xtotal:currency;
begin
  xtotal:=0;
  for p:=1 to grid.RowCount-1 do begin
    if trim( grid.Cells[Grid.getcolumn('move_esto_codigo'),p] ) <>'' then begin
      vlr:=Texttovalor( grid.Cells[Grid.getcolumn('move_venda'),p] );
      qtd:=Texttovalor( grid.Cells[Grid.getcolumn('move_qtde'),p] );
      xtotal:=xtotal + (vlr*qtd);
    end;
  end;
  Edtotal.Text:=floattostr(xtotal);
end;

end.
