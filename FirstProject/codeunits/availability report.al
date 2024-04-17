report 50201 "availability report"
{
    Caption = 'Availability report';
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './layouts/Availability_layout.rdl';

    dataset
    {
        dataitem("equipment catalogue table"; "equipment catalogue table")
        {
            Column(Equipment_ID; "Equipment ID")
            {
                IncludeCaption = true;
            }

            Column(Name; Name)
            {
                IncludeCaption = true;
            }

            Column(Status; Status)
            {
                IncludeCaption = true;
            }

            Column(Unavailable_untill; "Unavailable untill")
            {
                IncludeCaption = true;
            }
        }
    }
}