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
  IArchetypeController,
  GenerateSolutionUseCase;

  type
  TArchetypeController = class(TInterfacedObject, IArchetypeControllerSpecification)
  private
    FUseCase: IGenerateSolutionUseCase;
  public
    constructor Create(const AUseCase: IGenerateSolutionUseCase);
    function GenerateSolution: string;
  end;

implementation

uses
  GenerateSolutionService;


constructor TArchetypeController.Create(const AUseCase: IGenerateSolutionUseCase);
begin
  inherited Create;
  FUseCase := AUseCase;
end;

function TArchetypeController.GenerateSolution: string;
begin
  Result := FUseCase.Execute;
end;

end.