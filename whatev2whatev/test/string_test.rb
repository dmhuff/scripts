require 'test/unit'

require File.dirname(__FILE__) + '/test_helper'

require 'extensions/string'

class StringTest < Test::Unit::TestCase
  def test_to_camel_case
    assert_equal 'cheeseOnTrees', 'cheese_on_trees'.to_camel_case
    assert_equal 'cheeseOnTrees', 'Cheese on Trees'.to_camel_case
  end
end
