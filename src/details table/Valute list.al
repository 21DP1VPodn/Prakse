page 60106 "Valute list"
{
    Caption = 'Valute list';
    ApplicationArea = All;
    PageType = List;
    SourceTable = "valute table";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Number';
                }
                field(Valute; Rec.Valute)
                {
                    Caption = 'Valutes';
                }

                field(Rate; Rec.Rate)
                {
                    Caption = 'Rate';
                }
            }
        }
    }
}