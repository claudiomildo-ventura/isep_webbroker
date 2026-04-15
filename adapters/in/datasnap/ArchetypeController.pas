unit ArchetypeController;

interface

uses
  System.SysUtils, System.Classes, GetAppNameService, AppInfo;

type
  TArchetypeController = class(TComponent)
  public
    function ArchetypeMethod: string;
  end;

implementation

function TArchetypeController.ArchetypeMethod: string;
var
  Service: TGetAppNameService;
  AppInfo: TAppInfo;
begin
  Service := TGetAppNameService.Create;
  AppInfo := Service.Execute;
  try
    Result := AppInfo.Name;
  finally
    AppInfo.Free;
  end;
end;

end.

