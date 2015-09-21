require_relative 'test_helper'

class TestEconomicProfile < TestHarness
  class TestFreeOrReducedLunchByYear < TestEconomicProfile
    def test_truncates_to_three_digits
      expected = {
        2000 => 0.020,
        2001 => 0.024,
        2002 => 0.027,
        2003 => 0.030,
        2004 => 0.034,
        2005 => 0.058,
        2006 => 0.041,
        2007 => 0.050,
        2008 => 0.061,
        2009 => 0.070,
        2010 => 0.079,
        2011 => 0.084,
        2012 => 0.125,
        2013 => 0.091,
        2014 => 0.087,
      }
      assert_equal expected, a20.economic_profile.free_or_reduced_lunch_by_year
    end
  end


  class TestFreeOrReducedLunchInYear < TestHarness
    def test_unknown_years_return_nil
      assert_equal nil, a20.economic_profile.free_or_reduced_lunch_in_year(232323322332)
    end

    def test_truncates_to_three_digits
      assert_equal 0.125, a20.economic_profile.free_or_reduced_lunch_in_year(2012)
    end
  end


  class TestSchoolAgedChildrenInPovertyByYear < TestHarness
    def test_returns_an_empty_hash_if_the_district_doesnt_have_this_data
      assert_equal Hash.new,
                   repo.find_by_name('colorado').economic_profile.school_aged_children_in_poverty_by_year
    end

    def test_returns_a_hash_of_years_to_percentages
      expected = {
        1995 => 0.032,
        1997 => 0.035,
        1999 => 0.032,
        2000 => 0.031,
        2001 => 0.029,
        2002 => 0.033,
        2003 => 0.037,
        2004 => 0.034,
        2005 => 0.042,
        2006 => 0.036,
        2007 => 0.039,
        2008 => 0.044,
        2009 => 0.047,
        2010 => 0.057,
        2011 => 0.059,
        2012 => 0.064,
        2013 => 0.048,
      }
      assert_equal expected, a20.economic_profile.school_aged_children_in_poverty_by_year
    end
  end


  class TestSchoolAgedChildrenInPovertyInYear < TestHarness
    def test_returns_nil_for_unknown_years
      assert_equal nil, a20.economic_profile.school_aged_children_in_poverty_in_year(8248248)
    end

    def test_returns_the_percentage_of_school_aged_children_in_poverty_for_that_year
      assert_equal 0.064, a20.economic_profile.school_aged_children_in_poverty_in_year(2012)
    end
  end


  class TestTitle1StudentsByYear < TestHarness
    def test_returns_a_hash_of_years_to_percentages
      expected = {2009 => 0.014, 2011 => 0.011, 2012 => 0.01, 2013 => 0.012, 2014 => 0.027}
      assert_equal expected, a20.economic_profile.title_1_students_by_year
    end
  end

  class TestTitle1StudentsInYear < TestHarness
    def test_returns_nil_for_unknown_years
      assert_equal nil, a20.economic_profile.title_1_students_in_year(98023)
    end

    def test_returns_a_hash_of_years_to_percentages
      assert_equal 0.012, a20.economic_profile.title_1_students_in_year(2013)
    end
  end
end
