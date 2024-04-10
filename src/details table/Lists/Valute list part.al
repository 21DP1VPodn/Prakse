page 60108 "Valute list part"
{
    ApplicationArea = All;
    Caption = 'Valute list part';
    PageType = ListPart;
    SourceTable = "valute table";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {

                }
                field(Valute_from; Rec.Valute_from)
                {
                }
                field(Valute_to; Rec.Valute_to)
                {
                }
                field(Rate; Rec.Rate)
                {
                }
            }
        }
    }
}
