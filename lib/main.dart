import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase2/Feed/post_feed_cubit.dart';
import 'package:firebase2/pages/feed_screen.dart';
import 'package:firebase2/services/service_firestore.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostFeedCubit(ServiceFirestore()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social media app',
        theme: ThemeData(
            primarySwatch: Colors.green
        ),
        home: FeedScreen(),
      ),
    );
  }}
