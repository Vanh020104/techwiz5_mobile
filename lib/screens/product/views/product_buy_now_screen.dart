import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/components/cart_button.dart';
import 'package:shop/components/custom_modal_bottom_sheet.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/screens/product/views/added_to_cart_message_screen.dart';
import 'package:shop/screens/product/views/components/product_list_tile.dart';
import 'package:shop/screens/product/views/components/product_quantity.dart';
import 'package:shop/screens/product/views/components/unit_price.dart';
import 'package:shop/screens/product/views/location_permission_store_availability_screen.dart';
import 'package:shop/screens/product/views/size_guide_screen.dart';
import 'package:shop/services/CartService.dart';

class ProductBuyNowScreen extends StatefulWidget {
  final Product product;

  ProductBuyNowScreen({required this.product});

  @override
  _ProductBuyNowScreenState createState() => _ProductBuyNowScreenState();
}

class _ProductBuyNowScreenState extends State<ProductBuyNowScreen> {
  int quantity = 2;
  late Future<CartService> cartServiceFuture;
  late Future<int?> userIdFuture;

  @override
  void initState() {
    super.initState();
    cartServiceFuture = _initializeCartService();
    userIdFuture = getUserId();
  }

  Future<CartService> _initializeCartService() async {
    final cartService = CartService();
    await cartService.getToken(); // Ensure token is loaded
    return cartService;
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = quantity * widget.product.price;

    return Scaffold(
      bottomNavigationBar: FutureBuilder<CartService>(
        future: cartServiceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final cartService = snapshot.data!;
            return FutureBuilder<int?>(
              future: userIdFuture,
              builder: (context, userIdSnapshot) {
                if (userIdSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (userIdSnapshot.hasError) {
                  return Center(child: Text('Error: ${userIdSnapshot.error}'));
                } else {
                  final userId = userIdSnapshot.data;
                  if (userId == null) {
                    return Center(child: Text('User ID is null'));
                  }
                  return CartButton(
                    price: totalPrice,
                    product: widget.product,
                    title: "Add to cart",
                    subTitle: "Total price",
                    press: () async {
                      final cartItem = CartItem(
                        userId: userId.toString(), // Sử dụng userId thực tế
                        productId: widget.product.productId.toString(),
                        quantity: quantity,
                      );

                      try {
                        await cartService.addToCart(cartItem);
                        customModalBottomSheet(
                          context,
                          isDismissible: false,
                          child: const AddedToCartMessageScreen(),
                        );
                      } catch (e) {
                        // Xử lý lỗi nếu cần
                        print('Failed to add to cart: $e');
                      }
                    },
                  );
                }
              },
            );
          }
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            expandedHeight: 350.0, // Tăng chiều cao để có thêm khoảng cách
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.product.name), // Sử dụng tên từ product
              background: Padding(
                padding: const EdgeInsets.all(8.0), // Thêm padding
                child: Image.network(
                  'http://10.0.2.2:8082/api/v1/product-images/imagesPost/' + widget.product.images[0].imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, size: 110);
                  },
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(defaultPadding),
            sliver: SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: UnitPrice(
                      price: widget.product.price, // Sử dụng giá từ product
                      priceAfterDiscount: widget.product.price, // Sử dụng giá sau giảm giá từ product
                    ),
                  ),
                  ProductQuantity(
                    numOfItem: quantity,
                    onIncrement: _incrementQuantity,
                    onDecrement: _decrementQuantity,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Divider()),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            sliver: ProductListTile(
              title: "Size guide",
              svgSrc: "assets/icons/Sizeguid.svg",
              isShowBottomBorder: true,
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: const SizeGuideScreen(),
                );
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: defaultPadding / 2),
                  Text(
                    "Store pickup availability",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                      "Select a size to check store availability and In-Store pickup options.")
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            sliver: ProductListTile(
              title: "Check stores",
              svgSrc: "assets/icons/Stores.svg",
              isShowBottomBorder: true,
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: const LocationPermissonStoreAvailabilityScreen(),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding))
        ],
      ),
    );
  }
}