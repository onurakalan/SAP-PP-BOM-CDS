@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOM Ağacı'
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {serviceQuality: #C, sizeCategory: #L, dataClass: #MASTER}
define hierarchy ZPP_I_BOMItemTree
  with parameters
    p_material : matnr,
    p_plant    : werks_d,
    p_usage    : stlan,
    p_variant  : stalt,
    p_datum    : dats
  as parent child hierarchy(
    source ZPP_I_BOMItem(p_datum: $parameters.p_datum)
    child to parent association _tree
    start where
          Material                   = $parameters.p_material
      and Plant                      = $parameters.p_plant
      and BillOfMaterialVariantUsage = $parameters.p_usage
      and BillOfMaterialVariant      = $parameters.p_variant
    siblings order by
      BillOfMaterialItemNodeNumber ascending

    multiple parents allowed
    orphans ignore
    cycles breakup
  )

{
  Material,
  Plant,
  BillOfMaterialVariantUsage,
  BillOfMaterialCategory,
  BillOfMaterial,
  BillOfMaterialVariant,
  BillOfMaterialItemNumber,
  BillOfMaterialItemNodeNumber,
  BOMItemInternalChangeCount,
  Component,
  RealComponent,
  @Semantics.quantity.unitOfMeasure: 'BOMItemQtyUnit'
  BOMItemQty,
  BOMItemQtyUnit,
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
  BillOfMaterialItemUnit,


  // --- SİSTEM ($node) ÖZNİTELİKLERİ ---

  // 1. Derinlik / Seviye (Depth)
  $node.hierarchy_level     as HierarchyLevel, // Kök düğüm 1'dir. Aşağı indikçe artar.

  // 2. Alt Ağaç Büyüklüğü
  $node.hierarchy_tree_size as TreeSize, // Düğümün kendisi dahil toplam alt düğüm sayısı. (Örn: Sadece yaprak ise 1 döner).

  // 3. Hiyerarşi Sırası (Rank / Yol Tespiti İçin)
  $node.hierarchy_rank      as HierarchyRank, // Ağacın yukarıdan aşağıya (Preorder) traversal sırası.

  // 4. Bağlantı Metadataları
  $node.node_id             as NodeId, // Hiyerarşi içindeki benzersiz düğüm ID'si.
  $node.parent_id           as ParentNodeId, // Hiyerarşi ağacındaki geçerli ebeveyn ID'si.

  // 5. Veri Tutarlılığı (Sağlık Kontrolleri)
  $node.hierarchy_is_cycle  as IsCycle, // Düğüm bir sonsuz döngü yaratıyor mu? (0: Hayır, 1: Evet)
  $node.hierarchy_is_orphan as IsOrphan // Start koşulu ile bağlantısı kopuk bir yetim mi? (0: Hayır, 1: Evet)

}
