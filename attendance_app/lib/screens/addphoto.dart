import 'dart:io';
import 'package:attendance_app/screens/campage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class FaceRegistrationPage extends StatefulWidget {
  @override
  _FaceRegistrationPageState createState() => _FaceRegistrationPageState();
}

class _FaceRegistrationPageState extends State<FaceRegistrationPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Function to pick image from gallery or camera
  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      // Save the image to local storage for future recognition
      await _saveImage(File(pickedFile.path),context);
    }
  }

  // Save the image to local storage
  Future<void> _saveImage(File image,BuildContext context) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = basename(image.path);
    final savedImage = await image.copy('${directory.path}/$fileName');

    // Optionally store the file path in persistent storage like SharedPreferences
    print('Image saved at ${savedImage.path}');
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FaceRecognitionLive(filepath: savedImage.path,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Registration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageFile != null
                ? Image.file(_imageFile!)
                : Text('No image selected.'),
            ElevatedButton(
              onPressed: () => _pickImage(context),
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
