page 60107 "Exchange page"
{
    Caption = 'Exchange page';
    ApplicationArea = All;
    PageType = Document;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            field("Valute number"; Valutenumber)
            {
                caption = 'Valute code';
            }
            field("Valute_from"; Valute_from)
            {
                Caption = 'From';
            }

            field("Valute_to"; Valute_to)
            {
                Caption = 'To';
            }

            field(Quantity; Quantity)
            {
                Caption = 'Quantity';
            }

            field(Rate; Rate)
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
        Valutenumber: code[20];
        Valute_from: text[20];
        Valute_to: text[20];
        Rate: Decimal;

}