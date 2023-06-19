page 75001 "SDH Sales Demo Helper Info"
{
    Caption = 'SDH Sales Demo Helper Info';
    PageType = CardPart;
    SourceTable = "SDH Sales Demo Helper";
    Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;
                field("Helper Description"; Rec."Helper Description")
                {
                    ShowCaption = false;
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field(ScriptUrlExample; SampleScriptUrl)
                {
                    ShowCaption = false;
                    ApplicationArea = All;

                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                        Message('This could point to a URL PDF/Doc')
                    end;
                }

                field(DeckUrlExample; DeckUrl)
                {
                    ShowCaption = false;
                    ApplicationArea = All;

                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                        Message('This could point to a URL PDF/PowerPoint')
                    end;
                }
            }
        }
    }

    var
        SampleScriptUrl: Text;
        DeckUrl: Text;

    trigger OnOpenPage()
    begin
        SampleScriptUrl := 'Open Demo Script (Sharepoint)';
        DeckUrl := 'Open Slide Deck (Sharepoint)';
    end;
}
