import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllProductsView extends StatelessWidget {
  AllProductsView({super.key});
  CollectionReference products =
      FirebaseFirestore.instance.collection("products");

  getAllProducts() async {
    return products.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
            future: getAllProducts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 350,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snapshot.data.docs[index]['name']),
                                    Text(snapshot.data.docs[index]['price']),
                                    Text(snapshot.data.docs[index]
                                        ['description']),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
