require 'test_helper'

require 'minitest/autorun'

class MiniTestSpecTest < MiniTest::Spec
  extend  ApiFixtures::DSL

  describe 'instance level integration' do
    it 'should give access to the api' do
      api.must_equal ApiFixtures::Fixtures
    end

    it 'should clear the fixtures before running tests' do
      api.fixture('GET', '/foo', {})

      ApiFixtures::Fixtures::FIXTURES[:get].wont_be_empty

      setup

      ApiFixtures::Fixtures::FIXTURES[:get].must_be_empty
    end

    describe 'expectations' do
      before do
        @flunk_calls = 0
      end

      def flunk(message)
        @flunk_calls += 1
      end

      it 'should check that api expectations are met' do
        @flunk_calls.must_equal 0

        api.expect('GET', '/foo')

        teardown

        @flunk_calls.must_equal 1
      end
    end

  end

  describe 'class level integration' do
    api_fixtures '/user'

    it 'should give access to the api_fixtures method' do
      ApiFixtures::Fixtures::FIXTURES[:get].keys.must_equal ['/user']
    end

    describe 'in nested blocks' do
      api_fixtures '/account'

      it 'should inherit the fixtures from the parent block' do
        ApiFixtures::Fixtures::FIXTURES[:get].keys.sort.must_equal ['/account', '/user']
      end
    end
  end

end
