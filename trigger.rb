#!/bin/env ruby
#require "rainbow/refinement"
#using Rainbow

path = ARGV[0]


file = File.read(path)

parsed = file.gsub "\n", "<newline>"
parsed = parsed.gsub /\s+/, "<space>"

indents = 0


parsed = parsed.split("<newline>")

global = []

lines = parsed.each_with_index do | line, i |
   #puts "#{line.dump} - #{i}"

    tokens = line.split("<space>")

    #puts tokens.inspect

    tokens.reject!(&:empty?)

    puts tokens.inspect
 
    reordened = []

    tokens.each_with_index do |token, j|
        if token == "begin"
            #puts "\t #{token} - #{j}".red
            
            indents += 1
            #reordened.push "\n"

        elsif token == "end"
            #puts "\t #{token} - #{j}".green

            indents -= 1
            #reordened.push "\n"

      # elsif token == " " && tokens[j + 1] == " "
          #  break
        elsif j == 0 
            tabs = indents.times.collect{ "\t" }.join
            reordened.push "#{tabs}#{token.strip} "
        else
            #puts "\t #{token} - #{j}"
            #puts "\t\t #{token} -> #{tokens[j + 1]} - #{j}"

            reordened.push "#{token} ".lstrip
        end
    end
   # #puts reordened.join
    reordened.push "\n"

    (global << reordened).flatten!
end

#puts "----"

processed =  global.join
#puts processed

File.write("processed_#{ARGV[0]}", processed)
system "processed_#{ARGV[0]}"