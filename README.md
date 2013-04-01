## Ide

Ide (Injector of Dependencies for the Enterprise) is a revolutionary new [Dependency Injection](http://en.wikipedia.org/wiki/Dependency_injection) framework.

Compared to the [many](http://en.wikipedia.org/wiki/Spring_Framework) [other](http://www.ninject.org/) [Dependency](http://square.github.com/dagger/) [Injection](http://code.google.com/p/google-guice/) [frameworks](http://picocontainer.codehaus.org/), Ide is extremely terse: the entire framework is only [one line of code](https://github.com/nusco/ide/blob/master/ide.rb).

# Features

* Externalized configuration
* Programmable Dependency Resolution
* Instance factories ("classes")
* Enterprise-level robustness
* Very lightweight source code
* Written in Pure Ruby

# How to use Ide

To install, copy the [*ide.rb*](ide.rb) file into your project.

Now, assume that you have a class that depends on other classes. For example, this *WeatherScraper* depends on *WeatherService* and *Database*:

    class WeatherScraper
      def initialize
        @weather_service = WeatherService.new("http://onlineweatherforall.com")
        @database = Database.new
      end
    
      # a lot of code
    end

When you run with the "testing" configuration, you'd like *WeatherScraper* to use two specific implementations of *WeatherService* and *Database*, called *MockWeatherService* and *TestDatabase*. To define dependencies, create a file named *dependencies_testing* that contains this configuration code:

    WeatherService = MockWeatherService
    Database       = TestDatabase

At the beginning of your program, load the framework and initialize dependencies like this:

    require 'ide'
    load_dependencies('testing')
  
Now the *WeatherService* class will use the dependencies you defined. If you want another configuration (say, "production"), you can write a file named *dependencies_production*:

    WeatherService = RealOnlineWeatherService
    Database       = BigAssDatabase

# Programmable Dependency Resolution

In some cases, defining your dependencies in a static file is not enough - you want to apply programmatic logic to decide which concrete implementation to depend upon. With another Dependency Injection framework, this could prove hard. In Ide, you can customize your object factories (also known as "classes") by overriding their *new()* method:

    class TestDatabase
      def self.new()
        if functional_testing()
          return in_memory_database()
        else
          return mock_database()
        end
      end
    end

[Enjoy Ide](http://en.wikipedia.org/wiki/Ide_%28fish%29)!
