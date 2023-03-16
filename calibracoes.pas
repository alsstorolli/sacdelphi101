// 14.04.2021
// Movimento de calibrações de cada medidor / cliente

unit calibracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, SimpleDS,
  SqlSis, Vcl.DBGrids, SQLGrid, Vcl.Grids, SqlDtg, Vcl.Mask, SQLEd,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, SQLBtn, alabel, Arquiv,Geral, SqlExpr, SqlRel ;

type
  TFCalibracoes = class(TForm)
    PCadastro: TPanel;
    PBotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bAlterar: TSQLBtn;
    bExcluir: TSQLBtn;
    bCancelar: TSQLBtn;
    bSair: TSQLBtn;
    bExpColumn: TSQLBtn;
    Bevel1: TBevel;
    bRedColumn: TSQLBtn;
    bMoveLeft: TSQLBtn;
    bMoveRight: TSQLBtn;
    bDelColumn: TSQLBtn;
    bRestColumn: TSQLBtn;
    bLoadGrid: TSQLBtn;
    bSaveGrid: TSQLBtn;
    bGravar: TSQLBtn;
    bRelatorio: TSQLBtn;
    PMens: TSQLPanelGrid;
    Panel1: TPanel;
    PEdits: TSQLPanelGrid;
    Memo: TMemo;
    Grid: TSQLGrid;
    Dts: TDataSource;
    TOcorrencias: TSQLDs;
    EdMocd_fatorcalib: TSQLEd;
    EdMocd_tanque: TSQLEd;
    EdMocd_medido: TSQLEd;
    EdMoca_equi_codigo: TSQLEd;
    EdEqui_descricao: TSQLEd;
    procedure bCancelarClick(Sender: TObject);
    procedure GridNewRecord(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdMocd_medidoExitEdit(Sender: TObject);
    procedure bAlterarClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);

  private
    { Private declarations }
    TipoMov,Categoria:String;
    Entidade         :Integer;
    procedure PreparaEdicao;
  public
    { Public declarations }
    procedure Execute(const CatEntidade:String; const CodEntidade:Integer; const NomEntidade:String;Tipooc:string='';Numero:integer=0);
    procedure LimpaEdits;
    procedure AtivaEdits( atides:boolean );
    procedure Editstogrid;
    function GetSequencia:integer;
    procedure GravaMestre;

  end;

var
  FCalibracoes: TFCalibracoes;
  Numerodoc:integer;
  Tipoocor,
  nomedaentidade :string;
  QBusca,
  QC            : TSqlquery;

implementation

uses SqlFun, equipamentos;

{$R *.dfm}

{ TFCalibracoes }

procedure TFCalibracoes.AtivaEdits( atides:boolean );
//////////////////////////////////////////////
begin

   EdMocd_fatorcalib.Enabled := atides;
   EdMocd_tanque.Enabled := atides;
   EdMocd_medido.Enabled := atides ;

end;

procedure TFCalibracoes.bAlterarClick(Sender: TObject);
//////////////////////////////////////////////////////////
begin

  if TOcorrencias.IsEmpty then Exit;
  TipoMov:='A';
//  bgravar.enabled := true;
  bGravar.Black;
  Memo.Enabled:=true;
  Memo.setfocus;

end;

procedure TFCalibracoes.bCancelarClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

  Memo.Enabled:=False;
  bGravar.White;
  bIncluir.Black;
  bAlterar.Black;
  TipoMov:='';
  AtivaEdits( false );
  GridNewRecord(Self);

end;

procedure TFCalibracoes.bExcluirClick(Sender: TObject);
///////////////////////////////////////////////////////////
begin

   if not Confirma('Confirma exclusão') then exit;
   TOcorrencias.Edit;
   TOcorrencias.fieldbyname('Mocd_status').asstring:='C';
   TOcorrencias.Post;
   TOcorrencias.Commit;
   TOcorrencias.Refresh;

end;

procedure TFCalibracoes.bGravarClick(Sender: TObject);
//////////////////////////////////////////////////////////////
var GravaUsu:Boolean;
begin

  GravaUsu:=False;
  if (TipoMov='I') and (EdMocd_medido.asinteger>0 )  then begin

     TOcorrencias.Insert;
     TOcorrencias.FieldByName('Mocd_Tipo_Codigo').AsInteger  := Entidade;
//     TOcorrencias.FieldByName('Mocd_Data').AsDateTime        := Sistema.Hoje;
     TOcorrencias.FieldByName('Mocd_Unid_Codigo').AsString   :=Global.CodigoUnidade;
     TOcorrencias.FieldByName('Mocd_Mped_Numerodoc').AsInteger:=Numerodoc;
     TOcorrencias.FieldByName('Mocd_Transacao').AsString      :=strzero(GetSequencia,3);
     TOcorrencias.FieldByName('Mocd_fatorcalib').asfloat := EdMocd_fatorcalib.asfloat;
     TOcorrencias.FieldByName('Mocd_tanque').asinteger   := EdMocd_tanque.asinteger;
     TOcorrencias.FieldByName('Mocd_medido').asinteger   := EdMocd_medido.asinteger;
     TOcorrencias.FieldByName('mocd_status').Asstring:='N';
     TOcorrencias.Post;
     TOcorrencias.Commit;

     GravaMestre;
// 'reposiciona' qc pois quando 'inclui ainda não existe no meste movcalibracoes
     Qc := Sqltoquery('select * from MovCalibracoes where moca_status = ''N'''+
                   ' and moca_mped_numerodoc = '+inttostr(NUmerodoc)+
                   ' and moca_tipo_codigo    = '+inttostr(Entidade)+
                   ' and moca_unid_codigo    = '+Stringtosql(Global.codigounidade)+
                   ' order by moca_mped_numerodoc');

  end else if TipoMov='A' then begin

//     GravaUsu:=TOcorrencias.FieldByName('Moca_Trabalho').AsString <> Memo.Text;
//     TOcorrencias.Edit;
//     TOcorrencias.FieldByName('Moca_Trabalho').AsString:=Memo.Text;
        GravaMestre;

  end;



{
  if TipoMov='I' then begin

     TOcorrencias.Refresh;

  end;
}

  bCancelarClick(Self);

end;


procedure TFCalibracoes.bIncluirClick(Sender: TObject);
////////////////////////////////////////////////////////////
begin

  TipoMov:='I';
  PreparaEdicao;

end;

procedure TFCalibracoes.bRelatorioClick(Sender: TObject);
////////////////////////////////////////////////////////////////////
var i:Integer; P:Pointer;
begin

  FRel.Init('RelCalibracoes');
  FRel.AddTit('Relação de Calibrações '+Caption);
  FRel.AddCol(70,1,'D','','','Data','','Data da ocorrência',False);;
  FRel.AddCol(40,1,'C','','','Codigo','','Código do equipamento',False);;
  FRel.AddCol(60,1,'C','','','Equipamento','','Descrição do equipamento',False);;
  FRel.AddCol(60,1,'N','','','Fator Calib.','','Fato de calibração',False);;
  FRel.AddCol(60,1,'N','+','','Tanque','','Tanque',False);;
  FRel.AddCol(60,1,'N','+','','Medido','','Medido',False);;
  FRel.AddCol(400,1,'C','','','Trabalhos Efetuados','','Trabalhos Efetuados',False);;
  TOcorrencias.DisableControls;
  P:=TOcorrencias.GetBookmark;
  TOcorrencias.First;
  while not TOcorrencias.Eof do begin

      FRel.AddCel(Qc.FieldByName('Moca_Data').AsString);
      FRel.AddCel(Qc.FieldByName('Moca_Equi_codigo').AsString);
      FRel.AddCel( FEquipamentos.GetDescricao(Qc.FieldByName('Moca_Equi_codigo').AsString) );
      FRel.AddCel(TOcorrencias.FieldByName('Mocd_fatorcalib').AsString);
      FRel.AddCel(TOcorrencias.FieldByName('Mocd_tanque').AsString);
      FRel.AddCel(TOcorrencias.FieldByName('Mocd_medido').AsString);
      FRel.AddCel('');
      TOcorrencias.Next;

  end;

     Memo.Text:=Qc.FieldByName('Moca_Trabalho').AsString;
     if Memo.Lines.Count>0 then begin

//        FRel.AddCel(Memo.Lines[0]);
        for i:=0 to Memo.Lines.Count-1 do begin

            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel('');
            FRel.AddCel(Memo.Lines[i]);

        end;

     end;

  FRel.Video;
  TOcorrencias.GotoBookmark(P);
  TOcorrencias.EnableControls;

end;

procedure TFCalibracoes.Editstogrid;
/////////////////////////////////////////
begin
{
  Grid.Columns[0].FieldName:='Mocd_fatorcalib';
  Grid.Columns[0].Title.Caption :='Fator Calib.';
  Grid.Columns[1].FieldName:='Mocd_Tanque';
  Grid.Columns[1].Title.Caption:='Tanque';
  Grid.Columns[2].FieldName:='Mocd_Medido';
  Grid.Columns[2].Title.Caption:='Medido';
  Grid.Columns[3].FieldName:='Mocd_mped_numerodoc';
  Grid.Columns[3].Title.Caption:='Numero Doc.';
  Grid.Columns[4].FieldName:='Mocd_transacao';
  Grid.Columns[4].Title.Caption:='Sequencial';
}

end;

procedure TFCalibracoes.EdMocd_medidoExitEdit(Sender: TObject);
///////////////////////////////////////////////////////////////////////
begin

    if not Confirma( 'Confirma calibração ?' ) then exit;

    bgravarclick(self);
    AtivaEdits( false );


end;

procedure TFCalibracoes.Execute(const CatEntidade: String;
  const CodEntidade: Integer; const NomEntidade: String; Tipooc: string;
  Numero: integer);
//////////////////////////////////////////////////////////////////////////////
begin

  Categoria     :=CatEntidade;
  Entidade      :=CodEntidade;
  NomedaEntidade:=nomEntidade;
  Numerodoc     :=Numero;
  Tipoocor      :=Tipooc;

  if not Arq.TClientes.Active then begin

    Arq.TClientes.Open;
    Arq.TClientes.Locate('clie_codigo',inttostr(codentidade),[])

  end;

  TOcorrencias.DBConnection:=Sistema.Conexao;
  TOcorrencias.TableName:='MovCalibracoesDet';
  TOcorrencias.TableFields:='*';
  TOcorrencias.OpenWith('Mocd_Tipo_codigo='+IntToStr(CodEntidade)+
                       ' and mocd_mped_numerodoc = '+inttostr(Numerodoc)+
                       ' and '+FGeral.Getin('Mocd_status','N;E','C'),'mocd_mped_numerodoc');

  Grid.Columns[0].FieldName:='Mocd_fatorcalib';
  Grid.Columns[0].Title.Caption :='Fator Calib.';
  Grid.Columns[1].FieldName:='Mocd_Tanque';
  Grid.Columns[1].Title.Caption:='Tanque';
  Grid.Columns[2].FieldName:='Mocd_Medido';
  Grid.Columns[2].Title.Caption:='Medido';
  Grid.Columns[3].FieldName:='Mocd_mped_numerodoc';
  Grid.Columns[3].Title.Caption:='Numero Doc.';
  Grid.Columns[4].FieldName:='Mocd_transacao';
  Grid.Columns[4].Title.Caption:='Sequencial';

  Memo.clear;
  LimpaEdits;
  EdMoca_equi_codigo.clear;

  Caption:='Calibrações : '+NomedaEntidade;
  Grid.Configurar;
//  FGeral.ColunasGrid(Grid,Self);
  bCancelarClick(Self);
  QBusca := sqltoquery(FGeral.buscapedvenda(Numerodoc));
  Qc := Sqltoquery('select * from MovCalibracoes where moca_status = ''N'''+
                   ' and moca_mped_numerodoc = '+inttostr(NUmerodoc)+
                   ' and moca_tipo_codigo    = '+inttostr(Entidade)+
                   ' and moca_unid_codigo    = '+Stringtosql(Global.codigounidade)+
                   ' order by moca_mped_numerodoc');
  if not Qc.eof then begin

    Memo.text := Qc.fieldbyname('moca_trabalho').asstring;
    EdMoca_equi_codigo.text := Qc.fieldbyname('moca_equi_codigo').asstring;
    EdMoca_equi_codigo.validfind;

  end;

  FGeral.ConfiguraColorEditsNaoEnabled(FCalibracoes);

  ShowModal;

end;

function TFCalibracoes.GetSequencia: integer;
//////////////////////////////////////////////////
var Q:Tsqlquery;
begin

   Q := Sqltoquery('select mocd_transacao from MovCalibracoesDet where mocd_status = ''N'''+
                   ' and mocd_mped_numerodoc = '+inttostr(NUmerodoc)+
                   ' and mocd_tipo_codigo    = '+inttostr(Entidade)+
                   ' and mocd_unid_codigo    = '+Stringtosql(Global.codigounidade)+
                   ' order by mocd_transacao desc');
   if Q.eof then result := 1
   else result := strtoint(Q.fieldbyname('mocd_transacao').asstring)+ 1;
   FGeral.Fechaquery( Q );

end;

procedure TFCalibracoes.GravaMestre;
////////////////////////////////////////
var Q:Tsqlquery;
begin

   Q := Sqltoquery('select moca_mped_numerodoc from MovCalibracoes where moca_status = ''N'''+
                   ' and moca_mped_numerodoc = '+inttostr(NUmerodoc)+
                   ' and moca_tipo_codigo    = '+inttostr(Entidade)+
                   ' and moca_unid_codigo    = '+Stringtosql(Global.codigounidade)+
                   ' order by moca_transacao');
   if Q.eof then begin

      Sistema.Insert('movcalibracoes');
      Sistema.Setfield('Moca_status','N');
      Sistema.Setfield('Moca_Unid_Codigo',Global.codigounidade);
      Sistema.Setfield('Moca_transacao',Qbusca.fieldbyname('mped_transacao').asstring);
      Sistema.Setfield('Moca_mped_numerodoc',NUmerodoc);
//      Sistema.Setfield('Moca_vazaomedia',??);
      Sistema.Setfield('Moca_Equi_Codigo',EdMoca_equi_codigo.text);
      Sistema.Setfield('Moca_tipo_codigo',Entidade );
      Sistema.Setfield('Moca_Data',Sistema.hoje );
      Sistema.Setfield('Moca_Trabalho',Memo.text );

      Sistema.post;

   end else begin

      Sistema.Edit('movcalibracoes');

      Sistema.Setfield('Moca_Trabalho',Memo.text );

      Sistema.post('moca_mped_numerodoc = '+inttostr(NUmerodoc)+
                   ' and moca_status = ''N'''+
                   ' and moca_tipo_codigo    = '+inttostr(Entidade)+
                   ' and moca_unid_codigo    = '+Stringtosql(Global.codigounidade) );


   end;

   Sistema.commit;
   FGeral.Fechaquery( Q );


end;

procedure TFCalibracoes.GridNewRecord(Sender: TObject);
///////////////////////////////////////////////////////
begin

//  Memo.Text:=TOcorrencias.FieldByName('Moca_Trabalho').Text;////

end;

procedure TFCalibracoes.LimpaEdits;
//////////////////////////////////////
begin

   EdMocd_fatorcalib.clear;
   EdMocd_tanque.clear;
   EdMocd_medido.clear;

end;

procedure TFCalibracoes.PreparaEdicao;
///////////////////////////////////////////
begin

  bIncluir.Black;
  bAlterar.Black;
  bGravar.Black;
  if TipoMov='I' then begin

//     Memo.Clear;
     LimpaEdits;
     bIncluir.Red;
     AtivaEdits(true);
     Memo.Enabled:=True;
     if EdMoca_equi_codigo.isempty then begin

        EdMoca_equi_codigo.enabled:=true;
        EdMoca_equi_codigo.setfocus;

     end else begin

        EdMoca_equi_codigo.enabled:=false;
        EdMocd_fatorcalib.setfocus;

     end;

  end else begin

     bAlterar.Red;
     Memo.Enabled:=True;
     Memo.SetFocus;

  end;


end;


end.
