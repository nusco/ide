#
# system with dependencies
#

class WeatherScraper
  def initialize
    @weather_service = WeatherService.new("http://onlineweatherforthemasses.com")
    @database = Database.new
  end
  
  def store_temperature_locally
    temperature = @weather_service.temperature
    @database.write(temperature)
  end
  
  def locally_stored_temperature
    @database.read_last
  end
end

#
# implementations for a testing environment
#

class MockWeatherService
  def initialize(url)
    # ignore url
  end
  
  def temperature
    18
  end
end

class TestDatabase
  def write(temp)
    @temp = temp
  end
  
  def read_last
    @temp
  end
end

#
# unit test
#

require 'test/unit'
require_relative 'ide'

class IdeTest < Test::Unit::TestCase
  def test_replaces
    load_dependencies('testing')
    scraper = WeatherScraper.new
    scraper.store_temperature_locally
    assert_equal 18, scraper.locally_stored_temperature
  end
end
