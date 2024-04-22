codeunit 60104 "High priority" implements PriorityInterface
{
    procedure GetPriority(): Text
    begin
        exit('Needs to be delivered daily');
    end;
}