import 'package:hive/hive.dart';
part "products.g.dart";

@HiveType(typeId: 0)
class Product extends HiveObject{
  @HiveField(1)
  String id;
  @HiveField(2)
  String title;
  @HiveField(3)
  String price;
  @HiveField(4)
  String category;
  @HiveField(5)
  String description;
  @HiveField(6)
  String image;

  
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String,dynamic> parsedJson){
    return Product(
      id: parsedJson["id"].toString(),
      title: parsedJson["title"].toString(),
      price: parsedJson["price"].toString(),
      category: parsedJson["category"].toString(),
      description: parsedJson["description"].toString(),
      image: parsedJson["image"].toString()
    );
  }





}