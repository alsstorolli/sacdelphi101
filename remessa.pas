unit remessa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, SqlDtg, StdCtrls, Mask, SQLEd, Buttons,
  SQLBtn, alabel, SQLGrid, SqlExpr;
//  , DataGrid;

type
  TFRemessa = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
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
    EdDtemissao: TSQLEd;
    PIns: TSQLPanelGrid;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdQtde: TSQLEd;
    EdUnitario: TSQLEd;
    bImpressao: TSQLBtn;
    EdRepr_codigo: TSQLEd;
    SQLEd3: TSQLEd;
    EdTotalRemessa: TSQLEd;
    EdNumeroDoc: TSQLEd;
    bDevolucao: TSQLBtn;
    EdMoes_tabp_codigo: TSQLEd;
    SetEdTABP_ALIQUOTA: TSQLEd;
    EdVendabruto: TSQLEd;
    Edtotalqtde: TSQLEd;
    Edcodcor: TSQLEd;
    Setedcor: TSQLEd;
    EdCodtamanho: TSQLEd;
    Setedtamanho: TSQLEd;
    EdCodcopa: TSQLEd;
    SetEdcopa_descricao: TSQLEd;
    EdLimitedisp: TSQLEd;
    procedure EdClienteValidate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure EdRepr_codigoalidate(Sender: TObject);
    procedure bIncluiritemClick(Sender: TObject);
    procedure EdQtdeValidate(Sender: TObject);
    procedure EdUnitarioExitEdit(Sender: TObject);
    procedure bCancelaritemClick(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure bExcluiritemClick(Sender: TObject);
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure bImpressaoClick(Sender: TObject );
    procedure bDevolucaoClick(Sender: TObject);
    procedure EdMoes_tabp_codigoValidate(Sender: TObject);
    procedure EdDtemissaoValidate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdCodtamanhoValidate(Sender: TObject);
    procedure EdCodcopaValidate(Sender: TObject);
    procedure EdMoes_tabp_codigoExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditstoGrid;
    function ProcuraGrid(Coluna:integer;Pesquisa:string):integer;
    procedure LimpaEditsItens;
    function CalculaTotal:currency;
    procedure Campostoedits(Q:TSqlquery);
    procedure Campostogrid(Q:TSqlquery);
    procedure AtivaEdits;
    procedure DesativaEdits;
    procedure GravaItemConsignacao;
    procedure ReservaEstoque(Codigo,IncExc:string;Qtde:currency);
    procedure RetornaReserva;
    procedure GravaItemDevolucao;
    function CalculaTotalQtde:currency;
    function GetStatus(status:string):string;
// 15.07.13
    function ValidaRemessas:boolean;    

end;


var
  FRemessa: TFRemessa;
  QBusca,QEstoque,QGrade:TSqlquery;
  Op,Transacao,semvideo,magazinex:string;
  TotalRemessa,perc:Currency;
  ListaReservacodigo,ListaReservaQtde:TStringList;
  xemissao : TDatetime;

procedure Remessa_Execute(Opx:string;magazine:string='N';numero:integer=0);    // I / A  /  D  /  X

implementation


uses Arquiv, cadcli, Geral, Sqlfun, Diggrade, SqlSis, Estoque, Grades,
  TextRel, represen, tabela , Usuarios, cadcor, tamanhos, cadcopa,
  impressao;

{$R *.dfm}


procedure TFRemessa.EditstoGrid;
var x:integer;
    aqtde:currency;
begin
//  x:=ProcuraGrid(0,EdProduto.Text);
// 23.08.06
  x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.GetColumn('codtamanho'),Edcodtamanho.asinteger,
                        Grid.getcolumn('codcor'),EdCodcor.asinteger,Grid.getcolumn('codcopa'),EdCodcopa.asinteger);
//  if x<0 then begin
//    Grid.AppendRow;
  if x<=0 then begin
    if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.getcolumn('move_esto_codigo'),1])='') then begin
       x:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       x:=Grid.RowCount-1;
    end;
    Grid.Cells[Grid.getcolumn('move_esto_codigo'),Abs(x)]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),Abs(x)]:=SetEdEsto_descricao.text;
    Grid.Cells[Grid.getcolumn('move_qtde'),Abs(x)]:=EdQTde.AsSql;
    Grid.Cells[Grid.getcolumn('move_venda'),Abs(x)]:=EdUnitario.AsSql;
    Grid.Cells[Grid.getcolumn('total'),Abs(x)]:=TRansform(EdQTde.AsCurrency*EdUnitario.AsCurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_vendabru'),Abs(x)]:=EdVendabruto.AsSql;
    Grid.Cells[Grid.getcolumn('move_perdesco'),Abs(x)]:=currtostr(perc);
// 23.08.06
    Grid.Cells[Grid.getcolumn('cor'),Abs(x)]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),Abs(x)]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
    Grid.Cells[Grid.getcolumn('copa'),Abs(x)]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),Abs(x)]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),Abs(x)]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('codcopa'),Abs(x)]:=EdCodcopa.text;
  end else begin
    Grid.Cells[Grid.getcolumn('move_esto_codigo'),x]:=EdProduto.Text;
    Grid.Cells[Grid.getcolumn('esto_descricao'),x]:=SetEdEsto_descricao.text;
    aqtde:=EdQTde.Ascurrency+texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x]);
    Grid.Cells[Grid.getcolumn('move_qtde'),x]:=Transform(EdQTde.Ascurrency+texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),x]),f_cr);
    Grid.Cells[Grid.getcolumn('move_venda'),x]:=Transform(EdUnitario.Ascurrency,f_cr);
    Grid.Cells[Grid.getcolumn('total'),x]:=TRansform(aQTde*EdUnitario.AsCurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_vendabru'),x]:=Transform(EdVendabruto.Ascurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_perdesco'),x]:=Transform(perc,'###.##');
// 23.08.06
    Grid.Cells[Grid.getcolumn('cor'),x]:=FCores.Getdescricao(EdCodcor.asinteger);
    Grid.Cells[Grid.getcolumn('tamanho'),x]:=FTamanhos.Getdescricao(EdCodtamanho.asinteger);
    Grid.Cells[Grid.getcolumn('copa'),x]:=FCopas.Getdescricao(EdCodcopa.asinteger);
    Grid.Cells[Grid.getcolumn('codcor'),x]:=EdCodcor.text;
    Grid.Cells[Grid.getcolumn('codtamanho'),x]:=EdCodtamanho.text;
    Grid.Cells[Grid.getcolumn('codcopa'),x]:=EdCodcopa.text;
  end;
  Grid.Refresh;
end;


procedure TFRemessa.EdClienteValidate(Sender: TObject);
////////////////////////////////////////////////////////////
var restricao1,restricao2,restricao3,restricao4:boolean;
    unidades:string;
begin
// 18.03.15 - Vivan
  if  not FGeral.ValidaCadastro(EdCliente.ResultFind.FieldByName('clie_situacao').AsString) then Edcliente.Invalid('');
//
  restricao1:=true;
  restricao2:=true;
  restricao3:=true;
  restricao4:=true;
  unidades:=Global.Usuario.UnidadesMvto;
// 24.10.12 - vivan
  EdUnid_Codigo.Text:=Global.CodigoUnidade;
  EdRepr_Codigo.Text:=EdCliente.ResultFind.fieldbyname('clie_repr_codigo').AsString;
  EdUnid_codigo.ValidFind;
// 15.07.13 - Liane - Vivan
  if not ValidaRemessas then Edcliente.invalid('');
// 10.07.13 - Vivan - Angela
  EdLimitedisp.setvalue( FGeral.LimiteDisponivel(EdCliente.asinteger) );
// 08.06.16 - cecilia libera TC
  if (OP='I') and (Global.Topicos[1029]) and ( pos(MagazineX,'T')=0 ) then begin
// 04.02.14 - Vivan Cecilia
//  if (OP='I') and (Global.Topicos[1029]) and ( pos(MagazineX,'G')=0 ) then begin
// 16.05.16 - Vivan Cecilia
//  if (OP='I') and (Global.Topicos[1029]) then begin
      restricao1:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','DUP',unidades );
      restricao2:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','BOL',unidades );
      restricao3:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','CHQ',unidades );
      restricao4:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','LIM',unidades );
  end;

//  if not FGeral.ValidaCliente(EdCliente,Global.CodRemessaConsig,'P','BOL') then  //   12.05.06 - 'voltado'
//    EdCliente.Invalid('')
  if not restricao1 then begin //fixo portador duplicata
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;
  end else if not restricao2  then begin //fixo portador boleto
//      if not Confirma('Venda a vista') then
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;
  end else if not restricao3  then begin //cheques devolvidos

        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
          EdCliente.Invalid('');
          exit;
        end;
  end else if not restricao4  then begin // total em aberto versus limite de cr�dito
        if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
          EdCliente.Invalid('');
          exit;
        end;

  end else begin
//    EdUnid_Codigo.Text:=EdCliente.ResultFind.fieldbyname('clie_unid_codigo').AsString;
    Fgeral.Checaremessas(EdCliente.asinteger,EdUnid_Codigo.Text);
  end;
end;

procedure Remessa_Execute(Opx:string;magazine:string='N';numero:integer=0);
//////////////////////////////////////////////////////////////////////////////
begin
  global.UltimoFormAberto:=FREmessa.Name;
  Op:=Opx;
  magazinex:=magazine;
// 17.06.13
  FRemessa.Caption:='Remessa de Consigna��o';
  if magazinex='T' then
    FRemessa.Caption:='Troca de Cr�dito'
  else if magazinex='G' then
    FRemessa.Caption:='Compra Garantida'
  else if magazinex='S' then
    FRemessa.Caption:='Remessa Magazine';
// 27.08.11
  FGeral.ConfiguraColorEditsNaoEnabled(FRemessa);
  FRemessa.Show;
  FRemessa.Grid.Clear; // 25.06.10
//  FRemessa.EdUnitario.enabled:=Global.Usuario.OutrosAcessos[0039];
// 11.04.11 - 'ajeitado'
  FRemessa.EdUnitario.Enabled:=Global.Usuario.OutrosAcessos[0601];
  if (numero>0) and (OP='X') then begin
    FRemessa.EdNumerodoc.setvalue(numero);
    FRemessa.EdNumerodoc.valid;
  end;
// 18.11.13 - Liane - inibir tabela para RC normal
  FRemessa.EdMoes_tabp_codigo.text:='';
//  FRemessa.EdMoes_tabp_codigo.enabled:=(magazine<>'N');
// 01.11.16 - Fama - Janina
  FRemessa.EdMoes_tabp_codigo.enabled:=(Global.Usuario.OutrosAcessos[0061]);
// 30.01.13 - vindos do activate - Doce Pimenta - Cris
///////////////////////
  with FRemessa do begin
    bCancelar.Enabled:=Op='A';
    if (op='A') or (op='X') then  begin
      bImpressao.Enabled:=true;
    end;
    bDevolucao.Enabled:=OP='D';
    bCancelaritem.Enabled:=true;
    semvideo:='N';
    if not Arq.TEstoque.Active then Arq.TEstoque.Open;
    if pos(OP,'A/D/X')>0 then begin
      DesativaEdits;
      EdNumerodoc.Enabled:=true;
{  // 01.11.16 - fama - janina
      if op<>'X' then
        EdMoes_tabp_codigo.Enabled:=true
      else
        EdMoes_tabp_codigo.Enabled:=false;
}
      if OP='D' then
        bCancelaritem.Enabled:=false;
    end else begin
      AtivaEdits;
      EdNumerodoc.Enabled:=false;
    end;
    EdDtemissao.enabled:=Global.Usuario.OutrosAcessos[0702];
    if (OP='D') or (OP='X') then begin
      bIncluiritem.Enabled:=false;
      bExcluiritem.Enabled:=false;
      bCancelar.Enabled:=false;
      bGravar.Enabled:=false;
    end else begin
      bIncluiritem.Enabled:=true;
      bExcluiritem.Enabled:=true;
      bCancelar.Enabled:=true;
      bGravar.Enabled:=true;
    end;
    if OP='X' then begin
      bincluiritem.enabled:=false;
      bexcluiritem.enabled:=false;
      bcancelaritem.enabled:=false;
      bdevolucao.enabled:=false;
    end else begin
      bincluiritem.enabled:=true;
      bexcluiritem.enabled:=true;
      bcancelaritem.enabled:=true;
      bdevolucao.enabled:=true;
    end;
    perc:=0;
    ListaReservaCodigo:=TStringlist.Create;
    ListaReservaQTde:=TStringlist.Create;
  //////////////////  FRemessa.Grid.Clear;
    if Op='I' then begin
      EdCliente.ClearAll(FRemessa,99);
      if trim(EdDtemissao.Text)='' then
         EdDtemissao.SetDate(Sistema.hoje);
      EdCliente.SetFocus;
      EdNumerodoc.Setvalue(0);
    end else
      EdNumerodoc.SetFocus;
  end;
////////////////////////
end;

procedure TFRemessa.FormActivate(Sender: TObject);
//////////////////////////////////////////////////
begin
  if not Arq.TTabelaPreco.Active then Arq.TTabelaPreco.Open;
end;

procedure TFRemessa.bGravarClick(Sender: TObject);
/////////////////////////////////////////////////////
var Numero:integer;
    Q2:TSqlquery;
    restricao4,restricao,restricao1:boolean;
    unidades:string;
begin
  if (EdDtemissao.AsDate<=1) or (EdCliente.AsInteger=0) or (EdRepr_codigo.AsInteger=0)
    or (Grid.RowCount<=1)then
    exit;
  semvideo:='N';
  if not EdMoes_tabp_codigo.valid then begin
    Avisoerro('Problemas na tabela de descontos/acr�scimos');
    exit;
  end;
// 25.01.13
  Q2:=sqltoquery('select clie_codigo from clientes where clie_codigo='+EdCliente.AsSql);
  if Q2.Eof then begin
    Avisoerro('Codigo de cliente n�o encontrado.  Verificar !');
    FGeral.FechaQuery(Q2);
    exit;
  end;
// 18.03.15 - Vivan
  if  not FGeral.ValidaCadastro(EdCliente.ResultFind.FieldByName('clie_situacao').AsString) then exit;

// 21.05.13 - Angela
  restricao4:=true;
  restricao:=true;
  restricao1:=true;
  unidades:=Global.Usuario.UnidadesMvto;
// recolocado cecilia 08.06.16
  if (OP='I') and (Global.Topicos[1029]) and ( pos(MagazineX,'T')=0 )  then begin

// vivan - cecilia - 16.05.16 - checar 'em todas'
//  if (OP='I') and (Global.Topicos[1029]) then begin
// 05.11.15 - 18.11.15 - 'destirado' - cecilia -
//  if (OP='I') and (Global.Topicos[1029]) and ( pos(MagazineX,'G')=0 )  then begin
      restricao4:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','LIM',unidades,EdTotalRemessa.ascurrency );
      restricao1:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','DUP',unidades );
  end else if (OP='I') and (Global.Topicos[1029]) and ( MagazineX='T' )  then begin

      Q2:=sqltoquery('select sum(moes_vlrtotal) as dev from movesto where moes_status = ''N'''+
                     ' and moes_tipo_codigo = '+EdCliente.assql+
                     ' and moes_unid_codigo = '+EdUnid_codigo.assql+
                     ' and moes_dataemissao = '+Datetosql(Sistema.Hoje)+
                     ' and '+FGeral.GetIN('moes_tipomov',Global.CodDevolucaoVenda,'C'));
      if Edtotalremessa.ascurrency > (Q2.fieldbyname('dev').ascurrency+170) then begin

        Avisoerro('M�ximo permitido: '+FGEral.formatavalor(Q2.fieldbyname('dev').ascurrency+170,f_cr));
        exit;

      end;

  end;

  if not restricao4  then begin // total em aberto versus limite de cr�dito
        if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
          EdCliente.Invalid('');
          exit;
        end;
  end;
// 09.04.14
  if not restricao1 then begin //fixo portador duplicata
        if not FGEral.ValidaLiberacaoFinan(Global.usuario.codigo,'DUP') then begin
//          EdCliente.Invalid('');
          exit;
        end;
  end;
// 18.11.13 - vivan - Liane - checagem de RC em aberto
    if (OP='I') and ( pos(MagazineX,'T;G')=0 )  then begin
// 05.11.15 - 18.11.15 - 'destirado'
//    if (OP='I') and ( pos(MagazineX,'G')=0 )  then begin
        restricao:=FGeral.ValidaCliente( EdCliente,Global.CodRemessaConsig,'P','REM',Global.Usuario.UnidadesMvto,EdTotalRemessa.ascurrency );
    end;
  if not restricao  then begin // total de RC em aberto versus limite de RC
          if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
//            EdCliente.Invalid('');
            exit;
          end;
  end;
//////////////////
// 14.11.14 - vivan
      if pos( Edcliente.ResultFind.FieldByName('clie_situacao').AsString,'B/R' )>0 then begin
        Avisoerro('Cliente com situa��o '+Edcliente.ResultFind.FieldByName('clie_situacao').AsString);
        exit;
      end;

///////////////////////
  if not ValidaRemessas then exit;

  if confirma('Confirma grava��o ?') then begin
//    ListaReservaCodigo.Clear;
//    ListaReservaQtde.Clear;
    if OP='I' then begin

      Sistema.BeginTransaction('Gravando');
// 10.09.04
      Numero:=FGeral.GetContador('CONSIG'+EdUnid_codigo.text,false);
      if FGeral.Getconfig1asinteger('Remconsig')>0 then begin
        if Numero<FGeral.Getconfig1asinteger('Remconsig') then begin
          Numero:=FGeral.Getconfig1asinteger('Remconsig');
          FGeral.AlteraContador('CONSIG'+EdUnid_codigo.text,Numero);
        end;
      end;
////////////////////////
      EdNumerodoc.Text:=inttostr(Numero);
      Transacao:=FGeral.GetTransacao;
      try
        if Numero=0 then begin
          Avisoerro('Numero da remessa zerado.    N�o gravado.  Tente novamente !');
          exit;
        end;

        FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
              Global.CodRemessaConsig,Transacao,Numero,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,op,magazinex);
        FGeral.GravaItensConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
              Global.CodRemessaConsig,Transacao,Numero,Grid);
      except
        Avisoerro('Remessa com problemas na grava��o.  Conferir se aparece nas remessas em aberto do cliente.');
      end;

      try
        Sistema.EndTransaction('');
        ListaReservaCodigo.Clear;
        ListaReservaQtde.Clear;
      except
        if not global.Topicos[1201] then begin
          Sistema.beginprocess('Retornando ao estoque as quantidades ja baixadas nesta remessa');
          try
            RetornaReserva;
            Sistema.endprocess('Retorno ao estoque bem sucedido');
          except
            Sistema.endprocess('Falha ao tentar retornar ao estoque');
          end;
        end;
      end;

    end else if OP='A' then begin

      FGeral.FechaQuery(Q2);
      Q2:=sqltoquery('select moes_transacao from movesto where moes_numerodoc='+EdNumerodoc.assql+
                     ' and moes_unid_codigo='+EdUnid_codigo.assql+
                     ' and moes_tipomov='+stringtosql(Global.CodRemessaConsig)+
//                     ' and moes_dataemissao='+EdDtemissao.assql+
// 05.10.2021 - pesquisa pela emissao 'anterior' para casa for alterada
                     ' and moes_dataemissao='+Datetosql(xemissao)+
                     ' and moes_tipo_codigo='+Edcliente.assql );
// ver questao de alterar a emissao q dai aqui n�o encontra a remessa...
      ListaReservaCodigo.Clear;
      ListaReservaQtde.Clear;
      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
             Global.CodRemessaConsig,Q2.fieldbyname('moes_Transacao').ASSTRING,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,Op,magazinex);
      Sistema.Commit;
      Q2.close;
 // 05.10.2021

    end;
/////    semvideo:='S';
// 01.09.17 - retirado janina imprime matricial mas sai 'grande'
    if confirma('Imprimir remessa ?') then
      bimpressaoclick(FRemessa);
    EdCliente.Clearall(FRemessa,99);
    EdDtEmissao.setdate(sistema.hoje);
    Grid.Clear;
    if OP='I' then
      EdCliente.Setfocus
    else
      EdNumerodoc.SetFocus;

  end;

end;

procedure TFRemessa.bCancelarClick(Sender: TObject);
//////////////////////////////////////////////////////////
var QBusca:TSqlquery;
begin
   if (EdDtemissao.Asdate<=1) or (EdCliente.AsInteger=0) or (EdRepr_codigo.AsInteger=0) or (OP='I') then
     exit;
   QBusca:=sqltoquery('select * from movesto where moes_numerodoc='+inttostr(EdNumeroDoc.AsInteger)+
          ' and moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodRemessaConsig) );

   if QBusca.eof then
     Aviso('Numero de remessa n�o encontrado')
   else begin
     if confirma('Confirma exclus�o ?') then begin
       ExecuteSql('Update movesto set moes_status=''C'' where moes_numerodoc='+inttostr(EdNumeroDoc.AsInteger)+
                  ' and moes_status=''N'' and moes_tipomov='+stringtosql(Global.CodRemessaConsig) );
       ExecuteSql('Update movestoque set move_status=''C'' where move_numerodoc='+inttostr(EdNumeroDoc.AsInteger)+
                  ' and move_status=''N'' and move_tipomov='+stringtosql(Global.CodRemessaConsig) );
       Sistema.Commit;
       EdNumerodoc.ClearAll(FRemessa,99);
       Grid.Clear;
     end;
   end;
   QBusca.Free;
   EdNumeroDoc.Setfocus;

end;

procedure TFRemessa.EdRepr_codigoalidate(Sender: TObject);
begin
  if not FGeral.ValidaRepresentante(EdRepr_codigo) then
    EdRepr_Codigo.SetFocus;

end;

procedure TFRemessa.bIncluiritemClick(Sender: TObject);
begin
  if EdCliente.AsInteger=0 then exit;
  if EdRepr_codigo.AsInteger=0 then exit;
  PRemessa.Enabled:=false;
  bGravar.Enabled:=false;
  bSair.Enabled:=false;
  bCancelar.Enabled:=false;
  PINs.Visible:=true;
  PINs.EnableEdits;
  LimpaEditsItens;
  EdProduto.SetFocus;
end;

procedure TFRemessa.EdQtdeValidate(Sender: TObject);
begin
  if EdQtde.AsCurrency>0 then begin
    if EdQtde.ascurrency>99999 then begin   // 18.11.05
       EdQTde.INvalid('Quantidade acima de 99999');
    end else begin
      if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsCurrency,EdUNid_codigo.Text,QEstoque) then begin
         EdQTde.INvalid('Quantidade em estoque insuficiente');
      end;
    end;
// provavelmente nao precisara de grade aqui
//    if EdProduto.ResultFind.FieldByName('esto_grad_codigo').AsInteger>0 then begin
// mostrar grade para digita��o na grade e sua consistencia com o total digitado no edit
// se ok lan�ar todos os tamanhos/cores do dtgrid
//       FGrade.Execute(EdUnid_codigo.text,EdProduto.Text,EdProduto.ResultFind.FieldByName('esto_grad_codigo').AsInteger);
//    end;
  end;
end;

procedure TFRemessa.EdUnitarioExitEdit(Sender: TObject);
/////////////////////////////////////////////////////////////
var restricao4,restricao:boolean;
begin
//  if confirma('Confirma item ?') then begin
    EditstoGrid;
    ReservaEstoque(EdProduto.Text,'I',EdQtde.AsCurrency);
    EdTotalRemessa.setvalue(CalculaTotal);
    EdTotalqtde.setvalue(CalculatotalQtde);
    restricao4:=true;
    restricao:=true;
// 21.08.13 - vivan - Angela + Lindadir - checar por produto passado - 08.06.16 - nao checar mais TC
    if (OP='I') and (Global.Topicos[1029]) and ( pos(MagazineX,'T')=0 )  then begin
// 16.05.16 - vivan - cecilia
//    if (OP='I') and (Global.Topicos[1029])  then begin
        restricao4:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','LIM',Global.Usuario.UnidadesMvto,EdTotalRemessa.ascurrency );
    end;
// 18.11.13 - vivan - Liane - checagem de RC em aberto
    if (OP='I') and ( pos(MagazineX,'T;G')=0 )  then begin
        restricao:=FGeral.ValidaCliente( EdCliente,Global.CodRemessaConsig,'P','REM',Global.Usuario.UnidadesMvto,EdTotalRemessa.ascurrency );
    end;
    if not restricao4  then begin // total em aberto versus limite de cr�dito
          if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
            EdProduto.Invalid('');
            exit;
          end;
    end;
// 18.11.13
    if not restricao  then begin // total de RC em aberto versus limite de RC
          if not FGEral.ValidaLiberacaoLimite(Global.usuario.codigo) then begin
            EdProduto.Invalid('');
            exit;
          end;
    end;
//////////////////
    if op='A' then begin
      GravaItemConsignacao;
      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
             Global.CodRemessaConsig,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,OP,magazinex);
      Sistema.Commit;
      ListaReservaCodigo.Clear;
      ListaReservaQtde.Clear;
    end;
//  end;
  LimpaEditsItens;
  EdProduto.SetFocus;
  QEstoque.close;
  Freeandnil(QEstoque);

end;

procedure TFRemessa.bCancelaritemClick(Sender: TObject);
begin
  if EdRepr_codigo.AsInteger=0 then exit;
  bGravar.Enabled:=true;
  bCancelar.Enabled:=true;
  bSair.Enabled:=true;
  PINs.Visible:=false;
  PINs.DisableEdits;
  AtivaEdits;
  PRemessa.Enabled:=true;
//  EdCliente.SetFocus;
  EdMoes_tabp_codigo.Setfocus;
end;

function TFRemessa.ProcuraGrid(Coluna: integer; Pesquisa: string):integer;
var p:integer;
begin
  result:=0;
  for p:=1 to Grid.RowCount do  begin
    if trim(Grid.Cells[Coluna,p])=trim(Pesquisa) then begin
      result:=p;
      break;
    end;
    if trim(Grid.Cells[Coluna,p])='' then begin   // linha a ser usada
      result:=(-1)*p;
      break;
    end;
  end;
end;


procedure TFRemessa.LimpaEditsItens;
begin
  EdProduto.Clear;
  EdQtde.Clear;
  EdUnitario.Clear;
  SetedEsto_descricao.Clear;
end;


procedure TFRemessa.EdProdutoValidate(Sender: TObject);
var x:integer;
    QBusca,QGradeMatriz,QEstoqueMatriz:TSqlquery;
    codbarra:string;
    codigobarra:boolean;
begin
  codigobarra:=false;
  if  FGeral.CodigoBarra(EdProduto.Text,EdProduto) then begin
    QBusca:=sqltoquery('select * from estoque where esto_Codbarra='+EdProduto.AsSql);
    codbarra:=EdProduto.text;
    codigobarra:=true;
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
//      EdProduto.Invalid('Codigo de barra n�o encontrado');
//      exit;
    end;
    EdQtde.Enabled:=false;
    EdQtde.SetValue(1);
    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                           ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
// 25.03.08
///////////////////
    if (QEstoque.eof) and ( not QBusca.eof) then begin
       QEstoqueMatriz:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(Global.unidadematriz));
       if not QEstoqueMatriz.eof then begin
          Sistema.Insert('estoqueqtde');
          Sistema.Setfield('esqt_status','N');
          Sistema.Setfield('esqt_unid_codigo',EdUnid_codigo.text);
          Sistema.Setfield('esqt_esto_codigo',EdProduto.Text);
          Sistema.Setfield('esqt_qtde',QEstoqueMatriz.fieldbyname('esqt_qtde').ascurrency);
          Sistema.Setfield('esqt_qtdeprev',QEstoqueMatriz.fieldbyname('esqt_qtdeprev').ascurrency);
          Sistema.Setfield('esqt_vendavis',QEstoqueMatriz.fieldbyname('esqt_vendavis').ascurrency);
          Sistema.Setfield('esqt_custo',QEstoqueMatriz.fieldbyname('esqt_custo').ascurrency);
          Sistema.Setfield('esqt_custoger',QEstoqueMatriz.fieldbyname('esqt_custoger').ascurrency);
          Sistema.Setfield('esqt_customedio',QEstoqueMatriz.fieldbyname('esqt_customedio').ascurrency);
          Sistema.Setfield('esqt_customeger',QEstoqueMatriz.fieldbyname('esqt_customeger').ascurrency);
          Sistema.Setfield('esqt_dtultvenda',QEstoqueMatriz.fieldbyname('esqt_dtultvenda').asdatetime);
          Sistema.Setfield('esqt_dtultcompra',QEstoqueMatriz.fieldbyname('esqt_dtultcompra').asdatetime);
          Sistema.Setfield('esqt_desconto',0);
          Sistema.Setfield('esqt_basecomissao',0);

//          Sistema.Setfield('esqt_cfis_codigoest',QEstoqueMatriz.fieldbyname('esqt_cfis_codigoest').asstring);
//          Sistema.Setfield('esqt_cfis_codigoforaest',QEstoqueMatriz.fieldbyname('esqt_cfis_codigoforaest').asstring);
//          Sistema.Setfield('esqt_sitt_codestado',QEstoqueMatriz.fieldbyname('esqt_sitt_codestado').asinteger);
//          Sistema.Setfield('esqt_sitt_forestado',QEstoqueMatriz.fieldbyname('esqt_sitt_forestado').asinteger);
// 10.04.08 - buscar na unidade em uso a tributa��o fora do estado
          Sistema.Setfield('esqt_cfis_codigoest',GetSittDentro(EdUnid_codigo.text));
          Sistema.Setfield('esqt_cfis_codigoforaest',GetSittFora(EdUnid_codigo.text) );
          Sistema.Setfield('esqt_sitt_codestado',GetFiscalDentro(EdUnid_codigo.text));
          Sistema.Setfield('esqt_sitt_forestado',GetFiscalFora(EdUnid_codigo.text) );

          Sistema.Setfield('esqt_usua_codigo',Global.Usuario.codigo);
          Sistema.Post();
          Sistema.commit;
       end;
       QEstoqueMatriz.close;QEstoqueMatriz.free;
    end;
/////////////////////////////
    if not FGeral.TemEstoque(EdProduto.Text,EdQtde.AsCurrency,EdUNid_codigo.Text,QEstoque) then begin
       EdProduto.INvalid('Quantidade em estoque insuficiente');
       exit;
    end;
// 23.08.06
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
// reges - 27.02.08 - incluir automatico nas filiais as grades nao existentens pegando da matriz
// 31.08.17 - Janina - retirado por ser especifico demais para Toke
/////////////////////////////
//{
        if EdUNid_codigo.text<>Global.unidadematriz then begin
          QGradeMatriz:=sqltoquery('select * from EstGrades where esgr_status=''N'''+
                       ' and esgr_unid_codigo='+Stringtosql(Global.unidadematriz)+
                       ' and esgr_codbarra='+stringtosql(codbarra));
          if not QGradeMatriz.eof then begin
            Sistema.Insert('Estgrades');
            Sistema.Setfield('esgr_status','N');
            Sistema.Setfield('esgr_esto_codigo',QGradeMatriz.fieldbyname('esgr_esto_codigo').asstring);
            Sistema.Setfield('esgr_unid_codigo',EdUnid_codigo.text);
            Sistema.Setfield('esgr_grad_codigo',0);
            Sistema.Setfield('esgr_qtde',0 );
            Sistema.Setfield('esgr_qtdeprev',0);
            Sistema.Setfield('esgr_codbarra',codbarra);
            Sistema.Setfield('esgr_custo',QGradeMatriz.fieldbyname('esgr_custo').ascurrency);
            Sistema.Setfield('esgr_customedio',QGradeMatriz.fieldbyname('esgr_customedio').ascurrency);
            Sistema.Setfield('esgr_custoger',QGradeMatriz.fieldbyname('esgr_custoger').ascurrency);
            Sistema.Setfield('esgr_customeger',QGradeMatriz.fieldbyname('esgr_customeger').ascurrency);
            Sistema.Setfield('esgr_vendavis',QGradeMatriz.fieldbyname('esgr_vendavis').ascurrency);
            Sistema.Setfield('esgr_dtultvenda',sistema.hoje);
            Sistema.Setfield('esgr_dtultcompra',sistema.hoje);
            Sistema.Setfield('esgr_usua_codigo',Global.Usuario.codigo);
            Sistema.Setfield('esgr_tama_codigo',QGradeMatriz.fieldbyname('esgr_tama_codigo').asinteger);
            Sistema.Setfield('esgr_core_codigo',QGradeMatriz.fieldbyname('esgr_core_codigo').asinteger);
            Sistema.Setfield('esgr_copa_codigo',QGradeMatriz.fieldbyname('esgr_copa_codigo').asinteger);
            Sistema.Post();
            Sistema.commit;
            QGrade.close;
            QGrade:=sqltoquery('select * from EstGrades where esgr_status=''N'''+
                       ' and esgr_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
                       ' and esgr_codbarra='+stringtosql(codbarra));
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
            EdProduto.Invalid('Codigo de barra da grade n�o encontrado na MATRIZ');
            exit;
          end;
          FGeral.fechaquery(QGradeMatriz);
         // }
/////////////////////////////
        end else begin
          EdProduto.Invalid('Codigo de barra da grade n�o encontrado');
          exit;
        end;
      end;
    end else begin
// 19.05.14
        if (Global.Topicos[1038]) then begin
          if EdCodcor.IsEmpty then begin
            EdProduto.Invalid('Codigo da cor n�o encontrado');
            EdCodcor.Enabled:=true;
            EdCodcor.Empty:=false;
            EdCodtamanho.Enabled:=true;
            EdCodtamanho.Empty:=false;
            exit;
          end;
          if EdCodtamanho.IsEmpty then begin
            EdProduto.Invalid('Codigo do tamanho n�o encontrado');
            EdCodtamanho.Enabled:=true;
            EdCodtamanho.Empty:=false;
            EdCodcor.Enabled:=true;
            EdCodcor.Empty:=false;
            exit;
          end;
        end;
    end;
/////////////////////////


  end else begin

    QBusca:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.AsSql);
    if not QBusca.Eof then
      EdProduto.Text:=QBusca.fieldbyname('esto_codigo').AsString
    else begin
      EdProduto.Invalid('Codigo n�o encontrado');
      exit;
    end;
    QEstoque:=sqltoquery('select * from EstoqueQtde where esqt_status=''N'' and esqt_esto_codigo='+EdProduto.AsSql+
                         ' and esqt_unid_codigo='+Stringtosql(EdUnid_codigo.text));
    EdQtde.Enabled:=true;
    EdQtde.SetValue(0);
// 23.08.06
    EdCodcor.enabled:=true;
    EdCodcor.setvalue(0);
    EdCodtamanho.enabled:=true;
    EdCodtamanho.setvalue(0);
//    EdCodcopa.enabled:=true;
// 19.05.14
    if (Global.Topicos[1038]) then begin
            EdCodcor.Empty:=false;
            EdCodtamanho.Empty:=false;
    end;

    EdCodcopa.setvalue(0);

  end;

  SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;
// 21.02.06
//  if not FGeral.ChecaMostruario(EdProduto.text,Global.CodRemessaConsig,EdCliente.asinteger,EdNumerodoc.asinteger) then begin
//    EdProduto.invalid('');
//    exit;
//  end;
// 05.12.063 - Solange+Janina - retirado restri��o no consignado

//
//  EdUnitario.Setvalue(QEstoque.fieldbyname('esqt_vendavis').AsCurrency);
//  EdVendabruto.setvalue(QEstoque.fieldbyname('esqt_vendavis').AsCurrency);
// 19.09.05 - retorna assim em 08.08.16 - antes pegava da unidade em uso
//  EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.unidadematriz));
// 28.10.16 - Fama - janina
  EdUnitario.setvalue(FEstoque.GetPreco(EdProduto.text,Global.CodigoUnidade));
  EdVendabruto.setvalue(EdUnitario.ascurrency);
// 23.08.06
  if (pos( EdProduto.text,FGeral.Getconfig1asstring('Produtoscopa') )>0) and ( not codigobarra) then
    EdcodCopa.enabled:=true
  else begin
    EdCodCopa.enabled:=false;
    EdCodCopa.setvalue(0);
  end;

  if EdMoes_tabp_codigo.AsInteger>0 then
     EdUnitario.setvalue(FGeral.CalcDescAcre(EdVendabruto.ascurrency,perc,Arq.TTabelaPreco.fieldbyname('tabp_tipo').asstring));
// 08.08.05
  if EdUnitario.ascurrency<=0 then
     EdProduto.invalid('Produto com pre�o de venda zerado.  Checar');
{
  if op='A' then begin
//      x:=ProcuraGrid(0,EdProduto.Text);
      x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.GetColumn('codtamanho'),Edcodtamanho.asinteger,
                        Grid.getcolumn('codcor'),EdCodcor.asinteger,Grid.getcolumn('codcopa'),EdCodcopa.asinteger);
      if x>0 then
        EdProduto.Invalid('Produto j� existente.   Excluir e incluir.');
  end;
}

end;

function TFRemessa.CalculaTotal:currency;
var p:integer;
    vlrtotal:currency;
begin
  vlrtotal:=0;
  for p:=1 to Grid.RowCount do begin
    vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),p])*texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),p]),2);
  end;
  result:=vlrtotal;
end;

procedure TFRemessa.bExcluiritemClick(Sender: TObject);
var codigoestoque,sqlcor,sqltamanho,sqlcopa:string;
    qtde:currency;
    Q2:TSqlquery;
begin
  if EdRepr_codigo.AsInteger=0 then exit;
  if trim(Grid.Cells[0,Grid.row])='' then exit;
  if confirma('Confirma exclus�o ?') then begin
    codigoestoque:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
    qtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
    sqlcor:=FCores.Getsql('move_core_codigo',strtointdef(Grid.cells[Grid.getcolumn('codcor'),Grid.row],0) );
    sqltamanho:=FTamanhos.Getsql('move_tama_codigo',strtointdef(Grid.cells[Grid.getcolumn('codtamanho'),Grid.row],0) );
    sqlcopa:=FCopas.Getsql('move_copa_codigo',strtointdef(Grid.cells[Grid.getcolumn('codcopa'),Grid.row],0) );
    Grid.DeleteRow(Grid.Row);
    Edtotalremessa.SetValue(Calculatotal);
    Edtotalqtde.SetValue(Calculatotalqtde);
    ReservaEstoque(Codigoestoque,'E',qtde);
    if OP='A' then begin
      Q2:=sqltoquery('select moes_transacao from movesto where moes_numerodoc='+EdNumerodoc.assql+
                     ' and moes_unid_codigo='+EdUnid_codigo.assql+
                     ' and moes_tipomov='+stringtosql(Global.CodRemessaConsig)+
                     ' and moes_dataemissao='+EdDtemissao.assql+
                     ' and moes_tipo_codigo='+Edcliente.assql );
      transacao:=Q2.fieldbyname('moes_transacao').asstring;
      ExecuteSql('Update movestoque set move_status=''C'' where move_status=''N'''+
          ' and move_numerodoc='+EdNumerodoc.AsSql+
          ' and move_tipomov='+Stringtosql(Global.CodRemessaConsig)+
          ' and move_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and move_tipo_codigo='+EdCliente.AsSql+
          ' and move_esto_codigo='+Stringtosql(codigoestoque)+
          sqlcor+sqltamanho+sqlcopa+
          ' and move_tipocad='+Stringtosql('C') );
      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
             Global.CodRemessaConsig,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,Op,magazinex);
      FGeral.fechaquery(Q2);
    end;
    Sistema.Commit;
  end;
end;

procedure TFRemessa.Campostoedits(Q:TSqlquery);
///////////////////////////////////////////////////////////////////
begin

  EdCliente.Text:=Q.fieldbyname('moes_tipo_codigo').AsString;
  EdUnid_codigo.Text:=Q.fieldbyname('moes_unid_codigo').AsString;
  EdDtEmissao.SetDate(Q.fieldbyname('moes_dataemissao').AsDateTime);
// 05.10.2021
  xemissao := Q.fieldbyname('moes_dataemissao').AsDateTime;

  EdRepr_codigo.Text:=Q.fieldbyname('moes_repr_codigo').AsString;
  EdTotalremessa.SetValue(Q.fieldbyname('moes_vlrtotal').AsCurrency);
  EdMoes_tabp_codigo.SetValue(Q.fieldbyname('moes_tabp_codigo').AsInteger);
  SetEdTabp_aliquota.Text:=FTabela.GetDescAliquota(Q.fieldbyname('moes_tabp_codigo').AsInteger);
  EdUnid_codigo.ValidateEdit;
  EdRepr_codigo.ValidateEdit;
  EdCliente.ValidateEdit;
end;

procedure TFRemessa.Campostogrid(Q:TSqlquery);
var p:integer;
begin
  Grid.Clear;p:=1;Q.First;
  while not Q.Eof do begin
    Grid.Cells[Grid.getcolumn('move_esto_codigo'),p]:=Q.fieldbyname('move_esto_codigo').Asstring;
    Grid.Cells[Grid.getcolumn('esto_descricao'),p]:=FEstoque.GetDescricao(Q.fieldbyname('move_esto_codigo').Asstring);
    Grid.Cells[Grid.getcolumn('move_qtde'),p]:=transform(Q.fieldbyname('move_qtde').Ascurrency,f_cr);
    Grid.Cells[Grid.getcolumn('move_venda'),p]:=transform(Q.fieldbyname('move_venda').Ascurrency,f_cr);
    Grid.Cells[Grid.getcolumn('total'),p]:=transform(FGeral.Arredonda(Q.fieldbyname('move_venda').Ascurrency*Q.fieldbyname('move_qtde').Ascurrency,2),f_cr);
// 24.08.06
    Grid.Cells[Grid.getcolumn('cor'),p]:=FCores.Getdescricao(Q.fieldbyname('move_core_codigo').AsInteger);
    Grid.Cells[Grid.getcolumn('tamanho'),p]:=FTamanhos.Getdescricao(Q.fieldbyname('move_tama_codigo').AsInteger);
    Grid.Cells[Grid.getcolumn('copa'),p]:=FCopas.Getdescricao(Q.fieldbyname('move_copa_codigo').AsInteger);
    Grid.Cells[Grid.getcolumn('codcor'),p]:=Q.fieldbyname('move_core_codigo').Asstring;
    Grid.Cells[Grid.getcolumn('codtamanho'),p]:=Q.fieldbyname('move_tama_codigo').Asstring;
    Grid.Cells[Grid.getcolumn('codcopa'),p]:=Q.fieldbyname('move_copa_codigo').Asstring;
    inc(p);
    Grid.AppendRow;
    Q.Next;
  end;
  EdTotalqtde.setvalue(calculatotalqtde);
  EdTotalRemessa.setvalue(CalculaTotal);
end;

procedure TFRemessa.AtivaEdits;
begin
  PRemessa.Enabled:=true;
// 18.11.13 - Liane - inibir tabela para RC normal
//   EdMoes_tabp_codigo.enabled:=(magazinex<>'N');
// 01.11.16 - Fama - Janina
  EdMoes_tabp_codigo.enabled:=(Global.Usuario.OutrosAcessos[0061]);
  if OP='I' then begin
    PRemessa.EnableEdits;
    EdNumerodoc.Enabled:=false;
    EdDtemissao.enabled:=Global.Usuario.OutrosAcessos[0702];
// 18.11.13 - Liane - inibir tabela para RC normal
//    EdMoes_tabp_codigo.enabled:=(magazinex<>'N');
// 01.11.16 - Fama - Janina
    EdMoes_tabp_codigo.enabled:=(Global.Usuario.OutrosAcessos[0061]);
  end else
    EdNumerodoc.Enabled:=true;
end;

procedure TFRemessa.DesativaEdits;
begin
  PRemessa.DisableEdits;
  EdNumerodoc.Enabled:=true;

end;

procedure TFRemessa.EdNumeroDocValidate(Sender: TObject);
begin

  if EdNumerodoc.AsInteger>0 then begin
     QBusca:=sqltoquery(FGeral.buscaremessa(EdNumerodoc.AsInteger,Global.CodRemessaConsig,'N'));
     if QBusca.eof then begin
// 23.01.14 - para imprimir RC do 'ano passado' devido a liane voltar pro 1 a numeracao
       QBusca:=sqltoquery(FGeral.buscaremessa(EdNumerodoc.AsInteger,Global.CodRemessaConsig,'N;D',EdUnid_codigo.text,Sistema.hoje-365));
       if QBusca.eof then begin
         EdNUmerodoc.INvalid('Numero de remessa n�o encontrado');
         EdNumerodoc.ClearAll(FRemessa,99);
         Grid.Clear;
       end else begin
         Campostoedits(Qbusca);
         Campostogrid(Qbusca);
         EdCliente.ValidFind;
         TotalRemessa:=EdTotalremessa.AsCurrency;
         EdRepr_codigo.ValidFind;
         EdUnid_codigo.ValidFind;
       end;
     end else begin
       Campostoedits(Qbusca);
       Campostogrid(Qbusca);
       EdCliente.ValidFind;
       TotalRemessa:=EdTotalremessa.AsCurrency;
       EdRepr_codigo.ValidFind;
       EdUnid_codigo.ValidFind;
     end;
  end;
end;

function TFRemessa.GetStatus(status: string): string;
begin
   if status='N' then
     result:='Pendente'
   else
     result:='Fechada';
end;


procedure TFRemessa.GravaItemConsignacao;
var codigograde,codigolinha,codigocoluna:integer;
    Q2:TSqlquery;
begin
   Q2:=Sqltoquery('select moes_status,moes_transacao from movesto where moes_status=''N'''+
          ' and moes_numerodoc='+EdNumerodoc.AsSql+
          ' and moes_tipomov='+Stringtosql(Global.CodRemessaConsig)+
          ' and moes_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and moes_tipo_codigo='+EdCliente.AsSql+
          ' and moes_tipocad=''C''' );
   if Q2.Eof then begin
      Avisoerro('N�o encontrado esta remessa para incluir este item');
      exit;
   end else begin
//      codigograde:=FEstoque.GetCodigoGrade(EdProduto.Text);
      Transacao:=Q2.fieldbyname('moes_transacao').Asstring;
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',EdProduto.Text);
{
      codigolinha:=FEstoque.GetCodigoLinha(EdProduto.Text,codigograde);
      codigocoluna:=FEstoque.GetCodigoColuna(EdProduto.Text,codigograde);
      if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
        Sistema.SetField('move_tama_codigo',codigolinha)
      else
        Sistema.SetField('move_core_codigo',codigolinha);
      if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
        Sistema.SetField('move_tama_codigo',codigocoluna)
      else
        Sistema.SetField('move_core_codigo',codigocoluna);
}
      Sistema.SetField('move_core_codigo',Edcodcor.asinteger);
      Sistema.SetField('move_tama_codigo',Edcodtamanho.asinteger);
      Sistema.SetField('move_copa_codigo',Edcodcopa.asinteger);

      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',Ednumerodoc.Asinteger);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',Global.CodRemessaConsig);
      Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('move_tipo_codigo',EdCliente.AsInteger);
      Sistema.SetField('move_tipocad','C');
      Sistema.SetField('move_repr_codigo',EdRepr_codigo.AsInteger);
      Sistema.SetField('move_qtde',EdQtde.AsCurrency);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',Sistema.Hoje);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_venda',EdUnitario.AsCurrency);
      Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.Post('');
      Sistema.Commit;
   end;
   Q2.close;
   Freeandnil(Q2);
end;


procedure TFRemessa.bSairClick(Sender: TObject);
begin
  Grid.Clear;
  Close;
end;


procedure TFRemessa.ReservaEstoque(Codigo, IncExc: string; Qtde: currency);
var p:integer;
begin
  if not global.Topicos[1201] then begin
    if Incexc='I' then begin
      ListaReservaCodigo.Add(Codigo);
      ListaReservaQtde.Add(transform(Qtde,'#,###,###.00'));
      FGeral.ReservaEstoque(Codigo,EdUnid_codigo.text,'S',Global.CodRemessaConsig,Qtde);
    end else begin
      p:=ListaReservaCodigo.IndexOf(Codigo);
      if p>-1 then begin
        ListaReservaCodigo.Delete(p);
        ListaReservaQtde.Delete(p);
      end;
  // deixado fora do if pois pode entrar direto na altera��o e excluir...da� listareservacodigo estar� vazia
      FGeral.ReservaEstoque(Codigo,EdUnid_codigo.text,'E',Global.CodRemessaConsig,Qtde);
    end;
    Sistema.Commit;
  end;
end;

procedure TFRemessa.RetornaReserva;
var p:integer;
begin
  if ListaReservaCodigo<>nil then begin
    if ListaReservaCodigo.Count>0 then begin
      for p:=0 to ListaReservaCodigo.Count-1 do begin
        FGeral.ReservaEstoque(ListaReservaCodigo[p],EdUnid_codigo.text,'E',Global.CodRemessaConsig,texttovalor(ListaReservaQtde[p]));
      end;
      Sistema.Commit;
      ListaReservaCodigo.Clear;
      ListaReservaQTde.Clear;
    end;
  end;

end;

/////////////////////////////////////////////////////////////
procedure TFRemessa.bImpressaoClick(Sender: TObject);
/////////////////////////////////////////////////////////////
var largura,titem:integer;
    QBusca,QClientes:TSqlquery;
    tqtde,liquido,Tdescacre,valorbruto,qtde,venda:currency;
    descacre,produto,xtitulo:string;
    comprimidotitulo,ImpressoraHP:boolean;
begin
//  if not EdCliente.Valid then exit;
  QBusca:=sqltoquery(FGeral.buscaremessa(EdNumerodoc.AsInteger,Global.CodRemessaConsig,'N;D',EdUnid_codigo.text,Sistema.hoje));
  if QBusca.Eof then begin
// 23.01.14 - para imprimir RC do 'ano passado'
    QBusca:=sqltoquery(FGeral.buscaremessa(EdNumerodoc.AsInteger,Global.CodRemessaConsig,'N;D',EdUnid_codigo.text,Sistema.hoje-365));
    if QBusca.Eof then begin
      Avisoerro('Remessa n�o encontrada');
      exit;
    end;
  end;

  if not Global.Topicos[1011] then begin
    if not Confirma('Confirma impress�o ?') then exit;
  end;
  Sistema.BeginProcess('');
  largura:=80;
//  FTextRel.Init(60);
// 04.09.12
  ImpressoraHP:=false;
  if pos('VIVAN',Uppercase(Global.NomeUnidade))>0 then ImpressoraHP:=true;
  if pos('FAMA',Uppercase(Global.NomeUnidade))>0 then ImpressoraHP:=true;
// 26.09.17
  if pos('HARD',Uppercase(Global.NomeUnidade))>0 then ImpressoraHP:=true;
// 03.09.2021  - MUDOU A RAZAO SOCIAL
  if pos('DENIM',Uppercase(Global.NomeUnidade))>0 then ImpressoraHP:=true;

  if IMpressoraHP then
//    FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309],09,70)
    FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309])
  else
//    FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309],0,0);
    FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309]);
  FTextRel.MargemEsquerda:=3;
  FTextRel.Titulo.Clear;
  FTextRel.ClearColunas;
// 04.09.12 - Vivan - Lindacir
  comprimidotitulo:=true;;
  if not Arq.TUnidades.Active then Arq.TUnidades.Open;
//  if not Arq.TClientes.Active then Arq.TClientes.Open;
  QClientes:=sqltoquery('select * from clientes where clie_codigo='+QBusca.Fieldbyname('Moes_tipo_codigo').Asstring);
  if not Arq.TMunicipios.Active then Arq.TMunicipios.Open;
  Arq.TUnidades.Locate('unid_codigo',QBusca.Fieldbyname('Moes_Unid_codigo').Asstring,[]);
  Arq.TMunicipios.Locate('cida_codigo',QClientes.Fieldbyname('clie_cida_codigo_res').AsInteger,[]);

  if Global.Topicos[1011] then begin
    FImpressao.ImprimeRemessa(QBusca.fieldbyname('moes_numerodoc').AsInteger,QBusca.fieldbyname('moes_datamvto').AsDatetime,QBusca.fieldbyname('moes_unid_codigo').Asstring,Global.CodRemessaConsig);
    Sistema.EndProcess('');
    QBusca.Close;
    Freeandnil(QBusca);
    QClientes.Close;
    Freeandnil(QClientes);
    exit;
  end;

//  FTextRel.AddTitulo(FGeral.Centra('Remessa de Consigna��o',largura),true,False,false);
//  FTextrel.SaltaLinha(2);
//  FTextRel.AddLinha('Emiss�o : '+QBusca.fieldbyname('moes_dataemissao').Asstring+space(40)+
//                    'N�mero : '+QBusca.fieldbyname('moes_numerodoc').Asstring
//                    ,false,False,false);
// 24.06.13 - recolocado titulo - Liane
  xtitulo:='Remessa de Consigna��o';
  if QBusca.fieldbyname('moes_rcmagazine').asstring='M' then
    xtitulo:='Remessa Magazine'
  else if QBusca.fieldbyname('moes_rcmagazine').asstring='T' then
    xtitulo:='Troca de Cr�dito'
  else if QBusca.fieldbyname('moes_rcmagazine').asstring='G' then
    xtitulo:='Compra Garantida';
///////////////////
  if ImpressoraHP then
    largura:=110;

  FTextRel.AddTitulo(FGeral.Centra( xtitulo ,largura),true,False,comprimidotitulo);
  FTextRel.AddTitulo('Emissao : '+QBusca.fieldbyname('moes_dataemissao').Asstring+space(2)+
                    'Vendedor: '+QBusca.fieldbyname('moes_repr_codigo').Asstring+' - '+
//                    FRepresentantes.GetDescricao(QBusca.fieldbyname('moes_repr_codigo').AsInteger)+
                    FGeral.GetNomeRazaoSocialEntidade(QBusca.fieldbyname('moes_repr_codigo').AsInteger,'R','N')+
                    space(20)+'  Pg: [NumPg]'
                    ,false,False,comprimidotitulo);

//  FTextRel.AddLinha('Vendedor: '+QBusca.fieldbyname('moes_repr_codigo').Asstring+' - '+
//                    FRepresentantes.GetDescricao(QBusca.fieldbyname('moes_repr_codigo').AsInteger)
//                    ,false,False,false);

  FTextRel.AddTitulo(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,comprimidotitulo);
//  FTextrel.SaltaLinha(1);
//  Arq.TClientes.Locate('clie_codigo',QBusca.Fieldbyname('Moes_tipo_codigo').AsINteger,[]);
  FTextRel.AddTitulo('Cliente......: '+QClientes.fieldbyname('clie_nome').AsString,false,False,comprimidotitulo);
  FTextRel.AddTitulo('Codigo.......: '+QClientes.Fieldbyname('clie_codigo').Asstring,false,False,comprimidotitulo);
  FTextRel.AddTitulo('Raz�o Social : '+strspace(QClientes.Fieldbyname('clie_razaosocial').Asstring,37)+
                    'Tel.:'+FGeral.Formatatelefone(QClientes.Fieldbyname('clie_foneres').Asstring)
                    ,false,False,comprimidotitulo);
  FTextRel.AddTitulo('Endereco.....: '+strspace(QClientes.Fieldbyname('clie_endres').Asstring,36)+space(01)+
                    'CPF :'+FGeral.Formatacpf(QClientes.Fieldbyname('clie_cnpjcpf').Asstring)
                    ,false,False,comprimidotitulo);
  FTextRel.AddTitulo('Bairro.......: '+strspace(QClientes.Fieldbyname('clie_bairrores').Asstring,40)
                    ,false,False,comprimidotitulo);
  FTextRel.AddTitulo('Cep/Cidade/UF: '+FGeral.formatacep(QClientes.Fieldbyname('clie_cepres').Asstring)+' - '+
                    strspace(Arq.TMunicipios.Fieldbyname('cida_nome').Asstring,15)+' - '+
                    strspace(Arq.TMunicipios.Fieldbyname('cida_uf').Asstring,02)
                    ,false,False,comprimidotitulo);
  FTextRel.AddTitulo(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
//  FTextRel.SaltaLinha(2);
  if ImpressoraHP then begin
    if Global.Topicos[1049] then
      FTextRel.AddTitulo(space(02)+'Codigo'+space(07)+'Qtde'+space(1)+'Tam'+' Devol'+space(2)+'Descri��o'+space(21)+
                     'PC Vendidas'+space(01)+'Unit�rio'+space(01)+'Total R$'
                    ,false,False,true)
    else
      FTextRel.AddTitulo(space(04)+'Codigo'+space(07)+'Qtde'+space(3)+'Devol'+space(2)+'Descri��o'+space(25)+'PC Vendidas'+
                     space(01)+'Unitario'+space(01)+'Total R$ Desc.'
                    ,false,False,true);

  end else
     FTextRel.AddTitulo(space(04)+'Codigo'+space(07)+'Quantidade'+space(1)+'Devolucao'+space(1)+'Descricao'+space(35)+'Pe�as Vendidas'+
                    space(01)+'Vlr. Unitario'+space(01)+'Total R$ Desc.'
                    ,false,False,true);

  FTextRel.AddTitulo(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
  tqtde:=0;titem:=0;
  if Arq.TTabelaPreco.Locate('tabp_codigo',QBusca.Fieldbyname('Moes_tabp_codigo').AsInteger,[]) then begin
    descacre:=Arq.TTabelaPreco.Fieldbyname('tabp_tipo').AsString;
  end else
    descacre:='';
  valorbruto:=0;

  while not QBusca.Eof do begin

    produto:=Qbusca.fieldbyname('move_esto_codigo').asstring;
    qtde:=0;
    venda:=QBusca.Fieldbyname('Move_venda').AsCurrency;
// 03.04.08 - ativado aqui o 'esquema' joacir+cacio de 27.01.06
// 26.09.11 - desativado 'por Janina'
    if pos(QClientes.fieldbyname('clie_uf').asstring,Global.UfComSubstituicao)>0 then
      venda:=FEstoque.GetPreco(QBusca.fieldbyname('Move_esto_codigo').AsString,QBusca.fieldbyname('move_unid_codigo').asstring,
//                                        Qclientes.fieldbyname('clie_uf').asstring,17,   // pois na RC nao tem aliquota
                                        Qclientes.fieldbyname('clie_uf').asstring,QBusca.fieldbyname('move_aliicms').AsCurrency,
                                        Qclientes.fieldbyname('clie_tipo').asstring,
                                        QBusca.fieldbyname('move_venda').AsCurrency);

    if not Global.Topicos[1049] then begin

        while ( not QBusca.Eof ) and (produto=Qbusca.fieldbyname('move_esto_codigo').asstring) do begin

          qtde:=qtde+QBusca.Fieldbyname('Move_qtde').AsCurrency;
          tqtde:=tqtde+QBusca.Fieldbyname('Move_qtde').AsCurrency;
          if pos(QClientes.fieldbyname('clie_uf').asstring,Global.UfComSubstituicao)>0 then
    // 26.09.11 - desativado 'por Janina'
            valorbruto:=valorbruto+(QBusca.Fieldbyname('Move_qtde').AsCurrency*venda)
          else
            valorbruto:=valorbruto+(QBusca.Fieldbyname('Move_qtde').AsCurrency*QBusca.Fieldbyname('Move_vendabru').AsCurrency);
          QBusca.next;

        end;

    end;

    if ImpressoraHP then begin

      if Global.Topicos[1049] then begin

          FTextRel.AddLinha(space(01)+strspace(QBusca.Fieldbyname('Move_esto_codigo').AsString,10)+space(01)+
                    FGeral.Formatavalor(QBusca.Fieldbyname('Move_qtde').AsCurrency,'####0')+space(01)+FTamanhos.GetReduzido(Qbusca.FieldByName('move_tama_codigo').AsInteger)+
                    replicate('_',06)+space(01)+strspace(FEstoque.GetDescricao(Qbusca.fieldbyname('move_esto_codigo').asstring),29)+
                    space(02)+replicate('_',06)+space(01)+FGeral.Formatavalor(QBusca.Fieldbyname('Move_venda').AsCurrency,f_cr)+space(01)+replicate('_',06)
                    ,false,False,true);
          qtde:=qtde+QBusca.Fieldbyname('Move_qtde').AsCurrency;
          tqtde:=tqtde+QBusca.Fieldbyname('Move_qtde').AsCurrency;
          valorbruto:=valorbruto+(QBusca.Fieldbyname('Move_qtde').AsCurrency*QBusca.Fieldbyname('Move_venda').AsCurrency);
          QBusca.Next;

      end else begin

        FTextRel.AddLinha(space(01)+strspace(produto,10)+space(01)+
                    FGeral.Formatavalor(qtde,'###,##0')+space(01)+
                    replicate('_',06)+space(01)+strspace(FEstoque.GetDescricao(produto),29)+
                    space(02)+replicate('_',06)+space(01)+FGeral.Formatavalor(venda,f_cr)+space(01)+replicate('_',06)
                    ,false,False,true);
// 03.09.2021 - Hardsoul -> 'denim'
//         QBusca.Next;
// 10.09.2021 - aqui nao precisa poir j� tem o next acima na while do codigo do produto

      end;

    end else begin

         FTextRel.AddLinha(space(04)+strspace(produto,13)+space(03)+
                    FGeral.Formatavalor(qtde,'###,##0.000')+space(02)+
                    replicate('_',10)+space(02)+strspace(FEstoque.GetDescricao(produto),45)+
                    space(02)+replicate('_',10)+space(02)+FGeral.Formatavalor(venda,f_cr)+space(02)+replicate('_',10)
                    ,false,False,true);
// 03.09.2021 - 10.09.2021
         if Global.Topicos[1049] then

            QBusca.Next;

    end;
    inc(titem);

  end;

  QBusca.First;
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda-2),false,False,false);
//  tdescacre:=FGeral.Arredonda(QBusca.fieldbyname('moes_vlrtotal').AsCurrency*(QBusca.fieldbyname('moes_tabaliquota').AsCurrency/100) ,2);
  tdescacre:=FGeral.Arredonda(valorbruto-QBusca.fieldbyname('moes_vlrtotal').AsCurrency ,2);
  if tdescacre>0 then
    FTextRel.AddLinha(space(39)+'Total Mercadorias....: R$ '+FGeral.Formatavalor(valorbruto,'###,##0.00'),false,False,false)
  else
    FTextRel.AddLinha(space(39)+'Total Mercadorias....: R$ '+FGeral.Formatavalor(QBusca.fieldbyname('moes_vlrtotal').AsCurrency,'###,##0.00'),false,False,false);
  liquido:=valorbruto;
  if descacre='D' then begin
    FTextRel.AddLinha(space(39)+'Desconto sobre total.: R$ '+FGeral.Formatavalor(tdescacre,'###,##0.00'),false,False,false);
    liquido:=QBusca.fieldbyname('moes_vlrtotal').AsCurrency;   //-tdescacre;
  end else if descacre='A' then begin
    liquido:=QBusca.fieldbyname('moes_vlrtotal').AsCurrency;  // +tdescacre;
//    FTextRel.AddLinha(space(39)+'Acr�scimo sobre total: R$ '+FGeral.Formatavalor(tdescacre,'###,##0.00'),false,False,false);
// 24.08.05
  end;
  if tdescacre>0 then
    FTextRel.AddLinha(space(39)+'Total liquido........: R$ '+FGeral.Formatavalor(liquido,'###,##0.00'),false,False,false);

//  FTextRel.AddLinha(space(39)+'Total em Quantidade..:    '+FGeral.Formatavalor(tqtde,'###,##0.000'),false,False,false);
  FTextRel.AddLinha(strzero(QBusca.fieldbyname('moes_usua_codigo').asinteger,4)+' - '+strspace(FUsuarios.getnome(QBusca.fieldbyname('moes_usua_codigo').asinteger),32)+'Total em Quantidade..:    '+FGeral.Formatavalor(tqtde,'###,##0.000'),false,False,false);
  FTextRel.AddLinha(space(39)+'Total de Itens.......:    '+FGeral.Formatavalor(titem,'####'),false,False,false);
  FTextRel.SaltaLinha(2);
  FTextRel.AddLinha('Data para acerto : '+formatdatetime('dd/mm/yy',QBusca.fieldbyname('moes_dataemissao').AsDateTime+30)+
                    space(06)+'Data segunda visita ____/____/____',false,False,false);
  FTextRel.AddLinha(Replicate('-',largura-FTextRel.MargemEsquerda),false,False,false);
  FTextRel.AddLinha(space(50)+QBusca.fieldbyname('moes_numerodoc').Asstring+' - '+QBusca.fieldbyname('moes_status').Asstring,false,False,false);
  FTextRel.SaltaLinha(1);
  FTextRel.AddLinha('Declaro que recebi as mercadorias acima discriminadas : '+
                    replicate('_',21),false,False,false);
  FTextRel.SaltaLinha(1);
  if QBusca.fieldbyname('moes_rcmagazine').asstring='S' then
    FTextRel.AddLinha(Arq.TUnidades.fieldbyname('unid_mensremessam').asstring,false,False,false)
  else
    FTextRel.AddLinha(Arq.TUnidades.fieldbyname('unid_mensremessa').asstring,false,False,false);
  if semvideo='N' then
    FTextRel.Video('',9)   // de 6 para 10 para 9 - janina 20.09.17
  else begin
//    FGeral.Imprimesemvideo(FTextrel.PaginaAtual);
    if Global.topicos[1030] then
// 03.09.12 - Vivan - Lindacir - '2 vias'
      FGeral.Imprimesemvideo( 2 )
    else
      FGeral.Imprimesemvideo( 1 );
  end;
  Sistema.EndProcess('');
  QBusca.close;
  Freeandnil(QBusca);

end;

procedure TFRemessa.bDevolucaoClick(Sender: TObject);
/////////////////////////////////////////////////////////
var codigoestoque:string;
//    qtde:currency;
    Q:TSqlquery;
begin
  if EdRepr_codigo.AsInteger=0 then exit;
  if trim(Grid.Cells[0,Grid.row])='' then exit;
  codigoestoque:=Grid.Cells[0,Grid.row];
  Q:=Sqltoquery('select move_status from movestoque where move_status=''N'''+
          ' and move_numerodoc='+EdNumerodoc.AsSql+
          ' and move_tipomov='+Stringtosql(Global.CodDevolucaoConsig)+
          ' and move_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and move_tipo_codigo='+EdCliente.AsSql+
          ' and move_esto_codigo='+Stringtosql(codigoestoque)+
          ' and move_tipocad='+Stringtosql('C') );
  if not Q.Eof then begin
      Avisoerro('Produto j� devolvido nesta remessa de consigna��o');
      exit;
  end;
  if confirma('Confirma devolu��o ?') then begin
//    qtde:=texttovalor(Grid.Cells[2,Grid.row]);
////    Calculatotal(Edtotalremessa);
////    ReservaEstoque(Codigoestoque,'E',qtde);
    if Q.Eof then begin
      GravaItemDevolucao;
      Grid.DeleteRow(Grid.Row);
      Sistema.Commit;
    end;
    Q.free;
  end;

end;

procedure TFRemessa.GravaItemDevolucao;
var codigograde,codigolinha,codigocoluna:integer;
    codigoestoque:string;
    qtde,venda,totaldevolucao,vlr,qtd:currency;
    Q,QEstQtde:TSqlquery;
begin
    Q:=Sqltoquery('select move_venda,move_qtde from movestoque where move_status=''N'''+
          ' and move_numerodoc='+EdNumerodoc.AsSql+
          ' and move_tipomov='+Stringtosql(Global.CodDevolucaoConsig)+
          ' and move_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and move_tipo_codigo='+EdCliente.AsSql+
          ' and move_tipocad='+Stringtosql('C') );
    totaldevolucao:=0;
    while not Q.Eof do begin
      vlr:=Q.fieldbyname('move_qtde').AsCurrency;
      qtd:=Q.fieldbyname('move_venda').AsCurrency;
      totaldevolucao:=totaldevolucao+FGeral.Arredonda(vlr*qtd,2);
      Q.Next;
    end;
    codigoestoque:=Grid.Cells[Grid.getcolumn('move_esto_codigo'),Grid.row];
    codigograde:=FEstoque.GetCodigoGrade(EdProduto.Text);
    qtde:=texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),Grid.row]);
    venda:=texttovalor(Grid.Cells[Grid.getcolumn('move_venda'),Grid.row]);
    totaldevolucao:=totaldevolucao+FGeral.Arredonda(venda*qtde,2);
    Transacao:=FGeral.GetTransacao;
    FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
             Global.CodDevolucaoConsig,Transacao,EdNumerodoc.AsInteger,TotalDevolucao,EdMoes_Tabp_codigo.AsInteger,'A',magazinex);
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',codigoestoque);
{
      codigolinha:=FEstoque.GetCodigoLinha(codigoestoque,codigograde);
      codigocoluna:=FEstoque.GetCodigoColuna(codigoestoque,codigograde);
      Arq.TEstoque.Locate('esto_codigo',codigoestoque,[]);
      if FGrades.Getcodigolinha(codigograde)=1 then // tamanho
        Sistema.SetField('move_tama_codigo',codigolinha)
      else
        Sistema.SetField('move_core_codigo',codigolinha);
      if FGrades.GetcodigoColuna(codigograde)=1 then // tamanho
        Sistema.SetField('move_tama_codigo',codigocoluna)
      else
        Sistema.SetField('move_core_codigo',codigocoluna);
}
// 24.08.06
      Sistema.SetField('move_core_codigo',Edcodcor.asinteger);
      Sistema.SetField('move_tama_codigo',Edcodtamanho.asinteger);
      Sistema.SetField('move_copa_codigo',Edcodcopa.asinteger);

      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',Ednumerodoc.Asinteger);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',Global.CodDevolucaoConsig);
      Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('move_tipo_codigo',EdCliente.AsInteger);
      Sistema.SetField('move_tipocad','C');
      Sistema.SetField('move_repr_codigo',EdRepr_codigo.AsInteger);
      Sistema.SetField('move_qtde',Qtde);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',EdDtEmissao.AsDate);
      Sistema.SetField('move_qtderetorno',0);
      Sistema.SetField('move_venda',Venda);
      Sistema.SetField('move_grup_codigo',Arq.TEstoque.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',Arq.TEstoque.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',Arq.TEstoque.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.Setfield('move_remessas',strzero(EdNumerodoc.asinteger,8));
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.Post('');

      Sistema.Edit('MovEstoque');
      Sistema.SetField('move_qtderetorno',Qtde);
      Sistema.Post('move_numerodoc='+EdNumerodoc.AsSql+' and move_tipomov='+stringtosql(Global.CodRemessaConsig)+
                   'and move_esto_codigo='+stringtosql(codigoestoque)+
                   'and move_tipo_codigo='+EdCliente.AsSql+
                   'and move_unid_codigo='+stringtosql(EdUnid_codigo.text));

      Sistema.Commit;

    QEstQtde:=Sqltoquery(FGeral.BuscaQTdeItemEstoque(Codigoestoque,EdUnid_codigo.text));
    if not QEstQtde.Eof then
      FGeral.MovimentaQtdeEstoque(codigoestoque,EdUnid_codigo.text,'E',Global.CodRemessaConsig,Qtde,QEstqtde);
    QEstQtde.Free;Q.free;
end;


procedure TFRemessa.EdMoes_tabp_codigoValidate(Sender: TObject);
begin
  if EdMoes_tabp_codigo.asinteger>0 then begin
    if Arq.TTabelaPreco.Locate('tabp_codigo',EdMoes_tabp_codigo.AsInteger,[]) then begin
      SetEdTabp_aliquota.Text:=FTabela.GetDescAliquota(EdMoes_tabp_codigo.asinteger);
      perc:=FTabela.GetAliquota(EdMoes_tabp_codigo.AsInteger);
    end else begin
      SetEdTabp_aliquota.Text:='';
      EdMoes_tabp_codigo.Invalid('Tabela n�o encontrada');
    end;
  end else begin
    SetEdTabp_aliquota.Text:='';
    perc:=0;
  end;
//  bIncluiritemClick(FRemessa);
end;

procedure TFRemessa.EdDtemissaoValidate(Sender: TObject);
begin
  if not FGeral.ValidaMvto(EdDtemissao) then
    EdDtemissao.Invalid('');
end;

procedure TFRemessa.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var QMestre:TSqlquery;
begin
  if (EdCliente.AsInteger>0) and (EdRepr_codigo.AsInteger>0) then begin
    if OP='I' then begin
      QMestre:=Sqltoquery('select moes_status from movesto where moes_status=''N'''+
          ' and moes_tipomov='+Stringtosql(Global.CodRemessaConsig)+
          ' and moes_unid_codigo='+Stringtosql(EdUnid_codigo.text)+
          ' and moes_tipo_codigo='+EDCliente.AsSql+
          ' and moes_datamvto='+EdDtEmissao.AsSql+
          ' and moes_tipocad='+Stringtosql('C') );
      if QMestre.Eof then begin
        if Confirma('� prov�vel que este documento ainda n�o foi gravado.  Gravar ?') then
          bgravarclick(Self);
      end;
      RetornaReserva;
    end else if TotalRemessa<>EdTotalremessa.AsCurrency then begin
      FGeral.GravaMestreConsignacao(EdDtEmissao.AsDate,EdCliente,EdRepr_codigo.AsInteger,EdUnid_codigo.text,
             Global.CodRemessaConsig,Transacao,EdNumerodoc.AsInteger,EdTotalRemessa.AsCurrency,EdMoes_Tabp_codigo.AsInteger,Op,magazinex);
      Sistema.Commit;
    end;
  end;

  if ListaReservaCodigo<>nil then ListaReservaCodigo.Free;
  if ListaReservaQtde<>nil then ListaReservaQtde.Free;
  Global.UltimoFormAberto:='';
  
end;

procedure TFRemessa.EdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then begin
    bcancelaritemclick(FRemessa);
    bgravarclick(FRemessa);
  end;
end;

function TFRemessa.CalculaTotalQtde: currency;
var p:integer;
    vlrtotal:currency;
begin
  vlrtotal:=0;
  for p:=1 to Grid.RowCount do begin
    vlrtotal:=vlrtotal+FGeral.Arredonda(texttovalor(Grid.Cells[Grid.getcolumn('move_qtde'),p]),2);
  end;
  result:=vlrtotal;
end;

procedure TFRemessa.EdCodtamanhoValidate(Sender: TObject);
var x:integer;
begin
   if not FGeral.ValidaGrade(EdCodcor.asinteger,EdCodtamanho.asinteger,0,EdProduto.text,'cor;tamanho') then
     EdCodtamanho.invalid('')
   else begin
      if op='A' then begin
    //      x:=ProcuraGrid(0,EdProduto.Text);
          x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.GetColumn('codtamanho'),Edcodtamanho.asinteger,
                            Grid.getcolumn('codcor'),EdCodcor.asinteger,Grid.getcolumn('codcopa'),EdCodcopa.asinteger);
          if x>0 then
            Edcodtamanho.Invalid('Produto j� existente.   Excluir e incluir.');
      end;
   end;

end;

procedure TFRemessa.EdCodcopaValidate(Sender: TObject);
var x:integer;
begin
   if not FGeral.ValidaGrade(EdCodcor.asinteger,EdCodtamanho.asinteger,EdCodcopa.asinteger,EdProduto.text,'cor;tamanho;copa') then
     EdCodcopa.invalid('')
   else begin
      if op='A' then begin
    //      x:=ProcuraGrid(0,EdProduto.Text);
          x:=FGeral.ProcuraGrid(Grid.getcolumn('move_esto_codigo'),EdProduto.Text,Grid,Grid.GetColumn('codtamanho'),Edcodtamanho.asinteger,
                            Grid.getcolumn('codcor'),EdCodcor.asinteger,Grid.getcolumn('codcopa'),EdCodcopa.asinteger);
          if x>0 then
            Edcodcopa.Invalid('Produto j� existente.   Excluir e incluir.');
      end;
   end;

end;

procedure TFRemessa.EdMoes_tabp_codigoExitEdit(Sender: TObject);
begin
  bIncluiritemClick(FRemessa);

end;

// 15.07.13
function TFRemessa.ValidaRemessas: boolean;
///////////////////////////////////////////////
var campo:TDicionario;
begin
   result:=true;
// 15.07.13 - Vivan
   campo:=Sistema.GetDicionario('clientes','clie_tiposremessas');
   if (EdCliente.ResultFind<>nil) and (campo.Tipo<>'') then begin
     if trim(EdCliente.ResultFind.fieldbyname('clie_tiposremessas').asstring)<>'' then begin
       if (magazinex='N') and (pos('RC',EdCliente.ResultFind.fieldbyname('clie_tiposremessas').asstring)=0) then begin
         Avisoerro('Cliente sem permiss�o para Remessa de consigna��o');
         result:=false;
       end else if (magazinex='S') and (pos('RM',EdCliente.ResultFind.fieldbyname('clie_tiposremessas').asstring)=0) then begin
         Avisoerro('Cliente sem permiss�o para Remessa Magazine');
         result:=false;
       end else if (magazinex='T') and (pos('TC',EdCliente.ResultFind.fieldbyname('clie_tiposremessas').asstring)=0) then begin
         Avisoerro('Cliente sem permiss�o para Troca de Cr�dito');
         result:=false;
       end else if (magazinex='G') and (pos('CG',EdCliente.ResultFind.fieldbyname('clie_tiposremessas').asstring)=0) then begin
         Avisoerro('Cliente sem permiss�o para Compra Garantida');
         result:=false;
       end;
     end;
   end;
end;

end.
