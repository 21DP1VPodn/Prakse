page 60101 "Detail card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = Detail;
    layout
    {
        area(content)
        {
            field(No; Rec.DetailNo)
            {
                TableRelation = Detail.DetailNo;
                Caption = 'Number';
            }

            field(Code; Rec.Code)
            {
                Caption = 'Code';
            }

            field("Manufactorer code"; Rec.ManufactorerNo)
            {
                Caption = 'Manufactorer code';
            }

            field("Manufactorer name"; Rec.ManufacturerName)
            {
                Caption = 'Manufactorer';
            }

            field("Arašanas valsts"; Rec."AtrašanasValsts")
            {
                Caption = 'Atrašanas Vlasts';
            }

            field(Name; Rec.City)
            {
                Caption = 'Pilseta';
            }
        }
    }
}