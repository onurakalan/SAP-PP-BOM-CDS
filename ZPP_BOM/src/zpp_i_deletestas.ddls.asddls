@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delete Stas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {serviceQuality: #A, sizeCategory: #L, dataClass: #TRANSACTIONAL}
define view entity zpp_i_DeleteStas
  with parameters
    p_datum : dats
  as select from stas
{
  key stlty      as Stlty,
  key stlnr      as Stlnr,
  key stlal      as Stlal,
  key stlkn      as Stlkn,
      max(stasz) as Stasz
}
where
  datuv <= $parameters.p_datum
group by
  stlty,
  stlnr,
  stlal,
  stlkn
