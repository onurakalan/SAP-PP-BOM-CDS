@EndUserText.label: 'Bom Item Last Version'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {serviceQuality: #C, sizeCategory: #L, dataClass: #TRANSACTIONAL}
define table function zpp_tf_BomItemLastVersion
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt  : abap.clnt,
    p_datum : dats

returns
{
  Client                         : abap.clnt;
  row_num                        : int4;
  BillOfMaterialItemUUID         : cs_guid;
  Material                       : matnr;
  Plant                          : werks_d;
  BillOfMaterialVariantUsage     : stlan;
  BillOfMaterialCategory         : stlty;
  BillOfMaterial                 : stnum;
  BillOfMaterialVariant          : stalt;
  BillOfMaterialItemNodeNumber   : stlkn;
  BOMItemInternalChangeCount     : cim_count;
  BillOfMaterialVersion          : bom_version;
  ValidityStartDate              : datuv;
  ValidityEndDate                : datub;
  EngineeringChangeDocument      : aennr;
  ChgToEngineeringChgDocument    : aenra;
  InheritedNodeNumberForBOMItem  : stvkn;
  InheritedNodeNumberVersionBOM  : stvkn;
  BOMItemRecordCreationDate      : andat;
  BOMItemCreatedByUser           : annam;
  BOMItemLastChangeDate          : aedat;
  BOMItemLastChangedByUser       : aenam;
  BillOfMaterialComponent        : idnrk;
  BillOfMaterialItemCategory     : postp;
  BillOfMaterialItemNumber       : sposn;
  BillOfMaterialItemUnit         : kmpme;
  BillOfMaterialItemQuantity     : kmpmg;
  IsAssembly                     : stlkz;
  IsSubItem                      : upskz;
  BOMItemSorter                  : sortp;
  FixedQuantity                  : fmnge;
  BOMItemHasFixedQuantity        : fmnge;
  PurchasingGroup                : ekgrp;
  Currency                       : waers;
  MaterialComponentPrice         : cprei;
  IdentifierBOMItem              : cs_itmid;
  MaterialPriceUnitQty           : peinh;
  ComponentScrapInPercent        : kausf;
  OperationScrapInPercent        : avoau;
  IsNetScrap                     : netau;
  NumberOfVariableSizeItem       : roanz;
  QuantityVariableSizeItem       : romen;
  FormulaKey                     : rform;
  BOMItemDescription             : potx1;
  BOMItemText2                   : potx2;
  MaterialGroup                  : matkl;
  DocumentType                   : dokar;
  DocNumber                      : doknr;
  DocumentVersion                : dokvr;
  DocumentPart                   : doktl_d;
  ClassNumber                    : klasse_d;
  ClassType                      : klassenart;
  ResultingItemCategory          : potpr;
  DependencyObjectNumber         : knobj;
  ObjectType                     : objty;
  IsClassificationRelevant       : cs_kzclb;
  IsBulkMaterial                 : schgt;
  BOMItemIsSparePart             : erskz;
  BOMItemIsSalesRelevant         : rvrel;
  IsProductionRelevant           : sanfe;
  BOMItemIsPlantMaintRelevant    : sanin;
  BOMItemIsCostingRelevant       : cs_sanka;
  IsEngineeringRelevant          : sanko;
  SpecialProcurementType         : cs_sobsl;
  IsBOMRecursiveAllowed          : rekrs;
  OperationLeadTimeOffset        : cs_nlfzv;
  OpsLeadTimeOffsetUnit          : cs_nlfmv;
  IsMaterialProvision            : beikz;
  BOMIsRecursive                 : rekri;
  DocumentIsCreatedByCAD         : cadpo;
  DistrKeyCompConsumption        : sa_verti;
  DeliveryDurationInDays         : lifzt;
  Creditor                       : lifnr;
  CostElement                    : sakto;
  Size1                          : roms1;
  Size2                          : roms2;
  Size3                          : roms3;
  UnitOfMeasureForSize1To3       : romei;
  GoodsReceiptDuration           : webaz;
  PurchasingOrganization         : ekorg;
  RequiredComponent              : clobk;
  MultipleSelectionAllowed       : clmult;
  ProdOrderIssueLocation         : cslgo;
  MaterialIsCoProduct            : kzkup;
  ExplosionType                  : cs_dispo;
  AlternativeItemGroup           : cs_alpgr;
  FollowUpGroup                  : cs_nfgrp;
  DiscontinuationGroup           : cs_nfeag;
  IsConfigurableBOM              : awakz;
  ReferencePoint                 : cn_rfpnt;
  LeadTimeOffset                 : nlfzt;
  IsSoftwareComponent            : cs_sfwind;
  ProductionSupplyArea           : prvbe;
  IsDeleted                      : lkenz;
  IsALE                          : cs_alekz;
  BillOfMaterialItemCategoryDesc : pttxt;
  IsPhantomItem                  : dumps;
}
implemented by method
  ZCL_PP_BOM_LAST_VERSION_AMDP=>get_bom_item_last_version
