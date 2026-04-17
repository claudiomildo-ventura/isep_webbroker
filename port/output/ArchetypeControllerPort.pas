unit ArchetypeControllerPort;

interface

type
  /// <summary>
  /// Defines the contract for an Archetype Controller.
  /// This interface represents the "port" in a ports-and-adapters (hexagonal) architecture.
  /// Implementations of this interface are responsible for generating a solution
  /// based on a specific archetype or business logic.
  /// </summary>
  IArchetypeController = interface
    ['{A1B2C3D4-E5F6-47A8-9B0C-1D2E3F4A5B6C}']

    /// <summary>
    /// Generates and returns a solution as a string.
    /// The actual content and format of the solution depend on the implementation.
    /// </summary>
    /// <returns>
    /// A string representing the generated solution.
    /// </returns>
    function GenerateSolution: string;

  end;

implementation

end.
