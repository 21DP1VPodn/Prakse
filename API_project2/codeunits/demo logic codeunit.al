codeunit 50801 "Demo logic"
{
    procedure initialize(Handler2: Interface "Demo controll add-in")
    begin
        Handler := Handler2;
    end;

    procedure OnInvokeResult(Reslut: Text)
    begin
        Handler.OnInvokeResult(Reslut);
    end;


    var
        Handler: Interface "Demo controll add-in";
}