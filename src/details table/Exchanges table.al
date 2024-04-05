table 60106 "Exchanges table"
{
    Caption = 'Exchange Table';
    TableType = Normal;
    fields
    {
        Field(1; "No."; code[20])
        {
            Caption = 'Number';
        }

        field(2; Valutes; Text[20])
        {
            Caption = 'Rate';
            FieldClass = FlowField;
            CalcFormula = lookup("valute table".Valute where(Valute = field(Valutes)));
            Editable = false;
        }

        field(3; Rate; Decimal)
        {
            Caption = 'Rate';
            FieldClass = FlowField;
            CalcFormula = lookup("valute table".Rate where(Valute = field(Valutes)));
            Editable = false;
        }

        Field(4; "Valute number"; code[20])
        {
            Caption = 'Valutes';
            TableRelation = "valute table"."No.";
        }
    }
}