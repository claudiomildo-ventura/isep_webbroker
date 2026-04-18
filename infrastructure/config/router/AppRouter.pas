unit AppRouter;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.JSON,
  Web.HTTPApp,
  ArchetypeControllerPort,
  HttpResponse;

type
  TAppRouter = class
  private
    FController: IArchetypeController;

    function NormalizePath(const APath: string): string;
    function JsonError(const AMessage: string): TJSONObject;
    function JsonMethodNotAllowed(const AAllowedMethod: string): TJSONObject;

  public
    constructor Create(const AController: IArchetypeController);

    function Redirect(Request: TWebRequest): THttpResponse;
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

function TAppRouter.JsonError(const AMessage: string): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('error', AMessage);
end;

function TAppRouter.JsonMethodNotAllowed(const AAllowedMethod: string): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('error', 'method not allowed');
  Result.AddPair('allowed', AAllowedMethod);
end;

function TAppRouter.Redirect(Request: TWebRequest): THttpResponse;
var
  Path: string;
begin
  Result := THttpResponse.Create;
  Result.ContentType := 'application/json; charset=utf-8';
  Result.StatusCode := 200;

  Path := NormalizePath(Request.PathInfo);

  if SameText(Path, '/generate') then
  begin
    if not SameText(Request.Method, 'GET') then
    begin
      Result.StatusCode := 405;
      Result.Body := JsonMethodNotAllowed('GET');
      Exit;
    end;

    Result.Body := FController.GenerateSolution;
    Exit;
  end;

  Result.StatusCode := 404;
  Result.Body := JsonError('route not found');
end;

end.
