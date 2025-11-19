import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase2/Feed/post_feed_state.dart';
import 'package:firebase2/services/service_firestore.dart';

class PostFeedCubit extends Cubit<PostFeedState> {
final   ServiceFirestore serviceFirestore;

  PostFeedCubit(this.serviceFirestore) :super(PostFeedLoading()){
    loadPosts();
  }
  void loadPosts(){
    serviceFirestore.getPostsStream().listen((snapshot){
      emit(PostFeedLoaded(snapshot.docs));
    },onError: (e){
    emit(PostFeedError(e.toString()));
    });

  }
}