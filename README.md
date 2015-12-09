# docker-thumbor
Thumbor docker image

## Recommended map volumes

- map your own thumbor.conf: myfolder/thumbor.conf:/home/thumbor/conf/thumbor.conf
- map your own thumbor.key: myfolder/thumbor.conf:/home/thumbor/conf/thumbor.key
- map thumbor working dir directory (logs are here): myfolder/thumbor/app:/home/thumbor/app

## Thumbor could use s3 as loader/storage/result container.

Use https://boto3.readthedocs.org/en/latest/guide/quickstart.html#configuration for auth
and mount your .aws folder in /home/thumbor/.aws as a docker volume.

and configure thumbor.conf to use tc_aws:
- LOADER = 'tc_aws.loaders.s3_loader'
- STORAGE = 'tc_aws.storages.s3_storage'
- RESULT_STORAGE = 'tc_aws.result_storages.s3_storage'
