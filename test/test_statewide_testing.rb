require_relative 'test_helper'

class TestStatewideTesting < TestHarness
  class ProficientByGrade < TestStatewideTesting
    def test_it_accepts_grades_of_3_and_8
      assert a20.statewide_testing.proficient_by_grade(3)
      assert a20.statewide_testing.proficient_by_grade(8)
    end

    def test_grades_outside_the_accepted_domain_raise_an_UnknownDataError
      assert_raises UnknownDataError do
        a20.statewide_testing.proficient_by_grade(4)
      end
    end

    def test_it_returns_a_hash_whose_keys_are_years_and_values_are_hashes_of_subjects_to_grades
      actual   = a20.statewide_testing.proficient_by_grade(3)
      expected = {
        2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
        2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
        2010 => {:math => 0.849, :reading => 0.864, :writing => 0.662},
        2011 => {:math => 0.819, :reading => 0.867, :writing => 0.678},
        2012 => {:math => 0.830, :reading => 0.870, :writing => 0.655},
        2013 => {:math => 0.855, :reading => 0.859, :writing => 0.668},
        2014 => {:math => 0.834, :reading => 0.831, :writing => 0.639}
      }
      assert_equal expected, actual
    end
  end


  class ProficientByRaceOrEthnicity < TestStatewideTesting
    def test_it_accepts_any_race_from_the_domain_of_asian___black___pacific_islander___hispanic___native_american___two_or_more___white
      [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white].each do |race|
        assert a20.statewide_testing.proficient_by_race_or_ethnicity(race)
      end
    end

    def test_grades_outside_the_accepted_domain_raise_an_UnknownDataError
      assert_raises UnknownDataError do
        a20.statewide_testing.proficient_by_race_or_ethnicity(:relay)
      end
    end

    def test_it_returns_a_hash_grouped_by_race_referencing_percentages_by_subject_all_as_truncated_three_digit_floats
      actual   = a20.statewide_testing.proficient_by_race_or_ethnicity(:asian)
      expected = {
        2011 => {math: 0.816, reading: 0.897, writing: 0.826},
        2012 => {math: 0.818, reading: 0.893, writing: 0.808},
        2013 => {math: 0.805, reading: 0.901, writing: 0.810},
        2014 => {math: 0.800, reading: 0.855, writing: 0.789},
      }
      assert_equal expected, actual
    end
  end

  class ProficientForSubjectByGradeInYear < TestStatewideTesting
    def test_it_accepts_any_subject_from_math_reading_or_writing
      [:math, :reading, :writing].each do |subject|
        assert a20.statewide_testing.proficient_for_subject_by_grade_in_year(subject, 3, 2014)
      end
    end

    def test_it_accepts_any_grade_from_3_and_8
      [3, 8].each do |grade|
        assert a20.statewide_testing.proficient_for_subject_by_grade_in_year(:math, grade, 2014)
      end
    end

    def test_it_accepts_any_year_reported_in_the_data
      [2008, 2009, 2010, 2011, 2012, 2013, 2014].each do |year|
        assert a20.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, year)
      end
    end

    def test_inputs_outside_the_accepted_domain_raise_an_UnknownDataError
      assert_raises UnknownDataError do
        a20.statewide_testing.proficient_for_subject_by_grade_in_year(:science, 3, 2014)
      end
      assert_raises UnknownDataError do
        a20.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 4, 2014)
      end
      assert_raises UnknownDataError do
        a20.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2007)
      end
    end

    def test_it_returns_the_proficiency_for_that_grade_in_that_subject_during_that_year
      assert_equal 0.857, a20.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
    end
  end


  class ProficientForSubjectByRaceInYear < TestStatewideTesting
    def test_it_accepts_any_subject_from_math_reading_or_writing
      [:math, :reading, :writing].each do |subject|
        assert a20.statewide_testing.proficient_for_subject_by_race_in_year(subject, :asian, 2012)
      end
    end

    def test_it_accepts_any_race_from_the_domain_of_asian___black___pacific_islander___hispanic___native_american___two_or_more___white
      [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white].each do |race|
        assert a20.statewide_testing.proficient_for_subject_by_race_in_year(:math, race, 2012)
      end
    end

    def test_it_accepts_any_year_reported_in_the_data
      [2011, 2012, 2013, 2014].each do |year|
        assert a20.statewide_testing.proficient_for_subject_by_race_in_year(:math, :asian, year)
      end
    end

    def test_inputs_outside_the_accepted_domain_raise_an_UnknownDataError
      assert_raises UnknownDataError do
        a20.statewide_testing.proficient_for_subject_by_race_in_year(:science, :asian, 2012)
      end
      assert_raises UnknownDataError do
        a20.statewide_testing.proficient_for_subject_by_race_in_year(:math, :not_a_race, 2012)
      end
      assert_raises UnknownDataError do
        a20.statewide_testing.proficient_for_subject_by_race_in_year(:math, :asian, 2010)
      end
      assert_raises UnknownDataError do
        a20.statewide_testing.proficient_for_subject_by_race_in_year(:math, :asian, 2015)
      end
    end

    def test_it_returns_the_proficiency_for_that_grade_in_that_subject_during_that_year
      assert_equal 0.818, a20.statewide_testing.proficient_for_subject_by_race_in_year(:math, :asian, 2012)
    end
  end

  class ProficientForSubjectInYear < TestStatewideTesting
    def test_it_accepts_any_subject_from_math_reading_or_writing
      [:math, :reading, :writing].each do |subject|
        assert a20.statewide_testing.proficient_for_subject_in_year(subject, 2012)
      end
    end

    def test_it_accepts_any_year_reported_in_the_data
      [2011, 2012, 2013, 2014].each do |year|
        assert a20.statewide_testing.proficient_for_subject_in_year(:math, year)
      end
    end

    def test_inputs_outside_the_accepted_domain_raise_an_UnknownDataError
      assert_raises UnknownDataError do
        a20.statewide_testing.proficient_for_subject_in_year(:science, 2012)
      end
      assert_raises UnknownDataError do
        a20.statewide_testing.proficient_for_subject_in_year(:math, 2010)
      end
      assert_raises UnknownDataError do
        a20.statewide_testing.proficient_for_subject_in_year(:math, 2015)
      end
    end

    def test_it_returns_the_proficiency_for_that_grade_in_that_subject_during_that_year
      assert_equal 0.680, a20.statewide_testing.proficient_for_subject_in_year(:math, 2011)
      assert_equal 0.689, a20.statewide_testing.proficient_for_subject_in_year(:math, 2012)
    end
  end
end
