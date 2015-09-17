lib_dir = File.expand_path '../../headcount/lib', __dir__
$LOAD_PATH.unshift lib_dir
require_relative File.expand_path('headcount', lib_dir)


class TestHarness < Minitest::Test
  def self.data_dir
    File.expand_path '../data', __dir__
  end

  def self.repo
    @repo ||= DistrictRepository.from_csv(data_dir)
  end

  def repo
    TestHarness.repo
  end

  def a20
    repo.find_by_name('ACADEMY 20')
  end
end
