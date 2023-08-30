import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas3/controller/category_controller.dart';
import 'package:tugas3/models/category_model.dart';
import 'package:tugas3/models/response_model.dart';
import 'package:tugas3/utils/constants.dart';

import '../utils/mydialog.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  bool loading = false;

  TextEditingController name = TextEditingController();
  String? status;
  String imgSrc = defaultImage;
  File? imgFile;

  void addCategory() async {
    setState(() {
      loading = true;
    });

    ResponseModel responseModel = await CategoryController().addCategory(
        CategoryModel(id:"",name: name.text,status: status??"UpComing", image: ""), imgFile);
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
        Navigator.of(context).pop();
      });
    } else {
      MyDialog().myAlertDialog(context,
          content: responseModel.message);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: imgFile == null
                    ? Image.network(
                        imgSrc,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        imgFile!,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
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
                child: DropdownSearch<String>(
                  items: const ["UpComing", "Present"],
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
                      labelText: 'Status',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Select Status Category',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  onChanged: (v){
                    setState(() {
                      status = v;
                    });
                  },
                  selectedItem: status,
                ),
              ),
              loading
                  ? const CircularProgressIndicator()
                  : Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: ElevatedButton(
                        onPressed: () {
                          addCategory();
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
