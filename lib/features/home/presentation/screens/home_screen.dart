import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/router/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PopCal")),
      drawer: DrawerScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(Routes.rotation);
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to Home Screen"),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
