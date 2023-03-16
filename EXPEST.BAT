cd\Program Files\PostgreSQL\9.3\bin\
SET PGPASSWORD=sacd35269147
pg_dump.exe --host 127.0.0.1 --encoding latin1 --port 5432 --username "sac" --format plain -C --column-inserts --file "\sac60\pedidos\scripttempproduto.sql" --table estoquetemp sac60
