import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';

import 'package:mime/mime.dart';

class FaceRecognitionLive extends StatefulWidget {
  final String filepath;
  const FaceRecognitionLive({
    super.key,
    required this.filepath,
  });

  @override
  _FaceRecognitionLiveState createState() => _FaceRecognitionLiveState();
}

class _FaceRecognitionLiveState extends State<FaceRecognitionLive> {
  late CameraController cameraController;
  late FaceDetector faceDetector;
  File? capturedImage;
  late Future<void> _initializeControllerFuture;
  InputImage? registeredFace;
  bool isFaceMatched = false;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = initializeCamera();
    faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableClassification: true,
        minFaceSize: 0.1,
        performanceMode: FaceDetectorMode.fast,
      ),
    );
    _loadRegisteredFace();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first, // Fallback if front camera is unavailable
    );

    cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await cameraController.initialize();
  }

  Future<void> _loadRegisteredFace() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/your_saved_image.jpg';
    if (File(filePath).existsSync()) {
      setState(() {
        registeredFace = InputImage.fromFilePath(widget.filepath);
      });
    }
  }

  Future<void> captureAndDetectFace() async {
    try {
      // Step 1: Take a picture
      print("image is captured");
      final image = await cameraController.takePicture();
      setState(() {
        capturedImage = File(image.path); // Update UI to show captured image
      });

      // Step 2: Convert the image file into InputImage for face detection
      final inputImage = InputImage.fromFilePath(image.path);

      final registerInputImage = InputImage.fromFilePath(widget.filepath);

      // Step 3: Process the image for face detection
      final List<Face> faces = await faceDetector.processImage(inputImage);

      print(faces.length);

      // Step 4: Check if any faces are detected
      if (faces.isNotEmpty) {
        print('Faces detected: ${faces.length}');

        // Example: Detect and highlight the first face found
        final detectedFace = faces[0];
        print('First face bounds: ${detectedFace.boundingBox}');

        // If a registered face is available, compare it with the detected face

        bool isMatch =
            await compareWithRegisteredFace(detectedFace, registerInputImage);
        setState(() {
          isFaceMatched = isMatch;
        });
        print(
            isMatch ? 'Face matched with registered face!' : 'No match found');
      } else {
        // If no face is detected
        print('No face detected in the image');
        setState(() {
          isFaceMatched = false;
        });
      }
    } catch (e) {
      print('Error in capturing and detecting face: $e');
      setState(() {
        isFaceMatched = false;
      });
    }
  }

  Future<bool> compareWithRegisteredFace(
      Face detectedFace, InputImage registerdInputImage) async {
    String apiKey = 'GdPKqMeTWxcREyHnxCFEXMayHQwoibta';
    String apiSecret = 'l2fPqjSxhD5DWVwPmSBTCfNh-G3W_yZP';

    final List<Face> faces =
        await faceDetector.processImage(registerdInputImage);

    print("Registered face detected");
    print(faces.length);

    Face registeredFace = faces[0];

    File recieved = File(widget.filepath);
    List<int> image1Bytes = await capturedImage!.readAsBytes();

    List<int> image2Bytes = await recieved.readAsBytes();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api-us.faceplusplus.com/facepp/v3/compare'),
    );

    request.fields['api_key'] = apiKey;
    request.fields['api_secret'] = apiSecret;
    request.fields['face_token1'] = "1";
    request.fields['face_token2'] = "2";
    var mimeTypeData =
        lookupMimeType(capturedImage!.path, headerBytes: image1Bytes);
    request.files.add(
      http.MultipartFile.fromBytes(
        'image_file1', // Name of the form field the API expects
        image1Bytes,
        filename: capturedImage!.path.split('/').last,
        contentType:
            MediaType.parse(mimeTypeData ?? 'application/octet-stream'),
      ),
    );

    var mime2TypeData = lookupMimeType(recieved.path, headerBytes: image2Bytes);
    request.files.add(
      http.MultipartFile.fromBytes(
        'image_file2', // Name of the form field the API expects
        image2Bytes,
        filename: recieved.path.split('/').last,
        contentType:
            MediaType.parse(mime2TypeData ?? 'application/octet-stream'),
      ),
    );

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);
      double confidence = jsonResponse['confidence'];
      double threshold = jsonResponse['thresholds']['1e-5'];
      return confidence >= threshold;
    } else {
      print('Face++ API request failed with status: ${response.statusCode}');
      return false;
    }
  }

  Future<String> _faceToBase64(Face face) async {
    // Implement this to convert the detected face region into base64
    throw UnimplementedError('_faceToBase64 needs to be implemented');
  }

  @override
  void dispose() {
    cameraController.dispose();
    faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Face Recognition')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error initializing camera: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(child: CameraPreview(cameraController)),
                if (capturedImage != null)
                  Image.file(capturedImage!), // Display the captured image
                Text(
                  isFaceMatched ? "Face Matched!" : "No Match Detected",
                  style: TextStyle(
                    color: isFaceMatched ? Colors.green : Colors.red,
                    fontSize: 20,
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: captureAndDetectFace,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
