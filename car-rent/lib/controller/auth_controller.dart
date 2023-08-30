import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugas3/models/response_model.dart';
import 'package:tugas3/models/user_model.dart';
import 'package:tugas3/utils/constants.dart';

class AuthController {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<ResponseModel> signIn(String email, String password) async {
    if (!RegExp(emailRegex)
        .hasMatch(email)) {
      return ResponseModel(
          success: false, message: "Email not valid", data: null);
    } else if (password.isEmpty) {
      return ResponseModel(
          success: false, message: "Password Can't be empty", data: null);
    } else {
      var data = await users.doc(email).get();
      if (data.exists) {
        String getPass = data.get("password");
        if (getPass == password) {
          return ResponseModel(
              success: true, message: "Sign-in Successfully", data: UserModel(
            name: data.get("name"),
            email: data.id,
            password: data.get("password"),
            role: data.get("role"),
          ));
        } else {
          return ResponseModel(
              success: false, message: "Password Wrong", data: null);
        }
      } else {
        return ResponseModel(
            success: false,
            message: "E-mail Not already registered",
            data: null);
      }
    }
  }

  Future<ResponseModel> signUp(UserModel userModel) async {
    try{
      if (userModel.name.isEmpty) {
        return ResponseModel(
            success: false, message: "Name Can't be empty", data: null);
      } else if (!RegExp(
          emailRegex)
          .hasMatch(userModel.email)) {
        return ResponseModel(
            success: false, message: "Email not valid", data: null);
      } else if (userModel.password.isEmpty) {
        return ResponseModel(
            success: false, message: "Password Can't be empty", data: null);
      } else {
        var data = await users.doc(userModel.email).get();
        if (data.exists) {
          return ResponseModel(
              success: false, message: "E-mail already registered", data: null);
        } else {
          users.doc(userModel.email).set({
            "name": userModel.name,
            "role": "customer",
            "password": userModel.password,
            "image": "default-image.png",
          });
          return ResponseModel(
              success: true, message: "register successfully", data: null);

        }
      }
    }catch(e){
      return ResponseModel(
          success: false, message: "Something went wrong", data: null);
    }



  }
}
