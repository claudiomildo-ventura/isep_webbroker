(**
 * Unit: ArchetypeController
 *
 * Inbound HTTP controller for the /generate endpoint.
 *
 * This controller sits in the adapter/in layer and is responsible for
 * translating an HTTP request into a domain operation and returning
 * the result as a JSON string.
 *
 * It delegates business logic to the domain service layer and should
 * remain thin — no business rules belong here.
 *
 * Architecture position:
 *   WebModule -> AppRouter -> TArchetypeController -> TArchetypeService
 *)
unit ArchetypeController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  (** Controller for the /generate endpoint. All methods are stateless class functions. *)
  TArchetypeController = class
  public
    (**
     * Handles the GET /generate request.
     * Delegates to the domain service and returns a JSON payload.
     *
     * @returns JSON string: {"message":"solution generated"}
     *)
    class function GenerateSolution: string;
  end;

implementation

class function TArchetypeController.GenerateSolution: string;
begin
  // Delegate to the domain service layer.
  // In a full implementation, inject TArchetypeService via constructor DI.
  Result := '{"message":"solution generated"}';
end;

end.
