#!/usr/bin/env ruby

# A script that searches a directory structure, and prints the next task for
# each project directory found. In this context, a project directory is one
# that contains a next.txt file; the next task for the project is the first
# line of that file, formatted "#{date}: #{task}".
#
# Author::    Dave Huffman (dave \dot huffman \at me \dot com)
# Copyright:: Copyright (c) 2013 Dave Huffman
# License::   None - copy and use as you see fit.

TASK_FILE = 'next.txt'

NextTask = Struct.new(:project, :task)

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
tasks = files.map do |file_name|
  # Read the file's first line.
  first_line = nil
  File.open(file_name) do |f|
    f.each_line { |line| first_line = line; break; }
  end

  # Ensure we have something to work with.
  if first_line.nil?
    STDERR.puts "#{file_name} is empty."
    next
  end

  NextTask.new(file_name.split('/')[-2], first_line)
end

# Print a Markdown report of tasks found.
if tasks.empty?
  STDERR.puts('No tasks found.')
else
  tasks = tasks.sort { |l, r| l.task <=> r.task }
  max_project_len = tasks.map { |t| t.project }.sort { |l, r| l.length <=> r.length }.last.length

  puts 'Next tasks:',
       '===========',
       '',
       tasks.map { |t| "- #{t.project.ljust(max_project_len)} :: #{t.task}" },
       ''
end
