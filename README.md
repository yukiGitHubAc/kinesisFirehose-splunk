# kinesisFirehose-splunk

# config

Please set variables.

### ./bin/config.ini
- REGION
- S3_BUCKET_NAME
- PATH_TO_OBJECT
- CEC_ENDPOINT_URL
- HEC_TOKEN
- LAMBDA_ARN
- STACK_NAME
- ROLE_ARN

# deploy

```bash
./bin/create-template.bash
./bin/deploy.bash
```