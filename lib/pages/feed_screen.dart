import 'package:firebase2/pages/Details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase2/Feed/post_feed_cubit.dart';
import 'package:firebase2/Feed/post_feed_state.dart';
//import 'package:firebase2/pages/post_details_screen.dart';
import 'package:firebase2/services/service_firestore.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> PostFeedCubit(ServiceFirestore()),
      child: Scaffold(
        appBar: AppBar(title: Text("Feed"),),
        body: BlocBuilder<PostFeedCubit,PostFeedState>(
            builder: (context,state){
              if(state is PostFeedLoading){
                return Center(child: CircularProgressIndicator(),);
              }else if(state is PostFeedLoaded){
                return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context,index) {
                    final post = state.posts[index];
                    return ListTile(title: Text(post['title'] ?? 'No title'),
                      subtitle: Text(post['content'] ?? ''),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => DetailsScreen(postId: post.id),),);
                      },
                    );
                  },
                );
              }else if(state is PostFeedError){
                return Center(child: Text('Error: ${state.message}'),);
              }
              return SizedBox();
            }),
      ),


    );
  }
}
