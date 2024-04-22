codeunit 60102 "Low priority" implements PriorityInterface
{
    procedure GetPriority(): Text
    begin
        exit('Needs to be delivered monthly');
    end;
}