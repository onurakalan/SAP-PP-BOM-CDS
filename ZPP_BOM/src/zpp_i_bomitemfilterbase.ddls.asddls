@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bom Item'
@Metadata.ignorePropagatedAnnotations: false
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #MASTER }
define view entity ZPP_I_BomItemFilterBase
  with parameters
    p_datum : dats
  as select from I_BillOfMaterialItemBasic                    as item

  // EN baştan filtreliyoruz.
    inner join   ZPP_I_BOMFilter(p_datum:$parameters.p_datum) as BOMFilter on  item.BillOfMaterialCategory       = BOMFilter.BillOfMaterialCategory
                                                                           and item.BillOfMaterial               = BOMFilter.BillOfMaterial
                                                                           and item.BillOfMaterialItemNodeNumber = BOMFilter.BillOfMaterialItemNodeNumber

  association [0..*] to I_MaterialBOMLink as _Mast on  $projection.BillOfMaterialCategory     = _Mast.BillOfMaterialCategory
                                                   and $projection.BillOfMaterial             = _Mast.BillOfMaterial
                                                   and $projection.BillOfMaterialVariant      = _Mast.BillOfMaterialVariant
                                                   and $projection.BillOfMaterialVariantUsage = _Mast.BillOfMaterialVariantUsage



{
  key item.BillOfMaterialItemUUID,
  key _Mast.Material,
  key _Mast.Plant,
      BOMFilter.BillOfMaterialVariantUsage,
      item.BillOfMaterialCategory,
      item.BillOfMaterial,
      BOMFilter.BillOfMaterialVariant,
      item.BillOfMaterialItemNodeNumber,
      item.BOMItemInternalChangeCount,
      BOMFilter.BillOfMaterialVersion,
      item.ValidityStartDate,
      item.ValidityEndDate,
      item.EngineeringChangeDocument,
      item.ChgToEngineeringChgDocument,
      item.InheritedNodeNumberForBOMItem,
      item.InheritedNodeNumberVersionBOM,
      item.BOMItemRecordCreationDate,
      item.BOMItemCreatedByUser,
      item.BOMItemLastChangeDate,
      item.BOMItemLastChangedByUser,
      item.BillOfMaterialComponent,
      item.BillOfMaterialItemCategory,
      item.BillOfMaterialItemNumber,
      item.BillOfMaterialItemUnit,
      item.BillOfMaterialItemQuantity,
      //      item.IsAssembly,
      item.IsSubItem,
      item.BOMItemSorter,
      item.FixedQuantity,
      item.FixedQuantity                                       as BOMItemHasFixedQuantity,
      item.PurchasingGroup,
      item.Currency,
      item.MaterialComponentPrice,
      item.IdentifierBOMItem,
      item.MaterialPriceUnitQty,
      item.ComponentScrapInPercent,
      item.OperationScrapInPercent,
      item.IsNetScrap,
      item.NumberOfVariableSizeItem,
      item.QuantityVariableSizeItem,
      item.FormulaKey,
      item.BOMItemText1                                        as BOMItemDescription,
      item.BOMItemText2,
      item.MaterialGroup,
      item.DocumentType,
      item.DocNumber,
      item.DocumentVersion,
      item.DocumentPart,
      item.ClassNumber,
      item.ClassType,
      item.ResultingItemCategory,
      item.DependencyObjectNumber,
      item.ObjectType,
      item.IsClassificationRelevant,
      item.IsBulkMaterial,
      item.BOMItemIsSparePart,
      item.BOMItemIsSalesRelevant,
      item.IsProductionRelevant,
      item.BOMItemIsPlantMaintRelevant,
      item.BOMItemIsCostingRelevant,
      item.IsEngineeringRelevant,
      item.SpecialProcurementType,
      item.IsBOMRecursiveAllowed,
      item.OperationLeadTimeOffset,
      item.OpsLeadTimeOffsetUnit,
      item.IsMaterialProvision,
      item.BOMIsRecursive,
      item.DocumentIsCreatedByCAD,
      item.DistrKeyCompConsumption,
      item.DeliveryDurationInDays,
      item.Creditor,
      item.CostElement,
      item.Size1,
      item.Size2,
      item.Size3,
      item.UnitOfMeasureForSize1To3,
      item.GoodsReceiptDuration,
      item.PurchasingOrganization,
      item.RequiredComponent,
      item.MultipleSelectionAllowed,
      item.ProdOrderIssueLocation,
      item.MaterialIsCoProduct,
      item.ExplosionType,
      item.AlternativeItemGroup,
      item.FollowUpGroup,
      item.DiscontinuationGroup,
      item.IsConfigurableBOM,
      item.ReferencePoint,
      item.LeadTimeOffset,
      item.IsSoftwareComponent,
      item.ProductionSupplyArea,
      item.IsDeleted,
      item.IsALE,
      item._BOMItemCategoryText.BillOfMaterialItemCategoryDesc as BillOfMaterialItemCategoryDesc,
      //      item.MaterialComponentIsPhantomItem,
//      item.IsPhantomItem,
      _Mast
}
