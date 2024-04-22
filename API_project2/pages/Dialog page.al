page 50801 "Dialog page"
{
    ApplicationArea = All;
    PageType = StandardDialog;
    Caption = 'Dialog page';

    layout
    {
        area(Content)
        {
            field(artist; artist)
            {
                Caption = 'artist';
            }

            field(song; song)
            {
                Caption = 'song';
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        MainPage: page "Search history";
        Client: HttpClient;
        Response: HttpResponseMessage;
        J: JsonObject;
        ResponseTxT: Text;
        Request: text[250];
        Lyrics: text[1000000];
    begin
        if CloseAction = CloseAction::OK then begin
            Request := 'https://api.lyrics.ovh/v1/' + artist + '/' + song;
            if Client.Get(Request, Response) then begin
                if Response.IsSuccessStatusCode() then begin
                    Response.Content().ReadAs(ResponseTxT);
                    J.ReadFrom(ResponseTxT);
                    Lyrics := GetJsonTextField(J, 'lyrics');
                    Srch.Init();
                    NoSeriesMgt.InitSeries('SRCH', '', Today(), Srch."ID", NewNoSeries);
                    Srch.artist := artist;
                    Srch.song := song;
                    Srch.ID := NoSeriesMGt.GetNextNo(NewNoSeries, today(), true);
                    Srch.Insert(true, false);
                    Message(Lyrics);
                end
                else
                    message('Failed to get an answer from api');
            end
            else
                message('Failed to get an answer from api');
        end;
    end;

    procedure GetJsonTextField(O: JsonObject; Member: Text): Text
    var
        Result: JsonToken;
    begin
        if O.get(Member, Result) then
            exit(Result.AsValue().AsText());
    end;


    var
        artist: text[100];
        song: text[100];
        Srch: Record "Search history table";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNoSeries: code[20];
}