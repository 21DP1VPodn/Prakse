page 50804 "time dialog"
{
    ApplicationArea = All;
    PageType = StandardDialog;
    Caption = 'Time change dialog';

    layout
    {
        area(Content)
        {
            field(time; time)
            {
                Caption = 'time in numbers';
            }
            field(Cod; Cod)
            {
                Caption = 'output code';
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = CloseAction::OK then begin
            Code.Transform_time(time, Cod);
        end;
    end;

    var
        time: time;
        Cod: code[1];
        Code: Codeunit "Time converter";
}