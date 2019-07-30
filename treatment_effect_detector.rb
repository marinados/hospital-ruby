class TreatmentEffectDetector

	class Effect
		attr_reader :caused_by, :affects, :leads_to

		def initialize(effect)
			key = effect.keys.first
			@caused_by = [key, effect[key][:with]].compact
			@affects = effect[key][:affects]
			@leads_to = effect[key][:leads_to]
		end
	end

	MEDICATION_INCOMPATIBILITIES = {
		As: {
			with: :P, affects: ::Patient::KNOWN_DIAGNOSIS, leads_to: :X
		},
		I: {
			with: :An, affects: [:H], leads_to: :F
		}, 
	}.freeze

	THERAPEUTIC_EFFECTS = {
		As: { affects: [:F], leads_to: :H },
		An: { affects: [:T], leads_to: :H },
		I: { affects: [:D], leads_to: :D },
		P: { affects: [:F], leads_to: :H }
	}.freeze

	MISSING_VITAL_MEDICATION = {
		I: { affects: [:D], leads_to: :X }
	}

	private_constant :MEDICATION_INCOMPATIBILITIES
	private_constant :THERAPEUTIC_EFFECTS
	private_constant :MISSING_VITAL_MEDICATION

	attr_reader :formulae

	def self.run(medication)
		new(medication).run
	end

	def initialize(medication)
		@formulae = medication.map(&:formula)
	end

	def run
		therapeutic_effects.merge(missing_medication).
			merge(incompatibilities).map do |formula, effect| 
				Effect.new(formula => effect) 
			end
	end

	private

	def missing_medication
		@_missing_medication ||= 
			MISSING_VITAL_MEDICATION.select do |k, _v| 
				!formulae.include?(k)
			end
	end

	def incompatibilities
		@_incompatibilities ||= 
			MEDICATION_INCOMPATIBILITIES.slice(*formulae).
				select do |_, inc|
					next unless formulae.include?(inc[:with])
				end
	end

	def therapeutic_effects
		@_therapeutic_effects ||= THERAPEUTIC_EFFECTS.slice(*formulae)
	end
end
