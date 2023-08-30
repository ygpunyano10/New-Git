import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tugas3/models/car_model.dart';
import 'package:tugas3/pages/HomePage.dart';
import 'package:tugas3/pages/widgets/CarPageButtons.dart';
import 'package:tugas3/pages/widgets/CustomNavBar.dart';
import 'package:tugas3/pages/widgets/RecommendedWidget.dart';
import 'package:tugas3/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../utils/mydialog.dart';

class CarPage extends StatefulWidget {
  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  String? url;
  String? name;
  String? price;
  String? description;
  String? category;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as CarModel;
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Image.network(
              url ?? args.imageUrl ?? defaultImage,
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          var data = await Navigator.pushNamed(
                              context, "editCarPage",
                              arguments: CarModel(
                                  id: args.id,
                                  name: name ?? args.name,
                                  price: price ?? args.price,
                                  category: category ?? args.category,
                                  description: description ?? args.description,
                                  image: args.image,
                                  imageUrl: url ?? args.imageUrl)) as CarModel?;
                          if (data != null) {
                            setState(() {
                              url = data.imageUrl;
                              name = data.name;
                              price = data.price;
                              category = data.category;
                              description = data.description;
                            });
                          }
                        },
                        child: const Icon(
                          // Icons.favorite_border,
                          Icons.edit,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                  blurRadius: 8),
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            url ?? args.imageUrl ?? defaultImage,
                            height: 250,
                            width: 270,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                CarPageButtons(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name ?? args.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        price ?? args.price,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        // "Toyota Kijang Innova adalah sebuah Mobil MPV berukuran menengah buatan Toyota Motor Corporation yang diproduksi di Indonesia oleh Toyota-Astra Motor sejak tahun 2004. Kijang Innova merupakan penerus dari Toyota Kijang, dan diposisikan di atas Toyota Avanza dan Toyota Sienta, dan di bawah Toyota Voxy dan Toyota Alphard di lini kendaraan Toyota Indonesia. Toyota Kijang Innova adalah salah satu dari tiga produk Toyota yang memakai platform IMV sedang, yang lainnya adalah Toyota Hilux dan Toyota Fortuner. Di negara lain, mobil ini hanya disebut Toyota Innova. Dengan harga Rp 600.000, anda akan dapat menyewa mobil kijang inova selama 24 jam.",
                        description ?? args.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 1),
        child: ElevatedButton(
          onPressed: () async {
            String phoneNumber = "6287853184965";
            String urlWhatsapp = "";
            if (Platform.isAndroid) {
              urlWhatsapp =
                  "https://wa.me/${phoneNumber}/?text=hallo car rent app";
            } else {
              urlWhatsapp =
                  "https://api.whatsapp.com/send?phone=${phoneNumber}=hallo car rent app";
            }

            if (!await launchUrl(
              Uri.parse(
                  "https://wa.me/${phoneNumber}/?text=hallo car rent app"),
              mode: LaunchMode.externalApplication,
            )) {
              MyDialog().myAlertDialog(context,
                  content: 'Could not launch ${urlWhatsapp}');
              throw 'Could not launch ${urlWhatsapp}';
            }
          },
          child: const Text(
            'Book Now',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
