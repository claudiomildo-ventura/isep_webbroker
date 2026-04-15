unit AppInfo;

interface

type
  TAppInfo = class
  private
    FName: string;
  public
    constructor Create(const AName: string);
    property Name: string read FName;
  end;

implementation

constructor TAppInfo.Create(const AName: string);
begin
  FName := AName;
end;

end.
