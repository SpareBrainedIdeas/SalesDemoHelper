table 75000 "SDH Sales Demo Helper"
{
    Caption = 'Sales Demo Helper';
    DataClassification = ToBeClassified;
    DrillDownPageId = "SDH Sales Demo Helper";
    LookupPageId = "SDH Sales Demo Helper";
    DataPerCompany = false;

    fields
    {
        field(1; Id; Text[50])
        {
            Caption = 'Id';
            DataClassification = ToBeClassified;
        }
        field(2; "Demo Summary"; Text[200])
        {
            Caption = 'Demo Summary';
            DataClassification = ToBeClassified;
        }
        field(10; "Helper Page Id"; Integer)
        {
            Caption = 'Helper Page Id';
            DataClassification = ToBeClassified;
        }
        field(20; "Helper Codeunit Id"; Integer)
        {
            Caption = 'Helper Codeunit Id';
            DataClassification = ToBeClassified;
        }

        field(100; "Helper Description"; Text[2048])
        {
            Caption = 'Helper Description';
            DataClassification = ToBeClassified;
        }

        field(101; "To Run"; Boolean)
        {
            Caption = 'To Run';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }

    procedure LaunchHelper()
    begin
        Page.Run(Rec."Helper Page Id");
    end;
}
