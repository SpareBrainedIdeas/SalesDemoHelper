page 75020 "SDH Item Generate"
{
    Caption = 'Item Generator';
    PageType = List;
    SourceTable = "SDH Item Generate";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Base Unit of Measure field.';
                    ApplicationArea = All;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Sales Unit of Measure field.';
                    ApplicationArea = All;
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Purch. Unit of Measure field.';
                    ApplicationArea = All;
                }
                field("Item Cost Minumum"; Rec."Item Cost Minumum")
                {
                    ToolTip = 'Specifies the value of the Item Cost Minumum field.';
                    ApplicationArea = All;
                }
                field("Cost Maximum"; Rec."Item Cost Maximum")
                {
                    ToolTip = 'Specifies the value of the Cost Maximum field.';
                    ApplicationArea = All;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    ToolTip = 'Specifies the value of the Costing Method field.';
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    ToolTip = 'Specifies the value of the Price field.';
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ToolTip = 'Specifies the value of the Inventory Posting Group field.';
                    ApplicationArea = All;
                }
                field("Stock Start Date"; Rec."Stock Start Date")
                {
                    ToolTip = 'Specifies the value of the Stock Start Date field.';
                    ApplicationArea = All;
                }
                field("Stock End Date"; Rec."Stock End Date")
                {
                    ToolTip = 'Specifies the value of the Stock End Date field.';
                    ApplicationArea = All;
                }
                field("Stock Period Step"; Rec."Stock Period Step")
                {
                    ToolTip = 'Specifies the value of the Stock Period Step field.';
                    ApplicationArea = All;
                }
                field("Stock Minimum Quantity"; Rec."Stock Minimum Quantity")
                {
                    ToolTip = 'Specifies the value of the Stock Minimum Quantity field.';
                    ApplicationArea = All;
                }
                field("Stock Maximum Quantity"; Rec."Stock Maximum Quantity")
                {
                    ToolTip = 'Specifies the value of the Stock Maximum Quantity field.';
                    ApplicationArea = All;
                }
                field("Purchase Start Date"; Rec."Purchase Start Date")
                {
                    ToolTip = 'Specifies the value of the Purchase Start Date field.';
                    ApplicationArea = All;
                }
                field("Purchase End Date"; Rec."Purchase End Date")
                {
                    ToolTip = 'Specifies the value of the Purchase End Date field.';
                    ApplicationArea = All;
                }
                field("Purchase Period Step"; Rec."Purchase Period Step")
                {
                    ToolTip = 'Specifies the value of the Purchase Period Step field.';
                    ApplicationArea = All;
                }
                field("Purchase Minimum Quantity"; Rec."Purchase Minimum Quantity")
                {
                    ToolTip = 'Specifies the value of the Purchase Minimum Quantity field.';
                    ApplicationArea = All;
                }
                field("Purchase Maximum Quantity"; Rec."Purchase Maximum Quantity")
                {
                    ToolTip = 'Specifies the value of the Purchase Maximum Quantity field.';
                    ApplicationArea = All;
                }
                field("Purchase From Vendor"; Rec."Purchase From Vendor")
                {
                    ToolTip = 'Specifies the value of the Purchase From Vendor field.';
                    ApplicationArea = All;
                }
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

                trigger OnAction()
                begin
                    LaunchCustDataHelper();
                end;
            }
        }
    }

    procedure LaunchCustDataHelper()
    var
        SDHItemGenCore: Codeunit "SDH Item Gen. Core";
    begin
        SDHItemGenCore.GenerateData();
    end;
}
