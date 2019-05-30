# frozen_string_literal: true

require 'json'
require 'uri'
require 'aws-sdk-s3'

def lambda_handler(event:, context:)
  message = JSON.parse(event['Records'][0]['Sns']['Message'])

  source_bucket = message['Records'][0]['s3']['bucket']['name']

  key = message['Records'][0]['s3']['object']['key']
  source_key = URI.decode_www_form_component(key.gsub('+', ' '))

  params = {
    bucket: source_bucket,
    key: source_key,
    acl: 'public-read'
  }

  s3_client = Aws::S3::Client.new(region: 'ap-northeast-1')
  s3_client.put_object_acl(params)
end
