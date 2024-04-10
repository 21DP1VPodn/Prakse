page 60110 "Copy dialog page"
{
    ApplicationArea = All;
    Caption = 'Copy dialog page';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group("Details")
            {
                field(OldNo; Rec.DetailNo)
                {
                    Caption = 'This details number';
                    Editable = false;
                }
                field(NewNo; NewNo)
                {
                    Caption = 'New detail number';
                }
            }
        }
    }

    procedure SetDetail(Detail_Record: Record Detail)
    begin
        Rec := Detail_Record;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        Detail_record: Record Detail;
        err: Label 'Please specify new detail number';
    begin
        if CloseAction = CloseAction::OK then begin
            if NewNo = '' then Error(err);

            Detail_record.Init();
            Detail_record.TransferFields(Rec);
            Detail_record.DetailNo := NewNo;
            Detail_record.Insert();

            Page.Run(page::"Detail card", Detail_record);
        end;
    end;

    var
        Rec: Record Detail;
        NewNo: code[20];
}
