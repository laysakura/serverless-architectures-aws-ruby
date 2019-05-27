# frozen_string_literal: true

require 'json'
require 'uri'
require 'aws-sdk-elastictranscoder'

def lambda_handler(event:, context:)
  key = event['Records'][0]['s3']['object']['key']

  # the input file may have spaces so replace them with '+'
  source_key = URI.decode_www_form_component(key.gsub('+', ' '))

  # remove the extension
  output_key = source_key.split('.')[0]

  params = {
    pipeline_id: '1558853247228-pq7tuv',
    input: {
      key: source_key
    },
    outputs: [
      {
        key: "#{output_key}-1080p.mp4",
        preset_id: '1351620000001-000001' # Generic 1080p
      },
      {
        key: "#{output_key}-720p.mp4",
        preset_id: '1351620000001-000010' # Generic 720p
      },
      {
        key: "#{output_key}-web-720p.mp4",
        preset_id: '1351620000001-100070' # Web Friendly 720p
      }
    ]
  }

  transcoder_client = Aws::ElasticTranscoder::Client.new(region: 'ap-northeast-1')
  transcoder_client.create_job(params)
end
