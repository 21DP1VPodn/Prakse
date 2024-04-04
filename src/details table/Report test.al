Report 60100 "Test report"
{
    Caption = 'Test report';
    RDLClayout = './Layouts/MyFirstLayout.rdl';
    DefaultLayout = RDLC;
    ApplicationArea = All;

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "Bill-to Name";

            column(BillToAddress; "Bill-to Address")
            {
                IncludeCaption = true;
            }

            column(BillToCity; "Bill-to City")
            {
                IncludeCaption = true;
            }

            column(BillToCustomerNo; "Bill-to Customer No.")
            {
                IncludeCaption = true;
            }

            column(BillToName; "Bill-to Name")
            {
                IncludeCaption = true;
            }

            column(BillToPostCode; "Bill-to Post Code")
            {
                IncludeCaption = true;
            }

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                DataItemLinkReference = "SalesHeader";

                column("No_"; "No.")
                {
                    IncludeCaption = true;
                }

                column(Description; Description)
                {
                    IncludeCaption = true;
                }

                column(Quantity; Quantity)
                {
                    IncludeCaption = true;
                }

                column(Posting_Date; "Posting Date")
                {
                    IncludeCaption = true;
                }
            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                If (FromDate > 0D) and (ToDate > 0D) then
                    SetRange("Posting Date", FromDate, ToDate);
                If (FromDate > 0D) and (ToDate = 0D) then
                    SetRange("Posting Date", FromDate, 99991231D);
                If (FromDate = 0D) and (ToDate > 0D) then
                    SetRange("Posting Date", 00000101D, ToDate);
            end;
        }
    }

    requestpage
    {
        layout
        {
            Area(Content)
            {
                field(FromDate; FromDate)
                {

                }

                field(ToDate; ToDate)
                {

                }
            }
        }
    }

    labels
    {
        TitleLabel = 'My Title';
    }

    var
        TitleLbl: Label 'Test report';
        FromDate: Date;
        ToDate: Date;
}