require_relative 'test_helper'

class TestHeadcountAnalyst < TestHarness
  def test_top_statewide_testing_year_over_year_growth_returns_the_name_of_district_with_the_highest_average_percentage_growth_for_the_given_subject_in_3rd_grade
    skip
    ha = HeadcountAnalyst.new(repo)
    result = ha.top_statewide_testing_year_over_year_growth_in_3rd_grade(:math)
    assert_equal result, []
  end
end
