import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:tugas3/models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/response_model.dart';
import '../utils/constants.dart';

class CategoryController {
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  Stream collectionStream =
      FirebaseFirestore.instance.collection('category').snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamUpComingCategories() {
    return FirebaseFirestore.instance
        .collection('category')
        .where("status", isEqualTo: "UpComing")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCategories() {
    return FirebaseFirestore.instance.collection('category').snapshots();
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> list = [];
    await category.get().then((value) => {
          for (var a in value.docs)
            {
              list.add(CategoryModel(
                  id: a.id,
                  name: a.get("name"),
                  status: a.get("status"),
                  image: a.get("image"),
                  imageUrl: a.get("imageUrl")))
            }
        });

    return list;
  }

  Future<ResponseModel> addCategory(
      CategoryModel categoryModel, File? imageFile) async {
    try {
      if (categoryModel.name.isEmpty) {
        return ResponseModel(
            success: false, message: "Name Can't be empty", data: null);
      } else if (imageFile == null) {
        return ResponseModel(
            success: false, message: "Image Can't be empty", data: null);
      } else {
        var data =
            await category.where("name", isEqualTo: categoryModel.name).get();
        if (data.docs.isNotEmpty) {
          return ResponseModel(
              success: false,
              message: "Category already registered",
              data: null);
        } else {
          Reference reference =
              FirebaseStorage.instance.ref().child(basename(imageFile.path));
          await reference.putFile(File(imageFile.path)).catchError((e) {
            throw e;
          });

          String imgUrl =
              await downloadUrlImage(imageName: basename(imageFile.path));
          await category.add({
            "name": categoryModel.name,
            "status": categoryModel.status,
            "image": basename(imageFile.path),
            "imageUrl": imgUrl,
          });

          return ResponseModel(
              success: true, message: "Add Category successfully", data: null);
        }
      }
    } catch (e) {
      return ResponseModel(success: false, message: e.toString(), data: null);
    }
  }

  Future<ResponseModel> editCategory(
      CategoryModel categoryModel, File? imageFile) async {
    try {
      if (categoryModel.name.isEmpty) {
        return ResponseModel(
            success: false, message: "Name Can't be empty", data: null);
      } else if (categoryModel.status.isEmpty) {
        return ResponseModel(
            success: false, message: "Name Can't be empty", data: null);
      } else {
        String img = categoryModel.image;
        String imgUrl = categoryModel.imageUrl ?? defaultImage;
        if (imageFile != null) {
          img = basename(imageFile.path);

          Reference reference =
              FirebaseStorage.instance.ref().child(basename(imageFile.path));
          await reference.putFile(File(imageFile.path)).catchError((e) {
            throw e;
          });
          imgUrl = await downloadUrlImage(imageName: basename(imageFile.path));
        }

        print(categoryModel.status);

        await category.doc(categoryModel.id).set({
          "name": categoryModel.name,
          "status": categoryModel.status,
          "image": img,
          "imageUrl": imgUrl,
        });

        return ResponseModel(
            success: true,
            message: "Edit Category successfully",
            data: CategoryModel(
                id: categoryModel.id,
                name: categoryModel.name,
                status: categoryModel.status,
                image: img,
                imageUrl: imgUrl));
      }
    } catch (e) {
      return ResponseModel(success: false, message: e.toString(), data: null);
    }
  }

  Future<ResponseModel> deleteCategory(String id) async {
    try {
      await category
          .doc(id)
          .delete()
          .then((value) => print("User Deleted"))
          .catchError((error) => throw error);
      return ResponseModel(
          success: true, message: "Delete Category successfully", data: null);
    } catch (e) {
      return ResponseModel(success: false, message: e.toString(), data: null);
    }
  }

  Future<String> changeAndUploadImage(String doc) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      String fileName = basename(image.path);

      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      UploadTask task = reference.putFile(File(image.path));
      // await (await task).ref.getDownloadURL();
      await category.doc(doc).update({'image': fileName});
      return await (await task).ref.getDownloadURL();
    }

    return defaultImage;
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
}
