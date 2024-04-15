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
            field("Beign date"; Date_from)
            {
                Caption = 'Cotract begin date';
            }

            field("End date"; Date_to)
            {
                Caption = 'Contract end date';
                Editable = EditCode;

                trigger OnValidate()
                var
                    PriceRec: Record "Price catalogue table";
                    Days: Integer;
                begin
                    PriceRec.SetRange("Equipment ID", Equipment);
                    PriceRec.SetRange("Time period", Time);
                    PriceRec.FindFirst();
                    if PriceRec."Time period" = '1 DAY+' then begin
                        Days := Date_to - Date_from;
                        if Days = 1 then PriceRec."Daily price" := 3.50;
                        End_price := (PriceRec."Daily price" * Days) + PriceRec.Fee;
                    end;
                end;
            }

            field(Equipment; Equipment)
            {
                Caption = 'Equipment';
                TableRelation = "equipment catalogue table"."Equipment ID";
                trigger OnValidate()
                var
                    PriceRec: Record "Price catalogue table";
                begin
                    If (time = '') = false then begin
                        PriceRec.SetRange("Equipment ID", Equipment);
                        PriceRec.SetRange("Time period", Time);
                        PriceRec.FindFirst();
                        if PriceRec."Time period" = '1 DAY' then begin
                            EditCode := false;
                            End_price := PriceRec."Daily price" + PriceRec.Fee;
                            Date_to := CalcDate('1D', Date_from);
                        end;
                        if PriceRec."Time period" = '1 WEEK' then begin
                            EditCode := false;
                            End_price := (PriceRec."Daily price" * 7) + PriceRec.Fee;
                            Date_to := CalcDate('7D', Date_from);
                        end;
                        if PriceRec."Time period" = '2 WEEKS' then begin
                            EditCode := false;
                            End_price := (PriceRec."Daily price" * 14) + PriceRec.Fee;
                            Date_to := CalcDate('14D', Date_from);
                        end;
                        if PriceRec."Time period" = '1 MONTH' then begin
                            EditCode := false;
                            End_price := (PriceRec."Daily price" * 30) + PriceRec.Fee;
                            Date_to := CalcDate('30D', Date_from);
                        end;
                        if PriceRec."Time period" = '1 YEAR' then begin
                            EditCode := false;
                            End_price := (PriceRec."Daily price" * 365) + PriceRec.Fee;
                            Date_to := CalcDate('365D', Date_from);
                        end;
                        if PriceRec."Time period" = '1 DAY+' then begin
                            EditCode := true;
                            Date_to := 0D;
                            End_price := 0.00;
                        end;
                    end;
                end;
            }

            field(Time; Time)
            {
                Caption = 'Rent time';
                TableRelation = "Rent time options".option;

                trigger OnValidate()
                var
                    PriceRec: Record "Price catalogue table";
                begin
                    If (Equipment = '') = false then begin
                        PriceRec.SetFilter("Equipment ID", Equipment);
                        PriceRec.SetFilter("Time period", Time);
                        PriceRec.FindFirst();
                        if PriceRec."Time period" = '1 DAY' then begin
                            EditCode := false;
                            End_price := PriceRec."Daily price" + PriceRec.Fee;
                            Date_to := CalcDate('1D', Date_from);
                        end;
                        if PriceRec."Time period" = '1 WEEK' then begin
                            EditCode := false;
                            End_price := (PriceRec."Daily price" * 7) + PriceRec.Fee;
                            Date_to := CalcDate('7D', Date_from);
                        end;
                        if PriceRec."Time period" = '2 WEEKS' then begin
                            EditCode := false;
                            End_price := (PriceRec."Daily price" * 14) + PriceRec.Fee;
                            Date_to := CalcDate('14D', Date_from);
                        end;
                        if PriceRec."Time period" = '1 MONTH' then begin
                            EditCode := false;
                            End_price := (PriceRec."Daily price" * 30) + PriceRec.Fee;
                            Date_to := CalcDate('30D', Date_from);
                        end;
                        if PriceRec."Time period" = '1 YEAR' then begin
                            EditCode := false;
                            End_price := (PriceRec."Daily price" * 365) + PriceRec.Fee;
                            Date_to := CalcDate('365D', Date_from);
                        end;
                        if PriceRec."Time period" = '1 DAY+' then begin
                            EditCode := true;
                            Date_to := 0D;
                            End_price := 0.00;
                        end;
                    end;
                end;
            }

            field(End_price; End_price)
            {
                Editable = false;
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

    trigger OnOpenPage()
    begin
        EditCode := false;
    end;

    var
        EditCode: Boolean;
        Reco: Record "Rental contracts";
        End_price: Decimal;
        Client: code[20];
        Client_name: text[100];
        Equipment: code[20];
        Date_from: date;
        Date_to: date;
        NoSeriesMgt: codeunit NoSeriesManagement;
        NewNumberCode: code[20];
        Time: code[20];
}