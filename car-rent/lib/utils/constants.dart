import 'package:tugas3/models/user_model.dart';

String emailRegex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

String defaultImage = "https://firebasestorage.googleapis.com/v0/b/tugas3-9d4a8.appspot.com/o/default-image.png?alt=media&token=e30d7dcb-f866-4e5c-a0c6-218a128f32b8";

UserModel userSession = UserModel(name: "", email: "", password: "", role: "");