import 'dart:io'; // Cần import để sử dụng File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterDesignerScreen extends StatefulWidget {
  const RegisterDesignerScreen({super.key});

  @override
  _RegisterDesignerScreenState createState() => _RegisterDesignerScreenState();
}

class _RegisterDesignerScreenState extends State<RegisterDesignerScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _cvFile;
  List<XFile>? _projectImages = [];
  final ImagePicker _picker = ImagePicker();

  // Method to pick a CV image from device
  Future<void> _pickCV() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _cvFile = pickedFile;
    });
  }

  // Method to pick project images from device
  Future<void> _pickProjectImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    setState(() {
      if (pickedFiles != null) {
        _projectImages = pickedFiles;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register as Designer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16), // Add space between fields

              // Email field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16), // Add space between fields

              // Phone field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16), // Add space between fields

              // Address field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Add space before upload CV button

              // Upload CV button
              TextButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload CV"),
                onPressed: _pickCV,
              ),

              // Display CV image if selected
              if (_cvFile != null) 
                Column(
                  children: [
                    const Text('CV uploaded:'),
                    Image.file(
                      File(_cvFile!.path),
                      height: 200,
                    ),
                  ],
                ),
              const SizedBox(height: 20), // Add space before upload project images button

              // Upload project images button
              TextButton.icon(
                icon: const Icon(Icons.image),
                label: const Text("Upload Project Images"),
                onPressed: _pickProjectImages,
              ),

              // Display selected project images
              if (_projectImages != null && _projectImages!.isNotEmpty)
                Wrap(
                  spacing: 10,
                  children: _projectImages!.map((image) {
                    return Image.file(
                      File(image.path), 
                      width: 100, 
                      height: 100, 
                      fit: BoxFit.cover
                    );
                  }).toList(),
                ),
              const SizedBox(height: 20), // Add space before submit button

              // Submit button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process form data
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
