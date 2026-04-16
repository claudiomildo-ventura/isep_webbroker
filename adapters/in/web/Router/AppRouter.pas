unit AppRouter;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.JSON,
  Web.HTTPApp;

type
  TAppRouter = class
  private
    function NormalizePath(const APath: string): string;
    function JsonError(const AMessage: string): string;
    function JsonMethodNotAllowed(const AAllowedMethod: string): string;
  public
    function Route(
      Request: TWebRequest;
      out StatusCode: Integer;
      out ContentType: string
    ): string;
  end;

implementation

uses
  ArchetypeController;

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

function TAppRouter.Route(
  Request: TWebRequest;
  out StatusCode: Integer;
  out ContentType: string
): string;
var
  Controller: TArchetypeController;
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

    Controller := TArchetypeController.Create;
    try
      Result := Controller.GenerateSolution;
    finally
      Controller.Free;
    end;

    Exit;
  end;

  StatusCode := 404;
  Result := JsonError('route not found');
end;

end.

