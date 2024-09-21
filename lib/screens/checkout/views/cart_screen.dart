
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/screens/checkout/views/payment.dart';
import 'package:shop/services/cart_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
     Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<int?>(
          future: getUserId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('You need to log in to view the cart!',
              style: TextStyle(fontSize: 18, color: Colors.red),));
            }

            final userId = snapshot.data!;
            return FutureBuilder<List<Map<String, dynamic>>>(
              future: CartService().getCartData(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No items in the cart'));
                }

                final cartItems = snapshot.data!;
                final subtotal = cartItems.fold<double>(
                  0.0,
                  (sum, item) => sum + (item['productPrice'] as double) * (item['quantity'] as int),
                );
                const vat = 1.0;
                final total = subtotal + vat;

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Hiển thị các mục trong giỏ hàng
                  ...cartItems.map((item) {
                    final productName = item['productName'];
                    final productPrice = item['productPrice'];
                    final quantity = item['quantity'];
                    final productImages = item['productImages'] as List<dynamic>;
                    final imageUrl = productImages.isNotEmpty
                        ? 'http://10.0.2.2:8082/api/v1/product-images/imagesPost/${productImages[0]}'
                        : '';

                    return Column(
                      children: [
                        ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(imageUrl, fit: BoxFit.cover),
                            ),
                          ),
                          title: Text(productName),
                          subtitle: Text('\$${productPrice.toStringAsFixed(2)}', style: const TextStyle(color: Colors.red),),
                          trailing: Text('x$quantity', style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 114, 114, 114))),
                        ),
                        const Divider(
                          color: Color.fromARGB(255, 216, 216, 216),
                          thickness: 0.5,
                          indent: 30,
                          endIndent: 30,
                        ),
                      ],
                    );
                  }),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Coupon Code:',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 213, 212, 212),
                              ),
                            ),
                            hintText: 'Enter coupon code',
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 164, 163, 163),
                            ),
                            prefixIcon: Icon(Icons.card_giftcard, color: Colors.grey.shade600),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Card(
                    margin: const EdgeInsets.all(18),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16), // Add space between the title and the details
                          const Text(
                            'Order Summary',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Subtotal:',
                                  style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 163, 161, 161)),
                                ),
                                Text(
                                  '\$${subtotal.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 17, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shipping Fee:',
                                style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 163, 161, 161)),
                              ),
                              Text(
                                'Free',
                                style: TextStyle(fontSize: 17, color: Colors.green),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 216, 216, 216),
                            thickness: 0.5,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total (Include of VAT):',
                                  style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 163, 161, 161)),
                                ),
                                Text(
                                  '\$${total.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 17, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Text(
                          //       'Estimated VAT:',
                          //       style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 163, 161, 161)),
                          //     ),
                          //     Text(
                          //       '\$${vat.toStringAsFixed(2)}',
                          //       style: TextStyle(fontSize: 17, color: Colors.black),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18), // Padding on both sides
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Background color
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(color: Colors.white), // Text color
                        ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}