import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase2/Details/post_details_cubit.dart';
import 'package:firebase2/Details/post_details_state.dart';
import 'package:firebase2/services/service_firestore.dart';

class DetailsScreen extends StatelessWidget {
  final String postId;
  const DetailsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailsCubit(ServiceFirestore(), postId),
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: const Text('Post Details'),
          backgroundColor: Colors.blue[700],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<DetailsCubit, PostDetailsState>(
                builder: (context, state) {
                  if (state is PostDetailsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PostDetailsLoaded) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        final comment = state.comments[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                          shadowColor: Colors.blueGrey.withOpacity(0.2),
                          child: ListTile(
                            title: Text(
                              comment['text'] ?? '',
                              style: const TextStyle(fontSize: 14),
                            ),
                            subtitle: Text(
                              comment['userId'] ?? '',
                              style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is PostDetailsError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const SizedBox();
                },
              ),
            ),
            _AddCommentWidget(postId: postId),
          ],
        ),
      ),
    );
  }
}

class _AddCommentWidget extends StatefulWidget {
  final String postId;
  const _AddCommentWidget({required this.postId});

  @override
  State<_AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<_AddCommentWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DetailsCubit>();
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Add a Comment',
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[700],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  cubit.addComment(_controller.text.trim());
                  _controller.clear();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}