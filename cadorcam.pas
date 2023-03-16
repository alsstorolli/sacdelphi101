unit cadorcam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SQLGrid, StdCtrls, Mask, SQLEd, Buttons,
  SQLBtn, alabel, ExtCtrls, SqlExpr, Vcl.Menus,SimpleDS,
//  dbf,
//  Menus,
   Sqlsis, Datasnap.DBClient;

type
  TFOrcamentos = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bSair: TSQLBtn;
    bEditar: TSQLBtn;
    bExcluir: TSQLBtn;
    bcancelar: TSQLBtn;
    bPesquisar: TSQLBtn;
    brelatorio: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PGrid: TSQLPanelGrid;
    PEdits: TSQLPanelGrid;
    XGrid: TSQLGrid;
    DSOrcamentos: TDataSource;
    EdOrca_numerodoc: TSQLEd;
    EdOrca_status: TSQLEd;
    EdOrca_situacao: TSQLEd;
    EdOrca_unid_codigo: TSQLEd;
    EdOrca_tipo_codigo: TSQLEd;
    EdOrca_tipocad: TSQLEd;
    EdOrca_repr_codigo: TSQLEd;
    EdOrca_datalcto: TSQLEd;
    EdOrca_datamvto: TSQLEd;
    EdOrca_dataretorno: TSQLEd;
    EdOrca_cliente1: TSQLEd;
    EdOrca_cliente2: TSQLEd;
    EdOrca_obra: TSQLEd;
    EdOrca_linha: TSQLEd;
    EdOrca_area: TSQLEd;
    EdOrca_peso: TSQLEd;
    EdOrca_valor: TSQLEd;
    EdOrca_datafecha: TSQLEd;
    EdOrca_obs: TSQLEd;
    EdOrca_usua_codigo: TSQLEd;
    balterar: TSQLBtn;
    EdOrca_fone: TSQLEd;
    EdOrca_celular: TSQLEd;
    borcamento: TSQLBtn;
    EdNomeorcam: TSQLEd;
    EdOrca_nroobra: TSQLEd;
//    dbforcam: TDbf;
//    dbforcam: TSimpleDataSet;
    Edorca_dtprevisaoent: TSQLEd;
    Edorca_dtentrega: TSQLEd;
    MenuRel: TPopupMenu;
    Oramentos1: TMenuItem;
    AnliseEntrega1: TMenuItem;
    EdRepr_codigo: TSQLEd;
    SQLEd3: TSQLEd;
    Label1: TLabel;
    Label2: TLabel;
    Edorca_enderecocli: TSQLEd;
    EdOrca_tipoobra: TSQLEd;
    Edorca_pavimentos: TSQLEd;
    Edorca_dtidenti: TSQLEd;
    Edorca_vidrotemp: TSQLEd;
    Edorca_vidrolami: TSQLEd;
    Edorca_vidromono: TSQLEd;
    Edorca_vidroinsu: TSQLEd;
    Edorca_potpeso: TSQLEd;
    Edorca_potarea: TSQLEd;
    Edorca_potmoeda: TSQLEd;
    Edorca_tipovenda: TSQLEd;
    Edorca_motivorej: TSQLEd;
    Bevel1: TBevel;
    Edorca_nomeesp: TSQLEd;
    Edorca_empresaesp: TSQLEd;
    Edorca_enderecoesp: TSQLEd;
    Edorca_foneesp: TSQLEd;
    Edorca_fonecomesp: TSQLEd;
    Bevel2: TBevel;
    Edorca_nomerespcon: TSQLEd;
    Edorca_empresacon: TSQLEd;
    Edorca_enderecocon: TSQLEd;
    Edorca_fonecon: TSQLEd;
    Edorca_fonecomcon: TSQLEd;
    PorCidade1: TMenuItem;
    EdOrca_cida_codigo: TSQLEd;
    EdMuniRes_Nome: TSQLEd;
    Label3: TLabel;
    bcopia: TSQLBtn;
    EdNobra: TSQLEd;
    EdOrca_dtprevfecha: TSQLEd;
    EdOrca_prodser: TSQLEd;
    dbforcam: TSimpleDataSet;
    procedure bIncluirClick(Sender: TObject);
    procedure bEditarClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure EdOrca_tipo_codigoValidate(Sender: TObject);
    procedure EdOrca_dataretornoValidate(Sender: TObject);
    procedure EdOrca_datafechaValidate(Sender: TObject);
    procedure EdOrca_obsExitEdit(Sender: TObject);
    procedure bcancelarClick(Sender: TObject);
    procedure brelatorioClick(Sender: TObject);
    procedure borcamentoClick(Sender: TObject);
    procedure XGridNewRecord(Sender: TObject);
    procedure EdNomeorcamExitEdit(Sender: TObject);
    procedure EdNomeorcamKeyPress(Sender: TObject; var Key: Char);
    procedure EdOrca_nroobraValidate(Sender: TObject);
    procedure Oramentos1Click(Sender: TObject);
    procedure AnliseEntrega1Click(Sender: TObject);
    procedure EdOrca_situacaoValidate(Sender: TObject);
    procedure Edorca_fonecomespValidate(Sender: TObject);
    procedure Edorca_fonecomconValidate(Sender: TObject);
    procedure EdOrca_celularValidate(Sender: TObject);
    procedure PorCidade1Click(Sender: TObject);
    procedure bcopiaClick(Sender: TObject);
    procedure EdNobraExitEdit(Sender: TObject);
    procedure EdNobraKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure ChecaRetornos;
    procedure SetaSituacao(Ed:TSqled);
    procedure SetaTipoObra(Ed:TSqled);
    procedure SetaLinha(Ed:TSqled);
    procedure SetaMotivoRejeicao(Ed:TSqled);
    function GetSituacao(situacao:string):string;
    procedure SetaMidia(Ed:TSqled);

  end;

var
  FOrcamentos: TFOrcamentos;
  Qc:TSqlquery;
  Op,selectemaberto,localexterno,obra:string;
  campo:TDicionario;


implementation

uses Arquiv, SqlFun , Geral , SQLRel, formacaopreco, munic;

{$R *.dfm}


procedure TFOrcamentos.bIncluirClick(Sender: TObject);
begin
  Op:='I';
  PEdits.visible:=true;
  PEdits.Enabled:=true;
  balterar.enabled:=false;
  bexcluir.enabled:=false;
  bsair.enabled:=false;
  EdOrca_Numerodoc.ClearAll(FOrcamentos,99);
  Edorca_datamvto.setdate(sistema.hoje);
  EdOrca_situacao.setfocus;

end;

procedure TFOrcamentos.bEditarClick(Sender: TObject);
begin
  Op:='E';
  PEdits.visible:=true;
  PEdits.Enabled:=true;
  bincluir.enabled:=false;
  bexcluir.enabled:=false;
  bsair.enabled:=false;
  XGrid.enabled:=false;
  EdOrca_numerodoc.GetFields(FOrcamentos,99);
  EdOrca_Situacao.setfocus;

end;

procedure TFOrcamentos.bExcluirClick(Sender: TObject);
begin
     if confirma('Confirma exclusão ?') then begin
       EdOrca_numerodoc.GetFields(FOrcamentos,99);
       sistema.beginprocess('excluindo');
       ExecuteSql('Update orcamentos set orca_status=''C'' where orca_status=''N'''+
                  ' and orca_numerodoc='+EdOrca_numerodoc.AsSql+
                  ' and orca_unid_codigo='+Edorca_unid_codigo.AsSql );
       Arq.TOrcamentos.close;
       Arq.TOrcamentos.open;
       sistema.endprocess('');
     end;

end;

procedure TFOrcamentos.EdOrca_tipo_codigoValidate(Sender: TObject);
begin
  if EdOrca_tipo_codigo.isempty then begin
    exit;
  end;
  if not Arq.TClientes.active then Arq.TClientes.open;
  if not Arq.TClientes.locate('clie_codigo',EdOrca_tipo_codigo.text,[]) then
    EdOrca_tipo_codigo.invalid('Codigo de cliente não encontrado')
  else begin
// 02.01.12 - Abra - Adriano
//    if OP='I' then begin
// 30.10.13 - Metalforte
    if EdOrca_enderecocli.IsEmpty then begin
      EdOrca_cliente1.text:=Arq.TClientes.fieldbyname('clie_nome').asstring;
      EdOrca_enderecocli.text:=Arq.TClientes.fieldbyname('clie_endres').asstring;
      EdOrca_fone.text:=Arq.TClientes.fieldbyname('clie_foneres').asstring;
      EdOrca_celular.text:=Arq.TClientes.fieldbyname('clie_fonecel').asstring;
      if EdOrca_tipo_codigo.asinteger>0 then
        EdRepr_codigo.setvalue( EdOrca_tipo_codigo.ResultFind.fieldbyname('clie_repr_codigo').asinteger );
    end;
  end;
end;

procedure TFOrcamentos.EdOrca_dataretornoValidate(Sender: TObject);
begin
    if EdOrca_dataretorno.isempty then exit;
//    if EdOrca_dataretorno.asdate<EdOrca_datamvto.asdate then
//      EdOrca_dataretorno.Invalid('Data de retorno tem que ser posterior a data do movimento');
end;

procedure TFOrcamentos.EdOrca_datafechaValidate(Sender: TObject);
begin
    if EdOrca_datafecha.isempty then exit;
    if EdOrca_datafecha.asdate<EdOrca_datamvto.asdate then
      EdOrca_dataretorno.Invalid('Data de fechamento tem que ser posterior a data do movimento');

end;

procedure TFOrcamentos.Execute;
/////////////////////////////////////////////////////////
var xcondicao,sqlusuario,titulo:string;
begin

  selectemaberto:='select * from orcamentos '+
                   ' where orca_status=''N'''+
                   ' order by orca_dataretorno';
  xcondicao:='orca_status=''N''';
  sqlusuario:=' and orca_usua_codigo='+inttostr(Global.Usuario.Codigo);
  titulo:=' - Usuário '+inttostr(Global.Usuario.Codigo)+' '+Global.Usuario.Nome;
  if Global.Usuario.OutrosAcessos[0048] then begin
    sqlusuario:='';
    titulo:='';
  end;
  Arq.TOrcamentos.condicao:='orca_status=''N'''+sqlusuario;
  sistema.beginprocess('Abrindo arquivo de orçamentos');
  if not Arq.TOrcamentos.active then begin
    Arq.TOrcamentos.CommandText:=selectemaberto;
    Arq.TOrcamentos.open;
  end else
    Arq.TOrcamentos.refresh;
  FGeral.ColunasGrid(xGrid,Self);
  sistema.endprocess('');
  SetaSituacao(EdOrca_situacao);
  SetaTipoObra(EdOrca_tipoobra);
  SetaLinha(EdOrca_linha);
  SetaMidia(EdOrca_obra);
// 25.08.10 - Abra - cavalo....
  SetaMotivoRejeicao(Edorca_motivorej);
  Show;
  Caption:='Controle de Orçamentos '+titulo;
  EdNomeOrcam.enabled:=false;
  EdNomeOrcam.Visible:=false;
  Edorca_motivorej.enabled:=false;
  campo:=Sistema.GetDicionario('orcamentos','Orca_prodser');
  if campo.Tipo<>'' then begin
    EdOrca_prodser.Enabled:=true;
    EdOrca_prodser.TableName:='orcamentos';
  end else begin
    EdOrca_prodser.Enabled:=false;
    EdOrca_prodser.TableName:='';
  end;
end;

procedure TFOrcamentos.EdOrca_obsExitEdit(Sender: TObject);
//////////////////////////////////////////////////////////////
var msg:string;
begin
  msg:='Confirma informações ? ';
  if confirma(msg) then begin
    if (OP='I')  then
      Sistema.Insert('Orcamentos')
    else
      Sistema.Edit('Orcamentos');
    if (OP='I')  then begin
      Edorca_Numerodoc.setvalue( FGeral.GetContador('CADORCA',false) );
      Sistema.Setfield('orca_status','N');
      Sistema.Setfield('orca_numerodoc',Edorca_Numerodoc.Text);
      Sistema.Setfield('orca_datamvto',Edorca_datamvto.AsDate);
    end;
    Sistema.Setfield('orca_situacao',EdOrca_situacao.text);
    Sistema.Setfield('orca_tipo_codigo',EdOrca_tipo_codigo.asinteger);
    Sistema.Setfield('orca_tipocad','C');
    Sistema.Setfield('orca_cliente1',EdOrca_cliente1.Text);
    Sistema.Setfield('orca_cliente2',EdOrca_cliente2.Text);
    Sistema.Setfield('orca_dataretorno',EdOrca_dataretorno.AsDate);
    Sistema.Setfield('orca_valor',EdOrca_valor.ascurrency);
//    if EdOrca_tipo_codigo.asinteger>0 then
//    Sistema.Setfield('orca_repr_codigo',EdOrca_tipo_codigo.ResultFind.fieldbyname('clie_repr_codigo').asinteger);
// 30.03.09
    Sistema.Setfield('orca_repr_codigo',EdRepr_codigo.asinteger);
    Sistema.Setfield('orca_datafecha',EdOrca_datafecha.asdate);
    Sistema.Setfield('orca_obra',EdOrca_obra.Text);
    if OP='I' then
      Sistema.Setfield('orca_datalcto',Sistema.hoje);
    Sistema.Setfield('orca_obs',Edorca_obs.text);
    Sistema.Setfield('orca_linha',Edorca_linha.text);
    Sistema.Setfield('orca_unid_codigo',Global.codigounidade);
    Sistema.Setfield('orca_area',EdOrca_area.AsFloat);
    Sistema.Setfield('orca_peso',EdOrca_peso.AsFloat);
    Sistema.Setfield('orca_valor',EdOrca_valor.AsCurrency);
    Sistema.Setfield('orca_datafecha',EdOrca_datafecha.AsDate);
    Sistema.Setfield('orca_fone',EdOrca_fone.text);
    Sistema.Setfield('orca_celular',EdOrca_celular.text);
    Sistema.Setfield('orca_usua_codigo',Global.Usuario.Codigo);
    Sistema.Setfield('orca_nroobra',EdOrca_nroobra.Text);
// 13.04.09
    Sistema.Setfield('orca_enderecocli',Edorca_enderecocli.Text);

    Sistema.Setfield('orca_nomeesp',Edorca_nomeesp.Text);
    Sistema.Setfield('orca_empresaesp',Edorca_empresaesp.Text);
    Sistema.Setfield('orca_enderecoesp',Edorca_enderecoesp.Text);
    Sistema.Setfield('orca_foneesp',Edorca_foneesp.Text);
    Sistema.Setfield('orca_fonecomesp',Edorca_fonecomesp.Text);

    Sistema.Setfield('orca_nomerespcon',Edorca_nomerespcon.Text);
    Sistema.Setfield('orca_empresacon',Edorca_empresacon.Text);
    Sistema.Setfield('orca_enderecocon',Edorca_enderecocon.Text);
    Sistema.Setfield('orca_fonecon',Edorca_fonecon.Text);
    Sistema.Setfield('orca_fonecomcon',Edorca_fonecomcon.Text);
    Sistema.Setfield('orca_tipoobra',Edorca_tipoobra.Text);
    Sistema.Setfield('orca_pavimentos',Edorca_pavimentos.AsInteger);
    Sistema.Setfield('orca_dtidenti',Edorca_dtidenti.Asdate);
    Sistema.Setfield('orca_vidrotemp',Edorca_vidrotemp.AsCurrency);
    Sistema.Setfield('orca_vidrolami',Edorca_vidrolami.AsCurrency);
    Sistema.Setfield('orca_vidromono',Edorca_vidromono.AsCurrency);
    Sistema.Setfield('orca_vidroinsu',Edorca_vidroinsu.AsCurrency);
    Sistema.Setfield('orca_potpeso',Edorca_potpeso.AsCurrency);
    Sistema.Setfield('orca_potarea',Edorca_potarea.AsCurrency);
    Sistema.Setfield('orca_potmoeda',Edorca_potmoeda.AsCurrency);
    Sistema.Setfield('orca_motivorej',Edorca_motivorej.Text);
    Sistema.Setfield('orca_tipovenda',Edorca_tipovenda.Text);
    Sistema.Setfield('orca_cida_codigo',Edorca_cida_codigo.AsInteger);
// 13.12.10
    Sistema.Setfield('orca_dtprevfecha',EdOrca_dtprevfecha.asdate);
// 09.06.11
    if campo.Tipo<>'' then
      Sistema.Setfield('Orca_prodser',EdOrca_prodser.text);


    if (OP='I')  then begin
      Sistema.Post;
    end else begin
      Sistema.Post('orca_status=''N'''+
                   ' and orca_numerodoc='+EdOrca_numerodoc.AsSql );
//      Editstogrid;
    end;

    Sistema.beginprocess('Gravando informações');
    Sistema.Commit;
    Arq.TOrcamentos.Refresh;

    Sistema.endprocess('');

    EdOrca_situacao.ClearAll(FOrcamentos,99);
    EdOrca_datamvto.setdate(sistema.hoje);
    EdOrca_situacao.setfocus;
  end;

end;

procedure TFOrcamentos.bcancelarClick(Sender: TObject);
begin
  PEdits.enabled:=false;
  PEdits.visible:=false;
  EdOrca_Situacao.ClearAll(FOrcamentos,99);
  bincluir.enabled:=true;
  balterar.enabled:=true;
  bexcluir.enabled:=true;
  bsair.enabled:=true;
  xGrid.enabled:=true;
  XGrid.Restaure;
  xGrid.SetFocus;


end;

procedure TFOrcamentos.brelatorioClick(Sender: TObject);
begin
//   FRel.ReportFromGrid(xGrid,'RelOrcamentos','Relação de Orçamentos','','');
  MenuRel.Popup(Self.Left+620,Self.Top+228);
end;

procedure TFOrcamentos.ChecaRetornos;
var xcondicao:string;
begin

  xcondicao:='orca_status=''N'' and orca_situacao=''E'' and orca_dataretorno='+Datetosql(sistema.hoje);
  sistema.beginprocess('Abrindo arquivo de orçamentos');
  if Arq.TOrcamentos.active then
    Arq.TOrcamentos.close;
  Arq.TOrcamentos.OpenWith(xcondicao,'orca_dataretorno');
  sistema.endprocess('');
  if not Arq.TOrcamentos.eof then
    Show;

//  Execute;
//  Arq.TOrcamentos.Locate('orca_dataretorno',Datetostr(Sistema.hoje),[]);

end;

procedure TFOrcamentos.borcamentoClick(Sender: TObject);
var Q:TSqlquery;
begin
  Edorca_numerodoc.GetFields(FOrcamentos,99);
  if EdOrca_numerodoc.AsInteger=0 then begin
    Avisoerro('Orçamento ainda não gravado');
    exit;
  end;
  Q:=sqltoquery('select orca_numerodoc from orcamentos '+
               ' where orca_status=''N'' and orca_numerodoc='+EdOrca_numerodoc.Assql);
  if Q.eof then begin
    Avisoerro('Orçamento ainda não gravado no banco de dados');
    exit;
  end;
  FGeral.FechaQuery(Q);
  Q:=sqltoquery('select orcc_numerodoc,orcc_nome from orcamencal '+
               ' where orcc_status=''N'' and orcc_numerodoc='+EdOrca_numerodoc.Assql+
//               ' and orcc_unid_codigo='+stringtosql(Global.CodigoUnidade));
// 14.09.10 - pode ver orçammentos(valores) das unidades q pode acessar
//               ' and '+FGeral.GetIN('orcc_unid_codigo',Global.Usuario.UnidadesMvto,'C') );
// 07.04.11 - somente da unidade onde foi incluso o orçamento
               ' and '+FGeral.GetIN('orcc_unid_codigo',Arq.TOrcamentos.FieldByName('orca_unid_codigo').AsString,'C') );
  EdNomeOrcam.Clear;
  EdNomeOrcam.Items.Clear;
  while not Q.eof do begin
    EdNomeOrcam.Items.Add(Q.fieldbyname('orcc_nome').asstring);
    q.Next;
  end;
  FGeral.FechaQuery(Q);
  xgrid.Enabled:=false;
// 04.04.11
  if Global.CodigoUnidade<>Arq.TOrcamentos.FieldByName('orca_unid_codigo').AsString then begin
    Aviso('Não será permitido salvar orçamento fora da unidade onde foi incluido');
  end;

  EdNomeOrcam.enabled:=true;
  EdNomeOrcam.Visible:=true;
  EdNomeOrcam.Refresh;  // ver se aparece o 'title'
  EdNomeOrcam.setfocus;
end;

procedure TFOrcamentos.XGridNewRecord(Sender: TObject);
begin
  campo:=Sistema.GetDicionario('orcamentos','Orca_prodser');
  if campo.Tipo<>'' then begin
    EdOrca_prodser.Enabled:=true;
    EdOrca_prodser.TableName:='orcamentos';
  end else begin
    EdOrca_prodser.Enabled:=false;
    EdOrca_prodser.TableName:='';
  end;
  EdOrca_numerodoc.GetFields(FOrcamentos,99);

end;

procedure TFOrcamentos.EdNomeorcamExitEdit(Sender: TObject);
begin
  EdNomeOrcam.enabled:=false;
  EdNomeOrcam.Visible:=false;
  xgrid.Enabled:=true;
//  FFormacaoPreco.Execute(EdOrca_numerodoc.asinteger,EdNomeOrcam.text,EdOrca_Nroobra.text);
// 15.06.09
//  if confirma('Usar Vims') then
//        obra:='VIMS-'+EdOrca_nroobra.text
//  else
        obra:=EdOrca_nroobra.text;
  if campo.Tipo<>'' then
    FFormacaoPreco.Execute(EdOrca_numerodoc.asinteger,EdNomeOrcam.text,obra,Arq.TOrcamentos.FieldByName('orca_unid_codigo').AsString,Arq.TOrcamentos.FieldByName('orca_prodser').AsString)
  else
    FFormacaoPreco.Execute(EdOrca_numerodoc.asinteger,EdNomeOrcam.text,obra,Arq.TOrcamentos.FieldByName('orca_unid_codigo').AsString,'VP');

end;

procedure TFOrcamentos.EdNomeorcamKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then begin
    EdNomeOrcam.enabled:=false;
    EdNomeOrcam.Visible:=false;
    xgrid.Enabled:=true;
  end;
end;

procedure TFOrcamentos.EdOrca_nroobraValidate(Sender: TObject);

     procedure CamposdbftoEdits;
     ///////////////////////////
     begin
       EdOrca_cliente1.text:=dbforcam.fieldbyname('nomeclient').asstring;
       if copy(dbforcam.fieldbyname('fone_fax').asstring,1,1)='3' then
         EdOrca_fone.text:='46'+FGeral.TiraBarra(copy(dbforcam.fieldbyname('fone_fax').asstring,1,9),'()-')
       else
         EdOrca_fone.text:=FGeral.TiraBarra(copy(dbforcam.fieldbyname('fone_fax').asstring,1,10),'()-');
       if copy(dbforcam.fieldbyname('fax').asstring,1,1)='3' then
         EdOrca_celular.text:='46'+FGeral.TiraBarra(copy(dbforcam.fieldbyname('fax').asstring,1,10),'()-')
       else
         EdOrca_celular.text:=FGeral.TiraBarra(copy(dbforcam.fieldbyname('fax').asstring,1,10),'()-');
//       EdOrca_cliente2.text:=;
// 16.05.12 - as vezes vem do Pea com mais de 50 dai..pssss obra 12-2455-00
       EdOrca_obra.text:=copy(dbforcam.fieldbyname('nomeobra').asstring,1,50);
//       EdOrca_linha.text:=;
//       EdOrca_area.text:= ; // ver se pega de outro dbf
       EdOrca_peso.setvalue(dbforcam.fieldbyname('pesobruto').asfloat);
       EdOrca_obs.text:=dbforcam.fieldbyname('trat_perf').asstring;
     end;

begin

//  if EdOrca_nroobra.isempty then exit;

//  localexterno:=FGeral.Getconfig1asstring('localpea');
// 31.08.09
    if (OP='I') and ( trim(copy(EdOrca_nroobra.text,1,2))<>'' ) then begin
      localexterno:=FGeral.GetLocalExternoPea;
      if trim(localexterno)='' then begin
        EdOrca_nroobra.invalid('Falta configurar o local do PEA na configuração geral do sistema');
        exit;
      end else begin
        dbforcam.FileName:=localexterno+'OBNOMES.DBF';
  //      dbforcam.TableName:=localexterno+'OBITENS.DBF';
        try
          dbforcam.Open;
        except
          EdOrca_nroobra.invalid('Não foi possível abrir arquivo '+dbforcam.FileName);
  //        EdPedido.invalid('Não foi possível abrir arquivo '+dbforcam.TableName);
          exit;
        end;
        EdOrca_nroobra.text:=trim(EdOrca_nroobra.text);
        Sistema.beginprocess('Pesquisando obra '+EdOrca_nroobra.text);
  //      if confirma('Usar Vims') then
  //        obra:='VIMS-'+EdOrca_nroobra.text
  // 28.05.09 - 04.06.09
  //      else
          obra:=EdOrca_nroobra.text;
        while  not dbforcam.Eof do begin
          if dbforcam.FieldByName('codigo').asstring=obra then
            CamposdbftoEdits;
          dbforcam.Next;
        end;
        dbforcam.close;
        Sistema.endprocess('');
      end;
    end;
end;

procedure TFOrcamentos.Oramentos1Click(Sender: TObject);
/////////////////////////////////////////
var sqlaqui,sqldata,ctitulo,cqdata:string;
begin
//   FRel.ReportFromGrid(xGrid,'RelOrcamentos','Relação de Orçamentos','','');
// 28.09.11 - colocado opcao de periodo
   Sistema.GetPeriodo('Informe o perido (vazio pra todos)');
   sqldata:='';ctitulo:='';
   cqdata:='';
   if not Input('Informe qual data','M-Movimento  R-Retorno',cqdata,1,true) then cqdata:='M';
   if ( Datetoano(Sistema.Datai,true)>1901 ) and ( Datetoano(Sistema.Dataf,true)>1901 ) then begin
     if cqdata='M' then begin
       ctitulo:='Período ref. Data de Movimento :'+FGeral.formatadata(Sistema.datai)+' a '+FGeral.formatadata(Sistema.dataf);
       sqldata:=' and orca_datamvto >= '+Datetosql(Sistema.datai)+
              ' and orca_datamvto <= '+Datetosql(Sistema.dataf);
     end else begin
       ctitulo:='Período ref. Data de Retorno :'+FGeral.formatadata(Sistema.datai)+' a '+FGeral.formatadata(Sistema.dataf);
       sqldata:=' and orca_dataretorno >= '+Datetosql(Sistema.datai)+
              ' and orca_dataretorno <= '+Datetosql(Sistema.dataf);
     end;
   end;
   sqlaqui:='select * from orcamentos where orca_status=''N'''+
            sqldata+
            ' order by orca_cliente1';
   FRel.ReportFromSQL(sqlaqui,'RelOrcamentosObra','Relação de Orçamentos',ctitulo,'');

end;

procedure TFOrcamentos.AnliseEntrega1Click(Sender: TObject);
/////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  if not Sistema.GetPeriodo('Infome período de entrega') then exit;
    Q:=sqltoquery('select * from orcamentos where orca_status=''N'''+
                  ' and orca_dtentrega>='+Datetosql(Sistema.Datai)+
                  ' and orca_dtentrega<='+Datetosql(Sistema.Dataf)+
//                  ' and orca_dtentrega>1' );
// 26.09.11
                  ' and orca_dtentrega > '+DatetoSql(Global.DataMenorBanco) );
    FRel.Init('RelAnaliseEntrega');
    FRel.AddTit('Relação de Obras Entregues - Período : '+formatdatetime('dd/mm/yy',Sistema.datai)+' a '+formatdatetime('dd/mm/yy',Sistema.dataf) );
    FRel.AddCol( 70,1,'N','' ,''              ,'Orçamento'        ,''         ,'',false);
    FRel.AddCol( 70,1,'N','' ,''              ,'Numero'        ,''         ,'',false);
    FRel.AddCol(220,0,'C','' ,''              ,'Cliente'           ,''         ,'',false);
    FRel.AddCol(150,1,'C','' ,''              ,'Obra'           ,''         ,'',false);
    FRel.AddCol( 80,1,'N','' ,''              ,'Área'            ,''         ,'',false);
    FRel.AddCol( 80,1,'N','' ,''              ,'Valor'           ,''         ,'',false);
    FRel.AddCol(070,1,'D','' ,''              ,'Previsão'        ,''         ,'',false);
    FRel.AddCol(070,1,'D','' ,''              ,'Entrega'         ,''         ,'',false);
    FRel.AddCol(070,2,'N','&' ,''              ,'Análise'         ,''         ,'',false);
    FRel.AddCol(070,1,'D','' ,''              ,'Identificação'        ,''         ,'',false);
    FRel.AddCol(070,1,'N','' ,''              ,'Comercial'         ,''         ,'',false);
    FRel.AddCol(090,1,'C','' ,''              ,'Status'         ,''         ,'',false);
    while not Q.eof do begin
        FRel.AddCel(Q.fieldbyname('orca_numerodoc').asstring);
        FRel.AddCel( Q.fieldbyname('orca_nroobra').asstring );
        FRel.AddCel( Q.fieldbyname('orca_cliente1').asstring );
//        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('orca_tipo_codigo').asinteger,'C','N'));
        FRel.AddCel(Q.fieldbyname('orca_obra').asstring);
        FRel.AddCel( Q.fieldbyname('orca_area').asstring);
        FRel.AddCel( Q.fieldbyname('orca_valor').asstring);
        FRel.AddCel( FormatDatetime('dd/mm/yy',Q.fieldbyname('orca_dtprevisaoent').asdatetime));
        FRel.AddCel( FormatDatetime('dd/mm/yy',Q.fieldbyname('orca_dtentrega').asdatetime));
        FRel.AddCel( inttostr( abs(trunc(Q.fieldbyname('orca_dtentrega').asdatetime-Q.fieldbyname('orca_dtprevisaoent').asdatetime)) ) );
        if Q.fieldbyname('orca_dtidenti').asdatetime>1 then begin
          FRel.AddCel( FormatDatetime('dd/mm/yy',Q.fieldbyname('orca_dtidenti').asdatetime));
          FRel.AddCel( inttostr( abs(trunc(Q.fieldbyname('orca_dtentrega').asdatetime-Q.fieldbyname('orca_dtidenti').asdatetime)) ) );
        end else begin
          FRel.AddCel( '' );
          FRel.AddCel( '' );
        end;
        FRel.AddCel( GetSituacao(Q.fieldbyname('orca_situacao').AsString) );
      Q.next;
    end;
    FRel.setsort('Análise');
    FRel.Video;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

end;

procedure TFOrcamentos.SetaSituacao(Ed: TSqled);
begin
  Ed.Items.Clear;
  Ed.Items.Add('E - Produção');
  Ed.Items.Add('A - A Confirmar');
  Ed.Items.Add('P - Pendente');
  Ed.Items.Add('R - Rejeitada');
  Ed.Items.Add('F - Fechada');
  Ed.Items.Add('C - Concluída');
  Ed.Items.Add('X - Excluída');
  Ed.Items.Add('I - Indicada');
end;

procedure TFOrcamentos.SetaTipoObra(Ed: TSqled);
begin
  Ed.Items.Clear;
  Ed.Items.Add('Comercial');
  Ed.Items.Add('Residencial');
  Ed.Items.Add('Industrial');
  Ed.Items.Add('Edificio Vertical');

end;

procedure TFOrcamentos.SetaLinha(Ed: TSqled);
begin
  Ed.Items.Clear;
  Ed.Items.Add('Inova');
  Ed.Items.Add('Master');
  Ed.Items.Add('Suprema');
  Ed.Items.Add('Gold IV');
  Ed.Items.Add('Única');
  Ed.Items.Add('Gradil Universal');
  Ed.Items.Add('Portão Universal');
  Ed.Items.Add('Grade Universal');
  Ed.Items.Add('Citta Due');
  Ed.Items.Add('Pele de Vidro II');
  Ed.Items.Add('Soluta');
  Ed.Items.Add('Grid');
  Ed.Items.Add('Fachada Cortina');
  Ed.Items.Add('Cobertura');
  Ed.Items.Add('Piso Vidro');
  Ed.Items.Add('Vidro Temperado');
  Ed.Items.Add('Envidraçamento de Vão');
  Ed.Items.Add('Portão de Elevação');
  Ed.Items.Add('Tela Recolhível');
  Ed.Items.Add('Blackout Recolhível');
//  Ed.Items.Add('Outros');


end;

procedure TFOrcamentos.EdOrca_situacaoValidate(Sender: TObject);
begin
   if EdOrca_situacao.text='R' then
     Edorca_motivorej.enabled:=true
   else
     Edorca_motivorej.enabled:=false;

end;

procedure TFOrcamentos.SetaMotivoRejeicao(Ed: TSqled);
begin
  Ed.Items.Clear;
  Ed.Items.Add('Preço alto');
  Ed.Items.Add('Produto não atendia as necessidades');
  Ed.Items.Add('Atraso na entrega da proposta');
  Ed.Items.Add('Desconto Insuficiente');
  Ed.Items.Add('Incompatibilidade com consultor de vendas');
  Ed.Items.Add('Referências ruins');
  Ed.Items.Add('Atraso no atendimento');
  Ed.Items.Add('Especificação técnica insuficiente');
  Ed.Items.Add('Condição de Pagamento');
//  Ed.Items.Add('Outros');

end;

procedure TFOrcamentos.Edorca_fonecomespValidate(Sender: TObject);
begin
//  Edorca_nomerespcon.setfocus;
end;

procedure TFOrcamentos.Edorca_fonecomconValidate(Sender: TObject);
begin
//  EdOrca_tipoobra.setfocus;
end;

procedure TFOrcamentos.EdOrca_celularValidate(Sender: TObject);
begin
  Edorca_nomeesp.setfocus;

end;

function TFOrcamentos.GetSituacao(situacao: string): string;
begin
  if situacao='E'  then
    result:='Produção'
  else if situacao='A' then
    result:='A Confirmar'
  else if situacao='P' then
    result:='Pendente'
  else if situacao='R' then
    result:='Rejeitada'
  else if situacao='F' then
    result:='Fechada'
  else if situacao='C' then
    result:='Concluída'
  else if situacao='x' then
    result:='Excluída'
  else
    result:='Sem situação';
end;

procedure TFOrcamentos.PorCidade1Click(Sender: TObject);
////////////////////////////////////////////////////////////////
var Q:TSqlquery;
    sqlperiodo,ctitulo,cqdata:string;
    markupdivisor,percvenda:currency;
begin
   if not Sistema.GetPeriodo('Infome período referente data de movimento') then exit;

   cqdata:='';
   if not Input('Informe qual data','M-Movimento  R-Retorno',cqdata,1,true) then cqdata:='M';
     if cqdata='M' then begin
       ctitulo:='Período ref. Data de Movimento :'+FGeral.formatadata(Sistema.datai)+' a '+FGeral.formatadata(Sistema.dataf);
       sqlperiodo:=' and orca_datamvto >= '+Datetosql(Sistema.datai)+
              ' and orca_datamvto <= '+Datetosql(Sistema.dataf);
     end else begin
       ctitulo:='Período ref. Data de Retorno :'+FGeral.formatadata(Sistema.datai)+' a '+FGeral.formatadata(Sistema.dataf);
       sqlperiodo:=' and orca_dataretorno >= '+Datetosql(Sistema.datai)+
              ' and orca_dataretorno <= '+Datetosql(Sistema.dataf);
     end;


//       ' and orca_dtidenti>='+Datetosql(Sistema.Datai)+
//       ' and orca_dtidenti<='+Datetosql(Sistema.Dataf)
    Q:=sqltoquery('select * from orcamentos inner join orcamencal on (orcc_numerodoc=orca_numerodoc and orcc_unid_codigo=orca_unid_codigo)'+
                  ' where orca_status=''N'''+
//                  ' and '+FGeral.GetIN('orcc_unid_codigo',UnidadeObra,'C') );
//                  ' and '+FGeral.GetIN('orca_unid_codigo',UnidadeObra,'C') );
                  ' and orcc_status=''N'''+
                    sqlperiodo );
    FRel.Init('RelOrcamentosCidade');
    FRel.AddTit('Relação de Obras por Cidade. '+ctitulo );
    FRel.AddCol( 70,1,'N','' ,''              ,'Orçamento'        ,''         ,'',false);
    FRel.AddCol( 70,1,'N','' ,''              ,'Numero'        ,''         ,'',false);
    FRel.AddCol(035,0,'N','' ,''              ,'Cod.'       ,''         ,'',false);
    FRel.AddCol(150,0,'C','' ,''              ,'Cidade'           ,''         ,'',false);
    FRel.AddCol(030,0,'N','+' ,''              ,'Obras'           ,''         ,'',false);
    FRel.AddCol(220,0,'C','' ,''              ,'Cliente'           ,''         ,'',false);
    FRel.AddCol(150,3,'N','+' ,''              ,'Potencial Kg'           ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,''              ,'Potencial M2'            ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,''              ,'Potencial Fatur.'           ,''         ,'',false);

    FRel.AddCol( 60,3,'N','' ,''               ,'Margem Lucro'           ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,''              ,'Custo da Obra'           ,''         ,'',false);
    FRel.AddCol( 80,3,'N','' ,''               ,'Markup Divisor'           ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,''              ,'Preço de Venda'           ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,''              ,'Peso Líquido'           ,''         ,'',false);
    FRel.AddCol( 80,3,'N','+' ,''              ,'Area M2'           ,''         ,'',false);

    FRel.AddCol(220,0,'C','' ,''               ,'Nome Especificador'     ,''         ,'',false);
    FRel.AddCol(220,0,'C','' ,''               ,'Empresa Especificador'     ,''         ,'',false);
    FRel.AddCol(220,0,'C','' ,''               ,'Responsável Construtor'        ,''         ,'',false);
    FRel.AddCol(220,0,'C','' ,''               ,'Empresa Construtor'        ,''         ,'',false);
//    FRel.AddCol(070,1,'D','' ,''              ,'Previsão'        ,''         ,'',false);
//    FRel.AddCol(070,1,'D','' ,''              ,'Entrega'         ,''         ,'',false);
//    FRel.AddCol(070,1,'D','' ,''              ,'Identificação'        ,''         ,'',false);
    FRel.AddCol(090,1,'C','' ,''              ,'Status'         ,''         ,'',false);
    while not Q.eof do begin

        FRel.AddCel(Q.fieldbyname('orca_numerodoc').asstring);
        FRel.AddCel( Q.fieldbyname('orca_nroobra').asstring );
        FRel.AddCel( Q.fieldbyname('orca_cida_codigo').asstring );
        FRel.AddCel( FCidades.GetNome(Q.fieldbyname('orca_cida_codigo').asinteger) );
        FRel.AddCel('1' );
        FRel.AddCel( Q.fieldbyname('orca_cliente1').asstring );
//        FRel.AddCel(FGeral.GetNomeRazaoSocialEntidade(Q.fieldbyname('orca_tipo_codigo').asinteger,'C','N'));
        FRel.AddCel(Q.fieldbyname('orca_potpeso').asstring);
        FRel.AddCel( Q.fieldbyname('orca_potarea').asstring);
        FRel.AddCel( Q.fieldbyname('orca_potmoeda').asstring);

        FRel.AddCel( Q.fieldbyname('Orcc_margem').asstring );
        FRel.AddCel( Q.fieldbyname('Orcc_custoobra').asstring );
        percvenda:=Q.fieldbyname('orcc_simples').ascurrency+
                   Q.fieldbyname('Orcc_pis').ascurrency+
                   Q.fieldbyname('orcc_cofins').ascurrency+
                   Q.fieldbyname('Orcc_ir').ascurrency+
                   Q.fieldbyname('Orcc_cs').ascurrency+
                   Q.fieldbyname('Orcc_comissoes').ascurrency+
                   Q.fieldbyname('Orcc_icms').ascurrency+
                   Q.fieldbyname('Orcc_reserva').ascurrency+
                   Q.fieldbyname('Orcc_fretes').ascurrency+
                   Q.fieldbyname('Orcc_custofixo').ascurrency+
                   Q.fieldbyname('Orcc_Reflexocom').ascurrency+
                   Q.fieldbyname('Orcc_construcard').ascurrency;
        markupdivisor:= ( 100 - (percvenda+Q.fieldbyname('Orcc_margem').ascurrency)) / 100;

        FRel.AddCel( floattostr(markupdivisor) );
        FRel.AddCel( Q.fieldbyname('orcc_venda').asstring );
        FRel.AddCel( Q.fieldbyname('Orcc_pesoliquido').asstring );
        FRel.AddCel( Q.fieldbyname('Orca_area').asstring );

        FRel.AddCel( Q.fieldbyname('orca_nomeesp').asstring);
        FRel.AddCel( Q.fieldbyname('orca_empresaesp').asstring);
        FRel.AddCel( Q.fieldbyname('orca_nomerespcon').asstring);
        FRel.AddCel( Q.fieldbyname('orca_empresacon').asstring);

{
        if Q.fieldbyname('orca_dtprevisaoent').asdatetime>1 then
          FRel.AddCel( FormatDatetime('dd/mm/yy',Q.fieldbyname('orca_dtprevisaoent').asdatetime))
        else
          FRel.AddCel( '' );
        if Q.fieldbyname('orca_dtentrega').asdatetime>1 then
          FRel.AddCel( FormatDatetime('dd/mm/yy',Q.fieldbyname('orca_dtentrega').asdatetime))
        else
          FRel.AddCel( '' );
        if Q.fieldbyname('orca_dtidenti').asdatetime>1 then begin
          FRel.AddCel( FormatDatetime('dd/mm/yy',Q.fieldbyname('orca_dtidenti').asdatetime));
        end else begin
          FRel.AddCel( '' );
          FRel.AddCel( '' );
        end;
}
        FRel.AddCel( GetSituacao(Q.fieldbyname('orca_situacao').AsString) );
      Q.next;
    end;

    FRel.Video;
    Sistema.EndProcess('');
    Q.close;
    Freeandnil(Q);

end;

procedure TFOrcamentos.SetaMidia(Ed: TSqled);
begin
  Ed.Items.Clear;
  Ed.Items.Add('Indicada');
  Ed.Items.Add('Internet');
  Ed.Items.Add('Feira');
  Ed.Items.Add('Jornal');
  Ed.Items.Add('Revista');
  Ed.Items.Add('Outdoor');
  Ed.Items.Add('Radio');
  Ed.Items.Add('Tv');
  Ed.Items.Add('Lista Telefônica');
  Ed.Items.Add('Outros');

end;

procedure TFOrcamentos.bcopiaClick(Sender: TObject);
var Q:TSqlquery;
begin
  Edorca_numerodoc.GetFields(FOrcamentos,99);
  if EdOrca_numerodoc.AsInteger=0 then begin
    Avisoerro('Orçamento ainda não gravado');
    exit;
  end;
  Q:=sqltoquery('select orca_numerodoc from orcamentos '+
               ' where orca_status=''N'' and orca_numerodoc='+EdOrca_numerodoc.Assql);
  if Q.eof then begin
    Avisoerro('Orçamento ainda não gravado no banco de dados');
    exit;
  end;
  FGeral.FechaQuery(Q);
  EdNObra.enabled:=true;
  EdNObra.Visible:=true;
  EdNObra.setfocus;
end;

procedure TFOrcamentos.EdNobraExitEdit(Sender: TObject);
begin
  EdNObra.enabled:=false;
  EdNObra.Visible:=false;
  if not confirma('Confirma cópia') then exit;
  
    Sistema.Insert('Orcamentos');
    Edorca_Numerodoc.setvalue( FGeral.GetContador('CADORCA',false) );
    Sistema.Setfield('orca_status','N');
    Sistema.Setfield('orca_numerodoc',Edorca_Numerodoc.Text);
    Sistema.Setfield('orca_datamvto',Edorca_datamvto.AsDate);
    Sistema.Setfield('orca_situacao',EdOrca_situacao.text);
    Sistema.Setfield('orca_tipo_codigo',EdOrca_tipo_codigo.asinteger);
    Sistema.Setfield('orca_tipocad','C');
    Sistema.Setfield('orca_cliente1',EdOrca_cliente1.Text);
    Sistema.Setfield('orca_cliente2',EdOrca_cliente2.Text);
    Sistema.Setfield('orca_dataretorno',EdOrca_dataretorno.AsDate);
    Sistema.Setfield('orca_valor',EdOrca_valor.ascurrency);
//    if EdOrca_tipo_codigo.asinteger>0 then
//    Sistema.Setfield('orca_repr_codigo',EdOrca_tipo_codigo.ResultFind.fieldbyname('clie_repr_codigo').asinteger);
// 30.03.09
    Sistema.Setfield('orca_repr_codigo',EdRepr_codigo.asinteger);
    Sistema.Setfield('orca_datafecha',EdOrca_datafecha.asdate);
    Sistema.Setfield('orca_obra',EdNObra.Text);
    Sistema.Setfield('orca_datalcto',Sistema.hoje);
    Sistema.Setfield('orca_obs',Edorca_obs.text);
    Sistema.Setfield('orca_linha',Edorca_linha.text);
    Sistema.Setfield('orca_unid_codigo',Global.codigounidade);
    Sistema.Setfield('orca_area',EdOrca_area.AsFloat);
    Sistema.Setfield('orca_peso',EdOrca_peso.AsFloat);
    Sistema.Setfield('orca_valor',EdOrca_Valor.AsCurrency);
    Sistema.Setfield('orca_datafecha',EdOrca_datafecha.AsDate);
    Sistema.Setfield('orca_fone',EdOrca_fone.text);
    Sistema.Setfield('orca_celular',EdOrca_celular.text);
    Sistema.Setfield('orca_usua_codigo',Global.Usuario.Codigo);
    Sistema.Setfield('orca_nroobra',EdNobra.Text);
    Sistema.Setfield('orca_enderecocli',Edorca_enderecocli.Text);

    Sistema.Setfield('orca_nomeesp',Edorca_nomeesp.Text);
    Sistema.Setfield('orca_empresaesp',Edorca_empresaesp.Text);
    Sistema.Setfield('orca_enderecoesp',Edorca_enderecoesp.Text);
    Sistema.Setfield('orca_foneesp',Edorca_foneesp.Text);
    Sistema.Setfield('orca_fonecomesp',Edorca_fonecomesp.Text);

    Sistema.Setfield('orca_nomerespcon',Edorca_nomerespcon.Text);
    Sistema.Setfield('orca_empresacon',Edorca_empresacon.Text);
    Sistema.Setfield('orca_enderecocon',Edorca_enderecocon.Text);
    Sistema.Setfield('orca_fonecon',Edorca_fonecon.Text);
    Sistema.Setfield('orca_fonecomcon',Edorca_fonecomcon.Text);
    Sistema.Setfield('orca_tipoobra',Edorca_tipoobra.Text);
    Sistema.Setfield('orca_pavimentos',Edorca_pavimentos.AsInteger);
    Sistema.Setfield('orca_dtidenti',Edorca_dtidenti.Asdate);
    Sistema.Setfield('orca_vidrotemp',Edorca_vidrotemp.AsCurrency);
    Sistema.Setfield('orca_vidrolami',Edorca_vidrolami.AsCurrency);
    Sistema.Setfield('orca_vidromono',Edorca_vidromono.AsCurrency);
    Sistema.Setfield('orca_vidroinsu',Edorca_vidroinsu.AsCurrency);
    Sistema.Setfield('orca_potpeso',Edorca_potpeso.AsCurrency);
    Sistema.Setfield('orca_potarea',Edorca_potarea.AsCurrency);
    Sistema.Setfield('orca_potmoeda',Edorca_potmoeda.AsCurrency);
    Sistema.Setfield('orca_motivorej',Edorca_motivorej.Text);
    Sistema.Setfield('orca_tipovenda',Edorca_tipovenda.Text);
    Sistema.Setfield('orca_cida_codigo',Edorca_cida_codigo.AsInteger);
// 13.12.10
    Sistema.Setfield('orca_dtprevfecha',EdOrca_dtprevfecha.asdate);
// 09.06.11
    if campo.Tipo<>'' then
      Sistema.Setfield('Orca_prodser',EdOrca_prodser.text);

    Sistema.Post;
    try
      Sistema.Commit;
      Aviso('Orçamento copiado para o numero '+Edorca_Numerodoc.text);
      Arq.TOrcamentos.Refresh;
      Arq.TOrcamentos.Locate('orca_numerodoc',EdOrca_numerodoc.text,[]);
    except
      Avisoerro('Não foi possível gravar.  Tente mais tarde');
    end;

end;

procedure TFOrcamentos.EdNobraKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then begin
    EdNObra.enabled:=false;
    EdNObra.Visible:=false;
    xgrid.Enabled:=true;
    pbotoes.setfocus;
  end;
end;

end.
