import 'package:flutter/material.dart';
import 'package:gardabookingadmin/controllers/product_controller.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';
import 'new_product_screen.dart';
import 'screens.dart';


class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produkter'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 100,
            child: Card(
              margin: EdgeInsets.zero,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {
                    Get.to(() => NewProductScreen());
                  },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Tilføj et nyt produkt',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 210,
                      child: ProductCard(
                        product: productController.products[index],
                        index: index,
                        ),
                      );
                  },
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  ProductCard({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name,
              style: const TextStyle(
                  fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(product.city,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(height: 80, width: 80,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    children: [
                    Row(
                      children: [
                        const Text(
                          'Pris',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Slider(value: product.price,
                            min: 0,
                            max: 20000,
                            divisions: 80,
                            activeColor: Colors.black,
                            inactiveColor: Colors.black12,
                            onChanged: (value) {
                          productController.updateProductPrice(
                              index,
                              product,
                              value,
                          );
                            },
                          onChangeEnd: (value) {
                          productController.saveNewProductPrice(
                              product, 'price', value);
                          }
                        ),
                         Text(
                          '\Kr${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

