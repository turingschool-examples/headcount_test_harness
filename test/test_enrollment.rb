require_relative 'test_helper'

class TestEnrollment < TestHarness
  # def test_something
  #   district = repo.find_by_name('ACADEMY 20')
  #   assert_equal 22620, district.enrollment.in_year(2009)
  #   assert_equal 0.895, district.enrollment.graduation_rate.for_high_school_in_year(2010)
  #   assert_equal 0.857, district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  # end

  class TestDropoutRateInYear < TestEnrollment
    # .dropout_rate_in_year(year)

    # This method takes one parameter:

    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.

    # The method returns a truncated three-digit floating point number representing a percentage.

    # Example:

    # enrollment.dropout_rate_in_year(2012) # => 0.680
  end

  class TestDropoutRateByGenderInYear < TestEnrollment
    # .dropout_rate_by_gender_in_year(year)

    # This method takes one parameter:

    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.

    # The method returns a hash with genders as keys and three-digit floating point number representing a percentage.

    # Example:

    # enrollment.dropout_rate_by_gender_in_year(2012)
    # # => {:female => 0.002, :male => 0.002}
  end

  class TestDropoutRateByRaceInYear < TestEnrollment
    # .dropout_rate_by_race_in_year(year)

    # This method takes one parameter:

    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.

    # The method returns a hash with race markers as keys and a three-digit floating point number representing a percentage.

    # Example:

    # enrollment.dropout_rate_by_race_in_year(2012)
    # # => {
    #   :asian => 0.001,
    #   :black => 0.001,
    #   :pacific_islander => 0.001,
    #   :hispanic => 0.001,
    #   :native_american => 0.001,
    #   :two_or_more => 0.001,
    #   :white => 0.001
    # }
  end

  class TestDropoutRateForRaceOrEthnicity < TestEnrollment
    # .dropout_rate_for_race_or_ethnicity(race)

    # This method takes one parameter:

    # race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # A call to this method with any unknown race should raise an UnknownRaceError.

    # The method returns a hash with years as keys and a three-digit floating point number representing a percentage.

    # Example:

    # enrollment.dropout_rate_for_race_or_ethnicity(:asian)
    # # => {
    #   2011 => 0.047,
    #   2012 => 0.041
    # }
  end

  class DropoutRateForRaceOrEthnicityInYear < TestEnrollment
    # .dropout_rate_for_race_or_ethnicity_in_year(race, year)

    # This method takes two parameters:

    # race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.

    # The method returns a truncated three-digit floating point number representing a percentage.

    # Example:

    # enrollment.dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012) # => 0.001
  end

  class GraduationRateByYear < TestEnrollment
    # .graduation_rate_by_year

    # This method returns a hash with years as keys and a truncated three-digit floating point number representing a percentage.

    # Example:

    # enrollment.graduation_rate_by_year
    # # => {2010 => 0.895,
    #       2011 => 0.895,
    #       2012 => 0.889,
    #       2013 => 0.913,
    #       2014 => 0.898,
    #      }
  end

  class GraduationRateInYear < TestEnrollment
    # .graduation_rate_in_year(year)

    # This method takes one parameter:

    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.

    # The method returns a truncated three-digit floating point number representing a percentage.

    # Example:

    # enrollment.graduation_rate_in_year(2010) # => 0.895
  end

  class KindergartenParticipationByYear < TestEnrollment
    # .kindergarten_participation_by_year

    # This method returns a hash with years as keys and a truncated three-digit floating point number representing a percentage.

    # Example:

    # enrollment.kindergarten_participation_by_year
    # # => {2010 => 0.391,
    #       2011 => 0.353,
    #       2012 => 0.267,
    #       2013 => 0.487,
    #       2014 => 0.490,
    #      }
  end

  class KindergartenParticipationInYear < TestEnrollment
    # .kindergarten_participation_in_year(year)

    # This method takes one parameter:

    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.

    # The method returns a truncated three-digit floating point number representing a percentage.

    # Example:

    # enrollment.kindergarten_participation_in_year(2010) # => 0.391
  end

  class OnlineParticipationByYear < TestEnrollment
    # .online_participation_by_year

    # This method returns a hash with years as keys and an integer as the value.

    # Example:

    # enrollment.online_participation_by_year
    # # => {2010 => 16,
    #       2011 => 18,
    #       2012 => 24,
    #       2013 => 32,
    #       2014 => 40,
    #      }
  end

  class OnlineParticipationInYear < TestEnrollment
    # .online_participation_in_year(year)

    # This method takes one parameter:

    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.

    # The method returns a single integer.

    # Example:

    # enrollment.online_participation_in_year(2013) # => 33
  end

  class ParticipationByYear < TestEnrollment
    # .participation_by_year

    # This method returns a hash with years as keys and an integer as the value.

    # Example:

    # enrollment.participation_by_year
    # # => {2009 => 22620,
    #       2010 => 22620,
    #       2011 => 23119,
    #       2012 => 23657,
    #       2013 => 23973,
    #       2014 => 24578,
    #      }
  end

  class ParticipationInYear < TestEnrollment
    # .participation_in_year(year)

    # This method takes one parameter:

    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.

    # The method returns a single integer.

    # Example:

    # enrollment.participation_in_year(2013) # => 23973
  end

  class ParticipationByRceOrEthnicity < TestEnrollment
    # .participation_by_race_or_ethnicity(race)

    # This method takes one parameter:

    # race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # A call to this method with any unknown race should raise an UnknownRaceError.

    # The method returns a hash with years as keys and a three-digit floating point number representing a percentage.

    # Example:

    # enrollment.participation_by_race_or_ethnicity(:asian)
    # # => {
    #   2011 => 0.047,
    #   2012 => 0.041,
    #   2013 => 0.052,
    #   2014 => 0.056
    # }
  end

  class ParticipationByRaceOrEthnicityInYear < TestEnrollment
    # .participation_by_race_or_ethnicity_in_year(year)

    # This method takes one parameter:

    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.

    # The method returns a hash with race markers as keys and a three-digit floating point number representing a percentage.

    # Example:

    # enrollment.participation_by_race_or_ethnicity_in_year(2012)
    # # => {
    #   :asian => 0.036,
    #   :black => 0.029,
    #   :pacific_islander => 0.118,
    #   :hispanic => 0.003,
    #   :native_american => 0.004,
    #   :two_or_more => 0.050,
    #   :white => 0.756
    # }
  end

  class SpecialEducationByYear < TestEnrollment
    # .special_education_by_year

    # This method returns a hash with years as keys and an floating point three-significant digits representing a percentage.

    # Example:

    # enrollment.participation_by_year
    # # => {2009 => 0.075,
    #       2010 => 0.078,
    #       2011 => 0.072,
    #       2012 => 0.071,
    #       2013 => 0.070,
    #       2014 => 0.068,
    #      }
  end

  class SpecialEducationInYear < TestEnrollment
    # .special_education_in_year(year)

    # This method takes one parameter:

    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.

    # The method returns a single three-digit floating point percentage.

    # Example:

    # enrollment.special_education_in_year(2013) # => 0.105
  end

  class RemediationByYear < TestEnrollment
    # .remediation_by_year

    # This method returns a hash with years as keys and an floating point three-significant digits representing a percentage.

    # Example:

    # enrollment.participation_by_year
    # # => {2009 => 0.232,
    #       2010 => 0.251,
    #       2011 => 0.278
    #      }
  end

  class RemediationInYear < TestEnrollment
    # .remediation_in_year(year)

    # This method takes one parameter:

    # year as an integer for any year reported in the data
    # A call to this method with any unknown year should return nil.

    # The method returns a single three-digit floating point percentage.

    # Example:

    # enrollment.remediation_in_year(2010) # => 0.250
  end
end
