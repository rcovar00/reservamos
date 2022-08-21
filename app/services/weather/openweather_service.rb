class OpenweatherService < Weather
  require 'rest-client'

  # Define essential parameters of the API
  # API Documentation: https://openweathermap.org/api/one-call-3
  def initialize
    @version = '3.0'
    @api_key = Rails.application.credentials.openweather_api_key!
    @units = 'metric'
    @units_meaning = { metric: 'Celcius', imperial: 'Fahrenheit', '': 'Kelvin' }
    @service_url = ENV.fetch('OPENWEATHER_BASE_URL') + "/data/#{@version}/onecall?appid=#{@api_key}&units=#{@units}"
  end

  # Return weather forecast including max and min temperature for the next X days
  def get_weather_forecast(locations)
    weather_forecast = []
    is_success = false

    begin
      exclude = 'minutely,hourly,alerts' # Exclude some parts of the weather data
      locations.each do |_, value|
        url = "#{@service_url}&exclude=#{exclude}&lat=#{value['lat']}&lon=#{value['long']}"
        response = RestClient.get(url)
        results = JSON.parse(response)
        weather_forecast.append({ city: value['city'], slug: value['slug'], state: value['state'],
                                  country: value['country'], current_temperature: results['current']['temp'],
                                  units: @units_meaning[@units.to_sym], temperatures: format_temperatures(results) })
      end
      is_success = true
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.fatal "OpenWeather Request Exception: (#{e.response.code}) #{e.response}"
    end

    [is_success, weather_forecast]
  end

  # Get temperature of the next X days
  def format_temperatures(results)
    temperatures = []

    num_days = 7 # range from 1 - 8 days, be sure to update current_day if you update this variable
    current_day = 1  # Starts at day 1, because we want to ignore current day
    while current_day <= num_days
      temp_day = results['daily'][current_day]
      temperatures.append({ datetime: temp_day['dt'], max: temp_day['temp']['max'], min: temp_day['temp']['min'] })
      current_day += 1
    end

    temperatures
  end
end
