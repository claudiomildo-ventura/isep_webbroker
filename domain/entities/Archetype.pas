unit Archetype;

interface

type
  TArchetype = class
  private
    { Private declarations }
    FName: string;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(const AName: string);
    property Name: string read FName;
  end;

implementation

constructor TArchetype.Create(const AName: string);
begin
  FName := AName;
end;

end.