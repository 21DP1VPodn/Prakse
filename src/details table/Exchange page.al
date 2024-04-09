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
                TableRelation = "valute table"."No.";

                trigger OnValidate()
                var
                    Valute_Rec: Record "valute table";
                begin
                    Valute_rec.Get(Valutenumber);
                    Valute_from := Valute_Rec.Valute_from;
                    Valute_to := Valute_Rec.Valute_to;
                    Rate := Valute_Rec.Rate;
                end;
            }
            field("Valute_from"; Valute_from)
            {
                Caption = 'From';
                editable = false;
            }

            field("Valute_to"; Valute_to)
            {
                Caption = 'To';
                editable = false;
            }

            field(Quantity; Quantity)
            {
                Caption = 'Quantity';
            }

            field(Rate; Rate)
            {
                Caption = 'Rate';
                editable = false;
            }

            field(Result; Result)
            {
                Caption = 'End Sum';
                Editable = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Calculate result")
            {
                Caption = 'Count end sum';
                ApplicationArea = All;
                Image = Calculate;
                Tooltip = 'Counts end sum in the second valute';

                trigger OnAction()
                begin
                    Result := exchanger.exchange(Quantity, Rate);
                end;
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
        exchanger: Codeunit "valute exchange";

}