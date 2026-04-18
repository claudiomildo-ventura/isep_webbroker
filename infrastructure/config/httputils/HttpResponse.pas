unit HttpResponse;

interface

uses
  System.JSON;

type
  THttpResponse = class(TObject)
  private
    FStatusCode: Integer;
    FContentType: string;
    FBody: TJSONValue;
  public
    destructor Destroy; override;

    property StatusCode: Integer read FStatusCode write FStatusCode;
    property ContentType: string read FContentType write FContentType;
    property Body: TJSONValue read FBody write FBody;
  end;

implementation

destructor THttpResponse.Destroy;
begin
  FBody.Free;
  inherited;
end;

end.