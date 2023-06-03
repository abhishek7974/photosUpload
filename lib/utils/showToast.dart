import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

CustomToast(String txt, Color clr) async {
  return Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: clr,
      textColor: Colors.white,
      fontSize: 16.0);
}

showfinalToast(int statusCode,String data){

  if (statusCode == 200) {
          CustomToast(data, Colors.green);
        } else {
          CustomToast(data, Colors.red);
        }

}
