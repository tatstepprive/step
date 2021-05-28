select 'CHECK FAILED: low controlfile multiplexing', count(*) as mnr from v$controlfile having count(*)<3;
