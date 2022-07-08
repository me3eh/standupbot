require_relative '../spec_helper'
require_relative '../../lib/jsons/radio_buttons'
describe Jsons::RadioButtons do
  subject(:result) { described_class }

  let(:valid_options) do
    [{
       "text": {
         "type": "plain_text",
         "text": "siema",
         "emoji": true
       },
       "value": "bruh"
     },
     {
       "text": {
         "type": "plain_text",
         "text": "hejo",
         "emoji": true
       },
       "value": "yikes"
     }]
  end

  let(:invalid_options) do
    {sss: "sda", ccc: "daa"}
  end

  context 'when trying to use radio buttons with parameter as array' do
    it 'succeeds' do
      binding.pry
      expect( result.call(valid_options).class ).to eq(Hash)
    end

    it 'throws error related to object specifications' do
      expect{ result.call(invalid_options) }.to raise_error(Jsons::RadioButtons::Errors)
      expect{ result.call(invalid_options) }.to raise_error("Parameter need to be array")
    end
  end
end
