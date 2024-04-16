page 50200 "Equipment Catalouge"
{
    ApplicationArea = all;
    Caption = 'Equipment catalouge';
    SourceTable = "equipment catalogue table";
    PageType = List;
    UsageCategory = Lists;
    CardPageId = "Equipment details";

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

                field("Unavailable untill"; Rec."Unavailable untill")
                {
                    Caption = 'Unavailable untill';
                }
            }
        }
    }

    actions
    {
        Area(Processing)
        {
            action(available)
            {
                Caption = 'Make available';
                Tooltip = 'Makes a piece of equipment available';
                Image = Approval;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Rec_save: Record "equipment catalogue table";
                begin
                    Rec_save := Rec;
                    Rec.Init();
                    Rec.TransferFields(Rec_save);
                    Rec.Status := 'available';
                    Rec."Unavailable untill" := 0D;
                    Rec.Modify();
                end;
            }

            action(unavailable)
            {
                Caption = 'Make unavailable';
                Tooltip = 'Makes a piece of equipment unavailable';
                Image = Cancel;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Rec_save: Record "equipment catalogue table";
                begin
                    Rec_save := Rec;
                    Rec.Init();
                    Rec.TransferFields(Rec_save);
                    Rec.Status := 'unavailable';
                    Rec.Modify();
                end;
            }
        }
    }
}