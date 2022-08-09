import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  // Using this constructor, we will be passing the weatherData from the loading_screen to this screen using the MaterialPageRoute when this screen will be called.
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherMessage;
  String weatherIcon;
  String cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error!';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherMessage = weather.getMessage(temperature);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );

                      if (typedName != null) {
                        // This is inside 'if' because we should not be updating the weather data
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      // If we don't write 'await', then 'null' could get assigned to 'weatherData' if the user pressed the back key to come back from 'city_screen' to this screen. Since, in this case, the 'Navigator' will return a 'null' value.
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Watch lecture 150.

// LocationScreen is a stateful widget. LocationScreenState is a state of the LocationScreen widget(since this is a stateful widget, this cave many widgets)
// Every state has a "widget" property jiske madat se apan uske parent wale stateful widget me present chiizo ko access kr skte hai.
// uske parent wale stateful widget means the stateful widget of which this state is a state.

// We have to get data from the screen object (the data which was passed from one screen to other) to its state object.
// Note that the location screen's stateful widget is actually a separate object from it's state.
// location screen and the state object are different.
// The location screen object and the location screen's state object are linked. In other words, the state object knows which stateful widget it belongs to.
// The state object has a property called "widget", which will point to it's parent stateful widget.

// You get access to the "widget" object inside every single state object. It is the current object's configuration.
// You get access to the "widget" object inside every single state object. It is the current object's configuration.
// A [State] object's configuration is the corresponding [StatefulWidget] instance.

// Emojis are processed in exactly the same way as strings.
