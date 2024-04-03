Table 60101 Weather
{
    Caption = 'Weather';
    TableType = Normal;
    fields
    {
        field(1; "No."; code[20])
        {
            Caption = 'Line number';
        }

        field(2; "temp"; Text[40])
        {
            Caption = 'Temperature';
        }

        field(3; "wind"; Text[40])
        {
            Caption = 'wind speed';
        }

        field(4; "Date"; Date)
        {
            Caption = 'Forecast Date and Time';
        }
    }
}