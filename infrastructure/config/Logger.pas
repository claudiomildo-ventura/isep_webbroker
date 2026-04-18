(**
 * Unit: Logger
 *
 * Structured console logger inspired by the Spring Boot log format.
 *
 * Output format:
 *   <ISO-8601 timestamp>  <LEVEL> <PID> --- [app] [thread] <component> : <message>
 *
 * Example:
 *   2026-04-18T17:07:16.141-03:00  INFO  1234 --- [isep_webbroker] [        main] i.c.isep.Startup : Starting ISEP WebBroker application
 *
 * Usage:
 *   TLogger.Info('i.c.isep.MyUnit', 'Server started on port 3003');
 *   TLogger.Warn('i.c.isep.MyUnit', 'Configuration value not set, using default');
 *   TLogger.Error('i.c.isep.MyUnit', 'Unexpected exception: ' + E.Message);
 *
 * All methods are stateless class procedures — no instantiation required.
 *)
unit Logger;

{$mode objfpc}{$H+}

interface

uses
  SysUtils
  {$IFDEF WINDOWS}, Windows{$ENDIF};

type
  (** Stateless structured logger. All methods are class procedures. *)
  TLogger = class
  private
    (** Returns the current date/time as an ISO-8601 string with timezone offset. *)
    class function Timestamp: string;
    (** Returns the current OS process ID as a string. *)
    class function ProcessID: string;
    (** Internal method that formats and writes a log line to stdout. *)
    class procedure Log(const ALevel, AComponent, AMessage: string);
  public
    (** Writes an INFO-level log entry. *)
    class procedure Info(const AComponent, AMessage: string);
    (** Writes a WARN-level log entry. *)
    class procedure Warn(const AComponent, AMessage: string);
    (** Writes an ERROR-level log entry. *)
    class procedure Error(const AComponent, AMessage: string);
  end;

implementation

class function TLogger.Timestamp: string;
var
  DT: TDateTime;
  Y, Mo, D, H, Mi, S, MS: Word;
  Bias, BH, BM: Integer;
  Sign: string;
  {$IFDEF WINDOWS}
  TZI: TTimeZoneInformation;
  {$ENDIF}
begin
  DT := Now;
  DecodeDate(DT, Y, Mo, D);
  DecodeTime(DT, H, Mi, S, MS);
  {$IFDEF WINDOWS}
  GetTimeZoneInformation(TZI);
  Bias := TZI.Bias;
  {$ELSE}
  Bias := 0;
  {$ENDIF}
  if Bias <= 0 then Sign := '+' else Sign := '-';
  BH := Abs(Bias) div 60;
  BM := Abs(Bias) mod 60;
  Result := Format('%.4d-%.2d-%.2dT%.2d:%.2d:%.2d.%.3d%s%.2d:%.2d',
    [Y, Mo, D, H, Mi, S, MS, Sign, BH, BM]);
end;

class function TLogger.ProcessID: string;
begin
  {$IFDEF WINDOWS}
  Result := IntToStr(GetCurrentProcessId);
  {$ELSE}
  Result := '0';
  {$ENDIF}
end;

class procedure TLogger.Log(const ALevel, AComponent, AMessage: string);
begin
  WriteLn(Format('%s  %-5s %s --- [isep_webbroker] [        main] %-45s: %s', [Timestamp, ALevel, ProcessID, AComponent, AMessage]));
end;

class procedure TLogger.Info(const AComponent, AMessage: string);
begin
  Log('INFO', AComponent, AMessage);
end;

class procedure TLogger.Warn(const AComponent, AMessage: string);
begin
  Log('WARN', AComponent, AMessage);
end;

class procedure TLogger.Error(const AComponent, AMessage: string);
begin
  Log('ERROR', AComponent, AMessage);
end;

end.
