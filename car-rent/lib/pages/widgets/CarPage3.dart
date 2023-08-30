import 'package:flutter/material.dart';
import 'package:tugas3/pages/HomePage.dart';
import 'package:tugas3/pages/widgets/CarPageButtons.dart';
import 'package:tugas3/pages/widgets/CarRentWidget.dart';
import 'package:tugas3/pages/widgets/CustomNavBar.dart';
import 'package:tugas3/pages/widgets/RecommendedWidget.dart';

class CarPage3 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity:0.4,
            child: Image.asset(
              "images/mobil_3.jpg",
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
                                'images/mobil_3.jpg',
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
                              "Agya",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              "Toyota Agya Sejak peluncurannya pada 2013 lalu, kini PT Toyota Astra Motor (TAM) kembali merilis Toyota Agya facelift. Mobil LCGC (Low Cost Green Car) buatan pabrik asal Jepang ini telah mendapat penyegaran pada beberapa segmen yang membuatnya makin tampak lebih modern dan canggih, baik dari sisi eksterior, interior, mesin serta fitur-fitur yang disematkannya. Di sisi lain, peluncuran Toyota Agya facelift ini memang diyakini akan mampu mendongkrak penjualan Toyota mengingat pada tahun 2016, LCGC ini telah berhasil mempertahankan pangsa pasar hingga 30%. Sehingga, bukan tak mungkin apabila LCGC ini angka penjualannya lebih mampu untuk ditingkatkan lagi. Di samping itu, produk Toyota Agya ini pun akan dibanderol dengan harga yang relatif terjangkau dan dibekali spesifikasi cukup mumpuni guna memenuhi kebutuhan konsumen, terutama para kawula muda. Dengan harga Rp 250.000, anda akan dapat menyewa mobil agya selama 24 jam. ",
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
  