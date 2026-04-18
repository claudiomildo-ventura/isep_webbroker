(**
 * Unit: ArchetypeService
 *
 * Domain service responsible for the solution-generation business logic.
 *
 * This service lives in the domain layer and contains the core application
 * logic for the /generate use case. It must remain free of any HTTP,
 * infrastructure, or framework concerns.
 *
 * Architecture position:
 *   TArchetypeController -> TArchetypeService
 *)
unit ArchetypeService;

{$mode objfpc}{$H+}

interface

type
  (** Domain service that handles the archetype solution-generation use case. *)
  TArchetypeService = class
  public
    (**
     * Executes the solution-generation logic and returns the result
     * as a serialized JSON string.
     *
     * @returns JSON string: {"message":"solution generated"}
     *)
    function GenerateSolution: string;
  end;

implementation

function TArchetypeService.GenerateSolution: string;
begin
  // Core business logic for the generate use case.
  // Extend this method to perform real domain operations.
  Result := '{"message":"solution generated"}';
end;

end.
