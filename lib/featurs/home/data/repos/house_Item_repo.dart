import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moveassist/core/networking/api_error_handler.dart';
import 'package:moveassist/core/networking/api_result.dart';
import 'package:moveassist/featurs/home/data/models/house_item.dart';

class HouseItemRepo {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  HouseItemRepo(this._firebaseAuth, this._firestore, this._firebaseStorage);

  Future<ApiResult<HouseItem>> addHouseItem(
      String name, String description, XFile image) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'ERROR_USER_NOT_FOUND',
          message: 'User not found',
        );
      }

      // Log user info
      print('User ID: ${user.uid}');

      // Upload image to Firebase Storage
      File imageFile = File(image.path);
      String fileName =
          '${user.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Log file info
      print('Uploading file: $fileName');

      UploadTask uploadTask =
          _firebaseStorage.ref().child(fileName).putFile(imageFile);

      // Await the completion of the upload task
      TaskSnapshot taskSnapshot = await uploadTask;
      print('Upload complete');

      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Log image URL
      print('Image URL: $imageUrl');

      // Add item to Firestore with the image URL
      final docRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('house_items')
          .doc();
      final houseItem = HouseItem(
        id: docRef.id,
        name: name,
        description: description,
        imageUrl: imageUrl,
      );
      await docRef.set(houseItem.toJson());

      // Log success
      print('Item added to Firestore');

      return ApiResult.success(houseItem);
    } catch (error) {
      // Log errors
      print('Error: $error');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<HouseItem>>> getHouseItems() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'ERROR_USER_NOT_FOUND',
          message: 'User not found',
        );
      }

      final querySnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('house_items')
          .get();
      final houseItems = querySnapshot.docs
          .map((doc) => HouseItem.fromJson(doc.data()))
          .toList();

      return ApiResult.success(houseItems);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
