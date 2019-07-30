class Patient

	KNOWN_DIAGNOSIS = %i(F H T D X).freeze

	class UnknownDiagnosis < StandardError; end
	
	attr_reader :diagnosis

	def self.stats(patients)
		KNOWN_DIAGNOSIS.inject({}) do |h, d| 
			h.merge(d => count_patients_with_diagnosis(patients, d)) 
		end
	end

	def self.count_patients_with_diagnosis(patients, diagnosis)
		patients.select do |patient| 
			patient.diagnosis == diagnosis 
		end.count
	end

	def initialize(diagnosis:)
		diagnosis = diagnosis.to_sym
		raise UnknownDiagnosis unless KNOWN_DIAGNOSIS.include?(diagnosis)
		@diagnosis = diagnosis
	end

	def get_treatment_effect(effect)
		@diagnosis = effect.leads_to
	end

	def resurrect_from_dead
		@diagnosis = :H if @diagnosis == :X
	end
end