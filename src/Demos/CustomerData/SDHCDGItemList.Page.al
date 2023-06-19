page 75012 "SDH CDG Item List"
{
    Caption = 'Select Item(s)';
    PageType = ListPart;
    SourceTable = Item;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the item.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies what you are selling.';
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ToolTip = 'Specifies the unit in which the item is held in inventory. The base unit of measure also serves as the conversion basis for alternate units of measure.';
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example an item that is placed in quarantine.';
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure GetSelectedItems(var Item: Record Item)
    begin
        CurrPage.SetSelectionFilter(Item);
    end;
}
