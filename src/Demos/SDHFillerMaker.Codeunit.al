codeunit 75003 "SDH Filler Maker"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SDH Install", 'OnInstallSalesDemoHelper', '', false, false)]
    local procedure SelfRegisterHelper()
    var
        SDHSalesDemoHelper: Record "SDH Sales Demo Helper";
        DoInsert: Boolean;
    begin
        GenerateFillerHelper('ZZ-01', 'Generate Warehouse Shipping Demo', 'This helper could create a wide array of Sales Orders, Purchase Returns, and Transfer Orders for a Warehouse Location.');
        GenerateFillerHelper('ZZ-02', 'Generate Items with Serials', 'This helper could create Items with Item Tracking set to serial, along with adjust in some stock, create Sales Orders for same.');
        GenerateFillerHelper('ZZ-03', 'Generate Service Information', 'This helper could create Service Items, Orders, and Contracts');
        GenerateFillerHelper('ZZ-04', 'Generate Accounts Payables', 'This helper could create a wide array of invoices to pay over periods of time to test Vendor Suggest Payments.');
        GenerateFillerHelper('ZZ-05', 'Generate Item Demand', 'This helper could create historical and future demand for demonstrating Sales Forecasts and other Demand Fulfillment steps.');
        GenerateFillerHelper('ZZ-06', 'Generate Production Items and Orders', 'This helper could create a full Manufacturing demonstration.');
        GenerateFillerHelper('ZZ-07', 'Generate Transfer Orders', 'This helper could create Transfer Orders for various locations.');
        GenerateFillerHelper('ZZ-08', 'Generate G/L Usage and Budgets', 'This helper could demonstrate how Budgets VS Actuals could work in various reports.');
    end;

    procedure GenerateFillerHelper(HelperId: Text[50]; Summary: Text[200]; NewDescription: Text)
    var
        SDHSalesDemoHelper: Record "SDH Sales Demo Helper";
        DoInsert: Boolean;
    begin
        SDHSalesDemoHelper.SetRange("Demo Summary", Summary);
        DoInsert := SDHSalesDemoHelper.IsEmpty;
        SDHSalesDemoHelper.Id := HelperId;
        SDHSalesDemoHelper."Helper Page Id" := 0;
        SDHSalesDemoHelper."Helper Codeunit Id" := 0;
        SDHSalesDemoHelper."Demo Summary" := Summary;
        SDHSalesDemoHelper."Helper Description" := NewDescription;
        if DoInsert then
            SDHSalesDemoHelper.Insert()
        else
            SDHSalesDemoHelper.Modify();
    end;
}
