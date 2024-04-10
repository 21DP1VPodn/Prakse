page 60109 "Detail list part"
{
    ApplicationArea = All;
    Caption = 'Detail list part';
    PageType = ListPart;
    SourceTable = Detail;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(DetailNo; Rec.DetailNo)
                {
                }
                field("Code"; Rec."Code")
                {
                }
                field(ManufactorerNo; Rec.ManufactorerNo)
                {
                }
                field(ManufacturerName; Rec.ManufacturerName)
                {
                }
                field("AtrašanasValsts"; Rec."AtrašanasValsts")
                {
                }
                field(City; Rec.City)
                {
                }
                field(Pilseta; Rec.Pilseta)
                {
                }
            }
        }
    }
}
