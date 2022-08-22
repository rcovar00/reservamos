require 'test_helper'

module V1
  class WeatherControllerTest < ActionDispatch::IntegrationTest
    test 'should get default city' do
      get '/v1/weather'
      assert_response :ok
      assert_match 'Ciudad de México', @response.body
    end

    test 'should get results' do
      get '/v1/weather?location=guada'
      assert_response :ok
      assert_match 'Guadalajara', @response.body
      assert_match 'Guadalupe', @response.body
      assert_match 'Guadalupito', @response.body
    end

    test 'should contain temperatures' do
      get '/v1/weather?location=monterrey'
      body = @response.parsed_body
      if body['data'].length.positive?
        first_record = body['data'][0]
        assert_response :ok
        assert_equal 7, first_record['temperatures'].length
      end
    end
  end
end
