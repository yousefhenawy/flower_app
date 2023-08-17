class Item {
  String imgPath;
  String name;
  double price;
  Item({required this.imgPath, required this.name, required this.price});
}

final List<Item> items = [
  Item(name: "product1", price: 122.99, imgPath: "assets/img/1.webp"),
  Item(name: "product2", price: 123.99, imgPath: "assets/img/2.webp"),
  Item(name: "product3", price: 121.99, imgPath: "assets/img/3.webp"),
  Item(name: "product4", price: 312.99, imgPath: "assets/img/4.webp"),
  Item(name: "product5", price: 512.99, imgPath: "assets/img/5.webp"),
  Item(name: "product6", price: 232.99, imgPath: "assets/img/6.webp"),
  Item(name: "product7", price: 120.99, imgPath: "assets/img/7.webp"),
  Item(name: "product8", price: 128.99, imgPath: "assets/img/8.webp"),
];
