require 'api_fixtures/fixtures'
require 'api_fixtures/middleware'
require 'api_fixtures/dsl'

module ApiFixtures
  VERSION = '0.1.0'

  def self.folder=(folder)
    Fixtures.folder = folder
  end
end
