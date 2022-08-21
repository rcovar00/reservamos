class ReservamosService < Locations
  require 'rest-client'

  # Define essential parameters of the API
  # API Documentation: https://documenter.getpostman.com/view/6904537/TzRRCo6f
  def initialize
    @version = 'v2'
    @service_url = ENV.fetch('RESERVAMOS_BASE_URL') + "/api/#{@version}/"
  end

  # Return cities that match given location
  def get_locations(location)
    locations = ActiveSupport::HashWithIndifferentAccess.new
    is_success = false

    begin
      # Get results
      url = "#{@service_url}places?q=#{location}"
      response = RestClient.get(url)
      results = JSON.parse(response)

      # Filter by city
      results.each do |result|
        next unless result['result_type'] == 'city'

        locations[result['slug']] = {
          city: result['display'], slug: result['city_slug'], state: result['state'],
          country: result['country'], lat: result['lat'], long: result['long']
        }
      end

      is_success = true
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.fatal "Reservamos Request Exception: (#{e.response.code}) #{e.response}"
    end

    [is_success, locations]
  end
end
