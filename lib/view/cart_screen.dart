import 'package:flutter/material.dart';
import 'package:zupaytask/controller/cart_controller.dart';
import 'package:zupaytask/main.dart';
import 'package:zupaytask/view/widgets/cart_items.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const MyHomePage())));
            }),
        title: const Text("Your Cart", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.itemCount > 0
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (ctx, i) => CartElements(
                      // items in cart.dart returns a copy of a map hence we have to use .values.toList()
                      cart.items.values.toList()[i].id,
                      cart.items.keys.toList()[i],
                      cart.items.values.toList()[i].price,
                      cart.items.values.toList()[i].quantity,
                      cart.items.values.toList()[i].title,
                      cart.items.values.toList()[i].img,
                    ),
                    itemCount: cart.itemCount,
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Text(
                          "Your cart is empty, add products to place an order",
                          softWrap: false,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15)),
                    ),
                  ),
          ),
          const SizedBox(
            height: 10,
          ),
          cart.itemCount > 0
              ? Card(
                  elevation: 0,
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Price',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(), // interesting widget if using mainaxis alignment
                        Text('\$ ${cart.totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          cart.itemCount > 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          cart.clear();
                          showDialog(
                              //show dialogue itself returns a future
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: const Text(
                                      'Order Placed!',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: "Lato",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                        'Please look at your mail for confirmation'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop(true);
                                          },
                                          child: const Text('Ok')),
                                    ],
                                  ));
                        },
                        child: const Text("Order Now")),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
