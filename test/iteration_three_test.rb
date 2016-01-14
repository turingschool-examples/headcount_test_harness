require "minitest"
require "minitest/autorun"
require_relative "../../headcount/lib/district_repository"
require_relative "../../headcount/lib/headcount_analyst"
require_relative "../../headcount/lib/economic_profile_repository"
require_relative "../../headcount/lib/economic_profile"

class IterationThreeTest < Minitest::Test
  def test_economic_profile_basics
    data = {:median_household_income => {[2014, 2015] => 50000, [2013, 2014] => 60000},
            :children_in_poverty => {2012 => 0.1845},
            :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
            :title_i => {2015 => 0.543},
           }
    ep = EconomicProfile.new(data)
    assert_equal 50000, ep.estimated_median_household_income_in_year(2015)
    assert_equal 55000, ep.median_household_income_average
    assert_in_delta 0.184, ep.children_in_poverty_in_year(2012), 0.005
    assert_in_delta 0.023, ep.free_or_reduced_price_lunch_percentage_in_year(2014), 0.005
    assert_equal 100, ep.free_or_reduced_price_lunch_number_in_year(2014)
    assert_in_delta 0.543, ep.title_i_in_year(2015), 0.005
  end

  def test_median_household_income_query_with_overlapping_and_faulty_data
    data = {:median_household_income => {[2013, 2015] => 60000,
                                         [2014, 2016] => 50000,
                                         [2007, 2015] => "N/A"}}

    ep = EconomicProfile.new(data)

    assert_raises(InsufficientInformationError) do
      ep.estimated_median_household_income_in_year(2008)
    end
    assert_equal 60000, ep.estimated_median_household_income_in_year(2013)
    assert_equal 55000, ep.estimated_median_household_income_in_year(2014)
  end

  def test_unknown_data_errors_for_non_existent_year
    data = {:median_household_income => {[2014, 2015] => 50000, [2013, 2014] => 60000},
            :children_in_poverty => {2012 => 0.1845},
            :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
            :title_i => {2015 => 0.543},
           }
    ep = EconomicProfile.new(data)
    non_existent = 2017

    assert_raises(UnknownDataError) do
      ep.estimated_median_household_income_in_year(2017)
    end

    assert_raises(UnknownDataError) do
      ep.children_in_poverty_in_year(2017)
    end

    assert_raises(UnknownDataError) do
      ep.free_or_reduced_price_lunch_percentage_in_year(2017)
    end

    assert_raises(UnknownDataError) do
      ep.free_or_reduced_price_lunch_number_in_year(2017)
    end

    assert_raises(UnknownDataError) do
      ep.title_i_in_year(2017)
    end
  end

  def test_loading_econ_profile_data
    epr = EconomicProfileRepository.new
    epr.load_data({
                    :economic_profile => {
                      :median_household_income => "./data/Median household income.csv",
                      :children_in_poverty => "./data/School-aged children in poverty.csv",
                      :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
                      :title_i => "./data/Title I students.csv"
                    }
                  })
    ["ACADEMY 20","WIDEFIELD 3","ROARING FORK RE-1","MOFFAT 2","ST VRAIN VALLEY RE 1J"].each do |dname|
      assert epr.find_by_name(dname).is_a?(EconomicProfile)
    end
  end

  def district_repo
    dr = DistrictRepository.new
    dr.load_data({:enrollment => {
                    :kindergarten => "./data/Kindergartners in full-day program.csv",
                    :high_school_graduation => "./data/High school graduation rates.csv",
                   },
                   :statewide_testing => {
                     :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                     :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                     :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                     :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                     :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
                   }
                 })
    dr
  end
end
