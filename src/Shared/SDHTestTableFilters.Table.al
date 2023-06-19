table 75002 "SDH Test Table Filters"
{
    DataPerCompany = false;
    Caption = 'SDH Test Table Filters';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Table Id"; Integer)
        {
            Caption = 'Table Id';
            DataClassification = ToBeClassified;
        }
        field(2; ViewText; Text[2048])
        {
            Caption = 'ViewText';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Table Id")
        {
            Clustered = true;
        }
    }
}
