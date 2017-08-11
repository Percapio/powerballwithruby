require 'csv'

class Frequency
	attr_reader :read_file

	def initialize
		@read_file = Hash.new()
		read_csv
	end

	def read_csv
		CSV.open("data.csv", 'r').each_with_index do |row, idx|
			next if idx < 1
			hash_set(row)
		end

		read_file
	end

#====================================================================#
#Determines the number of lottery numbers played since 11/01/1997
	def hash_set(row)
		hash_array = []
		date = row.first

		row.map.with_index do |el, idx|
			case idx
			when 1..5
				hash_array << el.to_i
			when 6
				read_file[date] = [hash_array, el.to_i]
			end
		end

		read_file
	end

#====================================================================#
#Counts all the numbers to see the frequency of number that have won
#  for both the regular lottery numbers and Power Ball numbers.
	def lottery_counter
		lot_array = []

		read_file.each do |key, value|
			lottery, pb = value
			lot_array << lottery
		end

		lottery_hash = Hash.new(0)
		lot_array.flatten.each { |el| lottery_hash[el] += 1 }
		
		lottery_hash.sort_by { |_key, value| value }.reverse.to_h
	end

	def pb_counter
		pb_array = []

		read_file.each do |key, value|
			lottery, pb = value
			pb_array << pb
		end

		pb_hash = Hash.new(0)
		pb_array.sort.each { |el| pb_hash[el] += 1 }

		pb_hash.sort_by { |_key, value| value }.reverse.to_h
	end

#====================================================================#
#Allows the user to choose between which they can view:
#  	1 for lottery numbers
# 	2 for Power Ball numbers
#  	3 for all
	def top(choice = 3, nums = 5)
		case choice
		when 1
			lot_set(nums).first
		when 2
			lot_set(nums).last
		when 3
			lot_set(nums)
		end
	end

	def lot_set(nums)
		lot_set = lottery_counter
		pb_set = pb_counter
		outbound = [[], []]

		lot_set.each do |key, value|
			break if outbound.first.size == nums
			outbound.first << key
		end

		pb_set.each do |key, value|
			break if outbound.last.size == nums
			outbound.last << key
		end

		outbound
	end

#====================================================================#
#Allows the user to generate a ticket based upon top 10 lottery number
#  samples and top 3 Power Ball sample.
	def randomize
		lottery = lot_set(10).first.sample(5)
		powerball = lot_set(3).last.sample

		"Lotter Numbers: #{lottery}\nPowerBall Number: #{powerball}"
	end
end