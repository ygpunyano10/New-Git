import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugas3/models/car_model.dart';
import 'package:tugas3/pages/CarPage.dart';
import 'package:tugas3/pages/widgets/CarPage2.dart';
import 'package:tugas3/pages/widgets/CarPage3.dart';
import 'package:tugas3/CarPage4.dart';

import '../../controller/car_controller.dart';
import '../../utils/constants.dart';
import '../searchCarPage.dart';

class CarRentWidget extends StatelessWidget{
  @override 
  Widget build (BuildContext context){
    return Column(
      children: [
        Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Description Car",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ), 
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchCarPage()));
              },
              child: Text(
                "See All",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        ),
        SizedBox(height: 15,),
        
        StreamBuilder(
          stream: CarController().streamCars(),
            builder: (context, snapshot){
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {

                  return ListCar(carModel: CarModel(id: document.id, name: document.get("name"),
                      price: document.get("price"),
                      category: document.get("category"), description: document.get("description"),
                      image: document.get("image"),
                  imageUrl: document.get("imageUrl")
                  ),);
                }).toList(),
                // children: [
                //   ListCar(i: 1, nama: 'Kijang Inova', harga: "Rp 600.000" ,route: "CarPage",),
                //   ListCar(i: 2, nama: 'Avanza', harga: "Rp 300.000" ,route: "CarPage2",),
                //   ListCar(i: 3, nama: 'Agya', harga: "Rp 250.000" ,route: "CarPage3",),
                //   ListCar(i: 4, nama: 'Ertiga', harga: "Rp 325.000" ,route: "CarPage4",),
                // ],
              ),
            ),
          );
        }),
        

      ],
    );
  }
}

class ListCar extends StatelessWidget {
  const ListCar({
    super.key,
    required this.carModel,
  });

  final CarModel carModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, "carPage", arguments: carModel);
      },
      child: Container(
        width: 170,
        height: 230,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Color(0xff292b37),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0xff292b37),
              spreadRadius: 2,
              blurRadius: 6,
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
              carModel.imageUrl??defaultImage,
                height: 130,
                width: 200,
                fit: BoxFit.cover,
                ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carModel.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Rp. ${carModel.price}",
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "9/10",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}