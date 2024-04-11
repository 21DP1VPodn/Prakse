page 60101 "Detail card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = Detail;
    layout
    {
        area(content)
        {
            group(General)
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

            group("Detail list")
            {
                part("Details"; "Detail list part")
                {
                    Caption = 'Full detail list';
                    SubPageLink = DetailNo = field(DetailNo);
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Copy page")
            {
                Caption = 'Copy page';
                ApplicationArea = All;
                ToolTip = 'Creates a copy b of a current page with a different number';
                Image = Copy;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CopDetPag: page "Copy dialog page";
                begin
                    CopDetPag.SetDetail(Rec);
                    CopDetPag.RunModal();
                end;
            }
        }
    }
}