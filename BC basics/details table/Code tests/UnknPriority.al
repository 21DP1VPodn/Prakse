codeunit 60105 "Unknown priority" implements PriorityInterface
{
    procedure GetPriority(): Text
    begin
        exit('Something went wrong, please specify a new priority for this item');
    end;
}