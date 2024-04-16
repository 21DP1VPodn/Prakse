table 50200 "equipment catalogue table"
{
    fields
    {
        field(1; "Equipment ID"; code[20])
        {

        }

        field(2; "Name"; text[50])
        {

        }

        field(3; "Description"; text[300])
        {

        }

        field(4; "Daily price"; decimal)
        {

        }

        field(5; "Status"; Text[20])
        {

        }

        field(6; "Unavailable untill"; Date)
        {

        }
    }

    keys
    {
        key(PK; "Equipment ID")
        {

        }
    }
}