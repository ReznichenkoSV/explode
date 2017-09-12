set time on                      
set trimspool on                 
set wrap on                      
set verify off                   
host del log /q
host mkdir log                   
set define "&"                   
@@conf.sql                       
set serveroutput on size 500000 format wrapped    
--                               
set define "&"                   
prompt DROP tables
spool log\tab_log.log  
spool off   
--
prompt DROP sequences
spool log\sqs_log.log  
spool off 
--
prompt DROP triggers
spool log\trg_log.log  
spool off   
--
prompt DROP functions
spool log\fnc_log.log  
spool off
--
prompt DROP procedures
spool log\prc_log.log  
spool off
--
prompt DROP packages
spool log\pck_log.log  
spool off   
--
prompt DROP types
spool log\typ_log.log  
prompt drop type str_array force;
drop type str_array force;
prompt drop type explode force;
drop type explode force;
spool off   