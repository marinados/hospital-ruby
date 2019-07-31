require 'rspec'
require_relative 'treatment_effect_detector'

RSpec.describe TreatmentEffectDetector do
	describe '#self.run' do
		let(:medication) { [double(formula: :I)] }
		
		subject(:run) { described_class.run(medication) }
		
		context 'just pure therapeutic effects' do
			let(:expected_effects) do 
				[described_class::Effect.new(I: { affects: [:D], leads_to: :D })]
			end
			
			it 'provides a list of effects that a given list of medication has' do
				expect(run.map(&:caused_by)).to match_array expected_effects.map(&:caused_by)
				expect(run.map(&:affects)).to match_array expected_effects.map(&:affects)
				expect(run.map(&:leads_to)).to match_array expected_effects.map(&:leads_to)
			end
		end

		context 'therapeutic effects and incompatibilities' do
			let(:medication) { [double(formula: :I), double(formula: :An)] }
			let(:expected_effects) do 
				[described_class::Effect.new(I: { affects: [:D], leads_to: :D }), 
				 described_class::Effect.new(An: { affects: [:T], leads_to: :H }),
				 described_class::Effect.new(I: {
					with: :An, affects: [:H], leads_to: :F
				})]
			end
			
			it 'provides a list of effects that a given list of medication has' do
				expect(run.map(&:caused_by)).to match_array expected_effects.map(&:caused_by)
				expect(run.map(&:affects)).to match_array expected_effects.map(&:affects)
				expect(run.map(&:leads_to)).to match_array expected_effects.map(&:leads_to)
			end
		end

		context 'therapeutic effects and incompatibilities and missing medication' do
			let(:medication) { [double(formula: :As), double(formula: :P)] }
			let(:expected_effects) do 
				[described_class::Effect.new(As: { affects: [:F], leads_to: :H }),
				 described_class::Effect.new(P: { affects: [:F], leads_to: :H }), 
				 described_class::Effect.new(I: { affects: [:D], leads_to: :X }),
				 described_class::Effect.new(As: {
					with: :P, affects: %i(F H T D X), leads_to: :X })
				]
			end
			
			it 'provides a list of effects that a given list of medication has' do
				expect(run.map(&:caused_by)).to match_array expected_effects.map(&:caused_by)
				expect(run.map(&:affects)).to match_array expected_effects.map(&:affects)
				expect(run.map(&:leads_to)).to match_array expected_effects.map(&:leads_to)			end
		end
	end
end