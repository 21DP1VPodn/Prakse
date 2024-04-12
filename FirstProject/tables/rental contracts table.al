table 50201 "Rental contracts"
{
    fields
    {
        field(1; "Contract ID"; code[20])
        {

        }

        field(2; "Client ID"; code[20])
        {
            Caption = 'Customer ID';
            TableRelation = Customer."No.";
        }

        field(3; "equipment ID"; code[20])
        {
            TableRelation = "equipment catalogue table"."Equipment ID";
        }

        field(4; "rental begin date"; Date)
        {

        }

        field(5; "Rental end date"; Date)
        {

        }

        field(6; Status; text[20])
        {

        }
    }

    keys
    {
        key(PK; "Contract ID")
        {

        }
    }
}