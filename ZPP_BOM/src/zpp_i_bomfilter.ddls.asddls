@VDM.viewType: #COMPOSITE
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
@EndUserText.label: 'CDS based search model view for BOM Item'
define view entity ZPP_I_BOMFilter
  with parameters
    p_datum : dats
  as select from stas                                               as stas
  //    inner join   stpo                                               as stpo  on  stas.stlty = stpo.stlty
  //                                                                             and stas.stlnr = stpo.stlnr
  //                                                                             and stas.stlkn = stpo.stlkn

    inner join   ZPP_I_BOMHeaderLast( p_datum:$parameters.p_datum ) as stkoL on  stas.stlty = stkoL.stlty
                                                                             and stas.stlnr = stkoL.stlnr
                                                                             and stas.stlal = stkoL.stlal

    inner join   stzu                                               as stzu  on  stkoL.stlty = stzu.stlty
                                                                             and stkoL.stlnr = stzu.stlnr

    inner join   stko                                               as stko  on  stkoL.stlty = stko.stlty
                                                                             and stkoL.stlnr = stko.stlnr
                                                                             and stkoL.stlal = stko.stlal
                                                                             and stkoL.stkoz = stko.stkoz
  // sonuncu kalem silindi mi diye bakacağız.
    inner join   zpp_i_DeleteStas( p_datum:$parameters.p_datum )    as del   on  stas.stlty = del.Stlty
                                                                             and stas.stlnr = del.Stlnr
                                                                             and stas.stlal = del.Stlal
                                                                             and stas.stlkn = del.Stlkn
                                                                             and stas.stasz = del.Stasz
  //  association [1..1] to I_Product as _Product on _Product.Product = stpo.idnrk


{
  key stas.stlnr     as BillOfMaterial,
  key stas.stlal     as BillOfMaterialVariant,
  key stas.stlty     as BillOfMaterialCategory,
  key stas.stlkn     as BillOfMaterialItemNodeNumber,
      stzu.stlan     as BillOfMaterialVariantUsage,

      //  key stpo.guidx       as BillOfMaterialItemUUID,
      stko.guidx     as BillOfMaterialHeaderUUID,
      stko.loekz     as BOMIsArchivedForDeletion,

      stas.stvkn     as InheritedNodeNumberForBOMItem,
      //      stpo.stvkn_versn as InheritedNodeNumberVersionBOM,
      stas.bom_versn as BillOfMaterialVersion
      //      @Semantics.businessDate.from: true
      //      stpo.datuv       as ValidityStartDate,
      //      @Semantics.businessDate.to: true
      //      stpo.valid_to    as ValidityEndDate,
      //      stpo.aennr       as EngineeringChangeDocument,
      //      stpo.andat       as BOMItemRecordCreationDate,
      //      stpo.annam       as BOMItemCreatedByUser,
      //      stpo.aedat       as BOMItemLastChangeDate,
      //      stpo.aenam       as BOMItemLastChangedByUser,
      //      stpo.idnrk       as BillOfMaterialComponent,
      //      stpo.postp       as BillOfMaterialItemCategory,
      //      stpo.posnr       as BillOfMaterialItemNumber,
      //      stpo.meins       as BillOfMaterialItemUnit,
      //      stpo.menge       as BillOfMaterialItemQuantity,
      //      stpo.potx1       as BOMItemDescription,
      //      stpo.potx2       as BOMItemText2
}
where
  //      stpo.stlty                   = 'M'
      stas.lkenz = ''
  and stko.loekz = ''
//  and _Product.IsMarkedForDeletion = ''
