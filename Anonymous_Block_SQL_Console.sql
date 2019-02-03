DO ( 
    OUT EX_TOP_3_EMP_PO_COMBINED_CNT TABLE(
    FULLNAME NVARCHAR(256),  
	CREATE_CNT INTEGER, 
	CHANGE_CNT INTEGER,
	COMBINED_CNT INTEGER ) => ? )

BEGIN

PO_CREATE_CNT = SELECT COUNT(*) AS CREATE_CNT, "HISTORY.CREATEDBY.EMPLOYEEID" AS EID 
         FROM "PO.Header" 
            WHERE PURCHASEORDERID IN (
        SELECT PURCHASEORDERID FROM "PO.Item" 
             WHERE "PRODUCT.PRODUCTID" IS NOT NULL)
          GROUP BY  "HISTORY.CREATEDBY.EMPLOYEEID";
    
PO_CHANGE_CNT = SELECT COUNT(*) AS CHANGE_CNT, "HISTORY.CHANGEDBY.EMPLOYEEID" AS EID
           FROM "PO.Header"  
             WHERE PURCHASEORDERID IN (
             SELECT PURCHASEORDERID  FROM "PO.Item"
          WHERE "PRODUCT.PRODUCTID" IS NOT NULL)
           GROUP BY  "HISTORY.CHANGEDBY.EMPLOYEEID";

EX_TOP_3_EMP_PO_COMBINED_CNT = 
   SELECT "get_full_name"("NAME.FIRST", "NAME.MIDDLE", "NAME.LAST") as FULLNAME,
          crcnt.CREATE_CNT, chcnt.CHANGE_CNT,  
          crcnt.CREATE_CNT + chcnt.CHANGE_CNT AS COMBINED_CNT
       FROM "MD.Employees" as emp
        LEFT OUTER JOIN :PO_CREATE_CNT AS crcnt
            ON emp.EMPLOYEEID = crcnt.EID
        LEFT OUTER JOIN :PO_CHANGE_CNT AS chcnt
            ON emp.EMPLOYEEID = chcnt.EID
           ORDER BY COMBINED_CNT DESC LIMIT 3;

END;