lib_dir = File.dirname(__FILE__) + '/../lib'

require 'test/unit'

$:.unshift lib_dir unless $:.include?(lib_dir)
require 'whatev2whatev'
