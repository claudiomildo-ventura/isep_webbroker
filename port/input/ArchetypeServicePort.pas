unit ArchetypeServicePort;

interface

uses
  Archetype;

type
  /// <summary>
  /// Defines the contract for the Archetype Service.
  /// This interface acts as an application/service layer port in a
  /// ports-and-adapters (hexagonal) architecture.
  ///
  /// Implementations encapsulate the business use case responsible
  /// for producing or retrieving an Archetype instance.
  /// </summary>
  IArchetypeService = interface
    ['{A1B2C3D4-E5F6-47A8-9B0C-1234567890AB}']

    /// <summary>
    /// Executes the use case and returns an Archetype.
    /// </summary>
    /// <returns>
    /// A <c>TArchetype</c> instance resulting from the business logic execution.
    /// </returns>
    function Execute: TArchetype;

  end;

implementation

end.
