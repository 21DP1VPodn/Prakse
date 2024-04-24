page 50802 "JS test page"
{
    ApplicationArea = all;
    PageType = card;
    Caption = 'Test page';
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            usercontrol(Demo; "Test")
            {
                trigger OnControlReady()
                begin
                    Control.initialize(CurrPage.Demo);
                    Logic.initialize(Control);
                end;

                trigger OnInvoke(Context: Text)
                var
                    Response: JsonObject;
                begin
                    if confirm('Invoking?') then;
                    Logic.OnInvokeResult('Hello ' + Context + '!');
                end;
            }
        }
    }

    var
        Control: Codeunit "Interface codeunit";

        Logic: codeunit "Demo logic";
}