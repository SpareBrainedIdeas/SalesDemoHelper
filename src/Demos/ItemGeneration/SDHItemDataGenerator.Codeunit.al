codeunit 75021 "SDH Item Data Generator"
{
    trigger OnRun()
    var
        Item: Record Item;
        SDHItemGenerate: Record "SDH Item Generate";
        SDHUtilities: Codeunit "SDH Utilities";
        LibraryInventory: Codeunit "Library - Inventory";
        JournalTemplate: Code[10];
        JournalBatch: Code[10];
        NextDate: Date;
        SafetyCounter: Integer;
    begin
        if SDHItemGenerate.FindFirst() then
            repeat
                if SDHItemGenerate."Item No." <> '' then begin
                    if not Item.Get(SDHItemGenerate."Item No.") then begin
                        GenerateItem(SDHItemGenerate);
                    end;

                    if HasValidPastStockSettings(SDHItemGenerate) then begin
                        NextDate := SDHItemGenerate."Stock Start Date";
                        SafetyCounter := 0;
                        repeat
                            CreatePastAdjustment(SDHItemGenerate, NextDate, JournalTemplate, JournalBatch);
                            NextDate := CalcDate(SDHItemGenerate."Stock Period Step", NextDate);
                            SafetyCounter += 1;
                        until (NextDate >= SDHItemGenerate."Stock End Date") or (SafetyCounter > 1461);
                        LibraryInventory.PostItemJournalLine(JournalTemplate, JournalBatch);
                    end;

                    if HasValidPurchaseSettings(SDHItemGenerate) then begin
                        NextDate := SDHItemGenerate."Purchase Start Date";
                        SafetyCounter := 0;
                        repeat
                            CreatePurchaseDocument(SDHItemGenerate, NextDate);
                            NextDate := CalcDate(SDHItemGenerate."Purchase Period Step", NextDate);
                            SafetyCounter += 1;
                        until (NextDate >= SDHItemGenerate."Purchase End Date") or (SafetyCounter > 1461);
                    end;
                end;
            until SDHItemGenerate.Next() = 0;
    end;

    local procedure GenerateItem(SDHItemGenerate: Record "SDH Item Generate")
    var
        Item: Record Item;
        LibraryInventory: Codeunit "Library - Inventory";
    begin
        LibraryInventory.CreateItem(Item);
        Item.Rename(SDHItemGenerate."Item No.");
        Item.Validate(Description, SDHItemGenerate.Description);
        Item.Validate("Base Unit of Measure", SDHItemGenerate."Base Unit of Measure");
        if SDHItemGenerate."Sales Unit of Measure" <> '' then
            Item.Validate("Sales Unit of Measure", SDHItemGenerate."Sales Unit of Measure");
        if SDHItemGenerate."Purch. Unit of Measure" <> '' then
            Item.Validate("Purch. Unit of Measure", SDHItemGenerate."Purch. Unit of Measure");
        item.Validate("Costing Method", SDHItemGenerate."Costing Method");
        Item.Validate("Unit Price", SDHItemGenerate.Price);
        Item.Validate("Gen. Prod. Posting Group", SDHItemGenerate."Gen. Prod. Posting Group");
        Item.Validate("VAT Prod. Posting Group", SDHItemGenerate."VAT Prod. Posting Group");
        Item.Validate("Inventory Posting Group", SDHItemGenerate."Inventory Posting Group");
        Item.Modify(true);
    end;

    local procedure HasValidPastStockSettings(SDHItemGenerate: Record "SDH Item Generate") DataValid: Boolean
    begin
        DataValid := true;
        DataValid := DataValid and (SDHItemGenerate."Stock Start Date" <> 0D);
        DataValid := DataValid and (SDHItemGenerate."Stock End Date" <> 0D);
        DataValid := DataValid and (Format(SDHItemGenerate."Stock Period Step") <> '');
        DataValid := DataValid and (SDHItemGenerate."Stock Minimum Quantity" > 0);
        DataValid := DataValid and (SDHItemGenerate."Stock Maximum Quantity" > 0) and (SDHItemGenerate."Stock Maximum Quantity" > SDHItemGenerate."Stock Minimum Quantity");
    end;

    local procedure CreatePastAdjustment(SDHItemGenerate: Record "SDH Item Generate"; NextDate: Date; var JournalTemplate: Code[10]; var JournalBatch: Code[10])
    var
        ItemJournalLine: Record "Item Journal Line";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        LibraryInventory: Codeunit "Library - Inventory";
        LibraryRandom: Codeunit "Library - Random";
        QtyToAdjust: Decimal;
        CostToAdjust: Decimal;
    begin
        ItemUnitofMeasure.Get(SDHItemGenerate."Item No.", SDHItemGenerate."Base Unit of Measure");
        QtyToAdjust := LibraryRandom.RandDecInDecimalRange(SDHItemGenerate."Stock Minimum Quantity", SDHItemGenerate."Stock Maximum Quantity", ItemUnitofMeasure."Qty. Rounding Precision");
        CostToAdjust := LibraryRandom.RandDecInRange(SDHItemGenerate."Item Cost Minumum", SDHItemGenerate."Item Cost Maximum", 2);
        LibraryInventory.CreateItemJnlLine(ItemJournalLine,
            Enum::"Item Ledger Entry Type"::"Positive Adjmt.",
            NextDate,
            SDHItemGenerate."Item No.",
            QtyToAdjust,
            SDHItemGenerate."Location Code");
        ItemJournalLine.Validate("Unit Cost", CostToAdjust);
        ItemJournalLine.Modify();
        JournalTemplate := ItemJournalLine."Journal Template Name";
        JournalBatch := ItemJournalLine."Journal Batch Name";
    end;

    local procedure HasValidPurchaseSettings(SDHItemGenerate: Record "SDH Item Generate") DataValid: Boolean
    begin
        DataValid := true;
        DataValid := DataValid and (SDHItemGenerate."Purchase Start Date" <> 0D);
        DataValid := DataValid and (SDHItemGenerate."Purchase End Date" <> 0D);
        DataValid := DataValid and (Format(SDHItemGenerate."Purchase Period Step") <> '');
        DataValid := DataValid and (SDHItemGenerate."Purchase Minimum Quantity" > 0);
        DataValid := DataValid and (SDHItemGenerate."Purchase Maximum Quantity" > 0) and (SDHItemGenerate."Purchase Maximum Quantity" > SDHItemGenerate."Purchase Minimum Quantity");
    end;

    local procedure CreatePurchaseDocument(SDHItemGenerate: Record "SDH Item Generate"; NextDate: Date)
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        LibraryPurchase: Codeunit "Library - Purchase";
        LibraryRandom: Codeunit "Library - Random";
        QtyToPurchase: Decimal;
        CostToPurchase: Decimal;
    begin
        ItemUnitofMeasure.Get(SDHItemGenerate."Item No.", SDHItemGenerate."Base Unit of Measure");
        QtyToPurchase := LibraryRandom.RandDecInDecimalRange(SDHItemGenerate."Purchase Minimum Quantity", SDHItemGenerate."Purchase Maximum Quantity", ItemUnitofMeasure."Qty. Rounding Precision");
        CostToPurchase := LibraryRandom.RandDecInRange(SDHItemGenerate."Item Cost Minumum", SDHItemGenerate."Item Cost Maximum", 2);

        LibraryPurchase.CreatePurchaseOrderWithLocation(PurchaseHeader, SDHItemGenerate."Purchase From Vendor", SDHItemGenerate."Location Code");
        PurchaseHeader.validate("Posting Date", NextDate);
        PurchaseHeader.validate("Document Date", NextDate);
        PurchaseHeader.validate("Expected Receipt Date", NextDate);
        LibraryPurchase.CreatePurchaseLineWithUnitCost(PurchaseLine, PurchaseHeader, SDHItemGenerate."Item No.", CostToPurchase, QtyToPurchase);
    end;
}
