import 'package:flutter/material.dart';
import 'package:gardabookingadmin/controllers/product_controller.dart';
import 'package:gardabookingadmin/models/models.dart';
import 'package:gardabookingadmin/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../services/database_service.dart';



class NewProductScreen extends StatelessWidget {
  NewProductScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.find();

  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Lejligheder', 'Sommerhuse', 'Camping'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tilføj produkter'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() =>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: () async {
                        ImagePicker _picker = ImagePicker();
                        final XFile? _image =
                        await _picker.pickImage(
                            source: ImageSource.gallery);

                        if(_image == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Intet billede valgt'),
                              ),
                          );
                        }
                        if(_image != null){
                          await storage.uploadImage(_image);
                          var imageUrl = await storage.getDownloadURL(_image.name);

                          productController.newProduct.update(
                              'imageUrl', (_) => imageUrl,
                              ifAbsent: () => imageUrl);

                        }
                      },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Tilføj et billede',
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
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Produkt Info',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildTextFormField(
                  'Navn / Adresse',
              'name',
                  productController,
              ),
              _buildTextFormField(
                  'By',
              'city',
                productController,
              ),
              //
              DropdownButtonFormField(
                iconSize: 20,
                  decoration: const InputDecoration(hintText: 'Kategorier'),
                  items: categories.map((category) {
                return DropdownMenuItem(
                    value: category,
                    child: Text(category));
              }).toList(),
                  onChanged: (value) {
                  productController.newProduct.update(
                      'category', (_) => value,
                      ifAbsent: () => value);
                  }),
              const SizedBox(
                height: 10,
              ),
              _buildSlider(
                'Price',
                'price',
                productController,
                productController.price,
              ),
              const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _boxBuilder(
                'Lejlighed',
                'isApartment',
                productController,
                productController.isApartment,
              ),
              _boxBuilder(
                  'Sommerhus',
                  'isSummerhouse',
                  productController,
                  productController.isSummerhouse
              ),
              _boxBuilder(
                  'Camping',
                  'isCamping',
                  productController,
                  productController.isCamping
              ),
            ],
          ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _boxBuilder(
                      'Anbefalet',
                      'isRecomended',
                      productController,
                      productController.isRecomended
                  ),
                  _boxBuilder(
                      'Populær',
                      'isPopular',
                      productController,
                      productController.isPopular
                  ),

                ],
              ),

              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      database.addProduct(
                        Product(
                          id: productController.newProduct['id'],
                          name: productController.newProduct['name'],
                            category: productController.newProduct['category'],
                            city: productController.newProduct['city'],
                            imageUrl: productController.newProduct['imageUrl'],
                            isApartment: productController.newProduct['isApartment'] ?? false,
                            isCamping: productController.newProduct['isCamping'] ?? false,
                            isSummerhouse: productController.newProduct['isSummerhouse'] ?? false,
                            isPopular: productController.newProduct['isPopular'] ?? false,
                          isRecommended: productController.newProduct['isRecommended'] ?? false,                          price: productController.newProduct['price'],
                        ),
                      );
                      Navigator.pop(context);
                      },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                    child: const Text(
                      'Gem',
                      style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
      ),
              ),
            ],

          ),
        ),
      ),
    );
  }

  Row _boxBuilder(
      String title,
      String name,
      ProductController productController,
      bool? controllerValue,
      ) {
    return Row(
          children: [
            Text(title),
            Checkbox(value: (controllerValue == null) ? false : controllerValue,
                checkColor: Colors.black,
                activeColor: Colors.black12,
              onChanged: (value) {
                productController.newProduct.update(
                  name,
                      (_) => value,
                  ifAbsent: () => value,
                );
              },
            ),
          ],
        );
  }


  Row _buildSlider(
      String title,
      String name,
      ProductController productController,
      double? controllerValue,
      ) {
    return Row(
            children: [
              const SizedBox(
                width: 75,
                child: Text(
                  'Pris',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Slider(
                  value: (controllerValue == null) ? 0 : controllerValue,
                  min: 0,
                  max: 20000,
                  divisions: 80,
                  activeColor: Colors.black,
                  inactiveColor: Colors.black12,
                  onChanged: (value) {
                    productController.newProduct.update(
                      name,
                          (_) => value,
                      ifAbsent: () => value,
                    );
                  },
                ),
              ),
            ],
          );
  }

  TextFormField _buildTextFormField(
      String hintText,
      String name,
      ProductController productController,
      ) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      onChanged: (value) {
        productController.newProduct.update(
          name,
              (_) => value,
          ifAbsent: () => value,
        );
      },
            );
  }
}
