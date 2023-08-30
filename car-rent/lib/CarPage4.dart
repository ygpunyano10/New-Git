import 'package:flutter/material.dart';
import 'package:tugas3/pages/HomePage.dart';
import 'package:tugas3/pages/widgets/CarPageButtons.dart';
import 'package:tugas3/pages/widgets/CarRentWidget.dart';
import 'package:tugas3/pages/widgets/CustomNavBar.dart';
import 'package:tugas3/pages/widgets/RecommendedWidget.dart';

class CarPage4 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity:0.4,
            child: Image.asset(
              "images/mobil_4.jpg",
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
                                'images/mobil_4.jpg',
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
                              "Ertiga",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              "Ertiga adalah mobil berjenis MPV yang diproduksi oleh Suzuki sejak tahun 2012. Nama Ertiga berasal dari bahasa Indonesia, yaitu gabungan dari: Er (dari huruf R) yang berarti Row (baris) dan Tiga yang berarti angka 3, berarti mobil yang memiliki 3 baris pada interiornya dengan berkapasitas 7 orang penumpang dewasa/7-seater seperti MPV (Multi Purpose Vehicle). Suzuki Ertiga merupakan perpaduan MPV dan Sedan, yakni dengan platform Suzuki Swift generasi ketiga. Ertiga akan dipasarkan prinsipal Suzuki Motor Corporation Jepang secara global. Mazda juga pernah memasarkan Suzuki Ertiga generasi pertama di Indonesia sebagai Mazda VX-1. Selain itu, Proton juga pernah memasarkan Suzuki Ertiga generasi pertama di Malaysia sejak tanggal 24 November 2016 sebagai Proton Ertiga.Dengan harga Rp 325.000, anda akan dapat menyewa mobil ertiga selama 24 jam.",
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
  