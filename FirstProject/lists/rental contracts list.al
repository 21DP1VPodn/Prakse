page 50201 "rental contracts list"
{
    ApplicationArea = all;
    Caption = 'Rental contracts';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Rental contracts";
    CardPageId = "Rental contract card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Contract ID"; Rec."Contract ID")
                {
                    Caption = 'ID';
                    Editable = false;
                }

                field("Client ID"; Rec."Client ID")
                {
                    Caption = 'Customer ID';
                    editable = false;
                }

                field("equipment ID"; Rec."equipment ID")
                {
                    Caption = 'Equipment';
                    editable = false;
                }

                field("rental begin date"; Rec."rental begin date")
                {
                    Caption = 'Contract begin date';
                    editable = false;
                }

                field("Rental end date"; Rec."Rental end date")
                {
                    Caption = 'Contract end date';
                    editable = false;
                }

                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            Action("New Contract")
            {
                ApplicationArea = All;
                Caption = 'New Contract';
                Tooltip = 'Adds a new contract';
                Image = Add;

                trigger OnAction()
                var
                    Dialog: Page "Add dialogue page";
                begin
                    Dialog.SetContract(Rec);
                    Dialog.RunModal();
                end;
            }
        }
    }
}