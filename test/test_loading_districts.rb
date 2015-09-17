require_relative 'test_helper'

class TestEnrollment < TestHarness
  def test_something
    district = repo.find_by_name('ACADEMY 20')
    assert_equal 22620, district.enrollment.in_year(2009)
    assert_equal 0.895, district.enrollment.graduation_rate.for_high_school_in_year(2010)
    assert_equal 0.857, district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end
end


__END__

EconomicProfile
  Median household income.csv
  School-aged children in poverty.csv
  Students qualifying for free or reduced price lunch.csv
  Title I students.csv

StatewideTesting
  3rd grade students scoring proficient or above on the CSAP_TCAP.csv
  4th grade students scoring proficient or above on the CSAP_TCAP.csv
  8th grade students scoring proficient or above on the CSAP_TCAP.csv
  Average proficiency on the CSAP_TCAP by race_ethnicity_Math.csv
  Average proficiency on the CSAP_TCAP by race_ethnicity_Reading.csv
  Average proficiency on the CSAP_TCAP by race_ethnicity_Writing.csv

Enrollment
  Dropout rates by race and ethnicity.csv
  High school graduation rates.csv
  Kindergartners in full-day program.csv
  Online pupil enrollment.csv
  Pupil enrollment by race_ethnicity.csv
  Pupil enrollment.csv
  Remediation in higher education.csv
  Special education.csv


"data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv" Location,Score,TimeFrame,DataFormat,Data
"data/4th grade students scoring proficient or advanced on CSAP_TCAP.csv"  Location,TimeFrame,DataFormat,Data
"data/8th grade students scoring proficient or above on the CSAP_TCAP.csv" Location,Score,TimeFrame,DataFormat,Data
"data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv"    Location,Race Ethnicity,TimeFrame,DataFormat,Data
"data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv" Location,Race Ethnicity,TimeFrame,DataFormat,Data
"data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv" Location,Race Ethnicity,TimeFrame,DataFormat,Data
"data/Dropout rates by race and ethnicity.csv"                             Location,Category,TimeFrame,DataFormat,Data
"data/High school graduation rates.csv"                                    Location,TimeFrame,DataFormat,Data
"data/Kindergartners in full-day program.csv"                              Location,TimeFrame,DataFormat,Data
"data/Median household income.csv"                                         Location,TimeFrame,DataFormat,Data
"data/Online pupil enrollment.csv"                                         Location,TimeFrame,DataFormat,Data
"data/Pupil enrollment by race_ethnicity.csv"                              Location,Race,TimeFrame,DataFormat,Data
"data/Pupil enrollment.csv"                                                Location,TimeFrame,DataFormat,Data
"data/Remediation in higher education.csv"                                 Location,TimeFrame,DataFormat,Data
"data/School-aged children in poverty.csv"                                 Location,TimeFrame,DataFormat,Data
"data/Special education.csv"                                               Location,TimeFrame,DataFormat,Data
"data/Students qualifying for free or reduced price lunch.csv"             Location,Poverty Level,TimeFrame,DataFormat,Data
"data/Title I students.csv"                                                Location,TimeFrame,DataFormat,Data
