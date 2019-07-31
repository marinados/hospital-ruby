require_relative 'patient'
require_relative 'medication_incompatibility_detector'

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

	THERAPEUTIC_EFFECTS = {
		As: { affects: [:F], leads_to: :H },
		An: { affects: [:T], leads_to: :H },
		I: { affects: [:D], leads_to: :D },
		P: { affects: [:F], leads_to: :H }
	}.freeze

	MISSING_VITAL_MEDICATION = {
		I: { affects: [:D], leads_to: :X }
	}

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
		therapeutic_effects + missing_medication + incompatibilities 
	end

	private

	def missing_medication
		@_missing_medication ||= 
			to_effect(MISSING_VITAL_MEDICATION.select do |k, _v| 
				!formulae.include?(k)
			end)
	end

	def incompatibilities
		@_incompatibilities ||= to_effect(MedicationIncompatibilityDetector.run(formulae))
	end

	def therapeutic_effects
		@_therapeutic_effects ||= to_effect(THERAPEUTIC_EFFECTS.slice(*formulae))
	end

	def to_effect(collection)
		collection.map do |formula, effect| 
			Effect.new(formula => effect) 
		end
	end
end
