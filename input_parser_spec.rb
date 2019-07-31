require 'rspec'
require_relative 'input_parser'

RSpec.describe InputParser do
	describe '#self.run' do
		subject(:run) { described_class.run(input) }
		
		context 'with both valid arguments' do
			let(:input) { ['D,X,F', 'An'] }
			it 'returns the parsed arguments as objects' do
				expect(run.first).to include(a_kind_of(Patient))
				expect(run).to end_with(a_kind_of(TreatmentSession)) 			
			end
		end

		context 'with only first argument' do
			let(:input) { ['D,X,F'] }
			it 'returns the parsed arguments as objects' do
				expect(run.first).to include(a_kind_of(Patient))
				expect(run).to end_with(a_kind_of(TreatmentSession)) 			
			end
		end

		context 'with no arguments' do
			let(:input) { [] }
			it 'raises an error' do
				expect { run }.to raise_error(described_class::NeedArguments)
			end
		end

		context 'with too many arguments' do
			let(:input) { ['D,X,F', 'An', 'shdso'] }
			it 'raises an error' do
				expect { run }.to raise_error(described_class::TooManyArguments)
			end
		end

	end
end