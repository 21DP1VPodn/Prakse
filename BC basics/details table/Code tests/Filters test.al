pageextension 60100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        GL: Record "G/L Entry";
        D: Date;
    begin
        D := 20220505D;
        GL.SetFilter("Posting Date", '%1', D);
        GL.SetRange("Posting Date", D);
    end;
}