// -----------------------------------------------------------------------------
// ArchetypeController.pas
//
// This unit defines TArchetypeController, which acts as a controller for
// handling web requests in the WebBroker application. It delegates work to
// the application use case layer.
//
// Configuration:
// - Used by AppRouter to handle the /generate route.
// - Delegates business logic to TIArchetypeService.
// - Returns solution data as a string response.
// -----------------------------------------------------------------------------
unit ArchetypeController;

interface

uses
  System.JSON,
  Archetype,
  ArchetypeControllerPort,
  ArchetypeServicePort;

  type
  TArchetypeController = class(TInterfacedObject, IArchetypeController)
  private
    { Private declarations }
    FService: IArchetypeService;
  public
    { Public declarations }
    constructor Create(const AService: IArchetypeService);
    function GenerateSolution: TJSONObject;
  end;

implementation

constructor TArchetypeController.Create(const AService: IArchetypeService);
begin
  inherited Create;
  FService := AService;
end;

function TArchetypeController.GenerateSolution: TJSONObject;
var
  ArchetypeEntity: TArchetype;
begin
  ArchetypeEntity := FService.Execute;
  try
    Result := TJSONObject.Create;

    Result.AddPair('name', ArchetypeEntity.Name);
    Result.AddPair('autoCreated', TJSONBool.Create(ArchetypeEntity.AutoCreated));
    Result.AddPair('architecture', TJSONNumber.Create(ArchetypeEntity.Architecture));
    Result.AddPair('databasePlatform', TJSONNumber.Create(ArchetypeEntity.DatabasePlatform));
    Result.AddPair('databaseEngineer', TJSONNumber.Create(ArchetypeEntity.DatabaseEngineer));
    Result.AddPair('engineeringPlatform', TJSONNumber.Create(ArchetypeEntity.EngineeringPlatform));
    Result.AddPair('template', TJSONNumber.Create(ArchetypeEntity.Template));
    Result.AddPair('projectTemplate', TJSONNumber.Create(ArchetypeEntity.ProjectTemplate));

  finally
    ArchetypeEntity.Free;
  end;
end;

end.