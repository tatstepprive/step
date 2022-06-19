set head off

select "VAL" from (
select 1 N, 'Name                     '||name            "VAL" from v$database union
select 2 N, ' '  "VAL" from dual union
select 3 N, 'DB role                  '||DATABASE_ROLE   "VAL" from v$database union
select 4 N, 'Managed Recovery Process '||STATUS from (select nvl((select status from v$managed_standby where process like 'MRP%'),'CANCEL') status  from dual) union
select 5 N, 'Open mode                '||OPEN_MODE       "VAL" from v$database union
select 6 N, 'Protection               '||PROTECTION_MODE "VAL" from v$database union
select 7 N, ' '  "VAL" from dual union
select 7.6 N, '===> Using Active Data Guard ' "VAL" FROM V$MANAGED_STANDBY M, V$DATABASE D WHERE M.PROCESS LIKE 'MRP%' AND D.OPEN_MODE like 'READ ONLY%' union
select 7.7 N, ' '  "VAL" from dual union
select 8 N, 'Logs applied  until      '||to_char(max(NEXT_TIME),'HH24:MI:SS DD/MM')||' (seq '||max(SEQUENCE#)||')'   "VAL" from v$archived_log where applied='YES' union
select 9 N, 'Logs received until      '||to_char(max(NEXT_TIME),'HH24:MI:SS DD/MM')||' (seq '||max(SEQUENCE#)||')'   "VAL" from v$archived_log union
select 10 N, ' '  "VAL" from dual )
order by N;

set head on

