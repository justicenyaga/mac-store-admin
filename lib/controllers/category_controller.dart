import 'dart:convert';

import 'package:app_web/global_variables.dart';
import 'package:app_web/models/category.dart';
import 'package:app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  uploadCategory({
    required dynamic pickedImage,
    required dynamic pickedBanner,
    required String name,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dr84eglct", "dr84eglct");

      // upload the image
      var imageResponse =
          await cloudinary.uploadFile(CloudinaryFile.fromBytesData(
        pickedImage,
        identifier: "pickedImage",
        folder: "categoryImages",
      ));

      String image = imageResponse.secureUrl;

      var bannerResponse =
          await cloudinary.uploadFile(CloudinaryFile.fromBytesData(
        pickedBanner,
        identifier: "pickedBanner",
        folder: "categoryImages",
      ));

      String banner = bannerResponse.secureUrl;
      Category category = Category(
        id: "",
        name: name,
        image: image,
        banner: banner,
      );

      final response = await http.post(
        Uri.parse("$uri/api/categories"),
        body: category.toJson(),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Uploaded Category");
        },
      );
    } catch (e) {
      print("Error uploading to cloudinary: $e");
    }
  }

  Future<List<Category>> loadCategories() async {
    try {
      final response =
          await http.get(Uri.parse("$uri/api/categories"), headers: {
        "Content-Type": "application/json; charset=UTF-8",
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((category) => Category.fromJson(category)).toList();
      }

      throw Exception("Failed to load categories");
    } catch (e) {
      throw Exception("Error loading categories $e");
    }
  }
}
