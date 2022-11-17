import 'package:flutter/material.dart';
import 'package:zupaytask/controller/cart_controller.dart';
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
            onPressed: () {}),
        title: const Text("Your Cart", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx, i) => 
              CartElements(
                // items in cart.dart returns a copy of a map hence we have to use .values.toList()
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].img,
              ),
              itemCount: cart.itemCount,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Price',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(), // interesting widget if using mainaxis alignment
                  Text(
                    '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    cart.clear();
                  },
                  child: const Text("Order Now")),
            ),
          ),
        ],
      ),
    );
  }
}
