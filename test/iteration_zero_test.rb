require "minitest"
require "minitest/autorun"
require_relative "../../headcount/lib/district_repository"
require_relative "../../headcount/lib/district"

class IterationZeroTest < Minitest::Test
  def test_district_basics
    d = District.new({:name => "ACADEMY 20"})
    assert_equal "ACADEMY 20", d.name
  end

  def test_loading_and_finding_districts
    dr = DistrictRepository.new
    dr.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv"
                   }
                 })
    district = dr.find_by_name("ACADEMY 20")

    assert_equal "ACADEMY 20", district.name

    assert_equal 7, dr.find_all_matching("WE").count
  end

  def test_enrollment_basics
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    all_years = {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}
    assert_equal 0.391, e.kindergarten_participation_in_year(2010)
    assert_equal 0.267, e.kindergarten_participation_in_year(2012)

    truncated = all_years.map { |year, rate| [year, rate.to_s[0..4].to_f]}.to_h
    assert_equal truncated, e.kindergarten_participation_by_year
  end

  def test_loading_and_finding_enrollments
  end
end
