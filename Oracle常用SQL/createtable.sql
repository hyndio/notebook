

--order by price
--where [DEPARTURE] ,[ARRIVAL] ,[FLIGHTDATE] ,

--删除表



--按照日进行31天分区
drop table FLIGHTINFO;
CREATE TABLE FLIGHTINFO
(
  FLIGHTINFOID INTEGER primary key
, fltday   varchar2(2)
, FLIGHTNO VARCHAR2(6)
, DEPARTURE VARCHAR2(3)
, ARRIVAL VARCHAR2(3)
, FLIGHTDATE DATE
, NODEID INTEGER
, FLIGHTPRICE NUMBER(15)
, DISCOUNT_RATE NUMBER(15)
, KIDSAFE NUMBER(15)
, LEAVESEAT INTEGER
, RENEWDATE DATE
, PRICEVALID INTEGER
, URLSTRING VARCHAR2(200)
, REQUESTTYPE VARCHAR2(5)
, CHARACTER VARCHAR2(10)
, REQUESTSTRING CLOB
)
PARTITION BY LIST (fltday) 
( 
      PARTITION fltt1   VALUES ('1') TABLESPACE fltinfo1, 
      PARTITION fltt2   VALUES ('2') TABLESPACE fltinfo2,
      PARTITION fltt3   VALUES ('3') TABLESPACE fltinfo3,
      PARTITION fltt4   VALUES ('4') TABLESPACE fltinfo4,
      PARTITION fltt5   VALUES ('5') TABLESPACE fltinfo5,
      PARTITION fltt6   VALUES ('6') TABLESPACE fltinfo6,
      PARTITION fltt7   VALUES ('7') TABLESPACE fltinfo7,
      PARTITION fltt8   VALUES ('8') TABLESPACE fltinfo8,
      PARTITION fltt9   VALUES ('9') TABLESPACE fltinfo9,
      PARTITION fltt10   VALUES ('10') TABLESPACE fltinfo10,
      PARTITION fltt11   VALUES ('11') TABLESPACE fltinfo11,
      PARTITION fltt12   VALUES ('12') TABLESPACE fltinfo12,
      PARTITION fltt13   VALUES ('13') TABLESPACE fltinfo13,
      PARTITION fltt14   VALUES ('14') TABLESPACE fltinfo14,
      PARTITION fltt15   VALUES ('15') TABLESPACE fltinfo15,
      PARTITION fltt16   VALUES ('16') TABLESPACE fltinfo16,
      PARTITION fltt17   VALUES ('17') TABLESPACE fltinfo17,
      PARTITION fltt18   VALUES ('18') TABLESPACE fltinfo18,
      PARTITION fltt19   VALUES ('19') TABLESPACE fltinfo19,
      PARTITION fltt20   VALUES ('20') TABLESPACE fltinfo20,
      PARTITION fltt21   VALUES ('21') TABLESPACE fltinfo21,
      PARTITION fltt22   VALUES ('22') TABLESPACE fltinfo22,
      PARTITION fltt23   VALUES ('23') TABLESPACE fltinfo23,
      PARTITION fltt24   VALUES ('24') TABLESPACE fltinfo24,
      PARTITION fltt25   VALUES ('25') TABLESPACE fltinfo25,
      PARTITION fltt26   VALUES ('26') TABLESPACE fltinfo26,
      PARTITION fltt27   VALUES ('27') TABLESPACE fltinfo27,
      PARTITION fltt28   VALUES ('28') TABLESPACE fltinfo28,
      PARTITION fltt29   VALUES ('29') TABLESPACE fltinfo29,
      PARTITION fltt30   VALUES ('30') TABLESPACE fltinfo30,
      PARTITION fltt31   VALUES ('31') TABLESPACE fltinfo31
 );


--创建自增序列
--------------------
drop sequence FLIGHTINFO_AUTOINC;
create sequence FLIGHTINFO_AUTOINC 
minvalue 1  
start with 1  
increment by 1  
nocache;


--注意：不能以sysdba角色登录创建，否则在创建触发器的时候会报错
--
--drop trigger insert_for_FLIGHTINFO_AUTOINC;
--create or replace trigger insert_for_FLIGHTINFO_AUTOINC 
   --before insert on FLIGHTINFO   
  -- for each row  
   --WHEN   (NEW.FLIGHTINFOID   IS   NULL) 
  -- local variables here 
--begin  
   --select FLIGHTINFO_AUTOINC.nextval into:NEW.FLIGHTINFOID from dual; 
--end insert_for_FLIGHTINFO_AUTOINC;
------------------------

 --创建索引

