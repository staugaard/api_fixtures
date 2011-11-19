require 'api_fixtures/version'
require 'api_fixtures/fixtures'
require 'api_fixtures/middleware'
require 'api_fixtures/dsl'

module ApiFixtures
  def self.folder=(folder)
    Fixtures.folder = folder
  end
end
