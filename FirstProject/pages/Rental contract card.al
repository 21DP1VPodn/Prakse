page 50202 "Rental contract card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Rental contracts";
    Caption = 'Rental contract';

    layout
    {
        area(Content)
        {
            Group(General)
            {
                Caption = 'General';
                field("Contract ID"; Rec."Contract ID")
                {
                    Caption = 'ID';
                    Importance = Promoted;
                }

                field("Client ID"; Rec."Client ID")
                {
                    Caption = 'Customer ID';
                    Importance = Promoted;
                }

                field("equipment ID"; Rec."equipment ID")
                {
                    Caption = 'Equipment';
                    Importance = Promoted;
                }
            }

            Group("Execution time")
            {
                Caption = 'Execution time';
                field("rental begin date"; Rec."rental begin date")
                {
                    Caption = 'Contract begin date';
                }

                field("Rental end date"; Rec."Rental end date")
                {
                    Caption = 'Contract end date';
                }

                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    Importance = Promoted;
                }
            }
        }
    }
}