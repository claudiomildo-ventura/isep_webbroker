unit ArchetypeSolutionTableDto;

interface

type
  /// <summary>
  /// Data Transfer Object representing a table in an Archetype solution.
  /// Used to carry table metadata between layers (e.g., Service → Controller → API).
  /// </summary>
  TArchetypeSolutionTableDto = class
  private
    FName: string;
    FSchema: string;
    FHasPrimaryKey: Boolean;

  public
    /// <summary>
    /// Creates a new table DTO.
    /// </summary>
    constructor Create(
      const AName: string;
      const ASchema: string;
      AHasPrimaryKey: Boolean
    );

    /// <summary>
    /// Table name.
    /// </summary>
    property Name: string read FName write FName;

    /// <summary>
    /// Database schema (e.g., dbo, public).
    /// </summary>
    property Schema: string read FSchema write FSchema;

    /// <summary>
    /// Indicates whether the table has a primary key defined.
    /// </summary>
    property HasPrimaryKey: Boolean read FHasPrimaryKey write FHasPrimaryKey;
  end;

implementation

{ TArchetypeSolutionTableDto }

constructor TArchetypeSolutionTableDto.Create(
  const AName, ASchema: string;
  AHasPrimaryKey: Boolean
);
begin
  inherited Create;
  FName := AName;
  FSchema := ASchema;
  FHasPrimaryKey := AHasPrimaryKey;
end;

end.
