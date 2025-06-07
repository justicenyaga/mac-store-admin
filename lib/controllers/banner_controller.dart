import 'dart:convert';

import 'package:app_web/global_variables.dart';
import 'package:app_web/models/banner.dart';
import 'package:app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class BannerController {
  uploadBanner({
    required dynamic pickedImage,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dr84eglct", "dr84eglct");

      var imageResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: "pickedImage", folder: "banners"));

      String image = imageResponse.secureUrl;

      var bannerModel = BannerModel(id: "", image: image);

      var response = await http.post(
        Uri.parse("$uri/api/banner"),
        body: bannerModel.toJson(),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Banner Uploaded");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // fetch banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      final response = await http.get(
        Uri.parse("$uri/api/banner"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        return data.map((banner) => BannerModel.fromJson(banner)).toList();
      }

      throw Exception("Failed to load banners.");
    } catch (e) {
      throw Exception("Error loading banners $e");
    }
  }
}
