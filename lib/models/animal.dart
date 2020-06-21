import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  String id;
  String name;

  Animal({
    this.id,
    this.name,
  });

  factory Animal.fromFireStore(DocumentSnapshot snapshot) {
    Map animalData = snapshot.data;
    return Animal(
      id: snapshot.documentID,
      name: animalData["name"]
    );
  }
}