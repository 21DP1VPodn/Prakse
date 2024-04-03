page 60105 "Weather list"
{
    Caption = 'Weather List';
    ApplicationArea = All;
    PageType = list;
    SourceTable = Weather;
    UsageCategory = lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Line number';
                }

                field("Date"; Rec.Date)
                {
                    Caption = 'Forecast Date';
                }

                field("temp"; Rec.temp)
                {
                    Caption = 'Temperature';
                }

                field("wind"; Rec.wind)
                {
                    Caption = 'wind speed';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Add forecast")
            {
                ApplicationArea = All;
                Caption = 'Add forecast';
                Image = Add;
                Tooltip = 'Add a new weather forecast to the table';
                trigger OnAction()
                begin
                    Weat.Init();
                    NoSeriesMgt.InitSeries('WEAT', '', Today(), Weat."No.", NewNoSeriesCode);
                    Weat.Date := GetDate();
                    Weat.temp := Gettemp();
                    Weat.wind := Getwind();
                    Weat."No." := NoSeriesMGt.GetNextNo(NewNoSeriesCode, today(), true);
                    ;
                    Weat.Insert(true, false);
                end;
            }
        }
    }

    procedure GetDate(): Date
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        J: JsonObject;
        ResponseTxT: Text;
    begin
        if Client.Get('http://api.weatherapi.com/v1/current.json?key=f2bde0bbf710401c9e770016240304&q=Riga&aqi=no', Response) then begin
            if Response.IsSuccessStatusCode() then begin
                Response.Content().ReadAs(ResponseTxT);
                J.ReadFrom(ResponseTxT);
                J := GetJsonObject(J, 'location');
                exit(GetJsonDate(J, 'localtime'));
            end;
        end;
    end;

    procedure Gettemp(): Text
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        J: JsonObject;
        ResponseTxT: Text;
    begin
        if Client.Get('http://api.weatherapi.com/v1/current.json?key=f2bde0bbf710401c9e770016240304&q=Riga&aqi=no', Response) then begin
            if Response.IsSuccessStatusCode() then begin
                Response.Content().ReadAs(ResponseTxT);
                J.ReadFrom(ResponseTxT);
                J := GetJsonObject(J, 'current');
                exit(GetJsonTextField(J, 'temp_c'));
            end;
        end;
    end;

    procedure Getwind(): Text
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        J: JsonObject;
        ResponseTxT: Text;
    begin
        if Client.Get('http://api.weatherapi.com/v1/current.json?key=f2bde0bbf710401c9e770016240304&q=Riga&aqi=no', Response) then begin
            if Response.IsSuccessStatusCode() then begin
                Response.Content().ReadAs(ResponseTxT);
                J.ReadFrom(ResponseTxT);
                J := GetJsonObject(J, 'current');
                exit(GetJsonTextField(J, 'wind_kph'));
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

    var
        Weat: Record Weather;
        NoSeriesMGt: Codeunit NoSeriesManagement;
        NewNoSeriesCode: Code[20];
}
