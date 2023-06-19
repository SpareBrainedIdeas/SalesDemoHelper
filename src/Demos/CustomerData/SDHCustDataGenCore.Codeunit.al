codeunit 75011 "SDH Cust. Data Gen. Core"
{
    procedure GenerateData(var Rec: Record "SDH Cust. Data Gen."; var Customer: Record Customer; var Item: Record Item)
    var
        SDHSalesDemoHelper: Record "SDH Sales Demo Helper";
        SDHDemoRunner: Codeunit "SDH Demo Runner";
        SDHUtilities: Codeunit "SDH Utilities";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        SDHUtilities.StoreTableView(Database::Customer, SelectionFilterManagement.GetSelectionFilterForCustomer(Customer));
        SDHUtilities.StoreTableView(Database::Item, SelectionFilterManagement.GetSelectionFilterForItem(Item));

        SDHSalesDemoHelper.SetRange("Helper Codeunit Id", Codeunit::"SDH Customer Data Generator");
        SDHSalesDemoHelper.FindFirst();
        SDHSalesDemoHelper."To Run" := true;
        SDHSalesDemoHelper.Modify();
        Commit();

        Clear(SDHDemoRunner);
        SDHDemoRunner.Run();
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SDH Install", 'OnInstallSalesDemoHelper', '', false, false)]
    local procedure SelfRegisterHelper()
    var
        SDHSalesDemoHelper: Record "SDH Sales Demo Helper";
        DoInsert: Boolean;
    begin
        SDHSalesDemoHelper.SetRange("Helper Codeunit Id", Codeunit::"SDH Customer Data Generator");
        DoInsert := SDHSalesDemoHelper.IsEmpty;
        SDHSalesDemoHelper.Id := 'CUSTOMERDATAGEN';
        SDHSalesDemoHelper."Helper Page Id" := Page::"SDH Cust. Data Gen.";
        SDHSalesDemoHelper."Helper Codeunit Id" := Codeunit::"SDH Customer Data Generator";
        SDHSalesDemoHelper."Demo Summary" := 'Generate Customer/Item History (Orders and Posted Invoices)';
        SDHSalesDemoHelper."Helper Description" := 'This Demo Helper allows you to select a range of Customers and Items, then generate Sales Documents across a period of time, with options for volume.';
        if DoInsert then
            SDHSalesDemoHelper.Insert()
        else
            SDHSalesDemoHelper.Modify();
    end;
}
