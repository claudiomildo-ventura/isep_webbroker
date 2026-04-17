unit AppRouter;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.JSON,
  Web.HTTPApp,
  ArchetypeControllerPort;

type
  TAppRouter = class
  private
    { Private declarations }
    FController: IArchetypeController;
    function NormalizePath(const APath: string): string;
    function JsonError(const AMessage: string): string;
    function JsonMethodNotAllowed(const AAllowedMethod: string): string;
  public
    { Public declarations }
    constructor Create(const AController: IArchetypeController);
    function Route(Request: TWebRequest; out StatusCode: Integer; out ContentType: string): string;
  end;

implementation

constructor TAppRouter.Create(const AController: IArchetypeController);
begin
  inherited Create;

  if not Assigned(AController) then
    raise Exception.Create('IArchetypeController not assigned');

  FController := AController;
end;

function TAppRouter.NormalizePath(const APath: string): string;
begin
  Result := Trim(APath);

  if Result = '' then
    Exit('/');

  if (Length(Result) > 1) and Result.EndsWith('/') then
    Result := Result.Substring(0, Result.Length - 1);
end;

function TAppRouter.JsonError(const AMessage: string): string;
var
  JsonObj: TJSONObject;
begin
  JsonObj := TJSONObject.Create;
  try
    JsonObj.AddPair('error', AMessage);
    Result := JsonObj.ToJSON;
  finally
    JsonObj.Free;
  end;
end;

function TAppRouter.JsonMethodNotAllowed(const AAllowedMethod: string): string;
var
  JsonObj: TJSONObject;
begin
  JsonObj := TJSONObject.Create;
  try
    JsonObj.AddPair('error', 'method not allowed');
    JsonObj.AddPair('allowed', AAllowedMethod);
    Result := JsonObj.ToJSON;
  finally
    JsonObj.Free;
  end;
end;

function TAppRouter.Route(Request: TWebRequest; out StatusCode: Integer; out ContentType: string): string;
var
  Path: string;
begin
  ContentType := 'application/json; charset=utf-8';
  StatusCode := 200;
  Path := NormalizePath(Request.PathInfo);

  if SameText(Path, '/generate') then
  begin
    if not SameText(Request.Method, 'GET') then
    begin
      StatusCode := 405;
      Exit(JsonMethodNotAllowed('GET'));
    end;

    Exit(FController.GenerateSolution);
  end;

  StatusCode := 404;
  Result := JsonError('route not found');
end;

end.