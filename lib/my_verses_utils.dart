import 'dart:math';
import 'package:flutter/material.dart';

class MyVersesUtils {



static void showSnackBar({required BuildContext context, String? msg}) {

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
     content: Row(
      mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(msg!),// Icon
          const SizedBox(width: 8), // Space between icon and text
          const Icon(
          Icons.no_encryption_outlined,
          color: Color.fromARGB(255, 233, 219, 179),
        ), // Text
        ],
      )));

}

// static void showToast({String? msg}) {
//     Fluttertoast.showToast(
//       msg: msg!,
//       toastLength: Toast.LENGTH_SHORT, // Duration for the toast
//       gravity: ToastGravity.BOTTOM, // Location where the toast should appear
//       backgroundColor: Colors.black.withOpacity(0.7), // Background color
//       textColor: Colors.white, // Text color
//       fontSize: 16.0, // Font size
//     );
//   }

  static int getRandomNo({int? range}) {
    return Random().nextInt(range!); // Generate random number between 0 and 99
  }
}
