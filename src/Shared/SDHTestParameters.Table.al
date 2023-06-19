table 75001 "SDH Test Parameters"
{
    DataPerCompany = false;
    Caption = 'SDH Test Parameters';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Key"; Code[20])
        {
            Caption = 'Key';
            DataClassification = ToBeClassified;
        }
        field(2; Value; Text[1024])
        {
            Caption = 'Value';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Key")
        {
            Clustered = true;
        }
    }
}
