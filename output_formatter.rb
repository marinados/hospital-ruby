class OutputFormatter
	def self.run(outcomes)
		outcomes.each do |key, value|
			p "#{key}:#{value}"
		end
	end
end