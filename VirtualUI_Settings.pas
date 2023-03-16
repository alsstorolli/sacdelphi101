/// <summary>
///   This unit contains wrapper classes to the VirtualUI Settings COM API,
///   to manage and customize VirtualUI configuration from an application.
/// </summary>
unit VirtualUI_Settings;

{$IFDEF FPC}{$DEFINE NOTSUPPORTED}{$ENDIF}
{$IFDEF VER90}{$DEFINE NOTSUPPORTED}{$ENDIF}
{$IFDEF VER100}{$DEFINE NOTSUPPORTED}{$ENDIF}
{$IFDEF VER110}{$DEFINE NOTSUPPORTED}{$ENDIF}
{$IFDEF VER120}{$DEFINE NOTSUPPORTED}{$ENDIF}
{$IFDEF NOTSUPPORTED}
STOP! // This compiler version is not supported through this library
{$ENDIF}
{$IFDEF VER130}
  {$DEFINE DELPHI5}
{$ELSE}
  {$IF CompilerVersion >= 14}
    {$DEFINE DELPHI6_PLUS}
  {$IFEND}
  {$IF CompilerVersion >= 20}
    {$DEFINE DELPHI2009_PLUS}
  {$IFEND}
  {$IF CompilerVersion >= 22}
    {$DEFINE DELPHIXE_PLUS}
  {$IFEND}
  {$IF CompilerVersion >= 23}
    {$DEFINE DELPHIXE2_PLUS}
  {$IFEND}
{$ENDIF}
interface
uses
  Windows, SysUtils, Registry, ActiveX, ShellAPI, Classes,
  {$IFDEF FMX}
    {$IF CompilerVersion >= 26}
    FMX.Graphics,
    {$ELSE}
    FMX.Types,
    {$IFEND}
  {$ELSE}
    {$IFDEF DELPHI6_PLUS}Variants,{$ENDIF} StdVCL,
    {$IFDEF DELPHI2009_PLUS}pngimage,{$ENDIF}
    {$IFDEF DELPHIXE2_PLUS}
    Vcl.Graphics, Vcl.OleServer,
    {$ELSE}
    Graphics, OleServer,
    {$ENDIF}
  {$ENDIF}
  IniFiles, EncdDecd;

const
  // TypeLibrary Major and minor versions
  VirtualUISMajorVersion = 1;
  VirtualUISMinorVersion = 0;

  LIBID_VirtualUIS: TGUID = '{D4DAF0A0-78A3-4A22-BA6D-C1566F6529F0}';

  IID_IServer: TGUID = '{845B4EE8-0F67-4D84-A4CE-642BBD520A47}';
  CLASS_Server_: TGUID = '{67F012A8-5C8D-4E30-B697-104AF434CF57}';
  IID_ILicense: TGUID = '{A1DF5DC4-7157-4643-B28F-3B3D20A0E5C8}';
  CLASS_License: TGUID = '{7FEB0F94-6A75-4C73-9842-7E16C6378BBB}';
  IID_IProfile: TGUID = '{D478CC7A-8071-47BD-BA2D-845131B51B42}';
  CLASS_Profile: TGUID = '{5FB96D71-BA5A-42BD-9917-65A0AC6AE52C}';
  IID_IProfiles: TGUID = '{C271394D-82FA-4DF9-A603-9927AA76A4F9}';
  CLASS_Profiles: TGUID = '{EF900598-E5FD-434D-8883-AC52B4A57E0A}';
  IID_IBinding: TGUID = '{52C63E8D-2FA4-4179-AFDB-2D33853F3356}';
  CLASS_Binding: TGUID = '{FD6E655F-6D88-4A68-A4C0-F5382C809AF6}';
  IID_ICertificate: TGUID = '{8B534446-EDC5-4EE7-91B0-13B5DACC5B51}';
  CLASS_Certificate: TGUID = '{8C4F00ED-0D77-42CC-BE28-DE88F31636C9}';
  IID_IRDS: TGUID = '{103B86C8-E012-4AC7-A366-D3845BBB8D5E}';
  CLASS_RDS: TGUID = '{B67864A0-0650-4838-9864-F7F19CD979A8}';
  IID_IRDSAccounts: TGUID = '{60666BC2-7E17-4842-9716-CFA3DCFD5583}';
  CLASS_RDSAccounts: TGUID = '{AD852F92-BE8E-40DF-B7FE-E96EE599DCDE}';
  IID_IGateways: TGUID = '{716BBB17-7A57-46D1-93BB-2C8A947E1F6B}';
  CLASS_Gateways: TGUID = '{F2A03C8E-F1FA-4799-B0BC-CDB40BB4C020}';
  IID_IUser: TGUID = '{0BA574FB-8F9D-4B7B-97FC-C869231B4E6E}';
  CLASS_User: TGUID = '{3CDC6336-D35E-4A4A-AAF5-9E58C72F205E}';
  IID_IUsers: TGUID = '{751686C0-EA61-420F-A861-F8A7A8329307}';
  CLASS_Users: TGUID = '{D72E94FF-0629-4941-80AD-22646FCA47A1}';
  IID_IAuthentication: TGUID = '{FEC05713-8C95-4A12-805A-CC3B11571501}';
  CLASS_Authentication: TGUID = '{7EB04B7F-E4E5-45BA-A9A1-E4E761814F38}';
  IID_ISSOUser: TGUID = '{25D8274E-75C2-4AC6-B95C-EA146B138AAE}';
  CLASS_SSOUser: TGUID = '{875842CC-28E5-4C67-9F30-F28800DD07CC}';
  IID_ISSOUsers: TGUID = '{5B1D5A75-BBED-4694-8AE0-6EB944DF6318}';
  CLASS_SSOUsers: TGUID = '{8E18D593-AB10-4761-A91F-B1B796B353E8}';
  IID_IAssociatedUserAccount: TGUID = '{99D48E0A-0C91-494C-9A2C-B67BC782B3C2}';
  IID_IAssociatedUserAccounts: TGUID = '{A230AD4D-104A-4444-ADBD-259D5243A485}';
  CLASS_AssociatedUserAccount: TGUID = '{4EA144D9-3F22-402D-9B1C-B9A2B1BAFCCE}';
  CLASS_AssociatedUserAccounts: TGUID = '{3B5CDF2D-2399-4658-B625-F5634771858E}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum Protocol
type
  Protocol = TOleEnum;
const
  PROTO_HTTP = $00000000;
  PROTO_HTTPS = $00000001;

// Constants for enum ProfileKind
type
  ProfileKind = TOleEnum;
const
  PROFILE_APP = $00000000;
  PROFILE_WEBLINK = $00000001;

// Constants for enum ScreenResolution
type
  ScreenResolution = TOleEnum;
const
  SCREENRES_Custom = $00000000;
  SCREENRES_FitToBrowser = $00000001;
  SCREENRES_FitToScreen = $00000002;
  SCREENRES_640x480 = $00000003;
  SCREENRES_800x600 = $00000004;
  SCREENRES_1024x768 = $00000005;
  SCREENRES_1280x720 = $00000006;
  SCREENRES_1280x768 = $00000007;
  SCREENRES_1280x1024 = $00000008;
  SCREENRES_1440x900 = $00000009;
  SCREENRES_1440x1050 = $0000000A;
  SCREENRES_1600x1200 = $0000000B;
  SCREENRES_1680x1050 = $0000000C;
  SCREENRES_1920x1080 = $0000000D;
  SCREENRES_1920x1200 = $0000000E;

// Constants for enum ServerSection
type
  ServerSection = TOleEnum;
const
  SRVSEC_GENERAL = $00000000;
  SRVSEC_RDS = $00000001;
  SRVSEC_APPLICATIONS = $00000002;
  SRVSEC_LICENSES = $00000003;

// Constants for enum UserType
type
  UserType = TOleEnum;
const
  UT_USER = $00000000;
  UT_GROUP = $00000001;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IServer = interface;
  IServerDisp = dispinterface;
  ILicense = interface;
  ILicenseDisp = dispinterface;
  IProfile = interface;
  IProfileDisp = dispinterface;
  IProfiles = interface;
  IProfilesDisp = dispinterface;
  IBinding = interface;
  IBindingDisp = dispinterface;
  ICertificate = interface;
  ICertificateDisp = dispinterface;
  IRDS = interface;
  IRDSDisp = dispinterface;
  IRDSAccounts = interface;
  IRDSAccountsDisp = dispinterface;
  IGateways = interface;
  IGatewaysDisp = dispinterface;
  IUser = interface;
  IUserDisp = dispinterface;
  IUsers = interface;
  IUsersDisp = dispinterface;
  IAuthentication = interface;
  IAuthenticationDisp = dispinterface;
  ISSOUser = interface;
  ISSOUserDisp = dispinterface;
  ISSOUsers = interface;
  ISSOUsersDisp = dispinterface;
  IAssociatedUserAccount = interface;
  IAssociatedUserAccountDisp = dispinterface;
  IAssociatedUserAccounts = interface;
  IAssociatedUserAccountsDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  Server_ = IServer;
  License = ILicense;
  Profile = IProfile;
  Profiles = IProfiles;
  Binding = IBinding;
  Certificate = ICertificate;
  RDS = IRDS;
  RDSAccounts = IRDSAccounts;
  Gateways = IGateways;
  User = IUser;
  Users = IUsers;
  Authentication = IAuthentication;
  SSOUser = ISSOUser;
  SSOUsers = ISSOUsers;
  AssociatedUserAccount = IAssociatedUserAccount;
  AssociatedUserAccounts = IAssociatedUserAccounts;


// *********************************************************************//
// Interface: IServer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {845B4EE8-0F67-4D84-A4CE-642BBD520A47}
// *********************************************************************//
  IServer = interface(IDispatch)
    ['{845B4EE8-0F67-4D84-A4CE-642BBD520A47}']
    function Get_Binding: IBinding; safecall;
    function Get_Certificate: ICertificate; safecall;
    function Get_RDSAccounts: IRDSAccounts; safecall;
    function Get_Profiles: IProfiles; safecall;
    procedure Load; safecall;
    procedure Save; safecall;
    procedure HideSection(section: ServerSection); safecall;
    procedure ShowSection(section: ServerSection); safecall;
    function Get_License: ILicense; safecall;
    function Get_Gateways: IGateways; safecall;
    function Get_NetworkID: WideString; safecall;
    procedure Set_NetworkID(const Value: WideString); safecall;
    function Get_Authentication: IAuthentication; safecall;
    property Binding: IBinding read Get_Binding;
    property Certificate: ICertificate read Get_Certificate;
    property RDSAccounts: IRDSAccounts read Get_RDSAccounts;
    property Profiles: IProfiles read Get_Profiles;
    property License: ILicense read Get_License;
    property Gateways: IGateways read Get_Gateways;
    property NetworkID: WideString read Get_NetworkID write Set_NetworkID;
    property Authentication: IAuthentication read Get_Authentication;
  end;

// *********************************************************************//
// DispIntf:  IServerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {845B4EE8-0F67-4D84-A4CE-642BBD520A47}
// *********************************************************************//
  IServerDisp = dispinterface
    ['{845B4EE8-0F67-4D84-A4CE-642BBD520A47}']
    property Binding: IBinding readonly dispid 201;
    property Certificate: ICertificate readonly dispid 202;
    property RDSAccounts: IRDSAccounts readonly dispid 203;
    property Profiles: IProfiles readonly dispid 204;
    procedure Load; dispid 205;
    procedure Save; dispid 206;
    procedure HideSection(section: ServerSection); dispid 207;
    procedure ShowSection(section: ServerSection); dispid 208;
    property License: ILicense readonly dispid 209;
    property Gateways: IGateways readonly dispid 210;
    property NetworkID: WideString dispid 211;
    property Authentication: IAuthentication readonly dispid 212;
  end;

// *********************************************************************//
// Interface: ILicense
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A1DF5DC4-7157-4643-B28F-3B3D20A0E5C8}
// *********************************************************************//
  /// <summary>
  /// Contains methods and properties to control VirtualUI Server's
  /// licence activation. 
  /// </summary>                                                   
  ILicense = interface(IDispatch)
    ['{A1DF5DC4-7157-4643-B28F-3B3D20A0E5C8}']
    function Get_CustomerID: WideString; safecall;
    procedure Set_CustomerID(const Value: WideString); safecall;
    function Get_Limits(const name: WideString): Integer; safecall;
    function Get_Features(const name: WideString): Integer; safecall;
    function Get_IsTrial: WordBool; safecall;
    procedure Set_IsTrial(Value: WordBool); safecall;
    function Get_SerialStr: WideString; safecall;
    procedure Set_SerialStr(const Value: WideString); safecall;

    /// <summary>
    /// Activates the Server's machine license.
    /// </summary>
    /// <param name="customerId">ID of the license to register. </param>
    /// <param name="serial">Serial number of the license. </param>
    /// <param name="resultCode">Activation result code. </param>
    /// <param name="resultText">Message about the error. </param>
    /// <returns>
    /// True if the license was successfully activated. False
    /// otherwise (in which case check resultCode and resultText).
    /// </returns>
    function Activate(const customerId: WideString; const serial: WideString;
                      out resultCode: Integer; out resultTex: WideString): WordBool; safecall;
    /// <summary>
    /// Deactivates the previously activated license.
    /// </summary>
    procedure Deactivate; safecall;

    function Get_TrialDaysLeft: Integer; safecall;
    function Get_IsValid: WordBool; safecall;

    /// <summary>
    /// Using the Serial number property, gets from Activation Server the
    /// Manual Key the Server's machine. This key can be used to generate the
    /// license data needed to perform manual activation.
    /// </summary>
    /// <returns>
    /// The manual activation key.
    /// </returns>
    function GetManualActivationKey: WideString; safecall;

    /// <summary>
    /// Activates the Server's machine license manually.
    /// </summary>
    /// <param name="Data">License data received from Server. </param>
    /// <param name="resultCode">Activation result code. </param>
    /// <param name="resultText">Message about the error. </param>
    /// <returns>
    /// True if the license was successfully activated. False
    /// otherwise (in which case check resultCode and resultText).
    /// </returns>
    function ActivateManual(const Data: WideString; out resultCode: Integer;
                            out resultText: WideString): WordBool; safecall;

    /// <summary>
    ///   ID of the current Server License.
    /// </summary>
    property CustomerID: WideString read Get_CustomerID write Set_CustomerID;
    /// <summary>
    /// \Returns the License limits, if any (ie, trial days, max
    /// servers, max users per installation, etc).
    /// </summary>
    property Limits[const name: WideString]: Integer read Get_Limits;
    /// <summary>
    ///   Returns custom features enabled on the License, if any.
    /// </summary>
    property Features[const name: WideString]: Integer read Get_Features;
    /// <summary>
    ///   Returns true if the current License is in trial mode.
    /// </summary>
    property IsTrial: WordBool read Get_IsTrial write Set_IsTrial;
    /// <summary>
    ///   Serial number of the current License.
    /// </summary>
    property SerialStr: WideString read Get_SerialStr write Set_SerialStr;
    property TrialDaysLeft: Integer read Get_TrialDaysLeft;
    property IsValid: WordBool read Get_IsValid;
  end;

// *********************************************************************//
// DispIntf:  ILicenseDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A1DF5DC4-7157-4643-B28F-3B3D20A0E5C8}
// *********************************************************************//
  ILicenseDisp = dispinterface
    ['{A1DF5DC4-7157-4643-B28F-3B3D20A0E5C8}']
    property CustomerID: WideString dispid 201;
    property Limits[const name: WideString]: Integer readonly dispid 203;
    property Features[const name: WideString]: Integer readonly dispid 204;
    property IsTrial: WordBool dispid 205;
    property SerialStr: WideString dispid 202;
    function Activate(const customerId: WideString; const serial: WideString;
                      out resultCode: Integer; out resultTex: WideString): WordBool; dispid 206;
    procedure Deactivate; dispid 207;
    property TrialDaysLeft: Integer readonly dispid 208;
    property IsValid: WordBool readonly dispid 209;
    function GetManualActivationKey: WideString; dispid 210;
    function ActivateManual(const Data: WideString; out resultCode: Integer;
                            out resultText: WideString): WordBool; dispid 211;
  end;

// *********************************************************************//
// Interface: IProfile
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D478CC7A-8071-47BD-BA2D-845131B51B42}
// *********************************************************************//
  /// <summary>
  /// A profile contains information about an application or web
  /// link configured to be opened in VirtualUI's home page (or
  /// directly through its URL). 
  /// </summary>                                                
  IProfile = interface(IDispatch)
    ['{D478CC7A-8071-47BD-BA2D-845131B51B42}']
    function Get_ID: WideString; safecall;
    procedure Set_ID(const Value: WideString); safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Value: WideString); safecall;
    function Get_VirtualPath: WideString; safecall;
    procedure Set_VirtualPath(const Value: WideString); safecall;
    function Get_IsDefault: WordBool; stdcall;
    procedure Set_IsDefault(Value: WordBool); safecall;
    function Get_Enabled: WordBool; stdcall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_ProfileKind: ProfileKind; stdcall;
    procedure Set_ProfileKind(Value: ProfileKind); safecall;
    function Get_FileName: WideString; safecall;
    procedure Set_FileName(const Value: WideString); safecall;
    function Get_Arguments: WideString; safecall;
    procedure Set_Arguments(const Value: WideString); safecall;
    function Get_StartDir: WideString; safecall;
    procedure Set_StartDir(const Value: WideString); safecall;
    function Get_UserName: WideString; safecall;
    procedure Set_UserName(const Value: WideString); safecall;
    function Get_Password: WideString; safecall;
    procedure Set_Password(const Value: WideString); safecall;
    function Get_ScreenResolution: ScreenResolution; stdcall;
    procedure Set_ScreenResolution(Value: ScreenResolution); safecall;
    function Get_WebLink: WideString; safecall;
    procedure Set_WebLink(const Value: WideString); safecall;
    function Get_HomePage: WideString; safecall;
    procedure Set_HomePage(const Value: WideString); safecall;
    function Get_IdleTimeout: Integer; stdcall;
    procedure Set_IdleTimeout(Value: Integer); safecall;
    function Get_IconData: WideString; safecall;
    procedure Set_IconData(const Value: WideString); safecall;
    function Get_Visible: WordBool; stdcall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_GuestAllowed: WordBool; stdcall;
    procedure Set_GuestAllowed(Value: WordBool); safecall;
    function Get_Users: IUsers; safecall;

    /// <summary>
    ///   Internal ID of the profile. This value is auto generated by the
    ///   library when the profile is created.
    /// </summary>
    property ID: WideString read Get_ID write Set_ID;
    /// <summary>
    /// Profile name. It's the caption for the Application or Web
    /// link in the VirtualUI home page. 
    /// </summary>                                               
    property Name: WideString read Get_Name write Set_Name;
    /// <summary>
    ///   The Virtual Path must be unique across all profiles. It will create a
    ///   unique URL address for the profile. The complete path will consist
    ///   of: http(s)://ip:port/VirtualPath/. The users can then create a web
    ///   shortcut to this connection in particular and bypass the Thinfinity
    ///   VirtualUI home page.
    /// </summary>
    property VirtualPath: WideString read Get_VirtualPath write Set_VirtualPath;
    /// <summary>
    ///   This option is used to make this profile the default application: the
    ///   authenticated user will connect to this profile directly instead of
    ///   choosing between the available profiles on the VirtualUI home page.
    /// </summary>
    property IsDefault: WordBool read Get_IsDefault write Set_IsDefault;
    /// <summary>
    /// Enables or disables the profile. Disabled profiles are not
    /// accessible by users.
    /// </summary>
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    /// <summary>
    /// Gets or sets the profile type: Application or Web Link. Uses
    /// the PROFILE_App and PROFILE_WebLink constants. 
    /// </summary>                                                  
    property ProfileKind: ProfileKind read Get_ProfileKind write Set_ProfileKind;
    /// <summary>
    ///   Complete path of the application executable file. Only used when the
    ///   ProfileKind is Application.
    /// </summary>
    property FileName: WideString read Get_FileName write Set_FileName;
    /// <summary>
    ///   Parameters to be passed to application.
    /// </summary>
    property Arguments: WideString read Get_Arguments write Set_Arguments;
    /// <summary>
    /// Application startup directory. In most cases, the same
    /// directory of the application executable file. 
    /// </summary>                                            
    property StartDir: WideString read Get_StartDir write Set_StartDir;
    /// <summary>
    ///   A valid Windows User account to run the application.
    /// </summary>
    property UserName: WideString read Get_UserName write Set_UserName;
    /// <summary>
    ///   Password of the Windows User account.
    /// </summary>
    property Password: WideString read Get_Password write Set_Password;
    /// <summary>
    ///   Screen resolution in the browser. Uses the constants SCREENRES_...
    /// </summary>
    property ScreenResolution: ScreenResolution read Get_ScreenResolution write Set_ScreenResolution;
    /// <summary>
    /// Complete Web Link URL (used only when ProfileKind is Web
    /// Link). 
    /// </summary>                                              
    property WebLink: WideString read Get_WebLink write Set_WebLink;
    /// <summary>
    /// Use it to set a customized home page for the application. 
    /// </summary>                                                
    property HomePage: WideString read Get_HomePage write Set_HomePage;
    /// <summary>
    /// Set a timeout in minutes if you want VirtualUI Server to wait
    /// before killing the application once the browser has been
    /// closed. Timeout 0 will kill the application immediately after
    /// the browser has been closed. 
    /// </summary>                                                   
    property IdleTimeout: Integer read Get_IdleTimeout write Set_IdleTimeout;
    /// <summary>
    /// Contains the icon of the profile. This icon is visible in the
    /// VirtualUI home page. The icon must be encoded in base64. To
    /// convert the icon from a PNG image, you can use the
    /// IconToBase64 function. To convert the stored icon to a PNG
    /// image, you can use the Base64ToIcon function. 
    /// </summary>                                                   
    property IconData: WideString read Get_IconData write Set_IconData;
    /// <summary>
    /// Profiles marked as not visible are hidden in home page.
    /// </summary>
    property Visible: WordBool read Get_Visible write Set_Visible;
    /// <summary>
    /// Indicates anonymous access to this profile. If false, the
    /// users or groups in Users are used.
    /// </summary>
    property GuestAllowed: WordBool read Get_GuestAllowed write Set_GuestAllowed;
    /// <summary>
    /// Users or Groups with granted access to this profile (only
    /// when GuestAllowed is false).
    /// </summary>
    property Users: IUsers read Get_Users;
  end;

// *********************************************************************//
// DispIntf:  IProfileDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D478CC7A-8071-47BD-BA2D-845131B51B42}
// *********************************************************************//
  IProfileDisp = dispinterface
    ['{D478CC7A-8071-47BD-BA2D-845131B51B42}']
    property ID: WideString dispid 201;
    property Name: WideString dispid 202;
    property VirtualPath: WideString dispid 203;
    property IsDefault: WordBool dispid 204;
    property Enabled: WordBool dispid 205;
    property ProfileKind: ProfileKind dispid 207;
    property FileName: WideString dispid 208;
    property Arguments: WideString dispid 209;
    property StartDir: WideString dispid 210;
    property UserName: WideString dispid 211;
    property Password: WideString dispid 212;
    property ScreenResolution: ScreenResolution dispid 213;
    property WebLink: WideString dispid 214;
    property HomePage: WideString dispid 215;
    property IdleTimeout: Integer dispid 216;
    property IconData: WideString dispid 206;
    property Visible: WordBool dispid 217;
    property GuestAllowed: WordBool dispid 218;
    property Users: IUsers readonly dispid 219;
  end;

// *********************************************************************//
// Interface: IProfiles
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C271394D-82FA-4DF9-A603-9927AA76A4F9}
// *********************************************************************//
  /// <summary>
  /// Contains the list of profiles registered in VirtualUI Server.
  /// 
  /// </summary>                                                   
  IProfiles = interface(IDispatch)
    ['{C271394D-82FA-4DF9-A603-9927AA76A4F9}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IProfile; safecall;

    /// <summary>
    /// Creates a new profile and adds it to the list.
    /// </summary>
    /// <returns>
    /// The newly created profile.
    /// </returns>
    /// <seealso cref="IProfile interface"/>
    function Add: IProfile; safecall;
    /// <summary>
    /// Deletes a profile from the list.
    /// </summary>
    /// <param name="profile">The profile to be deleted. </param>
    procedure Delete(const profile: IProfile); safecall;
    /// <summary>
    ///   Returns the profile count.
    /// </summary>
    property Count: Integer read Get_Count;
    /// <value>
    /// Profile interface.
    /// </value>
    /// <summary>
    /// \Returns a profile from the list by its index.
    /// </summary>
    /// <seealso cref="IProfile"/>                    
    property Item[index: Integer]: IProfile read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IProfilesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C271394D-82FA-4DF9-A603-9927AA76A4F9}
// *********************************************************************//
  IProfilesDisp = dispinterface
    ['{C271394D-82FA-4DF9-A603-9927AA76A4F9}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IProfile readonly dispid 202;
    function Add: IProfile; dispid 205;
    procedure Delete(const profile: IProfile); dispid 206;
  end;

// *********************************************************************//
// Interface: IBinding
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {52C63E8D-2FA4-4179-AFDB-2D33853F3356}
// *********************************************************************//
  /// <summary>
  /// Manage the Server's Binding configuration: protocol, IP
  /// addresses and listening port. 
  /// </summary>                                             
  IBinding = interface(IDispatch)
    ['{52C63E8D-2FA4-4179-AFDB-2D33853F3356}']
    function Get_Protocol: Protocol; stdcall;
    procedure Set_Protocol(Value: Protocol); safecall;
    function Get_IPAddress: WideString; safecall;
    procedure Set_IPAddress(const Value: WideString); safecall;
    function Get_Port: Integer; stdcall;
    procedure Set_Port(Value: Integer); safecall;

    /// <summary>
    /// Gets o sets the network protocol: HTTP or HTTPS. Uses the
    /// PROTO_HTTP and PROTO_HTTPS constants. 
    /// </summary>                                               
    property Protocol: Protocol read Get_Protocol write Set_Protocol;
    /// <summary>
    /// Gets o sets the local IP Address. Leave empty to use all
    /// addresses.
    /// </summary>
    property IPAddress: WideString read Get_IPAddress write Set_IPAddress;
    /// <summary>
    /// Gets o sets the listening port.
    /// </summary>
    property Port: Integer read Get_Port write Set_Port;
  end;

// *********************************************************************//
// DispIntf:  IBindingDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {52C63E8D-2FA4-4179-AFDB-2D33853F3356}
// *********************************************************************//
  IBindingDisp = dispinterface
    ['{52C63E8D-2FA4-4179-AFDB-2D33853F3356}']
    property Protocol: Protocol dispid 201;
    property IPAddress: WideString dispid 202;
    property Port: Integer dispid 203;
  end;

// *********************************************************************//
// Interface: ICertificate
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8B534446-EDC5-4EE7-91B0-13B5DACC5B51}
// *********************************************************************//
  /// <summary>
  ///   Manages the certificate's configuration for HTTPS Binding.
  /// </summary>
  ICertificate = interface(IDispatch)
    ['{8B534446-EDC5-4EE7-91B0-13B5DACC5B51}']
    function Get_CertFile: WideString; safecall;
    procedure Set_CertFile(const Value: WideString); safecall;
    function Get_CAFile: WideString; safecall;
    procedure Set_CAFile(const Value: WideString); safecall;
    function Get_PKFile: WideString; safecall;
    procedure Set_PKFile(const Value: WideString); safecall;
    function Get_PassPhrase: WideString; safecall;
    procedure Set_PassPhrase(const Value: WideString); safecall;

    /// <summary>
    /// Gets o sets the Certificate file path. 
    /// </summary>                             
    property CertFile: WideString read Get_CertFile write Set_CertFile;
    /// <summary>
    /// Gets o sets the Certificate Authority file path. 
    /// </summary>                                       
    property CAFile: WideString read Get_CAFile write Set_CAFile;
    /// <summary>
    ///   Gets o sets the path of Private Key file.
    /// </summary>
    property PKFile: WideString read Get_PKFile write Set_PKFile;
    /// <summary>
    ///   Gets o sets the certificate password.
    /// </summary>
    property PassPhrase: WideString read Get_PassPhrase write Set_PassPhrase;
  end;

// *********************************************************************//
// DispIntf:  ICertificateDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8B534446-EDC5-4EE7-91B0-13B5DACC5B51}
// *********************************************************************//
  ICertificateDisp = dispinterface
    ['{8B534446-EDC5-4EE7-91B0-13B5DACC5B51}']
    property CertFile: WideString dispid 201;
    property CAFile: WideString dispid 202;
    property PKFile: WideString dispid 203;
    property PassPhrase: WideString dispid 204;
  end;

// *********************************************************************//
// Interface: IRDS
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {103B86C8-E012-4AC7-A366-D3845BBB8D5E}
// *********************************************************************//
  /// <summary>
  ///   Manages the configuration of an alternative Remote Desktop Services
  ///   account.
  /// </summary>
  IRDS = interface(IDispatch)
    ['{103B86C8-E012-4AC7-A366-D3845BBB8D5E}']
    function Get_UserName: WideString; safecall;
    procedure Set_UserName(const Value: WideString); safecall;
    function Get_Password: WideString; safecall;
    procedure Set_Password(const Value: WideString); safecall;

    /// <summary>
    /// Gets o sets the RDS Username.
    /// </summary>
    property UserName: WideString read Get_UserName write Set_UserName;
    /// <summary>
    ///   Gets o sets the RDS Password.
    /// </summary>
    property Password: WideString read Get_Password write Set_Password;
  end;

// *********************************************************************//
// DispIntf:  IRDSDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {103B86C8-E012-4AC7-A366-D3845BBB8D5E}
// *********************************************************************//
  IRDSDisp = dispinterface
    ['{103B86C8-E012-4AC7-A366-D3845BBB8D5E}']
    property UserName: WideString dispid 201;
    property Password: WideString dispid 202;
  end;

// *********************************************************************//
// Interface: IRDSAccounts
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {60666BC2-7E17-4842-9716-CFA3DCFD5583}
// *********************************************************************//
  /// <summary>
  /// Contains Remote Desktop Services accounts. VirtualUI makes
  /// use of an interactive session. The default setting is to run
  /// applications under the console session, but VirtualUI can
  /// also be configured to run applications under Remote Desktop
  /// Services sessions. For the production environment, it is
  /// recommended to set VirtualUI to run applications under its
  /// own Remote Desktop Services session. This will ensure that
  /// the service is available at all times. Alternatively, you can
  /// choose to have VirtualUI run the applications under the
  /// console session by configuring the Auto Logon feature on your
  /// Windows operating system. 
  /// </summary>                                                   
  IRDSAccounts = interface(IDispatch)
    ['{60666BC2-7E17-4842-9716-CFA3DCFD5583}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IRDS; safecall;

    /// <summary>
    /// Creates a new RDS account and adds it to the list.
    /// </summary>
    /// <returns>
    /// The newly created RDS account.
    /// </returns>
    /// <seealso cref="IRDS interface"/>
    function Add(const UserName: WideString; const Password: WideString; CreateAccount: WordBool): IRDS; safecall;
    /// <summary>
    ///   Deletes an RDS account from the list.
    /// </summary>
    /// <param name="UserName">
    ///   The account to be deleted.
    /// </param>
    /// <param name="DeleteAccount">
    ///   If true, the Windows account is also deleted.
    /// </param>
    function Delete(const UserName: WideString; DeleteAccount: WordBool): WordBool; safecall;
    /// <summary>
    ///   Returns the accounts count.
    /// </summary>
    property Count: Integer read Get_Count;
    /// <summary>
    ///   Returns an RDS account from the list by it's index.
    /// </summary>
    /// <seealso cref="IRDS">
    ///   RDS account.
    /// </seealso>
    property Item[index: Integer]: IRDS read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IRDSAccountsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {60666BC2-7E17-4842-9716-CFA3DCFD5583}
// *********************************************************************//
  IRDSAccountsDisp = dispinterface
    ['{60666BC2-7E17-4842-9716-CFA3DCFD5583}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IRDS readonly dispid 202;
    function Add(const UserName: WideString; const Password: WideString; CreateAccount: WordBool): IRDS; dispid 203;
    function Delete(const UserName: WideString; DeleteAccount: WordBool): WordBool; dispid 204;
  end;

// *********************************************************************//
// Interface: IGateways
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {716BBB17-7A57-46D1-93BB-2C8A947E1F6B}
// *********************************************************************//
  IGateways = interface(IDispatch)
    ['{716BBB17-7A57-46D1-93BB-2C8A947E1F6B}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): WideString; safecall;
    procedure Add(const URL: WideString); safecall;
    procedure Delete(Index: Integer); safecall;
    property Count: Integer read Get_Count;
    property Item[index: Integer]: WideString read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IGatewaysDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {716BBB17-7A57-46D1-93BB-2C8A947E1F6B}
// *********************************************************************//
  IGatewaysDisp = dispinterface
    ['{716BBB17-7A57-46D1-93BB-2C8A947E1F6B}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: WideString readonly dispid 202;
    procedure Add(const URL: WideString); dispid 203;
    procedure Delete(Index: Integer); dispid 204;
  end;

// *********************************************************************//
// Interface: IUser
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0BA574FB-8F9D-4B7B-97FC-C869231B4E6E}
// *********************************************************************//
  IUser = interface(IDispatch)
    ['{0BA574FB-8F9D-4B7B-97FC-C869231B4E6E}']
    function Get_UserType: UserType; safecall;
    function Get_SamCompatible: WideString; safecall;
    property UserType: UserType read Get_UserType;
    property SamCompatible: WideString read Get_SamCompatible;
  end;

// *********************************************************************//
// DispIntf:  IUserDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0BA574FB-8F9D-4B7B-97FC-C869231B4E6E}
// *********************************************************************//
  IUserDisp = dispinterface
    ['{0BA574FB-8F9D-4B7B-97FC-C869231B4E6E}']
    property UserType: UserType dispid 201;
    property SamCompatible: WideString dispid 202;
  end;

// *********************************************************************//
// Interface: IUsers
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {751686C0-EA61-420F-A861-F8A7A8329307}
// *********************************************************************//
  IUsers = interface(IDispatch)
    ['{751686C0-EA61-420F-A861-F8A7A8329307}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IUser; safecall;
    /// <summary>
    /// Creates a new User and adds it to the list.
    /// </summary>
    /// <param name="UserType">
    ///   Indicates type of User that SamCompatible defines
    ///   (UserType enum: User or Group).
    /// </param>
    /// <param name="SamCompatible">
    ///   User or Group (according to UserType) to grant.
    /// </param>
    /// <returns>
    /// The newly created User.
    /// </returns>
    /// <seealso cref="IUser">
    ///   User interface.
    /// </seealso>
    function Add(UserType: UserType; const SamCompatible: WideString): IUser; safecall;
    /// <summary>
    ///   Deletes a User from the list.
    /// </summary>
    /// <param name="UserType">
    ///   Indicates type of User that SamCompatible defines
    ///   (UserType enum: User or Group).
    /// </param>
    /// <param name="SamCompatible">
    ///   The User to be deleted.
    /// </param>
    function Delete(UserType: UserType; const SamCompatible: WideString): WordBool; safecall;
    /// <summary>
    ///   Removes the User.
    /// </summary>
    function Remove(const User: IUser): WordBool; safecall;
    /// <summary>
    ///   Returns the Users count.
    /// </summary>
    property Count: Integer read Get_Count;
    /// <summary>
    ///   Returns a User from the list by it's index.
    /// </summary>
    /// <seealso cref="IUser">
    ///   User interface.
    /// </seealso>
    property Item[index: Integer]: IUser read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IUsersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {751686C0-EA61-420F-A861-F8A7A8329307}
// *********************************************************************//
  IUsersDisp = dispinterface
    ['{751686C0-EA61-420F-A861-F8A7A8329307}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IUser readonly dispid 202;
    function Add(UserType: UserType; const SamCompatible: WideString): IUser; dispid 203;
    function Delete(UserType: Integer; const SamCompatible: WideString): WordBool; dispid 204;
    function Remove(const User: IUser): WordBool; dispid 205;
  end;

// *********************************************************************//
// Interface: IAuthentication
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FEC05713-8C95-4A12-805A-CC3B11571501}
// *********************************************************************//
  IAuthentication = interface(IDispatch)
    ['{FEC05713-8C95-4A12-805A-CC3B11571501}']
    function Get_AllowAnonymous: WordBool; stdcall;
    procedure Set_AllowAnonymous(Value: WordBool); safecall;
    function Get_SSOUsers: ISSOUsers; safecall;
    /// <summary>
    ///   Enables or disables the anonymous access to the Server home page.
    /// </summary>
    property AllowAnonymous: WordBool read Get_AllowAnonymous write Set_AllowAnonymous;
    /// <summary>
    ///   Returns the SSO user mappings. This can be used to map usernames
    ///   used in SSO authentication methods to Windows user names or
    ///   groups, used in profiles permissions.
    /// </summary>
    property SSOUsers: ISSOUsers read Get_SSOUsers;
  end;

// *********************************************************************//
// DispIntf:  IAuthenticationDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FEC05713-8C95-4A12-805A-CC3B11571501}
// *********************************************************************//
  IAuthenticationDisp = dispinterface
    ['{FEC05713-8C95-4A12-805A-CC3B11571501}']
    property AllowAnonymous: WordBool dispid 201;
    property SSOUsers: ISSOUsers readonly dispid 202;
  end;

// *********************************************************************//
// Interface: ISSOUser
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {25D8274E-75C2-4AC6-B95C-EA146B138AAE}
// *********************************************************************//
  ISSOUser = interface(IDispatch)
    ['{25D8274E-75C2-4AC6-B95C-EA146B138AAE}']
    function Get_RemoteUser: WideString; safecall;
    function Get_MethodId: WideString; safecall;
    function Get_Enabled: WordBool; stdcall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_AssociatedUserAccounts: IAssociatedUserAccounts; safecall;
    /// <summary>
    ///   Remote Username mask to match
    /// </summary>
    property RemoteUser: WideString read Get_RemoteUser;
    /// <summary>
    ///   MethodId to match. Can be one of the Authentication Methods
    ///   configured in Server (like Google, Facebook, etc) or * to match all
    /// </summary>
    property MethodId: WideString read Get_MethodId;
    /// <summary>
    ///   Enables or disables this mapping
    /// </summary>
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    /// <summary>
    ///   Users or Groups mapped to this RemoteUser/MethodId
    /// </summary>
    property AssociatedUserAccounts: IAssociatedUserAccounts read Get_AssociatedUserAccounts;
  end;

// *********************************************************************//
// DispIntf:  ISSOUserDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {25D8274E-75C2-4AC6-B95C-EA146B138AAE}
// *********************************************************************//
  ISSOUserDisp = dispinterface
    ['{25D8274E-75C2-4AC6-B95C-EA146B138AAE}']
    property RemoteUser: WideString readonly dispid 201;
    property MethodId: WideString readonly dispid 202;
    property Enabled: WordBool dispid 203;
    property AssociatedUserAccounts: IAssociatedUserAccounts readonly dispid 204;
  end;

// *********************************************************************//
// Interface: ISSOUsers
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5B1D5A75-BBED-4694-8AE0-6EB944DF6318}
// *********************************************************************//
  ISSOUsers = interface(IDispatch)
    ['{5B1D5A75-BBED-4694-8AE0-6EB944DF6318}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): ISSOUser; safecall;
    /// <summary>
    ///   Creates a new Associated User and adds it to the list.
    /// </summary>
    /// <param name="RemoteUser">
    ///   Remote Username mask
    /// </param>
    /// <param name="MethodID">
    ///   MethodId to match. Can be one of the Authentication Methods
    ///   configured in Server (like Google, Facebook, etc) or * to match all
    /// </param>
    /// <param name="Enabled">
    ///   Indicates if the mapping is enabled or disabled.
    /// </param>
    /// <returns>
    /// The newly created SSO User mapping.
    /// </returns>
    /// <seealso cref="ISSOUser">
    ///   SSO User interface.
    /// </seealso>
    function Add(const RemoteUser: WideString; const MethodID: WideString; Enabled: WordBool): ISSOUser; safecall;
    /// <summary>
    ///   Deletes a SSO User mapping from the list, based on RemoteUser+MethodId.
    /// </summary>
    function Delete(const RemoteUser: WideString; const MethodId: WideString): WordBool; safecall;
    /// <summary>
    ///   Removes the SSO User mapping.
    /// </summary>
    function Remove(const SSOUser: ISSOUser): WordBool; safecall;
    /// <summary>
    ///   Returns the mappings count.
    /// </summary>
    property Count: Integer read Get_Count;
    /// <summary>
    ///   Returns a SSO User mapping from the list by it's index.
    /// </summary>
    /// <seealso cref="ISSOUser">
    ///   SSO User interface.
    /// </seealso>
    property Item[index: Integer]: ISSOUser read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  ISSOUsersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5B1D5A75-BBED-4694-8AE0-6EB944DF6318}
// *********************************************************************//
  ISSOUsersDisp = dispinterface
    ['{5B1D5A75-BBED-4694-8AE0-6EB944DF6318}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: ISSOUser readonly dispid 202;
    function Add(const RemoteUser: WideString; const MethodID: WideString; Enabled: WordBool): ISSOUser; dispid 203;
    function Delete(const RemoteUser: WideString; const MethodId: WideString): WordBool; dispid 204;
    function Remove(const SSOUser: ISSOUser): WordBool; dispid 205;
  end;

// *********************************************************************//
// Interface: IAssociatedUserAccount
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {99D48E0A-0C91-494C-9A2C-B67BC782B3C2}
// *********************************************************************//
  IAssociatedUserAccount = interface(IDispatch)
    ['{99D48E0A-0C91-494C-9A2C-B67BC782B3C2}']
    function Get_UserType: UserType; safecall;
    function Get_SamCompatible: WideString; safecall;
    /// <summary>
    ///   Indicates type of User that SamCompatible defines
    ///   (UserType enum: User or Group).
    /// </summary>
    property UserType: UserType read Get_UserType;
    /// <summary>
    ///   User or Group (according to UserType).
    /// </summary>
    property SamCompatible: WideString read Get_SamCompatible;
  end;

// *********************************************************************//
// DispIntf:  IAssociatedUserAccountDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {99D48E0A-0C91-494C-9A2C-B67BC782B3C2}
// *********************************************************************//
  IAssociatedUserAccountDisp = dispinterface
    ['{99D48E0A-0C91-494C-9A2C-B67BC782B3C2}']
    property UserType: UserType readonly dispid 201;
    property SamCompatible: WideString readonly dispid 202;
  end;

// *********************************************************************//
// Interface: IAssociatedUserAccounts
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A230AD4D-104A-4444-ADBD-259D5243A485}
// *********************************************************************//
  IAssociatedUserAccounts = interface(IDispatch)
    ['{A230AD4D-104A-4444-ADBD-259D5243A485}']
    function Get_Count: Integer; safecall;
    function Get_Item(index: Integer): IAssociatedUserAccount; safecall;
    /// <summary>
    ///   Creates a new Associated User and adds it to the list.
    /// </summary>
    /// <param name="UserType">
    ///   Indicates type of User that SamCompatible defines
    ///   (UserType enum: User or Group).
    /// </param>
    /// <param name="SamCompatible">
    ///   User or Group (according to UserType) to grant.
    /// </param>
    /// <returns>
    ///   The newly created Associated User.
    /// </returns>
    /// <seealso cref="IAssociatedUserAccount">
    ///   Associated User interface.
    /// </seealso>
    function Add(UserType: UserType; const SamCompatible: WideString): IAssociatedUserAccount; safecall;
    /// <summary>
    ///   Deletes a Associated User from the list.
    /// </summary>
    /// <param name="UserType">
    ///   Indicates type of User that SamCompatible defines
    ///   (UserType enum: User or Group).
    /// </param>
    /// <param name="SamCompatible">
    ///   The User to be deleted.
    /// </param>
    function Delete(UserType: UserType; const SamCompatible: WideString): WordBool; safecall;
    /// <summary>
    ///   Removes the Associated User.
    /// </summary>
    function Remove(const User: IAssociatedUserAccount): WordBool; safecall;
    /// <summary>
    ///   Returns the Associated Users count.
    /// </summary>
    property Count: Integer read Get_Count;
    /// <summary>
    ///   Returns a Associated User from the list by it's index.
    /// </summary>
    /// <seealso cref="IAssociatedUserAccount">
    ///   Associated User interface.
    /// </seealso>
    property Item[index: Integer]: IAssociatedUserAccount read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  IAssociatedUserAccountsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A230AD4D-104A-4444-ADBD-259D5243A485}
// *********************************************************************//
  IAssociatedUserAccountsDisp = dispinterface
    ['{A230AD4D-104A-4444-ADBD-259D5243A485}']
    property Count: Integer readonly dispid 201;
    property Item[index: Integer]: IAssociatedUserAccount readonly dispid 202;
    function Add(UserType: UserType; const SamCompatible: WideString): IAssociatedUserAccount; dispid 203;
    function Delete(UserType: UserType; const SamCompatible: WideString): WordBool; dispid 204;
    function Remove(const User: IAssociatedUserAccount): WordBool; dispid 205;
  end;

// *********************************************************************//
// The Class CoServer_ provides a Create and CreateRemote method to
// create instances of the default interface IServer exposed by
// the CoClass Server. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoServer_ = class
    class function Create: IServer;
    class function CreateRemote(const MachineName: string): IServer;
  end;

// *********************************************************************//
// The Class CoLicense provides a Create and CreateRemote method to
// create instances of the default interface ILicense exposed by
// the CoClass License. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoLicense = class
    class function Create: ILicense;
    class function CreateRemote(const MachineName: string): ILicense;
  end;

// *********************************************************************//
// The Class CoProfile provides a Create and CreateRemote method to
// create instances of the default interface IProfile exposed by
// the CoClass Profile. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoProfile = class
    class function Create: IProfile;
    class function CreateRemote(const MachineName: string): IProfile;
  end;

// *********************************************************************//
// The Class CoProfiles provides a Create and CreateRemote method to
// create instances of the default interface IProfiles exposed by
// the CoClass Profiles. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoProfiles = class
    class function Create: IProfiles;
    class function CreateRemote(const MachineName: string): IProfiles;
  end;

// *********************************************************************//
// The Class CoBinding provides a Create and CreateRemote method to
// create instances of the default interface IBinding exposed by
// the CoClass Binding. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoBinding = class
    class function Create: IBinding;
    class function CreateRemote(const MachineName: string): IBinding;
  end;

// *********************************************************************//
// The Class CoCertificate provides a Create and CreateRemote method to
// create instances of the default interface ICertificate exposed by
// the CoClass Certificate. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCertificate = class
    class function Create: ICertificate;
    class function CreateRemote(const MachineName: string): ICertificate;
  end;

// *********************************************************************//
// The Class CoRDS provides a Create and CreateRemote method to
// create instances of the default interface IRDS exposed by
// the CoClass RDS. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoRDS = class
    class function Create: IRDS;
    class function CreateRemote(const MachineName: string): IRDS;
  end;

// *********************************************************************//
// The Class CoRDSAccounts provides a Create and CreateRemote method to
// create instances of the default interface IRDSAccounts exposed by
// the CoClass RDSAccounts. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoRDSAccounts = class
    class function Create: IRDSAccounts;
    class function CreateRemote(const MachineName: string): IRDSAccounts;
  end;

// *********************************************************************//
// The Class CoGateways provides a Create and CreateRemote method to
// create instances of the default interface IGateways exposed by
// the CoClass Gateways. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoGateways = class
    class function Create: IGateways;
    class function CreateRemote(const MachineName: string): IGateways;
  end;

// *********************************************************************//
// The Class CoUser provides a Create and CreateRemote method to
// create instances of the default interface IUser exposed by
// the CoClass User. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoUser = class
    class function Create: IUser;
    class function CreateRemote(const MachineName: string): IUser;
  end;

// *********************************************************************//
// The Class CoUsers provides a Create and CreateRemote method to
// create instances of the default interface IUsers exposed by
// the CoClass Users. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoUsers = class
    class function Create: IUsers;
    class function CreateRemote(const MachineName: string): IUsers;
  end;

// *********************************************************************//
// The Class CoAuthentication provides a Create and CreateRemote method to
// create instances of the default interface IAuthentication exposed by
// the CoClass Authentication. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAuthentication = class
    class function Create: IAuthentication;
    class function CreateRemote(const MachineName: string): IAuthentication;
  end;

// *********************************************************************//
// The Class CoSSOUser provides a Create and CreateRemote method to
// create instances of the default interface ISSOUser exposed by
// the CoClass SSOUser. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSSOUser = class
    class function Create: ISSOUser;
    class function CreateRemote(const MachineName: string): ISSOUser;
  end;

// *********************************************************************//
// The Class CoSSOUsers provides a Create and CreateRemote method to
// create instances of the default interface ISSOUsers exposed by
// the CoClass SSOUsers. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoSSOUsers = class
    class function Create: ISSOUsers;
    class function CreateRemote(const MachineName: string): ISSOUsers;
  end;

// *********************************************************************//
// The Class CoAssociatedUserAccount provides a Create and CreateRemote method to
// create instances of the default interface IAssociatedUserAccount exposed by
// the CoClass AssociatedUserAccount. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAssociatedUserAccount = class
    class function Create: IAssociatedUserAccount;
    class function CreateRemote(const MachineName: string): IAssociatedUserAccount;
  end;

// *********************************************************************//
// The Class CoAssociatedUserAccounts provides a Create and CreateRemote method to
// create instances of the default interface IAssociatedUserAccounts exposed by
// the CoClass AssociatedUserAccounts. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoAssociatedUserAccounts = class
    class function Create: IAssociatedUserAccounts;
    class function CreateRemote(const MachineName: string): IAssociatedUserAccounts;
  end;

  /// <summary>
  ///   Main class. Contains methods and properties to manage all Server
  ///   configuration.
  /// </summary>
  TServer = class(TInterfacedObject, IServer)
  private
    FServer: IServer;
  protected
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;

    function Get_Binding: IBinding; safecall;
    function Get_Certificate: ICertificate; safecall;
    function Get_RDSAccounts: IRDSAccounts; safecall;
    function Get_Profiles: IProfiles; safecall;
    function Get_License: ILicense; safecall;
    function Get_Gateways: IGateways; safecall;
    function Get_NetworkID: WideString; safecall;
    procedure Set_NetworkID(const Value: WideString); safecall;
    function Get_Authentication: IAuthentication; safecall;
  public
    constructor Create;
    destructor Destroy; override;

    /// <summary>
    ///   Returns the Server's Binding configuration.
    /// </summary>
    /// <seealso cref="IBinding interface" />
    property Binding: IBinding read Get_Binding;
    /// <summary>
    /// \Returns the Server's certificate configuration for SSL
    /// protocol.
    /// </summary>
    /// <seealso cref="ICertificate interface"/>               
    property Certificate: ICertificate read Get_Certificate;
    /// <summary>
    /// \Returns the list of Remote Desktop Services accounts.
    /// </summary>
    /// <seealso cref="IRDSAccounts interface"/>
    property RDSAccounts: IRDSAccounts read Get_RDSAccounts;
    /// <summary>
    /// \Returns the profiles list.
    /// </summary>
    /// <seealso cref="IProfiles interface"/>
    property Profiles: IProfiles read Get_Profiles;
    /// <summary>
    /// \Returns the current Server's licence.
    /// </summary>
    /// <seealso cref="ILicense interface"/>  
    property License: ILicense read Get_License;
    /// <summary>
    /// \Returns the current Server's gateways.
    /// </summary>
    /// <seealso cref="IGateway interface"/>
    property Gateways: IGateways read Get_Gateways;
    /// <summary>
    /// Global Network ID. All the Gateway and Server installations involved
    /// in a Load Balancing architecture share the same network ID.
    /// </summary>
    property NetworkID: WideString read Get_NetworkID write Set_NetworkID;
    /// <summary>
    ///   Returns the Authentication settings
    /// </summary>
    /// <seealso cref="IAuthentication"/>
    ///   Authentication interface
    /// </seealso>
    property Authentication: IAuthentication read Get_Authentication;

    /// <summary>
    /// Loads all the configuration entries and profiles from file.
    /// It is automatically called by constructor.
    /// </summary>
    procedure Load; safecall;
    /// <summary>
    /// Saves the entire configuration parameters and profiles.
    /// </summary>
    procedure Save; safecall;
    /// <summary>
    /// Hides a configuration section in the VirtualUI Server Manager
    /// GUI.
    /// </summary>
    /// <param name="section">The Server configuration section to
    ///                       hide to user. Use one of the following
    ///                       constants\:
    ///                       * SRVSEC_GENERAL\: Hides the General
    ///                         tab, that contains the Binding
    ///                         configuration.
    ///                       * SRVSEC_RDS\: Hides the tab with the
    ///                         Remote Desktop Services account
    ///                         configuration.
    ///                       * SRVSEC_APPLICATIONS\: Hides the list
    ///                         of applications.
    ///                       * SRVSEC_LICENSES\: Hides the tab with
    ///                         License information.</param>         
    procedure HideSection(section: ServerSection); safecall;
    /// <summary>
    /// Makes visible a configuration section in the VirtualUI Server
    /// Manager GUI.
    /// </summary>
    /// <param name="section">The Server configuration section to
    ///                       show to user. Use one of the following
    ///                       constants\:
    ///                       * SRVSEC_GENERAL\: Shows the General
    ///                         tab, that contains the Binding
    ///                         configuration.
    ///                       * SRVSEC_RDS\: Shows the tab with the
    ///                         Remote Desktop Services account
    ///                         configuration.
    ///                       * SRVSEC_APPLICATIONS\: Shows the list
    ///                         of applications.
    ///                       * SRVSEC_LICENSES\: Shows the tab with
    ///                         License information.</param>         
    procedure ShowSection(section: ServerSection); safecall;
  end;

/// <summary>
/// \Returns a global Server object. You can use this function to
/// manage all Server configuration, or create your own instance
/// of TServer. 
/// </summary>                                                   
function Server: TServer;

/// <summary>
///   Returns the path where Thinfinity.VirtualUI.Settings.dll is located.
/// </summary>
function GetDllDir:string;

/// <summary>
/// Runs an application in elevated mode. This mode is required
/// to save the Server's configuration in protected files.
/// </summary>
/// <param name="filename">Full path of application to execute.
///                        </param>
/// <param name="Parameters">\Arguments. </param>
/// <example>
/// In the main program of the application using this classes,
/// you can include: <c> if ParamCount=0 then
/// RunAsAdmin(ParamStr(0), '/some_param') else begin
/// Application.Initialize; [...] </c> 
/// </example>
function RunAsAdmin(filename: string; Parameters: string): Boolean;

// Versions prior to D2009 don't include PNG classes. You can use
// third party alternatives to do the convertion routines PNG-BASE64.
{$IFDEF DELPHI2009_PLUS}
/// <summary>
///   Converts the IProfile.IconData (base64 string) to a PNG image.
/// </summary>
/// <param name="data">
///   The image encoded in base64.
/// </param>
{$IFDEF FMX}
function Base64ToIcon(AData: String): TBitmap;
{$ELSE}
function Base64ToIcon(AData: String): TPngImage;
{$ENDIF}

/// <summary>
///   Converts a PNG image to be stored in IProfile.IconData (as base64 string).
/// </summary>
/// <param name="png">
///   The image to be encoded in base64.
/// </param>
{$IFDEF FMX}
function IconToBase64(png: TBitmap): string;
{$ELSE}
function IconToBase64(png: TPngImage): string;
{$ENDIF}
{$ENDIF}

implementation

uses ComObj;

class function CoServer_.Create: IServer;
begin
  Result := CreateComObject(CLASS_Server_) as IServer;
end;

class function CoServer_.CreateRemote(const MachineName: string): IServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Server_) as IServer;
end;

class function CoLicense.Create: ILicense;
begin
  Result := CreateComObject(CLASS_License) as ILicense;
end;

class function CoLicense.CreateRemote(const MachineName: string): ILicense;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_License) as ILicense;
end;

class function CoProfile.Create: IProfile;
begin
  Result := CreateComObject(CLASS_Profile) as IProfile;
end;

class function CoProfile.CreateRemote(const MachineName: string): IProfile;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Profile) as IProfile;
end;

class function CoProfiles.Create: IProfiles;
begin
  Result := CreateComObject(CLASS_Profiles) as IProfiles;
end;

class function CoProfiles.CreateRemote(const MachineName: string): IProfiles;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Profiles) as IProfiles;
end;

class function CoBinding.Create: IBinding;
begin
  Result := CreateComObject(CLASS_Binding) as IBinding;
end;

class function CoBinding.CreateRemote(const MachineName: string): IBinding;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Binding) as IBinding;
end;

class function CoCertificate.Create: ICertificate;
begin
  Result := CreateComObject(CLASS_Certificate) as ICertificate;
end;

class function CoCertificate.CreateRemote(const MachineName: string): ICertificate;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Certificate) as ICertificate;
end;

class function CoRDS.Create: IRDS;
begin
  Result := CreateComObject(CLASS_RDS) as IRDS;
end;

class function CoRDS.CreateRemote(const MachineName: string): IRDS;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDS) as IRDS;
end;

class function CoRDSAccounts.Create: IRDSAccounts;
begin
  Result := CreateComObject(CLASS_RDSAccounts) as IRDSAccounts;
end;

class function CoRDSAccounts.CreateRemote(const MachineName: string): IRDSAccounts;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RDSAccounts) as IRDSAccounts;
end;

class function CoGateways.Create: IGateways;
begin
  Result := CreateComObject(CLASS_Gateways) as IGateways;
end;

class function CoGateways.CreateRemote(const MachineName: string): IGateways;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Gateways) as IGateways;
end;

class function CoUser.Create: IUser;
begin
  Result := CreateComObject(CLASS_User) as IUser;
end;

class function CoUser.CreateRemote(const MachineName: string): IUser;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_User) as IUser;
end;

class function CoUsers.Create: IUsers;
begin
  Result := CreateComObject(CLASS_Users) as IUsers;
end;

class function CoUsers.CreateRemote(const MachineName: string): IUsers;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Users) as IUsers;
end;

class function CoAuthentication.Create: IAuthentication;
begin
  Result := CreateComObject(CLASS_Authentication) as IAuthentication;
end;

class function CoAuthentication.CreateRemote(const MachineName: string): IAuthentication;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Authentication) as IAuthentication;
end;

class function CoSSOUser.Create: ISSOUser;
begin
  Result := CreateComObject(CLASS_SSOUser) as ISSOUser;
end;

class function CoSSOUser.CreateRemote(const MachineName: string): ISSOUser;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SSOUser) as ISSOUser;
end;

class function CoSSOUsers.Create: ISSOUsers;
begin
  Result := CreateComObject(CLASS_SSOUsers) as ISSOUsers;
end;

class function CoSSOUsers.CreateRemote(const MachineName: string): ISSOUsers;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SSOUsers) as ISSOUsers;
end;

class function CoAssociatedUserAccount.Create: IAssociatedUserAccount;
begin
  Result := CreateComObject(CLASS_AssociatedUserAccount) as IAssociatedUserAccount;
end;

class function CoAssociatedUserAccount.CreateRemote(const MachineName: string): IAssociatedUserAccount;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AssociatedUserAccount) as IAssociatedUserAccount;
end;

class function CoAssociatedUserAccounts.Create: IAssociatedUserAccounts;
begin
  Result := CreateComObject(CLASS_AssociatedUserAccounts) as IAssociatedUserAccounts;
end;

class function CoAssociatedUserAccounts.CreateRemote(const MachineName: string): IAssociatedUserAccounts;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AssociatedUserAccounts) as IAssociatedUserAccounts;
end;

var
  gServer: TServer;
  LibHandle: THandle;
  DllGetInstance: function(var Value: IServer):HResult; stdcall;

function GetDllDir: string;
var
  oem: string;
  reg: TRegistry;
  ini: TIniFile;
  k32, k64: string;
begin
  Result := '';
  k32 := '';
  k64 := '';
  oem := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) + 'OEM.ini';
  if FileExists(oem{$IFDEF DELPHIXE_PLUS}, False{$ENDIF}) then
  begin
    ini := TIniFile.Create(oem);
    try
      k32 := Trim(ini.ReadString('PATHS', 'Key32', ''));
      k64 := Trim(ini.ReadString('PATHS', 'Key64', ''));
    finally
      ini.Free;
    end;
  end;
  if k32 = '' then k32 := '\SOFTWARE\Wow6432Node\Cybele Software\Setups\Thinfinity\VirtualUI';
  if k64 = '' then k64 := '\SOFTWARE\Cybele Software\Setups\Thinfinity\VirtualUI';
  reg := TRegistry.Create(KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS);
  try
    reg.RootKey:=HKEY_LOCAL_MACHINE;
    if reg.OpenKeyReadOnly(k32) or reg.OpenKeyReadOnly(k64) then
    begin
      {$IFDEF WIN32}
      if Reg.ValueExists('TargetDir_x86') then
        Result := IncludeTrailingPathDelimiter(reg.ReadString('TargetDir_x86'));
      {$ELSE}
      if Reg.ValueExists('TargetDir_x64') then
        Result := IncludeTrailingPathDelimiter(reg.ReadString('TargetDir_x64'));
      {$ENDIF}
    end
    else Result := ExtractFilePath(ParamStr(0));
  finally
    reg.Free;
  end;
end;

procedure LoadLib;
var
  Filename: string;
begin
 if LibHandle = 0 then
  begin
    Filename := 'Thinfinity.VirtualUI.Settings.dll';
    LibHandle := LoadLibrary(PChar(GetDllDir + Filename));
    if LibHandle = 0 then Exit;
    try
      @DllGetInstance := GetProcAddress(LibHandle, 'DllGetInstance');
      if @DllGetInstance = nil then RaiseLastOSError;
    except
      FreeLibrary(LibHandle);
      LibHandle := 0;
      raise;
    end;
  end;
end;

function Server: TServer;
begin
  if not Assigned(gServer) then
    gServer := TServer.Create;
  Result := gServer;
end;

function RunAsAdmin(filename: string; Parameters: string): Boolean;
var
  sei: TShellExecuteInfo;
begin
  ZeroMemory(@sei, SizeOf(sei));
  sei.cbSize := SizeOf(TShellExecuteInfo);
  sei.Wnd := GetDesktopWindow();
  sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
  sei.lpVerb := PChar('runas');
  sei.lpFile := PChar(Filename);
  if parameters <> '' then
    sei.lpParameters := PChar(parameters);
  sei.nShow := SW_SHOWNORMAL;
  Result := ShellExecuteEx(@sei);
end;

const
  PNG_DATA_HEADER = 'data:image/png;base64,';

{$IFDEF DELPHI2009_PLUS} 
{$IFDEF FMX}
function Base64ToIcon(AData: String): TBitmap;
{$ELSE}
function Base64ToIcon(AData: String): TPngImage;
{$ENDIF}
var
  Input: TStringStream;
  Output: TBytesStream;
begin
  {$IFDEF FMX}
  Result := TBitmap.Create(0,0);
  {$ELSE}
  Result := TPngImage.Create;
  {$ENDIF}
  if AData = '' then
    Result.Assign(nil)
  else begin
    if SameText(copy(AData,1,length(PNG_DATA_HEADER)), PNG_DATA_HEADER) then
      Delete(AData,1,length(PNG_DATA_HEADER));
    Input := TStringStream.Create(AData, TEncoding.ASCII);
    Output := TBytesStream.Create;
    try
      DecodeStream(Input, Output);
      Output.Position := 0;
      Result.LoadFromStream(Output);
    finally
      Input.Free;
      Output.Free;
    end;
  end;
end;

{$IFDEF FMX}
function IconToBase64(png: TBitmap): string;
{$ELSE}
function IconToBase64(png: TPngImage): string;
{$ENDIF}
var
  Input: TBytesStream;
  Output: TStringStream;
begin
  Result := '';
  Input := TBytesStream.Create;
  try
    png.SaveToStream(Input);
    Input.Position := 0;
    Output := TStringStream.Create('', TEncoding.ASCII);
    try
      EncodeStream(Input, Output);
      Result := Output.DataString;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;
{$ENDIF}

{ TServer }

constructor TServer.Create;
begin
  inherited;
  if Assigned(DllGetInstance) then
  begin
    DllGetInstance(FServer);
  end;
end;

destructor TServer.Destroy;
begin
  if gServer = Self then
    gServer := nil;
  inherited;
end;

function TServer.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  if Assigned(FServer) then
    Result := FServer.GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs)
  else
    Result := E_NOTIMPL;
end;

function TServer.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  if Assigned(FServer) then
    Result := FServer.GetTypeInfo(Index, LocaleID, TypeInfo)
  else begin
    Result := E_NOTIMPL;
    Pointer(TypeInfo) := nil;
  end;
end;

function TServer.GetTypeInfoCount(out Count: Integer): HResult;
begin
  if Assigned(FServer) then
    Result := FServer.GetTypeInfoCount(Count)
  else begin
    Result := 0;
    Count := 0;
  end;
end;

function TServer.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  if Assigned(FServer) then
    Result := FServer.Invoke(DispID, IID, LocaleID, Flags, Params, VarResult, ExcepInfo, ArgErr)
  else
    Result := E_NOTIMPL;
end;

function TServer.Get_Authentication: IAuthentication;
begin
  Result := FServer.Authentication;
end;

function TServer.Get_Binding: IBinding;
begin
  Result := FServer.Binding;
end;

function TServer.Get_Certificate: ICertificate;
begin
  Result := FServer.Certificate;
end;

function TServer.Get_Gateways: IGateways;
begin
  Result := FServer.Gateways;
end;

function TServer.Get_License: ILicense;
begin
  Result := FServer.License;
end;

function TServer.Get_NetworkID: WideString;
begin
  Result := FServer.NetworkID;
end;

procedure TServer.Set_NetworkID(const Value: WideString);
begin
  FServer.NetworkID := Value;
end;

function TServer.Get_Profiles: IProfiles;
begin
  Result := FServer.Profiles;
end;

function TServer.Get_RDSAccounts: IRDSAccounts;
begin
  Result := FServer.RDSAccounts;
end;

procedure TServer.Load;
begin
  if Assigned(FServer) then
    FServer.Load;
end;

procedure TServer.Save;
begin
  if Assigned(FServer) then
    FServer.Save;
end;

procedure TServer.HideSection(section: ServerSection);
begin
  if Assigned(FServer) then
    FServer.HideSection(section);
end;

procedure TServer.ShowSection(section: ServerSection);
begin
  if Assigned(FServer) then
    FServer.ShowSection(section);
end;

initialization
  LoadLib;
finalization
  FreeAndNil(gServer);
end.
