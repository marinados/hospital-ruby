class Medicine
	KNOWN_FORMULAE = %i(As An I P).freeze

	private_constant :KNOWN_FORMULAE

	class UnknownFormula < StandardError; end
	
	attr_reader :formula

	def initialize(formula:)
		formula = formula.to_sym
		raise UnknownFormula unless KNOWN_FORMULAE.include?(formula)
		@formula = formula
	end
end