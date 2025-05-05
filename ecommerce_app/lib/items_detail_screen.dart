import 'package:ecommerce_app/colors.dart';
import 'package:ecommerce_app/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';

class ItemsDetailScreen extends StatefulWidget {
  final AppModel eCommerceApp;
  const ItemsDetailScreen({super.key, required this.eCommerceApp});

  @override
  State<ItemsDetailScreen> createState() => _ItemsDetailScreenState();
}

class _ItemsDetailScreenState extends State<ItemsDetailScreen> {
  int currentIndex = 0;
  int selectedColorindex = 1;
  int selectedSizeindex = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: fbackGroundColor1,
        title: Text('Product Detail'),
        actions: [
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
          SizedBox(width: 13),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: size.height * 0.46,
            width: size.width,

            child: PageView.builder(
              itemCount: 3,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Hero(
                      tag: widget.eCommerceApp.image,
                      child: Image.asset(
                        widget.eCommerceApp.image,
                        height: size.height * 0.4,
                        width: size.width * 0.85,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 4),
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                index == currentIndex
                                    ? Colors.blue
                                    : Colors.grey.shade100,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'H&M',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.star, color: Colors.amber, size: 17),
                    Text(widget.eCommerceApp.rating.toString()),
                    Text(
                      '(${widget.eCommerceApp.review})',
                      style: TextStyle(color: Colors.black26),
                    ),
                    const Spacer(),
                    Icon(Icons.favorite_border),
                  ],
                ),
                Text(
                  widget.eCommerceApp.name,
                  maxLines: 1,

                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '\$${widget.eCommerceApp.price.toString()}.00',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(width: 5),
                    if (widget.eCommerceApp.isCheck == true)
                      Text(
                        '\$${widget.eCommerceApp.price + 255}.00',
                        style: TextStyle(
                          color: Colors.black26,

                          decoration: TextDecoration.lineThrough,

                          height: 1.5,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  "$myDescription1 ${widget.eCommerceApp.name} $myDescription2",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -.5,
                    color: Colors.black38,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width / 2.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Color',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  widget.eCommerceApp.fcolor
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                        final int index = entry.key;
                                        final color = entry.value;
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            top: 10,
                                            right: 10,
                                          ),
                                          child: CircleAvatar(
                                            backgroundColor: color,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  selectedColorindex = index;
                                                });
                                              },
                                              child: Icon(
                                                Icons.check,
                                                color:
                                                    selectedColorindex == index
                                                        ? Colors.white
                                                        : Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                      .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width / 2.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Size',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  widget.eCommerceApp.size.asMap().entries.map((
                                    entry,
                                  ) {
                                    final int index = entry.key;
                                    final String size = entry.value;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedSizeindex = index;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          right: 10,
                                          top: 10,
                                        ),
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              selectedSizeindex == index
                                                  ? Colors.black
                                                  : Colors.white,
                                          border: Border.all(
                                            color:
                                                selectedSizeindex == index
                                                    ? Colors.black
                                                    : Colors.black12,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            size,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  selectedSizeindex == index
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        elevation: 0,
        backgroundColor: Colors.white,
        label: SizedBox(
          width: size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.shopping_bag, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "ADD TO CART",
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      "BUY NOW",
                      style: TextStyle(color: Colors.white, letterSpacing: -1),
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
