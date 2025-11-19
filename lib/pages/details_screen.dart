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
      create: (_)=>DetailsCubit(ServiceFirestore(), postId),
      child: Scaffold(
        appBar: AppBar(title: Text('Post Details'),),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<DetailsCubit,PostDetailsState>
                (builder:(context,state){
                if(state is PostDetailsLoading){
                  return Center(child: CircularProgressIndicator(),);
                }else if(state is PostDetailsLoaded){
                  return ListView.builder(
                    itemCount: state.comments.length,
                    itemBuilder: (context,index){
                      final comment= state.comments[index];
                      return ListTile(
                        title: Text(comment['text']??''),
                        subtitle: Text(comment['userId']?? ''),
                      );
                    },
                  );
                }else if(state is PostDetailsError){
                  return Center(child: Text('Error: ${state.message}'),);
                }
                return SizedBox();
              },
              ),
            ),
            _AddCommentWidget(postId:postId),
          ],
        ),
      ),

    );
  }
}
class _AddCommentWidget extends StatefulWidget{
  final String postId;
  const _AddCommentWidget({required this.postId});

  @override
  State<_AddCommentWidget> createState()=> _AddCommentWidgetState();

}
class _AddCommentWidgetState extends State<_AddCommentWidget> {

  final TextEditingController _controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit =context.read<DetailsCubit>();
    return Padding(padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                hintText: 'Add a Comment',
                border: OutlineInputBorder()
            ),
          ),
          ),
          IconButton( icon: Icon(Icons.send),onPressed: (){
            if(_controller.text.trim().isNotEmpty){
              cubit.addComment(_controller.text.trim());
              _controller.clear();
            }
          },)
        ],
      ),
    );
  }
}