Report 60100 "Test report"
{
    Caption = 'Test report';
    RDLClayout = './Layouts/MyFirstLayout.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {

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
            }
        }
    }

    labels
    {
        TitleLabel = 'My Title';
    }

    var
        TitleLbl: Label 'Test report';
}