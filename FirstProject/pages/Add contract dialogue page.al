page 50203 "Add dialogue page"
{
    ApplicationArea = All;
    Caption = 'Add page';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field("Client ID"; Client)
            {
                Caption = 'Client ID';
                TableRelation = Customer."No.";

                trigger OnValidate()
                var
                    CustRec: Record Customer;
                begin
                    CustRec.Get(Client);
                    Client_name := CustRec.Name;
                end;
            }

            field("Equipment ID"; Equipment)
            {
                Caption = 'Equipment ID';
                TableRelation = "equipment catalogue table"."Equipment ID";
            }

            field("Beign date"; Date_from)
            {
                Caption = 'Cotract begin date';
            }

            field("End date"; Date_to)
            {
                Caption = 'Contract end date';
            }
        }
    }

    procedure SetContract(Record_contracts: Record "Rental contracts")
    begin
        Reco := Record_contracts;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    var
        InvoRecord: Record "Sales Header";
    begin
        if CLoseAction = CloseAction::OK then begin
            NoSeriesMgt.InitSeries('CONTR', '', Today(), Reco."Contract ID", NewNumberCode);
            Reco.Init();
            Reco."Contract ID" := NoSeriesMgt.GetNextNo('CONTR', today, true);
            Reco."Client ID" := Client;
            Reco."equipment ID" := Equipment;
            Reco."rental begin date" := Date_from;
            Reco."Rental end date" := Date_to;
            if (Date_from < Today) and (Date_to > Today) then Reco.Status := 'active';
            if (Date_from > Today) then Reco.Status := 'planned';
            if (Date_from < Today) and (Date_to < Today) then Reco.Status := 'finished';
            Reco.Insert();

            InvoRecord.init();
            InvoRecord."Document Type" := InvoRecord."Document Type"::Invoice;
            InvoRecord.Insert(true);
            InvoRecord.VALIDATE("Sell-to Customer No.", Client);
            InvoRecord."Document Date" := Today;
            InvoRecord."Posting Date" := Today;
            InvoRecord."VAT Reporting Date" := Today;
            InvoRecord."Due Date" := Today;
            InvoRecord.Modify();
            page.Run(page::"Sales Invoice", InvoRecord);
        end;
    end;

    var
        Reco: Record "Rental contracts";
        Client: code[20];
        Client_name: text[100];
        Equipment: code[20];
        Date_from: date;
        Date_to: date;
        NoSeriesMgt: codeunit NoSeriesManagement;
        NewNumberCode: code[20];
}