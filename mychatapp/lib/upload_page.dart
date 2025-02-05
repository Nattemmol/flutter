import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  // Function to handle form submission
  void _submitForm() {
    // Get values from controllers
    String location = _locationController.text.trim();
    String rent = _rentController.text.trim();
    String description = _descriptionController.text.trim();

    // Validate form fields
    if (_imageFile.path.isEmpty ||
        location.isEmpty ||
        rent.isEmpty ||
        description.isEmpty) {
      // Show error message if any field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content:
              const Text('Please fill all the fields and upload an image.'),
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
    }
    if (kDebugMode) {
      print('Rent: $rent');
    }
    if (kDebugMode) {
      print('Description: $description');
    }
    if (kDebugMode) {
      print('Image Path: ${_imageFile.path}');
    }

    // Clear form after submission
    _locationController.clear();
    _rentController.clear();
    _descriptionController.clear();
    setState(() {
      _imageFile = File('');
    });

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
        // backgroundColor: Colors.teal.shade300,
        title: const Text('Upload Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Leading back icon
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(0.0),
          padding: const EdgeInsets.all(40.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 117, 117, 117),
                Color.fromARGB(255, 56, 56, 56),
                Color.fromARGB(255, 107, 107, 107)
              ],
            ),
          ),
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
                    border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                  child: _imageFile.path.isNotEmpty
                      ? Image.file(_imageFile, fit: BoxFit.cover)
                      : const Icon(Icons.camera_alt,
                          size: 50, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _locationController,
                style: const TextStyle(
                    color: Colors.white, fontSize: 18.0), // Text color white
                decoration: const InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _rentController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    color: Colors.white, fontSize: 18.0), // Text color white
                decoration: const InputDecoration(
                  labelText: 'Rent Amount',
                  labelStyle:
                      TextStyle(color: Colors.white), // Label color white
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: Colors.white), // Border color white
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                style: const TextStyle(
                    color: Colors.white, fontSize: 18.0), // Text color white
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle:
                      TextStyle(color: Colors.white), // Label color white
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                        BorderSide(color: Colors.white), // Border color white
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
                      return const Color.fromARGB(
                          209, 250, 171, 86); // Use the default value.
                    },
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color.fromARGB(255, 53, 53, 53)
                            .withOpacity(0.8);
                      }
                      return const Color.fromARGB(
                          255, 36, 37, 37); // Use the default value.
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
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 205, 205, 205),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home,
                  color: Color.fromARGB(255, 62, 68, 71)),
              onPressed: () {
                // Handle home button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.person,
                  color: Color.fromARGB(255, 62, 68, 71)),
              onPressed: () {
                // Handle profile button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications,
                  color: Color.fromARGB(255, 62, 68, 71)),
              onPressed: () {
                // Handle notification button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromARGB(255, 62, 68, 71)),
              onPressed: () {
                // Handle back button press
              },
            ),
          ],
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
