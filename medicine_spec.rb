require 'rspec'
require_relative 'medicine'

RSpec.describe Medicine do
	describe '#new' do	
		subject(:new_medicine) { described_class.new(formula: formula) }
		
		context 'with valid parameters' do
			let(:formula) { :As }
			
			it 'instantiates a new medicine' do
				expect(new_medicine.formula).to eq formula
			end
		end

		context 'with invalid parameters' do
			let(:formula) { :invalid }
			
			it 'raises an error' do
				expect { new_medicine.formula }.to raise_error(::Medicine::UnknownFormula)
			end
		end
	end
end