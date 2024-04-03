table 60100 Detail
{
    Caption = 'Detail';
    TableType = Normal;

    fields
    {
        field(1; DetailNo; Code[20])
        {
            Caption = 'Detail number';
        }

        field(2; Code; Text[11])
        {
            Caption = 'Code';
        }

        field(3; ManufactorerNo; Code[20])
        {
            Caption = 'Manufactorer number';
            TableRelation = Manufacturer."Code";
        }

        field(4; ManufacturerName; Text[100])
        {
            Caption = 'Manufactorer name';
            FieldClass = FlowField;
            CalcFormula = lookup(Manufacturer."Name" where("Code" = field(ManufactorerNo)));
            Editable = false;
        }

        field(5; "AtrašanasValsts"; Enum "Atrašanas valsts")
        {
            Caption = 'Atrašanas Vlasts';
        }

        field(6; "City"; Text[50])
        {
            Caption = 'pilseta';
            TableRelation = City.No where("Atrašanas valsts" = field("AtrašanasValsts"));
        }

        field(7; "Pilseta"; Text[50])
        {
            FieldClass = FlowField;
            Caption = 'pilseta';
            TableRelation = City.No;
            CalcFormula = lookup(City.Name where("No" = field(City)));
        }
    }

    keys
    {
        key(PK; DetailNo)
        {

        }
    }
    /*
        trigger OnInsert()
        var
            NumberSeriesMgt: Codeunit NoSeriesManagement;
            NewNoSeriesCode: Code[20];
        begin
            if rec.DetailNo = '' then
                NumberSeriesMgt.InitSeries('Detail', '', Today(), DetailNo, NewNoSeriesCode);
        end;
        */
}