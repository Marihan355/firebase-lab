import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceFirestore {
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Stream<QuerySnapshot>getPostsStream(){
    return _firestore.collection('posts').orderBy('timestamp',descending: true).snapshots();
  }
  Stream<QuerySnapshot>getCommentsStream(String postId){
    return _firestore.collection('posts').doc(postId).collection('comments')
        .orderBy('timestamp',descending: true).snapshots();
  }
  Future<void>addComment( String postId,String commentText)async{
    await _firestore.collection('posts').doc(postId).collection('comments').add({

      'text':commentText,
      'timestamp':FieldValue.serverTimestamp(),
      'userId' :'guest',
    });
  }
}