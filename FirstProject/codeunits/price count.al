codeunit 50200 "price count"
{
    trigger OnRun()
    begin
        Count_price(Reco, Date_from, Date_to);
    end;

    procedure Count_price(Reco: Record "Price catalogue table"; Date_from: Date; Date_to: Date) ReturnValue: decimal
    var
        Days: integer;
        Price: decimal;
    begin
        Days := Date_to - Date_from;
        Price := Reco."Daily price" * Days;
        ReturnValue := Price;
    end;

    var
        Reco: Record "Price catalogue table";
        date_from: Date;
        date_to: Date;
}