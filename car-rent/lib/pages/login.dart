import 'package:flutter/material.dart';
import 'package:tugas3/controller/auth_controller.dart';
import 'package:tugas3/models/response_model.dart';
import 'package:tugas3/pages/HomePage.dart';
import 'package:tugas3/pages/SignUp.dart';
import 'package:tugas3/utils/constants.dart';

import '../utils/mydialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  bool hidePass = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void signIn(String email, String password) async {
    setState(() {
      loading = true;
    });

    ResponseModel responseModel =
        await AuthController().signIn(email, password);
    setState(() {
      loading = false;
    });
    if (responseModel.success) {
      if (!mounted) return;
      userSession = responseModel.data;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
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
              padding: const EdgeInsets.only(top: 60.0, bottom: 10),
              child: Center(
                child: Container(
                  width: 300,
                  height: 150,
                  child: Image.asset("images/car_1.jpg"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: email,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
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
                style: const TextStyle(color: Colors.white),
                obscureText: hidePass,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.white),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          hidePass = !hidePass;
                        });
                      },
                      child: Icon(
                        hidePass ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      )),
                  hintText: 'Enter secure password',
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            loading? CircularProgressIndicator() : Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HomePage()),
                  // );
                  signIn(email.text, password.text);
                },
                child: const Text('Login'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Does not have account?',
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
