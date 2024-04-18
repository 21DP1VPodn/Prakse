page 50208 "Contract list part"
{
    ApplicationArea = All;
    Caption = 'Contract list part';
    PageType = ListPart;
    SourceTable = "Rental contracts";

    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("equipment ID"; Rec."equipment ID")
                {
                    Caption = 'Equipment ID';
                }

                field("rental begin date"; Rec."rental begin date")
                {
                    Caption = 'Unavailable from';
                }

                field("Rental end date"; Rec."Rental end date")
                {
                    Caption = 'Unavailable to';
                }
            }
        }
    }
}