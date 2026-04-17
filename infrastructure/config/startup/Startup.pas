unit Startup;

interface

uses
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.AppEvnts,
  Vcl.StdCtrls,
  IdHTTPWebBrokerBridge,
  Web.HTTPApp;

  procedure TerminateThreads;

type
  /// <summary>
  /// Main startup form responsible for controlling the WebBroker HTTP server.
  /// Provides UI actions to start/stop the server and open a browser.
  /// </summary>
  TStartup = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    ButtonOpenBrowser: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;

    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);

  private
    FServer: TIdHTTPWebBrokerBridge;

    /// <summary>
    /// Starts the HTTP server if it is not already running.
    /// </summary>
    procedure StartServer;

    /// <summary>
    /// Stops the HTTP server and clears bindings.
    /// </summary>
    procedure StopServer;

    /// <summary>
    /// Safely converts the port from the UI.
    /// </summary>
    function GetPort: Integer;

  end;

var
  Startup1: TStartup;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  Winapi.ShellApi,
  Datasnap.DSSession;

procedure TStartup.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
end;

procedure TStartup.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

function TStartup.GetPort: Integer;
begin
  if not TryStrToInt(EditPort.Text, Result) then
    raise Exception.Create('Invalid port number.');
end;

procedure TStartup.StartServer;
begin
  if FServer.Active then
    Exit;

  try
    FServer.Bindings.Clear;
    FServer.DefaultPort := GetPort;
    FServer.Active := True;
  except
    on E: Exception do
      ShowMessage('Error starting server: ' + E.Message);
  end;
end;

procedure TStartup.StopServer;
begin
  if not FServer.Active then
    Exit;

  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

procedure TStartup.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TStartup.ButtonStopClick(Sender: TObject);
begin
  StopServer;
end;

procedure TStartup.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%d', [GetPort]);
  ShellExecute(0, nil, PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

end.
