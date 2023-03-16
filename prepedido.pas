unit prepedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SqlDtg, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, DBGrids;

type
  TFPrepedidos = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bexclusao: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    Edcliente: TSQLEd;
    SetEdCLIE_NOME: TSQLEd;
    EdDtEntrega: TSQLEd;
    EdRepr_codigo: TSQLEd;
    SQLEd3: TSQLEd;
    Edsolicitadas: TSQLEd;
    EdClie_fone: TSQLEd;
    EdUltimomes: TSQLEd;
    EdTresmeses: TSQLEd;
    EdLiberadas: TSQLEd;
    Edobs: TSQLEd;
    EdAtendimento: TSQLEd;
    Grid: TSqlDtGrid;
    EdIniciomedia: TSQLEd;
    EdFinalmedia: TSQLEd;
    procedure bCancelarClick(Sender: TObject);
    procedure bexclusaoClick(Sender: TObject);
    procedure bSairClick(Sender: TObject);
    procedure EdobsExitEdit(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdDtEntregaValidate(Sender: TObject);
    procedure EdAtendimentoValidate(Sender: TObject);
    procedure EdclienteValidate(Sender: TObject);
    procedure EdsolicitadasValidate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure EditstoGrid;

  end;

var
  FPrepedidos: TFPrepedidos;
  usuariolib:integer;
  obsliberacao,seq,tiposmov,complemento:string;

implementation

uses sqlsis,geral, Arquiv,  Sqlfun, Usuarios, Sqlexpr;


{$R *.dfm}

procedure TFPrepedidos.bCancelarClick(Sender: TObject);
begin
  EdCliente.clearall(FPrepedidos,99);
  EdDtentrega.setdate(sistema.hoje);
  EdAtendimento.setdate(sistema.hoje+1);
  EdCliente.setfocus;
end;

procedure TFPrepedidos.bexclusaoClick(Sender: TObject);
var cliente,sequencial:string;
begin
//  if not EdCliente.valid then exit;
  cliente:=Grid.cells[grid.getcolumn('conp_tipo_codigo'),grid.row];
  sequencial:=Grid.cells[grid.getcolumn('conp_sequencial'),grid.row];
  if trim(cliente)='' then exit;
  if not confirma('Confirma exclusão do cliente '+cliente+' do sequencial '+sequencial+' ?') then exit;
  Sistema.BeginProcess('Excluindo');
  try
    Sistema.edit('conpedidos');
    Sistema.setfield('conp_status','C');
    Sistema.post('conp_sequencial='+stringtosql(sequencial)+' and conp_tipo_codigo='+stringtosql(cliente));
    Sistema.commit;
    Grid.DeleteRow(Grid.row);
  except
    Avisoerro('Problemas na exclusão');
  end;
  Sistema.endprocess('');
end;

procedure TFPrepedidos.bSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFPrepedidos.EdobsExitEdit(Sender: TObject);
begin
  bgravarclick(Self);
end;

procedure TFPrepedidos.bGravarClick(Sender: TObject);

   procedure GravaPrePedido;
   begin
     Sistema.Insert('conpedidos');
     Sistema.Setfield('conp_sequencial',seq);
     Sistema.Setfield('conp_status','N');
     Sistema.Setfield('conp_repr_codigo',EdRepr_codigo.asinteger);
     Sistema.Setfield('conp_tipo_codigo',EdCliente.asinteger);
     Sistema.Setfield('conp_datalcto',sistema.hoje);
     Sistema.Setfield('conp_datamvto',EdDtEntrega.asdate);
     Sistema.Setfield('conp_dataentrega',EdDtEntrega.asdate);
     Sistema.Setfield('conp_dataatend',EdAtendimento.asdate);
     Sistema.Setfield('conp_qtdesolic',EdSolicitadas.ascurrency);
     Sistema.Setfield('conp_qtdeliber',EdLiberadas.ascurrency);
     Sistema.Setfield('conp_mediamesant',EdUltimomes.ascurrency);
     Sistema.Setfield('conp_mediatrimestre',EdTresmeses.ascurrency);
     Sistema.Setfield('conp_tiposmedia',tiposmov);
     Sistema.Setfield('conp_obs',EdObs.text);
     Sistema.Setfield('conp_complemento',complemento);
// 27.04.06
     Sistema.SetField('conp_obslibcredito',obsliberacao);
     Sistema.SetField('conp_datalibcredito',sistema.hoje);
     Sistema.SetField('conp_usualibcred',usuariolib);
     Sistema.Post;
   end;


begin

  if EdCliente.isempty then exit;
  if EdLiberadas.isempty then exit;
  if EdDtentrega.isempty then exit;
  if not EdAtendimento.valid then exit;
  if not confirma('Confirma gravação ?') then exit;
  try
    seq:=inttostr(FGeral.getcontador('PREPEDIDOS',false));
    Gravaprepedido;
    Sistema.commit;
    editstogrid;
  except
    Avisoerro('Problemas na gravação');
  end;
  bcancelarclick(self);
end;

procedure TFPrepedidos.Execute;
begin
  FPrePedidos.EdDtentrega.setdate(sistema.hoje);
  FPrePedidos.EdAtendimento.setdate(sistema.hoje+1);
  FPrePedidos.EdUnid_codigo.text:=Global.CodigoUnidade;
  complemento:='N';
  FPrePedidos.Show;
  tiposmov:=Global.CodVendaConsig+';'+Global.CodVendaREFinal;
  FPrePedidos.EdCliente.setfocus;

end;

procedure TFPrepedidos.EdDtEntregaValidate(Sender: TObject);
var Q:Tsqlquery;
    ano,mes:integer;
begin
   ano:=Datetoano(EdDtentrega.asdate,true);
   mes:=Datetomes(EdDtentrega.asdate);
//   if (EdDtentrega.asdate)<(Sistema.hoje-3) then
// 06.06.06
   if (EdDtentrega.asdate)<(Sistema.hoje-5) then
     EdDtentrega.invalid('Data de entrega inválida')
   else begin
     Grid.clear;
     Q:=sqltoquery('select conpedidos.*,clie_nome from conpedidos inner join clientes on (clie_codigo=conp_tipo_codigo)'+
                  ' where conp_status=''N'''+
//                  ' and extract( month from conp_datamvto )='+inttostr(mes)+
//                  ' and extract( year from conp_datamvto )='+inttostr(ano)+
                  ' and conp_datamvto='+EdDtEntrega.assql);
//                  ' and conp_repr_codigo='+EdRepr_codigo.assql);
     Grid.QueryToGrid(Q);
     FGeral.fechaquery(Q);
   end;
end;

procedure TFPrepedidos.EdAtendimentoValidate(Sender: TObject);
begin
   if EdAtendimento.asdate<EdDtentrega.asdate+1 then
     EdAtendimento.Invalid('Data de atendimento tem que ser posterior a da entrega');
end;

procedure TFPrepedidos.EdclienteValidate(Sender: TObject);
var restricao1,restricao2,restricao3,restricao4:boolean;
    Q:Tsqlquery;
    ano,mes:integer;
    datai,dataf:Tdatetime;
begin
  restricao1:=true;
  restricao2:=true;
  restricao3:=true;
  restricao4:=true;
  usuariolib:=0;
  obsliberacao:='';
  complemento:='N';
  datai:=Datetoprimeirodiames(Datetodatemesant(sistema.hoje,3));
  dataf:=Datetoultimodiames(Datetodatemesant(sistema.hoje,1));
  if EdIniciomedia.isempty then
    EdIniciomedia.setdate(datai);
  if EdFinalmedia.isempty then
    EdFinalmedia.setdate(dataf);
  if (EdCliente.resultfind<>nil) then begin
    if not FGEral.ValidaCliente(EdCliente,Global.CodRemessaConsig) then begin
      EdCliente.Invalid('');
      exit;
    end;
    restricao1:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','001' );
    restricao2:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','002' );
    restricao3:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','CHQ' );
    restricao4:=FGeral.ValidaCliente( EdCliente,Global.CodPedVenda,'P','VLR' );
// 22.05.06
//    if not restricao3 then begin
//            EdCliente.Invalid('');
//            exit;
//    end;
// 04.07.06
    if ( ( not restricao1 ) or ( not restricao2 ) or ( not restricao3 ) ) and   ( not Confirma('Deseja autorizar a venda ?') ) then begin
      EdCliente.invalid('');
      exit;
    end;
// 05.06.06 - roseleia+alexandre querem liberar em algumas situacoes mesm ocom chq devolvido
    if (not restricao1)  then begin //fixo portador duplicata
//      if not Confirma('Venda a vista') then
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
        if usuariolib>0 then begin
          Input('Contato com representante','Observação',obsliberacao,150,true);
          if trim(obsliberacao)='' then
            EdCliente.Invalid('Preenchimento Obrigatório');
        end else
          EdCliente.Invalid('');
    end else if not restricao2  then begin //fixo portador boleto
//      if not Confirma('Venda a vista') then
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
        if usuariolib>0 then begin
          Input('Contato com representante','Observação',obsliberacao,100,true);
          if trim(obsliberacao)='' then
            EdCliente.Invalid('Preenchimento Obrigatório');
        end else
          EdCliente.Invalid('');
    end else if not restricao4  then begin // valor minimo de vendas
//      if not Confirma('Venda a vista') then
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
        if usuariolib>0 then begin
          Input('Contato com representante','Observação',obsliberacao,100,true);
          if trim(obsliberacao)='' then
            EdCliente.Invalid('Preenchimento Obrigatório');
        end else
          EdCliente.Invalid('');
    end else if not restricao3  then begin // cheque devolvido - Alexandre+Roseleia
//      if not Confirma('Venda a vista') then
       usuariolib:=FUsuarios.GetSenhaAutorizacao(706);
        if usuariolib>0 then begin
          Input('Contato com representante','Observação',obsliberacao,100,true);
          if trim(obsliberacao)='' then
            EdCliente.Invalid('Preenchimento Obrigatório');
        end else
          EdCliente.Invalid('');
    end;
    EdRepr_codigo.setvalue(EdCliente.resultfind.fieldbyname('clie_repr_codigo').asinteger);
    EdRepr_codigo.validfind;
    EdClie_fone.text:=FGeral.Formatatelefone(EdCliente.resultfind.fieldbyname('clie_foneres').asstring);
    ano:=Datetoano(EdDtentrega.asdate,true);
    mes:=Datetomes(EdDtentrega.asdate);
    Q:=sqltoquery('select * from conpedidos where conp_status=''N'' and conp_tipo_codigo='+Edcliente.assql+
                  ' and extract( month from conp_datamvto )='+inttostr(mes)+
                  ' and extract( year from conp_datamvto )='+inttostr(ano)+
                  ' and conp_complemento=''S''');
    if not Q.eof then begin
      Avisoerro('Cliente já possui complemento de pré-pedido em '+fGeral.formatadata(Q.fieldbyname('conp_datamvto').Asdatetime));
//      EdCliente.Invalid('');
      exit;
    end;
    FGeral.fechaquery(q);
    Q:=sqltoquery('select * from conpedidos where conp_status=''N'' and conp_tipo_codigo='+Edcliente.assql+
                  ' and extract( month from conp_datamvto )='+inttostr(mes)+
                  ' and extract( year from conp_datamvto )='+inttostr(ano) );
    if (not Q.eof) then begin
      Avisoerro('Cliente com pré-pedido em '+fGeral.formatadata(Q.fieldbyname('conp_datamvto').Asdatetime));
      if confirma('Deseja fazer complemento ?') then
        complemento:='S';
    end;

  end else
    EdCliente.Invalid('Codigo inválido');

end;

procedure TFPrepedidos.EdsolicitadasValidate(Sender: TObject);
var Q:TSqlquery;
    perc,mediames,mediatri,qtdmes,qtdtri:currency;
    Datai,Dataf:TDatetime;
    mesant:integer;
    Listameses:TStringlist;
begin
//   aqui fazer a media do mes passado e do ultimo trimestre
  perc:=fGeral.Getconfig1asfloat('PERCMEDIAS');
  mediames:=0;mediatri:=0;
  Sistema.beginprocess('Calculando média de vendas mais '+FGeral.Formatavalor(perc,f_cr)+' %' );
//  datai:=Datetoprimeirodiames(Datetodatemesant(sistema.hoje,3));
//  dataf:=Datetoultimodiames(Datetodatemesant(sistema.hoje,1));
  datai:=EdInicioMedia.asdate;
  dataf:=EdFinalmedia.asdate;
//  mesant:=DAtetomes(Datetodatemesant(sistema.hoje,1));
  mesant:=DAtetomes(EdFinalMedia.asdate);
  Q:=sqltoquery('select * from movestoque inner join movesto on ( moes_transacao=move_transacao and moes_tipomov=move_tipomov)'+
                ' where '+fGeral.getin('move_tipomov',tiposmov,'C')+
                ' and move_status=''N'' and move_datamvto>='+Datetosql(datai)+' and move_datamvto<='+Datetosql(dataf)+
                ' and '+FGeral.Getin('move_unid_codigo',Global.Usuario.UnidadesRelatorios,'C')+
                ' and move_tipo_codigo='+EdCliente.assql+' and move_tipocad=''C''');
  qtdmes:=0;qtdtri:=0;
  Listameses:=TstringList.create;
  while not Q.eof do begin
    if datetomes(Q.fieldbyname('move_datamvto').asdatetime)=mesant then
      qtdmes:=qtdmes+Q.fieldbyname('move_qtde').ascurrency;
    qtdtri:=qtdtri+Q.fieldbyname('move_qtde').ascurrency;
    if Listameses.indexof(strzero(datetomes(Q.fieldbyname('move_datamvto').asdatetime),2))=-1 then
      Listameses.add( strzero(datetomes(Q.fieldbyname('move_datamvto').asdatetime),2) );
    Q.Next;
  end;
  mediames:=qtdmes;
  if LIstameses.count>0 then
    mediatri:=round(qtdtri/Listameses.count);
  mediames:=mediames+(mediames*(perc/100));
  mediatri:=mediatri+(mediatri*(perc/100));
  EdUltimomes.setvalue(mediames);
  EdTresmeses.setvalue(mediatri);
  Sistema.endprocess('')
end;

procedure TFPrepedidos.EditstoGrid;
var x:integer;
begin
  x:=fGeral.ProcuraGrid(Grid.getcolumn('conp_tipo_codigo'),EdCliente.Text,Grid );
  if x=0 then begin
    x:=Grid.RowCount;
    Grid.AppendRow;
    Grid.Cells[grid.getcolumn('conp_sequencial'),Abs(x)]:=Seq;
    Grid.Cells[grid.getcolumn('conp_tipo_codigo'),Abs(x)]:=EdCliente.Text;
    Grid.Cells[grid.getcolumn('clie_nome'),Abs(x)]:=SetEdclie_NOme.text;
    Grid.Cells[grid.getcolumn('conp_dataatend'),Abs(x)]:=FGeral.formatadata(EdAtendimento.asdate);
    Grid.Cells[grid.getcolumn('conp_qtdesolic'),Abs(x)]:=EdSolicitadas.AsSql;
    Grid.Cells[grid.getcolumn('conp_qtdeliber'),Abs(x)]:=EdLiberadas.AsSql;
  end else begin
    Grid.Cells[grid.getcolumn('conp_sequencial'),x]:=Seq;
    Grid.Cells[grid.getcolumn('conp_tipo_codigo'),x]:=EdCliente.Text;
    Grid.Cells[grid.getcolumn('clie_nome'),x]:=SetEdclie_NOme.text;
    Grid.Cells[grid.getcolumn('conp_dataatend'),x]:=FGeral.formatadata(EdAtendimento.asdate);
    Grid.Cells[grid.getcolumn('conp_qtdesolic'),x]:=EdSolicitadas.AsSql;
    Grid.Cells[grid.getcolumn('conp_qtdeliber'),x]:=EdLiberadas.AsSql;
  end;

end;

end.
