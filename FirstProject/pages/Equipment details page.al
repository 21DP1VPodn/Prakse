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
            group("General")
            {
                Caption = 'General inforamtion';
                field("Equipment ID"; Rec."Equipment ID")
                {
                    Caption = 'Equipment ID';
                    Importance = Promoted;
                }

                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    Importance = Promoted;
                }

                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    Importance = Additional;
                }
            }
            group(status_group)
            {
                Caption = 'Status';
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    editable = false;
                    Importance = Promoted;
                }

                field("Unavailable untill"; Rec."Unavailable untill")
                {
                    Caption = 'Unavailable untill';
                    Editable = false;
                }
            }

            part("Contract list"; "Contract list part")
            {
                Caption = 'Contract list';
                SubPageLink = "Equipment ID" = field("Equipment ID");
                Editable = false;
            }
        }
    }
}