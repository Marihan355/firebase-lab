import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class PostDetailsState extends Equatable {
  const PostDetailsState();
  @override
  List<Object?> get props => [];
}
class PostDetailsLoading extends PostDetailsState{}
class PostDetailsLoaded extends PostDetailsState{
  final List<QueryDocumentSnapshot> comments;
 const PostDetailsLoaded(this.comments);
 @override
  List<Object?> get props => [comments];
}
class PostDetailsError extends PostDetailsState{
  final String message;
const  PostDetailsError(this.message);
@override
List<Object?> get props => [message];
}
