unit ArchetypeService;

interface

uses
  System.SysUtils, System.Classes, ArchetypeServicePort, Archetype;

type
  TArchetypeService = class(TInterfacedObject, IArchetypeService)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    function Execute: TArchetype;
  end;

implementation

function TArchetypeService.Execute: TArchetype;
begin
  Result := TArchetype.Create('ISEP | Integrated Software Engineering Platform - WebBroker');
end;

end.