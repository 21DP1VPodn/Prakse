table 60103 "valute table"
{
    Caption = 'Valutes table';
    TableType = Normal;
    fields
    {
        field(1; "No."; code[20])
        {
            Caption = 'number';
        }

        field(2; "Valute_from"; Text[20])
        {
            Caption = 'From';
        }

        field(3; "Valute_to"; Text[20])
        {
            Caption = 'To';
        }

        field(4; "Rate"; Decimal)
        {
            Caption = 'Rate';
        }
    }

    keys
    {
        key(PK; "No.")
        {

        }
    }
}