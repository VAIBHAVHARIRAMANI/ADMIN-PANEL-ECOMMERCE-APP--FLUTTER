//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataProvider {
  final db = Firestore.instance;

  Stream<QuerySnapshot> banners(String filter) {
    if (filter != null && filter.isNotEmpty) {
      return db
          .collection('Banners')
          .where('screen', isEqualTo: filter)
          .snapshots();
    } else {
      return db.collection('Banners').snapshots();
    }
  }

  Future<DocumentSnapshot> bannerDelete(String doc) {
    return db.collection('Banners').document(doc).delete();
  }

  Stream<QuerySnapshot> regions(int filter) {
    if (filter != null) {
      return db
          .collection('Regions')
          .where('pincode', isEqualTo: filter)
          .snapshots();
    } else {
      return db.collection('Regions').snapshots();
    }
  }

  Stream<QuerySnapshot> employee() {
    return db.collection('Employee').snapshots();
  }

  Stream<QuerySnapshot> orders({String search, String filter}) {
    return db
        .collection('Orders')
        .orderBy('booking', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> completeOrders() {
    return db
        .collection('Orders')
        .where('status', isEqualTo: 'Order Completed')
        .snapshots();
  }

  Stream<QuerySnapshot> orderItems(String id) {
    return db.collection('Items').where('orderID', isEqualTo: id).snapshots();
  }

  Stream<QuerySnapshot> category() {
    return db.collection('Category').snapshots();
  }

  Stream<QuerySnapshot> subTags() {
    return db.collection('Tags').snapshots();
  }

  Stream<DocumentSnapshot> subcategory(String doc) {
    return db.collection('Category').document(doc).snapshots();
  }

  Stream<QuerySnapshot> products({String search, String filter}) {
    if (filter != null && filter.isNotEmpty) {
      return db
          .collection('Products')
          .where('category', arrayContains: filter)
          .snapshots();
    }
    if (search != null && search.isNotEmpty) {
      return db
          .collection('Products')
          .where('search', arrayContains: search)
          .snapshots();
    }
    if (search != null &&
        search.isNotEmpty &&
        filter != null &&
        filter.isNotEmpty) {
      return db
          .collection('Products')
          .where('search', arrayContains: search)
          .where('category', arrayContains: filter)
          .snapshots();
    }
    return db.collection('Products').snapshots();
  }
}

DataProvider dataProvider = new DataProvider();

class UserData {
  String profile;
  String name;
  String phone;
  String region;
  String pincode;
  String uid;
  String token;
  UserData(this.profile, this.name, this.phone, this.region, this.pincode,
      this.uid, this.token);
}

class EmployeeData {
  String profile;
  String name;
  String role;
  String number;
  String mail;
  String vechileNo;
  String licence;

  EmployeeData(this.profile, this.name, this.role, this.number, this.mail,
      this.vechileNo, this.licence);
}
