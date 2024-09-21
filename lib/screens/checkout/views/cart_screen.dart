
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Order Review Page',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cart', 
          style: TextStyle(
            fontSize: 20,
             fontWeight: FontWeight.bold
          ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Add border radius
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Clip the image to the border radius
                    child: Image.asset('assets/images/login_dark.png'),
                  ),
                ),
                title: const Text('Sleeveless Tiered Dobby...'),
                subtitle: const Text('\$299.43'),
              ),
              Divider(
                color: const Color.fromARGB(255, 216, 216, 216), 
                thickness: 0.5, 
                indent: 30,
                endIndent: 30,
              ),
              ListTile(
                leading: Container(
            
                  decoration: BoxDecoration(
                    // Add border
                    borderRadius: BorderRadius.circular(10), // Add border radius
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Clip the image to the border radius
                    child: Image.asset('assets/images/signUp_light.png'),
                  ),
                ),
                title: const Text('Printed Sleeveless Tiered...'),
                subtitle: const Text('\$299.43'),
                
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Coupon Code:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: const Color.fromARGB(255, 213, 212, 212)), 
                        ),
                        hintText: 'Enter coupon code',
                        hintStyle: TextStyle(color: const Color.fromARGB(255, 164, 163, 163)), 
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
                      
                      SizedBox(height: 16), // Add space between the title and the details
                      Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8), 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Subtotal:',style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 163, 161, 161)),),
                        Text('\$24',style: TextStyle(fontSize: 17, color: Colors.black),),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Shipping Fee:', style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 163, 161, 161)),),
                      Text('Free', style: TextStyle(fontSize: 17, color: Colors.green),),
                    ],
                  ),
                  Divider(
                              color: const Color.fromARGB(255, 216, 216, 216), 
                              thickness: 0.5, 
                              indent: 10,
                              endIndent: 10,
                            ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8), 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Total(Include of VAT):',style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 163, 161, 161)),),
                        Text('\$24',style: TextStyle(fontSize: 17, color: Colors.black),),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Estimated VAT:', style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 163, 161, 161)),),
                      Text('\$1', style: TextStyle(fontSize: 17,  color: Colors.black),),
                    ],
                  ),
                  
                ],
              )
                    ],
                  ),
                ),
              ),
               Padding(
              padding: EdgeInsets.symmetric(horizontal: 18), // Padding on both sides
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, paymentScreenRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color
                  ),
                  child: Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white), // Text color
                  ),
                ),
              ),
              ),
            ],
            
          ),
          
        ),
        
      ),
      
    );
  }
}
