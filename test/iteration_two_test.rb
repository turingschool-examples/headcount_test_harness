require "minitest"
require "minitest/autorun"
require_relative "../../headcount/lib/district_repository"
require_relative "../../headcount/lib/district"
require_relative "../../headcount/lib/enrollment"
require_relative "../../headcount/lib/headcount_analyst"
require_relative "../../headcount/lib/statewide_test"

class IterationTwoTest < Minitest::Test
  def test_statewide_testing_repository_basics
    str = statewide_repo
    assert str.find_by_name("ACADEMY 20")
    assert str.find_by_name("GUNNISON WATERSHED RE1J")
  end

  def test_basic_proficiency_by_grade
    str = statewide_repo
    expected = { 2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
                 2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
                 2010 => {:math => 0.849, :reading => 0.864, :writing => 0.662},
                 2011 => {:math => 0.819, :reading => 0.867, :writing => 0.678},
                 2012 => {:math => 0.830, :reading => 0.870, :writing => 0.655},
                 2013 => {:math => 0.855, :reading => 0.859, :writing => 0.668},
                 2014 => {:math => 0.834, :reading => 0.831, :writing => 0.639}
               }

    testing = str.find_by_name("ACADEMY 20")
    assert_equal expected, testing.proficient_by_grade(3)
  end

  def test_basic_proficiency_by_race
    str = statewide_repo
    testing = str.find_by_name("ACADEMY 20")
    expected = { 2011 => {math: 0.816, reading: 0.897, writing: 0.826},
                 2012 => {math: 0.818, reading: 0.893, writing: 0.808},
                 2013 => {math: 0.805, reading: 0.901, writing: 0.810},
                 2014 => {math: 0.800, reading: 0.855, writing: 0.789},
               }
    assert_equal expected, testing.proficient_by_race_or_ethnicity(:asian)

    expected = {2011=>{:math=>0.451, :reading=>0.688, :writing=>0.503},
                2012=>{:math=>0.467, :reading=>0.75, :writing=>0.528},
                2013=>{:math=>0.473, :reading=>0.738, :writing=>0.531},
                2014=>{:math=>0.418, :reading=>0.006, :writing=>0.453}}

    testing = str.find_by_name("WOODLAND PARK RE-2")

    assert_equal expected, testing.proficient_by_race_or_ethnicity(:hispanic)

    testing = str.find_by_name("PAWNEE RE-12")
    expected = {2011=>{:math=>0.581, :reading=>0.792, :writing=>0.698},
                2012=>{:math=>0.452, :reading=>0.773, :writing=>0.622},
                2013=>{:math=>0.469, :reading=>0.714, :writing=>0.51},
                2014=>{:math=>0.468, :reading=>0.006, :writing=>0.488}}
    assert_equal expected, testing.proficient_by_race_or_ethnicity(:white)
  end

  def test_proficiency_by_subject_and_year
    str = statewide_repo

    testing = str.find_by_name("ACADEMY 20")
    assert_equal 0.653, testing.proficient_for_subject_by_grade_in_year(:math, 8, 2011)

    testing = str.find_by_name("WRAY SCHOOL DISTRICT RD-2")
    assert_equal 0.89, testing.proficient_for_subject_by_grade_in_year(:reading, 3, 2014)

    testing = str.find_by_name("PLATEAU VALLEY 50")
    assert_equal "N/A", testing.proficient_for_subject_by_grade_in_year(:reading, 8, 2011)
  end

  def test_proficiency_by_subject_race_and_year
    str = statewide_repo

    testing = str.find_by_name("AULT-HIGHLAND RE-9")
    assert_equal 0.611, testing.proficient_for_subject_by_race_in_year(:math, :white, 2012)
    assert_equal 0.310, testing.proficient_for_subject_by_race_in_year(:math, :hispanic, 2014)
    assert_equal 0.794, testing.proficient_for_subject_by_race_in_year(:reading, :white, 2013)
    assert_equal 0.278, testing.proficient_for_subject_by_race_in_year(:writing, :hispanic, 2014)

    testing = str.find_by_name("BUFFALO RE-4")
    assert_equal 0.65, testing.proficient_for_subject_by_race_in_year(:math, :white, 2012)
    assert_equal 0.437, testing.proficient_for_subject_by_race_in_year(:math, :hispanic, 2014)
    assert_equal 0.76, testing.proficient_for_subject_by_race_in_year(:reading, :white, 2013)
    assert_equal 0.375, testing.proficient_for_subject_by_race_in_year(:writing, :hispanic, 2014)
  end

  def test_unknown_data_errors
    skip
  end

  def test_statewide_testing_relationships
    dr = DistrictRepository.new
    dr.load_data({
                   :enrollment => {
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
    district = dr.find_by_name("ACADEMY 20")
    statewide_test = district.statewide_test
    assert statewide_test.is_a?(StatewideTest)

    ha = HeadcountAnalyst.new(dr)

    assert_equal ["WILEY RE-13 JT", 0.3], ha.top_statewide_test_year_over_year_growth(grade: 3, subject: :math)
    assert_equal ["FRENCHMAN RE-3", 0.175], ha.top_statewide_test_year_over_year_growth(grade: 8, subject: :reading)
    assert_equal ["BETHUNE R-5", 0.148], ha.top_statewide_test_year_over_year_growth(grade: 3, subject: :writing)

    assert_equal ["OTIS R-3", 0.044], ha.top_statewide_test_year_over_year_growth(grade: 3)
    assert_equal ["OURAY R-1", 0.073], ha.top_statewide_test_year_over_year_growth(grade: 8)
  end

  def test_insufficient_information_errors
    skip
  end

  def statewide_repo
    str = StatewideTestRepository.new
    str.load_data({
                    :statewide_testing => {
                      :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                      :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                      :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                      :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                      :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
                    }
                  })
    str
  end
end
