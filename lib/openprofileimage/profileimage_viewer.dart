import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl;

  const ImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
            child: Text(
          'Profile Image',
          style: TextStyle(color: Colors.white),
        )),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Image.network(imageUrl),
      ),
    );
  }
}
