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
prompt CREATE tables
spool log\tab_log.log  
spool off   
--
prompt CREATE sequences
spool log\sqs_log.log  
spool off 
--
prompt INSTALL triggers
spool log\trg_log.log  
spool off   
--
prompt INSTALL functions
spool log\fnc_log.log  
spool off
--
prompt INSTALL procedures
spool log\prc_log.log  
spool off
--
prompt INSTALL packages
prompt INSTALL packages specification
spool log\pks_log.log  
spool off   
--
prompt INSTALL packages body
spool log\pkb_log.log  
spool off   
--
prompt INSTALL types
prompt INSTALL types specification
spool log\tps_log.log  
prompt @@plsql\types\str_array.tps
@@plsql\types\str_array.tps
prompt @@plsql\types\explode.tps
@@plsql\types\explode.tps
spool off 
--
prompt INSTALL types body
spool log\tpb_log.log  
prompt @@plsql\types\explode.tpb
@@plsql\types\explode.tpb
spool off 
--
@@recompile.sql log