require 'csv'

class CSVImport
	def initialize(file)
		@file = file		
	end
	
	def load
		first = true
		CSV.foreach(@file) do |row|
			next if row[1].nil?			
			if first
				first = false
				next
			end
			yield RowWrapper.new(row)
		end
	end			
end


class RowWrapper

	ENCODE_REPLACE_SIMBOL = '?'

	def initialize(row)
		@row = row
	end
	
	def[](position) 
		normalize @row[position]
	end	
	
	def normalize(text)
		unless text.nil?
			text.encode("UTF-8", undef: :replace, replace: ENCODE_REPLACE_SIMBOL)
				.tr("\"", "\'")
				.strip
		else
			text
		end
	end
end

