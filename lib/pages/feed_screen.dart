import 'package:firebase2/pages/Details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase2/Feed/post_feed_cubit.dart';
import 'package:firebase2/Feed/post_feed_state.dart';
import 'package:firebase2/services/service_firestore.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostFeedCubit(ServiceFirestore()),
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: const Text(
            "Feed",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          elevation: 2,
        ),
        body: BlocBuilder<PostFeedCubit, PostFeedState>(
          builder: (context, state) {
            if (state is PostFeedLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PostFeedError) {
              return Center(child: Text("Error: ${state.message}"));
            }

            if (state is PostFeedLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsScreen(postId: post.id),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['title'] ?? "No Title",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            post['content'] ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}