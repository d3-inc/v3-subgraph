/* 

!!!!!! IMPORTANT !!!!!!

replace <db> with the name of subgraph deployment 
(auto-generated during deployment of subgraph)

E.g. <db> = "sgd11" or <db> = "sgd13"
(normally it should be "sgd<number>")

 */

/* ---- POOLS QUERY INDEX START ---- */

CREATE INDEX CONCURRENTLY IF NOT EXISTS pool_block_range_gist
ON <db>.pool USING GIST (block_range);

ANALYZE <db>.pool;

/* ---- POOLS QUERY INDEX END ---- */

/* ---- TRANSACTIONS QUERY INDEX START ---- */

CREATE EXTENSION IF NOT EXISTS btree_gist;

CREATE INDEX CONCURRENTLY IF NOT EXISTS transaction_block_range_gist
ON <db>."transaction" USING GIST (block_range);
ANALYZE <db>."transaction";

CREATE INDEX CONCURRENTLY IF NOT EXISTS transaction_timestamp_id_block_range_vid
ON <db>."transaction" ("timestamp" DESC, "id" DESC)
INCLUDE ("block_range", "vid");

CREATE INDEX CONCURRENTLY IF NOT EXISTS transaction_timestamp_id
  ON <db>."transaction" ("timestamp" DESC, "id" DESC);

CREATE INDEX CONCURRENTLY IF NOT EXISTS swap_pool_range_gist
  ON <db>.swap USING GIST (pool, block_range) INCLUDE (transaction);
CREATE INDEX CONCURRENTLY IF NOT EXISTS mint_pool_range_gist
  ON <db>.mint USING GIST (pool, block_range) INCLUDE (transaction);
CREATE INDEX CONCURRENTLY IF NOT EXISTS burn_pool_range_gist
  ON <db>.burn USING GIST (pool, block_range) INCLUDE (transaction);
ANALYZE <db>.swap; ANALYZE <db>.mint; ANALYZE <db>.burn;


ANALYZE <db>."transaction";
ANALYZE <db>.swap; ANALYZE <db>.mint; ANALYZE <db>.burn;

/* ---- TRANSACTIONS QUERY INDEX END ---- */
