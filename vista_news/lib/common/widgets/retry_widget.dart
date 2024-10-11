// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vista_news/common/widgets/common_app_button.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({super.key, required this.message, this.retryAction});
  final String message;
  final Function()? retryAction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonAppButton(
              buttonName: "Retry",
              buttonAction: retryAction,
            ),
            const SizedBox(height: 16.0),
            Text('Error: $message')
          ],
        ),
      ),
    );
  }
}
