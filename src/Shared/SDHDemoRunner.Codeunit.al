codeunit 75000 "SDH Demo Runner"
{
    Subtype = TestRunner;
    TestIsolation = Disabled;

    trigger OnRun()
    var
        SDHSalesDemoHelper: Record "SDH Sales Demo Helper";
    begin
        SDHSalesDemoHelper.SetRange("To Run", true);
        if SDHSalesDemoHelper.FindSet() then
            repeat
                Codeunit.Run(SDHSalesDemoHelper."Helper Codeunit Id")
            until SDHSalesDemoHelper.Next() = 0;

        SDHSalesDemoHelper.ModifyAll("To Run", false);
    end;
}
