TERRASHINE_SQL_SEED_CHECK=/seed/terrashine_sql_seed_check;
if [ ! -f $TERRASHINE_SQL_SEED_CHECK ]; then
  sqlx migrate run --source /app/migrations --database-url $TERRASHINE_DATABASE_URL;
  touch $TERRASHINE_SQL_SEED_CHECK;
fi;
