codeunit 75010 "SDH Customer Data Generator"
{
    trigger OnRun()
    var
        Customer: Record Customer;
        Item: Record Item;
        SDHCustDataGen: Record "SDH Cust. Data Gen.";
        SDHUtilities: Codeunit "SDH Utilities";
        NoOfMonths: Integer;
        MonthNo: Integer;
    begin
        SDHCustDataGen.FindFirst();

        Customer.SetFilter("No.", SDHUtilities.GetTableView(Database::Customer));
        Item.SetFilter("No.", SDHUtilities.GetTableView(Database::Item));

        NoOfMonths := SDHUtilities.CalculateMonthBetweenTwoDate(SDHCustDataGen."Start Date", SDHCustDataGen."End Date");
        if NoOfMonths = 0 then
            NoOfMonths := 1;

        // For each customer
        if Customer.FindSet() then
            repeat
                for MonthNo := 1 to NoOfMonths do begin
                    if SDHCustDataGen."Orders Per Month" <> 0 then
                        GenerateSalesOrders(CalcDate(StrSubstNo('<+%1M>', MonthNo), SDHCustDataGen."Start Date"), SDHCustDataGen, Customer, Item);

                    if SDHCustDataGen."Posted Invoices Per Month" <> 0 then
                        GenerateSalesInvoices(CalcDate(StrSubstNo('<+%1M>', MonthNo), SDHCustDataGen."Start Date"), SDHCustDataGen, Customer, Item);
                end;
            until Customer.Next() = 0;
    end;

    local procedure GenerateSalesOrders(WhichDate: Date; var SDHCustDataGen: Record "SDH Cust. Data Gen."; var Customer: Record Customer; var Item: Record Item)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibrarySales: Codeunit "Library - Sales";
        LibraryRandom: Codeunit "Library - Random";
    begin
        LibrarySales.CreateSalesHeader(SalesHeader, Enum::"Sales Document Type"::Order, Customer."No.");
        SalesHeader.Validate("Posting Date", WhichDate);
        SalesHeader.Modify();
        if Item.FindSet() then
            repeat
                LibrarySales.CreateSalesLine(SalesLine, SalesHeader,
                  Enum::"Sales Line Type"::Item, Item."No.",
                  LibraryRandom.RandIntInRange(SDHCustDataGen."Minimum Item Quantity", SDHCustDataGen."Maximum Item Quantity"));
            until Item.Next() = 0;
    end;

    local procedure GenerateSalesInvoices(WhichDate: Date; var SDHCustDataGen: Record "SDH Cust. Data Gen."; var Customer: Record Customer; var Item: Record Item)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibrarySales: Codeunit "Library - Sales";
        LibraryRandom: Codeunit "Library - Random";
    begin
        LibrarySales.CreateSalesHeader(SalesHeader, Enum::"Sales Document Type"::Order, Customer."No.");
        SalesHeader.Validate("Posting Date", WhichDate);
        SalesHeader.Modify();
        if Item.FindSet() then
            repeat
                LibrarySales.CreateSalesLine(SalesLine, SalesHeader,
                  Enum::"Sales Line Type"::Item, Item."No.",
                  LibraryRandom.RandIntInRange(SDHCustDataGen."Minimum Item Quantity", SDHCustDataGen."Maximum Item Quantity"));
            until Item.Next() = 0;
        LibrarySales.ReopenSalesDocument(SalesHeader);
        LibrarySales.PostSalesDocument(SalesHeader, true, true);
    end;
}
