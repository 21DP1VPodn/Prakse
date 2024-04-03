Page 60103 "DemoPage"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(Input)
            {
                Caption = 'Input';
                field(Initialamount; Initialamount)
                {
                    ApplicationArea = All;
                    Tooltip = 'Initial Amount';
                    Caption = 'Initial Amount';

                }

                field(NoOfYears; NoOfYears)
                {
                    ApplicationArea = All;
                }

                field(RateOfInterest; RateOfInterest)
                {
                    ApplicationArea = All;
                }
            }

            group(Output)
            {
                Caption = 'Output';
                field(FinalAmount; FinalAmount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Calculate simple interest")
            {
                ApplicationArea = All;
                Caption = 'Calculate the interest';
                Image = ExecuteBatch;
                Tooltip = 'Interest calculation';
                trigger OnAction()
                begin
                    FinalAmount := InitialAmount * (1 + RateOfInterest * NoOfYears);
                    Message('%1', "FinalAmount");
                end;
            }
        }

        area(Navigation)
        {
            group("More Information")
            {
                Caption = 'More Data';
                group("More Details")
                {
                    action("Customer")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Details';
                        RunObject = page "Customer Card";
                    }
                    action("Sales")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Details';
                        RunObject = page "Sales Analysis View Card";
                    }
                }
            }
        }

        area(Creation)
        {
            action("New Customer")
            {
                Image = Add;
                ApplicationArea = All;
                RunObject = page "Customer Card";
            }
        }
    }

    var
        InitialAmount: Decimal;
        NoOfYears: Integer;
        RateOfInterest: Decimal;
        FinalAmount: Decimal;
}