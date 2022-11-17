import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zupaytask/controller/cart_controller.dart';

class CartElements extends StatefulWidget {
  final String id;
  final String productId;
  final double price;
  int quantity;
  final String title;
  final String image;
  CartElements(this.id, this.productId, this.price, this.quantity, this.title,
      this.image, {super.key});

  @override
  State<CartElements> createState() => _CartElementsState();
}

class _CartElementsState extends State<CartElements> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context);
    return Dismissible(
      key: ValueKey(widget.id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            //show dialogue itself returns a future
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text(
                    'Are You Sure?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold),
                  ),
                  content:
                      Text('Do you want to remove the item from the cart?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text('No')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text('Yes')),
                  ],
                ));
      },
      onDismissed: (direction) {
        cart.removeItem(widget.productId);
      },
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right : 8.0),
                  child: SizedBox(height: 90, width: 90, child: Image.network(widget.image)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        softWrap: false,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis, // new
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text("Size: S"),
                          const SizedBox(
                            width: 4,
                          ),
                          Row(
                            children: [
                              const Text("Color: "),
                              Container(
                                height: 10,
                                width: 10,
                                color: Colors.black,
                              )
                            ],
                          ),
                          SizedBox(width: 5),
                          Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    widget.quantity--;
                                    cart.removeSingleItem(widget.productId);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Center(child: Icon(Icons.remove,size: 10,)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                child: Text(widget.quantity.toString()),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    widget.quantity++;
                                    cart.addItem(productId: widget.productId, price: widget.price, title: widget.title, image: widget.image);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: const Center(child: Icon(Icons.add,size: 10,)),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('\$ ${widget.price.toString()}'),
                ),
              ],
            ),
          )),
    );
  }
}
