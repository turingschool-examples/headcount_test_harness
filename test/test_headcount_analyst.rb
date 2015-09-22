require_relative 'test_helper'

class TestHeadcountAnalyst < TestHarness
  def test_top_statewide_testing_year_over_year_growth_returns_the_name_of_district_with_the_highest_average_percentage_growth_for_the_given_subject_in_3rd_grade
    ha = HeadcountAnalyst.new(repo)
    result = ha.top_statewide_testing_year_over_year_growth_in_3rd_grade(:math)
    assert_equal result, ["WILEY RE-13 JT", 0.300]
  end

  def test_kindergarten_participation_rate_variation_returns_a_floating_point_value_truncated_to_three_decimels
    ha = HeadcountAnalyst.new(repo)

    assert_equal -0.123, ha.kindergarten_participation_rate_variation("ACADEMY 20")
  end
end
