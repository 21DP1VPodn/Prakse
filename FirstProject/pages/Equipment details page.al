page 50206 "Equipment details"
{
    ApplicationArea = All;
    Caption = 'Equipment details';
    SourceTable = "equipment catalogue table";
    PageType = card;

    layout
    {
        area(Content)
        {
            field("Equipment ID"; Rec."Equipment ID")
            {
                Caption = 'Equipment ID';
            }

            field(Name; Rec.Name)
            {
                Caption = 'Name';
            }

            field(Description; Rec.Description)
            {
                Caption = 'Description';
            }

            field(Status; Rec.Status)
            {
                Caption = 'Status';
                editable = false;
            }

            field("Unavailable untill"; Rec."Unavailable untill")
            {
                Caption = 'Unavailable untill';
                Editable = false;
            }

            part("Contract list"; "Contract list part")
            {
                Caption = 'Price list';
                SubPageLink = "Equipment ID" = field("Equipment ID");
                Editable = false;
            }
        }
    }
}