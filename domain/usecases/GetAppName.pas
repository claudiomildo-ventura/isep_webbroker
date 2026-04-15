unit GetAppName;

interface

uses AppInfo;

type
  IGetAppName = interface
    ['{A1B2C3D4-E5F6-47A8-9B0C-1234567890AB}']
    function Execute: TAppInfo;
  end;

implementation

end.
