require 'spec_helper'
require 'messages/orgs_list_message'

module VCAP::CloudController
  RSpec.describe OrgsListMessage do
    describe '.from_params' do
      let(:params) do
        {
          'page' => 1,
          'per_page' => 5
        }
      end

      it 'returns the correct OrgsListMessage' do
        message = OrgsListMessage.from_params(params)

        expect(message).to be_a(OrgsListMessage)

        expect(message.page).to eq(1)
        expect(message.per_page).to eq(5)
      end

      it 'converts requested keys to symbols' do
        message = OrgsListMessage.from_params(params)

        expect(message.requested?(:page)).to be_truthy
        expect(message.requested?(:per_page)).to be_truthy
      end
    end

    describe '#to_param_hash' do
      let(:opts) do
        {
          page: 1,
          per_page: 5,
        }
      end

      it 'excludes the pagination keys' do
        expected_params = []
        expect(OrgsListMessage.new(opts).to_param_hash.keys).to match_array(expected_params)
      end
    end

    describe 'fields' do
      it 'accepts a set of fields' do
        expect {
          OrgsListMessage.new({
            page:               1,
            per_page:           5,
          })
        }.not_to raise_error
      end

      it 'accepts an empty set' do
        message = OrgsListMessage.new
        expect(message).to be_valid
      end

      it 'does not accept a field not in this set' do
        message = OrgsListMessage.new({ foobar: 'pants' })

        expect(message).not_to be_valid
        expect(message.errors[:base]).to include("Unknown query parameter(s): 'foobar'")
      end
    end
  end
end
