page 50803 testpage
{
    ApplicationArea = all;
    UsageCategory = lists;
    Caption = 'Test page';

    layout
    {
        area(content)
        {
            Group("test data")
            {
                field(Date; Date)
                {
                    Caption = 'Date';
                }

                Field(data; data)
                {
                    Caption = 'result';
                    editable = false;
                }

                field(time; time)
                {
                    Caption = 'time example';
                }

                field(time_result; time_result)
                {
                    Caption = 'time reslut';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowWords)
            {
                Caption = 'show in words';
                Tooltip = 'shows the date in the date field written in words';
                ApplicationArea = all;
                Image = Change;

                trigger OnAction()
                begin
                    Code.DateToWords(Date, Data, false, 'I');
                end;
            }

            action(ShowTime)
            {
                Caption = 'show time';
                Tooltip = 'shows time ritten in words';
                ApplicationArea = All;
                Image = Change;

                trigger OnAction()
                begin
                    time_result := Code_time.Transform_time(time);
                end;
            }
        }
    }


    var
        Code: codeunit HDTBaseConvertToWords;
        Code_time: codeunit "Time converter";
        Date: date;
        data: text[300];
        time_result: text;
        time: time;
}