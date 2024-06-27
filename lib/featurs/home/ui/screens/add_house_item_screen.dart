import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moveassist/core/helpers/extensions.dart';
import 'package:moveassist/core/helpers/spacing.dart';
import 'package:moveassist/core/widgets/buttons/app_elevated_button.dart';
import 'package:moveassist/core/widgets/buttons/app_text_form_field.dart';
import 'package:moveassist/featurs/home/data/models/moving_schedule.dart';
import 'package:moveassist/featurs/home/logic/moving_schedule_cubit.dart';
import 'package:tflite_v2/tflite_v2.dart';

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
  File? file;
  XFile? _image;
  var _recognitions;
  var v = "";

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });

    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _quantityController.text = widget.item!.quantity.toString();
      _descriptionController.text = widget.item!.description;
      _image = XFile(widget.item!.imageUrl);
    }
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/models/model_unquant.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      setState(
        () {
          _image = pickedFile;
          file = File(pickedFile!.path);
        },
      );
      detectimage(file!);
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future detectimage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions;
      v = recognitions.toString();
      _nameController.text = _recognitions[0]['label'].toString().substring(2);
    });
    debugPrint(_recognitions);
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
                AppTextFormField(
                  controller: _nameController,
                  hintText: 'Item Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item name';
                    }
                    return null;
                  },
                ),
                verticalSpace(16),
                AppTextFormField(
                  controller: _quantityController,
                  hintText: 'Item Quantity',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item quantity';
                    }
                    final quantity = int.tryParse(value);
                    if (quantity == null || quantity < 1) {
                      return 'Please enter a quantity of 1 or more';
                    }
                    return null;
                  },
                ),
                verticalSpace(16),
                AppTextFormField(
                  controller: _descriptionController,
                  hintText: 'Item Description',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item description';
                    }
                    return null;
                  },
                ),
                verticalSpace(16),
                _image == null
                    ? const Text('No image selected.')
                    : Image.file(File(_image!.path)),
                verticalSpace(16),
                AppElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  text: 'Pick Image from Camera',
                ),
                AppElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  text: 'Pick Image from Gallery',
                ),
                verticalSpace(16),
                AppElevatedButton(
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
                  text: 'Add Item',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
