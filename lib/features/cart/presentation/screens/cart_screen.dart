import 'package:easy_shop/core/constants/app_constants.dart';
import 'package:easy_shop/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 15.0),
            Center(
              child: ListTile(
                leading: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 400,
                    width: 180,
                    child: Image.network(
                      'https://www.dsport.mk/media/opti_image/webp/catalog/product/cache/d25c7ffaa33cd077a5eb0dc50e0fb1f1/F/B/FB5064-010_1.webp',
                    ),
                  ),
                ),
                title: Text('hello'),
                subtitle: Text('\$50'),
                trailing: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppConstants.backgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
