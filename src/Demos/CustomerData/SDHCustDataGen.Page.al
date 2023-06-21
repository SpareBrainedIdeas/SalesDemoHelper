page 75010 "SDH Cust. Data Gen."
{
    Caption = 'Customer History Data Generator';
    PageType = Card;
    SourceTable = "SDH Cust. Data Gen.";

    layout
    {
        area(content)
        {
            group(Settings)
            {
                field("Orders Per Month"; Rec."Orders Per Month")
                {
                    ToolTip = 'Specifies the value of the Orders Per Month field.';
                    ApplicationArea = All;
                }
                field("Posted Invoices Per Month"; Rec."Posted Invoices Per Month")
                {
                    ToolTip = 'Specifies the value of the Posted Invoices Per Month field.';
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                    ApplicationArea = All;
                }
                field("Minimum Item Quantity"; Rec."Minimum Item Quantity")
                {
                    ToolTip = 'Specifies the value of the Minimum Item Quantity field.';
                    ApplicationArea = All;
                }
                field("Maximum Item Quantity"; Rec."Maximum Item Quantity")
                {
                    ToolTip = 'Specifies the value of the Maximum Item Quantity field.';
                    ApplicationArea = All;
                }
            }
            part(CustomersList; "SDH CDG Cust. List")
            {
                ApplicationArea = All;
            }
            part(ItemsList; "SDH CDG Item List")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RunHelper)
            {
                Caption = 'Run Helper';
                ApplicationArea = All;
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    RunCustDataHelper();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.GetRecordOnce();
    end;

    procedure RunCustDataHelper()
    var
        Customer: Record Customer;
        Item: Record Item;
    begin
        CurrPage.CustomersList.Page.GetSelectedCustomers(Customer);
        CurrPage.ItemsList.Page.GetSelectedItems(Item);
        Rec.GenerateData(Customer, Item);
    end;
}
