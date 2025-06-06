import 'package:easy_shop/core/constants/app_constants.dart';
import 'package:easy_shop/core/services/api_services.dart';
import 'package:easy_shop/features/Profile/profile_screen.dart';
import 'package:easy_shop/features/cart/presentation/screens/cart_screen.dart';
import 'package:easy_shop/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  int isSelected = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        iconSize: 30.0,
        selectedItemColor: AppConstants.buttonColor,
        unselectedItemColor: AppConstants.textColor,
        backgroundColor: AppConstants.backgroundColor,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            label: "Cart",
            icon: Icon(Icons.shopping_cart),
          ),
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person_2)),
        ],
      ),
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child:
            currentIndex == 0
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Search Bar Container
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        width: size.width * 0.88, // 88% of screen width
                        margin: const EdgeInsets.only(top: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: AppConstants.buttonColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: AppConstants.buttonColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: AppConstants.buttonColor,
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),

                    //CATAGORY
                    Center(
                      child: SizedBox(
                        width: size.width * 0.88,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildCatagory(text: "Catagory", onPressed: () {}),
                            SizedBox(width: size.width * 0.43),
                            buildCatagory(text: "Price", onPressed: () {}),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),

                    // PRODUCT GRID LIST VIEW
                    Expanded(
                      child: FutureBuilder(
                        future: ApiServices.fetchProduct(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error ${snapshot.error}'),
                            );
                          }

                          final products = snapshot.data!;

                          return GridView.builder(
                            padding: EdgeInsets.all(10.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 0.68,
                                ),

                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppConstants.backgroundColor,
                                      ),
                                      height: 200,
                                      width: double.infinity,
                                      child: Center(
                                        child: Image.network(
                                          product.image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),

                                    //Description Section
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 3.0,
                                      ),
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        '${product.title}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),

                                    //Rating Section
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 20,
                                            color: Colors.amber,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text('${product.rating}'),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(height: 5.0),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                )
                : screens[currentIndex],
      ),
    );
  }
}

class buildCatagory extends StatelessWidget {
  const buildCatagory({
    super.key,
    // required this.index,
    required this.onPressed,
    required this.text,
  });

  final String text;
  // final Index index;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstants.buttonColor,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: AppConstants.backgroundColor),
      ),
    );
  }
}
