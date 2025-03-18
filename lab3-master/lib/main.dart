import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp()); // Entry point of the Flutter application
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageFrameApp(), // Loads the main image slideshow widget
    );
  }
}

class ImageFrameApp extends StatefulWidget {
  @override
  _ImageFrameAppState createState() => _ImageFrameAppState();
}

class _ImageFrameAppState extends State<ImageFrameApp> {
  // List of image URLs to display in the slideshow
  final List<String> images = [
    'https://www.holidify.com/images/cmsuploads/compressed/phewa_20180710001256.jpeg',
    'https://www.holidify.com/images/cmsuploads/compressed/22043951124_08c344201f_h_20180710001301.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/Barun_Valley_-_Nghe_20180710001306.jpg',
    'https://www.planetware.com/wpimages/2019/12/nepal-in-pictures-beautiful-places-to-photograph-annapurna-range.jpg',
  ];

  int currentIndex = 0; // Index to track the current image in the slideshow
  bool isPaused = false; // Boolean to track whether the slideshow is paused
  Timer? _timer; // Timer to handle image switching

  @override
  void initState() {
    super.initState();
    startSlideshow(); // Start the automatic image slideshow
  }

  // Starts a timer that changes the image every 10 seconds
  void startSlideshow() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (!isPaused) {
        setState(() {
          currentIndex = (currentIndex + 1) % images.length; // Loop through images
        });
      }
    });
  }

  // Toggles the pause and resume state of the slideshow
  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Set background color
      appBar: AppBar(title: Text('Digital Picture Frame')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.brown, width: 10), // Brown frame
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            padding: EdgeInsets.all(10),
            child: Image.network(
              images[currentIndex], // Display current image
              width: 300,
              height: 300,
              fit: BoxFit.contain, // Ensure the image fits within the container
            ),
          ),
          SizedBox(height: 20), // Spacing between image and button
          ElevatedButton(
            onPressed: togglePause, // Toggle pause/resume when clicked
            child: Text(isPaused ? 'Resume' : 'Pause'),
          ),
        ],
      ),
    );
  }
}