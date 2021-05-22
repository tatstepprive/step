set linesize   145
set pagesize  1000
set trimout     on
set trimspool   on
Set Feedback   off
set timing     off
set verify     off


prompt

prompt

accept Owner_Name    prompt 'Owner Name : '

prompt

prompt

prompt -- ----------------------------------------------------------------------- ---

prompt --   Tables / Statistics / Last_Analyzed                                   ---

prompt -- ----------------------------------------------------------------------- ---

prompt


column owner          format a25         heading  "Owner"
column table_owner    format a25         heading  "Owner"
column last_analyzed  format a20         heading  "Last|Analyzed"    
column last_action    format a20         heading  "Last|Actions"    
column nb             format 999,999,999  heading  "Count"            
column nb_ins         format 999,999,999  heading  "Count|Inserts"            
column nb_upd         format 999,999,999  heading  "Count|Updates"            
column nb_del         format 999,999,999  heading  "Count|Deletes"            

select
       owner
     , trunc(last_analyzed, 'DD') last_analyzed
     , count(*)  nb   
  from 
       dba_tables
 where
       (owner       =   upper ('&owner_name.')
    Or 
       (owner    like   '%' and upper ('&owner_name.') is null))
 group
    by owner
     , trunc(last_analyzed, 'DD')
 order
    By trunc(last_analyzed, 'DD')
     , Owner
;


select
       table_owner
     , trunc(TIMESTAMP, 'DD') last_action
     , sum(inserts)  nb_ins   
     , sum(updates)  nb_upd   
     , sum(deletes)  nb_del   
  from 
       dba_tab_modifications
 where
       (table_owner       =   upper ('&owner_name.')
    Or 
       (table_owner    like   '%' and upper ('&owner_name.') is null))
 group
    by table_owner
     , trunc(timestamp, 'DD')
 order
    By trunc(timestamp, 'DD')
     , Table_Owner
;


column owner          format a15         heading  "Owner"
column table_name     format a30         heading  "Table Name"
column last_action    format a9          heading  "Last|Actions"    
column last_analyzed  format a9          heading  "Last|Analyzed"    
column pct_big_op     format 999 	     heading  "% Change"
column pct_max_op     format 999 	     heading  "% Change|(Max)"


Select
       m.table_owner				owner
     , m.Table_Name				table_name
     , trunc(last_analyzed, 'DD') 		last_analyzed
     , m.nb_ins					nb_ins
     , m.nb_upd					nb_upd
     , m.nb_del					nb_del
     , m.last_action				last_action
--   , s.max_op
     , m.nb_op * 100 / s.max_op 		pct_big_op
--   , s.max_op
--   , sm.smax_op
     , m.nb_op * 100 / sm.smax_op		pct_max_op
  from 
       ( Select * from 
              ( Select
                        table_owner
                      , Table_Name
                      , trunc(TIMESTAMP, 'DD') last_action
                      , sum(inserts)  nb_ins
                      , sum(updates)  nb_upd
                      , sum(deletes)  nb_del
                      , sum(deletes) + sum(updates) + sum(inserts) nb_op
                   from
                        dba_tab_modifications
                  where
                        (table_owner       =   upper ('&owner_name.')
                     Or
                        (table_owner    like   '%' and upper ('&owner_name.') is null))
                  group
                     by table_owner
                      , trunc(timestamp, 'DD')
                      , Table_Owner
                      , Table_Name
                  order
                     By nb_op desc 
                      , Table_Owner
                      , Table_Name) where rownum < 21) m
     , dba_tables t
     , ( Select
                max(sum(deletes) + sum(updates) + sum(inserts)) max_op
           from
                dba_tab_modifications
          where
                (table_owner       =   upper ('&owner_name.')
             Or
                (table_owner    like   '%' and upper ('&owner_name.') is null))
          group
             by table_owner
              , trunc(timestamp, 'DD')
              , Table_Owner
              , Table_Name) s  
     , ( Select
                sum(deletes) + sum(updates) + sum(inserts) smax_op
           from
                dba_tab_modifications
          where
                (table_owner       =   upper ('&owner_name.')
             Or
                (table_owner    like   '%' and upper ('&owner_name.') is null))) sm  
 Where
       t.table_name = m.table_name
   and
       m.table_owner = t.owner
 order
    by m.nb_op desc
;





prompt

prompt

pause Print Indexes / Statistics / Last_Analyzed . . . (enter)

prompt -- ----------------------------------------------------------------------- ---

prompt

column owner          format a25         heading  "Owner"

select
       owner
     , trunc(last_analyzed, 'DD') last_analyzed
     , count(*)  nb   
  from 
       dba_indexes
 where
       (owner       =   upper ('&owner_name.')
    Or 
       (owner    like   '%' and upper ('&owner_name.') is null))
 group
    by owner
     , trunc(last_analyzed, 'DD')
 order
    By trunc(last_analyzed, 'DD')
     , Owner
;


Prompt

Prompt


