import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gridview_test/EventListMainPage.dart';
import 'package:gridview_test/EventList.dart';
import 'EventDescriptionPage.dart';
import 'EventFilterBar.dart';
import 'CategoriesBar.dart';
import 'SearchBar.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

//DocumentSnapshot documentSnapshot;
//FirebaseStorage storage = new FirebaseStorage(storageBucket: 'gs://itpappbhagya.appspot.com/');
//StorageReference imageLink = storage.ref().child('EventApp').child(documentSnapshot['image']);


import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new EventApp());


