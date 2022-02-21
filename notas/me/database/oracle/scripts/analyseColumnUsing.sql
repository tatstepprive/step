--find where column tablespace used in db: query dict_columns
select * from dict_columns
where column_name like '%TABLESPACE%'
and table_name not in ('DBA_USERS',
'DBA_TS_QUOTAS',
'DBA_TABLESPACES',
'DBA_TABLESPACE_GROUPS',
'DBA_TABLESPACE_THRESHOLDS',
'DBA_SEGMENTS',
'DBA_SEGMENTS_OLD',
'DBA_EXTENTS',
'DBA_ROLLBACK_SEGS',
'DBA_UNDO_EXTENTS')
and table_name not like '%$%'
and table_name not like 'ALL_%'
and table_name not like 'USER_%'
and table_name not like '%HIST%'
and table_name not like '%FILE%'
and table_name not like '%FREE%'
and table_name not like '%HEATMAP%'
and table_name not like '%USAGE_METRICS%'
--and column_name='TABLESPACE_NAME';
--and column_name='TABLESPACE_ID';
--and column_name='TABLESPACE_PROCESSED'
--and column_name='TABLESPACE_SELECTED';
--and column_name='TIER_TABLESPACE';
--and column_name='TABLESPACE'
and column_name='DEF_TABLESPACE_NAME';
