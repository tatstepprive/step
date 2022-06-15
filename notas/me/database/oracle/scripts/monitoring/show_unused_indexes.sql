column owner format a35
column index_name format a50
set linesize 200;
select owner,index_name, status from dba_indexes where status='UNUSABLE';
--partitioned indexes have status 'N/A' par default 
--to see if they are usable
SELECT i.table_name,  i.index_name, ip.partition_name,
       i.status AS index_status, 
       ip.status AS partition_status
FROM dba_indexes i JOIN dba_ind_partitions ip ON (i.index_name = ip.index_name )
WHERE ip.status <> 'USABLE'
ORDER BY i.table_name, i.index_name, ip.partition_name;
-- rebuild partitioned indexes
ALTER INDEX nd_name REBUILD PARTITION partition_name;
-- rebuild all unused indexes
BEGIN
	FOR x IN
	(
		SELECT 'ALTER INDEX '||OWNER||'.'||INDEX_NAME||' REBUILD ONLINE PARALLEL' comm
		FROM    dba_indexes
		WHERE   status = 'UNUSABLE'
		UNION ALL
		SELECT 'ALTER INDEX '||index_owner||'.'||index_name||' REBUILD PARTITION '||partition_name||' ONLINE PARALLEL'
		FROM    dba_ind_PARTITIONS
		WHERE   status = 'UNUSABLE'
		UNION ALL
		SELECT 'ALTER INDEX '||index_owner||'.'||index_name||' REBUILD SUBPARTITION '||subpartition_name||' ONLINE PARALLEL'
		FROM    dba_ind_SUBPARTITIONS
		WHERE   status = 'UNUSABLE'
	)
	LOOP
		dbms_output.put_line(x.comm);
		EXECUTE immediate x.comm;
	END LOOP;
END;
/
