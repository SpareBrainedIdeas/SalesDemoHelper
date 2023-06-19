codeunit 75002 "SDH Utilities"
{

    procedure GetTableView(WhichTableId: Integer) ViewText: Text
    var
        SDHTestTableFilters: Record "SDH Test Table Filters";
    begin
        if SDHTestTableFilters.Get(WhichTableId) then
            exit(SDHTestTableFilters.ViewText);
    end;

    procedure StoreTableView(WhichTableId: Integer; NewViewText: Text)
    var
        SDHTestTableFilters: Record "SDH Test Table Filters";
    begin
        if SDHTestTableFilters.Get(WhichTableId) then begin
            SDHTestTableFilters.ViewText := NewViewText;
            SDHTestTableFilters.Modify();
        end else begin
            SDHTestTableFilters."Table Id" := WhichTableId;
            SDHTestTableFilters.ViewText := NewViewText;
            SDHTestTableFilters.Insert();
        end;
    end;

    procedure GetTestParameter(NewKey: Code[20]) NewValue: Variant
    var
        SDHTestParameters: Record "SDH Test Parameters";
    begin
        if SDHTestParameters.Get(NewKey) then
            exit(SDHTestParameters.Value)
    end;

    procedure StoreTestParameter(NewKey: Code[20]; NewValue: Variant)
    var
        SDHTestParameters: Record "SDH Test Parameters";
    begin
        if SDHTestParameters.Get(NewKey) then begin
            SDHTestParameters.Value := Format(NewValue, 0, 9);
            SDHTestParameters.Modify();
        end else begin
            SDHTestParameters."Key" := NewKey;
            SDHTestParameters.Value := Format(NewValue, 0, 9);
            SDHTestParameters.Insert();
        end;
    end;

    // Thanks Yun:  https://community.dynamics.com/business/f/dynamics-365-business-central-forum/435843/calculate-number-of-month-between-two-dates
    procedure CalculateMonthBetweenTwoDate(StartDate: Date; EndDate: Date): Integer
    var
        NoOfYears: Integer;
        NoOfMonths: Integer;
    begin
        NoOfYears := DATE2DMY(EndDate, 3) - DATE2DMY(StartDate, 3);
        NoOfMonths := DATE2DMY(EndDate, 2) - DATE2DMY(StartDate, 2);
        exit(12 * NoOfYears + NoOfMonths);
    end;
}
