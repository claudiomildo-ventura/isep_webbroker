unit WebModule1;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Web.HTTPApp,
  Datasnap.DSHTTPWebBroker, IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP;

type
  /// <summary>
  /// Main WebModule responsible for handling HTTP requests.
  /// Acts as the entry point for routing requests to the application layer.
  /// </summary>
  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;

    /// <summary>
    /// Default request handler (acts as a front controller).
    /// </summary>
    procedure WebModuleDefaultAction(
      Sender: TObject;
      Request: TWebRequest;
      Response: TWebResponse;
      var Handled: Boolean
    );

  private
    /// <summary>
    /// Generates a standardized JSON error response.
    /// </summary>
    function JsonInternalServerError(const AMessage: string): string;

  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{$R *.dfm}

uses
  AppRouter,
  ArchetypeControllerPort,
  ArchetypeServicePort,
  ArchetypeController,
  ArchetypeService;

function TWebModule1.JsonInternalServerError(const AMessage: string): string;
var
  JsonObj: TJSONObject;
begin
  JsonObj := TJSONObject.Create;
  try
    JsonObj.AddPair('error', 'internal_server_error');
    JsonObj.AddPair('message', AMessage);
    Result := JsonObj.ToJSON;
  finally
    JsonObj.Free;
  end;
end;

procedure TWebModule1.WebModuleDefaultAction(
  Sender: TObject;
  Request: TWebRequest;
  Response: TWebResponse;
  var Handled: Boolean
);
var
  Router: TAppRouter;
  Service: IArchetypeService;
  Controller: IArchetypeController;
  StatusCode: Integer;
  ContentType: string;
begin
  Handled := True;

  try
    /// Dependency composition (manual DI)
    Service := TArchetypeService.Create;
    Controller := TArchetypeController.Create(Service);
    Router := TAppRouter.Create(Controller);

    try
      Response.Content := Router.Route(Request, StatusCode, ContentType);
      Response.StatusCode := StatusCode;
      Response.ContentType := ContentType;

      if StatusCode = 405 then
        Response.SetCustomHeader('Allow', 'GET');

    finally
      Router.Free;
    end;

  except
    on E: Exception do
    begin
      Response.StatusCode := 500;
      Response.ContentType := 'application/json; charset=utf-8';
      Response.Content := JsonInternalServerError(E.Message);
    end;
  end;
end;

end.
