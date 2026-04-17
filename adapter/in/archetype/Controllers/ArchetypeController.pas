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
    function GenerateSolution: string;
  end;

implementation

constructor TArchetypeController.Create(const AService: IArchetypeService);
begin
  inherited Create;
  FService := AService;
end;

function TArchetypeController.GenerateSolution: string;
var
  ArchetypeEntity: TArchetype;
  JsonObj: TJSONObject;
begin
  ArchetypeEntity := FService.Execute;
  JsonObj := TJSONObject.Create;
  try
    JsonObj.AddPair('name', ArchetypeEntity.Name);
    JsonObj.AddPair('autoCreated', TJSONBool.Create(ArchetypeEntity.AutoCreated));
    JsonObj.AddPair('architecture', TJSONNumber.Create(ArchetypeEntity.Architecture));
    JsonObj.AddPair('databasePlatform', TJSONNumber.Create(ArchetypeEntity.DatabasePlatform));
    JsonObj.AddPair('databaseEngineer', TJSONNumber.Create(ArchetypeEntity.DatabaseEngineer));
    JsonObj.AddPair('engineeringPlatform', TJSONNumber.Create(ArchetypeEntity.EngineeringPlatform));
    JsonObj.AddPair('template', TJSONNumber.Create(ArchetypeEntity.Template));
    JsonObj.AddPair('projectTemplate', TJSONNumber.Create(ArchetypeEntity.ProjectTemplate));
    Result := JsonObj.ToJSON;
  finally
    JsonObj.Free;
    ArchetypeEntity.Free;
  end;
end;

end.