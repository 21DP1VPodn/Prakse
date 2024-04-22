table 50800 "Search history table"
{
    fields
    {
        field(1; ID; code[20])
        {
            Caption = 'ID';
        }

        field(2; artist; text[100])
        {
            Caption = 'artist';
        }
        field(3; song; text[100])
        {
            Caption = 'song';
        }
    }

    keys
    {
        key(PK; ID)
        {

        }
    }
}