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
                    Message('I am ready to execute!');
                end;

                trigger OnInvoke(Context: JsonObject)
                var
                    Response: JsonObject;
                begin
                    if confirm('Invoking?') then;
                    CurrPage.Demo.OnInvokeResult(Response);
                end;
            }
        }
    }
}