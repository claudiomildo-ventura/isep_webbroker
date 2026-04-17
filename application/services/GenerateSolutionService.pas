unit GenerateSolutionService;

interface

uses
  GenerateSolutionUseCase;

type
  TGenerateSolutionService = class(TInterfacedObject, IGenerateSolutionUseCase)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;

    function Execute: string;
  end;

implementation

constructor TGenerateSolutionService.Create;
begin
  inherited Create;

end;

destructor TGenerateSolutionService.Destroy;
begin

  inherited Destroy;
end;

function TGenerateSolutionService.Execute: string;
begin
  Result := '{ "message":"solution generated" }';
end;

end.