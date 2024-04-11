table 60105 "Exchange table"
{
    Caption = 'Exchange Table';
    TableType = Normal;
    fields
    {
        Field(1; "No."; code[20])
        {
            Caption = 'Number';
        }

        Field(2; "Valutes"; Text[20])
        {
            Caption = 'Valutes';
            TableRelation = "valute table".Valute_from;
        }

        field(3; Rate; Decimal)
        {
            Caption = 'Rate';
            FieldClass = FlowField;
            CalcFormula = lookup("valute table".Rate where(Valute_from = field(Valutes)));
            Editable = false;
        }
    }
}