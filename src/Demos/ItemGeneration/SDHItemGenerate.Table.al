table 75020 "SDH Item Generate"
{
    DataPerCompany = false;
    Caption = 'SDH Item Generate';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(10; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = SystemMetadata;
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;

        }
        field(15; "Location Code"; Code[10])
        {
            TableRelation = Location;
            Caption = 'Location Code';
            DataClassification = SystemMetadata;
        }
        field(20; "Base Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
            Caption = 'Base Unit of Measure';
            DataClassification = SystemMetadata;
        }
        field(21; "Sales Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
            Caption = 'Sales Unit of Measure';
            DataClassification = SystemMetadata;
        }
        field(22; "Purch. Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
            Caption = 'Purch. Unit of Measure';
            DataClassification = SystemMetadata;
        }
        field(30; "Item Cost Minumum"; Decimal)
        {
            Caption = 'Item Cost Minumum';
            DataClassification = SystemMetadata;

        }
        field(31; "Item Cost Maximum"; Decimal)
        {
            Caption = 'Item Cost Maximum';
            DataClassification = SystemMetadata;

        }
        field(32; "Costing Method"; Enum "Costing Method")
        {
            Caption = 'Costing Method';
            DataClassification = SystemMetadata;
        }

        field(40; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = SystemMetadata;
        }

        field(50; "Gen. Prod. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = SystemMetadata;
        }
        field(51; "VAT Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
            Caption = 'VAT Prod. Posting Group';
            DataClassification = SystemMetadata;
        }
        field(52; "Inventory Posting Group"; Code[10])
        {
            TableRelation = "Inventory Posting Group";
            Caption = 'Inventory Posting Group';
            DataClassification = SystemMetadata;
        }

        field(60; "Stock Start Date"; Date)
        {
            Caption = 'Stock Start Date';
            DataClassification = SystemMetadata;

        }
        field(61; "Stock End Date"; Date)
        {
            Caption = 'Stock End Date';
            DataClassification = SystemMetadata;

        }
        field(62; "Stock Period Step"; DateFormula)
        {
            InitValue = '<1M>';
            Caption = 'Stock Period Step';
            DataClassification = SystemMetadata;
        }
        field(63; "Stock Minimum Quantity"; Decimal)
        {
            Caption = 'Stock Minimum Quantity';
            DataClassification = SystemMetadata;

        }
        field(64; "Stock Maximum Quantity"; Decimal)
        {
            Caption = 'Stock Maximum Quantity';
            DataClassification = SystemMetadata;

        }


        field(70; "Purchase Start Date"; Date)
        {
            Caption = 'Purchase Start Date';
            DataClassification = SystemMetadata;

        }
        field(71; "Purchase End Date"; Date)
        {
            Caption = 'Purchase End Date';
            DataClassification = SystemMetadata;

        }
        field(72; "Purchase Period Step"; DateFormula)
        {
            InitValue = '<1M>';
            Caption = 'Purchase Period Step';
            DataClassification = SystemMetadata;
        }
        field(73; "Purchase Minimum Quantity"; Decimal)
        {
            Caption = 'Purchase Minimum Quantity';
            DataClassification = SystemMetadata;

        }
        field(74; "Purchase Maximum Quantity"; Decimal)
        {
            Caption = 'Purchase Maximum Quantity';
            DataClassification = SystemMetadata;

        }
        field(75; "Purchase From Vendor"; Code[20])
        {
            TableRelation = Vendor;
            Caption = 'Purchase From Vendor';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
}
