// -----------------------------------------------------------------------------
// ArchetypeController.pas
//
// This unit defines TArchetypeController, which acts as a controller for
// handling web requests in the WebBroker application. It is invoked by the
// WebModule to process requests and generate responses using the ArchetypeService.
//
// Configuration:
// - Used by WebModule.pas to handle HTTP requests.
// - Delegates business logic to ArchetypeService.
// - Returns solution data as a string response.
// -----------------------------------------------------------------------------
unit ArchetypeController;

interface

uses
  System.SysUtils, System.Classes, ArchetypeService, Archetype;

type
  TArchetypeController = class(TComponent)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    function GenerateSolution: string;
  end;

implementation

function TArchetypeController.GenerateSolution: string;
var
  Service: TArchetypeService;
  Archetype: TArchetype;
begin
  Service := TArchetypeService.Create;
  Archetype := Service.Execute;
  try
    Result := Archetype.Name;
  finally
    Archetype.Free;
  end;
end;

end.