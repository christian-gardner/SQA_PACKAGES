CREATE OR REPLACE PACKAGE     SQA_REOINT
IS

/******************************************************
  Version # 1.0     CREATED 01/09/2017 Christian.gardner
 ******************************************************/


TYPE  GenRefCursor is REF CURSOR;
TYPE rowidArray is table of rowid index by binary_integer;


TYPE LOV_RECORD IS RECORD (
  CO1       VARCHAR2(20 BYTE),
  C02       VARCHAR2(20 BYTE),
  ITEMS       VARCHAR2(100 BYTE)
);

TYPE LOV_NESTED_TABLE IS TABLE OF LOV_RECORD;

FUNCTION LIST_S( P_TABLE_NAME VARCHAR2) RETURN LOV_NESTED_TABLE PIPELINED;

FUNCTION LIST_S( P_pid number) RETURN LOV_NESTED_TABLE PIPELINED;

END;

/

CREATE OR REPLACE PACKAGE BODY SQA_REOINT
IS


FUNCTION LIST_S( P_TABLE_NAME VARCHAR2) RETURN LOV_NESTED_TABLE PIPELINED
IS

LOV_NT_VARIABLE     LOV_NESTED_TABLE;

   GC                 GenRefCursor;
   SQL_STMT           VARCHAR2(32000);

   CURSOR C1 (TAB_NAME VARCHAR2)
   IS
   SELECT COLUMN_NAME, COLUMN_ID
   FROM ALL_TAB_COLUMNS
   WHERE TABLE_NAME = TAB_NAME
    AND  OWNER = 'RDM'
   ORDER BY COLUMN_ID;

   R1  C1%ROWTYPE;

 BEGIN

 OPEN C1 ( P_TABLE_NAME );
     LOOP
         FETCH C1 INTO R1;
         EXIT WHEN C1%NOTFOUND;

         SQL_STMT := SQL_STMT||R1.COLUMN_NAME||' AS C0'||R1.COLUMN_ID||',';


     END LOOP;
 CLOSE C1;

   SQL_STMT := RTRIM(SQL_STMT,',');


       LOV_NT_VARIABLE := LOV_NESTED_TABLE();


        SQL_STMT := 'SELECT '||SQL_STMT||' FROM '||P_TABLE_NAME;




   OPEN  GC FOR SQL_STMT;

       LOOP
           FETCH GC BULK COLLECT INTO LOV_NT_VARIABLE LIMIT 10000;
           EXIT WHEN LOV_NT_VARIABLE.COUNT = 0;

            for k in 1..LOV_NT_VARIABLE.COUNT  loop
                 PIPE ROW (LOV_NT_VARIABLE(k));
           end loop;

       END LOOP;

   CLOSE GC;


 END;

FUNCTION LIST_S( P_PID NUMBER) RETURN LOV_NESTED_TABLE PIPELINED
IS

LOV_NT_VARIABLE     LOV_NESTED_TABLE;

   GC                 GenRefCursor;
   SQL_STMT           VARCHAR2(32000 BYTE);
   P_TABLE_NAME       VARCHAR2(100 BYTE);

   CURSOR C1 (TAB_NAME VARCHAR2)
   IS
   SELECT COLUMN_NAME, COLUMN_ID
   FROM ALL_TAB_COLUMNS
   WHERE TABLE_NAME = TAB_NAME
    AND  OWNER = 'RDM'
   ORDER BY COLUMN_ID;

   R1  C1%ROWTYPE;

 BEGIN

 SELECT LOV_TABLE
  into p_table_name
  FROM SQA_LOV
  WHERE PID = P_PID;

 OPEN C1 ( P_TABLE_NAME );
     LOOP
         FETCH C1 INTO R1;
         EXIT WHEN C1%NOTFOUND;

         SQL_STMT := SQL_STMT||R1.COLUMN_NAME||' AS C0'||R1.COLUMN_ID||',';


     END LOOP;
 CLOSE C1;

   SQL_STMT := RTRIM(SQL_STMT,',');


       LOV_NT_VARIABLE := LOV_NESTED_TABLE();


        SQL_STMT := 'SELECT '||SQL_STMT||' FROM '||P_TABLE_NAME;




   OPEN  GC FOR SQL_STMT;

       LOOP
           FETCH GC BULK COLLECT INTO LOV_NT_VARIABLE LIMIT 10000;
           EXIT WHEN LOV_NT_VARIABLE.COUNT = 0;

            for k in 1..LOV_NT_VARIABLE.COUNT  loop
                 PIPE ROW (LOV_NT_VARIABLE(k));
           end loop;

       END LOOP;

   CLOSE GC;


 END;

end;

/
