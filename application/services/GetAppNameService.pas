unit GetAppNameService;

interface

uses
  System.SysUtils, System.Classes,
  GetAppName, AppInfo;

type
  TGetAppNameService = class(TInterfacedObject, IGetAppName)
  public
    function Execute: TAppInfo;
  end;

implementation

function TGetAppNameService.Execute: TAppInfo;
begin
  Result := TAppInfo.Create('ISEP | Integrated Software Engineering Platform - WebBroker');
end;

end.
