import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_provider/models/animal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static final Firestore db = Firestore.instance;
  CollectionReference animalsCollection = db.collection('animals');

  List<String> animals = [
    '🐸 Rana',
    '🦁 León',
    '🐶 Perro',
    '🐈 Gato',
    '🦛 Hipopótamo',
    '🐻 Oso',
    '🐼 Panda',
    '🐀 Ratón',
    '🦊 Zorro',
    '🐨 Koala',
    '🐷 Cerdito',
    '🐙 Pulpo',
    '🐬 Delfín'
  ];


  Stream<List<Animal>> animalStream() {
    return animalsCollection
      .orderBy('createdAt')
      .snapshots()
      .map((list) => list
        .documents
        .map((animalSnapshot) => Animal
          .fromFireStore(animalSnapshot))
      .toList());
  }

  Future<void> addAnimal() async {
    var rand = new Random();
    DocumentReference newAnimal = animalsCollection.document();

    await newAnimal.setData({
      "name": animals[rand.nextInt(animals.length)],
      "createdAt": FieldValue.serverTimestamp()
    });

    return;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: 

          StreamProvider<List<Animal>>.value(
            value: animalStream(),
            child: AnimalList(),
          )
        
        ,
      ),
      bottomNavigationBar: Container(
        height: 60.0,
        child: FlatButton(
          color: Color(0xff7238c9),
          child: Text('AÑADIR ANIMAL', style: TextStyle(
            color: Colors.white,
            fontSize: 22.0
          ),),
          onPressed: () async {
            await addAnimal();
          },
        ),
      ),
    );
  }
}

class AnimalList extends StatelessWidget {
  const AnimalList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var animals = Provider.of<List<Animal>>(context);
    return ListView(
      children: animals != null
      ? animals.map(
        (Animal animal) => AnimalItem(animal: animal)
      ).toList()
      : <Widget> []
    );
  }
}

class AnimalItem extends StatelessWidget {

  final Animal animal;

  AnimalItem({Key key, this.animal}) : super(key: key);  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        animal.name,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}