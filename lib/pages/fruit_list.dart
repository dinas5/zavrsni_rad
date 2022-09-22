import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FruitList extends StatefulWidget {
  const FruitList({Key? key}) : super(key: key);
  @override
  State<FruitList> createState() => _FruitListState();
}

class _FruitListState extends State<FruitList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("fruits").snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("An error occurred."),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot fruit = snapshot.data.docs[index];
                  return ListTile(
                    leading: Image.network(fruit['Image']),
                    title: Text(fruit['Name']),
                    subtitle: Text(fruit['Nutrients']),
                  );
                });
          }),
    );
  }
}
