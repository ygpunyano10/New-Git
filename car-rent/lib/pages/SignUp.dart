import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugas3/controller/auth_controller.dart';
import 'package:tugas3/models/response_model.dart';
import 'package:tugas3/models/user_model.dart';
import 'package:tugas3/pages/HomePage.dart';
import 'package:tugas3/utils/mydialog.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void signUp() async {
    setState(() {
      loading = true;
    });

    ResponseModel responseModel = await AuthController().signUp(UserModel(
        name: name.text,
        email: email.text,
        password: password.text,
        role: "Customer"));
    setState(() {
      loading = false;
    });

    if (responseModel.success) {
      if (!mounted) return;
      MyDialog().myDialogPrimary(context,
          title: "Success", content: "register successfully", onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          loading = false;
        });
        Navigator.of(context).pop();
      });
    } else {
      if (!mounted) return;
      MyDialog().myAlertDialog(context, content: responseModel.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 100),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: name,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter Your Name',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
              child: TextField(
                controller: email,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter valid email id as abc@gmail.com',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
              child: TextField(
                controller: password,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter secure password',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            loading
                ? CircularProgressIndicator()
                : Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 1),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => HomePage()),
                        // );
                        signUp();
                      },
                      child: const Text('Login'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
