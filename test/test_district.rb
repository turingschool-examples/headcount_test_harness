require_relative 'test_helper'

class TestDistrict < TestHarness
  def test_name_returns_the_upcased_string_name_of_the_district
    assert_equal 'COLORADO', repo.find_by_name('colorado').name
  end

  def test_enrollment_returns_the_districts_enrollment
    assert_equal 22620, a20.enrollment.participation_in_year(2009)
  end

  def test_statewide_testing_returns_the_districts_statewide_testing
    assert_equal 0.857, a20.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end
end
