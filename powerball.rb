require 'open-uri'
require 'csv'

#=====================================================================#
#starts class, opens and initializes the website
class PowerBall
	attr_accessor :website

	def initialize
		@website = open('http://www.powerball.com/powerball/winnums-text.txt')
	end
#=====================================================================#
#Writes to CSV file with a given set of headers
#method to save file to CSV
	def csv_save
		CSV.open("data.csv", "w") do |csv|
			csv << ['Draw Date   ', 'WB1', 'WB2', 'WB3', 'WB4', 'WB5', 'PB  PP', 'nil']
			website.each_line.with_index do |line, idx|
				next if idx == 0
				row = line.split.map { |item| item }
				csv << row
			end
		end
	end
end