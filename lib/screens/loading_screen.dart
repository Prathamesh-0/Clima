import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}

// We can only wait on(put 'await' in front of) methods which return Future(a kinda receipt).
// We marked it as await since, it is gonna take some time to actually grab the current location.

// 'async' and 'await' is generally used whenever we have to carry out some time consuming tasks(such as getting the GPS location from the phone).
// By using the 'async', we can get the time consuming tasks to happen in the background instead of happening in the foreground(if it happens in the foreground, it can block up our UI and freeze up our app).

// Note that for the 'geolocator' package to get location, we will be needing to get permissions from the user.
// For that you can read and refer to the 'Permissions' section of the documentation/readme of the 'geolocator' package.

// 'sleep()' is a synchronous operation/function. It will have to get finished before the line below it could execute.
// 'Future.delayed()' is an asynchronous method. This can be know by seeing the method's return type. It's return type is generally 'Future'.

// We have to change the function to a 'async' type. For doing that just write the 'async' keyword before the opening curly brace of the function's definition.
// By adding this 'async' keyword, we then have access to the 'await' keyword. The 'await' keyword has to be added just at the front of something which can take an nondeterministic or long time to get executed, so that we can wait till the thing/call which is just after 'async' gets completed.
// We have to have 'Future' as the return type of the function called after the 'await'.
// Writing just 'Future' as the return type means that we are having a dynamic datatype. For having a specific datatype we can do like : Future<String>

// We keep track of the state(like the variables or the configuration of widgets, etc.) of the stateful widget using the state object.
// We can change these variables using the setState(), and it will update the app.
// The state object has got more than one lifecycle methods, like 'init()', 'build()', 'deactivate()'.
// In the stateful widget there is only 1 lifecycle method and that is the 'build()'
// init() gets triggered when the state initially gets initialized.
// build() gets triggered when the widgets are actually built and will show up on screen.
// deactivate() gets called when the stateful widget gets destroyed.

// So, if we want something to happen every single time, the moment our stateful widget gets created and added into the widget tree, then we gonna have to put our code in the initState().   (Just like constructor for a class)
// If we want something to happen every single time our stateful widget gets rebuilt, then we gonna have to put our code in the build().
// Similar for the destructor().          (Just like destructor for a class)

// What are status codes?
// --> When we are interacting with an external server, they need a short and unified way of telling us what exactly happened when we interacted with them. It is kinda like a set of codes for particular outcomes.
// Like the '404' status code means that the resource that you tried to access from the external server doesn't actually exist.

// 'http' and then the dot(.) signifies that the thing just next to it came from the 'http' package.
// The required data will be held in 'response.body'
// 'response.statusCode' will give you the status code received from the external server for the request you made.
// This 'get()' method returns a 'Future<Response>', so if we wanted to hold onto the data that we get back from 'get()', we have to create a new variable and store it.

// The weather data which we will be getting here is in JSON format.
// The API providers provide the data in either JSON or XML or both formats.
