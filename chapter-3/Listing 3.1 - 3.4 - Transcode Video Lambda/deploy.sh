#!/bin/sh
set -eux

sam package --template-file template.yaml --output-template-file packaged-template.yaml --s3-bucket book-chapter3-transcode-video-lambda
sam deploy --template-file packaged-template.yaml --stack-name TranscodeVideoFunc --capabilities CAPABILITY_IAM
