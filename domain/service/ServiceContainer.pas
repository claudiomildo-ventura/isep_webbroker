(**
 * Unit: ServiceContainer
 *
 * Lightweight dependency injection (DI) container for domain services.
 *
 * TServiceContainer owns and manages the lifecycle of all service instances.
 * A single global instance (ServiceContainer) is created at unit
 * initialization and freed at finalization, making services available
 * for the entire lifetime of the application.
 *
 * Usage:
 *   ServiceContainer.ArchetypeService.GenerateSolution;
 *
 * To add a new service:
 *   1. Declare a private field and a public property in TServiceContainer.
 *   2. Instantiate it in the constructor and free it in the destructor.
 *)
unit ServiceContainer;

{$mode objfpc}{$H+}

interface

uses
  ArchetypeService;

type
  (** Manages the lifecycle of all domain service instances. *)
  TServiceContainer = class
  private
    FArchetypeService: TArchetypeService;
  public
    constructor Create;
    destructor Destroy; override;

    (** Provides access to the ArchetypeService singleton instance. *)
    property ArchetypeService: TArchetypeService read FArchetypeService;
  end;

(** Global service container instance — available throughout the application. *)
var
  ServiceContainer: TServiceContainer;

implementation

constructor TServiceContainer.Create;
begin
  inherited Create;
  // Instantiate all domain services here
  FArchetypeService := TArchetypeService.Create;
end;

destructor TServiceContainer.Destroy;
begin
  // Free services in reverse order of creation
  FArchetypeService.Free;
  inherited Destroy;
end;

initialization
  // Create the global container when the unit is loaded
  ServiceContainer := TServiceContainer.Create;

finalization
  // Release all managed services on application shutdown
  ServiceContainer.Free;

end.
