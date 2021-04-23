import 'package:flutter/material.dart';

import 'package:toast/toast.dart';



String exception = 'Something went wrong. Check your connection or restart the app.';
String firebaseException =
      '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.';

Future<void> showException(
  {BuildContext context,String exp}
) async {
  return Toast.show(exp??exception, context, gravity:Toast.BOTTOM );
}