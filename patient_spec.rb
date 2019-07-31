require 'rspec'
require_relative 'patient'

RSpec.describe Patient do
	subject(:new_patient) { described_class.new(diagnosis: diagnosis) }
	let(:diagnosis) { :F }
	
	describe '#new' do		
		context 'with valid parameters' do			
			it 'instantiates a new patient' do
				expect(new_patient.diagnosis).to eq diagnosis
			end
		end

		context 'with invalid parameters' do
			let(:diagnosis) { :invalid }
			
			it 'raises an error' do
				expect { new_patient.diagnosis }.to raise_error(::Patient::UnknownDiagnosis)
			end
		end
	end

	describe '#get_treatment_effect' do
		subject(:treat) { new_patient.get_treatment_effect(effect) }
		let(:effect) { double(leads_to: :H) }

		it 'changes the diagnosis according to the treatment effect' do
			expect { treat }.to change { new_patient.diagnosis }.from(diagnosis).to(effect.leads_to)
		end
	end

	describe '#resurrect_from_dead' do
		subject(:resurrect) { new_patient.resurrect_from_dead }
		
		context 'when the patient was in fact dead' do
			let(:diagnosis) { :X }
			it 'changes the diagnosis according to the treatment effect' do
				expect { resurrect }.to change { new_patient.diagnosis }.from(diagnosis).to(:H)
			end
		end

		context 'when the patient was not dead' do
			it 'changes the diagnosis according to the treatment effect' do
				expect { resurrect }.to_not change { new_patient.diagnosis }
			end
		end
	end

	describe '#self.stats' do
		subject(:stats) { described_class.stats(patients) }
		let(:patients) { described_class::KNOWN_DIAGNOSIS.map { |d| described_class.new(diagnosis: d) } }
		let(:expected_stats) { {F: 1, H: 1, T: 1, D: 1, X: 1} }
		
		it 'provides the patient stats' do
			expect(stats).to eq expected_stats
		end
	end
end