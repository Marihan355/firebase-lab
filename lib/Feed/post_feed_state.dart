import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class PostFeedState  extends Equatable {
  const PostFeedState();

  @override
  List<Object?> get props => [];
}
class PostFeedLoading extends PostFeedState{}
class PostFeedLoaded extends PostFeedState{
  final List<QueryDocumentSnapshot> posts;
 const PostFeedLoaded(this.posts);
 @override
  List<Object?> get props =>[posts];
}
class PostFeedError extends PostFeedState{
  final String message;
 const PostFeedError(this.message);
  List<Object?> get props =>[message];
}