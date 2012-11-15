select * from dba_free_space

alter tablespace ODS coalesce 

--移动表空间
alter table ods_ssims_search_travelsky move tablespace ods;

alter index pk_cub_stat_fli rebuild

select segment_name,segment_type,blocks from dba_segments

  where tablespace_name='USERS'
  
  purge recyclebin
  
  
  --收缩表空间
  SELECT 'alter database datafile '||d.file_id ||' resize '||

NVL(ROUND(MAX(e.block_id+e.blocks -1)* t.block_size /1024/1024+1),11)||'M;'

FROM dba_extents e, dba_data_files d , dba_tablespaces t

WHERE d.tablespace_name = t. tablespace_name

AND d.file_id = e.file_id(+)

AND t. tablespace_name = 'USERS'

AND e. tablespace_name(+) = 'USERS'

GROUP BY d.file_id , t.block_size

  --修改外键
  alter table CUB_STAT_FLIGHT
   drop constraint FK_CUB_STAT_RE3;
   
alter   table   CUB_STAT_FLIGHT   rename   column   DIM_FLIGHT_ID   to   FLIGHT_ID;   
   
alter table CUB_STAT_FLIGHT
   add constraint FK_CUB_STAT_RE3 foreign key (FLIGHT_ID)
      references DIM_STAT_FLIGHTID (FLIGHT_ID);
      
      --表空间占用

      SELECT D.TABLESPACE_NAME,SPACE "SUM_SPACE(M)",BLOCKS SUM_BLOCKS,SPACE-NVL(FREE_SPACE,0) "USED_SPACE(M)",
ROUND((1-NVL(FREE_SPACE,0)/SPACE)*100,2) "USED_RATE(%)",FREE_SPACE "FREE_SPACE(M)"
FROM 
(SELECT TABLESPACE_NAME,ROUND(SUM(BYTES)/(1024*1024),2) SPACE,SUM(BLOCKS) BLOCKS
FROM DBA_DATA_FILES
GROUP BY TABLESPACE_NAME) D,
(SELECT TABLESPACE_NAME,ROUND(SUM(BYTES)/(1024*1024),2) FREE_SPACE
FROM DBA_FREE_SPACE
GROUP BY TABLESPACE_NAME) F
WHERE  D.TABLESPACE_NAME = F.TABLESPACE_NAME(+)
UNION ALL  --if have tempfile 
SELECT D.TABLESPACE_NAME,SPACE "SUM_SPACE(M)",BLOCKS SUM_BLOCKS, 
USED_SPACE "USED_SPACE(M)",ROUND(NVL(USED_SPACE,0)/SPACE*100,2) "USED_RATE(%)",
NVL(FREE_SPACE,0) "FREE_SPACE(M)"
FROM 
(SELECT TABLESPACE_NAME,ROUND(SUM(BYTES)/(1024*1024),2) SPACE,SUM(BLOCKS) BLOCKS
FROM DBA_TEMP_FILES
GROUP BY TABLESPACE_NAME) D,
(SELECT TABLESPACE_NAME,ROUND(SUM(BYTES_USED)/(1024*1024),2) USED_SPACE,
ROUND(SUM(BYTES_FREE)/(1024*1024),2) FREE_SPACE
FROM V$TEMP_SPACE_HEADER
GROUP BY TABLESPACE_NAME) F
WHERE  D.TABLESPACE_NAME = F.TABLESPACE_NAME(+)

--查询文件
select file#,name from v$datafile;

--收缩数据库文件,resize后的大小为上面的free值
alter database datafile '/opt/oracle/oradata/yntsora/cube' resize 1000M;


select 'alter database datafile ''' || file_name || ''' resize ' ||
       ceil((nvl(hwm, 1) * 8192) / 1024 / 1024) || 'm;' cmd
  from dba_data_files a,
       (select file_id, max(block_id + blocks - 1) hwm
          from dba_extents
         group by file_id) b
where a.file_id = b.file_id(+)
   and ceil(blocks * 8192 / 1024 / 1024) -
       ceil((nvl(hwm, 1) * 8192) / 1024 / 1024) > 100;
       
  
 --查看sga使用情况
  select * from v$sgastat
 --清除缓存
 Alter system flush buffer_cache;
       
 --查看表所占空间 
select bytes/1024/1024 from dba_segments where LOWER(segment_name)='ods_dcs_psr_info';


--创建有多个数据文件的表空间
create tablespace userdat datafile '/home/oracle/oradata/userdat01.dbf' size 10m,
'/home/oracle/oradata/userdat01_2.dbf' size 10m
 autoextend on next 1m maxsize 20m；

 --表空间添加数据文件
 alter tablespace users add datafile '/home/oracle/oradata/gldb/users02.dbf' size 1m；