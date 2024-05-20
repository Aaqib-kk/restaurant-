import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/models/menu_item.dart';
import 'package:restaurant_menu/viewmodel/menu_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class CreateMealPage extends StatefulWidget {
  @override
  _CreateMealPageState createState() => _CreateMealPageState();
}

class _CreateMealPageState extends State<CreateMealPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _imageBytes = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Meal'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 16.0),
            _imageBytes == null
                ? Text('No image selected.')
                : Image.memory(_imageBytes!, height: 150.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_imageBytes != null) {
                  String imageUrl = await Provider.of<MenuViewModel>(context, listen: false).uploadImage(_imageBytes!);
                  MenuItem menuItem = MenuItem(
                    name: nameController.text,
                    price: double.parse(priceController.text),
                    description: descriptionController.text,
                    category: categoryController.text,
                    imageUrl: imageUrl,
                  );
                  await Provider.of<MenuViewModel>(context, listen: false).createMenuItem(menuItem);
                  Navigator.pop(context);
                }
              },
              child: Text('Create Meal'),
            ),
          ],
        ),
      ),
    );
  }
}
