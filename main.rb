require_relative 'input_parser'
require_relative 'output_formatter'

def run_treatment(patients, treatment_session)
	patients.map { |patient| treatment_session.run(patient) }
end

def format_output(outcomes)
	OutputFormatter.run(outcomes)
end

def parse_input
	InputParser.run(ARGV)
end

patients, treatment_session = parse_input
patients = run_treatment(patients, treatment_session) if treatment_session
patient_outcomes = Patient.stats(patients)
format_output(patient_outcomes)

