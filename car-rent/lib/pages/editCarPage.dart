import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas3/controller/car_controller.dart';
import 'package:tugas3/controller/category_controller.dart';
import 'package:tugas3/models/car_model.dart';
import 'package:tugas3/models/category_model.dart';
import 'package:tugas3/models/response_model.dart';
import 'package:tugas3/utils/constants.dart';

import '../utils/mydialog.dart';

class EditCarPage extends StatefulWidget {
  const EditCarPage({Key? key}) : super(key: key);

  @override
  State<EditCarPage> createState() => _EditCarPageState();
}

class _EditCarPageState extends State<EditCarPage> {
  bool loading = false;

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  String category = "";
  File? imgFile;

  void editCar(CarModel carModel) async {
    setState(() {
      loading = true;
    });

    ResponseModel responseModel = await CarController().editCar(
        CarModel(
            id: carModel.id,
            name: carModel.name,
            description: carModel.description,
            category: carModel.category,
            price: carModel.price,
            image: carModel.image,
            imageUrl: carModel.imageUrl,
        ),
        imgFile);
    setState(() {
      loading = false;
    });

    if (responseModel.success) {
      MyDialog().myDialogPrimary(context,
          title: "Success", content: responseModel.message, onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop(responseModel.data);
          });
    } else {
      MyDialog().myAlertDialog(context, content: responseModel.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CarModel;
    name = TextEditingController(text: args.name);
    description = TextEditingController(text: args.description);
    price = TextEditingController(text: args.price);
    category = args.category;

    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                children: [
                  Row(
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
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        setState(() {
                          imgFile = File(image.path);
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white)
                      ),
                      child: imgFile == null
                          ? Image.network(
                        args.imageUrl??defaultImage,
                        height: 200,
                        width: 200,
                        fit: BoxFit.contain,
                      )
                          : Image.file(
                        imgFile!,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                    child: DropdownSearch<CategoryModel>(
                      selectedItem: CategoryModel(id: "",
                          status: "",
                          name: args.category,image: ""),
                      asyncItems: (String filter) =>
                          CategoryController().getCategories(),
                      itemAsString: (CategoryModel u) => u.categoryAsName(),
                      onChanged: (CategoryModel? data) {
                        if (data != null) {
                          category = data.name;
                        }
                      },
                      dropdownButtonProps:
                      const DropdownButtonProps(color: Colors.white),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        baseStyle: TextStyle(color: Colors.white),
                        dropdownSearchDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: 'Category',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Select Category Name',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                    child: TextField(
                      controller: name,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter Category Name',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                    child: TextField(
                      controller: price,
                      style: const TextStyle(color: Colors.white),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Price',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter Price',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                    child: TextField(
                      controller: description,
                      minLines: 5,
                      maxLines: 20,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.white),
                        alignLabelWithHint: true,
                        hintText: 'Enter Category Name',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  loading
                      ? const CircularProgressIndicator()
                      : Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: ElevatedButton(
                      onPressed: () {
                        editCar(CarModel(
                            id: args.id,
                            name: name.text,
                            price: price.text,
                            category: category,
                            description: description.text,
                            image: args.image,
                        imageUrl: args.imageUrl));
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
