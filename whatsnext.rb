#!/usr/bin/env ruby

if ARGV.first == '--help' || ARGV.first == '-h'
  puts 'Print the next task for each project directory found.'
  puts "usage: #{File.basename(__FILE__)} [directory]"
end
