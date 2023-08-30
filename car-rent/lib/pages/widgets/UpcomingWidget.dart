import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugas3/controller/category_controller.dart';

class UpcomingWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upcoming Category Car",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 15),

        StreamBuilder(
            stream: CategoryController().streamUpComingCategories(),
            builder: (context, snapshot){
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                    print(data.toString());
                    print(data.keys.toString());
                    print(data["image"].toString());
                    return Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          document.get("imageUrl"),
                          height: 180,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList()
                ),
              );
            }),

        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       for(int i=1; i<4; i++)
        //       Padding(
        //         padding: EdgeInsets.only(left: 10),
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(15),
        //           child: Image.asset(
        //             "images/car_$i.jpg",
        //             height: 180,
        //             width: 300,
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }
}