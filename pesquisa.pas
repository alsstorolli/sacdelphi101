unit pesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel, ExtCtrls,
  SQLGrid, SqlExpr;

type
  TFPesquisa01 = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    SQLPanelGrid2: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bgravar: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bExcluir: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PAcerto: TSQLPanelGrid;
    Edtipo_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdData: TSQLEd;
    EdNumeroDoc: TSQLEd;
    Edperg01: TSQLEd;
    EdPerg02: TSQLEd;
    Edperg03: TSQLEd;
    Edperg04: TSQLEd;
    brelat: TSQLBtn;
    procedure EdNumeroDocValidate(Sender: TObject);
    procedure Edperg04ExitEdit(Sender: TObject);
    procedure bgravarClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure Edperg01Validate(Sender: TObject);
    procedure EdNumeroDocExitEdit(Sender: TObject);
    procedure brelatClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(codigo:integer=0);
  end;

var
  FPesquisa01: TFPesquisa01;
  Q:TSqlquery;
  fechar:boolean;


implementation


uses Sqlsis, Geral, Sqlfun , SQLRel, cadcli;


{$R *.dfm}

{ TFPesquisa01 }

procedure TFPesquisa01.Execute(codigo: integer);
begin
   EdData.setdate(sistema.hoje);
   Show;
   if codigo>0 then  begin
     Pacerto.enabled:=false;
     Edtipo_codigo.setvalue(codigo);
     EdTipo_codigo.validfind;
     EdPerg01.setfocus;
     EdNumerodoc.enabled:=false;
     Fechar:=true;
   end else begin
     Edtipo_codigo.setvalue(0);
     Pacerto.enabled:=true;
     EdNumerodoc.enabled:=true;
     EdTipo_codigo.setfocus;
     Fechar:=false;
   end;

end;

procedure TFPesquisa01.EdNumeroDocValidate(Sender: TObject);

     procedure QuerytoEdits;
     begin
//        EdPerg01.text:=Q.fieldbyname('mpes_pergunta1').asstring;
        EdPerg01.text:=Q.fieldbyname('mpes_resposta1').asstring;
        EdPerg02.text:=Q.fieldbyname('mpes_obs2').asstring;
        EdPerg03.text:=Q.fieldbyname('mpes_obs3').asstring;
        EdPerg04.text:=Q.fieldbyname('mpes_obs4').asstring;
     end;


begin
  if EdNumerodoc.isempty then
     EdNumerodoc.setvalue(FGEral.Getcontador('PESQUISA01',false))
  else begin
    Sistema.beginprocess('Checando pesquisa nesta data');
    Q:=sqltoquery('select * from movpesquisas'+
            ' where mpes_status=''N'''+
            ' and mpes_datamvto='+EdData.AsSql+
            ' and mpes_tipo_codigo='+EdTipo_codigo.assql+
            ' and mpes_seq='+EdNUmerodoc.AsSql );
    Sistema.endprocess('');
    if not Q.eof then
      QueryToEdits;
    Q.close;
    Freeandnil(Q);
  end;

end;

procedure TFPesquisa01.Edperg04ExitEdit(Sender: TObject);
begin
  bgravarclick(FPesquisa01);  
end;

procedure TFPesquisa01.bgravarClick(Sender: TObject);
begin
   if not confirma('Confirma informações ?') then exit;
   Sistema.beginprocess('Gravando');
   if Q<>nil then begin
     Sistema.edit('Movpesquisas');
   end else begin
     Sistema.insert('Movpesquisas');
     Sistema.setfield('mpes_status','N');
     Sistema.setfield('mpes_seq',EdNumerodoc.text);
     Sistema.setfield('mpes_tipo_codigo',Edtipo_codigo.asinteger);
     Sistema.setfield('mpes_tipocad','C');
     Sistema.setfield('mpes_datalcto',Sistema.hoje);
     Sistema.setfield('mpes_datamvto',Eddata.asdate);
   end;
   Sistema.setfield('mpes_pergunta1',EdPerg01.Title);
   Sistema.setfield('mpes_resposta1',EdPerg01.text);
   Sistema.setfield('mpes_obs1','');
   Sistema.setfield('mpes_pergunta2',EdPerg02.Title);
   Sistema.setfield('mpes_resposta2','');  // varchar(1),
   Sistema.setfield('mpes_obs2',EdPerg02.text);
   Sistema.setfield('mpes_pergunta3',EdPerg03.Title);
   Sistema.setfield('mpes_resposta3','');
   Sistema.setfield('mpes_obs3',EdPerg03.text);
   Sistema.setfield('mpes_pergunta4',EdPerg04.Title);
   Sistema.setfield('mpes_resposta4','');
   Sistema.setfield('mpes_obs4',EdPerg04.text);
   Sistema.setfield('mpes_usua_codigo',global.usuario.codigo);
   if Q=nil then begin
     Sistema.post;
   end else begin
    Sistema.post('mpes_status=''N'' and mpes_seq='+EdNumerodoc.assql+' and mpes_datamvto='+EdData.assql+
                 'and mpes_tipo_codigo='+Edtipo_codigo.assql );
   end;
   Sistema.commit;
   Sistema.endprocess('Gravado');
   EdPerg01.clearall(FPesquisa01,99);
   EdTipo_codigo.clearall(FPesquisa01,99);
   EdNumerodoc.setvalue(1);
   EdData.setdate(sistema.hoje);
   if fechar then
     Close
   else
     EdTipo_codigo.setfocus;

end;

procedure TFPesquisa01.bExcluirClick(Sender: TObject);
begin
  if EdNumerodoc.isempty then exit;
  if not confirma('Confirma exclusão da pesquisa') then exit;
  Sistema.beginprocess('Excluindo');
  Sistema.Edit('movpesquisas');
  Sistema.setfield('mpes_status','C');
  Sistema.post('mpes_status=''N'' and mpes_seq='+EdNumerodoc.assql+' and mpes_datamvto='+EdData.assql+
               'and mpes_tipo_codigo='+Edtipo_codigo.assql );
  Sistema.commit;
  Sistema.endprocess('Pesquisa excluida');
  EdPerg01.clearall(FPesquisa01,99);
  Edtipo_codigo.setfocus;
end;

procedure TFPesquisa01.bCancelarClick(Sender: TObject);
begin
  EdPerg01.clearall(FPesquisa01,99);
  Edtipo_codigo.setfocus;

end;

procedure TFPesquisa01.Edperg01Validate(Sender: TObject);
begin
  if EdPerg01.text='S' then begin
    EdPerg02.enabled:=true;
  end else begin
    EdPerg02.enabled:=false;
    EdPerg02.text:='';
  end;
end;

procedure TFPesquisa01.EdNumeroDocExitEdit(Sender: TObject);
begin
  EdPerg01.setfocus;
end;

procedure TFPesquisa01.brelatClick(Sender: TObject);
var sql:string;
    Q:Tsqlquery;
begin
   if Sistema.GetPeriodo('Informe o período') then begin
     sistema.beginprocess('Gerando relatório');
     sql:='select * from movpesquisas where mpes_datamvto>='+Datetosql(sistema.datai)+' and mpes_datamvto<='+Datetosql(sistema.dataf)+' order by mpes_datamvto' ;
     Q:=sqltoquery(sql);
     if Q.eof then begin
       Avisoerro('Nada encontrado');
       sistema.endprocess('');
       exit;
     end;
//     FRel.ReportFromSQL(sql,'RelPesquisas','Relatório de Pesquisas','','');
     FRel.init('RelPesquisas');
     FREl.AddTit('Relatório de Pesquisa - Período : '+formatdatetime('dd/mm/yy',sistema.datai)+' a '+formatdatetime('dd/mm/yy',sistema.dataf));
     FRel.AddCol( 60,0,'D','' ,''              ,'Data'         ,''         ,'',false);
     FRel.AddCol( 60,0,'N','' ,''              ,'Número'         ,''         ,'',false);
     FRel.AddCol( 40,0,'C','' ,''              ,'Codigo'            ,''         ,'',False);
     FRel.AddCol(120,0,'N','' ,''              ,'Cliente'         ,''         ,'',False);
     FRel.AddCol(120,0,'C','' ,''              ,'Pergunta 1'         ,''         ,'',false);
     FRel.AddCol( 60,0,'C','' ,''              ,'Resposta 1'       ,''         ,'',false);
     FRel.AddCol(120,0,'C','' ,''              ,'Pergunta 2'         ,''         ,'',false);
     FRel.AddCol( 90,0,'C','' ,''              ,'Resposta 2'       ,''         ,'',false);
     FRel.AddCol(150,0,'C','' ,''              ,'Pergunta 3'         ,''         ,'',false);
     FRel.AddCol( 90,0,'C','' ,''              ,'Resposta 3'       ,''         ,'',false);
     FRel.AddCol(150,0,'C','' ,''              ,'Pergunta 4'         ,''         ,'',false);
     FRel.AddCol( 90,0,'C','' ,''              ,'Resposta 4'       ,''         ,'',false);
     while not Q.eof do begin
       FRel.AddCel(Q.fieldbyname('mpes_datamvto').asstring);
       FRel.AddCel(Q.fieldbyname('mpes_seq').asstring);
       FRel.AddCel(Q.fieldbyname('mpes_tipo_codigo').asstring);
       FRel.AddCel(FCadcli.GetNome(Q.fieldbyname('mpes_tipo_codigo').asinteger));
       FRel.AddCel(Q.fieldbyname('mpes_pergunta1').asstring);
       FRel.AddCel(Q.fieldbyname('mpes_resposta1').asstring);
       FRel.AddCel(Q.fieldbyname('mpes_pergunta2').asstring);
       FRel.AddCel(Q.fieldbyname('mpes_obs2').asstring);
       FRel.AddCel(Q.fieldbyname('mpes_pergunta3').asstring);
       FRel.AddCel(Q.fieldbyname('mpes_obs3').asstring);
       FRel.AddCel(Q.fieldbyname('mpes_pergunta4').asstring);
       FRel.AddCel(Q.fieldbyname('mpes_obs4').asstring);
       Q.Next;
     end;
     FRel.Video;
     sistema.endprocess('');
   end;
end;

end.
