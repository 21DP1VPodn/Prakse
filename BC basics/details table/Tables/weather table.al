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

        field(2; City; Text[50])
        {
            Caption = 'City';
        }
        field(3; "temp"; Text[40])
        {
            Caption = 'Temperature';
        }

        field(4; "wind"; Text[40])
        {
            Caption = 'wind speed';
        }

        field(5; "Date"; Date)
        {
            Caption = 'Forecast Date and Time';
        }
    }
}