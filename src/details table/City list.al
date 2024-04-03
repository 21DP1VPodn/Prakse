Page 60102 "City List"
{
    ApplicationArea = All;
    Caption = 'City List';
    PageType = List;
    SourceTable = City;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    Caption = 'City No.';
                }

                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                }

                field("Atrašanas vlasts"; Rec."Atrašanas valsts")
                {
                    Caption = 'Atrašanas valsts';
                }
            }
        }
    }
}