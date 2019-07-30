require_relative 'patient_treatment_session'
require_relative 'treatment_effect_detector'
require_relative 'medicine'

class TreatmentSession

	RANDOM_HEALING_PROBABILITY = 1_000_000

	private_constant :RANDOM_HEALING_PROBABILITY

	attr_reader :treatment_effects, :random_healing_factor

	def initialize(medication_list:)
		medication = medication_list.map do |formula|
			::Medicine.new(formula: formula) 
		end
		@treatment_effects = ::TreatmentEffectDetector.run(medication)

		@random_healing_factor = rand(RANDOM_HEALING_PROBABILITY) == 1
	end

	def run(patient)
		::PatientTreatmentSession.run(
			patient, 
			treatment_effects, 
			random_healing_factor: random_healing_factor
		)
	end

end
