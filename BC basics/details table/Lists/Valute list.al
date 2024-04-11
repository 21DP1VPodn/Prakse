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
                field(Valute_from; Rec.Valute_from)
                {
                    Caption = 'From';
                }

                field(Valute_to; Rec.Valute_to)
                {
                    Caption = 'To';
                }

                field(Rate; Rec.Rate)
                {
                    Caption = 'Rate';
                }
            }
        }
    }
}