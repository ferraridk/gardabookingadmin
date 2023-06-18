import 'package:flutter/material.dart';
import 'package:gardabookingadmin/screens/products_screen.dart';
import 'package:get/get.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GardaBookingAdmin'),
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Get.to(() =>  ProductsScreen());
                },
                child: const Card(
                  child: Center(
                      child: Text('Gå til produkt'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
