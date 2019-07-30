class PatientTreatmentSession

	attr_reader :patient, :treatment_effects, :random_healing_factor

	def self.run(patient, treatment_effects, random_healing_factor: false)
		new(patient, 
				treatment_effects: treatment_effects, 
				random_healing_factor: random_healing_factor).run
	end

	def initialize(patient, treatment_effects:, random_healing_factor:)
		@patient = patient
		@treatment_effects = applicable_treatment_effects(treatment_effects)
		@random_healing_factor = random_healing_factor
	end

	def run
		return apply_treatment_effects if @treatment_effects.any?
		return resurrect_patient if random_healing_factor
		patient
	end

	def applicable_treatment_effects(treatment_effects)
		treatment_effects.select do |effect| 
			effect.affects.include?(patient.diagnosis)
		end
	end

	def resurrect_patient
		patient.resurrect_from_dead
		patient
	end

	def apply_treatment_effects
		@treatment_effects.each do |t_e|
			patient.get_treatment_effect(t_e)
		end
		patient
	end
end