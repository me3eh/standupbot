require_relative '../spec_helper'

describe Jsons::RadioButtons do
  subject(:result) { described_class.call(options) }

  let(:valid_options) do
    [{
      "text": {
        "type": 'plain_text',
        "text": 'siema',
        "emoji": true
      },
      "value": 'bruh'
    },
     {
       "text": {
         "type": 'plain_text',
         "text": 'hejo',
         "emoji": true
       },
       "value": 'yikes'
     }]
  end

  context 'when trying to use radio buttons with parameter as array' do
    context 'and giving right parameters - array filled with hashes' do
      let(:options) do
        [{
          "text": {
            "type": 'plain_text',
            "text": 'siema',
            "emoji": true
          },
          "value": 'bruh'
        },
         {
           "text": {
             "type": 'plain_text',
             "text": 'hejo',
             "emoji": true
           },
           "value": 'yikes'
         }]
      end

      it 'succeeds' do
        expect(result.class).to be(Hash)
      end
    end
    context 'and giving wrong parameters - not array' do
      let(:options) do
        { sss: 'sda', ccc: 'daa' }
      end

      it 'throws error related to object specifications' do
        expect { result }.to raise_error(ObjectMustBeArray)
      end
    end
    context 'and giving wrong parameters - array with not only hashes in it' do
      let(:options) do
        [{ sss: 'sda', ccc: 'daa' }, 5]
      end

      it 'throws error related to object specifications' do
        expect { result }.to raise_error(ArrayMustBeFilledWithHashes)
      end
    end
  end
end
