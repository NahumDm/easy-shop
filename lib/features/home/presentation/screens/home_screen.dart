import 'package:easy_shop/core/constants/app_constants.dart';
import 'package:easy_shop/core/services/api_services.dart';
import 'package:easy_shop/features/Profile/profile_screen.dart';
import 'package:easy_shop/features/cart/presentation/screens/cart_screen.dart';
import 'package:easy_shop/features/product/data/models/product_model.dart';
import 'package:easy_shop/features/product_detail/presentation/screens/product_detail_screen.dart';
import 'package:easy_shop/features/search/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  int isSelected = 0;
  String? selectedCategory;
  String? selectedPriceRange;
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];

  final List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await ApiServices.fetchProduct();
    setState(() {
      allProducts = products;
      filteredProducts = products;
    });
  }

  void _filterProducts() {
    setState(() {
      filteredProducts =
          allProducts.where((product) {
            bool matchesCategory =
                selectedCategory == null ||
                selectedCategory == 'All' ||
                product.category.toLowerCase() ==
                    selectedCategory!.toLowerCase();

            bool matchesPrice =
                selectedPriceRange == null ||
                selectedPriceRange == 'Any' ||
                (selectedPriceRange == '< \$50' && product.price < 50) ||
                (selectedPriceRange == '> \$100' && product.price > 100);

            return matchesCategory && matchesPrice;
          }).toList();
    });
  }

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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SearchScreen()),
                          );
                        },
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
                          width: size.width * 0.88,
                          margin: const EdgeInsets.only(top: 20),
                          child: TextField(
                            enabled: false,
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
                    ),
                    SizedBox(height: 20.0),

                    //CATEGORY
                    Center(
                      child: SizedBox(
                        width: size.width * 0.88,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Category Dropdown
                            Container(
                              width: size.width * 0.4,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppConstants.buttonColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedCategory,
                                  isExpanded: true,
                                  dropdownColor: AppConstants.buttonColor,
                                  hint: Text(
                                    'Category',
                                    style: TextStyle(
                                      color: AppConstants.backgroundColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  items:
                                      ['All', 'Electronics', 'Clothes'].map((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value == 'All' ? null : value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              color:
                                                  AppConstants.backgroundColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCategory = newValue;
                                      _filterProducts();
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.08),
                            // Price Range Dropdown
                            Container(
                              width: size.width * 0.4,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppConstants.buttonColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedPriceRange,
                                  isExpanded: true,
                                  dropdownColor: AppConstants.buttonColor,
                                  hint: Text(
                                    'Price Range',
                                    style: TextStyle(
                                      color: AppConstants.backgroundColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  items:
                                      ['Any', '< \$50', '> \$100'].map((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value == 'Any' ? null : value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              color:
                                                  AppConstants.backgroundColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedPriceRange = newValue;
                                      _filterProducts();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),

                    // PRODUCT GRID LIST VIEW
                    Expanded(
                      child:
                          filteredProducts.isEmpty
                              ? Center(
                                child: Text(
                                  'No products found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppConstants.textColor,
                                  ),
                                ),
                              )
                              : GridView.builder(
                                padding: EdgeInsets.all(10.0),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 15,
                                      childAspectRatio: 0.68,
                                    ),
                                itemCount: filteredProducts.length,
                                itemBuilder: (context, index) {
                                  final product = filteredProducts[index];
                                  return GestureDetector(
                                    onTap:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => ProductDetailScreen(
                                                  product: product,
                                                ),
                                          ),
                                        ),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                      elevation: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  AppConstants.backgroundColor,
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
                                          SizedBox(height: 3.0),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
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
                                            ),
                                            child: Text(
                                              '\$${product.price.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
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
                                        ],
                                      ),
                                    ),
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
