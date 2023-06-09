unit transfes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, SQLEd, Buttons, SQLBtn, SQLGrid,
  ExtCtrls;

type
  TFTransSaldos = class(TForm)
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
    EdEsto_grup_codigo: TSQLEd;
    SetEdgrup_codigo: TSQLEd;
    EdEstoquefora: TSQLEd;
    procedure FormActivate(Sender: TObject);
    procedure EdmesanoValidate(Sender: TObject);
    procedure bExecutarClick(Sender: TObject);
    procedure EdUnid_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdProdutoValidate(Sender: TObject);
    procedure EdEstoqueforaExitEdit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure ChecaTransferenciaMensal;

  end;


type TSaldos=record
     produto,balanco,atualizacustos:string;
     qtde,qtdeprev,aqtde,aqtdeprev,entradas,saidas,custo,custoger,customedio,customeger,venda,aqtdeconsig,aqtdepronta,aqtderegesp,
     qtdeconsig,qtdepronta,qtderegesp,pecas,apecas,qtdeprocesso,aqtdeprocesso:currency;
end;

type TSaldosGrade=record
     produto,balanco,atualizacustos:string;
     codcor,codtamanho,codcopa:integer;
     qtde,qtdeprev,aqtde,aqtdeprev,entradas,saidas,custo,custoger,customedio,customeger,venda,aqtdeconsig,aqtdepronta,aqtderegesp,
     qtdeconsig,qtdepronta,qtderegesp,qtdeprocesso,aqtdeprocesso:currency;
end;


var
  FTransSaldos: TFTransSaldos;
  PSaldos:^TSaldos;
  ListaSaldos:Tlist;
  PSaldosGrade:^TSaldosGrade;
  ListaSaldosGrade:Tlist;

implementation

uses Geral, SqlFun, Arquiv, SqlSis, SqlExpr, tamanhos;

{$R *.dfm}

procedure TFTransSaldos.Execute;
begin
  if FTransSaldos=nil then FGeral.CreateForm(TFTransSaldos,FTransSaldos);
  if FTransSaldos.Edmesano.isempty then
    FTransSaldos.Edmesano.Text := strzero(DateTomes(Sistema.Hoje),2)+Inttostr(Datetoano(Sistema.Hoje,true));
  FTransSaldos.Show;

end;

procedure TFTransSaldos.FormActivate(Sender: TObject);
begin
  if EdUnid_codigo.isempty then
    EdUnid_codigo.Text:=Global.CodigoUnidade;
  FTransSaldos.Edmesano.SetFocus;

end;

procedure TFTransSaldos.EdmesanoValidate(Sender: TObject);
begin
   if FGeral.Validamesano(edmesano.text) then begin
     if not FGeral.Validaperiodo(edmesano.text) then
       Edmesano.Invalid('');
   end else begin
       Edmesano.Invalid('');
   end;

end;

///////////////////////////////////////////////////////////////
procedure TFTransSaldos.bExecutarClick(Sender: TObject);
/////////////////////////////////////////////////////////////////////////////
type TCamaraFria=record
     codigo  : string;
     qtde,
     qtds,
     saldoa,saldo   :currency;
end;

var Q,QSaldoanterior,Salestoque,QGrupo,QSaldoAnteriorGrade:TSqlquery;
    QSalestoque:TMemoryquery;
    p,mes,ano,tamanho,cor:integer;
    saldoanterior         :currency;
    produto,mesanoant,sqlsaldoant,sqlmovimento,sqlgrupo,sqlgruposaldoant,sqlgrupomovimento,ProdutosGrupo,
    Tiposacertos,sqlsalestoqueproduto,sqlsaldoantgrade,sqlgruposaldoantgrade,campos:string;
    ultimadatadomes:TDatetime;
    ListaCamaraFria:TList;
    PCamaraFria    :^TCamaraFria;


    procedure AtualizaLista(produto:string ; qtde,qtdeprev,estoque,pecas,estoquepecas,qtdeprocesso:currency ;tipomov:string);
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var p:integer;
        tiposestoquevirtual:string;
    begin
       tiposestoquevirtual:=global.CodRemessaConsig+';'+Global.CodRemessaProntaEntrega+';'+Global.CodVendaSerie4+';'+
                            Global.CodDevolucaoConsig+';'+Global.CodDevolucaoProntaEntrega+';'+Global.CodDevolucaoSerie5+';'+
                            Global.CodVendaProntaEntrega+';'+Global.CodVendaRE+';'+Global.CodVendaREBrinde;
// 20.07.09 - retirado
//+';'+Global.CodVendaBrinde

/////////////////////////////////////////////////////////////////////////////////
// 06.03.06
      if ( pos(Tipomov,tiposestoquevirtual)>0 ) and (Q.fieldbyname('move_status').asstring='N') then begin
// consignado
              if Tipomov=Global.CodRemessaConsig then
                PSaldos.qtdeconsig:=PSaldos.qtdeconsig+qtde
              else if Tipomov=Global.CodDevolucaoConsig then
                PSaldos.qtdeconsig:=PSaldos.qtdeconsig-qtde
              else if Tipomov=Global.CodDevolucaoTroca then
                PSaldos.qtdeconsig:=PSaldos.qtdeconsig-qtde
// pronta entrega
              else if Tipomov=Global.CodRemessaProntaEntrega then
                PSaldos.qtdepronta:=PSaldos.qtdepronta+qtde
              else if Tipomov=Global.CodDevolucaoProntaEntrega then
                PSaldos.qtdepronta:=PSaldos.qtdepronta-qtde
              else if Tipomov=Global.CodVendaProntaEntrega then
                PSaldos.qtdepronta:=PSaldos.qtdepronta-qtde
              else if Tipomov=Global.CodVendaBrinde then
                PSaldos.qtdepronta:=PSaldos.qtdepronta-qtde
// regime especial
              else if Tipomov=Global.CodVendaSerie4 then
                PSaldos.qtderegesp:=PSaldos.qtderegesp+qtde
              else if Tipomov=Global.CodDevolucaoSerie5 then
                PSaldos.qtderegesp:=PSaldos.qtderegesp-qtde
              else if Tipomov=Global.CodVendaProntaEntrega then
                PSaldos.qtderegesp:=PSaldos.qtderegesp-qtde
              else if Tipomov=Global.CodVendaBrinde then
                PSaldos.qtderegesp:=PSaldos.qtderegesp-qtde;


      end;
/////////////////////////////////////////////////////////////////////////////////
// 19.10.09 - Movimentacao estoque em processo
      if pos(Tipomov,Global.TipoEstoqueEmProcesso)>0 then begin
        for p:=0 to ListaSAldos.Count-1 do begin
          PSaldos:=Listasaldos[p];
          if Psaldos.produto=produto then begin
              if pos(Tipomov,Global.CodContagemBalancoE+';'+Global.CodContagemBalancoS)>0 then begin
                PSaldos.qtdeprocesso:=qtdeprocesso;
              end else if pos(Tipomov,Global.TiposEntrada)>0 then begin
                PSaldos.qtdeprocesso:=PSaldos.qtdeprocesso+qtdeprocesso;
              end else begin
                PSaldos.qtdeprocesso:=PSaldos.qtdeprocesso-qtdeprocesso;
              end;
            break;
          end;
        end;
      end;
///////////////////////////////////////////////////////


      if pos(Tipomov,Global.TiposMovMovEstoque)>0 then begin
        for p:=0 to ListaSAldos.Count-1 do begin
          PSaldos:=Listasaldos[p];
          if Psaldos.produto=produto then begin

// 28.11.05 - criado tipos BE e BS para contagem de balan�o
              if pos(Tipomov,Global.CodContagemBalancoE+';'+Global.CodContagemBalancoS)>0 then begin
                PSaldos.qtde:=estoque;
                PSaldos.qtdeprev:=estoque;
                PSaldos.balanco:='S';
                PSaldos.pecas:=estoquepecas;
              end else if pos(Tipomov,Global.TiposMovMovEntrada)>0 then begin
// 29.02.12 - considerando a embalagem do cadastro
                if (Q.fieldbyname('esto_embalagem').AsInteger>=1) and ( pos(Tipomov,Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai)=0 ) then begin
// 05.09.12
                  if (Global.Topicos[1356]) and (Q.fieldbyname('move_embalagem').AsInteger>0) then begin
                    qtde:=qtde*Q.fieldbyname('move_embalagem').AsInteger;
                    qtdeprev:=qtdeprev*Q.fieldbyname('move_embalagem').AsInteger;
                  end else begin
                    qtde:=qtde*Q.fieldbyname('esto_embalagem').AsInteger;
                    qtdeprev:=qtdeprev*Q.fieldbyname('esto_embalagem').AsInteger;
                  end;
                end;
                PSaldos.entradas:=PSaldos.entradas+qtde;
                PSaldos.qtde:=psaldos.qtde+qtde;
                PSaldos.qtdeprev:=psaldos.qtdeprev+qtde;
                PSaldos.pecas:=psaldos.pecas+pecas;
                if Q.fieldbyname('move_custo').ascurrency>0 then
                  PSaldos.custo:=Q.fieldbyname('move_custo').ascurrency;
                if Q.fieldbyname('move_customedio').ascurrency>0 then
                  PSaldos.custo:=Q.fieldbyname('move_customedio').ascurrency;
                if Q.fieldbyname('move_custoger').ascurrency>0 then
                  PSaldos.custo:=Q.fieldbyname('move_custoger').ascurrency;
                if Q.fieldbyname('move_customeger').ascurrency>0 then
                  PSaldos.custo:=Q.fieldbyname('move_customeger').ascurrency;
                if Q.fieldbyname('move_venda').ascurrency>0 then
                  PSaldos.custo:=Q.fieldbyname('move_venda').ascurrency;
              end else begin
// 14.04.15 - Devereda
///////////////////////
                    if (Global.Topicos[1382]) and (Q.fieldbyname('move_tama_codigo').asinteger>0) then begin
                      qtde:=qtde*FTamanhos.GetComprimento(Q.fieldbyname('move_tama_codigo').asinteger);
                      qtdeprev:=qtdeprev*FTamanhos.GetComprimento(Q.fieldbyname('move_tama_codigo').asinteger);
                    end else begin
                      qtde:=qtde*1;
                      qtdeprev:=qtdeprev*1;
                    end;
///////////////////////
                PSaldos.saidas:=PSaldos.saidas+qtde;
                PSaldos.qtde:=psaldos.qtde-qtde;
                PSaldos.qtdeprev:=psaldos.qtdeprev-qtde;
                PSaldos.pecas:=psaldos.pecas-pecas;
              end;
// 01.04.05 - considerar acertos como movimenta��o normal
//            if pos(Tipomov,Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai)>0 then begin
//              PSaldos.qtde:=estoque;
//              PSaldos.qtdeprev:=estoque;
//            end;
//              PSaldos.qtde:=psaldos.aqtde+psaldos.entradas-psaldos.saidas;
//              PSaldos.qtdeprev:=psaldos.aqtdeprev+psaldos.entradas-psaldos.saidas;

            break;
          end;
        end;
      end;
    end;


//////////////////////////////////// - 11.09.06
    procedure AtualizaListaGrade(produto:string ; qtde,qtdeprev,estoque,qtdeprocesso:currency ;tipomov:string ; codcor,codtamanho,codcopa:integer );
    /////////////////////////////////////////////////////////////////////////////////////
    var p:integer;
        tiposestoquevirtual:string;
    begin
       tiposestoquevirtual:=global.CodRemessaConsig+';'+Global.CodRemessaProntaEntrega+';'+Global.CodVendaSerie4+';'+
                            Global.CodDevolucaoConsig+';'+Global.CodDevolucaoProntaEntrega+';'+Global.CodDevolucaoSerie5+';'+
                            Global.CodVendaProntaEntrega+';'+Global.CodVendaRE+';'+Global.CodVendaREBrinde;
// 20.07.09 - retirado
//+';'+Global.CodVendaBrinde

      if ( pos(Tipomov,tiposestoquevirtual)>0 ) and (Q.fieldbyname('move_status').asstring='N') then begin
// consignado
              if Tipomov=Global.CodRemessaConsig then
                PSaldosGrade.qtdeconsig:=PSaldosGrade.qtdeconsig+qtde
              else if Tipomov=Global.CodDevolucaoConsig then
                PSaldosGrade.qtdeconsig:=PSaldosGrade.qtdeconsig-qtde
              else if Tipomov=Global.CodDevolucaoTroca then
                PSaldosGrade.qtdeconsig:=PSaldosGrade.qtdeconsig-qtde
// pronta entrega
              else if Tipomov=Global.CodRemessaProntaEntrega then
                PSaldosGrade.qtdepronta:=PSaldosGrade.qtdepronta+qtde
              else if Tipomov=Global.CodDevolucaoProntaEntrega then
                PSaldosGrade.qtdepronta:=PSaldosGrade.qtdepronta-qtde
              else if Tipomov=Global.CodVendaProntaEntrega then
                PSaldosGrade.qtdepronta:=PSaldosGrade.qtdepronta-qtde
//              else if Tipomov=Global.CodVendaBrinde then
//                PSaldosGrade.qtdepronta:=PSaldosGrade.qtdepronta-qtde
// regime especial
              else if Tipomov=Global.CodVendaSerie4 then
                PSaldosGrade.qtderegesp:=PSaldosGrade.qtderegesp+qtde
              else if Tipomov=Global.CodDevolucaoSerie5 then
                PSaldosGrade.qtderegesp:=PSaldosGrade.qtderegesp-qtde
              else if Tipomov=Global.CodVendaProntaEntrega then
                PSaldosGrade.qtderegesp:=PSaldosGrade.qtderegesp-qtde
              else if Tipomov=Global.CodVendaBrinde then
                PSaldosGrade.qtderegesp:=PSaldosGrade.qtderegesp-qtde;

      end;


/////////////////////////////////////////////////////////////////////////////////
// 19.10.09 - Movimentacao estoque em processo na grade
      if pos(Tipomov,Global.TipoEstoqueEmProcesso)>0 then begin
//        for p:=0 to ListaSAldos.Count-1 do begin
// 05.04.10
        for p:=0 to ListaSAldosGrade.Count-1 do begin
//          PSaldos:=Listasaldos[p];
          PSaldosGrade:=Listasaldos[p];
          if PsaldosGrade.produto=produto then begin
              if pos(Tipomov,Global.CodContagemBalancoE+';'+Global.CodContagemBalancoS)>0 then begin
                PSaldosGrade.qtdeprocesso:=qtdeprocesso;
              end else if pos(Tipomov,Global.TiposEntrada)>0 then begin
                PSaldosGrade.qtdeprocesso:=PSaldosGrade.qtdeprocesso+qtdeprocesso;
              end else begin
                PSaldosGrade.qtdeprocesso:=PSaldosGrade.qtdeprocesso-qtdeprocesso;
              end;
            break;
          end;
        end;
      end;
///////////////////////////////////////////////////////

      if pos(Tipomov,Global.TiposMovMovEstoque)>0 then begin
        for p:=0 to ListaSAldosGrade.Count-1 do begin
          PSaldosGrade:=ListasaldosGrade[p];
          if (PsaldosGrade.produto=produto) and (PsaldosGrade.codcor=codcor) and (PsaldosGrade.codtamanho=codtamanho)
//             and (PsaldosGrade.codcopa=codcopa)
// 27.04.17
              then begin
              if pos(Tipomov,Global.CodContagemBalancoE+';'+Global.CodContagemBalancoS)>0 then begin
                PSaldosGrade.qtde:=estoque;
                PSaldosGrade.qtdeprev:=estoque;
                PSaldosGrade.balanco:='S';
              end else if pos(Tipomov,Global.TiposMovMovEntrada)>0 then begin
                PSaldosGrade.entradas:=PSaldos.entradas+qtde;
                PSaldosGrade.qtde:=psaldosGrade.qtde+qtde;
                PSaldosGrade.qtdeprev:=psaldosGrade.qtdeprev+qtde;
                if Q.fieldbyname('move_custo').ascurrency>0 then
                  PSaldosGrade.custo:=Q.fieldbyname('move_custo').ascurrency;
                if Q.fieldbyname('move_customedio').ascurrency>0 then
                  PSaldosGrade.custo:=Q.fieldbyname('move_customedio').ascurrency;
                if Q.fieldbyname('move_custoger').ascurrency>0 then
                  PSaldosGrade.custo:=Q.fieldbyname('move_custoger').ascurrency;
                if Q.fieldbyname('move_customeger').ascurrency>0 then
                  PSaldosGrade.custo:=Q.fieldbyname('move_customeger').ascurrency;
                if Q.fieldbyname('move_venda').ascurrency>0 then
                  PSaldosGrade.custo:=Q.fieldbyname('move_venda').ascurrency;
              end else begin
                PSaldosGrade.saidas:=PSaldosGrade.saidas+qtde;
                PSaldosGrade.qtde:=psaldosGrade.qtde-qtde;
                PSaldosGrade.qtdeprev:=psaldosGrade.qtdeprev-qtde;
              end;
        // 27.04.17
//////////            break;
          end;
        end;
      end;

    end;

////////////////////////////////////

/// 23.06.06
    function TemnoQSalestoque(produto:string):string;
    ///////////////////////////////////////////////////
    begin
      result:='N';
      QSalestoque.first;
      while not QSalestoque.eof do begin
        if QSalestoque.fieldbyname('saes_esto_codigo').asstring=produto then begin
          result:='S';
          break;
        end;
        QSalEstoque.next;
      end;
    end;

/// 11.09.06
    function TemnoQSalestoqueGrade(produto:string ; codcor,codtamanho,codcopa:integer):string;
    /////////////////////////////////////////////////////////////////////////////////////////
    begin
      result:='N';
      QSalestoque.first;
      while not QSalestoque.eof do begin
        if (QSalestoque.fieldbyname('saes_esto_codigo').asstring=produto) and
           (QSalestoque.fieldbyname('saes_core_codigo').asinteger=codcor) and
           (QSalestoque.fieldbyname('saes_tama_codigo').asinteger=codtamanho) and
           (QSalestoque.fieldbyname('saes_copa_codigo').asinteger=codcopa)
          then begin
          result:='S';
          break;
        end;
        QSalEstoque.next;
      end;
    end;


    procedure AtualizaCamaraFria( codigo,tipomov:string ; pesobalanca:Currency );
    ////////////////////////////////////////////////////////////////////////
    var y     : integer;
        achou : boolean;

    begin

       achou:=false;
       for y := 0 to ListaCamaraFria.Count-1 do begin

           PCamaraFria:=ListaCamaraFria[ y ];
           if PCamaraFria.codigo=codigo then begin
             achou:=true;
             break;
           end;

       end;

       if not achou then begin
          New(PCamaraFria);
          PCamaraFria.codigo:=codigo;
          PCamaraFria.qtde:=0;
          PCamaraFria.qtds:=0;
          PCamaraFria.saldoa:=0;
          PCamaraFria.saldo:=0;
          if tipomov='PC' then
             PCamarafria.qtde:=pesobalanca
          else
             PCamaraFria.qtds:=pesobalanca;
          PCamarafria.saldo:=PCamarafria.saldoa + PCamarafria.qtde - PCamarafria.qtds;
          ListaCamaraFria.Add( PCamaraFria );

       end else begin

          if tipomov='PC' then
             PCamarafria.qtde:=PCamarafria.qtde + pesobalanca
          else
             PCamaraFria.qtds:=PCamaraFria.qtds + pesobalanca;
          PCamarafria.saldo:=PCamarafria.saldoa + PCamarafria.qtde - PCamarafria.qtds;

       end;

    end;


begin

  if not EdMesano.ValidEdiAll(FTransSaldos,99) then exit;
  if confirma('Confirma transfer�ncia da unidade '+EdUnid_codigo.text+'?') then begin

    Sistema.beginprocess('Abrindo tabela estoque');

    if not Arq.TEstoque.Active then Arq.TEstoque.Open;
//    Sistema.beginprocess('Abrindo tabela estoqueqtde');
//    if not Arq.TEstoqueQtde.Active then Arq.TEstoqueQtde.Open;
//    if not Arq.TSalEstoque.Active then Arq.TSalEstoque.Open;
//    Sistema.beginprocess('Abrindo tabela salestoque');
//////////////////////////////    Arq.TSalEstoque.Openwith('saes_unid_codigo='+stringtosql(EdUnid_codigo.text),arq.tsalestoque.ordenacao);
    ListaSaldos:=TList.Create;
    ListaSaldosGrade:=TList.Create;
    Texto.clear;
    sqlsaldoant:='';
    sqlmovimento:='';
    sqlgruposaldoant:='';
    sqlgrupomovimento:='';
// 11.09.06
    sqlsaldoantgrade:='';
    sqlgruposaldoantgrade:='';

    if not EdProduto.isempty then begin
      sqlsaldoant:=' and esqt_esto_codigo='+EdProduto.assql;
      sqlsaldoantgrade:=' and esgr_esto_codigo='+EdProduto.assql;
      sqlmovimento:=' and move_esto_codigo='+EdProduto.assql;
    end;
    ProdutosGrupo:='';
    if not EdEsto_Grup_codigo.isempty then begin
      Sistema.Beginprocess('Armazenando codigos do grupo escolhido');
      QGrupo:=sqltoquery('select esto_codigo from estoque where esto_grup_codigo='+EdEsto_Grup_codigo.assql);
      while not QGrupo.eof do begin
        ProdutosGrupo:=ProdutosGrupo+QGrupo.fieldbyname('esto_codigo').asstring+';';
        QGrupo.next;
      end;
      sqlgruposaldoant:=' and '+FGeral.Getin('esqt_esto_codigo',ProdutosGrupo,'C');
      sqlgrupomovimento:=' and '+FGeral.Getin('move_esto_codigo',ProdutosGrupo,'C');
      sqlgruposaldoantgrade:=' and '+FGeral.Getin('esgr_esto_codigo',ProdutosGrupo,'C');
    end;
    Sistema.Beginprocess('Pesquisando saldo do mes anterior');
    QSaldoanterior:=sqltoquery('select * from estoqueqtde '+
                    ' where esqt_unid_codigo='+EdUNid_codigo.assql+
                    sqlsaldoant+sqlgruposaldoant+
                    ' and esqt_status=''N''');

    Sistema.Beginprocess('Pesquisando saldo do mes anterior ref. grades');
    QSaldoanteriorGrade:=sqltoquery('select * from estgrades '+
                    ' where esgr_unid_codigo='+EdUNid_codigo.assql+
                    sqlsaldoantgrade+sqlgruposaldoantgrade+
                    ' and esgr_status=''N'' order by esgr_esto_codigo');

    mes:=strtoint(copy(edmesano.text,1,2));
    ano:=strtoint(copy(edmesano.text,3,4));
    if mes=1 then begin
      mes:=12;
      dec(ano);
    end else
      dec(mes);
    mesanoant:=inttostr(ano)+strzero(mes,2);
    Salestoque:=TSQLQuery.Create(Application.MainForm);
//    Salestoque.NoMetadata:=True;
    Salestoque.SQLConnection:=Sistema.Conexao;

    Sistema.Beginprocess('Armazenando saldo do mes anterior');

    while not QSaldoanterior.eof do begin

      produto:=QSaldoanterior.fieldbyname('esqt_esto_codigo').asstring;
//      FGeral.PosicaoEstoqueAnterior(produto,QSaldoanterior.fieldbyname('esqt_tama_codigo').asinteger,QSaldoanterior.fieldbyname('esqt_core_codigo').asinteger,
//              EdUNid_codigo.text,texttodate('01'+EdMesano.text),SAlestoque);
// 25.04.05 -confusao nesta questao do estoque atual/anterior
//      FGeral.PosicaoEstoqueAnterior(produto,QSaldoanterior.fieldbyname('esqt_tama_codigo').asinteger,QSaldoanterior.fieldbyname('esqt_core_codigo').asinteger,
//              0,EdUNid_codigo.text,texttodate('01'+strzero(mes,2)+inttostr(ano)),SAlestoque);
// 11.09.06 - deixado aqui somente para atualizar por codigo sem usar grade
      FGeral.PosicaoEstoqueAnterior(produto,0,0,0,EdUNid_codigo.text,texttodate('01'+strzero(mes,2)+inttostr(ano)),SAlestoque);
      New(PSaldos);
      PSaldos.produto:=produto;
//      if SalEstoque.fieldbyname('saes_mesano').asstring=mesanoant then begin
      if not SalEstoque.eof  then begin
        PSaldos.aqtde:=SalEstoque.fieldbyname('saes_qtde').ascurrency;
        PSaldos.aqtdeprev:=SalEstoque.fieldbyname('saes_qtdeprev').ascurrency;
// 01.10.07
        PSaldos.apecas:=SalEstoque.fieldbyname('saes_pecas').ascurrency;
// 19.10.09
        PSaldos.aqtdeprocesso:=SalEstoque.fieldbyname('saes_qtdeprocesso').ascurrency;
// 06.03.06
        if EdEstoquefora.text='S' then begin
          PSaldos.aqtdeconsig:=SalEstoque.fieldbyname('saes_qtdeconsig').ascurrency;
          PSaldos.aqtdepronta:=SalEstoque.fieldbyname('saes_qtdepronta').ascurrency;
          PSaldos.aqtderegesp:=SalEstoque.fieldbyname('saes_qtderegesp').ascurrency;
        end;
        Salestoque.close;
      end else begin
        PSaldos.aqtde:=0;
        PSaldos.aqtdeprev:=0;
// 01.10.07
        PSaldos.apecas:=0;
// 19.10.09
        PSaldos.aqtdeprocesso:=0;
// 06.03.06
        PSaldos.aqtdeconsig:=0;
        PSaldos.aqtdepronta:=0;
        PSaldos.aqtderegesp:=0;
      end;
      PSaldos.qtde:=0;
      PSaldos.qtdeprev:=0;
      PSaldos.entradas:=0;
// 01.10.07
      PSaldos.pecas:=0;
      PSaldos.saidas:=0;
      PSaldos.custo:=QSaldoanterior.fieldbyname('esqt_custo').ascurrency;
      PSaldos.custoger:=QSaldoanterior.fieldbyname('esqt_custoger').ascurrency;
      PSaldos.customedio:=QSaldoanterior.fieldbyname('esqt_customedio').ascurrency;
      PSaldos.customeger:=QSaldoanterior.fieldbyname('esqt_customeger').ascurrency;
      PSaldos.venda:=QSaldoanterior.fieldbyname('esqt_vendavis').ascurrency;
      PSaldos.balanco:='N';
      PSaldos.atualizacustos:='N';   // 17.02.06
// 06.03.06
      PSaldos.qtdeconsig:=0;
      PSaldos.qtdepronta:=0;
      PSaldos.qtderegesp:=0;
      PSaldos.qtdeprocesso:=0;
      ListaSaldos.Add(PSaldos);
      QSaldoanterior.next;
    end;

////////////// - 11.09.06
/////////////////////////////////////////
    Sistema.Beginprocess('Armazenando saldo do mes anterior ref. grades');

    while not QSaldoanteriorGrade.eof do begin

      produto:=QSaldoanteriorGrade.fieldbyname('esgr_esto_codigo').asstring;
// 11.09.06 - deixado aqui somente para atualizar por codigo usando grade
      FGeral.PosicaoEstoqueAnterior(produto,QSaldoanteriorGrade.fieldbyname('esgr_tama_codigo').asinteger,
            QSaldoanteriorGrade.fieldbyname('esgr_core_codigo').asinteger,
            QSaldoanteriorGrade.fieldbyname('esgr_copa_codigo').asinteger,EdUNid_codigo.text,texttodate('01'+strzero(mes,2)+inttostr(ano)),SAlestoque);
      New(PSaldosGrade);
      PSaldosGrade.produto:=produto;
      if not SalEstoque.eof  then begin
        PSaldosGrade.aqtde:=SalEstoque.fieldbyname('saes_qtde').ascurrency;
        PSaldosGrade.aqtdeprev:=SalEstoque.fieldbyname('saes_qtdeprev').ascurrency;
// 06.03.06
        if EdEstoquefora.text='S' then begin
          PSaldosGrade.aqtdeconsig:=SalEstoque.fieldbyname('saes_qtdeconsig').ascurrency;
          PSaldosGrade.aqtdepronta:=SalEstoque.fieldbyname('saes_qtdepronta').ascurrency;
          PSaldosGrade.aqtderegesp:=SalEstoque.fieldbyname('saes_qtderegesp').ascurrency;
        end;
        PSaldosGrade.aqtdeprocesso:=SalEstoque.fieldbyname('saes_qtdeprocesso').ascurrency;
        Salestoque.close;
      end else begin
        PSaldosGrade.aqtde:=0;
        PSaldosGrade.aqtdeprev:=0;
// 06.03.06
        PSaldosGrade.aqtdeconsig:=0;
        PSaldosGrade.aqtdepronta:=0;
        PSaldosGrade.aqtderegesp:=0;
        PSaldosGrade.aqtdeprocesso:=0;
      end;
      PSaldosGrade.qtde:=0;
      PSaldosGrade.qtdeprev:=0;
      PSaldosGrade.entradas:=0;
      PSaldosGrade.saidas:=0;
      PSaldosGrade.custo:=QSaldoanteriorGrade.fieldbyname('esgr_custo').ascurrency;
      PSaldosGrade.custoger:=QSaldoanteriorGrade.fieldbyname('esgr_custoger').ascurrency;
      PSaldosGrade.customedio:=QSaldoanteriorGrade.fieldbyname('esgr_customedio').ascurrency;
      PSaldosGrade.customeger:=QSaldoanteriorGrade.fieldbyname('esgr_customeger').ascurrency;
      PSaldosGrade.venda:=QSaldoanteriorGrade.fieldbyname('esgr_vendavis').ascurrency;
      PSaldosGrade.balanco:='N';
      PSaldosGrade.atualizacustos:='N';
      PSaldosGrade.qtdeconsig:=0;
      PSaldosGrade.qtdepronta:=0;
      PSaldosGrade.qtderegesp:=0;
      PSaldosGrade.codcor:=QSaldoanteriorgrade.fieldbyname('esgr_core_codigo').asinteger;
      PSaldosGrade.codtamanho:=QSaldoanteriorgrade.fieldbyname('esgr_tama_codigo').asinteger;;
      PSaldosGrade.codcopa:=QSaldoanteriorgrade.fieldbyname('esgr_copa_codigo').asinteger;;
      PSaldosGrade.qtdeprocesso:=0;
      ListaSaldosGrade.Add(PSaldosGrade);
      QSaldoanteriorGrade.next;
    end;

//////////////
    if not EdProduto.isempty then
      sqlsalestoqueproduto:=' and saes_esto_codigo='+EdProduto.Assql
    else
      sqlsalestoqueproduto:='';
    Sistema.Beginprocess('Lendo saldos existentes neste mes/ano');
    QSalestoque:=sqltomemoryquery('select saes_esto_codigo,saes_core_codigo,saes_tama_codigo,saes_copa_codigo from salestoque where saes_status=''N'''+
                            ' and saes_mesano='+stringtosql(FGeral.AnoMesinvertido(EdMesano.text))+
                            ' and saes_unid_codigo='+EdUnid_codigo.assql+
                            sqlsalestoqueproduto );
    Sistema.Beginprocess('Verificando se j� tem saldo mensal neste mes/ano');

    for p:=0 to ListaSAldos.Count-1 do begin

       PSaldos:=Listasaldos[p];
       if trim(Psaldos.produto)<>'' then begin
// 11.09.06
         PSaldos.atualizacustos:='S';

         if TemnoQSalestoque(Psaldos.produto)='N' then begin
           Sistema.insert('salestoque');
           Sistema.setfield('saes_status','N');
           Sistema.setfield('saes_mesano',FGeral.Anomesinvertido(EdMesano.text));
           Sistema.setfield('saes_unid_codigo',EdUNid_codigo.text);
           Sistema.setfield('saes_esto_codigo',Psaldos.produto);
           Sistema.setfield('saes_custo',PSaldos.custo);
           Sistema.setfield('saes_custoger',PSaldos.custoger);
           Sistema.setfield('saes_customedio',PSaldos.customedio);
           Sistema.setfield('saes_customeger',PSaldos.customeger);
           Sistema.setfield('saes_usua_codigo',Global.usuario.codigo);
           Sistema.setfield('saes_vendavis',PSaldos.venda);
// 06.03.06
           if EdEstoquefora.text='S' then begin
             Sistema.setfield('saes_qtdeconsig',PSaldos.qtdeconsig);
             Sistema.setfield('saes_qtdepronta',PSaldos.qtdepronta);
             Sistema.setfield('saes_qtderegesp',PSaldos.qtderegesp);
           end;
           Sistema.post;
           PSaldos.atualizacustos:='S';
             try
                Sistema.Commit;
             except
                texto.lines.Add(Psaldos.produto+' talvez duplicado no salestoque nesta unidade')
             end;
         end;
       end;
    end;
///////// - 11.09.06
    Sistema.Beginprocess('Verificando se j� tem saldo mensal neste mes/ano ref. grades');

    for p:=0 to ListaSAldosGrade.Count-1 do begin

       PSaldosGrade:=ListasaldosGrade[p];
       if trim(PsaldosGrade.produto)<>'' then begin
         if TemnoQSalestoqueGrade(PsaldosGrade.produto,Psaldosgrade.codcor,Psaldosgrade.codtamanho,Psaldosgrade.codcopa)='N' then begin
           Sistema.insert('salestoque');
           Sistema.setfield('saes_status','N');
           Sistema.setfield('saes_mesano',FGeral.Anomesinvertido(EdMesano.text));
           Sistema.setfield('saes_unid_codigo',EdUNid_codigo.text);
           Sistema.setfield('saes_esto_codigo',PsaldosGrade.produto);
           Sistema.setfield('saes_custo',PSaldosGrade.custo);
           Sistema.setfield('saes_custoger',PSaldosGrade.custoger);
           Sistema.setfield('saes_customedio',PSaldosGrade.customedio);
           Sistema.setfield('saes_customeger',PSaldosGrade.customeger);
           Sistema.setfield('saes_usua_codigo',Global.usuario.codigo);
           Sistema.setfield('saes_vendavis',PSaldosGrade.venda);
           if EdEstoquefora.text='S' then begin
             Sistema.setfield('saes_qtdeconsig',PSaldosGrade.qtdeconsig);
             Sistema.setfield('saes_qtdepronta',PSaldosGrade.qtdepronta);
             Sistema.setfield('saes_qtderegesp',PSaldosGrade.qtderegesp);
           end;
           Sistema.setfield('saes_core_codigo',PsaldosGrade.codcor);
           Sistema.setfield('saes_tama_codigo',PsaldosGrade.codtamanho);
           Sistema.setfield('saes_copa_codigo',PsaldosGrade.codcopa);
           Sistema.post;
           PSaldosGrade.atualizacustos:='S';
             try
                Sistema.Commit;
             except
                texto.lines.Add(PsaldosGrade.produto+' talvez duplicado no salestoque nesta unidade ref. grade')
             end;
         end;
       end;
    end;

/////////

    Sistema.Beginprocess('Gerando movimento geral');
/////////////////////////////////////////////////////////////////////////////////////////////
{
    Q:=sqltoquery('select mestre.*,detalhe.*,esto_descricao'+
                     ' from movesto mestre,movestoque detalhe'+
//                     ' left join estoque on (esto_codigo=move_esto_codigo) '+
//  05.07.05
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' where mestre.'+FGeral.RelEstoque('moes_status')+
                     ' and mestre.moes_unid_codigo='+EdUnid_codigo.assql+
//  10.10.05
                     ' and extract( month from detalhe.move_datamvto )='+inttostr(Datetomes(texttodate('01'+EdMesano.text)))+
                     ' and extract( year from detalhe.move_datamvto )='+inttostr(Datetoano(texttodate('01'+EdMesano.text),true))+
//                     ' and detalhe.move_datamvto>='+Datetosql(texttodate('01'+EdMesano.text))+
                     sqlmovimento+  // 02.06.05
                     sqlgrupomovimento+  // 04.10.05
//                     ' and mestre.moes_datamvto<='+Datetosql(DatetoUltimodiames(texttodate('01'+EdMesano.text)))+
//                     ' and mestre.moes_transacao=detalhe.move_transacao'+
//                     ' and mestre.moes_tipomov=detalhe.move_tipomov'+
// 25.04.05 - NOS ACERTOS DE ESTOQUE A TRANSACAO E O TIPO DE MOVIMENTO 'NAO FECHAM' NO MESTRE/DETALHE O TIPOMOV
//            POIS PODE SER AE OU AS NA MESMA DIGITA��O DO ACERTO
//                     ' and mestre.moes_datamvto>='+Datetosql(texttodate('01'+EdMesano.text))+
//  10.10.05
                     ' and extract( month from mestre.moes_datamvto )='+inttostr(Datetomes(texttodate('01'+EdMesano.text)))+
                     ' and extract( year from mestre.moes_datamvto )='+inttostr(Datetoano(texttodate('01'+EdMesano.text),true))+
                     ' and mestre.moes_numerodoc=detalhe.move_numerodoc'+
                     ' and mestre.moes_datamvto=detalhe.move_datamvto'+
                     ' and mestre.moes_tipo_codigo=detalhe.move_tipo_codigo'+
                     ' and mestre.moes_tipocad=detalhe.move_tipocad'+
                     ' and mestre.moes_transacao=detalhe.move_transacao'+   //  05.07.05
                     ' and detalhe.'+FGeral.RelEstoque('move_status')+
                     ' and detalhe.move_unid_codigo='+EdUnid_codigo.assql+   // 30.03.05
                     ' order by detalhe.move_esto_codigo,detalhe.move_datamvto,detalhe.move_numerodoc' );
}

    tiposacertos:=Global.CodAcertoEsEnt+';'+Global.CodAcertoEsSai+';'+Global.CodContagemBalancoE+';'+Global.CodContagemBalancoS;

/////////////////////////////////////////////////////////////////////////////////////////////
// 16.11.05
//    Q:=sqltoquery('select * from movestoque '+
    campos:='move_qtde,move_unid_codigo,move_tama_codigo,move_core_codigo,move_copa_codigo,'+
            'move_datamvto,move_esto_codigo,move_sugr_codigo,move_fami_codigo,move_grup_codigo,move_tipomov,'+
            'move_datacont,move_estoque,move_pecas,move_embalagem,move_custo,move_customedio,move_custoger,'+
            'move_customeger,move_status,move_estoquepc,esto_embalagem,move_venda';

    Q:=sqltoquery('select '+campos+' from movestoque '+
//                     ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
// 17.11.05 - devido aos AE e AS
//                     ' left join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
// 27.10.09 - movesto tipomov 'SA' ficam 'enuplicados' dai movimenta errado - Abra
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and move_unid_codigo='+EdUnid_codigo.assql+
////////////////////////                     ' and '+FGeral.Getnotin('move_tipomov',tiposacertos,'C')+
//  10.10.05
                     ' and extract( month from move_datamvto )='+inttostr(Datetomes(texttodate('01'+EdMesano.text)))+
                     ' and extract( year from move_datamvto )='+inttostr(Datetoano(texttodate('01'+EdMesano.text),true))+
// 07.08.06
//                     ' and '+FGeral.RelEstoque('moes_status')+
//                     ' and detalhe.move_datamvto>='+Datetosql(texttodate('01'+EdMesano.text))+
                     sqlmovimento+  // 02.06.05
                     sqlgrupomovimento+  // 04.10.05
// 25.04.05 - NOS ACERTOS DE ESTOQUE A TRANSACAO E O TIPO DE MOVIMENTO 'NAO FECHAM' NO MESTRE/DETALHE O TIPOMOV
//            POIS PODE SER AE OU AS NA MESMA DIGITA��O DO ACERTO
//                     ' and mestre.moes_datamvto>='+Datetosql(texttodate('01'+EdMesano.text))+
//  10.10.05
//                     ' order by move_esto_codigo,move_datamvto,move_numerodoc' );
// 13.04.06 - cfe a ordem as contagem sao consideradas 'depois do dia q realmente aconteceram'...
// parabens pra leilinha...
                     ' order by move_datamvto,move_numerodoc,move_esto_codigo' );

/////////////////////////////////////////////////////////////////////////////////////////////
    Sistema.EndProcess('');

    Sistema.Beginprocess('Percorrendo movimento geral');

    while not Q.eof do begin

      produto:=Q.fieldbyname('move_esto_codigo').asstring;
// ver como sera o uso das duas quantidades em estoque
// este if em 20.10.09 - um produto ter� 'somente ele' ou s� grade
      if (Q.fieldbyname('move_tama_codigo').asinteger+Q.fieldbyname('move_core_codigo').asinteger)=0 then
        AtualizaLista(produto,Q.fieldbyname('move_qtde').ascurrency,
                    Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_estoque').ascurrency,Q.fieldbyname('move_pecas').ascurrency,
                    Q.fieldbyname('move_estoquepc').ascurrency,Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_tipomov').asstring)
      else
        AtualizaListaGrade(produto,Q.fieldbyname('move_qtde').ascurrency,
                    Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_estoque').ascurrency,
                    Q.fieldbyname('move_qtde').ascurrency,
                    Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_core_codigo').asinteger,
                    Q.fieldbyname('move_tama_codigo').asinteger,Q.fieldbyname('move_copa_codigo').asinteger);
      Q.Next;
    end;
// - 13.04.06
////////////////////
    FGeral.Fechaquery(Q);
/////////////////////////////////////////////////
{
    Sistema.Beginprocess('Gerando movimento de acertos de estoque e contagem');
    Q:=sqltoquery('select * from movestoque '+
//                     ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
// 17.11.05 - devido aos AE e AS
                     ' left join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and move_unid_codigo='+EdUnid_codigo.assql+
                     ' and '+FGeral.Getin('move_tipomov',tiposacertos,'C')+
//  10.10.05
                     ' and extract( month from move_datamvto )='+inttostr(Datetomes(texttodate('01'+EdMesano.text)))+
                     ' and extract( year from move_datamvto )='+inttostr(Datetoano(texttodate('01'+EdMesano.text),true))+
//                     ' and detalhe.move_datamvto>='+Datetosql(texttodate('01'+EdMesano.text))+
                     sqlmovimento+  // 02.06.05
                     sqlgrupomovimento+  // 04.10.05
// 25.04.05 - NOS ACERTOS DE ESTOQUE A TRANSACAO E O TIPO DE MOVIMENTO 'NAO FECHAM' NO MESTRE/DETALHE O TIPOMOV
//            POIS PODE SER AE OU AS NA MESMA DIGITA��O DO ACERTO
//                     ' and mestre.moes_datamvto>='+Datetosql(texttodate('01'+EdMesano.text))+
//  10.10.05
//                     ' order by move_esto_codigo,move_datamvto,move_numerodoc' );
// 13.04.06 - cfe a ordem as contagem sao consideradas 'depois do dia q realmente aconteceram'...
// parabens pra leilinha...
                     ' order by move_datamvto,move_numerodoc,move_esto_codigo' );

    Sistema.Beginprocess('Percorrendo movimento de acertos de estoque e contagem');
    while not Q.eof do begin
      produto:=Q.fieldbyname('move_esto_codigo').asstring;
// ver como sera o uso das duas quantidades em estoque
      AtualizaLista(produto,Q.fieldbyname('move_qtde').ascurrency,
                    Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_estoque').ascurrency,
                    Q.fieldbyname('move_tipomov').asstring,);
      Q.Next;
    end;

}
////////////////////////////////////////////////////////////////////////////

    Sistema.Beginprocess('Transferindo o saldo final do estoque');

    for p:=0 to Listasaldos.Count-1 do begin

      PSaldos:=ListaSaldos[p];
      Sistema.Edit('salestoque');
      Sistema.setfield('saes_entradas',PSaldos.entradas);
      Sistema.setfield('saes_saidas',PSaldos.saidas);
      if Psaldos.balanco<>'S' then begin
        Sistema.setfield('saes_qtde',PSaldos.aqtde+PSaldos.qtde);
        Sistema.setfield('saes_qtdeprev',PSaldos.aqtdeprev+PSaldos.qtdeprev);
// 01.10.07
        Sistema.setfield('saes_pecas',PSaldos.apecas+PSaldos.pecas);
// 19.10.09
        Sistema.setfield('saes_qtdeprocesso',PSaldos.aqtdeprocesso+PSaldos.qtdeprocesso);
      end else begin
        Sistema.setfield('saes_qtde',PSaldos.qtde);
        Sistema.setfield('saes_qtdeprev',PSaldos.qtdeprev);
// 05.11.07
        Sistema.setfield('saes_pecas',PSaldos.pecas);
// 19.10.09
        Sistema.setfield('saes_qtdeprocesso',PSaldos.qtdeprocesso);
      end;
// 06.03.06
      if EdEstoquefora.text='S' then begin
        Sistema.setfield('saes_qtdeconsig',PSaldos.aqtdeconsig+PSaldos.qtdeconsig);
        Sistema.setfield('saes_qtdepronta',PSaldos.aqtdepronta+PSaldos.qtdepronta);
        Sistema.setfield('saes_qtderegesp',PSaldos.aqtderegesp+PSaldos.qtderegesp);
      end;
      Sistema.setfield('saes_usua_codigo',Global.Usuario.Codigo);
// 17.02.06
      if PSaldos.atualizacustos='S' then begin
        Sistema.setfield('saes_custo',PSaldos.custo);
        Sistema.setfield('saes_custoger',PSaldos.custoger);
        Sistema.setfield('saes_customedio',PSaldos.customedio);
        Sistema.setfield('saes_customeger',PSaldos.customeger);
        Sistema.setfield('saes_vendavis',PSaldos.venda);
      end;
//
      Sistema.Post('saes_status=''N'' and saes_mesano='+stringtosql(FGeral.AnoMesinvertido(EdMesano.text))+
                   ' and saes_unid_codigo='+EdUnid_codigo.assql+' and saes_esto_codigo='+stringtosql(PSaldos.produto)+
                   ' and ( saes_tama_codigo=0 or saes_tama_codigo is null )'+
                   ' and ( saes_core_codigo=0 or saes_core_codigo is null )');
      if (PSaldos.aqtdeprev+PSaldos.qtdeprev)<0 then
        Texto.Lines.Add('Produto '+PSaldos.produto+' com estoque negativo');
//      if PSAldos.custo<=0 then
//        Texto.Lines.Add('Produto '+PSaldos.produto+' com custo menor ou igual a zero');
      if PSAldos.customeger<=0 then
        Texto.Lines.Add('Produto '+PSaldos.produto+' com custo m�dio gerencial menor ou igual a zero');
      if p mod 500 = 0 then begin
        Sistema.setmessage('Gravando a cada 500');
        Sistema.Commit;
      end;
    end;
    Sistema.setmessage('Gravando �ltimos 500');
    Sistema.Commit;

//    Freeandnil(ListaSaldos);
//    if PSaldos<>nil then
//      Dispose(PSaldos);

/////////////////// - 11.09.06
    Sistema.Beginprocess('Transferindo o saldo final do estoque ref. grades');

    for p:=0 to ListasaldosGrade.Count-1 do begin

      PSaldosGrade:=ListaSaldosGrade[p];
      Sistema.Edit('salestoque');
      Sistema.setfield('saes_entradas',PSaldosGrade.entradas);
      Sistema.setfield('saes_saidas',PSaldosGrade.saidas);
      if PsaldosGrade.balanco<>'S' then begin
        Sistema.setfield('saes_qtde',PSaldosGrade.aqtde+PSaldosGrade.qtde);
        Sistema.setfield('saes_qtdeprev',PSaldosGrade.aqtdeprev+PSaldosGrade.qtdeprev);
        Sistema.setfield('saes_qtdeprocesso',PSaldosGrade.aqtdeprocesso+PSaldosGrade.qtdeprocesso);
      end else begin
        Sistema.setfield('saes_qtde',PSaldosGrade.qtde);
        Sistema.setfield('saes_qtdeprev',PSaldosGrade.qtdeprev);
        Sistema.setfield('saes_qtdeprocesso',PSaldosGrade.qtdeprocesso);
      end;
// 06.03.06
      if EdEstoquefora.text='S' then begin
        Sistema.setfield('saes_qtdeconsig',PSaldosGrade.aqtdeconsig+PSaldosGrade.qtdeconsig);
        Sistema.setfield('saes_qtdepronta',PSaldosGrade.aqtdepronta+PSaldosGrade.qtdepronta);
        Sistema.setfield('saes_qtderegesp',PSaldosGrade.aqtderegesp+PSaldosGrade.qtderegesp);
      end;
      Sistema.setfield('saes_usua_codigo',Global.Usuario.Codigo);
// 17.02.06
      if PSaldosGrade.atualizacustos='S' then begin
        Sistema.setfield('saes_custo',PSaldosGrade.custo);
        Sistema.setfield('saes_custoger',PSaldosGrade.custoger);
        Sistema.setfield('saes_customedio',PSaldosGrade.customedio);
        Sistema.setfield('saes_customeger',PSaldosGrade.customeger);
        Sistema.setfield('saes_vendavis',PSaldosGrade.venda);
      end;
//
      Sistema.Post('saes_status=''N'' and saes_mesano='+stringtosql(FGeral.AnoMesinvertido(EdMesano.text))+
                   ' and saes_unid_codigo='+EdUnid_codigo.assql+
                   ' and saes_esto_codigo='+stringtosql(PSaldosGrade.produto)+
                   ' and saes_tama_codigo='+inttostr(PSaldosGrade.codtamanho)+
                   ' and saes_core_codigo='+inttostr(PSaldosGrade.codcor) );
// 27.04.17
//                   ' and ( saes_copa_codigo='+inttostr(PSaldosGrade.codcopa)+' or saes_copa_codigo is null ) ' );
      if (PSaldosGrade.aqtdeprev+PSaldosGrade.qtdeprev)<0 then
        Texto.Lines.Add('Produto '+PSaldosGrade.produto+' - '+FTamanhos.GetDescricao(PSaldosGrade.codtamanho)+' com estoque negativo');
      if PSAldosGRade.customeger<=0 then
        Texto.Lines.Add('Produto '+PSaldosGrade.produto+' - '+FTamanhos.GetDescricao(PSaldosGrade.codtamanho)+' com custo m�dio gerencial menor ou igual a zero');
      if p mod 500 = 0 then begin
        Sistema.setmessage('Gravando a grade cada 500');
        Sistema.Commit;
      end;
    end;
    Sistema.setmessage('Gravando grade �ltimos 500');

    Sistema.Commit;

//    Freeandnil(ListaSaldosGrade);
//    if PSaldosgrade<>nil then
//      Dispose(PSaldosGrade);

    if Global.Topicos[1223] then begin
      ExecuteSql('Delete from movestoque '+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and move_unid_codigo='+EdUnid_codigo.assql+
                     ' and extract( month from move_datamvto )='+inttostr(Datetomes(texttodate('01'+EdMesano.text)))+
                     ' and extract( year from move_datamvto )='+inttostr(Datetoano(texttodate('01'+EdMesano.text),true))+
                     sqlmovimento+
                     sqlgrupomovimento+
                     ' and move_datacont is null' );
      ExecuteSql('Delete from movesto '+
                     ' where '+FGeral.RelEstoque('moes_status')+
                     ' and moes_unid_codigo='+EdUnid_codigo.assql+
                     ' and extract( month from moes_datamvto )='+inttostr(Datetomes(texttodate('01'+EdMesano.text)))+
                     ' and extract( year from moes_datamvto )='+inttostr(Datetoano(texttodate('01'+EdMesano.text),true))+
                     ' and moes_datacont is null' );
    end;

////////////////////////////////////////////////////////////////////////////////
//      27.05.15
// 26.03.20 - Devereda
    if Global.Usuario.Codigo=100 then begin

       if not Confirma('Atualizar estoque atual ?') then begin
          Sistema.Endprocess('Transfer�ncia terminada');
          exit;
       end;

    end;

    ultimadatadomes:=DateToUltimoDiaMes(Texttodate('01'+EdMesano.text));
    Q:=sqltoquery('select '+campos+' from movestoque '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and move_unid_codigo='+EdUnid_codigo.assql+
                     ' and move_datamvto >'+DatetoSql(ultimadatadomes)+
                     sqlmovimento+
                     sqlgrupomovimento+
                     ' order by move_datamvto,move_numerodoc,move_esto_codigo' );
    Sistema.Beginprocess('Percorrendo movimento at� '+FGeral.formatadata(Sistema.hoje));

    while not Q.eof do begin

      produto:=Q.fieldbyname('move_esto_codigo').asstring;
      if (Q.fieldbyname('move_tama_codigo').asinteger+Q.fieldbyname('move_core_codigo').asinteger)=0 then
        AtualizaLista(produto,Q.fieldbyname('move_qtde').ascurrency,
                    Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_estoque').ascurrency,Q.fieldbyname('move_pecas').ascurrency,
                    Q.fieldbyname('move_estoquepc').ascurrency,Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_tipomov').asstring)
      else
        AtualizaListaGrade(produto,Q.fieldbyname('move_qtde').ascurrency,
                    Q.fieldbyname('move_qtde').ascurrency,Q.fieldbyname('move_estoque').ascurrency,
                    Q.fieldbyname('move_qtde').ascurrency,
                    Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_core_codigo').asinteger,
                    Q.fieldbyname('move_tama_codigo').asinteger,Q.fieldbyname('move_copa_codigo').asinteger);
      Q.Next;
    end;
    FGeral.Fechaquery(Q);
    Sistema.Beginprocess('Transferindo o saldo atual do estoque');

    for p:=0 to Listasaldos.Count-1 do begin

      PSaldos:=ListaSaldos[p];
      Sistema.Edit('estoqueqtde');
      if Psaldos.balanco<>'S' then begin
        Sistema.setfield('esqt_qtde',PSaldos.aqtde+PSaldos.qtde);
        Sistema.setfield('esqt_qtdeprev',PSaldos.aqtdeprev+PSaldos.qtdeprev);
// 01.10.07
        Sistema.setfield('esqt_pecas',PSaldos.apecas+PSaldos.pecas);
// 19.10.09
        Sistema.setfield('esqt_qtdeprocesso',PSaldos.aqtdeprocesso+PSaldos.qtdeprocesso);
      end else begin
        Sistema.setfield('esqt_qtde',PSaldos.qtde);
        Sistema.setfield('esqt_qtdeprev',PSaldos.qtdeprev);
// 05.11.07
        Sistema.setfield('esqt_pecas',PSaldos.pecas);
// 19.10.09
        Sistema.setfield('esqt_qtdeprocesso',PSaldos.qtdeprocesso);
      end;
      Sistema.Post('esqt_status=''N'''+
                   ' and esqt_unid_codigo='+EdUnid_codigo.assql+' and esqt_esto_codigo='+stringtosql(PSaldos.produto) );
      if p mod 500 = 0 then begin
        Sistema.setmessage('Gravando a cada 500');
        Sistema.Commit;
      end;
    end;
    Sistema.setmessage('Gravando �ltimos 500');
    Sistema.Commit;

//    Freeandnil(ListaSaldos);
//    if PSaldos<>nil then
//      Dispose(PSaldos);

    Sistema.Beginprocess('Transferindo o saldo atual do estoque ref. grades');

    for p:=0 to ListasaldosGrade.Count-1 do begin

      PSaldosGrade:=ListaSaldosGrade[p];
      Sistema.Edit('estgrades');
      if PsaldosGrade.balanco<>'S' then begin
        Sistema.setfield('esgr_qtde',PSaldosGrade.aqtde+PSaldosGrade.qtde);
        Sistema.setfield('esgr_qtdeprev',PSaldosGrade.aqtdeprev+PSaldosGrade.qtdeprev);
        Sistema.setfield('esgr_qtdeprocesso',PSaldosGrade.aqtdeprocesso+PSaldosGrade.qtdeprocesso);
      end else begin
        Sistema.setfield('esgr_qtde',PSaldosGrade.qtde);
        Sistema.setfield('esgr_qtdeprev',PSaldosGrade.qtdeprev);
        Sistema.setfield('esgr_qtdeprocesso',PSaldosGrade.qtdeprocesso);
      end;
//
      Sistema.Post('esgr_status=''N'''+
                   ' and esgr_unid_codigo='+EdUnid_codigo.assql+' and esgr_esto_codigo='+stringtosql(PSaldosGrade.produto)+
                   ' and esgr_tama_codigo='+inttostr(PSaldosGrade.codtamanho)+
                   ' and esgr_core_codigo='+inttostr(PSaldosGrade.codcor)+
                   ' and ( esgr_copa_codigo='+inttostr(PSaldosGrade.codcopa)+' or esgr_copa_codigo is null ) ' );
      if p mod 500 = 0 then begin
        Sistema.setmessage('Gravando a grade cada 500');
        Sistema.Commit;
      end;
    end;
    Sistema.setmessage('Gravando grade �ltimos 500');

    Sistema.Commit;

    Freeandnil(ListaSaldos);
    if PSaldos<>nil then
      Dispose(PSaldos);
    Freeandnil(ListaSaldosGrade);
    if PSaldosgrade<>nil then
      Dispose(PSaldosGrade);

//////////////////////////////////////////////////////////////////
// 18.01.19 - Movimento de estoque da camara fria
//////////////////////////////////////////////////////////////////
    Q:=sqltoquery('select movabatedet.*,esto_descricao from movabatedet '+
                     ' inner join estoque on (esto_codigo=movd_esto_codigo) '+
                     ' where '+FGeral.RelEstoque('movd_status')+
                     ' and movd_unid_codigo='+EdUnid_codigo.assql+
                     ' and extract( month from movd_datamvto )='+inttostr(Datetomes(texttodate('01'+EdMesano.text)))+
                     ' and extract( year from movd_datamvto )='+inttostr(Datetoano(texttodate('01'+EdMesano.text),true))+
                     ' order by movd_datamvto,movd_numerodoc,movd_esto_codigo' );

    ListaCamaraFria:=TList.Create;

    while not Q.Eof do begin

       if AnsiPos( Q.FieldByName('movd_tipomov').AsString, 'PC;SA' ) > 0  then begin

          AtualizaCamaraFria( Q.FieldByName('movd_esto_codigo').AsString,
                              Q.FieldByName('movd_tipomov').AsString,
                              Q.FieldByName('movd_pesobalanca').AsCurrency );


       end;

       Q.Next;

    end;

    FGeral.FechaQuery(Q);
    Sistema.Endprocess('Transfer�ncia terminada');
  end;
end;

procedure TFTransSaldos.EdUnid_codigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  FGeral.limpaedit(EdUNid_codigo,key);
end;

procedure TFTransSaldos.ChecaTransferenciaMensal;
var Q:TSqlquery;
    mes,ano,p:integer;
    mesanoant,unidades:string;
    Lista:Tstringlist;
begin
//  if ( (Global.CodigoUnidade=Global.unidadematriz) and (Global.usuario.ObjetosAcessados[1205]) ) and (Global.usuario.Codigo<>300) then begin
// 10.05.11
  if ( (Global.usuario.ObjetosAcessados[1205]) ) and (Global.usuario.Codigo<>100) then begin
    FTransSaldos.Edmesano.Text := strzero(DateTomes(Sistema.Hoje),2)+Inttostr(Datetoano(Sistema.Hoje,true));
    mes:=strtoint(copy(FTransSaldos.edmesano.text,1,2));
    ano:=strtoint(copy(FTransSaldos.edmesano.text,3,4));
    if mes=1 then begin
      mes:=12;
      dec(ano);
    end else
      dec(mes);
    mesanoant:=inttostr(ano)+strzero(mes,2);
    Q:=sqltoquery('select * from salestoque where saes_status=''N'' and saes_mesano='+stringtosql(mesanoant));
    if Q.eof then begin
      unidades:=global.Unidadecuritiba+';'+global.unidadebeltrao+';'+global.unidadecrisciuma+';'+
                global.unidadejoinvile+';'+global.unidadeijui;
      Lista:=Tstringlist.create;
      strtolista(lista,unidades,';',true);
      FTransSaldos.Edmesano.Text := strzero(mes,2)+Inttostr(ano);
      for p:=0 to Lista.count-1 do begin
        FTransSaldos.EdUnid_codigo.text:=lista[p];
        bexecutarclick(FTransSaldos);
      end;
    end;
  end;
end;

procedure TFTransSaldos.EdProdutoValidate(Sender: TObject);
var QBusca:Tsqlquery;
begin
  if not EdProduto.isempty then begin
    QBusca:=sqltoquery('select * from estoque where esto_Codigo='+EdProduto.assql);
    if not QBusca.Eof then begin
      SetEdEsto_descricao.text:=QBusca.fieldbyname('esto_descricao').asstring;
      QBusca.close;
      QBusca:=sqltoquery('select * from estoqueqtde where esqt_esto_Codigo='+EdProduto.assql+' and esqt_unid_codigo='+EdUnid_codigo.assql);
      if QBusca.eof then
         EdProduto.Invalid('Produto n�o encontrado na tabela estoqueqtde');
    end else begin
      EdProduto.Invalid('Codigo n�o encontrado');
    end;
    QBusca.close;
    Freeandnil(QBusca);
  end;
end;

procedure TFTransSaldos.EdEstoqueforaExitEdit(Sender: TObject);
begin
  bexecutarclick(self);
end;

end.
