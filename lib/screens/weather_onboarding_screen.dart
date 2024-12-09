import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_forecast/colors/weather_colors.dart';
import 'package:weather_forecast/constants/weather_onboarding_screen_data.dart';
import 'package:weather_forecast/view/weather_home_screen.dart';

class WeatherOnBoardingScreen extends StatefulWidget {
  const WeatherOnBoardingScreen({super.key});

  @override
  State<WeatherOnBoardingScreen> createState() =>
      _WeatherOnBoardingScreenState();
}

class _WeatherOnBoardingScreenState extends State<WeatherOnBoardingScreen> {
  int currentIndex = 0;
  PageController _controller = PageController();
  bool isLastPage = false;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = contents.length - 1 == index;
                });
              },
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                        contents[i].lottieAnimation,
                        repeat: true,
                        reverse: true,
                        animate: true,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        contents[i].title,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        contents[i].description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white54,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: isLastPage
                ? getStarted()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _controller.jumpToPage(contents.length - 1);
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: contents.length,
                        onDotClicked: (currentIndex) {
                          _controller.animateToPage(
                            currentIndex,
                            duration: Duration(milliseconds: 800),
                            curve: Curves.easeIn,
                          );
                        },
                        effect: ExpandingDotsEffect(
                          spacing: 8.0,
                          radius: 10,
                          dotWidth: 14.0,
                          dotHeight: 14.0,
                          activeDotColor: lightBlue,
                          dotColor: lightBlue.withOpacity(.2),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 800),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget getStarted() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: lightBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        width: MediaQuery.of(context).size.width * .9,
        height: 50,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => WeatherHomeScreen()),
              ),
            );
          },
          child: Text(
            "Get Started",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
