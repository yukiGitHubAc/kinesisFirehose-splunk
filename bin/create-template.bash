#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# ログ設定
cur_time=$(date +%Y%m%d%H%M%S)
log_file=./log.$(basename ${0}).${cur_time}
exec 2> ${log_file}; set -xv
# ------------------------------------------------------------------------------
source ./config.ini &> /dev/null
# ------------------------------------------------------------------------------
# ネストされたテンプレートをデプロイ
#aws s3 cp ../src/kinesis-firehose-splunk-nested-stack.yaml s3://${S3_BUCKET_NAME}/${PATH_TO_OBJECT}/
#[ $? -ne 0 ] && exit 1
# ------------------------------------------------------------------------------
# テンプレートを作成
[ ! -d ../dist ] && mkdir ../dist
rm -rf ../dist/*

cat ../src/kinesis-firehose-splunk-root-stack.yaml |
    sed -e 's@###NESTED_TEMPLATE_YAML###@'https://s3-${REGION}.amazonaws.com/${S3_BUCKET_NAME}/${PATH_TO_OBJECT}/kinesis-firehose-splunk-nested-stack.yaml'@g' \
        -e 's@###BUCKET_ARN###@arn:aws:s3:::'${S3_BUCKET_NAME}'@g' \
        -e 's@###CEC_ENDPOINT_URL###@'${CEC_ENDPOINT_URL}'@g' \
        -e 's@###HEC_TOKEN###@'${HEC_TOKEN}'@g' \
        -e 's@###LAMBDA_ARN###@'${LAMBDA_ARN}'@g' >> ../dist/kinesis-firehose-splunk.package.yaml
[ $? -ne 0 ] && exit 1
# ------------------------------------------------------------------------------
rm -rf ${log_file}
exit 0
