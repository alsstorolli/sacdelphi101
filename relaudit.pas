unit relaudit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid, ACBrSpedPisCofins, ACBrEPCBlocos, Sqlsis;

type
  TFRelAuditorias = class(TForm)
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
    EdEsto_codigo: TSQLEd;
    SetEdFUNC_NOME: TSQLEd;
    EdMesanoi: TSQLEd;
    EdMesanof: TSQLEd;
    EdGrup_codigo: TSQLEd;
    SetEdDEPT_DESCRICAO: TSQLEd;
    procedure baplicarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edunid_codigoValidate(Sender: TObject);
    procedure EdEsto_codigoExitEdit(Sender: TObject);
    procedure EddatafValidate(Sender: TObject);
    procedure EdMesanofExitEdit(Sender: TObject);
    procedure EdMesanoiExitEdit(Sender: TObject);
    procedure EdGrup_codigoValidate(Sender: TObject);
// 08.01.18
    function TributaPIS(ycst:TACBrSituacaoTribPIS):boolean;
  private
    { Private declarations }
    SaiOk:Boolean;
  public
    { Public declarations }
  end;

var
  FRelAuditorias: TFRelAuditorias;
  largura,margem:integer;
  sqlunidade,sqltipomovto,sqlproduto,sqldatacont,sqlgrupo:string;
  campo                :TDicionario;


procedure FRelAuditorias_Canceladas;           // 1
procedure FRelAuditorias_EvolucaoCusto;           // 2
procedure FRelAuditorias_ComparaInventario;           // 3
procedure FRelAuditorias_ChecaSaldo;   // 4
procedure FRelAuditorias_ChecaNotasFinan;   // 5
procedure FRelAuditorias_ChecaPiscofins;   // 6
procedure FRelAuditorias_ChecaTributacaoVendas;   // 7

implementation

uses Geral, RelGerenciais, Unidades, SQLRel, Sqlexpr, Sqlfun ,
  Usuarios, plano, Estoque, relestoque, grupos, conpagto, portador,spedpiscofins,
  codigosipi,pcnconversao, codigosfis;

{$R *.dfm}


function FRelAuditorias_Execute(Tp:Integer):Boolean;
/////////////////////////////////////////////////////////
begin
  if FRelAuditorias=nil then FGeral.CreateForm(TFRelAuditorias, FRelAuditorias);
  result:=true;
  FGeral.SetaItemsMovimento(FRelAuditorias.EdTipomov);
  sqlunidade:='';
  sqltipomovto:='';
  with FRelAuditorias do begin
    FUnidades.SetaItems(EdUnid_codigo,nil,Global.Usuario.UnidadesRelatorios);
    EdUnid_codigo.Text:=Global.Usuario.UnidadesRelatorios;
    if tp=1 then
      Caption:='Relat�rio de transa��es canceladas'
    else if tp=2 then
      Caption:='Relat�rio de Evolu��o do Custo'
    else if tp=3 then
      Caption:='Relat�rio de Compara��o de Invent�rios'
    else if tp=4 then
      Caption:='Relat�rio de Checagem de Saldo de Estoque'
    else if tp=5 then
      Caption:='Relat�rio de Checagem de Notas Fiscais com Financeiro'
    else if tp=6 then
      Caption:='Relat�rio de Checagem de Pis e Cofins';
    largura:=80;
    if tp=2 then  begin
      EdTipomov.enabled:=false;
      EdTipomov.text:=Global.CodCompra+';'+Global.CodCompra100+';'+Global.CodCompraX;
      EdEsto_codigo.enabled:=true;
    end else if tp=5 then begin
      EdTipomov.enabled:=false;
      EdEsto_codigo.enabled:=false;
    end else begin
      EdTipomov.enabled:=true;
      EdEsto_codigo.enabled:=false;
    end;
    EdMesanoi.enabled:=tp=3;
    EdMesanof.enabled:=tp=3;
    EdDatai.enabled:=true;
    EdDataf.enabled:=true;
    EdGrup_codigo.enabled:=false;
    if (tp=3) or (tp=4) then begin
      EdDatai.enabled:=false;
      EdDataf.enabled:=false;
      EdTipomov.enabled:=false;
      EdGrup_codigo.enabled:=true;
    end;
    if tp=4 then begin
      EdMesanoi.enabled:=true;
      EdEsto_codigo.enabled:=true;
    end;
    SaiOk:=False;
    FRelAuditorias.ShowModal;
    Result:=SaiOk;
  end;
end;


procedure FRelAuditorias_Canceladas;         // 1
///////////////////////////////////////////////////////
var Q,Q1:TSqlquery;
    sqlunidade1,sqltipomovto1,livro:string;

begin

  with FRelAuditorias do begin
    if not FRelAuditorias_Execute(1) then Exit;
    Sistema.beginprocess('Pesquisando transa��es canceladas no per�odo');
    if trim(EdUnid_codigo.text)<>'' then begin
      sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
      sqlunidade1:=' and '+FGeral.getin('movf_unid_codigo',EdUnid_codigo.text,'C');
    end else begin
      sqlunidade:='';
      sqlunidade1:='';
    end;
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('moes_tipomov',EdTipomov.text,'C');
      sqltipomovto1:=' and '+FGeral.getin('movf_tipomov',EdTipomov.text,'C');
    end else begin
      sqltipomovto:='';
      sqltipomovto1:='';
    end;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
      sqldatacont:=' and moes_datacont>1';

    Q:=sqltoquery('select * from movesto'+
                  ' left join log on ( log_transacaocanc=moes_transacao )'+
                  ' where '+FGeral.getin('moes_status','C;X','C')+' and moes_datamvto>='+EdDatai.assql+
                    sqlunidade+sqltipomovto+sqldatacont+
                  ' and moes_datamvto<='+EdDAtaf.assql+' order by moes_unid_codigo,moes_usua_codigo');
//    if Q.eof then begin
//      Avisoerro('Nada encontrado para impress�o');
//      Q.close;
//      Freeandnil(Q);
//      exit;
//    end;
    Q1:=sqltoquery('select * from movfin'+
                  ' left join log on ( log_transacaocanc=movf_transacao )'+
                  ' where movf_status=''C'' and movf_datamvto>='+EdDatai.assql+
                   sqlunidade1+sqltipomovto1+
                  ' and movf_datamvto<='+EdDAtaf.assql+' order by movf_unid_codigo,movf_usua_codigo');

    FRel.Init('RelAuditoriaCanceladas');
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
    FRel.AddTit('Rela��o de Transa��es Canceladas');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
    FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
    FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    FRel.AddCol( 90,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Lan�amento'  ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'    ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Emiss�o'    ,''         ,'',false);
    FRel.AddCol( 70,3,'N','' ,''              ,'Numero Doc.'     ,''         ,'',False);
    FRel.AddCol( 70,1,'C','' ,''              ,'Reg.Livro'     ,''         ,'',False);
    FRel.AddCol( 60,1,'C','' ,''              ,'Codigo'           ,''         ,'',false);
    FRel.AddCol(200,1,'C','' ,''              ,'Nome'            ,''         ,'',false);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'Valor'           ,''         ,'',False);
    FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
    FRel.AddCol(200,0,'C','' ,''              ,'Obs'            ,''         ,'',False);
    FRel.AddCol( 60,3,'N','' ,''              ,'Digitado'  ,''         ,'',false);
    FRel.AddCol(100,1,'C','' ,''              ,'Nome digitado'            ,''         ,'',false);
    FRel.AddCol( 60,3,'N','' ,''              ,'Pediu canc.',''         ,'',false);
    FRel.AddCol(100,1,'C','' ,''              ,'Quem Pediu'                ,''         ,'',false);
    FRel.AddCol(300,1,'C','' ,''              ,'Motivo'            ,''         ,'',false);
    FRel.AddCol( 60,3,'D','' ,''              ,'Data Canc.'  ,''         ,'',false);
    FRel.AddCol( 60,3,'N','' ,''              ,'Cancelou'  ,''         ,'',false);
    FRel.AddCol(100,1,'C','' ,''              ,'Nome cancelou'            ,''         ,'',false);
    while not Q.eof do begin
        FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
        FRel.AddCel(Q.FieldByName('moes_datalcto').AsString);
        FRel.AddCel(Q.FieldByName('moes_datacont').AsString);
        FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
        FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
        if Q.FieldByName('moes_status').AsString='X' then
          livro:='S'
        else
          livro:='N';
        FRel.AddCel(livro);
        FRel.AddCel(Q.fieldbyname('moes_tipo_codigo').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.FieldByName('moes_tipocad').AsString,'N'));
        FRel.AddCel(Q.FieldByName('moes_vlrtotal').AsString);
        FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));
        FRel.AddCel(Q.FieldByName('moes_mensagem').AsString);
        FRel.AddCel(Q.fieldbyname('moes_usua_codigo').asstring);
        FRel.AddCel(FUsuarios.GetNome(Q.fieldbyname('moes_usua_codigo').asinteger));
        FRel.AddCel(Q.fieldbyname('log_usua_canc').asstring);
        FRel.AddCel(FUsuarios.GetNome(Q.fieldbyname('log_usua_canc').asinteger));
        FRel.AddCel(Q.fieldbyname('log_motivo').asstring);
        FRel.AddCel(Q.fieldbyname('log_data').asstring);
        FRel.AddCel(Q.fieldbyname('log_usua_codigo').asstring);
        FRel.AddCel(FUsuarios.GetNome(Q.fieldbyname('log_usua_codigo').asinteger));
        Q.Next;
    end;
    while not Q1.eof do begin
        FRel.AddCel(Q1.FieldByName('movf_unid_codigo').AsString);
        FRel.AddCel(Q1.FieldByName('movf_transacao').AsString);
        FRel.AddCel(Q1.FieldByName('movf_datalcto').AsString);
        FRel.AddCel(Q1.FieldByName('movf_datacont').AsString);
        FRel.AddCel(Q1.FieldByName('movf_datamvto').AsString);
        FRel.AddCel(Q1.FieldByName('movf_numerodcto').AsString);
        FRel.AddCel('');
        FRel.AddCel(Q1.fieldbyname('movf_plan_conta').asstring);
        FRel.AddCel(FPlano.GetDescricao(Q1.fieldbyname('movf_plan_conta').asinteger));
        FRel.AddCel(Q1.FieldByName('movf_valorger').AsString);
        FRel.AddCel(Q1.FieldByName('movf_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q1.FieldByName('movf_tipomov').AsString));
        FRel.AddCel(Q1.FieldByName('movf_complemento').AsString);
        FRel.AddCel(Q1.fieldbyname('movf_usua_codigo').asstring);
        FRel.AddCel(FUsuarios.GetNome(Q1.fieldbyname('movf_usua_codigo').asinteger));
        FRel.AddCel(Q1.fieldbyname('log_usua_canc').asstring);
        FRel.AddCel(FUsuarios.GetNome(Q1.fieldbyname('log_usua_canc').asinteger));
        FRel.AddCel(Q1.fieldbyname('log_motivo').asstring);
        FRel.AddCel(Q1.fieldbyname('log_data').asstring);
        FRel.AddCel(Q1.fieldbyname('log_usua_codigo').asstring);
        FRel.AddCel(FUsuarios.GetNome(Q1.fieldbyname('log_usua_codigo').asinteger));
        Q1.Next;
    end;
    FRel.Setsort('Transa��o');
    FRel.Video;

    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);
    Q1.Close;Freeandnil(Q1);
  end;

  FRelAuditorias_Canceladas;         // 1

end;


procedure FRelAuditorias_EvolucaoCusto;         // 2

type TCustos=record
     unidade,produto,tipo,transacao:string;
     customed1,customed2,customed3,customed4,customedger1,customedger2,customedger3,customedger4:currency;
end;

var Q:TSqlquery;
    ListaCustos:TList;
    PCustos:^TCustos;
    i:integer;
    perc:currency;


    procedure GuardaLista(unidade,produto,tipomov:string ; customedio,customeger:currency);
    var p:integer;
        achou:boolean;
    begin
      achou:=false;
      for p:=0 to ListaCustos.count-1 do begin
         PCustos:=ListaCustos[p];
         if (PCustos.unidade=unidade) and (PCustos.produto=produto)  then begin
           achou:=true;
           break;
         end;
      end;
      if not achou then begin
        New(PCustos);
        PCustos.unidade:=unidade;
        PCustos.produto:=produto;
        PCustos.tipo:=tipomov;
        Pcustos.transacao:=Q.fieldbyname('move_transacao').asstring;
        PCustos.customed1:=Customedio;
        PCustos.customed2:=0;
        PCustos.customed3:=0;
        PCustos.customed4:=0;
        PCustos.customedger1:=Customeger;
        PCustos.customedger2:=0;
        PCustos.customedger3:=0;
        PCustos.customedger4:=0;
        ListaCustos.Add(PCustos);
      end else begin
        if PCustos.customed2=0 then begin
          if (PCustos.customed2<>customedio) and (PCustos.customed1<>customedio) then
            PCustos.customed2:=Customedio;
        end else if PCustos.customed3=0 then begin
          if (PCustos.customed3<>customedio) and (PCustos.customed1<>customedio) and (PCustos.customed2<>customedio) then
            PCustos.customed3:=Customedio;
        end else if PCustos.customed4=0 then begin
          if (PCustos.customed4<>customedio)  and  (PCustos.customed1<>customedio) and (PCustos.customed2<>customedio)  and (PCustos.customed3<>customedio) then
            PCustos.customed4:=Customedio;
        end;
        if PCustos.customedger2=0 then begin
          if (PCustos.customedger2<>customeger) and (PCustos.customedger1<>customeger) then
            PCustos.customedger2:=Customeger;
        end else if PCustos.customedger3=0 then begin
          if (PCustos.customedger3<>customeger)  and (PCustos.customedger2<>customeger)  and  (PCustos.customedger2<>customeger) then
            PCustos.customedger3:=Customeger;
        end else if PCustos.customedger4=0 then begin
          if (PCustos.customedger4<>customeger)  and (PCustos.customedger2<>customeger)  and  (PCustos.customedger3<>customeger) and (PCustos.customedger1<>customeger) then
            PCustos.customedger4:=Customeger;
        end;
      end;

    end;

begin

  with FRelAuditorias do begin

    if not FRelAuditorias_Execute(2) then Exit;
    Sistema.beginprocess('Pesquisando movimento de compras no per�odo');
    if trim(EdUnid_codigo.text)<>'' then begin
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C');
    end else begin
      sqlunidade:='';
    end;
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C');
    end else begin
      sqltipomovto:='';
    end;
    if EdEsto_codigo.isempty then
      sqlproduto:=''
    else
      sqlproduto:=' and move_esto_codigo='+EdEsto_codigo.AsSql;
// 24.03.06
    if Global.Usuario.OutrosAcessos[0701] then
      sqldatacont:=''
    else
      sqldatacont:=' and move_datacont>1';

    Q:=sqltoquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                  ' where move_status=''N'' and move_datamvto>='+EdDatai.assql+
                   sqlunidade+sqltipomovto+sqlproduto+sqldatacont+sqlproduto+
                  ' and move_datamvto<='+EdDAtaf.assql+' order by move_datamvto');
    if Q.eof then begin
      sistema.endprocess('Nada encontrado para impress�o');
      Q.close;
      Freeandnil(Q);
      exit;
    end;
    ListaCustos:=TList.create;
    Sistema.beginprocess('Separando movimento de compras no per�odo por produto');
    while not Q.eof do begin
      GuardaLista(Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('move_esto_codigo').asstring,
                  Q.fieldbyname('move_tipomov').asstring,Q.fieldbyname('move_customedio').ascurrency,
                  Q.fieldbyname('move_customeger').ascurrency);
      Q.Next;
    end;

    FRel.Init('RelAuditoriaEvolucaoCusto');
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
    FRel.AddTit('Relat�rio de Evolu��o do Custo');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
    FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
    FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    FRel.AddCol( 90,0,'N','' ,''              ,'Produto'         ,''         ,'',false);
    FRel.AddCol(160,1,'C','' ,''              ,'Descri��o'   ,''         ,'',false);
//    FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'M�dio 1'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'M�dio 2'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'M�dio 3'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'M�dio 4'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'% Aumento'         ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'M�dio Ger. 1'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'M�dio Ger. 2'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'M�dio Ger. 3'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'M�dio Ger. 4'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','' ,f_cr            ,'% Aumento Ger.'         ,''         ,'',False);
    for i:=0 to ListaCustos.count-1 do begin
        PCustos:=ListaCustos[i];
        FRel.AddCel(PCustos.unidade);
        FRel.AddCel(PCustos.produto);
        FRel.AddCel(FEstoque.getdescricao(PCustos.produto));

//        FRel.AddCel(PCustos.tipo);
          FRel.AddCel(floattostr(PCustos.customed1));
          FRel.AddCel(floattostr(PCustos.customed2));
          FRel.AddCel(floattostr(PCustos.customed3));
          FRel.AddCel(floattostr(PCustos.customed4));
          perc:=0;
          if (Pcustos.customed2>0) and (Pcustos.customed1>0) then
            perc:=(Pcustos.customed2-Pcustos.customed1) / Pcustos.customed1;
          if (Pcustos.customed3>0) and (Pcustos.customed2>0) then
            perc:=(Pcustos.customed3-Pcustos.customed2) / Pcustos.customed2;
          if (Pcustos.customed4>0) and (Pcustos.customed3>0) then
            perc:=(Pcustos.customed4-Pcustos.customed3) / Pcustos.customed3;
          FRel.AddCel(floattostr(perc*100));
          FRel.AddCel(floattostr(PCustos.customedger1));
          FRel.AddCel(floattostr(PCustos.customedger2));
          FRel.AddCel(floattostr(PCustos.customedger3));
          FRel.AddCel(floattostr(PCustos.customedger4));
          if (Pcustos.customed2>0) and (Pcustos.customedger1>0) then
            perc:=(Pcustos.customedger2-Pcustos.customedger1) / Pcustos.customedger1;
          if (Pcustos.customedger3>0) and (Pcustos.customedger2>0) then
            perc:=(Pcustos.customedger3-Pcustos.customedger2) / Pcustos.customedger2;
          if (Pcustos.customedger4>0) and (Pcustos.customedger3>0) then
            perc:=(Pcustos.customedger4-Pcustos.customedger3) / Pcustos.customedger3;
          FRel.AddCel(floattostr(perc*100));
    end;
    FRel.Setsort('% Aumento Ger.',false);
    FRel.Video;

    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);
  end;

  FRelAuditorias_EvolucaoCusto;         // 2

end;


procedure FRelAuditorias_ComparaInventario;           // 3
type TCusto=record
     esto_codigo,estimado,estimadof:string;
     custo,customedio,custoger,customeger,venda,custof,customediof,custogerf,
     customegerf,vendaf,qtde,qtdef,qtdeprev,qtdeprevf:currency;
end;

var Q,QF:TSqlquery;
    cor,tamanho,x:integer;
    PCusto:^TCusto;
    Listacusto:Tlist;

    procedure Atualiza(Qx:tsqlquery ; Qual:string );
    var p:integer;
        achou:boolean;
    begin
      achou:=false;
      for p:=0 to ListaCusto.count-1 do begin
        PCusto:=ListaCusto[p];
        if PCusto.esto_codigo=Qx.fieldbyname('saes_esto_codigo').asstring then begin
          achou:=true;
          break;
        end;
      end;
      if not achou then begin
        New(PCusto);
        PCusto.esto_codigo:=Qx.fieldbyname('saes_esto_codigo').asstring;
        if Qual='I' then begin
          PCusto.custo:=Qx.fieldbyname('saes_custo').ascurrency;
          PCusto.customedio:=Qx.fieldbyname('saes_customedio').ascurrency;
          PCusto.custoger:=Qx.fieldbyname('saes_custoger').ascurrency;
          PCusto.customeger:=Qx.fieldbyname('saes_customeger').ascurrency;
          PCusto.qtde:=Qx.fieldbyname('saes_qtde').ascurrency;
          PCusto.qtdeprev:=Qx.fieldbyname('saes_qtdeprev').ascurrency;
          PCusto.custof:=0;
          PCusto.customediof:=0;
          PCusto.custogerf:=0;
          PCusto.customegerf:=0;
          PCusto.qtdef:=0;
          PCusto.qtdeprevf:=0;
        end else begin
          PCusto.custof:=Qx.fieldbyname('saes_custo').ascurrency;
          PCusto.customediof:=Qx.fieldbyname('saes_customedio').ascurrency;
          PCusto.custogerf:=Qx.fieldbyname('saes_custoger').ascurrency;
          PCusto.customegerf:=Qx.fieldbyname('saes_customeger').ascurrency;
          PCusto.qtdef:=Qx.fieldbyname('saes_qtde').ascurrency;
          PCusto.qtdeprevf:=Qx.fieldbyname('saes_qtdeprev').ascurrency;
          PCusto.custo:=0;
          PCusto.customedio:=0;
          PCusto.custoger:=0;
          PCusto.customeger:=0;
          PCusto.qtde:=0;
          PCusto.qtdeprev:=0;
        end;
        ListaCusto.add(PCusto);
      end else begin
        if Qual='I' then begin
          PCusto.custo:=Qx.fieldbyname('saes_custo').ascurrency;
          PCusto.customedio:=Qx.fieldbyname('saes_customedio').ascurrency;
          PCusto.custoger:=Qx.fieldbyname('saes_custoger').ascurrency;
          PCusto.customeger:=Qx.fieldbyname('saes_customeger').ascurrency;
          PCusto.qtde:=Qx.fieldbyname('saes_qtde').ascurrency;
          PCusto.qtdeprev:=Qx.fieldbyname('saes_qtdeprev').ascurrency;
          PCusto.custof:=0;
          PCusto.customediof:=0;
          PCusto.custogerf:=0;
          PCusto.customegerf:=0;
          PCusto.qtdef:=0;
          PCusto.qtdeprevf:=0;
        end else begin
          PCusto.custof:=Qx.fieldbyname('saes_custo').ascurrency;
          PCusto.customediof:=Qx.fieldbyname('saes_customedio').ascurrency;
          PCusto.custogerf:=Qx.fieldbyname('saes_custoger').ascurrency;
          PCusto.customegerf:=Qx.fieldbyname('saes_customeger').ascurrency;
          PCusto.qtdef:=Qx.fieldbyname('saes_qtde').ascurrency;
          PCusto.qtdeprevf:=Qx.fieldbyname('saes_qtdeprev').ascurrency;
{
          PCusto.custo:=0;
          PCusto.customedio:=0;
          PCusto.custoger:=0;
          PCusto.customeger:=0;
          PCusto.qtde:=0;
          PCusto.qtdeprev:=0;
}
        end;
      end;
    end;

begin

  with FRelAuditorias do begin

    if not FRelAuditorias_Execute(3) then Exit;
    if Global.Usuario.OutrosAcessos[0010] then
      sqlqtde:=' and saes_qtdeprev<>0'
    else
      sqlqtde:=' and saes_qtde<>0';
    if (FRelAuditorias.EdUnid_codigo.isempty) or ( copy(FRelAuditorias.EdUnid_codigo.text,5,1)<>'' ) then begin
      Avisoerro('Obrigat�rio informar SOMENTE UMA unidade');
      exit;
    end;
   sqlunidade:=' and '+FGeral.getin('saes_unid_codigo',copy(FRelAuditorias.EdUnid_codigo.text,1,3),'C');

   Sistema.BeginProcess('Pesquisando invent�rio inicial');
   Q:=sqltoquery('select * from salestoque '+
                  ' inner join estoque on (esto_codigo=saes_esto_codigo) '+
                  ' inner join grupos on (grup_codigo=esto_grup_codigo) '+
                  ' left join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
                  ' left join familias on (fami_codigo=esto_fami_codigo) '+
                  ' where saes_mesano='+stringtosql(FGeral.Anomesinvertido(FRelAuditorias.EdMesanoi.text))+
                  sqlunidade+
                 sqlgrupo+sqlproduto+sqlqtde+
                  ' and '+FGeral.Getin('saes_status','N','C')+
                ' order by saes_unid_codigo,saes_esto_codigo,saes_tama_codigo,saes_core_codigo' );

    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin

       ListaCusto:=TList.create;
       while not Q.eof do begin
         Atualiza(Q,'I');
         Q.Next;
       end;

      Sistema.BeginProcess('Pesquisando invent�rio final');
      QF:=sqltoquery('select * from salestoque '+
                    ' inner join estoque on (esto_codigo=saes_esto_codigo) '+
                    ' inner join grupos on (grup_codigo=esto_grup_codigo) '+
                    ' left join subgrupos on (sugr_codigo=esto_sugr_codigo) '+
                    ' left join familias on (fami_codigo=esto_fami_codigo) '+
                    ' where saes_mesano='+stringtosql(FGeral.Anomesinvertido(FRelAuditorias.EdMesanof.text))+
                    sqlunidade+
                   sqlgrupo+sqlproduto+sqlqtde+
                    ' and '+FGeral.Getin('saes_status','N','C')+
                  ' order by saes_unid_codigo,saes_esto_codigo,saes_tama_codigo,saes_core_codigo' );

      while not QF.eof do begin
         Atualiza(QF,'F');
         QF.Next;
      end;

      Sistema.BeginProcess('Gerando Relat�rio');
      FRel.Init('RelComparaInventario');
      FRel.AddTit('Comparativo Invent�rio Final de Estoque do mes de '+copy(FRelauditorias.EdMesanoi.text,1,2)+'/'+copy(FRelauditorias.EdMesanoi.text,3,4)+
                   ' e '+copy(FRelauditorias.EdMesanof.text,1,2)+'/'+copy(FRelauditorias.EdMesanof.text,3,4)  );
      FRel.AddTit(FGeral.TituloRelUnidade(FRelAuditorias.EdUnid_codigo.Text));
      FRel.AddCol( 60,1,'C','' ,''              ,'Grupo'           ,''         ,'',false);
      FRel.AddCol(100,1,'C','' ,''              ,'Desc. Grupo'     ,''         ,'',false);
      FRel.AddCol( 80,0,'N','' ,''              ,'Cod.Prod'        ,''         ,'',False);
      FRel.AddCol(130,1,'C','' ,''              ,'Produto'          ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Saldo Produto'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','' ,''              ,'Custo M�dio'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',''              ,'Total M�dio'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+' ,''             ,'Saldo Produto 2'        ,''         ,'',False);
      FRel.AddCol( 80,3,'N','' ,''              ,'Custo M�dio 2'       ,''         ,'',False);
      FRel.AddCol( 80,3,'N','+',''              ,'Total M�dio 2'       ,''         ,'',False);
      if Global.Usuario.OutrosAcessos[0010] then begin
        FRel.AddCol( 80,3,'N','+' ,''             ,'Saldo Previsto'        ,''         ,'',False);
        FRel.AddCol(100,3,'N','' ,''              ,'Custo Previsto M�dio'       ,''         ,'',False);
        FRel.AddCol(100,3,'N','+',''              ,'Total Previsto M�dio'    ,''         ,'',False);
        FRel.AddCol( 80,3,'N','+' ,''             ,'Saldo Previsto 2'        ,''         ,'',False);
        FRel.AddCol(100,3,'N','' ,''              ,'Custo Previsto M�dio 2'       ,''         ,'',False);
        FRel.AddCol(100,3,'N','+',''              ,'Total Previsto M�dio 2'    ,''         ,'',False);
      end;

      for x:=0 to Listacusto.count-1 do begin
         PCusto:=Listacusto[x];
         FRel.AddCel( strzero( FEstoque.GetGrupo(PCusto.esto_codigo),3 ) );
         FRel.AddCel( FGrupos.GetDescricao(FEstoque.GetGrupo(PCusto.esto_codigo)) );
         FRel.AddCel( PCusto.esto_codigo );
         FRel.AddCel(FEstoque.GetDescricao(PCusto.esto_codigo));
         FRel.AddCel(transform(PCusto.qtde,f_cr));
         FRel.AddCel(transform(PCusto.customedio,f_cr));
         FRel.AddCel(transform(PCusto.customedio*PCusto.qtde,f_cr));
         FRel.AddCel(transform(PCusto.qtdef,f_cr));
         FRel.AddCel(transform(PCusto.customediof,f_cr));
         FRel.AddCel(transform(PCusto.customediof*PCusto.qtdef,f_cr));
//            tamanho:=Q.fieldbyname('saes_tama_codigo').asinteger;
//            cor:=Q.fieldbyname('saes_core_codigo').asinteger;

         if Global.Usuario.OutrosAcessos[0010] then begin
               FRel.AddCel(transform(PCusto.qtdeprev,f_cr));
               FRel.AddCel(transform(PCusto.customeger,f_cr));
               FRel.AddCel(transform(PCusto.customeger*PCusto.qtdeprev,f_cr));
               FRel.AddCel(transform(PCusto.qtdeprevf,f_cr));
               FRel.AddCel(transform(PCusto.customegerf,f_cr));
               FRel.AddCel(transform(PCusto.customegerf*PCusto.qtdeprevf,f_cr));
         end;

      end;
      FRel.Video;
    end;
    Sistema.EndProcess('');
    Fgeral.Fechaquery(Q);
    Fgeral.Fechaquery(QF);
    Listacusto.free;
  end;

  FRelAuditorias_ComparaInventario;        // 3

end;

procedure FRelAuditorias_ChecaSaldo;   // 4

type TRegistro=record
    Codigo,unidade,contagem:string;
    saldomov,saldomovprev,saldoinv,saldoinvprev,customeger,saldomovant,saldomovprevant:currency;
end;

type ARegistro=TRegistro;

var unidade,produto,op,sqlinicio,nome,sqltermino,sqlproduto,contagem:string;
    saldoanterior,saldo,pentradas,psaidas,psemmov,tentradas,tsaidas,tsemmov,salantpecas:currency;
    x:integer;
    QBusca,Q,QInventa:TSqlquery;
    Lista:TList;
    PRegistro:^ARegistro;

    function Busca(Tipo,codigo:string):string;
    begin
      if tipo='C' then begin
        QBusca:=sqltoquery('select clie_nome from clientes where clie_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('clie_nome').AsString
        else
          result:=''
      end else if tipo='F' then begin
        QBusca:=sqltoquery('select forn_nome from fornecedores where forn_codigo='+stringtosql(codigo));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('forn_nome').AsString
        else
          result:=''
      end else begin
        QBusca:=sqltoquery('select unid_nome,unid_reduzido from unidades where unid_codigo='+stringtosql(formatfloat('000',strtocurr(codigo))));
        if not QBusca.eof then
          result:=QBusca.fieldbyname('unid_reduzido').AsString
        else
          result:=''
      end;
      FGeral.FechaQuery(QBusca);
    end;

    procedure Atualiza(produto,unidade,qtipo:string;saldo,saldoprev:currency;contestoque:string);
    var p:integer;
        found:boolean;
    begin
      for p:=0 to Lista.count-1 do begin
        PRegistro:=Lista[p];
        if (PRegistro.Codigo=produto) and (PRegistro.unidade=unidade) then begin
          found:=true;
          break;
        end;
      end;
      if not found then begin
         New(PRegistro);
         PRegistro.unidade:=unidade;
         PRegistro.Codigo:=produto;
         PRegistro.saldomovant:=FGeral.EstoqueAnterior(produto,unidade,texttodate('01'+FRelAuditorias.EdMesanoi.text),salantpecas);
         PRegistro.saldomovprevant:=FGeral.EstoqueAnterior(produto,unidade,texttodate('01'+FRelAuditorias.EdMesanoi.text),salantpecas);
         PRegistro.contagem:='N';
         if qtipo='I' then begin
           PRegistro.saldomov:=0;
           PRegistro.saldomovprev:=0;
           PRegistro.saldoinv:=saldo;
           PRegistro.saldoinvprev:=saldoprev;
           PRegistro.customeger:=QINventa.fieldbyname('saes_customeger').ascurrency;
         end else begin
           PRegistro.saldomov:=saldo;
           PRegistro.saldomovprev:=saldoprev;
           PRegistro.saldoinv:=0;
           PRegistro.saldoinvprev:=0;
           PRegistro.customeger:=FEstoque.GetCusto(produto,Global.unidadematriz,'medioger');
         end;
         Lista.add(PRegistro);
      end else begin
         if qtipo='I' then begin
           PRegistro.saldoinv:=PRegistro.saldoinv+saldo;
           PRegistro.saldoinvprev:=PRegistro.saldoinvprev+saldoprev;
         end else begin
           if Contestoque='N' then begin
             PRegistro.saldomov:=PRegistro.saldomov+saldo;
             PRegistro.saldomovprev:=PRegistro.saldomovprev+saldoprev;
           end else begin
             PRegistro.contagem:='S';
             PRegistro.saldomov:=saldo;
             PRegistro.saldomovprev:=saldoprev;
             PRegistro.saldomovant:=0;  // pois no final soma o saldo anterior com o movimento....
             PRegistro.saldomovprevant:=0;
           end;
         end;
      end;
// primeiro atualiza os saldo do inventario depois o saldo vindo do movimento

    end;


begin

  with FRelAuditorias do begin

    if not FRelAuditorias_Execute(4) then Exit;
//////////////////////////////////////
    sqlproduto:='';
    if not EdEsto_codigo.isempty then
      sqlproduto:='and saes_esto_codigo='+EdEsto_codigo.assql;
    Sistema.BeginProcess('Pesquisando saldo invent�rio final de '+FRelAuditorias.EdMesanoi.text);
    QInventa:=sqltoquery('select * from salestoque left join estoque on ( esto_codigo=saes_esto_codigo )'+
                         ' inner join grupos on (grup_codigo=esto_grup_codigo) '+
                         ' where saes_status=''N'' and '+FGeral.Getin('saes_unid_codigo',EdUnid_codigo.text,'C')+
                         ' and saes_mesano='+stringtosql(FGeral.Anomesinvertido(FRelAuditorias.EdMesanoi.text))+
                         sqlproduto+sqlgrupo+
                         ' and saes_qtde<>0 and saes_qtdeprev<>0' );

    if QInventa.eof then begin
        Sistema.EndProcess('N�o encontrado invent�rio de '+FRelAuditorias.EdMesanoi.text);
        FGeral.Fechaquery(QInventa);
        exit;
    end;
    Lista:=TList.create;
    while not QINventa.eof do begin
      Atualiza(QINventa.fieldbyname('saes_esto_codigo').asstring,QINventa.fieldbyname('saes_unid_codigo').asstring,'I',
               QINventa.fieldbyname('saes_qtde').ascurrency,QINventa.fieldbyname('saes_qtdeprev').ascurrency,'N');
      QInventa.next;
    end;
    Sistema.BeginProcess('Pesquisando movimento');
    unidade:=copy(FRelAuditorias.EdUnid_codigo.Text,1,3);
    sqlinicio:=' and move_datamvto>='+Datetosql(texttodate('01'+FRelAuditorias.EdMesanoi.text));
    sqltermino:=' and move_datamvto<='+Datetosql(DatetoUltimodiames(texttodate('01'+FRelAuditorias.EdMesanoi.text)) );
    sqlproduto:='';
    if not EdEsto_codigo.isempty then
      sqlproduto:='and move_esto_codigo='+EdEsto_codigo.assql;
    Q:=sqltoquery('select * from movestoque '+
                     ' left join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov) '+
                     ' inner join estoque on (esto_codigo=move_esto_codigo) '+
                     ' inner join grupos on (grup_codigo=esto_grup_codigo) '+
                     ' where '+FGeral.RelEstoque('move_status')+
                     ' and '+FGeral.Getin('move_unid_codigo',EdUnid_codigo.text,'C')+
                     sqlinicio+
                     sqltermino+
                     sqlproduto+sqlgrupo+
                     ' order by move_esto_codigo,move_datamvto,move_numerodoc' );

    if Q.eof then begin
        Sistema.EndProcess('Nada encontrado para impress�o');
        FGeral.Fechaquery(Q);
        exit;
    end;

      unidade:=copy(FRelAuditorias.EdUNid_codigo.Text,1,3);
      tentradas:=0;tsaidas:=0;tsemmov:=0;
      Sistema.BeginProcess('Calculando saldo pelo movimento');
      while not Q.eof do begin

        produto:=Q.FieldByName('move_esto_codigo').AsString;
///////////////        if Trim(EdEsto_codigo.text)<>'' then
//        saldoanterior:=FGeral.EstoqueAnterior(produto,unidade,texttodate('01'+FRelAuditorias.EdMesanoi.text));
//        if Trim(EdEsto_codigo.text)<>'' then
//        saldo:=saldoanterior;
        saldo:=0;

        pentradas:=0;psaidas:=0;psemmov:=0;
        contagem:='N';
        while (not Q.eof) and (produto=Q.FieldByName('move_esto_codigo').AsString) do begin

          op:=FGeral.GetEntSaiTipoMovto(Q.FieldByName('move_tipomov').AsString);
          if op='+' then begin
//            if Trim(EdEsto_codigo.text)<>'' then
              saldo:=saldo+Q.FieldByName('move_qtde').AsFloat;

            pentradas:=pentradas+Q.FieldByName('move_qtde').AsFloat;
            tentradas:=tentradas+Q.FieldByName('move_qtde').AsFloat;
          end else if op='-' then begin
//            if Trim(EdEsto_codigo.text)<>'' then
              saldo:=saldo-Q.FieldByName('move_qtde').AsFloat;
            psaidas:=psaidas+Q.FieldByName('move_qtde').AsFloat;
            tsaidas:=tsaidas+Q.FieldByName('move_qtde').AsFloat;
          end else if op='B' then begin  // 28.11.05
//            FTextRel.SetColuna(06,Q.FieldByName('move_estoque').AsFloat);
            psemmov:=psemmov+Q.FieldByName('move_qtde').AsFloat;
            tsemmov:=tsemmov+Q.FieldByName('move_qtde').AsFloat;
            contagem:='S';
            saldo:=Q.FieldByName('move_estoque').AsFloat;
          end else begin
            psemmov:=psemmov+Q.FieldByName('move_qtde').AsFloat;
            tsemmov:=tsemmov+Q.FieldByName('move_qtde').AsFloat;
          end;

          Q.Next;
        end;

//        FTExtRel.AddLinha(space(12)+'Totais'+space(7)+FGeral.Formatavalor(pentradas,f_qtdestoque)+space(03)+
//                          FGeral.Formatavalor(psaidas,f_qtdestoque)+space(5)+
//                          FGeral.Formatavalor(psemmov,f_qtdestoque),false,false,true  );
        Atualiza(produto,unidade,'M',saldo,saldo,contagem);

      end;
// 13.04.05 - total geral
//      FTExtRel.AddLinha(space(12)+'Totais'+space(7)+FGeral.Formatavalor(tentradas,f_qtdestoque)+space(03)+
//                          FGeral.Formatavalor(tsaidas,f_qtdestoque)+space(5)+
//                          FGeral.Formatavalor(tsemmov,f_qtdestoque),false,false,true  );

    Sistema.BeginProcess('Gerando relat�rio');
    FRel.Init('AuditoriaSaldoEstoque');
    FRel.AddTit('Auditoria de Saldos de Estoque');
    FRel.AddTit('Unidade : '+Unidade+' - '+FUnidades.Getnome(Unidade) );
    FRel.AddTit('Periodo : '+copy(FRelAuditorias.EdMesanoi.text,1,2)+'/'+copy(FRelAuditorias.EdMesanoi.text,3,4) );
    FRel.AddCol(080,3,'N','' ,'','Codigo'  ,'','',false);
    FRel.AddCol(200,1,'C','' ,'','Descri��o'  ,'','',false);
    FRel.AddCol(090,3,'N','+',f_qtdestoque,'Saldo Movimento'  ,'','',false);
    FRel.AddCol(090,3,'N','+',f_qtdestoque,'Saldo Invent�rio'  ,'','',false);
    FRel.AddCol(100,3,'N','+',f_cr,'Dif. Custo M.Gerencial'  ,'','',false);
    for x:=0 to LIsta.count-1 do begin
      PREgistro:=Lista[x];
      if (PRegistro.saldomovprevant+PRegistro.saldomovprev)<>PRegistro.saldoinvprev then begin
        FRel.AddCel(PRegistro.Codigo);
        FRel.AddCel(FEstoque.getdescricao(PRegistro.Codigo));
        FRel.AddCel(floattostr(PRegistro.saldomovprevant+PRegistro.saldomovprev));
        FRel.AddCel(floattostr(PRegistro.saldoinvprev));
        FRel.AddCel(floattostr(PRegistro.customeger*((PRegistro.saldomovprevant+PRegistro.saldomovprev)-PRegistro.saldoinvprev)));
      end;
    end;
    FRel.Setsort('Dif. Custo M.Gerencial');
    FRel.Video;
    Sistema.EndProcess('');
    Sistema.beginprocess('Fechando tabelas');
    Lista.free;
    Q.close;
    Freeandnil(Q);
    FGEral.Fechaquery(QINventa);
    Sistema.endprocess('');
  end;

/////////////////////////////////////
  FRelAuditorias_ChecaSaldo;   // 4
end;


procedure FRelAuditorias_ChecaNotasFinan;   // 5
var statusvalidos,titulo,periodo,sqlorder,sqlrecpag,valor,sqlcodtipo,sqltipocad,tipomov,tipomovdev,oscodigos,titvencidos,
    rel,sqldatalan,Unidadenota:string;
    Q:TSqlquery;
    valorx,vlrantecipa,valornota:currency;
    ListaCodigos:TStringlist;

    procedure ChecaBaixaParcial(unidade,tipocod,tipocad,numerodoc:string;Data,Datacont,Vencimento:TDatetime;parcela:integer;saldo:currency;statuspen:string);
    var Qbx:TSqlquery;
        status,sqlqtipo:string;
        saldox:currency;
    begin
      if Rel='PEN' then
        status:=stringtosql('P')
      else
        status:=stringtosql('N');
      if Datacont>1 then
        sqlqtipo:=' and pend_datacont>1'
      else
        sqlqtipo:=' and pend_datacont is null';
      QBx:=sqltoquery('select * from pendencias where pend_status='+status+' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
                      ' and pend_parcela='+inttostr(parcela)+
                      ' and pend_unid_codigo='+stringtosql(unidade)+
//                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
      if QBx.eof then begin
         QBx.close;
         Freeandnil(QBx);
         QBx:=sqltoquery('select * from pendencias where pend_status='+status+' and pend_tipo_codigo='+stringtosql(Tipocod)+
                      ' and pend_tipocad='+stringtosql(tipocad)+
                      ' and pend_databaixa>='+Datetosql(Data)+
//                      ' and pend_parcela='+inttostr(parcela)+
                      ' and pend_unid_codigo='+stringtosql(unidade)+
                      ' and pend_datavcto='+Datetosql(Vencimento)+
                      sqlqtipo+
                      ' and pend_numerodcto='+stringtosql(numerodoc) );
     end;
      saldox:=saldo;
      while not Qbx.eof do begin
          FRel.AddCel(QBx.FieldByName('pend_transacao').AsString);
//          FRel.AddCel(QBx.FieldByName('pend_operacao').AsString);
          FRel.AddCel(QBx.FieldByName('pend_unid_codigo').AsString);
//          FRel.AddCel(QBx.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel(QBx.FieldByName('pend_datacont').AsString);
          FRel.AddCel(QBx.FieldByName('pend_numerodcto').AsString);
          FRel.AddCel('');  // tipo de movimento - 08.09.05
          FRel.AddCel(FCondpagto.GetReduzido(QBx.FieldByName('pend_fpgt_codigo').AsString));
//          FRel.AddCel(FPortadores.GetDescricao(QBx.FieldByName('pend_port_codigo').AsString));
          FRel.AddCel(QBx.FieldByName('pend_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeTipoCad(QBx.FieldByName('pend_tipo_codigo').AsInteger,QBx.FieldByName('pend_tipocad').AsString));
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QBx.FieldByName('pend_tipo_codigo').AsInteger,QBx.FieldByName('pend_tipocad').AsString,'N'));
// 08.06.07 - elize - novicarnes
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QBx.FieldByName('pend_tipo_codigo').AsInteger,QBx.FieldByName('pend_tipocad').AsString,'R'));
//          FRel.AddCel(QBx.FieldByName('pend_repr_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeTipoCad(QBx.FieldByName('pend_repr_codigo').AsInteger,'R'));
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(QBx.FieldByName('pend_repr_codigo').AsInteger,'R','N'));
          FRel.AddCel(QBx.FieldByName('pend_datavcto').AsString);
          FRel.AddCel(QBx.FieldByName('pend_databaixa').AsString);
          FRel.AddCel(QBx.FieldByName('pend_transbaixa').AsString);
// 03.08.06
//          FRel.AddCel(QBx.FieldByName('pend_observacao').AsString);

          FRel.AddCel(QBx.FieldByName('pend_nparcelas').AsString);
          FRel.AddCel(QBx.FieldByName('pend_parcela').AsString);
          FRel.AddCel(QBx.FieldByName('pend_status').AsString);
          FRel.AddCel(Q.FieldByName('pend_rp').AsString);
          FRel.AddCel('');  // unidade nota
          FRel.AddCel('');  // valor nota
          if statuspen<>'B' then
            FRel.AddCel(formatfloat(f_cr,(-1)*texttovalor(Qbx.FieldByName('pend_valor').Asstring)))
          else
            FRel.AddCel(formatfloat(f_cr,texttovalor(Qbx.FieldByName('pend_valor').Asstring)));
//          FRel.AddCel('');
          saldox:=saldox-QBx.FieldByName('pend_valor').AsCurrency;
          FRel.AddCel(formatfloat(f_cr,saldox));
          Qbx.next;
      end;
      Qbx.close;
      Freeandnil(Qbx);
    end;


    function Gettipomov(transacao:String):string;
    var Q:TSqlquery;
    begin
      Q:=sqltoquery('select moes_tipomov from movesto where moes_transacao='+stringtosql(transacao));
      result:='';
      if not Q.eof then begin
        result:=Q.fieldbyname('moes_tipomov').asstring;
        if result=Global.CodDevolucaoConsig then   //  09.09.05 - gambia para reges -
          result:=Global.CodVendaConsig;
      end else
        result:=Global.CodPendenciaFinanceira;
      Q.close;
      Freeandnil(Q);
    end;

    function EstaValendo(vencimento:TDatetime ):boolean;
    begin
       result:=true;
    end;

    procedure GetValorNota(tra:string;parc:integer;var valornota:currency ; var unidadenota:string;codigo,numero:integer;tipocad:string);
    var QN:TSqlquery;
    begin
      if parc=1 then begin
//        Qn:=sqltoquery('select moes_vlrtotal,moes_valortotal,moes_datacont,moes_unid_codigo from movesto where moes_transacao='+stringtosql(tra));
        Qn:=sqltoquery('select moes_vlrtotal,moes_valortotal,moes_datacont,moes_unid_codigo from movesto'+
                       ' where moes_tipo_codigo='+inttostr(codigo)+' and moes_tipocad='+stringtosql(tipocad)+
                       ' and moes_numerodoc='+inttostr(numero) );
        if not QN.eof then begin
          if QN.fieldbyname('moes_datacont').asdatetime>1 then
            valornota:=QN.fieldbyname('moes_vlrtotal').ascurrency
          else
            valornota:=QN.fieldbyname('moes_valortotal').ascurrency;
          unidadenota:=QN.fieldbyname('moes_unid_codigo').asstring;
        end else begin
          valornota:=0;
          unidadenota:='';
        end;
        FGeral.fechaquery(QN);
      end else begin
        valornota:=0;
        unidadenota:='';
      end;
    end;

begin

  with FRelAuditorias do begin
    if not FRelAuditorias_Execute(5) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    sqlrecpag:='';
    titulo:='Checagem de Notas Fiscais com Valores no Financeiro';
    titvencidos:='';
    rel:= 'PEN';
    if Rel='INC' then begin
      statusvalidos:='N;A;D;B';
      titulo:=titulo+'Inclu�das';
      sqlorder:=' order by pend_unid_codigo,pend_tipo_codigo,pend_dataemissao';
    end else if Rel='PEN' then begin
      statusvalidos:='N;A;B;K';
//      titulo:=titulo+'Pendentes';
      sqlorder:=' order by pend_unid_codigo,pend_tipo_codigo,pend_dataemissao,pend_numerodcto,pend_datavcto';
    end else begin
      statusvalidos:='B;P;E';
      titulo:=titulo+'Baixadas';
      sqlorder:=' order by pend_unid_codigo,pend_tipo_codigo,pend_databaixa';
    end;
    sqlunidade:=' and '+FGeral.getin('pend_unid_codigo',EdUnid_codigo.text,'C');
    periodo:='Periodo : ';
    if EdDatai.AsDate>1 then begin
      sqldatalan:=' and pend_datamvto>='+EdDatai.AsSql+' and pend_datamvto<='+EdDataf.AsSql;
      periodo:=periodo+' Movimento : '+FGeral.FormataData(Eddatai.AsDate)+' a '+FGeral.FormataData(EdDataf.AsDate);
    end else
      sqldatalan:='';
    sqlcodtipo:='';
    sqltipocad:='';
    Q:=sqltoquery('select * from pendencias'+
                  ' where '+FGeral.Getin('pend_status',statusvalidos,'C')+
                  sqlrecpag+
                  ' and '+FGeral.GetNOTIN('pend_tipomov',Global.CodPendenciaFinanceira,'C')+
                  sqlunidade+
                  sqldatalan+
                  sqldatacont+
                  sqlcodtipo+
                  sqltipocad+
                  sqlorder );

    ListaCodigos:=TStringlist.create;
    oscodigos:='';
    if Q.Eof then
      Avisoerro('Nada encontrado para impress�o')
    else begin
      if Rel='INC' then
        FRel.Init('RelIncluidas')
      else if Rel='PEN' then begin
        FRel.Init('RelNotasFinan');
// 06.06.07
      end else
        FRel.Init('RelBaixadas');
      FRel.AddTit(titulo);
      FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
      FRel.AddTit(Periodo);
      FRel.AddCol( 70,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
//      FRel.AddCol( 80,0,'C','' ,''              ,'OPeracao'       ,''         ,'',false);
      FRel.AddCol( 35,2,'C','' ,''              ,'Uni.'           ,''         ,'',false);
//      FRel.AddCol( 65,1,'D','' ,''              ,'Lan�amento'      ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Emiss�o'         ,''         ,'',false);
      if Global.Usuario.OutrosAcessos[0701] then
         FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'       ,''         ,'',false);
      FRel.AddCol( 70,2,'N','' ,''              ,'Numero Doc'      ,''         ,'',False);
// 08.09.05
      FRel.AddCol(100,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);

      FRel.AddCol( 80,0,'C','' ,''              ,'Forma Pagto'     ,''         ,'',false);
  //    FRel.AddCol( 90,0,'C','' ,''              ,'Portador'        ,''         ,'',false);
      FRel.AddCol( 45,0,'C','' ,''              ,'Entidade'        ,''         ,'',false);
      FRel.AddCol(150,0,'C','' ,''              ,'Nome'            ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Vencimento'      ,''         ,'',false);
      FRel.AddCol( 60,1,'D','' ,''              ,'Baixa'           ,''         ,'',false);
      FRel.AddCol( 70,1,'C','' ,''              ,'Transa��o Baixa' ,''         ,'',false);
      FRel.AddCol( 30,2,'N','' ,''              ,'NP'              ,''         ,'',False);
      FRel.AddCol( 30,2,'N','' ,''              ,'Parc'            ,''         ,'',False);
      FRel.AddCol( 50,2,'C','' ,''              ,'Ant./Bx Parc.'   ,''         ,'',False);
      FRel.AddCol( 50,2,'C','' ,''              ,'Rec./Pag.'       ,''         ,'',False);
      FRel.AddCol( 60,1,'N','+' ,''             ,'Unid Nota'     ,''         ,'',False);
      FRel.AddCol( 70,3,'N','+' ,f_cr            ,'Valor Nota'     ,''         ,'',False);
      FRel.AddCol( 70,3,'N','+' ,f_cr            ,'Valor Parcela'   ,''         ,'',False);
      FRel.AddCol( 70,3,'N','-' ,f_cr            ,'Saldo Duplicata' ,''         ,'',False);

      while not Q.eof do begin
        if EstaValendo(Q.FieldByName('pend_datavcto').AsDatetime) then begin
          FRel.AddCel(Q.FieldByName('pend_transacao').AsString);
//          FRel.AddCel(Q.FieldByName('pend_operacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_unid_codigo').AsString);
//          FRel.AddCel(Q.FieldByName('pend_datalcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_dataemissao').AsString);
          if Global.Usuario.OutrosAcessos[0701] then
            FRel.AddCel(Q.FieldByName('pend_datacont').AsString);
          FRel.AddCel(Q.FieldByName('pend_numerodcto').AsString);
//          FRel.AddCel(Q.FieldByName('pend_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('pend_tipomov').AsString));
// 08.09.05
          tipomov:=Gettipomov(Q.FieldByName('pend_transacao').AsString);
          FRel.AddCel(Tipomov+'-'+FGeral.GetTipoMovto(Tipomov));
          FRel.AddCel(FCondpagto.GetReduzido(Q.FieldByName('pend_fpgt_codigo').AsString));
//          FRel.AddCel(FPortadores.GetDescricao(Q.FieldByName('pend_port_codigo').AsString));
          FRel.AddCel(Q.FieldByName('pend_tipo_codigo').AsString);
//          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'N'));
// 08.06.07 - elize - novicarnes
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.FieldByName('pend_tipo_codigo').AsInteger,Q.FieldByName('pend_tipocad').AsString,'R'));
          FRel.AddCel(Q.FieldByName('pend_datavcto').AsString);
          FRel.AddCel(Q.FieldByName('pend_databaixa').AsString);
          FRel.AddCel(Q.FieldByName('pend_transbaixa').AsString);
// 03.08.06
//          FRel.AddCel(Q.FieldByName('pend_observacao').AsString);
          FRel.AddCel(Q.FieldByName('pend_nparcelas').AsString);
          FRel.AddCel(Q.FieldByName('pend_parcela').AsString);
          FRel.AddCel(Q.FieldByName('pend_status').AsString);
          FRel.AddCel(Q.FieldByName('pend_rp').AsString);
//          valornota:=GetValorNota(Q.fieldbyname('pend_transacao').asstring,Q.fieldbyname('pend_parcela').asinteger);
// 24.09.07
          GetValorNota(Q.fieldbyname('pend_transacao').asstring,Q.fieldbyname('pend_parcela').asinteger,valornota,unidadenota,
                       Q.fieldbyname('pend_tipo_codigo').asinteger,strtointdef(Q.fieldbyname('pend_numerodcto').asstring,0),Q.fieldbyname('pend_tipocad').asstring);
          FRel.AddCel(unidadenota);
          FRel.AddCel(floattostr(valornota));
          vlrantecipa:=0;
          valor:=Q.FieldByName('pend_valor').Asstring;
          valorx:=0;
          if (pos(Q.FieldByName('pend_status').AsString,'P')>0) and (Rel='PEN') then begin
            FRel.AddCel(formatfloat(f_cr,(-1)*texttovalor(valor)));
            valorx:=(-1)*texttovalor(valor);
          end else if (pos(Q.FieldByName('pend_status').AsString,'D')>0) and (Rel='PEN') then begin
            FRel.AddCel('');
          end else if (pos(Q.FieldByName('pend_status').AsString,'E')>0) and (Rel='BAI') then begin
            FRel.AddCel('');
            vlrantecipa:=texttovalor(valor);
          end else if (pos(Q.FieldByName('pend_status').AsString,'A;E')>0) then begin
            FRel.AddCel('');
          end else begin
            FRel.AddCel(valor);
            valorx:=texttovalor(valor);
          end;
          if Q.FieldByName('pend_status').AsString='N' then begin
            if valornota>0 then
              FRel.AddCel(floattostr(valorx))   // saldo duplicata
            else
              FRel.AddCel(floattostr(valorx));   // saldo duplicata
          end else if pos(Q.FieldByName('pend_status').AsString,'K')>0 then begin
//            if valornota>0 then
//              FRel.AddCel(floattostr(valornota-valorx))   // saldo duplicata
//            else
              FRel.AddCel(floattostr(0));   // saldo duplicata
          end else if pos(Q.FieldByName('pend_status').AsString,'B')>0 then begin
            if valornota>0 then
              FRel.AddCel(floattostr(valornota-valorx))   // saldo duplicata
            else
              FRel.AddCel(floattostr(0));   // saldo duplicata
          end else
            FRel.AddCel('');   // saldo duplicata

//          FRel.AddCel(floattostr(vlrantecipa));
          if (Rel='PEN') and (pos(Q.FieldByName('pend_status').AsString,'N;K;B')>0) then
            ChecaBaixaParcial(Q.FieldByName('pend_unid_codigo').AsString,Q.FieldByName('pend_tipo_codigo').AsString,Q.FieldByName('pend_tipocad').AsString,Q.FieldByName('pend_numerodcto').AsString,Q.FieldByName('pend_dataemissao').Asdatetime,
               Q.FieldByName('pend_datacont').Asdatetime,Q.FieldByName('pend_datavcto').Asdatetime,Q.FieldByName('pend_parcela').Asinteger,valorx,Q.FieldByName('pend_status').Asstring);
          if ListaCodigos.indexof(Q.FieldByName('pend_tipo_codigo').AsString)=-1 then begin
            ListaCodigos.add(Q.FieldByName('pend_tipo_codigo').AsString);
            oscodigos:=oscodigos+Q.FieldByName('pend_tipo_codigo').AsString+';';
          end;

        end;  // esta valendo
        Q.Next;
      end;
    end;
    FRel.Video;
    Sistema.EndProcess('');
    Q.Close;
    Freeandnil(Q);
    FRelAuditorias_ChecaNotasFinan;

  end;
end;

procedure FRelAuditorias_ChecaPiscofins;   // 6
/////////////////////////////////////////////////////
var sqlunidade,sqltipomovto,sqldatacont,cstpis,tiposnao,sqlcfopssim,CfopsIsentosEntradas,CfopsIsentosSaidas,
    cstpisNAOEXPORTA,CfopsAquisicaoBensparaRevenda,CfopsAquisicaoBensparaInsumo,CfopsAquisicaoServicosparaInsumo,
    CfopsDevolucaoVendaNaoCumulativa,ModelosRegistroC170,
    CfopsOutrasEntradascomCredito,
    NumSerieCertificado,ModelosRegistroC100:string;
    valoritem,baseitem,valorpis,xalipis,xalicofins,
    valorcofins:currency;
    ListaDespesasCST53   :TStringList;
    ok                   :boolean;
    QContab              :TSqlquery;


    //////////////////////////////////////////
    function GetModelo(tipomov:string):string;
    //////////////////////////////////////////
//modelo de documento fiscal     01 - nf modelo 1 ou 1A     02 - nf venda consumidor modelo 2
//                               04 - nf produtor   e MAIS UM MONTE...
    begin
      result:='01';
      if ( ( Q.fieldbyname('moes_dtnfecanc').AsDateTime>1 ) or
         ( Q.fieldbyname('moes_dtnfeauto').AsDateTime>1 ) ) and
         (  NumSerieCertificado<>'' )
         then
         result:='55'
      else if (Q.fieldbyname('moes_xmlnfet').AsString<>'' ) and
              (Q.fieldbyname('moes_chavenfe').AsString<>'' ) then begin
         result:='55';
         if pos(tipomov,Global.CodConhecimento+';'+Global.CodConhecimentoSaida)>0 then result:='57';

      end else if pos(tipomov,Global.CodConhecimento+';'+Global.CodConhecimentoSaida)>0 then begin
        result:='08';
        if uppercase(Q.fieldbyname('moes_especie').AsString)='CTE' then
          result:='57';
      end else if pos(tipomov,Global.CodPrestacaoServicos)>0 then begin
        result:='PS';
      end else if pos(tipomov,Global.CodPrestacaoServicosE)>0 then begin
        result:='PA';
      end else if pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,2,3),'251;252;253') > 0 then
        result:='06'    // contas de energia eletrica
      else if pos( copy(Q.fieldbyname('moes_natf_codigo').asstring,2,3),'302;303') > 0 then
        result:='22'    // contas de telefone
      else  if (  copy(Q.FieldByName('moes_serie').asstring,1,1)='D' ) and ( pos(copy(Q.FieldByName('moes_natf_codigo').asstring,1,1),'567')>0 ) then
           Result:='02'
      else  if Pos( Q.fieldbyname('moes_tipomov').AsString,Global.CodCompraProdutor+';'+Global.CodEntradaProdutor )>0 then
          result:='04'
      else  if (uppercase(copy(Q.fieldbyname('moes_especie').AsString,1,2))='NF') and (copy(Q.FieldByName('moes_serie').asstring,1,1)='1') then
          result:='01';

    end;



begin

  with FRelAuditorias do begin

    if not FRelAuditorias_Execute(6) then Exit;

    NumSerieCertificado:=trim( FGeral.GetConfig1AsString('NumSerieCert') );
    Sistema.beginprocess('Pesquisando movimento de compras e vendas no per�odo');
    ModelosRegistroC100:='01;1B;04;55';
    ModelosRegistroC170:=ModelosRegistroC100;
    CfopsIsentosEntradas:=FGeral.GetConfig1AsString('Cfopspiscofinse');
    CfopsIsentosSaidas:=FGeral.GetConfig1AsString('Cfopspiscofinss');

//    cstpisNAOEXPORTA:='70;71;72;73;74;75;76;77;78;79;80;81;82;83;84;85;86;87;88;90;98;99';
//    cstpisNAOEXPORTA:='70;71;72;73;74;75;76;77;78;79;80;81;82;83;84;85;86;87;88;90;98';

// 31.10.18    - Novicarnes - Ketlen
    cstpisNAOEXPORTA:='';

    CfopsAquisicaoBensparaRevenda:='1102;1113;1117;1118;1121;1251;1403;1652;2102;2113;2117;'+
                                   '2118;2121;2251;2403;2652;3102;3251;3652';
    CfopsAquisicaoBensparaInsumo:='1101;1111;1116;1120;1122;1126;1128;1401;1407;1556;1651;'+
                                  '1653;2101;2111;2116;2120;2122;2126;2128;2401;2407;2556;'+
                                  '2651;2653;3101;3126;3128;3556;3651;3653';
    CfopsAquisicaoServicosparaInsumo:='1124;1125;1933;2124;2125;2933';
    CfopsDevolucaoVendaNaoCumulativa:='1201;1202;1203;1204;1410;1411;1660;1661;1662;2201;'+
                                      '2202;2410;2411;2660;2661;2662';
    CfopsOutrasEntradascomCredito:='1922;2922';

    if trim(EdUnid_codigo.text)<>'' then begin
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C');
    end else begin
      sqlunidade:='';
    end;
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C');
    end else begin
      sqltipomovto:='';
    end;
    sqldatacont:=' and  moes_datacont > '+Datetosql(Global.DataMenorBanco);
    sqlcfopssim:='';
    if trim( FGeral.GetConfig1Asstring('Cfopspiscofinsgera') )<>'' then
      sqlcfopssim:=' and '+FGeral.GetNOTIN('moes_natf_codigo',FGeral.GetConfig1Asstring('Cfopspiscofinsgera'),'C');


    tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+Global.CodContrato;

    Q:=sqltoquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                  ' inner join natureza on (natf_codigo=moes_natf_codigo)'+
                  ' inner join estoque on (esto_codigo=move_esto_codigo)'+
                  ' where '+FGeral.GetNOTIN('move_status','C','C')+' and move_datamvto>='+EdDatai.assql+
                    sqlunidade+sqltipomovto+sqldatacont+sqlcfopssim+
                  ' and '+FGeral.GetNOTIN('moes_tipomov',Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai,'C')+
                  ' and '+FGeral.GetNOTIN('move_tipomov',Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai,'C')+
                  ' and '+FGeral.GetNOTIN('moes_especie','CF;CF ;','C')+
                  ' and '+FGeral.GetNOTIN('moes_tipomov',tiposnao,'C')+
                  ' and moes_natf_codigo is not null'+
                  ' and moes_status not in (''X'',''Y'',''I'')'+
                  ' and move_datamvto<='+EdDAtaf.assql+' order by move_unid_codigo');


    if Q.eof then begin
      Sistema.EndProcess('Nada encontrado para impress�o');
      Q.close;
      Freeandnil(Q);
      exit;
    end;

// 04.12.18
  ListaDespesasCST53:=TStringList.Create;
  ok:=true;

  if FileExists( 'ListaDespesasCST53.txt' ) then begin
     try
        ListaDespesasCST53.LoadFromFile( 'ListaDespesasCST53.txt' );
     except
        Avisoerro('N�o foi poss�vel ler o arquivo ListaDespesasCST53.txt');
        exit;
     end;
  end;
  campo:=Sistema.GetDicionario('plano','plan_cstpiscofins');

    FRel.Init('RelConferenciaPisCofins');
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
    FRel.AddTit('Relat�rio de Confer�ncia de CST de Pis e Cofins');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
    FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
    FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    FRel.AddCol( 90,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'    ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Emiss�o'    ,''         ,'',false);
    FRel.AddCol( 70,3,'N','' ,''              ,'Numero Doc.'     ,''         ,'',False);
    FRel.AddCol( 60,1,'C','' ,''              ,'CFOP Ent.'           ,''         ,'',false);
    FRel.AddCol( 60,1,'C','' ,''              ,'CST'           ,''         ,'',false);
    FRel.AddCol( 90,1,'C','' ,''              ,'NCM'           ,''         ,'',false);
    FRel.AddCol(150,1,'C','' ,''              ,'Descri��o NCM'           ,''         ,'',false);
    FRel.AddCol( 90,3,'N','+' ,f_cr            ,'Valor do Item'           ,''         ,'',False);
    FRel.AddCol( 90,3,'N','' ,f_cr            ,'Base de C�lculo Pis'           ,''         ,'',False);
    FRel.AddCol( 90,3,'N','' ,f_cr            ,'Base de C�lculo Cofins'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+' ,f_cr            ,'Valor Pis '           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+' ,f_cr            ,'Valor Cofins '           ,''         ,'',False);
    FRel.AddCol(120,0,'C','' ,''              ,'Tipo Movimento'  ,''         ,'',False);
    if Global.Topicos[1055] then begin
       FRel.AddCol(080,0,'C','' ,''              ,'D�bito'  ,''         ,'',False);
       FRel.AddCol(080,0,'C','' ,''              ,'Cr�dito'  ,''         ,'',False);
    end;

    while not Q.eof do begin

        CSTPis:='';


//        if Q.fieldbyname('move_numerodoc').asinteger=135870 then aviso(Q.fieldbyname('move_tipomov').asstring+' '+Q.fieldbyname('move_esto_codigo').asstring+
//                      ' '+Q.fieldbyname('move_transacao').asstring );



        if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin



              CSTPIS:=FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) )  ;
// 04.12.18
// 19.10.18 - Novicarnes - Ketlen
              if Q.FieldByName('moes_plan_codigo').AsInteger  >0 then begin

                   if LIstaDespesasCST53.IndexOf( IntToStr( Q.FieldByName('moes_plan_codigo').AsInteger ) ) >=0  then begin

//                     CSTPIS:=StrtoCSTPis( ok, '53' );
                     CSTPIS:= '53';

                   end else begin

// 03.06.19 - Novicarnes - Ketlen - diferencia��o cfe a conta de despesa
                           if campo.Tipo<>'' then begin
                              cstpis:=FPlano.GetCSTPisCofins( Q.FieldByName('moes_plan_codigo').AsInteger);
                              if trim(cstpis)='' then begin
                                 CSTPIS:=FCodigosipi.GetCstPis( FEstoque.GetcodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring ) )  ;
                              end;
                           end;

                   end;

              end;


//              if ( Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , ModelosRegistroC170 )  > 0 )
//                   and ( trim(CSTPis)='' ) then
//                   CSTPis:='97';

              if ( Pos( Q.fieldbyname('moes_tipomov').asstring,Global.CodPrestacaoServicos+';'+Global.CodPrestacaoServicosE )  > 0 )
                 or ( Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , '06' )  >0 )
                 or ( Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , '22' )  >0 )
              then begin
                   if ( pos( Q.fieldbyname('moes_tipomov').asstring,Global.CodCompraProdutor+';'+Global.CodDrawBackSai+';'+
                            Global.CodTransfSai+';'+Global.CodPrestacaoServicos+';'+Global.CodPrestacaoServicosE ) = 0 ) then
                     if trim(cstpis)=''  then CSTPis:='96';

              end;

//              end else if( Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , ModelosRegistroC100 )  > 0 ) and
//                   ( trim(cstpis)='' ) then CSTPis:='99';

              if pos( Q.fieldbyname('moes_natf_codigo').asstring,CfopsIsentosEntradas ) >0 then begin
                  baseitem:=0;
                  CSTPIS:='74' ;
              end else  if ( pos( Q.fieldbyname('moes_natf_codigo').asstring,CfopsAquisicaoBensparaRevenda+';'+CfopsAquisicaoBensparaInsumo+';'+
                      CfopsAquisicaoServicosparaInsumo+';'+CfopsDevolucaoVendaNaoCumulativa+';'+
                      CfopsOutrasEntradascomCredito ) = 0 ) and ( trim(cstpis)='' ) then
                  cstpis:='70';




        end else begin

               CSTPIS:=FEstoque.GetsituacaotributariaPIS(Q.fieldbyname('move_esto_codigo').asstring,Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  ;
                if pos( Q.fieldbyname('moes_natf_codigo').asstring,CfopsIsentosSaidas ) >0 then begin
                  baseitem:=0;
                  CSTPIS:='08' ;
                end

        end;

         if ( Q.fieldbyname('move_tipomov').asstring=Global.CodTransfSai ) then

                 CSTPIS:='08'

         else if ( Q.fieldbyname('moes_tipomov').asstring=Global.CodConhecimento ) then

                 CSTPIS:='53'


         else if ( Q.fieldbyname('move_tipomov').asstring=Global.CodCompraProdutor ) then begin

                 CSTPIS:='73';
//               alipis:=0;
//               alicofins:=0;

//         end else if ( Pos( GetModelo(Q.fieldbyname('moes_tipomov').asstring) , ModelosRegistroC170 )  = 0 )
//                    and ( trim(CSTPis)='' ) then begin
//
//             CSTPis:='97';

         end;


 // 03.01.18 -
 {
        if ( Pos(Q.fieldbyname('moes_natf_codigo').asstring,CfopsConhecimentoSaida)=0 )
           and ( pos(copy(Q.fieldbyname('moes_natf_codigo').asstring,1,1),'1,2,3')>0 ) then begin
          if pos( Q.fieldbyname('moes_natf_codigo').asstring,CfopsAquisicaoBensparaRevenda+';'+CfopsAquisicaoBensparaInsumo+';'+
                CfopsAquisicaoServicosparaInsumo+';'+CfopsDevolucaoVendaNaoCumulativa+';'+
                CfopsOutrasEntradascomCredito ) = 0 then
            cstpis:='70';

        end;
}

      if Ansipos( cstpis,cstpisNAOEXPORTA )= 0 then begin

        FRel.AddCel(Q.FieldByName('move_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('move_transacao').AsString);
        FRel.AddCel(Q.FieldByName('move_datamvto').AsString);
        FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
        FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
        FRel.AddCel(Q.FieldByName('move_natf_codigo').AsString);
        valoritem:=Q.fieldbyname('move_venda').ascurrency*Q.fieldbyname('move_qtde').ascurrency;
        valoritem:=valoritem - ( valoritem*(Q.FieldByName('moes_perdesco').AsCurrency/100)  );
        baseitem:=valoritem;
        if Q.fieldbyname('move_redubase').ascurrency>0 then
          baseitem:=valoritem*(Q.fieldbyname('move_redubase').ascurrency/100);

        if FSpedPisCofins.TributaPIS( FSpedPisCofins.GetCSTPIS( CSTPIS ) ) then begin

           if pos(Q.FieldByName('move_tipomov').AsString,Global.TiposEntrada)>0  then  begin
              xalipis:=FCodigosIPI.GetPerPis( FEstoque.GetcodigoIPINCM(Q.FieldByName('move_esto_codigo').AsString) );
//   02.08.19 - Novicarnes - Ketlen
               if CSTPIS  = '53' then xalipis:=1.65

           end else
              xalipis:=FCodigosFiscais.GetAliquotaPis( FEstoque.GetCodigoFiscal(Q.FieldByName('move_esto_codigo').AsString,
                          Q.FieldByName('move_unid_codigo').AsString,Global.UFUnidade)  )

        end else begin

            xalipis:=0;
            baseitem:=0;  // 21.08.19 - Novicarnes - Ketlen

        end;


        valorpis:=roundvalor(valoritem*(xalipis/100));

        if FSpedPisCofins.TributaCofins( FSpedPisCofins.GetCSTCofins( CSTPIS ) ) then begin

             if pos(Q.fieldbyname('moes_tipomov').asstring,Global.TiposEntrada)>0 then begin
               xalicofins:=FCodigosipi.GetPerCofins( FEstoque.GetCodigoIPINCM(Q.fieldbyname('move_esto_codigo').asstring) );
//   02.08.19 - Novicarnes - Ketlen
               if CSTPIS  = '53' then xalicofins:=7.60;
             end else
               xalicofins:=FCodigosFiscais.GetAliquotaCofins( FEstoque.GetCodigoFiscal(Q.fieldbyname('move_esto_codigo').asstring,
                           Q.fieldbyname('move_unid_codigo').asstring,Q.fieldbyname('moes_estado').asstring)  )    ;

        end else begin

            xalicofins:=0;

        end;
        valorcofins:=roundvalor(valoritem*(xalicofins/100));

        FRel.AddCel( CSTpis );
        FRel.AddCel( FEstoque.GetNCMipi(Q.fieldbyname('move_esto_codigo').asstring ) );
        FRel.AddCel( FCodigosipi.GetDescricao(Q.fieldbyname('esto_cipi_codigo').asinteger ) );
//        FRel.AddCel(Q.fieldbyname('moes_tipo_codigo').asstring);
//        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('moes_tipo_codigo').asinteger,Q.FieldByName('moes_tipocad').AsString,'N'));
        FRel.AddCel( floattostr( valoritem ) );
        FRel.AddCel( floattostr( baseitem ) );
        FRel.AddCel( floattostr( baseitem ) );

        FRel.AddCel( floattostr( valorpis ) );
        FRel.AddCel( floattostr( valorcofins ) );
        FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));
        if Global.Topicos[1055] then begin

           QContab:=sqltoquery('select moct_debito,moct_credito from movcontab where moct_transacao = '+
                    Stringtosql(Q.FieldByName('moes_transacao').AsString)+
                    ' and moct_datamvto = '+Datetosql(Q.FieldByName('moes_datamvto').AsDatetime)+
                    ' and moct_tipo = '+stringtosql('NOTAS') );
           FRel.AddCel( QContab.FieldByName('moct_debito').AsString );
           FRel.AddCel( QContab.FieldByName('moct_credito').AsString );
           FGeral.FechaQuery(QContab);
        end;

      end;

      Q.Next;

    end;

    FGeral.FechaQuery(Q);

// 04.01.2018 - conhecimentos de entrada em que nao s�o digitados itens
///////////////////////////////////////////////////////////////////////
    if trim(EdUnid_codigo.text)<>'' then begin
      sqlunidade:=' and '+FGeral.getin('moes_unid_codigo',EdUnid_codigo.text,'C');
    end else begin
      sqlunidade:='';
    end;
    sqltipomovto:=' and '+FGeral.getin('moes_tipomov',global.CodConhecimento,'C');
    sqldatacont:=' and  moes_datacont > '+Datetosql(Global.DataMenorBanco);
    Q:=sqltoquery('select * from movesto '+
                  ' inner join natureza on (natf_codigo=moes_natf_codigo)'+
                  ' where '+FGeral.GetNOTIN('moes_status','C','C')+' and moes_datamvto>='+EdDatai.assql+
                    sqlunidade+sqltipomovto+
                  ' and moes_natf_codigo is not null'+
                  ' and moes_status not in (''X'',''Y'',''I'')'+
                  ' and moes_datamvto<='+EdDAtaf.assql+' order by moes_unid_codigo');
    CSTPis:='53';

    while not Q.eof do begin

        FRel.AddCel(Q.FieldByName('moes_unid_codigo').AsString);
        FRel.AddCel(Q.FieldByName('moes_transacao').AsString);
        FRel.AddCel(Q.FieldByName('moes_datamvto').AsString);
        FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
        FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
        FRel.AddCel(Q.FieldByName('moes_natf_codigo').AsString);
        valoritem:=Q.fieldbyname('moes_vlrtotal').ascurrency;
        valoritem:=valoritem - ( valoritem*(Q.FieldByName('moes_perdesco').AsCurrency/100)  );
        baseitem:=valoritem;

        if FSpedPisCofins.TributaPIS( FSpedPisCofins.GetCSTPIS( CSTPIS ) ) then begin
            xalipis:=FCodigosFiscais.GetAliquotaPis( '1'  );
        end else begin

            xalipis:=0;
            if trim(cstpis)='' then cstpis:='99';

        end;

        if FSpedPisCofins.TributaCofins( FSpedPisCofins.GetCSTCOFINS( CSTPIS ) ) then begin
            xalicofins:=FCodigosFiscais.GetAliquotaCofins( '1'  );
        end else begin

            xalicofins:=0;

        end;

        valorpis:=roundvalor(valoritem*(xalipis/100));
        valorcofins:=roundvalor(valoritem*(xalicofins/100));

        FRel.AddCel( CSTpis );
        FRel.AddCel( '' );
        FRel.AddCel( '' );
        FRel.AddCel( floattostr( valoritem ) );
        FRel.AddCel( floattostr( baseitem ) );
        FRel.AddCel( floattostr( baseitem ) );
        FRel.AddCel( floattostr( valorpis ) );
        FRel.AddCel( floattostr( valorcofins ) );
        FRel.AddCel(Q.FieldByName('moes_tipomov').AsString+'-'+FGeral.GetTipoMovto(Q.FieldByName('moes_tipomov').AsString));

        if Global.Topicos[1055] then begin

           QContab:=sqltoquery('select moct_debito,moct_credito from movcontab where moct_transacao = '+
                    Stringtosql(Q.FieldByName('moes_transacao').AsString)+
                    ' and moct_datamvto = '+Datetosql(Q.FieldByName('moes_datamvto').AsDatetime)+
                    ' and moct_tipo = '+stringtosql('NOTAS') );
           FRel.AddCel( QContab.FieldByName('moct_debito').AsString );
           FRel.AddCel( QContab.FieldByName('moct_credito').AsString );
           FGeral.FechaQuery(QContab);

        end;

      Q.Next;

    end;

    FRel.Video;

    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);

  end;

  FRelAuditorias_ChecaPisCofins;         // 6

end;

// 11.02.23
procedure FRelAuditorias_ChecaTributacaoVendas;   // 7
///////////////////////////////////////////////////////
var sqlunidade,sqltipomovto,sqldatacont,
    tiposnao,
    xcfop,
    xcst,
    cfopncm,
    cstncm,
    xncm       :string;
    aliicmsncm,
    valoritem,
    valoricms        :currency;
    Q,
    QTrib            :TSqlquery;
     achou           :boolean;

begin

  with FRelAuditorias do begin

    if not FRelAuditorias_Execute(7) then Exit;

    if trim(EdUnid_codigo.text)<>'' then begin
      sqlunidade:=' and '+FGeral.getin('move_unid_codigo',EdUnid_codigo.text,'C');
    end else begin
      sqlunidade:='';
    end;
    if trim(EdTipomov.text)<>'' then begin
      sqltipomovto:=' and '+FGeral.getin('move_tipomov',EdTipomov.text,'C');
    end else begin
      sqltipomovto:='';
    end;
    sqldatacont:=' and  moes_datacont > '+Datetosql(Global.DataMenorBanco);

    tiposnao:=Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai+';'+Global.CodEntradaSemItens+';'+Global.CodContrato;
    Sistema.beginprocess('Pesquisando movimento no per�odo');

    Q:=sqltoquery('select * from movestoque inner join movesto on (moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                  ' inner join natureza on (natf_codigo=moes_natf_codigo)'+
                  ' inner join estoque on (esto_codigo=move_esto_codigo)'+
                  ' where '+FGeral.GetNOTIN('move_status','C','C')+
                  ' and substr(moes_natf_codigo,1,1) in (''5'',''6'',''7'')'+
                  ' and move_datamvto>='+EdDatai.assql+
                    sqlunidade+sqltipomovto+sqldatacont+
                  ' and '+FGeral.GetNOTIN('moes_tipomov',Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai,'C')+
                  ' and '+FGeral.GetNOTIN('move_tipomov',Global.CodBaixaMatEnt+';'+Global.CodBaixaMatSai,'C')+
                  ' and '+FGeral.GetNOTIN('moes_especie','CF;CF ;','C')+
                  ' and '+FGeral.GetNOTIN('moes_tipomov',tiposnao,'C')+
                  ' and moes_natf_codigo is not null'+
                  ' and moes_status not in (''X'',''Y'',''I'')'+
                  ' and move_datamvto<='+EdDAtaf.assql+' order by move_unid_codigo');


    if Q.eof then begin
      Sistema.EndProcess('Nada encontrado para impress�o');
      Q.close;
      Freeandnil(Q);
      exit;
    end;

    FRel.Init('RelConferenciaTributacaoVendas');
    FRel.AddTit('Relat�rio de Diverg�ncia de CST, CFOP e % de Icms das Saidas');
    FRel.AddTit(FGeral.TituloRelUnidade(EdUnid_codigo.Text));
    FRel.AddTit('Periodo : '+FGeral.formatadata(EdDatai.Asdate)+' a '+FGeral.formatadata(EdDataf.asdate));
    FRel.AddCol( 45,2,'C','' ,''              ,'Unidade'         ,''         ,'',false);
    FRel.AddCol( 90,0,'C','' ,''              ,'Transa��o'       ,''         ,'',false);
//    FRel.AddCol( 60,1,'D','' ,''              ,'Movimento'    ,''         ,'',false);
    FRel.AddCol( 60,1,'D','' ,''              ,'Emiss�o'    ,''         ,'',false);
    FRel.AddCol( 70,3,'N','' ,''              ,'Numero Doc.'     ,''         ,'',False);
    FRel.AddCol( 70,1,'C','' ,''              ,'Codigo'           ,''         ,'',false);
    FRel.AddCol( 70,1,'C','' ,''              ,'NCM'           ,''         ,'',false);
    FRel.AddCol(230,1,'C','' ,''              ,'Descri��o produto'           ,''         ,'',false);
    FRel.AddCol( 60,1,'C','' ,''              ,'CFOP'           ,''         ,'',false);
    FRel.AddCol( 50,1,'C','' ,''              ,'CST'           ,''         ,'',false);
    FRel.AddCol( 50,1,'N','' ,''              ,'% Icms'           ,''         ,'',false);
    FRel.AddCol( 90,3,'N','+' ,f_cr           ,'Valor Item'           ,''         ,'',False);
    FRel.AddCol( 80,3,'N','+' ,f_cr           ,'Valor Icms '           ,''         ,'',False);
    FRel.AddCol( 60,1,'C','' ,''              ,'CFOP'           ,'NCM'         ,'',false);
    FRel.AddCol( 60,1,'C','' ,''              ,'CST'           ,'NCM'         ,'',false);
    FRel.AddCol( 60,1,'N','' ,''              ,'% Icms'           ,'NCM'         ,'',false);

    while not Q.Eof do begin

       xcfop := Q.FieldByName('move_natf_codigo').AsString;
       xcst  := Q.FieldByName('move_cst').AsString;
       xncm  := FEstoque.GetNCMipi(Q.FieldByName('move_esto_codigo').AsString);
       QTrib  := sqltoquery('select * from codigosipi where cipi_codfiscal = '+stringtosql(xncm));
       valoritem := Q.FieldByName('move_qtde').AsCurrency*Q.FieldByName('move_venda').AsCurrency;
       valoricms := valoritem*(Q.FieldByName('move_aliicms').AsCurrency/100);
       FGeral.GetTributacaoNCm(QTrib,xcfop,Q.FieldByName('move_unid_codigo').AsString,aliicmsncm,cstncm,cfopncm,achou);
//          if not Achou then begin
//         end;

         if ( Q.FieldByName('move_aliicms').AsCurrency<>aliicmsncm )
            or
            ( xcfop<>cfopncm )
            or
            ( xcst<>cstncm )
             then begin
                FRel.AddCel(Q.FieldByName('move_unid_codigo').AsString);
                FRel.AddCel(Q.FieldByName('move_transacao').AsString);
                FRel.AddCel(Q.FieldByName('moes_dataemissao').AsString);
                FRel.AddCel(Q.FieldByName('moes_numerodoc').AsString);
                FRel.AddCel(Q.FieldByName('move_esto_codigo').AsString);
                FRel.AddCel(xncm);
                FRel.AddCel(Q.FieldByName('esto_descricao').AsString);
                FRel.AddCel(Q.FieldByName('move_natf_codigo').AsString);
                FRel.AddCel(Q.FieldByName('move_cst').AsString);
                FRel.AddCel(floattostr(Q.FieldByName('move_aliicms').AsCurrency));
                FRel.AddCel(floattostr(valoritem));
                FRel.AddCel(floattostr(valoricms));
                FRel.AddCel(cfopncm);
                FRel.AddCel(cstncm);
                FRel.AddCel(floattostr(aliicmsncm));
        end;

       QTrib.close;
       Q.Next;

    end;

    FRel.Video;
    Sistema.EndProcess('');
    Q.Close;Freeandnil(Q);

  end;

  FRelAuditorias_ChecaTributacaoVendas;

end;

procedure TFRelAuditorias.baplicarClick(Sender: TObject);
begin
  if not EdDAtai.ValidEdiAll(FRelAuditorias,99) then exit;
  Saiok:=true;
  close;

end;

procedure TFRelAuditorias.FormActivate(Sender: TObject);
begin
  FRelAuditorias.EdDatai.SetFirstEd;
  if FRelAuditorias.EdDatai.isempty then begin
    FRelAuditorias.EdDatai.setdate(sistema.hoje);
    FRelAuditorias.EdDataf.setdate(sistema.hoje);
  end;
end;

////////////////////////////////////////////////////////////////////////////
function TFRelAuditorias.TributaPIS(ycst: TACBrSituacaoTribPIS): boolean;
///////////////////////////////////////////////////////
begin
      result:=false;
      if ycst in [ stpisValorAliquotaNormal,stpisValorAliquotaDiferenciada,stpisQtdeAliquotaUnidade,
                   stpisValorAliquotaPorST,stpisOperCredExcRecTribMercInt,stpisOperCredExcRecNaoTribMercInt,
                   stpisOperCredExcRecExportacao,stpisCredPresAquiExcRecTribMercInt,
                   stpisCredPresAquiExcRecNaoTribMercInt,
                   stpisCredPresAquiExcExcRecExportacao,
                   stpisCredPresAquiRecTribNaoTribMercInt,
                   stpisCredPresAquiRecTribMercIntEExportacao,
                   stpisCredPresAquiRecNaoTribMercIntEExportacao,
                   stpisCredPresAquiRecTribENaoTribMercIntEExportacao,
                   stpisOutrasOperacoes_CredPresumido,
                   stpisOperCredExcRecTribMercInt,     // '50' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita Tributada no Mercado Interno
                   stpisOperCredExcRecExportacao,      // '52' // Opera��o com Direito a Cr�dito - Vinculada Exclusivamente a Receita de Exporta��o
                   stpisOperCredRecTribNaoTribMercInt, // '53' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas e N�o-Tributadas no Mercado Interno
                   stpisOperCredRecTribMercIntEExportacao, // '54' // Opera��o com Direito a Cr�dito - Vinculada a Receitas Tributadas no Mercado Interno e de Exporta��o
                   stpisOperCredRecNaoTribMercIntEExportacao, // '55' // Opera��o com Direito a Cr�dito - Vinculada a Receitas N�o-Tributadas no Mercado Interno e de Exporta��o
                   stpisOperCredRecTribENaoTribMercIntEExportacao,
                   stpisOperAquiPorST ]
                   then
        result:=true;

end;

procedure TFRelAuditorias.Edunid_codigoValidate(Sender: TObject);
begin
  if trim(EdUnid_codigo.Text)='' then
    EdUnid_codigo.Text:=Global.Usuario.UnidadesRelatorios;

end;

procedure TFRelAuditorias.EdEsto_codigoExitEdit(Sender: TObject);
begin
  baplicarclick(self);
end;

procedure TFRelAuditorias.EddatafValidate(Sender: TObject);
begin
   if (not EdDataf.isempty) and ( not EdDatai.isempty ) then begin
     if EdDAtaf.asdate<Eddatai.asdate then
       EdDataf.invalid('Data final tem que ser maior que inicial');
   end;
end;

procedure TFRelAuditorias.EdMesanofExitEdit(Sender: TObject);
begin
  baplicarclick(self);
end;

procedure TFRelAuditorias.EdMesanoiExitEdit(Sender: TObject);
begin
  baplicarclick(self);
end;

procedure TFRelAuditorias.EdGrup_codigoValidate(Sender: TObject);
begin
  if EdGrup_codigo.AsInteger>0 then
    sqlgrupo:=' and esto_grup_codigo='+EdGrup_codigo.AsSql
  else
    sqlgrupo:='';

end;

end.
