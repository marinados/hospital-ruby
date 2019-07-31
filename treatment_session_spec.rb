require 'rspec'
require_relative 'treatment_session'

RSpec.describe TreatmentSession do
	let(:medication_list) { [:An, :I] }
	
	subject(:new_session) { described_class.new(medication_list: medication_list)}
	
	describe '#new' do 
	  it 'defines the treatment effects and the random healing factor at initialize' do
	    expect(new_session.treatment_effects).to satisfy do |value| 
	    	value.all? { |effect| effect.is_a?(::TreatmentEffectDetector::Effect) } 
	    end

	    expect(new_session.random_healing_factor).to be(true).or be(false)
	  end
	end

	describe '#run' do 
		let(:patient) { double }
		subject(:run) { new_session.run(patient) }
		let(:expected_arguments) do 
			[patient, 
			 new_session.treatment_effects, 
			 random_healing_factor: new_session.random_healing_factor] 
		end

	  it 'calls the individual patient oriented treatment service' do
	    expect(::PatientTreatmentSession).to receive(:run).with(*expected_arguments)
	    run
	  end
	end

end
