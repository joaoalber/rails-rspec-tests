require 'rails_helper'

describe Client do
	describe '.identification' do
    it 'should generate a identification' do
			client = Client.create(cpf: "745.291.293-20", name: 'John Doe', email: 'johndoe@gmail.com')

      result = client.identification

      expect(result).to eq "745.291.293-20 - John Doe"
    end
  end

end
