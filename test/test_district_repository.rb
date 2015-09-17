require_relative 'test_helper'

class TestDistrictRepository < TestHarness
  class TestFindByName < TestDistrictRepository
    def test_returns_nil_when_district_dne
      assert_equal nil, repo.find_by_name("not a real district")
    end

    def test_is_case_insensitive
      assert_equal repo.find_by_name("ACADEMY 20"),
                   repo.find_by_name("academy 20")
    end

    def test_returns_the_correct_district
      assert_equal 'ACADEMY 20', repo.find_by_name('ACADEMY 20').name
    end
  end


  class TestFindAllMatching < TestDistrictRepository
    def test_it_returns_empty_collection_when_there_are_no_matches
      assert_equal [], repo.find_all_matching('lksjlkjlkjlkj').to_a
    end

    def test_it_returns_all_districts_matching_the_name_fragment
      assert_equal ['IDALIA SCHOOL DISTRICT RJ-3', 'WRAY SCHOOL DISTRICT RD-2'],
                   repo.find_all_matching('DISTRICT R').map { |district| district.name }.sort
    end

    def test_it_matches_case_insensitive
      assert_equal ['COLORADO', 'COLORADO SPRINGS 11'],
                   repo.find_all_matching('oRa').map { |district| district.name }.sort
    end
  end
end
