codeunit 60101 "Keys"
{

    trigger OnRun()
    begin
        Setkey()
    end;

    procedure Setkey()
    begin
        IsolatedStorage.set('key', 'f2bde0bbf710401c9e770016240304', DataScope::Module);
    end;

}