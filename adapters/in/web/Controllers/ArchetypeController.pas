// -----------------------------------------------------------------------------
// ArchetypeController.pas
//
// This unit defines TArchetypeController, which acts as a controller for
// handling web requests in the WebBroker application. It delegates work to
// the application use case layer.
//
// Configuration:
// - Used by AppRouter to handle the /generate route.
// - Delegates business logic to IGenerateSolutionUseCase.
// - Returns solution data as a string response.
// -----------------------------------------------------------------------------
unit ArchetypeController;

interface

uses
  GenerateSolutionUseCase;

type
  TArchetypeController = class
  public
    function GenerateSolution: string;
  end;

implementation

uses
  GenerateSolutionService;

function TArchetypeController.GenerateSolution: string;
var
  UseCase: IGenerateSolutionUseCase;
begin
  UseCase := TGenerateSolutionService.Create;
  Result := UseCase.Execute;
end;

end.