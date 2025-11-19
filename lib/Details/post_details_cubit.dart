import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase2/Details/post_details_state.dart';
import 'package:firebase2/services/service_firestore.dart';

class DetailsCubit extends Cubit<PostDetailsState> {
  final ServiceFirestore serviceFirestore;
  final String postId;
  DetailsCubit(this.serviceFirestore, this.postId):super(PostDetailsLoading()){
    loadComments();
  }
  void loadComments(){
    serviceFirestore.getCommentsStream(postId).listen((snapshot){
      emit(PostDetailsLoaded(snapshot.docs));
    },onError: (e){
      emit(PostDetailsError(e.toString()));
    });

  }
  Future<void>addComment(String commentText) async{
    await serviceFirestore.addComment(postId, commentText);
  }
}