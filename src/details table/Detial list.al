page 60100 "Detial list"
{
    ApplicationArea = All;
    Caption = 'Detail list';
    PageType = List;
    SourceTable = Detail;
    UsageCategory = Lists;
    CardPageId = "Detail card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(DetailNo; Rec.DetailNo)
                {
                    Caption = 'Detai number';
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

                field("City"; Rec.City)
                {
                    Caption = 'City';
                }

                field("CityName"; Rec.Pilseta)
                {
                    Caption = 'City Name';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Add new line")
            {
                ApplicationArea = All;
                Caption = 'Add line';
                Image = Add;
                Tooltip = 'Add a new line to the table filled with random data';
                trigger OnAction()
                begin
                    NoSeriesMgt.InitSeries('Detail', '', Today(), Det.DetailNo, NewNoSeriesCode);
                    Det.Init();
                    Det.Code := 'DRQ5-8D20';
                    Det.ManufactorerNo := 'LAMNA';
                    Det.City := 'CTY00001';
                    Det.DetailNo := NoSeriesMGt.GetNextNo(NewNoSeriesCode, today(), true);
                    Det.Insert(true, false);
                end;
            }

            action("Clean table")
            {
                ApplicationArea = All;
                Caption = 'Clear';
                Image = Cancel;
                Tooltip = 'Delete all data from the table';
                trigger OnAction()
                begin
                    Det.DeleteAll;
                end;
            }

            action("Count Lines")
            {
                ApplicationArea = All;
                Caption = 'Count lines';
                Image = Allocations;
                Tooltip = 'Count all the lines in the table and display the count with a message';
                Trigger OnAction()
                begin
                    res := Det.count();
                    message('%1', "res");
                end;
            }
        }
    }

    var
        Det: Record Detail;
        NoSeriesMGt: Codeunit NoSeriesManagement;
        NewNoSeriesCode: Code[20];
        res: Integer;
}
