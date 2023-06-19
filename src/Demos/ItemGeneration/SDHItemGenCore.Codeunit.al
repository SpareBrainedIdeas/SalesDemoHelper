codeunit 75020 "SDH Item Gen. Core"
{

    procedure GenerateData()
    var
        SDHSalesDemoHelper: Record "SDH Sales Demo Helper";
        SDHDemoRunner: Codeunit "SDH Demo Runner";
    begin
        SDHSalesDemoHelper.SetRange("Helper Codeunit Id", Codeunit::"SDH Item Data Generator");
        SDHSalesDemoHelper.FindFirst();
        SDHSalesDemoHelper."To Run" := true;
        SDHSalesDemoHelper.Modify();
        Commit();

        Clear(SDHDemoRunner);
        SDHDemoRunner.Run();
    end;

    local procedure GenerateSampleData()
    var
        SDHItemGenerate: Record "SDH Item Generate";
        i: Integer;
    begin
        if SDHItemGenerate.IsEmpty then
            for i := 1 to 5 do begin
                SDHItemGenerate."Line No." := i * 10000;
                SDHItemGenerate."Item No." := 'DEMO-' + format(i);

                SDHItemGenerate."Base Unit of Measure" := 'PCS';
                SDHItemGenerate."Location Code" := 'MAIN';
                SDHItemGenerate."Item Cost Minumum" := Random(50);
                SDHItemGenerate."Item Cost Maximum" := Random(50);
                SDHItemGenerate.Price := 10 * Random(5) + Random(100);
                SDHItemGenerate."Gen. Prod. Posting Group" := 'RETAIL';
                SDHItemGenerate."VAT Prod. Posting Group" := 'STANDARD';
                SDHItemGenerate."Inventory Posting Group" := 'RESALE';

                SDHItemGenerate."Stock Start Date" := 20220101D;
                SDHItemGenerate."Stock End Date" := 20220601D;
                Evaluate(SDHItemGenerate."Stock Period Step", '<2W>');
                SDHItemGenerate."Stock Minimum Quantity" := 30 + Random(20);
                SDHItemGenerate."Stock Maximum Quantity" := 80 + Random(20);

                SDHItemGenerate."Purchase Start Date" := 20220401D;
                SDHItemGenerate."Purchase End Date" := 20221231D;
                Evaluate(SDHItemGenerate."Purchase Period Step", '<3W>');
                SDHItemGenerate."Purchase Minimum Quantity" := 40 + Random(20);
                SDHItemGenerate."Purchase Maximum Quantity" := 70 + Random(20);

                SDHItemGenerate."Purchase From Vendor" := '20000';
                SDHItemGenerate.Insert(true);
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SDH Install", 'OnInstallSalesDemoHelper', '', false, false)]
    local procedure SelfRegisterHelper()
    var
        SDHSalesDemoHelper: Record "SDH Sales Demo Helper";
        DoInsert: Boolean;
    begin
        SDHSalesDemoHelper.SetRange("Helper Codeunit Id", Codeunit::"SDH Item Data Generator");
        DoInsert := SDHSalesDemoHelper.IsEmpty;
        SDHSalesDemoHelper.Id := 'ITEMDATAGEN';
        SDHSalesDemoHelper."Helper Page Id" := Page::"SDH Item Generate";
        SDHSalesDemoHelper."Helper Codeunit Id" := Codeunit::"SDH Item Data Generator";
        SDHSalesDemoHelper."Demo Summary" := 'Generate Items and create supply for them';
        SDHSalesDemoHelper."Helper Description" := 'This Demo Helper allows you to generate a list of items, as well as past balances and future Purchase Order supplies for them.';
        if DoInsert then
            SDHSalesDemoHelper.Insert()
        else
            SDHSalesDemoHelper.Modify();


        GenerateSampleData();
    end;
}
