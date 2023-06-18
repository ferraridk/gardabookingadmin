import 'package:gardabookingadmin/services/database_service.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class ProductController extends GetxController {
  final DatabaseService database = DatabaseService();

  var products = <Product>[].obs;

  @override
  void onInit() {
    products.bindStream(database.getProducts());
    super.onInit();
  }

  var newProduct = {}.obs;

  get price => newProduct['price'];
  get isRecomended => newProduct['isRecomended'];
  get isPopular => newProduct['isPopular'];
  get isApartment => newProduct['isApartment'];
  get isCamping => newProduct['isCamping'];
  get isSummerhouse => newProduct['isSummerhouse'];

  void updateProductPrice(
      int index,
      Product product,
      double value,
      ) {
   product.price = value;
   products[index] = product;
  }

  void saveNewProductPrice(
      Product product,
      String field,
      double value,
      ) {
    database.updateField(product, field, value);
  }
}

