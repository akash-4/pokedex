import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PokemonDB {


  static Future<void> updateFavourites(String id, String uid) async {
    final DocumentSnapshot doc =
        await Firestore.instance.collection('users').document(uid).get();
    List f = doc.data['favourites'];
    f.contains(id) ? f.remove(id) : f.add(id);
    await Firestore.instance.collection('users').document(uid).updateData({
      'favourites': f,
    });
  }


  static Future<void> updateName(String uID, String name) async {
    await Firestore.instance.collection('users').document(uID).updateData({
      'displayName': name,
    });
  }

  static Future<void> startUpload(File imageToUpload, String uid) async {
    StorageUploadTask _uploadTask;

    StorageReference _storageReference =
        FirebaseStorage.instance.ref().child(uid);
    _uploadTask = _storageReference.putFile(imageToUpload);

    await _uploadTask.onComplete.whenComplete(() {
      print('File Uploaded');
      _storageReference.getDownloadURL().then((fileurl) {
        Firestore.instance.collection('users').document(uid).updateData({
          'photoUrl': fileurl,
        });

        print(fileurl);
      });
    });
  }

  static Future<void> updateProfileVisibility(bool visible, String uid) {
    Firestore.instance.collection('users').document(uid).updateData({
      'visible': visible,
    });
  }
}
