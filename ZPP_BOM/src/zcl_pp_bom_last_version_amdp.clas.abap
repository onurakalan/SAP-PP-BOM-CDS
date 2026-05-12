CLASS zcl_pp_bom_last_version_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS get_bom_item_last_version
        FOR TABLE FUNCTION zpp_tf_bomitemlastversion.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pp_bom_last_version_amdp IMPLEMENTATION.



  METHOD get_bom_item_last_version
    BY DATABASE FUNCTION
    FOR HDB LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY
    USING ZPP_I_BomItemFilter.

    RETURN
        select
            :p_clnt as client,
            ROW_NUMBER() OVER (
             PARTITION BY BillOfMaterialCategory, billofmaterial, billofmaterialvariant, inheritednodenumberforbomitem
             ORDER BY bomiteminternalchangecount desc
           ) as row_num,
            bom.billofmaterialitemuuid,
            bom.Material,
            bom.Plant,
            bom.billofmaterialvariantusage,
            bom.billofmaterialcategory,
            bom.billofmaterial,
            bom.billofmaterialvariant,
            bom.billofmaterialitemnodenumber,
            bom.bomiteminternalchangecount,
            bom.billofmaterialversion,
            bom.validitystartdate,
            bom.validityenddate,
            bom.engineeringchangedocument,
            bom.chgtoengineeringchgdocument,
            bom.inheritednodenumberforbomitem,
            bom.inheritednodenumberversionbom,
            bom.bomitemrecordcreationdate,
            bom.bomitemcreatedbyuser,
            bom.bomitemlastchangedate,
            bom.bomitemlastchangedbyuser,
            bom.billofmaterialcomponent,
            bom.billofmaterialitemcategory,
            bom.billofmaterialitemnumber,
            bom.billofmaterialitemunit,
            bom.billofmaterialitemquantity,
            bom.isassembly,
            bom.issubitem,
            bom.bomitemsorter,
            bom.fixedquantity,
            bom.bomitemhasfixedquantity,
            bom.purchasinggroup,
            bom.currency,
            bom.materialcomponentprice,
            bom.identifierbomitem,
            bom.materialpriceunitqty,
            bom.componentscrapinpercent,
            bom.operationscrapinpercent,
            bom.isnetscrap,
            bom.numberofvariablesizeitem,
            bom.quantityvariablesizeitem,
            bom.formulakey,
            bom.bomitemdescription,
            bom.bomitemtext2,
            bom.materialgroup,
            bom.documenttype,
            bom.docnumber,
            bom.documentversion,
            bom.documentpart,
            bom.classnumber,
            bom.classtype,
            bom.resultingitemcategory,
            bom.dependencyobjectnumber,
            bom.objecttype,
            bom.isclassificationrelevant,
            bom.isbulkmaterial,
            bom.bomitemissparepart,
            bom.bomitemissalesrelevant,
            bom.isproductionrelevant,
            bom.bomitemisplantmaintrelevant,
            bom.bomitemiscostingrelevant,
            bom.isengineeringrelevant,
            bom.specialprocurementtype,
            bom.isbomrecursiveallowed,
            bom.operationleadtimeoffset,
            bom.opsleadtimeoffsetunit,
            bom.ismaterialprovision,
            bom.bomisrecursive,
            bom.documentiscreatedbycad,
            bom.distrkeycompconsumption,
            bom.deliverydurationindays,
            bom.creditor,
            bom.costelement,
            bom.size1,
            bom.size2,
            bom.size3,
            bom.unitofmeasureforsize1to3,
            bom.goodsreceiptduration,
            bom.purchasingorganization,
            bom.requiredcomponent,
            bom.multipleselectionallowed,
            bom.prodorderissuelocation,
            bom.materialiscoproduct,
            bom.explosiontype,
            bom.alternativeitemgroup,
            bom.followupgroup,
            bom.discontinuationgroup,
            bom.isconfigurablebom,
            bom.referencepoint,
            bom.leadtimeoffset,
            bom.issoftwarecomponent,
            bom.productionsupplyarea,
            bom.isdeleted,
            bom.isale,
            bom.billofmaterialitemcategorydesc,
            bom.isphantomitem
        from zpp_i_bomitemfilter( :p_datum ) as bom  ;

  endmethod.

ENDCLASS.
