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
end
