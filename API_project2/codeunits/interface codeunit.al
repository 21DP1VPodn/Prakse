codeunit 50800 "Interface codeunit" implements "Demo controll add-in"
{
    procedure initialize(Control2: ControlAddIn Test)
    begin
        Control := Control2;
    end;

    procedure OnControlReady()
    begin

    end;

    procedure OnInvoke(Context: Text)
    begin

    end;

    procedure OnInvokeResult(Reslut: Text)
    begin
        Control.OnInvokeResult(Reslut);
    end;

    var
        Control: ControlAddIn Test;
}