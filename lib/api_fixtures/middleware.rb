module ApiFixtures
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)
      ApiFixtures::Fixtures.lookup(request.request_method, request.path) || @app.call(env)
    end

    def self.must_be_in_stack!
      if defined?(Rails::Application)
        unless Rails.application.middleware.include?(self)
          raise "ApiFixtures::Middleware needs to be in the middleware stack"
        end
        true
      else
        false
      end
    end
  end
end
