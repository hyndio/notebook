

--备份控制文件
alter database backup controlfile to trace as '/oradata/control.txt';

startup nomount;
--备份参数文件
create pfile='/oradata/pfile.ora' from spfile;

--更改控制文件存放位置

alter system set control_files='/oracle/oradata/YNYXTS/control01.ctl, /oracle/oradata/YNYXTS/control02.ctl, /oracle/oradata/YNYXTS/control03.ctl' scope=spfile;

--重建控制文件
CREATE CONTROLFILE REUSE DATABASE "YNYXTS" NORESETLOGS  NOARCHIVELOG
    MAXLOGFILES 16
    MAXLOGMEMBERS 3
    MAXDATAFILES 100
    MAXINSTANCES 8
    MAXLOGHISTORY 292
LOGFILE
  GROUP 1 '/oradata/redo01.log'  SIZE 50M,
  GROUP 2 '/oradata/redo02.log'  SIZE 50M,
  GROUP 3 '/oradata/redo03.log'  SIZE 50M
-- STANDBY LOGFILE

DATAFILE
  '/oradata/system01.dbf',
  '/oradata/undotbs01.dbf',
  '/oradata/sysaux01.dbf',
  '/oradata/users01.dbf',
  '/oradata/data1.dbf',
  '/oradata/data2.dbf',
  '/oradata/data3.dbf',
  '/oradata/data4.dbf',
  '/oradata/data5.dbf',
  '/oradata/data6.dbf',
  '/oradata/data7.dbf',
  '/oradata/data8.dbf',
  '/oradata/data9.dbf',
  '/oradata/data10.dbf',
  '/oradata/data11.dbf',
  '/oradata/data12.dbf',
  '/oradata/data13.dbf',
  '/oradata/data14.dbf',
  '/oradata/data15.dbf',
  '/oradata/data16.dbf',
  '/oradata/data17.dbf',
  '/oradata/data18.dbf',
  '/oradata/data19.dbf',
  '/oradata/data20.dbf',
  '/oradata/data21.dbf',
  '/oradata/data22.dbf',
  '/oradata/data23.dbf',
  '/oradata/data24.dbf',
  '/oradata/data25.dbf',
  '/oradata/data26.dbf',
  '/oradata/data27.dbf',
  '/oradata/data28.dbf',
  '/oradata/data29.dbf',
  '/oradata/data30.dbf'
CHARACTER SET ZHS16GBK
;

alter database open;
alter tablespace TEMP add tempfile '/oradata/temp01.dbf' reuse;
