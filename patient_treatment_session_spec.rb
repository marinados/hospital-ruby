require 'rspec'
require_relative 'patient_treatment_session'
require_relative 'patient'

RSpec.describe PatientTreatmentSession do
	describe '#self.run' do
		subject(:run) do 
			described_class.run(
				patient, 
				treatment_effects, 
				random_healing_factor: random_healing_factor
			) 
		end
		let(:outcome) { :H }
		let(:patient) { Patient.new(diagnosis: diagnosis)}
		let(:random_healing_factor) { false }

		context 'if there are some treatment effects for the given patient' do
			let(:diagnosis) { :F }
			let(:treatment_effects) { [double(affects: [diagnosis], leads_to: outcome)] }

			it 'applies the treatment' do
				expect { run }.to change { patient.diagnosis }.from(diagnosis).to(outcome)
			end
		end

		context 'if there are no treatment effects for the given patient' do
			let(:diagnosis) { :F }
			let(:treatment_effects) { [double(affects: [:something_else], leads_to: outcome)] }

			it 'applies the treatment' do
				expect { run }.to_not change { patient.diagnosis }
			end
		end
	end
end