module V1
  class WeatherController < ApplicationController
    LOCATION_SERVICE = 'ReservamosService'.freeze
    WEATHER_SERVICE = 'OpenweatherService'.freeze

    def index
      # Set a location by default in case parameter is empty
      location = 'df'

      # Get location from parameter
      location = params['location'] if params['location'].present?

      # Consult list of locations
      locations_service = LOCATION_SERVICE.constantize.new
      locations = locations_service.get_locations(location)

      # Get weather forecast
      if locations.first
        weather_service = WEATHER_SERVICE.constantize.new
        response = weather_service.get_weather_forecast(locations[1])
        if response.first
          data = response[1]
          # Response successfully
          render json: { data: data }, status: :ok
          return
        end
      end

      # In case something went wrong with APIs, set default code to HTTP 503 because
      # the service will be unavailable if the 3rd party APIs won't work
      render json: { response: [{ message: 'An error occurred' }] }, status: :service_unavailable
    end
  end
end
