// -----------------------------------------------------------------------------
// WebModule1.pas
//
// This unit defines TWebModule1, the main web module for handling HTTP requests
// in the WebBroker application. It acts as the entry point for web requests,
// dispatching them to controllers such as TArchetypeController.
//
// Configuration:
// - Instantiated and managed by the application at startup.
// - Handles routing and processing of incoming HTTP requests.
// - Delegates business logic to controllers.
// -----------------------------------------------------------------------------
unit WebModule1;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker,
  Datasnap.DSServer,
  Web.WebFileDispatcher,
  Web.HTTPProd,
  Datasnap.DSAuth,
  Datasnap.DSProxyJavaScript,
  IPPeerServer,
  Datasnap.DSMetadata,
  Datasnap.DSServerMetadata,
  Datasnap.DSClientMetadata,
  Datasnap.DSCommonServer,
  Datasnap.DSHTTP;

type
  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    procedure WebModuleDefaultAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule;

implementation

{$R *.dfm}

uses ArchetypeController, ServerContainer, Web.WebReq;

procedure TWebModule1.WebModuleDefaultAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  Controller: TArchetypeController;
begin
  Controller := TArchetypeController.Create(nil);
  try
    Response.Content := Controller.GenerateSolution;
    Handled := True;
  finally
    Controller.Free;
  end;
end;

end.
