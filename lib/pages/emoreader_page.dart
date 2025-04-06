import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'emotion_classifier.dart';

class EmoreaderPage extends StatefulWidget {
  final EmotionClassifier classifier;
  
  const EmoreaderPage({required this.classifier, super.key});

  @override
  State<EmoreaderPage> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<EmoreaderPage> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  String _result = 'Initializing camera...';
  bool _isProcessing = false;
  File? _capturedImage;
  int whichCamera = 0; // 0 for back camera, 1 for front camera
  Timer? _captureTimer;
  bool _isStreaming = false;
  List<Map<String, dynamic>> _emotionHistory = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _controller = CameraController(
        cameras[whichCamera], // Using front camera (cameras[1])
        ResolutionPreset.medium,
      );

      await _controller!.initialize();
      if (!mounted) return;
      setState(() {
        _isCameraInitialized = true;
        _result = 'Ready to detect emotions';
      });
    } catch (e) {
      setState(() => _result = 'Camera error: ${e.toString()}');
    }
  }

  Widget _buildCameraPreview() {
    return Center(
      child: AspectRatio(
        aspectRatio: 1, // Force 1:1 aspect ratio
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller!.value.previewSize!.height,
              height: _controller!.value.previewSize!.width,
              child: CameraPreview(_controller!),
            ),
          ),
        ),
      ),
    );
  }

  //Automatically capture and analyze the image
  Future<void> _startEmotionStream() async {
    if (!_isCameraInitialized || _isProcessing) return;

    setState(() {
      _isStreaming = true;
      _result = 'Starting emotion stream...';
      _emotionHistory.clear();
    });

    _captureTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!_isStreaming || !mounted) {
        timer.cancel();
        return;
      }

      try {
        setState(() => _isProcessing = true);
        final image = await _controller!.takePicture();
        final result = await widget.classifier.classifyImage(image.path);
        
        // Store the emotion history (optional)
        _emotionHistory.add({
          'timestamp': DateTime.now(),
          'emotion': result,
          'imagePath': image.path
        });

        // Keep only last 10 entries (adjust as needed)
        if (_emotionHistory.length > 10) {
          _emotionHistory.removeAt(0);
        }

        setState(() => _result = 'Detected: \n$result');
      } catch (e) {
        setState(() => _result = 'Error: ${e.toString()}');
      } finally {
        if (mounted) {
          setState(() => _isProcessing = false);
        }
      }
    });
  }

  Future<void> _stopEmotionStream() async {
    _captureTimer?.cancel();
    setState(() {
      _isStreaming = false;
      _result = 'Stream stopped';
    });
  }

  @override
  void dispose() {
    _captureTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  //Switch camera function
  Future<void> _switchCamera() async {
    if (_isProcessing) return;

    setState(() {
      _isCameraInitialized = false;
      _result = 'Switching camera...';
    });

    await _controller?.dispose();

    whichCamera = (whichCamera + 1) % 2;

    try {
      final cameras = await availableCameras();
      if (whichCamera >= cameras.length) {
        whichCamera = 0; 
      }

      _controller = CameraController(
        cameras[whichCamera],
        ResolutionPreset.medium,
      );

      await _controller!.initialize();
      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
        _result = 'Ready to detect emotions';
      });
    } catch (e) {
      setState(() {
        _result = 'Failed to switch camera: ${e.toString()}';
        _isCameraInitialized = false;
      });
      
      whichCamera = (whichCamera + 1) % 2;
      await _initializeCamera();
    }
  }


  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEEE6FF),
            Color(0xFFD2E3FF),
          ], // Light purple to blue gradient
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title and Description
            Column(
              children: [
                Text(
                  "EmoReader 🎭",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Use your device's camera and microphone to read and classify emotions in real time.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
              ],
            ),

            // Camera Preview or Captured Image
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _capturedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(_capturedImage!, fit: BoxFit.cover),
                    )
                  : _isCameraInitialized
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: _buildCameraPreview(),
                        )
                      : const Center(
                          child: Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                        ),
            ),

            const SizedBox(height: 20),

            // Result Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _result
                      .split('\n')
                      .map((line) => Text(line, textAlign: TextAlign.center))
                      .toList(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Buttons: Switch Camera and Stream Control
            if (_isCameraInitialized)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _isProcessing ? null : _switchCamera,
                        child: const Text('Switch Camera'),
                      ),
                      const SizedBox(width: 10),
                      _isStreaming
                          ? ElevatedButton(
                              onPressed: _stopEmotionStream,
                              child: const Text('Stop Stream'),
                            )
                          : ElevatedButton(
                              onPressed: _startEmotionStream,
                              child: const Text('Start Stream'),
                            ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
          ],
        ),
      ),
    ),
  );
}

}

