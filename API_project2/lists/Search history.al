page 50800 "Search history"
{
    ApplicationArea = All;
    Caption = 'Search history';
    PageType = List;
    SourceTable = "Search history table";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(ID; Rec.ID)
                {
                    Caption = 'ID';
                }

                field(artist; Rec.artist)
                {
                    Caption = 'artist';
                }

                field(song; Rec.song)
                {
                    Caption = 'song';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Add forecast")
            {
                ApplicationArea = All;
                Caption = 'search lyrics';
                Image = ChartOfAccounts;
                Tooltip = 'searches for lyrics of a specified song';
                trigger OnAction()
                var
                    Dialog: page "Dialog page";
                begin
                    Dialog.RunModal();
                end;
            }
        }
    }
}
