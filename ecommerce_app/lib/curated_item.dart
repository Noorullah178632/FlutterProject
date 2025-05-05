import 'package:ecommerce_app/colors.dart';
import 'package:ecommerce_app/model.dart';
import 'package:flutter/material.dart';

class CuratedItem extends StatelessWidget {
  final AppModel eCommerceItem;
  final Size size;
  const CuratedItem({
    super.key,
    required this.eCommerceItem,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Hero(
          tag: eCommerceItem.image,
          child: Container(
            height: size.height * 0.25,
            width: size.width * 0.5,
            decoration: BoxDecoration(
              color: fbackGroundColor2,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(eCommerceItem.image),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.black12,
                  child: Icon(Icons.favorite_border, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 7),
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
            Text(eCommerceItem.rating.toString()),
            Text(
              '(${eCommerceItem.review})',
              style: TextStyle(color: Colors.black26),
            ),
          ],
        ),
        SizedBox(
          width: size.width * 0.5,
          child: Text(
            eCommerceItem.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              '\$${eCommerceItem.price.toString()}.00',
              style: TextStyle(
                color: Colors.pink,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            SizedBox(width: 5),
            if (eCommerceItem.isCheck == true)
              Text(
                '\$${eCommerceItem.price + 255}.00',
                style: TextStyle(
                  color: Colors.black26,

                  decoration: TextDecoration.lineThrough,

                  height: 1.5,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
