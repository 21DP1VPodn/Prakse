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

        field(2; "Valute"; Text[20])
        {
            Caption = 'Valute';
        }

        field(3; "Rate"; Decimal)
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