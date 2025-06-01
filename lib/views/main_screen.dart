import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Management"),
      ),
      sideBar: const SideBar(
        items: [
          AdminMenuItem(
            title: "Vendors",
            route: "",
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: "Buyers",
            route: "",
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
            title: "Orders",
            route: "",
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: "Categories",
            route: "",
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: "Upload Banner",
            route: "",
            icon: Icons.upload,
          ),
          AdminMenuItem(
            title: "Products",
            route: "",
            icon: Icons.store,
          ),
        ],
        selectedRoute: "",
      ),
      body: const Text("Dashboard"),
    );
  }
}
