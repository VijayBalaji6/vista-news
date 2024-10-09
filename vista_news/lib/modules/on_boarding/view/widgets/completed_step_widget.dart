import 'package:flutter/material.dart';
import 'package:vista_news/models/user.dart';

class CompleteWidget extends StatelessWidget {
  final User user;

  const CompleteWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome ${user.userName}'),
          Text('Favorite Categories: ${user.favNewsCategory.join(", ")}'),
          if (user.city != null) Text('City: ${user.city}'),
        ],
      ),
    );
  }
}