import 'package:app_web/controllers/category_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = "\category-screen";
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CategoryController _categoryController = CategoryController();
  late String categoryName;

  dynamic _image;
  dynamic _bannerImage;

  void pickImage() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  void pickBannerImage() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _bannerImage = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(4),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: _image != null
                      ? Image.memory(_image)
                      : const Text("Category image"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  child: TextFormField(
                    onChanged: (value) {
                      categoryName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter category name";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Enter Category Name",
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _categoryController.uploadCategory(
                      pickedImage: _image,
                      pickedBanner: _bannerImage,
                    );
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: pickImage,
              child: const Text("Pick image"),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: _bannerImage != null
                  ? Image.memory(_bannerImage)
                  : const Text(
                      "Category Banner",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: pickBannerImage,
              child: const Text("Pick Image"),
            ),
          ),
          const Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
