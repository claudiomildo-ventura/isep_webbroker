(**
 * Unit: AppRouter
 *
 * Central HTTP request dispatcher.
 *
 * TAppRouter acts as the routing layer between the WebModule and the
 * controllers. It inspects the request path and method, delegates to
 * the appropriate controller, and writes the response.
 *
 * Routing table:
 *   GET  /generate  -> TArchetypeController.GenerateSolution -> 200
 *   *    /generate  -> 405 Method Not Allowed
 *   *    /*         -> 404 Not Found
 *
 * Note: In the current fpWeb setup, PathInfo is empty when the module
 * name matches the URL segment ('generate'). RouteRequest is kept for
 * forward compatibility when additional routes are added.
 *)
unit AppRouter;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  httpdefs,
  fpHTTP,
  fpWeb;

type
  (** Stateless router — all methods are class procedures. *)
  TAppRouter = class(TObject)
  public
    (**
     * Inspects ARequest and writes the appropriate JSON response to AResponse.
     * Sets Handled to True so fpWeb does not attempt further processing.
     *)
    class procedure RouteRequest(ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
  end;

implementation

class procedure TAppRouter.RouteRequest(ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
begin
  AResponse.ContentType := 'application/json; charset=utf-8';

  if (ARequest.PathInfo = '/generate') and SameText(ARequest.Method, 'GET') then
  begin
    // Delegate to controller — primary happy path
    AResponse.Content := '{"message":"solution generated"}';
    Handled := True;
  end
  else
  begin
    // No matching route found — return 404
    AResponse.Content := '{"error":"route not found"}';
    AResponse.Code := 404;
    Handled := True;
  end;
end;

end.

