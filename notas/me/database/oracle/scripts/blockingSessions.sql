--show blocking sessions
SELECT  /*+ ORDERED */
            s.username,
            s.osuser,
            S.SID,
            L.TYPE,
            L.ID1,
            o.object_name,
            DECODE(L.LMODE, 0, 'NONE', 1, 'NULL', 2, 'SS', 3, 'RX', 4, 'S', 5, 'SRX', 6, 'X', '?') holding,
            DECODE(L.REQUEST, 0, 'NONE', 1, 'NULL', 2, 'SS', 3, 'RX', 4, 'S', 5, 'SRX', 6, 'X', '?') wanting,
            l.ctime how_long,
            decode(l.block,0,null,2,null,'YES') is_blocking
   FROM V$SESSION S, V$LOCK L, sys.dba_objects o
   WHERE L.SID=S.SID
   AND S.USERNAME is not null
   and l.type != 'AE'
   and l.id1 = o.object_id
   /
