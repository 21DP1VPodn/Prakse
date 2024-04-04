Table 60104 City
{
    Caption = 'City';
    TableType = Normal;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No.';
        }

        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }

        field(3; "Atrašanas valsts"; Enum "Atrašanas Valsts")
        {
            Caption = 'Atrašanas valsts';
        }
    }

    keys
    {
        key(PK; No)
        {

        }
    }
}