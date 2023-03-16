unit relcadas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid, SqlExpr;

type
  TFRelcadastros = class(TForm)
    PRel: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    baplicar: TSQLBtn;
    bSair: TSQLBtn;
    PMens: TSQLPanelGrid;
    EdRepre: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdCliente: TSQLEd;
    SQLEd2: TSQLEd;
    EdDatai: TSQLEd;
    EdDataf: TSQLEd;
    EdAtivos: TSQLEd;
    EdTiposmov: TSQLEd;
    EdCodimp: TSQLEd;
    SetEdimpr_DESCRICAO: TSQLEd;
    Edqtde: TSQLEd;
    EdMediavendas: TSQLEd;
    EdMediaatraso: TSQLEd;
    EdDatabase: TSQLEd;
    EdSituacao: TSQLEd;
    EdUsua_codigo: TSQLEd;
    EdUsua_nome: TSQLEd;
    procedure baplicarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdClienteExitEdit(Sender: TObject);
    procedure EdDatafExitEdit(Sender: TObject);
    procedure EdqtdeExitEdit(Sender: TObject);
    procedure EdSituacaoValidate(Sender: TObject);
    procedure EdUsua_codigoValidate(Sender: TObject);
  private
    { Private declarations }
    SaiOk:Boolean;
  public
    { Public declarations }
    procedure SetaReprecliente;
    function EstaValendo(Cliente:integer):boolean;
    function GetTitAtivos:string;
  end;

var
  FRelcadastros: TFRelcadastros;
  Largura,nrorel,margem:integer;
  Q:TSqlquery;
  sqlrepre,sqlcliente,unidade,mensagemclientesinativos,sqlsituacao,sqlusuario,
  xunidades,sqlU:string;

procedure FRelCadastros_FichaCadastral;         // 1
procedure FRelCadastros_Aniversariantes;        // 2
procedure FRelCadastros_CliNovos;               // 3
procedure FRelCadastros_CliNovosRes;            // 4
procedure FRelCadastros_Etiqueta;               // 5
procedure FRelCadastros_TiposdeMovimento;       // 6
procedure FRelCadastros_Testelayout;            // 7
procedure FRelCadastros_VendasInativos;         // 8
procedure FRelCadastros_EtqVendasInativos;      // 9
// 03.05.13
procedure FRelCadastros_LimiteDisponivel;      // 10

implementation

uses Geral, TextRel, Unidades, Sqlsis, Sqlfun, represen, munic, SQLRel ,
  impressao, cadcli, Usuarios;

{$R *.dfm}



function FRelCadastros_Execute(Tp:Integer):Boolean;
//////////////////////////////////////////////////////////////
begin
  if FRelCadastros=nil then FGeral.CreateForm(TFRelCadastros, FRelCadastros);
  result:=true;
  nrorel:=tp;
  unidade:=Global.CodigoUnidade;
  xunidades:=Global.Usuario.UnidadesRelatorios;
  sqlU:=' and '+FGeral.GetIN('clie_unid_codigo',xunidades,'C');
  if FGeral.getconfig1asinteger('diasinativo')>0 then
    mensagemclientesinativos:='Somente clientes com remessa h� menos de '+inttostr(FGeral.getconfig1asinteger('diasinativo'))+' dias'
  else
    mensagemclientesinativos:='';
  with FRelCadastros do begin

    if tp=1 then begin

      Caption:='Ficha cadastral de clientes';


    end else if tp=2 then
      Caption:='Rela��o de Aniversariantes'
    else if tp=3 then
      Caption:='Rela��o de Clientes por per�odo'
    else if tp=4 then
      Caption:='Rela��o de Resumida de Clientes por per�odo'
    else if tp=5 then
      Caption:='Etiquetas de Clientes'
    else if tp=6 then
      Caption:='Tipos de Movimentos'
    else if tp=7 then
      Caption:='Teste layout'
    else if tp=8 then
      Caption:='Vendas Inativos'
    else if tp=9 then
      Caption:='Etiquetas Vendas Inativos'
    else if tp=10 then
      Caption:='Limite Dispon�vel';

    EdDatai.enabled:=false;
    EdDataf.enabled:=false;
    EdCodimp.enabled:=false;
    EdQtde.enabled:=false;
// 13.12.13
    Edusua_codigo.Enabled:=(tp=10);
    EdSituacao.Enabled:=(tp=5);
    if EdDAtai.isempty then begin
      EdDatai.setdate(sistema.hoje);
      EdDataf.setdate(sistema.hoje);
    end;
    if (tp=1) or (tp=2) or (tp=3) or (tp=4) or (tp=5) or (tp=8) or (tp=9) or (tp=10)  then begin
      EdCliente.enabled:=true;
      EdRepre.enabled:=true;
      if (tp=2) or (tp=3) or (tp=4)  or (tp=5) then begin
        EdDatai.enabled:=true;
        EdDataf.enabled:=true;
      end else begin
        EdDatai.enabled:=false;
        EdDataf.enabled:=false;
      end;
    end else begin
      EdCliente.enabled:=false;
      EdRepre.enabled:=false;
    end;
    if (tp=1) or (tp=3) or (tp=5) or (tp=10) or (tp=2) then
      EdAtivos.enabled:=true
    else
      EdAtivos.enabled:=false;
    if tp=7 then begin
      EdCodimp.enabled:=true;
      EdQtde.enabled:=true;
    end;
// 08.08.06
    if (tp=8) or (tp=9) then begin
      EdMediavendas.enabled:=true;
      EdMediaatraso.enabled:=true;
      EdDatabase.enabled:=true;
      if EdDatabase.isempty then
        EdDatabase.setdate(sistema.hoje);
    end else begin
      EdMediavendas.enabled:=false;
      EdMediaatraso.enabled:=false;
      EdDatabase.enabled:=false;
    end;
//    if tp=10 then EdCliente.enabled:=true;
    
    largura:=74;   // 80 passa 6 colunas em matricial
    SaiOk:=False;
    FRelCadastros.ShowModal;

    Result:=SaiOk;
  end;
end;

procedure TFRelcadastros.SetaReprecliente;
////////////////////////////////////////////
begin
   if EdRepre.isempty then
     sqlrepre:=''
   else
     sqlrepre:=' and clie_repr_codigo='+Edrepre.assql;
   if EdCliente.isempty then
     sqlcliente:=''
   else
     sqlcliente:=' and clie_codigo='+Edcliente.assql;
end;


procedure FRelCadastros_FichaCadastral;         // 1
//////////////////////////////////////////////////////////////////
var nroclientes,nclientes:integer;
    QUVenda,QPendentes:TSqlquery;
    TiposVenda,dtnasc,dtcad,ativodesc,titativos:string;
    Ativo:boolean;

    function EstaValendoaqui:boolean;
    ///////////////////////////////////
    begin
       result:=true;
       if (FRelCadastros.EdAtivos.text='A') and (Ativo) then
         result:=true
       else if (FRelCadastros.EdAtivos.text='T') then
         result:=true
       else if (pos(FRelCadastros.EdAtivos.text,'A')=0) and ( not Ativo ) then
         result:=true
       else
         result:=false;
    end;

begin
  with FRelCadastros do begin

       if ( not Global.Usuario.OutrosAcessos[0066] ) then begin

         Aviso('Acesso n�o autorizado' );
         close;
         exit;

      end;


    if not FRelCadastros_Execute(1) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
//    if EdRepre.isempty then begin
//      Edrepre.invalid('� necess�rio escolher um representante');
//      exit;
//    end;
    SetaReprecliente;
// 06.09.05
    if EdCliente.asinteger>0 then
      sqlrepre:='';
//    Tiposvenda:=Global.CodVendaConsig+';'+global.CodVendaDireta+';'+global.CodVendaProntaEntrega+';'+global.CodVendaSemMovEstoque+';'+
//                global.CodVendaMagazine+';'+global.CodVendaInternet+';'+global.CodVendaSerie4+';'+Global.CodVendaProntaEntregaFecha;
// 19.09.09 - para ficar igual a funcao fgeral.estaativo
    Tiposvenda:=Global.CodRemessaConsig+';'+Global.CodRemessaProntaEntrega+';'+Global.CodVendaConsig+';'+Global.CodVendaDireta+';'+
              Global.CodVendaMagazine+';'+Global.CodVendaInterna+';'+Global.CodVendaSerie4+';'+Global.CodVendaProntaEntrega;


    Q:=sqltoquery('select * from clientes where clie_nome is not null '+
                   sqlrepre+sqlcliente+sqlU+
                   ' order by clie_nome');
    if Q.eof then begin
       Avisoerro('Nada encontrado para impress�o');
       Q.close;
       Freeandnil(Q);
       Sistema.EndProcess('');
       exit;
    end;
// 06.09.05
    if EdCliente.asinteger>0 then begin
      EdRepre.setvalue(Q.fieldbyname('clie_repr_codigo').asinteger);
//      FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309],13,120);
      FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309]);
    end else
//      FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309],0);
      FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309]);

//    FTextRel.Init(60);
// 07.02.11
//    FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309]);
// 12.06.13
//    FTextRel.Init(60,nil,nil,0,Global.Usuario.OutrosAcessos[3309],14);
//    FTextRel.MargemEsquerda:=3;
    FTextRel.MargemEsquerda:=0;
    FTextRel.Titulo.Clear;
    FTextRel.ClearColunas;
    titativos:=GetTitAtivos;
    margem:=FTextRel.MargemEsquerda;
//      FRel.AddTit(Global.NomeSistema+' '+Global.VersaoSistema+space(78)+'Emiss�o:'+Datetostr(Sistema.hoje)+' '+timetostr(time)+'  Pg: [NumPg]',false,false,true );
    FTextRel.AddTitulo(FGeral.Centra('Ficha Cadastral de Cliente'+titativos,largura),false,false,false);
    FTextRel.AddTitulo(space(margem)+replicate('-',largura+3),false,false,false);
    FTextRel.AddTitulo(space(margem)+'Unidade : '+Unidade+' - '+copy(FUnidades.Getnome(Unidade)+space(48),1,48)+'  Pg: [NumPg]',false,false,false);
    FTextRel.AddTitulo(space(margem)+'Data    : '+formatdatetime('dd/mm/yy',Sistema.hoje)+
              ' - Representante '+Edrepre.text+' - '+FRepresentantes.GetDescricao(Edrepre.asinteger),false,false,false);
    FTextRel.AddTitulo(space(margem)+replicate('-',largura+3),false,false,false);
    nroclientes:=0;
    nclientes:=0;
// ver checar pela data da ultima remessa feita ou algo assim para definir se 'esta ativo'
// fazer funcao q retorna true/false
    while not Q.eof do begin
//      ativo:=FGeral.EstaAtivo(Q.FieldByName('clie_codigo').Asinteger,'C',Q.FieldByName('clie_dtcad').Asdatetime );
// 18.09.06 - para usar  a data de hoje como parametro
      ativo:=FGeral.EstaAtivo(Q.FieldByName('clie_codigo').Asinteger,'C',0 );
      if EdCliente.asinteger>0 then begin
        if ativo then
          ativodesc:=' - ATIVO'
        else
          ativodesc:=' - INATIVO';
      end else
        ativodesc:='';
//      if (ativo) or (EdCliente.asinteger=Q.FieldByName('clie_codigo').Asinteger) or EstaValendo() then begin
      if (EdCliente.asinteger=Q.FieldByName('clie_codigo').Asinteger) or (EstaValendoaqui) then begin
        FTextREl.AddLinha('Cliente.......: '+Q.FieldByName('clie_codigo').AsString+' - '+
                          Q.FieldByName('clie_nome').AsString+ativodesc,false,false,false);
        FTextREl.AddLinha('Raz�o Social..: '+strspace(Q.FieldByName('clie_razaosocial').AsString,40),false,false,false);
        FTextREl.AddLinha('Endere�o......: '+strspace(Q.FieldByName('clie_endres').AsString,40),false,false,false);
        FTextREl.AddLinha('Bairro........: '+strspace(Q.FieldByName('clie_bairrores').AsString,30)+' Cep.....: '+Trans(Q.FieldByName('clie_cepres').AsString,f_cep)
                         ,false,false,false);
        FTextREl.AddLinha('Cidade........: '+strspace(FCidades.GetNome(Q.FieldByName('clie_cida_codigo_res').Asinteger),30)+' UF......: '+Q.FieldByName('clie_uf').AsString
                         ,false,false,false);
        FTextREl.AddLinha('Telefone......: '+strspace(FGeral.Formatatelefone(Q.FieldByName('clie_foneres').AsString),30)+' Celular : '+fGeral.formatatelefone(Q.FieldByName('clie_fonecel').AsString)
                         ,false,false,false);
        FTextREl.AddLinha('CPF...........: '+strspace(Q.FieldByName('clie_cnpjcpf').AsString,30)+' RG......: '+Q.FieldByName('clie_rgie').AsString
                         ,false,false,false);
        if Q.FieldByName('clie_dtcad').AsDatetime>1 then
           dtcad:=formatdatetime('dd/mm/yy',Q.FieldByName('clie_dtcad').AsDatetime)
        else
           dtcad:=space(8);
        if Q.FieldByName('clie_dtnasc').AsDatetime>1 then
          dtnasc:=Formatdatetime('dd/mm/yy',Q.FieldByName('clie_dtnasc').AsDatetime)
        else
          dtnasc:=space(8);
        FTextREl.AddLinha('Data cadastro.: '+strspace(dtcad,30)+' Nascimen: '+dtnasc
                         ,false,false,false);
        FTextREl.AddLinha('Filia��o      : '+strspace(Q.FieldByName('Clie_pai').asstring,30)+' '+strspace(Q.FieldByName('Clie_mae').asstring,30)
                         ,false,false,false);


        QUVenda:=sqltoquery('select max(moes_dataemissao) as uvenda from movesto where moes_tipo_codigo='+stringtosql(Q.FieldByName('clie_codigo').AsString)+
                            ' and moes_tipocad=''C'' and moes_status<>''C'' and '+FGeral.getin('moes_tipomov',tiposvenda,'C') );
        QPendentes:=sqltoquery('select sum(pend_valor) as valor from pendencias where pend_status=''N'' and pend_tipo_codigo='+inttostr(Q.FieldByName('clie_codigo').AsInteger)+
                           ' and pend_tipocad=''C'' and pend_valor>0');
        if not QUvenda.eof then begin
          if quvenda.fieldbyname('uvenda').asdatetime>1 then
            FTextREl.AddLinha('Ultima compra.: '+strspace(Formatdatetime('dd/mm/yy',QUVenda.FieldByName('uvenda').AsDatetime),30)+
                              ' '+floattostr(QPendentes.fieldbyname('valor').ascurrency)
                           ,false,false,false)
          else
            FTextREl.AddLinha('Ultima compra.: '+strspace(space(8),30)+
                              ' '+floattostr(QPendentes.fieldbyname('valor').ascurrency)
                           ,false,false,false);
        end;
        FTextREl.AddLinha('End. Cobran�a.: '+strspace(Q.FieldByName('clie_endcom').Asstring,50)
                         ,false,false,false);
        FTextRel.AddLinha(space(margem-3)+replicate('-',largura+3),false,false,false);
        QUvenda.close;
        Freeandnil(QUvenda);
        FGeral.Fechaquery(QPendentes);
        inc(nroclientes);
        inc(nclientes);
      end;
//      if nroclientes=4 then begin
// 25.05.06 - Reges - aproveitar melhor o espa�o por folha na laser
      if nroclientes=5 then begin
        nroclientes:=0;
        FTextREl.NovaPagina;
      end;
      Q.Next;
    end;
    FTextRel.Video('',12);
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;

end;

procedure FRelCadastros_Aniversariantes;        // 2
///////////////////////////////////////////////////////
var dtnasc,dtcad,titativos:string;

begin

  with FRelCadastros do begin
    if not FRelCadastros_Execute(2) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    SetaReprecliente;
    Q:=sqltoquery('select * from clientes where clie_nome is not null '+
                   sqlrepre+sqlcliente+sqlU+
                   ' order by clie_nome');
    if Q.eof then begin
       Avisoerro('Nada encontrado para impress�o');
       Q.close;
       Freeandnil(Q);
       Sistema.EndProcess('');
       exit;
    end;
    FRel.Init('RelAniversariantes');
    titativos:=GetTitAtivos;
    FRel.AddTit('Rela��o de Aniversariantes - Per�odo : '+formatdatetime('dd/mm/yy',EdDAtai.asdate)+' a '+formatdatetime('dd/mm/yy',EdDAtaf.asdate) );
    FRel.AddTit('Representante : '+EdRepre.text+' - '+Setedclie_nome.text+titativos );
//    if FGeral.getconfig1asinteger('diasinativo')>0 then
//      FRel.Addtit(mensagemclientesinativos);

    FRel.AddCol( 60,3,'N','' ,''              ,'Codigo'          ,''         ,'',false);
    FRel.AddCol(220,0,'C','' ,''              ,'Nome'           ,''         ,'',false);
//    FRel.AddCol( 60,1,'N','' ,''              ,'Nascimento'     ,''         ,'',false);
    FRel.AddCol( 60,1,'N','' ,''              ,'Dia/Mes'        ,''         ,'',false);
    FRel.AddCol( 80,1,'C','' ,''              ,'Telefone'        ,''         ,'',false);
    FRel.AddCol( 80,1,'C','' ,''              ,'Celular'         ,''         ,'',false);
    FRel.AddCol(120,1,'C','' ,''              ,'Cidade'          ,''         ,'',false);
    FRel.AddCol( 40,1,'C','' ,''              ,'Estado'          ,''         ,'',false);
    while not Q.eof do begin
      if (FGeral.Parabens(Q.fieldbyname('clie_dtnasc').asdatetime,EdDAtai.asdate,EdDataf.asdate) ) and
//         (FGeral.EstaAtivo(Q.FieldByName('clie_codigo').Asinteger,'C',Q.FieldByName('clie_dtcad').Asdatetime) )
         Estavalendo(Q.fieldbyname('clie_codigo').asinteger)
        then begin
        FRel.AddCel(Q.fieldbyname('clie_codigo').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('clie_codigo').asinteger,'C','N'));
        FRel.AddCel( formatdatetime('dd/mm',Q.fieldbyname('clie_dtnasc').asdatetime) );
//        FRel.AddCel( copy(Datetotextinvertida(Q.fieldbyname('clie_dtnasc').asdatetime,true),5,4) );
//        FRel.AddCel( Datetotextinvertida(Q.fieldbyname('clie_dtnasc').asdatetime,true) );
//        FRel.AddCel(Q.fieldbyname('clie_dtnasc').asstring);
//        FRel.AddCel(copy(Q.fieldbyname('clie_dtnasc').asstring,4,2)+' '+copy(Q.fieldbyname('clie_dtnasc').asstring,1,2));
        FRel.AddCel( FGeral.Formatatelefone(Q.fieldbyname('clie_foneres').asstring));
        FRel.AddCel( FGeral.Formatatelefone(Q.fieldbyname('clie_fonecel').asstring));
        FRel.AddCel( FCidades.GetNome(Q.fieldbyname('clie_cida_codigo_res').asinteger));
        FRel.AddCel(Q.fieldbyname('clie_uf').asstring);
      end;
      Q.next;
    end;
    FRel.setsort('Dia/Mes');
    FRel.Video;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;
end;



procedure FRelCadastros_CliNovos;               // 3
/////////////////////////////////////////////
begin
  with FRelCadastros do begin
    if not FRelCadastros_Execute(3) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    SetaReprecliente;
    Q:=sqltoquery('select * from clientes where clie_nome is not null '+
                   sqlrepre+sqlcliente+sqlU+
                   ' and clie_dtcad >= '+EdDatai.assql+' and clie_dtcad <= '+EdDataf.assql+
                   ' order by clie_repr_codigo,clie_nome');
    if Q.eof then begin
       Avisoerro('Nada encontrado para impress�o');
       Q.close;
       Freeandnil(Q);
       Sistema.EndProcess('');
       exit;
    end;
    FRel.Init('RelClientesNovos');
    FRel.AddTit('Rela��o de Clientes no per�odo de '+formatdatetime('dd/mm/yy',EdDAtai.asdate)+' a '+formatdatetime('dd/mm/yy',EdDAtaf.asdate) );
    if not EdREpre.isempty then
      FRel.AddTit('Representante : '+EdRepre.text+' - '+Setedclie_nome.text )
    else begin
      FRel.AddCol( 40,3,'N','' ,''              ,'Repr.'           ,''         ,'',false);
      FRel.AddCol(120,0,'C','' ,''              ,'Nome repr.'     ,''         ,'',false);
    end;
    FRel.AddCol( 50,3,'N','' ,''              ,'Cliente'         ,''         ,'',false);
    FRel.AddCol(220,0,'C','' ,''              ,'Nome cliente'   ,''         ,'',false);
    FRel.AddCol(220,0,'C','' ,''              ,'Endere�o'       ,''         ,'',false);
    FRel.AddCol(100,0,'C','' ,''              ,'Bairro'         ,''         ,'',false);
    FRel.AddCol(150,0,'C','' ,''              ,'Cobran�a'       ,''         ,'',false);
    FRel.AddCol( 80,1,'C','' ,''              ,'Telefone'        ,''         ,'',false);
    FRel.AddCol( 80,1,'C','' ,''              ,'Celular'         ,''         ,'',false);
    FRel.AddCol(120,1,'C','' ,''              ,'Cidade'          ,''         ,'',false);
    FRel.AddCol( 40,1,'C','' ,''              ,'Estado'          ,''         ,'',false);
// 24.10.12 - Vivan
    FRel.AddCol(120,1,'C','' ,''              ,'Email 1'          ,''         ,'',false);
    FRel.AddCol(120,1,'C','' ,''              ,'Email 2'          ,''         ,'',false);
    if Global.topicos[1105] then begin
      FRel.AddCol( 60,1,'C','' ,''              ,'Matr�cula'       ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Tipo'       ,''         ,'',false);
      FRel.AddCol( 60,1,'C','' ,''              ,'Tipo Mens.'       ,''         ,'',false);
      FRel.AddCol( 70,3,'N','' ,''              ,'Valor Mens.'       ,''         ,'',false);
      FRel.AddCol( 90,1,'C','' ,''              ,'Invernada'       ,''         ,'',false);
      FRel.AddCol( 90,1,'C','' ,''              ,'Grupo'       ,''         ,'',false);
    end;
    while not Q.eof do begin
      if Estavalendo(Q.fieldbyname('clie_codigo').asinteger) then begin
        if EdREpre.isempty then begin
          FRel.AddCel(Q.fieldbyname('clie_repr_codigo').asstring);
  //      FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('clie_repr_codigo').asinteger,'R','N'));
          FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('clie_repr_codigo').asinteger,'R','N'));
        end;
        FRel.AddCel(Q.fieldbyname('clie_codigo').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('clie_codigo').asinteger,'C','N'));
        FRel.AddCel(Q.FieldByName('clie_endres').Asstring);
        FRel.AddCel(Q.FieldByName('clie_bairrores').Asstring);
        FRel.AddCel(Q.FieldByName('clie_endcom').Asstring);
        FRel.AddCel( FGeral.Formatatelefone(Q.fieldbyname('clie_foneres').asstring));
        FRel.AddCel( FGeral.Formatatelefone(Q.fieldbyname('clie_fonecel').asstring));
        FRel.AddCel( FCidades.GetNome(Q.fieldbyname('clie_cida_codigo_res').asinteger));
        FRel.AddCel(Q.fieldbyname('clie_uf').asstring);
        FRel.AddCel(Q.fieldbyname('clie_email').asstring);
        FRel.AddCel(Q.fieldbyname('clie_email1').asstring);
        if Global.topicos[1105] then begin
          FRel.AddCel(Q.FieldByName('clie_matricula').Asstring);
          FRel.AddCel(Q.FieldByName('Clie_integrante').AsString);
          FRel.AddCel( FCadcli.GetTipoMensalidade(Q.FieldByName('clie_tipomensa').Asstring) );
          FRel.AddCel( floattostr( FCadcli.GetValorMensalidade(Q.FieldByName('clie_tipomensa').Asstring,Q.FieldByName('clie_qintegra').Asstring) ) );
          FRel.AddCel( FCadcli.GetTipoInvernada(Q.FieldByName('clie_tipoinver').Asstring));
          FRel.AddCel( Q.FieldByName('clie_grupoinv').Asstring );
        end;
      end;
      Q.next;
    end;
    FRel.Video;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;
end;


procedure FRelCadastros_CliNovosRes;            // 4
begin
  with FRelCadastros do begin
    if not FRelCadastros_Execute(4) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    SetaReprecliente;
//    Q:=sqltoquery('select clie_repr_codigo,clie_cida_codigo_res,clie_uf,count(*) as nroclientes from clientes'+
    Q:=sqltoquery('select clie_repr_codigo,count(*) as nroclientes from clientes'+
                   ' where clie_nome is not null '+
                   sqlrepre+sqlcliente+sqlU+
                   ' and clie_dtcad >= '+EdDatai.assql+' and clie_dtcad <= '+EdDataf.assql+
                   ' group by clie_repr_codigo'+
                   ' order by clie_repr_codigo');
    if Q.eof then begin
       Avisoerro('Nada encontrado para impress�o');
       Q.close;
       Freeandnil(Q);
       Sistema.EndProcess('');
       exit;
    end;
    FRel.Init('RelClientesNovosRes');
    FRel.AddTit('Rela��o de Clientes Resumida no per�odo de '+formatdatetime('dd/mm/yy',EdDAtai.asdate)+' a '+formatdatetime('dd/mm/yy',EdDAtaf.asdate) );
    if not EdREpre.isempty then
      FRel.AddTit('Representante : '+EdRepre.text+' - '+Setedclie_nome.text );
    FRel.AddCol( 40,3,'N','' ,''              ,'Repr.'           ,''         ,'',false);
    FRel.AddCol(120,0,'C','' ,''              ,'Nome repr.'     ,''         ,'',false);
    FRel.AddCol( 70,3,'N','+' ,''             ,'Nro.Clientes'    ,''         ,'',false);
//    FRel.AddCol(120,1,'C','' ,''              ,'Cidade'          ,''         ,'',false);
//    FRel.AddCol( 40,1,'C','' ,''              ,'Estado'          ,''         ,'',false);
    while not Q.eof do begin
      FRel.AddCel(Q.fieldbyname('clie_repr_codigo').asstring);
      FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('clie_repr_codigo').asinteger,'R','N'));
      FRel.AddCel(Q.fieldbyname('nroclientes').asstring);
//      FRel.AddCel( FRepresentantes.getCidade( Q.fieldbyname('clie_repr_codigo').asinteger ) );
//      FRel.AddCel(Q.fieldbyname('clie_uf').asstring);
      Q.next;
    end;
    FRel.Video;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;
end;


procedure FRelCadastros_Etiqueta;               // 5
///////////////////////////////////////////
var comando:string;
begin
  with FRelCadastros do begin
    if not FRelCadastros_Execute(5) then Exit;
    Sistema.BeginProcess('Gerando Etiquetas');
    SetaReprecliente;
    comando:='select * from clientes'+
                   ' where clie_nome is not null '+
                   sqlrepre+sqlcliente+sqlsituacao;
//                   ' and clie_dtcad >= '+EdDatai.assql+' and clie_dtcad <= '+EdDataf.assql+
//                   ' order by Clie_endres,clie_nome';
    FImpressao.ImprimeEtqCliente(comando,EdAtivos.text,EdDatai.asdate,EdDataf.asdate);
    Sistema.EndProcess('');
  end;
end;


procedure FRelCadastros_TiposdeMovimento;       // 6
///////////////////////////////////////////////////////
var tipo:string;
    p:integer;
begin
  with FRelCadastros do begin
    if not FRelCadastros_Execute(6) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    FGeral.SetaItemsMovimento(EdTiposmov);
    if EdTiposmov.items.count=0 then begin
       Avisoerro('Nada encontrado para impress�o');
       Sistema.EndProcess('');
       exit;
    end;
    FRel.Init('RelTiposdeMovimento');
    FRel.AddTit('Rela��o de Tipos de Movimento do Sistema');
    FRel.AddCol(080,1,'C','' ,''              ,'Tipo'   ,''         ,'',false);
    FRel.AddCol(220,0,'C','' ,''              ,'Tipo de Movimento'       ,''         ,'',false);
    FRel.AddCol(100,2,'C','' ,''              ,'Entrada/Saida'             ,''         ,'',false);
    FRel.AddCol(100,2,'C','' ,''              ,'Cliente/Fornecedor'             ,''         ,'',false);
    FRel.AddCol(100,2,'C','' ,''              ,'Movimenta Estoque'         ,''         ,'',false);
    FRel.AddCol(100,2,'C','' ,''              ,'Gera financeiro'       ,''         ,'',false);
    FRel.AddCol(100,2,'C','' ,''              ,'Gera Fiscal'        ,''         ,'',false);
    FRel.AddCol(100,2,'C','' ,''              ,'Calcula Icms'        ,''         ,'',false);
    FRel.AddCol(100,2,'C','' ,''              ,'Calcula Substit.'         ,''         ,'',false);
    for p:=0 to EdTiposmov.Items.count-1 do begin
      tipo:=copy(EdTiposmov.Items.Strings[p],1,2);
      FRel.AddCel(Tipo);
      FRel.AddCel(FGeral.GetTipoMovto(tipo));
      FRel.AddCel(FGeral.GetMovimentoEs(tipo));
      FRel.AddCel(FGeral.GetUsaCliFor(tipo));
      FRel.AddCel(FGeral.GetMovimentoEstoque(tipo));
      FRel.AddCel(FGeral.GetGeraFinanceiro(tipo));
      FRel.AddCel(FGeral.GetGeraFiscal(tipo));
      FRel.AddCel(FGeral.GetCalculaIcms(tipo));
      FRel.AddCel(FGeral.GetCalculaSubstit(tipo));
    end;
    FRel.Video;
    Sistema.EndProcess('');
  end;

  FRelCadastros_TiposdeMovimento;       // 6

end;


procedure FRelCadastros_Testelayout;            // 7
////////////////////////////////////////////////

var p:integer;
begin
  with FRelCadastros do begin
    if not FRelCadastros_Execute(7) then Exit;
    Sistema.BeginProcess('Gerando Relat�rio');
    FImpressao.ImprimeInstrucoescobranca(EdCodimp.text,Edqtde.asinteger);
    Sistema.EndProcess('');
  end;

  FRelCadastros_Testelayout;       // 7
end;

procedure FRelCadastros_VendasInativos;         // 8
type TLista=record
     codigo,diasatraso,nrovendas,nrobaixas:integer;
     totalvendas:currency;
     nome,clie_endres,clie_bairrores,clie_endcom,clie_foneres,clie_fonecel,clie_uf,clie_cida_nome_res,cep:string;

end;

var Q,QMovesto,QPendencias:TSqlquery;
    p:integer;
    LIsta:Tlist;
    PLista:^TLista;
    Datai,Dataf:TDatetime;
    mediaatraso:currency;
    mediavendas:currency;

begin

  with FRelCadastros do begin
    if not FRelCadastros_Execute(8) then Exit;
    Sistema.BeginProcess('Checando clientes inativos');
    SetaReprecliente;
    Q:=sqltoquery('select * from clientes where clie_nome is not null '+
                   sqlrepre+sqlcliente+sqlU+
                   ' order by clie_nome');
    if Q.eof then begin
       Avisoerro('Nada encontrado para impress�o');
       Q.close;
       Freeandnil(Q);
       Sistema.EndProcess('');
       exit;
    end;
    if EdDatabase.isempty then begin
      datai:=Datetodatemesant(Sistema.hoje,15);
      dataf:=Datetodatemesant(Sistema.hoje,03);
    end else begin
      datai:=Datetodatemesant(EdDatabase.asdate,15);
      dataf:=Datetodatemesant(EdDatabase.asdate,03);
    end;
    LIsta:=Tlist.create;
    FRel.Init('RelVendasInativos');
    FRel.AddTit('Rela��o de Clientes Inativos : '+formatdatetime('dd/mm/yy',DAtai)+' a '+formatdatetime('dd/mm/yy',DAtaf) );
    FRel.AddTit('Representante : '+EdRepre.text+' - '+Setedclie_nome.text+' M�dia Vendas :'+EdMediavendas.text+' M�dia Atraso :'+EdMediaatraso.text );
    FRel.AddCol(040,3,'N','' ,''              ,'Codigo'          ,''         ,'',false);
    FRel.AddCol(200,0,'C','' ,''              ,'Nome'           ,''         ,'',false);
    FRel.AddCol(200,0,'C','' ,''              ,'End.Res.'       ,''         ,'',false);
    FRel.AddCol(200,0,'C','' ,''              ,'Bairro Res.'    ,''         ,'',false);
    FRel.AddCol(200,0,'C','' ,''              ,'End.Com'        ,''         ,'',false);
    FRel.AddCol(090,0,'C','' ,''              ,'Fone'           ,''         ,'',false);
    FRel.AddCol(090,0,'C','' ,''              ,'Celular'        ,''         ,'',false);
    FRel.AddCol(060,0,'C','' ,''              ,'Cep'            ,''         ,'',false);
    FRel.AddCol(120,0,'C','' ,''              ,'Cidade'         ,''         ,'',false);
    FRel.AddCol(050,0,'C','' ,''              ,'Estado'         ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,f_cr              ,'Total Vendas'     ,''         ,'',false);
    FRel.AddCol( 80,3,'N',''  ,f_cr              ,'M�dia Vendas'     ,''         ,'',false);
    FRel.AddCol(080,3,'N',''  ,f_cr              ,'M�dia Atraso'     ,''         ,'',false);
    while not Q.eof do begin
      if ( not (FGeral.EstaAtivo(Q.FieldByName('clie_codigo').Asinteger,'C',Q.FieldByName('clie_dtcad').Asdatetime) ) )
         and ( Q.FieldByName('clie_codigo').Asinteger>0 )  then begin
        New(PLista);
        PLista.codigo:=Q.FieldByName('clie_codigo').Asinteger;
        PLista.diasatraso:=0;
        PLista.nrovendas:=0;
        PLista.nrobaixas:=0;
        PLista.totalvendas:=0;
        PLista.nome:=FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('clie_codigo').asinteger,'C','N');
        PLista.clie_endres:=Q.FieldByName('clie_endres').Asstring;
        PLista.clie_bairrores:=Q.FieldByName('clie_bairrores').Asstring;
        PLista.clie_endcom:=Q.FieldByName('clie_endcom').Asstring;
        PLista.clie_foneres:=Q.fieldbyname('clie_foneres').asstring;
        PLista.clie_fonecel:=Q.fieldbyname('clie_fonecel').asstring;
        PLista.clie_cida_nome_res:=FCidades.GetNome(Q.fieldbyname('clie_cida_codigo_res').asinteger);
        PLista.clie_uf:=Q.fieldbyname('clie_uf').asstring;
        PLista.cep:=Q.fieldbyname('clie_cepres').asstring;
        Lista.Add(PLista);
      end;
      Q.next;
    end;
    Sistema.BeginProcess('Checando vendas');
    for p:=0 to LIsta.count-1 do begin
        PLista:=Lista[p];
        QMovesto:=sqltoquery('select moes_tipo_codigo,moes_tipomov,sum(moes_vlrtotal) as vendas,count(*) as nrovendas from movesto'+
                              ' where moes_tipo_codigo='+inttostr(Plista.codigo)+' and moes_tipocad=''C'''+
                              ' and moes_datamvto>='+Datetosql(datai)+
                              ' and moes_datamvto<='+Datetosql(dataf)+
                              ' and moes_status<>''C'''+
                              ' and '+FGeral.Getin('moes_tipomov',Global.TiposRelVenda+';'+Global.TiposRelDevVenda,'C')+
                              ' group by moes_tipo_codigo,moes_tipomov' );
        while not QMovesto.eof do begin
          if pos(QMovesto.fieldbyname('moes_tipomov').asstring,Global.TiposRelDevVenda)>0 then begin
            Plista.totalvendas:=Plista.totalvendas-QMovesto.fieldbyname('vendas').asinteger;
          end else begin
            Plista.nrovendas:=Plista.nrovendas+QMovesto.fieldbyname('nrovendas').asinteger;
            Plista.totalvendas:=Plista.totalvendas+QMovesto.fieldbyname('vendas').asinteger;
          end;
          QMovesto.Next;
        end;
        FGeral.Fechaquery(QMovesto);
    end;
    Sistema.BeginProcess('Checando pendencias financeiras');
    for p:=0 to LIsta.count-1 do begin
        PLista:=Lista[p];
        QPendencias:=sqltoquery('select pend_tipo_codigo,sum(pend_databaixa-pend_datavcto) as diasatraso,count(*) as nrobaixas from pendencias'+
                              ' where pend_tipo_codigo='+inttostr(Plista.codigo)+' and pend_tipocad=''C'''+
                              ' and pend_databaixa>='+Datetosql(datai)+
                              ' and pend_databaixa<='+Datetosql(dataf)+
                              ' and pend_databaixa>pend_datavcto'+
                              ' group by pend_tipo_codigo' );
        while not QPendencias.eof do begin
          Plista.diasatraso:=Plista.diasatraso+QPendencias.fieldbyname('diasatraso').asinteger;
          Plista.nrobaixas:=Plista.nrobaixas+QPendencias.fieldbyname('nrobaixas').asinteger;
          QPendencias.Next;
        end;
        FGeral.Fechaquery(QPendencias);
    end;
    Sistema.BeginProcess('Gerando Relat�rio');
    for p:=0 to LIsta.count-1 do begin
        PLista:=Lista[p];
        if PLista.nrovendas>0 then
          mediavendas:=PLista.totalvendas/PLista.nrovendas
        else
          mediavendas:=0;
        if PLista.nrobaixas>0 then
          mediaatraso:=PLista.diasatraso/PLista.nrobaixas
        else
          mediaatraso:=0;
        if (  (mediavendas>=EdMediavendas.ascurrency) and (mediaatraso<=EdMediaatraso.asinteger) )
//           and ( (mediavendas>0) and (mediaatraso>0) ) )  or
           or
           ( (EdMediavendas.ascurrency=0) and (Edmediaatraso.asinteger=0) )
          then begin
          FRel.AddCel(inttostr(PLista.codigo));
          FRel.AddCel(PLista.nome);
          FRel.AddCel(PLista.clie_endres);
          FRel.AddCel(PLista.clie_bairrores);
          FRel.AddCel(PLista.clie_endcom);
          FRel.AddCel( FGeral.Formatatelefone(PLista.clie_foneres) );
          FRel.AddCel( FGeral.Formatatelefone(PLista.clie_fonecel) );
          FRel.AddCel( FGeral.formatacep(PLista.cep) );
          FRel.AddCel( PLista.clie_cida_nome_res );
          FRel.AddCel(PLista.clie_uf);
          FRel.AddCel(floattostr(PLista.totalvendas));
          FRel.AddCel(floattostr(mediavendas));
          FRel.AddCel(floattostr(mediaatraso));
        end;
    end;
    FRel.Setsort('M�dia Vendas');
    FRel.Video;
    Lista.free;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;

  FRelCadastros_VendasInativos;         // 8

end;


procedure FRelCadastros_EtqVendasInativos;      // 9
type TLista=record
     codigo,diasatraso,nrovendas,nrobaixas:integer;
     totalvendas:currency;
     nome,clie_endres,clie_bairrores,clie_endcom,clie_foneres,clie_fonecel,clie_uf,clie_cida_nome_res,cep:string;

end;

var Q,QMovesto,QPendencias:TSqlquery;
    p,n,v:integer;
    LIsta:Tlist;
    PLista:^TLista;
    Datai,Dataf:TDatetime;
    mediaatraso:currency;
    mediavendas:currency;
    l0,l1,l2,l3,l4,l5:String;

begin

  with FRelCadastros do begin
    if not FRelCadastros_Execute(8) then Exit;
    Sistema.BeginProcess('Checando clientes inativos');
    SetaReprecliente;
    Q:=sqltoquery('select * from clientes where clie_nome is not null '+
                   sqlrepre+sqlcliente+sqlU+
                   ' order by clie_nome');
    if Q.eof then begin
       Avisoerro('Nada encontrado para impress�o');
       Q.close;
       Freeandnil(Q);
       Sistema.EndProcess('');
       exit;
    end;
    if EdDatabase.isempty then begin
      datai:=Datetodatemesant(Sistema.hoje,15);
      dataf:=Datetodatemesant(Sistema.hoje,03);
    end else begin
      datai:=Datetodatemesant(EdDatabase.asdate,15);
      dataf:=Datetodatemesant(EdDatabase.asdate,03);
    end;
    LIsta:=Tlist.create;
    FTextrel.Init(60);

    while not Q.eof do begin
      if ( not (FGeral.EstaAtivo(Q.FieldByName('clie_codigo').Asinteger,'C',Q.FieldByName('clie_dtcad').Asdatetime) ) )
         and ( Q.FieldByName('clie_codigo').Asinteger>0 )  then begin
        New(PLista);
        PLista.codigo:=Q.FieldByName('clie_codigo').Asinteger;
        PLista.diasatraso:=0;
        PLista.nrovendas:=0;
        PLista.nrobaixas:=0;
        PLista.totalvendas:=0;
        PLista.nome:=FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('clie_codigo').asinteger,'C','N');
        PLista.clie_endres:=Q.FieldByName('clie_endres').Asstring;
        PLista.clie_bairrores:=Q.FieldByName('clie_bairrores').Asstring;
        PLista.clie_endcom:=Q.FieldByName('clie_endcom').Asstring;
        PLista.clie_foneres:=Q.fieldbyname('clie_foneres').asstring;
        PLista.clie_fonecel:=Q.fieldbyname('clie_fonecel').asstring;
        PLista.clie_cida_nome_res:=FCidades.GetNome(Q.fieldbyname('clie_cida_codigo_res').asinteger);
        PLista.clie_uf:=Q.fieldbyname('clie_uf').asstring;
        PLista.cep:=Q.fieldbyname('clie_cepres').asstring;
        Lista.Add(PLista);
      end;
      Q.next;
    end;
    Sistema.BeginProcess('Checando vendas');
    for p:=0 to LIsta.count-1 do begin
        PLista:=Lista[p];
        QMovesto:=sqltoquery('select moes_tipo_codigo,moes_tipomov,sum(moes_vlrtotal) as vendas,count(*) as nrovendas from movesto'+
                              ' where moes_tipo_codigo='+inttostr(Plista.codigo)+' and moes_tipocad=''C'''+
                              ' and moes_datamvto>='+Datetosql(datai)+
                              ' and moes_datamvto<='+Datetosql(dataf)+
                              ' and moes_status<>''C'''+
                              ' and '+FGeral.Getin('moes_tipomov',Global.TiposRelVenda+';'+Global.TiposRelDevVenda,'C')+
                              ' group by moes_tipo_codigo,moes_tipomov' );
        while not QMovesto.eof do begin
          if pos(QMovesto.fieldbyname('moes_tipomov').asstring,Global.TiposRelDevVenda)>0 then begin
            Plista.totalvendas:=Plista.totalvendas-QMovesto.fieldbyname('vendas').asinteger;
          end else begin
            Plista.nrovendas:=Plista.nrovendas+QMovesto.fieldbyname('nrovendas').asinteger;
            Plista.totalvendas:=Plista.totalvendas+QMovesto.fieldbyname('vendas').asinteger;
          end;
          QMovesto.Next;
        end;
        FGeral.Fechaquery(QMovesto);
    end;
    Sistema.BeginProcess('Checando pendencias financeiras');
    for p:=0 to LIsta.count-1 do begin
        PLista:=Lista[p];
        QPendencias:=sqltoquery('select pend_tipo_codigo,sum(pend_databaixa-pend_datavcto) as diasatraso,count(*) as nrobaixas from pendencias'+
                              ' where pend_tipo_codigo='+inttostr(Plista.codigo)+' and pend_tipocad=''C'''+
                              ' and pend_databaixa>='+Datetosql(datai)+
                              ' and pend_databaixa<='+Datetosql(dataf)+
                              ' and pend_databaixa>pend_datavcto'+
                              ' group by pend_tipo_codigo' );
        while not QPendencias.eof do begin
          Plista.diasatraso:=Plista.diasatraso+QPendencias.fieldbyname('diasatraso').asinteger;
          Plista.nrobaixas:=Plista.nrobaixas+QPendencias.fieldbyname('nrobaixas').asinteger;
          QPendencias.Next;
        end;
        FGeral.Fechaquery(QPendencias);
    end;
    Sistema.BeginProcess('Gerando Relat�rio');
    n:=0;v:=0;
    for p:=0 to LIsta.count-1 do begin
        PLista:=Lista[p];
        if PLista.nrovendas>0 then
          mediavendas:=PLista.totalvendas/PLista.nrovendas
        else
          mediavendas:=0;
        if PLista.nrobaixas>0 then
          mediaatraso:=PLista.diasatraso/PLista.nrobaixas
        else
          mediaatraso:=0;
        if (  (mediavendas>=EdMediavendas.ascurrency) and (mediaatraso<=EdMediaatraso.asinteger) )
//           and ( (mediavendas>0) and (mediaatraso>0) ) )  or
            or
           ( (EdMediavendas.ascurrency=0) and (Edmediaatraso.asinteger=0) )
          then begin


                 Inc(n);
                  l1:=l1+strspace(Uppercase(PLista.nome),43)+space(3);
                  l2:=l2+strspace(PLista.clie_endres,43)+space(3);
                  l3:=l3+strspace(PLista.clie_bairrores,43)+space(3);
                  l4:=l4+strspace(PLista.clie_cida_nome_res+'/'+PLista.clie_uf,43)+space(3);
                  l5:=l5+strspace(FGeral.formatacep(PLista.cep),43)+space(3);
                  if n=3 then begin
                    Ftextrel.AddLinha(l0,false,false,true );
                    Ftextrel.AddLinha(l1,false,false,true );
                    Ftextrel.AddLinha(l2,false,false,true );
                    Ftextrel.AddLinha(l3,false,false,true );
                    Ftextrel.AddLinha(l4,false,false,true );
                    Ftextrel.AddLinha(l5,false,false,true );
                    n:=0;
                    l0:='';l1:='';l2:='';l3:='';l4:='';l5:='';
                    Inc(v);
                    if v=10 then begin
                      Ftextrel.Saltalinha(1);
                      v:=0
                    end;
                  end;



        end;
    end;

    if n<3 then begin
                    Ftextrel.AddLinha(l0,false,false,true );
                    Ftextrel.AddLinha(l1,false,false,true );
                    Ftextrel.AddLinha(l2,false,false,true );
                    Ftextrel.AddLinha(l3,false,false,true );
                    Ftextrel.AddLinha(l4,false,false,true );
                    Ftextrel.AddLinha(l5,false,false,true );
    end;


    FTextRel.Video;
    Lista.free;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;

///////////////////////  FRelCadastros_EtqVendasInativos;         // 9

end;


{ TFRelcadastros }


procedure TFRelcadastros.baplicarClick(Sender: TObject);
begin
  if not FRelCadastros.EdRepre.ValidEdiAll(FRelCadastros,99) then exit;
  Saiok:=true;
  close;

end;

procedure TFRelcadastros.FormActivate(Sender: TObject);
begin
   FRelCadastros.EdRepre.setfirsted;
end;

procedure TFRelcadastros.EdClienteExitEdit(Sender: TObject);
begin
   baplicarclick(FRElcadastros);
end;

procedure TFRelcadastros.EdDatafExitEdit(Sender: TObject);
begin
  baplicarclick(FRelcadastros);

end;

function TFRelcadastros.EstaValendo(Cliente: integer): boolean;
begin
   result:=true;
   if (pos(EdAtivos.text,'A')>0) and (FGeral.EstaAtivo(cliente,'C') ) then
     result:=true
   else if (pos(EdAtivos.text,'T')>0)   then
     result:=true
   else if (pos(EdAtivos.text,'A/T')=0) and ( not FGeral.EstaAtivo(cliente,'C') ) then
     result:=true
   else
     result:=false;
end;

function TFRelcadastros.GetTitAtivos: string;
begin
 if FRelcadastros.EdAtivos.text='T' then
   result:=' - Todos'
 else if FRelcadastros.EdAtivos
 .text='A' then
   result:=' - Somente Ativos'
 else
   result:=' - Somente Inativos'

end;

// 03.05.13
procedure FRelCadastros_LimiteDisponivel;      // 10
//////////////////////////////////////////////////////
begin

  with FRelCadastros do begin
    if not FRelCadastros_Execute(10) then Exit;
    SetaReprecliente;
    Sistema.BeginProcess('Gerando Relat�rio');
    Q:=sqltoquery('select * from clientes where clie_nome is not null '+
                   sqlcliente+sqlrepre+sqlusuario+sqlU+
                   ' and clie_limcredito > 0 '+
                   ' order by clie_nome');
    if Q.eof then begin
       Avisoerro('Nada encontrado para impress�o');
       Q.close;
       Freeandnil(Q);
       Sistema.EndProcess('');
       exit;
    end;
    FRel.Init('RelLimteDisponivel');
    FRel.AddTit('Rela��o de Clientes com Limite Dispon�vel no Momento '+GetTitAtivos );
    if not EdREpre.isempty then
      FRel.AddTit('Representante : '+EdRepre.text+' - '+Setedclie_nome.text );
    if not Edusua_codigo.isempty then
      FRel.AddTit('Usu�rio : '+Edusua_codigo.text+' - '+Edusua_nome.text );
    FRel.AddCol( 60,3,'N','' ,''              ,'Codigo'          ,''         ,'',false);
    FRel.AddCol(220,0,'C','' ,''              ,'Nome'           ,''         ,'',false);
    FRel.AddCol( 40,3,'N','' ,''              ,'Repr.'           ,''         ,'',false);
    FRel.AddCol(120,0,'C','' ,''              ,'Nome repr.'     ,''         ,'',false);
    FRel.AddCol( 80,1,'C','' ,''              ,'Telefone'        ,''         ,'',false);
    FRel.AddCol( 80,1,'C','' ,''              ,'Celular'         ,''         ,'',false);
    FRel.AddCol(120,1,'C','' ,''              ,'Cidade'          ,''         ,'',false);
    FRel.AddCol( 40,1,'C','' ,''              ,'Estado'          ,''         ,'',false);
    FRel.AddCol(100,3,'N','' ,''              ,'Lim.Dispon�vel'  ,''         ,'',false);
    FRel.AddCol(100,3,'N','' ,''              ,'Lim.Atual'       ,''         ,'',false);
    if Edusua_codigo.isempty then begin
      FRel.AddCol( 40,3,'N','' ,''              ,'Usu�rio'           ,''         ,'',false);
      FRel.AddCol(120,0,'C','' ,''              ,'Nome Usu�rio'     ,''         ,'',false);
    end;
    while not Q.eof do begin
      if Estavalendo(Q.fieldbyname('clie_codigo').asinteger) then begin
        FRel.AddCel(Q.fieldbyname('clie_codigo').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('clie_codigo').asinteger,'C','N'));
        FRel.AddCel(Q.fieldbyname('clie_repr_codigo').asstring);
        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('clie_repr_codigo').asinteger,'R','N'));
        FRel.AddCel( FGeral.Formatatelefone(Q.fieldbyname('clie_foneres').asstring));
        FRel.AddCel( FGeral.Formatatelefone(Q.fieldbyname('clie_fonecel').asstring));
        FRel.AddCel( FCidades.GetNome(Q.fieldbyname('clie_cida_codigo_res').asinteger));
        FRel.AddCel(Q.fieldbyname('clie_uf').asstring);
        FRel.AddCel( FGeral.Formatavalor(FGeral.LimiteDisponivel(Q.fieldbyname('clie_codigo').asinteger),f_cr) );
        FRel.AddCel( FGeral.Formatavalor(Q.fieldbyname('Clie_limcredito').ascurrency,f_cr) );
        if Edusua_codigo.isempty then begin
          FRel.AddCel(Q.fieldbyname('clie_usua_codigo').asstring);
          FRel.AddCel(Fusuarios.GetNome(Q.fieldbyname('clie_usua_codigo').asinteger));
        end;
      end;
      Q.next;
    end;
    FRel.Video;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);
  end;

  FRelCadastros_LimiteDisponivel;      // 10

end;


procedure TFRelcadastros.EdqtdeExitEdit(Sender: TObject);
begin
  baplicarclick(self);
end;

procedure TFRelcadastros.EdSituacaoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////////////
begin
  sqlsituacao:='';
  if not Edsituacao.isempty then
    if EdSituacao.text<>'T' then
      sqlsituacao:=' and clie_situacao='+Edsituacao.assql;
end;

procedure TFRelcadastros.EdUsua_codigoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////
begin
  sqlusuario:='';
  if not EdUsua_codigo.IsEmpty then sqlusuario:=' and clie_usua_codigo='+EdUsua_codigo.assql;
end;

end.
