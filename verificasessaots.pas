unit verificasessaots;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellAPi;

type
  WTS_INFO_CLASS = (
    WTSInitialProgram,
    WTSApplicationName,
    WTSWorkingDirectory,
    WTSOEMId,
    WTSSessionId,
    WTSUserName,
    WTSWinStationName,
    WTSDomainName,
    WTSConnectState,
    WTSClientBuildNumber,
    WTSClientName,
    WTSClientDirectory,
    WTSClientProductId,
    WTSClientHardwareId,
    WTSClientAddress,
    WTSClientDisplay,
    WTSClientProtocolType,
    WTSIdleTime,
    WTSLogonTime,
    WTSIncomingBytes,
    WTSOutgoingBytes,
    WTSIncomingFrames,
    WTSOutgoingFrames,
    WTSClientInfo,
    WTSSessionInfo,
    WTSSessionInfoEx,
    WTSConfigInfo,
    WTSValidationInfo,
    WTSSessionAddressV4,
    WTSIsRemoteSession
  );

  WTS_CONNECTSTATE_CLASS = (
    WTSActive,
    WTSConnected,
    WTSConnectQuery,
    WTSShadow,
    WTSDisconnected,
    WTSIdle,
    WTSListen,
    WTSReset,
    WTSDown,
    WTSInit
  );

  PWTS_SESSION_INFO = ^WTS_SESSION_INFO;
  WTS_SESSION_INFO = record
    SessionId: DWORD;
    pWinStationName: LPTSTR;
    State: WTS_CONNECTSTATE_CLASS;
  end;

const
//  WTS_CURRENT_SERVER_HANDLE: HANDLE = 0;
  WTS_CURRENT_SERVER_HANDLE: integer = 0;

function WTSEnumerateSessions(hServer: THandle; Reserved: DWORD; Version: DWORD; var ppSessionInfo: PWTS_SESSION_INFO; var pCount: DWORD): BOOL; stdcall; external 'Wtsapi32.dll' name {$IFDEF UNICODE}'WTSEnumerateSessionsW'{$ELSE}'WTSEnumerateSessionsA'{$ENDIF};

function WTSQuerySessionInformation(hServer: THandle; SessionId: DWORD; WTSInfoClass: WTS_INFO_CLASS; var ppBuffer: LPTSTR; var pBytesReturned: DWORD): BOOL; stdcall; external 'Wtsapi32.dll' name {$IFDEF UNICODE}'WTSQuerySessionInformationW'{$ELSE}'WTSQuerySessionInformationA'{$ENDIF};

procedure WTSFreeMemory(pMemory: Pointer); stdcall; external 'Wtsapi32.dll';

function Checa( idusuario:string):string ;


implementation


function  Checa( idusuario:string):string ;
///////////////////////////////////////
///
var
  Sessions, Session: PWTS_SESSION_INFO;
  NumSessions, I, NumBytes: DWORD;
  UserName: LPTSTR;
begin
  result := '';

  if not WTSEnumerateSessions(WTS_CURRENT_SERVER_HANDLE, 0, 1, Sessions, NumSessions) then
    RaiseLastOSError;
  try
    if NumSessions > 0 then
    begin
      Session := Sessions;
      for I := 0 to NumSessions-1 do
      begin
        if Session.State = WTSActive then
        begin
          if WTSQuerySessionInformation(WTS_CURRENT_SERVER_HANDLE, Session.SessionId, WTSUserName, UserName, NumBytes) then
          begin
            try
              // use UserName as needed...

              if IdUsuario = UserName then  begin

//                 showmessage('idusuario='+Idusuario+'|sessionid='+session.sessionid.ToString );
                 result :=trim(session.sessionid.ToString);
                 break;

              end;

            finally
              WTSFreeMemory(UserName);
            end;
          end;
        end;
        Inc(Session);
      end;
    end;
  finally
    WTSFreeMemory(Sessions);
  end;
end;


end.
