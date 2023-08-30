import 'package:flutter/material.dart';
import 'package:tugas3/controller/category_controller.dart';
import 'package:tugas3/models/category_model.dart';
import 'package:tugas3/models/response_model.dart';
import 'package:tugas3/utils/constants.dart';

import '../utils/mydialog.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({Key? key}) : super(key: key);

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  bool loading = false;

  String? url;
  String? name;
  String? status;

  deleteCategory(String id) async {
    setState(() {
      loading = true;
    });
    ResponseModel responseModel = await CategoryController().deleteCategory(id);

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
      MyDialog().myAlertDialog(context, content: responseModel.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CategoryModel;

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        deleteCategory(args.id);
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        var data = await Navigator.pushNamed(
                            context, "editCategoryPage",
                            arguments: CategoryModel(
                                id: args.id,
                                image: args.image,
                                status: status ?? args.status,
                                imageUrl: url ?? args.imageUrl,
                                name: name ?? args.name)) as CategoryModel?;

                        if (data != null) {
                          setState(() {
                            url = data.imageUrl;
                            name = data.name;
                            status = data.status;
                          });
                        }
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Image.network(
              url ?? args.imageUrl ?? defaultImage,
              height: 200,
              fit: BoxFit.cover,
            )),
            SizedBox(
              height: 20,
            ),
            Text(
              name ?? args.name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              status ?? args.status,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
