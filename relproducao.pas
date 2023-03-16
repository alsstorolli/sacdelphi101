unit relproducao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid;

type
  TFRelProducao = class(TForm)
    PRel: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    baplicar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Eddatai: TSQLEd;
    Eddataf: TSQLEd;
    Edunid_codigo: TSQLEd;
    Ednroobra: TSQLEd;
    EdEqui_codigo: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    EdSa: TSQLEd;
    procedure baplicarClick(Sender: TObject);
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdnroobraExitEdit(Sender: TObject);
    procedure EdProdutoExitEdit(Sender: TObject);
  private
    { Private declarations }
    SaiOk:Boolean;
  public
    { Public declarations }
  end;

var
  FRelProducao: TFRelProducao;
  sqlunidade,sqldatacont,sqlcodtipo,sqlperiodo,sqlnroobra,titcliente,titobra,titdata,
  sqlprodutos,sqlequipamentos,titproduto,titequipamento:string;

procedure FRelProducao_Cortes;                // 1
procedure FRelProducao_Barras;                // 2
procedure FRelProducao_ItensdaObra;           // 3
procedure FRelProducao_CortescomEstoque;      // 4
procedure FRelProducao_NotasFichaTecnica;     // 5
procedure FRelProducao_FichaTecnica;          // 6
procedure FRelProducao_ProximasTrocas;        // 7
procedure FRelProducao_MediaConsumo;          // 8
procedure FRelProducao_CMVporPVOS;            // 9


implementation

uses Geral, Unidades, Sqlsis , SQLRel, Sqlexpr, Sqlfun, cadcor, tamanhos,
  Estoque, ConfMovi, Pedvenda;


{$R *.dfm}

function FRelProducao_Execute(Tp:Integer):Boolean;
/////////////////////////////////////////////////////////////
begin
  if FRelProducao=nil then FGeral.CreateForm(TFRelProducao, FRelProducao);
  result:=true;
  sqlunidade:='';
  sqlcodtipo:='';
  with FRelProducao do begin
    FUnidades.SetaItems(EdUnid_codigo,nil,Global.Usuario.UnidadesRelatorios);
    EdEqui_codigo.Enabled:=true;
    EdProduto.Enabled:=true;
    EdSa.enabled:=false;
// 18.02.16
    FPedVenda.SetaPedidosemAberto(EdNroobra);
    if tp=1 then begin
      Caption:='Padrões de Cortes';
    end else if tp=2 then begin
      Caption:='Relação de Barras';
    end else if tp=3 then begin
      Caption:='Relação de Itens da Obra';
    end else if tp=4 then begin
      Caption:='Relação de Cortes Com Estoque';
    end else if tp=5 then begin
      Caption:='Notas X Ficha Técnica de Equipamentos'
    end else if tp=6 then begin
      Caption:='Ficha Técnica de Equipamentos'
    end else if tp=7 then begin
      Caption:='Próximas Trocas'
    end else if tp=8 then begin
      Caption:='Média Consumo';
    end else if tp=9 then begin
      Caption:='CMV por OS';
      EdEqui_codigo.Enabled:=false;
      EdProduto.Enabled:=false;
      EdNroobra.Enabled:=true;
      EdSa.enabled:=true;
    end else begin
      Caption:='';
    end;
    EdDatai.enabled:=true;
    EdDataf.enabled:=true;
    EdUnid_codigo.enabled:=true;
    EdNroobra.Empty:=true;
    if (tp=1) or (tp=2) or (tp=3) or (tp=4) then begin
      EdNroobra.Enabled:=Global.Topicos[1204];
      EdNroobra.Empty:=false;
    end else if tp=5 then
      EdUnid_codigo.enabled:=false;
    SaiOk:=False;
    FRelProducao.ShowModal;
    Result:=SaiOk;
  end;

end;


procedure FRelProducao_Cortes;                // 1
////////////////////////////////////////////
var Q:TSqlquery;
    periodo,anterior:string;
    totalprod,totalgeral,qtdeprod,totalsobra,sobra:extended;
begin
  with FRelProducao do begin
    if not FRelProducao_Execute(1) then Exit;
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('movp_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      sqlperiodo:='and movp_datamvto>='+EdDatai.AsSql+' and movp_datamvto<='+EdDataf.AsSql
    else if (EdDatai.asdate>1)  then
      sqlperiodo:='and movp_datamvto>='+EdDatai.AsSql
    else if (EdDataf.asdate>1)  then
      sqlperiodo:='and movp_datamvto<='+EdDataF.AsSql
    else
      sqlperiodo:='';
    sqlnroobra:='';
    if not EdNroobra.isempty then
      sqlnroobra:=' and movp_nroobra='+EdNroobra.assql;
    Sistema.beginprocess('Gerando relatório');
    Q:=sqltoquery('select * from movproducao inner join estoque on ( esto_codigo=movp_esto_codigo )'+
                  ' left join tamanhos on ( tama_codigo=movp_tamag_codigo )'+
                  ' left join cores on ( core_codigo=movp_core_codigo )'+
                  ' where movp_status=''N'''+
                  sqlperiodo+sqlnroobra+sqlunidade+
                  ' order by esto_referencia,core_descricao');
    if Q.eof then begin
      Avisoerro('Nada encontrado para impressão');
      Sistema.endprocess('');
      FGeral.fechaquery(Q);
      exit;
    end;
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      periodo:='Periodo : '+FGeral.FormataData(EdDatai.AsDate)+' a '+FGeral.FormataData(EdDataf.AsDate)
    else
      periodo:='';
    titobra:='';titcliente:='';titdata:='';
    if not EdNroobra.isempty then begin
       titobra:=' - Obra '+EdNroobra.text;
       titcliente:=' - Cliente '+Q.fieldbyname('movp_tipo_codigo').AsString+' '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('movp_tipo_codigo').AsInteger,Q.fieldbyname('movp_tipocad').AsString,'N');
       titdata:=' - Data '+FGeral.formatadata(Q.fieldbyname('movp_datamvto').AsDatetime);
    end;
    FRel.Init('RelProducaoOp');
    FRel.AddTit('Relatório de Produção - Cortes');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+titdata);
    FRel.AddTit(Periodo+titobra+titcliente);
    FRel.AddCol(090,0,'C','' ,''              ,'Transação'       ,''         ,'',False);
    if EdNroobra.isempty then begin
      FRel.AddCol( 60,1,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
      FRel.AddCol( 45,0,'C','' ,''              ,'Cliente'         ,''         ,'',false);
      FRel.AddCol(120,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
    end;
    FRel.AddCol( 80,0,'N','' ,''              ,'Produto'         ,''         ,'',false);
    FRel.AddCol( 90,0,'C','' ,''              ,'Cor'             ,''         ,'',false);
    FRel.AddCol( 70,3,'N','' ,''              ,'Qtde'            ,''         ,'',false);
    FRel.AddCol( 70,0,'C','' ,''              ,'Tamanho'         ,''         ,'',false);
    FRel.AddCol( 80,3,'N','',''               ,'Tam.Total'       ,''         ,'',false);
    FRel.AddCol( 80,3,'N','' ,''              ,'Qtde Prod.'      ,''         ,'',false);
    FRel.AddCol( 90,0,'C','' ,''              ,'Tamanho Prod.'   ,''         ,'',false);
    FRel.AddCol( 80,3,'N','',''               ,'Tam.Prod.'       ,''         ,'',false);
    FRel.AddCol( 80,0,'C','' ,''              ,'OPeração'        ,''         ,'',false);
    FRel.AddCol( 60,3,'N','+' ,''             ,'Sobra'           ,''         ,'',false);
    FRel.AddCol( 80,0,'C','' ,''              ,'Local Obra'      ,''         ,'',false);
    totalprod:=0;totalgeral:=0;qtdeprod:=0;totalsobra:=0;
    while not Q.eof do begin
      FRel.AddCel( Q.fieldbyname('movp_transacao').AsString );
      if EdNroobra.isempty then begin
        FRel.AddCel( Q.fieldbyname('movp_datamvto').AsString);
        FRel.AddCel( Q.fieldbyname('movp_numerodoc').AsString);
        FRel.AddCel( Q.fieldbyname('movp_tipo_codigo').AsString);
        FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('movp_tipo_codigo').AsInteger,Q.fieldbyname('movp_tipocad').AsString,'N' ));
      end;
      FRel.AddCel( Q.fieldbyname('esto_referencia').AsString);
      FRel.AddCel( FCores.GetDescricao( Q.fieldbyname('movp_core_codigo').AsInteger));
      FRel.AddCel( Q.fieldbyname('movp_qtdegeral').AsString);
      FRel.AddCel( FTamanhos.GetDescricao( Q.fieldbyname('movp_tama_codigo').AsInteger) );
      FRel.AddCel( floattostr(Q.fieldbyname('movp_qtdegeral').AsCurrency*FTamanhos.GetComprimento( Q.fieldbyname('movp_tama_codigo').AsInteger) ) );
      FRel.AddCel( Q.fieldbyname('movp_qtdeop').AsString);
      FRel.AddCel( FTamanhos.GetDescricao( Q.fieldbyname('movp_tamag_codigo').AsInteger));
      FRel.AddCel( floattostr(Q.fieldbyname('movp_qtdeop').AsCurrency*Q.fieldbyname('tama_comprimento').AsFloat) );
      FRel.AddCel( Q.fieldbyname('movp_operacaoop').AsString);
      FRel.AddCel( '' );
      FRel.AddCel( Q.fieldbyname('movp_localobra').AsString);
      anterior:=Q.fieldbyname('esto_referencia').AsString+Q.fieldbyname('core_descricao').asstring;
      totalprod:=totalprod+Q.fieldbyname('movp_qtdeop').AsCurrency*Q.fieldbyname('tama_comprimento').AsFloat;
      totalgeral:=totalgeral+ ( (Q.fieldbyname('movp_qtdegeral').AsCurrency*FTamanhos.GetComprimento(Q.fieldbyname('movp_tama_codigo').AsInteger)) );
      qtdeprod:=qtdeprod+Q.fieldbyname('movp_qtdeop').AsCurrency;
      sobra:=( (Q.fieldbyname('movp_qtdegeral').AsCurrency*FTamanhos.GetComprimento(Q.fieldbyname('movp_tama_codigo').AsInteger)) ) -
              Q.fieldbyname('movp_qtdeop').AsCurrency*Q.fieldbyname('tama_comprimento').AsFloat;
      totalsobra:=totalsobra+sobra;
      Q.Next;
      if not Q.Eof then begin
        if (Q.fieldbyname('esto_referencia').AsString+Q.fieldbyname('core_descricao').asstring)<>anterior then begin
          sobra:=totalgeral-totalprod;
          FGeral.PulalinhaRel(Frel.GCol.ColCount,FRel.GetnCol('Tam.Prod.')+1,Floattostr(totalprod),FRel.GetnCol('Tam.Total')+1,Floattostr(totalgeral),
                              FRel.GetnCol('Qtde Prod.')+1,Floattostr(qtdeprod),
                              FRel.GetnCol('Sobra')+1,Floattostr(sobra)  );
          totalprod:=0;
          qtdeprod:=0;
          totalsobra:=0;
        end;
        totalgeral:=0
      end else begin
          sobra:=totalgeral-totalprod;
          FGeral.PulalinhaRel(Frel.GCol.ColCount,FRel.GetnCol('Tam.Prod.')+1,Floattostr(totalprod),FRel.GetnCol('Tam.Total')+1,Floattostr(totalgeral),
                              FRel.GetnCol('Qtde Prod.')+1,Floattostr(qtdeprod),
                              FRel.GetnCol('Sobra')+1,Floattostr(sobra)  );
      end;
    end;
    FRel.Video();
    Sistema.EndProcess('');
    FGeral.fechaquery(Q);

  end;

  FRelProducao_Cortes;    // 1

end;

/////////////////////////////////////////////
procedure FRelProducao_CortescomEstoque;                // 4
type TCom=record
    codigo:string;
    comprimento:extended;
    qtde:currency
end;
var Q:TSqlquery;
    periodo,anterior,campos:string;
    totalprod,totalgeral,qtdeprod,totalsobra,sobra,estoque,estoquemaior,producao,faltaqtde,faltatam:extended;
    xcodtamanho:integer;
    Lista:TList;
    PCom:^TCom;

    function GetQtdeProducao(codigo:string;comp:extended):currency;
    var i:integer;
    begin
      result:=0;
      for i:=0 to Lista.count-1 do begin
         PCom:=Lista[i];
         if (PCom.codigo=codigo) and (PCom.comprimento=comp) then begin
           result:=PCom.qtde;
           break;
         end;
      end;
    end;

begin
  with FRelProducao do begin
    if not FRelProducao_Execute(1) then Exit;
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('movp_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      sqlperiodo:='and movp_datamvto>='+EdDatai.AsSql+' and movp_datamvto<='+EdDataf.AsSql
    else if (EdDatai.asdate>1)  then
      sqlperiodo:='and movp_datamvto>='+EdDatai.AsSql
    else if (EdDataf.asdate>1)  then
      sqlperiodo:='and movp_datamvto<='+EdDataF.AsSql
    else
      sqlperiodo:='';
    sqlnroobra:='';
    if not EdNroobra.isempty then
      sqlnroobra:=' and movp_nroobra='+EdNroobra.assql;
    Sistema.beginprocess('Lendo comprimentos a produzir');
    campos:='movp_tipo_codigo,movp_esto_codigo,movp_core_codigo,movp_tama_codigo,movp_coreg_codigo,movp_tamag_codigo,movp_qtdegeral';

    Q:=sqltoquery('select '+campos+',sum(movp_qtdeop) as movp_qtdeop'+
                  ' from movproducao'+
                  ' left join tamanhos on ( tama_codigo=movp_tamag_codigo )'+
                  ' left join cores on ( core_codigo=movp_core_codigo )'+
                  ' where movp_status=''N'''+
                  sqlperiodo+sqlnroobra+sqlunidade+
                  ' group by '+campos+
                  ' order by '+campos);
    if Q.eof then begin
      Avisoerro('Nada encontrado para impressão');
      Sistema.endprocess('');
      FGeral.fechaquery(Q);
      exit;
    end;
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      periodo:='Periodo : '+FGeral.FormataData(EdDatai.AsDate)+' a '+FGeral.FormataData(EdDataf.AsDate)
    else
      periodo:='';
    titobra:='';titcliente:='';titdata:='';
    if not EdNroobra.isempty then begin
       titobra:=' - Obra '+EdNroobra.text;
//       titcliente:=' - Cliente '+Q.fieldbyname('movp_tipo_codigo').AsString+' '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('movp_tipo_codigo').AsInteger,Q.fieldbyname('movp_tipocad').AsString,'N');
       titcliente:=' - Cliente '+Q.fieldbyname('movp_tipo_codigo').AsString+' '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('movp_tipo_codigo').AsInteger,'C','N');
//       titdata:=' - Data '+FGeral.formatadata(Q.fieldbyname('movp_datamvto').AsDatetime);
       titdata:='';
    end;
    FRel.Init('RelProducaoOpcomEstoque');
    FRel.AddTit('Relatório de Produção - Cortes considerando Estoque');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+titdata);
    FRel.AddTit(Periodo+titobra+titcliente);
    FRel.AddCol( 80,0,'N','' ,''              ,'Produto'         ,''         ,'',false);
    FRel.AddCol( 90,0,'C','' ,''              ,'Cor'             ,''         ,'',false);
    FRel.AddCol( 70,3,'N','' ,''              ,'Qtde'            ,''         ,'',false);
    FRel.AddCol( 70,0,'C','' ,''              ,'Tamanho'         ,''         ,'',false);
    FRel.AddCol( 80,3,'N','',''               ,'Tam.Total'       ,''         ,'',false);
    FRel.AddCol( 80,3,'N','' ,''              ,'Qtde Prod.'      ,''         ,'',false);
    FRel.AddCol( 80,0,'C','' ,''              ,'Tamanho Prod.'   ,''         ,'',false);
    FRel.AddCol( 80,3,'N','',''               ,'Total Prod.'       ,''         ,'',false);
//    FRel.AddCol( 60,3,'N','+' ,''             ,'Sobra'           ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,''             ,'Estoque Qtde'       ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,''             ,'Est.Qtde Maior'     ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,''             ,'Est.Tam. Maior'     ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,''             ,'Falta Qtde'     ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,''             ,'Falta Tam'     ,''         ,'',false);
    Lista:=TList.create;
    while not Q.eof do begin
      New(PCom);
      PCom.codigo:=Q.fieldbyname('movp_esto_codigo').AsString;
      PCom.comprimento:=FTamanhos.GetComprimento(Q.fieldbyname('movp_tamag_codigo').AsInteger);
      PCom.qtde:=Q.fieldbyname('movp_qtdeop').AsCurrency;
      Lista.Add(PCom);
      Q.Next;
    end;
    Q.First;
    Sistema.beginprocess('Gerando relatório');
    while not Q.eof do begin
      FRel.AddCel( FEstoque.GetDescricao( Q.fieldbyname('movp_esto_codigo').AsString));
      FRel.AddCel( FCores.GetDescricao( Q.fieldbyname('movp_core_codigo').AsInteger));
      FRel.AddCel( Q.fieldbyname('movp_qtdegeral').AsString);
      FRel.AddCel( FTamanhos.GetDescricao( Q.fieldbyname('movp_tama_codigo').AsInteger) );
      FRel.AddCel( floattostr(Q.fieldbyname('movp_qtdegeral').AsCurrency*FTamanhos.GetComprimento( Q.fieldbyname('movp_tama_codigo').AsInteger) ) );
      FRel.AddCel( Q.fieldbyname('movp_qtdeop').AsString);
      FRel.AddCel( FTamanhos.GetDescricao( Q.fieldbyname('movp_tamag_codigo').AsInteger));
      FRel.AddCel( floattostr(Q.fieldbyname('movp_qtdeop').AsCurrency*FTamanhos.GetComprimento(Q.fieldbyname('movp_tamag_codigo').AsInteger) ) );
      sobra:=( (Q.fieldbyname('movp_qtdegeral').AsCurrency*FTamanhos.GetComprimento(Q.fieldbyname('movp_tama_codigo').AsInteger)) ) -
              Q.fieldbyname('movp_qtdeop').AsCurrency*FTamanhos.GetComprimento(Q.fieldbyname('movp_tamag_codigo').AsInteger);
//      FRel.AddCel( floattostr(sobra) );
      estoque:=FEstoque.GetQtdeEmEstoque(copy(EdUnid_codigo.text,1,3),Q.fieldbyname('movp_esto_codigo').AsString,Q.fieldbyname('movp_core_codigo').AsInteger,
               Q.fieldbyname('movp_tamag_codigo').AsInteger);
      FRel.AddCel( floattostr(estoque) );
      xcodtamanho:=0;
      estoquemaior:=FEstoque.GetQtdeEmEstoqueComprimento(copy(EdUnid_codigo.text,1,3),Q.fieldbyname('movp_esto_codigo').AsString,xcodtamanho,Q.fieldbyname('movp_core_codigo').AsInteger,
                    FTamanhos.GetComprimento(Q.fieldbyname('movp_tamag_codigo').AsInteger) );
      producao:=GetQtdeProducao(Q.fieldbyname('movp_esto_codigo').AsString,FTamanhos.GetComprimento(xcodtamanho));
      if producao>estoquemaior then
        FRel.AddCel( '' )
      else
        FRel.AddCel( floattostr(estoquemaior-producao) );
      FRel.AddCel( FTamanhos.GetDescricao( xcodtamanho) );
      faltaqtde:=Q.fieldbyname('movp_qtdeop').AsCurrency-estoque-estoquemaior-producao;
      if faltaqtde>0 then
        faltatam:=faltaqtde*FTamanhos.GetComprimento(Q.fieldbyname('movp_tamag_codigo').AsInteger)
      else begin
        faltatam:=0;
        faltaqtde:=0;
      end;
      FRel.AddCel( floattostr(faltaqtde) );
      FRel.AddCel( floattostr(faltatam) );
      Q.Next;
    end;
    FRel.Video();
    Sistema.EndProcess('');
    FGeral.fechaquery(Q);
    Lista.free;
  end;

  FRelProducao_CortescomEstoque;    // 4

end;

////////////////////////////////////////////

procedure FRelProducao_Barras;                // 2
////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    periodo,anterior:string;
    totalpeso,subtotalpeso,totalsobra,subtotalsobra,persobra:extended;
begin
  with FRelProducao do begin
    if not FRelProducao_Execute(2) then Exit;
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      sqlperiodo:='and move_datamvto>='+EdDatai.AsSql+' and move_datamvto<='+EdDataf.AsSql
    else if (EdDatai.asdate>1)  then
      sqlperiodo:='and move_datamvto>='+EdDatai.AsSql
    else if (EdDataf.asdate>1)  then
      sqlperiodo:='and move_datamvto<='+EdDataF.AsSql
    else
      sqlperiodo:='';
    sqlnroobra:='';
    if not EdNroobra.isempty then
      sqlnroobra:=' and move_nroobra='+EdNroobra.assql;
    Sistema.beginprocess('Gerando relatório');
    Q:=sqltoquery('select * from movestoque inner join movesto on ( moes_transacao=move_transacao and moes_status=move_status)'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' left join tamanhos on ( tama_codigo=move_tama_codigo )'+
                  ' left join cores on ( core_codigo=move_core_codigo )'+
                  ' where move_status=''R'''+
                  sqlperiodo+sqlnroobra+sqlunidade+
                  ' order by core_descricao,esto_referencia');
    if Q.eof then begin
      Avisoerro('Nada encontrado para impressão');
      Sistema.endprocess('');
      FGeral.fechaquery(Q);
      exit;
    end;
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      periodo:='Periodo : '+FGeral.FormataData(EdDatai.AsDate)+' a '+FGeral.FormataData(EdDataf.AsDate)
    else
      periodo:='';
    titobra:='';titcliente:='';titdata:='';
    if not EdNroobra.isempty then begin
       titobra:=' - Obra '+EdNroobra.text;
       titcliente:=' - Cliente '+Q.fieldbyname('move_tipo_codigo').AsString+' '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('move_tipo_codigo').AsInteger,Q.fieldbyname('move_tipocad').AsString,'N');
       titdata:=' - Data '+FGeral.formatadata(Q.fieldbyname('move_datamvto').AsDatetime);
    end;
    FRel.Init('RelBarras');
    FRel.AddTit('Relatório de Barras');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+titdata);
    FRel.AddTit(Periodo+titobra+titcliente );
    FRel.AddCol(090,0,'C','' ,''              ,'Transação'       ,''         ,'',False);
    if EdNroobra.isempty then begin
      FRel.AddCol( 60,1,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
      FRel.AddCol( 45,0,'C','' ,''              ,'Cliente'         ,''         ,'',false);
      FRel.AddCol(120,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
    end;
    FRel.AddCol( 80,0,'N','' ,''              ,'Produto'         ,''         ,'',false);
    FRel.AddCol( 90,0,'C','' ,''              ,'Cor'             ,''         ,'',false);
    FRel.AddCol( 70,3,'N','' ,''              ,'Qtde'            ,''         ,'',false);
    FRel.AddCol( 65,0,'C','' ,''              ,'Tamanho'         ,''         ,'',false);
    FRel.AddCol( 65,3,'N','' ,'####0.000'     ,'Peso'            ,''         ,'',false);
    FRel.AddCol( 65,3,'N','' ,'####0.000'     ,'Sobra'           ,''         ,'',false);
    FRel.AddCol( 45,3,'N','' ,'####0.00'      ,'Sobra(%)'        ,''         ,'',false);
    totalpeso:=0;subtotalpeso:=0;totalsobra:=0;subtotalsobra:=0;
    while not Q.eof do begin
      FRel.AddCel( Q.fieldbyname('move_transacao').AsString );
      if EdNroobra.isempty then begin
        FRel.AddCel( Q.fieldbyname('move_datamvto').AsString);
        FRel.AddCel( Q.fieldbyname('move_numerodoc').AsString);
        FRel.AddCel( Q.fieldbyname('move_tipo_codigo').AsString);
        FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('move_tipo_codigo').AsInteger,Q.fieldbyname('move_tipocad').AsString,'N' ));
      end;
      FRel.AddCel( Q.fieldbyname('esto_referencia').AsString);
      FRel.AddCel( FCores.GetDescricao( Q.fieldbyname('move_core_codigo').AsInteger));
      FRel.AddCel( Q.fieldbyname('move_qtde').AsString);
      FRel.AddCel( FTamanhos.GetDescricao( Q.fieldbyname('move_tama_codigo').AsInteger) );
      FRel.AddCel( floattostr(Q.fieldbyname('move_peso').AsFloat) );
      FRel.AddCel( floattostr(Q.fieldbyname('move_pesosobra').AsFloat) );
      persobra:=0;
      if Q.fieldbyname('move_peso').AsFloat>0 then
        persobra:=(Q.fieldbyname('move_pesosobra').AsFloat/Q.fieldbyname('move_peso').AsFloat)*100;
      FRel.AddCel( floattostr(persobra) );
      anterior:=Q.fieldbyname('core_descricao').asstring;
      totalpeso:=totalpeso+Q.fieldbyname('move_peso').Asfloat;
      subtotalpeso:=subtotalpeso+Q.fieldbyname('move_peso').Asfloat;
      totalsobra:=totalsobra+Q.fieldbyname('move_pesosobra').Asfloat;
      subtotalsobra:=subtotalsobra+Q.fieldbyname('move_pesosobra').Asfloat;
//      sobra:=( (Q.fieldbyname('movp_qtdegeral').AsCurrency*FTamanhos.GetComprimento(Q.fieldbyname('movp_tama_codigo').AsInteger)) ) -
//              Q.fieldbyname('movp_qtdeop').AsCurrency*Q.fieldbyname('tama_comprimento').AsFloat;
//      totalsobra:=totalsobra+sobra;
      Q.Next;
      if not Q.Eof then begin
        if (Q.fieldbyname('core_descricao').asstring)<>anterior then begin
//          sobra:=totalgeral-totalprod;
          persobra:=0;
          if subtotalpeso>0 then
            persobra:=(subtotalsobra/subtotalpeso)*100;
          FGeral.PulalinhaRel(Frel.GCol.ColCount,FREl.GetnCol('Peso')+1,floattostr(subtotalpeso),FREl.GetnCol('Sobra')+1,floattostr(subtotalsobra),
                              FREl.GetnCol('Sobra(%)')+1,floattostr(persobra)   );
          subtotalpeso:=0;
          subtotalsobra:=0;
        end;
      end else begin
//          sobra:=totalgeral-totalprod;
          FGeral.PulalinhaRel(Frel.GCol.ColCount  );
      end;
    end;
    persobra:=0;
    if totalpeso>0 then
      persobra:=(totalsobra/totalpeso)*100;
    FGeral.PulalinhaRel(Frel.GCol.ColCount,FREl.GetnCol('Peso')+1,floattostr(totalpeso), FREl.GetnCol('Sobra')+1,floattostr(totalsobra),
                        FREl.GetnCol('Sobra(%)')+1,floattostr(persobra)      );
    FRel.Video();
    Sistema.EndProcess('');
    FGeral.fechaquery(Q);

  end;

  FRelProducao_Barras;    // 2

end;



procedure FRelProducao_ItensdaObra;           // 3
/////////////////////////////////////////////////////
var Q:TSqlquery;
    periodo,anterior:string;
    totalpeso,subtotalpeso,totalarea,subtotalarea:extended;
    pesoitem:currency;
begin
  with FRelProducao do begin
    if not FRelProducao_Execute(3) then Exit;
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('movo_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      sqlperiodo:='and movo_datamvto>='+EdDatai.AsSql+' and movo_datamvto<='+EdDataf.AsSql
    else if (EdDatai.asdate>1)  then
      sqlperiodo:='and movo_datamvto>='+EdDatai.AsSql
    else if (EdDataf.asdate>1)  then
      sqlperiodo:='and movo_datamvto<='+EdDataF.AsSql
    else
      sqlperiodo:='';
    sqlnroobra:='';
    if not EdNroobra.isempty then
      sqlnroobra:=' and movo_nroobra='+EdNroobra.assql;
    Sistema.beginprocess('Gerando relatório');
    Q:=sqltoquery('select * from movobrasdet'+
                  ' inner join estoque on ( esto_codigo=movo_esto_codigo )'+
                  ' left join cores on ( core_codigo=movo_core_codigo )'+
                  ' where movo_status=''N'''+
                  sqlperiodo+sqlnroobra+sqlunidade+
                  ' order by esto_referencia');
    if Q.eof then begin
      Avisoerro('Nada encontrado para impressão');
      Sistema.endprocess('');
      FGeral.fechaquery(Q);
      exit;
    end;
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      periodo:='Periodo : '+FGeral.FormataData(EdDatai.AsDate)+' a '+FGeral.FormataData(EdDataf.AsDate)
    else
      periodo:='';
    titobra:='';titcliente:='';titdata:='';
    if not EdNroobra.isempty then begin
       titobra:=' - Obra '+EdNroobra.text;
       titcliente:=' - Cliente '+Q.fieldbyname('movo_tipo_codigo').AsString+' '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('movo_tipo_codigo').AsInteger,Q.fieldbyname('movo_tipocad').AsString,'N');
       titdata:=' - Data '+FGeral.formatadata(Q.fieldbyname('movo_datamvto').AsDatetime);
    end;
    FRel.Init('RelItensdaObra');
    FRel.AddTit('Relatório de Itens da Obra');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+titdata);
    FRel.AddTit(Periodo+titobra+titcliente );
    FRel.AddCol(090,0,'C','' ,''              ,'Transação'       ,''         ,'',False);
    if EdNroobra.isempty then begin
      FRel.AddCol( 60,1,'D','' ,''              ,'Emissão'         ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
      FRel.AddCol( 45,0,'C','' ,''              ,'Cliente'         ,''         ,'',false);
      FRel.AddCol(120,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
    end;
    FRel.AddCol( 80,0,'N','' ,''              ,'Produto'         ,''         ,'',false);
//    FRel.AddCol( 90,0,'C','' ,''              ,'Cor'             ,''         ,'',false);
    FRel.AddCol( 70,3,'N','' ,''              ,'Qtde'            ,''         ,'',false);
    FRel.AddCol( 65,3,'N','' ,''              ,'Largura'         ,''         ,'',false);
    FRel.AddCol( 65,3,'N','' ,''              ,'Altura'          ,''         ,'',false);
    FRel.AddCol(180,1,'C','' ,''              ,'Localização'     ,''         ,'',false);
    FRel.AddCol( 65,3,'N','' ,f_cr            ,'Área'            ,''         ,'',false);
    FRel.AddCol( 65,3,'N','' ,'##0.000'       ,'Peso Uni'        ,''         ,'',false);
    FRel.AddCol( 65,3,'N','' ,'###0.000'      ,'Peso Total'      ,''         ,'',false);
    totalpeso:=0;subtotalpeso:=0;totalarea:=0;subtotalarea:=0;
    while not Q.eof do begin
      FRel.AddCel( Q.fieldbyname('movo_transacao').AsString );
      if EdNroobra.isempty then begin
        FRel.AddCel( Q.fieldbyname('movo_datamvto').AsString);
        FRel.AddCel( Q.fieldbyname('movo_numerodoc').AsString);
        FRel.AddCel( Q.fieldbyname('movo_tipo_codigo').AsString);
        FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('movo_tipo_codigo').AsInteger,Q.fieldbyname('movo_tipocad').AsString,'N' ));
      end;
      FRel.AddCel( Q.fieldbyname('esto_referencia').AsString);
//      FRel.AddCel( FCores.GetDescricao( Q.fieldbyname('movo_core_codigo').AsInteger));
      FRel.AddCel( Q.fieldbyname('movo_qtdegeral').AsString );
      FRel.AddCel( floattostr(Q.fieldbyname('movo_largura').AsFloat) );
      FRel.AddCel( floattostr(Q.fieldbyname('movo_altura').AsFloat) );
      FRel.AddCel( Q.fieldbyname('movo_descricaoobra').AsString );
      FRel.AddCel( floattostr(Q.fieldbyname('movo_area').AsFloat) );
      FRel.AddCel( floattostr(Q.fieldbyname('movo_peso').AsFloat) );
      pesoitem:=Q.fieldbyname('movo_peso').AsFloat*Q.fieldbyname('movo_qtdegeral').Ascurrency;
      FRel.AddCel( floattostr(pesoitem) );
      anterior:=Q.fieldbyname('esto_referencia').asstring;
      totalpeso:=totalpeso+pesoitem;
      subtotalpeso:=subtotalpeso+pesoitem;
      totalarea:=totalarea+Q.fieldbyname('movo_area').Asfloat;
      subtotalarea:=subtotalarea+Q.fieldbyname('movo_area').Asfloat;
      Q.Next;
      if not Q.Eof then begin
        if (Q.fieldbyname('esto_referencia').asstring)<>anterior then begin
          FGeral.PulalinhaRel(Frel.GCol.ColCount,FREl.GetnCol('Área')+1,floattostr(subtotalarea),FREl.GetnCol('Peso Total')+1,floattostr(subtotalpeso) );
          subtotalpeso:=0;
          subtotalarea:=0;
        end;
      end else begin
          FGeral.PulalinhaRel(Frel.GCol.ColCount  );
      end;
    end;
    if totalpeso>0 then
       FGeral.PulalinhaRel(Frel.GCol.ColCount,FREl.GetnCol('Área')+1,floattostr(totalarea),FREl.GetnCol('Peso Total')+1,floattostr(totalpeso) );
    FRel.Video();
    Sistema.EndProcess('');
    FGeral.fechaquery(Q);

  end;
  FRelProducao_ItensdaObra;           // 3
end;


// 09.10.13
procedure FRelProducao_NotasFichaTecnica;          // 5
/////////////////////////////////////////////
var Q,QNF,QE:TSqlquery;
    periodo:string;
    totalitem:currency;
    xemissao:TDatetime;

    // 30.08.19
    function EquipamentoOK( xcodequi:string):boolean;
    /////////////////////////////////////////////////
    begin

       if not FRelProducao.edEqui_codigo.isempty then begin

          result:=(FRelProducao.EdEqui_codigo.text=xcodequi)

       end else result:=true;


    end;


begin

  with FRelProducao do begin

    if not FRelProducao_Execute(5) then Exit;
//    if trim(EdUnid_codigo.text)<>'' then
//      sqlunidade:=' and '+FGeral.getin('movo_unid_codigo',EdUnid_codigo.text,'C',)
//    else
//      sqlunidade:='';
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      sqlperiodo:='and moes_dataemissao>='+EdDatai.AsSql+' and moes_dataemissao<='+EdDataf.AsSql
    else if (EdDatai.asdate>1)  then
      sqlperiodo:='and moes_dataemissao>='+EdDatai.AsSql
    else if (EdDataf.asdate>1)  then
      sqlperiodo:='and moes_dataemissao<='+EdDataF.AsSql
    else
      sqlperiodo:='';
    sqlequipamentos:='';
    sqlprodutos:='';
    titproduto:='';titequipamento:='';
    if not EdProduto.IsEmpty then begin
      sqlprodutos:=' and move_esto_codigo='+EdProduto.AsSql;
      titproduto:=' - Produto :'+EdProduto.Text+' '+SetEdESTO_DESCRICAO.text;
    end;
    if not EdEqui_codigo.IsEmpty then begin

      titequipamento:=' - Equipamento :'+EdEqui_codigo.text+' '+SetEdCLIE_NOME.text;

    end;

    Sistema.beginprocess('Gerando relatório');
    QNF:=sqltoquery('select * from movestoque'+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where move_status=''N'''+
                  ' and '+FGeral.GetIN('move_tipomov',Global.TiposEntrada,'C')+
                  sqlperiodo+sqlequipamentos+sqlprodutos+
                  ' and move_remessas is not null'+
                  ' order by move_remessas');

    if QNF.eof then begin
      Avisoerro('Nada encontrado para impressão');
      Sistema.endprocess('');
      FGeral.fechaquery(QNF);
      exit;
    end;

    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      periodo:='Periodo : '+FGeral.FormataData(EdDatai.AsDate)+' a '+FGeral.FormataData(EdDataf.AsDate)
    else
      periodo:='';
    FRel.Init('RelNotasManutencaoEquipamentos');
    FRel.AddTit('Relatório de Notas X Manutenção de Equipamentos'+titequipamento+titproduto);
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+titdata);
    FRel.AddTit( Periodo );
    FRel.AddCol( 60,1,'D','' ,''              ,'Data'            ,''         ,'',false);
    FRel.AddCol(200,1,'C','' ,''              ,'Equipamento'     ,''         ,'',false);
    FRel.AddCol( 60,2,'N','' ,''              ,'Numero'          ,''         ,'',False);
    FRel.AddCol(150,1,'C','' ,''              ,'Item '           ,''         ,'',false);
    FRel.AddCol(060,3,'N','' ,f_quanti        ,'Horas/KM'        ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Emissão'         ,''         ,'',false);
    FRel.AddCol( 70,2,'N','' ,''              ,'Numero NF'       ,''         ,'',False);
    FRel.AddCol( 45,0,'C','' ,''              ,'Fornec.'         ,''         ,'',false);
    FRel.AddCol(160,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
    FRel.AddCol(160,0,'N','' ,''              ,'Produto'         ,''         ,'',false);
    FRel.AddCol( 60,3,'N','+' ,f_cr            ,'Qtde'            ,''         ,'',false);
    FRel.AddCol( 65,3,'N','' ,f_cr            ,'Unitário'        ,''         ,'',false);
    FRel.AddCol( 65,3,'N','+' ,f_cr            ,'Total Item'      ,''         ,'',false);

    Q:=sqltoquery('select * from movestoque'+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where move_status=''N'''+
                  ' and move_tipomov='+Stringtosql(Global.CodManutencaoEquipamento)+
                  sqlperiodo+sqlequipamentos+sqlprodutos+
                  ' order by move_datamvto,move_esto_codigo');

    while not Q.eof do begin

////////////////////////////
{
      if copy(QNf.fieldbyname('move_remessas').asstring,1,12)<>strzero(0,12) then begin
        Q:=sqltoquery('select * from movestoque'+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where move_status=''N'''+
                  ' and move_operacao='+Stringtosql(trim(copy(QNf.fieldbyname('move_remessas').asstring,1,12)))+
                  ' and move_tipomov='+Stringtosql(Global.CodManutencaoEquipamento)+
                  ' order by move_datamvto,move_esto_codigo');
        QE:=sqltoquery('select * from equipamentos where equi_codigo='+Stringtosql(Strzero(Q.fieldbyname('moes_tipo_codigo').asinteger,4)));
      end else begin
        Q:=sqltoquery('select * from movestoque'+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where move_status=''N'''+
                  ' and move_operacao='+Stringtosql(trim(QNf.fieldbyname('move_remessas').asstring))+
                  ' and move_tipomov='+Stringtosql(Global.CodManutencaoEquipamento)+
                  ' order by move_datamvto,move_esto_codigo');
        QE:=sqltoquery('select * from equipamentos where equi_codigo='+Stringtosql(copy(QNF.fieldbyname('move_remessas').asstring,14,4)));
      end;
      }
//////////////////////////
      xemissao:=Q.fieldbyname('moes_dataemissao').AsDateTime;
      while (not Q.eof) and (xemissao=Q.fieldbyname('moes_dataemissao').AsDatetime) do begin


        if EquipamentoOK( copy(Q.fieldbyname('move_remessas').asstring,14,4)  ) then begin

          QE:=sqltoquery('select * from equipamentos where equi_codigo='+Stringtosql(Strzero(Q.fieldbyname('moes_tipo_codigo').asinteger,4)));
          FRel.AddCel( Q.fieldbyname('moes_dataemissao').AsString);
          FRel.AddCel( QE.fieldbyname('equi_descricao').AsString);
          FRel.AddCel( Q.fieldbyname('moes_numerodoc').AsString);
          FRel.AddCel( Q.fieldbyname('esto_descricao').AsString);
          FRel.AddCel( Q.fieldbyname('move_qtde').AsString);
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          totalitem:=0;
          FRel.AddCel( floattostr(totalitem));

        end;

        Q.Next;

      end;

      QNF:=sqltoquery('select * from movestoque'+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where move_status=''N'''+
                  ' and '+FGeral.GetIN('move_tipomov',Global.TiposEntrada,'C')+
                  ' and moes_dataemissao = '+Datetosql(xemissao)+
                  ' and move_remessas is not null'+
                  ' order by move_remessas');

      while not QNf.eof do begin

          if EquipamentoOK( copy(QNF.fieldbyname('move_remessas').asstring,14,4)  ) then begin

            QE:=sqltoquery('select * from equipamentos where equi_codigo='+Stringtosql(copy(QNF.fieldbyname('move_remessas').asstring,14,4)));
            FRel.AddCel( '' );
            FRel.AddCel( QE.fieldbyname('equi_descricao').AsString);
            FRel.AddCel( '');
            FRel.AddCel( '' );
            FRel.AddCel( '');
            FRel.AddCel( QNF.fieldbyname('moes_dataemissao').AsString);
            FRel.AddCel( QNF.fieldbyname('moes_numerodoc').AsString);
            FRel.AddCel( QNF.fieldbyname('moes_tipo_codigo').AsString);
            FRel.AddCel( FGeral.GetNomeRazaoSocialEntidade(QNF.fieldbyname('moes_tipo_codigo').AsInteger,QNF.fieldbyname('moes_tipocad').AsString,'N'));
            FRel.AddCel( QNF.fieldbyname('esto_descricao').AsString);
            FRel.AddCel( QNF.fieldbyname('move_qtde').AsString);
            FRel.AddCel( QNF.fieldbyname('move_venda').AsString);
            totalitem := QNF.fieldbyname('move_qtde').Ascurrency*QNF.fieldbyname('move_venda').Ascurrency;
            FRel.AddCel( floattostr(totalitem));

          end;

          QNf.Next;

      end;
      FGeral.fechaquery(QNF);

    end;

    FRel.Video();
    Sistema.EndProcess('');
    FGeral.fechaquery(Q);

  end;

  FRelProducao_NotasFichaTecnica;          // 5


end;

///////////////////////////////////////////////////////////
procedure FRelProducao_FichaTecnica;          // 6
//////////////////////////////////////////////////////////////////
var Q,QE:TSqlquery;
    periodo,
    anterior :string;
    totalitem : currency;

begin

  with FRelProducao do begin

    if not FRelProducao_Execute(6) then Exit;
//    if trim(EdUnid_codigo.text)<>'' then
//      sqlunidade:=' and '+FGeral.getin('movo_unid_codigo',EdUnid_codigo.text,'C',)
//    else
//      sqlunidade:='';
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      sqlperiodo:='and moes_dataemissao>='+EdDatai.AsSql+' and moes_dataemissao<='+EdDataf.AsSql
    else if (EdDatai.asdate>1)  then
      sqlperiodo:='and moes_dataemissao>='+EdDatai.AsSql
    else if (EdDataf.asdate>1)  then
      sqlperiodo:='and moes_dataemissao<='+EdDataF.AsSql
    else
      sqlperiodo:='';
    sqlequipamentos:='';
    sqlprodutos:='';
    titproduto:='';titequipamento:='';
    if not EdProduto.IsEmpty then begin

      sqlprodutos:=' and move_esto_codigo='+EdProduto.AsSql;
      titproduto:=' - Produto :'+EdProduto.Text+' '+SetEdESTO_DESCRICAO.text;

    end;
    if not EdEqui_codigo.IsEmpty then
      titequipamento:=' - Equipamento :'+EdEqui_codigo.text+' '+SetEdCLIE_NOME.text+
// 23.09.2021 - Leila - A2z
                      ' Nro Série :'+EdEqui_codigo.resultfind.fieldbyname('Equi_numserie').asstring;

    Sistema.beginprocess('Gerando relatório');
    Q:=sqltoquery('select *  from movestoque'+
                  ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where move_status=''N'''+
                  ' and move_tipomov='+Stringtosql(Global.CodManutencaoEquipamento)+
                  sqlperiodo+sqlequipamentos+sqlprodutos+
//                  ' order by move_datamvto,move_esto_codigo');
// 23.09.2021
                  ' order by move_datamvto,move_numerodoc');

    if Q.eof then begin

      Avisoerro('Nada encontrado para impressão');
      Sistema.endprocess('');
      FGeral.fechaquery(Q);
      exit;

    end;
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      periodo:='Periodo : '+FGeral.FormataData(EdDatai.AsDate)+' a '+FGeral.FormataData(EdDataf.AsDate)
    else
      periodo:='';
    FRel.Init('RelManutencaoEquipamentos');
    FRel.AddTit('Relatório de Manutenção de Equipamentos'+titequipamento+titproduto);
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
    FRel.AddTit( Periodo );
    FRel.AddCol( 60,1,'D','' ,''              ,'Data'            ,''         ,'',false);
// 13.10.2021 - A2z
    FRel.AddCol(060,2,'C','' ,''              ,'Prev/Corr'     ,''         ,'',false);
    FRel.AddCol(180,1,'C','' ,''              ,'Equipamento'     ,''         ,'',false);
    FRel.AddCol( 70,2,'N','' ,''              ,'Numero'          ,''         ,'',False);
    FRel.AddCol(180,1,'C','' ,''              ,'Item '           ,''         ,'',false);
    FRel.AddCol(070,3,'N','' ,f_cr            ,'Horímetro/KM'        ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,f_cr            ,'Consumo'     ,''         ,'',false);
    FRel.AddCol( 65,3,'N','' ,f_cr            ,'Unitário'        ,''         ,'',false);
    FRel.AddCol( 65,3,'N','+' ,f_cr           ,'Total Item'      ,''         ,'',false);
    FRel.AddCol(300,1,'C','' ,''              ,'Obs'           ,''         ,'',false);
    FRel.AddCol(300,1,'C','' ,''              ,'Obs 1'           ,''         ,'',false);

    anterior := 'ewewe';
    while not Q.eof do begin

      QE:=sqltoquery('select * from equipamentos where equi_codigo='+Stringtosql(Strzero(Q.fieldbyname('moes_tipo_codigo').asinteger,4)));
      if ( EdEqui_codigo.isempty ) or ( EdEqui_codigo.Text=QE.fieldbyname('equi_codigo').asstring ) then begin

        FRel.AddCel( Q.fieldbyname('moes_dataemissao').AsString);
        FRel.AddCel( Q.fieldbyname('moes_rcmagazine').AsString);
        FRel.AddCel( QE.fieldbyname('equi_descricao').AsString);
        FRel.AddCel( Q.fieldbyname('moes_numerodoc').AsString);
        FRel.AddCel( Q.fieldbyname('esto_descricao').AsString);
        FRel.AddCel( Q.fieldbyname('move_qtde').AsString);
        FRel.AddCel( Q.fieldbyname('move_pecas').AsString);
// 01.10.2021
        FRel.AddCel( Q.fieldbyname('move_venda').AsString);
//        totalitem := roundvalor( Q.fieldbyname('move_venda').Ascurrency*Q.fieldbyname('move_qtde').Ascurrency );
        totalitem := roundvalor( Q.fieldbyname('move_venda').Ascurrency*Q.fieldbyname('move_pecas').Ascurrency );
        FRel.AddCel( floattostr(totalitem) );

// 20.01.20
        if Q.fieldbyname('moes_numerodoc').AsString<>anterior then

           FRel.AddCel( Q.fieldbyname('moes_mensagem').AsString)

        else

           FRel.AddCel( '' );
// 07.10.2021
        if Q.fieldbyname('moes_numerodoc').AsString<>anterior then

           FRel.AddCel( Q.fieldbyname('moes_devolucoes').AsString)

        else

           FRel.AddCel( '' );

      end;

      anterior := Q.fieldbyname('moes_numerodoc').AsString;
      Q.Next;
      FGeral.FechaQuery(QE);

    end;

    FRel.Video();
    Sistema.EndProcess('');
    FGeral.fechaquery(Q);

  end;

  FRelProducao_FichaTecnica;          // 6

end;

// 29.11.13
procedure FRelProducao_ProximasTrocas;          // 7
///////////////////////////////////////////////
var QE,Q:TSqlquery;
    periodo,masc,sqlgrupostrocaoleo,grupostrocaoleo:string;
    xop:integer;
begin
  with FRelProducao do begin
    if not FRelProducao_Execute(7) then Exit;
//    if trim(EdUnid_codigo.text)<>'' then
//      sqlunidade:=' and '+FGeral.getin('movo_unid_codigo',EdUnid_codigo.text,'C',)
//    else
//      sqlunidade:='';
    Sistema.beginprocess('Gerando relatório');
    QE:=sqltoquery('select * from equipamentos order by equi_descricao');
    if QE.eof then begin
      Avisoerro('Nada encontrado para impressão');
      Sistema.endprocess('');
      FGeral.fechaquery(Qe);
      exit;
    end;
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      sqlperiodo:='and moes_dataemissao>='+EdDatai.AsSql+' and moes_dataemissao<='+EdDataf.AsSql
    else if (EdDatai.asdate>1)  then
      sqlperiodo:='and moes_dataemissao>='+EdDatai.AsSql
    else if (EdDataf.asdate>1)  then
      sqlperiodo:='and moes_dataemissao<='+EdDataF.AsSql
    else
      sqlperiodo:='';
    sqlequipamentos:='';
    sqlprodutos:='';
    titproduto:='';titequipamento:='';
    if not EdProduto.IsEmpty then begin
      sqlprodutos:=' and move_esto_codigo='+EdProduto.AsSql;
      titproduto:=' - Produto :'+EdProduto.Text+' '+SetEdESTO_DESCRICAO.text;
    end;
// 24.09.14
    sqlgrupostrocaoleo:='';
    grupostrocaoleo:=FGeral.getconfig1asstring('grupostrocaoleo');
    if trim(grupostrocaoleo)<>'' then
      sqlgrupostrocaoleo:=' and '+FGeral.getin('esto_fami_codigo',GruposTrocaOleo,'N');
    if not EdEqui_codigo.IsEmpty then
      titequipamento:=' - Equipamento :'+EdEqui_codigo.text+' '+SetEdCLIE_NOME.text;

    Sistema.beginprocess('Gerando relatório');
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      periodo:='Periodo : '+FGeral.FormataData(EdDatai.AsDate)+' a '+FGeral.FormataData(EdDataf.AsDate)
    else
      periodo:='';
    FRel.Init('RelProximaTrocaEquipamentos');
    FRel.AddTit('Relatório de Próximas Trocas dos Equipamentos');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+titdata);
    FRel.AddTit( Periodo );
    FRel.AddCol(060,1,'C','' ,''              ,'Codigo'     ,''         ,'',false);
    FRel.AddCol(200,1,'C','' ,''              ,'Equipamento'     ,''         ,'',false);
    FRel.AddCol(070,3,'N','' ,''              ,'Atual'        ,''         ,'',false);
//    FRel.AddCol(080,3,'N','' ,''              ,'Doc.'     ,''         ,'',false);
//    FRel.AddCol(200,1,'C','' ,''              ,'Descrição'     ,''         ,'',false);
{
    FRel.AddCol(080,1,'D','' ,''              ,'Data'     ,''         ,'',false);
    FRel.AddCol(080,3,'N','' ,''              ,'Hor./KM'     ,''         ,'',false);
    FRel.AddCol(070,3,'N','' ,''              ,'Dif.H/KM'     ,''         ,'',false);
    FRel.AddCol(080,3,'N','' ,''              ,'Litros/Qtde'     ,''         ,'',false);
}
/////////
    masc:=f_quanti;
    FRel.AddCol(070,3,'N','' ,masc            ,'Óleo Motor'        ,''         ,'',false);
    FRel.AddCol(080,3,'N','' ,masc            ,'Óleo Hidráulico'        ,''         ,'',false);
    FRel.AddCol(070,3,'N','' ,masc            ,'Óleo Diesel'        ,''         ,'',false);
    FRel.AddCol(070,3,'N','' ,masc            ,'Óleo Transmissão'        ,''         ,'',false);
    FRel.AddCol(070,3,'N','' ,masc            ,'Óleo Giro'        ,''         ,'',false);
    FRel.AddCol(070,3,'N','' ,masc            ,'Filtro Motor'        ,''         ,'',false);
    FRel.AddCol(080,3,'N','' ,masc            ,'Filtro Hidráulico'        ,''         ,'',false);
    FRel.AddCol(070,3,'N','' ,masc            ,'Filtro Diesel'        ,''         ,'',false);
    FRel.AddCol(070,3,'N','' ,masc            ,'Filtro Ar'        ,''         ,'',false);
////////
//    QE:=sqltoquery('select * from equipamentos where equi_codigo='+Stringtosql(Strzero(Q.fieldbyname('moes_tipo_codigo').asinteger,4)));
    QE:=sqltoquery('select * from equipamentos order by equi_descricao');
    while not QE.eof do begin

      FRel.AddCel( QE.fieldbyname('equi_codigo').AsString);
      FRel.AddCel( QE.fieldbyname('equi_descricao').AsString);
      FRel.AddCel( FGEral.Formatavalor(QE.fieldbyname('Equi_horimetro').Ascurrency,f_quanti,0));
      FRel.AddCel( QE.fieldbyname('Equi_oleomotor').AsString);
      FRel.AddCel( QE.fieldbyname('Equi_oleohidra').AsString);
      FRel.AddCel( QE.fieldbyname('Equi_oleodiesel').AsString);
      FRel.AddCel( QE.fieldbyname('Equi_oleotransmissao').AsString);
      FRel.AddCel( QE.fieldbyname('Equi_oleogiro').AsString);
      FRel.AddCel( QE.fieldbyname('Equi_filtromotor').AsString);
      FRel.AddCel( QE.fieldbyname('Equi_filtrohidra').AsString);
      FRel.AddCel( QE.fieldbyname('Equi_filtrodiesel').AsString);
      FRel.AddCel( QE.fieldbyname('Equi_filtroar').AsString);

      xop:=0;

      Q:=sqltoquery('select * from movestoque'+
                   ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                   ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                   ' where move_status=''N'''+
                   ' and move_tipomov='+Stringtosql(Global.CodManutencaoEquipamento)+
////                   ' and esto_descricao like ''%Troca%'''+
                   ' and moes_tipo_codigo='+QE.fieldbyname('equi_codigo').AsString+
                   sqlgrupostrocaoleo+
                   sqlperiodo+sqlequipamentos+sqlprodutos+
                  ' order by move_tipo_codigo,move_datamvto,move_esto_codigo');
      while ( not Q.eof ) and  ( QE.fieldbyname('equi_codigo').AsString=Strzero(Q.fieldbyname('moes_tipo_codigo').asinteger,4) ) do begin
        if ( EdEqui_codigo.isempty ) or ( EdEqui_codigo.Text=QE.fieldbyname('equi_codigo').asstring ) then begin
//          if xop=0 then begin
//            FRel.AddCel( QE.fieldbyname('equi_codigo').AsString);
//            FRel.AddCel( QE.fieldbyname('equi_descricao').AsString);
//            FRel.AddCel( QE.fieldbyname('Equi_horimetro').AsString)
//          end else begin
//            FRel.AddCel( '' );
//            FRel.AddCel( '' );
//          end;
          xop:=1;
//          FRel.AddCel( Q.fieldbyname('moes_numerodoc').AsString);
          FRel.AddCel( Q.fieldbyname('moes_dataemissao').AsString);
          FRel.AddCel( Q.fieldbyname('esto_descricao').AsString);
          FRel.AddCel( FGeral.Formatavalor( Q.fieldbyname('move_qtde').AsCurrency,f_quanti,0) );
          FRel.AddCel( floattostr(QE.fieldbyname('Equi_horimetro').AsCurrency-Q.fieldbyname('move_qtde').AsCurrency));
//          FRel.AddCel( Q.fieldbyname('move_pecas').AsString);
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
        end;
        Q.Next;
      end;
      FGeral.fechaquery(Q);
      if xop=1 then
//        FGeral.ImprimelinhaRel(FRel.GetnCol('Litros/Qtde')+1,space(40));
        FGeral.ImprimelinhaRel(FRel.GetnCol('Filtro Ar')+1,replicate('-',80));
//      FGeral.FechaQuery(QE);
       QE.Next;

    end;

    FRel.Video();
    Sistema.EndProcess('');
//    FGeral.fechaquery(Q);
    FGeral.FechaQuery(QE);

  end;

  FRelProducao_ProximasTrocas;          // 7

end;

// 09.12.13
procedure FRelProducao_MediaConsumo;          // 8
////////////////////////////////////////////////////////////
var QE,Qm:TSqlquery;
    periodo:string;
    percorrido,consumido,media,inicio,final:currency;

begin
  with FRelProducao do begin
    if not FRelProducao_Execute(8) then Exit;
//    if trim(EdUnid_codigo.text)<>'' then
//      sqlunidade:=' and '+FGeral.getin('movo_unid_codigo',EdUnid_codigo.text,'C',)
//    else
//      sqlunidade:='';
    if EdProduto.isempty then begin
       Avisoerro('Escolha o codigo do combustível para média');
       exit;
    end;
    QE:=sqltoquery('select * from equipamentos order by equi_descricao');
    if QE.eof then begin
      Avisoerro('Nada encontrado para impressão');
      Sistema.endprocess('');
      FGeral.fechaquery(Qe);
      exit;
    end;
//    Sistema.beginprocess('Calculando média no período informado');

    Sistema.beginprocess('Gerando relatório');
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      periodo:='Periodo : '+FGeral.FormataData(EdDatai.AsDate)+' a '+FGeral.FormataData(EdDataf.AsDate)
    else
      periodo:='';
// 26.02.14
    if (EdDatai.asdate>1) and (EdDataf.asdate>1) then
      sqlperiodo:='and moes_dataemissao>='+EdDatai.AsSql+' and moes_dataemissao<='+EdDataf.AsSql
    else if (EdDatai.asdate>1)  then
      sqlperiodo:='and moes_dataemissao>='+EdDatai.AsSql
    else if (EdDataf.asdate>1)  then
      sqlperiodo:='and moes_dataemissao<='+EdDataF.AsSql
    else
      sqlperiodo:='';
    sqlprodutos:=' and move_esto_codigo='+EdProduto.AsSql;
    if not EdEqui_codigo.IsEmpty then
      titequipamento:=' - Equipamento :'+EdEqui_codigo.text+' '+SetEdCLIE_NOME.text;

    FRel.Init('RelMediaConsumoEquipamentos');
    FRel.AddTit('Relatório de Média de Consumo de Combustível dos Equipamentos');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
    FRel.AddTit( Periodo+' - Combustível :'+EdProduto.text+' '+SetEdESTO_DESCRICAO.Text );
    FRel.AddCol(060,1,'C','' ,''              ,'Codigo'     ,''         ,'',false);
    FRel.AddCol(200,1,'C','' ,''              ,'Equipamento'     ,''         ,'',false);
    FRel.AddCol(080,3,'N','' ,f_cr            ,'Atual'        ,''         ,'',false);
    FRel.AddCol(080,3,'N','' ,f_cr            ,'Inicio'        ,''         ,'',false);
    FRel.AddCol(080,3,'N','' ,f_cr            ,'Final'        ,''         ,'',false);
    FRel.AddCol(080,3,'N','+' ,f_cr            ,'Percorrido'        ,''         ,'',false);
    FRel.AddCol(080,3,'N','+' ,f_cr            ,'Consumo'        ,''         ,'',false);
    FRel.AddCol(080,3,'N','' ,f_cr            ,'Média'        ,''         ,'',false);

    while not QE.eof do begin

      if ( EdEqui_codigo.isempty ) or ( EdEqui_codigo.Text=QE.fieldbyname('equi_codigo').asstring ) then begin
        FRel.AddCel( QE.fieldbyname('equi_codigo').AsString);
        FRel.AddCel( QE.fieldbyname('equi_descricao').AsString);
        FRel.AddCel( QE.fieldbyname('Equi_horimetro').AsString);
        sqlequipamentos:=' and moes_tipo_codigo='+inttostr(QE.fieldbyname('equi_codigo').asinteger);
        QM:=sqltoquery('select move_qtde,move_esto_codigo,move_pecas from movestoque'+
                    ' inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                    ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                    ' where move_status=''N'''+
                    ' and move_tipomov='+Stringtosql(Global.CodManutencaoEquipamento)+
                    sqlequipamentos+sqlprodutos+sqlperiodo+
                    ' order by move_datamvto');
        if not QM.eof then begin
          percorrido:=0;consumido:=0;media:=0;inicio:=0;final:=0;
          while not QM.eof do begin
            consumido:=consumido+QM.fieldbyname('move_pecas').ascurrency;
            if inicio=0 then inicio:=QM.fieldbyname('move_qtde').ascurrency;
            final:=QM.fieldbyname('move_qtde').ascurrency;
            QM.Next;
          end;
          FRel.AddCel( floattostr(inicio) );
          FRel.AddCel( floattostr(final) );
          FRel.AddCel( floattostr(final-inicio) );
          FRel.AddCel( floattostr(consumido) );
          if (final-inicio)>0 then
//            media:=(final-inicio)/consumido
            media:=consumido/(final-inicio)
          else
            media:=0;
          FRel.AddCel( floattostr(media) );
        end else begin
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
          FRel.AddCel( '' );
        end;
        FGeral.FechaQuery(QM);
      end;
      QE.Next;

    end;

    FRel.Video();
    Sistema.EndProcess('');
    FGeral.fechaquery(QE);

  end;

  FRelProducao_MediaConsumo;          // 8


end;

// 10.03.14 - SolMetal Mari
// 27.01.16 - Mettalum
procedure FRelProducao_CMVporPVOS;            // 9
///////////////////////////////////////////////////////
type TMateriais=record
     produto,unidade,nf,produtodesc,produtounid:string;
     qtde,unitario:currency;
end;

var Q,Q1:TSqlquery;
    sqlnumeroobra,produto,tiposvenda,titulo,sqlstatus,sqltipomovto,sqlproduto,xmpdd_unid_codigo,tit:string;
    vendaitem,customaterial,margembruta,vendatotal:currency;
    xnumerodoc,xmpdd_tipo_codigo,p:integer;
    PMateriais:^TMateriais;
    ListaM:TList;


    procedure Atualizalista;
    ///////////////////////
    var x:integer;
        found:boolean;
    begin
      found:=false;
      for x:=0 to ListaM.count-1 do begin
        PMateriais:=ListaM[x];
        if ( PMateriais.unidade=Q1.fieldbyname('move_unid_codigo').asstring ) and
///////////           ( PMateriais.nf=Q1.fieldbyname('move_nroobra').asstring ) and
           ( PMateriais.produto=Q1.fieldbyname('move_esto_codigo').asstring ) then begin
          found:=true;
          break;
        end;
      end;
      if not found then begin
        New(PMateriais);
        PMateriais.produto:=Q1.fieldbyname('move_esto_codigo').asstring;
        PMateriais.unidade:=Q1.fieldbyname('move_unid_codigo').asstring;
////////        PMateriais.nf:=Q1.fieldbyname('move_nroobra').asstring;
        PMateriais.qtde:=Q1.fieldbyname('move_qtde').ascurrency;
        PMateriais.produtodesc:=Q1.fieldbyname('esto_descricao').asstring;
        PMateriais.produtounid:=Q1.fieldbyname('esto_unidade').asstring;
        if copy(Q1.fieldbyname('move_esto_codigo').asstring,1,4)='DESP' then
          PMateriais.unitario:=Q1.fieldbyname('move_venda').ascurrency
        else
          PMateriais.unitario:=FEstoque.Getcusto(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,'custo');
        ListaM.add(PMateriais);
      end else begin
        if copy(Q1.fieldbyname('move_esto_codigo').asstring,1,4)='DESP' then
          PMateriais.unitario:=PMateriais.unitario+Q1.fieldbyname('move_venda').ascurrency;
        PMateriais.qtde:=PMateriais.qtde+Q1.fieldbyname('move_qtde').ascurrency;
      end;
    end;

    // 21.07.16
    function GetValorUnitario(xproduto,xtr:string):currency;
    ////////////////////////////////////////////////////////
    var Qx:TSqlquery;
    begin
      Qx:=sqltoquery('select move_venda from movestoque where move_esto_codigo='+Stringtosql(xproduto)+
                     ' and move_transacao='+Stringtosql(xtr)+' and move_status=''N''');
      result:=0;
      if not Qx.Eof then result:=Qx.fieldbyname('move_venda').ascurrency;
      FGeral.FechaQuery(Qx);
    end;

begin
////////////////////////////

  with FRelProducao do begin

    if not FRelProducao_Execute(09) then Exit;
    if trim(EdUnid_codigo.text)<>'' then
      sqlunidade:=' and '+FGeral.getin('mpdd_unid_codigo',EdUnid_codigo.text,'C')
    else
      sqlunidade:='';
    tiposvenda:=Global.CodPedVenda+';'+Global.CodOrdemdeServico;
    sqltipomovto:=' and '+FGeral.getin('mpdd_tipomov',tiposvenda,'C');
//    if EdCodtipo.isempty then
      sqlcodtipo:='';
//    else begin
//      if Edtipocad.text='R' then
//        sqlcodtipo:=' and mpdd_repr_codigo='+EdCodtipo.assql
//      else
//        sqlcodtipo:=' and mpdd_tipo_codigo='+EdCodtipo.assql;
//    end;
    if not EdProduto.isempty then
      sqlproduto:=' and '+FGeral.getin('mpdd_esto_codigo',EdProduto.text,'C')
    else
      sqlproduto:='';
    sqlstatus:=' and '+FGeral.Getin('mpdd_status','N;E','C') + ' and '+FGeral.Getin('mped_status','N;E','C');
// 24.03.06
    if Global.Usuario.OutrosAcessos[0010] then
      sqldatacont:=''
    else
      sqldatacont:=' and mpdd_datacont > '+DateToSql(Global.DataMenorBanco);
    sqlnumeroobra:=''; titulo:='';
    if not Ednroobra.isempty then begin
      sqlnumeroobra:=' and mpdd_numerodoc = '+Ednroobra.text;
    end;
// busca na Os os itens a serem produzidos
    Q:=sqltoquery('select *,clientes.clie_razaosocial from movpeddet '+
                  ' left join movped on ( mped_transacao=mpdd_transacao and mped_tipomov=mpdd_tipomov and mped_numerodoc=mpdd_numerodoc)'+
                  ' inner join estoque on ( esto_codigo=mpdd_esto_codigo )'+
                  ' inner join clientes on ( clie_codigo=mpdd_tipo_codigo )'+
                  ' where mpdd_datamvto>='+EdDatai.AsSql+' and mpdd_datamvto<='+EdDataf.AsSql+
                  sqlunidade+
                  sqltipomovto+
                  sqlproduto+
                  sqlcodtipo+
                  sqlstatus+
                  sqldatacont+
                  sqlnumeroobra+
                  ' order by mpdd_unid_codigo,mpdd_datalcto,mpdd_numerodoc,mpdd_tipo_codigo,mpdd_esto_codigo' );

    if Q.Eof then begin
      Avisoerro('Nada encontrado para impressão');
      Q.close;
      exit;
    end;
    Sistema.BeginProcess('Gerando Relatório');
    if not Ednroobra.isempty then begin
      titulo:=' - Obra no. '+Ednroobra.text+' Cliente : '+FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('mpdd_tipo_codigo').asinteger,'C','N');
    end;

    FRel.Init('RelCMVPvOS');
//    if tiporesumo='C' then
//      FRel.AddTit('Relatório de Custo da Mercadoria Vendida por ...')
//    else
    if EdSa.text='A' then tit:=' - Analítico' else tit:=' - Sintético';
    FRel.AddTit('Relatório de Custo da Mercadoria Vendida - Tipos Impressos: '+TiposVenda);
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+titulo);
    FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate)+tit);
    FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    FRel.AddCol(060,0,'N','' ,''              ,'OS/NF'              ,''         ,'',False);
    FRel.AddCol(070,0,'D','' ,''              ,'Data'              ,''         ,'',False);
    FRel.AddCol(060,0,'N','' ,''              ,'Codigo'         ,''         ,'',False);
    FRel.AddCol(200,0,'C','' ,''              ,'Cliente'       ,''         ,'',False);
    FRel.AddCol(080,0,'N','' ,''              ,'Produto'         ,''         ,'',False);
    FRel.AddCol(200,0,'C','' ,''              ,'Descrição'       ,''         ,'',False);
    FRel.AddCol(050,0,'C','' ,''              ,'Unidade'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N',''  ,''             ,'Qtde Produto'         ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'Valor Venda'         ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'Margem Bruta'         ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+' ,''             ,'Qtde Material'         ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Custo Total '         ,''         ,'',False);
    FRel.AddCol( 80,3,'N',''  ,f_cr           ,'Custo Item'         ,''         ,'',False);
    xnumerodoc:=0;
    customaterial:=0;vendatotal:=0;
    while not Q.eof do begin

//      Q1:=Sqltoquery('select sum(move_qtde*move_venda) as custo from movestoque'+
      Q1:=Sqltoquery('select move_qtde,move_custo,move_esto_codigo,move_unid_codigo,move_venda,move_transacao from movestoque'+
//                      ' inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                      ' where move_numerodoc='+inttostr(Q.fieldbyname('mpdd_numerodoc').asinteger)+
                      ' and move_tipo_codigo='+inttostr(Q.fieldbyname('mpdd_tipo_codigo').asinteger)+
                      ' and move_unid_codigo='+Stringtosql(Q.fieldbyname('mpdd_unid_codigo').asstring)+
                      ' and '+FGeral.GetIN('move_tipomov',Global.CodSaidaAlmox+';'+Global.CodOrdemdeServico,'C')+
                      ' and '+FGeral.GetIN('move_status','R','C') );
      while not Q1.eof do begin
   {
        if copy(Q1.fieldbyname('move_esto_codigo').asstring,1,4)='DESP' then
          vendaitem:=Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency
        else
          vendaitem:=Q1.fieldbyname('move_qtde').ascurrency*FEstoque.Getcusto(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,'custo');
  }
  // 13.12.16
        vendaitem:=Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency;
        if vendaitem=0 then begin
           vendaitem:=Q1.fieldbyname('move_qtde').ascurrency*GetValorUnitario(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_transacao').asstring);
        end;

        Q1.Next;
        customaterial:=customaterial + vendaitem
      end;
      FGeral.FechaQuery(Q1);
      xnumerodoc:=Q.fieldbyname('mpdd_numerodoc').asinteger;
      while ( not Q.eof ) and (xnumerodoc=Q.fieldbyname('mpdd_numerodoc').asinteger) do begin
        FRel.AddCel(Q.fieldbyname('mpdd_unid_codigo').asstring);
        FRel.AddCel(Q.fieldbyname('mpdd_numerodoc').asstring);
        FRel.AddCel(Q.fieldbyname('mpdd_datamvto').asstring);
        FRel.AddCel(Q.fieldbyname('mpdd_tipo_codigo').asstring);
        FRel.AddCel(Q.fieldbyname('clie_razaosocial').asstring);
        FRel.AddCel(Q.fieldbyname('mpdd_esto_codigo').asstring);
        FRel.AddCel(Q.fieldbyname('esto_descricao').asstring);
        FRel.AddCel(Q.fieldbyname('esto_unidade').asstring);
        FRel.AddCel(Q.fieldbyname('mpdd_qtde').asstring);
        vendaitem:=Q.fieldbyname('mpdd_qtde').ascurrency*Q.fieldbyname('mpdd_venda').ascurrency;
        FRel.AddCel(floattostr(vendaitem));
        vendatotal:=vendatotal+vendaitem;
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        xmpdd_tipo_codigo:=Q.fieldbyname('mpdd_tipo_codigo').asinteger;
        xmpdd_unid_codigo:=Q.fieldbyname('mpdd_unid_codigo').asstring;
        Q.Next;
      end;
//      FGeral.PulalinhaRel(10,06,'Total OS');
//      FGEral.ImprimelinhaRel(10,replicate('-',20));
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('');
        FRel.AddCel('Total OS');
        margembruta:=((vendatotal-customaterial)/vendatotal)*100;
        FRel.AddCel(floattostr(vendatotal));
        FRel.AddCel(floattostr(margembruta));
        FRel.AddCel('');
        FRel.AddCel(floattostr(customaterial));
        FRel.AddCel('');
        customaterial:=0;vendatotal:=0;
// lista materiais usados para produzir a OS indicados na nota de compra
        Q1:=Sqltoquery('select move_unid_codigo,move_numerodoc,move_qtde,move_venda,move_esto_codigo,move_transacao,'+
                      ' (select esto_descricao from estoque where esto_codigo=move_esto_codigo) as esto_descricao,'+
                      ' (select esto_unidade from estoque where esto_codigo=move_esto_codigo) as esto_unidade,'+
                      ' move_datamvto,move_nroobra'+
                      ' from movestoque'+
//                      ' inner join movesto on (moes_transacao=move_transacao )'+
                      ' where move_numerodoc='+inttostr(xnumerodoc)+
                      ' and move_tipo_codigo='+inttostr(xmpdd_tipo_codigo)+
                      ' and '+FGeral.GetIN('move_tipomov',Global.CodSaidaAlmox+';'+Global.CodOrdemdeServico,'C')+
                      ' and move_unid_codigo='+Stringtosql(xmpdd_unid_codigo)+
//                      ' and '+FGeral.GetIN('moes_tipomov',Global.CodSaidaAlmox,'C')+
//                      ' and '+FGeral.GetIN('move_status','N;R','C') );
                      ' and '+FGeral.GetIN('move_status','R','C') );
        if not Q1.eof then
          FGeral.PulalinhaRel(14,07,'MATERIAL UTILIZADO');
        ListaM:=TList.create;
        while not Q1.Eof do begin
          if EdSa.text='A' then begin
            FRel.AddCel(Q1.fieldbyname('move_unid_codigo').asstring);
            FRel.AddCel(Q1.fieldbyname('move_nroobra').asstring);
            FRel.AddCel(Q1.fieldbyname('move_datamvto').asstring);
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel(Q1.fieldbyname('move_esto_codigo').asstring);
            if copy(Q1.fieldbyname('move_esto_codigo').asstring,1,4)='DESP' then begin
              FRel.AddCel( FConfMovimento.GetDescricao(strtoint(trim(copy(Q1.fieldbyname('move_esto_codigo').asstring,5,4)))) );
              FRel.AddCel('');
            end else begin
              FRel.AddCel(Q1.fieldbyname('esto_descricao').asstring);
              FRel.AddCel(Q1.fieldbyname('esto_unidade').asstring);
            end;
            vendaitem:=Q1.fieldbyname('move_qtde').ascurrency*Q1.fieldbyname('move_venda').ascurrency;
            if vendaitem=0 then begin
//               vendaitem:=Q1.fieldbyname('move_qtde').ascurrency*FEstoque.Getcusto(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_unid_codigo').asstring,'custo');
// 21.07.16 - buscar o valor na nota de entrada
               vendaitem:=Q1.fieldbyname('move_qtde').ascurrency*GetValorUnitario(Q1.fieldbyname('move_esto_codigo').asstring,Q1.fieldbyname('move_transacao').asstring);
            end;
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel(Q1.fieldbyname('move_qtde').asstring);
            FRel.AddCel('');
            FRel.AddCel(floattostr(vendaitem));
          end else
            AtualizaLista;
          Q1.Next;
        end;
        FGeral.FechaQuery(Q1);
        if EdSa.text='S' then begin
          for p:=0 to ListaM.count-1 do begin
            PMateriais:=ListaM[p];
            FRel.AddCel(PMateriais.unidade);
            FRel.AddCel(PMateriais.nf);
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel(PMateriais.produto);
            if copy(PMateriais.produto,1,4)='DESP' then begin
              FRel.AddCel( FConfMovimento.GetDescricao(strtoint(trim(copy(PMateriais.produto,5,4)))) );
              FRel.AddCel('');
              vendaitem:=PMateriais.unitario;
            end else begin
              FRel.AddCel(PMateriais.produtodesc);
              FRel.AddCel(PMateriais.produtounid);
              vendaitem:=PMateriais.qtde*PMateriais.unitario;
            end;
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel(floattostr(PMateriais.qtde));
            FRel.AddCel('');
            FRel.AddCel(floattostr(vendaitem));
          end;
        end;
        ListaM.free;
        FGeral.PulalinhaRel(14);
    end;
    Fgeral.FechaQuery(Q);
    Sistema.endProcess('');
    FRel.Video();
  end;

  FRelProducao_CMVporPVOS;            // 9

end;



procedure TFRelProducao.baplicarClick(Sender: TObject);
begin
  if not EdDAtai.ValidEdiAll(FRelProducao,99) then exit;
  Saiok:=true;
  close;

end;
procedure TFRelProducao.Edunid_codigoValidate(Sender: TObject);
begin
  if trim(EdUnid_codigo.Text)='' then
    EdUnid_codigo.Text:=Global.Usuario.UnidadesRelatorios;

end;

procedure TFRelProducao.FormActivate(Sender: TObject);
begin
  FRelProducao.Eddatai.SetFirstEd;
  if FRelProducao.EdDatai.isempty then begin
    FRelProducao.EdDatai.setdate(sistema.hoje);
    FRelProducao.EdDataf.setdate(sistema.hoje);
  end;

end;

procedure TFRelProducao.EdnroobraExitEdit(Sender: TObject);
begin
  baplicarclick(self);
end;

procedure TFRelProducao.EdProdutoExitEdit(Sender: TObject);
begin
  baplicarclick(self);
end;

end.
