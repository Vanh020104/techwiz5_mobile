import 'package:flutter/material.dart';
import 'package:shop/components/buy_full_ui_kit.dart';
import 'package:shop/models/OrderStatus.dart';
import 'package:shop/route/route_constants.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersScreen> {
  List<OrderStatus> orderStatuses = [
    OrderStatus(status: 'Awaiting Payment', icon: Icons.account_balance_wallet),
    OrderStatus(status: 'Processing', icon: Icons.hourglass_empty),
    OrderStatus(status: 'Delivered', icon: Icons.local_shipping),
    OrderStatus(status: 'Completed', icon: Icons.check_circle),
    OrderStatus(status: 'Canceled', icon: Icons.cancel),
  ];

  void navigateToOrderStatusPage(BuildContext context, OrderStatus status) {
    switch (status.status) {
      case 'Awaiting Payment':
        Navigator.pushNamed(context, orderInfoScreenRoute);
        break;
      case 'Processing':
        // Navigator.pushNamed(context, '/processingOrders');
        break;
      case 'Delivered':
        // Navigator.pushNamed(context, '/deliveredOrders');
        break;
      case 'Completed':
        // Navigator.pushNamed(context, '/completedOrders');
        break;
      case 'Canceled':
        // Navigator.pushNamed(context, '/canceledOrders');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 25, right: 25, bottom: 8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Find an order...',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Orders history', style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: orderStatuses.length,
              separatorBuilder: (context, index) => Divider(color: Colors.grey[300], thickness: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(orderStatuses[index].icon, color: Theme.of(context).primaryColor),
                  title: Text(orderStatuses[index].status),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(width: 8),
                      Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                  onTap: () {
                    navigateToOrderStatusPage(context, orderStatuses[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}