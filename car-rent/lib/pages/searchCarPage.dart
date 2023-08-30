import 'package:flutter/material.dart';
import 'package:tugas3/controller/car_controller.dart';
import 'package:tugas3/models/car_model.dart';
import 'package:tugas3/utils/constants.dart';

class SearchCarPage extends StatefulWidget {
  const SearchCarPage({Key? key}) : super(key: key);

  @override
  State<SearchCarPage> createState() => _SearchCarPageState();
}

class _SearchCarPageState extends State<SearchCarPage> {
  bool loading = false;
  TextEditingController search = TextEditingController();
  List<CarModel> cars = [];
  List<CarModel> filterCars = [];

  List<CarModel> _buildSearchList(String keyword) {
    List<CarModel> _searchList = [];

    for (int i = 0; i < cars.length; i++) {
      String name = cars[i].name;
      if (name.toLowerCase().contains(keyword.toLowerCase())) {
        _searchList.add(cars[i]);
      }
    }

    return _searchList;
  }

  @override
  void initState() {
    getAllCar();
    super.initState();
  }

  getAllCar() async {
    setState(() {
      loading = true;
    });
    cars = await CarController().getAllCar();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: loading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: search,
                        style: TextStyle(color: Colors.white),
                        onChanged: (v) {
                          setState(() {
                            filterCars = _buildSearchList(v);
                          });

                          print(filterCars);
                        },
                        decoration: const InputDecoration(
                          fillColor: Color(0xFF292B37),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white70,
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      filterCars.isEmpty && search.text.isNotEmpty
                          ? Center(
                              child: Text(
                              "Not Found",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ))
                          : filterCars.length > 0
                              ? Column(
                                  children: filterCars.map((e) {
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, "carPage", arguments: e);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          children: [ ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              e.imageUrl??defaultImage,
                                              height: 70,
                                              width: 90,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              e.name,
                                              style: const TextStyle(fontSize: 22, color: Colors.white),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: 25,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                              : Column(
                                  children: cars.map((e) {
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, "carPage", arguments: e);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          children: [ ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              e.imageUrl??defaultImage,
                                              height: 70,
                                              width: 90,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              e.name,
                                              style: const TextStyle(fontSize: 22, color: Colors.white),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: 25,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
