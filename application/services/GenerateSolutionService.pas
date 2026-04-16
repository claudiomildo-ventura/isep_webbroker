unit GenerateSolutionService;

interface

uses
  GenerateSolutionUseCase;

type
  TGenerateSolutionService = class(TInterfacedObject, IGenerateSolutionUseCase)
  public
    function Execute: string;
  end;

implementation

function TGenerateSolutionService.Execute: string;
begin
  Result := '{"message":"solution generated"}';
end;

end.