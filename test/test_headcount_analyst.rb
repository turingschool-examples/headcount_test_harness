require_relative 'test_helper'

class TestHeadcountAnalyst < TestHarness
  def test_top_statewide_testing_year_over_year_growth_returns_the_name_of_district_with_the_highest_average_percentage_growth_for_the_given_subject_in_3rd_grade
    ha = HeadcountAnalyst.new(repo)
    result = ha.top_statewide_testing_year_over_year_growth_in_3rd_grade(:math)
    assert_equal result, ["WILEY RE-13 JT", 0.300]
  end

  def test_kindergarten_participation_rate_variation_against_state
    ha = HeadcountAnalyst.new(repo)
    assert_equal 0.766, ha.kindergarten_participation_rate_variation('ACADEMY 20', against: 'COLORADO')
    assert_equal 1.0, ha.kindergarten_participation_rate_variation('ACADEMY 20', against: 'ACADEMY 20')
    assert_equal 0.406, ha.kindergarten_participation_rate_variation('ACADEMY 20', against: 'ASPEN 1')
    assert_raises(UnknownDataError) { ha.kindergarten_participation_rate_variation('ACADEMY 20', against: 'NOT A DISTRICT') }
    assert_raises(UnknownDataError) { ha.kindergarten_participation_rate_variation('NOT A DISTRICT', against: 'ACADEMY 20') }
  end

  def test_kindergarten_participation_against_household_income
    ha = HeadcountAnalyst.new(repo)
    assert_equal 0.501, ha.kindergarten_participation_against_household_income('ACADEMY 20')
    assert_equal 1.631, ha.kindergarten_participation_against_household_income('ASPEN 1')
    assert_equal 1.282, ha.kindergarten_participation_against_household_income('DEL NORTE C-7')
  end

  def test_kindergarten_participation_correlates_with_household_income
    ha = HeadcountAnalyst.new(repo)
    #assert_equal true, ha.kindergarten_participation_correlates_with_household_income(for: 'DEL NORTE C-7')
    assert_equal false, ha.kindergarten_participation_correlates_with_household_income(for: 'AGUILAR REORGANIZED 6')
    assert_equal false, ha.kindergarten_participation_correlates_with_household_income(for: 'COLORADO')
  end

  def test_kindergarten_participation_against_high_school_graduation_for_one_district
    ha = HeadcountAnalyst.new(repo)
    assert_equal 0.641, ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')
    assert_equal 0.222, ha.kindergarten_participation_against_high_school_graduation('CHERRY CREEK 5')
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation
    ha = HeadcountAnalyst.new(repo)
    assert_equal false, ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'CHERRY CREEK 5')
    assert_equal true, ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'ARICKAREE R-2')
    assert_equal false, ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'COLORADO')
  end
end
