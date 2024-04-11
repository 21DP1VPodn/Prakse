codeunit 60100 "valute exchange"
{
    trigger OnRun()
    begin
        exchange(Quantity, Rate);
    end;

    procedure exchange(Quantity: decimal; Rate: decimal) ReturnValue: decimal
    var
        Res: decimal;
    begin
        Res := Quantity * Rate;
        ReturnValue := Res;
    end;

    var
        Quantity: decimal;
        Rate: decimal;

}