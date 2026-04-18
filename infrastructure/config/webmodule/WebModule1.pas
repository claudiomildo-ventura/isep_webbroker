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
  HttpResponse,
  ArchetypeControllerPort,
  ArchetypeServicePort,
  ArchetypeController,
  ArchetypeService;

function TWebModule1.JsonInternalServerError(const AMessage: string): string;
var
  J: TJSONObject;
begin
  J := TJSONObject.Create;
  try
    J.AddPair('error', 'internal_server_error');
    J.AddPair('message', AMessage);
    Result := J.ToJSON;
  finally
    J.Free;
  end;
end;

procedure TWebModule1.WebModuleDefaultAction(
  Sender: TObject;
  Request: TWebRequest;
  Response: TWebResponse;
  var Handled: Boolean
);
var
  Resp: THttpResponse;
  AppRouter: TAppRouter;
  ArchetypeService: IArchetypeService;
  ArchetypeController: IArchetypeController;
begin
  Handled := True;

  try
    /// Composition root (OK aqui)
    ArchetypeService := TArchetypeService.Create;
    ArchetypeController := TArchetypeController.Create(ArchetypeService);
    AppRouter := TAppRouter.Create(ArchetypeController);

    try
      Resp := AppRouter.Redirect(Request);
      try
        Response.StatusCode := Resp.StatusCode;
        Response.ContentType := Resp.ContentType;

        if Assigned(Resp.Body) then
          Response.Content := Resp.Body.ToJSON
        else
          Response.Content := '';

      finally
        Resp.Free;
      end;

    finally
      AppRouter.Free;
    end;

  except
    on E: Exception do
    begin
      Response.StatusCode := 500;
      Response.ContentType := 'application/json; charset=utf-8';
      Response.Content :=
        TJSONObject.Create
          .AddPair('error', 'internal_server_error')
          .AddPair('message', E.Message)
          .ToJSON;
    end;
  end;
end;

end.
