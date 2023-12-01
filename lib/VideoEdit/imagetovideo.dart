import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class Convertimagetovideo extends StatefulWidget {
  const Convertimagetovideo({Key? key}) : super(key: key);

  @override
  _ConvertimagetovideoState createState() => _ConvertimagetovideoState();
}

class _ConvertimagetovideoState extends State<Convertimagetovideo> {
  File? _selectedImage;
  File? _selectedAudio;
  bool _isProcessing = false;
  var uuid = const Uuid();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  String generateRandomName() {
    return uuid.v4();
  }

  Future<void> _pickAudio() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      setState(() {
        _selectedAudio = File(result.files.single.path!);
      });
    }
  }

  Future<void> _combineImageAndAudio() async {
    try {
      if (_selectedImage != null && _selectedAudio != null && !_isProcessing) {
        setState(() {
          _isProcessing = true;
        });
        var status = await Permission.manageExternalStorage.status;
        if (status != PermissionStatus.granted) {
          await Permission.manageExternalStorage.request();
        }
        // Get the Downloads directory
        Directory? downloadsDirectory =
            Directory("/storage/emulated/0/videoConverter");

        if (await downloadsDirectory.exists()) {
        } else {
          downloadsDirectory.create();
        }

        // Output video file path in the Downloads directory
        String outputPath =
            '${downloadsDirectory.path}/output_video_${generateRandomName()}.mp4';

        // Ensure that _selectedImage!.path and _selectedAudio!.path are non-null
        String imageFilePath = _selectedImage!.path;
        String audioFilePath = _selectedAudio!.path;

        // List<String> arguments = [
        //   '-i',
        //   imageFilePath,
        //   '-i',
        //   audioFilePath,
        //   '-c:v',
        //   'libx264',
        //   '-c:a',
        //   'aac',
        //   '-strict',
        //   'experimental',
        //   '-b:a',
        //   '192k',
        //   outputPath,
        // ];

        List<String> arguments = [
          '-loop 1',
          '-i',
          imageFilePath,
          '-i',
          audioFilePath,
          '-shortest',
          outputPath,
        ];

        String command = arguments.join(' ');

        print("Executing FFmpeg command: $command");

        await FFmpegKit.executeAsync(command, (session) async {
          final state = await session.getState();
          final returnCode = await session.getReturnCode();
          String? output =
              await session.getOutput() ?? ''; // Provide a default value

          print(output);

          // Save the FFmpeg output to a file
          File outputLogFile =
              File('${downloadsDirectory.path}/ffmpeg_output.txt');
          await outputLogFile.writeAsString(output);

          // print("Return code: $returnCode");
          // print("Output: $output");

          if (ReturnCode.isSuccess(returnCode)) {
            // SUCCESS
            // Save the video to the gallery
            // print("Return code: $returnCode");
            // print("Output: $output");
          } else if (ReturnCode.isCancel(returnCode)) {
            print("Cammand cancelled");
            // CANCEL
          } else {
            print("Error: $returnCode");
            // ERROR
          }

          setState(() {
            _isProcessing = false;
          });
        }, (logs) {
          print(logs.getMessage());
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // Clean up resources when the widget is disposed
    _selectedImage?.delete();
    _selectedAudio?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            "Video Editing",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/whitepattern.jpg'), // Replace with your background image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 350,
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        height: 150,
                      )
                    : const Text("No Image selected"),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black), // Set border color to black
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.5), // Set shadow color and opacity
                        spreadRadius: 2, // Set the spread radius of the shadow
                        blurRadius: 5, // Set the blur radius of the shadow
                        offset:
                            const Offset(0, 3), // Set the offset of the shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _selectedAudio != null
                          ? Text(
                              "Audio selected: ${_selectedAudio!.path}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Text(
                              "No Audio selected",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.red, // Set the button color to red
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.image,
                            color: Colors.white), // Add image icon
                        SizedBox(
                            width: 8), // Add some space between icon and text
                        Text("Pick Image",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickAudio,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green, // Set the button color to green
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.music_note,
                            color: Colors.white), // Add music icon
                        SizedBox(width: 8),
                        Text("Pick Audio",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _combineImageAndAudio,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.merge_type, color: Colors.black),
                    const SizedBox(width: 8),
                    _isProcessing
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          )
                        : const Text(
                            "Combine Image and Audio",
                            style: TextStyle(color: Colors.black),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
