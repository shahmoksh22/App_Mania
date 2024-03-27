import 'package:aap_mania/CartPage.dart';
import 'package:aap_mania/ProductDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Map<String, dynamic>> categoryarr = [
  {
    "categoryId": 0,
    "categoryTitle": "Mobiles",
    "categoryProducts": [
      {
        "productId": 0,
        "productTitle": "iPhone 15 Pro Max",
        "productImage": "assets/images/Iphone15ProMax.jpg",
        "productDescription": "Apple iPhone 15 Pro (1 TB) - Blue Titanium,Super Retina XDR display, 6.1‑inch (diagonal) all‑screen OLED display,Pro 48MP camera system (Ultra Wide, Main, and Telephoto",
        "productPrice": "199",
        "productDiscount": "19.58%",
        "productRating":5,
        "productBrand":"Apple",
        "productStock":0,
      },
      {
        "productId": 1,
        "productTitle": "iPhone 15 Plus",
        "productImage": "assets/images/Iphone15Plus.jpg",
        "productDescription": "Iphone 15 Super Retina XDR display, 6.1‑inch (diagonal) all‑screen OLED display,Dual 48MP camera system (Ultra Wide and Main),12MP TrueDepth camera",
        "productPrice": "179",
        "productDiscount": "15.56%",
        "productRating":4.5,
        "productBrand":"Apple",
        "productStock":0,
      },
      {
        "productId": 2,
        "productTitle": "iPhone 15",
        "productImage": "assets/images/Iphone15.jpg",
        "productDescription": "Iphone 15 Super Retina XDR display, 6.1‑inch (diagonal) all‑screen OLED display,Dual 48MP camera system (Ultra Wide and Main),12MP TrueDepth camera",
        "productPrice": "149",
        "productDiscount": "10.35%",
        "productRating":4,
        "productBrand":"Apple",
        "productStock":0,
      },
    ],
  },
  {
    "categoryId": 1,
    "categoryTitle": "Laptop",
    "categoryProducts": [
      {
        "productId": 0,
        "productTitle": "ASUS TUF",
        "productImage": "assets/images/AsusTuf.jpg",
        "productDescription": "ASUS TUF Gaming F15, Intel Core i5-11400H 11th Gen, 15.6-inch (39.62 cm) FHD 144Hz, Gaming Laptop (16GB/512GB SSD/4GB NVIDIA GeForce RTX 2050/Win 11/ RGB Backlit KB/Black/2.30 kg), FX506HF-HN025W",
        "productPrice": "240",
        "productRating":4.5,
         "productBrand":"Asus",
        "productStock":0,
      },{
        "productId": 1,
        "productTitle": "HP Victus",
        "productImage": "assets/images/HPVICTUS.jpg",
        "productDescription": "HP Victus Gaming Laptop, 12th Gen Intel Core i5-12450H, 4GB RTX 3050 GPU, 15.6-inch (39.6 cm) FHD IPS 144Hz, 16GB DDR4, 512GB SSD, Backlit KB, B&O Dual Speakers (Win 11, MSO, Blue, 2.37 kg), fa0666TX",
        "productPrice": "340",
        "productRating":4.5,
         "productBrand":"Hp",
        "productStock":0,
      },
    ],
  },
];
class _HomePageState extends State<HomePage> {
  late int _selectedCategoryIndex;
  late String selectedCategory = "All";
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _selectedCategoryIndex = 0; // Initialize selected category index
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Add onPressed callback if needed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<int>(
          value: _selectedCategoryIndex,
          items: categoryarr.map((category) {
            return DropdownMenuItem<int>(
              value: category["categoryId"],
              child: Text(category["categoryTitle"]),
            );
          }).toList(),
          onChanged: (int? newIndex) {
            if (newIndex != null) {
              setState(() {
                _selectedCategoryIndex = newIndex;
              });
            }
          },
                ),
        ),
         //Add
          Expanded(
            child: ListView.builder(
              itemCount: categoryarr.length,
              itemBuilder: (BuildContext context, int index) {
                final category = categoryarr[index];
                final List<Map<String, dynamic>> products =
                category['categoryProducts'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        category["categoryTitle"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index2) {
                          final product = products[index2];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                    product: product,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        child: Image.asset(
                                          product["productImage"],
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if (product["productDiscount"] != null)
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFb71d1c),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(19),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            product["productDiscount"],
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      product["productTitle"],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '\$ ${product["productPrice"]}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: RatingBar.builder(
                                      initialRating:
                                      product["productRating"].toDouble(),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      ignoreGestures: true,
                                      onRatingUpdate: (_) {},
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
