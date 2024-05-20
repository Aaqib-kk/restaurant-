import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/models/menu_item.dart';
import 'package:restaurant_menu/viewmodel/menu_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class EditMealPage extends StatefulWidget {
  final MenuItem menuItem;

  EditMealPage({required this.menuItem});

  @override
  _EditMealPageState createState() => _EditMealPageState();
}

class _EditMealPageState extends State<EditMealPage> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;
  Uint8List? _imageBytes;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.menuItem.name);
    priceController = TextEditingController(text: widget.menuItem.price?.toString());
    descriptionController = TextEditingController(text: widget.menuItem.description);
    categoryController = TextEditingController(text: widget.menuItem.category);
    _imageUrl = widget.menuItem.imageUrl;
  }

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
        title: Text('Edit Meal'),
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
                ? Image.network(_imageUrl ?? '', height: 150.0)
                : Image.memory(_imageBytes!, height: 150.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String imageUrl = _imageUrl ?? '';
                if (_imageBytes != null) {
                  imageUrl = await Provider.of<MenuViewModel>(context, listen: false).uploadImage(_imageBytes!);
                }
                MenuItem updatedMenuItem = MenuItem(
                  sId: widget.menuItem.sId,
                  name: nameController.text,
                  price: double.parse(priceController.text),
                  description: descriptionController.text,
                  category: categoryController.text,
                  imageUrl: imageUrl,
                );
                await Provider.of<MenuViewModel>(context, listen: false).updateMenuItem(updatedMenuItem);
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
