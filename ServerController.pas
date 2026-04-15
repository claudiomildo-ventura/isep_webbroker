unit ServerController;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

type
{$METHODINFO ON}
  TServerController1 = class(TComponent)
  public
    function GetAppName: string;
  end;
{$METHODINFO OFF}

implementation


function TServerController1.GetAppName: string;
begin
  Result := 'ISEP | Integrated Software Engineering Platform - WebBroker';
end;
end.