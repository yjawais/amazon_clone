import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/order_details/screens/order_details_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
// //temp list
//   List list = [

//       'https://images.unsplash.com/photo-1649859398021-afbfe80e83b9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=400&q=60',
//       'https://images.unsplash.com/photo-1649859398021-afbfe80e83b9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=400&q=60',
//       'https://images.unsplash.com/photo-1649859398021-afbfe80e83b9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=400&q=60',
//       'https://images.unsplash.com/photo-1649859398021-afbfe80e83b9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=400&q=60',

//   ];

  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              //display all order
              orders!.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: Text('No orders made!'),
                      ),
                    )
                  : Container(
                      height: 185,
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 20,
                        right: 0,
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemExtent: 200,
                        itemCount: orders!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                OrderDetailScreen.routeName,
                                arguments: orders![index],
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 135,
                                    child: SingleProduct(
                                      image:
                                          orders![index].products[0].images[0],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          orders![index].products[0].name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Rs. ${orders![index].products[0].price}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          );
  }
}
