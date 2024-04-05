table 60102 "valutes table"
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

        field(3; "Rate"; Integer)
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