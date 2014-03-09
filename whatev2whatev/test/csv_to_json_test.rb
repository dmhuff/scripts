require 'test/unit'

require File.dirname(__FILE__) + '/test_helper'

require 'whatev2whatev/csv_to_json'

class CsvToJsonTest < Test::Unit::TestCase
  def test_conversion
    actual_json = CsvToJson.instance.parse("alpha, bravo, charlie\n1,2,3")
    expected_json = "[{\"alpha\": \"1\", \"bravo\": \"2\", \"charlie\": \"3\"}]"
    assert_equal JSON.parse(expected_json), JSON.parse(actual_json)
  end
end
