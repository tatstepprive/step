-- AMM automatic memory management (memory transfer between pga and sga possible)
-- memory_target should not be 0, (disabled if 0)
-- memory_max_target 20% of memory_target
select * from v$parameter where name = 'memory_target';
select * from v$parameter where name = 'memory_max_target';
