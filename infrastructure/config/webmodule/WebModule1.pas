(**
 * Unit: WebModule1
 *
 * The main HTTP entry point for the fpWeb application.
 *
 * This module is registered with fpWeb as 'generate', meaning it handles
 * all requests to http://localhost:3003/generate.
 *
 * In fpWeb's routing model, the first path segment of the URL is used as
 * the module name. For /generate, fpWeb instantiates TWebModule1 and
 * dispatches the request to HandleRequest.
 *
 * Supported routes:
 *   GET  /generate  -> 200 {"message":"solution generated"}
 *   *    /generate  -> 405 Method Not Allowed
 *)
unit WebModule1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, httpdefs, fpHTTP, fpWeb,
  AppRouter, ArchetypeController, Logger;

type
  (** fpWeb web module that handles all HTTP requests for the /generate endpoint. *)
  TWebModule1 = class(TFPWebModule)
  private
    (** Handles incoming HTTP requests and writes the appropriate JSON response. *)
    procedure HandleRequest(Sender: TObject; ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
  public
    (** Constructor called by fpWeb when a new module instance is created. *)
    constructor CreateNew(AOwner: TComponent; Num: Integer); override;
  end;

var
  WebModule1Instance: TWebModule1;

implementation

constructor TWebModule1.CreateNew(AOwner: TComponent; Num: Integer);
begin
  inherited CreateNew(AOwner, Num);
  // Bind the request handler so fpWeb calls HandleRequest for every request
  OnRequest := @HandleRequest;
end;

procedure TWebModule1.HandleRequest(Sender: TObject; ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
begin
  // The module name 'generate' is consumed from the URL by fpWeb,
  // so PathInfo will be empty for GET /generate.
  // We only need to verify the HTTP method here.
  Handled := True;
  AResponse.ContentType := 'application/json; charset=utf-8';

  if SameText(ARequest.Method, 'GET') then
  begin
    AResponse.Code := 200;
    AResponse.Content := TArchetypeController.GenerateSolution;
  end
  else
  begin
    // Return 405 Method Not Allowed for any non-GET request
    AResponse.Code := 405;
    AResponse.Content := '{"error":"method not allowed","allowed":"GET"}';
  end;

  TLogger.Info('i.c.isep.WebModule1', Format('%s /generate -> %d', [ARequest.Method, AResponse.Code]));
end;

initialization
  // Register this module as 'generate' so fpWeb routes /generate requests here.
  // The third argument (True) marks it as the default module, used as fallback
  // when AllowDefaultModule is enabled on the application.
  RegisterHTTPModule('generate', TWebModule1, True);

end.
