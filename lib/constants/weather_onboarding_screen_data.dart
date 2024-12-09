class WeatherOnBoardingScreen {
  String lottieAnimation;
  String title;
  String description;

  WeatherOnBoardingScreen({
    required this.lottieAnimation,
    required this.title,
    required this.description,
  });
}

List<WeatherOnBoardingScreen> contents = [
  WeatherOnBoardingScreen(
    lottieAnimation: "assets/images/weather_onboarding_1.json",
    title: "Live Weather Updates",
    description:
        "Stay updated with real-time weather forecasts for your city and other locations. Get accurate information about temperature, humidity, and wind speed.",
  ),
  WeatherOnBoardingScreen(
    lottieAnimation: "assets/images/weather_onboarding_3.json",
    title: "Hourly Forecast",
    description:
        "Plan your day better with detailed hourly weather updates. Know what the weather will look like throughout the day and prepare accordingly.",
  ),
  WeatherOnBoardingScreen(
    lottieAnimation: "assets/images/weather_onboarding_2.json",
    title: "7-Day Forecast",
    description:
        "Prepare for the week ahead with comprehensive 7-day weather forecasts. Access detailed insights into maximum and minimum temperatures, precipitation chances, and humidity, and wind speed.",
  ),
  WeatherOnBoardingScreen(
    lottieAnimation: "assets/images/weather_onboarding_4.json",
    title: "Sunrise & Sunset",
    description:
        "Stay informed about sunrise and sunset timings for your city. Perfect for photographers, travelers, and anyone who loves to enjoy the beauty of nature.",
  ),
];
