codeunit 75001 "SDH Install"
{
    Subtype = Install;

    trigger OnInstallAppPerDatabase()
    begin

        OnInstallSalesDemoHelper();
    end;

    [BusinessEvent(false)]
    local procedure OnInstallSalesDemoHelper()
    begin
    end;
}
