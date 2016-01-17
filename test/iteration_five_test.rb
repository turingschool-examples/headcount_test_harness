require "minitest"
require "minitest/autorun"
require_relative "../../headcount/lib/district_repository"
require_relative "../../headcount/lib/district"
require_relative "../../headcount/lib/enrollment"
require_relative "../../headcount/lib/headcount_analyst"
require_relative "../../headcount/lib/statewide_test"

class IterationFiveTest < Minitest::Test

  def test_finding_top_overall_districts
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)

    assert_equal "SANGRE DE CRISTO RE-22J", ha.top_statewide_test_year_over_year_growth(grade: 3).first
    assert_in_delta 0.071, ha.top_statewide_test_year_over_year_growth(grade: 3).last, 0.005

    assert_equal "OURAY R-1", ha.top_statewide_test_year_over_year_growth(grade: 8).first
    assert_in_delta 0.11, ha.top_statewide_test_year_over_year_growth(grade: 8).last, 0.005
  end

  def test_weighting_results_by_subject
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)

    top_performer = ha.top_statewide_test_year_over_year_growth(grade: 8, :weighting => {:math => 0.5, :reading => 0.5, :writing => 0.0})
    assert_equal "OURAY R-1", top_performer.first
    assert_in_delta 0.153, top_performer.last, 0.005
  end

  def test_insufficient_information_errors
    dr = district_repo
    ha = HeadcountAnalyst.new(dr)

    assert_raises(InsufficientInformationError) do
      ha.top_statewide_test_year_over_year_growth(subject: :math)
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
