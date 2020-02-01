require 'rails_helper'

describe Client do
	describe '.identification' do
    it 'should generate a identification' do
			client = create(:client)

      result = client.identification

      expect(result).to eq "412.293.102-13 - João da Silva"
    end
  end

end
