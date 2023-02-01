
 URL  
  
 COLLECT 





Syntax 

COLLECT wa INTO itab [result]. 



 Effect 

This statement inserts the content of a work area wa either as a single row in an internal table itab or adds the values of its numeric components to the corresponding values of existing rows with the same primary table key. wa is a functional operand position. 

result can be used to set a reference to the inserted or changed row in the form of a field symbol or data reference. 

Prerequisite for the use of this statement is that wa is compatible with the row type of itab. All components that are not part of the primary table key must have a numeric data type. 

The table is scanned for a row with the same primary key as follows: 
◾ In standard tables that are filled using COLLECT only, the entry is determined by a temporary hash administrator. The workload is independent of the number of entries in the table. The hash administrator is temporary and is generally invalidated when the table is accessed to be changed. If COLLECT statements are specified after an invalidation, a linear search of all table rows is performed. The workload for this search increases in a linear fashion in relation to the number of entries. 


◾ In sorted tables, the entry is determined using a binary search. The workload has a logarithmic relationship to the number of entries in the table. 


◾ In hashed tables, the entry is determined using the hash administrator of the table and is always independent of the number of table entries. 


If no row is found with an identical primary key, a row is inserted as described below and filled with the content of wa: 
◾ In standard tables, the row is appended as the last row of the primary table index. 


◾ In sorted tables, the new row is inserted in the sort order of the internal table in accordance with its key values, and the primary table index of the subsequent rows is increased by 1. 


◾ In hashed tables, the new row is inserted into the internal table by the hash administrator, in accordance with its key values. 


If the internal table already contains one or more rows with an identical primary key, those values of the components of work area wa that are not part of the key are added to the corresponding components of the uppermost existing row (in the case of index tables, this is the row with the lowest primary table index). 

A non-handleable exception is raised if a duplicate entry in a unique secondary table key is produced when the statement COLLECT is executed. 

If the primary table key of a standard table is empty, all components of the row type must be numeric and the first row of the internal table is always compressed. If the system can statically detect this, the syntax check displays a warning that can be hidden using a pragma. 

System Fields 

The statement COLLECT sets sy-tabix for standard tables and sorted tables to the row number of the inserted or existing row in the primary table index, and for hashed tables to the value 0. 



ABAP Guidelines Programming Guideline 

Do not fill standard tables with collections of rows 

 Notes 
◾ COLLECT should only be used if internal tables are to be created that are genuinely unique or compressed. In this case, COLLECT can greatly benefit performance. If uniqueness or compression are not required, or the uniqueness is guaranteed for other reasons, the statement INSERT should be used instead. 


◾ The statement COLLECT is not suitable for standard tables and should no longer be used for them. COLLECT can be used for sorted tables and hashed tables without any problems since these, unlike standard tables, always have a separate, stable key administration that can be utilized by COLLECT. When used for sorted tables, these should have a unique primary key or the table should be filled with COLLECT only. For hashed tables, all prerequisites are fulfilled automatically. 


◾ If a standard table is still filled using COLLECT, it should not be edited using any other statement, with the exception of MODIFY. If the latter is used with the addition TRANSPORTING, no primary key fields can be changed. This is the only way to ensure that the table entries are always unique and compressed, and that the statement COLLECT runs efficiently. The function module ABL_TABLE_HASH_STATE can be used to check whether a standard table is suitable for editing using COLLECT. 


◾ The method HAS_COLLECT_HASH_ADMIN of the class CL_ABAP_ITAB_UTILITIES can be used in standard tables to check whether temporary hash management insists in the statement COLLECT. 


◾ Outside of classes, an obsolete short form is possible where wa INTO can be omitted if the internal table has a header line itab with the same name. The statement then uses the header line as the work area implicitly. 




 Example 

Compressed insertion of data from the database table sflight into the internal table seats_tab. The rows in which the primary key components carrid and connid are identical are compressed by adding the number of occupied seats to the numeric component seatsocc. 

 DATA: BEGIN OF seats, 
        carrid   TYPE sflight-carrid, 
        connid   TYPE sflight-connid, 
        seatsocc TYPE sflight-seatsocc, 
      END OF seats. 

DATA seats_tab LIKE HASHED TABLE OF seats 
               WITH UNIQUE KEY carrid connid. 

SELECT carrid, connid, seatsocc 
       FROM sflight 
       INTO @seats. 
  COLLECT seats INTO seats_tab. 
ENDSELECT. 

 

Exceptions 

Handleable Exceptions 

CX_SY_ARITHMETIC_OVERFLOW 
◾ Cause: Overflow in integer field when creating totals 
Runtime error: COLLECT_OVERFLOW 


◾ Cause: Overflow in type p field when creating totals 
Runtime error: COLLECT_OVERFLOW_TYPE_P 




Non-Handleable Exceptions 
◾ Cause: COLLECT used for non-numeric fields 
Runtime error: TABLE_COLLECT_CHAR_IN_FUNCTION 


◾ Cause: Memory area violated when TABLES parameter accessed 
Runtime error: ITAB_STRUC_ACCESS_VIOLATION 








