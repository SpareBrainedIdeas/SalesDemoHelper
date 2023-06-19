table 75010 "SDH Cust. Data Gen."
{
    DataPerCompany = false;
    Caption = 'SDH Cust. Data Gen.';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Orders Per Month"; Integer)
        {
            Caption = 'Orders Per Month';
            DataClassification = SystemMetadata;
            InitValue = 10;
        }
        field(3; "Posted Invoices Per Month"; Integer)
        {
            Caption = 'Posted Invoices Per Month';
            DataClassification = SystemMetadata;
            InitValue = 6;
        }
        field(20; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = SystemMetadata;
            InitValue = 20220101D;
        }
        field(21; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = SystemMetadata;
            InitValue = 20221201D;
        }

        field(30; "Minimum Item Quantity"; Integer)
        {
            Caption = 'Minimum Item Quantity';
            DataClassification = SystemMetadata;
            InitValue = 5;
        }
        field(31; "Maximum Item Quantity"; Integer)
        {
            Caption = 'Maximum Item Quantity';
            DataClassification = SystemMetadata;
            InitValue = 15;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }


    var
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Rec.InsertIfNotExists();
        RecordHasBeenRead := true;
    end;

    procedure InsertIfNotExists()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert(true);
        end;
    end;


    procedure GenerateData(var Customer: Record Customer; var Item: Record Item)
    var
        SDHCDGCore: Codeunit "SDH Cust. Data Gen. Core";
    begin
        TestField("Start Date");
        TestField("End Date");
        TestField("Minimum Item Quantity");
        TestField("Maximum Item Quantity");
        if ("Orders Per Month" = 0) or ("Posted Invoices Per Month" = 0) then
            Error('Nothing to generate');
        if (Customer.Count = 0) then
            Error('No customers to generate for.');
        if (Item.Count = 0) then
            Error('There are no items selected.');

        SDHCDGCore.GenerateData(Rec, Customer, Item);
    end;
}
