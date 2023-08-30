import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugas3/CarPage4.dart';
import 'package:tugas3/pages/CarPage.dart';
import 'package:tugas3/pages/CategoryPage.dart';
import 'package:tugas3/pages/HomePage.dart';
import 'package:tugas3/pages/addCarPage.dart';
import 'package:tugas3/pages/addCategoryPage.dart';
import 'package:tugas3/pages/categoryDetailPage.dart';
import 'package:tugas3/pages/editCarPage.dart';
import 'package:tugas3/pages/editCategoryPage.dart';
import 'package:tugas3/pages/login.dart';
import 'package:tugas3/pages/profilePage.dart';
import 'package:tugas3/pages/widgets/Akun.dart';
import 'package:tugas3/pages/widgets/CarPage2.dart';
import 'package:tugas3/pages/widgets/carpage3.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget{
  @override 
  State<MyApp> createState() => _MyAppState();
}
  
class _MyAppState extends State<MyApp>{
  @override
  void initState(){
    // To hide status bar and below buttons
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F111D),
      ),
      initialRoute: '/',
      routes: {
        "/": (context) =>const LoginPage(),
        "/home": (context) =>HomePage(),
        "categoryPage": (context) => CategoryPage(), 
        "addCategoryPage": (context) => const AddCategoryPage(),
        "editCategoryPage": (context) => const EditCategoryPage(),
        "categoryDetailPage": (context) => const CategoryDetailPage(),
        "carPage": (context) => CarPage(),
        "addCarPage": (context) => const AddCarPage(),
        "editCarPage": (context) => const EditCarPage(),
        "CarPage2": (context) => CarPage2(),
        "CarPage3": (context) => CarPage3(),
        "CarPage4": (context) => CarPage4(),
        "Akun": (context) => Akun(),
        "Profile": (context) => const ProfilePage(),
      },
    );
  }
}