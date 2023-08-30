import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:tugas3/models/car_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/response_model.dart';
import '../utils/constants.dart';

class CarController{
  CollectionReference cars =
  FirebaseFirestore.instance.collection('cars');
  Stream collectionStream =
  FirebaseFirestore.instance.collection('cars').snapshots();

  Future<List<CarModel>> getAllCar() async {
    List<CarModel> list = [];
    await cars.get().then((value) => {
      for (var a in value.docs)
        {
          list.add(CarModel(
              id: a.id,
              name: a.get("name"),
              category: a.get("category"),
              description: a.get("description"),
              price: a.get("price"),
              image: a.get("image"),
              imageUrl: a.get("imageUrl")))
        }
    });

    return list;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCars() {
    return FirebaseFirestore.instance.collection('cars').snapshots();
  }

  Future<String> downloadUrlImage({required String imageName}) async {
    try {
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(imageName)
          .getDownloadURL();
      return downloadURL;
    } catch (e) {
      return defaultImage;
    }
  }
  
  Future<ResponseModel> addCar(
      CarModel carModel, File? imageFile) async {
    try {
      if (carModel.name.isEmpty) {
        return ResponseModel(
            success: false, message: "Name Can't be empty", data: null);
      }else if (carModel.price.isEmpty) {
        return ResponseModel(
            success: false, message: "Price Can't be empty", data: null);
      }else if (carModel.category.isEmpty) {
        return ResponseModel(
            success: false, message: "Category Can't be empty", data: null);
      }else if (carModel.description.isEmpty) {
        return ResponseModel(
            success: false, message: "Description Can't be empty", data: null);
      }else if (imageFile == null) {
        return ResponseModel(
            success: false, message: "Image Can't be empty", data: null);
      } else {
          Reference reference =
          FirebaseStorage.instance.ref().child(basename(imageFile.path));
          await reference.putFile(File(imageFile.path)).catchError((e) {
            throw e;
          });

          String imgUrl =
          await downloadUrlImage(imageName: basename(imageFile.path));
          await cars.add({
            "name": carModel.name,
            "price": carModel.price,
            "category": carModel.category,
            "description": carModel.description,
            "image": basename(imageFile.path),
            "imageUrl": imgUrl,
          });

          return ResponseModel(
              success: true, message: "Add Cars successfully", data: null);

      }
    } catch (e) {
      return ResponseModel(success: false, message: e.toString(), data: null);
    }
  }

  Future<ResponseModel> editCar(
      CarModel carModel, File? imageFile) async {
    try {
      if (carModel.name.isEmpty) {
        return ResponseModel(
            success: false, message: "Name Can't be empty", data: null);
      }else if (carModel.price.isEmpty) {
        return ResponseModel(
            success: false, message: "Price Can't be empty", data: null);
      }else if (carModel.category.isEmpty) {
        return ResponseModel(
            success: false, message: "Category Can't be empty", data: null);
      }else if (carModel.description.isEmpty) {
        return ResponseModel(
            success: false, message: "Description Can't be empty", data: null);
      } else {
        String img = carModel.image;
        String imgUrl = carModel.imageUrl ?? defaultImage;
        if (imageFile != null) {
          img = basename(imageFile.path);

          Reference reference =
          FirebaseStorage.instance.ref().child(basename(imageFile.path));
          await reference.putFile(File(imageFile.path)).catchError((e) {
            throw e;
          });
          imgUrl = await downloadUrlImage(imageName: basename(imageFile.path));
        }

        await cars.doc(carModel.id).set({
          "name": carModel.name,
          "price": carModel.price,
          "category" : carModel.category,
          "description" : carModel.description,
          "image": img,
          "imageUrl": imgUrl,
        });

        return ResponseModel(
            success: true,
            message: "Edit Car successfully",
            data: CarModel(
                id: carModel.id,
                name: carModel.name,
                price: carModel.price,
                category: carModel.category,
                description: carModel.description,
                image: img,
                imageUrl: imgUrl));
      }
    } catch (e) {
      return ResponseModel(success: false, message: e.toString(), data: null);
    }
  }
  
}