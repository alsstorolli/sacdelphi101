{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE ON}
{$WARN UNSAFE_CODE ON}
{$WARN UNSAFE_CAST ON}
unit Pospedi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, DBGrids, SqlFun, SqlExpr, ACBrBase, ACBrMail, Data.DB ;

type
  TFPosicaoPedidoVenda = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bSair: TSQLBtn;
    bemail: TSQLBtn;
    bocorrencia: TSQLBtn;
    bimp: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    GridItens: TSqlDtGrid;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    Edcliente: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdRepr_codigo: TSQLEd;
    SQLEd3: TSQLEd;
    PIns: TSQLPanelGrid;
    EdQtde: TSQLEd;
    PPedidos: TSQLPanelGrid;
    PTotais: TSQLPanelGrid;
    Edqtdeprod: TSQLEd;
    EdQtdeenviada: TSQLEd;
    bautoriza: TSQLBtn;
    GridPedidos: TSqlDtGrid;
    EdValorpedidos: TSQLEd;
    Edtodos: TSQLEd;
    bfatura: TSQLBtn;
    EdCaoc_codigo: TSQLEd;
    EdCaoc_descricao: TSQLEd;
    bbaixapedido: TSQLBtn;
    bmontagem: TSQLBtn;
    PMontagem: TSQLPanelGrid;
    EdDtMontagem: TSQLEd;
    EdPrevisao: TSQLEd;
    EdBaixa: TSQLEd;
    PFinanceiro: TSQLPanelGrid;
    GridFinan: TSqlDtGrid;
    bautorizaproducao: TSQLBtn;
    balterapedido: TSQLBtn;
    bimpcomcusto: TSQLBtn;
    bimpop: TSQLBtn;
    bcancelareserva: TSQLBtn;
    balteracor: TSQLBtn;
    Setedcor2: TSQLEd;
    Edcodespeto: TSQLEd;
    breserva: TSQLBtn;
    EdContato: TSQLEd;
    ACBrMail1: TACBrMail;
    bwhatsapp: TSQLBtn;
    EdDatai: TSQLEd;
    EdDataf: TSQLEd;
    Timer1: TTimer;
    bbuscacontato: TSQLBtn;
    cbtipos: TComboBox;
    Label1: TLabel;
    procedure EdclienteValidate(Sender: TObject);
    procedure GridPedidosClick(Sender: TObject);
    procedure GridPedidosKeyPress(Sender: TObject; var Key: Char);
    procedure EdtodosValidate(Sender: TObject);
    procedure bocorrenciaClick(Sender: TObject);
    procedure bimpClick(Sender: TObject);
    procedure bautorizaClick(Sender: TObject);
    procedure bfaturaClick(Sender: TObject);
    procedure EdQtdeValidate(Sender: TObject);
    procedure EdCaoc_codigoValidate(Sender: TObject);
    procedure bbaixapedidoClick(Sender: TObject);
    procedure EdCaoc_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdQtdeKeyPress(Sender: TObject; var Key: Char);
    procedure bmontagemClick(Sender: TObject);
    procedure EdPrevisaoValidate(Sender: TObject);
    procedure EdPrevisaoExitEdit(Sender: TObject);
    procedure EdBaixaValidate(Sender: TObject);
    procedure bautorizaproducaoClick(Sender: TObject);
    procedure balterapedidoClick(Sender: TObject);
    procedure GridPedidosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure bimpcomcustoClick(Sender: TObject);
    procedure bimpopClick(Sender: TObject);
    procedure bcancelareservaClick(Sender: TObject);
    procedure balteracorClick(Sender: TObject);
    procedure EdcodespetoExitEdit(Sender: TObject);
    procedure breservaClick(Sender: TObject);
    procedure GridPedidosDblClick(Sender: TObject);
    procedure bemailClick(Sender: TObject);
    procedure bwhatsappClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdContatoExitEdit(Sender: TObject);
    procedure bbuscacontatoClick(Sender: TObject);
    procedure cbtiposClick(Sender: TObject);
  private
    function PedidoFinanOK: boolean;
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(tipo:string='C' ; xCliente:integer=0);
    procedure Queryitenstogrid(Q1:TMemoryquery ; GridDetalhe:TSqldtgrid ; pedido:string);
    function FinanceiroOK(dataautoriza:TDatetime ; envio:string):string;
    function FinanceiroLiberado:boolean;

  end;

var
  FPosicaoPedidoVenda: TFPosicaoPedidoVenda;
  QPedidos           :TMemoryQuery;
  unidade,clirepr,
  carnesescolhidas,
  pedidosescolhidos,
  sqlfiltroitens     :string;
  ListaPedidos       :TStringlist;

implementation

uses Geral, Sqlsis, Ocorrenc, impressao, cadocor, Usuarios, Pedvenda,
  impressaoop, Estoque, gerenciawhats, cadcli, diversos, Menuinicial;

{$R *.dfm}

procedure TFPosicaoPedidoVenda.Execute(tipo:string='C'; xCliente:integer=0);
//////////////////////////////////////////////////////////////////////////////
begin

// 16.06.2021 - Benato - pedido carne assada
   if Global.topicos[1426] then begin

      GridItens.Columns[3].Title.Caption := 'Espeto';

   end;
   sqlfiltroitens := '';

   Show;

   if tipo='R' then begin
//     FPosicaoPedidoVenda.Caption:='Posi��o de Pedido de Venda por Representante';

     FPosicaoPedidoVenda.Caption:='Posi��o de Pedido de Venda Geral';
     EdCliente.enabled:=false;
     EdRepr_codigo.enabled := true;
     balteracor.Enabled:=false;
     breserva.Enabled  :=false;
     edcontato.visible  := true;
     EdRepr_codigo.setfocus;
     EdTodos.setfocus;
     bbuscacontato.visible  := true;

   end else begin

     FPosicaoPedidoVenda.Caption:='Posi��o de Pedido de Venda por Cliente';
     EdRepr_codigo.enabled:=false;
     EdCliente.enabled:=true;
     balteracor.Enabled:=true;
     breserva.Enabled  :=true;
     if xCliente=0  then
        EdCliente.setfocus;
     edcontato.visible  := true;
     bbuscacontato.visible := true;

   end;

   clirepr:=tipo;
   unidade:=Global.codigounidade;
   EdUnid_codigo.text:=unidade;
   EdUNid_codigo.validfind;
   GridPedidos.clear;
   EdValorpedidos.clear;
   Edqtdeprod.clear;
   Griditens.clear;
   carnesescolhidas:='';
   FGeral.ConfiguraColorEditsNaoEnabled(FPosicaoPedidoVenda);
   if xCliente>0  then begin

       EdCliente.Text:=inttostr(xcliente);
       EdCliente.Next;
       EdTodos.Text:='T';
       EdTodos.Next;

   end;

// 02.11.20
//   balteracor.enabled := Global.topicos[1426];
//   breserva.enabled   := Global.topicos[1426];
//   edcontato.visible  := Global.topicos[1426];

   bwhatsapp.visible  := false;
// 08.06.2021
   if Global.Topicos[1419] then Timer1.enabled:=true else Timer1.enabled:=false;

   if Global.Usuario.OutrosAcessos[0352] then begin

       if not FGerenciaWhats.login then begin

          Avisoerro('N�o foi poss�vel acessar o servi�o do Whatsapp');
          exit;

       end;
       bwhatsapp.visible:=true;

   end;


end;


procedure TFPosicaoPedidoVenda.Queryitenstogrid(Q1:TMemoryquery ; GridDetalhe:TSqldtgrid ; pedido:string);
///////////////////////////////////////////////////////////////////////////////////////////////////
var npedido:string;
    qtde,qtdeenviada,vlritem:currency;
    x:integer;
    Q : TSqlquery;

begin

      Q := sqltoquery( 'select * from movpeddet'+
                    ' inner join estoque on ( esto_codigo = mpdd_esto_codigo )'+
                    ' left join cores on ( core_codigo = mpdd_core_codigo )'+
                    ' left join tamanhos on ( tama_codigo = mpdd_tama_codigo )'+
                    ' left join copas on ( copa_codigo = mpdd_copa_codigo )'+
                    ' where mpdd_status = ''N'''+
                    ' and mpdd_tipomov <> ''OP'''+
                    ' and mpdd_tipo_codigo='+GridPedidos.cells[GridPedidos.getcolumn('mped_tipo_codigo'),GridPedidos.row]+
                    ' and mpdd_numerodoc = '+pedido+
                    ' and '+FGeral.Getin('mpdd_unid_codigo',Global.CodigoUnidade,'C')+
                    ' and mpdd_datamvto >= '+Datetosql(Q1.fieldbyname('mped_datamvto').asdatetime) );


      Griddetalhe.clear;
      x:=1;
      qtde:=0;  qtdeenviada:=0;
      while not Q.eof do begin

        npedido:=Q.fieldbyname('mpdd_numerodoc').asstring;
        if npedido=pedido then begin

          while not Q.eof and (npedido=Q.fieldbyname('mpdd_numerodoc').asstring) do begin

            GridItens.cells[GridItens.getcolumn('mpdd_esto_codigo'),x]:=Q.fieldbyname('mpdd_esto_codigo').asstring;
//            GridItens.cells[GridItens.getcolumn('mpdd_dataemissao'),x]:=formatdatetime('dd/mm/yy',Q.fieldbyname('mped_dataemissao').asdatetime);
            GridItens.cells[GridItens.getcolumn('esto_descricao'),x]:=Q.fieldbyname('esto_descricao').asstring;
            GridItens.cells[GridItens.getcolumn('tama_descricao'),x]:=Q.fieldbyname('tama_descricao').asstring;
            GridItens.cells[GridItens.getcolumn('core_descricao'),x]:=Q.fieldbyname('core_descricao').asstring;
//            GridItens.cells[GridItens.getcolumn('mpdd_qtde'),x]:=formatfloat(f_cr,Q.fieldbyname('mpdd_qtde').asfloat);
// 03.11.2021 - Pequim
            GridItens.cells[GridItens.getcolumn('mpdd_qtde'),x]:=formatfloat(f_cr3,Q.fieldbyname('mpdd_qtde').asfloat);
            GridItens.cells[GridItens.getcolumn('mpdd_qtdeenviada'),x]:=formatfloat(f_cr,Q.fieldbyname('mpdd_qtdeenviada').asfloat);
            GridItens.cells[GridItens.getcolumn('copa_descricao'),x]:=Q.fieldbyname('copa_descricao').asstring;
            if Q.fieldbyname('mpdd_dataenviada').asdatetime>0 then
              GridItens.cells[GridItens.getcolumn('mpdd_dataenviada'),x]:=formatdatetime('dd/mm/yy',Q.fieldbyname('mpdd_dataenviada').asdatetime)
            else
              GridItens.cells[GridItens.getcolumn('mpdd_dataenviada'),x]:='';
            GridItens.cells[GridItens.getcolumn('mpdd_venda'),x]:=formatfloat(f_cr,Q.fieldbyname('mpdd_venda').asfloat);
            vlritem:=Q.fieldbyname('mpdd_qtde').asfloat*Q.fieldbyname('mpdd_venda').asfloat;
            GridItens.cells[GridItens.getcolumn('total'),x]:=formatfloat(f_cr,vlritem);
            GridItens.cells[GridItens.getcolumn('mpdd_core_codigo'),x]:=Q.fieldbyname('mpdd_core_codigo').asstring;
            GridItens.cells[GridItens.getcolumn('mpdd_tama_codigo'),x]:=Q.fieldbyname('mpdd_tama_codigo').asstring;
            GridItens.cells[GridItens.getcolumn('mpdd_copa_codigo'),x]:=Q.fieldbyname('mpdd_copa_codigo').asstring;
            if trim(Q.fieldbyname('mpdd_seq').Asstring)<>'' then
              GridItens.Cells[gridItens.getcolumn('move_seq'),x]:=strzero(strtoint(Q.fieldbyname('mpdd_seq').Asstring),3)
            else
              GridItens.Cells[gridItens.getcolumn('move_seq'),x]:=strzero(Q.fieldbyname('mpdd_seq').Asinteger,3);
            if Q.fieldbyname('mpdd_caoc_codigo').Asinteger>0 then
              GridItens.Cells[gridItens.getcolumn('caoc_descricao'),x]:=FCadOcorrencias.GetDescricao(Q.fieldbyname('mpdd_caoc_codigo').Asinteger);
// 14.12.05
            if Q.fieldbyname('mpdd_datamontagem').asdatetime>0 then
              GridItens.cells[GridItens.getcolumn('mpdd_datamontagem'),x]:=formatdatetime('dd/mm/yy',Q.fieldbyname('mpdd_datamontagem').asdatetime)
            else
              GridItens.cells[GridItens.getcolumn('mpdd_datamontagem'),x]:='';
            if Q.fieldbyname('mpdd_dataprevista').asdatetime>0 then
              GridItens.cells[GridItens.getcolumn('mpdd_dataprevista'),x]:=formatdatetime('dd/mm/yy',Q.fieldbyname('mpdd_dataprevista').asdatetime)
            else
              GridItens.cells[GridItens.getcolumn('mpdd_dataprevista'),x]:='';
            inc(x);
            GridItens.appendrow;
            qtde:=qtde+Q.fieldbyname('mpdd_qtde').asfloat;
            qtdeenviada:=qtdeenviada+Q.fieldbyname('mpdd_qtdeenviada').asfloat;
            Q.Next;

          end;
          break;

        end;
        Q.Next;

      end;

      FGeral.FechaQuery( Q );

      EdQtdeProd.setvalue(qtde);
      EdQtdeEnviada.setvalue(qtdeenviada);
end;


// 08.06.2021 - Guiber
procedure TFPosicaoPedidoVenda.Timer1Timer(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin

   Sistema.beginprocess('Verificando pedidos m�vel');
   PMens.Caption := 'Verificando pedidos m�vel';
   FDiversos.ImportaPedidos( Sistema.hoje,'S',PMens );
// 02.02.23
   FDiversos.ImportaPedidos( Sistema.hoje-1,'S',PMens );
   Sistema.endprocess('');

end;

function TFPosicaoPedidoVenda.FinanceiroOK(dataautoriza:TDatetime ; envio:string):string;
begin
//  if envio='P' then begin
    if dataautoriza>0 then
      result:=formatdatetime('dd/mm/yy',dataautoriza)
    else
      result:='Pendente';
//  end else
//    result:='OK';
end;

procedure TFPosicaoPedidoVenda.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

    Timer1.Enabled:=false;

end;

procedure TFPosicaoPedidoVenda.EdclienteValidate(Sender: TObject);
begin
   if Edcliente.asinteger=0 then exit;
   EdRepr_codigo.setvalue(EdCliente.resultfind.fieldbyname('clie_repr_codigo').asinteger);
   Edunid_codigo.text:=unidade;
   EdUnid_codigo.validfind;
   EdRepr_codigo.validfind;
   sqlfiltroitens := '';
   Cbtipos.Items.clear;

end;

procedure TFPosicaoPedidoVenda.EdcodespetoExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////////
var   NumeroDoc   : integer;
      Produto,
      seq         : string;

begin

   Edcodespeto.Visible:=false;
   Edcodespeto.Enabled:=false;
   Setedcor2.visible:=false;
   Setedcor2.enabled:=false;
   Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
   Produto  :=GridItens.cells[griditens.getcolumn('mpdd_esto_codigo'),griditens.row];
   Seq      :=GridItens.cells[griditens.getcolumn('move_seq'),griditens.row];

   if not EdCodespeto.ISEmpty then begin

      if EdCodespeto.Resultfind <> nil then begin

         GridItens.cells[gridItens.getcolumn('core_descricao'),gridItens.row]   := EdCodespeto.Resultfind.FieldByName('core_descricao').AsString;
         GridItens.cells[gridItens.getcolumn('mpdd_core_codigo'),gridItens.row] := EdCodespeto.Text;
         Sistema.Edit('movpeddet');
         Sistema.SetField('mpdd_core_codigo',EdCodespeto.AsInteger);
         Sistema.post('mpdd_numerodoc = '+inttostr(numerodoc)+
                   ' and mpdd_esto_codigo='+stringtosql(produto)+
                   ' and mpdd_seq = '+Stringtosql( seq ) +
                   ' and mpdd_status=''N''' );
         Sistema.Commit;


      end;

   end;

end;

procedure TFPosicaoPedidoVenda.EdContatoExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////////////////
begin


end;

// 09.01.20
procedure TFPosicaoPedidoVenda.GridPedidosClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////
begin
   if GridPedidos.cells[Gridpedidos.getcolumn('mped_numerodoc'),Gridpedidos.row]<>'' then
     Queryitenstogrid(QPedidos,GridItens,GridPedidos.cells[GridPedidos.getcolumn('mped_numerodoc'),GridPedidos.row]);

end;

procedure TFPosicaoPedidoVenda.GridPedidosKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    GridPedidosclick(FPosicaoPedidoVenda);
end;

procedure TFPosicaoPedidoVenda.EdtodosValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////////
var p,x:integer;
    vlrpedidos:currency;
    sqlaberto,sqldata,sqlcliente,sqlunidades,
    sqlwhere,
    sqlorder  :string;
    Datapedido:TDatetime;
    QP        :TSqlquery;

    // 26.09.09 - checar todos os pedidos se todos os itens est�o marcados como 'E'
    //            na situacao para dai mudar a situacao do 'pedido mestre' para 'E'
    procedure ChecaPedidosBaixados;
    //////////////////////////////
    var i,numero,cliente:integer;
        baixa:boolean;
    begin

      for i:=1 to GridPedidos.RowCount do begin
        numero:=strtointdef( GridPedidos.cells[GridPedidos.GetColumn('mped_numerodoc'),i] ,0);
        if numero>0 then begin
           QPedidos.First;
           cliente:=0;
           baixa:=true;
           while not QPedidos.eof do begin
             if Qpedidos.FieldByName('mpdd_numerodoc').AsInteger=numero then begin
               cliente:=Qpedidos.FieldByName('mpdd_tipo_codigo').AsInteger;
               if Qpedidos.FieldByName('mpdd_situacao').AsString<>'E' then begin
                 baixa:=false;
                 break;
               end;
             end;
             QPedidos.Next;
           end;
           if baixa then  begin
             Sistema.Edit('movped');
             Sistema.setfield('mped_situacao','E');
             Sistema.post('mped_numerodoc='+inttostr(Numero)+' and mped_situacao=''P'''+
                          ' and mped_status=''N'' and mped_tipo_codigo='+inttostr(cliente));
             Sistema.Commit;
           end;
        end;
      end;
      QPedidos.First;
    end;


begin

   Sistema.beginprocess('Pesquisando pedidos');
   if Edtodos.text='A' then
//     sqlaberto:=' and '+Fgeral.getin('mpdd_situacao','P','C')
// 24.03.06
     sqlaberto:=' and '+Fgeral.getin('mped_situacao','P;A','C')
   else
     sqlaberto:='';
   DataPedido:=0;
   sqlwhere:=' where '+FGEral.getin('mpdd_status','N;X','C');
   if FGeral.Getconfig1asinteger('DIASPEDIDO')>0 then
     DataPedido:=Sistema.hoje-FGeral.Getconfig1asinteger('DIASPEDIDO')
   else
     DataPedido:=Sistema.Hoje-60;

   if Edtodos.text='A' then begin

     sqlwhere:=' where '+FGEral.getin('mpdd_status','N','C');
     sqldata:=' and mped_dataemissao >= '+Datetosql(DAtaPedido) ;
// 23.02.2021
     if (not EdDatai.isempty) and ( not EdDataf.isempty ) then
        sqldata:=' and mped_dataemissao >= '+Datetosql(EdDAtai.asdate)+
                 ' and mped_dataemissao <='+Datetosql(EdDAtaf.asdate);

   end else begin

     if clirepr='C' then
        sqldata:=' and mped_dataemissao >= '+Datetosql(DAtaPedido-180)  // 06.06.06 - Tania 'espa�o maior'
     else
        sqldata:=' and mped_dataemissao >= '+Datetosql(DAtaPedido-40);   // 09.05.06 - quando pede todos limitar...
// 23.02.2021
     if (not EdDatai.isempty) and ( not EdDataf.isempty ) then
        sqldata:=' and mped_dataemissao >= '+Datetosql(EdDAtai.asdate)+
                 ' and mped_dataemissao <='+Datetosql(EdDAtaf.asdate);

   end;
//     sqldata:='';
   if clirepr='C' then
     sqlcliente:=' and mpdd_tipo_codigo='+EdCliente.assql

   else begin

//     sqlcliente:=' and mpdd_repr_codigo='+EdRepr_codigo.assql;
// 25.09.09
     sqlcliente:='';
// 21.06.2021
      if not EdRepr_codigo.isempty then

         sqlcliente:=' and mpdd_repr_codigo = '+EdRepr_codigo.assql;

   end;

//   if trim(Global.Usuario.UnidadesMvto)='' then
     sqlunidades:=' and '+FGeral.Getin('mpdd_unid_codigo',Global.CodigoUnidade,'C');
// 05.04.13 - Abra Cuiaba - Adriano - ver somente pedidos da unidade em uso
//   else
//     sqlunidades:=' and '+FGeral.Getin('mpdd_unid_codigo',Global.Usuario.UnidadesMvto,'C');

// 10.06.2021
   if Global.Topicos[1419] then

      sqlorder := ' order by mped_datamvto desc'

   else

      sqlorder := ' order by mped_datamvto,mpdd_numerodoc,mpdd_seq';

   QPedidos:=sqltomemoryquery('select * from movpeddet inner join movped on ( mped_transacao=mpdd_transacao )'+
                              ' inner join estoque on ( esto_codigo = mpdd_esto_codigo )'+
                              ' left join cores on ( core_codigo = mpdd_core_codigo )'+
                              ' left join tamanhos on ( tama_codigo = mpdd_tama_codigo )'+
                              ' left join copas on ( copa_codigo = mpdd_copa_codigo )'+
                              ' left join cadocorrencias on ( caoc_codigo = mpdd_caoc_codigo )'+
//                              ' where mpdd_status=''P'' and mpdd_unid_codigo='+stringtosql(unidade)+
//                              ' where '+FGEral.getin('mpdd_status','N;X','C') +
// 12.04.10 - Cenitech - se em aberto nao mostra cancelados
                              sqlwhere+
                              sqlaberto+sqldata+sqlcliente+sqlunidades+
                              sqlfiltroitens+
// 02.11.17
                              ' and mpdd_tipomov <> ''OP'''+
//                              ' order by mpdd_numerodoc,mpdd_seq');
// 24.04.06
//                              ' order by mpdd_datamvto,mpdd_numerodoc,mpdd_seq');
// 09.05.06 - pedidos com itens alterados em data diferente da q foi feita o pedido nao aparece na posi��o de
//            pedido por representante...
                              sqlorder );

   Sistema.endprocess('');
   GridPedidos.clear;
   GridItens.clear;
   if sqlfiltroitens='' then

      Cbtipos.Items.clear;


   EdValorPedidos.text := '';

   if QPedidos.eof then begin
     Edcliente.invalid('N�o encontrado pedidos');
     exit;
   end;
//   GridItens.clear;
//   GridItens.QueryToGrid(QPedidos);
//   Griditens.Seek(Griditens.getcolumn('mpdd_numerodoc'),'1');
   vlrpedidos:=0;
   GridPedidos.clear;
   ListaPedidos:=TStringlist.create;
   x:=1;p:=1;
   while not QPedidos.eof do begin

       if ListaPedidos.indexof( Qpedidos.fieldbyname('mpdd_numerodoc').asstring )=-1 then begin

         ListaPedidos.add(Qpedidos.fieldbyname('mpdd_numerodoc').asstring);
         GridPedidos.cells[GridPedidos.getcolumn('mped_numerodoc'),x]:=QPedidos.fieldbyname('mpdd_numerodoc').asstring;
         GridPedidos.cells[GridPedidos.getcolumn('mped_tipomov'),x]:=QPedidos.fieldbyname('mped_tipomov').asstring;
         GridPedidos.cells[GridPedidos.getcolumn('mped_pedcliente'),x]:=QPedidos.fieldbyname('mped_pedcliente').asstring;
         if clirepr='C' then
           GridPedidos.cells[GridPedidos.getcolumn('clie_nome'),x]:=''
         else
           GridPedidos.cells[GridPedidos.getcolumn('clie_nome'),x]:=FGeral.GetNomeRazaoSocialEntidade(QPedidos.fieldbyname('mped_tipo_codigo').asinteger,'C','N');
         GridPedidos.cells[GridPedidos.getcolumn('mped_dataemissao'),x]:=formatdatetime('dd/mm/yy',QPedidos.fieldbyname('mped_dataemissao').asdatetime);
//         GridPedidos.cells[GridPedidos.getcolumn('mped_formaped'),x]:=QPedidos.fieldbyname('mped_formaped').asstring;
//         GridPedidos.cells[GridPedidos.getcolumn('mped_envio'),x]:=QPedidos.fieldbyname('mped_envio').asstring;
         GridPedidos.cells[GridPedidos.getcolumn('mped_formaped'),x]:=FGeral.GetFormaPedido( QPedidos.fieldbyname('mped_formaped').asstring );
         GridPedidos.cells[GridPedidos.getcolumn('mped_envio'),x]:=FGeral.GetFormaEnvio(QPedidos.fieldbyname('mped_envio').asstring);
         GridPedidos.cells[GridPedidos.getcolumn('mped_contatopedido'),x]:=QPedidos.fieldbyname('mped_contatopedido').asstring;
         GridPedidos.cells[GridPedidos.getcolumn('mped_fpgt_prazos'),x]:=QPedidos.fieldbyname('mped_fpgt_prazos').asstring;
         GridPedidos.cells[GridPedidos.getcolumn('mped_vlrtotal'),x]:=formatfloat(f_cr,QPedidos.fieldbyname('mped_vlrtotal').asfloat);
         GridPedidos.cells[GridPedidos.getcolumn('financeiro'),x]:=FinanceiroOK(QPedidos.fieldbyname('mped_dataautoriza').asdatetime,QPedidos.fieldbyname('mped_envio').asstring);
         if QPedidos.fieldbyname('mped_status').asstring='X' then
//           GridPedidos.cells[GridPedidos.getcolumn('mped_situacao'),x]:=QPedidos.fieldbyname('mped_status').asstring
// 28.07.06
           GridPedidos.cells[GridPedidos.getcolumn('mped_situacao'),x]:='CANCELADO'
         else
           GridPedidos.cells[GridPedidos.getcolumn('mped_situacao'),x]:=QPedidos.fieldbyname('mped_situacao').asstring;
// 25.08.06
         GridPedidos.cells[GridPedidos.getcolumn('mped_usua_codigo'),x]:=strzero(QPedidos.fieldbyname('mped_usua_codigo').asinteger,3)+'-'+FUsuarios.getnome(QPedidos.fieldbyname('mped_usua_codigo').asinteger);
// 17.06.2021 - Benato - carne assada
         GridPedidos.cells[GridPedidos.getcolumn('mped_tipo_codigo'),x]:=QPedidos.fieldbyname('mped_tipo_codigo').asstring;
         inc(x);
         vlrpedidos:=vlrpedidos+QPedidos.fieldbyname('mped_vlrtotal').asfloat;
         GridPedidos.AppendRow;

       end;
     EdValorpedidos.setvalue(vlrpedidos);
// 09.07.2021
//     if Global.Topicos[1426] then begin
       if sqlfiltroitens='' then begin

           if Cbtipos.Items.indexof( QPedidos.Fieldbyname('mpdd_esto_codigo').asstring ) = -1 then

             Cbtipos.Items.add( QPedidos.Fieldbyname('mpdd_esto_codigo').asstring+' | '+
                                FEstoque.GetDescricao(QPedidos.Fieldbyname('mpdd_esto_codigo').asstring ) );

       end;

     QPedidos.next;

   end;
//   GridPedidos.Seek(GridPedidos.getcolumn('mped_numerodoc'),'1');
// 10.04.06
//   GridPedidos.Seek(GridPedidos.getcolumn('mped_dataemissao'),'01');
//   Griditens.Seek(GridItens.getcolumn('mpdd_numerodoc'),'1');
//   Griditens.Seek(Griditens.getcolumns(''),GriGriditens.getcolumns(''));

// 26.09.09
   ChecaPedidosBaixados;

   Queryitenstogrid(QPedidos,GridItens,GridPedidos.cells[GridPedidos.getcolumn('mped_numerodoc'),GridPedidos.row]);

   Gridfinan.clear;
   if Global.Usuario.ObjetosAcessados[2024] then begin
      if EdCliente.Enabled then begin
        QP:=sqltoquery('select * from pendencias left join portadores on (port_codigo=pend_port_codigo)'+
                       ' where pend_tipo_codigo='+EdCliente.assql+
//                       ' and pend_status=''N'' and '+FGeral.Getin('pend_unid_codigo',global.Usuario.UnidadesRelatorios,'C')+
                       ' and pend_status=''N'' and '+FGeral.Getin('pend_unid_codigo',EdUnid_codigo.text,'C')+
                       ' order by pend_datavcto' );
        if not Qp.eof then begin
          GridFinan.QueryToGrid(QP);
        end;
        FGeral.Fechaquery(QP);
      end;
   end;
   GridPedidos.setfocus;
end;

procedure TFPosicaoPedidoVenda.bocorrenciaClick(Sender: TObject);
var numerodoc:integer;
begin
  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then exit;
  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
//  if Edcliente.valid then
// 05.04.13
  if Edcliente.resultfind<>nil then
    FOcorrencias.Execute('C',EdCliente.asinteger,EdCliente.resultfind.fieldbyname('clie_nome').asstring,'',Numerodoc);

end;

// 09.01.20
procedure TFPosicaoPedidoVenda.breservaClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var Numerodoc,
    p,
    NovoNUm              : integer;
    tipomov,
    carnes,
    xtransacao           : string;
    Lista,
    ListaEspetos         : TStringList;
    Q,
    Qp                   : TSqlquery;
    Valor                : currency;

begin

  if EdContato.IsEmpty then begin

      Avisoerro('Ainda n�o informado o contato');
      exit;

  end;

  if FGeral.GetConfig1AsInteger('cliereserva') = 0 then begin

      Avisoerro('Ainda n�o configurado cliente ref. carne a vender');
      exit;

  end;
  if FGeral.GetConfig1AsInteger('clievenda') = 0 then begin

      Avisoerro('Ainda n�o configurado cliente carne vendida');
      exit;

  end;
  if FGeral.GetConfig1AsInteger('clievenda') <> EdCliente.AsInteger then begin

      Avisoerro('Op��o permitida somente para cliente carne a vender');
      exit;

  end;
  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then exit;

  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
//  Tipomov  :=GridPedidos.cells[gridpedidos.getcolumn('mped_tipomov'),gridpedidos.row];
  Tipomov := Global.CodPedVenda;

  carnes:='';
  ListaEspetos :=TStringList.Create;
  pedidosescolhidos := '';

  for p := 1 to GridPedidos.RowCount do begin

     if GridPedidos.cells[Gridpedidos.getcolumn('mped_contatopedido'),p] = 'OK' then
        pedidosescolhidos := pedidosescolhidos + GridPedidos.cells[Gridpedidos.getcolumn('mped_numerodoc'),p] + ';';

  end;

  Lista:=TStringList.Create;
  strtolista(Lista,pedidosescolhidos,';',true);
  valor := 0;

  for p := 0 to Lista.Count-1 do begin

      if ( trim(Lista[p])<>'' )  then begin

         if ( length(trim(Lista[p])) > 2 )  then begin

            Q := sqltoquery( 'select mpdd_esto_codigo,mpdd_core_codigo,(mpdd_qtde*mpdd_venda) as venda from movpeddet'+
                             ' where mpdd_numerodoc  = '+Lista[p]+
                             ' and mpdd_tipo_codigo  = '+EdCliente.AsSql+
                             ' and mpdd_status       = ''N'''+
                             ' and  mpdd_unid_codigo = '+Stringtosql(Global.CodigoUnidade) );

            while not Q.Eof do begin

               ListaEspetos.Add( FEstoque.getdescricao( Q.FieldByName('mpdd_esto_codigo').AsString )+' | '+
                                 'Espeto '+Q.FieldByName('mpdd_core_codigo').AsString );
               valor := valor + Q.fieldbyname('venda').ascurrency;
               Q.Next;

            end;

            Q.Close;

         end;

      end;

  end;

  if valor = 0 then begin

      Avisoerro('Ainda n�o foi marcado pedidos a reservar');
      exit;

  end;

  if not confirma('Confirma reserva de '+ListaEspetos.Text+' para '+EdContato.Text+' de R$ '+
                   FGeral.Formatavalor(valor,f_cr)+' ?' ) then exit;


  // mudar o codigo do cliente dos produtos dos pedidos marcados
  if ListaEspetos.Count=0 then exit;


  Q := sqltoquery( 'select mpdd_esto_codigo,mpdd_core_codigo,mpdd_numerodoc,'+
                   ' (mpdd_qtde*mpdd_venda) as venda from movpeddet'+
                   ' where '+FGeral.GetIN('mpdd_numerodoc',pedidosescolhidos,'N')+
                             ' and mpdd_status = ''N'''+
                             ' and mpdd_tipo_codigo  = '+EdCliente.AsSql+
                             ' and mpdd_unid_codigo = '+Stringtosql(Global.CodigoUnidade) );
  Novonum := FGeral.GetContador('PEDVENDA',false);
  xTransacao := FGEral.GetTransacao;

  Qp := sqltoquery('select movped.*,clie_uf,clie_cida_codigo_res'+
                  ' from movped inner join clientes on ( clie_codigo=mped_tipo_codigo )'+
                  ' where mped_status = ''N''' +
                  ' and mped_tipomov = '+stringtosql( Tipomov )+
                  ' and mped_numerodoc = '+Q.FieldByName('mpdd_numerodoc').AsString+
                  ' and mped_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                  ' and mped_tipo_codigo = '+EdCliente.AsSql );

  valor := 0;

  while not Q.Eof do begin


         valor := valor + Q.fieldbyname('venda').ascurrency;
         Sistema.Edit('movpeddet');
         Sistema.SetField('mpdd_tipo_codigo',FGeral.GetConfig1AsInteger('cliereserva'));
         Sistema.SetField('mpdd_numerodoc',Novonum);
         Sistema.SetField('mpdd_transacao',xTransacao);
         Sistema.Post('mpdd_tipomov = '+stringtosql( Tipomov )+
                   ' and mpdd_numerodoc = '+Q.FieldByName('mpdd_numerodoc').AsString+
                   ' and mpdd_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                   ' and mpdd_tipo_codigo = '+EdCliente.AsSql );

  // excluir os mestres do pedidos escolhidos
        Sistema.Edit('movped');
        Sistema.SetField('mped_status','C' );
        Sistema.Post('mped_tipomov = '+stringtosql( Tipomov )+
                        ' and mped_numerodoc = '+Q.FieldByName('mpdd_numerodoc').AsString+
                        ' and mped_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                        ' and mped_tipo_codigo = '+EdCliente.AsSql );

     Q.Next;

  end;

  Q.Close;

  // incluir novo pedido mestre com o codigo de cliente carne vendida somando os produtos
          Sistema.Insert('movped');
          Sistema.SetField('mped_transacao',xTransacao);
          Sistema.SetField('mped_operacao',FGeral.GetOperacao);
          Sistema.SetField('mped_status','N');
          Sistema.SetField('mped_numerodoc',Novonum);
          Sistema.SetField('mped_tipomov',Global.CodPedVenda);
          Sistema.SetField('mped_unid_codigo',Unidade);
          Sistema.SetField('mped_tipo_codigo',FGeral.GetConfig1AsInteger('cliereserva'));
          Sistema.SetField('mped_datalcto',Sistema.Hoje);
          Sistema.SetField('mped_datamvto',Sistema.Hoje);
          Sistema.SetField('mped_datacont',Sistema.Hoje);
          Sistema.SetField('mped_vlrtotal',Valor);
//          if FCondpagto.GetAvPz(EdFpgt_codigo.text)='V' then
//            Sistema.SetField('mped_valoravista',Valortotal)
//          else
//            Sistema.SetField('mped_valoravista',Valorparteavista);
 //         Sistema.SetField('mped_tabp_codigo',Tabela);
          Sistema.SetField('mped_fpgt_codigo',QP.FieldByName('mped_fpgt_codigo').AsString);
//          Sistema.SetField('mped_tabaliquota',FTabela.GetAliquota(Tabela));
          Sistema.SetField('mped_usua_codigo',Global.Usuario.Codigo);
//          Sistema.SetField('mped_pedcliente',EdPedidocliente.asinteger);
          Sistema.SetField('mped_estado',QP.FieldByName('clie_uf').asstring);
          Sistema.SetField('mped_cida_codigo',Qp.fieldbyname('clie_cida_codigo_res').asinteger);
          Sistema.SetField('mped_repr_codigo',EdRepr_codigo.asinteger);
          Sistema.SetField('mped_tipocad','C');
          Sistema.SetField('mped_dataemissao',Sistema.hoje);
          Sistema.SetField('mped_totprod',valor);
          Sistema.SetField('mped_vispra',QP.FieldByName('mped_vispra').AsString);
      // ver se vai usar
          Sistema.SetField('mped_perdesco',0);
          Sistema.SetField('mped_peracres',0);
          Sistema.SetField('mped_situacao','P');
          Sistema.SetField('mped_formaped',QP.FieldByName('mped_formaped').AsString);
          Sistema.SetField('mped_envio',QP.FieldByName('mped_envio').AsString);
          Sistema.SetField('Mped_fpgt_prazos',QP.FieldByName('mped_fpgt_prazos').AsString);
          Sistema.SetField('mped_contatopedido',EdContato.text);
          Sistema.SetField('mped_datapedcli',QP.FieldByName('mped_datapedcli').AsDatetime);
          Sistema.SetField('mped_obspedido',QP.FieldByName('mped_obspedido').AsString);
          Sistema.SetField('mped_port_codigo',QP.FieldByName('mped_port_codigo').AsString);

         Sistema.Post();

         try
             Sistema.commit;
             Aviso( 'Reserva gravada');
             EdTodos.Valid;

         except on E:exception do

             Avisoerro('Problemas na grava��o '+E.message)

         end;
         QP.close;
         EdContato.Text := '';

end;


// 02.11.20
procedure TFPosicaoPedidoVenda.bwhatsappClick(Sender: TObject);
////////////////////////////////////////////////////////////////
var ct,
    arqpdf,
    fone,
    mensagem    :string;
    i           :integer;
    Q           :TSqlquery;
    emissao     :TDatetime;

begin

     if Global.Usuario.OutrosAcessos[0352] then begin



        if trim( GridPedidos.Cells[GridPedidos.getcolumn('mped_numerodoc'),GridPedidos.row] ) <> '' then begin

          ct := trim( GridPedidos.Cells[GridPedidos.GetColumn('mped_numerodoc'),GridPedidos.row] );
          Q  := Sqltoquery('select * from movped where mped_numerodoc = '+(ct)+
                           ' and mped_unid_codigo = '+Stringtosql(EdUnid_codigo.text)+
                           ' and mped_status<>''C''');

          if Q.eof then begin

              Avisoerro('Pedido '+ct+' n�o encontrado');
              exit;

          end;
          emissao := Q.fieldbyname('mped_datamvto').asdatetime;


//          if Q.fieldbyname('moes_tipocad').asstring = 'C' then

             fone := FCadCli.getcelular( Q.fieldbyname('mped_tipo_codigo').asinteger );

//          else

//             fone := FFornece.getcelular( Q.fieldbyname('moes_tipo_codigo').asinteger );


          if trim(fone)='' then begin

             Input('Informe telefone','Numero',fone,10,false);

          end;


          fone := strtostrnumeros( fone );
          if length(trim(fone)) < 10 then begin

             Avisoerro('Fone '+fone+' faltando d�gitos.  Verificar');
             exit;

          end else if length(trim(fone)) > 10 then begin

             Avisoerro('Fone '+fone+' sobrando d�gitos.  Verificar');
             exit;

          end;


          FImpressao.ImprimePedidoVenda(strtoint(ct),emissao,edunid_codigo.text,'V',GridPedidos.cells[gridpedidos.getcolumn('mped_tipomov'),gridpedidos.row]);

//          ListaAnexos := TStringList.Create;
          arqpdf := ( ExtractFilePath( Application.ExeName ) + 'Arq'+strzero(Global.Usuario.Codigo,3)+'.pdf' );

          if not FileExists( arqpdf ) then begin

             Avisoerro('Arquivo '+arqpdf+' n�o encontrado.  Verificar');
             exit;

          end;



          mensagem :=  'Or�amento '+Q.fieldbyname('mped_numerodoc').asstring+' - '+
                       FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mped_tipo_codigo').asinteger,
                                                  'C',
                                                  'N');



          FGerenciaWhats.EnviaArquivo(fone,arqpdf,mensagem);

          DeleteFile( arqpdf );

        end;


    end;


end;

// 09.07.2021
procedure TFPosicaoPedidoVenda.cbtiposClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var pos : integer;

begin

    if trim( CBtipos.Items[CBtipos.ItemIndex] ) <> '' then begin

       pos := AnsiPos('|',CBtipos.Items[CBtipos.ItemIndex]);
       sqlfiltroitens := ' and mpdd_esto_codigo = '+stringtosql(trim( copy(CBtipos.Items[CBtipos.ItemIndex],1,pos-1) ));
       EdTodos.valid;

    end;

end;

procedure TFPosicaoPedidoVenda.bimpClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var numerodoc:integer;
    emissao:TDatetime;
begin

  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then begin
    Avisoerro('Escolher pedido');
    exit;
  end;
  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_dataemissao'),gridpedidos.row])='' then begin
    Avisoerro('Checar Data emiss�o do pedido');
    exit;
  end;
  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  Emissao:=texttodate(Fgeral.TiraBarra(Gridpedidos.cells[gridpedidos.getcolumn('mped_dataemissao'),gridpedidos.row]));
// 04.01.2021
// mudado no sqlfun texttodate para colocar 'seculo 20' para formar o ano correto '2021'...
  if Numerodoc>0 then
    FImpressao.ImprimePedidoVenda(Numerodoc,emissao,edunid_codigo.text,'N',GridPedidos.cells[gridpedidos.getcolumn('mped_tipomov'),gridpedidos.row])

end;

procedure TFPosicaoPedidoVenda.bautorizaClick(Sender: TObject);
var numerodoc:integer;
    finan:string;
begin
  if not Global.Usuario.OutrosAcessos[0703] then begin
     Avisoerro('Usu�rio sem permiss�o de libera��o de pedido de venda');
     exit;
  end;
  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then exit;
{ // 28.01.19
  if pos(GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row],'A')=0 then begin
     Avisoerro('Pedido n�o atendido');
     exit;
  end;
}

  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  if pos( '/',GridPedidos.cells[gridpedidos.getcolumn('financeiro'),gridpedidos.row] )>0 then
    finan:='Aprovado'
  else if pos( 'OK',GridPedidos.cells[gridpedidos.getcolumn('financeiro'),gridpedidos.row] )>0 then
    finan:='Aprovado'
  else
    finan:='Pendente';
  if finan='Pendente' then begin
    if confirma('Confirma libera��o do pedido '+inttostr(numerodoc)) then begin
      Sistema.beginprocess('Gravando');
      sistema.edit('movped');
      sistema.setfield('mped_usua_autoriza',Global.usuario.codigo);
      sistema.setfield('mped_dataautoriza',sistema.hoje);
//      sistema.SetField('mped_situacao','P');
// 28.01.19 - Seip
      sistema.SetField('mped_situacao','F');
      Sistema.post('mped_numerodoc='+inttostr(numerodoc)+
                   ' and mped_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                   ' and mped_status=''N''');
      try
        sistema.commit;
        GridPedidos.cells[gridpedidos.getcolumn('financeiro'),gridpedidos.row]:=formatdatetime('dd/mm/yy',sistema.hoje);
        GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]:='P';
      except
        avisoerro('Problemas na grava��o da libera��o do pedido');
      end;
      Sistema.endprocess('');
    end;
  end else begin
    if confirma('Confirma DESlibera��o do pedido '+inttostr(numerodoc)) then begin
      Sistema.beginprocess('Gravando');
      sistema.edit('movped');
      sistema.setfield('mped_usua_autoriza',0);
      sistema.setfield('mped_dataautoriza',Texttodate(''));
      sistema.SetField('mped_situacao','A');
      Sistema.post('mped_numerodoc='+inttostr(numerodoc)+
                   ' and mped_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                   ' and mped_status=''N''');
      try
        sistema.commit;
        GridPedidos.cells[gridpedidos.getcolumn('financeiro'),gridpedidos.row]:='Pendente';
        GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]:='A';
      except
        avisoerro('Problemas na grava��o da DESlibera��o do pedido');
      end;
      Sistema.endprocess('');
    end;
  end;
end;

procedure TFPosicaoPedidoVenda.bfaturaClick(Sender: TObject);
var numerodoc:integer;
begin
  if not Global.Usuario.OutrosAcessos[0704] then begin
     Avisoerro('Usu�rio sem permiss�o de Baixa de pedido de venda');
     exit;
  end;
// 29.06.06
  if  GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]='CANCELADO' then begin
    Avisoerro('Pedido cancelado');
    exit;
  end;
// 02.01.065
// 31.07.06
  if trim( FGeral.TiraBarra(GridItens.cells[gridItens.getcolumn('mpdd_dataenviada'),griditens.row]) )<>'' then
    EdBaixa.text:=FGeral.TiraBarra(GridItens.cells[gridItens.getcolumn('mpdd_dataenviada'),griditens.row]);
  if Global.Usuario.OutrosAcessos[0705] then begin
    EdBaixa.enabled:=true;
    if EdBaixa.isempty then EdBaixa.setdate(sistema.hoje);
// 31.07.06
  end else begin
    EdBaixa.enabled:=false;
    EdBaixa.setdate(sistema.hoje);
  end;

  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then exit;
  if trim( GridItens.cells[gridItens.getcolumn('mpdd_esto_codigo'),griditens.row] )='' then exit;
  if not Financeiroliberado then begin
     Avisoerro('Pedido n�o liberado pelo financeiro');
     exit;
  end;
  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  EDQTde.setvalue( texttovalor(GridItens.cells[GridItens.getcolumn('mpdd_qtdeenviada'),GridItens.row] ) );
  Pins.visible:=true;
  pbotoes.enabled:=false;
  premessa.enabled:=false;
//  EdQTde.setfocus;
  EdCaoc_codigo.setfocus;

end;

procedure TFPosicaoPedidoVenda.EdQtdeValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////////
var codcor,codtam,Numerodoc,codcopa:integer;
    produto:string;
    qtde:currency;
begin
//  if EdQTde.ascurrency<=0 then begin
//    Pins.visible:=false;
//    pbotoes.enabled:=true;
//    premessa.enabled:=true;
//    exit;
//  end;
  if (EdQTde.ascurrency=0) and (EdCaoc_codigo.isempty) then begin
    Avisoerro('Obrigado informar o motivo do n�o atendimento');
    EdCaoc_codigo.setfocus;
    exit;
  end;
  codcor:=strtointdef(GridItens.cells[griditens.getcolumn('mpdd_core_codigo'),griditens.row],0);
  codtam:=strtointdef(GridItens.cells[griditens.getcolumn('mpdd_tama_codigo'),griditens.row],0);
  codcopa:=strtointdef(GridItens.cells[griditens.getcolumn('mpdd_copa_codigo'),griditens.row],0);
  Produto:=GridItens.cells[griditens.getcolumn('mpdd_esto_codigo'),griditens.row];
  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  qtde:=texttovalor(GridItens.cells[griditens.getcolumn('mpdd_qtde'),griditens.row]);
  if EdQTde.ascurrency>qtde then begin
    Avisoerro('Quantidade enviada/de retorno maior que a pedida');
    Pins.visible:=false;
    pbotoes.enabled:=true;
    premessa.enabled:=true;
    exit;
  end;
  if confirma('Confirma baixa/retorno do item') then begin
      Sistema.beginprocess('Gravando');
      sistema.edit('movpeddet');
      sistema.setfield('mpdd_qtdeenviada',Edqtde.ascurrency);
//      sistema.setfield('mpdd_dataenviada',sistema.hoje);
// 02.01.06
      sistema.setfield('mpdd_dataenviada',EdBaixa.asdate);
      sistema.setfield('mpdd_caoc_codigo',EdCaoc_codigo.asinteger);
//      sistema.setfield('mpdd_situacao','E');
      sistema.setfield('mpdd_situacao','B');
      Sistema.post('mpdd_numerodoc='+inttostr(numerodoc)+' and mpdd_esto_codigo='+stringtosql(produto)+
                   ' and mpdd_core_codigo='+inttostr(codcor)+' and mpdd_tama_codigo='+inttostr(codtam)+
//                   ' and mpdd_copa_codigo='+inttostr(codcopa)+
// 31.07.06
                   ' and ( mpdd_copa_codigo='+inttostr(codcopa)+' or mpdd_copa_codigo is null )'+
                   ' and mpdd_status=''N''' );
//          +' and mpdd_unid_codigo='+EdUnid_codigo.assql );
// 16.08.14
      Sistema.Edit('movped');
      Sistema.SetField('mped_vlrtotal',Texttovalor(GridPedidos.cells[GridPedidos.getcolumn('mped_vlrtotal'),GridPedidos.row])-(Edqtde.ascurrency*Texttovalor(GridItens.cells[Griditens.getcolumn('mpdd_venda'),GridItens.row])) );
      Sistema.post( 'mped_numerodoc='+inttostr(numerodoc)+' and mped_dataemissao='+
                     Datetosql(StrtoDate(GridPedidos.cells[GridPedidos.getcolumn('mped_dataemissao'),GridPedidos.row]))+
                   ' and mped_status=''N''' );
      try
        sistema.commit;
        GridItens.cells[griditens.getcolumn('mpdd_qtdeenviada'),griditens.row]:=Edqtde.assql;
//        GridItens.cells[griditens.getcolumn('mpdd_dataenviada'),griditens.row]:=formatdatetime('dd/mm/yy',sistema.hoje);
// 02.01.06
        GridItens.cells[griditens.getcolumn('mpdd_dataenviada'),griditens.row]:=formatdatetime('dd/mm/yy',EdBaixa.asdate);
        if EdCaoc_codigo.asinteger>0 then
          GridItens.cells[griditens.getcolumn('caoc_descricao'),griditens.row]:=FCadOcorrencias.GetDescricao(EdCaoc_codigo.asinteger)
        else
          GridItens.cells[griditens.getcolumn('caoc_descricao'),griditens.row]:='';
      except
        avisoerro('Problemas na grava��o da libera��o/retorno do pedido');
      end;
      Sistema.endprocess('');
  end;
  Pins.visible:=false;
  pbotoes.enabled:=true;
  premessa.enabled:=true;
//  EdCliente.valid;
//  EdCliente.setfocus;
  GridItens.SetFocus;

end;

procedure TFPosicaoPedidoVenda.EdCaoc_codigoValidate(Sender: TObject);
begin
///  EdQtde.setfocus;
end;

procedure TFPosicaoPedidoVenda.bbaixapedidoClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////
var Numerodoc,p,codcor,codtam,codcopa:integer;
    produto:string;
    qtde:currency;

begin
  if not Global.Usuario.OutrosAcessos[0704] then begin
     Avisoerro('Usu�rio sem permiss�o de Baixa de pedido de venda');
     exit;
  end;
  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then exit;
  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  if not Financeiroliberado then begin
     Avisoerro('Pedido n�o liberado para faturamento');
     exit;
  end;
//  if  GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]='E' then begin
  if  GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]='B' then begin
    Avisoerro('Pedido j� baixado');
    exit;
  end;
// 29.06.06
  if  GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]='CANCELADO' then begin
    Avisoerro('Pedido cancelado');
    exit;
  end;
  if not Sistema.GetDataMvto('Informe data da baixa') then exit;

  if confirma('Confirma baixa TOTAL do pedido '+inttostr(Numerodoc)) then begin
      Sistema.beginprocess('Gravando');
      sistema.edit('movped');
//      sistema.setfield('mped_situacao','E');
      sistema.setfield('mped_situacao','B');
      Sistema.post( 'mped_numerodoc='+inttostr(numerodoc)+' and mped_status=''N''');
//       and mped_unid_codigo='+EdUnid_codigo.assql );
      for p:=1 to GridItens.rowcount do begin
        produto:=GridItens.cells[GridItens.getcolumn('mpdd_esto_codigo'),p];
        if trim(produto)<>'' then begin
          codcor:=strtointdef(GridItens.cells[griditens.getcolumn('mpdd_core_codigo'),p],0);
          codtam:=strtointdef(GridItens.cells[griditens.getcolumn('mpdd_tama_codigo'),p],0);
          codcopa:=strtointdef(GridItens.cells[griditens.getcolumn('mpdd_copa_codigo'),p],0);
          qtde:=texttovalor( GridItens.cells[GridItens.getcolumn('mpdd_qtde'),p] );
          sistema.edit('movpeddet');
          sistema.setfield('mpdd_qtdeenviada',qtde);
//          sistema.setfield('mpdd_dataenviada',sistema.hoje);
          sistema.setfield('mpdd_dataenviada',sistema.DataMvto);
//          sistema.setfield('mpdd_caoc_codigo',EdCaoc_codigo.asinteger);
//          sistema.setfield('mpdd_situacao','E');
// 11.08.09
          sistema.setfield('mpdd_situacao','B');
          Sistema.post( 'mpdd_numerodoc='+inttostr(numerodoc)+' and mpdd_status=''N'' and mpdd_esto_codigo='+Stringtosql(produto)+
//                        sqlcor+sqltamanho+sqlcopa
                        ' and mpdd_core_codigo='+inttostr(codcor)+' and mpdd_tama_codigo='+inttostr(codtam)+
                        ' and ( mpdd_copa_codigo='+inttostr(codcopa)+' or mpdd_copa_codigo is null )'+
                        ' and (  mpdd_situacao <>''B''  or  mpdd_situacao is null )' ) ; // 25.05.06
//                        ' and  mpdd_situacao <>''E''' ) ; // 31.07.06
//          if p=int(GridItens.rowcount/4) then
//             sistema.commit;
//          if p=int(GridItens.rowcount/2) then
//             sistema.commit;
//                        ' and mpdd_situacao=''P''' );
  //       and mpdd_unid_codigo='+EdUnid_codigo.assql );
// 05.12.05
          GridItens.cells[griditens.getcolumn('mpdd_qtdeenviada'),p]:=formatfloat('#####.##',qtde);
          GridItens.cells[griditens.getcolumn('mpdd_dataenviada'),p]:=formatdatetime('dd/mm/yy',sistema.DataMvto);
        end;
      end;
      try
        sistema.commit;
        GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]:='B';
//        GridPedidosClick(FPosicaoPedidoVenda);
      except
        avisoerro('Problemas na grava��o da baixa do pedido');
      end;
      Sistema.endprocess('Pedido Baixado');
      if Clirepr='C' then begin
        EdCliente.valid;
        EdCliente.setfocus;
      end else begin
        EdRepr_codigo.valid;
//        EdRepr_codigo.ValidateEdit;
//        EdRepr_codigo.setfocus;
        EdTodos.valid;
        GridPedidos.SetFocus;
      end;
  end;

end;
// 16.06.2021
procedure TFPosicaoPedidoVenda.bbuscacontatoClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////
begin

   if not EdContato.isempty then

      GridPedidos.Seek(GridPedidos.getcolumn('mped_contatopedido'),EdContato.text );

end;

// 12.06.20 - enviar or�amento / pedido via email anexo pdf
procedure TFPosicaoPedidoVenda.bemailClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var  CorpoEmail,
     ListaAnexos : TStringList;
     nomearq,
     nomearqpdf,
     xemail      : string;

 begin

  if EdCliente.IsEmpty then begin
    Avisoerro('Op��o v�lida somente na posi��o por cliente');
    exit;
  end;

  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then begin
    Avisoerro('Escolher pedido');
    exit;
  end;
  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_dataemissao'),gridpedidos.row])='' then begin
    Avisoerro('Checar Data emiss�o do pedido');
    exit;
  end;
// 12.06.20
  if trim( FGeral.GetConfig1AsString('Pedidoviaemail') ) = '' then begin

    Avisoerro('Impresso para uso no envio de email ainda n�o configurado');
    exit;

  end;


  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  Emissao:=texttodate(Fgeral.TiraBarra(Gridpedidos.cells[gridpedidos.getcolumn('mped_dataemissao'),gridpedidos.row]));

  if Numerodoc>0 then begin

   Acbrmail1.from:=FGeral.getconfig1asstring('EMAILORIGEM');
   Acbrmail1.Host:=FGeral.getconfig1asstring('SMTP');
   Acbrmail1.Username:=FGeral.getconfig1asstring('USUARIOSMTP');
   Acbrmail1.Password:=FGeral.getconfig1asstring('SENHASMTP');
   Acbrmail1.Port:=inttostr(FGeral.GetConfig1AsInteger('portasmtp'));
   Acbrmail1.SetSSL:=false;
   ACBrMail1.SetTLS := true;
   if FGeral.EmailStmpcomSSL( FGeral.GetConfig1AsString('EMAILORIGEM') ) then
     Acbrmail1.SetSSL:=true;

   xemail := FGeral.GetEmailEntidade( EdCliente.asinteger,'C','N');
   if trim(xemail)=''  then Input('Envio de email','Email',xemail,50,false);

   CorpoEmail := TStringList.Create;
   Sistema.BeginProcess('Enviando email');
   CorpoEmail.Add('Anexo or�amento '+inttostr(Numerodoc));

   FImpressao.ImprimePedidoVenda(Numerodoc,emissao,edunid_codigo.text,'V',GridPedidos.cells[gridpedidos.getcolumn('mped_tipomov'),gridpedidos.row]);

   ListaAnexos := TStringList.Create;
   if FileExists( ExtractFilePath( Application.ExeName ) + 'Arq'+strzero(Global.Usuario.Codigo,3)+'.pdf' ) then begin

     ListaAnexos.Add( 'Arq'+strzero(Global.Usuario.Codigo,3)+'.pdf' );

     FGeral.EnviaEMailcomAnexo(xemail,ListaAnexos,corpoemail,'ORC','Orcamento de Venda '+Global.NomeUnidade);

   end else Avisoerro('Arquivo para envio de email N�O gerado e enviado');

   Sistema.endProcess('');

   CorpoEmail.Free;
   ListaAnexos.Free;


  end;


end;

procedure TFPosicaoPedidoVenda.bcancelareservaClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////
var NUmerodoc,
    p,
    codcor,
    Novonum   :integer;
    tipomov,
    produto,
    gravar,
    xTransacao:string;
    QP        :TSqlquery;
    valor     :currency;

begin

  if FGeral.GetConfig1AsInteger('cliereserva') = 0 then begin

      Avisoerro('Ainda n�o configurado cliente ref. carne vendida');
      exit;

  end;
  if FGeral.GetConfig1AsInteger('clievenda') = 0 then begin

      Avisoerro('Ainda n�o configurado cliente venda');
      exit;

  end;
  if FGeral.GetConfig1AsInteger('cliereserva') <> EdCliente.AsInteger then begin

      Avisoerro('Op��o permitida somente para cliente reserva');
      exit;

  end;
  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then exit;

  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  Tipomov  :=GridPedidos.cells[gridpedidos.getcolumn('mped_tipomov'),gridpedidos.row];

  if  GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]='B' then begin
    Avisoerro('Pedido j� baixado');
    exit;
  end;
  if  GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]='CANCELADO' then begin
    Avisoerro('Pedido cancelado');
    exit;
  end;
  if not confirma('Confirma cancelamento da reserva ?') then exit;

// apaga o mestre do pedido atual
  Sistema.Edit('movped');
//  Sistema.SetField('mped_clie_codigo',FGeral.GetConfig1AsInteger('clievenda'));
//  Sistema.SetField('mped_numerodoc',novonum );
  Sistema.SetField('mped_status','C' );
  Sistema.Post('mped_tipomov = '+stringtosql( Tipomov )+
                  ' and mped_numerodoc = '+inttostr(Numerodoc)+
                  ' and mped_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                  ' and mped_tipo_codigo = '+EdCliente.AsSql );
  gravar := 'N';

  Qp := sqltoquery('select * from movped where mped_status = ''N''' +
                  ' and mped_tipomov = '+stringtosql( Tipomov )+
                  ' and mped_numerodoc = '+inttostr(Numerodoc)+
                  ' and mped_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                  ' and mped_tipo_codigo = '+EdCliente.AsSql );

  for p := 0 to GridItens.RowCount do begin

     codcor:=strtointdef(GridItens.cells[griditens.getcolumn('mpdd_core_codigo'),p],0);
     Produto:=GridItens.cells[griditens.getcolumn('mpdd_esto_codigo'),p];
     valor  := TextToValor(GridItens.cells[griditens.getcolumn('total'),p]);

     if trim(produto)<>'' then begin

// para cada produto gera um novo mestre e mudar o numero no detalhe
         Novonum := FGeral.GetContador('PEDVENDA',false);
         xTransacao := FGEral.GetTransacao;
         Sistema.Edit('movpeddet');
         Sistema.SetField('mpdd_tipo_codigo',FGeral.GetConfig1AsInteger('clievenda'));
         Sistema.SetField('mpdd_numerodoc',Novonum);
         Sistema.SetField('mpdd_transacao',xTransacao);
         Sistema.Post('mpdd_tipomov = '+stringtosql( Tipomov )+
                   ' and mpdd_numerodoc = '+inttostr(Numerodoc)+
                   ' and mpdd_esto_codigo = '+stringtosql(produto)+
                   ' and mpdd_unid_codigo = '+Stringtosql(Global.CodigoUnidade)+
                   ' and mpdd_tipo_codigo = '+EdCliente.AsSql );
// gera outro mestre...
          Sistema.Insert('movped');
          Sistema.SetField('mped_transacao',xTransacao);
          Sistema.SetField('mped_operacao',FGeral.GetOperacao);
          Sistema.SetField('mped_status','N');
          Sistema.SetField('mped_numerodoc',Novonum);
//          if trim(tipomovimento)<>'' then
//            Sistema.SetField('mped_tipomov',TipoMovimento)
//          else
            Sistema.SetField('mped_tipomov',Global.CodPedVenda);
          Sistema.SetField('mped_unid_codigo',Unidade);
          Sistema.SetField('mped_tipo_codigo',FGeral.GetConfig1AsInteger('clievenda'));
          Sistema.SetField('mped_datalcto',Sistema.Hoje);
          Sistema.SetField('mped_datamvto',Emissao);
          Sistema.SetField('mped_datacont',Sistema.Hoje);
          Sistema.SetField('mped_vlrtotal',Valor);
//          if FCondpagto.GetAvPz(EdFpgt_codigo.text)='V' then
//            Sistema.SetField('mped_valoravista',Valortotal)
//          else
//            Sistema.SetField('mped_valoravista',Valorparteavista);
 //         Sistema.SetField('mped_tabp_codigo',Tabela);
          Sistema.SetField('mped_fpgt_codigo',QP.FieldByName('mped_fpgt_codigo').AsString);
//          Sistema.SetField('mped_tabaliquota',FTabela.GetAliquota(Tabela));
          Sistema.SetField('mped_usua_codigo',Global.Usuario.Codigo);
//          Sistema.SetField('mped_pedcliente',EdPedidocliente.asinteger);
          Sistema.SetField('mped_estado',EdCliente.resultfind.fieldbyname('clie_uf').asstring);
          Sistema.SetField('mped_cida_codigo',EdCliente.resultfind.fieldbyname('clie_cida_codigo_res').asinteger);
          Sistema.SetField('mped_repr_codigo',EdRepr_codigo.asinteger);
          Sistema.SetField('mped_tipocad','C');
          Sistema.SetField('mped_dataemissao',QP.FieldByName('mped_dataemissao').AsDatetime);
          Sistema.SetField('mped_totprod',valor);
          Sistema.SetField('mped_vispra',QP.FieldByName('mped_vispra').AsString);
      // ver se vai usar
          Sistema.SetField('mped_perdesco',0);
          Sistema.SetField('mped_peracres',0);
          Sistema.SetField('mped_situacao','P');
          Sistema.SetField('mped_formaped',QP.FieldByName('mped_formaped').AsString);
          Sistema.SetField('mped_envio',QP.FieldByName('mped_envio').AsString);
          Sistema.SetField('Mped_fpgt_prazos',QP.FieldByName('mped_fpgt_prazos').AsString);
          Sistema.SetField('mped_contatopedido','');
          Sistema.SetField('mped_datapedcli',QP.FieldByName('mped_datapedcli').AsDatetime);
//          Sistema.SetField('mped_obslibcredito',obsliberacao);
//          Sistema.SetField('mped_datalibcredito',sistema.hoje);
//          Sistema.SetField('mped_usualibcred',usuariolib);

          Sistema.SetField('mped_obspedido',QP.FieldByName('mped_obspedido').AsString);

          Sistema.SetField('mped_port_codigo',QP.FieldByName('mped_port_codigo').AsString);

         Sistema.Post();
         gravar := 'S';

     end;

  end;

  if Gravar = 'S' then begin

     try
         Sistema.Commit;
         Aviso('Reserva desfeita');

     except on e:exception do begin

         Avisoerro( e.Message );

     end;

     end;

  end;

end;

function TFPosicaoPedidoVenda.PedidoFinanOK: boolean;
begin
end;

function TFPosicaoPedidoVenda.FinanceiroLiberado: boolean;
begin
// 10.01.06 - tania pediu para retirar checagem pois passa os clientes para a rosana 'antes' de digitar o pedido

//  if GridPedidos.cells[GridPedidos.getcolumn('financeiro'),GridPedidos.row]='Pendente' then
//    result:=false
//  else
    result:=true;

end;

procedure TFPosicaoPedidoVenda.EdCaoc_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   if key=#27 then begin
      Pins.visible:=false;
      pbotoes.enabled:=true;
      premessa.enabled:=true;
   end;
end;

procedure TFPosicaoPedidoVenda.EdQtdeKeyPress(Sender: TObject;
  var Key: Char);
begin
   if key=#27 then begin
      Pins.visible:=false;
      pbotoes.enabled:=true;
      premessa.enabled:=true;
   end;

end;

procedure TFPosicaoPedidoVenda.bmontagemClick(Sender: TObject);
begin
  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then exit;
  if trim( GridItens.cells[gridItens.getcolumn('mpdd_esto_codigo'),griditens.row] )='' then exit;
  if not Financeiroliberado then begin
     Avisoerro('Pedido n�o liberado pelo financeiro');
     exit;
  end;
// 29.06.06
  if  GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]='CANCELADO' then begin
    Avisoerro('Pedido cancelado');
    exit;
  end;
  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  EDQTde.setvalue( texttovalor(GridItens.cells[GridItens.getcolumn('mpdd_qtdeenviada'),GridItens.row] ) );

  PMontagem.visible:=true;
  PIns.visible:=true;
  EdCaoc_codigo.enabled:=false;
  EdQtde.enabled:=false;
  pbotoes.enabled:=false;
  premessa.enabled:=false;
  if EdDtMOntagem.isempty then EdDtMOntagem.setdate(sistema.hoje);
  if EdPrevisao.isempty then EdPrevisao.setdate(sistema.hoje);
  EdDtMontagem.setfocus;

end;

procedure TFPosicaoPedidoVenda.EdPrevisaoValidate(Sender: TObject);
begin
   if EdPrevisao.asdate<EdDtMontagem.asdate then
     EdPrevisao.invalid('Previs�o tem que ser igual ou posterior a data de montagem');
end;


procedure TFPosicaoPedidoVenda.EdPrevisaoExitEdit(Sender: TObject);
var codcor,codtam,Numerodoc,codcopa:integer;
    produto:string;
    qtde:currency;
begin
  codcor:=strtoint(GridItens.cells[griditens.getcolumn('mpdd_core_codigo'),griditens.row]);
  codtam:=strtoint(GridItens.cells[griditens.getcolumn('mpdd_tama_codigo'),griditens.row]);
  codcopa:=strtoint(GridItens.cells[griditens.getcolumn('mpdd_tama_codigo'),griditens.row]);
  Produto:=GridItens.cells[griditens.getcolumn('mpdd_esto_codigo'),griditens.row];
  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  qtde:=texttovalor(GridItens.cells[griditens.getcolumn('mpdd_qtde'),griditens.row]);
  if confirma('Confirma datas') then begin
      Sistema.beginprocess('Gravando');
      sistema.edit('movpeddet');
      sistema.setfield('mpdd_datamontagem',EdDtMontagem.asdate);
      sistema.setfield('mpdd_dataprevista',EdPrevisao.asdate);
      Sistema.post( 'mpdd_numerodoc='+inttostr(numerodoc)+' and mpdd_esto_codigo='+stringtosql(produto)+
                   ' and mpdd_core_codigo='+inttostr(codcor)+' and mpdd_tama_codigo='+inttostr(codtam)+
                   ' and mpdd_copa_codigo='+inttostr(codcopa)+
                   ' and mpdd_status=''N''' );
//          +' and mpdd_unid_codigo='+EdUnid_codigo.assql );
      try
        sistema.commit;
        GridItens.cells[griditens.getcolumn('mpdd_datamontagem'),griditens.row]:=formatdatetime('dd/mm/yy',EdDtMontagem.asdate);
        GridItens.cells[griditens.getcolumn('mpdd_dataprevista'),griditens.row]:=formatdatetime('dd/mm/yy',EdPrevisao.asdate);
      except
        avisoerro('Problemas na grava��o das datas no pedido');
      end;
      Sistema.endprocess('');
  end;
  PMOntagem.visible:=false;
  PIns.visible:=false;
  EdCaoc_codigo.enabled:=true;
  EdQtde.enabled:=true;
  pbotoes.enabled:=true;
  premessa.enabled:=true;
  GridItens.SetFocus;


end;

procedure TFPosicaoPedidoVenda.EdBaixaValidate(Sender: TObject);
begin
//  if (sistema.hoje-20)> EdBaixa.asdate then
//    EdBaixa.invalid('Data de baixa superior a 20 dias da data atual');
// liberado - 31.07.06
end;

procedure TFPosicaoPedidoVenda.bautorizaproducaoClick(Sender: TObject);
var numerodoc:integer;
    finan:string;
begin
  if not Global.Usuario.OutrosAcessos[0502] then begin
     Avisoerro('Usu�rio sem permiss�o de confirma��o de atendimento do pedido de venda');
     exit;
  end;
  finan:=GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row];
  if pos(finan,'P;A')=0 then begin
     Avisoerro('Pedido n�o est� pendente nem n�o atendido');
     exit;
  end;
  if pos( '/',GridPedidos.cells[gridpedidos.getcolumn('financeiro'),gridpedidos.row] )>0 then begin
     Avisoerro('Pedido j� liberado para faturamento');
     exit;
  end;
  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then exit;
  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  if finan='P' then begin
    if confirma('Confirma atendimento feito do pedido '+inttostr(numerodoc)) then begin
      Sistema.beginprocess('Gravando');
      sistema.edit('movped');
      sistema.setfield('mped_usualibcred',Global.usuario.codigo);
      sistema.setfield('mped_datalibcredito',sistema.hoje);
      sistema.SetField('mped_situacao','A');
      Sistema.post('mped_numerodoc='+inttostr(numerodoc)+
                   ' and mped_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                   ' and mped_status=''N''');
      try
        sistema.commit;
        GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]:='A';
      except
        avisoerro('Problemas na grava��o do atendimento do pedido');
      end;
      Sistema.endprocess('');
    end;
  end else begin
    if confirma('Confirma o N�O atendimento  do pedido '+inttostr(numerodoc)) then begin
      Sistema.beginprocess('Gravando');
      sistema.edit('movped');
      sistema.setfield('mped_usualibcred',0);
      sistema.setfield('mped_datalibcredito',Texttodate(''));
      sistema.SetField('mped_situacao','P');
      Sistema.post('mped_numerodoc='+inttostr(numerodoc)+
                   ' and mped_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
                   ' and mped_status=''N''');
      try
        sistema.commit;
        GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]:='P';
      except
        avisoerro('Problemas na grava��o do n�o atendimento do pedido');
      end;
      Sistema.endprocess('');
    end;
  end;
end;

// 08.01.20 -
procedure TFPosicaoPedidoVenda.balteracorClick(Sender: TObject);
////////////////////////////////////////////////////////////////

begin

  if  GridPedidos.cells[gridpedidos.getcolumn('mped_situacao'),gridpedidos.row]='CANCELADO' then begin
    Avisoerro('Pedido cancelado');
    exit;
  end;

  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then exit;
  if trim( GridItens.cells[gridItens.getcolumn('mpdd_esto_codigo'),griditens.row] )='' then exit;
  EdCodEspeto.enabled:=true;
  EdCodEspeto.visible:=true;
  Setedcor2.visible:=true;
  Setedcor2.enabled:=true;
  EdCodEspeto.setfocus;


end;

procedure TFPosicaoPedidoVenda.balterapedidoClick(Sender: TObject);
var Numerodoc:integer;
begin
//  if not Global.Usuario.OutrosAcessos[0704] then begin
//     Avisoerro('Usu�rio sem permiss�o de Baixa de pedido de venda');
//     exit;
//  end;
// 29.10.09
  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then exit;
  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  PedidoVenda_Execute('A',Numerodoc);

end;


// 09.01.20
procedure TFPosicaoPedidoVenda.GridPedidosDblClick(Sender: TObject);
///////////////////////////////////////////////////////////////////////
begin

//   if GridPedidos.cells[Gridpedidos.getcolumn('mped_numerodoc'),Gridpedidos.row]<>'' then begin

     if GridPedidos.cells[Gridpedidos.getcolumn('mped_contatopedido'),Gridpedidos.row] = 'OK' then begin

        GridPedidos.cells[Gridpedidos.getcolumn('mped_contatopedido'),Gridpedidos.row] :='';

   //  end else if GridPedidos.cells[Gridpedidos.getcolumn('mped_contatopedido'),Gridpedidos.row] = '' then begin
     end else begin

        GridPedidos.cells[Gridpedidos.getcolumn('mped_contatopedido'),Gridpedidos.row] :='OK';

     end;

 //  end;


end;

procedure TFPosicaoPedidoVenda.GridPedidosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var s:string;
    t:integer;
begin

////{
  if (not (gdSelected in State)) and (ARow>0) then begin
//     ( (Acol=Grid.Getcolumn('paca_quando')) or (Acol=Grid.Getcolumn('situacao')) )
//     and ( trim(Grid.Cells[Grid.GetColumn('paca_quem'),aRow])<>'' ) then begin

        if GridPedidos.Cells[GridPedidos.getcolumn('mped_situacao'),arow]='P' then begin

//           GridPedidos.Canvas.Brush.Color := clred;
           GridPedidos.Canvas.Brush.Color := claqua;
           s:=GridPedidos.Cells[ACol,ARow];
           GridPedidos.Canvas.FillRect(Rect);
           t:=GridPedidos.Canvas.TextWidth(s)+2;
           if GridPedidos.Columns[ACol].Alignment=taRightJustify then
              GridPedidos.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else GridPedidos.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);

        end else if GridPedidos.Cells[GridPedidos.getcolumn('mped_situacao'),arow]='E' then begin

           GridPedidos.Canvas.Brush.Color := clYellow;
           s:=GridPedidos.Cells[ACol,ARow];
           GridPedidos.Canvas.FillRect(Rect);
           t:=GridPedidos.Canvas.TextWidth(s)+2;
           if GridPedidos.Columns[ACol].Alignment=taRightJustify then
              GridPedidos.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else GridPedidos.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
// 20.09.11
        end else if GridPedidos.Cells[GridPedidos.getcolumn('mped_situacao'),arow]='A' then begin

           GridPedidos.Canvas.Brush.Color := clGreen;
           s:=GridPedidos.Cells[ACol,ARow];
           GridPedidos.Canvas.FillRect(Rect);
           t:=GridPedidos.Canvas.TextWidth(s)+2;
           if GridPedidos.Columns[ACol].Alignment=taRightJustify then
              GridPedidos.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else GridPedidos.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
// 20.09.11
        end else if GridPedidos.Cells[GridPedidos.getcolumn('mped_situacao'),arow]='B' then begin

           GridPedidos.Canvas.Brush.Color := clWhite;
           s:=GridPedidos.Cells[ACol,ARow];
           GridPedidos.Canvas.FillRect(Rect);
           t:=GridPedidos.Canvas.TextWidth(s)+2;
           if GridPedidos.Columns[ACol].Alignment=taRightJustify then
              GridPedidos.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else GridPedidos.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);
        end else if GridPedidos.Cells[GridPedidos.getcolumn('mped_situacao'),arow]<>'' then begin

           GridPedidos.Canvas.Brush.Color := clBlue;
           s:=GridPedidos.Cells[ACol,ARow];
           GridPedidos.Canvas.FillRect(Rect);
           t:=GridPedidos.Canvas.TextWidth(s)+2;
           if GridPedidos.Columns[ACol].Alignment=taRightJustify then
              GridPedidos.Canvas.TextRect(Rect,Rect.Right-t,Rect.Top+2,s)
           else GridPedidos.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,s);

        end;

  end;
//}


end;

procedure TFPosicaoPedidoVenda.bimpcomcustoClick(Sender: TObject);
//////////////////////////////////////////////////////////////////////
var numerodoc:integer;
    emissao:TDatetime;
begin

  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then begin
    Avisoerro('Escolher pedido');
    exit;
  end;
  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_dataemissao'),gridpedidos.row])='' then begin
    Avisoerro('Checar Data emiss�o do pedido');
    exit;
  end;
  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  Emissao:=texttodate(Fgeral.TiraBarra(Gridpedidos.cells[gridpedidos.getcolumn('mped_dataemissao'),gridpedidos.row]));
  if Numerodoc>0 then
    FImpressao.ImprimePedidoVenda(Numerodoc,emissao,edunid_codigo.text,'C',GridPedidos.cells[gridpedidos.getcolumn('mped_tipomov'),gridpedidos.row])


end;

// 18.04.18
procedure TFPosicaoPedidoVenda.bimpopClick(Sender: TObject);
////////////////////////////////////////////////////////////////
var numerodoc:integer;
    emissao:TDatetime;

begin

  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row])='' then begin
    Avisoerro('Escolher pedido');
    exit;
  end;
  if trim( GridPedidos.cells[gridpedidos.getcolumn('mped_dataemissao'),gridpedidos.row])='' then begin
    Avisoerro('Checar Data emiss�o do pedido');
    exit;
  end;
  Numerodoc:=strtoint(GridPedidos.cells[gridpedidos.getcolumn('mped_numerodoc'),gridpedidos.row]);
  Emissao:=texttodate(Fgeral.TiraBarra(Gridpedidos.cells[gridpedidos.getcolumn('mped_dataemissao'),gridpedidos.row]));
  if Numerodoc>0 then
    FImpressaoOP.Execute(Numerodoc,emissao,edunid_codigo.text)

end;

end.
