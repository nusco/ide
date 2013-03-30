## Ide

Ide (Injector of Dependencies for the Enterprise) is a revolutionary new [Dependency Injection](en.wikipedia.org/wiki/Dependency_injection) framework.

The selling point of Ide when compared to the [many](http://en.wikipedia.org/wiki/Spring_Framework) [other](http://www.ninject.org/) [Dependency](http://square.github.com/dagger/) [Injection](http://code.google.com/p/google-guice/) [frameworks](http://picocontainer.codehaus.org/) is its extreme terseness: the entire framework is only [one line of code](https://github.com/nusco/ide/blob/master/ide.rb).

# Features

* Runtime dependency resolution
* Externalized configuration
* Customizable instance factories ("classes")
* Enterprise-level robustness
* Very lightweight source code
* Written in Pure Ruby

# How to use Ide

To install, copy the [*ide.rb*](https://github.com/nusco/ide/blob/master/ide.rb) file into your project.

Now, assume that you have a class that depends on other classes. For example, this *WeatherScraper* depends on *WeatherService* and *Database*:

    class WeatherScraper
      def initialize
        @weather_service = WeatherService.new("http://onlineweatherforthemasses.com")
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

# Customizing Your Object Factories

In some complex use cases, you might want to customize your object factories (also known as "classes"). You can do that by overriding their *new()* method, like this:

    class WeatherService
      def self.new(arguments)
        # apply complex logic to create an object and return it
      end
    end

Enjoy [Ide](http://en.wikipedia.org/wiki/Ide_%28fish%29)!