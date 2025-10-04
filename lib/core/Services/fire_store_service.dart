import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kshk/core/Services/database_service.dart';

class FireStoreService extends DatabaseService{
   FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData({required String path, required Map<String, dynamic> data, required String? documentId}) async{
    if (documentId == null) {
       await firestore.collection(path).add(data);
    } else {
      await firestore.collection(path).doc(documentId).set(data);
      
    }
  }

  @override
  Future getData({required String path, String? documentId, Map<String, dynamic>? query}) async{
    if (documentId == null) {
      Query<Map<String, dynamic>> data = firestore.collection(path);
       if (query != null) {
        if (query["orderBy"] != null) {
          var orderBy = query["orderBy"];
          var descending = query["descending"];
          data = data.orderBy(orderBy, descending: descending);
        }

        if (query["limit"] != null) {
          var limit = query["limit"];
          data = data.limit(limit);
        }
      }
      var result = await data.get();
            if (result.docs.isEmpty) {
        log('Warning: No documents found in collection: $path');
        return [];
      }

      return result.docs.map((e) {
        var docData = e.data();

        // Extract the actual product data from nested structure
        if (docData.containsKey('product')) {
          return docData['product'] as Map<String, dynamic>;
        } else if (docData.containsKey('data') && docData['data'] != null) {
          var nestedData = docData['data'] as Map<String, dynamic>;
          if (nestedData.containsKey('product')) {
            return nestedData['product'] as Map<String, dynamic>;
          }
        }

        return docData;
      }).toList();

    } else {
      var data =  await firestore.collection(path).doc(documentId).get();
      return data.data();
    }
  }


    @override
    Future<bool> isUserExist({
      required String path,
      required String documentId,
    }) {
      var data = firestore.collection(path).doc(documentId).get();
      return data.then((value) => value.exists);
    }
  }
