Table 50203 "Price catalogue table"
{
    fields
    {
        field(1; ID; code[20])
        {

        }

        field(2; "Equipment ID"; code[20])
        {
            TableRelation = "equipment catalogue table"."Equipment ID";
        }

        field(3; "Time period"; Text[30])
        {
            TableRelation = "Rent time options".option;
        }

        field(4; "Daily price"; decimal)
        {

        }

        field(5; Fee; decimal)
        {

        }
    }
}