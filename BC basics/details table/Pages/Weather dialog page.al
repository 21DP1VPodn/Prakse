page 60111 "Weather dialog"
{
    ApplicationArea = all;
    Caption = 'Weather dialog page';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            Group(City_group)
            {
                Caption = 'City';

                field(City; City)
                {
                    Caption = 'City';
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        MainPage: page "Weather list";
        Client: HttpClient;
        Response: HttpResponseMessage;
        J: JsonObject;
        ResponseTxT: Text;
        Isolatedkey: text[50];
        Isolatedkey_bool: Boolean;
    begin
        if CloseAction = CloseAction::OK then begin
            IsolatedStorage.set('key', 'f2bde0bbf710401c9e770016240304', DataScope::Module);
            Isolatedkey := get_key();
            Request := 'http://api.weatherapi.com/v1/current.json?key=' + Isolatedkey + '&q=' + City + '&aqi=no';
            if Client.Get(Request, Response) then begin
                if Response.IsSuccessStatusCode() then begin
                    Response.Content().ReadAs(ResponseTxT);
                    J.ReadFrom(ResponseTxT);
                    Weat.Init();
                    NoSeriesMgt.InitSeries('WEAT', '', Today(), Weat."No.", NewNoSeriesCode);
                    J := GetJsonObject(J, 'location');
                    Weat.Date := GetJsonDate(J, 'localtime');
                    Weat.City := GetJsonTextField(J, 'name');
                    J.ReadFrom(ResponseTxT);
                    J := GetJsonObject(J, 'current');
                    Weat.temp := GetJsonTextField(J, 'temp_c');
                    Weat.wind := GetJsonTextField(J, 'wind_kph');
                    Weat."No." := NoSeriesMGt.GetNextNo(NewNoSeriesCode, today(), true);
                    Weat.Insert(true, false);
                end
                else begin
                    message('The City you provided was not found');
                end;
            end;
        end;
    end;

    procedure GetJsonDate(O: JsonObject; Member: Text): Date
    var
        Result: JsonToken;
    begin
        if O.get(Member, Result) then
            exit(ParseDate(Result));
    end;

    procedure GetJsonTextField(O: JsonObject; Member: Text): Text
    var
        Result: JsonToken;
    begin
        if O.get(Member, Result) then
            exit(Result.AsValue().AsText());
    end;

    procedure GetJsonObject(O: JsonObject; Member: Text): JsonObject
    var
        Result: JsonToken;
    begin
        if O.get(Member, Result) then
            exit(Result.AsObject())
        else
            message('can not gain the object out');
    end;

    procedure ParseDate(Token: JsonToken): Date
    var
        DateParts: List of [Text];
        Year: Integer;
        Month: Integer;
        Day: Integer;
    begin
        // Error handling omitted from example
        DateParts := Token.AsValue().AsText().Split('-', ' ');
        Evaluate(Year, DateParts.Get(1));
        Evaluate(Month, DateParts.Get(2));
        Evaluate(Day, DateParts.Get(3));
        exit(DMY2Date(Day, Month, Year));
    end;

    procedure get_key(): text
    var
        IsolatedKey: text;
    begin
        if IsolatedStorage.Get('key', DataScope::Module, Isolatedkey) then
            exit(Isolatedkey);
    end;

    var
        Weat: Record Weather;
        NoSeriesMGt: Codeunit NoSeriesManagement;
        NewNoSeriesCode: Code[20];
        City: Text[50];
        Request: text[150];
}