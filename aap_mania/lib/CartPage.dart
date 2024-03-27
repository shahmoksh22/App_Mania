import 'package:flutter/material.dart';
import 'globals.dart'; // Import the file where productCart is defined

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    int totalQuantity = 0;

    // Calculate total price and total quantity
    for (final product in productCart) {
      final double productPrice = double.parse(product['productPrice']);
      final int quantity = product['quantity'];
      totalPrice += productPrice * quantity;
      totalQuantity += quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: productCart.isEmpty
                ? Center(
              child: Text('Your cart is empty.'),
            )
                : ListView.builder(
              itemCount: productCart.length,
              itemBuilder: (context, index) {
                final product = productCart[index];
                final String productId = product['productId'].toString();
                final String productImage = product['productImage'];
                final String productTitle = product['productTitle'];
                final double productPrice = double.parse(product['productPrice']);
                final int quantity = product['quantity'];
                final double total = productPrice * quantity;

                return SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      // Handle tap if needed
                    },
                    child: ListTile(
                      leading: Image.asset(
                        productImage,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(productTitle),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: \$${productPrice.toStringAsFixed(2)}'),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  updateQuantity(productId, quantity - 1);
                                },
                              ),
                              Text(quantity.toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  updateQuantity(productId, quantity + 1);
                                },
                              ),
                            ],
                          ),
                          Text('Total: \$${total.toStringAsFixed(2)}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          removeItem(productId);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Total Quantity: $totalQuantity',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateQuantity(String productId, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        // Remove the product if the quantity becomes zero or negative
        productCart.removeWhere((product) => product['productId'].toString() == productId);
      } else {
        // Update the quantity otherwise
        final int index = productCart.indexWhere((product) => product['productId'].toString() == productId);
        productCart[index]['quantity'] = newQuantity;
      }
    });
  }

  void removeItem(String productId) {
    setState(() {
      productCart.removeWhere((product) => product['productId'].toString() == productId);
    });
  }
}