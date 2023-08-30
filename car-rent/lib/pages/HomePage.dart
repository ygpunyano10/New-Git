import 'package:flutter/material.dart';
import 'package:tugas3/pages/searchCarPage.dart';
import 'widgets/CarRentWidget.dart';
import 'widgets/CustomNavBar.dart';
import 'widgets/UpcomingWidget.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                vertical: 18, 
                horizontal: 10, 
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Car Rent App",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 30,
                         fontWeight: FontWeight.w500
                       ),
                      ),
                      Text(
                        "what car do you want to rent?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                       )
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "Profile");
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset("images/profile.jpg",
                      height: 60,
                      width: 60,
                      ),
                    ),
                  )
                ],),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchCarPage()));
                },
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal:10),
                  decoration: BoxDecoration(
                    color: Color(0xFF292B37),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(children: [
                    Icon(
                      Icons.search,
                      color: Colors.white70,
                      size: 25,
                      ),
                    Container(
                      width: 300,
                      margin: EdgeInsets.only(left: 7),
                      child: TextFormField(
                        enabled: false,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                      ),
                    )
                  ],),
                ),
              ),
              SizedBox(height: 40,),
              UpcomingWidget(),
              SizedBox(height: 40,),
              CarRentWidget(),
            ],
          )
        ), 
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
      