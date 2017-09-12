set lines 200
set feedback off
set pages 0
define usrpath=&1
spool &&usrpath\compile.sql
select /*+ ordered use_nl( ot uo ) */
       'PROMPT ' || ot.object_type || ' ' || uo.object_name || chr(10) ||
       'ALTER '||replace( ot.object_type, ' BODY' )|| ' ' || uo.object_name || ' COMPILE'|| decode( to_char( instr( ot.object_type, ' BODY' ) ), '0', ';', ' BODY;' ) object_compile
  from (
        select 1  tid, 'VIEW'             object_type from dual union all
        select 2  tid, 'TYPE'             object_type from dual union all
        select 3  tid, 'TYPE BODY'        object_type from dual union all
        select 4  tid, 'FUNCTION'         object_type from dual union all
        select 5  tid, 'PROCEDURE'        object_type from dual union all
        select 6  tid, 'PACKAGE'          object_type from dual union all
        select 7  tid, 'PACKAGE BODY'     object_type from dual union all
        select 8  tid, 'TRIGGER'          object_type from dual
       )              ot
     , user_objects   uo
 where (uo.object_type = ot.object_type
       and status != 'VALID')
       or (uo.object_type = ot.object_type
       and status = 'VALID' and upper(object_name) in ('PK_REPORT','ATTRV'))
 order by ot.tid, uo.object_name;

spool off;

@@&&usrpath\compile.sql

host del /Q &&usrpath\compile.sql

column type     format a12 trunc
column name     format a30
column line     format 99999
column position format 9999
column text     format a100 word wrapped

break on type skip 0 on name skip 0 on line skip 0

set linesize 160
set pagesize 2000

spool &&usrpath\compile_errors.log

select type,
       name,
       line, 
       position, 
       text
  from user_errors
 order by type, name, line, position, sequence;

spool off

