import 'package:dog_data/controller/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Center(
          child: FutureBuilder<List<Map<String, dynamic>>>(
        future: Provider.of<ApiProvider>(context).getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Text('No items in the cart.');
          } else {
            List<Map<String, dynamic>> carts =
                snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: carts.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> cart = carts[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(cart['image']),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                        ),
                      ),
                      Positioned(
                        top: 170,
                        left: 10,
                        child: Text(
                          '₹${cart['price']}',
                          style: const TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      )),
    );
  }
}
