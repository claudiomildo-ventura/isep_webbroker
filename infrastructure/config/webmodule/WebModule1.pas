unit WebModule1;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
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
    function JsonInternalServerError(const AMessage: string): string;
  public
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{$R *.dfm}

uses
  AppRouter,
  Web.WebReq,
  GenerateSolutionService;

function TWebModule1.JsonInternalServerError(const AMessage: string): string;
var
  JsonObj: TJSONObject;
begin
  JsonObj := TJSONObject.Create;
  try
    JsonObj.AddPair('error', 'internal server error');
    JsonObj.AddPair('message', AMessage);
    Result := JsonObj.ToJSON;
  finally
    JsonObj.Free;
  end;
end;

procedure TWebModule1.WebModuleDefaultAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  Router: TAppRouter;
  UseCase: TGenerateSolutionService;
  StatusCode: Integer;
  ContentType: string;
begin
  UseCase := TGenerateSolutionService.Create;
  Router := TAppRouter.Create(UseCase);
  try
    try
      Response.Content := Router.Route(Request, StatusCode, ContentType);
      Response.StatusCode := StatusCode;
      Response.ContentType := ContentType;

      if StatusCode = 405 then
        Response.SetCustomHeader('Allow', 'GET');

    except
      on E: Exception do
      begin
        Response.StatusCode := 500;
        Response.ContentType := 'application/json; charset=utf-8';
        Response.Content := JsonInternalServerError(E.Message);
      end;
    end;

    Handled := True;
  finally
    Router.Free;
  end;
end;

end.