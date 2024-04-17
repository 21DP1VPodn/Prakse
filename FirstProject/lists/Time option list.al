page 50204 "Time options"
{
    ApplicationArea = All;
    Caption = 'Time options';
    SourceTable = "Rent time options";
    UsageCategory = Lists;
    PageType = List;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Option; Rec.Option)
                {
                    Caption = 'Option';
                }

                field(Time; Rec.Time)
                {
                    Caption = 'number of days';
                }
            }
        }
    }
}