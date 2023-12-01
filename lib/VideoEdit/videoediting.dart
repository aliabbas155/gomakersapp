import 'package:flutter/material.dart';
import 'package:gomakersapp/VideoEdit/imagetovideo.dart';
import 'package:lottie/lottie.dart';

class VideoEditingScreen extends StatefulWidget {
  const VideoEditingScreen({super.key});

  @override
  _VideoEditingScreenState createState() => _VideoEditingScreenState();
}

class _VideoEditingScreenState extends State<VideoEditingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/whitepattern.jpg'), // Replace with your background image asset path
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          // Lottie Animation
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 150, top: 80, left: 40),
                child: SizedBox(
                  height: 200,
                  child: SizedBox(
                    width: 100.0,
                    height: 80.0,
                    child: Lottie.asset(
                      'assets/images/pushing.json', // Replace with your card1 animation asset path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Choose Image From Gallery',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Sora-VariableFont_wght.ttf',
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),

              // ElevatedButton
              const SizedBox(
                height: 90,
              ),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Convertimagetovideo()),
                    );
                  },
                  icon: const Icon(Icons.device_hub_outlined),
                  label: const Text(
                    'Gallery',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Set button color to black
                    fixedSize: const Size(
                        300, 50), // Set width and height of the button
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the value as needed for roundness
                    border: Border.all(
                      color: Colors.black,
                      width: 2, // Adjust the border width as needed
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Generating Video will take time so have patience  ',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Sora-VariableFont_wght.ttf',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the value as needed for roundness
                    border: Border.all(
                      color: Colors.black,
                      width: 2, // Adjust the border width as needed
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Dont Leave Creation Screen till Loading Ends ',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Sora-VariableFont_wght.ttf',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
