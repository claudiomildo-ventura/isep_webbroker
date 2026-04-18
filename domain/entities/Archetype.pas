unit Archetype;

interface

uses
  System.Generics.Collections,
  ArchetypeSolutionTableDto;

type
  /// <summary>
  /// Represents an Archetype configuration used to generate a solution.
  /// Encapsulates architectural, database, and platform-related settings,
  /// along with associated table definitions.
  /// </summary>
  TArchetype = class(TObject)
  private
    FName: string;
    FAutoCreated: Boolean;
    FArchitecture: Int64;
    FDatabasePlatform: Int64;
    FDatabaseEngineer: Int64;
    FEngineeringPlatform: Int64;
    FTemplate: Int64;
    FProjectTemplate: Int64;
    FTables: TObjectList<TArchetypeSolutionTableDto>;
  public
    constructor Create(const AName: string);
    destructor Destroy; override;

    /// <summary>
    /// Indicates whether the archetype was automatically created.
    /// </summary>
    property AutoCreated: Boolean read FAutoCreated write FAutoCreated;

    /// <summary>
    /// Identifier of the architecture type.
    /// </summary>
    property Architecture: Int64 read FArchitecture write FArchitecture;

    /// <summary>
    /// Identifier of the database platform.
    /// </summary>
    property DatabasePlatform: Int64 read FDatabasePlatform write FDatabasePlatform;

    /// <summary>
    /// Identifier of the database engineering strategy.
    /// </summary>
    property DatabaseEngineer: Int64 read FDatabaseEngineer write FDatabaseEngineer;

    /// <summary>
    /// Identifier of the engineering platform.
    /// </summary>
    property EngineeringPlatform: Int64 read FEngineeringPlatform write FEngineeringPlatform;

    /// <summary>
    /// Identifier of the template used.
    /// </summary>
    property Template: Int64 read FTemplate write FTemplate;

    /// <summary>
    /// Identifier of the project template.
    /// </summary>
    property ProjectTemplate: Int64 read FProjectTemplate write FProjectTemplate;

    /// <summary>
    /// Collection of tables associated with this archetype.
    /// The list owns its items (automatically frees them).
    /// </summary>
    property Tables: TObjectList<TArchetypeSolutionTableDto> read FTables;

    /// <summary>
    /// Name of the archetype (read-only after construction).
    /// </summary>
    property Name: string read FName;
  end;

implementation

{ TArchetype }

constructor TArchetype.Create(const AName: string);
begin
  inherited Create;
  FName := AName;
  FTables := TObjectList<TArchetypeSolutionTableDto>.Create(True); // Owns objects
end;

destructor TArchetype.Destroy;
begin
  FTables.Free;
  inherited Destroy;
end;

end.
