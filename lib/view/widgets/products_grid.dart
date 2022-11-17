import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupaytask/controller/cart_controller.dart';
import 'package:zupaytask/model/products.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.products});

  final List products;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context);
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.75),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Image.network(products[index].image,
                        fit: BoxFit.fitWidth)),
                Text(products[index].title,
                    overflow: TextOverflow.ellipsis, textAlign: TextAlign.left),
                Text(products[index].description,
                    overflow: TextOverflow.ellipsis),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$ ${products[index].price}'),
                    IconButton(
                        onPressed: () {
                          cart.addItem(
                              productId: products[index].id,
                              price: double.parse(products[index].price),
                              title: products[index].title,
                              image: products[index].image,
                            );
                          print("Added product");
                          //print(products[index].id);
                          // Scaffold.of(context)
                          //     .hideCurrentSnackBar(); //will hide if there already exist some snackbar
                          // Scaffold.of(context).showSnackBar(SnackBar(
                          //   content: Text(
                          //     "Added items to cart",
                          //   ),
                          //   duration: Duration(seconds: 2),
                          //   action: SnackBarAction(
                          //     label: 'Undo',
                          //     onPressed: () {
                          //       cart.removeSingleItem(product.id);
                          //     },
                          //   ),
                          // ));
                        },
                        icon: Icon(Icons.shopping_bag_outlined))
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
