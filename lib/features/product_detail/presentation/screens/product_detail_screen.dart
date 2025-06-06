import 'package:easy_shop/core/constants/app_constants.dart';
import 'package:easy_shop/features/home/presentation/screens/home_screen.dart';
import 'package:easy_shop/features/product/data/models/product_model.dart';
import 'package:easy_shop/features/product/data/models/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key, required this.product})
    : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        shadowColor: AppConstants.textColor,
        elevation: 0.5,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            icon: Icon(
              Icons.arrow_back,
              weight: 35.0,
              size: 35,
              color: AppConstants.buttonColor,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              'Product Detail',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 15.0),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppConstants.textColor, width: 0.2),
                  color: AppConstants.backgroundColor,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                width: size.width * 0.93,
                height: size.height * 0.3,
                child: Image.network(product.image),
              ),
            ),
            SizedBox(height: 15.0),
            //Description Details
            Container(
              width: size.width * 0.93,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Product Title Section
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      '${product.title}',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  //Product Description Section
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppConstants.backgroundColor,
                      ),
                      child: Text(
                        '${product.description}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  //Price Tag AND Add to Cart Option
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.buttonColor,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            cart.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.title} added to cart'),
                                duration: Duration(seconds: 2),
                                backgroundColor: AppConstants.buttonColor,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.buttonColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: AppConstants.backgroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
