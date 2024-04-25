codeunit 50802 "HDTBaseConvertToWords"
{
    trigger OnRun()
    begin
    end;

    var
        GLSetup: Record "General Ledger Setup";
        AndText: Text[30];
        ZeroText: Text[30];
        OnesText: array[19] of Text[30];
        TensText: array[9] of Text[30];
        HundredText1: Text[30];
        HundredTextM: Text[30];
        ExponentText1: array[4] of Text[30];
        ExponentTextM: array[4] of Text[30];
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        AmountText: array[2] of Text[80];
        AmountTextIndex: Integer;
        Exponent: Integer;
        LsText1: Text[30];
        LsTextM: Text[30];
        SantText1: Text[30];
        SantTextM: Text[30];
        Text001: Label 'Invalid Language parameter - In Words codeunit';
        MonthText: array[12] of Text[30];
        YearText: Text[30];
        ForeignCurrency: Record Currency;
        Text002: Label '%1 results in a written number that is too long.';
        NoSpaceNext: Boolean;



    procedure DateToWords(Date: Date; var DateText: Text[250]; Declined: Boolean; Language: Code[1]): Text[250]
    var
        MonthIndex: Integer;
    begin
        if Language in ['T'] then
            Declined := true;
        InitDateTexts(Language, Declined);
        if not Evaluate(MonthIndex, Format(Date, 0, '<Month>')) then begin
            DateText := '';
            exit(DateText);
        end;
        case Language of
            'E':
                DateText := MonthText[MonthIndex] + ' ' + Format(Date, 0, '<Day,2>') + ', ' + Format(Date, 0, '<Year4>');
            'L':
                DateText := Format(Date, 0, '<Year4>') + '. ' + YearText + ' ' + Format(Date, 0, '<Day,2>') + '. ' + MonthText[MonthIndex];
            'I':
                DateText := Format(Date, 0, '<Day,2>') + '. ' + MonthText[MonthIndex] + ' ' + Format(Date, 0, '<Year4>');
            'T':
                DateText := Format(Date, 0, '<Year4>') + ' ' + YearText + ' ' + MonthText[MonthIndex] + ' ' + Format(Date, 0, '<Day,2>') + ' d.';
        end; /*Case*/
        exit(DateText);
    end;

    procedure InitAmountTexts(Language: Code[1])
    begin
        TensText[1] := '';
        ExponentText1[1] := '';
        ExponentTextM[1] := '';
        case Language of
            'I':  // EE
                begin
                    AndText := 'JA';
                    ZeroText := 'NULL';
                    OnesText[1] := 'ÜKS';
                    OnesText[2] := 'KAKS';
                    OnesText[3] := 'KOLM';
                    OnesText[4] := 'NELI';
                    OnesText[5] := 'VIIS';
                    OnesText[6] := 'KUUS';
                    OnesText[7] := 'SEITSE';
                    OnesText[8] := 'KAHEKSA';
                    OnesText[9] := 'ÜHEKSA';
                    OnesText[10] := 'KÜMME';
                    OnesText[11] := 'ÜKSTEIST';
                    OnesText[12] := 'KAKSTEIST';
                    OnesText[13] := 'KOLMTEIST';
                    OnesText[14] := 'NELITEIST';
                    OnesText[15] := 'VIISTEIST';
                    OnesText[16] := 'KUUSTEIST';
                    OnesText[17] := 'SEITSETEIST';
                    OnesText[18] := 'KAHEKSATEIST';
                    OnesText[19] := 'ÜHEKSATEIST';
                    TensText[2] := 'KAKSKÜMMEND';
                    TensText[3] := 'KOLMKÜMMEND';
                    TensText[4] := 'NELIKÜMMEND';
                    TensText[5] := 'VIISKÜMMEND';
                    TensText[6] := 'KUUSKÜMMEND';
                    TensText[7] := 'SEITSEKÜMMEND';
                    TensText[8] := 'KAHEKSAKÜMMEND';
                    TensText[9] := 'ÜHEKSAKÜMMEND';
                    HundredText1 := 'SADA';
                    HundredTextM := 'SADA';
                    ExponentText1[2] := 'TUHAT';
                    ExponentText1[3] := 'MILJON';
                    ExponentText1[4] := 'MILJARD';
                    ExponentTextM[2] := 'TUHAT';
                    ExponentTextM[3] := 'MILJONIT';
                    ExponentTextM[4] := 'MILJARDIT';
                    LsText1 := 'EUROT';
                    LsTextM := 'EUROT';
                    SantText1 := 'SENT';
                    SantTextM := 'SENTI';
                end;
            'T':  // LT
                begin
                    AndText := '';
                    ZeroText := 'NULIS';
                    OnesText[1] := 'VIENAS';
                    OnesText[2] := 'DU';
                    OnesText[3] := 'TRYS';
                    OnesText[4] := 'KETURI';
                    OnesText[5] := 'PENKI';
                    OnesText[6] := 'ŠEŠI';
                    OnesText[7] := 'SEPTYNI';
                    OnesText[8] := 'AŠTUONI';
                    OnesText[9] := 'DEVYNI';
                    OnesText[10] := 'DEŠIMT';
                    OnesText[11] := 'VIENUOLIKA';
                    OnesText[12] := 'DVYLIKA';
                    OnesText[13] := 'TRYLIKA';
                    OnesText[14] := 'KETURIOLIKA';
                    OnesText[15] := 'PENKIOLIKA';
                    OnesText[16] := 'ŠEŠIOLIKA';
                    OnesText[17] := 'SEPTYNIOLIKA';
                    OnesText[18] := 'AŠTUONIOLIKA';
                    OnesText[19] := 'DEVYNIOLIKA';
                    TensText[2] := 'DVIDEŠIMT';
                    TensText[3] := 'TRISDEŠIMT';
                    TensText[4] := 'KETURIASDEŠIMT';
                    TensText[5] := 'PENKIASDEŠIMT';
                    TensText[6] := 'ŠEŠIASDEŠIMT';
                    TensText[7] := 'SEPTYNIASDEŠIMT';
                    TensText[8] := 'AŠTUONIASDEŠIMT';
                    TensText[9] := 'DEVYNIASDEŠIMT';
                    HundredText1 := 'ŠIMTAS';
                    HundredTextM := 'ŠIMTAI';
                    ExponentText1[2] := 'TŪKSTANTIS';
                    ExponentText1[3] := 'MILIJONAS';
                    ExponentText1[4] := 'MILIJARDAS';
                    ExponentTextM[2] := 'TŪKSTANČIŲ';
                    ExponentTextM[3] := 'MILIJONAI';
                    ExponentTextM[4] := 'MILIJARDAI';
                    /*HD.AL04:
                        LsText1 := 'Lt.';
                        LsTextM := 'Lt.';
                        SantText1 := 'Ct.';
                        SantTextM := 'Ct.';
                    HD.AL04*/
                    LsText1 := 'EUR';
                    LsTextM := 'EUR';
                    SantText1 := 'ct.';
                    SantTextM := 'ct.';
                end;
            'E':  // EN
                begin
                    AndText := 'AND';
                    ZeroText := 'ZERO';
                    OnesText[1] := 'ONE';
                    OnesText[2] := 'TWO';
                    OnesText[3] := 'THREE';
                    OnesText[4] := 'FOUR';
                    OnesText[5] := 'FIVE';
                    OnesText[6] := 'SIX';
                    OnesText[7] := 'SEVEN';
                    OnesText[8] := 'EIGHT';
                    OnesText[9] := 'NINE';
                    OnesText[10] := 'TEN';
                    OnesText[11] := 'ELEVEN';
                    OnesText[12] := 'TWELVE';
                    OnesText[13] := 'THIRTEEN';
                    OnesText[14] := 'FOURTEEN';
                    OnesText[15] := 'FIFTEEN';
                    OnesText[16] := 'SIXTEEN';
                    OnesText[17] := 'SEVENTEEN';
                    OnesText[18] := 'EIGHTEEN';
                    OnesText[19] := 'NINETEEN';
                    TensText[2] := 'TWENTY';
                    TensText[3] := 'THIRTY';
                    TensText[4] := 'FORTY';
                    TensText[5] := 'FIFTY';
                    TensText[6] := 'SIXTY';
                    TensText[7] := 'SEVENTY';
                    TensText[8] := 'EIGHTY';
                    TensText[9] := 'NINETY';
                    HundredText1 := 'HUNDRED';
                    HundredTextM := HundredText1;
                    ExponentText1[2] := 'THOUSAND';
                    ExponentText1[3] := 'MILLION';
                    ExponentText1[4] := 'BILLION';
                    ExponentTextM[2] := ExponentText1[2];
                    ExponentTextM[3] := ExponentText1[3];
                    ExponentTextM[4] := ExponentText1[4];
                    GLSetup.Get;
                    case GLSetup."LCY Code" of
                        'LVL':
                            begin
                                LsText1 := 'LAT';
                                LsTextM := 'LATS';
                                SantText1 := 'SANTIME';
                                SantTextM := 'SANTIMES';
                            end;
                        'LTL':
                            begin
                                LsText1 := 'Lt.';
                                LsTextM := 'Lt.';
                                SantText1 := 'Ct.';
                                SantTextM := 'Ct.';
                            end;
                        'EUR':
                            begin
                                LsText1 := 'EUR';
                                LsTextM := 'EUR';
                                SantText1 := 'CENT';
                                SantTextM := 'CENTS';
                            end;
                        else
                            LsText1 := '---';
                            LsTextM := '---';
                            SantText1 := '---';
                            SantTextM := '---';
                    end;
                end;
            'L':  // LV
                begin
                    AndText := 'UN';
                    ZeroText := 'NULLE';
                    OnesText[1] := 'VIENS';
                    OnesText[2] := 'DIVI';
                    OnesText[3] := 'TRĪS';
                    OnesText[4] := 'ČETRI';
                    OnesText[5] := 'PIECI';
                    OnesText[6] := 'SEŠI';
                    OnesText[7] := 'SEPTIŅI';
                    OnesText[8] := 'ASTOŅI';
                    OnesText[9] := 'DEVIŅI';
                    OnesText[10] := 'DESMIT';
                    OnesText[11] := 'VIENPADSMIT';
                    OnesText[12] := 'DIVPADSMIT';
                    OnesText[13] := 'TRĪSPADSMIT';
                    OnesText[14] := 'ČETRPADSMIT';
                    OnesText[15] := 'PIECPADSMIT';
                    OnesText[16] := 'SEŠPADSMIT';
                    OnesText[17] := 'SEPTIŅPADSMIT';
                    OnesText[18] := 'ASTOŅPADSMIT';
                    OnesText[19] := 'DEVIŅPADSMIT';
                    TensText[2] := 'DIVDESMIT';
                    TensText[3] := 'TRĪSDESMIT';
                    TensText[4] := 'ČETRDESMIT';
                    TensText[5] := 'PIECDESMIT';
                    TensText[6] := 'SEŠDESMIT';
                    TensText[7] := 'SEPTIŅDESMIT';
                    TensText[8] := 'ASTOŅDESMIT';
                    TensText[9] := 'DEVIŅDESMIT';
                    HundredText1 := 'SIMTS';
                    HundredTextM := 'SIMTI';
                    ExponentText1[2] := 'TŪKSTOTIS';
                    ExponentText1[3] := 'MILJONS';
                    ExponentText1[4] := 'MILJARDS';
                    ExponentTextM[2] := 'TŪKSTOŠI';
                    ExponentTextM[3] := 'MILJONI';
                    ExponentTextM[4] := 'MILJARDI';
                    //HD.KV->
                    /*LsText1 := 'LATS';
                    LsTextM := 'LATI';
                    SantText1 := 'SANTĪMS';
                    SantTextM := 'SANTĪMI'; */
                    GLSetup.Get;
                    case GLSetup."LCY Code" of
                        'LVL':
                            begin
                                LsText1 := 'LATS';
                                LsTextM := 'LATI';
                                SantText1 := 'SANTĪMS';
                                SantTextM := 'SANTĪMI';
                            end;
                        'EUR':
                            begin
                                LsText1 := 'EURO';
                                LsTextM := 'EURO';
                                SantText1 := 'CENTS';
                                SantTextM := 'CENTI';
                            end;
                        else
                            LsText1 := '---';
                            LsTextM := '---';
                            SantText1 := '---';
                            SantTextM := '---';
                    end;
                    //<-HD.KV
                end;
            else
                Error(Text001);
        end; /*Case*/
    end;

    procedure InitDateTexts(Language: Code[1]; Declined: Boolean)
    begin
        case Language of
            'E':  // EN
                begin
                    YearText := 'Year';
                    MonthText[1] := 'January';
                    MonthText[2] := 'February';
                    MonthText[3] := 'March';
                    MonthText[4] := 'April';
                    MonthText[5] := 'May';
                    MonthText[6] := 'June';
                    MonthText[7] := 'July';
                    MonthText[8] := 'August';
                    MonthText[9] := 'September';
                    MonthText[10] := 'October';
                    MonthText[11] := 'November';
                    MonthText[12] := 'December';
                end;
            'L':
                begin
                    YearText := 'gada';
                    if Declined then begin
                        MonthText[1] := 'janvārī';
                        MonthText[2] := 'februārī';
                        MonthText[3] := 'martā';
                        MonthText[4] := 'aprīlī';
                        MonthText[5] := 'maijā';
                        MonthText[6] := 'jūnijā';
                        MonthText[7] := 'jūlijā';
                        MonthText[8] := 'augustā';
                        MonthText[9] := 'septembrī';
                        MonthText[10] := 'oktobrī';
                        MonthText[11] := 'novembrī';
                        MonthText[12] := 'decembrī';
                    end else begin
                        MonthText[1] := 'janvāris';
                        MonthText[2] := 'februāris';
                        MonthText[3] := 'marts';
                        MonthText[4] := 'aprīlis';
                        MonthText[5] := 'maijs';
                        MonthText[6] := 'jūnijs';
                        MonthText[7] := 'jūlijs';
                        MonthText[8] := 'augusts';
                        MonthText[9] := 'septembris';
                        MonthText[10] := 'oktobris';
                        MonthText[11] := 'novembris';
                        MonthText[12] := 'decembris';
                    end;
                end;
            'T':  // LT
                begin
                    YearText := 'm.';  // 'metų';
                    if Declined then begin
                        MonthText[1] := 'sausio mėn.';
                        MonthText[2] := 'vasario mėn.';
                        MonthText[3] := 'kovo mėn.';
                        MonthText[4] := 'balandžio mėn.';
                        MonthText[5] := 'gegužės mėn.';
                        MonthText[6] := 'birželio mėn.';
                        MonthText[7] := 'liepos mėn.';
                        MonthText[8] := 'rugpjūčio mėn.';
                        MonthText[9] := 'rugsėjo mėn.';
                        MonthText[10] := 'spalio mėn.';
                        MonthText[11] := 'lapkričio mėn.';
                        MonthText[12] := 'gruodžio mėn.';
                    end else begin
                        MonthText[1] := 'sausis';
                        MonthText[2] := 'vasaris';
                        MonthText[3] := 'kovas';
                        MonthText[4] := 'balandis';
                        MonthText[5] := 'gegužė';
                        MonthText[6] := 'birželis';
                        MonthText[7] := 'liepa';
                        MonthText[8] := 'rugpjūtis';
                        MonthText[9] := 'rugsėjis';
                        MonthText[10] := 'spalis';
                        MonthText[11] := 'lapkritis';
                        MonthText[12] := 'gruodis';
                    end;
                end;
            'I':  // EE
                begin
                    YearText := 'aasta';
                    if Declined then begin
                        MonthText[1] := 'jaanuaris';
                        MonthText[2] := 'veebruaris';
                        MonthText[3] := 'märtsis';
                        MonthText[4] := 'aprillis';
                        MonthText[5] := 'mais';
                        MonthText[6] := 'juunis';
                        MonthText[7] := 'juulis';
                        MonthText[8] := 'augustis';
                        MonthText[9] := 'septembris';
                        MonthText[10] := 'oktoobris';
                        MonthText[11] := 'novembris';
                        MonthText[12] := 'detsembris';
                    end else begin
                        MonthText[1] := 'jaanuar';
                        MonthText[2] := 'veebruar';
                        MonthText[3] := 'märts';
                        MonthText[4] := 'aprill';
                        MonthText[5] := 'mai';
                        MonthText[6] := 'juuni';
                        MonthText[7] := 'juuli';
                        MonthText[8] := 'august';
                        MonthText[9] := 'september';
                        MonthText[10] := 'oktoober';
                        MonthText[11] := 'november';
                        MonthText[12] := 'detsember';
                    end;
                end;
            else
                Error(Text001);
        end; /*Case*/
    end;
}
