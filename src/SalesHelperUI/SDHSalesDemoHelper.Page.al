page 75000 "SDH Sales Demo Helper"
{
    ApplicationArea = All;
    Caption = 'Sales Demo Helpers';
    PageType = List;
    SourceTable = "SDH Sales Demo Helper";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Demo Summary"; Rec."Demo Summary")
                {
                    ToolTip = 'Specifies the value of the Demo Summary field.';
                    ApplicationArea = All;
                }
                field("Helper Page Id"; Rec."Helper Page Id")
                {
                    ToolTip = 'Specifies the value of the Helper Page Id field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Helper Codeunit Id"; Rec."Helper Codeunit Id")
                {
                    ToolTip = 'Specifies the value of the Helper Codeunit Id field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }

        area(FactBoxes)
        {
            part(HelperInfo; "SDH Sales Demo Helper Info")
            {
                Caption = 'Information';
                SubPageLink = Id = field(id);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(LaunchHelper)
            {
                Caption = 'Launch Helper';
                ApplicationArea = All;
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Repeater;

                trigger OnAction()
                begin
                    Rec.LaunchHelper();
                end;
            }
        }
    }
}
