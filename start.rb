require_relative 'powerball'
require_relative 'frequency'

class Prediction
	attr_reader :pb_program, :pb_freq

	def initialize
		@exit_file = false
		@pb_program = PowerBall.new
	end

	def file_check
		if !File.exist?("data.csv")
			file = false

			until file
				puts "Enter 1 to save 'data.csv' file in current folder to continue or Enter 2 to exit."
				input = gets.chomp.to_i
				
				if input == 1
					pb_program.csv_save
					file = true
					puts "File saved!"
				elsif input == 2
					puts "Good bye."
					sleep(0.5) 
					exit(true)
				else
					puts "Please enter 1 or 2."
				end
			end
		end
	end

	def start
		file_check

		@pb_freq = Frequency.new
		puts "Choose from the following: "
		until @exit_file
			display_choices
			input = gets.chomp.to_i
			break if input == 5
			choices(input)
			puts "\n"
		end

		puts "Take care."
		sleep(0.5)
	end

	def choices(input)
		case input
		when 1
			pb_program.csv_save
			puts "File saved!"
		when 2
			puts "1 for Lottery, 2 for PowerBall, 3 for All."
			choice = gets.chomp.to_i

			puts "Additionally, please give a number of values you wished returned."
			num = gets.chomp.to_i

			puts "High ----> Low"
			puts pb_freq.top(choice, num)
		when 3
			puts "How many tickets would you like to output?"
			tickets = gets.chomp.to_i

			(1..tickets).each { |el| puts pb_freq.randomize }
		when 4
			puts "Enter 1 for lottery or 2 for PowerBall"
			input_data = gets.chomp.to_i

			case input_data
			when 1
				puts "Number : Frequency"
				puts @pb_freq.lottery_counter
			when 2
				puts "Number : Frequency"
				puts @pb_freq.pb_counter
			else
				puts "Please, choose 1 or 2."
			end
		end
	end

	def display_choices
		puts "1: Save current information to CSV named 'data.csv' in current folder."
		puts "2: Show frequent lottery and/or PowerBall numbers."
		puts "3: Generate ticket based on top frequency returns."
		puts "4: Show hash of lottery and/or PowerBall data."
		puts "5: Exit."
	end
end

if $PROGRAM_NAME == __FILE__
	Prediction.new().start
end