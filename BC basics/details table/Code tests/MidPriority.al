codeunit 60103 "Medium priority" implements PriorityInterface
{
    procedure GetPriority(): Text
    begin
        exit('Needs to be delivered weekly');
    end;
}