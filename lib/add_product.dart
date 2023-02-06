import 'package:addprouctfirebase/data.dart';
import 'package:addprouctfirebase/nextpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProductView extends StatefulWidget {
  AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  TextEditingController productName = TextEditingController();

  TextEditingController productPrice = TextEditingController();

  TextEditingController productdescription = TextEditingController();

  List number = [
    {"amount": 12, "isfavorite": false}
  ];

  addProduct() async {
    CollectionReference products =
        FirebaseFirestore.instance.collection("products");
    await products
        .add({
          "name": productName.text,
          "price": productPrice.text,
          "description": productdescription.text,
        })
        .then((value) => print("Product Addes"))
        .catchError((e) => print(e));
  }

  AddNumber() async {
    CollectionReference numbe = FirebaseFirestore.instance.collection("numbe");
    await numbe
        .add({
          "amount": number,
          "isfavorite": number,
        })
        .then((value) => print("isfavorite Addes"))
        .catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: number.length,
        itemBuilder: (context, index) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: productName,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: productPrice,
                ),
                TextField(
                  controller: productdescription,
                ),
                ElevatedButton(
                  onPressed: () {
                    addProduct();
                  },
                  child: const Text("Add Product"),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 350,
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 100,
                            alignment: Alignment.center,
                            child: Text("${number[index]["amount"]}"),
                          ),
                          Container(
                            height: 50,
                            width: 100,
                            child: IconButton(
                                onPressed: () {
                                  AddNumber();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const NextPage(),
                                    ),
                                  );
                                  if (number[index]["isfavorite"] == true) {
                                    setState(() {
                                      number[index]['isfavorite'] = false;
                                      
                                    });
                                  } else {
                                    setState(() {
                                      favoriteItem.add(number[index]);
                                      number[index]["isfavorite"] = true;
                                    });
                                  }
                                },
                                icon: Icon(Icons.favorite,
                                    color: number[index]["isfavorite"]
                                        ? Colors.red
                                        : Colors.grey)),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
