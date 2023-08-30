import 'package:flutter/material.dart';
import 'package:tugas3/pages/HomePage.dart';
import 'package:tugas3/pages/widgets/CarPageButtons.dart';
import 'package:tugas3/pages/widgets/CarRentWidget.dart';
import 'package:tugas3/pages/widgets/CustomNavBar.dart';
import 'package:tugas3/pages/widgets/RecommendedWidget.dart';

class CarPage2 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity:0.4,
            child: Image.asset(
              "images/mobil_2.jpg",
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
                        InkWell(
                          onTap: (){
                          },
                          child: Icon(
                            Icons.favorite_border, 
                          color: Colors.white, 
                          size: 35,
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
                                'images/mobil_2.jpg',
                                height: 250,
                                width: 270,
                              ),
                          ),
                          ),
                          
                        ],
                      ),
                      ),
                      SizedBox(height: 30),
                      CarPageButtons(),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Avanza",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              "Toyota Avanza adalah mobil yang diproduksi di Indonesia oleh pabrikan Daihatsu, yang dipasarkan juga oleh Daihatsu dengan nama Daihatsu Xenia. Generasi pertama mobil ini diluncurkan pada tanggal 11 Desember 2003. Nama Avanza berasal dari bahasa Italia dan bahasa Spanyol avanzato/avanza, yang berarti peningkatan. Dengan harga Rp 300.000, anda akan dapat menyewa mobil avanza selama 24 jam.",
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
  