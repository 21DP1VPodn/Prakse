page 50203 "Add dialogue page"
{
    ApplicationArea = All;
    Caption = 'Add page';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {

            group(Client)
            {
                Caption = 'Client';
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

                field(Client_name; Client_name)
                {
                    Caption = 'Client name';
                    Editable = false;
                    Importance = Promoted;
                }
            }

            group(Dates)
            {
                Caption = 'Dates';
                field("Beign date"; Date_from)
                {
                    Caption = 'Cotract begin date';

                    trigger onValidate()
                    var
                        PriceRec: Record "Price catalogue table";
                        EqRec: Record "equipment catalogue table";
                        TimeRec: Record "Rent time options";
                        Days: integer;
                    begin
                        If ((time = '') = false) and ((Equipment = '') = false) then begin
                            PriceRec.SetRange("Equipment ID", Equipment);
                            PriceRec.SetRange("Time period", Time);
                            PriceRec.FindFirst();
                            EqRec.SetRange("Equipment ID", Equipment);
                            EqRec.FindFirst();
                            if PriceRec."Time period" = '1 DAY+' then begin
                                if (Date_to = 0D) = false then begin
                                    Days := Date_to - Date_from;
                                    if Days = 1 then PriceRec."Daily price" := 3.50;
                                    End_price := (PriceRec."Daily price" * Days) + PriceRec.Fee;
                                end;
                            end
                            else begin
                                TimeRec.Get(PriceRec."Time period");
                                End_price := (PriceRec."Daily price" * TimeRec.Time) + PriceRec.Fee;
                                Date_to := CalcDate((System.Format(TimeRec.Time) + 'D'), Date_from);
                            end;
                        end;
                    end;
                }

                field("End date"; Date_to)
                {
                    Caption = 'Contract end date';
                    Editable = EditCode;

                    trigger OnValidate()
                    var
                        PriceRec: Record "Price catalogue table";
                        Days: Integer;
                        ContRec: Record "Rental contracts";
                        EqRec: Record "equipment catalogue table";
                        TimeRec: Record "Rent time options";
                        availability_status: Boolean;
                        Count: Integer;
                        CheckRec: Record "Rental contracts";
                        test_date: Date;
                    begin
                        PriceRec.SetRange("Equipment ID", Equipment);
                        PriceRec.SetRange("Time period", Time);
                        PriceRec.FindFirst();
                        EqRec.SetRange("Equipment ID", Equipment);
                        EqRec.FindFirst();
                        ContRec.SetRange("equipment ID", Equipment);
                        ContRec.FindSet();
                        max_date := ContRec."Rental end date";
                        if (PriceRec."Time period" = '1 DAY+') and (EqRec.Status = 'availbale') then begin
                            Days := Date_to - Date_from;
                            if Days = 1 then PriceRec."Daily price" := 3.50;
                            End_price := (PriceRec."Daily price" * Days) + PriceRec.Fee;
                        end
                        else begin
                            availability_status := false;
                            Count := 0;
                            if (ContRec."Rental end date" < Date_from) or (ContRec."rental begin date" > Date_to) then begin
                                Count := Count + 1;
                            end;
                            while (ContRec.Next() = 0) = false do begin
                                if ContRec."Rental end date" > max_date then max_date := ContRec."Rental end date";
                                if (ContRec."Rental end date" < Date_from) or (ContRec."rental begin date" > Date_to) then begin
                                    Count := Count + 1;
                                end;
                            end;
                            if Count = ContRec.Count() then begin
                                availability_status := true;
                            end;
                            if availability_status = false then begin
                                message('Equipment unavailable, will become available %1', EqRec."Unavailable untill");
                                Equipment := '';
                                Date_to := 0D;
                                End_price := 0;
                            end
                            else begin
                                Days := Date_to - Date_from;
                                if Days = 1 then PriceRec."Daily price" := 3.50;
                                End_price := (PriceRec."Daily price" * Days) + PriceRec.Fee;
                            end;
                        end;
                    end;
                }
            }

            group("Equipment group")
            {
                Caption = 'Equipment';
                field(Equipment; Equipment)
                {
                    Caption = 'Equipment';
                    TableRelation = "equipment catalogue table"."Equipment ID";
                    trigger OnValidate()
                    var
                        PriceRec: Record "Price catalogue table";
                        EqRec: Record "equipment catalogue table";
                        TimeRec: Record "Rent time options";
                        ContRec: Record "Rental contracts";
                        availability_status: Boolean;
                        Count: Integer;
                        CheckRec: Record "Rental contracts";
                        test_date: Date;
                    begin
                        EqRec.SetRange("Equipment ID", Equipment);
                        EqRec.FindFirst();
                        Equipment_name := EqRec.Name;
                        If (time = '') = false then begin
                            PriceRec.SetRange("Equipment ID", Equipment);
                            PriceRec.SetRange("Time period", Time);
                            PriceRec.FindFirst();
                            ContRec.SetRange("equipment ID", Equipment);
                            ContRec.FindSet();
                            max_date := ContRec."Rental end date";
                            if EqRec.Status = 'available' then begin
                                if PriceRec."Time period" = '1 DAY+' then begin
                                    EditCode := true;
                                    Date_to := 0D;
                                    End_price := 0.00;
                                end
                                else begin
                                    EditCode := false;
                                    TimeRec.Get(PriceRec."Time period");
                                    End_price := (PriceRec."Daily price" * TimeRec.Time) + PriceRec.Fee;
                                    Date_to := CalcDate((System.Format(TimeRec.Time) + 'D'), Date_from);
                                end;
                            end
                            else begin
                                if PriceRec."Time period" = '1 DAY+' then begin
                                    EditCode := true;
                                    Date_to := 0D;
                                    End_price := 0.00;
                                end
                                else begin
                                    availability_status := false;
                                    Count := 0;
                                    test_date := CalcDate((System.Format(TimeRec.Time) + 'D'), Date_from);
                                    if (ContRec."Rental end date" < Date_from) or (ContRec."rental begin date" > test_date) then begin
                                        Count := Count + 1;
                                    end;
                                    while (ContRec.Next() = 0) = false do begin
                                        if ContRec."Rental end date" > max_date then max_date := ContRec."Rental end date";
                                        if (ContRec."Rental end date" < Date_from) or (ContRec."rental begin date" > test_date) then begin
                                            Count := Count + 1;
                                        end;
                                    end;
                                    if Count = ContRec.Count() then begin
                                        availability_status := true;
                                    end;
                                    if availability_status = false then begin
                                        message('Equipment unavailable, will become available %1', EqRec."Unavailable untill");
                                        Equipment := '';
                                        Date_to := 0D;
                                        End_price := 0;
                                    end
                                    else begin
                                        EditCode := false;
                                        TimeRec.Get(PriceRec."Time period");
                                        End_price := (PriceRec."Daily price" * TimeRec.Time) + PriceRec.Fee;
                                        Date_to := CalcDate((System.Format(TimeRec.Time) + 'D'), Date_from);
                                    end;
                                end;
                            end;
                        end;
                    end;
                }

                field(Equipment_name; Equipment_name)
                {
                    Caption = 'Equipment name';
                    Editable = false;
                    Importance = promoted;
                }
            }

            group(financial)
            {
                Caption = 'Financial';
                field(Time; Time)
                {
                    Caption = 'Rent time';
                    TableRelation = "Rent time options".option;

                    trigger OnValidate()
                    var
                        PriceRec: Record "Price catalogue table";
                        EqRec: Record "equipment catalogue table";
                        TimeRec: Record "Rent time options";
                        ContRec: Record "Rental contracts";
                        availability_status: Boolean;
                        Count: Integer;
                        CheckRec: Record "Rental contracts";
                        test_date: Date;
                    begin
                        If (Equipment = '') = false then begin
                            PriceRec.SetRange("Equipment ID", Equipment);
                            PriceRec.SetRange("Time period", Time);
                            PriceRec.FindFirst();
                            EqRec.SetRange("Equipment ID", Equipment);
                            EqRec.FindFirst();
                            ContRec.SetRange("equipment ID", Equipment);
                            ContRec.FindSet();
                            max_date := ContRec."Rental end date";
                            If (time = '') = false then begin
                                PriceRec.SetRange("Equipment ID", Equipment);
                                PriceRec.SetRange("Time period", Time);
                                PriceRec.FindFirst();
                                EqRec.SetRange("Equipment ID", Equipment);
                                EqRec.FindFirst();
                                if EqRec.Status = 'available' then begin
                                    if PriceRec."Time period" = '1 DAY+' then begin
                                        EditCode := true;
                                        Date_to := 0D;
                                        End_price := 0.00;
                                    end
                                    else begin
                                        EditCode := false;
                                        TimeRec.Get(PriceRec."Time period");
                                        End_price := (PriceRec."Daily price" * TimeRec.Time) + PriceRec.Fee;
                                        Date_to := CalcDate((System.Format(TimeRec.Time) + 'D'), Date_from);
                                    end;
                                end
                                else begin
                                    if PriceRec."Time period" = '1 DAY+' then begin
                                        EditCode := true;
                                        Date_to := 0D;
                                        End_price := 0.00;
                                    end
                                    else begin
                                        availability_status := false;
                                        Count := 0;
                                        test_date := CalcDate((System.Format(TimeRec.Time) + 'D'), Date_from);
                                        if (ContRec."Rental end date" < Date_from) or (ContRec."rental begin date" > test_date) then begin
                                            Count := Count + 1;
                                        end;
                                        while (ContRec.Next() = 0) = false do begin
                                            if ContRec."Rental end date" > max_date then max_date := ContRec."Rental end date";
                                            if (ContRec."Rental end date" < Date_from) or (ContRec."rental begin date" > test_date) then begin
                                                Count := Count + 1;
                                            end;
                                        end;
                                        if Count = ContRec.Count() then begin
                                            availability_status := true;
                                        end;
                                        if availability_status = false then begin
                                            message('Equipment unavailable, will become available %1', EqRec."Unavailable untill");
                                            Equipment := '';
                                            Date_to := 0D;
                                            End_price := 0;
                                        end
                                        else begin
                                            EditCode := false;
                                            TimeRec.Get(PriceRec."Time period");
                                            End_price := (PriceRec."Daily price" * TimeRec.Time) + PriceRec.Fee;
                                            Date_to := CalcDate((System.Format(TimeRec.Time) + 'D'), Date_from);
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                }

                field(End_price; End_price)
                {
                    Editable = false;
                    Importance = promoted;
                }
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
        EqRec: Record "equipment catalogue table";
        Rec: Record "equipment catalogue table";
    begin
        if CLoseAction = CloseAction::OK then begin
            NoSeriesMgt.InitSeries('CONTR', '', Today(), Reco."Contract ID", NewNumberCode);
            Reco.Init();
            Reco."Contract ID" := NoSeriesMgt.GetNextNo('CONTR', today, true);
            Reco."Client ID" := Client;
            Reco."equipment ID" := Equipment;
            Reco."rental begin date" := Date_from;
            Reco."Rental end date" := Date_to;
            if (Date_from <= Today) and (Date_to > Today) then Reco.Status := 'active';
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

            EqRec.SetRange("Equipment ID", Equipment);
            EqRec.FindFirst();
            Rec.init();
            Rec.TransferFields(EqRec);
            Rec.Status := 'unavailable';
            if Date_to > max_date then Rec."Unavailable untill" := Date_to;
            Rec.Modify();

            page.Run(page::"Sales Invoice", InvoRecord);
        end;
    end;

    trigger OnOpenPage()
    begin
        EditCode := false;
    end;

    var
        max_date: date;
        i: Integer;
        EditCode: Boolean;
        Reco: Record "Rental contracts";
        End_price: Decimal;
        Client: code[20];
        Client_name: text[100];
        Equipment: code[20];
        Equipment_name: text[100];
        Date_from: date;
        Date_to: date;
        NoSeriesMgt: codeunit NoSeriesManagement;
        NewNumberCode: code[20];
        Time: code[20];
}