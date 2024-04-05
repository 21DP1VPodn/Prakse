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
                TableRelation = "Exchanges table"."No.";
            }
            field("Valutes"; Valutes)
            {
                Caption = 'Valutes';
                Editable = true;
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
        Valutes: text[20];
        Rate: Decimal;

}