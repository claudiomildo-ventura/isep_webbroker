(**
 * ISEP | Integrated Software Engineering Platform - WebBroker
 *
 * Main program entry point.
 *
 * This application is a lightweight HTTP server built with Free Pascal (FPC)
 * and the fpWeb/fphttpapp framework. It follows a clean-architecture-inspired
 * layered structure:
 *
 *   HTTP Request
 *     -> WebModule  (infrastructure/config/webmodule)
 *     -> Controller (adapter/in/archetype/controller)
 *     -> Service    (domain/service)
 *
 * The server listens on port 3003 by default.
 * Main endpoint: GET http://localhost:3003/generate
 *
 * Build requirements:
 *   - Free Pascal Compiler (FPC) 3.2+
 *   - Lazarus IDE with fpWeb package
 *)
program isep_webbroker;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  // Enable multi-threading support on Unix/Linux platforms
  cthreads,
  {$ENDIF}{$ENDIF}
  SysUtils, fphttpapp,
  WebModule1, // Registers the HTTP module with fpWeb
  Startup;    // Configures and starts the HTTP server

begin
  // Initialize and start the embedded HTTP server.
  // Execution blocks here until the server is stopped.
  StartServer;
end.

{ Main web module for HTTP requests }

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TStartup, Startup1);
  Application.Run;
end.
