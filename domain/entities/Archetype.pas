unit Archetype;

interface

uses
  System.Generics.Collections;

type
  TArchetypeSolutionTableDto = class
  end;

  TArchetype = class
  private
    { Private declarations }
    FName: string;
    FAutoCreated: Boolean;
    FArchitecture: Int64;
    FDatabasePlatform: Int64;
    FDatabaseEngineer: Int64;
    FEngineeringPlatform: Int64;
    FTemplate: Int64;
    FProjectTemplate: Int64;
    //FTables: TObjectList<TArchetypeSolutionTableDto>;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(const AName: string);
    destructor Destroy; override;
    property AutoCreated: Boolean read FAutoCreated write FAutoCreated;
    property Architecture: Int64 read FArchitecture write FArchitecture;
    property DatabasePlatform: Int64 read FDatabasePlatform write FDatabasePlatform;
    property DatabaseEngineer: Int64 read FDatabaseEngineer write FDatabaseEngineer;
    property EngineeringPlatform: Int64 read FEngineeringPlatform write FEngineeringPlatform;
    property Template: Int64 read FTemplate write FTemplate;
    property ProjectTemplate: Int64 read FProjectTemplate write FProjectTemplate;
    //property Tables: TObjectList<TArchetypeSolutionTableDto> read FTables;
    property Name: string read FName;
  end;

implementation

constructor TArchetype.Create(const AName: string);
begin
  inherited Create;
  FName := AName;
  //FTables := TObjectList<TArchetypeSolutionTableDto>.Create(True);
end;

destructor TArchetype.Destroy;
begin
  //FTables.Free;
  inherited Destroy;
end;

end.