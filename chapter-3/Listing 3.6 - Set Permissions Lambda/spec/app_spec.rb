# frozen_string_literal: true

require 'json'
require_relative '../app'

describe '#lambda_handler' do
  subject { -> { lambda_handler(event: event, context: '') } }

  let(:event) do
    File.open(File.expand_path('fixtures/files/event.json', __dir__)) do |j|
      JSON.parse(j.read)
    end
  end

  context 'when Aws::S3::Client#put_object succeeds' do
    before { Aws.config[:stub_responses] = true }

    it do
      is_expected.not_to raise_error
    end
  end
end
