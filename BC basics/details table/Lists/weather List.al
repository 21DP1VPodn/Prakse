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
                var
                    Dialog: page "Weather dialog";
                begin
                    Dialog.RunModal();
                end;
            }
        }
    }
}
