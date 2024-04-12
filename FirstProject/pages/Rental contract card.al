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
            field("Contract ID"; Rec."Contract ID")
            {
                Caption = 'ID';
            }

            field("Client ID"; Rec."Client ID")
            {
                Caption = 'Customer ID';
            }

            field("equipment ID"; Rec."equipment ID")
            {
                Caption = 'Equipment';
            }

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
            }
        }
    }
}