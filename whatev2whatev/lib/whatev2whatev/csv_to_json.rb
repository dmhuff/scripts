#!/usr/bin/env ruby

require 'singleton'

require 'csv'
require 'json'

# Singleton class for parsing a CSV string into a string array of JSON objects.
#
class CsvToJson
  include Singleton

  # Parse a CSV string into JSON.
  #
  def parse(csv)
    # Parse the raw CSV string.
    data = CSV.parse(csv)

    # Treat the first row in the file as the header row (we'll use it for key
    # values later on).
    headers = data.shift

    objects = data.map do |datum|
      hash = {}
      datum.each_with_index do |value, i|
        key = headers[i].strip.to_camel_case
        hash[key] = value.strip
      end
      hash
    end

    objects.to_json
  end
end

