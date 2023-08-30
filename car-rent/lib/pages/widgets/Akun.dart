import 'package:flutter/material.dart';
import 'package:tugas3/pages/widgets/CustomNavBar.dart';

class Akun extends StatelessWidget{
  @override
  
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity:0.4,
            child: Image.asset(
              "images/fazamifzal.jpg",
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child:Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10,  horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back, 
                          color: Colors.white, 
                          size: 30,
                          ),
                        ),
                        
                      ],
                    ),
                    ),
                    SizedBox(height: 60,),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 8
                                ),
                              ]
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'images/fazamifzal.jpg',
                                height: 350,
                                width: 270,
                              ),
                          ),
                          ),
                          
                        ],
                      ),
                      ),
                      SizedBox(height: 30),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About Us",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              "NAME: Muhammad Dimas Faza                     NIM: 082111633029                                          AGE: 19",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              "NAME: Mifzal Novel                                           NIM: 082111633082                                               AGE: 20",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        ),
                        SizedBox(height: 10),
                        
                ],
              )
              ),
          )
        ],
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}