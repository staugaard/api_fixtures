require 'api_fixtures/fixtures'
require 'active_support/core_ext/class/attribute'

module ApiFixtures
  module DSL
    module InstanceDSL
      def api
        ApiFixtures::Fixtures
      end
    end

    def self.extended(base)
      base.class_attribute :api_fixture_paths
      base.send(:include, InstanceDSL)

      before_hook = [:before, :setup].find {|hook| base.respond_to?(hook) }
      after_hook  = [:after, :teardown].find {|hook| base.respond_to?(hook) }

      base.send(before_hook) do
        ApiFixtures::Fixtures.clear
        (api_fixture_paths || []).each do |path|
          ApiFixtures::Fixtures.fixture('GET', path)
        end
      end

      base.send(after_hook) do
        ApiFixtures::Fixtures.assert_expected_calls(self)
      end
    end

    def api_fixtures(*paths)
      self.api_fixture_paths ||= []
      self.api_fixture_paths += paths
      self.api_fixture_paths.uniq!
    end
  end
end
