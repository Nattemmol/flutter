import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File _imageFile = File(''); // Initialize _imageFile to avoid null errors
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Function to handle image selection
  Future<void> _selectImage() async {
    // Code to select image from gallery
    // This code uses packages like image_picker or flutter_image_compress
    // You need to import these packages and implement the logic here
  }

  // Function to handle form submission
  void _submitForm() {
    // Get values from controllers
    String location = _locationController.text.trim();
    String rent = _rentController.text.trim();
    String description = _descriptionController.text.trim();

    // Validate form fields
    if (_imageFile.path.isEmpty || location.isEmpty || rent.isEmpty || description.isEmpty) {
      // Show error message if any field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill all the fields and upload an image.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Perform further actions with the data, like uploading to server
    // You can add your logic here
    // For now, we'll just print the data
    if (kDebugMode) {
      print('Location: $location');
      print('Rent: $rent');
      print('Description: $description');
      print('Image Path: ${_imageFile.path}');
    }

    // Clear form after submission
    _locationController.clear();
    _rentController.clear();
    _descriptionController.clear();
    setState(() {
      _imageFile = File(''); // Reset _imageFile to avoid null errors
    });

    // Show success message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Form submitted successfully!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Leading back icon
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(188, 7, 5, 151),  Color.fromARGB(185, 64, 131, 255),  Color.fromARGB(160, 105, 195, 240)],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  onTap: _selectImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                    ),
                    child: _imageFile.path.isNotEmpty
                        ? Image.file(_imageFile, fit: BoxFit.cover)
                        : const Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _locationController,
                  style: const TextStyle(color: Colors.white), // Text color white
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(color: Colors.white), // Label color white
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.white), // Border color white
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _rentController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white), // Text color white
                  decoration: const InputDecoration(
                    labelText: 'Rent Amount',
                    labelStyle: TextStyle(color: Colors.white), // Label color white
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.white), // Border color white
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white), // Text color white
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.white), // Label color white
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.white), // Border color white
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(5.0),
                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.orange.withOpacity(0.2);
                        }
                        return const Color.fromARGB(209, 250, 171, 86); // Use the default value.
                      },
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.orange.withOpacity(0.8);
                        }
                        return Colors.orangeAccent; // Use the default value.
                      },
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50.0,
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: UploadPage(),
  ));
}
