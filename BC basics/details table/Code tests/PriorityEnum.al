Enum 60100 "Priority enum" implements PriorityInterface
{
    Caption = 'Priority Enum';
    Extensible = true;
    DefaultImplementation = PriorityInterface = "Low priority";
    UnknownValueImplementation = PriorityInterface = "Unknown priority";

    value(0; "Low")
    {
        Caption = 'Low priority';
    }

    value(1; "Mid")
    {
        Caption = 'Medium priority';
        Implementation = PriorityInterface = "Medium priority";
    }

    value(2; "High")
    {
        Caption = 'High priority';
        Implementation = PriorityInterface = "High priority";
    }
}