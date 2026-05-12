@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bom Item'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {serviceQuality: #C, sizeCategory: #L, dataClass: #MASTER }
define view entity ZPP_I_BOMItem
  with parameters
    p_datum : dats
  as select from ZPP_I_BomItemFilter( p_datum: $parameters.p_datum ) as item

  association [0..*] to ZPP_I_BOMItem as _tree on  $projection.Material                   = _tree.Component
                                               and $projection.Plant                      = _tree.Plant
                                               and $projection.BillOfMaterialVariant      = _tree.BillOfMaterialVariant
                                               and $projection.BillOfMaterialVariantUsage = _tree.BillOfMaterialVariantUsage
{
      _tree,

  key Material,
  key Plant,
  key BillOfMaterialItemUUID,
      BillOfMaterialVariantUsage,
      BillOfMaterialCategory,
      BillOfMaterial,
      BillOfMaterialVariant,
      BillOfMaterialItemNumber,
      BillOfMaterialItemNodeNumber,
      BOMItemInternalChangeCount,

      case when $projection.isphantomitem = 'X' then BillOfMaterialComponent
           else cast('' as matnr ) end as Component,
      BillOfMaterialComponent          as RealComponent,
      @Semantics.quantity.unitOfMeasure: 'BOMItemQtyUnit'
      BillOfMaterialItemQuantity       as BOMItemQty,
      BillOfMaterialItemUnit           as BOMItemQtyUnit,
      ComponentScrapInPercent,
      ValidityStartDate,
      ValidityEndDate,
      IsAssembly,
      IsPhantomItem,
      BillOfMaterialVersion,
      EngineeringChangeDocument,
      ChgToEngineeringChgDocument,
      InheritedNodeNumberForBOMItem,
      InheritedNodeNumberVersionBOM,
      BOMItemRecordCreationDate,
      BOMItemCreatedByUser,
      BOMItemLastChangeDate,
      BOMItemLastChangedByUser,
      BillOfMaterialItemCategory,
      BillOfMaterialItemUnit
}
//where
//  item.row_num = 1
