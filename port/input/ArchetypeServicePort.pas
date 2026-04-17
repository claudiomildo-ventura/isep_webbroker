unit ArchetypeServicePort;

interface

uses Archetype;

type
  IArchetypeService = interface ['{A1B2C3D4-E5F6-47A8-9B0C-1234567890AB}']
    function Execute: TArchetype;
  end;

implementation

end.