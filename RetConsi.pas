unit RetConsi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr, CheckLst, Sqlfun, SqlSis,SqlRel;
//  , DataGrid;

type
  TFRetConsig = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bIncluiritem: TSQLBtn;
    bExcluiritem: TSQLBtn;
    bCancelaritem: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdCliente: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdNumeroDoc: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    EdRemessas: TSQLEd;
    cb: TCheckListBox;
    bConfirma: TSQLBtn;
    StaticText1: TStaticText;
    EdDtemissao: TSQLEd;
    EdDtMovimento: TSQLEd;
    EdValorvenda: TSQLEd;
    bSaldo: TSQLBtn;
    PSaldo: TSQLPanelGrid;
    GridSaldo: TSqlDtGrid;
    bfechar: TSQLBtn;
    Pcodigos: TSQLPanelGrid;
    GridCodigos: TSqlDtGrid;
    EdValordev: TSQLEd;
    EdQtdedev: TSQLEd;
    PAux: TSQLPanelGrid;
    EdPagto: TSQLEd;
    Edperdesco: TSQLEd;
    EdVlrdesco: TSQLEd;
    PParcelas: TSQLPanelGrid;
    GridParcelas: TSqlDtGrid;
    EdParcela: TSQLEd;
    EdVencimento: TSQLEd;
    EdNomerepr: TSQLEd;
    EdPort_codigo: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    EdCodcopa: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    bgeranfe: TSQLBtn;
    EdCupomfiscal: TSQLEd;
    EdPend_Port_codigo: TSQLEd;
    EdVlrAdiantamento: TSQLEd;
    EdComcpf: TSQLEd;
    Pportador01: TSQLPanelGrid;
    GridParcelas01: TSqlDtGrid;
    Edportador01: TSQLEd;
    Edport_descricao: TSQLEd;
    Edpagto01: TSQLEd;
    Edvencimento01: TSQLEd;
    EdParcela01: TSQLEd;
    Pportador02: TSQLPanelGrid;
    GridParcelas02: TSqlDtGrid;
    Edportador02: TSQLEd;
    Edport_descricao01: TSQLEd;
    Edpagto02: TSQLEd;
    Edvencimento02: TSQLEd;
    EdParcela02: TSQLEd;
    brelat: TSQLBtn;
    bsimluacao: TSQLBtn;
    procedure EdClienteValidate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdRemessasValidate(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure bIncluiritemClick(Sender: TObject);
    procedure EdQtdeExitEdit(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure bExcluiritemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bGravarClick(Sender: TObject);
    procedure cbClickCheck(Sender: TObject);
    procedure bConfirmaClick(Sender: TObject);
    procedure EdPagtoValidate(Sender: TObject);
    procedure EdPagtoKeyPress(Sender: TObject; var Key: Char);
    procedure bSaldoClick(Sender: TObject);
    procedure bfecharClick(Sender: TObject);
    procedure EdDtMovimentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridCodigosClick(Sender: TObject);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdperdescoValidate(Sender: TObject);
    procedure GridParcelasDblClick(Sender: TObject);
    procedure GridParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure EdParcelaExitEdit(Sender: TObject);
    procedure EdVencimentoExitEdit(Sender: TObject);
    procedure EdVlrdescoValidate(Sender: TObject);
    procedure EdPagtoExitEdit(Sender: TObject);
    procedure EdRemessasExitEdit(Sender: TObject);
    procedure cbDblClick(Sender: TObject);
    procedure GridSaldoDblClick(Sender: TObject);
    procedure EdProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdCodtamanhoValidate(Sender: TObject);
    procedure EdCodcopaValidate(Sender: TObject);
    procedure bgeranfeClick(Sender: TObject);
    procedure EdPend_Port_codigoExitEdit(Sender: TObject);
    procedure GridCodigosKeyPress(Sender: TObject; var Key: Char);
    procedure EdPend_Port_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdVlrAdiantamentoValidate(Sender: TObject);
    procedure EdPort_codigoValidate(Sender: TObject);
    procedure EdDtMovimentoExit(Sender: TObject);
    procedure Edportador01Validate(Sender: TObject);
    procedure Edpagto01KeyPress(Sender: TObject; var Key: Char);
    procedure Edpagto01Validate(Sender: TObject);
    procedure GridParcelas01DblClick(Sender: TObject);
    procedure GridParcelas01KeyPress(Sender: TObject; var Key: Char);
    procedure EdParcela01ExitEdit(Sender: TObject);
    procedure Edvencimento01ExitEdit(Sender: TObject);
    procedure Edportador02Validate(Sender: TObject);
    procedure Edpagto02KeyPress(Sender: TObject; var Key: Char);
    procedure Edpagto02Validate(Sender: TObject);
    procedure GridParcelas02DblClick(Sender: TObject);
    procedure GridParcelas02KeyPress(Sender: TObject; var Key: Char);
    procedure Edvencimento02ExitEdit(Sender: TObject);
    procedure EdParcela02ExitEdit(Sender: TObject);
    procedure Edpagto01ExitEdit(Sender: TObject);
    procedure brelatClick(Sender: TObject);
    procedure bsimluacaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure EditstoGrid;
    procedure AtivaEditsParcelas;
    procedure AtivaEditsParcelas01;
    function ValorDesconto(valor:currency):currency;
    procedure MostraRepr(codigo:integer);
    function GetSaldoAntecipacao(xtipocad:string;xcodigo:integer):currency;
    procedure AtualizaGridSaldo(xcodigo,xop:string;xqtde:currency);
    function ValorGrid:currency;
    function ValorGrid01:currency;
    function ValorGrid02:currency;
    procedure AtivaEditsParcelas02;
  end;

var
  FRetConsig: TFRetConsig;
  QRemessas,QDevolucoes,QGrade:TSqlquery;
  QProdRemessa,QProdDevolvido:TMemoryQuery;
  ValorRetorno,Totalnota,TotalNf,Vlrnf,icmssubs,ValorMaximoAdiantamento,totalremessa,totaldevolucoes,
  totalsaldomedia:currency;
  CodRepre:integer;
  mediapreco:currency;
  produtoescolhido:string;
  FazNfDiferenca,TemSubsproduto:boolean;
  sqlremessasm,sqlremessasd,sqldevolucoesm,sqldevolucoesd,sqlstatusdevd,sqlstatusdevm,
  sqlstatusremd,sqlstatusremm,RemessaCG:string;
  DataDevolucoes:TDatetime;
  Campo:TDicionario;

implementation

uses Geral, Estoque, conpagto, Arquiv, codigosfis, represen,
  cadcor, tamanhos, cadcopa, expnfetxt,relgerenciais,
  /////////////////ecfteste1,
  portador;

{$R *.dfm}


procedure TFRetConsig.EdClienteValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////

   procedure QuerytoItens(Q:TSqlquery;Ed:TSqled;Chec:TCheckListbox);
   /////////////////////////////////////////////////////////////////////
   var num:integer;
       xremessas,s,magazine:string;
   begin
     Ed.Items.Clear;xremessas:='';
     Grid.Clear;
     Chec.Clear;
     while not Q.Eof do begin
       num:=Q.fieldbyname('moes_numerodoc').AsInteger;
       if pos(strzero(num,8),xremessas)=0 then begin
         xremessas:=xremessas+strzero(num,8)+';';
//         Ed.Items.Add(strzero(num,8)+' de '+Q.fieldbyname('moes_datamvto').AsString );
//         Chec.Items.Add(strzero(num,8)+' de '+Q.fieldbyname('moes_datamvto').AsString);
         if Q.fieldbyname('moes_rcmagazine').asstring='S' then
           magazine:='M'
         else if trim(Q.fieldbyname('moes_rcmagazine').asstring)<>'N' then
           magazine:=Q.fieldbyname('moes_rcmagazine').asstring
         else
           magazine:=' ';
         Chec.Items.Add(strzero(num,8)+' '+Q.fieldbyname('moes_datamvto').AsString+' '+magazine);
       end;
       Q.Next;
     end;
     s:='';
     for num:=0 to chec.count-1 do begin
       chec.Checked[num]:=true;
       s:=s+copy(cb.Items[num],1,8)+';';
     end;
     if length(s)>EdRemessas.MaxLength then begin
       Avisoerro('Aten��o !  N�mero m�ximo de remessas ultrapassado');
       EdRemessas.text:='';
     end else
       EdRemessas.Text:=s;

   end;

begin
/////////////////////////
//  EdDtMovimento.Text:='';
//  EdDtMovimento.setdate(sistema.hoje);
// 27.09.10
  FGeral.setamovimento(EdDtmovimento);
  EdValorvenda.setvalue(0);
  EdValordev.setvalue(0);
  EdQTdedev.setvalue(0);
  FazNfDiferenca:=false;
  EdRemessas.enabled:=true;
  GridParcelas.clear;   // 29.03.06
  GridParcelas01.clear;   // 08.11.15
  EdPortador01.Clear;
  EdPagto01.clear;
  GridParcelas02.clear;   // 08.11.15
  EdPortador02.Clear;
  EdPagto02.clear;
  PPortador01.visible:=false;
  PPortador02.visible:=false;
  ValorMaximoAdiantamento:=0;
  if not FGeral.ValidaCliente(EdCliente) then
    EdCliente.Invalid('')
  else begin
//    EdUnid_Codigo.Text:=EdCliente.ResultFind.fieldbyname('clie_unid_codigo').AsString;
    EdUnid_Codigo.Text:=Global.CodigoUnidade;
// 07.01.05 - assim so deixa fazer acerto na unidade 'em uso'  - vamos ver se alguem gritar
//   ter� q colocar a unidade digitada
    EdUnid_codigo.ValidFind;
    Sistema.beginprocess('Checando remessas do cliente');
    QRemessas:=Sqltoquery('select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,moes_repr_codigo,moes_tabp_codigo,moes_rcmagazine'+
            ' from movesto,movestoque where moes_tipo_codigo='+EdCliente.AsSql+
//            ' and '+FGeral.getin('moes_status','N;E','C')+
            sqlstatusremm+
            ' and '+FGeral.getin('moes_tipomov',Global.CodRemessaConsig+';'+Global.CodVendaTransf,'C')+
// 22.04.05 - colocado a unidade, tal qual tem quando vai buscar os produtos
            ' and moes_unid_codigo='+EdUnid_codigo.assql+
            ' and moes_transacao=move_transacao'+
            ' and moes_unid_codigo=move_unid_codigo'+
            ' and moes_status=move_status'+
//            ' and '+FGeral.getin('move_status','N;E','C')+
            sqlremessasm+
            ' and move_tipo_codigo='+EdCliente.AsSql+
            ' order by moes_datamvto,moes_numerodoc');
    Sistema.endprocess('');
    if QRemessas.Eof then begin
      EdCliente.Invalid('Cliente sem remessas em aberto');
      Codrepre:=0;
    end else begin
      CodRepre:=Qremessas.fieldbyname('moes_repr_codigo').asinteger;
      Mostrarepr(codrepre);
      QuerytoItens(QRemessas,EdRemessas,Cb);
    end;
    EdVlradiantamento.setvalue( GetSaldoAntecipacao( 'C',EdCliente.asinteger ) );
    ValorMaximoAdiantamento:=EdVlrAdiantamento.ascurrency;
// 15.08.13 - Vivan
    if  (campo.Tipo<>'') and (EdCliente.resultfind<>nil) then begin
      if ( trim(EdCliente.resultfind.fieldbyname('clie_portadores').asstring)<>'' ) then begin
        EdPort_codigo.ShowForm:='';
        FPortadores.SetaItems(EdPort_codigo,EdCliente.resultfind.fieldbyname('clie_portadores').asstring);
        EdPortador01.ShowForm:='';
        FPortadores.SetaItems(EdPortador01,EdCliente.resultfind.fieldbyname('clie_portadores').asstring);
        EdPortador02.ShowForm:='';
        FPortadores.SetaItems(EdPortador02,EdCliente.resultfind.fieldbyname('clie_portadores').asstring);
      end else begin
        EdPort_codigo.ShowForm:='FPortadores';
        EdPort_codigo.Items.Clear;
        EdPortador01.ShowForm:='FPortadores';
        EdPortador01.Items.Clear;
      end;
//      end else begin
        PPortador01.enabled:=false;
        PPortador01.visible:=false;
        PPortador02.enabled:=false;
        PPortador02.visible:=false;
//      end;
    end else begin
        EdPort_codigo.ShowForm:='FPortadores';
        EdPort_codigo.Items.Clear;
        EdPortador01.ShowForm:='FPortadores';
        EdPortador01.Items.Clear;
        PPortador01.enabled:=false;
        PPortador01.visible:=false;
        EdPortador02.ShowForm:='FPortadores';
        EdPortador02.Items.Clear;
        PPortador02.enabled:=false;
        PPortador02.visible:=false;
    end;
  end;
  cb.Enabled:=true;

end;

procedure TFRetConsig.Execute;
////////////////////////////////////
begin
  icmssubs:=0;vlrnf:=0;
  if Global.usuario.codigo=300000 then begin
    sqlremessasm:=' and '+FGeral.Getin('moes_numerodoc','6798;7645;7600;7621;7620;7516;6821;7453;7599;7646;6809','N');
    sqlremessasd:=' and '+FGeral.Getin('move_numerodoc','6798;7645;7600;7621;7620;7516;6821;7453;7599;7646;6809','N');
//+';'+strzero(129499,8)
    sqldevolucoesd:=' and '+FGeral.Getin('move_numerodoc',strzero(128468,8)+';'+strzero(129728,8)+';'+strzero(129730,8)+';'+strzero(128575,8)+';'+
                  strzero(128425,8)+';'+strzero(128423,8)+';'+strzero(130505,8)+';'+strzero(129499,8),'N');
    sqldevolucoesm:=' and '+FGeral.Getin('moes_numerodoc',strzero(128468,8)+';'+strzero(129728,8)+';'+strzero(129730,8)+';'+strzero(128575,8)+';'+
                  strzero(128425,8)+';'+strzero(128423,8)+';'+strzero(130505,8)+';'+strzero(000000,8),'N');
// strzero(129499,8)
    sqlstatusremd:=' and move_status<>''C''';
    sqlstatusremm:=' and moes_status<>''C''';
    sqlstatusdevd:=' and move_status<>''C''';
    sqlstatusdevm:=' and moes_status<>''C''';
  end else begin
    sqlremessasm:='';
    sqldevolucoesm:='';
    sqlremessasd:='';
    sqldevolucoesd:='';
    sqlstatusremd:=' and '+FGeral.Getin('move_status','N;E','C');
    sqlstatusremm:=' and '+FGeral.Getin('moes_status','N;E','C');
//    sqlstatusdevd:=' and '+FGeral.Getin('move_status','N','C');
    sqlstatusdevd:=' and '+FGeral.Getin('move_status','N;D','C');
//    sqlstatusdevm:=' and '+FGeral.Getin('moes_status','N','C');
// 27.06.13
    sqlstatusdevm:=' and '+FGeral.Getin('moes_status','N;D','C');
  end;
  fGeral.ConfiguraColorEditsNaoEnabled(FRetConsig);
  show;
//// - 25.08.06
  Grid.Clear;
  cb.clear;
  EdRemessas.Clear;
  EdDtEmissao.SetDate(Sistema.Hoje);
  EdDtemissao.enabled:=Global.Usuario.OutrosAcessos[0702];
  EdDtmovimento.setdate(sistema.hoje);
  EdCliente.SetFocus;
////
  EdCupomfiscal.Enabled:=FGeral.ConfiguradoECF;
  Global.FpgtoAntecipa:=FGeral.GetConfig1AsString('Fpgtoantecipa');
  RemessaCG:='';
//  DataDevolucoes:=Sistema.hoje-60;  // 27.06.13
//DataDevolucoes:=Sistema.hoje-120;  // // 16.07.13
  DataDevolucoes:=Sistema.hoje-180;  // // 01.04.15 - fama - janina remesse e devolucao de 11.2014 fechando em 04.2015
// 15.08.13
  campo:=Sistema.GetDicionario('clientes','clie_portadores');

end;

procedure TFRetConsig.FormActivate(Sender: TObject);
//////////////////////////////////////////////////////
begin
  if not Arq.TEstoque.active then Arq.TEstoque.open;
  if not Arq.TSittributaria.active then Arq.TSittributaria.open;
  produtoescolhido:='';
end;

///////////////////////////////////////////////////////////////////
procedure TFRetConsig.EdRemessasValidate(Sender: TObject);
///////////////////////////////////////////////////////////////////
var remessa,devolvido:currency;
    posicao,p:integer;
    ListaDevolucoes:TStringList;

    function TemnoGrid(produto:string):boolean;
    ////////////////////////////////////////////
    var s:integer;
    begin
      result:=false;
      for s:=1 to Gridcodigos.rowcount do begin
        if trim(Gridcodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),s])<>'' then begin
          if Gridcodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),s]=produto then begin
            result:=true;
            break;
          end;
        end;
      end;
    end;


begin
//////////////////////////////////
// 18.01.13
  if  ( pos('.',EdRemessas.text)>0 )  or  ( pos(',',EdRemessas.text)>0 )
    or ( length(EdRemessas.text) >1000 )
    then begin
    if not confirma('Encontrado . ou , nos numeros das remessas.   Confirma estas remessas ?') then
      exit;
  end;
  if copy(EdRemessas.text,1,1)='3' then begin
    Avisoerro('Verificar.  Encontrado o numero 3 no inicio do campo das remessas escolhidas.');
    exit;
  end;
//////////////////////////////
  Sistema.beginprocess('Separando produtos das remessas escolhidas');
  ListaDevolucoes:=TStringList.create;

  QProdRemessa:=Sqltomemoryquery('select moes_vlrtotal,moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,moes_remessas,movestoque.* from movesto,movestoque'+
          ' where moes_tipo_codigo='+EdCliente.AsSql+
//          ' and '+FGeral.GetIN('moes_numerodoc',EdRemessas.Text,'N')+
          ' and moes_unid_codigo='+EdUnid_codigo.assql+
//          ' and '+FGeral.getin('moes_status','N;E','C')+
          ' and '+FGeral.getin('moes_tipomov',Global.CodRemessaConsig+';'+Global.CodVendaTransf,'C')+
          ' and moes_transacao=move_transacao'+
          ' and moes_numerodoc=move_numerodoc'+
          sqlremessasm+sqlremessasd+sqlstatusremm+sqlstatusremd+
          ' and moes_tipo_codigo=move_tipo_codigo'+
//          ' and '+FGeral.getin('move_status','N;E','C')+
          ' and '+FGeral.getin('move_tipomov',Global.CodRemessaConsig+';'+Global.CodVendaTransf,'C')+
//          ' and moes_tipomov=move_tipomov'+
          ' order by move_esto_codigo,moes_numerodoc');
  remessa:=0;totalremessa:=0;
  Gridcodigos.clear;
// 29.07.05 - pegava o representante das remessas mas antes de marcar quais seria 'usadas'
  if not QProdremessa.eof then begin
     if QProdremessa.fieldbyname('move_repr_codigo').asfloat>0 then begin // 02.08.05
       CodRepre:=strtointdef(floattostr(QProdremessa.fieldbyname('move_repr_codigo').asfloat),0);
       Mostrarepr(codrepre);
     end;
  end;
// 04.11.05 - gambiarra devido as malditas joias dentro da matriz...
  TemSubsproduto:=false;
  while not QProdremessa.eof do begin

//    if FGeral.EstaemAberto(QProdRemessa.fieldbyname('moes_remessas').AsString,EdRemessas.text) then begin
    if FGeral.Estaemaberto(QProdRemessa.fieldbyname('moes_numerodoc').AsString,EdRemessas.text) then begin
      remessa:=remessa+QProdremessa.fieldbyname('move_qtde').AsFloat;
      totalremessa:=totalremessa+(QProdremessa.fieldbyname('move_qtde').Asfloat*QProdremessa.fieldbyname('move_venda').Asfloat);
      posicao:=FGeral.ProcuraGrid(Gridcodigos.getcolumn('move_esto_codigo'),QProdremessa.fieldbyname('move_esto_codigo').Asstring,Gridcodigos);
      if posicao =0 then begin
        FGeral.IncluiGrid(Gridcodigos,QProdremessa.fieldbyname('move_esto_codigo').Asstring,'move_esto_codigo');
        if (QProdremessa.fieldbyname('move_repr_codigo').asfloat>0) then  begin// 02.08.05
          CodRepre:=strtointdef(floattostr(QProdremessa.fieldbyname('move_repr_codigo').asfloat),0);
          if FEstoque.Getsituacaotributaria(QProdremessa.fieldbyname('move_esto_codigo').asstring,EdUnid_codigo.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring)='010' then
            TemSubsproduto:=true;
          Mostrarepr(codrepre);
        end;
      end;
// 03.05.06
      posicao:=FGeral.ProcuraGrid(Gridcodigos.getcolumn('move_esto_codigo'),QProdremessa.fieldbyname('move_esto_codigo').Asstring,Gridcodigos);
      if posicao>0 then begin
        Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),posicao]) +
           QProdremessa.fieldbyname('move_qtde').AsFloat  );
// 20.09.10 - Doce Pimenta - Dorilde
        Gridcodigos.cells[Gridcodigos.getcolumn('move_venda'),posicao]:= QProdremessa.fieldbyname('move_venda').AsString ;
// 15.01.14 - Vivan - pre�o m�dio 'antes' de fechar
        Gridcodigos.cells[Gridcodigos.getcolumn('nrorem'),posicao]:=inttostr(
           strtointdef(Gridcodigos.cells[Gridcodigos.getcolumn('nrorem'),posicao],0)+
           + 1 ) ;
        Gridcodigos.cells[Gridcodigos.getcolumn('vendamedio'),posicao]:=Valortosql(
            TextToValor(Gridcodigos.cells[Gridcodigos.getcolumn('vendamedio'),posicao]) +
            QProdremessa.fieldbyname('move_venda').AsFloat );
      end;

    end;

    QProdremessa.Next;

  end;

  Sistema.endprocess('');

  if remessa=0 then begin
    EdRemessas.Invalid('N�o encontrado produtos das remessas escolhidas');
    EdCliente.setfocus;

  end else begin

    Sistema.beginprocess('Separando as devolu��es das remessas escolhidas');
// rever : no retorno da consigna�ao mu
   QProdDevolvido:=Sqltomemoryquery('select moes_tipo_codigo,moes_status,moes_numerodoc,moes_datamvto,movestoque.* from movesto,movestoque'+
          ' where moes_tipo_codigo='+EdCliente.AsSql+' and move_unid_codigo='+EdUNid_codigo.AsSql+
          ' and moes_status=''N'''+
          ' and '+FGeral.Getin('moes_tipomov',Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca,'C')+
          ' and moes_unid_codigo=move_unid_codigo'+
          ' and moes_numerodoc=move_numerodoc'+
          ' and move_status=''N'''+
          ' and moes_tipomov=move_tipomov'+
          ' and moes_datamvto >= '+Datetosql(DataDevolucoes)+
          sqldevolucoesm+sqldevolucoesd+sqlstatusdevm+sqlstatusdevd+
          ' and moes_transacao=move_transacao'+
////////////          ' and moes_status=move_status'+  // 27.06.13
          ' order by move_esto_codigo,moes_numerodoc');

    devolvido:=0;totaldevolucoes:=0;
    while not QProdDevolvido.eof do begin
//      if ansipos(trim(EdRemessas.text),QProdDevolvido.fieldbyname('move_remessas').AsString)>0 then

      if ( FGeral.EstaemAberto(QProdDevolvido.fieldbyname('move_remessas').AsString,EdRemessas.text) )
         and  // 27.06.13
          (  QProdDevolvido.fieldbyname('move_status').asstring='N' )
         then begin
// 14.03.05 - checar tbem se o codigo do item das devolucoes esta nas remessas marcadas---
// situacao : quando fez devolu��o marcou todas as remessas mas fez acerto marcando somente algumas remessas
//            e entre essas marcadas nao constava a remessa da devolu��o feita....
        if TemnoGrid(QProdDevolvido.fieldbyname('move_esto_codigo').Asstring) then begin
// 03.05.06
           posicao:=FGeral.ProcuraGrid(Gridcodigos.getcolumn('move_esto_codigo'),QProdDevolvido.fieldbyname('move_esto_codigo').Asstring,Gridcodigos);
           if posicao >0 then
             Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),Posicao]:= floattostr( texttovalor(Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),posicao]) -
             QProdDevolvido.fieldbyname('move_qtde').AsFloat  );

          if ListaDevolucoes.indexof(QProdDevolvido.fieldbyname('move_numerodoc').AsString)=-1 then
            ListaDevolucoes.Add(QProdDevolvido.fieldbyname('move_numerodoc').AsString);

          devolvido:=devolvido+QProdDevolvido.fieldbyname('move_qtde').Asfloat;
// 24.08.06 - if para os 'refechamento'  de vc da mari savi....
          if QProddevolvido.fieldbyname('move_venda').Asfloat=0 then
            totaldevolucoes:=totaldevolucoes+(QProdDevolvido.fieldbyname('move_qtde').Asfloat*(FEstoque.Getpreco(QProdDevolvido.fieldbyname('move_esto_codigo').Asstring,QProdDevolvido.fieldbyname('move_unid_codigo').Asstring)) )
          else
            totaldevolucoes:=totaldevolucoes+(QProdDevolvido.fieldbyname('move_qtde').Asfloat*QProddevolvido.fieldbyname('move_venda').Asfloat);
        end;
//else
//          Aviso('Codigo '+QProdDevolvido.fieldbyname('move_esto_codigo').Asstring+' devolvido n�o est� nas remessas' );
      end;
       //else
//        Aviso(trim(QProdDevolvido.fieldbyname('move_remessas').AsString)+' - '+
//              QProdDevolvido.fieldbyname('move_numerodoc').AsString );

      QProdDevolvido.Next;
    end;
    Sistema.endprocess('');
//    EdValorvenda.SetValue(totalremessa-totaldevolucoes-valordesconto(totalremessa-totaldevolucoes));

//    EdValorvenda.SetValue(totalremessa-totaldevolucoes);
// 15.01.14 - pelo pre�o m�dio de venda das remessas
    totalsaldomedia:=0;
    for p:=1 to Gridcodigos.RowCount do begin
      if Texttovalor( GridCodigos.Cells[Gridcodigos.getcolumn('nrorem'),p]) > 0 then begin
        totalsaldomedia:=totalsaldomedia+TextToValor(GridCodigos.Cells[Gridcodigos.getcolumn('move_qtde'),p]) * 
        Roundvalor( TextToValor( GridCodigos.Cells[Gridcodigos.getcolumn('vendamedio'),p] ) / Texttovalor( GridCodigos.Cells[Gridcodigos.getcolumn('nrorem'),p] ) )
      end;
    end;
    EdValorvenda.SetValue(totalsaldomedia);

//    Aviso( ListaDevolucoes.Text );

    Aviso('Qtde remessa : '+FGeral.Formatavalor(remessa,'00000')+
                      '   Qtde retorno : '+FGeral.Formatavalor(devolvido,'00000')+
                      '   Saldo : '+FGeral.Formatavalor(remessa-devolvido,'00000') );
    cb.Enabled:=false;
    bincluiritemclick(FRetConsig);
  end;
  ListaDevolucoes.free;

end;

procedure TFRetConsig.EdProdutoValidate(Sender: TObject);
var QBusca,QEstoque,TEstoque:TSqlquery;
    codigobarra:boolean;
    codbarra:string;
begin
  if not FEstoque.ValidaCodigoProduto(EdProduto,EdProduto.text) then begin
    Edproduto.invalid('');
    exit;
  end;
  codigobarra:=false;
  codbarra:=EdProduto.text;
// 24.02.16
  TEstoque:=sqltoquery('select * from estoque where esto_codigo='+EdProduto.Assql);
//  if FGeral.CodigoBarra(EdProduto.Text) then begin
// 24.10.12 - Vivan - leitor viado
  if FGeral.CodigoBarra(EdProduto.Text,EdProduto) then begin

    QBusca:=sqltoquery('select * from estoque where esto_Codbarra='+EdProduto.Assql);
    if not QBusca.Eof then begin
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString;
      Arq.TEstoque.locate('esto_codigo',EdProduto.text,[]);
    end;  //  tirado em 20.01.11 else
//      EdProduto.Invalid('Codigo de barra n�o encontrado');
//    FGeral.fechaquery(QBusca);
    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsCurrency,EdUNid_codigo.Text,QEstoque) then begin
       EdProduto.INvalid('Quantidade em estoque insuficiente');
       exit;
    end;
// 30.08.06
/////////////////////////
    EdCodcor.enabled:=false;
    EdCodtamanho.enabled:=false;
    EdCodcopa.enabled:=false;
    EdCodcor.text:='';
    EdCodtamanho.text:='';
    EdCodcopa.text:='';
    if QBusca.eof  then begin
      QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'''+
                       ' and esgr_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
                       ' and esgr_codbarra='+stringtosql(codbarra));
      if not QGrade.eof then begin
        EdProduto.Text:=QGrade.fieldbyname('esgr_esto_codigo').AsString;
        EdCodcor.setvalue(QGrade.fieldbyname('esgr_core_codigo').asinteger);
        EdCodcor.validfind;
        EdCodtamanho.setvalue(QGrade.fieldbyname('esgr_tama_codigo').asinteger);
        EdCodtamanho.validfind;
        EdCodcopa.setvalue(QGrade.fieldbyname('esgr_copa_codigo').asinteger);
        EdCodcopa.validfind;
        FGeral.Fechaquery(QEstoque);
        QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
        FGeral.Fechaquery(QBusca);
        QBusca:=sqltoquery('select * from estoque where esto_codigo='+EdProduto.assql);
      end else begin

        EdProduto.Invalid('Codigo de barra da grade n�o encontrado');
        exit;

      end;

    end;
/////////////////////////

    SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;
    EdQtde.Enabled:=false;
    EdQtde.SetValue(1);
// 06.01.2021
    if not FEstoque.ValidaTributacaoProduto( EdProduto.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring,'VC' ) then
       EdProduto.Invalid('');

//  end else if Arq.TEstoque.locate('esto_codigo',EdProduto.text,[]) then begin
// 24.02.16 - passou 'do nada' a nao encontrar
  end else if not TEstoque.eof then begin

    EdQtde.Enabled:=true;
    EdQtde.SetValue(0);
    EdCodcor.enabled:=true;
    EdCodtamanho.enabled:=true;
    EdCodcopa.enabled:=true;
    EdCodcor.text:='';
    EdCodtamanho.text:='';
    EdCodcopa.text:='';
// 30.08.06
    if (pos( EdProduto.text,FGeral.Getconfig1asstring('Produtoscopa') )>0) and ( not codigobarra) then
      EdcodCopa.enabled:=true
    else begin
      EdCodCopa.enabled:=false;
      EdCodCopa.setvalue(0);
    end;
    SetEdEsto_descricao.text:=TEstoque.fieldbyname('esto_descricao').asstring;

     // 06.01.2021
    if not FEstoque.ValidaTributacaoProduto( EdProduto.text,EdCliente.resultfind.fieldbyname('clie_uf').asstring,'VC' ) then
       EdProduto.Invalid('');

  end else

    EdProduto.Invalid('Produto n�o encontrado');

  TEstoque.close;

end;

procedure TFRetConsig.bIncluiritemClick(Sender: TObject);
begin
  if not EdCliente.Asinteger=0 then exit;
  if Trim(EdRemessas.Text)='' then exit;
  if QProdRemessa=nil then exit;
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
  bSaldo.Enabled:=true;
  PINs.Visible:=true;
  PINs.EnableEdits;
  Edproduto.ClearAll(FRetconsig,99);
  EdProduto.SetFocus;

end;

procedure TFRetConsig.brelatClick(Sender: TObject);
//////////////////////////////////////////////////
begin

  if not Sistema.Processando then FRelGerenciais_ConsigAberto(EdCliente.AsInteger);


end;

procedure TFRetConsig.EdQtdeExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////
var y,w:integer;
    qtgrid:currency;

  function TemnasRemessas(Produto:string;Qtde:currency):integer;
  ///////////////////////////////////////////////
  var remessa,devolvido:currency;
      x,p:integer;
  begin
    QProdRemessa.First;x:=0;
    remessa:=0;devolvido:=0;mediapreco:=0;
    while not QProdRemessa.Eof do begin

      if FGeral.Estaemaberto(QProdRemessa.fieldbyname('moes_numerodoc').AsString,EdRemessas.text) then begin
        if QProdRemessa.FieldByName('move_esto_codigo').asstring=Produto then begin
           remessa:=remessa+QProdRemessa.FieldByName('move_qtde').asfloat;
           mediapreco:=mediapreco+QProdRemessa.FieldByName('move_venda').asfloat;
           inc(x);
        end;
      end;
      QProdRemessa.Next;

    end;

    QProdDevolvido.First;
    while not QProdDevolvido.Eof do begin

      if QProdDevolvido.FieldByName('move_esto_codigo').asstring=Produto then begin
        if FGeral.EstaemAberto(QProdDevolvido.fieldbyname('move_remessas').AsString,EdRemessas.text) then
//        if ansipos(trim(EdRemessas.text),QProdDevolvido.fieldbyname('move_remessas').AsString)>0 then
           devolvido:=devolvido+QProdDevolvido.FieldByName('move_qtde').asfloat;
      end;
      QProdDevolvido.Next;

    end;
//  14.09.06 - Idete pegou q nao considerava as devoluocoes ainda nao gravadas digitadas durante o fechamento
    for p:=1 to Grid.rowcount do begin
      if  ( trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),p])=EdProduto.text ) then
           devolvido:=devolvido+texttovalor( Grid.Cells[Grid.getcolumn('move_qtde'),p] );

    end;
    if x>0 then
      mediapreco:=FGeral.arredonda(mediapreco/x,2)
    else
      mediapreco:=FEstoque.GetPreco(Produto,Global.codigounidade);

    if Qtde>0 then begin
      if ( Qtde>(Remessa-devolvido) ) and (remessa>0) then
        result:=1
      else if remessa=0 then
        result:=0
      else
        result:=2;
    end else
        result:=0;
  end;

begin
/////////////////////////////
  y:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid);
  qtgrid:=0;

  w:=TemnasRemessas(EdProduto.Text,EdQtde.AsCurrency+qtgrid);
  if w=0 then begin
     Avisoerro('Produto n�o encontrado nas remessas escolhidas');
     exit;
  end else if w=1 then begin
     Avisoerro('Quantidade a ser devolvida maior que a remessa ou j� devolvido tudo');
     exit;
  end;
// 11.11.04 - reges em beltrao
//  if EdQtde.Enabled then begin
//    if confirma('Confirma item ?') then begin
//      EditstoGrid;
//      EdValorvenda.setvalue(EdValorvenda.ascurrency-(EdQTde.ascurrency*mediapreco));
//    end;
//  end else begin
      EditstoGrid;
      EdValorvenda.setvalue(EdValorvenda.ascurrency-(EdQTde.ascurrency*mediapreco));
//      EdValorvenda.setvalue(EdValorVenda.ascurrency-valordesconto(EdValorVenda.ascurrency));
      EdValordev.setvalue(EdValordev.ascurrency+(EdQTde.ascurrency*mediapreco));
      EdQtdedev.setvalue(EdQtdedev.ascurrency+(EdQTde.ascurrency));
// 22.01.13
      AtualizaGridSaldo(EdProduto.text,'-',EdQTde.ascurrency);
//  end;
  EdProduto.ClearAll(FRetconsig,99);
  EdProduto.SetFocus;

end;

procedure TFRetconsig.EditstoGrid;
///////////////////////////////////
var x:integer;
    aqtde:currency;
begin
//  x:=FGeral.ProcuraGrid(0,EdProduto.Text,Grid);
  x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.GetColumn('codtamanho'),Edcodtamanho.asinteger,
                        Grid.getcolumn('codcor'),EdCodcor.asinteger,Grid.getcolumn('codcopa'),EdCodcopa.asinteger);
  if x<=0 then begin
// grid vazio
//    Result:=(Grid.RowCount=2) and (Trim(Grid.Cells[0,1])='');
    if (Grid.RowCount=2) and (Trim(Grid.Cells[0,1])='') then begin
       x:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       x:=Grid.RowCount-1;
    end;
{
    Grid.Cells[0,Abs(x)]:=EdProduto.Text;
    Grid.Cells[1,Abs(x)]:=Arq.TEstoque.fieldbyname('esto_descricao').asstring;
    Grid.Cells[2,Abs(x)]:=EdQTde.AsSql;
//    Grid.Cells[3,Abs(x)]:=FGeral.formatavalor(FEstoque.GetPreco(EdProduto.Text,EdUnid_codigo.Text),f_cr);
    Grid.Cells[3,Abs(x)]:=FGeral.formatavalor(mediapreco,f_cr);
    Grid.Cells[4,Abs(x)]:=FGeral.formatavalor(mediapreco*Edqtde.ascurrency,f_cr);
}
//
    Grid.Cells[Grid.getcolumn('move_esto_codigo'),Abs(x)]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;
    Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=EdQTde.AsSql;
    Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=FGeral.formatavalor(mediapreco,f_cr);
    Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=FGeral.formatavalor(mediapreco*Edqtde.ascurrency,f_cr);
// 23.08.06
    Grid.Cells[Grid.getcolumn('cor'),Abs(x)]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),Abs(x)]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
    Grid.Cells[Grid.getcolumn('copa'),Abs(x)]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),Abs(x)]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),Abs(x)]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('codcopa'),Abs(x)]:=EdCodcopa.text;

//
  end else begin
{
    Grid.Cells[0,x]:=EdProduto.Text;
    Grid.Cells[1,x]:=Arq.TEstoque.fieldbyname('esto_descricao').asstring;
    Grid.Cells[2,x]:=Transform(texttovalor(Grid.Cells[2,x])+EdQTde.Ascurrency,f_cr);
    Grid.Cells[4,x]:=FGeral.formatavalor(texttovalor(Grid.Cells[2,x])*texttovalor(Grid.Cells[3,x]),f_cr);
}
    Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=SetEdEsto_descricao.text;
    aqtde:=EdQTde.Ascurrency+texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x]);
    Grid.Cells[Grid.getcolumn('move_qtde'),x]:=Transform(EdQTde.Ascurrency+texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x]),f_cr);
    Grid.Cells[Grid.getcolumn('total'),x]:=TRansform(aQTde*texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),x]),f_cr);
    Grid.Cells[Grid.getcolumn('cor'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
    Grid.Cells[Grid.getcolumn('copa'),x]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),x]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),x]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('codcopa'),x]:=EdCodcopa.text;

  end;
  Grid.Refresh;
end;

procedure TFRetConsig.bCancelaritemClick(Sender: TObject);
begin
  if not Pins.Visible then exit;
  bGravar.Enabled:=true;
//  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
//  bSaldo.Enabled:=false;
  PINs.Visible:=false;
  PINs.DisableEdits;
  PRemessa.Enabled:=true;
//  EdCliente.SetFocus;
//  EdRemessas.setfocus;
// 03.05.05
  EdDtmovimento.setfocus;  

end;

procedure TFRetConsig.bExcluiritemClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var codigoestoque:string;
    qtde,venda:currency;
begin
////////////////////////  if PIns.Visible then exit;
// 14.09.06
  if trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row])='' then exit;
  if confirma('Confirma exclus�o ?') then begin
    codigoestoque:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
    qtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
    venda:=texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),Grid.row]);
    Grid.DeleteRow(Grid.Row);
    EdValorvenda.setvalue(EdValorvenda.ascurrency+(QTde*venda));
//    EdValorvenda.setvalue(EdValorVenda.ascurrency-valordesconto(EdValorVenda.ascurrency));
    EdValordev.setvalue(EdValordev.ascurrency-(QTde*venda));
    EdQtdedev.setvalue(EdQtdedev.ascurrency-(QTde));
// 22.01.13 - Doce Pimenta - Cris Hotz
    AtualizaGridSaldo(codigoestoque,'+',qtde);

//    Edtotalremessa.SetValue(Calculatotal);
(*
    if OP='A' then begin
      ExecuteSql('Update movestoque set move_status=''C'' where move_status=''N'''+
          ' and move_numerodoc='+EdNumerodoc.AsSql+
          ' and move_tipomov='+Stringtosql(Global.CodRemessaConsig)+
          ' and move_unid_codigo='+Stringtosql(Global.CodigoUnidade)+
          ' and move_tipo_codigo='+EdCliente.AsSql+
          ' and move_esto_codigo='+Stringtosql(codigoestoque)+
          ' and move_tipocad='+Stringtosql('C') );
      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,Global.CodigoUnidade,
             Global.CodRemessaConsig,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger);

    end;
    Sistema.Commit;
*)
  end;

end;

procedure TFRetConsig.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (EdNUmerodoc.AsInteger=0) and (EdCliente.AsInteger>0) and (Grid.RowCount>=3) then
    if confirma('Retorno n�o gravado.  Gravar agora ?') then
       bgravarclick(Self);
end;

procedure TFRetConsig.bGravarClick(Sender: TObject);
///////////////////////////////////////////////////////////
var op,transacao,TipoMovto,xremessas:string;
    numero,x:integer;
    valorretorno:currency;
    marcoutodas,EscolheuEcf:boolean;


    // 09.11.15
    function TotalParcela01:currency;
    //////////////////////////////////
    var p:integer;
        valor:currency;
    begin
      valor:=0;
      for p:=1 to Gridparcelas01.rowcount do begin
        if trim(Gridparcelas01.cells[1,p])<>'' then
          valor:=valor+texttovalor(Gridparcelas01.cells[1,p])
      end;
      result:=valor;
    end;

    // 09.11.15
    function TotalParcela02:currency;
    //////////////////////////////////
    var p:integer;
        valor:currency;
    begin
      valor:=0;
      for p:=1 to Gridparcelas02.rowcount do begin
        if trim(Gridparcelas02.cells[1,p])<>'' then
          valor:=valor+texttovalor(Gridparcelas02.cells[1,p])
      end;
      result:=valor;
    end;


    function TotalParcela:currency;
    //////////////////////////////////
    var p:integer;
        valor:currency;
    begin
      valor:=0;
      for p:=1 to Gridparcelas.rowcount do begin
        if trim(Gridparcelas.cells[1,p])<>'' then
          valor:=valor+texttovalor(Gridparcelas.cells[1,p])
      end;
      result:=valor;
    end;


    function ValordoRetorno:currency;
    //////////////////////////////////
    var p:integer;
        total:currency;
    begin
      total:=0;
      for p:=1 to Grid.RowCount do begin
        total:=total+( texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),p])*texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),p]) );
      end;
      result:=total;
    end;

    function DevolucaoMaiorRemessa:boolean;
    ////////////////////////////////////////////////
    var p:integer;
        Q:TSqlquery;
    begin
      result:=false;
      for p:=1 to GridCodigos.rowcount do begin
        if trim(Gridcodigos.cells[0,p])<>'' then begin
          if texttovalor( Gridcodigos.cells[Gridcodigos.getcolumn('move_qtde'),p] )<0 then begin
            Avisoerro('Produto '+Gridcodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),p]+' com saldo negativo');
//            result:=true;
          end;
          Q:=Sqltoquery('select esto_codigo from estoque where esto_codigo='+Stringtosql(Gridcodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),p]));
          if q.eof then begin
            Avisoerro('Produto '+Gridcodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),p]+' est� nas remessas mas n�o encontrado no estoque');
            result:=true;
          end;
          FGeral.FechaQuery(Q);
        end;
      end;
    end;


begin
//////////////////////////

  if (EdCliente.ASInteger=0) or (Grid.RowCount<=1) or ( trim(EdRemessas.text)='' ) then
    exit;

  op:='I';  // por enquanto
// 03.05.05
  if (pos('789464',EdRemessas.text)>0 ) or ((pos('.',EdRemessas.text)>0 )) or ((pos(',',EdRemessas.text)>0 ))
    or ( length(EdRemessas.text) >1000 )
    then begin
    if not confirma('Encontrado 789 ou . ou , nos numeros das remessas.   Confirma estas remessas ?') then
      exit;
  end;
// 07.06.11
  if copy(EdRemessas.text,1,1)='3' then begin
    Avisoerro('Verificar.  Encontrado o numero 3 no inicio do campo das remessas escolhidas.');
    exit;
  end;
// 31.03.14 - vivan
  if ( FGeral.GetConfig1AsInteger('ConfMovECFVC')=0 ) and (EdCupomfiscal.text='S') then begin
    Avisoerro('Ainda n�o configurado tipo de Configura��o para tipo de movimento '+Global.CodVendaConsig);
    exit;
  end;
// 31.08.15 - vivan
  if ( FGeral.GetConfig1AsInteger('ConfMovNFCeVC')=0 ) and (EdCupomfiscal.text='S') then begin
    Avisoerro('Ainda n�o configurado tipo de Configura��o para NFC-e para tipo '+Global.CodVendaConsig);
    exit;
  end;
  x:=0;
  for numero:=0 to cb.Items.count-1 do begin
    if cb.Checked[numero] then
      inc(x)
  end;
  if x=cb.items.count then
    marcoutodas:=true
  else
    marcoutodas:=false;


//  if Confirma('Deseja fazer a nota de venda do saldo da diferen�a ?') then begin
  if FazNfDiferenca then begin
//    if not EdPagto.valid then begin
    if (trim(Gridparcelas.cells[1,1])='') and (FCondpagto.GetAvPz(Edpagto.text)='P') then begin
//      edpagto.invalid('Obrigat�rio o preenchimento da condi��o de pagamento');
      edpagto.invalid('Obrigat�rio ter pelo menos uma parcela');
      exit;
    end;
    if Global.VCConfMov=0 then
      Global.VCConfMov:=FGeral.GetConfig1AsInteger('Confvenconsig');
    if Global.VCConfMov=0 then begin
      Avisoerro('Falta configurar o codigo de movimento para venda consignada');
      exit;
    end;
// 17.11.15
//////////////    totalnota:=EdValorVenda.ascurrency-EdValorDev.ascurrency;
// 13.10.16
//    if FCondpagto.GetAvPz(Edpagto.text)='P' then begin
// 23.03.16 - ajustado para prever desconto
       if totalnota <> (Totalparcela+TotalParcela01+TotalParcela02) then begin
         Avisoerro('Total da nota '+floattostr(totalnota)+' Total de Parcelas '+floattostr(totalparcela+totalparcela01-totalparcela02));
         exit;
       end;
//    end;
// 29.03.06
//    if  ( (EdValorvenda.ascurrency-totalparcela) > (0.07*EdValorvenda.ascurrency) ) and ( (EdPerdesco.ascurrency=0) or (EdVlrdesco.ascurrency=0) )
// 21.09.11 - nao entendi o '0.07' acima...
    if  ( (EdValorvenda.ascurrency-totalparcela-totalparcela01-totalparcela02) <> (EdVlrdesco.ascurrency+EdVlrAdiantamento.ascurrency) ) then begin
         Avisoerro('Total da nota de venda '+floattostr(EdValorvenda.ascurrency)+ ' difere do total de parcelas com o desconto/cr�dito '+floattostr(totalparcela+totalparcela01+totalparcela02) );
         exit;
    end;
    TipoMovto:=Global.CodVendaConsig;
// 03.05.06 -
    if DevolucaoMaiorRemessa then begin
      exit;
    end;
// 28.08.13 - tentativa de evitar dif. de valores na VC
// 15.01.14 - colocado pre�o medio de venda aqui...
//    if ((totalremessa-(totaldevolucoes+EdValordev.ascurrency))<>EdValorvenda.ascurrency) then
//      Aviso('Total (remessa-devolu��o) = '+FGeral.Formatavalor(totalremessa-(totaldevolucoes+Edvalordev.ascurrency),f_cr)+' difere '+
//            'do valor da venda '+FGeral.Formatavalor(Edvalorvenda.ascurrency,f_cr) );

  end else if confirma('� devolu��o de TROCA ?','N') then begin
    TipoMovto:=Global.CodDevolucaoTroca
  end else
    TipoMovto:=Global.CodDevolucaoConsig;

// 21.01.05 - reges na toke
  if (not FazNfDiferenca) and (TipoMovto=Global.CodVendaConsig)  then
    TipoMovto:=Global.CodDevolucaoConsig;
// 06.08.05
  xremessas:=EdRemessas.text;   // pra ver se para de gravar codigo de barra no moes_remessas
// 08.06.11
  EscolheuEcf:=false;
  if (FGeral.ConfiguradoECF) and (EdDtMovimento.AsDate>1) then
    EscolheuEcf:=EdCupomfiscal.text='S';
// 13.11.13 - vivan assim 'phode' o retorno so devolucao // 25.11.13 - Liane . senao nao deixa fechar
//             acerto que devolve tudo
  if (totalnf=0) and (FazNfDiferenca) and (EdValordev.ascurrency<EdValorvenda.ascurrency) then begin
      Avisoerro('Acerto sem valor total.   Checar condi��o de pagamento e parcelas');
      exit;
  end;

  if confirma('Confirma grava��o ?') then begin
// 12.11.13
    if OP='I' then begin
// 03.09.15 - pra nfc-e
      Sistema.edit('clientes');
        if EdComcpf.text='N' then
          Sistema.setfield('clie_encargoscob','N')
        else
          Sistema.setfield('clie_encargoscob','');
      Sistema.post('clie_codigo='+EdCliente.assql);
      Sistema.commit;
////////////////////////////////
      Sistema.BeginTransaction('Iniciando transa��o');
// este numero ser� o da devolucao caso existir no fechamento do acerto
      Numero:=FGeral.GetContador('RETCONSIG',false);
      EdNumerodoc.Text:=inttostr(Numero);
      Valorretorno:=Valordoretorno;
      Transacao:=FGeral.GetTransacao;
//      if totalnf=0 then  //  06.06.05 - nova variavel para o total da nf prevendo o desconto, subst, etc.etc
//        FGeral.GravaRetornoConsignacao(EdDtEmissao.asdate,EdCliente,CodRepre,EdUNid_codigo.Text,
//              TipoMovto,Transacao,Numero,ValorRetorno,Grid,QProdRemessa,QProdDevolvido,xRemessas,
//              EdPagto.text,EdDtMovimento.AsDate,EdPerdesco.ascurrency,EdVlrdesco.ascurrency,
//              GridParcelas,totalnota,marcoutodas,EdPort_codigo.text,EscolheuECf,EdValorVenda.ascurrency,EdVlrAdiantamento.ascurrency)
//      else
// 12.11.13 0 deixado somente esta gravacao ..estava ocorrendo total da nota menos q os produtos e Sem desconto
        FGeral.GravaRetornoConsignacao(EdDtEmissao.asdate,EdCliente,CodRepre,EdUNid_codigo.Text,
             TipoMovto,Transacao,Numero,ValorRetorno,Grid,QProdRemessa,QProdDevolvido,xRemessas,
             EdPagto.text,EdDtMovimento.AsDate,EdPerdesco.ascurrency,EdVlrdesco.ascurrency,
             GridParcelas,totalNF,marcoutodas,EdPort_codigo.text,EscolheuECf,EdValorVenda.ascurrency,EdVlrAdiantamento.ascurrency,
             GridParcelas01,EdPortador01.text,GridParcelas02,EdPortador02.text);

      Sistema.EndTransaction('Retorno Gravado');
//      if (TipoMovto=Global.CodDevolucaoTroca) or (Tipomovto=Global.CodDevolucaoConsig) then
//
      if (TipoMovto<>Global.CodDevolucaoTroca) and (Tipomovto<>Global.CodDevolucaoConsig) then
         tipomovto:=Global.CodDevolucaoConsig;  // 12.01.05 - sen�o n�o encontrado a devolucao na funcao de impressao

//      if trim(Grid.cells[grid.col,1])<>'' then
// 29.04.05
      if trim(Grid.cells[Grid.getcolumn('move_esto_codigo'),1])<>'' then
        FGeral.IMpdevolucao(Numero,tipomovto,'S');

// 26.08.10
//        FGeral.IMpdevolucao(Numero,tipomovto,'N');

    end else if OP='A' then begin
//      FGeral.GravaRetornoConsignacao(Sistema.Hoje,EdCliente,ValorRetorno,Global.CodigoUnidade,
//             Global.CodDevolucaoConsig,Transacao,Numero,0);
      Sistema.Commit;
    end;

// ver se libera por usuario ou algo no registro do micro para habilitar
//    if EscolheuECF then
//        FEcfGeral.ImprimeCupomFiscal(Global.UltimaTransacao,Global.CodVendaConsig);

    EdCliente.Clearall(FRetConsig,99);
    EdPagto.Clearall(FRetConsig,99);
    EdPagto01.Clearall(FRetConsig,99);
    EdDtemissao.setdate(Sistema.hoje);
    EdDtmovimento.setdate(sistema.hoje);
    Cb.Items.Clear;
    Grid.Clear;
    GridParcelas.Clear;
    GridParcelas01.Clear;
    if OP='I' then
      EdCliente.Setfocus
    else
      EdNumerodoc.SetFocus;
  end;
end;

procedure TFRetConsig.cbClickCheck(Sender: TObject);
var s:string;
    num:integer;
begin
   s:='';
   RemessaCG:='';  // 17.06.13
   for num:=0 to cb.count-1 do begin
     if cb.Checked[num] then begin
       s:=s+copy(cb.Items[num],1,8)+';';
       if copy(cb.Items[num],19,1)='G' then
         RemessaCG:=copy(cb.Items[num],19,1);
     end;
   end;
   EdRemessas.Text:=s;
end;

procedure TFRetConsig.bConfirmaClick(Sender: TObject);
begin
  EdRemessas.Valid;
//  EdRemessas.ValidateEdit;
   EdRemessas.enabled:=false;
  Grid.Clear;
end;

procedure TFRetConsig.EdPagtoValidate(Sender: TObject);
//////////////////////////////////////////////////////////
var nparcelas,n:integer;
    ListaPrazo:TStringlist;
    p:integer;
    valorparcela,valortotal,valoravista,acumulado:currency;
    aliicms,baseicms,vlricms,basesubs:currency;
    produto:string;

begin
////////////
  if (FCondPagto.GetAvPz(EdPagto.text)='V') or (Fcondpagto.Getprimeiroprazo(EdPagto.text)=0) then begin
    if EdUnid_codigo.Resultfind.fieldbyname('Unid_contacontabil').AsInteger=0 then begin
      EdPagto.INvalid('Unidade sem conta caixa cadastrada para lan�amentos a vista');
      exit;
    end;
  end;
//  if (Edpagto.text<>EdPagto.OldValue) then
//    GridParcelas.Clear;
// 28.03.06 - retirado
  totalnota:=0;  // 23.05.06 - se fazia uma venda e em seguida devolu��o total ficava o valor na variavel
                 // dando mensagem de valor difere das parcelas
  if EdValorvenda.ascurrency>0 then begin
//////////////////////////// - 11.03.05                                   // 24.10.12
     vlrnf:=EdValorvenda.ascurrency-valordesconto(EdValorvenda.ascurrency)-EdVlrAdiantamento.ascurrency-Valorgrid01-Valorgrid02;
// 06.10.16 -
//     vlrnf:=EdValorvenda.ascurrency-valordesconto(EdValorvenda.ascurrency)-EdVlrAdiantamento.ascurrency-Valorgrid01-Valorgrid02-EdValorDev.ascurrency;
     if ( pos( Global.UFUnidade,Global.UfComSubstituicao ) > 0 )   and (EdDtmovimento.asdate>0) and (TemSubsproduto) then begin
       produto:=Gridcodigos.cells[0,1];
       if trim( produto )<>'' then
         aliicms:=FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,EdCliente.resultfind.fieldbyname('clie_uf').asstring )
       else
         aliicms:=17;
       baseicms:=vlrnf;
       vlricms:=baseicms*(aliicms/100);                                    // 25.08.05
       if (EdCliente.resultfind.fieldbyname('clie_tipo').asstring='F') and ( pos(EdCliente.resultfind.fieldbyname('clie_uf').asstring,'SC;RS')>0 )
         then begin  // 15.07.05
         basesubs:=vlrnf+( (vlrnf)*(Global.MargemSubsTrib/100) );
         icmssubs:=basesubs*(aliicms/100);
         icmssubs:=icmssubs-vlricms;
       end else begin
         basesubs:=0;
         icmssubs:=0;
       end;
     end else
       icmssubs:=0;
/////////////////////////////
    ListaPrazo:=TStringlist.create;
    n:=FCondPagto.GetPrazos(EdPagto.text,ListaPrazo);
// 14.03.05
//    totalnota:=roundvalor( vlrnf+icmssubs-(valordesconto(EdValorvenda.ascurrency)) );
// 30.03.05 - vlrnf ja tem o desconto
    totalnota:=roundvalor( vlrnf+icmssubs );
    totalNf:=totalnota;
    valortotal:=totalnota;  // 28.08.13
    if FCondPagto.GetAvPz(EdPagto.text)='V' then
      valoravista:=totalnota
    else begin
      if (Fcondpagto.GetPrimeiroPrazo(EdPagto.text)=0) and (Fcondpagto.GetNumeroParcelas(EdPagto.text)>1) then
         valoravista:=FGeral.GetValorAvista(Listaprazo,icmssubs)
      else
         valoravista:=0;
      valortotal:=totalnota - valoravista;
    end;
    nparcelas:=FCondPagto.GetNumeroParcelas(EdPagto.text);
// 11.03.05 - reges pegou bug quando tem parte a vista e mais de duas parcelas
    acumulado:=0;
    for p:=1 to nparcelas do begin
      GridParcelas.cells[GridParcelas.getcolumn('pend_datavcto'),p]:=formatdatetime('dd/mm/yyyy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  );
      if (p=nparcelas) and (valoravista=0) then
        valorparcela:=valortotal-acumulado  // para deixar na ultima parcelas "as d�zimas"
      else begin
        if (valoravista>0) and (nparcelas>1) then begin   // 14.03.05
          valorparcela:=FGeral.Arredonda(valortotal/(nparcelas-1),2);
          if (p=nparcelas) then
            valorparcela:=valortotal+valoravista-acumulado  // para deixar na ultima parcelas "as d�zimas" - 02.06.05
        end else
          valorparcela:=FGeral.Arredonda((valortotal)/nparcelas,2);
      end;
      if (valoravista>0) and (p=1) then begin
        GridParcelas.cells[GridParcelas.getcolumn('pend_valor'),p]:=Transform(valoravista,f_cr);
        acumulado:=acumulado+valoravista;
      end else begin
        GridParcelas.cells[GridParcelas.getcolumn('pend_valor'),p]:=Transform(valorparcela,f_cr);
        acumulado:=acumulado+valorparcela;
      end;
// 24.05.12 - Vivan
      GridParcelas.cells[GridParcelas.getcolumn('pend_port_codigo'),p]:=EdPort_codigo.text;
      GridParcelas.RowCount:=GridParcelas.RowCount+1;
    end;  // for do numero de parcelas
    Freeandnil(ListaPrazo);
    Gridparcelas.setfocus;
  end;

////   bgravarclick(FRetConsig);

end;

procedure TFRetConsig.EdPagtoKeyPress(Sender: TObject; var Key: Char);
begin
  FGeral.LImpaEdit(EdPagto,key);
end;

procedure TFRetConsig.bSaldoClick(Sender: TObject);
var linha,x:integer;
    saldo:currency;
begin
//  if trim(EdProduto.text)='' then exit;
//  if trim(Gridcodigos.cells[0,grid.row])='' then exit;
//  EdProduto.text:=produtoescolhido;
  pbotoes.enabled:=false;
  pins.enabled:=false;
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
  PSaldo.visible:=true;
//  Psaldo.setfocus;
  Pcodigos.visible:=true;
  PCodigos.bringtofront;
  GridSaldo.clear;
  GridCodigos.setfocus;
end;

// 02.04.18
procedure TFRetConsig.bsimluacaoClick(Sender: TObject);
////////////////////////////////////////////////////////
var p:integer;
    totalitem:currency;

begin

  if GridCodigos.RowCount<=1 then begin
     Avisoerro('Confirmar as remessas e devolu��es primeiro');
     exit;
  end;

  FRel.Init('RelSimulacao');
  FRel.AddTit('Simula��o de Fechamento do Consignado');
  FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
  FRel.AddTit('Cliente  : '+EdCliente.Text+' - '+EdCliente.ResultFind.FieldByName('clie_nome').AsString );
  FRel.AddCol( 060,3,'N',''  ,''              ,'Codigo'         ,''         ,'',false);
  FRel.AddCol( 250,0,'C',''  ,''              ,'Descri��o'       ,''         ,'',false);
// 03.09.18
//  FRel.AddCol( 060,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
//  FRel.AddCol( 090,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
  FRel.AddCol(  60,1,'N','' ,''              ,'Unit�rio'  ,''         ,'',false);
  FRel.AddCol(  60,3,'N','+' ,''              ,'Saldo'  ,''         ,'',false);
  FRel.AddCol(  60,3,'N','+' ,''              ,'Valor'  ,''         ,'',false);

  for p:=1 to GridCodigos.RowCount-1 do begin

     FRel.AddCel( GridCodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),p] );
     FRel.AddCel( FEstoque.GetDescricao( GridCodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),p] ) );
     FRel.AddCel( GridCodigos.cells[Gridcodigos.getcolumn('move_venda'),p] );
     FRel.AddCel( GridCodigos.cells[Gridcodigos.getcolumn('move_qtde'),p] );
     totalitem := Texttovalor( GridCodigos.cells[Gridcodigos.getcolumn('move_venda'),p] ) *
                  TexttoValor(GridCodigos.cells[Gridcodigos.getcolumn('move_qtde'),p]);
     FRel.AddCel( floattostr(totalitem ) );

  end;

  FRel.video;

end;

procedure TFRetConsig.bfecharClick(Sender: TObject);
begin
  bGravar.Enabled:=true;
  bSair.Enabled:=true;
  PSaldo.visible:=false;
  Pcodigos.visible:=false;
//  bSaldo.enabled:=false;
  pbotoes.enabled:=true;
  pins.enabled:=true;
  EdProduto.setfocus;
end;

procedure TFRetConsig.EdDtMovimentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FGeral.PoeData(EdDtmovimento,key);

end;


procedure TFRetConsig.GridCodigosClick(Sender: TObject);
var linha,x:integer;
    saldo:currency;

    procedure MontaGrid(Grid:TSqldtgrid ; Q:TMemoryquery );
    var x:integer;

         function ProcuraGrid(coluna1,coluna2:integer ; busca1,busca2:string ):integer;
         var p:integer;
         begin
           result:=0;
           for p:=1 to Grid.rowcount do  begin
               if (coluna1>0) and (coluna2>0) then begin
                 if (Grid.cells[coluna1,p]=busca1) and  (Grid.cells[coluna2,p]=busca2) then begin
                   result:=p;
                   break;
                 end;
               end else begin
                 if (Grid.cells[coluna1,p]=busca1)  then begin
                   result:=p;
                   break;
                 end;
               end;
           end;
         end;

    begin

      x:=ProcuraGrid( Grid.GetColumn('move_numerodoc'),Grid.getcolumn('move_tipomov'),Q.fieldbyname('move_numerodoc').Asstring,Q.fieldbyname('move_tipomov').Asstring );
      if x=0 then begin
        Grid.Cells[Grid.getcolumn('move_numerodoc'),linha]:=Q.fieldbyname('move_numerodoc').Asstring;
        Grid.Cells[Grid.getcolumn('move_datamvto'),linha]:=Q.fieldbyname('move_datamvto').Asstring;
        Grid.Cells[Grid.getcolumn('move_tipomov'),linha]:=Q.fieldbyname('move_tipomov').Asstring;
        Grid.Cells[Grid.getcolumn('move_qtde'),linha]:=Q.fieldbyname('move_qtde').Asstring;
        if pos(Q.fieldbyname('move_tipomov').Asstring,Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca)=0  then
          saldo:=saldo+Q.fieldbyname('move_qtde').Asfloat
        else
          saldo:=saldo-Q.fieldbyname('move_qtde').Asfloat;
        Grid.Cells[Grid.getcolumn('saldo'),linha]:=FGeral.formatavalor(saldo,'####0');
        inc(linha);
        Grid.RowCount:=linha+1;
      end else begin
        Grid.Cells[Grid.getcolumn('move_qtde'),x]:=floattostr( texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x])+Q.fieldbyname('move_qtde').Asfloat );
        if pos(Q.fieldbyname('move_tipomov').Asstring,Global.CodDevolucaoConsig+';'+Global.CodDevolucaoTroca)=0  then
          saldo:=saldo+Q.fieldbyname('move_qtde').Asfloat
        else
          saldo:=saldo-Q.fieldbyname('move_qtde').Asfloat;
        Grid.Cells[Grid.getcolumn('saldo'),x]:=FGeral.formatavalor(saldo,'####0');
      end;
    end;

begin

  if trim(Gridcodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),gridcodigos.row])='' then exit;
  produtoescolhido:=Gridcodigos.cells[Gridcodigos.getcolumn('move_esto_codigo'),gridcodigos.row];
  EdProduto.text:=produtoescolhido;
  GridSaldo.clear;linha:=1;saldo:=0;
  GridSaldo.RowCount:=2;
  QProdremessa.first;
  while not QProdremessa.eof do begin
    if EdProduto.text=QProdremessa.fieldbyname('move_esto_codigo').asstring then begin
 // 18.08.05
      if FGeral.EstaemAberto(QProdremessa.fieldbyname('move_numerodoc').AsString,EdRemessas.text) then begin
// 25.08.06
        MontaGrid( GridSaldo,QProdremessa );
      end;
    end;
    QProdremessa.Next;
  end;
  QProddevolvido.first;
  while not QProdDevolvido.eof do begin
    if EdProduto.text=QProddevolvido.fieldbyname('move_esto_codigo').asstring then begin
//      if (ansipos(QProdDevolvido.fieldbyname('move_remessas').AsString,trim(EdRemessas.text))>0) and
      if FGeral.EstaemAberto(QProdDevolvido.fieldbyname('move_remessas').AsString,EdRemessas.text) and
         (QProdDevolvido.fieldbyname('move_remessas').AsString<>'')
        then begin
// 04.09.06
        MontaGrid( GridSaldo,QProdDevolvido );
{
        GridSaldo.Cells[Gridsaldo.getcolumn('move_numerodoc'),linha]:=QProdDevolvido.fieldbyname('move_numerodoc').Asstring;
        GridSaldo.Cells[Gridsaldo.getcolumn('move_datamvto'),linha]:=QProddevolvido.fieldbyname('move_datamvto').Asstring;
        GridSaldo.Cells[Gridsaldo.getcolumn('move_tipomov'),linha]:=QProddevolvido.fieldbyname('move_tipomov').Asstring;
        GridSaldo.Cells[Gridsaldo.getcolumn('move_qtde'),linha]:=QProddevolvido.fieldbyname('move_qtde').Asstring;
        saldo:=saldo-QProddevolvido.fieldbyname('move_qtde').Asfloat;
        GridSaldo.Cells[Gridsaldo.getcolumn('saldo'),linha]:=FGeral.formatavalor(saldo,'####0');
        inc(linha);
        GridSaldo.RowCount:=linha+1;
}
      end;
    end;
    QProdDevolvido.Next;
  end;
  for x:=1 to Grid.rowcount do begin
    if EdProduto.text=Grid.cells[Grid.Getcolumn('move_esto_codigo'),x] then begin
        GridSaldo.Cells[Gridsaldo.getcolumn('move_numerodoc'),linha]:='';
        GridSaldo.Cells[Gridsaldo.getcolumn('move_datamvto'),linha]:=formatdatetime('dd/mm/yy',EddtEmissao.asdate);
        GridSaldo.Cells[Gridsaldo.getcolumn('move_tipomov'),linha]:=Global.CodDevolucaoConsig;
        GridSaldo.Cells[Gridsaldo.getcolumn('move_qtde'),linha]:=Grid.cells[Grid.Getcolumn('move_qtde'),x];
        saldo:=saldo-texttovalor( Grid.cells[Grid.Getcolumn('move_qtde'),x] );
        GridSaldo.Cells[Gridsaldo.getcolumn('saldo'),linha]:=FGeral.formatavalor(saldo,'####0');
        inc(linha);
        GridSaldo.RowCount:=linha+1;
    end;
  end;
//  bsaldoclick(FRetConsig);
end;

procedure TFRetConsig.EdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then begin
    bcancelaritemclick(FRetConsig);
//    EdPagto.Valid;
//    EdPagto.setfocus;
    if Confirma('Deseja fazer a nota de venda do saldo da diferen�a ?') then begin
      EdPerdesco.setfocus;
      FazNfDiferenca:=true;
    end else begin
      bgravarclick(FRetconsig);
      FazNfDiferenca:=false;
    end;
  end;

end;

procedure TFRetConsig.EdperdescoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////
begin
  if EdPerdesco.ascurrency>0 then begin
    EdVlrDesco.setvalue( EdValorvenda.ascurrency*(EdPerdesco.ascurrency/100) );
    EdVlrdesco.enabled:=false;
  end else begin
    EdVlrDesco.setvalue(0);
    EdVlrdesco.enabled:=true;
    if not EdPagto.isempty then EDPagto.valid;
  end;
  if (length(trim(EdCliente.resultfind.fieldbyname('clie_portadores').asstring)) > 5) and (Global.usuario.outrosacessos[0058]) then begin
    PPortador01.enabled:=true;
    PPortador01.visible:=true;
    if (length(trim(EdCliente.resultfind.fieldbyname('clie_portadores').asstring)) > 8) and (Global.usuario.outrosacessos[0058]) then begin
      PPortador02.enabled:=true;
      PPortador02.visible:=true;
    end;
  end;
end;

procedure TFRetConsig.AtivaEditsParcelas;
///////////////////////////////////////////
begin
  if GridParcelas.Col=0 then begin
     EdVencimento.Top:=GridParcelas.TopEdit+2;
     EdVencimento.Left:=GridParcelas.LeftEdit+4;
     EdVencimento.Text:=StrToStrNumeros(GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]);
//     EdVencimento.Text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
     EdVencimento.Visible:=True;
     EdVencimento.SetFocus;
  end else if GridParcelas.Col=1 then begin
     EdParcela.Top:=GridParcelas.TopEdit+2;
     EdParcela.Left:=GridParcelas.LeftEdit+4;
     EdParcela.SetValue(TextToValor(GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]));
     EdParcela.Visible:=True;
     EdParcela.SetFocus;
  end else if GridParcelas.Col=2 then begin
     EdPend_Port_codigo.Top:=GridParcelas.TopEdit;
     EdPend_Port_codigo.Left:=GridParcelas.LeftEdit+02;
     EdPend_Port_codigo.text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
     EdPend_Port_codigo.Visible:=True;
     EdPend_Port_codigo.SetFocus;
  end;

end;

procedure TFRetConsig.GridParcelasDblClick(Sender: TObject);
begin
  AtivaEditsParcelas;

end;

procedure TFRetConsig.GridParcelasKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    GridParcelasDblClick(FRetConsig);

end;

procedure TFRetConsig.EdParcelaExitEdit(Sender: TObject);
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=Transform(EdParcela.AsFloat,f_cr);
  GridParcelas.SetFocus;
  EdParcela.Visible:=False;
  if PPortador01.enabled then EdPagto01.valid;
  if PPortador02.enabled then EdPagto02.valid;

end;

procedure TFRetConsig.EdVencimentoExitEdit(Sender: TObject);
begin

//  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=DateToStr_(EdVencimento.AsDate);
// 30.11.20
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=FGeral.formatadata(EdVencimento.AsDate,true);
  GridParcelas.SetFocus;
  EdVencimento.Visible:=False;

end;

function TFRetConsig.ValorDesconto(valor:currency):currency;
begin
    if EdPerDesco.ascurrency>0 then begin
      EdVlrdesco.setvalue(valor*(EdPerDesco.ascurrency/100));
      result:=valor*(EdPerDesco.ascurrency/100)
    end else if EdVlrdesco.ascurrency>0 then
      result:=EdVlrdesco.ascurrency
    else
      result:=0;

end;

procedure TFRetConsig.EdVlrdescoValidate(Sender: TObject);
begin
   if (EdVlrdesco.ascurrency>0) and (EdPerdesco.ascurrency=0)  and (EdVlrdesco.ascurrency<=EdValorvenda.ascurrency) then begin
     EdPerdesco.setvalue(  (EdVlrdesco.ascurrency/EdValorvenda.ascurrency)*100 );
   end;
   if not EdPagto.isempty then EDPagto.valid;
end;

procedure TFRetConsig.EdPagtoExitEdit(Sender: TObject);
begin
  if (EdPagto01.Items.count=1) or ( not Global.Usuario.outrosacessos[0058] ) then
     bgravarclick(FRetConsig)
  else
     EdPortador01.setfocus;

end;

procedure TFRetConsig.EdRemessasExitEdit(Sender: TObject);
begin
   EdRemessas.enabled:=false;
end;

procedure TFRetConsig.MostraRepr(codigo: integer);
begin
  EdNomerepr.text:=inttostr(codigo)+'-'+FRepresentantes.GetDescricao(codigo);
  EdNomerepr.Update;
end;

procedure TFRetConsig.cbDblClick(Sender: TObject);
var s,marca:string;
    num:integer;
begin
   if confirma('S - Marca todas   N - Desmarca todas') then
     marca:='S'
   else
     marca:='N';
   for num:=0 to cb.count-1 do begin
     if marca='S' then
        cb.Checked[num]:=true
     else
        cb.Checked[num]:=false;
   end;

   s:='';
   for num:=0 to cb.count-1 do begin
     if cb.Checked[num] then
       s:=s+copy(cb.Items[num],1,8)+';';
   end;
   EdRemessas.Text:=s;
end;

procedure TFRetConsig.GridSaldoDblClick(Sender: TObject);
begin
//  if GridSaldo.cells[gridSaldo.getcolumn('move_tipomov'),gridSaldo.row]=Global.CodRemessaconsig then
//     Remessa_Execute('X','',strtointdef(GridSaldo.cells[gridSaldo.getcolumn('move_numerodoc'),gridSaldo.row] ,0) )
end;

procedure TFRetConsig.EdProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if key=18 then
//    Aviso('Enter pra retornar ao programa');

end;

procedure TFRetConsig.EdCodtamanhoValidate(Sender: TObject);
var x:integer;
begin
   if not FGeral.ValidaGrade(EdCodcor.asinteger,EdCodtamanho.asinteger,0,EdProduto.text,'cor;tamanho') then
     EdCodtamanho.invalid('')

end;

procedure TFRetConsig.EdCodcopaValidate(Sender: TObject);
begin
   if not FGeral.ValidaGrade(EdCodcor.asinteger,EdCodtamanho.asinteger,EdCodcopa.asinteger,EdProduto.text,'cor;tamanho;copa') then
     EdCodcopa.invalid('')

end;

procedure TFRetConsig.bgeranfeClick(Sender: TObject);
begin
  if ( FGeral.GetConfig1AsInteger('ConfMovNFCE')>0 ) then
    FExpNfetxt.Execute(0,'NFCe')
  else
    FExpNfetxt.Execute;

end;

procedure TFRetConsig.EdPend_Port_codigoExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
  GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row]:=EdPend_port_codigo.Text;
  GridParcelas.SetFocus;
  EdPend_Port_codigo.Visible:=False;

end;

procedure TFRetConsig.GridCodigosKeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then  bfecharClick(Self);

end;

procedure TFRetConsig.EdPend_Port_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
    FGeral.Limpaedit(EdPend_Port_codigo,key);
end;

function TFRetConsig.GetSaldoAntecipacao(xtipocad: string;  xcodigo: integer): currency;
////////////////////////////////////////////////////////////////////////////////////////////
var saldo:currency;
    QA:TSqlquery;
begin
      QA:=sqltoquery('select pend_rp,sum(pend_valor) as vlrantecipa from pendencias where pend_status='+stringtosql('A')+
                      ' and pend_tipo_codigo='+inttostr(xcodigo)+
                      ' and pend_tipocad='+Stringtosql(xtipocad)+
                      ' and '+FGeral.GetIN('pend_unid_codigo',EdUnid_codigo.text,'C')+
                      ' group by pend_rp' );
      saldo:=0;
      while not QA.eof do begin
        if QA.fieldbyname('pend_rp').asstring='R' then
          saldo:=saldo+QA.fieldbyname('vlrantecipa').ascurrency
        else
          saldo:=saldo-QA.fieldbyname('vlrantecipa').ascurrency;
        QA.Next;
      end;
      FGeral.FechaQuery(QA);
      result:=saldo

end;

procedure TFRetConsig.EdVlrAdiantamentoValidate(Sender: TObject);
/////////////////////////////
begin
  IF Edvlradiantamento.ascurrency>ValorMaximoAdiantamento then
    Edvlradiantamento.Invalid('M�ximo permitido '+FGeral.Formatavalor(ValorMaximoAdiantamento,f_cr));
end;

// 22.01.13 - Doce Pimenta - Cris Hotz
procedure TFRetConsig.AtualizaGridSaldo(xcodigo,xop:string;xqtde:currency);
///////////////////////////////////////////////////////////////////////////////
var x:integer;
    aqtde:currency;
begin
//  x:=FGeral.ProcuraGrid(0,EdProduto.Text,Grid);
  x:=FGeral.ProcuraGrid(GridCodigos.getcolumn('move_esto_codigo'),xcodigo,GridCodigos,0,0,
                        0,0,0,0);
  if x>0 then begin
    aqtde:=texttovalor(GridCodigos.Cells[GridCodigos.getcolumn('move_qtde'),x]);
    if xop='-' then
      GridCodigos.Cells[GridCodigos.getcolumn('move_qtde'),x]:=Transform(aQTde-xQtde,f_cr)
    else
      GridCodigos.Cells[GridCodigos.getcolumn('move_qtde'),x]:=Transform(aQTde+xQtde,f_cr);
  end;
//  GridCodigos.Refresh;

end;

procedure TFRetConsig.EdPort_codigoValidate(Sender: TObject);
////////////////////////////////////////////////////////////////////
var num:integer;
begin
// 17.06.13
  RemessaCG:='';  // 17.06.13
  for num:=0 to cb.count-1 do begin
     if cb.Checked[num] then begin
       if copy(cb.Items[num],19,1)='G' then
         RemessaCG:=copy(cb.Items[num],19,1);
     end;
  end;

  if (RemessaCG='G') and (EdPort_codigo.ResultFind<>nil) then begin
    if ( pos( EdPort_codigo.text,FGeral.GetConfig1AsString('Portadorcartao') ) = 0 ) and
       ( pos( 'CHEQUE' ,uppercase(EdPort_codigo.ResultFind.fieldbyname('port_descricao').asstring) ) = 0 )
      then
      EdPort_codigo.invalid('Permitido somente portador cart�o ou cheque');
  end;


end;

procedure TFRetConsig.EdDtMovimentoExit(Sender: TObject);
begin
  if EdDtmovimento.isempty then begin
    Edcomcpf.enabled:=false;
    Edcomcpf.text:='N';
    EdRemessas.setfocus;
  end else begin
    Edcomcpf.enabled:=true;
    Edcomcpf.text:='N';
  end;

end;

// 08.11.15
procedure TFRetConsig.Edportador01Validate(Sender: TObject);
//////////////////////////////////////////////////////////////
begin
  if (RemessaCG='G') and (EdPortador01.ResultFind<>nil) then begin
    if ( pos( EdPortador01.text,FGeral.GetConfig1AsString('Portadorcartao') ) = 0 ) and
       ( pos( 'CHEQUE' ,uppercase(EdPortador01.ResultFind.fieldbyname('port_descricao').asstring) ) = 0 )
      then
      EdPortador01.invalid('Permitido somente portador cart�o ou cheque');
  end else if EdPortador01.text=EdPort_codigo.text then
    EdPortador01.invalid('Portador j� utilizado');

end;

procedure TFRetConsig.Edpagto01KeyPress(Sender: TObject; var Key: Char);
begin
  FGeral.LImpaEdit(EdPagto01,key);

end;

// 08.11.15
procedure TFRetConsig.Edpagto01Validate(Sender: TObject);
///////////////////////////////////////////////////////////////
var nparcelas,n:integer;
    ListaPrazo:TStringlist;
    p:integer;
    valorparcela,valortotal,valoravista,acumulado:currency;
    aliicms,baseicms,vlricms,basesubs,vlrnf01:currency;
    produto:string;

begin
////////////
  if (FCondPagto.GetAvPz(EdPagto01.text)='V') or (Fcondpagto.Getprimeiroprazo(EdPagto01.text)=0) then begin
    if EdUnid_codigo.Resultfind.fieldbyname('Unid_contacontabil').AsInteger=0 then begin
      EdPagto01.INvalid('Unidade sem conta caixa cadastrada para lan�amentos a vista');
      exit;
    end;
  end;
  if EdValorvenda.ascurrency>0 then begin
//////////////////////////// - 11.03.05                                   // 24.10.12
     vlrnf01:=EdValorvenda.ascurrency-valordesconto(EdValorvenda.ascurrency)-EdVlrAdiantamento.ascurrency-ValorGrid-Valorgrid02;
     if ( pos( Global.UFUnidade,Global.UfComSubstituicao ) > 0 )   and (EdDtmovimento.asdate>0) and (TemSubsproduto) then begin
       produto:=Gridcodigos.cells[0,1];
       if trim( produto )<>'' then
         aliicms:=FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,EdCliente.resultfind.fieldbyname('clie_uf').asstring )
       else
         aliicms:=17;
       baseicms:=vlrnf01;
       vlricms:=baseicms*(aliicms/100);                                    // 25.08.05
       if (EdCliente.resultfind.fieldbyname('clie_tipo').asstring='F') and ( pos(EdCliente.resultfind.fieldbyname('clie_uf').asstring,'SC;RS')>0 )
         then begin  // 15.07.05
         basesubs:=vlrnf01+( (vlrnf01)*(Global.MargemSubsTrib/100) );
         icmssubs:=basesubs*(aliicms/100);
         icmssubs:=icmssubs-vlricms;
       end else begin
         basesubs:=0;
         icmssubs:=0;
       end;
     end else
       icmssubs:=0;
/////////////////////////////
    ListaPrazo:=TStringlist.create;
    n:=FCondPagto.GetPrazos(EdPagto01.text,ListaPrazo);
//    totalnota:=roundvalor( vlrnf01+icmssubs );
//    totalNf:=totalnota;
    valortotal:=vlrnf01;
    if FCondPagto.GetAvPz(EdPagto01.text)='V' then
      valoravista:=totalnota
    else begin
      if (Fcondpagto.GetPrimeiroPrazo(EdPagto01.text)=0) and (Fcondpagto.GetNumeroParcelas(EdPagto01.text)>1) then
         valoravista:=FGeral.GetValorAvista(Listaprazo,icmssubs)
      else
         valoravista:=0;
      valortotal:=vlrnf01 - valoravista;
    end;
    nparcelas:=FCondPagto.GetNumeroParcelas(EdPagto01.text);
    acumulado:=0;
    for p:=1 to nparcelas do begin
      GridParcelas01.cells[GridParcelas01.getcolumn('pend_datavcto'),p]:=formatdatetime('dd/mm/yyyy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  );
      if (p=nparcelas) and (valoravista=0) then
        valorparcela:=valortotal-acumulado  // para deixar na ultima parcelas "as d�zimas"
      else begin
        if (valoravista>0) and (nparcelas>1) then begin   // 14.03.05
          valorparcela:=FGeral.Arredonda(valortotal/(nparcelas-1),2);
          if (p=nparcelas) then
            valorparcela:=valortotal+valoravista-acumulado  // para deixar na ultima parcelas "as d�zimas" - 02.06.05
        end else
          valorparcela:=FGeral.Arredonda((valortotal)/nparcelas,2);
      end;
      if (valoravista>0) and (p=1) then begin
        GridParcelas01.cells[GridParcelas01.getcolumn('pend_valor'),p]:=Transform(valoravista,f_cr);
        acumulado:=acumulado+valoravista;
      end else begin
        GridParcelas01.cells[GridParcelas01.getcolumn('pend_valor'),p]:=Transform(valorparcela,f_cr);
        acumulado:=acumulado+valorparcela;
      end;
//      GridParcelas01.cells[GridParcelas.getcolumn('pend_port_codigo'),p]:=EdPortador01.text;
      GridParcelas01.RowCount:=GridParcelas01.RowCount+1;
    end;  // for do numero de parcelas
    Freeandnil(ListaPrazo);
    Gridparcelas01.setfocus;
  end;

end;

// 08.11.15
procedure TFRetConsig.AtivaEditsParcelas01;
///////////////////////////////////////////
begin
  if GridParcelas01.Col=0 then begin
     EdVencimento01.Top:=GridParcelas01.TopEdit+48;
     EdVencimento01.Left:=GridParcelas01.LeftEdit;
     EdVencimento01.Text:=StrToStrNumeros(GridParcelas01.Cells[GridParcelas01.Col,GridParcelas01.Row]);
//     EdVencimento.Text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
     EdVencimento01.Visible:=True;
     EdVencimento01.SetFocus;
  end else if GridParcelas01.Col=1 then begin
     EdParcela01.Top:=GridParcelas01.TopEdit+48;
     EdParcela01.Left:=GridParcelas01.LeftEdit;
     EdParcela01.SetValue(TextToValor(GridParcelas01.Cells[GridParcelas01.Col,GridParcelas01.Row]));
     EdParcela01.Visible:=True;
     EdParcela01.SetFocus;
//  end else if GridParcelas01.Col=2 then begin
//     EdPend_Port_codigo.Top:=GridParcelas.TopEdit;
//     EdPend_Port_codigo.Left:=GridParcelas.LeftEdit+02;
//     EdPend_Port_codigo.text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
//     EdPend_Port_codigo.Visible:=True;
//     EdPend_Port_codigo.SetFocus;
  end;


end;

procedure TFRetConsig.GridParcelas01DblClick(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
  AtivaEditsParcelas01;

end;


function TFRetConsig.ValorGrid:currency;
/////////////////////////////////////////////
var x:integer;
begin
  result:=0;
  for x:=1 to Gridparcelas.rowcount do result:=result+Texttovalor(Gridparcelas.cells[Gridparcelas.getcolumn('pend_valor'),x])
end;

procedure TFRetConsig.GridParcelas01KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    GridParcelas01DblClick(FRetConsig);

end;

procedure TFRetConsig.EdParcela01ExitEdit(Sender: TObject);
////////////////////////////////////////////////////////////////////
begin
  GridParcelas01.Cells[GridParcelas01.Col,GridParcelas01.Row]:=Transform(EdParcela01.AsFloat,f_cr);
  GridParcelas01.SetFocus;
  EdParcela01.Visible:=False;
  if PPortador02.enabled then EdPagto02.valid;
  EdPagto.valid

end;

procedure TFRetConsig.Edvencimento01ExitEdit(Sender: TObject);
begin
  GridParcelas01.Cells[GridParcelas01.Col,GridParcelas01.Row]:=DateToStr_(EdVencimento01.AsDate);
  GridParcelas01.SetFocus;
  EdVencimento01.Visible:=False;

end;

procedure TFRetConsig.Edportador02Validate(Sender: TObject);
/////////////////////////////////////////////////////////////////
begin
  if (RemessaCG='G') and (EdPortador02.ResultFind<>nil) then begin
    if ( pos( EdPortador02.text,FGeral.GetConfig1AsString('Portadorcartao') ) = 0 ) and
       ( pos( 'CHEQUE' ,uppercase(EdPortador02.ResultFind.fieldbyname('port_descricao').asstring) ) = 0 )
      then
      EdPortador02.invalid('Permitido somente portador cart�o ou cheque');
  end else if pos(EdPortador02.text,EdPort_codigo.text+';'+EdPortador01.text)>0 then
    EdPortador02.invalid('Portador j� utilizado');


end;

procedure TFRetConsig.Edpagto02KeyPress(Sender: TObject; var Key: Char);
////////////////////////////////////////////////////////////////////////////
begin
  FGeral.LImpaEdit(EdPagto02,key);

end;

procedure TFRetConsig.Edpagto02Validate(Sender: TObject);
/////////////////////////////////////////////////////////////////
var nparcelas,n:integer;
    ListaPrazo:TStringlist;
    p:integer;
    valorparcela,valortotal,valoravista,acumulado:currency;
    aliicms,baseicms,vlricms,basesubs,vlrnf01:currency;
    produto:string;

begin
////////////
  if (FCondPagto.GetAvPz(EdPagto02.text)='V') or (Fcondpagto.Getprimeiroprazo(EdPagto02.text)=0) then begin
    if EdUnid_codigo.Resultfind.fieldbyname('Unid_contacontabil').AsInteger=0 then begin
      EdPagto02.INvalid('Unidade sem conta caixa cadastrada para lan�amentos a vista');
      exit;
    end;
  end;
  if EdValorvenda.ascurrency>0 then begin
//////////////////////////// - 11.03.05                                   // 24.10.12
     vlrnf01:=EdValorvenda.ascurrency-valordesconto(EdValorvenda.ascurrency)-EdVlrAdiantamento.ascurrency-ValorGrid-ValorGrid01;
     if ( pos( Global.UFUnidade,Global.UfComSubstituicao ) > 0 )   and (EdDtmovimento.asdate>0) and (TemSubsproduto) then begin
       produto:=Gridcodigos.cells[0,1];
       if trim( produto )<>'' then
         aliicms:=FEstoque.Getaliquotaicms(produto,Global.CodigoUnidade,EdCliente.resultfind.fieldbyname('clie_uf').asstring )
       else
         aliicms:=17;
       baseicms:=vlrnf01;
       vlricms:=baseicms*(aliicms/100);                                    // 25.08.05
       if (EdCliente.resultfind.fieldbyname('clie_tipo').asstring='F') and ( pos(EdCliente.resultfind.fieldbyname('clie_uf').asstring,'SC;RS')>0 )
         then begin  // 15.07.05
         basesubs:=vlrnf01+( (vlrnf01)*(Global.MargemSubsTrib/100) );
         icmssubs:=basesubs*(aliicms/100);
         icmssubs:=icmssubs-vlricms;
       end else begin
         basesubs:=0;
         icmssubs:=0;
       end;
     end else
       icmssubs:=0;
/////////////////////////////
    ListaPrazo:=TStringlist.create;
    n:=FCondPagto.GetPrazos(EdPagto02.text,ListaPrazo);
//    totalnota:=roundvalor( vlrnf01+icmssubs );
//    totalNf:=totalnota;
    valortotal:=vlrnf01;
    if FCondPagto.GetAvPz(EdPagto02.text)='V' then
      valoravista:=vlrnf01  // totalnota
    else begin
      if (Fcondpagto.GetPrimeiroPrazo(EdPagto02.text)=0) and (Fcondpagto.GetNumeroParcelas(EdPagto02.text)>1) then
         valoravista:=FGeral.GetValorAvista(Listaprazo,icmssubs)
      else
         valoravista:=0;
      valortotal:=vlrnf01 - valoravista;
    end;
    nparcelas:=FCondPagto.GetNumeroParcelas(EdPagto02.text);
    acumulado:=0;
    for p:=1 to nparcelas do begin
      GridParcelas02.cells[GridParcelas02.getcolumn('pend_datavcto'),p]:=formatdatetime('dd/mm/yyyy',FGeral.GetProximoDiaUtil(EdDtEmissao.Asdate+Inteiro(ListaPrazo[p-1]),Inteiro(ListaPrazo[p-1]))  );
      if (p=nparcelas) and (valoravista=0) then
        valorparcela:=valortotal-acumulado  // para deixar na ultima parcelas "as d�zimas"
      else begin
        if (valoravista>0) and (nparcelas>1) then begin   // 14.03.05
          valorparcela:=FGeral.Arredonda(valortotal/(nparcelas-1),2);
          if (p=nparcelas) then
            valorparcela:=valortotal+valoravista-acumulado  // para deixar na ultima parcelas "as d�zimas" - 02.06.05
        end else
          valorparcela:=FGeral.Arredonda((valortotal)/nparcelas,2);
      end;
      if (valoravista>0) and (p=1) then begin
        GridParcelas02.cells[GridParcelas02.getcolumn('pend_valor'),p]:=Transform(valoravista,f_cr);
        acumulado:=acumulado+valoravista;
      end else begin
        GridParcelas02.cells[GridParcelas02.getcolumn('pend_valor'),p]:=Transform(valorparcela,f_cr);
        acumulado:=acumulado+valorparcela;
      end;
//      GridParcelas01.cells[GridParcelas.getcolumn('pend_port_codigo'),p]:=EdPortador01.text;
      GridParcelas02.RowCount:=GridParcelas02.RowCount+1;
    end;  // for do numero de parcelas
    Freeandnil(ListaPrazo);
    Gridparcelas02.setfocus;
  end;

end;

procedure TFRetConsig.GridParcelas02DblClick(Sender: TObject);
///////////////////////////////////////////////////////////////////
begin
  AtivaEditsParcelas02;

end;

procedure TFRetConsig.GridParcelas02KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    GridParcelas02DblClick(FRetConsig);

end;

procedure TFRetConsig.Edvencimento02ExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
  GridParcelas02.Cells[GridParcelas02.Col,GridParcelas02.Row]:=DateToStr_(EdVencimento02.AsDate);
  GridParcelas02.SetFocus;
  EdVencimento02.Visible:=False;

end;

procedure TFRetConsig.EdParcela02ExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////////
begin
  GridParcelas02.Cells[GridParcelas02.Col,GridParcelas02.Row]:=Transform(EdParcela02.AsFloat,f_cr);
  GridParcelas02.SetFocus;
  EdParcela02.Visible:=False;
  if PPortador01.enabled then EdPagto01.valid;
  EdPagto.valid;
end;

function TFRetConsig.ValorGrid01: currency;
//////////////////////////////////////////////////
var x:integer;
begin
  result:=0;
  for x:=1 to Gridparcelas01.rowcount do result:=result+Texttovalor(Gridparcelas01.cells[Gridparcelas01.getcolumn('pend_valor'),x])
end;

procedure TFRetConsig.AtivaEditsParcelas02;
////////////////////////////////////////////////
begin
  if GridParcelas02.Col=0 then begin
     EdVencimento02.Top:=GridParcelas02.TopEdit+48;
     EdVencimento02.Left:=GridParcelas02.LeftEdit;
     EdVencimento02.Text:=StrToStrNumeros(GridParcelas02.Cells[GridParcelas02.Col,GridParcelas02.Row]);
//     EdVencimento.Text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
     EdVencimento02.Visible:=True;
     EdVencimento02.SetFocus;
  end else if GridParcelas02.Col=1 then begin
     EdParcela02.Top:=GridParcelas02.TopEdit+48;
     EdParcela02.Left:=GridParcelas02.LeftEdit;
     EdParcela02.SetValue(TextToValor(GridParcelas02.Cells[GridParcelas02.Col,GridParcelas02.Row]));
     EdParcela02.Visible:=True;
     EdParcela02.SetFocus;
//  end else if GridParcelas01.Col=2 then begin
//     EdPend_Port_codigo.Top:=GridParcelas.TopEdit;
//     EdPend_Port_codigo.Left:=GridParcelas.LeftEdit+02;
//     EdPend_Port_codigo.text:=GridParcelas.Cells[GridParcelas.Col,GridParcelas.Row];
//     EdPend_Port_codigo.Visible:=True;
//     EdPend_Port_codigo.SetFocus;
  end;

end;

procedure TFRetConsig.Edpagto01ExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////
begin
  if (EdPagto01.Items.count=1) or ( not Global.Usuario.outrosacessos[0058] ) then
     bgravarclick(FRetConsig)
  else
     EdPortador02.setfocus;

end;

function TFRetConsig.ValorGrid02: currency;
//////////////////////////////////////////////
var x:integer;
begin
  result:=0;
  for x:=1 to Gridparcelas02.rowcount do result:=result+Texttovalor(Gridparcelas02.cells[Gridparcelas02.getcolumn('pend_valor'),x])
end;

end.
