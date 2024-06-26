import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moveassist/core/helpers/extensions.dart';
import 'package:moveassist/featurs/home/data/models/moving_schedule.dart';
import 'package:moveassist/featurs/home/logic/moving_schedule_cubit.dart';

class AddHouseItemScreen extends StatefulWidget {
  final HouseItem? item;

  const AddHouseItemScreen({super.key, this.item});

  @override
  AddHouseItemScreenState createState() => AddHouseItemScreenState();
}

class AddHouseItemScreenState extends State<AddHouseItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _quantityController.text = widget.item!.quantity.toString();
      _descriptionController.text = widget.item!.description;
      _image = XFile(widget.item!.imageUrl);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      _image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Add House Item' : 'Edit House Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Item Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(labelText: 'Item Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item quantity';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration:
                      const InputDecoration(labelText: 'Item Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _image == null
                    ? const Text('No image selected.')
                    : Image.file(File(_image!.path)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: const Text('Pick Image from Camera'),
                ),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: const Text('Pick Image from Gallery'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final item = HouseItem(
                        id: widget.item?.id ??
                            DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _nameController.text,
                        quantity: int.parse(_quantityController.text),
                        description: _descriptionController.text,
                        imageUrl: _image?.path ?? '',
                      );
                      context
                          .read<MovingScheduleCubit>()
                          .addOrUpdateHouseItem(item);
                      context.pop();
                    }
                  },
                  child: const Text('Save Item'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
