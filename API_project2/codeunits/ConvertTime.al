codeunit 50803 "Time converter"
{
    trigger OnRun()
    begin
        output := Transform_time(Time);
    end;

    procedure Transform_time(Time: time): Text[100]
    var
        Hours: Text;
        Minutes: Text;
        Connector: Text;
        Timestamp: Text;
        Clock: text;
        hours_result: text;
        minutes_result: text;
        result: text;
        index: integer;
        index_minutes: integer;
    begin
        Clock := 'o clock';
        Hours := Format(Time, 0, '<Hours12>');
        Minutes := Format(Time, 0, '<Minutes,2>');
        Timestamp := Format(Time, 0, '<AM/PM>');
        InitHour();
        If Hours = '12' then begin
            if Timestamp = 'AM' then begin
                hours_result := HoursText[12];
            end;
            if Timestamp = 'PM' then begin
                hours_result := HoursText[13];
            end;
        end
        else begin
            Evaluate(index, Hours);
            Hours_result := HoursText[index];
        end;
        InitMinutes();
        if Minutes = '00' then begin
            minutes_result := MinutesText[31];
            Connector := '';
        end
        else begin
            Evaluate(index_minutes, Minutes);
            if index_minutes <= 30 then begin
                minutes_result := MinutesText[index_minutes];
                Connector := 'past';
            end
            else begin
                index_minutes := index_minutes - 30;
                index_minutes := 30 - index_minutes;
                minutes_result := MinutesText[index_minutes];
                Connector := 'to';
                if (index = 12) or (index = 13) then begin
                    hours_result := HoursText[1];
                    if Timestamp = 'AM' then begin
                        Timestamp := 'PM';
                    end;
                    if Timestamp = 'PM' then begin
                        Timestamp := 'AM';
                    end;
                end
                else begin
                    if (index = 11) and (Timestamp = 'PM') then begin
                        hours_result := HoursText[index + 2];
                    end
                    else begin
                        hours_result := HoursText[index + 1];
                    end;
                end;
            end;
        end;
        if (hours_result = 'Noon') or (hours_result = 'Midnight') then begin
            Timestamp := '';
            Clock := '';
        end;
        if minutes_result = '' then begin
            result := hours_result + ' ' + Timestamp + ' ' + Clock;
        end
        else begin
            result := minutes_result + ' ' + Connector + ' ' + hours_result + ' ' + Timestamp;
        end;
        exit(result);
    end;

    procedure InitHour()
    begin
        HoursText[1] := 'One';
        HoursText[2] := 'Two';
        HoursText[3] := 'Three';
        HoursText[4] := 'Four';
        HoursText[5] := 'Five';
        HoursText[6] := 'Six';
        HoursText[7] := 'Seven';
        HoursText[8] := 'Eight';
        HoursText[9] := 'Nine';
        HoursText[10] := 'Ten';
        HoursText[11] := 'Eleven';
        HoursText[12] := 'Noon';
        HoursText[13] := 'Midnight';
    end;

    procedure InitMinutes()
    begin
        MinutesText[1] := 'one';
        MinutesText[2] := 'two';
        MinutesText[3] := 'three';
        MinutesText[4] := 'four';
        MinutesText[5] := 'five';
        MinutesText[6] := 'six';
        MinutesText[7] := 'seven';
        MinutesText[8] := 'eight';
        MinutesText[9] := 'nine';
        MinutesText[10] := 'ten';
        MinutesText[11] := 'eleven';
        MinutesText[12] := 'twelve';
        MinutesText[13] := 'thirteen';
        MinutesText[14] := 'fourteen';
        MinutesText[15] := 'quarter';
        MinutesText[16] := 'sixteen';
        MinutesText[17] := 'seventeen';
        MinutesText[18] := 'eighteen';
        MinutesText[19] := 'nineteen';
        MinutesText[20] := 'twenty';
        MinutesText[21] := 'twenty-one';
        MinutesText[22] := 'twenty-two';
        MinutesText[23] := 'twenty-three';
        MinutesText[24] := 'twenty-four';
        MinutesText[25] := 'twenty-five';
        MinutesText[26] := 'twenty-six';
        MinutesText[27] := 'twenty-seven';
        MinutesText[28] := 'twenty-eight';
        MinutesText[29] := 'twenty-nine';
        MinutesText[30] := 'half';
        MinutesText[31] := '';
    end;

    var
        Time: time;
        output: Text[100];
        HoursText: array[13] of text[30];
        MinutesText: array[31] of text[30];
}