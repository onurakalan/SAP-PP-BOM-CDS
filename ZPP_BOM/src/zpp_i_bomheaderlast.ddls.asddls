@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOM Header Last'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #L, dataClass: #TRANSACTIONAL}
define view entity ZPP_I_BOMHeaderLast
  with parameters
    p_datum : dats
  as select from stko
{

  key stlty,
  key stlnr,
  key stlal,
      max( stkoz ) as stkoz
}
where
      datuv    <= $parameters.p_datum
  and ( valid_to is initial or valid_to >= $parameters.p_datum )
group by
  stlty,
  stlnr,
  stlal
