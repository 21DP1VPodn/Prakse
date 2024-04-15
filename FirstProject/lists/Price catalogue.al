Page 50205 "Price catalogue"
{
    ApplicationArea = All;
    Caption = 'Price catalogue';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "price catalogue table";

    layout
    {
        Area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    Caption = 'ID';
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
                    Caption = 'Price for 1 day';
                }

                field(Fee; Rec.Fee)
                {
                    Caption = 'Fee';
                }
            }
        }
    }
}