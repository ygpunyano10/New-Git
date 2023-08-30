import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugas3/controller/category_controller.dart';
import 'package:tugas3/pages/categoryDetailPage.dart';
import 'package:tugas3/pages/widgets/CustomNavBar.dart';

import '../models/category_model.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "addCategoryPage");
                        },
                        child: const Icon(
                          Icons.add_box_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Category",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: CategoryController().streamCategories(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Column(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        print(data.toString());
                        print(data.keys.toString());
                        print(data["image"].toString());
                        return Category(
                          categoryModel: CategoryModel(
                              id: document.id,
                              name: data["name"],
                            status: data["status"],
                              image: data["image"],
                              imageUrl: data["imageUrl"],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
          ],
        )),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}

class Category extends StatefulWidget {
  const Category({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // String imageUrl = "";
  bool loading = false;

  @override
  void initState() {
    getUrlImage();
    super.initState();
  }

  getUrlImage() async {
    // setState(() {
    //   loading = true;
    // });
    // imageUrl = await CategoryController()
    //     .downloadUrlImage(imageName: widget.categoryModel.image);
    // setState(() {
    //   loading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "categoryDetailPage",
            arguments: CategoryModel(
                id: widget.categoryModel.id,
                image: widget.categoryModel.image,
                status: widget.categoryModel.status,
                imageUrl: widget.categoryModel.imageUrl,
                name: widget.categoryModel.name));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [ ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.categoryModel.imageUrl!,
                      height: 70,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.categoryModel.name,
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
  }
}
