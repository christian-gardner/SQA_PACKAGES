CREATE OR REPLACE PACKAGE     SQA_LOVS
IS

/******************************************************
  Version # 3.4

  TO DO
  :ADD A NEW PROCEDURE TO LOAD SPECIAL PROJECTS INTO ICC
  :ADD A NEW PROCEDURE TO INSERT SPECIAL PROJECTS TO ASSIGNMENT_TEMPLATE

 ******************************************************/


TYPE  GenRefCursor is REF CURSOR;
TYPE rowidArray is table of rowid index by binary_integer;

TYPE SQA_DATA_ARCH IS RECORD (
  PID    DBMS_SQL.NUMBER_TABLE,
  ROWIDS  rowidArray
);


TYPE SQA_TD_ASSIGN IS RECORD (
  PID          DBMS_SQL.NUMBER_TABLE,
  WORKING      DBMS_SQL.VARCHAR2_TABLE,
  SQA_TD_REP   DBMS_SQL.VARCHAR2_TABLE,
  REVIEW_ID    DBMS_SQL.NUMBER_TABLE,
  BATCH_NO     DBMS_SQL.NUMBER_TABLE,
  COMPLETED_DT DBMS_SQL.DATE_TABLE,
  RK           DBMS_SQL.NUMBER_TABLE
);


TYPE LOV_RECORD IS RECORD (
  CO1       VARCHAR2(20 BYTE),
  C02       VARCHAR2(20 BYTE),
  ITEMS       VARCHAR2(100 BYTE)
);

TYPE LOV_NESTED_TABLE IS TABLE OF LOV_RECORD;

-- SQA_LOVS.LIST_S

/*
SQA_VENDOR_LIST
(
  VENDOR_ID           NUMBER,
  VENDOR_CODE         VARCHAR2(40 BYTE),
  FOLLOW_UP           VARCHAR2(40 BYTE),
  FOLLOW_UP_SAT       VARCHAR2(40 BYTE),
  FOLLOW_UP_DTE       DATE,
  STANDING            NUMBER,
  NBR_WORKORDERS      NUMBER,
  ACTIVE              NUMBER,
  LAST_REVIEW         DATE,
  REVIEWED_BY         VARCHAR2(100 BYTE),
  SEGMENTS            VARCHAR2(10 BYTE),
  CAP_HOLD            NUMBER,
  BATCH_NO            NUMBER,
  WORKCODE            VARCHAR2(20 BYTE),
  ASSIGNED_TO         INTEGER,
  COMPLETED_BY        INTEGER,
  START_COUNTER_DATE  DATE,
  FOLLOW_UP_CAT       VARCHAR2(100 BYTE)
  THIRTY_FIFTY_DAY_RULE NUMBER
  assign_it             number
  FOLLOW_UP_RES       VARCHAR2(20 BYTE)
  NBR_COMPLETED        NUMBER
)
*/

TYPE SQA_TD_DATA_ETL_REC IS RECORD
(
SPIPROPERTYID       DBMS_SQL.VARCHAR2_TABLE,
LOANNUMBER          DBMS_SQL.VARCHAR2_TABLE,
LOANTYPE            DBMS_SQL.VARCHAR2_TABLE,
CLIENT              DBMS_SQL.VARCHAR2_TABLE,
ADDRESSLINE1        DBMS_SQL.VARCHAR2_TABLE,
ADDRESSLINE2        DBMS_SQL.VARCHAR2_TABLE,
CITY                DBMS_SQL.VARCHAR2_TABLE,
STATE               DBMS_SQL.VARCHAR2_TABLE,
ZIP                 DBMS_SQL.VARCHAR2_TABLE,
ORDERNUMBER         DBMS_SQL.VARCHAR2_TABLE,
ORDERDATE           DBMS_SQL.DATE_TABLE,
WORKCODE            DBMS_SQL.VARCHAR2_TABLE,
COMPLETEDDATE       DBMS_SQL.DATE_TABLE,
CONTRACTORCODE      DBMS_SQL.VARCHAR2_TABLE,
MORTGAGORNAME       DBMS_SQL.VARCHAR2_TABLE,
SALEDATE            DBMS_SQL.DATE_TABLE,
SECUREDDATE         DBMS_SQL.DATE_TABLE,
WINTERIZEDDATE      DBMS_SQL.DATE_TABLE,
INITIALICCDATE      DBMS_SQL.DATE_TABLE,
LASTICCDATE         DBMS_SQL.DATE_TABLE,
CONVEYDATE          DBMS_SQL.DATE_TABLE,
INVESTORNUMBER      DBMS_SQL.VARCHAR2_TABLE,
BILLINGCODE         DBMS_SQL.VARCHAR2_TABLE,
REPORT_SEGMENT      DBMS_SQL.VARCHAR2_TABLE,
WORK_GROUP          DBMS_SQL.VARCHAR2_TABLE,
NBR_QUESTIONS       DBMS_SQL.NUMBER_TABLE,
PID                 DBMS_SQL.NUMBER_TABLE
);


TYPE VENDORCODE_LIST IS RECORD
(

  VENDOR_ID             DBMS_SQL.NUMBER_TABLE,
  VENDOR_CODE           DBMS_SQL.VARCHAR2_TABLE,
  FOLLOW_UP             DBMS_SQL.VARCHAR2_TABLE,
  FOLLOW_UP_SAT         DBMS_SQL.VARCHAR2_TABLE,
  FOLLOW_UP_DTE         DBMS_SQL.DATE_TABLE,
  STANDING              DBMS_SQL.NUMBER_TABLE,
  NBR_WORKORDERS        DBMS_SQL.NUMBER_TABLE,
  ACTIVE                DBMS_SQL.NUMBER_TABLE,
  LAST_REVIEW           DBMS_SQL.DATE_TABLE,
  REVIEWED_BY           DBMS_SQL.VARCHAR2_TABLE,
  SEGMENTS              DBMS_SQL.VARCHAR2_TABLE,
  CAP_HOLD              DBMS_SQL.NUMBER_TABLE,
  BATCH_NO              DBMS_SQL.NUMBER_TABLE,
  WORKCODE              DBMS_SQL.VARCHAR2_TABLE,
  ASSIGNED_TO           DBMS_SQL.NUMBER_TABLE,
  COMPLETED_BY          DBMS_SQL.NUMBER_TABLE,
  START_COUNTER_DATE    DBMS_SQL.DATE_TABLE,
  FOLLOW_UP_CAT         DBMS_SQL.VARCHAR2_TABLE,
  THIRTY_FIFTY_DAY_RULE dbms_sql.number_table,
  ASSIGN_IT             DBMS_SQL.NUMBER_TABLE,
  FOLLOW_UP_RES         DBMS_SQL.VARCHAR2_TABLE,
  NBR_COMPLETED         DBMS_SQL.NUMBER_TABLE,
  ROWIDS                rowidArray
);

TYPE VENDOR_SEGMENTS IS RECORD
(
 VENDOR_CODE      DBMS_SQL.VARCHAR2_TABLE,
 SEGMENTS         DBMS_SQL.VARCHAR2_TABLE
);

TYPE VENDORCODE_WRK IS RECORD
(
  VENDOR_CODE     DBMS_SQL.VARCHAR2_TABLE,
  SEGMENTS        DBMS_SQL.VARCHAR2_TABLE
);

TYPE CAP_HOLD IS RECORD
(
 VENDOR_ID       DBMS_SQL.NUMBER_TABLE,
 CAP_HOLD        DBMS_SQL.NUMBER_TABLE,
 ROWIDS          RowidArray
);

cp         CAP_HOLD;

TYPE LINE_OUT IS RECORD(
LINES     DBMS_SQL.VARCHAR2_TABLE
);

LO     LINE_OUT;



TYPE SUMMARYS IS RECORD
(
  PREVIEW_ID     DBMS_SQL.NUMBER_TABLE,
  PCOLUMN_NAME   DBMS_SQL.VARCHAR2_TABLE,
  PHEADING       DBMS_SQL.VARCHAR2_TABLE,
  PYES           DBMS_SQL.NUMBER_TABLE,
  PGRADE         DBMS_SQL.VARCHAR2_TABLE,
  PCOLUMN_NBR    DBMS_SQL.VARCHAR2_TABLE
);
SUMS     SUMMARYS;

TYPE DYN_STMT_REC IS RECORD
(
   DYN_STMT   DBMS_SQL.VARCHAR2_TABLE
);


TYPE PAGE_341 IS RECORD
(
DATA_DT                 DBMS_SQL.DATE_TABLE,
ST                      DBMS_SQL.VARCHAR2_TABLE,
CONTRACTOR              DBMS_SQL.VARCHAR2_TABLE,
CLIENT                  DBMS_SQL.VARCHAR2_TABLE,
LOAN_TYPE               DBMS_SQL.VARCHAR2_TABLE,
ORDER_DT                DBMS_SQL.DATE_TABLE,
COMPLETED_DT            DBMS_SQL.DATE_TABLE,
ORDER_NUM               DBMS_SQL.VARCHAR2_TABLE,
SWEEPING                DBMS_SQL.VARCHAR2_TABLE,
VACUUMING               DBMS_SQL.VARCHAR2_TABLE,
MOPPING                 DBMS_SQL.VARCHAR2_TABLE,
WIPING_SURFACES         DBMS_SQL.VARCHAR2_TABLE,
INSIDE_ALL_TOILETS      DBMS_SQL.VARCHAR2_TABLE,
INSIDE_OUT_APPLIANCES   DBMS_SQL.VARCHAR2_TABLE,
INSIDE_ALL_CLOSETS      DBMS_SQL.VARCHAR2_TABLE,
ENTIRE_BASEMENT         DBMS_SQL.VARCHAR2_TABLE,
SAFETY_HAZARD_AREA      DBMS_SQL.VARCHAR2_TABLE,
CIRCUIT_BREAKER         DBMS_SQL.VARCHAR2_TABLE,
AIR_FRESHENERS_DATED    DBMS_SQL.VARCHAR2_TABLE,
SHOW_ALL_AIR_FRESHENERS DBMS_SQL.VARCHAR2_TABLE,
CHECKLIST               DBMS_SQL.VARCHAR2_TABLE,
VOLT_STICK              DBMS_SQL.VARCHAR2_TABLE,
LOCKBOX                 DBMS_SQL.VARCHAR2_TABLE,
FRONT_OF_HOUSE          DBMS_SQL.VARCHAR2_TABLE,
ADDRESS_PHOTO           DBMS_SQL.VARCHAR2_TABLE,
RIGHT_LEFT_SIDE_OF_HOUSE  DBMS_SQL.VARCHAR2_TABLE,
BACK_OF_PROPERTY        DBMS_SQL.VARCHAR2_TABLE,
GATE_ALLOWING_ENTRY     DBMS_SQL.VARCHAR2_TABLE,
UP_DOWN_STREET          DBMS_SQL.VARCHAR2_TABLE,
BEHIND_BUILDING_GARAGE  DBMS_SQL.VARCHAR2_TABLE,
COMMENTS                DBMS_SQL.CLOB_TABLE
);

TYPE PAGE_342 IS RECORD
(
DATA_DT               DBMS_SQL.DATE_TABLE,
ST                    DBMS_SQL.VARCHAR2_TABLE,
CONTRACTOR            DBMS_SQL.VARCHAR2_TABLE,
CLIENT                DBMS_SQL.VARCHAR2_TABLE,
LOAN_TYPE             DBMS_SQL.VARCHAR2_TABLE,
ORDER_DT              DBMS_SQL.DATE_TABLE,
COMPLETED_DT          DBMS_SQL.DATE_TABLE,
ORDER_NUM             DBMS_SQL.VARCHAR2_TABLE,
SWEEPING              DBMS_SQL.VARCHAR2_TABLE,
VACUUMING             DBMS_SQL.VARCHAR2_TABLE,
MOPPING               DBMS_SQL.VARCHAR2_TABLE,
WIPING_SURFACES       DBMS_SQL.VARCHAR2_TABLE,
INSIDE_ALL_TOILETS    DBMS_SQL.VARCHAR2_TABLE,
INSIDE_OUT_APPLIANCES DBMS_SQL.VARCHAR2_TABLE,
SAFETY_HAZARD_AREA    DBMS_SQL.VARCHAR2_TABLE,
AIR_FRESHENERS_DATED  DBMS_SQL.VARCHAR2_TABLE,
CHECKLIST             DBMS_SQL.VARCHAR2_TABLE,
VOLT_STICK            DBMS_SQL.VARCHAR2_TABLE,
FRONT_OF_HOUSE        DBMS_SQL.VARCHAR2_TABLE,
COMMENTS              DBMS_SQL.CLOB_TABLE
);

TYPE PAGE_343 IS RECORD
(
DATA_DT                         DBMS_SQL.DATE_TABLE,
ST                              DBMS_SQL.VARCHAR2_TABLE,
CONTRACTOR                      DBMS_SQL.VARCHAR2_TABLE,
CLIENT                          DBMS_SQL.VARCHAR2_TABLE,
LOAN_TYPE                       DBMS_SQL.VARCHAR2_TABLE,
ORDER_DT                        DBMS_SQL.DATE_TABLE,
COMPLETED_DT                    DBMS_SQL.DATE_TABLE,
ORDER_NUM                       DBMS_SQL.VARCHAR2_TABLE,
FRONT_OF_HOUSE                  DBMS_SQL.VARCHAR2_TABLE,
FOUR_SIDES_OF_HOUSE             DBMS_SQL.VARCHAR2_TABLE,
BACK_OF_PROPERTY                DBMS_SQL.VARCHAR2_TABLE,
GATE_ALLOWING_ENTRY             DBMS_SQL.VARCHAR2_TABLE,
BA_FRONT_YARD                   DBMS_SQL.VARCHAR2_TABLE,
BA_BACK_YARD                    DBMS_SQL.VARCHAR2_TABLE,
WEED_WHACKING                   DBMS_SQL.VARCHAR2_TABLE,
EDGED_PAVED_AREAS               DBMS_SQL.VARCHAR2_TABLE,
FENCE_FOUNDATION_NO_WEEDS       DBMS_SQL.VARCHAR2_TABLE,
FLOWER_ROCKSCAPE_FREE_OF_WEEDS  DBMS_SQL.VARCHAR2_TABLE,
BEHIND_BUILDING_GARAGE          DBMS_SQL.VARCHAR2_TABLE,
UNDER_PORCH_DECK                DBMS_SQL.VARCHAR2_TABLE,
SHRUBS_CUT_WHEN_NEEDED          DBMS_SQL.VARCHAR2_TABLE,
RULER_PHOT0_TWO_INCHES          DBMS_SQL.VARCHAR2_TABLE,
LOCKBOX                         DBMS_SQL.VARCHAR2_TABLE,
ADDRESS_PHOTO                   DBMS_SQL.VARCHAR2_TABLE,
UP_DOWN_STREET                  DBMS_SQL.VARCHAR2_TABLE,
COMMENTS                        DBMS_SQL.CLOB_TABLE
);


TYPE PAGE_344 IS RECORD
(
DATA_DT                     DBMS_SQL.DATE_TABLE,
ST                          DBMS_SQL.VARCHAR2_TABLE,
CONTRACTOR                  DBMS_SQL.VARCHAR2_TABLE,
CLIENT                      DBMS_SQL.VARCHAR2_TABLE,
LOAN_TYPE                   DBMS_SQL.VARCHAR2_TABLE,
ORDER_DT                    DBMS_SQL.DATE_TABLE,
COMPLETED_DT                DBMS_SQL.DATE_TABLE,
ORDER_NUM                   DBMS_SQL.VARCHAR2_TABLE,
FRONT_OF_HOUSE              DBMS_SQL.VARCHAR2_TABLE,
FOUR_SIDES_OF_HOUSE         DBMS_SQL.VARCHAR2_TABLE,
BA_FRONT_YARD               DBMS_SQL.VARCHAR2_TABLE,
BA_BACK_YARD                DBMS_SQL.VARCHAR2_TABLE,
WEED_WHACKING               DBMS_SQL.VARCHAR2_TABLE,
EDGED_PAVED_AREAS           DBMS_SQL.VARCHAR2_TABLE,
FENCE_FOUNDATION_NO_WEEDS   DBMS_SQL.VARCHAR2_TABLE,
FLOWER_ROCKSCAPE_FREE_OF_WEEDS  DBMS_SQL.VARCHAR2_TABLE,
BEHIND_BUILDING_GARAGE      DBMS_SQL.VARCHAR2_TABLE,
UNDER_PORCH_DECK            DBMS_SQL.VARCHAR2_TABLE,
SHRUBS_CUT_WHEN_NEEDED      DBMS_SQL.VARCHAR2_TABLE,
RULER_PHOT0_TWO_INCHES      DBMS_SQL.VARCHAR2_TABLE,
COMMENTS                    DBMS_SQL.CLOB_TABLE
);

TYPE PAGE_345 IS RECORD
(
DATA_DT                   DBMS_SQL.DATE_TABLE,
ST                        DBMS_SQL.VARCHAR2_TABLE,
CONTRACTOR                DBMS_SQL.VARCHAR2_TABLE,
CLIENT                    DBMS_SQL.VARCHAR2_TABLE,
LOAN_TYPE                 DBMS_SQL.VARCHAR2_TABLE,
ORDER_DT                  DBMS_SQL.DATE_TABLE,
COMPLETED_DT              DBMS_SQL.DATE_TABLE,
ORDER_NUM                 DBMS_SQL.VARCHAR2_TABLE,
BA_FRONT_YARD             DBMS_SQL.VARCHAR2_TABLE,
BA_BACK_YARD              DBMS_SQL.VARCHAR2_TABLE,
FOUR_SIDES_OF_HOUSE       DBMS_SQL.VARCHAR2_TABLE,
FENCE_FOUNDATION_NO_WEEDS   DBMS_SQL.VARCHAR2_TABLE,
DRIVE_WALK_FREE_OF_WEEDS    DBMS_SQL.VARCHAR2_TABLE,
FLOWER_ROCKSCAPE_FREE_OF_WEEDS   DBMS_SQL.VARCHAR2_TABLE,
EDGED_PAVED_AREAS           DBMS_SQL.VARCHAR2_TABLE,
CLIPPINGS_LEAVES_REMOVED    DBMS_SQL.VARCHAR2_TABLE,
SHRUBS_CUT_WHEN_NEEDED      DBMS_SQL.VARCHAR2_TABLE,
RULER_PHOT0_TWO_INCHES      DBMS_SQL.VARCHAR2_TABLE,
COMMENTS                    DBMS_SQL.CLOB_TABLE
);

GV_TESTING   NUMBER;
GV_30_RULE   NUMBER;
GV_50_RULE   NUMBER;
GV_100_RULE  NUMBER;
GV_CURRENT_DATE DATE;


c_inline_with_field            constant varchar2(40):='INLINE_WITH_FIELD';
c_inline_with_field_and_notif  constant varchar2(40):='INLINE_WITH_FIELD_AND_NOTIFICATION';
c_inline_in_notification       constant varchar2(40):='INLINE_IN_NOTIFICATION';
c_on_error_page                constant varchar2(40):='ON_ERROR_PAGE';

----------The following constants are used for the API parameter associated_type in the t_error type.

c_ass_type_page_item           constant varchar2(30):='PAGE_ITEM';
c_ass_type_region              constant varchar2(30):='REGION';
c_ass_type_region_column       constant varchar2(30):='REGION_COLUMN';


-------------The following type is passed into an error handling function and contains all of the relevant error information.

type t_error is record (
    message           varchar2(32767),     /* Displayed error message */
    additional_info   varchar2(32767),     /* Only used for display_location ON_ERROR_PAGE to display additional error information */
    display_location  varchar2(40),        /* Use constants "used for display_location" below */
    association_type  varchar2(40),        /* Use constants "used for asociation_type" below */
    page_item_name    varchar2(255),       /* Associated page item name */
    region_id         number,              /* Associated tabular form region id of the primary application */
    column_alias      varchar2(255),       /* Associated tabular form column alias */
    row_num           pls_integer,         /* Associated tabular form row */
    is_internal_error boolean,             /* Set to TRUE if it's a critical error raised by the Application Express engine, like an invalid SQL/PLSQL statements, ... Internal Errors are always displayed on the Error Page */
    apex_error_code   varchar2(255),       /* Contains the system message code if it's an error raised by Application Express */
    ora_sqlcode       number,              /* SQLCODE on exception stack which triggered the error, NULL if the error was not raised by an ORA error */
    ora_sqlerrm       varchar2(32767),     /* SQLERRM which triggered the error, NULL if the error was not raised by an ORA error */
    error_backtrace   varchar2(32767),     /* Output of dbms_utility.format_error_backtrace or dbms_utility.format_call_stack */
    component         wwv_flow.t_component /* Component which has been processed when the error occurred */
    );



TYPE EIM_FIPINT_DAILY_REC IS RECORD
(
LOANNUMBER                  DBMS_SQL.VARCHAR2_TABLE,
ORDERNUMBER                 DBMS_SQL.VARCHAR2_TABLE,
WORKCODE                    DBMS_SQL.VARCHAR2_TABLE,
CLIENT_CODE                 DBMS_SQL.VARCHAR2_TABLE,
COMPLETIONENTEREDDATE       DBMS_SQL.VARCHAR2_TABLE,
COMPLETEDDATE               DBMS_SQL.VARCHAR2_TABLE,
SALEDATE                    DBMS_SQL.VARCHAR2_TABLE,
ISPOOLSECURE                DBMS_SQL.VARCHAR2_TABLE,
ISHOTTUBSECURE              DBMS_SQL.VARCHAR2_TABLE,
SUMPPUMP                    DBMS_SQL.VARCHAR2_TABLE,
ISSUMPPUMPOPERATIONAL       DBMS_SQL.VARCHAR2_TABLE,
DEHUMIDIFIER                DBMS_SQL.VARCHAR2_TABLE,
ISDEHUMIDIFIEROPERATIONAL   DBMS_SQL.VARCHAR2_TABLE,
GARAGESECURE                DBMS_SQL.VARCHAR2_TABLE,
OUTBUILDINGSECURE           DBMS_SQL.VARCHAR2_TABLE,
CRAWLSPACESECURE            DBMS_SQL.VARCHAR2_TABLE,
GRASSHEIGHT                 DBMS_SQL.NUMBER_TABLE,
PROPERTYSECURE              DBMS_SQL.VARCHAR2_TABLE,
NEWDAMAGE                   DBMS_SQL.VARCHAR2_TABLE,
SEVEREDAMAGE                DBMS_SQL.VARCHAR2_TABLE,
ISROOFTARPED                DBMS_SQL.VARCHAR2_TABLE,
ACTIVEROOFLEAK              DBMS_SQL.VARCHAR2_TABLE,
ACUNIT                      DBMS_SQL.VARCHAR2_TABLE,
ANTIFREEZEINALL             DBMS_SQL.VARCHAR2_TABLE,
GAINACCESS                  DBMS_SQL.VARCHAR2_TABLE,
OCCUPANCYSTATUS             DBMS_SQL.VARCHAR2_TABLE,
LOANTYPE                    DBMS_SQL.VARCHAR2_TABLE,
FLOOD                       DBMS_SQL.VARCHAR2_TABLE,
MOLD                        DBMS_SQL.VARCHAR2_TABLE,
ROOFLEAK                    DBMS_SQL.VARCHAR2_TABLE,
VANDALISM                   DBMS_SQL.VARCHAR2_TABLE,
PERSONALPROPERTY            DBMS_SQL.VARCHAR2_TABLE,
DEBRIS                      DBMS_SQL.VARCHAR2_TABLE,
CITATION                    DBMS_SQL.VARCHAR2_TABLE,
CONVEYDATE                  DBMS_SQL.DATE_TABLE,
CURRENTICCSTATUS            DBMS_SQL.VARCHAR2_TABLE
);

TYPE EIM_INTICC_DAILY_REC IS RECORD
(
LOANNUMBER                  DBMS_SQL.VARCHAR2_TABLE,
ORDERNUMBER                 DBMS_SQL.VARCHAR2_TABLE,
WORKCODE                    DBMS_SQL.VARCHAR2_TABLE,
CLIENTCODE                  DBMS_SQL.VARCHAR2_TABLE,
COMPLETIONENTEREDDATE_FK    DBMS_SQL.VARCHAR2_TABLE,
COMPLETEDDATE_FK            DBMS_SQL.VARCHAR2_TABLE,
SALEDATE                    DBMS_SQL.VARCHAR2_TABLE,
ISPOOLSECURE                DBMS_SQL.VARCHAR2_TABLE,
ISHOTTUBSECURE              DBMS_SQL.VARCHAR2_TABLE,
SUMPPUMP                    DBMS_SQL.VARCHAR2_TABLE,
ISSUMPPUMPOPERATIONAL       DBMS_SQL.VARCHAR2_TABLE,
DEHUMIDIFIER                DBMS_SQL.VARCHAR2_TABLE,
ISDEHUMIDIFIEROPERATIONAL   DBMS_SQL.VARCHAR2_TABLE,
GARAGESECURE                DBMS_SQL.VARCHAR2_TABLE,
OUTBUILDINGSECURE           DBMS_SQL.VARCHAR2_TABLE,
CRAWLSPACESECURE            DBMS_SQL.VARCHAR2_TABLE,
GRASSHEIGHT                 DBMS_SQL.NUMBER_TABLE,
PROPERTYSECURE              DBMS_SQL.VARCHAR2_TABLE,
NEWDAMAGE                   DBMS_SQL.VARCHAR2_TABLE,
SEVEREDAMAGE                DBMS_SQL.VARCHAR2_TABLE,
ISROOFTARPED                DBMS_SQL.VARCHAR2_TABLE,
ACTIVEROOFLEAK              DBMS_SQL.VARCHAR2_TABLE,
ACUNIT                      DBMS_SQL.VARCHAR2_TABLE,
ANTIFREEZEINALL             DBMS_SQL.VARCHAR2_TABLE,
GAINACCESS                  DBMS_SQL.VARCHAR2_TABLE,
OCCUPANCYSTATUS             DBMS_SQL.VARCHAR2_TABLE,
LOANTYPE                    DBMS_SQL.VARCHAR2_TABLE
);


TYPE SQA_ICC_CARDS_REC IS RECORD
(
LOAN              DBMS_SQL.VARCHAR2_TABLE,
MORT_NAME         DBMS_SQL.VARCHAR2_TABLE,
ADDRESS_LINE1     DBMS_SQL.VARCHAR2_TABLE,
ADDRESS_LINE2     DBMS_SQL.VARCHAR2_TABLE,
CITY              DBMS_SQL.VARCHAR2_TABLE,
STATE             DBMS_SQL.VARCHAR2_TABLE,
ZIP               DBMS_SQL.VARCHAR2_TABLE,
SALE_DT           DBMS_SQL.VARCHAR2_TABLE,
SECURED_DT        DBMS_SQL.VARCHAR2_TABLE,
WINTERIZED_DT     DBMS_SQL.VARCHAR2_TABLE,
INITIAL_ICC_DT    DBMS_SQL.VARCHAR2_TABLE,
REPORTED_ICC_DT   DBMS_SQL.VARCHAR2_TABLE,
COMPLETED_ICC_DT  DBMS_SQL.VARCHAR2_TABLE,
CONVEY_DATE       DBMS_SQL.VARCHAR2_TABLE,
INVESTOR          DBMS_SQL.VARCHAR2_TABLE,
CLIENT            DBMS_SQL.VARCHAR2_TABLE,
LOAD_ID           DBMS_SQL.NUMBER_TABLE,
FILE_ID           DBMS_SQL.NUMBER_TABLE
);


TYPE  EIM_PROPERTY_CONVEY_COND_REC IS RECORD
(
LOANNUMBER              DBMS_SQL.VARCHAR2_TABLE,
ORDERNUMBER             DBMS_SQL.VARCHAR2_TABLE,
ORDERSTATUS             DBMS_SQL.VARCHAR2_TABLE,
SPIPROPERTYID           DBMS_SQL.VARCHAR2_TABLE,
CLIENTCODE              DBMS_SQL.VARCHAR2_TABLE,
LOAN_LOANTYPE           DBMS_SQL.VARCHAR2_TABLE,
WORKCODE                DBMS_SQL.VARCHAR2_TABLE,
COMPLETEDDATE_FK        DBMS_SQL.VARCHAR2_TABLE,
COMPLETIONENTEREDDATE   DBMS_SQL.VARCHAR2_TABLE,
MODIFYDATE              DBMS_SQL.VARCHAR2_TABLE,
LASTICCDATE             DBMS_SQL.VARCHAR2_TABLE,
INITIALICCDATE          DBMS_SQL.VARCHAR2_TABLE,
ZCONVEYSTATUS           DBMS_SQL.VARCHAR2_TABLE
);


TYPE EIM_WORKORDER_RECONVEY_REC IS RECORD
(
LOANNUMBER             DBMS_SQL.VARCHAR2_TABLE,
CLIENTCODE             DBMS_SQL.VARCHAR2_TABLE,
LOANTYPE               DBMS_SQL.VARCHAR2_TABLE,
WORKCODE               DBMS_SQL.VARCHAR2_TABLE,
ORDERNUMBER            DBMS_SQL.VARCHAR2_TABLE,
COMPLETEDDATE_FK       DBMS_SQL.VARCHAR2_TABLE,
ORDERDATE_FK           DBMS_SQL.VARCHAR2_TABLE
);


TYPE EIM_LOAN_RECONVEY_REC IS RECORD
(
LOANNUMBER         DBMS_SQL.VARCHAR2_TABLE,
CLIENTCODE         DBMS_SQL.VARCHAR2_TABLE,
LOANTYPE           DBMS_SQL.VARCHAR2_TABLE,
CONVEYDATE         DBMS_SQL.DATE_TABLE,
RECONVEYDATE       DBMS_SQL.DATE_TABLE
);



Type  EIM_OPEN_FHA_CLAIM_REC  IS RECORD
(
LOANNUMBER        DBMS_SQL.VARCHAR2_TABLE,
ORDERNUMBER       DBMS_SQL.VARCHAR2_TABLE,
CLIENTCODE        DBMS_SQL.VARCHAR2_TABLE,
RECONVEYDATE      DBMS_SQL.VARCHAR2_TABLE,
CONVEYSTATUS      DBMS_SQL.VARCHAR2_TABLE,
SALEDATE          DBMS_SQL.VARCHAR2_TABLE,
WORKCODEDESC      DBMS_SQL.VARCHAR2_TABLE,
ORDERDATE         DBMS_SQL.VARCHAR2_TABLE
);


TYPE  SQA_ICC_PRIOR_LOAN_HIST_REC  IS RECORD
(
PID                     DBMS_SQL.NUMBER_TABLE,
LOAN_NBR                DBMS_SQL.VARCHAR2_TABLE,
CLIENT_CODE             DBMS_SQL.VARCHAR2_TABLE,
REVIEWED_BY             DBMS_SQL.VARCHAR2_TABLE,
OUTCOME                 DBMS_SQL.VARCHAR2_TABLE,
COMMENTS                DBMS_SQL.VARCHAR2_TABLE,
ICC_DECISION            DBMS_SQL.VARCHAR2_TABLE,
CASIS_ALL_ICC           DBMS_SQL.VARCHAR2_TABLE,
DATE_UPLOADED           DBMS_SQL.DATE_TABLE,
DATE_TO_REVIEW          DBMS_SQL.DATE_TABLE,
ACTUAL_REVIEW_DATE      DBMS_SQL.DATE_TABLE,
DISPUTE                 DBMS_SQL.VARCHAR2_TABLE,
NBR_IMP                 DBMS_SQL.NUMBER_TABLE,
IMP_ID                  DBMS_SQL.NUMBER_TABLE,
NBR_REVERSALS           DBMS_SQL.NUMBER_TABLE,
TRUE_OUTCOME            DBMS_SQL.VARCHAR2_TABLE,
CAR_ASSIGNED            DBMS_SQL.VARCHAR2_TABLE,
UPDATER                 DBMS_SQL.VARCHAR2_TABLE,
BILLER                  DBMS_SQL.VARCHAR2_TABLE,
CASE_NBR                DBMS_SQL.VARCHAR2_TABLE,
STATE                   DBMS_SQL.VARCHAR2_TABLE,
CLIENT_LOAN_STATUS      DBMS_SQL.VARCHAR2_TABLE,
FTV                     DBMS_SQL.VARCHAR2_TABLE,
SALE_DATE               DBMS_SQL.DATE_TABLE,
CUR_CONVEY_DEADLINE     DBMS_SQL.DATE_TABLE,
INITIAL_ICC_DATE        DBMS_SQL.DATE_TABLE,
ICC_DATE                DBMS_SQL.DATE_TABLE
);


TYPE SQA_ICC_ASSIGNMENT_TEMP IS RECORD
(
   LOAN_NUMBER           DBMS_SQL.VARCHAR2_TABLE,
   CLIENTCODE            DBMS_SQL.VARCHAR2_TABLE,
   BACKLOG               DBMS_SQL.VARCHAR2_TABLE,
   ROWIDS                rowidArray
);


--- CAR_PROCESSOR, CLIENT, COMPLETED, DATE_TO_REVIEW, DATE_UPLOADED, LOANNUMBER, PICK_ORDER, PID, REVIEWER
TYPE ICC_BACKLOG_LIST IS RECORD
(
   LOANNUMBER            DBMS_SQL.VARCHAR2_TABLE,
   CLIENT                DBMS_SQL.VARCHAR2_TABLE,
   REVIEWER              DBMS_SQL.VARCHAR2_TABLE,
   CAR_PROCESSOR         DBMS_SQL.VARCHAR2_TABLE,
   DATE_UPLOADED         DBMS_SQL.DATE_TABLE,
   DATE_TO_REVIEW        DBMS_SQL.DATE_TABLE,
   PICK_ORDER            DBMS_SQL.NUMBER_TABLE,
   ROWIDS                rowidArray
);


function apex_error_handling ( p_error in apex_error.t_error ) return apex_error.t_error_result;

PROCEDURE PULL_WORKORDER_DATA;

procedure ARCHIVE_SQA_DATA;


FUNCTION LIST_S( P_TABLE_NAME VARCHAR2) RETURN LOV_NESTED_TABLE PIPELINED;

FUNCTION LIST_S( P_pid number) RETURN LOV_NESTED_TABLE PIPELINED;

FUNCTION max_standing (P_STANDING NUMBER) RETURN number;

PROCEDURE CALC_SCORE (P_PID NUMBER);

procedure SET_NBR_VENDOR_WO;

procedure SET_REP_WORK_QUEUE(P_APP_USER VARCHAR2, P_VENDOR_ID NUMBER, P_VENDOR_NAME VARCHAR2, P_NUMBER_TO_REVIEW NUMBER);

PROCEDURE ADD_VENDOR_TO_LIST;

PROCEDURE SETUP_CAP_HOLD_FLAG;

PROCEDURE SET_CAP_HOLD_FLAG( P_VENDOR_ID NUMBER, P_CAP_HOLD NUMBER) ;

PROCEDURE UPD_CAP_HOLD_FLAG;


PROCEDURE GEN_EMAILS ( P_PAGE_NO NUMBER, P_REVIEWID NUMBER,  P_CLIENT VARCHAR2, P_LOAN_TYPE VARCHAR2, P_WORK_CODE VARCHAR2, P_VENDORID NUMBER);

procedure CLOSE_REP_WORK_QUEUE
(
P_APP_USER VARCHAR2,
P_VENDOR_ID NUMBER
);


procedure UPDATE_REP_WORK_QUEUE(P404_CAP_HOLD      NUMBER,
                                P404_FOLLOW_UP     VARCHAR2,
                                P404_FOLLOW_UP_SAT VARCHAR2,
                                P404_REVIEWED_BY   VARCHAR2,
                                P404_STANDING      NUMBER,
                                P404_VENDOR_CODE   VARCHAR2,
                                P404_VENDOR_ID     NUMBER);

PROCEDURE ASSIGN_REVIEWS;

PROCEDURE LOAD_ICC_FILES
(
P_FILE_type NUMBER
);

PROCEDURE SET_SYS_VARIABLES;

PROCEDURE MOVE_ETL_TO_DATA
(
P_CURRENT_DATE DATE
);

PROCEDURE MOVE_ETL_TO_DATA;

PROCEDURE ADD_DATA_TO_ETL;


PROCEDURE RUN_PROCESS;


PROCEDURE ICC_QC_ASSIGNMENT;

PROCEDURE ICC_QC_ASSIGNMENT_PROD;

PROCEDURE ICC_MANAGE_WORKLOAD
(
PAPP_ID       NUMBER,
PPAGE_ID      NUMBER,
PREPORT_NAME  VARCHAR2,
PAPPL_USER    VARCHAR2,
PASSIGN_TO    VARCHAR2,
PLIMIT        VARCHAR2
);

PROCEDURE QAP_ICC_REVIEWS
(
P643_PID         NUMBER,
P643_DID_QC_PASS VARCHAR2,
P643_COMMENTS    VARCHAR2
);


PROCEDURE ICC_REASSIGN_WORKLOAD
(
PAPP_ID       NUMBER,
PPAGE_ID      NUMBER,
PREPORT_NAME  VARCHAR2,
PAPPL_USER    VARCHAR2,
PASSIGN_FROM  VARCHAR2,
PASSIGN_TO    VARCHAR2,
PLIMIT        VARCHAR2
);


PROCEDURE ICC_MERGE_TEMP_TO_BACKLOG
(
PAPP_ID       NUMBER,
PPAGE_ID      NUMBER,
PREPORT_NAME  VARCHAR2,
PAPPL_USER    VARCHAR2
);

PROCEDURE LOAD_QAPP_PROJECT_FILES
(
P_FILE_type NUMBER
);

PROCEDURE ICC_CLEAR_BACKLOG;


END;

/

CREATE OR REPLACE PACKAGE BODY SQA_LOVS
IS

/******************************************************
  Version # 3.2
 ******************************************************/


function apex_error_handling ( p_error in apex_error.t_error ) return apex_error.t_error_result
is
    l_result          apex_error.t_error_result;
    l_reference_id    number;
    l_constraint_name varchar2(255);
begin

    l_result := apex_error.init_error_result (
                    p_error => p_error );

    -- If it's an internal error raised by APEX, like an invalid statement or
    -- code which cannot be executed, the error text might contain security sensitive
    -- information. To avoid this security problem rewrite the error to
    -- a generic error message and log the original error message for further
    -- investigation by the help desk.

    if p_error.is_internal_error then
        -- Access Denied errors raised by application or page authorization should
        -- still show up with the original error message
        if    p_error.apex_error_code <> 'APEX.AUTHORIZATION.ACCESS_DENIED'    and p_error.apex_error_code not like 'APEX.SESSION_STATE.%' then
            -- log error for example with an autonomous transaction and return
            -- l_reference_id as reference#
            -- l_reference_id := log_error (
            --                       p_error => p_error );
            --

            -- Change the message to the generic error message which is not exposed
            -- any sensitive information.
            l_result.message         := 'An unexpected internal application error has occurred. '||
                                        'Please get in contact with RDM Team and provide '||
                                        'reference# '||to_char(l_reference_id, '999G999G999G990')||
                                        ' for further investigation.';
            l_result.additional_info := null;
        end if;
    else
        -- Always show the error as inline error
        -- Note: If you have created manual tabular forms (using the package
        --       apex_item/htmldb_item in the SQL statement) you should still
        --       use "On error page" on that pages to avoid loosing entered data
        l_result.display_location := case
                                       when l_result.display_location = apex_error.c_on_error_page then apex_error.c_inline_in_notification
                                       else l_result.display_location
                                     end;
       -- If it's a constraint violation like
        --
        --   -) ORA-00001: unique constraint violated
        --   -) ORA-02091: transaction rolled back (-> can hide a deferred constraint)
        --   -) ORA-02290: check constraint violated
        --   -) ORA-02291: integrity constraint violated - parent key not found
        --   -) ORA-02292: integrity constraint violated - child record found
        --
        -- try to get a friendly error message from our constraint lookup configuration.
        -- If the constraint in our lookup table is not found, fallback to
        -- the original ORA error message.
        if p_error.ora_sqlcode in (-1, -2091, -2290, -2291, -2292) then
            l_constraint_name := apex_error.extract_constraint_name (
                                     p_error => p_error );

--            begin
--                select message
--                  into l_result.message
--                  from constraint_lookup
--                 where constraint_name = l_constraint_name;
--            exception when no_data_found then null; -- not every constraint has to be in our lookup table
--            end;
        end if;

        -- If an ORA error has been raised, for example a raise_application_error(-20xxx, '...')
        -- in a table trigger or in a PL/SQL package called by a process and the
        -- error has not been found in the lookup table, then display
        -- the actual error text and not the full error stack with all the ORA error numbers.
        if p_error.ora_sqlcode is not null and l_result.message = p_error.message then
            l_result.message := apex_error.get_first_ora_error_text (
                                    p_error => p_error );
        end if;

        -- If no associated page item/tabular form column has been set, use
        -- apex_error.auto_set_associated_item to automatically guess the affected
        -- error field by examine the ORA error for constraint names or column names.
        if l_result.page_item_name is null and l_result.column_alias is null then
            apex_error.auto_set_associated_item (
                p_error        => p_error,
                p_error_result => l_result );
        end if;
    end if;

    return l_result;
END;

PROCEDURE PULL_WORKORDER_DATA
IS

CURSOR C1
IS
SELECT A.CLIENT, A.LOANTYPE, A.WORKCODE
FROM SQA_WORKORDER_MV A
GROUP BY A.CLIENT, A.LOANTYPE, A.WORKCODE
ORDER BY A.CLIENT, A.LOANTYPE, A.WORKCODE;

R1  C1%ROWTYPE;

SQL_STMT VARCHAR2(32000 BYTE);
SQLROWS  NUMBER;

BEGIN

OPEN C1;
     LOOP
       FETCH C1 INTO R1;
       EXIT WHEN C1%NOTFOUND;


SQL_STMT := ' SELECT  COUNT(*) ';
SQL_STMT := SQL_STMT||' FROM SQA_WORKORDER_MV A';
SQL_STMT := SQL_STMT||' LEFT JOIN ( SELECT  SPIPROPERTYID, LOANNUMBER, ORDER_NUM FROM SQA_TD_DATA) B ON ( A.SPIPROPERTYID = B.SPIPROPERTYID  AND A.LOANNUMBER    = B.LOANNUMBER  AND   A.ORDERNUMBER   =  B.ORDER_NUM )';
SQL_STMT := SQL_STMT||' WHERE B.SPIPROPERTYID IS NULL';
SQL_STMT := SQL_STMT||' AND  B.LOANNUMBER    IS NULL';
SQL_STMT := SQL_STMT||' AND  B.ORDER_NUM     IS NULL';
SQL_STMT := SQL_STMT||' AND  A.CLIENT   = '''||R1.CLIENT||''' ';
SQL_STMT := SQL_STMT||' AND  A.LOANTYPE = '''||R1.LOANTYPE||''' ';
SQL_STMT := SQL_STMT||' AND  A.WORKCODE = '''||R1.WORKCODE||'''  ';

EXECUTE IMMEDIATE SQL_STMT INTO SQLROWS;

IF  ( SQLROWS > 0 ) THEN
            SQL_STMT := ' INSERT INTO SQA_TD_DATA(  DATA_DT,  LOANNUMBER, WORK_CODE, SPIPROPERTYID, ADD_1, ADD_2, CITY, ST, ZIP, CONTRACTOR, CLIENT,     LOAN_TYPE, ORDER_NUM,  ORDER_DT, COMPLETED_DT)';
SQL_STMT := SQL_STMT||' SELECT  SYSDATE,  A.LOANNUMBER,  A.WORKCODE,  A.SPIPROPERTYID, A.ADDRESSLINE1, A.ADDRESSLINE2, A.CITY, A.STATE, A.ZIP, A.CONTRACTORCODE,   A.CLIENT, A.LOANTYPE, A.ORDERNUMBER, A.ORDERDATE,  A.COMPLETEDDATE ';
SQL_STMT := SQL_STMT||' FROM SQA_WORKORDER_MV A';
SQL_STMT := SQL_STMT||' LEFT JOIN ( SELECT  SPIPROPERTYID, LOANNUMBER, ORDER_NUM FROM SQA_TD_DATA) B ON ( A.SPIPROPERTYID = B.SPIPROPERTYID  AND A.LOANNUMBER    = B.LOANNUMBER  AND   A.ORDERNUMBER   =  B.ORDER_NUM )';
SQL_STMT := SQL_STMT||' WHERE B.SPIPROPERTYID IS NULL';
SQL_STMT := SQL_STMT||' AND  B.LOANNUMBER    IS NULL';
SQL_STMT := SQL_STMT||' AND  B.ORDER_NUM     IS NULL';
SQL_STMT := SQL_STMT||' AND  A.CLIENT   = '''||R1.CLIENT||''' ';
SQL_STMT := SQL_STMT||' AND  A.LOANTYPE = '''||R1.LOANTYPE||''' ';
SQL_STMT := SQL_STMT||' AND  A.WORKCODE = '''||R1.WORKCODE||'''  ';
SQL_STMT := SQL_STMT||' AND  ROWNUM <  101  ';

          BEGIN
              EXECUTE IMMEDIATE SQL_STMT;

              SQLROWS  := SQL%ROWCOUNT;

                 COMMIT;

                 EXCEPTION WHEN OTHERS THEN
                 COMMIT;
          END;



END IF;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'PULL_DATA_WO_MV',SYSDATE, SQLROWS, R1.CLIENT ||','|| R1.LOANTYPE||', '||R1.WORKCODE);
    COMMIT;





     END LOOP;

CLOSE C1;

END;



procedure ARCHIVE_SQA_DATA
IS

 A        SQA_DATA_ARCH;

 RCODE    NUMBER;
 SQLROWS  NUMBER;
 MSG      VARCHAR2(1000  BYTE);
 SQL_STMT VARCHAR2(32000 BYTE);
 SEL_STMT VARCHAR2(32000 BYTE);
 DEL_STMT VARCHAR2(32000 BYTE);

 GC       GenRefCursor;

BEGIN
 SQLROWS := 0;
 RCODE   := 0;
 MSG     := 'Starting..';


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'ARCHIVE_SQA_DATA',SYSDATE, RCODE, MSG);
    COMMIT;

SEL_STMT := ' SELECT PID, ROWID FROM SQA_TD_DATA WHERE DATA_DT <  :A ';
DEL_STMT := ' DELETE FROM SQA_TD_DATA WHERE ROWID = :B';

SQL_STMT := 'INSERT INTO SQA_TD_DATA_ARCHIVE (';
SQL_STMT := SQL_STMT||' DATA_DT,SQA_TD_REP,LOANNUMBER,WORK_CODE,SPIPROPERTYID,ADD_1,ADD_2,CITY,ST,ZIP,CONTRACTOR,CLIENT,LOAN_TYPE,ORDER_DT,COMPLETED_DT,ORDER_NUM,VOLT_STICK, ';
SQL_STMT := SQL_STMT||' FRONT_OF_HOUSE,RIGHT_LEFT_SIDE_OF_HOUSE,UP_DOWN_STREET,ADDRESS_PHOTO,LOCKBOX,BACK_OF_PROPERTY,GATE_ALLOWING_ENTRY,BEHIND_BUILDING_GARAGE,SWEEPING,VACUUMING,';
SQL_STMT := SQL_STMT||' MOPPING,WIPING_SURFACES,INSIDE_ALL_TOILETS,INSIDE_OUT_APPLIANCES,SAFETY_HAZARD_AREA,INSIDE_ALL_CLOSETS,ENTIRE_BASEMENT,CIRCUIT_BREAKER,CHECKLIST,AIR_FRESHENERS_DATED,';
SQL_STMT := SQL_STMT||' SHOW_ALL_AIR_FRESHENERS,FOUR_SIDES_OF_HOUSE,BA_FRONT_YARD,BA_BACK_YARD,WEED_WHACKING,EDGED_PAVED_AREAS,FENCE_FOUNDATION_NO_WEEDS,UNDER_PORCH_DECK,SHRUBS_CUT_WHEN_NEEDED,';
SQL_STMT := SQL_STMT||' RULER_PHOT0_TWO_INCHES,DRIVE_WALK_FREE_OF_WEEDS,FLOWER_ROCKSCAPE_FREE_OF_WEEDS,CLIPPINGS_LEAVES_REMOVED,NEED_WORKED,WORKING,COMPLETED,SAVED,PID,COMMENTS,TOP_DOWN_DT,LAST_UPDATE_DT,';
SQL_STMT := SQL_STMT||' NBR_QUESTIONS,NBR_QUESTIONS_YES,REPORT_SEGMENT,FRAUD_INDC,REVIEW_ID,QP_INDC)';
SQL_STMT := SQL_STMT||' SELECT A.DATA_DT,A.SQA_TD_REP,A.LOANNUMBER,A.WORK_CODE,A.SPIPROPERTYID,A.ADD_1,A.ADD_2,A.CITY,A.ST,A.ZIP,A.CONTRACTOR,A.CLIENT,A.LOAN_TYPE,A.ORDER_DT,A.COMPLETED_DT,A.ORDER_NUM,A.VOLT_STICK,';
SQL_STMT := SQL_STMT||'        A.FRONT_OF_HOUSE,A.RIGHT_LEFT_SIDE_OF_HOUSE,A.UP_DOWN_STREET,A.ADDRESS_PHOTO,A.LOCKBOX,A.BACK_OF_PROPERTY,A.GATE_ALLOWING_ENTRY,A.BEHIND_BUILDING_GARAGE,A.SWEEPING,A.VACUUMING,';
SQL_STMT := SQL_STMT||'        A.MOPPING,A.WIPING_SURFACES,A.INSIDE_ALL_TOILETS,A.INSIDE_OUT_APPLIANCES,A.SAFETY_HAZARD_AREA,A.INSIDE_ALL_CLOSETS,A.ENTIRE_BASEMENT,A.CIRCUIT_BREAKER,A.CHECKLIST,a.AIR_FRESHENERS_DATED,';
SQL_STMT := SQL_STMT||'        A.SHOW_ALL_AIR_FRESHENERS,A.FOUR_SIDES_OF_HOUSE,A.BA_FRONT_YARD,A.BA_BACK_YARD,A.WEED_WHACKING,A.EDGED_PAVED_AREAS,A.FENCE_FOUNDATION_NO_WEEDS,A.UNDER_PORCH_DECK,A.SHRUBS_CUT_WHEN_NEEDED,';
SQL_STMT := SQL_STMT||'        A.RULER_PHOT0_TWO_INCHES,A.DRIVE_WALK_FREE_OF_WEEDS,A.FLOWER_ROCKSCAPE_FREE_OF_WEEDS,A.CLIPPINGS_LEAVES_REMOVED,A.NEED_WORKED,A.WORKING,A.COMPLETED,A.SAVED,A.PID,A.COMMENTS,A.TOP_DOWN_DT,A.LAST_UPDATE_DT,';
SQL_STMT := SQL_STMT||'        A.NBR_QUESTIONS,A.NBR_QUESTIONS_YES,A.REPORT_SEGMENT,A.FRAUD_INDC,A.REVIEW_ID,A.QP_INDC ';
SQL_STMT := SQL_STMT||'        FROM SQA_TD_DATA A ';
SQL_STMT := SQL_STMT||'LEFT JOIN ( SELECT PID FROM SQA_TD_DATA_ARCHIVE ) B ON ( B.PID = A.PID) ';
SQL_STMT := SQL_STMT||' WHERE A.PID = :A ';
SQL_STMT := SQL_STMT||'  AND  B.PID IS NULL';


OPEN GC FOR SEL_STMT USING (SYSDATE - 90);

LOOP
    FETCH GC BULK COLLECT INTO A.PID, A.ROWIDS LIMIT 10000;
    EXIT WHEN A.PID.COUNT = 0;
    SQLROWS := SQLROWS + A.PID.COUNT;
    FOR K IN 1..A.PID.COUNT LOOP

         EXECUTE IMMEDIATE SQL_STMT USING A.PID(K);

         EXECUTE IMMEDIATE DEL_STMT USING A.ROWIDS(K);

    END LOOP;

END LOOP;

COMMIT;

 MSG     := 'Complete..';

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'ARCHIVE_SQA_DATA',SYSDATE, SQLROWS, MSG);
    COMMIT;



exception
     when others then
     MSG := SQLERRM;
     RCODE := SQLCODE;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'ARCHIVE_SQA_DATA',SYSDATE, RCODE, MSG);
    COMMIT;


END;

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

/****************************************************************
         MAX STANDING
         FIND THE BOTTOM OF THE LADDER
 ***************************************************************/
FUNCTION max_standing (P_STANDING NUMBER) RETURN number
is
   PRAGMA AUTONOMOUS_TRANSACTION;
   return_value number;
begin
RETURN_VALUE := 0;

select max(standing)
into  return_value
from  SQA_VENDOR_LIST;

   RETURN_VALUE := RETURN_VALUE + P_STANDING;

RETURN RETURN_VALUE;

end;

/**************************************************
   GIVE THE VENDOR CREDIT FOR YES / N/A
 **************************************************/

PROCEDURE CALC_SCORE (P_PID NUMBER)
IS
CURSOR C2 (PPID NUMBER)
IS
SELECT  REVIEW_ID, CLIENT, LOAN_TYPE,  WORK_CODE
FROM SQA_TD_DATA
WHERE PID = PPID;
R2 C2%ROWTYPE;

CURSOR C1 (reviewid NUMBER)
IS
SELECT CONTRACTOR, REPORT_SEGMENT, CLIENT, LOAN_TYPE, WORK_CODE, NBR_QUESTIONS, REVIEW_ID,  VOLT_STICK, FRONT_OF_HOUSE, RIGHT_LEFT_SIDE_OF_HOUSE, UP_DOWN_STREET, ADDRESS_PHOTO, LOCKBOX, BACK_OF_PROPERTY, GATE_ALLOWING_ENTRY,
       BEHIND_BUILDING_GARAGE, SWEEPING, VACUUMING, MOPPING, WIPING_SURFACES, INSIDE_ALL_TOILETS, INSIDE_OUT_APPLIANCES, SAFETY_HAZARD_AREA,
       INSIDE_ALL_CLOSETS, ENTIRE_BASEMENT, CIRCUIT_BREAKER, CHECKLIST, AIR_FRESHENERS_DATED, SHOW_ALL_AIR_FRESHENERS, FOUR_SIDES_OF_HOUSE,
       BA_FRONT_YARD, BA_BACK_YARD, WEED_WHACKING, EDGED_PAVED_AREAS, FENCE_FOUNDATION_NO_WEEDS, UNDER_PORCH_DECK, SHRUBS_CUT_WHEN_NEEDED,
       RULER_PHOT0_TWO_INCHES, DRIVE_WALK_FREE_OF_WEEDS, FLOWER_ROCKSCAPE_FREE_OF_WEEDS, CLIPPINGS_LEAVES_REMOVED, PID
FROM SQA_TD_DATA
WHERE REVIEW_ID = reviewid;
R1 C1%ROWTYPE;

REVIEW_SIZE      NUMBER;
P_CLIENTCODE     VARCHAR2(100 BYTE);
P_LOANTYPE       VARCHAR2(100 BYTE);
P_WORKCODE       VARCHAR2(100 BYTE);
BOTTOM_OF_LIST   NUMBER;
FOLLOWUP_DAYS    NUMBER;
WHATS_LEFT       NUMBER;
P_REVIEW_ID      NUMBER;
RUNNING_SCORE    NUMBER;
PAGE_NO          NUMBER;
P_working_cnt    number;
P_POINTS_CNT     NUMBER;
P_POSSIBLE_PTS   NUMBER;
P_REVIEW_SCORE   NUMBER(9);
P_VENDOR_ID      NUMBER;
USER_ID          INTEGER;
RCODE            NUMBER;
MSG              VARCHAR2(300 BYTE);
P_FOLLOW_UP      VARCHAR2(100 BYTE);
P_FOLLOW_UP_SAT  VARCHAR2(100 BYTE);
P_FOLLOW_UP_CAT  VARCHAR2(100 BYTE);
P_FOLLOW_UP_RES  VARCHAR2(100 BYTE);
SEL_STMT         VARCHAR2(32000 BYTE);
GC               GenRefCursor;
BAD_DATA         EXCEPTION;


/**********************************************
     NEED PAGE NO IN ORDER TO FIGURE WHICH
     QUESTIONS WERE ANSWERED
 *********************************************/
FUNCTION PAGENO ( P_CLIENT VARCHAR2, P_LOAN_TYPE VARCHAR2, P_WORK_CODE VARCHAR2) RETURN NUMBER
IS
RETURN_VALUE NUMBER;
SQL_STMT     VARCHAR2(32000);

BEGIN

      RETURN_VALUE := 0;


      SQL_STMT := CASE WHEN P_CLIENT NOT IN ('FNMA') AND P_WORK_CODE LIKE 'GC%' AND P_LOAN_TYPE NOT IN ('REO') THEN 'SELECT PAGE_NBR FROM SQA_TD_BRANCH_PAGES WHERE CLIENT IS NULL AND LOAN_TYPE IS NULL AND WORK_CODE = ''GC'''
                       WHEN P_CLIENT NOT IN ('FNMA') AND P_WORK_CODE LIKE 'GC%' AND P_LOAN_TYPE IN ('REO') THEN 'SELECT PAGE_NBR FROM SQA_TD_BRANCH_PAGES WHERE CLIENT IS NULL AND LOAN_TYPE = ''REO'' AND WORK_CODE = ''GC'''
                       WHEN P_CLIENT IN ('FNMA') AND P_WORK_CODE LIKE 'GC%' AND P_LOAN_TYPE IN ('REO') THEN 'SELECT PAGE_NBR FROM SQA_TD_BRANCH_PAGES WHERE CLIENT = ''FNMA'' AND LOAN_TYPE = ''REO'' AND WORK_CODE = ''GC'''
                       WHEN P_CLIENT NOT IN ('FNMA') AND P_WORK_CODE = 'RFRSH2' AND P_LOAN_TYPE IN ('REO') THEN 'SELECT PAGE_NBR FROM SQA_TD_BRANCH_PAGES WHERE CLIENT IS NULL AND LOAN_TYPE  IN (''REO'') AND WORK_CODE = ''RFRSH2'''
                       WHEN P_CLIENT IN ('FNMA') AND P_WORK_CODE = 'RFRSH2'  AND P_LOAN_TYPE IN ('REO') THEN 'SELECT PAGE_NBR FROM SQA_TD_BRANCH_PAGES WHERE CLIENT = ''FNMA'' AND LOAN_TYPE = ''REO'' AND WORK_CODE = ''RFRSH2'''
                       WHEN P_CLIENT NOT IN ('FNMA') AND P_WORK_CODE = 'RFRSH2' AND P_LOAN_TYPE NOT IN ('REO') THEN 'SELECT 0 AS PAGE_NBR FROM DUAL'
                  ELSE 'SELECT-NO-STATEMENT'

                  END;

      IF ( SQL_STMT NOT IN ( 'SELECT-NO-STATEMENT') ) THEN

          EXECUTE IMMEDIATE SQL_STMT INTO RETURN_VALUE;
      END IF;

      RETURN RETURN_VALUE;


END;

FUNCTION GET_COUNT ( P_COLUMN  VARCHAR2, P_REVIEW_ID NUMBER ) RETURN NUMBER
IS
  COUNT_YES  NUMBER;
  SQL_STMT   VARCHAR2(32000 BYTE);

BEGIN

    SQL_STMT := ' SELECT NVL(SUM (P_COLUMN),0) FROM ( SELECT CASE WHEN '||P_COLUMN||' IN  (''Yes'',''N/A'') THEN 1 ELSE 0 END AS P_COLUMN FROM SQA_TD_DATA WHERE REVIEW_ID = '||P_REVIEW_ID||') ';
    EXECUTE IMMEDIATE SQL_STMT INTO COUNT_YES;
    RETURN COUNT_YES;


END;


/******************************/


/*  THE FUN BEGINS HERE */

BEGIN

/**************************************************
 are we on the last one?
***************************************************/
REVIEW_SIZE       := 0;
WHATS_LEFT        := 1;
P_FOLLOW_UP       := 'UNKNOWN';
P_FOLLOW_UP_SAT   := 'UNKNOWN';
P_FOLLOW_UP_CAT   := 'UNKNOWN';
P_FOLLOW_UP_RES   := 'UNKNOWN';
FOLLOWUP_DAYS := 0;
USER_ID       := 0;


SELECT MAX(STANDING)
INTO BOTTOM_OF_LIST
FROM SQA_VENDOR_LIST;

BOTTOM_OF_LIST := BOTTOM_OF_LIST + 1;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'CALC_SCORE',SYSDATE, P_PID, 'P_PID');
         COMMIT;


OPEN C2(P_PID);
    FETCH C2 INTO R2;
    P_REVIEW_ID      := R2.REVIEW_ID;
    P_CLIENTCODE     := R2.CLIENT;
    P_LOANTYPE       := R2.LOAN_TYPE;
    P_WORKCODE       := R2.WORK_CODE;
CLOSE C2;




          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'CALC_SCORE',SYSDATE, P_REVIEW_ID, 'P_REVIEW_ID');
         COMMIT;



    SELECT POINTS_RECEIVED, POSSIBLE_PTS, VENDOR_ID
    INTO   P_POINTS_CNT, P_POSSIBLE_PTS, P_VENDOR_ID
    FROM SQA_VENDOR_HISTORY
    WHERE history_id = P_REVIEW_ID;


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'CALC_SCORE',SYSDATE, P_VENDOR_ID, 'P_VENDOR_ID');
         COMMIT;

    SELECT  A.FOLLOW_UP, A.FOLLOW_UP_SAT,A.FOLLOW_UP_CAT,A.FOLLOW_UP_RES, A.ASSIGNED_TO
    INTO    P_FOLLOW_UP, P_FOLLOW_UP_SAT, P_FOLLOW_UP_CAT,P_FOLLOW_UP_RES, USER_ID
    FROM SQA_VENDOR_LIST A
    WHERE A.VENDOR_ID = P_VENDOR_ID;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'CALC_SCORE',SYSDATE, USER_ID, 'USER_ID');
         COMMIT;


    PAGE_NO := PAGENO( P_CLIENTCODE, P_LOANTYPE, P_WORKCODE);

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'CALC_SCORE',SYSDATE, PAGE_NO, 'PAGE_NO');
         COMMIT;



OPEN C1(P_REVIEW_ID);

  LOOP
  FETCH C1 INTO R1;
    EXIT WHEN C1%NOTFOUND;


    RUNNING_SCORE := ( CASE WHEN PAGE_NO IN (341) THEN
                                                      (CASE WHEN R1.SWEEPING IN ('Yes','N/A') THEN 1 ELSE 0 END)  +
                                                      (CASE WHEN R1.VACUUMING IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.MOPPING IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.WIPING_SURFACES IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.INSIDE_ALL_TOILETS IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.INSIDE_ALL_CLOSETS IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.ENTIRE_BASEMENT IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.SAFETY_HAZARD_AREA IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.CIRCUIT_BREAKER IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.AIR_FRESHENERS_DATED IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.SHOW_ALL_AIR_FRESHENERS IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.CHECKLIST IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.VOLT_STICK IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.LOCKBOX IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.FRONT_OF_HOUSE IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.ADDRESS_PHOTO IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.RIGHT_LEFT_SIDE_OF_HOUSE IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.BACK_OF_PROPERTY IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.GATE_ALLOWING_ENTRY IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.UP_DOWN_STREET IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.BEHIND_BUILDING_GARAGE IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.INSIDE_OUT_APPLIANCES    IN ('Yes','N/A') THEN 1 ELSE 0 END)

                         WHEN PAGE_NO IN (342) THEN
                                                      (CASE WHEN R1.SWEEPING IN ('Yes','N/A') THEN 1 ELSE 0 END)  +
                                                      (CASE WHEN R1.MOPPING IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.WIPING_SURFACES IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.VACUUMING IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.INSIDE_ALL_TOILETS IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.INSIDE_OUT_APPLIANCES    IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.SAFETY_HAZARD_AREA IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.AIR_FRESHENERS_DATED IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.CHECKLIST IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.VOLT_STICK IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.FRONT_OF_HOUSE IN ('Yes','N/A') THEN 1 ELSE 0 END)
                         WHEN PAGE_NO IN (343) THEN
                                                      (CASE WHEN R1.FRONT_OF_HOUSE IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.FOUR_SIDES_OF_HOUSE IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.BACK_OF_PROPERTY IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.GATE_ALLOWING_ENTRY IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.BA_FRONT_YARD IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.BA_BACK_YARD IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.WEED_WHACKING IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.EDGED_PAVED_AREAS IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.FENCE_FOUNDATION_NO_WEEDS IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.FLOWER_ROCKSCAPE_FREE_OF_WEEDS  IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.BEHIND_BUILDING_GARAGE IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.UNDER_PORCH_DECK IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.SHRUBS_CUT_WHEN_NEEDED IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.RULER_PHOT0_TWO_INCHES IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.LOCKBOX IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.ADDRESS_PHOTO IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.UP_DOWN_STREET IN ('Yes','N/A') THEN 1 ELSE 0 END)

                         WHEN PAGE_NO IN (344) THEN
                                                      (CASE WHEN R1.FRONT_OF_HOUSE IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.FOUR_SIDES_OF_HOUSE IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.BA_FRONT_YARD IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.BA_BACK_YARD IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.WEED_WHACKING IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.EDGED_PAVED_AREAS IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.FENCE_FOUNDATION_NO_WEEDS IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.FLOWER_ROCKSCAPE_FREE_OF_WEEDS  IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.BEHIND_BUILDING_GARAGE IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.UNDER_PORCH_DECK IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.SHRUBS_CUT_WHEN_NEEDED IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.RULER_PHOT0_TWO_INCHES IN ('Yes','N/A') THEN 1 ELSE 0 END)

                         WHEN PAGE_NO IN (345) THEN
                                                      (CASE WHEN R1.BA_FRONT_YARD IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.BA_BACK_YARD IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.FOUR_SIDES_OF_HOUSE IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.FENCE_FOUNDATION_NO_WEEDS IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.DRIVE_WALK_FREE_OF_WEEDS IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.FLOWER_ROCKSCAPE_FREE_OF_WEEDS  IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.EDGED_PAVED_AREAS IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.CLIPPINGS_LEAVES_REMOVED IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.SHRUBS_CUT_WHEN_NEEDED IN ('Yes','N/A') THEN 1 ELSE 0 END) +
                                                      (CASE WHEN R1.RULER_PHOT0_TWO_INCHES IN ('Yes','N/A') THEN 1 ELSE 0 END)

                          ELSE 0 END);

        P_POINTS_CNT   :=  P_POINTS_CNT + RUNNING_SCORE;
        P_POSSIBLE_PTS :=  P_POSSIBLE_PTS + R1.NBR_QUESTIONS;
        P_REVIEW_SCORE :=  ROUND(((P_POINTS_CNT / P_POSSIBLE_PTS) * 100),0);

        UPDATE SQA_TD_DATA SET
        NBR_QUESTIONS_YES = RUNNING_SCORE,
        SAVED       = 'Y',
        TOP_DOWN_DT =  SYSDATE
        WHERE PID   = R1.PID;

        COMMIT;

   END LOOP;

CLOSE C1;

        UPDATE SQA_VENDOR_HISTORY  SET  POINTS_RECEIVED = P_POINTS_CNT ,  POSSIBLE_PTS  = P_POSSIBLE_PTS,   REVIEW_SCORE = P_REVIEW_SCORE
        WHERE      HISTORY_ID = P_REVIEW_ID;
        COMMIT;




select count(*)
INTO WHATS_LEFT
from SQA_TD_DATA
WHERE REVIEW_ID = P_REVIEW_ID
AND   NVL(SAVED,'N') = 'N';


IF (WHATS_LEFT > 0 )  THEN

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'CALC_SCORE',SYSDATE, WHATS_LEFT, 'WHATS LEFT IS NOT ZERO');
         COMMIT;
      RAISE BAD_DATA;
END IF;

----------------------------------------------
--   Grade the contractor
----------------------------------------------
IF (WHATS_LEFT = 0 )  THEN

        UPDATE  SQA_VENDOR_HISTORY
           SET  CALC_CMPT = 1,REVIEW_DTE = GV_CURRENT_DATE
        WHERE   HISTORY_ID = P_REVIEW_ID;


        select count(*)
        INTO REVIEW_SIZE
        from SQA_TD_DATA
        WHERE REVIEW_ID = P_REVIEW_ID;


/*
TYPE SUMMARYS IS RECORD
(
  PREVIEW_ID     DBMS_SQL.NUMBER_TABLE,
  PCOLUMN_NAME   DBMS_SQL.VARCHAR2_TABLE,
  PHEADING       DBMS_SQL.VARCHAR2_TABLE,
  PYES           DBMS_SQL.NUMBER_TABLE,
  PGRADE         DBMS_SQL.VARCHAR2_TABLE,
  PCOLUMN_NBR    DBMS_SQL.VARCHAR2_TABLE
);
SUMS     SUMMARYS;
*/



    SEL_STMT := 'SELECT '||P_REVIEW_ID||' ,COLUMN_NAME, HEADING, 0,0, COLUMN_NBR  FROM SQA_TD_QUESTION_HEADINGS WHERE PAGE_NO = :A  and column_name not in (''DATA_DT'',''ST'',''CONTRACTOR'',''CLIENT'',''LOAN_TYPE'',''ORDER_DT'',''COMPLETED_DT'',''ORDER_NUM'',''COMMENTS'') order BY COLUMN_NBR';

    OPEN GC FOR SEL_STMT USING PAGE_NO;

         FETCH GC BULK COLLECT INTO SUMS.PREVIEW_ID,
                                    SUMS.PCOLUMN_NAME,
                                    SUMS.PHEADING,
                                    SUMS.PYES,
                                    SUMS.PGRADE,
                                   SUMS.PCOLUMN_NBR;

           RCODE :=  SUMS.PREVIEW_ID.COUNT;
   CLOSE GC;



          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'CALC_SCORE',SYSDATE, RCODE, 'NBR QUESTIONS');
         COMMIT;



      FOR I IN 1..RCODE LOOP

          SUMS.PYES(I) := GET_COUNT ( SUMS.PCOLUMN_NAME(I), P_REVIEW_ID );

          BEGIN
              SUMS.PGRADE(I) := ROUND(((SUMS.PYES(I) / REVIEW_SIZE) * 100),0);
          EXCEPTION
                  WHEN OTHERS THEN
                   SUMS.PGRADE(I) := 0;
          END;
      END LOOP;


    DELETE FROM SQA_TD_REPORT_SUMMARY WHERE BATCH_NO = P_REVIEW_ID;

    COMMIT;


     FOR L IN 1..RCODE LOOP

          INSERT INTO SQA_TD_REPORT_SUMMARY ( BATCH_NO, COLUMN_NAME, QUESTION,TOTAL_PER_TASK,TASK_COMPLIENT,REPORT_ORDER)
          VALUES (SUMS.PREVIEW_ID(L),SUMS.PCOLUMN_NAME(L),SUMS.PHEADING(L),SUMS.PYES(L),SUMS.PGRADE(L),SUMS.PCOLUMN_NBR(L));

          EXECUTE IMMEDIATE ' UPDATE SQA_VENDOR_HISTORY SET '||SUMS.PCOLUMN_NAME(L)||' = '||SUMS.PYES(L)||'  WHERE HISTORY_ID = :A' USING SUMS.PREVIEW_ID(L);
     END LOOP;

     COMMIT;



/*
   ALL Initial Orders
  89.9% and below requires a conference call

   ALL Follow Up orders
  94.9% and below require a chargeback
   INITIAL-NEW-TDA-VENDOR
   INITIAL-TDA-NOT-NEW-VENDOR
   FOLLOW-UP-VENDOR-FAILED-INITIAL
   CALL-INITIAL-NEW-TDA-VENDOR
   CHARGEBACK-FOLLOW-UP-VENDOR-FAILED

 */


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'CALC_SCORE',SYSDATE, 0, 'Before__.'||P_FOLLOW_UP_CAT);
         COMMIT;


      P_FOLLOW_UP_RES   := CASE WHEN  P_REVIEW_SCORE >  94  THEN 'PASS'
                                WHEN  P_REVIEW_SCORE <  89  THEN 'CALL'
                                WHEN  P_REVIEW_SCORE <  95  THEN 'FAIL'
                           else  'UNKNOWN'
                           end;


      P_FOLLOW_UP_CAT   := CASE WHEN  P_FOLLOW_UP_RES IN ('PASS') AND  P_FOLLOW_UP_CAT IN ('INITIAL-NEW-TDA-VENDOR',
                                                                                           'INITIAL-TDA-NOT-NEW-VENDOR',
                                                                                           'FOLLOW-UP-VENDOR-FAILED-INITIAL',
                                                                                           'CHARGEBACK-FOLLOW-UP-VENDOR-FAILED',
                                                                                           'CALL-INITIAL-NEW-TDA-VENDOR',
                                                                                           '2ND-ROUND-INITIAL-AUDIT-FAILED')   THEN  'INITIAL-TDA-NOT-NEW-VENDOR'
                                WHEN  P_FOLLOW_UP_RES IN ('FAIL') AND  P_FOLLOW_UP_CAT IN ('INITIAL-NEW-TDA-VENDOR','INITIAL-TDA-NOT-NEW-VENDOR') THEN 'FOLLOW-UP-VENDOR-FAILED-INITIAL'
                                WHEN  P_FOLLOW_UP_RES IN ('CALL') AND  P_FOLLOW_UP_CAT IN ('INITIAL-NEW-TDA-VENDOR')                    THEN  'CALL-INITIAL-NEW-TDA-VENDOR'
                                WHEN  P_FOLLOW_UP_RES IN ('CALL','FAIL') AND  P_FOLLOW_UP_CAT IN ('INITIAL-TDA-NOT-NEW-VENDOR')         THEN  'FOLLOW-UP-VENDOR-FAILED-INITIAL'
                                WHEN  P_FOLLOW_UP_RES IN ('CALL','FAIL') AND  P_FOLLOW_UP_CAT IN ('FOLLOW-UP-VENDOR-FAILED-INITIAL','CALL-INITIAL-NEW-TDA-VENDOR')    THEN  'CHARGEBACK-FOLLOW-UP-VENDOR-FAILED'
                                WHEN  P_FOLLOW_UP_RES IN ('CALL','FAIL') AND  P_FOLLOW_UP_CAT IN ('CHARGEBACK-FOLLOW-UP-VENDOR-FAILED') THEN  '2ND-ROUND-INITIAL-AUDIT-FAILED'
                                WHEN  P_FOLLOW_UP_RES IN ('CALL','FAIL') AND  P_FOLLOW_UP_CAT IN ('2ND-ROUND-INITIAL-AUDIT-FAILED')     THEN  '2ND-ROUND-FOLLOW-UP-AUDIT-FAILED'

                           else  'UNKNOWN-CAT'
                           end;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'CALC_SCORE',SYSDATE, 0, 'After__.'||P_FOLLOW_UP_CAT);
         COMMIT;


      P_FOLLOW_UP_SAT   := CASE WHEN  P_FOLLOW_UP_CAT IN ('INITIAL-TDA-NOT-NEW-VENDOR') THEN 'Pass'
                                WHEN  P_FOLLOW_UP_CAT IN ('FOLLOW-UP-VENDOR-FAILED-INITIAL') THEN 'Fail'
                                WHEN  P_FOLLOW_UP_CAT IN ('CALL-INITIAL-NEW-TDA-VENDOR') THEN 'Fail/Confrennce call'
                                WHEN  P_FOLLOW_UP_CAT IN ('CHARGEBACK-FOLLOW-UP-VENDOR-FAILED') THEN 'Fail/Chargeback'
                                WHEN  P_FOLLOW_UP_CAT IN ('2ND-ROUND-INITIAL-AUDIT-FAILED')     THEN 'Fail'
                                WHEN  P_FOLLOW_UP_CAT IN ('2ND-ROUND-FOLLOW-UP-AUDIT-FAILED') THEN 'Mgmt/VAM'
                           else  'UNKNOWN-SAT'
                           end;




/*
        UPDATE SQA_VENDOR_HISTORY  SET  REVIEW_DTE =
        WHERE      HISTORY_ID = P_REVIEW_ID;

        VENDOR_ID,
        VENDOR_CODE,
        FOLLOW_UP,
        FOLLOW_UP_SAT,
        FOLLOW_UP_DTE,
        STANDING,
        NBR_WORKORDERS,
        ACTIVE,
        LAST_REVIEW,
        REVIEWED_BY,
        SEGMENTS,
        CAP_HOLD,
        BATCH_NO,
        WORKCODE,
        ASSIGNED_TO,
        COMPLETED_BY,
        START_COUNTER_DATE,
        FOLLOW_UP_CAT, THIRTY_FIFTY_DAY_RULE, ASSIGN_IT, FOLLOW_UP_RES
*/



    if ( P_FOLLOW_UP_CAT IN ('FOLLOW-UP-VENDOR-FAILED-INITIAL','2ND-ROUND-INITIAL-AUDIT-FAILED')) THEN

      UPDATE
       SQA_VENDOR_LIST
       SET FOLLOW_UP_SAT         = P_FOLLOW_UP_SAT,
           FOLLOW_UP_CAT         = P_FOLLOW_UP_CAT,
           FOLLOW_UP_RES         = P_FOLLOW_UP_RES,
           FOLLOW_UP             = 'Follow-up',
           STANDING              = BOTTOM_OF_LIST,
           FOLLOW_UP_DTE         = GV_CURRENT_DATE + 30,
--TESTING  FOLLOW_UP_DTE         = TRUNC(SYSDATE) + 30,
           NBR_WORKORDERS        =  0,
           NBR_COMPLETED         =  0,
           THIRTY_FIFTY_DAY_RULE =  0,
           NEXT_REVIEW           = NULL,
           LAST_REVIEW           = GV_CURRENT_DATE,
           START_COUNTER_DATE    = GV_CURRENT_DATE,
--TESTING  LAST_REVIEW           = TRUNC(SYSDATE),
--TESTING  START_COUNTER_DATE    = TRUNC(SYSDATE),
           ASSIGN_IT             = 0,
           COMPLETED_BY          = 0,
           ASSIGNED_TO           = 0,
           BATCH_NO              = 0
          WHERE VENDOR_ID = P_VENDOR_ID;

          COMMIT;
    END IF;

    if ( P_FOLLOW_UP_CAT IN ('CHARGEBACK-FOLLOW-UP-VENDOR-FAILED')) THEN

      UPDATE
       SQA_VENDOR_LIST
       SET FOLLOW_UP_SAT         = P_FOLLOW_UP_SAT,
           FOLLOW_UP_CAT         = P_FOLLOW_UP_CAT,
           FOLLOW_UP_RES         = P_FOLLOW_UP_RES,
           FOLLOW_UP             = 'Initial',
           STANDING              = BOTTOM_OF_LIST,
           FOLLOW_UP_DTE         = null,
--TESTING  NEXT_REVIEW           = TRUNC(SYSDATE) + 30,
           NEXT_REVIEW           = GV_CURRENT_DATE + 30,
           NBR_WORKORDERS        =  0,
           NBR_COMPLETED         =  0,
           THIRTY_FIFTY_DAY_RULE =  0,
           LAST_REVIEW           = GV_CURRENT_DATE,
           START_COUNTER_DATE    = GV_CURRENT_DATE,
--TESTING  LAST_REVIEW           = TRUNC(SYSDATE),
--TESTING  START_COUNTER_DATE    = TRUNC(SYSDATE),
           ASSIGN_IT             =  0,
           COMPLETED_BY          =  0,
           ASSIGNED_TO           =  0,
           BATCH_NO              =  0
          WHERE VENDOR_ID  = P_VENDOR_ID;

          COMMIT;
    END IF;



    if ( P_FOLLOW_UP_CAT IN ('CALL-INITIAL-NEW-TDA-VENDOR')) THEN

      UPDATE
       SQA_VENDOR_LIST
       SET FOLLOW_UP_SAT         = P_FOLLOW_UP_SAT,
           FOLLOW_UP_CAT         = P_FOLLOW_UP_CAT,
           FOLLOW_UP_RES         = P_FOLLOW_UP_RES,
           FOLLOW_UP             = 'Follow-up',
           STANDING              = BOTTOM_OF_LIST,
--TESTING  FOLLOW_UP_DTE         = TRUNC(SYSDATE) + 30,
           FOLLOW_UP_DTE         = GV_CURRENT_DATE + 30,
           NBR_WORKORDERS        =  0,
           NBR_COMPLETED         =  0,
           THIRTY_FIFTY_DAY_RULE =  0,
           LAST_REVIEW           = GV_CURRENT_DATE,
           NEXT_REVIEW           = NULL,
           START_COUNTER_DATE    = GV_CURRENT_DATE,
--TESTING  LAST_REVIEW           = TRUNC(SYSDATE),
--TESTING  START_COUNTER_DATE    = TRUNC(SYSDATE),
           ASSIGN_IT             =  0,
           COMPLETED_BY          =  0,
           ASSIGNED_TO           =  0,
           BATCH_NO              =  0
          WHERE VENDOR_ID  = P_VENDOR_ID;

          COMMIT;
    END IF;


--INITIAL-TDA-NOT-NEW-VENDOR

    if ( P_FOLLOW_UP_CAT IN ('INITIAL-TDA-NOT-NEW-VENDOR')) THEN

      UPDATE
       SQA_VENDOR_LIST
       SET FOLLOW_UP_SAT         = P_FOLLOW_UP_SAT,
           FOLLOW_UP_CAT         = P_FOLLOW_UP_CAT,
           FOLLOW_UP_RES         = P_FOLLOW_UP_RES,
           FOLLOW_UP_DTE         = NULL,
           NEXT_REVIEW           = NULL,
           FOLLOW_UP             = 'Initial',
           STANDING              = BOTTOM_OF_LIST,
           NBR_WORKORDERS        =  0,
           NBR_COMPLETED         =  0,
           THIRTY_FIFTY_DAY_RULE =  0,
           START_COUNTER_DATE    =  (GV_CURRENT_DATE + 1),
           ASSIGN_IT             =  0,
           COMPLETED_BY          =  0,
           ASSIGNED_TO           =  0,
           BATCH_NO              =  0,
           LAST_REVIEW           = GV_CURRENT_DATE
          WHERE VENDOR_ID  = P_VENDOR_ID;

          COMMIT;
    END IF;


    if ( P_FOLLOW_UP_CAT IN ('2ND-ROUND-FOLLOW-UP-AUDIT-FAILED')) THEN

      UPDATE
       SQA_VENDOR_LIST
       SET FOLLOW_UP_SAT         = P_FOLLOW_UP_SAT,
           FOLLOW_UP_CAT         = P_FOLLOW_UP_CAT,
           FOLLOW_UP_RES         = P_FOLLOW_UP_RES,
           FOLLOW_UP             = NULL,
           STANDING              = BOTTOM_OF_LIST,
--TESTING  FOLLOW_UP_DTE         = TRUNC(SYSDATE) + 30,
           FOLLOW_UP_DTE         = NULL,
           NBR_WORKORDERS        =  0,
           NBR_COMPLETED         =  0,
           THIRTY_FIFTY_DAY_RULE =  0,
           LAST_REVIEW           = GV_CURRENT_DATE,
           NEXT_REVIEW           = NULL,
           START_COUNTER_DATE    = NULL,
--TESTING  LAST_REVIEW           = TRUNC(SYSDATE),
--TESTING  START_COUNTER_DATE    = TRUNC(SYSDATE),
           ASSIGN_IT             =  -1,
           COMPLETED_BY          =  0,
           ASSIGNED_TO           =  0,
           BATCH_NO              =  0
          WHERE VENDOR_ID  = P_VENDOR_ID;

          COMMIT;
    END IF;



          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'CALC_SCORE',SYSDATE, 0, 'Complete');
         COMMIT;

   if ( P_FOLLOW_UP_CAT NOT IN ('CHARGEBACK-FOLLOW-UP-VENDOR-FAILED','2ND-ROUND-FOLLOW-UP-AUDIT-FAILED')) THEN
       SQA_LOVS.GEN_EMAILS ( P_PAGE_NO=> PAGE_NO, P_REVIEWID => P_REVIEW_ID, P_CLIENT =>P_CLIENTCODE, P_LOAN_TYPE=>P_LOANTYPE, P_WORK_CODE=>P_WORKCODE, P_VENDORID=>P_VENDOR_ID);
   END IF;

--- ASSIGN_REVIEWS ( P_USER_ID=> USER_ID);



END IF;


exception
     WHEN BAD_DATA THEN

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'CALC_SCORE',SYSDATE, -600, 'Houston we have an issue');
    COMMIT;

     when others then
     MSG := SQLERRM;
     RCODE := SQLCODE;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'CALC_SCORE',SYSDATE, RCODE, MSG);
    COMMIT;

END;



procedure SET_NBR_VENDOR_WO
IS

VL VENDORCODE_LIST;
VW VENDORCODE_WRK;

GC GenRefCursor;



SQL_STMT     VARCHAR2(32000);
SEL_STMT     VARCHAR2(32000);
UPD_STMT     VARCHAR2(32000);
SEL_INITIAL  VARCHAR2(32000);
MSG          VARCHAR2(1000);

RCODE                 NUMBER;
CNT                   NUMBER;
NBR_TO_REVIEW         NUMBER;
COMPLETED             NUMBER;
THIRTY_FIFTY_DAY_RULE NUMBER;
DAYS_FROM_START       NUMBER;
DAY_31                DATE;
DAY_50                DATE;

BEGIN


----------------------------------------------- knock out the non active

UPD_STMT := 'UPDATE SQA_VENDOR_LIST SET FOLLOW_UP_SAT = ''Fail/QP'' , ACTIVE = 0, ASSIGN_IT = 0, BATCH_NO = 0  WHERE ROWID = :B ';


SQL_STMT := 'SELECT a.VENDOR_CODE, A.LAST_REVIEW, A.FOLLOW_UP_DTE, A.NBR_WORKORDERS, a.ROWID FROM SQA_VENDOR_LIST a  ';
SQL_STMT := SQL_STMT||' LEFT JOIN ( SELECT VENDORCODE,  NAME ';
SQL_STMT := SQL_STMT||'             FROM ALL_ACTIVE_VENDORS_MV';
SQL_STMT := SQL_STMT||'             WHERE TERMINATIONDATE IS NOT NULL ) B ON ( A.VENDOR_CODE = B.VENDORCODE) ';
SQL_STMT := SQL_STMT||' WHERE  A.VENDOR_CODE = B.VENDORCODE ';


OPEN GC FOR SQL_STMT;
       FETCH GC BULK COLLECT INTO  VL.VENDOR_CODE,  VL.LAST_REVIEW, VL.FOLLOW_UP_DTE, VL.NBR_WORKORDERS, VL.ROWIDS;


FORALL Y IN 1..VL.VENDOR_CODE.COUNT
    EXECUTE IMMEDIATE UPD_STMT USING VL.ROWIDS(y);

    COMMIT;

CLOSE GC;

--------------------------------------------------------------------------------------------------------------------------------------------------
------ MOVE COMPLETED AND FIRST TIMERS INTO THE QUEUE FOR ASSIGNMENT
--------------------------------------------------------------------------------------------------------------------------------------------------
SQL_STMT := 'UPDATE SQA_VENDOR_LIST SET ASSIGNED_TO = 0, COMPLETED_BY = 0, ASSIGN_IT = 0, BATCH_NO = 0 WHERE NVL(ASSIGNED_TO,1) > 0 AND NVL(COMPLETED_BY,1) > 0 AND ACTIVE = 1 AND CAP_HOLD = 0';
EXECUTE IMMEDIATE SQL_STMT;

--VL.NBR_WORKORDERS(y),VL.ASSIGN_IT(y),VL.THIRTY_FIFTY_DAY_RULE(y),
UPD_STMT := 'UPDATE SQA_VENDOR_LIST  SET NBR_WORKORDERS = :A,   ASSIGN_IT = :B,  THIRTY_FIFTY_DAY_RULE = :C, NBR_COMPLETED = :D, START_COUNTER_DATE = :E   WHERE ROWID = :F ';


SQL_STMT := 'SELECT a.VENDOR_ID,a.VENDOR_CODE,a.FOLLOW_UP,a.FOLLOW_UP_SAT,a.FOLLOW_UP_DTE,a.STANDING,a.NBR_WORKORDERS,a.ACTIVE,a.LAST_REVIEW,a.REVIEWED_BY,a.SEGMENTS,a.CAP_HOLD,';
SQL_STMT := SQL_STMT||'a.BATCH_NO, a.WORKCODE,a.ASSIGNED_TO,a.COMPLETED_BY,a.START_COUNTER_DATE,a.FOLLOW_UP_CAT,a.THIRTY_FIFTY_DAY_RULE,a.assign_it, a.FOLLOW_UP_RES, a.NBR_COMPLETED, a.ROWID FROM SQA_VENDOR_LIST a  ';
SQL_STMT := SQL_STMT||' LEFT JOIN ( SELECT VENDORCODE,  NAME ';
SQL_STMT := SQL_STMT||'             FROM ALL_ACTIVE_VENDORS_MV';
SQL_STMT := SQL_STMT||'             WHERE TERMINATIONDATE IS NULL ) B ON ( A.VENDOR_CODE = B.VENDORCODE) ';
SQL_STMT := SQL_STMT||' WHERE  A.VENDOR_CODE = B.VENDORCODE ';
SQL_STMT := SQL_STMT||'  AND   a.assigned_to  = 0 ';
SQL_STMT := SQL_STMT||'  AND   a.completed_by = 0 ';
SQL_STMT := SQL_STMT||'  AND   a.assign_it    = 0 ';
SQL_STMT := SQL_STMT||'  AND   a.cap_hold     = 0 ';


SEL_STMT    := 'SELECT CONTRACTOR, REPORT_SEGMENT FROM SQA_TD_DATA WHERE CONTRACTOR = :A AND REPORT_SEGMENT = :B AND TRUNC(COMPLETED_DT) >= :C  AND TRUNC(COMPLETED_DT) <= :D ';
SEL_INITIAL := 'SELECT CONTRACTOR, REPORT_SEGMENT FROM SQA_TD_DATA WHERE CONTRACTOR = :A AND REPORT_SEGMENT = :B AND TRUNC(COMPLETED_DT) >=  :C ';

OPEN GC FOR SQL_STMT;
   FETCH GC BULK COLLECT INTO VL.VENDOR_ID,
                              VL.VENDOR_CODE,
                              VL.FOLLOW_UP,
                              VL.FOLLOW_UP_SAT,
                              VL.FOLLOW_UP_DTE,
                              VL.STANDING,
                              VL.NBR_WORKORDERS,
                              VL.ACTIVE,
                              VL.LAST_REVIEW,
                              VL.REVIEWED_BY,
                              VL.SEGMENTS,
                              VL.CAP_HOLD,
                              VL.BATCH_NO,
                              VL.WORKCODE,
                              VL.ASSIGNED_TO,
                              VL.COMPLETED_BY,
                              VL.START_COUNTER_DATE,
                              VL.FOLLOW_UP_CAT,
                              VL.THIRTY_FIFTY_DAY_RULE,
                              VL.ASSIGN_IT,
                              VL.FOLLOW_UP_RES,
                              VL.NBR_COMPLETED,
                              VL.ROWIDS;

--TESTING SET TRUNC(SYSDATE) TO GV_CURRENT_DATE


           FOR X IN 1..VL.VENDOR_CODE.COUNT LOOP

              DAYS_FROM_START :=   GV_CURRENT_DATE - VL.START_COUNTER_DATE(x);
              DAY_31          :=   VL.START_COUNTER_DATE(x) + 31;
              DAY_50          :=   VL.START_COUNTER_DATE(x) + 50;



              IF ( VL.FOLLOW_UP_CAT(x) IN ('FOLLOW-UP-VENDOR-FAILED-INITIAL','CHARGEBACK-FOLLOW-UP-VENDOR-FAILED','2ND-ROUND-INITIAL-AUDIT-FAILED') AND  DAYS_FROM_START = 30 )
                 THEN
                     OPEN GC FOR SEL_STMT USING VL.VENDOR_CODE(x), VL.SEGMENTS(x), VL.START_COUNTER_DATE(x),  GV_CURRENT_DATE;
                             FETCH GC BULK COLLECT INTO VW.VENDOR_CODE, VW.SEGMENTS;

                                COMPLETED := VW.VENDOR_CODE.COUNT;
                      VL.NBR_COMPLETED(x) := VW.VENDOR_CODE.COUNT;


/*
GV_30_RULE   NUMBER;
GV_50_RULE   NUMBER;
GV_100_RULE  NUMBER;
 */


                      VL.THIRTY_FIFTY_DAY_RULE(x) := case  WHEN  COMPLETED > 749 THEN GV_100_RULE
                                                           WHEN  COMPLETED > 499 THEN GV_50_RULE
                                                           WHEN  COMPLETED > 29  THEN GV_30_RULE
                                                     ELSE GV_30_RULE
                                                     END;


                   MSG := ' '||VL.VENDOR_CODE(x)||'- '||VL.SEGMENTS(x)||'-'||TO_CHAR(VL.START_COUNTER_DATE(x),'MM/DD/YYYY')||'-'||TO_CHAR(GV_CURRENT_DATE,'MM/DD/YYYY')||'-'|| VL.FOLLOW_UP_CAT(x);

                          INSERT INTO BOA_PROCESS_LOG
                                (
                                  PROCESS,
                                  SUB_PROCESS,
                                  ENTRYDTE,
                                  ROWCOUNTS,
                                  MESSAGE
                                )
                    VALUES ( 'SQA_LOVS', 'SET_NBR_VENDOR_WO - 30',sysdate, completed, MSG);
                    COMMIT;


              END IF;


              IF ( VL.FOLLOW_UP_CAT(x) IN ('FOLLOW-UP-VENDOR-FAILED-INITIAL','CHARGEBACK-FOLLOW-UP-VENDOR-FAILED','2ND-ROUND-INITIAL-AUDIT-FAILED') AND DAYS_FROM_START BETWEEN 31 AND 49 )
                 THEN
                     OPEN GC FOR SEL_STMT USING VL.VENDOR_CODE(x), VL.SEGMENTS(x), DAY_31,  GV_CURRENT_DATE;

                             FETCH GC BULK COLLECT INTO VW.VENDOR_CODE, VW.SEGMENTS;

                              COMPLETED := VW.VENDOR_CODE.COUNT;
                    VL.NBR_COMPLETED(x) := VW.VENDOR_CODE.COUNT;

                         THIRTY_FIFTY_DAY_RULE    := case  WHEN  COMPLETED > 749 THEN GV_100_RULE
                                                           WHEN  COMPLETED > 499 THEN GV_50_RULE
                                                           WHEN  COMPLETED > 29  THEN GV_30_RULE
                                                     ELSE 0
                                                     END;


                                         IF ( THIRTY_FIFTY_DAY_RULE >= VL.THIRTY_FIFTY_DAY_RULE(x)  )
                                         THEN
                                              VL.ASSIGN_IT(x)      :=   1;
                                              VL.NBR_WORKORDERS(x) :=  THIRTY_FIFTY_DAY_RULE;
                                         END IF;


                   MSG := ' '||VL.VENDOR_CODE(x)||'- '||VL.SEGMENTS(x)||'-'||TO_CHAR(VL.START_COUNTER_DATE(x),'MM/DD/YYYY')||'-'||TO_CHAR(GV_CURRENT_DATE,'MM/DD/YYYY')||'-'|| VL.FOLLOW_UP_CAT(x);

                          INSERT INTO BOA_PROCESS_LOG
                                (
                                  PROCESS,
                                  SUB_PROCESS,
                                  ENTRYDTE,
                                  ROWCOUNTS,
                                  MESSAGE
                                )
                    VALUES ( 'SQA_LOVS', 'SET_NBR_VENDOR_WO - 31',sysdate, completed, MSG);
                    COMMIT;


              END IF;

              IF ( VL.FOLLOW_UP_CAT(x) IN ('FOLLOW-UP-VENDOR-FAILED-INITIAL','CHARGEBACK-FOLLOW-UP-VENDOR-FAILED','2ND-ROUND-INITIAL-AUDIT-FAILED') AND DAYS_FROM_START = 50 )
                 THEN
                     OPEN GC FOR SEL_STMT USING VL.VENDOR_CODE(x), VL.SEGMENTS(x), DAY_31,  DAY_50;

                             FETCH GC BULK COLLECT INTO VW.VENDOR_CODE, VW.SEGMENTS;

                                             COMPLETED := VW.VENDOR_CODE.COUNT;
                                   VL.NBR_COMPLETED(x) := VW.VENDOR_CODE.COUNT;


                                   THIRTY_FIFTY_DAY_RULE    := case  WHEN  COMPLETED > 749 THEN GV_100_RULE
                                                                     WHEN  COMPLETED > 499 THEN GV_50_RULE
                                                                     WHEN  COMPLETED > 29  THEN GV_30_RULE
                                                               ELSE 0
                                                               END;


                                 NBR_TO_REVIEW := CASE WHEN THIRTY_FIFTY_DAY_RULE >= VL.THIRTY_FIFTY_DAY_RULE(x) THEN  THIRTY_FIFTY_DAY_RULE
                                                       WHEN THIRTY_FIFTY_DAY_RULE > 0                            THEN  THIRTY_FIFTY_DAY_RULE
                                                       WHEN COMPLETED < 29                                       THEN  COMPLETED
                                                  END;

                                              VL.ASSIGN_IT(x)      :=   1;
                                              VL.NBR_WORKORDERS(x) :=   NBR_TO_REVIEW;


                   MSG := ' '||VL.VENDOR_CODE(x)||'- '||VL.SEGMENTS(x)||'-'||TO_CHAR(VL.START_COUNTER_DATE(x),'MM/DD/YYYY')||'-'||TO_CHAR(GV_CURRENT_DATE,'MM/DD/YYYY')||'-'|| VL.FOLLOW_UP_CAT(x);

                          INSERT INTO BOA_PROCESS_LOG
                                (
                                  PROCESS,
                                  SUB_PROCESS,
                                  ENTRYDTE,
                                  ROWCOUNTS,
                                  MESSAGE
                                )
                    VALUES ( 'SQA_LOVS', 'SET_NBR_VENDOR_WO - 50',sysdate, completed, MSG);
                    COMMIT;


              END IF;

---                 90 DAYS FROM START
----                INITIAL LOAD COULD HAVE 30/50/100 FOR SAMPLE

              IF ( VL.FOLLOW_UP_CAT(x) IN ('INITIAL-TDA-NOT-NEW-VENDOR','INITIAL-NEW-TDA-VENDOR')  )
                 THEN
                     OPEN GC FOR SEL_INITIAL USING VL.VENDOR_CODE(x), VL.SEGMENTS(x), TRUNC(VL.START_COUNTER_DATE(x));

                             FETCH GC BULK COLLECT INTO VW.VENDOR_CODE, VW.SEGMENTS;

                                            COMPLETED := VW.VENDOR_CODE.COUNT;
                                  VL.NBR_COMPLETED(x) := VW.VENDOR_CODE.COUNT;

                                  VL.THIRTY_FIFTY_DAY_RULE(x) := case  WHEN  COMPLETED > 749 THEN GV_100_RULE
                                                                       WHEN  COMPLETED > 499 THEN GV_50_RULE
                                                                       WHEN  COMPLETED > 29  THEN GV_30_RULE
                                                                       ELSE  0
                                                                 END;

                                  IF  ( VL.THIRTY_FIFTY_DAY_RULE(x) > 0 )  THEN

                                       VL.ASSIGN_IT(x) := 1;

                                       VL.NBR_WORKORDERS(x) :=  VL.THIRTY_FIFTY_DAY_RULE(x);

                                  END IF;

              END IF;


            end loop;

CLOSE GC;

FORALL Y IN 1..VL.VENDOR_CODE.COUNT
    EXECUTE IMMEDIATE UPD_STMT USING VL.NBR_WORKORDERS(y), VL.ASSIGN_IT(y), VL.THIRTY_FIFTY_DAY_RULE(y), VL.NBR_COMPLETED(y), VL.START_COUNTER_DATE(y),   VL.ROWIDS(y);


     commit;

--TESTING

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'SET_NBR_VENDOR_WO',GV_CURRENT_DATE, RCODE, MSG);
    COMMIT;



exception
     when others then
     MSG := SQLERRM;
     RCODE := SQLCODE;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'SET_NBR_VENDOR_WO',SYSDATE, RCODE, MSG);
    COMMIT;



END;
/**********************************************************************************************************************

***********************************************************************************************************************/

procedure SET_REP_WORK_QUEUE(P_APP_USER VARCHAR2, P_VENDOR_ID NUMBER, P_VENDOR_NAME VARCHAR2, P_NUMBER_TO_REVIEW NUMBER)
IS

P_REVIEW_ID           NUMBER;
P_BATCH_NO            NUMBER;
PNBR_WORKORDERS       NUMBER;
P_FOLLOW_UP_SAT       VARCHAR2(100 BYTE);
P_FOLLOW_UP_DTE       DATE;
P_LAST_REVIEW         DATE;
P_SEGMENTS            VARCHAR2(100 BYTE);
P_START_COUNTER_DATE  DATE;
P_FOLLOW_UP_CAT       VARCHAR2(100 BYTE);
P_FOLLOW_UP_RES       VARCHAR2(100 BYTE);
MSG                   VARCHAR2(1000 BYTE);
SQLROWS               NUMBER;
RCODE                 NUMBER;
PPID                  NUMBER;
USER_ID               NUMBER;
GROUP_NO              NUMBER;
gc                    GenRefCursor;
SQL_STMT              VARCHAR2(32000 BYTE);
UPD_STMT              VARCHAR2(32000 BYTE);
TD                    SQA_TD_ASSIGN;
BAD_DATA              EXCEPTION;

BEGIN

      SELECT COUNT(*)
      INTO SQLROWS
      FROM SQA_VENDOR_LIST
      WHERE VENDOR_ID = P_VENDOR_ID
       AND  NVL(ASSIGNED_TO,0) > 0
       and  nvl(batch_no,0)    > 0
       AND  NVL(COMPLETED_by,0)   = 0;

     if ( sqlrows > 0 ) then

         raise bad_data;
     end if;


      SELECT SQA_TD_DATA_BATCH_SEQ.NEXTVAL
      INTO P_BATCH_NO
      FROM DUAL;

      SELECT PID
      INTO USER_ID
      FROM SQA_TD_QUEUE_PROCESSORS
      WHERE UPPER(LOGIN) = UPPER(P_APP_USER);


      UPDATE SQA_VENDOR_LIST SET REVIEWED_BY = P_APP_USER, batch_no = p_batch_no, assigned_to = USER_ID  WHERE VENDOR_ID = P_VENDOR_ID;

      COMMIT;

      SELECT  FOLLOW_UP_SAT,   FOLLOW_UP_DTE,      LAST_REVIEW,  SEGMENTS,      START_COUNTER_DATE, FOLLOW_UP_CAT,    FOLLOW_UP_RES,   NBR_WORKORDERS
      INTO    P_FOLLOW_UP_SAT, P_FOLLOW_UP_DTE,  P_LAST_REVIEW,  P_SEGMENTS,  P_START_COUNTER_DATE, P_FOLLOW_UP_CAT,  P_FOLLOW_UP_RES, PNBR_WORKORDERS
      FROM SQA_VENDOR_LIST
      WHERE VENDOR_ID = P_VENDOR_ID;

--TESTING SET TRUNC(SYSDATE) TO GV_CURRENT_DATE
INSERT INTO  SQA_VENDOR_HISTORY ( VENDOR_ID, REVIEWED_BY, NBR_REVIEWED,      REVIEW_DTE, POSSIBLE_PTS, POINTS_RECEIVED, REVIEW_SCORE,CALC_CMPT )
                       VALUES ( P_VENDOR_ID, P_APP_USER,  P_NUMBER_TO_REVIEW,GV_CURRENT_DATE, 0, 0, 0,0) RETURNING HISTORY_ID INTO P_REVIEW_ID;

                       COMMIT;
                       
--LIMIT P_NUMBER_TO_REVIEW;


GROUP_NO := 0;
SQLROWS  := 0;

UPD_STMT := 'UPDATE SQA_TD_DATA  SET WORKING = :A,  SQA_TD_REP = :B,  REVIEW_ID = :C,  BATCH_NO = :D  WHERE PID = :E';

SQL_STMT := 'SELECT PID, WORKING, SQA_TD_REP, REVIEW_ID,  0 AS BATCH_NO, COMPLETED_DT, RK ';
SQL_STMT := SQL_STMT||'  FROM ( SELECT PID, WORKING, SQA_TD_REP, REVIEW_ID, COMPLETED_DT , RANK() OVER (PARTITION BY ADD_1, CITY,ST, ZIP ORDER BY COMPLETED_DT DESC, ROWNUM) RK ';
SQL_STMT := SQL_STMT||'          FROM SQA_TD_DATA  ';
SQL_STMT := SQL_STMT||'          WHERE  WORKING IS NULL';
SQL_STMT := SQL_STMT||'           AND   SQA_TD_REP IS NULL';
SQL_STMT := SQL_STMT||'           AND   CONTRACTOR = :A';
SQL_STMT := SQL_STMT||'           AND   REPORT_SEGMENT = :B';
SQL_STMT := SQL_STMT||'           AND   COMPLETED_DT >= :C ) ';
SQL_STMT := SQL_STMT||'  WHERE   RK  = :R ';


WHILE ( SQLROWS < P_NUMBER_TO_REVIEW ) 
    LOOP
         GROUP_NO := GROUP_NO + 1;
    
    OPEN GC FOR SQL_STMT USING  P_VENDOR_NAME, P_SEGMENTS, P_START_COUNTER_DATE, GROUP_NO;
        FETCH GC BULK COLLECT INTO TD.PID,
                                   TD.WORKING,
                                   TD.SQA_TD_REP,
                                   TD.REVIEW_ID,
                                   TD.BATCH_NO,
                                   TD.COMPLETED_DT,
                                   TD.rk;
                        
    CLOSE GC;
     
           
           IF  (TD.PID.COUNT = 0) 
               THEN 
                   SQLROWS := P_NUMBER_TO_REVIEW;
           END IF;     

            FOR i IN 1..TD.PID.COUNT loop               
                EXIT WHEN SQLROWS >= P_NUMBER_TO_REVIEW;


                 
                IF (TD.COMPLETED_DT(i) > ( GV_CURRENT_DATE  - 60) ) 
                    THEN 
                       TD.WORKING(i)    := 'Y';
                       TD.SQA_TD_REP(i) := UPPER(P_APP_USER);
                       TD.REVIEW_ID(i)  := P_REVIEW_ID;
                       TD.BATCH_NO(i)   := P_BATCH_NO;
                       SQLROWS          := SQLROWS + 1;                                        
                END IF;
                
            END LOOP;                               


        FOR i IN 1..TD.PID.COUNT loop
           
           IF  ( TD.BATCH_NO(i)  > 0 ) THEN 
                EXECUTE IMMEDIATE UPD_STMT USING  TD.WORKING(i), TD.SQA_TD_REP(i), TD.REVIEW_ID(i), TD.BATCH_NO(i), TD.PID(i);
           END IF;
           
        END LOOP;                               

        COMMIT;

END LOOP;
        


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'SET_REP_WORK_QUEUE',SYSDATE, SQLROWS, 'Create Review univ');
    COMMIT;



          INSERT INTO SQA_TD_DATA_DETAILS
          (
            MASTER_ID,
            BATCH_NO,
            CONTRACTOR_ID,
            CLIENT,
            CONTRACTOR,
            REPORT_SEGMENT,
            REVIEW_ID
          )
          SELECT PID, BATCH_NO, P_VENDOR_ID, CLIENT, CONTRACTOR, REPORT_SEGMENT, P_REVIEW_ID
          FROM SQA_TD_DATA
          WHERE BATCH_NO = P_BATCH_NO;

          SQLROWS := SQL%ROWCOUNT;

         COMMIT;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'SET_REP_WORK_QUEUE',SYSDATE, SQLROWS, 'insert into details');
    COMMIT;



exception
     WHEN BAD_DATA THEN

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'SET_REP_WORK_QUEUE',SYSDATE, -1, 'The Process attempted to batch a open review');
    COMMIT;

     when others then
     MSG := SQLERRM;
     RCODE := SQLCODE;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'SET_REP_WORK_QUEUE',SYSDATE, RCODE, MSG);
    COMMIT;

END;


PROCEDURE ADD_VENDOR_TO_LIST
IS
/*
TYPE VENDOR_SEGMENTS IS RECORD
(
 VENDOR_CODE      DBMS_SQL.VARCHAR2_TABLE,
 SEGMENTS         DBMS_SQL.VARCHAR2_TABLE
);

*/

GC       GenRefCursor;
VS       VENDOR_SEGMENTS;
SQL_STMT VARCHAR2(32000);

BEGIN
    SQL_STMT := ' SELECT A.VENDOR_CODE,A.SEGMENTS FROM SQA_VENDOR_LIST A ';
    SQL_STMT := SQL_STMT||' LEFT JOIN ( SELECT CONTRACTOR, SEGMENTS ';
    SQL_STMT := SQL_STMT||'             FROM ( SELECT CONTRACTOR ';
END;


PROCEDURE SETUP_CAP_HOLD_FLAG
IS

/*
TYPE CAP_HOLD IS RECORD
(
 VENDOR_ID       DBMS_SQL.NUMBER_TABLE,
 CAP_HOLD        DBMS_SQL.NUMBER_TABLE,
 ROWIDS          RowidArray
);
*/

GC       GenRefCursor;

SQL_STMT VARCHAR2(32000);
CNT      NUMBER;

BEGIN


     SQL_STMT := ' SELECT VENDOR_ID, CAP_HOLD, ROWID FROM SQA_VENDOR_LIST';
     OPEN GC FOR SQL_STMT;
            FETCH GC BULK COLLECT INTO cp.vendor_id, cp.cap_hold, cp.rowids;
     close gc;

CNT := CP.VENDOR_ID.COUNT;



END;


PROCEDURE SET_CAP_HOLD_FLAG( P_VENDOR_ID NUMBER, P_CAP_HOLD NUMBER)
IS

CNT      NUMBER;

BEGIN



     for x in 1..cp.vendor_id.count loop
           if ( cp.vendor_id(x) = p_vendor_id)
              then
                cp.cap_hold(x)  := P_CAP_HOLD;
           end if;
     end loop;


CNT := CP.VENDOR_ID.COUNT;



END;




PROCEDURE UPD_CAP_HOLD_FLAG
IS

  SQL_STMT VARCHAR2(32000);

  CNT   NUMBER;
BEGIN
      SQL_STMT := 'UPDATE SQA_VENDOR_LIST SET CAP_HOLD = :A, BATCH_NO = 0, assigned_to = 0, THIRTY_FIFTY_DAY_RULE = 0,NBR_WORKORDERS = 0,NBR_COMPLETED = 0, assign_it = -1  WHERE ROWID = :B ';


    forall x IN 1..cp.vendor_id.count
    EXECUTE IMMEDIATE  SQL_STMT USING  cp.cap_hold(x), cp.ROWIDS(x);

    commit;

CNT := CP.VENDOR_ID.COUNT;


END;
-------------------------------------------------------------------------------------------------------------------------------------------------------------
------------   creating HTML attachments
--------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE GEN_EMAILS ( P_PAGE_NO   NUMBER,
                       P_REVIEWID  NUMBER,
                       P_CLIENT    VARCHAR2,
                       P_LOAN_TYPE VARCHAR2,
                       P_WORK_CODE VARCHAR2,
                       P_VENDORID  NUMBER)
IS

gc  GenRefCursor;
---------------------------------------------
------------------------------- SUMMARY REPORT
------------------------------------------------
CURSOR SHD ( R_NAME VARCHAR2)
IS
SELECT XMLNS
FROM SQA_TD_XMLNS
WHERE REF_NAME = R_NAME;
SHDR  SHD%ROWTYPE;

CURSOR SCL ( SHEET VARCHAR2)
IS
SELECT CLASS_DEF
 FROM SQA_TD_CLASSES
 WHERE SHEET_NAME = SHEET;

SCLR SCL%ROWTYPE;

CURSOR SSM ( P_BATCH_NO NUMBER)
IS
SELECT QUESTION, TOTAL_PER_TASK, TASK_COMPLIENT, REPORT_ORDER
FROM SQA_TD_REPORT_SUMMARY
WHERE BATCH_NO = P_BATCH_NO
ORDER BY REPORT_ORDER;

SSMR   SSM%ROWTYPE;


CURSOR SC3(RID NUMBER)
IS
SELECT PID
FROM SQA_TD_DATA
WHERE REVIEW_ID = RID;

SC3R  SC3%ROWTYPE;

-----------------------------------------------------------------

CURSOR CC (P_APP VARCHAR2)
IS
SELECT APP, CONTACT_GROUP, FIRST_NAME, LAST_NAME, EMAILADDRESS, WORKSPACE, EMAIL_OPTIONS
FROM SQA_EMAIL_ADDRESSES
WHERE EMAIL_OPTIONS = 3
AND   CONTACT_GROUP = 'RDM'
AND   APP IN (P_APP);

RC   CC%ROWTYPE;
------------------------------------------------
-------------------------- Detail Report
------------------------------------------------
CURSOR QUES( P_PAGE_NO NUMBER)
IS
SELECT  COLUMN_NAME, HEADING
FROM SQA_TD_QUESTION_HEADINGS
where column_name not in ( 'DATA_DT', 'ST','CONTRACTOR', 'CLIENT', 'LOAN_TYPE','ORDER_DT','COMPLETED_DT','ORDER_NUM','COMMENTS')
AND   PAGE_NO = P_PAGE_NO
ORDER BY COLUMN_NBR;

Q1     QUES%ROWTYPE;

CURSOR CL(SHEET VARCHAR2)
IS
SELECT CLASS_DEF
 FROM SQA_TD_CLASSES WHERE SHEET_NAME = SHEET;
R2 CL%ROWTYPE;

CURSOR SM ( P_BATCH_NO NUMBER)
IS
SELECT QUESTION, TOTAL_PER_TASK, TASK_COMPLIENT, REPORT_ORDER
FROM SQA_TD_REPORT_SUMMARY
WHERE BATCH_NO = P_BATCH_NO
ORDER BY REPORT_ORDER;

R3   SM%ROWTYPE;


P1  SQA_LOVS.PAGE_341;
P2  SQA_LOVS.PAGE_342;
P3  SQA_LOVS.PAGE_343;
P4  SQA_LOVS.PAGE_344;
P5  SQA_LOVS.PAGE_345;
DS  SQA_LOVS.DYN_STMT_REC;
SS  SQA_LOVS.DYN_STMT_REC;


MSG                VARCHAR2(1000  BYTE);
RCODE              NUMBER;
HEADING_LINE       VARCHAR2(4000  BYTE);
SQL_STMT           VARCHAR2(32000 BYTE);
INS_STMT           VARCHAR2(32000 BYTE);
LETTERS            VARCHAR2(4000  BYTE);
WORK_GROUP         VARCHAR2(20    BYTE);
LC_CLIENT          VARCHAR2(20    BYTE);
LC_SCORE           VARCHAR2(20    BYTE);
LC_FOLLOW_UP_CAT   VARCHAR2(200   BYTE);
LC_FOLLOW_UP_SAT   VARCHAR2(100   BYTE);
LC_FOLLOW_UP_RES   VARCHAR2(20    BYTE);
LC_FOLLOW_UP_DTE   VARCHAR2(30    BYTE);
LC_VENDOR          VARCHAR2(100   BYTE);
LC_LAST_REVIEW     VARCHAR2(30    BYTE);
LC_AUDIT_TYPE      VARCHAR2(100   BYTE);
LC_EMAIL           VARCHAR2(100   BYTE);
LC_GREETINGS       VARCHAR2(40    BYTE);
LC_MONYYYY         VARCHAR2(40    BYTE);
cc_list            VARCHAR2(1000  BYTE);
LC_TESTING_MODE    NUMBER;

summary_blob        blob;
summary_clob        clob;
summary_id          NUMBER;


XML_STMT           VARCHAR2(32000 BYTE);
TOT_STMT           VARCHAR2(32000 BYTE);

blob_stmt          blob;
clob_stmt          clob;
blob_ref           blob;
local_id           NUMBER;

P_FORM_ID          NUMBER;

CNT                NUMBER;

N_NBR_REVIEWED     NUMBER;
N_POSSIBLE_PTS     NUMBER;
N_POINTS_RECEIVED  NUMBER;
N_REVIEW_SCORE     NUMBER;

N_COLUMNS          NUMBER;
TBL_SIZE           NUMBER;
TBL_WIDTH          NUMBER;
TBL_STY_WIDTH      NUMBER;

dest_offset        integer;
src_offset         integer;
lang_context       integer;
warning            varchar2(1000);





function pick_class ( p_question varchar2,p_count number, p_score number) return varchar2
is

rating  varchar2(32000 byte);


begin

IF ( P_SCORE > 94.5)
      THEN
      rating := ' <tr height=20 style=''height:15.0pt''>';
      rating := rating||'<td height=20 class=xl641057 style=''height:15.0pt;border-top:none''>'||p_question||'</td>'||utl_tcp.crlf;
      rating := rating||'<td class=xl651057 style=''border-top:none;border-left:none''>'||p_count||'</td>'||utl_tcp.crlf;
      rating := rating||'<td class=xl661057 style=''border-top:none;border-left:none;font-size:9.5pt;'||utl_tcp.crlf;
      rating := rating||'color:#006100;font-weight:400;text-decoration:none;text-underline-style:none; '||utl_tcp.crlf;
      rating := rating||'text-line-through:none;font-family:Calibri;border:.5pt solid windowtext;'||utl_tcp.crlf;
      rating := rating||'background:#C6EFCE;mso-pattern:black none''>'||to_char(p_score,'999')||'%</td>'||utl_tcp.crlf;
      rating := rating||'</tr>'||utl_tcp.crlf;

      return rating;

end if;

if  ( p_score > 75.0 )
      then
      rating := ' <tr height=20 style=''height:15.0pt''>';
      rating := rating||'<td height=20 class=xl641057 style=''height:15.0pt;border-top:none''>'||p_question||'</td>'||utl_tcp.crlf;
      rating := rating||'<td class=xl651057 style=''border-top:none;border-left:none''>'||p_count||'</td>'||utl_tcp.crlf;
      rating := rating||'<td class=xl661057 style=''border-top:none;border-left:none;font-size:9.5pt;'||utl_tcp.crlf;
      rating := rating||'color:#9C6500;font-weight:400;text-decoration:none;text-underline-style:none; '||utl_tcp.crlf;
      rating := rating||'text-line-through:none;font-family:Calibri;border:.5pt solid windowtext;'||utl_tcp.crlf;
      rating := rating||'background:#FFEB9C;mso-pattern:black none''>'||to_char(p_score,'999')||'%</td>'||utl_tcp.crlf;
      rating := rating||'</tr>'||utl_tcp.crlf;

      return rating;
end if;

      rating := ' <tr height=20 style=''height:15.0pt''>';
      rating := rating||'<td height=20 class=xl641057 style=''height:15.0pt;border-top:none''>'||p_question||'</td>'||utl_tcp.crlf;
      rating := rating||'<td class=xl651057 style=''border-top:none;border-left:none''>'||p_count||'</td>'||utl_tcp.crlf;
      rating := rating||'<td class=xl661057 style=''border-top:none;border-left:none;font-size:9.5pt;'||utl_tcp.crlf;
      rating := rating||'color:#9C0006;font-weight:400;text-decoration:none;text-underline-style:none; '||utl_tcp.crlf;
      rating := rating||'text-line-through:none;font-family:Calibri;border:.5pt solid windowtext;'||utl_tcp.crlf;
      rating := rating||'background:#FFC7CE;mso-pattern:black none''>'||to_char(p_score,'999')||'%</td>'||utl_tcp.crlf;
      rating := rating||'</tr>'||utl_tcp.crlf;

      return rating;


end;

BEGIN


SELECT GROUP_NAME
INTO   WORK_GROUP
FROM   SQA_TD_WORK_GROUPS
WHERE  WORKCODE = P_WORK_CODE;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'GEN EMAILS',SYSDATE, 0, P_WORK_CODE||' To '||WORK_GROUP);
    COMMIT;


OPEN CC ('Top-Down');
      LOOP
          FETCH CC INTO RC;
          EXIT WHEN CC%NOTFOUND;
          cc_list := cc_list||rc.EMAILADDRESS||',';
      END LOOP;
CLOSE CC;

        cc_list := rtrim(cc_list,',');

        SELECT    NBR_REVIEWED,   POSSIBLE_PTS,   POINTS_RECEIVED,   REVIEW_SCORE, TO_CHAR(REVIEW_SCORE,'99,99')
        INTO    N_NBR_REVIEWED, N_POSSIBLE_PTS, N_POINTS_RECEIVED, N_REVIEW_SCORE, LC_SCORE
        FROM SQA_VENDOR_HISTORY
        WHERE HISTORY_ID = P_REVIEWID;


/*
       SQA_VENDOR_LIST
           FOLLOW_UP_SAT      = LC_FOLLOW_UP_SAT,
           FOLLOW_UP_CAT      = LC_FOLLOW_UP_CAT,
           FOLLOW_UP_RES      = LC_FOLLOW_UP_RES,
           FOLLOW_UP          = LC_FOLLOW_UP,
           STANDING           = BOTTOM_OF_LIST,
           FOLLOW_UP_DTE      =  LC_FOLLOW_UP_DTE,
           NBR_WORKORDERS     =  0,
           LAST_REVIEW        = TRUNC(SYSDATE),
           START_COUNTER_DATE = TRUNC(SYSDATE),
           ASSIGN_IT          = 0,
           COMPLETED_BY       = ASSIGNED_TO
          WHERE VENDOR_ID = P_VENDOR_ID;
*/

       SELECT  FOLLOW_UP_SAT,    FOLLOW_UP_RES,    TO_CHAR(FOLLOW_UP_DTE,'MM/DD/YY'), VENDOR_CODE, TO_CHAR(LAST_REVIEW,'MM/DD/YY'), FOLLOW_UP_CAT,    SEGMENTS
       INTO LC_FOLLOW_UP_SAT, LC_FOLLOW_UP_RES,         LC_FOLLOW_UP_DTE,            LC_VENDOR,           LC_LAST_REVIEW,           LC_FOLLOW_UP_CAT, LC_AUDIT_TYPE
       FROM SQA_VENDOR_LIST
       WHERE VENDOR_ID = P_VENDORID;
--- Find Email address
-----------------------

  SELECT VARIABLE_VALUE
  INTO LC_TESTING_MODE
       FROM SQA_SYS_VARIABLES
       WHERE  VARIABLE_NAME = 'TESTING';

begin

        IF ( LC_TESTING_MODE IN (1) )
           THEN
               SELECT VARIABLE_VALUE
               INTO LC_EMAIL
               FROM SQA_SYS_VARIABLES
               WHERE  VARIABLE_NAME = LC_VENDOR
                AND   ROWNUM = 1;
        ELSE

               SELECT EMAIL
               INTO LC_EMAIL
               FROM ALL_ACTIVE_VENDORS
               WHERE VENDORCODE = LC_VENDOR
               AND  ROWNUM = 1;
        END IF;

exception
     when others then
     LC_EMAIL := 'christian.gardner@safeguardproperties.com';
end;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'GEN EMAILS',SYSDATE, 0, 'TO: '||LC_EMAIL);
    COMMIT;


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'GEN EMAILS',SYSDATE, 0, 'SET UP COMPLETE');
    COMMIT;


XML_STMT :=  ' <html xmlns:o="urn:schemas-microsoft-com:office:office"'||utl_tcp.crlf;
XML_STMT :=  XML_STMT||' xmlns:x="urn:schemas-microsoft-com:office:excel" '||utl_tcp.crlf;
XML_STMT :=  XML_STMT||' xmlns="http://www.w3.org/TR/REC-html40">'||utl_tcp.crlf;
XML_STMT :=  XML_STMT||'<head>'||utl_tcp.crlf;
XML_STMT :=  XML_STMT||'<meta http-equiv=Content-Type content="text/html; charset=windows-1252"> '||utl_tcp.crlf;
XML_STMT :=  XML_STMT||'<meta name=ProgId content=Excel.Sheet>'||utl_tcp.crlf;
XML_STMT :=  XML_STMT||'<meta name=Generator content="Microsoft Excel 14">'||utl_tcp.crlf;
XML_STMT :=  XML_STMT||'<link rel=File-List href="Questions-w-size_files/filelist.xml">'||utl_tcp.crlf;
XML_STMT :=  XML_STMT||'<style id="Complete Questions For Vendor_2472_Styles">'||utl_tcp.crlf;
XML_STMT :=  XML_STMT||'<!--table  '||utl_tcp.crlf;
XML_STMT :=  XML_STMT||' {mso-displayed-decimal-separator:"\.";   '||utl_tcp.crlf;
XML_STMT :=  XML_STMT||'  mso-displayed-thousand-separator:"\,";} '||utl_tcp.crlf;



DS.DYN_STMT(1) := XML_STMT;

CNT := 1;

open CL('Details');
      LOOP
       fetch CL INTO R2;
        EXIT WHEN CL%NOTFOUND;
        XML_STMT := R2.CLASS_DEF||utl_tcp.crlf;
        CNT := CNT + 1;
        DS.DYN_STMT(CNT) := XML_STMT;
     END LOOP;
CLOSE CL;



XML_STMT := '</style>'||utl_tcp.crlf||'</head>'||utl_tcp.crlf||'<body>'||utl_tcp.crlf||'<div id="Complete Questions For Vendor_2472" align=center x:publishsource="Excel">'||utl_tcp.crlf;

CNT := CNT + 1;
DS.DYN_STMT(CNT) := XML_STMT;



IF  ( P_PAGE_NO IN (341)  )
    THEN



          TBL_SIZE      := 31;
          TBL_WIDTH     := 6150;
          TBL_STY_WIDTH := 4150;


          SQL_STMT := ' SELECT DATA_DT,ST,CONTRACTOR,CLIENT,LOAN_TYPE,ORDER_DT,COMPLETED_DT,ORDER_NUM,SWEEPING,VACUUMING,MOPPING,WIPING_SURFACES,INSIDE_ALL_TOILETS,INSIDE_OUT_APPLIANCES,';
          SQL_STMT := SQL_STMT||' INSIDE_ALL_CLOSETS,ENTIRE_BASEMENT,SAFETY_HAZARD_AREA,CIRCUIT_BREAKER,AIR_FRESHENERS_DATED,SHOW_ALL_AIR_FRESHENERS,CHECKLIST,VOLT_STICK,LOCKBOX,FRONT_OF_HOUSE,';
          SQL_STMT := SQL_STMT||' ADDRESS_PHOTO,RIGHT_LEFT_SIDE_OF_HOUSE,BACK_OF_PROPERTY,GATE_ALLOWING_ENTRY,UP_DOWN_STREET,BEHIND_BUILDING_GARAGE,COMMENTS ';
          SQL_STMT := SQL_STMT||' FROM SQA_TD_DATA WHERE REVIEW_ID = :A';

          OPEN GC FOR SQL_STMT USING P_REVIEWID;
          FETCH GC BULK COLLECT INTO P1.DATA_DT,
                                     P1.ST,
                                     P1.CONTRACTOR,
                                     P1.CLIENT,
                                     P1.LOAN_TYPE,
                                     P1.ORDER_DT,
                                     P1.COMPLETED_DT,
                                     P1.ORDER_NUM,
                                     P1.SWEEPING,
                                     P1.VACUUMING,
                                     P1.MOPPING,
                                     P1.WIPING_SURFACES,
                                     P1.INSIDE_ALL_TOILETS,
                                     P1.INSIDE_OUT_APPLIANCES,
                                     P1.INSIDE_ALL_CLOSETS,
                                     P1.ENTIRE_BASEMENT,
                                     P1.SAFETY_HAZARD_AREA,
                                     P1.CIRCUIT_BREAKER,
                                     P1.AIR_FRESHENERS_DATED,
                                     P1.SHOW_ALL_AIR_FRESHENERS,
                                     P1.CHECKLIST,
                                     P1.VOLT_STICK,
                                     P1.LOCKBOX,
                                     P1.FRONT_OF_HOUSE,
                                     P1.ADDRESS_PHOTO,
                                     P1.RIGHT_LEFT_SIDE_OF_HOUSE,
                                     P1.BACK_OF_PROPERTY,
                                     P1.GATE_ALLOWING_ENTRY,
                                     P1.UP_DOWN_STREET,
                                     P1.BEHIND_BUILDING_GARAGE,
                                     P1.COMMENTS;


        XML_STMT := XML_STMT||' <table border=0 cellpadding=0 cellspacing=0 width='||TBL_WIDTH||' style=''border-collapse: collapse;table-layout:fixed;width:'||TBL_STY_WIDTH||'''>'||utl_tcp.crlf;

        CNT := CNT + 1;

        DS.DYN_STMT(CNT) := XML_STMT;

---top bar

         ----- DATA_DT
         XML_STMT := ' <col class=xl642472 width=100 style=''mso-width-source:userset;mso-width-alt: 400;width:75pt''> '||utl_tcp.crlf;


         ----- ST,CONTRACTOR,CLIENT,LOAN_TYPE,ORDER_DT,COMPLETED_DT,ORDER_NUM
         FOR I IN 1..7 LOOP

             XML_STMT := XML_STMT|| '<col class=xl642472 width=100 style=''mso-width-source:userset;mso-width-alt: 400;width:75pt''>'||utl_tcp.crlf;

         END LOOP;


         ---- 22 QUESTIONS
        for i in 1..22 LOOP

          XML_STMT := XML_STMT|| '<col class=xl942472 width=150 style=''mso-width-source:userset;mso-width-alt: 600;width:150pt''>'||utl_tcp.crlf;

        END LOOP;

          ------ COMMENTS

          XML_STMT := XML_STMT|| '<col class=xl942472 width=600 style=''mso-width-source:userset;mso-width-alt: 2400;width:600t''>'||utl_tcp.crlf;


          CNT := CNT + 1;
          DS.DYN_STMT(CNT) := XML_STMT;


---- title Bar


    XML_STMT := '<tr style=''height:18.75pt''> '||utl_tcp.crlf;

    FOR A IN 1..13 LOOP
                XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none:width:100pt''>&nbsp;</td>'||utl_tcp.crlf;
    END LOOP;

      XML_STMT := XML_STMT||'<td colspan=2 class=xl802472  style=''border-left:none;width:325pt''>Complete Questions for Contractor</td>'||utl_tcp.crlf;

    FOR B IN 1..15 LOOP
       XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none;width:150pt''>&nbsp;</td>'||utl_tcp.crlf;
    END LOOP;

       XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none;width:600pt''>&nbsp;</td>'||utl_tcp.crlf;
       XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

      CNT := CNT + 1;
      DS.DYN_STMT(CNT) := XML_STMT;


--- blank space across screen

    XML_STMT := '<tr height=20 style=''height:15.0pt''>'||utl_tcp.crlf;

      for i in 1..31 loop
          XML_STMT := XML_STMT||'<td class=x1822472</td>'||utl_tcp.crlf;

      end loop;

      XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;


      CNT := CNT + 1;
      DS.DYN_STMT(CNT) := XML_STMT;


      XML_STMT := '<tr height=64 style=''mso-height-source:userset;height:48.0pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Date</td> '||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>State</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Contractor</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Client</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Loan Type</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Order Date</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Completed Date</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Order #</td>'||utl_tcp.crlf;




        OPEN QUES (P_PAGE_NO);
              LOOP
                 FETCH QUES INTO Q1;
                 EXIT WHEN QUES%NOTFOUND;
                 XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none;width:150pt''>'||Q1.HEADING||'</td>'||utl_tcp.crlf;
              END LOOP;
        CLOSE QUES;
                 XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none;width:600pt''>Comments</td>'||utl_tcp.crlf;
                 XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;


        CNT := CNT + 1;
        DS.DYN_STMT(CNT) := XML_STMT;



     for k in 1..P1.DATA_DT.count loop
        XML_STMT := '<tr style=''height:15.75pt''> '||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P1.DATA_DT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P1.ST(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P1.CONTRACTOR(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P1.CLIENT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P1.LOAN_TYPE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P1.ORDER_DT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P1.COMPLETED_DT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P1.ORDER_NUM(k)||'</td>'||utl_tcp.crlf;

            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.SWEEPING(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.VACUUMING(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.MOPPING(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.WIPING_SURFACES(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.INSIDE_ALL_TOILETS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.INSIDE_OUT_APPLIANCES(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.INSIDE_ALL_CLOSETS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.ENTIRE_BASEMENT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.SAFETY_HAZARD_AREA(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.CIRCUIT_BREAKER(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.AIR_FRESHENERS_DATED(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.SHOW_ALL_AIR_FRESHENERS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.CHECKLIST(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.VOLT_STICK(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.LOCKBOX(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.FRONT_OF_HOUSE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.ADDRESS_PHOTO(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.RIGHT_LEFT_SIDE_OF_HOUSE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.BACK_OF_PROPERTY(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.GATE_ALLOWING_ENTRY(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.UP_DOWN_STREET(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:150pt''>'||P1.BEHIND_BUILDING_GARAGE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:600pt''>'||P1.COMMENTS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

            CNT := CNT + 1;
            DS.DYN_STMT(CNT) := XML_STMT;


     end loop;

        XML_STMT := '</table>'||utl_tcp.crlf||'</div>'||utl_tcp.crlf||'</body>'||utl_tcp.crlf||'</html>'||utl_tcp.crlf;

        CNT := CNT + 1;
        DS.DYN_STMT(CNT) := XML_STMT;



END IF;

IF  ( P_PAGE_NO IN (342)  )
    THEN

              TBL_SIZE      := 20;
              TBL_WIDTH     := 4150;
              TBL_STY_WIDTH := 2766;



          SQL_STMT :=   ' SELECT DATA_DT,ST,CONTRACTOR,CLIENT,LOAN_TYPE,ORDER_DT,COMPLETED_DT,ORDER_NUM,SWEEPING,VACUUMING,MOPPING,WIPING_SURFACES,INSIDE_ALL_TOILETS,INSIDE_OUT_APPLIANCES,';
          SQL_STMT := SQL_STMT||' SAFETY_HAZARD_AREA,AIR_FRESHENERS_DATED,CHECKLIST,VOLT_STICK,FRONT_OF_HOUSE,COMMENTS ';
          SQL_STMT := SQL_STMT||' FROM SQA_TD_DATA WHERE REVIEW_ID = :A';

          OPEN GC FOR SQL_STMT USING P_REVIEWID;
          FETCH GC BULK COLLECT INTO  P2.DATA_DT,
                                      P2.ST,
                                      P2.CONTRACTOR,
                                      P2.CLIENT,
                                      P2.LOAN_TYPE,
                                      P2.ORDER_DT,
                                      P2.COMPLETED_DT,
                                      P2.ORDER_NUM,
                                      P2.SWEEPING,
                                      P2.VACUUMING,
                                      P2.MOPPING,
                                      P2.WIPING_SURFACES,
                                      P2.INSIDE_ALL_TOILETS,
                                      P2.INSIDE_OUT_APPLIANCES,
                                      P2.SAFETY_HAZARD_AREA,
                                      P2.AIR_FRESHENERS_DATED,
                                      P2.CHECKLIST,
                                      P2.VOLT_STICK,
                                      P2.FRONT_OF_HOUSE,
                                      P2.COMMENTS;


        XML_STMT := XML_STMT||' <table border=0 cellpadding=0 cellspacing=0 width='||TBL_WIDTH||' style=''border-collapse: collapse;table-layout:fixed;width:'||TBL_STY_WIDTH||'''>'||utl_tcp.crlf;

        CNT := CNT + 1;

        DS.DYN_STMT(CNT) := XML_STMT;

---top bar

         ----- DATA_DT
         XML_STMT := ' <col class=xl642472 width=100 style=''mso-width-source:userset;mso-width-alt: 400;width:75pt''> '||utl_tcp.crlf;


         ----- ST,CONTRACTOR,CLIENT,LOAN_TYPE,ORDER_DT,COMPLETED_DT,ORDER_NUM
         FOR I IN 1..7 LOOP

             XML_STMT := XML_STMT|| '<col class=xl642472 width=100 style=''mso-width-source:userset;mso-width-alt: 400;width:75pt''>'||utl_tcp.crlf;

         END LOOP;


         ---- 11 QUESTIONS
        for i in 1..11 LOOP

          XML_STMT := XML_STMT|| '<col class=xl942472 width=150 style=''mso-width-source:userset;mso-width-alt: 600;width:150pt''>'||utl_tcp.crlf;

        END LOOP;

          ------ COMMENTS

          XML_STMT := XML_STMT|| '<col class=xl942472 width=600 style=''mso-width-source:userset;mso-width-alt: 2400;width:600t''>'||utl_tcp.crlf;


          CNT := CNT + 1;
          DS.DYN_STMT(CNT) := XML_STMT;


---- title Bar


    XML_STMT := '<tr style=''height:18.75pt''> '||utl_tcp.crlf;

    FOR A IN 1..7 LOOP
                XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none:width:100pt''>&nbsp;</td>'||utl_tcp.crlf;
    END LOOP;

      XML_STMT := XML_STMT||'<td colspan=2 class=xl802472  style=''border-left:none;width:325pt''>Complete Questions for Contractor</td>'||utl_tcp.crlf;

    FOR B IN 1..10 LOOP
       XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none;width:150pt''>&nbsp;</td>'||utl_tcp.crlf;
    END LOOP;

       XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none;width:600pt''>&nbsp;</td>'||utl_tcp.crlf;
       XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

      CNT := CNT + 1;
      DS.DYN_STMT(CNT) := XML_STMT;


--- blank space across screen

    XML_STMT := '<tr height=20 style=''height:15.0pt''>'||utl_tcp.crlf;

      for i in 1..20 loop
          XML_STMT := XML_STMT||'<td class=x1822472</td>'||utl_tcp.crlf;

      end loop;

      XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;


      CNT := CNT + 1;
      DS.DYN_STMT(CNT) := XML_STMT;


      XML_STMT := '<tr height=64 style=''mso-height-source:userset;height:48.0pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Date</td> '||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>State</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Contractor</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Client</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Loan Type</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Order Date</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Completed Date</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Order #</td>'||utl_tcp.crlf;




        OPEN QUES (p_page_no);
              LOOP
                 FETCH QUES INTO Q1;
                 EXIT WHEN QUES%NOTFOUND;
                 XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none;width:150pt''>'||Q1.HEADING||'</td>'||utl_tcp.crlf;
              END LOOP;
        CLOSE QUES;
                 XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none;width:600pt''>Comments</td>'||utl_tcp.crlf;
                 XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;


        CNT := CNT + 1;
        DS.DYN_STMT(CNT) := XML_STMT;



     for k in 1..P2.DATA_DT.count loop
        XML_STMT := '<tr style=''height:15.75pt''> '||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P2.DATA_DT(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.ST(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.CONTRACTOR(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.CLIENT(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.LOAN_TYPE(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P2.ORDER_DT(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P2.COMPLETED_DT(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.ORDER_NUM(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.SWEEPING(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.VACUUMING(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.MOPPING(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.WIPING_SURFACES(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.INSIDE_ALL_TOILETS(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.INSIDE_OUT_APPLIANCES(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.SAFETY_HAZARD_AREA(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.AIR_FRESHENERS_DATED(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.CHECKLIST(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.VOLT_STICK(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.FRONT_OF_HOUSE(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P2.COMMENTS(k)||'</td>'||utl_tcp.crlf;
        XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

            CNT := CNT + 1;
            DS.DYN_STMT(CNT) := XML_STMT;

     end loop;

        XML_STMT := '</table>'||utl_tcp.crlf||'</div>'||utl_tcp.crlf||'</body>'||utl_tcp.crlf||'</html>'||utl_tcp.crlf;

        CNT := CNT + 1;
        DS.DYN_STMT(CNT) := XML_STMT;


END IF;




IF  ( P_PAGE_NO IN (343)  )
    THEN
          TBL_SIZE      := 26;
          TBL_WIDTH     := 5158;
          TBL_STY_WIDTH := 2400;


          SQL_STMT :=   ' SELECT DATA_DT,ST,CONTRACTOR,CLIENT,LOAN_TYPE,ORDER_DT,COMPLETED_DT,ORDER_NUM,FRONT_OF_HOUSE,FOUR_SIDES_OF_HOUSE,BACK_OF_PROPERTY,GATE_ALLOWING_ENTRY,BA_FRONT_YARD,BA_BACK_YARD,WEED_WHACKING,EDGED_PAVED_AREAS,';
          SQL_STMT := SQL_STMT||' FENCE_FOUNDATION_NO_WEEDS,FLOWER_ROCKSCAPE_FREE_OF_WEEDS,BEHIND_BUILDING_GARAGE,UNDER_PORCH_DECK,SHRUBS_CUT_WHEN_NEEDED,RULER_PHOT0_TWO_INCHES,LOCKBOX,ADDRESS_PHOTO,UP_DOWN_STREET,COMMENTS ';
          SQL_STMT := SQL_STMT||' FROM SQA_TD_DATA WHERE REVIEW_ID = :A';

          OPEN GC FOR SQL_STMT USING  P_REVIEWID;
          FETCH GC BULK COLLECT INTO  P3.DATA_DT,
                                      P3.ST,
                                      P3.CONTRACTOR,
                                      P3.CLIENT,
                                      P3.LOAN_TYPE,
                                      P3.ORDER_DT,
                                      P3.COMPLETED_DT,
                                      P3.ORDER_NUM,
                                      P3.FRONT_OF_HOUSE,
                                      P3.FOUR_SIDES_OF_HOUSE,
                                      P3.BACK_OF_PROPERTY,
                                      P3.GATE_ALLOWING_ENTRY,
                                      P3.BA_FRONT_YARD,
                                      P3.BA_BACK_YARD,
                                      P3.WEED_WHACKING,
                                      P3.EDGED_PAVED_AREAS,
                                      P3.FENCE_FOUNDATION_NO_WEEDS,
                                      P3.FLOWER_ROCKSCAPE_FREE_OF_WEEDS,
                                      P3.BEHIND_BUILDING_GARAGE,
                                      P3.UNDER_PORCH_DECK,
                                      P3.SHRUBS_CUT_WHEN_NEEDED,
                                      P3.RULER_PHOT0_TWO_INCHES,
                                      P3.LOCKBOX,
                                      P3.ADDRESS_PHOTO,
                                      P3.UP_DOWN_STREET,
                                      P3.COMMENTS;


        XML_STMT := XML_STMT||' <table border=0 cellpadding=0 cellspacing=0 width='||TBL_WIDTH||' style=''border-collapse: collapse;table-layout:fixed;width:'||TBL_STY_WIDTH||'''>'||utl_tcp.crlf;

        CNT := CNT + 1;

        DS.DYN_STMT(CNT) := XML_STMT;

---top bar

         ----- DATA_DT
         XML_STMT := ' <col class=xl642472 width=100 style=''mso-width-source:userset;mso-width-alt: 400;width:75pt''> '||utl_tcp.crlf;


         ----- ST,CONTRACTOR,CLIENT,LOAN_TYPE,ORDER_DT,COMPLETED_DT,ORDER_NUM
         FOR I IN 1..7 LOOP

             XML_STMT := XML_STMT|| '<col class=xl642472 width=100 style=''mso-width-source:userset;mso-width-alt: 400;width:75pt''>'||utl_tcp.crlf;

         END LOOP;


         ---- 17 QUESTIONS
        for i in 1..17 LOOP

          XML_STMT := XML_STMT|| '<col class=xl942472 width=150 style=''mso-width-source:userset;mso-width-alt: 600;width:150pt''>'||utl_tcp.crlf;

        END LOOP;

          ------ COMMENTS

          XML_STMT := XML_STMT|| '<col class=xl942472 width=600 style=''mso-width-source:userset;mso-width-alt: 2400;width:600t''>'||utl_tcp.crlf;


          CNT := CNT + 1;
          DS.DYN_STMT(CNT) := XML_STMT;


---- title Bar


    XML_STMT := '<tr style=''height:18.75pt''> '||utl_tcp.crlf;

    FOR A IN 1..7 LOOP
                XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none:width:100pt''>&nbsp;</td>'||utl_tcp.crlf;
    END LOOP;

      XML_STMT := XML_STMT||'<td colspan=2 class=xl802472  style=''border-left:none;width:325pt''>Complete Questions for Contractor</td>'||utl_tcp.crlf;

    FOR B IN 1..16 LOOP
       XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none;width:150pt''>&nbsp;</td>'||utl_tcp.crlf;
    END LOOP;

       XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none;width:600pt''>&nbsp;</td>'||utl_tcp.crlf;
       XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

      CNT := CNT + 1;
      DS.DYN_STMT(CNT) := XML_STMT;


--- blank space across screen

    XML_STMT := '<tr height=20 style=''height:15.0pt''>'||utl_tcp.crlf;

      for i in 1..26 loop
          XML_STMT := XML_STMT||'<td class=x1822472</td>'||utl_tcp.crlf;

      end loop;

      XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;


      CNT := CNT + 1;
      DS.DYN_STMT(CNT) := XML_STMT;


      XML_STMT := '<tr height=64 style=''mso-height-source:userset;height:48.0pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Date</td> '||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>State</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Contractor</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Client</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Loan Type</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Order Date</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Completed Date</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Order #</td>'||utl_tcp.crlf;




        OPEN QUES (p_page_no);
              LOOP
                 FETCH QUES INTO Q1;
                 EXIT WHEN QUES%NOTFOUND;
                 XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none;width:150pt''>'||Q1.HEADING||'</td>'||utl_tcp.crlf;
              END LOOP;
        CLOSE QUES;
                 XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none;width:600pt''>Comments</td>'||utl_tcp.crlf;
                 XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;


        CNT := CNT + 1;
        DS.DYN_STMT(CNT) := XML_STMT;



     for k in 1..P3.DATA_DT.count loop
            XML_STMT := '<tr style=''height:15.75pt''> '||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P3.DATA_DT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.ST(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.CONTRACTOR(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.CLIENT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.LOAN_TYPE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P3.ORDER_DT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P3.COMPLETED_DT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.ORDER_NUM(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.FRONT_OF_HOUSE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.FOUR_SIDES_OF_HOUSE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.BACK_OF_PROPERTY(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.GATE_ALLOWING_ENTRY(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.BA_FRONT_YARD(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.BA_BACK_YARD(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.WEED_WHACKING(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.EDGED_PAVED_AREAS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.FENCE_FOUNDATION_NO_WEEDS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.FLOWER_ROCKSCAPE_FREE_OF_WEEDS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.BEHIND_BUILDING_GARAGE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.UNDER_PORCH_DECK(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.SHRUBS_CUT_WHEN_NEEDED(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.RULER_PHOT0_TWO_INCHES(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.LOCKBOX(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.ADDRESS_PHOTO(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.UP_DOWN_STREET(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P3.COMMENTS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

            CNT := CNT + 1;
            DS.DYN_STMT(CNT) := XML_STMT;


     end loop;

        XML_STMT := '</table>'||utl_tcp.crlf||'</div>'||utl_tcp.crlf||'</body>'||utl_tcp.crlf||'</html>'||utl_tcp.crlf;

        CNT := CNT + 1;
        DS.DYN_STMT(CNT) := XML_STMT;


END IF;



IF  ( P_PAGE_NO IN (344)  )
    THEN
          TBL_SIZE      := 21;
          TBL_WIDTH     := 4158;
          TBL_STY_WIDTH := 2800;


          SQL_STMT := ' SELECT DATA_DT,ST,CONTRACTOR,CLIENT,LOAN_TYPE,ORDER_DT,COMPLETED_DT,ORDER_NUM,FRONT_OF_HOUSE,FOUR_SIDES_OF_HOUSE,BA_FRONT_YARD,BA_BACK_YARD,WEED_WHACKING,';
          SQL_STMT := SQL_STMT||' EDGED_PAVED_AREAS,FENCE_FOUNDATION_NO_WEEDS,FLOWER_ROCKSCAPE_FREE_OF_WEEDS,BEHIND_BUILDING_GARAGE,UNDER_PORCH_DECK,SHRUBS_CUT_WHEN_NEEDED,RULER_PHOT0_TWO_INCHES,COMMENTS ';
          SQL_STMT := SQL_STMT||' FROM SQA_TD_DATA WHERE REVIEW_ID = :A';

          OPEN GC FOR SQL_STMT USING P_REVIEWID;
          FETCH GC BULK COLLECT INTO P4.DATA_DT,
                                     P4.ST,
                                     P4.CONTRACTOR,
                                     P4.CLIENT,
                                     P4.LOAN_TYPE,
                                     P4.ORDER_DT,
                                     P4.COMPLETED_DT,
                                     P4.ORDER_NUM,
                                     P4.FRONT_OF_HOUSE,
                                     P4.FOUR_SIDES_OF_HOUSE,
                                     P4.BA_FRONT_YARD,
                                     P4.BA_BACK_YARD,
                                     P4.WEED_WHACKING,
                                     P4.EDGED_PAVED_AREAS,
                                     P4.FENCE_FOUNDATION_NO_WEEDS,
                                     P4.FLOWER_ROCKSCAPE_FREE_OF_WEEDS,
                                     P4.BEHIND_BUILDING_GARAGE,
                                     P4.UNDER_PORCH_DECK,
                                     P4.SHRUBS_CUT_WHEN_NEEDED,
                                     P4.RULER_PHOT0_TWO_INCHES,
                                     P4.COMMENTS;


        XML_STMT := XML_STMT||' <table border=0 cellpadding=0 cellspacing=0 width='||TBL_WIDTH||' style=''border-collapse: collapse;table-layout:fixed;width:'||TBL_STY_WIDTH||'''>'||utl_tcp.crlf;

        CNT := CNT + 1;

        DS.DYN_STMT(CNT) := XML_STMT;

---top bar

         ----- DATA_DT
         XML_STMT := ' <col class=xl642472 width=100 style=''mso-width-source:userset;mso-width-alt: 400;width:75pt''> '||utl_tcp.crlf;


         ----- ST,CONTRACTOR,CLIENT,LOAN_TYPE,ORDER_DT,COMPLETED_DT,ORDER_NUM
         FOR I IN 1..7 LOOP

             XML_STMT := XML_STMT|| '<col class=xl642472 width=100 style=''mso-width-source:userset;mso-width-alt: 400;width:75pt''>'||utl_tcp.crlf;

         END LOOP;


         ---- 12 QUESTIONS
        for i in 1..12 LOOP

          XML_STMT := XML_STMT|| '<col class=xl942472 width=150 style=''mso-width-source:userset;mso-width-alt: 600;width:150pt''>'||utl_tcp.crlf;

        END LOOP;

          ------ COMMENTS

          XML_STMT := XML_STMT|| '<col class=xl942472 width=600 style=''mso-width-source:userset;mso-width-alt: 2400;width:600t''>'||utl_tcp.crlf;


          CNT := CNT + 1;
          DS.DYN_STMT(CNT) := XML_STMT;


---- title Bar


    XML_STMT := '<tr style=''height:18.75pt''> '||utl_tcp.crlf;

    FOR A IN 1..7 LOOP
                XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none:width:100pt''>&nbsp;</td>'||utl_tcp.crlf;
    END LOOP;

      XML_STMT := XML_STMT||'<td colspan=2 class=xl802472  style=''border-left:none;width:325pt''>Complete Questions for Contractor</td>'||utl_tcp.crlf;

    FOR B IN 1..11 LOOP
       XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none;width:150pt''>&nbsp;</td>'||utl_tcp.crlf;
    END LOOP;

       XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none;width:600pt''>&nbsp;</td>'||utl_tcp.crlf;
       XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

      CNT := CNT + 1;
      DS.DYN_STMT(CNT) := XML_STMT;


--- blank space across screen

    XML_STMT := '<tr height=20 style=''height:15.0pt''>'||utl_tcp.crlf;

      for i in 1..21 loop
          XML_STMT := XML_STMT||'<td class=x1822472</td>'||utl_tcp.crlf;

      end loop;

      XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;


      CNT := CNT + 1;
      DS.DYN_STMT(CNT) := XML_STMT;


      XML_STMT := '<tr height=64 style=''mso-height-source:userset;height:48.0pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Date</td> '||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>State</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Contractor</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Client</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Loan Type</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Order Date</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Completed Date</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Order #</td>'||utl_tcp.crlf;




        OPEN QUES (P_PAGE_NO);
              LOOP
                 FETCH QUES INTO Q1;
                 EXIT WHEN QUES%NOTFOUND;
                 XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none;width:150pt''>'||Q1.HEADING||'</td>'||utl_tcp.crlf;
              END LOOP;
        CLOSE QUES;
                 XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none;width:600pt''>Comments</td>'||utl_tcp.crlf;
                 XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;


        CNT := CNT + 1;
        DS.DYN_STMT(CNT) := XML_STMT;



     for k in 1..P4.DATA_DT.count loop
            XML_STMT := '<tr style=''height:15.75pt''> '||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P4.DATA_DT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.ST(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.CONTRACTOR(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.CLIENT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.LOAN_TYPE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P4.ORDER_DT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P4.COMPLETED_DT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.ORDER_NUM(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.FRONT_OF_HOUSE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.FOUR_SIDES_OF_HOUSE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.BA_FRONT_YARD(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.BA_BACK_YARD(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.WEED_WHACKING(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.EDGED_PAVED_AREAS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.FENCE_FOUNDATION_NO_WEEDS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.FLOWER_ROCKSCAPE_FREE_OF_WEEDS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.BEHIND_BUILDING_GARAGE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.UNDER_PORCH_DECK(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.SHRUBS_CUT_WHEN_NEEDED(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.RULER_PHOT0_TWO_INCHES(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P4.COMMENTS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

            CNT := CNT + 1;
            DS.DYN_STMT(CNT) := XML_STMT;


     end loop;

        XML_STMT := '</table>'||utl_tcp.crlf||'</div>'||utl_tcp.crlf||'</body>'||utl_tcp.crlf||'</html>'||utl_tcp.crlf;

        CNT := CNT + 1;
        DS.DYN_STMT(CNT) := XML_STMT;


END IF;


IF  ( P_PAGE_NO IN (345)  )
    THEN
          TBL_SIZE      := 19;
          TBL_WIDTH     := 4150;
          TBL_STY_WIDTH := 2700;


          SQL_STMT := ' SELECT DATA_DT,ST,CONTRACTOR,CLIENT,LOAN_TYPE,ORDER_DT,COMPLETED_DT,ORDER_NUM, BA_FRONT_YARD,BA_BACK_YARD,FOUR_SIDES_OF_HOUSE,FENCE_FOUNDATION_NO_WEEDS,DRIVE_WALK_FREE_OF_WEEDS,';
          SQL_STMT := SQL_STMT||' FLOWER_ROCKSCAPE_FREE_OF_WEEDS,EDGED_PAVED_AREAS,CLIPPINGS_LEAVES_REMOVED,SHRUBS_CUT_WHEN_NEEDED,RULER_PHOT0_TWO_INCHES,COMMENTS ';
          SQL_STMT := SQL_STMT||' FROM SQA_TD_DATA WHERE REVIEW_ID = :A';

          OPEN GC FOR SQL_STMT USING P_REVIEWID;
          FETCH GC BULK COLLECT INTO  P5.DATA_DT,
                                      P5.ST,
                                      P5.CONTRACTOR,
                                      P5.CLIENT,
                                      P5.LOAN_TYPE,
                                      P5.ORDER_DT,
                                      P5.COMPLETED_DT,
                                      P5.ORDER_NUM,
                                      P5.BA_FRONT_YARD,
                                      P5.BA_BACK_YARD,
                                      P5.FOUR_SIDES_OF_HOUSE,
                                      P5.FENCE_FOUNDATION_NO_WEEDS,
                                      P5.DRIVE_WALK_FREE_OF_WEEDS,
                                      P5.FLOWER_ROCKSCAPE_FREE_OF_WEEDS,
                                      P5.EDGED_PAVED_AREAS,
                                      P5.CLIPPINGS_LEAVES_REMOVED,
                                      P5.SHRUBS_CUT_WHEN_NEEDED,
                                      P5.RULER_PHOT0_TWO_INCHES,
                                      P5.COMMENTS;

        XML_STMT := XML_STMT||' <table border=0 cellpadding=0 cellspacing=0 width='||TBL_WIDTH||' style=''border-collapse: collapse;table-layout:fixed;width:'||TBL_STY_WIDTH||'''>'||utl_tcp.crlf;

        CNT := CNT + 1;

        DS.DYN_STMT(CNT) := XML_STMT;

---top bar

         ----- DATA_DT
         XML_STMT := ' <col class=xl642472 width=100 style=''mso-width-source:userset;mso-width-alt: 400;width:75pt''> '||utl_tcp.crlf;


         ----- ST,CONTRACTOR,CLIENT,LOAN_TYPE,ORDER_DT,COMPLETED_DT,ORDER_NUM
         FOR I IN 1..7 LOOP

             XML_STMT := XML_STMT|| '<col class=xl642472 width=100 style=''mso-width-source:userset;mso-width-alt: 400;width:75pt''>'||utl_tcp.crlf;

         END LOOP;


         ---- 12 QUESTIONS
        for i in 1..10 LOOP

          XML_STMT := XML_STMT|| '<col class=xl942472 width=150 style=''mso-width-source:userset;mso-width-alt: 600;width:150pt''>'||utl_tcp.crlf;

        END LOOP;

          ------ COMMENTS

          XML_STMT := XML_STMT|| '<col class=xl942472 width=600 style=''mso-width-source:userset;mso-width-alt: 2400;width:600t''>'||utl_tcp.crlf;


          CNT := CNT + 1;
          DS.DYN_STMT(CNT) := XML_STMT;


---- title Bar


    XML_STMT := '<tr style=''height:18.75pt''> '||utl_tcp.crlf;

    FOR A IN 1..7 LOOP
                XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none:width:100pt''>&nbsp;</td>'||utl_tcp.crlf;
    END LOOP;

      XML_STMT := XML_STMT||'<td colspan=2 class=xl802472  style=''border-left:none;width:325pt''>Complete Questions for Contractor</td>'||utl_tcp.crlf;

    FOR B IN 1..10 LOOP
       XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none;width:150pt''>&nbsp;</td>'||utl_tcp.crlf;
    END LOOP;

       XML_STMT := XML_STMT||'<td class=xl782472  style=''border-left:none;width:600pt''>&nbsp;</td>'||utl_tcp.crlf;
       XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

      CNT := CNT + 1;
      DS.DYN_STMT(CNT) := XML_STMT;


--- blank space across screen

    XML_STMT := '<tr height=20 style=''height:15.0pt''>'||utl_tcp.crlf;

      for i in 1..19 loop
          XML_STMT := XML_STMT||'<td class=x1822472</td>'||utl_tcp.crlf;

      end loop;

      XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;


      CNT := CNT + 1;
      DS.DYN_STMT(CNT) := XML_STMT;


      XML_STMT := '<tr height=64 style=''mso-height-source:userset;height:48.0pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Date</td> '||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>State</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Contractor</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Client</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Loan Type</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Order Date</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Completed Date</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none:width:100pt''>Order #</td>'||utl_tcp.crlf;




        OPEN QUES (P_PAGE_NO);
              LOOP
                 FETCH QUES INTO Q1;
                 EXIT WHEN QUES%NOTFOUND;
                 XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none;width:150pt''>'||Q1.HEADING||'</td>'||utl_tcp.crlf;
              END LOOP;
        CLOSE QUES;
                 XML_STMT := XML_STMT||'<td class=xl822472 style=''border-left:none;width:600pt''>Comments</td>'||utl_tcp.crlf;
                 XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;


        CNT := CNT + 1;
        DS.DYN_STMT(CNT) := XML_STMT;


     for k in 1..P5.DATA_DT.count loop
            XML_STMT := '<tr style=''height:15.75pt''> '||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P5.DATA_DT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.ST(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.CONTRACTOR(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.CLIENT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.LOAN_TYPE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P5.ORDER_DT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl692472 style=''border-left:none:width:100pt''>'||P5.COMPLETED_DT(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.ORDER_NUM(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.BA_FRONT_YARD(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.BA_BACK_YARD(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.FOUR_SIDES_OF_HOUSE(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.FENCE_FOUNDATION_NO_WEEDS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.DRIVE_WALK_FREE_OF_WEEDS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.FLOWER_ROCKSCAPE_FREE_OF_WEEDS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.EDGED_PAVED_AREAS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.CLIPPINGS_LEAVES_REMOVED(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.SHRUBS_CUT_WHEN_NEEDED(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.RULER_PHOT0_TWO_INCHES(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'<td class=xl812472 style=''border-left:none:width:100pt''>'||P5.COMMENTS(k)||'</td>'||utl_tcp.crlf;
            XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

            CNT := CNT + 1;
            DS.DYN_STMT(CNT) := XML_STMT;


     end loop;

        XML_STMT := '</table>'||utl_tcp.crlf||'</div>'||utl_tcp.crlf||'</body>'||utl_tcp.crlf||'</html>'||utl_tcp.crlf;

        CNT := CNT + 1;
        DS.DYN_STMT(CNT) := XML_STMT;

END IF;



for x in 1..cnt loop

    clob_stmt := clob_stmt||ds.dyn_stmt(x);


end loop;

   dbms_lob.createtemporary(blob_stmt, FALSE);

    dest_offset := 1;
    src_offset := 1;

   lang_context := 0;

   -- convert to a BLOB here:
     dbms_lob.converttoblob( blob_stmt, clob_stmt,    dbms_lob.getlength( clob_stmt ), dest_offset, src_offset, 0, lang_context, warning );

--      DBMS_OUTPUT.PUT_LINE(warning);


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'GEN EMAILS',SYSDATE, 0, 'Details attachment - '||warning);
    COMMIT;

/*************************************************
 *   Summary
 ************************************************/



      ----- Read in heading
      OPEN SHD('xmlns-vendor-report');
           FETCH SHD INTO SHDR;
           XML_STMT := SHDR.XMLNS;
      CLOSE SHD;

      CNT := 1;

      SS.DYN_STMT(CNT) := XML_STMT;




      OPEN SCL('Summary');
          LOOP
             FETCH SCL INTO SCLR;
             EXIT WHEN SCL%NOTFOUND;

                   XML_STMT := SCLR.CLASS_DEF||utl_tcp.crlf;

                    CNT := CNT + 1;
                   SS.DYN_STMT(CNT) := XML_STMT;

--             XML_STMT := XML_STMT||utl_tcp.crlf||SCLR.CLASS_DEF;
          END LOOP;
      CLOSE SCL;



      XML_STMT := '-->'||utl_tcp.crlf||'</style>'||utl_tcp.crlf||'</head>'||utl_tcp.crlf||'<body>'||utl_tcp.crlf||'<div id="Vendor-report_1057" align=center x:publishsource="Excel">'||utl_tcp.crlf;

      CNT := CNT + 1;
      SS.DYN_STMT(CNT) := XML_STMT;



      XML_STMT := '<table border=0 cellpadding=0 cellspacing=0 width=571 style=''border-collapse:collapse;table-layout:fixed;width:500pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<col width=376 style=''mso-width-source:userset;mso-width-alt:13750;width:282pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<col width=132 style=''mso-width-source:userset;mso-width-alt:4827;width:99pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<col width=63 style=''mso-width-source:userset;mso-width-alt:2304;width:47pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<tr height=20 style=''height:15.0pt''> '||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td colspan=3 height=20 class=xl691057 width=571 style=''height:15.0pt; width:428pt''>Refresh Audit Breakdown by Task Quality and Photo Requirements</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;


      CNT := CNT + 1;
      SS.DYN_STMT(CNT) := XML_STMT;


      OPEN SSM (P_REVIEWID);
          LOOP
              FETCH SSM INTO SSMR;
              EXIT WHEN SSM%NOTFOUND;
      --        XML_STMT := XML_STMT||pick_class ( R3.QUESTION, R3.TOTAL_PER_TASK, R3.TASK_COMPLIENT);
                XML_STMT := pick_class ( SSMR.QUESTION, SSMR.TOTAL_PER_TASK, SSMR.TASK_COMPLIENT);

                CNT := CNT + 1;
                SS.DYN_STMT(CNT) := XML_STMT;

          END LOOP;
      CLOSE SSM;



      XML_STMT := '<tr height=20 style=''height:15.0pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td height=20 class=xl671057 style=''height:15.0pt''></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl671057></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl671057></td> '||utl_tcp.crlf;
      XML_STMT := XML_STMT||'</tr> '||utl_tcp.crlf;

      CNT := CNT + 1;
      SS.DYN_STMT(CNT) := XML_STMT;


      XML_STMT := ' <tr height=20 style=''height:15.0pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td height=20 class=xl671057 style=''height:15.0pt''></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td colspan=2 class=xl691057>Overall Audit Quality</td> '||utl_tcp.crlf;
      XML_STMT := XML_STMT||'</tr> '||utl_tcp.crlf;

      CNT := CNT + 1;
      SS.DYN_STMT(CNT) := XML_STMT;

      ---N_NBR_REVIEWED, N_POSSIBLE_PTS, N_POINTS_RECEIVED, N_REVIEW_SCORE
      XML_STMT := ' <tr height=20 style=''height:15.0pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td height=20 class=xl671057 style=''height:15.0pt''></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl641057 style=''border-top:none''>Total Orders Reviewed</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl681057 align=right style=''border-top:none;border-left:none''>'||N_NBR_REVIEWED||'</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

      CNT := CNT + 1;
      SS.DYN_STMT(CNT) := XML_STMT;

      XML_STMT := ' <tr height=20 style=''height:15.0pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td height=20 class=xl671057 style=''height:15.0pt''></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl641057 style=''border-top:none''>Possible Points</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl681057 align=right style=''border-top:none;border-left:none''>'||N_POSSIBLE_PTS||'</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

      CNT := CNT + 1;
      SS.DYN_STMT(CNT) := XML_STMT;


      XML_STMT := ' <tr height=20 style=''height:15.0pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td height=20 class=xl671057 style=''height:15.0pt''></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl641057 style=''border-top:none''>Total Points Received</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl681057 align=right style=''border-top:none;border-left:none''>'||N_POINTS_RECEIVED||'</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

      CNT := CNT + 1;
      SS.DYN_STMT(CNT) := XML_STMT;

      XML_STMT := ' <tr height=20 style=''height:15.0pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td height=20 class=xl671057 style=''height:15.0pt''></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl641057 style=''border-top:none''>Overall % Compliant</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl641057 align=right style=''border-top:none;border-left:none;font-size:9.5pt;color:#9C6500;font-weight:400;text-decoration:none;text-underline-style:none;text-line-through:none;font-family:Calibri;border:.5pt solid windowtext;background:#FFEB9C;mso-pattern:black none''>'||N_REVIEW_SCORE||'%</td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

      CNT := CNT + 1;
      SS.DYN_STMT(CNT) := XML_STMT;

      XML_STMT := ' <tr height=20 style=''height:15.0pt''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td height=20 class=xl671057 style=''height:15.0pt''></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl671057></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td class=xl671057></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;

      CNT := CNT + 1;
      SS.DYN_STMT(CNT) := XML_STMT;

      XML_STMT := ' <![if supportMisalignedColumns]>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<tr height=0 style=''display:none''>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td width=376 style=''width:282pt''></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td width=132 style=''width:99pt''></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<td width=63 style=''width:47pt''></td>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'</tr>'||utl_tcp.crlf;
      XML_STMT := XML_STMT||'<![endif]>'||utl_tcp.crlf;

      CNT := CNT + 1;
      SS.DYN_STMT(CNT) := XML_STMT;

      XML_STMT := '</table>'||utl_tcp.crlf||'</div>'||utl_tcp.crlf||'</body>'||utl_tcp.crlf||'</html>'||utl_tcp.crlf;

      CNT := CNT + 1;
      SS.DYN_STMT(CNT) := XML_STMT;


      for x in 1..cnt loop

          summary_clob := summary_clob||ss.dyn_stmt(x);

      end loop;

         dbms_lob.createtemporary(summary_blob, FALSE);

          dest_offset := 1;
          src_offset := 1;

          lang_context := 0;

         -- convert to a BLOB here:

           dbms_lob.converttoblob( summary_blob, summary_clob,    dbms_lob.getlength( summary_clob ), dest_offset, src_offset, 0, lang_context, warning );

                INSERT INTO BOA_PROCESS_LOG
                      (
                        PROCESS,
                        SUB_PROCESS,
                        ENTRYDTE,
                        ROWCOUNTS,
                        MESSAGE
                      )
          VALUES ( 'SQA_LOVS', 'GEN EMAILS',SYSDATE, 0, 'Summary attachment -'||warning);
          COMMIT;



/**********************************
       The letter

      P_FOLLOW_UP_CAT   := CASE WHEN  P_FOLLOW_UP_RES IN ('PASS') AND  P_FOLLOW_UP_CAT IN ('INITIAL-NEW-TDA-VENDOR','INITIAL-TDA-NOT-NEW-VENDOR','FOLLOW-UP-VENDOR-FAILED-INITIAL')   THEN  'INITIAL-TDA-NOT-NEW-VENDOR'
                                WHEN  P_FOLLOW_UP_RES IN ('FAIL') AND  P_FOLLOW_UP_CAT IN ('INITIAL-NEW-TDA-VENDOR','INITIAL-TDA-NOT-NEW-VENDOR') THEN 'FOLLOW-UP-VENDOR-FAILED-INITIAL'
                                WHEN  P_FOLLOW_UP_RES IN ('CALL') AND  P_FOLLOW_UP_CAT IN ('INITIAL-NEW-TDA-VENDOR') THEN 'CALL-INITIAL-NEW-TDA-VENDOR'
                                WHEN  P_FOLLOW_UP_RES IN ('FAIL') AND  P_FOLLOW_UP_CAT IN ('FOLLOW-UP-VENDOR-FAILED-INITIAL','CHARGEBACK-FOLLOW-UP-VENDOR-FAILED') THEN  'CHARGEBACK-FOLLOW-UP-VENDOR-FAILED'


***********************************/
--    LC_CLIENT := P_CLIENT;

           LC_CLIENT := SUBSTR(LC_AUDIT_TYPE,1,INSTR(LC_AUDIT_TYPE,'-') - 1);


                INSERT INTO BOA_PROCESS_LOG
                      (
                        PROCESS,
                        SUB_PROCESS,
                        ENTRYDTE,
                        ROWCOUNTS,
                        MESSAGE
                      )
          VALUES ( 'SQA_LOVS', 'GEN EMAILS',SYSDATE, 0, P_CLIENT||' to '||LC_CLIENT);
          COMMIT;


IF (LC_FOLLOW_UP_CAT IN ('FOLLOW-UP-VENDOR-FAILED-INITIAL','2ND-ROUND-INITIAL-AUDIT-FAILED') ) THEN

          SELECT LETTER_BODY
          INTO   LETTERS
          FROM SQA_TD_EMAIL_LETTERS
          WHERE LETTER_TYPE IN ('NONCOMPLAINT')
          AND   REPORT_SEGMENT = WORK_GROUP;

         LETTERS := REPLACE(REPLACE(REPLACE(replace(LETTERS,'1VENDOR_NAME',LC_VENDOR),'2ORDERS',WORK_GROUP),'3SCORE',LC_SCORE),'4FOLLOWUP',LC_FOLLOW_UP_DTE) ;
END IF;

IF (LC_FOLLOW_UP_CAT  IN ('CALL-INITIAL-NEW-TDA-VENDOR') )  THEN

SELECT CASE WHEN PARTOFDAY IN ('AM') THEN 'Morning'
            ELSE 'Afternoon' end, MONYEAR
into LC_GREETINGS, LC_MONYYYY
from(
select TO_CHAR(SYSDATE,'AM') PARTOFDAY,TO_CHAR(SYSDATE,'MONYYYY') MONYEAR FROM DUAL);



          SELECT LETTER_BODY
          INTO LETTERS
          FROM SQA_TD_EMAIL_LETTERS
          WHERE LETTER_TYPE IN ('CONFERENCECALL');


         LETTERS := REPLACE(LETTERS,'1AMPM',LC_GREETINGS);
         LETTERS := REPLACE(LETTERS,'2ORDERS',WORK_GROUP);
         LETTERS := REPLACE(LETTERS,'3VENDOR',LC_VENDOR);
         LETTERS := REPLACE(LETTERS,'4MONYYYY',LC_MONYYYY);
         LETTERS := REPLACE(LETTERS,'5SCORE',LC_SCORE);
         LETTERS := REPLACE(LETTERS,'6FOLLOWUPDTE',LC_FOLLOW_UP_DTE);
END IF;



--  TDA Audit Details_ABC123_09.09.16
--- TDA Audit Summary_ABC123_09.09.16

--- EMAIL_ATTACHMENT, FILENAME, MIMETYPE, LAST_UPDATE, EMAIL_ATTACHMENT_DETAILS, DETAILS_FILENAME, DETAILS_MIMETYPE, DETAILS_LAST_UPDATE
IF (LC_FOLLOW_UP_RES NOT IN ('PASS') ) THEN

          INSERT INTO SQA_TD_EMAIL_FORM ( review_id,
                                          VENDOR_ID,
                                          VENDOR,
                                          CLIENT,
                                          REPORT_SEGMENT,
                                          REVIEW_DATE,
                                          FOLLOW_UP_DATE,
                                          REVIEW_SCORE,
                                          EMAIL_TO,
                                          EMAIL_CC,
                                          EMAIL_FROM,
                                          EMAIL_SUBJECT,
                                          EMAIL_HTML)
                                 VALUES (P_REVIEWID,
                                         P_VENDORID,
                                         LC_VENDOR,
                                         LC_CLIENT,
                                         LC_AUDIT_TYPE,
                                         LC_LAST_REVIEW,
                                         LC_FOLLOW_UP_DTE,
                                         LC_SCORE,
                                         LC_EMAIL,
                                         cc_list,
                                         'sqa@safeguardproperties.com',
                                         'IMPORTANT NOTICE OF DEFICIENCY - '||LC_VENDOR,
                                         LETTERS) RETURNING FORM_ID INTO P_FORM_ID;


    update SQA_TD_EMAIL_FORM
    set  DETAILS_FILENAME = 'TDA Audit Details_'||LC_VENDOR||'_'||TO_CHAR(SYSDATE,'MM-DD-YY')||'.html',
         DETAILS_LAST_UPDATE = sysdate,
         EMAIL_ATTACHMENT_DETAILS = blob_stmt,
         DETAILS_MIMETYPE = 'text/html',
         EMAIL_ATTACHMENT = summary_blob,
         FILENAME = 'TDA Audit Summary_'||LC_VENDOR||'_'||TO_CHAR(SYSDATE,'MM-DD-YY')||'.html',
         MIMETYPE = 'text/html',
         LAST_UPDATE = SYSDATE
    where FORM_ID = P_FORM_ID;

    commit;


   INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'GEN EMAILS',SYSDATE, 0, 'ADD TO EMAIL FORM');
    COMMIT;


--   EMAIL_ID, VENDOR_ID, REVIEW_ID, VENDOR, CLIENT, ENTRY_DATE, SENT_DATE, EMAIL_TO, EMAIL_CC, EMAIL_FROM, EMAIL_SUBJECT, EMAIL_BODY, EMAIL_HTML, EMAIL_ATTACHMENT, FILENAME, MIMETYPE, LAST_UPDATE, EMAIL_ERRORS
ELSE

---   (LC_FOLLOW_UP_RES IN ('PASS') )

          SELECT LETTER_BODY
          INTO LETTERS
          FROM SQA_TD_EMAIL_LETTERS
          WHERE LETTER_TYPE IN ('COMPLAINT')
           AND  REPORT_SEGMENT = WORK_GROUP
           AND  CLIENT  IN ( LC_CLIENT);

          INSERT INTO SQA_TD_EMAIL_OUTBOX   (VENDOR_ID,
                                             REVIEW_ID,
                                             VENDOR,
                                             CLIENT,
                                             AUDIT_TYPE,
                                             ENTRY_DATE,
                                             EMAIL_TO,
                                             EMAIL_CC,
                                             EMAIL_FROM,
                                             EMAIL_SUBJECT,
                                             EMAIL_HTML)
                                    VALUES ( P_VENDORID,
                                             P_REVIEWID,
                                             LC_VENDOR,
                                             LC_AUDIT_TYPE,
                                             LC_AUDIT_TYPE,
                                             SYSDATE,
                                             LC_EMAIL,
                                             cc_list,
                                             'sqa@safeguardproperties.com',
                                             'NOTICE OF COMPLIANCE - '||LC_VENDOR,
                                             LETTERS) RETURNING EMAIL_ID INTO P_FORM_ID;


         COMMIT;

        update SQA_TD_EMAIL_OUTBOX
        set  DETAILS_FILENAME = 'TDA Audit Details_'||LC_VENDOR||'_'||TO_CHAR(SYSDATE,'MM-DD-YY')||'.html',
             DETAILS_LAST_UPDATE = sysdate,
             EMAIL_ATTACHMENT_DETAILS = blob_stmt,
             DETAILS_MIMETYPE = 'text/html',
             EMAIL_ATTACHMENT = summary_blob,
             FILENAME = 'TDA Audit Summary_'||LC_VENDOR||'_'||TO_CHAR(SYSDATE,'MM-DD-YY')||'.html',
             MIMETYPE = 'text/html',
             LAST_UPDATE = SYSDATE
        where EMAIL_ID = P_FORM_ID;

        commit;


   INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'GEN EMAILS',SYSDATE, 0, 'ADD TO EMAIL OutBox');
    COMMIT;



END IF;


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'GEN EMAILS',SYSDATE, 0, 'SENT');
    COMMIT;


exception
     when others then
     MSG := SQLERRM;
     RCODE := SQLCODE;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'GEN EMAILS',SYSDATE, RCODE, MSG);
    COMMIT;

END;

/*
     SQA_LOVS.CLOSE_REP_WORK_QUEUE('CHRISTIAN.GARDNER','MANUAL');
 */

procedure CLOSE_REP_WORK_QUEUE(P_APP_USER VARCHAR2, P_VENDOR_ID NUMBER)
IS
RCODE           NUMBER;
MSG             VARCHAR2(300 BYTE);
LC_VENDOR_CODE  VARCHAR2(20 BYTE);

BEGIN

/*
 BEGIN
MERGE INTO SQA_TD_DATA Z
USING (
         SELECT LOANNUMBER, SPIPROPERTYID, ORDER_NUM, SYSDATE AS LAST_UPDATE_DT, 'Y' AS COMPLETED, 'Y' AS SAVED, CASE WHEN TOP_DOWN_DT IS NULL THEN SYSDATE WHEN TOP_DOWN_DT = '' THEN SYSDATE ELSE TOP_DOWN_DT END AS TOP_DOWN_DT
         FROM SQA_TD_DATA
         WHERE SPIPROPERTYID = :P220_SPIPROPERTYID
      ) X ON (Z.LOANNUMBER = X.LOANNUMBER AND Z.ORDER_NUM = X.ORDER_NUM AND Z.SPIPROPERTYID = X.SPIPROPERTYID)
WHEN MATCHED THEN
     UPDATE
     SET     Z.COMPLETED = X.COMPLETED, Z.SAVED = X.SAVED, Z.LAST_UPDATE_DT = X.LAST_UPDATE_DT, Z.TOP_DOWN_DT = X.TOP_DOWN_DT;
COMMIT;
END;
 */

SELECT VENDOR_CODE
INTO   LC_VENDOR_CODE
FROM SQA_VENDOR_LIST
WHERE VENDOR_ID = P_VENDOR_ID;



                        UPDATE SQA_VENDOR_LIST A
                        SET a.FOLLOW_UP_SAT = 'Fail/Fraud',
                            a.FOLLOW_UP_RES = 'FAIL',
                            a.FOLLOW_UP     = 'Follow-up',
                            A.FOLLOW_UP_DTE = NULL,
                            a.ASSIGN_IT     = -1,
                            a.ASSIGNED_TO   = 0,
                            a.COMPLETED_BY  = 0,
                            a.BATCH_NO      = 0,
                            a.THIRTY_FIFTY_DAY_RULE = 0,
                            a.NBR_WORKORDERS  = 0,
                            a.NBR_COMPLETED   = 0,
                            a.START_COUNTER_DATE  = NULL
                            WHERE VENDOR_CODE = LC_VENDOR_CODE;

RCODE := SQL%ROWCOUNT;


COMMIT;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'CLOSE_REP_WORK_QUEUE',SYSDATE, RCODE, 'Closed SQA_VENDOR_LIST');
    COMMIT;


 UPDATE SQA_TD_DATA Z SET  Z.LAST_UPDATE_DT = SYSDATE, Z.COMPLETED = 'Y', Z.SAVED = 'Y',  Z.TOP_DOWN_DT = NVL(Z.TOP_DOWN_DT,SYSDATE)
    WHERE EXISTS ( SELECT 1
                   FROM ( SELECT S.PID
                           FROM (
                           SELECT A.PID
                           FROM SQA_TD_DATA A
                           LEFT JOIN (SELECT VENDOR_CODE, LAST_REVIEW, VENDOR_ID, SEGMENTS, FOLLOW_UP_DTE  FROM SQA_VENDOR_LIST  WHERE VENDOR_ID = P_VENDOR_ID ) B ON ( B.VENDOR_CODE = A.CONTRACTOR AND B.SEGMENTS = A.REPORT_SEGMENT)
                           WHERE   A.SQA_TD_REP     =  P_APP_USER
                           and     A.CONTRACTOR     =  B.VENDOR_CODE
                           AND     A.REPORT_SEGMENT =  B.SEGMENTS) S
                  WHERE S.PID = Z.PID));
RCODE := SQL%ROWCOUNT;

COMMIT;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'CLOSE_REP_WORK_QUEUE',SYSDATE, RCODE, 'Closed SQA_TD_DATA');
    COMMIT;


UPDATE SQA_VENDOR_HISTORY SET REVIEWED_BY = P_APP_USER,  REVIEW_DTE = TRUNC(SYSDATE) , POSSIBLE_PTS = 0, POINTS_RECEIVED = 0, REVIEW_SCORE = 0, CALC_CMPT = 1
WHERE VENDOR_ID =  P_VENDOR_ID
AND   CALC_CMPT = 0;


RCODE := SQL%ROWCOUNT;

COMMIT;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'CLOSE_REP_WORK_QUEUE',SYSDATE, RCODE, 'Closed SQA_VENDOR_HISTORY');
    COMMIT;


EXCEPTION
      WHEN OTHERS THEN
          RCODE := SQLCODE;
          MSG   := SQLERRM;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'CLOSE_REP_WORK_QUEUE',SYSDATE, RCODE, MSG);
    COMMIT;

END;
/*

 */



procedure UPDATE_REP_WORK_QUEUE(P404_CAP_HOLD      NUMBER,
                                P404_FOLLOW_UP     VARCHAR2,
                                P404_FOLLOW_UP_SAT VARCHAR2,
                                P404_REVIEWED_BY   VARCHAR2,
                                P404_STANDING      NUMBER,
                                P404_VENDOR_CODE   VARCHAR2,
                                P404_VENDOR_ID     NUMBER)
IS
RCODE     NUMBER;
MSG       VARCHAR2(300 BYTE);

V_FOLLOW_UP_DTE  DATE;
V_LAST_REVIEW    DATE;
V_FOLLOW_UP_SAT  VARCHAR2(100 BYTE);
V_REPORT_SEGMENT VARCHAR2(100 BYTE);
V_CAP_HOLD       NUMBER;

WE_DONE          EXCEPTION;

BEGIN

IF ( P404_FOLLOW_UP IN ('Follow-up') ) then
     V_FOLLOW_UP_DTE :=  GV_CURRENT_DATE + 30;
else
     V_FOLLOW_UP_DTE := NULL;
END IF;



SELECT UPPER(FOLLOW_UP_SAT), SEGMENTS,   CAP_HOLD
INTO   V_FOLLOW_UP_SAT, V_REPORT_SEGMENT, V_CAP_HOLD
FROM   SQA_VENDOR_LIST
WHERE  VENDOR_ID = P404_VENDOR_ID;

IF ( P404_REVIEWED_BY IN ('Clear') )  THEN

                         UPDATE SQA_TD_DATA Z
                            SET   Z.COMPLETED         = NULL,
                                  Z.WORKING           = NULL,
                                  Z.SAVED             = NULL,
                                  Z.LAST_UPDATE_DT    = NULL,
                                  Z.TOP_DOWN_DT       = NULL,
                                  Z.FRAUD_INDC        = NULL,
                                  Z.SQA_TD_REP        = NULL,
                                  Z.VOLT_STICK        = NULL,
                                  Z.FRONT_OF_HOUSE    = NULL,
                                  Z.RIGHT_LEFT_SIDE_OF_HOUSE  = NULL,
                                  Z.UP_DOWN_STREET    = NULL,
                                  Z.ADDRESS_PHOTO     = NULL,
                                  Z.LOCKBOX           = NULL,
                                  Z.BACK_OF_PROPERTY  = NULL,
                                  Z.GATE_ALLOWING_ENTRY       = NULL,
                                  Z.BEHIND_BUILDING_GARAGE    = NULL,
                                  Z.SWEEPING          = NULL,
                                  Z.VACUUMING         = NULL,
                                  Z.MOPPING           = NULL,
                                  Z.WIPING_SURFACES   = NULL,
                                  Z.INSIDE_ALL_TOILETS  = NULL,
                                  Z.INSIDE_OUT_APPLIANCES  = NULL,
                                  Z.SAFETY_HAZARD_AREA  = NULL,
                                  Z.INSIDE_ALL_CLOSETS  = NULL,
                                  Z.ENTIRE_BASEMENT  = NULL,
                                  Z.CIRCUIT_BREAKER  = NULL,
                                  Z.CHECKLIST         = NULL,
                                  Z.AIR_FRESHENERS_DATED  = NULL,
                                  Z.SHOW_ALL_AIR_FRESHENERS  = NULL,
                                  Z.FOUR_SIDES_OF_HOUSE  = NULL,
                                  Z.BA_FRONT_YARD     = NULL,
                                  Z.BA_BACK_YARD      = NULL,
                                  Z.WEED_WHACKING     = NULL,
                                  Z.EDGED_PAVED_AREAS = NULL,
                                  Z.FENCE_FOUNDATION_NO_WEEDS  = NULL,
                                  Z.UNDER_PORCH_DECK  = NULL,
                                  Z.SHRUBS_CUT_WHEN_NEEDED  = NULL,
                                  Z.RULER_PHOT0_TWO_INCHES  = NULL,
                                  Z.DRIVE_WALK_FREE_OF_WEEDS  = NULL,
                                  Z.FLOWER_ROCKSCAPE_FREE_OF_WEEDS  = NULL,
                                  Z.CLIPPINGS_LEAVES_REMOVED  = NULL,
                                  Z.NEED_WORKED  = NULL,
                                  Z.COMMENTS  = NULL,
                                  Z.NBR_QUESTIONS_YES = 0,
                                  Z.FRAUD_INDC  = NULL,
                                  Z.QP_INDC  = NULL,
                                  Z.BATCH_NO = 0
                         WHERE EXISTS ( SELECT 1
                                        FROM SQA_TD_DATA X
                                        WHERE X.CONTRACTOR = P404_VENDOR_CODE
                                        AND   X.REPORT_SEGMENT = V_REPORT_SEGMENT
                                        AND   X.WORKING    = 'Y'
                                        AND   X.PID        = Z.PID);

                                       RCODE := SQL%ROWCOUNT;
                                       COMMIT;

                        update SQA_VENDOR_HISTORY set possible_pts = 0, POINTS_RECEIVED = 0, CALC_CMPT = 0 WHERE VENDOR_ID = P404_VENDOR_ID;

                        COMMIT;


                        UPDATE SQA_VENDOR_LIST
                            SET CAP_HOLD       = P404_CAP_HOLD,
                                FOLLOW_UP      = P404_FOLLOW_UP,
                                FOLLOW_UP_SAT  = P404_FOLLOW_UP_SAT,
                                REVIEWED_BY    = NULL,
                                ASSIGNED_TO    = 0,
                                COMPLETED_BY   = 0,
                                ASSIGN_IT      = 0,
                                BATCH_NO       = 0,
                                STANDING       = P404_STANDING,
                          START_COUNTER_DATE   = GV_CURRENT_DATE
--TESTING                 START_COUNTER_DATE   = TRUNC(SYSDATE)
                          WHERE VENDOR_ID      = P404_VENDOR_ID;

                          COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'Clear SQA_TD_DATA');
                       COMMIT;



RAISE WE_DONE;

END IF;

IF ( P404_CAP_HOLD IN (1) ) THEN
                        UPDATE SQA_VENDOR_LIST
                            SET CAP_HOLD       = 1,
                                FOLLOW_UP      = P404_FOLLOW_UP,
                                FOLLOW_UP_SAT  = NULL,
                                FOLLOW_UP_DTE  = NULL,
                                FOLLOW_UP_RES  = 'CAP',
                                ASSIGNED_TO    = 0,
                                COMPLETED_BY   = 0,
                                ASSIGN_IT      = -1,
                                BATCH_NO       = 0,
                                STANDING       = P404_STANDING,
                                REVIEWED_BY     = NULL,
                          START_COUNTER_DATE   = GV_CURRENT_DATE
--TESTING                 START_COUNTER_DATE   = TRUNC(SYSDATE)
                          WHERE VENDOR_ID      = P404_VENDOR_ID;
                        RCODE := SQL%ROWCOUNT;
                        COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'Set CAP HOLD');
                       COMMIT;



             UPDATE SQA_TD_DATA
                    SET   SQA_TD_REP     = NULL, WORKING = NULL
                    WHERE CONTRACTOR     = P404_VENDOR_CODE
                      AND REPORT_SEGMENT = V_REPORT_SEGMENT;


                        RCODE := SQL%ROWCOUNT;
                        COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'update SQA_TD_DATA');
                       COMMIT;


END IF;

/*****************************************************************************************
  WE ASSUME THE USER IS REMOVING THE CAP_HOLD FLAG
 *****************************************************************************************/

IF ( V_CAP_HOLD  IN (1)  AND P404_CAP_HOLD IN (0) ) THEN
                        UPDATE SQA_VENDOR_LIST
                            SET CAP_HOLD       = 0,
                                FOLLOW_UP      = P404_FOLLOW_UP,
                                FOLLOW_UP_SAT  = P404_FOLLOW_UP_SAT,
                                FOLLOW_UP_DTE  = V_FOLLOW_UP_DTE,
                                FOLLOW_UP_RES  = NULL,
                                ASSIGNED_TO    = 0,
                                COMPLETED_BY   = 0,
                                ASSIGN_IT      = 0,
                                BATCH_NO       = 0,
                                STANDING       = P404_STANDING,
                                REVIEWED_BY     = NULL,
                          START_COUNTER_DATE   = GV_CURRENT_DATE
--TESTING                 START_COUNTER_DATE   = TRUNC(SYSDATE)
                          WHERE VENDOR_ID      = P404_VENDOR_ID;
                        RCODE := SQL%ROWCOUNT;
                        COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'Clear CAP HOLD');
                       COMMIT;



             UPDATE SQA_TD_DATA
                    SET   SQA_TD_REP     = NULL, WORKING = NULL
                    WHERE CONTRACTOR     = P404_VENDOR_CODE
                      AND REPORT_SEGMENT = V_REPORT_SEGMENT;


                        RCODE := SQL%ROWCOUNT;
                        COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'update SQA_TD_DATA');
                       COMMIT;


END IF;



/*****************************************************************************************
  WE ASSUME THE USER IS CHANGING A REVIEW THAT IS STILL OPEN AND WANT TO CLOSE IT FRAUD
 *****************************************************************************************/

IF ( V_FOLLOW_UP_SAT  NOT IN ('FAIL/FRAUD') AND UPPER(P404_FOLLOW_UP_SAT) IN ('FAIL/FRAUD') )  THEN


                        UPDATE SQA_VENDOR_LIST A
                        SET a.FOLLOW_UP_SAT = P404_FOLLOW_UP_SAT,
                            a.FOLLOW_UP_RES = 'FAIL',
                            a.FOLLOW_UP     = P404_FOLLOW_UP,
                            A.FOLLOW_UP_DTE = NULL,
                            a.ASSIGN_IT     = -1,
                            a.ASSIGNED_TO   = 0,
                            a.active        = 1,
                            a.COMPLETED_BY  = 0,
                            a.BATCH_NO      = 0,
                            a.THIRTY_FIFTY_DAY_RULE = 0,
                            a.NBR_WORKORDERS  = 0,
                            a.NBR_COMPLETED   = 0,
                            a.REVIEWED_BY     = NULL,
                            a.START_COUNTER_DATE  = NULL
                            WHERE VENDOR_CODE = P404_VENDOR_CODE;



                        RCODE := SQL%ROWCOUNT;
                        COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'close it Fail/Fraud');
                       COMMIT;




                         UPDATE SQA_TD_DATA Z
                         SET  Z.COMPLETED = 'Y',
                              Z.SAVED = 'Y',
                              Z.LAST_UPDATE_DT = SYSDATE,
                              Z.TOP_DOWN_DT    = NVL(Z.TOP_DOWN_DT,SYSDATE),
                              Z.FRAUD_INDC     = 'Yes',
                              Z.QP_INDC        = null,
                              Z.SQA_TD_REP     = P404_REVIEWED_BY
                         WHERE EXISTS ( SELECT 1
                                        FROM SQA_TD_DATA X
                                        WHERE X.CONTRACTOR = P404_VENDOR_CODE
                                        AND   X.COMPLETED  IS NULL
                                        AND   X.SAVED      IS NULL
                                        AND   X.PID        = Z.PID);

                        RCODE := SQL%ROWCOUNT;
                        COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'close it Fraud/Fail');
                       COMMIT;

  END IF;
/*****************************************************************************************
  WE ASSUME THE USER IS CHANGING A REVIEW THAT IS STILL OPEN AND WANT TO CLOSE IT QP
 *****************************************************************************************/

IF ( V_FOLLOW_UP_SAT  NOT IN ('FAIL/QP') AND UPPER(P404_FOLLOW_UP_SAT) IN ('FAIL/QP') )  THEN

                        UPDATE SQA_VENDOR_LIST A
                        SET a.FOLLOW_UP_SAT = P404_FOLLOW_UP_SAT,
                            a.FOLLOW_UP_RES = 'FAIL',
                            a.FOLLOW_UP     = P404_FOLLOW_UP,
                            A.FOLLOW_UP_DTE = NULL,
                            a.ASSIGN_IT     = -1,
                            a.ASSIGNED_TO   = 0,
                            a.COMPLETED_BY  = 0,
                            a.BATCH_NO      = 0,
                            a.THIRTY_FIFTY_DAY_RULE = 0,
                            a.NBR_WORKORDERS  = 0,
                            a.NBR_COMPLETED   = 0,
                            a.START_COUNTER_DATE   = NULL,
                            a.REVIEWED_BY     = NULL,
                            a.active          = 0
                            WHERE a.VENDOR_CODE = P404_VENDOR_CODE;

                        RCODE := SQL%ROWCOUNT;
                        COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'close it Fail/QP');
                       COMMIT;




                         UPDATE SQA_TD_DATA Z
                         SET  Z.COMPLETED = 'Y',
                              Z.SAVED = 'Y',
                              Z.LAST_UPDATE_DT = SYSDATE,
                              Z.TOP_DOWN_DT    = NVL(Z.TOP_DOWN_DT,SYSDATE),
                              Z.QP_INDC     = 'Yes',
                              Z.FRAUD_INDC     = NULL,
                              Z.SQA_TD_REP     = P404_REVIEWED_BY
                         WHERE EXISTS ( SELECT 1
                                        FROM SQA_TD_DATA X
                                        WHERE X.CONTRACTOR = P404_VENDOR_CODE
                                        AND   X.COMPLETED  IS NULL
                                        AND   X.SAVED      IS NULL
                                        AND   X.PID        = Z.PID);

                        RCODE := SQL%ROWCOUNT;
                        COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'close it QP/Fail');
                       COMMIT;

  END IF;


/*****************************************************************************************
  WE ASSUME THE USER IS CHANGING A REVIEW THAT IS CLOSED FRAUD AND WANT TO open it again
 *****************************************************************************************/

IF ( V_FOLLOW_UP_SAT  IN ('FAIL/FRAUD') AND UPPER(P404_FOLLOW_UP_SAT) NOT IN ('FAIL/QP')   )  THEN

                          UPDATE SQA_VENDOR_LIST
                            SET FOLLOW_UP_SAT     = P404_FOLLOW_UP_SAT,
                                FOLLOW_UP         = P404_FOLLOW_UP,
                                FOLLOW_UP_CAT     = 'INITIAL-TDA-NOT-NEW-VENDOR',
                                FOLLOW_UP_DTE     = V_FOLLOW_UP_DTE,
                                FOLLOW_UP_RES     = NULL,
                                ASSIGNED_TO       = 0,
                                THIRTY_FIFTY_DAY_RULE = 0,
                                REVIEWED_BY     = NULL,
                                cap_hold        = 0,
                                NBR_WORKORDERS  = 0,
                                NBR_COMPLETED   = 0,
                                completed_by    = 0,
                                assign_IT       = 0,
                                START_COUNTER_DATE   = GV_CURRENT_DATE
--TESTING                       START_COUNTER_DATE   = TRUNC(SYSDATE)
                          WHERE VENDOR_CODE = P404_VENDOR_CODE;




                          RCODE := SQL%ROWCOUNT;
                          COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'Open a Fail/Fraud');
                       COMMIT;


                         UPDATE SQA_TD_DATA Z
                         SET  Z.COMPLETED = NULL,
                              Z.SAVED = NULL,
                              Z.LAST_UPDATE_DT = NULL,
                              Z.TOP_DOWN_DT    = NULL,
                              Z.FRAUD_INDC     = NULL,
                              Z.SQA_TD_REP     = NULL
                         WHERE EXISTS ( SELECT 1
                                        FROM SQA_TD_DATA X
                                        WHERE X.CONTRACTOR = P404_VENDOR_CODE
                                        AND   X.COMPLETED  = 'Y'
                                        AND   X.SAVED      = 'Y'
                                        AND   X.FRAUD_INDC IN ('Yes','Fraud')
                                        AND   X.PID        = Z.PID);

                        RCODE := SQL%ROWCOUNT;
                        COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'Open a Fraud/Fail');
                       COMMIT;




END IF;

/*****************************************************************************************
  WE ASSUME THE USER IS CHANGING A REVIEW THAT IS CLOSED QP AND WANT TO open it again
 *****************************************************************************************/

IF ( V_FOLLOW_UP_SAT  IN ('FAIL/QP') AND UPPER(P404_FOLLOW_UP_SAT) NOT IN ('FAIL/FRAUD')  )  THEN

                          UPDATE SQA_VENDOR_LIST
                            SET FOLLOW_UP_SAT = P404_FOLLOW_UP_SAT,
                                FOLLOW_UP     = P404_FOLLOW_UP,
                                FOLLOW_UP_DTE = V_FOLLOW_UP_DTE,
                                FOLLOW_UP_CAT = 'INITIAL-TDA-NOT-NEW-VENDOR',
                                FOLLOW_UP_RES = NULL,
                                Next_Review   = null,
                                ASSIGNED_TO   = 0,
                                THIRTY_FIFTY_DAY_RULE = 0,
                                REVIEWED_BY   = null,
                                cap_hold      = 0,
                                NBR_WORKORDERS = 0,
                                NBR_COMPLETED = 0,
                                completed_by  = 0,
                                active        = 1,
                                assign_it     = 0,
                                START_COUNTER_DATE   = GV_CURRENT_DATE
--TESTING                        START_COUNTER_DATE   = TRUNC(SYSDATE)
                          WHERE VENDOR_CODE = P404_VENDOR_CODE;

                          RCODE := SQL%ROWCOUNT;
                          COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'Open a Fail/QP');
                       COMMIT;


                         UPDATE SQA_TD_DATA Z
                         SET  Z.COMPLETED = NULL,
                              Z.SAVED = NULL,
                              Z.LAST_UPDATE_DT = NULL,
                              Z.TOP_DOWN_DT    = NULL,
                              Z.QP_INDC        = NULL,
                              Z.SQA_TD_REP     = NULL
                         WHERE EXISTS ( SELECT 1
                                        FROM SQA_TD_DATA X
                                        WHERE X.CONTRACTOR = P404_VENDOR_CODE
                                        AND   X.COMPLETED  = 'Y'
                                        AND   X.SAVED      = 'Y'
                                        AND   X.QP_INDC IN ('Yes')
                                        AND   X.PID        = Z.PID);

                        RCODE := SQL%ROWCOUNT;
                        COMMIT;

                        INSERT INTO BOA_PROCESS_LOG
                              (
                                PROCESS,
                                SUB_PROCESS,
                                ENTRYDTE,
                                ROWCOUNTS,
                                MESSAGE
                              )
                       VALUES ( 'SQA_LOVS', 'Update_REP_WORK_QUEUE',SYSDATE, RCODE, 'Open a Fail/QP');
                       COMMIT;




END IF;



EXCEPTION
      WHEN WE_DONE THEN
        NULL;
      WHEN OTHERS THEN
          RCODE := SQLCODE;
          MSG   := SQLERRM;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'UPDATE_REP_WORK_QUEUE',SYSDATE, RCODE, MSG);
    COMMIT;

END;

PROCEDURE ASSIGN_REVIEWS
IS
      CURSOR C1
      IS
      SELECT A.PID, CASE WHEN C.WORKING IS NULL THEN 0 ELSE C.WORKING END AS NUMBER_ASSIGNED
      FROM SQA_TD_QUEUE_PROCESSORS A
      LEFT JOIN ( SELECT B.ASSIGNED_TO, B.WORKING
                   FROM ( SELECT ASSIGNED_TO, COUNT(*) AS WORKING
                            FROM SQA_VENDOR_LIST
                            WHERE ASSIGNED_TO > 0
                            AND   COMPLETED_BY = 0
                           GROUP BY ASSIGNED_TO) B) C  ON ( C.ASSIGNED_TO = A.PID)
     ORDER BY CASE WHEN C.WORKING IS NULL THEN 0 ELSE C.WORKING END;

     R1  C1%ROWTYPE;



GC       GenRefCursor;
SQL_STMT  VARCHAR2(32000 BYTE);
UPD_STMT  VARCHAR2(32000 BYTE);
NO_ASSIGN NUMBER;
RCODE     NUMBER;
MSG       VARCHAR2(1000 BYTE);

VL       VENDORCODE_LIST;

BEGIN

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'ASSIGN_REVIEWS',SYSDATE, 0, 'starting..');
    COMMIT;


      UPD_STMT := 'UPDATE SQA_VENDOR_LIST SET assigned_to = :A, assign_it = :B WHERE ROWID = :C';


      SQL_STMT := 'SELECT a.VENDOR_ID,a.VENDOR_CODE,a.FOLLOW_UP,a.FOLLOW_UP_SAT,a.FOLLOW_UP_DTE,a.STANDING,a.NBR_WORKORDERS,a.ACTIVE,a.LAST_REVIEW,a.REVIEWED_BY,a.SEGMENTS,a.CAP_HOLD,';
      SQL_STMT := SQL_STMT||'a.BATCH_NO, a.WORKCODE,a.ASSIGNED_TO,a.COMPLETED_BY,a.START_COUNTER_DATE,a.FOLLOW_UP_CAT,a.THIRTY_FIFTY_DAY_RULE,a.assign_it,a.FOLLOW_UP_RES, a.ROWID FROM SQA_VENDOR_LIST a  ';
      SQL_STMT := SQL_STMT||'  WHERE  a.assigned_to  = 0 ';
      SQL_STMT := SQL_STMT||'  AND    a.completed_by = 0 ';
      SQL_STMT := SQL_STMT||'  AND    a.assign_it    = 1 ';

      OPEN GC FOR SQL_STMT;
         FETCH GC BULK COLLECT INTO VL.VENDOR_ID,
                                    VL.VENDOR_CODE,
                                    VL.FOLLOW_UP,
                                    VL.FOLLOW_UP_SAT,
                                    VL.FOLLOW_UP_DTE,
                                    VL.STANDING,
                                    VL.NBR_WORKORDERS,
                                    VL.ACTIVE,
                                    VL.LAST_REVIEW,
                                    VL.REVIEWED_BY,
                                    VL.SEGMENTS,
                                    VL.CAP_HOLD,
                                    VL.BATCH_NO,
                                    VL.WORKCODE,
                                    VL.ASSIGNED_TO,
                                    VL.COMPLETED_BY,
                                    VL.START_COUNTER_DATE,
                                    VL.FOLLOW_UP_CAT,
                                    VL.THIRTY_FIFTY_DAY_RULE,
                                    VL.ASSIGN_IT,
                                    VL.FOLLOW_UP_RES,
                                    VL.ROWIDS;

                 NO_ASSIGN := VL.VENDOR_CODE.COUNT;

                 OPEN C1;

                 FOR X IN 1..VL.VENDOR_CODE.COUNT LOOP
                    FETCH C1 INTO R1;
                       IF ( C1%NOTFOUND )
                          THEN
                            CLOSE C1;
                            OPEN  C1;
                            FETCH C1 INTO R1;
                       END IF;

                      VL.ASSIGNED_TO(x) := R1.PID;

                 END LOOP;

                 CLOSE C1;

       FORALL k in 1..VL.VENDOR_ID.COUNT
          EXECUTE IMMEDIATE UPD_STMT USING VL.ASSIGNED_TO(k), -1, VL.ROWIDS(k);


      COMMIT;


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'ASSIGN_REVIEWS',SYSDATE, NO_ASSIGN, 'Complete..');
    COMMIT;


EXCEPTION
      WHEN OTHERS THEN
          RCODE := SQLCODE;
          MSG   := SQLERRM;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'ASSIGN_REVIEWS',SYSDATE, RCODE, MSG);
    COMMIT;



END;

PROCEDURE LOAD_ICC_FILES(P_FILE_TYPE NUMBER)
IS

/********************************************************************
    Process what has not been moved from stage to Work order lists
          SQA_LOV.LOAD_ICC_FILES;
 ******************************************************************/
CURSOR C1 (FILE_ID NUMBER)
IS
select PID, FILE_TYPE, FILE_NAME, RECORDCNT, LOAD_DATE, LOADED_BY, COMMENTS, BEGIN_LOAD_ID, END_LOAD_ID, LOADED
from  SQA_ICC_FILES_LIST
WHERE LOADED = 0
 AND  FILE_TYPE = FILE_ID;


R1  C1%ROWTYPE;

GC          GenRefCursor;
SQL_STMT    VARCHAR2(32000 BYTE);
DEL_STMT    VARCHAR2(32000 BYTE);
UPD_STMT    VARCHAR2(32000 BYTE);
MSG         VARCHAR2(1000 BYTE);
cnt1        NUMBER(10);

/*
   file id 4 is CARDS
 */

BEGIN


OPEN C1( P_FILE_TYPE);
    LOOP
    FETCH C1 INTO R1;
    EXIT WHEN C1%NOTFOUND;

     IF ( P_FILE_TYPE IN (1) )
        THEN

      /*
        ASSIGN  PID to stage table ASSIGNING EACH RECORD To the File that was just loaded
      */
                  BEGIN
                      UPD_STMT := ' UPDATE SQA_ICC_QAPP_UPLOAD_STG set FILE_ID = :1 WHERE LOAD_ID BETWEEN :2 AND :3 ';

                      EXECUTE IMMEDIATE UPD_STMT USING  R1.PID, R1.BEGIN_LOAD_ID, R1.END_LOAD_ID;


                      COMMIT;

                      SQL_STMT := ' insert into SQA_ICC_QC_Review_Detail(Loan_NBR,Client_Code,Review_Origin, Reviewed_by,DATE_UPLOADED,DATE_TO_REVIEW)';
                      SQL_STMT := SQL_STMT||'  select A.LOAN_NUMBER, A.CLIENT_NAME, A.CAR_NAME, REVIEWER,SYSDATE, SYSDATE ';
                      SQL_STMT := SQL_STMT||'  FROM    SQA_ICC_QAPP_UPLOAD_STG  A';
                      SQL_STMT := SQL_STMT||'  LEFT JOIN ( SELECT LOAN_NBR, CLIENT_CODE, REVIEW_ORIGIN FROM SQA_ICC_QC_REVIEW_DETAIL ) B ON ( A.LOAN_NUMBER = B.LOAN_NBR  AND A.CLIENT_NAME = B.CLIENT_CODE AND A.CAR_NAME    = B.REVIEW_ORIGIN)';
                      SQL_STMT := SQL_STMT||' WHERE  A.LOAN_NUMBER NOT IN (''BEGIN'',''END'') ';
                      SQL_STMT := SQL_STMT||' AND  B.LOAN_NBR IS NULL ';
                      SQL_STMT := SQL_STMT||' AND A.FILE_ID = :A';

                      EXECUTE IMMEDIATE SQL_STMT USING  R1.PID;

                           cnt1  := SQL%ROWCOUNT;


                    COMMIT;

                      /*

                        move from stage to
                          CREATE TABLE SQA_ICC_Assignment
                          (
                          PID                 NUMBER,
                          Loan_NBR            VARCHAR2(40 BYTE),
                          Order_NBR           VARCHAR2(40 BYTE),
                          WorkCode_SName      VARCHAR2(40 BYTE),
                          Client_Code         VARCHAR2(40 BYTE),
                          Loan_Type           VARCHAR2(10 BYTE),
                          Completion_DATE     Date,
                          Billed_Date         DATE,
                          Initial_ICC_Date    DATE,
                          Completed_ICC_Date  DATE,
                          Reconvey_Date       DATE,
                          Reconvey_Check      VARCHAR2(40 BYTE),
                          INTICC_Check        VARCHAR2(40 BYTE),
                          Backlog             VARCHAR2(20 BYTE),
                          Report_Date         DATE,
                          Last_Pass_Date      DATE,
                          Last_Fail_Date      DATE,
                          Assignment          VARCHAR2(200 BYTE)
                          )

                      */

                              INSERT INTO BOA_PROCESS_LOG
                                          (
                                            PROCESS,
                                            SUB_PROCESS,
                                            ENTRYDTE,
                                            ROWCOUNTS,
                                            MESSAGE
                                          )
                              VALUES ( 'SQA_LOV', 'LOAD_ICC_FILES',SYSDATE, cnt1, 'from '||R1.FILE_NAME);
                              COMMIT;

                      /*
                         close out the queue record
                      */
                            UPDATE SQA_ICC_FILES_LIST SET LOADED = 1, RECORDCNT = cnt1 WHERE PID = R1.PID;

                            COMMIT;

                            EXECUTE IMMEDIATE 'TRUNCATE TABLE SQA_ICC_QAPP_UPLOAD_STG DROP STORAGE';

                  EXCEPTION WHEN OTHERS THEN

                            UPDATE SQA_ICC_FILES_LIST SET LOADED = 9, RECORDCNT = 0 WHERE PID = R1.PID;
                            COMMIT;
                            MSG   := SQLERRM;
                           SEND_EMAIL  (P_TEAM=>'RDM',P_FROM=>'SQA_LOV.LOAD_ICC_FILES',P_SUBJECT=>R1.FILE_NAME ,P_MESSAGE=>MSG );
                  END;
           END IF;

     IF ( P_FILE_TYPE IN (2) )
        THEN

      /*
        ASSIGN  PID to stage table ASSIGNING EACH RECORD To the File that was just loaded
      */

--LOAN_NUMBER,CLIENT_NAME,REVIEWER,CAR_NAME,STATE,CLIENT_SPECIFIC_LOAN_STATUS,FTV,SALE_DATE,CURRENT_CONVEYANCE_DEADLINE,INITIAL_ICC_DATE,ICC_DATE,CASE_NUMBER,UPDATER,  BILLER,LOAD_ID,FILE_ID

                  BEGIN
                      UPD_STMT := ' UPDATE SQA_ICC_WORK_ASSIGNED_STG set FILE_ID = :1 WHERE LOAD_ID BETWEEN :2 AND :3 ';

                      EXECUTE IMMEDIATE UPD_STMT USING  R1.pid, R1.BEGIN_LOAD_ID, R1.END_LOAD_ID;


                      COMMIT;

                      SQL_STMT := ' insert into SQA_ICC_WORK_ASSIGNED(LOAN_NUMBER,  CLIENT_NAME,REVIEWER,DATA_SOURCE,RECONVEY_STATUS,CAR_NAME,STATE,CLIENT_SPECIFIC_LOAN_STATUS,FTV,SALE_DATE,CURRENT_CONVEYANCE_DEADLINE,INITIAL_ICC_DATE,ICC_DATE,CASE_NUMBER,UPDATER,BILLER,FILE_ID,LOAD_DATE)';
                      SQL_STMT := SQL_STMT||'  select A.LOAN_NUMBER,A.CLIENT_NAME,A.REVIEWER,A.DATA_SOURCE,A.RECONVEY_STATUS,A.CAR_NAME,A.STATE,A.CLIENT_SPECIFIC_LOAN_STATUS,A.FTV,A.SALE_DATE,A.CURRENT_CONVEYANCE_DEADLINE,A.INITIAL_ICC_DATE,A.ICC_DATE,A.CASE_NUMBER,A.UPDATER,A.BILLER,A.FILE_ID, SYSDATE';
                      SQL_STMT := SQL_STMT||'  FROM    SQA_ICC_WORK_ASSIGNED_STG  A';
                      SQL_STMT := SQL_STMT||'  LEFT JOIN ( SELECT LOAN_NUMBER,CLIENT_NAME,CAR_NAME FROM SQA_ICC_WORK_ASSIGNED ) B ON ( A.LOAN_NUMBER = B.LOAN_NUMBER  AND A.CLIENT_NAME = B.CLIENT_NAME AND A.CAR_NAME  = B.CAR_NAME)';
                      SQL_STMT := SQL_STMT||'  WHERE  A.LOAN_NUMBER NOT IN (''BEGIN'',''END'',''LOAN_NUMBER'') ';
                      SQL_STMT := SQL_STMT||'   AND  B.LOAN_NUMBER IS NULL ';
                      SQL_STMT := SQL_STMT||'   AND A.FILE_ID = :A';

                      EXECUTE IMMEDIATE SQL_STMT USING  R1.pid;

                               cnt1  := SQL%ROWCOUNT;


                               COMMIT;

                              INSERT INTO BOA_PROCESS_LOG
                                          (
                                            PROCESS,
                                            SUB_PROCESS,
                                            ENTRYDTE,
                                            ROWCOUNTS,
                                            MESSAGE
                                          )
                              VALUES ( 'SQA_LOV', 'LOAD_ICC_FILES',SYSDATE, cnt1, 'from '||R1.FILE_NAME);
                              COMMIT;

                      /*
                         close out the queue record
                      */
                            UPDATE SQA_ICC_FILES_LIST SET LOADED = 1, RECORDCNT = cnt1 WHERE PID = R1.PID;

                            COMMIT;

                            EXECUTE IMMEDIATE 'TRUNCATE TABLE SQA_ICC_WORK_ASSIGNED_STG DROP STORAGE';

                  EXCEPTION WHEN OTHERS THEN

                            UPDATE SQA_ICC_FILES_LIST SET LOADED = 9, RECORDCNT = 0 WHERE PID = R1.PID;
                            COMMIT;
                            MSG   := SQLERRM;
                           SEND_EMAIL  (P_TEAM=>'RDM',P_FROM=>'SQA_LOV.LOAD_ICC_FILES',P_SUBJECT=>R1.FILE_NAME ,P_MESSAGE=>MSG );
                  END;
           END IF;


       IF ( P_FILE_TYPE IN (4) )
          THEN

        /*
          ASSIGN  PID to stage table ASSIGNING EACH RECORD To the File that was just loaded
        */
                BEGIN
                    UPD_STMT := ' UPDATE SQA_ICC_CARDS_RPT_STG set FILE_ID = :1 WHERE LOAD_ID BETWEEN :2 AND :3 ';

                    EXECUTE IMMEDIATE UPD_STMT USING  R1.PID, R1.BEGIN_LOAD_ID, R1.END_LOAD_ID;

                    COMMIT;

                     EXECUTE IMMEDIATE 'TRUNCATE TABLE SQA_ICC_CARDS_REPORT DROP STORAGE';

                      SQL_STMT := ' INSERT INTO SQA_ICC_CARDS_REPORT ';
                      SQL_STMT := SQL_STMT||' (LOAN,';
                      SQL_STMT := SQL_STMT||' MORT_NAME,';
                      SQL_STMT := SQL_STMT||' ADDRESS_LINE1,';
                      SQL_STMT := SQL_STMT||' ADDRESS_LINE2,';
                      SQL_STMT := SQL_STMT||' CITY,';
                      SQL_STMT := SQL_STMT||' STATE,';
                      SQL_STMT := SQL_STMT||' ZIP,';
                      SQL_STMT := SQL_STMT||' SALE_DT,';
                      SQL_STMT := SQL_STMT||' SECURED_DT,';
                      SQL_STMT := SQL_STMT||' WINTERIZED_DT,';
                      SQL_STMT := SQL_STMT||' INITIAL_ICC_DT,';
                      SQL_STMT := SQL_STMT||' REPORTED_ICC_DT,';
                      SQL_STMT := SQL_STMT||' COMPLETED_ICC_DT,';
                      SQL_STMT := SQL_STMT||' CONVEY_DATE,';
                      SQL_STMT := SQL_STMT||' INVESTOR,';
                      SQL_STMT := SQL_STMT||' CLIENT,';
                      SQL_STMT := SQL_STMT||' LOAD_ID,';
                      SQL_STMT := SQL_STMT||' FILE_ID)';

                      SQL_STMT := SQL_STMT||' SELECT ';
                      SQL_STMT := SQL_STMT||' R.LOAN,';
                      SQL_STMT := SQL_STMT||' R.MORT_NAME,';
                      SQL_STMT := SQL_STMT||' R.ADDRESS_LINE1,';
                      SQL_STMT := SQL_STMT||' R.ADDRESS_LINE2,';
                      SQL_STMT := SQL_STMT||' R.CITY,';
                      SQL_STMT := SQL_STMT||' R.STATE,';
                      SQL_STMT := SQL_STMT||' R.ZIP,';
                      SQL_STMT := SQL_STMT||' R.SALE_DT,';
                      SQL_STMT := SQL_STMT||' R.SECURED_DT,';
                      SQL_STMT := SQL_STMT||' R.WINTERIZED_DT,';
                      SQL_STMT := SQL_STMT||' R.INITIAL_ICC_DT,';
                      SQL_STMT := SQL_STMT||' R.REPORTED_ICC_DT,';
                      SQL_STMT := SQL_STMT||' R.COMPLETED_ICC_DT,';
                      SQL_STMT := SQL_STMT||' R.CONVEY_DATE,';
                      SQL_STMT := SQL_STMT||' R.INVESTOR,';
                      SQL_STMT := SQL_STMT||' R.CLIENT,';
                      SQL_STMT := SQL_STMT||' R.LOAD_ID,';
                      SQL_STMT := SQL_STMT||' R.FILE_ID ';
                      SQL_STMT := SQL_STMT||' FROM ( ';

                      SQL_STMT := SQL_STMT||' SELECT ';
                      SQL_STMT := SQL_STMT||' LOAN,';
                      SQL_STMT := SQL_STMT||' MORT_NAME,';
                      SQL_STMT := SQL_STMT||' ADDRESS_LINE1,';
                      SQL_STMT := SQL_STMT||' ADDRESS_LINE2,';
                      SQL_STMT := SQL_STMT||' CITY,';
                      SQL_STMT := SQL_STMT||' STATE,';
                      SQL_STMT := SQL_STMT||' ZIP,';
                      SQL_STMT := SQL_STMT||' SALE_DT,';
                      SQL_STMT := SQL_STMT||' SECURED_DT,';
                      SQL_STMT := SQL_STMT||' WINTERIZED_DT,';
                      SQL_STMT := SQL_STMT||' INITIAL_ICC_DT,';
                      SQL_STMT := SQL_STMT||' REPORTED_ICC_DT,';
                      SQL_STMT := SQL_STMT||' COMPLETED_ICC_DT,';
                      SQL_STMT := SQL_STMT||' CONVEY_DATE,';
                      SQL_STMT := SQL_STMT||' INVESTOR,';
                      SQL_STMT := SQL_STMT||' CLIENT,';
                      SQL_STMT := SQL_STMT||' LOAD_ID,';
                      SQL_STMT := SQL_STMT||' FILE_ID, RANK() OVER ( PARTITION BY LOAN, CLIENT ORDER BY ROWNUM ) RK';
                      SQL_STMT := SQL_STMT||' FROM SQA_ICC_CARDS_RPT_STG WHERE FILE_ID = :A ';
                      SQL_STMT := SQL_STMT||'  AND  LOAN NOT IN (''BEGIN'',''END'',''LOAN'') ) R ';
                      SQL_STMT := SQL_STMT||' WHERE R.RK = 1';

                      EXECUTE IMMEDIATE SQL_STMT USING  R1.PID;

                         cnt1  := SQL%ROWCOUNT;

                        COMMIT;


                            INSERT INTO BOA_PROCESS_LOG
                                        (
                                          PROCESS,
                                          SUB_PROCESS,
                                          ENTRYDTE,
                                          ROWCOUNTS,
                                          MESSAGE
                                        )
                            VALUES ( 'SQA_LOV', 'LOAD_ICC_FILES',SYSDATE, cnt1, 'from '||R1.FILE_NAME);
                            COMMIT;

                    /*
                       close out the queue record
                    */
                          UPDATE SQA_ICC_FILES_LIST SET LOADED = 1, RECORDCNT = cnt1, COMMENTS = 'No Issues found' WHERE PID = R1.PID;

                          COMMIT;

                          EXECUTE IMMEDIATE 'TRUNCATE TABLE SQA_ICC_CARDS_RPT_STG DROP STORAGE';

                EXCEPTION WHEN OTHERS THEN

                          MSG   := SQLERRM;

                          UPDATE SQA_ICC_FILES_LIST SET LOADED = 9, RECORDCNT = 0, COMMENTS = MSG  WHERE PID = R1.PID;
                          COMMIT;

                         SEND_EMAIL  (P_TEAM=>'RDM',P_FROM=>'SQA_LOV.LOAD_ICC_FILES',P_SUBJECT=>R1.FILE_NAME ,P_MESSAGE=>MSG );
                END;
       END IF;


    END LOOP;
CLOSE C1;
exception
     when others then
          cnt1  := sqlcode;
           msg  := sqlerrm;

              INSERT INTO BOA_PROCESS_LOG
                    (
                      PROCESS,
                      SUB_PROCESS,
                      ENTRYDTE,
                      ROWCOUNTS,
                      MESSAGE
                    )
        VALUES ( 'SQA_LOV', 'LOAD_ICC_FILES', SYSDATE, cnt1, msg);
        COMMIT;


    SEND_EMAIL  (P_TEAM=>'RDM',P_FROM=>'SQA_LOV.LOAD_ICC_FILES',P_SUBJECT=>'Procedure issue' ,P_MESSAGE=>MSG );

END;

  PROCEDURE SET_SYS_VARIABLES
  IS

  BEGIN

            SELECT VARIABLE_VALUE
             INTO    GV_30_RULE
             FROM  SQA_SYS_VARIABLES
            WHERE VARIABLE_NAME = 'Thirty_rule';

          SELECT VARIABLE_VALUE
            INTO   GV_50_RULE
           FROM  SQA_SYS_VARIABLES
           WHERE VARIABLE_NAME = 'Fifty_rule';


          SELECT VARIABLE_VALUE
           INTO  GV_100_RULE
           FROM  SQA_SYS_VARIABLES
          WHERE VARIABLE_NAME = 'Hundred_rule';

          SELECT VARIABLE_VALUE
           INTO  GV_TESTING
           FROM  SQA_SYS_VARIABLES
          WHERE VARIABLE_NAME = 'TESTING';




         IF ( GV_TESTING = 1 ) THEN

                SELECT TO_DATE(VARIABLE_VALUE,'MM/DD/YYYY')
                 INTO  GV_CURRENT_DATE
                 FROM  SQA_SYS_VARIABLES
                WHERE VARIABLE_NAME = 'Current_date';
         ELSE
                SELECT  TRUNC(SYSDATE)
                INTO    GV_CURRENT_DATE
                FROM  DUAL;

                UPDATE  SQA_SYS_VARIABLES
                 SET VARIABLE_VALUE = TO_CHAR(SYSDATE,'MM/DD/YYYY')
                WHERE VARIABLE_NAME = 'Current_date';

         END IF;


  END;


---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
PROCEDURE MOVE_ETL_TO_DATA (P_CURRENT_DATE DATE)
IS


CNT              NUMBER;
R                SQA_LOVS.SQA_TD_DATA_ETL_REC;
GC                SQA_LOVS.GenRefCursor;
SQL_STMT           VARCHAR2(32000 BYTE);
GV_CURRENT_DATE    DATE;

BEGIN
/*
                SELECT TO_DATE(VARIABLE_VALUE,'MM/DD/YYYY')
                 INTO  GV_CURRENT_DATE
                 FROM  SQA_SYS_VARIABLES
                WHERE VARIABLE_NAME = 'Current_date';
*/

CNT := 0;

SQL_STMT := 'SELECT A.SPIPROPERTYID,A.LOANNUMBER,A.LOANTYPE,A.CLIENT,A.ADDRESSLINE1,A.ADDRESSLINE2,A.CITY,A.STATE,A.ZIP,A.ORDERNUMBER,A.ORDERDATE,A.WORKCODE,A.COMPLETEDDATE,A.CONTRACTORCODE,A.MORTGAGORNAME,A.SALEDATE,A.SECUREDDATE,A.WINTERIZEDDATE,';
SQL_STMT := SQL_STMT||' A.INITIALICCDATE,A.LASTICCDATE,A.CONVEYDATE,A.INVESTORNUMBER,A.BILLINGCODE,A.REPORT_SEGMENT,A.WORK_GROUP,A.NBR_QUESTIONS,A.PID';
SQL_STMT := SQL_STMT||' FROM SQA_TD_DATA_ETL a';
SQL_STMT := SQL_STMT||' LEFT JOIN ( SELECT PID FROM SQA_TD_DATA ) B ON (A.PID = B.PID)';
SQL_STMT := SQL_STMT||' WHERE  B.PID  is null';
SQL_STMT := SQL_STMT||' AND  a.COMPLETEDDATE =  :A ';
SQL_STMT := SQL_STMT||' AND  A.REPORT_SEGMENT NOT IN (''SKIP'')';

OPEN GC FOR SQL_STMT USING P_CURRENT_DATE;
      LOOP

      FETCH GC BULK COLLECT INTO
                                  R.SPIPROPERTYID,
                                  R.LOANNUMBER,
                                  R.LOANTYPE,
                                  R.CLIENT,
                                  R.ADDRESSLINE1,
                                  R.ADDRESSLINE2,
                                  R.CITY,
                                  R.STATE,
                                  R.ZIP,
                                  R.ORDERNUMBER,
                                  R.ORDERDATE,
                                  R.WORKCODE,
                                  R.COMPLETEDDATE,
                                  R.CONTRACTORCODE,
                                  R.MORTGAGORNAME,
                                  R.SALEDATE,
                                  R.SECUREDDATE,
                                  R.WINTERIZEDDATE,
                                  R.INITIALICCDATE,
                                  R.LASTICCDATE,
                                  R.CONVEYDATE,
                                  R.INVESTORNUMBER,
                                  R.BILLINGCODE,
                                  R.REPORT_SEGMENT,
                                  R.WORK_GROUP,
                                  R.NBR_QUESTIONS,
                                  R.PID
                                  LIMIT 10000;
            EXIT WHEN R.PID.count = 0;

            CNT := CNT + R.PID.COUNT;
            FOR k in 1..R.PID.COUNT LOOP
                   INSERT INTO SQA_TD_DATA(  DATA_DT,
                                             SPIPROPERTYID,
                                             LOANNUMBER,
                                             LOAN_TYPE,
                                             CLIENT,
                                             ADD_1,
                                             ADD_2,
                                             CITY,
                                             ST,
                                             ZIP,
                                             ORDER_NUM,
                                             ORDER_DT,
                                             WORK_CODE,
                                             COMPLETED_DT,
                                             CONTRACTOR,
                                             REPORT_SEGMENT,
                                             NBR_QUESTIONS,
                                             PID)
                     VALUES (SYSDATE,
                              R.SPIPROPERTYID(k),
                              R.LOANNUMBER(k),
                              R.LOANTYPE(k),
                              R.CLIENT(k),
                              R.ADDRESSLINE1(k),
                              R.ADDRESSLINE2(k),
                              R.CITY(k),
                              R.STATE(k),
                              R.ZIP(k),
                              R.ORDERNUMBER(k),
                              R.ORDERDATE(k),
                              R.WORKCODE(k),
                              R.COMPLETEDDATE(k),
                              R.CONTRACTORCODE(k),
                              R.REPORT_SEGMENT(k),
                              R.NBR_QUESTIONS(k),
                              R.PID(k));
            END LOOP;


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'MOVE SQA_TD_DATA_ETL TO SQA_TD_DATA',SYSDATE, CNT, 'Running  ');
         COMMIT;


      END LOOP;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'MOVE SQA_TD_DATA_ETL TO SQA_TD_DATA',SYSDATE, CNT, 'Complete');
         COMMIT;


END;

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
PROCEDURE MOVE_ETL_TO_DATA
IS


CNT                NUMBER;
R                  SQA_LOVS.SQA_TD_DATA_ETL_REC;
GC                 SQA_LOVS.GenRefCursor;
SQL_STMT           VARCHAR2(32000 BYTE);
GV_CURRENT_DATE    DATE;
GV_CURRENT_MINUS_2 DATE;
GV_CURRENT_PLUS_2  DATE;


BEGIN

SELECT TO_DATE(VARIABLE_VALUE,'MM/DD/YYYY')
 INTO  GV_CURRENT_DATE
 FROM  SQA_SYS_VARIABLES
WHERE VARIABLE_NAME = 'Current_date';

GV_CURRENT_MINUS_2 :=  GV_CURRENT_DATE - 3;
GV_CURRENT_PLUS_2  :=  GV_CURRENT_DATE + 3;
CNT := 0;

SQL_STMT := 'SELECT A.SPIPROPERTYID,A.LOANNUMBER,A.LOANTYPE,A.CLIENT,A.ADDRESSLINE1,A.ADDRESSLINE2,A.CITY,A.STATE,A.ZIP,A.ORDERNUMBER,A.ORDERDATE,A.WORKCODE,A.COMPLETEDDATE,A.CONTRACTORCODE,A.MORTGAGORNAME,A.SALEDATE,A.SECUREDDATE,A.WINTERIZEDDATE,';
SQL_STMT := SQL_STMT||' A.INITIALICCDATE,A.LASTICCDATE,A.CONVEYDATE,A.INVESTORNUMBER,A.BILLINGCODE,A.REPORT_SEGMENT,A.WORK_GROUP,A.NBR_QUESTIONS,A.PID';
SQL_STMT := SQL_STMT||' FROM SQA_TD_DATA_ETL a';
SQL_STMT := SQL_STMT||' LEFT JOIN ( SELECT PID FROM SQA_TD_DATA ) B ON (A.PID = B.PID)';
SQL_STMT := SQL_STMT||' WHERE  B.PID  is null';
SQL_STMT := SQL_STMT||' and A.COMPLETEDDATE BETWEEN :A AND :B  ';
SQL_STMT := SQL_STMT||' and A.COMPLETEDDATE IS NOT NULL ';
SQL_STMT := SQL_STMT||' AND  A.REPORT_SEGMENT NOT IN (''SKIP'')';

OPEN GC FOR SQL_STMT USING GV_CURRENT_MINUS_2,  GV_CURRENT_PLUS_2;
      LOOP

      FETCH GC BULK COLLECT INTO
                                  R.SPIPROPERTYID,
                                  R.LOANNUMBER,
                                  R.LOANTYPE,
                                  R.CLIENT,
                                  R.ADDRESSLINE1,
                                  R.ADDRESSLINE2,
                                  R.CITY,
                                  R.STATE,
                                  R.ZIP,
                                  R.ORDERNUMBER,
                                  R.ORDERDATE,
                                  R.WORKCODE,
                                  R.COMPLETEDDATE,
                                  R.CONTRACTORCODE,
                                  R.MORTGAGORNAME,
                                  R.SALEDATE,
                                  R.SECUREDDATE,
                                  R.WINTERIZEDDATE,
                                  R.INITIALICCDATE,
                                  R.LASTICCDATE,
                                  R.CONVEYDATE,
                                  R.INVESTORNUMBER,
                                  R.BILLINGCODE,
                                  R.REPORT_SEGMENT,
                                  R.WORK_GROUP,
                                  R.NBR_QUESTIONS,
                                  R.PID
                                  LIMIT 10000;
            EXIT WHEN R.PID.count = 0;

            CNT := CNT + R.PID.COUNT;
            FOR k in 1..R.PID.COUNT LOOP
                   INSERT INTO SQA_TD_DATA(  DATA_DT,
                                             SPIPROPERTYID,
                                             LOANNUMBER,
                                             LOAN_TYPE,
                                             CLIENT,
                                             ADD_1,
                                             ADD_2,
                                             CITY,
                                             ST,
                                             ZIP,
                                             ORDER_NUM,
                                             ORDER_DT,
                                             WORK_CODE,
                                             COMPLETED_DT,
                                             CONTRACTOR,
                                             REPORT_SEGMENT,
                                             NBR_QUESTIONS,
                                             PID)
                     VALUES (SYSDATE,
                              R.SPIPROPERTYID(k),
                              R.LOANNUMBER(k),
                              R.LOANTYPE(k),
                              R.CLIENT(k),
                              R.ADDRESSLINE1(k),
                              R.ADDRESSLINE2(k),
                              R.CITY(k),
                              R.STATE(k),
                              R.ZIP(k),
                              R.ORDERNUMBER(k),
                              R.ORDERDATE(k),
                              R.WORKCODE(k),
                              R.COMPLETEDDATE(k),
                              R.CONTRACTORCODE(k),
                              R.REPORT_SEGMENT(k),
                              R.NBR_QUESTIONS(k),
                              R.PID(k));
            END LOOP;


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'MOVE SQA_TD_DATA_ETL TO SQA_TD_DATA',SYSDATE, CNT, 'Running  ');
         COMMIT;


      END LOOP;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'MOVE SQA_TD_DATA_ETL TO SQA_TD_DATA',SYSDATE, CNT, 'Complete');
         COMMIT;


END;


PROCEDURE ADD_DATA_TO_ETL
IS
TYPE MONTHS IS RECORD
(
  MO    DBMS_SQL.NUMBER_TABLE
);
 M  MONTHS;
BEGIN

/*
MAR  -122
APR  -91
MAY  -61
JUN  -30
JUL   START
AUG   +31
SEP   +59
OCT   +90
NOV   +120
DEC   +151
JAN   +181
FEB   +212
MAR   +243
APR   +273
MAY   +304
JUN   +334
JUL   +365
*/
    M.MO(1)  := -122;
    M.MO(2)  := -91;
    M.MO(3)  := -61;
    m.mo(4) := -30;
    M.MO(5) := 31;
    M.MO(6) := 59;
    M.MO(7) := 90;
    M.MO(8) := 120;
    M.MO(9) := 151;
    M.MO(10) := 181;
    M.MO(11) := 212;
    M.MO(12) := 243;
    M.MO(13) := 273;
    M.MO(14) := 304;
    M.MO(15) := 334;
    M.MO(16) := 365;


FOR i in 1..m.mo.count loop

 INSERT INTO SQA_TD_DATA_ETL( SPIPROPERTYID,
                              LOANNUMBER,
                              LOANTYPE,
                              CLIENT,
                              ADDRESSLINE1,
                              ADDRESSLINE2,
                              CITY,
                              STATE,
                              ZIP,
                              ORDERNUMBER,
                              WORKCODE,
                              COMPLETEDDATE,
                              CONTRACTORCODE,
                              MORTGAGORNAME,
                              INVESTORNUMBER,
                              BILLINGCODE)
 SELECT A.SPIPROPERTYID,
        A.LOANNUMBER,
        A.LOANTYPE,
        A.CLIENT,
        A.ADDRESSLINE1,
        A.ADDRESSLINE2,
        A.CITY,
        A.STATE,
        A.ZIP,
        A.ORDERNUMBER,
        A.WORKCODE,
        CASE WHEN A.COMPLETEDDATE IS NOT NULL THEN A.COMPLETEDDATE + M.MO(I) END COMPLETEDDATE_30,
         A.CONTRACTORCODE,
         A.MORTGAGORNAME,
         A.INVESTORNUMBER,
         A.BILLINGCODE
         FROM SQA_TD_DATA_ETL  A
         Where a.contractorcode in ('P5GRS','ABRREO','CALRGR','NAMGR2','PSEGRS','BMVREO','RJRRGR','JESRGR')
           AND A.COMPLETEDDATE BETWEEN  TO_DATE('07/01/2016','MM/DD/YYYY') AND TO_DATE('07/31/2016','MM/DD/YYYY');
 commit;

end loop;

COMMIT;

end;

/**********************************************************************************************************

***********************************************************************************************************/

PROCEDURE RUN_PROCESS
IS

BEGIN

  SQA_LOVS.SET_SYS_VARIABLES;
  SQA_LOVS.MOVE_ETL_TO_DATA;
  SQA_LOVS.SET_NBR_VENDOR_WO;
  SQA_LOVS.ASSIGN_REVIEWS;

END;
/**********************************************************************

***********************************************************************/

PROCEDURE ICC_QC_ASSIGNMENT
IS

GC  GenRefCursor;
FD  EIM_FIPINT_DAILY_REC;
ID  EIM_INTICC_DAILY_REC;
IC  SQA_ICC_CARDS_REC;
PC  EIM_PROPERTY_CONVEY_COND_REC;
WR  EIM_WORKORDER_RECONVEY_REC;
LR  EIM_LOAN_RECONVEY_REC;
CL  EIM_OPEN_FHA_CLAIM_REC;
PL  SQA_ICC_PRIOR_LOAN_HIST_REC;

SQL_STMT        VARCHAR2(32000 BYTE);
SQLROWCOUNT     NUMBER;
MSG             VARCHAR2(32000 BYTE);
TODAY           DATE;
manual_control  number;

BEGIN

     TODAY := TRUNC(SYSDATE);


select VARIABLE_VALUE
into   manual_control
from SQA_SYS_VARIABLES
where VARIABLE_NAME  = 'ICC_MANUAL_FLAG';

IF ( manual_control = 1 )
   THEN
   select  to_date(VARIABLE_VALUE,'MM/DD/YYYY')
      into   TODAY
      from SQA_SYS_VARIABLES
      where VARIABLE_NAME  = 'ICC_REPORT_DATE';

END IF;



---- REMOVE TODAYS RUN IF WE RE-RAN for some reason

SQL_STMT := 'DELETE SQA_ICC_ASSIGNMENT_TEMP_HIST  WHERE REPORT_DATE = :H ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

SQL_STMT := 'DELETE EIM_WORKORDER_RECONVEY_HIST  WHERE REPORT_DATE = :W ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

SQL_STMT := 'DELETE EIM_LOAN_RECONVEY_HIST WHERE REPORT_DATE = :L ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

SQL_STMT := 'DELETE EIM_INTICC_HIST WHERE REPORT_DATE = :I ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

SQL_STMT := 'DELETE EIM_FIPINT_HIST WHERE REPORT_DATE = :F ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

SQL_STMT := 'DELETE SQA_ICC_CARDS_REPORT_HIST WHERE REPORT_DATE = :C ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

SQL_STMT := 'TRUNCATE TABLE SQA_ICC_ASSIGNMENT_TEMPLATE DROP STORAGE ';
EXECUTE IMMEDIATE SQL_STMT;
COMMIT;


SQLROWCOUNT := 0;

      INSERT INTO BOA_PROCESS_LOG
            (
              PROCESS,
              SUB_PROCESS,
              ENTRYDTE,
              ROWCOUNTS,
              MESSAGE
            )
     VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'Clear last run if needed');
     COMMIT;


insert into SQA_ICC_assignment_template (LOANNUMBER, CLIENTCODE, ORDERNUMBER, RECONVEYDATE, CONVEYSTATUS, SALEDATE, WORKCODEDESC, ORDERDATE, RECONVEY, DATA_SOURCE, BACKLOG, REPORT_DATE, LATEST_PASS_DATE, LATEST_FAIL_DATE, ASSIGNMENT)
SELECT  A.LOANNUMBER,
        A.CLIENTCODE,
        CL.ORDERNUMBER,
        CL.RECONVEYDATE,
        CL.CONVEYSTATUS,
        CL.SALEDATE,
        CL.WORKCODEDESC,
        CL.ORDERDATE,
        R.RECONVEY,
        A.DATA_SOURCE,
        Q.BACKLOG,
        TODAY AS REPORT_DATE,
 ps.ACTUAL_REVIEW_DATE as latest_pass_date,
 fl.ACTUAL_REVIEW_DATE as latest_fail_date,
 CASE WHEN Q.BACKLOG IS NOT NULL THEN 'NOT REVIEWED - Autocompleted Reverifies'
      when R.RECONVEY is not null and data_source in ('INTICC','FIPINT') THEN  'Assign - Reconvey INTICC Exception'
      WHEN R.RECONVEY is not null AND ps.ACTUAL_REVIEW_DATE IS NULL AND fl.ACTUAL_REVIEW_DATE IS NULL THEN  'Assign - RECONVEY'
      WHEN data_source in ('INTICC','FIPINT') THEN 'Assign - INTICC Exception'
      WHEN R.RECONVEY IS NOT NULL THEN 'Assign - RECONVEY'
      WHEN ps.ACTUAL_REVIEW_DATE IS NULL AND fl.ACTUAL_REVIEW_DATE IS NULL THEN 'Assign - New ICC'
      WHEN NVL(TO_NUMBER(to_char(fl.ACTUAL_REVIEW_DATE,'YYYYMMDD')),0) > NVL(TO_NUMBER(to_char(ps.ACTUAL_REVIEW_DATE,'YYYYMMDD')),0) THEN 'Assign - Failed Prior'
      WHEN (TODAY -  ps.ACTUAL_REVIEW_DATE) > 59 THEN  'Assign - Not Reviewed in 60 Days'
 ELSE  'NOT REVIEWED - Autocompleted Reverifies'
 END AS assignment
FROM (
SELECT R.LOANNUMBER,R.CLIENTCODE, R.DATA_SOURCE
FROM ( SELECT LOANNUMBER,CLIENTCODE, DATA_SOURCE, RANK() OVER ( PARTITION BY LOANNUMBER,CLIENTCODE ORDER BY DATA_SOURCE DESC, ROWNUM) RK
FROM(
select  LOANNUMBER,CLIENTCODE, 'INTICC' AS DATA_SOURCE
from EIM_INTICC_DAILY
UNION
select  LOANNUMBER,CLIENT_CODE AS CLIENTCODE, 'FIPINT' AS DATA_SOURCE
from EIM_FIPINT_DAILY
UNION
SELECT LOAN AS LOANNUMBER, CLIENT AS CLIENTCODE,  'CARDS' AS DATA_SOURCE
FROM SQA_ICC_CARDS_REPORT
))R
WHERE R.RK = 1) A
------ claims
LEFT JOIN ( select R.LOANNUMBER,R.ORDERNUMBER,R.CLIENTCODE,R.RECONVEYDATE,R.CONVEYSTATUS,R.SALEDATE,R.WORKCODEDESC,R.ORDERDATE
            FROM (
           select LOANNUMBER,ORDERNUMBER,CLIENTCODE,RECONVEYDATE,CONVEYSTATUS,SALEDATE,WORKCODEDESC,ORDERDATE, RANK() OVER ( PARTITION BY LOANNUMBER, CLIENTCODE ORDER BY ROWNUM ) RK
            FROM EIM_OPEN_FHA_CLAIM)R
            WHERE R.RK = 1 ) CL  ON ( A.LOANNUMBER =  CL.LOANNUMBER AND A.CLIENTCODE = CL.CLIENTCODE)
------- latest pass
LEFT JOIN ( SELECT  R.LOAN_NBR,R.CLIENT_CODE,R.OUTCOME,R.TRUE_OUTCOME, R.ACTUAL_REVIEW_DATE
             FROM (
             SELECT LOAN_NBR,CLIENT_CODE,OUTCOME,TRUE_OUTCOME, ACTUAL_REVIEW_DATE, RANK() OVER ( PARTITION BY LOAN_NBR, CLIENT_CODE ORDER BY ACTUAL_REVIEW_DATE DESC, ROWNUM) RK
               FROM SQA_ICC_PRIOR_LOAN_HISTORY  WHERE OUTCOME IN ('Pass') ) R
             WHERE R.RK = 1) Ps on ( ps.LOAN_NBR = A.LOANNUMBER AND ps.CLIENT_CODE = A.CLIENTCODE)
------ latest fail
LEFT JOIN ( SELECT  R.LOAN_NBR,R.CLIENT_CODE,R.OUTCOME,R.TRUE_OUTCOME, R.ACTUAL_REVIEW_DATE
             FROM (
             SELECT LOAN_NBR,CLIENT_CODE,OUTCOME,TRUE_OUTCOME, ACTUAL_REVIEW_DATE, RANK() OVER ( PARTITION BY LOAN_NBR, CLIENT_CODE ORDER BY ACTUAL_REVIEW_DATE DESC, ROWNUM) RK
               FROM SQA_ICC_PRIOR_LOAN_HISTORY  WHERE OUTCOME IN ('Fail') ) R
             WHERE R.RK = 1) fl on ( fl.LOAN_NBR = A.LOANNUMBER AND fl.CLIENT_CODE = A.CLIENTCODE)
LEFT JOIN ( SELECT U.LOANNUMBER, U.CLIENTCODE, 'RECONVEY' AS RECONVEY
             FROM (SELECT LOANNUMBER,CLIENTCODE
                     FROM EIM_WORKORDER_RECONVEY
                    UNION
                    SELECT LOANNUMBER,CLIENTCODE
                     FROM EIM_LOAN_RECONVEY)U  ) R ON ( R.LOANNUMBER = A.LOANNUMBER AND R.CLIENTCODE = A.CLIENTCODE)
LEFT JOIN ( SELECT LOANNUMBER, CLIENT,  REVIEWER AS BACKLOG  FROM SQA_ICC_BACKLOG  WHERE COMPLETED = 0 ) Q ON ( Q.LOANNUMBER = A.LOANNUMBER AND A.CLIENTCODE = Q.CLIENT);

       SQLROWCOUNT := SQL%ROWCOUNT;

       COMMIT;


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'SQA_ICC_assignment_template');
         COMMIT;



          INSERT INTO EIM_WORKORDER_RECONVEY_HIST (LOANNUMBER,CLIENTCODE,LOANTYPE,WORKCODE,ORDERNUMBER,COMPLETEDDATE_FK,ORDERDATE_FK,REPORT_DATE)
          SELECT LOANNUMBER,CLIENTCODE,LOANTYPE,WORKCODE,ORDERNUMBER,COMPLETEDDATE_FK,ORDERDATE_FK,TODAY AS REPORT_DATE
          FROM EIM_WORKORDER_RECONVEY;

           SQLROWCOUNT := SQL%ROWCOUNT;

           COMMIT;


            INSERT INTO BOA_PROCESS_LOG
                  (
                    PROCESS,
                    SUB_PROCESS,
                    ENTRYDTE,
                    ROWCOUNTS,
                    MESSAGE
                  )
           VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'EIM_WORKORDER_RECONVEY_HIST');
           COMMIT;



          INSERT INTO EIM_LOAN_RECONVEY_HIST ( LOANNUMBER, CLIENTCODE, LOANTYPE, CONVEYDATE, RECONVEYDATE, REPORT_DATE)
          SELECT  LOANNUMBER, CLIENTCODE, LOANTYPE, CONVEYDATE, RECONVEYDATE, TODAY AS REPORT_DATE
          FROM EIM_LOAN_RECONVEY;

           SQLROWCOUNT := SQL%ROWCOUNT;

           COMMIT;


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'EIM_LOAN_RECONVEY_HIST');
         COMMIT;

          INSERT INTO EIM_INTICC_HIST(LOANNUMBER, ORDERNUMBER, WORKCODE, CLIENTCODE, COMPLETIONENTEREDDATE_FK, COMPLETEDDATE_FK, SALEDATE, ISPOOLSECURE, ISHOTTUBSECURE, SUMPPUMP, ISSUMPPUMPOPERATIONAL, DEHUMIDIFIER, ISDEHUMIDIFIEROPERATIONAL, GARAGESECURE, OUTBUILDINGSECURE, CRAWLSPACESECURE, GRASSHEIGHT, PROPERTYSECURE, NEWDAMAGE, SEVEREDAMAGE, ISROOFTARPED, ACTIVEROOFLEAK, ACUNIT, ANTIFREEZEINALL, GAINACCESS, OCCUPANCYSTATUS, LOANTYPE, REPORT_DATE )
          SELECT LOANNUMBER, ORDERNUMBER, WORKCODE, CLIENTCODE, COMPLETIONENTEREDDATE_FK, COMPLETEDDATE_FK, SALEDATE, ISPOOLSECURE, ISHOTTUBSECURE, SUMPPUMP, ISSUMPPUMPOPERATIONAL, DEHUMIDIFIER, ISDEHUMIDIFIEROPERATIONAL, GARAGESECURE, OUTBUILDINGSECURE, CRAWLSPACESECURE, GRASSHEIGHT, PROPERTYSECURE, NEWDAMAGE, SEVEREDAMAGE, ISROOFTARPED, ACTIVEROOFLEAK, ACUNIT, ANTIFREEZEINALL, GAINACCESS, OCCUPANCYSTATUS, LOANTYPE, TODAY AS REPORT_DATE
          FROM EIM_INTICC_DAILY;

         SQLROWCOUNT := SQL%ROWCOUNT;

         COMMIT;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'EIM_INTICC_HIST');
         COMMIT;


          INSERT INTO EIM_FIPINT_HIST (LOANNUMBER, ORDERNUMBER, WORKCODE, CLIENT_CODE, COMPLETIONENTEREDDATE, COMPLETEDDATE, SALEDATE, ISPOOLSECURE, ISHOTTUBSECURE, SUMPPUMP, ISSUMPPUMPOPERATIONAL, DEHUMIDIFIER, ISDEHUMIDIFIEROPERATIONAL, GARAGESECURE, OUTBUILDINGSECURE, CRAWLSPACESECURE, GRASSHEIGHT, PROPERTYSECURE, NEWDAMAGE, SEVEREDAMAGE, ISROOFTARPED, ACTIVEROOFLEAK, ACUNIT, ANTIFREEZEINALL, GAINACCESS, OCCUPANCYSTATUS, LOANTYPE, FLOOD, MOLD, ROOFLEAK, VANDALISM, PERSONALPROPERTY, DEBRIS, CITATION, CONVEYDATE, CURRENTICCSTATUS, REPORT_DATE)
          SELECT LOANNUMBER, ORDERNUMBER, WORKCODE, CLIENT_CODE, COMPLETIONENTEREDDATE, COMPLETEDDATE, SALEDATE, ISPOOLSECURE, ISHOTTUBSECURE, SUMPPUMP, ISSUMPPUMPOPERATIONAL, DEHUMIDIFIER, ISDEHUMIDIFIEROPERATIONAL, GARAGESECURE, OUTBUILDINGSECURE, CRAWLSPACESECURE, GRASSHEIGHT, PROPERTYSECURE, NEWDAMAGE, SEVEREDAMAGE, ISROOFTARPED, ACTIVEROOFLEAK, ACUNIT, ANTIFREEZEINALL, GAINACCESS, OCCUPANCYSTATUS, LOANTYPE, FLOOD, MOLD, ROOFLEAK, VANDALISM, PERSONALPROPERTY, DEBRIS, CITATION, CONVEYDATE, CURRENTICCSTATUS, TODAY AS REPORT_DATE
          FROM EIM_FIPINT_DAILY;

          SQLROWCOUNT := SQL%ROWCOUNT;

          COMMIT;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'EIM_FIPINT_HIST');
         COMMIT;

         INSERT INTO SQA_ICC_CARDS_REPORT_HIST (LOAN, MORT_NAME, ADDRESS_LINE1, ADDRESS_LINE2, CITY, STATE, ZIP, SALE_DT, SECURED_DT, WINTERIZED_DT, INITIAL_ICC_DT, REPORTED_ICC_DT, COMPLETED_ICC_DT, CONVEY_DATE, INVESTOR, CLIENT, REPORT_DATE)
         SELECT LOAN, MORT_NAME, ADDRESS_LINE1, ADDRESS_LINE2, CITY, STATE, ZIP, SALE_DT, SECURED_DT, WINTERIZED_DT, INITIAL_ICC_DT, REPORTED_ICC_DT, COMPLETED_ICC_DT, CONVEY_DATE, INVESTOR, CLIENT, today as REPORT_DATE
         FROM SQA_ICC_CARDS_REPORT;

          SQLROWCOUNT := SQL%ROWCOUNT;

          COMMIT;

         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'SQA_ICC_CARDS_REPORT_HIST');
         COMMIT;




          SQL_STMT := ' insert into SQA_ICC_ASSIGNMENT_TEMP_HIST (LOANNUMBER, CLIENTCODE, ORDERNUMBER, RECONVEYDATE, CONVEYSTATUS, SALEDATE, WORKCODEDESC, ORDERDATE, RECONVEY, DATA_SOURCE, BACKLOG, REPORT_DATE, LATEST_PASS_DATE, LATEST_FAIL_DATE, ASSIGNMENT) ';
          SQL_STMT := SQL_STMT||' SELECT LOANNUMBER, CLIENTCODE, ORDERNUMBER, RECONVEYDATE, CONVEYSTATUS, SALEDATE, WORKCODEDESC, ORDERDATE, RECONVEY, DATA_SOURCE, BACKLOG, REPORT_DATE, LATEST_PASS_DATE, LATEST_FAIL_DATE, ASSIGNMENT ';
          SQL_STMT := SQL_STMT||' FROM SQA_ICC_assignment_template ';
          EXECUTE IMMEDIATE SQL_STMT;

          SQLROWCOUNT := SQL%ROWCOUNT;

          COMMIT;

         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'SQA_ICC_ASSIGNMENT_TEMP_HIST');
         COMMIT;



         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, 0, 'Process complete');
         COMMIT;


EXCEPTION
     WHEN OTHERS THEN
     SQLROWCOUNT := SQLCODE;
     MSG         := SQLERRM;

         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, MSG);
         COMMIT;


END;


------  SQA_LOVS.ICC_QC_ASSIGNMENT_PROD
PROCEDURE ICC_QC_ASSIGNMENT_PROD
IS

GC  GenRefCursor;
FD  EIM_FIPINT_DAILY_REC;
ID  EIM_INTICC_DAILY_REC;
IC  SQA_ICC_CARDS_REC;
PC  EIM_PROPERTY_CONVEY_COND_REC;
WR  EIM_WORKORDER_RECONVEY_REC;
LR  EIM_LOAN_RECONVEY_REC;
CL  EIM_OPEN_FHA_CLAIM_REC;
PL  SQA_ICC_PRIOR_LOAN_HIST_REC;

SQL_STMT        VARCHAR2(32000 BYTE);
SQLROWCOUNT     NUMBER;
MSG             VARCHAR2(32000 BYTE);
TODAY           DATE;
manual_control  number;

BEGIN

     TODAY := TRUNC(SYSDATE);


select VARIABLE_VALUE
into   manual_control
from SQA_SYS_VARIABLES
where VARIABLE_NAME  = 'ICC_MANUAL_FLAG';

IF ( manual_control = 1 )
   THEN
   select  to_date(VARIABLE_VALUE,'MM/DD/YYYY')
      into   TODAY
      from SQA_SYS_VARIABLES
      where VARIABLE_NAME  = 'ICC_REPORT_DATE';

END IF;



---- REMOVE TODAYS RUN IF WE RE-RAN for some reason

SQL_STMT := 'DELETE SQA_ICC_ASSIGNMENT_TEMP_HIST  WHERE REPORT_DATE = :H ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

SQL_STMT := 'DELETE EIM_WORKORDER_RECONVEY_HIST  WHERE REPORT_DATE = :W ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

SQL_STMT := 'DELETE EIM_LOAN_RECONVEY_HIST WHERE REPORT_DATE = :L ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

SQL_STMT := 'DELETE EIM_INTICC_HIST WHERE REPORT_DATE = :I ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

SQL_STMT := 'DELETE EIM_FIPINT_HIST WHERE REPORT_DATE = :F ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

SQL_STMT := 'DELETE SQA_ICC_CARDS_REPORT_HIST WHERE REPORT_DATE = :C ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

SQL_STMT := 'TRUNCATE TABLE SQA_ICC_ASSIGNMENT_TEMPLATE DROP STORAGE ';
EXECUTE IMMEDIATE SQL_STMT;
COMMIT;



SQLROWCOUNT := 0;

      INSERT INTO BOA_PROCESS_LOG
            (
              PROCESS,
              SUB_PROCESS,
              ENTRYDTE,
              ROWCOUNTS,
              MESSAGE
            )
     VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'Clear last run if needed');
     COMMIT;

insert into SQA_ICC_assignment_template (LOANNUMBER, CLIENTCODE, ORDERNUMBER, RECONVEYDATE, CONVEYSTATUS, SALEDATE, WORKCODEDESC, ORDERDATE, RECONVEY, DATA_SOURCE, BACKLOG, REPORT_DATE, LATEST_PASS_DATE, LATEST_FAIL_DATE, ASSIGNMENT)
SELECT  A.LOANNUMBER,
        A.CLIENTCODE,
        CL.ORDERNUMBER,
        CL.RECONVEYDATE,
        CL.CONVEYSTATUS,
        CL.SALEDATE,
        CL.WORKCODEDESC,
        CL.ORDERDATE,
        R.RECONVEY,
        A.DATA_SOURCE,
        Q.BACKLOG,
        TODAY AS REPORT_DATE,
 ps.ACTUAL_REVIEW_DATE as latest_pass_date,
 fl.ACTUAL_REVIEW_DATE as latest_fail_date,
 CASE WHEN Q.BACKLOG IS NOT NULL THEN 'NOT REVIEWED - Autocompleted Reverifies'
      when R.RECONVEY is not null and data_source in ('INTICC','FIPINT') THEN  'Assign - Reconvey INTICC Exception'
      WHEN R.RECONVEY is not null AND ps.ACTUAL_REVIEW_DATE IS NULL AND fl.ACTUAL_REVIEW_DATE IS NULL THEN  'Assign - RECONVEY'
      WHEN data_source in ('INTICC','FIPINT') THEN 'Assign - INTICC Exception'
      WHEN R.RECONVEY IS NOT NULL THEN 'Assign - RECONVEY'
      WHEN ps.ACTUAL_REVIEW_DATE IS NULL AND fl.ACTUAL_REVIEW_DATE IS NULL THEN 'Assign - New ICC'
      WHEN NVL(TO_NUMBER(to_char(fl.ACTUAL_REVIEW_DATE,'YYYYMMDD')),0) > NVL(TO_NUMBER(to_char(ps.ACTUAL_REVIEW_DATE,'YYYYMMDD')),0) THEN 'Assign - Failed Prior'
      WHEN (TODAY -  ps.ACTUAL_REVIEW_DATE) > 59 THEN  'Assign - Not Reviewed in 60 Days'
 ELSE  'NOT REVIEWED - Autocompleted Reverifies'
 END AS assignment
FROM (
SELECT R.LOANNUMBER,R.CLIENTCODE, R.DATA_SOURCE
 FROM ( SELECT LOANNUMBER,CLIENTCODE, DATA_SOURCE, RANK() OVER ( PARTITION BY LOANNUMBER,CLIENTCODE ORDER BY DATA_SOURCE DESC, ROWNUM) RK
 FROM(
 select  LOANNUMBER,CLIENTCODE, 'INTICC' AS DATA_SOURCE
 from inticc_daily_vw  where  COMPLETIONENTEREDDATE_FK  = to_number(to_char(TODAY,'MMDDYYYY'))
 UNION
 select  LOANNUMBER,"Client_Code" AS CLIENTCODE, 'FIPINT' AS DATA_SOURCE
 from fipint_daily_vw  where  COMPLETIONENTEREDDATE  = to_number(to_char(TODAY,'MMDDYYYY'))
 UNION
SELECT LOANNUMBER, CLIENTCODE,  'CARDS' AS DATA_SOURCE
 FROM cpropertyinconveycondtion_vw ))R
 WHERE R.RK = 1) A
------ claims
 LEFT JOIN ( select R.LOANNUMBER,R.ORDERNUMBER,R.CLIENTCODE,R.RECONVEYDATE,R.CONVEYSTATUS,R.SALEDATE,R.WORKCODEDESC,R.ORDERDATE
            FROM (
           select LOANNUMBER,ORDERNUMBER,CLIENTCODE,RECONVEYDATE,CONVEYSTATUS,SALEDATE,WORKCODEDESC,TO_DATE(ORDERDATE,'YYYYMMDD') ORDERDATE, RANK() OVER ( PARTITION BY LOANNUMBER, CLIENTCODE ORDER BY ROWNUM ) RK
            FROM open_fha_claim_vw )R
            WHERE R.RK = 1 ) CL  ON ( A.LOANNUMBER =  CL.LOANNUMBER AND A.CLIENTCODE = CL.CLIENTCODE)
------- latest pass
 LEFT JOIN ( SELECT  R.LOAN_NBR,R.CLIENT_CODE,R.OUTCOME,R.TRUE_OUTCOME, R.ACTUAL_REVIEW_DATE
             FROM (
             SELECT LOAN_NBR,CLIENT_CODE,OUTCOME,TRUE_OUTCOME, ACTUAL_REVIEW_DATE, RANK() OVER ( PARTITION BY LOAN_NBR, CLIENT_CODE ORDER BY ACTUAL_REVIEW_DATE DESC, ROWNUM) RK
               FROM SQA_ICC_PRIOR_LOAN_HISTORY  WHERE OUTCOME IN ('Pass') ) R
             WHERE R.RK = 1) Ps on ( ps.LOAN_NBR = A.LOANNUMBER AND ps.CLIENT_CODE = A.CLIENTCODE)
------ latest fail
 LEFT JOIN ( SELECT  R.LOAN_NBR,R.CLIENT_CODE,R.OUTCOME,R.TRUE_OUTCOME, R.ACTUAL_REVIEW_DATE
             FROM (
             SELECT LOAN_NBR,CLIENT_CODE,OUTCOME,TRUE_OUTCOME, ACTUAL_REVIEW_DATE, RANK() OVER ( PARTITION BY LOAN_NBR, CLIENT_CODE ORDER BY ACTUAL_REVIEW_DATE DESC, ROWNUM) RK
               FROM SQA_ICC_PRIOR_LOAN_HISTORY  WHERE OUTCOME IN ('Fail') ) R
             WHERE R.RK = 1) fl on ( fl.LOAN_NBR = A.LOANNUMBER AND fl.CLIENT_CODE = A.CLIENTCODE)
 LEFT JOIN ( SELECT U.LOANNUMBER, U.CLIENTCODE, 'RECONVEY' AS RECONVEY
             FROM (SELECT LOANNUMBER,CLIENTCODE
                     FROM workorder_reconvey_vw
                    UNION
                    SELECT LOANNUMBER,CLIENTCODE
                     FROM loan_reconvey_vw )U  ) R ON ( R.LOANNUMBER = A.LOANNUMBER AND R.CLIENTCODE = A.CLIENTCODE)
 LEFT JOIN ( SELECT LOANNUMBER, CLIENT,  REVIEWER AS BACKLOG  FROM SQA_ICC_BACKLOG  WHERE COMPLETED = 0 ) Q ON ( Q.LOANNUMBER = A.LOANNUMBER AND A.CLIENTCODE = Q.CLIENT);

       SQLROWCOUNT := SQL%ROWCOUNT;

       COMMIT;


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'SQA_ICC_assignment_template');
         COMMIT;

          INSERT INTO EIM_WORKORDER_RECONVEY_HIST (LOANNUMBER,CLIENTCODE,LOANTYPE,WORKCODE,ORDERNUMBER,REPORT_DATE)
          SELECT LOANNUMBER,CLIENTCODE,LOANTYPE,WORKCODE,ORDERNUMBER,TODAY AS REPORT_DATE
          FROM workorder_reconvey_vw;

           SQLROWCOUNT := SQL%ROWCOUNT;

           COMMIT;


            INSERT INTO BOA_PROCESS_LOG
                  (
                    PROCESS,
                    SUB_PROCESS,
                    ENTRYDTE,
                    ROWCOUNTS,
                    MESSAGE
                  )
           VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'EIM_WORKORDER_RECONVEY_HIST');
           COMMIT;



          INSERT INTO EIM_LOAN_RECONVEY_HIST ( LOANNUMBER, CLIENTCODE, LOANTYPE, CONVEYDATE, RECONVEYDATE, REPORT_DATE)
          SELECT  LOANNUMBER, CLIENTCODE, LOANTYPE, CONVEYDATE, RECONVEYDATE, TODAY AS REPORT_DATE
          FROM loan_reconvey_vw;

           SQLROWCOUNT := SQL%ROWCOUNT;

           COMMIT;


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'EIM_LOAN_RECONVEY_HIST');
         COMMIT;

          INSERT INTO EIM_INTICC_HIST(LOANNUMBER, ORDERNUMBER, WORKCODE, CLIENTCODE, COMPLETIONENTEREDDATE_FK, COMPLETEDDATE_FK, SALEDATE, ISPOOLSECURE, ISHOTTUBSECURE, SUMPPUMP, ISSUMPPUMPOPERATIONAL, DEHUMIDIFIER, ISDEHUMIDIFIEROPERATIONAL, GARAGESECURE, OUTBUILDINGSECURE, CRAWLSPACESECURE, GRASSHEIGHT, PROPERTYSECURE, NEWDAMAGE, SEVEREDAMAGE, ISROOFTARPED, ACTIVEROOFLEAK, ACUNIT, ANTIFREEZEINALL, GAINACCESS, OCCUPANCYSTATUS, LOANTYPE, REPORT_DATE )
          SELECT LOANNUMBER, ORDERNUMBER, WORKCODE, CLIENTCODE, COMPLETIONENTEREDDATE_FK, COMPLETEDDATE_FK, SALEDATE, ISPOOLSECURE, ISHOTTUBSECURE, SUMPPUMP, ISSUMPPUMPOPERATIONAL, DEHUMIDIFIER, ISDEHUMIDIFIEROPERATIONAL, GARAGESECURE, OUTBUILDINGSECURE, CRAWLSPACESECURE, GRASSHEIGHT, PROPERTYSECURE, NEWDAMAGE, SEVEREDAMAGE, ISROOFTARPED, ACTIVEROOFLEAK, ACUNIT, ANTIFREEZEINALL, GAINACCESS, OCCUPANCYSTATUS, LOANTYPE, TODAY AS REPORT_DATE
          FROM inticc_daily_vw;

         SQLROWCOUNT := SQL%ROWCOUNT;

         COMMIT;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'EIM_INTICC_HIST');
         COMMIT;


          INSERT INTO EIM_FIPINT_HIST (LOANNUMBER, ORDERNUMBER, WORKCODE, CLIENT_CODE, COMPLETIONENTEREDDATE, COMPLETEDDATE, SALEDATE, ISPOOLSECURE, ISHOTTUBSECURE, SUMPPUMP, ISSUMPPUMPOPERATIONAL, DEHUMIDIFIER, ISDEHUMIDIFIEROPERATIONAL, GARAGESECURE, OUTBUILDINGSECURE, CRAWLSPACESECURE, GRASSHEIGHT, PROPERTYSECURE, NEWDAMAGE, SEVEREDAMAGE, ISROOFTARPED, ACTIVEROOFLEAK, ACUNIT, ANTIFREEZEINALL, GAINACCESS, OCCUPANCYSTATUS, LOANTYPE, FLOOD, MOLD, ROOFLEAK, VANDALISM, PERSONALPROPERTY, DEBRIS, CITATION, CONVEYDATE, CURRENTICCSTATUS, REPORT_DATE)
          SELECT LOANNUMBER, ORDERNUMBER, WORKCODE, "Client_Code", COMPLETIONENTEREDDATE, COMPLETEDDATE, SALEDATE, ISPOOLSECURE, ISHOTTUBSECURE, SUMPPUMP, ISSUMPPUMPOPERATIONAL, DEHUMIDIFIER, ISDEHUMIDIFIEROPERATIONAL, GARAGESECURE, OUTBUILDINGSECURE, CRAWLSPACESECURE, GRASSHEIGHT, PROPERTYSECURE, NEWDAMAGE, SEVEREDAMAGE, ISROOFTARPED, ACTIVEROOFLEAK, ACUNIT, ANTIFREEZEINALL, GAINACCESS, OCCUPANCYSTATUS, LOANTYPE, FLOOD, MOLD, ROOFLEAK, VANDALISM, PERSONALPROPERTY, DEBRIS, CITATION, CONVEYDATE, CURRENTICCSTATUS, TODAY AS REPORT_DATE
          FROM fipint_daily_vw;

          SQLROWCOUNT := SQL%ROWCOUNT;

          COMMIT;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'EIM_FIPINT_HIST');
         COMMIT;


         INSERT INTO SQA_ICC_CARDS_REPORT_HIST (LOAN,
                                                MORT_NAME,
                                                ADDRESS_LINE1,
                                                ADDRESS_LINE2,
                                                CITY,
                                                STATE,
                                                ZIP,
                                                SALE_DT,
                                                SECURED_DT,
                                                WINTERIZED_DT,
                                                INITIAL_ICC_DT,
                                                REPORTED_ICC_DT,
                                                COMPLETED_ICC_DT,
                                                CONVEY_DATE,
                                                INVESTOR,
                                                CLIENT,
                                                REPORT_DATE)
         select LOANNUMBER,MORTGAGORNAME,PROPERTYADDRESSLINE1,PROPERTYADDRESSLINE2,PROPERTYADDRESSCITY, PROPERTYADDRESSSTATE, PROPERTYADDRESSZIP, SALEDATE, SECUREDDATE, WINTERIZEDDATE,INITIALICCDATE, LASTREPORTEDICCDATE, LASTICCDATE,CONVEYDATE,INVESTORNUMBER, CLIENTNAME, TODAY AS REPORT_DATE
         from cpropertyinconveycondtion_vw;

          SQLROWCOUNT := SQL%ROWCOUNT;

          COMMIT;

         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'SQA_ICC_CARDS_REPORT_HIST');
         COMMIT;




          SQL_STMT := ' insert into SQA_ICC_ASSIGNMENT_TEMP_HIST (LOANNUMBER, CLIENTCODE, ORDERNUMBER, RECONVEYDATE, CONVEYSTATUS, SALEDATE, WORKCODEDESC, ORDERDATE, RECONVEY, DATA_SOURCE, BACKLOG, REPORT_DATE, LATEST_PASS_DATE, LATEST_FAIL_DATE, ASSIGNMENT) ';
          SQL_STMT := SQL_STMT||' SELECT LOANNUMBER, CLIENTCODE, ORDERNUMBER, RECONVEYDATE, CONVEYSTATUS, SALEDATE, WORKCODEDESC, ORDERDATE, RECONVEY, DATA_SOURCE, BACKLOG, REPORT_DATE, LATEST_PASS_DATE, LATEST_FAIL_DATE, ASSIGNMENT ';
          SQL_STMT := SQL_STMT||' FROM SQA_ICC_assignment_template ';
          EXECUTE IMMEDIATE SQL_STMT;

          SQLROWCOUNT := SQL%ROWCOUNT;

          COMMIT;

         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, 'SQA_ICC_ASSIGNMENT_TEMP_HIST');
         COMMIT;



                delete SQA_ICC_PRIOR_LOAN_HISTORY h
                where exists ( select 1
                               from (select  B.PID
                                    from SQA_ICC_assignment_template A
                                        left join ( select PID, client, loannumber
                                              from sqa_icc_backlog
                                              WHERE COMPLETED = 0 ) B ON ( B.LOANNUMBER = A.LOANNUMBER AND B.CLIENT = A.CLIENTCODE )
                                              where A.assignment like  'NOT REVIEWED%') c
                                              where c.pid = h.pid);
                SQLROWCOUNT := SQL%ROWCOUNT;

                commit;


         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, ' Clear SQA_ICC_PRIOR_LOAN_HISTORY');
         COMMIT;



                insert into SQA_ICC_PRIOR_LOAN_HISTORY ( PID,LOAN_NBR,CLIENT_CODE,REVIEWED_BY,OUTCOME,ICC_DECISION, CASIS_ALL_ICC, DATE_UPLOADED, DATE_TO_REVIEW,ACTUAL_REVIEW_DATE,DISPUTE,NBR_IMP,NBR_REVERSALS)
                select  B.PID, b.loannumber,b.client, b.reviewer, a.assignment, 'N/A', 'N/A', B.DATE_UPLOADED, B.DATE_TO_REVIEW, B.DATE_TO_REVIEW, 'FALSE',0,0
                from SQA_ICC_assignment_template A
                left join ( select   PID,
                                     LOANNUMBER,
                                     CLIENT,
                                     REVIEWER,
                                     CAR_PROCESSOR,
                                     DATE_UPLOADED,
                                     DATE_TO_REVIEW
                              from sqa_icc_backlog
                              WHERE COMPLETED = 0 ) B ON ( B.LOANNUMBER = A.LOANNUMBER AND B.CLIENT = A.CLIENTCODE )
                where A.assignment like  'NOT REVIEWED%';

                SQLROWCOUNT := SQL%ROWCOUNT;

                commit;


                 INSERT INTO BOA_PROCESS_LOG
                        (
                          PROCESS,
                          SUB_PROCESS,
                          ENTRYDTE,
                          ROWCOUNTS,
                          MESSAGE
                        )
                 VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, ' add not Reviewed to SQA_ICC_PRIOR_LOAN_HISTORY');
                 COMMIT;



         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, 0, 'Process complete');
         COMMIT;


EXCEPTION
     WHEN OTHERS THEN
     SQLROWCOUNT := SQLCODE;
     MSG         := SQLERRM;

         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_QC_ASSIGNMENT',SYSDATE, SQLROWCOUNT, MSG);
         COMMIT;


END;
/*********************************************************************

 **********************************************************************/
PROCEDURE ICC_MANAGE_WORKLOAD
(
PAPP_ID       NUMBER,
PPAGE_ID      NUMBER,
PREPORT_NAME  VARCHAR2,
PAPPL_USER    VARCHAR2,
PASSIGN_TO    VARCHAR2,
PLIMIT        VARCHAR2
)
IS

CURSOR C1( P_APPL_ID NUMBER, P_PAGE_ID NUMBER, P_APP_USER VARCHAR2, P_REPORT_NAME VARCHAR2)
IS
SELECT  A.REPORT_ID,
        A.REPORT_NAME,
        A.APPLICATION_USER,
        A.CONDITION_COLUMN_NAME,
        a.CONDITION_OPERATOR,
        a.CONDITION_EXPR_TYPE,
        a.CONDITION_EXPRESSION,
        a.CONDITION_EXPRESSION2,
        a.CONDITION_SQL,
        a.LAST_UPDATED_ON
from APEX_APPLICATION_PAGE_IR_COND A
left join (SELECT L.REPORT_ID
           FROM (select report_id, LAST_UPDATED_ON
                   from APEX_APPLICATION_PAGE_IR_COND
                  WHERE APPLICATION_ID  = P_APPL_ID
                   AND PAGE_ID          = P_PAGE_ID
                   AND APPLICATION_USER = P_APP_USER
                   AND REPORT_NAME      = P_REPORT_NAME
                   ORDER BY LAST_UPDATED_ON DESC) L
                   WHERE ROWNUM = 1) B ON ( A.REPORT_ID = B.REPORT_ID)
WHERE A.REPORT_ID = B.REPORT_ID;

R1   C1%ROWTYPE;

MSG           VARCHAR2(1000 BYTE);
SQL_STMT      VARCHAR2(32000 BYTE);
WHERE_STMT    VARCHAR2(32000 BYTE);
CASE_STMT     VARCHAR2(1000 BYTE);
NBR_TO_DEAL   NUMBER;
NBR_DEALT     NUMBER;
RECORDCNT     NUMBER;
RCODE         NUMBER;
ARRAYSIZE     PLS_INTEGER;
BAD_DATA      EXCEPTION;

--TYPE SQA_ICC_ASSIGNMENT_TEMP IS RECORD
--(
--   LOAN_NUMBER           DBMS_SQL.VARCHAR2_TABLE,
--   CLIENTCODE            DBMS_SQL.VARCHAR2_TABLE,
--   BACKLOG               DBMS_SQL.VARCHAR2_TABLE,
--   ROWIDS                rowidArray
--);

CAT         SQA_LOVS.SQA_ICC_ASSIGNMENT_TEMP;
GC          SQA_LOVS.genrefcursor;


REVIEWERS   apex_application_global.vc_arr2;

BEGIN

         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_MANAGE_WORKLOAD',SYSDATE, 0, 'STARTING..');
         COMMIT;



-------------- DEAL OUT TO REVIEWERS HOW MANY TO SPLIT BY

REVIEWERS    := apex_util.string_to_table (PASSIGN_TO);

ARRAYSIZE   := REVIEWERS.COUNT;

NBR_TO_DEAL := REVIEWERS.COUNT;


RECORDCNT := CASE WHEN UPPER(PLIMIT) = 'ALL' THEN 100000
                  ELSE TO_NUMBER(PLIMIT)
             END;

IF ( PREPORT_NAME IS NULL )
   THEN
    MSG := 'NO REPORT NAME WAS GIVEN';
    RAISE BAD_DATA;
END IF;



 OPEN C1(PAPP_ID, PPAGE_ID, PAPPL_USER, PREPORT_NAME);

      WHERE_STMT := ' WHERE ';

         LOOP
              FETCH C1 INTO R1;
              EXIT WHEN C1%NOTFOUND;
               CASE_STMT := CASE  WHEN UPPER(R1.CONDITION_OPERATOR) IN ('IN') THEN R1.CONDITION_COLUMN_NAME||' IN  ('''||REPLACE(R1.CONDITION_EXPRESSION,',',''',''')||''') '
                                  ELSE REPLACE( REPLACE( REPLACE(R1.CONDITION_SQL,'"','') ,'#',''''),'APXWS_EXPR',R1.CONDITION_EXPRESSION)
                             END;

               WHERE_STMT :=  WHERE_STMT||CASE_STMT||' AND ';

         END LOOP;

      CLOSE C1;

       WHERE_STMT := RTRIM(WHERE_STMT,' AND ');

       SQL_STMT := ' SELECT LOANNUMBER, BACKLOG, CLIENTCODE,  ROWID  FROM  SQA_ICC_ASSIGNMENT_TEMPLATE '||WHERE_STMT;

--INSERT INTO SHOW_STMT
--VALUES (NBR_TO_DEAL);

--COMMIT;

NBR_DEALT   := 1;

OPEN GC FOR SQL_STMT;
        FETCH GC BULK COLLECT INTO cat.LOAN_NUMBER, cat.backlog, cat.CLIENTCODE, cat.ROWIDS LIMIT RECORDCNT;
CLOSE GC;


      ---- OK THE UNIVERSE IS SET
       ---- all to one person?
       IF (NBR_TO_DEAL = 1)
          THEN
              FOR k in 1..CAT.LOAN_NUMBER.COUNT LOOP

                   EXECUTE IMMEDIATE ' UPDATE SQA_ICC_ASSIGNMENT_TEMPLATE SET BACKLOG = :A  WHERE ROWID = :B '  USING REVIEWERS(NBR_TO_DEAL), cat.rowids(k);
              END LOOP;
       ELSE

              for k in 1..cat.loan_number.count loop

              ------------ IF WE RUN OUT OF PEOPLE TO DEAL TO
              ------------- START THE NEXT ROUND  52 CARDS 4 PEOPLE = 13 CARDS EACH

                             if ( NBR_DEALT  >  NBR_TO_DEAL) then
                                  NBR_DEALT := 1;
                             END IF;

                            cat.backlog(k) := REVIEWERS(NBR_DEALT);

--                            INSERT INTO SHOW_STMT
--                            VALUES (REVIEWERS(NBR_DEALT));

                            NBR_DEALT := NBR_DEALT + 1;

              end loop;

             ----- NOW that the deck is dealt out Post the assignments

                   for x in 1..cat.loan_number.count loop

                       execute immediate ' UPDATE SQA_ICC_ASSIGNMENT_TEMPLATE SET BACKLOG = :a where rowid = :b ' USING cat.backlog(x), cat.ROWIDS(x);

                   end loop;

                  commit;
       END IF;


      COMMIT;

         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_MANAGE_WORKLOAD',SYSDATE, 0, 'Completed..');
         COMMIT;

EXCEPTION
       WHEN BAD_DATA THEN
         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_MANAGE_WORKLOAD',SYSDATE, 0, MSG);
         COMMIT;

       WHEN OTHERS THEN
         msg   := sqlerrm;
         rcode := sqlcode;
         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_MANAGE_WORKLOAD',SYSDATE, rcode, MSG);
         COMMIT;


END;

/************************************************************
SQA_LOVS.QAP_ICC_REVIEWS( P643_PID, P643_DID_QC_PASS, P643_COMMENTS)
 ***********************************************************/
PROCEDURE QAP_ICC_REVIEWS
(
P643_PID         NUMBER,
P643_DID_QC_PASS VARCHAR2,
P643_COMMENTS    VARCHAR2
)

IS


MSG         VARCHAR2(1000 BYTE);
RCODE       NUMBER;
SQLROWCOUNT NUMBER;
NBR_IMP     NUMBER;
STATES      VARCHAR2(30 BYTE);
CASENO      VARCHAR2(100 BYTE);

FUNCTION HOW_MANY_COMPLETE ( PPID NUMBER) RETURN NUMBER
IS
RET_NUMBER    NUMBER;
P_LOANNUMBER  VARCHAR2(40 BYTE);
P_CLIENTCODE  VARCHAR2(40 BYTE);
BEGIN

SELECT LOANNUMBER,   CLIENT
INTO   P_LOANNUMBER, P_CLIENTCODE
FROM SQA_ICC_BACKLOG
WHERE PID = PPID;

SELECT COUNT(*)
INTO RET_NUMBER
FROM SQA_ICC_BACKLOG
WHERE LOANNUMBER = P_LOANNUMBER
 AND  CLIENT = P_CLIENTCODE
 AND  COMPLETED  > 0;

RETURN RET_NUMBER + 1;


END;
/*******************************************
   AND WE'RE OFF
 *******************************************/
begin


insert into SQA_ICC_PRIOR_LOAN_HISTORY
(
PID,
LOAN_NBR,
CLIENT_CODE,
REVIEWED_BY,
OUTCOME,
COMMENTS,
ICC_DECISION,
DATE_UPLOADED,
DATE_TO_REVIEW,
ACTUAL_REVIEW_DATE,
DISPUTE,
NBR_IMP,
CAR_ASSIGNED,
CASE_NBR
)
SELECT A.PID,
       A.LOANNUMBER,
       A.CLIENT,
       A.REVIEWER,
       P643_DID_QC_PASS,
       P643_COMMENTS,
       P643_DID_QC_PASS,
       A.DATE_UPLOADED,
       A.DATE_TO_REVIEW,
       SYSDATE,
       'FALSE',
       I.NBR_IMP,
       A.CAR_PROCESSOR,
       C.WORKCODEDESC
FROM ICC_QC_REVIEW_DETAIL_VW A
LEFT JOIN ( SELECT  CL.WORKCODEDESC, CL.LOANNUMBER, CL.CLIENTCODE, CL.ORDERDATE
            FROM ( SELECT  WORKCODEDESC, LOANNUMBER, CLIENTCODE, ORDERDATE
                     FROM EIM_OPEN_FHA_CLAIM ORDER BY ORDERDATE DESC ) CL
           WHERE ROWNUM = 1) C ON (  C.LOANNUMBER = A.LOANNUMBER AND C.CLIENTCODE = A.CLIENT)
left join ( SELECT master_id, COUNT(*) NBR_IMP
              FROM  SQA_ICC_IMPEDIMENTS
              group by master_id ) i on (i.master_id = a.pid)
WHERE A.PID = P643_PID;
SQLROWCOUNT := SQL%ROWCOUNT;

COMMIT;


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'QAP_ICC_REVIEWS',SYSDATE, SQLROWCOUNT, 'ADD TO HISTORY');
    COMMIT;




SQLROWCOUNT  := HOW_MANY_COMPLETE (P643_PID);

    UPDATE SQA_ICC_BACKLOG
       SET COMPLETED = SQLROWCOUNT, DATE_TO_REVIEW = TRUNC(SYSDATE)
     WHERE PID = P643_PID;

COMMIT;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'QAP_ICC_REVIEWS',SYSDATE, SQLROWCOUNT, 'CLOSED BACKLOG');
    COMMIT;



EXCEPTION
     WHEN OTHERS THEN
     RCODE := SQLCODE;
     MSG   := SQLERRM;

          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
    VALUES ( 'SQA_LOVS', 'QAP_ICC_REVIEWS',SYSDATE, RCODE, MSG);
    COMMIT;


END;

/*********************************************************************
     sqa_lovs
 **********************************************************************/
PROCEDURE ICC_REASSIGN_WORKLOAD
(
PAPP_ID       NUMBER,
PPAGE_ID      NUMBER,
PREPORT_NAME  VARCHAR2,
PAPPL_USER    VARCHAR2,
PASSIGN_FROM  VARCHAR2,
PASSIGN_TO    VARCHAR2,
PLIMIT        VARCHAR2
)
IS

CURSOR C1( P_APPL_ID NUMBER, P_PAGE_ID NUMBER, P_APP_USER VARCHAR2, P_REPORT_NAME VARCHAR2)
IS
SELECT  A.REPORT_ID,
        A.REPORT_NAME,
        A.APPLICATION_USER,
        A.CONDITION_COLUMN_NAME,
        a.CONDITION_OPERATOR,
        a.CONDITION_EXPR_TYPE,
        a.CONDITION_EXPRESSION,
        a.CONDITION_EXPRESSION2,
        a.CONDITION_SQL,
        a.LAST_UPDATED_ON
from APEX_APPLICATION_PAGE_IR_COND A
left join (SELECT L.REPORT_ID
           FROM (select report_id, LAST_UPDATED_ON
                   from APEX_APPLICATION_PAGE_IR_COND
                  WHERE APPLICATION_ID  = P_APPL_ID
                   AND PAGE_ID          = P_PAGE_ID
                   AND APPLICATION_USER = P_APP_USER
                   AND REPORT_NAME      = P_REPORT_NAME
                   ORDER BY LAST_UPDATED_ON DESC) L
                   WHERE ROWNUM = 1) B ON ( A.REPORT_ID = B.REPORT_ID)
WHERE A.REPORT_ID = B.REPORT_ID;

R1   C1%ROWTYPE;

MSG                  VARCHAR2(1000 BYTE);
CASE_STMT            VARCHAR2(1000 BYTE);
SQL_STMT_TO          VARCHAR2(32000 BYTE);
SQL_STMT_FROM        VARCHAR2(32000 BYTE);
WHERE_TO_STMT        VARCHAR2(32000 BYTE);
WHERE_FROM_STMT      VARCHAR2(32000 BYTE);
IN_FROM_STMT         VARCHAR2(32000 BYTE);
IN_TO_STMT           VARCHAR2(32000 BYTE);

RECORDCNT_FROM       NUMBER;
RECORDCNT_TO         NUMBER;
RECORDCNT            NUMBER;
RCODE                NUMBER;

ARRAYSIZE_FROM    PLS_INTEGER;
ARRAYSIZE_TO      PLS_INTEGER;

--TYPE SQA_ICC_ASSIGNMENT_TEMP IS RECORD
--(
--   LOAN_NUMBER           DBMS_SQL.VARCHAR2_TABLE,
--   CLIENTCODE            DBMS_SQL.VARCHAR2_TABLE,
--   BACKLOG               DBMS_SQL.VARCHAR2_TABLE,
--   ROWIDS                rowidArray
--);

FL           SQA_LOVS.ICC_BACKLOG_LIST;
TL           SQA_LOVS.ICC_BACKLOG_LIST;

GC           SQA_LOVS.genrefcursor;


FROM_ANALYST   apex_application_global.vc_arr2;
TO_ANALYST     apex_application_global.vc_arr2;


BEGIN

         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_REASSIGN_WORKLOAD',SYSDATE, 0, 'STARTING..');
         COMMIT;




-------------- DEAL OUT THE WORK
----
FROM_ANALYST := apex_util.string_to_table (PASSIGN_FROM);
---- who are you assigning this to
TO_ANALYST   := apex_util.string_to_table (PASSIGN_TO);

--- for the in statement
ARRAYSIZE_FROM := FROM_ANALYST.COUNT;
--- how many to assign to
ARRAYSIZE_TO   := TO_ANALYST.COUNT;
RECORDCNT_TO   := 1;
/*******************************************
  PULL RECORDS FROM ANALYST add to where clause
  incase there is no other criteria
********************************************/
IN_FROM_STMT := '(';

FOR F in 1..FROM_ANALYST.count LOOP
        IN_FROM_STMT := IN_FROM_STMT||''''||FROM_ANALYST(f)||''',';

END LOOP;

IN_FROM_STMT := RTRIM(IN_FROM_STMT,',')||')';

/************************************************************/



------------- is there limit of how many to assign

RECORDCNT_FROM := CASE WHEN UPPER(NVL(PLIMIT,'ALL')) = 'ALL' THEN 100000
                   ELSE TO_NUMBER(PLIMIT)
             END;

 WHERE_FROM_STMT := ' WHERE REVIEWER IN '||IN_FROM_STMT;

---------- create additional filters

IF ( PREPORT_NAME IS NOT NULL )
   THEN
       OPEN C1(PAPP_ID, PPAGE_ID, PAPPL_USER, PREPORT_NAME);

         LOOP
              FETCH C1 INTO R1;
              EXIT WHEN C1%NOTFOUND;

               CASE_STMT := CASE  WHEN UPPER(R1.CONDITION_OPERATOR) IN ('IN') THEN R1.CONDITION_COLUMN_NAME||' IN  ('''||REPLACE(R1.CONDITION_EXPRESSION,',',''',''')||''') '
                                  ELSE REPLACE( REPLACE( REPLACE(R1.CONDITION_SQL,'"','') ,'#',''''),'APXWS_EXPR',R1.CONDITION_EXPRESSION)
                             END;

               WHERE_FROM_STMT :=  WHERE_FROM_STMT||CASE_STMT||' AND ';

         END LOOP;

      CLOSE C1;

      WHERE_FROM_STMT := RTRIM(WHERE_FROM_STMT,' AND ');


END IF;

---------- pull the data to reassign

      SQL_STMT_FROM := ' SELECT LOANNUMBER, CLIENT, REVIEWER, CAR_PROCESSOR, DATE_UPLOADED, DATE_TO_REVIEW, PICK_ORDER, ROWID FROM SQA_ICC_BACKLOG '||WHERE_FROM_STMT;

      OPEN GC FOR SQL_STMT_FROM;
          FETCH GC BULK COLLECT INTO FL.LOANNUMBER, FL.CLIENT, FL.REVIEWER, FL.CAR_PROCESSOR, FL.DATE_UPLOADED, FL.DATE_TO_REVIEW, FL.PICK_ORDER, FL.ROWIDS LIMIT RECORDCNT_FROM;
      CLOSE GC;

---- start dealing out

      for k in 1..fl.loannumber.count loop

          if ( RECORDCNT_TO  >  ARRAYSIZE_TO) then
               RECORDCNT_TO := 1;
          end if;
               fl.reviewer(k) := TO_ANALYST(RECORDCNT_TO);
               RECORDCNT_TO := RECORDCNT_TO + 1;
      end loop;


      for x in 1..fl.loannumber.count loop

          execute immediate ' UPDATE SQA_ICC_BACKLOG SET REVIEWER = :a where rowid = :b ' USING FL.REVIEWER(x), fl.ROWIDS(x);

      end loop;

      commit;

         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_REASSIGN_WORKLOAD',SYSDATE, 0, 'Completed..');
         COMMIT;

EXCEPTION
       WHEN OTHERS THEN
         msg   := sqlerrm;
         rcode := sqlcode;
         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_REASSIGN_WORKLOAD',SYSDATE, rcode, MSG);
         COMMIT;


END;

/**********************************************************************



 *********************************************************************/

PROCEDURE ICC_MERGE_TEMP_TO_BACKLOG
(
PAPP_ID       NUMBER,
PPAGE_ID      NUMBER,
PREPORT_NAME  VARCHAR2,
PAPPL_USER    VARCHAR2
)

IS

CURSOR C1( P_APPL_ID NUMBER, P_PAGE_ID NUMBER, P_APP_USER VARCHAR2, P_REPORT_NAME VARCHAR2)
IS
SELECT  A.REPORT_ID,
        A.REPORT_NAME,
        A.APPLICATION_USER,
        A.CONDITION_COLUMN_NAME,
        a.CONDITION_OPERATOR,
        a.CONDITION_EXPR_TYPE,
        a.CONDITION_EXPRESSION,
        a.CONDITION_EXPRESSION2,
        a.CONDITION_SQL,
        a.LAST_UPDATED_ON
from APEX_APPLICATION_PAGE_IR_COND A
left join (SELECT L.REPORT_ID
           FROM (select report_id, LAST_UPDATED_ON
                   from APEX_APPLICATION_PAGE_IR_COND
                  WHERE APPLICATION_ID  = P_APPL_ID
                   AND PAGE_ID          = P_PAGE_ID
                   AND APPLICATION_USER = P_APP_USER
                   AND REPORT_NAME      = P_REPORT_NAME
                   ORDER BY LAST_UPDATED_ON DESC) L
                   WHERE ROWNUM = 1) B ON ( A.REPORT_ID = B.REPORT_ID)
WHERE A.REPORT_ID = B.REPORT_ID;

R1   C1%ROWTYPE;

MSG           VARCHAR2(1000 BYTE);
SQL_STMT      VARCHAR2(32000 BYTE);
WHERE_STMT    VARCHAR2(32000 BYTE);
CASE_STMT     VARCHAR2(1000 BYTE);
BACK_STMT     VARCHAR2(32000 BYTE);

RECORDCNT     NUMBER;
RCODE         NUMBER;

ARRAYSIZE     PLS_INTEGER;
BAD_DATA      EXCEPTION;

PT          SQA_LOVS.SQA_ICC_ASSIGNMENT_TEMP;
BT          SQA_LOVS.ICC_BACKLOG_LIST;
GC          SQA_LOVS.genrefcursor;


/*
TYPE SQA_ICC_ASSIGNMENT_TEMP IS RECORD
(
   LOAN_NUMBER           DBMS_SQL.VARCHAR2_TABLE,
   CLIENTCODE            DBMS_SQL.VARCHAR2_TABLE,
   BACKLOG               DBMS_SQL.VARCHAR2_TABLE,
   ROWIDS                rowidArray
);


TYPE ICC_BACKLOG_LIST IS RECORD
(
   LOANNUMBER            DBMS_SQL.VARCHAR2_TABLE,
   CLIENT                DBMS_SQL.VARCHAR2_TABLE,
   REVIEWER              DBMS_SQL.VARCHAR2_TABLE,
   CAR_PROCESSOR         DBMS_SQL.VARCHAR2_TABLE,
   DATE_UPLOADED         DBMS_SQL.DATE_TABLE,
   DATE_TO_REVIEW        DBMS_SQL.DATE_TABLE,
   PICK_ORDER            DBMS_SQL.NUMBER_TABLE,
   ROWIDS                rowidArray
);
*/


BEGIN

         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_MERGE_TEMP_TO_BACKLOG',SYSDATE, 0, 'STARTING..');
         COMMIT;



IF ( PREPORT_NAME IS NULL )
   THEN
    MSG := 'NO REPORT NAME WAS GIVEN';
    RAISE BAD_DATA;
END IF;



  OPEN C1(PAPP_ID, PPAGE_ID, PAPPL_USER, PREPORT_NAME);

       WHERE_STMT := ' WHERE ';

         LOOP
              FETCH C1 INTO R1;
              EXIT WHEN C1%NOTFOUND;
               CASE_STMT := CASE  WHEN UPPER(R1.CONDITION_OPERATOR) IN ('IN') THEN R1.CONDITION_COLUMN_NAME||' IN  ('''||REPLACE(R1.CONDITION_EXPRESSION,',',''',''')||''') '
                                  ELSE REPLACE( REPLACE( REPLACE(R1.CONDITION_SQL,'"','') ,'#',''''),'APXWS_EXPR',R1.CONDITION_EXPRESSION)
                             END;

               WHERE_STMT :=  WHERE_STMT||CASE_STMT||' AND ';

         END LOOP;

  CLOSE C1;

        WHERE_STMT := WHERE_STMT ||' BACKLOG IS NOT NULL ';


        SQL_STMT := ' SELECT  A.LOANNUMBER, A.CLIENT, B.BACKLOG, A.CAR_PROCESSOR, A.DATE_UPLOADED, A.DATE_TO_REVIEW,  A.PICK_ORDER, A.ROWID FROM SQA_ICC_BACKLOG A';
        SQL_STMT := SQL_STMT||'  LEFT JOIN (SELECT LOANNUMBER, BACKLOG, CLIENTCODE  FROM  SQA_ICC_ASSIGNMENT_TEMPLATE '||WHERE_STMT||' ) B ON (A.LOANNUMBER = B.LOANNUMBER AND A.CLIENT = B.CLIENTCODE) ';
        SQL_STMT := SQL_STMT||'  WHERE A.LOANNUMBER = B.LOANNUMBER  ';
        SQL_STMT := SQL_STMT||'    AND A.CLIENT     = B.CLIENTCODE ';
        SQL_STMT := SQL_STMT||'    AND nvl(A.COMPLETED,0)  = 0 ';


--        insert into show_stmt
--        values (SQL_STMT);

--        COMMIT;


        OPEN GC FOR SQL_STMT;
                FETCH GC BULK COLLECT INTO bt.LOANNUMBER, bt.CLIENT, bt.REVIEWER, bt.CAR_PROCESSOR, bt.DATE_UPLOADED, bt.DATE_TO_REVIEW,  bt.PICK_ORDER,  bt.ROWIDS;
        CLOSE GC;

        for y in 1..bt.loannumber.count loop
              execute immediate ' UPDATE SQA_ICC_BACKLOG SET REVIEWER = :A, DATE_TO_REVIEW  = :B WHERE ROWID = :C ' USING bt.reviewer(y), SYSDATE, bt.rowids(y);

        end loop;


        commit;


/*
TYPE SQA_ICC_ASSIGNMENT_TEMP IS RECORD
(
   LOAN_NUMBER           DBMS_SQL.VARCHAR2_TABLE,
   CLIENTCODE            DBMS_SQL.VARCHAR2_TABLE,
   BACKLOG               DBMS_SQL.VARCHAR2_TABLE,
   ROWIDS                rowidArray
);
*/

        SQL_STMT := ' SELECT A.LOANNUMBER, A.CLIENTCODE, A.BACKLOG, A.DATA_SOURCE, A.REPORT_DATE, A.REPORT_DATE, 0 AS PICK_ORDER, A.ROWID  FROM  SQA_ICC_ASSIGNMENT_TEMPLATE A';
        SQL_STMT := SQL_STMT||'  LEFT JOIN (SELECT LOANNUMBER, CLIENT  FROM  SQA_ICC_BACKLOG  WHERE  NVL(COMPLETED,0) = 0 ) B ON (A.LOANNUMBER = B.LOANNUMBER AND A.CLIENTCODE = B.CLIENT) ';
        SQL_STMT := SQL_STMT||'  '||WHERE_STMT||' ';
        SQL_STMT := SQL_STMT||'  AND B.LOANNUMBER  IS NULL ';


--        insert into show_stmt
--        values (SQL_STMT);

--        COMMIT;



        OPEN GC FOR SQL_STMT;
                FETCH GC BULK COLLECT INTO bt.LOANNUMBER, bt.CLIENT, bt.REVIEWER, bt.CAR_PROCESSOR, bt.DATE_UPLOADED, bt.DATE_TO_REVIEW,  bt.PICK_ORDER,  bt.ROWIDS;
        CLOSE GC;

        for x in 1..bt.loannumber.count loop
              BEGIN

                      INSERT INTO SQA_ICC_BACKLOG ( LOANNUMBER, CLIENT, REVIEWER, CAR_PROCESSOR, DATE_UPLOADED, DATE_TO_REVIEW, PICK_ORDER, COMPLETED)
                       VALUES (bt.LOANNUMBER(x), bt.CLIENT(x), bt.REVIEWER(x), bt.CAR_PROCESSOR(x), SYSDATE , TRUNC(SYSDATE),  bt.PICK_ORDER(x), 0);
                       COMMIT;
              EXCEPTION
                     WHEN OTHERS THEN
                     NULL;
              END;
        end loop;


        commit;



         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_MERGE_TEMP_TO_BACKLOG',SYSDATE, 0, 'Completed..');
         COMMIT;


EXCEPTION
       WHEN BAD_DATA THEN
         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_MERGE_TEMP_TO_BACKLOG',SYSDATE, 0, MSG);
         COMMIT;

       WHEN OTHERS THEN
         msg   := sqlerrm;
         rcode := sqlcode;
         INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'ICC_MERGE_TEMP_TO_BACKLOG',SYSDATE, rcode, MSG);
         COMMIT;


END;

/*****************************************************************************************
  PARM IS FILE TYPE # 2

 *****************************************************************************************/
PROCEDURE LOAD_QAPP_PROJECT_FILES (P_FILE_type NUMBER)

IS

CURSOR C1 (FILETYPE NUMBER)
IS
select PID, FILE_TYPE, FILE_NAME, RECORDCNT, LOAD_DATE, LOADED_BY, COMMENTS, BEGIN_LOAD_ID, END_LOAD_ID, LOADED
from  SQA_ICC_FILES_LIST
WHERE LOADED = 0
 AND  FILE_TYPE = FILETYPE;


R1  C1%ROWTYPE;

GC             GenRefCursor;
SQL_STMT       VARCHAR2(32000 BYTE);
DEL_STMT       VARCHAR2(32000 BYTE);
UPD_STMT       VARCHAR2(32000 BYTE);
MSG            VARCHAR2(1000 BYTE);
cnt1           NUMBER;
manual_control NUMBER;
TODAY          DATE;

/*
   file id 4 is CARDS
 */

BEGIN


OPEN C1( P_FILE_TYPE);
    LOOP
    FETCH C1 INTO R1;
    EXIT WHEN C1%NOTFOUND;

         IF ( P_FILE_TYPE IN (2) )
            THEN

          /*
            ASSIGN  PID to stage table ASSIGNING EACH RECORD To the File that was just loaded
          */

    --LOAN_NUMBER,CLIENT_NAME,REVIEWER,CAR_NAME,STATE,CLIENT_SPECIFIC_LOAN_STATUS,FTV,SALE_DATE,CURRENT_CONVEYANCE_DEADLINE,INITIAL_ICC_DATE,ICC_DATE,CASE_NUMBER,UPDATER,  BILLER,LOAD_ID,FILE_ID

                      BEGIN
                          UPD_STMT := ' UPDATE SQA_ICC_WORK_ASSIGNED_STG set FILE_ID = :1 WHERE LOAD_ID BETWEEN :2 AND :3 ';

                          EXECUTE IMMEDIATE UPD_STMT USING  R1.pid, R1.BEGIN_LOAD_ID, R1.END_LOAD_ID;


                          COMMIT;

                          SQL_STMT := ' insert into SQA_ICC_WORK_ASSIGNED(LOAN_NUMBER,  CLIENT_NAME,REVIEWER,DATA_SOURCE,RECONVEY_STATUS,CAR_NAME,STATE,CLIENT_SPECIFIC_LOAN_STATUS,FTV,SALE_DATE,CURRENT_CONVEYANCE_DEADLINE,INITIAL_ICC_DATE,ICC_DATE,CASE_NUMBER,UPDATER,BILLER,FILE_ID,LOAD_DATE)';
                          SQL_STMT := SQL_STMT||'  select A.LOAN_NUMBER,A.CLIENT_NAME,A.REVIEWER,A.DATA_SOURCE,A.RECONVEY_STATUS,A.CAR_NAME,A.STATE,A.CLIENT_SPECIFIC_LOAN_STATUS,A.FTV,A.SALE_DATE,A.CURRENT_CONVEYANCE_DEADLINE,A.INITIAL_ICC_DATE,A.ICC_DATE,A.CASE_NUMBER,A.UPDATER,A.BILLER,A.FILE_ID, SYSDATE';
                          SQL_STMT := SQL_STMT||'  FROM    SQA_ICC_WORK_ASSIGNED_STG  A';
                          SQL_STMT := SQL_STMT||'  LEFT JOIN ( SELECT LOAN_NUMBER,CLIENT_NAME,CAR_NAME FROM SQA_ICC_WORK_ASSIGNED ) B ON ( A.LOAN_NUMBER = B.LOAN_NUMBER  AND A.CLIENT_NAME = B.CLIENT_NAME AND A.CAR_NAME  = B.CAR_NAME)';
                          SQL_STMT := SQL_STMT||'  WHERE  A.LOAN_NUMBER NOT IN (''BEGIN'',''END'',''LOAN_NUMBER'') ';
                          SQL_STMT := SQL_STMT||'   AND  B.LOAN_NUMBER IS NULL ';
                          SQL_STMT := SQL_STMT||'   AND A.FILE_ID = :A';

                          EXECUTE IMMEDIATE SQL_STMT USING  R1.pid;

                                   cnt1  := SQL%ROWCOUNT;


                                   COMMIT;

                                  INSERT INTO BOA_PROCESS_LOG
                                              (
                                                PROCESS,
                                                SUB_PROCESS,
                                                ENTRYDTE,
                                                ROWCOUNTS,
                                                MESSAGE
                                              )
                                  VALUES ( 'SQA_LOV', 'LOAD_ICC_FILES',SYSDATE, cnt1, 'from '||R1.FILE_NAME);
                                  COMMIT;

                          /*
                             close out the queue record
                          */
                                UPDATE SQA_ICC_FILES_LIST SET LOADED = 1, RECORDCNT = cnt1 WHERE PID = R1.PID;

                                COMMIT;

                                EXECUTE IMMEDIATE 'TRUNCATE TABLE SQA_ICC_WORK_ASSIGNED_STG DROP STORAGE';



                      EXCEPTION WHEN OTHERS THEN

                                UPDATE SQA_ICC_FILES_LIST SET LOADED = 9, RECORDCNT = 0 WHERE PID = R1.PID;
                                COMMIT;
                                MSG   := SQLERRM;
                               SEND_EMAIL  (P_TEAM=>'RDM',P_FROM=>'SQA_LOV.LOAD_QAPP_PROJECT_FILES',P_SUBJECT=>R1.FILE_NAME ,P_MESSAGE=>MSG );
                      END;
         END IF;

    END LOOP;


CLOSE C1;


TODAY := TRUNC(SYSDATE);

select VARIABLE_VALUE
into   manual_control
from SQA_SYS_VARIABLES
where VARIABLE_NAME  = 'ICC_MANUAL_FLAG';

IF ( manual_control = 1 )
   THEN
   select  to_date(VARIABLE_VALUE,'MM/DD/YYYY')
      into   TODAY
      from SQA_SYS_VARIABLES
      where VARIABLE_NAME  = 'ICC_REPORT_DATE';

END IF;

---- REMOVE TODAYS RUN IF WE RE-RAN for some reason

SQL_STMT := 'DELETE SQA_ICC_WORK_ASSIGNED_HIST  WHERE LOAD_DATE = :H ';
EXECUTE IMMEDIATE SQL_STMT USING TODAY;
COMMIT;

insert into SQA_ICC_ASSIGNMENT_TEMPLATE (LOANNUMBER, CLIENTCODE, DATA_SOURCE, BACKLOG, REPORT_DATE)
SELECT  A.LOAN_NUMBER,
        A.CLIENT_NAME,
        A.CAR_NAME,
        A.REVIEWER,
        TRUNC(SYSDATE) AS REPORT_DATE
FROM ( SELECT R.LOAN_NUMBER,R.CLIENT_NAME, R.REVIEWER, R.CAR_NAME
  FROM ( SELECT LOAN_NUMBER,CLIENT_NAME, REVIEWER, CAR_NAME, RANK() OVER ( PARTITION BY LOAN_NUMBER,CLIENT_NAME ORDER BY CAR_NAME, ROWNUM) RK
           FROM SQA_ICC_WORK_ASSIGNED) R
          WHERE R.RK = 1) A
LEFT JOIN ( SELECT LOANNUMBER, CLIENTCODE FROM SQA_ICC_ASSIGNMENT_TEMPLATE ) B ON ( B.LOANNUMBER = A.LOAN_NUMBER AND B.CLIENTCODE = A.CLIENT_NAME)
WHERE B.CLIENTCODE IS NULL
 AND  B.LOANNUMBER IS NULL;

       CNT1 := SQL%ROWCOUNT;

       COMMIT;


          INSERT INTO BOA_PROCESS_LOG
                (
                  PROCESS,
                  SUB_PROCESS,
                  ENTRYDTE,
                  ROWCOUNTS,
                  MESSAGE
                )
         VALUES ( 'SQA_LOVS', 'LOAD_QAPP_PROJECT_FILES',SYSDATE, CNT1, 'SQA_ICC_assignment_template');
         COMMIT;



          INSERT INTO SQA_ICC_WORK_ASSIGNED_HIST (LOAN_NUMBER,CLIENT_NAME, REVIEWER, CAR_NAME, LOAD_DATE)
          SELECT LOAN_NUMBER,CLIENT_NAME, REVIEWER, CAR_NAME, TODAY AS LOAD_DATE
          FROM SQA_ICC_WORK_ASSIGNED;

           CNT1 := SQL%ROWCOUNT;

           COMMIT;


            INSERT INTO BOA_PROCESS_LOG
                  (
                    PROCESS,
                    SUB_PROCESS,
                    ENTRYDTE,
                    ROWCOUNTS,
                    MESSAGE
                  )
           VALUES ( 'SQA_LOVS', 'LOAD_QAPP_PROJECT_FILES',SYSDATE, CNT1, 'SQA_ICC_WORK_ASSIGNED_HIST');
           COMMIT;


exception
     when others then
          cnt1  := sqlcode;
           msg  := sqlerrm;

              INSERT INTO BOA_PROCESS_LOG
                    (
                      PROCESS,
                      SUB_PROCESS,
                      ENTRYDTE,
                      ROWCOUNTS,
                      MESSAGE
                    )
        VALUES ( 'SQA_LOV', 'LOAD_ICC_FILES', SYSDATE, cnt1, msg);
        COMMIT;


    SEND_EMAIL  (P_TEAM=>'RDM',P_FROM=>'SQA_LOV.LOAD_ICC_FILES',P_SUBJECT=>'Procedure issue' ,P_MESSAGE=>MSG );

END;


PROCEDURE ICC_CLEAR_BACKLOG
IS


BEGIN
       NULL;

END;






BEGIN

     SET_SYS_VARIABLES;

END;

/
