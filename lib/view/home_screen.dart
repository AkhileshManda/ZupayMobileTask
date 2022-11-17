import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zupaytask/view/widgets/products_grid.dart';

import '../model/products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //late Future<List<Product>> _future;
  late Box box;
  List _data = [];
  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('data');
    return;
  }

  Future<bool> getAlldata() async {
    String url = "https://fakestoreapi.com/products";
    try {
      List<Product> products = [];
      var response = await Dio().get(url);
      //print(response);
      for (var x in response.data) {
        //print(x);
        products.add(Product.fromJson(x));
      }
      //print("got products!!");
      await putData(products);
      //print("put data");
      // ignore: non_constant_identifier_names
    } catch (SocketException) {
      //print(SocketException);
    }

    var mymap = box.toMap().values.toList();
    if (mymap.isEmpty) {
      _data.add("empty");
    } else {
      _data = mymap;
    }
    return Future.value(true);
  }

  Future putData(data) async {
    await box.clear();
    for (var d in data) {
      box.add(d);
    }
  }

  @override
  void initState() {
    super.initState();
    openBox();
    // final productsController = ProductsController();
    // _future = productsController.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const ImageIcon(
                AssetImage("assets/menu_icon.png"),
                color: Colors.black,
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 15),
          child: Text("New Arrivals",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
        ),
        Expanded(
          child: FutureBuilder<bool>(
              future: getAlldata(),
              builder: ((context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  if (_data.contains("empty")) {
                    return const Text("Internet not connected");
                  } else {
                    return ProductsList(
                      products: _data,
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
        ),
      ],
    );
  }
}
