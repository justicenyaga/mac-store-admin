import 'package:flutter/material.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String id = "subCategoryScreen";
  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Subcategory screen"),
    );
  }
}
