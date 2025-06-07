import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

void manageHttpResponse({
  required http.Response response, // the HTTP response from the request
  required BuildContext context, // the context to show snackbar
  required VoidCallback onSuccess, // success response callback
}) {
  switch (response.statusCode) {
    case 200: // successfull request
      onSuccess();
      break;
    case 201: // successfully created a resource
      onSuccess();
      break;
    case 400: // bad request
      showSnackBar(context, json.decode(response.body)["msg"]);
      break;
    case 403: // bad request
      showSnackBar(context, json.decode(response.body)["msg"]);
      break;
    case 500: // server error
      showSnackBar(context, json.decode(response.body)["error"]);
      break;
  }
}

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}
