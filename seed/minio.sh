TERRASHINE_S3_SEED_CHECK=/seed/terrashine_s3_seed_check;
if [ ! -f $TERRASHINE_S3_SEED_CHECK ]; then
  mc mb --region $AWS_REGION $AWS_STORAGE/$AWS_BUCKET_NAME;
  touch $TERRASHINE_S3_SEED_CHECK;
fi;
