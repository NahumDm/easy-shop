import 'package:easy_shop/core/constants/app_constants.dart';
import 'package:easy_shop/features/product/data/models/cart_provider.dart';
import 'package:easy_shop/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        elevation: 0.5,
        shadowColor: AppConstants.textColor,
        backgroundColor: AppConstants.backgroundColor,
        leading: IconButton(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          onPressed: () {},
          icon: Icon(
            Icons.shopping_cart,
            size: 30,
            color: AppConstants.buttonColor,
          ),
        ),
        title: Text('ShopEase', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_checkout_rounded, size: 28),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
                items.isEmpty
                    ? Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppConstants.textColor,
                        ),
                      ),
                    )
                    : ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final product = items[index];
                        Size size = MediaQuery.of(context).size;
                        return Center(
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 2.0,
                            child: Container(
                              width: size.width * 0.9,
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.2,
                                    height: size.width * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        image: NetworkImage(product.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: AppConstants.textColor,
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed:
                                                  () => cart.decrementQuantity(
                                                    product.id,
                                                  ),
                                              icon: Icon(
                                                Icons.remove_circle_outline,
                                              ),
                                              constraints: BoxConstraints(),
                                              padding: EdgeInsets.zero,
                                              color: AppConstants.buttonColor,
                                            ),
                                            SizedBox(width: 8.0),
                                            Text(
                                              '${cart.getQuantity(product.id)}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 8.0),
                                            IconButton(
                                              onPressed:
                                                  () => cart.incrementQuantity(
                                                    product.id,
                                                  ),
                                              icon: Icon(
                                                Icons.add_circle_outline,
                                              ),
                                              constraints: BoxConstraints(),
                                              padding: EdgeInsets.zero,
                                              color: AppConstants.buttonColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: ElevatedButton(
                                      onPressed:
                                          () => cart.removeFromCart(product.id),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        minimumSize: Size(80, 30),
                                      ),
                                      child: Text(
                                        'Remove',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: AppConstants.backgroundColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: AppConstants.backgroundColor,
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${cart.total.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: items.isEmpty ? null : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: AppConstants.backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
