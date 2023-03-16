unit ataspacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, SQLEd, Grids, SqlDtg, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid;

type
  TFAtaplanoacao = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bSair: TSQLBtn;
    bCancelar: TSQLBtn;
    bExcluir: TSQLBtn;
    bbaixar: TSQLBtn;
    bimpressao: TSQLBtn;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PInicial: TSQLPanelGrid;
    Grid: TSqlDtGrid;
    PAcerto: TSQLPanelGrid;
    EdData: TSQLEd;
    Edobjetivo: TSQLEd;
    EdSetor_codigo: TSQLEd;
    Eddesctipo: TSQLEd;
    PIns: TSQLPanelGrid;
    Edrespcodigo: TSQLEd;
    SetEdusua_descricao: TSQLEd;
    Edplanoacao: TSQLEd;
    Edpaca_oque: TSQLEd;
    Edpaca_como: TSQLEd;
    Edpaca_usua_codigo: TSQLEd;
    Edpaca_quem: TSQLEd;
    Edpaca_quando: TSQLEd;
    Edpaca_porque: TSQLEd;
    Edpaca_valor: TSQLEd;
    Edencerramento: TSQLEd;
    balterar: TSQLBtn;
    procedure bIncluirClick(Sender: TObject);
    procedure EdobjetivoExitEdit(Sender: TObject);
    procedure Edpaca_valorExitEdit(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure EdplanoacaoValidate(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure Edpaca_oqueKeyPress(Sender: TObject; var Key: Char);
    procedure bbaixarClick(Sender: TObject);
    procedure EdencerramentoExitEdit(Sender: TObject);
    procedure EdencerramentoValidate(Sender: TObject);
    procedure EdplanoacaoKeyPress(Sender: TObject; var Key: Char);
    procedure bimpressaoClick(Sender: TObject);
    procedure balterarClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute( opx:string='I' ; xnumerornc:integer=0 ; descrnc:string='');
    procedure GravaMestre(xplanoacao:string='';xnumero:integer=0);
    procedure EditstoGrid(linha:integer=0;xseq:integer=0);
    procedure SetaPlano(Ed:TSqled);
    procedure GridtoEdits;
    procedure GeraExcluido;

  end;

var
  FAtaplanoacao: TFAtaplanoacao;
  OP,tipoplano,OPbotao:string;
  seq,numerornc:integer;

implementation

uses SqlSis, SqlExpr, Geral, SqlFun, regnaoconf, SQLRel;

{$R *.dfm}

{ TFAtaplanoacao }

procedure TFAtaplanoacao.Execute(opx: string='I' ; xnumerornc:integer=0 ; descrnc:string='');
/////////////////////////////////////////////////////////////////////////////////////////////
var Q,QRnc:TSqlquery;
begin
   OP:=opx;
   OPBotao:='I';
   Grid.clear;
   EdData.clearall(FAtaplanoacao,99);
   EdPaca_oque.clearall(FAtaplanoacao,99);
   show;
   EdData.setdate(Sistema.hoje);
   numerornc:=xnumerornc;
   balterar.enabled:=pos(OP,'A;P')>0;
   if numerornc>0 then
     tipoplano:='R'
   else
     tipoplano:='A';
   if OP='I' then begin
     EdPlanoacao.enabled:=false;
     EdData.Enabled:=true;
     EdData.setfocus;
   end else begin
     SetaPlano(EdPlanoacao);
     EdData.Enabled:=false;
     EdPlanoacao.enabled:=true;
     if numerornc>0 then begin
       Q:=sqltoquery('select paca_numeroata from planoacao where paca_mrnc_numerornc='+inttostr(numerornc)+' and paca_unid_codigo='+stringtosql(Global.CodigoUnidade) );
       FAtaplanoacao.Caption:='Plano de Açao da RNC '+inttostr(numerornc)+' '+descrnc;
       if not Q.eof then begin
//         EdPlanoAcao.setvalue(Q.fieldbyname('paca_numeroata').asinteger);
         EdPlanoAcao.text:=Q.fieldbyname('paca_numeroata').asstring;
         EdPlanoAcao.valid;
       end else begin
         OP:='I';  // muda para inclusao pois achou rnc sem nenhum plano de ação cadastrado
         EdPlanoacao.enabled:=false;
         EdData.Enabled:=true;
         EdData.setfocus;
         QRnc:=sqltoquery(FRegNaoConformidade.GetSqlRcn(numerornc,Global.CodigoUnidade) );
         if not QRnc.eof then begin
            EdSetor_codigo.Text:=QRnc.fieldbyname('mrnc_seto_codigo').asstring;
            EdRespcodigo.Text:=QRnc.fieldbyname('mrnc_usua_resp').asstring;
         end;
         FGeral.FechaQuery(QRnc);
       end;
       FGeral.FechaQuery(Q);
     end else
       EdPlanoacao.setfocus;
   end;
end;

procedure TFAtaplanoacao.bIncluirClick(Sender: TObject);
begin
   OPBotao:='I';
   if OP='A' then begin
     if EdPlanoacao.isempty then exit;
     if Global.Usuario.Codigo<>Edrespcodigo.asinteger then begin
       Avisoerro('Responsável por este plano é usuário '+Edrespcodigo.text);
       exit;
     end;
   end;
   if not EdSetor_codigo.ValidEdiAll(FAtaplanoacao,10) then begin
     exit;
   end;
   pins.visible:=true;
   EdPaca_oque.clearall(FAtaplanoacao,99);
   EdPaca_oque.setfocus;
end;

procedure TFAtaplanoacao.EdobjetivoExitEdit(Sender: TObject);
begin
  bincluirclick(self);
end;

procedure TFAtaplanoacao.Edpaca_valorExitEdit(Sender: TObject);
begin
   if not confirma('Confirma informações ?') then exit;
   if OP='I' then begin
     Editstogrid;
     try
       gravamestre;
     except
       Avisoerro('Não foi possível inlcuir este item');
     end;
     EdPaca_oque.clearall(FAtaplanoacao,99);
     EdPaca_oque.setfocus;
   end else begin
     geraexcluido;
//     Editstogrid( strtointdef( Grid.Cells[Grid.getcolumn('paca_seq'),grid.row],0 ) );
//     Editstogrid(  grid.row, strtoint(grid.cells[grid.getcolumn('paca_seq'),grid.row]));
//  07.05.09
     if OPBotao='A' then begin
       Editstogrid(  grid.row, strtoint(grid.cells[grid.getcolumn('paca_seq'),grid.row]));
       gravamestre(Edplanoacao.text, strtoint(grid.cells[grid.getcolumn('paca_seq'),grid.row]) );
     end else begin
       Editstogrid;
       gravamestre(Edplanoacao.text, seq );
     end;
     bcancelarclick(self);
   end;
   try
     Sistema.commit;
   except
       Avisoerro('Não foi possível gravar este item');
   end;
end;



procedure TFAtaplanoacao.GravaMestre(xplanoacao: string ; xnumero: integer);
///////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;

      procedure Inclui;
      begin
        Sistema.Insert('planoacao');
        Sistema.SetField('paca_usua_resp',Edrespcodigo.text);
        Sistema.SetField('paca_seto_codigo',EdSetor_codigo.text);
        Sistema.SetField('paca_objetivo',EdObjetivo.text);
        Sistema.SetField('paca_status','N');
        Sistema.SetField('paca_seq',strzero(seq,3));
        Sistema.SetField('paca_numeroata',EdPlanoacao.text);
        Sistema.SetField('paca_mrnc_numerornc',numerornc);
        Sistema.SetField('paca_unid_codigo',Global.CodigoUnidade);
        Sistema.SetField('paca_situacao','P');
        Sistema.SetField('paca_tipoplano',tipoplano);
        Sistema.SetField('paca_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('paca_usua_resp',EdRespcodigo.asinteger);
        Sistema.SetField('paca_usua_exclusao',0);
        Sistema.SetField('paca_data',EdData.asdate);
        Sistema.SetField('paca_dtlcto',Sistema.Hoje);
        Sistema.SetField('paca_oque',EdPaca_oque.text);
        Sistema.SetField('paca_como',EdPaca_como.text);
        Sistema.SetField('paca_quem',EdPaca_quem.text);
        Sistema.SetField('paca_usua_quem',EdPaca_usua_codigo.asinteger);
        Sistema.SetField('paca_quando',EdPaca_quando.asdate);
        Sistema.SetField('paca_porque',EdPaca_porque.text);
        Sistema.SetField('paca_dtencerra',Texttodate(''));
        Sistema.SetField('paca_valor',EdPaca_valor.ascurrency);
        Sistema.post('');
      end;

begin
/////////////////////////////////
    if xnumero=0 then begin
      if EdPlanoacao.isempty then
        EdPlanoacao.text:=inttostr( fGeral.getcontador('ATAPLANO'+Global.CodigoUnidade,false) );
        Inclui;
    end else begin
      Q:=Sqltoquery('select paca_numeroata from planoacao where paca_numeroata='+EdPlanoacao.assql+' and paca_tipoplano='+stringtosql(tipoplano)+' and paca_status=''N'''+
                   ' and paca_seq='+stringtosql(strzero(xnumero,3)));
      if not Q.eof then begin
        Sistema.Edit('planoacao');
        Sistema.SetField('paca_usua_resp',Edrespcodigo.asinteger);
        Sistema.SetField('paca_seto_codigo',EdSetor_codigo.text);
        Sistema.SetField('paca_objetivo',EdObjetivo.text);
        Sistema.post('paca_numeroata='+Stringtosql(inttostr(xnumero))
                    +' and paca_tipoplano='+stringtosql(tipoplano)+' and paca_status=''N''');

        Sistema.Edit('planoacao');
        Sistema.SetField('paca_oque',EdPaca_oque.text);
        Sistema.SetField('paca_como',EdPaca_como.text);
        Sistema.SetField('paca_quem',EdPaca_quem.text);
        Sistema.SetField('paca_usua_quem',EdPaca_usua_codigo.asinteger);
        Sistema.SetField('paca_quando',EdPaca_quando.asdate);
        Sistema.SetField('paca_porque',EdPaca_porque.text);
        Sistema.SetField('paca_dtencerra',Texttodate(''));
        Sistema.SetField('paca_valor',EdPaca_valor.ascurrency);
        Sistema.post('paca_numeroata='+EdPlanoacao.assql+' and paca_tipoplano='+stringtosql(tipoplano)+' and paca_status=''N'''+
                     ' and paca_seq='+stringtosql(strzero(xnumero,3)));
      end else begin
        Inclui;
      end;
    end;
end;

procedure TFAtaplanoacao.EditstoGrid(linha:integer=0;xseq:integer=0);
var i:integer;
begin
  i:=0;seq:=0;
  if i<=0 then begin
    if (Grid.RowCount=2) and (Trim(Grid.Cells[Grid.getcolumn('paca_seq'),1])='') then begin
       i:=1;
    end else begin
       Grid.RowCount:=Grid.RowCount+1;
       i:=Grid.RowCount-1;
       if OP='A' then begin
           dec(i);
       end;
    end;
    seq:=i;
    if xseq>0 then begin
      seq:=xseq;
      i:=linha;
    end;
//     Grid.AppendRow;
     Grid.Cells[Grid.getcolumn('paca_seq'),i]:=strzero(seq,3);
     Grid.Cells[Grid.getcolumn('paca_oque'),i]:=Edpaca_oque.text;
     Grid.Cells[Grid.getcolumn('paca_como'),i]:=Edpaca_como.text;
     Grid.Cells[Grid.getcolumn('paca_quem'),i]:=Edpaca_quem.text;
     Grid.Cells[Grid.getcolumn('paca_usua_quem'),i]:=Edpaca_usua_codigo.text;
     Grid.Cells[Grid.getcolumn('paca_quando'),i]:=FGeral.formatadata(Edpaca_quando.asdate);
     Grid.Cells[Grid.getcolumn('paca_porque'),i]:=Edpaca_porque.text;
     Grid.Cells[Grid.getcolumn('paca_valor'),i]:=Edpaca_valor.assql;
  end else
    Avisoerro('Item já existente');

end;

procedure TFAtaplanoacao.bExcluirClick(Sender: TObject);
var aseq:integer;
begin
   if OP='A' then begin
     if EdPlanoacao.isempty then exit;
//     if ( Global.Usuario.Codigo<>Edrespcodigo.asinteger ) and
// 09.12.09 - Abra - Pivatto
     if (Global.Usuario.Codigo<>Edrespcodigo.asinteger) and (not Global.Usuario.OutrosAcessos[0401]) then begin
       Avisoerro('Responsável por este plano é usuário '+Edrespcodigo.text);
       exit;
     end;
   end;
   aseq:=strtointdef(Grid.cells[Grid.getcolumn('paca_seq'),Grid.row],0);
   if aseq=0 then exit;
   if not confirma('Confirma exclusão ?') then exit;
   try
      Sistema.Edit('planoacao');
      Sistema.SetField('paca_status','C');
      Sistema.SetField('paca_usua_exclusao',Global.Usuario.Codigo);
      Sistema.post('paca_numeroata='+EdPlanoacao.assql+' and paca_tipoplano='+stringtosql(tipoplano)+' and paca_status=''N'''+
                   ' and paca_seq='+stringtosql(strzero(aseq,3)));
      Sistema.commit;
      Grid.DeleteRow(Grid.row);
   except
      Avisoerro('Não foi possível excluir este item');
   end;
end;

procedure TFAtaplanoacao.SetaPlano(Ed: TSqled);
var Q:TSqlquery;
begin
  Q:=sqltoquery('select distinct paca_numeroata from planoacao where paca_tipoplano='+stringtosql(tipoplano)+' and paca_status=''N'''+
                ' and paca_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                ' and paca_data>='+Datetosql(Sistema.hoje-30));   //+' order by paca_data desc');
  Ed.Items.Clear;
  while not Q.eof do begin
    Ed.Items.add(Q.fieldbyname('paca_numeroata').AsString);
    Q.Next;
  end;
  FGeral.fechaquery(Q);

end;

procedure TFAtaplanoacao.EdplanoacaoValidate(Sender: TObject);
//////////////////////////////////////////////////////////////////////
var Q:TSqlquery;

    procedure QuerytoGrid(Q:Tsqlquery);
    var i:integer;
    begin
      Grid.clear;i:=1;
      while not Q.Eof do begin
         Grid.Cells[Grid.getcolumn('paca_seq'),i]:=Q.fieldbyname('paca_seq').AsString;
         Grid.Cells[Grid.getcolumn('paca_oque'),i]:=Q.fieldbyname('paca_oque').AsString;
         Grid.Cells[Grid.getcolumn('paca_como'),i]:=Q.fieldbyname('paca_como').AsString;
         Grid.Cells[Grid.getcolumn('paca_quem'),i]:=Q.fieldbyname('paca_quem').AsString;
         Grid.Cells[Grid.getcolumn('paca_usua_quem'),i]:=Q.fieldbyname('paca_usua_quem').AsString;
         Grid.Cells[Grid.getcolumn('paca_quando'),i]:=FGeral.formatadata(Q.fieldbyname('paca_quando').asdatetime);
         Grid.Cells[Grid.getcolumn('paca_porque'),i]:=Q.fieldbyname('paca_porque').AsString;
         Grid.Cells[Grid.getcolumn('paca_valor'),i]:=floattostr(Q.fieldbyname('paca_valor').AsCurrency);
         if Q.fieldbyname('paca_dtencerra').AsDatetime>1 then
           Grid.Cells[Grid.getcolumn('paca_dtencerra'),i]:=FGeral.formatadata(Q.fieldbyname('paca_dtencerra').asdatetime)
         else
           Grid.Cells[Grid.getcolumn('paca_dtencerra'),i]:='';
         Grid.AppendRow;
         inc(i);
         Q.Next;
      end;
    end;

begin
  Q:=sqltoquery('select * from planoacao where paca_tipoplano='+stringtosql(tipoplano)+' and paca_status=''N'''+
                ' and paca_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                ' and paca_numeroata='+EdPlanoacao.assql+' order by paca_seq');
  if Q.eof then begin
    EdPlanoacao.invalid('Plano de ação não encontrado');
  end else begin
    EdData.SetDate(Q.fieldbyname('paca_data').asdatetime);
    EdSetor_codigo.Text:=Q.fieldbyname('paca_seto_codigo').asstring;
    EdSetor_codigo.ValidFind;
    Edrespcodigo.Text:=Q.fieldbyname('paca_usua_resp').asstring;
    Edrespcodigo.ValidFind;
    EdObjetivo.Text:=Q.fieldbyname('paca_objetivo').asstring;
    QuerytoGrid(Q);
    if Global.Usuario.Codigo<>Edrespcodigo.asinteger then begin
      EdPlanoacao.invalid('Responsável por este plano é usuário '+Edrespcodigo.text);
    end;
  end;
  FGeral.FechaQuery(Q);

end;

procedure TFAtaplanoacao.bCancelarClick(Sender: TObject);
begin
   PIns.visible:=false;
end;

procedure TFAtaplanoacao.Edpaca_oqueKeyPress(Sender: TObject;
  var Key: Char);
begin
   if key=#27 then
     bcancelarclick(self);
end;

procedure TFAtaplanoacao.bbaixarClick(Sender: TObject);
var aseq:integer;
begin
   if OP='A' then begin
     if EdPlanoacao.isempty then exit;
     if Global.Usuario.Codigo<>Edrespcodigo.asinteger then begin
       Avisoerro('Responsável por este plano é usuário '+Edrespcodigo.text);
       exit;
     end;
   end;
   aseq:=strtointdef(Grid.cells[Grid.getcolumn('paca_seq'),Grid.row],0);
   if aseq=0 then exit;
   Grid.setfocus;
   if Grid.col<>grid.getcolumn('paca_dtencerra') then begin
     Aviso('Primeiro posicionar na data de encerramento da tarefa desejada');
     exit;
   end;
   EdEncerramento.Top:=Grid.TopEdit;
   EdEncerramento.Left:=Grid.LeftEdit;
   EdEncerramento.Enabled:=true;
   EdEncerramento.Visible:=true;
   EdEncerramento.setdate( Texttodate(FGeral.TiraBarra(Grid.cells[grid.getcolumn('paca_dtencerra'),grid.row])) );
   EdEncerramento.setfocus;

end;

procedure TFAtaplanoacao.EdencerramentoExitEdit(Sender: TObject);
begin
  if Confirma('Confirma baixa ?') then begin
    Grid.cells[grid.getcolumn('paca_dtencerra'),grid.row]:=FGeral.formatadata(EdEncerramento.asdate);
    Sistema.Edit('planoacao');
    Sistema.SetField('paca_dtencerra',EdEncerramento.asdate);
    if EdEncerramento.AsDate>0 then
      Sistema.SetField('paca_situacao','E')
    else
      Sistema.SetField('paca_situacao','P');
// 17.11.08 - usuario q encerrou a tarefa
    Sistema.SetField('paca_usua_ence',Global.Usuario.Codigo);
    Sistema.post('paca_numeroata='+EdPlanoacao.assql+' and paca_tipoplano='+stringtosql(tipoplano)+' and paca_status=''N'''+
                 ' and paca_seq='+stringtosql(Grid.cells[Grid.getcolumn('paca_seq'),Grid.row]) );
    Sistema.commit;
  end;
  EdEncerramento.Enabled:=false;
  EdEncerramento.Visible:=false;

end;

procedure TFAtaplanoacao.EdencerramentoValidate(Sender: TObject);
//var DtQuando:TDatetime;
begin
//  DtQuando:=( Texttodate(FGeral.TiraBarra(Grid.cells[grid.getcolumn('paca_quando'),grid.row])) );
//  if (EdEncerramento.asdate<DtQuando) and (not EdEncerramento.isempty) then
//     EdEncerramento.invalid('Data de encerramento deve ser posterior ao campo Até Quando ?');
end;

procedure TFAtaplanoacao.EdplanoacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
   FGeral.Limpaedit(EdPlanoacao,key);
end;

procedure TFAtaplanoacao.bimpressaoClick(Sender: TObject);
var Q:TSqlquery;
begin
  if EdPlanoacao.isempty then exit;
  Q:=sqltoquery('select * from planoacao where paca_tipoplano='+stringtosql(tipoplano)+' and paca_status=''N'''+
                ' and paca_unid_codigo='+stringtosql(Global.CodigoUnidade)+
                ' and paca_numeroata='+EdPlanoacao.assql+' order by paca_seq');
  if Q.eof then begin
    Avisoerro('Plano de Ação não encontrado');
    FGEral.FechaQuery(Q);
    exit;
  end;
  Sistema.beginprocess('Imprimindo');
  FRel.Init('PlanoAcao');
  FRel.AddTit('Plano de Ação '+EdPlanoacao.text+' - Setor '+EdSEtor_codigo.text+' '+Eddesctipo.text+' - Responsável '+Edrespcodigo.text+' '+SetEdusua_descricao.text);
  FRel.AddTit('Objetivo : '+Edobjetivo.text+' - Data : '+FGeral.formatadata(EdData.asdate));
  FRel.AddCol(100,1,'C','','','O que','','O que',false);
  FRel.AddCol(150,1,'C','','','Como','','Como',false);
  FRel.AddCol(070,1,'D','','','Quando','','Quando',false);
  FRel.AddCol(090,1,'C','','','Quem','','Quem',false);
  FRel.AddCol(150,1,'C','','','Por que','','Por que',false);
  FRel.AddCol(070,1,'D','','','Enc.','','Encerramento',false);
  while not Q.eof do begin
    FRel.AddCel(Q.fieldbyname('paca_oque').asstring);
    FRel.AddCel(Q.fieldbyname('paca_como').asstring);
    FRel.AddCel(Q.fieldbyname('paca_quando').asstring);
    FRel.AddCel(Q.fieldbyname('paca_quem').asstring);
    FRel.AddCel(Q.fieldbyname('paca_porque').asstring);
    FRel.AddCel(Q.fieldbyname('paca_dtencerra').asstring);
    Q.Next;
  end;
  FGeral.FechaQuery(Q);
  Sistema.endprocess('');
  FREl.Video();
end;

procedure TFAtaplanoacao.balterarClick(Sender: TObject);
begin
   OPBotao:='A';
   if OP='A' then begin
     if EdPlanoacao.isempty then exit;
     if (Global.Usuario.Codigo<>Edrespcodigo.asinteger) and (not Global.Usuario.OutrosAcessos[0401]) then begin
       Avisoerro('Responsável por este plano é usuário '+Edrespcodigo.text);
       exit;
     end;
   end;
   GridtoEdits;
   pins.visible:=true;
   EdPaca_oque.setfocus;

end;

procedure TFAtaplanoacao.GridtoEdits;
var aseq,i:integer;
begin
   aseq:=strtointdef(Grid.cells[Grid.getcolumn('paca_seq'),Grid.row],0);
   if aseq=0 then exit;
   i:=Grid.row;
   Edpaca_oque.text:=Grid.Cells[Grid.getcolumn('paca_oque'),i];
   Edpaca_como.text:=Grid.Cells[Grid.getcolumn('paca_como'),i];
   Edpaca_quem.text:=Grid.Cells[Grid.getcolumn('paca_quem'),i];
   Edpaca_usua_codigo.text:=Grid.Cells[Grid.getcolumn('paca_usua_quem'),i];
   Edpaca_quando.setdate( TExttodate( FGeral.TiraBarra(Grid.Cells[Grid.getcolumn('paca_quando'),i],'/') ) );
   Edpaca_porque.text:=Grid.Cells[Grid.getcolumn('paca_porque'),i];
   Edpaca_valor.setvalue( Texttovalor( Grid.Cells[Grid.getcolumn('paca_valor'),i] ) );

end;

procedure TFAtaplanoacao.GeraExcluido;
var aseq,i:integer;
begin

   aseq:=strtointdef(Grid.cells[Grid.getcolumn('paca_seq'),Grid.row],0);
   if aseq=0 then exit;
   i:=Grid.row;
{
   Edpaca_oque.text:=;
   Edpaca_como.text:=;
   Edpaca_quem.text:=;
   Edpaca_usua_codigo.text:=;
   Edpaca_quando.setdate( TExttodate( FGeral.TiraBarra(Grid.Cells[Grid.getcolumn('paca_quando'),i],'/') ) );
   Edpaca_porque.text:=;
   Edpaca_valor.setvalue(  );
}
        Sistema.Insert('planoacao');
        Sistema.SetField('paca_usua_resp',Edrespcodigo.text);
        Sistema.SetField('paca_seto_codigo',EdSetor_codigo.text);
        Sistema.SetField('paca_objetivo',EdObjetivo.text);
        Sistema.SetField('paca_status','C');
        Sistema.SetField('paca_seq',Grid.cells[Grid.getcolumn('paca_seq'),Grid.row]);
        Sistema.SetField('paca_numeroata',EdPlanoacao.text);
        Sistema.SetField('paca_mrnc_numerornc',numerornc);
        Sistema.SetField('paca_unid_codigo',Global.CodigoUnidade);
        Sistema.SetField('paca_situacao','P');
        Sistema.SetField('paca_tipoplano',tipoplano);
        Sistema.SetField('paca_usua_codigo',Global.Usuario.Codigo);
        Sistema.SetField('paca_usua_resp',EdRespcodigo.asinteger);
        Sistema.SetField('paca_usua_exclusao',0);
        Sistema.SetField('paca_data',EdData.asdate);
        Sistema.SetField('paca_dtlcto',Sistema.Hoje);
        Sistema.SetField('paca_oque',Grid.Cells[Grid.getcolumn('paca_oque'),i]);
        Sistema.SetField('paca_como',Grid.Cells[Grid.getcolumn('paca_como'),i]);
        Sistema.SetField('paca_quem',Grid.Cells[Grid.getcolumn('paca_quem'),i]);
        Sistema.SetField('paca_usua_quem',strtointdef(Grid.Cells[Grid.getcolumn('paca_usua_quem'),i],0));
        Sistema.SetField('paca_quando',TExttodate( FGeral.TiraBarra(Grid.Cells[Grid.getcolumn('paca_quando'),i],'/') ));
        Sistema.SetField('paca_porque',Grid.Cells[Grid.getcolumn('paca_porque'),i]);
        Sistema.SetField('paca_dtencerra',Texttodate(''));
        Sistema.SetField('paca_valor',Texttovalor( Grid.Cells[Grid.getcolumn('paca_valor'),i] ));
        Sistema.post('');

end;

procedure TFAtaplanoacao.GridDblClick(Sender: TObject);
begin
   bbaixarclick(self);
end;

procedure TFAtaplanoacao.GridKeyPress(Sender: TObject; var Key: Char);
begin
   if (key=#13) and (Grid.getcolumn('paca_dtencerra')=Grid.col) then
     griddblclick(self);
end;

end.
