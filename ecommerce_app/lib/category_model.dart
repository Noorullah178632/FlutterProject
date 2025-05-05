class Category {
  final String name, image;
  Category({required this.name, required this.image});
}

List<Category> category = [
  Category(name: "Women", image: "assets/images/women1.jpg"),
  Category(name: "Men", image: "assets/images/Men1.jpg"),
  Category(name: "Teens", image: "assets/images/boy1.jpg"),
  Category(name: "Child", image: "assets/images/kid1.jpg"),
  Category(name: "Baby", image: "assets/images/baby1.jpg"),
];
List<String> filterCategory = [
  "Filter",
  "Rating",
  "Size",
  "Color",
  "Price",
  "Brand",
];
