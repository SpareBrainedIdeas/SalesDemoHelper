page 75011 "SDH CDG Cust. List"
{
    Caption = 'Select Customer(s)';
    PageType = ListPart;
    SourceTable = Customer;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the customer''s name.';
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ToolTip = 'Specifies the customer''s market type to link business transactions to.';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the default currency for the customer.';
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies which transactions with the customer that cannot be processed, for example, because the customer is insolvent.';
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure GetSelectedCustomers(var Customer: Record Customer)
    begin
        CurrPage.SetSelectionFilter(Customer);
    end;
}
