#!/bin/sh
set -eux

sam package --template-file template.yaml --output-template-file packaged-template.yaml --s3-bucket book-chapter3-set-permissions-lambda
sam deploy --template-file packaged-template.yaml --stack-name SetPermissionsFunc --capabilities CAPABILITY_IAM
