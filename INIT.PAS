unit Init;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,SqlExpr,
  //DBXPress,
  Buttons, SQLBtn, StdCtrls, alabel, SQLGrid,
  Mask, SQLEd, ExtCtrls;

type
  TFInit = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Inicializar;
    function InicializaUsuario(PrimeiroAcesso:Boolean):Boolean;
    procedure InicializaConfiguracao;
  end;

var
  FInit: TFInit;

implementation

{$R *.dfm}

uses SqlSis, Arquiv,SqlFun, GrUsu, Menuinicial, Usuarios,Geral, SQLRel,
  Unidades, Diversos, moedas , TextRel, Configura;

////////////////////////////////////////
procedure TFInit.Inicializar;
////////////////////////////////////////
var Texto:TStrings;
    usuariocaixa,
    i             :integer;
    s             :string;


    function SetaBancoDados:Boolean;
    /////////////////////////////////
    var Servidor,BancoDados,NomeBanco,xnomebanco,xservidor,xsenha:String;
        Gravado:Boolean;

        function SeforCoorlaf( xpath:string ):boolean;
        //////////////////////////////////////////////
        begin
          result:=false;
          if pos('LARANJEIRAS',uppercase( xpath ) ) >0 then result:=true
          else if pos('RESERVA',uppercase( xpath ) ) >0 then result:=true
          else if pos('PITANGA',uppercase( xpath ) ) >0 then result:=true
          else if pos('SANTAMARIA',uppercase( xpath ) ) >0 then result:=true
//          else if pos('DELPHISAC',uppercase( xpath ) ) >0 then result:=true
          else if pos('BOAVENTURA',uppercase( xpath ) ) >0 then result:=true
          else if pos('GABRIEL',uppercase( xpath ) ) >0 then result:=true
          else if pos('UNICAFES',uppercase( xpath ) ) >0 then result:=true;
        end;

        // 29.09.18
        function GetVersaoBanco:integer;
        ///////////////////////////////
        var Qb:TSqlquery;
        begin

           Qb:=sqltoquery('select name, setting from pg_settings where name like '+stringtosql('%server_version_num%')) ;
           if not Qb.Eof then result:=strtointdef( Qb.FieldByName('setting').AsString,0)
           else result:=0;
           Qb.Close;Qb.Free;

        end;

    begin

      Gravado:=False;
      Arq.Ambiente.SQLPassword:='sacd'+IntToStr(35269147);
      Result:=False;
      BancoDados:=GetIni('SACD','Config','BancoDados');
      Servidor:=GetIni('SACD','Config','EnderecoServidor');
      NomeBanco:=GetIni('SACD','Config','NomeBanco');
      xNomeBanco:=GetIni('SACD','Config','NomeBanco');
// 11.08.16
      xSenha:=GetIni('SACD','Config','SenhaUsuario');
// 19.10.05 - para poder escolher a base 'toda vez'
      if (fileexists('pedebase.txt')) then begin
        Input('Nome banco','Base',Nomebanco,15,false);
        Input('Servidor','Nro. Ip',Servidor,15,false);
        if trim(nomebanco)='' then
          nomebanco:=xnomebanco;
        if trim(xservidor)='' then
          servidor:=xservidor;
      end;
      if (Trim(BancoDados)='') or (Servidor='') or (NomeBanco='') then begin
         if (not FDiversos.ConfBancoDeDados) then Exit;
         BancoDados:=GetIni('SACD','Config','BancoDados');
         Servidor:=GetIni('SACD','Config','EnderecoServidor');
         NomeBanco:=GetIni('SACD','Config','NomeBanco');
         Gravado:=True;
      end;

      if BancoDados='ORACLE' then Sistema.TypeServer:=tsOracle
      else if BancoDados='SQLSERVER' then Sistema.TypeServer:=tsSQLServer
      else if BancoDados='INTERBASE' then Sistema.TypeServer:=tsInterbase
      else if BancoDados='FIREBIRD' then Sistema.TypeServer:=tsInterbase
      else if BancoDados='POSTGRESQL' then Sistema.TypeServer:=tsPostGreSql
      else begin
         SetIni('SACD','Config','BancoDados','');
         SetIni('SACD','Config','EnderecoServidor','');
         SetIni('SACD','Config','NomeBanco','');
         AvisoErro('Tipo configurado para o banco de dados está inválido: '+BancoDados);
         FDiversos.ConfBancoDeDados;
         Exit;
      end;
// 11.08.16
      if SeforCoorlaf( ExtractFilePath( Application.ExeName ) ) then begin
         xSenha:='BYue7j4B:ai(0h%9l]!sL~IIO[@z}[x+';
         Servidor:='cloudrureco.dynv6.net';
// 13.09.16
      end else if pos('cloudrureco',servidor)>0 then xSenha:='BYue7j4B:ai(0h%9l]!sL~IIO[@z}[x+';


//////////////////////      if Sistema.TypeServer=tsInterbase then Arq.Ambiente.DataBaseName:='\SAC\'+Arq.Ambiente.DataBaseName+'.GDB';
      if Sistema.TypeServer=tsInterbase then Arq.Ambiente.DataBaseName:='\SAC\'+NomeBanco+'.GDB';

      Sistema.SQLServer:=Servidor;

// 26.10.05 - para poder escolher a base 'toda vez'
      if (fileexists('pedebase.txt'))  and (xservidor<>servidor)then begin
         SetIni('SACD','Config','NomeBanco',Nomebanco);
         SetIni('SACD','Config','EnderecoServidor',Servidor);
      end;
//      Arq.Ambiente.SQLPassword:=NomeBanco+IntToStr(35269147);
// 11.08.16
      if trim(xsenha)='' then
        Arq.Ambiente.SQLPassword:='sacd'+IntToStr(35269147)
      else
        Arq.Ambiente.SQLPassword:=xsenha;
// 04.08.08 - 03.09.10 - recolocado - de nada adiantou..

//      Arq.Ambiente.DataBaseName:=Nomebanco;

      Sistema.DataBaseName:=NomeBanco;
      Result:=Sistema.Init;
      if (not Result) and (Gravado) then begin
         SetIni('SACD','Config','BancoDados','');
         SetIni('SACD','Config','EnderecoServidor','');
         SetIni('SACD','Config','NomeBanco','');
      end;
// 29.09.18 -
      if Result then Global.VersaoBanco:=GetVersaoBanco;

    end;

    procedure InicializaCodigoUnidade;
    ///////////////////////////////////
    var ipbase:string;
    begin
      Global.CodigoUnidade:=GetIni('SACD','Config','CodigoUnidade');
      if not Arq.TUnidades.Active then Arq.TUnidades.Open;
      ipbase:=' - '+Sistema.sqlserver+' - '+Sistema.DataBaseName ;
      if not Arq.TUnidades.Locate('Unid_Codigo',Global.CodigoUnidade,[]) then begin
         AvisoErro('Atenção, unidade da estação de trabalho;não cadastrada');
         Global.CodigoUnidade:='000';
         FMain.PUnidade.Caption:=Global.CodigoUnidade+' - Não Cadastrada'+ipbase;
      end else begin
         Global.NomeUnidade:=FUnidades.GetNome(Global.CodigoUnidade);
         Global.ReduzidoUnidade:=FUnidades.GetReduzido(Global.CodigoUnidade);
         Global.UFUnidade:=FUnidades.GetUF(Global.CodigoUnidade);
         FMain.PUnidade.Caption:=Global.CodigoUnidade+' - '+Global.NomeUnidade+ipbase;
         Global.SerieUnidade:=FUnidades.GetSerie(Global.CodigoUnidade);
// 13.05.11
         Global.SimplesUNidade:=Arq.TUnidades.FieldByName('Unid_Simples').AsString
      end;
      Arq.TUnidades.BeginProcess;
      Arq.TUnidades.First;
      while not Arq.TUnidades.Eof do begin
        Global.ReduzidoUnidades[Inteiro(Arq.TUnidades.FieldByName('Unid_Codigo').AsString)]:=Trim(Arq.TUnidades.FieldByName('Unid_Reduzido').AsString);
        Global.EmpresaUnidades[Inteiro(Arq.TUnidades.FieldByName('Unid_Codigo').AsString)]:=Trim(Arq.TUnidades.FieldByName('Unid_Empr_Codigo').AsString);
        Arq.TUnidades.Next;
      end;
      Arq.TUnidades.EndProcess;
    end;

    procedure InicializaDiasNaoUteis;
    ////////////////////////////////
    begin
      Global.DiasNaoUteisAnteriores:=0;
      while not FGeral.DiaUtil(Sistema.Hoje-(Global.DiasNaoUteisAnteriores+1)) do begin
        Inc(Global.DiasNaoUteisAnteriores);
      end;
    end;

    procedure SetaDataZero;
    /////////////////////////
    var dd,mm,aa:Word;
    begin
      dd:=31;mm:=12;aa:=1899;
      Global.DataMinima:=EncodeDate(aa,mm,dd);
    end;

    procedure InicializaEmpresa;
    ///////////////////////////
    begin
      if not Arq.TEmpresas.Active then Arq.TEmpresas.Open;
      Arq.TEmpresas.IndexFieldNames:='Empr_Codigo';
      Arq.TEmpresas.First;
      Global.EmpresaContabil:=Trim(Arq.TEmpresas.FieldByName('Empr_Codigo').AsString);
    end;

    procedure SetaCodigosEspecificos;
    //////////////////////////////////
    var Lista:TStringList;
        i,n:Integer;
    begin
      Lista:=TStringList.Create;
      StrToLista(Lista,FGeral.GetConfig1AsString('Especificos'),';,',False);
      for i:=0 to Lista.Count-1 do begin
          if Length(Lista[i])<=4 then begin
             n:=Inteiro(Lista[i]);
             if (n>0) and (n<=9999) then Global.CodigosEspecificos[n]:=True;
          end;   
      end;
      Lista.Free;
    end;

    procedure CriaTabelaControle;
    //////////////////////////////
    var Q:TSqlQuery;
    begin
      Q:=SqlToQuery('SELECT Count(*) AS Registros FROM Controle');
      if Q.FieldByName('Registros').AsInteger=0 then begin
         Sistema.Insert('Controle');
         Sistema.SetField('Ctrl_Registro',1);
         Sistema.SetField('Ctrl_UsuExclusivo',0);
         Sistema.Post;
         Sistema.Commit;
      end;
      Q.Close;Q.Free;
    end;

    function UsoExclusivo:Boolean;
    var Q:TSqlQuery;
        u:Integer;
    begin
      Result:=False;
      Q:=SqlToQuery('SELECT Ctrl_UsuExclusivo FROM Controle WHERE Ctrl_Registro=1');
      u:=Q.FieldByName('Ctrl_UsuExclusivo').AsInteger;
      Q.Close;Q.Free;
      if (u>0) and (u<>Global.Usuario.Codigo) then begin
         AvisoErro('Atenção, sistema está com uso exclusivo para o usuário: '+IntToStr(u)+' - '+FUsuarios.GetNome(u));
         Result:=True;
         if (not Global.Usuario.Suporte) and (not Global.Usuario.SenhaDiaria) then begin
            Sistema.Finalizando:=True;
            Application.Terminate;
         end;
      end;
    end;


begin

  if not SetaBancoDados then begin
     Sistema.Finalizando:=True;
     Aviso('O sistema será finalizado');
     Application.Terminate;
     Exit;
  end;
  Global.NomeSistema:='SAC';
// 09.12.15 - Claudio
// Metalforte
//  Global.DataSistema:=Texttodate('15032016');
// 16.02.16
//  Global.DataSistema:=Texttodate('16092017');
// 28.08.17
//  Global.DataSistema:=Texttodate('16092018');
// 28.08.18
//  Global.DataSistema:=Texttodate('17092019');
// 29.08.19
//  Global.DataSistema:=Texttodate('17092020');
// 31.08.20
//  Global.DataSistema:=Texttodate('18092021');
// 31.08.2021
//  Global.DataSistema:=Texttodate('19092022');
// 01.08.2022
  Global.DataSistema:=Texttodate('19092023');

// 26.04.10
  Global.DataMenorBanco:=Texttodate('31121901');
  FMain.Caption:=Global.NomeSistema+' - '+Global.VersaoSistema;
  FMain.PAlerta.Caption:='Ver '+Global.VersaoSistema;
  Sistema.BeginProcess('inicializando sistema');
  CriaTabelaControle;
  FUnidades.Open;
  FMoedas.Open;
  Sistema.Hoje:=FGeral.GetDataServidor;
  Sistema.Datai:=Sistema.Hoje;
  Sistema.Dataf:=Sistema.Hoje;
  Sistema.DataMvto:=Sistema.Hoje;
  SetaDataZero;
  if not Arq.TPlano.Active then Arq.TPlano.Open;
  InicializaConfiguracao;
  InicializaCodigoUnidade;
  SetaCodigosEspecificos;
  FGeral.SetaGradientes;
//  FInflacao.InicializaInflacao;
//  FNatFisc.InicializaNaturezasFiscais;
  FUsuarios.CriaTopicosAcessoObjetos;
  FUsuarios.CriaTopicosOutrosAcessos;
//  FEspecif.RegistraOpcoesMenu;
  InicializaDiasNaoUteis;
  InicializaEmpresa;
  Sistema.EndProcess('');
  usuariocaixa:=strtointdef( GetIni('SACD','Config','Usuariocaixa'),0);
// 13.11.18 - formulario direto do caminhao
  if GetIni('SACD','Config','Usuario') = 'CAMINHAO' then begin

     Global.Usuario.Codigo:=27;
     Sistema.CodigoUsuario:='027';
     if not Arq.TUsuarios.Active then Arq.TUsuarios.Open;

     Arq.TUsuarios.Locate( 'usua_codigo',inttostr( Global.Usuario.Codigo ),[] );
     Global.Usuario.Nome:=Arq.TUsuarios.FieldByName('usua_nome').asstring;
//     Global.Usuario.ObjetosAcessados:=Arq.TUsuarios.FieldByName('usua_objetosAcessados').asstring;
//     Global.Usuario.OutrosAcessos:=Arq.TUsuarios.FieldByName('usua_outrosacessos').asstring;
     Global.Usuario.OutrosAcessos[0064]:=true;

// 06.12.18
  end else if usuariocaixa>0 then begin

     Global.Usuario.Codigo:=usuariocaixa;
     Sistema.CodigoUsuario:=strzero( usuariocaixa,3 );
     if not Arq.TUsuarios.Active then Arq.TUsuarios.Open;
     Arq.TUsuarios.Locate( 'usua_codigo',inttostr( Global.Usuario.Codigo ),[] );
     Global.Usuario.Nome:=Arq.TUsuarios.FieldByName('usua_nome').asstring;
        Global.Usuario.UnidadesMvto:=Trim(Arq.TUsuarios.FieldByName('Usua_UnidadesMvto').AsString);
        Global.Usuario.UnidadesRelatorios:=Trim(Arq.TUsuarios.FieldByName('Usua_UnidadesRelatorios').AsString);
        Global.Usuario.TiposDctosRelatorios:=Trim(Arq.TUsuarios.FieldByName('Usua_TpDctosRelatorios').AsString);
        Global.Usuario.ContasCaixaValidas:=';'+Trim(Arq.TUsuarios.FieldByName('Usua_ContasCaixaValidas').AsString)+';';
        s:=StrSpace(Arq.TUsuarios.FieldByName('Usua_ObjetosAcessados').AsString,4000);
        for i:=1 to 4000 do Global.Usuario.ObjetosAcessados[i]:=s[i]='S';
        s:=StrSpace(Arq.TUsuarios.FieldByName('Usua_OutrosAcessos').AsString,4000);
        for i:=1 to 4000 do Global.Usuario.OutrosAcessos[i]:=s[i]='S';

     Fusuarios.ProcessaAcessoObjetos;

  end else if not InicializaUsuario(True) then Exit;

  if UsoExclusivo then Exit;
  FGeral.TimeGeral.Enabled:=True;
// 10.03.20
  if Global.Usuario.OutrosAcessos[0519] then FGeral.TimeGeral.Interval:=1000; // 4500 padrao
// 31.08.20 - retirado em 10.01.23 pra ver nf geral , venda e devolucoes
//  if AnsiPos('AGB',Uppercase(Global.NomeUnidade)) > 0 then
//     Global.DataSistema:=Texttodate('18102020');
// 19.10.20
//     Global.DataSistema:=Texttodate('18022021');
// 19.02.2021
//     Global.DataSistema:=Texttodate('18042021');
// 19.04.2021
//     Global.DataSistema:=Texttodate('23042021');
// 26.04.2021
//     Global.DataSistema:=Texttodate('31052021');
// 04.06.2021
//     Global.DataSistema:=Texttodate('31072021');
// 06.08.2021
//     Global.DataSistema:=Texttodate('30092021');
// 19.10.2021
//     Global.DataSistema:=Texttodate('30112021');


//  Aviso( 'Data '+FGeral.formatadata(Global.datasistema));

// 10.05.06
  FTextRel.GerarArquivo.visible:=Global.Usuario.Outrosacessos[3306];
// 27.09.07
  FTextRel.bEmail.visible:=Global.Usuario.Outrosacessos[3307];
 {  - retirado em 28.08.17
// 14.03.09
  if ( trim(FGeral.getconfig1asstring('SMTP'))+trim(FGeral.getconfig1asstring('USUARIOSMTP'))+trim(FGeral.getconfig1asstring('SENHASMTP')) )<>'' then begin
    Texto:=TStringList.Create;
    Texto.Add('Dias restantes '+inttostr( trunc( Sistema.hoje-(Global.DataSistema-20) ) ) );
    if Sistema.Hoje>(Global.DataSistema-20) then
      FGeral.EnviaEMail('andreluis779@gmail.com','Atualização Sac','',Texto);
      FRel.SendMail('andreluis779@gmail.com','Atualização Sac','',Texto);
    Texto.Free;
  end;
  }
  if Sistema.Hoje>(Global.DataSistema-20) then begin
//     Avisoerro('Atenção.   Menos de 20 dias para validação do sistema.');
    Avisoerro('Dias restantes para validação do sistema '+inttostr( trunc( (Global.DataSistema-Sistema.hoje) ) ) );
  end;
  if Sistema.Hoje>Global.DataSistema then begin
     Avisoerro('Problemas na inicialização do sistema.');
     Application.Terminate;
  end;
//  if Global.VersaoSistema<Sistema.GetVersion then begin
//     Aviso('Atenção, versão do sistema; está desatualizada, efetuar a atualização logo que possível');
//  end;

  CriaTabelaControle;
  FGeral.AlertaMensagem;
  FGeral.SetaDataUltimoEncerrCont;
  FGeral.InicializaSistema;
// 20.07.13
  if (Global.Topicos[1033]  ) or (Global.Topicos[1021]) then FGeral.SetaTabelaIBPT;
end;



function TFInit.InicializaUsuario(PrimeiroAcesso:Boolean):Boolean;
///////////////////////////////////////////////////////////////////////
var i:Integer;
begin
  if not Arq.TUsuarios.Active then Arq.TUsuarios.Open;
  if (Global.Usuario.Desenvolvimento) and (PrimeiroAcesso) then begin
//     FMain.Testes.Visible:=True;
     Global.Usuario.Codigo:=999;
     Global.Usuario.Nome:='Suporte';
     Global.Usuario.Suporte:=True;
     Sistema.CodigoUsuario:=IntToStr(Global.Usuario.Codigo);
     Sistema.NomeUsuario:=Global.Usuario.Nome;
     Result:=True;
     for i:=1 to 4000 do Global.Usuario.ObjetosAcessados[i]:=True;
     for i:=1 to 4000 do Global.Usuario.OutrosAcessos[i]:=True;
     if not Arq.TUnidades.Active then Arq.TUnidades.Open;
     Global.Usuario.UnidadesMvto:='';
     Global.Usuario.UnidadesRelatorios:='';
     Arq.TUnidades.BeginProcess;
     while not Arq.TUnidades.Eof do begin
       Global.Usuario.UnidadesMvto:=Global.Usuario.UnidadesMvto+Arq.TUnidades.FieldByName('Unid_Codigo').AsString+';';
       Global.Usuario.UnidadesRelatorios:=Global.Usuario.UnidadesRelatorios+Arq.TUnidades.FieldByName('Unid_Codigo').AsString+';';
       Arq.TUnidades.Next;
     end;
     Arq.TUnidades.EndProcess;
     Global.Usuario.ContasAutPgto:=';';
     Global.Usuario.ContasCaixaValidas:=';';
     Arq.TPlano.BeginProcess;
     while not Arq.TPlano.Eof do begin
       if Pos(Arq.TPlano.FieldByName('Plan_Tipo').AsString,'CX,CB,CS')>0 then begin
          Global.Usuario.ContasCaixaValidas:=Global.Usuario.ContasCaixaValidas+IntToStr(Arq.TPlano.FieldByName('Plan_Conta').AsInteger)+';';
       end;
       if Pos(Arq.TPlano.FieldByName('Plan_Tipo').AsString,'CP,CR')>0 then begin
          Global.Usuario.ContasAutPgto:=Global.Usuario.ContasAutPgto+IntToStr(Arq.TPlano.FieldByName('Plan_Conta').AsInteger)+';';
       end;
       Arq.TPlano.Next;
     end;
     Arq.TPlano.EndProcess;
  end else begin
     if PrimeiroAcesso then begin
        Result:=FUsuarios.GetSenha;
     end else begin
        Result:=FUsuarios.GetNovoUsuario;
     end;
     FUsuarios.ProcessaAcessoObjetos;
     if (pos( Global.CodigoUnidade,Global.Usuario.UnidadesMvto )=0 ) and ( not primeiroacesso ) then begin
       Avisoerro('Usuário sem permissão para acessar unidade '+Global.CodigoUnidade);
       Close;
       FDiversos.ConfUnidade;
       Application.Terminate;
     end;
  end;
  FMain.PData.Caption:=DateToStr_(Sistema.Hoje);
  FMain.PUsuario.Caption:=' '+IntToStr(Global.Usuario.Codigo)+' - '+Global.Usuario.Nome;
// 27.04.15
  Arq.Ambiente.PanelMessages:=FMain.PMsg;

  FRel.SetParams(Global.NomeSistema+'D',FGeral.GetConfig1AsString('TituloRelatorios')+' - '+Global.NomeSistema+' '+Global.VersaoSistema,
          FUsuarios.Acesso(3301),FUsuarios.Acesso(3302),FUsuarios.Acesso(3304),FUsuarios.Acesso(3303),False);
// 27.09.07
  FRel.SetParamsEMail(FGeral.getconfig1asstring('SMTP'),FGeral.getconfig1asstring('USUARIOSMTP'),
                      FGeral.getconfig1asstring('SENHASMTP'),FGeral.getconfig1asstring('EMAILORIGEM'),
                      FGeral.GetConfig1AsInteger('portasmtp') );
//  FMovDctos.SetaDocumentos;
end;

procedure TFInit.InicializaConfiguracao;
/////////////////////////////////////////////
var i:integer;
    s:String;
    Q:TSqlQuery;
begin
  Global.Contadores.ConfigGeral:=FGeral.ConsultaContador('ConfigGeral');
  FGeral.InicializaConfig1;

  for i:=0 to 4000 do Global.Topicos[i]:=False;
  Q:=SqlToQuery('SELECT * FROM Config2');
  if Q.isEmpty then begin
     s:=Replicate('N',4000);
     ExecuteSql('INSERT INTO Config2 (Cfg2_Topicos) VALUES('+StringToSql(s)+')');
     Sistema.Commit;
  end else begin
     s:=Q.FieldByName('Cfg2_Topicos').AsString;
     for i:=1 to Length(s) do Global.Topicos[i]:=s[i]='S';
  end;
  Q.Close;Q.Free;

end;






end.


