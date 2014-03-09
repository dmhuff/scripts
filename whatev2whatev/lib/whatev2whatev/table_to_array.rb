#!/usr/bin/env ruby

require 'singleton'

require 'nokogiri'

class TableToArray
  include Singleton

  def parse(html)
    # Parse the HTML with Nokogiri and extract the table element.
    table = Nokogiri::HTML(html).css('table')

    # raise 'Multiple tables found, expected one!' unless table.length == 1

    # Transform each row in the table to an array of values.
    [].concat(table.css('tr').map do |tr|
      # Gather the header and data cells.
      row = [].concat(tr.css('th')).concat(tr.css('td'))
      # Extract the text from each cell.
      row.map { |cell| cell.inner_text.strip }
    end)
  end
end

