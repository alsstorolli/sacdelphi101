unit desossa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SqlDtg, StdCtrls, Mask, SQLEd, Buttons, SQLBtn, alabel,
  ExtCtrls, SQLGrid, SqlExpr, ACBrBase, ACBrDFe, ACBrNFe,ACBrDANFCeFortesFrETQFAT,
  pcnconversao;
type
  TFDesossa = class(TForm)
    SQLPanelGrid1: TSQLPanelGrid;
    pbotoes: TSQLPanelGrid;
    APHeadLabel1: TAPHeadLabel;
    bGravar: TSQLBtn;
    bSair: TSQLBtn;
    EdCaoc_codigo: TSQLEd;
    PMens: TSQLPanelGrid;
    SQLPanelGrid3: TSQLPanelGrid;
    SQLPanelGrid4: TSQLPanelGrid;
    PRemessa: TSQLPanelGrid;
    Edunid_codigo: TSQLEd;
    SetEdUNID_NOME: TSQLEd;
    EdDtdesossa: TSQLEd;
    EdNumeroDoc: TSQLEd;
    EdProduto: TSQLEd;
    SetEdESTO_DESCRICAO: TSQLEd;
    Edqtde: TSQLEd;
    EdPecas: TSQLEd;
    Grid: TSqlDtGrid;
    betiqueta: TSQLBtn;
    ACBrNFe1: TACBrNFe;
    procedure EdDtdesossaValidate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdqtdeExitEdit(Sender: TObject);
    procedure bGravarClick(Sender: TObject);
    procedure EdProdutoValidate(Sender: TObject);
    procedure betiquetaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute;
    procedure GravaMestres;
    procedure GravaItens;
    procedure LimpaEdits;

  end;

var
  FDesossa: TFDesossa;
  Transacao:String;
  QC:TSqlquery;

implementation

uses Geral, Sqlsis, Sqlfun , Estoque, Unidades;

{$R *.dfm}

procedure TFDesossa.Execute;
///////////////////////////////
var numero:integer;
begin

    FGeral.ConfiguraColorEditsNaoEnabled(FDesossa);
    Numero:=FGeral.GetContador('DESOSSA'+EdUnid_codigo.text,false,false);
    EdNumerodoc.Text:=inttostr(Numero);
    Show;
    LimpaEdits;
    EdUnid_codigo.text:=Global.CodigoUnidade;
    EdUNid_codigo.validfind;
    EdDtdesossa.setfocus;

end;

procedure TFDesossa.EdDtdesossaValidate(Sender: TObject);
begin
   if not FGeral.ValidaMvto(EdDtdesossa) then
     EdDtdesossa.Invalid('');
end;

// 22.11.17
procedure TFDesossa.EdProdutoValidate(Sender: TObject);
/////////////////////////////////////////////////////////////
begin

   QC:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
                  ' inner join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N'' and esqt_unid_codigo='+EdUnid_codigo.assql+' )'+
                  ' where cust_status=''N'' and cust_esto_codigo='+EdProduto.assql+
                  ' and ( (cust_core_codigo=0) or (cust_core_codigo=null) )'+
                  ' order by cust_esto_codigomat');
   Grid.clear;
   if QC.Eof then EdProduto.Invalid('Falta configurar a composi��o deste codigo');


end;

procedure TFDesossa.FormActivate(Sender: TObject);
begin
   if EdDtdesossa.isempty then
     EdDtdesossa.setdate( sistema.hoje );

end;

procedure TFDesossa.EdqtdeExitEdit(Sender: TObject);
/////////////////////////////////////////////////////
var npecas,p:integer;
begin
   if QC=nil then exit;
   p:=0;
   while not QC.eof do begin
     Grid.Appendrow;
     inc(p);
     Grid.Cells[Grid.GetColumn('move_esto_codigo'),p]:=QC.FieldByName('cust_esto_codigomat').AsString;
     Grid.Cells[Grid.GetColumn('esto_descricao'),p]:=QC.FieldByName('esto_descricao').AsString;
     npecas:=Qc.FieldByName('cust_qtde').AsInteger*EdPecas.AsInteger ;
     Grid.Cells[Grid.GetColumn('move_pecas'),p]:=FGeral.Formatavalor(npecas,f_integer);
//     Grid.RowCount:=Grid.RowCount+1;
     Qc.Next;
   end;

//   bgravarclick(self);

end;

// 22.11.17
procedure TFDesossa.betiquetaClick(Sender: TObject);
///////////////////////////////////////////////////////
var s:string;
    npecas,i:integer;
begin

    Qc.First;
    if Qc.eof then exit;

    ACBrNFe1.NotasFiscais.Clear;
    AcbrNFe1.DANFE := TACBrNFeDANFCeFortesETQFAT.Create(AcbrNFe1);
    AcbrNfe1.DANFE.TipoDANFE := tiNFCE;

    if Global.usuario.outrosacessos[0510] then
      acbrnfe1.danfe.MostraPreview:=true
    else
      acbrnfe1.danfe.MostraPreview:=false;
    acbrnfe1.danfe.MargemEsquerda:=01;
    acbrnfe1.danfe.MargemDireita:=05;
    acbrnfe1.danfe.MargemSuperior:=18;
    acbrnfe1.danfe.MargemInferior:=10;


    s:=LeArquivoINI(Global.NomeSistema,'Impressoras','IMPETQDES');
    if trim(s)<>'' then Acbrnfe1.DANFE.Impressora:=s;


    while not QC.eof do begin

      with  ACBrNFe1.NotasFiscais.Add.NFe do begin
        Total.ICMSTot.vBC   := 0;
        Total.ICMSTot.vProd := 0;
//        Emit.xFant          := FCadcli.GetNome(codigocliente);
//        Emit.xNome          := FCadcli.GetRazaoSocial(codigocliente);
//        Emit.CNPJCPF        := '';   // FCadcli.GetCnpjCpf(codigocliente);
//        Emit.EnderEmit.xLgr := Q1.fieldbyname('clie_endres').asstring;
        Emit.EnderEmit.nro  := '';
        Emit.EnderEmit.xCpl := '';
//        codmuniemitente     := FCidades.GetCodigoIBGE( FUnidades.GetCidaCodigo(Global.CodigoUnidade) );
//        Ide.cUF             := strtoint(copy(codmuniemitente,1,2));
// 21.08.17
        Ide.cNF             := EdNumerodoc.asinteger;
        Ide.dEmi            := Sistema.Hoje;

        npecas:= QC.fieldbyname('cust_qtde').asinteger*EdPecas.AsInteger;
          with  Det.Add do
          begin
            Prod.qCom    := npecas;
            Prod.qTrib   := npecas;
            Prod.uCom    := QC.fieldbyname('esto_unidade').asstring;
            Prod.uTrib   := QC.fieldbyname('esto_unidade').asstring;
            Prod.xProd   := QC.fieldbyname('esto_descricao').asstring;
            Prod.cProd   := QC.fieldbyname('cust_esto_codigomat').asstring;
          end;


          QC.Next;

      end; /// with acbr

    end;  /// QC.eof

    Sistema.beginprocess('Imprimindo');

    if ACBrNFe1.NotasFiscais.Count=0 then avisoerro('componente acbr ficou vazio');


      for i:=0 to ACBrNFe1.NotasFiscais.Count-1 do begin

        ACBrNFe1.DANFE.ImprimirDANFE( ACBrNFe1.NotasFiscais.Items[i].NFe )  ;
        sleeP(2000);  // senao da i/o error

      end;

      Sistema.endprocess('');
      ACBrNFe1.NOtasFiscais.clear;

  EdDtDesossa.setfocus;

end;

procedure TFDesossa.bGravarClick(Sender: TObject);
//////////////////////////////////////////////////////
var Numero:integer;
begin

    if not confirma('Confirma grava��o') then exit;

    Numero:=FGeral.GetContador('DESOSSA'+EdUnid_codigo.text,false);
    EdNumerodoc.Text:=inttostr(Numero);

    Sistema.BeginTransaction('Gravando');
    Transacao:=FGeral.GetTransacao;
    GravaMestres;
    GravaItens;
    try
      Sistema.EndTransaction('Incluido desosssa numero '+EdNUmerodoc.text);
    except
      Avisoerro('Problemas na grava��o.  Nada foi gravado.');
    end;
    LimpaEdits;
    EdDtDesossa.setfocus;

end;

procedure TFDesossa.GravaItens;
/////////////////////////////////
var TEstoqueQtde,QCusto,QEst,QEstQtde:TSqlquery;
    novocusto,novocustomedio,totalitem:currency;

begin
// item da saida da desossa
///////////////////////////////////
      Sistema.Insert('Movestoque');
      Sistema.SetField('move_esto_codigo',EdProduto.text);
//      Sistema.SetField('move_tama_codigo',strtointdef(Grid.cells[Grid.getcolumn('move_tama_codigo'),linha],0));
//      Sistema.SetField('move_core_codigo',strtointdef(Grid.cells[Grid.getcolumn('move_core_codigo'),linha],0));
//      Sistema.SetField('move_copa_codigo',strtointdef(Grid.cells[Grid.getcolumn('move_copa_codigo'),linha],0));
      Sistema.SetField('move_transacao',transacao);
      Sistema.SetField('move_operacao',FGeral.GetOperacao);
      Sistema.SetField('move_numerodoc',Ednumerodoc.asinteger);
      Sistema.SetField('move_status','N');
      Sistema.SetField('move_tipomov',Global.CodDesossaSai);
      Sistema.SetField('move_unid_codigo',EdUnid_codigo.text);
      Sistema.SetField('move_tipo_codigo',EdUNid_codigo.AsInteger);
      Sistema.SetField('move_tipocad','U');
      Sistema.SetField('move_repr_codigo',0);
      Sistema.SetField('move_qtde',EdQtde.ascurrency);
      Sistema.SetField('move_venda',FEstoque.GetPreco(EdProduto.text,EdUNid_codigo.text));
//      Sistema.SetField('move_datacont',Entrada);
      Sistema.SetField('move_datalcto',Sistema.Hoje);
      Sistema.SetField('move_datamvto',EdDtdesossa.AsDate);
      Sistema.SetField('move_qtderetorno',0);
      TEstoqueQtde:=sqltoquery('select * from estoqueqtde where esqt_status=''N'' and esqt_unid_codigo='+EdUnid_codigo.assql+
                               ' and esqt_esto_codigo='+Edproduto.assql );
// 22.11.17
      if TEstoqueQtde.fieldbyname('esqt_custo').ascurrency > 0 then begin
        Sistema.SetField('move_custo',TEstoqueQtde.fieldbyname('esqt_custo').ascurrency);
        Sistema.SetField('move_custoger',TEstoqueQtde.fieldbyname('esqt_custoger').ascurrency);
        Sistema.SetField('move_customedio',TEstoqueQtde.fieldbyname('esqt_customedio').ascurrency);
        Sistema.SetField('move_customeger',TEstoqueQtde.fieldbyname('esqt_customeger').ascurrency);
      end;
      Sistema.SetField('move_venda',TEstoqueQtde.fieldbyname('esqt_vendavis').ascurrency);
      Sistema.SetField('move_cst','');
      Sistema.SetField('move_aliicms',0);
      Sistema.SetField('move_grup_codigo',EdProduto.resultfind.fieldbyname('esto_grup_codigo').AsInteger);
      Sistema.SetField('move_sugr_codigo',EdProduto.resultfind.fieldbyname('esto_sugr_codigo').AsInteger);
      Sistema.SetField('move_fami_codigo',EdProduto.resultfind.fieldbyname('esto_fami_codigo').AsInteger);
      Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
      Sistema.SetField('move_aliipi',0);
      Sistema.SetField('move_pecas',EdPecas.ascurrency);
      Sistema.SetField('move_redubase',0);
      Sistema.Post('');
      FGeral.FechaQuery(TEstoqueqtde);
////////////
// itens da entrada da desossa
///////////////////////////////////
      QCusto:=sqltoquery('select * from custos inner join estoque on ( esto_codigo=cust_esto_codigomat )'+
                  ' inner join estoqueqtde on ( esqt_esto_codigo=cust_esto_codigomat and esqt_status=''N'' and esqt_unid_codigo='+EdUnid_codigo.assql+' )'+
                  ' where cust_status=''N'' and cust_esto_codigo='+EdProduto.assql+
                  ' and ( (cust_core_codigo=0) or (cust_core_codigo=null) )'+
                  ' order by cust_esto_codigomat');
      while (not QCusto.eof) do begin

        Sistema.Insert('Movestoque');
        Sistema.SetField('move_esto_codigo',QCusto.fieldbyname('cust_esto_codigomat').asstring);
        Sistema.SetField('move_tama_codigo',QCusto.fieldbyname('cust_tama_codigomat').asinteger);
        Sistema.SetField('move_core_codigo',QCusto.fieldbyname('cust_core_codigomat').asinteger);
        Sistema.SetField('move_copa_codigo',QCusto.fieldbyname('cust_copa_codigo').asinteger);
        Sistema.SetField('move_transacao',transacao);
        Sistema.SetField('move_operacao',FGeral.GetOperacao);
//              Sistema.SetField('move_numerodoc',100+numero);
        Sistema.SetField('move_numerodoc',EdNUmerodoc.asinteger*10);
        Sistema.SetField('move_status','N');
        Sistema.SetField('move_tipomov',Global.CodDesossaEnt);
        Sistema.SetField('move_unid_codigo',EdUNid_codigo.text);
        Sistema.SetField('move_tipo_codigo',EdUNid_codigo.AsInteger);
        Sistema.SetField('move_tipocad','U');
//              if movimento>0 then begin
// 02.11.07
        novocusto:=0;
        novocustomedio:=0;
        totalitem:=EdQtde.ascurrency*FEstoque.GetCusto(EdProduto.text,EdUnid_codigo.text,'custo');
        novocusto:=( totalitem*(Qcusto.fieldbyname('cust_percusto').ascurrency/100) ) / ( (EdQtde.ascurrency)*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100) );
        Sistema.SetField('move_qtde',EdQtde.ascurrency*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100) );
// 22.11.17
        if novocusto>0 then begin

          Sistema.SetField('move_custo',novocusto );
          Sistema.SetField('move_custoger',novocusto);
          Sistema.SetField('move_venda',novocusto);

        end;
//              Sistema.SetField('move_datacont',Movimento);
        Sistema.SetField('move_pecas',EdPecas.ascurrency*Qcusto.fieldbyname('cust_qtde').ascurrency );
        Sistema.SetField('move_datalcto',Sistema.Hoje);
        Sistema.SetField('move_datamvto',EdDtDesossa.asdate);
        Sistema.SetField('move_qtderetorno',0);
        Sistema.SetField('move_cst','');
        Sistema.SetField('move_aliicms',0);
        QEst:=sqltoquery('select esto_grup_codigo,esto_sugr_codigo,esto_fami_codigo from estoque where esto_codigo='+stringtosql(QCusto.fieldbyname('cust_esto_codigomat').asstring));
        if not QEst.eof then begin
          Sistema.SetField('move_grup_codigo',QEst.FieldByName('esto_grup_codigo').AsInteger);
          Sistema.SetField('move_sugr_codigo',QEst.fieldbyname('esto_sugr_codigo').AsInteger);
          Sistema.SetField('move_fami_codigo',QEst.fieldbyname('esto_fami_codigo').AsInteger);
        end;
        FGeral.Fechaquery(QEst);
        Sistema.SetField('move_usua_codigo',Global.Usuario.codigo);
        Sistema.SetField('move_aliipi',0);
        Sistema.Post('');
//atualiza os custos e a qtde em estoque
        QEstQtde:=sqltoquery('select * from estoqueqtde where esqt_esto_codigo='+stringtosql(QCusto.fieldbyname('cust_esto_codigomat').asstring)+
                       ' and esqt_status=''N'' and esqt_unid_codigo='+EdUnid_codigo.assql );
        novocustomedio:= (novocusto*EdQtde.ascurrency)*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100) + ( QEstQtde.fieldbyname('esqt_qtde').ascurrency*QEstQtde.fieldbyname('esqt_customedio').ascurrency )  /
                         ( QEstQtde.fieldbyname('esqt_qtde').ascurrency+(EdQtde.ascurrency*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100)) );

        Sistema.Edit('estoqueqtde');
// 22.11.17
        if novocusto>0 then begin
            Sistema.SetField('esqt_custo',novocusto);
            Sistema.SetField('esqt_custoger',novocusto);
            Sistema.SetField('esqt_customedio',novocustomedio );
            Sistema.SetField('esqt_customeger',novocustomedio);
        end else begin
            Sistema.SetField('esqt_custo',0);
            Sistema.SetField('esqt_custoger',0);
            Sistema.SetField('esqt_customedio',0 );
            Sistema.SetField('esqt_customeger',0);

        end;

        Sistema.post('esqt_esto_codigo='+stringtosql(QCusto.fieldbyname('cust_esto_codigomat').asstring)+
                       ' and esqt_status=''N'' and esqt_unid_codigo='+EdUnid_codigo.assql );

        if not QEstQtde.Eof then
          FGeral.MovimentaQtdeEstoque(QCusto.fieldbyname('cust_esto_codigomat').asstring,EdUnid_codigo.text,'E',Global.CodDesossaEnt,EdQtde.ascurrency*(Qcusto.fieldbyname('cust_perqtde').ascurrency/100) ,QEstqtde);
        FGeral.FechaQuery(QEstQtde);

        QCusto.Next;
      end;  //  QCusto
      FGeral.FechaQuery(QCusto);
///////////////////////////////////

end;

procedure TFDesossa.GravaMestres;
//////////////////////////////////
begin
    Sistema.Insert('Movesto');
    Sistema.SetField('moes_transacao',Transacao);
    Sistema.SetField('moes_operacao',fGeral.GetOperacao);
    Sistema.SetField('moes_status','N');
//                Sistema.SetField('moes_numerodoc',100+numero);
    Sistema.SetField('moes_numerodoc',EdNumerodoc.asinteger);
    Sistema.SetField('moes_tipomov',Global.CodDesossaSai);
    Sistema.SetField('moes_comv_codigo',0);
    Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
//    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
    Sistema.SetField('moes_tipo_codigo',EdUnid_codigo.asinteger);
    Sistema.SetField('moes_estado',EdUnid_codigo.ResultFind.fieldbyname('unid_uf').AsString);
    Sistema.SetField('moes_cida_codigo',EdUnid_codigo.ResultFind.fieldbyname('unid_cida_codigo').AsInteger);
    Sistema.SetField('moes_tipocad','U');
    Sistema.SetField('moes_datalcto',Sistema.Hoje);
    Sistema.SetField('moes_dataemissao',Sistema.Hoje);
    Sistema.SetField('moes_datamvto',EdDtDesossa.asdate);
//    Sistema.SetField('moes_DataCont',Movimento);
    Sistema.SetField('moes_vlrtotal',0);
    Sistema.SetField('moes_baseicms',0);
    Sistema.SetField('moes_valoricms',0);
    Sistema.SetField('moes_basesubstrib',0);
    Sistema.SetField('moes_valoricmssutr',0);
    Sistema.SetField('moes_totprod',0);
    Sistema.SetField('moes_vlrtotal',0);
    Sistema.SetField('moes_valortotal',0);
    Sistema.SetField('moes_natf_codigo','');
    Sistema.SetField('moes_freteciffob','');
    Sistema.SetField('moes_frete',0);
//              Sistema.SetField('moes_vispra',FCondPagto.GetAvPz(Condicao));
    Sistema.SetField('moes_especie','');
    Sistema.SetField('moes_serie','');
    Sistema.SetField('moes_tran_codigo','');
    Sistema.SetField('Moes_Perdesco',0);
    Sistema.SetField('Moes_Peracres',0);
    Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('moes_pedido',0);
    Sistema.Post();

    Sistema.Insert('Movesto');
    Sistema.SetField('moes_transacao',Transacao);
    Sistema.SetField('moes_operacao',FGeral.GetOperacao);
    Sistema.SetField('moes_status','N');
//                Sistema.SetField('moes_numerodoc',100+numero);
    Sistema.SetField('moes_numerodoc',EdNumerodoc.asinteger*10);
    Sistema.SetField('moes_tipomov',Global.CodDesossaEnt);
    Sistema.SetField('moes_comv_codigo',0);
    Sistema.SetField('moes_unid_codigo',EdUnid_codigo.text);
//    Sistema.SetField('moes_estado',FCidades.GetUF(Cliente.ResultFind.fieldbyname('clie_cida_codigo_com').AsInteger));
    Sistema.SetField('moes_tipo_codigo',EdUnid_codigo.asinteger);
    Sistema.SetField('moes_estado',EdUnid_codigo.ResultFind.fieldbyname('unid_uf').AsString);
    Sistema.SetField('moes_cida_codigo',EdUnid_codigo.ResultFind.fieldbyname('unid_cida_codigo').AsInteger);
    Sistema.SetField('moes_tipocad','U');
    Sistema.SetField('moes_datalcto',Sistema.Hoje);
    Sistema.SetField('moes_dataemissao',Sistema.Hoje);
    Sistema.SetField('moes_datamvto',EdDtDesossa.asdate);
//    Sistema.SetField('moes_DataCont',Movimento);
    Sistema.SetField('moes_vlrtotal',0);
    Sistema.SetField('moes_baseicms',0);
    Sistema.SetField('moes_valoricms',0);
    Sistema.SetField('moes_basesubstrib',0);
    Sistema.SetField('moes_valoricmssutr',0);
    Sistema.SetField('moes_totprod',0);
    Sistema.SetField('moes_vlrtotal',0);
    Sistema.SetField('moes_valortotal',0);
    Sistema.SetField('moes_natf_codigo','');
    Sistema.SetField('moes_freteciffob','');
    Sistema.SetField('moes_frete',0);
//              Sistema.SetField('moes_vispra',FCondPagto.GetAvPz(Condicao));
    Sistema.SetField('moes_especie','');
    Sistema.SetField('moes_serie','');
    Sistema.SetField('moes_tran_codigo','');
    Sistema.SetField('Moes_Perdesco',0);
    Sistema.SetField('Moes_Peracres',0);
    Sistema.SetField('moes_usua_codigo',Global.Usuario.Codigo);
    Sistema.SetField('moes_pedido',0);
    Sistema.Post();

end;

procedure TFDesossa.LimpaEdits;
begin
  Edproduto.clear;
  EdQtde.clear;
  EdPecas.Clear;
  Grid.Clear;
end;

end.
