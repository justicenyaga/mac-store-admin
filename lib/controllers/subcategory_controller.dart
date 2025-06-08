import 'dart:convert';

import 'package:app_web/global_variables.dart';
import 'package:app_web/models/subcategory.dart';
import 'package:app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class SubcategoryController {
  uploadSubcategory({
    required String categoryId,
    required String categoryName,
    required String subCategoryName,
    required dynamic pickedImage,
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

      final subCategory = Subcategory(
        id: "",
        categoryId: categoryId,
        categoryName: categoryName,
        subCategoryName: subCategoryName,
        image: image,
      );

      final response = await http.post(
        Uri.parse("$uri/api/subcategories"),
        body: subCategory.toJson(),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Subcategory Uploaded");
          });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<Subcategory>> loadSubcategories() async {
    try {
      final response =
          await http.get(Uri.parse("$uri/api/subcategories"), headers: {
        "Content-Type": "application/json; charset=UTF-8",
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data
            .map((subcategory) => Subcategory.fromJson(subcategory))
            .toList();
      }

      throw Exception("Failed to load subcategories");
    } catch (e) {
      throw Exception("Error loading subcategories $e");
    }
  }
}
