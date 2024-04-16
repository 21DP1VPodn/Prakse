report 50200 "Equipment report"
{
    Caption = 'Equipment report';
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './layouts/Equipment_layout.rdl';

    dataset
    {
        dataitem("equipment catalogue table"; "equipment catalogue table")
        {
            DataItemTableView = sorting("Equipment ID");

            Column(Equipment_ID; "Equipment ID")
            {
                IncludeCaption = true;
            }

            Column(Name; Name)
            {
                IncludeCaption = true;
            }

            Column(Description; Description)
            {
                IncludeCaption = true;
            }

            column(Status; Status)
            {
                IncludeCaption = true;
            }

            Column(Unavailable_untill; "Unavailable untill")
            {
                IncludeCaption = true;
            }

            dataitem("Price catalogue table"; "Price catalogue table")
            {
                DataItemLink = "Equipment ID" = field("Equipment ID");
                DataItemLinkReference = "equipment catalogue table";

                column(Time_period; "Time period")
                {
                    IncludeCaption = true;
                }

                column(Daily_price; "Daily price")
                {
                    IncludeCaption = true;
                }

                column(ID; ID)
                {
                    IncludeCaption = true;
                }

                column(Fee; Fee)
                {
                    IncludeCaption = true;
                }
            }

            trigger OnPreDataItem()
            begin
                SetRange("equipment catalogue table"."Equipment ID", Equipment);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(General)
                {
                    Caption = 'General';
                    field(Equipment; Equipment)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Equipment';
                        TableRelation = "equipment catalogue table";
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var
        Reco: Record "equipment catalogue table";
    begin
        if not (Equipment <> '') then error('Please select the equipment');
    end;

    var
        Equipment: code[20];
}