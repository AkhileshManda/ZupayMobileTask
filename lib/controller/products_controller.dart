import 'package:dio/dio.dart';
import '../model/products.dart';

class ProductsController {
  static const url = "https://fakestoreapi.com/products";

  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    var response = await Dio().get(ProductsController.url);
    for(var x in response.data) {
      //print(x);
      products.add(Product.fromJson(x));
    }
    return products;
  }

  // List<Product> get items {
  //   return [..._items];
  // }

  // Product findById(String id) {
  //   return _items.firstWhere((element) => element.id == id);
  // }

}
