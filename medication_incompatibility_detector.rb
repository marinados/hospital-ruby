class MedicationIncompatibilityDetector
	
	MEDICATION_INCOMPATIBILITIES = {
		As: {
			with: :P, affects: ::Patient::KNOWN_DIAGNOSIS, leads_to: :X
		},
		I: {
			with: :An, affects: [:H], leads_to: :F
		}, 
	}.freeze

	private_constant :MEDICATION_INCOMPATIBILITIES

	def self.run(formulae)
		new(formulae).run
	end

	def initialize(formulae)
		@formulae = formulae
	end

	def run
		@_incompatibilities ||= 
			MEDICATION_INCOMPATIBILITIES.slice(*@formulae).
				select do |k, inc|
					@formulae.include?(inc[:with])
				end
	end
end