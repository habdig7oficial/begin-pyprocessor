require "rainbow/refinement"
using Rainbow

path = ARGV[0]


file = File.read(path)

parsed = file.gsub /\s+/, "<space>"
parsed = parsed.gsub "\n", "<newline>"

puts parsed

puts "----"

lines = parsed.split("<newline>")

indents = 0
reordened = []

lines.each_with_index do | line, i |
   puts "#{line.dump} - #{i}"

    tokens = line.split("<space>")

 
    tokens.each_with_index do |token, j|
        if token == "begin"
            puts "\t #{token} - #{j}".red
            
            indents += 1
            reordened.push "\n"

        elsif token == "end"
            puts "\t #{token} - #{j}".green

            indents -= 1
            reordened.push "\n\n"

      # elsif token == " " && tokens[j + 1] == " "
          #  break
        else
            puts "\t #{token} - #{j}"

            tabs = indents.times.collect{ "\t" }.join
            
            reordened.push "#{tabs}#{token} "
        end

    end
    reordened.push "\n"
end

puts "----"

puts lines.join("\n")
processed = reordened.join

File.write("processed_#{ARGV[0]}", processed)