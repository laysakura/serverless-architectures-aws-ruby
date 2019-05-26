# frozen_string_literal: true

require 'json'
require_relative '../app'

describe '#lambda_handler' do
  subject { lambda_handler(event: event, context: '') }

  let(:event) do
    File.open(File.expand_path('fixtures/files/event.json', __dir__)) do |j|
      JSON.parse(j)
    end
  end

  it do
    is_expected.to eq(
      statusCode: 200,
      body: JSON.generate('Hello from laysakura!')
    )
  end
end
