@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bom Item'
@Metadata.ignorePropagatedAnnotations: false
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #MASTER}
define view entity ZPP_I_BomItemFilter
  with parameters
    p_datum : dats
  as select from           ZPP_I_BomItemFilterBase(p_datum: $parameters.p_datum) as item

    left outer to one join t460a                                                 as t460a_o on  t460a_o.werks = item.Plant ---N_3475629
                                                                                            and t460a_o.sobsl = item.SpecialProcurementType ---N_3475629

    left outer to one join marc                                                  as marc    on  marc.matnr = item.BillOfMaterialComponent ---N_3475629
                                                                                            and marc.werks = item.Plant    ---N_3475629

    left outer to one join t460a                                                 as t460b_o on  t460b_o.werks = item.Plant ---N_3475629
                                                                                            and t460b_o.sobsl = marc.sobsl

  association [0..1] to I_MultiLevelBOM as _MultilevelBOM on  $projection.BillOfMaterialComponent = _MultilevelBOM.Material
                                                          and $projection.Plant                   = _MultilevelBOM.Plant
{
  key item.BillOfMaterialItemUUID,
  key item.Material,
  key item.Plant,
      item.BillOfMaterialVariantUsage,
      item.BillOfMaterialCategory,
      item.BillOfMaterial,
      item.BillOfMaterialVariant,
      item.BillOfMaterialItemNodeNumber,
      item.BOMItemInternalChangeCount,
      item.BillOfMaterialVersion,
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

      case when ( _MultilevelBOM.Material is not null or _MultilevelBOM.Material != '' ) and
                         ( item.Plant = _MultilevelBOM.Plant )
                 then
                 cast('X' as char1)
                 else
               cast(' ' as char1)
                 end as IsAssembly,

      item.IsSubItem,
      item.BOMItemSorter,
      item.FixedQuantity,
      item.BOMItemHasFixedQuantity,
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
      item.BOMItemDescription,
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
      item.BillOfMaterialItemCategoryDesc,
      case
          when t460a_o.dumps = 'X'                                    ---N_3475629
          then cast('X' as xfeld preserving type)
          when t460b_o.dumps = 'X'                                    ---N_3475629
          then cast('X' as xfeld preserving type)                     ---N_3475629
          else
          cast('' as xfeld preserving type)
      end            as IsPhantomItem,
      item._Mast
}
