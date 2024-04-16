page 50207 "Price list"
{
    ApplicationArea = All;
    Caption = 'Price list';
    SourceTable = "Price catalogue table";
    PageType = ListPart;

    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field(ID; Rec.ID)
                {
                    Caption = 'Plan name';
                }

                field("Equipment ID"; Rec."Equipment ID")
                {
                    Caption = 'Equipment ID';
                }

                field("Time period"; Rec."Time period")
                {
                    Caption = 'Time period';
                }

                field("Daily price"; Rec."Daily price")
                {
                    Caption = 'Daily price';
                }

                field(Fee; Rec.Fee)
                {
                    Caption = 'Fee';
                }
            }
        }
    }
}