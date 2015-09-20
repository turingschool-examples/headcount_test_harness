require_relative 'test_helper'

class TestEnrollment < TestHarness
  class TestDropoutRateInYear < TestEnrollment
    def test_unknown_years_return_nil
      assert_equal nil, a20.enrollment.dropout_rate_in_year(232323322332)
    end

    def test_truncates_to_three_digits
      assert_equal 0.004, a20.enrollment.dropout_rate_in_year(2012)
    end
  end


  class TestDropoutRateByGenderInYear < TestEnrollment
    def test_unknown_years_return_nil
      assert_equal nil, a20.enrollment.dropout_rate_by_gender_in_year(232323322332)
    end

    def test_returns_a_hash_with_genders_as_keys_and_three_digit_floating_point_number_representing_a_percentage
      expected = {:female => 0.002, :male => 0.002}
      assert_equal expected, a20.enrollment.dropout_rate_by_gender_in_year(2011)
    end
  end


  class TestDropoutRateByRaceInYear < TestEnrollment
    def test_unknown_years_return_nil
      assert_equal nil, a20.enrollment.dropout_rate_by_race_in_year(232323322332)
    end

    def test_returns_a_hash_of_races_to_truncated_percentages_of_dropout_rates_for_that_race
      expected = {asian: 0.007, black: 0.002, hispanic: 0.006, native_american: 0.036, pacific_islander: 0.000, two_or_more: 0.000, white: 0.004}
      assert_equal expected, a20.enrollment.dropout_rate_by_race_in_year(2012)
    end
  end


  class TestDropoutRateForRaceOrEthnicity < TestEnrollment
    def test_returns_dropout_rates_as_truncated_percentages_by_race
      expected = {2011 => 0.0, 2012 => 0.007}
      assert_equal expected, a20.enrollment.dropout_rate_for_race_or_ethnicity(:asian)
    end

    def test_accepts_the_known_races
      # [:all_students, :female_students, :male_students, :native_american_students,
      #  :asian_students, :black_students, :hispanic_students, :white_students, :pacific_islander, :two_or_more_races]
      [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white].each do |race|
        assert a20.enrollment.dropout_rate_for_race_or_ethnicity(race)
      end
    end

    def test_raises_UnknownRaceError_when_given_an_unknown_race
      assert_raises UnknownRaceError do
        a20.enrollment.dropout_rate_for_race_or_ethnicity(:wat)
      end
    end
  end


  class DropoutRateForRaceOrEthnicityInYear < TestEnrollment
    def test_unknown_years_return_nil
      assert_equal nil, a20.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 232323322332)
    end

    def test_unknown_races_raise_UnknownRaceError
      assert_raises UnknownRaceError do
        a20.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:lksdjsdlkjf, 2014)
      end
    end

    def accepts_the_known_races
      [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white].each do |race|
        assert a20.enrollment.dropout_rate_for_race_or_ethnicity_in_year(race, 2012)
      end
    end

    def test_returns_a_truncated_three_digit_floating_point_number_representing_a_percentage
      assert_equal 0.007, a20.enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012)
    end
  end


  class GraduationRateByYear < TestEnrollment
    def test_returns_a_hash_of_years_to_truncated_graduation_rates
      expected = {2010 => 0.895, 2011 => 0.895, 2012 => 0.889, 2013 => 0.913, 2014 => 0.898}
      assert_equal expected, a20.enrollment.graduation_rate_by_year
    end
  end

  class GraduationRateInYear < TestEnrollment
    def test_unknown_years_return_nil
      assert_equal nil, a20.enrollment.graduation_rate_in_year(232323322332)
    end

    def test_returns_a_truncated_three_digit_floating_point_number_representing_a_percentage
      assert_equal 0.895, a20.enrollment.graduation_rate_in_year(2010)
    end
  end


  class KindergartenParticipationByYear < TestEnrollment
    def test_returns_a_hash_of_years_to_truncated_kindergarten_participation_percentages
      expected = {
        2004 => 0.302,
        2005 => 0.267,
        2006 => 0.353,
        2007 => 0.391,
        2008 => 0.384,
        2009 => 0.390,
        2010 => 0.436,
        2011 => 0.489,
        2012 => 0.478,
        2013 => 0.487,
        2014 => 0.490,
      }
      assert_equal expected, a20.enrollment.kindergarten_participation_by_year
    end
  end

  class KindergartenParticipationInYear < TestEnrollment
    def test_unknown_years_return_nil
      assert_equal nil, a20.enrollment.kindergarten_participation_in_year(232323322332)
    end

    def test_returns_a_truncated_three_digit_floating_point_number_representing_a_percentage
      assert_equal 0.436, a20.enrollment.kindergarten_participation_in_year(2010)
    end
  end


  class OnlineParticipationByYear < TestEnrollment
    def test_returns_a_hash_of_years_to_online_participations
      expected = {2011=>33, 2012=>35, 2013=>341}
      assert_equal expected, a20.enrollment.online_participation_by_year
    end
  end


  class OnlineParticipationInYear < TestEnrollment
    def test_unknown_years_return_nil
      assert_equal nil, a20.enrollment.online_participation_in_year(232323322332)
    end

    def test_returns_an_integer_indicating_the_online_participation_for_that_year
      assert_equal 341, a20.enrollment.online_participation_in_year(2013)
    end
  end


  class ParticipationByYear < TestEnrollment
    def test_returns_a_hash_of_years_to_participation_amounts
      expected = {2009=>22620, 2010=>23119, 2011=>23657, 2012=>23973, 2013=>24481, 2014=>24578}
      assert_equal expected, a20.enrollment.participation_by_year
    end
  end


  class ParticipationInYear < TestEnrollment
    def test_unknown_years_return_nil
      assert_equal nil, a20.enrollment.participation_in_year(232323322332)
    end

    def test_returns_an_integer_indicating_the_participation_for_that_year
      assert_equal 22620, a20.enrollment.participation_in_year(2009)
    end
  end


  class ParticipationByRceOrEthnicity < TestEnrollment
    def test_accepts_the_known_races
      [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white].each do |race|
        assert a20.enrollment.participation_by_race_or_ethnicity(race)
      end
    end

    def test_raises_UnknownRaceError_when_given_an_unknown_race
      assert_raises UnknownRaceError do
        a20.enrollment.participation_by_race_or_ethnicity(:wat)
      end
    end

    def test_returns_a_hash_with_years_as_keys_and_a_three_digit_floating_point_number_representing_a_percentage
      expected = {2007=>0.05, 2008=>0.054, 2009=>0.055, 2010=>0.04, 2011=>0.036, 2012=>0.038, 2013=>0.038, 2014=>0.037}
      assert_equal expected, a20.enrollment.participation_by_race_or_ethnicity(:asian)
    end
  end


  class ParticipationByRaceOrEthnicityInYear < TestEnrollment
    def test_unknown_years_return_nil
      assert_equal nil, a20.enrollment.participation_by_race_or_ethnicity_in_year(232323322332)
    end

    def test_returns_a_hash_with_race_markers_as_keys_and_a_three_digit_floating_point_number_representing_a_percentage
      expected = {
        native_american:  0.004,
        asian:            0.038,
        black:            0.031,
        hispanic:         0.121,
        pacific_islander: 0.004,
        two_or_more:      0.053,
        white:            0.750,
      }
      assert_equal expected, a20.enrollment.participation_by_race_or_ethnicity_in_year(2012)
    end
  end


  class SpecialEducationByYear < TestEnrollment
    def test_returns_a_hash_with_years_as_keys_and_an_floating_point_three_significant_digits_representing_a_percentage
      expected = {
        2009 => 0.075,
        2010 => 0.078,
        2011 => 0.079,
        2012 => 0.078,
        2013 => 0.079,
        2014 => 0.079,
      }
      assert_equal expected, a20.enrollment.special_education_by_year
    end
  end


  class SpecialEducationInYear < TestEnrollment
    def test_unknown_years_return_nil
      assert_equal nil, a20.enrollment.special_education_in_year(232323322332)
    end

    def test_returns_a_single_three_digit_floating_point_percentage
      assert_equal 0.079, a20.enrollment.special_education_in_year(2013)
    end
  end


  class RemediationByYear < TestEnrollment
    def test_returns_a_hash_with_years_as_keys_and_a_floating_point_three_significant_digits_representing_a_percentage
      expected = {
        2009 => 0.264,
        2010 => 0.294,
        2011 => 0.263,
      }
      assert_equal expected, a20.enrollment.remediation_by_year
    end
  end


  class RemediationInYear < TestEnrollment
    def test_unknown_years_return_nil
      assert_equal nil, a20.enrollment.remediation_in_year(232323322332)
    end

    def test_returns_a_single_three_digit_floating_point_percentage
      assert_equal 0.294, a20.enrollment.remediation_in_year(2010)
    end
  end
end
