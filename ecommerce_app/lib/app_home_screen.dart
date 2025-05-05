import 'package:ecommerce_app/banner.dart';
import 'package:ecommerce_app/category_items.dart';
import 'package:ecommerce_app/category_model.dart';
import 'package:ecommerce_app/colors.dart';
import 'package:ecommerce_app/curated_item.dart';
import 'package:ecommerce_app/items_detail_screen.dart';
import 'package:ecommerce_app/model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppHomeScreen extends StatefulWidget {
  @override
  _AppHomeScreenState createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/n.png', height: 55),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(Iconsax.shopping_bag, size: 28),

                        //we will make it dynamic during backend part
                        Positioned(
                          right: -3,
                          top: -3,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              const MyBanner(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shop By Catagory',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                  ],
                ),
              ),

              //for catagory
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    category.length,
                    (index) => InkWell(
                      onTap: () {
                        final filterItems =
                            fashionEcommerceApp
                                .where(
                                  (items) =>
                                      items.category.toLowerCase() ==
                                      category[index].name.toLowerCase(),
                                )
                                .toList();
                        //navigation
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CategoryItems(
                                  category: category[index].name,
                                  categoryItems: filterItems,
                                ),
                          ),
                        );
                      },

                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: fbackGroundColor1,

                              backgroundImage: AssetImage(
                                category[index].image,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(category[index].name),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Curated Items',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                  ],
                ),
              ),
              //all created items
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(fashionEcommerceApp.length, (index) {
                    final eCommerceItem = fashionEcommerceApp[index];
                    return Padding(
                      padding:
                          index == 0
                              ? EdgeInsets.symmetric(horizontal: 20)
                              : EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ItemsDetailScreen(
                                    eCommerceApp: eCommerceItem,
                                  ),
                            ),
                          );
                        },
                        child: CuratedItem(
                          eCommerceItem: eCommerceItem,
                          size: size,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//for now this is the simple data 
//late we will fetch that data from fire base