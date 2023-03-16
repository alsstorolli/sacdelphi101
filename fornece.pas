unit fornece;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ExtCtrls, Buttons, SQLBtn, StdCtrls, alabel, SQLGrid, Grids,
  DBGrids, Mask, SQLEd, SQLExpr, SQLSis, Menus, ACBrBase, ACBrDFe, ACBrNFe;

type
  TFFornece = class(TForm)
    PMens: TSQLPanelGrid;
    PBotoes: TSQLPanelGrid;
    DSFornec: TDataSource;
    SQLPanelGrid1: TSQLPanelGrid;
    Grid: TSQLGrid;
    PInsert: TSQLPanelGrid;
    EdForn_codigo: TSQLEd;
    EdForn_nome: TSQLEd;
    EdForn_razaosocial: TSQLEd;
    EdForn_cnpjcpf: TSQLEd;
    EdForn_inscricaoestadual: TSQLEd;
    EdForn_inscricaomunicipal: TSQLEd;
    EdForn_regjuntacomercial: TSQLEd;
    EdForn_atividade: TSQLEd;
    EdForn_tipofrete: TSQLEd;
    EdForn_pzentrega: TSQLEd;
    EdForn_endereco: TSQLEd;
    EdForn_bairro: TSQLEd;
    EdForn_cep: TSQLEd;
    EdForn_cxpostal: TSQLEd;
    EdForn_muni_codigo: TSQLEd;
    EdForn_municipio: TSQLEd;
    EdForn_uf: TSQLEd;
    EdForn_fone: TSQLEd;
    EdForn_fax: TSQLEd;
    EdForn_email: TSQLEd;
    EdForn_fpgt_codigo: TSQLEd;
    EdForn_vendedor: TSQLEd;
    EdForn_fonevendedor: TSQLEd;
    EdForn_celularvendedor: TSQLEd;
    EdForn_faxvendedor: TSQLEd;
    EdForn_gerente: TSQLEd;
    EdForn_fonegerente: TSQLEd;
    EdForn_celulargerente: TSQLEd;
    EdForn_descpedidos: TSQLEd;
    EdForn_obspedidos: TSQLEd;
    EdForn_contacontabil: TSQLEd;
    EdForn_enderecoind: TSQLEd;
    EdForn_muniind_codigo: TSQLEd;
    EdForn_municipioindustria: TSQLEd;
    EdForn_ufindustria: TSQLEd;
    EdForn_foneindustria: TSQLEd;
    EdForn_faxindustria: TSQLEd;
    EdForn_obstrocas: TSQLEd;
    EdForn_usua_codigo: TSQLEd;
    EdFORN_DATACAD: TSQLEd;
    APHeadLabel1: TAPHeadLabel;
    bIncluir: TSQLBtn;
    bAlterar: TSQLBtn;
    bExcluir: TSQLBtn;
    bCancelar: TSQLBtn;
    bFiltrar: TSQLBtn;
    bOrdenar: TSQLBtn;
    bPesquisar: TSQLBtn;
    bRelatorio: TSQLBtn;
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
    bRestaurar: TSQLBtn;
    bEditar: TSQLBtn;
    EdForn_contribuinte: TSQLEd;
    PopupMenu: TPopupMenu;
    Cadatro1: TMenuItem;
    Cadastro1: TMenuItem;
    Histrico1: TMenuItem;
    EdForn_descpgtodia: TSQLEd;
    EdForn_pzpgto: TSQLEd;
    FinanceiroIncluses1: TMenuItem;
    FinaceiroBaixas1: TMenuItem;
    FinanceiroPendncias1: TMenuItem;
    ResumoMovimentos1: TMenuItem;
    EdFORN_DATAALT: TSQLEd;
    EdForn_ContaExp: TSQLEd;
    EdForn_email1: TSQLEd;
    Edunid_exp01: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdForn_ContaExp02: TSQLEd;
    Edforn_unidexporta01: TSQLEd;
    SQLEd4: TSQLEd;
    EdForn_ContaExp03: TSQLEd;
    EdForn_unidexporta03: TSQLEd;
    SQLEd5: TSQLEd;
    EdForn_contaexp04: TSQLEd;
    EdForn_unidexporta04: TSQLEd;
    SQLEd6: TSQLEd;
    EdForn_certificado: TSQLEd;
    EdForn_devocompra: TSQLEd;
    Edforn_naocontab: TSQLEd;
    bcnpj: TSQLBtn;
    ACBrNFe1: TACBrNFe;
    EdForn_compraremFutura001: TSQLEd;
    EdForn_compraremFutura002: TSQLEd;
    procedure EdForn_muni_codigoValidate(Sender: TObject);
    procedure EdForn_muniind_codigoValidate(Sender: TObject);
    procedure bIncluirClick(Sender: TObject);
    procedure EdForn_codvincKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdForn_codigoExitEdit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdForn_razaosocialValidate(Sender: TObject);
    procedure bEditarClick(Sender: TObject);
    procedure EdForn_cnpjcpfValidate(Sender: TObject);
    procedure EdForn_situacaoValidate(Sender: TObject);
    procedure EdForn_situacaoEnter(Sender: TObject);
    procedure Cadastro1Click(Sender: TObject);
    procedure bRelatorioClick(Sender: TObject);
    procedure ResumoMovimentos1Click(Sender: TObject);
    procedure FinanceiroIncluses1Click(Sender: TObject);
    procedure FinaceiroBaixas1Click(Sender: TObject);
    procedure FinanceiroPendncias1Click(Sender: TObject);
    procedure Histrico1Click(Sender: TObject);
    procedure bOcorrenciasClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure EdForn_ufKeyPress(Sender: TObject; var Key: Char);
    procedure EdForn_nomeValidate(Sender: TObject);
    procedure bcnpjClick(Sender: TObject);
  private
//    _Sit:String;
  public
    function ValidaFornecedor(Codigo:Integer):Boolean;  //Verifica se o fornecedor est� liberado no sistema
    procedure execute;
    function GetNome(codigo:integer):string;
    function GetContaExp(codigo:integer; unidade:string=''):integer;
    function GetRazaoSocial(codigo:integer):string;
    function GetCnpjCpf(codigo:integer;masc:string='N'):string;
    function GetInsEst(codigo:integer):string;
    function GetUf(codigo:integer):string;
    function GetCidade(codigo:integer):string;
    function GetPopulacao(codigo:integer):integer;
    procedure SetaItems(Edit,EditNomeForne:TSqlEd;ForneValidos,Nomevalido:String);
    function GetEmails(ListaCodigos:String):string;
// 20.04.09
    function GetContaExpDevCompra(codigo:integer; unidade:string=''):integer;
// 26.10.09
    function GetEndereco(codigo:integer):string;
// 09.09.14
    procedure ConfiguraEditsNaoEnabled;
// 27.11.18
   function GetCodigoCidade(codigo:integer):integer;
// 28.10.19
    function GetContaExpCompraRemessaFutura(codigo:integer; unidade:string=''):integer;
// 15.08.20
    function GetCelular(codigo:integer):string;
// 14.06.2021
    function GetNomepelocnpj(cnpjcpf:string):string;

  end;


var
  FFornece: TFFornece;
  OP:string;

implementation

uses Arquiv, SQLFun, Geral, Usuarios , SQLRel, expnfetxt;
//, RelFin, Ocorrenc;

{$R *.dfm}


procedure TFFornece.execute;
///////////////////////////////
var campo:TDicionario;
begin
  EdForn_Codigo.SetStatusEdits(Self,99,seGrid);
// 20.04.09
  campo:=Sistema.GetDicionario('fornecedores','forn_devocompra');
  if campo.Tipo<>'' then begin
    EdForn_Devocompra.Enabled:=true;
    EdForn_Devocompra.TableField:='forn_devocompra';
  end else begin
    EdForn_Devocompra.Enabled:=false;
    EdForn_Devocompra.TableField:='';
  end;
// 28.12.16
  campo:=Sistema.GetDicionario('fornecedores','forn_naocontab');
  if campo.Tipo<>'' then begin
    EdForn_Naocontab.Enabled:=true;
    EdForn_Naocontab.TableField:='forn_naocontab';
  end else begin
    EdForn_Naocontab.Enabled:=false;
    EdForn_Naocontab.TableField:='';
  end;
  Edforn_naocontab.enabled:=(Global.Usuario.OutrosAcessos[0062]);
  if not Global.Usuario.OutrosAcessos[0062] then EdForn_Naocontab.TableField:='';
// 26.10.10
  FGeral.ConfiguraTamanhoEditsEnabled(FFornece,FGeral.GetConfig1AsInteger('tamanholetra'));
  EdForn_endereco.Empty:=not Global.Topicos[1114];
// 28.10.19
  campo:=Sistema.GetDicionario('fornecedores','Forn_compraremFutura001');
  if campo.Tipo<>'' then begin

    EdForn_compraremFutura001.Enabled:=true;
    EdForn_compraremFutura001.TableField:='Forn_compraremFutura001';
    EdForn_compraremFutura002.Enabled:=true;
    EdForn_compraremFutura002.TableField:='Forn_compraremFutura002';

  end else begin

    EdForn_compraremFutura001.Enabled:=false;
    EdForn_compraremFutura001.TableField:='';
    EdForn_compraremFutura002.Enabled:=false;
    EdForn_compraremFutura002.TableField:='';

  end;


  FFornece.ShowMOdal;

end;

function TFFornece.ValidaFornecedor(Codigo:Integer):Boolean;
////////////////////////////////////////////////////////////////
var Q:TSQLQuery;
begin
  Result:=false;
  if Arq.TFornec.FieldByName('FORN_CODIGO').AsInteger<>Codigo then begin
     Q:=SQLToQuery('SELECT FORN_SITUACAO FROM FORNECEDORES WHERE FORN_CODIGO='+IntToStr(Codigo));
      if Q.FieldByName('FORN_SITUACAO').AsString='N' then Result:=true
      else if Q.FieldByName('FORN_SITUACAO').AsString='A' then begin
         if FUsuarios.Acesso(5) then Result:=true
         else AvisoErro('Fornecedor n�o autorizado');
      end else AvisoErro('Fornecedor impedido');
     Q.Close;
     Q.Free;
  end else begin
     if Arq.TFornec.FieldByName('FORN_SITUACAO').AsString='N' then Result:=true
     else if Arq.TFornec.FieldByName('FORN_SITUACAO').AsString='A' then begin
        if FUsuarios.Acesso(5) then Result:=true
        else AvisoErro('Fornecedor n�o autorizado');
     end else AvisoErro('Fornecedor impedido');
  end;
end;




procedure TFFornece.EdForn_muni_codigoValidate(Sender: TObject);
begin
  if EdForn_Muni_Codigo.AsInteger>0 then begin
     EdForn_UF.Text:=EdForn_Muni_Codigo.ResultFind.FieldByName('Cida_UF').AsString;
  end;
end;




procedure TFFornece.EdForn_muniind_codigoValidate(Sender: TObject);
begin
  if EdForn_Muniind_Codigo.AsInteger>0 then begin
     EdForn_UFIndustria.Text:=EdForn_MuniInd_Codigo.ResultFind.FieldByName('Cida_UF').AsString;
  end;
end;




procedure TFFornece.bIncluirClick(Sender: TObject);
///////////////////////////////////////////////////////
begin
//  if EdForn_codigo.StatusEdit<>SeEdit then begin
// 24.07.07
  if (Grid.Focused)  then begin
    PInsert.BringToFront;
    OP:='I';
  // 20.07.07
    EdForn_codigo.SetStatusEdits(FFornece,99,SeEditAll);
    Grid.Insert(EdForn_Nome);
    bSair.enabled:=false;
    ConfiguraEditsNaoEnabled;
  ///
    EdForn_Usua_Codigo.SetValue(StrToInt(Sistema.CodigoUsuario));
  end;
end;




procedure TFFornece.EdForn_codvincKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var Q:TSQLQuery;
    v:String;
begin
  if Key=VK_F12 then begin
     Q:=SQLToQuery('SELECT MAX(FORN_CODVINC) as CVincMax FROM FORNECEDORES');
     if Q.FieldByName('CVincMax').AsInteger=0 then v:='1'
     else v:=IntToStr(Q.FieldByName('CVincMax').AsInteger+1);
     Aviso('Pr�ximo c�digo de vincula��o : '+v);
     Q.Close;
     Q.Free;
  end;
end;




procedure TFFornece.EdForn_codigoExitEdit(Sender: TObject);
begin
  if (EdForn_Codigo.StatusEdit=seEditAll) and (OP<>'I') then begin
     if Arq.TFornec.fieldbyname('forn_uf').asstring<>EdForn_uf.text then begin
       if not confirma('Cadastro est� com UF '+Arq.TFornec.fieldbyname('forn_uf').asstring+'.  Mudar para UF '+EdForn_uf.text+' ?') then
          exit;
     end;
     Arq.TFornec.Edit;
     EdForn_Codigo.SetFields(Self,99);
     Arq.TFornec.Post;
     Arq.TFornec.Commit;
     PInsert.Hide;
     EdForn_Codigo.SetStatusEdits(Self,99,seGrid);
     beditar.Enabled:=true;
  end else begin
//     EdForn_Codigo.Text:=IntToStr(FGeral.GetContador('Forn_Codigo',true));
// 12.06.17 - SM
     if ( ( Global.Topicos[1114] ) and ( not EdForn_endereco.IsEmpty ) )
       or
        ( ( not Global.Topicos[1114] ) )
      then begin

       EdForn_Codigo.Text:=IntToStr(FGeral.GetProximoCodigoCadastro('Fornecedores','Forn_Codigo'));
       EdForn_DataCad.Text:=DateToText(Sistema.Hoje);
       Grid.PostInsert(EdForn_Nome);
  //     EdForn_Codigo.SetStatusEdits(Self,99,seGrid);
  // 06.07.09
       EdForn_Codigo.SetStatusEdits(Self,99,seEditAll);
     end else if Global.Topicos[1114] then
       Avisoerro('Obrigat�rio preencher o endere�o');

     bincluir.Enabled:=true;
  end;
  bSair.enabled:=true;
end;




procedure TFFornece.FormActivate(Sender: TObject);
///////////////////////////////////////////////////////////
var campo:TDicionario;
begin

  if not Arq.TFornec.Active then Arq.TFornec.Open;

  FGeral.ColunasGrid(Grid,Self);

//  if FUsuarios.Acesso(3) then EdForn_Situacao.OpGrids:=[ogFilter,ogFind,ogEdit]
//  else EdForn_Situacao.OpGrids:=[ogFilter,ogFind];
  OP:='E';
  Grid.Cancel;
  Edforn_naocontab.enabled:=(Global.Usuario.OutrosAcessos[0062]);
// 28.10.19
  campo:=Sistema.GetDicionario('fornecedores','Forn_compraremFutura001');
  if campo.Tipo<>'' then begin

    EdForn_compraremFutura001.Enabled:=true;
    EdForn_compraremFutura001.TableField:='Forn_compraremFutura001';
    EdForn_compraremFutura002.Enabled:=true;
    EdForn_compraremFutura002.TableField:='Forn_compraremFutura002';

  end else begin

    EdForn_compraremFutura001.Enabled:=false;
    EdForn_compraremFutura001.TableField:='';
    EdForn_compraremFutura002.Enabled:=false;
    EdForn_compraremFutura002.TableField:='';

  end;

  Grid.Configurar;

end;




procedure TFFornece.EdForn_razaosocialValidate(Sender: TObject);
begin
  if (EdForn_Nome.IsEmpty) and (EdForn_RazaoSocial.IsEmpty) then EdForn_RazaoSocial.Invalid('Preencher pelo menos o nome ou raz�o social do fornecedor');
end;



// 11.03.19 - Novicarnes
procedure TFFornece.bcnpjClick(Sender: TObject);
////////////////////////////////////////////////////
var ps:integer;

begin

  if grid.Focused then exit;

  if trim( FGeral.GetConfig1AsString('Pastaschemas') ) <> '' then
    Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=FGeral.GetConfig1AsString('Pastaschemas')
  else
    Acbrnfe1.Configuracoes.Arquivos.PathSchemas:=ExtractFilePath( Application.ExeName )+'Schemas20';
  acbrnfe1.Configuracoes.Certificados.NumeroSerie:=FGeral.GetNroSerieCertificado(Global.codigounidade);

  if Edforn_cnpjcpf.Enabled then begin

    if EdForn_uf.isempty then
      ACBrNFe1.WebServices.ConsultaCadastro.UF  := Global.UfUnidade
    else
      ACBrNFe1.WebServices.ConsultaCadastro.UF  := EdForn_uf.text;
    if Length(EdForn_cnpjcpf.text) > 11 then
       ACBrNFe1.WebServices.ConsultaCadastro.CNPJ := EdForn_cnpjcpf.text
    else
       ACBrNFe1.WebServices.ConsultaCadastro.CPF := EdForn_cnpjcpf.text;


    if  ACBrNFe1.WebServices.ConsultaCadastro.Executar then begin

      EdForn_inscricaoestadual.text:=FExpNfetxt.GetTag('IE',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      EdForn_razaosocial.text:=FExpNfetxt.GetTag('xnome',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      ps:=pos('&amp;',EdForn_razaosocial.text);
      if ps>0 then EdForn_razaosocial.text:=copy(EdForn_razaosocial.text,1,ps)+copy(EdForn_razaosocial.text,ps+length('&amp;'),30);
      EdForn_razaosocial.Next;
      EdForn_endereco.text:=FExpNfetxt.GetTag('xlgr',ACBrNFe1.WebServices.ConsultaCadastro.RetWS)+','+
                          FExpNfetxt.GetTag('nro',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      EdForn_bairro.text:=FExpNfetxt.GetTag('xbairro',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      EdForn_cep.text:=FExpNfetxt.GetTag('cep',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      EdForn_uf.text:=FExpNfetxt.GetTag('uf',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      EdForn_nome.text:=FExpNfetxt.GetTag('xnome',ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
      if EdForn_datacad.IsEmpty then
         EdForn_datacad.SetDate( Sistema.Hoje );
      EdForn_nome.SetFocus;

    end else begin

//      avisoerro('CNPJ / CPF n�o encontrado na consulta pela UF '+ACBrNFe1.WebServices.ConsultaCadastro.UF);
      avisoerro( ACBrNFe1.WebServices.ConsultaCadastro.xMotivo )

    end;
  end else
    bsair.Enabled:=true;

end;

procedure TFFornece.bEditarClick(Sender: TObject);
begin
//  if EdForn_codigo.StatusEdit=SeEdit then begin
// 24.07.07
//  if EdForn_codigo.StatusEdit<>SeEdit then begin
// 24.07.07
  if (Grid.Focused)  then begin
    EdForn_Codigo.SetStatusEdits(Self,99,seEditAll);
    OP:='E';
    PInsert.BringToFront;
    PInsert.Show;
    EdForn_Codigo.GetFields(Self,99);
    EdForn_Muni_Codigo.Valid;
    EdForn_Muniind_Codigo.Valid;
    bSair.enabled:=false;
    ConfiguraEditsNaoEnabled;
    EdForn_Nome.SetFocus;
  end;
end;


procedure TFFornece.EdForn_cnpjcpfValidate(Sender: TObject);
var Q:TSqlQuery;
begin
  if (not Global.Topicos[1101]) and (EdForn_cnpjcpf.IsEmpty) then begin
     EdForn_cnpjcpf.Invalid('N�o permitido conte�do vazio');
     Exit;
  end;
  if (Global.Topicos[1101]) and (EdForn_cnpjcpf.IsEmpty) then Exit;
  if not Global.Topicos[1102] then FGeral.ValidaCNPJCPF(EdForn_CNPJCPF);
  if not Global.Topicos[1103] then begin
     if EdForn_cnpjcpf.StatusEdit=seEditall then begin
       Q:=SqlToQuery('SELECT Forn_CNPJCPF FROM FORNECEDORES WHERE Forn_CNPJCPF='''+EdForn_CNPJCPF.Text+''''+
           ' and Forn_Codigo<>'+EdForn_codigo.AsSql);
//       if not Q.IsEmpty then EdForn_CNPJCPF.Invalid('CNPJ/CPF j� cadastrado');
// 17.08.05
       if not Q.IsEmpty then avisoerro('CNPJ/CPF j� cadastrado');
       Q.Close;
       Freeandnil(Q);
     end;
  end;
end;




procedure TFFornece.EdForn_situacaoValidate(Sender: TObject);
begin
(*
  if EdForn_Situacao.StatusEdit=seEditAll then begin
     if (not FUsuarios.Acesso(3)) and (Trim(EdForn_Situacao.Text)<>_Sit) then begin
        EdForn_Situacao.Invalid('Usu�rio n�o autorizado a alterar a situa��o do fornecedor');
        EdForn_Situacao.Text:=_Sit;
     end;
  end;
*)
end;




procedure TFFornece.EdForn_situacaoEnter(Sender: TObject);
begin
//  _Sit:=Trim(EdForn_Situacao.Text);
end;




procedure TFFornece.Cadastro1Click(Sender: TObject);
begin
//  Grid.Report('RelCadFornece','Rela��o Dos Fornecedores Cadastrados','','');
  FRel.Reportfromsql('select * from fornecedores','RelCadFornece','Rela��o Dos Fornecedores Cadastrados');
end;




procedure TFFornece.bRelatorioClick(Sender: TObject);
begin
  PopupMenu.Popup(Self.Left+520,Self.Top+228);
end;




procedure TFFornece.ResumoMovimentos1Click(Sender: TObject);
begin
//  FRelFin.ResumoMvtoFornecedores;
end;




procedure TFFornece.FinanceiroIncluses1Click(Sender: TObject);
begin
//  FRelFin.PendFinEntidade('F',Arq.TFornec.FieldByName('Forn_codigo').AsInteger,'I');
end;




procedure TFFornece.FinaceiroBaixas1Click(Sender: TObject);
begin
//  FRelFin.PendFinEntidade('F',Arq.TFornec.FieldByName('Forn_codigo').AsInteger,'B');
end;




procedure TFFornece.FinanceiroPendncias1Click(Sender: TObject);
begin
//  FRelFin.PendFinEntidade('F',Arq.TFornec.FieldByName('Forn_codigo').AsInteger,'P');
end;




procedure TFFornece.Histrico1Click(Sender: TObject);
begin
//  FRelFin.RelHistorico(IntToStr(Arq.TFornec.FieldByName('Forn_codigo').AsInteger),'F');
end;




procedure TFFornece.bOcorrenciasClick(Sender: TObject);
begin
//  FOcorrencias.Execute('F',Arq.TFornec.FieldByName('Forn_Codigo').AsInteger,Arq.TFornec.FieldByName('Forn_Nome').AsString);
end;

function TFFornece.GetNome(codigo: integer): string;
begin
  if not Arq.TFornec.active then Arq.TFornec.open;
  if Arq.TFornec.Locate('forn_codigo',codigo,[]) then
    result:=Arq.TFornec.fieldbyname('forn_nome').asstring
  else
    result:='';
  FGeral.ConfiguraColorEditsNaoEnabled(FFornece);
end;



// 27.11.1
// 14.06.2021
function TFFornece.GetNomepelocnpj(cnpjcpf: string): string;
//////////////////////////////////////////////////////
var Q:TSqlquery;
begin

   Q:=sqltoquery('select forn_nome from fornecedores where forn_cnpjcpf = '+stringtosql(cnpjcpf));
   if not Q.Eof then result:=Q.FieldByName('forn_nome').AsString else result:='';
   Q.Close;

end;

function TFFornece.GetCodigoCidade(codigo: integer): integer;
////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin

   Q:=sqltoquery('select forn_cida_codigo from fornecedores where forn_codigo = '+inttostr(codigo));
   if not Q.Eof then result:=Q.FieldByName('forn_cida_codigo').AsInteger else result:=0;
   Q.Close;

end;

function TFFornece.GetContaExp(codigo: integer ; unidade:string=''): integer;
//////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from Fornecedores where forn_codigo='+inttostr(codigo));
  if not Q.eof then begin
    if trim(unidade)='' then
      result:=Q.fieldbyname('forn_contaexp').asinteger
// 13.05.10 - Abra - Ligiane
    else if Global.Topicos[1010] then
      result:=Q.fieldbyname('forn_contaexp').asinteger
    else if unidade=Q.FieldByName('Forn_unidexporta01').asstring then
      result:=Q.fieldbyname('forn_contaexp').asinteger
    else if unidade=Q.FieldByName('Forn_unidexporta02').asstring then
      result:=Q.fieldbyname('Forn_ContaExp02').asinteger
    else if unidade=Q.FieldByName('Forn_unidexporta03').asstring then
      result:=Q.fieldbyname('Forn_ContaExp03').asinteger
    else if unidade=Q.FieldByName('Forn_unidexporta04').asstring then
      result:=Q.fieldbyname('Forn_ContaExp04').asinteger
    else
      result:=0;
  end else
    result:=0;
  FGeral.fechaquery(Q);
end;

// 28.10.19 - Novicarnes
function TFFornece.GetContaExpCompraRemessaFutura(codigo: integer;  unidade: string): integer;
/////////////////////////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from Fornecedores where forn_codigo='+inttostr(codigo));
  if not Q.eof then begin
     if unidade=Global.unidadematriz then

        result:=Q.fieldbyname('Forn_compraremFutura001').asinteger

     else

        result:=Q.fieldbyname('Forn_compraremFutura002').asinteger;

  end else result:=0;

  FGeral.fechaquery(Q);


end;

function TFFornece.GetRazaoSocial(codigo: integer): string;
begin
  if not Arq.TFornec.active then Arq.TFornec.open;
  if Arq.TFornec.Locate('forn_codigo',codigo,[]) then
    result:=Arq.TFornec.fieldbyname('forn_razaosocial').asstring
  else
    result:='';

end;

function TFFornece.GetCnpjCpf(codigo: integer;masc:string='N'): string;
//////////////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
{
  if not Arq.TFornec.active then Arq.TFornec.open;
  if Arq.TFornec.Locate('forn_codigo',codigo,[]) then
    result:=Arq.TFornec.fieldbyname('forn_cnpjcpf').asstring
  else
    result:='';
}
// 10.08.07
  Q:=Sqltoquery('select forn_cnpjcpf from fornecedores where forn_codigo='+inttostr(codigo));
  if not Q.eof then begin
    if masc='N' then
      result:=Q.fieldbyname('forn_cnpjcpf').asstring
    else
      result:=FormatoCGCCPF( Q.fieldbyname('forn_cnpjcpf').asstring );
  end else
    result:='';
  fGeral.fechaquery(Q);

end;

function TFFornece.GetInsEst(codigo: integer): string;
begin
  if not Arq.TFornec.active then Arq.TFornec.open;
  if Arq.TFornec.Locate('forn_codigo',codigo,[]) then
    result:=Arq.TFornec.fieldbyname('forn_inscricaoestadual').asstring
  else
    result:='';

end;

function TFFornece.GetUf(codigo: integer): string;
begin
  if not Arq.TFornec.active then Arq.TFornec.open;
  if Arq.TFornec.Locate('forn_codigo',codigo,[]) then
    result:=Arq.TFornec.fieldbyname('forn_uf').asstring
  else
    result:='';

end;

function TFFornece.GetCelular(codigo: integer): string;
//////////////////////////////////////////////////////////////
var  Q:TSqlquery;

begin

  Q := Sqltoquery('select forn_fax from fornecedores where forn_codigo='+inttostr(codigo));
  if not Q.eof then
    result:=Q.fieldbyname('forn_fax').asstring
  else
    result:='';
  fGeral.fechaquery(Q);

end;

function TFFornece.GetCidade(codigo: integer): string;
begin
  if not Arq.TFornec.active then Arq.TFornec.open;
  if not Arq.TMunicipios.active then Arq.TMunicipios.open;
  if Arq.TFornec.Locate('forn_codigo',codigo,[]) then begin
    if Arq.TMunicipios.Locate('cida_codigo',arq.tfornec.fieldbyname('forn_cida_codigo').asstring,[]) then
      result:=Arq.TMunicipios.fieldbyname('cida_nome').asstring
    else
      result:='';
  end else
    result:='';

end;

procedure TFFornece.bExcluirClick(Sender: TObject);
var Cod:String;
    Found:Boolean;

    function FoundTabela(Tabela,Campo,CampoTipocad,Msg,TipoCad,CampoStatus:String):Boolean;
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM '+Tabela+' WHERE '+Campo+'='+Cod+' and '+CampoTipocad+'='+STringtosql(tipocad)+
                    ' and '+campostatus+' <> ''C''' );
      Result:=Q.FieldByName('Registros').AsInteger>0;
      if Result then AvisoErro('Encontrado lan�amentos na tabela '+tabela+' ref. '+Msg);
      Q.Close;Freeandnil(Q);
    end;


begin
  Cod:=IntToStr(Arq.TFornec.FieldByName('forn_Codigo').AsInteger);
  Found:=FoundTabela('Movesto','Moes_tipo_Codigo','Moes_tipocad','Movimento estoque','F','moes_status');
// 17.03.10
  if not Found then Found:=FoundTabela('Pendencias','Pend_tipo_Codigo','Pend_TipoCad','Pend�ncia Financeira','F','Pend_status');
  if not Found then Grid.Delete;
end;

procedure TFFornece.bCancelarClick(Sender: TObject);
begin
  EdForn_Codigo.SetStatusEdits(Self,99,seGrid);
  bSair.enabled:=true;
end;

procedure TFFornece.EdForn_ufKeyPress(Sender: TObject; var Key: Char);
begin
   Fgeral.limpaedit(EdForn_uf,key);
end;

function TFFornece.GetPopulacao(codigo: integer): integer;
var Q:Tsqlquery;
begin
  if not Arq.TMunicipios.active then Arq.TMunicipios.open;
  q:=sqltoquery('select forn_cida_codigo from fornecedores where forn_codigo='+inttostr(codigo));
  if not q.eof then begin
    if Arq.TMunicipios.Locate('cida_codigo',q.fieldbyname('forn_cida_codigo').asstring,[]) then
      result:=Arq.TMunicipios.fieldbyname('cida_populacao').asinteger
    else
      result:=0;
  end else
    result:=0;
  q.close;
  freeandnil(q);

end;

procedure TFFornece.SetaItems(Edit,EditNomeForne:TSqlEd;ForneValidos,Nomevalido:String);
var TFornec:TSqlquery;
begin
  Edit.Items.Clear;
  TFornec:=sqltoquery('select forn_codigo,forn_razaosocial,forn_nome from fornecedores order by forn_nome');
  Sistema.beginprocess('Pesquisando fornecedores');
  while not TFornec.Eof do begin
    if ((ForneValidos='') or (Pos(strzero(TFornec.FieldByName('Forn_Codigo').AsInteger,7),ForneValidos)>0))
       and ((NomeValido='') or (Pos(NomeValido,Uppercase(TFornec.FieldByName('Forn_Nome').AsString))>0))
      then begin
       Edit.Items.Add(Strzero(TFornec.FieldByName('Forn_Codigo').AsInteger,7)+' - '+strspace(TFornec.FieldByName('Forn_Nome').AsString,30)+
                      ' - '+TFornec.FieldByName('Forn_razaosocial').AsString);
    end;
    TFornec.Next;
  end;
  FGeral.FechaQuery(TFornec);
  Sistema.EndProcess('');
  if Edit.Items.Count=1 then begin
     Edit.Text:=LeftStr(Edit.Items[0],3);
     if EditNomeForne<>nil then EditNomeForne.Text:=FinalStr(Edit.Items[0],7);
  end;
end;


function TFFornece.GetEmails(ListaCodigos: String): string;
var Q:TSqlquery;
    fornecedores,emails:string;
    p:integer;
begin
  fornecedores:=ListaCodigos;emails:='';
  if trim(fornecedores)<>'' then begin
    Q:=sqltoquery('select forn_email from fornecedores where '+FGeral.GetIN('forn_codigo',fornecedores,'N'));
    while not Q.eof do begin
      if trim(Q.fieldbyname('forn_email').asstring)<>'' then
        emails:=emails+Q.fieldbyname('forn_email').asstring+';';
      Q.Next;
    end;
    FGeral.FechaQuery(Q);
  end;
  result:=emails;
end;

function TFFornece.GetContaExpDevCompra(codigo: integer;  unidade: string): integer;
var Q:TSqlquery;
begin
  Q:=sqltoquery('select * from Fornecedores where forn_codigo='+inttostr(codigo));
  if not Q.eof then begin
// 01.09.09 - Ligiane - conta dev. compra mesma usada em compra
    if Q.fieldbyname('Forn_Devocompra').asinteger=0 then begin
      if trim(unidade)='' then
        result:=Q.fieldbyname('forn_contaexp').asinteger
// 13.05.10 - Abra - Ligiane
      else if Global.Topicos[1010] then
        result:=Q.fieldbyname('forn_contaexp').asinteger
      else if unidade=Q.FieldByName('Forn_unidexporta01').asstring then
        result:=Q.fieldbyname('forn_contaexp').asinteger
      else if unidade=Q.FieldByName('Forn_unidexporta02').asstring then
        result:=Q.fieldbyname('Forn_ContaExp02').asinteger
      else if unidade=Q.FieldByName('Forn_unidexporta03').asstring then
        result:=Q.fieldbyname('Forn_ContaExp03').asinteger
      else if unidade=Q.FieldByName('Forn_unidexporta04').asstring then
        result:=Q.fieldbyname('Forn_ContaExp04').asinteger
    end else
      result:=Q.fieldbyname('Forn_Devocompra').asinteger

  end else
    result:=0;
  FGeral.fechaquery(Q);

end;

function TFFornece.GetEndereco(codigo: integer): string;
//////////////////////////////////////////////////////////////
var Q:TSqlquery;
begin
  Q:=sqltoquery('select forn_endereco from Fornecedores where forn_codigo='+inttostr(codigo));
  result:='';
  if not Q.eof then
    result:=Q.fieldbyname('forn_endereco').asstring;
  FGeral.FechaQuery(Q);
end;

procedure TFFornece.EdForn_nomeValidate(Sender: TObject);
begin
// 18.11.11
  if EdForn_razaosocial.isempty then EdForn_razaosocial.text:=EdForn_nome.text
end;

// 09.09.14
procedure TFFornece.ConfiguraEditsNaoEnabled;
//////////////////////////////////////////////
begin
  if not Global.Topicos[1110] then begin
//    EdForn_vendedor.Enabled:=false;
//    EdForn_fonevendedor.Enabled:=false;

    EdForn_gerente.Enabled:=false;
    EdForn_fonegerente.Enabled:=false;
    EdForn_celulargerente.Enabled:=false;
    EdForn_descpedidos.Enabled:=false;
    EdForn_descpgtodia.Enabled:=false;
    EdForn_ContaExp.Enabled:=false;
    Edunid_exp01.Enabled:=false;
    EdForn_ContaExp02.Enabled:=false;
    Edforn_unidexporta01.Enabled:=false;
    EdForn_ContaExp03.Enabled:=false;
    EdForn_unidexporta03.Enabled:=false;
    EdForn_contaexp04.Enabled:=false;
    EdForn_unidexporta04.Enabled:=false;
    EdForn_devocompra.Enabled:=false;
    EdForn_obspedidos.Enabled:=false;
    EdForn_contacontabil.Enabled:=false;
    EdForn_enderecoind.Enabled:=false;
    EdForn_foneindustria.Enabled:=false;
    EdForn_faxindustria.Enabled:=false;
    EdForn_obstrocas.Enabled:=false;
    EdForn_muniind_codigo.Enabled:=false;
 // 22.05.20
    EdForn_compraremFutura001.Enabled:=false;
    EdForn_compraremFutura002.Enabled:=false;

  end else begin

    EdForn_gerente.Enabled:=true;
    EdForn_fonegerente.Enabled:=true;
    EdForn_celulargerente.Enabled:=true;
    EdForn_descpedidos.Enabled:=true;
    EdForn_descpgtodia.Enabled:=true;
    EdForn_ContaExp.Enabled:=true;
    Edunid_exp01.Enabled:=true;
    EdForn_ContaExp02.Enabled:=true;
    Edforn_unidexporta01.Enabled:=true;
    EdForn_ContaExp03.Enabled:=true;
    EdForn_unidexporta03.Enabled:=true;
    EdForn_contaexp04.Enabled:=true;
    EdForn_unidexporta04.Enabled:=true;
    EdForn_devocompra.Enabled:=true;
    EdForn_obspedidos.Enabled:=true;
    EdForn_contacontabil.Enabled:=true;
    EdForn_enderecoind.Enabled:=true;
    EdForn_foneindustria.Enabled:=true;
    EdForn_faxindustria.Enabled:=true;
    EdForn_obstrocas.Enabled:=true;
    EdForn_muniind_codigo.Enabled:=true;
 // 22.05.20
    EdForn_compraremFutura001.Enabled:=true;
    EdForn_compraremFutura002.Enabled:=true;

  end;
end;

end.
