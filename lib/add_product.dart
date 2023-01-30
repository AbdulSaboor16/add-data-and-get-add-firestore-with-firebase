import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProductView extends StatelessWidget {
  AddProductView({super.key});
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productdescription = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: Center(
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
            )
          ],
        ),
      ),
    );
  }
}
