codeunit 50803 "Time converter"
{

    //Šis codeunit pārveido laiku no time uz tekst pierakstīto ar vārdiem
    trigger OnRun()
    begin
        output := Transform_time(Time, Code);
    end;

    procedure Transform_time(Time: time; Code: code[1]): Text[100]
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
        // nosakam default variables
        Clock := 'o clock';
        Hours := Format(Time, 0, '<Hours12>');
        Minutes := Format(Time, 0, '<Minutes,2>');
        Timestamp := Format(Time, 0, '<AM/PM>');

        //Output like human
        if Code = 'H' then begin // like human
            // nosakam stundu pieraksti ar vārdiem
            InitHour(Code);
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
            // nosakam minūtu pierkasti ar vardiem
            InitMinutes(Code);
            if Minutes = '00' then begin
                minutes_result := MinutesText[31];
                Connector := '';
            end
            else begin
                // nosakam minutes kas ir mazākas par 30
                Evaluate(index_minutes, Minutes);
                if index_minutes <= 30 then begin
                    minutes_result := MinutesText[index_minutes];
                    Connector := 'past';
                end
                // nosakam minūtes kas ir lielākas par 30, skaitļojot stundu un dienas puses parveršanu pareizi pierakstei
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
            // nosākam rezultātu ja kods ir H(human)
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
        end;

        //Output like Computer
        if Code = 'C' then begin // like computer
            InitHour(Code);
            // nosakam stundu skaitu
            if Hours = '00' then
                hours_result := HoursText[13]
            else begin
                Evaluate(index, Hours);
                hours_result := HoursText[index];
            end;
            // nosakam minušu skaitu
            InitMinutes(Code);
            if Minutes = '00' then
                minutes_result := MinutesText[60]
            else begin
                Evaluate(index_minutes, Minutes);
                minutes_result := MinutesText[index_minutes];
            end;
            // nosakam rezultātu ja kods ir C(computer)
            if (Hours = '12') and (Minutes = '00') and (Timestamp = 'AM') then
                result := 'Noon'
            else begin
                if (Hours = '12') and (Minutes = '00') and (Timestamp = 'PM') then
                    result := 'Midnight'
                else begin
                    if Minutes = '00' then
                        result := hours_result + ' ' + Clock + ' ' + LowerCase(Timestamp)
                    else
                        result := hours_result + ' ' + Clock + ', ' + minutes_result + ' ' + LowerCase(Timestamp);
                end;
            end;
        end;
        // Izvadam rezultātu
        message(result);
    end;

    // Šī procedūra definē stundu pieraksti ar vārdiem
    procedure InitHour(Code: code[1])
    begin
        Case Code of
            'H': // pierakste like human
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
            'C': // pierakste like computer
                begin
                    HoursText[1] := 'one';
                    HoursText[2] := 'two';
                    HoursText[3] := 'three';
                    HoursText[4] := 'four';
                    HoursText[5] := 'five';
                    HoursText[6] := 'six';
                    HoursText[7] := 'seven';
                    HoursText[8] := 'eight';
                    HoursText[9] := 'nine';
                    HoursText[10] := 'ten';
                    HoursText[11] := 'eleven';
                    HoursText[12] := 'twelve';
                    HoursText[13] := 'zero';
                End;
        end;
    end;

    // Šī procedūra definē stundu pieraksti ar vārdiem
    procedure InitMinutes(Code: code[1])
    begin
        Case code of
            'H': // pierakste like human
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
            'C': // pierakste like computer
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
                    MinutesText[15] := 'fifteen';
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
                    MinutesText[30] := 'thirty';
                    MinutesText[31] := 'thirty-one';
                    MinutesText[32] := 'thirty-two';
                    MinutesText[33] := 'thirty-three';
                    MinutesText[34] := 'thirty-four';
                    MinutesText[35] := 'thirty-five';
                    MinutesText[36] := 'thirty-six';
                    MinutesText[37] := 'thirty-seven';
                    MinutesText[38] := 'thirty-eight';
                    MinutesText[39] := 'thirty-nine';
                    MinutesText[40] := 'fourty';
                    MinutesText[41] := 'fourty-one';
                    MinutesText[42] := 'fourty-two';
                    MinutesText[43] := 'fourty-three';
                    MinutesText[44] := 'fourty-four';
                    MinutesText[45] := 'fourty-five';
                    MinutesText[46] := 'fourty-six';
                    MinutesText[47] := 'fourty-seven';
                    MinutesText[48] := 'fourty-eight';
                    MinutesText[49] := 'fourty-nine';
                    MinutesText[50] := 'fifty';
                    MinutesText[51] := 'fifty-one';
                    MinutesText[52] := 'fifty-two';
                    MinutesText[53] := 'fifty-three';
                    MinutesText[54] := 'fifty-four';
                    MinutesText[55] := 'fifty-five';
                    MinutesText[56] := 'fifty-six';
                    MinutesText[57] := 'fifty-seven';
                    MinutesText[58] := 'fifty-eight';
                    MinutesText[59] := 'fifty-nine';
                    MinutesText[60] := '';
                end;
        End;
    end;
    // globālo mainīgu skaraksts
    var
        Time: time;
        output: Text[100];
        HoursText: array[13] of text[30];
        MinutesText: array[60] of text[30];
        Code: code[1];
}