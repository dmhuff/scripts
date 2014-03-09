require 'test/unit'

require File.dirname(__FILE__) + '/test_helper'

require 'whatev2whatev/table_to_array'

class TableToArrayTest < Test::Unit::TestCase
  def test_simple
    do_test(%q{
      <html>
        <table>
          <tr> <th>FOO</th> <th>BAR</th> </tr>
          <tr> <td>1</td>   <td>2</td>   </tr>
          <tr> <td>3</td>   <td>4</td>   </tr>
        </table>
      </html>
    }, [
      ['FOO', 'BAR'],
      ['1',   '2'  ],
      ['3',   '4'  ]
    ])
  end

  def test_colspan
    do_test(%q{
      <!-- Taken from http://www.temple.edu/cs/web/tables.html -->
      <TABLE BORDER="5"    WIDTH="50%"   CELLPADDING="4" CELLSPACING="3">
        <TR>
          <TH COLSPAN="2"><BR><H3>TABLE TITLE</H3>
          </TH>
        </TR>
        <TR>
          <TH>Column A</TH>
          <TH>Column B</TH>
        </TR>
        <TR ALIGN="CENTER">
          <TD>Data 1</TD>
          <TD>Data 2</TD>
        </TR>
      </TABLE>
    }, [
      ['TABLE TITLE'           ],
      ['Column A',   'Column B'],
      ['Data 1',     'Data 2'  ]
    ])
  end

  def test_merged_cells
    do_test(%q{
      <!-- Taken from http://www.w3.org/TR/html401/struct/tables.html -->
      <TABLE border="1" summary="This table gives some statistics about fruit
                                 flies: average height and weight, and percentage
                                with red eyes (for both males and females).">
        <CAPTION><EM>A test table with merged cells</EM></CAPTION>
        <TR><TH rowspan="2"><TH colspan="2">Average
            <TH rowspan="2">Red<BR>eyes
        <TR><TH>height<TH>weight
        <TR><TH>Males<TD>1.9<TD>0.003<TD>40%
        <TR><TH>Females<TD>1.7<TD>0.002<TD>43%
      </TABLE>
    }, [
      ['',        'Average', 'Redeyes'      ],
      ['height',  'weight'                  ],
      ['Males',   '1.9',     '0.003',  '40%'],
      ['Females', '1.7',     '0.002',  '43%']
    ])
  end

  def do_test(html, expected_result)
    assert_equal expected_result, TableToArray.instance.parse(html)
  end
end
