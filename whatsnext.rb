#!/usr/bin/env ruby

# A script that searches a directory structure, and prints the next task for
# each project directory found. In this context, a project directory is one
# that contains a next.txt file; the next task for the project is the first
# line of that file.
#
# Author::    Dave Huffman (dave \dot huffman \at me \dot com)
# Copyright:: Copyright (c) 2013 Dave Huffman
# License::   None - copy and use as you see fit.

TASK_FILE = 'next.txt'

NextTask = Struct.new(:project, :date, :task)

# Handle the CLI parameters.
if ARGV.first == '--help' || ARGV.first == '-h'
  puts 'Print the next task for each project directory found. ' \
       "Tasks are stored in #{TASK_FILE} files."
  puts " usage: #{File.basename(__FILE__)} [directory]"
  exit
end

# Find all task files, starting in the current directory and all subdirectories,
# following symlinks once (glob from http://stackoverflow.com/a/357798).
files = File.exists?(TASK_FILE) ? [File.expand_path(TASK_FILE)] : []
files.concat(Dir.glob("**/*/**/#{TASK_FILE}"))

# Build a list of task objects.
files.each do |file_name|
  puts file_name
end

# Print a report of tasks found.
# TODO
