require_relative 'patient'
require_relative 'treatment_session'

class InputParser
	class NeedArguments < StandardError; end
	class TooManyArguments < StandardError; end

	attr_reader :input 

	def initialize(input)
		@input = input
	end

	def run
		check_arguments
		parse_input
	end

	def self.run(input)
		new(input).run
	end

	private

	def check_arguments
		raise NeedArguments if input.count < 1
		raise TooManyArguments if input.count >2 
	end

	def parse_input
		patients = input.first.split(',').map { |pat| parse_patient(pat) }
		
		treatment = parse_treatment(input[1])
		[patients, treatment]
	end

	def parse_patient(diagnosis)
		Patient.new(diagnosis: diagnosis)
	end

	def parse_treatment(codes)
		formulae = codes&.split(',') || []
		TreatmentSession.new(medication_list: formulae)
	end
end