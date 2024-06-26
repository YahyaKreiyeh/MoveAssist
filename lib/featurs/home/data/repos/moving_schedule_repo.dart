import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:moveassist/core/networking/api_error_handler.dart';
import 'package:moveassist/core/networking/api_result.dart';
import 'package:moveassist/featurs/home/data/models/moving_schedule.dart';

class MovingScheduleRepo {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  MovingScheduleRepo(
      this._firebaseAuth, this._firestore, this._firebaseStorage);

  Future<ApiResult<HouseItem>> _uploadHouseItem(HouseItem item) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'ERROR_USER_NOT_FOUND',
          message: 'User not found',
        );
      }

      // Upload image to Firebase Storage
      File imageFile = File(item.imageUrl);
      String fileName =
          '${user.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      UploadTask uploadTask =
          _firebaseStorage.ref().child(fileName).putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Add or update item in Firestore with the image URL
      final docRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('house_items')
          .doc(item.id.isEmpty
              ? _firestore.collection('users').doc().id
              : item.id);
      final houseItem = HouseItem(
        id: docRef.id,
        name: item.name,
        quantity: item.quantity,
        description: item.description,
        imageUrl: imageUrl,
      );
      await docRef.set(houseItem.toJson());

      return ApiResult.success(houseItem);
    } catch (error) {
      print('Error uploading house item: $error');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<MovingSchedule>> addMovingSchedule(
    DateTime date,
    String notes,
    List<HouseItem> items,
  ) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'ERROR_USER_NOT_FOUND',
          message: 'User not found',
        );
      }

      // Upload each house item and collect the results
      List<HouseItem> uploadedItems = [];
      for (HouseItem item in items) {
        final result = await _uploadHouseItem(item);
        result.when(
          success: (uploadedItem) {
            uploadedItems.add(uploadedItem);
            print('Successfully uploaded item: ${uploadedItem.id}');
          },
          failure: (error) {
            print('Failed to upload item: $error');
            throw Exception(error.apiErrorModel.message);
          },
        );
      }

      // Create moving schedule document
      final docRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('moving_schedules')
          .doc();
      final movingSchedule = MovingSchedule(
        id: docRef.id,
        date: date,
        notes: notes,
        items: uploadedItems,
      );

      print(
          'MovingSchedule toJson: ${movingSchedule.toJson()['items'][0].toString()}');
      for (var item in uploadedItems) {
        print('HouseItem toJson: ${item.toJson()}');
      }

      await docRef.set(movingSchedule.toJson());
      print('Successfully created moving schedule: ${docRef.id}');

      return ApiResult.success(movingSchedule);
    } catch (error) {
      print('Error adding moving schedule: $error');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<MovingSchedule>>> getMovingSchedules() async {
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
          .collection('moving_schedules')
          .get();
      final movingSchedules = querySnapshot.docs
          .map((doc) => MovingSchedule.fromJson(doc.data()))
          .toList();

      return ApiResult.success(movingSchedules);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> deleteMovingSchedule(String scheduleId) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'ERROR_USER_NOT_FOUND',
          message: 'User not found',
        );
      }

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('moving_schedules')
          .doc(scheduleId)
          .delete();

      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
