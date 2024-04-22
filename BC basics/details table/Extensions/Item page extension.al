pageextension 60101 "Item page extension" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("Priority enum"; Rec."Priority enum")
            {
                Caption = 'priority';
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action("Get priority")
            {
                Caption = 'Get priority';
                ApplicationArea = All;
                Image = AboutNav;

                trigger OnAction()
                var
                    Priority: Interface PriorityInterface;
                begin
                    Priority := Rec."Priority enum";
                    Message(Priority.GetPriority());
                end;
            }
        }
    }
}
