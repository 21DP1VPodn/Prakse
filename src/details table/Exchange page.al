page 60107 "Exchange page"
{
    Caption = 'Exchange page';
    ApplicationArea = All;
    PageType = Document;
    SourceTable = "Exchanges table";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            field("Valute number"; Rec."Valute number")
            {
                caption = 'Valute code';
            }
            field("Valutes"; Rec.Valutes)
            {
                Caption = 'Valutes';
                Editable = true;
            }

            field(Quantity; Quantity)
            {
                Caption = 'Quantity';
            }

            field(Rate; Rec.Rate)
            {
                Caption = 'Rate';
            }

            field(Result; Result)
            {
                Caption = 'End Sum';
                Editable = false;
            }
        }
    }

    var
        Quantity: decimal;
        Result: decimal;

}