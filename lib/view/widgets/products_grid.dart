import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupaytask/controller/cart_controller.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.products});

  final List products;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context);
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.73),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: CachedNetworkImage(
                    imageUrl: products[index].image.toString(),
                    progressIndicatorBuilder: (context, url, progress) => const SizedBox(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 10,
                    ),
                  ),
                ),
                // SizedBox(
                //     height: MediaQuery.of(context).size.height * 0.15,
                //     child: Image.network(products[index].image,
                //         fit: BoxFit.fitWidth)),
                const SizedBox(
                  height: 5,
                ),
                Text(products[index].title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    // ignore: use_full_hex_values_for_flutter_colors
                    style: const TextStyle(color: Color(0xffb7154b8))),
                const SizedBox(
                  height: 3,
                ),
                Text(products[index].description,
                    overflow: TextOverflow.ellipsis),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${products[index].price}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        cart.addItem(
                          productId: products[index].id,
                          price: double.parse(products[index].price),
                          title: products[index].title,
                          image: products[index].image,
                        );
                        //print("Added product");
                        //print(products[index].id);
                        ScaffoldMessenger.of(context)
                            .hideCurrentSnackBar(); //will hide if there already exist some snackbar
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                            "Added product to cart",
                          ),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              cart.removeSingleItem(products[index].id);
                            },
                          ),
                        ));
                      },
                      icon: const Icon(Icons.shopping_bag_outlined),
                      color: Colors.grey,
                    )
                  ],
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
