module FixtureHelper
  def fixture_file_path(name)
    File.join(RSpec.configuration.fixture_path, name)
  end
end

RSpec.configure do |config|
  config.include FixtureHelper
end
