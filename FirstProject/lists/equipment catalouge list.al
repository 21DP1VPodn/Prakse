page 50200 "Equipment Catalouge"
{
    ApplicationArea = all;
    Caption = 'Equipment catalouge';
    SourceTable = "equipment catalogue table";
    PageType = List;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Equipment ID"; Rec."Equipment ID")
                {
                    Caption = 'ID';
                }

                field(Name; Rec.Name)
                {
                    Caption = 'Equipment name';
                }

                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }

                field("Daily price"; Rec."Daily price")
                {
                    Caption = 'Price for 1 day';
                }

                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                }
            }
        }
    }
}