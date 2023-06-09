unit rel_compras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid;

type
  TFRelcompras = class(TForm)
    PRel: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    baplicar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    Eddatai: TSQLEd;
    Eddataf: TSQLEd;
    Edunid_codigo: TSQLEd;
    EdTipomov: TSQLEd;
    EdTipocad: TSQLEd;
    EdCodtipo: TSQLEd;
    SetEdFavorecido: TSQLEd;
    EdNumerodoc: TSQLEd;
    EdEsto_codigo: TSQLEd;
    SetEdFUNC_NOME: TSQLEd;
    procedure baplicarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdEsto_codigoExitEdit(Sender: TObject);
    procedure EdTipocadValidate(Sender: TObject);
  private
    { Private declarations }
    SaiOk:Boolean;
  public
    { Public declarations }
  end;

var
  FRelcompras: TFRelcompras;
  sqlunidade,sqltipomovto,sqlproduto,sqldatacont,sqlnumerodoc,sqlcodtipo:string;

procedure FRelCompras_ImprimePedido;                // 1
procedure FRelCompras_Recebimento;           // 2
procedure FRelCompras_ExtratoMateriaPrima;           // 3
procedure FRelCompras_ExtratoMateriaPrimaResumido;           // 4
procedure FRelCompras_RecebimentoContagem;           // 5


implementation

uses Geral, Unidades, SQLRel, SqlExpr, Usuarios, Sqlsis, Sqlfun , tamanhos,
  cadcor, cadcopa, Pedcomp, Estoque, grupos;

{$R *.dfm}

function FRelCompras_Execute(Tp:Integer):Boolean;
begin
  if FRelCompras=nil then FGeral.CreateForm(TFRelCompras, FRelCompras);
  result:=true;
  FGeral.SetaItemsMovimento(FRelCompras.EdTipomov);
//  FRelCompras.PRel.enableedits;
  if FRelCompras.EdDatai.isempty then begin
    FRelCompras.EdDatai.setdate(sistema.hoje);
    FRelCompras.EdDataf.setdate(sistema.hoje);
  end;
  sqlunidade:='';
  sqltipomovto:='';
  sqlnumerodoc:='';
  sqlproduto:='';
  sqlcodtipo:='';  
  with FRelCompras do begin
    FUnidades.SetaItems(EdUnid_codigo,nil,Global.Usuario.UnidadesRelatorios);
    if tp=1 then
      Caption:='Impress�o Pedido de Compra'
    else if tp=2 then
      Caption:='Relat�rio de Recebimento de Mercadoria'
    else if tp=3 then
      Caption:='Extrato Detalhado de Mat�ria Prima'
    else if tp=4 then
      Caption:='Extrato Resumido de Mat�ria Prima'
    else if tp=5 then
      Caption:='Relat�rio para Contagem Recebimento de Mercadoria';
    EdDatai.enabled:=true;
    EdDataf.enabled:=true;
    EdTipomov.enabled:=true;
    EdUnid_codigo.enabled:=true;
    Edtipocad.enabled:=true;
    Edcodtipo.enabled:=true;
    EdEsto_codigo.enabled:=true;
    if tp=1 then  begin
      EdDatai.enabled:=false;
      EdDataf.enabled:=false;
      EdTipomov.enabled:=false;
      EdUnid_codigo.enabled:=false;
      Edtipocad.enabled:=false;
      Edcodtipo.enabled:=false;
//      EdTipomov.text:=Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX;
      EdEsto_codigo.enabled:=false;
    end else if tp=3 then begin
      EdTipomov.enabled:=false;
    end;
    SaiOk:=False;
    FRelCompras.ShowModal;
    Result:=SaiOk;
  end;

end;


procedure FRelCompras_ImprimePedido;                // 1
begin
  with FRelCompras do begin
    if not FRelCompras_Execute(1) then Exit;
    FPedCompra.ImprimePedidoCompra(FRelCompras.EdNUmerodoc.asinteger,'PU','N');
  end;
end;

procedure FRelCompras_ExtratoMateriaPrima;           // 3
var entrada,saida,saldo,unitario:currency;
    Q,QCustomat:Tsqlquery;
    QCfop:TMemoryquery;
    moes_natf_codigo,sqlunidadem,sqltipomovtom,sqlnumerodocm,sqldatacontm,sqlcotipom,sqlcodtipom:string;
begin
  with FRelCompras do begin
    if not FRelCompras_Execute(3) then Exit;
    Sistema.beginprocess('Pesquisando movimenta��o de materia prima');
    if trim(EdUnid_codigo.text)<>'' then begin
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C');
      sqlunidadem:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
    end else begin
      sqlunidade:='';
      sqlunidadem:='';
    end;
//    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.codbaixamatsai+';'+Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+Global.CodBaixaMatEnt,'C');
      sqltipomovtom:=' and '+FGeral.getin('moes_tipomov',Global.codbaixamatsai+';'+Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+Global.CodBaixaMatEnt,'C');
//    end else begin
//      sqltipomovto:='';
//    end;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then begin
      sqldatacont:='';
      sqldatacontm:='';
    end else begin
      sqldatacont:=' and move_datacont>1';
      sqldatacontm:=' and moes_datacont>1';
    end;
    if not EdNumerodoc.isempty  then begin
      sqlnumerodoc:=' and move_numerodoc='+EdNumerodoc.assql;
      sqlnumerodocm:=' and moes_numerodoc='+EdNumerodoc.assql;
    end else begin
      sqlnumerodoc:='';
      sqlnumerodocm:='';
    end;
    if not EdEsto_codigo.isempty  then
      sqlproduto:=' and move_esto_codigo='+EdEsto_codigo.assql
    else
      sqlproduto:='';
    if not EdCodtipo.isempty then begin
//      sqlcodtipo:=' and move_tipo_codigo='+Edcodtipo.assql
      sqlcodtipo:=' and move_tipo_codigoind='+Edcodtipo.assql;
      sqlcodtipom:=' and moes_tipo_codigoind='+Edcodtipo.assql;
    end else begin
      sqlcodtipo:='';
      sqlcodtipom:='';
    end;
    Qcfop:=sqltomemoryquery('select moes_natf_codigo,moes_transacao,moes_numerodoc from movesto'+
                  ' where '+FGeral.getin('moes_status','N','C')+' and moes_datamvto>='+EdDatai.assql+
                    sqlunidadem+sqltipomovtom+sqldatacontm+sqlnumerodocm+sqlcodtipom+
                  ' and moes_datamvto<='+EdDAtaf.assql+
                  ' order by moes_unid_codigo,moes_numerodoc');

    Q:=sqltoquery('select * from movestoque'+
//                  ' inner join movesto on ( moes_numerodoc=move_numerodoc and moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where '+FGeral.getin('move_status','N','C')+' and move_datamvto>='+EdDatai.assql+
                    sqlunidade+sqltipomovto+sqldatacont+sqlproduto+sqlnumerodoc+sqlcodtipo+
                  ' and move_datamvto<='+EdDAtaf.assql+
//                  ' order by move_unid_codigo,move_esto_codigo,move_tipomov');
                  ' order by move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo,move_copa_codigo,move_tipomov');
   if Q.eof then begin
      Avisoerro('Nada encontrado para impress�o');
      Q.close;
      Freeandnil(Q);
      Sistema.EndProcess('');
      exit;
   end;
    FRel.Init('ExtratoMateriaPrima');
    FRel.AddTit('Extrato de Mat�ria Prima');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+' Fornecedor '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,Edtipocad.text,'N') );
    FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
    FRel.AddCol( 35,2,'C','' ,''              ,'Unid'         ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Lan�amento'  ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'    ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Entrada'    ,''         ,'',false);
    FRel.AddCol( 50,3,'N','' ,''              ,'Numero'     ,''         ,'',False);
    FRel.AddCol( 50,1,'C','' ,''              ,'TipoCod'           ,''         ,'',false);
    FRel.AddCol( 50,1,'C','' ,''              ,'Codigo'           ,''         ,'',false);
    FRel.AddCol(120,1,'C','' ,''              ,'Nome'            ,''         ,'',false);
    FRel.AddCol( 80,1,'N','' ,''              ,'Produto'          ,''         ,'',false);
    FRel.AddCol(150,1,'C','' ,''              ,'Descri��o'       ,''         ,'',false);
//    FRel.AddCol(060,1,'C','' ,''              ,'Cod.Tam'         ,''         ,'',False);
    FRel.AddCol(070,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
//    FRel.AddCol(060,1,'C','' ,''              ,'Cod.Cor'         ,''         ,'',False);
    FRel.AddCol(080,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
//    FRel.AddCol(060,1,'C','' ,''              ,'Cod.Copa'        ,''         ,'',False);
    FRel.AddCol(050,1,'C','' ,''              ,'Copa'           ,''         ,'',False);
    FRel.AddCol(050,1,'C','' ,''              ,'Tipomov'           ,''         ,'',False);
    FRel.AddCol( 60,3,'N','+',''              ,'Entrada'    ,''         ,'',False);
    FRel.AddCol( 60,3,'N','+',''              ,'Saida'    ,''         ,'',False);
    FRel.AddCol( 60,3,'N','+',''              ,'Saldo'  ,''         ,'',False);
    FRel.AddCol( 60,3,'N','' ,f_cr            ,'Unit�rio'       ,''         ,'',False);
    FRel.AddCol( 70,3,'N','+',f_cr            ,'Total Saldo'     ,''         ,'',False);

    while not Q.eof do begin

//      if ( pos(Q.fieldbyname('moes_natf_codigo').asstring,'1122;2122;    ')>0 ) or
//          ( q.fieldbyname('moes_natf_codigo').asstring='' ) then begin
// 27.07.06
      QCfop.first;
      moes_natf_codigo:='';
      while not QCfop.eof do begin
        if ( QCfop.fieldbyname('moes_transacao').asstring=Q.fieldbyname('move_transacao').asstring ) and
           ( QCfop.fieldbyname('moes_numerodoc').asinteger=Q.fieldbyname('move_numerodoc').asinteger ) then begin
          moes_natf_codigo:=QCfop.fieldbyname('moes_natf_codigo').asstring;
          break;
        end;
        QCfop.next;
      end;
      if ( pos(moes_natf_codigo,'1122;2122;    ')>0 ) or
          ( moes_natf_codigo='' ) then begin

        FRel.AddCel(Q.FieldByName('move_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('move_datalcto').AsString);
        FRel.AddCel(Q.FieldByName('move_datacont').AsString);
        FRel.AddCel(Q.FieldByName('move_datamvto').AsString);
        FRel.AddCel(Q.FieldByName('move_numerodoc').AsString);
        FRel.AddCel(Q.fieldbyname('move_tipocad').asstring);
//        FRel.AddCel(Q.fieldbyname('move_tipo_codigo').asstring);
//        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('move_tipo_codigo').asinteger,Q.FieldByName('move_tipocad').AsString,'N'));
// 27.06.06
        FRel.AddCel(Q.fieldbyname('move_tipo_codigoind').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('move_tipo_codigoind').asinteger,Q.FieldByName('move_tipocad').AsString,'N'));
        FRel.AddCel(Q.fieldbyname('move_esto_codigo').asstring);
        FRel.AddCel(Q.fieldbyname('esto_descricao').asstring);
//        FRel.AddCel(Q.fieldbyname('moco_tama_codigo').asstring);
        FRel.AddCel(FTamanhos.GetDescricao(Q.fieldbyname('move_tama_codigo').asinteger));
//        FRel.AddCel(Q.fieldbyname('moco_core_codigo').asstring);
        FRel.AddCel(FCores.GetDescricao(Q.fieldbyname('move_core_codigo').asinteger));
//        FRel.AddCel(Q.fieldbyname('moco_copa_codigo').asstring);
        FRel.AddCel(FCopas.GetDescricao(Q.fieldbyname('move_copa_codigo').asinteger));
        FRel.AddCel(Q.fieldbyname('move_tipomov').asstring);
// 27.07.06
          unitario:=Q.fieldbyname('move_customeger').ascurrency;
        if unitario=0 then begin
          QCustoMat:=sqltoquery( FEstoque.Getsqlcustos(Q.fieldbyname('move_esto_codigo').asstring,Global.Unidadematriz,
                          Q.fieldbyname('move_tama_codigo').asinteger,Q.fieldbyname('move_core_codigo').asinteger) );
          if not QCustoMat.eof then
            unitario:=QCustomat.fieldbyname('customeger').ascurrency;
          FGeral.fechaquery(QCustomat);
        end;
        if Q.FieldByName('move_tipomov').AsString=Global.codbaixamatsai then begin
          entrada:=0;
          saida:=Q.fieldbyname('move_qtde').ascurrency;
          saldo:=(-1)*saida;
        end else begin
          entrada:=Q.fieldbyname('move_qtde').ascurrency;
          saida:=0;
          saldo:=entrada;
        end;
        FRel.AddCel(floattostr(entrada));
        FRel.AddCel(floattostr(saida));
        FRel.AddCel(floattostr(saldo));
        FRel.AddCel(floattostr(unitario));
        FRel.AddCel( floattostr(unitario*saldo) );
      end;
      Q.Next;
    end;
    FRel.Video;

    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);
    FGeral.fechaquery(QCfop);
  end;

  FRelCompras_ExtratoMateriaPrima;         // 3

end;


procedure FRelCompras_Recebimento;           // 2
var Q:TSqlquery;
    titulo:string;
begin

  with FRelCompras do begin
    if not FRelCompras_Execute(2) then Exit;
    Sistema.beginprocess('Pesquisando pedidos de compra no per�odo');
    if trim(EdUnid_codigo.text)<>'' then begin
      sqlunidade:=' and '+FGeral.getin('moco_unid_codigo',EdUnid_codigo.text,'C');
    end else begin
      sqlunidade:='';
    end;
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('moco_tipomov',EdTipomov.text,'C');
    end else begin
      sqltipomovto:='';
    end;
// 24.03.06  - ver se pedido de compra tem este 'esquema'
//    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:='';   // fran em 04.06.09
//    else
//      sqldatacont:=' and moco_datacont>1';
    if not EdNumerodoc.isempty  then
      sqlnumerodoc:=' and moco_numerodoc='+EdNumerodoc.assql
    else
      sqlnumerodoc:='';
    if not EdEsto_codigo.isempty  then
      sqlproduto:=' and moco_esto_codigo='+EdEsto_codigo.assql
    else
      sqlproduto:='';
    if not EdCodtipo.isempty then
      sqlcodtipo:=' and moco_tipo_codigo='+Edcodtipo.assql
    else
      sqlcodtipo:='';

    Q:=sqltoquery('select * from movcompras'+
                  ' inner join movcomp on ( mocm_numerodoc=moco_numerodoc and mocm_status=''N'' )'+
                  ' inner join estoque on ( esto_codigo=moco_esto_codigo )'+
//                  ' where '+FGeral.getin('moco_status','N','C')+' and moco_datamvto>='+EdDatai.assql+
//                    sqlunidade+sqltipomovto+sqldatacont+sqlproduto+sqlnumerodoc+sqlcodtipo+
                  ' where '+FGeral.getin('moco_status','N','C')+' and mocm_dataentrega>='+EdDatai.assql+
                    sqlunidade+sqltipomovto+sqldatacont+sqlproduto+sqlnumerodoc+sqlcodtipo+
                  ' and mocm_dataentrega<='+EdDAtaf.assql+' order by moco_unid_codigo,moco_numerodoc');
   if Q.eof then begin
      Avisoerro('Nada encontrado para impress�o');
      Q.close;
      Freeandnil(Q);
      Sistema.EndProcess('');
      exit;
   end;
    FRel.Init('RelRecebimentoCompras');
    FRel.AddTit('Rela��o de Recebimento de Compras - Previs�o de entrega : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+' Fornecedor '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,Edtipocad.text,'N') );
    titulo:='';
    if not EdNumerodoc.isempty then
      titulo:='Pedido '+EdNumerodoc.text;
    if not EdEsto_codigo.isempty then
      titulo:=titulo+' - Codigo Escolhido '+EdEsto_codigo.text;
    if trim(titulo)<>'' then
      FRel.AddTit(titulo);
    FRel.AddCol( 35,2,'C','' ,''              ,'Unid'         ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Lan�am.'  ,''         ,'',false);
//    FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'    ,''         ,'',false);
//    FRel.AddCol( 60,1,'D','' ,''              ,'Emiss�o'    ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Entrega'    ,''         ,'',false);
    FRel.AddCol( 50,3,'N','' ,''              ,'Numero'     ,''         ,'',False);
    if Global.Topicos[1209] then
      FRel.AddCol( 90,1,'C','' ,''              ,'Referencia'          ,''         ,'',false)
    else
      FRel.AddCol( 50,1,'N','' ,''              ,'Codigo'           ,''         ,'',false);
    FRel.AddCol(100,1,'C','' ,''              ,'Nome'            ,''         ,'',false);
    FRel.AddCol( 80,1,'N','' ,''              ,'Produto'          ,''         ,'',false);
    FRel.AddCol(130,1,'C','' ,''              ,'Descri��o'       ,''         ,'',false);
//    FRel.AddCol(060,1,'C','' ,''              ,'Cod.Tam'         ,''         ,'',False);
// 24.01.10 - Abra - Robson
    FRel.AddCol(090,1,'C','' ,''              ,'Grupo'         ,''         ,'',False);
    FRel.AddCol(070,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
//    FRel.AddCol(060,1,'C','' ,''              ,'Cod.Cor'         ,''         ,'',False);
    FRel.AddCol(080,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
//    FRel.AddCol(060,1,'C','' ,''              ,'Cod.Copa'        ,''         ,'',False);
//    FRel.AddCol(050,1,'C','' ,''              ,'Copa'           ,''         ,'',False);
    FRel.AddCol( 50,3,'N','+',''              ,'Pedido'    ,''         ,'',False);
    FRel.AddCol( 70,3,'N','',f_cr            ,'Unit�rio'       ,''         ,'',False);
    FRel.AddCol( 70,3,'N','+',f_cr            ,'Total Item'     ,''         ,'',False);
    FRel.AddCol( 50,1,'D','',''               ,'Data Rec.'  ,''         ,'',False);
    FRel.AddCol( 50,3,'N','+',''              ,'Recebido'  ,''         ,'',False);
    FRel.AddCol( 50,3,'N','+',''              ,'Falta'     ,''         ,'',False);
    while not Q.eof do begin
        FRel.AddCel(Q.FieldByName('moco_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('moco_datalcto').AsString);
//        FRel.AddCel(Q.FieldByName('moco_datacont').AsString);
//        FRel.AddCel(Q.FieldByName('mocm_datamvto').AsString);
        FRel.AddCel(Q.FieldByName('mocm_dataentrega').AsString);
        FRel.AddCel(Q.FieldByName('moco_numerodoc').AsString);
        FRel.AddCel(Q.fieldbyname('moco_tipo_codigo').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moco_tipo_codigo').asinteger,Q.FieldByName('moco_tipocad').AsString,'N'));
        if Global.Topicos[1209] then
          FRel.AddCel(Q.FieldByName('esto_referencia').AsString)
        else
          FRel.AddCel(Q.fieldbyname('moco_esto_codigo').asstring);
        FRel.AddCel(Q.fieldbyname('esto_descricao').asstring);
//        FRel.AddCel(Q.fieldbyname('moco_tama_codigo').asstring);
// 24.01.11 - Abra - Robson - 'indicadores'...
        FRel.AddCel(FGrupos.GetDescricao(Q.fieldbyname('esto_grup_codigo').asinteger));
        FRel.AddCel(FTamanhos.GetDescricao(Q.fieldbyname('moco_tama_codigo').asinteger));
//        FRel.AddCel(Q.fieldbyname('moco_core_codigo').asstring);
        FRel.AddCel(FCores.GetDescricao(Q.fieldbyname('moco_core_codigo').asinteger));
//        FRel.AddCel(Q.fieldbyname('moco_copa_codigo').asstring);
//        FRel.AddCel(FCopas.GetDescricao(Q.fieldbyname('moco_copa_codigo').asinteger));
        FRel.AddCel(Q.fieldbyname('moco_qtde').asstring);
        FRel.AddCel(Q.fieldbyname('moco_unitario').asstring);
        FRel.AddCel( floattostr(Q.fieldbyname('moco_unitario').ascurrency*Q.fieldbyname('moco_qtde').ascurrency) );
        FRel.AddCel(Q.fieldbyname('moco_datanfcompra').asstring);
        FRel.AddCel(Q.fieldbyname('moco_qtderecebida').asstring);
        FRel.AddCel( floattostr(Q.fieldbyname('moco_qtde').ascurrency-Q.fieldbyname('moco_qtderecebida').ascurrency) );
//        FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));
//        FRel.AddCel(FUsuarios.GetNome(Q.fieldbyname('moco_usua_codigo').asinteger));
        Q.Next;
    end;
    FRel.Video;

    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);
  end;

  FRelCompras_Recebimento;         // 2
end;

procedure FRelCompras_ExtratoMateriaPrimaResumido;           // 4 -  28.07.06
type TRegistro=record
    unidade,produto,descricao,unidprod:string;
    qtdes,qtdee,unitario:currency;
    codcor,codtamanho,codcopa:integer;
end;

var entrada,saida,saldo,unitario:currency;
    Q,QCustomat:Tsqlquery;
    QCfop:TMemoryquery;
    moes_natf_codigo,sqlunidadem,sqltipomovtom,sqlnumerodocm,sqldatacontm,sqlcotipom,sqlcodtipom:string;
    p:integer;
    Lista:Tlist;
    PRegistro:^TRegistro;

    procedure AtualizaLista;
    var achou:boolean;
        x:integer;
    begin
      achou:=false;
      for x:=0 to Lista.count-1 do begin
        PRegistro:=Lista[x];
        if ( PRegistro.unidade=Q.fieldbyname('move_unid_codigo').asstring ) and
           ( Pregistro.produto=Q.fieldbyname('move_esto_codigo').asstring ) and
           ( PREgistro.codtamanho=Q.fieldbyname('move_tama_codigo').asinteger ) and
           ( PREgistro.codcor=Q.fieldbyname('move_core_codigo').asinteger ) then begin
//           ( PREgistro.codcopa=Q.fieldbyname('move_copa_codigo').asinteger ) then begin
// 28.07.06 - pois materia prima nao ten sentido falar em copa
           achou:=true;
           break;
        end;
      end;
      if not achou then begin
        New(PREgistro);
        PRegistro.unidade:=Q.fieldbyname('move_unid_codigo').asstring;
        Pregistro.produto:=Q.fieldbyname('move_esto_codigo').asstring;
        PREgistro.codtamanho:=Q.fieldbyname('move_tama_codigo').asinteger;
        PREgistro.codcor:=Q.fieldbyname('move_core_codigo').asinteger;
        PREgistro.codcopa:=Q.fieldbyname('move_copa_codigo').asinteger;
        PRegistro.qtdes:=0;
        PRegistro.qtdee:=0;
        PRegistro.unitario:=unitario;
        PRegistro.descricao:=Q.fieldbyname('esto_descricao').asstring;
        if Q.fieldbyname('move_tipomov').asstring=Global.codbaixamatsai then
          PRegistro.qtdes:=Q.fieldbyname('move_qtde').ascurrency
        else
          PRegistro.qtdee:=Q.fieldbyname('move_qtde').ascurrency;
        PREgistro.unidprod:=Q.fieldbyname('esto_unidade').asstring;
        Lista.add(Pregistro);
      end else begin
        if Q.fieldbyname('move_tipomov').asstring=Global.codbaixamatsai then
          PRegistro.qtdes:=PRegistro.qtdes+Q.fieldbyname('move_qtde').ascurrency
        else
          PRegistro.qtdee:=PRegistro.qtdee+Q.fieldbyname('move_qtde').ascurrency;
      end;
    end;

begin
  with FRelCompras do begin
    if not FRelCompras_Execute(4) then Exit;
    Sistema.beginprocess('Pesquisando movimenta��o de materia prima');
    if trim(EdUnid_codigo.text)<>'' then begin
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C');
      sqlunidadem:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
    end else begin
      sqlunidade:='';
      sqlunidadem:='';
    end;
//    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',Global.codbaixamatsai+';'+Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+Global.codbaixamatent,'C');
      sqltipomovtom:=' and '+FGeral.getin('moes_tipomov',Global.codbaixamatsai+';'+Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX+';'+Global.codbaixamatent,'C');
//    end else begin
//      sqltipomovto:='';
//    end;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then begin
      sqldatacont:='';
      sqldatacontm:='';
    end else begin
      sqldatacont:=' and move_datacont>1';
      sqldatacontm:=' and moes_datacont>1';
    end;
    if not EdNumerodoc.isempty  then begin
      sqlnumerodoc:=' and move_numerodoc='+EdNumerodoc.assql;
      sqlnumerodocm:=' and moes_numerodoc='+EdNumerodoc.assql;
    end else begin
      sqlnumerodoc:='';
      sqlnumerodocm:='';
    end;
    if not EdEsto_codigo.isempty  then
      sqlproduto:=' and move_esto_codigo='+EdEsto_codigo.assql
    else
      sqlproduto:='';
    if not EdCodtipo.isempty then begin
//      sqlcodtipo:=' and move_tipo_codigo='+Edcodtipo.assql
      sqlcodtipo:=' and move_tipo_codigoind='+Edcodtipo.assql;
      sqlcodtipom:=' and moes_tipo_codigoind='+Edcodtipo.assql;
    end else begin
      sqlcodtipo:='';
      sqlcodtipom:='';
    end;
    Qcfop:=sqltomemoryquery('select moes_natf_codigo,moes_transacao,moes_numerodoc from movesto'+
                  ' where '+FGeral.getin('moes_status','N','C')+' and moes_datamvto>='+EdDatai.assql+
                    sqlunidadem+sqltipomovtom+sqldatacontm+sqlnumerodocm+sqlcodtipom+
                  ' and moes_datamvto<='+EdDAtaf.assql+
                  ' order by moes_unid_codigo,moes_numerodoc');

    Q:=sqltoquery('select * from movestoque'+
//                  ' inner join movesto on ( moes_numerodoc=move_numerodoc and moes_transacao=move_transacao and moes_tipomov=move_tipomov )'+
                  ' inner join estoque on ( esto_codigo=move_esto_codigo )'+
                  ' where '+FGeral.getin('move_status','N','C')+' and move_datamvto>='+EdDatai.assql+
                    sqlunidade+sqltipomovto+sqldatacont+sqlproduto+sqlnumerodoc+sqlcodtipo+
                  ' and move_datamvto<='+EdDAtaf.assql+
//                  ' order by move_unid_codigo,move_esto_codigo,move_tipomov');
                  ' order by move_unid_codigo,move_esto_codigo,move_tama_codigo,move_core_codigo,move_copa_codigo,move_tipomov');
   if Q.eof then begin
      Avisoerro('Nada encontrado para impress�o');
      Q.close;
      Freeandnil(Q);
      Sistema.EndProcess('');
      exit;
   end;

    Lista:=Tlist.create;
    while not Q.eof do begin

      QCfop.first;
      moes_natf_codigo:='';
      while not QCfop.eof do begin
        if ( QCfop.fieldbyname('moes_transacao').asstring=Q.fieldbyname('move_transacao').asstring ) and
           ( QCfop.fieldbyname('moes_numerodoc').asinteger=Q.fieldbyname('move_numerodoc').asinteger ) then begin
          moes_natf_codigo:=QCfop.fieldbyname('moes_natf_codigo').asstring;
          break;
        end;
        QCfop.next;
      end;
      if ( pos(moes_natf_codigo,'1122;2122;    ')>0 ) or
          ( moes_natf_codigo='' ) then begin

// 27.07.06
        unitario:=Q.fieldbyname('move_customeger').ascurrency;
        if unitario=0 then begin
          QCustoMat:=sqltoquery( FEstoque.Getsqlcustos(Q.fieldbyname('move_esto_codigo').asstring,Global.Unidadematriz,
                          Q.fieldbyname('move_tama_codigo').asinteger,Q.fieldbyname('move_core_codigo').asinteger) );
          if not QCustoMat.eof then
            unitario:=QCustomat.fieldbyname('customeger').ascurrency;
          FGeral.fechaquery(QCustomat);
        end;
        AtualizaLista;
      end;
      Q.Next;
    end;

    FRel.Init('ExtratoMateriaPrimaResumido');
    FRel.AddTit('Extrato de Mat�ria Prima Resumido');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+' Fornecedor '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,Edtipocad.text,'N') );
    FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
    FRel.AddCol( 35,2,'C','' ,''              ,'Unid'         ,''         ,'',false);
    FRel.AddCol( 80,1,'N','' ,''              ,'Produto'          ,''         ,'',false);
    FRel.AddCol(150,1,'C','' ,''              ,'Descri��o'       ,''         ,'',false);
    FRel.AddCol(050,1,'C','' ,''              ,'Unidade'         ,''         ,'',false);
//    FRel.AddCol(060,1,'C','' ,''              ,'Cod.Tam'         ,''         ,'',False);
    FRel.AddCol(070,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
//    FRel.AddCol(060,1,'C','' ,''              ,'Cod.Cor'         ,''         ,'',False);
    FRel.AddCol(080,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
//    FRel.AddCol(060,1,'C','' ,''              ,'Cod.Copa'        ,''         ,'',False);
//    FRel.AddCol(050,1,'C','' ,''              ,'Copa'           ,''         ,'',False);
    FRel.AddCol( 60,3,'N','+',''              ,'Entrada'    ,''         ,'',False);
    FRel.AddCol( 60,3,'N','+',''              ,'Saida'    ,''         ,'',False);
    FRel.AddCol( 60,3,'N','+',''              ,'Saldo'  ,''         ,'',False);
    FRel.AddCol( 70,3,'N','' ,f_cr            ,'Unit�rio'       ,''         ,'',False);
    FRel.AddCol( 70,3,'N','+',f_cr            ,'Total Saldo'     ,''         ,'',False);

    for p:=0 to Lista.count-1 do begin
        PREgistro:=Lista[p];
        FRel.AddCel(PRegistro.unidade);
        FRel.AddCel(PRegistro.produto);
        FRel.AddCel(PRegistro.descricao);
        FRel.AddCel(PRegistro.unidprod);
        FRel.AddCel(FTamanhos.GetDescricao(PREgistro.codtamanho));
        FRel.AddCel(FCores.GetDescricao(PREgistro.codcor));
/////        FRel.AddCel(FCopas.GetDescricao(PREgistro.codcopa));

        if Q.FieldByName('move_tipomov').AsString=Global.codbaixamatsai then begin
          entrada:=0;
          saida:=Q.fieldbyname('move_qtde').ascurrency;
          saldo:=(-1)*saida;
        end else begin
          entrada:=Q.fieldbyname('move_qtde').ascurrency;
          saida:=0;
          saldo:=entrada;
        end;
        FRel.AddCel(floattostr(PRegistro.qtdee));
        FRel.AddCel(floattostr(PRegistro.qtdes));
        saldo:=PRegistro.qtdee-PRegistro.qtdes;
        FRel.AddCel(floattostr(saldo));
        FRel.AddCel(floattostr(PRegistro.unitario));
        FRel.AddCel( floattostr(PRegistro.unitario*saldo) );

    end;
    FRel.Video;

    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);
    FGeral.fechaquery(QCfop);
  end;

  FRelCompras_ExtratoMateriaPrimaResumido;         // 4

end;



procedure TFRelcompras.baplicarClick(Sender: TObject);
begin
  if not EdDAtai.ValidEdiAll(FRelCompras,99) then exit;
  Saiok:=true;
  close;

end;

procedure TFRelcompras.FormActivate(Sender: TObject);
begin
  FRelcompras.Eddatai.SetFirstEd;

end;

procedure TFRelcompras.EdEsto_codigoExitEdit(Sender: TObject);
begin
  baplicarclick(self);
end;

procedure TFRelcompras.EdTipocadValidate(Sender: TObject);
begin
  if EdTipoCad.text='U' then begin
    EdCodtipo.ShowForm:='FUnidades';
    EdCodtipo.FindTable:='unidades';
    EdCodtipo.FindField:='unid_codigo';
  end else if EdTipoCad.text='C' then begin
    EdCodtipo.ShowForm:='FCadcli';
    EdCodtipo.FindTable:='clientes';
    EdCodtipo.FindField:='clie_codigo';
  end else if EdTipoCad.text='F' then begin
    EdCodtipo.ShowForm:='FFornece';
    EdCodtipo.FindTable:='fornecedores';
    EdCodtipo.FindField:='forn_codigo';
  end else if EdTipoCad.text='T' then  begin
    EdCodtipo.ShowForm:='FTransp';
    EdCodtipo.FindTable:='transportadores';
    EdCodtipo.FindField:='tran_codigo';
  end else if EdTipoCad.text='R' then begin
    EdCodtipo.ShowForm:='FRepresentantes';
    EdCodtipo.FindTable:='representantes';
    EdCodtipo.FindField:='repr_codigo';
  end else begin
    EdCodtipo.ShowForm:='';
    EdCodtipo.FindTable:='';
    EdCodtipo.FindField:='';
  end;

end;

procedure FRelCompras_RecebimentoContagem;           // 5
var Q:TSqlquery;
    titulo:string;
begin

  with FRelCompras do begin
    if not FRelCompras_Execute(5) then Exit;
    Sistema.beginprocess('Pesquisando pedidos de compra no per�odo');
    if trim(EdUnid_codigo.text)<>'' then begin
      sqlunidade:=' and '+FGeral.getin('moco_unid_codigo',EdUnid_codigo.text,'C');
    end else begin
      sqlunidade:='';
    end;
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('moco_tipomov',EdTipomov.text,'C');
    end else begin
      sqltipomovto:='';
    end;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
      sqldatacont:=' and moco_datacont>1';
    if not EdNumerodoc.isempty  then
      sqlnumerodoc:=' and moco_numerodoc='+EdNumerodoc.assql
    else
      sqlnumerodoc:='';
    if not EdEsto_codigo.isempty  then
      sqlproduto:=' and moco_esto_codigo='+EdEsto_codigo.assql
    else
      sqlproduto:='';
    if not EdCodtipo.isempty then
      sqlcodtipo:=' and moco_tipo_codigo='+Edcodtipo.assql
    else
      sqlcodtipo:='';

    Q:=sqltoquery('select * from movcompras'+
                  ' inner join movcomp on ( mocm_numerodoc=moco_numerodoc and mocm_status=''N'' )'+
                  ' inner join estoque on ( esto_codigo=moco_esto_codigo )'+
//                  ' where '+FGeral.getin('moco_status','N','C')+' and moco_datamvto>='+EdDatai.assql+
//                    sqlunidade+sqltipomovto+sqldatacont+sqlproduto+sqlnumerodoc+sqlcodtipo+
                  ' where '+FGeral.getin('moco_status','N','C')+' and mocm_dataentrega>='+EdDatai.assql+
                    sqlunidade+sqltipomovto+sqldatacont+sqlproduto+sqlnumerodoc+sqlcodtipo+
                  ' and mocm_dataentrega<='+EdDAtaf.assql+' order by moco_unid_codigo,moco_numerodoc');
   if Q.eof then begin
      Avisoerro('Nada encontrado para impress�o');
      Q.close;
      Freeandnil(Q);
      Sistema.EndProcess('');
      exit;
   end;
    FRel.Init('RelContagemRecebimento');
    FRel.AddTit('Rela��o de Recebimento de Compras - Previs�o de entrega : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text)+' Fornecedor '+FGeral.GetNomeRazaoSocialEntidade(EdCodtipo.asinteger,Edtipocad.text,'N') );
    titulo:='';
    if not EdNumerodoc.isempty then
      titulo:='Pedido '+EdNumerodoc.text;
    if not EdEsto_codigo.isempty then
      titulo:=titulo+' - Codigo Escolhido '+EdEsto_codigo.text;
    if trim(titulo)<>'' then
      FRel.AddTit(titulo);
    FRel.AddCol( 35,2,'C','' ,''              ,'Unid'         ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Lan�am.'  ,''         ,'',false);
//    FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'    ,''         ,'',false);
//    FRel.AddCol( 60,1,'D','' ,''              ,'Emiss�o'    ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Entrega'    ,''         ,'',false);
    FRel.AddCol( 50,3,'N','' ,''              ,'Numero'     ,''         ,'',False);
    FRel.AddCol( 50,1,'C','' ,''              ,'Codigo'           ,''         ,'',false);
    FRel.AddCol(100,1,'C','' ,''              ,'Nome'            ,''         ,'',false);
    FRel.AddCol( 80,1,'N','' ,''              ,'Produto'          ,''         ,'',false);
    FRel.AddCol(130,1,'C','' ,''              ,'Descri��o'       ,''         ,'',false);
//    FRel.AddCol(060,1,'C','' ,''              ,'Cod.Tam'         ,''         ,'',False);
    FRel.AddCol(070,1,'C','' ,''              ,'Tamanho'         ,''         ,'',False);
//    FRel.AddCol(060,1,'C','' ,''              ,'Cod.Cor'         ,''         ,'',False);
    FRel.AddCol(080,1,'C','' ,''              ,'Cor'             ,''         ,'',False);
//    FRel.AddCol(060,1,'C','' ,''              ,'Cod.Copa'        ,''         ,'',False);
    FRel.AddCol(050,1,'C','' ,''              ,'Copa'           ,''         ,'',False);
    FRel.AddCol( 50,3,'N','+',''              ,'Pedido'    ,''         ,'',False);
    FRel.AddCol( 90,1,'C','',''              ,'Recebido 1 '    ,''         ,'',False);
    FRel.AddCol( 90,1,'C','',''              ,'Recebido 2 '     ,''         ,'',False);
    FRel.AddCol( 90,1,'C','',''              ,'Recebido 3 '  ,''         ,'',False);
    while not Q.eof do begin
        FRel.AddCel(Q.FieldByName('moco_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('moco_datalcto').AsString);
//        FRel.AddCel(Q.FieldByName('moco_datacont').AsString);
//        FRel.AddCel(Q.FieldByName('mocm_datamvto').AsString);
        FRel.AddCel(Q.FieldByName('mocm_dataentrega').AsString);
        FRel.AddCel(Q.FieldByName('moco_numerodoc').AsString);
        FRel.AddCel(Q.fieldbyname('moco_tipo_codigo').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moco_tipo_codigo').asinteger,Q.FieldByName('moco_tipocad').AsString,'N'));
        FRel.AddCel(Q.fieldbyname('moco_esto_codigo').asstring);
        FRel.AddCel(Q.fieldbyname('esto_descricao').asstring);
//        FRel.AddCel(Q.fieldbyname('moco_tama_codigo').asstring);
        FRel.AddCel(FTamanhos.GetDescricao(Q.fieldbyname('moco_tama_codigo').asinteger));
//        FRel.AddCel(Q.fieldbyname('moco_core_codigo').asstring);
        FRel.AddCel(FCores.GetDescricao(Q.fieldbyname('moco_core_codigo').asinteger));
//        FRel.AddCel(Q.fieldbyname('moco_copa_codigo').asstring);
        FRel.AddCel(FCopas.GetDescricao(Q.fieldbyname('moco_copa_codigo').asinteger));
        FRel.AddCel(Q.fieldbyname('moco_qtde').asstring);
        FRel.AddCel('_______________');
        FRel.AddCel('_______________');
        FRel.AddCel('_______________');
       Q.Next;
    end;
    FRel.Video;

    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);
  end;

  FRelCompras_RecebimentoContagem;         // 5
end;


end.
