import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vista_news/common/widgets/common_app_button.dart';

class CommonPopUpMenu {
  static void showPopUpDialog({
    required BuildContext context,
    String? title,
    String? message,
    Widget? trailingWidgets,
    bool showOk = true,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: title != null
              ? Text(
                  title,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                )
              : null,
          content: message != null
              ? Text(
                  message,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                )
              : null,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            Column(
              children: [
                if (trailingWidgets != null) trailingWidgets,
                const SizedBox(
                  height: 10,
                ),
                if (showOk)
                  CommonAppButton(
                    buttonName: 'ok',
                    buttonAction: () {
                      context.pop();
                    },
                  ),
              ],
            )
          ],
        );
      },
      barrierDismissible: !showOk,
    );
  }
}
