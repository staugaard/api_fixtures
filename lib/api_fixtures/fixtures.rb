require 'pathname'

module ApiFixtures
  class Fixtures
    FIXTURES = {
      :get =>    {},
      :put =>    {},
      :post =>   {},
      :delete => {}
    }
    EXPECTATIONS = []
    CALLS = []

    def self.normalize_method(method)
      method.downcase.to_sym
    end

    def self.normalize_path(path)
      path.gsub(/\.\w+$/, '')
    end

    def self.folder
      unless @folder
        if defined?(Rails)
          @folder = (Rails.root + 'test/api_fixtures')
        end
      end
      @folder
    end

    def self.folder=(folder)
      @folder = Pathname.new(folder)
    end

    def self.fixture(method, path, response = nil)
      ApiFixtures::Middleware.must_be_in_stack!

      case response
      when Hash
        response = [200, {'Content-Type' => 'application/json; charset=utf-8'}, [response.to_json]]
      when Array
        case response[2]
        when String
          response[2] = [response[2]]
        end
      when nil
        file_name = folder + ('.' + path + '.json')
        response = [200, {'Content-Type' => 'application/json; charset=utf-8'}, [File.read(file_name.to_s)]]
      end

      FIXTURES[normalize_method(method)][path] = response
    end

    def self.expect(method, path, options = {})
      if options[:response]
        fixture(method, path, options[:response])
      end
      EXPECTATIONS << [normalize_method(method), path]
    end

    def self.lookup(method, path)
      method = normalize_method(method)
      path   = normalize_path(path)
      CALLS << [method, path]
      FIXTURES[method][path]
    end

    def self.clear
      FIXTURES[:get].clear
      FIXTURES[:put].clear
      FIXTURES[:post].clear
      FIXTURES[:delete].clear

      EXPECTATIONS.clear
      CALLS.clear
    end

    def self.assert_expected_calls(test)
      (EXPECTATIONS - CALLS).each do | method, path|
        test.flunk("Expected API call: #{method.to_s.upcase} #{path}")
      end
    end
  end
end