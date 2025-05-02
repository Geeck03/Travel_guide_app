import 'package:flutter/material.dart';

/* 

Images used from
https://freefantasymaps.org/category/world/ 

*/

//root of app
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isDarkMode = false; // Variable to track dark mode

  //Toggles dark mode on and off
  // This function is called when the user taps the button.
  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode; // Toggle the dark mode variable
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fantasy Travel App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(), // Use dark theme when isDarkMode is true
      themeMode:
          isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light, // Set the theme mode based on isDarkMode
      home: HomeScreen(
        toggleTheme: toggleDarkMode,
      ), // Pass the toggleTheme function to the home screen
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imagePath; // Path to the image

  const ImageCard({super.key, required this.imagePath}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            height: 200, // Height of the image card
            width: double.infinity, // Full width of the card
            child: Image.asset(imagePath), // Display the image
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Function toggleTheme; // Function to toggle the theme

  HomeScreen({super.key, required this.toggleTheme}); // Constructor

  final List<String> imagePaths = [
    'assets/F1.png',
    'assets/F2.jpg',
    'assets/F3.jpg',
    'assets/F4.jpg',
  ]; // List of image paths

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fantasy App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              toggleTheme();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ImageCard(
                imagePath: imagePaths[index],
              ), // Create an ImageCard for each image
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => MapScreen(imagePath: imagePaths[index]),
                    ),
                  );
                },
                child: const Text("Click on map"),
              ),
            ],
          );
        },
      ), // ListView to display the images
    );
  }
}

class MapScreen extends StatelessWidget {
  final String imagePath;
  const MapScreen({super.key, required this.imagePath}); // Constructor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Screen')),
      body: Stack(
        children: [
          Image.asset(
            imagePath,
            height: MediaQuery.of(context).size.height, // Full screen height
            width: MediaQuery.of(context).size.width, // Full screen width
            fit: BoxFit.cover,
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  child: Text("Go back"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
