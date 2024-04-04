page 60104 "API trainng page"
{
    PageType = Card;
    Caption = 'API training';
    editable = false;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            field(IP; GetIP())
            {
                Caption = 'Your current IP adress';
                ApplicationArea = All;
            }
        }
    }

    procedure GetIP(): Text
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        J: JsonObject;
        ResponseTxT: Text;
    begin
        if Client.Get('https://api.ipify.org?format=json', Response) then
            if Response.IsSuccessStatusCode() then begin
                Response.Content().ReadAs(ResponseTxT);
                J.ReadFrom(ResponseTxT);
                exit(GetJsonTextField(J, 'ip'));
            end;
    end;

    procedure GetJsonTextField(O: JsonObject; Member: Text): Text
    var
        Result: JsonToken;
    begin
        if O.get(Member, Result) then
            exit(Result.AsValue().AsText());
    end;
}