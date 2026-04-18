(**
 * Unit: Startup
 *
 * Responsible for bootstrapping the embedded HTTP server using fphttpapp.
 *
 * This unit configures the fpWeb application object and starts the
 * request-handling loop. It also emits structured startup log messages
 * to stdout, similar to the Spring Boot startup banner format.
 *
 * Usage:
 *   Call StartServer from the program entry point (isep_webbroker.lpr).
 *   Execution will block until the server is shut down.
 *)
unit Startup;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fphttpapp,
  Logger;

(** Configures and starts the embedded HTTP server. Blocks until shutdown. *)
procedure StartServer;

implementation

const
  Port = 3003;

procedure StartServer;
begin
  try
    // Set the TCP port the server will bind to
    Application.Port := Port;

    // Allow requests to be dispatched to the default registered module.
    // when no specific module name is found in the URL path.
    Application.AllowDefaultModule := True;

    TLogger.Info('i.c.isep.Startup', 'Starting ISEP WebBroker application');
    Application.Initialize;
    TLogger.Info('i.c.isep.Startup', Format('Server started on port %d', [Application.Port]));
    TLogger.Info('i.c.isep.Startup', Format('Listening on http://localhost: %d /generate', [Application.Port]));

    // Enter the server event loop — blocks until process is terminated.
    Application.Run;
  except
    on E: Exception do
    begin
      TLogger.Error('i.c.isep.Startup', Format('Error starting server: %s', [E.Message]));
      raise; // Re-raises the exception to keep it visible during debugging.
    end;
  end;
end;

end.
