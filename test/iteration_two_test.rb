require "minitest"
require "minitest/autorun"
require_relative "../../headcount/lib/district_repository"
require_relative "../../headcount/lib/district"
require_relative "../../headcount/lib/enrollment"
require_relative "../../headcount/lib/headcount_analyst"

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
